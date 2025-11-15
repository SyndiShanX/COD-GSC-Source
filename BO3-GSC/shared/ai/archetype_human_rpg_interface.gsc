/*******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_human_rpg_interface.gsc
*******************************************************/

#using scripts\shared\ai\archetype_human_rpg;
#using scripts\shared\ai\systems\ai_interface;
#namespace humanrpginterface;

function registerhumanrpginterfaceattributes() {
  ai::registermatchedinterface("human_rpg", "can_be_meleed", 1, array(1, 0));
  ai::registermatchedinterface("human_rpg", "can_melee", 1, array(1, 0));
  ai::registermatchedinterface("human_rpg", "coverIdleOnly", 0, array(1, 0));
  ai::registermatchedinterface("human_rpg", "sprint", 0, array(1, 0));
  ai::registermatchedinterface("human_rpg", "patrol", 0, array(1, 0));
}