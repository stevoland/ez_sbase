{ezpagedata_set('mode', 'admin')}

{default search=false()}
{section show=$use_template_search}
    {set page_limit=10}
    {switch match=$search_page_limit}
    {case match=1}{set page_limit=5}{/case}
    {case match=2}{set page_limit=10}{/case}
    {case match=3}{set page_limit=20}{/case}
    {case match=4}{set page_limit=30}{/case}
    {case match=5}{set page_limit=50}{/case}
    {case/}
    {/switch}
    {set search=fetch(content,search,
                      hash(text,$search_text,
                           section_id,$search_section_id,
                           subtree_array,$search_sub_tree,
                           class_id,$search_contentclass_id,
                           class_attribute_id,$search_contentclass_attribute_id,
                           offset,$view_parameters.offset,
                           publish_date,$search_date,
                           limit,$page_limit))}
    {set search_result=$search['SearchResult']}
    {set search_count=$search['SearchCount']}
    {set stop_word_array=$search['StopWordArray']}
    {set search_data=$search}
{/section}

<form action={$search_url|ezurl} method="get">
<div class="context-block">
{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">{'Admin search'|i18n( 'design/admin/content/search' )}</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

<div class="context-attributes">

<div class="block">
<label>{'Search for all of the following words'|i18n( 'design/admin/content/search' )}:</label>
<input class="halfbox" type="text" size="40" name="SearchText" value="{$full_search_text|wash}" />
</div>

<div class="block">
<label>{'Search for an exact phrase'|i18n( 'design/admin/content/search' )}:</label>
<input class="halfbox" type="text" size="40" name="PhraseSearchText" value="{$phrase_search_text|wash}" />
</div>

<div class="block">

<div class="element">
<label>{'Class'|i18n( 'design/admin/content/search' )}:</label>
<select name="SearchContentClassID">
<option value="-1">{'Any class'|i18n( 'design/admin/content/search' )}</option>
{section name=ContentClass loop=$content_class_array }
<option {switch name=sw match=$search_contentclass_id}
{case match=$ContentClass:item.id}
selected="selected"
{/case}
{case}
{/case}
{/switch} value="{$ContentClass:item.id}">{$ContentClass:item.name|wash}</option>
{/section}
</select>
</div>

<div class="element">
<label>{'Class attribute'|i18n( 'design/admin/content/search' )}:</label>

{section name=Attribute show=$search_contentclass_id|gt( 0 )}

<select name="SearchContentClassAttributeID">
<option value="-1">{'Any attribute'|i18n( 'design/admin/content/search' )}</option>
{section name=ClassAttribute loop=$search_content_class_attribute_array}
<option value="{$Attribute:ClassAttribute:item.id}" 
{section show=eq( $search_contentclass_attribute_id, $Attribute:ClassAttribute:item.id )}selected="selected"{/section}>
{$Attribute:ClassAttribute:item.name|wash}
</option>
{/section}
</select>

&nbsp;

{/section}
<input class="button" type="submit" name="SelectClass" value="{'Update attributes'|i18n( 'design/admin/content/search' )}"/>
</div>

<div class="break"></div>
</div>
<div class="block">
<div class="element">

<label>{'In'|i18n( 'design/admin/content/search' )}:</label>
<select name="SearchSectionID">
<option value="-1">{'Any section'|i18n( 'design/admin/content/search' )}</option>
{section name=Section loop=$section_array }
<option {switch name=sw match=$search_section_id}
     {case match=$Section:item.id}
selected="selected"
{/case}
{case}
{/case}
{/switch} value="{$Section:item.id}">{$Section:item.name|wash}</option>
{/section}
</select>

</div>
<div class="element">

<label>{"Published"|i18n( 'design/admin/content/search' )}:</label>
<select name="SearchDate">
<option value="-1" {section show=eq( $search_date, -1 )}selected="selected"{/section}>{'Any time'|i18n( 'design/admin/content/search' )}</option>
<option value="1"  {section show=eq( $search_date,  1 )}selected="selected"{/section}>{'Last day'|i18n( 'design/admin/content/search' )}</option>
<option value="2"  {section show=eq( $search_date,  2 )}selected="selected"{/section}>{'Last week'|i18n( 'design/admin/content/search' )}</option>
<option value="3"  {section show=eq( $search_date,  3 )}selected="selected"{/section}>{'Last month'|i18n( 'design/admin/content/search' )}</option>
<option value="4"  {section show=eq( $search_date,  4 )}selected="selected"{/section}>{'Last three months'|i18n( 'design/admin/content/search' )}</option>
<option value="5"  {section show=eq( $search_date,  5 )}selected="selected"{/section}>{'Last year'|i18n( 'design/admin/content/search' )}</option>
</select>
</div>

{section show=$use_template_search}
<div class="element">
<label>{'Display per page'|i18n( 'design/admin/content/search' )}:</label>
<select name="SearchPageLimit">
<option value="1" {section show=eq($search_page_limit,1)}selected="selected"{/section}>{"5 items"|i18n( 'design/admin/content/search' )}</option>
<option value="2" {section show=or(array(1,2,3,4,5)|contains($search_page_limit)|not,eq($search_page_limit,2))}selected="selected"{/section}>{"10 items"|i18n( 'design/admin/content/search' )}</option>
<option value="3" {section show=eq($search_page_limit,3)}selected="selected"{/section}>{"20 items"|i18n( 'design/admin/content/search' )}</option>
<option value="4" {section show=eq($search_page_limit,4)}selected="selected"{/section}>{"30 items"|i18n( 'design/admin/content/search' )}</option>
<option value="5" {section show=eq($search_page_limit,5)}selected="selected"{/section}>{"50 items"|i18n( 'design/admin/content/search' )}</option>
</select>
</div>
{/section}

{section name=SubTree loop=$search_sub_tree}
<input type="hidden" name="SubTreeArray[]" value="{$:item}" />
{/section}


<div class="break"></div>
</div>
{section show=or($search_text,eq(ezini('SearchSettings','AllowEmptySearch','site.ini'),'enabled') )}
<br/>
{switch name=Sw match=$search_count}
  {case match=0}
<div class="warning">
<h2>{'No results were found when searching for <%1>'|i18n( 'design/admin/content/search',, array( $search_text ) )|wash}</h2>
</div>
  {/case}
  {case}
  {/case}
{/switch}
{/section}
</div>
{* DESIGN: Content END *}</div></div></div>

<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block">
<input class="button" type="submit" name="SearchButton" value="{'Search'|i18n( 'design/admin/content/search' )}" />
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

</div>
</form>

{/default}

{section show=is_set($browse) }
	<form name="browse" action={$browse.from_page|ezurl} method="post">
{/section}

{section show=ne($search_count,0)}
<div class="context-block">
{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
<h2 class="context-title">{'Search for <%1> returned %2 matches'|i18n( 'design/admin/content/search',, array( $search_text, $search_count ) )|wash}</h2>

{* DESIGN: Mainline *}<div class="header-subline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{if is_set($browse)}

	{if $browse.description_template}
	    {include name=Description uri=$browse.description_template browse=$browse}
	    {$browse.description_template}
	{else}
	
	    <p>{'To select objects, choose the appropriate radiobutton or checkbox(es), and click the "Select" button.'|i18n( 'design/ezwebin/content/browse' )}</p>
	    <p>{'To select an object that is a child of one of the displayed objects, click the parent object name to display a list of its children.'|i18n( 'design/ezwebin/content/browse' )}</p>
	{/if}
{/if}
</div>
{/section}

{section show=ne($search_count,0)}
<div class="context-block">

{* DESIGN: Content START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">

{include name=Result
         uri='design:content/advancedsearch/admin_searchresult.tpl'
         search_result=$search_result}

<div class="context-toolbar">
{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri=$search_url
         page_uri_suffix=concat('?SearchText=',$search_text|urlencode,'&PhraseSearchText=',$phrase_search_text|urlencode,'&SearchContentClassID=',$search_contentclass_id,'&SearchContentClassAttributeID=',$search_contentclass_attribute_id,'&SearchSectionID=',$search_section_id,$search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)),$search_sub_tree|gt(0)|choose( '', concat( '&', 'SubTreeArray[]'|urlencode, '=', $search_sub_tree|implode( concat( '&', 'SubTreeArray[]'|urlencode, '=' ) ) ) ),'&SearchDate=',$search_date,'&SearchPageLimit=',$search_page_limit)
         item_count=$search_count
         view_parameters=$view_parameters
         item_limit=$page_limit}
</div>

{* DESIGN: Content END *}</div></div></div></div></div></div>

</div>
{/section}

{if is_set($browse)}
	{if $browse.persistent_data|count()}
	{foreach $browse.persistent_data as $key => $data_item}
	    <input type="hidden" name="{$key|wash}" value="{$data_item|wash}" />
	{/foreach}
	{/if}
	
	{section show=ne($search_count,0)}
	
		<input type="hidden" name="BrowseActionName" value="{$browse.action_name}" />
		{if $browse.browse_custom_action}
		<input type="hidden" name="{$browse.browse_custom_action.name}" value="{$browse.browse_custom_action.value}" />
		{/if}
		
		<input class="button" type="submit" name="SelectButton" value="{'Select'|i18n('design/ezwebin/content/browse')}" />
	{/section}
	
	
	{if is_set($cancel_action)}
	<input type="hidden" name="BrowseCancelURI" value="{$cancel_action}" />
	{/if}
	 <input class="button" type="submit" name="BrowseCancelButton" value="{'Cancel'|i18n( 'design/ezwebin/content/browse' )}" />
	</form>
{/if}
