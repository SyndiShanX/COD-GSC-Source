/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2328.gsc
*************************************************/

init() {
  thread _id_7F16();
}

_id_7F16() {
  level waittill("equipment_initialized");
  _id_0728::_id_10AB("equip_adrenaline", "onFired", ::_id_FE21);
}

_id_FE21(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("removeAdrenaline");
  self._id_11B4 = 1;
  self.adrenalineusetime = gettime();
  self.adrenalinekills = 0;
  self notify("force_regeneration");
  self _meth_86CE();
  childthread _id_11B0();
  childthread _id_11AE();
  childthread _id_11AF();
  self setscriptablepartstate("healing", "active", 0);
  return 1;
}

_id_C469() {
  if(istrue(self._id_11B4)) {
    self notify("removeAdrenaline");
    self._id_11B4 = undefined;
  }
}

_id_6A90() {
  return 8;
}

_id_11B0() {
  scripts\engine\utility::waittill_any_2("death", "healed");
  thread _id_C469();
}

_id_11AE() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    thread _id_C469();
    return;
  }
}

_id_11AF() {
  level waittill("game_ended");
  thread _id_C469();
}