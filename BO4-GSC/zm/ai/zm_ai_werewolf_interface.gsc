/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_werewolf_interface.gsc
***********************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\zm\ai\zm_ai_werewolf;

#namespace zm_ai_werewolf_interface;

registerwerewolfinterfaceattributes() {
  ai::registermatchedinterface(#"werewolf", #"patrol", 0, array(1, 0), &zm_ai_werewolf::function_2341cdf0);
  ai::registermatchedinterface(#"werewolf", #"summon_wolves", 0, array(1, 0), &zm_ai_werewolf::function_2c67c3e1);
}