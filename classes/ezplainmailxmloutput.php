<?php

class eZPlainMailXMLOutput extends eZXHTMLXMLOutput
{

    function eZPlainMailXMLOutput( &$xmlData, $aliasedType, $contentObjectAttribute = null )
    {
        $this->eZXHTMLXMLOutput( $xmlData, $aliasedType, $contentObjectAttribute );
    }

	// Path to tags' templates
    public $TemplatesPath = 'design:content/datatype/view/plainmail/ezxmltags/';
}

?>
