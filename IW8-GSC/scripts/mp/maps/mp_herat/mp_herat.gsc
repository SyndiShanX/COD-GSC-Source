/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_herat\mp_herat.gsc
*************************************************/

function main() {
  scripts\mp\maps\mp_herat\mp_herat_precache::main();
  scripts\mp\maps\mp_herat\gen\mp_herat_art::main();
  scripts\mp\maps\mp_herat\mp_herat_fx::main();
  scripts\mp\maps\mp_herat\mp_herat_lighting::main();
  scripts\mp\load::main();
  setDvar("mantle_force_legacy_system", 1);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_herat", "codcaster_compass_map_mp_herat");
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  var0 = getEnt("infil_van_col", "targetname");

  if(isDefined(var0)) {
    var0 hide();
    var0 connectpaths();
  }

  thread scripts\mp\animation_suite::animationsuite();
  thread spawnstaticvan();
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
    foreach(var1 in [[scripts\cp_mp\utility\script_utility::getsharedfunc("infil", "get_all_infils")]]()) {
      if(var1.script_noteworthy != "infil_van_hackney") {
        continue;
      }

      if(var1.name != "alpha") {
        continue;
      }

      game["infil"]["types"]["infil_van_hackney"]["alpha"]["vehicleOrg"] = (-2957, -720.5, 87.5);
      game["infil"]["types"]["infil_van_hackney"]["alpha"]["vehicleAng"] = (0, 180, 0);
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("infil", "spawnPersistentVan")]]("infil_van_hackney", "alpha");
      break;
    }

    return;
  }
}