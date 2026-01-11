/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_weap_black_hole_bomb.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include animscripts\zombie_Utility;

init() {
  if(!black_hole_bomb_exists()) {
    return;
  }
  level black_hole_bomb_anim_init();
  level._effect["black_hole_bomb_portal"] = LoadFX("maps/zombie/fx_zmb_blackhole_looping");
  level._effect["black_hole_bomb_portal_exit"] = LoadFX("maps/zombie/fx_zmb_blackhole_exit");
  level._effect["black_hole_bomb_zombie_soul"] = LoadFX("maps/zombie/fx_zmb_blackhole_zombie_death");
  level._effect["black_hole_bomb_zombie_destroy"] = LoadFX("maps/zombie/fx_zmb_blackhole_zombie_flare");
  level._effect["black_hole_bomb_zombie_gib"] = LoadFX("maps/zombie/fx_zombie_dog_explosion");
  level._effect["black_hole_bomb_event_horizon"] = LoadFX("maps/zombie/fx_zmb_blackhole_implode");
  level._effect["black_hole_samantha_steal"] = LoadFX("maps/zombie/fx_zmb_blackhole_trap_end");
  level._effect["black_hole_bomb_zombie_pull"] = LoadFX("maps/zombie/fx_blackhole_zombie_breakup");
  level._effect["black_hole_bomb_marker_flare"] = LoadFX("maps/zombie/fx_zmb_blackhole_flare_marker");
  PreCacheModel("t5_bh_bomb_world");
  level._SCRIPTMOVER_CLIENT_FLAG_BLACKHOLE = 10;
  level._ACTOR_CLIENT_FLAG_BLACKHOLE = 10;
  level.zombie_death_animscript_override = ::black_hole_bomb_corpse_hide;
  level.black_hole_bomb_poi_initial_attract_func = ::black_hole_bomb_initial_attract_func;
  level.black_hole_bomb_poi_arrival_attract_func = ::black_hole_bomb_arrival_attract_func;
  level._black_hole_bomb_zombies_anim_change = [];
  flag_init("bhb_anim_change_allowed");
  level thread black_hole_bomb_throttle_anim_changes();
  flag_set("bhb_anim_change_allowed");
}

player_give_black_hole_bomb() {
  self giveweapon("zombie_black_hole_bomb");
  self set_player_tactical_grenade("zombie_black_hole_bomb");
  self thread player_handle_black_hole_bomb();
}

#using_animtree("zombie_cymbal_monkey");
player_handle_black_hole_bomb() {
  self notify("starting_black_hole_bomb");
  self endon("disconnect");
  self endon("starting_black_hole_bomb");
  attract_dist_diff = level.black_hole_attract_dist_diff;
  if(!isDefined(attract_dist_diff)) {
    attract_dist_diff = 10;
  }
  num_attractors = level.num_black_hole_bomb_attractors;
  if(!isDefined(num_attractors)) {
    num_attractors = 15;
  }
  max_attract_dist = level.black_hole_bomb_attract_dist;
  if(!isDefined(max_attract_dist)) {
    max_attract_dist = 2056;
  }
  while(true) {
    grenade = get_thrown_black_hole_bomb();
    if(isDefined(grenade)) {
      if(self maps\_laststand::player_is_in_laststand() || is_true(self.intermission)) {
        grenade delete();
        continue;
      }
      grenade hide();
      model = spawn("script_model", grenade.origin);
      model setModel("t5_bh_bomb_world");
      model linkTo(grenade);
      model.angles = grenade.angles;
      info = spawnStruct();
      info.sound_attractors = [];
      grenade thread monitor_zombie_groans(info);
      velocitySq = 10000 * 10000;
      oldPos = grenade.origin;
      while(velocitySq != 0) {
        wait(0.05);
        if(!isDefined(grenade)) {
          break;
        }
        velocitySq = distanceSquared(grenade.origin, oldPos);
        oldPos = grenade.origin;
      }
      if(isDefined(grenade)) {
        self thread black_hole_bomb_kill_counter(grenade);
        model unlink();
        model.origin = grenade.origin;
        model.angles = grenade.angles;
        model._black_hole_bomb_player = self;
        model.targetname = "zm_bhb";
        model._new_ground_trace = true;
        grenade resetmissiledetonationtime();
        if(isDefined(level.black_hole_bomb_loc_check_func)) {
          if([
              [level.black_hole_bomb_loc_check_func]
            ](grenade, model, info)) {
            continue;
          }
        }
        if(isDefined(level._blackhole_bomb_valid_area_check)) {
          if([
              [level._blackhole_bomb_valid_area_check]
            ](grenade, model, self)) {
            continue;
          }
        }
        valid_poi = check_point_in_active_zone(grenade.origin);
        if(valid_poi) {
          level thread black_hole_bomb_cleanup(grenade, model);
          if(isDefined(level._black_hole_bomb_poi_override)) {
            model thread[[level._black_hole_bomb_poi_override]]();
          }
          model create_zombie_point_of_interest(max_attract_dist, num_attractors, 0, true, level.black_hole_bomb_poi_initial_attract_func, level.black_hole_bomb_poi_arrival_attract_func);
          model SetClientFlag(level._SCRIPTMOVER_CLIENT_FLAG_BLACKHOLE);
          grenade thread do_black_hole_bomb_sound(model, info);
          level thread black_hole_bomb_teleport_init(grenade);
          grenade.is_valid = true;
        } else {
          self.script_noteworthy = undefined;
          level thread black_hole_bomb_stolen_by_sam(self, model);
        }
      } else {
        self.script_noteworthy = undefined;
        level thread black_hole_bomb_stolen_by_sam(self, model);
      }
    }
    wait(0.05);
  }
}

wait_for_attractor_positions_complete() {
  self waittill("attractor_positions_generated");
  self.attract_to_origin = false;
}

black_hole_bomb_cleanup(parent, model) {
  model endon("sam_stole_it");
  grenade_org = parent.origin;
  while(true) {
    if(!isDefined(parent)) {
      if(isDefined(model)) {
        model Delete();
        wait_network_frame();
      }
      break;
    }
    wait(0.05);
  }
  level thread black_hole_bomb_corpse_collect(grenade_org);
}

black_hole_bomb_corpse_collect(vec_origin) {
  wait(0.1);
  corpse_array = GetCorpseArray();
  for(i = 0; i < corpse_array.size; i++) {
    if(distanceSquared(corpse_array[i].origin, vec_origin) < 192 * 192) {
      corpse_array[i] thread black_hole_bomb_corpse_delete();
    }
  }
}

black_hole_bomb_corpse_delete() {
  self Delete();
}

do_black_hole_bomb_sound(model, info) {
  monk_scream_vox = false;
  if(level.music_override == false) {
    monk_scream_vox = false;
  }
  self playSound("wpn_gersh_device_exp");
  self playLoopSound("wpn_gersh_device_loop_close");
  fakeorigin = self.origin;
  self waittill("explode", position);
  playsoundatposition("wpn_gersh_device_implode", fakeorigin);
  if(isDefined(model)) {}
  for(i = 0; i < info.sound_attractors.size; i++) {
    if(isDefined(info.sound_attractors[i])) {
      info.sound_attractors[i] notify("black_hole_bomb_blown_up");
    }
  }
  if(!monk_scream_vox) {
    play_sound_in_space("zmb_vox_monkey_explode", position);
  }
}

get_thrown_black_hole_bomb() {
  self endon("disconnect");
  self endon("starting_black_hole_bomb");
  while(true) {
    self waittill("grenade_fire", grenade, weapName);
    if(weapName == "zombie_black_hole_bomb") {
      return grenade;
    }
    wait(0.05);
  }
}

monitor_zombie_groans(info) {
  self endon("explode");
  while(true) {
    if(!isDefined(self)) {
      return;
    }
    if(!isDefined(self.attractor_array)) {
      wait(0.05);
      continue;
    }
    for(i = 0; i < self.attractor_array.size; i++) {
      if(array_check_for_dupes(info.sound_attractors, self.attractor_array[i])) {
        if(isDefined(self.origin) && isDefined(self.attractor_array[i].origin)) {
          if(distanceSquared(self.origin, self.attractor_array[i].origin) < 500 * 500) {
            info.sound_attractors = array_add(info.sound_attractors, self.attractor_array[i]);
            self.attractor_array[i] thread play_zombie_groans();
          }
        }
      }
    }
    wait(0.05);
  }
}

play_zombie_groans() {
  self endon("death");
  self endon("black_hole_bomb_blown_up");
  while(1) {
    if(isDefined(self)) {
      self playSound("zmb_vox_zombie_groan");
      wait randomfloatrange(2, 3);
    } else {
      return;
    }
  }
}

black_hole_bomb_exists() {
  return isDefined(level.zombie_weapons["zombie_black_hole_bomb"]);
}

black_hole_bomb_initial_attract_func(ent_poi) {
  self endon("death");
  if(isDefined(self.pre_black_hole_bomb_run_combatanim)) {
    return;
  }
  if(isDefined(self.script_string) && self.script_string == "riser") {
    while(is_true(self.in_the_ground)) {
      wait(0.05);
    }
  }
  soul_spark_end = ent_poi.origin;
  soul_burst_range = 50 * 50;
  pulled_in_range = 128 * 128;
  inner_range = 1024 * 1024;
  outer_edge = 2056 * 2056;
  distance_to_black_hole = 100000 * 100000;
  self._distance_to_black_hole = 100000 * 100000;
  self._black_hole_bomb_collapse_death = 0;
  self._black_hole_attract_walk = 0;
  self._black_hole_attract_run = 0;
  self._current_black_hole_bomb_origin = ent_poi.origin;
  self._normal_run_blend_time = 0.2;
  self._black_hole_bomb_tosser = ent_poi._black_hole_bomb_player;
  self._black_hole_bomb_being_pulled_in_fx = 0;
  self.deathanim = self black_hole_bomb_death_while_attracted();
  if(!isDefined(self._bhb_ent_flag_init)) {
    self ent_flag_init("bhb_anim_change");
    self._bhb_ent_flag_init = 1;
  }
  self.pre_black_hole_bomb_run_combatanim = self black_hole_bomb_store_movement_anim();
  if(isDefined(level._black_hole_attract_override)) {
    level[[level._black_hole_attract_override]]();
  }
  while(isDefined(ent_poi)) {
    self._distance_to_black_hole = distanceSquared(self.origin, self._current_black_hole_bomb_origin);
    if(self._black_hole_attract_walk == 0 && (self._distance_to_black_hole < outer_edge && self._distance_to_black_hole > inner_range)) {
      if(isDefined(self._bhb_walk_attract)) {
        self[[self._bhb_walk_attract]]();
      } else {
        self black_hole_bomb_attract_walk();
      }
    }
    if(self._black_hole_attract_run == 0 && (self._distance_to_black_hole < inner_range && self._distance_to_black_hole > pulled_in_range)) {
      if(isDefined(self._bhb_run_attract)) {
        self[[self._bhb_run_attract]]();
      } else {
        self black_hole_bomb_attract_run();
      }
    }
    if((self._distance_to_black_hole < pulled_in_range) && (self._distance_to_black_hole > soul_burst_range)) {
      self._black_hole_bomb_collapse_death = 1;
      if(isDefined(self._bhb_horizon_death)) {
        self[[self._bhb_horizon_death]](self._current_black_hole_bomb_origin, ent_poi);
      } else {
        self black_hole_bomb_event_horizon_death(self._current_black_hole_bomb_origin, ent_poi);
      }
    }
    if(self._distance_to_black_hole < soul_burst_range) {
      self._black_hole_bomb_collapse_death = 1;
      if(isDefined(self._bhb_horizon_death)) {
        self[[self._bhb_horizon_death]](self._current_black_hole_bomb_origin, ent_poi);
      } else {
        self black_hole_bomb_event_horizon_death(self._current_black_hole_bomb_origin, ent_poi);
      }
    }
    wait(0.1);
  }
  self thread black_hole_bomb_escaped_zombie_reset();
}

black_hole_bomb_store_movement_anim() {
  self endon("death");
  current_anim = self.run_combatanim;
  anim_keys = GetArrayKeys(level.scr_anim[self.animname]);
  for(j = 0; j < anim_keys.size; j++) {
    if(level.scr_anim[self.animname][anim_keys[j]] == current_anim) {
      return anim_keys[j];
    }
  }
  AssertMsg("couldn't find zombie run anim in the array keys");
}

black_hole_bomb_being_pulled_fx() {
  self endon("death");
  wait_network_frame();
  self SetClientFlag(level._ACTOR_CLIENT_FLAG_BLACKHOLE);
  self._black_hole_bomb_being_pulled_in_fx = 1;
}

black_hole_bomb_attract_walk() {
  self endon("death");
  flag_wait("bhb_anim_change_allowed");
  level._black_hole_bomb_zombies_anim_change = add_to_array(level._black_hole_bomb_zombies_anim_change, self, false);
  self ent_flag_wait("bhb_anim_change");
  self.a.runBlendTime = 0.9;
  self clear_run_anim();
  if(self.has_legs) {
    rand = RandomIntRange(1, 4);
    self.needs_run_update = true;
    self._had_legs = true;
    self set_run_anim("slow_pull_" + rand);
    self.run_combatanim = level.scr_anim["zombie"]["slow_pull_" + rand];
    self.crouchRunAnim = level.scr_anim["zombie"]["slow_pull_" + rand];
    self.crouchrun_combatanim = level.scr_anim["zombie"]["slow_pull_" + rand];
  } else {
    rand = RandomIntRange(1, 3);
    self.needs_run_update = true;
    self._had_legs = false;
    self set_run_anim("crawler_slow_pull_" + rand);
    self.run_combatanim = level.scr_anim["zombie"]["crawler_slow_pull_" + rand];
    self.crouchRunAnim = level.scr_anim["zombie"]["crawler_slow_pull_" + rand];
    self.crouchrun_combatanim = level.scr_anim["zombie"]["crawler_slow_pull_" + rand];
  }
  self._black_hole_attract_walk = 1;
  self._bhb_change_anim_notified = 1;
  self.a.runBlendTime = self._normal_run_blend_time;
}

black_hole_bomb_attract_run() {
  self endon("death");
  rand = RandomIntRange(1, 4);
  flag_wait("bhb_anim_change_allowed");
  level._black_hole_bomb_zombies_anim_change = add_to_array(level._black_hole_bomb_zombies_anim_change, self, false);
  self ent_flag_wait("bhb_anim_change");
  self.a.runBlendTime = 0.9;
  self clear_run_anim();
  if(self.has_legs) {
    self.needs_run_update = true;
    self set_run_anim("fast_pull_" + rand);
    self.run_combatanim = level.scr_anim["zombie"]["fast_pull_" + rand];
    self.crouchRunAnim = level.scr_anim["zombie"]["fast_pull_" + rand];
    self.crouchrun_combatanim = level.scr_anim["zombie"]["fast_pull_" + rand];
  } else {
    self.needs_run_update = true;
    self set_run_anim("crawler_fast_pull_" + rand);
    self.run_combatanim = level.scr_anim["zombie"]["crawler_fast_pull_" + rand];
    self.crouchRunAnim = level.scr_anim["zombie"]["crawler_fast_pull_" + rand];
    self.crouchrun_combatanim = level.scr_anim["zombie"]["crawler_fast_pull_" + rand];
  }
  self._black_hole_attract_run = 1;
  self._bhb_change_anim_notified = 1;
  self.a.runBlendTime = self._normal_run_blend_time;
}

black_hole_bomb_death_anim() {
  self endon("death");
  flt_moveto_time = 0.7;
  rand = RandomIntRange(1, 4);
  if(self.has_legs) {
    death_animation = level.scr_anim[self.animname]["black_hole_death_" + rand];
  } else {
    death_animation = level.scr_anim[self.animname]["crawler_black_hole_death_" + rand];
  }
  return death_animation;
}

black_hole_bomb_death_while_attracted() {
  self endon("death");
  death_animation = undefined;
  rand = RandomIntRange(1, 5);
  if(self.has_legs) {
    death_animation = level.scr_anim[self.animname]["attracted_death_" + rand];
  }
  return death_animation;
}

black_hole_bomb_arrival_attract_func(ent_poi) {
  self endon("death");
  self endon("zombie_acquire_enemy");
  self endon("path_timer_done");
  soul_spark_end = ent_poi.origin;
  self waittill("goal");
  if(isDefined(self._bhb_horizon_death)) {
    self[[self._bhb_horizon_death]](self._current_black_hole_bomb_origin, ent_poi);
  } else {
    self black_hole_bomb_event_horizon_death(self._current_black_hole_bomb_origin, ent_poi);
  }
}

black_hole_bomb_event_horizon_death(vec_black_hole_org, grenade) {
  self endon("death");
  self maps\_zombiemode_spawner::zombie_eye_glow_stop();
  self playSound("wpn_gersh_device_kill");
  pulled_in_anim = black_hole_bomb_death_anim();
  self AnimScripted("pulled_in_complete", self.origin, self.angles, pulled_in_anim);
  self waittill_either("bhb_burst", "pulled_in_complete");
  playFXOnTag(level._effect["black_hole_bomb_zombie_destroy"], self, "tag_origin");
  grenade notify("black_hole_bomb_kill");
  self DoDamage(self.health + 50, self.origin + (0, 0, 50), self._black_hole_bomb_tosser, "zombie_black_hole_bomb", "MOD_CRUSH");
}

black_hole_bomb_corpse_hide() {
  if(isDefined(self._black_hole_bomb_collapse_death) && self._black_hole_bomb_collapse_death == 1) {
    playFXOnTag(level._effect["black_hole_bomb_zombie_gib"], self, "tag_origin");
    self hide();
  }
  if(isDefined(self._black_hole_bomb_being_pulled_in_fx) && self._black_hole_bomb_being_pulled_in_fx == 1) {}
}

black_hole_bomb_escaped_zombie_reset() {
  self endon("death");
  flag_wait("bhb_anim_change_allowed");
  level._black_hole_bomb_zombies_anim_change = add_to_array(level._black_hole_bomb_zombies_anim_change, self, false);
  self ent_flag_wait("bhb_anim_change");
  self.a.runBlendTime = 0.9;
  self clear_run_anim();
  self.needs_run_update = true;
  if(!self.has_legs) {
    legless_walk_anims = [];
    legless_walk_anims = add_to_array(legless_walk_anims, "crawl1", false);
    legless_walk_anims = add_to_array(legless_walk_anims, "crawl5", false);
    legless_walk_anims = add_to_array(legless_walk_anims, "crawl_hand_1", false);
    legless_walk_anims = add_to_array(legless_walk_anims, "crawl_hand_2", false);
    rand_walk_anim = randomInt(legless_walk_anims.size);
    legless_sprint_anims = [];
    legless_sprint_anims = add_to_array(legless_sprint_anims, "crawl2", false);
    legless_sprint_anims = add_to_array(legless_sprint_anims, "crawl3", false);
    legless_sprint_anims = add_to_array(legless_sprint_anims, "crawl_sprint1", false);
    rand_sprint_anim = randomInt(legless_sprint_anims.size);
    if(self.zombie_move_speed == "walk") {
      self set_run_anim(legless_walk_anims[rand_walk_anim]);
      self.run_combatanim = level.scr_anim[self.animname][legless_walk_anims[rand_walk_anim]];
      self.crouchRunAnim = level.scr_anim[self.animname][legless_walk_anims[rand_walk_anim]];
      self.crouchrun_combatanim = level.scr_anim[self.animname][legless_walk_anims[rand_walk_anim]];
    } else if(self.zombie_move_speed == "run") {
      self set_run_anim("crawl4");
      self.run_combatanim = level.scr_anim[self.animname]["crawl4"];
      self.crouchRunAnim = level.scr_anim[self.animname]["crawl4"];
      self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl4"];
    } else if(self.zombie_move_speed == "sprint") {
      self set_run_anim(legless_sprint_anims[rand_sprint_anim]);
      self.run_combatanim = level.scr_anim[self.animname][legless_sprint_anims[rand_sprint_anim]];
      self.crouchRunAnim = level.scr_anim[self.animname][legless_sprint_anims[rand_sprint_anim]];
      self.crouchrun_combatanim = level.scr_anim[self.animname][legless_sprint_anims[rand_sprint_anim]];
    } else {
      self set_run_anim("crawl4");
      self.run_combatanim = level.scr_anim[self.animname]["crawl4"];
      self.crouchRunAnim = level.scr_anim[self.animname]["crawl4"];
      self.crouchrun_combatanim = level.scr_anim[self.animname]["crawl4"];
    }
  } else {
    self set_run_anim(self.pre_black_hole_bomb_run_combatanim);
    self.run_combatanim = level.scr_anim[self.animname][self.pre_black_hole_bomb_run_combatanim];
    self.crouchRunAnim = level.scr_anim[self.animname][self.pre_black_hole_bomb_run_combatanim];
    self.crouchrun_combatanim = level.scr_anim[self.animname][self.pre_black_hole_bomb_run_combatanim];
  }
  self.pre_black_hole_bomb_run_combatanim = undefined;
  self._black_hole_attract_walk = 0;
  self._black_hole_attract_run = 0;
  self._bhb_change_anim_notified = 1;
  self._black_hole_bomb_being_pulled_in_fx = 0;
  self.a.runBlendTime = self._normal_run_blend_time;
  which_anim = randomInt(10);
  if(self.has_legs) {
    if(which_anim > 5) {
      self.deathanim = level.scr_anim[self.animname]["death1"];
    } else {
      self.deathanim = level.scr_anim[self.animname]["death2"];
    }
  } else {
    if(which_anim > 5) {
      self.deathanim = level.scr_anim[self.animname]["death3"];
    } else {
      self.deathanim = level.scr_anim[self.animname]["death4"];
    }
  }
  self._had_legs = undefined;
  self._bhb_ent_flag_init = 0;
}

black_hole_bomb_throttle_anim_changes() {
  if(!isDefined(level._black_hole_bomb_zombies_anim_change)) {
    level._black_hole_bomb_zombies_anim_change = [];
  }
  int_max_num_zombies_per_frame = 7;
  array_zombies_allowed_to_switch = [];
  while(isDefined(level._black_hole_bomb_zombies_anim_change)) {
    if(level._black_hole_bomb_zombies_anim_change.size == 0) {
      wait(0.1);
      continue;
    }
    array_zombies_allowed_to_switch = level._black_hole_bomb_zombies_anim_change;
    for(i = 0; i < array_zombies_allowed_to_switch.size; i++) {
      if(isDefined(array_zombies_allowed_to_switch[i]) &&
        IsAlive(array_zombies_allowed_to_switch[i])) {
        array_zombies_allowed_to_switch[i] ent_flag_set("bhb_anim_change");
      }
      if(i >= int_max_num_zombies_per_frame) {
        break;
      }
    }
    flag_clear("bhb_anim_change_allowed");
    for(i = 0; i < array_zombies_allowed_to_switch.size; i++) {
      if(!isDefined(array_zombies_allowed_to_switch[i]._bhb_ent_flag_init)) {
        array_zombies_allowed_to_switch[i] ent_flag_init("bhb_anim_change");
        array_zombies_allowed_to_switch[i]._bhb_ent_flag_init = 1;
      }
      if(array_zombies_allowed_to_switch[i] ent_flag("bhb_anim_change")) {
        level._black_hole_bomb_zombies_anim_change = array_remove(level._black_hole_bomb_zombies_anim_change, array_zombies_allowed_to_switch[i]);
      }
    }
    level._black_hole_bomb_zombies_anim_change = array_removedead(level._black_hole_bomb_zombies_anim_change);
    level._black_hole_bomb_zombies_anim_change = array_removeundefined(level._black_hole_bomb_zombies_anim_change);
    flag_set("bhb_anim_change_allowed");
    wait_network_frame();
    wait(0.1);
  }
}

black_hole_bomb_teleport_init(ent_grenade) {
  if(!isDefined(ent_grenade)) {
    return;
  }
  teleport_trigger = spawn("trigger_radius", ent_grenade.origin, 0, 64, 70);
  ent_grenade thread black_hole_bomb_trigger_monitor(teleport_trigger);
  ent_grenade waittill("explode");
  teleport_trigger notify("black_hole_complete");
  wait(0.1);
  teleport_trigger Delete();
}

black_hole_bomb_trigger_monitor(ent_trigger) {
  ent_trigger endon("black_hole_complete");
  while(1) {
    ent_trigger waittill("trigger", ent_player);
    if(IsPlayer(ent_player) && !ent_player IsOnGround() && !is_true(ent_player.lander)) {
      ent_trigger thread black_hole_teleport_trigger_thread(ent_player, ::black_hole_time_before_teleport, ::black_hole_teleport_cancel);
    }
    wait(0.1);
  }
}

black_hole_time_before_teleport(ent_player, str_endon) {
  ent_player endon(str_endon);
  if(!BulletTracePassed(ent_player getEye(), self.origin + (0, 0, 65), false, ent_player)) {
    return;
  }
  black_hole_teleport_structs = getstructarray("struct_black_hole_teleport", "targetname");
  chosen_spot = undefined;
  if(isDefined(level._special_blackhole_bomb_structs)) {
    black_hole_teleport_structs = [[level._special_blackhole_bomb_structs]]();
  }
  if(!isDefined(black_hole_teleport_structs) || black_hole_teleport_structs.size == 0) {
    return;
  }
  black_hole_teleport_structs = array_randomize(black_hole_teleport_structs);
  if(isDefined(level._override_blackhole_destination_logic)) {
    chosen_spot = [[level._override_blackhole_destination_logic]](black_hole_teleport_structs, ent_player);
  } else {
    for(i = 0; i < black_hole_teleport_structs.size; i++) {
      if(check_point_in_active_zone(black_hole_teleport_structs[i].origin) &&
        (ent_player get_current_zone() != black_hole_teleport_structs[i].script_string)) {
        chosen_spot = black_hole_teleport_structs[i];
        break;
      }
    }
  }
  if(isDefined(chosen_spot)) {
    self playSound("zmb_gersh_teleporter_out");
    ent_player thread black_hole_teleport(chosen_spot);
  }
}

black_hole_teleport_cancel(ent_player) {}
black_hole_teleport(struct_dest) {
  self endon("death");
  if(!isDefined(struct_dest)) {
    return;
  }
  prone_offset = (0, 0, 49);
  crouch_offset = (0, 0, 20);
  stand_offset = (0, 0, 0);
  destination = undefined;
  if(self GetStance() == "prone") {
    destination = struct_dest.origin + prone_offset;
  } else if(self GetStance() == "crouch") {
    destination = struct_dest.origin + crouch_offset;
  } else {
    destination = struct_dest.origin + stand_offset;
  }
  if(isDefined(level._black_hole_teleport_override)) {
    level[[level._black_hole_teleport_override]](self);
  }
  black_hole_bomb_create_exit_portal(struct_dest.origin);
  self FreezeControls(true);
  self DisableOffhandWeapons();
  self DisableWeapons();
  self DontInterpolate();
  self SetOrigin(destination);
  self SetPlayerAngles(struct_dest.angles);
  self EnableOffhandWeapons();
  self EnableWeapons();
  self FreezeControls(false);
  self thread slightly_delayed_player_response();
}

slightly_delayed_player_response() {
  wait(1);
  self maps\_zombiemode_audio::create_and_play_dialog("general", "teleport_gersh");
}

black_hole_teleport_trigger_thread(ent, on_enter_payload, on_exit_payload) {
  ent endon("death");
  self endon("black_hole_complete");
  if(ent black_hole_teleport_ent_already_in_trigger(self)) {
    return;
  }
  self black_hole_teleport_add_trigger_to_ent(ent);
  endon_condition = "leave_trigger_" + self getEntityNumber();
  if(isDefined(on_enter_payload)) {
    self thread[[on_enter_payload]](ent, endon_condition);
  }
  while(isDefined(ent) && ent IsTouching(self) && isDefined(self)) {
    wait(0.01);
  }
  ent notify(endon_condition);
  if(isDefined(ent) && isDefined(on_exit_payload)) {
    self thread[[on_exit_payload]](ent);
  }
  if(isDefined(ent)) {
    self black_hole_teleport_remove_trigger_from_ent(ent);
  }
}

black_hole_teleport_add_trigger_to_ent(ent) {
  if(!isDefined(ent._triggers)) {
    ent._triggers = [];
  }
  ent._triggers[self getEntityNumber()] = 1;
}

black_hole_teleport_remove_trigger_from_ent(ent) {
  if(!isDefined(ent._triggers)) {
    return;
  }
  if(!isDefined(ent._triggers[self getEntityNumber()])) {
    return;
  }
  ent._triggers[self getEntityNumber()] = 0;
}

black_hole_teleport_ent_already_in_trigger(trig) {
  if(!isDefined(self._triggers)) {
    return false;
  }
  if(!isDefined(self._triggers[trig getEntityNumber()])) {
    return false;
  }
  if(!self._triggers[trig getEntityNumber()]) {
    return false;
  }
  return true;
}

black_hole_bomb_kill_counter(grenade) {
  self endon("death");
  grenade endon("death");
  kill_count = 0;
  for(;;) {
    grenade waittill("black_hole_bomb_kill");
    kill_count++;
    if(kill_count == 4) {
      self maps\_zombiemode_audio::create_and_play_dialog("kill", "gersh_device");
    }
    if(5 <= kill_count) {
      self notify("black_hole_kills_achievement");
    }
  }
}

black_hole_bomb_create_exit_portal(pos) {
  exit_portal_fx_spot = spawn("script_model", pos);
  exit_portal_fx_spot setModel("tag_origin");
  playFXOnTag(level._effect["black_hole_bomb_portal_exit"], exit_portal_fx_spot, "tag_origin");
  exit_portal_fx_spot thread black_hole_bomb_exit_clean_up();
  exit_portal_fx_spot playSound("zmb_gersh_teleporter_go");
}

black_hole_bomb_exit_clean_up() {
  wait(4.0);
  self Delete();
}

black_hole_bomb_stolen_by_sam(ent_grenade, ent_model) {
  if(!isDefined(ent_model)) {
    return;
  }
  direction = ent_model.origin;
  direction = (direction[1], direction[0], 0);
  if(direction[1] < 0 || (direction[0] > 0 && direction[1] > 0)) {
    direction = (direction[0], direction[1] * -1, 0);
  } else if(direction[0] < 0) {
    direction = (direction[0] * -1, direction[1], 0);
  }
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    if(IsAlive(players[i])) {
      if(is_true(level.player_4_vox_override)) {
        players[i] playlocalsound("zmb_laugh_rich");
      } else {
        players[i] playlocalsound("zmb_laugh_child");
      }
    }
  }
  playFXOnTag(level._effect["black_hole_samantha_steal"], ent_model, "tag_origin");
  ent_model MoveZ(60, 1.0, 0.25, 0.25);
  ent_model Vibrate(direction, 1.5, 2.5, 1.0);
  ent_model waittill("movedone");
  ent_model Delete();
}

#using_animtree("generic_human");
black_hole_bomb_anim_init() {
  if(isDefined(level._use_extra_blackhole_anims)) {
    [[level._use_extra_blackhole_anims]]();
  }
  level.scr_anim["zombie"]["slow_pull_1"] = % ai_zombie_blackhole_walk_slow_v1;
  level.scr_anim["zombie"]["slow_pull_2"] = % ai_zombie_blackhole_walk_slow_v2;
  level.scr_anim["zombie"]["slow_pull_3"] = % ai_zombie_blackhole_walk_slow_v3;
  level.scr_anim["zombie"]["fast_pull_1"] = % ai_zombie_blackhole_walk_fast_v1;
  level.scr_anim["zombie"]["fast_pull_2"] = % ai_zombie_blackhole_walk_fast_v2;
  level.scr_anim["zombie"]["fast_pull_3"] = % ai_zombie_blackhole_walk_fast_v3;
  level.scr_anim["zombie"]["black_hole_death_1"] = % ai_zombie_blackhole_death_v1;
  level.scr_anim["zombie"]["black_hole_death_2"] = % ai_zombie_blackhole_death_v2;
  level.scr_anim["zombie"]["black_hole_death_3"] = % ai_zombie_blackhole_death_v3;
  level.scr_anim["zombie"]["crawler_slow_pull_1"] = % ai_zombie_blackhole_crawl_slow_v1;
  level.scr_anim["zombie"]["crawler_slow_pull_2"] = % ai_zombie_blackhole_crawl_slow_v2;
  level.scr_anim["zombie"]["crawler_fast_pull_1"] = % ai_zombie_blackhole_crawl_fast_v1;
  level.scr_anim["zombie"]["crawler_fast_pull_2"] = % ai_zombie_blackhole_crawl_fast_v2;
  level.scr_anim["zombie"]["crawler_fast_pull_3"] = % ai_zombie_blackhole_crawl_fast_v3;
  level.scr_anim["zombie"]["crawler_black_hole_death_1"] = % ai_zombie_blackhole_crawl_death_v1;
  level.scr_anim["zombie"]["crawler_black_hole_death_2"] = % ai_zombie_blackhole_crawl_death_v2;
  level.scr_anim["zombie"]["crawler_black_hole_death_3"] = % ai_zombie_blackhole_crawl_death_v3;
  level.scr_anim["zombie"]["attracted_death_1"] = % ai_zombie_blackhole_death_preburst_v1;
  level.scr_anim["zombie"]["attracted_death_2"] = % ai_zombie_blackhole_death_preburst_v2;
  level.scr_anim["zombie"]["attracted_death_3"] = % ai_zombie_blackhole_death_preburst_v3;
  level.scr_anim["zombie"]["attracted_death_4"] = % ai_zombie_blackhole_death_preburst_v4;
}