/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3124.gsc
************************/

func_11090() {}

func_4E36() {
  self notify("terminate_ai_threads");
  self notify("killanimscript");
}

func_CF0E(param_00, param_01, param_02, param_03) {
  self gib_fx_override("gravity");
  self ghostlaunched("anim deltas");
  lib_0F3C::func_CEA8(param_00, param_01, param_02);
}

func_3EE2(param_00, param_01, param_02) {
  return 0;
}

func_3ECA(param_00, param_01, param_02) {
  return 0;
}

func_3EC6(param_00, param_01, param_02) {
  return 0;
}

func_3F00(param_00, param_01, param_02) {
  return 0;
}

func_3F02(param_00, param_01, param_02) {
  return 0;
}

func_3F01(param_00, param_01, param_02) {
  return 0;
}

func_6DB2() {
  return 1;
}

playdeathfx() {}

play_blood_pool(param_00, param_01) {}

func_C703() {}

playdeathsound() {}

func_E166(param_00) {}

func_41DC(param_00) {}

func_FFFA(param_00, param_01, param_02, param_03) {
  return 0;
}

isdepot(param_00) {
  if(param_00 == "deserteagle") {
    return 1;
  }

  return 0;
}

func_9D59(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(distance(self.origin, param_00.origin) > param_01) {
    return 0;
  }

  return 1;
}