/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\lightarmor.gsc
*************************************/

haslightarmor(param_00) {
  return getlightarmorvalue(param_00) > 0;
}

getlightarmorvalue(param_00) {
  if(isDefined(param_00.lightarmorhp)) {
    return param_00.lightarmorhp;
  }

  return 0;
}

setlightarmorvalue(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  if(lightarmor_lightarmor_disabled(param_00)) {
    param_01 = 0;
    param_02 = 1;
  }

  var_04 = getlightarmorvalue(param_00);
  if(!param_02 && var_04 > param_01) {
    param_01 = var_04;
  }

  if(var_04 <= 0 && param_01 > 0) {
    lightarmor_set(param_00, param_01, param_03);
    return;
  }

  if(var_04 > 0 && param_01 <= 0) {
    lightarmor_unset(param_00);
    return;
  }

  param_00.lightarmorhp = param_01;
  if(isplayer(param_00) && var_04 <= param_01 && param_01 > 0 && param_03 == 1) {
    thread lightarmor_setfx(param_00);
  }

  if(isplayer(param_00)) {
    lightarmor_updatehud(param_00);
  }
}

init() {
  level._effect["lightArmor_persistent"] = loadfx("vfx\core\mp\core\vfx_uplink_carrier.vfx");
}

lightarmor_set(param_00, param_01, param_02) {
  param_00 notify("lightArmor_set");
  param_00.lightarmorhp = param_01;
  lightarmor_updatehud(param_00);
  thread lightarmor_monitordeath(param_00);
  if(isplayer(param_00) && param_02 == 1) {
    thread lightarmor_setfx(param_00);
  }
}

lightarmor_unset(param_00) {
  param_00 notify("lightArmor_unset");
  param_00.lightarmorhp = undefined;
  lightarmor_updatehud(param_00);
  if(isplayer(param_00)) {
    param_00 setscriptablepartstate("light_armor", "neutral", 0);
  }

  param_00 notify("remove_light_armor");
}

lightarmor_modifydamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = 0;
  var_0C = 0;
  var_0D = param_00.lightarmorhp;
  if(!isDefined(param_0A)) {
    param_0A = 1;
  }

  if(!var_0B) {
    if(param_04 == "MOD_FALLING" || param_04 == "MOD_MELEE") {
      var_0B = 1;
    }
  }

  if(!var_0B) {
    if(scripts\engine\utility::isbulletdamage(param_04) && scripts\mp\utility::isheadshot(param_05, param_08, param_04, param_01)) {
      var_0B = 1;
    }
  }

  if(!var_0B) {
    if(param_04 == "MOD_IMPACT") {
      if(scripts\mp\weapons::func_9FA9(param_05) || scripts\mp\weapons::isaxeweapon(param_05)) {
        var_0B = 1;
      }
    }
  }

  if(!var_0B) {
    if(isexplosivedamagemod(param_04)) {
      if(isDefined(param_09) && isDefined(param_09.stuckenemyentity) && param_09.stuckenemyentity == param_00) {
        var_0B = 1;
      }
    }
  }

  if(!var_0B) {
    if(scripts\mp\utility::issuperdamagesource(param_05)) {
      var_0B = 1;
    }
  }

  if(!var_0B) {
    var_0C = min(param_02 + param_03, param_00.lightarmorhp);
    var_0D = var_0D - param_02 + param_03;
    if(!param_0A) {
      param_00.lightarmorhp = param_00.lightarmorhp - param_02 + param_03;
    }

    param_02 = 0;
    param_03 = 0;
    if(var_0D <= 0) {
      param_02 = abs(var_0D);
      param_03 = 0;
      if(!param_0A) {
        lightarmor_unset(param_00);
      }
    }
  }

  if(!param_0A) {
    lightarmor_updatehud(self);
  }

  if(var_0C > 0 && param_02 == 0) {
    param_02 = 1;
  }

  return [var_0C, param_02, param_03];
}

lightarmor_lightarmor_disabled(param_00) {
  if(param_00 scripts\mp\heavyarmor::hasheavyarmor()) {
    return 1;
  }

  return 0;
}

lightarmor_monitordeath(param_00) {
  param_00 endon("disconnect");
  param_00 endon("lightArmor_set");
  param_00 endon("lightArmor_unset");
  param_00 waittill("death");
  thread lightarmor_unset(param_00);
}

lightarmor_updatehud(param_00) {
  if(!isplayer(param_00)) {
    return;
  }

  if(isDefined(level.carrierarmor)) {
    param_00 setclientomnvar("ui_uplink_carrier_armor", int(getlightarmorvalue(param_00)));
  }
}

lightarmor_setfx(param_00) {
  param_00 setscriptablepartstate("light_armor", "active", 0);
}