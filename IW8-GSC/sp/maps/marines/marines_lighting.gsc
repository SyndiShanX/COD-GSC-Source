/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_lighting.gsc
************************************************/

main() {
  init_flags();
  thread hospital_dof_on();
  thread murderhole_dof_on();
  thread turnon();
  thread turnoff();
  thread flickerlightmh();
  thread flickersource();
  thread flickerfire();
  thread getlighttrigger();
  thread snakecam_light_on("snakecam_light_on_trig");
  thread scriptlights_setup();
  thread call_sung_lighting_setup();
  scripts\engine\sp\utility::post_load_precache(::postload);
}

init_flags() {
  scripts\engine\utility::flag_init("murderhole_shadow_adjustment_end");
  scripts\engine\utility::flag_init("hospital_dof_on");
  scripts\engine\utility::flag_init("murderhole_dof_On");
}

optimizationdvars() {
  waitframe();
  waitframe();
  setsaveddvar("MPLORMMQPT", 2);
  setsaveddvar("MNKLKSPRT", 1500);
  setsaveddvar("QPLMKRON", 0);
  setsaveddvar("NQTPSMTLQM", 0);
  setsaveddvar("MRSTKSMMP", 0);
  setsaveddvar("MPTNKKPKRK", 4);
  setsaveddvar("MPRMNMQQKR", 4);
}

call_sung_lighting_setup() {
  setDvar("r_useCompressedSunShadow", 1);
  setsaveddvar("TMNTMTQRM", 0);
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("LSNRQTOKRR", 2);
}

scriptlights_setup() {
  var_0 = getEntArray("snakecam_light", "targetname");
  var_1 = getEntArray("wolfroom_light", "targetname");
  var_2 = getEntArray("cinematic_monitor_light", "targetname");

  foreach(var_4 in var_0)
  var_4.tempintensity = var_4 getlightintensity();

  foreach(var_7 in var_2)
  var_7.tempintensity = var_7 getlightintensity();

  foreach(var_10 in var_1)
  var_10.tempintensity = var_10 getlightintensity();
}

snakecam_light_on(var_0) {
  var_1 = getEntArray("snakecam_light", "targetname");
  var_2 = getEntArray("wolfroom_light", "targetname");
  var_3 = getEntArray("cinematic_monitor_light", "targetname");
  scripts\engine\sp\utility::trigger_wait(var_0, "targetname");

  foreach(var_5 in var_2)
  var_5 setlightintensity(0);

  foreach(var_8 in var_3)
  var_8 setlightintensity(var_8.tempintensity);

  foreach(var_11 in var_1)
  var_11 setlightintensity(var_11.tempintensity);

  waitframe();
  wolfroom_light_on();
}

wolfroom_light_on() {
  var_0 = getEnt("wolfroom_light_on_trig", "targetname");
  var_1 = getEntArray("snakecam_light", "targetname");
  var_2 = getEntArray("wolfroom_light", "targetname");
  var_3 = getEntArray("cinematic_monitor_light", "targetname");
  scripts\engine\sp\utility::trigger_wait("wolfroom_light_on_trig", "targetname");
  setsaveddvar("LTQMSPKRKO", 6);
  setsaveddvar("MROOOROPKL", 6);

  foreach(var_5 in var_1)
  var_5 setlightintensity(0);

  foreach(var_8 in var_3)
  var_8 setlightintensity(0);

  foreach(var_11 in var_2)
  var_11 setlightintensity(var_11.tempintensity);

  waitframe();
  snakecam_light_on("snakecam_balcony_light_on_trig");
}

hospital_dof_on() {
  scripts\engine\utility::flag_wait("hospital_dof_on");
  setsaveddvar("LKOLRONRNQ", 600);
  scripts\engine\utility::flag_waitopen("hospital_dof_on");
}

murderhole_dof_on() {
  scripts\engine\utility::flag_wait("murderhole_dof_On");
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("LKOLRONRNQ", 500);
  scripts\engine\utility::flag_waitopen("murderhole_dof_On");
  setsaveddvar("TMNTMTQRM", 0);
}

getlighttrigger() {
  var_0 = getEntArray("light_trigger", "targetname");

  foreach(var_2 in var_0)
  var_2 thread destroylight();
}

destroylight() {
  var_0 = getEntArray(self.target, "targetname");
  self waittill("trigger", var_1);

  foreach(var_3 in var_0) {
    var_3 setlightintensity(0);
    var_3 notify("stopflicker");
  }
}

postload() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  lighting_setup_dvars();
}

flycam_intro_start() {
  level endon("intro_skipped");
  waitframe();
  var_0 = getEntArray("hospital_intro", "targetname");
  level.player enablephysicaldepthoffieldscripting();
  level thread scripts\engine\sp\utility::dof_enable(1.4, 10000, 20);
  wait 4;
  level thread scripts\engine\sp\utility::dof_enable(1.4, 300, 20);
  wait 3;
  level thread scripts\engine\sp\utility::dof_enable(1.4, 250, 2);
  wait 2;
  wait 3;

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);

  level.fake_player thread scripts\engine\sp\utility::dof_enable_autofocus(1.2, 2, undefined, undefined, "tag_eye");
  wait 10;
  level.farah thread scripts\engine\sp\utility::dof_enable_autofocus(1.2, 2, undefined, undefined, "tag_eye");
  wait 11;
  level.hadir thread scripts\engine\sp\utility::dof_enable_autofocus(1.2, 2, undefined, undefined, "tag_eye");
  wait 2;
  level.fake_player thread scripts\engine\sp\utility::dof_enable_autofocus(1.2, 2, undefined, undefined, "tag_eye");
  wait 3;
  level.fake_player thread scripts\engine\sp\utility::dof_enable_autofocus(4, 1, undefined, undefined, "tag_eye");
  level.player disablephysicaldepthoffieldscripting();
}

wolf_takedown_cam_start() {
  setsaveddvar("MPTNKKPKRK", 6);
  scripts\engine\utility::flag_wait("flag_wolf_performing_takedown");
  waitframe();
}

lighting_setup_dvars() {
  setDvar("r_useCompressedSunShadow", 1);
  setsaveddvar("TMNTMTQRM", 0);
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("LKOLRONRNQ", 800);
  setsaveddvar("MROOOROPKL", 4);
  setsaveddvar("LTQMSPKRKO", 4);
}

turnon() {
  var_0 = getEnt("turn_on_light_trigger", "targetname");
  var_1 = getEnt("stair_light", "targetname");
  var_1.tempintensity = var_1 getlightintensity();
  scripts\engine\sp\utility::trigger_wait("turn_on_light_trigger", "targetname");

  while(level.player istouching(var_0)) {
    var_1 setlightintensity(var_1.tempintensity);
    wait 0.1;
  }

  thread turnon();
}

turnoff() {
  var_0 = getEnt("turn_off_light_trigger", "targetname");
  var_1 = getEnt("stair_light", "targetname");
  scripts\engine\sp\utility::trigger_wait("turn_off_light_trigger", "targetname");

  while(level.player istouching(var_0)) {
    var_1 setlightintensity(0);
    wait 0.1;
  }

  thread turnoff();
}

sun_adjustments_murderhole_building() {}

sun_adjustments_hospital_trigger(var_0, var_1) {
  var_2 = getEnt(var_0 + "_" + var_1, "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  scripts\engine\sp\utility::trigger_wait_targetname(var_0 + "_" + var_1);
  sun_adjustments_register_trigger(var_0, var_1);
}

sun_adjustments_hospital_force(var_0, var_1) {
  var_2 = getEnt(var_0 + "_" + var_1, "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  sun_adjustments_register_trigger(var_0, var_1);
}

sun_adjustments_register_trigger(var_0, var_1) {
  waitframe();
  var_2 = getEnt(var_0 + "_" + var_1, "targetname");
  var_3 = var_2.script_sunsamplesizenear;
  var_4 = var_2.script_sunshadowscale;
  var_5 = var_2.script_sunenable;

  if(isDefined(var_3)) {}

  if(isDefined(var_5) && var_5 > 0) {}

  if(isDefined(var_4)) {
    setsuncolorandintensity(var_4);

    if(var_4 > 0) {
      waitframe();
      setsaveddvar("OMKTSMSOS", 3);
    } else {}
  }

  thread sun_adjustments_hospital_trigger(var_0, var_1 + 1);
  thread sun_adjustments_hospital_trigger(var_0, var_1 - 1);
}

flickerlightmh() {
  var_0 = getEntArray("flicker_light_mh", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 thread flickersinglelight();
}

flickersinglelight() {
  self endon("stopflicker");

  for(;;) {
    var_0 = sin(gettime() * 123) * 0.3 + 0.3;
    self setlightintensity(5);
    wait(var_0);
    self setlightintensity(15);
    var_0 = sin(gettime() * 123) * 0.3 + 0.3;
    wait(var_0);
  }
}

flickersource() {
  var_0 = getEntArray("flicker_source", "targetname");

  for(;;) {
    foreach(var_2 in var_0) {
      var_3 = 0.1 + randomfloat(1.0);
      var_2 setlightintensity(var_3);
    }

    wait 0.1;
  }

  thread flickersource();
}

flickerfire() {
  var_0 = getEntArray("flicker_fire", "targetname");

  for(;;) {
    var_1 = 5.0 + randomfloat(5.0);

    foreach(var_3 in var_0)
    var_3 setlightintensity(var_1);

    wait 0.06;
  }

  thread flickersource();
}