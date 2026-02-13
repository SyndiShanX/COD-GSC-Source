/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1977.gsc
*************************************************/

_id_2F97() {
  _id_078A::_id_2F98();
  _id_0A8E::_id_C285(_id_078A::_id_2FA0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ping", "calloutMarkerPing_squadLeaderBeaconShouldCreate", ::_id_2FB0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer", ::_id_2FAE);
  level._effect["vfx_br_beacon_circle"] = loadfx("vfx/_requests/br_gameplay/vfx_br_beacon_circle");
}

_id_2FB0(var_0, var_1, var_2) {
  if(!getdvarint("#x36ce6c1076c79435d", 0)) {
    return;
  }
  if(var_0 scripts\mp\gametypes\br_public::_id_898B() && istrue(var_0._id_2A64) && var_1 == _id_078A::_id_2F91() || getdvarint("#x3427e57284d891cc7", 0)) {
    _id_2FAD(var_2);
  }
}

_id_2FAD(var_0) {
  var_1 = self;
  var_2 = scripts\engine\utility::getfx("vfx_br_beacon_circle");
  var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_1.team, 1);

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_E49A)) {
      var_5._id_E49A delete();
    }

    var_5._id_E49A = _func_020D(var_2, var_0, var_5);
    triggerfx(var_5._id_E49A);
    var_5._id_E49A _meth_8322();
    var_5._id_E498 = var_0;
    var_5._id_E499 = 892.5;
    var_5._id_E49B = 1;
  }
}

_id_2FAF() {
  var_0 = self;

  if(!getdvarint("#x36ce6c1076c79435d", 0)) {
    return;
  }
  if(!istrue(var_0._id_E49B)) {
    return;
  }
  if(scripts\engine\utility::_id_89BA(var_0.origin, var_0._id_E498, var_0._id_E499)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
      var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]]("br_beacon_bonus");
    }
  }

  var_0._id_E49A delete();
  var_0._id_E498 = undefined;
  var_0._id_E499 = undefined;
  var_0._id_E49B = undefined;
}

_id_2FAE(var_0) {
  if(!getdvarint("#x36ce6c1076c79435d", 0)) {
    return;
  }
  if(isDefined(var_0._id_E49A)) {
    var_0._id_E49A delete();
    var_0._id_E498 = undefined;
    var_0._id_E499 = undefined;
    var_0._id_E49B = undefined;
  }
}