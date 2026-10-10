/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\oxygenmask_mp.gsc
***********************************************/

#using scripts\common\swim_common;
#using scripts\cp_mp\oxygenmask;
#using scripts\engine\utility;
#namespace oxygenmask_mp;

function init() {
  scripts\engine\utility::registersharedfunc("oxygenmask", "onUnusable", &function_afb7a317198d0688);
  scripts\engine\utility::registersharedfunc("oxygenmask", "onEquip", &function_5320a46c0e139cb5);
  scripts\engine\utility::registersharedfunc("oxygenmask", "onUse", &function_c6f7c3926e6e4522);
  scripts\engine\utility::registersharedfunc("oxygenmask", "onUseComplete", &function_cad73059babfbe29);
  level.var_f6bad8618358a031.holdweaponname = "iw9_oxygenmask_mp";
}

function function_afb7a317198d0688() {
  self endon("death_or_disconnect");
  msg = undefined;

  if(istrue(self isswimsprinting())) {
    msg = "MP/DISABLED_WHILE_SWIM_SPRINT";
  } else if(!istrue(self isswimunderwater())) {
    msg = "MP/DISABLED_WHILE_NOT_SWIMMING";
  }

  if(isDefined(msg) && function_a387d51c1bace19(msg)) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]](msg);
      function_c3adccf5abf65331(msg);
    }
  }
}

function function_c3adccf5abf65331(errorref) {
  superinfo = self.super;

  if(!isDefined(superinfo)) {
    return;
  }

  superinfo.omstarttime = gettime();
  superinfo.var_65f670fb7cc70326 = errorref;
}

function function_a387d51c1bace19(var_b5bf99952e022dbe) {
  superinfo = self.super;

  if(!isDefined(superinfo)) {
    return 0;
  }

  if(isDefined(superinfo.var_65f670fb7cc70326) && superinfo.var_65f670fb7cc70326 == var_b5bf99952e022dbe) {
    if(!isDefined(superinfo.omstarttime)) {
      return 1;
    } else if(gettime() > superinfo.omstarttime + 1500) {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  return 1;
}

function function_5320a46c0e139cb5() {
  childthread function_824af6d3bd562a89();
}

function function_824af6d3bd562a89() {
  while(true) {
    self waittill("weapon_fired");
    currentweapon = self getcurrentweapon();

    if(isDefined(currentweapon.basename) && currentweapon.basename != level.var_f6bad8618358a031.holdweaponname) {
      return;
    }

    stockammo = self getweaponammostock(currentweapon);

    if(stockammo > 0) {
      self setweaponammoclip(currentweapon, 1);
      self setweaponammostock(currentweapon, stockammo - 1);
    }
  }
}

function function_c6f7c3926e6e4522() {
  scripts\common\swim_common::function_9368fff2b3156346(1);
  thread function_58611da8ae346833();
  thread function_5a7760580acb149c("death");
  thread function_5a7760580acb149c("weapon_change");
  thread function_5a7760580acb149c("offhand_pullback");
  thread function_fedcd0dbe67afaef();
}

function function_fedcd0dbe67afaef() {
  self endon("disconnect");
  self endon("oxygenmask_fired");
  self endon("oxygenmask_fail");
  level endon("game_ended");

  while(true) {
    if(self ismeleeing()) {
      self notify("oxygenmask_fail");
    }

    waitframe();
  }
}

function function_58611da8ae346833() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("weapon_fired");
  self waittill("oxygenmask_fail");
  scripts\cp_mp\oxygenmask::function_9ac10cec8e7b9d40();
  scripts\common\swim_common::function_9368fff2b3156346(0);
}

function function_5a7760580acb149c(failnotify) {
  self endon("disconnect");
  self endon("oxygenmask_fired");
  self endon("oxygenmask_fail");
  level endon("game_ended");
  self waittill(failnotify);
  self notify("oxygenmask_fail");
}

function function_cad73059babfbe29() {
  scripts\common\swim_common::function_9368fff2b3156346(0);
}