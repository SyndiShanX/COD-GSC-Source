/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3124.gsc
**************************************/

_id_11090() {}

_id_4E36() {
  self notify("terminate_ai_threads");
  self notify("killanimscript");
}

_id_CF0E(var_0, var_1, var_2, var_3) {
  self scragentsetphysicsmode("gravity");
  self _meth_8281("anim deltas");
  _id_0F3C::_id_CEA8(var_0, var_1, var_2);
}

_id_3EE2(var_0, var_1, var_2) {
  return 0;
}

_id_3ECA(var_0, var_1, var_2) {
  return 0;
}

_id_3EC6(var_0, var_1, var_2) {
  return 0;
}

_id_3F00(var_0, var_1, var_2) {
  return 0;
}

_id_3F02(var_0, var_1, var_2) {
  return 0;
}

_id_3F01(var_0, var_1, var_2) {
  return 0;
}

_id_6DB2() {
  return 1;
}

playdeathfx() {}

play_blood_pool(var_0, var_1) {}

_id_C703() {}

playdeathsound() {}

_id_E166(var_0) {}

_id_41DC(var_0) {}

_id_FFFA(var_0, var_1, var_2, var_3) {
  return 0;
}

isdepot(var_0) {
  if(var_0 == "deserteagle")
    return 1;

  return 0;
}

_id_9D59(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(distance(self.origin, var_0.origin) > var_1)
    return 0;

  return 1;
}