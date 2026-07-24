/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3149.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("gesture")) {
    return;
  }
  scripts\asm\asm::_id_230B("gesture", "gesture_start");
  scripts\asm\asm::_id_2374("gesture", _id_0C4C::_id_D48B, undefined, undefined, undefined, undefined, _id_0C4C::_id_3EDA, undefined, ["gesture"], undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("gesture_start", undefined, ::_id_121A5, undefined);
  scripts\asm\asm::_id_2374("gesture_start", _id_0C4C::_id_980D, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("gesture", undefined, ::_id_121A1, undefined);
  scripts\asm\asm::_id_2375("gesture_point", undefined, ::_id_121A3, undefined);
  scripts\asm\asm::_id_2374("gesture_point", _id_0C4C::_id_D48B, undefined, undefined, undefined, undefined, _id_0C4C::_id_3EDA, undefined, ["gesture"], undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("gesture_start", undefined, ::_id_1219F, undefined);
  scripts\asm\asm::_id_2327();
}

_id_121A5(var_0, var_1, var_2, var_3) {
  return !_id_0C4C::_id_195F();
}

_id_121A1(var_0, var_1, var_2, var_3) {
  return _id_0C4C::_id_195F();
}

_id_121A3(var_0, var_1, var_2, var_3) {
  return _id_0C4C::_id_19D2();
}

_id_1219F(var_0, var_1, var_2, var_3) {
  return !_id_0C4C::_id_19D2();
}