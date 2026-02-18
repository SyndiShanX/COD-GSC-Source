/*********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_brutus_interface.gsc
*********************************************************/

#using scripts\core_common\ai\archetype_brutus;
#using scripts\core_common\ai\systems\ai_interface;
#namespace brutusinterface;

function registerbrutusinterfaceattributes() {
  ai::registermatchedinterface(#"brutus", #"can_ground_slam", 0, array(1, 0));
  ai::registermatchedinterface(#"brutus", #"scripted_mode", 0, array(1, 0), &archetypebrutus::function_f8aa76ea);
  ai::registermatchedinterface(#"brutus", #"patrol", 0, array(1, 0));
}