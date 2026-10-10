/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_22856b83897eaad8.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\engine\utility;
#namespace ob_armor;

function init_armor() {
  level.var_e8f60267621fda8d = &function_c71dfd42d05c80b1;
  level.var_49bf61396483bae7 = &function_1260ae7112d01f9c;
  registersharedfunc("ob_armor", "set_golden_armor", &set_golden_armor);

  level thread function_e54948c0841f1fd5();
}

function set_golden_armor() {
  self.var_28c033c3c5b37f1f = 1;
  thread function_fdb99149ef6e3583();
  scripts\cp_mp\armor::setarmoromnvars();
}

function function_ed2a0bbe317941f6() {
  self.var_28c033c3c5b37f1f = undefined;
  scripts\cp_mp\armor::setarmoromnvars();
}

function function_fdb99149ef6e3583() {
  level endon("game_ended");
  self endon("death");
  self.var_740c24af54388791 = 0;

  while(istrue(self.var_28c033c3c5b37f1f)) {
    if(self.var_740c24af54388791 > 0) {
      self.var_740c24af54388791--;
    }

    if(self.var_740c24af54388791 <= 0) {
      self.var_740c24af54388791 = 4;

      if(self.armorhealth < self.maxarmorhealth) {
        var_1df09d4f31ef52f1 = function_ac266fc218266d08();
        var_1df09d4f31ef52f1 += int(self.maxarmorhealth / 3);
        setarmorhealth(var_1df09d4f31ef52f1);
        self playsoundevent("sndevent_golden_armor_restore");
      }
    }

    wait 1;
  }
}

function function_c71dfd42d05c80b1(damage, eattacker, smeansofdeath) {
  if(damage > 0) {
    self.var_740c24af54388791 = 4;
  }

  if(isPlayer(self)) {
    return damage;
  }

  if(isDefined(self.armorhealth)) {
    return min(self.armorhealth, damage);
  }
}

function function_1260ae7112d01f9c(damage, eattacker, smeansofdeath) {
  if(istrue(self.var_28c033c3c5b37f1f) && isDefined(smeansofdeath)) {
    if(smeansofdeath == "MOD_EXPLOSIVE") {
      damage *= 0.5;
    } else if(smeansofdeath == "MOD_FIRE") {
      damage *= 0.5;
    } else if(smeansofdeath == "MOD_RADIATION") {
      damage *= 0.5;
    }
  }

  aitype = "none";

  if(isDefined(eattacker) && isDefined(eattacker.type)) {
    aitype = eattacker.type;
  }

  if(isDefined(aitype) && aitype == "zombie") {
    damage *= 0.5;
  }

  return damage;
}

function function_e54948c0841f1fd5() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_b23a59dfb4ca49a1("<dev string:x29>", "<dev string:x3b>", &function_b24d8b90edce1cf8, 0);
  function_b23a59dfb4ca49a1("<dev string:x4e>", "<dev string:x60>", &function_b24d8b90edce1cf8, 0);
  function_b23a59dfb4ca49a1("<dev string:x73>", "<dev string:x85>", &function_b24d8b90edce1cf8, 0);
  function_a9a864379a098ad6("<dev string:x98>", "<dev string:xad>", &function_1e66cdd3c32a9cd9);
  function_fe953f000498048f();
}

function function_1e66cdd3c32a9cd9() {
  foreach(player in level.players) {
    player set_golden_armor();
  }
}

function function_b24d8b90edce1cf8(params) {
  armor_level = int(params[0]);

  foreach(player in level.players) {
    player function_f9dabaa1b39d496c(armor_level);
  }
}

function function_f9dabaa1b39d496c(platecarrierlevel) {
  self.platecarrierlevel = platecarrierlevel;
  self.maxarmorhealth = platecarrierlevel * level.var_4b78859bacc88808;
  setarmorhealth(platecarrierlevel * level.var_4b78859bacc88808);
}

# /