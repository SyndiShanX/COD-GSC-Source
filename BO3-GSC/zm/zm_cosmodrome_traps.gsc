/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_cosmodrome_traps.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\zm\_zm_traps;
#using scripts\zm\zm_cosmodrome_amb;
#namespace zm_cosmodrome_traps;

function init_traps() {
  level thread rocket_init();
  level thread centrifuge_init();
  level thread door_firetrap_init();
}

function claw_attach(arm, claw_name) {
  claws = getEntArray(claw_name, "targetname");
  for(i = 0; i < claws.size; i++) {
    claws[i] linkto(arm);
  }
}

function claw_detach(arm, claw_name) {
  claws = getEntArray(claw_name, "targetname");
  for(i = 0; i < claws.size; i++) {
    claws[i] unlink();
  }
}

function rocket_init() {
  level flag::wait_till("start_zombie_round_logic");
  wait(1);
  retract_l = struct::get("claw_l_retract", "targetname");
  retract_r = struct::get("claw_r_retract", "targetname");
  extend_l = struct::get("claw_l_extend", "targetname");
  extend_r = struct::get("claw_r_extend", "targetname");
  level.claw_retract_l_pos = retract_l.origin;
  level.claw_retract_r_pos = retract_r.origin;
  level.claw_extend_l_pos = extend_l.origin;
  level.claw_extend_r_pos = extend_r.origin;
  level.gantry_l = getent("claw_arm_l", "targetname");
  level.gantry_r = getent("claw_arm_r", "targetname");
  level.claw_arm_l = getent("claw_l_arm", "targetname");
  claw_attach(level.claw_arm_l, "claw_l");
  level.claw_arm_r = getent("claw_r_arm", "targetname");
  claw_attach(level.claw_arm_r, "claw_r");
  level.rocket = getent("zombie_rocket", "targetname");
  rocket_pieces = getEntArray(level.rocket.target, "targetname");
  for(i = 0; i < rocket_pieces.size; i++) {
    rocket_pieces[i] setforcenocull();
    rocket_pieces[i] linkto(level.rocket);
  }
  level.rocket_lifter = getent("lifter_body", "targetname");
  lifter_pieces = getEntArray(level.rocket_lifter.target, "targetname");
  for(i = 0; i < lifter_pieces.size; i++) {
    lifter_pieces[i] linkto(level.rocket_lifter);
  }
  level.rocket_lifter_arm = getent("lifter_arm", "targetname");
  level.rocket_lifter_clamps = getEntArray("lifter_clamp", "targetname");
  for(i = 0; i < level.rocket_lifter_clamps.size; i++) {
    level.rocket_lifter_clamps[i] linkto(level.rocket_lifter_arm);
  }
  level.rocket linkto(level.rocket_lifter_arm);
  level.rocket_lifter_arm linkto(level.rocket_lifter);
  level.var_be9553f1 = getent("rocket_debris", "script_noteworthy");
  level.var_be9553f1 hide();
  level thread rocket_move_ready();
}

function rocket_move_ready() {
  start_spot = struct::get("rail_start_spot", "targetname");
  dock_spot = struct::get("rail_dock_spot", "targetname");
  level.claw_arm_r moveto(level.claw_retract_r_pos, 0.05);
  level.claw_arm_l moveto(level.claw_retract_l_pos, 0.05);
  level.rocket_lifter moveto(start_spot.origin, 0.05);
  level.rocket_lifter waittill("movedone");
  level.rocket_lifter_arm unlink();
  level.rocket_lifter_arm rotateto(vectorscale((1, 0, 0), 13), 0.05);
  level.rocket_lifter_arm waittill("rotatedone");
  unlink_rocket_pieces();
  level waittill("power_on");
  wait(5);
  link_rocket_pieces();
  level.rocket_lifter_arm linkto(level.rocket_lifter);
  level.rocket_lifter moveto(dock_spot.origin, 10, 3, 3);
  level.rocket_lifter playSound("evt_rocket_roll");
  level.rocket_lifter waittill("movedone");
  level.rocket_lifter_arm unlink();
  rocket_move_vertical();
  unlink_rocket_pieces();
}

function rocket_move_vertical() {
  level thread rocket_arm_sounds();
  level.rocket_lifter_arm rotateto(vectorscale((1, 0, 0), 90), 15, 3, 5);
  wait(16);
  level.rocket unlink();
  level.rocket movez(-20, 3);
  level.claw_arm_r playSound("evt_rocket_claw_arm");
  level.claw_arm_r moveto(level.claw_extend_r_pos, 3);
  level.claw_arm_l moveto(level.claw_extend_l_pos, 3);
  level thread zm_cosmodrome_amb::play_cosmo_announcer_vox("vox_ann_rocket_anim");
  wait(3);
}

function move_lifter_away() {
  start_spot = struct::get("rail_start_spot", "targetname");
  level.rocket_lifter_arm linkto(level.rocket_lifter);
  offset = level.rocket_lifter_arm.origin - level.rocket_lifter.origin;
  level.rocket_lifter_arm unlink();
  level.rocket_lifter_arm rotateto((0, 0, 0), 15);
  level.rocket_lifter_arm moveto(start_spot.origin + offset, 15, 3, 3);
  level.rocket_lifter moveto(start_spot.origin, 15, 3, 3);
  wait(15);
  claw_detach(level.claw_arm_l, "claw_l");
  claw_detach(level.claw_arm_r, "claw_r");
}

function centrifuge_init() {
  centrifuge_trig = getent("trigger_centrifuge_damage", "targetname");
  centrifuge_trap = getent("rotating_trap_group1", "targetname");
  centrifuge_trig enablelinkto();
  centrifuge_trig linkto(centrifuge_trap);
  centrifuge_collision_brush = getent("rotating_trap_collision", "targetname");
  /
  #
  assert(isDefined(centrifuge_collision_brush.target), "");
  centrifuge_collision_brush linkto(getent(centrifuge_collision_brush.target, "targetname"));
  tip_sound_origins = getEntArray("origin_centrifuge_spinning_sound", "targetname");
  array::thread_all(tip_sound_origins, &centrifuge_spinning_edge_sounds);
  level flag::wait_till("start_zombie_round_logic");
  centrifuge_trap clientfield::set("COSMO_CENTRIFUGE_LIGHTS", 1);
  wait(4);
  centrifuge_trap rotateyaw(720, 10, 0, 4.5);
  centrifuge_trap waittill("rotatedone");
  centrifuge_trap playSound("zmb_cent_end");
  centrifuge_trap clientfield::set("COSMO_CENTRIFUGE_LIGHTS", 0);
  level thread centrifuge_random();
}

function centrifuge_activate() {
  self._trap_duration = 30;
  self._trap_cooldown_time = 60;
  if(getdvarint("") >= 1) {
    self._trap_cooldown_time = 5;
  }
  centrifuge = self._trap_movers[0];
  old_angles = centrifuge.angles;
  self thread zm_traps::trig_update(centrifuge);
  for(i = 0; i < self._trap_movers.size; i++) {
    self._trap_movers[i] rotateyaw(360, 5, 4.5);
  }
  wait(2);
  self thread centrifuge_damage();
  wait(3);
  self playLoopSound("zmb_cent_mach_loop", 0.6);
  step = 3;
  t = 0;
  while(t < self._trap_duration) {
    for(i = 0; i < self._trap_movers.size; i++) {
      self._trap_movers[i] rotateyaw(360, step);
    }
    wait(step);
    t = t + step;
  }
  end_angle = randomint(360);
  curr_angle = int(centrifuge.angles[1]) % 360;
  if(end_angle < curr_angle) {
    end_angle = end_angle + 360;
  }
  degrees = end_angle - curr_angle;
  if(degrees > 0) {
    time = (degrees / 360) * step;
    for(i = 0; i < self._trap_movers.size; i++) {
      self._trap_movers[i] rotateyaw(degrees, time);
    }
    wait(time);
  }
  self stoploopsound(2);
  self playSound("zmb_cent_end");
  for(i = 0; i < self._trap_movers.size; i++) {
    self._trap_movers[i] rotateyaw(360, 5, 0, 4);
  }
  wait(5);
  self notify("trap_done");
  for(i = 0; i < self._trap_movers.size; i++) {
    self._trap_movers[i] rotateto((0, end_angle % 360, 0), 1, 0, 0.9);
  }
  wait(1);
  self playSound("zmb_cent_lockdown");
  self notify("kill_counter_end");
}

function centrifuge_random() {
  centrifuge_model = getent("rotating_trap_group1", "targetname");
  centrifuge_damage_trigger = getent("trigger_centrifuge_damage", "targetname");
  centrifuge_start_angles = centrifuge_model.angles;
  while(true) {
    if(!isDefined(level.var_6708aa9c) || !level.var_6708aa9c) {
      malfunction_for_round = randomint(10);
      if(malfunction_for_round > 6) {
        level waittill("between_round_over");
      } else if(malfunction_for_round == 1) {
        level waittill("between_round_over");
        level waittill("between_round_over");
      }
      wait(randomintrange(24, 90));
    }
    rotation_amount = randomintrange(3, 7) * 360;
    wait_time = randomintrange(4, 7);
    level centrifuge_spin_warning(centrifuge_model);
    centrifuge_model clientfield::set("COSMO_CENTRIFUGE_RUMBLE", 1);
    centrifuge_model rotateyaw(rotation_amount, wait_time, 1, 2);
    centrifuge_damage_trigger thread centrifuge_damage();
    wait(3);
    centrifuge_model stoploopsound(4);
    centrifuge_model playSound("zmb_cent_end");
    centrifuge_model waittill("rotatedone");
    centrifuge_damage_trigger notify("trap_done");
    centrifuge_model playSound("zmb_cent_lockdown");
    centrifuge_model clientfield::set("COSMO_CENTRIFUGE_LIGHTS", 0);
    centrifuge_model clientfield::set("COSMO_CENTRIFUGE_RUMBLE", 0);
  }
}

function centrifuge_spin_warning(ent_centrifuge_model) {
  ent_centrifuge_model clientfield::set("COSMO_CENTRIFUGE_LIGHTS", 1);
  ent_centrifuge_model playSound("zmb_cent_alarm");
  ent_centrifuge_model playSound("vox_ann_centrifuge_spins_1");
  wait(1);
  ent_centrifuge_model playSound("zmb_cent_start");
  wait(2);
  ent_centrifuge_model playLoopSound("zmb_cent_mach_loop", 0.6);
  wait(1);
}

function centrifuge_damage() {
  self endon("trap_done");
  self._trap_type = self.script_noteworthy;
  players = getplayers();
  while(true) {
    self waittill("trigger", ent);
    if(isplayer(ent) && ent.health > 1) {
      if(ent getstance() == "stand") {
        if(players.size == 1) {
          ent dodamage(50, ent.origin + vectorscale((0, 0, 1), 20));
          ent setstance("crouch");
          wait(1);
        } else {
          ent dodamage(125, ent.origin + vectorscale((0, 0, 1), 20));
          ent setstance("crouch");
        }
      }
    } else if(!isDefined(ent.marked_for_death)) {
      ent.marked_for_death = 1;
      ent thread zm_traps::zombie_trap_death(self, randomint(100));
      ent playSound("zmb_cent_zombie_gib");
    }
  }
}

function centrifuge_spinning_edge_sounds() {
  /
  #
  assert(isDefined(self.target), "");
  if(!isDefined(self.target)) {
    return;
  }
  self linkto(getent(self.target, "targetname"));
  while(true) {
    level flag::wait_till("fuge_spining");
    self playLoopSound("zmb_cent_close_loop", 0.5);
    level flag::wait_till("fuge_slowdown");
    self stoploopsound(2);
    wait(0.05);
  }
}

function rocket_arm_sounds() {
  level.rocket_lifter playSound("evt_rocket_set_main");
  wait(13.8);
  level.rocket_lifter playSound("evt_rocket_set_impact");
}

function door_firetrap_init() {
  level flag::init("base_door_opened");
  door_trap = undefined;
  traps = getEntArray("zombie_trap", "targetname");
  for(i = 0; i < traps.size; i++) {
    if(isDefined(traps[i].script_string) && traps[i].script_string == "f2") {
      door_trap = traps[i];
      door_trap zm_traps::trap_set_string(&"ZOMBIE_NEED_POWER");
    }
  }
  level flag::wait_till("power_on");
  if(!level flag::get("base_entry_2_north_path")) {
    door_trap zm_traps::trap_set_string(&"ZM_COSMODROME_DOOR_CLOSED");
  }
  level flag::wait_till("base_entry_2_north_path");
  level flag::set("base_door_opened");
}

function unlink_rocket_pieces() {
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

function link_rocket_pieces() {
  claw_attach(level.claw_arm_l, "claw_l");
  level.claw_arm_r = getent("claw_r_arm", "targetname");
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