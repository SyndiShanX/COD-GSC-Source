/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_red_achievement.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\spawner_shared;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_red_achievement;

init() {
  level thread function_e502ed82();
  spawner::add_archetype_spawn_function(#"gegenees", &function_b3786a8a);
  callback::on_connect(&function_3aed7ccf);
}

function_3aed7ccf() {
  self thread function_ec51ce01();
  self thread function_653f23be();
  self thread function_50e46434();
  self thread function_863d6212();
  self thread function_103e6827();
  self thread function_3c39c720();
  self thread function_74846734();
  self thread function_84d102f2();
}

private function_ec51ce01() {
  self endon(#"disconnect");
  level waittill(#"hash_71d7e6a55a1ca9e");

  if(zm_utility::is_classic()) {

    self iprintlnbold("<dev string:x38>");

      self zm_utility::giveachievement_wrapper("zm_red_tragedy");
  }
}

private function_653f23be() {
  self endon(#"death");
  level endon(#"end_game");

  if(zm_custom::function_901b751c(#"startround") > 1) {
    return;
  }

  level flagsys::wait_till("start_zombie_round_logic");

  if(level.round_number > 1) {
    return;
  }

  var_76f21e6b = array("zone_temple_of_apollo", "zone_temple_of_apollo_left_path", "zone_temple_of_apollo_right_path", "zone_temple_of_apollo_back");

  while(level.round_number <= 20) {
    str_zone = self zm_zonemgr::get_player_zone();

    if(!isDefined(str_zone) || !isinarray(var_76f21e6b, str_zone)) {
      return;
    }

    wait 1;
  }

  self iprintlnbold("<dev string:x55>");

    self zm_utility::giveachievement_wrapper("zm_red_follower");
}

private function_50e46434() {
  self endon(#"disconnect");

  if(zm_custom::function_901b751c(#"startround") > 1) {
    return;
  }

  while(true) {
    s_result = level waittill(#"hash_751ac3ddacb1c548", #"between_round_over");

    if(s_result._notify == "between_round_over" && level.round_number > 15) {
      return;
    }

    if(!isDefined(level.var_705db276)) {
      continue;
    }

    if(level.var_705db276 >= 5) {

      self iprintlnbold("<dev string:x75>");

        self zm_utility::giveachievement_wrapper("zm_red_tribute");
      return;
    }
  }
}

private function_863d6212() {
  self endon(#"disconnect");

  if(!zm_custom::function_901b751c(#"zmwonderweaponisenabled") || zm_utility::is_standard()) {
    return;
  }

  while(true) {
    s_result = self waittill(#"hash_4c8edf52fbfca691");

    if(self flag::get(#"ww_combat_active") || !isDefined(s_result.var_e0ae28d)) {
      continue;
    }

    if(s_result.var_e0ae28d >= 4) {

      self iprintlnbold("<dev string:x95>");

        self zm_utility::giveachievement_wrapper("zm_red_mountains");
      return;
    }
  }
}

private function_103e6827() {
  self endon(#"disconnect");

  if(!zm_custom::function_901b751c(#"zmwonderweaponisenabled") || zm_utility::is_standard()) {
    return;
  }

  while(true) {
    s_result = self waittill(#"hash_175b1370e662293a");

    if(self flag::get(#"ww_combat_active")) {
      continue;
    }

    if(isDefined(s_result.var_b1224954) && s_result.var_b1224954.n_dragged >= 15) {

      self iprintlnbold("<dev string:xb3>");

        self zm_utility::giveachievement_wrapper("zm_red_no_obol");
      return;
    }
  }
}

private function_3c39c720() {
  self endoncallback(&function_a5f404e2, #"disconnect");

  if(!zm_custom::function_901b751c(#"zmwonderweaponisenabled") || zm_utility::is_standard()) {
    return;
  }

  while(true) {
    s_result = self waittill(#"hash_4969a839c4e666dc");

    if(self flag::get(#"ww_combat_active")) {
      continue;
    }

    self.var_ec3e3f82 = 0;
    level callback::on_ai_killed(&function_8a595f5);
    self waittill(#"weapon_change", #"weapon_fired", #"stop_beaming");
    level callback::remove_on_ai_killed(&function_8a595f5);

    if(self.var_ec3e3f82 >= 20) {

      self iprintlnbold("<dev string:xca>");

        self zm_utility::giveachievement_wrapper("zm_red_sun");
      return;
    }

    self.var_ec3e3f82 = undefined;
  }
}

function_8a595f5(s_params) {
  if(isplayer(s_params.eattacker) && s_params.weapon == level.w_hand_hemera) {
    if(isDefined(self.var_4dcd7a1c) && self.var_4dcd7a1c) {
      s_params.eattacker.var_ec3e3f82++;
    }
  }
}

private function_a5f404e2(var_c34665fc) {
  level callback::remove_on_ai_killed(&function_8a595f5);
}

private function_74846734() {
  self endoncallback(&function_8828b419, #"disconnect");

  if(!zm_custom::function_901b751c(#"zmwonderweaponisenabled") || zm_utility::is_standard()) {
    return;
  }

  while(true) {
    s_result = self waittill(#"start_beaming");

    if(self flag::get(#"ww_combat_active")) {
      continue;
    }

    self.n_flung = 0;
    level callback::on_ai_killed(&function_c6125761);
    self waittill(#"weapon_change", #"weapon_fired", #"stop_beaming");
    level callback::remove_on_ai_killed(&function_c6125761);

    if(self.n_flung >= 20) {

      self iprintlnbold("<dev string:xee>");

        self zm_utility::giveachievement_wrapper("zm_red_wind");
      return;
    }

    self.n_flung = undefined;
  }
}

function_c6125761(s_params) {
  if(isplayer(s_params.eattacker) && s_params.weapon == level.w_hand_ouranos) {
    if(isDefined(self.var_8ac7cc49) && self.var_8ac7cc49 && isDefined(s_params.eattacker.n_flung)) {
      s_params.eattacker.n_flung++;
    }
  }
}

private function_8828b419(var_c34665fc) {
  level callback::remove_on_ai_killed(&function_c6125761);
}

private function_84d102f2() {
  self endon(#"disconnect", #"hash_5766f147327163d1");

  while(true) {
    s_result = level waittill(#"hash_4fb1eb2c137a7955", #"hash_1e2d6c34f734996b");

    if(s_result._notify == #"hash_4fb1eb2c137a7955") {
      if(s_result.e_player !== self) {
        return;
      }

      waitframe(1);

      if(level flag::get(#"hash_67695ee69c57c0b2") && level flag::get(#"hash_61de3b8fe6f6a35")) {

        self iprintlnbold("<dev string:x10b>");

          self zm_utility::giveachievement_wrapper("zm_red_eagle");
        self notify(#"hash_5766f147327163d1");
      } else {
        self thread function_9fdcf13f();
      }
    } else if(s_result._notify == #"hash_1e2d6c34f734996b") {
      return;
    }

    waitframe(1);
  }
}

private function_9fdcf13f() {
  self endon(#"disconnect", #"hash_5766f147327163d1", #"hash_4fb1eb2c137a7955");
  self waittill(#"weapon_change");
  level notify(#"hash_1e2d6c34f734996b", {
    #e_player: self
  });
}

private function_b3786a8a() {
  self thread function_f31369ae();
}

private function_f31369ae() {
  e_player = undefined;

  while(isalive(self)) {
    s_result = self waittill(#"damage", #"death");

    if((s_result.weapon === getweapon(#"zhield_zpear_dw") || s_result.weapon === getweapon(#"zhield_zpear_turret")) && isplayer(s_result.attacker)) {
      if(!isDefined(e_player)) {
        e_player = s_result.attacker;
      } else if(e_player !== s_result.attacker || isDefined(e_player.var_298cc14d) && e_player.var_298cc14d) {
        return;
      }

      continue;
    }

    return;
  }

  if(isDefined(e_player)) {
    e_player.var_298cc14d = 1;

    e_player iprintlnbold("<dev string:x12c>");

      e_player zm_utility::giveachievement_wrapper("zm_red_defense");
  }
}

private function_e502ed82() {
  level endon(#"end_game");
  a_flags = array(#"hash_5827ff8b059b77f3", #"hash_786c9a9f60b254f5", #"hash_3b7c39d9b76689fb", #"hash_29ac8ec32d2a389b", #"hash_39100dea955077f2");
  level flagsys::wait_till_all(a_flags);

  iprintlnbold("<dev string:x15e>");

    zm_utility::giveachievement_wrapper("zm_red_gods", 1);
}