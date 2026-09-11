/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trl_boneyard_gw_race.gsc
*********************************************************/

function ref_134ad(var0, var1, var2) {
  self endon(var1 + "_finished");
  self.scripted_mode = 1;
  self animmode("noclip");
  var3 = scripts\asm\asm_mp::asm_getanimindex(var0, var1);
  var4 = 0.01;
  thread scripts\asm\asm_mp::asm_playanimstateindex(var0, var1, var3, var4);

  if(isDefined(level.ref_1355b)) {
    self[[level.ref_1355b]]();
  }

  wait 0.5;
  self.shouldbekilledoff = 1;
}

function ref_134ae(var0, var1, var2) {
  self endon(var1 + "_finished");
  self.ref_1286d = self.ignoreall;

  if(isDefined(self.scripted_mode)) {
    self.ref_1286e = self.scripted_mode;
  }

  if(getdvarint("scr_br_ai_spawnPerformance", 0) == 1) {
    self.scripted_mode = 1;
    self.turbopetchallengewatcher = 1;
    self.ref_142b2 = 1;
    self.ignoreall = 1;
    self animmode("noclip");
    self.hasplayedvignetteanim = 0;
    var3 = scripts\asm\asm_mp::asm_getanimindex(var0, var1);
    var4 = 1;

    if(isDefined(self.ref_142b3)) {
      var4 = self.ref_142b3;
    }

    var5 = self.do_immediate_ragdoll;
    self.do_immediate_ragdoll = 1;
    scripts\asm\asm_mp::care_pkg(var0, var1, var3, var4, "code_move");
    self.do_immediate_ragdoll = var5;
  }

  self.hasplayedvignetteanim = 1;
}

function ref_134bf(var0, var1, var2) {
  self animmode("gravity");

  if(isDefined(self.ref_1286e)) {
    self.scripted_mode = self.ref_1286e;
    self.ref_1286e = undefined;
  } else {
    self.scripted_mode = undefined;
  }

  self.ignoreall = self.ref_1286d;
  self.ref_1286d = undefined;
  self.hasplayedvignetteanim = 1;
  self.turbopetchallengewatcher = undefined;
  self.ref_142b2 = undefined;
  self method_87bc(0);
  self notify("intro_vignette_done");
}

function ref_134a2(var0, var1, var2, var3) {
  return istrue(self.shouldbekilledoff);
}

function ref_134a1(var0, var1, var2, var3) {
  return istrue(self.hasplayedvignetteanim);
}