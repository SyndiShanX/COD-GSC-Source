/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_challenges.gsc
***********************************************/

#using script_437ce686d29bb81b;
#using script_5f261a5d57de5f7c;
#using script_62caa307a394c18c;
#using script_7d5c9b91cf8d272b;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\zm\killstreakrules;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_intel;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_challenges;

function private autoexec __init__system__() {
  system::register(#"zm_challenges", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&start_gametype);
  callback::on_spawned(&on_spawned);
  callback::on_player_damage(&on_damaged);
  callback::on_laststand(&on_laststand);
  callback::on_bleedout(&on_bleedout);
  callback::on_challenge_complete(&on_challenge_complete);
  callback::on_game_playing(&on_game_playing);
  callback::on_ai_killed(&death_check_for_challenge_updates);
  callback::add_callback(#"hash_7cdd5b06f3e281c6", &function_dfd4b1a0);
  callback::add_callback(#"hash_3ca80e35288a78d0", &function_1f01cc3b);
  callback::function_74872db6(&function_74872db6);
  callback::add_callback(#"hash_75d9baf9eed8610b", &function_74872db6);
  callback::add_callback(#"parachute", &function_c75bd5cb);
  callback::add_callback(#"objective_ended", &function_37c1c391);

  if(!zm_utility::is_survival() && !zm_utility::function_c200446c()) {
    callback::on_connect(&function_611805cb);
    level thread function_a87d82d1();
  }

  thread function_e71942eb();
  level.var_417f4274 = [];

  for(i = 0; i < 4; i++) {
    new_throttle = new class_c6c0e94();
    [[new_throttle]] - > initialize(#"hash_53ac88fccc8c24db", 1, float(function_60d95f53()) / 1000);
    level.var_417f4274[level.var_417f4274.size] = new_throttle;
  }

  level.var_faccd7d4 = [# "hash_2138b9a62ba26ce3": &function_8c48d8ff, #"hash_749cd3eb9a2fe063": &function_8c48d8ff, #"hash_1f8a926447abe886": &function_8c48d8ff, #"hash_116e94a600e48352": &function_486d4ce3];
}

function private function_74872db6() {
  if(getdvarint(#"hash_1ad35129069d0b0a", 0) && zm_utility::get_round_number() === 15) {
    foreach(player in getplayers()) {
      player zm_stats::function_17ee4529(#"hash_4941bc4d64a8e38", 1, #"hash_5c49df97f4f82e12");
    }
  }
}

function private function_1f01cc3b() {
  util::function_64ebd94d();

  if(getdvarint(#"hash_1ad35129069d0b0a", 0)) {
    if(zm_utility::get_round_number() >= 5) {
      foreach(player in getplayers()) {
        player zm_stats::function_17ee4529(#"hash_5677d9133114a8ac", 1, #"hash_5c49df97f4f82e12");
      }
    }
  }

  if(is_true(getgametypesetting(#"hash_5183877c20675325"))) {
    if(zm_utility::get_round_number() >= 5) {
      foreach(player in getplayers()) {
        player zm_stats::function_17ee4529(#"hash_513bd1963a91e24d", 1, #"hash_735ace6b22542a65");
      }
    }
  }
}

function private function_37c1c391(eventstruct) {
  if(level.var_fdcaf3a6 === level.contentmanager.var_1d9d92ba) {
    return;
  }

  if(!is_true(eventstruct.completed)) {
    return;
  }

  foreach(player in getplayers()) {
    player stats::function_dad108fa(#"hash_184d672dc3614f1f", 1);
    player zm_stats::function_7ec42fbf(#"hash_6d52ae8b2b73008b", 1);
    player contracts::increment_zm_contract(#"hash_5641c97526886d16");

    if(is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
      player zm_stats::function_17ee4529(#"hash_5a970e436e734f6", 1, #"hash_6abe83944d701459");
    }
  }
}

function private postinit() {
  level thread spent_points_tracking();
  level thread function_a9f6b8ef();
}

function start_gametype() {
  waittillframeend();
  challenges::registerchallengescallback("gun_level_complete_last_rank", &function_b15a1e1e);
  callback::on_connect(&on_connect);

  if(is_true(level.var_ce7af4fa)) {
    level thread function_f6cfe355();
  }
}

function on_connect() {
  self thread round_tracking();
  self thread function_e365b5ab();
  self thread function_5bec2304();
  self thread function_169107a0();
  self thread function_d61cb0eb();
  self thread function_b5df0b8b();
  self thread function_12a35616();
  self thread function_b3862180();
  self thread function_4f4a3c59();
  self thread function_79deb4a0();
  self thread function_874334a5();
  self thread watchformantle();
  self thread function_31de0f93();
  self.var_9cd2c51d = {};
  self.var_152810ff = [];
  self.var_152810ff[0] = 0;
  self.var_152810ff[1] = 0;
  self.var_152810ff[2] = 0;
  self.var_152810ff[3] = 0;
  self.var_152810ff[4] = 0;
  self.var_152810ff[5] = 0;
  self.var_152810ff[6] = 1;
}

function on_spawned() {
  if(zm_utility::is_survival()) {
    if(!isDefined(self.var_dbd7c18f)) {
      self.var_dbd7c18f = 0;
    }
  }

  self thread function_70fb11de(3);
  self thread function_ef2d2d4d();
  self thread function_64a04e4a();
}

function on_damaged(params) {
  self.var_152810ff[1] = 1;
  self.var_152810ff[4] = 1;
  self.var_bd019bbf = 0;

  if(isDefined(self.var_4dd3d657) && self.var_4dd3d657.size > 0) {
    self.var_4dd3d657 = [];
  }
}

function on_laststand() {
  self.var_152810ff[2] = 1;
  self.var_152810ff[5] = 1;
}

function on_bleedout() {
  self.var_152810ff[3] = 1;
}

function function_c75bd5cb(params) {
  if(isPlayer(self)) {
    self thread function_a0dbb404();
  }
}

function private function_a0dbb404() {
  self endon(#"death");

  while(self isparachuting() && !self isonground()) {
    waitframe(1);
  }

  self thread function_87e6005();
}

function private function_87e6005() {
  self.var_bd593810 = 1;
  wait 3;

  if(isDefined(self)) {
    self.var_bd593810 = undefined;
  }
}

function function_a87d82d1() {
  level endon(#"end_game");
  level waittill(#"door_opened");
  callback::remove_on_connect(&function_611805cb);
}

function function_611805cb() {
  self notify("9fe34900a723f34");
  self endon("9fe34900a723f34");
  level endon(#"door_opened", #"end_game", #"hash_6efaa75e1959aa0f");
  self endon(#"death");

  if(level.round_number > 1 || level flag::get(#"hash_6efaa75e1959aa0f")) {
    return;
  }

  while(true) {
    level waittill(#"end_of_round");

    if(level.round_number >= 19) {
      break;
    }
  }

  self zm_stats::increment_challenge_stat(#"hash_2b4c8ac9156d7564");
}

function round_tracking() {
  self endon(#"disconnect");

  while(true) {
    if(!isDefined(self.var_3c91d68e)) {
      self.var_3c91d68e = 0;
    }

    if(isDefined(level.var_27028b8e)) {
      var_35def1e9 = [[level.var_27028b8e]](self zm_zonemgr::get_player_zone());
    }

    level waittill(#"end_of_round");

    if(isDefined(level.var_27028b8e) && isDefined(var_35def1e9) && !is_true(self.var_b0d21209)) {
      var_1af3f5af = [[level.var_27028b8e]](self zm_zonemgr::get_player_zone());

      if(var_35def1e9 === var_1af3f5af) {
        self.var_3c91d68e++;

        if(self.var_3c91d68e >= 5) {
          self.var_b0d21209 = 1;
          self zm_stats::function_7ec42fbf(#"hash_1b4587ccc6718a54");
        }
      } else {
        self.var_3c91d68e = 0;
      }
    }

    if(!isDefined(self.var_e394d7c0)) {
      self.var_e394d7c0 = 0;
    }

    self.var_e394d7c0++;

    if(zm_utility::is_classic() && isDefined(level.round_number)) {
      var_4533f4c2 = self stats::function_1bb1c57c(#"globalchallenges", #"hash_6a3b487c924d7081", #"challengetier");

      if(!isDefined(var_4533f4c2)) {
        var_4533f4c2 = 0;
      }

      if(var_4533f4c2 < 1) {
        if(level.round_number == 20) {
          self stats::function_dad108fa(#"hash_6a3b487c924d7081", 20);
        } else if(level.round_number < 20) {
          var_12d3a336 = self stats::function_1bb1c57c(#"globalchallenges", #"hash_6a3b487c924d7081", #"challengevalue");

          if(!isDefined(var_12d3a336)) {
            var_12d3a336 = 0;
          }

          if(var_12d3a336 < level.round_number && var_12d3a336 < 19) {
            self stats::function_dad108fa(#"hash_6a3b487c924d7081", 1);
          }
        }
      }
    }

    if(self.var_e394d7c0 < level.round_number - 10) {
      continue;
    }

    if(zm_utility::is_trials() && level flag::get("round_reset")) {
      continue;
    }

    self debug_print("<dev string:x38>");

    self zm_stats::function_c0c6ab19(#"survive_rounds", 1, 1);

    if(level.round_number == 19 && zm_utility::is_classic() && !self.var_152810ff[4]) {
      self debug_print("<dev string:x62>");

      self zm_stats::increment_challenge_stat(#"hash_758b3285de8999f", undefined, 1);
    }

    if(!self.var_152810ff[1]) {
      self debug_print("<dev string:x9e>");

      self zm_stats::increment_challenge_stat(#"rounds_no_damage", undefined, 1);
    }

    if(!self.var_152810ff[2]) {
      self debug_print("<dev string:xd7>");

      self zm_stats::increment_challenge_stat(#"rounds_no_downs", undefined, 1);
    }

    if(level.round_number === 99) {
      self zm_stats::increment_challenge_stat(#"hash_b1ca52c5ef21dcb");
    }

    if(level.round_number === 19 && !self.var_152810ff[4]) {
      self zm_stats::increment_challenge_stat(#"hash_2030b96b5a4b7a90");
    }

    if(level.round_number === 19 && is_true(self.var_152810ff[6]) && !isDefined(self.var_d0355ca8) && self stats::get_stat(#"hash_2dd2a2b3580dd409", #"rarity_upgrade") == 0) {
      self zm_stats::increment_challenge_stat(#"hash_1a9f296012aa60db");
    }

    if(level.round_number === 29 && !self.var_152810ff[5]) {
      self zm_stats::increment_challenge_stat(#"hash_75a098c0db2ab15c");
    }

    self.var_152810ff[1] = 0;
    self.var_152810ff[2] = 0;
  }
}

function private function_dfd4b1a0(params) {
  if(isPlayer(params.eattacker)) {
    if(!isDefined(params.eattacker.var_154f23db)) {
      params.eattacker.var_154f23db = [];
    }

    function_1eaaceab(params.eattacker.var_154f23db);

    if(!isDefined(params.eattacker.var_154f23db)) {
      params.eattacker.var_154f23db = [];
    } else if(!isarray(params.eattacker.var_154f23db)) {
      params.eattacker.var_154f23db = array(params.eattacker.var_154f23db);
    }

    if(!isinarray(params.eattacker.var_154f23db, self)) {
      params.eattacker.var_154f23db[params.eattacker.var_154f23db.size] = self;
    }

    if(params.eattacker.var_154f23db.size >= 3) {
      params.eattacker zm_stats::increment_challenge_stat(#"hash_51b6a492525184b5");
    }
  }
}

function death_check_for_challenge_updates(params) {
  self thread function_f807c679(params.eattacker, params.einflictor);
}

function function_f807c679(e_attacker, e_inflictor) {
  if(!isDefined(e_attacker)) {
    return;
  }

  if(isai(e_attacker) && e_attacker.archetype === # "tormentor" && self.damagemod === "MOD_EXPLOSIVE") {
    if(isPlayer(e_attacker.attacker)) {
      e_attacker.attacker zm_stats::increment_challenge_stat(#"hash_a2f3ba1ce10b5da");
      e_attacker.attacker zm_stats::function_7ec42fbf(#"hash_4fda6c4372b053eb");
      return;
    }

    if(isPlayer(e_attacker.var_443d78cc)) {
      e_attacker.var_443d78cc zm_stats::increment_challenge_stat(#"hash_a2f3ba1ce10b5da");
      return;
    }
  }

  if(!isPlayer(e_attacker)) {
    return;
  }

  var_60a19127 = 0;

  if(self.archetype === # "abom") {
    if(namespace_361e505d::function_17ae1df1(self, 0) && namespace_361e505d::function_17ae1df1(self, 1) && namespace_361e505d::function_17ae1df1(self, 2)) {
      var_60a19127 = 1;
    }
  }

  var_a0345f37 = {
    #str_damagemod: isvehicle(self) ? self.str_damagemod : self.damagemod, #w_damage: isvehicle(self) ? self.w_damage : self.damageweapon, #is_stunned: self ai::is_stunned(), #archetype: self.archetype, #subarchetype: self.subarchetype, #zm_ai_category: self.zm_ai_category, #var_d1b39105: self flag::get(#"deadwire_stun"), #var_8126f3c8: self.var_8126f3c8, #enemy_override: self.enemy_override, #var_2290a541: isDefined(self.var_2290a541) ? self.var_2290a541 : 0, #var_84e41b20: self.var_84e41b20, #var_88421cc2: self.var_88421cc2, #var_cbf4894c: self.var_cbf4894c, #var_36fa0ac4: self.var_36fa0ac4, #aat_turned: self.aat_turned, #var_6e9934ba: self.var_6e9934ba, #var_1d8cde9: self.var_1d8cde9, #var_958cf9c5: self.var_958cf9c5, #var_1b760cdb: self.var_d0de7f41, #var_81af229: self.var_9258f88f, #var_fc304017: self.var_fc304017, #var_5c09e990: self.var_5c09e990, #missinglegs: self.missinglegs, #stuck_items: self.stuck_items, #origin: self.origin, #var_3f87fe17: self.var_3f87fe17, #var_e12c4e3d: self.var_8a3828c6, #var_7fde19e8: self.var_7fde19e8, #var_276a8013: self.var_276a8013, #var_60a19127: var_60a19127, #var_18551f4: self.var_390850ac, #var_85e14c33: self flag::get(#"hash_6ab8e3db32b20d33")
  };
  weaponslotid = e_attacker item_inventory::function_d768ea30();
  weapon_item = e_attacker.inventory.items[weaponslotid];
  w_stat = zm_weapons::get_base_weapon(var_a0345f37.w_damage);
  var_947d01ee = level.zombie_weapons[w_stat].weapon_classname;

  if(isDefined(weapon_item.itementry.rarity)) {
    var_74ca2ca1 = zm_weapons::function_137f88c6(weapon_item.itementry.rarity);
  }

  var_bbfa9bda = {
    #weapon_item: weapon_item, #var_7c9dadeb: e_attacker zm_perks::function_9a0e9d65(), #var_611eda49: e_attacker zm_perks::function_80514167(), #var_31af8fb0: e_attacker zm_powerups::is_insta_kill_active()
  };
  var_a0345f37.is_headshot = self zm_utility::is_headshot(var_a0345f37.w_damage, self.damagelocation, var_a0345f37.str_damagemod);
  var_a0345f37.var_d3ed3a9b = self zm_utility::function_4562a3ef(self.damagelocation);
  var_bbfa9bda.element = namespace_42457a0::function_d6863a3(e_inflictor, e_attacker, var_a0345f37.str_damagemod, var_a0345f37.w_damage, var_bbfa9bda.weapon_item.aat, var_bbfa9bda.weapon_item);
  var_a0345f37.var_5c57c8c1 = isDefined(self.var_19f5037) && is_true(self.var_19f5037[var_bbfa9bda.element]);
  waitframe(1);

  if(!isPlayer(e_attacker)) {
    return;
  }

  dummy_struct = {};
  [[level.var_417f4274[e_attacker getentitynumber()]]] - > waitinqueue(dummy_struct);

  if(!isPlayer(e_attacker)) {
    return;
  }

  if(is_true(var_a0345f37.var_60a19127)) {
    e_attacker zm_stats::increment_challenge_stat(#"hash_5be9c19eb061c8e");
  }

  if(is_true(var_a0345f37.var_18551f4)) {
    e_attacker zm_stats::function_7ec42fbf(#"hash_1c411a909421fc85");
    e_attacker zm_stats::increment_challenge_stat(#"hash_526aeb1ca606fe59");
  }

  if(is_true(var_a0345f37.archetype === # "abom") && var_a0345f37.str_damagemod === "MOD_MELEE") {
    e_attacker zm_stats::function_51c1448(#"hash_492732555967d2a2", 1, #"hash_2b2b28f1d1323b99", #"melee_battleaxe_t9");
  }

  if(is_true(var_a0345f37.var_85e14c33) && (var_a0345f37.zm_ai_category === # "special" || var_a0345f37.zm_ai_category === # "elite")) {
    e_attacker zm_stats::increment_challenge_stat(#"hash_617a35610ee3f4c1");
  }

  if(var_a0345f37.str_damagemod === "MOD_MELEE" && w_stat.name === # "ww_axe_gun_melee_t9") {
    e_attacker zm_stats::increment_challenge_stat(#"hash_3c8dc5747bf561e2");
  }

  if(is_true(e_attacker.var_b0b3c4df)) {
    e_attacker zm_stats::increment_challenge_stat(#"hash_5440867be903f580");
    e_attacker zm_stats::function_7ec42fbf(#"hash_1dce8a1f4224e648");
  }

  if(zm_utility::is_player_valid(e_attacker, 0, 0)) {
    if(is_true(var_a0345f37.var_5c57c8c1)) {
      e_attacker zm_stats::function_7ec42fbf(#"hash_120456cb37b4ac3b");
      e_attacker zm_stats::increment_challenge_stat(#"hash_5a04e5e551fdc490");
    }

    if(var_a0345f37.zm_ai_category === # "boss") {
      if(var_a0345f37.str_damagemod === "MOD_MELEE") {
        e_attacker zm_stats::increment_challenge_stat(#"hash_28a2a7b195211268");
      }
    }

    if(isDefined(var_a0345f37.var_3f87fe17)) {
      deathtime = gettime();
      difftime = deathtime - (isDefined(var_a0345f37.var_3f87fe17.stun_time) ? var_a0345f37.var_3f87fe17.stun_time : 0);

      if(float(difftime) / 1000 <= 2) {
        e_attacker zm_stats::increment_challenge_stat(#"hash_796cd4fb6181046f");
      }
    }

    if(isDefined(var_a0345f37.enemy_override) && var_a0345f37.enemy_override.weapon.name === # "nightingale_zm" && (var_a0345f37.w_damage.name === # "frag_grenade" || var_a0345f37.w_damage.name === # "eq_sticky_grenade")) {
      e_attacker zm_stats::increment_challenge_stat(#"hash_44a8be5f522bfbb");
    }

    if(var_a0345f37.w_damage.name === # "hatchet" && (var_a0345f37.zm_ai_category === # "elite" || var_a0345f37.zm_ai_category === # "special")) {
      e_attacker zm_stats::increment_challenge_stat(#"hash_1daafc9c2aadfb3d");
    }

    if(is_true(var_a0345f37.var_d3ed3a9b) && !e_attacker playerads() && var_a0345f37.str_damagemod !== "MOD_MELEE" && var_a0345f37.str_damagemod !== "MOD_MELEE_WEAPON_BUTT" && var_a0345f37.str_damagemod !== "MOD_CRUSH" && !isvehicle(e_inflictor)) {
      if(w_stat.name === # "hero_pineapplegun" || w_stat.name === # "sig_bow_flame" || (w_stat.inventorytype === # "dwlefthand" || w_stat.inventorytype === # "primary" || w_stat.inventorytype === # "altmode") && !killstreaks::is_killstreak_weapon(w_stat)) {
        e_attacker zm_stats::increment_challenge_stat(#"hash_6e9ed00c931e3aad");
      }
    }

    if(is_true(var_a0345f37.var_d3ed3a9b) && e_attacker namespace_e86ffa8::function_7bf30775()) {
      e_attacker stats::function_dad108fa(#"hash_70f048948f3fb670", 1);
    }

    if(is_true(var_a0345f37.var_1b760cdb) && e_attacker === var_a0345f37.var_81af229) {
      e_attacker stats::function_dad108fa(#"hash_5d5cac785e5018aa", 1);

      if(var_a0345f37.zm_ai_category === # "elite" || var_a0345f37.zm_ai_category === # "special") {
        if(var_947d01ee === "smg") {
          e_attacker zm_stats::function_51c1448(#"hash_510817c4cd9369ef", 1, #"hash_7483a7699470a94c", #"smg_spray_t9");
        }
      }
    }

    if(e_attacker isinvehicle()) {
      vehicle = e_attacker getvehicleoccupied();

      if(vehicle.vehicleclass === "boat") {
        e_attacker zm_stats::increment_challenge_stat(#"hash_3139fa102654452a");
      }

      if(vehicle.vehicleclass === "tank") {
        e_attacker zm_stats::increment_challenge_stat(#"hash_3aade606855dd31b");
      }

      e_attacker contracts::increment_zm_contract(#"hash_185d34a3847fe23c");
    }

    if(var_a0345f37.var_e12c4e3d === e_attacker && (var_a0345f37.zm_ai_category == # "elite" || var_a0345f37.zm_ai_category == # "special") && var_947d01ee === "melee") {
      e_attacker stats::function_d0de7686(#"hash_32e5fd6487f5c9fa", 1, #"hash_663c1b8697faad25");
    }

    if(var_947d01ee === "smg" && var_a0345f37.archetype === # "avogadro") {
      if(gettime() - (isDefined(var_a0345f37.var_7fde19e8) ? var_a0345f37.var_7fde19e8 : 0) <= int(2 * 1000)) {
        e_attacker stats::function_d0de7686(#"hash_3b12ed4f1d5665e1", 1, #"hash_564ba202834000a6");
      }
    }
  }

  if(zm_loadout::is_lethal_grenade(var_a0345f37.w_damage)) {
    e_attacker stats::function_dad108fa(#"hash_2d868c0eda640cc6", 1);
    e_attacker zm_stats::increment_challenge_stat(#"hash_7128b5364ae54a0d");

    if(var_a0345f37.zm_ai_category === # "special" || var_a0345f37.zm_ai_category === # "elite") {
      e_attacker zm_stats::increment_challenge_stat(#"hash_6077506b8728c093");
    }
  }

  if(isDefined(var_bbfa9bda.weapon_item.aat)) {
    e_attacker stats::function_dad108fa(#"hash_5e89396e6f618c5a", 1);
  }

  if(var_bbfa9bda.weapon_item.var_627c698b.statname === var_a0345f37.w_damage.statname) {
    if(var_bbfa9bda.weapon_item.var_96c71057 === 1) {
      e_attacker zm_stats::increment_challenge_stat(#"hash_65d7028060285fa0");
    }

    if(var_bbfa9bda.weapon_item.var_a0cc02cf === 1) {
      e_attacker zm_stats::increment_challenge_stat(#"hash_53222585ac81741a");
    }
  }

  if(!e_attacker zm_powerups::is_insta_kill_active() && !e_attacker zm_powerups::function_a4e210c7()) {
    if(!isDefined(e_attacker.var_bd019bbf)) {
      e_attacker.var_bd019bbf = 1;
    } else {
      e_attacker.var_bd019bbf++;
    }
  }

  if(e_attacker.var_bd019bbf === 20) {
    e_attacker.var_bd019bbf = 0;
    level scoreevents::doscoreeventcallback("scoreEventZM", {
      #attacker: e_attacker, #scoreevent: "killstreak_without_getting_hit_zm"});
    e_attacker contracts::increment_zm_contract(#"hash_27c82052a38b443a");
    e_attacker zm_stats::function_17ee4529(#"hash_7e82640bedc5ea04", 1, #"hash_5c49df97f4f82e12");
    e_attacker zm_stats::function_fbce465a(#"hash_76bf5bf08a08dab1");
    e_attacker zm_stats::function_fbce465a(#"hash_3a26c4202d86ea27");
    e_attacker zm_stats::function_fbce465a(#"hash_7208e1149645391b");

    if(zm_utility::is_survival() && level flag::get("objective_locked")) {
      e_attacker zm_stats::increment_challenge_stat(#"hash_ee7b7bd94593585");
    }
  }

  e_attacker debug_print("<dev string:x113>");

  e_attacker zm_stats::increment_challenge_stat(#"kill_enemies", undefined, 1);
  e_attacker zm_stats::function_c0c6ab19(#"kills");
  e_attacker contracts::function_dff4c02f();
  str_damagemod = var_a0345f37.str_damagemod;
  w_damage = var_a0345f37.w_damage;
  var_7050de53 = w_damage.inventorytype;

  if(isvehicle(e_inflictor)) {
    if(str_damagemod === "MOD_EXPLOSIVE" || str_damagemod === "MOD_UNKNOWN") {
      e_attacker zm_stats::increment_challenge_stat(#"hash_1a9d6b83204c7c28");
    } else if(str_damagemod === "MOD_CRUSH") {
      if(var_a0345f37.zm_ai_category === # "special" || var_a0345f37.zm_ai_category === # "elite") {
        e_attacker zm_stats::increment_challenge_stat(#"hash_7e4b300f1e1f2274");
      }

      e_attacker stats::function_dad108fa(#"hash_e822c99f16c5e3a", 1);
    }
  }

  if(is_true(e_attacker.var_96971e3c) && is_true(var_a0345f37.var_6e9934ba)) {
    e_attacker zm_stats::increment_challenge_stat(#"hash_5637dbe66b1e3feb");
  }

  if(str_damagemod !== "MOD_MELEE" && isDefined(w_damage.inventorytype) && w_damage != level.weaponnone) {
    switch (w_damage.inventorytype) {
      case # "dwlefthand":
        w_damage = w_damage.dualwieldweapon;
        e_attacker contracts::increment_zm_contract(#"hash_28124610d29236d9");
        e_attacker stats::function_dad108fa(#"hash_c564d52a7c51ad4", 1);
        break;
      case # "primary":
        if(!e_attacker playerads()) {
          e_attacker contracts::increment_zm_contract(#"hash_28124610d29236d9");
          e_attacker stats::function_dad108fa(#"hash_c564d52a7c51ad4", 1);
        } else if(e_attacker playerads() > 0) {
          e_attacker contracts::increment_zm_contract(#"hash_c5107c9ab542cc8");
        }

        break;
    }
  }

  w_damage = zm_weapons::get_nonalternate_weapon(w_damage);
  e_attacker function_d6b32ad3(w_damage, #"hash_49b586d05aaa0209", 1);

  if(isDefined(var_a0345f37.zm_ai_category)) {
    switch (var_a0345f37.zm_ai_category) {
      case # "special":

        e_attacker debug_print("<dev string:x139>");

        e_attacker zm_stats::increment_challenge_stat(#"heavy_kills");
        e_attacker function_d6b32ad3(w_damage, #"specialkills", 1);
        e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"specialkills", #"statvalue", 1);
        e_attacker thread activecamo::function_896ac347(w_damage, #"special_kills", 1);
        e_attacker thread activecamo::function_896ac347(w_damage, #"hash_39ab7cda18fd5c74", 1);
        e_attacker contracts::increment_zm_contract(#"contract_zm_special_kills");

        if(var_a0345f37.archetype === # "raz" && var_a0345f37.str_damagemod === "MOD_MELEE") {
          e_attacker zm_stats::increment_challenge_stat(#"hash_7df91106483d60b6");
        }

        if(var_947d01ee === "melee") {
          e_attacker stats::function_d0de7686(#"hash_5939a7f27c84412c", 1, #"hash_2b6ca84b97ab9928");
        }

        pack_level = e_attacker zm_pap_util::function_2a196eff(w_damage);

        if(var_947d01ee === "special" && isDefined(pack_level) && pack_level >= 2) {
          e_attacker stats::function_d0de7686(#"hash_1f1e05ecdb4321ff", 1, #"hash_3be00484d9ce9a63");
        }

        break;
      case # "elite":

        e_attacker debug_print("<dev string:x160>");

        e_attacker zm_stats::increment_challenge_stat(#"mini_boss_kills");
        e_attacker function_d6b32ad3(w_damage, #"hash_20806ac72acd7d15", 1);
        e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"hash_20806ac72acd7d15", #"statvalue", 1);
        e_attacker thread activecamo::function_896ac347(w_damage, #"hash_45814ac55657fc62", 1);
        e_attacker thread activecamo::function_896ac347(w_damage, #"hash_39ab7cda18fd5c74", 1);
        e_attacker contracts::increment_zm_contract(#"hash_1bbcbc1ef268d554");
        break;
      case # "normal":

        e_attacker debug_print("<dev string:x185>");

        e_attacker function_d6b32ad3(w_damage, #"verminkills", 1);
        e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"verminkills", #"statvalue", 1);
        e_attacker thread activecamo::function_896ac347(w_damage, #"vermin_kills", 1);
        e_attacker thread activecamo::function_896ac347(w_damage, #"hash_39ab7cda18fd5c74", 1);
        e_attacker contracts::increment_zm_contract(#"contract_zm_vermin_kills");
        break;
    }
  }

  if(killstreaks::is_killstreak_weapon(w_damage)) {
    e_attacker stats::function_b04e7184(w_damage.statname, #"best_kills");
    e_attacker stats::function_dad108fa(#"hash_195bc77f835411ca", 1);
    e_attacker stats::function_dad108fa(#"hash_453743f534bcb9db", 1);

    if(isDefined(weapon_item) && isDefined(e_attacker.var_636887e6) && isinarray(e_attacker.var_636887e6, weapon_item.id)) {
      e_attacker stats::function_dad108fa(#"hash_2ab68853897a8d0c", 1);
    }

    e_attacker contracts::increment_zm_contract(#"hash_4f513a02494984c0");

    switch (w_damage.statname) {
      case # "chopper_gunner":
        e_attacker zm_stats::increment_challenge_stat(#"hash_77814b03edd946bc");
        e_attacker contracts::increment_zm_contract(#"hash_1118222f042b742b");

        if(is_true(e_attacker.v_train_inbound_igc)) {
          e_attacker zm_stats::increment_challenge_stat(#"hash_78260b4431f8764e");
        }

        break;
      case # "ultimate_turret":
        e_attacker contracts::increment_zm_contract(#"hash_7da8d70743cddefa");
        break;
      case # "hero_pineapplegun":
        e_attacker contracts::increment_zm_contract(#"hash_4b9ddec4f59f76a3");
        e_attacker stats::function_dad108fa(#"hash_59685457ec89f211", 1);
        break;
      case # "sig_bow_flame":
        e_attacker contracts::increment_zm_contract(#"hash_3c3eaa7321a4911c");
        e_attacker zm_stats::function_7ec42fbf(#"hash_42ad6596af9cd4d");
        break;
      case # "napalm_strike":
        e_attacker contracts::increment_zm_contract(#"hash_4074b35d03a96348");
        e_attacker stats::function_dad108fa(#"hash_3822203fc7c2eadf", 1);
        break;
      case # "sig_lmg":
        e_attacker zm_stats::increment_challenge_stat(#"hash_681c57e8ca4bcdf3");
        e_attacker contracts::increment_zm_contract(#"hash_3172e810ab23f874");
        break;
      case # "hero_annihilator":
        e_attacker zm_stats::function_7ec42fbf(#"hash_aaa9c900cdfefaa");
        e_attacker contracts::increment_zm_contract(#"hash_6604da9088edc06f");

        if(var_a0345f37.zm_ai_category === # "elite") {
          e_attacker zm_stats::increment_challenge_stat(#"hash_679d2a2e1b786309");
        }

        break;
      case # "recon_car":
        e_attacker zm_stats::function_7ec42fbf(#"hash_518010f809e66024");
        e_attacker zm_stats::increment_challenge_stat(#"hash_4801eab040b132f5");
        break;
      case # "remote_missile":
      case # "remote_missile_bomblet":
      case # "remote_missile_missile":
        e_attacker contracts::increment_zm_contract(#"hash_1e485aae5e2dc011");
        break;
      case # "planemortar":
        e_attacker contracts::increment_zm_contract(#"hash_1e52bb6a2fe54fa1");
        break;
      case # "hero_flamethrower":
        e_attacker contracts::increment_zm_contract(#"hash_534b79f1515cac46");

        if(var_a0345f37.zm_ai_category === # "special" || var_a0345f37.zm_ai_category === # "elite") {
          e_attacker zm_stats::increment_challenge_stat(#"hash_68a05283e6b947f6");
        }

        e_attacker zm_stats::function_7ec42fbf(#"hash_76b222292bb7ea6a");
        break;
    }

    switch (w_damage.statname) {
      case # "remote_missile":
      case # "chopper_gunner":
      case # "remote_missile_bomblet":
      case # "remote_missile_missile":
      case # "napalm_strike":
      case # "planemortar":
        e_attacker contracts::increment_zm_contract(#"hash_2dfb176e8015feff");
        break;
      case # "ultimate_turret":
      case # "sig_lmg":
      case # "hero_pineapplegun":
      case # "recon_car":
      case # "sig_bow_flame":
      case # "hero_flamethrower":
      case # "hero_annihilator":
        e_attacker contracts::increment_zm_contract(#"hash_34e11e6062de3146");
        break;
    }
  }

  if(var_a0345f37.is_headshot) {
    e_attacker debug_print("<dev string:x1ab>");

    e_attacker zm_stats::function_c0c6ab19(#"headshots");

    if(w_damage === e_attacker.var_2a62e678) {
      e_attacker debug_print("<dev string:x1d3>");

      e_attacker zm_stats::increment_challenge_stat(#"perk_mule_kick_kills");
    }

    if(isDefined(e_attacker.var_807f94d7) && e_attacker.var_807f94d7 > 0) {
      e_attacker debug_print("<dev string:x211>");

      e_attacker zm_stats::increment_challenge_stat(#"perk_stronghold_headshots");
    }
  }

  if(var_a0345f37.var_d3ed3a9b && isDefined(var_a0345f37.str_damagemod) && var_a0345f37.str_damagemod != "MOD_MELEE") {
    e_attacker contracts::increment_zm_contract(#"hash_40cd9410951215b8");
    e_attacker zm_stats::increment_challenge_stat(#"critical_finishers");
    e_attacker zm_stats::function_17ee4529(#"hash_4714f96a091995", 1, #"event_test_enabled");
    e_attacker function_d6b32ad3(w_damage, #"criticals", 1);

    if(isDefined(var_947d01ee)) {
      switch (var_947d01ee) {
        case # "ar":

          e_attacker debug_print("<dev string:x244>");

          e_attacker contracts::increment_zm_contract(#"hash_546c523756e9ac9d");
          break;
        case # "lmg":

          e_attacker debug_print("<dev string:x26f>");

          e_attacker contracts::increment_zm_contract(#"hash_2761852b694b4e58");
          break;
        case # "pistol":

          e_attacker debug_print("<dev string:x29b>");

          e_attacker contracts::increment_zm_contract(#"hash_2bbe9120c601cb3d");
          e_attacker stats::function_d0de7686(#"hash_5c77fb32f73c647d", 1, #"weapon_unlock_challenge_enabled_pm63");
          break;
        case # "shotgun":

          e_attacker debug_print("<dev string:x2ca>");

          e_attacker contracts::increment_zm_contract(#"hash_6607fdb1e8642de2");
          e_attacker zm_stats::increment_challenge_stat(#"hash_512344494f0da53e");
          break;
        case # "smg":

          e_attacker debug_print("<dev string:x2fa>");

          e_attacker contracts::increment_zm_contract(#"hash_1763727e117a0f19");
          break;
        case # "sniper":

          e_attacker debug_print("<dev string:x326>");

          e_attacker contracts::increment_zm_contract(#"hash_455135401bc3c771");
          break;
        case # "tr":

          e_attacker debug_print("<dev string:x355>");

          e_attacker contracts::increment_zm_contract(#"hash_2f8eabe9d1bd2ee8");
          break;
      }
    }
  }

  if(e_attacker.var_9cd2c51d.var_158e75d4 === # "eq_stimshot" && isDefined(e_attacker.var_9cd2c51d.var_63362b1e) && e_attacker.var_9cd2c51d.var_63362b1e > gettime() - 6500) {
    e_attacker contracts::increment_zm_contract(#"hash_1c456f43ac6ce890");
    e_attacker stats::function_622feb0d(#"eq_stimshot", #"hash_1bc3e0ea4bf67adf", 1);
    e_attacker stats::function_6fb0b113(#"eq_stimshot", #"hash_7612343d459539e4");
  }

  if(isDefined(e_attacker.var_9cd2c51d.var_3ca3137f) && e_attacker.var_9cd2c51d.var_3ca3137f > gettime() - 6500) {
    e_attacker stats::function_8fb23f94(#"self_revive", #"hash_1975d12a85c62fd6", 1);
    e_attacker stats::function_b04e7184(#"self_revive", #"hash_4af819397d9b896e");
  }

  if(str_damagemod === "MOD_MELEE") {
    e_attacker contracts::increment_zm_contract(#"hash_6945e246eaae0456");
    e_attacker zm_stats::increment_challenge_stat(#"melee_finishers");
    e_attacker zm_stats::function_17ee4529(#"hash_4711f96a09147c", 1, #"event_test_enabled");

    if(w_damage === level.weaponbasemeleeheld) {
      e_attacker zm_stats::increment_challenge_stat(#"hash_231ce4bb96dad98");
    }
  }

  if(str_damagemod !== "MOD_MELEE" && (str_damagemod === "MOD_GRENADE" || str_damagemod === "MOD_GRENADE_SPLASH" || str_damagemod === "MOD_EXPLOSIVE" || zm_weapons::is_explosive_weapon(w_damage) && w_damage.name !== "gun_ultimate_turret" || var_a0345f37.var_8126f3c8 === # "explosive")) {
    e_attacker debug_print("<dev string:x380>");

    e_attacker zm_stats::increment_challenge_stat(#"explosive_kills");
    e_attacker zm_stats::function_c0c6ab19(#"explosions");
    e_attacker contracts::increment_zm_contract(#"contract_zm_explosive_kills");
  }

  if(is_true(var_a0345f37.missinglegs)) {
    e_attacker debug_print("<dev string:x3a9>");

    e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_kill_crawler");
  }

  pack_level = e_attacker zm_pap_util::function_2a196eff(w_damage);

  if(e_attacker zm_pap_util::function_b81da3fd(w_damage)) {
    e_attacker debug_print("<dev string:x3d0>");

    e_attacker zm_stats::increment_challenge_stat(#"double_pap_kills", undefined, 1);
    e_attacker zm_stats::function_c0c6ab19(#"hash_5d3dce1c38a95835");
    e_attacker zm_stats::function_c0c6ab19(#"repacked_kills");
    e_attacker contracts::increment_zm_contract(#"contract_zm_packed_kills");
    w_stat = zm_weapons::get_base_weapon(w_damage);
    e_attacker zm_stats::increment_challenge_stat(#"pap_kills");
    e_attacker function_d6b32ad3(w_damage, #"packedkills", 1);
    e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"packedkills", #"statvalue", 1);
    e_attacker stats::function_561716e6(w_damage.statname, #"packed_kills", 1);

    if(var_947d01ee === "melee" && isDefined(pack_level) && pack_level >= 3) {
      e_attacker stats::function_d0de7686(#"hash_133973d140372afe", 1, "weapon_unlock_challenge_enabled_sledgehammer");
    }
  } else if(zm_weapons::is_weapon_upgraded(w_damage) || isDefined(pack_level) && pack_level > 0) {
    e_attacker debug_print("<dev string:x404>");

    e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_kill_packapunch");
    e_attacker zm_stats::increment_challenge_stat(#"pap_kills");
    e_attacker zm_stats::function_c0c6ab19(#"hash_5d3dce1c38a95835");
    e_attacker contracts::increment_zm_contract(#"contract_zm_packed_kills");
    w_stat = zm_weapons::get_base_weapon(w_damage);
    e_attacker function_d6b32ad3(w_stat, #"packedkills", 1);
    e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"packedkills", #"statvalue", 1);
    e_attacker stats::function_561716e6(w_damage.statname, #"packed_kills", 1);
  } else {
    w_stat = zm_weapons::function_386dacbc(w_damage);
  }

  if(zm_weapons::is_wonder_weapon(w_damage) || w_damage.statname === # "ray_gun") {
    e_attacker contracts::increment_zm_contract(#"hash_1db0aaefc2baceb4");
    e_attacker zm_stats::function_7ec42fbf(#"hash_4d5ecc0ade47e69b");
  }

  if(is_true(w_damage.isdualwield) && (str_damagemod === "MOD_PROJECTILE" || str_damagemod === "MOD_PISTOL_BULLET" || str_damagemod === "MOD_RIFLE_BULLET" || str_damagemod === "MOD_PROJECTILE_SPLASH")) {
    e_attacker zm_stats::increment_challenge_stat(#"hash_6e93bb5e8c2ba491");
  }

  if((var_74ca2ca1 === "purple" || var_74ca2ca1 === "orange") && (var_947d01ee === "special" || var_947d01ee === "melee")) {
    e_attacker stats::function_d0de7686(#"hash_57b95e90f6cbac0d", 1, #"hash_43f0f74bb67f952c");
  }

  if(!isDefined(e_attacker.var_4dd3d657)) {
    e_attacker.var_4dd3d657 = [];
  }

  if(isDefined(w_damage.name) && isDefined(e_attacker.var_4dd3d657[w_damage.name])) {
    e_attacker.var_4dd3d657[w_damage.name].var_6dac8bc5++;

    if(e_attacker.var_4dd3d657[w_damage.name].var_6dac8bc5 === 20 || e_attacker.var_4dd3d657[w_damage.name].var_6dac8bc5 === 30) {
      if(e_attacker.var_4dd3d657[w_damage.name].var_6dac8bc5 === 20) {
        e_attacker function_d6b32ad3(w_damage, #"hash_1f3b0d3bd9acb4a5", 1);

        if(var_947d01ee === "melee") {
          e_attacker stats::function_d0de7686(#"hash_f6d02bd887e8a67", 1, #"hash_24fa97d9f5305a82");
        }

        if(var_947d01ee !== "ar") {
          e_attacker.var_4dd3d657[w_damage.name].var_6dac8bc5 = 0;
        }
      } else if(var_947d01ee === "ar" && e_attacker.var_4dd3d657[w_damage.name].var_6dac8bc5 === 30) {
        e_attacker zm_stats::function_51c1448(#"hash_4975a47f10046ed", 1, #"hash_a5417e397f372f2", #"ar_slowhandling_t9");
        e_attacker.var_4dd3d657[w_damage.name].var_6dac8bc5 = 0;
      }
    }
  } else if(isDefined(w_damage.name)) {
    e_attacker.var_4dd3d657[w_damage.name] = {
      #weapon: w_damage, #var_6dac8bc5: 1
    };
  }

  if(isDefined(level.zombie_weapons[w_stat])) {
    switch (level.zombie_weapons[w_stat].weapon_classname) {
      case # "ar":

        e_attacker debug_print("<dev string:x431>");

        e_attacker zm_stats::increment_challenge_stat(#"ar_kills");
        e_attacker zm_stats::function_c0c6ab19(#"kills_ar");
        break;
      case # "lmg":

        e_attacker debug_print("<dev string:x453>");

        e_attacker zm_stats::increment_challenge_stat(#"lmg_kills");
        e_attacker zm_stats::function_c0c6ab19(#"kills_lmg");
        break;
      case # "pistol":

        e_attacker debug_print("<dev string:x476>");

        e_attacker zm_stats::increment_challenge_stat(#"pistol_kills");
        e_attacker zm_stats::function_c0c6ab19(#"kills_pistol");

        if(var_a0345f37.archetype === # "soa" && isarray(var_a0345f37.var_276a8013)) {
          function_1eaaceab(var_a0345f37.var_276a8013);

          if(var_a0345f37.var_276a8013.size >= 5) {
            e_attacker stats::function_d0de7686(#"hash_399e533eb62256f6", 1, #"hash_7a7208607a705d6d");
          }
        }

        break;
      case # "shotgun":

        e_attacker debug_print("<dev string:x49c>");

        e_attacker zm_stats::increment_challenge_stat(#"shotgun_kills");
        e_attacker zm_stats::function_c0c6ab19(#"kills_shotguns");
        break;
      case # "smg":

        e_attacker debug_print("<dev string:x4c3>");

        e_attacker zm_stats::increment_challenge_stat(#"smg_kills");
        e_attacker zm_stats::function_c0c6ab19(#"kills_smg");
        break;
      case # "sniper":

        e_attacker debug_print("<dev string:x4e6>");

        e_attacker zm_stats::increment_challenge_stat(#"sniper_kills");
        e_attacker zm_stats::function_c0c6ab19(#"hash_2333d2f2b7271a56");

        if(var_a0345f37.archetype === # "raz" && !is_true(var_a0345f37.var_5c09e990)) {
          e_attacker stats::function_d0de7686(#"hash_637627fb0019084", 1, #"hash_699bb6cd0eb6fe01");
        }

        break;
      case # "tr":

        e_attacker debug_print("<dev string:x50c>");

        e_attacker zm_stats::increment_challenge_stat(#"tr_kills");
        e_attacker zm_stats::function_c0c6ab19(#"hash_26d8f2fa0846a614");
        break;
      case # "melee":
        e_attacker zm_stats::increment_challenge_stat(#"hash_28d06d169d6df927");

        if(e_attacker zm_powerups::is_insta_kill_active()) {
          e_attacker zm_stats::function_51c1448(#"hash_7cb905c409de3ce8", 1, #"hash_4abd131971e6f7a7", #"melee_scythe_t9");
        }

        break;
    }
  }

  if(is_true(e_attacker.var_b895a3ff)) {
    e_attacker zm_stats::increment_challenge_stat(#"hash_588caccb5ea9a399");
  }

  if(isDefined(w_damage.name)) {
    switch (w_damage.name) {
      case # "hatchet":
        e_attacker contracts::increment_zm_contract(#"hash_2bdb36192dc0c35b");

        if(distancesquared(var_a0345f37.origin, e_attacker.origin) > 448900) {
          e_attacker contracts::increment_zm_contract(#"hash_47e4a8a9710c8504");
        }

        break;
      case # "frag_grenade":
        e_attacker contracts::increment_zm_contract(#"hash_404c66f0c2116811");
        break;
      case # "eq_sticky_grenade":
        e_attacker contracts::increment_zm_contract(#"hash_5020d12306499cbd");
        break;
      case # "satchel_charge":
        e_attacker contracts::increment_zm_contract(#"hash_7e171b76ec0c1c42");
        break;
      case # "cymbal_monkey":
        e_attacker contracts::increment_zm_contract(#"hash_2840c9eff7d8c449");
        break;
      case # "molotov_fire":
        e_attacker zm_stats::increment_challenge_stat(#"hash_3f2b5f5f5c66ddd3");
        e_attacker contracts::increment_zm_contract(#"hash_4000032e74ffc77d");
        break;
      case # "eq_slow_grenade":
        e_attacker contracts::increment_zm_contract(#"hash_4936408b808baff1");
        break;
      case # "hash_6a4dd5ed56f6e3f6":
        e_attacker zm_stats::function_7ec42fbf(#"hash_768adb0a89648a89");
        break;
    }

    switch (w_damage.name) {
      case # "molotov_fire":
      case # "frag_grenade":
      case # "hatchet":
      case # "eq_sticky_grenade":
      case # "eq_slow_grenade":
      case # "satchel_charge":
      case # "cymbal_monkey":
        e_attacker contracts::increment_zm_contract(#"hash_2eebe80848be398");
        break;
      case # "toxic_growth":
      case # "toxic_growth_5":
      case # "toxic_growth_4":
      case # "toxic_growth_3":
      case # "toxic_growth_2":
      case # "toxic_growth_1":
        e_attacker contracts::increment_zm_contract(#"hash_1d79330297e3f68b");
        break;
      case # "lightning_links":
      case # "lightning_links_1":
      case # "lightning_links_2":
      case # "lightning_links_3":
      case # "lightning_links_4":
      case # "lightning_links_5":
        e_attacker contracts::increment_zm_contract(#"hash_1d79330297e3f68b");
        e_attacker zm_stats::increment_challenge_stat(#"hash_7c5dfd9a8b4b34e");
        e_attacker zm_stats::function_7ec42fbf(#"hash_2d451e3bdc5fc297", 1);
        break;
      case # "energy_mine":
      case # "energy_mine_4":
      case # "energy_mine_5":
      case # "energy_mine_2":
      case # "energy_mine_3":
      case # "energy_mine_1":
      case # "hash_7e4053e6965bafa7":
        e_attacker contracts::increment_zm_contract(#"hash_1d79330297e3f68b");
        e_attacker stats::function_622feb0d(#"energy_mine", #"kills", 1);
        e_attacker zm_stats::function_7ec42fbf(#"hash_79af8de54e6f5a0a");
        break;
      case # "frost_blast":
      case # "frost_blast_1":
      case # "frost_blast_3":
      case # "frost_blast_2":
      case # "frost_blast_5":
      case # "frost_blast_4":
        e_attacker contracts::increment_zm_contract(#"hash_1d79330297e3f68b");
        e_attacker stats::function_622feb0d(#"frost_blast", #"kills", 1);

        if(var_a0345f37.subarchetype === # "hash_28e36e7b7d5421f") {
          e_attacker zm_stats::increment_challenge_stat(#"hash_1f2e2a07900d9e2d");
        }

        break;
    }
  }

  if(var_a0345f37.subarchetype === # "hash_28e36e7b7d5421f" && is_true(var_a0345f37.var_1d8cde9) && level.contentmanager.activeobjective.content_script_name === "holdout") {
    e_attacker zm_stats::increment_challenge_stat(#"hash_3baee3fe30b6ea65");
  }

  if(w_damage.statname === # "bowie_knife") {
    e_attacker debug_print("<dev string:x52e>");

    e_attacker zm_stats::increment_challenge_stat(#"bowie_kills");
    return;
  }

  if(is_true(w_damage.var_ff0b00ba)) {
    e_attacker debug_print("<dev string:x559>");

    e_attacker zm_stats::function_c0c6ab19(#"kills_equipment");
    e_attacker contracts::increment_zm_contract(#"contract_zm_equip_kills");
  }

  if(zm_utility::is_frag_grenade(w_damage)) {
    e_attacker debug_print("<dev string:x582>");

    e_attacker zm_stats::increment_challenge_stat(#"frag_kills");
    return;
  }

  if(zm_utility::is_claymore(w_damage)) {
    e_attacker debug_print("<dev string:x5a6>");

    e_attacker zm_stats::increment_challenge_stat(#"claymore_kills");
    return;
  }

  if(zm_utility::is_mini_turret(w_damage, 1)) {
    e_attacker debug_print("<dev string:x5ce>");

    e_attacker zm_stats::increment_challenge_stat(#"sentry_kills");
    return;
  }

  if(zm_utility::function_b797694c(w_damage)) {
    e_attacker debug_print("<dev string:x5f9>");

    e_attacker zm_stats::increment_challenge_stat(#"acid_bomb_kills");
    return;
  }

  if(zm_utility::function_850e7499(w_damage, 1)) {
    e_attacker debug_print("<dev string:x622>");

    e_attacker zm_stats::increment_challenge_stat(#"wraith_fire_kills");
    return;
  }

  if(is_true(w_damage.isriotshield)) {
    e_attacker debug_print("<dev string:x64d>");

    e_attacker zm_stats::increment_challenge_stat(#"shield_kills");
    e_attacker contracts::increment_zm_contract(#"contract_zm_shield_kills");
    return;
  }

  if(zm_utility::is_player_valid(e_attacker, 0, 0)) {
    if(var_a0345f37.var_d1b39105 === 1 || var_a0345f37.var_8126f3c8 === # "electrical" || var_a0345f37.var_fc304017 === 1) {
      e_attacker zm_stats::increment_challenge_stat(#"electric_kills");
    }

    if(var_a0345f37.is_stunned) {
      e_attacker contracts::increment_zm_contract(#"hash_4075c12717a62ec7");
    }

    if(isDefined(var_a0345f37.enemy_override) || var_a0345f37.w_damage.name === # "cymbal_monkey") {
      e_attacker zm_stats::increment_challenge_stat(#"hash_132df2b4183bc9c8");
      e_attacker contracts::increment_zm_contract(#"hash_4c2b485a7927aadb");
    }

    if(var_a0345f37.var_2290a541 > 0 || isDefined(var_a0345f37.var_84e41b20) && var_a0345f37.var_84e41b20.size > 0 || isDefined(var_a0345f37.var_88421cc2) && var_a0345f37.var_88421cc2.size > 0 || var_a0345f37.var_8126f3c8 === # "fire") {
      if(var_a0345f37.var_2290a541 > 0 && var_a0345f37.w_damage.name !== # "hero_flamethrower" && var_a0345f37.w_damage.name !== # "sig_bow_flame") {
        e_attacker zm_stats::increment_challenge_stat(#"hash_585b66ad59f45eae");
      }

      e_attacker zm_stats::increment_challenge_stat(#"fire_kills");

      if(var_947d01ee === "smg") {
        e_attacker zm_stats::function_51c1448(#"hash_1cd482b5aaa76a63", 1, #"hash_3142d28c7a02bdf7", #"smg_accurate_t9");
      }
    }

    if(isDefined(var_a0345f37.var_cbf4894c) && var_a0345f37.var_cbf4894c > 1 || isDefined(var_a0345f37.var_d70e35fb) && var_a0345f37.var_d70e35fb > 1 || is_true(var_a0345f37.var_958cf9c5) || var_a0345f37.var_8126f3c8 === # "cold") {
      e_attacker zm_stats::increment_challenge_stat(#"frost_kills");
    }

    if(is_true(var_a0345f37.aat_turned)) {
      e_attacker zm_stats::increment_challenge_stat(#"hash_7fe169cf58d1d6ef");
    }

    if(var_947d01ee === "special") {
      if(isDefined(e_attacker.var_dbd7c18f)) {
        e_attacker.var_dbd7c18f++;

        if(e_attacker.var_dbd7c18f >= 25 && !is_true(e_attacker.var_e8bee75e)) {
          e_attacker.var_e8bee75e = 1;
        }
      }
    }
  }
}

function event_handler[grenade_stuck] function_5c5941ef(eventstruct) {
  grenade = eventstruct.projectile;

  if(!isDefined(grenade)) {
    return;
  }

  if(isai(eventstruct.hitent) && eventstruct.hitent.team === level.zombie_team && isPlayer(grenade.owner) && grenade.weapon.name === # "eq_sticky_grenade") {
    grenade.owner contracts::increment_zm_contract(#"hash_702ce12b92970cd6");
  }
}

function watchformantle() {
  self endon(#"disconnect", #"death", #"killmantlemonitor");
  self.mantletime = 0;

  while(true) {
    if(self ismantling()) {
      self.mantletime = gettime();
    }

    wait 0.1;
  }
}

function function_31de0f93() {
  self endon(#"disconnect", #"death");

  while(true) {
    self waittill(#"killstreak_equipped");
    weapon = self getinventoryweapon();

    if(killstreaks::is_killstreak_weapon(weapon)) {
      weaponslotid = self item_inventory::function_d768ea30();

      if(isDefined(weaponslotid)) {
        weapon_item = self.inventory.items[weaponslotid];

        if(isDefined(weapon.statname)) {
          if(!isDefined(weapon_item.var_be83192)) {
            switch (weapon.statname) {
              case # "remote_missile":
              case # "remote_missile_bomblet":
              case # "remote_missile_missile":
                self stats::function_8fb23f94(#"remote_missile_zm", #"uses", 1);
                break;
              default:
                self stats::function_8fb23f94(weapon.statname, #"uses", 1);
                break;
            }

            weapon_item.var_be83192 = 1;
          }
        }
      }
    }
  }
}

function function_575c37e0(weapon, enemy) {
  self contracts::increment_zm_contract(#"hash_4a67f445fabbabb4");

  if(self zm_powerups::is_insta_kill_active() || self zm_powerups::function_a4e210c7()) {
    self contracts::increment_zm_contract(#"hash_28d69ecb1123398b");
  }

  if(self killstreakrules::function_2912fa8()) {
    self zm_stats::increment_challenge_stat(#"hash_158beead6820875f");
  }

  if(isDefined(self.mantletime) && self.mantletime > gettime() - 2000) {
    self zm_stats::increment_challenge_stat(#"hash_7c8f5be8bd9ffa06");
  }

  if(self namespace_e86ffa8::function_cb561923(0)) {
    self zm_stats::function_7ec42fbf(#"hash_4124fad6c16b36d3");
  }

  if(is_true(self clientfield::is_registered("" + # "hash_63af42145e260fb5"))) {
    var_19f4406e = self clientfield::get("" + # "hash_63af42145e260fb5");

    if(var_19f4406e === 1) {
      self zm_stats::increment_challenge_stat(#"hash_4184958c0a55d46f");
    }
  }

  weaponslotid = self item_inventory::function_d768ea30();

  if(isDefined(weaponslotid)) {
    weapon_item = self.inventory.items[weaponslotid];

    if(weapon_item.var_627c698b.statname === weapon.statname) {
      if(weapon_item.var_96c71057 === 1) {
        self contracts::increment_zm_contract(#"hash_39d1bb5abc4290a8");
        self stats::function_dad108fa(#"hash_2dd97472bfdc1750", 1);
      }

      if(weapon_item.var_a0cc02cf === 1) {
        self stats::function_dad108fa(#"hash_15e38ff835419f29", 1);
        self contracts::increment_zm_contract(#"hash_74f9ee275506c72a");
      }

      if(is_true(weapon_item.var_b3546c09)) {
        self stats::function_dad108fa(#"hash_70a2e253d4eafa89", 1);
      }
    }

    if(isDefined(weapon_item.itementry.rarity) && !killstreaks::is_killstreak_weapon(weapon)) {
      var_74ca2ca1 = zm_weapons::function_137f88c6(weapon_item.itementry.rarity);

      if(var_74ca2ca1 == "blue" || var_74ca2ca1 == "purple" || var_74ca2ca1 == "orange") {
        if(is_true(weapon_item.var_a0cc02cf)) {
          self zm_stats::function_7ec42fbf(#"hash_c602b888cc99522");
        }
      }

      if(var_74ca2ca1 === "orange" && isDefined(weapon_item.var_e91aba42) && weapon_item.var_e91aba42 !== 0) {
        if(is_true(weapon_item.var_a0cc02cf) || is_true(weapon_item.var_96c71057) || is_true(weapon_item.var_387e74f4) || is_true(weapon_item.var_d688ad29) || is_true(weapon_item.var_569199b9)) {
          self zm_stats::increment_challenge_stat(#"hash_3f7fe50fe83a3441");
        }
      }
    }

    if(isDefined(weapon_item.aat)) {
      self stats::function_dad108fa(#"hash_2291cc79d49e6296", 1);
    }
  }

  if(self isinvehicle()) {
    self zm_stats::function_945c7ce2(#"hash_4a2a695d0f0137d9", 1);
    self stats::function_dad108fa(#"hash_4de87f4ac352d31c", 1);
  }

  self zm_stats::function_945c7ce2(#"hash_49f1cf535b9700b2", 1);

  if(self namespace_e86ffa8::function_30a8ed81() && isDefined(weapon_item) && weapon_item === self.inventory.items[17 + 1 + 8 + 1 + 8 + 1]) {
    self zm_stats::increment_challenge_stat(#"hash_4264deaabcb7bb38");
    self zm_stats::function_7ec42fbf(#"hash_18b0754477746c0e");
  }

  if(is_true(enemy.var_c3e92aaf) || !is_false(enemy.var_c3e92aaf) && isDefined(self.origin[2]) && isDefined(enemy.origin[2]) && enemy.origin[2] - self.origin[2] >= 200) {
    self zm_stats::increment_challenge_stat(#"hash_2b4013f15361c880");
  }

  w_stat = zm_weapons::get_base_weapon(weapon);
  var_947d01ee = level.zombie_weapons[w_stat].weapon_classname;

  if(enemy.zm_ai_category === # "boss") {
    if(enemy.archetype === # "hulk") {
      self stats::function_dad108fa(#"hash_793cb36230ece12", 1);
      self zm_stats::increment_challenge_stat(#"hash_7b482d2a97abe802");
      self function_d6b32ad3(weapon, #"eliteeliminations", 3);
    }
  } else if(enemy.zm_ai_category === # "elite" && (!isDefined(enemy.var_e293f8ac) || isDefined(enemy.var_e293f8ac) && enemy.var_e293f8ac.size === 0)) {
    self zm_stats::function_945c7ce2(#"hash_5c79495cf16e0818", 1);
    self stats::function_dad108fa(#"hash_78b5865817a3c321", 1);
    self stats::function_dad108fa(#"hash_4c0d9457aef9aed2", 1);
    self contracts::increment_zm_contract(#"hash_6552527c7d6010fc");
    self zm_stats::function_17ee4529(#"hash_513bcc963a91d9ce", 1, #"hash_735ace6b22542a65");
    self zm_stats::function_17ee4529(#"hash_5a978e436e7428e", 1, #"hash_6abe83944d701459");

    if(enemy.archetype === # "mechz") {
      self zm_stats::increment_challenge_stat(#"hash_5dc6f030420d1d6b");
      self zm_stats::function_7ec42fbf(#"hash_5e9fbf4fb934f162");
    }

    if(enemy.archetype === # "abom") {
      self zm_stats::function_7ec42fbf(#"hash_4b723faebc6cb297");
    }

    if(is_true(weapon.islauncher) || var_947d01ee === "special") {
      self zm_stats::increment_challenge_stat(#"hash_2d811e79d85e0017");
    }
  } else if(enemy.zm_ai_category === # "special") {
    if(enemy.archetype === # "mimic") {
      self zm_stats::increment_challenge_stat(#"hash_81dfbfc52acbb4b");
    }

    self stats::function_dad108fa(#"hash_1aba6fb35597bd85", 1);
    self stats::function_dad108fa(#"hash_2f835612b65f4272", 1);
    self zm_stats::function_945c7ce2(#"hash_21e2f8fd18871114", 1);
    self contracts::increment_zm_contract(#"hash_7b3ac5b418ed167c");
    self zm_stats::function_17ee4529(#"hash_513bcc963a91d9ce", 1, #"hash_735ace6b22542a65");

    if(enemy.archetype === # "avogadro") {
      self zm_stats::function_7ec42fbf(#"hash_7fa0fb7abd1293d1");
    }

    if(var_947d01ee === "melee") {
      self zm_stats::function_7ec42fbf(#"hash_3c55e3e2a9134760", 1);
    }

    if(is_true(weapon.islauncher) || var_947d01ee === "special") {
      self zm_stats::increment_challenge_stat(#"hash_2d811e79d85e0017");
    }
  }

  if(enemy.archetype === # "zombie_dog") {
    self contracts::increment_zm_contract(#"hash_3819a71c22f9ec8f");
  }

  if(enemy.archetype === # "soa") {
    self zm_stats::function_7ec42fbf(#"hash_232f596c7bb640f4", 1);
  }

  pack_level = self zm_pap_util::function_2a196eff(weapon);

  if(zm_weapons::is_weapon_upgraded(weapon) || isDefined(pack_level) && pack_level > 0) {
    self contracts::increment_zm_contract(#"hash_453b44052f10aff9");
    self zm_stats::function_61e39bb6(#"hash_3171d9bb6e1519ac", 1);
    self stats::function_dad108fa(#"hash_48e4f004511eee67", 1);
  }

  self function_d6b32ad3(weapon, #"ekia", 1);
  self function_d6b32ad3(weapon, #"hash_14b7133a39a0456e", 1);

  if(w_stat.statname === # "ww_mega_barrel_fullauto_copycat_t9") {
    self zm_stats::increment_challenge_stat(#"hash_53751bfa0573d9b8");
  }

  if(isDefined(w_stat.name)) {
    switch (w_stat.name) {
      case # "hash_ac86d29509a8939":
      case # "ww_ray_rifle_t9":
        self zm_stats::increment_challenge_stat(#"hash_2b7368bb97d41c4f");
        break;
      case # "ww_ieu_acid_t9_upgraded_item_sr":
      case # "ww_ieu_gas_t9_upgraded_item_sr":
      case # "ww_ieu_shockwave_t9_upgraded_item_sr":
      case # "ww_ieu_shockwave_t9":
      case # "ww_ieu_electric_t9":
      case # "ww_ieu_acid_t9":
      case # "ww_ieu_electric_t9_upgraded_item_sr":
      case # "ww_ieu_gas_t9":
      case # "ww_ieu_plasma_t9":
      case # "ww_ieu_plasma_t9_upgraded_item_sr":
        self zm_stats::increment_challenge_stat(#"hash_31e51e924e57c83a");
        break;
      case # "frost_blast_1":
      case # "frost_blast_3":
      case # "frost_blast_2":
      case # "frost_blast_5":
      case # "frost_blast_4":
      case # "lightning_links_1":
      case # "lightning_links_2":
      case # "lightning_links_3":
      case # "lightning_links_4":
      case # "lightning_links_5":
      case # "ring_of_fire_5":
      case # "energy_mine":
      case # "energy_mine_4":
      case # "energy_mine_5":
      case # "energy_mine_2":
      case # "energy_mine_3":
      case # "energy_mine_1":
      case # "ring_of_fire_4":
      case # "toxic_growth":
      case # "ring_of_fire_3":
      case # "ring_of_fire_2":
      case # "ring_of_fire_1":
      case # "frost_blast":
      case # "lightning_links":
      case # "toxic_growth_5":
      case # "toxic_growth_4":
      case # "toxic_growth_3":
      case # "toxic_growth_2":
      case # "toxic_growth_1":
      case # "ring_of_fire":
      case # "hash_7e4053e6965bafa7":
        self stats::function_dad108fa(#"hash_1dbfc19533279bd1", 1);
        break;
    }
  }

  if(isDefined(level.zombie_weapons[w_stat])) {
    switch (level.zombie_weapons[w_stat].weapon_classname) {
      case # "ar":

        self debug_print("<dev string:x431>");

        self contracts::increment_zm_contract(#"hash_2df3c0a3d246a317");
        var_74ca2ca1 = zm_weapons::function_137f88c6(weapon_item.itementry.rarity);

        if(var_74ca2ca1 == "purple" || var_74ca2ca1 == "orange") {
          self zm_stats::function_51c1448(#"hash_9d8677f2b8f6e88", 1, #"hash_a64dff1bf2a2551", #"ar_british_t9");
        }

        if(isDefined(pack_level) && pack_level > 2) {
          self zm_stats::function_51c1448(#"hash_153b001a46288fe6", 1, #"hash_a2304f8a8f31a95", #"ar_soviet_t9");
        }

        break;
      case # "lmg":

        self debug_print("<dev string:x453>");

        self contracts::increment_zm_contract(#"hash_7f2d55373edd6bd4");
        self stats::function_dad108fa(#"hash_3b13dc0e3c4bb2a2", 1);
        break;
      case # "pistol":

        self debug_print("<dev string:x476>");

        self contracts::increment_zm_contract(#"hash_3af737750c46d537");
        break;
      case # "shotgun":

        self debug_print("<dev string:x49c>");

        self contracts::increment_zm_contract(#"hash_2d89237bb56740aa");
        break;
      case # "smg":

        self debug_print("<dev string:x4c3>");

        self contracts::increment_zm_contract(#"hash_286a3c0a06a25f63");

        if(isarray(self.var_7341f980) && self.var_7341f980.size >= 5) {
          self zm_stats::function_51c1448(#"hash_23fe7ee198149ca7", 1, #"hash_321f62b43e5e631b", #"smg_fastfire_t9");
        }

        if(enemy.zm_ai_category === # "elite") {
          self zm_stats::function_51c1448(#"hash_4633cd5d032f64ee", 1, #"hash_6d5c2b4b0c5834bc", #"smg_semiauto_t9");
        }

        if(var_74ca2ca1 === "purple" || var_74ca2ca1 === "orange") {
          self zm_stats::function_51c1448(#"hash_49ee01ddb38e868e", 1, #"hash_2b4649f1d1493b64", #"smg_flechette_t9");
        }

        break;
      case # "sniper":

        self debug_print("<dev string:x4e6>");

        self contracts::increment_zm_contract(#"hash_65ca61d61094915b");
        self zm_stats::increment_challenge_stat(#"hash_78334d9117ca1925");
        break;
      case # "tr":

        self debug_print("<dev string:x50c>");

        self contracts::increment_zm_contract(#"hash_113a972fef98964");
        self zm_stats::increment_challenge_stat(#"hash_34f8fe4251de7f39");
        break;
    }
  }

  if(isPlayer(self) && isweapon(weapon)) {
    weapon_item = item_inventory::function_230ceec4(weapon);
  }

  if(isDefined(weapon_item) && isDefined(weapon_item.paplv) && weapon_item.itementry.rarity === # "ultra") {
    self zm_stats::increment_challenge_stat(#"hash_264f73a843a3e379");
  }

  if(isPlayer(self)) {
    if(is_true(self.var_bd593810)) {
      self zm_stats::increment_challenge_stat(#"hash_7a4b90d85af21324");
    }

    if(isDefined(weapon.attachments) && weapon.attachments.size > 0 && is_true(weaponhasattachment(weapon, "ir")) && self playerads()) {
      self zm_stats::increment_challenge_stat(#"hash_1d2c3c200f429ec9");
    }

    if(isDefined(weapon)) {
      var_75de4d7b = self getweaponoptic(weapon);

      if(var_75de4d7b != "") {
        var_e85becb3 = function_2edf4eec(weapon);

        if(var_e85becb3 > 1.9) {
          self zm_stats::increment_challenge_stat(#"hash_7c268f858b56322e");
        }
      }
    }

    if(is_true(self.var_b1164fd0)) {
      self stats::function_dad108fa(#"hash_7571a5aebc58c0df", 1);
    }

    if(var_947d01ee === "special") {
      self stats::function_dad108fa(#"hash_3c1a94bb292d8e96", 1);
    }

    if(is_true(enemy.var_4439c2d9)) {
      self stats::function_dad108fa(#"hash_38a132ff33294724", 1);
    }

    if(is_true(weapon_item.var_387e74f4)) {
      self contracts::increment_zm_contract(#"hash_7482a2b3f02b97af");
    }
  }

  if(isDefined(weapon) && (enemy.zm_ai_category === # "special" || enemy.zm_ai_category === # "elite") && (weapon.statname === # "smg_heavy_t9" || weapon.statname === # "ar_slowhandling_t9" || weapon.statname === # "lmg_light_t9")) {
    self zm_stats::function_fbce465a(#"hash_3d9159bfdb045054");
  }
}

function function_d6b32ad3(weapon, challenge, amount) {
  w_stat = zm_weapons::get_base_weapon(weapon);

  if(isDefined(w_stat) && isDefined(challenge)) {
    self stats::function_e24eec31(w_stat, challenge, amount);
  }
}

function function_4281b2f1(params) {
  self perk_tracker();
  item1 = self.inventory.items[17 + 1];
  var_ff082c28 = self.inventory.items[17 + 1 + 8 + 1];
  weapon1 = item_inventory_util::function_2b83d3ff(item1);
  weapon2 = item_inventory_util::function_2b83d3ff(var_ff082c28);

  if(isDefined(item1) && isDefined(weapon1) && isDefined(var_ff082c28) && isDefined(weapon2)) {
    if(item1.paplv === 3 && isDefined(item1.aat) && var_ff082c28.paplv === 3 && isDefined(var_ff082c28.aat)) {
      if(is_true(self.var_2121dbc7)) {
        self zm_stats::increment_challenge_stat(#"hash_6515936e245d91f6");
      }
    }
  }
}

function spent_points_tracking() {
  level endon(#"end_game");

  while(true) {
    result = level waittill(#"spent_points");
    player = result.player;
    n_points = result.points;
    player.var_152810ff[0] += n_points;

    player debug_print("<dev string:x673>");

    player zm_stats::increment_challenge_stat(#"points_spent", n_points, 1);
  }
}

function increment_magic_box() {
  self debug_print("<dev string:x699>");
}

function function_73696786() {
  self endon(#"disconnect");
  var_c0e0819a = 1;

  while(true) {
    s_result = self waittill(#"hash_13948ef3726b968f");

    if(is_true(var_c0e0819a)) {
      self debug_print("<dev string:x6c2>");

      self zm_stats::increment_challenge_stat(#"perks_full");
      var_c0e0819a = undefined;
    }

    self function_b892d1da();
  }
}

function function_5bec2304() {
  self endon(#"disconnect");

  if(namespace_cf6efd05::function_85b812c9()) {
    level flag::wait_till(#"initial_fade_in_complete");
  }

  self.var_bd0352a9 = [];
  self.var_c0e11f30 = {
    #time: gettime(), #count: 0
  };

  while(true) {
    s_result = self waittill(#"perk_acquired");

    if(self.var_c0e11f30.time > gettime() - 6000) {
      self.var_c0e11f30 = {
        #time: gettime(), #count: self.var_c0e11f30.count + 1
      };

      if(self.var_c0e11f30.count === 6) {
        self zm_stats::increment_challenge_stat(#"hash_60469384a8d07186");
      }
    } else {
      self.var_c0e11f30 = {
        #time: gettime(), #count: 1
      };
    }

    switch (s_result.var_16c042b8) {
      case # "hash_504b3df717f88c4e":
      case # "talent_quickrevive":
      case # "hash_504b41f717f8931a":
      case # "hash_504b40f717f89167":
      case # "hash_504b3ff717f88fb4":
      case # "hash_504b3ef717f88e01":
        self.var_bd0352a9[# "talent_quickrevive"] = 1;
        self stats::function_dad108fa("talent_quickrevive_drank", 1);
        break;
      case # "hash_520b59b0216b70be":
      case # "hash_520b5db0216b778a":
      case # "talent_speedcola":
      case # "hash_520b5ab0216b7271":
      case # "hash_520b5bb0216b7424":
      case # "hash_520b5cb0216b75d7":
        self.var_bd0352a9[# "talent_speedcola"] = 1;
        self stats::function_dad108fa("talent_speedcola_drank", 1);
        break;
      case # "hash_1f95b18e4a49da31":
      case # "talent_deadshot":
      case # "hash_1f95b28e4a49dbe4":
      case # "hash_1f95b38e4a49dd97":
      case # "hash_1f95b48e4a49df4a":
      case # "hash_1f95b08e4a49d87e":
        self.var_bd0352a9[# "talent_deadshot"] = 1;
        self stats::function_dad108fa("talent_deadshot_drank", 1);
        break;
      case # "talent_doubletap":
      case # "talent_doubletap":
      case # "talent_doubletap":
      case # "talent_doubletap":
      case # "talent_doubletap":
      case # "talent_doubletap":
        self.var_bd0352a9[# "talent_doubletap"] = 1;
        self stats::function_dad108fa("talent_doubletap_drank", 1);
        break;
      case # "hash_afdc57f440fb620":
      case # "hash_afdc67f440fb7d3":
      case # "hash_afdc97f440fbcec":
      case # "hash_afdcb7f440fc052":
      case # "hash_afdcc7f440fc205":
      case # "hash_47d7a8105237c88":
        self.var_bd0352a9[# "hash_47d7a8105237c88"] = 1;
        self stats::function_dad108fa("talent_juggernog_drank", 1);
        break;
      case # "hash_17ccbbee64daa20e":
      case # "hash_17ccbcee64daa3c1":
      case # "hash_17ccbdee64daa574":
      case # "hash_17ccbeee64daa727":
      case # "hash_17ccbaee64daa05b":
      case # "talent_staminup":
        self.var_bd0352a9[# "talent_staminup"] = 1;
        self stats::function_dad108fa("talent_staminup_drank", 1);
        break;
      case # "talent_elemental_pop":
      case # "talent_elemental_pop_2":
      case # "talent_elemental_pop_3":
      case # "talent_elemental_pop_1":
      case # "talent_elemental_pop_4":
      case # "talent_elemental_pop_5":
        self.var_bd0352a9[# "talent_elemental_pop"] = 1;
        self stats::function_dad108fa("talent_elemental_pop_drank", 1);
        break;
      case # "hash_38c08136902fd553":
      case # "hash_59dbe7f72baaa0f0":
      case # "hash_59dbe8f72baaa2a3":
      case # "hash_59dbecf72baaa96f":
      case # "hash_59dbedf72baaab22":
      case # "hash_59dbeef72baaacd5":
        self.var_bd0352a9[# "hash_38c08136902fd553"] = 1;
        self stats::function_dad108fa("talent_tombstone_drank", 1);
        break;
    }

    var_fff94a73 = self stats::get_stat_global("talent_elemental_pop_drank");
    var_317c380d = self stats::get_stat_global("talent_staminup_drank");
    var_a47cc4dd = self stats::get_stat_global("talent_juggernog_drank");
    var_325628d7 = self stats::get_stat_global("talent_doubletap_drank");
    var_32feae61 = self stats::get_stat_global("talent_deadshot_drank");
    var_6d1d99a3 = self stats::get_stat_global("talent_quickrevive_drank");
    var_1a8aaae7 = self stats::get_stat_global("talent_speedcola_drank");
    var_169c7afa = self stats::get_stat_global("talent_tombstone_drank");

    if(var_fff94a73 === 1 && self.var_bd0352a9[# "talent_elemental_pop"] === 1 || var_317c380d === 1 && self.var_bd0352a9[# "talent_staminup"] === 1 || var_a47cc4dd === 1 && self.var_bd0352a9[# "hash_47d7a8105237c88"] === 1 || var_325628d7 === 1 && self.var_bd0352a9[# "talent_doubletap"] === 1 || var_32feae61 === 1 && self.var_bd0352a9[# "talent_deadshot"] === 1 || var_6d1d99a3 === 1 && self.var_bd0352a9[# "talent_quickrevive"] === 1 || var_1a8aaae7 === 1 && self.var_bd0352a9[# "talent_speedcola"] === 1 || var_169c7afa === 1 && self.var_bd0352a9[# "hash_38c08136902fd553"] === 1) {
      self zm_stats::increment_challenge_stat(#"hash_39fd6dba5e5b592f");
    }

    self perk_tracker();
    self function_4281b2f1();
  }
}

function function_e365b5ab() {
  self endon(#"disconnect");

  while(true) {
    s_result = self waittill(#"aat_acquired");
    self.var_152810ff[6] = 0;
    self function_4281b2f1();
  }
}

function function_169107a0() {
  self endon(#"disconnect");

  while(true) {
    s_result = self waittill(#"hash_75ec9942d2d5fd0f");
    self.var_152810ff[6] = 0;
    self function_4281b2f1();
  }
}

function function_d61cb0eb() {
  self endon(#"disconnect");

  while(true) {
    s_result = level waittill(#"hash_159f5d1e1b511031");
    self.var_152810ff[6] = 0;

    if(s_result.player === self) {
      self thread function_70fb11de(3);
      weaponslotid = self item_inventory::function_d768ea30();

      if(!isDefined(weaponslotid)) {
        return;
      }

      weapon_item = self.inventory.items[weaponslotid];
      weapon_item.var_96c71057 = 1;
    }
  }
}

function function_b5df0b8b() {
  self endon(#"disconnect");

  while(true) {
    self waittill(#"hash_63344bbf1789e2c7");
    self thread function_70fb11de(6);

    if(isDefined(self.var_3a289354) && self.var_3a289354.size > 33) {
      self zm_stats::increment_challenge_stat(#"hash_4cd4e442cac88468");
    }
  }
}

function function_b3862180() {
  self endon(#"disconnect");
  function_5bce3615();
  self.var_55f98899 = [];

  while(true) {
    waitresult = self waittill(#"zone_change");

    if(is_true(level.var_92c52eed)) {
      if(!isDefined(self.var_55f98899)) {
        self.var_55f98899 = [];
      } else if(!isarray(self.var_55f98899)) {
        self.var_55f98899 = array(self.var_55f98899);
      }

      if(!isinarray(self.var_55f98899, waitresult.zone_name)) {
        self.var_55f98899[self.var_55f98899.size] = waitresult.zone_name;
      }

      if(self.var_55f98899.size === level.zones.size) {
        self zm_stats::increment_challenge_stat(#"hash_ec057f8bdec38d9");
      }

      continue;
    }

    if(is_true(level.var_ce7af4fa)) {
      if(waitresult.zone_name === "zone_bunny_room_1" || waitresult.zone_name === "zone_bunny_room_2") {
        level.var_d7ca0fe[# "hash_d002a29a2fe6e72"] = 1;
      } else {
        zone_name = [[level.var_27028b8e]](self zm_zonemgr::get_player_zone());

        if(isDefined(zone_name)) {
          level.var_d7ca0fe[zone_name] = 1;
        }
      }

      var_6e157233 = self function_3e8babbf(#"zm_gold");

      if(is_true(var_6e157233)) {
        return;
      }

      continue;
    }

    if(is_true(level.var_775a83a7)) {
      zone_name = [[level.var_27028b8e]](self zm_zonemgr::get_player_zone());

      if(isDefined(zone_name)) {
        level.var_d7ca0fe[zone_name] = 1;
      }

      var_6e157233 = self function_3e8babbf(#"zm_platinum");

      if(is_true(var_6e157233)) {
        return;
      }

      continue;
    }

    if(is_true(level.var_f937a06e)) {
      zone_name = [[level.var_27028b8e]](self zm_zonemgr::get_player_zone());

      if(isDefined(zone_name)) {
        level.var_d7ca0fe[zone_name] = 1;
      }

      var_6e157233 = self function_3e8babbf(#"zm_tungsten");

      if(is_true(var_6e157233)) {
        return;
      }
    }
  }
}

function function_3e8babbf(str_map_name) {
  assert(isDefined(str_map_name), "<dev string:x6f1>");

  if(str_map_name === # "zm_tungsten") {
    var_d3f0948b = # "hash_307ac432179b93ba";
  } else if(str_map_name === # "zm_platinum") {
    var_d3f0948b = # "hash_2e698f3f78ce7272";
  } else if(str_map_name === # "zm_gold") {
    var_d3f0948b = # "hash_38bef53143af72bc";
  }

  var_19a6f5c4 = 0;

  foreach(var_c93f7d90 in level.var_d7ca0fe) {
    if(is_true(var_c93f7d90)) {
      var_19a6f5c4++;
    }
  }

  if(var_19a6f5c4 === level.var_d7ca0fe.size) {
    self zm_stats::increment_challenge_stat(var_d3f0948b);
  }

  var_b6cbfb04 = self stats::get_stat(#"playerstatslist", var_d3f0948b, #"challengetier");

  if(isDefined(var_b6cbfb04) && var_b6cbfb04 > 0) {
    return true;
  }

  return false;
}

function function_5bce3615() {
  if(!isDefined(level.var_d7ca0fe)) {
    level.var_d7ca0fe = [];
  }

  foreach(zone in level.zones) {
    if(isDefined(level.var_27028b8e)) {
      if(zone.name === "zone_bunny_room_1" || zone.name === "zone_bunny_room_2") {
        level.var_d7ca0fe[# "hash_d002a29a2fe6e72"] = 0;
        continue;
      }

      zone_name = [[level.var_27028b8e]](zone.name);

      if(isDefined(zone_name)) {
        level.var_d7ca0fe[zone_name] = 0;
      }
    }
  }
}

function function_f6cfe355() {
  level endon(#"end_game");

  while(true) {
    level waittill(#"captured_control_point");
    var_6012e65d = 0;
    players = getplayers();

    foreach(player in players) {
      if(zm_utility::is_player_valid(player, 0, 1) && !zm_utility::function_c4b020f8()) {
        player zm_stats::increment_challenge_stat(#"hash_7a07b005bc08a081");
      }
    }

    foreach(control_point in level.var_cc43b632) {
      if(control_point.var_269ad176 === 2) {
        var_6012e65d++;
      }
    }

    if(var_6012e65d >= level.var_cc43b632.size) {
      foreach(player in players) {
        if(zm_utility::is_player_valid(player, 0, 1) && !zm_utility::function_c4b020f8()) {
          player zm_stats::increment_challenge_stat(#"hash_5235cb868a2e5bc1");
        }
      }

      return;
    }
  }
}

function function_4f4a3c59() {
  self endon(#"disconnect");

  while(true) {
    waitresult = self waittill(#"hash_18e59631bf777496");

    if(isDefined(waitresult.heal_amount) && waitresult.heal_amount > 0 && isDefined(self.var_9cd2c51d.var_43797ec0) && self.var_9cd2c51d.var_43797ec0.statname === # "eq_stimshot") {
      if(waitresult.heal_amount > 100) {
        self zm_stats::increment_challenge_stat(#"big_heals");
      }

      var_b9109e15 = self stats::function_97f7728e(#"eq_stimshot", #"hash_28be23967ca019c6");
      var_dfe20cae = self stats::function_97f7728e(#"eq_stimshot", #"uses");

      if(isDefined(var_b9109e15) && isDefined(var_dfe20cae) && var_dfe20cae > 0) {
        var_eb6c0e3f = (var_b9109e15 * var_dfe20cae + waitresult.heal_amount) / var_dfe20cae;
        var_7ed9a4d4 = int(var_eb6c0e3f);
        self stats::function_c8da9a88(#"eq_stimshot", #"hash_28be23967ca019c6", var_7ed9a4d4);
      } else {
        self stats::function_c8da9a88(#"eq_stimshot", #"hash_28be23967ca019c6", waitresult.heal_amount);
      }

      self contracts::increment_zm_contract(#"hash_5b8c91da65d60b4b", waitresult.heal_amount);
    }
  }
}

function function_874334a5() {
  self endon(#"disconnect");
  level flag::wait_till(#"main_quest_completed");
  players = getplayers();

  foreach(player in players) {
    if(!is_true(player.var_4a996ccb)) {
      player.var_4a996ccb = 1;

      if(is_true(level.var_92c52eed)) {
        player zm_stats::increment_challenge_stat(#"hash_45419091cdb5f154");
      } else if(is_true(level.var_ce7af4fa)) {
        player zm_stats::increment_challenge_stat(#"hash_139c5d1048195803");
      } else if(is_true(level.var_775a83a7)) {
        player zm_stats::increment_challenge_stat(#"hash_3e45baf53f91deb9");
      } else if(is_true(level.var_f937a06e)) {
        player zm_stats::increment_challenge_stat(#"hash_534c9832ce5fb8e1");
      }

      player function_c8cf642e();
    }
  }
}

function function_79deb4a0() {
  self endon(#"disconnect");

  while(true) {
    waitresult = level waittill(#"exfil_complete", #"hash_383cbd169f8d0938");

    if(waitresult.b_success === 1) {
      players = function_a1ef346b();

      foreach(player in players) {
        player function_c8cf642e();
      }
    }
  }
}

function function_c8cf642e() {
  player = self;

  if(isPlayer(player) && !is_true(player.var_b9ff264c)) {
    player.var_b9ff264c = 1;
    player zm_stats::increment_challenge_stat(#"hash_67429a304536459");
    player contracts::increment_zm_contract(#"hash_885ac2ac2e7c422");
    player zm_stats::function_fbce465a(#"hash_734f4d49f539ada");

    if(isDefined(player.var_204e6c25) && player.var_204e6c25 >= 2) {
      player zm_stats::function_17ee4529(#"hash_5a96fe436e73343", 1, #"hash_6abe83944d701459");
    }

    if(zm_utility::is_survival()) {
      if(zm_utility::function_e3025ca5() >= 5) {
        player zm_stats::increment_challenge_stat(#"hash_6a28c3c8320ac9a9");
      }

      var_3ba4bf7d = player getweaponslistprimaries();
      var_2a818961 = player zm_loadout::function_439b009a("primary");
      var_80a87db = player stats::get_stat(#"hash_2dd2a2b3580dd409", #"rarity_upgrade");

      if(zm_utility::function_e3025ca5() >= 3 && var_3ba4bf7d.size <= 2 && player hasweapon(var_2a818961) && player hasweapon(level.weaponbasemeleeheld) && var_80a87db == 0) {
        player zm_stats::increment_challenge_stat(#"hash_48f57ba1008a331f");
      }

      if(is_true(level.var_53bc31ad) && is_true(getgametypesetting(#"hash_4751990deae37e66"))) {
        player zm_stats::function_17ee4529(#"hash_513bcf963a91dee7", 1, #"hash_735ace6b22542a65");
      }
    }

    if(player.score >= 30000) {
      player zm_stats::increment_challenge_stat(#"hash_5670ae565826fea2");
    }

    if(level.round_number >= 31 && is_true(level.var_92c52eed)) {
      player zm_stats::increment_challenge_stat(#"hash_5be5c4c5dacd7bec");
    }

    if(is_true(level.var_775a83a7) && level.round_number >= 21) {
      player zm_stats::increment_challenge_stat(#"hash_67ed5d971276484f");
    }

    if(is_true(level.is_survival) && isDefined(level.var_b48509f9) && level.var_b48509f9 >= 10) {
      player zm_stats::increment_challenge_stat(#"hash_52d86f82675aaf1a");
    }

    player zm_stats::function_945c7ce2(#"hash_1e1cccf58903bfa8", 1);

    if(!is_true(player.var_8a246020)) {
      player.var_8a246020 = 1;
      player stats::function_dad108fa(#"hash_359f26f3fe7b3e34", 1);
      player stats::function_dad108fa(#"hash_6b9b36fedfb95f3c", 1);
      player stats::function_dad108fa(#"hash_e9b414f0e35b790", 1);
      player zm_stats::function_61e39bb6(#"hash_3c8e09a04082db5e", 1);
    }

    if(!isDefined(player.var_e394d7c0) || isDefined(player.var_e394d7c0) && player.var_e394d7c0 < level.round_number - 5) {
      return;
    }

    if(!isDefined(player.var_e7b05e99) && !is_true(player.var_18d824e4)) {
      player.var_18d824e4 = 1;
      player zm_stats::increment_challenge_stat(#"hash_6cf6b4ae9ac877b0");
    }
  }
}

function function_82383b3e() {
  self endon(#"disconnect");

  while(true) {
    self waittill(#"intel_collected");
  }
}

function function_12a35616() {
  self endon(#"disconnect");

  while(true) {
    waitresult = level waittill(#"blueprint_completed");

    if(isDefined(waitresult.produced) && is_true(waitresult.produced.isriotshield)) {
      self debug_print("<dev string:x731>");

      return;
    }
  }
}

function function_a9f6b8ef() {
  level endon(#"end_game");

  if(zm_custom::function_901b751c(#"zmpapenabled") == 2 || zm_custom::function_901b751c(#"zmpapenabled") == 0) {
    return;
  }

  if(is_true(level.var_775a83a7)) {
    level flag::wait_till(#"hash_20afa38b1f1c339e");

    foreach(player in getplayers()) {
      player zm_stats::increment_challenge_stat(#"hash_63e962bd4021d604");
    }

    return;
  }

  if(is_true(level.var_f937a06e)) {
    level flag::wait_till(#"hash_3814c5c6793e2b2d");

    foreach(player in getplayers()) {
      player zm_stats::increment_challenge_stat(#"hash_73bcca6cdadc5ddc");
    }
  }
}

function debug_print(str_line) {
  if(getdvarint(#"zombie_debug", 0) > 0) {
    println("<dev string:x75a>" + self.entity_num + "<dev string:x765>" + str_line);
  }
}

function on_challenge_complete(params) {
  n_challenge_index = params.challenge_index;

  if(is_challenge(n_challenge_index)) {}
}

function is_challenge(n_challenge_index) {
  return false;
}

function function_9a9ab6f6(var_1c48b665) {
  self zm_stats::increment_challenge_stat(var_1c48b665);

  foreach(var_6c7a7f72 in array(#"darkops_zod_ee", #"hash_6d5340d9e43ed73d", #"hash_ad3a508a80a0e6e")) {
    if(!self stats::get_stat_global(var_6c7a7f72)) {
      return;
    }
  }

  self debug_print("<dev string:x76b>");

  self zm_stats::increment_challenge_stat(#"hash_405387fd6efe78b3");
}

function private perk_tracker() {
  if(isarray(self.var_7341f980) && self.var_7341f980.size >= 6) {
    if(!is_true(self.var_2121dbc7)) {
      self contracts::increment_zm_contract(#"contract_zm_perks");
      self.var_2121dbc7 = 1;
    }
  }
}

function private function_b892d1da() {
  var_684d09cd = array(#"perk_juggernog", #"perk_quick_revive", #"perk_sleight_of_hand", #"perk_staminup", #"perk_dead_shot", #"perk_elemental_pop");

  foreach(var_9b9f4901 in var_684d09cd) {
    if(!self stats::get_stat(#"perk_stats", var_9b9f4901, #"modifier_given", #"statvalue")) {
      return;
    }
  }

  self debug_print("<dev string:x79b>");

  self zm_stats::increment_challenge_stat(#"hash_34f185c936027147", undefined, 1);
}

function function_bf0be8f1() {
  foreach(str_map in array("zm_zodt8", "zm_towers", "zm_escape")) {
    if(!self stats::get_stat(#"playerstatsbymap", str_map, #"statsbygametype", level.gametype, #"stats", "FASTEST_TIME_TO_COMPLETE_ROUND_30", #"statvalue")) {
      return;
    }
  }

  self debug_print("<dev string:x7d1>");

  self zm_stats::increment_challenge_stat(#"hash_c59a95e3be43538");
}

function function_e40c9d13() {
  var_b361a853 = array(#"ar_accurate_t8_upgraded", #"ar_damage_t8_upgraded", #"ar_fastfire_t8_upgraded", #"ar_mg1909_t8_upgraded", #"ar_modular_t8_upgraded", #"ar_stealth_t8_upgraded", #"launcher_standard_t8_upgraded", #"lmg_double_t8_upgraded", #"lmg_heavy_t8_upgraded", #"lmg_spray_t8_upgraded", #"lmg_standard_t8_upgraded", #"pistol_burst_t8_upgraded", #"pistol_revolver_t8_upgraded", #"pistol_standard_t8_upgraded", #"pistol_topbreak_t8_upgraded", #"shotgun_pump_t8_upgraded", #"shotgun_semiauto_t8_upgraded", #"shotgun_trenchgun_t8_upgraded", #"smg_accurate_t8_upgraded", #"smg_capacity_t8_upgraded", #"smg_drum_pistol_t8_upgraded", #"smg_fastfire_t8_upgraded", #"smg_handling_t8_upgraded", #"smg_standard_t8_upgraded", #"sniper_powerbolt_t8_upgraded", #"sniper_powersemi_t8_upgraded", #"sniper_quickscope_t8_upgraded", #"tr_leveraction_t8_upgraded", #"tr_longburst_t8_upgraded", #"tr_midburst_t8_upgraded", #"tr_powersemi_t8_upgraded");

  foreach(var_5f8b3585 in var_b361a853) {
    if(!self stats::get_stat(#"item_stats", var_5f8b3585, #"doublepacked", #"statvalue")) {
      return;
    }
  }

  self debug_print("<dev string:x804>");

  self zm_stats::increment_challenge_stat(#"hash_40d2ff74fd37a2ab", undefined, 1);
}

function t9_tu5_zm_hunter_mastery_fixup() {
  if(!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
    return;
  }

  var_845ac04e = self stats::get_stat_global("t9_tu5_zm_hunter_mastery_fixup");

  if(!isDefined(var_845ac04e)) {
    var_845ac04e = 0;
  }

  if(var_845ac04e != 1) {
    var_76f39460 = self stats::get_stat_challenge(#"zombie_hunter_mastery");

    if(!isDefined(var_76f39460)) {
      return;
    }

    var_2994e135 = self stats::get_stat(#"playerstatslist", #"trapper_kills", #"challengetier");

    if(!isDefined(var_2994e135)) {
      return;
    }

    var_99d0574f = self stats::get_stat(#"playerstatslist", #"hash_1ceaeed13ab4546b", #"challengetier");

    if(!isDefined(var_99d0574f)) {
      return;
    }

    var_c92e42cb = self stats::get_stat(#"playerstatslist", #"hash_45814ac55657fc62", #"challengetier");

    if(!isDefined(var_c92e42cb)) {
      return;
    }

    var_4d67e7b2 = self stats::get_stat(#"playerstatslist", #"hash_60594d8f8bc8764b", #"challengetier");

    if(!isDefined(var_4d67e7b2)) {
      return;
    }

    var_a391451e = self stats::get_stat(#"playerstatslist", #"hash_132df2b4183bc9c8", #"challengetier");

    if(!isDefined(var_a391451e)) {
      return;
    }

    var_1c2a202d = self stats::get_stat(#"playerstatslist", #"support_kills", #"challengetier");

    if(!isDefined(var_1c2a202d)) {
      return;
    }

    var_58b42ec7 = 0;

    if(var_2994e135 >= 3) {
      var_58b42ec7++;
    }

    if(var_99d0574f >= 3) {
      var_58b42ec7++;
    }

    if(var_c92e42cb >= 3) {
      var_58b42ec7++;
    }

    if(var_4d67e7b2 >= 3) {
      var_58b42ec7++;
    }

    if(var_a391451e >= 3) {
      var_58b42ec7++;
    }

    if(var_1c2a202d >= 1) {
      var_58b42ec7++;
    }

    if(var_58b42ec7 > var_76f39460 && var_1c2a202d >= 1) {
      self zm_stats::increment_challenge_stat(#"zombie_hunter_mastery", 1);
    }

    self stats::set_stat_global("t9_tu5_zm_hunter_mastery_fixup", 1);
  }
}

function function_4e5de0a2() {
  if(!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
    return;
  }

  var_d585ec85 = self stats::get_stat_global(#"hash_3eacfddc84997ba5");

  if(!is_true(var_d585ec85)) {
    self stats::set_stat_global(#"hash_3eacfddc84997ba5", 1);
    var_3c362b22 = 0;
    var_3c362b22 += self stats::function_97f7728e(#"hash_43e326396554e18c", #"uses");
    var_3c362b22 += self stats::function_97f7728e(#"hash_43e329396554e6a5", #"uses");
    var_3c362b22 += self stats::function_97f7728e(#"hash_43e328396554e4f2", #"uses");
    var_3c362b22 += self stats::function_97f7728e(#"hash_43e323396554dc73", #"uses");
    var_3c362b22 += self stats::function_97f7728e(#"hash_43e322396554dac0", #"uses");

    if(var_3c362b22 > 0) {
      self stats::function_622feb0d(#"hash_55569355da0f0f68", #"uses", var_3c362b22);
    }

    var_eb1fb63e = 0;
    var_eb1fb63e += self stats::function_97f7728e(#"toxic_growth_1", #"uses");
    var_eb1fb63e += self stats::function_97f7728e(#"toxic_growth_2", #"uses");
    var_eb1fb63e += self stats::function_97f7728e(#"toxic_growth_3", #"uses");
    var_eb1fb63e += self stats::function_97f7728e(#"toxic_growth_4", #"uses");
    var_eb1fb63e += self stats::function_97f7728e(#"toxic_growth_5", #"uses");

    if(var_eb1fb63e > 0) {
      self stats::function_622feb0d(#"toxic_growth", #"uses", var_eb1fb63e);
    }
  }
}

function private function_b15a1e1e(eventstruct) {
  self challenges::function_d43316bd(#"hash_1cba6f375b8ef307", eventstruct);
  self challenges::function_4e40694d(#"hash_1cba6f375b8ef307", eventstruct);
}

function private function_8c48d8ff(eventstruct) {
  self challenges::function_4e40694d(#"hash_1cba6f375b8ef307", eventstruct);
}

function private function_486d4ce3(eventstruct) {
  self challenges::function_4e40694d(#"hash_1cba6f375b8ef307", eventstruct);
}

function function_e71942eb() {
  level endon(#"end_game");
  waittillframeend();
  level flag::wait_till("all_players_spawned");
  players = getplayers();

  foreach(player in players) {
    player thread function_eb3f0817();
  }
}

function function_70fb11de(wait_time) {
  self endon(#"death", #"disconnect");
  level endon(#"end_game");

  if(isDefined(wait_time)) {
    wait wait_time;
  }

  primaryweapon = self item_inventory_util::function_2b83d3ff(self item_inventory::function_2e711614(17 + 1));
  secondaryweapon = self item_inventory_util::function_2b83d3ff(self item_inventory::function_2e711614(17 + 1 + 8 + 1));
  var_27d163f4 = self item_inventory_util::function_2b83d3ff(self item_inventory::function_2e711614(17 + 1 + 8 + 1 + 8 + 1));

  if(isDefined(primaryweapon)) {
    var_74d1fc7b = getbaseweaponitemindex(primaryweapon);

    if(isDefined(var_74d1fc7b)) {
      params = {};
      params.item_index = var_74d1fc7b;
      self challenges::function_4e40694d(#"hash_1cba6f375b8ef307", params);
    }
  }

  if(isDefined(secondaryweapon)) {
    var_f547d6d2 = getbaseweaponitemindex(secondaryweapon);

    if(isDefined(var_f547d6d2)) {
      params = {};
      params.item_index = var_f547d6d2;
      self challenges::function_4e40694d(#"hash_1cba6f375b8ef307", params);
    }
  }

  if(isDefined(var_27d163f4)) {
    var_6a1bdd09 = getbaseweaponitemindex(var_27d163f4);

    if(isDefined(var_6a1bdd09)) {
      params = {};
      params.item_index = var_6a1bdd09;
      self challenges::function_4e40694d(#"hash_1cba6f375b8ef307", params);
    }
  }
}

function function_eb3f0817() {
  self endon(#"death", #"disconnect");

  while(true) {
    self waittill(#"loadout_given");
    self thread function_70fb11de(3);
  }
}

function on_game_playing(params) {
  level flag::wait_till("initial_fade_in_complete");
  players = getplayers();

  foreach(player in players) {
    player thread function_1dd9fc03();
    player thread t9_tu5_zm_hunter_mastery_fixup();
    player thread function_4e5de0a2();

    if(getDvar(#"hash_570880cbdb22b9ac", 0) == 0) {
      player thread function_bc7f70a4();
    }

    player thread function_a51a383b();

    if(is_true(level.var_775a83a7)) {
      player thread zm_intel::function_a2579c2d(#"zm_platinum");
      continue;
    }

    if(is_true(level.var_ce7af4fa)) {
      player thread zm_intel::function_a2579c2d(#"zm_gold");
      continue;
    }

    if(is_true(level.var_92c52eed)) {
      player thread zm_intel::function_a2579c2d(#"zm_silver");
      continue;
    }

    if(is_true(level.var_f937a06e)) {
      player thread zm_intel::function_a2579c2d(#"zm_tungsten");
    }
  }
}

function function_a51a383b() {
  if(!level.onlinegame || is_true(level.zm_disable_recording_stats) || !isPlayer(self)) {
    return;
  }

  var_845ac04e = self stats::get_stat_global("t9_tu7_zm_omega_intel_challenge_fixedup");

  if(!isDefined(var_845ac04e)) {
    var_845ac04e = 0;
  }

  if(var_845ac04e != 1) {
    self stats::set_stat_global("t9_tu7_zm_omega_intel_challenge_fixedup", 1);
    var_64b5aa3d = self stats::get_stat(#"playerstatslist", #"hash_607cee7194682397", #"challengevalue");

    if(!isDefined(var_64b5aa3d)) {
      var_64b5aa3d = 0;
    }

    if(var_64b5aa3d >= 13) {
      self stats::set_stat(#"playerstatslist", #"hash_607cee7194682397", #"challengevalue", 12);
      self stats::inc_stat(#"playerstatslist", #"hash_607cee7194682397", #"challengevalue", 1);
    }
  }
}

function function_bc7f70a4() {
  if(!level.onlinegame || is_true(level.zm_disable_recording_stats) || !isPlayer(self)) {
    return;
  }

  var_845ac04e = self stats::get_stat_global("t9_tu7_zm_s1_mastery_fixedup");

  if(!isDefined(var_845ac04e)) {
    var_845ac04e = 0;
  }

  if(var_845ac04e != 1) {
    if(!stats::function_f94325d3()) {
      return 0;
    }

    self stats::set_stat_global("t9_tu7_zm_s1_mastery_fixedup", 1);
    var_71d636c6 = self stats::function_1bb1c57c(#"globalchallenges", #"hash_5dc4288a3e83811e", #"challengetier");

    if(!isDefined(var_71d636c6)) {
      var_71d636c6 = 0;
    }

    if(var_71d636c6 >= 1) {
      self function_dc7c4fb9(#"globalchallenges", #"hash_5dc4288a3e83811e", #"challengetier", 0);
      self function_dc7c4fb9(#"globalchallenges", #"hash_5dc4288a3e83811e", #"challengevalue", 19);
      self stats::function_dad108fa(#"hash_5dc4288a3e83811e", 1);
    }
  }
}

function function_dc7c4fb9(...) {
  assert(vararg.size > 1);

  if(vararg.size <= 1) {
    return 0;
  }

  if(!stats::function_f94325d3()) {
    return 0;
  }

  result = 0;

  if(isDefined(self)) {
    assert(isPlayer(self), "<dev string:x846>");
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    result = self writestat(2, vararg, value);

    stats::function_d92cb558(result, vararg);
  }

  return is_true(result);
}

function function_1dd9fc03() {
  if(!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
    return;
  }

  var_845ac04e = self stats::get_stat_global("t9_tu5_zm_dark_matter_fixedup");

  if(!isDefined(var_845ac04e)) {
    var_845ac04e = 0;
  }

  if(var_845ac04e != 1) {
    self stats::set_stat_global("t9_tu5_zm_dark_matter_fixedup", 1);
    weapon_names = [];
    weapon_names[# "weapon_tactical"] = [# "tr_damagesemi_t9", #"tr_longburst_t9", #"tr_powerburst_t9", #"tr_precisionsemi_t9"];
    weapon_names[# "weapon_smg"] = [# "smg_standard_t9", #"smg_heavy_t9", #"smg_handling_t9", #"smg_fastfire_t9", #"smg_capacity_t9", #"smg_burst_t9"];

    foreach(weapon in weapon_names[# "weapon_tactical"]) {
      var_79aea5cb = 0;
      var_d33334c3 = 0;
      var_782a947 = 0;
      var_45c0113e = 0;
      var_e0ce2c9f = 0;
      var_71709b6e = 0;
      var_daca47a6 = 0;
      var_b1d90f13 = self stats::get_stat(#"item_stats", weapon, #"kills", #"challengevalue");

      if(!isDefined(var_b1d90f13)) {
        continue;
      }

      var_79aea5cb = 0;

      if(var_b1d90f13 >= 50 && var_b1d90f13 < 250) {
        var_79aea5cb = 1;
      } else if(var_b1d90f13 >= 250 && var_b1d90f13 < 750) {
        var_79aea5cb = 2;
      } else if(var_b1d90f13 >= 750 && var_b1d90f13 < 1500) {
        var_79aea5cb = 3;
      } else if(var_b1d90f13 >= 1500 && var_b1d90f13 < 2500) {
        var_79aea5cb = 4;
      } else if(var_b1d90f13 >= 2500) {
        var_79aea5cb = 5;
      }

      var_531d02e6 = self stats::get_stat(#"item_stats", weapon, #"criticals", #"challengetier");

      if(!isDefined(var_531d02e6)) {
        continue;
      }

      var_6872fc45 = self stats::get_stat(#"item_stats", weapon, #"packedkills", #"challengetier");

      if(!isDefined(var_6872fc45)) {
        continue;
      }

      var_59a3dcb1 = self stats::get_stat(#"item_stats", weapon, #"eliteeliminations", #"challengetier");

      if(!isDefined(var_59a3dcb1)) {
        continue;
      }

      var_7bb2e982 = self stats::get_stat(#"item_stats", weapon, #"multikill", #"challengetier");

      if(!isDefined(var_7bb2e982)) {
        continue;
      }

      var_b72a7e87 = self stats::get_stat(#"item_stats", weapon, #"criticalmultikill", #"challengetier");

      if(!isDefined(var_b72a7e87)) {
        continue;
      }

      var_3657e2eb = self stats::get_stat(#"item_stats", weapon, #"hash_1f3b0d3bd9acb4a5", #"challengetier");

      if(!isDefined(var_3657e2eb)) {
        continue;
      }

      var_99543712 = self stats::get_stat(#"item_stats", weapon, #"challenges", #"challengevalue");

      if(!isDefined(var_99543712)) {
        continue;
      }

      expected_value = var_3657e2eb + var_b72a7e87 + var_7bb2e982 + var_59a3dcb1 + var_6872fc45 + var_531d02e6 + var_79aea5cb;

      if(isDefined(expected_value) && expected_value > var_99543712) {
        var_402b331b = getweapon(weapon);
        self function_d6b32ad3(var_402b331b, #"challenges", 1);
      }
    }

    if(isDefined(weapon_names[# "weapon_smg"])) {
      foreach(weapon in weapon_names[# "weapon_smg"]) {
        var_d4bdcb67 = self stats::get_stat(#"item_stats", weapon, #"challenges", #"challengevalue");

        if(!isDefined(var_d4bdcb67)) {
          continue;
        }

        if(var_d4bdcb67 >= 35) {
          var_d4ece5d0 = self stats::get_stat(#"item_stats", weapon, #"challenges_completed", #"challengevalue");

          if(!isDefined(var_d4ece5d0)) {
            continue;
          }

          if(var_d4ece5d0 == 0) {
            var_402b331b = getweapon(weapon);
            self function_d6b32ad3(var_402b331b, #"challenges_completed", 1);
          }
        }
      }
    }
  }
}

function function_ef2d2d4d() {
  self endon(#"death");
  var_a088f75f = 0;

  while(isPlayer(self)) {
    if(!self isonground()) {
      if(var_a088f75f) {
        self stats::function_dad108fa(#"hash_71fb6d66e0007d1d", 1);
      } else {
        var_a088f75f = 1;
      }
    } else {
      var_a088f75f = 0;
    }

    wait 1;
  }
}

function function_64a04e4a() {
  self endon(#"death", #"disconnect");

  while(isPlayer(self)) {
    if(!self isonground()) {
      var_577c82e7 = self.origin[2];
      var_e8ae4175 = 0;

      while(true) {
        if(self flag::get(#"hash_4e5451766f737d14") || self function_b4813488() || self isparachuting() || self laststand::player_is_in_laststand() || self scene::is_igc_active() || is_true(self.var_16735873)) {
          var_e8ae4175 = 0;

          while(!self isonground()) {
            waitframe(1);
          }

          break;
        }

        if(self isonground()) {
          var_e8ae4175 = 1;
          break;
        }

        if(self.origin[2] > var_577c82e7) {
          var_577c82e7 = self.origin[2];
        }

        waitframe(1);
      }

      if(var_e8ae4175) {
        var_3ce9b0ae = self.origin[2];
        var_af850774 = var_577c82e7 - var_3ce9b0ae;

        if(var_af850774 >= 2300) {
          self zm_stats::increment_challenge_stat(#"hash_6c3dae3eba6c9c0c");
        }
      }
    }

    waitframe(1);
  }
}