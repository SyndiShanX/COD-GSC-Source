/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 8.gsc
***************************************/

codecallback_agentadded() {
  self[[level.initagentscriptvariables]]();
  var_00 = "axis";

  if(level.numagents % 2 == 0)
    var_00 = "allies";

  level.numagents++;
  self sethitlocdamagetable("locdmgtable\mp_lochit_dmgtable");
  self[[level.setagentteam]](var_00);
  level.agentarray[level.agentarray.size] = self;
}

codecallback_agentdamaged(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  var_01 = [
    [level.agentvalidateattacker]
  ](var_01);
  var_12 = self[[level.agentfunc]]("on_damaged");

  if(isDefined(var_12))
    self[[var_12]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
}

codecallback_agentimpaled(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(isDefined(level.callbackplayerimpaled))
    [[level.callbackplayerimpaled]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07);
}

codecallback_agentkilled(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  var_01 = [
    [level.agentvalidateattacker]
  ](var_01);
  var_10 = self[[level.agentfunc]]("on_killed");

  if(isDefined(var_10))
    self thread[[var_10]](var_00, var_01, var_02, var_04, var_05, var_06, var_07, var_08, var_09);
}

func_00A7(var_00, var_01, var_02, var_03) {}

func_00A8(var_00, var_01) {}

func_00A9(var_00, var_01, var_02, var_03) {}

init() {
  initagentlevelvariables();
  scripts\anim\notetracks_mp::registernotetracks();
  level thread add_agents_to_game();
}

connectnewagent(var_00, var_01, var_02) {
  var_03 = [
    [level.getfreeagent]
  ](var_00);

  if(isDefined(var_03)) {
    var_3.connecttime = gettime();

    if(isDefined(var_01))
      var_03[[level.setagentteam]](var_01);
    else
      var_03[[level.setagentteam]](var_3.team);

    if(isDefined(var_02))
      var_3.class_override = var_02;

    if(isDefined(level.agent_funcs[var_00]["onAIConnect"]))
      var_03[[var_03[[level.agentfunc]]("onAIConnect")]]();

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

set_agent_health(var_00) {
  self.agenthealth = var_00;
  self.health = var_00;
  self.maxhealth = var_00;
}