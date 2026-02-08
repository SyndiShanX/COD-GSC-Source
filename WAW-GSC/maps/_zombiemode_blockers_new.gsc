/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_blockers_new.gsc
*********************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#using_animtree("generic_human");

init() {
  init_blockers();
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
}
door_init() {
  self.type = undefined;

  targets = getEntArray(self.target, "targetname");

  if(isDefined(self.script_flag) && !isDefined(level.flag[self.script_flag])) {
    flag_init(self.script_flag);
  }

  for(i = 0; i < targets.size; i++) {
    targets[i] disconnectpaths();
    if(isDefined(targets[i].script_noteworthy) && targets[i].script_noteworthy == "clip") {
      self.clip = targets[i];
      self.script_string = "clip";
    } else if(!isDefined(targets[i].script_string)) {
      if(isDefined(targets[i].script_angles)) {
        targets[i].script_string = "rotate";
      } else if(isDefined(targets[i].script_vector)) {
        targets[i].script_string = "move";
      }
    } else {
      if(targets[i].script_string == "anim") {
        AssertEx(isDefined(targets[i].script_animname), "Blocker_init: You must specify a script_animname for " + targets[i].targetname);
        AssertEx(isDefined(level.scr_anim[targets[i].script_animname]), "Blocker_init: You must define a level.scr_anim for script_anim -> " + targets[i].script_animname);
        AssertEx(isDefined(level.blocker_anim_func), "Blocker_init: You must define a level.blocker_anim_func");
      }
    }
  }
  self.doors = targets;

  cost = 1000;
  if(isDefined(self.zombie_cost)) {
    cost = self.zombie_cost;
  }

  self set_hint_string(self, "default_buy_door_" + cost);
  self SetCursorHint("HINT_NOICON");
  self UseTriggerRequireLookAt();
  self thread door_think();

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "electric_door") {
    self set_door_unusable();
    if(isDefined(level.door_dialog_function)) {
      self thread[[level.door_dialog_function]]();
    }
  }
}

door_think() {
  while(1) {
    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "electric_door") {
      flag_wait("electricity_on");
    } else {
      self waittill("trigger", who);
      if(!who UseButtonPressed()) {
        continue;
      }

      if(who in_revive_trigger()) {
        continue;
      }

      if(is_player_valid(who)) {
        if(who.score >= self.zombie_cost) {
          who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);
          if(isDefined(level.achievement_notify_func)) {
            level[[level.achievement_notify_func]]("DLC3_ZOMBIE_ALL_DOORS");
          }
          bbPrint("zombie_uses: playername %s playerscore %d round %d cost %d name %s x %f y %f z %f type door", who.playername, who.score, level.round_number, self.zombie_cost, self.target, self.origin);
        } else {
          play_sound_at_pos("no_purchase", self.doors[0].origin);

          continue;
        }
      }
    }

    for(i = 0; i < self.doors.size; i++) {
      self.doors[i] NotSolid();
      self.doors[i] connectpaths();

      if(isDefined(self.doors[i].door_moving)) {
        continue;
      }
      self.doors[i].door_moving = 1;

      if((isDefined(self.doors[i].script_noteworthy) && self.doors[i].script_noteworthy == "clip") || (isDefined(self.doors[i].script_string) && self.doors[i].script_string == "clip")) {
        continue;
      }

      if(isDefined(self.doors[i].script_sound)) {
        play_sound_at_pos(self.doors[i].script_sound, self.doors[i].origin);
      } else {
        play_sound_at_pos("door_slide_open", self.doors[i].origin);
      }

      time = 1;
      if(isDefined(self.doors[i].script_transition_time)) {
        time = self.doors[i].script_transition_time;
      }

      switch (self.doors[i].script_string) {
        case "rotate":
          if(isDefined(self.doors[i].script_angles)) {
            self.doors[i] RotateTo(self.doors[i].script_angles, time, 0, 0);
            self.doors[i] thread door_solid_thread();
          }
          wait(randomfloat(.15));
          break;
        case "move":
        case "slide_apart":
          if(isDefined(self.doors[i].script_vector)) {
            self.doors[i] MoveTo(self.doors[i].origin + self.doors[i].script_vector, time, time * 0.25, time * 0.25);
            self.doors[i] thread door_solid_thread();
          }
          wait(randomfloat(.15));
          break;

        case "anim":
          self.doors[i][[level.blocker_anim_func]](self.doors[i].script_animname);
          self.doors[i] thread door_solid_thread_anim();
          wait(randomfloat(.15));
          break;
      }

      if(i == 0) {
        play_sound_at_pos("purchase", self.doors[i].origin);
      }

      if(isDefined(self.doors[i].target)) {
        self.doors[i] add_new_zombie_spawners();
      }
    }

    if(isDefined(self.script_flag)) {
      flag_set(self.script_flag);
    }

    all_trigs = getEntArray(self.target, "target");
    for(i = 0; i < all_trigs.size; i++) {
      all_trigs[i] trigger_off();
    }
    break;
  }
}
door_solid_thread() {
  self waittill_either("rotatedone", "movedone");

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
set_door_unusable() {
  self sethintstring(&"ZOMBIE_FLAMES_UNAVAILABLE");
  self UseTriggerRequireLookAt();
}

debris_init() {
  cost = 1000;
  if(isDefined(self.zombie_cost)) {
    cost = self.zombie_cost;
  }

  self set_hint_string(self, "default_buy_debris_" + cost);
  self SetCursorHint("HINT_NOICON");

  if(isDefined(self.script_flag) && !isDefined(level.flag[self.script_flag])) {
    flag_init(self.script_flag);
  }

  self UseTriggerRequireLookAt();
  self thread debris_think();
}

debris_think() {
  if(level.script == "nazi_zombie_asylum") {
    ents = getEntArray(self.target, "targetname");
    for(i = 0; i < ents.size; i++) {
      if(isDefined(ents[i].script_linkTo)) {
        ents[i] notsolid();
      }
    }
  }

  while(1) {
    self waittill("trigger", who);

    if(!who UseButtonPressed()) {
      continue;
    }

    if(who in_revive_trigger()) {
      continue;
    }

    if(is_player_valid(who)) {
      if(who.score >= self.zombie_cost) {
        who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);
        if(isDefined(level.achievement_notify_func)) {
          level[[level.achievement_notify_func]]("DLC3_ZOMBIE_ALL_DOORS");
        }
        bbPrint("zombie_uses: playername %s playerscore %d round %d cost %d name %s x %f y %f z %f type debris", who.playername, who.score, level.round_number, self.zombie_cost, self.target, self.origin);

        junk = getEntArray(self.target, "targetname");

        if(isDefined(self.script_flag)) {
          flag_set(self.script_flag);
        }

        play_sound_at_pos("purchase", self.origin);

        move_ent = undefined;
        clip = undefined;
        for(i = 0; i < junk.size; i++) {
          junk[i] connectpaths();
          junk[i] add_new_zombie_spawners();

          level notify("junk purchased");

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
            move_ent notsolid();
          }

          clip Delete();
        }

        break;
      } else {
        play_sound_at_pos("no_purchase", self.origin);
      }
    }
  }
}

debris_move(struct) {
  self script_delay();
  self notsolid();

  self play_sound_on_ent("debris_move");
  playsoundatposition("lightning_l", self.origin);
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

  self MoveTo(struct.origin, time, time * 0.5);
  self RotateTo(struct.angles, time * 0.75);

  self waittill("movedone");

  self play_sound_on_entity("couch_slam");
  if(isDefined(self.script_fxid)) {
    playFX(level._effect[self.script_fxid], self.origin);
    playsoundatposition("zombie_spawn", self.origin);
  }
  self Delete();
}
blocker_init() {
  if(!isDefined(self.target)) {
    return;
  }

  targets = getEntArray(self.target, "targetname");

  self.barrier_chunks = [];
  for(j = 0; j < targets.size; j++) {
    if(isDefined(targets[j].script_noteworthy)) {
      if(targets[j].script_noteworthy == "clip") {
        self.clip = targets[j];
        continue;
      }
    }

    targets[j].destroyed = false;
    targets[j].claimed = false;
    targets[j].og_origin = targets[j].origin;
    self.barrier_chunks[self.barrier_chunks.size] = targets[j];

    self blocker_attack_spots();
  }

  assert(isDefined(self.clip));
  self.trigger_location = getstruct(self.target, "targetname");

  self thread blocker_think();
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

blocker_think() {
  while(1) {
    wait(0.5);

    if(all_chunks_intact(self.barrier_chunks)) {
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

  if(GetDvarInt("zombie_debug") > 0) {
    thread debug_blocker(trigger_pos, radius, height);
  }

  trigger set_hint_string(self, "default_reward_barrier_piece");

  doubler_status = level.zombie_vars["zombie_powerup_point_doubler_on"];

  if(doubler_status) {
    cost = original_cost * 2;
  }

  trigger SetCursorHint("HINT_NOICON");

  while(1) {
    trigger waittill("trigger", player);

    if(player hasperk("specialty_fastreload")) {
      has_perk = true;
    } else {
      has_perk = false;
    }

    if(all_chunks_intact(self.barrier_chunks)) {
      trigger notify("all_boards_repaired");
      return;
    }

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

      if(!player UseButtonPressed()) {
        break;
      }

      if(doubler_status != level.zombie_vars["zombie_powerup_point_doubler_on"]) {
        doubler_status = level.zombie_vars["zombie_powerup_point_doubler_on"];
        cost = original_cost;
        if(level.zombie_vars["zombie_powerup_point_doubler_on"]) {
          cost = original_cost * 2;
        }
      }

      chunk = get_random_destroyed_chunk(self.barrier_chunks);
      assert(chunk.destroyed == true);

      chunk Show();

      chunk play_sound_on_ent("rebuild_barrier_piece");

      self thread replace_chunk(chunk, has_perk);

      assert(isDefined(self.clip));
      self.clip enable_trigger();
      self.clip DisconnectPaths();

      if(!self script_delay()) {
        wait(1);
      }

      if(!is_player_valid(player)) {
        break;
      }

      player.rebuild_barrier_reward += cost;
      if(player.rebuild_barrier_reward < level.zombie_vars["rebuild_barrier_cap_per_round"]) {
        player maps\_zombiemode_score::add_to_player_score(cost);
      }

      if(isDefined(player.board_repair)) {
        player.board_repair += 1;
      }

      if(all_chunks_intact(self.barrier_chunks)) {
        trigger notify("all_boards_repaired");
        return;
      }
    }
  }
}

trigger_delete_on_repair() {
  while(isDefined(self)) {
    self waittill("all_boards_repaired");
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

remove_chunk(chunk, node, destroy_immediately) {
  chunk play_sound_on_ent("break_barrier_piece");

  chunk NotSolid();

  fx = "wood_chunk_destory";
  if(isDefined(self.script_fxid)) {
    fx = self.script_fxid;
  }

  playFX(level._effect[fx], chunk.origin);

  if(isDefined(chunk.script_moveoverride) && chunk.script_moveoverride) {
    chunk Hide();
  } else {
    ent = spawn("script_origin", chunk.origin);
    ent.angles = node.angles + (0, 180, 0);
    dist = 100 + RandomInt(100);
    dest = ent.origin + (anglesToForward(ent.angles) * dist);
    trace = bulletTrace(dest + (0, 0, 16), dest + (0, 0, -200), false, undefined);

    if(trace["fraction"] == 1) {
      dest = dest + (0, 0, -200);
    } else {
      dest = trace["position"];
    }

    chunk LinkTo(ent);

    time = ent fake_physicslaunch(dest, 200 + RandomInt(100));

    if(RandomInt(100) > 40) {
      ent RotatePitch(180, time * 0.5);
    } else {
      ent RotatePitch(90, time, time * 0.5);
    }
    wait(time);

    chunk Hide();

    wait(1);
    ent Delete();
  }

  chunk.destroyed = true;
  chunk.target_by_zombie = undefined;
  chunk.mid_repair = undefined;
  chunk notify("destroyed");

  if(all_chunks_destroyed(node.barrier_chunks)) {
    EarthQuake(randomfloatrange(0.5, 0.8), 0.5, chunk.origin, 300);

    if(isDefined(node.clip)) {
      node.clip ConnectPaths();
      wait(0.05);
      node.clip disable_trigger();
    } else {
      for(i = 0; i < node.barrier_chunks.size; i++) {
        node.barrier_chunks[i] ConnectPaths();
      }
    }
  } else {
    EarthQuake(RandomFloatRange(0.1, 0.15), 0.2, chunk.origin, 200);
  }
}

replace_chunk(chunk, has_perk, via_powerup) {
  if(!isDefined(has_perk)) {
    has_perk = false;
  }

  assert(isDefined(chunk.og_origin));

  assert(!isDefined(chunk.mid_repair));
  chunk.mid_repair = true;

  chunk Show();

  sound = "rebuild_barrier_hover";
  if(isDefined(chunk.script_presound)) {
    sound = chunk.script_presound;
  }

  if(!isDefined(via_powerup)) {
    play_sound_at_pos(sound, chunk.origin);
  }

  only_z = (chunk.origin[0], chunk.origin[1], chunk.og_origin[2]);

  if(has_perk == true) {
    chunk RotateTo((0, 0, 0), 0.15);
    chunk waittill_notify_or_timeout("rotatedone", 1);
    wait(0.1);
  } else {
    chunk MoveTo(only_z, 0.15);
    chunk RotateTo((0, 0, 0), 0.3);
    chunk waittill_notify_or_timeout("rotatedone", 1);
    wait(0.2);
  }

  if(has_perk == true) {
    chunk MoveTo(chunk.og_origin, 0.05);
  } else {
    chunk MoveTo(chunk.og_origin, 0.1);
  }

  chunk waittill_notify_or_timeout("movedone", 1);
  assert(chunk.origin == chunk.og_origin);

  chunk.target_by_zombie = undefined;
  chunk.destroyed = false;

  assert(chunk.mid_repair == true);
  chunk.mid_repair = undefined;

  sound = "barrier_rebuild_slam";
  if(isDefined(self.script_ender)) {
    sound = self.script_ender;
  }

  chunk Solid();

  fx = "wood_chunk_destory";
  if(isDefined(self.script_fxid)) {
    fx = self.script_fxid;
  }

  if(!isDefined(via_powerup)) {
    play_sound_at_pos(sound, chunk.origin);
    playFX(level._effect[fx], chunk.origin);
  }

  if(!isDefined(self.clip)) {
    chunk Disconnectpaths();
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
    self.possible_spawners[i].locked_spawner = false;
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