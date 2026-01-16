/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\teams\team_assignment.gsc
***********************************************/

#include scripts\core_common\bots\bot;
#include scripts\core_common\platoons;
#include scripts\core_common\system_shared;
#include scripts\core_common\teams;
#include scripts\core_common\util_shared;
#include scripts\mp_common\teams\platoons;
#include scripts\mp_common\teams\teams;

#namespace teams;

autoexec __init__system__() {
  system::register(#"team_assignment", &__init__, undefined, undefined);
}

__init__() {
  if(!isDefined(level.var_a3e209ba)) {
    level.var_a3e209ba = &function_321f8eb5;
  }

  level.var_ba13fb7a = getdvarint(#"hash_40fe9055da22add4", 0);

}

get_assigned_team() {
  teamname = getassignedteamname(self);
}

function_2ba5e3e6() {
  var_ac46c774 = util::gethostplayerforbots();

  if(isDefined(var_ac46c774)) {
    return var_ac46c774.team;
  }

  return "";
}

function_582e5d7c() {
  return isbot(self) && isDefined(self.botteam) && self.botteam != "autoassign" && (level.maxteamplayers == 0 || getplayers(self.botteam).size < level.maxteamplayers);
}

function_ee150fcc(team, team_players) {
  var_ab9e77bf = [];

  var_f8896168 = getdvarint(#"hash_4cbf229ab691d987", 0);

    foreach(player in team_players) {
      party = player getparty();
      assert(party.var_a15e4438 <= level.maxteamplayers);
      var_ab9e77bf[party.party_id] = party.fill ? party.var_a15e4438 : level.maxteamplayers;

      if(var_f8896168) {
        var_ab9e77bf[party.party_id] = party.var_a15e4438;
      }

    }

  var_6195506c = 0;

  foreach(count in var_ab9e77bf) {
    var_6195506c += count;
  }

  return level.maxteamplayers - var_6195506c;
}

private function_f18da875(platoon, player_counts) {
  foreach(test_platoon, count in player_counts) {
    if(test_platoon != platoon && count >= player_counts[platoon]) {
      return false;
    }
  }

  return true;
}

function_efe5a681(team) {
  team_players = getplayers(team);

  if(team_players.size >= level.maxteamplayers) {
    return false;
  }

  if(getdvarint(#"hash_aecb27a63d1fcee", 0) == 0) {
    if(platoons::function_382a49e0()) {
      platoon = getteamplatoon(team);

      if(platoon != #"invalid" && platoon != #"none") {
        player_counts = platoons::count_players();

        if(player_counts[platoon] >= level.platoon.max_players) {
          return false;
        }

        if(getdvarint(#"hash_52e8746b313ada90", 0) == 0) {
          if(function_f18da875(platoon, player_counts)) {
            return false;
          }
        }
      }
    }
  }

  available_spots = function_ee150fcc(team, team_players);
  party = self getparty();

  if(party.var_a15e4438 > available_spots) {
    return false;
  }

  if(getdvarint(#"hash_2ffea48b89a9ff3f", 0) && self != getplayers()[0] && getplayers()[0].team == team && !isbot(self)) {
    return false;
  }

    return true;
}

function_ccb3bc7a() {
  foreach(team in level.teams) {
    if(self function_efe5a681(team)) {
      println("<dev string:x38>" + "<dev string:x4c>" + self.name + "<dev string:x61>" + team + "<dev string:x71>" + getplayers(team).size);

      function_d28f6fa0(team);

        return team;
    }
  }

  return #"spectator";
}

function_b919f6aa(status) {
  foreach(team in level.teams) {
    if(status == #"game") {
      if(isDefined(level.var_75dffa9f[team]) && level.var_75dffa9f[team] != #"game") {
        continue;
      }
    } else if(isDefined(level.var_75dffa9f[team]) && level.var_75dffa9f[team] == #"game") {
      continue;
    }

    if(self function_efe5a681(team)) {
      println("<dev string:x38>" + "<dev string:x4c>" + self.name + "<dev string:x7b>" + team + "<dev string:x71>" + getplayers(team).size);

      function_d28f6fa0(team);

        return team;
    }
  }

  return #"spectator";
}

function_5c389625() {
  status = self function_3d288f14();
  assignment = self function_b919f6aa(status);

  if(!isDefined(assignment) || assignment == #"spectator") {
    assignment = function_959bac94();
  }

  if(!isDefined(assignment)) {
    assignment = function_ccb3bc7a();
  }

  return assignment;
}

function_5d02dd86(party) {
  foreach(member in party.party_members) {
    if(self == member) {
      continue;
    }

    if(member.team != "autoassign" && member.team != "spectate") {
      team_players = getplayers(member.team);

      if(team_players.size >= level.maxteamplayers) {
        break;
      }

      println("<dev string:x38>" + "<dev string:x4c>" + self.name + "<dev string:x90>" + member.team + "<dev string:x9c>" + member.name);

      function_d28f6fa0(member.team);

        return member.team;
    }
  }

  return function_868b679c(party);
}

private function_650d105d() {
  if(function_582e5d7c()) {
    return self.botteam;
  }

  teamkeys = getarraykeys(level.teams);
  assignment = teamkeys[randomint(teamkeys.size)];
  playercounts = self count_players();

  if(teamplayercountsequal(playercounts)) {
    if(!level.splitscreen && self issplitscreen()) {
      assignment = self get_splitscreen_team();

      if(assignment == "") {
        assignment = pickteamfromscores(teamkeys);
      }
    } else {
      assignment = pickteamfromscores(teamkeys);
    }
  } else {
    assignment = function_d078493a(playercounts);
  }

  assert(isDefined(assignment));
  return assignment;
}

private function_75daeb56(party) {

  var_f8896168 = getdvarint(#"hash_4cbf229ab691d987", 0);

  if(var_f8896168 && (var_f8896168 != 2 || self ishost())) {
    return false;
  }

    if(isDefined(party) && party.fill == 0) {
      return true;
    }

  return false;
}

private function_868b679c(party) {
  if(function_75daeb56(party)) {
    assignment = function_959bac94();
  } else if(getdvarint(#"hash_587d8e03df4f4f8a", 0)) {
    assignment = function_ccb3bc7a();
  } else {
    assignment = self function_5c389625();
  }

  return assignment;
}

private function_1e545bc7() {
  if(function_582e5d7c()) {
    return self.botteam;
  }

  party = self getparty();

  if(isDefined(party) && party.var_a15e4438 > 1) {
    return function_5d02dd86(party);
  }

  return function_868b679c(party);
}

function_bec6e9a() {
  if(level.multiteam && level.maxteamplayers > 0) {
    return function_1e545bc7();
  }

  return function_650d105d();
}

function_b55ab4b3(comingfrommenu, var_4c542e39) {
  if(!comingfrommenu && var_4c542e39 === "spectator") {
    return var_4c542e39;
  }

  clientnum = self getentitynumber();
  count = 0;

  foreach(team, _ in level.teams) {
    if(team == "free") {
      continue;
    }

    count++;

    if(count == clientnum + 1) {
      return team;
    }
  }

  return var_4c542e39;
}

function_d22a4fbb(comingfrommenu, var_4c542e39) {
  if(!isDefined(var_4c542e39)) {
    teamname = getassignedteamname(self);
  } else {
    teamname = var_4c542e39;
  }

  if(teamname !== "free" && !comingfrommenu) {
    assignment = teamname;
  } else if(function_a3e209ba(teamname, comingfrommenu)) {
    assignment = #"spectator";
  } else if(isDefined(level.forcedplayerteam) && !isbot(self)) {
    assignment = level.forcedplayerteam;
  } else {
    assignment = function_bec6e9a();
    assert(isDefined(assignment));
  }

  return assignment;
}

teamscoresequal() {
  score = undefined;

  foreach(team, _ in level.teams) {
    if(!isDefined(score)) {
      score = getteamscore(team);
      continue;
    }

    if(score != getteamscore(team)) {
      return false;
    }
  }

  return true;
}

teamwithlowestscore() {
  score = 99999999;
  lowest_team = undefined;

  foreach(team, _ in level.teams) {
    if(score > getteamscore(team)) {
      lowest_team = team;
    }
  }

  return lowest_team;
}

pickteamfromscores(teams) {
  assignment = #"allies";

  if(teamscoresequal()) {
    assignment = teams[randomint(teams.size)];
  } else {
    assignment = teamwithlowestscore();
  }

  return assignment;
}

get_splitscreen_team() {
  for(index = 0; index < level.players.size; index++) {
    if(!isDefined(level.players[index])) {
      continue;
    }

    if(level.players[index] == self) {
      continue;
    }

    if(!self isplayeronsamemachine(level.players[index])) {
      continue;
    }

    team = level.players[index].sessionteam;

    if(team != #"spectator") {
      return team;
    }
  }

  return "";
}

teamplayercountsequal(playercounts) {
  count = undefined;

  foreach(team, _ in level.teams) {
    if(!isDefined(count)) {
      count = playercounts[team];
      continue;
    }

    if(count != playercounts[team]) {
      return false;
    }
  }

  return true;
}

function_d078493a(playercounts) {
  count = 9999;
  lowest_team = undefined;

  foreach(team, _ in level.teams) {
    if(count > playercounts[team]) {
      count = playercounts[team];
      lowest_team = team;
    }
  }

  return lowest_team;
}

function_321f8eb5(player) {
  return true;
}

function_a3e209ba(teamname, comingfrommenu) {
  if(level.rankedmatch) {
    return false;
  }

  if(level.inprematchperiod) {
    return false;
  }

  if(teamname != "free") {
    return false;
  }

  if(comingfrommenu) {
    return false;
  }

  if(self ishost()) {
    return false;
  }

  if(level.forceautoassign) {
    return false;
  }

  if(isbot(self)) {
    return false;
  }

  if(self issplitscreen()) {
    return false;
  }

  if(![[level.var_a3e209ba]]()) {
    return false;
  }

  return true;
}

function_7d93567f() {
  players = level.players;
  distribution = [];

  foreach(player in level.players) {
    team = player.pers[#"team"];

    if(!isDefined(level.teams[team])) {
      continue;
    }

    platoon = getteamplatoon(team);

    if(platoon == #"invalid") {
      continue;
    }

    if(!isDefined(distribution[platoon])) {
      distribution[platoon] = [];
    }

    if(!isDefined(distribution[platoon][team])) {
      distribution[platoon][team] = [];
    }

    if(!isDefined(distribution[platoon][team])) {
      distribution[platoon][team] = [];
    } else if(!isarray(distribution[platoon][team])) {
      distribution[platoon][team] = array(distribution[platoon][team]);
    }

    distribution[platoon][team][distribution[platoon][team].size] = player;
  }

  return distribution;
}

private function_94478182(distribution) {
  var_dd3d17c1 = [];

  foreach(platoon, platoon_teams in distribution) {
    if(!isDefined(var_dd3d17c1[platoon])) {
      var_dd3d17c1[platoon] = [];
    }

    for(i = 1; i < level.maxteamplayers; i++) {
      var_dd3d17c1[platoon][i] = [];
    }
  }

  foreach(platoon, platoon_teams in distribution) {
    if(!isDefined(var_dd3d17c1[platoon])) {
      var_dd3d17c1[platoon] = [];
    }

    foreach(team, team_players in platoon_teams) {
      if(team_players.size < level.maxteamplayers) {
        var_a787dfe7 = function_ee150fcc(team, team_players);

        if(var_a787dfe7 > 0) {
          if(!isDefined(var_dd3d17c1[platoon][var_a787dfe7])) {
            var_dd3d17c1[platoon][var_a787dfe7] = [];
          } else if(!isarray(var_dd3d17c1[platoon][var_a787dfe7])) {
            var_dd3d17c1[platoon][var_a787dfe7] = array(var_dd3d17c1[platoon][var_a787dfe7]);
          }

          var_dd3d17c1[platoon][var_a787dfe7][var_dd3d17c1[platoon][var_a787dfe7].size] = team;
        }
      }
    }
  }

  return var_dd3d17c1;
}

function_b25f48bf(for_team, var_a9ab69de, var_d9438b7, var_ed0a1ecc) {
  foreach(var_a787dfe7, var_75aa1f3c in var_ed0a1ecc) {
    if(level.maxteamplayers - var_a787dfe7 > var_a9ab69de) {
      continue;
    }

    if(var_75aa1f3c.size == 0) {
      continue;
    }

    foreach(team in var_75aa1f3c) {
      if(team == #"none") {
        continue;
      }

      if(team == for_team) {
        continue;
      }

      return team;
    }
  }

  return undefined;
}

private function_78db0e06(old_team, new_team) {
  players = getplayers(old_team);

  foreach(player in players) {
    player function_dc7eaabd(new_team);
  }

  return players.size;
}

function_a9822793() {
  if(getdvarint(#"hash_761d80face4c4459", 0)) {
    return;
  }

  distribution = function_7d93567f();
  var_ed0a1ecc = function_94478182(distribution);

  if(level.var_ba13fb7a) {
    println("<dev string:x38>" + "<dev string:xab>");
    function_a9bfa6d6();
    println("<dev string:x38>" + "<dev string:xbf>");
  }

    foreach(platoon, platoon_teams in var_ed0a1ecc) {
      println("<dev string:xdc>" + platoon);

      foreach(var_a787dfe7, var_75aa1f3c in platoon_teams) {
        foreach(index, team in var_75aa1f3c) {
          if(team == #"none") {
            continue;
          }

          current_count = level.maxteamplayers - var_a787dfe7;

          while(current_count < level.maxteamplayers) {
            var_6f782d8f = function_b25f48bf(team, var_a787dfe7, distribution[platoon], var_ed0a1ecc[platoon]);

            if(!isDefined(var_6f782d8f)) {
              break;
            }

            assert(getplayers(team).size + getplayers(var_6f782d8f).size <= level.maxteamplayers);
            println("<dev string:xe7>" + var_ed0a1ecc[platoon].size);

            foreach(var_aacd04cb in var_ed0a1ecc[platoon]) {
              println("<dev string:xfa>" + var_aacd04cb.size);

              foreach(remove_index, var_adeea4a7 in var_aacd04cb) {
                if(var_adeea4a7 == var_6f782d8f) {
                  var_aacd04cb[remove_index] = #"none";
                }
              }
            }

            current_count += function_78db0e06(var_6f782d8f, team);
          }

          var_75aa1f3c[index] = #"none";
        }
      }
    }

  if(level.var_ba13fb7a) {
    println("<dev string:x38>" + "<dev string:x111>");
    function_a9bfa6d6();
  }

}

private function_a9bfa6d6() {
  if(level.var_ba13fb7a) {
    foreach(team in level.teams) {
      self thread function_6c66cc64(team);
    }
  }
}

private function_6c66cc64(team) {
  players = getplayers(team);

  if(players.size == 0) {
    return;
  }

  team_str = string(team);

  if(isDefined(level.teams[team])) {
    team_str = level.teams[team];
  }

  voip = "<dev string:x12e>";

  if(isDefined(level.var_75dffa9f[team])) {
    voip += level.var_75dffa9f[team] == #"game" ? "<dev string:x136>" : "<dev string:x13d>";
  } else {
    voip += "<dev string:x146>";
  }

  platoon = getteamplatoon(team);
  platoon_name = "<dev string:x152>";

  if(platoon == #"invalid") {
    platoon_name += "<dev string:x15d>";
  } else if(platoon == #"none") {
    platoon_name += "<dev string:x167>";
  } else if(isDefined(level.platoons[platoon])) {
    platoon_name += level.platoons[platoon].name;
  }

  println("<dev string:x38>" + "<dev string:x16e>" + platoon_name + "<dev string:x16e>" + team_str + "<dev string:x16e>" + voip);

  foreach(player in players) {
    party = player getparty();
    println("<dev string:x38>" + "<dev string:x172>" + player.name + "<dev string:x177>" + (party.fill ? "<dev string:x183>" : "<dev string:x189>") + "<dev string:x18e>" + party.var_a15e4438);
  }
}

function_58b6d2c9() {
  if(level.multiteam && level.maxteamplayers > 0) {
    players = getplayers();

    foreach(team in level.teams) {
      var_dcbb8617 = getplayers(team);

      if(var_dcbb8617.size > level.maxteamplayers) {
        var_f554d31e = "<dev string:x197>";

        foreach(player in var_dcbb8617) {
          party = player getparty();
          var_f554d31e = var_f554d31e + player.name + "<dev string:x19a>" + party.party_id + "<dev string:x1a7>";
        }

        assertmsg("<dev string:x1ab>" + self.name + "<dev string:x1c0>" + (ishash(team) ? function_9e72a96(team) : team) + "<dev string:x1e5>" + var_dcbb8617.size + "<dev string:x1f9>" + level.maxteamplayers + "<dev string:x1a7>" + var_f554d31e);
      }
    }

    if(!level.custommatch) {
      foreach(player in players) {
        if(player.team == #"spectator") {
          continue;
        }

        party = player getparty();

        foreach(party_member in party.party_members) {
          if(party_member.team == #"spectator") {
            continue;
          }

          if(party_member.team != player.team) {
            assertmsg("<dev string:x209>" + player.name + "<dev string:x237>" + function_9e72a96(player.team) + "<dev string:x23c>" + party_member.name + "<dev string:x237>" + function_9e72a96(party_member.team) + "<dev string:x241>");
          }
        }
      }
    }
  }
}

function_1aa0418f() {
  while(true) {
    wait 3;
    players = getplayers();

    if(players.size > 0 && players[0] isstreamerready()) {
      setdvar(#"devgui_bot", "<dev string:x247>");
      wait 3;
      function_a9822793();
      wait 1;
      bots = bot::get_bots();

      foreach(bot in bots) {
        level thread bot::remove_bot(bot);
      }
    }
  }
}

