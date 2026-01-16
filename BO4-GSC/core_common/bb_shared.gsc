/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\bb_shared.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;

#namespace bb;

init_shared() {
  callback::on_start_gametype(&init);
  callback::on_joined_team(&player_joined_team);
  callback::on_spawned(&on_player_spawned);
}

init() {}

on_player_spawned() {
  self._bbdata = [];
  self._bbdata[#"score"] = 0;
  self._bbdata[#"momentum"] = 0;
  self._bbdata[#"spawntime"] = gettime();
  self._bbdata[#"shots"] = 0;
  self._bbdata[#"hits"] = 0;
}

commit_weapon_data(spawnid, currentweapon, time0) {
  if(isbot(self)) {
    return;
  }

  assert(isDefined(self._bbdata));

  if(!isDefined(self._bbdata)) {
    return;
  }

  time1 = gettime();
  blackboxeventname = #"mpweapons";
  eventname = #"hash_41cc1afc10e99541";

  if(sessionmodeiscampaigngame()) {
    blackboxeventname = #"cpweapons";
    eventname = #"hash_474292d3118817ab";
  } else if(sessionmodeiszombiesgame()) {
    blackboxeventname = #"zmweapons";
    eventname = #"hash_67140d84a7660909";
  } else if(sessionmodeiswarzonegame()) {
    blackboxeventname = #"wzweapons";
    eventname = #"hash_63ec5305e1ef1335";
  }

  event_data = {
    #spawnid: spawnid, 
    #name: currentweapon.name, 
    #duration: time1 - time0, 
    #shots: self._bbdata[#"shots"], 
    #hits: self._bbdata[#"hits"]
  };
  function_92d1707f(eventname, blackboxeventname, event_data);
  self._bbdata[#"shots"] = 0;
  self._bbdata[#"hits"] = 0;
}

add_to_stat(statname, delta) {
  if(isbot(self)) {
    return;
  }

  if(isDefined(self._bbdata) && isDefined(self._bbdata[statname])) {
    self._bbdata[statname] += delta;
  }
}

function_a7ba460f(reason) {
  function_92d1707f(#"hash_28b295eb3b8e189", {
    #reason: reason
  });
}

function_afcc007d(name, clientnum, xuid) {
  var_bd8c7087 = int(xuid);
  function_92d1707f(#"hash_3e5070f3289e386c", {
    #name: name, 
    #clientnum: clientnum, 
    #xuid: var_bd8c7087
  });
}

function_e0dfa262(name, clientnum, xuid) {
  var_bd8c7087 = int(xuid);
  function_92d1707f(#"hash_557aae9aaddeac22", {
    #name: name, 
    #clientnum: clientnum, 
    #xuid: var_bd8c7087
  });
}

player_joined_team(params) {
  if(!isDefined(self.team) || isDefined(self.startingteam)) {
    return;
  }

  self.startingteam = self.team;
}