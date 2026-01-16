/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_silver_bullet.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_mansion_util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_crafting;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_items;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;
#include scripts\zm_common\zm_wallbuy;
#include scripts\zm_common\zm_weapons;

#namespace mansion_silver_bullet;

init(var_5ea5c94d) {
  callback::on_connect(&on_player_connect);
  zm::register_actor_damage_callback(&function_eb7664aa);
  level thread function_79fad591();
  zm_crafting::function_d1f16587(#"zblueprint_mansion_silver_bullet", &function_5a6cebce);
  level thread function_766980a4();
  level.var_c9fce264 = 0;
}

on_player_connect() {
  self flag::init(#"hash_56504ef435e17076");
  self.var_4a06bcd2 = &function_619e42ce;
  self thread function_3088962c();
}

cleanup(var_5ea5c94d, ended_early) {}

function_3088962c() {
  self endon(#"disconnect");

  while(true) {
    var_255fe317 = 0;
    s_notify = self waittill(#"weapon_change", #"hash_3cc002901b983064");

    if(s_notify._notify === #"weapon_change") {
      self clientfield::set_to_player("" + #"hash_6a4f537da00ae3f9", 0);
      self mansion_util::function_268efa09(0);
      s_notify = self waittilltimeout(1.2, #"weapon_change_complete");
    } else {
      var_255fe317 = 1;
    }

    if(s_notify._notify === #"timeout") {
      var_12680c28 = self getcurrentweapon();

      if(isDefined(var_12680c28)) {
        var_255fe317 = zm_utility::function_aa45670f(var_12680c28, 0);
      }
    }

    if(var_255fe317 || isDefined(s_notify.weapon) && zm_utility::function_aa45670f(s_notify.weapon, 0)) {
      self clientfield::set_to_player("" + #"hash_6a4f537da00ae3f9", 1);
      self mansion_util::function_268efa09(1);
    }
  }
}

function_766980a4() {
  level endon(#"end_game");

  while(true) {
    s_result = level waittill(#"blueprint_completed");

    if(s_result.produced == getweapon(#"zitem_silver_bullet_part_4")) {
      level zm_ui_inventory::function_7df6bb60(#"hash_26da6ef83af4ba62", 1);
      break;
    }
  }
}

function_79fad591() {
  level flagsys::wait_till(#"load_main_complete");

  foreach(s_stub in level.var_4fe2f84d[#"zblueprint_mansion_silver_bullet"]) {
    s_stub.prompt_and_visibility_func = &function_62018caa;
    s_stub.var_c060d2c8 = 0;
  }

  foreach(s_stub in level.var_4fe2f84d[#"zblueprint_mansion_silver_molten"]) {
    s_stub.var_c060d2c8 = 0;
  }
}

function_62018caa(e_player) {
  var_235457fd = self zm_crafting::function_126fc77c(e_player);

  if(var_235457fd) {
    var_87d6e5ff = zm_crafting::function_b18074d0(self.stub.blueprint.name);
    var_b3c7df1a = zm_crafting::function_b18074d0(#"zblueprint_mansion_silver_molten");

    if(!zm_items::player_has(e_player, var_87d6e5ff.component04) && zm_items::player_has(e_player, var_b3c7df1a.component01) && zm_items::player_has(e_player, var_b3c7df1a.component02) && zm_items::player_has(e_player, var_b3c7df1a.component03)) {
      self sethintstring(#"hash_3da7f56d63678947");
    }
  }

  return var_235457fd;
}

function_619e42ce(w_wallbuy, stub, var_111ca2ad) {
  if(isDefined(var_111ca2ad) && var_111ca2ad || self zm_utility::function_aa45670f(w_wallbuy, 0) || self zm_utility::function_aa45670f(zm_weapons::get_upgrade_weapon(w_wallbuy), 0)) {
    return function_8051ebe7(self, w_wallbuy, 0);
  }
}

function_8051ebe7(e_player, w_weapon, var_7e18912e) {
  if(isDefined(var_7e18912e) && var_7e18912e) {
    if(zm_weapons::is_weapon_upgraded(w_weapon)) {
      return 5500;
    } else {
      return function_bdddc37c(w_weapon);
    }
  }

  if(e_player zm_weapons::has_upgrade(w_weapon)) {
    return 5500;
  }

  if(e_player zm_weapons::has_weapon_or_upgrade(w_weapon)) {
    return function_bdddc37c(w_weapon);
  }
}

function_bdddc37c(w_weapon) {
  w_base_weapon = zm_weapons::get_base_weapon(w_weapon);

  if(isDefined(w_base_weapon)) {
    if(w_base_weapon == getweapon("pistol_topbreak_t8")) {
      return 380;
    }

    n_cost = zm_weapons::get_weapon_cost(w_base_weapon) * 0.75;

    if(isDefined(n_cost)) {
      return zm_utility::round_up_to_ten(int(n_cost));
    }
  }
}

function_eb7664aa(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  n_multi = 1;

  if(isalive(attacker) && isplayer(attacker) && isalive(inflictor) && isplayer(inflictor) && meansofdeath != "MOD_UNKNOWN" && meansofdeath != "MOD_MELEE" && meansofdeath != "MOD_AAT" && attacker zm_utility::function_aa45670f(weapon, 0)) {
    if(isDefined(self) && isDefined(self.archetype)) {
      switch (self.archetype) {
        case #"zombie":
          n_multi += 0.25;
          break;
        case #"werewolf":
          n_multi += 1;
          break;
        case #"zombie_dog":
          n_multi += 0.5;
          break;
        case #"blight_father":
          n_multi += 0.25;
          break;
        case #"catalyst":
          n_multi += 0.25;
          break;
        case #"bat":
          n_multi += 0.25;
          break;
        case #"nosferatu":
          n_multi += 0.5;
          break;
      }

      n_damage = int(damage * n_multi);

      if(n_damage > damage) {

        iprintln("<dev string:x38>" + n_damage - damage);

          return n_damage;
      }
    }
  }

  return -1;
}

function_5a6cebce(e_player) {
  s_loc = struct::get("silver_bullet_loc");
  s_loc zm_unitrigger::create(&function_252cf612, 34);
  s_loc thread function_dad1960c();
  zm_unitrigger::unitrigger_force_per_player_triggers(s_loc.s_unitrigger, 1);
}

function_252cf612(player) {
  var_12680c28 = player getcurrentweapon();

  if(!zm_loadout::is_hero_weapon(var_12680c28) && !zm_equipment::is_equipment(var_12680c28) && !(isDefined(var_12680c28.isriotshield) && var_12680c28.isriotshield) && !zm_weapons::is_wonder_weapon(var_12680c28) && var_12680c28 != level.weaponnone) {
    var_3ce66e88 = zm_weapons::get_base_weapon(var_12680c28);

    if(!isDefined(level.zombie_weapons[var_3ce66e88])) {
      return 0;
    }

    if(player zm_utility::function_aa45670f(var_12680c28, 0)) {
      if(player function_ec89dca9()) {
        self sethintstring(#"hash_4731c9534a6055b");
      } else if(isDefined(self.stub.var_6646a22) && self.stub.var_6646a22) {
        str_prompt = zm_utility::function_d6046228(#"hash_5d4b4dfdc53fd671", #"hash_7bd012fd92e7aaf");
        self sethintstring(str_prompt, 0);
      } else {
        n_cost = function_8051ebe7(player, var_12680c28, 1);
        str_prompt = zm_utility::function_d6046228(#"hash_5d4b4dfdc53fd671", #"hash_7bd012fd92e7aaf");
        self sethintstring(str_prompt, n_cost);
      }
    } else if(!player flag::get(#"hash_56504ef435e17076")) {
      str_prompt = zm_utility::function_d6046228(#"hash_558dab41980bd79b", #"hash_7bc5748f7802e011");
      self sethintstring(str_prompt);
    } else if(isDefined(self.stub.var_6646a22) && self.stub.var_6646a22) {
      str_prompt = zm_utility::function_d6046228(#"hash_558dab41980bd79b", #"hash_7bc5748f7802e011");
      self sethintstring(str_prompt);
    } else {
      n_cost = function_8051ebe7(player, var_12680c28, 1);

      if(isDefined(n_cost)) {
        self sethintstring(#"hash_9c2f7742abf6acb", n_cost);
      } else {

        iprintln("<dev string:x4f>" + function_9e72a96(var_12680c28.name) + "<dev string:x59>");

          return 0;
      }
    }

    return 1;
  }

  return 0;
}

function_dad1960c() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"trigger_activated");
    player = waitresult.e_who;
    n_cost = function_8051ebe7(player, player getcurrentweapon(), 1);

    if(!isDefined(n_cost)) {
      w_weapon = player getcurrentweapon();

      iprintln("<dev string:x4f>" + function_9e72a96(w_weapon.name) + "<dev string:x59>");

        continue;
    }

    if(!player zm_score::can_player_purchase(n_cost) && player flag::get(#"hash_56504ef435e17076")) {

      player iprintln("<dev string:x72>");

        player thread zm_audio::create_and_play_dialog(#"general", #"outofmoney");
      continue;
    }

    if(player function_ec89dca9()) {
      continue;
    }

    if(player flag::get(#"hash_56504ef435e17076")) {
      var_ff915b1d = player function_4e849ab();

      if(isDefined(var_ff915b1d) && var_ff915b1d) {
        player zm_score::minus_to_player_score(n_cost);
      }

      continue;
    }

    foreach(e_player in level.players) {
      if(isDefined(e_player.hud_bullet)) {
        e_player.hud_bullet destroy();
      }
    }

      if(!level.var_c9fce264) {
        player thread zm_vo::function_a2bd5a0c(#"hash_400e358c3529b05f", 1);
        level.var_c9fce264 = 1;
      }

    player function_4e849ab();
    player flag::set(#"hash_56504ef435e17076");
  }
}

function_ec89dca9() {
  w_current = self getcurrentweapon();

  if(!isDefined(w_current)) {
    return true;
  }

  if(zm_loadout::is_hero_weapon(w_current) || zm_equipment::is_equipment(w_current) || isDefined(w_current.isriotshield) && w_current.isriotshield || zm_weapons::is_wonder_weapon(w_current) || w_current == level.weaponnone) {
    return true;
  }

  if(self hasperk(#"specialty_extraammo")) {
    n_ammo_max = w_current.maxammo;
  } else {
    n_ammo_max = w_current.startammo;
  }

  if(self getweaponammoclip(w_current) == self getweaponammoclipsize(w_current) && self getweaponammostock(w_current) == n_ammo_max && self zm_utility::function_aa45670f(w_current, 0)) {
    return true;
  }

  return false;
}

function_4e849ab() {
  if(!isDefined(self.var_1ab0a315)) {
    self thread pap_watcher();
  }

  if(zm_utility::function_aa45670f(self.currentweapon, 0)) {
    var_ff915b1d = self zm_weapons::ammo_give(self.currentweapon);
  } else {
    var_ff915b1d = self zm_utility::function_28ee38f4(self.currentweapon, 0, 1);
  }

  if(isDefined(var_ff915b1d) && var_ff915b1d) {
    self notify(#"hash_3cc002901b983064");
  }

  return var_ff915b1d;
}

pap_watcher() {
  self endon(#"disconnect");
  self.var_1ab0a315 = 1;

  while(true) {
    self waittill(#"packing_weapon");

    if(isDefined(self.currentweapon)) {
      w_current = self.currentweapon;
      var_e7b17c0d = zm_weapons::get_upgrade_weapon(w_current);

      if(zm_utility::function_aa45670f(w_current, 0)) {
        self function_5a2bd56f(var_e7b17c0d);
      }
    }
  }
}

function_5a2bd56f(var_e7b17c0d) {
  self endon(#"disconnect");

  if(isDefined(self.var_14361e0c)) {
    n_timeout = self.var_14361e0c;
  } else {
    n_timeout = level.pack_a_punch.timeout;
  }

  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  while(true) {
    var_54a97edd = self waittill(#"weapon_give", #"pap_timeout");

    if(isDefined(var_54a97edd) && zm_weapons::function_93cd8e76(var_54a97edd) === var_e7b17c0d) {
      zm_utility::function_28ee38f4(var_54a97edd, 0, 0);
      return;
    }
  }
}