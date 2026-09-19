/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\consumables\inv_rng_ability.gsc
*******************************************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("rng_ability", ::userngability, ::canuserngability, ::getrngabilitycharges);
}

canuserngability(var_0) {
  if(!_id_0561::_id_1F7B())
    return 0;

  return 1;
}

userngability(var_0) {
  var_1 = 30;
  var_2 = self;
  var_2 endon("disconnect");
  var_3 = var_2 get_random_other_role();
  var_2.rentingability = var_3.abilityname;
  var_2 thread _id_057A::_id_259E("consumable_zm_weapon_ability", var_1);
  var_2[[var_3._id_6AF7]]();
  var_4 = var_2 wait_for_timeout_or_disable(var_3.abilityname);
  var_2.rentingability = undefined;

  if(common_scripts\utility::_id_562E(var_4))
    var_2[[var_3._id_6AED]]();
}

wait_for_timeout_or_disable(var_0) {
  self endon("DisabledRoleAbility_" + var_0);
  wait 30;
  return 1;
}

get_random_other_role() {
  var_0 = [];
  var_1 = self;

  foreach(var_4, var_3 in level._id_7ED0) {
    if(_id_0547::_id_5565(var_4, "role_ability_melee_frenzy_zm")) {
      continue;
    }
    if(var_1 hasweapon(var_4)) {
      continue;
    }
    if(var_1 hasweapon("role_ability_taunt_zm") && _id_0547::_id_5565(var_4, "role_ability_camo_zm")) {
      continue;
    }
    if(var_1 hasweapon("role_ability_camo_zm") && _id_0547::_id_5565(var_4, "role_ability_taunt_zm")) {
      continue;
    }
    var_0[var_0.size] = var_3;
    var_3.abilityname = var_4;
  }

  return common_scripts\utility::random(var_0);
}

getrngabilitycharges(var_0) {
  if(!isDefined(var_0))
    var_0 = "";

  switch (var_0) {
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