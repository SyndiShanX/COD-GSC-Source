/*********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\cp_explosives_expert.gsc
*********************************************************/

init() {
  _id_0945::_id_C2B1("specialty_explosives_expert", ::give_explosives_expert, ::take_explosives_expert);
}

give_explosives_expert() {
  if(!scripts\engine\utility::array_contains(level.damage_multiplier_callbacks, ::apply_explosives_expert_damage)) {
    level.damage_multiplier_callbacks = scripts\engine\utility::array_add(level.damage_multiplier_callbacks, ::apply_explosives_expert_damage);
  }
}

take_explosives_expert() {
  foreach(var_1 in level.players) {
    if(var_1 scripts\cp\utility::_hasperk("specialty_explosives_expert")) {
      return;
    }
  }

  level.damage_multiplier_callbacks = scripts\engine\utility::array_remove(level.damage_multiplier_callbacks, ::apply_explosives_expert_damage);
}

apply_explosives_expert_damage(var_0) {
  var_1 = 0.0;

  if(isPlayer(var_0.attacker)) {
    if(_func_010F(var_0._id_9CD6) && var_0._id_04F6.basename != "s4_pi_raygun_mp") {
      var_2 = var_0.attacker _id_0945::_id_664E("explosives_expert_enemy_multiplier");

      if(isDefined(var_2) && var_2 > 0.0) {
        var_1 = var_2;
      }
    }
  }

  return var_1;
}

get_explosives_expert_self_reduction(var_0) {
  var_1 = 1.0;

  if(isPlayer(self) && scripts\cp\utility::_hasperk("specialty_explosives_expert") && var_0 != "s4_pi_raygun_mp") {
    var_2 = _id_0945::_id_664E("explosives_expert_self_reduction");

    if(isDefined(var_2)) {
      var_1 = clamp(1.0 - var_2, 0.0, 1.0);
    }
  }

  return var_1;
}

is_explosives_expert_active(var_0, var_1) {
  return isPlayer(var_0) && var_0 scripts\cp\utility::_hasperk("specialty_explosives_expert") && _func_010F(var_1);
}