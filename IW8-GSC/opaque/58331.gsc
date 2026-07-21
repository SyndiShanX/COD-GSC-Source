/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58331.gsc
***********************************************/

_id_14127() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(_calloutmarkerping_predicted_timeout::_id_1412A);
  scripts\mp\utility\join_team_aggregator::_id_12B2F(_calloutmarkerping_predicted_timeout::_id_14129);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B82710C38871C417183DD7E3C0C0A30EAFA0", "_encstr_AF2618A0BAE5ABC8DB12E57401BF504D8DF211B8D1FD3B22B74A", ::_id_14128);
}

_id_14128(var_0, var_1) {
  if(var_1 entitymarkfilteredin(var_0))
    return 1;
  else if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    if(!scripts\cp_mp\vehicles\vehicle::_id_141B7(var_0, var_1))
      return 1;
  } else if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_BE67199EB795D9604B6C4398C138E396AB83BB1964916A93D7B735")) {
    if(!scripts\cp_mp\vehicles\vehicle::_id_141BB(var_0, var_1))
      return 1;
  }

  return undefined;
}