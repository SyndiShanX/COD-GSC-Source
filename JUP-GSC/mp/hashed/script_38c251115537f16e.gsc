/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_38c251115537f16e.gsc
*************************************************/

#using script_1243911b5893214a;
#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace zombie_melee;

function function_8e401d26d58bc32d() {
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("on_move_speed_changed", &function_2423853525ee87d7);
}

function function_265e0e58c950559() {
  thread function_e87d981fe3e432d6();
  self.var_b32061fbf4f14999 = &function_b32061fbf4f14999;
}

function function_e700d8944532443d(damage_amount, range, var_6a3d37541ccb42e7, var_2c1d789f7a25cad1, always_knockback, knockback_strength, var_7921c0704abad1a3) {
  assert(isDefined(range));
  self.melee_damage = default_to(damage_amount, 30);
  self.var_8b184e6eade0bc4f = self.melee_damage;
  self.melee_range = range;
  self.var_4c9b344b1a95200 = default_to(var_6a3d37541ccb42e7, 1);
  self.var_2c1d789f7a25cad1 = var_2c1d789f7a25cad1;
  self.always_knockback = always_knockback;
  self.knockback_strength = knockback_strength;
  self.var_7921c0704abad1a3 = var_7921c0704abad1a3;
  self._blackboard.zombiemeleerange = int(self.melee_range);
  self._blackboard.var_94f78603f930cce6 = 90;
  self._blackboard.var_5b09efabac175a4c = 64;
  function_2576f3b996c15ad("melee_range", self.melee_range);
}

function function_1fc0eb1eb90c8dd0(movetype, range_override) {
  self.var_5b7cb9371ba53dc8 = default_to(self.var_5b7cb9371ba53dc8, []);
  self.var_5b7cb9371ba53dc8[movetype] = range_override;
}

function function_2423853525ee87d7(params) {
  if(isDefined(self._blackboard.movetype) && isDefined(self.var_5b7cb9371ba53dc8) && isDefined(self.var_5b7cb9371ba53dc8[self._blackboard.movetype])) {
    self._blackboard.var_94f78603f930cce6 = self.var_5b7cb9371ba53dc8[self._blackboard.movetype];
  }
}

function request_melee(var_eb9973984c6db0df, var_f261c2f31d7de033) {
  self.var_a7e7a5cbca185094 = var_eb9973984c6db0df;

  if(!isDefined(var_f261c2f31d7de033)) {
    var_f261c2f31d7de033 = function_3529beadf9e07df8();
  }

  if(!isDefined(self.var_f261c2f31d7de033) || self.var_f261c2f31d7de033 != var_f261c2f31d7de033) {
    self.var_f261c2f31d7de033 = var_f261c2f31d7de033;
    callback::callback("on_is_moving_melee_changed");
  }

  callback::callback("on_is_melee_started");
  function_e725cd043cf58ebb();
}

function private function_b32061fbf4f14999(msg) {
  assert(isDefined(self.melee_range) && isDefined(self.melee_damage));
  var_eb9973984c6db0df = self.var_a7e7a5cbca185094;
  melee_damage = self.melee_damage;

  if(isai(var_eb9973984c6db0df)) {
    melee_damage = int(melee_damage * self.var_4c9b344b1a95200);
  }

  params = spawnStruct();
  params.meleetarget = var_eb9973984c6db0df;
  params.meleedamage = melee_damage;
  callback::callback("zombie_melee_pre", params);
  hit_ent = self melee(undefined, melee_damage, self.melee_range, 16, 16);
  self._blackboard.var_648f4849d921b37c = !isDefined(hit_ent);
  params = spawnStruct();
  params.damage = melee_damage;
  params.origin = self.origin + anglesToForward(self.angles) * self.melee_range * 0.5 + (0, 0, 1) * self.height * 0.5;
  params.radius = self.melee_range * 0.5;
  params.meansofdeath = "MOD_MELEE";

  if(isDefined(hit_ent) && self.var_2c1d789f7a25cad1 && (isai(hit_ent) || isPlayer(hit_ent))) {
    if(self.always_knockback || isDefined(msg) && msg == "knockback") {
      hit_ent knockback_flat(hit_ent.origin - self.origin, self.knockback_strength);
    }
  }

  recordsphere(params.origin, 5, (1, 0, 0));

  callback::callback("damage_point", params);
  params = spawnStruct();
  params.meleehitent = hit_ent;
  callback::callback("zombie_melee", params);
}

function private function_e87d981fe3e432d6() {
  self endon("death");

  while(true) {
    self waittill("bmeleestarted");

    if(self.var_7921c0704abad1a3) {
      set("melee_pain", "pain", 0);
    }

    if(isDefined(self._blackboard.meleerequestedtarget)) {
      var_eb9973984c6db0df = self._blackboard.meleerequestedtarget;
    } else if(isDefined(self._blackboard.var_40609a14c75fbe3)) {
      var_eb9973984c6db0df = self._blackboard.var_40609a14c75fbe3;
    } else {
      var_eb9973984c6db0df = self.enemy;
    }

    request_melee(var_eb9973984c6db0df, self._blackboard.var_39f71a91ec96eac7);
    thread function_b10cf3d9f8a0a94();
    self waittill("bmeleeended");

    if(self.var_7921c0704abad1a3) {
      set("melee_pain", "pain", 1);
    }

    self.var_a7a6441b0e218a8a = 0;
    self.in_melee = 0;
  }
}

function private function_b10cf3d9f8a0a94() {
  self endon("death");
  self endon("bmeleeended");

  while(true) {
    self waittill("hit_melee", msg);

    if(isDefined(self.var_b32061fbf4f14999)) {
      [[self.var_b32061fbf4f14999]](msg);
    }
  }
}

function private function_3529beadf9e07df8() {
  return lengthsquared(self.velocity) > squared(getdvarint(@ "hash_b17a9432a377356d", 65));
}