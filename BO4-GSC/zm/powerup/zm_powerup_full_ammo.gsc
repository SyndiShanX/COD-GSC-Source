/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_full_ammo.gsc
***********************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\perk\zm_perk_widows_wine;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_placeable_mine;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_powerup_full_ammo;

autoexec __init__system__() {
  system::register(#"zm_powerup_full_ammo", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::register_powerup("full_ammo", &grab_full_ammo);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("full_ammo", "p7_zm_power_up_max_ammo", #"zombie/powerup_max_ammo", &function_b695b971, 0, 0, 0);
  }
}

grab_full_ammo(player) {
  if(zm_powerups::function_cfd04802(#"full_ammo")) {
    level thread function_dae1df4d(self, player);
  } else {
    level thread full_ammo_powerup(self, player);
  }

  player thread zm_powerups::powerup_vo("full_ammo");
}

function_dae1df4d(e_powerup, player) {
  if(isDefined(level.check_player_is_ready_for_ammo)) {
    if([
        [level.check_player_is_ready_for_ammo]
      ](player) == 0) {
      return;
    }
  }

  a_w_weapons = player getweaponslist(0);
  player.var_655c0753 = undefined;
  player notify(#"zmb_max_ammo");
  player zm_placeable_mine::disable_all_prompts_for_player();

  foreach(w_weapon in a_w_weapons) {
    if(level.headshots_only && zm_loadout::is_lethal_grenade(w_weapon)) {
      continue;
    }

    if(isDefined(level.zombie_include_equipment) && isDefined(level.zombie_include_equipment[w_weapon]) && !(isDefined(level.zombie_equipment[w_weapon].refill_max_ammo) && level.zombie_equipment[w_weapon].refill_max_ammo)) {
      continue;
    }

    if(isDefined(level.zombie_weapons_no_max_ammo) && isDefined(level.zombie_weapons_no_max_ammo[w_weapon.name])) {
      continue;
    }

    if(zm_loadout::is_hero_weapon(w_weapon)) {
      continue;
    }

    if(player hasweapon(w_weapon)) {
      if(zm_loadout::is_lethal_grenade(w_weapon)) {
        player thread function_3ecbd9d(w_weapon);
        continue;
      }

      player zm_weapons::ammo_give(w_weapon, 0);
    }
  }

  if(player hasperk(#"specialty_widowswine")) {
    player zm_perk_widows_wine::reset_charges();
  }

  player playsoundtoplayer(#"zmb_full_ammo", player);

  if(isDefined(e_powerup)) {
    player zm_utility::function_7a35b1d7(e_powerup.hint);
  }
}

full_ammo_powerup(drop_item, player) {
  players = getplayers(player.team);

  if(isDefined(level.var_73345bfd)) {
    players = [[level.var_73345bfd]](player);
  }

  level notify(#"zmb_max_ammo_level");

  foreach(player in players) {
    if(isDefined(level.check_player_is_ready_for_ammo)) {
      if([
          [level.check_player_is_ready_for_ammo]
        ](player) == 0) {
        continue;
      }
    }

    a_w_weapons = player getweaponslist(0);
    player.var_655c0753 = undefined;
    player notify(#"zmb_max_ammo");
    player zm_placeable_mine::disable_all_prompts_for_player();

    foreach(w_weapon in a_w_weapons) {
      if(level.headshots_only && zm_loadout::is_lethal_grenade(w_weapon)) {
        continue;
      }

      if(isDefined(level.zombie_include_equipment) && isDefined(level.zombie_include_equipment[w_weapon]) && !(isDefined(level.zombie_equipment[w_weapon].refill_max_ammo) && level.zombie_equipment[w_weapon].refill_max_ammo)) {
        continue;
      }

      if(isDefined(level.zombie_weapons_no_max_ammo) && isDefined(level.zombie_weapons_no_max_ammo[w_weapon.name])) {
        continue;
      }

      if(zm_loadout::is_hero_weapon(w_weapon)) {
        continue;
      }

      if(player hasweapon(w_weapon)) {
        if(zm_loadout::is_lethal_grenade(w_weapon)) {
          player thread function_3ecbd9d(w_weapon);
          continue;
        }

        player zm_weapons::ammo_give(w_weapon, 0);
      }
    }

    if(player hasperk(#"specialty_widowswine")) {
      player zm_perk_widows_wine::reset_charges();
    }
  }

  level thread full_ammo_on_hud(drop_item, player.team);
}

function_3ecbd9d(w_weapon) {
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

full_ammo_on_hud(drop_item, player_team) {
  players = getplayers(player_team);
  players[0] playsoundtoteam("zmb_full_ammo", player_team);

  if(isDefined(drop_item) && isDefined(drop_item.hint)) {
    level zm_utility::function_7a35b1d7(drop_item.hint);
  }
}

function_b695b971() {
  return level.zm_genesis_robot_pay_towardsreactswordstart <= 0;
}