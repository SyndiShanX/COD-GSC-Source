/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\emp_grenade.gsc
************************************************/

function emp_grenade_used(var0) {
  self endon("disconnect");
  var0 endon("explode_end");
  var0 thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  var0 waittill("explode", var1);
  var2 = scripts\cp_mp\emp_debuff::get_emp_ents();
  var3 = getcompleteweaponname("emp_grenade_mp");

  foreach(var5 in var2) {
    var6 = var5.owner;

    if(isDefined(var6)) {
      if(var6 != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, var6)) {
        continue;
      }
    }

    var7 = distancesquared(var1, var5.origin);

    if(var7 > 262144) {
      continue;
    }

    var8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self, var5, 1, var3, "MOD_EXPLOSIVE", var0, var1);
    thread emp_grenade_apply_non_player(var8);
  }

  var10 = scripts\mp\utility\player::getplayersinradius(var1, 512);

  foreach(var12 in var10) {
    if(!var12 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }

    if(var12 != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, var12)) {
      continue;
    }

    var8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self, var12, 1, var3, "MOD_EXPLOSIVE", var0, var1);
    thread emp_grenade_apply_player(var8);
  }
}

function emp_grenade_apply_non_player(var0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var0);
  emp_grenade_end_early(var0, 6);

  if(isDefined(var0.victim)) {
    var0.victim scripts\cp_mp\emp_debuff::remove_emp();
    return;
  }
}

function emp_grenade_apply_player(var0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var0);
  var1 = scripts\engine\utility::ter_op(var0.attacker == var0.victim, 2, 6);
  thread scripts\mp\gamescore::trackdebuffassistfortime(var0.attacker, var0.victim, var0.objweapon.basename, var1, "emp_cleared");
  emp_grenade_end_early(var0, var1);

  if(isDefined(var0.victim)) {
    var0.victim scripts\cp_mp\emp_debuff::remove_emp();
    return;
  }
}

function emp_grenade_end_early(var0, var1) {
  var0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var1);
}