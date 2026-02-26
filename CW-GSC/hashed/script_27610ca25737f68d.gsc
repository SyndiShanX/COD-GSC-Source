/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_27610ca25737f68d.gsc
***********************************************/

#using script_2c5daa95f8fec03c;
#using script_4dc6a9b234b838e1;
#using script_72401f526ba71638;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_weapons;
#namespace namespace_797fe2e7;

function private autoexec __init__system__() {
  system::register(#"hash_607f0336b64df630", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  clientfield::register("missile", "" + # "hash_36112e7cad541b66", 1, 2, "int");
  clientfield::register("missile", "" + # "hash_2d55ead1309349bc", 1, 3, "int");
  level.var_887c77a4 = "destroyed_armor_zm";
  callback::on_ai_killed(&function_9b6145a);
  namespace_1b527536::function_36e0540e(#"energy_mine", 1, 30, "field_upgrade_energy_mine_item_sr");
  namespace_1b527536::function_36e0540e(#"energy_mine_1", 2, 30, "field_upgrade_energy_mine_1_item_sr");
  namespace_1b527536::function_36e0540e(#"energy_mine_2", 2, 30, "field_upgrade_energy_mine_2_item_sr");
  namespace_1b527536::function_36e0540e(#"energy_mine_3", 2, 30, "field_upgrade_energy_mine_3_item_sr");
  namespace_1b527536::function_36e0540e(#"energy_mine_4", 2, 30, "field_upgrade_energy_mine_4_item_sr");
  namespace_1b527536::function_36e0540e(#"energy_mine_5", 2, 30, "field_upgrade_energy_mine_5_item_sr");
  namespace_1b527536::function_dbd391bf(#"energy_mine", &function_a6da15be);
  namespace_1b527536::function_dbd391bf(#"energy_mine_1", &function_a6da15be);
  namespace_1b527536::function_dbd391bf(#"energy_mine_2", &function_a6da15be);
  namespace_1b527536::function_dbd391bf(#"energy_mine_3", &function_a6da15be);
  namespace_1b527536::function_dbd391bf(#"energy_mine_4", &function_a6da15be);
  namespace_1b527536::function_dbd391bf(#"energy_mine_5", &function_a6da15be);
  zm_weapons::function_404c3ad5(getweapon(#"energy_mine"), &function_1ac47afc);
  zm_weapons::function_404c3ad5(getweapon(#"energy_mine_1"), &function_1ac47afc);
  zm_weapons::function_404c3ad5(getweapon(#"energy_mine_2"), &function_1ac47afc);
  zm_weapons::function_404c3ad5(getweapon(#"energy_mine_3"), &function_1ac47afc);
  zm_weapons::function_404c3ad5(getweapon(#"energy_mine_4"), &function_a68304b6);
  zm_weapons::function_404c3ad5(getweapon(#"energy_mine_5"), &function_a68304b6);
  zm_weapons::function_404c3ad5(getweapon(#"hash_7e4053e6965bafa7"), &function_a68304b6);
}

function function_a6da15be(params) {
  self namespace_1b527536::function_460882e2(1);
  weapon = params.weapon;
  e_mine = params.projectile;
  var_f61738a0 = 0;
  b_stun = 0;
  var_f224b687 = 1;
  var_29030410 = 1;
  var_79e920ac = 1;

  switch (weapon.name) {
    case # "energy_mine":
    case # "energy_mine_1":
      break;
    case # "energy_mine_2":
      var_29030410 = 2;
      var_79e920ac = 2;
      break;
    case # "energy_mine_3":
      var_f61738a0 = 1;
      var_f224b687 = 2;
      var_29030410 = 2;
      var_79e920ac = 3;
      break;
    case # "energy_mine_4":
      var_f61738a0 = 1;
      var_f224b687 = 2;
      var_29030410 = 2;
      var_79e920ac = 3;
      break;
    case # "energy_mine_5":
      var_f61738a0 = 1;
      b_stun = 1;
      var_f224b687 = 3;
      var_29030410 = 3;
      var_79e920ac = 4;
      break;
  }

  v_origin = e_mine.origin;
  e_mine function_1e6559d5(var_29030410);

  if(isDefined(e_mine)) {
    e_mine function_a24e7103(self, 100);
  }

  if(isDefined(e_mine)) {
    e_mine notify(#"starting_detonation");
    e_mine clientfield::set("" + # "hash_36112e7cad541b66", 0);
    e_mine clientfield::set("" + # "hash_2d55ead1309349bc", var_79e920ac);
    v_origin = e_mine.origin;
  }

  wait 0.6;

  if(isDefined(e_mine)) {
    if(isPlayer(self)) {
      e_mine detonate(self);
    } else {
      e_mine detonate();
    }
  }

  for(i = 0; i < var_f224b687; i++) {
    if(i >= 1) {
      if(isPlayer(self)) {
        e_mine = self magicgrenadeplayer(getweapon(#"hash_7e4053e6965bafa7"), v_origin, (0, 0, 0));
        e_mine detonate(self);
      } else {
        return;
      }
    }

    a_ai_targets = function_3655d156(self, weapon.explosionradius, v_origin);
    self thread function_71efd0e6(a_ai_targets, v_origin, var_f61738a0, b_stun);
    wait 1;
  }
}

function private function_71efd0e6(a_ai_targets, v_origin, var_f61738a0 = 0, b_stun = 0) {
  foreach(ai in a_ai_targets) {
    if(!isalive(ai)) {
      continue;
    }

    if(var_f61738a0 && ai.zm_ai_category === # "normal") {
      ai zombie_utility::setup_zombie_knockdown(v_origin);
    }

    if(b_stun && ai.zm_ai_category === # "special") {
      ai ai::clear_stun();
      ai ai::stun();
    }

    waitframe(1);
  }
}

function private function_1e6559d5(var_29030410) {
  self endon(#"death", #"starting_detonation");

  if(getdvarint(#"hash_3ce5890428b398f1", 0)) {}

  self util::waittillnotmoving();
  wait 0.5;
  self clientfield::set("" + # "hash_36112e7cad541b66", var_29030410);
}

function private function_a24e7103(e_player, n_radius) {
  self endon(#"death");

  while(true) {
    a_ai_targets = self function_3655d156(e_player, n_radius, self.origin);

    if(a_ai_targets.size) {
      return;
    }

    waitframe(1);
  }
}

function private function_3655d156(e_player, n_radius, v_origin) {
  if(isDefined(e_player)) {
    a_ai_targets = e_player getenemiesinradius(v_origin, n_radius);
  } else {
    a_ai_targets = getaiteamarray(level.zombie_team);
  }

  a_ai_targets = arraysortclosest(a_ai_targets, v_origin, undefined, 0, n_radius);
  return a_ai_targets;
}

function function_39aea6b8(name) {
  if(!isDefined(name)) {
    return false;
  }

  switch (name) {
    case # "energy_mine":
    case # "energy_mine_4":
    case # "energy_mine_5":
    case # "energy_mine_2":
    case # "energy_mine_3":
    case # "energy_mine_1":
      return true;
  }

  return false;
}

function function_1ac47afc(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
  if(isentity(surfacetype) && isPlayer(vsurfacenormal) && self.zm_ai_category === # "normal") {
    self.var_6d683e5a = surfacetype.origin;
  }
}

function function_a68304b6(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
  if(surfacetype === getweapon(#"hash_7e4053e6965bafa7") && !is_true(boneindex.var_d9f807a7)) {
    return;
  }

  if(isentity(psoffsettime) && isPlayer(boneindex) && self.zm_ai_category === # "normal") {
    self.var_6d683e5a = psoffsettime.origin;
    namespace_81245006::function_76e239dc(self, boneindex);
  }

  if(isPlayer(boneindex)) {
    if(!isDefined(self.var_786be2f0)) {
      self.var_786be2f0 = [];
    }

    if(self.archetype === # "raz" && isarray(self.var_5ace757d) && isDefined(level.var_92e56a0f[#"raz"])) {
      foreach(weakpoint in self.var_5ace757d) {
        if(weakpoint.type === # "armor" && weakpoint.currstate === 1 && weakpoint.health > 0 && !isinarray(self.var_786be2f0, weakpoint.var_f371ebb0)) {
          if(!isDefined(self.var_786be2f0)) {
            self.var_786be2f0 = [];
          } else if(!isarray(self.var_786be2f0)) {
            self.var_786be2f0 = array(self.var_786be2f0);
          }

          self.var_786be2f0[self.var_786be2f0.size] = weakpoint.var_f371ebb0;
          [[level.var_92e56a0f[#"raz"]]](self, weakpoint, boneindex, weakpoint.health, 1, surfacetype, vsurfacenormal, modelindex, psoffsettime);
        }
      }

      return;
    }

    if(self.archetype === # "mechz" && isarray(self.var_5ace757d) && isDefined(level.var_92e56a0f[#"mechz"])) {
      foreach(weakpoint in self.var_5ace757d) {
        if(weakpoint.type === # "armor" && weakpoint.currstate === 1 && weakpoint.health > 0 && !isinarray(self.var_786be2f0, weakpoint.var_f371ebb0)) {
          if(!isDefined(self.var_786be2f0)) {
            self.var_786be2f0 = [];
          } else if(!isarray(self.var_786be2f0)) {
            self.var_786be2f0 = array(self.var_786be2f0);
          }

          self.var_786be2f0[self.var_786be2f0.size] = weakpoint.var_f371ebb0;
          [[level.var_92e56a0f[#"mechz"]]](self, weakpoint, boneindex, weakpoint.health, surfacetype, modelindex, psoffsettime);
        }
      }
    }
  }
}

function private function_9b6145a(params) {
  if(function_39aea6b8(params.weapon.name) && isPlayer(params.eattacker) && self.zm_ai_category === # "normal" && isvec(self.var_6d683e5a)) {
    self namespace_cc411409::ragdoll_launch(self.var_6d683e5a, 2);
    self thread function_3fb4ce3b();
  }
}

function function_3fb4ce3b() {
  util::wait_network_frame();

  if(isDefined(self)) {
    if(self.health < -300) {
      if(math::cointoss()) {
        gibserverutils::annihilate(self);
      } else {
        self zombie_utility::gib_random_parts();
      }

      return;
    }

    self zombie_utility::gib_random_parts();
  }
}