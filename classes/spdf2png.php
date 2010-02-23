<?php

class sPdf2png
{

    private $paradoxPDFExec ;
    private $paradoxPDFExtensionDir;
    private $debugEnabled;
    private $javaExec;
    private $tmpDir;
    private $fileSep;
    private $cacheTTL;
    private $cacheEnabled;
    private $size;


    function sPdf2png()
    {
        $ini = eZINI::instance('spdf2png.ini');
        $this->cacheEnabled = ($ini->variable('CacheSettings', 'Cache') == 'enabled');
        $this->debugEnabled = ($ini->variable('DebugSettings', 'DebugPDF') == 'enabled');
        $this->javaExec =  $ini->variable('BinarySettings', 'JavaExecutable');
        $this->cacheTTL =  $ini->variable('CacheSettings','TTL');
        $fileSep = eZSys::fileSeparator();
        $this->fileSep = $fileSep;
        $this->extensionDir = eZSys::rootDir().$fileSep.eZExtension::baseDirectory().$fileSep.'pdf2png';
        //$this->paradoxPDFExec = $this->pdf2pngExtensionDir.$fileSep.'bin'.$fileSep.'paradoxpdf.jar';
        $this->tmpDir = eZSys::rootDir().$fileSep.'var'.$fileSep.'cache'.$fileSep.'public'.$fileSep.'pdf2png';
    }
	 
	 
	public function getTag($url = '', $density, $keys, $subtree_expiry, $expiry, $ignore_content_expiry = false, $atts=array())
	{
		$obj = $this->getObject($url, $density, $keys, $subtree_expiry, $expiry, $ignore_content_expiry);
		if ( isset($obj) && isset($obj['url']) )
		{
			$atts = array();
			$atts_str = '';
			foreach ( $atts as $key => $val )
			{
				$atts_str .= $key.'="'.$val.'" ';
			}
			return '<img src="'.$obj['url'].'" width="'.$obj['width'].'" height="'.$obj['height'].'" '.$atts_str.'/>';
		}
		return false;
	}
	 
	 
	public function getUrl($url = '', $density, $keys, $subtree_expiry, $expiry, $ignore_content_expiry = false)
	{
		$obj = $this->getObject($url, $density, $keys, $subtree_expiry, $expiry, $ignore_content_expiry);
		if ( isset($obj) && isset($obj['url']) )
			return $obj['url'];
		
		return false;
	}
	
    /**
     * Performs PDF content generation and caching
     *
     * @param $url                 	 String    URL
     * @param $denisty               Integer   
     * @param $keys                  Mixed     Keys for Cache key(s) - either as a string or an array of strings
     * @param $subtree_expiry        Mixed     The parameter $subtreeExpiryParameter is expiry value is usually taken
     *                                         from the template operator and can be one of:
     *                                           - A numerical value which represents the node ID (the fastest approach)
     *                                           - A string containing 'content/view/full/xxx' where xx is the node ID number,
     *                                             the number will be extracted.
     *                                           - A string containing a nice url which will be decoded into a node ID using
     *                                             the database (slowest approach).
     * @param $expiry                Integer   The number of seconds that the pdf cache should be allowed to live.A value of
     *                                         zero will produce a cache block that will never expire
     * @param $ignore_content_expiry Boolean   Disables cache expiry when new content is published.
     * @return void
     */

    public function getObject($url = '', $density, $keys, $subtree_expiry, $expiry, $ignore_content_expiry = false)
    {
        $pngUrl = '';
		$obj = false;
        $mtime = eZDateTime::currentTimeStamp();
        $httpExpiry = $this->cacheTTL;
		
		if ( strpos("://", $url) === false )
		{
			$url = eZSys::serverURL() . $url;
		}
		//eZDebug::writeError($url, 'sPdf2png::exportPng');
		
        if($this->cacheEnabled)
        {
            $use_global_expiry = !$ignore_content_expiry;

            //$keys = self::getCacheKeysArray($keys);

            $expiry = (is_numeric($expiry) ) ? $expiry : $this->cacheTTL;

            list($handler, $pngUrl) = eZTemplateCacheBlock::retrieve($keys, $subtree_expiry, $expiry, $use_global_expiry);

            if ($pngUrl instanceof eZClusterFileFailure || !file_get_contents($pngUrl) )
            {				
			
				eZDebug::writeError("cache invalid", 'sPdf2png::exportPng');
				$obj = $this->generatePng($url, $density, $keys);
				
                $handler->storeCache(array(  'scope'      => 'template-block',
                                             'binarydata' => $obj['url']));
            }
			//eZDebug::writeError("cache", 'sPdf2png::exportPng');
        }
        else
        {			
			$obj = $this->generatePng($url, $density, $keys);
        }
		
		if ( !$obj )
		{
			$obj = $this->getPngData($pngUrl);
		}
		
		$obj['url'] = self::getWwwDir() . $obj['url'];
		
		return $obj;
		
    }
	
	private function getPngData($pngUrl)
    {
		$obj = array('url' => $pngUrl);
		//eZDebug::writeError("pngUrl2=".$pngUrl, 'sPdf2png::exportPng');
		// get h + w
		/*try {
			$image = new ezcImageAnalyzer($pngUrl);
			$data = $image->analyzeImage();
			$obj['width'] = $data->width;
			$obj['height'] = $data->height;
		}
		catch ( Exception $e )
		{
			//var_dump($e );
			return false;
		}*/
		
		return array('url' => $pngUrl,
					 'width' => '100',
					 'height' => '100' );
	}
	
	public function generatePng($url, $density, $keys)
    {
		$data = $this->getPDF($url);
		
		// check if error occurred during pdf generation
		if($data === false)
		{
			return false;
		}
		
		// save pdf, generate png, return url
		$cacheName = hash("md5", $url . '-' . $density . '-' . implode($keys, '-'));
		
		$cacheDir = self::getCacheDir();
		eZFile::create( $cacheName . '.pdf', $cacheDir, $data );
		
		$pdfUrl = $cacheDir . $cacheName . '.pdf';
		$pngUrl = $cacheDir . $cacheName . '.png';
		
		
		
		$command = "gs -dNOPAUSE -dBATCH -sDEVICE=pngalpha -r$density -dEPSCrop -sOutputFile=" . eZSys::rootDir()."/".$pngUrl ." " . eZSys::rootDir()."/". $pdfUrl;
		
		exec($command, $output, $returnCode);
		
		//eZDebug::writeError($command, 'sPdf2png::exportPng');
		//eZDebug::writeError("pngUrl=".$pngUrl, 'sPdf2png::exportPng');
		
		//eZFileHandler::unlink($pdfUrl);
		
		return $this->getPngData($pngUrl);
		/*return array('url' => ,
					 'width' => '100',
					 'height' => '100' );*/
    }

    /**
     * Converts xhtml to pdf
     *
     * @param $url
     * @return Binary pdf content or false if error
     */
    public function getPDF($url)
    {
        return file_get_contents($url);
    }


    /**
     *  Generate cache  key array based on current user roles, requested url, layout
     *
     * @param $userKeys Array
     * @return array
     */

    public function getCacheKeysArray( $userKeys )
    {
        if(!is_array($userKeys))
        {
            $userKeys = array($userKeys);
        }

        $user = eZUser::currentUser();
        $limitedAssignmentValueList = $user->limitValueList();
        $roleList = $user->roleIDList();
        $discountList = eZUserDiscountRule::fetchIDListByUserID( $user->attribute( 'contentobject_id' ) );
        $currentSiteAccess = ( isset( $GLOBALS['eZCurrentAccess']['name'] ) ) ? $GLOBALS['eZCurrentAccess']['name']:false ;
        $res = eZTemplateDesignResource::instance();
        $keys = $res->keys();
        $layout= ( isset( $keys['layout'] ) ) ? $keys['layout'] : false;
        $uri = eZURI::instance( eZSys::requestURI() );
        $actualRequestedURI = $uri->uriString();
        $userParameters = $uri->userParameters();

        $cacheKeysArray = array('spdf2png',
			$currentSiteAccess,
			$layout,
			$actualRequestedURI,
			implode( '.', $userParameters ),
			implode( '.', $roleList ),
			implode( '.', $limitedAssignmentValueList),
			implode( '.', $discountList ),
			implode( '.', $userKeys )
		);

        return $cacheKeysArray;

    }

    /**
     *  Log execution output
     *
     * @param $command String executed command
     * @param $output Array command execution output
     * @return Void
     */

    private function writeCommandLog($command, $output, $status=false)
    {

        $logMessage = implode("\n", $output);

        if(!$status)
        {
            eZDebug::writeError("An error occured during pdf generation please check var/log/spdf2png.log", 'sPdf2png::exportPng');
            eZLog::write("Failed executing command : $command , \n Output : $logMessage",'spdf2png.log');
        }
        elseif($this->debugEnabled)
        {
            eZLog::write("sPdf2Png : conversion successful: $command , \n Output : $logMessage",'spdf2png.log');
        }

    }
	
	// static :: gets the cache dir
    static function getCacheDir()
    {
        static $cacheDir = null;
    	if ( $cacheDir === null )
        {
            $sys = eZSys::instance();
            $cacheDir = $sys->cacheDirectory() . '/public/pdf2png/';
        }
        return $cacheDir;
    }
	
	// static :: gets the www dir
    static function getWwwDir()
    {
        static $wwwDir = null;
    	if ( $wwwDir === null )
        {
            $sys = eZSys::instance();
            $wwwDir = $sys->wwwDir() . '/';
        }
        return $wwwDir;
    }
}
?>