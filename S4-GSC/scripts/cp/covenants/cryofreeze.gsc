/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\cryofreeze.gsc
*************************************************/

init() {
  _id_0945::_id_C2B1("covenant_cryofreeze", ::give_cryofreeze, ::take_cryofreeze);
  _id_0945::_id_C2B1("covenant_cryofreeze_legendary", ::give_cryofreeze_legendary, ::take_cryofreeze_legendary);
  _id_0945::_id_C2B1("cryo_freezes_specials");
  level._effect["zmb_cryofreeze_explosion"] = loadfx("vfx/s4/zombie_weapon/vfx_cov_cryofreeze_aoe.vfx");
}

give_cryofreeze() {
  var_0 = get_total_owners();

  if(var_0 == 1) {
    _id_06CB::_id_AA49(::apply_slow_on_damage);
  }
}

give_cryofreeze_legendary() {
  give_cryofreeze();
  var_0 = get_num_cryofreeze_owners("covenant_cryofreeze_legendary");

  if(var_0 == 1) {
    _id_06CB::_id_AA4A(::explode_ai_on_killed);
  }
}

take_cryofreeze() {
  var_0 = get_total_owners();

  if(var_0 == 0) {
    _id_06CB::_id_C416(::apply_slow_on_damage);
  }

  self.nextcryofreeze = undefined;
}

take_cryofreeze_legendary() {
  take_cryofreeze();
  var_0 = get_num_cryofreeze_owners("covenant_cryofreeze_legendary");

  if(var_0 == 0) {
    _id_06CB::_id_C417(::explode_ai_on_killed);
  }

  self.nextcryoexplosion = undefined;
}

get_total_owners() {
  var_0 = get_num_cryofreeze_owners("covenant_cryofreeze");
  var_1 = get_num_cryofreeze_owners("covenant_cryofreeze_legendary");
  return var_0 + var_1;
}

get_num_cryofreeze_owners(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp\utility::_hasperk(var_0)) {
      var_1++;
    }
  }

  return var_1;
}

apply_slow_on_damage(var_0) {
  if(can_apply_to_target(self, var_0) && should_apply_slow(var_0)) {
    apply_slow(self, var_0);
  }
}

can_apply_to_target(var_0, var_1) {
  if(!isDefined(var_0.zm_ai_category)) {
    return 0;
  }

  if(!isDefined(var_1._id_50FF) || !isPlayer(var_1._id_50FF)) {
    return 0;
  }

  switch (var_0.zm_ai_category) {
    case "normal":
      return 1;
    case "special":
      return var_1._id_50FF scripts\cp\utility::_hasperk("cryo_freezes_specials");
    default:
      return 0;
  }
}

should_apply_slow(var_0) {
  var_1 = var_0._id_50FF;
  var_2 = var_0._id_DE2B;
  var_3 = var_0._id_04F6;

  if(isDefined(var_1) && isPlayer(var_1) && scripts\cp\covenants\cp_covenants::isvalidcovenantprimaryweapon(var_3, var_2)) {
    var_4 = var_1 _id_0945::_id_664E("cryofreeze_chance");

    if(var_4 > 0.0) {
      var_5 = !isDefined(var_1.nextcryofreeze) || gettime() >= var_1.nextcryofreeze;

      if(var_5) {
        return randomfloat(1.0) < var_4;
      }
    }
  }

  return 0;
}

apply_slow(var_0, var_1) {
  var_2 = var_1._id_50FF;
  var_3 = var_2 _id_0945::_id_664E("cryofreeze_duration");
  var_4 = 1.0 - var_2 _id_0945::_id_664E("cryofreeze_slow_amount");
  var_5 = var_2 _id_0945::_id_664E("cryofreeze_cooldown") * 1000;
  var_2.nextcryofreeze = gettime() + var_5;

  if(var_2 scripts\cp\utility::_hasperk("covenant_cryofreeze_legendary")) {
    var_6 = spawnStruct();
    var_6.attacker = var_2;
    var_6.explosiondamage = var_2 _id_0945::_id_664E("cryofreeze_explosion_damage");
    var_0.cryoinfo = var_6;
  }

  if(!var_0 scripts\cp\zombies\zombie_slow::has_slow("cryofreeze_slow")) {
    var_0 scripts\cp\zombies\zm_field_upgrades_frost_blast::play_slow_fx();

    if(isDefined(var_0.set_frozen_func)) {
      var_0[[var_0.set_frozen_func]](1);
    }
  }

  var_0 scripts\cp\zombies\zombie_slow::slow("cryofreeze_slow", var_4, var_3, var_2, ::on_slow_end);
  _id_072A::addplayereffects("cryo_freeze_slow", var_0, var_2, var_3);
}

on_slow_end() {
  self.cryoinfo = undefined;
  scripts\cp\zombies\zm_field_upgrades_frost_blast::stop_slow_fx();

  if(isDefined(self.set_frozen_func)) {
    self[[self.set_frozen_func]](0);
  }
}

explode_ai_on_killed(var_0) {
  if(should_explode(self)) {
    do_explosion(self);
  }
}

should_explode(var_0) {
  if(isDefined(var_0.cryoinfo) && isDefined(var_0.cryoinfo.explosiondamage) && isDefined(var_0.cryoinfo.attacker)) {
    var_1 = var_0.cryoinfo.attacker;

    if(isDefined(var_1.nextcryoexplosion) && gettime() < var_1.nextcryoexplosion) {
      return 0;
    }

    var_2 = _func_0071(var_0.origin, 200);
    return var_2.size > 0;
  }

  return 0;
}

do_explosion(var_0) {
  var_1 = var_0.cryoinfo.attacker;
  var_2 = var_1 _id_0945::_id_664E("cryofreeze_explosion_cooldown") * 1000;
  var_3 = var_0.cryoinfo.explosiondamage;
  var_4 = var_0.origin + (0, 0, 60);
  playFX(level._effect["zmb_cryofreeze_explosion"], var_4);
  var_1 radiusdamage(var_4, 200, var_3, var_3, var_1, "MOD_UNKNOWN", "s4_cryofreeze_zm");
  var_5 = spawnStruct();
  var_5._id_50FF = var_1;
  var_6 = _func_0071(var_4, 200);
  var_7 = [];

  foreach(var_9 in var_6) {
    if(can_apply_to_target(var_9, var_5)) {
      var_7[var_7.size] = var_9;
    }
  }

  for(var_11 = 0; var_11 < 5 && var_11 < var_7.size; var_11++) {
    var_9 = var_7[var_11];
    apply_slow(var_9, var_5);
  }

  if(_func_0205("zmb_cryofreeze_explo")) {
    playsoundatpos(var_4, "zmb_cryofreeze_explo");
  }

  var_0.cryoinfo = undefined;
  var_1.nextcryoexplosion = gettime() + var_2;
}

is_cryofreeze_active(var_0, var_1, var_2) {
  if(isPlayer(var_0) && isDefined(var_1)) {
    if(var_1 scripts\cp\zombies\zombie_slow::has_applied_slow(var_0, "cryofreeze_slow")) {
      return 1;
    }

    if(isDefined(var_2) && isDefined(var_2.basename) && var_2.basename == "s4_cryofreeze_zm") {
      return 1;
    }
  }

  return 0;
}