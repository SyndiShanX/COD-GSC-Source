/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_asylum_achievements.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace zm_asylum_achievements;

function autoexec __init__sytem__() {
  system::register("zm_theater_achievements", &__init__, undefined, undefined);
}

function __init__() {
  level.achievement_sound_func = &achievement_sound_func;
  level thread function_fa4b9452();
  zm_spawner::register_zombie_death_event_callback(&function_1abfde35);
  callback::on_connect(&onplayerconnect);
}

function achievement_sound_func(achievement_name_lower) {
  self endon("disconnect");
  if(!sessionmodeisonlinegame()) {
    return;
  }
  for(i = 0; i < (self getentitynumber() + 1); i++) {
    util::wait_network_frame();
  }
  self thread zm_utility::do_player_general_vox("general", "achievement");
}

function onplayerconnect() {
  self thread function_a90f7ab8();
  self thread function_9c59bc3();
}

function function_fa4b9452() {
  level endon("end_game");
  level waittill("start_of_round");
  while(level.round_number < 5 && !level flag::get("power_on")) {
    level function_64c5daf7();
  }
  if(level flag::get("power_on")) {}
}

function function_64c5daf7() {
  level endon("end_game");
  level endon("power_on");
  level waittill("end_of_round");
}

function function_a90f7ab8() {
  level endon("end_game");
  self endon("disconnect");
  self.var_2418ad9a = 20;
  self waittill("hash_fadd25a2");
  self zm_utility::giveachievement_wrapper("ZM_ASYLUM_ACTED_ALONE", 0);
}

function function_9c59bc3() {
  level endon("end_game");
  self endon("disconnect");
  self.zapped_zombies = 0;
  self thread function_a366eb3e();
  self waittill("hash_c0226895");
}

function function_a366eb3e() {
  level endon("end_game");
  self endon("disconnect");
  self endon("hash_c0226895");
  while(self.zapped_zombies < 50) {
    self waittill("zombie_zapped");
  }
  self notify("hash_c0226895");
}

function function_1abfde35(e_attacker) {
  if(isDefined(e_attacker) && isDefined(e_attacker.zapped_zombies) && e_attacker.zapped_zombies < 50 && isDefined(self.damageweapon)) {
    if(self.damageweapon == level.weaponzmteslagun || self.damageweapon == level.weaponzmteslagun) {
      e_attacker.zapped_zombies++;
    }
    if(e_attacker.zapped_zombies >= 50) {
      e_attacker notify("hash_c0226895");
    }
  }
  if(isDefined(e_attacker) && isDefined(e_attacker.var_2418ad9a) && e_attacker.var_2418ad9a > 0) {
    if(!isDefined(self.damagelocation)) {
      return;
    }
    if(!(isDefined(zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod)) && zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod))) {
      return;
    }
    var_52df56de = getent("area_courtyard", "targetname");
    if(!(isDefined(self istouching(var_52df56de)) && self istouching(var_52df56de))) {
      return;
    }
    str_zone = e_attacker zm_zonemgr::get_player_zone();
    var_1486ce13 = strtok(str_zone, "_");
    if(var_1486ce13[1] != "upstairs") {
      return;
    }
    e_attacker.var_2418ad9a--;
    if(e_attacker.var_2418ad9a <= 0) {
      e_attacker notify("hash_fadd25a2");
    }
  }
}