/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_tiger_interface.gsc
********************************************************/

#include scripts\core_common\ai\archetype_tiger;
#include scripts\core_common\ai\systems\ai_interface;

#namespace tigerinterface;

registertigerinterfaceattributes() {
  ai::registermatchedinterface(#"tiger", #"gravity", "normal", array("low", "normal"), &tigerbehavior::function_c0b7f4ce);
  ai::registermatchedinterface(#"tiger", #"min_run_dist", 500);
  ai::registermatchedinterface(#"tiger", #"sprint", 0, array(1, 0));
}