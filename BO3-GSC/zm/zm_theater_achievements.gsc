/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_theater_achievements.gsc
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
#namespace zm_theater_achievements;

function autoexec __init__sytem__() {
  system::register("zm_theater_achievements", &__init__, undefined, undefined);
}

function __init__() {
  level.achievement_sound_func = &achievement_sound_func;
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
  self thread achievement_ive_seen_some_things();
  self thread function_24b05d89();
  self thread function_6c831509();
}

function achievement_ive_seen_some_things() {
  level endon("end_game");
  self endon("disconnect");
  self.var_3ac4b03d = [];
  for(i = 0; i <= 3; i++) {
    self.var_3ac4b03d[i] = i;
  }
  level flag::wait_till("power_on");
  while(self.var_3ac4b03d.size > 0) {
    self waittill("player_teleported", n_loc);
    if(isDefined(n_loc) && isint(n_loc) && isinarray(self.var_3ac4b03d, n_loc)) {
      arrayremovevalue(self.var_3ac4b03d, n_loc);
    }
    wait(0.05);
  }
  self zm_utility::giveachievement_wrapper("ZM_THEATER_IVE_SEEN_SOME_THINGS", 0);
}

function function_24b05d89() {
  level endon("end_game");
  self endon("disconnect");
  self.var_597e831d = [];
  for(i = 1; i <= 3; i++) {
    self.var_597e831d[i - 1] = "ps" + i;
  }
  level flag::wait_till("power_on");
  while(self.var_597e831d.size > 0) {
    level waittill("play_movie", var_2be4351a);
    if(isDefined(var_2be4351a) && isinarray(self.var_597e831d, var_2be4351a)) {
      arrayremovevalue(self.var_597e831d, var_2be4351a);
    }
  }
}

function function_6c831509() {
  level endon("end_game");
  self endon("disconnect");
  self.var_386853b6 = [];
  self.var_386853b6["zombie"] = 40;
  self.var_386853b6["zombie_quad"] = 20;
  self.var_386853b6["zombie_dog"] = 10;
  self waittill("hash_f5c9d74f");
}

function function_1abfde35(e_attacker) {
  if(isDefined(e_attacker) && e_attacker.target === "crematorium_room_trap" && isDefined(self.archetype) && isDefined(e_attacker.activated_by_player)) {
    var_3500dd7a = e_attacker.activated_by_player;
    var_3500dd7a.var_386853b6[self.archetype]--;
    var_fc3072e7 = 1;
    foreach(n_targets in var_3500dd7a.var_386853b6) {
      if(n_targets > 0) {
        var_fc3072e7 = 0;
        break;
      }
    }
    if(var_fc3072e7 && isDefined(var_3500dd7a)) {
      var_3500dd7a notify("hash_f5c9d74f");
    }
  }
}