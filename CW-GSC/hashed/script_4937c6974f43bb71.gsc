/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4937c6974f43bb71.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\cp_common\gametypes\globallogic_ui;

#namespace namespace_82bfe441;

function fade(dofadeout, fadespeed = "FadeImmediate", customfadespeed = 0) {
  globallogic_ui::function_9ed5232e("hudItems.cpHudFadeControl.fadeSpeed", fadespeed);
  globallogic_ui::function_9ed5232e("hudItems.cpHudFadeControl.customFadeSpeed", customfadespeed);
  globallogic_ui::function_9ed5232e("hudItems.cpHudFadeControl.doFadeOut", dofadeout);
}