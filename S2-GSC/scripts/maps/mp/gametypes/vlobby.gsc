/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\vlobby.gsc
************************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();
  level.rankedmatch = 0;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level._id_7658 = undefined;
  level._id_A278 = undefined;
  level.onspawnplayer = ::onspawnplayer;
  maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
  maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
  maps\mp\_utility::registerscorelimitdvar(level.gametype, 1);
  maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
  level.classold = level.class;
  level.class = ::menuclass;
  game["menu_team"] = "main";
  game["menu_class_allies"] = "main";
  game["menu_class_axis"] = "main";
  game["menu_changeclass_allies"] = "main";
  game["menu_changeclass_axis"] = "main";
  game["menu_changeclass"] = "menu_cac_assault";
  game["allies"] = "sentinel_vl";
  game["axis"] = "atlas";
}

menuclass(var_0) {
  level.ingraceperiod = 1;
  self.hasdonecombat = 0;
  [[level.classold]](var_0);
}

onstartgametype() {
  _setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_WAR");
  _id_050D::_id_10E4();
  var_0[0] = level.gametype;
  _id_04D1::main(var_0);
  level.prematchperiod = 0;
  level.prematchperiodend = 0;
}

getspawnpoint(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;

    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      if(level.players[var_1] == self) {
        var_0 = var_1;
        break;
      }
    }
  }

  var_2 = common_scripts\utility::getstructarray("player_pos", "targetname");
  var_3 = undefined;

  foreach(var_3 in var_2) {
    if(var_3._id_0165 == "" + var_0) {
      break;
    }
  }

  if(!isDefined(var_3)) {
    var_3 = var_2[0];
  }

  self.avatar_spawnpoint = var_3;
  return var_3;
}

onspawnplayer() {
  if(isDefined(level.vl_onspawnplayer)) {
    self[[level.vl_onspawnplayer]]();
  }
}