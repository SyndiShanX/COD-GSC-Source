/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_health_regen.gsc
*****************************************************/

#using script_4a1e83805671ae57;
#using script_725554a59d6a75b9;
#using scripts\abilities\ability_player;
#using scripts\abilities\ability_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace gadget_health_regen;

function private autoexec __init__system__() {
  system::register(#"gadget_health_regen", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  ability_player::register_gadget_activation_callbacks(23, &gadget_health_regen_on, &gadget_health_regen_off);
  ability_player::register_gadget_possession_callbacks(23, &gadget_health_regen_on_give, &gadget_health_regen_on_take);
  clientfield::register("toplayer", "healthregen", 1, 1, "int");
  clientfield::register_clientuimodel("hudItems.healingActive", 1, 1, "int");
  clientfield::register_clientuimodel("hudItems.numHealthPickups", 1, 2, "int");
  callback::on_spawned(&on_player_spawned);
  callback::on_player_damage(&on_player_damage);
  callback::add_callback(#"on_status_effect", &on_status_effect);
  callback::add_callback(#"on_buff", &on_buff);
  callback::add_callback(#"on_ai_killed", &function_3a6741ee);
  level.var_3a536ce3 = getweapon(#"hash_5768c7fdf2dc422e");

  if(!isDefined(level.var_f71267dc)) {
    level.var_f71267dc = &function_b5b7d60e;
  }

  if(!isDefined(level.var_11e731d7)) {
    level.var_11e731d7 = &function_582035b1;
  }

  if(!isDefined(level.var_a77fcfbe)) {
    level.var_a77fcfbe = &function_dafd9cd;
  }

  assert(level.var_3a536ce3.name != "<dev string:x38>", "<dev string:x40>");
}

function on_status_effect(var_756fda07) {
  if(is_true(var_756fda07.var_29f71617)) {
    self function_aba28004();
  }
}

function on_buff() {
  self function_aba28004();
}

function gadget_health_regen_on_give(slot, weapon) {
  self.gadget_health_regen_slot = slot;
  self.gadget_health_regen_weapon = weapon;
  weapon.ignore_grenade = 1;

  if(isDefined(weapon) && weapon.maxheal) {
    self player::function_9080887a(weapon.maxheal);
    return;
  }

  self player::function_9080887a();
}

function gadget_health_regen_on_take(slot, weapon) {
  self.gadget_health_regen_slot = undefined;
  self player::function_9080887a();
}

function on_player_spawned() {
  self function_d91a057d();

  if(isDefined(level.var_c018953f)) {
    if(!level.var_c018953f stim_count::is_open(self)) {
      level.var_c018953f stim_count::open(self, 1);
    }
  }

  if(getdvarint(#"hash_4a424b02130fa0c0", 0) > 0) {
    stim_count = getdvarint(#"hash_4a424b02130fa0c0", 0);
    self function_6eef7f4f(stim_count);
  }
}

function function_6eef7f4f(stim_count) {
  stim_count = math::clamp(stim_count, 0, 9);
  self.var_f2a5bd01 = stim_count;

  if(isDefined(level.var_c018953f)) {
    level.var_c018953f stim_count::function_6eef7f4f(self, stim_count);
  }
}

function function_36ac3c21() {
  self clientfield::set_to_player("healthregen", 1);
}

function function_ddfdddb1() {
  self clientfield::set_to_player("healthregen", 1);
  battlechatter::function_30146e82(self);
}

function heal_start() {
  self notify(#"healing");
  self clientfield::set_player_uimodel("hudItems.healingActive", 1);
}

function heal_end() {
  if(!isDefined(self) || !isDefined(self.heal)) {
    return;
  }

  self.heal.var_a1cac2f1 = 0;
  self.heal.enabled = 0;
  self.heal.var_bc840360 = 0;
  self.heal.var_f0f1ff36 = 0;
  self notify(#"healing_disabled");
  self player::function_9080887a();
  self clientfield::set_player_uimodel("hudItems.healingActive", 0);
  self clientfield::set_to_player("healthregen", 0);
}

function function_a1a8b5e5() {
  modifier = 1;

  if(self hastalent(#"hash_504b40f717f89167") || self hastalent(#"hash_504b3ff717f88fb4") || self hastalent(#"hash_504b3ef717f88e01") || self hastalent(#"hash_504b3df717f88c4e")) {
    modifier = 0.5;
  }

  return modifier;
}

function function_ef6c7869(now) {
  if(self.laststand === 1 && self.var_8fd58a32 !== 1) {
    return;
  }

  var_337562a8 = isDefined(self.var_337562a8) ? self.var_337562a8 : level.var_3a536ce3;
  var_f60dece = function_a1a8b5e5();
  total_time = [[level.var_11e731d7]](var_337562a8) * var_f60dece;

  if(now - self.lastdamagetime < total_time) {
    return;
  }

  profilestart();
  self function_36ac3c21();
  self thread enable_healing_after_wait(undefined, var_337562a8, getdvarfloat(#"hash_57be38bf0a00809d", 0), 0.5, self);
  profilestop();
}

function function_34daf34a(slot, weapon) {
  if(self gadgetsdisabled()) {
    return;
  }

  if(weapon === getweapon(#"gadget_health_regen_squad")) {
    self function_bc0ce7d5(slot, weapon);
    return;
  }

  self function_ddfdddb1();
  self thread enable_healing_after_wait(slot, weapon, getdvarfloat(#"hash_57be38bf0a00809d", 0), 0.5, self);
}

function function_bc0ce7d5(slot, weapon) {
  var_1594ab5 = self function_941ed5d6();

  for(i = 0; i < 4; i++) {
    if(isalive(var_1594ab5[i])) {
      profilestart();

      if(is_true(var_1594ab5[i].laststand)) {
        if(isDefined(var_1594ab5[i].var_84c0402e)) {
          var_1594ab5[i].bleedout_time = var_1594ab5[i].var_84c0402e;
        }
      } else {
        var_1594ab5[i] function_ddfdddb1();
        var_1594ab5[i] thread enable_healing_after_wait(slot, weapon, getdvarfloat(#"hash_57be38bf0a00809d", 0), 0.5, self);
      }

      profilestop();
    }
  }
}

function function_941ed5d6() {
  if(isDefined(self.team)) {
    var_1594ab5 = getplayers(self.team, self.origin, 1500);
  } else {
    var_1594ab5 = array(self);
  }

  return var_1594ab5;
}

function function_aa2c622b(weapon) {
  return weapon.name === # "gadget_health_regen" || weapon.name === # "gadget_medicalinjectiongun" || weapon.name === # "hash_788c96e19cc7a46e";
}

function gadget_health_regen_on(slot, weapon) {
  if(sessionmodeiswarzonegame() && !function_aa2c622b(weapon)) {
    self.var_eedfcc6e = gettime();
    return;
  }

  function_34daf34a(slot, weapon);
}

function gadget_health_regen_off(slot, weapon) {
  if(!sessionmodeiswarzonegame() && !function_aa2c622b(weapon)) {
    return;
  }

  if(isDefined(self.var_eedfcc6e)) {
    var_d9dbb072 = 0;
    usage_rate = self function_c1b7eefa(weapon);

    if(usage_rate > 0) {
      var_d9dbb072 = weapon.gadget_powermax / usage_rate;
    }

    if(int(var_d9dbb072 * 1000) + self.var_eedfcc6e <= gettime() + 100) {
      function_34daf34a(slot, weapon);
    } else {
      self gadgetpowerset(slot, weapon.gadget_powermax);
    }

    self.var_eedfcc6e = undefined;
  }
}

function enable_healing_after_wait(slot, weapon, wait_time, var_5818bd22, player) {
  self notify(#"healing_preamble");
  self.heal.var_a1cac2f1 = gettime() + var_5818bd22;
  waitresult = self waittilltimeout(wait_time, #"death", #"disconnect", #"healing_disabled", #"healing_preamble");

  if(waitresult._notify != "timeout") {
    return;
  }

  self enable_healing(slot, weapon, player);
}

function enable_healing(slot, weapon, player) {
  if(!isDefined(self)) {
    return;
  }

  if(self gadgetsdisabled()) {
    return;
  }

  self heal_start();

  if(isDefined(weapon) && weapon.maxheal) {
    self player::function_9080887a(weapon.maxheal);
  } else {
    self player::function_9080887a();
  }

  if(isDefined(self.var_9cd2c51d)) {
    if(!self.heal.enabled) {
      self.var_9cd2c51d.var_c54af9a9 = gettime();
      self.var_9cd2c51d.var_6e219f3c = self.health;
    }

    self.var_9cd2c51d.var_43797ec0 = weapon;

    if(weapon !== level.var_3a536ce3) {
      self.var_9cd2c51d.var_63362b1e = gettime();
      self.var_9cd2c51d.var_158e75d4 = weapon.statname;
      self.var_9cd2c51d.var_697d048e = 1;
    }
  }

  var_bc840360 = self.health;

  if(self.heal.enabled) {
    if(isDefined(self.heal.var_bc840360) && self.heal.var_bc840360 > 0) {
      var_bc840360 = self.heal.var_bc840360;
    }
  }

  if(weapon.heal) {
    max_health = self.maxhealth;

    if(weapon.maxheal && !getdvarint(#"hash_573a1edd4b4143e4", 0)) {
      max_health = weapon.maxheal;
    }

    self.heal.var_bc840360 = math::clamp(weapon.heal + var_bc840360, 0, max_health);

    if(self.heal.var_bc840360 == 0) {
      return;
    }
  } else {
    self.heal.var_bc840360 = 0;
  }

  self.heal.var_f0f1ff36 = weapon === level.var_3a536ce3;
  var_b16fafc9 = 0;

  if(!self.heal.enabled) {
    if(self secondaryoffhandbuttonPressed()) {
      if(isDefined(self.var_f2a5bd01) && self.var_f2a5bd01 > 0) {
        self function_6eef7f4f(self.var_f2a5bd01 - 1);
        var_b16fafc9 = 1;
        self playrumbleonentity("stim_heal");
      }
    }
  }

  var_4465ef1e = player[[level.var_f71267dc]](var_b16fafc9, weapon);

  if(var_4465ef1e > 0) {
    heal_amount = weapon.heal;

    if(heal_amount <= 0 && isDefined(self.var_66cb03ad)) {
      heal_amount = self.var_66cb03ad;
    }

    self.heal.rate = heal_amount / float(var_4465ef1e) / 1000;
    var_9c776d17 = self function_4e64ede5();

    if(isfloat(var_9c776d17)) {
      self.heal.rate *= var_9c776d17;
    }

    self.heal.heal_amount = heal_amount;
    self.heal.var_4e6c244d = weapon.var_db003065;
  } else {
    self.heal.rate = 0;
  }

  if(isDefined(slot)) {
    self function_820a63e9(slot, 1);
  }

  if(isDefined(level.var_d3b4a4db) && self === player) {
    self[[level.var_d3b4a4db]](var_b16fafc9);
  }

  if(isDefined(self.var_121392a1)) {
    foreach(se in self.var_121392a1) {
      params = se.var_4f6b79a4;

      if(params.var_abac379d === 1) {
        status_effect::function_408158ef(params.setype, params.var_18d16a6b);
      }
    }
  }

  was_enabled = self.heal.enabled;
  self.heal.enabled = 1;

  if(getdvarint(#"hash_7f9cfdea69a18091", 1) == 1) {
    if(!was_enabled) {
      self.heal.var_f37a08a8 = gettime();
      self.heal.var_fa57541f = self.health;
    }
  }

  self callback::callback(#"hash_4b807b1167b4a811");
  self callback::function_d8abfc3d(#"done_healing", &function_4e449209);

  if(isDefined(self.health) && isDefined(self.var_66cb03ad) && self.health >= self.var_66cb03ad) {
    self function_4e449209();
  }
}

function function_b5b7d60e(var_b16fafc9, weapon) {
  return var_b16fafc9 ? self function_442af617(weapon) : self function_89a98197(weapon);
}

function function_582035b1(var_337562a8) {
  return var_337562a8.var_5b053313;
}

function function_d91a057d(slot = ability_util::gadget_slot_for_type(23)) {
  if(isDefined(slot)) {
    self function_820a63e9(slot, 0);
  }

  if(is_healing()) {
    self heal_end();
  }
}

function is_healing() {
  return isDefined(self) && isDefined(self.heal) && is_true(self.heal.enabled);
}

function function_4e449209() {
  self endon(#"disconnect");

  if(isDefined(self)) {
    self.heal.var_a1cac2f1 = 0;

    if(isDefined(level.var_d9ae19f0)) {
      level[[level.var_d9ae19f0]](self);
    }

    self callback::function_52ac9652(#"done_healing", &function_4e449209);

    if(self is_healing()) {
      if(!isDefined(self.var_c443b227)) {
        self thread battlechatter::function_78c16252();
      }
    }

    self function_d91a057d();
  }
}

function on_player_damage(params) {
  if(!self is_healing()) {
    return;
  }

  attacker = params.eattacker;
  damage = params.idamage;

  if(self[[level.var_a77fcfbe]](attacker, damage) == 0) {
    self.heal.var_bc840360 = math::clamp(self.heal.var_bc840360 - damage, 0, self.heal.var_bc840360);
    return;
  }

  function_18e0320b();
}

function function_aba28004() {
  if(!isPlayer(self)) {
    return;
  }

  self function_18e0320b();
}

function private function_18e0320b() {
  if(self is_healing()) {
    self function_d91a057d();
  }
}

function private function_dafd9cd(attacker, damage) {
  if(gettime() < self.heal.var_a1cac2f1) {
    return false;
  }

  if(damage < getdvarfloat(#"hash_3671f84e911fb747", isDefined(level.var_5714f442) ? level.var_5714f442 : 0)) {
    return false;
  }

  if(isDefined(level.deathcircle) && level.deathcircle === attacker) {
    return false;
  }

  return true;
}

function function_831bf182() {
  can_set = isDefined(self.gadget_health_regen_slot);

  if(!can_set || "ammo" == self.gadget_health_regen_weapon.gadget_powerusetype) {
    return 0;
  }

  return can_set;
}

function power_off() {
  if(self function_831bf182()) {
    self gadgetpowerset(self.gadget_health_regen_slot, 0);
  }
}

function power_on() {
  if(self function_831bf182()) {
    self gadgetpowerset(self.gadget_health_regen_slot, self.gadget_health_regen_weapon.gadget_powermax);
  }
}

function function_3a6741ee(params) {
  attacker = params.eattacker;

  if(!isPlayer(attacker)) {
    return;
  }

  player = attacker;

  if(player function_831bf182() == 0) {
    return;
  }

  var_312418a2 = getweapon(#"gadget_health_regen");
  var_d1c7ac6d = var_312418a2.var_4db0917a;

  if(!isDefined(var_d1c7ac6d) || var_d1c7ac6d == 0) {
    return;
  }

  assert(isDefined(player) && isDefined(player.gadget_health_regen_slot));
  assert(isDefined(player.gadget_health_regen_weapon) && isDefined(player) && isDefined(player.gadget_health_regen_weapon.gadget_powermax));
  gadgetslot = player.gadget_health_regen_slot;
  var_5d74fac3 = player.gadget_health_regen_weapon.gadget_powermax;
  var_db3ef30b = player gadgetpowerget(gadgetslot);
  var_d4a51b2 = var_db3ef30b + var_d1c7ac6d;

  if(var_d4a51b2 < 0) {
    var_d4a51b2 = 0;
  } else if(var_d4a51b2 > var_5d74fac3) {
    var_d4a51b2 = var_5d74fac3;
  }

  player gadgetpowerset(gadgetslot, var_d4a51b2);
}