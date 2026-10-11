/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_gametype_conflict.gsc
*********************************************************/

#using script_27fdece778e999d8;
#using script_4a941421347ff7df;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#namespace bots_gametype_conflict;

function main() {
  setup_callbacks();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  initialize(&function_a3ba36b8f9e1f910);
}

function private function_a3ba36b8f9e1f910(mind_personality) {
  decisions = namespace_823e1abd5161abb1::function_e65493518b3de050();
  decisions[decisions.size] = "ControlFob";
  return decisions;
}