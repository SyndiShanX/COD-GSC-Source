/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_civilian_interface.gsc
***********************************************************/

#include scripts\core_common\ai\archetype_civilian;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\ai_interface;

#namespace civilianinterface;

registercivilianinterfaceattributes() {
  ai::registermatchedinterface(#"civilian", #"disablearrivals", 0, array(1, 0), &aiutility::arrivalattributescallback);
  ai::registermatchedinterface(#"civilian", #"_civ_mode", "calm", array("calm", "panic", "riot", "run"));
  ai::registermatchedinterface(#"civilian", #"auto_escape", 1, array(1, 0));
  ai::registermatchedinterface(#"civilian", #"auto_wander", 1, array(1, 0));
  ai::registermatchedinterface(#"civilian", #"usegrenades", 1, array(1, 0));
  ai::registerentityinterface(#"civilian", #"follow", undefined, &archetypecivilian::function_49d80e54);
}