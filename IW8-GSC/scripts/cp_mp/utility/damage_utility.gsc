/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\damage_utility.gsc
****************************************************/

function adddamagemodifier(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    if(!isDefined(self.additivedamagemodifiers)) {
      self.additivedamagemodifiers = [];
    }

    self.additivedamagemodifiers[var_0] = var_1;

    if(isDefined(var_3)) {
      if(!isDefined(self.additivedamagemodifierignorefuncs)) {
        self.additivedamagemodifierignorefuncs = [];
      }

      self.additivedamagemodifierignorefuncs[var_0] = var_3;
      return;
    }

    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    self.multiplicativedamagemodifiers = [];
  }

  self.multiplicativedamagemodifiers[var_0] = var_1;

  if(isDefined(var_3)) {
    if(!isDefined(self.multiplicativedamagemodifierignorefuncs)) {
      self.multiplicativedamagemodifierignorefuncs = [];
    }

    self.multiplicativedamagemodifierignorefuncs[var_0] = var_3;
    return;
  }
}

function removedamagemodifier(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    if(!isDefined(self.additivedamagemodifiers)) {
      return;
    }

    self.additivedamagemodifiers[var_0] = undefined;

    if(!isDefined(self.additivedamagemodifierignorefuncs)) {
      return;
    }

    self.additivedamagemodifierignorefuncs[var_0] = undefined;
    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    return;
  }

  self.multiplicativedamagemodifiers[var_0] = undefined;

  if(!isDefined(self.multiplicativedamagemodifierignorefuncs)) {
    return;
  }

  self.multiplicativedamagemodifierignorefuncs[var_0] = undefined;
}

function getdamagemodifiertotal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 1;

  if(isDefined(self.additivedamagemodifiers)) {
    foreach(var_11, var_9 in self.additivedamagemodifiers) {
      var_10 = 0;

      if(isDefined(self.additivedamagemodifierignorefuncs) && isDefined(self.additivedamagemodifierignorefuncs[var_11])) {
        var_10 = [[self.additivedamagemodifierignorefuncs[var_11]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
      }

      if(!var_10) {
        var_7 += var_9 - 1;
      }
    }
  }

  var_12 = 1;

  if(isDefined(self.multiplicativedamagemodifiers)) {
    foreach(var_9 in self.multiplicativedamagemodifiers) {
      var_10 = 0;

      if(isDefined(self.multiplicativedamagemodifierignorefuncs) && isDefined(self.multiplicativedamagemodifierignorefuncs[var_11])) {
        var_10 = [[self.multiplicativedamagemodifierignorefuncs[var_11]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
      }

      if(!var_10) {
        var_12 *= var_9;
      }
    }
  }

  return var_7 * var_12;
}

function cleardamagemodifiers() {
  self.additivedamagemodifiers = [];
  self.multiplicativedamagemodifiers = [];
  self.additivedamagemodifierignorefuncs = [];
  self.multiplicativedamagemodifierignorefuncs = [];
}

function packdamagedata(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = spawnStruct();
  var_13.attacker = var_0;
  var_13.victim = var_1;
  var_13.damage = var_2;
  var_13.objweapon = var_3;
  var_13.meansofdeath = var_4;
  var_13.inflictor = var_5;
  var_13.point = var_6;
  var_13.direction_vec = var_7;
  var_13.modelname = var_8;
  var_13.partname = var_9;
  var_13.tagname = var_10;
  var_13.idflags = var_11;
  var_13.damageflags = var_11;
  var_13.eventid = var_12;

  if(isDefined(var_13.attacker)) {
    var_13.attacker.assistedsuicide = 0;
  }

  return var_13;
}

function isstuckdamage(var_0, var_1) {
  if(istrue(self.playerplunderbankcallback)) {
    return true;
  }

  if(isDefined(self.stuckbygrenade)) {
    if(isDefined(var_0.inflictor) && var_0.inflictor == self.stuckbygrenade) {
      if(istrue(var_1)) {
        return true;
      } else if(isexplosivedamagemod(var_0.meansofdeath) || var_0.meansofdeath == "MOD_FIRE") {
        return true;
      }
    }
  }

  return false;
}

function isstuckdamagekill(var_0) {
  if(istrue(self.nostuckdamagekill)) {
    return false;
  }

  if(!isstuckdamage(var_0, 0)) {
    return false;
  }

  switch (var_0.objweapon.basename) {
    case "thermite_ap_mp":
    case "thermite_av_mp":
    case "thermite_mp":
    case "molotov_mp":
      return false;
    default:
      break;
  }

  return true;
}

function playerplunderbankcallback() {
  self.playerplunderbankcallback = 1;
}

function playerplunderbankdeposit() {
  self.playerplunderbankcallback = undefined;
}