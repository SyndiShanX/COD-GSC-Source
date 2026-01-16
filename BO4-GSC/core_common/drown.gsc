/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\drown.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\visionset_mgr_shared;

#namespace drown;

autoexec __init__system__() {
  system::register(#"drown", &__init__, undefined, undefined);
}

__init__() {
  callback::on_spawned(&function_27777812);
  callback::on_connect(&on_connect);
  level.drown_pre_damage_stage_time = 2000;

  if(!isDefined(level.vsmgr_prio_overlay_drown_blur)) {
    level.vsmgr_prio_overlay_drown_blur = 10;
  }

  visionset_mgr::register_info("overlay", "drown_blur", 1, level.vsmgr_prio_overlay_drown_blur, 1, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1);
  clientfield::register("toplayer", "drown_stage", 1, 3, "int");
}

on_connect() {
  self callback::on_death(&function_1ef50162);
  self callback::function_d8abfc3d(#"on_end_game", &function_c621d98c);
}

activate_player_health_visionset() {
  self deactivate_player_health_visionset();

  if(!self.drown_vision_set) {
    visionset_mgr::activate("overlay", "drown_blur", self, 0.1, 0.25, 0.1);
    self.drown_vision_set = 1;
  }
}

deactivate_player_health_visionset() {
  if(!isDefined(self.drown_vision_set) || self.drown_vision_set) {
    visionset_mgr::deactivate("overlay", "drown_blur", self);
    self.drown_vision_set = 0;
  }
}

function_27777812() {
  self callback::add_callback(#"underwater", &function_84845e32);
  self deactivate_player_health_visionset();
}

function_c621d98c(params) {
  self function_1ef50162(params);
  self callback::remove_on_death(&function_1ef50162);
}

function_84845e32(params) {
  if(!isDefined(self.playerrole)) {
    return;
  }

  if(params.underwater) {
    thread watch_player_drowning();
  }
}

watch_player_drowning() {
  self endon(#"disconnect", #"death");
  level endon(#"game_ended");
  self clientfield::set_to_player("drown_stage", 0);
  self.lastwaterdamagetime = self getlastoutwatertime();
  self.drownstage = 0;
  var_c1e8fa5d = 4000;
  underwaterbreathtime = 1000;

  if(isDefined(level.var_ac6052e9)) {
    underwaterbreathtime = int([[level.var_ac6052e9]]("underwaterBreathTime", 1) * 1000);
    exertbuffer = [[level.var_ac6052e9]]("playerExertBuffer", 1);
  }

  while(true) {
    waitframe(1);
    underwater = (game.state == "pregame" || game.state == "playing") && self isplayerunderwater();
    var_790acff6 = isDefined(level.var_8e910e84) && level.var_8e910e84 && self inlaststand() && getwaterheight(self.origin) > self getplayercamerapos()[2];
    underwater |= var_790acff6;

    if(underwater && !(isDefined(self.var_f07d3654) && self.var_f07d3654)) {
      if(!(isDefined(self.wasunderwater) && self.wasunderwater)) {
        self.wasunderwater = 1;
        self.var_cdefe788 = gettime();
        self stopsounds();
      }

      n_swimtime = int(self.playerrole.swimtime * 1000);

      if(self hasperk(#"hash_4ef368f54cd86ab7")) {
        n_swimtime = int(n_swimtime * 1.5);
      }

      if(gettime() - self.lastwaterdamagetime > n_swimtime - var_c1e8fa5d && self.drownstage == 0) {
        if(isDefined(level.var_9f155bf4)) {
          self thread[[level.var_9f155bf4]]("MOD_DROWN");
        }

        var_c1e8fa5d -= int(self.playerrole.var_f0886300 * 1000);
      }

      if(gettime() - self.lastwaterdamagetime > n_swimtime - level.drown_pre_damage_stage_time && self.drownstage == 0) {
        self.drownstage++;
        self clientfield::set_to_player("drown_stage", self.drownstage);
      } else if(self.drownstage == 0 && var_790acff6) {
        self.drownstage++;
        self clientfield::set_to_player("drown_stage", self.drownstage);
        self.lastwaterdamagetime = gettime() - n_swimtime + int(self.playerrole.var_f0886300 * 1000);
      }

      if(gettime() - self.lastwaterdamagetime > n_swimtime) {
        self.lastwaterdamagetime += int(self.playerrole.var_f0886300 * 1000);
        self dodamage(self.playerrole.swimdamage, self.origin, undefined, undefined, undefined, "MOD_DROWN", 6);
        self activate_player_health_visionset();

        if(self.drownstage < 4) {
          self.drownstage++;
          self clientfield::set_to_player("drown_stage", self.drownstage);
        }
      }

      continue;
    }

    if(isDefined(level.var_ee30f81d) && isDefined(self.wasunderwater) && self.wasunderwater) {
      if(self.drownstage > 0) {
        thread[[level.var_ee30f81d]](self, 1);
      } else if(gettime() > (isDefined(self.var_cdefe788) ? self.var_cdefe788 : 0) + underwaterbreathtime) {
        thread[[level.var_ee30f81d]](self, 0);
      }
    }

    self.drownstage = 0;
    self clientfield::set_to_player("drown_stage", 0);
    self.lastwaterdamagetime = self getlastoutwatertime();
    self deactivate_player_health_visionset();
    var_c1e8fa5d = 4000;
    self.wasunderwater = 0;
    return;
  }
}

function_1ef50162(params = undefined) {
  self.drownstage = 0;
  self clientfield::set_to_player("drown_stage", 0);
  self.wasunderwater = 0;
  self deactivate_player_health_visionset();
}

is_player_drowning() {
  drowning = 1;

  if(!isDefined(self.drownstage) || self.drownstage == 0) {
    drowning = 0;
  }

  return drowning;
}