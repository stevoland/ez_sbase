{def $multilingual_site=fetch( content, translation_list )|count|gt( 1 )}

<script type="text/javascript">
<!--
var menuArray = new Array();
menuArray['ContextMenu'] = new Array();
menuArray['ContextMenu']['depth'] = 0;
menuArray['ContextMenu']['headerID'] = 'menu-header';
menuArray['ContextMenu']['elements'] = new Array();
menuArray['ContextMenu']['elements']['menu-view'] = new Array();
menuArray['ContextMenu']['elements']['menu-view']['url'] = {"/content/view/full/%nodeID%"|ezurl};
menuArray['ContextMenu']['elements']['menu-edit'] = new Array();
menuArray['ContextMenu']['elements']['menu-edit']['url'] = {"/content/edit/%objectID%"|ezurl};
menuArray['ContextMenu']['elements']['menu-copy'] = new Array();
menuArray['ContextMenu']['elements']['menu-copy']['url'] = {"/content/copy/%objectID%"|ezurl};
menuArray['ContextMenu']['elements']['menu-copy-subtree']= new Array();
menuArray['ContextMenu']['elements']['menu-copy-subtree']['url'] = {"/content/copysubtree/%nodeID%"|ezurl};
menuArray['ContextMenu']['elements']['menu-create-here']= new Array();
menuArray['ContextMenu']['elements']['menu-create-here']['disabled_class'] = 'menu-item-disabled';

{*menuArray['ContextMenu']['elements']['child-menu-create-here'] = new Array();
menuArray['ContextMenu']['elements']['child-menu-create-here']['disabled_class'] = 'menu-item-disabled';*}

{* Edit menu *}
menuArray['EditSubmenu'] = new Array();
menuArray['EditSubmenu']['depth'] = 1;
menuArray['EditSubmenu']['elements'] = new Array();
menuArray['EditSubmenu']['elements']['edit-languages'] = new Array();
menuArray['EditSubmenu']['elements']['edit-languages']['variable'] = '%languages%';
menuArray['EditSubmenu']['elements']['edit-languages']['content'] = '<a href={"/content/edit/%objectID%/f/%locale%"|ezurl} onmouseover="ezpopmenu_mouseOver( \'EditSubmenu\' )">%name%<\/a>';
menuArray['EditSubmenu']['elements']['edit-languages-another'] = new Array();
menuArray['EditSubmenu']['elements']['edit-languages-another']['url'] = {"/content/edit/%objectID%/a"|ezurl};

{* CreateHere menu *}
menuArray['CreateHereMenu'] = new Array();
menuArray['CreateHereMenu']['depth'] = 1; // this is a first level submenu of ContextMenu
menuArray['CreateHereMenu']['elements'] = new Array();
menuArray['CreateHereMenu']['elements']['menu-classes'] = new Array();
menuArray['CreateHereMenu']['elements']['menu-classes']['variable'] = '%classList%';
menuArray['CreateHereMenu']['elements']['menu-classes']['content'] = '<a id="menu-item-create-here" href="#" onclick="ezpopmenu_submitForm( \'menu-form-create-here\', new Array( \'classID\', \'%classID%\' ) ); return false;">%name%<\/a>';

{* Advanced menu *}
menuArray['Advanced'] = new Array();
menuArray['Advanced']['depth'] = 1; // this is a first level submenu of ContextMenu
menuArray['Advanced']['elements'] = new Array();
menuArray['Advanced']['elements']['menu-hide'] = new Array();
menuArray['Advanced']['elements']['menu-hide']['url'] = {"/content/hide/%nodeID%"|ezurl};
menuArray['Advanced']['elements']['menu-list'] = new Array();
menuArray['Advanced']['elements']['menu-list']['url'] = {"content/view/sitemap/%nodeID%"|ezurl};

menuArray['Advanced']['elements']['menu-history'] = new Array();
menuArray['Advanced']['elements']['menu-history']['url'] = {"content/history/%objectID%"|ezurl};
menuArray['Advanced']['elements']['menu-url-alias'] = new Array();
menuArray['Advanced']['elements']['menu-url-alias']['url'] = {"content/urlalias/%nodeID%"|ezurl};

menuArray['SubitemsContextMenu'] = new Array();
menuArray['SubitemsContextMenu']['depth'] = 0;
menuArray['SubitemsContextMenu']['headerID'] = 'child-menu-header';
menuArray['SubitemsContextMenu']['elements'] = new Array();
menuArray['SubitemsContextMenu']['elements']['child-menu-view'] = new Array();
menuArray['SubitemsContextMenu']['elements']['child-menu-view']['url'] = {"/content/view/full/%nodeID%"|ezurl};
menuArray['SubitemsContextMenu']['elements']['child-menu-edit'] = new Array();
menuArray['SubitemsContextMenu']['elements']['child-menu-edit']['url'] = {"/content/edit/%objectID%"|ezurl};
menuArray['SubitemsContextMenu']['elements']['child-menu-copy'] = new Array();
menuArray['SubitemsContextMenu']['elements']['child-menu-copy']['url'] = {"/content/copy/%objectID%"|ezurl};
menuArray['SubitemsContextMenu']['elements']['child-menu-copy-subtree'] = new Array();
menuArray['SubitemsContextMenu']['elements']['child-menu-copy-subtree']['url'] = {"/content/copysubtree/%nodeID%"|ezurl};
menuArray['SubitemsContextMenu']['elements']['child-menu-create-here'] = new Array();
menuArray['SubitemsContextMenu']['elements']['child-menu-create-here']['disabled_class'] = 'menu-item-disabled';



// -->
</script>

{ezscript( array(
		'lib/ezjslibdomsupport.js',
		'lib/ezjslibmousetracker.js',
		'popupmenu/ezpopupmenu.js'), 'text/javascript', '' )}

<!-- Treemenu icon click popup menu -->
<div class="popupmenu" id="ContextMenu">
    <div class="popupmenuheader"><h3 id="menu-header">XXX</h3>
        <div class="break"></div>
    </div>
    <a id="menu-view" href="#" onmouseover="ezpopmenu_mouseOver( 'ContextMenu' )">{"View"|i18n("design/admin/popupmenu")}</a>
{if $multilingual_site}
    <a id="menu-edit-in" class="more" href="#" onmouseover="ezpopmenu_showSubLevel( event, 'EditSubmenu', 'menu-edit-in' ); return false;">{'Edit in'|i18n( 'design/admin/popupmenu' )}</a>
{else}
    <a id="menu-edit" href="#" onmouseover="ezpopmenu_mouseOver( 'ContextMenu' )">{"Edit"|i18n("design/admin/popupmenu")}</a>
{/if}
    <hr />
    <a id="menu-copy" href="#" onmouseover="ezpopmenu_mouseOver( 'ContextMenu' )">{"Copy"|i18n("design/admin/popupmenu")}</a>
    <a id="menu-copy-subtree" href="#" onmouseover="ezpopmenu_mouseOver( 'ContextMenu' )">{"Copy subtree"|i18n("design/admin/popupmenu")}</a>
    <a id="menu-move" href="#" onmouseover="ezpopmenu_mouseOver( 'ContextMenu' )" onclick="ezpopmenu_submitForm( 'menu-form-move' ); return false;">{"Move"|i18n("design/admin/popupmenu")}</a>
    <a id="menu-remove" href="#" onmouseover="ezpopmenu_mouseOver( 'ContextMenu' )" onclick="ezpopmenu_submitForm( 'menu-form-remove' ); return false;">{"Remove"|i18n("design/admin/popupmenu")}</a>
    <a id="menu-advanced" class="more" href="#" onmouseover="ezpopmenu_showSubLevel( event, 'Advanced', 'menu-advanced' ); return false;">{'Advanced'|i18n( 'design/admin/popupmenu' )}</a>
    <hr />
{if ezini('TreeMenu','Dynamic','contentstructuremenu.ini')|ne('enabled')}
    <a id="menu-expand" href="#" onmouseover="ezpopmenu_mouseOver( 'ContextMenu' )"
       onclick="ezcst_expandSubtree( CurrentSubstituteValues['%nodeID%'] ); ezpopmenu_hideAll(); return false;">{"Expand"|i18n("design/admin/popupmenu")}</a>
    <a id="menu-collapse" href="#" onmouseover="ezpopmenu_mouseOver( 'ContextMenu' )"
       onclick="ezcst_collapseSubtree( CurrentSubstituteValues['%nodeID%'] ); ezpopmenu_hideAll(); return false;">{"Collapse"|i18n("design/admin/popupmenu")}</a>
{else}
    <a id="menu-collapse" href="#" onmouseover="ezpopmenu_mouseOver( 'ContextMenu' )"
       onclick="treeMenu.collapse( CurrentSubstituteValues['%nodeID%'] ); ezpopmenu_hideAll(); return false;">{"Collapse"|i18n("design/admin/popupmenu")}</a>
{/if}
    <hr />
    <a id="menu-notify" href="#" onmouseover="ezpopmenu_mouseOver( 'ContextMenu' )"
       onclick="ezpopmenu_submitForm( 'menu-form-notify' ); return false;">{"Add to my notifications"|i18n("design/admin/popupmenu")}</a>

    <a id="menu-create-here" class="more" href="#" onmouseover="ezpopmenu_showSubLevel( event, 'CreateHereMenu', 'menu-create-here' ); return false;">{'Create here'|i18n( 'design/admin/popupmenu' )}</a>

    {* Include additional context menu items  based on .ini settings *}
    {section var=template loop=ezini( 'AdditionalMenuSettings', 'ContextMenuTemplateArray', 'admininterface.ini' )}
        {include uri=concat('design:', $template )}
    {/section}
</div>

<!-- Subitems icon click popup menu -->
<div class="popupmenu" id="SubitemsContextMenu">
    <div class="popupmenuheader"><h3 id="child-menu-header">XXX</h3>
{*        <div class="window-close" onclick="ezpopmenu_hide( 'SubitemsContextMenu' )"><p>X</p></div> *}
        <div class="break"></div>
    </div>
    <a id="child-menu-view" href="#" onmouseover="ezpopmenu_mouseOver( 'SubitemsContextMenu' )">{"View"|i18n("design/admin/popupmenu")}</a>
{if $multilingual_site}
    <a id="child-menu-edit-in" class="more" href="#" onmouseover="ezpopmenu_showSubLevel( event, 'EditSubmenu', 'child-menu-edit-in' ); return false;">{'Edit in'|i18n( 'design/admin/popupmenu' )}</a>
{else}
    <a id="child-menu-edit" href="#" onmouseover="ezpopmenu_mouseOver( 'SubitemsContextMenu' )">{"Edit"|i18n("design/admin/popupmenu")}</a>
{/if}
    <hr />
    <a id="child-menu-copy" href="#" onmouseover="ezpopmenu_mouseOver( 'SubitemsContextMenu' )">{"Copy"|i18n("design/admin/popupmenu")}</a>
    <a id="child-menu-copy-subtree" href="#" onmouseover="ezpopmenu_mouseOver( 'SubitemsContextMenu' )">{"Copy subtree"|i18n("design/admin/popupmenu")}</a>
    <a id="child-menu-move" href="#" onmouseover="ezpopmenu_mouseOver( 'SubitemsContextMenu' )"
       onclick="ezpopmenu_submitForm( 'menu-form-move' ); return false;">{"Move"|i18n("design/admin/popupmenu")}</a>
    <a id="child-menu-remove" href="#" onmouseover="ezpopmenu_mouseOver( 'SubitemsContextMenu' )"
       onclick="ezpopmenu_submitForm( 'menu-form-remove' ); return false;">{"Remove"|i18n("design/admin/popupmenu")}</a>
    <a id="child-menu-advanced" class="more" href="#" onmouseover="ezpopmenu_showSubLevel( event, 'Advanced', 'child-menu-advanced' ); return false;">{'Advanced'|i18n( 'design/admin/popupmenu' )}</a>
    <hr />
    <a id="child-menu-notify" href="#" onmouseover="ezpopmenu_mouseOver( 'SubitemsContextMenu' )"
       onclick="ezpopmenu_submitForm( 'menu-form-notify' ); return false;">{"Add to my notifications"|i18n("design/admin/popupmenu")}</a>

    <a id="child-menu-create-here" class="more" href="#" onmouseover="ezpopmenu_showSubLevel( event, 'CreateHereMenu', 'child-menu-create-here' ); return false;">{'Create here'|i18n( 'design/admin/popupmenu' )}</a>

    {* Include additional subitems menu items  based on .ini settings *}
    {section var=template loop=ezini( 'AdditionalMenuSettings', 'SubitemsContextMenuTemplateArray', 'admininterface.ini' )}
        {include uri=concat('design:', $template )}
    {/section}
</div>

{* Include additional submenus based on .ini files *}
{section var=template loop=ezini( 'AdditionalMenuSettings', 'SubMenuTemplateArray', 'admininterface.ini' )}
   {include uri=concat('design:', $template )}
{/section}

<!-- Create here menu -->
<div class="popupmenu" id="CreateHereMenu">
    <div id="menu-classes"></div>
</div>

<!-- Edit menu -->
<div class="popupmenu" id="EditSubmenu">
    <div id="edit-languages"></div>
    <hr />
    <a id="edit-languages-another" href="#" onmouseover="ezpopmenu_mouseOver( 'EditSubmenu' )">{'Another language'|i18n( 'design/admin/popupmenu' )}</a>
</div>

<!-- Advanced menu -->
<div class="popupmenu" id="Advanced">
    <a id="menu-swap" href="#" onmouseover="ezpopmenu_mouseOver( 'Advanced' )" onclick="ezpopmenu_submitForm( 'menu-form-swap' ); return false;">{'Swap with another node'|i18n( 'design/admin/popupmenu' )}</a>
    <a id="menu-hide" href="#" onmouseover="ezpopmenu_mouseOver( 'Advanced' )">{'Hide / unhide'|i18n( 'design/admin/popupmenu' )}</a>
    <hr />
    <a id="menu-history" href="#" onmouseover="ezpopmenu_mouseOver( 'Advanced' )">{'Manage versions'|i18n( 'design/admin/popupmenu' )}</a>
    <a id="menu-url-alias" href="#" onmouseover="ezpopmenu_mouseOver( 'Advanced' )">{'Manage URL aliases'|i18n( 'design/admin/popupmenu' )}</a>
</div>


{* Forms used by the various elements *}

{* Create here. *}
<form id="menu-form-create-here" method="post" action={"/content/action"|ezurl}>
  <input type="hidden" name="NewButton" value="x" />
  <input type="hidden" name="ContentNodeID" value="%nodeID%" />
  <input type="hidden" name="NodeID" value="%nodeID%" />
  <input type="hidden" name="ContentObjectID" value="%objectID%" />
  <input type="hidden" name="ClassID" value="%classID%" />
  <input type="hidden" name="ViewMode" value="full" />
  <legend></legend>
  {*<input type="hidden" name="ContentLanguageCode" value="eng-GB" />*}
</form>

{* Add bookmark. *}
<form id="menu-form-addbookmark" method="post" action={"/content/action"|ezurl}>
  <input type="hidden" name="ContentNodeID" value="%nodeID%" />
  <input type="hidden" name="ActionAddToBookmarks" value="x" />
  <legend></legend>
</form>

{* Remove bookmark *}
<form id="menu-form-removebookmark" method="post" action={"/content/bookmark"|ezurl}>
  <input type="hidden" name="DeleteIDArray[]" value="%bookmarkID%" />
  <input type="hidden" name="RemoveButton" value="x" />
  <input type="hidden" name="NeedRedirectBack" value="x" />
  <legend></legend>
</form>

{* Remove node. *}
<form id="menu-form-remove" method="post" action={"/content/action"|ezurl}>
  <input type="hidden" name="TopLevelNode" value="%nodeID%" />
  <input type="hidden" name="ContentNodeID" value="%nodeID%" />
  <input type="hidden" name="ContentObjectID" value="%objectID%" />
  <input type="hidden" name="ActionRemove" value="x" />
  <legend></legend>
</form>

{* Move node. *}
<form id="menu-form-move" method="post" action={"/content/action"|ezurl}>
  <input type="hidden" name="TopLevelNode" value="%nodeID%" />
  <input type="hidden" name="ContentNodeID" value="%nodeID%" />
  <input type="hidden" name="ContentObjectID" value="%objectID%" />
  <input type="hidden" name="MoveNodeButton" value="x" />
  <legend></legend>
</form>

{* Swap node *}
<form id="menu-form-swap" method="post" action={"/content/action"|ezurl}>
  <input type="hidden" name="TopLevelNode" value="%nodeID%" />
  <input type="hidden" name="ContentNodeID" value="%nodeID%" />
  <input type="hidden" name="ContentObjectID" value="%objectID%" />
  <input type="hidden" name="SwapNodeButton" value="x" />
  <legend></legend>
</form>


{* Add to notifications. *}
<form id="menu-form-notify" method="post" action={"/content/action"|ezurl}>
  <input type="hidden" name="ContentNodeID" value="%nodeID%" />
  <input type="hidden" name="ActionAddToNotification" value="x" />
  <legend></legend>
</form>

{* Delete view cache for node. *}
<form id="menu-form-view-cache-delete" method="post" action={"/content/action"|ezurl}>
  <input type="hidden" name="NodeID" value="%nodeID%" />
  <input type="hidden" name="ObjectID" value="%objectID%" />
  <input type="hidden" name="CurrentURL" value="%currentURL%" />
  <input type="hidden" name="ClearViewCacheButton" value="x" />
  <legend></legend>
</form>

{* Delete view cache for subtree. *}
<form id="menu-form-recursive-view-cache-delete" method="post" action={"/content/action"|ezurl}>
  <input type="hidden" name="NodeID" value="%nodeID%" />
  <input type="hidden" name="ObjectID" value="%objectID%" />
  <input type="hidden" name="CurrentURL" value="%currentURL%" />
  <input type="hidden" name="ClearViewCacheSubtreeButton" value="x" />
  <legend></legend>
</form>
