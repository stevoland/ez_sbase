<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-detail">
    <div class="{include uri='design:parts/full/cssclasses.tpl'}">

    <div class="attribute-header">
        <h1><a href={concat('/content/view/detail/',$node.parent_node_id)|ezurl} title="{'Up one level.'|i18n(  'design/admin/node/view/full'  )}"><img src={'back-button-16x16.gif'|ezimage} alt="{'Up one level.'|i18n( 'design/admin/node/view/full' )}" title="{'Up one level.'|i18n( 'design/admin/node/view/full' )}" /></a>&nbsp;{$node.name|wash()} [{$node.class_name|wash}]</h1>
    </div>

<div class="mainobject-window">
<div class="fixedsize">{* Fix for overflow bug in Opera *}
<div class="holdinplace">{* Fix for some width bugs in IE *}

{def $design_attributes=array()}

{foreach $node.object.contentobject_attributes as $attribute}
	{if $attribute.contentclass_attribute_identifier|begins_with('design_')}
		{set $design_attributes=$design_attributes|append($attribute) }
  {elseif $attribute.contentclass_attribute_identifier|begins_with('hidden_')}
	{elseif $attribute.data_type_string|eq('xrowmetadata')}
		{def $metadata_attribute=$attribute}
	{else}
		<div class="ezcoa ezcoadt-{$attribute.data_type_string} attribute-{$attribute.contentclass_attribute_identifier}">
		{if $attribute.display_info.view.grouped_input}
		<fieldset>
			<legend>{$attribute.contentclass_attribute.name|wash}{section show=$attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/section}</legend>
			{attribute_view_gui attribute=$attribute}
		</fieldset>
		{else}
			<label>{$attribute.contentclass_attribute.name|wash}{section show=$attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/section}:</label>
      {if $attribute.is_information_collector|not}
        <div class="mode-site">
      {/if}
			{attribute_view_gui attribute=$attribute}
      {if $attribute.is_information_collector|not}
        </div>
        <div class="clearboth"></div>
      {/if}
		{/if}
		</div>
	{/if}
{/foreach}

{if $design_attributes|count|gt(0)}
	<fieldset>
		<legend>Design</legend>
	{foreach $design_attributes as $attribute}
		<div class="ezcoa ezcoadt-{$attribute.data_type_string} attribute-{$attribute.contentclass_attribute_identifier}">
		<label>{$attribute.contentclass_attribute.name|wash}{section show=$attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/section}:</label>
		{attribute_view_gui attribute=$attribute}
		</div>
	{/foreach}
	</fieldset>
{/if}

{if is_set($metadata_attribute) }
	<fieldset>
		<legend>{$metadata_attribute.contentclass_attribute.name|wash}
		<div class="ezcoa ezcoadt-{$metadata_attribute.data_type_string} attribute-{$metadata_attribute.contentclass_attribute_identifier}">
		{attribute_view_gui attribute=$metadata_attribute}
		</div>
	</fieldset>
{/if}


</div>
</div>
<div class="break"></div>{* Terminate overflow bug fix *}
</div>

<div class="content-view-children">

<!-- Children START -->

<div class="context-block">
<form name="children" id="ezwt-sort-form" method="post" action={'content/action'|ezurl}>
<input type="hidden" name="ContentNodeID" value="{$node.node_id}" />

{* Generic children list for admin interface. *}
{let item_type=ezpreference( 'admin_list_limit' )
     priority_sorting = $node.sort_array[0][0]|eq( 'priority' )
     number_of_items=min( $item_type, 3)|choose( 10, 10, 25, 50 )
     can_remove=false()
     can_move=false()
     can_edit=false()
     can_create=false()
     can_copy=false()
     children_count=fetch( content, list_count, hash( parent_node_id, $node.node_id,
                                                      objectname_filter, $view_parameters.namefilter ) )
     children=fetch( content, list, hash( parent_node_id, $node.node_id,
                                          sort_by, $node.sort_array,
                                          limit, $number_of_items,
                                          offset, $view_parameters.offset,
                                          objectname_filter, $view_parameters.namefilter,
                                          ignore_visibility, true() ) ) }

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">




<h2 class="context-title"><a href={$node.depth|gt(1)|choose('/'|ezurl,concat('/content/view/detail/',$node.parent_node_id)|ezurl )} title="{'Up one level.'|i18n(  'design/admin/node/view/full'  )}"><img src={'back-button-16x16.gif'|ezimage} alt="{'Up one level.'|i18n( 'design/admin/node/view/full' )}" title="{'Up one level.'|i18n( 'design/admin/node/view/full' )}" /></a>&nbsp;{'Sub items [%children_count]'|i18n( 'design/admin/node/view/full',, hash( '%children_count', $children_count ) )}</h2>

{* DESIGN: Subline *}<div class="header-subline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

{* If there are children: show list and buttons that belong to the list. *}
{section show=$children}

{* Items per page and view mode selector. *}
<div class="context-toolbar">
<div class="block">
<div class="left">
    <p>
    {switch match=$number_of_items}
    {case match=25}
        <a href={'/user/preferences/set/admin_list_limit/1'|ezurl} title="{'Show 10 items per page.'|i18n( 'design/admin/node/view/full' )}">10</a>
        <span class="current">25</span>
        <a href={'/user/preferences/set/admin_list_limit/3'|ezurl} title="{'Show 50 items per page.'|i18n( 'design/admin/node/view/full' )}">50</a>

        {/case}

        {case match=50}
        <a href={'/user/preferences/set/admin_list_limit/1'|ezurl} title="{'Show 10 items per page.'|i18n( 'design/admin/node/view/full' )}">10</a>
        <a href={'/user/preferences/set/admin_list_limit/2'|ezurl} title="{'Show 25 items per page.'|i18n( 'design/admin/node/view/full' )}">25</a>
        <span class="current">50</span>
        {/case}

        {case}
        <span class="current">10</span>
        <a href={'/user/preferences/set/admin_list_limit/2'|ezurl} title="{'Show 25 items per page.'|i18n( 'design/admin/node/view/full' )}">25</a>
        <a href={'/user/preferences/set/admin_list_limit/3'|ezurl} title="{'Show 50 items per page.'|i18n( 'design/admin/node/view/full' )}">50</a>
        {/case}

        {/switch}
    </p>
</div>
<div class="right">
        <p>
        {switch match=ezpreference( 'admin_children_viewmode' )}
        {case match='thumbnail'}
        <a href={'/user/preferences/set/admin_children_viewmode/list'|ezurl} title="{'Display sub items using a simple list.'|i18n( 'design/admin/node/view/full' )}">{'List'|i18n( 'design/admin/node/view/full' )}</a>
        <span class="current">{'Thumbnail'|i18n( 'design/admin/node/view/full' )}</span>
        {/case}

        {case}
        <span class="current">{'List'|i18n( 'design/admin/node/view/full' )}</span>
        <a href={'/user/preferences/set/admin_children_viewmode/thumbnail'|ezurl} title="{'Display sub items as thumbnails.'|i18n( 'design/admin/node/view/full' )}">{'Thumbnail'|i18n( 'design/admin/node/view/full' )}</a>
        {/case}
        {/switch}
        </p>
</div>

<div class="break"></div>

</div>
</div>

    {* Copying operation is allowed if the user can create stuff under the current node. *}
    {set can_copy=$node.can_create}

    {* Check if the current user is allowed to *}
    {* edit or delete any of the children.     *}
    {section var=Children loop=$children}
        {section show=$Children.item.can_remove}
            {set can_remove=true()}
        {/section}
        {section show=$Children.item.can_edit}
            {set can_edit=true()}
        {/section}
        {section show=$Children.item.can_create}
            {set can_create=true()}
        {/section}
        {if $Children.item.can_move}
            {set $can_move=true()}
        {/if}
    {/section}


{* Display the actual list of nodes. *}
{switch match=ezpreference( 'admin_children_viewmode' )}

{case match='thumbnail'}
    {include uri='design:children_thumbnail.tpl'}
{/case}

{case}
    {include uri='design:children_list.tpl'}
{/case}
{/switch}

{* Else: there are no children. *}
{section-else}

<div class="block">
    <p>{'The current item does not contain any sub items.'|i18n( 'design/admin/node/view/full' )}</p>
</div>

{/section}

<div class="context-toolbar">
{include name=navigator
         uri='design:navigator/alphabetical.tpl'
         page_uri=concat('/content/view/detail/',$node.node_id)
         item_count=$children_count
         view_parameters=$view_parameters
         node_id=$node.node_id
         item_limit=$number_of_items}
</div>

{* DESIGN: Content END *}</div></div></div>


{* Button bar for remove and update priorities buttons. *}
<div class="controlbar">

{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">

<div class="block">
    {* Remove button *}
    <div class="left">
    {section show=$can_remove}
        <input class="button" type="submit" name="RemoveButton" value="{'Remove selected'|i18n( 'design/admin/node/view/full' )}" title="{'Remove the selected items from the list above.'|i18n( 'design/admin/node/view/full' )}" />
    {section-else}
        <input class="button-disabled" type="submit" name="RemoveButton" value="{'Remove selected'|i18n( 'design/admin/node/view/full' )}" title="{'You do not have permissions to remove any of the items from the list above.'|i18n( 'design/admin/node/view/full' )}" disabled="disabled" />
    {/section}
        {if $can_move}
            <input class="button" type="submit" name="MoveButton" value="{'Move selected'|i18n( 'design/admin/node/view/full' )}" title="{'Move the selected items from the list above.'|i18n( 'design/admin/node/view/full' )}" />
        {else}
            <input class="button-disabled" type="submit" name="MoveButton" value="{'Move selected'|i18n( 'design/admin/node/view/full' )}" title="{'You do not have permission to move any of the items from the list above.'|i18n( 'design/admin/node/view/full' )}" disabled="disabled" />
        {/if}
    </div>

    <div class="right">
    {* Update priorities button *}
    {section show=and( eq( $node.sort_array[0][0], 'priority' ), $node.can_edit, $children_count )}
		{'Automaitc update'|i18n( 'design/standard/websitetoolbar/sort' )} <input id="ezwt-automatic-update" type="checkbox" name="AutomaticUpdate" value="" /> 
        <input id="ezwt-update-priority" class="button" type="submit" name="UpdatePriorityButton" value="{'Update priorities'|i18n( 'design/admin/node/view/full' )}" title="{'Apply changes to the priorities of the items in the list above.'|i18n( 'design/admin/node/view/full' )}" />
    {section-else}
        <input id="ezwt-update-priority" class="button-disabled" type="submit" name="UpdatePriorityButton" value="{'Update priorities'|i18n( 'design/admin/node/view/full' )}" title="{'You can not update the priorities because you do not have permissions to edit the current item or because a non-priority sorting method is used.'|i18n( 'design/admin/node/view/full' )}" disabled="disabled" />
    {/section}
    </div>

    <div class="break"></div>
</div>


{* The "Create new here" thing: *}
<div class="block">


{* Sorting *}
<div class="right">
<label>{'Sorting'|i18n( 'design/admin/node/view/full' )}:</label>

{let sort_fields=hash( 6, 'Class identifier'|i18n( 'design/admin/node/view/full' ),
                       7, 'Class name'|i18n( 'design/admin/node/view/full' ),
                       5, 'Depth'|i18n( 'design/admin/node/view/full' ),
                       3, 'Modified'|i18n( 'design/admin/node/view/full' ),
                       9, 'Name'|i18n( 'design/admin/node/view/full' ),
                       8, 'Priority'|i18n( 'design/admin/node/view/full' ),
                       2, 'Published'|i18n( 'design/admin/node/view/full' ),
                       4, 'Section'|i18n( 'design/admin/node/view/full' ) )
    title='You can not set the sorting method for the current location because you do not have permissions to edit the current item.'|i18n( 'design/admin/node/view/full' )
    disabled=' disabled="disabled"' }

{section show=$node.can_edit}
    {set title='Use these controls to set the sorting method for the sub items of the current location.'|i18n( 'design/admin/node/view/full' )}
    {set disabled=''}
    <input type="hidden" name="ContentObjectID" value="{$node.contentobject_id}" />
{/section}

<select id="ezwt-sort-field" name="SortingField" title="{$title}"{$disabled}>
{section var=Sort loop=$sort_fields}
    <option value="{$Sort.key}" {section show=eq( $Sort.key, $node.sort_field )}selected="selected"{/section}>{$Sort.item}</option>
{/section}
</select>

<select id="ezwt-sort-order" name="SortingOrder" title="{$title}"{if $disabled}{$disabled}{/if}>
    <option value="0"{section show=eq($node.sort_order, 0)} selected="selected"{/section}>{'Descending'|i18n( 'design/admin/node/view/full' )}</option>
    <option value="1"{section show=eq($node.sort_order, 1)} selected="selected"{/section}>{'Ascending'|i18n( 'design/admin/node/view/full' )}</option>
</select>
    
{if $priority_sorting}
	<input id="ezwt-sort-order-asc" type="hidden" name="SortingOrder" value="1" />
{/if}

<input {section show=$disabled}class="button-disabled"{section-else}class="button"{/section} type="submit" name="SetSorting" value="{'Set'|i18n( 'design/admin/node/view/full' )}" title="{$title}" {$disabled} />
<input type="hidden" name="RedirectURIAfterSorting" value={concat('/content/view/detail/', $node.node_id)|ezurl} />
<input type="hidden" name="RedirectURIAfterPriority" value={concat('/content/view/detail/', $node.node_id)|ezurl} />
<input type="hidden" name="ViewMode" value="detail" />


{/let}


</div>

<div class="break"></div>

</div>

{* DESIGN: Control bar END *}</div></div></div></div></div></div>

</div>

</form>

</div>

<!-- Children END -->

{/let}
</div>

    </div>
</div>


{include uri='design:locations.tpl'}

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>
{ezscript_require( array( 'ezjsc::yui3', 'ezjsc::yui3io', 'ezwtsortdd.js' ) )}
<script type="text/javascript">
eZWTSortDD.init();
</script>