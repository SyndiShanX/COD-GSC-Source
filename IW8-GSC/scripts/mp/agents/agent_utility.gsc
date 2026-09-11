/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\agent_utility.gsc
***********************************************/

function agentfunc(var0) {
  return level.agent_funcs[self.agent_type][var0];
}

function set_agent_team(var0, var1) {
  self.team = var0;
  self.agentteam = var0;
  self.pers["team"] = var0;
  self.owner = var1;
  self setotherent(var1);
  self setentityowner(var1);
}

function initagentscriptvariables() {
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
  self.agentname = undefined;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self detachall();
  initplayerscriptvariables(0);
}

function initplayerscriptvariables(var0) {
  if(!var0) {
    self.class = undefined;
    self.lastclass = undefined;
    self.movespeedscaler = undefined;
    self.avoidkillstreakonspawntimer = undefined;
    self.guid = undefined;
    self.name = undefined;
    self.perks = undefined;
    self.weaponlist = undefined;
    self.objectivescaler = undefined;
    self.touchtriggers = undefined;
    self.carryobject = undefined;
    self.canpickupobject = undefined;
    self.sessionteam = undefined;
    self.sessionstate = undefined;
    self.lastspawntime = undefined;
    self.lastspawnpoint = undefined;
    scripts\common\input_allow::clear_allow_info("weapon");
    scripts\common\input_allow::clear_allow_info("weaponSwitch");
    scripts\common\input_allow::clear_allow_info("offhandWeaps");
    scripts\common\input_allow::clear_allow_info("usability");
    self.shieldbullethits = undefined;
    self.recentshieldxp = undefined;
    return;
  }

  self.movespeedscaler = 1;
  self.avoidkillstreakonspawntimer = 5;
  self.guid = scripts\mp\utility\player::getuniqueid();
  self.name = self.guid;
  self.sessionteam = self.team;
  self.sessionstate = "playing";
  self.shieldbullethits = 0;
  self.recentshieldxp = 0;
  self.agent_gameparticipant = 1;

  if(scripts\mp\utility\entity::isgameparticipant(self)) {
    self.objectivescaler = 1;
    scripts\mp\gameobjects::init_player_gameobjects();
    return;
  }
}

function getfreeagent(var0) {
  var1 = undefined;

  if(isDefined(level.agentarray)) {
    foreach(var3 in level.agentarray) {
      if(!isDefined(var3.isactive) || !var3.isactive) {
        if(isDefined(var3.waitingtodeactivate) && var3.waitingtodeactivate) {
          continue;
        }

        var1 = var3;
        initagentscriptvariables(var1);

        if(isDefined(var0)) {
          var1.agent_type = var0;
        }

        break;
      }
    }
  }

  return var1;
}

function activateagent() {
  self.isactive = 1;
}

function deactivateagent() {
  thread deactivateagentdelayed();
}

function deactivateagentdelayed() {
  self notify("deactivateAgentDelayed");
  self endon("deactivateAgentDelayed");

  if(scripts\mp\utility\entity::isgameparticipant(self)) {
    scripts\mp\spawnlogic::removefromparticipantsarray();
  }

  scripts\mp\spawnlogic::removefromcharactersarray();
  wait 0.05;
  self.isactive = 0;
  self.hasdied = 0;
  self.owner = undefined;
  self.connecttime = undefined;
  self.waitingtodeactivate = undefined;

  foreach(var1 in level.characters) {
    if(isDefined(var1.attackers)) {
      foreach(var3 in var1.attackers) {
        if(var3 == self) {
          var1.attackers[var4] = undefined;
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

function getnumactiveagents(var0) {
  if(!isDefined(var0)) {
    var0 = "all";
  }

  var1 = getactiveagentsoftype(var0);
  return var1.size;
}

function getactiveagentsoftype(var0) {
  var1 = [];

  if(!isDefined(level.agentarray)) {
    return var1;
  }

  foreach(var3 in level.agentarray) {
    if(isDefined(var3.isactive) && var3.isactive) {
      if(var0 == "all" || var3.agent_type == var0) {
        var1 = var3;
      }
    }
  }

  return var1;
}

function getnumownedactiveagents(var0) {
  return getnumownedactiveagentsbytype(var0, "all");
}

function getnumownedactiveagentsbytype(var0, var1) {
  var2 = 0;

  if(!isDefined(level.agentarray)) {
    return var2;
  }

  foreach(var4 in level.agentarray) {
    if(isDefined(var4.isactive) && var4.isactive) {
      if(isDefined(var4.owner) && var4.owner == var0) {
        if(var1 == "all" && var4.agent_type != "alien" || var4.agent_type == var1) {
          var2++;
        }
      }
    }
  }

  return var2;
}

function getnumownedagentsonteambytype(var0, var1) {
  var2 = 0;

  if(!isDefined(level.agentarray)) {
    return var2;
  }

  foreach(var4 in level.agentarray) {
    if(isDefined(var4.isactive) && var4.isactive) {
      if(isDefined(var4.team) && var4.team == var0) {
        if(var1 == "all" && var4.agent_type != "alien" || var4.agent_type == var1) {
          var2++;
        }
      }
    }
  }

  return var2;
}

function getvalidspawnpathnodenearplayer(var0, var1) {
  var2 = getnodesinradius(self.origin, 350, 64, 128, "Path");

  if(!isDefined(var2) || var2.size == 0) {
    return undefined;
  }

  if(isDefined(level.waterdeletez) && isDefined(level.trigunderwater)) {
    var3 = var2;
    var2 = [];

    foreach(var5 in var3) {
      if(var5.origin[2] > level.waterdeletez || !ispointinvolume(var5.origin, level.trigunderwater)) {
        var2 = var5;
      }
    }
  }

  var7 = anglesToForward(self.angles);
  var8 = -10;
  var9 = scripts\mp\spawnlogic::getplayertraceheight(self);
  var10 = (0, 0, var9);

  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  var11 = [];
  var12 = [];

  foreach(var14 in var2) {
    if(!var14 doesnodeallowstance("stand") || isDefined(var14.no_agent_spawn)) {
      continue;
    }

    var15 = vectorNormalize(var14.origin - self.origin);
    var16 = vectordot(var7, var15);

    for(var17 = 0; var17 < var12.size; var17++) {
      if(var16 > var12[var17]) {
        for(var18 = var12.size; var18 > var17; var18--) {
          var12 = var12[var18 - 1];
          var11 = var11[var18 - 1];
        }

        break;
      }
    }

    var11 = var14;
    var12 = var16;
  }

  for(var17 = 0; var17 < var11.size; var17++) {
    var14 = var11[var17];
    var20 = self.origin + var10;
    var21 = var14.origin + var10;

    if(var17 > 0) {
      wait 0.05;
    }

    if(!sighttracepassed(var20, var21, 0, self)) {
      continue;
    }

    if(var1) {
      if(var17 > 0) {
        wait 0.05;
      }

      var22 = playerphysicstrace(var14.origin + var10, var14.origin);

      if(distancesquared(var22, var14.origin) > 1) {
        continue;
      }
    }

    if(var0) {
      if(var17 > 0) {
        wait 0.05;
      }

      var22 = physicstrace(var20, var21);

      if(distancesquared(var22, var21) > 1) {
        continue;
      }
    }

    return var14;
  }
}

function killagent(var0) {
  var0 dodamage(var0.health + 500000, var0.origin);
}

function killdog() {
  self[[agentfunc("on_damaged")]](level, undefined, self.health + 1, 0, "MOD_CRUSH", "none", (0, 0, 0), (0, 0, 0), "none", 0);
}