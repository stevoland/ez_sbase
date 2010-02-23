<?php

class sPdf2pngOperator
{
    function __construct()
    {
		$this->Operators = array( 'pdf2png_tag', 'pdf2png_object', 'pdf2png_url');
        $this->Debug = false;
    }

    function operatorList()
    {
        return $this->Operators;
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        $ret = array( 'pdf2png_tag' => array('pdf2png_params' => array( 'type'     => 'array',
                                                                    'required' => true
                                                                         )));
		$ret['pdf2png_object'] = $ret['pdf2png_url'] = $ret['pdf2png_tag'];
		return $ret;
    }

    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {
		$params = $namedParameters['pdf2png_params'];
		
		$url                   = isset($params['url'])? trim($params['url']) : '';
		$density               = isset($params['density'])? trim($params['density']) : '';
		$keys                  = isset($params['keys'])? $params['keys'] : array();
		$subtree_expiry        = isset($params['subtree_expiry'])?$params['subtree_expiry'] : '';
		$expiry                = isset($params['expiry'])? $params['expiry'] : null ;
		$ignore_content_expiry = isset($params['ignore_content_expiry'])?$params['ignore_content_expiry'] : false;
		
		$pdf2png = new sPdf2png();
		
        switch ( $operatorName )
        {
			
            case 'pdf2png_tag':
            {
                $ret = $pdf2png->getTag( $url, $density, $keys, $subtree_expiry, $expiry, $ignore_content_expiry );
				
            } break;
			case 'pdf2png_object':
            {
                $ret = $pdf2png->getObject( $url, $density, $keys, $subtree_expiry, $expiry, $ignore_content_expiry );
				
            } break;
			case 'pdf2png_url':
            {
                $ret = $pdf2png->getUrl( $url, $density, $keys, $subtree_expiry, $expiry, $ignore_content_expiry );
				
            } break;
        }

        $operatorValue = $ret;

    }

    /// \privatesection

    /// \return The class variable 'Operators' which contains an array of available operators names.
    var $Operators;

    /// \privatesection
    /// \return The class variable 'Debug' to false.
    var $Debug;
    
}

?>
