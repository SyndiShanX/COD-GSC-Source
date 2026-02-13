/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\cp_swift_vengeance.gsc
*******************************************************/

init() {
  _id_0945::_id_C2B1("specialty_swift_vengeance", ::set_swift_vengeance, ::unset_swift_vengeance);

  if(!scripts\engine\utility::array_contains(level.damage_multiplier_callbacks, ::apply_swift_vengeance_damage)) {
    level.damage_multiplier_callbacks = scripts\engine\utility::array_add(level.damage_multiplier_callbacks, ::apply_swift_vengeance_damage);
  }
}

set_swift_vengeance() {
  thread swift_vengeance_movemenet_watcher();
}

unset_swift_vengeance() {
  self notify("end_swift_vengeance");
}

swift_vengeance_movemenet_watcher() {
  self endon("disconnect");
  self endon("end_swift_vengeance");
  self._id_8639 = 0;

  for(;;) {
    var_0 = self getvelocity();
    var_1 = _func_0134(var_0);

    if(self._id_8639) {
      if(var_1 == 0) {
        self._id_8639 = 0;
      }
    } else if(var_1 > 0) {
      self._id_8639 = 1;
      self.swift_vengeance_activation_time = gettime() + _id_0945::_id_664E("swift_vengeance_activation_time") * 1000;
    }

    waitframe();
  }
}

apply_swift_vengeance_damage(var_0) {
  if(is_swift_vengeance_active(var_0.attacker, var_0._id_9CD6, var_0._id_04F6)) {
    var_1 = var_0.attacker _id_0945::_id_664E("swift_vengeance_max_damage");
    var_2 = _func_0133(var_0.attacker getvelocity());
    var_3 = var_1 * ((var_2 - 120) / 280);
    return max(var_3, 0);
  }

  return 0;
}

is_swift_vengeance_active(var_0, var_1, var_2) {
  if(var_0 scripts\cp\utility::_hasperk("specialty_swift_vengeance") && isDefined(var_0.swift_vengeance_activation_time) && scripts\cp\covenants\cp_covenants::isvalidcovenantprimaryweapon(var_2, var_1, 1)) {
    return istrue(var_0._id_8639) && gettime() >= var_0.swift_vengeance_activation_time;
  }

  return 0;
}