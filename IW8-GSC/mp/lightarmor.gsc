/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\lightarmor.gsc
***********************************************/

haslightarmor(var_0) {
  return getlightarmorvalue(var_0) > 0;
}

getlightarmorvalue(var_0) {
  if(isDefined(var_0.lightarmorhp))
    return var_0.lightarmorhp;

  return 0;
}

setlightarmorvalue(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  if(lightarmor_lightarmor_disabled(var_0)) {
    var_1 = 0;
    var_2 = 1;
  }

  var_4 = getlightarmorvalue(var_0);

  if(!var_2 && var_4 > var_1)
    var_1 = var_4;

  if(var_4 <= 0 && var_1 > 0) {
    lightarmor_set(var_0, var_1, var_3);
    return;
  }

  if(var_4 > 0 && var_1 <= 0) {
    lightarmor_unset(var_0);
    return;
  }

  var_0.lightarmorhp = var_1;

  if(isPlayer(var_0) && var_4 <= var_1 && var_1 > 0 && var_3 == 1)
    thread lightarmor_setfx(var_0);

  if(isPlayer(var_0))
    lightarmor_updatehud(var_0);
}

init() {
  level._effect["_encstr_BA2716B1B4D986E850395BF6C9EB83AC396E4B9B1DB273A3"] = loadfx("_encstr_96B428CE330F5EC67B9CB2975BE079C6F69CCA97D9333CEB5D831B4BCD6DAF362C9CE4B4954E71D933C3");
}

lightarmor_set(var_0, var_1, var_2) {
  var_0 notify("_encstr_93140F18020FBB28D6F2A3AF1A89C8F5EB");
  var_0.lightarmorhp = var_1;
  lightarmor_updatehud(var_0);
  thread lightarmor_monitordeath(var_0);

  if(isPlayer(var_0) && var_2 == 1)
    thread lightarmor_setfx(var_0);
}

lightarmor_unset(var_0) {
  var_0 notify("_encstr_A18311B43B8228F35360FFE2EA7E8B6D133553");
  var_0.lightarmorhp = undefined;
  lightarmor_updatehud(var_0);

  if(isPlayer(var_0)) {}

  var_0 notify("_encstr_A2BD1339CAB6B7CE59D71B2DB386D1EBB09CADB727");
}

lightarmor_modifydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = 0;
  var_12 = 0;
  var_13 = var_0.lightarmorhp;

  if(!isDefined(var_10))
    var_10 = 1;

  if(!var_11) {
    if(var_4 == "_encstr_87A10C9D24E997A01F21838F3D34")
      var_11 = 1;
  }

  if(!var_11) {
    if(isexplosivedamagemod(var_4)) {
      if(isDefined(var_9) && isDefined(var_9.stuckenemyentity) && var_9.stuckenemyentity == var_0)
        var_11 = 1;
    }
  }

  if(!var_11) {
    if(scripts\mp\utility\weapon::issuperdamagesource(var_5))
      var_11 = 1;
  }

  if(!var_11) {
    var_12 = min(var_2 + var_3, var_0.lightarmorhp);
    var_13 = var_13 - (var_2 + var_3);

    if(!var_10)
      var_0.lightarmorhp = var_0.lightarmorhp - (var_2 + var_3);

    var_2 = 0;
    var_3 = 0;

    if(var_13 <= 0) {
      var_2 = abs(var_13);
      var_3 = 0;

      if(!var_10)
        lightarmor_unset(var_0);
    }
  }

  if(!var_10)
    lightarmor_updatehud(self);

  if(var_12 > 0 && var_2 == 0)
    var_2 = 1;

  return [var_12, var_2, var_3];
}

lightarmor_lightarmor_disabled(var_0) {
  if(var_0 scripts\mp\heavyarmor::hasheavyarmor())
    return 1;

  return 0;
}

lightarmor_monitordeath(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_93140F18020FBB28D6F2A3AF1A89C8F5EB");
  var_0 endon("_encstr_A18311B43B8228F35360FFE2EA7E8B6D133553");
  var_0 waittill("_encstr_AD75063D571AE108");
  thread lightarmor_unset(var_0);
}

lightarmor_updatehud(var_0) {
  if(!isPlayer(var_0))
    return;
}

lightarmor_setfx(var_0) {}