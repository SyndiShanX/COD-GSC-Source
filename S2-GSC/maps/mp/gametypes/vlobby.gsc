/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\vlobby.gsc
*********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }

  maps\mp\gametypes\_globallogic::init();
  lib_01DD::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();
  level.rankedmatch = 0;
  level.var_6BAF = ::func_6BAF;
  level.var_4696 = ::func_4696;
  level.var_7658 = undefined;
  level.var_A278 = undefined;
  level.var_6BA7 = ::func_6BA7;
  maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
  maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
  maps\mp\_utility::registerscorelimitdvar(level.gametype, 1);
  maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
  level.var_2322 = level.class;
  level.class = ::func_6111;
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

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_WAR");
  lib_050D::func_10E4();
  var_00[0] = level.gametype;
  maps\mp\gametypes\_gameobjects::main(var_00);
  level.prematchperiod = 0;
  level.prematchperiodend = 0;
}

func_4696(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
    for(var_01 = 0; var_01 < level.players.size; var_01++) {
      if(level.players[var_01] == self) {
        param_00 = var_01;
        break;
      }
    }
  }

  var_02 = common_scripts\utility::func_46B7("player_pos", "targetname");
  var_03 = undefined;
  foreach(var_03 in var_02) {
    if(var_03.script_noteworthy == "" + param_00) {
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