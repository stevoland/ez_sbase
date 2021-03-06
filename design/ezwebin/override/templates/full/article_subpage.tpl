{* Article (sub-page) - Full view *}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="{include uri='design:parts/full/cssclasses.tpl' class_name='article-mainpage'}">

        <div class="attribute-header">
            <h1>{$node.data_map.title.content|wash()}</h1>
        </div>

        <div class="attribute-byline">
        {if $node.parent.data_map.author.content.is_empty|not()}
        <p class="author">
             {attribute_view_gui attribute=$node.parent.data_map.author}
        </p>
        {/if}
        <p class="date">
             {$node.parent.object.published|l10n(shortdatetime)}
        </p>
        </div>

        {include uri='design:parts/article/article_index.tpl' used_node=$node.parent}

        {if $node.data_map.body.content.is_empty|not}
            <div class="attribute-long">
                {attribute_view_gui attribute=$node.data_map.body}
            </div>
        {/if}

        {include uri='design:parts/article/page_navigator.tpl' used_node=$node.parent}

        {include uri='design:parts/full/show_comments.tpl'}

        {include uri='design:parts/full/show_tipafriend.tpl'}

    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>