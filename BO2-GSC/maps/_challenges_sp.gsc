/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_challenges_sp.gsc
**************************************/

#include maps\_utility;

inc_challenge_stat(str_stat_name) {
  assert(isDefined(level._challenge_lookup) && isDefined(level._challenge_lookup[str_stat_name]), "Tried to increment the counter for invalid challenge " + str_stat_name + "!");
  self addsessstat("PlayerSessionStats", "challengeCounters", level._challenge_lookup[str_stat_name], 1);
}

get_challenge_stat(str_stat_name) {
  assert(isDefined(level._challenge_lookup) && isDefined(level._challenge_lookup[str_stat_name]), "Tried to get the challenge counter for invalid challenge " + str_stat_name + "!");
  return self getsessstat("PlayerSessionStats", "challengeCounters", level._challenge_lookup[str_stat_name]);
}

get_challenge_complete(str_stat_name) {
  assert(isDefined(level._challenge_lookup) && isDefined(level._challenge_lookup[str_stat_name]), "Tried to get the completion status for the invalid challenge " + str_stat_name + "!");
  currval = self get_challenge_stat(str_stat_name);
  targetval = level._challenge_target[str_stat_name];
  return currval >= targetval;
}

register_challenge(str_stat_name, logic_func) {
  assert(isplayer(self), "register_challenge() with stat name " + str_stat_name + " must be called on a player.");

  if(!isDefined(level._challenges_complete))
    level._challenges_complete = [];

  if(!isDefined(level._challenge_lookup))
    level._challenge_lookup = [];

  if(!isDefined(level._challenge_target))
    level._challenge_target = [];

  levelalias = getlevelalias();
  challengenum = tablelookup("sp/challengeTable.csv", 1, levelalias, 2, str_stat_name, 0);
  targetval = int(tablelookup("sp/challengeTable.csv", 1, levelalias, 2, str_stat_name, 4));
  assert(challengenum != "", "Invalid challenge " + str_stat_name + " for level " + levelalias + " requested, please check challengeTable.csv!");
  level._challenge_lookup[str_stat_name] = "CHALLENGE_" + challengenum;
  level._challenge_target[str_stat_name] = targetval;
  maps\_utility::waitforstats();
  str_challenge_notify = "challenge_" + str_stat_name + "_increment";

  if(isDefined(logic_func))
    self thread[[logic_func]](str_challenge_notify);

  if(get_challenge_complete(str_stat_name)) {
    return;
  }
  self thread challenge_notify_listener(str_stat_name, str_challenge_notify);
}

challenge_notify_listener(str_stat_name, str_challenge_notify) {
  self endon("stop_" + str_stat_name);

  while(true) {
    self waittill(str_challenge_notify);
    self inc_challenge_stat(str_stat_name);
    is_challenge_stat_complete(str_stat_name);
  }
}

is_challenge_stat_complete(str_stat_name) {
  if(self get_challenge_complete(str_stat_name) && !isDefined(level._challenges_complete[str_stat_name])) {
    level.challenge_awarded = gettime();
    level notify(str_stat_name + "_challenge_complete");
    dochallengecompleteui();
    level._challenges_complete[str_stat_name] = 1;
    self setsessstat("challengeCompletion", level._challenge_lookup[str_stat_name], 1);
  }
}

challenge_stop(str_stat_name) {
  self notify("stop_" + str_stat_name);
}