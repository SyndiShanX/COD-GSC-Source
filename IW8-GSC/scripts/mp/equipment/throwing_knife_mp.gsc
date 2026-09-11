/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\throwing_knife_mp.gsc
******************************************************/

function throwing_knife_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "onGive", &throwing_knife_mp_ongive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "onTake", &throwing_knife_mp_ontake);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "tryToPickup", &throwing_knife_mp_trytopickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "shallowWater", &ref_13b51);
}

function throwing_knife_mp_ongive(var0, var1) {
  if(var0 == "equip_throwing_knife_fire") {
    self.ref_13b5c = "iw8_throwingknife_fire_melee_mp";
    thread ref_13b5a();
  } else if(var0 == "equip_throwing_knife_electric") {
    self.ref_13b5c = "iw8_throwingknife_electric_melee_mp";
    thread ref_13b56();
  } else if(var0 == "equip_throwing_knife_drill") {
    self.ref_13b5c = "iw8_throwingknife_drill_melee_mp";
  } else {
    self.ref_13b5c = "iw8_knifestab_mp";
  }

  scripts\mp\utility\perk::giveperk("specialty_equip_throwingKnife");
}

function throwing_knife_mp_ontake(var0, var1) {
  if(scripts\mp\utility\perk::_hasperk("specialty_equip_throwingKnife")) {
    scripts\mp\utility\perk::removeperk("specialty_equip_throwingKnife");
  }

  self.ref_13b5c = undefined;
}

function throwing_knife_mp_trytopickup(var0) {
  if(scripts\mp\equipment::getequipmentammo(var0) >= scripts\mp\equipment::getequipmentmaxammo(var0)) {
    return false;
  }

  scripts\mp\equipment::incrementequipmentammo(var0);

  if(var0 == "equip_throwing_knife_fire") {
    scripts\mp\damagefeedback::hudicontype("throwingknife_fire");
  } else {
    scripts\mp\damagefeedback::hudicontype("throwingknife");
  }

  return true;
}

function ref_13b51(var0) {
  thread ref_13b59();
  var0 setscriptablepartstate("igniteWick", "neutral", 0);
}

function ref_13b5a() {
  self notify("throwingKnife_clear_fx");
  self endon("throwingKnife_clear_fx");
  self endon("death_or_disconnect");
  var0 = 0;

  for(;;) {
    var1 = 0;
    var2 = self getheldoffhand();

    if(!nullweapon(var2) && var2.basename == "throwingknife_fire_mp") {
      var1 = 1;
    }

    if(var1 && !var0) {
      thread ref_13b57();
    } else if(var0 && !var1) {
      thread ref_13b59();
    }

    var0 = var1;
    waitframe();
  }
}

function ref_13b57() {
  self endon("death_or_disconnect");
  self endon("throwingKnife_end_fx");
  self.ref_12748 = 1;
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "active", 0);
  var0 = 0.4;
  wait var0;
  self setscriptablepartstate("equipMtovFXWorld", "active", 0);
  self waittill("offhand_fired");
  waitframe();
  thread ref_13b59();
}

function ref_13b59() {
  self notify("throwingKnife_end_fx");

  if(istrue(self.ref_12748)) {
    self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
    self setscriptablepartstate("equipMtovFXView", "neutral", 0);
  }

  self.ref_12748 = undefined;
}

function ref_13b52() {
  self notify("throwingKnife_clear_fx");
  thread ref_13b59();
  thread ref_13b55();
}

function ref_13b56() {
  self notify("throwingKnife_electric_clear_fx");
  self endon("throwingKnife_electric_clear_fx");
  self endon("death_or_disconnect");
  var0 = 0;

  for(;;) {
    var1 = 0;
    var2 = self getheldoffhand();

    if(!nullweapon(var2) && var2.basename == "throwingknife_electric_mp") {
      var1 = 1;
    }

    if(var1 && !var0) {
      thread ref_13b53();
    } else if(var0 && !var1) {
      thread ref_13b55();
    }

    var0 = var1;
    waitframe();
  }
}

function ref_13b53() {
  self endon("death_or_disconnect");
  self endon("throwingKnife_electric_end_fx");
  self.ref_12747 = 1;
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "electricKnife", 0);
  var0 = 0.4;
  wait var0;
  self setscriptablepartstate("equipMtovFXWorld", "electricKnife", 0);
  self waittill("offhand_fired");
  waitframe();
  thread ref_13b55();
}

function ref_13b55() {
  self notify("throwingKnife_electric_end_fx");

  if(istrue(self.ref_12747)) {
    self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
    self setscriptablepartstate("equipMtovFXView", "neutral", 0);
  }

  self.ref_12747 = undefined;
}

function ref_13b54() {
  self notify("throwingKnife_electric_clear_fx");
  thread ref_13b55();
}