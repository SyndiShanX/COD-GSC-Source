/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_dog_interface.gsc
***********************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\zm\ai\zm_ai_dog;

#namespace zm_ai_dog_interface;

registerzombiedoginterfaceattributes() {
  ai::registermatchedinterface(#"zombie_dog", #"gravity", "normal", array("low", "normal"), &zm_ai_dog::zombiedoggravity);
  ai::registermatchedinterface(#"zombie_dog", #"min_run_dist", 500);
  ai::registermatchedinterface(#"zombie_dog", #"sprint", 0, array(1, 0));
  ai::registermatchedinterface(#"zombie_dog", #"patrol", 0, array(1, 0));
}