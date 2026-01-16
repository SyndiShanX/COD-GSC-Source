/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_snowball.gsc
***********************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_snowball;

autoexec __init__system__() {
  system::register(#"snowball", &__init__, undefined, undefined);
}

__init__() {
  level.w_snowball = getweapon(#"snowball");
  level.w_snowball_upgraded = getweapon(#"snowball_upgraded");
  level.w_snowball_yellow = getweapon(#"snowball_yellow");
  level.w_snowball_yellow_upgraded = getweapon(#"snowball_yellow_upgraded");
  zm::function_84d343d(#"snowball", &function_5ff12a45);
  zm::function_84d343d(#"snowball_upgraded", &function_5ff12a45);
  zm::function_84d343d(#"snowball_yellow", &function_ee240a8e);
  zm::function_84d343d(#"snowball_yellow_upgraded", &function_ee240a8e);
  callback::on_grenade_fired(&on_grenade_fired);
  zm_loadout::register_lethal_grenade_for_level(#"snowball");
  zm_loadout::register_lethal_grenade_for_level(#"snowball_upgraded");
  zm_loadout::register_lethal_grenade_for_level(#"snowball_yellow");
  zm_loadout::register_lethal_grenade_for_level(#"snowball_yellow_upgraded");
  clientfield::register("toplayer", "" + #"hash_78aa1dc141a3e27", 24000, 1, "int");
  clientfield::register("toplayer", "" + #"hash_2fafddfa9f85b8aa", 24000, 1, "int");
}

on_grenade_fired(s_params) {
  self endon(#"death");
  level endon(#"end_game");

  if(s_params.weapon != level.w_snowball && s_params.weapon != level.w_snowball_upgraded && s_params.weapon != level.w_snowball_yellow && s_params.weapon != level.w_snowball_yellow_upgraded) {
    return;
  }

  s_waitresult = s_params.projectile waittill(#"projectile_impact_explode", #"explode");
  a_e_players = getplayers();
  a_e_players = arraysortclosest(a_e_players, s_waitresult.position, 4, 0, 64);

  foreach(e_player in a_e_players) {
    if(s_params.weapon == level.w_snowball || s_params.weapon == level.w_snowball_upgraded) {
      e_player thread function_6e2124f7();
      continue;
    }

    e_player thread function_2291fc03();
  }

  var_566b3847 = getentitiesinradius(s_waitresult.position, 5);

  foreach(var_c006f5e9 in var_566b3847) {
    if(isDefined(var_c006f5e9)) {
      if(var_c006f5e9.targetname === "sos_snowball" || var_c006f5e9.targetname === "soup_pot") {
        var_c006f5e9 dodamage(1, var_c006f5e9.origin, self, undefined, undefined, "MOD_PROJECTILE", 0, s_params.weapon);
      }

      if(isplayer(var_c006f5e9) && var_c006f5e9 != self) {
        self thread zm_audio::create_and_play_dialog(#"snowball", #"friendly");
      }
    }
  }

  var_d87c5b04 = array::get_all_closest(s_waitresult.position, trigger::get_all(), undefined, undefined, 64);

  foreach(var_32835396 in var_d87c5b04) {
    var_32835396 dodamage(1, var_c006f5e9.origin, self, undefined, undefined, "MOD_PROJECTILE", 0, s_params.weapon);
  }
}

private function_6e2124f7() {
  self endon(#"disconnect");
  clientfield::set_to_player("" + #"hash_78aa1dc141a3e27", 1);
  wait 0.5;
  clientfield::set_to_player("" + #"hash_78aa1dc141a3e27", 0);
}

private function_2291fc03() {
  self endon(#"disconnect");
  clientfield::set_to_player("" + #"hash_2fafddfa9f85b8aa", 1);
  wait 0.5;
  clientfield::set_to_player("" + #"hash_2fafddfa9f85b8aa", 0);
}

function_5ff12a45(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(meansofdeath != "MOD_IMPACT") {
    return damage;
  }

  if(zm_utility::is_headshot(weapon, shitloc, meansofdeath, 1)) {
    damage = self.maxhealth;

    if(self.no_gib !== 1) {
      gibserverutils::gibhead(self);
    }

    self.water_damage = 1;
  } else {
    damage = ceil(self.maxhealth / 3) + 1;

    if(self.health <= damage) {
      self.water_damage = 1;
    }
  }

  if(attacker zm_powerups::is_insta_kill_active()) {
    self.water_damage = 1;
  }

  return damage;
}

function_ee240a8e(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  damage = self.maxhealth;
  self.water_damage = 1;

  if(zm_utility::is_headshot(weapon, shitloc, meansofdeath, 1)) {
    gibserverutils::gibhead(self);
  }

  if(attacker zm_powerups::is_insta_kill_active()) {
    self.water_damage = 1;
  }

  return damage;
}