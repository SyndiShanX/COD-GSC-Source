/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\cull_the_weak.gsc
**************************************************/

init() {
  _id_0945::_id_C2B1("covenant_cull_the_weak", ::give_cull_the_weak, ::take_cull_the_weak);
}

give_cull_the_weak() {
  if(!scripts\engine\utility::array_contains(level.damage_multiplier_callbacks, ::apply_cull_the_weak_damage)) {
    level.damage_multiplier_callbacks = scripts\engine\utility::array_add(level.damage_multiplier_callbacks, ::apply_cull_the_weak_damage);
  }
}

take_cull_the_weak() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::_hasperk("covenant_cull_the_weak")) {
      var_0 = 1;
      break;
    }
  }

  if(!istrue(var_0)) {
    level.damage_multiplier_callbacks = scripts\engine\utility::array_remove(level.damage_multiplier_callbacks, ::apply_cull_the_weak_damage);
  }
}

apply_cull_the_weak_damage(var_0) {
  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker)) {
    return 0.0;
  }

  var_1 = scripts\cp\zombies\zombie_slow::is_slowed();
  var_2 = scripts\aitypes\zombie_common\stun::is_stunned();

  if(var_1 || var_2) {
    var_3 = var_0.attacker _id_0945::_id_664E("cull_the_weak_extra_damage");

    if(isDefined(var_3) && var_3 > 0.0) {
      return var_3;
    }
  }

  return 0.0;
}

apply_cull_the_weak_bonus_crit_damage(var_0, var_1, var_2, var_3, var_4) {
  if(!isPlayer(var_0)) {
    return var_1;
  }

  var_5 = scripts\cp\zombies\zombie_slow::is_slowed();
  var_6 = scripts\aitypes\zombie_common\stun::is_stunned();

  if((var_5 || var_6) && scripts\cp\utility::_id_8891(var_3, var_4, var_2, var_0)) {
    var_1 = var_1 * var_0 _id_0945::_id_664E("cull_the_weak_crit_damage_multiplier");
  }

  return var_1;
}

is_cull_the_weak_active(var_0, var_1) {
  if(isPlayer(var_0) && isDefined(var_1) && var_0 scripts\cp\utility::_hasperk("covenant_cull_the_weak")) {
    var_2 = var_1 scripts\cp\zombies\zombie_slow::is_slowed();
    var_3 = var_1 scripts\aitypes\zombie_common\stun::is_stunned();
    return var_2 || var_3;
  }

  return 0;
}