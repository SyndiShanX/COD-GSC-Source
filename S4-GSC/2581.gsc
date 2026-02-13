/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2581.gsc
*************************************************/

_id_E807() {
  level._effect["steel_bib_bullet_impact"] = loadfx("vfx/s4/killstreaks/vfx_imp_armor_ks.vfx");
}

_id_E805(var_0) {
  self notify("steel_bib_applied");

  if(1) {
    var_1 = makeweapon("s4_ks_steel_bib_mp");
    self _meth_852A(var_1);
    _id_07EA::_id_D5E2(self, 50, 0);
    level thread scripts\mp\battlechatter_mp::_id_F759(self, "use_armor");
    var_2 = self _meth_876E("ui_light_armor_state");

    if(var_2 != 1) {
      self setclientomnvar("ui_light_armor_state", 1);
      thread _id_E806();
    }

    return 1;
  }

  return 0;
}

_id_E806() {
  self endon("steel_bib_applied");
  self endon("disconnect");
  self endon("death");
  self waittill("lightArmor_unset");
  var_0 = self _meth_876E("ui_light_armor_state");

  if(var_0 == 1) {
    self setscriptablepartstate("armor_break", "armor_break", 0);
    self setclientomnvar("ui_light_armor_state", 2);
    self playlocalsound("mp_fldupgrds_steel_bib_break");
  }
}

steel_bib_clear_ui() {
  var_0 = self _meth_876E("ui_light_armor_state");

  if(var_0 == 1) {
    self setscriptablepartstate("armor_break", "armor_break", 0);
    self setclientomnvar("ui_light_armor_state", 2);
  }
}