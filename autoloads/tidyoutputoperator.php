<?php

class sTidyOutputOperator
{

    private $Operators;


    /*!
     Constructor
     */
    function __construct()
    {
        /* Opérateurs */
        $this->Operators = array(
            'tidy_output',
        );
    }



    function &operatorList()
    {
        return $this->Operators;
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
         return array(
            'tidy_output' => array( ),
        );
    }



    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace,
                      &$currentNamespace, &$operatorValue, &$namedParameters )
    {
        switch ( $operatorName )
        {
            case 'tidy_output':
                eZDebugSetting::writeNotice( "extension-eztidy", "Use 'tidy_output' template operator", "eZTidy::tidyCleaner()" );
                $tidy = eZTidy::instance('OutputFilter');
                $operatorValue = $tidy->tidyCleaner( $operatorValue );
                break;
        }
    }

} // EOC

?>