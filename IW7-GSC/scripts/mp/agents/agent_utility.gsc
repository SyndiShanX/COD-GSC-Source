/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\agent_utility.gsc
***********************************************/

agentfunc(param_00) {
  return level.agent_funcs[self.agent_type][param_00];
}

set_agent_team(param_00, param_01) {
  self.team = param_00;
  self.var_20 = param_00;
  self.pers["team"] = param_00;
  self.triggerportableradarping = param_01;
  self setotherent(param_01);
  self setentityowner(param_01);
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

initplayerscriptvariables(param_00) {
  if(!param_00) {
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

getfreeagent(param_00) {
  var_01 = undefined;
  if(isDefined(level.agentarray)) {
    foreach(var_03 in level.agentarray) {
      if(!isDefined(var_03.isactive) || !var_03.isactive) {
        if(isDefined(var_03.waitingtodeactivate) && var_03.waitingtodeactivate) {
          continue;
        }

        var_01 = var_03;
        var_01 initagentscriptvariables();
        if(isDefined(param_00)) {
          var_01.agent_type = param_00;
        }

        break;
      }
    }
  }

  return var_01;
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
  foreach(var_01 in level.characters) {
    if(isDefined(var_01.attackers)) {
      foreach(var_04, var_03 in var_01.attackers) {
        if(var_03 == self) {
          var_01.attackers[var_04] = undefined;
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

getnumactiveagents(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "all";
  }

  var_01 = getactiveagentsoftype(param_00);
  return var_01.size;
}

getactiveagentsoftype(param_00) {
  var_01 = [];
  if(!isDefined(level.agentarray)) {
    return var_01;
  }

  foreach(var_03 in level.agentarray) {
    if(isDefined(var_03.isactive) && var_03.isactive) {
      if(param_00 == "all" || var_03.agent_type == param_00) {
        var_01[var_01.size] = var_03;
      }
    }
  }

  return var_01;
}

getnumownedactiveagents(param_00) {
  return getnumownedactiveagentsbytype(param_00, "all");
}

getnumownedactiveagentsbytype(param_00, param_01) {
  var_02 = 0;
  if(!isDefined(level.agentarray)) {
    return var_02;
  }

  foreach(var_04 in level.agentarray) {
    if(isDefined(var_04.isactive) && var_04.isactive) {
      if(isDefined(var_04.triggerportableradarping) && var_04.triggerportableradarping == param_00) {
        if((param_01 == "all" && var_04.agent_type != "alien") || var_04.agent_type == param_01) {
          var_02++;
        }
      }
    }
  }

  return var_02;
}

getnumownedagentsonteambytype(param_00, param_01) {
  var_02 = 0;
  if(!isDefined(level.agentarray)) {
    return var_02;
  }

  foreach(var_04 in level.agentarray) {
    if(isDefined(var_04.isactive) && var_04.isactive) {
      if(isDefined(var_04.team) && var_04.team == param_00) {
        if((param_01 == "all" && var_04.agent_type != "alien") || var_04.agent_type == param_01) {
          var_02++;
        }
      }
    }
  }

  return var_02;
}

getvalidspawnpathnodenearplayer(param_00, param_01) {
  var_02 = getnodesinradius(self.origin, 350, 64, 128, "Path");
  if(!isDefined(var_02) || var_02.size == 0) {
    return undefined;
  }

  if(isDefined(level.waterdeletez) && isDefined(level.trigunderwater)) {
    var_03 = var_02;
    var_02 = [];
    foreach(var_05 in var_03) {
      if(var_05.origin[2] > level.waterdeletez || !ispointinvolume(var_05.origin, level.trigunderwater)) {
        var_02[var_02.size] = var_05;
      }
    }
  }

  var_07 = anglesToForward(self.angles);
  var_08 = -10;
  var_09 = scripts\mp\spawnlogic::getplayertraceheight(self);
  var_0A = (0, 0, var_09);
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_0B = [];
  var_0C = [];
  foreach(var_0E in var_02) {
    if(!var_0E getrandomattachments("stand") || isDefined(var_0E.no_agent_spawn)) {
      continue;
    }

    var_0F = vectornormalize(var_0E.origin - self.origin);
    var_10 = vectordot(var_07, var_0F);
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

    if(param_01) {
      if(var_11 > 0) {
        wait(0.05);
      }

      var_16 = playerphysicstrace(var_0E.origin + var_0A, var_0E.origin);
      if(distancesquared(var_16, var_0E.origin) > 1) {
        continue;
      }
    }

    if(param_00) {
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

killagent(param_00) {
  param_00 dodamage(param_00.health + 500000, param_00.origin);
}

killdog() {
  self[[agentfunc("on_damaged")]](level, undefined, self.health + 1, 0, "MOD_CRUSH", "none", (0, 0, 0), (0, 0, 0), "none", 0);
}