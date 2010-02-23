{let search=false()}
{section show=$use_template_search}
	{def $inc_classes=-1
		 $exc_classes=-1 }
	{if ezini_hasvariable( 'Search', 'IncludeClasses', 'search.ini' )}
		{set $inc_classes=ezini( 'Search', 'IncludeClasses', 'search.ini' )}
	{/if}
	{if or( $inc_classes|is_array|not, $inc_classes|count|not ) }
		{set $inc_classes=-1 }
		{if ezini_hasvariable( 'Search', 'ExcludeClasses', 'search.ini' )}
			 {set $exc_classes=ezini( 'Search', 'ExcludeClasses', 'search.ini' )}
		{/if}
		{if and( $exc_classes, $exc_classes|count )}
			{def $all_classes=fetch('class', 'list') }
			{set $inc_classes=array()}
			{foreach $all_classes as $class}
				{if $exc_classes|contains($class.id)|not}
					{set $inc_classes=$inc_classes|append($class.id)}
				{/if}
			{/foreach}
		{/if}
	{/if}
	{if $search_subtree_array|count|not}
		{set $search_subtree_array=array(2)}
	{/if}
    {set page_limit=10}
    {set search=fetch(content,search,
                      hash(text,$search_text,
                           section_id,$search_section_id,
                           class_id,$inc_classes,
                           subtree_array,$search_subtree_array,
                           sort_by,array('modified',false()),
                           offset,$view_parameters.offset,
                           limit,$page_limit))}
    {set search_result=$search['SearchResult']}
    {set search_count=$search['SearchCount']}
    {set stop_word_array=$search['StopWordArray']}
    {set search_data=$search}
{/section}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-search">

<form action={"/content/search/"|ezurl} method="get">

<div class="attribute-header">
    <h1 class="long">{"Search"|i18n("design/ezwebin/content/search")}</h1>
</div>

<p>
    <input class="halfbox" type="text" size="20" name="SearchText" id="Search" value="{$search_text|wash}" />
    <input class="button" name="SearchButton" type="submit" value="{'Search'|i18n('design/ezwebin/content/search')}" />
</p>

    {let adv_url=concat('/content/advancedsearch/',$search_text|count_chars()|gt(0)|choose('',concat('?SearchText=',$search_text|urlencode)))|ezurl}
    <label>{"For more options try the %1Advanced search%2"|i18n("design/ezwebin/content/search","The parameters are link start and end tags.",array(concat("<a href=",$adv_url,">"),"</a>"))}</label>
    {/let}

{section show=$stop_word_array}
    <p>
    {"The following words were excluded from the search:"|i18n("design/ezwebin/content/search")}:
    {section name=StopWord loop=$stop_word_array}
        {$StopWord:item.word|wash}
        {delimiter}, {/delimiter}
    {/section}
    </p>
{/section}

{switch name=Sw match=$search_count}
  {case match=0}
  <div class="warning">
  <h2>{'No results were found when searching for "%1".'|i18n("design/ezwebin/content/search",,array($search_text|wash))}</h2>
  </div>
    <p>{'Search tips'|i18n('design/ezwebin/content/search')}</p>
    <ul>
        <li>{'Check spelling of keywords.'|i18n('design/ezwebin/content/search')}</li>
        <li>{'Try changing some keywords (eg, "car" instead of "cars").'|i18n('design/ezwebin/content/search')}</li>
        <li>{'Try searching with less specific keywords.'|i18n('design/ezwebin/content/search')}</li>
        <li>{'Reduce number of keywords to get more results.'|i18n('design/ezwebin/content/search')}</li>
    </ul>
  {/case}
  {case}
  <div class="feedback">
  <h2>{'Search for "%1" returned %2 matches'|i18n("design/ezwebin/content/search",,array($search_text|wash,$search_count))}</h2>
  </div>
  {/case}
{/switch}

{section name=SearchResult loop=$search_result show=$search_result sequence=array(bglight,bgdark)}
   {node_view_gui view=line sequence=$:sequence use_url_translation=$use_url_translation content_node=$:item}
{/section}

{include name=Navigator
         uri='design:navigator/google.tpl'
         page_uri='/content/search'
         page_uri_suffix=concat('?SearchText=',$search_text|urlencode,$search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)))
         item_count=$search_count
         view_parameters=$view_parameters
         item_limit=$page_limit}

</form>

</div>


</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

{/let}