/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\uav_mp.gsc
***********************************************/

function init_uav_mp() {
  level.radarviewtime = 25;
  level.advradarviewtime = getdvarint("scr_auav_radarViewTime", 30);
  level.uavblocktime = 23;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("uav", &scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("directional_uav", &scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct);
  level.uavsettings = [];
  level.uavsettings["uav"] = spawnStruct();
  level.uavsettings["uav"].timeout = level.radarviewtime;
  level.uavsettings["uav"].health = 999999;
  level.uavsettings["uav"].maxhealth = 450;
  level.uavsettings["uav"].streakname = "uav";
  level.uavsettings["uav"].modelbase = "veh8_mil_air_mquebec9_small";
  level.uavsettings["uav"].modelbasealt = "veh8_mil_air_mquebec9_small_east";
  level.uavsettings["uav"].fxid_explode = loadfx("vfx/iw8_mp/killstreak/vfx_uav_death.vfx");
  level.uavsettings["uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["uav"].fxid_contrail = undefined;
  level.uavsettings["uav"].fx_contrail_tag = undefined;
  level.uavsettings["uav"].sound_explode = "mp_uav_explo_dist";
  level.uavsettings["uav"].teamsplash = "used_uav";
  level.uavsettings["uav"].votimeout = "timeout_uav";
  level.uavsettings["uav"].calloutdestroyed = "callout_destroyed_uav";
  level.uavsettings["uav"].addfunc = &scripts\cp_mp\killstreaks\uav::addactiveuav;
  level.uavsettings["uav"].removefunc = &scripts\cp_mp\killstreaks\uav::removeactiveuav;
  level.uavsettings["directional_uav"] = spawnStruct();
  level.uavsettings["directional_uav"].timeout = level.advradarviewtime;
  level.uavsettings["directional_uav"].health = 999999;
  level.uavsettings["directional_uav"].maxhealth = 2000;
  level.uavsettings["directional_uav"].streakname = "directional_uav";
  level.uavsettings["directional_uav"].modelbase = "veh8_mil_air_auniform";
  level.uavsettings["directional_uav"].modelbasealt = "veh8_mil_air_auniform_east";
  level.uavsettings["directional_uav"].fxid_explode = loadfx("vfx/iw8_mp/killstreak/vfx_auav_death.vfx");
  level.uavsettings["directional_uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["directional_uav"].fxid_contrail = undefined;
  level.uavsettings["directional_uav"].fx_contrail_tag = "tag_jet_trail";
  level.uavsettings["directional_uav"].sound_explode = "mp_uav_explo_dist";
  level.uavsettings["directional_uav"].votimeout = "timeout_directional_uav";
  level.uavsettings["directional_uav"].teamsplash = "used_directional_uav";
  level.uavsettings["directional_uav"].calloutdestroyed = "callout_destroyed_directional_uav";
  level.uavsettings["directional_uav"].addfunc = &scripts\cp_mp\killstreaks\uav::addactiveuav;
  level.uavsettings["directional_uav"].removefunc = &scripts\cp_mp\killstreaks\uav::removeactiveuav;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&scripts\cp_mp\killstreaks\uav::onplayerspawned);
  scripts\cp_mp\utility\script_utility::registersharedfunc("uav", "remoteUAV_processTaggedAssist", &scripts\mp\killstreaks\remoteuav::remoteuav_processtaggedassist);
}