/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_temple_waterslide.gsc
*********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_utility_raven;

precache_assets() {
  level._effect["fx_slide_wake"] = LoadFX("bio/player/fx_player_water_swim_wake");
  level._effect["fx_slide_splash"] = LoadFX("bio/player/fx_player_water_splash");
  level._effect["fx_slide_splash_2"] = LoadFX("env/water/fx_water_splash_fountain_lg");
  level._effect["fx_slide_splash_3"] = LoadFX("maps/pow/fx_pow_cave_water_splash");
  level._effect["fx_slide_water_fall"] = LoadFX("maps/pow/fx_pow_cave_water_fall");
}

waterslide_main() {
  flag_init("waterslide_open");
  zombie_cave_slide_init();
  if(getDvar("waterslide_debug") == "") {
    SetDvar("waterslide_debug", "0");
  }
  messageTrigger = getEnt("waterslide_message_trigger", "targetname");
  if(isDefined(messageTrigger)) {
    messageTrigger setcursorhint("HINT_NOICON");
  }
  cheat = false;
  if(!cheat) {
    if(isDefined(messageTrigger)) {
      messageTrigger SetHintString(&"ZOMBIE_NEED_POWER");
    }
    flag_wait("power_on");
    if(isDefined(messageTrigger)) {
      messageTrigger SetHintString(&"ZOMBIE_TEMPLE_DESTINATION_NOT_OPEN");
    }
    flag_wait_any("cave01_to_cave02", "pressure_to_cave01");
  }
  flag_set("waterslide_open");
  if(isDefined(messageTrigger)) {
    messageTrigger SetHintString("");
  }
  waterSlideBlocker = getEnt("water_slide_blocker", "targetname");
  if(isDefined(waterSlideBlocker)) {
    waterSlideBlocker ConnectPaths();
    waterSlideBlocker movez(128, 1);
  }
  level notify("slide_open");
}

zombie_cave_slide_init() {
  flag_init("slide_anim_change_allowed");
  level.zombies_slide_anim_change = [];
  level thread slide_anim_change_throttle();
  flag_set("slide_anim_change_allowed");
  slide_trigs = getEntArray("zombie_cave_slide", "targetname");
  array_thread(slide_trigs, ::slide_trig_watch);
  level thread slide_player_enter_watch();
  level thread slide_player_exit_watch();
  level thread zombie_caveslide_anim_failsafe();
}

zombie_caveslide_anim_failsafe() {
  trig = getEnt("zombie_cave_slide_failsafe", "targetname");
  if(isDefined(trig)) {
    while(1) {
      trig waittill("trigger", who);
      if(is_true(who.sliding)) {
        who.sliding = false;
        who thread reset_zombie_anim();
      }
    }
  }
}

slide_trig_watch() {
  slide_node = GetNode(self.target, "targetname");
  if(!isDefined(slide_node)) {
    return;
  }
  self trigger_off();
  level waittill("slide_open");
  self trigger_on();
  while(true) {
    self waittill("trigger", who);
    if(who.animname == "zombie" || who.animname == "sonic_zombie" || who.animname == "napalm_zombie") {
      if(isDefined(who.sliding) && who.sliding == true) {
        continue;
      } else {
        who thread zombie_sliding(slide_node);
      }
    } else if(isDefined(who.zombie_sliding)) {
      who thread[[who.zombie_sliding]](slide_node);
    }
  }
}

#using_animtree("generic_human");
cave_slide_anim_init() {
  level.scr_anim["zombie"]["fast_pull_4"] = % ai_zombie_caveslide_traverse;
  level.scr_anim["napalm_zombie"]["fast_pull_4"] = % ai_zombie_caveslide_traverse;
  level.scr_anim["sonic_zombie"]["fast_pull_4"] = % ai_zombie_caveslide_traverse;
  level.scr_anim["zombie"]["attracted_death_1"] = % ai_zombie_blackhole_death_preburst_v1;
  level.scr_anim["zombie"]["attracted_death_2"] = % ai_zombie_blackhole_death_preburst_v2;
  level.scr_anim["zombie"]["attracted_death_3"] = % ai_zombie_blackhole_death_preburst_v3;
  level.scr_anim["zombie"]["attracted_death_4"] = % ai_zombie_blackhole_death_preburst_v4;
  level.scr_anim["napalm_zombie"]["attracted_death_1"] = % ai_zombie_blackhole_death_preburst_v1;
  level.scr_anim["napalm_zombie"]["attracted_death_2"] = % ai_zombie_blackhole_death_preburst_v2;
  level.scr_anim["napalm_zombie"]["attracted_death_3"] = % ai_zombie_blackhole_death_preburst_v3;
  level.scr_anim["napalm_zombie"]["attracted_death_4"] = % ai_zombie_blackhole_death_preburst_v4;
  level.scr_anim["sonic_zombie"]["attracted_death_1"] = % ai_zombie_blackhole_death_preburst_v1;
  level.scr_anim["sonic_zombie"]["attracted_death_2"] = % ai_zombie_blackhole_death_preburst_v2;
  level.scr_anim["sonic_zombie"]["attracted_death_3"] = % ai_zombie_blackhole_death_preburst_v3;
  level.scr_anim["sonic_zombie"]["attracted_death_4"] = % ai_zombie_blackhole_death_preburst_v4;
}

zombie_sliding(slide_node) {
  self endon("death");
  level endon("intermission");
  if(!isDefined(self.cave_slide_flag_init)) {
    self ent_flag_init("slide_anim_change");
    self.cave_slide_flag_init = 1;
  }
  self.is_traversing = true;
  self notify("zombie_start_traverse");
  self thread zombie_slide_watch();
  self thread play_zombie_slide_looper();
  self.sliding = true;
  self.ignoreall = true;
  self thread gibbed_while_sliding();
  self notify("stop_find_flesh");
  self notify("zombie_acquire_enemy");
  self thread set_zombie_slide_anim();
  self SetGoalNode(slide_node);
  check_dist_squared = 60 * 60;
  while(Distancesquared(self.origin, slide_node.origin) > check_dist_squared) {
    wait(0.01);
  }
  self thread reset_zombie_anim();
  self notify("water_slide_exit");
  self.sliding = false;
  self.is_traversing = false;
  self notify("zombie_end_traverse");
  self.ignoreall = false;
  self thread maps\_zombiemode_spawner::find_flesh();
}

play_zombie_slide_looper() {
  self endon("death");
  level endon("intermission");
  self playLoopSound("fly_dtp_slide_loop_npc_snow", .5);
  self waittill_any("zombie_end_traverse", "death");
  self stopLoopSound(.5);
}

set_zombie_slide_anim() {
  self endon("death");
  rand = RandomIntRange(1, 4);
  level.zombies_slide_anim_change = add_to_array(level.zombies_slide_anim_change, self, false);
  self ent_flag_wait("slide_anim_change");
  self clear_run_anim();
  if(self.has_legs) {
    self._had_legs = true;
    self.preslide_death = self.deathanim;
    self.deathanim = death_while_sliding();
    self set_run_anim("fast_pull_4");
    self.run_combatanim = level.scr_anim[self.animname]["fast_pull_4"];
    self.crouchRunAnim = level.scr_anim[self.animname]["fast_pull_4"];
    self.crouchrun_combatanim = level.scr_anim[self.animname]["fast_pull_4"];
    self.needs_run_update = true;
  } else {
    self._had_legs = false;
    self set_run_anim("fast_pull_4");
    self.run_combatanim = level.scr_anim[self.animname]["fast_pull_4"];
    self.crouchRunAnim = level.scr_anim[self.animname]["fast_pull_4"];
    self.crouchrun_combatanim = level.scr_anim[self.animname]["fast_pull_4"];
    self.needs_run_update = true;
  }
}

reset_zombie_anim() {
  self endon("death");
  level.zombies_slide_anim_change = add_to_array(level.zombies_slide_anim_change, self, false);
  self ent_flag_wait("slide_anim_change");
  theanim = undefined;
  if(self.has_legs) {
    if(isDefined(self.preslide_death)) {
      self.deathanim = self.preslide_death;
    }
    switch (self.zombie_move_speed) {
      case "walk":
        theanim = "walk" + randomintrange(1, 8);
        break;
      case "run":
        theanim = "run" + randomintrange(1, 6);
        break;
      case "sprint":
        theanim = "sprint" + randomintrange(1, 4);
        break;
    }
  } else {
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
    switch (self.zombie_move_speed) {
      case "walk":
        theanim = legless_walk_anims[rand_walk_anim];
        break;
      case "run":
        theanim = "crawl4";
        break;
      case "sprint":
        theanim = legless_sprint_anims[rand_sprint_anim];
        break;
      default:
        theanim = "crawl4";
        break;
    }
  }
  if(isDefined(level.scr_anim[self.animname][theanim])) {
    self clear_run_anim();
    wait_network_frame();
    self set_run_anim(theanim);
    self.run_combatanim = level.scr_anim[self.animname][theanim];
    self.walk_combatanim = level.scr_anim[self.animname][theanim];
    self.crouchRunAnim = level.scr_anim[self.animname][theanim];
    self.crouchrun_combatanim = level.scr_anim[self.animname][theanim];
    self.needs_run_update = true;
    return;
  } else {
    self thread reset_zombie_anim();
  }
}

death_while_sliding() {
  self endon("death");
  if(self.animname == "sonic_zombie" || self.animname == "napalm_zombie") {
    return self.deathanim;
  }
  death_animation = undefined;
  rand = RandomIntRange(1, 5);
  if(self.has_legs) {
    death_animation = level.scr_anim[self.animname]["attracted_death_" + rand];
  }
  return death_animation;
}

gibbed_while_sliding() {
  self endon("death");
  if(self.animname == "sonic_zombie" || self.animname == "napalm_zombie") {
    return;
  }
  if(!self.has_legs) {
    return;
  }
  while(self.sliding) {
    if(!self.has_legs && self._had_legs == true) {
      self thread set_zombie_slide_anim();
      return;
    }
    wait(0.1);
  }
}

slide_anim_change_throttle() {
  if(!isDefined(level.zombies_slide_anim_change)) {
    level.zombies_slide_anim_change = [];
  }
  int_max_num_zombies_per_frame = 7;
  array_zombies_allowed_to_switch = [];
  while(isDefined(level.zombies_slide_anim_change)) {
    if(level.zombies_slide_anim_change.size == 0) {
      wait(0.1);
      continue;
    }
    array_zombies_allowed_to_switch = level.zombies_slide_anim_change;
    for(i = 0; i < array_zombies_allowed_to_switch.size; i++) {
      if(isDefined(array_zombies_allowed_to_switch[i]) && IsAlive(array_zombies_allowed_to_switch[i])) {
        array_zombies_allowed_to_switch[i] ent_flag_set("slide_anim_change");
      }
      if(i >= int_max_num_zombies_per_frame) {
        break;
      }
    }
    flag_clear("slide_anim_change_allowed");
    for(i = 0; i < array_zombies_allowed_to_switch.size; i++) {
      if(array_zombies_allowed_to_switch[i] ent_flag("slide_anim_change")) {
        level.zombies_slide_anim_change = array_remove(level.zombies_slide_anim_change, array_zombies_allowed_to_switch[i]);
      }
    }
    level.zombies_slide_anim_change = array_removedead(level.zombies_slide_anim_change);
    level.zombies_slide_anim_change = array_removeundefined(level.zombies_slide_anim_change);
    flag_set("slide_anim_change_allowed");
    wait_network_frame();
    wait(0.1);
  }
}

slide_player_enter_watch() {
  level endon("fake_death");
  trig = getEnt("cave_slide_force_crouch", "targetname");
  while(true) {
    trig waittill("trigger", who);
    if(isDefined(who) && isPlayer(who) && who.sessionstate != "spectator" && !is_true(who.on_slide)) {
      who.on_slide = true;
      who thread player_slide_watch();
      who thread maps\_zombiemode_audio::create_and_play_dialog("general", "slide");
    }
  }
}

slide_player_exit_watch() {
  trig = getEnt("cave_slide_force_stand", "targetname");
  while(true) {
    trig waittill("trigger", who);
    if(isDefined(who) && isPlayer(who) && who.sessionstate != "spectator" && is_true(who.on_slide)) {
      who.on_slide = false;
      who notify("water_slide_exit");
    }
  }
}

player_slide_watch() {
  self thread on_player_enter_slide();
  self thread player_slide_fake_death_watch();
  self waittill_any("water_slide_exit", "death", "disconnect");
  if(isDefined(self)) {
    self thread on_player_exit_slide();
  }
}

player_slide_fake_death_watch() {
  self endon("death");
  self endon("disconnect");
  self endon("water_slide_exit");
  self waittill("fake_death");
  self allowstand(true);
  self AllowProne(true);
}

on_player_enter_slide() {
  self endon("death");
  self endon("disconnect");
  self endon("water_slide_exit");
  self thread play_loop_sound_on_entity("evt_slideloop");
  while(self maps\_laststand::player_is_in_laststand()) {
    wait .1;
  }
  while(is_true(self.divetoprone)) {
    wait(.1);
  }
  self AllowStand(false);
  self AllowProne(false);
  self SetStance("crouch");
}

on_player_exit_slide() {
  self endon("death");
  self endon("disconnect");
  self AllowStand(true);
  self AllowProne(true);
  if(!self maps\_laststand::player_is_in_laststand()) {
    self SetStance("stand");
  }
  self thread stop_loop_sound_on_entity("evt_slideloop");
}

zombie_slide_watch() {
  self thread on_zombie_enter_slide();
  self waittill_any("water_slide_exit", "death");
  self thread on_zombie_exit_slide();
}

on_zombie_enter_slide() {
  self thread play_loop_sound_on_entity("evt_slideloop");
}

on_zombie_exit_slide() {
  self thread stop_loop_sound_on_entity("evt_slideloop");
}