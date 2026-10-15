/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_gladiator_interface.gsc
***********************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\zm\ai\zm_ai_gladiator;

#namespace zm_ai_gladiator_interface;

registergladiatorinterfaceattributes() {
  ai::registermatchedinterface(#"gladiator", #"run", 0, array(1, 0));
  ai::registermatchedinterface(#"gladiator", #"axe_throw", 1, array(1, 0));
  ai::registernumericinterface(#"gladiator", #"damage_multiplier", 1, 0, 100);
}