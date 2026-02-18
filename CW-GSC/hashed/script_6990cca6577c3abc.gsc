/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6990cca6577c3abc.gsc
***********************************************/

#using script_24c32478acf44108;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace namespace_6fc19861;

function private autoexec __init__system__() {
  system::register(#"hash_4c62174ea005e84e", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  level.axe_gun = getweapon(#"ww_axe_gun_melee_t9");
  level.var_948e5165 = getweapon(#"hash_18696150427f2efb");
  level.axe_gun_upgraded = getweapon(#"ww_axe_gun_melee_t9_upgraded");
  level.var_3e316c1b = getweapon(#"hash_7eab88123b09e2c");
  level.var_386befd7 = 22500;
  level.var_b8885484 = 750 / 20;
  callback::on_weapon_change(&function_16139ef4);
  callback::on_ai_killed(&function_e339e720);
  callback::on_ai_damage(&function_709843c2);
  callback::on_item_pickup(&on_item_pickup);
  callback::on_item_drop(&on_item_drop);
  callback::on_connect(&on_player_connect);

  if(!isDefined(level.var_91f71aa)) {
    level.var_91f71aa = [];
  } else if(!isarray(level.var_91f71aa)) {
    level.var_91f71aa = array(level.var_91f71aa);
  }

  level.var_91f71aa[# "axe_gun_energetic_shard_item_t9"] = &function_d243e3bc;
  level.var_91f71aa[# "axe_gun_volatile_crystal_item_t9"] = &function_6492d995;

  if(!isDefined(level.var_6e197241)) {
    level.var_6e197241 = [];
  } else if(!isarray(level.var_6e197241)) {
    level.var_6e197241 = array(level.var_6e197241);
  }

  level.var_6e197241[# "ww_axe_gun_melee_t9"] = 1;
  level.var_6e197241[# "ww_axe_gun_melee_t9_upgraded"] = 1;

  if(!isDefined(level.var_299abeff)) {
    level.var_299abeff = [];
  } else if(!isarray(level.var_299abeff)) {
    level.var_299abeff = array(level.var_299abeff);
  }

  level.var_299abeff[# "ww_axe_gun_melee_t9"] = &function_5a35d482;
  level.var_299abeff[# "ww_axe_gun_melee_t9_upgraded"] = &function_5a35d482;
  level.var_299abeff[# "hash_18696150427f2efb"] = &function_5a35d482;
  level.var_299abeff[# "hash_7eab88123b09e2c"] = &function_5a35d482;

  if(!isDefined(level.var_3216bc47)) {
    level.var_3216bc47 = [];
  } else if(!isarray(level.var_3216bc47)) {
    level.var_3216bc47 = array(level.var_3216bc47);
  }

  level.var_3216bc47[# "ww_axe_gun_melee_t9"] = &function_f53bdacf;
  level.var_3216bc47[# "ww_axe_gun_melee_t9_upgraded"] = &function_f53bdacf;
  level.var_3216bc47[# "hash_18696150427f2efb"] = &function_f53bdacf;
  level.var_3216bc47[# "hash_7eab88123b09e2c"] = &function_f53bdacf;

  if(!isDefined(level.var_faabb06f)) {
    level.var_faabb06f = [];
  } else if(!isarray(level.var_faabb06f)) {
    level.var_faabb06f = array(level.var_faabb06f);
  }

  if(!isinarray(level.var_faabb06f, #"hash_18696150427f2efb")) {
    level.var_faabb06f[level.var_faabb06f.size] = # "hash_18696150427f2efb";
  }

  if(!isDefined(level.var_faabb06f)) {
    level.var_faabb06f = [];
  } else if(!isarray(level.var_faabb06f)) {
    level.var_faabb06f = array(level.var_faabb06f);
  }

  if(!isinarray(level.var_faabb06f, #"hash_7eab88123b09e2c")) {
    level.var_faabb06f[level.var_faabb06f.size] = # "hash_7eab88123b09e2c";
  }

  zm_weapons::function_90953640(level.axe_gun, 5, float(function_60d95f53()) / 1000);
  zm_weapons::function_90953640(level.var_948e5165, 5, float(function_60d95f53()) / 1000);
  zm_weapons::function_90953640(level.axe_gun_upgraded, 5, float(function_60d95f53()) / 1000);
  zm_weapons::function_90953640(level.var_3e316c1b, 5, float(function_60d95f53()) / 1000);
  clientfield::register("actor", "" + # "hash_d1d4ed99da50a4b", 28000, 1, "int");
  clientfield::register("actor", "" + # "hash_4189b622ab06c2d5", 28000, 1, "counter");
  clientfield::register("actor", "" + # "hash_5c2324e6d994b886", 28000, 1, "counter");
  clientfield::register("scriptmover", "" + # "hash_403f172f69819024", 28000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_2b223a333ab436cd", 28000, 1, "int");
  clientfield::register("allplayers", "" + # "hash_5d6139b1ce0e7c82", 28000, 2, "int");
  clientfield::register("toplayer", "" + # "hash_13f32f06b0e858dd", 28000, 3, "int");
  namespace_9ff9f642::register_slowdown(#"hash_4d4e7225b8223af5", 0.75, 10);
  zm::function_84d343d(#"hash_18696150427f2efb", &function_adc762ac);
  zm::function_84d343d(#"hash_7eab88123b09e2c", &function_adc762ac);
  level.var_59505a17 = &function_565c848a;

  level thread function_e711fec1();
}

function postinit() {
  zm_weapons::function_8389c033(#"ww_axe_gun_melee_t9", #"ww_axe_gun_melee_t9");
}

function private on_player_connect() {
  self thread function_b4b736a0();
}

function private function_b4b736a0() {
  self notify("35a5a9395d21a138");
  self endon("35a5a9395d21a138");
  self endon(#"death");

  while(true) {
    self waittill(#"zmb_max_ammo", #"hash_75ec9942d2d5fd0f");
    waitframe(1);

    if(isDefined(self.var_c926b4fc)) {
      self.var_c926b4fc = 5;
      self clientfield::set_to_player("" + # "hash_13f32f06b0e858dd", self.var_c926b4fc + 1);
    }
  }
}

function function_5a35d482(weapon) {
  if(self.var_c926b4fc === 5) {
    var_94459b80 = 1;
  } else {
    var_94459b80 = 0;
  }

  if(weapon.name === # "ww_axe_gun_melee_t9" || weapon.name === # "ww_axe_gun_melee_t9_upgraded") {
    smg_weapon = weapon.altweapon;
  } else {
    smg_weapon = weapon;
  }

  maxammo = smg_weapon.maxammo;
  maxclip = smg_weapon.clipsize;
  currentammostock = self getweaponammostock(smg_weapon);
  currentclipammo = self getweaponammoclip(smg_weapon);

  if(currentammostock < maxammo || currentclipammo < maxclip) {
    var_769cba68 = 0;
  } else {
    var_769cba68 = 1;
  }

  return var_94459b80 && var_769cba68;
}

function function_f53bdacf(weapon) {
  if(weapon.name === # "ww_axe_gun_melee_t9" || weapon.name === # "ww_axe_gun_melee_t9_upgraded") {
    smg_weapon = weapon.altweapon;
  } else {
    smg_weapon = weapon;
  }

  self setweaponammoclip(smg_weapon, smg_weapon.clipsize);
  self setweaponammostock(smg_weapon, smg_weapon.maxammo);
  self.var_c926b4fc = 5;
  self clientfield::set_to_player("" + # "hash_13f32f06b0e858dd", self.var_c926b4fc + 1);
}

function function_16139ef4(params) {
  var_d30a4554 = function_58d581b6(params.weapon);
  var_4f3bcf2b = function_58d581b6(params.last_weapon);

  if(var_d30a4554) {
    if(!var_4f3bcf2b) {
      self setactionslot(1, "altmode");
    }

    if(function_565c848a(params.weapon)) {
      self thread axe_right_melee_attack_think(params.weapon);
      self thread function_219565f5(params.weapon);
      self clientfield::set("" + # "hash_5d6139b1ce0e7c82", 1);

      if(!is_true(self.var_7fe71a4d)) {
        self thread zm_equipment::show_hint_text(#"hash_43c861740b7191e5", 10);
        self.var_7fe71a4d = 1;
      }
    } else {
      self clientfield::set("" + # "hash_5d6139b1ce0e7c82", 2);

      if(!is_true(self.var_cbab3c85)) {
        self thread zm_equipment::show_hint_text(#"hash_5f1191a53e87c640", 10);
        self.var_cbab3c85 = 1;
      }
    }

    if(!isDefined(self.var_c926b4fc)) {
      self.var_c926b4fc = 5;
    }

    self clientfield::set_to_player("" + # "hash_13f32f06b0e858dd", self.var_c926b4fc + 1);
    return;
  }

  if(!function_58d581b6(params.weapon) && function_58d581b6(params.last_weapon)) {
    self setactionslot(1, "");
    self clientfield::set("" + # "hash_5d6139b1ce0e7c82", 0);
  }
}

function function_58d581b6(weapon) {
  return function_565c848a(weapon) || function_1b662278(weapon);
}

function function_565c848a(weapon) {
  if(isDefined(weapon)) {
    var_1236db9d = zm_weapons::function_386dacbc(weapon).name;

    switch (var_1236db9d) {
      case # "ww_axe_gun_melee_t9_upgraded":
      case # "ww_axe_gun_melee_t9":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function function_1b662278(weapon) {
  if(isDefined(weapon)) {
    var_1236db9d = zm_weapons::function_386dacbc(weapon).name;

    switch (var_1236db9d) {
      case # "hash_7eab88123b09e2c":
      case # "hash_18696150427f2efb":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function function_e339e720(s_params) {
  if(isPlayer(s_params.eattacker)) {
    player = s_params.eattacker;

    if(function_565c848a(s_params.weapon) && s_params.smeansofdeath === "MOD_MELEE") {
      player.armor += 10;
      player playSound(#"hash_4b89009623a94842");
      self zombie_utility::gib_random_parts();

      if(isDefined(self.var_fecf7735)) {
        self zm_utility::function_ffc279(self.var_fecf7735 * 150, player, self.health, s_params.weapon);
      }

      if(!isDefined(player.var_f7e829c0)) {
        player.var_f7e829c0 = 0;
      }

      if(!isDefined(player.var_2501c648)) {
        player.var_2501c648 = 0;
      }

      switch (self.zm_ai_category) {
        case # "normal":
          var_161794b5 = 2 + player.var_2501c648;
          break;
        case # "special":
          var_161794b5 = 10 + player.var_2501c648;
          break;
        case # "elite":
          var_161794b5 = 25 + player.var_2501c648;
          break;
        default:
          var_161794b5 = 0;
          break;
      }

      if(math::cointoss(var_161794b5)) {
        player.var_f7e829c0 = 0;
        player.var_2501c648 = 0;
        var_d4d3b41a = function_4ba8fde(#"axe_gun_volatile_crystal_item_t9");
        self thread item_drop::drop_item(0, undefined, 1, 0, var_d4d3b41a.id, self.origin);
        return;
      }

      player.var_f7e829c0++;

      if(player.var_f7e829c0 >= 20) {
        player.var_2501c648 += 5;
      }
    }
  }
}

function function_68ec4aa2() {
  targets = getaispeciesarray(level.zombie_team, "all");
  return targets;
}

function function_7862c208() {
  if(isDefined(level.var_60a2b62c)) {
    var_13ef9467 = [];

    foreach(loot_crystal in level.var_60a2b62c) {
      bundle = isDefined(loot_crystal.bundle) ? loot_crystal.bundle : zm_utility::function_b42da08a(loot_crystal);
      state = function_ffdbe8c2(loot_crystal);

      if(is_true(loot_crystal.dynentstates[state].var_b7401b42)) {
        continue;
      }

      if(!isDefined(var_13ef9467)) {
        var_13ef9467 = [];
      } else if(!isarray(var_13ef9467)) {
        var_13ef9467 = array(var_13ef9467);
      }

      var_13ef9467[var_13ef9467.size] = loot_crystal;
    }

    return var_13ef9467;
  }

  return [];
}

function function_6c14b72a() {
  if(isDefined(level.var_99018b7a)) {
    var_13ef9467 = [];

    foreach(var_5d028bf5 in level.var_99018b7a) {
      if(!isDefined(var_5d028bf5.health) || var_5d028bf5.health <= 0) {
        continue;
      }

      if(!isDefined(var_13ef9467)) {
        var_13ef9467 = [];
      } else if(!isarray(var_13ef9467)) {
        var_13ef9467 = array(var_13ef9467);
      }

      var_13ef9467[var_13ef9467.size] = var_5d028bf5;
    }

    return var_13ef9467;
  }

  return [];
}

function private axe_right_melee_attack_think(weapon) {
  self endon(#"death");
  var_17b7891d = "75cc23f3c91f3b51" + "axe_right_melee_attack_think";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  while(true) {
    self waittill(#"weapon_melee_power");
    self function_1ca5af86(weapon);
  }
}

function function_1ca5af86(weapon) {
  self endon(#"weapon_change", #"death");
  waitframe(5);
  self thread function_f3eae4ba(1, weapon);
  waitframe(10);
  self thread function_f3eae4ba(2, weapon);
}

function function_1fa698a6(target, view_pos, forward_view_angles, var_ccb70dad, target_pos, var_3270c905) {
  dist_sq = distancesquared(view_pos, target_pos);

  if(dist_sq > level.var_386befd7) {
    return false;
  }

  v_normal = vectornormalize(target_pos - self.origin);
  dot = vectordot(var_ccb70dad, v_normal);

  if(is_true(var_3270c905)) {
    if(dot <= 0 && dist_sq > 1600) {
      return false;
    }

    if(0 == target damageconetrace(view_pos, self, forward_view_angles)) {
      return false;
    }
  } else if(dot <= 0) {
    return false;
  }

  return true;
}

function function_f3eae4ba(var_6cd541c6, weapon = level.weaponnone) {
  if(!isalive(self)) {
    return;
  }

  axe_damage = 5000 * self function_e5469f27(weapon, 1);
  view_pos = self getEye();
  forward_view_angles = anglesToForward(self getplayerangles());

  if(forward_view_angles[2] < -0.7) {
    var_ccb70dad = (forward_view_angles[0], forward_view_angles[1], -0.25);
  } else {
    var_ccb70dad = forward_view_angles;
  }

  var_1da354d3 = level function_68ec4aa2();
  var_be07f1d4 = 0;

  foreach(target in var_1da354d3) {
    if(!isalive(target)) {
      continue;
    }

    test_origin = target getcentroid();

    if(!function_1fa698a6(target, view_pos, forward_view_angles, var_ccb70dad, test_origin, 1)) {
      continue;
    }

    n_random_x = randomfloatrange(-3, 3);
    n_random_y = randomfloatrange(-3, 3);
    var_61906722 = randomfloatrange(25, 45);
    v_ragdoll = vectornormalize(target.origin - self.origin + (n_random_x, n_random_y, var_61906722));
    self thread function_b9b06e2(target, weapon, var_6cd541c6, v_ragdoll, axe_damage);
    var_be07f1d4++;

    if(var_be07f1d4 >= 3) {
      break;
    }
  }

  var_c6da7c23 = level function_7862c208();

  foreach(target in var_c6da7c23) {
    test_origin = target.origin;

    if(!function_1fa698a6(target, view_pos, forward_view_angles, var_ccb70dad, test_origin, 0)) {
      continue;
    }

    target dodamage(target.health, self.origin, self, self, undefined, "MOD_MELEE");
  }

  var_330d827b = level function_6c14b72a();

  foreach(target in var_330d827b) {
    test_origin = target.origin;

    if(!function_1fa698a6(target, view_pos, forward_view_angles, var_ccb70dad, test_origin, 0)) {
      continue;
    }

    target dodamage(target.health, self.origin, self, self, undefined, "MOD_MELEE");
  }
}

function function_b9b06e2(e_target, weapon, var_6cd541c6 = level.weaponnone, v_to_target, n_damage) {
  if(!isalive(weapon)) {
    return;
  }

  if(!isDefined(weapon.zm_ai_category)) {
    return;
  }

  damage_location = weapon.origin + vectornormalize(self.origin - weapon.origin) * 10 + (0, 0, 60);
  weapon dodamage(n_damage, damage_location, self, self, "none", "MOD_MELEE", 0, var_6cd541c6);
  self playSound(#"hash_4b89009623a94842");

  if(isactor(weapon)) {
    weapon.var_fecf7735 = v_to_target;
  }
}

function private function_219565f5(weapon) {
  self endon(#"death");
  self notify("43c14c4f1b42d42a");
  self endon("43c14c4f1b42d42a");

  while(true) {
    self waittill(#"weapon_melee_power_left");

    if(is_true(self.var_9996fc0f)) {
      continue;
    }

    var_9040b50d = self gettagorigin("tag_weapon_right");
    waitframe(5);
    self thread function_f3eae4ba(1, weapon);

    if(isDefined(self.var_c926b4fc) && self.var_c926b4fc > 0) {
      self.var_c926b4fc--;
      self clientfield::set_to_player("" + # "hash_13f32f06b0e858dd", self.var_c926b4fc + 1);
      self.var_92188e6b = 1;
      self thread function_2d708b10();
      self thread axe_throw_start(weapon, var_9040b50d);
      continue;
    }

    iprintlnbold("<dev string:x38>");
  }
}

function private function_2d708b10() {
  self notify("5ebfc22ea53c9c6c");
  self endon("5ebfc22ea53c9c6c");
  self endon(#"disconnect");

  while(isalive(self) && self throwbuttonPressed() && function_565c848a(self getcurrentweapon())) {
    waitframe(1);
  }

  if(isDefined(self)) {
    self.var_92188e6b = 0;
  }
}

function function_a5abfa4a(str_notify) {
  if(isDefined(self.var_c5165568)) {
    self.var_c5165568 hide();
    self.var_c5165568 clientfield::set("" + # "hash_2b223a333ab436cd", 0);
    self.var_c5165568 clientfield::set("" + # "hash_403f172f69819024", 0);
    self.var_c5165568 thread function_766433e5();
  }
}

function function_766433e5() {
  self endon(#"death");
  wait 5;

  if(isDefined(self)) {
    self deletedelay();
  }
}

function private axe_throw_start(weapon, start_origin) {
  self endoncallback(&function_a5abfa4a, #"death");
  waitframe(1);
  paped = 0;
  var_deb20ded = self function_e5469f27(weapon, 1);

  if(var_deb20ded > 1) {
    paped = 1;
  }

  var_55b935c = 5000 * var_deb20ded;
  var_fca97989 = 5000 * var_deb20ded;

  if(!isDefined(start_origin)) {
    start_origin = self.origin;
  }

  if(!isDefined(self.var_c5165568)) {
    var_c5165568 = util::spawn_model("tag_origin", start_origin);
    self.var_c5165568 = var_c5165568;
  } else {
    var_c5165568 = self.var_c5165568;
  }

  if(!isDefined(var_c5165568)) {
    return;
  }

  self playSound(#"hash_4aac6b6f82b638fc");
  var_c5165568.origin = start_origin;
  var_c5165568 setModel("tag_origin");
  var_c5165568 show();

  if(paped) {
    var_c5165568 clientfield::set("" + # "hash_2b223a333ab436cd", 1);
  } else {
    var_c5165568 clientfield::set("" + # "hash_403f172f69819024", 1);
  }

  self.var_9996fc0f = 1;
  start_position = self getplayercamerapos();
  forward_direction = self getweaponforwarddir();
  end_position = start_position + forward_direction * 750;
  var_87916932 = bulletTrace(start_position, end_position, 0, self);

  if(var_87916932[# "fraction"] < 1) {
    end_position = var_87916932[# "position"];
  }

  var_2b94b479 = 1 * var_87916932[# "fraction"];

  if(var_2b94b479 < 0.01) {
    var_2b94b479 = 0.01;
  }

  var_c5165568.last_origin = var_c5165568.origin;
  var_c5165568.last_hit_target = self;
  var_c5165568.var_cc327795 = self;
  var_c5165568 moveto(end_position, var_2b94b479);
  var_48ce5c7e = gettime();
  var_11a5ceb4 = 0;

  while(var_11a5ceb4 < var_2b94b479) {
    waitframe(1);

    if(!isDefined(var_c5165568)) {
      return;
    }

    var_11a5ceb4 += float(function_60d95f53()) / 1000;
    var_525a6081 = self function_28a475cb(var_c5165568.last_origin, var_c5165568.origin, 50, weapon, var_55b935c, paped);

    if(var_525a6081 && is_true(self.var_92188e6b)) {
      break;
    }

    var_c5165568.last_origin = var_c5165568.origin;
  }

  if(is_true(self.var_92188e6b) && isDefined(var_c5165568)) {
    var_c5165568 moveto(var_c5165568.origin, float(function_60d95f53()) / 1000);
    var_2f1545ed = gettime();
    var_946e6de7 = 0;

    while(var_946e6de7 < 10 && is_true(self.var_92188e6b) && isDefined(var_c5165568)) {
      wait 0.2;
      self function_28a475cb(var_c5165568.origin, var_c5165568.origin, 50, weapon, var_fca97989, paped);
      var_946e6de7 += 0.2;
    }
  }

  var_c5165568 playSound(#"hash_24b690e088ad3b0b");
  var_f1395f3a = 0;
  var_15e3f0ba = self gettagorigin("tag_weapon_left");

  if(!isDefined(var_15e3f0ba)) {
    var_15e3f0ba = self.origin;
  }

  var_160a0478 = distance(var_15e3f0ba, var_c5165568.origin);
  var_505936b8 = 1 * var_160a0478 / 750;

  while(var_f1395f3a < var_505936b8 - 0.05) {
    waitframe(1);

    if(!isDefined(var_c5165568)) {
      return;
    }

    var_f1395f3a += float(function_60d95f53()) / 1000;

    if(!isentity(self)) {
      return;
    }

    var_173eb60b = self gettagorigin("tag_weapon_left");

    if(!isDefined(var_173eb60b)) {
      var_173eb60b = self.origin;
    }

    travel_time = var_505936b8 - var_f1395f3a;

    if(travel_time < 0.01) {
      travel_time = 0.01;
    }

    var_c5165568 moveto(var_173eb60b, travel_time);
    self function_28a475cb(var_c5165568.last_origin, var_c5165568.origin, 50, weapon, var_55b935c, paped);
    var_c5165568.last_origin = var_c5165568.origin;
  }

  if(isDefined(var_c5165568)) {
    if(paped) {
      var_c5165568 clientfield::set("" + # "hash_2b223a333ab436cd", 0);
    } else {
      var_c5165568 clientfield::set("" + # "hash_403f172f69819024", 0);
    }
  }

  self playSound(#"hash_41056c71c18559be");
  waitframe(1);

  if(isDefined(var_c5165568)) {
    var_c5165568 hide();
  }

  self.var_9996fc0f = 0;
}

function function_c3a6cbeb() {
  start = self getplayercamerapos();
  forward = self getweaponforwarddir();
  end = start + forward * 750;
  trace = bulletTrace(start, end, 1, self);

  if(trace[# "fraction"] < 1) {
    end = trace[# "position"];
  }

  return end;
}

function function_28a475cb(start_pos, end_pos, var_e7b59cda, var_50ebbc23, var_55b935c, paped) {
  var_d29cf4fc = self function_9a843b5a(start_pos, end_pos, var_e7b59cda);

  if(var_d29cf4fc.size > 0) {
    foreach(target in var_d29cf4fc) {
      target dodamage(target.health, end_pos, self, undefined, undefined, "MOD_MELEE", 0, var_50ebbc23);
    }
  }

  var_7d6d627e = self function_f8986ee9(start_pos, end_pos, var_e7b59cda);

  if(var_7d6d627e.size > 0) {
    foreach(target in var_7d6d627e) {
      target dodamage(var_55b935c, end_pos, self, undefined, undefined, "MOD_RIFLE_BULLET", 0, var_50ebbc23);

      if(paped) {
        target clientfield::increment("" + # "hash_5c2324e6d994b886", 1);
        continue;
      }

      target clientfield::increment("" + # "hash_4189b622ab06c2d5", 1);
    }

    return 1;
  }

  return 0;
}

function function_9a843b5a(start_pos, end_pos, var_e7b59cda) {
  var_dcce477a = level function_7862c208();
  var_f8233fc9 = [];
  var_1be6243c = [];
  var_f8233fc9 = function_24e9dbc2(end_pos, var_dcce477a, var_e7b59cda);

  if(start_pos != end_pos) {
    var_1be6243c = function_24e9dbc2((start_pos + end_pos) / 2, var_dcce477a, var_e7b59cda);
  }

  var_1a0e87c7 = arraycombine(var_f8233fc9, var_1be6243c, 0, 0);
  var_9b088cac = level function_6c14b72a();
  var_4cfabda9 = [];
  var_f5e620b6 = [];
  var_4cfabda9 = function_24e9dbc2(end_pos, var_9b088cac, var_e7b59cda);

  if(start_pos != end_pos) {
    var_f5e620b6 = function_24e9dbc2((start_pos + end_pos) / 2, var_9b088cac, var_e7b59cda);
  }

  var_1da833ff = arraycombine(var_4cfabda9, var_f5e620b6, 0, 0);
  return arraycombine(var_1a0e87c7, var_1da833ff, 0, 0);
}

function function_f8986ee9(start_pos, end_pos, var_e7b59cda) {
  targets = level function_68ec4aa2();
  var_9fae0643 = [];
  var_5ca1dd70 = [];
  var_9fae0643 = function_24e9dbc2(end_pos, targets, var_e7b59cda);

  if(start_pos != end_pos) {
    var_5ca1dd70 = function_24e9dbc2((start_pos + end_pos) / 2, targets, var_e7b59cda);
  }

  return arraycombine(var_9fae0643, var_5ca1dd70, 0, 0);
}

function function_24e9dbc2(position, array, var_e7b59cda) {
  var_7914206d = position - (0, 0, 50);
  ground_trace = groundtrace(position, var_7914206d, 0, self);

  if(ground_trace[# "fraction"] > 0.01 && ground_trace[# "fraction"] < 1) {
    var_7914206d = ground_trace[# "position"];
  }

  return array::get_all_closest(var_7914206d, array, undefined, undefined, var_e7b59cda);
}

function function_709843c2(params) {
  if(!is_true(self.zm_ai_category === # "normal")) {
    return;
  }

  b_death = params.idamage > self.health;

  if(is_true(self.var_687de2a9)) {
    self.var_d7b66cd8 += params.idamage;

    if(self.var_d7b66cd8 >= 3000 || params.smeansofdeath === "MOD_MELEE") {
      if(!is_true(self.var_3af9cf02)) {
        self.var_494ecedd = 1;
      } else {
        self notify(#"hash_6dffe1fcde89233f");
      }
    }

    if(is_true(b_death)) {
      self.health = params.idamage + 1;
    }

    return;
  }

  if(function_1b662278(params.weapon)) {
    var_7656a4ec = self function_d1534cde(params);

    if(is_true(var_7656a4ec)) {
      if(is_true(b_death)) {
        self.health = params.idamage + 1;
      }

      self thread function_f81a3f00(params);
    }
  }
}

function function_d1534cde(params) {
  return params.smeansofdeath !== "MOD_EXPLOSIVE" && params.smeansofdeath !== "MOD_MELEE" && math::cointoss(2);
}

function function_f81a3f00(params) {
  self.var_687de2a9 = 1;
  self clientfield::set("" + # "hash_d1d4ed99da50a4b", 1);
  self.var_d7b66cd8 = 0;
  self.var_3af9cf02 = 0;
  self thread function_f0be6705();
  self thread function_ed0d6200(params.eattacker, params.weapon);
  self thread namespace_9ff9f642::slowdown(#"hash_4d4e7225b8223af5");
}

function function_f0be6705() {
  self notify("6b14ef77a81d5345");
  self endon("6b14ef77a81d5345");
  self endon(#"death");
  wait 1;

  if(!isDefined(self)) {
    return;
  }

  self.var_3af9cf02 = 1;

  if(is_true(self.var_494ecedd)) {
    self notify(#"hash_6dffe1fcde89233f");
  }
}

function function_ed0d6200(attacker, weapon) {
  self notify("3a2ba44a728c447f");
  self endon("3a2ba44a728c447f");
  self endon(#"death");
  self waittilltimeout(6, #"hash_6dffe1fcde89233f");

  if(!zm_utility::is_magic_bullet_shield_enabled(self)) {
    self.var_4169c3be = 1;
    self clientfield::set("" + # "hash_d1d4ed99da50a4b", 0);
    self thread function_b9e23a1e(attacker, weapon);
  }
}

function function_b9e23a1e(attacker, weapon) {
  self endon(#"death");
  centroid = self getcentroid();
  a_targets = getentitiesinradius(centroid, 256, 15);

  foreach(ai in a_targets) {
    if(!isDefined(ai) || ai getteam() !== level.zombie_team) {
      continue;
    }

    if(isentity(ai) && isalive(ai)) {
      n_damage = zm_equipment::function_379f6b5d(200, getweapon(#"eq_sticky_grenade"), ai.zm_ai_category, ai.maxhealth);
      ai dodamage(n_damage, ai.origin, attacker, undefined, undefined, "MOD_EXPLOSIVE", 0, level.var_948e5165);
    }
  }

  wait 0.5;

  if(isDefined(self)) {
    var_47c940c2 = function_4ba8fde(#"axe_gun_energetic_shard_item_t9");
    item_drop::drop_item(0, undefined, 1, 0, var_47c940c2.id, self.origin);
    self.allowdeath = 1;
    self kill(self.origin, attacker, undefined, weapon, undefined, 1);
  }
}

function function_adc762ac(einflictor, eattacker, idamage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(!isalive(self)) {
    return 0;
  }

  var_d3c8f6cd = 1;

  if(isPlayer(shitloc) && boneindex !== "MOD_EXPLOSIVE") {
    var_d3c8f6cd = shitloc function_e5469f27(surfacetype, 0);
  }

  return psoffsettime * var_d3c8f6cd;
}

function function_d243e3bc(item) {
  if(isDefined(self function_49fa2899()) && isDefined(self.var_c926b4fc) && self.var_c926b4fc < 5) {
    return 1;
  }

  return 0;
}

function function_6492d995(item) {
  var_3c4fcfcf = self function_49fa2899();

  if(!isDefined(var_3c4fcfcf)) {
    return false;
  }

  maxstockammo = var_3c4fcfcf.altweapon.maxammo;
  currentstockammo = self getweaponammostock(var_3c4fcfcf.altweapon);
  return currentstockammo < maxstockammo;
}

function function_49fa2899() {
  var_b84949d0 = undefined;
  var_cb5aea38 = [17 + 1, 17 + 1 + 8 + 1, 17 + 1 + 8 + 1 + 8 + 1];

  foreach(slot in var_cb5aea38) {
    slot_item = self item_inventory::function_2e711614(slot);

    if(!isDefined(slot_item)) {
      continue;
    }

    slot_weapon = self item_inventory_util::function_2b83d3ff(slot_item);

    if(function_58d581b6(slot_weapon)) {
      var_b84949d0 = slot_weapon;
      break;
    }
  }

  return var_b84949d0;
}

function on_item_pickup(params) {
  item = params.item;

  if(isPlayer(self)) {
    if(isDefined(item.itementry.weapon) && function_58d581b6(item.itementry.weapon)) {
      self.var_c926b4fc = isDefined(item.var_c926b4fc) ? item.var_c926b4fc : 5;
      return;
    }

    if(item.itementry.name === # "axe_gun_energetic_shard_item_t9") {
      self.var_c926b4fc++;

      if(self.var_c926b4fc > 5) {
        self.var_c926b4fc = 5;
      }

      self clientfield::set_to_player("" + # "hash_13f32f06b0e858dd", self.var_c926b4fc + 1);

      iprintlnbold("<dev string:x6c>" + self.var_c926b4fc);

      return;
    }

    if(item.itementry.name === # "axe_gun_volatile_crystal_item_t9") {
      var_3c4fcfcf = self function_49fa2899();

      if(!isDefined(var_3c4fcfcf)) {
        return;
      }

      maxstockammo = var_3c4fcfcf.altweapon.maxammo;
      currentstockammo = self getweaponammostock(var_3c4fcfcf.altweapon);
      totalammo = currentstockammo + 70;

      if(totalammo > maxstockammo) {
        totalammo = maxstockammo;
      }

      self setweaponammostock(var_3c4fcfcf.altweapon, totalammo);

      iprintlnbold("<dev string:x90>" + totalammo);
    }
  }
}

function on_item_drop(params) {
  item = params.item;

  if(isPlayer(self) && isDefined(item.itementry.weapon) && function_58d581b6(item.itementry.weapon)) {
    item.var_c926b4fc = self.var_c926b4fc;
    self.var_c926b4fc = undefined;
  }
}

function function_e5469f27(weapon, var_131779dd) {
  var_55687712 = self item_inventory::function_230ceec4(weapon);

  if(isDefined(var_55687712.paplv)) {
    if(is_true(var_131779dd)) {
      switch (var_55687712.paplv) {
        case 1:
          return 2;
        case 2:
          return 4;
        case 3:
          return 6;
        default:
          return 1;
      }
    } else {
      switch (var_55687712.paplv) {
        case 1:
          return 1;
        case 2:
          return 1.75;
        case 3:
          return 2.5;
        default:
          return 1;
      }
    }
  }

  return 1;
}

function function_e711fec1() {
  level_name = util::get_map_name();

  if(level_name === "<dev string:xb7>") {
    util::add_debug_command("<dev string:xc6>");
    util::add_debug_command("<dev string:x13a>");
    util::add_debug_command("<dev string:x1ac>");
    zm_devgui::add_custom_devgui_callback(&cmd);
  }
}

function cmd(cmd) {
  switch (cmd) {
    case # "hash_4fd39fa505917bb8":
      function_4e036cff(#"axe_gun_volatile_crystal_item_t9");
      break;
    case # "hash_3282d077fe3c9d0c":
      function_4e036cff(#"axe_gun_energetic_shard_item_t9");
      break;
    case # "hash_2bbefdbbe0dcca8":
      function_c1fdd154();
      break;
    default:
      break;
  }
}

function function_4e036cff(item_name) {
  player = getplayers()[0];
  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = player getplayercamerapos();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  trace = bulletTrace(eye, eye + direction_vec, 0, undefined);
  drop_item = function_4ba8fde(item_name);
  item = item_drop::drop_item(0, undefined, 1, 0, drop_item.id, trace[# "position"]);
}

function function_c1fdd154(item_name) {
  players = getplayers();

  foreach(player in players) {
    player.var_c926b4fc = 5;
  }
}