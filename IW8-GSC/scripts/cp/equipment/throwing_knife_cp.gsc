/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\throwing_knife_cp.gsc
******************************************************/

function throwing_knife_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "tryToPickup", &ref_13b50);
}

function ref_13b50(var0) {
  if(scripts\cp\cp_powers::haspower("power_throwingKnife")) {
    var1 = "power_throwingKnife";
  } else if(scripts\cp\cp_powers::haspower("power_throwingKnife_fire")) {
    var1 = "power_throwingKnife_fire";
  } else if(scripts\cp\cp_powers::haspower("power_throwingKnife_electric")) {
    var1 = "power_throwingKnife_electric";
  } else if(scripts\cp\cp_powers::haspower("power_throwingKnife_drill")) {
    var1 = "power_throwingKnife_drill";
  } else {
    return false;
  }

  var2 = self.powers[var1].charges;
  var3 = self.powers[var1].maxcharges;

  if(var2 + 1 > var3) {
    return false;
  }

  scripts\cp\cp_powers::power_adjustcharges(1, "primary");
  scripts\cp\cp_damagefeedback::hudicontype("throwingknife");
  return true;
}