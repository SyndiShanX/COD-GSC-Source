/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1273.gsc
*********************************************/

func_52C6() {
  level.var_79C2.var_9FF0 = 30;
  level.var_79C2.var_9FEF = 30;
}

func_7937(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_02)) {
    param_02 = 120;
  }

  if(!isDefined(param_03)) {
    param_03 = 9;
  }

  if(!isDefined(param_04)) {
    param_04 = (1, 1, 1);
  }

  if(self issplitscreenplayer() && !function_03BA()) {
    param_01 = param_01 + 20;
  }

  var_06 = newclienthudelem(self);
  var_06.var_35B2 = "raid_cd_bar";
  var_06.maxsightdistsqrd = 0;
  var_06.var_1D7 = 0;
  var_06.var_3E6E = 0;
  var_06.var_56 = param_04;
  var_06.ignoreme = -2;
  var_06.var_8AC7 = "progress_bar_fill";
  var_06 setshader("progress_bar_fill", param_02, param_03);
  var_06.var_606D = param_02;
  var_06.var_6058 = param_03;
  var_06.var_21F6 = [];
  var_06 maps\mp\gametypes\_hud_util::func_86EF(level.var_A012);
  var_06.var_4CC7 = 0;
  var_06 maps\mp\gametypes\_hud_util::func_8707("CENTER", undefined, param_00, param_01);
  var_06.accuracy = "left";
  var_06.maxsightdistsqrd = var_06.maxsightdistsqrd - int(param_02 / 2);
  var_06.var_1F = 0;
  var_06.var_C2 = 1;
  var_06.var_180 = 0;
  var_06.var_18 = param_05;
  return var_06;
}

func_79EA(param_00) {
  if(param_00 > 1) {
    param_00 = 1;
  } else if(param_00 < 0) {
    param_00 = 0;
  }

  var_01 = int(self.var_606D * param_00 + 0.5);
  if(!var_01) {
    var_01 = 1;
  }

  self.var_3E6E = param_00;
  self setshader(self.var_8AC7, var_01, self.var_6058);
  self.var_294E = self.var_8AC7;
  self.var_5C09 = gettime();
}

func_7936(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(param_05)) {
    param_05 = 1;
  }

  if(!isDefined(param_06)) {
    param_06 = -1;
  }

  var_07 = newclienthudelem(self);
  var_07.var_35B2 = "icon";
  var_07.var_21F6 = [];
  var_07 setshader(param_00, param_03, param_04);
  var_07 maps\mp\gametypes\_hud_util::func_86EF(level.var_A012);
  var_07 maps\mp\gametypes\_hud_util::func_8707("CENTER", undefined, param_01, param_02);
  var_07.var_56 = (1, 1, 1);
  var_07.var_18 = param_05;
  var_07.ignoreme = param_06;
  var_07.var_C2 = 1;
  var_07.var_180 = 0;
  var_07.var_1F = 0;
  return var_07;
}

func_7938(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(!isDefined(param_03)) {
    param_03 = -1;
  }

  var_04 = newclienthudelem(self);
  var_04.var_35B2 = "text";
  var_04.var_21F6 = [];
  var_04 maps\mp\gametypes\_hud_util::func_86EF(level.var_A012);
  var_04 maps\mp\gametypes\_hud_util::func_8707("CENTER", undefined, param_00, param_01);
  var_04.var_9B = 1;
  var_04.var_56 = (1, 1, 0);
  var_04.var_18 = param_02;
  var_04.ignoreme = param_03;
  var_04.var_C2 = 1;
  var_04.var_180 = 0;
  var_04.var_1F = 0;
  var_04 settext("2");
  return var_04;
}