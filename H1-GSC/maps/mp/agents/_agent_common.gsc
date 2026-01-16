/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\agents\_agent_common.gsc
********************************************/

codecallback_agentadded() {
  maps\mp\agents\_agent_utility::initagentscriptvariables();
  var_0 = "axis";

  if(level.numagents % 2 == 0)
    var_0 = "allies";

  level.numagents++;
  maps\mp\agents\_agent_utility::set_agent_team(var_0);
  level.agentarray[level.agentarray.size] = self;
}

codecallback_agentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_1 = maps\mp\_utility::_validateattacker(var_1);
  self[[maps\mp\agents\_agent_utility::agentfunc("on_damaged")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

codecallback_agentkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_1 = maps\mp\_utility::_validateattacker(var_1);
  self thread[[maps\mp\agents\_agent_utility::agentfunc("on_killed")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

init() {
  initagentlevelvariables();
  level thread add_agents_to_game();
}

connectnewagent(var_0, var_1, var_2) {
  var_3 = maps\mp\agents\_agent_utility::getfreeagent(var_0);

  if(isdefined(var_3)) {
    var_3.connecttime = gettime();

    if(isdefined(var_1))
      var_3 maps\mp\agents\_agent_utility::set_agent_team(var_1);
    else
      var_3 maps\mp\agents\_agent_utility::set_agent_team(var_3.team);

    if(isdefined(var_2))
      var_3.class_override = var_2;

    if(isdefined(level.agent_funcs[var_0]["onAIConnect"]))
      var_3[[var_3 maps\mp\agents\_agent_utility::agentfunc("onAIConnect")]]();

    var_3 maps\mp\gametypes\_spawnlogic::addtocharactersarray();
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

  while (level.agentarray.size < var_1) {
    var_2 = addagent();

    if(!isdefined(var_2)) {
      waitframe();
      continue;
    }
  }
}

set_agent_health(var_0) {
  self.agenthealth = var_0;
  self.health = var_0;
  self.maxhealth = var_0;
}