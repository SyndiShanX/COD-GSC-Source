/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_640f33037ba8d927.gsc
*************************************************/

#using scripts\engine\utility;
#using scripts\mp\gametypes\br_pickups;
#namespace namespace_1d412d516148e9b4;

function init() {
  level thread function_6ef0f16edb152d68();
}

function function_6ef0f16edb152d68() {
  while(!istrue(game["gamestarted"])) {
    waitframe();
  }

  level thread function_e7501d779917972();
}

function function_e7501d779917972() {
  structs = getStructArray("spaceshipment_loot_crate_lege", "targetname");
  geo = getEnt("space_shipment_geo", "targetname");

  foreach(struct in structs) {
    if(!isDefined(struct.angles)) {
      struct.angles = (0, 0, 0);
    }

    instance = spawnscriptable("br_loot_cache_lege", struct.origin, struct.angles);

    if(!isDefined(instance)) {
      continue;
    }

    scripts\mp\gametypes\br_pickups::registerscriptableinstance(instance);
    localorigin = rotatevectorinverted(instance.origin - geo.origin, geo.angles);
    localangles = combineangles(invertangles(geo.angles), instance.angles);
    instance scriptablesetparententity(geo, localorigin, localangles);
    instance setscriptablepartstate("body", "closed_usable");
  }

  structs = getStructArray("buy_station_space_shipment", "targetname");

  foreach(struct in structs) {
    if(!isDefined(struct.angles)) {
      struct.angles = (0, 0, 0);
    }

    instance = spawnscriptable("br_plunder_box", struct.origin, struct.angles);

    if(!isDefined(instance)) {
      continue;
    }

    scripts\mp\gametypes\br_pickups::registerscriptableinstance(instance);
    localorigin = rotatevectorinverted(instance.origin - geo.origin, geo.angles);
    localangles = combineangles(invertangles(geo.angles), instance.angles);
    instance scriptablesetparententity(geo, localorigin, localangles);
    instance setscriptablepartstate("body", "closed_usable");
  }
}