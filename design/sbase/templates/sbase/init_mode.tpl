{set $mode_conditions	= array(
	 	hash(
	 		module, 'content',
	 		functions, 'trash,draft',
	 		mode, 'admin',
	 		menu, 'design:parts/my/menu.tpl'
	 	),
	 	hash(
	 		module, 'collaboration',
	 		mode, 'admin',
	 		menu, 'design:parts/my/menu.tpl'
	 	),
	 	hash(
	 		mode, 'admin',
	 		module, 'notification',
	 		menu, 'design:parts/my/menu.tpl'
	 	),
	 	hash(
	 		module, 'shop',
	 		mode, 'admin',
	 		menu, 'design:parts/shop/menu.tpl'
	 	),
	 	hash(
	 		module, 'content',
	 		functions, 'urltranslator,urlwildcards,translations',
	 		mode, 'admin',
	 		menu, 'design:parts/setup/menu.tpl'
	 	),
	 	hash(
	 		module, 'search',
	 		mode, 'admin',
	 		menu, 'design:parts/setup/menu.tpl'
	 	),
	 	hash(
	 		module, 'url',
	 		mode, 'admin',
	 		menu, 'design:parts/setup/menu.tpl'
	 	),
	 	hash(
	 		module, 'infocollector',
	 		mode, 'admin',
	 		menu, 'design:parts/setup/menu.tpl'
	 	),
	 	hash(
	 		module, 'all2einfoexport',
	 		mode, 'admin',
	 		menu, 'design:parts/setup/menu.tpl'
	 	),
	 	hash(
	 		module, 'survey',
	 		mode, 'admin',
	 		menu, 'design:parts/setup/menu.tpl'
	 	),
	 	hash(
	 		module, 'ezfind',
	 		mode, 'admin',
	 		menu, 'design:parts/setup/menu.tpl'
	 	),
	 	hash(
	 		module, 'rss',
	 		mode, 'admin',
	 		menu, 'design:parts/setup/menu.tpl'
	 	),
	 	hash(
	 		module, 'content',
	 		functions, 'view,versionview,search,advancedsearch,keyword,tipafriend',
	 		mode, 'site',
	 		menu, 'design:page_leftmenu.tpl'
	 	),
	 	hash(
	 		module, 'content',
	 		functions, 'view',
	 		content_info, hash('viewmode', 'detail'),
	 		mode, 'admin',
	 		menu, false()
	 	),
	 	hash(
	 		module, 'error',
	 		functions, 'view',
	 		mode, 'site',
	 		menu, 'design:page_leftmenu.tpl'
	 	),
	 	hash(
	 		module, 'user',
	 		functions, 'login,logout,register,activate,forgotpassword,password,success,activate,edit',
	 		mode, 'site',
	 		menu, 'design:page_leftmenu.tpl'
	 	),
	 	hash(
	 		module, 'vlogin',
	 		functions, 'login,logout,edit',
	 		mode, 'site',
	 		menu, 'design:page_leftmenu.tpl'
	 	),
	 	hash(
	 		module, 'shop',
	 		functions, 'basket,confirmorder,customerorderview,userregister,wishlist',
	 		mode, 'site',
	 		menu, 'design:page_leftmenu.tpl'
	 	),
	 	hash(
	 		module, 'newsletter',
	 		functions, 'user_settings,register_subscription,subscription_activate,read',
	 		mode, 'site',
	 		menu, 'design:page_leftmenu.tpl'
	 	)
	 )
}
{if is_set($pagedata.persistent_variable.mode)}
	{set $mode=$pagedata.persistent_variable.mode}
	{set $menu=cond( is_set($pagedata.persistent_variable.menu), $pagedata.persistent_variable.menu, false() ) }
{elseif $current_user.is_logged_in }
	{if fetch( 'user', 'has_access_to', hash( 'module', 'websitetoolbar', 'function', 'use' ) ) }
		{set $mode='admin'
			 $menu=false() }
		{if and( is_set($module_result.left_menu), $module_result.left_menu )}
			{set $menu=$module_result.left_menu}
		{/if}
		{foreach $mode_conditions as $view}
			{if $module_params.module_name|eq($view.module)}
				{if is_set($view.functions) }
					{if concat(',',$view.functions,',')|contains( concat(',',$module_params.function_name,',') ) }
						{if is_set($view.content_info)}
							{foreach $view.content_info as $key => $vals}
								{if concat(',',$vals,',')|contains( concat(',',$module_result.content_info.$key,',') ) }
									{set $mode=$view.mode }
									{if is_set($view.menu) }
										{set $menu=$view.menu }
									{/if}
								{/if}
							{/foreach}
						{else}
							{set $mode=$view.mode }
							{if is_set($view.menu) }
								{set $menu=$view.menu }
							{/if}
						{/if}
					{/if}
				{else}
					{set $mode=$view.mode }
					{if is_set($view.menu) }
						{set $menu=$view.menu }
					{/if}
				{/if}
			{/if}
		{/foreach}
	{/if}
{/if}

{if or( is_unset( $pagedata.persistent_variable.record_access ), $pagedata.persistent_variable.record_access|eq(true) ) }
	{session_set('sBaseLastAccessesURI', $module_result.uri|ezurl(no))}
{/if}

{set $head_scripts        = cond( is_set($pagedata.persistent_variable.head_scripts), $pagedata.persistent_variable.head_scripts, array() )
     $head_inline_scripts = cond( is_set($pagedata.persistent_variable.head_inline_scripts), $pagedata.persistent_variable.head_inline_scripts, array() )
     $foot_scripts        = cond( is_set($pagedata.persistent_variable.foot_scripts), $pagedata.persistent_variable.foot_scripts, array() )
     $foot_inline_scripts = cond( is_set($pagedata.persistent_variable.foot_inline_scripts), $pagedata.persistent_variable.foot_inline_scripts, array() )
     $head_styles         = cond( is_set($pagedata.persistent_variable.head_styles), $pagedata.persistent_variable.head_styles, array() )
     $head_inline_styles  = cond( is_set($pagedata.persistent_variable.head_inline_styles), $pagedata.persistent_variable.head_inline_styles, array() )
     scope				  = global
}

{if $module_params.function_name|eq('versionview')}
	{set $extra_cache_key = $extra_cache_key|append(rand(0, 99999999)) }
{/if}