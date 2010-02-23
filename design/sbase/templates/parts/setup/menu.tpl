{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h4>{'Setup'|i18n( 'design/admin/parts/setup/menu' )}</h4>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">

{section show=eq( $ui_context, 'edit' )}
<ul>
    <li><div><span class="disabled">{'Collected information'|i18n( 'design/admin/parts/setup/menu' )}</span>
        {if ezmodule('all2einfoexport')}
        <ul>
            <li><div><span class="disabled">{'Export'|i18n( 'design/admin/parts/setup/menu' )}</span></div></li>
        </ul>
        {/if}
        </div>
    </li>
    {if ezmodule('survey')}
        <li><div><span class="disabled">{'Surveys'|i18n( 'design/admin/parts/setup/menu' )}</span></div></li>
    {/if}
    {* if ezmodule('ezfind')}
        <li><div><span class="disabled">{'Search elevation'|i18n( 'design/admin/parts/setup/menu' )}</span></div></li>
    {/if *}
    <li><div><span class="disabled">{'Search statistics'|i18n( 'design/admin/parts/setup/menu' )}</span></div></li>
    <li><div><span class="disabled">{'Languages'|i18n( 'design/admin/parts/setup/menu' )}</span></div></li>
    <li><div><span class="disabled">{'URL management'|i18n( 'design/admin/parts/setup/menu' )}</span></div></li>
    <li><div><span class="disabled">{'URL translator'|i18n( 'design/admin/parts/setup/menu' )}</span></div></li>
    <li><div><span class="disabled">{'URL wildcards'|i18n( 'design/admin/parts/setup/menu' )}</span></div></li>
    <li><div><span class="disabled">{'RSS'|i18n( 'design/admin/parts/setup/menu' )}</a></span></li>
</ul>

{section-else}

<ul>
    <li><div><a href={'/infocollector/overview/'|ezurl}>{'Collected information'|i18n( 'design/admin/parts/setup/menu' )}</a>
        {if ezmodule('all2einfoexport')}
        <ul>
            <li><div><a href={'/all2einfoexport/select_export/'|ezurl}>{'Export'|i18n( 'design/admin/parts/setup/menu' )}</a></div></li>
        </ul>
        {/if}
    </div></li>
    {if ezmodule('survey')}
        <li><div><a href={'/survey/list/'|ezurl}>{'Surveys'|i18n( 'design/admin/parts/setup/menu' )}</a></div></li>
    {/if}
    {* if ezmodule('ezfind')}
        <li><div><a href={'/ezfind/elevate'|ezurl}>{'Search elevation'|i18n( 'design/admin/parts/setup/menu' )}</a></div></li>
    {/if *}
    <li><div><a href={'/search/stats/'|ezurl}>{'Search statistics'|i18n( 'design/admin/parts/setup/menu' )}</a></div></li>
    <li><div><a href={'/content/translations/'|ezurl}>{'Languages'|i18n( 'design/admin/parts/setup/menu' )}</a></div></li>
    <li><div><a href={'/url/list/'|ezurl}>{'URL management'|i18n( 'design/admin/parts/setup/menu' )}</a></div></li>
    <li><div><a href={'/content/urltranslator/'|ezurl}>{'URL translator'|i18n( 'design/admin/parts/setup/menu' )}</a></div></li>
    <li><div><a href={'/content/urlwildcards/'|ezurl}>{'URL wildcards'|i18n( 'design/admin/parts/setup/menu' )}</a></div></li>
    <li><div><a href={'/rss/list'|ezurl}>{'RSS'|i18n( 'design/admin/parts/setup/menu' )}</a></div></li>
</ul>

{/section}

{* DESIGN: Content END *}</div></div></div></div></div></div>