/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_special_event_creator.gsc
************************************************************/

func_170B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  self.var_695B = param_03;
  self.var_696B = param_01;
  self.var_6943 = param_02;
  self.var_2E37 = param_05;
  self.var_2DA5 = param_06;
  self.var_2DA6 = param_07;
  self.var_AC2D = param_00;
  self.var_AC2C = 0;
  if(isDefined(param_08)) {
    self.var_7D24 = param_08;
  }

  if(isDefined(param_09)) {
    self.var_8C47 = param_09;
  }

  if(isDefined(param_0A)) {
    self.var_8C48 = param_0A;
  }

  if(!isDefined(level.var_08E3)) {
    level.var_08E3 = [];
  }

  level.var_08E3 = common_scripts\utility::func_0F6F(level.var_08E3, self);
  if(!isDefined(param_04) && !common_scripts\utility::func_0F79(level.var_376B, ::maps\mp\mp_zombie_nest_ee_util::func_4030)) {
    lib_0547::func_7BA9(::maps\mp\mp_zombie_nest_ee_util::func_4030);
  }

  if(isDefined(param_04)) {
    lib_0547::func_7BA9(param_04);
  }

  if(isDefined(param_0B)) {
    thread maps\mp\mp_zombie_nest_special_event_creator_util::func_4DED(param_0B);
  }

  while(self.var_AC2C < self.var_AC2D) {
    level waittill(self.var_695B);
    if(self.var_AC2C >= self.var_AC2D) {
      break;
    }
  }

  if(isDefined(param_0B)) {
    thread maps\mp\mp_zombie_nest_special_event_creator_util::func_9408();
  }

  lib_0378::func_8D74("zombie_soul_suck_threshold", self.var_0116);
  if(isDefined(param_04)) {
    lib_0547::func_2D8C(param_04);
  }

  level.var_08E3 = common_scripts\utility::func_0F93(level.var_08E3, self);
}

func_3135(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  var_0E = 0;
  var_0F = 1;
  var_10 = param_0B;
  var_10.var_1171 = param_02;
  var_10.var_38C2 = param_06;
  var_10.var_38B7 = param_07;
  var_10.var_38BA = 1500;
  maps\mp\mp_zombie_nest_special_event_creator_interface::func_08F3(var_10);
  while(!var_0E) {
    param_01[[param_00]](param_05, param_03, var_10.var_1171);
    [[param_08]](param_05, var_0F, param_03);
    maps\mp\mp_zombie_nest_special_event_creator_util::func_11B2(param_02);
    var_10.var_552B = 1;
    maps\mp\mp_zombie_nest_special_event_creator_interface::func_08F4(var_10, param_02, param_04, param_06, param_07, var_10, param_0C, param_0D);
    var_0E = param_01 maps\mp\mp_zombie_nest_special_event_creator_util::func_11BE(param_02, param_04, param_06, param_07, var_10, param_0C, param_0D);
    var_10.var_552B = 0;
    maps\mp\mp_zombie_nest_special_event_creator_interface::func_7C69(var_10);
    if(!var_0E) {
      level thread[[param_09]](param_01, param_02);
      maps\mp\mp_zombie_nest_special_event_creator_util::func_11B1(param_02);
    } else {
      level thread[[param_0A]](param_01, param_02, param_05);
      maps\mp\mp_zombie_nest_special_event_creator_util::func_11B3(param_02);
    }

    var_0F = 0;
    thread maps\mp\mp_zombie_nest_special_event_creator_util::func_11B0(param_02);
  }

  maps\mp\mp_zombie_nest_special_event_creator_interface::func_7C68(param_0B);
  for(var_11 = 0; var_11 < param_02.size; var_11++) {
    param_02[var_11] notify(param_04.var_94D4);
  }

  level notify(param_04.var_94D4);
}