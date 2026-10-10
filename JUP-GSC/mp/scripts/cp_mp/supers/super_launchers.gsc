/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\supers\super_launchers.gsc
*******************************************************/

#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace super_launchers;

function autoexec main() {
  registersharedfunc("super_launcher", "init", &function_ac4e5642f4a76765);
}

function function_ac4e5642f4a76765() {
  scripts\engine\utility::registersharedfunc("super_launcher", "launcher_set", &function_cd7adfeda90090ea);
  scripts\engine\utility::registersharedfunc("super_launcher", "launcher_unset", &function_ab826319b54a872f);
  scripts\engine\utility::registersharedfunc("super_launcher", "launcher_begin_use", &function_b175b0e761ee083d);
  scripts\engine\utility::registersharedfunc("super_launcher", "launcher_end_use", &function_9152d073564d3361);
  scripts\engine\utility::registersharedfunc("super_launcher", "launcher_repeat", &function_c31358a51d2e2031);
}

function function_c31358a51d2e2031() {
  if(!issharedfuncdefined("supers", "setSuperIsActive") || !issharedfuncdefined("supers", "getCurrentSuper") || !issharedfuncdefined("supers", "tryGiveUseWeapon")) {
    return;
  }

  self[[getsharedfunc("supers", "setSuperIsActive")]](1);
  superinfo = self[[getsharedfunc("supers", "getCurrentSuper")]]();
  clipammo = superinfo.staticdata.useweaponclipammo;
  stockammo = superinfo.staticdata.useweaponstockammo;

  if(isDefined(superinfo.var_3d2b63c4e181029d)) {
    clipammo = superinfo.var_3d2b63c4e181029d;
  }

  if(isDefined(superinfo.var_b9ef26fa33686273)) {
    stockammo = superinfo.var_b9ef26fa33686273;
  }

  result = [[getsharedfunc("supers", "tryGiveUseWeapon")]](superinfo.staticdata.useweapon, clipammo, stockammo);

  if(istrue(result)) {
    self[[getsharedfunc("supers", "setSuperIsActive")]](1);
  } else {
    self[[getsharedfunc("supers", "setSuperIsActive")]](0);
  }

  return result;
}

function function_b175b0e761ee083d() {
  function_7b092f96be9a26d9(0);
  thread function_51cf80cea7c30793();
  return true;
}

function function_9152d073564d3361(fromdeath) {
  function_7b092f96be9a26d9(1);
}

function function_cd7adfeda90090ea() {
  self setclientomnvar("ui_block_fu_not_ready_error", 1);
}

function function_ab826319b54a872f() {
  self setclientomnvar("ui_block_fu_not_ready_error", 0);
  self.var_b24e609023ce8208 = undefined;
  self.var_98d31d9ce04b2b81 = undefined;
}

function function_7b092f96be9a26d9(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self enableweaponpickup();
    return;
  }

  self disableweaponpickup();
}

function function_51cf80cea7c30793() {
  self endon("death_or_disconnect");
  self endon("super_use_finish");
  self endon("end_super_select");

  if(!istrue(self.perkpackagedata.istwomode)) {
    return;
  }

  self waittill("weapon_change");
  self[[getsharedfunc("supers", "setSuperIsActive")]](0);
  self[[getsharedfunc("supers", "setSuperIsInUse")]](0);
}