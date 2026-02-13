/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\equipment\serum.gsc
*************************************************/

init() {
  level._effect["serum"] = loadfx("vfx/s4/equipment/vfx_xserum_scrn.vfx");
}

_id_AAD0(var_0, var_1) {
  self notify("serum_finished");
}

_id_AACE(var_0, var_1, var_2) {
  useserum();
}

useserum() {
  self endon("disconnect");
  self setclientomnvar("ui_health_regen_hud", 1);
  _func_019D(level._effect["serum"], self, "tag_origin", self);
  thread watchspeedboost();
  thread watchunset();
}

watchspeedboost() {
  self endon("death_or_disconnect");
  self endon("serum_finished");
  self._id_A25F = self._id_A25F + 2.5;
  scripts\mp\weapons::_id_FCCC();
  wait 5;
  self notify("serum_finished");
}

watchunset() {
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "serum_finished");
  removeserum();
}

removeserum() {
  self._id_A25F = max(1, self._id_A25F - 2.5);
  scripts\mp\weapons::_id_FCCC();
}