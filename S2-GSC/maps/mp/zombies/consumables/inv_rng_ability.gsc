/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\consumables\inv_rng_ability.gsc
***********************************************************/

func_52A4() {
  lib_0561::initconsumablesfromtable("rng_ability", ::userngability, ::canuserngability, ::getrngabilitycharges);
}

canuserngability(param_00) {
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  return 1;
}

userngability(param_00) {
  var_01 = 30;
  var_02 = self;
  var_02 endon("disconnect");
  var_03 = var_02 get_random_other_role();
  var_02.rentingability = var_03.abilityname;
  var_02 thread lib_057A::func_259E("consumable_zm_weapon_ability", var_01);
  var_02[[var_03.var_6AF7]]();
  var_04 = var_02 wait_for_timeout_or_disable(var_03.abilityname);
  var_02.rentingability = undefined;
  if(common_scripts\utility::func_562E(var_04)) {
    var_02[[var_03.var_6AED]]();
  }
}

wait_for_timeout_or_disable(param_00) {
  self endon("DisabledRoleAbility_" + param_00);
  wait(30);
  return 1;
}

get_random_other_role() {
  var_00 = [];
  var_01 = self;
  foreach(var_04, var_03 in level.var_7ED0) {
    if(lib_0547::func_5565(var_04, "role_ability_melee_frenzy_zm")) {
      continue;
    }

    if(var_01 hasweapon(var_04)) {
      continue;
    }

    if(var_01 hasweapon("role_ability_taunt_zm") && lib_0547::func_5565(var_04, "role_ability_camo_zm")) {
      continue;
    }

    if(var_01 hasweapon("role_ability_camo_zm") && lib_0547::func_5565(var_04, "role_ability_taunt_zm")) {
      continue;
    }

    var_00[var_00.size] = var_03;
    var_03.abilityname = var_04;
  }

  return common_scripts\utility::func_7A33(var_00);
}

getrngabilitycharges(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "";
  }

  switch (param_00) {
    case "epic":
      return 4;

    case "legendary":
      return 3;

    case "rare":
      return 2;

    case "common":
      return 1;

    default:
      return 0;
  }
}