/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_zombie_interface.gsc
*********************************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\zombie;

#namespace zombieinterface;

registerzombieinterfaceattributes() {
  ai::registermatchedinterface(#"zombie", #"can_juke", 0, array(1, 0));
  ai::registermatchedinterface(#"zombie", #"suicidal_behavior", 0, array(1, 0));
  ai::registermatchedinterface(#"zombie", #"spark_behavior", 0, array(1, 0));
  ai::registermatchedinterface(#"zombie", #"use_attackable", 0, array(1, 0));
  ai::registermatchedinterface(#"zombie", #"gravity", "normal", array("low", "normal"), &zombiebehavior::zombiegravity);
}