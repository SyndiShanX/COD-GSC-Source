/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3191.gsc
************************/

func_13F64() {
  if(scripts\asm\asm_bb::bb_movetyperequested("fly")) {
    return 1;
  }

  return 0;
}

func_13F66() {
  if(scripts\asm\asm_bb::bb_meleerequested()) {
    return 1;
  }

  return 0;
}

func_13F67() {
  if(scripts\asm\asm_bb::bb_movetyperequested("entangled")) {
    return 1;
  }

  return 0;
}

func_13F68() {
  if(scripts\aitypes\zombie_ghost\behaviors::getghostnavmode() == "launched") {
    return 1;
  }

  return 0;
}

func_13F65() {
  if(!isDefined(self.ghost_target_position)) {
    return 0;
  }

  if(scripts\aitypes\zombie_ghost\behaviors::getghostnavmode() == "entangled") {
    return 0;
  }

  var_00 = self.ghost_target_position - self.origin;
  var_01 = calculate_final_spider_score(var_00);
  if(isDefined(var_01)) {
    self.var_6FF5 = var_01;
    return 1;
  }

  return 0;
}

func_13F6D(param_00, param_01, param_02, param_03) {
  if(isDefined(self.zombie_ghost_target)) {
    func_1299A(self.zombie_ghost_target.origin);
  }

  func_CECF(param_00, param_01, param_02, param_03);
  self notify("ghost_played_melee_anim");
}

func_13F63(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    if(!isDefined(self.zombie_ghost_target)) {
      return;
    }

    if(!scripts\cp\utility::isreallyalive(self.zombie_ghost_target)) {
      return;
    }

    if(self.zombie_ghost_target scripts\cp\utility::isignoremeenabled()) {
      return;
    }

    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(self.zombie_ghost_target)) {
      return;
    }

    if(distancesquared(self.zombie_ghost_target.origin, self.origin) > 9216) {
      return;
    }

    self.zombie_ghost_target dodamage(45, self.origin, self, self, "MOD_MELEE");
  }
}

func_13F6C(param_00, param_01, param_02, param_03) {
  func_CECF(param_00, param_01, param_02, param_03);
}

func_13F6A(param_00, param_01, param_02, param_03) {
  func_CECF(param_00, param_01, param_02, param_03);
}

_meth_826A(param_00, param_01, param_02, param_03, param_04) {
  self endon(param_01 + "_finished");
  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  self.currentanimstate = param_01;
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  self.currentanimindex = var_05;
  var_06 = scripts\asm\asm::func_2341(param_00, param_01);
  for(;;) {
    self setanimstate(param_01, var_05, param_03);
    scripts\mp\agents\_scriptedagents::func_1384C(param_01, "end", param_01, var_05, var_06);
  }
}

func_13F6E(param_00, param_01, param_02, param_03) {}

zombieghost_constantanglesadjust() {
  self endon("death");
  for(;;) {
    scripts\engine\utility::waitframe();
    if(isDefined(self.ghost_target_position)) {
      func_1299A(self.ghost_target_position);
    }
  }
}

func_13F6B(param_00, param_01, param_02, param_03) {
  func_CECF(param_00, param_01, param_02, param_03);
  if(isDefined(self.ghost_target_position)) {
    func_1299A(self.ghost_target_position);
  }
}

calculate_final_spider_score(param_00) {
  var_01 = 10;
  var_02 = vectortoangles(param_00);
  var_03 = angleclamp180(var_02[1] - self.angles[1]);
  var_04 = getangleindex(var_03, var_01);
  if(var_04 == 4 || var_04 < 0 || var_04 > 8) {
    return undefined;
  }

  var_05 = func_79C4();
  return var_05[var_04];
}

func_13F61(param_00, param_01, param_02, param_03) {
  return self.var_6FF5;
}

func_79C4() {
  var_00 = [];
  var_00[0] = 0;
  var_00[1] = 1;
  var_00[2] = 2;
  var_00[3] = 3;
  var_00[5] = 4;
  var_00[6] = 5;
  var_00[7] = 6;
  var_00[8] = 7;
  return var_00;
}

func_1299A(param_00) {
  var_01 = param_00 - self.origin;
  self orientmode("face angle abs", vectortoangles(var_01));
  self.angles = vectortoangles(var_01);
}

func_CECF(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = scripts\asm\asm::func_2341(param_00, param_01);
  self.currentanimstate = param_01;
  self.currentanimindex = var_04;
  scripts\mp\agents\_scriptedagents::func_CED2(param_01, var_04, self.animplaybackrate, param_01, "end", var_05);
}