/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\throwing_knife_cp.gsc
******************************************************/

function throwing_knife_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "tryToPickup", &ref_13b50);
}

function ref_13b50(var_0) {
  if(scripts\cp\cp_powers::haspower("power_throwingKnife")) {
    var_1 = "power_throwingKnife";
  } else if(scripts\cp\cp_powers::haspower("power_throwingKnife_fire")) {
    var_1 = "power_throwingKnife_fire";
  } else if(scripts\cp\cp_powers::haspower("power_throwingKnife_electric")) {
    var_1 = "power_throwingKnife_electric";
  } else if(scripts\cp\cp_powers::haspower("power_throwingKnife_drill")) {
    var_1 = "power_throwingKnife_drill";
  } else {
    return false;
  }

  var_2 = self.powers[var_1].charges;
  var_3 = self.powers[var_1].maxcharges;

  if(var_2 + 1 > var_3) {
    return false;
  }

  scripts\cp\cp_powers::power_adjustcharges(1, "primary");
  scripts\cp\cp_damagefeedback::hudicontype("throwingknife");
  return true;
}