/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_421ca110b4204518.gsc
***********************************************/

#using script_24c32478acf44108;
#using script_72401f526ba71638;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\perks;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace namespace_2ab93693;

function private autoexec __init__system__() {
  system::register(#"hash_662c938bd03bd1ad", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  clientfield::register("scriptmover", "" + # "hash_142ed640bf2e09b9", 1, 1, "int");
  clientfield::register("actor", "" + # "hash_717ed5a81b281ebd", 1, 1, "counter");
  clientfield::register("toplayer", "" + # "hash_717ed5a81b281ebd", 1, 1, "int");
  clientfield::register("actor", "" + # "hash_177f6b02e0b5436b", 1, 1, "int");
  clientfield::register("actor", "" + # "hash_40a7e84c380b9b1a", 1, 1, "int");
  callback::on_connect(&on_connect);
  namespace_1b527536::function_36e0540e(#"ring_of_fire", 1, 35, "field_upgrade_ring_of_fire_item_sr");
  namespace_1b527536::function_36e0540e(#"ring_of_fire_1", 1, 35, "field_upgrade_ring_of_fire_1_item_sr");
  namespace_1b527536::function_36e0540e(#"ring_of_fire_2", 1, 35, "field_upgrade_ring_of_fire_2_item_sr");
  namespace_1b527536::function_36e0540e(#"ring_of_fire_3", 1, 35, "field_upgrade_ring_of_fire_3_item_sr");
  namespace_1b527536::function_36e0540e(#"ring_of_fire_4", 1, 35, "field_upgrade_ring_of_fire_4_item_sr");
  namespace_1b527536::function_36e0540e(#"ring_of_fire_5", 1, 35, "field_upgrade_ring_of_fire_5_item_sr");
  namespace_1b527536::function_dbd391bf(#"ring_of_fire", &function_309daad7);
  namespace_1b527536::function_dbd391bf(#"ring_of_fire_1", &function_309daad7);
  namespace_1b527536::function_dbd391bf(#"ring_of_fire_2", &function_309daad7);
  namespace_1b527536::function_dbd391bf(#"ring_of_fire_3", &function_309daad7);
  namespace_1b527536::function_dbd391bf(#"ring_of_fire_4", &function_309daad7);
  namespace_1b527536::function_dbd391bf(#"ring_of_fire_5", &function_309daad7);
  namespace_9ff9f642::register_burn(#"ring_of_fire", 25, 5, "" + # "hash_177f6b02e0b5436b", "" + # "hash_40a7e84c380b9b1a");
  namespace_9ff9f642::register_burn(#"ring_of_fire_1", 25, 10, "" + # "hash_177f6b02e0b5436b", "" + # "hash_40a7e84c380b9b1a");
  namespace_9ff9f642::register_burn(#"ring_of_fire_2", 25, 10, "" + # "hash_177f6b02e0b5436b", "" + # "hash_40a7e84c380b9b1a");
  namespace_9ff9f642::register_burn(#"ring_of_fire_3", 25, 10, "" + # "hash_177f6b02e0b5436b", "" + # "hash_40a7e84c380b9b1a");
  namespace_9ff9f642::register_burn(#"ring_of_fire_4", 25, 10, "" + # "hash_177f6b02e0b5436b", "" + # "hash_40a7e84c380b9b1a");
  namespace_9ff9f642::register_burn(#"ring_of_fire_5", 25, 10, "" + # "hash_177f6b02e0b5436b", "" + # "hash_40a7e84c380b9b1a");
  zm_equipment::function_76beede2(#"ring_of_fire", "MOD_BURNED");
  zm_equipment::function_76beede2(#"ring_of_fire_1", "MOD_BURNED");
  zm_equipment::function_76beede2(#"ring_of_fire_2", "MOD_BURNED");
  zm_equipment::function_76beede2(#"ring_of_fire_3", "MOD_BURNED");
  zm_equipment::function_76beede2(#"ring_of_fire_4", "MOD_BURNED");
  zm_equipment::function_76beede2(#"ring_of_fire_5", "MOD_BURNED");
}

function on_connect() {
  self.var_d93ab65 = [];
}

function function_309daad7(params) {
  self namespace_1b527536::function_460882e2(1);
  weapon = params.weapon;

  if(isDefined(params.projectile) && !isDefined(params.projectile.owner)) {
    params.projectile.owner = self;
  }

  self thread function_1cbc22b0(weapon, 175);
}

function private function_baaff75b(var_cb73750, entity) {
  n_radius_sq = var_cb73750.n_radius * var_cb73750.n_radius;

  if(distance2dsquared(var_cb73750.origin, entity.origin) <= n_radius_sq && abs(entity.origin[2] - var_cb73750.origin[2]) <= var_cb73750.n_height) {
    return true;
  }

  return false;
}

function private function_ca26e871(entity) {
  if(isarray(level.var_686c81d7) && isalive(entity)) {
    foreach(var_cb73750 in level.var_686c81d7) {
      if(isDefined(var_cb73750) && function_baaff75b(var_cb73750, entity)) {
        return true;
      }
    }
  }

  return false;
}

function private function_1cbc22b0(weapon, n_radius) {
  var_d71041e1 = groundtrace(self.origin + (0, 0, 16) + (0, 0, 8), self.origin + (0, 0, 16) + (0, 0, -100000), 0, self)[# "position"];
  var_3889eb68 = util::spawn_model("tag_origin", var_d71041e1);
  var_3889eb68.owner = self;
  var_3889eb68.n_radius = n_radius;
  var_3889eb68.n_height = 72;
  var_3889eb68.weapon = weapon;
  var_3889eb68.var_5e3cceb9 = 1;
  var_3889eb68.var_bb41cf71 = 0;
  var_3889eb68.var_8ad82414 = 0;
  var_3889eb68.var_c91dca7e = 4;
  var_3889eb68.var_5b61dff6 = 0.02;
  var_3889eb68.var_fc827c27 = 10;
  var_3889eb68.n_duration = 15;

  if(!isDefined(level.var_686c81d7)) {
    level.var_686c81d7 = [];
  }

  if(!isDefined(level.var_686c81d7)) {
    level.var_686c81d7 = [];
  } else if(!isarray(level.var_686c81d7)) {
    level.var_686c81d7 = array(level.var_686c81d7);
  }

  if(!isinarray(level.var_686c81d7, var_3889eb68)) {
    level.var_686c81d7[level.var_686c81d7.size] = var_3889eb68;
  }

  self flag::increment("zm_field_upgrade_in_use");

  switch (weapon.name) {
    case # "ring_of_fire":
      var_3889eb68 thread function_64a3f9c6();
      break;
    case # "ring_of_fire_1":
      var_3889eb68.var_5b61dff6 = 0.04;
      var_3889eb68 thread function_64a3f9c6();
      break;
    case # "ring_of_fire_2":
      var_3889eb68.var_5b61dff6 = 0.04;
      var_3889eb68 thread function_64a3f9c6(1);
      break;
    case # "ring_of_fire_3":
      var_3889eb68.var_5b61dff6 = 0.04;
      var_3889eb68 thread function_64a3f9c6(1, 1);
      break;
    case # "ring_of_fire_4":
      var_3889eb68.var_5b61dff6 = 0.04;
      var_3889eb68 thread function_64a3f9c6(1, 1);
      var_3889eb68.var_bb41cf71 = 1;
      break;
    case # "ring_of_fire_5":
      var_3889eb68.var_5b61dff6 = 0.04;
      var_3889eb68 thread function_64a3f9c6(1, 1, 1);
      var_3889eb68.var_bb41cf71 = 1;
      break;
  }

  var_3889eb68 clientfield::set("" + # "hash_142ed640bf2e09b9", 1);

  level thread function_da2298bc();

  n_timer = 0;

  while(n_timer <= var_3889eb68.n_duration) {
    if(var_3889eb68.var_5e3cceb9) {
      if(isDefined(self)) {
        a_ai = self getenemiesinradius(var_3889eb68.origin, n_radius);
        a_ai = arraysortclosest(a_ai, var_3889eb68.origin);
      } else {
        a_ai = getaiteamarray(level.zombie_team);
        a_ai = arraysortclosest(a_ai, var_3889eb68.origin, undefined, 0, n_radius);
      }

      foreach(ai in a_ai) {
        if(isalive(ai) && ai.zm_ai_category === # "normal") {
          var_16e6b8ea = ai.maxhealth * var_3889eb68.var_5b61dff6;
          ai namespace_9ff9f642::burn(weapon.name, self, weapon, var_16e6b8ea);

          if(var_3889eb68.var_bb41cf71 && ai.zm_ai_category === # "normal" && math::cointoss(var_3889eb68.var_fc827c27)) {
            ai.allowdeath = 1;
            ai dodamage(ai.health, var_3889eb68.origin, self, var_3889eb68, "none", "MOD_BURNED", 0, weapon);
          }
        }
      }
    }

    wait 1;
    n_timer += 1;
  }

  if(isPlayer(self)) {
    self flag::decrement("zm_field_upgrade_in_use");
  }

  arrayremovevalue(level.var_686c81d7, var_3889eb68);
  var_3889eb68 clientfield::set("" + # "hash_142ed640bf2e09b9", 0);
  var_3889eb68 thread util::delayed_delete(0.5);
}

function private function_64a3f9c6(var_dfbbc9a0 = 0, var_feefd408 = 0, var_cf53ab1f = 0) {
  while(isDefined(self)) {
    foreach(player in getplayers()) {
      if(isalive(player) && !isinarray(player.var_d93ab65, self) && function_baaff75b(self, player)) {
        if(!player.var_d93ab65.size) {
          player clientfield::set_to_player("" + # "hash_717ed5a81b281ebd", 1);
        }

        if(!isDefined(player.var_d93ab65)) {
          player.var_d93ab65 = [];
        } else if(!isarray(player.var_d93ab65)) {
          player.var_d93ab65 = array(player.var_d93ab65);
        }

        player.var_d93ab65[player.var_d93ab65.size] = self;

        if(self.owner === player) {
          player.var_a25e160d = 0;
        }

        continue;
      }

      if(isinarray(player.var_d93ab65, self) && !function_baaff75b(self, player)) {
        arrayremovevalue(player.var_d93ab65, self);

        if(self.owner === player) {
          player.var_a25e160d = undefined;
        }

        if(!player.var_d93ab65.size) {
          player clientfield::set_to_player("" + # "hash_717ed5a81b281ebd", 0);
        }
      }
    }

    a_actors = getactorarray();

    foreach(ai in a_actors) {
      if(!isalive(ai)) {
        continue;
      }

      if(!is_true(ai.var_25e2200c) && function_ca26e871(ai)) {
        ai clientfield::increment("" + # "hash_717ed5a81b281ebd", 1);
        ai.var_25e2200c = 1;
        continue;
      }

      if(is_true(ai.var_25e2200c) && !function_ca26e871(ai)) {
        ai.var_25e2200c = undefined;
      }
    }

    if(var_dfbbc9a0) {
      var_315c9351 = getentarraybytype(4);

      if(isarray(level.var_9ded2ca6)) {
        arrayremovevalue(level.var_9ded2ca6, undefined);
        var_315c9351 = arraycombine(var_315c9351, level.var_9ded2ca6);
      }

      foreach(missile in var_315c9351) {
        if(!isDefined(missile) || isPlayer(missile.originalowner) || isPlayer(missile.owner) || missile.team === self.owner.team) {
          continue;
        }

        if(function_baaff75b(self, missile)) {
          v_dir = missile.origin - self.origin;
          v_dir = vectornormalize(v_dir);

          if(v_dir[0] == 0) {
            var_c51499f8 = 1;
          } else {
            var_c51499f8 = v_dir[0];
          }

          level scoreevents::doscoreeventcallback("scoreEventZM", {
            #attacker: self.owner, #scoreevent: # "hash_56aa82cbbc11009b"});
          self.owner stats::function_622feb0d(#"ring_of_fire", #"hash_5c5c962a0971316a", 1);

          if(missile.weapon.name === # "hash_2b47921791da6f0" || missile.weapon.name === # "hash_67307aa00ad6f686") {
            self.owner zm_stats::increment_challenge_stat(#"hash_370c230dce9e1be6");
          }

          playFX(#"hash_2d3cd6bf4ac44fc0", missile.origin, (var_c51499f8, 0, 0), (0, 0, 1), 0, self.owner.team);
          missile notify(#"hash_38b24dfa52842786");
          missile delete();
        }
      }
    }

    if(var_feefd408) {
      a_players = function_a1ef346b();

      foreach(player in a_players) {
        arrayremovevalue(player.var_d93ab65, undefined);

        if(player.var_d93ab65.size) {
          if(!player perks::perk_hasperk(#"specialty_ammodrainsfromstockfirst")) {
            player perks::perk_setperk(#"specialty_ammodrainsfromstockfirst");
          }

          continue;
        }

        if(player perks::perk_hasperk(#"specialty_ammodrainsfromstockfirst")) {
          player perks::perk_unsetperk(#"specialty_ammodrainsfromstockfirst");
        }
      }
    }

    if(var_cf53ab1f) {
      var_47528896 = 0;

      foreach(player in function_a1ef346b()) {
        if(isinarray(player.var_d93ab65, self)) {
          var_47528896 = 1;
          break;
        }
      }

      if(var_47528896) {
        var_473d58cc = math::clamp(self.var_8ad82414 / 5, 0, 1);
        self.var_5b61dff6 = lerpfloat(0.04, 0.05, var_473d58cc);
        self.var_c91dca7e = lerpfloat(4, 5, var_473d58cc);
        self.var_fc827c27 = lerpfloat(10, 20, var_473d58cc);
        self.n_duration = lerpfloat(15, 20, var_473d58cc);
        self.var_8ad82414 += float(function_60d95f53()) / 1000;
      } else {
        self.var_8ad82414 = 0;
        self.var_5b61dff6 = 0.04;
        self.var_c91dca7e = 4;
        self.var_fc827c27 = 10;
        self.n_duration = 15;
      }
    }

    waitframe(1);
  }

  a_players = getplayers();

  foreach(player in a_players) {
    arrayremovevalue(player.var_d93ab65, undefined);

    if(!player.var_d93ab65.size) {
      if(player perks::perk_hasperk("specialty_ammodrainsfromstockfirst")) {
        player perks::perk_unsetperk("specialty_ammodrainsfromstockfirst");
      }

      player clientfield::set_to_player("" + # "hash_717ed5a81b281ebd", 0);
    }
  }

  a_actors = getactorarray();

  foreach(ai in a_actors) {
    if(!isDefined(ai)) {
      continue;
    }

    if(is_true(ai.var_25e2200c)) {
      ai.var_25e2200c = undefined;
    }
  }
}

function function_da2298bc() {
  self notify("<dev string:x38>");
  self endon("<dev string:x38>");

  while(getdvarint(#"hash_3ce5890428b398f1", 0) && isarray(level.var_686c81d7) && level.var_686c81d7.size) {
    foreach(var_3889eb68 in level.var_686c81d7) {
      if(!isDefined(var_3889eb68)) {
        continue;
      }

      var_1bc24030 = int(1 / float(function_60d95f53()) / 1000);

      if(getdvarint(#"hash_3ce5890428b398f1", 0)) {
        foreach(n_index, var_3889eb68 in level.var_686c81d7) {
          v_color = (1, 1, 1);

          if(function_baaff75b(var_3889eb68, var_3889eb68.owner)) {
            v_color = (1, 0.5, 0);
          }

          var_b68b8d0 = 200 + n_index * 120;
          cylinder(var_3889eb68.origin, var_3889eb68.origin + (0, 0, var_3889eb68.n_height), var_3889eb68.n_radius, v_color, 0, var_1bc24030);
          debug2dtext((500, var_b68b8d0, 0), "<dev string:x4c>" + var_3889eb68.var_c91dca7e, v_color, undefined, (0, 0, 0), 1, 0.8, var_1bc24030);

          if(var_3889eb68.var_bb41cf71) {
            debug2dtext((500, var_b68b8d0 + 20, 0), "<dev string:x72>" + var_3889eb68.var_fc827c27, v_color, undefined, (0, 0, 0), 1, 0.8, var_1bc24030);
          }

          debug2dtext((500, var_b68b8d0 + 40, 0), "<dev string:x95>" + var_3889eb68.var_5b61dff6, v_color, undefined, (0, 0, 0), 1, 0.8, var_1bc24030);
          debug2dtext((500, var_b68b8d0 + 60, 0), "<dev string:xc5>" + var_3889eb68.n_duration, v_color, undefined, (0, 0, 0), 1, 0.8, var_1bc24030);

          if(var_3889eb68.weapon.name === # "ring_of_fire_5" && isDefined(var_3889eb68.var_8ad82414)) {
            debug2dtext((500, var_b68b8d0 + 80, 0), "<dev string:xe0>" + floor(var_3889eb68.var_8ad82414), v_color, undefined, (0, 0, 0), 1, 0.8, var_1bc24030);
          }

          debug2dtext((500, var_b68b8d0 + 100, 0), "<dev string:x110>", v_color, undefined, (0, 0, 0), 1, 0.8, var_1bc24030);
        }
      }
    }

    wait 1;
  }
}