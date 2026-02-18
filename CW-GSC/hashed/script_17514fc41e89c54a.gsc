/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_17514fc41e89c54a.gsc
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
#using scripts\zm\powerup\zm_powerup_cranked_pause;
#using scripts\zm_common\aats\zm_aat;
#using scripts\zm_common\objective_manager;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#namespace namespace_9be1ab53;

function private autoexec __init__system__() {
  system::register(#"hash_5aa4949e75ab9d9c", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(util::get_game_type() === # "hash_5aa4949e75ab9d9c") {
    level.var_2d41db66 = 1;
    level.var_3d9229ee = 1000;
    level.var_f35ad8f3 = 250;

    if((is_true(level.var_2d41db66) || util::get_game_type() === # "hash_5aa4949e75ab9d9c") && getdvarint(#"hash_d3df2c834aa1010", 1)) {
      level.var_aa36d14e = (level.var_3d9229ee - 1) / 75;
    } else {
      level.var_aa36d14e = (level.var_3d9229ee - level.var_f35ad8f3) / 60;
    }

    callback::add_callback(#"hash_5118a91e667446ee", &function_9e216600);
    callback::add_callback(#"hash_c41074e4c29158a", &function_504e44da);
    callback::add_callback(#"hash_75d9baf9eed8610b", &function_4e9f972a);
  }
}

function function_4e9f972a() {
  wait 4;
  level flag::clear(#"hash_2c0ce601824acdf5");
}

function function_504e44da() {
  level flag::set(#"hash_2c0ce601824acdf5");
}

function function_9e216600() {
  if(getdvarint(#"hash_6d9eda83aac99122", 0)) {
    foreach(player in getplayers()) {
      player zm_stats::increment_challenge_stat(#"hash_5a234b7c00ae1ae4");
    }
  }
}