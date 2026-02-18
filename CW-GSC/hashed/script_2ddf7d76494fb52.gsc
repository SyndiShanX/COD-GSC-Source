/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2ddf7d76494fb52.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\util_shared;
#namespace namespace_297ae820;

function init() {
  clientfield::register("world", "" + # "hash_658f225a02b95617", 28000, 1, "int");
  clientfield::register("world", "" + # "hash_5e34e1c50fd13b32", 28000, 1, "int");
  clientfield::register("world", "" + # "dark_aether_light_on", 28000, 1, "int");
}

function function_3528419f(state) {
  level endon(#"end_game");
  level clientfield::set("" + # "hash_658f225a02b95617", state);
}