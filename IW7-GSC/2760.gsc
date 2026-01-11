/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2760.gsc
***************************************/

func_AC0B(var_00, var_01) {}

func_AC1A(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  thread func_AC13();
  var_02 = self getcurrentweapon();

  for(;;) {
    while(var_02 != var_00) {
      self waittill("weapon_change", var_02);
    }

    childthread func_AC08(var_02, var_01);
    self waittill("weapon_change", var_02);
    func_AC07();
  }
}

func_AC13() {
  self endon("LGM_player_endMonitorFire");
  scripts\engine\utility::waittill_any("death", "disconnect");

  if(isDefined(self)) {
    func_AC04();
  }
}

func_AC07() {
  func_AC04();
  self notify("LGM_player_endMonitorFire");
}

func_AC08(var_00, var_01, var_02) {
  self endon("LGM_player_endMonitorFire");
  func_AC05();
  var_03 = undefined;

  for(;;) {
    var_04 = undefined;
    self waittill("missile_fire", var_04, var_05);

    if(isDefined(var_4.func_9E8F) && var_4.func_9E8F) {
      continue;
    }
    if(var_05 != var_00) {
      continue;
    }
    if(!isDefined(var_03)) {
      var_03 = func_AC17(self);
    }

    thread func_AC06(var_00, var_01, var_02, 0.35, 0.1, var_04, var_03);
  }
}

func_AC06(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self notify("monitor_laserGuidedMissile_delaySpawnChildren");
  self endon("monitor_laserGuidedMissile_delaySpawnChildren");
  self endon("death");
  self endon("LGM_player_endMonitorFire");
  func_AC12(var_06);
  wait(var_03);

  if(!isvalidmissile(var_05)) {
    return;
  }
  var_07 = var_5.origin;
  var_08 = anglesToForward(var_5.angles);
  var_09 = anglestoup(var_5.angles);
  var_10 = anglestoright(var_5.angles);
  var_05 delete();
  playFX(level._effect["laser_guided_launcher_missile_split"], var_07, var_08, var_09);
  var_11 = [];

  for(var_12 = 0; var_12 < 2; var_12++) {
    var_13 = 20;
    var_14 = 0;

    if(var_12 == 0) {
      var_14 = 20;
    }
    else if(var_12 == 1) {
      var_14 = -20;
    }
    else if(var_12 == 2) {}

    var_15 = rotatepointaroundvector(var_10, var_08, var_13);
    var_15 = rotatepointaroundvector(var_09, var_15, var_14);
    var_16 = scripts\mp\utility\game::_magicbullet(var_01, var_07, var_07 + var_15 * 180, self);
    var_16.func_9E8F = 1;
    var_11[var_11.size] = var_16;
    scripts\engine\utility::waitframe();
  }

  wait(var_04);
  var_11 = func_AC16(var_11);

  if(var_11.size > 0) {
    foreach(var_18 in var_11) {
      var_6.func_B8AC[var_6.func_B8AC.size] = var_18;
      var_18 missile_settargetent(var_06);
      thread func_AC15(var_06, var_18);
    }

    thread func_AC09(var_06, var_02);
  }
}

func_AC15(var_00, var_01) {
  var_01 scripts\engine\utility::waittill_any("death", "missile_pairedWithFlare", "LGM_missile_abandoned");

  if(isDefined(var_0.func_B8AC) && var_0.func_B8AC.size > 0) {
    var_0.func_B8AC = scripts\engine\utility::array_remove(var_0.func_B8AC, var_01);
    var_0.func_B8AC = func_AC16(var_0.func_B8AC);
  }

  if(!isDefined(var_0.func_B8AC) || var_0.func_B8AC.size == 0) {
    self notify("LGM_player_allMissilesDestroyed");
  }
}

func_AC09(var_00, var_01) {
  self notify("LGM_player_newMissilesFired");
  self endon("LGM_player_newMissilesFired");
  self endon("LGM_player_allMissilesDestroyed");
  self endon("LGM_player_endMonitorFire");
  self endon("death");
  self endon("disconnect");
  var_02 = undefined;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = 0;
  var_06 = gettime() + 400;

  while(isDefined(var_0.func_B8AC) && var_0.func_B8AC.size > 0) {
    var_07 = func_AC18();

    if(!isDefined(var_07)) {
      if(isDefined(var_03)) {
        self notify("LGM_player_targetLost");
        var_03 = undefined;

        foreach(var_09 in var_0.func_B8AC) {
        var_09 notify("missile_targetChanged");
        }
      }

      var_04 = undefined;
      var_05 = 0;
      var_11 = scripts\engine\utility::ter_op(gettime() > var_06, 8000, 800);
      var_12 = anglesToForward(self getplayerangles());
      var_13 = self getEye() + var_12 * 12;
      var_14 = bulletTrace(var_13, var_13 + var_12 * var_11, 1, self, 0, 0, 0);
      var_02 = var_14["position"];
    } else {
      var_02 = var_7.origin;
      var_15 = !isDefined(var_03) || var_07 != var_03;
      var_03 = var_07;

      if(var_15 || !isDefined(var_04)) {
        var_04 = gettime() + 1500;
        level thread func_AC11(var_03, self);
      } else if(gettime() >= var_04) {
        var_05 = 1;
        self notify("LGM_player_lockedOn");
      }

      if(var_05) {
        waittillframeend;

        if(var_0.func_B8AC.size > 0) {
          var_16 = [];

          foreach(var_09 in var_0.func_B8AC) {
            if(!isvalidmissile(var_09)) {
              continue;
            }
            var_16[var_16.size] = var_9.origin;
            var_09 notify("missile_targetChanged");
            var_09 notify("LGM_missile_abandoned");
            var_09 delete();
          }

          if(var_16.size > 0) {
            level thread func_AC0E(var_03, self, var_01, var_16);
          }

          var_0.func_B8AC = [];
        } else
          break;
      } else if(var_15)
        func_AC19(var_03, self, var_0.func_B8AC);
    }

    var_0.origin = var_02;
    scripts\engine\utility::waitframe();
  }
}

func_AC17(var_00) {
  if(!isDefined(level.func_A875)) {
    level.func_A875 = [];
  }

  if(!isDefined(level.func_A876)) {
    level.func_A876 = [];
  }

  var_01 = undefined;

  if(level.func_A876.size) {
    var_01 = level.func_A876[0];
    level.func_A876 = scripts\engine\utility::array_remove(level.func_A876, var_01);
  } else
    var_01 = spawn("script_origin", var_0.origin);

  level.func_A875[level.func_A875.size] = var_01;
  level thread func_AC14(var_01, var_00);
  var_1.func_B8AC = [];
  return var_01;
}

func_AC14(var_00, var_01) {
  var_01 scripts\engine\utility::waittill_any("death", "disconnect", "LGM_player_endMonitorFire");

  foreach(var_03 in var_0.func_B8AC) {
    if(isvalidmissile(var_03)) {
      var_03 missile_cleartarget();
    }
  }

  var_0.func_B8AC = undefined;
  level.func_A875 = scripts\engine\utility::array_remove(level.func_A875, var_00);

  if(level.func_A876.size + level.func_A875.size < 4) {
    level.func_A876[level.func_A876.size] = var_00;
  }
  else {
    var_00 delete();
  }
}

func_AC11(var_00, var_01) {
  var_02 = scripts\mp\utility\game::outlineenableforplayer(var_00, "orange", var_01, 1, 0, "killstreak_personal");
  level thread func_AC0F(var_01, "maaws_reticle_tracking", 1.5, "LGM_player_lockingDone");
  level thread func_AC10(var_00, var_01);
  var_01 scripts\engine\utility::waittill_any("death", "disconnect", "LGM_player_endMonitorFire", "LGM_player_newMissilesFired", "LGM_player_targetLost", "LGM_player_lockedOn", "LGM_player_allMissilesDestroyed", "LGM_player_targetDied");

  if(isDefined(var_00)) {
    scripts\mp\utility\game::outlinedisable(var_02, var_00);
  }

  if(isDefined(var_01)) {
    var_01 notify("LGM_player_lockingDone");
    var_01 stopolcalsound("maaws_reticle_tracking");
  }
}

func_AC0C(var_00, var_01, var_02) {
  var_01 endon("death");
  var_00 waittill("death");
  var_1.func_AC03[var_02] = ::scripts\engine\utility::array_remove(var_1.func_AC03[var_02], var_00);

  if(var_1.func_AC03[var_02].size == 0) {
    var_1.func_AC03[var_02] = undefined;
    var_01 notify("LGM_target_lockedMissilesDestroyed");
  }
}

func_AC10(var_00, var_01) {
  var_01 endon("death");
  var_01 endon("disconnect");
  var_01 endon("LGM_player_lockingDone");
  var_00 waittill("death");
  var_01 notify("LGM_player_targetDied");
}

func_AC0F(var_00, var_01, var_02, var_03) {
  var_00 endon("death");
  var_00 endon("disconnect");
  var_00 endon(var_03);

  for(;;) {
    var_00 playlocalsound(var_01);
    wait(var_02);
  }
}

func_AC0D(var_00, var_01, var_02, var_03) {
  var_00 endon("death");
  var_01 endon("death");
  var_01 endon("disconnect");
  var_04 = [];

  for(var_05 = 0; var_05 < var_3.size; var_5++) {
    var_06 = scripts\mp\utility\game::_magicbullet(var_02, var_3[var_05], var_0.origin, var_01);
    var_6.func_9E8F = 1;
    var_4[var_4.size] = var_06;
    playFX(level._effect["laser_guided_launcher_missile_spawn_homing"], var_6.origin, anglesToForward(var_6.angles), anglestoup(var_6.angles));
    scripts\engine\utility::waitframe();
  }

  return var_04;
}

func_AC0E(var_00, var_01, var_02, var_03) {
  if(var_3.size == 0) {
    return;
  }
  var_04 = func_AC0D(var_00, var_01, var_02, var_03);

  if(!isDefined(var_04)) {
    return;
  }
  var_04 = func_AC16(var_04);

  if(var_4.size == 0) {
    return;
  }
  var_01 playlocalsound("maaws_reticle_locked");
  var_05 = scripts\mp\utility\game::outlineenableforplayer(var_00, "red", var_01, 0, 0, "killstreak_personal");
  var_06 = func_AC0A(var_00);

  foreach(var_08 in var_04) {
    var_08 scripts\engine\utility::missile_settargetandflightmode(var_00, "direct", var_06);
    func_AC19(var_00, var_01, var_04);
  }

  if(!isDefined(var_0.func_AC03)) {
    var_0.func_AC03 = [];
  }

  var_0.func_AC03[var_05] = var_04;

  foreach(var_11 in var_04) {
  level thread func_AC0C(var_11, var_00, var_05);
  }

  var_13 = 1;

  while(var_13) {
    var_14 = var_00 scripts\engine\utility::waittill_any_return("death", "LGM_target_lockedMissilesDestroyed");

    if(var_14 == "death") {
      var_13 = 0;

      if(isDefined(var_00)) {
        var_0.func_AC03[var_05] = undefined;
      }

      continue;
    }

    if(var_14 == "LGM_target_lockedMissilesDestroyed") {
      waittillframeend;

      if(!isDefined(var_0.func_AC03[var_05]) || var_0.func_AC03[var_05].size == 0) {
        var_13 = 0;
      }
    }
  }

  if(isDefined(var_00)) {
    scripts\mp\utility\game::outlinedisable(var_05, var_00);
  }
}

func_AC18() {
  var_00 = scripts\mp\weapons::func_AF2B();
  var_00 = sortbydistance(var_00, self.origin);
  var_01 = undefined;

  foreach(var_03 in var_00) {
    if(self worldpointinreticle_circle(var_3.origin, 65, 75)) {
      var_01 = var_03;
      break;
    }
  }

  return var_01;
}

func_AC05() {
  if(!isDefined(self.func_A874) || self.func_A874 == 0) {
    self.func_A874 = 1;
    scripts\mp\utility\game::enableweaponlaser();
  }
}

func_AC04() {
  if(isDefined(self.func_A874) && self.func_A874 == 1) {
    scripts\mp\utility\game::disableweaponlaser();
  }

  self.func_A874 = undefined;
}

func_AC16(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(isvalidmissile(var_03)) {
      var_1[var_1.size] = var_03;
    }
  }

  return var_01;
}

func_AC19(var_00, var_01, var_02) {
  level notify("laserGuidedMissiles_incoming", var_01, var_02, var_00);
  var_00 notify("targeted_by_incoming_missile", var_02);
}

func_AC0A(var_00) {
  var_01 = undefined;

  if(var_0.model != "vehicle_av8b_harrier_jet_mp") {
    var_01 = var_00 gettagorigin("tag_missile_target");
  }
  else {
    var_01 = var_00 gettagorigin("tag_body");
  }

  if(!isDefined(var_01)) {
    var_01 = var_00 getpointinbounds(0, 0, 0);
  }

  return var_01 - var_0.origin;
}

func_AC12(var_00) {
  if(isDefined(var_0.func_B8AC) && var_0.func_B8AC.size > 0) {
    foreach(var_02 in var_0.func_B8AC) {
      if(isvalidmissile(var_02)) {
        var_02 notify("missile_targetChanged");
        var_02 notify("LGM_missile_abandoned");
        var_02 missile_cleartarget();
      }
    }
  }

  var_0.func_B8AC = [];
}