/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1344.gsc
*********************************************/

lib_0540::func_00D5() {
  setdvarifuninitialized("debug_falling_zombies", 0);
}

lib_0540::func_A26F(param_00, param_01, param_02) {
  var_03 = param_00.var_A27C;
  var_04 = "";
  var_05 = 0;
  var_06 = 0;
  if(!isDefined(param_01)) {
    param_01 = "spawn_drop";
  }

  if(!isDefined(var_03)) {
    var_03 = spawnStruct();
    var_03.var_9919 = -1;
    var_03.var_0ED2 = [];
    var_03.var_0886 = [];
    param_00.var_A27C = var_03;
  }

  if(isDefined(var_03.var_0886[param_01])) {
    return var_03.var_0886[param_01];
  }

  var_07 = undefined;
  if(!isDefined(var_07)) {
    var_07 = 15;
  }

  var_08 = getgroundposition(param_00.var_0116, var_07, 64, 64);
  param_00.var_487C = var_08;
  if(!function_02E6(var_08)) {
    var_04 = "Sky Spawner not on Nav Mesh for entities of radius " + var_07 + "\n";
    var_09 = getclosestpointonnavmesh(var_08);
    var_05 = 1;
  }

  if(!var_05) {
    foreach(var_0B in maps\mp\agents\_scripted_agent_anim_util::func_4081(param_01, "ombie_generic", #animtree)) {
      var_0C = getanimname(var_0B);
      var_0D = maps\mp\agents\_scripted_agent_anim_util::func_446A(var_0B);
      if(!animhasnotetrack(var_0B, "jump_start") || !animhasnotetrack(var_0B, "jump_end")) {
        continue;
      }

      var_0E = maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_0B, "jump_end");
      if(var_0D <= var_0E) {}

      var_0F = getmovedelta(var_0B, var_0E, var_0D);
      var_10 = getangledelta(var_0B, var_0E, 0);
      var_0F = rotatevector(var_0F, (0, var_10, 0));
      var_11 = var_0F + var_08;
      if(function_02E6(var_11) && function_02DE(var_08, var_11)) {
        var_03.var_0ED2[var_0C] = 1;
        var_06++;
        continue;
      }

      var_04 = var_04 + var_0C + " does not fit on mesh for entities of radius " + var_07 + "\n";
    }
  }

  if(var_04 != "") {
    if(isDefined(param_02)) {
      var_04 = param_02 + "\n" + var_04;
    }
  }

  var_03.var_0886[param_01] = var_06 > 0;
  return var_03.var_0886[param_01];
}

lib_0540::func_ABA4(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon("death");
  if(!common_scripts\utility::func_562E(param_04.ignorehidingskyspawner) && common_scripts\utility::func_562E(level.st_142418)) {
    self method_805C();
    wait 0.05;
    self method_805B();
  }

  if(isDefined(param_04) && common_scripts\utility::func_562E(param_04.asssassinspawn)) {
    [[level.assassin_validation_func]](param_04, param_03);
  } else if(isDefined(param_04)) {
    lib_0540::func_A26F(param_04, param_03);
  }

  if(!isDefined(param_02)) {
    param_02 = 2500;
  }

  param_02 = param_00[2] + param_02;
  var_06 = getgroundposition(param_00, self.var_014F, 64, 64);
  if(!isDefined(param_03)) {
    param_03 = "spawn_drop";
  }

  var_07 = maps\mp\agents\_scripted_agent_anim_util::func_434D(param_03);
  var_08 = -1;
  var_09 = 0;
  var_0A = undefined;
  var_0B = undefined;
  var_0C = undefined;
  var_0D = undefined;
  var_0E = 0;
  var_0F = [];
  var_10 = undefined;
  var_0E = undefined;
  var_09 = undefined;
  var_11 = undefined;
  var_12 = self method_83DB(var_07);
  for(var_13 = 0; var_13 < var_12; var_13++) {
    var_0F[var_0F.size] = var_13;
  }

  var_0F = common_scripts\utility::func_0F92(var_0F);
  foreach(var_15 in var_0F) {
    var_0D = self method_83D8(var_07, var_15);
    var_16 = getanimname(var_0D);
    if(isDefined(param_04) && isDefined(param_04.var_A27C) && isDefined(param_04.var_A27C.var_0886[param_03]) && !common_scripts\utility::func_562E(param_04.var_A27C.var_0ED2[var_16])) {
      continue;
    }

    if(!animhasnotetrack(var_0D, "jump_start") || !animhasnotetrack(var_0D, "jump_end")) {
      continue;
    }

    var_11 = getanimlength(var_0D);
    var_09 = maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_0D, "jump_start");
    var_09 = ceil(var_09 * var_11 * 20) / var_11 * 20;
    var_0E = maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_0D, "jump_end");
    var_17 = (0, getangledelta(var_0D, var_0E, 0), 0);
    var_0B = transformmove(var_06, param_01, (0, 0, 0), (0, 0, 0), getmovedelta(var_0D, var_0E, 0), var_17);
    var_18 = rotatevector(getmovedelta(var_0D, 0, var_09), var_0B["angles"]);
    var_19 = rotatevector(getmovedelta(var_0D, 0, 1), var_0B["angles"]);
    var_1A = var_0B["origin"];
    var_1B = (0, 0, param_02 - var_1A[2]);
    var_0C = var_1A + var_1B;
    var_0A = var_0C + var_18;
    var_1C = getgroundposition(var_1A + var_19, self.var_014F);
    var_1D = (0, 0, 4);
    var_1E = self method_83EB(var_0A, var_06 + var_1D, self.var_014F, self.var_00BD, 1, 1);
    var_1F = function_02E6(var_06, self) && function_02DE(var_06, var_1C, self);
    if(var_1E["fraction"] < 1) {
      continue;
    }

    if(!var_1F) {
      continue;
    }

    var_08 = var_15;
    var_0B["origin"] = var_0C;
    var_21 = var_18[2] + var_1A[2] - var_06[2];
    var_22 = var_21 + var_1B[2];
    var_10 = var_22 / var_21;
    break;
  }

  if(var_08 == -1) {
    lib_056D::func_5A86();
    return;
  }

  if(isDefined(param_04)) {
    param_04 thread lib_0540::func_17EE(self);
  }

  self setorigin(var_0B["origin"], 1);
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", var_0B["angles"]);
  self method_839D("noclip");
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "FallingZombie");
  maps\mp\agents\_scripted_agent_anim_util::func_8415(var_07, var_08);
  var_24 = var_11 * var_09;
  wait(var_24);
  var_25 = sqrt(1 / var_10);
  var_26 = var_0E - var_09 * var_11;
  var_27 = var_26 / var_25;
  if(isDefined(param_05)) {
    var_28 = param_05 - gettime() * 0.001;
    var_27 = max(0.1, min(var_27, var_28));
  }

  var_27 = floor(var_27 * 20 + 0.5) * 0.05;
  var_25 = var_26 / var_27;
  var_29 = 1 / squared(var_25);
  self method_839A(1, var_10);
  self method_85D4(var_25);
  wait(var_27);
  lib_0378::func_8D74("zombie_fall_impact");
  var_2A = anglestoaxis(self.var_001D);
  playFX(common_scripts\utility::func_44F5("ground_impact"), self.var_0116, var_2A["forward"], var_2A["up"]);
  self notify("zombie_fall_impact");
  self method_839A(1, 1);
  self method_85D4(1);
  self method_839D("gravity");
  var_2B = 1 - var_0E * var_11;
  wait(var_2B);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "FallingZombie");
  self scragentsetscripted(0);
  lib_0547::func_84CB();
  if(abs(param_00[2] - self.var_0116[2]) > 32) {
    lib_056D::func_5A86();
  }
}

lib_0540::func_17EE(param_00) {
  self.var_3A1B = 1;
  param_00 common_scripts\utility::func_A70A("death", "zombie_fall_impact");
  self.var_3A1B = undefined;
}