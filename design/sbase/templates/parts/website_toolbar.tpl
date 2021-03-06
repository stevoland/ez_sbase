{def $current_node = fetch( 'content', 'node', hash( 'node_id', $current_node_id ) )
     $content_object = $current_node.object
     $can_edit_languages = $content_object.can_edit_languages
     $can_manage_location = fetch( 'content', 'access', hash( 'access', 'manage_locations', 'contentobject', $current_node ) )
     $can_create_languages = $content_object.can_create_languages
     $is_container = $content_object.content_class.is_container
     $odf_display_classes = ezini( 'WebsiteToolbarSettings', 'ODFDisplayClasses', 'websitetoolbar.ini' )
     $odf_hide_container_classes = ezini( 'WebsiteToolbarSettings', 'HideODFContainerClasses', 'websitetoolbar.ini' )
     $odf_hide = ezini( 'WebsiteToolbarSettings', 'HideODF', 'websitetoolbar.ini' )
     $website_toolbar_access = fetch( 'user', 'has_access_to', hash( 'module', 'websitetoolbar', 'function', 'use' ) )
     $odf_import_access = fetch( 'user', 'has_access_to', hash( 'module', 'ezodf', 'function', 'import' ) )
     $odf_export_access = fetch( 'user', 'has_access_to', hash( 'module', 'ezodf', 'function', 'export' ) )
     $content_object_language_code = ''
     $policies = fetch( 'user', 'user_role', hash( 'user_id', $current_user.contentobject_id ) )
     $available_for_current_class = false()
     $custom_templates = ezini( 'CustomTemplateSettings', 'CustomTemplateList', 'websitetoolbar.ini' )
     $include_in_view = ezini( 'CustomTemplateSettings', 'IncludeInView', 'websitetoolbar.ini' )}

     {foreach $policies as $policy}
        {if and( eq( $policy.moduleName, 'websitetoolbar' ),
                    eq( $policy.functionName, 'use' ),
                        is_array( $policy.limitation ) )}
            {if $policy.limitation[0].values_as_array|contains( $content_object.content_class.id )}
                {set $available_for_current_class = true()}
            {/if}
        {elseif or( and( eq( $policy.moduleName, '*' ),
                             eq( $policy.functionName, '*' ),
                                 eq( $policy.limitation, '*' ) ),
                    and( eq( $policy.moduleName, 'websitetoolbar' ),
                             eq( $policy.functionName, '*' ),
                                 eq( $policy.limitation, '*' ) ),
                    and( eq( $policy.moduleName, 'websitetoolbar' ),
                             eq( $policy.functionName, 'use' ),
                                 eq( $policy.limitation, '*' ) ) )}
            {set $available_for_current_class = true()}
        {/if}
     {/foreach}

{if and( $website_toolbar_access, $available_for_current_class )}

<!-- eZ website toolbar: START -->

<div id="ezwt">
<div class="tl"><div class="tr"><div class="tc"></div></div></div>
<div class="mc"><div class="ml"><div class="mr float-break">

<!-- eZ website toolbar content: START -->
{include uri='design:parts/websitetoolbar/styles.tpl'}
{include uri='design:parts/websitetoolbar/logo.tpl'}
{include uri='design:parts/websitetoolbar/content_structure_menu.tpl'}

<div id="ezwt-standardactions">

{if $content_object.can_edit}
	{if $module_result.content_info.viewmode|ne('full') }
	    <a href={concat('/content/view/full/',$module_result.node_id)|ezurl} title="{'Normal view'|i18n('extension/base')}" class="ezwt-left ezwt-detail"><img src={"websitetoolbar/ezwt-icon-detail.gif"|ezimage} alt="{'Switch'|i18n('extension/base')}" /></a>
	{else}
	    <a href={concat('/content/view/detail/',$module_result.node_id)|ezurl} title="{'Detailed view'|i18n('extension/base')}" class="ezwt-left ezwt-detail"><img src={"websitetoolbar/ezwt-icon-detail.gif"|ezimage} alt="{'Switch'|i18n('extension/base')}" /></a>
	{/if}
{/if}

<form method="post" action={"content/action"|ezurl} class="left">
{if and( $content_object.can_create, $is_container )}
<label for="ezwt-create" class="hide">Create:</label>
{def $can_create_class_list = ezcreateclasslistgroups( $content_object.can_create_class_list )}
  {if $can_create_class_list|count()}
  <select name="ClassID" id="ezwt-create">
  {foreach $can_create_class_list as $group}
    <optgroup label="{$group.group_name}">
    {foreach $group.items as $class}
        <option value="{$class.id}">{$class.name|wash}</option>
    {/foreach}
    </optgroup>
  {/foreach}
  </select>
  {/if}
  <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini')}" />
  <input type="image" src={"websitetoolbar/ezwt-icon-new.gif"|ezimage} name="NewButton" title="{'Create here'|i18n('design/ezwebin/parts/website_toolbar')}" />
{/if}

{if $content_object.can_edit}
    <input type="hidden" name="ContentObjectLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini')}" />
    <input type="image" src={"websitetoolbar/ezwt-icon-edit.gif"|ezimage} name="EditButton" title="{'Edit: %node_name [%class_name]'|i18n( 'design/ezwebin/parts/website_toolbar', , hash( '%node_name', $current_node.name|wash(), '%class_name', $content_object.content_class.name|wash() ) )}" />
{/if}

{if $content_object.can_move}
    <input type="image" src={"websitetoolbar/ezwt-icon-move.gif"|ezimage} name="MoveNodeButton" title="{'Move'|i18n('design/ezwebin/parts/website_toolbar')}" />
{/if}

{if $content_object.can_remove}
    <input type="image" src={"websitetoolbar/ezwt-icon-remove.gif"|ezimage} name="ActionRemove" title="{'Remove'|i18n('design/ezwebin/parts/website_toolbar')}" />
{/if}

{if $can_manage_location}
    {if and( $can_manage_location, ne( $current_node.node_id, ezini( 'NodeSettings', 'RootNode','content.ini' ) ), ne( $current_node.node_id, ezini( 'NodeSettings', 'MediaRootNode', 'content.ini' ) ), ne( $current_node.node_id, ezini( 'NodeSettings', 'UserRootNode', 'content.ini' ) ) )}
        <input type="image" src={"websitetoolbar/ezwt-icon-locations.gif"|ezimage} name="AddAssignmentButton" title="{'Add locations'|i18n( 'design/ezwebin/parts/website_toolbar' )}" />
    {else}
        <input type="image" src={"websitetoolbar/ezwt-icon-locations-disabled.gif"|ezimage} name="AddAssignmentButton" title="{'Add locations'|i18n( 'design/ezwebin/parts/website_toolbar' )}" disabled="disabled" />
    {/if}
{/if}

<a href={concat( "websitetoolbar/sort/", $current_node.node_id )|ezurl()} title="{'Sorting'|i18n( 'design/ezwebin/parts/website_toolbar' )}"><img src={"websitetoolbar/ezwt-icon-sort.gif"|ezimage} alt="{'Sorting'|i18n( 'design/ezwebin/parts/website_toolbar' )}" /></a>



  <input type="hidden" name="HasMainAssignment" value="1" />
  <input type="hidden" name="ContentObjectID" value="{$content_object.id}" />
  <input type="hidden" name="NodeID" value="{$current_node.node_id}" />
  <input type="hidden" name="ContentNodeID" value="{$current_node.node_id}" />
  {* If a translation exists in the siteaccess' sitelanguagelist use default_language, otherwise let user select language to base translation on. *}
  {def $avail_languages = $content_object.available_languages
       $default_language = $content_object.default_language}
  {if and( $avail_languages|count|ge( 1 ), $avail_languages|contains( $default_language ) )}
    {set $content_object_language_code = $default_language}
  {else}
    {set $content_object_language_code = ''}
  {/if}
  <input type="hidden" name="ContentObjectLanguageCode" value="{$content_object_language_code}" />
</form>

{* Custom templates inclusion *}
{def $views = ''}
{foreach $custom_templates as $custom_template}
    {if is_set( $include_in_view[$custom_template] )}
        {set $views = $include_in_view[$custom_template]|explode( ';' )}
        {if or($views|contains( 'full' ), $views|contains( '*' ))}
            {include uri=concat( 'design:parts/websitetoolbar/', $custom_template, '.tpl' )}
        {/if}
    {/if}
{/foreach}
{undef $views}
</div>

{include uri='design:parts/websitetoolbar/help.tpl'}

{if $odf_hide|not}
<div id="ezwt-openoffice">

{def $disable_oo=true()}

{if $odf_display_classes|contains( $content_object.content_class.identifier )}
    {set $disable_oo=false()}
{/if}

{if $disable_oo|not}

{if $odf_import_access}
<form method="post" action={"/ezodf/import/"|ezurl} class="right">
  <input type="hidden" name="ImportType" value="replace" />
  <input type="hidden" name="NodeID" value="{$current_node.node_id}" />
  <input type="hidden" name="ObjectID" value="{$content_object.id}" />
  <input type="image" src={"websitetoolbar/ezwt-icon-replace.gif"|ezimage} name="ReplaceAction" title="{'Replace'|i18n('design/ezwebin/parts/website_toolbar')}" />
</form>
{/if}
{if $odf_export_access}
<form method="post" action={"/ezodf/export/"|ezurl} class="right">
  <input type="hidden" name="NodeID" value="{$current_node.node_id}" />
  <input type="hidden" name="ObjectID" value="{$content_object.id}" />
  <input type="image" src={"websitetoolbar/ezwt-icon-export.gif"|ezimage} name="ExportAction" title="{'Export'|i18n('design/ezwebin/parts/website_toolbar')}" />
</form>
{/if}


{if and( $content_object.content_class.is_container, 
            $odf_hide_container_classes|contains( $content_object.content_class.identifier )|not(), 
                $odf_import_access )}
<form method="post" action={"/ezodf/import/"|ezurl} class="right">
  <input type="hidden" name="NodeID" value="{$current_node.node_id}" />
  <input type="hidden" name="ObjectID" value="{$content_object.id}" />
  <input type="image" src={"websitetoolbar/ezwt-icon-import.gif"|ezimage} name="ImportAction" title="{'Import'|i18n('design/ezwebin/parts/website_toolbar')}" />
</form>
{/if}

<div id="ezwt-oologo">
<img src={"websitetoolbar/ezwt-oo-logo.gif"|ezimage} width="58" height="18" alt="OpenOffice.org" />
</div>
{/if}
</div>

{/if}

<!-- eZ website toolbar content: END -->

</div></div></div>
<div class="bl"><div class="br"><div class="bc"></div></div></div>
</div>

<!-- eZ website toolbar: END -->

{/if}