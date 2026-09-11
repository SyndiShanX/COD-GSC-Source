/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\lab\lab_lighting.gsc
************************************************/

function main() {
  level.sun_flare_pos = (-66564, -17380, 44792);
  claxon_light_init();
  thread ambush1_lights_on();
  thread ambush1_lights_off();
  thread tank_hero_lighting_off();
  thread pipes_hero_light_init();
  scripts\engine\sp\utility::post_load_precache(&post_load);
}

function post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  thread init_lighting_dvars();
}

function init_lighting_dvars() {
  waitframe();
  setsaveddvar("NPONLLLSPL", 0.35);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("LTQMSPKRKO", 6);
  setsaveddvar("MROOOROPKL", 8);
  setsaveddvar("LKOLRONRNQ", 800);
}

function drone_hero_lighting_setup() {
  var0 = getEnt("drone_hero_light", "targetname");

  if(!isDefined(var0)) {
    return;
  }

  var0.og_intensity = var0 getlightintensity();
}

function drone_hero_lighting_on() {
  var0 = getEnt("drone_hero_light", "targetname");

  if(!isDefined(var0)) {
    return;
  }

  var1 = (-65, 50, -40);
  var2 = (-150, 135, 0);
  var0 linkTo(self, "tag_origin", var1, var2);
  level waittill("delete_drone_light");

  if(isDefined(var0)) {
    wait 0.2;
    var0 setlightintensity(0);
    var0 unlink();
    return;
  }
}

function tank_hero_lighting_off() {
  scripts\engine\utility::flag_wait("introscreen_start_wait");
  var0 = getEntArray("tank_hero_light", "targetname");

  if(!isDefined(var0)) {
    return;
  }

  foreach(var2 in var0) {
    var2 thread scripts\sp\lights::lerp_intensity(0, 1.5);
  }

  wait 2;

  foreach(var2 in var0) {
    var2 delete();
  }
}

function init_lab_lights() {
  var0 = getEntArray("light_emergency_on", "targetname");

  foreach(var2 in var0) {
    store_og_intensity(var2);
    var2 setlightintensity(0);
  }

  var4 = getEntArray("light_emergency_model", "targetname");

  foreach(var6 in var4) {
    if(var6.model == "sign_emergency_exit_light_02_lab_on" || var6.model == "sign_emergency_exit_light_02_on_lab_right" || var6.model == "sign_emergency_exit_light_02_on_lab_left") {
      var6 setModel("sign_emergency_exit_light_02");
    }
  }
}

function ambush1_emergency_lights_on() {
  var0 = getEntArray("light_emergency_on", "targetname");

  foreach(var2 in var0) {
    if(isDefined(var2.og_intensity)) {
      var2 setlightintensity(var2.og_intensity);
    }
  }

  var4 = getEntArray("light_emergency_model", "targetname");

  foreach(var6 in var4) {
    if(var6.model == "lighting_fixtures_security_lamp_withcage_01_sm") {
      var6 setModel("lighting_fixtures_security_lamp_withcage_01_sm_lab_on");
      continue;
    }

    if(isDefined(var6.script_noteworthy) && var6.script_noteworthy == "left") {
      var6 setModel("sign_emergency_exit_light_02_on_lab_left");
      continue;
    }

    if(isDefined(var6.script_noteworthy) && var6.script_noteworthy == "right") {
      var6 setModel("sign_emergency_exit_light_02_on_lab_right");
      continue;
    }

    var6 setModel("sign_emergency_exit_light_02_lab_on");
  }
}

function ambush1_lights_on() {
  wait 1;
  scripts\engine\utility::flag_wait("ambush1_start");
  thread claxon_lights_on("turbine2");
}

function ambush1_lights_off() {
  wait 2;
  scripts\engine\utility::flag_wait("ambush_end");
  var0 = getarraykeys(level.claxons);

  foreach(var2 in var0) {
    thread claxon_lights_off(level, var2);
  }
}

function ambush_lighting_change() {
  thread turn_off_ambush_light_models();
  var0 = getEntArray("light_turbine_off", "targetname");

  if(isDefined(var0) && isarray(var0)) {
    scripts\engine\utility::array_call(var0, &setlightintensity, 0);
  }

  thread scripts\sp\hud_util::fade_out(0.5);
  scripts\engine\utility::delaythread(level.blackout_delay - 0.2, &scripts\sp\hud_util::fade_in, 0.2);
  wait level.blackout_delay;
  scripts\engine\utility::exploder("ambush_flares");
  thread ambush1_emergency_lights_on();
}

function turn_off_ambush_light_models() {
  var0 = getEntArray("light_model_ambush1", "targetname");

  if(isDefined(var0) && isarray(var0)) {
    foreach(var2 in var0) {
      var2 setModel("uk_industrial_light_01");
    }
  }

  var0 = getEntArray("light_model2_ambush1", "targetname");

  if(isDefined(var0) && isarray(var0)) {
    foreach(var2 in var0) {
      var2 setModel("me_light_ceiling_fluorescent_tube");
    }

    return;
  }
}

function dark_visionset_turbine_room() {
  for(;;) {
    scripts\engine\utility::flag_wait("in_turbine_room");
    visionsetnaked("lab_interior_dark", 0.05);
    scripts\engine\utility::flag_waitopen("in_turbine_room");
    visionsetnaked("", 0.05);
  }
}

function store_og_intensity() {
  self.og_intensity = self getlightintensity();
}

#using_animtree("script_model");

function claxon_light_init() {
  level.claxons = [];
  var0 = getEntArray("claxon_model_on", "targetname");

  foreach(var2 in var0) {
    var2 useanimtree(#animtree);
    var2.lights = [];
    var3 = getEntArray(var2.target, "targetname");

    foreach(var5 in var3) {
      if(var5.script_namenumber == "light") {
        var5 linkTo(var2, "j_spin");
        var2.lights[var2.lights.size] = var5;
      }

      if(var5.script_namenumber == "model_off") {
        var2.model_off = var5;
      }
    }

    if(!isDefined(level.claxons[var2.script_noteworthy])) {
      level.claxons[var2.script_noteworthy] = spawnStruct();
      level.claxons[var2.script_noteworthy].models_on = [];
    }

    var7 = level.claxons[var2.script_noteworthy].models_on;
    var7 = var2;
    level.claxons[var2.script_noteworthy].models_on = var7;
  }

  var9 = getarraykeys(level.claxons);

  foreach(var11 in var9) {
    thread claxon_lights_off(level, var11);
  }
}

#using_animtree("");

function claxon_lights_on(var0) {
  foreach(var2 in level.claxons[var0].models_on) {
    var2 show();
    var2.model_off hide();

    if(isDefined(var2.script_fxid)) {
      playFXOnTag(scripts\engine\utility::getfx(var2.script_fxid), var2, "j_spin");
    }

    foreach(var4 in var2.lights) {
      var4 setlightcolor((1, 0.085294, 0.03137));
      var4 thread scripts\sp\lights::lerp_intensity(15, 1);
    }

    var2 setanim(%claxon_spin_loop);
    wait 0.3;
  }
}

function claxon_lights_off(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  foreach(var3 in level.claxons[var0].models_on) {
    thread claxon_stop_spin(var3);
  }
}

function claxon_stop_spin(var0) {
  self clearanim(%claxon_spin_loop, 0.5);

  if(var0) {
    wait 0.5;
  }

  self hide();
  self.model_off show();

  foreach(var2 in self.lights) {
    var2 thread scripts\sp\lights::lerp_intensity(0, 1);
  }

  if(isDefined(self.script_fxid)) {
    killfxontag(scripts\engine\utility::getfx(self.script_fxid), self, "j_spin");
    return;
  }
}

function detonator_hero_lighting_setup() {
  var0 = getEnt("det_hero_light", "targetname");
  var0.og_intensity = var0 getlightintensity();
  var0 setlightintensity(0);
}

function detonator_hero_lighting_on() {
  var0 = getEnt("det_hero_light", "targetname");
  var0 linkTo(self, "tag_origin", (7, -15, 15), (50, 90, 0));
  wait 0.65;
  var0 setlightintensity(var0.og_intensity);
  level waittill("delete_detonator_light");
  wait 0.2;
  var0 setlightintensity(0);
  var0 unlink();
}

function pipes_hero_light_init() {
  var0 = getEntArray("pipes_hero_light", "targetname");

  foreach(var2 in var0) {
    var2.og_intensity = var2 getlightintensity();
    var2 setlightintensity(0);
  }
}

function pipes_hero_light_rig_setup() {
  var0 = getEntArray("pipes_hero_light", "targetname");
  var1 = getEnt("pipes_hero_lights_pos", "targetname");

  if(isDefined(var0) && var0.size > 0) {
    foreach(var3 in var0) {
      var3 linkTo(var1);
    }
  }

  return var1;
}

function enable_pipes_hero_lights() {
  var0 = getEntArray("pipes_hero_light", "targetname");

  foreach(var2 in var0) {
    var2 thread scripts\sp\lights::lerp_intensity(var2.og_intensity, 2.5);
  }
}

function finale_heli_lights() {
  self.lights = [];
  thread get_volume_and_linkTo();
  var0 = get_light_and_linkTo("heli_light_door", 55, (125, 0, -44), (0, 0, 0), 90, 120);
  var1 = get_light_and_linkTo("heli_light_omni_1", 5, (110, 12, -61.5), (0, 0, 0), 50, 90);
  var2 = get_light_and_linkTo("heli_light_window", 5, (106, -46, -76), (0, 0, 0), 28, 115);
  var3 = get_light_and_linkTo("heli_light_window_2", 15, (-25, 43, -84), (0, 0, 0), 110, 120);
  thread move_window_light(var3);
  var4 = get_light_and_linkTo("heli_light_back_door", 23, (-115.539, 4, -74.2349), (0, 0, 0), 140, 80);
  var5 = get_light_and_linkTo("heli_light_back", 25, (40.4612, -5, -68.2349), (0, 0, 0), 65, 50);
  var6 = get_light_and_linkTo("heli_light_end_key", 110, (-127.539, 49, -87.2349), (0, 0, 0), 70, 55);
  var7 = get_light_and_linkTo("heli_light_end_rim", 27, (-115.539, -9, -69.2349), (0, 0, 0), 55, 65);
  var8 = get_light_and_linkTo("heli_light_end_fill", 42, (-161.539, -45, -87.2349), (0, 0, 0), 65, 40);
  var9 = [var0, var1, var2, var3, var4, var5, var6, var7, var8];
  var10 = [var6, var7, var8];
  thread disable_heli_lights(var9);
  thread disable_back_light(var5);
  thread toggle_farah_lights(var10);
  var11 = get_light_and_linkTo("heli_light_cockpit_1", 5.5, (191.441, 27.3363, -67), (0, 0, 0), 30, 85);
  var12 = get_light_and_linkTo("heli_light_cockpit_2", 2.5, (179.441, -33.6637, -63), (0, 0, 0), 100, 65);
  var13 = get_light_and_linkTo("heli_light_cockpit_3", 30, (167.941, 39.8363, -64), (0, 0, 0), 56, 90);
  var14 = [var11, var12, var13];
  thread toggle_cockpit_lights(var14);
}

function move_window_light(var0) {
  var1 = spawn("script_origin", var0.origin);
  var1 linkTo(level.finale_heli, "tag_origin", (-50, 42, -86), (0, 0, 0));
  var2 = spawn("script_origin", var0.origin);
  var2 linkTo(level.finale_heli, "tag_origin", (-25, 42, -84), (0, 0, 0));
  var3 = spawn("script_origin", var0.origin);
  var3 linkTo(level.finale_heli, "tag_origin", (-25, 42, -84), (0, 0, 0));
  var4 = spawn("script_origin", var0.origin);
  var4 linkTo(level.finale_heli, "tag_origin", (-5, 42, -84), (0, 0, 0));
  var5 = level scripts\engine\utility::waittill_any_return("move_window_light_elbow", "move_window_light_fail");
  var6 = spawn("script_origin", var0.origin);
  var0 unlink();
  var0 linkTo(var6);
  var0 setlightintensity(0);
  var0 thread scripts\sp\lights::lerp_intensity(var0.og_intensity, 1);

  switch (var5) {
    case "move_window_light_elbow":
      var6.origin = var1.origin;
      var6 moveTo(var2.origin, 3);
      break;
    default:
      var6.origin = var3.origin;
      var6 moveTo(var4.origin, 2);
      break;
  }
}

function toggle_cockpit_lights(var0) {
  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }

  scripts\engine\utility::flag_wait("barkov_dead");

  foreach(var2 in var0) {
    var2 setlightintensity(var2.og_intensity);
  }
}

function toggle_farah_lights(var0) {
  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }

  level waittill("barkov_dead");

  foreach(var2 in var0) {
    var2 thread scripts\sp\lights::lerp_intensity(var2.og_intensity, 2);
  }
}

function disable_back_light(var0) {
  level waittill("disable_light_6");
  var0 setlightintensity(0);
}

function disable_heli_lights(var0) {
  scripts\engine\utility::flag_wait("barkov_dead");

  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }
}

function get_light_and_linkTo(var0, var1, var2, var3, var4, var5) {
  var6 = getEnt(var0, "targetname");

  if(!isDefined(var6)) {
    return;
  }

  var6 linkTo(self, "tag_origin", var2, var3);
  var6.og_intensity = var6 getlightintensity();
  var6 setlightintensity(var1);
  var6 setlightradius(var4);
  var6.og_fov = var6 getlightfovouter();

  if(var5 > var6.og_fov) {
    var5 = var6.og_fov;
  }

  var6 setlightfovrange(var5, var5 - 5);
  self.lights[self.lights.size] = var6;
  return var6;
}

function get_volume_and_linkTo() {
  self.reflectionvolume = getEnt("finale_heli_locator", "targetname");
  self.reflectionvolume linkTo(self);
  self.reflectionvolume2 = getEnt("finale_heli_locator2", "targetname");
  self.reflectionvolume2 linkTo(self);
  self.reflectionvolume3 = getEnt("finale_heli_locator3", "targetname");
  self.reflectionvolume3 linkTo(self);
}

function juggernaut_dof() {
  level.juggernaut_1 thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 10, undefined, undefined, "tag_eye", undefined, 1);
  wait 2.75;
  level.jugg_detonator thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 10, undefined, undefined, "tag_origin", undefined, 1);
  wait 2;
  level.juggernaut_1 thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 10, undefined, undefined, "tag_eye", undefined, 1);
  wait 2;
  thread scripts\engine\sp\utility::dof_disable_autofocus();
}

function c4_pickup_dof() {
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