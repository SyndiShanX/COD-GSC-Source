/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_59a783d756554a80.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_office_floors;
#include scripts\zm_common\callbacks;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;
#namespace namespace_8f53e87b;

init() {
  callback::on_spawned(&setup_character_vo);

  if(!zm_utility::is_standard()) {
    level thread function_132e0bea();
  }
}

setup_character_vo() {
  if(!zm_trial::is_trial_mode() && !zm_utility::is_standard()) {
    if(self zm_characters::is_character(array(#"prt_zm_richtofen", #"prt_zm_richtofen_ofc", #"prt_zm_richtofen_whi_novials"))) {
      self thread function_5bd0ee94();
    }
  }
}

function_5bd0ee94() {
  self endon(#"death");
  level.var_b10a99a1 = array(#"hash_32d43d269e30acea", #"hash_17d53ca41c412d7f", #"hash_da35c4f5834157c", #"hash_3ee8d76b357581a1", #"hash_7cc1be647a9336e6");
  level.next_rmb = 0;
  level thread function_148c9f71();
  level waittill(#"rich_mind");
  self thread function_c207b97();
  function_25f77618();
}

function_25f77618() {
  self zm_audio::function_6191af93(#"ammo", #"out", #"ammo_rich_mind", #"out", 25);
  self zm_audio::function_6191af93(#"ammo", #"low", #"ammo_rich_mind", #"low", 25);
  self zm_audio::function_6191af93(#"magicbox", #"homunculus", #"magicbox_rich_mind", #"homunculus", 25);
  self zm_audio::function_6191af93(#"magicbox", #"pistol", #"magicbox_rich_mind", #"pistol", 25);
  self zm_audio::function_6191af93(#"magicbox", #"sniper", #"magicbox_rich_mind", #"sniper", 25);
  self zm_audio::function_6191af93(#"magicbox", #"raygun", #"magicbox_rich_mind", #"raygun", 25);
  self zm_audio::function_6191af93(#"kill", #"homunculus", #"kill_rich_mind", #"homunculus", 25);
  self zm_audio::function_6191af93(#"kill", #"explosive", #"kill_rich_mind", #"explosive", 25);
  self zm_audio::function_6191af93(#"kill", #"headshot", #"kill_rich_mind", #"headshot", 25);
  self zm_audio::function_6191af93(#"kill", #"streak_self", #"kill_rich_mind", #"streak_self", 25);
  self zm_audio::function_6191af93(#"kill", #"melee", #"kill_rich_mind", #"melee", 25);
  self zm_audio::function_6191af93(#"kill", #"raygun", #"kill_rich_mind", #"raygun", 25);
  self zm_audio::function_6191af93(#"kill", #"specialround", #"kill_rich_mind", #"specialround", 25);
  self zm_audio::function_6191af93(#"powerup", #"firesale", #"powerup_rich_mind", #"firesale", 25);
  self zm_audio::function_6191af93(#"powerup", #"nuke", #"powerup_rich_mind", #"nuke", 25);
  self zm_audio::function_6191af93(#"revive", #"down", #"revive_rich_mind", #"down", 25);
  self zm_audio::function_6191af93(#"revive", #"support_demp", #"revive_rich_mind", #"support_demp", 25);
  self zm_audio::function_6191af93(#"revive", #"support_niko", #"revive_rich_mind", #"support_niko", 25);
  self zm_audio::function_6191af93(#"revive", #"support_take", #"revive_rich_mind", #"support_take", 25);
  self zm_audio::function_6191af93(#"general", #"attacked", #"general_rich_mind", #"attacked", 25);
  self zm_audio::function_6191af93(#"general", #"crawl_spawn", #"general_rich_mind", #"crawl_spawn", 25);
  self zm_audio::function_6191af93(#"general", #"gib", #"general_rich_mind", #"gib", 25);
  self zm_audio::function_6191af93(#"general", #"outofmoney", #"general_rich_mind", #"outofmoney", 25);
  self zm_audio::function_6191af93(#"perk", #"generic", #"perk_rich_mind", #"generic", 25);
  self zm_audio::function_6191af93(#"weapon_pickup", #"shield", #"weapon_pickup_rich_mind", #"shield", 25);
  self zm_audio::function_6191af93(#"roundstart", #"special", #"roundstart_rich_mind", #"special", 25);
  self zm_audio::function_6191af93(#"surrounded", #"self", #"surrounded_rich_mind", #"self", 25);
}

function_148c9f71() {
  self endon(#"game_ended");
  callback::on_round_end(&function_76659f5e);

  while(level.next_rmb < 3) {
    level waittill(#"next_rmb");
    level.next_rmb++;
  }

  level.next_rmb = 0;
  level notify(#"rich_mind");
}

function_c207b97() {
  self endon(#"death");

  while(level.next_rmb < 5) {
    self.var_472e3448 = 1;
    self zm_vo::vo_say(level.var_b10a99a1[level.next_rmb], undefined, 1, undefined, undefined, 1);
    level.next_rmb++;
    level waittill(#"next_rmb");
  }

  callback::remove_on_round_end(&function_76659f5e);
}

function_76659f5e() {
  a_e_players = zm_office_floors::function_df2506d3(4);

  foreach(e_player in a_e_players) {
    level notify(#"next_rmb");

    if(e_player zm_characters::is_character(array(#"prt_zm_richtofen", #"prt_zm_richtofen_ofc", #"prt_zm_richtofen_whi_novials"))) {
      level notify(#"next_rmb");
    }
  }
}

function_132e0bea() {
  level endon(#"end_game");
  level waittill(#"start_of_round");
  power_trig = getent("use_elec_switch", "targetname");

  if(isDefined(power_trig)) {
    waitresult = power_trig waittill(#"trigger");
    user = waitresult.activator;
    wait 2;

    while(isDefined(user) && isDefined(user.isspeaking) && user.isspeaking) {
      waitframe(1);
    }

    play_pentagon_announcer_vox(#"hash_1984a3f4bf85aff0");
  }
}

function_777b7961(user) {
  flag::clear(#"hash_38f45c699c5d5d63");
  level play_pentagon_announcer_vox(#"hash_450f3dd9fe21becd", 5);
  level play_pentagon_announcer_vox("vox_pentagon_teleport_establish_pann_0");
  user thread zm_vo::function_a2bd5a0c(#"hash_2a834e891cc8667a");
}

play_pentagon_announcer_vox(alias, defcon_level) {
  if(!isDefined(alias)) {
    return;
  }

  if(!isDefined(level.pentann_is_speaking)) {
    level.pentann_is_speaking = 0;
  }

  if(isDefined(defcon_level)) {
    alias = alias + "_" + defcon_level + "_pann_0";
  }

  if(level.pentann_is_speaking == 0) {
    level.pentann_is_speaking = 1;
    level play_initial_alarm();
    level function_2389bb7a(alias);
    level.pentann_is_speaking = 0;
  }
}

function_2389bb7a(str_sound) {
  n_wait = float(soundgetplaybacktime(str_sound)) / 1000;
  n_wait = max(n_wait - 0.5, 0.1);

  foreach(player in level.players) {
    if(!zm_office_floors::function_9dd97963(player)) {
      player playsoundtoplayer(str_sound, player);
    }
  }

  wait n_wait;
}

play_initial_alarm() {
  structs = struct::get_array("defcon_alarms", "targetname");

  for(i = 0; i < structs.size; i++) {
    playsoundatposition(#"evt_thief_alarm_single", structs[i].origin);
  }

  wait 0.5;
}

function_8cbb1711() {
  play_pentagon_announcer_vox(#"hash_447c4584ae2e8e9c");
  e_player = function_d62aaf66();

  if(isDefined(e_player)) {
    e_player zm_audio::create_and_play_dialog(#"generic", #"response_negative", undefined, 1);
  }
}

function_d7b93e68(e_player, n_index) {
  if(isDefined(n_index)) {
    level play_pentagon_announcer_vox(#"hash_33a55493071f7af6");
    e_player thread zm_audio::create_and_play_dialog(#"generic", #"response_negative", undefined, 1);
    return;
  }

  level thread play_pentagon_announcer_vox(#"hash_33a55493071f7af6");
}

function_d62aaf66() {
  a_players = zm_vo::get_valid_players();
  e_player = array::random(a_players);
  return e_player;
}