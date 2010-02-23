{default enable_print=true()}

<link rel="Home" href={"/"|ezurl} title="{'%sitetitle front page'|i18n('design/ezwebin/link',,hash('%sitetitle',$site.title))}" />
<link rel="Index" href={"/"|ezurl} />
<link rel="Top"  href={"/"|ezurl} title="{$site_title}" />
<link rel="Search" href={"content/advancedsearch"|ezurl} title="{'Search %sitetitle'|i18n('design/ezwebin/link',,hash('%sitetitle',$site.title))}" />
<link rel="Shortcut icon" href={"favicon.ico"|ezimage} type="image/x-icon" />
{*<link rel="Copyright" href={"/ezinfo/copyright"|ezurl} />
<link rel="Author" href={"/ezinfo/about"|ezurl} />*}
{if and( is_set($module_result.content_info), is_set($module_result.content_info.url_alias) )}
	{def $canonical_node=fetch( 'content', 'node', hash( 'node_id', $module_result.node_id ) )}
	{if or( $module_result.content_info.url_alias|ne($module_result.uri), $canonical_node.node_id|ne($canonical_node.object.main_node_id) ) }
	<link rel="canonical" href={$canonical_node.object.main_node.url_alias|ezurl(,'full')} />
	{/if}
{/if}

{* if and( is_set($pagedesign), $pagedesign.data_map.rss_feed.has_content )}
<link rel="Alternate" type="application/rss+xml" title="RSS" href="{$pagedesign.data_map.rss_feed.data_text|ezurl(no)}" />
{/if *}

{if $enable_print}
<link rel="Alternate" href={concat("layout/set/print/", $site.uri.original_uri)|ezurl} media="print" title="{'Printable version'|i18n('design/ezwebin/link')}" />
{/if}

{/default}