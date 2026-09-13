/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\cruise_predator_mp.gsc
*********************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("cruise_predator", scripts\cp_mp\killstreaks\cruise_predator::tryusecruisepredatorfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "registerVO", ::cruisepredator_registervo);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "eventRecord", ::cruisepredator_eventrecord);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "assignTargetMarkers", ::cruisepredator_assigntargetmarkers);
}

cruisepredator_registervo() {
  game["dialog"]["cruise_predator_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["cruise_predator_hit_target"] = "killstreak_remote_operator_hit_target";
  game["dialog"]["cruise_predator_miss_target"] = "killstreak_remote_operator_miss_target";
}

cruisepredator_eventrecord(_id_45292519459D6838) {
  if(isDefined(_id_45292519459D6838))
    scripts\mp\events::predatormissileimpact(_id_45292519459D6838);
}

cruisepredator_assigntargetmarkers(_id_EEE718E33217DC9E) {
  _id_2CD52BBC2A67B7CF = [];
  _id_FF93381949523976 = [];
  _id_22CCB4186BD27179 = level.players;
  _id_2395B77BDD5F9CA4 = spawnStruct();

  foreach(player in _id_22CCB4186BD27179) {
    if(level.teambased && player.team == _id_EEE718E33217DC9E.team || player == _id_EEE718E33217DC9E) {
      _id_FF93381949523976[_id_FF93381949523976.size] = player;
      continue;
    }

    if(player scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }
    _id_2CD52BBC2A67B7CF[_id_2CD52BBC2A67B7CF.size] = player;
  }

  _id_2395B77BDD5F9CA4.enemytargetmarkergroup = _id_2CD52BBC2A67B7CF;
  _id_2395B77BDD5F9CA4.friendlytargetmarkergroup = _id_FF93381949523976;
  return _id_2395B77BDD5F9CA4;
}