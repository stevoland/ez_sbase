{def $design_attributes=array()
     $metadata_attribute=false()}
     
{section var=attributes loop=$content_attributes}
{* Show view GUI if we can't edit, oterwise: show edit GUI. *}
{section show=and( eq( $attributes.item.can_translate, 0 ), ne( $object.initial_language_code, $attributes.item.language_code ) )}
    <div class="block ezcca-edit-datatype-{$attributes.item.data_type_string} ezcca-edit-{$attributes.item.contentclass_attribute_identifier}">
    <label>{$attributes.item.contentclass_attribute_name|wash}{section show=$attributes.item.can_translate|not} <span class="nontranslatable">({'Not translatable'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}:</label>
    {section show=$is_translating_content}
        <div class="original">
        {attribute_view_gui attribute_base=$attribute_base attribute=$attributes.item}
        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attributes.item.id}" />
        </div>
    {section-else}
        {attribute_view_gui attribute_base=$attribute_base attribute=$attributes.item}
        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attributes.item.id}" />
    {/section}
    </div>
{section-else}
    {section show=$is_translating_content}
    <div class="block ezcca-edit-datatype-{$attributes.item.data_type_string} ezcca-edit-{$attributes.item.contentclass_attribute_identifier}">
        <label{section show=$attributes.item.has_validation_error} class="message-error"{/section}>{$attributes.item.contentclass_attribute_name|wash}{section show=$attributes.item.is_required} <span class="required">({'Required'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}{section show=$attributes.item.is_information_collector} <span class="collector">({'Information collector'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}:</label>
        <div class="original">
        {attribute_view_gui attribute_base=$attribute_base attribute=$from_content_attributes[$attributes.key]}
        </div>
        <div class="translation">
        {section show=$attributes.display_info.edit.grouped_input}
            <fieldset>
            {attribute_edit_gui attribute_base=$attribute_base attribute=$attributes.item}
            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attributes.item.id}" />
            </fieldset>
        {section-else}
            {attribute_edit_gui attribute_base=$attribute_base attribute=$attributes.item}
            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attributes.item.id}" />
        {/section}
        </div>
    </div>
    {section-else}
        {* if $attributes.item.contentclass_attribute_identifier|begins_with('hidden_') *}
        {if $attributes.item.contentclass_attribute_identifier|begins_with('design_')}
            {append-block variable=$design_attributes}
                <div class="block ezcca-edit-datatype-{$attributes.item.data_type_string} ezcca-edit-{$attributes.item.contentclass_attribute_identifier}">
                {section show=$attributes.display_info.edit.grouped_input}
                    <fieldset>
                    <legend{section show=$attributes.item.has_validation_error} class="message-error"{/section}>{$attributes.item.contentclass_attribute_name|wash}{section show=$attributes.item.is_required} <span class="required">({'Required'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}{section show=$attributes.item.is_information_collector} <span class="collector">({'Information collector'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}</legend>
                    {attribute_edit_gui attribute_base=$attribute_base attribute=$attributes.item}
                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attributes.item.id}" />
                    </fieldset>
                {section-else}
                    <label{section show=$attributes.item.has_validation_error} class="message-error"{/section}>{$attributes.item.contentclass_attribute_name|wash}{section show=$attributes.item.is_required} <span class="required">({'Required'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}{section show=$attributes.item.is_information_collector} <span class="collector">({'Information collector'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}:</label>
                    {attribute_edit_gui attribute_base=$attribute_base attribute=$attributes.item}
                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attributes.item.id}" />
                {/section}
                </div>
            {/append-block}
        {elseif $attributes.item.data_type_string|eq('xrowmetadata')}
            {set $metadata_attribute=$attributes.item}
        {else}
            <div class="block ezcca-edit-datatype-{$attributes.item.data_type_string} ezcca-edit-{$attributes.item.contentclass_attribute_identifier}">
            {section show=$attributes.display_info.edit.grouped_input}
                <fieldset>
                <legend{section show=$attributes.item.has_validation_error} class="message-error"{/section}>{$attributes.item.contentclass_attribute_name|wash}{section show=$attributes.item.is_required} <span class="required">({'Required'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}{section show=$attributes.item.is_information_collector} <span class="collector">({'Information collector'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}</legend>
                {attribute_edit_gui attribute_base=$attribute_base attribute=$attributes.item}
                <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attributes.item.id}" />
                </fieldset>
            {section-else}
                <label{section show=$attributes.item.has_validation_error} class="message-error"{/section}>{$attributes.item.contentclass_attribute_name|wash}{section show=$attributes.item.is_required} <span class="required">({'Required'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}{section show=$attributes.item.is_information_collector} <span class="collector">({'Information collector'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}:</label>
                {attribute_edit_gui attribute_base=$attribute_base attribute=$attributes.item}
                <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attributes.item.id}" />
            {/section}
            </div>
        {/if}
    {/section}
{/section}

{/section}

{if $design_attributes|count}
    <fieldset>
        <legend>Design</legend>
{foreach $design_attributes as $html}
    {$html}
{/foreach}
    </fieldset>
{/if}

{if $metadata_attribute}
<div class="block ezcca-edit-datatype-{$metadata_attribute.data_type_string} ezcca-edit-{$metadata_attribute.contentclass_attribute_identifier}">
    <fieldset>
        <legend{section show=$metadata_attribute.has_validation_error} class="message-error"{/section}>{$metadata_attribute.contentclass_attribute_name|wash}{section show=$metadata_attribute.is_required} <span class="required">({'Required'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}{section show=$metadata_attribute.is_information_collector} <span class="collector">({'Information collector'|i18n( 'design/ezwebin/content/edit_attribute' )})</span>{/section}</legend>
        {attribute_edit_gui attribute_base=$attribute_base attribute=$metadata_attribute}
        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$metadata_attribute.id}" />
    </fieldset>
</div>
{/if}
