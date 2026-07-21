/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\emp_grenade.gsc
***********************************************/

emp_grenade_used(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_91A50C1BA8D2A87053EA5E01420B");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_91A50C1BA8D2A87053EA5E01420B");
  var_0 waittill("_encstr_860808CB78E2984063BA", var_1);
  var_2 = scripts\cp_mp\emp_debuff::get_emp_ents();
  var_3 = getcompleteweaponname("_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E");

  foreach(var_5 in var_2) {
    var_6 = var_5.owner;

    if(isDefined(var_6)) {
      if(var_6 != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, var_6))
        continue;
    }

    var_7 = distancesquared(var_1, var_5.origin);

    if(var_7 > 262144) {
      continue;
    }
    var_8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self, var_5, 1, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_0, var_1);
    thread emp_grenade_apply_non_player(var_8);
  }

  var_10 = scripts\mp\utility\player::getplayersinradius(var_1, 512);

  foreach(var_12 in var_10) {
    if(!var_12 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }
    if(var_12 != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, var_12)) {
      continue;
    }
    var_8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self, var_12, 1, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_0, var_1);
    thread emp_grenade_apply_player(var_8);
  }
}

emp_grenade_apply_non_player(var_0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  emp_grenade_end_early(var_0, 6);

  if(isDefined(var_0.victim))
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();
}

emp_grenade_apply_player(var_0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  var_1 = scripts\engine\utility::ter_op(var_0.attacker == var_0.victim, 2, 6);
  thread scripts\mp\gamescore::trackdebuffassistfortime(var_0.attacker, var_0.victim, var_0.objweapon.basename, var_1, "_encstr_99C40CA749E1F16B80389FEB2BB9");
  emp_grenade_end_early(var_0, var_1);

  if(isDefined(var_0.victim))
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();
}

emp_grenade_end_early(var_0, var_1) {
  var_0.victim endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_99C40CA749E1F16B80389FEB2BB9", var_1);
}