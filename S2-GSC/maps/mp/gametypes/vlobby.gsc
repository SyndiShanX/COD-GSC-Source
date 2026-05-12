/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\vlobby.gsc
*********************************************/

func_00F9() {
  if(getDvar("1673") == "mp_background") {
    return;
  }

  maps\mp\gametypes\_globallogic::func_00D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  level.var_7A67 = 0;
  level.var_6BAF = ::func_6BAF;
  level.var_4696 = ::func_4696;
  level.var_7658 = undefined;
  level.var_A278 = undefined;
  level.var_6BA7 = ::func_6BA7;
  maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
  maps\mp\_utility::func_7BFA(level.var_3FDC, 0);
  maps\mp\_utility::func_7BF9(level.var_3FDC, 1);
  maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
  level.var_2322 = level.var_2319;
  level.var_2319 = ::func_6111;
  game["menu_team"] = "main";
  game["menu_class_allies"] = "main";
  game["menu_class_axis"] = "main";
  game["menu_changeclass_allies"] = "main";
  game["menu_changeclass_axis"] = "main";
  game["menu_changeclass"] = "menu_cac_assault";
  game["allies"] = "sentinel_vl";
  game["axis"] = "atlas";
}

func_6111(param_00) {
  level.var_5139 = 1;
  self.var_4B62 = 0;
  [[level.var_2322]](param_00);
}

func_6BAF() {
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_WAR");
  maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_WAR");
  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_WAR");
  lib_050D::func_10E4();
  var_00[0] = level.var_3FDC;
  maps\mp\gametypes\_gameobjects::func_00F9(var_00);
  level.var_7691 = 0;
  level.var_7692 = 0;
}

func_4696(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
    for(var_01 = 0; var_01 < level.var_744A.size; var_01++) {
      if(level.var_744A[var_01] == self) {
        param_00 = var_01;
        break;
      }
    }
  }

  var_02 = common_scripts\utility::func_46B7("player_pos", "targetname");
  var_03 = undefined;
  foreach(var_03 in var_02) {
    if(var_03.var_0165 == "" + param_00) {
      break;
    }
  }

  if(!isDefined(var_03)) {
    var_03 = var_02[0];
  }

  self.var_13B6 = var_03;
  return var_03;
}

func_6BA7() {
  if(isDefined(level.var_A592)) {
    self[[level.var_A592]]();
  }
}