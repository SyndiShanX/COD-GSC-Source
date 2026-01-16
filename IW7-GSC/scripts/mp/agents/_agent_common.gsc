/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\_agent_common.gsc
***********************************************/

codecallback_agentadded() {
  self[[level.initagentscriptvariables]]();
  var_0 = "axis";
  if(level.numagents % 2 == 0) {
    var_0 = "allies";
  }

  level.numagents++;
  self sethitlocdamagetable("locdmgtable\mp_lochit_dmgtable");
  self[[level.setagentteam]](var_0);
  level.agentarray[level.agentarray.size] = self;
}

codecallback_agentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_1 = [[level.agentvalidateattacker]](var_1);
  var_12 = self[[level.agentfunc]]("on_damaged");
  if(isDefined(var_12)) {
    self[[var_12]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }
}

codecallback_agentimpaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level.callbackplayerimpaled)) {
    [[level.callbackplayerimpaled]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

codecallback_agentkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_1 = [[level.agentvalidateattacker]](var_1);
  var_10 = self[[level.agentfunc]]("on_killed");
  if(isDefined(var_10)) {
    self thread[[var_10]](var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

func_00A7(var_0, var_1, var_2, var_3) {}

func_00A8(var_0, var_1) {}

func_00A9(var_0, var_1, var_2, var_3) {}

init() {
  initagentlevelvariables();
  scripts\mp\agents\_scriptedagents::registernotetracks();
  level thread add_agents_to_game();
}

connectnewagent(var_0, var_1, var_2) {
  var_3 = [[level.getfreeagent]](var_0);
  if(isDefined(var_3)) {
    var_3.connecttime = gettime();
    if(isDefined(var_1)) {
      var_3[[level.setagentteam]](var_1);
    } else {
      var_3[[level.setagentteam]](var_3.team);
    }

    if(isDefined(var_2)) {
      var_3.class_override = var_2;
    }

    if(isDefined(level.agent_funcs[var_0]["onAIConnect"])) {
      var_3[[var_3[[level.agentfunc]]("onAIConnect")]]();
    }

    var_3[[level.addtocharactersarray]]();
  }

  return var_3;
}

initagentlevelvariables() {
  level.agentarray = [];
  level.numagents = 0;
}

add_agents_to_game() {
  level endon("game_ended");
  level waittill("connected", var_0);
  var_1 = getmaxagents();
  while(level.agentarray.size < var_1) {
    var_2 = addagent();
    if(!isDefined(var_2)) {
      scripts\engine\utility::waitframe();
      continue;
    }
  }
}

set_agent_health(var_0) {
  self.var_1E = var_0;
  self.health = var_0;
  self.maxhealth = var_0;
}