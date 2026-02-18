/**************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\archetype\archetype_zod_companion_interface.gsc
**************************************************************/

#using scripts\core_common\ai\systems\ai_interface;
#using scripts\zm\archetype\archetype_zod_companion;
#namespace zodcompanioninterface;

function registerzodcompanioninterfaceattributes() {
  ai::registermatchedinterface(#"zod_companion", #"sprint", 0, array(1, 0));
}