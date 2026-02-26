/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7386ab623c3f6754.gsc
***********************************************/

#using script_176597095ddfaa17;
#using script_24c32478acf44108;
#using script_62caa307a394c18c;
#using script_72401f526ba71638;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\animation_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_utility;
#namespace namespace_bf2d4e77;

function private autoexec __init__system__() {
  system::register(#"hash_6be63b3e08b5ceb9", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  clientfield::register("actor", "" + # "hash_6a9eb737488c81c7", 11000, 1, "counter");
  clientfield::register("actor", "" + # "hash_13a6ddf6358f814", 11000, 1, "int");
  level.var_1765ad79 = 0;
  level.var_c23218c7 = [];
  namespace_1b527536::function_36e0540e(#"toxic_growth", 1, 30, #"field_upgrade_toxic_growth_item_sr");
  namespace_1b527536::function_36e0540e(#"toxic_growth_1", 1, 30, #"field_upgrade_toxic_growth_1_item_sr");
  namespace_1b527536::function_36e0540e(#"toxic_growth_2", 2, 30, #"field_upgrade_toxic_growth_2_item_sr");
  namespace_1b527536::function_36e0540e(#"toxic_growth_3", 2, 30, #"field_upgrade_toxic_growth_3_item_sr");
  namespace_1b527536::function_36e0540e(#"toxic_growth_4", 3, 30, #"field_upgrade_toxic_growth_4_item_sr");
  namespace_1b527536::function_36e0540e(#"toxic_growth_5", 3, 30, #"field_upgrade_toxic_growth_5_item_sr");
  namespace_1b527536::function_dbd391bf(#"toxic_growth", &function_d763fd41);
  namespace_1b527536::function_dbd391bf(#"toxic_growth_1", &function_d763fd41);
  namespace_1b527536::function_dbd391bf(#"toxic_growth_2", &function_d763fd41);
  namespace_1b527536::function_dbd391bf(#"toxic_growth_3", &function_d763fd41);
  namespace_1b527536::function_dbd391bf(#"toxic_growth_4", &function_d763fd41);
  namespace_1b527536::function_dbd391bf(#"toxic_growth_5", &function_d763fd41);
  weaponobjects::function_e6400478(#"toxic_growth", &function_464ccb73, 1);
  weaponobjects::function_e6400478(#"toxic_growth_1", &function_464ccb73, 1);
  weaponobjects::function_e6400478(#"toxic_growth_2", &function_464ccb73, 1);
  weaponobjects::function_e6400478(#"toxic_growth_3", &function_464ccb73, 1);
  weaponobjects::function_e6400478(#"toxic_growth_4", &function_464ccb73, 1);
  weaponobjects::function_e6400478(#"toxic_growth_5", &function_464ccb73, 1);
  deployable::register_deployable(getweapon(#"toxic_growth"), &function_c355b189, &function_c66c2af4, undefined, #"hash_37605398dce96965", 1);
  deployable::register_deployable(getweapon(#"toxic_growth_1"), &function_c355b189, &function_c66c2af4, undefined, #"hash_37605398dce96965", 1);
  deployable::register_deployable(getweapon(#"toxic_growth_2"), &function_c355b189, &function_c66c2af4, undefined, #"hash_37605398dce96965", 1);
  deployable::register_deployable(getweapon(#"toxic_growth_3"), &function_c355b189, &function_c66c2af4, undefined, #"hash_37605398dce96965", 1);
  deployable::register_deployable(getweapon(#"toxic_growth_4"), &function_c355b189, &function_c66c2af4, undefined, #"hash_37605398dce96965", 1);
  deployable::register_deployable(getweapon(#"toxic_growth_5"), &function_c355b189, &function_c66c2af4, undefined, #"hash_37605398dce96965", 1);
  callback::add_callback(#"hash_6dc96d04d1ba7f5a", &function_2ca4337c);
  namespace_9ff9f642::register_slowdown(#"toxic_growth", 0.6, 3);
  namespace_9ff9f642::register_slowdown(#"toxic_growth_1", 0.6, 3);
  namespace_9ff9f642::register_slowdown(#"toxic_growth_2", 0.6, 3);
  namespace_9ff9f642::register_slowdown(#"toxic_growth_3", 0.6, 3);
  namespace_9ff9f642::register_slowdown(#"toxic_growth_4", 0.6, 3);
  namespace_9ff9f642::register_slowdown(#"toxic_growth_5", 0.6, 3);
  namespace_9ff9f642::register_slowdown(#"hash_66bb6c828f73af96", 0.7, 3);
  namespace_9ff9f642::register_slowdown(#"hash_40f93ca047c821e6", 0.7, 3);
  namespace_9ff9f642::register_slowdown(#"hash_6be54a2bd9499617", 0.7, 3);
  namespace_9ff9f642::register_slowdown(#"hash_71a984b8f68b3538", 0.7, 3);
  namespace_9ff9f642::register_slowdown(#"hash_5aed6cd80a86a8e1", 0.7, 3);
  namespace_9ff9f642::register_slowdown(#"hash_132a3fe93930738a", 0.7, 3);
  namespace_9ff9f642::register_slowdown(#"hash_775ba6ec890d5dd6", 0.5, 3);
  zm_equipment::function_76beede2(#"toxic_growth", "MOD_GAS");
  zm_equipment::function_76beede2(#"toxic_growth_1", "MOD_GAS");
  zm_equipment::function_76beede2(#"toxic_growth_2", "MOD_GAS");
  zm_equipment::function_76beede2(#"toxic_growth_3", "MOD_GAS");
  zm_equipment::function_76beede2(#"toxic_growth_4", "MOD_GAS");
  zm_equipment::function_76beede2(#"toxic_growth_5", "MOD_GAS");
  zombie_utility::add_zombie_gib_weapon_callback(#"toxic_growth", &function_b70cf4bf, &function_b70cf4bf);
  zombie_utility::add_zombie_gib_weapon_callback(#"toxic_growth_1", &function_b70cf4bf, &function_b70cf4bf);
  zombie_utility::add_zombie_gib_weapon_callback(#"toxic_growth_2", &function_b70cf4bf, &function_b70cf4bf);
  zombie_utility::add_zombie_gib_weapon_callback(#"toxic_growth_3", &function_b70cf4bf, &function_b70cf4bf);
  zombie_utility::add_zombie_gib_weapon_callback(#"toxic_growth_4", &function_b70cf4bf, &function_b70cf4bf);
  zombie_utility::add_zombie_gib_weapon_callback(#"toxic_growth_5", &function_b70cf4bf, &function_b70cf4bf);
  callback::on_ai_killed(&on_ai_killed);
  callback::add_callback(#"on_host_migration_end", &on_host_migration_end);
}

function private on_host_migration_end(params) {
  if(isarray(level.var_c23218c7)) {
    foreach(var_f968837d in level.var_c23218c7) {
      if(isDefined(var_f968837d.var_deb3e8b1)) {
        var_f968837d.var_deb3e8b1 thread function_814f2bcd();
      }
    }
  }
}

function private function_b70cf4bf(n_damage_percent) {
  return false;
}

function private function_ef5cde9f(str_weapon_name) {
  if(!isDefined(str_weapon_name)) {
    return false;
  }

  switch (str_weapon_name) {
    case # "toxic_growth":
    case # "toxic_growth_5":
    case # "toxic_growth_4":
    case # "toxic_growth_3":
    case # "toxic_growth_2":
    case # "toxic_growth_1":
      return true;
  }

  return false;
}

function on_ai_killed(params) {
  if(params.weapon.name === # "toxic_growth_5" && is_true(self.var_d0de7f41) && params.einflictor.weapon === params.weapon) {
    self clientfield::increment("" + # "hash_6a9eb737488c81c7", 1);
    var_a0722b6e = getaiteamarray(level.zombie_team);
    var_a0722b6e = arraysortclosest(var_a0722b6e, self.origin, undefined, 0, 64);

    foreach(ai in var_a0722b6e) {
      if(ai != self && ai function_3fc6f786()) {
        ai.var_7fb7de87 = 1;
        ai.var_10552fac = 1;
        ai callback::callback(#"hash_69106b41ba3763f7");
        var_6254bcaf = self.maxhealth * 0.2;
        ai thread function_5276a443(#"toxic_growth_5", params.einflictor, var_6254bcaf, #"hash_775ba6ec890d5dd6");
      }
    }
  }
}

function function_464ccb73(watcher) {
  watcher.watchforfire = 1;
  watcher.onspawn = &function_27f93038;
  watcher.onfizzleout = &function_c3726ef3;
  watcher.timeout = 0;
}

function function_2ca4337c(params) {
  if(function_ef5cde9f(params.weapon.name)) {
    self thread zm_equipment::show_hint_text(#"hash_37605398dce96965", 1);
  }
}

function function_c355b189(origin, angles, player) {
  var_874a73c4 = isDefined(player.inventory.items[12].count) ? player.inventory.items[12].count : 0;

  if(var_874a73c4 <= 0) {
    return false;
  }

  if(isarray(level.var_c23218c7)) {
    arrayremovevalue(level.var_c23218c7, undefined);

    foreach(var_f968837d in level.var_c23218c7) {
      if(!isDefined(var_f968837d.trigger)) {
        continue;
      }

      if(istouching(angles, var_f968837d.trigger) || distance(angles, var_f968837d.trigger.origin) <= 92) {
        return false;
      }
    }
  }

  if(zm_utility::is_survival()) {
    if(level.contentmanager.activeobjective.content_script_name === "holdout" && isDefined(level.var_e6689780) || is_true(player.var_41c16555)) {
      if(!ispointonnavmesh(angles, 8)) {
        return false;
      }
    } else if(!ispointonnavmesh(angles, 8) || is_true(getgametypesetting(#"hash_59854c1f30538261")) && !namespace_d0ab5955::function_3824d2dc(angles)) {
      return false;
    }
  } else if(!zm_utility::function_c200446c()) {
    if(!zm_utility::check_point_in_playable_area(angles) || !zm_utility::check_point_in_enabled_zone(angles, 1) || !ispointonnavmesh(angles, 15)) {
      return false;
    }
  }

  return true;
}

function function_c66c2af4(player) {
  var_bc4bc76d = getweapon(#"toxic_growth");
  var_40da166f = player function_287dcf4b(75, int(115), 0, 0, var_bc4bc76d);

  if(!var_40da166f.isvalid) {
    var_40da166f = player function_242060b9(var_bc4bc76d);

    if(!var_40da166f.isvalid) {
      player function_bf191832(0, (0, 0, 0), (0, 0, 0));
      return var_40da166f;
    }
  }

  var_40da166f.origin = isDefined(var_40da166f.var_83050ca1) ? var_40da166f.var_83050ca1 : var_40da166f.origin;
  player.var_8b10aad1 = var_40da166f;
  return var_40da166f;
}

function function_27f93038(watcher, owner) {
  self endon(#"death");
  player = owner;
  v_origin = isDefined(player.var_8b10aad1.origin) ? player.var_8b10aad1.origin : player.var_b8878ba9;
  v_angles = isDefined(player.var_8b10aad1.angles) ? player.var_8b10aad1.angles : player.var_ddc03e10;

  if(!(isDefined(v_origin) && isDefined(v_angles))) {
    return;
  }

  self.var_deb3e8b1 = util::spawn_anim_model(watcher.weapon.var_22082a57, v_origin, v_angles);
  self.origin = v_origin;
  self.angles = v_angles;

  if(!isDefined(player.var_c23218c7)) {
    player.var_c23218c7 = [];
  } else if(!isarray(player.var_c23218c7)) {
    player.var_c23218c7 = array(player.var_c23218c7);
  }

  if(!isinarray(player.var_c23218c7, self)) {
    player.var_c23218c7[player.var_c23218c7.size] = self;
  }

  if(!isDefined(level.var_c23218c7)) {
    level.var_c23218c7 = [];
  } else if(!isarray(level.var_c23218c7)) {
    level.var_c23218c7 = array(level.var_c23218c7);
  }

  if(!isinarray(level.var_c23218c7, self)) {
    level.var_c23218c7[level.var_c23218c7.size] = self;
  }

  arrayremovevalue(player.var_c23218c7, undefined);
  arrayremovevalue(level.var_c23218c7, undefined);

  if(player.var_c23218c7.size > 3) {
    player.var_c23218c7[0] thread function_c3726ef3();
  }

  self.var_deb3e8b1 thread function_814f2bcd();
  self.trigger = spawn("trigger_box", v_origin + (0, 0, 20), 512 | 16 | 8192, 40, 115, 30);
  self.trigger.angles = v_angles;
  self.trigger.var_f968837d = self;
  self.trigger.var_deb3e8b1 = self.var_deb3e8b1;
  self.health = 1000;
  self.trigger callback::on_trigger(&function_ae618f2b);

  self thread function_56133646();
}

function function_56133646() {
  self endon(#"death");
  self.var_deb3e8b1 endon(#"death");

  while(true) {
    if(getdvarint(#"hash_3ce5890428b398f1", 0)) {
      if(isDefined(self.trigger)) {
        v_min = self.trigger getmins();
        v_max = self.trigger getmaxs();
        box(self.trigger.origin, v_min, v_max, self.trigger.angles, (0, 1, 0), undefined, undefined, 1);
        print3d(self.trigger.origin + (0, 0, 40), "<dev string:x38>" + self.health, (0, 1, 0), undefined, 0.4, 1);
      }
    }

    waitframe(1);
  }
}

function function_814f2bcd() {
  self endon(#"death");
  self scene::play(#"p9_fxanim_zm_gp_toxic_growth_scene", "expand", self);
  self thread scene::play(#"p9_fxanim_zm_gp_toxic_growth_scene", "idle_wide", self);
}

function function_ae618f2b(params) {
  ai = params.activator;

  if(isDefined(self.var_f968837d) && ai function_3fc6f786()) {
    ai.var_d0de7f41 = 1;
    ai.var_10552fac = 1;
    ai callback::callback(#"hash_69106b41ba3763f7");

    if(ai.zm_ai_category === # "special" || ai.zm_ai_category === # "elite") {
      var_86890135 = self.var_f968837d.weapon.name + "_special_elite";
    } else {
      var_86890135 = self.var_f968837d.weapon.name;
    }

    ai thread function_5276a443(self.var_f968837d.weapon.name, self.var_f968837d, undefined, var_86890135);
    return;
  }

  if(!isDefined(self.var_f968837d)) {
    if(isDefined(self.var_deb3e8b1)) {
      self.var_deb3e8b1 delete();
    }

    self deletedelay();
  }
}

function function_3fc6f786() {
  if(isactor(self) && isalive(self) && self.team === level.zombie_team && (self.zm_ai_category === # "normal" || self.zm_ai_category === # "special" || self.zm_ai_category === # "elite" || self.archetype === # "zombie_dog") && !is_true(self.var_d0de7f41) && !is_true(self.var_7fb7de87) && !is_true(self.var_8576e0be)) {
    if(!isDefined(self.var_207045e5) || gettime() >= self.var_207045e5 + 1000) {
      return true;
    }
  }

  return false;
}

function function_9ed9a337() {
  if(is_true(self.var_d0de7f41)) {
    self.var_d0de7f41 = undefined;
  }

  if(is_true(self.var_7fb7de87)) {
    self.var_7fb7de87 = undefined;
  }

  self.var_9258f88f = undefined;
  self.var_19ec2cc3 = undefined;
  self.var_10552fac = undefined;
  self clientfield::set("" + # "hash_13a6ddf6358f814", 0);
  self.var_207045e5 = gettime();
}

function function_5276a443(var_9055f9a9, var_f968837d, var_6254bcaf, var_86890135) {
  self notify("22eefdd2ca353d24");
  self endon("22eefdd2ca353d24");

  if(!isDefined(var_9055f9a9) || !isalive(self)) {
    return;
  }

  switch (var_9055f9a9) {
    case # "toxic_growth":
      var_da4a3267 = self.maxhealth * 0.2;
      var_34e3b3f7 = self.maxhealth * 0.025;
      var_4471a107 = 50;
      break;
    case # "toxic_growth_1":
      var_da4a3267 = self.maxhealth * 0.2;
      var_34e3b3f7 = self.maxhealth * 0.025;
      var_4471a107 = 25;
      break;
    case # "toxic_growth_2":
      var_da4a3267 = self.maxhealth * 0.2;
      var_34e3b3f7 = self.maxhealth * 0.025;
      var_4471a107 = 25;
      break;
    case # "toxic_growth_5":
    case # "toxic_growth_4":
    case # "toxic_growth_3":
      var_da4a3267 = self.maxhealth * 0.4;
      var_34e3b3f7 = self.maxhealth * 0.05;
      var_4471a107 = 25;
      break;
    default:
      return;
  }

  var_6b140fb2 = 1;
  self.var_9258f88f = var_f968837d.owner;
  weapon = var_f968837d.weapon;
  self clientfield::set("" + # "hash_13a6ddf6358f814", 1);

  if(isDefined(var_86890135)) {
    if(is_true(self.var_7b0667d9) || is_true(self.var_b736fc8b)) {
      self util::delay(3, "death", &function_9ed9a337);
    } else {
      self thread namespace_9ff9f642::slowdown(var_86890135, undefined, &function_9ed9a337);
    }

    if(self.zm_ai_category === # "special" || self.zm_ai_category === # "elite") {
      self.var_19ec2cc3 = 0.7;
    } else {
      self.var_19ec2cc3 = 0.6;
    }
  }

  if(!isDefined(level.var_cef2e607[#"hash_3e529c287efbdbff"])) {
    level.var_cef2e607[#"hash_3e529c287efbdbff"] = -1;
  }

  level.var_cef2e607[#"hash_3e529c287efbdbff"]++;
  wait float(function_60d95f53()) / 1000 * (level.var_cef2e607[#"hash_3e529c287efbdbff"] % int(float(function_60d95f53()) / 1000 / float(function_60d95f53()) / 1000) + 1);

  while(isalive(self) && (is_true(self.var_d0de7f41) || is_true(self.var_7fb7de87)) && !is_true(self.var_8576e0be)) {
    if(isDefined(var_6254bcaf)) {
      var_70ab6bc = var_6254bcaf;
      var_6254bcaf = undefined;
    } else if(self.zm_ai_category === # "elite" || self.zm_ai_category === # "special") {
      var_70ab6bc = var_34e3b3f7;
    } else {
      var_70ab6bc = var_da4a3267;
    }

    var_36635dd8 = isDefined(var_f968837d.origin) ? var_f968837d.origin : self.origin + (0, 0, 48);
    self namespace_42457a0::function_601fabe9(#"toxic", var_70ab6bc, var_36635dd8, self.var_9258f88f, var_f968837d, "none", "MOD_GAS", 0, weapon);
    self playSound(#"hash_25822a2d894aaa12");

    if(isDefined(var_f968837d)) {
      var_f968837d.health -= var_4471a107;

      if(var_f968837d.health <= 0) {
        var_f968837d thread function_c3726ef3();
      }
    }

    wait var_6b140fb2;
  }

  if(is_true(self.var_8576e0be)) {
    self namespace_9ff9f642::function_520f4da5(var_86890135);
  }
}

function function_c3726ef3() {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.trigger)) {
    self.trigger deletedelay();
  }

  if(isDefined(self.var_deb3e8b1) && !is_true(self.var_deb3e8b1.var_b5573fde)) {
    self.var_deb3e8b1.var_b5573fde = 1;
    self.var_deb3e8b1 scene::play(#"p9_fxanim_zm_gp_toxic_growth_scene", "collapse", self.var_deb3e8b1);
  }

  if(isDefined(self)) {
    deployable::function_81598103(self);

    if(isDefined(self.var_deb3e8b1)) {
      self.var_deb3e8b1 delete();
    }

    if(isDefined(self)) {
      self delete();
    }
  }
}

function function_d763fd41(params) {
  self namespace_1b527536::function_460882e2(1);
}