/***********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jalo_oasis\mp_jalo_oasis.gsc
***********************************************************/

main() {
  scripts\mp\maps\mp_jalo_oasis\mp_jalo_oasis_precache::main();
  scripts\mp\maps\mp_jalo_oasis\gen\mp_jalo_oasis_art::main();
  scripts\mp\maps\mp_jalo_oasis\mp_jalo_oasis_fx::main();
  scripts\mp\maps\mp_jalo_oasis\mp_jalo_oasis_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_jalo_oasis");
  setDvar("#x32ee39981452e9751", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_F7AA = 0;
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  _func_0446(48);
  scripts\mp\gametypes\skulls::init();
  setDvar("#x331157d6a11c2a653", 3000.0);
  setDvar("#x3b94d9d617f14e388", 1200);
  setDvar("#x36d8bf82840d880d2", 1);
  thread fixpostlaunchspawns();
  thread fixbadpatrollink();
}

fixpostlaunchspawns() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "ctf":
      break;
    case "control":
      break;
    case "sd":
      break;
    case "dm":
    case "gun":
      break;
    case "dom":
      break;
    case "war":
    case "conf":
      break;
    case "patrol":
    case "koth":
      level._id_9FFA["2558 -596"]["mp_patrol_spawn_axis_start"]["remove"] = 1;
      level._id_9FFA["2492 -646"]["mp_patrol_spawn_axis_start"]["remove"] = 1;
      level._id_9FFA["2551 -661"]["mp_patrol_spawn_axis_start"]["remove"] = 1;
      level._id_9FFA["2460 -706"]["mp_patrol_spawn_axis_start"]["remove"] = 1;
      level._id_9FFA["2528 -720"]["mp_patrol_spawn_axis_start"]["remove"] = 1;
      level._id_9FFA["2554 -786"]["mp_patrol_spawn_axis_start"]["remove"] = 1;
      level._id_9FFA["2494 -763"]["mp_patrol_spawn_axis_start"]["remove"] = 1;
      level._id_9FFA["2436 -766"]["mp_patrol_spawn_axis_start"]["remove"] = 1;
      level._id_9FFA["2405 -816"]["mp_patrol_spawn_axis_start"]["remove"] = 1;
      level._id_9FFA["2471 -822"]["mp_patrol_spawn_axis_start"]["remove"] = 1;
      level._id_9FFA["2440 -872"]["mp_patrol_spawn_axis_start"]["remove"] = 1;
      level._id_9FFA["2495 -914"]["mp_patrol_spawn_axis_start"]["remove"] = 1;
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}

fixbadpatrollink() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = scripts\engine\utility::getStructArray("patrol_route", "script_noteworthy");

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::_id_4B8C(var_4.origin, (255.695, -33.187, 122.04)) <= 10) {
      var_4.target = "patrol_route_start";
      continue;
    }

    if(scripts\engine\utility::_id_4B8C(var_4.origin, (422.92, -1340.73, 73.1798)) <= 10) {
      var_0 = var_4;
      continue;
    }

    if(scripts\engine\utility::_id_4B8C(var_4.origin, (1.54836, -1432.77, 73.1802)) <= 10) {
      var_1 = var_4;
    }
  }

  if(isDefined(var_0) && isDefined(var_1)) {
    var_0.target = var_1._id_0481;
  }
}