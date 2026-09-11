/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\agent_common.gsc
***********************************************/

function codecallback_agentadded() {
  self[[level.initagentscriptvariables]]();
  var_0 = "axis";

  if(level.numagents % 2 == 0) {
    var_0 = "allies";
  }

  level.numagents++;
  self sethitlocdamagetable("ai_lochit_dmgtable");
  self[[level.setagentteam]](var_0);
  level.agentarray[level.agentarray.size] = self;
}

function codecallback_agentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = var_5;

  if(isDefined(level.weaponmapfunc)) {
    var_5 = [[level.weaponmapfunc]](var_5, var_0);
    var_12 = var_5;
  }

  var_1 = [[level.agentvalidateattacker]](var_1);
  var_13 = self[[level.agentfunc]]("on_damaged");

  if(isDefined(var_13)) {
    self[[var_13]](var_0, var_1, var_2, var_3, var_4, var_12, var_6, var_7, var_8, var_9, var_10, var_11, var_5);
    return;
  }
}

function codecallback_agentimpaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level.callbackplayerimpaled)) {
    [[level.callbackplayerimpaled]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    return;
  }
}

function codecallback_agentkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = var_5;
  var_1 = [[level.agentvalidateattacker]](var_1);

  if(isDefined(level.binoculars_setcurrentstate)) {
    self thread[[level.binoculars_setcurrentstate]](var_0, var_1, var_2, var_4, var_10, var_6, var_7, var_8, var_9);
    return;
  }

  var_11 = self[[level.agentfunc]]("on_killed");

  if(isDefined(var_11)) {
    self thread[[var_11]](var_0, var_1, var_2, var_4, var_10, var_6, var_7, var_8, var_9);
    return;
  }
}

function codecallback_agentfinishweaponchange(var_0, var_1) {}

function init() {
  initagentlevelvariables();
  scripts\anim\notetracks_mp::registernotetracks();
  scripts\asm\asm::setup_level_ents();
  thread add_agents_to_game();
}

function connectnewagent(var_0, var_1, var_2) {
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

function initagentlevelvariables() {
  level.agentarray = [];
  level.numagents = 0;
}

function add_agents_to_game() {
  level endon("game_ended");
  level waittill("connected", var_0);
  var_1 = getmaxagents();

  while(level.agentarray.size < var_1) {
    var_2 = addagent();

    if(!isDefined(var_2)) {
      waitframe();
    }
  }

  level notify("add_agents_to_game");
}

function set_agent_health(var_0) {
  self.agenthealth = var_0;
  self.health = var_0;
  self.maxhealth = var_0;
}