/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\player\player_stats.gsc
***********************************************/

#include scripts\core_common\util_shared;
#include scripts\weapons\weapons;

#namespace stats;

function_d92cb558(result, vararg) {
  if(!isDefined(result)) {
    pathstr = ishash(vararg[0]) ? function_9e72a96(vararg[0]) : vararg[0];

    if(!isDefined(pathstr)) {
      return;
    }

    for(i = 1; i < vararg.size; i++) {
      pathstr = pathstr + "<dev string:x38>" + (ishash(vararg[i]) ? function_9e72a96(vararg[i]) : vararg[i]);
    }

    println("<dev string:x3c>" + pathstr);
  }
}

  function function_f94325d3() {
    player = self;
    assert(isplayer(player), "<dev string:x59>");

    if(isbot(player) || isDefined(level.disablestattracking) && level.disablestattracking) {
      return false;
    }

    if(sessionmodeiswarzonegame()) {
      if(getdvarint(#"scr_disable_merits", 0) == 1) {
        return false;
      }

      if(!isDefined(game.state) || game.state == "pregame") {
        return false;
      }

      if(!isdedicated() && getdvarint(#"wz_stat_testing", 0) == 0) {
        return false;
      }
    }

    return true;
  }

function_8921af36() {
  return level.var_12323003;
}

get_stat(...) {
  assert(vararg.size > 0);

  if(vararg.size == 0) {
    return 0;
  }

  result = 0;

  if(isDefined(self)) {
    assert(isplayer(self), "<dev string:x59>");
    result = self readstat(vararg);

    function_d92cb558(result, vararg);

  }

  return result;
}

function_6d50f14b(...) {
  assert(vararg.size > 0);

  if(vararg.size == 0) {
    return 0;
  }

  result = 0;

  if(isDefined(self)) {
    assert(isplayer(self), "<dev string:x84>");
    result = self readstatloadout(vararg);

    function_d92cb558(result, vararg);

  }

  return result;
}

function_ff8f4f17(...) {
  assert(vararg.size > 0);

  if(vararg.size == 0) {
    return 0;
  }

  result = 0;

  if(isDefined(self)) {
    assert(isplayer(self), "<dev string:xb7>");
    result = self function_24c32cb1(vararg);

    function_d92cb558(result, vararg);

  }

  return result;
}

set_stat(...) {
  assert(vararg.size > 1);

  if(vararg.size <= 1) {
    return false;
  }

  if(!function_f94325d3()) {
    return false;
  }

  result = 0;

  if(isDefined(self)) {
    assert(isplayer(self), "<dev string:xec>");
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    result = self writestat(vararg, value);

    function_d92cb558(result, vararg);

  }

  return isDefined(result) && result;
}

inc_stat(...) {
  assert(vararg.size > 1);

  if(vararg.size <= 1) {
    return;
  }

  if(!function_f94325d3()) {
    return;
  }

  player = self;
  assert(isplayer(player), "<dev string:xec>");

  if(!isDefined(player) || !isplayer(player)) {
    return;
  }

  value = vararg[vararg.size - 1];
  arrayremoveindex(vararg, vararg.size - 1);
  result = player incrementstat(vararg, value);

  function_d92cb558(result, vararg);

    return isDefined(result) && result;
}

private function_e6106f3b(statname, value) {
  self set_stat(#"playerstatsbygametype", function_8921af36(), statname, #"statvalue", value);
  self set_stat(#"playerstatsbygametype", function_8921af36(), statname, #"challengevalue", value);
  self set_stat(#"playerstatslist", statname, #"statvalue", value);
  self set_stat(#"playerstatslist", statname, #"challengevalue", value);
}

private function_1d354b96(statname, value) {
  var_44becfa9 = self inc_stat(#"playerstatslist", statname, #"statvalue", value);
  self addgametypestat(statname, value);
  return var_44becfa9;
}

function_ed81f25e(statname) {
  return self get_stat(#"playerstatsbygametype", util::get_gametype_name(), statname, #"statvalue");
}

function_baa25a23(statname, value) {
  if(!function_f94325d3()) {
    return 0;
  }

  if(sessionmodeiswarzonegame()) {
    function_e6106f3b(statname, value);
    return;
  }

  self addgametypestat(statname, value);
  return 1;
}

function_d40764f3(statname, value) {
  if(!function_f94325d3()) {
    return 0;
  }

  if(sessionmodeiswarzonegame()) {
    return function_1d354b96(statname, value);
  }

  self addgametypestat(statname, value);
  return 1;
}

function_7a850245(statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  return self set_stat(#"afteractionreportstats", statname, value);
}

function_62b271d8(statname, value) {
  teammates = getplayers(self.team);

  foreach(player in teammates) {
    if(!player function_f94325d3()) {
      continue;
    }

    teammatecount = get_stat(#"afteractionreportstats", #"teammatecount");

    if(!isDefined(teammatecount)) {
      return;
    }

    playerxuid = int(self getxuid(1));

    for(i = 0; i < teammatecount; i++) {
      var_bd8d01a8 = player get_stat(#"afteractionreportstats", #"teammates", i, #"xuid");

      if(var_bd8d01a8 === playerxuid) {
        player set_stat(#"afteractionreportstats", #"teammates", i, statname, value);
        break;
      }
    }
  }
}

function_b7f80d87(statname, value) {
  teammates = getplayers(self.team);

  foreach(player in teammates) {
    if(!player function_f94325d3()) {
      continue;
    }

    teammatecount = get_stat(#"afteractionreportstats", #"teammatecount");

    if(!isDefined(teammatecount)) {
      return;
    }

    playerxuid = int(self getxuid(1));

    for(i = 0; i < teammatecount; i++) {
      var_bd8d01a8 = player get_stat(#"afteractionreportstats", #"teammates", i, #"xuid");

      if(var_bd8d01a8 === playerxuid) {
        player inc_stat(#"afteractionreportstats", #"teammates", i, statname, value);
        break;
      }
    }
  }
}

function_81f5c0fe(statname, value) {
  if(!function_f94325d3() || sessionmodeiswarzonegame()) {
    return 0;
  }

  gametype = level.var_12323003;
  map = util::get_map_name();
  mapstats = isarenamode() ? #"mapstatsarena" : #"mapstats";
  return self inc_stat(mapstats, map, #"permode", gametype, statname, value);
}

set_stat_global(statname, value, var_b6d36336 = 0) {
  if(!function_f94325d3()) {
    return 0;
  }

  if(sessionmodeiswarzonegame()) {
    return function_e6106f3b(statname, value);
  }

  if(isarenamode() && !var_b6d36336) {
    return self set_stat(#"playerstatslist", statname, #"arenavalue", value);
  }

  return self set_stat(#"playerstatslist", statname, #"statvalue", value);
}

get_stat_global(statname, var_b6d36336 = 0) {
  if(isarenamode() && !var_b6d36336) {
    return self get_stat(#"playerstatslist", statname, #"arenavalue");
  }

  return self get_stat(#"playerstatslist", statname, #"statvalue");
}

set_stat_challenge(statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  return self set_stat(#"playerstatslist", statname, #"challengevalue", value);
}

get_stat_challenge(statname) {
  return self get_stat(#"playerstatslist", statname, #"challengevalue");
}

function_af5584ca(statname) {
  return self get_stat(#"playerstatslist", statname, #"challengetier");
}

function_8e071909(statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  return self set_stat(#"playerstatslist", statname, #"challengetier", value);
}

function_878e75b7(statname) {
  return self get_stat(#"playerstatsbygametype", util::get_gametype_name(), statname, #"challengevalue");
}

function_dad108fa(statname, value) {
  if(!function_f94325d3()) {
    return 0;
  }

  if(sessionmodeiswarzonegame()) {
    return function_1d354b96(statname, value);
  }

  if(isarenamode()) {
    return self inc_stat(#"playerstatslist", statname, #"arenavalue", value);
  }

  return self inc_stat(#"playerstatslist", statname, #"statvalue", value);
}

function_bb7eedf0(statname, value) {
  if(sessionmodeiswarzonegame()) {
    return self function_1d354b96(statname, value);
  }

  setglobal = self function_dad108fa(statname, value);
  return self addgametypestat(statname, value);
}

function_eec52333(weapon, statname, value, classnum, pickedup, forceads) {
  if(sessionmodeiswarzonegame() && game.state == "pregame") {
    return;
  }

  if(sessionmodeiszombiesgame() && level.zm_disable_recording_stats === 1) {
    return;
  }

  if(isDefined(level.var_b10e134d)) {
    [[level.var_b10e134d]](self, weapon, statname, value);
  }

  self addweaponstat(weapon, statname, value, classnum, pickedup, forceads);

  switch (statname) {
    case #"shots":
    case #"used":
      self function_f95ea9b6(weapon);
      break;
    case #"kills":
      if(weapon.var_ff0b00ba) {
        self function_dad108fa(#"kills_equipment", 1);
      }

      break;
  }
}

function_e24eec31(weapon, statname, value) {
  self function_eec52333(weapon, statname, value, undefined, undefined, undefined);
}