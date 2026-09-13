/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\oxygenmask_mp.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "onGive", ::_id_78936156143BF6FA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "onUnusable", ::_id_AFB7A317198D0688);
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "onEquip", ::_id_5320A46C0E139CB5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "onUse", ::_id_C6F7C3926E6E4522);
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "onUseComplete", ::_id_CAD73059BABFBE29);
  level._id_F6BAD8618358A031._id_3D605BC71C5D48E3 = "iw9_oxygenmask_mp";
}

_id_AFB7A317198D0688() {
  self endon("death_or_disconnect");
  msg = undefined;

  if(istrue(self _meth_635E39FC16A64657()))
    msg = "MP/DISABLED_WHILE_SWIM_SPRINT";
  else if(!istrue(self _meth_6F55D55CCFF20D14()))
    msg = "MP/DISABLED_WHILE_NOT_SWIMMING";

  if(isDefined(msg) && _id_0A387D51C1BACE19(msg)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](msg);
      _id_C3ADCCF5ABF65331(msg);
    }
  }
}

_id_C3ADCCF5ABF65331(_id_5B67BCF1FFFA8112) {
  _id_19163E14365D9264 = self.super;

  if(!isDefined(_id_19163E14365D9264)) {
    return;
  }
  _id_19163E14365D9264._id_E8378B57E2E5177E = gettime();
  _id_19163E14365D9264._id_65F670FB7CC70326 = _id_5B67BCF1FFFA8112;
}

_id_0A387D51C1BACE19(_id_B5BF99952E022DBE) {
  _id_19163E14365D9264 = self.super;

  if(!isDefined(_id_19163E14365D9264))
    return 0;

  if(isDefined(_id_19163E14365D9264._id_65F670FB7CC70326) && _id_19163E14365D9264._id_65F670FB7CC70326 == _id_B5BF99952E022DBE) {
    if(!isDefined(_id_19163E14365D9264._id_E8378B57E2E5177E))
      return 1;
    else if(gettime() > _id_19163E14365D9264._id_E8378B57E2E5177E + 1500.0)
      return 1;
    else
      return 0;
  } else
    return 1;
}

_id_78936156143BF6FA() {
  thread _id_DAB51E8A68583183();
}

_id_5320A46C0E139CB5() {
  childthread _id_824AF6D3BD562A89();
}

_id_824AF6D3BD562A89() {
  for(;;) {
    self waittill("weapon_fired");
    currentweapon = self getcurrentweapon();

    if(isDefined(currentweapon.basename) && currentweapon.basename != level._id_F6BAD8618358A031._id_3D605BC71C5D48E3) {
      return;
    }
    stockammo = self getweaponammostock(currentweapon);

    if(stockammo > 0) {
      self setweaponammoclip(currentweapon, 1);
      self setweaponammostock(currentweapon, stockammo - 1);
    }
  }
}

_id_C6F7C3926E6E4522() {
  _id_4B87F2871B6B025C::_id_9368FFF2B3156346(1);
  thread _id_58611DA8AE346833();
  thread _id_5A7760580ACB149C("death");
  thread _id_5A7760580ACB149C("weapon_change");
  thread _id_5A7760580ACB149C("offhand_pullback");
}

_id_58611DA8AE346833() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("weapon_fired");
  self waittill("oxygenmask_fail");
  _id_1B4114093CD44368::_id_9AC10CEC8E7B9D40();
  _id_4B87F2871B6B025C::_id_9368FFF2B3156346(0);
}

_id_5A7760580ACB149C(_id_0C7488BC8F0EF820) {
  self endon("disconnect");
  self endon("oxygenmask_fired");
  self endon("oxygenmask_fail");
  level endon("game_ended");
  self waittill(_id_0C7488BC8F0EF820);
  self notify("oxygenmask_fail");
}

_id_CAD73059BABFBE29() {
  _id_4B87F2871B6B025C::_id_9368FFF2B3156346(0);
}

_id_DAB51E8A68583183() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("oxygenmask_tryShowHint");
  self endon("oxygenmask_tryShowHint");

  if(!isDefined(level._id_F6BAD8618358A031._id_4A80A7848A4968E2))
    level._id_F6BAD8618358A031._id_4A80A7848A4968E2 = [];

  _id_AFD4A4922443A15C = level._id_F6BAD8618358A031._id_4A80A7848A4968E2;
  entnum = self getentitynumber();

  if(!isDefined(_id_AFD4A4922443A15C[entnum]))
    _id_AFD4A4922443A15C[entnum] = 0;

  _id_D5A0474D01815168 = getdvarint("dvar_CFA01CDE7D01C1E2", 1);

  if(_id_D5A0474D01815168 <= _id_AFD4A4922443A15C[entnum])
    return;
  else {
    scripts\mp\utility\lower_message::setlowermessageomnvar("rebreather_hint");
    wait 5;
    scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
    _id_AFD4A4922443A15C[entnum]++;
    level._id_F6BAD8618358A031._id_4A80A7848A4968E2 = _id_AFD4A4922443A15C;
  }
}