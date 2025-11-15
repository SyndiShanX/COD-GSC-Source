/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_gegenees_interface.gsc
***********************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\zm\ai\zm_ai_gegenees;

#namespace zm_ai_gegenees_interface;

registergegeneesinterfaceattributes() {
  ai::registermatchedinterface(#"gegenees", #"run", 0, array(1, 0));
  ai::registernumericinterface(#"gegenees", #"damage_multiplier", 1, 0, 100);
}