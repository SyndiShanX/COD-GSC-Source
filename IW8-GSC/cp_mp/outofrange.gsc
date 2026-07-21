/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\outofrange.gsc
***********************************************/

setupoutofrangewatcher(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.owner setclientomnvar("_encstr_9B9110AE2DF57BABD1F5DE997DC90BCDECB2", 0);

  if(!isDefined(var_1))
    var_1 = var_0.origin;

  if(!isDefined(var_4))
    var_4 = 4000000;

  if(!isDefined(var_5))
    var_5 = 16000000;

  if(isDefined(var_2))
    var_0 thread watchdistancefromentity(var_2, var_3, var_4, var_5);
  else
    var_0 thread watchdistancefromstaticpoint(var_1, var_4, var_5);
}

watchdistancefromentity(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_1))
    var_1 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";

  for(;;) {
    if(!isDefined(var_0)) {
      self.owner setclientomnvar("_encstr_9B9110AE2DF57BABD1F5DE997DC90BCDECB2", 0);
      return;
    }

    var_4 = var_0 gettagorigin(var_1);
    var_5 = distancesquared(self.origin, var_4);

    if(scripts\common\utility::iscp()) {
      var_6 = var_5 / var_3;

      if(var_6 <= 1)
        self.owner setclientomnvar("_encstr_A2BB16BAD2AFB7AE1DD7DBCCAF2785CDB359EBB6568E2B93", sqrt(var_6));
    }

    if(var_5 >= var_2)
      watchoutofrangestrength(var_4, var_2, var_3, var_0, var_1);

    waitframe();
  }
}

watchdistancefromstaticpoint(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_3 = distancesquared(self.origin, var_0);

    if(scripts\common\utility::iscp()) {
      var_4 = var_3 / var_2;

      if(var_4 <= 1)
        self.owner setclientomnvar("_encstr_A2BB16BAD2AFB7AE1DD7DBCCAF2785CDB359EBB6568E2B93", sqrt(var_4));
    }

    if(var_3 >= var_1)
      watchoutofrangestrength(var_0, var_1, var_2);

    waitframe();
  }
}

watchoutofrangestrength(var_0, var_1, var_2, var_3, var_4) {
  for(;;) {
    if(isDefined(var_3))
      var_0 = var_3 gettagorigin(var_4);

    var_5 = distancesquared(self.origin, var_0);
    var_6 = var_5 / var_2;
    self.owner setclientomnvar("_encstr_9B9110AE2DF57BABD1F5DE997DC90BCDECB2", var_6);

    if(scripts\common\utility::iscp())
      self.owner setclientomnvar("_encstr_A2BB16BAD2AFB7AE1DD7DBCCAF2785CDB359EBB6568E2B93", sqrt(var_6));

    if(isDefined(self.owner.outofrangefunc))
      self.owner thread[[self.owner.outofrangefunc]](self.owner);

    if(var_5 >= var_2) {
      var_7 = getcompleteweaponname("_encstr_A29408E6D5D6CAAF5B1C");
      var_8 = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
      self.owner setclientomnvar("_encstr_9B9110AE2DF57BABD1F5DE997DC90BCDECB2", 0);
      self dodamage(10000, self.origin, self.owner, self.owner, var_8, var_7);
      break;
    } else if(var_5 < var_1) {
      self.owner setclientomnvar("_encstr_9B9110AE2DF57BABD1F5DE997DC90BCDECB2", 0);
      break;
    }

    waitframe();
  }
}