/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_factory_zombie.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_behavior;
#using scripts\zm\_zm_utility;
#namespace zm_factory_zombie;

function autoexec init() {
  initzmfactorybehaviorsandasm();
  level.zombie_init_done = & function_f06eec12;
  setdvar("scr_zm_use_code_enemy_selection", 0);
  level.closest_player_override = & factory_closest_player;
  level thread update_closest_player();
  level.move_valid_poi_to_navmesh = 1;
  level.pathdist_type = 2;
}

function private initzmfactorybehaviorsandasm() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("ZmFactoryTraversalService", & zmfactorytraversalservice);
  animationstatenetwork::registeranimationmocomp("mocomp_idle_special_factory", & mocompidlespecialfactorystart, undefined, & mocompidlespecialfactoryterminate);
}

function zmfactorytraversalservice(entity) {
  if(isdefined(entity.traversestartnode)) {
    entity pushactors(0);
    return true;
  }
  return false;
}

function private mocompidlespecialfactorystart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
    entity orientmode("face direction", entity.enemyoverride[1].origin - entity.origin);
    entity animmode("zonly_physics", 0);
  } else {
    entity orientmode("face current");
    entity animmode("zonly_physics", 0);
  }
}

function private mocompidlespecialfactoryterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {}

function function_f06eec12() {
  self pushactors(0);
}

function private factory_validate_last_closest_player(players) {
  if(isdefined(self.last_closest_player) && (isdefined(self.last_closest_player.am_i_valid) && self.last_closest_player.am_i_valid)) {
    return;
  }
  self.need_closest_player = 1;
  foreach(player in players) {
    if(isdefined(player.am_i_valid) && player.am_i_valid) {
      self.last_closest_player = player;
      return;
    }
  }
  self.last_closest_player = undefined;
}

function private factory_closest_player(origin, players) {
  if(players.size == 0) {
    return undefined;
  }
  if(isdefined(self.zombie_poi)) {
    return undefined;
  }
  if(players.size == 1) {
    self.last_closest_player = players[0];
    return self.last_closest_player;
  }
  if(!isdefined(self.last_closest_player)) {
    self.last_closest_player = players[0];
  }
  if(!isdefined(self.need_closest_player)) {
    self.need_closest_player = 1;
  }
  if(isdefined(level.last_closest_time) && level.last_closest_time >= level.time) {
    self factory_validate_last_closest_player(players);
    return self.last_closest_player;
  }
  if(isdefined(self.need_closest_player) && self.need_closest_player) {
    level.last_closest_time = level.time;
    self.need_closest_player = 0;
    closest = players[0];
    closest_dist = self zm_utility::approximate_path_dist(closest);
    if(!isdefined(closest_dist)) {
      closest = undefined;
    }
    for (index = 1; index < players.size; index++) {
      dist = self zm_utility::approximate_path_dist(players[index]);
      if(isdefined(dist)) {
        if(isdefined(closest_dist)) {
          if(dist < closest_dist) {
            closest = players[index];
            closest_dist = dist;
          }
          continue;
        }
        closest = players[index];
        closest_dist = dist;
      }
    }
    self.last_closest_player = closest;
  }
  if(players.size > 1 && isdefined(closest)) {
    self zm_utility::approximate_path_dist(closest);
  }
  self factory_validate_last_closest_player(players);
  return self.last_closest_player;
}

function private update_closest_player() {
  level waittill("start_of_round");
  while (true) {
    reset_closest_player = 1;
    zombies = zombie_utility::get_round_enemy_array();
    foreach(zombie in zombies) {
      if(isdefined(zombie.need_closest_player) && zombie.need_closest_player) {
        reset_closest_player = 0;
        break;
      }
    }
    if(reset_closest_player) {
      foreach(zombie in zombies) {
        if(isdefined(zombie.need_closest_player)) {
          zombie.need_closest_player = 1;
        }
      }
    }
    wait(0.05);
  }
}