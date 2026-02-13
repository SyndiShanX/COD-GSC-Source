/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2587.gsc
*************************************************/

_id_F19A() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "onGive", ::_id_F19B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "onTake", ::_id_F19D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "onStuck", ::_id_F19C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "tryToPickup", ::_id_F19E);
}

_id_F19B(var_0, var_1) {
  scripts\mp\utility\perk::_id_6FC2("specialty_equip_throwingKnife");
  thread _id_F1B7();
}

_id_F19D(var_0, var_1) {
  if(scripts\mp\utility\perk::_hasperk("specialty_equip_throwingKnife")) {
    scripts\mp\utility\perk::removeperk("specialty_equip_throwingKnife");
  }
}

_id_F19C(var_0, var_1, var_2) {
  var_0 setscriptablepartstate("showLocation", "active", 0);
  return 1;
}

_id_F19E(var_0) {
  if(scripts\mp\equipment::_id_6A0F(var_0) >= scripts\mp\equipment::_id_6A12(var_0)) {
    return 0;
  }

  scripts\mp\equipment::incrementequipmentammo(var_0);
  _id_07C4::_id_7B6B("throwingknife");
  return 1;
}

_id_F1B7() {
  self endon("throwingKnife_clear_fx");
  self endon("death_or_disconnect");
  var_0 = 0;

  for(;;) {
    var_1 = 0;
    var_2 = self getheldoffhand();

    if(!isnullweapon(var_2) && var_2.basename == "throwingknife_fire_mp") {
      var_1 = 1;
    }

    if(!var_1 && !var_0) {
      return;
    }
    if(var_1 && !var_0) {
      thread _id_F1B4();
    } else if(var_0 && !var_1) {
      thread _id_F1B6();
    }

    var_0 = var_1;
    waitframe();
  }
}

_id_F1B4() {
  self endon("death_or_disconnect");
  self endon("throwingKnife_end_fx");
  self._id_B868 = 1;
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "active", 0);
  var_0 = 0.4;
  wait(var_0);
  self setscriptablepartstate("equipMtovFXWorld", "active", 0);
}

_id_F1B6() {
  self notify("throwingKnife_end_fx");

  if(istrue(self._id_B868)) {
    self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
    self setscriptablepartstate("equipMtovFXView", "neutral", 0);
  }

  self._id_B868 = undefined;
}

_id_F1B5() {
  self notify("throwingKnife_clear_fx");
  thread _id_F1B6();
}