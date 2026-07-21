/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\lab\lab_lighting.gsc
***********************************************/

main() {
  level.sun_flare_pos = (-66564, -17380, 44792);
  claxon_light_init();
  thread ambush1_lights_on();
  thread ambush1_lights_off();
  thread tank_hero_lighting_off();
  thread pipes_hero_light_init();
  scripts\engine\sp\utility::post_load_precache(::post_load);
}

post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  thread init_lighting_dvars();
}

init_lighting_dvars() {
  waitframe();
  setsaveddvar("NPONLLLSPL", 0.35);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("LTQMSPKRKO", 6);
  setsaveddvar("MROOOROPKL", 8);
  setsaveddvar("LKOLRONRNQ", 800);
}

drone_hero_lighting_setup() {
  var_0 = getEnt("drone_hero_light", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0.og_intensity = var_0 getlightintensity();
}

drone_hero_lighting_on() {
  var_0 = getEnt("drone_hero_light", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = (-65, 50, -40);
  var_2 = (-150, 135, 0);
  var_0 linkTo(self, "tag_origin", var_1, var_2);
  level waittill("delete_drone_light");

  if(isDefined(var_0)) {
    wait 0.2;
    var_0 setlightintensity(0);
    var_0 unlink();
  }
}

tank_hero_lighting_off() {
  scripts\engine\utility::flag_wait("introscreen_start_wait");
  var_0 = getEntArray("tank_hero_light", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0)
  var_2 thread scripts\sp\lights::lerp_intensity(0, 1.5);

  wait 2;

  foreach(var_2 in var_0)
  var_2 delete();
}

init_lab_lights() {
  var_0 = getEntArray("light_emergency_on", "targetname");

  foreach(var_2 in var_0) {
    var_2 store_og_intensity();
    var_2 setlightintensity(0);
  }

  var_4 = getEntArray("light_emergency_model", "targetname");

  foreach(var_6 in var_4) {
    if(var_6.model == "sign_emergency_exit_light_02_lab_on" || var_6.model == "sign_emergency_exit_light_02_on_lab_right" || var_6.model == "sign_emergency_exit_light_02_on_lab_left")
      var_6 setModel("sign_emergency_exit_light_02");
  }
}

ambush1_emergency_lights_on() {
  var_0 = getEntArray("light_emergency_on", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.og_intensity))
      var_2 setlightintensity(var_2.og_intensity);
  }

  var_4 = getEntArray("light_emergency_model", "targetname");

  foreach(var_6 in var_4) {
    if(var_6.model == "lighting_fixtures_security_lamp_withcage_01_sm") {
      var_6 setModel("lighting_fixtures_security_lamp_withcage_01_sm_lab_on");
      continue;
    }

    if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "left") {
      var_6 setModel("sign_emergency_exit_light_02_on_lab_left");
      continue;
    }

    if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "right") {
      var_6 setModel("sign_emergency_exit_light_02_on_lab_right");
      continue;
    }

    var_6 setModel("sign_emergency_exit_light_02_lab_on");
  }
}

ambush1_lights_on() {
  wait 1;
  scripts\engine\utility::flag_wait("ambush1_start");
  thread claxon_lights_on("turbine2");
}

ambush1_lights_off() {
  wait 2;
  scripts\engine\utility::flag_wait("ambush_end");
  var_0 = getarraykeys(level.claxons);

  foreach(var_2 in var_0)
  level thread claxon_lights_off(var_2, 0);
}

ambush_lighting_change() {
  thread turn_off_ambush_light_models();
  var_0 = getEntArray("light_turbine_off", "targetname");

  if(isDefined(var_0) && isarray(var_0))
    scripts\engine\utility::array_call(var_0, ::setlightintensity, 0);

  thread scripts\sp\hud_util::fade_out(0.5);
  scripts\engine\utility::delaythread(level.blackout_delay - 0.2, scripts\sp\hud_util::fade_in, 0.2);
  wait(level.blackout_delay);
  scripts\engine\utility::exploder("ambush_flares");
  thread ambush1_emergency_lights_on();
}

turn_off_ambush_light_models() {
  var_0 = getEntArray("light_model_ambush1", "targetname");

  if(isDefined(var_0) && isarray(var_0)) {
    foreach(var_2 in var_0)
    var_2 setModel("uk_industrial_light_01");
  }

  var_0 = getEntArray("light_model2_ambush1", "targetname");

  if(isDefined(var_0) && isarray(var_0)) {
    foreach(var_2 in var_0)
    var_2 setModel("me_light_ceiling_fluorescent_tube");
  }
}

dark_visionset_turbine_room() {
  for(;;) {
    scripts\engine\utility::flag_wait("in_turbine_room");
    visionsetnaked("lab_interior_dark", 0.05);
    scripts\engine\utility::flag_waitopen("in_turbine_room");
    visionsetnaked("", 0.05);
  }
}

store_og_intensity() {
  self.og_intensity = self getlightintensity();
}

#using_animtree("script_model");

claxon_light_init() {
  level.claxons = [];
  var_0 = getEntArray("claxon_model_on", "targetname");

  foreach(var_2 in var_0) {
    var_2 useanimtree(#animtree);
    var_2.lights = [];
    var_3 = getEntArray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      if(var_5.script_namenumber == "light") {
        var_5 linkTo(var_2, "j_spin");
        var_2.lights[var_2.lights.size] = var_5;
      }

      if(var_5.script_namenumber == "model_off")
        var_2.model_off = var_5;
    }

    if(!isDefined(level.claxons[var_2.script_noteworthy])) {
      level.claxons[var_2.script_noteworthy] = spawnStruct();
      level.claxons[var_2.script_noteworthy].models_on = [];
    }

    var_7 = level.claxons[var_2.script_noteworthy].models_on;
    var_7[var_7.size] = var_2;
    level.claxons[var_2.script_noteworthy].models_on = var_7;
  }

  var_9 = getarraykeys(level.claxons);

  foreach(var_11 in var_9)
  level thread claxon_lights_off(var_11, 0);
}

claxon_lights_on(var_0) {
  foreach(var_2 in level.claxons[var_0].models_on) {
    var_2 show();
    var_2.model_off hide();

    if(isDefined(var_2.script_fxid))
      playFXOnTag(scripts\engine\utility::getfx(var_2.script_fxid), var_2, "j_spin");

    foreach(var_4 in var_2.lights) {
      var_4 setlightcolor((1, 0.085294, 0.03137));
      var_4 thread scripts\sp\lights::lerp_intensity(15, 1);
    }

    var_2 setanim(%claxon_spin_loop);
    wait 0.3;
  }
}

claxon_lights_off(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_3 in level.claxons[var_0].models_on)
  var_3 thread claxon_stop_spin(var_1);
}

claxon_stop_spin(var_0) {
  self clearanim(%claxon_spin_loop, 0.5);

  if(var_0)
    wait 0.5;

  self hide();
  self.model_off show();

  foreach(var_2 in self.lights)
  var_2 thread scripts\sp\lights::lerp_intensity(0, 1);

  if(isDefined(self.script_fxid))
    killfxontag(scripts\engine\utility::getfx(self.script_fxid), self, "j_spin");
}

detonator_hero_lighting_setup() {
  var_0 = getEnt("det_hero_light", "targetname");
  var_0.og_intensity = var_0 getlightintensity();
  var_0 setlightintensity(0);
}

detonator_hero_lighting_on() {
  var_0 = getEnt("det_hero_light", "targetname");
  var_0 linkTo(self, "tag_origin", (7, -15, 15), (50, 90, 0));
  wait 0.65;
  var_0 setlightintensity(var_0.og_intensity);
  level waittill("delete_detonator_light");
  wait 0.2;
  var_0 setlightintensity(0);
  var_0 unlink();
}

pipes_hero_light_init() {
  var_0 = getEntArray("pipes_hero_light", "targetname");

  foreach(var_2 in var_0) {
    var_2.og_intensity = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }
}

pipes_hero_light_rig_setup() {
  var_0 = getEntArray("pipes_hero_light", "targetname");
  var_1 = getEnt("pipes_hero_lights_pos", "targetname");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_3 in var_0)
    var_3 linkTo(var_1);
  }

  return var_1;
}

enable_pipes_hero_lights() {
  var_0 = getEntArray("pipes_hero_light", "targetname");

  foreach(var_2 in var_0)
  var_2 thread scripts\sp\lights::lerp_intensity(var_2.og_intensity, 2.5);
}

finale_heli_lights() {
  self.lights = [];
  thread get_volume_and_linkTo();
  var_0 = get_light_and_linkTo("heli_light_door", 55, (125, 0, -44), (0, 0, 0), 90, 120);
  var_1 = get_light_and_linkTo("heli_light_omni_1", 5, (110, 12, -61.5), (0, 0, 0), 50, 90);
  var_2 = get_light_and_linkTo("heli_light_window", 5, (106, -46, -76), (0, 0, 0), 28, 115);
  var_3 = get_light_and_linkTo("heli_light_window_2", 15, (-25, 43, -84), (0, 0, 0), 110, 120);
  thread move_window_light(var_3);
  var_4 = get_light_and_linkTo("heli_light_back_door", 23, (-115.539, 4, -74.2349), (0, 0, 0), 140, 80);
  var_5 = get_light_and_linkTo("heli_light_back", 25, (40.4612, -5, -68.2349), (0, 0, 0), 65, 50);
  var_6 = get_light_and_linkTo("heli_light_end_key", 110, (-127.539, 49, -87.2349), (0, 0, 0), 70, 55);
  var_7 = get_light_and_linkTo("heli_light_end_rim", 27, (-115.539, -9, -69.2349), (0, 0, 0), 55, 65);
  var_8 = get_light_and_linkTo("heli_light_end_fill", 42, (-161.539, -45, -87.2349), (0, 0, 0), 65, 40);
  var_9 = [var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8];
  var_10 = [var_6, var_7, var_8];
  thread disable_heli_lights(var_9);
  thread disable_back_light(var_5);
  thread toggle_farah_lights(var_10);
  var_11 = get_light_and_linkTo("heli_light_cockpit_1", 5.5, (191.441, 27.3363, -67), (0, 0, 0), 30, 85);
  var_12 = get_light_and_linkTo("heli_light_cockpit_2", 2.5, (179.441, -33.6637, -63), (0, 0, 0), 100, 65);
  var_13 = get_light_and_linkTo("heli_light_cockpit_3", 30, (167.941, 39.8363, -64), (0, 0, 0), 56, 90);
  var_14 = [var_11, var_12, var_13];
  thread toggle_cockpit_lights(var_14);
}

move_window_light(var_0) {
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkTo(level.finale_heli, "tag_origin", (-50, 42, -86), (0, 0, 0));
  var_2 = spawn("script_origin", var_0.origin);
  var_2 linkTo(level.finale_heli, "tag_origin", (-25, 42, -84), (0, 0, 0));
  var_3 = spawn("script_origin", var_0.origin);
  var_3 linkTo(level.finale_heli, "tag_origin", (-25, 42, -84), (0, 0, 0));
  var_4 = spawn("script_origin", var_0.origin);
  var_4 linkTo(level.finale_heli, "tag_origin", (-5, 42, -84), (0, 0, 0));
  var_5 = level scripts\engine\utility::waittill_any_return("move_window_light_elbow", "move_window_light_fail");
  var_6 = spawn("script_origin", var_0.origin);
  var_0 unlink();
  var_0 linkTo(var_6);
  var_0 setlightintensity(0);
  var_0 thread scripts\sp\lights::lerp_intensity(var_0.og_intensity, 1);

  switch (var_5) {
    case "move_window_light_elbow":
      var_6.origin = var_1.origin;
      var_6 moveTo(var_2.origin, 3);
      break;
    default:
      var_6.origin = var_3.origin;
      var_6 moveTo(var_4.origin, 2);
      break;
  }
}

toggle_cockpit_lights(var_0) {
  foreach(var_2 in var_0)
  var_2 setlightintensity(0);

  scripts\engine\utility::flag_wait("barkov_dead");

  foreach(var_2 in var_0)
  var_2 setlightintensity(var_2.og_intensity);
}

toggle_farah_lights(var_0) {
  foreach(var_2 in var_0)
  var_2 setlightintensity(0);

  level waittill("barkov_dead");

  foreach(var_2 in var_0)
  var_2 thread scripts\sp\lights::lerp_intensity(var_2.og_intensity, 2);
}

disable_back_light(var_0) {
  level waittill("disable_light_6");
  var_0 setlightintensity(0);
}

disable_heli_lights(var_0) {
  scripts\engine\utility::flag_wait("barkov_dead");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

get_light_and_linkTo(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEnt(var_0, "targetname");

  if(!isDefined(var_6)) {
    return;
  }
  var_6 linkTo(self, "tag_origin", var_2, var_3);
  var_6.og_intensity = var_6 getlightintensity();
  var_6 setlightintensity(var_1);
  var_6 setlightradius(var_4);
  var_6.og_fov = var_6 getlightfovouter();

  if(var_5 > var_6.og_fov)
    var_5 = var_6.og_fov;

  var_6 setlightfovrange(var_5, var_5 - 5);
  self.lights[self.lights.size] = var_6;
  return var_6;
}

get_volume_and_linkTo() {
  self.reflectionvolume = getEnt("finale_heli_locator", "targetname");
  self.reflectionvolume linkTo(self);
  self.reflectionvolume2 = getEnt("finale_heli_locator2", "targetname");
  self.reflectionvolume2 linkTo(self);
  self.reflectionvolume3 = getEnt("finale_heli_locator3", "targetname");
  self.reflectionvolume3 linkTo(self);
}

juggernaut_dof() {
  level.juggernaut_1 thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 10, undefined, undefined, "tag_eye", undefined, 1);
  wait 2.75;
  level.jugg_detonator thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 10, undefined, undefined, "tag_origin", undefined, 1);
  wait 2.0;
  level.juggernaut_1 thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 10, undefined, undefined, "tag_eye", undefined, 1);
  wait 2;
  thread scripts\engine\sp\utility::dof_disable_autofocus();
}

c4_pickup_dof() {
  level.bomb thread scripts\engine\sp\utility::dof_enable_autofocus(3.5, 20, 20, undefined, "tag_origin_c4", undefined, 1);
  wait 1.75;
  level.nikolai thread scripts\engine\sp\utility::dof_enable_autofocus(3, 20, 20, undefined, "tag_eye", undefined, 1);
  wait 3.8;
  level.player_rig.detonator thread scripts\engine\sp\utility::dof_enable_autofocus(2, 20, 20, undefined, "tag_eye", undefined, 1);
  wait 1.5;
  level.nikolai thread scripts\engine\sp\utility::dof_enable_autofocus(3, 20, 20, undefined, "tag_eye", undefined, 1);
  wait 3.5;
  level.farah thread scripts\engine\sp\utility::dof_enable_autofocus(2.5, 31, 20, undefined, "tag_eye", undefined, 1);
  wait 5.75;
  thread scripts\engine\sp\utility::dof_disable_autofocus();
}