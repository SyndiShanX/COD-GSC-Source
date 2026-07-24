/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3890.gsc
**************************************/

main() {
  precacheitem("trackingfragzerog");
  precache();
}

_id_D393() {
  thread _id_139A();
}

_id_D434() {
  if(scripts\sp\utility::_id_D0BD("trackingfragzerog", 1)) {
    scripts\sp\utility::_id_1145A("trackingfragzerog");
    self notify("take_trackingfragzerog");
  }
}

_id_139A() {
  self endon("death");
  self endon("take_trackingfragzerog");

  if(isDefined(self._id_EB73) && self._id_EB73 == gettime())
    scripts\engine\utility::waitframe();

  self giveweapon("trackingfragzerog");
  self assignweaponoffhandprimary("trackingfragzerog");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isDefined(var_0) && issubstr(var_1, "trackingfragzerog"))
      thread _id_11AE6(var_0);
  }
}

precache() {
  level._id_7649["tracking_grenade_thrown"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_tracking_grenade_thrown.vfx");
  level._id_7649["tracking_grenade_track_start"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_tracking_grenade_deploy.vfx");
  level._id_7649["tracking_grenade_thruster_lg"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_tracking_grenade_thruster_lg.vfx");
  level._id_7649["tracking_grenade_thruster_sm"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_tracking_grenade_thruster_sm.vfx");
  level._id_7649["tracking_grenade_impact"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_tracking_grenade_detonate.vfx");
  level._id_764C["tracking_grenade_tgt_acquired"] = "semtex_warning";
  level._id_764C["tracking_grenade_track_start"] = "zg_jets_lp";
  level._id_764C["tracking_grenade_detonate"] = "zg_grenade_detonate";
  level._id_764C["tracking_grenade_throw"] = "zg_throw";
}

_id_11861(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::spawn_tag_origin();
  var_4.fx = var_1;

  if(!isDefined(var_2))
    var_2 = "";

  var_4 linkTo(var_0, var_2, (0, 0, 0), (0, 0, 0));

  if(var_2 != "") {
    var_4._id_AEC1 = rotatevectorinverted(anglesToForward(var_0 gettagangles(var_2)), var_0.angles);
    var_4._id_AEC2 = rotatevectorinverted(var_0 gettagorigin(var_2) - var_0.origin, var_0.angles);
  } else {
    var_4._id_AEC1 = (1, 0, 0);
    var_4._id_AEC2 = (0, 0, 0);
  }

  var_4._id_AEBF = vectortoangles(var_4._id_AEC1);
  var_4._id_AEC0 = invertangles(var_4._id_AEBF);
  var_4.enabled = 0;
  return var_4;
}

_id_1185F(var_0, var_1) {
  if(var_1 && !var_0.enabled)
    playFXOnTag(_id_7ED1(var_0.fx), var_0, "tag_origin");
  else if(!var_1 && var_0.enabled)
    stopFXOnTag(_id_7ED1(var_0.fx), var_0, "tag_origin");

  var_0.enabled = var_1;
}

_id_11860(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_2) - anglesToForward(var_1);
  var_3 = rotatevectorinverted(var_3, var_1);
  var_4 = (0, 0, 2.5);

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(isDefined(var_0[var_5])) {
      var_6 = vectorNormalize((var_0[var_5]._id_AEC1[0], var_0[var_5]._id_AEC1[1], 0));
      var_7 = vectordot(var_3, var_6);
      var_8 = 0;

      if(abs(var_7) > 0.05) {
        var_9 = var_4 - var_0[var_5]._id_AEC2;

        if(vectordot(var_9, (0, 0, 1)) < 0)
          var_8 = var_7 < 0;
        else
          var_8 = var_7 > 0;
      }

      _id_1185F(var_0[var_5], var_8);
    }
  }
}

_id_11AE6(var_0) {
  var_1 = self;
  var_2 = 0.05;
  var_3 = _id_B28E(var_0, self getplayerangles());

  if(!isDefined(var_3)) {
    return;
  }
  var_3 endon("death");
  var_4 = [];
  var_4["fx"] = _id_11861(var_3);
  var_4["main"] = _id_11861(var_3, "tracking_grenade_thruster_lg", "tag_fx", 30);
  var_4[0] = _id_11861(var_3, "tracking_grenade_thruster_sm", "tag_jet_1", 10);
  var_4[1] = _id_11861(var_3, "tracking_grenade_thruster_sm", "tag_jet_2", 10);
  var_4[2] = _id_11861(var_3, "tracking_grenade_thruster_sm", "tag_jet_3", 10);
  var_4[3] = _id_11861(var_3, "tracking_grenade_thruster_sm", "tag_jet_4", 10);
  var_3 thread _id_11AE3(var_1);
  var_3._id_11881 = var_4;
  var_5 = self getEye();
  var_6 = anglestoaxis(self getplayerangles());
  var_7 = var_5 + var_6["forward"] * 10000 + rotatepointaroundvector(var_6["forward"], var_6["right"], randomfloatrange(0, 360)) * 10000;
  var_8 = var_6["forward"] * 500 + var_6["up"] * randomfloatrange(20, 50) + var_6["right"] * randomfloatrange(-20, 20);
  var_8 = var_8 + self getvelocity();
  var_9 = (randomfloatrange(360, 540), 0, randomfloatrange(90, 120));
  var_10 = (0, 0, 0);
  var_11 = 1.0;
  var_12 = undefined;
  var_13 = 0;
  var_14 = (0, 0, 0);
  var_15 = 0;
  var_16 = 1.0;
  var_17 = 2000;
  var_18 = 100;
  var_19 = var_18 * var_18;

  if(soundexists(_id_812F("tracking_grenade_throw")))
    var_3 thread _id_11AE7();

  playFXOnTag(_id_7ED1("tracking_grenade_thrown"), var_4["fx"], "tag_origin");

  for(var_20 = 0; var_20 < 4.25; var_20 = var_20 + var_2) {
    if(gettime() > var_15 && (!isDefined(var_12) || !isalive(var_12))) {
      if(isDefined(var_12))
        var_20 = min(0.25, var_20);

      var_12 = var_3 _id_11AE2(var_1);
      var_15 = gettime() + 500;
    }

    if(distancesquared(var_7, var_3.origin) < var_19) {
      break;
    }

    if(var_20 < 0.25) {
      var_8 = var_8 * 0.95;
      var_9 = var_9 * 0.97;
    } else {
      var_8 = var_8 * 0.85;
      var_9 = var_9 * 0.9;
    }

    if(!var_13 && var_20 > 0.25) {
      var_13 = 1;
      var_14 = var_3.origin;

      if(isDefined(var_12) && soundexists(_id_812F("tracking_grenade_tgt_acquired")))
        var_3 thread _id_11AE5();

      if(soundexists(_id_812F("tracking_grenade_track_start")))
        var_3 playLoopSound(_id_812F("tracking_grenade_track_start"));

      stopFXOnTag(_id_7ED1("tracking_grenade_thrown"), var_4["fx"], "tag_origin");
      playFXOnTag(_id_7ED1("tracking_grenade_track_start"), var_4["fx"], "tag_origin");
      _id_1185F(var_4["main"], 1);
    }

    if(var_13) {
      var_21 = clamp((var_20 - 0.25) / var_11, 0.0, 1.0);
      var_22 = 0.0;

      if(var_20 > 0.25 + var_11)
        var_22 = clamp((var_20 - (0.25 + var_11)) / (4.25 - (0.25 + var_11)), 0.0, 1.0);

      if(isDefined(var_12) && isalive(var_12))
        var_7 = var_12.origin;

      var_23 = rotatevector(var_4["main"]._id_AEC1 * -1, var_3.angles);
      var_24 = var_21 * var_17;
      var_10 = var_10 + var_23 * var_24 * var_2;
      var_25 = combineangles(vectortoangles(var_3.origin - var_7), var_4["main"]._id_AEC0);
      var_26 = var_21 * var_16;
      var_27 = anglelerpquatfrac(var_3.angles, var_25, var_26);
      var_27 = combineangles(var_27, var_9 * var_2);

      if(var_22 > 0) {
        var_28 = vectorNormalize(var_7 - var_3.origin);
        var_29 = var_28 * length(var_10);
        var_10 = vectorlerp(var_10, var_29, var_22);
        var_27 = anglelerpquatfrac(var_3.angles, var_25, var_22);
      }

      _id_11860(var_4, var_3.angles, var_25);
    } else
      var_27 = combineangles(var_3.angles, var_9 * var_2);

    var_30 = var_8 + var_10;
    var_31 = var_3.origin + var_30 * var_2;
    var_32 = bulletTrace(var_3.origin, var_31, 1, var_3, 1, 1, 0, 0, 1);

    if(isDefined(var_32["glass"])) {
      destroyglass(var_32["glass"], vectorNormalize(var_30));
      var_32 = bulletTrace(var_3.origin, var_31, 1, var_3, 1, 1, 0, 0, 1);
    }

    if(var_32["fraction"] < 1 && (!isDefined(var_32["entity"]) || var_32["entity"] != var_1)) {
      break;
    }

    var_3.origin = var_31;
    var_3.angles = var_27;
    wait(var_2);
  }

  var_3 _id_11AE1(var_1);
}

_id_11AE1(var_0) {
  var_1 = 200;
  var_2 = 1000;
  var_3 = 50;
  self notify("tracking_grenade_deactivate");
  self notsolid();
  radiusdamage(self.origin, var_1, var_2, var_3, var_0, "MOD_GRENADE", "trackingfragzerog");
  playFX(_id_7ED1("tracking_grenade_impact"), self.origin);

  if(soundexists(_id_812F("tracking_grenade_detonate")))
    thread scripts\engine\utility::play_sound_in_space(_id_812F("tracking_grenade_detonate"), self.origin);

  foreach(var_5 in self._id_11881)
  var_5 delete();

  scripts\engine\utility::waitframe();
  self delete();
}

_id_11AE3(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_C1D7))
    var_0._id_C1D7 = 0;

  var_0._id_C1D7++;
  scripts\sp\utility::_id_16D5("no_tracking_grenades_active", ::_id_C017, "tracking grenades are active");
  scripts\engine\utility::waittill_any_timeout(4.25, "death", "tracking_grenade_deactivate");
  wait 1;
  var_0._id_C1D7--;
}

_id_C017() {
  return !isDefined(level.player._id_C1D7) || level.player._id_C1D7 == 0;
}

_id_11AE2(var_0) {
  var_1 = 4000000;
  var_2 = var_0 getEye();
  var_3 = anglesToForward(var_0 getplayerangles());
  var_4 = undefined;
  var_5 = getaispeciesarray(scripts\engine\utility::get_enemy_team(var_0.team), "all");
  var_6 = getEntArray("tracking_grenade_target", "script_noteworthy");
  var_6 = scripts\engine\utility::array_combine(var_6, vehicle_getarray());
  var_7 = [var_5, var_6];

  foreach(var_9 in var_7) {
    if(isDefined(var_4)) {
      break;
    }

    var_10 = -1.0;

    foreach(var_12 in var_9) {
      if(!issentient(var_12)) {
        continue;
      }
      if(!isalive(var_12)) {
        continue;
      }
      if(var_12.ignoreme) {
        continue;
      }
      var_13 = var_12.origin;

      if(isai(var_12))
        var_13 = var_12 getEye();

      if(distancesquared(var_13, var_2) > var_1) {
        continue;
      }
      var_14 = vectordot(vectorNormalize(var_13 - var_2), var_3);

      if(var_14 <= var_10) {
        continue;
      }
      if(!sighttracepassed(self.origin, var_13, 0, self, var_12)) {
        continue;
      }
      var_4 = var_12;
      var_10 = var_14;
    }
  }

  return var_4;
}

_id_B28E(var_0, var_1) {
  var_2 = var_0.origin;
  var_0 delete();
  var_3 = spawn("script_model", var_2);
  var_3 setModel("tracking_grenade_wm");
  var_3.angles = var_1;
  var_3 setcontents(0);
  return var_3;
}

_id_11AE7() {
  self endon("sounddone");
  self playSound(_id_812F("tracking_grenade_throw"), "sounddone");
  self waittill("tracking_grenade_deactivate");
  self stopsounds();
}

_id_11AE5() {
  self playSound(_id_812F("tracking_grenade_tgt_acquired"));
  var_0 = scripts\engine\utility::waittill_any_timeout(5, "tracking_grenade_deactivate");

  if(isDefined(var_0) && var_0 != "timeout")
    self stopsounds();
}

_id_7ED1(var_0) {
  return level._id_7649[var_0];
}

_id_812F(var_0) {
  return level._id_764C[var_0];
}