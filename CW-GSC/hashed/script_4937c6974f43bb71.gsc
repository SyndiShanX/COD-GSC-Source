/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4937c6974f43bb71.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#namespace namespace_82bfe441;

function fade(var_564144a4, var_b8e08e16 = "FadeImmediate", var_ee0e1f8 = 0) {
  globallogic_ui::function_9ed5232e("hudItems.cpHudFadeControl.fadeSpeed", var_b8e08e16);
  globallogic_ui::function_9ed5232e("hudItems.cpHudFadeControl.customFadeSpeed", var_ee0e1f8);
  globallogic_ui::function_9ed5232e("hudItems.cpHudFadeControl.doFadeOut", var_564144a4);
}