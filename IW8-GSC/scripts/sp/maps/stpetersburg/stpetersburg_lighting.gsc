/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_lighting.gsc
******************************************************************/

function main() {
  scripts\engine\sp\utility::post_load_precache(&post_load);
  flaginit();
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("LSNRQTOKRR", 1);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  setsaveddvar("LKOLRONRNQ", 500);
  thread lighting_pre_alley_to_apartments();
  thread lighting_alley_to_apartments();
  thread lighting_in_apartments();
  thread lighting_apartments_to_canal();
  thread lighting_canal_to_cafe();
  thread lighting_in_cafe();
  thread lighting_interrogation();
  thread lighting_interrogation_room();
  thread lighting_interrogation_intro_cinematic();
  thread lighting_interrogation_outro();
  thread dof_interrogation_enforcer();
  thread apartment_enforcer_grenade();
  thread motion_blur();
}

function flaginit() {
  scripts\engine\utility::flag_init("lighting_pre_alley_to_apartments");
  scripts\engine\utility::flag_init("lighting_alley_to_apartments");
  scripts\engine\utility::flag_init("lighting_in_apartments");
  scripts\engine\utility::flag_init("lighting_apartments_to_canal");
  scripts\engine\utility::flag_init("lighting_canal_to_cafe");
  scripts\engine\utility::flag_init("lighting_in_cafe");
  scripts\engine\utility::flag_init("lighting_interrogation");
  scripts\engine\utility::flag_init("lighting_interrogation_intro_cinematic");
  scripts\engine\utility::flag_init("lighting_interrogation_gameplay");
  scripts\engine\utility::flag_init("lighting_interrogation_outro_cinematic");
  scripts\engine\utility::flag_init("warning_accepted");
  scripts\engine\utility::flag_init("flag_apartment_grenade_explosion");
  scripts\engine\utility::flag_init("flag_acquire_turn_on_cop_siren_lights");
  scripts\engine\utility::flag_init("motion_blur_on");
  scripts\engine\utility::flag_init("motion_blur_off");
  scripts\engine\utility::flag_init("camera_intro_dof_on");
  scripts\engine\utility::flag_init("camera_intro_dof_rack");
  scripts\engine\utility::flag_init("camera_intro_dof_off");
}

function post_load() {
  thread lighting_setup_dvars();
}

function lighting_setup_dvars() {
  setsaveddvar("MROOOROPKL", 8);
  setsaveddvar("LTQMSPKRKO", 8);
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  setsaveddvar("LKOLRONRNQ", 500);
}

function flycam_intro_start() {
  level endon("intro_scene_skipped");
  setsaveddvar("MROOOROPKL", 8);
  setsaveddvar("LTQMSPKRKO", 8);
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  setsaveddvar("MRSTKSMMP", 1);
  setsaveddvar("LKOLRONRNQ", 500);
  waitframe();
  waitframe();
  scripts\engine\sp\utility::motion_blur_enable(1, 0.5);
  level scripts\engine\sp\utility::delaychildthread(0.1, &scripts\engine\sp\utility::dof_enable, 8, 1000, 1);
  wait 2;
  var0 = 5;
  level scripts\engine\sp\utility::delaychildthread(var0, &scripts\engine\sp\utility::dof_enable, 1, 1000, 1);
  var0 = 12;
  level scripts\engine\sp\utility::delaychildthread(var0, &scripts\engine\sp\utility::dof_enable, 1, 300, 1);
  var0 = 21.5;
  level.enforcer scripts\engine\sp\utility::delaychildthread(var0, &scripts\engine\sp\utility::dof_enable_autofocus, 1.2, 1);
  var0 = 23.3;
  level.enforcer scripts\engine\sp\utility::delaychildthread(var0, &scripts\engine\sp\utility::dof_enable_autofocus, 3.5, 1);
  var0 = 29.1;
  level.price scripts\engine\sp\utility::delaychildthread(var0, &scripts\engine\sp\utility::dof_enable_autofocus, 2, 1);
  var0 = 35;
  level.nikolai scripts\engine\sp\utility::delaychildthread(var0, &scripts\engine\sp\utility::dof_enable_autofocus, 2, 1);
  var0 = 37;
  level.player scripts\engine\sp\utility::delaychildthread(var0, &scripts\engine\sp\utility::dof_disable);
  scripts\engine\sp\utility::motion_blur_disable(0.5);
}

function motion_blur() {
  var0 = scripts\engine\utility::flag_wait_any_return("motion_blur_on", "motion_blur_off");

  if(var0 == "motion_blur_on") {
    waitframe();
    scripts\engine\sp\utility::motion_blur_enable(1, 0.5, 1);
  }

  scripts\engine\utility::flag_wait("motion_blur_off");
  scripts\engine\sp\utility::motion_blur_disable(1);
  scripts\engine\utility::flag_clear("motion_blur_off");
  scripts\engine\utility::flag_clear("motion_blur_on");
  thread motion_blur();
}

function lighting_pre_alley_to_apartments() {
  scripts\engine\utility::flag_wait("lighting_pre_alley_to_apartments");
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("QPLMKRON", 1);
  setsaveddvar("LKOLRONRNQ", 500);
  scripts\engine\utility::flag_clear("lighting_pre_alley_to_apartments");
  wait 0.2;
  thread lighting_pre_alley_to_apartments();
}

function lighting_alley_to_apartments() {
  scripts\engine\utility::flag_wait("lighting_alley_to_apartments");
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("QPLMKRON", 1);
  setsaveddvar("LKOLRONRNQ", 500);
  scripts\engine\utility::flag_clear("lighting_alley_to_apartments");
  wait 0.2;
  thread lighting_alley_to_apartments();
}

function lerpalleysunshadow(var0) {
  self waittill("trigger");

  while(level.player istouching(self)) {
    var1 = vectorNormalize(var0.origin - level.player.origin);
    var2 = anglesToForward(level.player.angles);
    var3 = clamp(vectordot(var1, var2), 0, 1);
    setsaveddvar("NPONLLLSPL", 0.47 + 0.3 * var3);
    wait 0.1;
  }

  thread lerpalleysunshadow(var0);
}

function lighting_in_apartments() {
  scripts\engine\utility::flag_wait("lighting_in_apartments");
  visionsetnaked("", 0);
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("LSNRQTOKRR", 1);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("QPLMKRON", 1);
  setsaveddvar("LKOLRONRNQ", 500);
  scripts\engine\utility::flag_clear("lighting_in_apartments");
  wait 0.2;
  thread lighting_in_apartments();
}

function lighting_apartments_to_canal() {
  scripts\engine\utility::flag_wait("lighting_apartments_to_canal");
  visionsetnaked("", 0);
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("LSNRQTOKRR", 1);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("QPLMKRON", 1);
  setsaveddvar("LKOLRONRNQ", 500);
  scripts\engine\utility::flag_clear("lighting_apartments_to_canal");
  wait 0.2;
  thread lighting_apartments_to_canal();
}

function lighting_canal_to_cafe() {
  scripts\engine\utility::flag_wait("lighting_canal_to_cafe");
  visionsetnaked("", 0);
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("LSNRQTOKRR", 1);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("QPLMKRON", 1);
  setsaveddvar("LKOLRONRNQ", 500);
  scripts\engine\utility::flag_clear("lighting_canal_to_cafe");
  wait 0.2;
  thread lighting_canal_to_cafe();
}

function lighting_in_cafe() {
  scripts\engine\utility::flag_wait("lighting_in_cafe");
  visionsetnaked("", 0);
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("LSNRQTOKRR", 1);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("QPLMKRON", 1);
  setsaveddvar("LKOLRONRNQ", 500);
  scripts\engine\utility::flag_clear("lighting_in_cafe");
  wait 0.2;
  thread lighting_in_cafe();
}

function apartment_enforcer_grenade() {
  scripts\engine\utility::flag_wait("flag_apartment_grenade_explosion");
  waitframe();
  scripts\engine\sp\utility::motion_blur_enable(1, 0.5, 1);
  var0 = getEnt("apartment_grenade_light_01", "targetname");
  var1 = getEnt("apartment_grenade_light_scriptable", "targetname");
  var0 setlightintensity(0.001);
  var0 setlightradius(0.001);
  var1 setscriptablepartstate("base", "dead");
  wait 8;
  scripts\engine\sp\utility::motion_blur_disable(1);
}

function lighting_interrogation() {
  scripts\engine\utility::flag_wait("lighting_interrogation");
  setsaveddvar("NPONLLLSPL", 0.45);
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("LSNRQTOKRR", 1);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("QPLMKRON", 1);
  setsaveddvar("MROOOROPKL", 8);
  setsaveddvar("LTQMSPKRKO", 8);
  setsaveddvar("MPOKKOPMTN", "32 64 128 256");
  setsaveddvar("LKOLRONRNQ", 500);
  visionsetnaked("", 0);
  scripts\engine\utility::flag_clear("lighting_interrogation");
  wait 0.2;
  thread lighting_interrogation();
}

function dof_interrogation_van_open() {
  waitframe();
  scripts\engine\sp\utility::motion_blur_enable(1, 0.5);
  thread interrogation_van_light_on();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(4, 20, 2, 2);
  wait 1.8;
  level.player setphysicaldepthoffield(4, 90, 4, 2);
  wait 2;
  level.player setphysicaldepthoffield(8, 70, 5, 2);
  wait 2;
  level.nikolai thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 10, undefined, undefined, "tag_eye");
  wait 2;
  level.nikolai thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 10, undefined, undefined, "tag_eye");
  wait 4;
  level.player setphysicaldepthoffield(4, 95, 3, 3);
  wait 2;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(4, 6, 2, undefined);
  scripts\engine\utility::flag_waitopen("van_retrieve_package");
  level.player enablephysicaldepthoffieldscripting();
  wait 0.25;
  level.player setphysicaldepthoffield(2, 20, 3, 3);
  wait 1;
  level.player setphysicaldepthoffield(2, 50, 2, 2);
  wait 1.5;
  level.player setphysicaldepthoffield(2, 30, 2, 2);
  wait 1.5;
  level.player setphysicaldepthoffield(1, 11, 3, 3);
  wait 0.75;
  level.player setphysicaldepthoffield(4, 40, 3, 3);
  wait 0.85;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(4, 6, 2, undefined);
}

function interrogation_van_light_on() {
  wait 1.5;
  var0 = getEnt("van_interiorlight_spot", "targetname");
  var0 setlightintensity(2);
  var1 = getEnt("van_interiorlight_omni", "targetname");
  var1 setlightintensity(0.05);
  var2 = getEnt("van_interiorLight_sun", "targetname");
  var2 setlightintensity(4);
}

function lighting_interrogation_intro_cinematic() {
  scripts\engine\utility::flag_wait("lighting_interrogation_intro_cinematic");
  visionsetnaked("", 0);
  var0 = getEnt("interrogation_price_spot_fill", "targetname");
  var0 setlightintensity(0);
  var1 = getEnt("interrogation_price_spot_rim", "targetname");
  var1 setlightintensity(0.5);
  var2 = getEnt("price_spot_door_key", "targetname");
  var2 setlightintensity(1.5);
  var3 = getEnt("interrogation_spot_yagor_key", "targetname");
  var3 setlightintensity(0.2);
  var4 = getEnt("interrogation_enforcer_spot_rim", "targetname");
  var4 setlightintensity(0.3);
  var5 = getEnt("interrogation_enforcer_spot_rim_b", "targetname");
  var5 setlightintensity(0.005);
  var6 = getEnt("interrogation_kyle_spot_fill", "targetname");
  var6 setlightintensity(0.4);
  var7 = getEnt("interrogation_spot_kyle_rim", "targetname");
  var7 setlightintensity(0.4);
  var8 = getEnt("interrogation_spot_kyle_key", "targetname");
  var8 setlightintensity(0.4);
  var9 = getEnt("interrogation_room_spot_fill", "targetname");
  var9 setlightintensity(0);
  var10 = getEnt("canister_spot_fill", "targetname");
  var10 setlightintensity(0);
  scripts\engine\utility::flag_clear("lighting_interrogation_intro_cinematic");
  wait 0.2;
  thread lighting_interrogation_intro_cinematic();
}

function dof_interrogation_enforcer() {
  scripts\engine\utility::flag_wait("warning_accepted");
  wait 4;
  level.player enablephysicaldepthoffieldscripting(1);
  level.enforcer thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 10, undefined, undefined, "tag_eye");
  wait 10;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(4, 6, 2, undefined);
  var0 = getEnt("price_spot_door_key", "targetname");
  var0 setlightintensity(1);
  scripts\engine\utility::flag_clear("warning_accepted");
  wait 0.2;
  thread lighting_interrogation_intro_cinematic();
}

function lighting_interrogation_room() {
  scripts\engine\utility::flag_wait("lighting_interrogation_gameplay");
  visionsetnaked("", 0);
  var0 = getEnt("interrogation_price_spot_fill", "targetname");
  var0 setlightintensity(0.1);
  var1 = getEnt("interrogation_price_spot_rim", "targetname");
  var1 setlightintensity(0);
  var2 = getEnt("price_spot_door_key", "targetname");
  var2 setlightintensity(1.5);
  var3 = getEnt("interrogation_spot_yagor_key", "targetname");
  var3 setlightintensity(0.2);
  var4 = getEnt("interrogation_enforcer_spot_rim", "targetname");
  var4 setlightintensity(0);
  var5 = getEnt("interrogation_enforcer_spot_rim_b", "targetname");
  var5 setlightintensity(0.01);
  var6 = getEnt("interrogation_kyle_spot_fill", "targetname");
  var6 setlightintensity(0);
  var7 = getEnt("interrogation_spot_kyle_rim", "targetname");
  var7 setlightintensity(0);
  var8 = getEnt("interrogation_spot_kyle_key", "targetname");
  var8 setlightintensity(0);
  var9 = getEnt("interrogation_room_spot_fill", "targetname");
  var9 setlightintensity(0.35);
  var10 = getEnt("canister_spot_fill", "targetname");
  var10 setlightintensity(0);
  level.player enablephysicaldepthoffieldscripting(1);
  level.nikolai thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 90, undefined, undefined, "tag_eye");
  wait 10;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(4, 6, 2, undefined);
  scripts\engine\utility::flag_clear("lighting_interrogation_gameplay");
  wait 0.2;
  thread lighting_interrogation_room();
}

function lighting_interrogation_outro() {
  scripts\engine\utility::flag_wait("lighting_interrogation_outro_cinematic");
  visionsetnaked("", 0);
  var0 = getEnt("interrogation_room_spot_fill", "targetname");
  var0 setlightintensity(0);
  var1 = getEnt("interrogation_enforcer_spot_rim_b", "targetname");
  var1 setlightintensity(0.2);
  var2 = getEnt("interrogation_spot_yagor_key", "targetname");
  var2 setlightintensity(0);
  var3 = getEnt("interrogation_kyle_spot_fill", "targetname");
  var3 setlightintensity(2);
  var4 = getEnt("interrogation_spot_kyle_key", "targetname");
  var4 setlightintensity(0);
  var5 = getEnt("price_spot_door_key", "targetname");
  var5 setlightintensity(0.1);
  var6 = getEnt("canister_spot_fill", "targetname");
  var6 setlightintensity(1);
  scripts\engine\utility::flag_clear("lighting_interrogation_outro_cinematic");
  wait 0.2;
  thread lighting_interrogation_room();
}

function dof_interrogation_revolver_pickup() {
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  level.player enablephysicaldepthoffieldscripting(1);
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(8, 10, 0.75, 2);
  wait 2;
  level.player setphysicaldepthoffield(8, 58, 1, 2);
  wait 1;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(8, 6, 2, undefined);
}