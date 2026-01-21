/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_spawner.gsc
****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_net;
#include maps\_zombiemode_audio;
#using_animtree("generic_human");
init() {
  level._CONTEXTUAL_GRAB_LERP_TIME = .3;
  zombies = getEntArray("zombie_spawner", "script_noteworthy");
  for(i = 0; i < zombies.size; i++) {
    if(is_spawner_targeted_by_blocker(zombies[i])) {
      zombies[i].is_enabled = false;
    }
  }
  array_thread(zombies, ::add_spawn_function, ::zombie_spawn_init);
  array_thread(zombies, ::add_spawn_function, maps\_zombiemode::round_spawn_failsafe);
}

#using_animtree("generic_human");
is_spawner_targeted_by_blocker(ent) {
  if(isDefined(ent.targetname)) {
    targeters = getEntArray(ent.targetname, "target");
    for(i = 0; i < targeters.size; i++) {
      if(targeters[i].targetname == "zombie_door" || targeters[i].targetname == "zombie_debris") {
        return true;
      }
      result = is_spawner_targeted_by_blocker(targeters[i]);
      if(result) {
        return true;
      }
    }
  }
  return false;
}

zombie_spawn_init(animname_set) {
  if(!isDefined(animname_set)) {
    animname_set = false;
  }
  self.targetname = "zombie";
  self.script_noteworthy = undefined;
  if(!animname_set) {
    self.animname = "zombie";
  }
  self thread play_ambient_zombie_vocals();
  self.ignoreall = true;
  self.ignoreme = true;
  self.allowdeath = true;
  self.force_gib = true;
  self.is_zombie = true;
  self.has_legs = true;
  self allowedStances("stand");
  self.zombie_damaged_by_bar_knockdown = false;
  self.gibbed = false;
  self.head_gibbed = false;
  self PushPlayer(true);
  self.disableArrivals = true;
  self.disableExits = true;
  self.grenadeawareness = 0;
  self.badplaceawareness = 0;
  self.ignoreSuppression = true;
  self.suppressionThreshold = 1;
  self.noDodgeMove = true;
  self.dontShootWhileMoving = true;
  self.pathenemylookahead = 0;
  self.badplaceawareness = 0;
  self.chatInitialized = false;
  self.a.disablepain = true;
  self disable_react();
  self.maxhealth = level.zombie_health;
  self.health = level.zombie_health;
  self.freezegun_damage = 0;
  self.dropweapon = false;
  level thread zombie_death_event(self);
  self set_zombie_run_cycle();
  self thread zombie_think();
  self thread zombie_gib_on_damage();
  self thread zombie_damage_failsafe();
  if(!isDefined(self.no_eye_glow) || !self.no_eye_glow) {
    self thread delayed_zombie_eye_glow();
  }
  self.deathFunction = ::zombie_death_animscript;
  self.flame_damage_time = 0;
  self.meleeDamage = 60;
  self zombie_history("zombie_spawn_init -> Spawned = " + self.origin);
  self.thundergun_disintegrate_func = ::zombie_disintegrate;
  self.thundergun_knockdown_func = ::zombie_knockdown;
  self.tesla_head_gib_func = ::zombie_tesla_head_gib;
  self setTeamForEntity("axis");
  self notify("zombie_init_done");
}

delayed_zombie_eye_glow() {
  self endon("zombie_delete");
  wait .5;
  self zombie_eye_glow();
}

zombie_damage_failsafe() {
  self endon("death");
  continue_failsafe_damage = false;
  while(1) {
    wait 0.5;
    if(!isDefined(self.enemy) || !IsPlayer(self.enemy)) {
      continue;
    }
    if(self istouching(self.enemy)) {
      old_org = self.origin;
      if(!continue_failsafe_damage) {
        wait 5;
      }
      if(!isDefined(self.enemy) || !IsPlayer(self.enemy) || self.enemy hasperk("specialty_armorvest")) {
        continue;
      }
      if(self istouching(self.enemy) && !self.enemy maps\_laststand::player_is_in_laststand() && isalive(self.enemy)) {
        if(distancesquared(old_org, self.origin) < (60 * 60)) {
          setsaveddvar("player_deathInvulnerableTime", 0);
          self.enemy DoDamage(self.enemy.health + 1000, self.enemy.origin, undefined, undefined, "riflebullet");
          setsaveddvar("player_deathInvulnerableTime", level.startInvulnerableTime);
          continue_failsafe_damage = true;
        }
      }
    } else {
      continue_failsafe_damage = false;
    }
  }
}

set_zombie_run_cycle(new_move_speed) {
  if(isDefined(new_move_speed)) {
    self.zombie_move_speed = new_move_speed;
  } else {
    self set_run_speed();
    self.zombie_move_speed_original = self.zombie_move_speed;
  }
  self.needs_run_update = true;
  death_anims = level._zombie_deaths[self.animname];
  self.deathanim = random(death_anims);
  switch (self.zombie_move_speed) {
    case "walk":
      var = randomintrange(1, 8);
      self set_run_anim("walk" + var);
      self.run_combatanim = level.scr_anim[self.animname]["walk" + var];
      break;
    case "run":
      var = randomintrange(1, 6);
      self set_run_anim("run" + var);
      self.run_combatanim = level.scr_anim[self.animname]["run" + var];
      break;
    case "sprint":
      var = randomintrange(1, 4);
      self set_run_anim("sprint" + var);
      self.run_combatanim = level.scr_anim[self.animname]["sprint" + var];
      break;
  }
}

set_run_speed() {
  rand = randomintrange(level.zombie_move_speed, level.zombie_move_speed + 35);
  if(rand <= 35) {
    self.zombie_move_speed = "walk";
  } else if(rand <= 70) {
    self.zombie_move_speed = "run";
  } else {
    self.zombie_move_speed = "sprint";
  }
}

should_skip_teardown(rise_struct_string) {
  if(isDefined(rise_struct_string) && rise_struct_string == "find_flesh") {
    return true;
  }
  if(isDefined(self.script_string) && self.script_string == "zombie_chaser") {
    return true;
  }
  return false;
}

zombie_think() {
  self endon("death");
  assert(!self.isdog);
  rise_struct_string = undefined;
  if(GetDvarInt(#"zombie_rise_test") || (isDefined(self.script_string) && self.script_string == "riser")) {
    self thread do_zombie_rise();
    self waittill("risen", rise_struct_string);
  } else {
    self notify("no_rise");
  }
  node = undefined;
  desired_nodes = [];
  self.entrance_nodes = [];
  if(isDefined(level.max_barrier_search_dist_override)) {
    max_dist = level.max_barrier_search_dist_override;
  } else {
    max_dist = 500;
  }
  if(isDefined(self.target) && self.target != "") {
    desired_origin = get_desired_origin();
    AssertEx(isDefined(desired_origin), "Spawner @ " + self.origin + " has a .target but did not find a target");
    origin = desired_origin;
    node = getclosest(origin, level.exterior_goals);
    self.entrance_nodes[0] = node;
    self zombie_history("zombie_think -> #1 entrance (script_forcegoal) origin = " + self.entrance_nodes[0].origin);
  } else if(self should_skip_teardown(rise_struct_string)) {
    self zombie_setup_attack_properties();
    if(isDefined(self.target)) {
      end_at_node = GetNode(self.target, "targetname");
      if(isDefined(end_at_node)) {
        self setgoalnode(end_at_node);
        self waittill("goal");
      }
    }
    self thread find_flesh();
    return;
  } else {
    origin = self.origin;
    desired_origin = get_desired_origin();
    if(isDefined(desired_origin)) {
      origin = desired_origin;
    }
    nodes = get_array_of_closest(origin, level.exterior_goals, undefined, 3);
    desired_nodes[0] = nodes[0];
    prev_dist = Distance(self.origin, nodes[0].origin);
    for(i = 1; i < nodes.size; i++) {
      dist = Distance(self.origin, nodes[i].origin);
      if((dist - prev_dist) > max_dist) {
        break;
      }
      prev_dist = dist;
      desired_nodes[i] = nodes[i];
    }
    node = desired_nodes[0];
    if(desired_nodes.size > 1) {
      node = desired_nodes[randomInt(desired_nodes.size)];
    }
    self.entrance_nodes = desired_nodes;
    self zombie_history("zombie_think -> #1 entrance origin = " + node.origin);
    self thread zombie_assure_node();
  }
  AssertEx(isDefined(node), "Did not find a node!!! [Should not see this!]");
  level thread draw_line_ent_to_pos(self, node.origin, "goal");
  self.first_node = node;
  self thread zombie_goto_entrance(node);
}

get_desired_origin() {
  if(isDefined(self.target)) {
    ent = getEnt(self.target, "targetname");
    if(!isDefined(ent)) {
      ent = getstruct(self.target, "targetname");
    }
    if(!isDefined(ent)) {
      ent = GetNode(self.target, "targetname");
    }
    AssertEx(isDefined(ent), "Cannot find the targeted ent/node/struct, \"" + self.target + "\" at " + self.origin);
    return ent.origin;
  }
  return undefined;
}

zombie_goto_entrance(node, endon_bad_path) {
  assert(!self.isdog);
  self endon("death");
  level endon("intermission");
  if(isDefined(endon_bad_path) && endon_bad_path) {
    self endon("bad_path");
  }
  self zombie_history("zombie_goto_entrance -> start goto entrance " + node.origin);
  self.got_to_entrance = false;
  self.goalradius = 128;
  self SetGoalPos(node.origin);
  self waittill("goal");
  self.got_to_entrance = true;
  self zombie_history("zombie_goto_entrance -> reached goto entrance " + node.origin);
  self tear_into_building();
  if(isDefined(self.first_node.clip)) {
    if(!isDefined(self.first_node.clip.disabled) || !self.first_node.clip.disabled) {
      self.first_node.clip disable_trigger();
      self.first_node.clip connectpaths();
    }
  }
  self zombie_setup_attack_properties();
  if(isDefined(level.pre_aggro_pathfinding_func)) {
    self[[level.pre_aggro_pathfinding_func]]();
  }
  self thread find_flesh();
}

zombie_assure_node() {
  self endon("death");
  self endon("goal");
  level endon("intermission");
  start_pos = self.origin;
  if(isDefined(self.entrance_nodes)) {
    for(i = 0; i < self.entrance_nodes.size; i++) {
      if(self zombie_bad_path()) {
        self zombie_history("zombie_assure_node -> assigned assured node = " + self.entrance_nodes[i].origin);
        println("^1Zombie @ " + self.origin + " did not move for 1 second. Going to next closest node @ " + self.entrance_nodes[i].origin);
        level thread draw_line_ent_to_pos(self, self.entrance_nodes[i].origin, "goal");
        self.first_node = self.entrance_nodes[i];
        self SetGoalPos(self.entrance_nodes[i].origin);
      } else {
        return;
      }
    }
  }
  wait(2);
  nodes = get_array_of_closest(self.origin, level.exterior_goals, undefined, 20);
  if(isDefined(nodes)) {
    self.entrance_nodes = nodes;
    for(i = 0; i < self.entrance_nodes.size; i++) {
      if(self zombie_bad_path()) {
        self zombie_history("zombie_assure_node -> assigned assured node = " + self.entrance_nodes[i].origin);
        println("^1Zombie @ " + self.origin + " did not move for 1 second. Going to next closest node @ " + self.entrance_nodes[i].origin);
        level thread draw_line_ent_to_pos(self, self.entrance_nodes[i].origin, "goal");
        self.first_node = self.entrance_nodes[i];
        self SetGoalPos(self.entrance_nodes[i].origin);
      } else {
        return;
      }
    }
  }
  self zombie_history("zombie_assure_node -> failed to find a good entrance point");
  wait(20);
  self DoDamage(self.health + 10, self.origin);
}

zombie_bad_path() {
  self endon("death");
  self endon("goal");
  self thread zombie_bad_path_notify();
  self thread zombie_bad_path_timeout();
  self.zombie_bad_path = undefined;
  while(!isDefined(self.zombie_bad_path)) {
    wait(0.05);
  }
  self notify("stop_zombie_bad_path");
  return self.zombie_bad_path;
}

zombie_bad_path_notify() {
  self endon("death");
  self endon("stop_zombie_bad_path");
  self waittill("bad_path");
  self.zombie_bad_path = true;
}

zombie_bad_path_timeout() {
  self endon("death");
  self endon("stop_zombie_bad_path");
  wait(2);
  self.zombie_bad_path = false;
}

tear_into_building() {
  self endon("death");
  self endon("teleporting");
  self zombie_history("tear_into_building -> start");
  while(1) {
    if(isDefined(self.first_node.script_noteworthy)) {
      if(self.first_node.script_noteworthy == "no_blocker") {
        return;
      }
    }
    if(!isDefined(self.first_node.target)) {
      return;
    }
    if(all_chunks_destroyed(self.first_node.barrier_chunks)) {
      self zombie_history("tear_into_building -> all chunks destroyed");
    }
    if(!get_attack_spot(self.first_node)) {
      self zombie_history("tear_into_building -> Could not find an attack spot");
      self thread do_a_taunt();
      wait(0.5);
      continue;
    }
    self.goalradius = 2;
    self SetGoalPos(self.attacking_spot, self.first_node.angles);
    attacking_spot1a = self.attacking_spot;
    self waittill("goal");
    self waittill_notify_or_timeout("orientdone", 1);
    self zombie_history("tear_into_building -> Reach position and orientated");
    if(all_chunks_destroyed(self.first_node.barrier_chunks)) {
      self zombie_history("tear_into_building -> all chunks destroyed");
      for(i = 0; i < self.first_node.attack_spots_taken.size; i++) {
        self.first_node.attack_spots_taken[i] = false;
      }
      return;
    }
    while(1) {
      chunk = get_closest_non_destroyed_chunk(self.origin, self.first_node.barrier_chunks);
      if(!isDefined(chunk)) {
        if(!all_chunks_destroyed(self.first_node.barrier_chunks)) {
          attack = self should_attack_player_thru_boards();
          if(isDefined(attack) && !attack && self.has_legs) {
            self do_a_taunt();
          } else {
            wait_network_frame();
          }
          continue;
        }
        for(i = 0; i < self.first_node.attack_spots_taken.size; i++) {
          self.first_node.attack_spots_taken[i] = false;
        }
        return;
      }
      self zombie_history("tear_into_building -> animating");
      tear_anim = get_tear_anim(chunk, self);
      chunk maps\_zombiemode_blockers::update_states("target_by_zombie");
      self thread maps\_zombiemode_audio::do_zombies_playvocals("teardown", self.animname);
      self AnimScripted("tear_anim", attacking_spot1a, self.first_node.angles, tear_anim, "normal", undefined, 1, 0.3);
      if(tear_anim == % ai_zombie_bar_bend_l || tear_anim == % ai_zombie_bar_bend_l_2 || tear_anim == % ai_zombie_bar_bend_r || tear_anim == % ai_zombie_bar_bend_r_2 || tear_anim == % ai_zombie_bar_bend_m_1 || tear_anim == % ai_zombie_bar_bend_m_2) {
        self playSound("zmb_bar_bend");
      }
      self zombie_tear_notetracks("tear_anim", chunk, self.first_node);
      attack = self should_attack_player_thru_boards();
      if(isDefined(attack) && !attack && self.has_legs) {
        self do_a_taunt();
      }
      if(all_chunks_destroyed(self.first_node.barrier_chunks)) {
        for(i = 0; i < self.first_node.attack_spots_taken.size; i++) {
          self.first_node.attack_spots_taken[i] = false;
        }
        return;
      }
    }
    self reset_attack_spot();
  }
}

do_a_taunt() {
  self endon("death");
  if(!self.has_legs) {
    return false;
  }
  self.old_origin = self.origin;
  if(getDvar(#"zombie_taunt_freq") == "") {
    setdvar("zombie_taunt_freq", "5");
  }
  freq = GetDvarInt(#"zombie_taunt_freq");
  if(freq >= randomInt(100)) {
    anime = random(level._zombie_board_taunt[self.animname]);
    self thread maps\_zombiemode_audio::do_zombies_playvocals("taunt", self.animname);
    self animscripted("zombie_taunt", self.origin, self.angles, anime, "normal", undefined, 1, 0.4);
    wait(getanimlength(anime));
    self ForceTeleport(self.old_origin);
  }
}

should_attack_player_thru_boards() {
  if(!self.has_legs) {
    return false;
  }
  if(isDefined(self.first_node.barrier_chunks)) {
    for(i = 0; i < self.first_node.barrier_chunks.size; i++) {
      if(isDefined(self.first_node.barrier_chunks[i].unbroken) && self.first_node.barrier_chunks[i].unbroken == true) {
        return false;
      }
    }
  }
  if(getDvar(#"zombie_reachin_freq") == "") {
    setdvar("zombie_reachin_freq", "50");
  }
  freq = GetDvarInt(#"zombie_reachin_freq");
  players = get_players();
  attack = false;
  self.player_targets = [];
  for(i = 0; i < players.size; i++) {
    if(distance2d(self.origin, players[i].origin) <= 72) {
      self.player_targets[self.player_targets.size] = players[i];
      attack = true;
    }
  }
  if(attack && freq >= randomInt(100)) {
    self.old_origin = self.origin;
    if(self.attacking_spot_index == 0) {
      if(randomInt(100) > 50) {
        self thread maps\_zombiemode_audio::do_zombies_playvocals("attack", self.animname);
        self animscripted("window_melee", self.origin, self.angles, %ai_zombie_window_attack_arm_l_out, "normal", undefined, 1, 0.3);
      } else {
        self thread maps\_zombiemode_audio::do_zombies_playvocals("attack", self.animname);
        self animscripted("window_melee", self.origin, self.angles, %ai_zombie_window_attack_arm_r_out, "normal", undefined, 1, 0.3);
      }
      self window_notetracks("window_melee");
    } else if(self.attacking_spot_index == 2) {
      self thread maps\_zombiemode_audio::do_zombies_playvocals("attack", self.animname);
      self animscripted("window_melee", self.origin, self.angles, %ai_zombie_window_attack_arm_r_out, "normal", undefined, 1, 0.3);
      self window_notetracks("window_melee");
    } else if(self.attacking_spot_index == 1) {
      self thread maps\_zombiemode_audio::do_zombies_playvocals("attack", self.animname);
      self animscripted("window_melee", self.origin, self.angles, %ai_zombie_window_attack_arm_l_out, "normal", undefined, 1, 0.3);
      self window_notetracks("window_melee");
    }
  } else {
    return false;
  }
}

window_notetracks(msg) {
  while(1) {
    self waittill(msg, notetrack);
    if(notetrack == "end") {
      self teleport(self.old_origin);
      return;
    }
    if(notetrack == "fire") {
      if(self.ignoreall) {
        self.ignoreall = false;
      }
      if(isDefined(self.first_node)) {
        _MELEE_DIST_SQ = 72 * 72;
        _TRIGGER_DIST_SQ = 37 * 37;
        for(i = 0; i < self.player_targets.size; i++) {
          playerDistSq = Distance2DSquared(self.player_targets[i].origin, self.origin);
          heightDiff = abs(self.player_targets[i].origin[2] - self.origin[2]);
          if(playerDistSq < _MELEE_DIST_SQ && (heightDiff * heightDiff) < _MELEE_DIST_SQ) {
            triggerDistSq = Distance2DSquared(self.player_targets[i].origin, self.first_node.trigger_location.origin);
            heightDiff = abs(self.player_targets[i].origin[2] - self.first_node.trigger_location.origin[2]);
            if(triggerDistSq < _TRIGGER_DIST_SQ && (heightDiff * heightDiff) < _TRIGGER_DIST_SQ) {
              self.player_targets[i] DoDamage(self.meleeDamage, self.player_targets[i].origin, self, 0, "MOD_MELEE");
              break;
            }
          }
        }
      } else {
        self melee();
      }
    }
  }
}

reset_attack_spot() {
  if(isDefined(self.attacking_node)) {
    node = self.attacking_node;
    index = self.attacking_spot_index;
    node.attack_spots_taken[index] = false;
    self.attacking_node = undefined;
    self.attacking_spot_index = undefined;
  }
}

get_attack_spot(node) {
  index = get_attack_spot_index(node);
  if(!isDefined(index)) {
    return false;
  }
  self.attacking_node = node;
  self.attacking_spot_index = index;
  node.attack_spots_taken[index] = true;
  self.attacking_spot = node.attack_spots[index];
  return true;
}

get_attack_spot_index(node) {
  indexes = [];
  for(i = 0; i < node.attack_spots.size; i++) {
    if(!node.attack_spots_taken[i]) {
      indexes[indexes.size] = i;
    }
  }
  if(indexes.size == 0) {
    return undefined;
  }
  return indexes[randomInt(indexes.size)];
}

zombie_tear_notetracks(msg, chunk, node) {
  random_chance = undefined;
  self endon("death");
  chunk thread check_for_zombie_death(self);
  while(1) {
    self waittill(msg, notetrack);
    if(notetrack == "end") {
      return;
    }
    if(notetrack == "board") {
      if(!chunk.destroyed) {
        self.lastchunk_destroy_time = getTime();
        playFX(level._effect["wood_chunk_destory"], chunk.origin);
        if(chunk.script_noteworthy == "4" || chunk.script_noteworthy == "6") {
          chunk thread zombie_boardtear_offset_fx_horizontle(chunk, node);
        } else {
          chunk thread zombie_boardtear_offset_fx_verticle(chunk, node);
        }
        zomb = self;
        level thread maps\_zombiemode_blockers::remove_chunk(chunk, node, true, zomb);
        chunk notify("destroyed");
      }
    } else if(notetrack == "bar_bend") {
      if(!chunk.destroyed) {
        self.lastchunk_destroy_time = getTime();
        if(chunk.script_noteworthy == "3") {
          if(isDefined(chunk.script_string)) {
            if(chunk.script_string == "prestine_bend") {
              bar_bend_left = spawn("script_model", chunk.origin);
              bar_bend_left RotateTo(chunk.angles, 0.2, 0.1, 0.1);
              bar_bend_left waittill("rotatedone");
              bar_bend_left setModel("p_zom_win_cell_bars_01_vert01_bent");
              chunk hide();
              thread bar_repair_bend_left(bar_bend_left, chunk);
            } else if(chunk.script_string == "bar_bend") {
              bar_bend_left = spawn("script_model", chunk.origin);
              bar_bend_left RotateTo(chunk.angles, 0.2, 0.1, 0.1);
              bar_bend_left waittill("rotatedone");
              bar_bend_left setModel("p_zom_win_cell_bars_bent_01_vert01_bent");
              chunk hide();
              thread bar_repair_bend_left(bar_bend_left, chunk);
            }
          }
        }
        if(chunk.script_noteworthy == "5") {
          if(isDefined(chunk.script_string)) {
            if(chunk.script_string == "prestine_bend") {
              bar_bend_right = spawn("script_model", chunk.origin);
              bar_bend_right RotateTo(chunk.angles, 0.2, 0.1, 0.1);
              bar_bend_right waittill("rotatedone");
              bar_bend_right setModel("p_zom_win_cell_bars_01_vert04_bent");
              chunk hide();
              thread bar_repair_bend_right(bar_bend_right, chunk);
            } else if(chunk.script_string == "bar_bend") {
              bar_bend_right = spawn("script_model", chunk.origin);
              bar_bend_right RotateTo(chunk.angles, 0.2, 0.1, 0.1);
              bar_bend_right waittill("rotatedone");
              bar_bend_right setModel("p_zom_win_cell_bars_bent_01_vert04_bent");
              chunk hide();
              thread bar_repair_bend_right(bar_bend_right, chunk);
            }
          }
        }
        zomb = self;
        chunk thread zombie_bartear_offset_fx_verticle(chunk);
        level thread maps\_zombiemode_blockers::remove_chunk(chunk, node, true, zomb);
        chunk notify("destroyed");
      }
    } else if(notetrack == "bar") {
      if(!chunk.destroyed) {
        self.lastchunk_destroy_time = getTime();
        if(chunk.script_noteworthy == "4" || chunk.script_noteworthy == "6") {
          if(isDefined(chunk.script_squadname) && (chunk.script_squadname == "cosmodrome_storage_area")) {}
          if(!isDefined(chunk.script_squadname)) {
            chunk thread zombie_bartear_offset_fx_horizontle(chunk);
          }
        } else {
          if(isDefined(chunk.script_squadname) && (chunk.script_squadname == "cosmodrome_storage_area")) {}
          if(!isDefined(chunk.script_squadname)) {
            chunk thread zombie_bartear_offset_fx_verticle(chunk);
          }
        }
        level thread maps\_zombiemode_blockers::remove_chunk(chunk, node, true, self);
        chunk notify("destroyed");
      }
    }
  }
}

bar_repair_bend_left(bar_bend_left, chunk) {
  while(1) {
    wait(0.2);
    if(chunk get_chunk_state() == "repaired") {
      bar_bend_left delete();
      break;
    }
  }
}

bar_repair_bend_right(bar_bend_right, chunk) {
  while(1) {
    wait(0.2);
    if(chunk get_chunk_state() == "repaired") {
      bar_bend_right delete();
      break;
    }
  }
}

zombie_boardtear_offset_fx_horizontle(chunk, node) {
  if(isDefined(chunk.script_parameters) && (chunk.script_parameters == "repair_board")) {
    if(isDefined(chunk.unbroken) && chunk.unbroken == true) {
      if(isDefined(chunk.material) && chunk.material == "glass") {
        playFX(level._effect["glass_break"], chunk.origin, node.angles);
        chunk.unbroken = false;
      } else if(isDefined(chunk.material) && chunk.material == "metal") {
        playFX(level._effect["fx_zombie_bar_break"], chunk.origin);
        chunk.unbroken = false;
      } else {
        playFX(level._effect["wall_break"], chunk.origin);
        chunk.unbroken = false;
      }
    }
  } else {
    playFX(level._effect["wood_chunk_destory"], chunk.origin + (0, 0, 30));
    wait(randomfloat(0.2, 0.4));
    playFX(level._effect["wood_chunk_destory"], chunk.origin + (0, 0, -30));
  }
}

zombie_boardtear_offset_fx_verticle(chunk, node) {
  if(isDefined(chunk.script_parameters) && (chunk.script_parameters == "repair_board")) {
    if(isDefined(chunk.unbroken) && chunk.unbroken == true) {
      if(isDefined(chunk.material) && chunk.material == "glass") {
        playFX(level._effect["glass_break"], chunk.origin, node.angles);
        chunk.unbroken = false;
      } else if(isDefined(chunk.material) && chunk.material == "metal") {
        playFX(level._effect["fx_zombie_bar_break"], chunk.origin);
        chunk.unbroken = false;
      } else {
        playFX(level._effect["wall_break"], chunk.origin);
        chunk.unbroken = false;
      }
    }
  } else {
    playFX(level._effect["wood_chunk_destory"], chunk.origin + (30, 0, 0));
    wait(randomfloat(0.2, 0.4));
    playFX(level._effect["wood_chunk_destory"], chunk.origin + (-30, 0, 0));
  }
}

zombie_bartear_offset_fx_verticle(chunk) {
  if(isDefined(chunk.script_parameters) && (chunk.script_parameters == "bar") || (chunk.script_noteworthy == "board")) {
    possible_tag_array_1 = [];
    possible_tag_array_1[0] = "Tag_fx_top";
    possible_tag_array_1[1] = "";
    possible_tag_array_1[2] = "Tag_fx_top";
    possible_tag_array_1[3] = "";
    possible_tag_array_2 = [];
    possible_tag_array_2[0] = "";
    possible_tag_array_2[1] = "Tag_fx_bottom";
    possible_tag_array_2[2] = "";
    possible_tag_array_2[3] = "Tag_fx_bottom";
    possible_tag_array_2 = array_randomize(possible_tag_array_2);
    random_fx = [];
    random_fx[0] = level._effect["fx_zombie_bar_break"];
    random_fx[1] = level._effect["fx_zombie_bar_break_lite"];
    random_fx[2] = level._effect["fx_zombie_bar_break"];
    random_fx[3] = level._effect["fx_zombie_bar_break_lite"];
    random_fx = array_randomize(random_fx);
    switch (randomInt(9)) {
      case 0:
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
        wait(randomfloat(0.0, 0.3));
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
        break;
      case 1:
        playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_top");
        wait(randomfloat(0.0, 0.3));
        playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
        break;
      case 2:
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
        wait(randomfloat(0.0, 0.3));
        playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
        break;
      case 3:
        playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_top");
        wait(randomfloat(0.0, 0.3));
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
        break;
      case 4:
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
        wait(randomfloat(0.0, 0.3));
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
        break;
      case 5:
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
        break;
      case 6:
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
        break;
      case 7:
        playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_top");
        break;
      case 8:
        playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
        break;
    }
  }
  if(isDefined(chunk.script_parameters) && (chunk.script_parameters == "grate")) {
    EarthQuake(RandomFloatRange(0.3, 0.4), RandomFloatRange(0.2, 0.4), chunk.origin, 150);
    chunk play_sound_on_ent("bar_rebuild_slam");
    switch (randomInt(9)) {
      case 0:
        playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        wait(randomfloat(0.0, 0.3));
        playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        break;
      case 1:
        playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        wait(randomfloat(0.0, 0.3));
        playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        break;
      case 2:
        playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        wait(randomfloat(0.0, 0.3));
        playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        break;
      case 3:
        playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        wait(randomfloat(0.0, 0.3));
        playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        break;
      case 4:
        playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        wait(randomfloat(0.0, 0.3));
        playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        break;
      case 5:
        playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        break;
      case 6:
        playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        break;
      case 7:
        playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        break;
      case 8:
        playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        break;
    }
  }
}

zombie_bartear_offset_fx_horizontle(chunk) {
  if(isDefined(chunk.script_parameters) && (chunk.script_parameters == "bar") || (chunk.script_noteworthy == "board")) {
    switch (randomInt(10)) {
      case 0:
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
        wait(randomfloat(0.0, 0.3));
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
        break;
      case 1:
        playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_left");
        wait(randomfloat(0.0, 0.3));
        playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
        break;
      case 2:
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
        wait(randomfloat(0.0, 0.3));
        playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
        break;
      case 3:
        playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_left");
        wait(randomfloat(0.0, 0.3));
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
        break;
      case 4:
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
        wait(randomfloat(0.0, 0.3));
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
        break;
      case 5:
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
        break;
      case 6:
        playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
        break;
      case 7:
        playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
        break;
      case 8:
        playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
        break;
    }
  }
}

check_for_zombie_death(zombie) {
  self endon("destroyed");
  wait(2.5);
  self maps\_zombiemode_blockers::update_states("repaired");
}

get_tear_anim(chunk, zombo) {
  anims = [];
  anims[anims.size] = % ai_zombie_door_tear_high;
  anims[anims.size] = % ai_zombie_door_tear_low;
  anims[anims.size] = % ai_zombie_door_tear_left;
  anims[anims.size] = % ai_zombie_door_tear_right;
  anims[anims.size] = % ai_zombie_door_tear_v1;
  anims[anims.size] = % ai_zombie_door_tear_v2;
  anims[anims.size] = % ai_zombie_door_pound_v1;
  anims[anims.size] = % ai_zombie_door_pound_v2;
  tear_anim = anims[randomInt(anims.size)];
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "board" || chunk.script_parameters == "repair_board") {
      if(self.has_legs) {
        if(isDefined(chunk.script_noteworthy)) {
          if(isDefined(chunk.unbroken) && chunk.unbroken == true) {
            if(isDefined(chunk.material) && chunk.material == "metal") {
              if(chunk.script_noteworthy == "1") {
                tear_anim = % ai_zombie_boardtear_m_1;
              }
              if(chunk.script_noteworthy == "2") {
                tear_anim = % ai_zombie_boardtear_m_4;
              }
              if(chunk.script_noteworthy == "3") {
                tear_anim = % ai_zombie_door_tear_low;
              }
              if(chunk.script_noteworthy == "4") {
                tear_anim = % ai_zombie_boardtear_m_5;
              }
              if(chunk.script_noteworthy == "5") {
                tear_anim = % ai_zombie_door_tear_low;
              }
              if(chunk.script_noteworthy == "6") {
                tear_anim = % ai_zombie_boardtear_m_6;
              }
            } else {
              if(zombo.attacking_spot_index == 0) {
                tear_anim = % ai_zombie_door_pound_v1;
              } else {
                tear_anim = % ai_zombie_door_pound_v2;
              }
            }
          } else if(zombo.attacking_spot_index == 0) {
            if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_boardtear_m_1;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_boardtear_m_2;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_boardtear_m_3;
            } else if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_boardtear_m_4;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_boardtear_m_5;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_boardtear_m_6;
            }
          } else if(zombo.attacking_spot_index == 1) {
            if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_boardtear_r_1;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_boardtear_r_3;
            } else if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_boardtear_r_4;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_boardtear_r_5;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_boardtear_r_6;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_boardtear_r_2;
            }
          } else if(zombo.attacking_spot_index == 2) {
            if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_boardtear_l_1;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_boardtear_l_2;
            } else if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_boardtear_l_4;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_boardtear_l_5;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_boardtear_l_6;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_boardtear_l_3;
            }
          }
        }
      }
    }
  }
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "bar") {
      if(self.has_legs) {
        if(isDefined(chunk.script_noteworthy)) {
          if(zombo.attacking_spot_index == 0) {
            if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_bartear_m_5;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_bartear_m_6;
            } else if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_bartear_m_3;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_bartear_m_2;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_bar_bend_m_2;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_bar_bend_m_1;
            }
          } else if(zombo.attacking_spot_index == 1) {
            if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_bartear_r_5;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_bartear_r_6;
            } else if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_bartear_r_3;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_bar_bend_r;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_bartear_r_2;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_bar_bend_r_2;
            }
          } else if(zombo.attacking_spot_index == 2) {
            if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_bartear_l_5;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_bartear_l_6;
            } else if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_bartear_l_3;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_bartear_l_2;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_bar_bend_l;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_bar_bend_L_2;
            }
          }
        }
      }
    }
  }
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "grate") {
      if(self.has_legs) {
        if(isDefined(chunk.script_noteworthy)) {
          if(zombo.attacking_spot_index == 0) {
            if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_boardtear_m_1;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_boardtear_m_2;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_boardtear_m_3;
            } else if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_boardtear_m_4;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_boardtear_m_5;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_boardtear_m_6;
            }
          } else if(zombo.attacking_spot_index == 1) {
            if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_boardtear_r_1;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_boardtear_r_3;
            } else if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_boardtear_r_4;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_boardtear_r_5;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_boardtear_r_6;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_boardtear_r_2;
            }
          } else if(zombo.attacking_spot_index == 2) {
            if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_boardtear_l_1;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_boardtear_l_2;
            } else if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_boardtear_l_4;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_boardtear_l_5;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_boardtear_l_6;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_boardtear_l_3;
            }
          }
        }
      }
    }
  }
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "board" || chunk.script_parameters == "repair_board") {
      if(self.has_legs == false) {
        if(isDefined(chunk.script_noteworthy)) {
          if(zombo.attacking_spot_index == 0) {
            if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_boardtear_crawl_m_1;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_boardtear_crawl_m_2;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_boardtear_crawl_m_3;
            } else if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_boardtear_crawl_m_4;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_boardtear_crawl_m_5;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_boardtear_crawl_m_6;
            }
          } else if(zombo.attacking_spot_index == 1) {
            if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_boardtear_crawl_r_1;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_boardtear_crawl_r_3;
            } else if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_boardtear_crawl_r_4;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_boardtear_crawl_r_5;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_boardtear_crawl_r_6;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_boardtear_crawl_r_2;
            }
          } else if(zombo.attacking_spot_index == 2) {
            if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_boardtear_crawl_l_1;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_boardtear_crawl_l_2;
            } else if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_boardtear_crawl_l_4;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_boardtear_crawl_l_5;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_boardtear_crawl_l_6;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_boardtear_crawl_l_3;
            }
          }
        }
      }
    }
  }
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "bar") {
      if(self.has_legs == false) {
        if(isDefined(chunk.script_noteworthy)) {
          if(zombo.attacking_spot_index == 0) {
            if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_bartear_crawl_m_2;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_bartear_crawl_m_3;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_bartear_crawl_m_1;
            } else if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_bartear_crawl_m_5;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_bartear_crawl_m_4;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_bartear_crawl_m_6;
            }
          } else if(zombo.attacking_spot_index == 1) {
            if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_bartear_crawl_r_2;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_bartear_crawl_r_1;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_bartear_crawl_r_3;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_bartear_crawl_r_4;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_bartear_crawl_r_6;
            } else if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_bartear_crawl_r_5;
            }
          } else if(zombo.attacking_spot_index == 2) {
            if(chunk.script_noteworthy == "1") {
              tear_anim = % ai_zombie_bartear_crawl_l_2;
            } else if(chunk.script_noteworthy == "2") {
              tear_anim = % ai_zombie_bartear_crawl_l_3;
            } else if(chunk.script_noteworthy == "4") {
              tear_anim = % ai_zombie_bartear_crawl_l_5;
            } else if(chunk.script_noteworthy == "5") {
              tear_anim = % ai_zombie_bartear_crawl_l_4;
            } else if(chunk.script_noteworthy == "6") {
              tear_anim = % ai_zombie_bartear_crawl_l_6;
            } else if(chunk.script_noteworthy == "3") {
              tear_anim = % ai_zombie_bartear_crawl_l_1;
            }
          }
        }
      } else if(self.has_legs == false) {
        anims = [];
        anims[anims.size] = % ai_zombie_attack_crawl;
        anims[anims.size] = % ai_zombie_attack_crawl_lunge;
        tear_anim = anims[randomInt(anims.size)];
      }
    }
  }
  return tear_anim;
}

cap_zombie_head_gibs() {
  if(!isDefined(level.max_head_gibs_per_frame)) {
    level.max_head_gibs_per_frame = 4;
  }
  while(true) {
    level.head_gibs_this_frame = 0;
    wait_network_frame();
  }
}

zombie_head_gib(attacker, means_of_death) {
  self endon("death");
  if(!is_mature()) {
    return false;
  }
  if(is_german_build()) {
    return;
  }
  if(isDefined(self.head_gibbed) && self.head_gibbed) {
    return;
  }
  if(!isDefined(level.head_gibs_this_frame)) {
    level thread cap_zombie_head_gibs();
  }
  if(level.head_gibs_this_frame >= level.max_head_gibs_per_frame) {
    return;
  }
  level.head_gibs_this_frame++;
  self.head_gibbed = true;
  self zombie_eye_glow_stop();
  size = self GetAttachSize();
  for(i = 0; i < size; i++) {
    model = self GetAttachModelName(i);
    if(IsSubStr(model, "head")) {
      if(isDefined(self.hatmodel)) {
        self detach(self.hatModel, "");
      }
      self Detach(model, "", true);
      if(isDefined(self.torsoDmg5)) {
        self Attach(self.torsoDmg5, "", true);
      }
      break;
    }
  }
  temp_array = [];
  temp_array[0] = level._ZOMBIE_GIB_PIECE_INDEX_HEAD;
  self gib("normal", temp_array);
  self thread damage_over_time(self.health * 0.2, 1, attacker, means_of_death);
}

damage_over_time(dmg, delay, attacker, means_of_death) {
  self endon("death");
  if(!IsAlive(self)) {
    return;
  }
  if(!IsPlayer(attacker)) {
    attacker = undefined;
  }
  while(1) {
    if(isDefined(delay)) {
      wait(delay);
    }
    self DoDamage(dmg, self.origin, attacker, undefined, means_of_death, self.damagelocation);
  }
}

head_should_gib(attacker, type, point) {
  if(!is_mature()) {
    return false;
  }
  if(is_german_build()) {
    return false;
  }
  if(self.head_gibbed) {
    return false;
  }
  if(!isDefined(attacker) || !IsPlayer(attacker)) {
    return false;
  }
  low_health_percent = (self.health / self.maxhealth) * 100;
  if(low_health_percent > 10) {
    return false;
  }
  weapon = attacker GetCurrentWeapon();
  if(type != "MOD_RIFLE_BULLET" && type != "MOD_PISTOL_BULLET") {
    if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH") {
      if(Distance(point, self GetTagOrigin("j_head")) > 55) {
        return false;
      } else {
        return true;
      }
    } else if(type == "MOD_PROJECTILE") {
      if(Distance(point, self GetTagOrigin("j_head")) > 10) {
        return false;
      } else {
        return true;
      }
    } else if(WeaponClass(weapon) != "spread") {
      return false;
    }
  }
  if(!animscripts\utility::damageLocationIsAny("head", "helmet", "neck")) {
    return false;
  }
  if(weapon == "none" || weapon == "m1911_zm" || WeaponIsGasWeapon(self.weapon)) {
    return false;
  }
  return true;
}

headshot_blood_fx() {
  if(!isDefined(self)) {
    return;
  }
  if(!is_mature()) {
    return;
  }
  fxTag = "j_neck";
  fxOrigin = self GetTagOrigin(fxTag);
  upVec = AnglesToUp(self GetTagAngles(fxTag));
  forwardVec = anglesToForward(self GetTagAngles(fxTag));
  playFX(level._effect["headshot"], fxOrigin, forwardVec, upVec);
  playFX(level._effect["headshot_nochunks"], fxOrigin, forwardVec, upVec);
  wait(0.3);
  if(isDefined(self)) {
    if(self maps\_zombiemode_weap_tesla::enemy_killed_by_tesla()) {
      playFXOnTag(level._effect["tesla_head_light"], self, fxTag);
    } else {
      playFXOnTag(level._effect["bloodspurt"], self, fxTag);
    }
  }
}

zombie_gib_on_damage() {
  while(1) {
    self waittill("damage", amount, attacker, direction_vec, point, type);
    if(!isDefined(self)) {
      return;
    }
    if(!self zombie_should_gib(amount, attacker, type)) {
      continue;
    }
    if(self head_should_gib(attacker, type, point) && type != "MOD_BURNED") {
      self zombie_head_gib(attacker, type);
      if(isDefined(attacker.headshot_count)) {
        attacker.headshot_count++;
      } else {
        attacker.headshot_count = 1;
      }
      attacker.stats["headshots"] = attacker.headshot_count;
      attacker.stats["zombie_gibs"]++;
      continue;
    }
    if(!self.gibbed) {
      if(self animscripts\utility::damageLocationIsAny("head", "helmet", "neck")) {
        continue;
      }
      refs = [];
      switch (self.damageLocation) {
        case "torso_upper":
        case "torso_lower":
          refs[refs.size] = "guts";
          refs[refs.size] = "right_arm";
          break;
        case "right_arm_upper":
        case "right_arm_lower":
        case "right_hand":
          refs[refs.size] = "right_arm";
          break;
        case "left_arm_upper":
        case "left_arm_lower":
        case "left_hand":
          refs[refs.size] = "left_arm";
          break;
        case "right_leg_upper":
        case "right_leg_lower":
        case "right_foot":
          if(self.health <= 0) {
            refs[refs.size] = "right_leg";
            refs[refs.size] = "right_leg";
            refs[refs.size] = "right_leg";
            refs[refs.size] = "no_legs";
          }
          break;
        case "left_leg_upper":
        case "left_leg_lower":
        case "left_foot":
          if(self.health <= 0) {
            refs[refs.size] = "left_leg";
            refs[refs.size] = "left_leg";
            refs[refs.size] = "left_leg";
            refs[refs.size] = "no_legs";
          }
          break;
        default:
          if(self.damageLocation == "none") {
            if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
              refs = self derive_damage_refs(point);
              break;
            }
          } else {
            refs[refs.size] = "guts";
            refs[refs.size] = "right_arm";
            refs[refs.size] = "left_arm";
            refs[refs.size] = "right_leg";
            refs[refs.size] = "left_leg";
            refs[refs.size] = "no_legs";
            break;
          }
      }
      if(refs.size) {
        self.a.gib_ref = animscripts\zombie_death::get_random(refs);
        if((self.a.gib_ref == "no_legs" || self.a.gib_ref == "right_leg" || self.a.gib_ref == "left_leg") && self.health > 0) {
          self.has_legs = false;
          self AllowedStances("crouch");
          self thread kill_crawler_over_time((10 + randomInt(40)));
          self setPhysParams(15, 0, 24);
          health = self.health;
          health = health * 0.1;
          which_anim = randomInt(5);
          if(self.a.gib_ref == "no_legs") {
            if(randomInt(100) < 50) {
              self.deathanim = % ai_zombie_crawl_death_v1;
              self set_run_anim("death3");
              self.run_combatanim = level.scr_anim[self.animname]["crawl_hand_1"];
              self.crouchRunAnim = level.scr_anim[self.animname]["crawl_hand_1"];
              self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl_hand_1"];
            } else {
              self.deathanim = % ai_zombie_crawl_death_v1;
              self set_run_anim("death3");
              self.run_combatanim = level.scr_anim[self.animname]["crawl_hand_2"];
              self.crouchRunAnim = level.scr_anim[self.animname]["crawl_hand_2"];
              self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl_hand_2"];
            }
          } else if(which_anim == 0) {
            self.deathanim = % ai_zombie_crawl_death_v1;
            self set_run_anim("death3");
            self.run_combatanim = level.scr_anim[self.animname]["crawl1"];
            self.crouchRunAnim = level.scr_anim[self.animname]["crawl1"];
            self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl1"];
          } else if(which_anim == 1) {
            self.deathanim = % ai_zombie_crawl_death_v2;
            self set_run_anim("death4");
            self.run_combatanim = level.scr_anim[self.animname]["crawl2"];
            self.crouchRunAnim = level.scr_anim[self.animname]["crawl2"];
            self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl2"];
          } else if(which_anim == 2) {
            self.deathanim = % ai_zombie_crawl_death_v1;
            self set_run_anim("death3");
            self.run_combatanim = level.scr_anim[self.animname]["crawl3"];
            self.crouchRunAnim = level.scr_anim[self.animname]["crawl3"];
            self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl3"];
          } else if(which_anim == 3) {
            self.deathanim = % ai_zombie_crawl_death_v2;
            self set_run_anim("death4");
            self.run_combatanim = level.scr_anim[self.animname]["crawl4"];
            self.crouchRunAnim = level.scr_anim[self.animname]["crawl4"];
            self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl4"];
          } else if(which_anim == 4) {
            self.deathanim = % ai_zombie_crawl_death_v1;
            self set_run_anim("death3");
            self.run_combatanim = level.scr_anim[self.animname]["crawl5"];
            self.crouchRunAnim = level.scr_anim[self.animname]["crawl5"];
            self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl5"];
          }
        }
      }
      if(self.health > 0) {
        self thread animscripts\zombie_death::do_gib();
        if(IsPlayer(self)) {
          attacker.stats["zombie_gibs"]++;
        }
      }
    }
  }
}

kill_crawler_over_time(delay) {
  self endon("death");
  if(!IsAlive(self)) {
    return;
  }
  wait(delay);
  self DoDamage(self.health + 100, self.origin);
}

zombie_should_gib(amount, attacker, type) {
  if(!is_mature()) {
    return false;
  }
  if(is_german_build()) {
    return false;
  }
  if(!isDefined(type)) {
    return false;
  }
  if(isDefined(self.no_gib) && (self.no_gib == 1)) {
    return false;
  }
  if(self maps\_zombiemode_weap_freezegun::is_freezegun_damage(type)) {
    return false;
  }
  switch (type) {
    case "MOD_UNKNOWN":
    case "MOD_CRUSH":
    case "MOD_TELEFRAG":
    case "MOD_FALLING":
    case "MOD_SUICIDE":
    case "MOD_TRIGGER_HURT":
    case "MOD_BURNED":
      return false;
    case "MOD_MELEE": {
      return false;
    }
  }
  if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
    if(!isDefined(attacker) || !IsPlayer(attacker)) {
      return false;
    }
    weapon = attacker GetCurrentWeapon();
    if(weapon == "none" || weapon == "m1911_zm") {
      return false;
    }
    if(WeaponIsGasWeapon(self.weapon)) {
      return false;
    }
  }
  prev_health = amount + self.health;
  if(prev_health <= 0) {
    prev_health = 1;
  }
  damage_percent = (amount / prev_health) * 100;
  if(damage_percent < 10) {
    return false;
  }
  return true;
}

derive_damage_refs(point) {
  if(!isDefined(level.gib_tags)) {
    init_gib_tags();
  }
  closestTag = undefined;
  for(i = 0; i < level.gib_tags.size; i++) {
    if(!isDefined(closestTag)) {
      closestTag = level.gib_tags[i];
    } else {
      if(distanceSquared(point, self GetTagOrigin(level.gib_tags[i])) < distanceSquared(point, self GetTagOrigin(closestTag))) {
        closestTag = level.gib_tags[i];
      }
    }
  }
  refs = [];
  if(closestTag == "J_SpineLower" || closestTag == "J_SpineUpper" || closestTag == "J_Spine4") {
    refs[refs.size] = "guts";
    refs[refs.size] = "right_arm";
  } else if(closestTag == "J_Shoulder_LE" || closestTag == "J_Elbow_LE" || closestTag == "J_Wrist_LE") {
    refs[refs.size] = "left_arm";
  } else if(closestTag == "J_Shoulder_RI" || closestTag == "J_Elbow_RI" || closestTag == "J_Wrist_RI") {
    refs[refs.size] = "right_arm";
  } else if(closestTag == "J_Hip_LE" || closestTag == "J_Knee_LE" || closestTag == "J_Ankle_LE") {
    refs[refs.size] = "left_leg";
    refs[refs.size] = "no_legs";
  } else if(closestTag == "J_Hip_RI" || closestTag == "J_Knee_RI" || closestTag == "J_Ankle_RI") {
    refs[refs.size] = "right_leg";
    refs[refs.size] = "no_legs";
  }
  ASSERTEX(array_validate(refs), "get_closest_damage_refs(): couldn't derive refs from closestTag " + closestTag);
  return refs;
}

init_gib_tags() {
  tags = [];
  tags[tags.size] = "J_SpineLower";
  tags[tags.size] = "J_SpineUpper";
  tags[tags.size] = "J_Spine4";
  tags[tags.size] = "J_Shoulder_LE";
  tags[tags.size] = "J_Elbow_LE";
  tags[tags.size] = "J_Wrist_LE";
  tags[tags.size] = "J_Shoulder_RI";
  tags[tags.size] = "J_Elbow_RI";
  tags[tags.size] = "J_Wrist_RI";
  tags[tags.size] = "J_Hip_LE";
  tags[tags.size] = "J_Knee_LE";
  tags[tags.size] = "J_Ankle_LE";
  tags[tags.size] = "J_Hip_RI";
  tags[tags.size] = "J_Knee_RI";
  tags[tags.size] = "J_Ankle_RI";
  level.gib_tags = tags;
}

zombie_can_drop_powerups(zombie) {
  if(level.mutators["mutator_noPowerups"]) {
    return false;
  }
  if(zombie.damageweapon == "zombie_cymbal_monkey" || !flag("zombie_drop_powerups")) {
    return false;
  }
  if(isDefined(zombie.no_powerups)) {
    return false;
  }
  return true;
}

zombie_death_points(origin, mod, hit_location, attacker, zombie) {
  if(!isDefined(attacker) || !IsPlayer(attacker)) {
    return;
  }
  if(zombie_can_drop_powerups(zombie)) {
    level thread maps\_zombiemode_powerups::powerup_drop(origin);
  }
  level thread maps\_zombiemode_audio::player_zombie_kill_vox(hit_location, attacker, mod, zombie);
  event = "death";
  if(issubstr(zombie.damageweapon, "knife_ballistic_")) {
    event = "ballistic_knife_death";
  }
  attacker maps\_zombiemode_score::player_add_points(event, mod, hit_location);
}

get_number_variants(aliasPrefix) {
  for(i = 0; i < 100; i++) {
    if(!SoundExists(aliasPrefix + "_" + i)) {
      return i;
    }
  }
}

dragons_breath_flame_death_fx() {
  if(self.isdog) {
    return;
  }
  if(!isDefined(level._effect) || !isDefined(level._effect["character_fire_death_sm"])) {
    return;
  }
  playFXOnTag(level._effect["character_fire_death_sm"], self, "J_SpineLower");
  tagArray = [];
  if(!isDefined(self.a.gib_ref) || self.a.gib_ref != "left_arm") {
    tagArray[tagArray.size] = "J_Elbow_LE";
    tagArray[tagArray.size] = "J_Wrist_LE";
  }
  if(!isDefined(self.a.gib_ref) || self.a.gib_ref != "right_arm") {
    tagArray[tagArray.size] = "J_Elbow_RI";
    tagArray[tagArray.size] = "J_Wrist_RI";
  }
  if(!isDefined(self.a.gib_ref) || (self.a.gib_ref != "no_legs" && self.a.gib_ref != "left_leg")) {
    tagArray[tagArray.size] = "J_Knee_LE";
    tagArray[tagArray.size] = "J_Ankle_LE";
  }
  if(!isDefined(self.a.gib_ref) || (self.a.gib_ref != "no_legs" && self.a.gib_ref != "right_leg")) {
    tagArray[tagArray.size] = "J_Knee_RI";
    tagArray[tagArray.size] = "J_Ankle_RI";
  }
  tagArray = array_randomize(tagArray);
  playFXOnTag(level._effect["character_fire_death_sm"], self, tagArray[0]);
}

zombie_death_animscript() {
  self reset_attack_spot();
  if(self maps\_zombiemode_weap_tesla::enemy_killed_by_tesla() || self maps\_zombiemode_weap_thundergun::enemy_killed_by_thundergun()) {
    return false;
  }
  if(self maps\_zombiemode_weap_freezegun::should_do_freezegun_death(self.damagemod)) {
    self thread maps\_zombiemode_weap_freezegun::freezegun_death(self.damagelocation, self.origin, self.attacker);
    if("MOD_EXPLOSIVE" == self.damagemod) {
      return false;
    }
  }
  if(self.has_legs && isDefined(self.a.gib_ref) && self.a.gib_ref == "no_legs") {
    self.deathanim = % ai_gib_bothlegs_gib;
  }
  self.grenadeAmmo = 0;
  if(isDefined(self.nuked)) {
    if(zombie_can_drop_powerups(self)) {
      level thread maps\_zombiemode_powerups::powerup_drop(self.origin);
    }
  } else {
    level zombie_death_points(self.origin, self.damagemod, self.damagelocation, self.attacker, self);
  }
  if(isDefined(self.attacker) && isai(self.attacker)) {
    self.attacker notify("killed", self);
  }
  if("rottweil72_upgraded_zm" == self.damageweapon && "MOD_RIFLE_BULLET" == self.damagemod) {
    self thread dragons_breath_flame_death_fx();
  }
  if(self.damagemod == "MOD_BURNED") {
    self thread animscripts\zombie_death::flame_death_fx();
  }
  if(self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_GRENADE_SPLASH") {
    level notify("zombie_grenade_death", self.origin);
  }
  return false;
}

damage_on_fire(player) {
  self endon("death");
  self endon("stop_flame_damage");
  wait(2);
  while(isDefined(self.is_on_fire) && self.is_on_fire) {
    if(level.round_number < 6) {
      dmg = level.zombie_health * RandomFloatRange(0.2, 0.3);
    } else if(level.round_number < 9) {
      dmg = level.zombie_health * RandomFloatRange(0.15, 0.25);
    } else if(level.round_number < 11) {
      dmg = level.zombie_health * RandomFloatRange(0.1, 0.2);
    } else {
      dmg = level.zombie_health * RandomFloatRange(0.1, 0.15);
    }
    if(isDefined(player) && Isalive(player)) {
      self DoDamage(dmg, self.origin, player);
    } else {
      self DoDamage(dmg, self.origin, level);
    }
    wait(randomfloatrange(1.0, 3.0));
  }
}

player_using_hi_score_weapon(player) {
  weapon = player GetCurrentWeapon();
  if(weapon == "none" || WeaponIsSemiAuto(weapon)) {
    return (1);
  }
  return (0);
}

zombie_damage(mod, hit_location, hit_origin, player, amount) {
  if(is_magic_bullet_shield_enabled(self)) {
    return;
  }
  player.use_weapon_type = mod;
  if(isDefined(self.marked_for_death)) {
    return;
  }
  if(!isDefined(player)) {
    return;
  }
  if(self zombie_flame_damage(mod, player)) {
    if(self zombie_give_flame_damage_points()) {
      player maps\_zombiemode_score::player_add_points("damage", mod, hit_location, self.isdog);
    }
  } else if(self maps\_zombiemode_weap_tesla::is_tesla_damage(mod)) {
    self maps\_zombiemode_weap_tesla::tesla_damage_init(hit_location, hit_origin, player);
    return;
  } else {
    if(self maps\_zombiemode_weap_freezegun::is_freezegun_damage(self.damagemod)) {
      self thread maps\_zombiemode_weap_freezegun::freezegun_damage_response(player, amount);
    }
    if(!self maps\_zombiemode_weap_freezegun::is_freezegun_shatter_damage(self.damagemod)) {
      if(player_using_hi_score_weapon(player)) {
        damage_type = "damage";
      } else {
        damage_type = "damage_light";
      }
      player maps\_zombiemode_score::player_add_points(damage_type, mod, hit_location, self.isdog);
    }
  }
  if(isDefined(self.zombie_damage_fx_func)) {
    self[[self.zombie_damage_fx_func]](mod, hit_location, hit_origin, player);
  }
  modName = remove_mod_from_methodofdeath(mod);
  if(self maps\_zombiemode_weap_freezegun::is_freezegun_damage(self.damagemod)) {
    ;
  } else if(self.damageweapon == "claymore_zm") {
    if(isDefined(self.zombie_damage_claymore_func)) {
      self[[self.zombie_damage_claymore_func]](mod, hit_location, hit_origin, player);
    } else if(isDefined(player) && isalive(player)) {
      self DoDamage(level.round_number * randomintrange(100, 200), self.origin, player);
    } else {
      self DoDamage(level.round_number * randomintrange(100, 200), self.origin, undefined);
    }
  } else if(mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH") {
    if(isDefined(player) && isalive(player)) {
      self DoDamage(level.round_number + randomintrange(100, 200), self.origin, player, 0, modName, hit_location);
    } else {
      self DoDamage(level.round_number + randomintrange(100, 200), self.origin, undefined, 0, modName, hit_location);
    }
  } else if(mod == "MOD_PROJECTILE" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH") {
    if(isDefined(player) && isalive(player)) {
      self DoDamage(level.round_number * randomintrange(0, 100), self.origin, player, 0, modName, hit_location);
    } else {
      self DoDamage(level.round_number * randomintrange(0, 100), self.origin, undefined, 0, modName, hit_location);
    }
  }
  if(isDefined(self.a.gib_ref) && (self.a.gib_ref == "no_legs") && isalive(self)) {
    if(isDefined(player)) {
      rand = randomintrange(0, 100);
      if(rand < 10) {
        player create_and_play_dialog("general", "crawl_spawn");
      }
    }
  } else if(isDefined(self.a.gib_ref) && ((self.a.gib_ref == "right_arm") || (self.a.gib_ref == "left_arm"))) {
    if(self.has_legs && isalive(self)) {
      if(isDefined(player)) {
        rand = randomintrange(0, 100);
        if(rand < 3) {
          player create_and_play_dialog("general", "shoot_arm");
        }
      }
    }
  }
  self thread maps\_zombiemode_powerups::check_for_instakill(player, mod, hit_location);
}

zombie_damage_ads(mod, hit_location, hit_origin, player, amount) {
  if(is_magic_bullet_shield_enabled(self)) {
    return;
  }
  player.use_weapon_type = mod;
  if(!isDefined(player)) {
    return;
  }
  if(self zombie_flame_damage(mod, player)) {
    if(self zombie_give_flame_damage_points()) {
      player maps\_zombiemode_score::player_add_points("damage_ads", mod, hit_location);
    }
  } else if(self maps\_zombiemode_weap_tesla::is_tesla_damage(mod)) {
    self maps\_zombiemode_weap_tesla::tesla_damage_init(hit_location, hit_origin, player);
    return;
  } else {
    if(self maps\_zombiemode_weap_freezegun::is_freezegun_damage(self.damagemod)) {
      self thread maps\_zombiemode_weap_freezegun::freezegun_damage_response(player, amount);
    }
    if(!self maps\_zombiemode_weap_freezegun::is_freezegun_shatter_damage(self.damagemod)) {
      if(player_using_hi_score_weapon(player)) {
        damage_type = "damage";
      } else {
        damage_type = "damage_light";
      }
      player maps\_zombiemode_score::player_add_points(damage_type, mod, hit_location);
    }
  }
  self thread maps\_zombiemode_powerups::check_for_instakill(player, mod, hit_location);
}

zombie_give_flame_damage_points() {
  if(GetTime() > self.flame_damage_time) {
    self.flame_damage_time = GetTime() + level.zombie_vars["zombie_flame_dmg_point_delay"];
    return true;
  }
  return false;
}

zombie_flame_damage(mod, player) {
  if(mod == "MOD_BURNED") {
    self.moveplaybackrate = 0.8;
    if(!isDefined(self.is_on_fire) || (isDefined(self.is_on_fire) && !self.is_on_fire)) {
      self thread damage_on_fire(player);
    }
    do_flame_death = true;
    dist = 100 * 100;
    ai = GetAiArray("axis");
    for(i = 0; i < ai.size; i++) {
      if(isDefined(ai[i].is_on_fire) && ai[i].is_on_fire) {
        if(distanceSquared(ai[i].origin, self.origin) < dist) {
          do_flame_death = false;
          break;
        }
      }
    }
    if(do_flame_death) {
      self thread animscripts\zombie_death::flame_death_fx();
    }
    return true;
  }
  return false;
}

zombie_death_event(zombie) {
  zombie waittill("death");
  if(!isDefined(zombie)) {
    return;
  }
  if(!zombie maps\_zombiemode_weap_freezegun::should_do_freezegun_death(zombie.damagemod)) {
    zombie thread maps\_zombiemode_audio::do_zombies_playvocals("death", zombie.animname);
    zombie thread zombie_eye_glow_stop();
  }
  if(maps\_zombiemode_weapons::is_weapon_included("freezegun_zm")) {
    zombie thread maps\_zombiemode_weap_freezegun::freezegun_clear_extremity_damage_fx();
    zombie thread maps\_zombiemode_weap_freezegun::freezegun_clear_torso_damage_fx();
  }
  if(isDefined(zombie.attacker) && isplayer(zombie.attacker)) {
    if(!isDefined(zombie.attacker.killcounter)) {
      zombie.attacker.killcounter = 1;
    } else {
      zombie.attacker.killcounter++;
    }
    if(isDefined(zombie.sound_damage_player) && zombie.sound_damage_player == zombie.attacker) {
      zombie.attacker maps\_zombiemode_audio::create_and_play_dialog("kill", "damage");
    }
    zombie.attacker notify("zom_kill");
    damageloc = zombie.damagelocation;
    damagemod = zombie.damagemod;
    attacker = zombie.attacker;
    weapon = zombie.damageWeapon;
    bbPrint("zombie_kills: round %d zombietype zombie damagetype %s damagelocation %s playername %s playerweapon %s playerx %f playery %f playerz %f zombiex %f zombiey %f zombiez %f", level.round_number, damagemod, damageloc, attacker.playername, weapon, attacker.origin, zombie.origin);
  }
  level notify("zom_kill");
  level.total_zombies_killed++;
}

zombie_setup_attack_properties() {
  self zombie_history("zombie_setup_attack_properties()");
  self.ignoreall = false;
  self PushPlayer(true);
  self.pathEnemyFightDist = 64;
  self.meleeAttackDist = 64;
  self.maxsightdistsqrd = 128 * 128;
  self.disableArrivals = true;
  self.disableExits = true;
}

find_flesh() {
  self endon("death");
  level endon("intermission");
  self endon("stop_find_flesh");
  if(level.intermission) {
    return;
  }
  self.helitarget = true;
  self.ignoreme = false;
  self.ignore_player = [];
  self zombie_history("find flesh -> start");
  self.goalradius = 32;
  while(1) {
    near_zombies = getaiarray("axis");
    same_enemy_count = 0;
    for(i = 0; i < near_zombies.size; i++) {
      if(isDefined(near_zombies[i]) && isalive(near_zombies[i])) {
        if(isDefined(near_zombies[i].favoriteenemy) && isDefined(self.favoriteenemy) && near_zombies[i].favoriteenemy == self.favoriteenemy) {
          if(distancesquared(near_zombies[i].origin, self.favoriteenemy.origin) < 225 * 225 && distancesquared(near_zombies[i].origin, self.origin) > 525 * 525) {
            same_enemy_count++;
          }
        }
      }
    }
    if(same_enemy_count > 12) {
      self.ignore_player[self.ignore_player.size] = self.favoriteenemy;
    }
    if(isDefined(level.zombieTheaterTeleporterSeekLogicFunc)) {
      self[[level.zombieTheaterTeleporterSeekLogicFunc]]();
    }
    zombie_poi = self get_zombie_point_of_interest(self.origin);
    players = get_players();
    if(players.size == 1) {
      self.ignore_player = [];
    } else {
      for(i = 0; i < self.ignore_player.size; i++) {
        if(isDefined(self.ignore_player[i]) && isDefined(self.ignore_player[i].ignore_counter) && self.ignore_player[i].ignore_counter > 3) {
          self.ignore_player[i].ignore_counter = 0;
          self.ignore_player = array_remove(self.ignore_player, self.ignore_player[i]);
        }
      }
    }
    player = get_closest_valid_player(self.origin, self.ignore_player);
    if(!isDefined(player) && !isDefined(zombie_poi)) {
      self zombie_history("find flesh -> can't find player, continue");
      if(isDefined(self.ignore_player)) {
        self.ignore_player = [];
      }
      wait(1);
      continue;
    }
    self.enemyoverride = zombie_poi;
    self.favoriteenemy = player;
    self thread zombie_pathing();
    if(players.size > 1) {
      for(i = 0; i < self.ignore_player.size; i++) {
        if(isDefined(self.ignore_player[i])) {
          if(!isDefined(self.ignore_player[i].ignore_counter))
            self.ignore_player[i].ignore_counter = 0;
          else
            self.ignore_player[i].ignore_counter += 1;
        }
      }
    }
    self thread attractors_generated_listener();
    self.zombie_path_timer = GetTime() + (RandomFloatRange(1, 3) * 1000);
    while(GetTime() < self.zombie_path_timer) {
      wait(0.1);
    }
    self notify("path_timer_done");
    self zombie_history("find flesh -> bottom of loop");
    debug_print("Zombie is re-acquiring enemy, ending breadcrumb search");
    self notify("zombie_acquire_enemy");
  }
}

attractors_generated_listener() {
  self endon("death");
  level endon("intermission");
  self endon("stop_find_flesh");
  self endon("path_timer_done");
  level waittill("attractor_positions_generated");
  self.zombie_path_timer = 0;
}

zombie_pathing() {
  self endon("death");
  self endon("zombie_acquire_enemy");
  level endon("intermission");
  assert(isDefined(self.favoriteenemy) || isDefined(self.enemyoverride));
  self thread zombie_follow_enemy();
  self waittill("bad_path");
  if(isDefined(self.enemyoverride)) {
    debug_print("Zombie couldn't path to point of interest at origin: " + self.enemyoverride[0] + " Falling back to breadcrumb system");
    if(isDefined(self.enemyoverride[1])) {
      self.enemyoverride = self.enemyoverride[1] invalidate_attractor_pos(self.enemyoverride, self);
      self.zombie_path_timer = 0;
      return;
    }
  } else {
    debug_print("Zombie couldn't path to player at origin: " + self.favoriteenemy.origin + " Falling back to breadcrumb system");
  }
  if(!isDefined(self.favoriteenemy)) {
    self.zombie_path_timer = 0;
    return;
  } else {
    self.favoriteenemy endon("disconnect");
  }
  players = get_players();
  valid_player_num = 0;
  for(i = 0; i < players.size; i++) {
    if(is_player_valid(players[i], true)) {
      valid_player_num += 1;
    }
  }
  if(players.size > 1) {
    if(array_check_for_dupes(self.ignore_player, self.favoriteenemy)) {
      self.ignore_player[self.ignore_player.size] = self.favoriteenemy;
    }
    if(self.ignore_player.size < valid_player_num) {
      self.zombie_path_timer = 0;
      return;
    }
  }
  crumb_list = self.favoriteenemy.zombie_breadcrumbs;
  bad_crumbs = [];
  while(1) {
    if(!is_player_valid(self.favoriteenemy, true)) {
      self.zombie_path_timer = 0;
      return;
    }
    goal = zombie_pathing_get_breadcrumb(self.favoriteenemy.origin, crumb_list, bad_crumbs, (randomInt(100) < 20));
    if(!isDefined(goal)) {
      debug_print("Zombie exhausted breadcrumb search");
      goal = self.favoriteenemy.spectator_respawn.origin;
    }
    debug_print("Setting current breadcrumb to " + goal);
    self.zombie_path_timer += 100;
    self SetGoalPos(goal);
    self waittill("bad_path");
    debug_print("Zombie couldn't path to breadcrumb at " + goal + " Finding next breadcrumb");
    for(i = 0; i < crumb_list.size; i++) {
      if(goal == crumb_list[i]) {
        bad_crumbs[bad_crumbs.size] = i;
        break;
      }
    }
  }
}

zombie_pathing_get_breadcrumb(origin, breadcrumbs, bad_crumbs, pick_random) {
  assert(isDefined(origin));
  assert(isDefined(breadcrumbs));
  assert(IsArray(breadcrumbs));
  for(i = 0; i < breadcrumbs.size; i++) {
    if(pick_random) {
      crumb_index = randomInt(breadcrumbs.size);
    } else {
      crumb_index = i;
    }
    if(crumb_is_bad(crumb_index, bad_crumbs)) {
      continue;
    }
    return breadcrumbs[crumb_index];
  }
  return undefined;
}

crumb_is_bad(crumb, bad_crumbs) {
  for(i = 0; i < bad_crumbs.size; i++) {
    if(bad_crumbs[i] == crumb) {
      return true;
    }
  }
  return false;
}

jitter_enemies_bad_breadcrumbs(start_crumb) {
  trace_distance = 35;
  jitter_distance = 2;
  index = start_crumb;
  while(isDefined(self.favoriteenemy.zombie_breadcrumbs[index + 1])) {
    current_crumb = self.favoriteenemy.zombie_breadcrumbs[index];
    next_crumb = self.favoriteenemy.zombie_breadcrumbs[index + 1];
    angles = vectortoangles(current_crumb - next_crumb);
    right = anglestoright(angles);
    left = anglestoright(angles + (0, 180, 0));
    dist_pos = current_crumb + vector_scale(right, trace_distance);
    trace = bulletTrace(current_crumb, dist_pos, true, undefined);
    vector = trace["position"];
    if(distance(vector, current_crumb) < 17) {
      self.favoriteenemy.zombie_breadcrumbs[index] = current_crumb + vector_scale(left, jitter_distance);
      continue;
    }
    dist_pos = current_crumb + vector_scale(left, trace_distance);
    trace = bulletTrace(current_crumb, dist_pos, true, undefined);
    vector = trace["position"];
    if(distance(vector, current_crumb) < 17) {
      self.favoriteenemy.zombie_breadcrumbs[index] = current_crumb + vector_scale(right, jitter_distance);
      continue;
    }
    index++;
  }
}

zombie_follow_enemy() {
  self endon("death");
  self endon("zombie_acquire_enemy");
  self endon("bad_path");
  level endon("intermission");
  while(1) {
    if(isDefined(self.enemyoverride) && isDefined(self.enemyoverride[1])) {
      if(distanceSquared(self.origin, self.enemyoverride[0]) > 1 * 1) {
        self OrientMode("face motion");
      } else {
        self OrientMode("face point", self.enemyoverride[1].origin);
      }
      self.ignoreall = true;
      self SetGoalPos(self.enemyoverride[0]);
    } else if(isDefined(self.favoriteenemy)) {
      self.ignoreall = false;
      self OrientMode("face default");
      self SetGoalPos(self.favoriteenemy.origin);
    }
    if(isDefined(level.inaccesible_player_func)) {
      self[[level.inaccessible_player_func]]();
    }
    wait(0.1);
  }
}

zombie_eye_glow() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.no_eye_glow) || !self.no_eye_glow) {
    self haseyes(1);
  }
}

zombie_eye_glow_stop() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.no_eye_glow) || !self.no_eye_glow) {
    self haseyes(0);
  }
}

zombie_history(msg) {}
do_zombie_rise() {
  self endon("death");
  self.zombie_rise_version = (randomInt(99999) % 2) + 1;
  if(self.zombie_move_speed != "walk") {
    self.zombie_rise_version = 1;
  }
  self.in_the_ground = true;
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkto(self.anchor);
  if(isDefined(self.zone_name)) {
    spots = level.zones[self.zone_name].rise_locations;
  } else if(isDefined(self.rise_target_name)) {
    spots = GetStructArray(self.rise_target_name, "targetname");
  } else if(isDefined(level.zombie_rise_spawners)) {
    if(IsArray(level.zombie_rise_spawners)) {
      spots = level.zombie_rise_spawners[self.script_index];
    } else {
      spots = level.zombie_rise_spawners;
    }
  } else {
    spots = GetStructArray("zombie_rise", "targetname");
  }
  if(spots.size < 1) {
    self unlink();
    self.anchor delete();
    return;
  } else
    spot = random(spots);
  if(!isDefined(spot.angles)) {
    spot.angles = (0, 0, 0);
  }
  anim_org = spot.origin;
  anim_ang = spot.angles;
  if(self.zombie_rise_version == 2) {
    anim_org = anim_org + (0, 0, -14);
  } else {
    anim_org = anim_org + (0, 0, -45);
  }
  self hide();
  self.anchor moveTo(anim_org, .05);
  self.anchor waittill("movedone");
  target_org = maps\_zombiemode_spawner::get_desired_origin();
  if(isDefined(target_org)) {
    anim_ang = VectorToAngles(target_org - self.origin);
    self.anchor RotateTo((0, anim_ang[1], 0), .05);
    self.anchor waittill("rotatedone");
  }
  self unlink();
  self.anchor delete();
  self thread hide_pop();
  level thread zombie_rise_death(self, spot);
  spot thread zombie_rise_fx(self);
  self AnimScripted("rise", self.origin, spot.angles, self get_rise_anim());
  self animscripts\zombie_shared::DoNoteTracks("rise", ::handle_rise_notetracks, undefined, spot);
  self notify("rise_anim_finished");
  spot notify("stop_zombie_rise_fx");
  self.in_the_ground = false;
  self notify("risen", spot.script_noteworthy);
}

hide_pop() {
  wait .5;
  self Show();
}

handle_rise_notetracks(note, spot) {
  if(note == "deathout" || note == "deathhigh") {
    self.zombie_rise_death_out = true;
    self notify("zombie_rise_death_out");
    wait 2;
    spot notify("stop_zombie_rise_fx");
  }
}

zombie_rise_death(zombie, spot) {
  zombie.zombie_rise_death_out = false;
  zombie endon("rise_anim_finished");
  while(zombie.health > 1) {
    zombie waittill("damage", amount);
  }
  spot notify("stop_zombie_rise_fx");
  zombie.deathanim = zombie get_rise_death_anim();
  zombie StopAnimScripted();
}

zombie_rise_fx(zombie) {
  self thread zombie_rise_dust_fx(zombie);
  self thread zombie_rise_burst_fx();
  playsoundatposition("zmb_zombie_spawn", self.origin);
  zombie endon("death");
  self endon("stop_zombie_rise_fx");
  wait 1;
  if(zombie.zombie_move_speed != "sprint") {
    wait 1;
  }
}

zombie_rise_burst_fx() {
  self endon("stop_zombie_rise_fx");
  self endon("rise_anim_finished");
  if(isDefined(self.script_string) && self.script_string == "in_water") {
    playFX(level._effect["rise_burst_water"], self.origin + (0, 0, randomintrange(5, 10)));
    wait(.25);
    playFX(level._effect["rise_billow_water"], self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
  } else {
    playFX(level._effect["rise_burst"], self.origin + (0, 0, randomintrange(5, 10)));
    wait(.25);
    playFX(level._effect["rise_billow"], self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
  }
}

zombie_rise_dust_fx(zombie) {
  dust_tag = "J_SpineUpper";
  self endon("stop_zombie_rise_dust_fx");
  self thread stop_zombie_rise_dust_fx(zombie);
  dust_time = 7.5;
  dust_interval = .1;
  if(isDefined(self.script_string) && self.script_string == "in_water") {
    for(t = 0; t < dust_time; t += dust_interval) {
      playFXOnTag(level._effect["rise_dust_water"], zombie, dust_tag);
      wait dust_interval;
    }
  } else {
    for(t = 0; t < dust_time; t += dust_interval) {
      playFXOnTag(level._effect["rise_dust"], zombie, dust_tag);
      wait dust_interval;
    }
  }
}

stop_zombie_rise_dust_fx(zombie) {
  zombie waittill("death");
  self notify("stop_zombie_rise_dust_fx");
}

get_rise_anim() {
  speed = self.zombie_move_speed;
  return random(level._zombie_rise_anims[self.animname][self.zombie_rise_version][speed]);
}

get_rise_death_anim() {
  possible_anims = [];
  if(self.zombie_rise_death_out) {
    possible_anims = level._zombie_rise_death_anims[self.animname][self.zombie_rise_version]["out"];
  } else {
    possible_anims = level._zombie_rise_death_anims[self.animname][self.zombie_rise_version]["in"];
  }
  return random(possible_anims);
}

make_crawler() {
  if(!isDefined(self)) {
    return;
  }
  self.has_legs = false;
  self.needs_run_update = true;
  self AllowedStances("crouch");
  damage_type[0] = "right_foot";
  damage_type[1] = "left_foot";
  refs = [];
  switch (damage_type[randomInt(damage_type.size)]) {
    case "right_leg_upper":
    case "right_leg_lower":
    case "right_foot":
      refs[refs.size] = "right_leg";
      refs[refs.size] = "right_leg";
      refs[refs.size] = "right_leg";
      refs[refs.size] = "no_legs";
      break;
    case "left_leg_upper":
    case "left_leg_lower":
    case "left_foot":
      refs[refs.size] = "left_leg";
      refs[refs.size] = "left_leg";
      refs[refs.size] = "left_leg";
      refs[refs.size] = "no_legs";
      break;
  }
  if(refs.size) {
    self.a.gib_ref = animscripts\zombie_death::get_random(refs);
    if((self.a.gib_ref == "no_legs" || self.a.gib_ref == "right_leg" || self.a.gib_ref == "left_leg") && self.health > 0) {
      self.has_legs = false;
      self AllowedStances("crouch");
      which_anim = randomInt(5);
      if(self.a.gib_ref == "no_legs") {
        if(randomInt(100) < 50) {
          self.deathanim = % ai_zombie_crawl_death_v1;
          self set_run_anim("death3");
          self.run_combatanim = level.scr_anim[self.animname]["crawl_hand_1"];
          self.crouchRunAnim = level.scr_anim[self.animname]["crawl_hand_1"];
          self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl_hand_1"];
        } else {
          self.deathanim = % ai_zombie_crawl_death_v1;
          self set_run_anim("death3");
          self.run_combatanim = level.scr_anim[self.animname]["crawl_hand_2"];
          self.crouchRunAnim = level.scr_anim[self.animname]["crawl_hand_2"];
          self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl_hand_2"];
        }
      } else if(which_anim == 0) {
        self.deathanim = % ai_zombie_crawl_death_v1;
        self set_run_anim("death3");
        self.run_combatanim = level.scr_anim[self.animname]["crawl1"];
        self.crouchRunAnim = level.scr_anim[self.animname]["crawl1"];
        self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl1"];
      } else if(which_anim == 1) {
        self.deathanim = % ai_zombie_crawl_death_v2;
        self set_run_anim("death4");
        self.run_combatanim = level.scr_anim[self.animname]["crawl2"];
        self.crouchRunAnim = level.scr_anim[self.animname]["crawl2"];
        self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl2"];
      } else if(which_anim == 2) {
        self.deathanim = % ai_zombie_crawl_death_v1;
        self set_run_anim("death3");
        self.run_combatanim = level.scr_anim[self.animname]["crawl3"];
        self.crouchRunAnim = level.scr_anim[self.animname]["crawl3"];
        self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl3"];
      } else if(which_anim == 3) {
        self.deathanim = % ai_zombie_crawl_death_v2;
        self set_run_anim("death4");
        self.run_combatanim = level.scr_anim[self.animname]["crawl4"];
        self.crouchRunAnim = level.scr_anim[self.animname]["crawl4"];
        self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl4"];
      } else if(which_anim == 4) {
        self.deathanim = % ai_zombie_crawl_death_v1;
        self set_run_anim("death3");
        self.run_combatanim = level.scr_anim[self.animname]["crawl5"];
        self.crouchRunAnim = level.scr_anim[self.animname]["crawl5"];
        self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl5"];
      }
    }
  }
}

zombie_disintegrate(player) {
  self DoDamage(self.health + 666, player.origin, player);
  if(self.health <= 0) {
    player maps\_zombiemode_score::player_add_points("death", "", "", self.isdog);
    if(self.has_legs) {
      self.deathanim = random(level._zombie_knockdowns[self.animname]["front"]["has_legs"]);
    } else {
      self.deathanim = random(level._zombie_tesla_crawl_death[self.animname]);
    }
    self swap_to_dissolve_models();
    self setDeathContents(level.CONTENTS_CORPSE);
    self playweapondeatheffects(player GetCurrentWeapon());
    self.thundergun_death = true;
    self.thundergun_disintegrated_death = true;
    self.skip_death_notetracks = true;
    self.nodeathragdoll = true;
    wait(GetDvarFloat(#"cg_dissolveTransitionTime") + 4);
    self_delete();
  }
}

zombie_knockdown(player, gib) {
  if(gib && !self.gibbed) {
    self.a.gib_ref = random(level.thundergun_gib_refs);
    self thread animscripts\zombie_death::do_gib();
  }
  self.thundergun_handle_pain_notetracks = maps\_zombiemode_weap_thundergun::handle_thundergun_pain_notetracks;
  self DoDamage(level.zombie_vars["thundergun_knockdown_damage"], player.origin, player);
}

zombie_tesla_head_gib() {
  if(randomInt(100) < level.zombie_vars["tesla_head_gib_chance"]) {
    wait(RandomFloat(0.53, 1.0));
    self zombie_head_gib();
  } else {
    network_safe_play_fx_on_tag("tesla_death_fx", 2, level._effect["tesla_shock_eyes"], self, "J_Eyeball_LE");
  }
}

play_ambient_zombie_vocals() {
  self endon("death");
  while(1) {
    type = "ambient";
    float = 2;
    if(!isDefined(self.zombie_move_speed)) {
      wait(.5);
      continue;
    }
    switch (self.zombie_move_speed) {
      case "walk":
        type = "ambient";
        float = 4;
        break;
      case "run":
        type = "sprint";
        float = 4;
        break;
      case "sprint":
        type = "sprint";
        float = 4;
        break;
    }
    if(self.animname == "zombie" && !self.has_legs) {
      type = "crawler";
    } else if(self.animname == "thief_zombie") {
      float = 1.2;
    }
    self thread maps\_zombiemode_audio::do_zombies_playvocals(type, self.animname);
    wait(RandomFloatRange(1, float));
  }
}