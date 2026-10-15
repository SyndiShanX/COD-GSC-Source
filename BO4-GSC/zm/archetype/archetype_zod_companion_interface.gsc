/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\archetype\archetype_zod_companion_interface.gsc
**************************************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\zm\archetype\archetype_zod_companion;

#namespace zodcompanioninterface;

registerzodcompanioninterfaceattributes() {
  ai::registermatchedinterface(#"zod_companion", #"sprint", 0, array(1, 0));
}