/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\outofrange.gsc
***********************************************/

function setupoutofrangewatcher(var0, var1, var2, var3, var4, var5) {
  self.owner setclientomnvar("ui_out_of_range", 0);

  if(!isDefined(var1)) {
    var1 = var0.origin;
  }

  if(!isDefined(var4)) {
    var4 = 4000000;
  }

  if(!isDefined(var5)) {
    var5 = 16000000;
  }

  if(isDefined(var2)) {
    thread watchdistancefromentity(var0, var2, var3, var4);
    return;
  }

  thread watchdistancefromstaticpoint(var0, var1, var4);
}

function watchdistancefromentity(var0, var1, var2, var3) {
  self endon("death");
  jumpiftrue(isDefined(var1)) LOC_00000019;
  var1 = "tag_origin";

  for(;;) {
    if(!isDefined(var0)) {
      self.owner setclientomnvar("ui_out_of_range", 0);
      return;
    }

    var4 = var0 gettagorigin(var1);
    var5 = distancesquared(self.origin, var4);

    if(scripts\common\utility::iscp()) {
      var6 = var5 / var3;

      if(var6 <= 1) {
        self.owner setclientomnvar("ui_out_of_range_meter", sqrt(var6));
      }
    }

    if(var5 >= var2) {
      watchoutofrangestrength(var4, var2, var3, var0, var1);
    }

    waitframe();
  }
}

function watchdistancefromstaticpoint(var0, var1, var2) {
  self endon("death");

  for(;;) {
    var3 = distancesquared(self.origin, var0);

    if(scripts\common\utility::iscp()) {
      var4 = var3 / var2;

      if(var4 <= 1) {
        self.owner setclientomnvar("ui_out_of_range_meter", sqrt(var4));
      }
    }

    if(var3 >= var1) {
      watchoutofrangestrength(var0, var1, var2);
    }

    waitframe();
  }
}

function watchoutofrangestrength(var0, var1, var2, var3, var4) {
  for(;;) {
    if(isDefined(var3)) {
      var0 = var3 gettagorigin(var4);
    }

    var5 = distancesquared(self.origin, var0);
    var6 = var5 / var2;
    self.owner setclientomnvar("ui_out_of_range", var6);

    if(scripts\common\utility::iscp()) {
      self.owner setclientomnvar("ui_out_of_range_meter", sqrt(var6));
    }

    if(isDefined(self.owner.outofrangefunc)) {
      self.owner thread[[self.owner.outofrangefunc]](self.owner);
    }

    if(var5 >= var2) {
      var7 = getcompleteweaponname("nuke_mp");
      var8 = "MOD_EXPLOSIVE";
      self.owner setclientomnvar("ui_out_of_range", 0);
      self dodamage(10000, self.origin, self.owner, self.owner, var8, var7);
      break;
    } else if(var5 < var1) {
      self.owner setclientomnvar("ui_out_of_range", 0);
      break;
    }

    waitframe();
  }
}