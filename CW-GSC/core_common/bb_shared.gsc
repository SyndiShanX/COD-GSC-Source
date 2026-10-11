/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\bb_shared.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#namespace bb;

function init_shared() {
  callback::on_start_gametype(&init);
  callback::on_joined_team(&player_joined_team);
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
}

function init() {}

function function_ff257265() {
  self._bbdata = [];
  self._bbdata[#"score"] = 0;
  self._bbdata[#"momentum"] = 0;
  self._bbdata[#"spawntime"] = gettime();
  self._bbdata[#"shots"] = 0;
  self._bbdata[#"hits"] = 0;
}

function on_player_connect() {
  self function_ff257265();
}

function on_player_spawned() {
  self function_ff257265();
}

function commit_weapon_data(spawnid, currentweapon, time0) {
  if(isbot(self)) {
    return;
  }

  assert(isDefined(self._bbdata));

  if(!isDefined(self._bbdata)) {
    return;
  }

  time1 = gettime();
  blackboxeventname = #"mpweapons";
  eventname = #"dlog_event_mpweapons";

  if(sessionmodeiscampaigngame()) {
    blackboxeventname = #"cpweapons";
    eventname = #"dlog_event_cpweapons";
  } else if(sessionmodeiszombiesgame()) {
    blackboxeventname = #"zmweapons";
    eventname = #"dlog_event_zmweapons";
  } else if(sessionmodeiswarzonegame()) {
    blackboxeventname = #"wzweapons";
    eventname = #"dlog_event_wzweapons";
  }

  event_data = {
    #spawnid: spawnid, #name: currentweapon.name, #duration: time1 - time0, #shots: self._bbdata[#"shots"], #hits: self._bbdata[#"hits"]
  };
  function_92d1707f(eventname, blackboxeventname, event_data);
  self._bbdata[#"shots"] = 0;
  self._bbdata[#"hits"] = 0;
}

function add_to_stat(statname, delta) {
  if(isbot(self)) {
    return;
  }

  if(isDefined(self._bbdata) && isDefined(self._bbdata[statname])) {
    self._bbdata[statname] += delta;
  }
}

function function_a7ba460f(reason) {
  function_92d1707f(#"dlog_event_global_session_epilogs", {
    #reason: reason
  });
}

function function_afcc007d(name, clientnum, xuid) {
  var_bd8c7087 = int(xuid);
  function_92d1707f(#"hash_3e5070f3289e386c", {
    #name: name, #clientnum: clientnum, #xuid: var_bd8c7087
  });
}

function function_e0dfa262(name, clientnum, xuid) {
  var_bd8c7087 = int(xuid);
  function_92d1707f(#"dlog_event_global_leave", {
    #name: name, #clientnum: clientnum, #xuid: var_bd8c7087
  });
}

function player_joined_team(params) {
  if(!isDefined(self.team) || isDefined(self.startingteam)) {
    return;
  }

  self.startingteam = self.team;
}