/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\weapon_utility.gsc
****************************************************/

function _magicbullet(var0, var1, var2, var3, var4) {
  var5 = magicbullet(var0, var1, var2, var3, var4);

  if(isDefined(var5) && isDefined(var3)) {
    var5 setotherent(var3);
  }

  return var5;
}

function islockonlauncher(var0) {
  var1 = undefined;
  var2 = undefined;

  if(isstring(var0)) {
    var2 = var0;
  } else {
    var2 = var0.basename;
  }

  switch (var2) {
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
    case "iw8_la_t9standard_mp":
      var1 = 1;
      break;
    default:
      var1 = 0;
      break;
  }

  return var1;
}

function addlockedon(var0, var1) {
  if(!isDefined(var0.islockedon)) {
    var0.islockedon = 0;
    var0.attackerslockedon = [];
  }

  if(var0.islockedon == 0) {
    if(isDefined(var0.lockedoncallback)) {
      var0 thread[[var0.lockedoncallback]]();
    }
  }

  if(isDefined(var1)) {
    var1.entlockedonto = var0;
    var0.attackerslockedon[var1 getentitynumber()] = var1;
  }

  var0.islockedon++;
}

function removelockedon(var0, var1) {
  if(!isDefined(var0.islockedon)) {
    return;
  }

  if(var0.islockedon == 1) {
    if(isDefined(var0.lockedonremovedcallback)) {
      var0 thread[[var0.lockedonremovedcallback]]();
    }
  }

  if(isDefined(var1)) {
    if(isDefined(var1.entlockedonto) && var1.entlockedonto == var0) {
      var1.entlockedonto = undefined;
    }

    var0.attackerslockedon[var1 getentitynumber()] = undefined;
  }

  var0.islockedon--;
}

function setlockedoncallback(var0, var1) {
  var0.lockedoncallback = var1;
}

function setlockedonremovedcallback(var0, var1) {
  var0.lockedonremovedcallback = var1;
}

function clearlockedon(var0) {
  var0 notify("clearLockedOn");

  if(islockedonto(var0)) {
    if(isDefined(var0.lockedonremovedcallback)) {
      var0 thread[[var0.lockedonremovedcallback]]();
    }

    foreach(var2 in var0.attackerslockedon) {
      if(isDefined(var2)) {
        if(isDefined(var2.entlockedonto) && var2.entlockedonto == var0) {
          var2.entlockedonto = undefined;
        }
      }
    }
  }

  var0.islockedon = undefined;
  var0.attackerslockedon = undefined;
  var0.lockedoncallback = undefined;
  var0.lockedonremovedcallback = undefined;

  if(hasincoming(var0)) {
    if(isDefined(var0.start_firing_minigun)) {
      var0 thread[[var0.start_firing_minigun]]();
    }
  }

  var0.hasincoming = undefined;
  var0.start_eye_barkov = undefined;
  var0.start_firing_minigun = undefined;
}

function clearlockedonondisconnect(var0) {
  if(isDefined(self.entlockedonto)) {
    removelockedon(self.entlockedonto, self);
  }

  self.entlockedonto = undefined;
}

function islockedonto(var0) {
  return isDefined(var0.islockedon) && var0.islockedon > 0;
}

function battle_tracks_shouldplaybattletrackswhenstandingonvehicle(var0) {
  if(!isDefined(var0.hasincoming)) {
    var0.hasincoming = 0;
  }

  if(var0.hasincoming == 0) {
    if(isDefined(var0.start_eye_barkov)) {
      var0 thread[[var0.start_eye_barkov]]();
    }
  }

  var0.hasincoming++;
}

function ref_12c07(var0) {
  if(!isDefined(var0.hasincoming)) {
    return;
  }

  if(var0.hasincoming == 1) {
    if(isDefined(var0.start_firing_minigun)) {
      var0 thread[[var0.start_firing_minigun]]();
    }
  }

  var0.hasincoming--;
}

function ref_13162(var0, var1) {
  var0.start_eye_barkov = var1;
}

function ref_13163(var0, var1) {
  var0.start_firing_minigun = var1;
}

function hasincoming(var0) {
  return isDefined(var0.hasincoming) && var0.hasincoming > 0;
}

function watchtargetlockedontobyprojectile(var0, var1) {
  var0 endon("clearLockedOn");
  addlockedon(var0);
  battle_tracks_shouldplaybattletrackswhenstandingonvehicle(var0);
  var1 scripts\engine\utility::ref_143a5("death", "clearTargetLockedOntoByProjectile");

  if(isDefined(var0)) {
    removelockedon(var0);
    ref_12c07(var0);
    return;
  }
}

function clearprojectilelockedon(var0) {
  var0 notify("clearTargetLockedOntoByProjectile");
}

function dropweaponfordeathlaunch(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = self.angles;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var4 = scripts\engine\math::normalize_value(0, 200, var2);

  if(var1 == "weapon_melee2") {
    var5 = randomfloatrange(25, 100);
    var6 = randomfloatrange(75, 175);
    var7 = scripts\engine\math::factor_value(450, 800, var4);
    var8 = scripts\engine\math::factor_value(-1.16667, -0.833333, var4);
    var9 = scripts\engine\math::factor_value(0.125, 0.183333, var4);
  } else if(var6 == "weapon_pistol") {
    var5 = randomfloatrange(100, 200);
    var6 = randomfloatrange(150, 250);
    var7 = scripts\engine\math::factor_value(950, 1300, var9);
    var8 = scripts\engine\math::factor_value(-1.75, -1.25, var9);
    var9 = scripts\engine\math::factor_value(0.5625, 0.825, var9);
  } else {
    var5 = randomfloatrange(150, 350);
    var6 = randomfloatrange(150, 250);
    var7 = scripts\engine\math::factor_value(950, 1300, var9);
    var8 = scripts\engine\math::factor_value(-7, -5, var9);
    var9 = scripts\engine\math::factor_value(0.75, 1.1, var9);
  }

  if(scripts\engine\utility::cointoss()) {
    var6 *= -1;
  }

  if(!isDefined(var5)) {
    return;
  }

  var10 = var5 physics_getentitycenterofmass();

  if(isDefined(var10)) {
    var10 = var10["unscaled"];
  } else {
    var10 = var5.origin;
  }

  var11 = (0, 0, 0);
  var11 += anglesToForward(var8) * var5;
  var11 += anglestoright(var8) * var6;
  var11 += anglestoup(var8) * var7;
  var12 = var5 gettagangles("tag_flash", 1);

  if(!isDefined(var12)) {
    var12 = var5.angles;
  }

  if(scripts\engine\utility::cointoss()) {
    var9 *= -1;
  }

  var13 = var10;
  var13 += anglesToForward(var12) * var8;
  var13 += anglestoright(var12) * var9;
  var5 physicslaunchserveritem(var13, var11);
}

function ref_12eb2() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "saveToggleScopeStates")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "saveToggleScopeStates")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "saveAltStates")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "saveAltStates")]]();
    return;
  }
}

function ref_12cc7(var0) {
  if(self isalternatemode(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "updateSavedAltState")) {
      var0 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "updateSavedAltState")]](var0);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "updateToggleScopeState")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "updateToggleScopeState")]](var0);
  }

  return var0;
}

function vehicle_clearpreventplayercollisiondamagefortimeafterexit(var0) {
  var1 = self getplayerdata(level.loadoutsgroup, "squadMembers", "weapon_unlocked", var0);
  return istrue(var1);
}

function tv_station_boss(var0) {
  return var0 == "iw8_ar_falpha" || var0 == "iw8_ar_t9longburst" || var0 == "iw8_sm_t9powerburst" || var0 == "iw8_sm_t9burst" || var0 == "iw8_ar_t9fastburst";
}

function vehicle_ai_script_models(var0) {
  var1 = strtok(var0, "_");
  var2 = var1.size > 1 && isstartstr(var1[1], "t9") || var1.size > 2 && isstartstr(var1[2], "t9");
  var3 = var1.size > 0 && var1[0] == "s4";
  return !var2 && !var3;
}