/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\agents\agent_common.gsc
***********************************************/

codecallback_agentadded() {
  self[[level.initagentscriptvariables]]();
  var_0 = "_encstr_8E8405EA382B2A";

  if(level.numagents % 2 == 0)
    var_0 = "_encstr_9A8507BA4040188D08";

  level.numagents++;
  self sethitlocdamagetable("_encstr_96861358B47D63ED8D43D2E8F532AD76D10B893656");
  self[[level.setagentteam]](var_0);
  level.agentarray[level.agentarray.size] = self;
}

codecallback_agentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = var_5;

  if(isDefined(level.weaponmapfunc)) {
    var_5 = [[level.weaponmapfunc]](var_5, var_0);
    var_12 = var_5;
  }

  var_1 = [[level.agentvalidateattacker]](var_1);
  var_13 = self[[level.agentfunc]]("_encstr_8BB20BDE37D723C2DA859DACC8");

  if(isDefined(var_13))
    self[[var_13]](var_0, var_1, var_2, var_3, var_4, var_12, var_6, var_7, var_8, var_9, var_10, var_11, var_5);
}

codecallback_agentimpaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level.callbackplayerimpaled))
    [[level.callbackplayerimpaled]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

codecallback_agentkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = var_5;
  var_1 = [[level.agentvalidateattacker]](var_1);

  if(isDefined(level.binoculars_setcurrentstate))
    self thread[[level.binoculars_setcurrentstate]](var_0, var_1, var_2, var_4, var_10, var_6, var_7, var_8, var_9);
  else {
    var_11 = self[[level.agentfunc]]("_encstr_96330A95DD7FB43840C92ACD");

    if(isDefined(var_11))
      self thread[[var_11]](var_0, var_1, var_2, var_4, var_10, var_6, var_7, var_8, var_9);
  }
}

codecallback_agentfinishweaponchange(var_0, var_1) {}

init() {
  initagentlevelvariables();
  _encstr_A22E1FE61B4E96838E9B792C73B4B6E5DC7BE8B2479CC28D6DE6EBD61CC5CEDCC6::registernotetracks();
  scripts\asm\asm::setup_level_ents();
  level thread add_agents_to_game();
}

connectnewagent(var_0, var_1, var_2) {
  var_3 = [[level.getfreeagent]](var_0);

  if(isDefined(var_3)) {
    var_3.connecttime = gettime();

    if(isDefined(var_1))
      var_3[[level.setagentteam]](var_1);
    else
      var_3[[level.setagentteam]](var_3.team);

    if(isDefined(var_2))
      var_3.class_override = var_2;

    if(isDefined(level.agent_funcs[var_0]["_encstr_A7720CD718453940A7481DD72649"]))
      var_3[[var_3[[level.agentfunc]]("_encstr_A7720CD718453940A7481DD72649")]]();

    var_3[[level.addtocharactersarray]]();
  }

  return var_3;
}

initagentlevelvariables() {
  level.agentarray = [];
  level.numagents = 0;
}

add_agents_to_game() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
  var_1 = getmaxagents();

  while(level.agentarray.size < var_1) {
    var_2 = addagent();

    if(!isDefined(var_2)) {
      waitframe();
      continue;
    }
  }

  level notify("_encstr_B43D134691384702BCC3BB2B17489BBF3959FECD29");
}

set_agent_health(var_0) {
  self.agenthealth = var_0;
  self.health = var_0;
  self.maxhealth = var_0;
}