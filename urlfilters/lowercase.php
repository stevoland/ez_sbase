<?php
     class sURLAliasFilterLowerCase extends eZURLAliasFilter
     {
     	function sURLAliasFilterLowerCase()
	    {
	    }
	    
		function process( $text, &$languageObject, &$caller )
		{
			return strtolower( $text );
		}
     }
?>