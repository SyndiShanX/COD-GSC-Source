/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3905.gsc
*********************************************/

func_CEE2(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
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
  thread func_197A(var_1);
  lib_0A1E::func_2364(var_0, var_1, var_2);
}

func_3EB1(var_0, var_1, var_2) {
  var_3 = "rise_" + self.var_201C;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

func_197A(var_0) {
  self endon(var_0 + "_finished");
  self.var_2021 = self.var_2029.origin;
  var_1 = randomfloatrange(56, 106);
  var_2 = 16;
  var_3 = var_1 / var_1 + var_2;
  var_4 = 16;
  var_5 = 80;
  var_6 = 8;
  if(isDefined(self.subclass) && self.subclass == "C8") {
    var_5 = 110;
  }

  var_7 = scripts\common\trace::capsule_trace(self.var_2021 + (0, 0, 2), self.var_2021 + (0, 0, var_1 + var_2), var_4, var_5, undefined, undefined, scripts\common\trace::create_solid_ai_contents(1));
  self.var_201E = clamp(var_1 + var_2 * var_7["fraction"], var_6, var_1);
  self.var_201F = 0;
  if(var_7["fraction"] < 1) {
    self.var_201F = 1;
  }

  var_8 = randomfloatrange(0.3, 0.6);
  var_9 = 3.2;
  wait(var_8);
  self.var_2029 moveto(self.var_2021 + (0, 0, self.var_201E), var_9, 0.1, var_9 - 0.1);
  wait(var_9);
  if(self.var_201F == 0) {
    var_10 = self.var_201D - self.var_2022 - var_9 - var_8;
    self.var_2029 moveto(self.var_2029.origin + (0, 0, 10), var_10);
  }
}

func_CEE0(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.var_2023 = "float_idle";
  lib_0A1E::func_235F(var_0, var_1, var_2, 1);
}

func_3EB0(var_0, var_1, var_2) {
  if(!isDefined(self.var_201C)) {
    var_3 = "float_1";
  } else {
    var_3 = "float_" + self.var_201C;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

func_CEDC(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.var_2023 = "fall";
  thread func_1976(var_1);
  lib_0A1E::func_2364(var_0, var_1, var_2);
}

func_3EAD(var_0, var_1, var_2) {
  var_3 = "fall_" + self.var_201C;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

func_1976(var_0) {
  self endon(var_0 + "_finished");
  var_1 = 0.3;
  self.var_2029 moveto(self.var_2021, var_1, var_1 - 0.1, 0);
  wait(var_1);
  func_1973(1);
  self.var_2023 = "getup";
  self orientmode("face angle", self.angles[1]);
}

func_CEDD(var_0, var_1, var_2, var_3) {
  thread func_1977();
}

func_1977() {
  var_0 = 3.2;
  self.var_2029 moveto(self.var_2021 + (0, 0, self.var_201E), var_0, 0.1, var_0 - 0.1);
  wait(var_0);
  if(isDefined(self) && self.var_201F == 0) {
    var_1 = self.var_201D - self.var_2022 - var_0;
    self.var_2029 moveto(self.var_2029.origin + (0, 0, 10), var_1);
  }
}

func_CEE1(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  func_1974();
}

func_197C(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_2020)) {
    if(!isDefined(self.var_2023) || self.var_2023 != "fall") {
      return 1;
    }
  }

  return 0;
}

func_CEDB(var_0, var_1, var_2, var_3) {
  if(!func_197C()) {
    func_1973();
  }
}

func_3391(var_0, var_1, var_2, var_3) {
  if(!func_197C()) {
    func_1973();
  }
}

func_197B() {
  self.var_2023 = "rise";
  self.var_2029 = scripts\engine\utility::spawn_tag_origin();
  self linkto(self.var_2029);
}

func_1973(var_0) {
  self notify("ai_antigrav_done");
  if(isDefined(self.var_2029)) {
    self.var_2029 scripts\engine\utility::delaycall(1, ::delete);
  }

  if(!isDefined(var_0) || !var_0) {
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

func_2012(var_0, var_1, var_2, var_3) {
  if(gettime() >= self.var_201D) {
    return 1;
  }

  return 0;
}