/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\display_transition.gsc
******************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\killcam_shared;
#include scripts\core_common\music_shared;
#include scripts\core_common\player\player_role;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\potm_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\hud_message;
#include scripts\mp_common\gametypes\outcome;
#include scripts\mp_common\gametypes\overtime;
#include scripts\mp_common\player\player_utils;

#namespace display_transition;

init_shared() {
  registerclientfields();
  function_7e74281();
}

private registerclientfields() {
  if(sessionmodeiswarzonegame()) {
    clientfield::register("clientuimodel", "eliminated_postfx", 12000, 1, "int");
  }
}

private function_a5ce91f1(val) {
  if(sessionmodeiswarzonegame()) {
    self clientfield::set_player_uimodel("eliminated_postfx", val);
  }
}

function_81d670f5() {
  if(isDefined(level.var_d1455682)) {
    if(!isDefined(level.var_d1455682.finaldisplaytransition) || level.var_d1455682.finaldisplaytransition.size == 0) {
      return false;
    }
  }

  return true;
}

private function_b8e20f5f(transition, outcome, feature_enabled, feature_time, func) {
  if(isDefined(feature_enabled) && feature_enabled) {
    if((isDefined(feature_time) ? feature_time : 0) != 0) {
      wait float(feature_time) / 1000;
    }

    [[func]](transition, outcome);
  }
}

function_e6b4f2f7(outcome) {
  function_76f27db3(outcome.var_c1e98979, outcome::function_2e00fa44(outcome), outcome.platoon, outcome.team, outcome.players);
}

function_12d1f62a(outcome) {
  function_2fa975e0(util::getroundsplayed(), outcome.var_c1e98979, outcome::function_2e00fa44(outcome), outcome.platoon, outcome.team, outcome.players);
}

function_19adc0b7(outcome) {
  player::function_2f80d95b(&function_3f65d5d3);
  function_e6b4f2f7(outcome);
  array::run_all(level.players, &hud_message::can_bg_draw, outcome);
  function_15e28b1a(outcome);
  globallogic::function_452e18ad();
  array::run_all(level.players, &hud_message::hide_outcome);
}

display_round_end(outcome) {
  player::function_2f80d95b(&function_3f65d5d3);
  player::function_2f80d95b(&function_3cfb29e1);
  function_12d1f62a(outcome);
  function_cf3d556b(outcome);
  globallogic::function_452e18ad();
  array::run_all(level.players, &hud_message::hide_outcome);
}

private function_91b514e8(menuname) {
  player = self;
  player endon(#"disconnect");

  while(true) {
    waitresult = player waittill(#"menuresponse");
    menu = waitresult.menu;
    response = waitresult.response;

    if(isDefined(menuname)) {
      if(menu == menuname) {
        return;
      }

      continue;
    }

    if(menu == "GameEndScore") {
      return;
    }
  }
}

function_61d01718(transitions, lui_event) {
  player = self;
  player endon(#"disconnect");

  foreach(index, transition in transitions) {
    player function_b797319e(lui_event, index + 1);

    if((isDefined(transition.time) ? transition.time : 0) != 0) {
      round_end_wait(float(transition.time) / 1000);
      continue;
    }

    if((isDefined(transition.var_bda115b5) ? transition.var_bda115b5 : 0) != 0) {
      self function_a5ce91f1(1);
      self thread function_c6f81aa1(float(transition.var_f4df0630) / 1000);
      player function_91b514e8(transition.menuresponse);
      self function_a5ce91f1(0);
      continue;
    }

    player function_91b514e8(transition.menuresponse);
  }
}

function_c6f81aa1(time) {
  if(!isDefined(time)) {
    return;
  }

  player = self;
  player endon(#"disconnect", #"spawned");
  player.var_686890d5 = 1;

  if(time <= 0) {
    time = 0.1;
  }

  wait time;

  if(!isDefined(player)) {
    return;
  }

  player.var_686890d5 = undefined;
  player.sessionstate = "spectator";
  player.spectatorclient = -1;
  player.killcamentity = -1;
  player.archivetime = 0;
  player.psoffsettime = 0;
  player.spectatekillcam = 0;
}

function_9b2bd02c() {
  player = self;
  player function_3f65d5d3();
  player function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"elimination_transition");
}

function_b3964dc9() {

  if(getdvarint(#"scr_disable_infiltration", 0)) {
    return;
  }

    if(isDefined(level.var_a4c48e88) && level.var_a4c48e88) {
      return;
    }

  player = self;
  player function_3f65d5d3();
  player function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"hash_ee32e40c182320b");
}

function_f4c03c3b() {
  if(isDefined(self.var_58f00ca2) && self.var_58f00ca2) {
    return;
  }

  self.var_58f00ca2 = 1;
  self thread function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"hash_4a3306cfce6719bc");
}

function_1caf5c87(team) {
  players = getplayers(team);
  player::function_4dcd9a89(players, &function_3f65d5d3);

  foreach(player in players) {
    if(player != self) {
      player.var_58f00ca2 = 1;
      player thread function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"hash_4a3306cfce6719bc");
    }
  }

  if(self.team == team) {
    self.var_58f00ca2 = 1;
    self function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"hash_4a3306cfce6719bc");
  }
}

function_3f65d5d3() {
  if(!isDefined(self.pers[#"team"])) {
    self[[level.spawnintermission]](1);
    return true;
  }

  return false;
}

function_3cfb29e1() {
  if(!util::waslastround()) {
    self playlocalsound(#"hash_7353399f9153966f");
    self thread globallogic_audio::set_music_on_player("none");

    if(isDefined(self.pers[#"music"].spawn)) {
      self.pers[#"music"].spawn = 0;
    }
  }
}

private freeze_player_for_round_end() {
  self player::freeze_player_for_round_end();
  self thread globallogic::roundenddof();
}

private function_ba94df6c() {
  self setclientuivisibilityflag("hud_visible", 0);
  self thread[[level.spawnintermission]](0);
}

function_9185f489(transition, outcome) {
  globallogic::function_2556afb5(transition.var_20c0730c, transition.var_18d4b2ad, float(transition.var_3efb751d) / 1000);
}

private function_e22f5208(transition, outcome) {
  player::function_2f80d95b(&function_ba94df6c);
}

private function_a3b4d41d(transition, outcome) {
  player::function_2f80d95b(&freeze_player_for_round_end);
}

private function_654c0030(transition, outcome) {
  player::function_2f80d95b(&function_d7b5082e);
  thread globallogic_audio::announce_game_winner(outcome);
  player::function_2f80d95b(&globallogic_audio::function_6374b97e, outcome::get_flag(outcome, "tie"));
}

private function_d9d842b2(transition, outcome) {
  thread globallogic_audio::function_57678746(outcome);
}

private function_b7fec738(transition, outcome) {
  thread globallogic_audio::announce_round_winner(0);
}

private function_66713ac(transition, outcome) {
  thread globallogic_audio::function_5e0a6842();
}

private function_8feabee3(transition, outcome) {
  thread globallogic_audio::function_dfd17bd3();
}

private function_26bbb839(transition, outcome) {
  thread function_b8e20f5f(transition, outcome, transition.slowdown, transition.var_d7f20c92, &function_9185f489);
  thread function_b8e20f5f(transition, outcome, transition.freezeplayers, transition.freezetime, &function_a3b4d41d);
  thread function_b8e20f5f(transition, outcome, transition.var_b0bc6ae0, transition.var_8d7c57a2, &function_8feabee3);
  thread function_b8e20f5f(transition, outcome, transition.var_619875ca, transition.var_73f860db, &function_b7fec738);
  thread function_b8e20f5f(transition, outcome, transition.var_7a712c7, transition.var_a803fe51, &function_66713ac);
  thread function_b8e20f5f(transition, outcome, transition.var_93a95648, transition.var_de820e2d, &function_654c0030);
  thread function_b8e20f5f(transition, outcome, transition.var_f9995c63, transition.var_41fc87a8, &function_d9d842b2);
  thread function_b8e20f5f(transition, outcome, transition.pickup_message, transition.var_5026a297, &function_e22f5208);
}

checkroundswitch() {
  if(!isDefined(level.roundswitch) || !level.roundswitch) {
    return false;
  }

  if(!isDefined(level.onroundswitch)) {
    return false;
  }

  assert(game.roundsplayed > 0);

  if(game.roundsplayed % level.roundswitch == 0) {
    [[level.onroundswitch]]();
    return true;
  }

  return false;
}

private function_e3855f6d(transition, outcome) {
  if(util::waslastround()) {
    return;
  }

  if(!(isDefined(level.var_3e7c197f) && level.var_3e7c197f) && !checkroundswitch()) {
    return;
  }

  level.var_3e7c197f = 1;
  function_26bbb839(transition, outcome);
}

private function_a2d39e40(transition, outcome) {
  globallogic::function_452e18ad();
  array::run_all(level.players, &hud_message::hide_outcome);
  killcam::post_round_final_killcam();
}

private function_e3442abc(transition, outcome) {
  globallogic::function_452e18ad();
  array::run_all(level.players, &hud_message::hide_outcome);
  potm::post_round_potm();
}

private function_aed7dbe1(p1, p2) {
  if(p1.score != p2.score) {
    return (p1.score > p2.score);
  }

  return p1 getentitynumber() <= p2 getentitynumber();
}

private function_e17d407e(transition, outcome) {
  var_77d0878c = array();

  foreach(player in level.players) {
    if(player.team == outcome.team && player player_role::get() != 0) {
      array::add(var_77d0878c, player);
    }
  }

  player_positions = array();

  for(i = 0;; i++) {
    pos = struct::get("team_pose_" + i, "targetname");

    if(isDefined(pos)) {
      array::add(player_positions, pos);
      continue;
    }

    break;
  }

  var_5a552ef6 = struct::get("team_pose_cam", "targetname");

  if(var_77d0878c.size == 0 || player_positions.size == 0 || !isDefined(var_5a552ef6)) {
    return;
  }

  function_26bbb839(transition, outcome);
  var_77d0878c = array::quick_sort(var_77d0878c, &function_aed7dbe1);

  for(i = 0; i < min(var_77d0878c.size, player_positions.size); i++) {
    player = var_77d0878c[i];
    player.sessionstate = "playing";
    player takeallweapons();
    fields = getcharacterfields(player player_role::get(), currentsessionmode());

    if(i == 0) {
      player_positions[i] thread scene::play(fields.heroicscenes[0].scene, player);
      continue;
    }

    player_positions[i] thread scene::play(fields.heroicposes[0].scene, player);
  }

  var_5a552ef6 thread scene::play("team_pose_cam");
}

function_b3214a0a(transition, outcome, next_transition) {
  if(isDefined(next_transition)) {
    if(next_transition.type == "play_of_the_match") {
      level waittill(#"hash_4ead2cd3fa59f29b");
    }

    var_5a552ef6 = struct::get("team_pose_cam", "targetname");
    var_5a552ef6 thread scene::stop("team_pose_cam");
  }
}

function_7e74281() {
  level.var_3a309902[#"blank"] = &function_26bbb839;
  level.var_3a309902[#"outcome"] = &function_26bbb839;
  level.var_3a309902[#"outcome_with_score"] = &function_26bbb839;
  level.var_3a309902[#"outcome_with_time"] = &function_26bbb839;
  level.var_3a309902[#"switch_sides"] = &function_e3855f6d;
  level.var_3a309902[#"final_killcam"] = &function_a2d39e40;
  level.var_3a309902[#"play_of_the_match"] = &function_e3442abc;
  level.var_3a309902[#"team_pose"] = &function_e17d407e;
  level.var_3a309902[#"high_value_operatives"] = &function_26bbb839;
  level.var_5d720398[#"team_pose"] = &function_b3214a0a;
}

function_b797319e(transition_type, transition_index) {
  self luinotifyevent(transition_type, 1, transition_index);
}

function_752a920f() {
  self luinotifyevent(#"clear_transition");
}

function_d7b5082e() {
  if(isDefined(self.pers[#"totalmatchbonus"])) {
    self luinotifyevent(#"hash_9dfc8d44ea4547e", 1, self.pers[#"totalmatchbonus"]);
  }
}

display_transition(transition, transition_index, outcome, lui_event) {
  level thread globallogic::sndsetmatchsnapshot(2);
  player::function_e7f18b20(&function_b797319e, lui_event, transition_index + 1);
  [[level.var_3a309902[transition.type]]](transition, outcome);
}

shutdown_transition(transition, outcome, next_transition) {
  if(isDefined(level.var_5d720398[transition.type])) {
    level thread[[level.var_5d720398[transition.type]]](transition, outcome, next_transition);
  }
}

clear_transition() {
  player::function_2f80d95b(&function_752a920f);
  array::run_all(level.players, &hud_message::hide_outcome);
}

function_40a46b5b(transition, outcome) {
  if(isDefined(transition.disable) && transition.disable) {
    return true;
  }

  if(isDefined(transition.var_b5dabc6b) && transition.var_b5dabc6b) {
    if(util::waslastround() || util::isoneround()) {
      return true;
    }
  }

  var_860cd9fa = isDefined(level.shouldplayovertimeround) && [[level.shouldplayovertimeround]]();

  if(isDefined(level.shouldplayovertimeround) && [[level.shouldplayovertimeround]]()) {
    if(isDefined(transition.var_d0f2da62) && transition.var_d0f2da62) {
      return true;
    }
  } else if(isDefined(transition.var_fb87c2b4) && transition.var_fb87c2b4) {
    return true;
  }

  if(overtime::is_overtime_round()) {
    if(isDefined(transition.var_e0d86f3) && transition.var_e0d86f3) {
      return true;
    }
  } else if(isDefined(transition.var_7b778818) && transition.var_7b778818) {
    return true;
  }

  if(transition.type == "team_pose") {
    if(outcome.team == #"free") {
      return true;
    }

    if(!isDefined(struct::get("team_pose_cam", "targetname"))) {
      return true;
    }
  }

  if(transition.type == "switch_sides") {
    if(!(isDefined(level.roundswitch) && level.roundswitch)) {
      return true;
    }
  }

  if(transition.type == "outcome") {
    if(isDefined(level.skip_outcome) && level.skip_outcome) {
      return true;
    }
  }

  return false;
}

function_7e8f8c47(transitions, outcome, lui_event) {
  foreach(index, transition in transitions) {
    if(function_40a46b5b(transition, outcome)) {
      continue;
    }

    level notify(#"display_transition", index);
    display_transition(transition, index, outcome, lui_event);

    if((isDefined(transition.time) ? transition.time : 0) != 0) {
      round_end_wait(float(transition.time) / 1000);
    }

    shutdown_transition(transition, outcome, transitions[index + 1]);
  }

  clear_transition();
}

function_15e28b1a(outcome) {
  function_7e8f8c47(level.var_d1455682.finaldisplaytransition, outcome, #"match_transition");
}

function_cf3d556b(outcome) {
  if(isDefined(level.var_d1455682.var_e779605d) && level.var_d1455682.var_e779605d) {
    if(util::waslastround() || util::isoneround()) {
      return;
    }
  }

  transitions = level.var_d1455682.rounddisplaytransition;

  if(!isDefined(transitions)) {
    return;
  }

  function_7e8f8c47(transitions, outcome, #"round_transition");
}

round_end_wait(time) {
  if(time <= 0) {
    return;
  }

  level waittilltimeout(time * level.var_49d9aa70, #"hash_197c640e2f684a74");
}

function_ad717b18(var_c139bfe2) {
  assert(isDefined(level.roundenddelay[var_c139bfe2]));
  delay = level.roundenddelay[var_c139bfe2] * level.var_49d9aa70;

  if(delay) {
    return;
  }

  var_f05b8779 = delay / 2;

  if(var_f05b8779 > 0) {
    wait var_f05b8779;
    var_f05b8779 = delay / 2;
  } else {
    var_f05b8779 = delay / 2 + var_f05b8779;
  }

  level notify(#"give_match_bonus");

  if(var_f05b8779 > 0) {
    wait var_f05b8779;
  }
}