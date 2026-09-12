/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trl_boneyard_gw_race.gsc
*********************************************************/

function ref_134AD(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self.scripted_mode = 1;
  self animmode("noclip");
  var_3 = scripts\asm\asm_mp::asm_getanimindex(var_0, var_1);
  var_4 = 0.01;
  thread scripts\asm\asm_mp::asm_playanimstateindex(var_0, var_1, var_3, var_4);

  if(isDefined(level.ref_1355B)) {
    self[[level.ref_1355B]]();
  }

  wait 0.5;
  self.shouldbekilledoff = 1;
}

function ref_134AE(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self.ref_1286D = self.ignoreall;

  if(isDefined(self.scripted_mode)) {
    self.ref_1286E = self.scripted_mode;
  }

  if(getdvarint("scr_br_ai_spawnPerformance", 0) == 1) {
    self.scripted_mode = 1;
    self.turbopetchallengewatcher = 1;
    self.ref_142B2 = 1;
    self.ignoreall = 1;
    self animmode("noclip");
    self.hasplayedvignetteanim = 0;
    var_3 = scripts\asm\asm_mp::asm_getanimindex(var_0, var_1);
    var_4 = 1;

    if(isDefined(self.ref_142B3)) {
      var_4 = self.ref_142B3;
    }

    var_5 = self.do_immediate_ragdoll;
    self.do_immediate_ragdoll = 1;
    scripts\asm\asm_mp::care_pkg(var_0, var_1, var_3, var_4, "code_move");
    self.do_immediate_ragdoll = var_5;
  }

  self.hasplayedvignetteanim = 1;
}

function ref_134BF(var_0, var_1, var_2) {
  self animmode("gravity");

  if(isDefined(self.ref_1286E)) {
    self.scripted_mode = self.ref_1286E;
    self.ref_1286E = undefined;
  } else {
    self.scripted_mode = undefined;
  }

  self.ignoreall = self.ref_1286D;
  self.ref_1286D = undefined;
  self.hasplayedvignetteanim = 1;
  self.turbopetchallengewatcher = undefined;
  self.ref_142B2 = undefined;
  self method_87bc(0);
  self notify("intro_vignette_done");
}

function ref_134A2(var_0, var_1, var_2, var_3) {
  return istrue(self.shouldbekilledoff);
}

function ref_134A1(var_0, var_1, var_2, var_3) {
  return istrue(self.hasplayedvignetteanim);
}