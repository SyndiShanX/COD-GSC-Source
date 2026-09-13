/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\uav_mp.gsc
***********************************************/

init_uav_mp() {
  level.radarviewtime = 25;
  level.advradarviewtime = getdvarint("dvar_9F9E7D3A7B0B123D", 50);
  level.uavblocktime = 23;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("uav", scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("counter_uav", scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("directional_uav", scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct);
  level.uavsettings = [];
  level.uavsettings["uav"] = spawnStruct();
  level.uavsettings["uav"].timeout = level.radarviewtime;
  level.uavsettings["uav"].health = 999999;
  level.uavsettings["uav"].maxhealth = 450;
  level.uavsettings["uav"].streakname = "uav";
  level.uavsettings["uav"].modelbase = "veh9_mil_air_uav_small_mp";
  level.uavsettings["uav"].sound_explode = "mp_uav_explo_dist";
  level.uavsettings["uav"].teamsplash = "used_uav";
  level.uavsettings["uav"].votimeout = "timeout_uav";
  level.uavsettings["uav"].calloutdestroyed = "callout_destroyed_uav";
  level.uavsettings["uav"].addfunc = scripts\cp_mp\killstreaks\uav::_id_A4D3120487C90203;
  level.uavsettings["uav"].removefunc = scripts\cp_mp\killstreaks\uav::_id_0B5950FBC92DB2FA;
  level.uavsettings["directional_uav"] = spawnStruct();
  level.uavsettings["directional_uav"].timeout = level.advradarviewtime;
  level.uavsettings["directional_uav"].health = 999999;
  level.uavsettings["directional_uav"].maxhealth = 2000;
  level.uavsettings["directional_uav"].streakname = "directional_uav";
  level.uavsettings["directional_uav"].modelbase = "veh9_mil_air_advanced_uav_mp";
  level.uavsettings["directional_uav"].votimeout = "timeout_directional_uav";
  level.uavsettings["directional_uav"].teamsplash = "used_directional_uav";
  level.uavsettings["directional_uav"].addfunc = scripts\cp_mp\killstreaks\uav::_id_A4D3120487C90203;
  level.uavsettings["directional_uav"].removefunc = scripts\cp_mp\killstreaks\uav::_id_0B5950FBC92DB2FA;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp_mp\killstreaks\uav::onplayerspawned);
  scripts\cp_mp\utility\script_utility::registersharedfunc("uav", "remoteUAV_processTaggedAssist", scripts\mp\killstreaks\remoteuav::remoteuav_processtaggedassist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("uav", "attachXRays", ::_id_91BE4C07ADD55C1A);
}

_id_91BE4C07ADD55C1A(_id_A561E2B774105AD0) {
  _id_A561E2B774105AD0 _meth_5226227BCE83EBE9(3, _id_A561E2B774105AD0.team);
  return _id_A561E2B774105AD0;
}