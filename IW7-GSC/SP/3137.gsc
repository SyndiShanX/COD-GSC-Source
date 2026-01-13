/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3137.gsc
*********************************************/

func_3629() {
  anim.var_362A = [];
  level.var_362A["left"] = [];
  level.var_362A["left"]["rail"]["height"] = 120.336;
  level.var_362A["left"]["rail"]["max"] = 147.938;
  level.var_362A["left"]["rail"]["min"] = 72.6321;
  level.var_362A["left"]["rail"]["radius"] = 41.6399;
  level.var_362A["left"]["rail"]["center_offset"] = 13.7184;
  level.var_362A["left"]["rail"]["rate"] = 1.52309;
  level.var_362A["left"]["pitch"] = [];
  level.var_362A["left"]["pitch"]["max"] = -81.8474;
  level.var_362A["left"]["pitch"]["min"] = 81.8623;
  level.var_362A["left"]["pitch"]["rate"] = 1.35075;
  level.var_362A["right"] = [];
  level.var_362A["right"]["rail"]["height"] = 119.798;
  level.var_362A["right"]["rail"]["max"] = -147.617;
  level.var_362A["right"]["rail"]["min"] = -72.5554;
  level.var_362A["right"]["rail"]["radius"] = 41.7472;
  level.var_362A["right"]["rail"]["center_offset"] = 13.7055;
  level.var_362A["right"]["rail"]["rate"] = 1.52613;
  level.var_362A["right"]["pitch"] = [];
  level.var_362A["right"]["pitch"]["max"] = -81.8536;
  level.var_362A["right"]["pitch"]["min"] = 81.8683;
  level.var_362A["right"]["pitch"]["rate"] = 1.35211;
  level.var_362A["main"] = [];
  level.var_362A["main"]["hex"]["max"] = 67.5246;
  level.var_362A["main"]["hex"]["min"] = -72.8348;
  level.var_362A["main"]["hex"]["rate"] = 1.15538;
  level.var_362A["main"]["minigun"]["yaw_delta"] = 2.73737;
  level.var_362A["main"]["minigun"]["pitch_offset"] = 7.1249;
  level.var_362A["main"]["minigun"][2] = 32.8453;
  level.var_362A["main"]["minigun"][4] = 13.2259;
  level.var_362A["main"]["minigun"][6] = -13.7964;
  level.var_362A["main"]["minigun"][8] = 0.938614;
  level.var_362A["main"]["rocket"]["yaw_delta"] = -2.78845;
  level.var_362A["main"]["rocket"]["pitch_delta"] = -5.96385;
}

func_3628(var_0, var_1, var_2) {
  return level.var_362A[var_0][var_1][var_2];
}

func_3627(var_0) {
  self endon("death");
  self endon("self_destruct");
  self endon("stop_c12trackloop");
  self.asm.var_11AC7 = var_0;
  self.asm.var_11B08 = spawnStruct();
  self.asm.var_11B08.btracking = 0;
  self.asm.var_11B08.var_30E6 = 0;
  wait(0.5);
  func_362C();
}

func_358A() {
  return lib_0A1E::func_2356("aim_parent_knob", "aim_knob");
}

func_9E4D() {
  var_0 = scripts\asm\asm::asm_getcurrentstate(self.asm.var_11AC7);
  switch (var_0) {
    case "exposed_exit":
    case "stand_turn":
    case "run_turn":
      return 1;
  }

  return 0;
}

func_35FF() {
  var_0 = self.precacheleaderboards;
  self.precacheleaderboards = 1;
  var_1 = func_358A();
  self give_attacker_kill_rewards(var_1, 1000, 0.1, 1);
  self.asm.var_11B08.var_DCCF = [];
  func_3600();
  func_3601();
  func_3604();
  self.asm.var_11B08.btracking = 1;
  self.precacheleaderboards = var_0;
}

func_3583() {
  var_0 = self gettagangles("j_spineupper");
  var_1 = anglestoaxis(var_0);
  var_2 = rotatevectorinverted(var_1["right"], self.angles);
  var_3 = vectortoyaw(var_2);
  return angleclamp180(var_3);
}

func_357E(var_0) {
  if(!isDefined(var_0)) {
    var_1 = lib_0A1E::func_2356("aim_body", "hexapod");
    var_0 = self getscoreinfocategory(var_1);
  }

  var_2 = func_3628("main", "hex", "min");
  var_3 = func_3628("main", "hex", "max");
  var_4 = var_2 + var_0 * var_3 - var_2;
  return var_4;
}

func_3600() {
  var_0 = self.asm.var_11B08;
  var_1 = lib_0A1E::func_2356("aim_body", "hexapod");
  self give_attacker_kill_rewards(var_1, 1, 0, 0);
  wait(0.1);
  var_2 = [];
  var_3 = func_3583();
  var_2["min"] = var_3;
  var_4 = var_3 < 0;
  var_5 = 0;
  self _meth_82B1(var_1, 1);
  var_6 = 0;
  while(var_6 < 1) {
    var_7 = self gettagorigin("j_spineupper");
    var_8 = self gettagangles("j_spineupper");
    var_9 = anglestoaxis(var_8);
    func_3547(var_9, var_7);
    var_6 = self getscoreinfocategory(var_1);
    if(!var_5) {
      var_0A = func_3583();
      var_0B = var_0A < 0;
      if(var_4 != var_0B) {
        var_2["zero"] = var_6;
        var_5 = 1;
      }
    }

    wait(0.05);
  }

  if(!var_5) {
    var_2["zero"] = 0;
  }

  var_2["max"] = func_3583();
  if(var_2["max"] < var_2["min"]) {
    var_2["max"] = var_2["max"] + 360;
  }

  var_2["rate"] = 0.05 * abs(var_2["max"] - var_2["min"]) / getanimlength(var_1);
  var_0.var_DCCF["main"] = [];
  var_0.var_DCCF["main"]["hex"] = var_2;
  func_3608(var_1, "main", "hex", 0);
}

func_358D(var_0) {
  var_1 = func_3628(var_0, "rail", "center_offset");
  var_2 = func_3628(var_0, "rail", "height");
  var_3 = anglesToForward(self.angles);
  return self.origin + var_3 * var_1 + (0, 0, var_2);
}

func_3580(var_0, var_1) {
  var_2 = func_3628(var_0, "rail", "center_offset");
  var_3 = func_3628(var_0, "rail", "height");
  var_4 = (var_2, 0, 0);
  if(!isDefined(var_1)) {
    var_1 = func_357E();
  }

  var_4 = rotatevector(var_4, (0, var_1, 0));
  var_4 = rotatevector(var_4, self.angles);
  return self.origin + var_4 + (0, 0, var_3);
}

func_358F(var_0) {
  var_1 = undefined;
  if(var_0 == "left") {
    var_1 = "j_clavicle_track_le";
  } else {
    var_1 = "j_clavicle_track_ri";
  }

  var_2 = self gettagorigin(var_1);
  return var_2;
}

func_358C(var_0, var_1) {
  var_2 = undefined;
  if(var_1 == "left") {
    var_2 = "j_clavicle_track_le";
  } else {
    var_2 = "j_clavicle_track_ri";
  }

  var_3 = self gettagorigin(var_2);
  var_4 = self.origin;
  var_5 = var_3 - var_4;
  var_5 = (var_5[0], var_5[1], 0);
  var_6 = rotatevectorinverted(var_5, self.angles);
  var_7 = vectortoangles(var_6);
  return angleclamp180(var_7[1]);
}

func_358B(var_0) {
  var_1 = undefined;
  if(var_0 == "left") {
    var_1 = "j_clavicle_track_le";
  } else {
    var_1 = "j_clavicle_track_ri";
  }

  var_2 = self gettagorigin(var_1);
  var_3 = func_358D(var_0);
  var_4 = var_2 - var_3;
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = rotatevectorinverted(var_4, self.angles);
  var_6 = vectortoangles(var_5);
  return angleclamp180(var_6[1]);
}

func_357F(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_2 = lib_0A1E::func_2356("aimset_" + var_0, "arm_rail");
    var_1 = self getscoreinfocategory(var_2);
  }

  var_3 = func_3628(var_0, "rail", "min");
  var_4 = func_3628(var_0, "rail", "max");
  var_5 = var_4 - var_3;
  var_6 = var_3 + var_1 * var_5;
  return var_6;
}

func_3581(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_2 = lib_0A1E::func_2356("aimset_" + var_0, "arm_pitch");
    var_1 = self getscoreinfocategory(var_2);
  }

  var_3 = func_3628(var_0, "pitch", "min");
  var_4 = func_3628(var_0, "pitch", "max");
  var_5 = var_4 - var_3;
  var_6 = var_3 + var_1 * var_5;
  return var_6;
}

func_3590(var_0) {
  var_1 = undefined;
  if(var_0 == "left") {
    var_1 = "j_clavicle_track_le";
  } else {
    var_1 = "j_clavicle_track_ri";
  }

  var_2 = self gettagorigin(var_1);
  var_3 = var_2 - self.origin;
  return length2d(var_3);
}

func_3591(var_0) {
  var_1 = undefined;
  if(var_0 == "left") {
    var_1 = "j_clavicle_track_le";
  } else {
    var_1 = "j_clavicle_track_ri";
  }

  var_2 = self gettagorigin(var_1);
  return var_2[2] - self.origin[2];
}

func_358E(var_0, var_1) {
  var_2 = undefined;
  if(var_1 == "left") {
    var_2 = "j_clavicle_x_le";
  } else {
    var_2 = "j_clavicle_x_ri";
  }

  var_3 = self gettagangles(var_2);
  var_4 = anglestoright(var_3);
  var_5 = rotatevectorinverted(var_4, self.angles);
  var_6 = vectortoangles(var_5);
  return angleclamp180(var_6[0]);
}

func_351F(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * var_3 - var_1 * var_1;
  var_5 = 180 - var_0;
  var_6 = 180 - var_2;
  var_7 = -0.5 * var_4 / var_3 * cos(var_6) - var_1 * cos(var_5);
  return var_7;
}

func_3603(var_0) {
  var_1 = self.asm.var_11B08;
  var_2 = 0;
  if(var_0 == "left") {
    var_2 = 90;
  } else {
    var_2 = -90;
  }

  var_1.var_DCCF[var_0] = [];
  var_1.var_DCCF[var_0]["rail"] = [];
  var_3 = lib_0A1E::func_2356("aimset_" + var_0, "arm_rail");
  self give_attacker_kill_rewards(var_3, 1, 0, 0);
  wait(0.1);
  var_4 = func_3591(var_0);
  var_1.var_DCCF[var_0]["rail"]["height"] = var_4;
  var_5 = func_358F(var_0);
  var_6 = func_358C(var_3, var_0);
  var_7 = func_3590(var_0);
  self _meth_82B0(var_3, 1);
  wait(0.1);
  var_8 = func_358F(var_0);
  var_9 = func_358C(var_3, var_0);
  var_0A = func_3590(var_0);
  var_0B = func_351F(var_6, var_7, var_9, var_0A);
  var_1.var_DCCF[var_0]["rail"]["center_offset"] = var_0B;
  var_0C = func_358D(var_0);
  var_0D = distance(var_5, var_0C);
  var_0E = distance(var_8, var_0C);
  var_1.var_DCCF[var_0]["rail"]["radius"] = var_0D + var_0E * 0.5;
  self _meth_82B0(var_3, 0);
  wait(0.1);
  var_1.var_DCCF[var_0]["rail"]["min"] = func_358B(var_0);
  self _meth_82B0(var_3, 1);
  wait(0.1);
  var_1.var_DCCF[var_0]["rail"]["max"] = func_358B(var_0);
  var_1.var_DCCF[var_0]["rail"]["rate"] = 0.05 * abs(var_1.var_DCCF[var_0]["rail"]["max"] - var_1.var_DCCF[var_0]["rail"]["min"]) / getanimlength(var_3);
  if(var_0 == "left") {
    func_3608(var_3, var_0, "rail", 90);
  } else {
    func_3608(var_3, var_0, "rail", -90);
  }

  var_3 = lib_0A1E::func_2356("aimset_" + var_0, "arm_pitch");
  self give_attacker_kill_rewards(var_3, 1, 0, 0);
  wait(0.05);
  var_1.var_DCCF[var_0]["pitch"] = [];
  var_1.var_DCCF[var_0]["pitch"]["min"] = func_358E(var_3, var_0);
  self _meth_82B0(var_3, 1);
  wait(0.1);
  var_1.var_DCCF[var_0]["pitch"]["max"] = func_358E(var_3, var_0);
  var_1.var_DCCF[var_0]["pitch"]["rate"] = 0.05 * abs(var_1.var_DCCF[var_0]["pitch"]["max"] - var_1.var_DCCF[var_0]["pitch"]["min"]) / getanimlength(var_3);
  var_0F = 0;
  self _meth_82B0(var_3, 0);
  self _meth_82B1(var_3, 1);
  while(var_0F < 8) {
    var_10 = undefined;
    if(var_0 == "left") {
      var_10 = "j_clavicle_x_le";
    } else {
      var_10 = "j_clavicle_x_ri";
    }

    var_11 = func_358E(var_3, var_0);
    var_12 = self getscoreinfocategory(var_3);
    var_13 = self gettagangles(var_10);
    func_3547(anglestoaxis(var_13), self gettagorigin(var_10));
    wait(0.05);
    var_0F = var_0F + 0.05;
  }

  self _meth_82B1(var_3, 0);
  func_3608(var_3, var_0, "pitch", 0);
}

func_3585(var_0) {
  var_1 = undefined;
  if(var_0 == "left") {
    var_1 = "tag_weapon_rotate_le";
  } else {
    var_1 = "tag_weapon_rotate_ri";
  }

  return self gettagangles(var_1);
}

func_3587(var_0) {
  var_1 = undefined;
  if(var_0 == "left") {
    var_1 = "tag_weapon_rotate_le";
  } else {
    var_1 = "tag_weapon_rotate_ri";
  }

  return self gettagorigin(var_1);
}

func_3586(var_0) {
  var_1 = undefined;
  if(var_0 == "left") {
    var_1 = "j_weaponshoulder_x_le";
  } else {
    var_1 = "j_weaponshoulder_x_ri";
  }

  return self gettagorigin(var_1);
}

func_3588(var_0) {
  var_1 = undefined;
  if(var_0 == "left") {
    var_1 = "j_weaponshoulder_le";
  } else {
    var_1 = "j_weaponshoulder_ri";
  }

  return self gettagorigin(var_1);
}

func_3602(var_0) {
  wait(0.2);
  var_1 = self.asm.var_11B08;
  var_2 = lib_0A1E::func_2356("aimset_minigun", "aim_5");
  self give_attacker_kill_rewards(var_2, 0.01, 0, 1);
  wait(0.05);
  var_3 = func_3585(var_0);
  var_1.var_DCCF["main"]["minigun"]["yaw_delta"] = angleclamp180(var_3[1] - self.angles[1]);
  var_4 = func_3587(var_0);
  var_5 = func_3588(var_0);
  var_6 = func_3586(var_0);
  var_7 = vectornormalize(var_4 - var_6);
  var_8 = var_4 - var_5;
  var_9 = vectordot(var_7, var_8);
  var_1.var_DCCF["main"]["minigun"]["pitch_offset"] = distance(var_5, var_6);
  var_0A = lib_0A1E::func_2356("aimset_minigun", "aim_2");
  self give_attacker_kill_rewards(var_0A, 1, 0, 1, 0);
  wait(0.1);
  var_4 = func_3587(var_0);
  var_6 = func_3586(var_0);
  var_0B = var_4 - var_6;
  var_0C = var_0B[2];
  var_1.var_DCCF["main"]["minigun"][2] = 0 - asin(var_0C / length(var_0B));
  self clearanim(var_0A, 0);
  var_0D = lib_0A1E::func_2356("aimset_minigun", "aim_8");
  self give_attacker_kill_rewards(var_0D, 1, 0, 1, 0);
  wait(0.1);
  var_4 = func_3587(var_0);
  var_6 = func_3586(var_0);
  var_0B = var_4 - var_6;
  var_0C = var_0B[2];
  var_1.var_DCCF["main"]["minigun"][8] = 0 - asin(var_0C / length(var_0B));
  self clearanim(var_0D, 0);
  var_0E = anglestoright(self.angles);
  var_0F = lib_0A1E::func_2356("aimset_minigun", "aim_4");
  self give_attacker_kill_rewards(var_0F, 1, 0, 1, 0);
  wait(0.1);
  var_4 = func_3587(var_0);
  var_6 = func_3586(var_0);
  var_0B = var_4 - var_6;
  var_10 = vectordot(var_0B, var_0E) * -1;
  var_1.var_DCCF["main"]["minigun"][4] = asin(var_10 / length(var_0B));
  self clearanim(var_0F, 0);
  var_11 = lib_0A1E::func_2356("aimset_minigun", "aim_6");
  self give_attacker_kill_rewards(var_11, 1, 0, 1, 0);
  wait(0.1);
  var_4 = func_3587(var_0);
  var_6 = func_3586(var_0);
  var_0B = var_4 - var_6;
  var_10 = vectordot(var_0B, var_0E) * -1;
  var_1.var_DCCF["main"]["minigun"][6] = asin(var_10 / length(var_0B));
  self clearanim(var_11, 0);
  var_12 = lib_0A1E::func_2356("aimset_minigun", "aim_knob_28");
  self clearanim(var_12, 0);
  var_13 = lib_0A1E::func_2356("aimset_minigun", "aim_knob_46");
  self clearanim(var_13, 0);
}

func_3594(var_0, var_1) {
  var_2 = undefined;
  if(var_0 == "left") {
    if(var_1 == "top") {
      var_2 = "tag_missile_top_le";
    } else {
      var_2 = "tag_missile_bottom_le";
    }
  } else if(var_1 == "top") {
    var_2 = "tag_missile_top_ri";
  } else {
    var_2 = "tag_missile_bottom_ri";
  }

  return var_2;
}

func_3593(var_0, var_1) {
  var_2 = func_3594(var_0, var_1);
  return self gettagorigin(var_2);
}

func_3592(var_0, var_1) {
  var_2 = func_3594(var_0, var_1);
  return self gettagangles(var_2);
}

func_3605(var_0) {
  wait(0.2);
  var_1 = func_3592(var_0, "top");
  self.asm.var_11B08.var_DCCF["main"]["rocket"]["yaw_delta"] = angleclamp180(var_1[1] - self.angles[1]);
  self.asm.var_11B08.var_DCCF["main"]["rocket"]["pitch_delta"] = -1 * var_1[0];
}

func_3601() {
  func_3603("left");
  func_3602("left");
}

func_3604() {
  func_3603("right");
  func_3605("right");
}

func_35A7() {
  var_0 = 0.3;
  var_1 = 0.2;
  var_2 = lib_0A1E::func_2356("aim_body", "hexapod");
  func_3608(var_2, "main", "hex", 0, var_0);
  var_2 = lib_0A1E::func_2356("aimset_left", "arm_rail");
  func_3608(var_2, "left", "rail", 100, var_0);
  var_2 = lib_0A1E::func_2356("aimset_left", "arm_pitch");
  func_3608(var_2, "left", "pitch", 0, var_0);
  var_2 = lib_0A1E::func_2356("aimset_right", "arm_rail");
  func_3608(var_2, "right", "rail", -100, var_0);
  var_2 = lib_0A1E::func_2356("aimset_right", "arm_pitch");
  func_3608(var_2, "right", "pitch", 0, var_0);
  var_3 = func_358A();
  thread func_3632(var_3, var_0, var_1);
  self.asm.var_11B08.btracking = 1;
}

func_3632(var_0, var_1, var_2) {
  self endon("death");
  self give_attacker_kill_rewards(var_0, 5, var_1, 1);
  wait(var_1);
  if(!self.asm.var_11B08.btracking) {
    return;
  }

  self give_attacker_kill_rewards(var_0, 15, var_2);
  wait(var_2);
  if(!self.asm.var_11B08.btracking) {
    return;
  }

  self give_attacker_kill_rewards(var_0, 1000, 1);
}

func_3529() {
  var_0 = func_358A();
  self clearanim(var_0, 0.2);
  self.asm.var_11B08.btracking = 0;
}

func_3582() {
  var_0 = self._blackboard.shootparams;
  var_1 = lib_0C42::func_3518("left");
  var_2 = lib_0C42::func_3518("right");
  if(var_1 && var_2) {
    var_3 = func_3595("left");
    var_4 = func_3595("right");
    if(isDefined(var_3) && isDefined(var_4)) {
      var_5 = 0.5 * var_3 + var_4;
      if(distancesquared(var_5, self.origin) < 10000 && distancesquared(var_3, var_4) > 0) {
        var_6 = scripts\engine\utility::flatten_vector(var_3 - self.origin);
        var_7 = scripts\engine\utility::flatten_vector(var_4 - self.origin);
        var_8 = vectortoyaw(var_6);
        var_9 = vectortoyaw(var_7);
        var_0A = angleclamp180(var_8 + var_9 * 0.5);
        var_0B = anglesToForward((0, var_0A, 0));
        var_5 = self.origin + var_0B * 256;
      }

      return var_5;
    } else if(isDefined(var_4)) {
      return var_4;
    } else if(isDefined(var_5)) {
      return var_5;
    }
  }

  if(var_2) {
    return func_3595("left");
  } else {
    return func_3595("right");
  }

  return undefined;
}

func_3595(var_0, var_1) {
  var_2 = self._blackboard.shootparams;
  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = var_2.var_13CC3[var_0];
  if(!isDefined(var_3)) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!var_1 && !var_3.var_312A) {
    return undefined;
  }

  if(isDefined(var_3.var_1A46) && var_3.var_1A47 != gettime()) {
    var_4 = 0;
    if(lib_0C08::func_A007(var_0, "rocket")) {
      var_4 = 1;
    }

    return lib_0C08::func_FE67(var_3, var_4);
  }

  return var_4.var_1A46;
}

func_351E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self._blackboard.shootparams;
  var_6 = func_3595(var_0);
  if(!isDefined(var_6)) {
    var_4.var_B7A9 = 0;
    var_4.var_B7A6 = 0;
    return;
  }

  var_7 = func_3588(var_0);
  var_8 = func_357F(var_0, var_2);
  if(var_0 == "left") {
    var_8 = var_8 - 90;
  } else {
    var_8 = var_8 + 90;
  }

  if(!isDefined(var_1)) {
    var_1 = func_357E();
  }

  var_9 = anglestoaxis(self.angles + (0, var_1 + var_8, 0));
  var_0A = var_6 - var_7;
  var_0B = vectordot(var_0A, var_9["right"]) * -1;
  var_0C = vectordot(var_0A, var_9["up"]);
  var_0D = var_0A - var_0C * var_9["up"];
  var_0E = length(var_0D);
  var_0F = var_0A + var_0B * var_9["right"];
  var_10 = length(var_0F);
  var_11 = clamp(func_3628("main", "minigun", "pitch_offset") / var_10, -1, 1);
  var_12 = 90 - acos(var_11);
  var_13 = clamp(var_0B / var_0E, -1, 1);
  var_4.var_B7A9 = asin(var_13) - func_3628("main", "minigun", "yaw_delta");
  var_13 = clamp(var_0C / var_10, -1, 1);
  var_4.var_B7A6 = -1 * asin(var_13) - func_3581(var_0, var_3) + var_12;
}

func_3521(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 - var_3;
  var_5 = (var_5[0], var_5[1], 0);
  var_6 = length(var_5);
  if(var_4 > var_6) {
    var_7 = -90;
    if(var_0 == "right") {
      var_7 = 90;
    }
  } else {
    var_6 = var_6 / var_7;
    var_8 = anglesToForward((0, var_3 + self.angles[1], 0));
    var_7 = acos(var_4 / var_6);
    var_9 = vectordot(var_5, var_8);
    if(var_0 == "right") {
      var_7 = -1 * var_7;
    }

    if(-1 < var_9 && var_9 < 1) {
      var_0A = vectorcross(var_5, var_8);
      if(var_0A[2] > 0) {
        var_7 = var_7 - acos(var_9);
      } else {
        var_7 = var_7 + acos(var_9);
      }
    }
  }

  return var_7;
}

func_3520(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self.angles + (0, var_5 + var_2, 0);
  var_7 = anglesToForward(var_6);
  var_8 = var_3 + var_4 * var_7;
  var_9 = var_1 - var_8;
  var_0A = var_9[2];
  var_0B = clamp(var_0A / length(var_9), -1, 1);
  var_0C = asin(var_0B);
  return -1 * var_0C;
}

func_3522(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = spawnStruct();
  var_3 = func_3582();
  if(isDefined(var_3)) {
    var_4 = var_3 - self.origin;
    var_5 = rotatevectorinverted(var_4, self.angles);
    var_6 = vectortoyaw(var_5);
    var_2.var_8E55 = angleclamp180(var_6);
  } else {
    var_2.var_8E55 = 0;
  }

  if(func_9E4D()) {
    var_8 = func_3583();
  } else {
    var_8 = func_357E(var_1.var_8E54);
  }

  var_9 = func_3595("left");
  if(isDefined(var_9)) {
    var_0A = func_3580("left", var_8);
    var_0B = func_3628("left", "rail", "radius");
    var_2.var_AB57 = func_3521("left", var_9, var_8, var_0A, var_0B);
    var_2.var_AB56 = func_3520("left", var_9, var_8, var_0A, var_0B, var_2.var_AB57);
    if(self.var_13CC3["left"] == "minigun") {
      func_351E("left", var_8, var_0.var_AB57, var_0.var_AB56, var_2);
    } else if(self.var_13CC3["left"] == "rocket") {
      var_2.var_AB57 = var_2.var_AB57 + func_3628("main", "rocket", "yaw_delta");
      var_2.var_AB56 = var_2.var_AB56 + func_3628("main", "rocket", "pitch_delta");
      if(isDefined(self.var_E5C4)) {
        var_2.var_AB56 = var_2.var_AB56 - self.var_E5C4;
      }
    }
  } else {
    var_2.var_AB57 = 90;
    var_2.var_AB56 = 0;
  }

  var_0C = func_3595("right");
  if(isDefined(var_0C)) {
    var_0A = func_3580("right", var_8);
    var_0B = func_3628("right", "rail", "radius");
    var_2.var_E530 = func_3521("right", var_0C, var_8, var_0A, var_0B);
    var_2.var_E52F = func_3520("right", var_0C, var_8, var_0A, var_0B, var_2.var_E530);
    if(self.var_13CC3["right"] == "minigun") {
      func_351E("right", var_8, var_0.var_E530, var_0.var_E52F, var_2);
    } else if(self.var_13CC3["right"] == "rocket") {
      var_2.var_E530 = var_2.var_E530 - func_3628("main", "rocket", "yaw_delta");
      var_2.var_E52F = var_2.var_E52F + func_3628("main", "rocket", "pitch_delta");
      if(isDefined(self.var_E5C4)) {
        var_2.var_E52F = var_2.var_E52F - self.var_E5C4;
      }
    }
  } else {
    var_2.var_E530 = -90;
    var_2.var_E52F = 0;
  }

  return var_2;
}

func_3630() {
  func_3574();
  var_0 = 0.75;
  thread func_3631(var_0);
}

func_3631(var_0) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_1 = lib_0A1E::func_2356("aim_body", "hexapod");
  self clearanim(var_1, var_0);
  var_1 = lib_0A1E::func_2356("aimset_left", "arm_rail");
  self clearanim(var_1, var_0);
  var_1 = lib_0A1E::func_2356("aimset_left", "arm_pitch");
  self clearanim(var_1, var_0);
  var_1 = lib_0A1E::func_2356("aimset_right", "arm_rail");
  self clearanim(var_1, var_0);
  var_1 = lib_0A1E::func_2356("aimset_right", "arm_pitch");
  self clearanim(var_1, var_0);
  var_2 = func_358A();
  var_3 = self _meth_8103(var_2);
  var_4 = 2;
  if(var_3 <= var_4) {
    var_5 = min(var_0, 0.2 * var_3 / var_4);
    self clearanim(var_2, var_5);
    return;
  }

  while(var_4 > var_5) {
    self give_attacker_kill_rewards(var_3, var_4 * 0.5, 0.05);
    wait(0.05);
    if(self.asm.var_11B08.btracking) {
      break;
    }

    var_1 = var_1 - 0.05;
    var_4 = self _meth_8103(var_3);
  }

  if(!self.asm.var_11B08.btracking) {
    self clearanim(var_3, var_1);
  }
}

func_3574() {
  var_0 = lib_0A1E::func_2356("aim_body", "hexapod");
  self _meth_82B1(var_0, 0);
  var_0 = lib_0A1E::func_2356("aimset_left", "arm_rail");
  self _meth_82B1(var_0, 0);
  var_0 = lib_0A1E::func_2356("aimset_left", "arm_pitch");
  self _meth_82B1(var_0, 0);
  var_0 = lib_0A1E::func_2356("aimset_right", "arm_rail");
  self _meth_82B1(var_0, 0);
  var_0 = lib_0A1E::func_2356("aimset_right", "arm_pitch");
  self _meth_82B1(var_0, 0);
}

func_363C() {
  var_0 = lib_0A1E::func_2356("aim_body", "hexapod");
  func_3607(var_0, undefined, "main", "hex", 0, 6);
  var_0 = lib_0A1E::func_2356("aimset_left", "arm_rail");
  func_3607(var_0, undefined, "left", "rail", 100, 8);
  var_0 = lib_0A1E::func_2356("aimset_left", "arm_pitch");
  func_3607(var_0, undefined, "left", "pitch", 0, 8);
  var_0 = lib_0A1E::func_2356("aimset_right", "arm_rail");
  func_3607(var_0, undefined, "right", "rail", -100, 8);
  var_0 = lib_0A1E::func_2356("aimset_right", "arm_pitch");
  func_3607(var_0, undefined, "right", "pitch", 0, 8);
}

func_3608(var_0, var_1, var_2, var_3, var_4) {
  var_5 = func_3628(var_1, var_2, "min");
  var_6 = func_3628(var_1, var_2, "max");
  var_7 = var_6 - var_5;
  if(var_5 < var_6) {
    var_3 = clamp(angleclamp180(var_3), var_5, var_6);
  } else {
    var_3 = clamp(angleclamp180(var_3), var_6, var_5);
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_8 = var_3 - var_5 / var_7;
  var_8 = clamp(var_8, 0, 1);
  self give_attacker_kill_rewards(var_0, 1, var_4, 0);
  self _meth_82B0(var_0, var_8);
}

func_3607(var_0, var_1, var_2, var_3, var_4, var_5) {
  self give_attacker_kill_rewards(var_0, 1, 0, 0);
  var_6 = func_3628(var_2, var_3, "min");
  var_7 = func_3628(var_2, var_3, "max");
  var_8 = var_7 - var_6;
  if(var_6 < var_7) {
    var_4 = clamp(var_4, var_6, var_7);
  } else {
    var_4 = clamp(var_4, var_7, var_6);
  }

  var_9 = var_4 - var_6 / var_8;
  var_9 = clamp(var_9, 0, 1);
  if(!isDefined(var_1)) {
    var_1 = self getscoreinfocategory(var_0);
  }

  var_0A = var_6 + var_1 * var_8;
  var_0B = abs(var_4 - var_0A);
  if(var_0B > var_5) {
    var_0B = var_5;
  }

  if(-0.002 < var_0B && var_0B < 0.002) {
    var_0B = 0;
    self _meth_82B0(var_0, var_9);
  }

  var_0C = 1;
  if(var_9 < var_1) {
    var_0C = -1;
  }

  var_0D = func_3628(var_2, var_3, "rate");
  self _meth_82B1(var_0, var_0C * var_0B / var_0D);
}

func_360B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;
  var_0A = 0;
  var_0B = 0;
  var_0C = 0;
  var_0D = 0.1;
  self give_attacker_kill_rewards(var_4, 0.01, 0, 1);
  if(var_0 > 0) {
    var_0A = var_0 / func_3628("main", "minigun", 4);
    var_0A = clamp(var_0A, 0, 1);
    self clearanim(var_5, var_0D);
    self give_attacker_kill_rewards(var_3, 1, var_0D);
    self give_attacker_kill_rewards(var_8, var_0A, var_0D);
  } else if(var_0 < 0) {
    var_0B = var_0 / func_3628("main", "minigun", 6);
    var_0B = clamp(var_0B, 0, 1);
    self clearanim(var_3, var_0D);
    self give_attacker_kill_rewards(var_5, 1, var_0D);
    self give_attacker_kill_rewards(var_8, var_0B, var_0D);
  }

  if(var_1 > 0) {
    var_9 = var_1 / func_3628("main", "minigun", 2);
    var_9 = clamp(var_9, 0, 1);
    self clearanim(var_6, var_0D);
    self give_attacker_kill_rewards(var_2, 1, var_0D);
    self give_attacker_kill_rewards(var_7, var_9, var_0D);
    return;
  }

  if(var_1 < 0) {
    var_0C = var_1 / func_3628("main", "minigun", 8);
    var_0C = clamp(var_0C, 0, 1);
    self clearanim(var_2, var_0D);
    self give_attacker_kill_rewards(var_6, 1, var_0D);
    self give_attacker_kill_rewards(var_7, var_0C, var_0D);
  }
}

func_362C() {
  var_0 = lib_0A1E::func_2356("aim_body", "hexapod");
  var_1 = lib_0A1E::func_2356("aimset_left", "arm_rail");
  var_2 = lib_0A1E::func_2356("aimset_left", "arm_pitch");
  var_3 = lib_0A1E::func_2356("aimset_right", "arm_rail");
  var_4 = lib_0A1E::func_2356("aimset_right", "arm_pitch");
  var_5 = lib_0A1E::func_2356("aimset_minigun", "aim_2");
  var_6 = lib_0A1E::func_2356("aimset_minigun", "aim_4");
  var_7 = lib_0A1E::func_2356("aimset_minigun", "aim_6");
  var_8 = lib_0A1E::func_2356("aimset_minigun", "aim_8");
  var_9 = lib_0A1E::func_2356("aimset_minigun", "aim_5");
  var_0A = lib_0A1E::func_2356("aimset_minigun", "aim_knob_28");
  var_0B = lib_0A1E::func_2356("aimset_minigun", "aim_knob_46");
  var_0C = func_358A();
  var_0D = 0;
  var_0E = 0;
  var_0F = 6;
  var_10 = spawnStruct();
  for(;;) {
    var_11 = scripts\asm\asm::func_231B(self.asm.var_11AC7, "aim");
    if(isDefined(self._blackboard.var_E5F9)) {
      var_11 = 0;
    } else if(isDefined(self._blackboard.rodeorequested)) {
      var_11 = 1;
    }

    if(var_11) {
      if(!self.asm.var_11B08.btracking) {
        func_35A7();
      }

      if(isDefined(self._blackboard.rodeorequested)) {
        if(!self.asm.var_11B08.var_30E6) {
          self.asm.var_11B08.var_30E6 = 1;
          thread lib_0C47::func_351B();
          func_3608(var_0, "main", "hex", 0);
        }
      } else if(isDefined(self._blackboard.shootparams) && self.var_13C83["left"] || self.var_13C83["right"]) {
        var_10.var_8E54 = self getscoreinfocategory(var_0);
        var_10.var_AB57 = self getscoreinfocategory(var_1);
        var_10.var_E530 = self getscoreinfocategory(var_3);
        var_10.var_AB56 = self getscoreinfocategory(var_2);
        var_10.var_E52F = self getscoreinfocategory(var_4);
        var_12 = func_3522(var_10);
        self give_attacker_kill_rewards(var_0C, 1000, 0.1, 1);
        func_3607(var_0, var_10.var_8E54, "main", "hex", var_12.var_8E55, 6 * self.var_1A48);
        if(isDefined(var_12.var_AB57)) {
          func_3607(var_1, var_10.var_AB57, "left", "rail", var_12.var_AB57, 8 * self.var_1A48);
        }

        if(isDefined(var_12.var_AB56)) {
          func_3607(var_2, var_10.var_AB56, "left", "pitch", var_12.var_AB56, 8 * self.var_1A48);
        }

        if(isDefined(var_12.var_E530)) {
          func_3607(var_3, var_10.var_E530, "right", "rail", var_12.var_E530, 8 * self.var_1A48);
        }

        if(isDefined(var_12.var_E52F)) {
          func_3607(var_4, var_10.var_E52F, "right", "pitch", var_12.var_E52F, 8 * self.var_1A48);
        }

        if(isDefined(var_12.var_B7A9) && isDefined(var_12.var_B7A6)) {
          var_13 = var_12.var_B7A9;
          var_14 = var_12.var_B7A6;
          var_15 = var_0D - var_13;
          var_16 = var_0E - var_14;
          if(var_15 > var_0F) {
            var_13 = var_0D - var_0F;
          } else if(var_15 < -1 * var_0F) {
            var_13 = var_0D + var_0F;
          }

          if(var_16 > var_0F) {
            var_14 = var_0E - var_0F;
          } else if(var_16 < -1 * var_0F) {
            var_14 = var_0E + var_0F;
          }

          func_360B(var_13, var_14, var_5, var_6, var_9, var_7, var_8, var_0A, var_0B);
          var_0D = var_12.var_B7A9;
          var_0E = var_12.var_B7A6;
        }
      } else {
        func_363C();
        var_0D = 0;
        var_0E = 0;
      }
    } else if(self.asm.var_11B08.btracking) {
      func_3630();
      var_0D = 0;
      var_0E = 0;
      self.asm.var_11B08.btracking = 0;
    }

    wait(0.05);
  }
}

func_FE84(var_0, var_1, var_2) {
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

func_35D3(var_0, var_1, var_2) {
  var_3 = var_0 + "_finished";
  var_4 = var_0 + "_waitfor_note";
  thread func_FE84(var_4, var_3, var_2);
  self endon(var_3);
  self endon(var_4);
  self waittillmatch(var_1, var_0);
}

func_35D6(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = self._blackboard.shootparams;
  var_6 = self.var_164D[var_0].slot;
  var_7 = var_5.var_13CC3[var_6];
  self.var_164D[var_0].var_4C1A = var_7;
  if(var_6 == "left") {
    var_8 = self.secondaryweapon;
  } else {
    var_8 = self.primaryweapon;
  }

  var_9 = var_7.var_C241;
  var_0A = [];
  if(isDefined(var_7.var_EF76)) {
    foreach(var_0C in var_7.var_EF76) {
      var_0A[var_0A.size] = var_0C;
    }
  } else {
    var_0A[0] = var_7.ent;
  }

  if(var_0A.size == 0) {
    wait(1);
    scripts\asm\asm::asm_fireevent(var_1, "end");
    return;
  }

  var_0E = ["top", "bottom"];
  if(isDefined(self._blackboard.scriptableparts)) {
    var_0F = self._blackboard.scriptableparts[var_6 + "_arm"];
    if(isDefined(var_0F)) {
      if(var_0F.state == "dmg_upper") {
        var_0E = ["bottom"];
      }

      if(var_0F.state == "dmg_lower") {
        var_0E = ["top"];
      }
    }
  }

  var_10 = getnotetracktimes(var_4, "fire");
  var_11 = var_10.size > 0;
  var_12 = lib_0C08::func_FE67(var_7, 1);
  var_7.var_E5E0 = var_12;
  var_13 = [];
  foreach(var_15, var_0C in var_0A) {
    var_13[var_15] = var_0C.origin;
  }

  thread func_35E9(var_6, var_0E[0], var_12, var_7.var_DCE8 * var_9, var_1 + "_finished");
  self waittill("rocket_ready");
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  thread func_360F(var_1);
  var_16 = 0;
  var_17 = 0;
  while(var_16 < var_9) {
    if(isDefined(var_7.var_E5E0) || isDefined(var_0A[var_17])) {
      if(var_16 == 0) {
        if(var_16 < var_10.size) {
          func_35D3(var_1, "fire", 1);
        } else {
          wait(0.1);
        }
      } else {
        wait(var_7.var_DCE8 / 1000);
      }

      var_18 = var_16 == 0;
      if(func_3615(var_6, var_7, var_18)) {
        func_3509(var_7);
        break;
      }

      var_19 = int(var_16 / 4) % 2;
      var_1A = func_3593(var_6, var_0E[var_19]);
      var_1B = func_3592(var_6, var_0E[var_19]);
      var_1C = anglesToForward(var_1B);
      if(var_6 == "left") {
        var_1D = self.secondaryweapon;
      } else {
        var_1D = self.primaryweapon;
      }

      if(scripts\sp\utility::func_93A6() || level.var_7683 == 2 && isDefined(self.var_32D5) && self.var_32D5) {
        var_1D = "iw7_c12rocket_specialist_mode";
      }

      var_1E = magicbullet(var_1D, var_1A, var_13[var_17]);
      playFXOnTag(level.var_7649["muz_c12_rocket"], self, func_3594(var_6, var_0E[var_19]));
      if(isDefined(self.var_11B06)) {
        func_362D(var_1E);
      }

      if(isDefined(var_7.var_E5E0)) {
        var_1E.var_1155F = var_0A[var_17];
        var_1E missile_settargetpos(var_13[var_17]);
      } else if(isDefined(var_0A[var_17])) {
        var_1E.var_1155F = var_0A[var_17];
        var_1E missile_settargetent(var_0A[var_17]);
      }

      var_16++;
    }

    var_17 = var_17 + 1 % var_0A.size;
  }

  wait(3);
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

func_3635(var_0, var_1, var_2) {
  var_3 = 4;
  var_4 = 360 / var_3;
  var_5 = 45;
  var_6 = 9;
  var_7 = self gettagorigin(var_0);
  var_8 = self gettagangles(var_0);
  var_9 = invertangles(var_8);
  var_0A = combineangles(var_8, (0, 0, -90 * 1 - var_2));
  for(var_0B = 0; var_0B < var_3; var_0B++) {
    var_0C = self.var_E5DB[var_0B];
    var_0D = var_0B + 0.5 * var_4;
    var_0E = var_6 * (0, cos(var_0D), sin(var_0D));
    var_0F = var_7 + rotatevector(var_0E, var_8);
    var_10 = var_5 * (-1 * sin(var_0D), cos(var_0D), 0);
    var_11 = vectortoangles(var_1 - var_0F);
    var_12 = combineangles(var_9, var_11);
    var_13 = anglelerpquatfrac(var_10, var_12, var_2);
    var_13 = combineangles(var_0A, var_13);
    var_0C.origin = var_0F;
    var_0C.angles = var_13;
  }
}

func_35E9(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_4);
  var_5 = func_3594(var_0, var_1);
  var_6 = 4;
  var_7 = 360 / var_6;
  var_8 = 45;
  var_9 = 9;
  var_0A = 1;
  var_0B = var_3 / 1000;
  var_0C = var_0A + level.var_35EC + var_0B;
  createnavrepulsor("c12_rocket", var_0C, var_2, 256, 1);
  self notify("rocket_targeting");
  lib_0A16::func_17BA("targeting");
  self _meth_857A("target", var_2);
  self.var_E5DB = [];
  for(var_0D = 0; var_0D < var_6; var_0D++) {
    var_0E = spawn("script_model", (0, 0, 0));
    self.var_E5DB[var_0D] = var_0E;
    var_0E setModel("tag_flash");
    var_0E _meth_81D6();
    var_0E setotherent(self);
    var_0E _meth_8575(self.secondaryweapon);
  }

  func_3635(var_5, var_2, 0);
  foreach(var_0E in self.var_E5DB) {
    var_0E linkto(self, var_5);
  }

  wait(var_0A);
  wait(level.var_35EC);
  self notify("rocket_ready");
  var_11 = int(var_0B * 20);
  while(var_11 > 0) {
    if(!isDefined(self.var_E5DB)) {
      return;
    }

    var_11--;
    scripts\engine\utility::waitframe();
  }

  func_35EB();
}

func_35EB() {
  if(isDefined(self.var_E5DB)) {
    self _meth_857A("none");
    foreach(var_1 in self.var_E5DB) {
      var_1 _meth_81D5();
      var_1 delete();
    }

    self.var_E5DB = undefined;
  }
}

func_35EA(var_0) {
  var_0.var_E5E0 = undefined;
  destroynavrepulsor("c12_rocket");
  func_35EB();
}

func_362D(var_0) {
  if(!isDefined(self.var_6D6C)) {
    self.var_6D6C = [];
  }

  var_1 = [];
  foreach(var_3 in self.var_6D6C) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  var_1[var_1.size] = var_0;
  self.var_6D6C = var_1;
  self notify("rocket_fired", var_0);
  var_1 = undefined;
}

func_360F(var_0) {
  self endon(var_0 + "_finished");
  for(;;) {
    self waittill(var_0, var_1);
    if(!isarray(var_1)) {
      var_1 = [var_1];
    }

    foreach(var_3 in var_1) {
      if(var_3 == "end") {
        scripts\asm\asm::asm_fireevent(var_0, var_3);
        return;
      }
    }
  }
}

func_35D5(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = self._blackboard.shootparams;
  var_6 = self.var_164D[var_0].slot;
  var_7 = var_5.var_13CC3[var_6];
  var_8 = var_7.var_32BC;
  var_9 = var_7.var_DCE8;
  var_0A = 1.5;
  self give_attacker_kill_rewards(var_4, 1, var_2, var_0A);
  var_0B = lib_0A1E::func_2356(var_1, "recoil");
  self give_attacker_kill_rewards(var_0B, 1, var_2, 1);
  var_0C = gettime();
  var_0D = var_0C;
  var_0E = var_0C + var_9;
  self.var_164D[var_0].var_4C1A = var_7;
  self playSound("weap_c12_minigun_spinup");
  self playLoopSound("weap_c12_minigun_fire");
  var_0F = lib_0C08::func_9F7B(var_6);
  while(var_0C < var_8) {
    if(func_3615(var_6, var_7, var_0F)) {
      func_3509(var_7);
      break;
    }

    if(var_0C >= var_0E) {
      if(lib_0C08::func_8BEC(var_7)) {
        var_10 = var_8 - var_0C < 0.05;
        func_35C5(var_6, var_10, var_0F);
      }

      var_0E = var_0E + var_9;
    }

    wait(0.05);
    var_0C = gettime();
  }
}

func_35C5(var_0, var_1, var_2) {
  var_3 = undefined;
  if(var_0 == "left") {
    var_4 = self.secondaryweapon;
    var_3 = "tag_weapon_rotate_le";
  } else {
    var_4 = self.primaryweapon;
    var_3 = "tag_weapon_rotate_ri";
  }

  var_5 = func_3587(var_0);
  var_6 = func_3585(var_0);
  var_7 = self._blackboard.shootparams.var_13CC3[var_0];
  var_8 = 1;
  var_9 = 0;
  if(var_7.var_29A1 && !var_2) {
    var_0A = undefined;
    if(isDefined(var_7.ent)) {
      var_0A = var_7.ent;
    } else if(isDefined(var_7.var_EF76)) {
      var_0A = var_7.var_EF76[0];
    }

    self _meth_8494(var_4, var_5, var_6, var_8, var_0A, var_9, var_1, var_3);
    return;
  }

  var_0B = func_3595(var_0, var_2);
  var_0C = bulletspread(var_5, var_0B, 4);
  self _meth_8494(var_4, var_5, var_6, var_8, var_0C, var_9, var_1, var_3);
}

func_3615(var_0, var_1, var_2) {
  var_3 = self._blackboard.shootparams;
  if(!isDefined(var_3)) {
    return 1;
  }

  var_4 = var_3.var_13CC3[var_0];
  if(!isDefined(var_4)) {
    return 1;
  }

  if(!lib_0C08::func_9F5B(var_0)) {
    return 1;
  }

  if(var_4 != var_1) {
    return 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!var_2 && !var_4.var_312A) {
    return 1;
  }

  if(isDefined(self.var_9DD2) && self.var_9DD2) {
    return 1;
  }

  return 0;
}

func_3509(var_0) {
  var_0.var_2720 = 1;
}

func_3612(var_0, var_1, var_2) {
  var_3 = lib_0A1E::func_2356(var_1, "loop");
  var_4 = lib_0A1E::func_2356(var_1, "recoil_knob");
  self clearanim(var_3, 0.2);
  self clearanim(var_4, 0.2);
  self shootstopsound();
  self stoploopsound();
  self playSound("weap_c12_minigun_release");
  var_5 = self.var_164D[var_0].var_4C1A;
  var_6 = self.var_164D[var_0].slot;
  if(isDefined(self.var_EF6F) && isDefined(var_5.var_EF76)) {
    self notify(var_5.var_EF6F);
  }

  self.var_164D[var_0].var_4C1A = undefined;
}

func_3613(var_0, var_1, var_2) {
  var_3 = lib_0A1E::func_2356(var_1, "shoot_knob");
  self clearanim(var_3, 0.2);
  var_4 = self.var_164D[var_0].slot;
  scripts\asm\asm::asm_fireephemeralevent("rocket_shoot_complete", var_4);
  var_5 = self.var_164D[var_0].var_4C1A;
  if(isDefined(var_5.var_EF77)) {
    self notify(var_5.var_EF77);
  }

  self.var_164D[var_0].var_4C1A = undefined;
  func_35EA(var_5);
}

func_35D4(var_0, var_1, var_2, var_3) {}

func_3526(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard.shootparams;
  var_5 = self.var_164D[var_0].slot;
  var_6 = var_4.var_13CC3[var_5];
  if(var_6.var_C241 == 1) {
    var_7 = var_5 + "_1";
  } else {
    var_7 = var_6 + "_4";
  }

  return lib_0A1E::func_2356(var_1, var_7);
}

func_3525(var_0, var_1, var_2, var_3) {
  var_4 = lib_0A1E::func_2356(var_1, "loop");
  return var_4;
}

func_3547(var_0, var_1) {}