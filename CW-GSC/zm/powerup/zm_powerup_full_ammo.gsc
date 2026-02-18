/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_full_ammo.gsc
***********************************************/

#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace zm_powerup_full_ammo;

function private autoexec __init__system__() {
  system::register(#"zm_powerup_full_ammo", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_powerups::register_powerup("full_ammo", &grab_full_ammo);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("full_ammo", #"p7_zm_power_up_max_ammo", #"zombie/powerup_max_ammo", &zm_powerups::func_should_always_drop, 0, 0, 0);
  }
}

function grab_full_ammo(player) {
  if(zm_powerups::function_cfd04802(#"full_ammo")) {
    level thread function_dae1df4d(self, player);
  } else {
    level thread full_ammo_powerup(self, player);
  }

  player thread zm_powerups::powerup_vo("full_ammo");
}

function function_dae1df4d(e_powerup, player) {
  if(isDefined(level.check_player_is_ready_for_ammo)) {
    if([[level.check_player_is_ready_for_ammo]](player) == 0) {
      return;
    }
  }

  if(isDefined(player) && isPlayer(player) && isDefined(e_powerup.hint)) {
    player zm_utility::function_846eb7dd(#"hash_1d757d99eb407952", e_powerup.hint);
  }

  player.var_655c0753 = undefined;
  player notify(#"zmb_max_ammo");
  player zm_placeable_mine::disable_all_prompts_for_player();

  foreach(slotid in array(17 + 1, 17 + 1 + 8 + 1, 17 + 1 + 8 + 1 + 8 + 1)) {
    player zm_weapons::function_51aa5813(slotid);
  }

  player playsoundtoplayer(#"zmb_full_ammo", player);
}

function full_ammo_powerup(drop_item, player) {
  players = getplayers(player.team);

  if(isDefined(level.var_73345bfd)) {
    players = [[level.var_73345bfd]](player);
  }

  level notify(#"zmb_max_ammo_level");

  foreach(player in players) {
    if(isDefined(level.check_player_is_ready_for_ammo)) {
      if([[level.check_player_is_ready_for_ammo]](player) == 0) {
        continue;
      }
    }

    if(player util::is_spectating()) {
      continue;
    }

    if(isDefined(player) && isPlayer(player) && isDefined(drop_item.hint)) {
      player zm_utility::function_846eb7dd(#"hash_1d757d99eb407952", drop_item.hint);
    }

    player.var_655c0753 = undefined;
    player notify(#"zmb_max_ammo");
    player zm_placeable_mine::disable_all_prompts_for_player();

    foreach(slotid in array(17 + 1, 17 + 1 + 8 + 1, 17 + 1 + 8 + 1 + 8 + 1)) {
      player zm_weapons::function_51aa5813(slotid);
    }
  }

  level thread full_ammo_on_hud(drop_item, player.team);
}

function function_3ecbd9d(w_weapon) {
  self endon(#"disconnect");
  n_slot = self gadgetgetslot(w_weapon);

  if(w_weapon == getweapon(#"tomahawk_t8") || w_weapon == getweapon(#"tomahawk_t8_upgraded")) {
    while(self function_36dfc05f(n_slot)) {
      waitframe(1);
    }

    self notify(#"hash_3d73720d4588203c");
    self gadgetpowerset(n_slot, 100);
    return;
  }

  self gadgetpowerset(n_slot, 100);
}

function full_ammo_on_hud(drop_item, player_team) {
  players = getplayers(player_team);
  players[0] playsoundtoteam("zmb_full_ammo", player_team);
}

function function_b695b971() {
  return level.zm_genesis_robot_pay_towardsreactswordstart == 0;
}