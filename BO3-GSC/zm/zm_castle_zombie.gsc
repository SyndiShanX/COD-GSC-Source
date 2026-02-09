/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_zombie.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace zm_castle_zombie;

function autoexec init() {
  initzmcastlebehaviorsandasm();
  level.var_4fb25bb9 = [];
  level.var_4fb25bb9["walk"] = 4;
  level.var_4fb25bb9["run"] = 4;
  level.var_4fb25bb9["sprint"] = 4;
  level.var_4fb25bb9["crawl"] = 3;
  setDvar("tu5_zmPathDistanceCheckTolarance", 20);
  setDvar("scr_zm_use_code_enemy_selection", 0);
  level.closest_player_override = &castle_closest_player;
  level thread update_closest_player();
  thread castle_zombie_devgui();
  level.move_valid_poi_to_navmesh = 1;
  level.pathdist_type = 2;
}

function private initzmcastlebehaviorsandasm() {
  animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie", &teleporttraversalmocompstart, undefined, undefined);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldMoveLowg", &shouldmovelowg);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zodShouldMove", &zodshouldmove);
}

function teleporttraversalmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("normal");
  if(isDefined(entity.traverseendnode)) {
    print3d(entity.traversestartnode.origin, "", (1, 0, 0), 1, 1, 60);
    print3d(entity.traverseendnode.origin, "", (0, 1, 0), 1, 1, 60);
    line(entity.traversestartnode.origin, entity.traverseendnode.origin, (0, 1, 0), 1, 0, 60);
    entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
  }
}

function zodshouldmove(entity) {
  if(isDefined(entity.zombie_tesla_hit) && entity.zombie_tesla_hit && (!(isDefined(entity.tesla_death) && entity.tesla_death))) {
    return false;
  }
  if(isDefined(entity.pushed) && entity.pushed) {
    return false;
  }
  if(isDefined(entity.knockdown) && entity.knockdown) {
    return false;
  }
  if(isDefined(entity.grapple_is_fatal) && entity.grapple_is_fatal) {
    return false;
  }
  if(level.wait_and_revive) {
    if(!(isDefined(entity.var_1e3fb1c) && entity.var_1e3fb1c)) {
      return false;
    }
  }
  if(isDefined(entity.stumble)) {
    return false;
  }
  if(zombiebehavior::zombieshouldmeleecondition(entity)) {
    return false;
  }
  if(entity haspath()) {
    return true;
  }
  if(isDefined(entity.keep_moving) && entity.keep_moving) {
    return true;
  }
  return false;
}

function shouldmovelowg(entity) {
  return isDefined(entity.low_gravity) && entity.low_gravity;
}

function set_gravity(gravity) {
  if(gravity == "low") {
    self.low_gravity = 1;
    if(isDefined(self.missinglegs) && self.missinglegs) {
      self.low_gravity_variant = randomint(level.var_4fb25bb9["crawl"]);
    } else {
      self.low_gravity_variant = randomint(level.var_4fb25bb9[self.zombie_move_speed]);
    }
  } else if(gravity == "normal") {
    self.low_gravity = 0;
  }
}

function function_7b63bf24(player) {
  var_b9ec9b33 = 0;
  var_ef36a2fe = 0;
  if(self.archetype == "mechz") {
    if(self zm_zonemgr::entity_in_zone("zone_undercroft")) {
      a_players = getplayers();
      var_2ace9ca5 = 0;
      var_949334ad = 0;
      foreach(target in a_players) {
        if(zombie_utility::is_player_valid(target, 1) && target zm_zonemgr::entity_in_zone("zone_undercroft")) {
          var_949334ad = var_949334ad + 1;
          if(target iswallrunning() || !target isonground()) {
            var_2ace9ca5 = var_2ace9ca5 + 1;
          }
        }
      }
      if(var_2ace9ca5 < var_949334ad && (player iswallrunning() || !player isonground())) {
        return false;
      }
    }
    return true;
  }
  if(isDefined(self.zone_name)) {
    if(self.zone_name == "zone_v10_pad" || self.zone_name == "zone_v10_pad_door" || self.zone_name == "zone_v10_pad_exterior") {
      var_b9ec9b33 = 1;
      if(!(isDefined(level.zones["zone_v10_pad_door"].is_spawning_allowed) && level.zones["zone_v10_pad_door"].is_spawning_allowed)) {
        var_2d8a543 = getent("zone_v10_pad", "targetname");
        if(!self istouching(var_2d8a543)) {
          return false;
        }
      }
    }
  }
  if(isDefined(player.zone_name)) {
    if(player.zone_name == "zone_v10_pad" || player.zone_name == "zone_v10_pad_door" || player.zone_name == "zone_v10_pad_exterior") {
      var_ef36a2fe = 1;
    }
  }
  if(var_b9ec9b33 == var_ef36a2fe) {
    return true;
  }
  return false;
}

function private castle_validate_last_closest_player(players) {
  if(isDefined(self.last_closest_player) && (isDefined(self.last_closest_player.am_i_valid) && self.last_closest_player.am_i_valid)) {
    return;
  }
  self.need_closest_player = 1;
  foreach(player in players) {
    if(self function_7b63bf24(player)) {
      self.last_closest_player = player;
      return;
    }
  }
  self.last_closest_player = undefined;
}

function private function_ca4f6cd2(player) {
  if(isDefined(player.zone_name)) {
    if(player.zone_name == "zone_v10_pad") {
      dist = distance(player.origin, self.origin);
      return dist;
    }
  }
  dist = self zm_utility::approximate_path_dist(player);
  return dist;
}

function private castle_closest_player(origin, var_6c55ba74) {
  aiprofile_beginentry("castle_closest_player");
  players = array::filter(var_6c55ba74, 0, &function_4fee0339);
  if(players.size == 0) {
    aiprofile_endentry();
    return undefined;
  }
  if(isDefined(self.zombie_poi)) {
    aiprofile_endentry();
    return undefined;
  }
  if(players.size == 1) {
    if(self function_7b63bf24(players[0])) {
      self.last_closest_player = players[0];
      aiprofile_endentry();
      return self.last_closest_player;
    }
    aiprofile_endentry();
    return undefined;
  }
  if(!isDefined(self.last_closest_player)) {
    self.last_closest_player = players[0];
  }
  if(!isDefined(self.need_closest_player)) {
    self.need_closest_player = 1;
  }
  if(isDefined(level.last_closest_time) && level.last_closest_time >= level.time) {
    self castle_validate_last_closest_player(players);
    aiprofile_endentry();
    return self.last_closest_player;
  }
  if(isDefined(self.need_closest_player) && self.need_closest_player) {
    level.last_closest_time = level.time;
    self.need_closest_player = 0;
    closest = players[0];
    closest_dist = undefined;
    if(self function_7b63bf24(players[0])) {
      closest_dist = self function_ca4f6cd2(closest);
    }
    if(!isDefined(closest_dist)) {
      closest = undefined;
    }
    for(index = 1; index < players.size; index++) {
      dist = undefined;
      if(self function_7b63bf24(players[index])) {
        dist = self function_ca4f6cd2(players[index]);
      }
      if(isDefined(dist)) {
        if(isDefined(closest_dist)) {
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
  if(players.size > 1 && isDefined(closest)) {
    self zm_utility::approximate_path_dist(closest);
  }
  self castle_validate_last_closest_player(players);
  aiprofile_endentry();
  return self.last_closest_player;
}

function private function_4fee0339(player) {
  if(!isDefined(player) || !isalive(player) || !isPlayer(player) || player.sessionstate == "spectator" || player.sessionstate == "intermission" || player laststand::player_is_in_laststand() || player.ignoreme) {
    return false;
  }
  return true;
}

function private update_closest_player() {
  level waittill("start_of_round");
  while(true) {
    reset_closest_player = 1;
    zombies = zombie_utility::get_round_enemy_array();
    var_6aad1b23 = getaiarchetypearray("mechz", level.zombie_team);
    if(var_6aad1b23.size) {
      zombies = arraycombine(zombies, var_6aad1b23, 0, 0);
    }
    foreach(zombie in zombies) {
      if(isDefined(zombie.need_closest_player) && zombie.need_closest_player) {
        reset_closest_player = 0;
        break;
      }
    }
    if(reset_closest_player) {
      foreach(zombie in zombies) {
        if(isDefined(zombie.need_closest_player)) {
          zombie.need_closest_player = 1;
        }
      }
    }
    wait(0.05);
  }
}

function private castle_zombie_devgui() {
  level flagsys::wait_till("");
  zm_devgui::add_custom_devgui_callback(&castle_zombie_devgui_callback);
  adddebugcommand("");
}

function private castle_zombie_devgui_callback(cmd) {
  switch (cmd) {
    case "": {
      if(!isDefined(level.var_c43a1504)) {
        level.var_c43a1504 = 1;
      } else {
        level.var_c43a1504 = !level.var_c43a1504;
      }
      zombies = getaispeciesarray(level.zombie_team, "");
      foreach(zombie in zombies) {
        if(isDefined(level.var_c43a1504) && level.var_c43a1504) {
          zombie set_gravity("");
          if(zombie ai::has_behavior_attribute("")) {
            zombie ai::set_behavior_attribute("", "");
          }
          continue;
        }
        zombie set_gravity("");
        if(zombie ai::has_behavior_attribute("")) {
          zombie ai::set_behavior_attribute("", "");
        }
      }
      break;
    }
  }
}