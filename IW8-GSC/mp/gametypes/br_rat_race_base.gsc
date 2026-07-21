/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_rat_race_base.gsc
***********************************************/

_id_140F9() {
  _id_140FA();
}

_id_140FA() {
  var_0 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C("_encstr_82A11CC91AD708B9C32369637B4975109472D16103593860995B5B5B7BA3", 1);
  var_0.type = 1;
  var_0.usetime = 0.75;
  var_0._encstr_BEC50A783C37EEECF3424A55 = 1.5;
  var_0._id_14077 = 7;
  var_0._id_14075 = 100000;
  var_0._id_13ACC = 0;
  var_0._id_12F7D = "_encstr_921D20D5C238C817F34FA0DD5362B910DBAFD74845F0513EA3286F60A9C6B33B65CB";
  var_0._id_12F7E = "_encstr_8E8607AB603B6E4341";
  var_0._id_12F77 = "_encstr_ADB209DDA0A3209B828060";
  var_0._encstr_8FD60DAA488AB988410FD9E0602337 = "_encstr_95C2207A1EDE7B7E81D93914118B3DE397608EFFB5845FF5DFC161F8097FABB7AD41";
  var_0.overrideviewkickscaledmr = 10800;
  var_0.origin_delta = 0;
  var_0.get_closest_enemy_near_turret = 0;
  var_0.outline_enemy_ai_for_duration = "_encstr_8AE1099A0B999F2D28AF15";
  var_0.brking_ispointinmovingcircle = getdvarint("_encstr_9AC12F9B36E47D13E4F5C163AEE62356C9FA561E474E16363AD2BDB9AF67B0AEC63ABE0B8DD8EDEE7DCD1DB216D84BB9EC", 1) != 0;
  var_0._encstr_A73E0C5F793D9AE488D0AD33A8F8 = getdvarint("_encstr_B4A82D5AE910DF5A4ECFABD3B378025DB8F657E06348A982A55BCFE3FF1C1A85B03B41AADB18712A6863CFEFC3C893", 2500);
  var_0._encstr_9A3E230F7B8B52C5C0AB85CB40A01D4BE895EBA7E735CB9CA8313A557B682F03BE015F2F51 = 50;
}

_id_140F5(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3 setModel("_encstr_82A11CC91AD708B9C32369637B4975109472D16103593860995B5B5B7BA3");
  var_3.team = var_2;
  var_3.angles = var_1;
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12796(var_3, "_encstr_82A11CC91AD708B9C32369637B4975109472D16103593860995B5B5B7BA3");
  var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_3.team);
  thread _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_127A4(var_3, var_4);
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_127AA(var_3, var_4);

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && isPlayer(var_6)) {
      var_3 setotherent(var_6);
      break;
    }
  }

  return var_3;
}

_id_140FB() {
  var_0 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C("_encstr_82A11CC91AD708B9C32369637B4975109472D16103593860995B5B5B7BA3");

  if(var_0.brking_ispointinmovingcircle) {
    var_1 = "_encstr_A2FB098A2035874AB0F358";
    var_2 = undefined;
    var_3 = undefined;
    var_4 = 1;
    thread scripts\mp\damage::monitordamage(500, var_1, ::_id_140F8, ::_id_140F7, var_2, var_3, var_4);
  }
}

_id_140F7(var_0) {
  if(self.plunder.size <= 0)
    return 0;

  if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_0.attacker, self)))
    return 0;

  var_1 = scripts\mp\damage::handleshotgundamage(var_0.objweapon, var_0.meansofdeath, var_0.damage);

  if(var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981")
    var_1 = int(ceil(self.maxhealth / 6));
  else if(isexplosivedamagemod(var_0.meansofdeath)) {
    if(var_0.damage >= 50)
      var_1 = int(ceil(self.maxhealth / 2));
  }

  return var_1;
}

_id_140F8(var_0) {
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_B89535894ED7CE58D6CA47BC0756BE27C28EBE9C0BD895AFE5DEEA277DA35958DAEBE61DDE8DCABE999CDE6BBE59DCACD65EEB13586ECA", undefined, var_0.attacker.team);
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_865830F65A310F91D52708685BF56E9D7A43E006762AC31E857398F0673723D9E2ED65180F538F805707C038A31F592B8BD7", undefined, self.team);
  var_1 = 1;
  var_2 = _encstr_BA6F2E3318E5A43B7B56C78DEF285FEE73B0CBEBE8939A8E513EAFBF0F081F73A3B04201407393170BAF9BB5B0919FFE::replace_access_card_on_deathordisconnect();
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::num_rocket_per_attack(var_1, var_2);
  scripts\mp\damage::monitordamageend();
  wait 1;
  _id_140FB();
}