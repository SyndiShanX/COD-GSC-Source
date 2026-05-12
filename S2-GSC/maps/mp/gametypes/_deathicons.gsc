/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_deathicons.gsc
*********************************************/

func_00D5() {
  if(!level.var_984D) {
    return;
  }

  precacheshader("friendly_death_hud");
  level thread func_6B6C();
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00.var_83C1 = [];
  }
}

func_A107() {}

func_09AA(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!level.var_984D) {
    return;
  }

  if(isDefined(param_04)) {
    if(isPlayer(param_04) && param_04 maps\mp\_utility::func_0649("specialty_silentkill")) {
      return;
    }

    if(isDefined(param_05) && maps\mp\_utility::func_5755(param_05) && isDefined(param_06) && function_01A9(param_06) == "melee") {
      return;
    }
  }

  var_07 = param_00.var_0116;
  param_01 endon("spawned_player");
  param_01 endon("disconnect");
  wait 0.05;
  maps\mp\_utility::func_A790();
  if(getDvar("ui_hud_showdeathicons") == "0") {
    return;
  }

  if(level.var_4B17) {
    return;
  }

  if(isDefined(self.var_5B8E)) {
    self.var_5B8E destroy();
  }

  var_08 = newteamhudelem(param_02);
  var_08.var_01D3 = var_07[0];
  var_08.var_01D7 = var_07[1];
  var_08.var_01D9 = var_07[2] + 54;
  var_08.var_0018 = 0.61;
  var_08.var_0056 = (0.9058824, 0.8784314, 0.7686275);
  var_08.var_001F = 1;
  if(level.var_910F) {
    var_08 setshader("friendly_death_hud", 14, 14);
  } else {
    var_08 setshader("friendly_death_hud", 7, 7);
  }

  var_08 setwaypoint(0);
  self.var_5B8E = var_08;
  var_08 thread func_2DDC(param_03);
}

func_2DDC(param_00) {
  self endon("death");
  wait(param_00);
  self fadeovertime(1);
  self.var_0018 = 0;
  wait(1);
  self destroy();
}