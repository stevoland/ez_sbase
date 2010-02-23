{def $custom_templates = ezini( 'CustomTemplateSettings', 'CustomTemplateList', 'websitetoolbar.ini' )
     $include_in_view = ezini( 'CustomTemplateSettings', 'IncludeInView', 'websitetoolbar.ini' )
 }
{default $uri_string = 'extra' }

<!-- eZ website toolbar: START -->
{include uri='design:parts/websitetoolbar/styles.tpl'}
<div id="ezwt">
<div class="tl"><div class="tr"><div class="tc"></div></div></div>
<div class="mc"><div class="ml"><div class="mr float-break">

<!-- eZ website toolbar content: START -->

{include uri='design:parts/websitetoolbar/logo.tpl'}
{include uri='design:parts/websitetoolbar/content_structure_menu.tpl'}

{* Custom templates inclusion *}
{foreach $custom_templates as $custom_template}
    {if is_set( $include_in_view[$custom_template] )}
        {def $views = $include_in_view[$custom_template]|explode( ';' )}
        {foreach $views as $view}
	        {if or($uri_string|begins_with( $view ), $views|contains('*'))}
	            {include uri=concat( 'design:parts/websitetoolbar/', $custom_template, '.tpl' )}
	            {break}
	        {/if}
        {/foreach}
        {undef $views}
    {/if}
{/foreach}

{include uri='design:parts/websitetoolbar/help.tpl'}

<!-- eZ website toolbar content: END -->

</div></div></div>
<div class="bl"><div class="br"><div class="bc"></div></div></div>
</div>

<!-- eZ website toolbar: END -->