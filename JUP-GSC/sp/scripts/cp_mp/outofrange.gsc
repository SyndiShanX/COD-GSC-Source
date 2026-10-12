/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\outofrange.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\engine\utility;
#namespace outofrange;

function setupoutofrangewatcher(var_616ea41542b3d45a, var_96408b0d60660b1, var_363c1035ed04723a, var_d9ffca69374e542, minrangesq, maxrangesq, inverserange) {
  assertex(isDefined(self.owner), "setupOutofRangeWatcher(): There is no valid owner for this ent");
  self.owner setclientomnvar("ui_out_of_range", 0);

  if(isDefined(inverserange) && inverserange == 1) {
    assertex(isDefined(var_96408b0d60660b1) || isDefined(var_363c1035ed04723a), "A tether point or tether ent must be defined");
  } else if(!isDefined(var_96408b0d60660b1)) {
    var_96408b0d60660b1 = var_616ea41542b3d45a.origin;
  }

  if(!isDefined(minrangesq)) {
    minrangesq = 4000000;
  }

  if(!isDefined(maxrangesq)) {
    maxrangesq = 16000000;
  }

  if(isDefined(var_363c1035ed04723a)) {
    var_616ea41542b3d45a thread watchdistancefromentity(var_363c1035ed04723a, var_d9ffca69374e542, minrangesq, maxrangesq, inverserange);
    return;
  }

  var_616ea41542b3d45a thread watchdistancefromstaticpoint(var_96408b0d60660b1, minrangesq, maxrangesq, inverserange);
}

function watchdistancefromentity(var_363c1035ed04723a, var_d9ffca69374e542, minrangesq, maxrangesq, inverserange) {
  self endon("death");
  inverted = isDefined(inverserange) && inverserange == 1;

  if(!isDefined(var_d9ffca69374e542)) {
    var_d9ffca69374e542 = "tag_origin";
  }

  while(true) {
    if(!isDefined(var_363c1035ed04723a)) {
      self.owner setclientomnvar("ui_out_of_range", 0);
      return;
    }

    var_96408b0d60660b1 = var_363c1035ed04723a gettagorigin(var_d9ffca69374e542);
    distancefrom = distancesquared(self.origin, var_96408b0d60660b1);

    if(utility::iscp() && !inverted) {
      distancefrac = distancefrom / maxrangesq;

      if(distancefrac <= 1) {
        self.owner setclientomnvar("ui_out_of_range_meter", sqrt(distancefrac));
      }
    }

    if(distancefrom >= minrangesq && !inverted || distancefrom <= maxrangesq && inverted) {
      watchoutofrangestrength(var_96408b0d60660b1, minrangesq, maxrangesq, var_363c1035ed04723a, var_d9ffca69374e542, inverserange);
    }

    waitframe();
  }
}

function watchdistancefromstaticpoint(var_96408b0d60660b1, minrangesq, maxrangesq, inverserange) {
  self endon("death");
  inverted = isDefined(inverserange) && inverserange == 1;

  while(true) {
    distancefrom = distancesquared(self.origin, var_96408b0d60660b1);

    if(utility::iscp() && !inverted) {
      distancefrac = distancefrom / maxrangesq;

      if(distancefrac <= 1) {
        self.owner setclientomnvar("ui_out_of_range_meter", sqrt(distancefrac));
      }
    }

    if(distancefrom >= minrangesq && !inverted || distancefrom <= maxrangesq && inverted) {
      watchoutofrangestrength(var_96408b0d60660b1, minrangesq, maxrangesq, inverserange);
    }

    waitframe();
  }
}

function watchoutofrangestrength(var_96408b0d60660b1, minrangesq, maxrangesq, var_363c1035ed04723a, var_d9ffca69374e542, inverserange) {
  inverted = isDefined(inverserange) && inverserange == 1;

  while(true) {
    if(isDefined(var_363c1035ed04723a)) {
      var_96408b0d60660b1 = var_363c1035ed04723a gettagorigin(var_d9ffca69374e542);
    }

    currentdistancevalue = distancesquared(self.origin, var_96408b0d60660b1);

    if(!inverted) {
      signalscale = currentdistancevalue / maxrangesq;
    } else if(currentdistancevalue == 0) {
      signalscale = minrangesq;
    } else {
      signalscale = minrangesq / currentdistancevalue;
    }

    assertex(isDefined(self.owner), "watchOutOfRangeStrength(): Owner is not defined for the our of range ent");
    self.owner setclientomnvar("ui_out_of_range", signalscale);

    if(utility::iscp() && !inverted) {
      self.owner setclientomnvar("ui_out_of_range_meter", sqrt(signalscale));
    }

    if(isDefined(self.owner.outofrangefunc) && !inverted) {
      self.owner thread[[self.owner.outofrangefunc]](self.owner);
    }

    if(currentdistancevalue >= maxrangesq && !inverted || currentdistancevalue <= minrangesq && inverted) {
      weapon = makeweapon("nuke_multi_mp");
      meansofdeath = "MOD_EXPLOSIVE";
      self.owner setclientomnvar("ui_out_of_range", 0);
      self dodamage(10000, self.origin, self.owner, self.owner, meansofdeath, weapon);
      break;
    } else if(currentdistancevalue < minrangesq && !inverted || currentdistancevalue > minrangesq && inverted) {
      self.owner setclientomnvar("ui_out_of_range", 0);
      break;
    }

    waitframe();
  }
}