/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\marines\marines_background.gsc
**********************************************************/

function marines_background_init() {
  scripts\engine\sp\utility::array_spawn_function_targetname("background_outside_murderhole_allies", &background_marine_handler);
  var0 = getEntArray("intro_helicopter", "targetname");

  foreach(var2 in var0) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var4 = getEntArray("retreat_heli_right", "targetname");

  foreach(var2 in var4) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var7 = getEntArray("retreat_heli_left", "targetname");

  foreach(var2 in var7) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var10 = getEntArray("wolf_room_heli", "targetname");

  foreach(var2 in var10) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var13 = getEntArray("helis_house_stairs_window", "targetname");

  foreach(var2 in var13) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var16 = getEntArray("window_passby_helis", "targetname");

  foreach(var2 in var16) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var19 = getEntArray("heli_mosoleum_flyby", "targetname");

  foreach(var2 in var19) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var22 = getEntArray("flank_alley_helis", "targetname");

  foreach(var2 in var22) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var25 = getEntArray("helis_if_you_look_backwards", "targetname");

  foreach(var2 in var25) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var28 = getEntArray("streets_loop_helis", "targetname");

  foreach(var2 in var28) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var31 = getEntArray("helis_surround_hospital", "targetname");

  foreach(var2 in var31) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var34 = getEntArray("helis_convoy_overhead", "targetname");

  foreach(var2 in var34) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var37 = getEntArray("helis_convoy_overhead_detonated", "targetname");

  foreach(var2 in var37) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var40 = getEntArray("heli_civ_ambush", "targetname");

  foreach(var2 in var40) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var43 = getEntArray("heli_stairwell", "targetname");

  foreach(var2 in var43) {
    var2 scripts\engine\sp\utility::add_spawn_function(&heli_sound_handler, var2.targetname, var2.script_index);
  }

  var46 = getEntArray("background_vehicle_parking_lot_right", "targetname");

  foreach(var48 in var46) {
    var48 scripts\engine\sp\utility::add_spawn_function(&ground_vehicle_sound_handler);
  }

  var46 = getEnt("background_vehicle_parking_lot_right", "targetname");
  var46 scripts\engine\sp\utility::add_spawn_function(&retreat_vehicle_collision_clear);
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

function retreat_vehicle_collision_clear() {
  waitframe();
  self delete();
}

function heli_light_disable_on_spawn() {
  scripts\common\vehicle::vehicle_lights_off("running");
}

function print_vehicle_info() {
  while(!isDefined(self)) {
    waitframe();
  }

  var0 = self.origin;
  var1 = 0;
  var2 = 0;
  var3 = 2;
  var4 = 0;
  var5 = randomintrange(-100, 100);

  while(isDefined(self) && var1 < 60) {
    wait 0.5;

    if(isDefined(self) && self.origin != var0) {
      var2 += 0.5;
    }

    var1 += 0.5;

    if(isDefined(self)) {
      var4 = distance(self.origin, level.player.origin);
    }

    if(var4 > 5000) {
      var3 = 8;
    } else if(var4 > 2500) {
      var3 = 5;
    } else if(var4 > 1000) {
      var3 = 3;
    } else {
      var3 = 2;
    }

    if(isDefined(self)) {}
  }
}

function ground_vehicle_sound_handler() {
  waitframe();

  if(isDefined(self.targetname) && self.targetname == "assault_vehicle") {
    thread assault_vehicle_sound();
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "ied_vehicle") {
    thread ied_vehicle_sound();
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "player_vehicle") {
    thread player_vehicle_sound();
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "AQ_technical_1") {
    thread aq_technical_1_sound();
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "AQ_technical_2") {
    thread aq_technical_2_sound();
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "retreat_assault_vehicle") {
    thread retreat_assault_vehicle_sound();
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "retreat_support_apc_1") {
    thread retreat_support_apc_1_sound();
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "retreat_support_apc_2") {
    thread retreat_support_apc_2_sound();
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "wolf_background_apc_1") {
    thread wolf_background_apc_1_sound();
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "wolf_background_apc_2") {
    thread wolf_background_apc_2_sound();
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "wolf_background_apc_3") {
    thread wolf_background_apc_3_sound();
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "wolf_background_apc_4") {
    thread wolf_background_apc_4_sound();
    return;
  }
}

function heli_sound_handler(var0, var1) {
  waitframe();

  if(isDefined(var0) && var0 == "intro_helicopter") {
    if(isDefined(var1) && var1 == 1) {
      thread intro_helicopter_1();
      return;
    }

    if(isDefined(var1) && var1 == 2) {
      thread intro_helicopter_2();
      return;
    }

    if(isDefined(var1) && var1 == 3) {
      thread intro_helicopter_3();
      return;
    }

    return;
  }

  if(isDefined(var0) && var0 == "heli_mosoleum_flyby") {
    level endon("a10_approach_sound_playing");
    scripts\engine\utility::flag_wait("intro_skipped");
    thread heli_mosoleum_flyby_1();
    thread air_vehicles_distant_intro_skipped();
    return;
  }

  if(isDefined(var0) && var0 == "helis_convoy_overhead") {
    if(isDefined(var1) && var1 == 1) {
      thread helis_convoy_overhead_1();
      return;
    }

    if(isDefined(var1) && var1 == 2) {
      thread helis_convoy_overhead_2();
      return;
    }

    return;
  }

  if(isDefined(var0) && var0 == "helis_convoy_overhead_detonated") {
    if(isDefined(var1) && var1 == 1) {
      thread helis_convoy_overhead_detonated_1();
      return;
    }

    if(isDefined(var1) && var1 == 2) {
      thread helis_convoy_overhead_detonated_2();
      return;
    }

    return;
  }

  if(isDefined(var0) && var0 == "helis_surround_hospital") {
    if(isDefined(var1) && var1 == 1) {
      thread helis_surround_hospital_1();
      return;
    }

    if(isDefined(var1) && var1 == 2) {
      thread helis_surround_hospital_2();
      return;
    }

    if(isDefined(var1) && var1 == 3) {
      thread helis_surround_hospital_3();
      return;
    }

    return;
  }

  if(isDefined(var0) && var0 == "streets_loop_helis") {
    thread streets_loop_helis_1();
    return;
  }

  if(isDefined(var0) && var0 == "flank_alley_helis") {
    if(isDefined(var1) && var1 == 1) {
      thread flank_alley_helis_1();
      return;
    }

    if(isDefined(var1) && var1 == 2) {
      thread flank_alley_helis_2();
      return;
    }

    return;
  }

  if(isDefined(var0) && var0 == "window_passby_helis") {
    if(isDefined(var1) && var1 == 1) {
      thread window_passby_helis_1();
      return;
    }

    if(isDefined(var1) && var1 == 2) {
      thread window_passby_helis_2();
      return;
    }

    return;
  }

  if(isDefined(var0) && var0 == "helis_house_stairs_window") {
    thread helis_house_stairs_window_1();
    return;
  }

  if(isDefined(var0) && var0 == "helis_if_you_look_backwards") {
    thread helis_if_you_look_backwards_1();
    return;
  }

  if(isDefined(var0) && var0 == "retreat_heli_right") {
    thread retreat_heli_right_1();
    return;
  }

  if(isDefined(var0) && var0 == "retreat_heli_left") {
    thread retreat_heli_left_1();
    return;
  }

  if(isDefined(var0) && var0 == "heli_stairwell") {
    if(isDefined(var1) && var1 == 1) {
      thread heli_stairwell_1();
      return;
    }

    if(isDefined(var1) && var1 == 2) {
      thread heli_stairwell_2();
      return;
    }

    return;
  }

  if(isDefined(var0) && var0 == "heli_civ_ambush") {
    self vehicle_turnengineoff();
    thread heli_civ_ambush_1();
    return;
  }

  if(isDefined(var0) && var0 == "wolf_room_heli") {
    self vehicle_turnengineoff();
    thread wolf_room_heli_1();
    return;
  }
}

function intro_helicopter_1() {
  self vehicle_turnengineoff();
}

function intro_helicopter_2() {
  self vehicle_turnengineoff();
  scripts\engine\utility::delaycall(0.15, &playsound, "mar_intro_heli_2");
}

function intro_helicopter_3() {
  self vehicle_turnengineoff();
}

function heli_mosoleum_flyby_1() {
  self vehicle_turnengineoff();
  self playSound("mar_mosoleum_flyby_heli");
  wait 8;
  self vehicle_turnengineon();
}

function air_vehicles_distant(var0) {
  level notify("a10_approach_sound_playing");
  var1 = spawn("script_origin", (-1151, -6080, 550));
  var1 scalevolume(0);
  var1 scalepitch(0.5);
  waitframe();
  var1 playLoopSound("mar_a10_distant_lp");
  var1 scalevolume(1, 15);
  var1 scalepitch(1, 15);
  var1 moveTo((-4775, 1558, 550), 25, 8);
  playworldsound("mar_ambush_heli_by_ambient_01", level.player.origin + (0, 0, 1000));
  level.player waittill("stop_a10_approach_loop");
  var1 moveTo((2691, 1580, 550), 3);
  var1 scripts\engine\sp\utility::sound_fade_and_delete(8);
}

function air_vehicles_distant_intro_skipped() {
  var0 = spawn("script_origin", (-1151, -6080, 550));
  var0 scalevolume(0);
  var0 scalepitch(0.5);
  waitframe();
  var0 playLoopSound("mar_a10_distant_lp");
  var0 scalevolume(1, 7);
  var0 scalepitch(1, 7);
  var0 moveTo((-4775, 1558, 550), 10);
  playworldsound("mar_ambush_heli_by_ambient_01", level.player.origin + (0, 0, 1000));
  level.player waittill("stop_a10_approach_loop");
  var0 moveTo((2691, 1580, 550), 3);
  var0 scripts\engine\sp\utility::sound_fade_and_delete(8);
}

function helis_convoy_overhead_1() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_convoy_overhead_1");
  self scalevolume(0.251);
  waitframe();
  self scalevolume(1, 2);
}

function helis_convoy_overhead_2() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_convoy_overhead_2");
  self scalevolume(0.251);
  waitframe();
  self scalevolume(1, 2);
}

function helis_convoy_overhead_detonated_1() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_convoy_overhead_detonated_1");
}

function helis_convoy_overhead_detonated_2() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_convoy_overhead_detonated_2");
}

function helis_surround_hospital_1() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_surround_hospital_1");
  wait 5;
  playworldsound("mar_ambush_heli_by_ambient_03", (688, 367, 1000));
  wait 3;
  self vehicle_turnengineon();
}

function helis_surround_hospital_2() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_surround_hospital_2");
  wait 9;
  self vehicle_turnengineon();
}

function helis_surround_hospital_3() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_surround_hospital_3");
  wait 10;
  self vehicle_turnengineon();
}

function streets_loop_helis_1() {
  self vehicle_turnengineoff();
  self playLoopSound("mar_streets_loop_heli");
}

function flank_alley_helis_1() {
  self vehicle_turnengineoff();
  self playSound("mar_flank_alley_heli_1");
  wait 13;
  self vehicle_turnengineon();
}

function flank_alley_helis_2() {
  self vehicle_turnengineoff();
  self playSound("mar_flank_alley_heli_2");
  wait 14;
  self vehicle_turnengineon();
}

function window_passby_helis_1() {
  self vehicle_turnengineoff();
  self playSound("mar_window_passby_heli_1");
}

function window_passby_helis_2() {
  self vehicle_turnengineoff();
  wait 2;
  self playSound("mar_window_passby_heli_2");
  wait 15;
  self vehicle_turnengineon();
}

function helis_house_stairs_window_1() {
  self vehicle_turnengineoff();
  self playSound("mar_house_stairs_window_heli");
}

function helis_if_you_look_backwards_1() {
  self vehicle_turnengineoff();
  self playSound("mar_heli_if_you_look_backwards");
}

function retreat_heli_right_1() {
  self scalevolume(0);
  waitframe();
  self scalevolume(1, 2);
}

function retreat_heli_left_1() {
  self scalevolume(0);
  waitframe();
  self scalevolume(1, 3);
}

function heli_stairwell_1() {
  self vehicle_turnengineoff();
  self playSound("mar_stairwell_heli_1");
}

function heli_stairwell_2() {
  self scalevolume(0);
  waitframe();
  self scalevolume(1, 6);
  scripts\engine\utility::play_sound_in_space("mar_stairwell_heli_2", self.origin);
}

function heli_civ_ambush_1() {
  self scalevolume(0);
  waitframe();
  self scalevolume(1, 2);
  self playSound("mar_heli_civ_ambush");
}

function wolf_room_heli_1() {
  self vehicle_turnengineoff();
  self playSound("mar_wolf_room_heli");
}

function assault_vehicle_sound() {
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

function ied_vehicle_sound() {
  self playSound("mar_ied_vehicle_pullup");
  scripts\engine\utility::flag_wait("convoy_commence");
  self playSound("mar_ied_vehicle_away");
}

function player_vehicle_sound() {
  self playSound("mar_player_vehicle_pullup");
  scripts\engine\utility::flag_wait("convoy_commence");
  self playSound("mar_player_vehicle_away");
}

function aq_technical_1_sound() {
  self playSound("mar_aq_technical_1");
}

function aq_technical_2_sound() {
  wait 0.7;
  self playSound("mar_aq_technical_2");
}

function retreat_assault_turret() {
  self endon("death");
  self endon("stop_turret_sounds");

  if(!isDefined(self.mainturret)) {
    return;
  }

  var0 = self.mainturret;
  var1 = (0, 0, 0);
  var2 = (0, 0, 0);
  var3 = 0;

  for(;;) {
    var4 = var0 turretgetaim();
    var2 = var4 - var1;
    var1 = var4;
    var5 = var2[1];

    if(var5 < 0.1 && var5 > -0.1) {
      var5 = 0;
    }

    if(var3 == 0 && var5 != 0) {
      self playSound("mar_retreat_assault_vehicle_turret_start");
      wait 0.25;
    } else if(var3 != 0 && var5 == 0) {
      self playSound("mar_retreat_assault_vehicle_turret_stop");
      wait 0.25;
    }

    var3 = var5;
    waitframe();
  }
}

function retreat_assault_vehicle_sound() {
  var0 = spawn("script_origin", (-129, 3575, 248));
  var0 scalevolume(0);
  waitframe();
  var0 playLoopSound("mar_house_exit_passing_vehicles_lp");
  var0 scalevolume(1, 5);
  self vehicle_turnengineoff();
  thread retreat_assault_turret();
  var1 = self gettagorigin("tag_origin");
  var2 = spawn("script_model", var1);
  var2 linkTo(self, "tag_origin");
  var2 scalevolume(0);
  waitframe();
  var2 playLoopSound("mar_retreat_assault_vehicle_whine_lp");
  waitframe();
  var2 scalevolume(1, 4);
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  var0 scripts\engine\sp\utility::sound_fade_and_delete(3, 1);
  thread hospital_ground_vehicle_movement_sound("mar_retreat_assault_vehicle_lp");
  var2 scalepitch(1.1, 1);
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop");
  var2 scalepitch(1, 1);
  thread scripts\engine\utility::play_sound_in_space("mar_retreat_assault_vehicle_stop_1", self.origin);
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_advance");
  scripts\engine\utility::play_sound_in_space("mar_retreat_assault_vehicle_start", self.origin);
  var2 scalepitch(1.2, 3);
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop_2");
  thread scripts\engine\utility::play_sound_in_space("mar_retreat_assault_vehicle_stop_2", self.origin);
  var2 scalepitch(0.95, 0.5);
  wait 0.5;
  scripts\engine\utility::play_sound_in_space("mar_retreat_assault_vehicle_start", self.origin);
  var2 scalepitch(1.2, 3);
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop_3");
  var2 scalepitch(1, 1);
  scripts\engine\utility::flag_wait("flag_retreat_advance_2");
  wait 0.4;
  var2 scalepitch(1.2, 3);
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  wait 1;
  var2 scripts\engine\sp\utility::sound_fade_and_delete(0.1, 1);
  self stoploopsound("mar_retreat_assault_vehicle_lp");
  scripts\engine\utility::flag_wait("flag_retreat_rooftop_cleanup");
  level notify("stop_retreat_vehicle_sounds");
}

function retreat_support_apc_1_sound() {
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  thread hospital_ground_vehicle_movement_sound("mar_retreat_support_apc_1_lp", "mar_retreat_support_apc_idle_1_lp");
}

function retreat_support_apc_2_sound() {
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  thread hospital_ground_vehicle_movement_sound("mar_retreat_support_apc_2_lp", "mar_retreat_support_apc_idle_2_lp");
}

function hospital_ground_vehicle_movement_sound(var0, var1) {
  self endon("death");
  var2 = 1;
  var3 = 0.05;
  var4 = 0.2;
  var5 = self gettagorigin("tag_origin");
  var6 = spawn("script_model", var5);
  var6 linkTo(self, "tag_origin");
  self scalevolume(0);
  self scalepitch(0.8);
  var6 scalevolume(0);
  waitframe();
  self playLoopSound(var0);
  jumpiffalse(isDefined(var1)) LOC_00000067;
  var6 playLoopSound(var1);

  while(isDefined(self)) {
    var7 = self.veh_speed;
    clamp(var7, 0, 5);
    var8 = scripts\engine\math::remap(var7, 0, 5, var4, 1);
    var9 = scripts\engine\math::remap(var7, 0, 5, 0.8, 1);
    var10 = scripts\engine\math::remap(var7, 0, 5, 1, 0);
    var10 = clamp(var10, 0, 1);

    if(var8 > var4 && var2 == 1) {
      self playLoopSound(var0);
      var2 = 0;
      var3 = 0.5;
    }

    self scalevolume(var8, var3);
    self scalepitch(var9, var3);
    var6 scalevolume(var10, var3);
    wait var3;

    if(var8 <= var4 && var2 == 0) {
      self stoploopsound(var0);
      var2 = 1;
      var3 = 0.05;
    }
  }

  var6 stopsounds();
  waitframe();
  var6 delete();
}

function wolf_background_apc_1_sound() {
  thread hospital_ground_vehicle_movement_sound("wolf_background_apc_1_lp", "mar_wolf_background_apc_idle_1_lp");
}

function wolf_background_apc_2_sound() {
  thread hospital_ground_vehicle_movement_sound("wolf_background_apc_2_lp", "mar_wolf_background_apc_idle_2_lp");
}

function wolf_background_apc_3_sound() {
  thread hospital_ground_vehicle_movement_sound("wolf_background_apc_3_lp", "mar_wolf_background_apc_idle_3_lp");
}

function wolf_background_apc_4_sound() {
  thread hospital_ground_vehicle_movement_sound("wolf_background_apc_4_lp", "mar_wolf_background_apc_idle_4_lp");
}

function cleanup_background_city_heli() {
  scripts\common\vehicle::vehicle_lights_off("running");
  scripts\engine\utility::flag_wait("flag_groundfloor_hallway_ambush_start");

  if(isDefined(self)) {
    self scalevolume(1, 0);
    self scalevolume(0, 5);
  }

  wait 5;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function background_heli_turret_cleanup() {
  if(isDefined(self.mainturret)) {
    self.mainturret delete();
    return;
  }
}

function init_bg_tracer_fx() {
  var0 = getEntArray("background_tracer_fx", "targetname");
  scripts\engine\utility::array_thread(var0, &bg_aa_trigger_tracer_fx);
}

function bg_aa_trigger_tracer_fx() {
  level endon("disable_bg_tracers");
  var0 = spawn("trigger_radius", self.origin, 16, 3000, 2500);

  for(;;) {
    var0 waittill("trigger", var1);

    if(!isDefined(var1)) {
      continue;
    }

    if(var1.classname != "script_vehicle_apache") {
      continue;
    }

    if(isDefined(var1.ignore_background_tracers)) {
      continue;
    }

    bg_aa_fire_tracer_fx(var1);
    wait 10;
  }
}

function bg_aa_fire_tracer_fx(var0) {
  var0 endon("death");
  var1 = randomintrange(3, 8);
  var2 = var0;
  var3 = self;

  for(var4 = 0; var4 < var1; var4++) {
    var5 = var2.origin + scripts\engine\utility::randomvectorrange(-200, 200) - var3.origin;
    var5 = vectortoangles(var5);
    var3 rotateTo(var5, 0.05);
    var6 = anglesToForward(var3.angles);
    var7 = anglestoup(var3.angles);
    playFX(scripts\engine\utility::getfx("background_aa_tracer_fx"), var3.origin, var7, var6);
    wait randomfloatrange(0.25, 0.4);
  }
}

function bg_retreat_slaughter_magic_bullets() {
  scripts\engine\utility::flag_wait("bg_parking_lot_right_shooting");

  for(var0 = 0; var0 < 30; var0++) {
    var1 = scripts\engine\utility::getStructArray("bg_parking_lot_right_shooting_target", "targetname");
    var2 = scripts\engine\utility::random(var1);
    var3 = scripts\engine\utility::getStructArray("bg_parking_lot_right_shooting_source", "targetname");
    var4 = scripts\engine\utility::random(var3);
    var5 = (0, 0, randomintrange(-10, 10));
    playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), var4.origin, vectortoangles(var2.origin + var5));
    magicbullet("iw8_ar_akilo47", var4.origin, var2.origin + var5);
    wait 0.1;
  }
}

function wolf_room_heli_manager() {
  scripts\engine\utility::flag_wait("flag_wolf_room_heli");
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("wolf_room_heli");
  waitframe();
  var0 scripts\common\vehicle::vehicle_lights_off("running");
}

function heli_fire_magic_bullet() {
  self.mainturret delete();
  wait 2;
  var0 = getaiarray("axis");

  while(var0.size > 0 && isDefined(self)) {
    var0 = scripts\engine\utility::array_removedead_or_dying(var0);

    if(var0.size > 0) {
      var1 = scripts\engine\utility::random(var0);
      self setlookatent(var1);
      var2 = self.origin + (0, 0, -10);
      var3 = var1.origin;
      var4 = (0, 0, randomintrange(-50, 50));
      magicbullet("iw8_la_rpapa7", var2, var3 + var4);
      self clearlookatent();
      wait randomfloatrange(0.015, 0.5);
    }

    waitframe();
    wait 5;
  }
}

function wolf_balcony_apc_handler() {
  var0 = scripts\sp\maps\marines\marines_utility::setup_named_vehicle("wolf_background_apc_1", "Stormin Norman", "wolf_background_apc_1_start", 0, 0);
  var1 = scripts\sp\maps\marines\marines_utility::setup_named_vehicle("wolf_background_apc_2", "Sticky Treads", "wolf_background_apc_2_start", 0, 0);
  var2 = scripts\sp\maps\marines\marines_utility::setup_named_vehicle("wolf_background_apc_3", "Hollywood", "wolf_background_apc_3_start", 0, 0);
  var3 = scripts\sp\maps\marines\marines_utility::setup_named_vehicle("wolf_background_apc_4", "Beagle", "wolf_background_apc_4_start", 0, 0);
  var0.targetname = "wolf_background_apc_1";
  var1.targetname = "wolf_background_apc_2";
  var2.targetname = "wolf_background_apc_3";
  var3.targetname = "wolf_background_apc_4";
  var0.dontdisconnectpaths = 1;
  var1.dontdisconnectpaths = 1;
  var2.dontdisconnectpaths = 1;
  var3.dontdisconnectpaths = 1;
  var0.script_badplace = 1;
  var1.script_badplace = 1;
  var2.script_badplace = 1;
  var3.script_badplace = 1;
  var0 scripts\common\vehicle_code::vehicle_remove_badplace();
  var1 scripts\common\vehicle_code::vehicle_remove_badplace();
  var2 scripts\common\vehicle_code::vehicle_remove_badplace();
  var3 scripts\common\vehicle_code::vehicle_remove_badplace();
  thread ground_vehicle_sound_handler();
  thread ground_vehicle_sound_handler();
  thread ground_vehicle_sound_handler();
  thread ground_vehicle_sound_handler();
  var4 = getspawnerarray("background_wolf_runners");
  var5 = getspawnerarray("background_wolf_runners_aim");
  var6 = getEnt("background_wolf_runner_aimer_target", "targetname");
  scripts\engine\utility::flag_wait("flag_wolf_roof_advance");
  var7 = scripts\engine\sp\utility::array_spawn(var4);
  var8 = scripts\engine\sp\utility::array_spawn(var5);
  thread scripts\common\vehicle_paths::gopath(var0);
  thread scripts\common\vehicle_paths::gopath(var1);
  thread scripts\common\vehicle_paths::gopath(var2);
  thread scripts\common\vehicle_paths::gopath(var3);
  wait 5;

  foreach(var10 in var8) {
    if(isDefined(var10) && isalive(var10)) {
      var10 scripts\engine\sp\utility::enable_dontevershoot();
      var10 setentitytarget(var6);
      var10.no_pistol_switch = 1;
    }
  }
}

function background_marine_handler() {
  self.ignoreme = 1;
}

function background_outside_murderhouse_allies_cleanup() {
  scripts\engine\utility::flag_wait("flag_delete_mg_house_outside_allies");
  var0 = scripts\engine\sp\utility::get_living_ai_array("background_outside_murderhole_allies", "script_noteworthy");
  waitframe();

  foreach(var2 in var0) {
    if(isDefined(var2) && isalive(var2)) {
      var2 delete();
    }
  }
}