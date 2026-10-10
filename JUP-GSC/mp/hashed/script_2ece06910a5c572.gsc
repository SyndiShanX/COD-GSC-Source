/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2ece06910a5c572.gsc
************************************************/

#using script_5490321f01c7322e;
#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace zombie_bite;

function function_abeab68e34b24949() {
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("on_move_speed_changed", &function_96046c875df0d6a3);
}

function function_36acc07bbc238f35() {
  thread function_9d1c07a68cda90d2();
  self.var_c8de7f73babe502d = &function_c8de7f73babe502d;
}

function function_dca79eb8ca59cd89(damage_amount, range) {
  self.melee_damage = default_to(damage_amount, 30);
  self.melee_range = range;
  self._blackboard.zombiemeleerange = int(self.melee_range);
  self._blackboard.var_94f78603f930cce6 = 64;
  self._blackboard.var_5b09efabac175a4c = 64;
  self._blackboard.var_6b93b99c8b1c38c2 = 65;
  function_2576f3b996c15ad("melee_range", self.melee_range);
}

function function_e8d0e8d7ba0f392e(movetype, range_override) {
  self.var_100ea074a5e044b4 = default_to(self.var_100ea074a5e044b4, []);
  self.var_100ea074a5e044b4[movetype] = range_override;
}

function function_96046c875df0d6a3(params) {
  if(isDefined(self._blackboard.movetype) && isDefined(self.var_100ea074a5e044b4) && isDefined(self.var_100ea074a5e044b4[self._blackboard.movetype])) {
    self._blackboard.var_94f78603f930cce6 = self.var_100ea074a5e044b4[self._blackboard.movetype];
  }
}

function request_bite(target_ent) {
  self.bite_target = target_ent;
  callback::callback("on_is_bite_started");
  function_3ce3c307b88d4237();
}

function private function_c8de7f73babe502d() {
  assert(isDefined(self.melee_range) && isDefined(self.melee_damage));
  target = self.bite_target;
  hit_ent = self melee(undefined, self.melee_damage, self.melee_range, 16, 16);
  params = spawnStruct();
  params.damage = self.melee_damage;
  params.origin = self.origin + anglesToForward(self.angles) * self.melee_range + (0, 0, 1) * self.height * 0.5;
  params.meansofdeath = "MOD_MELEE";

  recordsphere(params.origin, 5, (1, 0, 0));

  callback::callback("damage_point", params);
}

function private function_9d1c07a68cda90d2() {
  self endon("death");

  while(true) {
    self waittill("bmeleestarted");
    request_bite(self.enemy);
    thread function_24db30577155f620();
    self waittill("bmeleeended");
    self.var_4507177651176666 = 0;
    self.in_melee = 0;
  }
}

function private function_24db30577155f620() {
  self endon("death");
  self endon("bmeleeended");
  self waittill("hit_melee");

  if(isDefined(self.var_c8de7f73babe502d)) {
    [[self.var_c8de7f73babe502d]]();
  }
}