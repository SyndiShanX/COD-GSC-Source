/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\uav_cp.gsc
***********************************************/

init_uav_cp() {
  level.radarviewtime = 43;
  level.advradarviewtime = 28;
  level.uavblocktime = 23;
  level.uavsettings = [];
  level.uavsettings["uav"] = spawnStruct();
  level.uavsettings["uav"].timeout = level.radarviewtime;
  level.uavsettings["uav"].health = 999999;
  level.uavsettings["uav"].maxhealth = 800;
  level.uavsettings["uav"].streakname = "uav";
  level.uavsettings["uav"].modelbase = "veh9_mil_air_uav_small_mp";
  level.uavsettings["uav"].fxid_explode = loadfx("vfx/iw8_mp/killstreak/vfx_uav_death.vfx");
  level.uavsettings["uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["uav"].fxid_contrail = undefined;
  level.uavsettings["uav"].fx_contrail_tag = undefined;
  level.uavsettings["uav"].sound_explode = "mp_uav_explo_dist";
  level.uavsettings["uav"].teamsplash = "used_uav";
  level.uavsettings["uav"].votimeout = "uav_timeout";
  level.uavsettings["uav"].calloutdestroyed = "callout_destroyed_uav";
  level.uavsettings["uav"].addfunc = scripts\cp_mp\killstreaks\uav::_id_A4D3120487C90203;
  level.uavsettings["uav"].removefunc = scripts\cp_mp\killstreaks\uav::_id_0B5950FBC92DB2FA;
  level.uavsettings["directional_uav"] = spawnStruct();
  level.uavsettings["directional_uav"].timeout = level.advradarviewtime;
  level.uavsettings["directional_uav"].health = 999999;
  level.uavsettings["directional_uav"].maxhealth = 2000;
  level.uavsettings["directional_uav"].streakname = "directional_uav";
  level.uavsettings["directional_uav"].modelbase = "veh9_mil_air_advanced_uav_mp";
  level.uavsettings["directional_uav"].fxid_explode = loadfx("vfx/iw8_mp/killstreak/vfx_auav_death.vfx");
  level.uavsettings["directional_uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["directional_uav"].fxid_contrail = undefined;
  level.uavsettings["directional_uav"].fx_contrail_tag = "tag_jet_trail";
  level.uavsettings["directional_uav"].sound_explode = "mp_uav_explo_dist";
  level.uavsettings["directional_uav"].votimeout = "directional_uav_timeout";
  level.uavsettings["directional_uav"].teamsplash = "used_directional_uav";
  level.uavsettings["directional_uav"].calloutdestroyed = "callout_destroyed_directional_uav";
  level.uavsettings["directional_uav"].addfunc = scripts\cp_mp\killstreaks\uav::_id_A4D3120487C90203;
  level.uavsettings["directional_uav"].removefunc = scripts\cp_mp\killstreaks\uav::_id_0B5950FBC92DB2FA;
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp_mp\killstreaks\uav::onplayerspawned);
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::hide_minimap_on_spawn);
  scripts\cp_mp\utility\script_utility::registersharedfunc("uav", "remoteUAV_processTaggedAssist", ::remoteuav_processtaggedassist);
}

give_radar_to_team() {
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::setradarparamsonlatejoiner);

  foreach(player in level.players)
  player.radarmode = "normal_radar";

  _id_1868502BAEAC1A9F = getuavstrengthlevelneutral();
  scripts\cp_mp\killstreaks\uav::_id_484D86CE003C2526("allies", _id_1868502BAEAC1A9F + 1);
  setteamradar("allies", 1);
}

hide_minimap_on_spawn() {
  _id_B2FF82EC901486E4 = getDvar("ui_gametype");

  if(_id_B2FF82EC901486E4 == "cp_survival")
    scripts\cp\utility::hideminimap(1);
}

setradarparamsonlatejoiner() {
  self.radarmode = "normal_radar";
}

remoteuav_processtaggedassist(victim) {}