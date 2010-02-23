<?php /*#?ini charset="utf-8"?
# eZ publish configuration file for the eZ Online Editor



[EditorSettings]

# Friendly name for tags, is shown in status bar and dialogs
XmlTagNameAlias[]
XmlTagNameAlias[th]=table header
XmlTagNameAlias[td]=table cell
XmlTagNameAlias[tr]=table row
XmlTagNameAlias[ul]=unordered list
XmlTagNameAlias[ol]=ordered list
XmlTagNameAlias[li]=list item



[SpellChecker]
# Settings for TinyMCE SpellChecker
# You need to enable the spellchecker plugin before these settings have any effect
# Wiki: http://wiki.moxiecode.com/index.php/TinyMCE:Plugins/spellchecker
config[]
config[general.engine]=GoogleSpell

// PSpell settings
#config[general.engine]=PSpell
#config[PSpell.spelling]=
#config[PSpell.jargon]=
#config[PSpell.encoding]=

# PSpellShell settings
#config[general.engine]=PSpellShell
#config[PSpellShell.aspell]=/usr/bin/aspell
#config[PSpellShell.tmp]=/tmp

# Windows PSpellShell settings
#config[general.engine]=PSpellShell
#config[PSpellShell.aspell]="c:\Program Files\Aspell\bin\aspell.exe"
#config[PSpellShell.tmp]=c:/temp




# Settings for the js / css packer included in OE
# The Packer lets you define custom functions that can generate CSS or JS dynamically
# Here is an example of setting up such a function:
#
#[Packer_<custom_packer>]
## Optional, uses <custom_packer> as class name if not set
#Class=MyCustomJsGeneratorClass
## Optional, uses autoload system if not defined
#File=extension/ezoe/classes/mycustomjsgenerator.php
#
# Definition of use in template:
# {ezoescript('<custom_packer>::<funtion_name>[::arg1]')}
#
# See in extension/ezoe/autoloads/ezoepackerfunctions.php for more info on how
# to set up the php part!
#
# eZOEPackerFunctions::i18n included in ezoe is used to generate translation strings
# automatically to a json format that TinyMCE can understand.


[Packer_ezoe]
Class=eZOEPackerFunctions
File=extension/ezoe/classes/ezoepackerfunctions.php

*/ ?>