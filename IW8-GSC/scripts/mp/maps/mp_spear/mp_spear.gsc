/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_spear\mp_spear.gsc
*************************************************/

function main() {
  scripts\mp\trials\mp_trl_cleararea::keypad_check_levelinput();
  level.music_style = "middle_east";
  scripts\mp\maps\mp_spear\mp_spear_precache::main();
  scripts\mp\maps\mp_spear\gen\mp_spear_art::main();
  scripts\mp\maps\mp_spear\mp_spear_fx::main();
  scripts\mp\maps\mp_spear\mp_spear_lighting::main();
  scripts\mp\load::main();
  level thread scripts\engine\scriptable_door::system_init();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_spear", "codcaster_compass_map_mp_spear");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\door::door_system_init("retract_door_trigger");
  setDvar("PKKMTTRQO", 8);
  setDvar("NOSQLKNSQO", 40);
  setDvar("TSPOQPTMS", 256);
  setDvar("NKLMONNPNN", 768);
  setDvar("NSSMQLPRNT", 0.01);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "desert";
  game["axis_outfit"] = "desert";
  thread managegate();
  thread watchplayerconnect();
  thread spawnstaticvan();
  thread player_fired_gun_monitor();
}

function player_fired_gun_monitor() {
  var_0 = getEnt("mount64", "targetname");
  var_1 = spawn("script_model", (137, 135, 247));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0, 1);
  var_2 = getEnt("clip128x128x8", "targetname");
  var_3 = spawn("script_model", (-904, -76, 264));
  var_3.angles = (0, 270, 70);
  var_3 clonebrushmodeltoscriptmodel(var_2, 1);
  var_4 = getEnt("clip128x128x8", "targetname");
  var_5 = spawn("script_model", (-904, 52, 264));
  var_5.angles = (0, 270, 70);
  var_5 clonebrushmodeltoscriptmodel(var_4, 1);
  var_6 = spawn("script_model", (574, 2183, 192));
  var_6 setModel("me_construction_plank_bridge_a_11");
  var_6.angles = (270, 0, -90);
}

function spawnstaticvan() {
  level waittill("infil_setup_complete");

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("infil", "get_all_infils")) {
    return;
  }

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("infil", "spawnPersistentVan")) {
    return;
  }

  if(!scripts\mp\flags::gameflag("infil_will_run")) {
    foreach(var_1 in [[scripts\cp_mp\utility\script_utility::getsharedfunc("infil", "get_all_infils")]]()) {
      if(var_1.script_noteworthy != "infil_van_hackney") {
        continue;
      }

      if(var_1.name != "alpha") {
        continue;
      }

      game["infil"]["types"]["infil_van_hackney"]["alpha"]["vehicleOrg"] = (-38.8918, 3264, -43);
      game["infil"]["types"]["infil_van_hackney"]["alpha"]["vehicleAng"] = (0, 90, 0);
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("infil", "spawnPersistentVan")]]("infil_van_hackney", "alpha");
      break;
    }

    return;
  }
}

function managegate() {
  level waittill("infil_setup_complete");

  if(!scripts\mp\flags::gameflag("infil_will_run")) {
    return;
  }

  scripts\mp\flags::gameflagwait("infil_started");
  var_0 = getEntArray("infil_barrier", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
  }

  level waittill("prematch_countdown");
  wait 4;

  foreach(var_2 in var_0) {
    var_2 show();
  }
}

function watchplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 streamsetmaterialtouchuntilloaded("vfx_vol_weather_sandstorm_vista_2");
  }
}