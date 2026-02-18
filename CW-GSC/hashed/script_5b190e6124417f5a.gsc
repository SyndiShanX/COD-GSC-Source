/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5b190e6124417f5a.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\util_shared;
#namespace namespace_b574e135;

function init() {
  clientfield::register("world", "" + # "hash_11f590eba265ab9e", 24000, 4, "int");
  clientfield::register("world", "" + # "hash_3227b9d6476c5f3b", 24000, 1, "int");
  clientfield::register("world", "" + # "hash_5d84af8c16684d61", 24000, 1, "int");
  clientfield::register("world", "" + # "hash_17dd998c0d1ddef9", 24000, 2, "int");
  clientfield::register("world", "" + # "hash_6e50c5223648d97", 24000, 1, "int");
  clientfield::register("world", "" + # "hash_2c8008207dc4c591", 24000, 1, "int");
}

function function_f5d0eb85(state) {
  level endon(#"end_game");
  level clientfield::set("" + # "hash_11f590eba265ab9e", state);
}

function function_d508d5d8(state) {
  level endon(#"end_game");
  level clientfield::set("" + # "hash_3227b9d6476c5f3b", state);
}

function function_4b599595(state) {
  level endon(#"end_game");
  level clientfield::set("" + # "hash_5d84af8c16684d61", state);
}

function function_471f4c0f(state) {
  level endon(#"end_game");
  level clientfield::set("" + # "hash_17dd998c0d1ddef9", state);
}

function function_278866ab(state) {
  level endon(#"end_game");
  level clientfield::set("" + # "hash_6e50c5223648d97", state);
}

function function_8d857888(state) {
  level endon(#"end_game");
  level clientfield::set("" + # "hash_2c8008207dc4c591", state);
}