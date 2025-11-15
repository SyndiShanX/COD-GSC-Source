/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\aalauncher.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("aa_launcher", ::func_6D69, undefined, ::func_5FBC, undefined, ::func_11378);
  scripts\mp\laserguidedlauncher::func_AC0B("vfx\core\mp\killstreaks\vfx_maaws_split", "vfx\core\mp\killstreaks\vfx_maaws_homing");
}

getaalaunchername() {
  return "iw6_maaws_mp";
}

getaalauncherchildname() {
  return "iw6_maawschild_mp";
}

getaalauncherhomingname() {
  return "iw6_maawshoming_mp";
}

func_5FBC(param_00) {
  param_00.var_14FF = 2;
  return 1;
}

func_6D69(param_00) {
  param_00.var_14FF = param_00.var_14FF - 1;
  var_01 = param_00.var_14FF <= 0;
  return var_01;
}

func_11378(param_00) {
  self setweaponammoclip(param_00.var_394, param_00.var_14FF);
  thread monitorweaponswitch(param_00);
}

monitorweaponswitch(param_00) {
  self endon("death");
  self endon("disconnect");
  self waittill("weapon_change", var_01);
  thread scripts\mp\laserguidedlauncher::func_AC08(getaalaunchername(), getaalauncherchildname(), getaalauncherhomingname());
  self waittill("weapon_change");
  scripts\mp\laserguidedlauncher::func_AC07();
}