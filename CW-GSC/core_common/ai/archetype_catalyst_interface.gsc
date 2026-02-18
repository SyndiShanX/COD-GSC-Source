/***********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_catalyst_interface.gsc
***********************************************************/

#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\zombie;
#namespace catalystinterface;

function registercatalystinterfaceattributes() {
  ai::registermatchedinterface(#"catalyst", #"gravity", "normal", array("low", "normal"), &zombiebehavior::zombiegravity);
}