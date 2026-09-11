/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\emp_grenade.gsc
************************************************/

function emp_grenade_used(var_0) {
  self endon("disconnect");
  var_0 endon("explode_end");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  var_0 waittill("explode", var_1);
  var_2 = scripts\cp_mp\emp_debuff::get_emp_ents();
  var_3 = getcompleteweaponname("emp_grenade_mp");

  foreach(var_5 in var_2) {
    var_6 = var_5.owner;

    if(isDefined(var_6)) {
      if(var_6 != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, var_6)) {
        continue;
      }
    }

    var_7 = distancesquared(var_1, var_5.origin);

    if(var_7 > 262144) {
      continue;
    }

    var_8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self, var_5, 1, var_3, "MOD_EXPLOSIVE", var_0, var_1);
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

    var_8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self, var_12, 1, var_3, "MOD_EXPLOSIVE", var_0, var_1);
    thread emp_grenade_apply_player(var_8);
  }
}

function emp_grenade_apply_non_player(var_0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  emp_grenade_end_early(var_0, 6);

  if(isDefined(var_0.victim)) {
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();
    return;
  }
}

function emp_grenade_apply_player(var_0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  var_1 = scripts\engine\utility::ter_op(var_0.attacker == var_0.victim, 2, 6);
  thread scripts\mp\gamescore::trackdebuffassistfortime(var_0.attacker, var_0.victim, var_0.objweapon.basename, var_1, "emp_cleared");
  emp_grenade_end_early(var_0, var_1);

  if(isDefined(var_0.victim)) {
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();
    return;
  }
}

function emp_grenade_end_early(var_0, var_1) {
  var_0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var_1);
}