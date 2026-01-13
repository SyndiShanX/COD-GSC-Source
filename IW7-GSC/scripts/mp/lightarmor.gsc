/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\lightarmor.gsc
*********************************************/

haslightarmor(var_0) {
  return getlightarmorvalue(var_0) > 0;
}

getlightarmorvalue(var_0) {
  if(isDefined(var_0.lightarmorhp)) {
    return var_0.lightarmorhp;
  }

  return 0;
}

setlightarmorvalue(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(lightarmor_lightarmor_disabled(var_0)) {
    var_1 = 0;
    var_2 = 1;
  }

  var_4 = getlightarmorvalue(var_0);
  if(!var_2 && var_4 > var_1) {
    var_1 = var_4;
  }

  if(var_4 <= 0 && var_1 > 0) {
    lightarmor_set(var_0, var_1, var_3);
    return;
  }

  if(var_4 > 0 && var_1 <= 0) {
    lightarmor_unset(var_0);
    return;
  }

  var_0.lightarmorhp = var_1;
  if(isplayer(var_0) && var_4 <= var_1 && var_1 > 0 && var_3 == 1) {
    thread lightarmor_setfx(var_0);
  }

  if(isplayer(var_0)) {
    lightarmor_updatehud(var_0);
  }
}

init() {
  level._effect["lightArmor_persistent"] = loadfx("vfx\core\mp\core\vfx_uplink_carrier.vfx");
}

lightarmor_set(var_0, var_1, var_2) {
  var_0 notify("lightArmor_set");
  var_0.lightarmorhp = var_1;
  lightarmor_updatehud(var_0);
  thread lightarmor_monitordeath(var_0);
  if(isplayer(var_0) && var_2 == 1) {
    thread lightarmor_setfx(var_0);
  }
}

lightarmor_unset(var_0) {
  var_0 notify("lightArmor_unset");
  var_0.lightarmorhp = undefined;
  lightarmor_updatehud(var_0);
  if(isplayer(var_0)) {
    var_0 setscriptablepartstate("light_armor", "neutral", 0);
  }

  var_0 notify("remove_light_armor");
}

lightarmor_modifydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  var_0B = 0;
  var_0C = 0;
  var_0D = var_0.lightarmorhp;
  if(!isDefined(var_0A)) {
    var_0A = 1;
  }

  if(!var_0B) {
    if(var_4 == "MOD_FALLING" || var_4 == "MOD_MELEE") {
      var_0B = 1;
    }
  }

  if(!var_0B) {
    if(scripts\engine\utility::isbulletdamage(var_4) && scripts\mp\utility::isheadshot(var_5, var_8, var_4, var_1)) {
      var_0B = 1;
    }
  }

  if(!var_0B) {
    if(var_4 == "MOD_IMPACT") {
      if(scripts\mp\weapons::func_9FA9(var_5) || scripts\mp\weapons::isaxeweapon(var_5)) {
        var_0B = 1;
      }
    }
  }

  if(!var_0B) {
    if(isexplosivedamagemod(var_4)) {
      if(isDefined(var_9) && isDefined(var_9.stuckenemyentity) && var_9.stuckenemyentity == var_0) {
        var_0B = 1;
      }
    }
  }

  if(!var_0B) {
    if(scripts\mp\utility::issuperdamagesource(var_5)) {
      var_0B = 1;
    }
  }

  if(!var_0B) {
    var_0C = min(var_2 + var_3, var_0.lightarmorhp);
    var_0D = var_0D - var_2 + var_3;
    if(!var_0A) {
      var_0.lightarmorhp = var_0.lightarmorhp - var_2 + var_3;
    }

    var_2 = 0;
    var_3 = 0;
    if(var_0D <= 0) {
      var_2 = abs(var_0D);
      var_3 = 0;
      if(!var_0A) {
        lightarmor_unset(var_0);
      }
    }
  }

  if(!var_0A) {
    lightarmor_updatehud(self);
  }

  if(var_0C > 0 && var_2 == 0) {
    var_2 = 1;
  }

  return [var_0C, var_2, var_3];
}

lightarmor_lightarmor_disabled(var_0) {
  if(var_0 scripts\mp\heavyarmor::hasheavyarmor()) {
    return 1;
  }

  return 0;
}

lightarmor_monitordeath(var_0) {
  var_0 endon("disconnect");
  var_0 endon("lightArmor_set");
  var_0 endon("lightArmor_unset");
  var_0 waittill("death");
  thread lightarmor_unset(var_0);
}

lightarmor_updatehud(var_0) {
  if(!isplayer(var_0)) {
    return;
  }

  if(isDefined(level.carrierarmor)) {
    var_0 setclientomnvar("ui_uplink_carrier_armor", int(getlightarmorvalue(var_0)));
  }
}

lightarmor_setfx(var_0) {
  var_0 setscriptablepartstate("light_armor", "active", 0);
}