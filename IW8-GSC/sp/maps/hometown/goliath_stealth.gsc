/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\hometown\goliath_stealth.gsc
************************************************/

goliath_has_lost_enemy() {
  var_0 = 10000;
  var_1 = 576;
  var_2 = 8000;
  var_3 = gettime();
  var_4 = self.enemy;

  if(isDefined(var_4) && issentient(var_4) && isalive(var_4)) {
    if(var_4.team != "allies")
      return 0;

    var_5 = self lastknowntime(var_4);

    if(var_3 < var_5 + var_0)
      return 0;

    var_6 = self lastknownpos(var_4);

    if(var_5 > 0 && distancesquared(var_4.origin, var_6) < var_1 && self cansee(var_4) && self canshootenemy())
      return 0;

    if(isDefined(self.benemyinlowcover))
      return 0;
  }

  return 1;
}

goliath_setup_stealth() {
  if(!isDefined(self.stealth.funcs))
    self.stealth.funcs = [];

  self.stealth.funcs["has_lost_enemy"] = ::goliath_has_lost_enemy;
}