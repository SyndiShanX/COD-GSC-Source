/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\uav_mp.gsc
************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\uav;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\killstreaks\remoteuav;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace uav_mp;

function init_uav_mp() {
  level.radarviewtime = 25;
  level.advradarviewtime = getdvarint(@ "hash_9f9e7d3a7b0b123d", 50);
  level.uavblocktime = 23;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("uav", &tryuseuavfromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("counter_uav", &tryuseuavfromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("directional_uav", &tryuseuavfromstruct);
  uav_bundle = level.streakglobals.streakbundles["uav"];
  level.uavsettings = [];
  level.uavsettings["uav"] = spawnStruct();
  level.uavsettings["uav"].timeout = level.radarviewtime;
  level.uavsettings["uav"].health = 999999;
  level.uavsettings["uav"].maxhealth = 450;
  level.uavsettings["uav"].streakname = "uav";
  level.uavsettings["uav"].modelbase = default_to(uav_bundle.uavmodel, "veh9_mil_air_uav_small_mp");
  level.uavsettings["uav"].sound_explode = "mp_uav_explo_dist";
  level.uavsettings["uav"].teamsplash = "used_uav";
  level.uavsettings["uav"].votimeout = "timeout_uav";
  level.uavsettings["uav"].calloutdestroyed = "callout_destroyed_uav";
  level.uavsettings["uav"].addfunc = &uav_addactiveuav;
  level.uavsettings["uav"].removefunc = &uav_removeactiveuav;
  function_7dbeff3d392879b3();
  var_5085fa19030c6eb9 = level.streakglobals.streakbundles["directional_uav"];
  var_30bd814725530611 = "veh9_mil_air_uav_small_mp";

  if(isDefined(var_5085fa19030c6eb9) && isDefined(var_5085fa19030c6eb9.var_30bd814725530611)) {
    var_30bd814725530611 = var_5085fa19030c6eb9.var_30bd814725530611;
  }

  level.uavsettings["directional_uav"] = spawnStruct();
  level.uavsettings["directional_uav"].timeout = level.advradarviewtime;
  level.uavsettings["directional_uav"].health = 999999;
  level.uavsettings["directional_uav"].maxhealth = 2000;
  level.uavsettings["directional_uav"].streakname = "directional_uav";
  level.uavsettings["directional_uav"].modelbase = var_30bd814725530611;
  level.uavsettings["directional_uav"].votimeout = "timeout_directional_uav";
  level.uavsettings["directional_uav"].teamsplash = "used_directional_uav";
  level.uavsettings["directional_uav"].addfunc = &uav_addactiveuav;
  level.uavsettings["directional_uav"].removefunc = &uav_removeactiveuav;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  scripts\engine\utility::registersharedfunc("uav", "remoteUAV_processTaggedAssist", &scripts\mp\killstreaks\remoteuav::remoteuav_processtaggedassist);
  scripts\engine\utility::registersharedfunc("uav", "attachXRays", &function_91be4c07add55c1a);
}

function function_7dbeff3d392879b3() {
  cuav_bundle = level.streakglobals.streakbundles["counter_uav"];

  if(!isDefined(cuav_bundle)) {
    cuav_bundle = spawnStruct();
  }

  level.uavsettings["counter_uav"] = spawnStruct();
  level.uavsettings["counter_uav"].timeout = level.uavblocktime;
  level.uavsettings["counter_uav"].health = 999999;
  level.uavsettings["counter_uav"].maxhealth = 800;
  level.uavsettings["counter_uav"].streakname = "counter_uav";
  level.uavsettings["counter_uav"].modelbase = default_to(cuav_bundle.cuavmodel, "veh8_mil_air_cuniform");
  level.uavsettings["counter_uav"].modelbasealt = default_to(cuav_bundle.var_5aa9050ef59f30d3, "veh8_mil_air_cuniform_east");
  level.uavsettings["counter_uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["counter_uav"].sound_explode = "scrambler_drone_explode";
  level.uavsettings["counter_uav"].votimeout = "counter_uav_timeout";
  level.uavsettings["counter_uav"].vodestroyed = "destroyed_scrambler_drone_guard";
  level.uavsettings["counter_uav"].votimedout = "timeout_scrambler_drone_guard";
  level.uavsettings["counter_uav"].teamsplash = "used_scrambler_drone_guard";
  level.uavsettings["counter_uav"].destroyedsplash = "callout_destroyed_scrambler_drone_guard";
  level.uavsettings["counter_uav"].scorepopup = "destroyed_scrambler_drone_guard";
  level.uavsettings["counter_uav"].calloutdestroyed = "callout_destroyed_counter_uav";
  level.uavsettings["counter_uav"].addfunc = &uav_addactivecounteruav;
  level.uavsettings["counter_uav"].removefunc = &uav_removeactivecounteruav;
}

function function_91be4c07add55c1a(uavmodel) {
  uavmodel setentityhudoutlinedata(3, uavmodel.team);
  return uavmodel;
}