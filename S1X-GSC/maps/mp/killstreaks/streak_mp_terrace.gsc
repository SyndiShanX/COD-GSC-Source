/*****************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\streak_mp_terrace.gsc
*****************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  level.killstreakWieldWeapons["killstreak_terrace_mp"] = "mp_terrace";

  level.killstreakFuncs["mp_terrace"] = ::tryUseKillstreak;

  level.mapKillStreak = "mp_terrace";
  level.mapKillstreakPickupString = &"MP_TERRACE_MAP_KILLSTREAK_PICKUP";
}

tryUseKillstreak(lifeId, modules) {
  modules = ["mp_terrace"];
  return maps\mp\killstreaks\_drone_assault::tryUseAssaultDrone(lifeId, modules);
}