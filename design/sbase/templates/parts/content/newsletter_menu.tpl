{def $types=fetch('newsletter', 'newsletter_type_list')}

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h4>{'Newslettertypes'|i18n( 'design/eznewsletter/parts/eznewsletter_menu' )}</h4>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">

{if $types|count}
<ul>
{foreach $types as $type}
	<li><div><a href={concat('newsletter/list_type/', $type.id)|ezurl}>{$type.name|wash}</a>
		<ul>
			<li><a class="nodetext" href={concat('newsletter/list_inprogress/',$type.id)|ezurl} title="{$type.id} - {'In progress'|i18n( 'design/eznewsletter/contentstructuremenu' )}">{'In progress'|i18n( 'design/eznewsletter/contentstructuremenu' )}</a></li>
			<li><a class="nodetext" href={concat('newsletter/list_recurring/',$type.id)|ezurl} title="{$type.id} - {'Recurring'|i18n( 'design/eznewsletter/contentstructuremenu' )}">{'Recurring'|i18n( 'design/eznewsletter/contentstructuremenu' )}</a></li>
		</ul>
	</div></li>
{/foreach}
</ul>
{/if}

{* DESIGN: Content END *}</div></div></div></div></div></div>