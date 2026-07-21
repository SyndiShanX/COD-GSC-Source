/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\damage_utility.gsc
***********************************************/

adddamagemodifier(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2) {
    if(!isDefined(self.additivedamagemodifiers))
      self.additivedamagemodifiers = [];

    self.additivedamagemodifiers[var_0] = var_1;

    if(isDefined(var_3)) {
      if(!isDefined(self.additivedamagemodifierignorefuncs))
        self.additivedamagemodifierignorefuncs = [];

      self.additivedamagemodifierignorefuncs[var_0] = var_3;
    }
  } else {
    if(!isDefined(self.multiplicativedamagemodifiers))
      self.multiplicativedamagemodifiers = [];

    self.multiplicativedamagemodifiers[var_0] = var_1;

    if(isDefined(var_3)) {
      if(!isDefined(self.multiplicativedamagemodifierignorefuncs))
        self.multiplicativedamagemodifierignorefuncs = [];

      self.multiplicativedamagemodifierignorefuncs[var_0] = var_3;
    }
  }
}

removedamagemodifier(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1) {
    if(!isDefined(self.additivedamagemodifiers)) {
      return;
    }
    self.additivedamagemodifiers[var_0] = undefined;

    if(!isDefined(self.additivedamagemodifierignorefuncs)) {
      return;
    }
    self.additivedamagemodifierignorefuncs[var_0] = undefined;
  } else {
    if(!isDefined(self.multiplicativedamagemodifiers)) {
      return;
    }
    self.multiplicativedamagemodifiers[var_0] = undefined;

    if(!isDefined(self.multiplicativedamagemodifierignorefuncs)) {
      return;
    }
    self.multiplicativedamagemodifierignorefuncs[var_0] = undefined;
  }
}

getdamagemodifiertotal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 1.0;

  if(isDefined(self.additivedamagemodifiers)) {
    foreach(var_11, var_9 in self.additivedamagemodifiers) {
      var_10 = 0;

      if(isDefined(self.additivedamagemodifierignorefuncs) && isDefined(self.additivedamagemodifierignorefuncs[var_11]))
        var_10 = [[self.additivedamagemodifierignorefuncs[var_11]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);

      if(!var_10)
        var_7 = var_7 + (var_9 - 1.0);
    }
  }

  var_12 = 1.0;

  if(isDefined(self.multiplicativedamagemodifiers)) {
    foreach(var_11, var_9 in self.multiplicativedamagemodifiers) {
      var_10 = 0;

      if(isDefined(self.multiplicativedamagemodifierignorefuncs) && isDefined(self.multiplicativedamagemodifierignorefuncs[var_11]))
        var_10 = [[self.multiplicativedamagemodifierignorefuncs[var_11]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);

      if(!var_10)
        var_12 = var_12 * var_9;
    }
  }

  return var_7 * var_12;
}

cleardamagemodifiers() {
  self.additivedamagemodifiers = [];
  self.multiplicativedamagemodifiers = [];
  self.additivedamagemodifierignorefuncs = [];
  self.multiplicativedamagemodifierignorefuncs = [];
}

packdamagedata(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
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

  if(isDefined(var_13.attacker))
    var_13.attacker.assistedsuicide = 0;

  return var_13;
}

isstuckdamage(var_0, var_1) {
  if(istrue(self.playerplunderbankcallback))
    return 1;

  if(isDefined(self.stuckbygrenade)) {
    if(isDefined(var_0.inflictor) && var_0.inflictor == self.stuckbygrenade) {
      if(istrue(var_1))
        return 1;
      else if(isexplosivedamagemod(var_0.meansofdeath) || var_0.meansofdeath == "_encstr_9B0D099AD3887D91252954")
        return 1;
    }
  }

  return 0;
}

isstuckdamagekill(var_0) {
  if(istrue(self.nostuckdamagekill))
    return 0;

  if(!isstuckdamage(var_0, 0))
    return 0;

  switch (var_0.objweapon.basename) {
    case "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1":
    case "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898":
    case "_encstr_99410C4B48C39AB7D0CD95B769DB":
    case "_encstr_BA730BF8AFF178988293F158B9":
      return 0;
    default:
      break;
  }

  return 1;
}

playerplunderbankcallback() {
  self.playerplunderbankcallback = 1;
}

playerplunderbankdeposit() {
  self.playerplunderbankcallback = undefined;
}