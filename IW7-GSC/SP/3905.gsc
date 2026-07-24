/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3905.gsc
**************************************/

_id_CEE2(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");

  if(!isDefined(level._id_4B17)) {
    level._id_4B17 = 0;
  }

  level._id_4B17++;

  if(level._id_4B17 > 3) {
    level._id_4B17 = 1;
  }

  self._id_201C = level._id_4B17;
  self._id_2023 = "rise";
  self._id_2029 = scripts\engine\utility::spawn_tag_origin();
  self linkTo(self._id_2029);
  self._id_2020 = undefined;
  thread _id_197A(var_1);
  _id_0A1E::_id_2364(var_0, var_1, var_2);
}

_id_3EB1(var_0, var_1, var_2) {
  var_3 = "rise_" + self._id_201C;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

_id_197A(var_0) {
  self endon(var_0 + "_finished");
  self._id_2021 = self._id_2029.origin;
  var_1 = randomfloatrange(56, 106);
  var_2 = 16.0;
  var_3 = var_1 / (var_1 + var_2);
  var_4 = 16.0;
  var_5 = 80.0;
  var_6 = 8.0;

  if(isDefined(self.subclass) && self.subclass == "C8") {
    var_5 = 110.0;
  }

  var_7 = scripts\common\trace::capsule_trace(self._id_2021 + (0, 0, 2), self._id_2021 + (0, 0, var_1 + var_2), var_4, var_5, undefined, undefined, scripts\common\trace::create_solid_ai_contents(1));
  self._id_201E = clamp((var_1 + var_2) * var_7["fraction"], var_6, var_1);
  self._id_201F = 0;

  if(var_7["fraction"] < 1.0) {
    self._id_201F = 1;
  }

  var_8 = randomfloatrange(0.3, 0.6);
  var_9 = 3.2;
  wait(var_8);
  self._id_2029 moveTo(self._id_2021 + (0, 0, self._id_201E), var_9, 0.1, var_9 - 0.1);
  wait(var_9);

  if(self._id_201F == 0) {
    var_10 = self._id_201D - self._id_2022 - var_9 - var_8;
    self._id_2029 moveTo(self._id_2029.origin + (0, 0, 10), var_10);
  }
}

_id_CEE0(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self._id_2023 = "float_idle";
  _id_0A1E::_id_235F(var_0, var_1, var_2, 1.0);
}

_id_3EB0(var_0, var_1, var_2) {
  if(!isDefined(self._id_201C)) {
    var_3 = "float_1";
  } else {
    var_3 = "float_" + self._id_201C;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

_id_CEDC(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self._id_2023 = "fall";
  thread _id_1976(var_1);
  _id_0A1E::_id_2364(var_0, var_1, var_2);
}

_id_3EAD(var_0, var_1, var_2) {
  var_3 = "fall_" + self._id_201C;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

_id_1976(var_0) {
  self endon(var_0 + "_finished");
  var_1 = 0.3;
  self._id_2029 moveTo(self._id_2021, var_1, var_1 - 0.1, 0.0);
  wait(var_1);
  _id_1973(1);
  self._id_2023 = "getup";
  self orientmode("face angle", self.angles[1]);
}

_id_CEDD(var_0, var_1, var_2, var_3) {
  thread _id_1977();
}

_id_1977() {
  var_0 = 3.2;
  self._id_2029 moveTo(self._id_2021 + (0, 0, self._id_201E), var_0, 0.1, var_0 - 0.1);
  wait(var_0);

  if(isDefined(self) && self._id_201F == 0) {
    var_1 = self._id_201D - self._id_2022 - var_0;
    self._id_2029 moveTo(self._id_2029.origin + (0, 0, 10), var_1);
  }
}

_id_CEE1(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  _id_1974();
}

_id_197C(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_2020)) {
    if(!isDefined(self._id_2023) || self._id_2023 != "fall") {
      return 1;
    }
  }

  return 0;
}

_id_CEDB(var_0, var_1, var_2, var_3) {
  if(!_id_197C()) {
    _id_1973();
  }
}

_id_3391(var_0, var_1, var_2, var_3) {
  if(!_id_197C()) {
    _id_1973();
  }
}

_id_197B() {
  self._id_2023 = "rise";
  self._id_2029 = scripts\engine\utility::spawn_tag_origin();
  self linkTo(self._id_2029);
}

_id_1973(var_0) {
  self notify("ai_antigrav_done");

  if(isDefined(self._id_2029)) {
    self._id_2029 scripts\engine\utility::delaycall(1, ::delete);
  }

  if(!isDefined(var_0) || !var_0) {
    self._id_2023 = undefined;
    self._id_2020 = undefined;
    self._id_201C = undefined;
    self._id_201D = undefined;
    self._id_2022 = undefined;
  }
}

_id_1974() {
  self._id_2029 delete();
  self._id_2023 = undefined;
}

_id_2012(var_0, var_1, var_2, var_3) {
  if(gettime() >= self._id_201D) {
    return 1;
  } else {
    return 0;
  }
}