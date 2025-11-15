/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3905.gsc
************************/

func_CEE2(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  if(!isDefined(level.var_4B17)) {
    level.var_4B17 = 0;
  }

  level.var_4B17++;
  if(level.var_4B17 > 3) {
    level.var_4B17 = 1;
  }

  self.var_201C = level.var_4B17;
  self.var_2023 = "rise";
  self.var_2029 = scripts\engine\utility::spawn_tag_origin();
  self linkto(self.var_2029);
  self.var_2020 = undefined;
  thread func_197A(param_01);
  lib_0A1E::func_2364(param_00, param_01, param_02);
}

func_3EB1(param_00, param_01, param_02) {
  var_03 = "rise_" + self.var_201C;
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

func_197A(param_00) {
  self endon(param_00 + "_finished");
  self.var_2021 = self.var_2029.origin;
  var_01 = randomfloatrange(56, 106);
  var_02 = 16;
  var_03 = var_01 / var_01 + var_02;
  var_04 = 16;
  var_05 = 80;
  var_06 = 8;
  if(isDefined(self.subclass) && self.subclass == "C8") {
    var_05 = 110;
  }

  var_07 = scripts\common\trace::capsule_trace(self.var_2021 + (0, 0, 2), self.var_2021 + (0, 0, var_01 + var_02), var_04, var_05, undefined, undefined, scripts\common\trace::create_solid_ai_contents(1));
  self.var_201E = clamp(var_01 + var_02 * var_07["fraction"], var_06, var_01);
  self.var_201F = 0;
  if(var_07["fraction"] < 1) {
    self.var_201F = 1;
  }

  var_08 = randomfloatrange(0.3, 0.6);
  var_09 = 3.2;
  wait(var_08);
  self.var_2029 moveto(self.var_2021 + (0, 0, self.var_201E), var_09, 0.1, var_09 - 0.1);
  wait(var_09);
  if(self.var_201F == 0) {
    var_0A = self.var_201D - self.var_2022 - var_09 - var_08;
    self.var_2029 moveto(self.var_2029.origin + (0, 0, 10), var_0A);
  }
}

func_CEE0(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.var_2023 = "float_idle";
  lib_0A1E::func_235F(param_00, param_01, param_02, 1);
}

func_3EB0(param_00, param_01, param_02) {
  if(!isDefined(self.var_201C)) {
    var_03 = "float_1";
  } else {
    var_03 = "float_" + self.var_201C;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

func_CEDC(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.var_2023 = "fall";
  thread func_1976(param_01);
  lib_0A1E::func_2364(param_00, param_01, param_02);
}

func_3EAD(param_00, param_01, param_02) {
  var_03 = "fall_" + self.var_201C;
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

func_1976(param_00) {
  self endon(param_00 + "_finished");
  var_01 = 0.3;
  self.var_2029 moveto(self.var_2021, var_01, var_01 - 0.1, 0);
  wait(var_01);
  func_1973(1);
  self.var_2023 = "getup";
  self orientmode("face angle", self.angles[1]);
}

func_CEDD(param_00, param_01, param_02, param_03) {
  thread func_1977();
}

func_1977() {
  var_00 = 3.2;
  self.var_2029 moveto(self.var_2021 + (0, 0, self.var_201E), var_00, 0.1, var_00 - 0.1);
  wait(var_00);
  if(isDefined(self) && self.var_201F == 0) {
    var_01 = self.var_201D - self.var_2022 - var_00;
    self.var_2029 moveto(self.var_2029.origin + (0, 0, 10), var_01);
  }
}

func_CEE1(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  func_1974();
}

func_197C(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_2020)) {
    if(!isDefined(self.var_2023) || self.var_2023 != "fall") {
      return 1;
    }
  }

  return 0;
}

func_CEDB(param_00, param_01, param_02, param_03) {
  if(!func_197C()) {
    func_1973();
  }
}

func_3391(param_00, param_01, param_02, param_03) {
  if(!func_197C()) {
    func_1973();
  }
}

func_197B() {
  self.var_2023 = "rise";
  self.var_2029 = scripts\engine\utility::spawn_tag_origin();
  self linkto(self.var_2029);
}

func_1973(param_00) {
  self notify("ai_antigrav_done");
  if(isDefined(self.var_2029)) {
    self.var_2029 scripts\engine\utility::delaycall(1, ::delete);
  }

  if(!isDefined(param_00) || !param_00) {
    self.var_2023 = undefined;
    self.var_2020 = undefined;
    self.var_201C = undefined;
    self.var_201D = undefined;
    self.var_2022 = undefined;
  }
}

func_1974() {
  self.var_2029 delete();
  self.var_2023 = undefined;
}

func_2012(param_00, param_01, param_02, param_03) {
  if(gettime() >= self.var_201D) {
    return 1;
  }

  return 0;
}