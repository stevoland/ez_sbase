{def $custom_templates = ezini( 'CustomTemplateSettings', 'CustomEditTemplateList', 'websitetoolbar.ini' ) }

<!-- eZ website toolbar: START -->
{include uri='design:parts/websitetoolbar/styles.tpl'}

<div id="ezwt">
<div class="tl"><div class="tr"><div class="tc"></div></div></div>
<div class="mc"><div class="ml"><div class="mr float-break">

<!-- eZ website toolbar content: START -->

{include uri='design:parts/websitetoolbar/logo.tpl'}

<div id="ezwt-standardactions" class="left">

    <input type="image" src={"websitetoolbar/ezwt-icon-publish.gif"|ezimage} name="PublishButton" title="{'Send for publishing'|i18n('design/ezwebin/content/edit')}" />

    <input type="image" src={"websitetoolbar/ezwt-icon-versions.gif"|ezimage} name="VersionsButton" title="{'Manage versions'|i18n('design/ezwebin/content/edit')}" />

    <input type="image" src={"websitetoolbar/ezwt-icon-exit.gif"|ezimage} name="StoreExitButton" title="{'Store and exit'|i18n( 'design/ezwebin/content/edit' )}" />

    <input type="image" src={"websitetoolbar/ezwt-icon-preview.gif"|ezimage} name="PreviewButton" title="{'Preview'|i18n('design/ezwebin/content/edit')}" />

{def $langs=ezini('RegionalSettings', 'SiteLanguageList', 'site.ini') }
{if $langs|count|gt(1) }
<select name="FromLanguage">
<option value=""{if $from_language|not} selected="selected"{/if}> {'Translate from'|i18n( 'design/ezwebin/content/edit' )}</option>

{if $object.status}
{foreach $object.languages as $lang}
<option value="{$lang.locale}"{if $lang.locale|eq($from_language)} selected="selected"{/if}>
{$lang.name|wash}
</option>
{/foreach}
{/if}
</select>

{if $object.status|eq(0)}
    <input disabled="disabled" type="image" src={"websitetoolbar/ezwt-icon-add_translation-disabled.gif"|ezimage} name="FromLanguageButton" title="{'Translate'|i18n( 'design/ezwebin/content/edit' )}" />
{else}
    <input type="image" src={"websitetoolbar/ezwt-icon-add_translation.gif"|ezimage} name="FromLanguageButton" title="{'Translate'|i18n( 'design/ezwebin/content/edit' )}" />
{/if}

{/if}


</div>

{* Custom templates inclusion *}
{foreach $custom_templates as $custom_template}
    {include uri=concat( 'design:parts/websitetoolbar/', $custom_template, '.tpl' )}
{/foreach}

{include uri='design:parts/websitetoolbar/help.tpl'}

<!-- eZ website toolbar content: END -->

</div></div></div>
<div class="bl"><div class="br"><div class="bc"></div></div></div>
</div>

<!-- eZ website toolbar: END -->