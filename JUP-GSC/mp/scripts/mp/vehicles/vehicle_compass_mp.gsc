/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_compass_mp.gsc
******************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_compass;
#using scripts\engine\utility;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace vehicle_compass_mp;

function vehicle_compass_mp_init() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&vehicle_compass_playerspawnedcallback);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamnospectatorcallback(&vehicle_compass_playerjoinedteamcallback);
  registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", &vehicle_compass_mp_shouldbevisibletoplayer);
}

function vehicle_compass_mp_shouldbevisibletoplayer(vehicle, player) {
  if(player entitymarkfilteredin(vehicle)) {
    return 1;
  } else if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(!scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(vehicle, player)) {
      return 1;
    }
  } else if(player scripts\mp\utility\perk::_hasperk("specialty_tactical_recon")) {
    if(!scripts\cp_mp\vehicles\vehicle::vehicle_isneutraltoplayer(vehicle, player)) {
      return 1;
    }
  }

  return undefined;
}