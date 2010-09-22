<?php

class sSessionSetOperator
{

    private $Operators;
    private $http;


    /*!
     Constructor
     */
    function __construct()
    {
        /* Opérateurs */
        $this->Operators = array(
            'session_set',
        );
        $this->http = eZHTTPTool::instance();
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
            'session_set' => array( 'variable' => array('type'     => 'string',
                                                        'required' => true,
                                                        'default'  => null),
                                    'value'  => array('type'     => 'mixed',
                                                      'required' => true,
                                                      'default'  => null),
                             ),
        );
    }



    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace,
                      &$currentNamespace, &$operatorValue, &$namedParameters )
    {
        switch ( $operatorName )
        {
            case 'session_set':
                $this->http->setSessionVariable($namedParameters['variable'], $namedParameters['value']);
            break;
        }
    }

} // EOC

?>