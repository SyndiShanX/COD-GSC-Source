/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5544f0d56caa6b36.gsc
***********************************************/

#using script_193d6fcd3b319d05;
#using script_340a2e805e35f7a2;
#using script_34e9dd62fc371077;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\aats\zm_aat;
#using scripts\zm_common\objective_manager;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#namespace namespace_89fd9b3e;

function private autoexec __init__system__() {
  system::register(#"hash_75aa82b3ae89f54e", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(util::get_game_type() === # "hash_75aa82b3ae89f54e") {
    level.var_612d6a21 = 1;
    level.var_51514f45 = 0.25;
    level.var_e2fec446 = 0.25;
    level.var_12f3d2fc = 0.5;
    callback::add_callback(#"hash_7852c3cae4d4082a", &function_2d9abf0f);
  }
}

function function_2d9abf0f() {
  if(getdvarint(#"hash_505f9e51193386d9", 0)) {
    foreach(player in getplayers()) {
      player zm_stats::increment_challenge_stat(#"hash_3551fbb8f9272df6");
    }
  }
}