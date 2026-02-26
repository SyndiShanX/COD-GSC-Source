/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3d703ef87a841fe4.gsc
***********************************************/

#using scripts\core_common\map;
#using scripts\core_common\player\player_shared;
#namespace teams;

function function_7f8faff9(team) {
  return game.stat[#"teamscores"][team];
}

function function_dc7eaabd(assignment) {
  assert(isDefined(assignment));
  self.pers[#"team"] = assignment;
  self.team = assignment;
  self.sessionteam = assignment;

  if(isDefined(level.teams[assignment])) {
    status = self player::function_3d288f14();

    if(!isDefined(level.var_75dffa9f[assignment]) || status != level.var_75dffa9f[assignment] && status == # "game") {
      if(status == # "game") {
        level.var_75dffa9f[assignment] = # "game";
      } else {
        level.var_75dffa9f[assignment] = # "none";
      }
    }
  }

  self thread function_ba459d03(assignment);
}

function is_team_empty(team) {
  team_players = getplayers(team);

  if(team_players.size > 0) {
    return false;
  }

  return true;
}

function function_959bac94() {
  foreach(team in level.teams) {
    if(self is_team_empty(team)) {
      println("<dev string:x38>" + "<dev string:x4d>" + self.name + "<dev string:x63>" + team);

      function_d28f6fa0(team);

      return team;
    }
  }

  return # "spectator";
}

function function_712e3ba6(score) {
  foreach(team, _ in level.teams) {
    if(game.stat[#"teamscores"][team] >= score) {
      return true;
    }
  }

  return false;
}

function any_team_hit_score_limit() {
  return function_712e3ba6(level.scorelimit);
}

function private function_67aac3d9(gamestat, teama, teamb, previous_winner_score) {
  winner = undefined;
  assert(teama !== "<dev string:x76>");

  if(previous_winner_score == game.stat[gamestat][teamb]) {
    winner = undefined;
  } else if(game.stat[gamestat][teamb] > previous_winner_score) {
    winner = teamb;
  } else {
    winner = teama;
  }

  return winner;
}

function function_d85770f0(gamestat) {
  teamkeys = getarraykeys(level.teams);
  winner = teamkeys[0];
  previous_winner_score = game.stat[gamestat][winner];

  for(teamindex = 1; teamindex < teamkeys.size; teamindex++) {
    winner = function_67aac3d9(gamestat, winner, teamkeys[teamindex], previous_winner_score);

    if(isDefined(winner)) {
      previous_winner_score = game.stat[gamestat][winner];
    }
  }

  return winner;
}

function private function_e390f598(currentwinner, teamb, var_2a5c5ccb) {
  assert(currentwinner !== "<dev string:x76>");
  teambscore = [[level._getteamscore]](teamb);

  if(teambscore == var_2a5c5ccb) {
    return undefined;
  } else if(teambscore > var_2a5c5ccb) {
    return teamb;
  }

  return currentwinner;
}

function function_ef80de99() {
  teamkeys = getarraykeys(level.teams);
  winner = teamkeys[0];
  var_2a5c5ccb = [[level._getteamscore]](winner);

  for(teamindex = 1; teamindex < teamkeys.size; teamindex++) {
    winner = function_e390f598(winner, teamkeys[teamindex], var_2a5c5ccb);

    if(isDefined(winner)) {
      var_2a5c5ccb = [[level._getteamscore]](winner);
    }
  }

  return winner;
}

function function_20cfd8b5(team) {
  if(isDefined(team)) {
    teamindex = level.teamindex[team];

    if(isDefined(teamindex)) {
      var_504bfad6 = map::function_596f8772();
      var_7c3dac8 = var_504bfad6.faction[teamindex].var_d2446fa0;

      if(isDefined(var_7c3dac8)) {
        return getscriptbundle(var_7c3dac8);
      }
    }
  }

  return undefined;
}

function private function_ba459d03(team) {
  if(is_true(level.var_ba13fb7a)) {
    team_str = string(team);

    if(isDefined(level.teams[team])) {
      team_str = level.teams[team];
    }

    voip = "<dev string:x7d>";

    if(isDefined(level.var_75dffa9f[team])) {
      voip += level.var_75dffa9f[team] == # "game" ? "<dev string:x86>" : "<dev string:x8e>";
    } else {
      voip += "<dev string:x98>";
    }

    println("<dev string:x38>" + "<dev string:xa5>" + self.name + "<dev string:xab>" + team_str + "<dev string:xb1>" + voip);
  }
}

function function_a9d594a0(party) {
  foreach(party_member in party.party_members) {
    var_2798314b = party_member getparty();

    if(var_2798314b.var_a15e4438 != party.var_a15e4438) {
      assertmsg("<dev string:xb6>");
    }
  }
}

function function_d28f6fa0(team) {
  players = getplayers(team);

  foreach(player in players) {
    function_a9d594a0(player getparty());
  }
}