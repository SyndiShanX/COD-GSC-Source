/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\bots\bot_interface.gsc
***********************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\bots\bot;

#namespace botinterface;

registerbotinterfaceattributes() {
  ai::registermatchedinterface(#"bot", #"control", "commander", array("commander", "autonomous"), &bot::function_b5dd2fd2);
  ai::registermatchedinterface(#"bot", #"sprint", 0, array(1, 0), undefined);
  ai::registermatchedinterface(#"bot", #"revive", 1, array(1, 0), undefined);
  ai::registermatchedinterface(#"bot", #"slide", 1, array(1, 0), undefined);
  ai::registermatchedinterface(#"bot", #"ignorepathenemyfightdist", 0, array(1, 0), undefined);
  ai::registermatchedinterface(#"bot", #"allowprimaryoffhand", 1, array(1, 0), undefined);
  ai::registermatchedinterface(#"bot", #"allowsecondaryoffhand", 1, array(1, 0), undefined);
  ai::registermatchedinterface(#"bot", #"allowspecialoffhand", 1, array(1, 0), undefined);
  ai::registermatchedinterface(#"bot", #"allowscorestreak", 1, array(1, 0), undefined);
}