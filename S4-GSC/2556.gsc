/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2556.gsc
*************************************************/

init() {
  level._effect["adrenaline"] = loadfx("vfx/iw8_mp/equipment/stim/vfx_stim_heal_scrn.vfx");
}

monitorkillforevent() {
  self.stimactiveevent = 1;
  wait 3;
  self.stimactiveevent = undefined;
}

_id_FE21() {
  self endon("disconnect");
  self endon("removeAdrenaline");
  self notify("force_regeneration");
  thread monitorkillforevent();
  scripts\mp\gamelogic::_id_D58D(self, 1);
  _id_11AD();
  self._id_11B4 = 1;
  self _meth_86CE();
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "use_stim");
  childthread _id_11B0();
  childthread _id_11AE();
  childthread _id_11AF();
  self setclientomnvar("ui_health_regen_hud", 1);
  _func_019D(level._effect["adrenaline"], self, "tag_origin", self);
  return 1;
}

_id_C469() {
  if(istrue(self._id_11B4)) {
    self notify("removeAdrenaline");
    self._id_11B4 = undefined;
  }
}

_id_AAD0(var_0, var_1) {
  _id_C469();
}

_id_AACE(var_0, var_1, var_2) {
  _id_FE21();
  thread scripts\mp\battlechatter_mp::enemyuseadrenaline();
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

    if(level.gametype == "br" && (var_4 == "MOD_TRIGGER_HURT" || var_4 == "MOD_UNKNOWN")) {
      continue;
    }
    thread _id_C469();
    return;
  }
}

_id_11AF() {
  level waittill("game_ended");
  thread _id_C469();
}

_id_11AD() {
  if(self.health >= self.maxhealth) {
    self._id_FE41 = 1;
    thread _id_11AC();
  }
}

_id_11AC() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("adrenaline_missionOnDeathThink");
  self endon("adrenaline_missionOnDeathThink");
  self waittill("death");
  self._id_FE41 = undefined;
}