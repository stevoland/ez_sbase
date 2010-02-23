<?php

$eZTemplateOperatorArray = array();
$eZTemplateOperatorArray[] = array( 'script' => 'extension/_sbase/autoloads/spdf2pngoperator.php',
                                    'class' => 'sPdf2pngOperator',
                                    'operator_names' => array( 'pdf2png_tag', 'pdf2png_object', 'pdf2png_url') );
$eZTemplateOperatorArray[] = array( 'script' => 'extension/_sbase/autoloads/tidyoutputoperator.php',
                                    'class' => 'sTidyOutputOperator',
                                    'operator_names' => array( 'tidy_output') );
?>
