/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\killstreaks\uav_cp.gsc
************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp_mp\killstreaks\uav;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#namespace uav_cp;

function init_uav_cp() {
  level.radarviewtime = 90;
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
  level.uavsettings["uav"].addfunc = &uav_addactiveuav;
  level.uavsettings["uav"].removefunc = &uav_removeactiveuav;
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
  level.uavsettings["directional_uav"].addfunc = &uav_addactiveuav;
  level.uavsettings["directional_uav"].removefunc = &uav_removeactiveuav;
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&hide_minimap_on_spawn);
  scripts\engine\utility::registersharedfunc("uav", "remoteUAV_processTaggedAssist", &remoteuav_processtaggedassist);
}

function give_radar_to_team() {
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&setradarparamsonlatejoiner);

  foreach(player in level.players) {
    player.radarmode = "normal_radar";
  }

  var_1868502baeac1a9f = getuavstrengthlevelneutral();
  scripts\cp_mp\killstreaks\uav::function_484d86ce003c2526("allies", var_1868502baeac1a9f + 1);
  setteamradar("allies", 1);
}

function hide_minimap_on_spawn() {
  gamemode = getDvar(@ "ui_gametype");

  if(gamemode == "cp_survival") {
    scripts\cp\utility::hideminimap(1);
  }
}

function setradarparamsonlatejoiner() {
  self.radarmode = "normal_radar";
}

function remoteuav_processtaggedassist(victim) {}