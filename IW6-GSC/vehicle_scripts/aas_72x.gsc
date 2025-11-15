/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\aas_72x.gsc
***************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("aas_72x", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_aas_72x");
  main_common(var_0, var_1, var_2);
  maps\_vehicle::build_deathfx("fx/explosions/helicopter_explosion_secondary_small", "tag_engine_right", "aascout72x_helicopter_secondary_exp", undefined, undefined, undefined, 0.0, 1, undefined);
  maps\_vehicle::build_deathfx("fx/explosions/helicopter_explosion_secondary_small", "tag_engine_left", "aascout72x_helicopter_dying_loop", 1, 1.5, 1, 0.5, 1, undefined);
  maps\_vehicle::build_deathfx("fx/explosions/helicopter_explosion_secondary_small", "tag_engine_right", undefined, 1, 2.25, undefined, 5.0, 1, undefined);
  maps\_vehicle::build_deathfx("fx/explosions/helicopter_explosion_little_bird", undefined, "aascout72x_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::build_deathfx("fx/fire/fire_smoke_trail_L", "tail_rotor_jnt", undefined, 1, 0.05, undefined, 0.5, 1, undefined);
  maps\_vehicle::build_deathfx("fx/explosions/helicopter_explosion_secondary_small", "tail_rotor_jnt", undefined, undefined, undefined, undefined, 0.5, 1, undefined);
  maps\_vehicle::build_rocket_deathfx("fx/explosions/helicopter_explosion_little_bird_dcburn", "tag_deathfx", "aascout72x_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  maps\_vehicle::build_rider_death_func(::handle_rider_death);
  main_common(var_0, var_1, var_2);
}

#using_animtree("vehicles");

main_common(var_0, var_1, var_2) {
  maps\_vehicle::build_drive( % mi28_rotors, undefined, 0, 3.0);
  maps\_vehicle::build_deathquake(0.8, 1.6, 2048);
  maps\_vehicle::build_life(3000, 2800, 3100);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_mainturret();
  maps\_vehicle::build_unload_groups(::unload_groups);
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_light(var_2, "red_blink1", "TAG_LIGHT_TAIL1", "fx/misc/aircraft_light_red_blink_occ", "running");
  maps\_vehicle::build_light(var_2, "red_blink2", "TAG_LIGHT_TAIL2", "fx/misc/aircraft_light_red_blink_occ", "running");
  maps\_vehicle::build_treadfx(var_2, "default", "vfx/gameplay/tread_fx/vfx_heli_dust_sand", 1);
  maps\_vehicle::build_treadfx(var_2, "sand", "vfx/gameplay/tread_fx/vfx_heli_dust_sand", 1);

  if(isDefined(var_1) && var_1 == "aas_72x_nonheli")
    maps\_vehicle::build_is_airplane();
  else
    maps\_vehicle::build_is_helicopter();
}

init_local() {
  self endon("death");
  self.dropoff_height = 270;
  self.originheightoffset = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  self.script_badplace = 0;
  self.dontdisconnectpaths = 1;
  self.vehicle_loaded_notify_size = 6;
  self.deathanims = get_deathanims();
  maps\_vehicle::aircraft_wash();
  thread maps\_vehicle::vehicle_lights_on("running");
}

handle_rider_death() {
  if(isDefined(self.shooters)) {
    foreach(var_1 in self.shooters) {
      if(!isDefined(var_1) || !isalive(var_1)) {
        continue;
      }
      var_1 thread shooter_death(self);
    }
  }

  foreach(var_4 in self.riders) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4.vehicle_position > 1) {
      continue;
    }
    var_4 notify("newanim");
    thread maps\_vehicle_aianim::guy_idle(var_4, var_4.vehicle_position);
  }

  self waittill("crash_done");
  common_scripts\utility::array_call(self.riders, ::delete);
}

shooter_death(var_0) {
  var_0 endon("crash_done");
  self endon("death");
  var_1 = randomfloatrange(2, 15);
  wait(var_1);

  if(isDefined(self))
    self kill();
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].sittag = "tag_pilot1";
  var_0[0].bhasgunwhileriding = 0;
  var_0[0].idle[0] = % aas_72x_pilot_idle;
  var_0[0].idleoccurrence[0] = 500;
  var_0[1].sittag = "tag_pilot2";
  var_0[1].bhasgunwhileriding = 0;
  var_0[1].idle[0] = % aas_72x_copilot_idle;
  var_0[1].idleoccurrence[0] = 450;
  var_0[2].sittag = "tag_guy1";
  var_0[2].getout = % aas_72x_jumpout_front_r;
  var_0[3].sittag = "tag_guy2";
  var_0[3].getout = % aas_72x_jumpout_rear_r;
  var_0[4].sittag = "tag_guy3";
  var_0[4].getout = % aas_72x_jumpout_front_l;
  var_0[5].sittag = "tag_guy4";
  var_0[5].getout = % aas_72x_jumpout_rear_l;

  for(var_1 = 2; var_1 < 6; var_1++) {
    var_0[var_1].linktoblend = 1;
    var_0[var_1].rider_func = ::init_shooter;
  }

  return var_0;
}

get_deathanims() {
  var_0 = [ % aas_72x_seated_death_a_1, % aas_72x_seated_death_a_5, % aas_72x_seated_death_a_10, % aas_72x_seated_death_a_11, % aas_72x_seated_death_a_12];
  return common_scripts\utility::array_randomize(var_0);
}

unload_groups() {
  var_0 = [];
  var_0["first_guy_left"] = [];
  var_0["first_guy_right"] = [];
  var_0["left"] = [];
  var_0["right"] = [];
  var_0["passengers"] = [];
  var_0["default"] = [];
  var_0["first_guy_left"][0] = 3;
  var_0["first_guy_right"][0] = 2;
  var_0["stage_guy_left"][0] = 3;
  var_0["stage_guy_right"][0] = 2;
  var_0["right"][var_0["right"].size] = 2;
  var_0["right"][var_0["right"].size] = 3;
  var_0["left"][var_0["left"].size] = 4;
  var_0["left"][var_0["left"].size] = 5;
  var_0["passengers"][var_0["passengers"].size] = 2;
  var_0["passengers"][var_0["passengers"].size] = 3;
  var_0["passengers"][var_0["passengers"].size] = 4;
  var_0["passengers"][var_0["passengers"].size] = 5;
  var_0["default"] = var_0["passengers"];
  return var_0;
}

set_vehicle_anims(var_0) {
  return var_0;
}

init_shooter() {
  if(isDefined(self.script_drone)) {
    init_drone();
    return;
  }

  if(!isDefined(self.ridingvehicle.shooters))
    self.ridingvehicle.shooters = [];

  self.ridingvehicle.shooters[self.ridingvehicle.shooters.size] = self;
  self.custom_animscript["combat"] = ::shooter_animscript;
  self.custom_animscript["stop"] = ::shooter_animscript;
  self.getoffvehiclefunc = ::shooter_unload;
}

init_drone() {
  var_0 = get_idle_anim(self.vehicle_position);
  self setanimknob(var_0, 1, 0);
}

shooter_unload() {
  self.current_event = undefined;
  self.custom_animscript = undefined;
  self.allowpain = 1;
  self.a.pose = "stand";
  self.grenadeawareness = 0.2;
  self.deathanim = undefined;
  maps\_utility::enable_surprise();

  if(!isDefined(self.delay))
    self.delay = randomfloat(0.75);

  wait(self.delay);
  self.delay = undefined;
  var_0 = get_unload_anim();
  var_1 = getanimlength(var_0) * 0.3;
  thread maps\_utility::notify_delay("jumpedout", var_1);
  common_scripts\utility::delaycall(0.25, ::unlink);

  if(isDefined(self.ridingvehicle.quick_getout) && self.ridingvehicle.quick_getout) {
    var_1 = get_short_getout_time();
    common_scripts\utility::delaycall(var_1, ::stopanimscripted);
    thread maps\_utility::notify_delay("quick_getout_end", var_1);
  }
}

get_short_getout_time() {
  var_0 = self.vehicle_position;

  if(var_0 == 2 || var_0 == 3)
    return 1.7;

  if(var_0 == 4 || var_0 == 5)
    return 2.1;

  return undefined;
}

get_unload_anim() {
  return level.vehicle_aianims[self.ridingvehicle.classname][self.vehicle_position].getout;
}

shooter_animscript() {
  self endon("death");
  self endon("killanimscript");
  self.current_event = "none";
  self.rightaimlimit = 77;
  self.leftaimlimit = -57;
  self.grenadeawareness = 0;
  self.a.pose = "crouch";
  maps\_utility::disable_surprise();
  self.allowpain = 0;
  init_shooter_anims();
  animscripts\track::setanimaimweight(1, 0.2);
  thread shooter_tracking();
  thread shooter_shooting();
  event_thread();
}

get_idle_anim(var_0) {
  var_1 = undefined;

  switch (self.vehicle_position) {
    case 2:
      var_1 = % aas_72x_guy1_idle;
      break;
    case 3:
      var_1 = % aas_72x_guy2_idle;
      break;
    case 4:
      var_1 = % aas_72x_guy3_idle;
      break;
    case 5:
      var_1 = % aas_72x_guy4_idle;
      break;
  }

  return var_1;
}

get_straight_level_anim(var_0) {
  var_1 = undefined;

  switch (self.vehicle_position) {
    case 2:
      var_1 = % aas_72x_guy1_aim_5;
      break;
    case 3:
      var_1 = % aas_72x_guy1_aim_5_rear;
      break;
    case 4:
      var_1 = % aas_72x_guy1_aim_5;
      break;
    case 5:
      var_1 = % aas_72x_guy1_aim_5_rear;
      break;
  }

  return var_1;
}

init_shooter_anims() {
  self.a.array = [];
  self.a.array["idle"] = get_idle_anim(self.vehicle_position);
  self.a.array["add_aim_up"] = % aas_72x_guy1_aim_8;
  self.a.array["add_aim_down"] = % aas_72x_guy1_aim_2;
  self.a.array["add_aim_left"] = % aas_72x_guy1_aim_4;
  self.a.array["add_aim_right"] = % aas_72x_guy1_aim_6;
  self.a.array["straight_level"] = get_straight_level_anim(self.vehicle_position);
  self.a.array["burst2"] = % exposed_crouch_shoot_burst3;
  self.a.array["burst3"] = % exposed_crouch_shoot_burst3;
  self.a.array["burst4"] = % exposed_crouch_shoot_burst4;
  self.a.array["burst5"] = % exposed_crouch_shoot_burst5;
  self.a.array["burst6"] = % exposed_crouch_shoot_burst6;
  self.a.array["semi2"] = % exposed_crouch_shoot_semi2;
  self.a.array["semi3"] = % exposed_crouch_shoot_semi3;
  self.a.array["semi4"] = % exposed_crouch_shoot_semi4;
  self.a.array["semi5"] = % exposed_crouch_shoot_semi5;
  self.a.array["fire"] = % exposed_crouch_shoot_auto_v2;
  self.a.array["single"] = [ % exposed_crouch_shoot_semi1];
  self.a.array["reload"] = [ % exposed_crouch_reload];
  self.deathanim = self.ridingvehicle.deathanims[self.vehicle_position - 2];
}

event_thread() {
  self endon("death");
  self endon("killanimscript");
  var_0 = self.ridingvehicle;

  for(;;)
    var_0 waittill("start_event", var_1);
}

shooter_shooting() {
  self endon("death");
  self endon("killanimscript");
  var_0 = 0.05;

  for(;;) {
    wait 0.05;

    if(!isDefined(self.current_event)) {
      continue;
    }
    if(self.current_event != "none") {
      self waittill("event_finished");
      continue;
    }

    if(animscripts\combat_utility::needtoreload(0)) {
      animscripts\combat_utility::endfireandanimidlethread();
      var_1 = animscripts\utility::animarraypickrandom("reload");
      animscripts\combat::doreloadanim(var_1, 0);
      self notify("abort_reload");
      thread shooter_tracking();
      continue;
    }

    shoot_behavior();

    if(isplayer(self.enemy))
      self updateplayersightaccuracy();
  }
}

shoot_behavior() {
  thread animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
  animscripts\combat_utility::shootuntilshootbehaviorchange();
}

shooter_tracking() {
  self endon("death");
  self endon("killanimscript");
  self notify("stop tracking");
  self endon("stop tracking");
  var_0 = 0.2;
  self clearanim( % root, var_0);
  self setanimknob(self.a.array["idle"], 1, 0);
  self setanimknoblimited(animscripts\utility::animarray("straight_level"), 1, var_0);
  self setanimknoblimited(animscripts\utility::animarray("add_aim_up"), 1, var_0);
  self setanimknoblimited(animscripts\utility::animarray("add_aim_down"), 1, var_0);
  self setanimknoblimited(animscripts\utility::animarray("add_aim_left"), 1, var_0);
  self setanimknoblimited(animscripts\utility::animarray("add_aim_right"), 1, var_0);
  var_1 = % aas72x_aim_2;
  var_2 = % aas72x_aim_4;
  var_3 = % aas72x_aim_6;
  var_4 = % aas72x_aim_8;
  animscripts\track::trackloop(var_1, var_2, var_3, var_4);
}

#using_animtree("vehicles");

chopper_lean(var_0) {
  self endon("stop_player_lean");
  var_1 = 1.0;
  var_2 = 110;
  var_3 = 110;
  var_4 = 30;
  var_5 = 60;
  self playerlinktodelta(var_0, "tag_rider", var_1, var_2, var_3, var_4, var_5);
  var_6 = % vegas_player_littlebird_lean_out_b;
  var_7 = % vegas_player_littlebird_lean_in_b;
  var_8 = 0;
  var_9 = 0;
  var_10 = 110;
  var_11 = 0;

  for(;;) {
    wait 0.05;
    var_12 = self.angles[1] - var_0.angles[1] - 90;
    var_12 = angleclamp180(var_12);
    var_13 = abs(var_12 / var_10);
    var_13 = min(var_13, 1);

    if(abs(var_11 - var_13) < 0.001) {
      var_0 setanim(var_6, 1, 0.2, 0);
      continue;
    }

    if(var_13 > var_11) {
      var_6 = % vegas_player_littlebird_lean_out_b;
      var_8 = var_13;
    } else {
      var_6 = % vegas_player_littlebird_lean_in_b;
      var_8 = 1 - var_13;
    }

    if(var_6 != var_7)
      var_0 clearanim(var_7, 0);

    var_0 setanim(var_6, 1, 0, 0.5);
    var_0 setanimtime(var_6, var_8);
    var_7 = var_6;
    var_11 = var_13;
    var_9 = var_8;
  }
}

stop_chopper_lean() {
  self notify("stop_player_lean");
}