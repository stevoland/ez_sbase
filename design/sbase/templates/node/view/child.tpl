<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-child">
    <div class="{include uri='design:parts/full/cssclasses.tpl'}">

    <div class="attribute-header">
        <h1><a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">{$node.name|wash()}</a></h1>
    </div>

    {*
     This is a general full view template
     It is intended to accelerate web development by elimineting the need to create templates for simple classes
     It probes the name_pattern for attributes and has some pre set attributes that are hidden
     The output are quite stylable, so you can do visual modifications with css

     The pre set optional attributes are:
     'enable_comments' a checkbox to indicates if you want to enable comments or not
     'enable_tipafriend' a checkbox to indicates if you want to enable tipp a friend or not
     'show_children' a checkbox to indicates if you want to show children or not
     'show_children_exclude' a text_line with classes you want to exclude, like: 'article,infobox,folder'
     'show_children_pr_page' a Integer with the number of children you want to show pr page
    *}

    {def $name_pattern = $node.object.content_class.contentobject_name|explode('>')|implode(',')
         $name_pattern_array = array('enable_comments', 'enable_tipafriend', 'show_children', 'show_children_exclude', 'show_children_pr_page')}
    {set $name_pattern  = $name_pattern|explode('|')|implode(',')}
    {set $name_pattern  = $name_pattern|explode('<')|implode(',')}
    {set $name_pattern  = $name_pattern|explode(',')}
    {foreach $name_pattern  as $name_pattern_string}
        {set $name_pattern_array = $name_pattern_array|append( $name_pattern_string|trim() )}
    {/foreach}

        {foreach $node.object.contentobject_attributes as $attribute}
        {if $name_pattern_array|contains($attribute.contentclass_attribute_identifier)|not()}
                {if $attribute.contentclass_attribute_identifier|begins_with('design_')}
                {elseif $attribute.data_type_string|eq('xrowmetadata')}
                {else}
            <div class="attribute-{$attribute.contentclass_attribute_identifier} ezccadt-{$attribute.data_type_string}">
                {attribute_view_gui attribute=$attribute}
            </div>
            {/if}
        {/if}
    {/foreach}
    
    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
