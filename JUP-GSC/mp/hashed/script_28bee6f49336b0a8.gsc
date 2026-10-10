/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_28bee6f49336b0a8.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_supply_drops_common;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_d3cf3492214e1e4f;

function init() {
  scripts\mp\gametypes\br_supply_drops_common::init();
  level.var_5d2af95280a3cf58 = getdvarint(@ "hash_36a630e359ea8611", 16000);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_supply_drop", &scripts\mp\gametypes\br_supply_drops_common::function_94ff06d2db58e807);
  dropstruct = scripts\mp\gametypes\br_supply_drops_common::function_69b2e5235bfb7998("dmz_c17_drop", "military_carepackage_03_dmz");
  scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("dmz_c17_drop", "onDropSpawned", &function_baa146d001c08201);
  dropstruct.planemodel = "veh9_mil_air_cargo_plane_wm_dmz";
  dropstruct = scripts\mp\gametypes\br_supply_drops_common::function_69b2e5235bfb7998("dmz_samsite_drop", "military_carepackage_03_dmz_samsite");
  scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("dmz_samsite_drop", "onDropSpawned", &function_baa146d001c08201);
  dropstruct.planemodel = "veh9_mil_air_cargo_plane_wm_dmz";
  dropstruct = scripts\mp\gametypes\br_supply_drops_common::function_69b2e5235bfb7998("dmz_supply_drop", "military_carepackage_03_dmz_supply");
  scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("dmz_supply_drop", "onDropSpawned", &function_baa146d001c08201);
  dropstruct.planemodel = "veh9_mil_air_cargo_plane_wm_dmz";
  dropstruct = scripts\mp\gametypes\br_supply_drops_common::function_69b2e5235bfb7998("dmz_boss_drop", "military_carepackage_03_dmz_boss");
  scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("dmz_boss_drop", "onDropSpawned", &function_baa146d001c08201);
  dropstruct.planemodel = "veh9_mil_air_cargo_plane_wm_dmz";

  if(getdvarint(@ "hash_531f1530cb50bb4a", 1) == 0) {
    return;
  }

  level thread function_9a7d934b60433cd9();
}

function function_baa146d001c08201(dropend) {
  var_40920b1903f4682a = "cashdrop_common";
  self setscriptablepartstate("objective_map", var_40920b1903f4682a, 0);
}

function function_9a7d934b60433cd9() {
  scripts\mp\flags::gameflagwait("prematch_done");
  waittime = getdvarint(@ "hash_7affedbe66b614ea", 300);
  wait waittime;
  level thread function_9bcdecc2b1fcc04c();
  teamcount = level.teamswithplayers.size;

  if(teamcount > 1) {
    posone = function_593929a3be0bb12d(level.teamswithplayers[0]);
    postwo = function_593929a3be0bb12d(level.teamswithplayers[1]);

    if(isDefined(posone) && isDefined(postwo)) {
      pos = (posone + postwo) / 2;
      scripts\mp\gametypes\br_supply_drops_common::function_1a01863a6ec2ad05(drop_to_ground(pos), "dmz_c17_drop");
    }

    return;
  }

  foreach(player in level.players) {
    if(isreallyalive(player)) {
      function_3ee855cfe6f5f8d5(player);
      return;
    }
  }
}

function function_9bcdecc2b1fcc04c() {
  wait 3;
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_supply_drop", level.players);
}

function function_3ee855cfe6f5f8d5(player) {
  droppos = player.origin;
  mindropdist = getdvarint(@ "hash_ab10323144550acf", 2000);
  var_5e1fcd736aa390a3 = getdvarint(@ "hash_a002dde97cd0623e", 3000);
  droppos = drop_to_ground(droppos + vectorNormalize(function_6174330574a2a273()) * (randomint(var_5e1fcd736aa390a3) + mindropdist), 10500);
  scripts\mp\gametypes\br_supply_drops_common::function_1a01863a6ec2ad05(droppos, "dmz_c17_drop");
}

function function_593929a3be0bb12d(team) {
  players = getteamdata(team, "players");

  foreach(player in players) {
    if(isDefined(player) && isreallyalive(player) && isDefined(player.origin)) {
      return player.origin;
    }
  }

  return undefined;
}