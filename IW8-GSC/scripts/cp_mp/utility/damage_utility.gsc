/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\damage_utility.gsc
****************************************************/

function adddamagemodifier(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(var2) {
    if(!isDefined(self.additivedamagemodifiers)) {
      self.additivedamagemodifiers = [];
    }

    self.additivedamagemodifiers[var0] = var1;

    if(isDefined(var3)) {
      if(!isDefined(self.additivedamagemodifierignorefuncs)) {
        self.additivedamagemodifierignorefuncs = [];
      }

      self.additivedamagemodifierignorefuncs[var0] = var3;
      return;
    }

    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    self.multiplicativedamagemodifiers = [];
  }

  self.multiplicativedamagemodifiers[var0] = var1;

  if(isDefined(var3)) {
    if(!isDefined(self.multiplicativedamagemodifierignorefuncs)) {
      self.multiplicativedamagemodifierignorefuncs = [];
    }

    self.multiplicativedamagemodifierignorefuncs[var0] = var3;
    return;
  }
}

function removedamagemodifier(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(var1) {
    if(!isDefined(self.additivedamagemodifiers)) {
      return;
    }

    self.additivedamagemodifiers[var0] = undefined;

    if(!isDefined(self.additivedamagemodifierignorefuncs)) {
      return;
    }

    self.additivedamagemodifierignorefuncs[var0] = undefined;
    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    return;
  }

  self.multiplicativedamagemodifiers[var0] = undefined;

  if(!isDefined(self.multiplicativedamagemodifierignorefuncs)) {
    return;
  }

  self.multiplicativedamagemodifierignorefuncs[var0] = undefined;
}

function getdamagemodifiertotal(var0, var1, var2, var3, var4, var5, var6) {
  var7 = 1;

  if(isDefined(self.additivedamagemodifiers)) {
    foreach(var11, var9 in self.additivedamagemodifiers) {
      var10 = 0;

      if(isDefined(self.additivedamagemodifierignorefuncs) && isDefined(self.additivedamagemodifierignorefuncs[var11])) {
        var10 = [[self.additivedamagemodifierignorefuncs[var11]]](var0, var1, var2, var3, var4, var5, var6);
      }

      if(!var10) {
        var7 += var9 - 1;
      }
    }
  }

  var12 = 1;

  if(isDefined(self.multiplicativedamagemodifiers)) {
    foreach(var9 in self.multiplicativedamagemodifiers) {
      var10 = 0;

      if(isDefined(self.multiplicativedamagemodifierignorefuncs) && isDefined(self.multiplicativedamagemodifierignorefuncs[var11])) {
        var10 = [[self.multiplicativedamagemodifierignorefuncs[var11]]](var0, var1, var2, var3, var4, var5, var6);
      }

      if(!var10) {
        var12 *= var9;
      }
    }
  }

  return var7 * var12;
}

function cleardamagemodifiers() {
  self.additivedamagemodifiers = [];
  self.multiplicativedamagemodifiers = [];
  self.additivedamagemodifierignorefuncs = [];
  self.multiplicativedamagemodifierignorefuncs = [];
}

function packdamagedata(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  var13 = spawnStruct();
  var13.attacker = var0;
  var13.victim = var1;
  var13.damage = var2;
  var13.objweapon = var3;
  var13.meansofdeath = var4;
  var13.inflictor = var5;
  var13.point = var6;
  var13.direction_vec = var7;
  var13.modelname = var8;
  var13.partname = var9;
  var13.tagname = var10;
  var13.idflags = var11;
  var13.damageflags = var11;
  var13.eventid = var12;

  if(isDefined(var13.attacker)) {
    var13.attacker.assistedsuicide = 0;
  }

  return var13;
}

function isstuckdamage(var0, var1) {
  if(istrue(self.playerplunderbankcallback)) {
    return true;
  }

  if(isDefined(self.stuckbygrenade)) {
    if(isDefined(var0.inflictor) && var0.inflictor == self.stuckbygrenade) {
      if(istrue(var1)) {
        return true;
      } else if(isexplosivedamagemod(var0.meansofdeath) || var0.meansofdeath == "MOD_FIRE") {
        return true;
      }
    }
  }

  return false;
}

function isstuckdamagekill(var0) {
  if(istrue(self.nostuckdamagekill)) {
    return false;
  }

  if(!isstuckdamage(var0, 0)) {
    return false;
  }

  switch (var0.objweapon.basename) {
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