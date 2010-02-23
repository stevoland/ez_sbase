<?php

$Module = $Params['Module'];
$http = eZHTTPTool::instance();
$parameters = array();

$parameterUrl = $http->postVariable( 'DestinationURL' );
$parameters['tag'] = $http->postVariable( '(tag)' );

foreach( $parameters as $p => $id ) {
    $pname = $p;
    $pvalue = $id;
    if( $parameters["$pname"] == '' ) {
        $parameters["$pname"] = 'null';
    }
}

posttoview( $parameterUrl, $parameters );

function posttoview( $parameterUrl, $parameters = array(), $s = '' ) {
  foreach( $parameters as $p => $id ) {
  	$pname = $p;
  	$pvalue = $id;
        if( $id != 'null' && $pvalue != '' && $pvalue != ' ' && $pvalue != '  ' )
  	$s .= '/('.$pname.')/'.$pvalue;
  }
  $location = '/'. $parameterUrl .$s;
  
  echo "loc=" . $location;
  // die( print_r( $location ) );
  header( "Location: " . $location );
  //die();
}

?>