/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\player\player.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\gamestate;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\player\player_utils;

#namespace player;

autoexec __init__() {
  callback::on_spawned(&on_player_spawned);
  callback::on_game_playing(&on_game_playing);
}

spectate_player_watcher() {
  self endon(#"disconnect");

  if(!level.splitscreen && !level.hardcoremode && getdvarint(#"scr_showperksonspawn", 0) == 1 && !gamestate::is_game_over() && !isDefined(self.perkhudelem)) {
    if(level.perksenabled == 1) {
      self hud::showperks();
    }
  }

    self.watchingactiveclient = 1;

  while(true) {
    if(self.pers[#"team"] != #"spectator" || level.gameended) {
      if(!(isDefined(level.inprematchperiod) && level.inprematchperiod)) {
        self val::reset(#"spectate", "freezecontrols");
        self val::reset(#"spectate", "disablegadgets");
      }

      self.watchingactiveclient = 0;
      break;
    }

    count = 0;

    for(i = 0; i < level.players.size; i++) {
      if(level.players[i].team != #"spectator") {
        count++;
        break;
      }
    }

    if(count > 0) {
      if(!self.watchingactiveclient) {
        self val::reset(#"spectate", "freezecontrols");
        self val::reset(#"spectate", "disablegadgets");
        self luinotifyevent(#"player_spawned", 0);
      }

      self.watchingactiveclient = 1;
    } else {
      if(self.watchingactiveclient) {
        [
          [level.onspawnspectator]
        ]();
        self val::set(#"spectate", "freezecontrols", 1);
        self val::set(#"spectate", "disablegadgets", 1);
      }

      self.watchingactiveclient = 0;
    }

    wait 0.5;
  }
}

reset_doublexp_timer() {
  self notify(#"reset_doublexp_timer");
  self thread doublexp_timer();
}

doublexp_timer() {
  self notify(#"doublexp_timer");
  self endon(#"doublexp_timer", #"reset_doublexp_timer", #"end_game");
  level flagsys::wait_till("game_start_doublexp");

  if(!level.onlinegame) {
    return;
  }

  wait 60;

  if(level.onlinegame) {
    if(!isDefined(self)) {
      return;
    }

    self doublexptimerfired();
  }

  self thread reset_doublexp_timer();
}

on_player_spawned() {
  self thread doublexp_timer();
  profilestart();

  if(util::is_frontend_map()) {
    profilestop();
    return;
  }

  self thread last_valid_position();
  profilestop();

  if(function_8b1a219a()) {
    self allowjump(0);
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }

    self allowjump(1);
  }
}

on_game_playing() {
  level flagsys::set("game_start_doublexp");
}

function_490dc3d3() {
  return self isinvehicle() && !self isremotecontrolling() && self function_a867284b() && self playerads() >= 1;
}

function_c3eed624() {
  origin = self.origin;

  if(self function_490dc3d3()) {
    forward = anglesToForward(self.angles);
    origin += forward * self function_85d25868();
    origin -= (0, 0, isDefined(self.var_2d23ee07) ? self.var_2d23ee07 : 0);
  }

  return origin;
}

last_valid_position() {
  self endon(#"disconnect");
  self notify(#"stop_last_valid_position");
  self endon(#"stop_last_valid_position");

  while(!isDefined(self.last_valid_position) && isDefined(self)) {
    origin = self function_c3eed624();
    self.last_valid_position = getclosestpointonnavmesh(origin, 2048, 0);
    wait 0.1;
  }

  while(isDefined(self)) {
    origin = self function_c3eed624();

    if(getdvarint(#"hash_1a597b008cc91bd8", 0) > 0) {
      wait 1;
      continue;
    }

    playerradius = self getpathfindingradius();

    if(distance2dsquared(origin, self.last_valid_position) < playerradius * playerradius && (origin[2] - self.last_valid_position[2]) * (origin[2] - self.last_valid_position[2]) < 16 * 16) {
      wait 0.1;
      continue;
    }

    if(ispointonnavmesh(origin, self)) {
      self.last_valid_position = origin;
    } else if(!ispointonnavmesh(origin, self) && ispointonnavmesh(self.last_valid_position, self) && distance2dsquared(origin, self.last_valid_position) < 32 * 32) {
      wait 0.1;
      continue;
    } else {
      position = getclosestpointonnavmesh(origin, 100, playerradius);

      if(isDefined(position)) {
        self.last_valid_position = position;
      }
    }

    wait 0.1;
  }
}