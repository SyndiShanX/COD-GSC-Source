/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2762.gsc
***************************************/

haslightarmor(var_00) {
  return getlightarmorvalue(var_00) > 0;
}

getlightarmorvalue(var_00) {
  if(isDefined(var_0.lightarmorhp)) {
    return var_0.lightarmorhp;
  }

  return 0;
}

setlightarmorvalue(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_02)) {
    var_02 = 1;
  }

  if(!isDefined(var_03)) {
    var_03 = 1;
  }

  if(lightarmor_lightarmor_disabled(var_00)) {
    var_01 = 0;
    var_02 = 1;
  }

  var_04 = getlightarmorvalue(var_00);

  if(!var_02 && var_04 > var_01) {
    var_01 = var_04;
  }

  if(var_04 <= 0 && var_01 > 0) {
    lightarmor_set(var_00, var_01, var_03);
    return;
  }

  if(var_04 > 0 && var_01 <= 0) {
    lightarmor_unset(var_00);
    return;
  }

  var_0.lightarmorhp = var_01;

  if(isplayer(var_00) && var_04 <= var_01 && var_01 > 0 && var_03 == 1) {
    thread lightarmor_setfx(var_00);
  }

  if(isplayer(var_00)) {
    lightarmor_updatehud(var_00);
  }
}

init() {
  level._effect["lightArmor_persistent"] = loadfx("vfx\core\mp\core\vfx_uplink_carrier.vfx");
}

lightarmor_set(var_00, var_01, var_02) {
  var_00 notify("lightArmor_set");
  var_0.lightarmorhp = var_01;
  lightarmor_updatehud(var_00);
  thread lightarmor_monitordeath(var_00);

  if(isplayer(var_00) && var_02 == 1) {
    thread lightarmor_setfx(var_00);
  }
}

lightarmor_unset(var_00) {
  var_00 notify("lightArmor_unset");
  var_0.lightarmorhp = undefined;
  lightarmor_updatehud(var_00);

  if(isplayer(var_00)) {
    var_00 setscriptablepartstate("light_armor", "neutral", 0);
  }

  var_00 notify("remove_light_armor");
}

lightarmor_modifydamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  var_11 = 0;
  var_12 = 0;
  var_13 = var_0.lightarmorhp;

  if(!isDefined(var_10)) {
    var_10 = 1;
  }

  if(!var_11) {
    if(var_04 == "MOD_FALLING" || var_04 == "MOD_MELEE") {
      var_11 = 1;
    }
  }

  if(!var_11) {
    if(scripts\engine\utility::isbulletdamage(var_04) && scripts\mp\utility\game::isheadshot(var_05, var_08, var_04, var_01)) {
      var_11 = 1;
    }
  }

  if(!var_11) {
    if(var_04 == "MOD_IMPACT") {
      if(scripts\mp\weapons::func_9FA9(var_05) || scripts\mp\weapons::isaxeweapon(var_05)) {
        var_11 = 1;
      }
    }
  }

  if(!var_11) {
    if(isexplosivedamagemod(var_04)) {
      if(isDefined(var_09) && isDefined(var_9.stuckenemyentity) && var_9.stuckenemyentity == var_00) {
        var_11 = 1;
      }
    }
  }

  if(!var_11) {
    if(scripts\mp\utility\game::issuperdamagesource(var_05)) {
      var_11 = 1;
    }
  }

  if(!var_11) {
    var_12 = min(var_02 + var_03, var_0.lightarmorhp);
    var_13 = var_13 - (var_02 + var_03);

    if(!var_10) {
      var_0.lightarmorhp = var_0.lightarmorhp - (var_02 + var_03);
    }

    var_02 = 0;
    var_03 = 0;

    if(var_13 <= 0) {
      var_02 = abs(var_13);
      var_03 = 0;

      if(!var_10) {
        lightarmor_unset(var_00);
      }
    }
  }

  if(!var_10) {
    lightarmor_updatehud(self);
  }

  if(var_12 > 0 && var_02 == 0) {
    var_02 = 1;
  }

  return [var_12, var_02, var_03];
}

lightarmor_lightarmor_disabled(var_00) {
  if(var_00 scripts\mp\heavyarmor::hasheavyarmor()) {
    return 1;
  }

  return 0;
}

lightarmor_monitordeath(var_00) {
  var_00 endon("disconnect");
  var_00 endon("lightArmor_set");
  var_00 endon("lightArmor_unset");
  var_00 waittill("death");
  thread lightarmor_unset(var_00);
}

lightarmor_updatehud(var_00) {
  if(!isplayer(var_00)) {
    return;
  }
  if(isDefined(level.carrierarmor)) {
    var_00 setclientomnvar("ui_uplink_carrier_armor", int(getlightarmorvalue(var_00)));
  }
}

lightarmor_setfx(var_00) {
  var_00 setscriptablepartstate("light_armor", "active", 0);
}