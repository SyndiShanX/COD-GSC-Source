/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_stoker_interface.gsc
*********************************************************/

#include scripts\core_common\ai\archetype_stoker;
#include scripts\core_common\ai\systems\ai_interface;

#namespace stokerinterface;

registerstokerinterfaceattributes() {
  ai::registermatchedinterface(#"stoker", #"gravity", "normal", array("low", "normal"), &archetype_stoker::function_e4ef4e27);
}