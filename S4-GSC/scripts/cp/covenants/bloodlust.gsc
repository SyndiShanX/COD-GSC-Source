/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\bloodlust.gsc
*************************************************/

init() {
  _id_0945::_id_C2B1("covenant_bloodlust", ::give_bloodlust, ::take_bloodlust);
}

give_bloodlust() {
  if(!scripts\engine\utility::array_contains(level.damage_multiplier_callbacks, ::apply_bloodlust_damage)) {
    level.damage_multiplier_callbacks = scripts\engine\utility::array_add(level.damage_multiplier_callbacks, ::apply_bloodlust_damage);
  }
}

take_bloodlust() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::_hasperk("covenant_bloodlust")) {
      var_0 = 1;
      break;
    }
  }

  if(!istrue(var_0)) {
    level.damage_multiplier_callbacks = scripts\engine\utility::array_remove(level.damage_multiplier_callbacks, ::apply_bloodlust_damage);
  }
}

apply_bloodlust_damage(var_0) {
  if(!isDefined(var_0._id_9CD6) || !isDefined(var_0.attacker) || !isPlayer(var_0.attacker)) {
    return 0.0;
  }

  if(var_0._id_9CD6 == "MOD_MELEE") {
    var_1 = var_0.attacker _id_0945::_id_664E("bloodlust_extra_damage");

    if(isDefined(var_1) && var_1 > 0.0) {
      var_2 = var_1;
      var_0.attacker apply_bloodlust_heal();
      return var_2;
    }
  }

  return 0.0;
}

apply_bloodlust_heal() {
  if(self.health != self.maxhealth) {
    var_0 = _id_0945::_id_664E("bloodlust_heal");

    if(isDefined(var_0) && var_0 > 0.0) {
      var_1 = int(min(self.maxhealth * var_0, self.maxhealth - self.health));
      self.health = self.health + var_1;
      _id_070F::createhealevent(self, var_1, "bloodlust");
    }
  }
}

is_bloodlust_active(var_0, var_1) {
  return isPlayer(var_0) && var_0 scripts\cp\utility::_hasperk("covenant_bloodlust") && var_1 == "MOD_MELEE";
}