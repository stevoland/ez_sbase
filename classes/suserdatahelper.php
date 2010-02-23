<?php

class sUserDataHelper
{

    private function __construct()
    {
    }

	static public function setCookie()
	{
		$ini   = eZINI::instance( 'sbase.ini' );
		$hasUserData = false;
		$displayedData = $ini->variable( 'UserData', 'DisplayedData' );

		$prefs = eZPreferences::values();
		foreach ( $prefs as $key => $val )
		{			
			if ( $key != '' )
			{
				if ( in_array('preferences', $displayedData) || in_array($key, $displayedData)  )
				{
					if ( $val != '' )
					{
						$hasUserData = true;
						break;
					}
				}
			}
		}
		
		
		if ( $hasUserData === false && in_array('basket', $displayedData) )
		{
			$http = eZHTTPTool::instance();
            $sessionID = $http->sessionID();
			$basket = eZBasket::fetch($sessionID);
			if ( $basket )
			{
				if ( !$basket->isEmpty() )
				{
					$hasUserData = true;
				}
			}
		}
		
		if ( $hasUserData === false && in_array('wishlist', $displayedData) )
		{
			$user = eZUser::currentUser();
			$userID = $user->attribute( 'contentobject_id' );
			$WishListArray = eZPersistentObject::fetchObjectList( eZWishList::definition(),
															  null, array( "user_id" => $userID
																		   ),
															  null, null,
															  true );
			if ( count( $WishListArray ) > 0 )
			{
				if ( $WishListArray[0]->itemCount() > 0 )
				{
					$hasUserData = true;
				}
			}
		}
		
		
		$value  = ( $hasUserData !== false ) ? "true" : false;
		
		$wwwDir = eZSys::wwwDir();
	    $cookiePath = $wwwDir != '' ? $wwwDir : '/';
        setcookie( $ini->variable( 'UserData', 'CookieName' ),
                   $value,
                   (int)$ini->variable( 'UserData', 'CookieDuration' ),
                   $cookiePath );

	}
}

?>
