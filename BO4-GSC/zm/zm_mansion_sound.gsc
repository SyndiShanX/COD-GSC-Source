/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_sound.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_mansion_sound;

main() {
  if(zm_utility::is_ee_enabled()) {
    level thread function_96da6081();
    level thread function_9ea70701();
  }

  level thread function_63491fbd();
  level thread function_a3a23636();
  level.var_359223a8 = array(0, 1, 2, 3, 4);
}

private function_96da6081() {
  level flag::wait_till_any(array("power_on", "power_on1"));
  level.var_4687b0d0 = [];
  level.var_4687b0d0[0] = array(#"hash_41c5ef88d30a0d04");
  level.var_4687b0d0[1] = array(#"hash_77d26356e7772673");
  level.var_4687b0d0[2] = array(#"hash_5f2672545b99ea1a");
  level.var_4687b0d0[3] = array(#"hash_47c8e68ac1a558b9");
  level.var_4687b0d0[4] = array(#"hash_b75c49e9dcc7900", #"hash_3d4162f1d6598a06", #"hash_38da480a84b97bda", #"hash_21856919a8b0f180", #"hash_3a59c33cb06334", #"hash_27a3a2bb7b9f52c2", #"hash_1448f639d29f413e", #"hash_7e02a393e0c315fc");
  level.var_4687b0d0[5] = array(#"hash_1db1fecdc55a68dd");
  a_s_rolls = struct::get_array("s_roll");

  foreach(s_roll in a_s_rolls) {
    s_roll.var_255658de = util::spawn_model(#"p8_zm_zod_phonograph_opera_roll", s_roll.origin, s_roll.angles);
    s_roll.s_unitrigger_stub = s_roll zm_unitrigger::create("", 64, &function_aba430c2);
  }

  var_b12143bd = struct::get("s_phono_roll");
  var_b12143bd.s_unitrigger_stub = var_b12143bd zm_unitrigger::create("", 64, &function_63c3fd24);
  level flag::init(#"phonograph_playing");
}

private function_aba430c2() {
  while(true) {
    s_result = self waittill(#"trigger");

    if(isplayer(s_result.activator) && isalive(s_result.activator) && !isDefined(s_result.activator.registerraz_locationinvalidposmenu)) {
      break;
    }
  }

  s_result.activator playSound(#"hash_7e0e4a1fb470d18f");
  s_result.activator.registerraz_locationinvalidposmenu = self.stub.related_parent.script_int;

  if(isDefined(self.stub.related_parent.var_255658de)) {
    self.stub.related_parent.var_255658de delete();
  }

  zm_unitrigger::unregister_unitrigger(self.stub.related_parent.s_unitrigger_stub);
}

private function_63c3fd24() {
  while(true) {
    s_result = self waittill(#"trigger");

    if(!isalive(s_result.activator)) {
      continue;
    }

    if(level flag::get(#"phonograph_playing")) {
      continue;
    }

    e_player = s_result.activator;

    if(!isDefined(self.stub.related_parent.var_255658de) && isDefined(e_player.registerraz_locationinvalidposmenu)) {
      self.stub.related_parent.var_255658de = util::spawn_model(#"p8_zm_zod_phonograph_opera_roll", self.stub.related_parent.origin, self.stub.related_parent.angles);
      self.stub.related_parent.var_255658de playSound(#"hash_343bf66b64f5830e");
      self.stub.related_parent.var_255658de thread function_f2d27140(e_player.registerraz_locationinvalidposmenu);
      self.stub.related_parent.var_255658de.registerraz_locationinvalidposmenu = e_player.registerraz_locationinvalidposmenu;
      e_player.registerraz_locationinvalidposmenu = undefined;
      continue;
    }

    if(isDefined(self.stub.related_parent.var_255658de)) {
      self.stub.related_parent.var_255658de thread function_f2d27140(self.stub.related_parent.var_255658de.registerraz_locationinvalidposmenu);
      continue;
    }

    if(!(isDefined(e_player.var_57c1fd86) && e_player.var_57c1fd86)) {
      self.stub.related_parent thread function_6aad582c(e_player);
    }
  }
}

private function_f2d27140(var_6a87ce6d) {
  self endon(#"death");
  self thread function_64834acd();
  level flag::set(#"phonograph_playing");
  self notify(#"hash_2b02b5a5a9af36e0");
  self notify(#"hash_44144f80f295a13f");
  self playSound(#"hash_7c91fa775c8a0134");
  self playLoopSound(#"hash_2367dae4a69a4294");
  wait 1;

  if(isDefined(var_6a87ce6d)) {
    self zm_vo::function_cf1e151c(level.var_4687b0d0[var_6a87ce6d]);
  }

  self notify(#"hash_53eb32eaa511640c");
  self stoploopsound();
  self playSound(#"hash_376eaa517cd09530");
  self thread function_ad05f6f3();
  level flag::clear(#"phonograph_playing");
}

private function_64834acd() {
  self notify("1a9a8d2140387a89");
  self endon("1a9a8d2140387a89");
  self endon(#"death");

  while(true) {
    self function_21a979f7();
    self waittill(#"hash_44144f80f295a13f");
  }
}

private function_21a979f7() {
  self endon(#"hash_53eb32eaa511640c");

  while(true) {
    if(self.angles[0] < 360) {
      self.angles += (360, 0, 0);
    }

    self rotatepitch((self.angles[0] + 180) * -1, 2);
    self waittill(#"rotatedone");
  }
}

private function_ad05f6f3() {
  self notify(#"hash_2b02b5a5a9af36e0");
  self endon(#"hash_2b02b5a5a9af36e0");
  self val::set(#"phono_roll", "takedamage", 1);
  self val::set(#"phono_roll", "allowdeath", 0);

  while(isDefined(self)) {
    s_result = self waittill(#"damage");

    if(isplayer(s_result.attacker)) {
      break;
    }
  }

  playsoundatposition(#"hash_2cf59d6222de4f6f", self.origin);
  self delete();
}

private function_6aad582c(e_player) {
  e_player endoncallback(&function_3741630d, #"disconnect");

  if(e_player zm_characters::is_character(array(#"hash_3c0932fa55ee6e5b"))) {
    var_59c8624c = #"hash_24f1e841c9ab0766";
  } else if(e_player zm_characters::is_character(array(#"hash_5ebf024e1559c04a"))) {
    var_59c8624c = #"hash_680df11406aaad0d";
  } else if(e_player zm_characters::is_character(array(#"hash_4e8f51ec275a4a38"))) {
    var_59c8624c = #"hash_14367bddc8694d4f";
  } else if(e_player zm_characters::is_character(array(#"hash_515977e191d13967"))) {
    var_59c8624c = #"hash_53875c52fa6301c0";
  }

  level flag::set(#"phonograph_playing");
  e_player playsoundtoplayer(var_59c8624c, e_player);
  wait soundgetplaybacktime(var_59c8624c) * 0.001;
  e_player.var_57c1fd86 = 1;
  level flag::clear(#"phonograph_playing");
}

private function_3741630d(var_c34665fc) {
  level flag::clear(#"phonograph_playing");
}

function_9ea70701() {
  var_56980742 = struct::get("s_int_t_c");
  var_56980742.var_690ea031 = array(#"hash_515977e191d13967");
  var_56980742.var_59c8624c = #"hash_4ff92627bab81ee4";
  var_56980742.s_unitrigger_stub = var_56980742 zm_unitrigger::create("", 64, &function_33864e5d);
  var_91f0b44f = struct::get("s_int_amu");
  var_91f0b44f.var_690ea031 = array(#"hash_515977e191d13967");
  var_91f0b44f.var_59c8624c = #"hash_502b8782f8b740c";
  var_91f0b44f.s_unitrigger_stub = var_91f0b44f zm_unitrigger::create("", 64, &function_33864e5d);
  var_fb14f184 = struct::get("s_int_n_p");
  var_fb14f184.var_690ea031 = array(#"hash_5ebf024e1559c04a");
  var_fb14f184.var_59c8624c = #"hash_7172cde1ce628720";
  var_fb14f184.s_unitrigger_stub = var_fb14f184 zm_unitrigger::create("", 64, &function_33864e5d);
  var_64dd4c0d = struct::get("s_int_a_p");
  var_64dd4c0d.var_690ea031 = array(#"hash_3c0932fa55ee6e5b");
  var_64dd4c0d.var_59c8624c = #"hash_26c5ceaa58dd1ddc";
  var_64dd4c0d.s_lookat = struct::get("s_int_a_p_lookat", "targetname");
  var_64dd4c0d.s_unitrigger_stub = var_64dd4c0d zm_unitrigger::create("", 64, &function_33864e5d);
}

function_33864e5d() {
  s_interact = self.stub.related_parent;

  while(true) {
    s_result = self waittill(#"trigger");

    if(!isplayer(s_result.activator) || !isalive(s_result.activator)) {
      continue;
    }

    if(!s_result.activator zm_characters::is_character(s_interact.var_690ea031)) {
      continue;
    }

    if(!isDefined(s_interact.s_lookat) || s_result.activator util::is_looking_at(s_interact.s_lookat.origin, 0.7)) {
      s_result.activator thread zm_vo::function_a2bd5a0c(s_interact.var_59c8624c);
      break;
    }
  }

  zm_unitrigger::unregister_unitrigger(s_interact.s_unitrigger_stub);
}

function_63491fbd() {
  level endon(#"end_game");

  while(!(isDefined(level.var_9138a2) && level.var_9138a2)) {
    s_result = level waittill(#"crafting_started");
    e_player = s_result.activator;
    str_zone = e_player zm_zonemgr::get_player_zone();

    if(isDefined(str_zone) && str_zone != "zone_cemetery_path_left") {
      level.var_9138a2 = s_result.activator zm_audio::create_and_play_dialog(#"bench", #"interact_first", undefined, 1);
    }
  }

  level.var_9138a2 = undefined;
}

function_a3a23636() {
  level endon(#"end_game");
  level flag::wait_till_any(array(#"power_on", #"power_on1", #"hash_2daf5bdda85cc660"));
  var_79bd8bd4 = getent("knight_model_cemetery", "targetname");
  var_38c25a0c = getent("knight_model_greenhouse", "targetname");
  var_170ef705 = getent("knight_model_main_hall", "targetname");

  while(!(isDefined(level.var_d2867f97) && level.var_d2867f97) && !level flag::get_all(array(#"knight_main_hall_stationed", #"knight_cemetery_stationed", #"knight_greenhouse_stationed"))) {
    b_play_vo = 0;

    foreach(e_player in zm_vo::function_347f7d34()) {
      if(!isDefined(e_player)) {
        continue;
      }

      if(isDefined(var_79bd8bd4) && e_player util::is_player_looking_at(var_79bd8bd4.origin) && distance2dsquared(var_79bd8bd4.origin, e_player.origin) < 65536) {
        b_play_vo = 1;
      } else if(isDefined(var_38c25a0c) && e_player util::is_player_looking_at(var_38c25a0c.origin) && distance2dsquared(var_38c25a0c.origin, e_player.origin) < 65536) {
        b_play_vo = 1;
      } else if(isDefined(var_170ef705) && e_player util::is_player_looking_at(var_170ef705.origin) && distance2dsquared(var_170ef705.origin, e_player.origin) < 65536) {
        b_play_vo = 1;
      }

      if(b_play_vo && !(isDefined(level.var_d2867f97) && level.var_d2867f97)) {
        level.var_d2867f97 = e_player zm_vo::function_a2bd5a0c(#"hash_4a084873bbb64d39", 0, 0, 9999);
      }
    }

    wait 1;
  }

  level.var_d2867f97 = undefined;
}

function_90659e2c() {
  level endon(#"end_game");
  s_result = level waittill(#"hash_483503537a553500");

  if(isalive(s_result.e_player)) {
    s_result.e_player zm_audio::create_and_play_dialog(#"seer_stone", #"interact_first", undefined, 1);
  }
}

function_eb112701() {
  level endon(#"end_game");
  s_result = level waittill(#"bedroom_charged", #"library_charged", #"cellar_charged");
  mdl_stone = undefined;

  switch (s_result._notify) {
    case #"bedroom_charged":
      mdl_stone = getent("gazing_stone_main_hall", "targetname");
      break;
    case #"library_charged":
      mdl_stone = getent("gazing_stone_library", "targetname");
      break;
    case #"cellar_charged":
      mdl_stone = getent("gazing_stone_cellar", "targetname");
      break;
  }

  e_closest_player = arraygetclosest(mdl_stone.origin, getplayers());

  if(isalive(e_closest_player)) {
    e_closest_player zm_audio::create_and_play_dialog(#"seer_stone", #"active", undefined, 1);
  }
}

function_6b5b1780() {
  level endon(#"end_game");
  s_result = level waittill(#"hash_43aa2c21cf191318");

  if(isalive(s_result.e_player)) {
    s_result.e_player zm_audio::create_and_play_dialog(#"seer_stone", #"location", undefined, 1);
  }
}

function_70c90053() {
  level endon(#"end_game");
  self endon(#"death", #"flag_gazing_stone_in_use");
  v_stone = self.origin + (0, 0, 8);

  while(true) {
    wait randomintrange(27, 31);
    e_closest_player = arraygetclosest(v_stone, util::get_active_players(), 768);

    if(isalive(e_closest_player) && e_closest_player util::is_player_looking_at(v_stone, 0.6, 0)) {
      e_closest_player zm_audio::create_and_play_dialog(#"seer_stone", #"nag", undefined, 1);
    }
  }
}

function_e432aeb6(str_category, var_39acfdda) {
  if(level.var_359223a8.size) {
    n_voice = array::random(level.var_359223a8);
    arrayremovevalue(level.var_359223a8, n_voice);
    function_2d4ce142(n_voice);
    return 1;
  }

  self.var_631a26f0[str_category][var_39acfdda] = undefined;
  return 0;
}

private function_2d4ce142(n_voice) {
  switch (n_voice) {
    case 0:
      zm_audio::play_vo_internal(#"hash_56d727e4dde061ef");
      zm_audio::play_vo_internal(#"hash_73722f29ea1fa41", self);
      break;
    case 1:
      zm_audio::play_vo_internal(#"hash_46c0fcd4eac3143a");
      zm_audio::play_vo_internal(#"hash_2fd88698209e1998", self);
      break;
    case 2:
      zm_audio::play_vo_internal(#"hash_6a18c9d5cea653d4", self);
      zm_audio::play_vo_internal(#"hash_21bcbc16a4e2812a");
      break;
    case 3:
      zm_audio::play_vo_internal(#"hash_19c3a28739527fc8");
      zm_audio::play_vo_internal(#"hash_c3c497c80eba90e", self);
      break;
    case 4:
      zm_audio::play_vo_internal(#"hash_5f99dba5a34a200b");
      zm_audio::play_vo_internal(#"hash_50bc3e7a02399bd5", self);
      break;
  }
}

function_c8d42aba(str_category, var_39acfdda) {
  a_e_players = util::get_players();

  if(a_e_players.size > 1) {
    n_voice = randomint(5);

    switch (n_voice) {
      case 0:
        zm_audio::play_vo_internal(#"hash_39ad75c662ff40da");
        zm_audio::play_vo_internal(#"hash_25d195bb73a47af8", self);
        zm_audio::play_vo_internal(#"hash_39ad73c662ff3d74");
        zm_audio::play_vo_internal(#"hash_25d197bb73a47e5e", self);
        break;
      case 1:
        zm_audio::play_vo_internal(#"hash_2c15b9198408b36e", self);
        zm_audio::play_vo_internal(#"hash_559c2e4e451d15dc");
        zm_audio::play_vo_internal(#"hash_2c15b7198408b008", self);
        break;
      case 2:
        zm_audio::play_vo_internal(#"hash_7024e5a861250e68");
        zm_audio::play_vo_internal(#"hash_2d116afa2223e9ee", self);
        zm_audio::play_vo_internal(#"hash_7024e7a8612511ce");
        zm_audio::play_vo_internal(#"hash_2d1168fa2223e688", self);
        break;
      case 3:
        zm_audio::play_vo_internal(#"hash_3682a6259c85c134", self);
        zm_audio::play_vo_internal(#"hash_6dc330df77b075ca");
        zm_audio::play_vo_internal(#"hash_3682a8259c85c49a", self);
        zm_audio::play_vo_internal(#"hash_6dc32edf77b07264");
        break;
      case 4:
        zm_audio::play_vo_internal(#"hash_1f01c37f559d0216");
        zm_audio::play_vo_internal(#"hash_663346a99e3bdffc", self);
        zm_audio::play_vo_internal(#"hash_1f01c17f559cfeb0");
        zm_audio::play_vo_internal(#"hash_663348a99e3be362", self);
        break;
    }
  }

  return true;
}

function_4928382a(str_category, var_39acfdda) {
  a_e_players = util::get_players();

  if(a_e_players.size > 1) {
    var_e04d003f = self zm_characters::function_d35e4c92();
    str_vo = "vox_revive_down_plr_" + var_e04d003f + "_" + randomint(4);
    self zm_audio::play_vo_internal(hash(str_vo));
  }

  return true;
}

function_658ce256(str_category, var_39acfdda) {
  if(math::cointoss(16)) {
    zm_audio::play_vo_internal(#"hash_781c84d22590fba6");
    zm_audio::play_vo_internal(#"hash_6a2a0c62daaff8ac", self);
    return true;
  }

  return false;
}

function_df8a01f3() {
  self endon(#"death");

  if(!level flag::get("boss_fight_started")) {
    switch (level.round_number) {
      case 1:
        self zm_vo::vo_say("vox_solo_game_start_0_butd_0", 0, 1, 9999);
        self zm_vo::vo_say("vox_solo_game_start_1_plr_12_0", 0, 1, 9999);
        break;
      case 2:
        self zm_vo::vo_say("vox_solo_end_round1_0_plr_12_0", 0, 1, 9999);
        self zm_vo::vo_say("vox_solo_end_round1_1_butd_0", 0, 1, 9999);
        break;
      case 3:
        self zm_vo::vo_say("vox_solo_end_round2_0_plr_12_0", 0, 1, 9999);
        self zm_vo::vo_say("vox_solo_end_round2_1_butd_0", 0, 1, 9999);
        break;
    }
  }

  return true;
}

function_edae33b5(str_category, var_39acfdda) {
  if(math::cointoss(16)) {
    zm_audio::play_vo_internal(#"hash_41b1b4aa63697b30", self);
    return true;
  }

  return false;
}

function_fe8cce7a(str_category, var_39acfdda) {
  if(math::cointoss(16)) {
    zm_audio::play_vo_internal(#"hash_5356fdb821d6dedd");
    zm_audio::play_vo_internal(#"hash_10335b450c3f5187", self);
    return true;
  }

  return false;
}

function_bb1888fe(str_category, var_39acfdda) {
  if(math::cointoss(25)) {
    zm_audio::play_vo_internal(#"hash_f5f0d56fe254796");
    zm_audio::play_vo_internal(#"hash_48710f792a0c297c", self);
    return true;
  }

  return false;
}

function_f26d178f(str_category, var_39acfdda) {
  if(math::cointoss(16)) {
    zm_audio::play_vo_internal(#"hash_23048fd6c52dd964");
    zm_audio::play_vo_internal(#"hash_5d5ef2b48b533f2", self);
    return true;
  }

  return false;
}

function_1f4ab5ec(str_category, var_39acfdda) {
  n_chance = randomint(10);

  if(n_chance == 3 || n_chance == 4) {
    switch (n_chance) {
      case 3:
        zm_audio::play_vo_internal(#"hash_2b910762865b2884");
        zm_audio::play_vo_internal(#"hash_d705a0e5a2a79d2", self);
        break;
      case 4:
        zm_audio::play_vo_internal(#"hash_c27975b04cf4e48", self);
        break;
    }

    return true;
  }

  return false;
}

function_a3a92098() {
  level endon(#"cellar_located");
  self endon(#"death");
  var_39ef2390 = getent("cellar_location_vo", "targetname");

  while(true) {
    s_result = var_39ef2390 waittill(#"trigger");

    if(isalive(s_result.activator) && s_result.activator === self) {
      self thread zm_audio::create_and_play_dialog(#"location_enter", #"wine_cellar");
      level notify(#"cellar_located");
      callback::remove_on_spawned(&function_a3a92098);
      return;
    }

    wait 2;
  }
}