/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_wallco2\mp_m_wallco2.gsc
*********************************************************/

function main() {
  scripts\mp\maps\mp_m_wallco2\mp_m_wallco2_precache::main();
  scripts\mp\maps\mp_m_wallco2\gen\mp_m_wallco2_art::main();
  scripts\mp\maps\mp_m_wallco2\mp_m_wallco2_fx::main();
  scripts\mp\maps\mp_m_wallco2\mp_m_wallco2_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_wallco2", "codcaster_compass_map_mp_m_wallco2");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread monitor();
}

function monitor() {
  level.ref_13dee = getEnt("EggTruckFullCol", "targetname");
  level.ref_13def = getEnt("EggDoorLeft", "targetname");
  level.ref_13df0 = getEnt("EggTruckDoorLeftCol", "targetname");
  level.ref_13df0 linkTo(level.ref_13def);
  level.ref_13df1 = getEnt("EggDoorRight", "targetname");
  level.ref_13df2 = getEnt("EggTruckDoorRightCol", "targetname");
  level.ref_13df2 linkTo(level.ref_13df1);
  level.molotov_trigger_timeout = getEnt("EggBox", "targetname");
  level.molotovrecentlyused = getEntArray("EggRolls", "targetname");

  foreach(var1 in level.molotovrecentlyused) {
    var1 hide();
  }

  level.clear_padding_disables = getEntArray("EggBear", "script_noteworthy");

  foreach(var4 in level.clear_padding_disables) {
    var4 hide();
  }

  thread molotov_store_branch_ents("EggBear1");
}

function molotov_store_branch_ents(var0) {
  var1 = getEnt(var0, "targetname");
  var1 show();
  var1 setCanDamage(1);
  var1 waittill("damage", var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15);
  var1 hide();

  if(isDefined(var1.target)) {
    molotov_store_branch_ents(var1.target);
    return;
  }

  monitor_enemy_death();
}

function monitor_enemy_death() {
  scripts\engine\utility::exploder("last_roll");
  thread ref_13295();

  foreach(var1 in level.molotovrecentlyused) {
    var1 show();
  }

  level.molotov_trigger_timeout hide();
  level.ref_13dee hide();
  level.ref_13dee connectpaths();
  level.ref_13def rotateby((0, -230, 0), 0.5, 0, 0);
  wait 0.05;
  level.ref_13df1 rotateby((0, 270, 0), 0.45, 0, 0);
  wait 0.45;
  level.ref_13def rotateby((0, 30, 0), 1.5, 0, 0.5);
  level.ref_13df1 rotateby((0, -20, 0), 1, 0, 0.25);
}

function ref_13295() {
  thread scripts\engine\utility::play_sound_in_space("scn_wallco_ee_truck_open", (-301, -42, 186));
  thread scripts\engine\utility::play_sound_in_space("mus_wallco_disco", (-124, 2, 222));
  wait 1;
  thread scripts\engine\utility::play_loopsound_in_space("emt_disco_light_01", (-101, 9, 234));
  thread scripts\engine\utility::play_loopsound_in_space("emt_disco_light_02", (-165, -6, 223));
  thread scripts\engine\utility::play_loopsound_in_space("emt_sparkler_lp_01", (-273, -66, 176));
  thread scripts\engine\utility::play_loopsound_in_space("emt_sparkler_lp_02", (-287, -3, 176));
}