/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\agents\agent_utility.gsc
***********************************************/

agentfunc(var_0) {
  return level.agent_funcs[self.agent_type][var_0];
}

set_agent_team(var_0, var_1) {
  self.team = var_0;
  self.agentteam = var_0;
  self.pers["_encstr_8AEF05472BC2D6"] = var_0;
  self.owner = var_1;
  self setotherent(var_1);
  self setentityowner(var_1);
}

initagentscriptvariables() {
  self.agent_type = "_encstr_8BB007E03658CBCAE4";
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

initplayerscriptvariables(var_0) {
  if(!var_0) {
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
    scripts\common\input_allow::clear_allow_info("_encstr_AC20072B9FA9487832");
    scripts\common\input_allow::clear_allow_info("_encstr_8E170DEB5287C7806DA30733AC1680");
    scripts\common\input_allow::clear_allow_info("_encstr_A3760DF666334316CD32AE2B58079B");
    scripts\common\input_allow::clear_allow_info("_encstr_9BE40A0BC09BCEF7C0F33441");
    self.shieldbullethits = undefined;
    self.recentshieldxp = undefined;
  } else {
    self.movespeedscaler = 1;
    self.avoidkillstreakonspawntimer = 5;
    self.guid = scripts\mp\utility\player::getuniqueid();
    self.name = self.guid;
    self.sessionteam = self.team;
    self.sessionstate = "_encstr_877508C1D8C22F2DDC3B";
    self.shieldbullethits = 0;
    self.recentshieldxp = 0;
    self.agent_gameparticipant = 1;

    if(scripts\mp\utility\entity::isgameparticipant(self)) {
      self.objectivescaler = 1;
      scripts\mp\gameobjects::init_player_gameobjects();
    }
  }
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

        if(isDefined(var_0))
          var_1.agent_type = var_0;

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
  self notify("_encstr_AA4B17644DD177EB2358F29BF84B672768ADCC1D5179A777D1");
  self endon("_encstr_AA4B17644DD177EB2358F29BF84B672768ADCC1D5179A777D1");

  if(scripts\mp\utility\entity::isgameparticipant(self))
    scripts\mp\spawnlogic::removefromparticipantsarray();

  scripts\mp\spawnlogic::removefromcharactersarray();
  wait 0.05;
  self.isactive = 0;
  self.hasdied = 0;
  self.owner = undefined;
  self.connecttime = undefined;
  self.waitingtodeactivate = undefined;

  foreach(var_1 in level.characters) {
    if(isDefined(var_1.attackers)) {
      foreach(var_4, var_3 in var_1.attackers) {
        if(var_3 == self)
          var_1.attackers[var_4] = undefined;
      }
    }
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
    self.headmodel = undefined;
  }

  self notify("_encstr_8D820B49520F0EC02DDE6367EC");
}

getnumactiveagents(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_AF1904A7F929";

  var_1 = getactiveagentsoftype(var_0);
  return var_1.size;
}

getactiveagentsoftype(var_0) {
  var_1 = [];

  if(!isDefined(level.agentarray))
    return var_1;

  foreach(var_3 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_0 == "_encstr_AF1904A7F929" || var_3.agent_type == var_0)
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

getnumownedactiveagents(var_0) {
  return getnumownedactiveagentsbytype(var_0, "_encstr_AF1904A7F929");
}

getnumownedactiveagentsbytype(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(level.agentarray))
    return var_2;

  foreach(var_4 in level.agentarray) {
    if(isDefined(var_4.isactive) && var_4.isactive) {
      if(isDefined(var_4.owner) && var_4.owner == var_0) {
        if(var_1 == "_encstr_AF1904A7F929" && var_4.agent_type != "_encstr_97BB06B0C64B59B9" || var_4.agent_type == var_1)
          var_2++;
      }
    }
  }

  return var_2;
}

getnumownedagentsonteambytype(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(level.agentarray))
    return var_2;

  foreach(var_4 in level.agentarray) {
    if(isDefined(var_4.isactive) && var_4.isactive) {
      if(isDefined(var_4.team) && var_4.team == var_0) {
        if(var_1 == "_encstr_AF1904A7F929" && var_4.agent_type != "_encstr_97BB06B0C64B59B9" || var_4.agent_type == var_1)
          var_2++;
      }
    }
  }

  return var_2;
}

getvalidspawnpathnodenearplayer(var_0, var_1) {
  var_2 = getnodesinradius(self.origin, 350, 64, 128, "_encstr_8F0D0582C21D43");

  if(!isDefined(var_2) || var_2.size == 0)
    return undefined;

  if(isDefined(level.waterdeletez) && isDefined(level.trigunderwater)) {
    var_3 = var_2;
    var_2 = [];

    foreach(var_5 in var_3) {
      if(var_5.origin[2] > level.waterdeletez || !ispointinvolume(var_5.origin, level.trigunderwater))
        var_2[var_2.size] = var_5;
    }
  }

  var_7 = anglesToForward(self.angles);
  var_8 = -10;
  var_9 = scripts\mp\spawnlogic::getplayertraceheight(self);
  var_10 = (0, 0, var_9);

  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  var_11 = [];
  var_12 = [];

  foreach(var_14 in var_2) {
    if(!var_14 doesnodeallowstance("_encstr_A5AD069B231F0BAF") || isDefined(var_14.no_agent_spawn)) {
      continue;
    }
    var_15 = vectorNormalize(var_14.origin - self.origin);
    var_16 = vectordot(var_7, var_15);

    for(var_17 = 0; var_17 < var_12.size; var_17++) {
      if(var_16 > var_12[var_17]) {
        for(var_18 = var_12.size; var_18 > var_17; var_18--) {
          var_12[var_18] = var_12[var_18 - 1];
          var_11[var_18] = var_11[var_18 - 1];
        }

        break;
      }
    }

    var_11[var_17] = var_14;
    var_12[var_17] = var_16;
  }

  for(var_17 = 0; var_17 < var_11.size; var_17++) {
    var_14 = var_11[var_17];
    var_20 = self.origin + var_10;
    var_21 = var_14.origin + var_10;

    if(var_17 > 0)
      wait 0.05;

    if(!sighttracepassed(var_20, var_21, 0, self)) {
      continue;
    }
    if(var_1) {
      if(var_17 > 0)
        wait 0.05;

      var_22 = playerphysicstrace(var_14.origin + var_10, var_14.origin);

      if(distancesquared(var_22, var_14.origin) > 1)
        continue;
    }

    if(var_0) {
      if(var_17 > 0)
        wait 0.05;

      var_22 = physicstrace(var_20, var_21);

      if(distancesquared(var_22, var_21) > 1)
        continue;
    }

    return var_14;
  }
}

killagent(var_0) {
  var_0 dodamage(var_0.health + 500000, var_0.origin);
}

killdog() {
  self[[agentfunc("_encstr_8BB20BDE37D723C2DA859DACC8")]](level, undefined, self.health + 1, 0, "_encstr_8D4E0A501FCB898912CB3FA3", "_encstr_8BBA05185F8B99", (0, 0, 0), (0, 0, 0), "_encstr_8BBA05185F8B99", 0);
}