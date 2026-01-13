/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\agent_utility.gsc
***********************************************/

agentfunc(var_0) {
  return level.agent_funcs[self.agent_type][var_0];
}

set_agent_team(var_0, var_1) {
  self.team = var_0;
  self.var_20 = var_0;
  self.pers["team"] = var_0;
  self.triggerportableradarping = var_1;
  self setotherent(var_1);
  self setentityowner(var_1);
}

initagentscriptvariables() {
  self.agent_type = "player";
  self.pers = [];
  self.hasdied = 0;
  self.isactive = 0;
  self.isagent = 1;
  self.wasti = 0;
  self.spawntime = 0;
  self.entity_number = self getentitynumber();
  self.agent_teamparticipant = 0;
  self.agent_gameparticipant = 0;
  self.var_1F = undefined;
  self detachall();
  initplayerscriptvariables(0);
}

initplayerscriptvariables(var_0) {
  if(!var_0) {
    self.class = undefined;
    self.lastclass = undefined;
    self.movespeedscaler = undefined;
    self.avoidkillstreakonspawntimer = undefined;
    self.guid = undefined;
    self.name = undefined;
    self.saved_actionslotdata = undefined;
    self.perks = undefined;
    self.weaponlist = undefined;
    self.var_C47E = undefined;
    self.objectivescaler = undefined;
    self.touchtriggers = undefined;
    self.carryobject = undefined;
    self.var_3FFA = undefined;
    self.var_38ED = undefined;
    self.var_A64F = undefined;
    self.sessionteam = undefined;
    self.sessionstate = undefined;
    self.lastspawntime = undefined;
    self.lastspawnpoint = undefined;
    self.disabledweapon = undefined;
    self.disabledweaponswitch = undefined;
    self.disabledoffhandweapons = undefined;
    self.disabledusability = undefined;
    self.var_FC96 = undefined;
    self.var_FC95 = undefined;
    self.recentshieldxp = undefined;
  } else {
    self.movespeedscaler = 1;
    self.avoidkillstreakonspawntimer = 4;
    self.guid = scripts\mp\utility::getuniqueid();
    self.name = self.guid;
    self.sessionteam = self.team;
    self.sessionstate = "playing";
    self.var_FC96 = 0;
    self.var_FC95 = 0;
    self.recentshieldxp = 0;
    self.agent_gameparticipant = 1;
    scripts\mp\playerlogic::setupsavedactionslots();
    thread scripts\mp\perks\_perks::onplayerspawned();
    if(scripts\mp\utility::isgameparticipant(self)) {
      self.objectivescaler = 1;
      scripts\mp\gameobjects::init_player_gameobjects();
      self.disabledweapon = 0;
      self.disabledweaponswitch = 0;
      self.disabledoffhandweapons = 0;
    }
  }

  self.disabledusability = 1;
}

getfreeagent(var_0) {
  var_1 = undefined;
  if(isDefined(level.agentarray)) {
    foreach(var_3 in level.agentarray) {
      if(!isDefined(var_3.isactive) || !var_3.isactive) {
        if(isDefined(var_3.waitingtodeactivate) && var_3.waitingtodeactivate) {
          continue;
        }

        var_1 = var_3;
        var_1 initagentscriptvariables();
        if(isDefined(var_0)) {
          var_1.agent_type = var_0;
        }

        break;
      }
    }
  }

  return var_1;
}

activateagent() {
  self.isactive = 1;
}

deactivateagent() {
  thread deactivateagentdelayed();
}

deactivateagentdelayed() {
  self notify("deactivateAgentDelayed");
  self endon("deactivateAgentDelayed");
  if(scripts\mp\utility::isgameparticipant(self)) {
    scripts\mp\spawnlogic::removefromparticipantsarray();
  }

  scripts\mp\spawnlogic::removefromcharactersarray();
  wait(0.05);
  self.isactive = 0;
  self.hasdied = 0;
  self.triggerportableradarping = undefined;
  self.connecttime = undefined;
  self.waitingtodeactivate = undefined;
  foreach(var_1 in level.characters) {
    if(isDefined(var_1.attackers)) {
      foreach(var_4, var_3 in var_1.attackers) {
        if(var_3 == self) {
          var_1.attackers[var_4] = undefined;
        }
      }
    }
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
    self.headmodel = undefined;
  }

  self notify("disconnect");
}

getnumactiveagents(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  var_1 = getactiveagentsoftype(var_0);
  return var_1.size;
}

getactiveagentsoftype(var_0) {
  var_1 = [];
  if(!isDefined(level.agentarray)) {
    return var_1;
  }

  foreach(var_3 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_0 == "all" || var_3.agent_type == var_0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

getnumownedactiveagents(var_0) {
  return getnumownedactiveagentsbytype(var_0, "all");
}

getnumownedactiveagentsbytype(var_0, var_1) {
  var_2 = 0;
  if(!isDefined(level.agentarray)) {
    return var_2;
  }

  foreach(var_4 in level.agentarray) {
    if(isDefined(var_4.isactive) && var_4.isactive) {
      if(isDefined(var_4.triggerportableradarping) && var_4.triggerportableradarping == var_0) {
        if((var_1 == "all" && var_4.agent_type != "alien") || var_4.agent_type == var_1) {
          var_2++;
        }
      }
    }
  }

  return var_2;
}

getnumownedagentsonteambytype(var_0, var_1) {
  var_2 = 0;
  if(!isDefined(level.agentarray)) {
    return var_2;
  }

  foreach(var_4 in level.agentarray) {
    if(isDefined(var_4.isactive) && var_4.isactive) {
      if(isDefined(var_4.team) && var_4.team == var_0) {
        if((var_1 == "all" && var_4.agent_type != "alien") || var_4.agent_type == var_1) {
          var_2++;
        }
      }
    }
  }

  return var_2;
}

getvalidspawnpathnodenearplayer(var_0, var_1) {
  var_2 = getnodesinradius(self.origin, 350, 64, 128, "Path");
  if(!isDefined(var_2) || var_2.size == 0) {
    return undefined;
  }

  if(isDefined(level.waterdeletez) && isDefined(level.trigunderwater)) {
    var_3 = var_2;
    var_2 = [];
    foreach(var_5 in var_3) {
      if(var_5.origin[2] > level.waterdeletez || !ispointinvolume(var_5.origin, level.trigunderwater)) {
        var_2[var_2.size] = var_5;
      }
    }
  }

  var_7 = anglesToForward(self.angles);
  var_8 = -10;
  var_9 = scripts\mp\spawnlogic::getplayertraceheight(self);
  var_0A = (0, 0, var_9);
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_0B = [];
  var_0C = [];
  foreach(var_0E in var_2) {
    if(!var_0E getrandomattachments("stand") || isDefined(var_0E.no_agent_spawn)) {
      continue;
    }

    var_0F = vectornormalize(var_0E.origin - self.origin);
    var_10 = vectordot(var_7, var_0F);
    for(var_11 = 0; var_11 < var_0C.size; var_11++) {
      if(var_10 > var_0C[var_11]) {
        for(var_12 = var_0C.size; var_12 > var_11; var_12--) {
          var_0C[var_12] = var_0C[var_12 - 1];
          var_0B[var_12] = var_0B[var_12 - 1];
        }

        break;
      }
    }

    var_0B[var_11] = var_0E;
    var_0C[var_11] = var_10;
  }

  for(var_11 = 0; var_11 < var_0B.size; var_11++) {
    var_0E = var_0B[var_11];
    var_14 = self.origin + var_0A;
    var_15 = var_0E.origin + var_0A;
    if(var_11 > 0) {
      wait(0.05);
    }

    if(!sighttracepassed(var_14, var_15, 0, self)) {
      continue;
    }

    if(var_1) {
      if(var_11 > 0) {
        wait(0.05);
      }

      var_16 = playerphysicstrace(var_0E.origin + var_0A, var_0E.origin);
      if(distancesquared(var_16, var_0E.origin) > 1) {
        continue;
      }
    }

    if(var_0) {
      if(var_11 > 0) {
        wait(0.05);
      }

      var_16 = physicstrace(var_14, var_15);
      if(distancesquared(var_16, var_15) > 1) {
        continue;
      }
    }

    return var_0E;
  }
}

killagent(var_0) {
  var_0 dodamage(var_0.health + 500000, var_0.origin);
}

killdog() {
  self[[agentfunc("on_damaged")]](level, undefined, self.health + 1, 0, "MOD_CRUSH", "none", (0, 0, 0), (0, 0, 0), "none", 0);
}