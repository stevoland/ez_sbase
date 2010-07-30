{default enable_help=true() enable_link=true()}

{literal}
<script type="text/javascript">
(function(ns){
  var hash = ns.location.hash;
    if ( hash.indexOf('#') === 0 )
      hash = hash.substring(1);
    var parts = hash.split('&');
    for ( var i=0, len = parts.length; i<len; i++ )
    {
      if ( parts[i].indexOf('p=/') === 0 || parts[i].indexOf('p=%2F') === 0 )
      {
        var url = ns.location.protocol + '//' + ns.location.host + decodeURIComponent( parts[i].substring(2) );
        ns.location.replace(url);
      }
    }
})(this);
</script>
{/literal}

{def $site_title=''}
{if is_set($pagedata.persistent_variable.site_title)}
    {set scope=root site_title=$pagedata.persistent_variable.site_title}
{else}
  {let name=Path
       path=$module_result.path
       reverse_path=array()}
    {if is_set($pagedata.path_array)}
      {set path=$pagedata.path_array}
    {elseif is_set($module_result.title_path)}
      {set path=$module_result.title_path}
    {/if}
    {section loop=$:path offset=1}
      {set reverse_path=$:reverse_path|array_prepend($:item)}
    {/section}
    
    {*adminmode*}
    
    {if and( $:reverse_path|count|eq(0), or( is_unset($module_result.node_id), is_unset($module_result.content_info), $module_result.content_info.viewmode|ne('full') ), is_unset($pagedata.persistent_variable.preview_node) ) }
    	{set reverse_path=$:path }
  	{* admin mode *}
    {/if}
  
    {set-block scope=root variable=site_title}{if $Path:reverse_path|count|ge(1)}{section loop=$Path:reverse_path}{$:item.text|wash}{delimiter} / {/delimiter}{/section} - {/if}{$site.title|wash}{/set-block}
  
  {/let}
{/if}
    <title>{$site_title}</title>

    {*if and(is_set($#Header:extra_data),is_array($#Header:extra_data))}
      {section name=ExtraData loop=$#Header:extra_data}
      {$:item}
      {/section}
    {/if*}
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Cache-control" content="no-cache" />
	

    {* check if we need a http-equiv refresh *}
    {if and( is_set($site.redirect), is_object($site.redirect) ) }
    	<meta http-equiv="Refresh" content="{$site.redirect.timer}; URL={$site.redirect.location}" />

    {/if}
    {foreach $site.http_equiv as $key => $item}
        <meta name="{$key|wash}" content="{$item|wash}" />
    {/foreach}
    
    {if is_set($module_result.node_id) }
    	{def $meta = metadata( $module_result.node_id ) }
    {/if}
	{if is_set($meta)}
	    {if is_set($meta.keywords)}
	    <meta name="keywords" content="{$meta.keywords|wash|downcase}" />
	    {/if}
	    {if is_set($meta.description)}
	    <meta name="description" content="{$meta.description|wash}" />
	    {/if}
	{elseif is_set($meta)}
	  {foreach $site.meta as $key => $item}
    	{if is_set( $module_result.content_info.persistent_variable[$key] )}
        <meta name="{$key|wash}" content="{$module_result.content_info.persistent_variable[$key]|wash}" />
    	{else}
        <meta name="{$key|wash}" content="{$item|wash}" />
    	{/if}
    {/foreach}
	{/if}

    
    
    <meta name="MSSmartTagsPreventParsing" content="TRUE" />
    <meta name="generator" content="eZ Publish" />

{if $enable_link}
    {include uri="design:link.tpl" enable_help=$enable_help enable_link=$enable_link}
{/if}

{/default}