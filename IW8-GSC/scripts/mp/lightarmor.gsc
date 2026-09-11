/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\lightarmor.gsc
***********************************************/

function haslightarmor(var0) {
  return getlightarmorvalue(var0) > 0;
}

function getlightarmorvalue(var0) {
  if(isDefined(var0.lightarmorhp)) {
    return var0.lightarmorhp;
  }

  return 0;
}

function setlightarmorvalue(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(lightarmor_lightarmor_disabled(var0)) {
    var1 = 0;
    var2 = 1;
  }

  var4 = getlightarmorvalue(var0);

  if(!var2 && var4 > var1) {
    var1 = var4;
  }

  if(var4 <= 0 && var1 > 0) {
    lightarmor_set(var0, var1, var3);
    return;
  }

  if(var4 > 0 && var1 <= 0) {
    lightarmor_unset(var0);
    return;
  }

  var0.lightarmorhp = var1;

  if(isPlayer(var0) && var4 <= var1 && var1 > 0 && var3 == 1) {
    thread lightarmor_setfx(var0);
  }

  if(isPlayer(var0)) {
    lightarmor_updatehud(var0);
    return;
  }
}

function init() {
  level._effect["lightArmor_persistent"] = loadfx("vfx/core/mp/core/vfx_uplink_carrier.vfx");
}

function lightarmor_set(var0, var1, var2) {
  var0 notify("lightArmor_set");
  var0.lightarmorhp = var1;
  lightarmor_updatehud(var0);
  thread lightarmor_monitordeath(var0);

  if(isPlayer(var0) && var2 == 1) {
    thread lightarmor_setfx(var0);
    return;
  }
}

function lightarmor_unset(var0) {
  var0 notify("lightArmor_unset");
  var0.lightarmorhp = undefined;
  lightarmor_updatehud(var0);

  if(isPlayer(var0)) {}

  var0 notify("remove_light_armor");
}

function lightarmor_modifydamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var11 = 0;
  var12 = 0;
  var13 = var0.lightarmorhp;

  if(!isDefined(var10)) {
    var10 = 1;
  }

  if(!var11) {
    if(var4 == "MOD_FALLING") {
      var11 = 1;
    }
  }

  if(!var11) {
    if(isexplosivedamagemod(var4)) {
      if(isDefined(var9) && isDefined(var9.stuckenemyentity) && var9.stuckenemyentity == var0) {
        var11 = 1;
      }
    }
  }

  if(!var11) {
    if(scripts\mp\utility\weapon::issuperdamagesource(var5)) {
      var11 = 1;
    }
  }

  if(!var11) {
    var12 = min(var2 + var3, var0.lightarmorhp);
    var13 -= var2 + var3;

    if(!var10) {
      var0.lightarmorhp -= var2 + var3;
    }

    var2 = 0;
    var3 = 0;

    if(var13 <= 0) {
      var2 = abs(var13);
      var3 = 0;

      if(!var10) {
        lightarmor_unset(var0);
      }
    }
  }

  if(!var10) {
    lightarmor_updatehud(self);
  }

  if(var12 > 0 && var2 == 0) {
    var2 = 1;
  }

  return [var12, var2, var3];
}

function lightarmor_lightarmor_disabled(var0) {
  if(var0 scripts\mp\heavyarmor::hasheavyarmor()) {
    return true;
  }

  return false;
}

function lightarmor_monitordeath(var0) {
  var0 endon("disconnect");
  var0 endon("lightArmor_set");
  var0 endon("lightArmor_unset");
  var0 waittill("death");
  thread lightarmor_unset(var0);
}

function lightarmor_updatehud(var0) {
  if(!isPlayer(var0)) {
    return;
  }
}

function lightarmor_setfx(var0) {}