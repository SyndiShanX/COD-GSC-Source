/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_448683444db21d61.gsc
***********************************************/

#using script_340a2e805e35f7a2;
#using script_5e96d104c70be5ac;
#using script_7a8059ca02b7b09e;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_world_util;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;
#namespace namespace_207ea311;

function private autoexec __init__system__() {
  system::register(#"hash_684573a459d68beb", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register("allplayers", "" + # "hash_63af42145e260fb5", 1, 2, "int");
}

function private postinit() {
  callback::on_spawned(&on_player_spawned);
  callback::on_player_killed(&on_death);
}

function on_player_spawned() {
  if(isDefined(level.var_33833303)) {
    self thread[[level.var_33833303]]();
    return;
  }

  self thread function_23c31b4e();
}

function on_death() {
  self clientfield::set("" + # "hash_63af42145e260fb5", 0);
}

function function_31b6f21e(str_notify) {
  self clientfield::set("" + # "hash_63af42145e260fb5", 0);
}

function function_23c31b4e() {
  if(is_true(self.is_hotjoining) || self util::is_spectating()) {
    return;
  }

  self endoncallback(&function_31b6f21e, #"death");

  while(true) {
    if(level flag::get(#"dark_aether_active")) {
      self clientfield::set("" + # "hash_63af42145e260fb5", 2);
    } else if(level flag::get("power_on")) {
      self clientfield::set("" + # "hash_63af42145e260fb5", 0);
    } else {
      self childthread function_3ba2978d();
    }

    waitresult = level waittill(#"dark_aether_active", #"power_on");

    if(waitresult._notify == "power_on") {
      wait 5;
    }

    if(waitresult._notify == "dark_aether_active" && level flag::get(#"dark_aether_active")) {
      wait 3;
    }
  }
}

function function_3ba2978d() {
  level endon(#"dark_aether_active", #"power_on");

  while(true) {
    if(self zm_zonemgr::is_player_in_zone(level.var_b80c4ecc)) {
      self clientfield::set("" + # "hash_63af42145e260fb5", 1);
    } else {
      self clientfield::set("" + # "hash_63af42145e260fb5", 0);
    }

    self waittill(#"zone_change");
  }
}

function function_57cc7ff7() {
  a_players = getplayers();

  foreach(player in a_players) {
    player clientfield::set("" + # "hash_63af42145e260fb5", 0);
  }
}

function function_c6b98f73(a_zones) {
  if(!isDefined(a_zones)) {
    a_zones = [];
  } else if(!isarray(a_zones)) {
    a_zones = array(a_zones);
  }

  level.var_b80c4ecc = a_zones;
}