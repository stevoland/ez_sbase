{set $pagestyle = concat('mode-', $mode, ' module-', $module_params.module_name, ' function-', $module_params.function_name ) }
 
{if and( is_set($module_result.content_info), is_set($module_result.content_info.viewmode) ) }
	{set $pagestyle=concat($pagestyle, ' viewmode-',$module_result.content_info.viewmode) }
{/if}
 
{if is_set($module_result.navigation_part) }
	{set $pagestyle=concat($pagestyle, ' navpart-', $module_result.navigation_part) }
{/if}
{if is_set($module_result.ui_context) }
	{set $pagestyle=concat($pagestyle, ' uicontext-', $module_result.ui_context) }
{/if}
{if is_set($module_result.ui_component) }
	{set $pagestyle=concat($pagestyle, ' uicomponent-', $module_result.ui_component) }
{/if}
{if and( is_set($pagedata.persistent_variable.no_wrapper), $pagedata.persistent_variable.no_wrapper ) }
	{set $pagestyle=concat($pagestyle, ' no-wrapper') }
{/if}
{set $pagestyle=concat($pagestyle, ' ', $pagedata.css_classes )}

{if is_set($pagedata.persistent_variable.css_classes) }
	{foreach $pagedata.persistent_variable.css_classes as $class}
		{set $pagestyle=concat($pagestyle, ' ', $class )}
	{/foreach}
{/if}