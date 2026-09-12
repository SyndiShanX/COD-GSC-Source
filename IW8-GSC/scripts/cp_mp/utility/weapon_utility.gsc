/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\weapon_utility.gsc
****************************************************/

function _magicbullet(var_0, var_1, var_2, var_3, var_4) {
  var_5 = magicbullet(var_0, var_1, var_2, var_3, var_4);

  if(isDefined(var_5) && isDefined(var_3)) {
    var_5 setotherent(var_3);
  }

  return var_5;
}

function islockonlauncher(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(isstring(var_0)) {
    var_2 = var_0;
  } else {
    var_2 = var_0.basename;
  }

  switch (var_2) {
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
    case "iw8_la_t9standard_mp":
      var_1 = 1;
      break;
    default:
      var_1 = 0;
      break;
  }

  return var_1;
}

function addlockedon(var_0, var_1) {
  if(!isDefined(var_0.islockedon)) {
    var_0.islockedon = 0;
    var_0.attackerslockedon = [];
  }

  if(var_0.islockedon == 0) {
    if(isDefined(var_0.lockedoncallback)) {
      var_0 thread[[var_0.lockedoncallback]]();
    }
  }

  if(isDefined(var_1)) {
    var_1.entlockedonto = var_0;
    var_0.attackerslockedon[var_1 getentitynumber()] = var_1;
  }

  var_0.islockedon++;
}

function removelockedon(var_0, var_1) {
  if(!isDefined(var_0.islockedon)) {
    return;
  }

  if(var_0.islockedon == 1) {
    if(isDefined(var_0.lockedonremovedcallback)) {
      var_0 thread[[var_0.lockedonremovedcallback]]();
    }
  }

  if(isDefined(var_1)) {
    if(isDefined(var_1.entlockedonto) && var_1.entlockedonto == var_0) {
      var_1.entlockedonto = undefined;
    }

    var_0.attackerslockedon[var_1 getentitynumber()] = undefined;
  }

  var_0.islockedon--;
}

function setlockedoncallback(var_0, var_1) {
  var_0.lockedoncallback = var_1;
}

function setlockedonremovedcallback(var_0, var_1) {
  var_0.lockedonremovedcallback = var_1;
}

function clearlockedon(var_0) {
  var_0 notify("clearLockedOn");

  if(islockedonto(var_0)) {
    if(isDefined(var_0.lockedonremovedcallback)) {
      var_0 thread[[var_0.lockedonremovedcallback]]();
    }

    foreach(var_2 in var_0.attackerslockedon) {
      if(isDefined(var_2)) {
        if(isDefined(var_2.entlockedonto) && var_2.entlockedonto == var_0) {
          var_2.entlockedonto = undefined;
        }
      }
    }
  }

  var_0.islockedon = undefined;
  var_0.attackerslockedon = undefined;
  var_0.lockedoncallback = undefined;
  var_0.lockedonremovedcallback = undefined;

  if(hasincoming(var_0)) {
    if(isDefined(var_0.start_firing_minigun)) {
      var_0 thread[[var_0.start_firing_minigun]]();
    }
  }

  var_0.hasincoming = undefined;
  var_0.start_eye_barkov = undefined;
  var_0.start_firing_minigun = undefined;
}

function clearlockedonondisconnect(var_0) {
  if(isDefined(self.entlockedonto)) {
    removelockedon(self.entlockedonto, self);
  }

  self.entlockedonto = undefined;
}

function islockedonto(var_0) {
  return isDefined(var_0.islockedon) && var_0.islockedon > 0;
}

function battle_tracks_shouldplaybattletrackswhenstandingonvehicle(var_0) {
  if(!isDefined(var_0.hasincoming)) {
    var_0.hasincoming = 0;
  }

  if(var_0.hasincoming == 0) {
    if(isDefined(var_0.start_eye_barkov)) {
      var_0 thread[[var_0.start_eye_barkov]]();
    }
  }

  var_0.hasincoming++;
}

function ref_12C07(var_0) {
  if(!isDefined(var_0.hasincoming)) {
    return;
  }

  if(var_0.hasincoming == 1) {
    if(isDefined(var_0.start_firing_minigun)) {
      var_0 thread[[var_0.start_firing_minigun]]();
    }
  }

  var_0.hasincoming--;
}

function ref_13162(var_0, var_1) {
  var_0.start_eye_barkov = var_1;
}

function ref_13163(var_0, var_1) {
  var_0.start_firing_minigun = var_1;
}

function hasincoming(var_0) {
  return isDefined(var_0.hasincoming) && var_0.hasincoming > 0;
}

function watchtargetlockedontobyprojectile(var_0, var_1) {
  var_0 endon("clearLockedOn");
  addlockedon(var_0);
  battle_tracks_shouldplaybattletrackswhenstandingonvehicle(var_0);
  var_1 scripts\engine\utility::ref_143A5("death", "clearTargetLockedOntoByProjectile");

  if(isDefined(var_0)) {
    removelockedon(var_0);
    ref_12C07(var_0);
    return;
  }
}

function clearprojectilelockedon(var_0) {
  var_0 notify("clearTargetLockedOntoByProjectile");
}

function dropweaponfordeathlaunch(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = self.angles;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = scripts\engine\math::normalize_value(0, 200, var_2);

  if(var_1 == "weapon_melee2") {
    var_5 = randomfloatrange(25, 100);
    var_6 = randomfloatrange(75, 175);
    var_7 = scripts\engine\math::factor_value(450, 800, var_4);
    var_8 = scripts\engine\math::factor_value(-1.16667, -0.833333, var_4);
    var_9 = scripts\engine\math::factor_value(0.125, 0.183333, var_4);
  } else if(var_6 == "weapon_pistol") {
    var_5 = randomfloatrange(100, 200);
    var_6 = randomfloatrange(150, 250);
    var_7 = scripts\engine\math::factor_value(950, 1300, var_9);
    var_8 = scripts\engine\math::factor_value(-1.75, -1.25, var_9);
    var_9 = scripts\engine\math::factor_value(0.5625, 0.825, var_9);
  } else {
    var_5 = randomfloatrange(150, 350);
    var_6 = randomfloatrange(150, 250);
    var_7 = scripts\engine\math::factor_value(950, 1300, var_9);
    var_8 = scripts\engine\math::factor_value(-7, -5, var_9);
    var_9 = scripts\engine\math::factor_value(0.75, 1.1, var_9);
  }

  if(scripts\engine\utility::cointoss()) {
    var_6 *= -1;
  }

  if(!isDefined(var_5)) {
    return;
  }

  var_10 = var_5 physics_getentitycenterofmass();

  if(isDefined(var_10)) {
    var_10 = var_10["unscaled"];
  } else {
    var_10 = var_5.origin;
  }

  var_11 = (0, 0, 0);
  var_11 += anglesToForward(var_8) * var_5;
  var_11 += anglestoright(var_8) * var_6;
  var_11 += anglestoup(var_8) * var_7;
  var_12 = var_5 gettagangles("tag_flash", 1);

  if(!isDefined(var_12)) {
    var_12 = var_5.angles;
  }

  if(scripts\engine\utility::cointoss()) {
    var_9 *= -1;
  }

  var_13 = var_10;
  var_13 += anglesToForward(var_12) * var_8;
  var_13 += anglestoright(var_12) * var_9;
  var_5 physicslaunchserveritem(var_13, var_11);
}

function ref_12EB2() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "saveToggleScopeStates")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "saveToggleScopeStates")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "saveAltStates")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "saveAltStates")]]();
    return;
  }
}

function ref_12CC7(var_0) {
  if(self isalternatemode(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "updateSavedAltState")) {
      var_0 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "updateSavedAltState")]](var_0);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "updateToggleScopeState")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "updateToggleScopeState")]](var_0);
  }

  return var_0;
}

function vehicle_clearpreventplayercollisiondamagefortimeafterexit(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "squadMembers", "weapon_unlocked", var_0);
  return istrue(var_1);
}

function tv_station_boss(var_0) {
  return var_0 == "iw8_ar_falpha" || var_0 == "iw8_ar_t9longburst" || var_0 == "iw8_sm_t9powerburst" || var_0 == "iw8_sm_t9burst" || var_0 == "iw8_ar_t9fastburst";
}

function vehicle_ai_script_models(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = var_1.size > 1 && isstartstr(var_1[1], "t9") || var_1.size > 2 && isstartstr(var_1[2], "t9");
  var_3 = var_1.size > 0 && var_1[0] == "s4";
  return !var_2 && !var_3;
}