/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\cp_covenants.gsc
*************************************************/

init_covenants() {
  scripts\cp\covenants\bloodlust::init();
  scripts\cp\covenants\splatterfest::init();
  scripts\cp\covenants\cull_the_weak::init();
  scripts\cp\covenants\cryofreeze::init();
  scripts\cp\covenants\cp_ammo_gremlin::init();
  scripts\cp\covenants\cp_dead_accurate::init();
  scripts\cp\covenants\cp_brain_rot::init();
  scripts\cp\covenants\cp_brimstone::init();
  scripts\cp\covenants\cp_dead_wire::init();
  scripts\cp\covenants\cp_swift_vengeance::init();
  scripts\cp\covenants\cp_artifact_defense_system::init();
  scripts\cp\covenants\cp_explosives_expert::init();
  scripts\cp\covenants\cp_critical_expertise::init();
  init_unholy_ground();
  init_deadshot_daiquiri();
  _id_0945::_id_C2B1("specialty_proximity_revive");
  _id_0945::_id_C2B1("specialty_stationary_damage", ::set_stationary_damage, ::unset_stationary_damage);
  _id_0945::_id_C2B1("specialty_scrapper");
}

damage_covenant_active(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isPlayer(var_1) || !isDefined(var_0)) {
    return 0;
  }

  if(scripts\cp\covenants\bloodlust::is_bloodlust_active(var_1, var_8)) {
    return 1;
  }

  if(scripts\cp\covenants\cull_the_weak::is_cull_the_weak_active(var_1, var_0)) {
    return 1;
  }

  if(scripts\cp\covenants\cp_dead_accurate::is_dead_accurate_active(var_1, var_0, var_8, var_3)) {
    return 1;
  }

  if(is_unholy_ground_active(var_1)) {
    return 1;
  }

  if(scripts\cp\covenants\cp_brain_rot::is_brain_rot_active(var_2)) {
    return 1;
  }

  if(scripts\cp\covenants\cryofreeze::is_cryofreeze_active(var_1, var_0, var_3)) {
    return 1;
  }

  if(scripts\cp\covenants\splatterfest::is_splatterfest_active(var_3)) {
    return 1;
  }

  if(scripts\cp\covenants\cp_brimstone::is_brimstone_damage(var_3)) {
    return 1;
  }

  if(is_deadshot_daiquiri_active(var_0, var_1, var_3, var_6, var_8)) {
    return 1;
  }

  if(scripts\cp\covenants\cp_dead_wire::is_dead_wire_active(var_0, var_1)) {
    return 1;
  }

  if(scripts\cp\covenants\cp_swift_vengeance::is_swift_vengeance_active(var_1, var_8, var_3)) {
    return 1;
  }

  if(scripts\cp\covenants\cp_explosives_expert::is_explosives_expert_active(var_1, var_8)) {
    return 1;
  }

  if(scripts\cp\covenants\cp_critical_expertise::is_critical_expertise_active(var_1, var_0)) {
    return 1;
  }

  return 0;
}

isvalidcovenantprimaryweapon(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    var_3 = scripts\cp\utility::_id_6E6D(var_0);

    if(var_3 == "weapon_melee" || var_3 == "weapon_melee2") {
      return scripts\cp\utility::_id_88D7(var_0);
    }
  }

  return scripts\cp\utility::_id_88D7(var_0) && var_1 != "MOD_MELEE";
}

init_unholy_ground() {
  if(!scripts\engine\utility::array_contains(level.damage_multiplier_callbacks, ::apply_unholy_ground_damage)) {
    level.damage_multiplier_callbacks = scripts\engine\utility::array_add(level.damage_multiplier_callbacks, ::apply_unholy_ground_damage);
  }
}

apply_unholy_ground_damage(var_0) {
  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker)) {
    return 0;
  }

  if(isDefined(var_0._id_04F6) && (var_0._id_04F6.classname == "grenade" || var_0._id_04F6.classname == "throwingknife")) {
    return 0;
  }

  if(isDefined(var_0._id_9CD6) && var_0._id_9CD6 == "MOD_MELEE") {
    return 0;
  }

  if(var_0.attacker getvelocity() == (0, 0, 0) || isDefined(var_0.attacker.end_stationary_damage) && gettime() < var_0.attacker.end_stationary_damage) {
    return var_0.attacker _id_0945::_id_664E("stationary_damage_increase");
  }

  return 0;
}

is_unholy_ground_active(var_0) {
  if(isPlayer(var_0) && var_0 _id_0945::_id_664E("stationary_damage_increase") > 0) {
    return var_0 getvelocity() == (0, 0, 0) || isDefined(var_0.end_stationary_damage) && gettime() < var_0.end_stationary_damage;
  }

  return 0;
}

set_stationary_damage() {
  thread stationary_damage_watcher();
}

stationary_damage_watcher() {
  self endon("disconnect");
  self notify("end_stationary_damage");
  self endon("end_stationary_damage");
  waittillframeend;
  var_0 = _id_0945::_id_664E("stationary_damage_increase_duration");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    if(self getvelocity() == (0, 0, 0)) {
      self.end_stationary_damage = gettime() + var_0;
    }

    waitframe();
  }
}

unset_stationary_damage() {
  self notify("end_stationary_damage");
}

init_deadshot_daiquiri() {
  if(!scripts\engine\utility::array_contains(level.damage_multiplier_callbacks, ::apply_deadshot_daiquiri_damage)) {
    level.damage_multiplier_callbacks = scripts\engine\utility::array_add(level.damage_multiplier_callbacks, ::apply_deadshot_daiquiri_damage);
  }
}

apply_deadshot_daiquiri_damage(var_0) {
  if(!isDefined(var_0.attacker.guid) || !scripts\cp\utility::_id_8891(var_0._id_04F6, var_0._id_D9E0, var_0._id_9CD6, var_0.attacker)) {
    return 0;
  }

  if(!isDefined(self.num_critical_hits)) {
    self.num_critical_hits = [];
  }

  if(!isDefined(self.num_critical_hits[var_0.attacker.guid])) {
    self.num_critical_hits[var_0.attacker.guid] = 0;
  }

  self.num_critical_hits[var_0.attacker.guid]++;

  if(self.num_critical_hits[var_0.attacker.guid] == 1) {
    return var_0.attacker _id_0945::_id_664E("deadshot_daiquiri_bonus_damage");
  }

  return 0;
}

is_deadshot_daiquiri_active(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1.guid) || !scripts\cp\utility::_id_8891(var_2, var_3, var_4, var_1)) {
    return 0;
  }

  if(isDefined(var_0.num_critical_hits) && isDefined(var_0.num_critical_hits[var_1.guid])) {
    return var_0.num_critical_hits[var_1.guid] == 1 && var_1 _id_0945::_id_664E("deadshot_daiquiri_bonus_damage") > 0;
  }

  return 0;
}

is_covenant_weapon(var_0) {
  var_1 = 0;
  var_2 = scripts\cp\utility::getweaponrootname(var_0);

  if(var_2 == "s4_brain_rot_explosion" || var_2 == "s4_brimstone" || var_2 == "s4_cryofreeze" || var_2 == "s4_splatterfest") {
    var_1 = 1;
  }

  return var_1;
}