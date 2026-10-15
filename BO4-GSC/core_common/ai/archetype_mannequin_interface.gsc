/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_mannequin_interface.gsc
************************************************************/

#include scripts\core_common\ai\systems\ai_interface;

#namespace mannequininterface;

registermannequininterfaceattributes() {
  ai::registermatchedinterface(#"mannequin", #"can_juke", 0, array(1, 0));
  ai::registermatchedinterface(#"mannequin", #"suicidal_behavior", 0, array(1, 0));
  ai::registermatchedinterface(#"mannequin", #"spark_behavior", 0, array(1, 0));
}