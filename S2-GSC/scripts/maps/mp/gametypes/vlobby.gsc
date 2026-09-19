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
  level._id_6BAF = ::_id_6BAF;
  level._id_4696 = ::_id_4696;
  level._id_7658 = undefined;
  level._id_A278 = undefined;
  level._id_6BA7 = ::_id_6BA7;
  maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
  maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
  maps\mp\_utility::registerscorelimitdvar(level.gametype, 1);
  maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
  level._id_2322 = level.class;
  level.class = ::_id_6111;
  game["menu_team"] = "main";
  game["menu_class_allies"] = "main";
  game["menu_class_axis"] = "main";
  game["menu_changeclass_allies"] = "main";
  game["menu_changeclass_axis"] = "main";
  game["menu_changeclass"] = "menu_cac_assault";
  game["allies"] = "sentinel_vl";
  game["axis"] = "atlas";
}

_id_6111(var_0) {
  level.ingraceperiod = 1;
  self._id_4B62 = 0;
  [[level._id_2322]](var_0);
}

_id_6BAF() {
  _setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_WAR");
  _id_050D::_id_10E4();
  var_0[0] = level.gametype;
  _id_04D1::main(var_0);
  level._id_7691 = 0;
  level._id_7692 = 0;
}

_id_4696(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;

    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      if(level.players[var_1] == self) {
        var_0 = var_1;
        break;
      }
    }
  }

  var_2 = common_scripts\utility::_id_46B7("player_pos", "targetname");
  var_3 = undefined;

  foreach(var_3 in var_2) {
    if(var_3._id_0165 == "" + var_0) {
      break;
    }
  }

  if(!isDefined(var_3))
    var_3 = var_2[0];

  self._id_13B6 = var_3;
  return var_3;
}

_id_6BA7() {
  if(isDefined(level._id_A592))
    self[[level._id_A592]]();
}