{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

{if $load_css_file_list}
  {set $loaded_styles=array( 'html5boilerplate/reset.css',
                 'html5boilerplate/base.css',
                 'html5boilerplate/fonts.css',
                 'yui/grids.css',
                 'core.css',
                 'pagelayout.css',
                 'debug.css',
                 'oocss/template.css',
                 'content.css',
                 'websitetoolbar.css',
                 'sbase.css',
                 'extra.css',
                 ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ),
                 ezini( 'StylesheetSettings','SiteCSS','design.ini'),
                 'print.css' ) }
{else}
	{set $loaded_styles=array( 'yui3/reset.css',
                 'yui3/base.css',
                 'yui3/fonts.css',
                 'yui/grids.css',
                 'core.css',
                 'pagelayout.css',
                 'debug.css',
                 'oocss/template.css',
                 'content.css',
                 'websitetoolbar.css',
                 'sbase.css',
                 'extra.css',
                 ezini( 'StylesheetSettings','SiteCSS','design.ini'),
                 'print.css' ) }
{/if}
<!--[if (gte IE 8)|!(IE)]><!-->
{ezcss($loaded_styles) }
{ezcss_load()}
<!--<![endif]-->
<!--[if IE 5 ]>
{ezcss($loaded_styles|append("browsers/ie5.css"))}
<![endif]-->
<!--[if lte IE 7 ]>
{ezcss($loaded_styles|append("browsers/ie7lte.css"))}
<![endif]-->
{if $#head_styles|count}
     {ezcss($#head_styles|unique)}
     {set $loaded_styles=$loaded_styles|array_merge($#head_styles) }
     {set $head_styles = array()
           scope=global}
{/if}
{if $#head_inline_styles|count}
     <style type="text/css">
     {foreach $#head_inline_styles as $style}
          {$style}
     {/foreach}
     </style>
     {set $head_inline_styles = array()
           scope=global}
{/if}