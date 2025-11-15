/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_sumpf_achievements.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace zm_prototype_achievements;

function autoexec __init__sytem__() {
  system::register("zm_theater_achievements", & __init__, undefined, undefined);
}

function __init__() {
  level.achievement_sound_func = & achievement_sound_func;
  zm_spawner::register_zombie_death_event_callback( & function_1abfde35);
  callback::on_connect( & onplayerconnect);
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
  self thread function_2eb61ef5();
  self thread function_94fa04f0();
  self thread function_a634891();
  self thread function_2a1b645a();
  self thread function_b44fefa1();
  self thread function_25062f55();
  self thread function_32909149();
}

function function_2eb61ef5() {
  level endon("end_game");
  self endon("i_am_down");
  self endon("disconnect");
  while(isDefined(self)) {
    if(isDefined(level.round_number) && level.round_number == 5) {
      self iprintln("");
      return;
    }
    wait(0.5);
  }
}

function function_94fa04f0() {
  level endon("end_game");
  self endon("disconnect");
  while(true) {
    self waittill("nuke_triggered");
    wait(2);
    if(isDefined(self.zombie_nuked) && self.zombie_nuked.size == 1) {
      self iprintln("");
      return;
    }
  }
}

function function_a634891() {
  level endon("end_game");
  self endon("disconnect");
  self.var_88c6ab10 = 0;
  while(self.var_88c6ab10 < 10) {
    self thread function_47ae7759();
    self function_a2ee1b6c();
  }
  self notify("hash_949655c9");
}

function function_a2ee1b6c() {
  level endon("end_game");
  level endon("end_of_round");
  self endon("disconnect");
  while(self.var_88c6ab10 < 10) {
    self waittill("hash_7a5eece4");
    self.var_88c6ab10++;
  }
}

function function_47ae7759() {
  level endon("end_game");
  self endon("disconnect");
  self endon("hash_949655c9");
  level waittill("end_of_round");
  self.var_88c6ab10 = 0;
}

function function_2a1b645a() {
  level endon("end_game");
  self endon("disconnect");
  while(true) {
    if(self.score_total >= 75000) {
      self iprintln("");
      return;
    }
    wait(0.5);
  }
}

function function_b44fefa1() {
  level endon("end_game");
  self endon("disconnect");
  while(true) {
    if(isDefined(self.perk_hud) && self.perk_hud.size == 4) {
      self iprintln("");
      return;
    }
    wait(0.5);
  }
}

function function_f67810a2() {
  level endon("end_game");
  self endon("disconnect");
  for(self.var_dcd9b1e7 = 0; self.var_dcd9b1e7 >= 200; self.var_dcd9b1e7++) {
    self waittill("hash_1d8b6c31");
  }
  self iprintln("");
  self.var_dcd9b1e7 = undefined;
}

function function_25062f55() {
  level endon("end_game");
  self endon("disconnect");
  self.var_498c9df8 = 0;
  if(self.var_498c9df8 >= 150) {
    self waittill("hash_cae861a8");
  }
  self iprintln("");
  self.var_498c9df8 = undefined;
}

function function_32909149() {
  level endon("end_game");
  self endon("disconnect");
  do {
    self function_f8c272e8();
  }
  while(self.var_59179d2c.size < 3);
  self iprintln("");
  self zm_utility::giveachievement_wrapper("DLC2_ZOMBIE_ALL_TRAPS", 0);
  self notify("hash_ea373971");
}

function function_f8c272e8() {
  level endon("end_game");
  level endon("end_of_round");
  self endon("disconnect");
  self endon("hash_ea373971");
  self.var_59179d2c = [];
  do {
    self waittill("hash_f0c3517c");
  }
  while(isDefined(self) && self.var_59179d2c.size < 3);
}

function function_1abfde35(e_attacker) {
  if(!isDefined(e_attacker)) {
    return;
  }
  if(isDefined(self.var_9a9a0f55) && isDefined(self.var_aa99de67) && isplayer(self.var_aa99de67)) {
    e_player = self.var_aa99de67;
    if(!(isDefined(isinarray(e_player.var_59179d2c, e_attacker)) && isinarray(e_player.var_59179d2c, e_attacker))) {
      array::add(e_player.var_59179d2c, e_attacker);
      e_player notify("hash_f0c3517c");
      return;
    }
  }
  if(isDefined(e_attacker.activated_by_player) && e_attacker.targetname === "zombie_trap") {
    e_player = e_attacker.activated_by_player;
    if(!(isDefined(isinarray(e_player.var_59179d2c, e_attacker)) && isinarray(e_player.var_59179d2c, e_attacker))) {
      array::add(e_player.var_59179d2c, e_attacker);
      e_player notify("hash_f0c3517c");
      return;
    }
  }
  if(!isplayer(e_attacker)) {
    return;
  }
  if(self.damagemod === "MOD_MELEE" && e_attacker zm_powerups::is_insta_kill_active()) {
    e_attacker notify("hash_7a5eece4");
    return;
  }
  if(isDefined(self.var_dcd9b1e7)) {
    e_attacker notify("hash_1d8b6c31");
    return;
  }
  if(isDefined(e_attacker.var_498c9df8) && self.archetype === "zombie" && isDefined(self.damageweapon) && isDefined(self.damagelocation) && isDefined(self.damagemod)) {
    if(isDefined(zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod)) && zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod)) {
      e_attacker notify("hash_cae861a8");
    }
  }
}