/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_background.gsc
**************************************************/

marines_background_init() {
  scripts\engine\sp\utility::array_spawn_function_targetname("background_outside_murderhole_allies", ::background_marine_handler);
  var_0 = getEntArray("intro_helicopter", "targetname");

  foreach(var_2 in var_0)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_4 = getEntArray("retreat_heli_right", "targetname");

  foreach(var_2 in var_4)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_7 = getEntArray("retreat_heli_left", "targetname");

  foreach(var_2 in var_7)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_10 = getEntArray("wolf_room_heli", "targetname");

  foreach(var_2 in var_10)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_13 = getEntArray("helis_house_stairs_window", "targetname");

  foreach(var_2 in var_13)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_16 = getEntArray("window_passby_helis", "targetname");

  foreach(var_2 in var_16)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_19 = getEntArray("heli_mosoleum_flyby", "targetname");

  foreach(var_2 in var_19)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_22 = getEntArray("flank_alley_helis", "targetname");

  foreach(var_2 in var_22)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_25 = getEntArray("helis_if_you_look_backwards", "targetname");

  foreach(var_2 in var_25)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_28 = getEntArray("streets_loop_helis", "targetname");

  foreach(var_2 in var_28)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_31 = getEntArray("helis_surround_hospital", "targetname");

  foreach(var_2 in var_31)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_34 = getEntArray("helis_convoy_overhead", "targetname");

  foreach(var_2 in var_34)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_37 = getEntArray("helis_convoy_overhead_detonated", "targetname");

  foreach(var_2 in var_37)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_40 = getEntArray("heli_civ_ambush", "targetname");

  foreach(var_2 in var_40)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_43 = getEntArray("heli_stairwell", "targetname");

  foreach(var_2 in var_43)
  var_2 scripts\engine\sp\utility::add_spawn_function(::heli_sound_handler, var_2.targetname, var_2.script_index);

  var_46 = getEntArray("background_vehicle_parking_lot_right", "targetname");

  foreach(var_48 in var_46)
  var_48 scripts\engine\sp\utility::add_spawn_function(::ground_vehicle_sound_handler);

  var_46 = getEnt("background_vehicle_parking_lot_right", "targetname");
  var_46 scripts\engine\sp\utility::add_spawn_function(::retreat_vehicle_collision_clear);
  scripts\engine\utility::flag_init("bg_parking_lot_right_shooting");
  scripts\engine\utility::flag_init("flag_groundfloor_hallway_ambush_start");
  scripts\engine\utility::flag_init("flag_marines_cleanup");
  scripts\engine\utility::flag_init("flag_upperfloor_murderhole_spawn");
  scripts\engine\utility::flag_init("flag_wolf_room_heli");
  scripts\engine\utility::flag_init("flag_wolf_roof_advance");
  scripts\engine\utility::flag_init("flag_delete_mg_house_outside_allies");
  thread bg_retreat_slaughter_magic_bullets();
  thread wolf_room_heli_manager();
}

retreat_vehicle_collision_clear() {
  waitframe();
  self delete();
}

heli_light_disable_on_spawn() {
  scripts\common\vehicle::vehicle_lights_off("running");
}

print_vehicle_info() {
  while(!isDefined(self))
    waitframe();

  var_0 = self.origin;
  var_1 = 0.0;
  var_2 = 0.0;
  var_3 = 2;
  var_4 = 0;
  var_5 = randomintrange(-100, 100);

  while(isDefined(self) && var_1 < 60) {
    wait 0.5;

    if(isDefined(self) && self.origin != var_0)
      var_2 = var_2 + 0.5;

    var_1 = var_1 + 0.5;

    if(isDefined(self))
      var_4 = distance(self.origin, level.player.origin);

    if(var_4 > 5000)
      var_3 = 8;
    else if(var_4 > 2500)
      var_3 = 5;
    else if(var_4 > 1000)
      var_3 = 3;
    else
      var_3 = 2;

    if(isDefined(self)) {}
  }
}

ground_vehicle_sound_handler() {
  waitframe();

  if(isDefined(self.targetname) && self.targetname == "assault_vehicle")
    thread assault_vehicle_sound();
  else if(isDefined(self.targetname) && self.targetname == "ied_vehicle")
    thread ied_vehicle_sound();
  else if(isDefined(self.targetname) && self.targetname == "player_vehicle")
    thread player_vehicle_sound();
  else if(isDefined(self.targetname) && self.targetname == "AQ_technical_1")
    thread aq_technical_1_sound();
  else if(isDefined(self.targetname) && self.targetname == "AQ_technical_2")
    thread aq_technical_2_sound();
  else if(isDefined(self.targetname) && self.targetname == "retreat_assault_vehicle")
    thread retreat_assault_vehicle_sound();
  else if(isDefined(self.targetname) && self.targetname == "retreat_support_apc_1")
    thread retreat_support_apc_1_sound();
  else if(isDefined(self.targetname) && self.targetname == "retreat_support_apc_2")
    thread retreat_support_apc_2_sound();
  else if(isDefined(self.targetname) && self.targetname == "wolf_background_apc_1")
    thread wolf_background_apc_1_sound();
  else if(isDefined(self.targetname) && self.targetname == "wolf_background_apc_2")
    thread wolf_background_apc_2_sound();
  else if(isDefined(self.targetname) && self.targetname == "wolf_background_apc_3")
    thread wolf_background_apc_3_sound();
  else if(isDefined(self.targetname) && self.targetname == "wolf_background_apc_4")
    thread wolf_background_apc_4_sound();
}

heli_sound_handler(var_0, var_1) {
  waitframe();

  if(isDefined(var_0) && var_0 == "intro_helicopter") {
    if(isDefined(var_1) && var_1 == 1)
      thread intro_helicopter_1();
    else if(isDefined(var_1) && var_1 == 2)
      thread intro_helicopter_2();
    else if(isDefined(var_1) && var_1 == 3)
      thread intro_helicopter_3();
  } else if(isDefined(var_0) && var_0 == "heli_mosoleum_flyby") {
    level endon("a10_approach_sound_playing");
    scripts\engine\utility::flag_wait("intro_skipped");
    thread heli_mosoleum_flyby_1();
    thread air_vehicles_distant_intro_skipped();
  } else if(isDefined(var_0) && var_0 == "helis_convoy_overhead") {
    if(isDefined(var_1) && var_1 == 1)
      thread helis_convoy_overhead_1();
    else if(isDefined(var_1) && var_1 == 2)
      thread helis_convoy_overhead_2();
  } else if(isDefined(var_0) && var_0 == "helis_convoy_overhead_detonated") {
    if(isDefined(var_1) && var_1 == 1)
      thread helis_convoy_overhead_detonated_1();
    else if(isDefined(var_1) && var_1 == 2)
      thread helis_convoy_overhead_detonated_2();
  } else if(isDefined(var_0) && var_0 == "helis_surround_hospital") {
    if(isDefined(var_1) && var_1 == 1)
      thread helis_surround_hospital_1();
    else if(isDefined(var_1) && var_1 == 2)
      thread helis_surround_hospital_2();
    else if(isDefined(var_1) && var_1 == 3)
      thread helis_surround_hospital_3();
  } else if(isDefined(var_0) && var_0 == "streets_loop_helis")
    thread streets_loop_helis_1();
  else if(isDefined(var_0) && var_0 == "flank_alley_helis") {
    if(isDefined(var_1) && var_1 == 1)
      thread flank_alley_helis_1();
    else if(isDefined(var_1) && var_1 == 2)
      thread flank_alley_helis_2();
  } else if(isDefined(var_0) && var_0 == "window_passby_helis") {
    if(isDefined(var_1) && var_1 == 1)
      thread window_passby_helis_1();
    else if(isDefined(var_1) && var_1 == 2)
      thread window_passby_helis_2();
  } else if(isDefined(var_0) && var_0 == "helis_house_stairs_window")
    thread helis_house_stairs_window_1();
  else if(isDefined(var_0) && var_0 == "helis_if_you_look_backwards")
    thread helis_if_you_look_backwards_1();
  else if(isDefined(var_0) && var_0 == "retreat_heli_right")
    thread retreat_heli_right_1();
  else if(isDefined(var_0) && var_0 == "retreat_heli_left")
    thread retreat_heli_left_1();
  else if(isDefined(var_0) && var_0 == "heli_stairwell") {
    if(isDefined(var_1) && var_1 == 1)
      thread heli_stairwell_1();
    else if(isDefined(var_1) && var_1 == 2)
      thread heli_stairwell_2();
  } else if(isDefined(var_0) && var_0 == "heli_civ_ambush") {
    self vehicle_turnengineoff();
    thread heli_civ_ambush_1();
  } else if(isDefined(var_0) && var_0 == "wolf_room_heli") {
    self vehicle_turnengineoff();
    thread wolf_room_heli_1();
  }
}

intro_helicopter_1() {
  self vehicle_turnengineoff();
}

intro_helicopter_2() {
  self vehicle_turnengineoff();
  scripts\engine\utility::delaycall(0.15, ::playsound, "mar_intro_heli_2");
}

intro_helicopter_3() {
  self vehicle_turnengineoff();
}

heli_mosoleum_flyby_1() {
  self vehicle_turnengineoff();
  self playSound("mar_mosoleum_flyby_heli");
  wait 8;
  self vehicle_turnengineon();
}

air_vehicles_distant(var_0) {
  level notify("a10_approach_sound_playing");
  var_1 = spawn("script_origin", (-1151, -6080, 550));
  var_1 scalevolume(0);
  var_1 scalepitch(0.5);
  waitframe();
  var_1 playLoopSound("mar_a10_distant_lp");
  var_1 scalevolume(1, 15);
  var_1 scalepitch(1, 15);
  var_1 moveTo((-4775, 1558, 550), 25, 8);
  playworldsound("mar_ambush_heli_by_ambient_01", level.player.origin + (0, 0, 1000));
  level.player waittill("stop_a10_approach_loop");
  var_1 moveTo((2691, 1580, 550), 3);
  var_1 scripts\engine\sp\utility::sound_fade_and_delete(8);
}

air_vehicles_distant_intro_skipped() {
  var_0 = spawn("script_origin", (-1151, -6080, 550));
  var_0 scalevolume(0);
  var_0 scalepitch(0.5);
  waitframe();
  var_0 playLoopSound("mar_a10_distant_lp");
  var_0 scalevolume(1, 7);
  var_0 scalepitch(1, 7);
  var_0 moveTo((-4775, 1558, 550), 10);
  playworldsound("mar_ambush_heli_by_ambient_01", level.player.origin + (0, 0, 1000));
  level.player waittill("stop_a10_approach_loop");
  var_0 moveTo((2691, 1580, 550), 3);
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(8);
}

helis_convoy_overhead_1() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_convoy_overhead_1");
  self scalevolume(0.251);
  waitframe();
  self scalevolume(1, 2);
}

helis_convoy_overhead_2() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_convoy_overhead_2");
  self scalevolume(0.251);
  waitframe();
  self scalevolume(1, 2);
}

helis_convoy_overhead_detonated_1() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_convoy_overhead_detonated_1");
}

helis_convoy_overhead_detonated_2() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_convoy_overhead_detonated_2");
}

helis_surround_hospital_1() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_surround_hospital_1");
  wait 5;
  playworldsound("mar_ambush_heli_by_ambient_03", (688, 367, 1000));
  wait 3;
  self vehicle_turnengineon();
}

helis_surround_hospital_2() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_surround_hospital_2");
  wait 9;
  self vehicle_turnengineon();
}

helis_surround_hospital_3() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_surround_hospital_3");
  wait 10;
  self vehicle_turnengineon();
}

streets_loop_helis_1() {
  self vehicle_turnengineoff();
  self playLoopSound("mar_streets_loop_heli");
}

flank_alley_helis_1() {
  self vehicle_turnengineoff();
  self playSound("mar_flank_alley_heli_1");
  wait 13;
  self vehicle_turnengineon();
}

flank_alley_helis_2() {
  self vehicle_turnengineoff();
  self playSound("mar_flank_alley_heli_2");
  wait 14;
  self vehicle_turnengineon();
}

window_passby_helis_1() {
  self vehicle_turnengineoff();
  self playSound("mar_window_passby_heli_1");
}

window_passby_helis_2() {
  self vehicle_turnengineoff();
  wait 2;
  self playSound("mar_window_passby_heli_2");
  wait 15;
  self vehicle_turnengineon();
}

helis_house_stairs_window_1() {
  self vehicle_turnengineoff();
  self playSound("mar_house_stairs_window_heli");
}

helis_if_you_look_backwards_1() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_if_you_look_backwards");
}

retreat_heli_right_1() {
  self scalevolume(0);
  waitframe();
  self scalevolume(1, 2);
}

retreat_heli_left_1() {
  self scalevolume(0);
  waitframe();
  self scalevolume(1, 3);
}

heli_stairwell_1() {
  self vehicle_turnengineoff();
  self playSound("mar_stairwell_heli_1");
}

heli_stairwell_2() {
  self scalevolume(0);
  waitframe();
  self scalevolume(1, 6);
  scripts\engine\utility::play_sound_in_space("mar_stairwell_heli_2", self.origin);
}

heli_civ_ambush_1() {
  self scalevolume(0);
  waitframe();
  self scalevolume(1, 2);
  self playSound("mar_heli_civ_ambush");
}

wolf_room_heli_1() {
  self vehicle_turnengineoff();
  self playSound("mar_wolf_room_heli");
}

assault_vehicle_sound() {
  self playSound("mar_assault_vehicle_pullup");
  scripts\engine\utility::flag_wait("assault_vehicle_halt");
  thread scripts\engine\utility::play_loop_sound_on_entity("mar_assault_vehicle_idle");
  scripts\engine\utility::flag_wait("convoy_commence");
  self playSound("mar_assault_vehicle_away");
  wait 1;
  thread scripts\engine\utility::stop_loop_sound_on_entity("mar_assault_vehicle_idle");
  wait 10;
  playworldsound("mar_ambush_heli_by_ambient_02", (-615, -113, 1000));
}

ied_vehicle_sound() {
  self playSound("mar_ied_vehicle_pullup");
  scripts\engine\utility::flag_wait("convoy_commence");
  self playSound("mar_ied_vehicle_away");
}

player_vehicle_sound() {
  self playSound("mar_player_vehicle_pullup");
  scripts\engine\utility::flag_wait("convoy_commence");
  self playSound("mar_player_vehicle_away");
}

aq_technical_1_sound() {
  self playSound("mar_aq_technical_1");
}

aq_technical_2_sound() {
  wait 0.7;
  self playSound("mar_aq_technical_2");
}

retreat_assault_turret() {
  self endon("death");
  self endon("stop_turret_sounds");

  if(!isDefined(self.mainturret)) {
    return;
  }
  var_0 = self.mainturret;
  var_1 = (0, 0, 0);
  var_2 = (0, 0, 0);
  var_3 = 0;

  for(;;) {
    var_4 = var_0 turretgetaim();
    var_2 = var_4 - var_1;
    var_1 = var_4;
    var_5 = var_2[1];

    if(var_5 < 0.1 && var_5 > -0.1)
      var_5 = 0.0;

    if(var_3 == 0.0 && var_5 != 0.0) {
      self playSound("mar_retreat_assault_vehicle_turret_start");
      wait 0.25;
    } else if(var_3 != 0.0 && var_5 == 0.0) {
      self playSound("mar_retreat_assault_vehicle_turret_stop");
      wait 0.25;
    }

    var_3 = var_5;
    waitframe();
  }
}

retreat_assault_vehicle_sound() {
  var_0 = spawn("script_origin", (-129, 3575, 248));
  var_0 scalevolume(0);
  waitframe();
  var_0 playLoopSound("mar_house_exit_passing_vehicles_lp");
  var_0 scalevolume(1, 5);
  self vehicle_turnengineoff();
  thread retreat_assault_turret();
  var_1 = self gettagorigin("tag_origin");
  var_2 = spawn("script_model", var_1);
  var_2 linkTo(self, "tag_origin");
  var_2 scalevolume(0);
  waitframe();
  var_2 playLoopSound("mar_retreat_assault_vehicle_whine_lp");
  waitframe();
  var_2 scalevolume(1, 4);
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(3, 1);
  thread hospital_ground_vehicle_movement_sound("mar_retreat_assault_vehicle_lp");
  var_2 scalepitch(1.1, 1);
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop");
  var_2 scalepitch(1, 1);
  thread scripts\engine\utility::play_sound_in_space("mar_retreat_assault_vehicle_stop_1", self.origin);
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_advance");
  scripts\engine\utility::play_sound_in_space("mar_retreat_assault_vehicle_start", self.origin);
  var_2 scalepitch(1.2, 3);
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop_2");
  thread scripts\engine\utility::play_sound_in_space("mar_retreat_assault_vehicle_stop_2", self.origin);
  var_2 scalepitch(0.95, 0.5);
  wait 0.5;
  scripts\engine\utility::play_sound_in_space("mar_retreat_assault_vehicle_start", self.origin);
  var_2 scalepitch(1.2, 3);
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop_3");
  var_2 scalepitch(1, 1);
  scripts\engine\utility::flag_wait("flag_retreat_advance_2");
  wait 0.4;
  var_2 scalepitch(1.2, 3);
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  wait 1;
  var_2 scripts\engine\sp\utility::sound_fade_and_delete(0.1, 1);
  self stoploopsound("mar_retreat_assault_vehicle_lp");
  scripts\engine\utility::flag_wait("flag_retreat_rooftop_cleanup");
  level notify("stop_retreat_vehicle_sounds");
}

retreat_support_apc_1_sound() {
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  thread hospital_ground_vehicle_movement_sound("mar_retreat_support_apc_1_lp", "mar_retreat_support_apc_idle_1_lp");
}

retreat_support_apc_2_sound() {
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  thread hospital_ground_vehicle_movement_sound("mar_retreat_support_apc_2_lp", "mar_retreat_support_apc_idle_2_lp");
}

hospital_ground_vehicle_movement_sound(var_0, var_1) {
  self endon("death");
  var_2 = 1;
  var_3 = 0.05;
  var_4 = 0.2;
  var_5 = self gettagorigin("tag_origin");
  var_6 = spawn("script_model", var_5);
  var_6 linkTo(self, "tag_origin");
  self scalevolume(0);
  self scalepitch(0.8);
  var_6 scalevolume(0);
  waitframe();
  self playLoopSound(var_0);

  if(isDefined(var_1))
    var_6 playLoopSound(var_1);

  while(isDefined(self)) {
    var_7 = self.veh_speed;
    clamp(var_7, 0, 5);
    var_8 = scripts\engine\math::remap(var_7, 0, 5, var_4, 1);
    var_9 = scripts\engine\math::remap(var_7, 0, 5, 0.8, 1);
    var_10 = scripts\engine\math::remap(var_7, 0, 5, 1, 0);
    var_10 = clamp(var_10, 0, 1);

    if(var_8 > var_4 && var_2 == 1) {
      self playLoopSound(var_0);
      var_2 = 0;
      var_3 = 0.5;
    }

    self scalevolume(var_8, var_3);
    self scalepitch(var_9, var_3);
    var_6 scalevolume(var_10, var_3);
    wait(var_3);

    if(var_8 <= var_4 && var_2 == 0) {
      self stoploopsound(var_0);
      var_2 = 1;
      var_3 = 0.05;
    }
  }

  var_6 stopsounds();
  waitframe();
  var_6 delete();
}

wolf_background_apc_1_sound() {
  thread hospital_ground_vehicle_movement_sound("wolf_background_apc_1_lp", "mar_wolf_background_apc_idle_1_lp");
}

wolf_background_apc_2_sound() {
  thread hospital_ground_vehicle_movement_sound("wolf_background_apc_2_lp", "mar_wolf_background_apc_idle_2_lp");
}

wolf_background_apc_3_sound() {
  thread hospital_ground_vehicle_movement_sound("wolf_background_apc_3_lp", "mar_wolf_background_apc_idle_3_lp");
}

wolf_background_apc_4_sound() {
  thread hospital_ground_vehicle_movement_sound("wolf_background_apc_4_lp", "mar_wolf_background_apc_idle_4_lp");
}

cleanup_background_city_heli() {
  scripts\common\vehicle::vehicle_lights_off("running");
  scripts\engine\utility::flag_wait("flag_groundfloor_hallway_ambush_start");

  if(isDefined(self)) {
    self scalevolume(1, 0);
    self scalevolume(0, 5);
  }

  wait 5;

  if(isDefined(self))
    self delete();
}

background_heli_turret_cleanup() {
  if(isDefined(self.mainturret))
    self.mainturret delete();
}

init_bg_tracer_fx() {
  var_0 = getEntArray("background_tracer_fx", "targetname");
  scripts\engine\utility::array_thread(var_0, ::bg_aa_trigger_tracer_fx);
}

bg_aa_trigger_tracer_fx() {
  level endon("disable_bg_tracers");
  var_0 = spawn("trigger_radius", self.origin, 16, 3000, 2500);

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1.classname != "script_vehicle_apache") {
      continue;
    }
    if(isDefined(var_1.ignore_background_tracers)) {
      continue;
    }
    bg_aa_fire_tracer_fx(var_1);
    wait 10;
  }
}

bg_aa_fire_tracer_fx(var_0) {
  var_0 endon("death");
  var_1 = randomintrange(3, 8);
  var_2 = var_0;
  var_3 = self;

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = var_2.origin + scripts\engine\utility::randomvectorrange(-200, 200) - var_3.origin;
    var_5 = vectortoangles(var_5);
    var_3 rotateTo(var_5, 0.05);
    var_6 = anglesToForward(var_3.angles);
    var_7 = anglestoup(var_3.angles);
    playFX(scripts\engine\utility::getfx("background_aa_tracer_fx"), var_3.origin, var_7, var_6);
    wait(randomfloatrange(0.25, 0.4));
  }
}

bg_retreat_slaughter_magic_bullets() {
  scripts\engine\utility::flag_wait("bg_parking_lot_right_shooting");

  for(var_0 = 0; var_0 < 30; var_0++) {
    var_1 = scripts\engine\utility::getStructArray("bg_parking_lot_right_shooting_target", "targetname");
    var_2 = scripts\engine\utility::random(var_1);
    var_3 = scripts\engine\utility::getStructArray("bg_parking_lot_right_shooting_source", "targetname");
    var_4 = scripts\engine\utility::random(var_3);
    var_5 = (0, 0, randomintrange(-10, 10));
    playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), var_4.origin, vectortoangles(var_2.origin + var_5));
    magicbullet("iw8_ar_akilo47", var_4.origin, var_2.origin + var_5);
    wait 0.1;
  }
}

wolf_room_heli_manager() {
  scripts\engine\utility::flag_wait("flag_wolf_room_heli");
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("wolf_room_heli");
  waitframe();
  var_0 scripts\common\vehicle::vehicle_lights_off("running");
}

heli_fire_magic_bullet() {
  self.mainturret delete();
  wait 2;
  var_0 = getaiarray("axis");

  while(var_0.size > 0 && isDefined(self)) {
    var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);

    if(var_0.size > 0) {
      var_1 = scripts\engine\utility::random(var_0);
      self setlookatent(var_1);
      var_2 = self.origin + (0, 0, -10);
      var_3 = var_1.origin;
      var_4 = (0, 0, randomintrange(-50, 50));
      magicbullet("iw8_la_rpapa7", var_2, var_3 + var_4);
      self clearlookatent();
      wait(randomfloatrange(0.015, 0.5));
    }

    waitframe();
    wait 5;
  }
}

wolf_balcony_apc_handler() {
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("wolf_background_apc_1", "Stormin Norman", "wolf_background_apc_1_start", 0, 0);
  var_1 = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("wolf_background_apc_2", "Sticky Treads", "wolf_background_apc_2_start", 0, 0);
  var_2 = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("wolf_background_apc_3", "Hollywood", "wolf_background_apc_3_start", 0, 0);
  var_3 = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("wolf_background_apc_4", "Beagle", "wolf_background_apc_4_start", 0, 0);
  var_0.targetname = "wolf_background_apc_1";
  var_1.targetname = "wolf_background_apc_2";
  var_2.targetname = "wolf_background_apc_3";
  var_3.targetname = "wolf_background_apc_4";
  var_0.dontdisconnectpaths = 1;
  var_1.dontdisconnectpaths = 1;
  var_2.dontdisconnectpaths = 1;
  var_3.dontdisconnectpaths = 1;
  var_0.script_badplace = 1;
  var_1.script_badplace = 1;
  var_2.script_badplace = 1;
  var_3.script_badplace = 1;
  var_0 scripts\common\vehicle_code::vehicle_remove_badplace();
  var_1 scripts\common\vehicle_code::vehicle_remove_badplace();
  var_2 scripts\common\vehicle_code::vehicle_remove_badplace();
  var_3 scripts\common\vehicle_code::vehicle_remove_badplace();
  var_0 thread ground_vehicle_sound_handler();
  var_1 thread ground_vehicle_sound_handler();
  var_2 thread ground_vehicle_sound_handler();
  var_3 thread ground_vehicle_sound_handler();
  var_4 = getspawnerarray("background_wolf_runners");
  var_5 = getspawnerarray("background_wolf_runners_aim");
  var_6 = getEnt("background_wolf_runner_aimer_target", "targetname");
  scripts\engine\utility::flag_wait("flag_wolf_roof_advance");
  var_7 = scripts\engine\sp\utility::array_spawn(var_4);
  var_8 = scripts\engine\sp\utility::array_spawn(var_5);
  thread scripts\common\vehicle_paths::gopath(var_0);
  thread scripts\common\vehicle_paths::gopath(var_1);
  thread scripts\common\vehicle_paths::gopath(var_2);
  thread scripts\common\vehicle_paths::gopath(var_3);
  wait 5;

  foreach(var_10 in var_8) {
    if(isDefined(var_10) && isalive(var_10)) {
      var_10 scripts\engine\sp\utility::enable_dontevershoot();
      var_10 setentitytarget(var_6);
      var_10.no_pistol_switch = 1;
    }
  }
}

background_marine_handler() {
  self.ignoreme = 1;
}

background_outside_murderhouse_allies_cleanup() {
  scripts\engine\utility::flag_wait("flag_delete_mg_house_outside_allies");
  var_0 = scripts\engine\sp\utility::get_living_ai_array("background_outside_murderhole_allies", "script_noteworthy");
  waitframe();

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2))
      var_2 delete();
  }
}