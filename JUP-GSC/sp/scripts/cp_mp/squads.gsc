/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\squads.gsc
***********************************************/



#using script_2342b8aad723994e;
#using scripts\common\callbacks;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#namespace squads;

function init() {
  level.maxsquadsize = getdvarint(@ "party_maxsquadsize", 1);

  if(level.maxsquadsize && function_a9cb1bbce9eb3d1b()) {
    level.maxsquadsize = level.maxteamsize;
  }

  level.usesquadleader = getdvarint(@ "hash_56fe5e64db58eb48", 1);

  if(shouldmodesetsquads()) {
    initsquaddata();
  }
}

function initsquaddata() {
  level.squaddata = [];

  foreach(entry in level.teamnamelist) {
    level.squaddata[entry] = [];
  }

  level thread debugprintsquads();
}

function setsquad(team, index) {
  if(!shouldmodesetsquads()) {
    return;
  }

  if(!isDefined(team) || team == "spectator" || team == "codcaster") {
    return;
  }

  if(getdvarint(@ "scr_assign_squad_from_team", 0) != 0) {
    teamindex = 0;

    foreach(index, name in level.teamnamelist) {
      if(name == team) {
        teamindex = index;
        break;
      }
    }

    joinsquad(team, teamindex);
    return;
  }

  if(isbot(self) && isDefined(self.bot_squad)) {
    var_69c5807191f92fbb = self.bot_squad != -1;
  } else {
    var_69c5807191f92fbb = self.sessionsquadid != -1;
  }

  if(istrue(level.matchmakingmatch) && var_69c5807191f92fbb && getdvarint(@ "hash_6595c001520e3eec", 0) != 1) {
    if(!isDefined(index)) {
      if(isbot(self) && isDefined(self.bot_squad)) {
        index = self.bot_squad;
      } else {
        index = self.sessionsquadid;
      }
    }

    self.squadassignedfromlobby = 1;
    joinsquad(team, index);
    return;
  }

  if(istrue(level.matchmakingmatch)) {
    fireteammembers = self getfireteammembers();

    if(isDefined(fireteammembers) && fireteammembers.size > 0) {
      squadindex = undefined;

      foreach(member in fireteammembers) {
        if(isDefined(member) && member.sessionsquadid != -1) {
          squadindex = member.sessionsquadid;
          break;
        }
      }

      if(isDefined(squadindex)) {
        joinsquad(team, squadindex);
        return;
      } else {
        requestnewsquad(team, 1);
        return;
      }
    }
  }

  foreach(squad in level.squaddata[team]) {
    isfull = squad.players.size == level.maxsquadsize;

    if(!squad.isfireteam && !isfull) {
      joinsquad(team, squad.index);
      return;
    }
  }

  requestnewsquad(team, 0);
}

function createsquad(team, index) {
  if(!isDefined(level.uniquesquadid)) {
    level.uniquesquadid = 0;
  }

  if(!isDefined(index)) {
    index = level.uniquesquadid;
  }

  data = spawnStruct();
  data.index = index;
  data.team = team;
  data.isfireteam = 0;
  data.players = [];
  data.squadleader = undefined;
  data.skydivezoneindex = undefined;
  data.properties = [];
  level.squaddata[team][index] = data;
  level.uniquesquadid++;
  callback::callback("squad_created", data);
  return index;
}

function freesquadindex(team, index) {
  level.squaddata[team][index] = undefined;
}

function requestnewsquad(team, isfireteam) {
  index = createsquad(team);
  data = level.squaddata[team][index];
  data.infil = undefined;
  joinsquad(team, index);
}

function joinsquad(team, index) {
  if(!isDefined(level.squaddata[team][index])) {
    createsquad(team, index);
  }

  self.sessionsquadid = index;
  self.sessionuimemberindex = function_eec90fb96d0aff02(team, index);
  level.squaddata[team][index].players[level.squaddata[team][index].players.size] = self;
  choosesquadleader(team, index);
  namespace_c31609f90efcf2ca::onplayerjoinsquad(self);
  callback::callback(#"hash_cc06eb1d45f33a0c", {
    #index: index, #team: team
  });
  self notify("joined_squad");
}

function leavesquad(team, index) {
  if(!shouldmodesetsquads()) {
    return;
  }

  if(!isDefined(team) || team == "spectator" || team == "codcaster" || !isDefined(index) || !isDefined(level.squaddata)) {
    return;
  }

  assertex(isDefined(level.squaddata[team][index]), "Squad data for player is undefined");

  if(level.squaddata[team][index].players.size == 1) {
    freesquadindex(team, index);
    callback::callback(#"hash_cef9136f9b434dc1", {
      #index: index, #team: team
    });
    return;
  }

  self.var_71afb85ec1cc06f8 = self.sessionuimemberindex;
  self.sessionuimemberindex = -1;
  var_aa17b95935a5047f = 0;
  squadleader = getsquadleader(team, index);

  if(istrue(level.usesquadleader) && isDefined(squadleader) && squadleader == self) {
    level.squaddata[team][index].squadleader = undefined;
    var_aa17b95935a5047f = 1;

    foreach(player in level.squaddata[team][index].players) {
      player setclientomnvar("ui_squad_leader", undefined);
    }
  }

  namespace_c31609f90efcf2ca::function_2a1e4811621fdcde(self);
  callback::callback(#"hash_cef9136f9b434dc1", {
    #index: index, #team: team
  });
  level.squaddata[team][index].players = array_remove(level.squaddata[team][index].players, self);

  if(istrue(var_aa17b95935a5047f)) {
    squadmembers = array_randomize(level.squaddata[team][index].players);

    foreach(player in squadmembers) {
      if(isDefined(player)) {
        player choosesquadleader(team, index);
        break;
      }
    }
  }
}

function function_9be60342a8babba5() {
  if(issharedfuncdefined("teamAssim", "isEnabled") && [[getsharedfunc("teamAssim", "isEnabled")]]()) {
    if(issharedfuncdefined("teamAssim", "getMaxAssimilationTeamSize")) {
      return [[getsharedfunc("teamAssim", "getMaxAssimilationTeamSize")]]();
    }

    return;
  }

  return level.maxsquadsize;
}

function function_eec90fb96d0aff02(team, index) {
  availableindices = [];

  for(i = 0; i < function_9be60342a8babba5(); i++) {
    availableindices[i] = 1;
  }

  foreach(player in level.squaddata[team][index].players) {
    if(player.sessionuimemberindex >= 0) {
      availableindices[player.sessionuimemberindex] = 0;
    }
  }

  foreach(index, isavailable in availableindices) {
    if(isavailable) {
      return index;
    }
  }

  assertmsg("getAvailableSquadMemberIndex() unable to find available index!");
  return undefined;
}

function changesquad(team, index) {
  if(isDefined(self.sessionsquadid) && self.sessionsquadid == index) {
    return;
  }

  leavesquad(team, self.sessionsquadid);
  joinsquad(team, index);
}

function updatesquadomnvars(team, squadindex) {
  if(!shouldmodesetsquads() || !isDefined(level.squaddata)) {
    return;
  }

  squadleader = getsquadleader(team, squadindex);

  foreach(player in level.squaddata[team][squadindex].players) {
    var_4f87bc92d01fa479 = squadindex;
    var_4f87bc92d01fa479 += level.squaddata[team][squadindex].players.size << 5;

    if(isDefined(squadleader) && squadleader == player) {
      var_4f87bc92d01fa479 += 256;
    }

    if(istrue(level.var_4e353dc2c64b19b1)) {
      continue;
    }

    player setclientomnvar("ui_squad_data", var_4f87bc92d01fa479);

    if(isDefined(level.gametype) && (level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "risk" || level.gametype == "arena" || level.gametype == "brtdm" || level.gametype == "brtdm_mgl")) {
      var_69fe4a18f948739c = player.game_extrainfo & 65528;
      player.game_extrainfo = var_69fe4a18f948739c | player.sessionuimemberindex + 1;

      if(isDefined(squadleader) && squadleader == player) {
        player.game_extrainfo |= 256;
      } else {
        player.game_extrainfo &= ~256;
      }

      var_f31235f8d2bec0f0 = player getentitynumber();

      if(isDefined(squadleader) && squadleader == player) {
        var_f31235f8d2bec0f0 += 2048;
      }

      if(isalive(player)) {
        var_f31235f8d2bec0f0 += 4096;
      }

      player setclientomnvar("ui_arm_squadmember_0", var_f31235f8d2bec0f0);
      mates = array_remove(level.squaddata[team][squadindex].players, player);

      for(i = 0; i < 3; i++) {
        mate = mates[i];

        if(isDefined(mate)) {
          var_f31235f8d2bec0f0 = mate getentitynumber();

          if(isDefined(squadleader) && squadleader == mate) {
            var_f31235f8d2bec0f0 += 2048;
          }

          if(isalive(mate)) {
            var_f31235f8d2bec0f0 += 4096;
          }
        } else {
          var_f31235f8d2bec0f0 = -1;
        }

        player setclientomnvar("ui_arm_squadmember_" + i + 1, var_f31235f8d2bec0f0);
      }
    }
  }
}

function choosesquadleader(team, index) {
  if(!istrue(level.usesquadleader)) {
    return;
  }

  var_ddb8d98c593d15de = 0;

  if(istrue(level.matchmakingmatch)) {
    fireteammembers = self getfireteammembers();

    if(isDefined(fireteammembers) && fireteammembers.size > 0) {
      var_ddb8d98c593d15de = self isfireteamleader();
    }
  }

  candidate = self;

  if(!var_ddb8d98c593d15de) {
    currentleader = getsquadleader(team, index);

    if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      if(isDefined(currentleader) && !isai(currentleader)) {
        return;
      }

      if(isai(candidate)) {
        var_beb6c9f3d61cf4e1 = 0;

        foreach(player in level.squaddata[team][index].players) {
          if(!isai(player)) {
            candidate = player;
            var_beb6c9f3d61cf4e1 = 1;
            break;
          }
        }

        if(!var_beb6c9f3d61cf4e1 && isDefined(currentleader)) {
          return;
        }
      }
    } else if(isDefined(currentleader)) {
      return;
    }
  }

  level.squaddata[team][index].squadleader = candidate;

  foreach(player in level.squaddata[team][index].players) {
    player setclientomnvar("ui_squad_leader", candidate);
  }
}

function debugprintsquads() {
  stepy = 25;

  while(true) {
    if(getdvarint(@ "hash_eb9b72744c4518d8", 0) == 1 && isDefined(level.squaddata)) {
      startx = 800;
      starty = 25;
      linecount = 1;
      printtoscreen2d(startx, starty, "<dev string:x1c>", (1, 1, 1), 1);

      foreach(squadarray in level.squaddata) {
        linecount = 1;
        printtoscreen2d(startx, starty + stepy * linecount, "<dev string:x27>" + team, (1, 1, 1), 1);
        linecount++;

        foreach(squad in squadarray) {
          color = (1, 1, 1);

          if(isDefined(squad.activemission)) {
            color = (1, 1, 0);
          }

          printtoscreen2d(startx + 25, starty + stepy * linecount, "<dev string:x2e>" + squad.index, color, 1);
          linecount++;

          foreach(player in squad.players) {
            color = (1, 1, 1);

            if(istrue(player.squadassignedfromlobby)) {
              color = (0, 1, 0);
            }

            printtoscreen2d(startx + 50, starty + stepy * linecount, player.name, color, 1);
            linecount++;
          }
        }

        startx += 200;
      }
    }

    waitframe();
  }
}

function getsquaddata(team, sessionsquadid, property) {
  assertex(isDefined(level.squaddata[team][sessionsquadid]), "UNDEFINED level.squadData[" + team + "][" + sessionsquadid + "]");
  assertex(function_be6ce63a202791c5(team, sessionsquadid, property), "UNDEFINED level.squadData[" + team + "][" + sessionsquadid + "][" + property + "]");

  if(isDefined(level.squaddata[team][sessionsquadid]) && isDefined(level.squaddata[team][sessionsquadid].properties) && isDefined(level.squaddata[team][sessionsquadid].properties[property])) {
    return level.squaddata[team][sessionsquadid].properties[property];
  }

  return undefined;
}

function function_a20a10ce593f692b(team, sessionsquadid, property, value) {
  assertex(isDefined(level.squaddata[team][sessionsquadid]), "UNDEFINED level.squadData[" + team + "][" + sessionsquadid + "]");
  assertex(function_be6ce63a202791c5(team, sessionsquadid, property), "UNDEFINED level.squadData[" + team + "][" + sessionsquadid + "][" + property + "]");
  assertex(isDefined(value), "setSquadData() undefined value");
  level.squaddata[team][sessionsquadid].properties[property] = value;
}

function function_be6ce63a202791c5(team, sessionsquadid, property) {
  assertex(isDefined(level.squaddata[team][sessionsquadid]), "UNDEFINED level.squadData[" + team + "][" + sessionsquadid + "]");

  if(!isDefined(level.squaddata[team][sessionsquadid].properties)) {
    return false;
  }

  return isDefined(level.squaddata[team][sessionsquadid].properties[property]);
}