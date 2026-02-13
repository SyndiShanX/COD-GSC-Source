/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2664.gsc
*************************************************/

init() {
  level._effect["helmet_pop"] = loadfx("vfx/iw7/core/human/helmet_sdf_army_split.vfx");
}

_id_C4CC(var_0, var_1) {
  self notify("remove_headgear");
  self._id_756C = undefined;
}

_id_CA3F(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("remove_headgear");
  self._id_756C = 1;
  self waittill("headgear_save");
  self._id_756C = 0;

  if(var_0 != "") {
    scripts\mp\equipment::_id_D543(var_0, 0);
  }

  _id_CA40();
}

_id_CA40() {
  playFXOnTag(level._effect["helmet_pop"], self, "j_head");
  self detach(self._id_7611, "");
  self _meth_8526(self._id_25E5, self._id_20C6);
  self._id_7611 = self._id_20C6;
  self attach(self._id_20C6, "", 1);
}

_id_69C0() {
  return 0.1;
}

_id_6B3A() {
  return 20;
}