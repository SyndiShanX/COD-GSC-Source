/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3455.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("aa_launcher", ::func_6D69, undefined, ::func_5FBC, undefined, ::func_11378);
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

func_5FBC(var_00) {
  var_0.func_14FF = 2;
  return 1;
}

func_6D69(var_00) {
  var_0.func_14FF = var_0.func_14FF - 1;
  var_01 = var_0.func_14FF <= 0;
  return var_01;
}

func_11378(var_00) {
  self setweaponammoclip(var_0.weapon, var_0.func_14FF);
  thread monitorweaponswitch(var_00);
}

monitorweaponswitch(var_00) {
  self endon("death");
  self endon("disconnect");
  self waittill("weapon_change", var_01);
  thread scripts\mp\laserguidedlauncher::func_AC08(getaalaunchername(), getaalauncherchildname(), getaalauncherhomingname());
  self waittill("weapon_change");
  scripts\mp\laserguidedlauncher::func_AC07();
}