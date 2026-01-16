/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_health_regen.gsc
*****************************************************/

#include scripts\abilities\ability_player;
#include scripts\abilities\ability_util;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;

#namespace gadget_health_regen;

autoexec __init__system__() {
  system::register(#"gadget_health_regen", &__init__, undefined, undefined);
}

__init__() {
  ability_player::register_gadget_activation_callbacks(23, &gadget_health_regen_on, &gadget_health_regen_off);
  ability_player::register_gadget_possession_callbacks(23, &gadget_health_regen_on_give, &gadget_health_regen_on_take);
  clientfield::register("toplayer", "healthregen", 1, 1, "int");
  clientfield::register("clientuimodel", "hudItems.healingActive", 1, 1, "int");
  clientfield::register("clientuimodel", "hudItems.numHealthPickups", 1, 2, "int");
  callback::on_spawned(&on_player_spawned);
  callback::on_player_damage(&on_player_damage);
  callback::add_callback(#"on_status_effect", &on_status_effect);
  callback::add_callback(#"on_buff", &on_buff);
}

on_status_effect(var_756fda07) {
  if(isDefined(var_756fda07.var_29f71617) && var_756fda07.var_29f71617) {
    self function_aba28004();
  }
}

on_buff() {
  self function_aba28004();
}

gadget_health_regen_on_give(slot, weapon) {
  self.gadget_health_regen_slot = slot;
  self.gadget_health_regen_weapon = weapon;
  weapon.ignore_grenade = 1;

  if(isDefined(weapon) && weapon.maxheal) {
    self player::function_9080887a(weapon.maxheal);
    return;
  }

  self player::function_9080887a();
}

gadget_health_regen_on_take(slot, weapon) {
  self.gadget_health_regen_slot = undefined;
  self player::function_9080887a();
}

on_player_spawned() {
  self function_d91a057d();
}

function_ddfdddb1() {
  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    self clientfield::set_to_player("healthregen", 1);
  }

  if(isDefined(level.p8_wep_gun_storage_rack_03_lod5_s1_geo_rigid_bs_pehghddpjrzbf52gqu27h64a4b)) {
    [[level.p8_wep_gun_storage_rack_03_lod5_s1_geo_rigid_bs_pehghddpjrzbf52gqu27h64a4b]](self);
  }
}

heal_start() {
  self clientfield::set_player_uimodel("hudItems.healingActive", 1);
}

heal_end() {
  if(!isDefined(self) || !isDefined(self.heal)) {
    return;
  }

  self.heal.var_a1cac2f1 = 0;
  self.heal.enabled = 0;
  self.heal.var_bc840360 = 0;
  self notify(#"healing_disabled");
  self player::function_9080887a();
  self clientfield::set_player_uimodel("hudItems.healingActive", 0);

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    self clientfield::set_to_player("healthregen", 0);
  }
}

function_34daf34a(slot, weapon) {
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

function_bc0ce7d5(slot, weapon) {
  var_1594ab5 = self function_941ed5d6();

  for(i = 0; i < 4; i++) {
    if(isalive(var_1594ab5[i])) {
      profilestart();

      if(isDefined(var_1594ab5[i].laststand) && var_1594ab5[i].laststand) {
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

function_941ed5d6() {
  if(isDefined(self.team)) {
    var_1594ab5 = getplayers(self.team, self.origin, 1500);
  } else {
    var_1594ab5 = array(self);
  }

  return var_1594ab5;
}

gadget_health_regen_on(slot, weapon) {
  if(sessionmodeiswarzonegame()) {
    self.var_eedfcc6e = gettime();
    return;
  }

  function_34daf34a(slot, weapon);
}

gadget_health_regen_off(slot, weapon) {
  if(!sessionmodeiswarzonegame()) {
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

enable_healing_after_wait(slot, weapon, wait_time, var_5818bd22, player) {
  self notify(#"healing_preamble");
  self.heal.var_a1cac2f1 = gettime() + var_5818bd22;
  waitresult = self waittilltimeout(wait_time, #"death", #"disconnect", #"healing_disabled", #"healing_preamble");

  if(waitresult._notify != "timeout") {
    return;
  }

  self enable_healing(slot, weapon, player);
}

enable_healing(slot, weapon, player) {
  if(self gadgetsdisabled()) {
    return;
  }

  self heal_start();

  if(isDefined(weapon) && weapon.maxheal) {
    self player::function_9080887a(weapon.maxheal);
  } else {
    self player::function_9080887a();
  }

  var_bc840360 = self.health;

  if(isDefined(self.var_9cd2c51d)) {
    if(!self.heal.enabled) {
      self.var_9cd2c51d.var_c54af9a9 = gettime();
      self.var_9cd2c51d.var_6e219f3c = self.health;
    }
  }

  if(self.heal.enabled) {
    var_bc840360 = isDefined(self.heal.var_bc840360) ? self.heal.var_bc840360 : self.health;
  }

  if(weapon.heal) {
    max_health = self.maxhealth;

    if(weapon.maxheal) {
      max_health = weapon.maxheal;
    }

    self.heal.var_bc840360 = math::clamp(weapon.heal + var_bc840360, 0, max_health);

    if(self.heal.var_bc840360 == 0) {
      return;
    }
  } else {
    self.heal.var_bc840360 = 0;
  }

  if(weapon.var_4465ef1e > 0) {
    heal_ammount = weapon.heal;

    if(heal_ammount <= 0 && isDefined(self.var_66cb03ad)) {
      heal_ammount = self.var_66cb03ad;
    }

    self.heal.rate = heal_ammount / float(weapon.var_4465ef1e) / 1000;
  } else {
    self.heal.rate = 0;
  }

  self function_820a63e9(slot, 1);

  if(isDefined(level.var_d3b4a4db) && self === player) {
    self[[level.var_d3b4a4db]]();
  }

  if(isDefined(self.var_121392a1)) {
    foreach(se in self.var_121392a1) {
      params = se.var_4f6b79a4;

      if(params.var_abac379d === 1) {
        status_effect::function_408158ef(params.setype, params.var_18d16a6b);
      }
    }
  }

  self.heal.enabled = 1;
  self callback::function_d8abfc3d(#"done_healing", &function_4e449209);

  if(isDefined(self.health) && isDefined(self.var_66cb03ad) && self.health >= self.var_66cb03ad) {
    self function_4e449209();
  }
}

function_d91a057d(slot = ability_util::gadget_slot_for_type(23)) {
  if(isDefined(slot)) {
    self function_820a63e9(slot, 0);
  }

  if(is_healing()) {
    self heal_end();
  }
}

is_healing() {
  return isDefined(self) && isDefined(self.heal) && isDefined(self.heal.enabled) && self.heal.enabled;
}

function_4e449209() {
  self endon(#"disconnect");

  if(isDefined(self)) {
    self.heal.var_a1cac2f1 = 0;

    if(isDefined(level.var_d9ae19f0)) {
      level[[level.var_d9ae19f0]](self);
    }

    self callback::function_52ac9652(#"done_healing", &function_4e449209);

    if(self is_healing()) {
      if(isDefined(level.var_da2d586a) && !isDefined(self.var_c443b227)) {
        self[[level.var_da2d586a]]();
      }
    }

    self function_d91a057d();
  }
}

on_player_damage(params) {
  if(!isDefined(self.gadget_health_regen_slot)) {
    return;
  }

  if(!self is_healing()) {
    return;
  }

  attacker = params.eattacker;

  if(self function_dafd9cd(attacker) == 0) {
    damage = params.idamage;
    self.heal.var_bc840360 = math::clamp(self.heal.var_bc840360 - damage, 0, self.heal.var_bc840360);
    return;
  }

  function_18e0320b();
}

function_aba28004() {
  if(!isplayer(self)) {
    return;
  }

  self function_18e0320b();
}

private function_18e0320b() {
  if(self is_healing()) {
    self function_d91a057d();
  }
}

private function_dafd9cd(attacker) {
  if(gettime() < self.heal.var_a1cac2f1) {
    return false;
  }

  if(isDefined(level.deathcircle) && level.deathcircle === attacker) {
    return false;
  }

  return true;
}

function_831bf182() {
  can_set = isDefined(self.gadget_health_regen_slot);

  if(!can_set || "ammo" == self.gadget_health_regen_weapon.gadget_powerusetype) {
    return 0;
  }

  return can_set;
}

power_off() {
  if(self function_831bf182()) {
    self gadgetpowerset(self.gadget_health_regen_slot, 0);
  }
}

power_on() {
  if(self function_831bf182()) {
    self gadgetpowerset(self.gadget_health_regen_slot, self.gadget_health_regen_weapon.gadget_powermax);
  }
}