/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_lighting.gsc
**********************************************************/

main() {
  scripts\engine\sp\utility::post_load_precache(::post_load);
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

flaginit() {
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

post_load() {
  thread lighting_setup_dvars();
}

lighting_setup_dvars() {
  setsaveddvar("MROOOROPKL", 8);
  setsaveddvar("LTQMSPKRKO", 8);
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  setsaveddvar("LKOLRONRNQ", 500);
}

flycam_intro_start() {
  level endon("intro_scene_skipped");
  setsaveddvar("MROOOROPKL", 8);
  setsaveddvar("LTQMSPKRKO", 8);
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  setsaveddvar("MRSTKSMMP", 1);
  setsaveddvar("LKOLRONRNQ", 500);
  waitframe();
  waitframe();
  scripts\engine\sp\utility::motion_blur_enable(1, 0.5);
  level scripts\engine\sp\utility::delaychildthread(0.1, scripts\engine\sp\utility::dof_enable, 8, 1000, 1);
  wait 2.0;
  var_0 = 5;
  level scripts\engine\sp\utility::delaychildthread(var_0, scripts\engine\sp\utility::dof_enable, 1, 1000, 1);
  var_0 = 12;
  level scripts\engine\sp\utility::delaychildthread(var_0, scripts\engine\sp\utility::dof_enable, 1, 300, 1);
  var_0 = 21.5;
  level.enforcer scripts\engine\sp\utility::delaychildthread(var_0, scripts\engine\sp\utility::dof_enable_autofocus, 1.2, 1);
  var_0 = 23.3;
  level.enforcer scripts\engine\sp\utility::delaychildthread(var_0, scripts\engine\sp\utility::dof_enable_autofocus, 3.5, 1);
  var_0 = 29.1;
  level.price scripts\engine\sp\utility::delaychildthread(var_0, scripts\engine\sp\utility::dof_enable_autofocus, 2.0, 1);
  var_0 = 35;
  level.nikolai scripts\engine\sp\utility::delaychildthread(var_0, scripts\engine\sp\utility::dof_enable_autofocus, 2.0, 1);
  var_0 = 37;
  level.player scripts\engine\sp\utility::delaychildthread(var_0, scripts\engine\sp\utility::dof_disable);
  scripts\engine\sp\utility::motion_blur_disable(0.5);
}

motion_blur() {
  var_0 = scripts\engine\utility::flag_wait_any_return("motion_blur_on", "motion_blur_off");

  if(var_0 == "motion_blur_on") {
    waitframe();
    scripts\engine\sp\utility::motion_blur_enable(1, 0.5, 1);
  }

  scripts\engine\utility::flag_wait("motion_blur_off");
  scripts\engine\sp\utility::motion_blur_disable(1);
  scripts\engine\utility::flag_clear("motion_blur_off");
  scripts\engine\utility::flag_clear("motion_blur_on");
  thread motion_blur();
}

lighting_pre_alley_to_apartments() {
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

lighting_alley_to_apartments() {
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

lerpalleysunshadow(var_0) {
  self waittill("trigger");

  while(level.player istouching(self)) {
    var_1 = vectorNormalize(var_0.origin - level.player.origin);
    var_2 = anglesToForward(level.player.angles);
    var_3 = clamp(vectordot(var_1, var_2), 0, 1);
    setsaveddvar("NPONLLLSPL", 0.47 + 0.3 * var_3);
    wait 0.1;
  }

  thread lerpalleysunshadow(var_0);
}

lighting_in_apartments() {
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

lighting_apartments_to_canal() {
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

lighting_canal_to_cafe() {
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

lighting_in_cafe() {
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

apartment_enforcer_grenade() {
  scripts\engine\utility::flag_wait("flag_apartment_grenade_explosion");
  waitframe();
  scripts\engine\sp\utility::motion_blur_enable(1, 0.5, 1);
  var_0 = getEnt("apartment_grenade_light_01", "targetname");
  var_1 = getEnt("apartment_grenade_light_scriptable", "targetname");
  var_0 setlightintensity(0.001);
  var_0 setlightradius(0.001);
  var_1 setscriptablepartstate("base", "dead");
  wait 8.0;
  scripts\engine\sp\utility::motion_blur_disable(1);
}

lighting_interrogation() {
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

dof_interrogation_van_open() {
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
  level thread scripts\engine\sp\utility::dof_enable_autofocus(4.0, 6.0, 2.0, undefined);
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
  level thread scripts\engine\sp\utility::dof_enable_autofocus(4.0, 6.0, 2.0, undefined);
}

interrogation_van_light_on() {
  wait 1.5;
  var_0 = getEnt("van_interiorlight_spot", "targetname");
  var_0 setlightintensity(2.0);
  var_1 = getEnt("van_interiorlight_omni", "targetname");
  var_1 setlightintensity(0.05);
  var_2 = getEnt("van_interiorLight_sun", "targetname");
  var_2 setlightintensity(4.0);
}

lighting_interrogation_intro_cinematic() {
  scripts\engine\utility::flag_wait("lighting_interrogation_intro_cinematic");
  visionsetnaked("", 0);
  var_0 = getEnt("interrogation_price_spot_fill", "targetname");
  var_0 setlightintensity(0.0);
  var_1 = getEnt("interrogation_price_spot_rim", "targetname");
  var_1 setlightintensity(0.5);
  var_2 = getEnt("price_spot_door_key", "targetname");
  var_2 setlightintensity(1.5);
  var_3 = getEnt("interrogation_spot_yagor_key", "targetname");
  var_3 setlightintensity(0.2);
  var_4 = getEnt("interrogation_enforcer_spot_rim", "targetname");
  var_4 setlightintensity(0.3);
  var_5 = getEnt("interrogation_enforcer_spot_rim_b", "targetname");
  var_5 setlightintensity(0.005);
  var_6 = getEnt("interrogation_kyle_spot_fill", "targetname");
  var_6 setlightintensity(0.4);
  var_7 = getEnt("interrogation_spot_kyle_rim", "targetname");
  var_7 setlightintensity(0.4);
  var_8 = getEnt("interrogation_spot_kyle_key", "targetname");
  var_8 setlightintensity(0.4);
  var_9 = getEnt("interrogation_room_spot_fill", "targetname");
  var_9 setlightintensity(0.0);
  var_10 = getEnt("canister_spot_fill", "targetname");
  var_10 setlightintensity(0.0);
  scripts\engine\utility::flag_clear("lighting_interrogation_intro_cinematic");
  wait 0.2;
  thread lighting_interrogation_intro_cinematic();
}

dof_interrogation_enforcer() {
  scripts\engine\utility::flag_wait("warning_accepted");
  wait 4;
  level.player enablephysicaldepthoffieldscripting(1);
  level.enforcer thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 10, undefined, undefined, "tag_eye");
  wait 10;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(4.0, 6.0, 2.0, undefined);
  var_0 = getEnt("price_spot_door_key", "targetname");
  var_0 setlightintensity(1.0);
  scripts\engine\utility::flag_clear("warning_accepted");
  wait 0.2;
  thread lighting_interrogation_intro_cinematic();
}

lighting_interrogation_room() {
  scripts\engine\utility::flag_wait("lighting_interrogation_gameplay");
  visionsetnaked("", 0);
  var_0 = getEnt("interrogation_price_spot_fill", "targetname");
  var_0 setlightintensity(0.1);
  var_1 = getEnt("interrogation_price_spot_rim", "targetname");
  var_1 setlightintensity(0.0);
  var_2 = getEnt("price_spot_door_key", "targetname");
  var_2 setlightintensity(1.5);
  var_3 = getEnt("interrogation_spot_yagor_key", "targetname");
  var_3 setlightintensity(0.2);
  var_4 = getEnt("interrogation_enforcer_spot_rim", "targetname");
  var_4 setlightintensity(0.0);
  var_5 = getEnt("interrogation_enforcer_spot_rim_b", "targetname");
  var_5 setlightintensity(0.01);
  var_6 = getEnt("interrogation_kyle_spot_fill", "targetname");
  var_6 setlightintensity(0.0);
  var_7 = getEnt("interrogation_spot_kyle_rim", "targetname");
  var_7 setlightintensity(0.0);
  var_8 = getEnt("interrogation_spot_kyle_key", "targetname");
  var_8 setlightintensity(0.0);
  var_9 = getEnt("interrogation_room_spot_fill", "targetname");
  var_9 setlightintensity(0.35);
  var_10 = getEnt("canister_spot_fill", "targetname");
  var_10 setlightintensity(0.0);
  level.player enablephysicaldepthoffieldscripting(1);
  level.nikolai thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 90, undefined, undefined, "tag_eye");
  wait 10;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(4.0, 6.0, 2.0, undefined);
  scripts\engine\utility::flag_clear("lighting_interrogation_gameplay");
  wait 0.2;
  thread lighting_interrogation_room();
}

lighting_interrogation_outro() {
  scripts\engine\utility::flag_wait("lighting_interrogation_outro_cinematic");
  visionsetnaked("", 0);
  var_0 = getEnt("interrogation_room_spot_fill", "targetname");
  var_0 setlightintensity(0.0);
  var_1 = getEnt("interrogation_enforcer_spot_rim_b", "targetname");
  var_1 setlightintensity(0.2);
  var_2 = getEnt("interrogation_spot_yagor_key", "targetname");
  var_2 setlightintensity(0.0);
  var_3 = getEnt("interrogation_kyle_spot_fill", "targetname");
  var_3 setlightintensity(2.0);
  var_4 = getEnt("interrogation_spot_kyle_key", "targetname");
  var_4 setlightintensity(0.0);
  var_5 = getEnt("price_spot_door_key", "targetname");
  var_5 setlightintensity(0.1);
  var_6 = getEnt("canister_spot_fill", "targetname");
  var_6 setlightintensity(1.0);
  scripts\engine\utility::flag_clear("lighting_interrogation_outro_cinematic");
  wait 0.2;
  thread lighting_interrogation_room();
}

dof_interrogation_revolver_pickup() {
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  level.player enablephysicaldepthoffieldscripting(1);
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(8, 10, 0.75, 2);
  wait 2;
  level.player setphysicaldepthoffield(8, 58, 1, 2);
  wait 1;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(8.0, 6.0, 2.0, undefined);
}