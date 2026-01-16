/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_602009d88d859543.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\zm\weapons\zm_weap_spectral_shield;
#include scripts\zm\zm_escape_vo_hooks;
#include scripts\zm\zm_escape_weap_quest;
#include scripts\zm_common\util\ai_brutus_util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;
#include scripts\zm_common\zm_zonemgr;

#namespace namespace_b99141ed;

init() {
  level.var_d0fafce1 = 1;
  level.var_829d6a97 = &function_b6a3df03;
  level.var_e9737821 = &function_c52e8ba;
  level.var_91171ae5 = &function_640bb879;
  level.var_352c9e03 = &function_47dec08f;
  level.var_1e47389a = &function_9afaebe9;
  level.var_8f8f85f5 = 1;

  if(level.var_8f8f85f5) {
    level.var_261ad4d[#"cafeteria_west_side"] = 0;
    level.var_261ad4d[#"warden_house_shower"] = 0;
  }

  level.var_dfd49265 = 1;
  level flag::init(#"hash_76a9f44aee68fe8e");
  level flag::init(#"hash_6a5df83b0716ed39");
  level flag::init(#"hash_107c5504e3325022");
  level.var_ce0f67cf = 31;
  level.var_a38d293a = 22;
}

init_clientfields() {
  clientfield::register("toplayer", "" + #"hash_275c4e6783b917f8", 1, 1, "int");
}

function_cdbbf1ee() {
  self.var_9c7b96ed = [];
}

function_b6a3df03() {
  var_501f80dc = self.unitrigger_stub.script_string;
  var_e84f96c4 = self.unitrigger_stub;

  switch (var_501f80dc) {
    case #"shower_to_warden_house":
    case #"warden_house_to_shower":
      self.unitrigger_stub.var_8d5d092c = "warden_house_shower";
      break;
    case #"cafeteria_to_west_side":
    case #"west_side_to_cafeteria":
      self.unitrigger_stub.var_8d5d092c = "cafeteria_west_side";
      break;
  }

  self.unitrigger_stub.var_67cba496 = struct::get("scene_" + var_501f80dc, "script_string");

  switch (var_501f80dc) {
    case #"warden_house_to_shower":
      var_e84f96c4.var_374f0c4e = struct::get("scene_shower_to_warden_house", "script_string");
      break;
    case #"shower_to_warden_house":
      var_e84f96c4.var_374f0c4e = struct::get("scene_warden_house_to_shower", "script_string");
      break;
    case #"west_side_to_cafeteria":
      var_e84f96c4.var_374f0c4e = struct::get("scene_cafeteria_to_west_side", "script_string");
      break;
    case #"cafeteria_to_west_side":
      var_e84f96c4.var_374f0c4e = struct::get("scene_west_side_to_cafeteria", "script_string");
      break;
  }
}

function_c52e8ba(player, var_8d5d092c) {
  if(!isDefined(self.hint_string)) {
    self.hint_string = [];
  }

  n_player_index = player getentitynumber();
  b_result = 0;

  if(isDefined(self.stub)) {
    str_loc = self.stub.script_string;
  }

  if(!zombie_utility::is_player_valid(player)) {
    self.hint_string[n_player_index] = #"";
  } else if(isDefined(player.var_16735873) && player.var_16735873 && self.stub.script_string !== "dropout") {
    self.hint_string[n_player_index] = #"";
    return 1;
  } else if(isDefined(player.var_564dec14) && player.var_564dec14) {
    self.hint_string[n_player_index] = #"";
  } else if(level flag::get(#"disable_fast_travel")) {
    self.hint_string[n_player_index] = #"";
  } else if(!level flag::get("power_on1")) {
    self.hint_string[n_player_index] = #"hash_1889aab1f9075530";
    self sethintstringforplayer(player, self.hint_string[n_player_index]);
    b_result = 1;
  } else if(isDefined(self.stub.var_a4134e51) && !level flag::get(self.stub.var_a4134e51)) {
    self.hint_string[n_player_index] = #"zombie/fasttravel_locked";
    b_result = 1;
  } else if(isDefined(player.var_9c7b96ed[var_8d5d092c]) && player.var_9c7b96ed[var_8d5d092c] || isDefined(level.var_8f8f85f5) && level.var_8f8f85f5 && isDefined(level.var_261ad4d[var_8d5d092c]) && level.var_261ad4d[var_8d5d092c]) {
    self.hint_string[n_player_index] = #"hash_7667bd0f83307360";
    self sethintstringforplayer(player, self.hint_string[n_player_index]);
    b_result = 1;
  } else {
    self.hint_string[n_player_index] = #"";
    b_result = 1;

    switch (str_loc) {
      case #"warden_house_to_shower":
        if(level flag::get(#"hash_76a9f44aee68fe8e") || zm_utility::is_standard()) {
          if(function_8b1a219a()) {
            self.hint_string[n_player_index] = #"hash_300b1d3d5ba4c0fe";
          } else {
            self.hint_string[n_player_index] = #"hash_3c4e15b133cbbbfa";
          }
        } else if(function_8b1a219a()) {
          self.hint_string[n_player_index] = #"hash_6f301212d8bab6f9";
        } else {
          self.hint_string[n_player_index] = #"hash_2110980a2c8a4dd3";
        }

        break;
      case #"shower_to_warden_house":
        if(level flag::get(#"hash_76a9f44aee68fe8e") || zm_utility::is_standard()) {
          if(function_8b1a219a()) {
            self.hint_string[n_player_index] = #"hash_2e77e87570b1c528";
          } else {
            self.hint_string[n_player_index] = #"hash_751feed02ba9abc4";
          }
        } else if(function_8b1a219a()) {
          self.hint_string[n_player_index] = #"hash_6bfcbf101ce05cc3";
        } else {
          self.hint_string[n_player_index] = #"hash_af863c29e30651d";
        }

        break;
      case #"cafeteria_to_west_side":
        if(level flag::get(#"hash_6a5df83b0716ed39") || zm_utility::is_standard()) {
          if(function_8b1a219a()) {
            self.hint_string[n_player_index] = #"hash_25fef648e85ea908";
          } else {
            self.hint_string[n_player_index] = #"hash_5bd2ed18b058d064";
          }
        } else if(function_8b1a219a()) {
          self.hint_string[n_player_index] = #"hash_706a38abf5bf863";
        } else {
          self.hint_string[n_player_index] = #"hash_1db3b05a63943f7d";
        }

        break;
      case #"west_side_to_cafeteria":
        if(level flag::get(#"hash_6a5df83b0716ed39") || zm_utility::is_standard()) {
          if(function_8b1a219a()) {
            self.hint_string[n_player_index] = #"hash_2465c3ca09a8650f";
          } else {
            self.hint_string[n_player_index] = #"hash_9fdf28b2277fe11";
          }
        } else if(function_8b1a219a()) {
          self.hint_string[n_player_index] = #"hash_31a8769c6599d292";
        } else {
          self.hint_string[n_player_index] = #"hash_3600e293ddc9f9b6";
        }

        break;
      default:
        self.hint_string[n_player_index] = #"hash_2731cc5c1208e2e4";
        break;
    }

    self sethintstringforplayer(player, self.hint_string[n_player_index]);
  }

  return b_result;
}

function_640bb879(e_unitrigger) {
  var_8d5d092c = e_unitrigger.stub.var_8d5d092c;
  var_d5376a79 = function_d7af842d(e_unitrigger);

  if(level flag::get(var_d5376a79)) {
    n_cost = 0;
  } else if(isDefined(e_unitrigger.stub)) {
    n_cost = e_unitrigger.stub.zombie_cost;
  } else {
    n_cost = e_unitrigger.zombie_cost;
  }

  return n_cost;
}

function_47dec08f(e_unitrigger) {
  var_8d5d092c = e_unitrigger.stub.var_8d5d092c;
  var_d5376a79 = function_d7af842d(e_unitrigger);
  n_player_index = self getentitynumber();

  if(!level flag::get(var_d5376a79)) {
    level thread function_429e121c(var_d5376a79, var_8d5d092c, e_unitrigger.stub.var_67cba496, e_unitrigger.stub.var_374f0c4e, self);
  }

  switch (e_unitrigger.hint_string[n_player_index]) {
    case #"hash_9fdf28b2277fe11":
    case #"hash_2465c3ca09a8650f":
    case #"hash_31a8769c6599d292":
    case #"hash_3600e293ddc9f9b6":
      if(!zm_zonemgr::zone_is_enabled("zone_cafeteria")) {
        zm_zonemgr::enable_zone("zone_cafeteria");
        zm_zonemgr::enable_zone("zone_cafeteria_end");
        level flag::set(#"hash_6059fbd4a3d1823e");
        level thread function_f789d6ed();
      }

      break;
    case #"hash_af863c29e30651d":
    case #"hash_2e77e87570b1c528":
    case #"hash_6bfcbf101ce05cc3":
    case #"hash_751feed02ba9abc4":
      if(!zm_zonemgr::zone_is_enabled("zone_warden_house")) {
        zm_zonemgr::enable_zone("zone_warden_house");
        zm_zonemgr::enable_zone("zone_warden_house_exterior");
        level flag::set(#"hash_6804675ac314efd1");
      }

      break;
    case #"hash_2110980a2c8a4dd3":
    case #"hash_300b1d3d5ba4c0fe":
    case #"hash_3c4e15b133cbbbfa":
    case #"hash_6f301212d8bab6f9":
      if(!zm_zonemgr::zone_is_enabled("cellblock_shower")) {
        zm_zonemgr::enable_zone("cellblock_shower");
      }

      break;
    case #"hash_706a38abf5bf863":
    case #"hash_1db3b05a63943f7d":
    case #"hash_25fef648e85ea908":
    case #"hash_5bd2ed18b058d064":
      if(!zm_zonemgr::zone_is_enabled("zone_new_industries") || !zm_zonemgr::zone_is_enabled("zone_new_industries_transverse_tunnel")) {
        zm_zonemgr::enable_zone("zone_new_industries");
        zm_zonemgr::enable_zone("zone_new_industries_transverse_tunnel");
        level flag::set(#"hash_2873d6b98dfeaf6d");
      }

      break;
  }

  self thread zm_escape_vo_hooks::function_818b85eb();
  self thread function_c179676a();
  self thread function_402d070f();
}

private function_f789d6ed() {
  level.var_8b4ac110 = 256;
  level.var_f49050a9 = level.dog_spawn_func;
  level.dog_spawn_func = &function_fa3bdfb7;
  level flag::wait_till_any(array("activate_cafeteria", "activate_infirmary"));
  level.var_8b4ac110 = undefined;
  level.dog_spawn_func = level.var_f49050a9;
  level.var_f49050a9 = undefined;
}

function_fa3bdfb7() {
  if(isarray(level.zm_loc_types[#"dog_location"])) {
    s_spawn_loc = array::random(level.zm_loc_types[#"dog_location"]);
  }

  return s_spawn_loc;
}

private function_c179676a() {
  self endon(#"disconnect");
  w_current = self getcurrentweapon();

  if(!zm_weap_spectral_shield::function_98890cd8(w_current)) {
    return;
  }

  var_3ba4bf7d = self getweaponslistprimaries();

  if(isDefined(var_3ba4bf7d[0])) {
    self switchtoweaponimmediate(var_3ba4bf7d[0], 1);
  }

  self waittill(#"fasttravel_finished");
  self switchtoweaponimmediate(w_current, 1);
}

private function_402d070f() {
  self endon(#"disconnect");
  self clientfield::set_to_player("" + #"hash_275c4e6783b917f8", 1);
  self waittill(#"fasttravel_over");
  self clientfield::set_to_player("" + #"hash_275c4e6783b917f8", 0);
}

function_d7af842d(e_unitrigger) {
  var_8d5d092c = e_unitrigger.stub.var_8d5d092c;

  switch (var_8d5d092c) {
    case #"warden_house_shower":
      var_d5376a79 = #"hash_76a9f44aee68fe8e";
      break;
    case #"cafeteria_west_side":
      var_d5376a79 = #"hash_6a5df83b0716ed39";
      break;
  }

  return var_d5376a79;
}

function_429e121c(var_5cc91e3c, var_8d5d092c, var_67cba496, var_374f0c4e, var_418e2265) {
  var_67cba496 thread scene::play("open");
  var_374f0c4e thread scene::play("open");
  level flag::set(#"hash_5466d69fa17fc721");
  level flag::set(var_5cc91e3c);
  level waittilltimeout(18, #"hash_3c3c6b906f6bbd6");
  level flag::clear(var_5cc91e3c);
  level flag::clear(#"hash_5466d69fa17fc721");
  var_67cba496 thread scene::play("close");
  var_374f0c4e thread scene::play("close");

  if(level.var_8f8f85f5) {
    if(isplayer(var_418e2265)) {
      if(isDefined(level.var_6effbeb5) && level.var_6effbeb5) {
        var_418e2265.var_a5a050c1 = 0.5;
      } else {
        var_418e2265.var_a5a050c1 = 30;
      }
    }

    level thread function_eef4fa8c(var_8d5d092c, var_418e2265);
    return;
  }

  if(isplayer(var_418e2265)) {
    var_418e2265.var_a5a050c1 = undefined;
  }
}

function_eef4fa8c(var_8d5d092c, var_418e2265) {
  str_notify_endon = "global_cooldown_watcher_" + var_8d5d092c;
  level notify(str_notify_endon);
  level endon(str_notify_endon);

  if(level.var_8f8f85f5) {
    level.var_261ad4d[var_8d5d092c] = 1;

    if(isDefined(level.var_6effbeb5) && level.var_6effbeb5) {
      n_cooldown = 0.5;
    } else {
      n_cooldown = 30;

      if(isplayer(var_418e2265) && var_418e2265 hasperk(#"specialty_cooldown")) {
        n_cooldown *= 0.5;
      }
    }

    level waittilltimeout(n_cooldown, #"hash_3c3c6b906f6bbd6");
    level.var_261ad4d[var_8d5d092c] = 0;
  }
}

function_9afaebe9() {
  self zm_audio::create_and_play_dialog(#"hellhole", #"exit", undefined);
}