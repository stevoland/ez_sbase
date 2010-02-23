{def $output=''}{set-block variable=$output}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$site.http_equiv.Content-language|wash}" lang="{$site.http_equiv.Content-language|wash}">
<head>
{def $basket_is_empty     = cond( $current_user.is_logged_in, fetch( shop, basket ).is_empty, 1 )
     $user_hash           = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )
     
	   $pagedata            = ezpagedata()
     $module_params	   	  = module_params()
    $mode				  = 'site'
    $menu				  = 'design:page_leftmenu.tpl'
	 
	 $mode_conditions	  = array()
	 $head_scripts        = array()
     $head_inline_scripts = array()
     $foot_scripts        = array()
     $foot_inline_scripts = array()
     $head_styles         = array()
     $head_inline_styles  = array()
     $loaded_scripts      = array()
     $loaded_styles       = array()
     
     $pagestyle			  = '' }
     
{if is_set( $extra_cache_key )|not}
  {def $extra_cache_key = ''}
{/if}
	 
{include uri='design:sbase/init_mode.tpl'}



{cache-block keys=array( $module_result.uri, $basket_is_empty, $current_user.contentobject_id, $extra_cache_key )}
{def $locales          = fetch( 'content', 'translation_list' )
     $pagedesign       = $pagedata.template_look
     $current_node_id  = $pagedata.node_id
}

{include uri='design:sbase/init_pagestyle.tpl'}

{include uri='design:page_head.tpl'}
{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}

</head>

<body class="ua-images ua-no-js">


{* for the yui3 history module in ie < 8 *}
<!--[if lte IE 8]><iframe id="yui-history-iframe" src={'extension/_sbase/design/blank.html'|ezroot}></iframe><![endif]-->
<p class="hide"><input id="yui-history-field" type="hidden" /></p>
<!-- Complete page area: START -->

<!-- Change between "sidemenu"/"nosidemenu" and "extrainfo"/"noextrainfo" to switch display of side columns on or off  -->
<div id="page" class="{$pagestyle}">

  {if and( is_set( $pagedata.persistent_variable.extra_template_list ), 
             $pagedata.persistent_variable.extra_template_list|count() )}
    {foreach $pagedata.persistent_variable.extra_template_list as $extra_template}
      {include uri=concat('design:extra/', $extra_template)}
    {/foreach}
  {/if}

  <!-- Header area: START -->
  {include uri='design:page_header.tpl'}
  <!-- Header area: END -->
  
  {cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key )}

  <!-- Top menu area: START -->
  {if $pagedata.top_menu}
    {include uri='design:page_topmenu.tpl'}
  {/if}
  <!-- Top menu area: END -->

  <!-- Path area: START -->
  {if $pagedata.show_path}
    {include uri='design:page_toppath.tpl'}
  {/if}
  <!-- Path area: END -->
  
  <!-- Toolbar area: START -->
  {if is_set($pagedata.persistent_variable.preview_node) }
	{include uri='design:parts/website_toolbar_versionview.tpl'}
  {elseif and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
    {include uri='design:page_toolbar.tpl'}
  {elseif and($current_user.is_logged_in, $module_params.function_name|ne('edit') ) }
  	{if fetch( 'user', 'has_access_to', hash( 'module', 'websitetoolbar', 'function', 'use' ) ) }
      {include uri='design:parts/website_toolbar_extra.tpl' uri_string=$uri_string}
    {/if}
  {/if}
  <!-- Toolbar area: END -->

  <!-- Columns area: START -->
  <div id="bd">

    <!-- Side menu area: START -->
    {if or($pagedata.left_menu, $mode|eq('admin')) }
      {if $menu}
      	{if $mode|eq('admin')}
      		<div class="leftCol adminmenu">
       		<div id="sidemenu">
       			<div class="border-box">
  <div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
  <div class="border-ml"><div class="border-mr"><div class="border-mc">
      	{/if}
      		{include uri=$menu}
      	{if $mode|eq('admin')}
      		</div></div></div>
  <div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
  </div>
    			</div>
    		</div>
      	{/if}
      {/if}
    {/if}
    <!-- Side menu area: END -->
    
    <!-- Extra area: START -->
    {if $pagedata.extra_menu}
        {include uri='design:page_extramenu.tpl'}
    {/if}
    <!-- Extra area: END -->

  {/cache-block}
{/cache-block}
    <!-- Main area: START -->
    {include uri='design:page_mainarea.tpl'}
    <!-- Main area: END -->
{cache-block keys=array( $module_result.uri, $user_hash, $access_type.name, $extra_cache_key )}

    {if is_unset($pagedesign)}
        {def $pagedata   = ezpagedata()
             $pagedesign = $pagedata.template_look}
    {/if}

  </div>
  <!-- Columns area: END -->

  <!-- Footer area: START -->
  {if $mode|ne('admin') }
 	{include uri='design:page_footer.tpl'}
  {/if}
  <!-- Footer area: END -->

</div>
<!-- Complete page area: END -->

<!-- Footer script area: START -->
{include uri='design:page_footer_script.tpl'}
<!-- Footer script area: END -->

{* The popup menu include must be outside all divs. It is hidden by default. *}
{if and($current_user.is_logged_in, $pagedata.is_edit|not)}
	{if fetch( 'user', 'has_access_to', hash( 'module', 'websitetoolbar', 'function', 'use' ) ) }
		{include uri='design:popupmenu/popup_menu.tpl'}
	{/if}
{/if}


{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
{if or($current_user.is_logged_in|not, fetch( 'user', 'has_access_to', hash( 'module', 'websitetoolbar', 'function', 'use' ) )|not ) }
	{'false'|bc_ga_urchin()}
{/if}
</html>
{/set-block}{$output} {*|tidy_output()*}