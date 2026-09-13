/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_compass_mp.gsc
******************************************************/

vehicle_compass_mp_init() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_playerspawnedcallback);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamnospectatorcallback(scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_playerjoinedteamcallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", ::vehicle_compass_mp_shouldbevisibletoplayer);
}

vehicle_compass_mp_shouldbevisibletoplayer(vehicle, player) {
  if(player entitymarkfilteredin(vehicle))
    return 1;
  else if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(!scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(vehicle, player))
      return 1;
  } else if(player scripts\mp\utility\perk::_hasperk("specialty_tactical_recon")) {
    if(!scripts\cp_mp\vehicles\vehicle::vehicle_isneutraltoplayer(vehicle, player))
      return 1;
  }

  return undefined;
}