/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_zombie.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_behavior;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_genesis_portals;
#namespace zm_genesis_zombie;

function autoexec init() {
  initzmgenesisbehaviorsandasm();
  setdvar("scr_zm_use_code_enemy_selection", 0);
  level.closest_player_override = &genesis_closest_player;
  level.pathdist_type = 2;
  level.custom_rise_func = &genesis_custom_rise_func;
  level.zm_custom_spawn_location_selection = &genesis_custom_spawn_location_selection;
  level.should_zigzag = &genesis_should_zigzag;
  level.validate_on_navmesh = 1;
  level thread update_closest_player();
  level thread function_68528574();
  spawner::add_archetype_spawn_function("zombie", &function_e0c0cb69);
  spawner::add_archetype_spawn_function("spider", &function_6c5e4588);
  callback::on_spawned(&function_a11812c);
  level.octobomb_targets = &genesis_octobomb_targets;
}

function private function_68528574() {
  level.var_a397a77 = [];
  level.var_a397a77[level.var_a397a77.size] = "start_island";
  level.var_a397a77[level.var_a397a77.size] = "apothicon_island";
  level.var_a397a77[level.var_a397a77.size] = "temple_island";
  level.var_a397a77[level.var_a397a77.size] = "prototype_island";
  level.var_a397a77[level.var_a397a77.size] = "asylum_island";
  level.var_a397a77[level.var_a397a77.size] = "prison_island";
  level.var_15ba7eb8 = [];
  foreach(island in level.var_a397a77) {
    level.var_15ba7eb8[level.var_15ba7eb8.size] = getent(island, "targetname");
  }
}

function private initzmgenesisbehaviorsandasm() {
  animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie", &teleporttraversalmocompstart, undefined, undefined);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldMoveLowg", &shouldmovelowg);
}

function shouldmovelowg(entity) {
  return isDefined(entity.low_gravity) && entity.low_gravity;
}

function private function_6c5e4588() {
  self thread zm::update_zone_name();
  self.can_reach_enemy = &function_2f50c929;
}

function private function_2f50c929() {
  if(isDefined(self.enemy) && isDefined(self.enemy.zone_name)) {
    if(isDefined(self.zone_name)) {
      var_51042e52 = self.zone_name == "apothicon_interior_zone";
      var_be94e0a7 = self.enemy.zone_name == "apothicon_interior_zone";
      if(var_51042e52 != var_be94e0a7) {
        return false;
      }
    }
  }
  return true;
}

function private function_e0c0cb69() {
  self thread function_2fa8f151();
  self thread function_bb062ca5();
  self.traversalspeedboost = &function_1108488e;
}

function private function_a11812c() {
  self thread function_dc84c8cc();
}

function private genesis_octobomb_targets(targets) {
  zombies = getactorteamarray(level.zombie_team);
  foreach(zombie in zombies) {
    if(zombie.archetype == "keeper" || zombie.archetype == "apothicon_fury") {
      if(!isDefined(targets)) {
        targets = [];
      } else if(!isarray(targets)) {
        targets = array(targets);
      }
      targets[targets.size] = zombie;
    }
  }
  return targets;
}

function function_dc84c8cc() {
  self endon("death");
  self endon("disconnnect");
  var_c17e74e6 = gettime();
  var_eaacaebf = level.round_number;
  var_e274e0c3 = undefined;
  var_a83e7943 = 900000;
  var_320b8666 = 900000;
  var_ed78383b = 7;
  while(isDefined(self)) {
    self.var_a3d40b8 = undefined;
    foreach(volume in level.var_15ba7eb8) {
      if(self istouching(volume)) {
        var_7da7c388 = gettime() - var_c17e74e6;
        if(var_7da7c388 > var_a83e7943) {
          level notify("hash_b1d69866", self);
        }
        if(var_7da7c388 > var_320b8666) {
          if(var_e274e0c3 == "apothicon_island") {
            level notify("hash_8dbe1895", self);
          }
        }
        var_42215f9c = level.round_number - var_eaacaebf;
        if(var_42215f9c > var_ed78383b) {
          if(var_e274e0c3 == "prototype_island") {
            level notify("hash_e15c8839", self);
          }
        }
        if(isDefined(var_e274e0c3) && var_e274e0c3 != volume.targetname) {
          var_c17e74e6 = gettime();
          var_eaacaebf = level.round_number;
        }
        self.var_a3d40b8 = volume.targetname;
        var_e274e0c3 = self.var_a3d40b8;
        break;
      }
    }
    wait(randomfloatrange(0.5, 1));
  }
}

function function_2fa8f151() {
  self endon("death");
  self endon("disconnnect");
  while(isDefined(self)) {
    self.var_a3d40b8 = undefined;
    foreach(volume in level.var_15ba7eb8) {
      if(self istouching(volume)) {
        self.var_a3d40b8 = volume.targetname;
        break;
      }
    }
    wait(randomfloatrange(0.5, 1));
  }
}

function function_bb062ca5() {
  self pushactors(0);
}

function private function_1108488e() {
  traversal = self.traversal;
  speedboost = 0;
  if(traversal.abslengthtoend > 200) {
    speedboost = 32;
  } else {
    if(traversal.abslengthtoend > 120) {
      speedboost = 16;
    } else if(traversal.abslengthtoend > 80 || traversal.absheighttoend > 80) {
      speedboost = 8;
    }
  }
  return speedboost;
}

function teleporttraversalmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.is_teleporting = 1;
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("normal");
  if(isDefined(entity.traversestartnode)) {
    portal_trig = entity.traversestartnode.portal_trig;
    if(isDefined(portal_trig)) {
      portal_trig thread zm_genesis_portals::portal_teleport_ai(entity);
    }
  }
}

function function_ca420408(player) {
  if(isDefined(self.b_ignore_cleanup) && self.b_ignore_cleanup) {
    return true;
  }
  if(isDefined(player.b_teleporting) && player.b_teleporting) {
    return false;
  }
  if(isDefined(player.var_a393601c) && player.var_a393601c) {
    return false;
  }
  var_bc4ca8d7 = 0;
  var_85d379f2 = 0;
  player_in_apothicon = 0;
  var_a70fdedb = 0;
  if(isDefined(player.zone_name)) {
    if(player.zone_name == "dark_arena_zone" || player.zone_name == "dark_arena2_zone") {
      var_bc4ca8d7 = 1;
    }
    if(player.zone_name == "apothicon_interior_zone") {
      player_in_apothicon = 1;
    }
  }
  if(isDefined(self.zone_name)) {
    if(self.zone_name == "dark_arena_zone" || self.zone_name == "dark_arena2_zone") {
      var_85d379f2 = 1;
    }
    if(self.zone_name == "apothicon_interior_zone") {
      var_a70fdedb = 1;
    }
  }
  if(var_bc4ca8d7 && !var_85d379f2) {
    return false;
  }
  if(!var_bc4ca8d7 && var_85d379f2) {
    return false;
  }
  if(player_in_apothicon && !var_a70fdedb) {
    return false;
  }
  if(!player_in_apothicon && var_a70fdedb) {
    return false;
  }
  return true;
}

function private function_f01c3337(players) {
  if(isDefined(self.last_closest_player) && (isDefined(self.last_closest_player.am_i_valid) && self.last_closest_player.am_i_valid) && self function_ca420408(self.last_closest_player)) {
    return;
  }
  self.need_closest_player = 1;
  foreach(player in players) {
    if(self function_ca420408(player)) {
      self.last_closest_player = player;
      return;
    }
  }
  self.last_closest_player = undefined;
}

function genesis_custom_rise_func(s_spot) {
  str_anim = "ai_zombie_traverse_ground_climbout_fast";
  if(isDefined(s_spot.speed)) {
    var_a1df9af9 = array("ai_zm_dlc2_zombie_quick_rise_v1", "ai_zm_dlc2_zombie_quick_rise_v2", "ai_zm_dlc2_zombie_quick_rise_v3");
    str_anim = array::random(var_a1df9af9);
    self show();
  }
  self animscripted("rise_anim", self.origin, s_spot.angles, str_anim);
}

function private genesis_closest_player(origin, players) {
  keepers = getactorteamarray("allies");
  foreach(keeper in keepers) {
    if(isDefined(keeper.allow_zombie_to_target_ai) && keeper.allow_zombie_to_target_ai) {
      return keeper;
    }
  }
  if(players.size == 0) {
    return undefined;
  }
  if(isDefined(self.zombie_poi)) {
    return undefined;
  }
  if(players.size == 1) {
    if(self function_ca420408(players[0])) {
      self.last_closest_player = players[0];
      return self.last_closest_player;
    }
    return undefined;
  }
  if(!isDefined(self.last_closest_player)) {
    self.last_closest_player = players[0];
  }
  if(!isDefined(self.need_closest_player)) {
    self.need_closest_player = 1;
  }
  if(isDefined(level.last_closest_time) && level.last_closest_time >= level.time) {
    self function_f01c3337(players);
    return self.last_closest_player;
  }
  if(isDefined(self.need_closest_player) && self.need_closest_player) {
    level.last_closest_time = level.time;
    self.need_closest_player = 0;
    closest = players[0];
    closest_dist = undefined;
    if(self function_ca420408(players[0])) {
      closest_dist = self zm_utility::approximate_path_dist(closest);
    }
    if(!isDefined(closest_dist)) {
      closest = undefined;
    }
    for(index = 1; index < players.size; index++) {
      dist = undefined;
      if(self function_ca420408(players[index])) {
        dist = self zm_utility::approximate_path_dist(players[index]);
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
  self function_f01c3337(players);
  return self.last_closest_player;
}

function private update_closest_player() {
  level waittill("start_of_round");
  while(true) {
    reset_closest_player = 1;
    zombies = getactorteamarray(level.zombie_team);
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

function genesis_custom_spawn_location_selection(a_spots) {
  if(math::cointoss()) {
    if(!isDefined(level.n_player_spawn_selection_index)) {
      level.n_player_spawn_selection_index = 0;
    }
    e_player = level.players[level.n_player_spawn_selection_index];
    level.n_player_spawn_selection_index++;
    if(level.n_player_spawn_selection_index > (level.players.size - 1)) {
      level.n_player_spawn_selection_index = 0;
    }
    if(!zm_utility::is_player_valid(e_player)) {
      s_spot = array::random(a_spots);
      return s_spot;
    }
    var_e8c67fc0 = array::get_all_closest(e_player.origin, a_spots, undefined, 5);
    var_b008ef9a = [];
    v_player_dir = anglesToForward(e_player.angles);
    for(i = 0; i < var_e8c67fc0.size; i++) {
      v_dir = var_e8c67fc0[i].origin - e_player.origin;
      n_dp = vectordot(v_player_dir, v_dir);
      if(n_dp >= 0) {
        var_b008ef9a[var_b008ef9a.size] = var_e8c67fc0[i];
      }
    }
    if(var_b008ef9a.size) {
      s_spot = array::random(var_b008ef9a);
    } else {
      if(var_e8c67fc0.size) {
        s_spot = array::random(var_e8c67fc0);
      } else {
        s_spot = array::random(a_spots);
      }
    }
  } else {
    s_spot = array::random(a_spots);
  }
  return s_spot;
}

function genesis_should_zigzag() {
  if(isDefined(self.var_b6b1080c) && self.var_b6b1080c) {
    return false;
  }
  if(isDefined(self.var_a3d40b8)) {
    player = self.favoriteenemy;
    if(isDefined(player) && isDefined(player.var_a3d40b8)) {
      if(self.var_a3d40b8 != player.var_a3d40b8) {
        return false;
      }
    }
  }
  return true;
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