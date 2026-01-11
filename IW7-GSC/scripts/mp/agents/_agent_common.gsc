/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\_agent_common.gsc
***********************************************/

codecallback_agentadded() {
  self[[level.initagentscriptvariables]]();
  var_00 = "axis";
  if(level.numagents % 2 == 0) {
    var_00 = "allies";
  }

  level.numagents++;
  self sethitlocdamagetable("locdmgtable\mp_lochit_dmgtable");
  self[[level.setagentteam]](var_00);
  level.agentarray[level.agentarray.size] = self;
}

codecallback_agentdamaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  param_01 = [[level.agentvalidateattacker]](param_01);
  var_0C = self[[level.agentfunc]]("on_damaged");
  if(isDefined(var_0C)) {
    self[[var_0C]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  }
}

codecallback_agentimpaled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(isDefined(level.callbackplayerimpaled)) {
    [[level.callbackplayerimpaled]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07);
  }
}

codecallback_agentkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  param_01 = [[level.agentvalidateattacker]](param_01);
  var_0A = self[[level.agentfunc]]("on_killed");
  if(isDefined(var_0A)) {
    self thread[[var_0A]](param_00, param_01, param_02, param_04, param_05, param_06, param_07, param_08, param_09);
  }
}

func_00A7(param_00, param_01, param_02, param_03) {}

func_00A8(param_00, param_01) {}

func_00A9(param_00, param_01, param_02, param_03) {}

init() {
  initagentlevelvariables();
  scripts\mp\agents\_scriptedagents::registernotetracks();
  level thread add_agents_to_game();
}

connectnewagent(param_00, param_01, param_02) {
  var_03 = [[level.getfreeagent]](param_00);
  if(isDefined(var_03)) {
    var_03.connecttime = gettime();
    if(isDefined(param_01)) {
      var_03[[level.setagentteam]](param_01);
    } else {
      var_03[[level.setagentteam]](var_03.team);
    }

    if(isDefined(param_02)) {
      var_03.class_override = param_02;
    }

    if(isDefined(level.agent_funcs[param_00]["onAIConnect"])) {
      var_03[[var_03[[level.agentfunc]]("onAIConnect")]]();
    }

    var_03[[level.addtocharactersarray]]();
  }

  return var_03;
}

initagentlevelvariables() {
  level.agentarray = [];
  level.numagents = 0;
}

add_agents_to_game() {
  level endon("game_ended");
  level waittill("connected", var_00);
  var_01 = getmaxagents();
  while(level.agentarray.size < var_01) {
    var_02 = addagent();
    if(!isDefined(var_02)) {
      scripts\engine\utility::waitframe();
      continue;
    }
  }
}

set_agent_health(param_00) {
  self.var_1E = param_00;
  self.health = param_00;
  self.maxhealth = param_00;
}