/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\estate\estate_lighting.gsc
***********************************************/

main() {
  scripts\engine\sp\utility::post_load_precache(::post_load);
  thread lighting_flags();
  thread lighting_intro();
  thread lighting_gate();
  thread lighting_mansion_fire_1();
  thread lighting_mansion_fire_2();
  thread lighting_escape();
  thread lighting_tunnel();
}

post_load() {
  thread lighting_setup_dvars();
}

lighting_setup_dvars() {
  setsaveddvar("MPOKKOPMTN", "128 384 768 2304");
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 2);
  wait 1;
  setsaveddvar("LTQMSPKRKO", 8);
  setsaveddvar("MROOOROPKL", 10);
  setsaveddvar("LKOLRONRNQ", 550);
}

lighting_flags() {
  scripts\engine\utility::flag_init("lighting_intro");
  scripts\engine\utility::flag_init("at_woods");
  scripts\engine\utility::flag_init("player_entered_bushes_gate");
  scripts\engine\utility::flag_init("lighting_heli_attack");
  scripts\engine\utility::flag_init("lighting_fire_obj_room");
  scripts\engine\utility::flag_init("lighting_fire_hallways");
  scripts\engine\utility::flag_init("lighting_fire_collapse");
  scripts\engine\utility::flag_init("lighting_escape");
  scripts\engine\utility::flag_init("obj_scene_started");
  scripts\engine\utility::flag_init("lighting_fire_obj_room_hero");
  scripts\engine\utility::flag_init("lighting_tunnel");
  init_lights("lt_intro_fill");
  init_lights("lt_intro_rim");
  init_lights("lt_mansion_fire_obj");
  init_lights("lt_mansion_fire_hallways");
  init_lights("lt_mansion_fire_collapse");
  init_lights("lt_mansion_heli_searchlight");
  init_lights("lt_escape");
  init_lights("lt_tunnel_hero");
  init_lights("lt_tunnel_hero_key2");
  init_lights("lt_fireplace");
  lights_off("lt_intro_fill");
  lights_off("lt_intro_rim");
  lights_off("lt_mansion_fire_obj");
  lights_off("lt_mansion_fire_hallways");
  lights_off("lt_mansion_fire_collapse");
  lights_off("lt_mansion_heli_searchlight");
  lights_off("lt_escape");
  lights_off("lt_tunnel_hero");
  lights_off("lt_tunnel_hero_key2");
  lights_on("lt_fireplace");
}

lerp_woods_sunlight() {
  var_0 = scripts\engine\utility::getStruct("lt_woods_start", "targetname").origin;
  var_1 = scripts\engine\utility::getStruct("lt_woods_end", "targetname").origin;
  var_2 = vectortoangles(var_1 - var_0);
  var_3 = vectortoangles(var_0 - var_1);
  var_4 = distance(var_0, var_1);
  level endon("rappel_start");

  for(;;) {
    var_5 = scripts\engine\math::get_dot(var_0, var_2, level.player.origin);
    var_6 = scripts\engine\math::get_dot(var_1, var_3, level.player.origin);

    if(var_5 <= 0)
      var_7 = 0.01;
    else if(var_6 <= 0)
      var_7 = 0;
    else {
      var_8 = vectorfromlinetopoint(var_0, var_1, level.player.origin);
      var_9 = level.player.origin - var_8;
      var_10 = distance(var_0, var_9);
      var_11 = scripts\engine\math::normalize_value(0, var_4, var_10);
      var_7 = 0.01 + -0.01 * var_11;
    }

    setsuncolorandintensity(var_7);

    if(var_7 == 0)
      level notify("hide_moon");

    waitframe();
  }
}

init_lights(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1)
  var_3.og_intensity = var_3 getlightintensity();
}

lights_off(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.og_intensity))
      var_3.og_intensity = var_3 getlightintensity();

    var_3 setlightintensity(0);
  }
}

lights_on(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.og_intensity)) {
      iprintln("light with targetname" + var_0 + " has no stored intensity");
      continue;
    }

    var_3 setlightintensity(var_3.og_intensity);
  }
}

lighting_intro() {
  scripts\engine\utility::flag_wait("lighting_intro");
  lights_on("lt_intro_fill");
  lights_on("lt_intro_rim");
}

lighting_gate() {
  scripts\engine\utility::flag_wait("at_woods");
  setsaveddvar("LKOLRONRNQ", 1500);
  scripts\engine\utility::flag_wait("player_entered_bushes_gate");
  setsaveddvar("LKOLRONRNQ", 550);
}

lighting_mansion_fire_1() {
  scripts\engine\utility::flag_wait("lighting_fire_obj_room");
  visionsetnaked("estate_escape_mansion", 6);
  wait 1.5;
  lights_on("lt_mansion_fire_obj");
  scripts\engine\utility::flag_set("lighting_fire_obj_room_hero");
  var_0 = getEnt("lt_mansion_fire_obj_hero", "targetname");
  var_0 setlightintensity(0.25);
}

lighting_mansion_fire_2() {
  scripts\engine\utility::flag_wait("lighting_fire_hallways");
  visionsetnaked("estate_escape_mansion", 0);
  lights_on("lt_mansion_fire_hallways");
  lights_on("lt_mansion_heli_searchlight");
  scripts\engine\utility::flag_wait("lighting_fire_collapse");
  visionsetnaked("estate_escape_outdoors", 1);
  lights_on("lt_mansion_fire_collapse");
  lights_on("lt_escape");
  var_0 = getEnt("lt_mansion_fire_collapse_hero", "targetname");
  var_0 setlightintensity(0.08);
}

lighting_escape() {
  scripts\engine\utility::flag_wait("lighting_escape");
  visionsetnaked("estate_escape_outdoors", 0);
  scripts\engine\utility::flag_set("lighting_fire_collapse");
  lights_on("lt_mansion_fire_collapse");
  lights_on("lt_escape");
}

lighting_tunnel() {
  scripts\engine\utility::flag_wait("lighting_tunnel");
  visionsetnaked("estate_tunnel", 2);
  wait 1;
  lights_on("lt_tunnel_hero");
  wait 11.5;
  lights_off("lt_tunnel_hero");
  lights_on("lt_tunnel_hero_key2");
}