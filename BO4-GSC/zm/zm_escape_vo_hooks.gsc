/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_escape_vo_hooks.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_escape_paschal;
#include scripts\zm\zm_escape_travel;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_escape_vo_hooks;

autoexec __init__system__() {
  system::register(#"zm_escape_vo_hooks", &__init__, &__main__, undefined);
}

__init__() {
  callback::on_connect(&on_player_connect);
  level init_flags();
  level thread init_announcer();
}

__main__() {
  level flag::wait_till(#"all_players_spawned");
  level thread function_f1da2bd5();
  level thread function_bdc25d1b();
  level thread function_35491a0e();
  level thread function_49189399();
  level thread function_3deb7fb0();
  level thread function_a78a3261();
  level thread function_f34169e8();
  level thread function_22101968();
  level thread function_4e68b0f4();
  level thread function_29543c();
  level thread function_963edada();
}

init_flags() {
  level flag::init(#"hash_20ac26ecda866c45");
  level flag::init(#"hash_59cfca3c898df56d");
  level flag::init(#"hash_779398f97110e7b8");
  level flag::init(#"hash_732657441f7793dc");
}

init_announcer() {
  zm_audio::sndannouncervoxadd(#"catwalk_warden_0_0", #"hash_53687fb8d75cd0d");
}

on_player_connect() {
  self flag::init(#"hash_1308e79a11093c1e");
  self thread function_9af564c();
}

function_4e68b0f4() {
  var_baa069fa = getent("t_v_o_exam", "targetname");
  s_info = var_baa069fa waittill(#"trigger");
  e_player = s_info.activator;
  e_player thread zm_audio::create_and_play_dialog(#"exam_room", #"react", undefined, 1);
}

function_29543c() {
  var_baa069fa = getent("t_v_o_docks", "targetname");
  s_info = var_baa069fa waittill(#"trigger");
  e_player = s_info.activator;
  b_say = e_player zm_audio::create_and_play_dialog(#"zone_dock", #"react_0", undefined, 1);

  if(isDefined(b_say) && b_say && e_player zm_characters::is_character(array(#"hash_1aa57ef704f24fa5", #"hash_36bc80636f0fdac4"))) {
    wait soundgetplaybacktime(#"hash_6598db6cd61c4aad") / 1000;
    e_nikolai = undefined;

    foreach(var_a7cf1037 in level.players) {
      if(var_a7cf1037 zm_characters::is_character(array(#"hash_22e6f7e13c3a99ef", #"hash_46b92e1337b43236"))) {
        e_nikolai = var_a7cf1037;
        break;
      }
    }

    if(isalive(e_nikolai) && isalive(e_player)) {
      if(distancesquared(e_nikolai.origin, e_player.origin) < 589824) {
        var_9a0250b7 = #"hash_465a6e7feb94a61d";
        e_nikolai zm_vo::vo_say(var_9a0250b7, 0, 0, 9999);
      }
    }
  }
}

function_9af564c() {
  self endon(#"disconnect");

  while(true) {
    self waittill(#"hash_1413599b710f10bd");
    self thread zm_audio::create_and_play_dialog(#"brutus", #"helm_off", undefined);
  }
}

private function_f34169e8() {
  level endon(#"end_game");
  s_escape_plan_vo_react = struct::get("s_map_react_vo_rich_lab");
  s_escape_plan_vo_react.s_unitrigger_stub = s_escape_plan_vo_react zm_unitrigger::create(undefined, 64, &function_65a374eb);

  if(level flag::exists(#"hash_40e9ad323fe8402a")) {
    level flag::wait_till(#"hash_40e9ad323fe8402a");
    zm_unitrigger::unregister_unitrigger(s_escape_plan_vo_react.s_unitrigger_stub);
  }
}

function_65a374eb() {
  level endon(#"hash_40e9ad323fe8402a");

  while(true) {
    s_result = self waittill(#"trigger");
    e_player = s_result.activator;
    e_player thread zm_audio::create_and_play_dialog(#"map", #"react");
  }
}

private function_f1da2bd5() {
  var_44e6a82b = struct::get_array("s_pods_react");

  foreach(s_pod in var_44e6a82b) {
    s_pod.s_unitrigger_stub = s_pod zm_unitrigger::create(&function_480ec8c, 96, &function_4f89089b);
  }

  if(level flag::exists(#"hash_379fc22ed85f0dbc")) {
    level flag::wait_till(#"hash_379fc22ed85f0dbc");

    foreach(s_pod in var_44e6a82b) {
      zm_unitrigger::unregister_unitrigger(s_pod.s_unitrigger_stub);
    }
  }
}

function_480ec8c(player) {
  if(!(isDefined(player.var_b5fbfab4) && player.var_b5fbfab4)) {
    self sethintstring(#"");
    return 1;
  }

  return 0;
}

function_4f89089b() {
  while(true) {
    s_result = self waittill(#"trigger");

    if(isplayer(s_result.activator) && isalive(s_result.activator)) {
      b_played = s_result.activator zm_audio::create_and_play_dialog(#"vpods", #"react");

      if(isDefined(b_played) && b_played) {
        s_result.activator.var_b5fbfab4 = 1;

        if(isDefined(self.stub.related_parent.script_string) && self.stub.related_parent.script_string == "stuh") {
          s_result.activator.var_59dde2f6 = 1;
        }
      }
    }
  }
}

function_963edada() {
  level endoncallback(&function_19af3d1b, #"hash_59cfca3c898df56d", #"hash_732657441f7793dc", #"end_game");
  var_d98d7f94 = getent("t_cell_block_vista_vo", "targetname");

  while(isDefined(var_d98d7f94)) {
    s_result = var_d98d7f94 waittill(#"trigger");
    b_play = s_result.activator zm_audio::create_and_play_dialog(#"vista", #"react");

    if(isDefined(b_play) && b_play) {
      level flag::set(#"hash_59cfca3c898df56d");
    }

    wait 0.1;
  }
}

function_19af3d1b(str_notify) {
  var_d98d7f94 = getent("t_cell_block_vista_vo", "targetname");

  if(isDefined(var_d98d7f94)) {
    var_d98d7f94 delete();
  }
}

private function_bdc25d1b() {
  var_73707aab = getent("power_house_power_switch", "script_noteworthy");
  var_73707aab endon(#"death");
  s_info = var_73707aab waittill(#"trigger");
  e_player = s_info.activator;
  e_player thread zm_audio::create_and_play_dialog(#"powerplant", #"turn_on");
}

function_350029c6() {
  self endon(#"death");
  s_info = self waittill(#"trigger");
  e_player = s_info.activator;
  e_player thread zm_audio::create_and_play_dialog(#"build_64", #"turn_on");
}

private function_35491a0e() {
  s_catwalk_lava_exp = struct::get("s_catwalk_lava_exp");
  s_catwalk_lava_exp.var_ef66d35a = s_catwalk_lava_exp zm_unitrigger::create(&function_58813027, s_catwalk_lava_exp.radius, &function_f118f554, 0, 0);
  level flag::wait_till(#"hash_779398f97110e7b8");
  zm_unitrigger::unregister_unitrigger(s_catwalk_lava_exp.var_ef66d35a);
}

function_58813027(e_player) {
  return !level flag::get(#"hash_779398f97110e7b8");
}

function_f118f554() {
  self endon(#"death");
  s_info = self waittill(#"trigger");
  e_player = s_info.activator;
  exploder::exploder("fxexplo_catwalk_lava_burst");
  level clientfield::set("" + #"hash_24deaa9795e06d41", 1);
  e_player thread function_5860fce9();
}

private function_5860fce9() {
  self endon(#"disconnect");
  wait 10;

  if(isalive(self)) {
    b_say = self zm_vo::function_a2bd5a0c(#"hash_227bd68a057f7198", 0, 1);

    if(b_say && isalive(self) && level.activeplayers.size > 1) {
      e_richtofen = paschal::function_b1203924();

      if(isDefined(e_richtofen) && self != e_richtofen && distancesquared(self.origin, e_richtofen.origin) < 1000000) {
        e_richtofen zm_vo::function_a2bd5a0c(#"hash_227bd68a057f7198");
      }
    }
  }

  level flag::set(#"hash_779398f97110e7b8");
}

private function_49189399() {
  var_e5bf9843 = getent("t_reached_cellbock_vo", "targetname");
  var_e5bf9843 endon(#"death");

  while(true) {
    s_info = var_e5bf9843 waittill(#"trigger");
    e_player = s_info.activator;

    if(isplayer(e_player)) {
      break;
    }
  }

  if(level.players.size > 1) {
    e_player thread zm_audio::create_and_play_dialog(#"cell_block", #"react", undefined, 1);
  } else {
    e_richtofen = paschal::function_b1203924();

    if(isalive(e_richtofen)) {
      e_richtofen thread zm_audio::create_and_play_dialog(#"cell_block", #"react", undefined, 1);
    }
  }

  level flag::set(#"hash_732657441f7793dc");
}

function_22101968() {
  var_d756a0b4 = getent("t_infir_full_react", "targetname");
  var_d756a0b4 endon(#"death");

  while(true) {
    s_info = var_d756a0b4 waittill(#"trigger");
    e_player = s_info.activator;

    if(isplayer(e_player) && e_player flag::get(#"hash_30ae3926b2d211db")) {
      break;
    }
  }

  if(!level flag::get(#"hash_1a367a4a0dfb0471")) {
    e_player zm_audio::create_and_play_dialog(#"bathtub", #"react", undefined, 1);
    var_d756a0b4 delete();
  }
}

private function_3deb7fb0() {
  s_escape_plan_vo_react = struct::get("s_escape_plan_vo_react");
  s_escape_plan_vo_react zm_unitrigger::create(undefined, 64, &function_db185b3, 1);
}

function_db185b3() {
  self endon(#"death");

  while(true) {
    s_info = self waittill(#"trigger");
    e_player = s_info.activator;
    e_player thread zm_audio::create_and_play_dialog(#"escape_plan", #"react");
  }
}

private function_a78a3261() {
  for(var_12d0accd = 0; var_12d0accd < 3; var_12d0accd++) {
    while(true) {
      level waittill(#"gondola_moving");
      var_be632f74 = 1;

      foreach(player in getplayers()) {
        if(player zm_escape_travel::function_9a8ab327()) {
          var_be632f74 = 0;
          break;
        }
      }

      if(var_be632f74 == 0) {
        continue;
      }

      break;
    }

    if(isDefined(level.var_105462b6)) {
      level.var_105462b6 thread zm_audio::create_and_play_dialog(#"gondola", #"call");
    }
  }
}

function_818b85eb() {
  self endon(#"death", #"disconnect");
  wait 1;

  if(!isDefined(self)) {
    return;
  }

  if(!self flag::get(#"hash_1308e79a11093c1e")) {
    self flag::set(#"hash_1308e79a11093c1e");
    self thread zm_audio::create_and_play_dialog(#"hellhole", #"enter_first");
    return;
  }

  self thread zm_audio::create_and_play_dialog(#"hellhole", #"enter");
}

function_c179111e() {
  level endon(#"hash_dd62a8822ea4a38", #"end_game");
  level waittill(#"p_e_f_vo");
  a_e_players = zm_zonemgr::get_players_in_zone("zone_citadel_stairs", 1);

  if(isarray(a_e_players) && a_e_players.size > 0) {
    e_player = array::random(a_e_players);

    if(isalive(e_player)) {
      e_player thread zm_audio::create_and_play_dialog(#"elev_crash", #"react");
    }
  }
}

function_d62aaf66() {
  e_player = array::random(level.activeplayers);
  return e_player;
}