/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_cosmodrome_traps.gsc
********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_traps;
#include maps\_zombiemode_utility;

init_funcs() {}
init_traps() {
  level thread rocket_init();
  level thread centrifuge_init();
  level thread door_firetrap_init();
}
claw_attach(arm, claw_name) {
  claws = getEntArray(claw_name, "targetname");
  for(i = 0; i < claws.size; i++) {
    claws[i] LinkTo(arm);
  }
}
claw_detach(arm, claw_name) {
  claws = getEntArray(claw_name, "targetname");
  for(i = 0; i < claws.size; i++) {
    claws[i] unlink();
  }
}
rocket_init() {
  flag_wait("all_players_spawned");
  wait(1);
  retract_l = GetStruct("claw_l_retract", "targetname");
  retract_r = GetStruct("claw_r_retract", "targetname");
  extend_l = GetStruct("claw_l_extend", "targetname");
  extend_r = GetStruct("claw_r_extend", "targetname");
  level.claw_retract_l_pos = retract_l.origin;
  level.claw_retract_r_pos = retract_r.origin;
  level.claw_extend_l_pos = extend_l.origin;
  level.claw_extend_r_pos = extend_r.origin;
  level.gantry_l = getent("claw_arm_l", "targetname");
  level.gantry_r = getent("claw_arm_r", "targetname");
  level.claw_arm_l = GetEnt("claw_l_arm", "targetname");
  claw_attach(level.claw_arm_l, "claw_l");
  level.claw_arm_r = GetEnt("claw_r_arm", "targetname");
  claw_attach(level.claw_arm_r, "claw_r");
  level.rocket = GetEnt("zombie_rocket", "targetname");
  rocket_pieces = getEntArray(level.rocket.target, "targetname");
  for(i = 0; i < rocket_pieces.size; i++) {
    rocket_pieces[i] setforcenocull();
    rocket_pieces[i] linkto(level.rocket);
  }
  level.rocket_lifter = GetEnt("lifter_body", "targetname");
  lifter_pieces = getEntArray(level.rocket_lifter.target, "targetname");
  for(i = 0; i < lifter_pieces.size; i++) {
    lifter_pieces[i] linkto(level.rocket_lifter);
  }
  level.rocket_lifter_arm = GetEnt("lifter_arm", "targetname");
  level.rocket_lifter_clamps = getEntArray("lifter_clamp", "targetname");
  for(i = 0; i < level.rocket_lifter_clamps.size; i++) {
    level.rocket_lifter_clamps[i] linkto(level.rocket_lifter_arm);
  }
  level.rocket linkto(level.rocket_lifter_arm);
  level.rocket_lifter_arm linkto(level.rocket_lifter);
  level thread rocket_move_ready();
  level thread rocket_spotlight_init();
}
rocket_move_ready() {
  start_spot = GetStruct("rail_start_spot", "targetname");
  dock_spot = GetStruct("rail_dock_spot", "targetname");
  level.claw_arm_r MoveTo(level.claw_retract_r_pos, 0.05);
  level.claw_arm_l MoveTo(level.claw_retract_l_pos, 0.05);
  level.rocket_lifter MoveTo(start_spot.origin, 0.05);
  level.rocket_lifter waittill("movedone");
  level.rocket_lifter_arm unlink();
  level.rocket_lifter_arm RotateTo((13, 0, 0), 0.05);
  level.rocket_lifter_arm waittill("rotatedone");
  unlink_rocket_pieces();
  level waittill("power_on");
  wait(5.0);
  link_rocket_pieces();
  level.rocket_lifter_arm linkto(level.rocket_lifter);
  level.rocket_lifter MoveTo(dock_spot.origin, 10, 3, 3);
  level.rocket_lifter playSound("evt_rocket_roll");
  level.rocket_lifter waittill("movedone");
  level.rocket_lifter_arm unlink();
  rocket_move_vertical();
  unlink_rocket_pieces();
}
rocket_spotlight_init() {
  level waittill("rocket_lights_on");
  exploder(5501);
  wait(randomfloatrange(1, 2));
  exploder(5502);
  wait(randomfloatrange(1, 2));
  exploder(5503);
}
rocket_move_vertical() {
  level thread rocket_arm_sounds();
  level.rocket_lifter_arm RotateTo((90, 0, 0), 15, 3, 5);
  wait(16.0);
  level.rocket unlink();
  level.rocket MoveZ(-20, 3);
  level.claw_arm_r playSound("evt_rocket_claw_arm");
  level.claw_arm_r MoveTo(level.claw_extend_r_pos, 3.0);
  level.claw_arm_l MoveTo(level.claw_extend_l_pos, 3.0);
  level thread maps\zombie_cosmodrome_amb::play_cosmo_announcer_vox("vox_ann_rocket_anim");
  wait(3);
}
move_lifter_away() {
  start_spot = GetStruct("rail_start_spot", "targetname");
  level.rocket_lifter_arm linkto(level.rocket_lifter);
  offset = level.rocket_lifter_arm.origin - level.rocket_lifter.origin;
  level.rocket_lifter_arm unlink();
  level.rocket_lifter_arm RotateTo((0, 0, 0), 15);
  level.rocket_lifter_arm MoveTo(start_spot.origin + offset, 15, 3, 3);
  level.rocket_lifter MoveTo(start_spot.origin, 15, 3, 3);
  wait(15.0);
  claw_detach(level.claw_arm_l, "claw_l");
  claw_detach(level.claw_arm_r, "claw_r");
}
centrifuge_init() {
  level.spinner_awards = [];
  spinner_add_award(0, 5, "jackpot");
  spinner_add_award(85, 95, "double_points");
  spinner_add_award(175, 185, "zero");
  spinner_add_award(265, 275, "double_points");
  spinner_add_award(355, 359, "jackpot");
  centrifuge_trig = GetEnt("trigger_centrifuge_damage", "targetname");
  centrifuge_trap = GetEnt("rotating_trap_group1", "targetname");
  level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_CENTRIFUGE_RUMBLE = 8;
  level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_CENTRIFUGE_LIGHTS = 11;
  centrifuge_trig EnableLinkTo();
  centrifuge_trig LinkTo(centrifuge_trap);
  centrifuge_collision_brush = GetEnt("rotating_trap_collision", "targetname");
  centrifuge_collision_brush LinkTo(GetEnt(centrifuge_collision_brush.target, "targetname"));
  tip_sound_origins = getEntArray("origin_centrifuge_spinning_sound", "targetname");
  array_thread(tip_sound_origins, ::centrifuge_spinning_edge_sounds);
  flag_wait("all_players_connected");
  centrifuge_trap SetClientFlag(level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_CENTRIFUGE_LIGHTS);
  wait(4);
  centrifuge_trap RotateYaw(720, 10.0, 0.0, 4.5);
  centrifuge_trap waittill("rotatedone");
  centrifuge_trap playSound("zmb_cent_end");
  centrifuge_trap ClearClientFlag(level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_CENTRIFUGE_LIGHTS);
  level thread centrifuge_random();
}
centrifuge_activate() {
  self._trap_duration = 30;
  self._trap_cooldown_time = 60;
  centrifuge = self._trap_movers[0];
  old_angles = centrifuge.angles;
  self thread maps\_zombiemode_traps::trig_update(centrifuge);
  for(i = 0; i < self._trap_movers.size; i++) {
    self._trap_movers[i] RotateYaw(360, 5.0, 4.5);
  }
  wait(2.0);
  self thread centrifuge_damage();
  wait(3.0);
  self playLoopSound("zmb_cent_mach_loop", .6);
  step = 3.0;
  for(t = 0; t < self._trap_duration; t = t + step) {
    for(i = 0; i < self._trap_movers.size; i++) {
      self._trap_movers[i] RotateYaw(360, step);
    }
    wait(step);
  }
  end_angle = RandomInt(360);
  curr_angle = Int(centrifuge.angles[1]) % 360;
  if(end_angle < curr_angle) {
    end_angle += 360;
  }
  degrees = end_angle - curr_angle;
  if(degrees > 0) {
    time = degrees / 360 * step;
    for(i = 0; i < self._trap_movers.size; i++) {
      self._trap_movers[i] RotateYaw(degrees, time);
    }
    wait(time);
  }
  self stoploopsound(2);
  self playSound("zmb_cent_end");
  for(i = 0; i < self._trap_movers.size; i++) {
    self._trap_movers[i] RotateYaw(360, 5.0, 0.0, 4.0);
  }
  wait(5.0);
  self notify("trap_done");
  for(i = 0; i < self._trap_movers.size; i++) {
    self._trap_movers[i] RotateTo((0, end_angle % 360, 0), 1.0, 0.0, 0.9);
  }
  wait(1.0);
  self playSound("zmb_cent_lockdown");
  self notify("kill_counter_end");
}
centrifuge_random() {
  centrifuge_model = GetEnt("rotating_trap_group1", "targetname");
  centrifuge_damage_trigger = GetEnt("trigger_centrifuge_damage", "targetname");
  centrifuge_start_angles = centrifuge_model.angles;
  while(true) {
    malfunction_for_round = RandomInt(10);
    if(malfunction_for_round > 6) {
      level waittill("between_round_over");
    } else if(malfunction_for_round == 1) {
      level waittill("between_round_over");
      level waittill("between_round_over");
    }
    wait(RandomIntRange(24, 90));
    rotation_amount = RandomIntRange(3, 7) * 360;
    wait_time = RandomIntRange(4, 7);
    level centrifuge_spin_warning(centrifuge_model);
    centrifuge_model SetClientFlag(level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_CENTRIFUGE_RUMBLE);
    centrifuge_model RotateYaw(rotation_amount, wait_time, 1.0, 2.0);
    centrifuge_damage_trigger thread centrifuge_damage();
    wait(3.0);
    slow_down_moment = wait_time - 3;
    if(slow_down_moment < 0) {
      slow_down_moment = Abs(slow_down_moment);
    }
    centrifuge_model stoploopsound(4);
    centrifuge_model playSound("zmb_cent_end");
    wait(slow_down_moment);
    centrifuge_model waittill("rotatedone");
    centrifuge_damage_trigger notify("trap_done");
    centrifuge_model playSound("zmb_cent_lockdown");
    centrifuge_model ClearClientFlag(level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_CENTRIFUGE_LIGHTS);
    centrifuge_model ClearClientFlag(level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_CENTRIFUGE_RUMBLE);
  }
}
centrifuge_spin_warning(ent_centrifuge_model) {
  ent_centrifuge_model SetClientFlag(level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_CENTRIFUGE_LIGHTS);
  ent_centrifuge_model playSound("zmb_cent_alarm");
  ent_centrifuge_model playSound("vox_ann_centrifuge_spins_1");
  wait(1.0);
  ent_centrifuge_model playSound("zmb_cent_start");
  wait(2.0);
  ent_centrifuge_model playLoopSound("zmb_cent_mach_loop", .6);
  wait(1.0);
}
centrifuge_damage() {
  self endon("trap_done");
  self._trap_type = self.script_noteworthy;
  players = getplayers();
  while(1) {
    self waittill("trigger", ent);
    if(isPlayer(ent) && ent.health > 1) {
      if(ent GetStance() == "stand") {
        if(players.size == 1) {
          ent dodamage(50, ent.origin + (0, 0, 20));
          ent SetStance("crouch");
        } else {
          ent dodamage(125, ent.origin + (0, 0, 20));
          ent SetStance("crouch");
        }
      }
    } else {
      if(!isDefined(ent.marked_for_death)) {
        ent.marked_for_death = true;
        ent thread maps\_zombiemode_traps::zombie_trap_death(self, randomint(100));
        ent playSound("zmb_cent_zombie_gib");
      }
    }
  }
}
centrifuge_spinning_edge_sounds() {
  if(!isDefined(self.target)) {
    return;
  }
  self LinkTo(GetEnt(self.target, "targetname"));
  while(true) {
    flag_wait("fuge_spining");
    self playLoopSound("zmb_cent_close_loop", .5);
    flag_wait("fuge_slowdown");
    self StopLoopSound(2);
    wait(0.05);
  }
}
kill_counter() {
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] playlocalsound("zmb_laugh_child");
  }
  level.kill_counter_hud = create_counter_hud();
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
      ones = self._kill_count % 10;
    } else {
      ones = i % 10;
    }
    self.counter_1s set_counter(ones);
    if(isDefined(self.counter_10s)) {
      if(num_stages - stage_num <= 1) {
        tens = int(self._kill_count / 10);
      } else {
        tens = i % 10;
      }
      self.counter_10s set_counter(tens);
    }
    if(isDefined(self.counter_100s)) {
      if(num_stages - stage_num <= 1) {
        hundreds = int(self._kill_count / 100);
      } else {
        hundreds = i % 10;
      }
      self.counter_100s set_counter(hundreds);
    }
    level.kill_counter_hud SetValue(hundreds * 100 + tens * 10 + ones);
    wait(0.1);
  }
  self thread kill_counter_update();
  self waittill("kill_counter_end");
  level.kill_counter_hud FadeOverTime(1.0);
  level.kill_counter_hud.alpha = 0;
  wait(1.0);
  level.kill_counter_hud destroy_hud();
}
kill_counter_update() {
  self endon("kill_counter_end");
  if(!isDefined(level.kill_counter_hud)) {
    return;
  }
  while(1) {
    if(isDefined(self.counter_10s)) {
      self.counter_1s set_counter(self._kill_count % 10);
    }
    if(isDefined(self.counter_10s)) {
      self.counter_10s set_counter(int(self._kill_count / 10));
    }
    if(isDefined(self.counter_100s)) {
      self.counter_100s set_counter(int(self._kill_count / 100));
    }
    level.kill_counter_hud SetValue(self._kill_count);
    level waittill("zom_kill");
  }
}
spinner_add_award(start_angle, end_angle, prize) {
  index = level.spinner_awards.size;
  level.spinner_awards[index] = spawnStruct();
  level.spinner_awards[index].name = prize;
  level.spinner_awards[index].start_angle = start_angle;
  level.spinner_awards[index].end_angle = end_angle;
}
rocket_arm_sounds() {
  level.rocket_lifter playSound("evt_rocket_set_main");
  wait(13.8);
  level.rocket_lifter playSound("evt_rocket_set_impact");
}
door_firetrap_init() {
  flag_init("base_door_opened");
  door_trap = undefined;
  traps = getEntArray("zombie_trap", "targetname");
  for(i = 0; i < traps.size; i++) {
    if(isDefined(traps[i].script_string) && traps[i].script_string == "f2") {
      door_trap = traps[i];
      door_trap trap_set_string(&"ZOMBIE_NEED_POWER");
    }
  }
  flag_wait("power_on");
  if(!flag("base_entry_2_north_path")) {
    door_trap trap_set_string(&"ZOMBIE_COSMODROME_DOOR_CLOSED");
  }
  flag_wait("base_entry_2_north_path");
  flag_set("base_door_opened");
}
unlink_rocket_pieces() {
  claw_detach(level.claw_arm_l, "claw_l");
  claw_detach(level.claw_arm_r, "claw_r");
  rocket_pieces = getEntArray(level.rocket.target, "targetname");
  for(i = 0; i < rocket_pieces.size; i++) {
    rocket_pieces[i] unlink();
  }
  lifter_pieces = getEntArray(level.rocket_lifter.target, "targetname");
  for(i = 0; i < lifter_pieces.size; i++) {
    lifter_pieces[i] unlink();
  }
  level.rocket_lifter_clamps = getEntArray("lifter_clamp", "targetname");
  for(i = 0; i < level.rocket_lifter_clamps.size; i++) {
    level.rocket_lifter_clamps[i] unlink();
  }
}
link_rocket_pieces() {
  claw_attach(level.claw_arm_l, "claw_l");
  level.claw_arm_r = GetEnt("claw_r_arm", "targetname");
  claw_attach(level.claw_arm_r, "claw_r");
  rocket_pieces = getEntArray(level.rocket.target, "targetname");
  for(i = 0; i < rocket_pieces.size; i++) {
    rocket_pieces[i] linkto(level.rocket);
  }
  lifter_pieces = getEntArray(level.rocket_lifter.target, "targetname");
  for(i = 0; i < lifter_pieces.size; i++) {
    lifter_pieces[i] linkto(level.rocket_lifter);
  }
  level.rocket_lifter_clamps = getEntArray("lifter_clamp", "targetname");
  for(i = 0; i < level.rocket_lifter_clamps.size; i++) {
    level.rocket_lifter_clamps[i] linkto(level.rocket_lifter_arm);
  }
}