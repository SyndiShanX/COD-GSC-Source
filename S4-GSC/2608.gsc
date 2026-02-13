/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2608.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("airdrop", scripts\cp_mp\killstreaks\airdrop::_id_F768);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "airdropMultipleInit", ::_id_1371);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "registerScoreInfo", ::_id_139A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "registerActionSet", ::_id_1398);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "updateUIProgress", ::_id_13A1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "allowActionSet", ::_id_1372);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "unresolvedCollisionNearestNode", ::_id_13A0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "awardKillstreak", ::_id_1374);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "showKillstreakSplash", ::_id_139D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "getTargetMarker", ::_id_137C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "airdropMultipleDropCrates", ::_id_1370);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "outlineDisable", ::_id_1396);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "captureLootCacheCallback", ::_id_1379);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "isKillstreakBlockedForBots", ::_id_137F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "botIsKillstreakSupported", ::_id_1375);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "applyImmediateJuggernaut", ::_id_1373);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "monitorDamage", _id_07C3::_id_A0FF);
}

_id_1371() {
  _id_09AA::_id_138E();
}

_id_139A() {
  scripts\mp\rank::_id_C2AC("little_bird", "value", 200);
}

_id_1398() {
  var_0 = getdvarint("#x382fa2a2b8a12fe7f", 1);

  if(var_0) {
    scripts\mp\playeractions::_id_C23B("crateUse", ["offhand_weapons", "fire", "melee", "weapon_switch", "killstreaks", "supers", "allow_movement", "allow_jump"]);
  } else {
    scripts\mp\playeractions::_id_C23B("crateUse", ["offhand_weapons", "weapon", "killstreaks", "supers", "allow_movement", "allow_jump"]);
  }
}

_id_13A1(var_0, var_1) {
  _id_07D6::_id_FD75(var_0, var_1);
}

_id_1372(var_0, var_1) {
  scripts\mp\playeractions::_id_1596(var_0, var_1);
}

_id_13A0(var_0, var_1, var_2) {
  childthread scripts\mp\movers::_id_F9AA(var_0, var_1, var_2);
}

_id_1374(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;
  var_5 = undefined;

  if(level.gametype == "grnd" || level.gametype == "kspoint") {
    var_3 = 0;
    var_4 = 0;
    var_5 = var_1;
  } else if(isDefined(var_2.streakinfo)) {
    var_3 = var_2.streakinfo._id_A2B6._id_EA0F;
    var_4 = var_2.streakinfo._id_A2B6._id_EA10;
    var_5 = var_2.streakinfo.owner;
  }

  thread scripts\mp\killstreaks\killstreaks::_id_1FC8(var_0, var_1, var_3, var_4, var_5);
  scripts\mp\utility\stats::_id_7DAE("carepackagesCaptured", 1);
}

_id_139D(var_0, var_1, var_2) {
  scripts\mp\hud_message::_id_DCBD(var_0, var_1, var_2);
}

_id_137C(var_0) {
  return _id_0A61::_id_6DBE(var_0);
}

_id_1370(var_0, var_1, var_2, var_3, var_4, var_5) {
  return _id_09AA::_id_138B(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_1396(var_0, var_1) {
  scripts\mp\utility\outline::outlinedisable(var_0, var_1);
}

_id_1379() {
  return scripts\mp\gametypes\plunder::_id_322F;
}

_id_137F(var_0) {
  return _id_09F4::_id_88EC(var_0);
}

_id_1375(var_0) {
  return _id_09F4::_id_2809(var_0);
}

_id_1373(var_0) {
  var_1 = "juggernaut";
  var_2 = scripts\mp\killstreaks\killstreaks::_id_4057(var_1);
  var_2._id_9925 = _id_07EE::_id_6DE4(gettime());
  var_2._id_EA0F = self._id_936C;
  var_2._id_EA10 = self._id_9BC0;
  var_2.owner = self;
  var_2._id_ADB5 = self getxuid();
  var_2._id_0EF1 = _id_07EE::_id_6DE4(gettime());
  _id_07A9::_id_9770(self, var_2._id_EA0F, var_2.streakname, var_2._id_887C, var_2._id_0EF1, self.origin);
  scripts\mp\killstreaks\killstreaks::_id_3ABE(var_1);
  _id_0A8D::_id_B871(var_1);
  var_3 = scripts\cp_mp\utility\killstreak_utility::_id_4056(var_1, self);
  var_3._id_A2B6 = var_2;
  _id_09B8::_id_F78F(var_3, var_0);
}