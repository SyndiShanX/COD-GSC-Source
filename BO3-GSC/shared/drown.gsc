/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\drown.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace drown;

function autoexec __init__sytem__() {
  system::register("drown", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_spawned( & on_player_spawned);
  level.drown_damage = getdvarfloat("player_swimDamage");
  level.drown_damage_interval = getdvarfloat("player_swimDamagerInterval") * 1000;
  level.drown_damage_after_time = getdvarfloat("player_swimTime") * 1000;
  level.drown_pre_damage_stage_time = 2000;
  if(!isdefined(level.vsmgr_prio_overlay_drown_blur)) {
    level.vsmgr_prio_overlay_drown_blur = 10;
  }
  visionset_mgr::register_info("overlay", "drown_blur", 1, level.vsmgr_prio_overlay_drown_blur, 1, 1, & visionset_mgr::ramp_in_out_thread_per_player, 1);
  clientfield::register("toplayer", "drown_stage", 1, 3, "int");
}

function activate_player_health_visionset() {
  self deactivate_player_health_visionset();
  if(!self.drown_vision_set) {
    visionset_mgr::activate("overlay", "drown_blur", self, 0.1, 0.25, 0.1);
    self.drown_vision_set = 1;
  }
}

function deactivate_player_health_visionset() {
  if(!isdefined(self.drown_vision_set) || self.drown_vision_set) {
    visionset_mgr::deactivate("overlay", "drown_blur", self);
    self.drown_vision_set = 0;
  }
}

function on_player_spawned() {
  self thread watch_player_drowning();
  self thread watch_player_drown_death();
  self thread watch_game_ended();
  self deactivate_player_health_visionset();
}

function watch_player_drowning() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self.lastwaterdamagetime = self getlastoutwatertime();
  self.drownstage = 0;
  self clientfield::set_to_player("drown_stage", 0);
  if(!isdefined(self.drown_damage_after_time)) {
    self.drown_damage_after_time = level.drown_damage_after_time;
  }
  if(isdefined(self.var_d1d70226) && self.var_d1d70226) {
    return;
  }
  while (true) {
    if(self isplayerunderwater() && self isplayerswimming()) {
      if((gettime() - self.lastwaterdamagetime) > (self.drown_damage_after_time - level.drown_pre_damage_stage_time) && self.drownstage == 0) {
        self.drownstage++;
        self clientfield::set_to_player("drown_stage", self.drownstage);
      }
      if((gettime() - self.lastwaterdamagetime) > self.drown_damage_after_time) {
        self.lastwaterdamagetime = self.lastwaterdamagetime + level.drown_damage_interval;
        drownflags = 6;
        self dodamage(level.drown_damage, self.origin, undefined, undefined, undefined, "MOD_DROWN", drownflags);
        self activate_player_health_visionset();
        if(self.drownstage < 4) {
          self.drownstage++;
          self clientfield::set_to_player("drown_stage", self.drownstage);
        }
      }
    } else {
      self.drownstage = 0;
      self clientfield::set_to_player("drown_stage", 0);
      self.lastwaterdamagetime = self getlastoutwatertime();
      self deactivate_player_health_visionset();
    }
    wait(0.05);
  }
}

function watch_player_drown_death() {
  self endon("disconnect");
  self endon("game_ended");
  self waittill("death");
  self.drownstage = 0;
  self clientfield::set_to_player("drown_stage", 0);
  self deactivate_player_health_visionset();
}

function watch_game_ended() {
  self endon("disconnect");
  self endon("death");
  level waittill("game_ended");
  self.drownstage = 0;
  self clientfield::set_to_player("drown_stage", 0);
  self deactivate_player_health_visionset();
}

function is_player_drowning() {
  drowning = 1;
  if(!isdefined(self.drownstage) || self.drownstage == 0) {
    drowning = 0;
  }
  return drowning;
}