/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3137.gsc
**************************************/

_id_3629() {
  anim._id_362A = [];
  anim._id_362A["left"] = [];
  anim._id_362A["left"]["rail"]["height"] = 120.336;
  anim._id_362A["left"]["rail"]["max"] = 147.938;
  anim._id_362A["left"]["rail"]["min"] = 72.6321;
  anim._id_362A["left"]["rail"]["radius"] = 41.6399;
  anim._id_362A["left"]["rail"]["center_offset"] = 13.7184;
  anim._id_362A["left"]["rail"]["rate"] = 1.52309;
  anim._id_362A["left"]["pitch"] = [];
  anim._id_362A["left"]["pitch"]["max"] = -81.8474;
  anim._id_362A["left"]["pitch"]["min"] = 81.8623;
  anim._id_362A["left"]["pitch"]["rate"] = 1.35075;
  anim._id_362A["right"] = [];
  anim._id_362A["right"]["rail"]["height"] = 119.798;
  anim._id_362A["right"]["rail"]["max"] = -147.617;
  anim._id_362A["right"]["rail"]["min"] = -72.5554;
  anim._id_362A["right"]["rail"]["radius"] = 41.7472;
  anim._id_362A["right"]["rail"]["center_offset"] = 13.7055;
  anim._id_362A["right"]["rail"]["rate"] = 1.52613;
  anim._id_362A["right"]["pitch"] = [];
  anim._id_362A["right"]["pitch"]["max"] = -81.8536;
  anim._id_362A["right"]["pitch"]["min"] = 81.8683;
  anim._id_362A["right"]["pitch"]["rate"] = 1.35211;
  anim._id_362A["main"] = [];
  anim._id_362A["main"]["hex"]["max"] = 67.5246;
  anim._id_362A["main"]["hex"]["min"] = -72.8348;
  anim._id_362A["main"]["hex"]["rate"] = 1.15538;
  anim._id_362A["main"]["minigun"]["yaw_delta"] = 2.73737;
  anim._id_362A["main"]["minigun"]["pitch_offset"] = 7.1249;
  anim._id_362A["main"]["minigun"][2] = 32.8453;
  anim._id_362A["main"]["minigun"][4] = 13.2259;
  anim._id_362A["main"]["minigun"][6] = -13.7964;
  anim._id_362A["main"]["minigun"][8] = 0.938614;
  anim._id_362A["main"]["rocket"]["yaw_delta"] = -2.78845;
  anim._id_362A["main"]["rocket"]["pitch_delta"] = -5.96385;
}

_id_3628(var_0, var_1, var_2) {
  return anim._id_362A[var_0][var_1][var_2];
}

_id_3627(var_0) {
  self endon("death");
  self endon("self_destruct");
  self endon("stop_c12trackloop");
  self.asm._id_11AC7 = var_0;
  self.asm._id_11B08 = spawnStruct();
  self.asm._id_11B08.btracking = 0;
  self.asm._id_11B08._id_30E6 = 0;
  wait 0.5;
  _id_362C();
}

_id_358A() {
  return _id_0A1E::_id_2356("aim_parent_knob", "aim_knob");
}

_id_9E4D() {
  var_0 = scripts\asm\asm::asm_getcurrentstate(self.asm._id_11AC7);

  switch (var_0) {
    case "stand_turn":
    case "exposed_exit":
    case "run_turn":
      return 1;
  }

  return 0;
}

_id_35FF() {
  var_0 = self.ignoreall;
  self.ignoreall = 1;
  var_1 = _id_358A();
  self _meth_82A2(var_1, 1000, 0.1, 1);
  self.asm._id_11B08._id_DCCF = [];
  _id_3600();
  _id_3601();
  _id_3604();
  self.asm._id_11B08.btracking = 1;
  self.ignoreall = var_0;
}

_id_3583() {
  var_0 = self gettagangles("j_spineupper");
  var_1 = anglestoaxis(var_0);
  var_2 = rotatevectorinverted(var_1["right"], self.angles);
  var_3 = vectortoyaw(var_2);
  return angleclamp180(var_3);
}

_id_357E(var_0) {
  if(!isDefined(var_0)) {
    var_1 = _id_0A1E::_id_2356("aim_body", "hexapod");
    var_0 = self islegacyagent(var_1);
  }

  var_2 = _id_3628("main", "hex", "min");
  var_3 = _id_3628("main", "hex", "max");
  var_4 = var_2 + var_0 * (var_3 - var_2);
  return var_4;
}

_id_3600() {
  var_0 = self.asm._id_11B08;
  var_1 = _id_0A1E::_id_2356("aim_body", "hexapod");
  self _meth_82A2(var_1, 1, 0.0, 0.0);
  wait 0.1;
  var_2 = [];
  var_3 = _id_3583();
  var_2["min"] = var_3;
  var_4 = var_3 < 0;
  var_5 = 0;
  self _meth_82B1(var_1, 1);
  var_6 = 0;

  while(var_6 < 1) {
    var_7 = self gettagorigin("j_spineupper");
    var_8 = self gettagangles("j_spineupper");
    var_9 = anglestoaxis(var_8);
    _id_3547(var_9, var_7);
    var_6 = self islegacyagent(var_1);

    if(!var_5) {
      var_10 = _id_3583();
      var_11 = var_10 < 0;

      if(var_4 != var_11) {
        var_2["zero"] = var_6;
        var_5 = 1;
      }
    }

    wait 0.05;
  }

  if(!var_5)
    var_2["zero"] = 0;

  var_2["max"] = _id_3583();

  if(var_2["max"] < var_2["min"])
    var_2["max"] = var_2["max"] + 360;

  var_2["rate"] = 0.05 * abs(var_2["max"] - var_2["min"]) / getanimlength(var_1);
  var_0._id_DCCF["main"] = [];
  var_0._id_DCCF["main"]["hex"] = var_2;
  _id_3608(var_1, "main", "hex", 0);
}

_id_358D(var_0) {
  var_1 = _id_3628(var_0, "rail", "center_offset");
  var_2 = _id_3628(var_0, "rail", "height");
  var_3 = anglesToForward(self.angles);
  return self.origin + var_3 * var_1 + (0, 0, var_2);
}

_id_3580(var_0, var_1) {
  var_2 = _id_3628(var_0, "rail", "center_offset");
  var_3 = _id_3628(var_0, "rail", "height");
  var_4 = (var_2, 0, 0);

  if(!isDefined(var_1))
    var_1 = _id_357E();

  var_4 = rotatevector(var_4, (0, var_1, 0));
  var_4 = rotatevector(var_4, self.angles);
  return self.origin + var_4 + (0, 0, var_3);
}

_id_358F(var_0) {
  var_1 = undefined;

  if(var_0 == "left")
    var_1 = "j_clavicle_track_le";
  else
    var_1 = "j_clavicle_track_ri";

  var_2 = self gettagorigin(var_1);
  return var_2;
}

_id_358C(var_0, var_1) {
  var_2 = undefined;

  if(var_1 == "left")
    var_2 = "j_clavicle_track_le";
  else
    var_2 = "j_clavicle_track_ri";

  var_3 = self gettagorigin(var_2);
  var_4 = self.origin;
  var_5 = var_3 - var_4;
  var_5 = (var_5[0], var_5[1], 0);
  var_6 = rotatevectorinverted(var_5, self.angles);
  var_7 = vectortoangles(var_6);
  return angleclamp180(var_7[1]);
}

_id_358B(var_0) {
  var_1 = undefined;

  if(var_0 == "left")
    var_1 = "j_clavicle_track_le";
  else
    var_1 = "j_clavicle_track_ri";

  var_2 = self gettagorigin(var_1);
  var_3 = _id_358D(var_0);
  var_4 = var_2 - var_3;
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = rotatevectorinverted(var_4, self.angles);
  var_6 = vectortoangles(var_5);
  return angleclamp180(var_6[1]);
}

_id_357F(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_2 = _id_0A1E::_id_2356("aimset_" + var_0, "arm_rail");
    var_1 = self islegacyagent(var_2);
  }

  var_3 = _id_3628(var_0, "rail", "min");
  var_4 = _id_3628(var_0, "rail", "max");
  var_5 = var_4 - var_3;
  var_6 = var_3 + var_1 * var_5;
  return var_6;
}

_id_3581(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_2 = _id_0A1E::_id_2356("aimset_" + var_0, "arm_pitch");
    var_1 = self islegacyagent(var_2);
  }

  var_3 = _id_3628(var_0, "pitch", "min");
  var_4 = _id_3628(var_0, "pitch", "max");
  var_5 = var_4 - var_3;
  var_6 = var_3 + var_1 * var_5;
  return var_6;
}

_id_3590(var_0) {
  var_1 = undefined;

  if(var_0 == "left")
    var_1 = "j_clavicle_track_le";
  else
    var_1 = "j_clavicle_track_ri";

  var_2 = self gettagorigin(var_1);
  var_3 = var_2 - self.origin;
  return length2d(var_3);
}

_id_3591(var_0) {
  var_1 = undefined;

  if(var_0 == "left")
    var_1 = "j_clavicle_track_le";
  else
    var_1 = "j_clavicle_track_ri";

  var_2 = self gettagorigin(var_1);
  return var_2[2] - self.origin[2];
}

_id_358E(var_0, var_1) {
  var_2 = undefined;

  if(var_1 == "left")
    var_2 = "j_clavicle_x_le";
  else
    var_2 = "j_clavicle_x_ri";

  var_3 = self gettagangles(var_2);
  var_4 = anglestoright(var_3);
  var_5 = rotatevectorinverted(var_4, self.angles);
  var_6 = vectortoangles(var_5);
  return angleclamp180(var_6[0]);
}

_id_351F(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * var_3 - var_1 * var_1;
  var_5 = 180 - var_0;
  var_6 = 180 - var_2;
  var_7 = -0.5 * var_4 / (var_3 * cos(var_6) - var_1 * cos(var_5));
  return var_7;
}

_id_3603(var_0) {
  var_1 = self.asm._id_11B08;
  var_2 = 0;

  if(var_0 == "left")
    var_2 = 90;
  else
    var_2 = -90;

  var_1._id_DCCF[var_0] = [];
  var_1._id_DCCF[var_0]["rail"] = [];
  var_3 = _id_0A1E::_id_2356("aimset_" + var_0, "arm_rail");
  self _meth_82A2(var_3, 1, 0.0, 0.0);
  wait 0.1;
  var_4 = _id_3591(var_0);
  var_1._id_DCCF[var_0]["rail"]["height"] = var_4;
  var_5 = _id_358F(var_0);
  var_6 = _id_358C(var_3, var_0);
  var_7 = _id_3590(var_0);
  self _meth_82B0(var_3, 1);
  wait 0.1;
  var_8 = _id_358F(var_0);
  var_9 = _id_358C(var_3, var_0);
  var_10 = _id_3590(var_0);
  var_11 = _id_351F(var_6, var_7, var_9, var_10);
  var_1._id_DCCF[var_0]["rail"]["center_offset"] = var_11;
  var_12 = _id_358D(var_0);
  var_13 = distance(var_5, var_12);
  var_14 = distance(var_8, var_12);
  var_1._id_DCCF[var_0]["rail"]["radius"] = (var_13 + var_14) * 0.5;
  self _meth_82B0(var_3, 0);
  wait 0.1;
  var_1._id_DCCF[var_0]["rail"]["min"] = _id_358B(var_0);
  self _meth_82B0(var_3, 1);
  wait 0.1;
  var_1._id_DCCF[var_0]["rail"]["max"] = _id_358B(var_0);
  var_1._id_DCCF[var_0]["rail"]["rate"] = 0.05 * abs(var_1._id_DCCF[var_0]["rail"]["max"] - var_1._id_DCCF[var_0]["rail"]["min"]) / getanimlength(var_3);

  if(var_0 == "left")
    _id_3608(var_3, var_0, "rail", 90);
  else
    _id_3608(var_3, var_0, "rail", -90);

  var_3 = _id_0A1E::_id_2356("aimset_" + var_0, "arm_pitch");
  self _meth_82A2(var_3, 1, 0, 0);
  wait 0.05;
  var_1._id_DCCF[var_0]["pitch"] = [];
  var_1._id_DCCF[var_0]["pitch"]["min"] = _id_358E(var_3, var_0);
  self _meth_82B0(var_3, 1);
  wait 0.1;
  var_1._id_DCCF[var_0]["pitch"]["max"] = _id_358E(var_3, var_0);
  var_1._id_DCCF[var_0]["pitch"]["rate"] = 0.05 * abs(var_1._id_DCCF[var_0]["pitch"]["max"] - var_1._id_DCCF[var_0]["pitch"]["min"]) / getanimlength(var_3);
  var_15 = 0;
  self _meth_82B0(var_3, 0);
  self _meth_82B1(var_3, 1);

  while(var_15 < 8) {
    var_16 = undefined;

    if(var_0 == "left")
      var_16 = "j_clavicle_x_le";
    else
      var_16 = "j_clavicle_x_ri";

    var_17 = _id_358E(var_3, var_0);
    var_18 = self islegacyagent(var_3);
    var_19 = self gettagangles(var_16);
    _id_3547(anglestoaxis(var_19), self gettagorigin(var_16));
    wait 0.05;
    var_15 = var_15 + 0.05;
  }

  self _meth_82B1(var_3, 0);
  _id_3608(var_3, var_0, "pitch", 0);
}

_id_3585(var_0) {
  var_1 = undefined;

  if(var_0 == "left")
    var_1 = "tag_weapon_rotate_le";
  else
    var_1 = "tag_weapon_rotate_ri";

  return self gettagangles(var_1);
}

_id_3587(var_0) {
  var_1 = undefined;

  if(var_0 == "left")
    var_1 = "tag_weapon_rotate_le";
  else
    var_1 = "tag_weapon_rotate_ri";

  return self gettagorigin(var_1);
}

_id_3586(var_0) {
  var_1 = undefined;

  if(var_0 == "left")
    var_1 = "j_weaponshoulder_x_le";
  else
    var_1 = "j_weaponshoulder_x_ri";

  return self gettagorigin(var_1);
}

_id_3588(var_0) {
  var_1 = undefined;

  if(var_0 == "left")
    var_1 = "j_weaponshoulder_le";
  else
    var_1 = "j_weaponshoulder_ri";

  return self gettagorigin(var_1);
}

_id_3602(var_0) {
  wait 0.2;
  var_1 = self.asm._id_11B08;
  var_2 = _id_0A1E::_id_2356("aimset_minigun", "aim_5");
  self _meth_82A2(var_2, 0.01, 0, 1);
  wait 0.05;
  var_3 = _id_3585(var_0);
  var_1._id_DCCF["main"]["minigun"]["yaw_delta"] = angleclamp180(var_3[1] - self.angles[1]);
  var_4 = _id_3587(var_0);
  var_5 = _id_3588(var_0);
  var_6 = _id_3586(var_0);
  var_7 = vectorNormalize(var_4 - var_6);
  var_8 = var_4 - var_5;
  var_9 = vectordot(var_7, var_8);
  var_1._id_DCCF["main"]["minigun"]["pitch_offset"] = distance(var_5, var_6);
  var_10 = _id_0A1E::_id_2356("aimset_minigun", "aim_2");
  self _meth_82A2(var_10, 1, 0, 1, 0);
  wait 0.1;
  var_4 = _id_3587(var_0);
  var_6 = _id_3586(var_0);
  var_11 = var_4 - var_6;
  var_12 = var_11[2];
  var_1._id_DCCF["main"]["minigun"][2] = 0 - asin(var_12 / length(var_11));
  self clearanim(var_10, 0);
  var_13 = _id_0A1E::_id_2356("aimset_minigun", "aim_8");
  self _meth_82A2(var_13, 1, 0, 1, 0);
  wait 0.1;
  var_4 = _id_3587(var_0);
  var_6 = _id_3586(var_0);
  var_11 = var_4 - var_6;
  var_12 = var_11[2];
  var_1._id_DCCF["main"]["minigun"][8] = 0 - asin(var_12 / length(var_11));
  self clearanim(var_13, 0);
  var_14 = anglestoright(self.angles);
  var_15 = _id_0A1E::_id_2356("aimset_minigun", "aim_4");
  self _meth_82A2(var_15, 1, 0, 1, 0);
  wait 0.1;
  var_4 = _id_3587(var_0);
  var_6 = _id_3586(var_0);
  var_11 = var_4 - var_6;
  var_16 = vectordot(var_11, var_14) * -1;
  var_1._id_DCCF["main"]["minigun"][4] = asin(var_16 / length(var_11));
  self clearanim(var_15, 0);
  var_17 = _id_0A1E::_id_2356("aimset_minigun", "aim_6");
  self _meth_82A2(var_17, 1, 0, 1, 0);
  wait 0.1;
  var_4 = _id_3587(var_0);
  var_6 = _id_3586(var_0);
  var_11 = var_4 - var_6;
  var_16 = vectordot(var_11, var_14) * -1;
  var_1._id_DCCF["main"]["minigun"][6] = asin(var_16 / length(var_11));
  self clearanim(var_17, 0);
  var_18 = _id_0A1E::_id_2356("aimset_minigun", "aim_knob_28");
  self clearanim(var_18, 0);
  var_19 = _id_0A1E::_id_2356("aimset_minigun", "aim_knob_46");
  self clearanim(var_19, 0);
}

_id_3594(var_0, var_1) {
  var_2 = undefined;

  if(var_0 == "left") {
    if(var_1 == "top")
      var_2 = "tag_missile_top_le";
    else
      var_2 = "tag_missile_bottom_le";
  } else if(var_1 == "top")
    var_2 = "tag_missile_top_ri";
  else
    var_2 = "tag_missile_bottom_ri";

  return var_2;
}

_id_3593(var_0, var_1) {
  var_2 = _id_3594(var_0, var_1);
  return self gettagorigin(var_2);
}

_id_3592(var_0, var_1) {
  var_2 = _id_3594(var_0, var_1);
  return self gettagangles(var_2);
}

_id_3605(var_0) {
  wait 0.2;
  var_1 = _id_3592(var_0, "top");
  self.asm._id_11B08._id_DCCF["main"]["rocket"]["yaw_delta"] = angleclamp180(var_1[1] - self.angles[1]);
  self.asm._id_11B08._id_DCCF["main"]["rocket"]["pitch_delta"] = -1 * var_1[0];
}

_id_3601() {
  _id_3603("left");
  _id_3602("left");
}

_id_3604() {
  _id_3603("right");
  _id_3605("right");
}

_id_35A7() {
  var_0 = 0.3;
  var_1 = 0.2;
  var_2 = _id_0A1E::_id_2356("aim_body", "hexapod");
  _id_3608(var_2, "main", "hex", 0, var_0);
  var_2 = _id_0A1E::_id_2356("aimset_left", "arm_rail");
  _id_3608(var_2, "left", "rail", 100, var_0);
  var_2 = _id_0A1E::_id_2356("aimset_left", "arm_pitch");
  _id_3608(var_2, "left", "pitch", 0, var_0);
  var_2 = _id_0A1E::_id_2356("aimset_right", "arm_rail");
  _id_3608(var_2, "right", "rail", -100, var_0);
  var_2 = _id_0A1E::_id_2356("aimset_right", "arm_pitch");
  _id_3608(var_2, "right", "pitch", 0, var_0);
  var_3 = _id_358A();
  thread _id_3632(var_3, var_0, var_1);
  self.asm._id_11B08.btracking = 1;
}

_id_3632(var_0, var_1, var_2) {
  self endon("death");
  self _meth_82A2(var_0, 5, var_1, 1);
  wait(var_1);

  if(!self.asm._id_11B08.btracking) {
    return;
  }
  self _meth_82A2(var_0, 15, var_2);
  wait(var_2);

  if(!self.asm._id_11B08.btracking) {
    return;
  }
  self _meth_82A2(var_0, 1000, 1);
}

_id_3529() {
  var_0 = _id_358A();
  self clearanim(var_0, 0.2);
  self.asm._id_11B08.btracking = 0;
}

_id_3582() {
  var_0 = self._blackboard.shootparams;
  var_1 = _id_0C42::_id_3518("left");
  var_2 = _id_0C42::_id_3518("right");

  if(var_1 && var_2) {
    var_3 = _id_3595("left");
    var_4 = _id_3595("right");

    if(isDefined(var_3) && isDefined(var_4)) {
      var_5 = 0.5 * (var_3 + var_4);

      if(distancesquared(var_5, self.origin) < 10000 && distancesquared(var_3, var_4) > 0) {
        var_6 = scripts\engine\utility::flatten_vector(var_3 - self.origin);
        var_7 = scripts\engine\utility::flatten_vector(var_4 - self.origin);
        var_8 = vectortoyaw(var_6);
        var_9 = vectortoyaw(var_7);
        var_10 = angleclamp180((var_8 + var_9) * 0.5);
        var_11 = anglesToForward((0, var_10, 0));
        var_5 = self.origin + var_11 * 256;
      }

      return var_5;
    } else if(isDefined(var_3))
      return var_3;
    else if(isDefined(var_4))
      return var_4;
  }

  if(var_1)
    return _id_3595("left");
  else
    return _id_3595("right");

  return undefined;
}

_id_3595(var_0, var_1) {
  var_2 = self._blackboard.shootparams;

  if(!isDefined(var_2))
    return undefined;

  var_3 = var_2._id_13CC3[var_0];

  if(!isDefined(var_3))
    return undefined;

  if(!isDefined(var_1))
    var_1 = 0;

  if(!var_1 && !var_3._id_312A)
    return undefined;

  if(isDefined(var_3._id_1A46) && var_3._id_1A47 != gettime()) {
    var_4 = 0;

    if(_id_0C08::_id_A007(var_0, "rocket"))
      var_4 = 1;

    return _id_0C08::_id_FE67(var_3, var_4);
  }

  return var_3._id_1A46;
}

_id_351E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self._blackboard.shootparams;
  var_6 = _id_3595(var_0);

  if(!isDefined(var_6)) {
    var_4._id_B7A9 = 0;
    var_4._id_B7A6 = 0;
    return;
  }

  var_7 = _id_3588(var_0);
  var_8 = _id_357F(var_0, var_2);

  if(var_0 == "left")
    var_8 = var_8 - 90;
  else
    var_8 = var_8 + 90;

  if(!isDefined(var_1))
    var_1 = _id_357E();

  var_9 = anglestoaxis(self.angles + (0, var_1 + var_8, 0));
  var_10 = var_6 - var_7;
  var_11 = vectordot(var_10, var_9["right"]) * -1;
  var_12 = vectordot(var_10, var_9["up"]);
  var_13 = var_10 - var_12 * var_9["up"];
  var_14 = length(var_13);
  var_15 = var_10 + var_11 * var_9["right"];
  var_16 = length(var_15);
  var_17 = clamp(_id_3628("main", "minigun", "pitch_offset") / var_16, -1, 1);
  var_18 = 90 - acos(var_17);
  var_19 = clamp(var_11 / var_14, -1, 1);
  var_4._id_B7A9 = asin(var_19) - _id_3628("main", "minigun", "yaw_delta");
  var_19 = clamp(var_12 / var_16, -1, 1);
  var_4._id_B7A6 = -1 * asin(var_19) - _id_3581(var_0, var_3) + var_18;
}

_id_3521(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 - var_3;
  var_5 = (var_5[0], var_5[1], 0);
  var_6 = length(var_5);

  if(var_4 > var_6) {
    var_7 = -90;

    if(var_0 == "right")
      var_7 = 90;
  } else {
    var_5 = var_5 / var_6;
    var_8 = anglesToForward((0, var_2 + self.angles[1], 0));
    var_7 = acos(var_4 / var_6);
    var_9 = vectordot(var_5, var_8);

    if(var_0 == "right")
      var_7 = -1 * var_7;

    if(-1 < var_9 && var_9 < 1) {
      var_10 = vectorcross(var_5, var_8);

      if(var_10[2] > 0)
        var_7 = var_7 - acos(var_9);
      else
        var_7 = var_7 + acos(var_9);
    }
  }

  return var_7;
}

_id_3520(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self.angles + (0, var_5 + var_2, 0);
  var_7 = anglesToForward(var_6);
  var_8 = var_3 + var_4 * var_7;
  var_9 = var_1 - var_8;
  var_10 = var_9[2];
  var_11 = clamp(var_10 / length(var_9), -1, 1);
  var_12 = asin(var_11);
  return -1 * var_12;
}

_id_3522(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = spawnStruct();
  var_3 = _id_3582();

  if(isDefined(var_3)) {
    var_4 = var_3 - self.origin;
    var_5 = rotatevectorinverted(var_4, self.angles);
    var_6 = vectortoyaw(var_5);
    var_2._id_8E55 = angleclamp180(var_6);
  } else
    var_2._id_8E55 = 0;

  if(_id_9E4D())
    var_8 = _id_3583();
  else
    var_8 = _id_357E(var_0._id_8E54);

  var_9 = _id_3595("left");

  if(isDefined(var_9)) {
    var_10 = _id_3580("left", var_8);
    var_11 = _id_3628("left", "rail", "radius");
    var_2._id_AB57 = _id_3521("left", var_9, var_8, var_10, var_11);
    var_2._id_AB56 = _id_3520("left", var_9, var_8, var_10, var_11, var_2._id_AB57);

    if(self._id_13CC3["left"] == "minigun")
      _id_351E("left", var_8, var_0._id_AB57, var_0._id_AB56, var_2);
    else if(self._id_13CC3["left"] == "rocket") {
      var_2._id_AB57 = var_2._id_AB57 + _id_3628("main", "rocket", "yaw_delta");
      var_2._id_AB56 = var_2._id_AB56 + _id_3628("main", "rocket", "pitch_delta");

      if(isDefined(self._id_E5C4))
        var_2._id_AB56 = var_2._id_AB56 - self._id_E5C4;
    }
  } else {
    var_2._id_AB57 = 90;
    var_2._id_AB56 = 0;
  }

  var_12 = _id_3595("right");

  if(isDefined(var_12)) {
    var_10 = _id_3580("right", var_8);
    var_11 = _id_3628("right", "rail", "radius");
    var_2._id_E530 = _id_3521("right", var_12, var_8, var_10, var_11);
    var_2._id_E52F = _id_3520("right", var_12, var_8, var_10, var_11, var_2._id_E530);

    if(self._id_13CC3["right"] == "minigun")
      _id_351E("right", var_8, var_0._id_E530, var_0._id_E52F, var_2);
    else if(self._id_13CC3["right"] == "rocket") {
      var_2._id_E530 = var_2._id_E530 - _id_3628("main", "rocket", "yaw_delta");
      var_2._id_E52F = var_2._id_E52F + _id_3628("main", "rocket", "pitch_delta");

      if(isDefined(self._id_E5C4))
        var_2._id_E52F = var_2._id_E52F - self._id_E5C4;
    }
  } else {
    var_2._id_E530 = -90;
    var_2._id_E52F = 0;
  }

  return var_2;
}

_id_3630() {
  _id_3574();
  var_0 = 0.75;
  thread _id_3631(var_0);
}

_id_3631(var_0) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_1 = _id_0A1E::_id_2356("aim_body", "hexapod");
  self clearanim(var_1, var_0);
  var_1 = _id_0A1E::_id_2356("aimset_left", "arm_rail");
  self clearanim(var_1, var_0);
  var_1 = _id_0A1E::_id_2356("aimset_left", "arm_pitch");
  self clearanim(var_1, var_0);
  var_1 = _id_0A1E::_id_2356("aimset_right", "arm_rail");
  self clearanim(var_1, var_0);
  var_1 = _id_0A1E::_id_2356("aimset_right", "arm_pitch");
  self clearanim(var_1, var_0);
  var_2 = _id_358A();
  var_3 = self _meth_8103(var_2);
  var_4 = 2;

  if(var_3 <= var_4) {
    var_5 = min(var_0, 0.2 * var_3 / var_4);
    self clearanim(var_2, var_5);
    return;
  }

  while(var_3 > var_4) {
    self _meth_82A2(var_2, var_3 * 0.5, 0.05);
    wait 0.05;

    if(self.asm._id_11B08.btracking) {
      break;
    }

    var_0 = var_0 - 0.05;
    var_3 = self _meth_8103(var_2);
  }

  if(!self.asm._id_11B08.btracking)
    self clearanim(var_2, var_0);
}

_id_3574() {
  var_0 = _id_0A1E::_id_2356("aim_body", "hexapod");
  self _meth_82B1(var_0, 0);
  var_0 = _id_0A1E::_id_2356("aimset_left", "arm_rail");
  self _meth_82B1(var_0, 0);
  var_0 = _id_0A1E::_id_2356("aimset_left", "arm_pitch");
  self _meth_82B1(var_0, 0);
  var_0 = _id_0A1E::_id_2356("aimset_right", "arm_rail");
  self _meth_82B1(var_0, 0);
  var_0 = _id_0A1E::_id_2356("aimset_right", "arm_pitch");
  self _meth_82B1(var_0, 0);
}

_id_363C() {
  var_0 = _id_0A1E::_id_2356("aim_body", "hexapod");
  _id_3607(var_0, undefined, "main", "hex", 0, 6);
  var_0 = _id_0A1E::_id_2356("aimset_left", "arm_rail");
  _id_3607(var_0, undefined, "left", "rail", 100, 8);
  var_0 = _id_0A1E::_id_2356("aimset_left", "arm_pitch");
  _id_3607(var_0, undefined, "left", "pitch", 0, 8);
  var_0 = _id_0A1E::_id_2356("aimset_right", "arm_rail");
  _id_3607(var_0, undefined, "right", "rail", -100, 8);
  var_0 = _id_0A1E::_id_2356("aimset_right", "arm_pitch");
  _id_3607(var_0, undefined, "right", "pitch", 0, 8);
}

_id_3608(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_3628(var_1, var_2, "min");
  var_6 = _id_3628(var_1, var_2, "max");
  var_7 = var_6 - var_5;

  if(var_5 < var_6)
    var_3 = clamp(angleclamp180(var_3), var_5, var_6);
  else
    var_3 = clamp(angleclamp180(var_3), var_6, var_5);

  if(!isDefined(var_4))
    var_4 = 0;

  var_8 = (var_3 - var_5) / var_7;
  var_8 = clamp(var_8, 0, 1);
  self _meth_82A2(var_0, 1, var_4, 0);
  self _meth_82B0(var_0, var_8);
}

_id_3607(var_0, var_1, var_2, var_3, var_4, var_5) {
  self _meth_82A2(var_0, 1, 0.0, 0);
  var_6 = _id_3628(var_2, var_3, "min");
  var_7 = _id_3628(var_2, var_3, "max");
  var_8 = var_7 - var_6;

  if(var_6 < var_7)
    var_4 = clamp(var_4, var_6, var_7);
  else
    var_4 = clamp(var_4, var_7, var_6);

  var_9 = (var_4 - var_6) / var_8;
  var_9 = clamp(var_9, 0, 1);

  if(!isDefined(var_1))
    var_1 = self islegacyagent(var_0);

  var_10 = var_6 + var_1 * var_8;
  var_11 = abs(var_4 - var_10);

  if(var_11 > var_5)
    var_11 = var_5;

  if(-0.002 < var_11 && var_11 < 0.002) {
    var_11 = 0;
    self _meth_82B0(var_0, var_9);
  }

  var_12 = 1;

  if(var_9 < var_1)
    var_12 = -1;

  var_13 = _id_3628(var_2, var_3, "rate");
  self _meth_82B1(var_0, var_12 * var_11 / var_13);
}

_id_360B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = 0.1;
  self _meth_82A2(var_4, 0.01, 0, 1);

  if(var_0 > 0) {
    var_10 = var_0 / _id_3628("main", "minigun", 4);
    var_10 = clamp(var_10, 0, 1);
    self clearanim(var_5, var_13);
    self _meth_82A2(var_3, 1, var_13);
    self _meth_82A2(var_8, var_10, var_13);
  } else if(var_0 < 0) {
    var_11 = var_0 / _id_3628("main", "minigun", 6);
    var_11 = clamp(var_11, 0, 1);
    self clearanim(var_3, var_13);
    self _meth_82A2(var_5, 1, var_13);
    self _meth_82A2(var_8, var_11, var_13);
  }

  if(var_1 > 0) {
    var_9 = var_1 / _id_3628("main", "minigun", 2);
    var_9 = clamp(var_9, 0, 1);
    self clearanim(var_6, var_13);
    self _meth_82A2(var_2, 1, var_13);
    self _meth_82A2(var_7, var_9, var_13);
  } else if(var_1 < 0) {
    var_12 = var_1 / _id_3628("main", "minigun", 8);
    var_12 = clamp(var_12, 0, 1);
    self clearanim(var_2, var_13);
    self _meth_82A2(var_6, 1, var_13);
    self _meth_82A2(var_7, var_12, var_13);
  }
}

_id_362C() {
  var_0 = _id_0A1E::_id_2356("aim_body", "hexapod");
  var_1 = _id_0A1E::_id_2356("aimset_left", "arm_rail");
  var_2 = _id_0A1E::_id_2356("aimset_left", "arm_pitch");
  var_3 = _id_0A1E::_id_2356("aimset_right", "arm_rail");
  var_4 = _id_0A1E::_id_2356("aimset_right", "arm_pitch");
  var_5 = _id_0A1E::_id_2356("aimset_minigun", "aim_2");
  var_6 = _id_0A1E::_id_2356("aimset_minigun", "aim_4");
  var_7 = _id_0A1E::_id_2356("aimset_minigun", "aim_6");
  var_8 = _id_0A1E::_id_2356("aimset_minigun", "aim_8");
  var_9 = _id_0A1E::_id_2356("aimset_minigun", "aim_5");
  var_10 = _id_0A1E::_id_2356("aimset_minigun", "aim_knob_28");
  var_11 = _id_0A1E::_id_2356("aimset_minigun", "aim_knob_46");
  var_12 = _id_358A();
  var_13 = 0;
  var_14 = 0;
  var_15 = 6;
  var_16 = spawnStruct();

  for(;;) {
    var_17 = scripts\asm\asm::_id_231B(self.asm._id_11AC7, "aim");

    if(isDefined(self._blackboard._id_E5F9))
      var_17 = 0;
    else if(isDefined(self._blackboard.rodeorequested))
      var_17 = 1;

    if(var_17) {
      if(!self.asm._id_11B08.btracking)
        _id_35A7();

      if(isDefined(self._blackboard.rodeorequested)) {
        if(!self.asm._id_11B08._id_30E6) {
          self.asm._id_11B08._id_30E6 = 1;
          thread _id_0C47::_id_351B();
          _id_3608(var_0, "main", "hex", 0);
        }
      } else if(isDefined(self._blackboard.shootparams) && (self._id_13C83["left"] || self._id_13C83["right"])) {
        var_16._id_8E54 = self islegacyagent(var_0);
        var_16._id_AB57 = self islegacyagent(var_1);
        var_16._id_E530 = self islegacyagent(var_3);
        var_16._id_AB56 = self islegacyagent(var_2);
        var_16._id_E52F = self islegacyagent(var_4);
        var_18 = _id_3522(var_16);
        self _meth_82A2(var_12, 1000, 0.1, 1);
        _id_3607(var_0, var_16._id_8E54, "main", "hex", var_18._id_8E55, 6 * self._id_1A48);

        if(isDefined(var_18._id_AB57))
          _id_3607(var_1, var_16._id_AB57, "left", "rail", var_18._id_AB57, 8 * self._id_1A48);

        if(isDefined(var_18._id_AB56))
          _id_3607(var_2, var_16._id_AB56, "left", "pitch", var_18._id_AB56, 8 * self._id_1A48);

        if(isDefined(var_18._id_E530))
          _id_3607(var_3, var_16._id_E530, "right", "rail", var_18._id_E530, 8 * self._id_1A48);

        if(isDefined(var_18._id_E52F))
          _id_3607(var_4, var_16._id_E52F, "right", "pitch", var_18._id_E52F, 8 * self._id_1A48);

        if(isDefined(var_18._id_B7A9) && isDefined(var_18._id_B7A6)) {
          var_19 = var_18._id_B7A9;
          var_20 = var_18._id_B7A6;
          var_21 = var_13 - var_19;
          var_22 = var_14 - var_20;

          if(var_21 > var_15)
            var_19 = var_13 - var_15;
          else if(var_21 < -1 * var_15)
            var_19 = var_13 + var_15;

          if(var_22 > var_15)
            var_20 = var_14 - var_15;
          else if(var_22 < -1 * var_15)
            var_20 = var_14 + var_15;

          _id_360B(var_19, var_20, var_5, var_6, var_9, var_7, var_8, var_10, var_11);
          var_13 = var_18._id_B7A9;
          var_14 = var_18._id_B7A6;
        }
      } else {
        _id_363C();
        var_13 = 0;
        var_14 = 0;
      }
    } else if(self.asm._id_11B08.btracking) {
      _id_3630();
      var_13 = 0;
      var_14 = 0;
      self.asm._id_11B08.btracking = 0;
    }

    wait 0.05;
  }
}

_id_FE84(var_0, var_1, var_2) {
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

_id_35D3(var_0, var_1, var_2) {
  var_3 = var_0 + "_finished";
  var_4 = var_0 + "_waitfor_note";
  thread _id_FE84(var_4, var_3, var_2);
  self endon(var_3);
  self endon(var_4);
  self waittillmatch(var_0, var_1);
}

_id_35D6(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = self._blackboard.shootparams;
  var_6 = self._id_164D[var_0].slot;
  var_7 = var_5._id_13CC3[var_6];
  self._id_164D[var_0]._id_4C1A = var_7;

  if(var_6 == "left")
    var_8 = self.secondaryweapon;
  else
    var_8 = self.primaryweapon;

  var_9 = var_7._id_C241;
  var_10 = [];

  if(isDefined(var_7._id_EF76)) {
    foreach(var_12 in var_7._id_EF76)
    var_10[var_10.size] = var_12;
  } else
    var_10[0] = var_7.ent;

  if(var_10.size == 0) {
    wait 1;
    scripts\asm\asm::asm_fireevent(var_1, "end");
    return;
  }

  var_14 = ["top", "bottom"];

  if(isDefined(self._blackboard.scriptableparts)) {
    var_15 = self._blackboard.scriptableparts[var_6 + "_arm"];

    if(isDefined(var_15)) {
      if(var_15.state == "dmg_upper")
        var_14 = ["bottom"];

      if(var_15.state == "dmg_lower")
        var_14 = ["top"];
    }
  }

  var_16 = getnotetracktimes(var_4, "fire");
  var_17 = var_16.size > 0;
  var_18 = _id_0C08::_id_FE67(var_7, 1);
  var_7._id_E5E0 = var_18;
  var_19 = [];

  foreach(var_21, var_12 in var_10)
  var_19[var_21] = var_12.origin;

  thread _id_35E9(var_6, var_14[0], var_18, var_7._id_DCE8 * var_9, var_1 + "_finished");
  self waittill("rocket_ready");
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  thread _id_360F(var_1);
  var_22 = 0;

  for(var_23 = 0; var_22 < var_9; var_23 = (var_23 + 1) % var_10.size) {
    if(isDefined(var_7._id_E5E0) || isDefined(var_10[var_23])) {
      if(var_22 == 0) {
        if(var_22 < var_16.size)
          _id_35D3(var_1, "fire", 1);
        else
          wait 0.1;
      } else
        wait(var_7._id_DCE8 / 1000);

      var_24 = var_22 == 0;

      if(_id_3615(var_6, var_7, var_24)) {
        _id_3509(var_7);
        break;
      }

      var_25 = int(var_22 / 4) % 2;
      var_26 = _id_3593(var_6, var_14[var_25]);
      var_27 = _id_3592(var_6, var_14[var_25]);
      var_28 = anglesToForward(var_27);

      if(var_6 == "left")
        var_29 = self.secondaryweapon;
      else
        var_29 = self.primaryweapon;

      if(scripts\sp\utility::_id_93A6() || level._id_7683 == 2 && isDefined(self._id_32D5) && self._id_32D5)
        var_29 = "iw7_c12rocket_specialist_mode";

      var_30 = magicbullet(var_29, var_26, var_19[var_23]);
      playFXOnTag(level._id_7649["muz_c12_rocket"], self, _id_3594(var_6, var_14[var_25]));

      if(isDefined(self._id_11B06))
        _id_362D(var_30);

      if(isDefined(var_7._id_E5E0)) {
        var_30._id_1155F = var_10[var_23];
        var_30 missile_settargetpos(var_19[var_23]);
      } else if(isDefined(var_10[var_23])) {
        var_30._id_1155F = var_10[var_23];
        var_30 missile_settargetEnt(var_10[var_23]);
      }

      var_22++;
    }
  }

  wait 3;
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

_id_3635(var_0, var_1, var_2) {
  var_3 = 4;
  var_4 = 360 / var_3;
  var_5 = 45;
  var_6 = 9;
  var_7 = self gettagorigin(var_0);
  var_8 = self gettagangles(var_0);
  var_9 = invertangles(var_8);
  var_10 = combineangles(var_8, (0, 0, -90 * (1 - var_2)));

  for(var_11 = 0; var_11 < var_3; var_11++) {
    var_12 = self._id_E5DB[var_11];
    var_13 = (var_11 + 0.5) * var_4;
    var_14 = var_6 * (0, cos(var_13), sin(var_13));
    var_15 = var_7 + rotatevector(var_14, var_8);
    var_16 = var_5 * (-1 * sin(var_13), cos(var_13), 0);
    var_17 = vectortoangles(var_1 - var_15);
    var_18 = combineangles(var_9, var_17);
    var_19 = anglelerpquatfrac(var_16, var_18, var_2);
    var_19 = combineangles(var_10, var_19);
    var_12.origin = var_15;
    var_12.angles = var_19;
  }
}

_id_35E9(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_4);
  var_5 = _id_3594(var_0, var_1);
  var_6 = 4;
  var_7 = 360 / var_6;
  var_8 = 45;
  var_9 = 9;
  var_10 = 1;
  var_11 = var_3 / 1000;
  var_12 = var_10 + anim._id_35EC + var_11;
  createnavrepulsor("c12_rocket", var_12, var_2, 256, 1);
  self notify("rocket_targeting");
  _id_0A16::_id_17BA("targeting");
  self _meth_857A("target", var_2);
  self._id_E5DB = [];

  for(var_13 = 0; var_13 < var_6; var_13++) {
    var_14 = spawn("script_model", (0, 0, 0));
    self._id_E5DB[var_13] = var_14;
    var_14 setModel("tag_flash");
    var_14 _meth_81D6();
    var_14 setotherent(self);
    var_14 _meth_8575(self.secondaryweapon);
  }

  _id_3635(var_5, var_2, 0);

  foreach(var_14 in self._id_E5DB)
  var_14 linkTo(self, var_5);

  wait(var_10);
  wait(anim._id_35EC);
  self notify("rocket_ready");
  var_17 = int(var_11 * 20);

  while(var_17 > 0) {
    if(!isDefined(self._id_E5DB)) {
      return;
    }
    var_17--;
    scripts\engine\utility::waitframe();
  }

  _id_35EB();
}

_id_35EB() {
  if(isDefined(self._id_E5DB)) {
    self _meth_857A("none");

    foreach(var_1 in self._id_E5DB) {
      var_1 _meth_81D5();
      var_1 delete();
    }

    self._id_E5DB = undefined;
  }
}

_id_35EA(var_0) {
  var_0._id_E5E0 = undefined;
  destroynavrepulsor("c12_rocket");
  _id_35EB();
}

_id_362D(var_0) {
  if(!isDefined(self._id_6D6C))
    self._id_6D6C = [];

  var_1 = [];

  foreach(var_3 in self._id_6D6C) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_1[var_1.size] = var_0;
  self._id_6D6C = var_1;
  self notify("rocket_fired", var_0);
  var_1 = undefined;
}

_id_360F(var_0) {
  self endon(var_0 + "_finished");

  for(;;) {
    self waittill(var_0, var_1);

    if(!isarray(var_1))
      var_1 = [var_1];

    foreach(var_3 in var_1) {
      if(var_3 == "end") {
        scripts\asm\asm::asm_fireevent(var_0, var_3);
        return;
      }
    }
  }
}

_id_35D5(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = self._blackboard.shootparams;
  var_6 = self._id_164D[var_0].slot;
  var_7 = var_5._id_13CC3[var_6];
  var_8 = var_7._id_32BC;
  var_9 = var_7._id_DCE8;
  var_10 = 1.5;
  self _meth_82A2(var_4, 1, var_2, var_10);
  var_11 = _id_0A1E::_id_2356(var_1, "recoil");
  self _meth_82A2(var_11, 1, var_2, 1);
  var_12 = gettime();
  var_13 = var_12;
  var_14 = var_12 + var_9;
  self._id_164D[var_0]._id_4C1A = var_7;
  self playSound("weap_c12_minigun_spinup");
  self playLoopSound("weap_c12_minigun_fire");

  for(var_15 = _id_0C08::_id_9F7B(var_6); var_12 < var_8; var_12 = gettime()) {
    if(_id_3615(var_6, var_7, var_15)) {
      _id_3509(var_7);
      break;
    }

    if(var_12 >= var_14) {
      if(_id_0C08::_id_8BEC(var_7)) {
        var_16 = var_8 - var_12 < 0.05;
        _id_35C5(var_6, var_16, var_15);
      }

      var_14 = var_14 + var_9;
    }

    wait 0.05;
  }
}

_id_35C5(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_0 == "left") {
    var_4 = self.secondaryweapon;
    var_3 = "tag_weapon_rotate_le";
  } else {
    var_4 = self.primaryweapon;
    var_3 = "tag_weapon_rotate_ri";
  }

  var_5 = _id_3587(var_0);
  var_6 = _id_3585(var_0);
  var_7 = self._blackboard.shootparams._id_13CC3[var_0];
  var_8 = 1;
  var_9 = 0;

  if(var_7._id_29A1 && !var_2) {
    var_10 = undefined;

    if(isDefined(var_7.ent))
      var_10 = var_7.ent;
    else if(isDefined(var_7._id_EF76))
      var_10 = var_7._id_EF76[0];

    self _meth_8494(var_4, var_5, var_6, var_8, var_10, var_9, var_1, var_3);
  } else {
    var_11 = _id_3595(var_0, var_2);
    var_12 = bulletspread(var_5, var_11, 4);
    self _meth_8494(var_4, var_5, var_6, var_8, var_12, var_9, var_1, var_3);
  }
}

_id_3615(var_0, var_1, var_2) {
  var_3 = self._blackboard.shootparams;

  if(!isDefined(var_3))
    return 1;

  var_4 = var_3._id_13CC3[var_0];

  if(!isDefined(var_4))
    return 1;

  if(!_id_0C08::_id_9F5B(var_0))
    return 1;

  if(var_4 != var_1)
    return 1;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!var_2 && !var_4._id_312A)
    return 1;

  if(isDefined(self._id_9DD2) && self._id_9DD2)
    return 1;

  return 0;
}

_id_3509(var_0) {
  var_0._id_2720 = 1;
}

_id_3612(var_0, var_1, var_2) {
  var_3 = _id_0A1E::_id_2356(var_1, "loop");
  var_4 = _id_0A1E::_id_2356(var_1, "recoil_knob");
  self clearanim(var_3, 0.2);
  self clearanim(var_4, 0.2);
  self shootstopsound();
  self stoploopsound();
  self playSound("weap_c12_minigun_release");
  var_5 = self._id_164D[var_0]._id_4C1A;
  var_6 = self._id_164D[var_0].slot;

  if(isDefined(self._id_EF6F) && isDefined(var_5._id_EF76))
    self notify(var_5._id_EF6F);

  self._id_164D[var_0]._id_4C1A = undefined;
}

_id_3613(var_0, var_1, var_2) {
  var_3 = _id_0A1E::_id_2356(var_1, "shoot_knob");
  self clearanim(var_3, 0.2);
  var_4 = self._id_164D[var_0].slot;
  scripts\asm\asm::asm_fireephemeralevent("rocket_shoot_complete", var_4);
  var_5 = self._id_164D[var_0]._id_4C1A;

  if(isDefined(var_5._id_EF77))
    self notify(var_5._id_EF77);

  self._id_164D[var_0]._id_4C1A = undefined;
  _id_35EA(var_5);
}

_id_35D4(var_0, var_1, var_2, var_3) {}

_id_3526(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard.shootparams;
  var_5 = self._id_164D[var_0].slot;
  var_6 = var_4._id_13CC3[var_5];

  if(var_6._id_C241 == 1)
    var_7 = var_5 + "_1";
  else
    var_7 = var_5 + "_4";

  return _id_0A1E::_id_2356(var_1, var_7);
}

_id_3525(var_0, var_1, var_2, var_3) {
  var_4 = _id_0A1E::_id_2356(var_1, "loop");
  return var_4;
}

_id_3547(var_0, var_1) {}