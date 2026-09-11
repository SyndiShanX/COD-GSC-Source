/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\estate\estate_lighting.gsc
******************************************************/

function main() {
  scripts\engine\sp\utility::post_load_precache(&post_load);
  thread lighting_flags();
  thread lighting_intro();
  thread lighting_gate();
  thread lighting_mansion_fire_1();
  thread lighting_mansion_fire_2();
  thread lighting_escape();
  thread lighting_tunnel();
}

function post_load() {
  thread lighting_setup_dvars();
}

function lighting_setup_dvars() {
  setsaveddvar("MPOKKOPMTN", "128 384 768 2304");
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 2);
  wait 1;
  setsaveddvar("LTQMSPKRKO", 8);
  setsaveddvar("MROOOROPKL", 10);
  setsaveddvar("LKOLRONRNQ", 550);
}

function lighting_flags() {
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

function lerp_woods_sunlight() {
  var0 = scripts\engine\utility::getStruct("lt_woods_start", "targetname").origin;
  var1 = scripts\engine\utility::getStruct("lt_woods_end", "targetname").origin;
  var2 = vectortoangles(var1 - var0);
  var3 = vectortoangles(var0 - var1);
  var4 = distance(var0, var1);
  level endon("rappel_start");

  for(;;) {
    var5 = scripts\engine\math::get_dot(var0, var2, level.player.origin);
    var6 = scripts\engine\math::get_dot(var1, var3, level.player.origin);

    if(var5 <= 0) {
      var7 = 0.01;
    } else if(var6 <= 0) {
      var7 = 0;
    } else {
      var8 = vectorfromlinetopoint(var0, var1, level.player.origin);
      var9 = level.player.origin - var8;
      var10 = distance(var0, var9);
      var11 = scripts\engine\math::normalize_value(0, var4, var10);
      var7 = 0.01 + -0.01 * var11;
    }

    setsuncolorandintensity(var7);

    if(var7 == 0) {
      level notify("hide_moon");
    }

    waitframe();
  }
}

function init_lights(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var3.og_intensity = var3 getlightintensity();
  }
}

function lights_off(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    if(!isDefined(var3.og_intensity)) {
      var3.og_intensity = var3 getlightintensity();
    }

    var3 setlightintensity(0);
  }
}

function lights_on(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    if(!isDefined(var3.og_intensity)) {
      iprintln("light with targetname" + var0 + " has no stored intensity");
      continue;
    }

    var3 setlightintensity(var3.og_intensity);
  }
}

function lighting_intro() {
  scripts\engine\utility::flag_wait("lighting_intro");
  lights_on("lt_intro_fill");
  lights_on("lt_intro_rim");
}

function lighting_gate() {
  scripts\engine\utility::flag_wait("at_woods");
  setsaveddvar("LKOLRONRNQ", 1500);
  scripts\engine\utility::flag_wait("player_entered_bushes_gate");
  setsaveddvar("LKOLRONRNQ", 550);
}

function lighting_mansion_fire_1() {
  scripts\engine\utility::flag_wait("lighting_fire_obj_room");
  visionsetnaked("estate_escape_mansion", 6);
  wait 1.5;
  lights_on("lt_mansion_fire_obj");
  scripts\engine\utility::flag_set("lighting_fire_obj_room_hero");
  var0 = getEnt("lt_mansion_fire_obj_hero", "targetname");
  var0 setlightintensity(0.25);
}

function lighting_mansion_fire_2() {
  scripts\engine\utility::flag_wait("lighting_fire_hallways");
  visionsetnaked("estate_escape_mansion", 0);
  lights_on("lt_mansion_fire_hallways");
  lights_on("lt_mansion_heli_searchlight");
  scripts\engine\utility::flag_wait("lighting_fire_collapse");
  visionsetnaked("estate_escape_outdoors", 1);
  lights_on("lt_mansion_fire_collapse");
  lights_on("lt_escape");
  var0 = getEnt("lt_mansion_fire_collapse_hero", "targetname");
  var0 setlightintensity(0.08);
}

function lighting_escape() {
  scripts\engine\utility::flag_wait("lighting_escape");
  visionsetnaked("estate_escape_outdoors", 0);
  scripts\engine\utility::flag_set("lighting_fire_collapse");
  lights_on("lt_mansion_fire_collapse");
  lights_on("lt_escape");
}

function lighting_tunnel() {
  scripts\engine\utility::flag_wait("lighting_tunnel");
  visionsetnaked("estate_tunnel", 2);
  wait 1;
  lights_on("lt_tunnel_hero");
  wait 11.5;
  lights_off("lt_tunnel_hero");
  lights_on("lt_tunnel_hero_key2");
}