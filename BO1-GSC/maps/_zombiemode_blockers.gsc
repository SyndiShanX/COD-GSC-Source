/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_blockers.gsc
*****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#using_animtree("generic_human");
init() {
  init_blockers();
  if(isDefined(level.quantum_bomb_register_result_func)) {
    [[level.quantum_bomb_register_result_func]]("open_nearest_door", ::quantum_bomb_open_nearest_door_result, 35, ::quantum_bomb_open_nearest_door_validation);
  }
}

init_blockers() {
  level.exterior_goals = getstructarray("exterior_goal", "targetname");
  for(i = 0; i < level.exterior_goals.size; i++) {
    level.exterior_goals[i] thread blocker_init();
  }
  zombie_doors = getEntArray("zombie_door", "targetname");
  for(i = 0; i < zombie_doors.size; i++) {
    zombie_doors[i] thread door_init();
  }
  zombie_debris = getEntArray("zombie_debris", "targetname");
  for(i = 0; i < zombie_debris.size; i++) {
    zombie_debris[i] thread debris_init();
  }
  flag_blockers = getEntArray("flag_blocker", "targetname");
  for(i = 0; i < flag_blockers.size; i++) {
    flag_blockers[i] thread flag_blocker();
  }
  window_shutter = getEntArray("window_shutter", "targetname");
  for(i = 0; i < window_shutter.size; i++) {
    window_shutter[i] thread shutter_init();
  }
}

door_init() {
  self.type = undefined;
  self._door_open = false;
  targets = getEntArray(self.target, "targetname");
  if(isDefined(self.script_flag) && !isDefined(level.flag[self.script_flag])) {
    if(isDefined(self.script_flag)) {
      tokens = Strtok(self.script_flag, ",");
      for(i = 0; i < tokens.size; i++) {
        flag_init(self.script_flag);
      }
    }
  }
  if(!isDefined(self.script_noteworthy)) {
    self.script_noteworthy = "default";
  }
  self.doors = [];
  for(i = 0; i < targets.size; i++) {
    targets[i] door_classify(self);
  }
  cost = 1000;
  if(isDefined(self.zombie_cost)) {
    cost = self.zombie_cost;
  }
  self SetCursorHint("HINT_NOICON");
  self thread door_think();
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "electric_door" || self.script_noteworthy == "electric_buyable_door") {
      self sethintstring(&"ZOMBIE_NEED_POWER");
      if(isDefined(level.door_dialog_function)) {
        self thread[[level.door_dialog_function]]();
      }
      return;
    } else if(self.script_noteworthy == "kill_counter_door") {
      self sethintstring(&"ZOMBIE_DOOR_ACTIVATE_COUNTER", cost);
      return;
    }
  }
  self set_hint_string(self, "default_buy_door_" + cost);
}

door_classify(parent_trig) {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "clip") {
    parent_trig.clip = self;
    parent_trig.script_string = "clip";
  } else if(!isDefined(self.script_string)) {
    if(isDefined(self.script_angles)) {
      self.script_string = "rotate";
    } else if(isDefined(self.script_vector)) {
      self.script_string = "move";
    }
  } else {
    if(!isDefined(self.script_string)) {
      self.script_string = "";
    }
    switch (self.script_string) {
      case "anim":
        AssertEx(isDefined(self.script_animname), "Blocker_init: You must specify a script_animname for " + self.targetname);
        AssertEx(isDefined(level.scr_anim[self.script_animname]), "Blocker_init: You must define a level.scr_anim for script_anim -> " + self.script_animname);
        AssertEx(isDefined(level.blocker_anim_func), "Blocker_init: You must define a level.blocker_anim_func");
        break;
      case "counter_1s":
        parent_trig.counter_1s = self;
        return;
      case "counter_10s":
        parent_trig.counter_10s = self;
        return;
      case "counter_100s":
        parent_trig.counter_100s = self;
        return;
      case "explosives":
        if(!isDefined(parent_trig.explosives)) {
          parent_trig.explosives = [];
        }
        parent_trig.explosives[parent_trig.explosives.size] = self;
        return;
    }
  }
  if(self.classname == "script_brushmodel") {
    self DisconnectPaths();
  }
  parent_trig.doors[parent_trig.doors.size] = self;
}

door_buy() {
  self waittill("trigger", who, force);
  if(GetDvarInt(#"zombie_unlock_all") > 0 || is_true(force)) {
    return true;
  }
  if(!who UseButtonPressed()) {
    return false;
  }
  if(who in_revive_trigger()) {
    return false;
  }
  if(is_player_valid(who)) {
    players = get_players();
    if(players.size == 1 && who.score >= self.zombie_cost) {
      who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);
    } else if(level.team_pool[who.team_num].score >= self.zombie_cost) {
      who maps\_zombiemode_score::minus_to_team_score(self.zombie_cost);
    } else if(level.team_pool[who.team_num].score + who.score >= self.zombie_cost) {
      team_points = level.team_pool[who.team_num].score;
      who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost - team_points);
      who maps\_zombiemode_score::minus_to_team_score(team_points);
    } else {
      play_sound_at_pos("no_purchase", self.doors[0].origin);
      who maps\_zombiemode_audio::create_and_play_dialog("general", "door_deny", undefined, 0);
      return false;
    }
    bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type door", who.playername, who.score, level.team_pool[who.team_num].score, level.round_number, self.zombie_cost, self.script_flag, self.origin);
  }
  return true;
}

door_delay() {
  if(isDefined(self.explosives)) {
    for(i = 0; i < self.explosives.size; i++) {
      self.explosives[i] Show();
    }
  }
  if(!isDefined(self.script_int)) {
    self.script_int = 5;
  }
  all_trigs = getEntArray(self.target, "target");
  for(i = 0; i < all_trigs.size; i++) {
    all_trigs[i] trigger_off();
  }
  wait(self.script_int);
  for(i = 0; i < self.script_int; i++) {
    wait(1);
  }
  if(isDefined(self.explosives)) {
    for(i = 0; i < self.explosives.size; i++) {
      playFX(level._effect["def_explosion"], self.explosives[i].origin, anglesToForward(self.explosives[i].angles));
      self.explosives[i] hide();
    }
  }
}

kill_countdown() {
  kills_remaining = self.kill_goal - level.total_zombies_killed;
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    if(is_true(level.player_4_vox_override)) {
      players[i] playlocalsound("zmb_laugh_rich");
    } else {
      players[i] playlocalsound("zmb_laugh_child");
    }
  }
  level.kill_counter_hud FadeOverTime(1.0);
  level.kill_counter_hud.alpha = 1;
  num_stages = 3;
  if(isDefined(self.counter_10s)) {
    num_stages = 4;
  } else {
    num_stages = 5;
  }
  time_per_stage = 1.0;
  steps = time_per_stage * num_stages / 0.1;
  steps_per_stage = steps / num_stages;
  stage_num = 1;
  ones = 0;
  tens = 0;
  hundreds = 0;
  for(i = 0; i < steps; i++) {
    if(i > steps_per_stage * stage_num) {
      stage_num++;
    }
    if(num_stages - stage_num == 0) {
      ones = kills_remaining % 10;
    } else {
      ones = i % 10;
    }
    self.counter_1s set_counter(ones);
    if(isDefined(self.counter_10s)) {
      if(num_stages - stage_num <= 1) {
        tens = int(kills_remaining / 10);
      } else {
        tens = i % 10;
      }
      self.counter_10s set_counter(tens);
    }
    if(isDefined(self.counter_100s)) {
      if(num_stages - stage_num <= 1) {
        hundreds = int(kills_remaining / 100);
      } else {
        hundreds = i % 10;
      }
      self.counter_100s set_counter(hundreds);
    }
    level.kill_counter_hud SetValue(hundreds * 100 + tens * 10 + ones);
    wait(0.1);
  }
  level.kill_counter_hud FadeOverTime(1.0);
  level.kill_counter_hud.color = (0.21, 0, 0);
  while(level.total_zombies_killed < self.kill_goal) {
    kills_remaining = self.kill_goal - level.total_zombies_killed;
    self.counter_1s set_counter(kills_remaining % 10);
    if(isDefined(self.counter_10s)) {
      self.counter_10s set_counter(int(kills_remaining / 10));
    }
    if(isDefined(self.counter_100s)) {
      self.counter_100s set_counter(int(kills_remaining / 100));
    }
    level.kill_counter_hud SetValue(kills_remaining);
    level waittill("zom_kill");
  }
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] playlocalsound("zmb_perks_packa_ready");
  }
  self.counter_1s set_counter(0);
  if(isDefined(self.counter_10s)) {
    self.counter_10s set_counter(0);
  }
  if(isDefined(self.counter_100s)) {
    self.counter_100s set_counter(0);
  }
  level.kill_counter_hud SetValue(0);
  wait(1.0);
  self notify("countdown_finished");
}

door_kill_counter() {
  counter = 0;
  if(!isDefined(self.script_int)) {
    counter = 5;
  } else {
    counter = self.script_int;
    players = GetPlayers();
    if(players.size < 4) {
      fraction = int(counter * 0.2);
      counter -= fraction * (4 - players.size);
    }
  }
  counter = RandomIntRange(counter, Int(counter * 1.2) + 1);
  AssertEx(isDefined(self.counter_1s), "Door Kill counter needs a 'ones' digit model");
  AssertEx((counter < 9 || isDefined(self.counter_10s)), "Door Kill counter needs a 'tens' digit model");
  AssertEx((counter < 99 || isDefined(self.counter_100s)), "Door Kill counter needs a 'hundreds' digit model");
  level.kill_counter_hud = create_counter_hud();
  num_enemies = get_enemy_count();
  if(level.zombie_total + num_enemies < counter) {
    level.zombie_total += counter - num_enemies;
  }
  all_trigs = getEntArray(self.target, "target");
  for(i = 0; i < all_trigs.size; i++) {
    all_trigs[i] trigger_off();
  }
  self.kill_goal = level.total_zombies_killed + counter;
  self thread kill_countdown();
  self waittill("countdown_finished");
  level.kill_counter_hud destroy_hud();
  self.counter_1s Delete();
  if(isDefined(self.counter_10s)) {
    self.counter_10s Delete();
  }
  if(isDefined(self.counter_100s)) {
    self.counter_100s Delete();
  }
  if(isDefined(self.explosives)) {
    for(i = 0; i < self.explosives.size; i++) {
      self.explosives[i] hide();
    }
    playFX(level._effect["betty_explode"], self.explosives[0].origin, anglesToForward(self.explosives[0].angles));
    self.explosives[0] playSound("mpl_kls_artillery_impact");
  }
}

door_activate(time, open) {
  if(!isDefined(time)) {
    time = 1;
    if(isDefined(self.script_transition_time)) {
      time = self.script_transition_time;
    }
  }
  if(!isDefined(open)) {
    open = true;
  }
  self NotSolid();
  if(self.classname == "script_brushmodel") {
    if(open) {
      self ConnectPaths();
    }
  }
  if(isDefined(self.door_moving)) {
    return;
  }
  self.door_moving = 1;
  if((isDefined(self.script_noteworthy) && self.script_noteworthy == "clip") || (isDefined(self.script_string) && self.script_string == "clip")) {
    return;
  }
  if(isDefined(self.script_sound)) {
    play_sound_at_pos(self.script_sound, self.origin);
  } else {
    play_sound_at_pos("door_slide_open", self.origin);
  }
  scale = 1;
  if(!open) {
    scale = -1;
  }
  switch (self.script_string) {
    case "rotate":
      if(isDefined(self.script_angles)) {
        self RotateTo(self.script_angles, time, 0, 0);
        self thread door_solid_thread();
      }
      wait(randomfloat(.15));
      break;
    case "move":
    case "slide_apart":
      if(isDefined(self.script_vector)) {
        vector = vector_scale(self.script_vector, scale);
        if(time >= 0.5) {
          self moveTo(self.origin + vector, time, time * 0.25, time * 0.25);
        } else {
          self moveTo(self.origin + vector, time);
        }
        self thread door_solid_thread();
        if(!open) {
          self thread disconnect_paths_when_done();
        }
      }
      wait(randomfloat(.15));
      break;
    case "anim":
      self[[level.blocker_anim_func]](self.script_animname);
      self thread door_solid_thread_anim();
      wait(randomfloat(.15));
      break;
    case "physics":
      self thread physics_launch_door(self);
      wait(0.10);
      break;
  }
}

door_think() {
  self endon("kill_door_think");
  cost = 1000;
  if(isDefined(self.zombie_cost)) {
    cost = self.zombie_cost;
  }
  while(1) {
    switch (self.script_noteworthy) {
      case "electric_door":
        flag_wait("power_on");
        break;
      case "electric_buyable_door":
        flag_wait("power_on");
        self set_hint_string(self, "default_buy_door_" + cost);
        if(!self door_buy()) {
          continue;
        }
        break;
      case "delay_door":
        if(!self door_buy()) {
          continue;
        }
        self door_delay(cost);
        break;
      case "kill_counter_door":
        if(!self door_buy()) {
          continue;
        }
        self door_kill_counter();
        break;
      default:
        if(!self door_buy()) {
          continue;
        }
        break;
    }
    self door_opened();
    break;
  }
  self._door_open = true;
  self notify("door_opened");
}

door_opened() {
  if(isDefined(self.script_flag)) {
    tokens = Strtok(self.script_flag, ",");
    for(i = 0; i < tokens.size; i++) {
      flag_set(tokens[i]);
    }
  }
  for(i = 0; i < self.doors.size; i++) {
    self.doors[i] door_activate();
  }
  if(self.doors.size) {
    play_sound_at_pos("purchase", self.doors[0].origin);
  }
  all_trigs = getEntArray(self.target, "target");
  for(i = 0; i < all_trigs.size; i++) {
    all_trigs[i] trigger_off();
  }
}

physics_launch_door(door_trig) {
  vec = vector_scale(VectorNormalize(self.script_vector), 5);
  self moveTo(self.origin + vec, 0.1);
  self waittill("movedone");
  self PhysicsLaunch(self.origin, self.script_vector * 10);
  wait(0.1);
  PhysicsExplosionSphere(vector_scale(vec, -1), 120, 1, 100);
  wait(60);
  self delete();
}

door_solid_thread() {
  self waittill_either("rotatedone", "movedone");
  self.door_moving = undefined;
  while(1) {
    players = get_players();
    player_touching = false;
    for(i = 0; i < players.size; i++) {
      if(players[i] IsTouching(self)) {
        player_touching = true;
        break;
      }
    }
    if(!player_touching) {
      self Solid();
      return;
    }
    wait(1);
  }
}

door_solid_thread_anim() {
  self waittillmatch("door_anim", "end");
  self.door_moving = undefined;
  while(1) {
    players = get_players();
    player_touching = false;
    for(i = 0; i < players.size; i++) {
      if(players[i] IsTouching(self)) {
        player_touching = true;
        break;
      }
    }
    if(!player_touching) {
      self Solid();
      return;
    }
    wait(1);
  }
}

disconnect_paths_when_done() {
  self waittill_either("rotatedone", "movedone");
  self DisconnectPaths();
}

debris_init() {
  cost = 1000;
  if(isDefined(self.zombie_cost)) {
    cost = self.zombie_cost;
  }
  self set_hint_string(self, "default_buy_debris_" + cost);
  self setCursorHint("HINT_NOICON");
  if(isDefined(self.script_flag) && !isDefined(level.flag[self.script_flag])) {
    flag_init(self.script_flag);
  }
  self thread debris_think();
}

debris_think() {
  if(isDefined(level.custom_debris_function)) {
    self[[level.custom_debris_function]]();
  }
  while(1) {
    self waittill("trigger", who, force);
    if(GetDvarInt(#"zombie_unlock_all") > 0 || is_true(force)) {} else {
      if(!who UseButtonPressed()) {
        continue;
      }
      if(who in_revive_trigger()) {
        continue;
      }
    }
    if(is_player_valid(who)) {
      players = get_players();
      if(GetDvarInt(#"zombie_unlock_all") > 0) {} else if(players.size == 1 && who.score >= self.zombie_cost) {
        who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);
      } else if(level.team_pool[who.team_num].score >= self.zombie_cost) {
        who maps\_zombiemode_score::minus_to_team_score(self.zombie_cost);
      } else if(level.team_pool[who.team_num].score + who.score >= self.zombie_cost) {
        team_points = level.team_pool[who.team_num].score;
        who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost - team_points);
        who maps\_zombiemode_score::minus_to_team_score(team_points);
      } else {
        play_sound_at_pos("no_purchase", self.origin);
        who maps\_zombiemode_audio::create_and_play_dialog("general", "door_deny", undefined, 1);
        continue;
      }
      bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type door", who.playername, who.score, level.team_pool[who.team_num].score, level.round_number, self.zombie_cost, self.script_flag, self.origin);
      junk = getEntArray(self.target, "targetname");
      if(isDefined(self.script_flag)) {
        tokens = Strtok(self.script_flag, ",");
        for(i = 0; i < tokens.size; i++) {
          flag_set(tokens[i]);
        }
      }
      play_sound_at_pos("purchase", self.origin);
      level notify("junk purchased");
      move_ent = undefined;
      clip = undefined;
      for(i = 0; i < junk.size; i++) {
        junk[i] connectpaths();
        if(isDefined(junk[i].script_noteworthy)) {
          if(junk[i].script_noteworthy == "clip") {
            clip = junk[i];
            continue;
          }
        }
        struct = undefined;
        if(isDefined(junk[i].script_linkTo)) {
          struct = getstruct(junk[i].script_linkTo, "script_linkname");
          if(isDefined(struct)) {
            move_ent = junk[i];
            junk[i] thread debris_move(struct);
          } else {
            junk[i] Delete();
          }
        } else {
          junk[i] Delete();
        }
      }
      all_trigs = getEntArray(self.target, "target");
      for(i = 0; i < all_trigs.size; i++) {
        all_trigs[i] delete();
      }
      if(isDefined(clip)) {
        if(isDefined(move_ent)) {
          move_ent waittill("movedone");
        }
        clip Delete();
      }
      break;
    }
  }
}

debris_move(struct) {
  self script_delay();
  self notsolid();
  self play_sound_on_ent("debris_move");
  playsoundatposition("zmb_lightning_l", self.origin);
  if(isDefined(self.script_firefx)) {
    playFX(level._effect[self.script_firefx], self.origin);
  }
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "jiggle") {
      num = RandomIntRange(3, 5);
      og_angles = self.angles;
      for(i = 0; i < num; i++) {
        angles = og_angles + (-5 + RandomFloat(10), -5 + RandomFloat(10), -5 + RandomFloat(10));
        time = RandomFloatRange(0.1, 0.4);
        self Rotateto(angles, time);
        wait(time - 0.05);
      }
    }
  }
  time = 0.5;
  if(isDefined(self.script_transition_time)) {
    time = self.script_transition_time;
  }
  self moveTo(struct.origin, time, time * 0.5);
  self RotateTo(struct.angles, time * 0.75);
  self waittill("movedone");
  if(isDefined(self.script_fxid)) {
    playFX(level._effect[self.script_fxid], self.origin);
    playsoundatposition("zmb_zombie_spawn", self.origin);
  }
  self Delete();
}

blocker_init() {
  if(!isDefined(self.target)) {
    return;
  }
  targets = getEntArray(self.target, "targetname");
  self.barrier_chunks = [];
  use_boards = true;
  if(level.mutators["mutator_noBoards"]) {
    use_boards = false;
  }
  for(j = 0; j < targets.size; j++) {
    if(isDefined(targets[j].script_noteworthy)) {
      if(targets[j].script_noteworthy == "clip") {
        self.clip = targets[j];
        continue;
      }
    }
    if(isDefined(targets[j].script_string) && targets[j].script_string == "rock") {
      targets[j].material = "rock";
    }
    if(isDefined(targets[j].script_parameters)) {
      if(targets[j].script_parameters == "grate") {
        if(isDefined(targets[j].script_noteworthy)) {
          if(targets[j].script_noteworthy == "2" || targets[j].script_noteworthy == "3" || targets[j].script_noteworthy == "4" || targets[j].script_noteworthy == "5" || targets[j].script_noteworthy == "6") {
            targets[j] hide();
          }
        }
      } else if(targets[j].script_parameters == "repair_board") {
        targets[j].unbroken_section = getEnt(targets[j].target, "targetname");
        if(isDefined(targets[j].unbroken_section)) {
          targets[j].unbroken_section LinkTo(targets[j]);
          targets[j] hide();
          targets[j] notSolid();
          targets[j].unbroken = true;
          if(isDefined(targets[j].unbroken_section.script_noteworthy) && targets[j].unbroken_section.script_noteworthy == "glass") {
            targets[j].material = "glass";
            targets[j] thread destructible_glass_barricade(targets[j].unbroken_section, self);
          } else if(isDefined(targets[j].unbroken_section.script_noteworthy) && targets[j].unbroken_section.script_noteworthy == "metal") {
            targets[j].material = "metal";
          }
        }
      } else if(targets[j].script_parameters == "barricade_vents") {
        targets[j].material = "metal_vent";
      }
    }
    if(isDefined(targets[j].targetname)) {
      if(targets[j].targetname == "auto2") {}
    }
    if(use_boards) {
      targets[j] update_states("repaired");
      targets[j].destroyed = false;
    } else {
      targets[j] update_states("destroyed");
      targets[j].destroyed = true;
      targets[j] hide();
      targets[j] notSolid();
    }
    targets[j].claimed = false;
    targets[j].anim_grate_index = 0;
    targets[j].og_origin = targets[j].origin;
    targets[j].og_angles = targets[j].angles;
    self.barrier_chunks[self.barrier_chunks.size] = targets[j];
    self blocker_attack_spots();
  }
  if(use_boards) {
    assert(isDefined(self.clip));
    self.trigger_location = getstruct(self.target, "targetname");
    self thread blocker_think();
  }
}

destructible_glass_barricade(unbroken_section, node) {
  unbroken_section setCanDamage(true);
  unbroken_section.health = 99999;
  unbroken_section waittill("damage", amount, who);
  if(is_player_valid(who) || who maps\_laststand::player_is_in_laststand()) {
    self thread maps\_zombiemode_spawner::zombie_boardtear_offset_fx_horizontle(self, node);
    level thread remove_chunk(self, node, true);
    self update_states("destroyed");
    self notify("destroyed");
    self.unbroken = false;
  }
}

blocker_attack_spots() {
  chunk = getClosest(self.origin, self.barrier_chunks);
  dist = Distance2d(self.origin, chunk.origin) - 36;
  spots = [];
  spots[0] = groundpos(self.origin + (anglesToForward(self.angles) * dist) + (0, 0, 60));
  spots[spots.size] = groundpos(spots[0] + (AnglesToRight(self.angles) * 28) + (0, 0, 60));
  spots[spots.size] = groundpos(spots[0] + (AnglesToRight(self.angles) * -28) + (0, 0, 60));
  taken = [];
  for(i = 0; i < spots.size; i++) {
    taken[i] = false;
  }
  self.attack_spots_taken = taken;
  self.attack_spots = spots;
  self thread debug_attack_spots_taken();
}

blocker_choke() {
  level._blocker_choke = 0;
  while(1) {
    wait(0.05);
    level._blocker_choke = 0;
  }
}

blocker_think() {
  if(!isDefined(level._blocker_choke)) {
    level thread blocker_choke();
  }
  use_choke = false;
  if(isDefined(level._use_choke_blockers) && level._use_choke_blockers == 1) {
    use_choke = true;
  }
  while(1) {
    wait(0.5);
    if(use_choke) {
      if(level._blocker_choke > 3) {
        wait(0.05);
      }
    }
    level._blocker_choke++;
    if(all_chunks_intact(self.barrier_chunks)) {
      continue;
    }
    if(no_valid_repairable_boards(self.barrier_chunks)) {
      continue;
    }
    self blocker_trigger_think();
  }
}

blocker_trigger_think() {
  cost = 10;
  if(isDefined(self.zombie_cost)) {
    cost = self.zombie_cost;
  }
  original_cost = cost;
  radius = 96;
  height = 96;
  if(isDefined(self.trigger_location)) {
    trigger_location = self.trigger_location;
  } else {
    trigger_location = self;
  }
  if(isDefined(trigger_location.radius)) {
    radius = trigger_location.radius;
  }
  if(isDefined(trigger_location.height)) {
    height = trigger_location.height;
  }
  trigger_pos = groundpos(trigger_location.origin) + (0, 0, 4);
  trigger = spawn("trigger_radius", trigger_pos, 0, radius, height);
  trigger thread trigger_delete_on_repair();
  if(isDefined(level._zombiemode_blocker_trigger_extra_thread)) {
    trigger thread[[level._zombiemode_blocker_trigger_extra_thread]]();
  }
  trigger set_hint_string(self, "default_reward_barrier_piece");
  trigger SetCursorHint("HINT_NOICON");
  while(1) {
    trigger waittill("trigger", player);
    if(player hasperk("specialty_fastreload")) {
      has_perk = "specialty_fastreload";
    } else {
      has_perk = undefined;
    }
    if(all_chunks_intact(self.barrier_chunks)) {
      trigger notify("all_boards_repaired");
      return;
    }
    if(no_valid_repairable_boards(self.barrier_chunks)) {
      trigger notify("no valid boards");
      return;
    }
    players = GetPlayers();
    while(1) {
      if(!player IsTouching(trigger)) {
        break;
      }
      if(!is_player_valid(player)) {
        break;
      }
      if(player in_revive_trigger()) {
        break;
      }
      if(players.size == 1 && isDefined(players[0].intermission) && players[0].intermission == 1) {
        break;
      }
      if(player hacker_active()) {
        break;
      }
      if(!player use_button_held()) {
        break;
      }
      chunk = get_random_destroyed_chunk(self.barrier_chunks);
      if(isDefined(chunk.script_parameter) && chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
        if(isDefined(chunk.unbroken_section)) {
          chunk Show();
          chunk Solid();
          chunk.unbroken_section self_delete();
        }
      } else {
        chunk Show();
      }
      if(!isDefined(chunk.script_parameters) || chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
        if(!is_true(level.use_clientside_board_fx)) {
          if(!isDefined(chunk.material) || (isDefined(chunk.material) && chunk.material != "rock")) {
            chunk play_sound_on_ent("rebuild_barrier_piece");
          }
          playsoundatposition("zmb_cha_ching", (0, 0, 0));
        }
      }
      if(chunk.script_parameters == "bar") {
        chunk play_sound_on_ent("rebuild_barrier_piece");
        playsoundatposition("zmb_cha_ching", (0, 0, 0));
      }
      if(isDefined(chunk.script_parameters)) {
        if(chunk.script_parameters == "bar") {
          if(isDefined(chunk.script_noteworthy)) {
            if(chunk.script_noteworthy == "5") {
              chunk hide();
            } else if(chunk.script_noteworthy == "3") {
              chunk hide();
            }
          }
        }
      }
      self thread replace_chunk(chunk, has_perk);
      assert(isDefined(self.clip));
      self.clip enable_trigger();
      self.clip DisconnectPaths();
      bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type repair", player.playername, player.score, level.team_pool[player.team_num].score, level.round_number, original_cost, self.target, self.origin);
      if(!self script_delay()) {
        wait(1);
      }
      if(!is_player_valid(player)) {
        break;
      }
      player.rebuild_barrier_reward += cost;
      if(player.rebuild_barrier_reward < level.zombie_vars["rebuild_barrier_cap_per_round"]) {
        player maps\_zombiemode_score::player_add_points("rebuild_board", cost);
        player play_sound_on_ent("purchase");
      }
      if(isDefined(player.board_repair)) {
        player.board_repair += 1;
      }
      if(all_chunks_intact(self.barrier_chunks)) {
        trigger notify("all_boards_repaired");
        return;
      }
      if(no_valid_repairable_boards(self.barrier_chunks)) {
        trigger notify("no valid boards");
        return;
      }
    }
  }
}

random_destroyed_chunk_show() {
  wait(0.5);
  self Show();
}

door_repaired_rumble_n_sound() {
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    if(distance(players[i].origin, self.origin) < 150) {
      if(isalive(players[i])) {
        players[i] thread board_completion();
      }
    }
  }
}

board_completion() {
  self endon("disconnect");
}

trigger_delete_on_repair() {
  while(isDefined(self)) {
    self waittill_either("all_boards_repaired", "no valid boards");
    self thread door_repaired_rumble_n_sound();
    self delete();
    break;
  }
}

blocker_doubler_hint(hint, original_cost) {
  self endon("death");
  doubler_status = level.zombie_vars["zombie_powerup_point_doubler_on"];
  while(1) {
    wait(0.5);
    if(doubler_status != level.zombie_vars["zombie_powerup_point_doubler_on"]) {
      doubler_status = level.zombie_vars["zombie_powerup_point_doubler_on"];
      cost = original_cost;
      if(level.zombie_vars["zombie_powerup_point_doubler_on"]) {
        cost = original_cost * 2;
      }
      self set_hint_string(self, hint + cost);
    }
  }
}

rebuild_barrier_reward_reset() {
  self.rebuild_barrier_reward = 0;
}

remove_chunk(chunk, node, destroy_immediately, zomb) {
  chunk update_states("mid_tear");
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
      chunk thread zombie_boardtear_audio_offset(chunk);
    }
  }
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "bar") {
      chunk thread zombie_bartear_audio_offset(chunk);
    }
  }
  chunk NotSolid();
  fx = "wood_chunk_destory";
  if(isDefined(self.script_fxid)) {
    fx = self.script_fxid;
  }
  if(isDefined(chunk.script_moveoverride) && chunk.script_moveoverride) {
    chunk hide();
  }
  if(isDefined(chunk.script_parameters) && (chunk.script_parameters == "bar")) {
    if(isDefined(chunk.script_noteworthy) && (chunk.script_noteworthy == "4")) {
      ent = spawn("script_origin", chunk.origin);
      ent.angles = node.angles + (0, 180, 0);
      dist = 100;
      if(isDefined(chunk.script_move_dist)) {
        dist_max = chunk.script_move_dist - 100;
        dist = 100 + randomInt(dist_max);
      } else {
        dist = 100 + randomInt(100);
      }
      dest = ent.origin + (anglesToForward(ent.angles) * dist);
      trace = bulletTrace(dest + (0, 0, 16), dest + (0, 0, -200), false, undefined);
      if(trace["fraction"] == 1) {
        dest = dest + (0, 0, -200);
      } else {
        dest = trace["position"];
      }
      chunk LinkTo(ent);
      time = ent fake_physicslaunch(dest, 300 + randomInt(100));
      if(randomInt(100) > 40) {
        ent rotatePitch(180, time * 0.5);
      } else {
        ent rotatePitch(90, time, time * 0.5);
      }
      wait(time);
      chunk hide();
      wait(0.1);
      ent Delete();
    } else {
      ent = spawn("script_origin", chunk.origin);
      ent.angles = node.angles + (0, 180, 0);
      dist = 100;
      if(isDefined(chunk.script_move_dist)) {
        dist_max = chunk.script_move_dist - 100;
        dist = 100 + randomInt(dist_max);
      } else {
        dist = 100 + randomInt(100);
      }
      dest = ent.origin + (anglesToForward(ent.angles) * dist);
      trace = bulletTrace(dest + (0, 0, 16), dest + (0, 0, -200), false, undefined);
      if(trace["fraction"] == 1) {
        dest = dest + (0, 0, -200);
      } else {
        dest = trace["position"];
      }
      chunk LinkTo(ent);
      time = ent fake_physicslaunch(dest, 260 + randomInt(100));
      if(randomInt(100) > 40) {
        ent rotatePitch(180, time * 0.5);
      } else {
        ent rotatePitch(90, time, time * 0.5);
      }
      wait(time);
      chunk hide();
      wait(0.1);
      ent Delete();
    }
    chunk update_states("destroyed");
    chunk notify("destroyed");
  }
  if(isDefined(chunk.script_parameters) && chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
    ent = spawn("script_origin", chunk.origin);
    ent.angles = node.angles + (0, 180, 0);
    dist = 100;
    if(isDefined(chunk.script_move_dist)) {
      dist_max = chunk.script_move_dist - 100;
      dist = 100 + randomInt(dist_max);
    } else {
      dist = 100 + randomInt(100);
    }
    dest = ent.origin + (anglesToForward(ent.angles) * dist);
    trace = bulletTrace(dest + (0, 0, 16), dest + (0, 0, -200), false, undefined);
    if(trace["fraction"] == 1) {
      dest = dest + (0, 0, -200);
    } else {
      dest = trace["position"];
    }
    chunk LinkTo(ent);
    time = ent fake_physicslaunch(dest, 200 + randomInt(100));
    if(isDefined(chunk.unbroken_section)) {
      if(!isDefined(chunk.material) || chunk.material != "metal") {
        chunk.unbroken_section self_delete();
      }
    }
    if(randomInt(100) > 40) {
      ent rotatePitch(180, time * 0.5);
    } else {
      ent rotatePitch(90, time, time * 0.5);
    }
    wait(time);
    if(isDefined(chunk.unbroken_section)) {
      if(isDefined(chunk.material) && chunk.material == "metal") {
        chunk.unbroken_section self_delete();
      }
    }
    chunk hide();
    wait(0.1);
    ent Delete();
    chunk update_states("destroyed");
    chunk notify("destroyed");
  }
  if(isDefined(chunk.script_parameters) && (chunk.script_parameters == "grate")) {
    if(isDefined(chunk.script_noteworthy) && (chunk.script_noteworthy == "6")) {
      ent = spawn("script_origin", chunk.origin);
      ent.angles = node.angles + (0, 180, 0);
      dist = 100 + randomInt(100);
      dest = ent.origin + (anglesToForward(ent.angles) * dist);
      trace = bulletTrace(dest + (0, 0, 16), dest + (0, 0, -200), false, undefined);
      if(trace["fraction"] == 1) {
        dest = dest + (0, 0, -200);
      } else {
        dest = trace["position"];
      }
      chunk LinkTo(ent);
      time = ent fake_physicslaunch(dest, 200 + randomInt(100));
      if(randomInt(100) > 40) {
        ent rotatePitch(180, time * 0.5);
      } else {
        ent rotatePitch(90, time, time * 0.5);
      }
      wait(time);
      chunk hide();
      ent Delete();
      chunk update_states("destroyed");
      chunk notify("destroyed");
    } else {
      chunk hide();
      chunk update_states("destroyed");
      chunk notify("destroyed");
    }
  }
}

remove_chunk_rotate_grate(chunk) {
  if(isDefined(chunk.script_parameters) && chunk.script_parameters == "grate") {
    chunk vibrate((0, 270, 0), 0.2, 0.4, 0.4);
    return;
  }
}

zombie_boardtear_audio_offset(chunk) {
  if(isDefined(chunk.material) && !isDefined(chunk.already_broken))
    chunk.already_broken = false;
  if(isDefined(chunk.material) && chunk.material == "glass" && chunk.already_broken == false) {
    chunk playSound("zmb_break_glass_barrier");
    wait(randomfloat(0.3, 0.6));
    chunk playSound("zmb_break_glass_barrier");
    chunk.already_broken = true;
  } else if(isDefined(chunk.material) && chunk.material == "metal" && chunk.already_broken == false) {
    chunk playSound("grab_metal_bar");
    wait(randomfloat(0.3, 0.6));
    chunk playSound("break_metal_bar");
    chunk.already_broken = true;
  } else if(isDefined(chunk.material) && chunk.material == "rock") {
    if(!is_true(level.use_clientside_rock_tearin_fx)) {
      chunk playSound("zmb_break_rock_barrier");
      wait(randomfloat(0.3, 0.6));
      chunk playSound("zmb_break_rock_barrier");
    }
    chunk.already_broken = true;
  } else if(isDefined(chunk.material) && chunk.material == "metal_vent") {
    if(!is_true(level.use_clientside_board_fx)) {
      chunk playSound("evt_vent_slat_remove");
    }
  } else {
    if(!is_true(level.use_clientside_board_fx)) {
      chunk play_sound_on_ent("break_barrier_piece");
      wait(randomfloat(0.3, 0.6));
      chunk play_sound_on_ent("break_barrier_piece");
    }
    chunk.already_broken = true;
  }
}

zombie_bartear_audio_offset(chunk) {
  chunk play_sound_on_ent("grab_metal_bar");
  wait(randomfloat(0.3, 0.6));
  chunk play_sound_on_ent("break_metal_bar");
  wait(randomfloat(1.0, 1.3));
  chunk play_sound_on_ent("drop_metal_bar");
}

ensure_chunk_is_back_to_origin(chunk) {
  if(chunk.origin != chunk.og_origin) {
    chunk notsolid();
    chunk waittill("movedone");
  }
}

replace_chunk(chunk, perk, via_powerup) {
  chunk update_states("mid_repair");
  assert(isDefined(chunk.og_origin));
  assert(isDefined(chunk.og_angles));
  has_perk = false;
  if(isDefined(perk)) {
    has_perk = true;
  }
  sound = "rebuild_barrier_hover";
  if(isDefined(chunk.script_presound)) {
    sound = chunk.script_presound;
  }
  if(!isDefined(via_powerup)) {
    play_sound_at_pos(sound, chunk.origin);
  }
  only_z = (chunk.origin[0], chunk.origin[1], chunk.og_origin[2]);
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "board") {
      chunk Show();
      if(has_perk) {
        if("specialty_fastreload" == perk) {
          chunk RotateTo(chunk.og_angles, 0.15);
          chunk waittill_notify_or_timeout("rotatedone", 1);
          wait(0.1);
        } else if("specialty_fastreload_upgrade" == perk) {
          chunk RotateTo(chunk.og_angles, 0.08);
          chunk waittill_notify_or_timeout("rotatedone", 1);
          wait(0.1);
        }
      } else {
        chunk RotateTo(chunk.angles + (0, -9, 0), 0.1);
        chunk waittill("rotatedone");
        chunk RotateTo(chunk.angles + (0, 18, 0), 0.1);
        chunk waittill("rotatedone");
        chunk moveTo(only_z, 0.15);
        chunk RotateTo(chunk.og_angles, 0.3);
        chunk waittill_notify_or_timeout("rotatedone", 1);
        wait(0.2);
      }
    } else if(chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
      if(isDefined(chunk.unbroken_section)) {
        chunk.unbroken_section self_delete();
        chunk Show();
      } else {
        chunk Show();
      }
      if(has_perk) {
        if("specialty_fastreload" == perk) {
          chunk RotateTo(chunk.og_angles, 0.15);
          chunk waittill_notify_or_timeout("rotatedone", 1);
          wait(0.1);
        } else if("specialty_fastreload_upgrade" == perk) {
          chunk RotateTo(chunk.og_angles, 0.08);
          chunk waittill_notify_or_timeout("rotatedone", 1);
          wait(0.1);
        }
      } else {
        chunk RotateTo(chunk.angles + (0, -9, 0), 0.1);
        chunk waittill("rotatedone");
        chunk RotateTo(chunk.angles + (0, 18, 0), 0.1);
        chunk waittill("rotatedone");
        chunk moveTo(only_z, 0.15);
        chunk RotateTo(chunk.og_angles, 0.3);
        chunk waittill_notify_or_timeout("rotatedone", 1);
        wait(0.2);
      }
    }
    if(isDefined(chunk.script_parameters)) {
      if(chunk.script_parameters == "bar") {
        chunk Show();
        if(has_perk) {
          if("specialty_fastreload" == perk) {
            chunk RotateTo(chunk.og_angles, 0.15);
            chunk waittill_notify_or_timeout("rotatedone", 1);
            wait(0.1);
          } else if("specialty_fastreload_upgrade" == perk) {
            chunk RotateTo(chunk.og_angles, 0.08);
            chunk waittill_notify_or_timeout("rotatedone", 1);
            wait(0.1);
          }
        }
        if(chunk.script_noteworthy == "3" || chunk.script_noteworthy == "5") {}
        chunk RotateTo(chunk.angles + (0, -9, 0), 0.1);
        chunk waittill("rotatedone");
        chunk RotateTo(chunk.angles + (0, 18, 0), 0.1);
        chunk waittill("rotatedone");
        chunk moveTo(only_z, 0.15);
        chunk RotateTo(chunk.og_angles, 0.3);
        chunk waittill_notify_or_timeout("rotatedone", 1);
        wait(0.2);
      }
    }
  }
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
      if(has_perk) {
        if("specialty_fastreload" == perk) {
          chunk moveTo(chunk.og_origin, 0.05);
          chunk waittill_notify_or_timeout("movedone", 1);
          ensure_chunk_is_back_to_origin(chunk);
        } else if("specialty_fastreload_upgrade" == perk) {
          chunk moveTo(chunk.og_origin, 0.03);
          chunk waittill_notify_or_timeout("movedone", 1);
          ensure_chunk_is_back_to_origin(chunk);
        }
      } else {
        chunk RotateTo(chunk.angles + (0, -9, 0), 0.1);
        chunk waittill("rotatedone");
        chunk RotateTo(chunk.angles + (0, 18, 0), 0.1);
        chunk waittill("rotatedone");
        chunk RotateTo(chunk.og_angles, 0.1);
        chunk waittill_notify_or_timeout("RotateTo", 0.1);
        chunk moveTo(chunk.og_origin, 0.1);
        chunk waittill_notify_or_timeout("movedone", 1);
        ensure_chunk_is_back_to_origin(chunk);
      }
    }
  }
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "bar") {
      if(has_perk) {
        if("specialty_fastreload" == perk) {
          chunk Show();
          chunk moveTo(chunk.og_origin, 0.05);
          chunk waittill_notify_or_timeout("movedone", 1);
          ensure_chunk_is_back_to_origin(chunk);
        } else if("specialty_fastreload_upgrade" == perk) {
          chunk Show();
          chunk moveTo(chunk.og_origin, 0.03);
          chunk waittill_notify_or_timeout("movedone", 1);
          ensure_chunk_is_back_to_origin(chunk);
        }
      } else if(chunk.script_noteworthy == "3") {
        chunk RotateTo(chunk.angles + (0, -9, 0), 0.1);
        chunk waittill("rotatedone");
        chunk RotateTo(chunk.angles + (0, 18, 0), 0.1);
        chunk waittill("rotatedone");
        chunk RotateTo(chunk.og_angles, 0.1);
        chunk moveTo(chunk.og_origin, 0.1);
        chunk waittill_notify_or_timeout("movedone", 1);
        ensure_chunk_is_back_to_origin(chunk);
        chunk Show();
      } else if(chunk.script_noteworthy == "5") {
        chunk RotateTo(chunk.angles + (0, -9, 0), 0.1);
        chunk waittill("rotatedone");
        chunk RotateTo(chunk.angles + (0, 18, 0), 0.1);
        chunk waittill("rotatedone");
        chunk RotateTo(chunk.og_angles, 0.1);
        chunk moveTo(chunk.og_origin, 0.1);
        chunk waittill_notify_or_timeout("movedone", 1);
        ensure_chunk_is_back_to_origin(chunk);
        chunk Show();
      } else {
        chunk Show();
        chunk RotateTo(chunk.angles + (0, -9, 0), 0.1);
        chunk waittill("rotatedone");
        chunk RotateTo(chunk.angles + (0, 18, 0), 0.1);
        chunk waittill("rotatedone");
        chunk RotateTo(chunk.og_angles, 0.1);
        chunk moveTo(chunk.og_origin, 0.1);
        chunk waittill_notify_or_timeout("movedone", 1);
        ensure_chunk_is_back_to_origin(chunk);
      }
    }
  }
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "grate") {
      if(isDefined(chunk.script_noteworthy) && (chunk.script_noteworthy == "6")) {
        amplitude1 = RandomfloatRange(10, 15);
        period1 = RandomfloatRange(0.3, 0.5);
        time1 = RandomfloatRange(0.3, 0.4);
        chunk vibrate((0, 180, 0), amplitude1, period1, time1);
        wait(0.3);
        chunk RotateTo(chunk.og_angles, 0.1);
        chunk moveTo(chunk.og_origin, 0.1);
        chunk waittill_notify_or_timeout("movedone", 1);
        ensure_chunk_is_back_to_origin(chunk);
        chunk thread zombie_gratetear_audio_plus_fx_offset_repair_horizontal(chunk);
        chunk Show();
      } else {
        wait(0.5);
        chunk waittill_notify_or_timeout("movedone", 1);
        chunk thread zombie_gratetear_audio_plus_fx_offset_repair_horizontal(chunk);
        chunk Show();
      }
    }
  }
  sound = "barrier_rebuild_slam";
  if(isDefined(self.script_ender)) {
    sound = self.script_ender;
  }
  if(isDefined(chunk.script_string) && chunk.script_string == "rock") {
    sound = "zmb_rock_fix";
  }
  if(isDefined(chunk.script_parameters) && chunk.script_parameters == "barricade_vents") {
    sound = "zmb_vent_fix";
  }
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
      if(chunk.script_noteworthy == "1" || chunk.script_noteworthy == "5" || chunk.script_noteworthy == "6") {
        chunk thread zombie_boardtear_audio_plus_fx_offset_repair_horizontal(chunk);
      } else {
        chunk thread zombie_boardtear_audio_plus_fx_offset_repair_verticle(chunk);
      }
    }
  }
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "bar") {
      if(chunk.script_noteworthy == "4" || chunk.script_noteworthy == "6") {
        if(isDefined(chunk.script_squadname) && (chunk.script_squadname == "cosmodrome_storage_area")) {}
        if(!isDefined(chunk.script_squadname)) {
          chunk thread zombie_bartear_audio_plus_fx_offset_repair_horizontal(chunk);
        }
      } else {
        if(isDefined(chunk.script_squadname) && (chunk.script_squadname == "cosmodrome_storage_area")) {}
        if(!isDefined(chunk.script_squadname)) {
          chunk thread zombie_bartear_audio_plus_fx_offset_repair_verticle(chunk);
        }
      }
    }
  }
  chunk Solid();
  chunk update_states("repaired");
  fx = "wood_chunk_destory";
  if(isDefined(self.script_fxid)) {
    fx = self.script_fxid;
  }
  if(isDefined(chunk.script_string) && chunk.script_string == "rock") {
    if(!is_true(level.use_clientside_rock_tearin_fx)) {
      play_sound_at_pos(sound, chunk.origin);
    }
  } else if(isDefined(chunk.script_parameters) && (chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents")) {
    if(!is_true(level.use_clientside_board_fx)) {
      play_sound_at_pos(sound, chunk.origin);
    }
  } else {
    play_sound_at_pos(sound, chunk.origin);
  }
  if(!isDefined(self.clip)) {
    chunk Disconnectpaths();
  }
}

zombie_boardtear_audio_plus_fx_offset_repair_horizontal(chunk) {
  if(isDefined(chunk.material) && chunk.material == "rock") {
    if(is_true(level.use_clientside_rock_tearin_fx)) {
      chunk clearclientflag(level._ZOMBIE_SCRIPTMOVER_FLAG_ROCK_FX);
    } else {
      EarthQuake(RandomFloatRange(0.3, 0.4), RandomFloatRange(0.2, 0.4), chunk.origin, 150);
      playFX(level._effect["wood_chunk_destory"], chunk.origin + (0, 0, 30));
      wait(randomfloat(0.3, 0.6));
      chunk play_sound_on_ent("break_barrier_piece");
      playFX(level._effect["wood_chunk_destory"], chunk.origin + (0, 0, -30));
    }
  } else {
    if(is_true(level.use_clientside_board_fx)) {
      chunk clearclientflag(level._ZOMBIE_SCRIPTMOVER_FLAG_BOARD_HORIZONTAL_FX);
    } else {
      EarthQuake(RandomFloatRange(0.3, 0.4), RandomFloatRange(0.2, 0.4), chunk.origin, 150);
      playFX(level._effect["wood_chunk_destory"], chunk.origin + (0, 0, 30));
      wait(randomfloat(0.3, 0.6));
      chunk play_sound_on_ent("break_barrier_piece");
      playFX(level._effect["wood_chunk_destory"], chunk.origin + (0, 0, -30));
    }
  }
}

zombie_boardtear_audio_plus_fx_offset_repair_verticle(chunk) {
  if(isDefined(chunk.material) && chunk.material == "rock") {
    if(is_true(level.use_clientside_rock_tearin_fx)) {
      chunk clearclientflag(level._ZOMBIE_SCRIPTMOVER_FLAG_ROCK_FX);
    } else {
      EarthQuake(RandomFloatRange(0.3, 0.4), RandomFloatRange(0.2, 0.4), chunk.origin, 150);
      playFX(level._effect["wood_chunk_destory"], chunk.origin + (30, 0, 0));
      wait(randomfloat(0.3, 0.6));
      chunk play_sound_on_ent("break_barrier_piece");
      playFX(level._effect["wood_chunk_destory"], chunk.origin + (-30, 0, 0));
    }
  } else {
    if(is_true(level.use_clientside_board_fx)) {
      chunk clearclientflag(level._ZOMBIE_SCRIPTMOVER_FLAG_BOARD_VERTICAL_FX);
    } else {
      EarthQuake(RandomFloatRange(0.3, 0.4), RandomFloatRange(0.2, 0.4), chunk.origin, 150);
      playFX(level._effect["wood_chunk_destory"], chunk.origin + (30, 0, 0));
      wait(randomfloat(0.3, 0.6));
      chunk play_sound_on_ent("break_barrier_piece");
      playFX(level._effect["wood_chunk_destory"], chunk.origin + (-30, 0, 0));
    }
  }
}

zombie_gratetear_audio_plus_fx_offset_repair_horizontal(chunk) {
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

zombie_bartear_audio_plus_fx_offset_repair_horizontal(chunk) {
  EarthQuake(RandomFloatRange(0.3, 0.4), RandomFloatRange(0.2, 0.4), chunk.origin, 150);
  chunk play_sound_on_ent("bar_rebuild_slam");
  switch (randomInt(9)) {
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
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_left");
      break;
    case 8:
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
      break;
  }
}

zombie_bartear_audio_plus_fx_offset_repair_verticle(chunk) {
  EarthQuake(RandomFloatRange(0.3, 0.4), RandomFloatRange(0.2, 0.4), chunk.origin, 150);
  chunk play_sound_on_ent("bar_rebuild_slam");
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

add_new_zombie_spawners() {
  if(isDefined(self.target)) {
    self.possible_spawners = getEntArray(self.target, "targetname");
  }
  if(isDefined(self.script_string)) {
    spawners = getEntArray(self.script_string, "targetname");
    self.possible_spawners = array_combine(self.possible_spawners, spawners);
  }
  if(!isDefined(self.possible_spawners)) {
    return;
  }
  zombies_to_add = self.possible_spawners;
  for(i = 0; i < self.possible_spawners.size; i++) {
    self.possible_spawners[i].is_enabled = true;
    add_spawner(self.possible_spawners[i]);
  }
}

flag_blocker() {
  if(!isDefined(self.script_flag_wait)) {
    AssertMsg("Flag Blocker at " + self.origin + " does not have a script_flag_wait key value pair");
    return;
  }
  if(!isDefined(level.flag[self.script_flag_wait])) {
    flag_init(self.script_flag_wait);
  }
  type = "connectpaths";
  if(isDefined(self.script_noteworthy)) {
    type = self.script_noteworthy;
  }
  flag_wait(self.script_flag_wait);
  self script_delay();
  if(type == "connectpaths") {
    self ConnectPaths();
    self disable_trigger();
    return;
  }
  if(type == "disconnectpaths") {
    self DisconnectPaths();
    self disable_trigger();
    return;
  }
  AssertMsg("flag blocker at " + self.origin + ", the type \"" + type + "\" is not recognized");
}

update_states(states) {
  assertex(isDefined(states));
  self.state = states;
}

shutter_init() {
  self.shutters = [];
  self.lights = [];
  self.area_triggers = [];
  targets = getEntArray(self.target, "targetname");
  for(i = 0; i < targets.size; i++) {
    if(isDefined(targets[i].script_string)) {
      self.shutters[self.shutters.size] = targets[i];
    } else if(targets[i].classname == "trigger_multiple") {
      self.area_triggers[self.area_triggers.size] = targets[i];
    } else if(targets[i].classname == "script_model") {
      if(targets[i].model == "zombie_zapper_cagelight") {
        self.lights[self.lights.size] = targets[i];
      } else if(targets[i].model == "zombie_zapper_handle") {
        self.handle = targets[i];
      }
    }
  }
  flag_wait("all_players_connected");
  players = GetPlayers();
  min_size = 4;
  if(isDefined(self.script_int)) {
    min_size = self.script_int;
  }
  if(players.size > min_size) {
    shutter_light_green(self.lights);
    for(i = 0; i < self.shutters.size; i++) {
      if(self.shutters[i].script_string == "anim") {
        AssertEx(isDefined(self.shutters[i].script_animname), "Blocker_init: You must specify a script_animname for " + self.shutters[i].targetname);
        AssertEx(isDefined(level.scr_anim[self.shutters[i].script_animname]), "Blocker_init: You must define a level.scr_anim for script_anim -> " + self.shutters[i].script_animname);
        AssertEx(isDefined(level.blocker_anim_func), "Blocker_init: You must define a level.blocker_anim_func");
      }
      self.shutters[i] door_activate(0.05);
    }
    cost = 1000;
    if(isDefined(self.zombie_cost)) {
      cost = self.zombie_cost;
    }
    self set_hint_string(self, "default_buy_door_" + cost);
    self thread shutter_think();
  } else {
    self disable_trigger();
    self thread shutter_enable_zone(false);
  }
}

shutter_light_red(shutter_lights) {
  for(i = 0; i < shutter_lights.size; i++) {
    shutter_lights[i] setModel("zombie_zapper_cagelight_red");
    if(isDefined(shutter_lights[i].fx)) {
      shutter_lights[i].fx delete();
    }
    shutter_lights[i].fx = maps\_zombiemode_net::network_safe_spawn("trap_light_red", 2, "script_model", shutter_lights[i].origin);
    shutter_lights[i].fx setModel("tag_origin");
    shutter_lights[i].fx.angles = shutter_lights[i].angles + (-90, 0, 0);
    playFXOnTag(level._effect["zapper_light_notready"], shutter_lights[i].fx, "tag_origin");
  }
}

shutter_light_green(shutter_lights) {
  for(i = 0; i < shutter_lights.size; i++) {
    shutter_lights[i] setModel("zombie_zapper_cagelight_green");
    if(isDefined(shutter_lights[i].fx)) {
      shutter_lights[i].fx delete();
    }
    shutter_lights[i].fx = maps\_zombiemode_net::network_safe_spawn("trap_light_green", 2, "script_model", shutter_lights[i].origin);
    shutter_lights[i].fx setModel("tag_origin");
    shutter_lights[i].fx.angles = shutter_lights[i].angles + (-90, 0, 0);
    playFXOnTag(level._effect["zapper_light_ready"], shutter_lights[i].fx, "tag_origin");
  }
}

shutter_move_switch() {
  if(isDefined(self.handle)) {
    self.handle rotatePitch(180, .5);
    self.handle playSound("amb_sparks_l_b");
    self.handle waittill("rotatedone");
    self notify("switch_activated");
    self waittill("available");
    self.handle rotatePitch(-180, .5);
  }
}

shutter_think() {
  while(1) {
    self waittill("trigger", who);
    if(!who UseButtonPressed()) {
      continue;
    }
    if(who in_revive_trigger()) {
      continue;
    }
    if(is_player_valid(who)) {
      players = get_players();
      if(players.size == 1 && who.score >= self.zombie_cost) {
        who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);
      } else if(level.team_pool[who.team_num].score >= self.zombie_cost) {
        who maps\_zombiemode_score::minus_to_team_score(self.zombie_cost);
      } else if(level.team_pool[who.team_num].score + who.score >= self.zombie_cost) {
        team_points = level.team_pool[who.team_num].score;
        who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost - team_points);
        who maps\_zombiemode_score::minus_to_team_score(team_points);
      } else {
        play_sound_at_pos("zmb_no_cha_ching", self.shutters[0].origin);
        who maps\_zombiemode_audio::create_and_play_dialog("general", "door_deny", undefined, 0);
        continue;
      }
      bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type door", who.playername, who.score, level.team_pool[who.team_num].score, level.round_number, self.zombie_cost, self.target, self.origin);
    }
    self disable_trigger();
    self thread shutter_move_switch();
    shutter_light_red(self.lights);
    self waittill("switch_activated");
    for(i = 0; i < self.shutters.size; i++) {
      self.shutters[i] door_activate(undefined, false);
    }
    self thread shutter_enable_zone(false);
    delay = 10;
    if(isDefined(self.script_wait)) {
      delay = self.script_wait;
    }
    wait(delay);
    self notify("available");
    self thread shutter_enable_zone(true);
    for(i = 0; i < self.shutters.size; i++) {
      self.shutters[i] door_activate(undefined, true);
    }
    wait(1);
    shutter_light_green(self.lights);
    self enable_trigger();
  }
}

shutter_enable_zone(set_enable) {
  zkeys = GetArrayKeys(level.zones);
  for(z = 0; z < zkeys.size; z++) {
    zone_name = zkeys[z];
    zone = level.zones[zone_name];
    for(s = 0; s < zone.spawners.size; s++) {
      for(at = 0; at < self.area_triggers.size; at++) {
        if(zone.spawners[s] IsTouching(self.area_triggers[at])) {
          zone.spawners[s].is_enabled = set_enable;
        }
      }
    }
    for(rl = 0; rl < zone.rise_locations.size; rl++) {
      for(at = 0; at < self.area_triggers.size; at++) {
        org = spawn("script_origin", zone.rise_locations[rl].origin);
        if(org IsTouching(self.area_triggers[at])) {
          zone.rise_locations[rl].is_enabled = set_enable;
        }
        org delete();
      }
    }
  }
  if(!set_enable) {
    wait(1.5);
    ai_array = GetAIArray("axis");
    num_to_add = 0;
    for(ai_num = 0; ai_num < ai_array.size; ai_num++) {
      ai = ai_array[ai_num];
      for(i = 0; i < self.area_triggers.size; i++) {
        if(IsAlive(ai) && ai IsTouching(self.area_triggers[i])) {
          ai DoDamage(ai.health, ai.origin);
          num_to_add++;
        }
      }
    }
    level.zombie_total += num_to_add;
  }
}

replace_chunk_instant(chunk) {
  chunk update_states("mid_repair");
  assert(isDefined(chunk.og_origin));
  assert(isDefined(chunk.og_angles));
  if(isDefined(chunk.script_parameters)) {
    chunk Show();
    chunk.origin = chunk.og_origin;
    chunk.angles = chunk.og_angles;
    if(chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
      if(chunk.script_noteworthy == "1" || chunk.script_noteworthy == "4" || chunk.script_noteworthy == "5" || chunk.script_noteworthy == "6") {
        chunk thread zombie_boardtear_audio_plus_fx_offset_repair_horizontal(chunk);
      } else {
        chunk thread zombie_boardtear_audio_plus_fx_offset_repair_verticle(chunk);
      }
    } else if(chunk.script_parameters == "bar") {
      if(chunk.script_noteworthy == "4" || chunk.script_noteworthy == "6") {
        if(isDefined(chunk.script_squadname) && (chunk.script_squadname == "cosmodrome_storage_area")) {}
        if(!isDefined(chunk.script_squadname)) {
          chunk thread zombie_bartear_audio_plus_fx_offset_repair_horizontal(chunk);
        }
      } else {
        if(isDefined(chunk.script_squadname) && (chunk.script_squadname == "cosmodrome_storage_area")) {}
        if(!isDefined(chunk.script_squadname)) {
          chunk thread zombie_bartear_audio_plus_fx_offset_repair_verticle(chunk);
        }
      }
    }
  }
  chunk Solid();
  chunk update_states("repaired");
  if(!isDefined(self.clip)) {
    chunk Disconnectpaths();
  }
}

quantum_bomb_open_nearest_door_validation(position) {
  range_squared = 180 * 180;
  zombie_doors = getEntArray("zombie_door", "targetname");
  for(i = 0; i < zombie_doors.size; i++) {
    if(distanceSquared(zombie_doors[i].origin, position) < range_squared) {
      return true;
    }
  }
  zombie_airlock_doors = getEntArray("zombie_airlock_buy", "targetname");
  for(i = 0; i < zombie_airlock_doors.size; i++) {
    if(distanceSquared(zombie_airlock_doors[i].origin, position) < range_squared) {
      return true;
    }
  }
  zombie_debris = getEntArray("zombie_debris", "targetname");
  for(i = 0; i < zombie_debris.size; i++) {
    if(distanceSquared(zombie_debris[i].origin, position) < range_squared) {
      return true;
    }
  }
  return false;
}

quantum_bomb_open_nearest_door_result(position) {
  range_squared = 180 * 180;
  zombie_doors = getEntArray("zombie_door", "targetname");
  for(i = 0; i < zombie_doors.size; i++) {
    if(distanceSquared(zombie_doors[i].origin, position) < range_squared) {
      self thread maps\_zombiemode_audio::create_and_play_dialog("kill", "quant_good");
      zombie_doors[i] notify("trigger", self, true);
      [[level.quantum_bomb_play_area_effect_func]](position);
      return;
    }
  }
  zombie_airlock_doors = getEntArray("zombie_airlock_buy", "targetname");
  for(i = 0; i < zombie_airlock_doors.size; i++) {
    if(distanceSquared(zombie_airlock_doors[i].origin, position) < range_squared) {
      self thread maps\_zombiemode_audio::create_and_play_dialog("kill", "quant_good");
      zombie_airlock_doors[i] notify("trigger", self, true);
      [[level.quantum_bomb_play_area_effect_func]](position);
      return;
    }
  }
  zombie_debris = getEntArray("zombie_debris", "targetname");
  for(i = 0; i < zombie_debris.size; i++) {
    if(distanceSquared(zombie_debris[i].origin, position) < range_squared) {
      self thread maps\_zombiemode_audio::create_and_play_dialog("kill", "quant_good");
      zombie_debris[i] notify("trigger", self, true);
      [[level.quantum_bomb_play_area_effect_func]](position);
      return;
    }
  }
}