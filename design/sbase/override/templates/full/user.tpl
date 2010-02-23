<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="{include uri='design:parts/full/cssclasses.tpl'}">

    <div class="attribute-header">
        <h1>{$node.name|wash()}</h1>
    </div>

	{def $attribute=$node.object.data_map.user_account}
    <div class="block">
		<div class="element">
		<label>{'Username'|i18n( 'design/standard/content/datatype' )}:</label>
		{$attribute.content.login|wash( xhtml )}
		</div>
		
		<div class="element">
		<label>{'Email'|i18n( 'design/standard/content/datatype' )}:</label>
		<a href="mailto:{$attribute.content.email}">{$attribute.content.email}</a>
		</div>
		
		<div class="break"></div>
	</div>
	{undef $attribute}
	
	{foreach $node.object.contentobject_attributes as $attribute}
	{if $attribute.contentclass_attribute_identifier|begins_with('hidden_')}}
	{elseif $attribute.data_type_string|eq('ezuser')|not}
    <div class="attribute-{$attribute.contentclass_attribute_identifier} ezccadt-{$attribute.data_type_string}">
        <h3>{$attribute.contentclass_attribute.name|wash}</h3>
        {attribute_view_gui attribute=$attribute}
    </div>
    {/if}
    {/foreach}


	{* def $list=fetch('newsletter', 'list_subscriptions')}
	{$list|objDebug(show) *}

    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
