<?php

$Module = array( 'name' => 'TagFilter', 'variable_params' => true );

$ViewList = array();
$ViewList['action'] = array(
                          'script' => 'action.php',
                          "default_navigation_part" => 'ezcontentnavigationpart',
                          "unordered_params" => array( 'tag' => 'Tag' ) 
);

?>
