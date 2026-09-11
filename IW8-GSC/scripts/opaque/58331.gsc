/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58331.gsc
***********************************************/

function ref_14127() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&_calloutmarkerping_predicted_timeout::ref_1412a);
  scripts\mp\utility\join_team_aggregator::ref_12b2f(&_calloutmarkerping_predicted_timeout::ref_14129);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", &ref_14128);
}

function ref_14128(var0, var1) {
  if(var1 entitymarkfilteredin(var0)) {
    return 1;
  } else if(scripts\mp\utility\game::getgametype() != "br") {
    if(!scripts\cp_mp\vehicles\vehicle::ref_141b7(var0, var1)) {
      return 1;
    }
  } else if(var1 scripts\mp\utility\perk::_hasperk("specialty_tactical_recon")) {
    if(!scripts\cp_mp\vehicles\vehicle::ref_141bb(var0, var1)) {
      return 1;
    }
  }

  return undefined;
}