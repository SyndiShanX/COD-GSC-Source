/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_blight_father_interface.gsc
****************************************************************/

#include scripts\core_common\ai\archetype_blight_father;
#include scripts\core_common\ai\systems\ai_interface;

#namespace blightfatherinterface;

registerblightfatherinterfaceattributes() {
  ai::registermatchedinterface(#"blight_father", #"tongue_grab_enabled", 1, array(1, 0));
  ai::registermatchedinterface(#"blight_father", #"lockdown_enabled", 1, array(1, 0), &archetypeblightfather::function_b95978a7);
  ai::registermatchedinterface(#"blight_father", #"gravity", "normal", array("low", "normal"), &archetypeblightfather::function_3e8300e9);
}