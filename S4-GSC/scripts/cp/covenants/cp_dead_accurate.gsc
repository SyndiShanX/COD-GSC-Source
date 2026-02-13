/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\cp_dead_accurate.gsc
*****************************************************/

init() {
  _id_0945::_id_C2B1("specialty_dead_accurate", ::set_dead_accurate, ::unset_dead_accurate);
  _id_0945::_id_C2B1("specialty_dead_accurate_legendary");

  if(!scripts\engine\utility::array_contains(level.damage_multiplier_callbacks, ::apply_dead_accurate_damage)) {
    level.damage_multiplier_callbacks = scripts\engine\utility::array_add(level.damage_multiplier_callbacks, ::apply_dead_accurate_damage);
  }
}

set_dead_accurate() {
  if(!isDefined(self.dead_accurate_enemies)) {
    self.dead_accurate_enemies = [];
  }

  thread dead_accurate_miss_watcher();
}

unset_dead_accurate() {
  self notify("end_dead_accurate");
  self.dead_accurate_enemies = undefined;
}

dead_accurate_zombie_damaged(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::_hasperk("specialty_dead_accurate_legendary");

  if(scripts\cp\covenants\cp_covenants::isvalidcovenantprimaryweapon(var_2, var_1)) {
    if(!var_3 && !istrue(self.dead_accurate_reset_running)) {
      thread dead_accurate_damage_reset();
    }

    var_4 = gettime();
    var_5 = var_0 getentitynumber();
    add_dead_accurate_enemy(var_5);

    if(isDefined(self.dead_accurate_enemies[var_5].last_hit_time) && self.dead_accurate_enemies[var_5].last_hit_time >= var_4) {
      return;
    }
    self.dead_accurate_enemies[var_5].last_hit_time = var_4;
    increment_dead_accurate_damage(var_5, var_3);
  }
}

add_dead_accurate_enemy(var_0) {
  if(!isDefined(self.dead_accurate_enemies[var_0])) {
    self.dead_accurate_enemies[var_0] = spawnStruct();
    self.dead_accurate_enemies[var_0].damage = 0;
    self.dead_accurate_enemies[var_0].damage_to_apply = 0;
  }
}

increment_dead_accurate_damage(var_0, var_1) {
  var_2 = _id_0945::_id_664E("consecutive_hit_damage_increase");
  var_3 = _id_0945::_id_664E("consecutive_hit_damage_max");

  if(var_1) {
    var_0 = 0;
    add_dead_accurate_enemy(0);
    self.dead_accurate_enemies[0].last_hit_time = gettime();
  }

  var_4 = self.dead_accurate_enemies[var_0].damage;
  var_5 = min(var_3, var_4 + var_2);
  self.dead_accurate_enemies[var_0].damage = var_5;
  self.dead_accurate_enemies[var_0].damage_to_apply = scripts\engine\utility::ter_op(var_1, var_5, var_4);
}

dead_accurate_miss_watcher() {
  self endon("disconnect");
  self endon("end_dead_accurate");

  for(;;) {
    self waittill("shot_missed", var_0);

    if(var_0.type == "bullet" || var_0.type == "projectile") {
      self.dead_accurate_enemies = [];
    }
  }
}

apply_dead_accurate_damage(var_0) {
  if(isDefined(var_0.attacker) && var_0.attacker scripts\cp\utility::_hasperk("specialty_dead_accurate") && scripts\cp\covenants\cp_covenants::isvalidcovenantprimaryweapon(var_0._id_04F6, var_0._id_9CD6)) {
    var_1 = var_0.attacker get_dead_accurate_entity_number(self);

    if(isDefined(var_0.attacker.dead_accurate_enemies[var_1])) {
      return scripts\cp\utility::_id_459B(var_0.attacker.dead_accurate_enemies[var_1].damage_to_apply, 0);
    }
  }

  return 0;
}

is_dead_accurate_active(var_0, var_1, var_2, var_3) {
  if(isPlayer(var_0) && isDefined(var_1) && var_0 scripts\cp\utility::_hasperk("specialty_dead_accurate") && scripts\cp\covenants\cp_covenants::isvalidcovenantprimaryweapon(var_3, var_2)) {
    var_4 = var_0 get_dead_accurate_entity_number(var_1);
    var_5 = var_0 _id_0945::_id_664E("consecutive_hit_damage_increase");

    if(isDefined(var_0.dead_accurate_enemies[var_4])) {
      return isDefined(var_0.dead_accurate_enemies[var_4].damage) && var_0.dead_accurate_enemies[var_4].damage > var_5;
    }
  }

  return 0;
}

dead_accurate_damage_reset() {
  self endon("disconnect");
  self endon("end_dead_accurate");
  var_0 = gettime();
  self.dead_accurate_reset_running = 1;
  waittillframeend;
  var_1 = self.dead_accurate_enemies;
  self.dead_accurate_enemies = [];

  foreach(var_4, var_3 in var_1) {
    if(var_3.last_hit_time >= var_0) {
      var_3.damage_to_apply = var_3.damage;
      self.dead_accurate_enemies[var_4] = var_3;
    }
  }

  self.dead_accurate_reset_running = 0;
}

get_dead_accurate_entity_number(var_0) {
  if(scripts\cp\utility::_hasperk("specialty_dead_accurate_legendary")) {
    return 0;
  }

  return var_0 getentitynumber();
}