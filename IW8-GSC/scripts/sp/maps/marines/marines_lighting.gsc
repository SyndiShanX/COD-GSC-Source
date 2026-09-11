/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\marines\marines_lighting.gsc
********************************************************/

function main() {
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
  scripts\engine\sp\utility::post_load_precache(&postload);
}

function init_flags() {
  scripts\engine\utility::flag_init("murderhole_shadow_adjustment_end");
  scripts\engine\utility::flag_init("hospital_dof_on");
  scripts\engine\utility::flag_init("murderhole_dof_On");
}

function optimizationdvars() {
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

function call_sung_lighting_setup() {
  setDvar("r_useCompressedSunShadow", 1);
  setsaveddvar("TMNTMTQRM", 0);
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("LSNRQTOKRR", 2);
}

function scriptlights_setup() {
  var0 = getEntArray("snakecam_light", "targetname");
  var1 = getEntArray("wolfroom_light", "targetname");
  var2 = getEntArray("cinematic_monitor_light", "targetname");

  foreach(var4 in var0) {
    var4.tempintensity = var4 getlightintensity();
  }

  foreach(var7 in var2) {
    var7.tempintensity = var7 getlightintensity();
  }

  foreach(var10 in var1) {
    var10.tempintensity = var10 getlightintensity();
  }
}

function snakecam_light_on(var0) {
  var1 = getEntArray("snakecam_light", "targetname");
  var2 = getEntArray("wolfroom_light", "targetname");
  var3 = getEntArray("cinematic_monitor_light", "targetname");
  scripts\engine\sp\utility::trigger_wait(var0, "targetname");

  foreach(var5 in var2) {
    var5 setlightintensity(0);
  }

  foreach(var8 in var3) {
    var8 setlightintensity(var8.tempintensity);
  }

  foreach(var11 in var1) {
    var11 setlightintensity(var11.tempintensity);
  }

  waitframe();
  wolfroom_light_on();
}

function wolfroom_light_on() {
  var0 = getEnt("wolfroom_light_on_trig", "targetname");
  var1 = getEntArray("snakecam_light", "targetname");
  var2 = getEntArray("wolfroom_light", "targetname");
  var3 = getEntArray("cinematic_monitor_light", "targetname");
  scripts\engine\sp\utility::trigger_wait("wolfroom_light_on_trig", "targetname");
  setsaveddvar("LTQMSPKRKO", 6);
  setsaveddvar("MROOOROPKL", 6);

  foreach(var5 in var1) {
    var5 setlightintensity(0);
  }

  foreach(var8 in var3) {
    var8 setlightintensity(0);
  }

  foreach(var11 in var2) {
    var11 setlightintensity(var11.tempintensity);
  }

  waitframe();
  snakecam_light_on("snakecam_balcony_light_on_trig");
}

function hospital_dof_on() {
  scripts\engine\utility::flag_wait("hospital_dof_on");
  setsaveddvar("LKOLRONRNQ", 600);
  scripts\engine\utility::flag_waitopen("hospital_dof_on");
}

function murderhole_dof_on() {
  scripts\engine\utility::flag_wait("murderhole_dof_On");
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("LKOLRONRNQ", 500);
  scripts\engine\utility::flag_waitopen("murderhole_dof_On");
  setsaveddvar("TMNTMTQRM", 0);
}

function getlighttrigger() {
  var0 = getEntArray("light_trigger", "targetname");

  foreach(var2 in var0) {
    thread destroylight();
  }
}

function destroylight() {
  var0 = getEntArray(self.target, "targetname");
  self waittill("trigger", var1);

  foreach(var3 in var0) {
    var3 setlightintensity(0);
    var3 notify("stopflicker");
  }
}

function postload() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  lighting_setup_dvars();
}

function flycam_intro_start() {
  level endon("intro_skipped");
  waitframe();
  var0 = getEntArray("hospital_intro", "targetname");
  level.player enablephysicaldepthoffieldscripting();
  level thread scripts\engine\sp\utility::dof_enable(1.4, 10000, 20);
  wait 4;
  level thread scripts\engine\sp\utility::dof_enable(1.4, 300, 20);
  wait 3;
  level thread scripts\engine\sp\utility::dof_enable(1.4, 250, 2);
  wait 2;
  wait 3;

  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }

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

function wolf_takedown_cam_start() {
  setsaveddvar("MPTNKKPKRK", 6);
  scripts\engine\utility::flag_wait("flag_wolf_performing_takedown");
  waitframe();
}

function lighting_setup_dvars() {
  setDvar("r_useCompressedSunShadow", 1);
  setsaveddvar("TMNTMTQRM", 0);
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("LKOLRONRNQ", 800);
  setsaveddvar("MROOOROPKL", 4);
  setsaveddvar("LTQMSPKRKO", 4);
}

function turnon() {
  var0 = getEnt("turn_on_light_trigger", "targetname");
  var1 = getEnt("stair_light", "targetname");
  var1.tempintensity = var1 getlightintensity();
  scripts\engine\sp\utility::trigger_wait("turn_on_light_trigger", "targetname");

  while(level.player istouching(var0)) {
    var1 setlightintensity(var1.tempintensity);
    wait 0.1;
  }

  thread turnon();
}

function turnoff() {
  var0 = getEnt("turn_off_light_trigger", "targetname");
  var1 = getEnt("stair_light", "targetname");
  scripts\engine\sp\utility::trigger_wait("turn_off_light_trigger", "targetname");

  while(level.player istouching(var0)) {
    var1 setlightintensity(0);
    wait 0.1;
  }

  thread turnoff();
}

function sun_adjustments_murderhole_building() {}

function sun_adjustments_hospital_trigger(var0, var1) {
  var2 = getEnt(var0 + "_" + var1, "targetname");

  if(!isDefined(var2)) {
    return;
  }

  scripts\engine\sp\utility::trigger_wait_targetname(var0 + "_" + var1);
  sun_adjustments_register_trigger(var0, var1);
}

function sun_adjustments_hospital_force(var0, var1) {
  var2 = getEnt(var0 + "_" + var1, "targetname");

  if(!isDefined(var2)) {
    return;
  }

  sun_adjustments_register_trigger(var0, var1);
}

function sun_adjustments_register_trigger(var0, var1) {
  waitframe();
  var2 = getEnt(var0 + "_" + var1, "targetname");
  var3 = var2.script_sunsamplesizenear;
  var4 = var2.script_sunshadowscale;
  var5 = var2.script_sunenable;

  if(isDefined(var3)) {}

  if(isDefined(var5) && var5 > 0) {}

  if(isDefined(var4)) {
    setsuncolorandintensity(var4);

    if(var4 > 0) {
      waitframe();
      setsaveddvar("OMKTSMSOS", 3);
    }
  }

  thread sun_adjustments_hospital_trigger(var0, var1 + 1);
  thread sun_adjustments_hospital_trigger(var0, var1 - 1);
}

function flickerlightmh() {
  var0 = getEntArray("flicker_light_mh", "script_noteworthy");

  foreach(var2 in var0) {
    thread flickersinglelight();
  }
}

function flickersinglelight() {
  self endon("stopflicker");

  for(;;) {
    var0 = sin(gettime() * 123) * 0.3 + 0.3;
    self setlightintensity(5);
    wait var0;
    self setlightintensity(15);
    var0 = sin(gettime() * 123) * 0.3 + 0.3;
    wait var0;
  }
}

function flickersource() {
  var0 = getEntArray("flicker_source", "targetname");

  for(;;) {
    foreach(var2 in var0) {
      var3 = 0.1 + randomfloat(1);
      var2 setlightintensity(var3);
    }

    wait 0.1;
  }

  thread flickersource();
}

function flickerfire() {
  var0 = getEntArray("flicker_fire", "targetname");

  for(;;) {
    var1 = 5 + randomfloat(5);

    foreach(var3 in var0) {
      var3 setlightintensity(var1);
    }

    wait 0.06;
  }

  thread flickersource();
}