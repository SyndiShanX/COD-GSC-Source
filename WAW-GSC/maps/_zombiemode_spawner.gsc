/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_spawner.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#using_animtree("generic_human");

init() {
  level.zombie_move_speed = 1;
  level.zombie_health = 150;
  level.zombie_eyes_limited = 1;
  level.zombie_eyes_disabled = 1;
  if(getdvarint("g_allzombieseyeglow")) {
    level.zombie_eyes_limited = 0;
  }
  zombies = getEntArray("zombie_spawner", "script_noteworthy");
  later_rounds = getentarray("later_round_spawners", "script_noteworthy");
  zombies = array_combine(zombies, later_rounds);
  for (i = 0; i < zombies.size; i++) {
    if(is_spawner_targeted_by_blocker(zombies[i])) {
      zombies[i].locked_spawner = true;
    }
  }
  array_thread(zombies, ::add_spawn_function, ::zombie_spawn_init);
  array_thread(zombies, ::add_spawn_function, ::zombie_rise);
}

#using_animtree("generic_human");

is_spawner_targeted_by_blocker(ent) {
  if(isDefined(ent.targetname)) {
    targeters = GetEntArray(ent.targetname, "target");
    for (i = 0; i < targeters.size; i++) {
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

zombie_spawn_init() {
  self.targetname = "zombie";
  self.script_noteworthy = undefined;
  self.animname = "zombie";
  self.ignoreall = true;
  self.allowdeath = true;
  self.gib_override = true;
  self.is_zombie = true;
  self.has_legs = true;
  self.gibbed = false;
  self.head_gibbed = false;
  self PushPlayer(true);
  animscripts\shared::placeWeaponOn(self.primaryweapon, "none");
  self allowedStances("stand");
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
  self disable_pain();
  self.maxhealth = level.zombie_health;
  self.health = level.zombie_health;
  self.dropweapon = false;
  level thread zombie_death_event(self);
  self random_tan();
  self set_zombie_run_cycle();
  self thread zombie_think();
  self thread zombie_gib_on_damage();
  self thread zombie_damage_failsafe();
  self thread delayed_zombie_eye_glow();
  self.deathFunction = ::zombie_death_animscript;
  self.flame_damage_time = 0;
  self zombie_history("zombie_spawn_init -> Spawned = " + self.origin);
  self notify("zombie_init_done");
}

delayed_zombie_eye_glow() {
  wait .5;
  self zombie_eye_glow();
}

zombie_damage_failsafe() {
  self endon("death");
  continue_failsafe_damage = false;
  while (1) {
    wait 0.5;
    if(!isDefined(self.enemy)) {
      continue;
    }
    if(self istouching(self.enemy)) {
      old_org = self.origin;
      if(!continue_failsafe_damage) {
        wait 5;
      }
      if(!isDefined(self.enemy) || self.enemy hasperk("specialty_armorvest")) {
        continue;
      }
      if(self istouching(self.enemy) &&
        !self.enemy maps\_laststand::player_is_in_laststand() &&
        isalive(self.enemy)) {
        if(distancesquared(old_org, self.origin) < (35 * 35)) {
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

set_zombie_run_cycle() {
  self set_run_speed();
  death_anims = [];
  death_anims[death_anims.size] = % ch_dazed_a_death;
  death_anims[death_anims.size] = % ch_dazed_b_death;
  death_anims[death_anims.size] = % ch_dazed_c_death;
  death_anims[death_anims.size] = % ch_dazed_d_death;
  self.deathanim = random(death_anims);
  if(level.round_number < 3) {
    self.zombie_move_speed = "walk";
  }
  switch (self.zombie_move_speed) {
    case "walk":
      var = randomintrange(1, 8);
      self set_run_anim("walk" +
        var);
      self.run_combatanim = level.scr_anim["zombie"]["walk" +
        var
      ];
      break;
    case "run":
      var = randomintrange(1, 6);
      self set_run_anim("run" +
        var);
      self.run_combatanim = level.scr_anim["zombie"]["run" +
        var
      ];
      break;
    case "sprint":
      var = randomintrange(1, 4);
      self set_run_anim("sprint" +
        var);
      self.run_combatanim = level.scr_anim["zombie"]["sprint" +
        var
      ];
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

zombie_think() {
  self endon("death");
  assert(!self enemy_is_dog());
  if(GetDVarInt("zombie_rise_test") || (isDefined(self.script_string) && self.script_string == "riser" && randomint(100) > 25)) {
    self.do_rise = 1;
    self waittill("risen");
  } else {
    self notify("no_rise");
  }
  node = undefined;
  desired_nodes = [];
  self.entrance_nodes = [];
  if(isDefined(self.script_forcegoal) && self.script_forcegoal) {
    desired_origin = get_desired_origin();
    AssertEx(isDefined(desired_origin), "Spawner @ " + self.origin + " has a script_forcegoal but did not find a target");
    origin = desired_origin;
    node = getclosest(origin, level.exterior_goals);
    self.entrance_nodes[0] = node;
    self zombie_history("zombie_think -> #1 entrance (script_forcegoal) origin = " + self.entrance_nodes[0].origin);
  } else if((level.script == "nazi_zombie_sumpf" || level.script == "nazi_zombie_bridgetest" || level.script == "nazi_zombie_bridge_test" ||
      level.script == "nazi_zombie_drawbridge" || level.script == "nazi_zombie_sluicegate" || level.script == "nazi_zombie_pendulum" || level.script == "nazi_zombie_zipline") &&
    isDefined(self.script_string) && (self.script_string == "zombie_chaser" || self.script_string == "riser")) {
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
    max_dist = 500;
    desired_nodes[0] = nodes[0];
    prev_dist = Distance(self.origin, nodes[0].origin);
    for (i = 1; i < nodes.size; i++) {
      dist = Distance(self.origin, nodes[i].origin);
      if((dist - prev_dist) > max_dist) {
        break;
      }
      prev_dist = dist;
      desired_nodes[i] = nodes[i];
    }
    node = desired_nodes[0];
    if(desired_nodes.size > 1) {
      node = desired_nodes[RandomInt(desired_nodes.size)];
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
    ent = GetEnt(self.target, "targetname");
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
  assert(!self enemy_is_dog());
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
    self.first_node.clip connectpaths();
  }
  self zombie_setup_attack_properties();
  if(isDefined(level.script) && level.script == "nazi_zombie_sumpf") {
    if(isDefined(self.target)) {
      temp_node = GetNode(self.target, "targetname");
      if(isDefined(temp_node) && isDefined(temp_node.target)) {
        end_at_node = GetNode(temp_node.target, "targetname");
        if(isDefined(end_at_node)) {
          self setgoalnode(end_at_node);
          self waittill("goal");
        }
      }
    }
  }
  self thread find_flesh();
}

zombie_assure_node() {
  self endon("death");
  self endon("goal");
  level endon("intermission");
  start_pos = self.origin;
  for (i = 0; i < self.entrance_nodes.size; i++) {
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
  if(level.script == "nazi_zombie_asylum" || level.script == "nazi_zombie_sumpf" || level.script == "nazi_zombie_factory") {
    wait(2);
    nodes = get_array_of_closest(self.origin, level.exterior_goals, undefined, 20);
    self.entrance_nodes = nodes;
    for (i = 0; i < self.entrance_nodes.size; i++) {
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
  while (!isDefined(self.zombie_bad_path)) {
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
  self zombie_history("tear_into_building -> start");
  while (1) {
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
      wait(0.5);
      continue;
    }
    self.goalradius = 4;
    self SetGoalPos(self.attacking_spot, self.first_node.angles);
    self waittill("orientdone");
    self zombie_history("tear_into_building -> Reach position and orientated");
    if(all_chunks_destroyed(self.first_node.barrier_chunks)) {
      self zombie_history("tear_into_building -> all chunks destroyed");
      return;
    }
    while (1) {
      chunk = get_closest_non_destroyed_chunk(self.origin, self.first_node.barrier_chunks);
      if(!isDefined(chunk)) {
        for (i = 0; i < self.first_node.attack_spots_taken.size; i++) {
          self.first_node.attack_spots_taken[i] = false;
        }
        return;
      }
      self zombie_history("tear_into_building -> animating");
      tear_anim = get_tear_anim(chunk, self);
      chunk.target_by_zombie = true;
      self AnimScripted("tear_anim", self.origin, self.first_node.angles, tear_anim);
      self zombie_tear_notetracks("tear_anim", chunk, self.first_node);
      if(level.script != "nazi_zombie_prototype") {
        attack = self should_attack_player_thru_boards();
        if(isDefined(attack) && !attack && self.has_legs) {
          self do_a_taunt();
        }
      }
      if(all_chunks_destroyed(self.first_node.barrier_chunks)) {
        for (i = 0; i < self.first_node.attack_spots_taken.size; i++) {
          self.first_node.attack_spots_taken[i] = false;
        }
        return;
      }
    }
    self reset_attack_spot();
  }
}

do_a_taunt() {
  if(!self.has_legs) {
    return false;
  }
  self.old_origin = self.origin;
  if(getdvar("zombie_taunt_freq") == "") {
    setdvar("zombie_taunt_freq", "5");
  }
  freq = getdvarint("zombie_taunt_freq");
  if(freq >= randomint(100)) {
    anime = random(level._zombie_board_taunt);
    self animscripted("zombie_taunt", self.origin, self.angles, anime);
    wait(getanimlength(anime));
    self teleport(self.old_origin);
  }
}

should_attack_player_thru_boards() {
  if(!self.has_legs) {
    return false;
  }
  if(getdvar("zombie_reachin_freq") == "") {
    setdvar("zombie_reachin_freq", "50");
  }
  freq = getdvarint("zombie_reachin_freq");
  players = get_players();
  attack = false;
  for (i = 0; i < players.size; i++) {
    if(distance2d(self.origin, players[i].origin) <= 72) {
      attack = true;
    }
  }
  if(attack && freq >= randomint(100)) {
    self.old_origin = self.origin;
    if(self.attacking_spot_index == 0) {
      if(randomint(100) > 50) {
        self animscripted("window_melee", self.origin, self.angles, % ai_zombie_window_attack_arm_l_out);
      } else {
        self animscripted("window_melee", self.origin, self.angles, % ai_zombie_window_attack_arm_r_out);
      }
      self window_notetracks("window_melee");
    } else if(self.attacking_spot_index == 2) {
      self animscripted("window_melee", self.origin, self.angles, % ai_zombie_window_attack_arm_r_out);
      self window_notetracks("window_melee");
    } else if(self.attacking_spot_index == 1) {
      self animscripted("window_melee", self.origin, self.angles, % ai_zombie_window_attack_arm_l_out);
      self window_notetracks("window_melee");
    }
  } else {
    return false;
  }
}

window_notetracks(msg) {
  while (1) {
    self waittill(msg, notetrack);
    if(notetrack == "end") {
      self teleport(self.old_origin);
      return;
    }
    if(notetrack == "fire") {
      if(self.ignoreall) {
        self.ignoreall = false;
      }
      self melee();
    }
  }
}

crash_into_building() {
  self endon("death");
  self zombie_history("tear_into_building -> start");
  while (1) {
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
      return;
    }
    if(!get_attack_spot(self.first_node)) {
      self zombie_history("tear_into_building -> Could not find an attack spot");
      wait(0.5);
      continue;
    }
    self.goalradius = 4;
    self SetGoalPos(self.attacking_spot, self.first_node.angles);
    self waittill("goal");
    self zombie_history("tear_into_building -> Reach position and orientated");
    while (1) {
      chunk = get_closest_non_destroyed_chunk(self.origin, self.first_node.barrier_chunks);
      if(!isDefined(chunk)) {
        for (i = 0; i < self.first_node.attack_spots_taken.size; i++) {
          self.first_node.attack_spots_taken[i] = false;
        }
        return;
      }
      self zombie_history("tear_into_building -> crash");
      PlayFx(level._effect["wood_chunk_destory"], chunk.origin);
      PlayFx(level._effect["wood_chunk_destory"], chunk.origin + (randomint(20), randomint(20), randomint(10)));
      PlayFx(level._effect["wood_chunk_destory"], chunk.origin + (randomint(40), randomint(40), randomint(20)));
      level thread maps\_zombiemode_blockers::remove_chunk(chunk, self.first_node, true);
      if(all_chunks_destroyed(self.first_node.barrier_chunks)) {
        EarthQuake(randomfloatrange(0.5, 0.8), 0.5, chunk.origin, 300);
        if(isDefined(self.first_node.clip)) {
          self.first_node.clip ConnectPaths();
          wait(0.05);
          self.first_node.clip disable_trigger();
        } else {
          for (i = 0; i < self.first_node.barrier_chunks.size; i++) {
            self.first_node.barrier_chunks[i] ConnectPaths();
          }
        }
      } else {
        EarthQuake(RandomFloatRange(0.1, 0.15), 0.2, chunk.origin, 200);
      }
    }
    self reset_attack_spot();
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
  for (i = 0; i < node.attack_spots.size; i++) {
    if(!node.attack_spots_taken[i]) {
      indexes[indexes.size] = i;
    }
  }
  if(indexes.size == 0) {
    return undefined;
  }
  return indexes[RandomInt(indexes.size)];
}

zombie_tear_notetracks(msg, chunk, node) {
  self endon("death");
  chunk thread check_for_zombie_death(self);
  while (1) {
    self waittill(msg, notetrack);
    if(notetrack == "end") {
      return;
    }
    if(notetrack == "board") {
      if(!chunk.destroyed) {
        self.lastchunk_destroy_time = getTime();
        PlayFx(level._effect["wood_chunk_destory"], chunk.origin);
        PlayFx(level._effect["wood_chunk_destory"], chunk.origin + (randomint(20), randomint(20), randomint(10)));
        PlayFx(level._effect["wood_chunk_destory"], chunk.origin + (randomint(40), randomint(40), randomint(20)));
        level thread maps\_zombiemode_blockers::remove_chunk(chunk, node, true);
        chunk.successfully_destroyed = true;
        chunk notify("destroyed");
      }
    }
  }
}

check_for_zombie_death(zombie) {
  self endon("destroyed");
  wait(2.5);
  self.target_by_zombie = undefined;
}

get_tear_anim(chunk, zombo) {
  anims = [];
  anims[anims.size] = % ai_zombie_door_tear_left;
  anims[anims.size] = % ai_zombie_door_tear_right;
  tear_anim = anims[RandomInt(anims.size)];
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
    } else {
      z_dist = chunk.origin[2] - self.origin[2];
      if(z_dist > 70) {
        tear_anim = % ai_zombie_door_tear_high;
      } else if(z_dist < 40) {
        tear_anim = % ai_zombie_door_tear_low;
      } else {
        anims = [];
        anims[anims.size] = % ai_zombie_door_tear_left;
        anims[anims.size] = % ai_zombie_door_tear_right;
        tear_anim = anims[RandomInt(anims.size)];
      }
    }
  } else {
    anims = [];
    anims[anims.size] = % ai_zombie_attack_crawl;
    anims[anims.size] = % ai_zombie_attack_crawl_lunge;
    tear_anim = anims[RandomInt(anims.size)];
  }
  return tear_anim;
}

zombie_head_gib(attacker) {
  if(is_german_build()) {
    return;
  }
  if(isDefined(self.head_gibbed) && self.head_gibbed) {
    return;
  }
  self.head_gibbed = true;
  self zombie_eye_glow_stop();
  size = self GetAttachSize();
  for (i = 0; i < size; i++) {
    model = self GetAttachModelName(i);
    if(IsSubStr(model, "head")) {
      self thread headshot_blood_fx();
      if(isDefined(self.hatmodel)) {
        self detach(self.hatModel, "");
      }
      self play_sound_on_ent("zombie_head_gib");
      self Detach(model, "", true);
      self Attach("char_ger_honorgd_zomb_behead", "", true);
      break;
    }
  }
  self thread damage_over_time(self.health * 0.2, 1, attacker);
}

damage_over_time(dmg, delay, attacker) {
  self endon("death");
  if(!IsAlive(self)) {
    return;
  }
  if(!IsPlayer(attacker)) {
    attacker = undefined;
  }
  while (1) {
    wait(delay);
    if(isDefined(attacker)) {
      self DoDamage(dmg, self.origin, attacker);
    } else {
      self DoDamage(dmg, self.origin);
    }
  }
}

head_should_gib(attacker, type, point) {
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
  if(!self animscripts\utility::damageLocationIsAny("head", "helmet", "neck")) {
    return false;
  }
  if(weapon == "none" || WeaponClass(weapon) == "pistol" || WeaponIsGasWeapon(self.weapon)) {
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
  forwardVec = AnglesToForward(self GetTagAngles(fxTag));
  PlayFX(level._effect["headshot"], fxOrigin, forwardVec, upVec);
  PlayFX(level._effect["headshot_nochunks"], fxOrigin, forwardVec, upVec);
  wait(0.3);
  if(isDefined(self)) {
    if(self maps\_zombiemode_tesla::enemy_killed_by_tesla()) {
      PlayFxOnTag(level._effect["tesla_head_light"], self, fxTag);
    } else {
      PlayFxOnTag(level._effect["bloodspurt"], self, fxTag);
    }
  }
}

zombie_gib_on_damage() {
  while (1) {
    self waittill("damage", amount, attacker, direction_vec, point, type);
    if(!isDefined(self)) {
      return;
    }
    if(!self zombie_should_gib(amount, attacker, type)) {
      continue;
    }
    if(self head_should_gib(attacker, type, point) && type != "MOD_BURNED") {
      self zombie_head_gib(attacker);
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
            if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE") {
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
        self.a.gib_ref = animscripts\death::get_random(refs);
        if((self.a.gib_ref == "no_legs" || self.a.gib_ref == "right_leg" || self.a.gib_ref == "left_leg") && self.health > 0) {
          self.has_legs = false;
          self AllowedStances("crouch");
          which_anim = RandomInt(5);
          if(self.a.gib_ref == "no_legs") {
            if(randomint(100) < 50) {
              self.deathanim = % ai_zombie_crawl_death_v1;
              self set_run_anim("death3");
              self.run_combatanim = level.scr_anim["zombie"]["crawl_hand_1"];
              self.crouchRunAnim = level.scr_anim["zombie"]["crawl_hand_1"];
              self.crouchrun_combatanim = level.scr_anim["zombie"]["crawl_hand_1"];
            } else {
              self.deathanim = % ai_zombie_crawl_death_v1;
              self set_run_anim("death3");
              self.run_combatanim = level.scr_anim["zombie"]["crawl_hand_2"];
              self.crouchRunAnim = level.scr_anim["zombie"]["crawl_hand_2"];
              self.crouchrun_combatanim = level.scr_anim["zombie"]["crawl_hand_2"];
            }
          } else if(which_anim == 0) {
            self.deathanim = % ai_zombie_crawl_death_v1;
            self set_run_anim("death3");
            self.run_combatanim = level.scr_anim["zombie"]["crawl1"];
            self.crouchRunAnim = level.scr_anim["zombie"]["crawl1"];
            self.crouchrun_combatanim = level.scr_anim["zombie"]["crawl1"];
          } else if(which_anim == 1) {
            self.deathanim = % ai_zombie_crawl_death_v2;
            self set_run_anim("death4");
            self.run_combatanim = level.scr_anim["zombie"]["crawl2"];
            self.crouchRunAnim = level.scr_anim["zombie"]["crawl2"];
            self.crouchrun_combatanim = level.scr_anim["zombie"]["crawl2"];
          } else if(which_anim == 2) {
            self.deathanim = % ai_zombie_crawl_death_v1;
            self set_run_anim("death3");
            self.run_combatanim = level.scr_anim["zombie"]["crawl3"];
            self.crouchRunAnim = level.scr_anim["zombie"]["crawl3"];
            self.crouchrun_combatanim = level.scr_anim["zombie"]["crawl3"];
          } else if(which_anim == 3) {
            self.deathanim = % ai_zombie_crawl_death_v2;
            self set_run_anim("death4");
            self.run_combatanim = level.scr_anim["zombie"]["crawl4"];
            self.crouchRunAnim = level.scr_anim["zombie"]["crawl4"];
            self.crouchrun_combatanim = level.scr_anim["zombie"]["crawl4"];
          } else if(which_anim == 4) {
            self.deathanim = % ai_zombie_crawl_death_v1;
            self set_run_anim("death3");
            self.run_combatanim = level.scr_anim["zombie"]["crawl5"];
            self.crouchRunAnim = level.scr_anim["zombie"]["crawl5"];
            self.crouchrun_combatanim = level.scr_anim["zombie"]["crawl5"];
          }
        }
      }
      if(self.health > 0) {
        self thread animscripts\death::do_gib();
        attacker.stats["zombie_gibs"]++;
      }
    }
  }
}

zombie_should_gib(amount, attacker, type) {
  if(is_german_build()) {
    return false;
  }
  if(!isDefined(type)) {
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
    case "MOD_MELEE":
      return false;
  }
  if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
    if(!isDefined(attacker) || !IsPlayer(attacker)) {
      return false;
    }
    weapon = attacker GetCurrentWeapon();
    if(weapon == "none") {
      return false;
    }
    if(WeaponClass(weapon) == "pistol") {
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
  for (i = 0; i < level.gib_tags.size; i++) {
    if(!isDefined(closestTag)) {
      closestTag = level.gib_tags[i];
    } else {
      if(DistanceSquared(point, self GetTagOrigin(level.gib_tags[i])) < DistanceSquared(point, self GetTagOrigin(closestTag))) {
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

zombie_death_points(origin, mod, hit_location, player, zombie) {
  if(isDefined(zombie.marked_for_death)) {
    return;
  }
  level thread maps\_zombiemode_powerups::powerup_drop(origin);
  if(!isDefined(player) || !IsPlayer(player)) {
    return;
  }
  if(level.script != "nazi_zombie_prototype") {
    level thread play_death_vo(hit_location, player, mod, zombie);
  }
  player maps\_zombiemode_score::player_add_points("death", mod, hit_location);
}

designate_rival_hero(player, hero, rival) {
  players = getplayers();
  playHero = isDefined(players[hero]);
  playRival = isDefined(players[rival]);
  if(playHero && playRival) {
    if(randomfloatrange(0, 1) < .5) {
      playRival = false;
    } else {
      playHero = false;
    }
  }
  if(playHero) {
    if(distance(player.origin, players[hero].origin) < 400) {
      player_responder = "plr_" + hero + "_";
      players[hero] play_headshot_response_hero(player_responder);
    }
  }
  if(playRival) {
    if(distance(player.origin, players[rival].origin) < 400) {
      player_responder = "plr_" + rival + "_";
      players[rival] play_headshot_response_rival(player_responder);
    }
  }
}

play_death_vo(hit_location, player, mod, zombie) {
  if(getdvar("zombie_death_vo_freq") == "") {
    setdvar("zombie_death_vo_freq", "100");
  }
  chance = getdvarint("zombie_death_vo_freq");
  weapon = player GetCurrentWeapon();
  sound = undefined;
  if(chance < randomint(100)) {
    return;
  }
  index = maps\_zombiemode_weapons::get_player_index(player);
  players = getplayers();
  if(!isDefined(level.player_is_speaking)) {
    level.player_is_speaking = 0;
  }
  if(!isDefined(level.zombie_vars["zombie_insta_kill"])) {
    level.zombie_vars["zombie_insta_kill"] = 0;
  }
  if(hit_location == "head" && level.zombie_vars["zombie_insta_kill"] != 1) {
    if(mod != "MOD_PISTOL_BULLET" && mod != "MOD_RIFLE_BULLET") {
      return;
    }
    if(distance(player.origin, zombie.origin) > 450) {
      plr = "plr_" + index + "_";
      player thread play_headshot_dialog(plr);
      if(index == 0) {
        designate_rival_hero(player, 2, 3);
      }
      if(index == 1) {
        designate_rival_hero(player, 3, 2);
      }
      if(index == 2) {
        designate_rival_hero(player, 0, 1);
      }
      if(index == 3) {
        designate_rival_hero(player, 1, 0);
      }
      return;
    }
    if(level.zombie_vars["zombie_insta_kill"] != 0) {
      sound = undefined;
    }
  }
  if(weapon == "ray_gun") {
    if(distance(player.origin, zombie.origin) > 348 && level.zombie_vars["zombie_insta_kill"] == 0) {
      rand = randomintrange(0, 100);
      if(rand < 28) {
        plr = "plr_" + index + "_";
        player play_raygun_dialog(plr);
      }
    }
    return;
  }
  if(weapon == "ray_gun") {
    if(distance(player.origin, zombie.origin) > 348 && level.zombie_vars["zombie_insta_kill"] == 0) {
      rand = randomintrange(0, 100);
      if(rand < 28) {
        plr = "plr_" + index + "_";
        player play_raygun_dialog(plr);
      }
    }
    return;
  }
  if(mod == "MOD_BURNED") {
    plr = "plr_" + index + "_";
    player play_flamethrower_dialog(plr);
    return;
  }
  if(distance(player.origin, zombie.origin) < 64 && level.zombie_vars["zombie_insta_kill"] == 0 && mod != "MOD_BURNED") {
    rand = randomintrange(0, 100);
    if(rand < 40) {
      plr = "plr_" + index + "_";
      player play_closekill_dialog(plr);
    }
    return;
  }
  if(level.zombie_vars["zombie_insta_kill"] != 0) {
    if(mod == "MOD_MELEE" || mod == "MOD_BAYONET" || mod == "MOD_UNKNOWN" && distance(player.origin, zombie.origin) < 64) {
      plr = "plr_" + index + "_";
      player play_insta_melee_dialog(plr);
      return;
    }
  }
  if(mod == "MOD_PROJECTILE") {
    plr = "plr_" + index + "_";
    player play_explosion_dialog(plr);
  }
  if((mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GRENADE") && level.zombie_vars["zombie_insta_kill"] == 0) {
    plr = "plr_" + index + "_";
    player play_explosion_dialog(plr);
    return;
  }
}

play_headshot_response_hero(player_index) {
  waittime = 0;
  if(!isDefined(self.one_at_a_time_hero)) {
    self.one_at_a_time_hero = 0;
  }
  if(!isDefined(self.vox_resp_hr_headdist)) {
    num_variants = get_number_variants(player_index + "vox_resp_hr_headdist");
    self.vox_resp_hr_headdist = [];
    for (i = 0; i < num_variants; i++) {
      self.vox_resp_hr_headdist[self.vox_resp_hr_headdist.size] = "vox_resp_hr_headdist_" + i;
    }
    self.vox_resp_hr_headdist_available = self.vox_resp_hr_headdist;
  }
  if(self.one_at_a_time_hero == 0) {
    self.one_at_a_time_hero = 1;
    sound_to_play = random(self.vox_resp_hr_headdist_available);
    wait(2);
    self do_player_playdialog(player_index, sound_to_play, waittime);
    self.vox_resp_hr_headdist_available = array_remove(self.vox_resp_hr_headdist_available, sound_to_play);
    if(self.vox_resp_hr_headdist_available.size < 1) {
      self.vox_resp_hr_headdist_available = self.vox_resp_hr_headdist;
    }
    self.one_at_a_time_hero = 0;
  }
}

play_headshot_response_rival(player_index) {
  waittime = 0;
  if(!isDefined(self.one_at_a_time_rival)) {
    self.one_at_a_time_rival = 0;
  }
  if(!isDefined(self.vox_resp_riv_headdist)) {
    num_variants = get_number_variants(player_index + "vox_resp_riv_headdist");
    self.vox_resp_riv_headdist = [];
    for (i = 0; i < num_variants; i++) {
      self.vox_resp_riv_headdist[self.vox_resp_riv_headdist.size] = "vox_resp_riv_headdist_" + i;
    }
    self.vox_resp_riv_headdist_available = self.vox_resp_riv_headdist;
  }
  if(self.one_at_a_time_rival == 0) {
    self.one_at_a_time_rival = 1;
    sound_to_play = random(self.vox_resp_riv_headdist_available);
    self.vox_resp_riv_headdist_available = array_remove(self.vox_resp_riv_headdist_available, sound_to_play);
    wait(2);
    self do_player_playdialog(player_index, sound_to_play, waittime);
    if(self.vox_resp_riv_headdist_available.size < 1) {
      self.vox_resp_riv_headdist_available = self.vox_resp_riv_headdist;
    }
    self.one_at_a_time_rival = 0;
  }
}

play_projectile_dialog(player_index) {
  waittime = 1;
  if(!isDefined(self.one_at_a_time)) {
    self.one_at_a_time = 0;
  }
  if(!isDefined(self.vox_kill_explo)) {
    num_variants = get_number_variants(player_index + "vox_kill_explo");
    self.vox_kill_explo = [];
    for (i = 0; i < num_variants; i++) {
      self.vox_kill_explo[self.vox_kill_explo.size] = "vox_kill_explo_" + i;
    }
    self.vox_kill_explo_available = self.vox_kill_explo;
  }
  if(self.one_at_a_time == 0) {
    self.one_at_a_time = 1;
    sound_to_play = random(self.vox_kill_explo_available);
    self.vox_kill_explo_available = array_remove(self.vox_kill_explo_available, sound_to_play);
    self do_player_playdialog(player_index, sound_to_play, waittime);
    if(self.vox_kill_explo_available.size < 1) {
      self.vox_kill_explo_available = self.vox_kill_explo;
    }
    self.one_at_a_time = 0;
  }
}

play_explosion_dialog(player_index) {
  waittime = 0.25;
  if(!isDefined(self.one_at_a_time)) {
    self.one_at_a_time = 0;
  }
  if(!isDefined(self.vox_kill_explo)) {
    num_variants = get_number_variants(player_index + "vox_kill_explo");
    self.vox_kill_explo = [];
    for (i = 0; i < num_variants; i++) {
      self.vox_kill_explo[self.vox_kill_explo.size] = "vox_kill_explo_" + i;
    }
    self.vox_kill_explo_available = self.vox_kill_explo;
  }
  if(self.one_at_a_time == 0) {
    self.one_at_a_time = 1;
    sound_to_play = random(self.vox_kill_explo_available);
    self.vox_kill_explo_available = array_remove(self.vox_kill_explo_available, sound_to_play);
    self do_player_playdialog(player_index, sound_to_play, waittime);
    if(self.vox_kill_explo_available.size < 1) {
      self.vox_kill_explo_available = self.vox_kill_explo;
    }
    self.one_at_a_time = 0;
  }
}

play_flamethrower_dialog(player_index) {
  waittime = 0.5;
  if(!isDefined(self.one_at_a_time)) {
    self.one_at_a_time = 0;
  }
  if(!isDefined(self.vox_kill_flame)) {
    num_variants = get_number_variants(player_index + "vox_kill_flame");
    self.vox_kill_flame = [];
    for (i = 0; i < num_variants; i++) {
      self.vox_kill_flame[self.vox_kill_flame.size] = "vox_kill_flame_" + i;
    }
    self.vox_kill_flame_available = self.vox_kill_flame;
  }
  if(self.one_at_a_time == 0) {
    self.one_at_a_time = 1;
    sound_to_play = random(self.vox_kill_flame_available);
    self.vox_kill_flame_available = array_remove(self.vox_kill_flame_available, sound_to_play);
    self do_player_playdialog(player_index, sound_to_play, waittime);
    if(self.vox_kill_flame_available.size < 1) {
      self.vox_kill_flame_available = self.vox_kill_flame;
    }
    self.one_at_a_time = 0;
  }
}

play_closekill_dialog(player_index) {
  waittime = 1;
  if(!isDefined(self.one_at_a_time)) {
    self.one_at_a_time = 0;
  }
  if(!isDefined(self.vox_close)) {
    num_variants = get_number_variants(player_index + "vox_close");
    self.vox_close = [];
    for (i = 0; i < num_variants; i++) {
      self.vox_close[self.vox_close.size] = "vox_close_" + i;
    }
    self.vox_close_available = self.vox_close;
  }
  if(self.one_at_a_time == 0) {
    self.one_at_a_time = 1;
    if(self.vox_close_available.size >= 1) {
      sound_to_play = random(self.vox_close_available);
      self.vox_close_available = array_remove(self.vox_close_available, sound_to_play);
      self do_player_playdialog(player_index, sound_to_play, waittime);
    }
    if(self.vox_close_available.size < 1) {
      self.vox_close_available = self.vox_close;
    }
    self.one_at_a_time = 0;
  }
}

get_number_variants(aliasPrefix) {
  for (i = 0; i < 100; i++) {
    if(!SoundExists(aliasPrefix + "_" + i)) {
      return i;
    }
  }
}

play_headshot_dialog(player_index) {
  waittime = 0.25;
  if(!isDefined(self.vox_kill_headdist)) {
    num_variants = get_number_variants(player_index + "vox_kill_headdist");
    self.vox_kill_headdist = [];
    for (i = 0; i < num_variants; i++) {
      self.vox_kill_headdist[self.vox_kill_headdist.size] = "vox_kill_headdist_" + i;
    }
    self.vox_kill_headdist_available = self.vox_kill_headdist;
  }
  sound_to_play = random(self.vox_kill_headdist_available);
  self do_player_playdialog(player_index, sound_to_play, waittime);
  self.vox_kill_headdist_available = array_remove(self.vox_kill_headdist_available, sound_to_play);
  if(self.vox_kill_headdist_available.size < 1) {
    self.vox_kill_headdist_available = self.vox_kill_headdist;
  }
}

play_tesla_dialog(player_index) {
  waittime = 0.25;
  if(!isDefined(self.vox_kill_tesla)) {
    num_variants = get_number_variants(player_index + "vox_kill_tesla");
    self.vox_kill_tesla = [];
    for (i = 0; i < num_variants; i++) {
      self.vox_kill_tesla[self.vox_kill_tesla.size] = "vox_kill_tesla_" + i;
    }
    self.vox_kill_tesla_available = self.vox_kill_tesla;
  }
  if(!isDefined(level.player_is_speaking)) {
    level.player_is_speaking = 0;
  }
  sound_to_play = random(self.vox_kill_tesla_available);
  self do_player_playdialog(player_index, sound_to_play, waittime);
  self.vox_kill_tesla_available = array_remove(self.vox_kill_tesla_available, sound_to_play);
  if(self.vox_kill_tesla_available.size < 1) {
    self.vox_kill_tesla_available = self.vox_kill_tesla;
  }
}

play_raygun_dialog(player_index) {
  waittime = 0.05;
  if(!isDefined(self.vox_kill_ray)) {
    num_variants = get_number_variants(player_index + "vox_kill_ray");
    self.vox_kill_ray = [];
    for (i = 0; i < num_variants; i++) {
      self.vox_kill_ray[self.vox_kill_ray.size] = "vox_kill_ray_" + i;
    }
    self.vox_kill_ray_available = self.vox_kill_ray;
  }
  if(!isDefined(level.player_is_speaking)) {
    level.player_is_speaking = 0;
  }
  sound_to_play = random(self.vox_kill_ray_available);
  self do_player_playdialog(player_index, sound_to_play, waittime);
  self.vox_kill_ray_available = array_remove(self.vox_kill_ray_available, sound_to_play);
  if(self.vox_kill_ray_available.size < 1) {
    self.vox_kill_ray_available = self.vox_kill_ray;
  }
}

play_insta_melee_dialog(player_index) {
  waittime = 0.25;
  if(!isDefined(self.one_at_a_time)) {
    self.one_at_a_time = 0;
  }
  if(!isDefined(self.vox_insta_melee)) {
    num_variants = get_number_variants(player_index + "vox_insta_melee");
    self.vox_insta_melee = [];
    for (i = 0; i < num_variants; i++) {
      self.vox_insta_melee[self.vox_insta_melee.size] = "vox_insta_melee_" + i;
    }
    self.vox_insta_melee_available = self.vox_insta_melee;
  }
  if(self.one_at_a_time == 0) {
    self.one_at_a_time = 1;
    sound_to_play = random(self.vox_insta_melee_available);
    self.vox_insta_melee_available = array_remove(self.vox_insta_melee_available, sound_to_play);
    if(self.vox_insta_melee_available.size < 1) {
      self.vox_insta_melee_available = self.vox_insta_melee;
    }
    self do_player_playdialog(player_index, sound_to_play, waittime);
    wait(waittime);
    self.one_at_a_time = 0;
  }
}

do_player_playdialog(player_index, sound_to_play, waittime) {
  if(!isDefined(level.player_is_speaking)) {
    level.player_is_speaking = 0;
  }
  if(level.player_is_speaking != 1) {
    level.player_is_speaking = 1;
    self playsound(player_index + sound_to_play, "sound_done" + sound_to_play);
    self waittill("sound_done" + sound_to_play);
    wait(waittime);
    level.player_is_speaking = 0;
  }
}

zombie_death_animscript() {
  self reset_attack_spot();
  if(self maps\_zombiemode_tesla::enemy_killed_by_tesla()) {
    return false;
  }
  if(self.has_legs && isDefined(self.a.gib_ref) && self.a.gib_ref == "no_legs") {
    self.deathanim = % ai_gib_bothlegs_gib;
  }
  self.grenadeAmmo = 0;
  level zombie_death_points(self.origin, self.damagemod, self.damagelocation, self.attacker, self);
  if(self.damagemod == "MOD_BURNED") {
    self thread animscripts\death::flame_death_fx();
  }
  return false;
}

damage_on_fire(player) {
  self endon("death");
  self endon("stop_flame_damage");
  wait(2);
  while (isDefined(self.is_on_fire) && self.is_on_fire) {
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

zombie_damage(mod, hit_location, hit_origin, player) {
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
      player maps\_zombiemode_score::player_add_points("damage", mod, hit_location, self enemy_is_dog());
    }
  } else if(self maps\_zombiemode_tesla::is_tesla_damage(mod)) {
    self maps\_zombiemode_tesla::tesla_damage_init(hit_location, hit_origin, player);
    return;
  } else {
    player maps\_zombiemode_score::player_add_points("damage", mod, hit_location, self enemy_is_dog());
  }
  if(mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH") {
    if(isDefined(player) && isalive(player)) {
      self DoDamage(level.round_number + randomint(100, 500), self.origin, player);
    } else {
      self DoDamage(level.round_number + randomint(100, 500), self.origin, undefined);
    }
  } else if(mod == "MOD_PROJECTILE" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_PROJECTILE_SPLASH") {
    if(isDefined(player) && isalive(player)) {
      self DoDamage(level.round_number * randomintrange(0, 100), self.origin, player);
    } else {
      self DoDamage(level.round_number * randomintrange(0, 100), self.origin, undefined);
    }
  } else if(mod == "MOD_ZOMBIE_BETTY") {
    if(isDefined(player) && isalive(player)) {
      self DoDamage(level.round_number * randomintrange(100, 200), self.origin, player);
    } else {
      self DoDamage(level.round_number * randomintrange(100, 200), self.origin, undefined);
    }
  }
  self thread maps\_zombiemode_powerups::check_for_instakill(player);
}

zombie_damage_ads(mod, hit_location, hit_origin, player) {
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
  } else if(self maps\_zombiemode_tesla::is_tesla_damage(mod)) {
    self maps\_zombiemode_tesla::tesla_damage_init(hit_location, hit_origin, player);
    return;
  } else {
    player maps\_zombiemode_score::player_add_points("damage_ads", mod, hit_location);
  }
  self thread maps\_zombiemode_powerups::check_for_instakill(player);
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
    for (i = 0; i < ai.size; i++) {
      if(isDefined(ai[i].is_on_fire) && ai[i].is_on_fire) {
        if(DistanceSquared(ai[i].origin, self.origin) < dist) {
          do_flame_death = false;
          break;
        }
      }
    }
    if(do_flame_death) {
      self thread animscripts\death::flame_death_fx();
    }
    return true;
  }
  return false;
}

zombie_death_event(zombie) {
  zombie waittill("death");
  zombie thread zombie_eye_glow_stop();
  playsoundatposition("death_vocals", zombie.origin);
  if(isDefined(zombie.attacker) && isplayer(zombie.attacker) && level.script != "nazi_zombie_prototype") {
    if(!isDefined(zombie.attacker.killcounter)) {
      zombie.attacker.killcounter = 1;
    } else {
      zombie.attacker.killcounter++;
    }
    if(isDefined(zombie.sound_damage_player) && zombie.sound_damage_player == zombie.attacker) {
      zombie.attacker thread play_closeDamage_dialog();
    }
    zombie.attacker notify("zom_kill");
  }
}

play_closeDamage_dialog() {
  index = maps\_zombiemode_weapons::get_player_index(self);
  player_index = "plr_" + index + "_";
  if(!isDefined(self.vox_dmg_close)) {
    num_variants = maps\_zombiemode_spawner::get_number_variants(player_index + "vox_dmg_close");
    self.vox_dmg_close = [];
    for (i = 0; i < num_variants; i++) {
      self.vox_dmg_close[self.vox_dmg_close.size] = "vox_dmg_close_" + i;
    }
    self.vox_dmg_close_available = self.vox_dmg_close;
  }
  sound_to_play = random(self.vox_dmg_close_available);
  self.vox_dmg_close_available = array_remove(self.vox_dmg_close_available, sound_to_play);
  if(self.vox_dmg_close_available.size < 1) {
    self.vox_dmg_close_available = self.vox_dmg_close;
  }
  self maps\_zombiemode_spawner::do_player_playdialog(player_index, sound_to_play, 0.25);
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
  if(level.intermission) {
    return;
  }
  self.ignore_player = undefined;
  self zombie_history("find flesh -> start");
  self.goalradius = 32;
  while (1) {
    players = get_players();
    if(players.size == 1) {
      self.ignore_player = undefined;
    }
    player = get_closest_valid_player(self.origin, self.ignore_player);
    if(!isDefined(player)) {
      self zombie_history("find flesh -> can't find player, continue");
      if(isDefined(self.ignore_player)) {
        self.ignore_player = undefined;
      }
      wait(1);
      continue;
    }
    self.ignore_player = undefined;
    self.favoriteenemy = player;
    self thread zombie_pathing();
    self.zombie_path_timer = GetTime() + (RandomFloatRange(1, 3) * 1000);
    while (GetTime() < self.zombie_path_timer) {
      wait(0.1);
    }
    self zombie_history("find flesh -> bottom of loop");
    debug_print("Zombie is re-acquiring enemy, ending breadcrumb search");
    self notify("zombie_acquire_enemy");
  }
}

zombie_pathing() {
  self endon("death");
  self endon("zombie_acquire_enemy");
  level endon("intermission");
  assert(isDefined(self.favoriteenemy));
  self.favoriteenemy endon("disconnect");
  self thread zombie_follow_enemy();
  self waittill("bad_path");
  debug_print("Zombie couldn't path to player at origin: " + self.favoriteenemy.origin + " Falling back to breadcrumb system");
  crumb_list = self.favoriteenemy.zombie_breadcrumbs;
  bad_crumbs = [];
  while (1) {
    if(!is_player_valid(self.favoriteenemy)) {
      self.zombie_path_timer = 0;
      return;
    }
    goal = zombie_pathing_get_breadcrumb(self.favoriteenemy.origin, crumb_list, bad_crumbs, (RandomInt(100) < 20));
    if(!isDefined(goal)) {
      debug_print("Zombie exhausted breadcrumb search");
      goal = self.favoriteenemy.spectator_respawn.origin;
    }
    debug_print("Setting current breadcrumb to " + goal);
    self.zombie_path_timer += 1000;
    self SetGoalPos(goal);
    self waittill("bad_path");
    debug_print("Zombie couldn't path to breadcrumb at " + goal + " Finding next breadcrumb");
    for (i = 0; i < crumb_list.size; i++) {
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
  if(pick_random) {
    debug_print("Finding random breadcrumb");
  }
  for (i = 0; i < breadcrumbs.size; i++) {
    if(pick_random) {
      crumb_index = RandomInt(breadcrumbs.size);
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
  for (i = 0; i < bad_crumbs.size; i++) {
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
  while (isDefined(self.favoriteenemy.zombie_breadcrumbs[index + 1])) {
    current_crumb = self.favoriteenemy.zombie_breadcrumbs[index];
    next_crumb = self.favoriteenemy.zombie_breadcrumbs[index + 1];
    angles = vectortoangles(current_crumb - next_crumb);
    right = anglestoright(angles);
    left = anglestoright(angles + (0, 180, 0));
    dist_pos = current_crumb + vectorScale(right, trace_distance);
    trace = bulletTrace(current_crumb, dist_pos, true, undefined);
    vector = trace["position"];
    if(distance(vector, current_crumb) < 17) {
      self.favoriteenemy.zombie_breadcrumbs[index] = current_crumb + vectorScale(left, jitter_distance);
      continue;
    }
    dist_pos = current_crumb + vectorScale(left, trace_distance);
    trace = bulletTrace(current_crumb, dist_pos, true, undefined);
    vector = trace["position"];
    if(distance(vector, current_crumb) < 17) {
      self.favoriteenemy.zombie_breadcrumbs[index] = current_crumb + vectorScale(right, jitter_distance);
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
  while (1) {
    if(isDefined(self.favoriteenemy)) {
      self SetGoalPos(self.favoriteenemy.origin);
    }
    if(isDefined(level.script) && level.script == "nazi_zombie_sumpf") {
      if(isDefined(self.favoriteenemy.on_zipline) && self.favoriteenemy.on_zipline == true) {
        crumb_list = self.favoriteenemy.zombie_breadcrumbs;
        bad_crumbs = [];
        goal = zombie_pathing_get_breadcrumb(self.favoriteenemy.origin, crumb_list, bad_crumbs, 0);
        if(isDefined(goal))
          self SetGoalPos(goal);
      }
    }
    wait(0.1);
  }
}

zombie_eye_glow() {
  if(isDefined(level.zombie_eye_glow) && !level.zombie_eye_glow) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(level._numZombEyeGlows)) {
    level._numZombEyeGlows = 0;
  }
  if(level.zombie_eyes_limited && level._numZombEyeGlows > 8) {
    return;
  }
  if(level.zombie_eyes_disabled) {
    return;
  }
  linkTag = "J_Eyeball_LE";
  fxModel = "tag_origin";
  fxTag = "tag_origin";
  self.fx_eye_glow = Spawn("script_model", self GetTagOrigin(linkTag));
  self.fx_eye_glow.angles = self GetTagAngles(linkTag);
  self.fx_eye_glow SetModel(fxModel);
  self.fx_eye_glow LinkTo(self, linkTag);
  PlayFxOnTag(level._effect["eye_glow"], self.fx_eye_glow, fxTag);
  level._numZombEyeGlows++;
}

zombie_eye_glow_stop() {
  if(isDefined(self.fx_eye_glow)) {
    self.fx_eye_glow Delete();
    level._numZombEyeGlows--;
  }
}

zombie_history(msg) {
  if(!isDefined(self.zombie_history)) {
    self.zombie_history = [];
  }
  self.zombie_history[self.zombie_history.size] = msg;
}

zombie_rise() {
  self endon("death");
  self endon("no_rise");
  while (!isDefined(self.do_rise)) {
    wait_network_frame();
  }
  self do_zombie_rise();
}

do_zombie_rise() {
  self endon("death");
  self.zombie_rise_version = (RandomInt(99999) % 2) + 1;
  if(self.zombie_move_speed != "walk") {
    self.zombie_rise_version = 1;
  }
  self.in_the_ground = true;
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkto(self.anchor);
  if(level.script == "nazi_zombie_sumpf" && isDefined(level.zombie_rise_spawners)) {
    spots = level.zombie_rise_spawners;
  } else {
    spots = GetStructArray("zombie_rise", "targetname");
  }
  if(spots.size < 1) {
    self unlink();
    self.anchor delete();
    return;
  } else
    spot = random(spots);
  if(GetDVarInt("zombie_rise_test")) {
    spot = SpawnStruct();
    spot.origin = (472, 240, 56);
    spot.angles = (0, 0, 0);
  }
  anim_org = spot.origin;
  anim_ang = spot.angles;
  if(self.zombie_rise_version == 2) {
    anim_org = anim_org + (0, 0, -14);
  } else {
    anim_org = anim_org + (0, 0, -45);
  }
  self Hide();
  self.anchor moveto(anim_org, .05);
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
  self AnimScripted("rise", self.origin, self.angles, self get_rise_anim());
  self animscripts\shared::DoNoteTracks("rise", ::handle_rise_notetracks, undefined, spot);
  self notify("rise_anim_finished");
  spot notify("stop_zombie_rise_fx");
  self.in_the_ground = false;
  self notify("risen");
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
  while (zombie.health > 1) {
    zombie waittill("damage", amount);
  }
  spot notify("stop_zombie_rise_fx");
  zombie.deathanim = zombie get_rise_death_anim();
  zombie StopAnimScripted();
}

zombie_rise_fx(zombie) {
  self thread zombie_rise_dust_fx(zombie);
  self thread zombie_rise_burst_fx();
  playsoundatposition("zombie_spawn", self.origin);
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
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "in_water") {
    playfx(level._effect["rise_burst_water"], self.origin + (0, 0, randomintrange(5, 10)));
    wait(.25);
    playfx(level._effect["rise_billow_water"], self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
  } else {
    playfx(level._effect["rise_burst"], self.origin + (0, 0, randomintrange(5, 10)));
    wait(.25);
    playfx(level._effect["rise_billow"], self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
  }
}

zombie_rise_dust_fx(zombie) {
  dust_tag = "J_SpineUpper";
  self endon("stop_zombie_rise_dust_fx");
  self thread stop_zombie_rise_dust_fx(zombie);
  dust_time = 7.5;
  dust_interval = .1;
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "in_water") {
    for (t = 0; t < dust_time; t += dust_interval) {
      PlayfxOnTag(level._effect["rise_dust_water"], zombie, dust_tag);
      wait dust_interval;
    }
  } else {
    for (t = 0; t < dust_time; t += dust_interval) {
      PlayfxOnTag(level._effect["rise_dust"], zombie, dust_tag);
      wait dust_interval;
    }
  }
}

stop_zombie_rise_dust_fx(zombie) {
  zombie waittill("death");
  self notify("stop_zombie_rise_dust_fx");
}

get_rise_anim() {}

get_rise_death_anim() {
  possible_anims = [];
  if(self.zombie_rise_death_out) {
    possible_anims = level._zombie_rise_death_anims[self.zombie_rise_version]["out"];
  } else {
    possible_anims = level._zombie_rise_death_anims[self.zombie_rise_version]["in"];
  }
  return random(possible_anims);
}