/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\agent_common.gsc
***********************************************/

function codecallback_agentadded() {
  self[[level.initagentscriptvariables]]();
  var0 = "axis";

  if(level.numagents % 2 == 0) {
    var0 = "allies";
  }

  level.numagents++;
  self sethitlocdamagetable("ai_lochit_dmgtable");
  self[[level.setagentteam]](var0);
  level.agentarray[level.agentarray.size] = self;
}

function codecallback_agentdamaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = var5;

  if(isDefined(level.weaponmapfunc)) {
    var5 = [[level.weaponmapfunc]](var5, var0);
    var12 = var5;
  }

  var1 = [[level.agentvalidateattacker]](var1);
  var13 = self[[level.agentfunc]]("on_damaged");

  if(isDefined(var13)) {
    self[[var13]](var0, var1, var2, var3, var4, var12, var6, var7, var8, var9, var10, var11, var5);
    return;
  }
}

function codecallback_agentimpaled(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(level.callbackplayerimpaled)) {
    [[level.callbackplayerimpaled]](var0, var1, var2, var3, var4, var5, var6, var7);
    return;
  }
}

function codecallback_agentkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = var5;
  var1 = [[level.agentvalidateattacker]](var1);

  if(isDefined(level.binoculars_setcurrentstate)) {
    self thread[[level.binoculars_setcurrentstate]](var0, var1, var2, var4, var10, var6, var7, var8, var9);
    return;
  }

  var11 = self[[level.agentfunc]]("on_killed");

  if(isDefined(var11)) {
    self thread[[var11]](var0, var1, var2, var4, var10, var6, var7, var8, var9);
    return;
  }
}

function codecallback_agentfinishweaponchange(var0, var1) {}

function init() {
  initagentlevelvariables();
  scripts\anim\notetracks_mp::registernotetracks();
  scripts\asm\asm::setup_level_ents();
  thread add_agents_to_game();
}

function connectnewagent(var0, var1, var2) {
  var3 = [[level.getfreeagent]](var0);

  if(isDefined(var3)) {
    var3.connecttime = gettime();

    if(isDefined(var1)) {
      var3[[level.setagentteam]](var1);
    } else {
      var3[[level.setagentteam]](var3.team);
    }

    if(isDefined(var2)) {
      var3.class_override = var2;
    }

    if(isDefined(level.agent_funcs[var0]["onAIConnect"])) {
      var3[[var3[[level.agentfunc]]("onAIConnect")]]();
    }

    var3[[level.addtocharactersarray]]();
  }

  return var3;
}

function initagentlevelvariables() {
  level.agentarray = [];
  level.numagents = 0;
}

function add_agents_to_game() {
  level endon("game_ended");
  level waittill("connected", var0);
  var1 = getmaxagents();

  while(level.agentarray.size < var1) {
    var2 = addagent();

    if(!isDefined(var2)) {
      waitframe();
    }
  }

  level notify("add_agents_to_game");
}

function set_agent_health(var0) {
  self.agenthealth = var0;
  self.health = var0;
  self.maxhealth = var0;
}