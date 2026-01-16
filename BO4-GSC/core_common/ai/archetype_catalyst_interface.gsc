/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_catalyst_interface.gsc
***********************************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\zombie;

#namespace catalystinterface;

registercatalystinterfaceattributes() {
  ai::registermatchedinterface(#"catalyst", #"gravity", "normal", array("low", "normal"), &zombiebehavior::zombiegravity);
}