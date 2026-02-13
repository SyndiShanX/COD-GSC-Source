/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2566.gsc
*************************************************/

_id_AAE3(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  foreach(var_3 in level._id_9EE2) {
    if(!isDefined(var_3._id_5562) || var_3._id_5562 != "equip_claymore") {
      continue;
    }
    if(!isDefined(var_3.owner) || !scripts\cp_mp\utility\player_utility::_id_B78C(var_0, var_3.owner)) {
      continue;
    }
    if(distancesquared(var_1, var_3.origin) < 262144) {
      var_3 thread _id_0A05::_id_381E(var_0);
    }
  }
}

_id_AB61(var_0) {
  var_1 = var_0._id_103C2;
  var_2 = var_0.attacker;
  var_3 = var_0.point;

  if(var_0._id_9CD6 == "MOD_IMPACT") {
    return 1;
  }

  if(var_2 == var_1 && distancesquared(var_3, var_1.origin) > 65536) {
    return 0;
  }

  var_1 thread _id_19CC(var_0.inflictor, var_2);
  var_2 _id_07C3::_id_3AC3("equip_concussion");
  var_2 scripts\mp\utility\stats::_id_7DAE("stunHits", 1);
  return 1;
}

_id_19CC(var_0, var_1) {
  if(scripts\mp\utility\player::_id_8ACE()) {
    return;
  }
  if(scripts\mp\utility\game::_id_875E() || level.gametype == "br" && var_1 scripts\mp\gametypes\br_public::_id_8990()) {
    var_2 = level._id_ED2C;
    var_3 = level._id_ED2C;
  } else {
    var_2 = 1;
    var_3 = 1.5;
  }

  var_4 = self == var_1;

  if(var_4) {
    if(scripts\mp\utility\game::_id_875E() || level.gametype == "br" && var_1 scripts\mp\gametypes\br_public::_id_8990()) {
      var_2 = max(level._id_ED2C - 1, 0.5);
      var_3 = max(level._id_ED2C - 1, 0.5);
    } else {
      var_2 = 0.5;
      var_3 = 1;
    }
  }

  var_5 = 1 - distance(self.origin, var_0.origin) / 512;

  if(var_5 < 0) {
    var_5 = 0;
  }

  if(scripts\mp\utility\game::_id_875E()) {
    var_6 = var_2;
  } else {
    var_6 = var_2 + var_3 * var_5;
  }

  var_6 = _id_0A6B::_id_19ED(var_1, self, var_6);
  var_1 _id_07BC::_id_ABB0("equip_concussion");
  thread scripts\mp\gamescore::_id_F3FB(var_1, self, "s4_stun_gbr_n69_mp", var_6);
  var_1 notify("stun_hit");
  self notify("concussed", var_1);
  scripts\mp\weapons::_id_D675();
  thread scripts\mp\weapons::_id_3879(var_6);

  if(scripts\mp\utility\perk::_hasperk("specialty_stun_resistance")) {
    _id_09C8::_id_0CF9("weak_concussion_grenade_mp", "stun", var_6, 1);
  } else {
    _id_09C8::_id_0CF9("mild_concussion_grenade_mp", "stun", var_6, 1);
  }

  if(var_1 scripts\mp\utility\perk::_hasperk("specialty_tactical_outline") && self != var_1) {
    thread _id_0A6B::_id_ED35(var_1);
  }

  scripts\mp\utility\player::_id_3A20("stun", var_6);
}

_id_2EEC(var_0) {
  return max(0, var_0 - 1.9) * 1000;
}