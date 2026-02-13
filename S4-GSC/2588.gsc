/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2588.gsc
*************************************************/

_id_F1A8() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_star", "onGive", ::_id_F1A9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_star", "onTake", ::_id_F1AB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_star", "onStuck", ::_id_F1AA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_star", "tryToPickup", ::_id_F1AC);
}

_id_F1A9(var_0, var_1) {
  scripts\mp\utility\perk::_id_6FC2("specialty_equip_throwingKnife");
  thread _id_F1C8();
}

_id_F1AB(var_0, var_1) {
  if(scripts\mp\utility\perk::_hasperk("specialty_equip_throwingStar")) {
    scripts\mp\utility\perk::removeperk("specialty_equip_throwingStar");
  }
}

_id_F1AA(var_0, var_1, var_2) {
  var_0 setscriptablepartstate("showLocation", "active", 0);
  return 1;
}

_id_F1AC(var_0) {
  if(scripts\mp\equipment::_id_6A0F(var_0) >= scripts\mp\equipment::_id_6A12(var_0)) {
    return 0;
  }

  scripts\mp\equipment::incrementequipmentammo(var_0);
  _id_07C4::_id_7B6B("throwingStar");
  return 1;
}

_id_F1C8() {
  self endon("throwingStar_clear_fx");
  self endon("death_or_disconnect");
  var_0 = 0;

  for(;;) {
    var_1 = 0;
    var_2 = self getheldoffhand();

    if(!isnullweapon(var_2) && var_2.basename == "throwingstar_fire_mp") {
      var_1 = 1;
    }

    if(!var_1 && !var_0) {
      return;
    }
    if(var_1 && !var_0) {
      thread _id_F1C5();
    } else if(var_0 && !var_1) {
      thread _id_F1C7();
    }

    var_0 = var_1;
    waitframe();
  }
}

_id_F1C5() {
  self endon("death_or_disconnect");
  self endon("throwingStar_end_fx");
  self._id_B869 = 1;
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "active", 0);
  var_0 = 0.4;
  wait(var_0);
  self setscriptablepartstate("equipMtovFXWorld", "active", 0);
}

_id_F1C7() {
  self notify("throwingStar_end_fx");

  if(istrue(self._id_B869)) {
    self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
    self setscriptablepartstate("equipMtovFXView", "neutral", 0);
  }

  self._id_B869 = undefined;
}

_id_F1C6() {
  self notify("throwingStar_clear_fx");
  thread _id_F1C7();
}