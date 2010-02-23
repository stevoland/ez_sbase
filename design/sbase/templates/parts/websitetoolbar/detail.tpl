{if $module_result.content_info.viewmode|ne('full') }
    <a href={concat('/content/view/full/',$module_result.node_id)|ezurl} title="{'Normal view'|i18n('extension/base')}" class="ezwt-left ezwt-detail"><img src={"websitetoolbar/ezwt-icon-detail.gif"|ezimage} alt="{'Switch'|i18n('extension/base')}" /></a>
{else}
    <a href={concat('/content/view/detail/',$module_result.node_id)|ezurl} title="{'Detailed view'|i18n('extension/base')}" class="ezwt-left ezwt-detail"><img src={"websitetoolbar/ezwt-icon-detail.gif"|ezimage} alt="{'Switch'|i18n('extension/base')}" /></a>
{/if}
