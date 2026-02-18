/***********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_civilian_interface.gsc
***********************************************************/

#using scripts\core_common\ai\archetype_civilian;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_interface;
#namespace civilianinterface;

function registercivilianinterfaceattributes() {
  ai::registermatchedinterface(#"civilian", #"disablearrivals", 0, array(1, 0), &aiutility::arrivalattributescallback);
  ai::registermatchedinterface(#"civilian", #"_civ_mode", "calm", array("calm", "panic", "riot", "run"));
  ai::registermatchedinterface(#"civilian", #"auto_escape", 1, array(1, 0));
  ai::registermatchedinterface(#"civilian", #"auto_wander", 0, array(1, 0));
  ai::registermatchedinterface(#"civilian", #"usegrenades", 1, array(1, 0));
  ai::registerentityinterface(#"civilian", #"follow", undefined, &archetypecivilian::function_49d80e54);
  ai::registermatchedinterface(#"civilian", #"stealth", 0, array(1, 0));
  ai::registermatchedinterface(#"civilian", #"coveridleonly", 0, array(1, 0));
}