/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\hometown\goliath_stealth.gsc
********************************************************/

function goliath_has_lost_enemy() {
  var0 = 10000;
  var1 = 576;
  var2 = 8000;
  var3 = gettime();
  var4 = self.enemy;

  if(isDefined(var4) && issentient(var4) && isalive(var4)) {
    if(var4.team != "allies") {
      return false;
    }

    var5 = self lastknowntime(var4);

    if(var3 < var5 + var0) {
      return false;
    }

    var6 = self lastknownpos(var4);

    if(var5 > 0 && distancesquared(var4.origin, var6) < var1 && self cansee(var4) && self canshootenemy()) {
      return false;
    }

    if(isDefined(self.benemyinlowcover)) {
      return false;
    }
  }

  return true;
}

function goliath_setup_stealth() {
  if(!isDefined(self.stealth.funcs)) {
    self.stealth.funcs = [];
  }

  self.stealth.funcs["has_lost_enemy"] = &goliath_has_lost_enemy;
}