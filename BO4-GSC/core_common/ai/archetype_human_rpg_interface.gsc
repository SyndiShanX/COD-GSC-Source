/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_human_rpg_interface.gsc
************************************************************/

#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\ai_interface;

#namespace humanrpginterface;

registerhumanrpginterfaceattributes() {
  ai::registermatchedinterface(#"human_rpg", #"can_be_meleed", 1, array(1, 0), &aiutility::meleeattributescallback);
  ai::registermatchedinterface(#"human_rpg", #"can_melee", 1, array(1, 0), &aiutility::meleeattributescallback);
  ai::registermatchedinterface(#"human_rpg", #"coveridleonly", 0, array(1, 0));
  ai::registermatchedinterface(#"human_rpg", #"sprint", 0, array(1, 0));
  ai::registermatchedinterface(#"human_rpg", #"patrol", 0, array(1, 0));
}