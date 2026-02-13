/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2568.gsc
*************************************************/

_id_518B(var_0) {
  self endon("disconnect");
  var_0 endon("explode_end");
  var_0 thread scripts\mp\utility\script::_id_A695("death", "explode_end");
  var_0 waittill("explode", var_1);
  var_2 = _id_078D::_id_646E();
  var_3 = makeweapon("emp_grenade_mp");

  foreach(var_5 in var_2) {
    var_6 = var_5.owner;

    if(isDefined(var_6)) {
      if(var_6 != self && !scripts\cp_mp\utility\player_utility::_id_B78C(self, var_6)) {
        continue;
      }
    }

    var_7 = distancesquared(var_1, var_5.origin);

    if(var_7 > 262144) {
      continue;
    }
    var_8 = _id_09BF::_id_ADCA(self, var_5, 1, var_3, "MOD_EXPLOSIVE", var_0, var_1);
    thread _id_5188(var_8);
  }

  var_10 = scripts\mp\utility\player::_id_6C5F(var_1, 512);

  foreach(var_12 in var_10) {
    if(!var_12 _id_078D::_id_30C2()) {
      continue;
    }
    if(var_12 != self && !scripts\cp_mp\utility\player_utility::_id_B78C(self, var_12)) {
      continue;
    }
    var_8 = _id_09BF::_id_ADCA(self, var_12, 1, var_3, "MOD_EXPLOSIVE", var_0, var_1);
    thread _id_5189(var_8);
  }
}

_id_5188(var_0) {
  _id_078D::_id_19B9(var_0);
  _id_518A(var_0, 6);

  if(isDefined(var_0._id_103C2)) {
    var_0._id_103C2 _id_078D::_id_C3AE();
  }
}

_id_5189(var_0) {
  _id_078D::_id_19B9(var_0);
  scripts\mp\gamescore::_id_F3FA(var_0.attacker, var_0._id_103C2, var_0.objweapon.basename);
  var_1 = scripts\engine\utility::ter_op(var_0.attacker == var_0._id_103C2, 2, 6);
  _id_518A(var_0, var_1);

  if(isDefined(var_0._id_103C2)) {
    var_0._id_103C2 _id_078D::_id_C3AE();

    if(isDefined(var_0.attacker) && scripts\mp\utility\player::isreallyalive(var_0.attacker)) {
      scripts\mp\gamescore::_id_FB2C(var_0.attacker, var_0._id_103C2, var_0.objweapon.basename);
    }
  }
}

_id_518A(var_0, var_1) {
  var_0._id_103C2 endon("death_or_disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::_id_108F7("emp_cleared", var_1);
}