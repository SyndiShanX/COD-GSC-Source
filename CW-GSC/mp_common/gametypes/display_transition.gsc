/******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\display_transition.gsc
******************************************************/

#using script_39003d7a41f33078;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\player\player_utils;
#namespace display_transition;

function init_shared() {
  registerclientfields();
  function_7e74281();
}

function private registerclientfields() {
  if(sessionmodeiswarzonegame()) {
    clientfield::register("toplayer", "eliminated_postfx", 12000, 1, "int");
  }

  if(sessionmodeismultiplayergame()) {
    clientfield::register("world", "top_squad_begin", 1, 1, "int");
    clientfield::register("world", "hero_pose_begin", 1, 1, "int");
  }
}

function private function_a5ce91f1(val) {
  if(sessionmodeiswarzonegame()) {
    self clientfield::set_to_player("eliminated_postfx", val);
  }
}

function function_81d670f5() {
  if(isDefined(level.var_d1455682)) {
    if(!isDefined(level.var_d1455682.finaldisplaytransition) || level.var_d1455682.finaldisplaytransition.size == 0) {
      return false;
    }
  }

  return true;
}

function private function_b8e20f5f(transition, outcome, feature_enabled, feature_time, func) {
  if(is_true(feature_enabled)) {
    if((isDefined(feature_time) ? feature_time : 0) != 0) {
      wait float(feature_time) / 1000;
    }

    [[func]](transition, outcome);
  }
}

function function_e6b4f2f7(outcome) {
  function_76f27db3(outcome.var_c1e98979, outcome::function_2e00fa44(outcome), #"none", outcome.team, outcome.players);
}

function function_12d1f62a(outcome) {
  function_2fa975e0(util::getroundsplayed(), outcome.var_c1e98979, outcome::function_2e00fa44(outcome), #"none", outcome.team, outcome.players);
}

function function_19adc0b7(outcome) {
  thread globallogic_audio::function_91d557d3(outcome);
  player::function_2f80d95b(&function_3f65d5d3);
  function_e6b4f2f7(outcome);
  array::run_all(level.players, &hud_message::can_bg_draw, outcome);
  function_15e28b1a(outcome);
  globallogic::function_452e18ad();
  array::run_all(level.players, &hud_message::hide_outcome);
}

function function_73d36f61(outcome) {
  level thread globallogic_audio::set_music_global("matchend");
}

function display_round_end(outcome) {
  player::function_2f80d95b(&function_3f65d5d3);
  function_12d1f62a(outcome);

  if(!util::waslastround()) {
    level thread function_ee8c4421();
  }

  function_cf3d556b(outcome);

  if(!util::waslastround()) {
    clear_transition();
  }

  globallogic::function_452e18ad();
}

function function_ee8c4421() {
  if(isDefined(level.var_6561b05c)) {
    level thread[[level.var_6561b05c]]();
    return;
  }

  level thread globallogic_audio::set_music_global("roundend_start");
}

function private function_91b514e8(menuname) {
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

    if(menu == "GameEndScoreMenu") {
      return;
    }
  }
}

function function_61d01718(transitions, lui_event) {
  if(!isDefined(transitions)) {
    return;
  }

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

function function_c6f81aa1(time) {
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

function function_9b2bd02c() {
  player = self;
  player function_3f65d5d3();
  player function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"elimination_transition");
}

function function_b3964dc9() {
  display = is_true(level.var_3e5fe4d1);

  if(!is_true(level.var_3e5fe4d1)) {
    return;
  }

  player = self;
  player function_3f65d5d3();
  player function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"hash_ee32e40c182320b");
}

function function_f4c03c3b() {
  if(is_true(self.var_58f00ca2)) {
    return;
  }

  self.var_58f00ca2 = 1;
  self thread function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"hash_4a3306cfce6719bc");
}

function function_1caf5c87(team) {
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

function function_3f65d5d3() {
  if(!isDefined(self.pers[#"team"])) {
    self[[level.spawnintermission]](1);
    return true;
  }

  return false;
}

function private freeze_player_for_round_end() {
  self player::freeze_player_for_round_end();
  self thread globallogic::roundenddof();
}

function private function_ba94df6c() {
  self setclientuivisibilityflag("hud_visible", 0);
  self thread[[level.spawnintermission]](0);
}

function function_9185f489(transition, outcome) {
  globallogic::function_2556afb5(outcome.var_20c0730c, outcome.var_18d4b2ad, float(outcome.var_3efb751d) / 1000);
}

function private function_e22f5208(transition, outcome) {
  var_9914886a = 0;

  foreach(player in level.players) {
    if(isDefined(player getlinkedent())) {
      player unlink();
      var_9914886a = 1;
    }
  }

  if(var_9914886a) {
    waitframe(1);
  }

  clearplayercorpses();
  player::function_2f80d95b(&function_ba94df6c);
}

function private function_a3b4d41d(transition, outcome) {
  player::function_2f80d95b(&freeze_player_for_round_end);
}

function private function_654c0030(transition, outcome) {
  player::function_2f80d95b(&function_d7b5082e);
  thread globallogic_audio::announce_game_winner(outcome);
}

function private function_d9d842b2(transition, outcome) {
  thread globallogic_audio::function_57678746(outcome);
}

function private function_b7fec738(transition, outcome) {
  thread globallogic_audio::announce_round_winner(0);
}

function private function_66713ac(transition, outcome) {
  thread globallogic_audio::function_5e0a6842();
}

function private function_8feabee3(transition, outcome) {
  thread globallogic_audio::function_dfd17bd3();
}

function private function_a3c90acf(transition, outcome) {
  thread globallogic_audio::function_1f89b047();
}

function private function_26bbb839(transition, outcome) {
  thread function_b8e20f5f(transition, outcome, transition.slowdown, transition.var_d7f20c92, &function_9185f489);
  thread function_b8e20f5f(transition, outcome, transition.freezeplayers, transition.freezetime, &function_a3b4d41d);
  thread function_b8e20f5f(transition, outcome, transition.var_b0bc6ae0, transition.var_8d7c57a2, &function_8feabee3);
  thread function_b8e20f5f(transition, outcome, transition.var_738bf790, transition.var_8dc11094, &function_a3c90acf);
  thread function_b8e20f5f(transition, outcome, transition.var_619875ca, transition.var_73f860db, &function_b7fec738);
  thread function_b8e20f5f(transition, outcome, transition.var_7a712c7, transition.var_a803fe51, &function_66713ac);
  thread function_b8e20f5f(transition, outcome, transition.var_93a95648, transition.var_de820e2d, &function_654c0030);
  thread function_b8e20f5f(transition, outcome, transition.var_f9995c63, transition.var_41fc87a8, &function_d9d842b2);
  thread function_b8e20f5f(transition, outcome, transition.pickup_message, transition.var_5026a297, &function_e22f5208);
}

function checkroundswitch() {
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

function private function_e3855f6d(transition, outcome) {
  if(util::waslastround()) {
    return;
  }

  if(!is_true(level.var_3e7c197f) && !checkroundswitch()) {
    return;
  }

  level.var_3e7c197f = 1;
  function_26bbb839(transition, outcome);
}

function private function_a2d39e40(transition, outcome) {
  globallogic::function_452e18ad();
  killcam::post_round_final_killcam();
}

function private function_e3442abc(transition, outcome) {
  globallogic::function_452e18ad();
  potm::post_round_potm();
}

function private function_4029edc0(transition, outcome) {
  globallogic::function_452e18ad();

  if(outcome.var_c1e98979 == 6) {
    killcam::post_round_final_killcam();
    return;
  }

  potm::post_round_potm();
}

function private function_7285f7e1(e1, e2, b_lowest_first = 0) {
  if(b_lowest_first) {
    return (e1.score <= e2.score);
  }

  return e1.score > e2.score;
}

function private function_6b33e951() {
  var_9a829482 = 6;
  winning_team = match::get_winning_team();

  if(winning_team == # "none") {
    winning_team = # "allies";
  }

  winners = getplayers(winning_team);
  winners = array::merge_sort(winners, &function_7285f7e1, 0);
  var_860af94a = array();

  for(i = 0; i < var_9a829482; i++) {
    client_num = isDefined(winners[i]) ? winners[i].entnum : -1;
    array::add(var_860af94a, client_num);
  }

  luinotifyevent(#"top_squad", var_9a829482, var_860af94a[0], var_860af94a[1], var_860af94a[2], var_860af94a[3], var_860af94a[4], var_860af94a[5]);
}

function private function_87a832a5(transition, outcome) {
  if(sessionmodeismultiplayergame()) {}

  function_26bbb839(transition, outcome);
}

function private function_721d8d6e(transition, outcome) {
  globallogic::function_452e18ad();
  level clientfield::set("top_squad_begin", 1);
}

function private function_51bb7ed5(transition, outcome) {
  globallogic::function_452e18ad();

  if(sessionmodeiswarzonegame()) {
    namespace_98521e8b::function_d6b2318a();
    return;
  }

  namespace_98521e8b::function_f7961c39();
}

function private function_8d0112e9(transition, outcome) {
  namespace_98521e8b::function_364bc19c(outcome);

  if(!sessionmodeiswarzonegame()) {
    namespace_98521e8b::function_29597300();
  }
}

function private function_e794b637(transition, outcome) {
  globallogic::function_452e18ad();
  wait 1;
  level clientfield::set("hero_pose_begin", 1);
  wait 10;
}

function function_7e74281() {
  level.var_3a309902[#"blank"] = &function_26bbb839;
  level.var_3a309902[#"outcome"] = &function_87a832a5;
  level.var_3a309902[#"outcome_with_score"] = &function_26bbb839;
  level.var_3a309902[#"outcome_with_time"] = &function_26bbb839;
  level.var_3a309902[#"switch_sides"] = &function_e3855f6d;
  level.var_3a309902[#"final_killcam"] = &function_a2d39e40;
  level.var_3a309902[#"play_of_the_match"] = &function_e3442abc;
  level.var_3a309902[#"hash_7367d8ab0bb7068b"] = &function_4029edc0;
  level.var_3a309902[#"high_value_operatives"] = &function_26bbb839;
  level.var_3a309902[#"top_squad"] = &function_721d8d6e;
  level.var_3a309902[#"hero_pose"] = &function_e794b637;
  level.var_3a309902[#"exit_cinematic"] = &function_51bb7ed5;
  level.var_7e74281[#"exit_cinematic"] = &function_8d0112e9;
}

function function_b797319e(transition_type, transition_index) {
  self luinotifyevent(transition_type, 1, transition_index);
}

function function_752a920f() {
  self luinotifyevent(#"clear_transition");
}

function function_d7b5082e() {
  if(isDefined(self.pers[#"totalmatchbonus"])) {
    self luinotifyevent(#"hash_9dfc8d44ea4547e", 1, self.pers[#"totalmatchbonus"]);
  }
}

function display_transition(transition, transition_index, outcome, lui_event) {
  player::function_e7f18b20(&function_b797319e, lui_event, transition_index + 1);
  [[level.var_3a309902[transition.type]]](transition, outcome);
}

function init_transition(transition, transition_index, outcome) {
  if(isDefined(level.var_7e74281[transition_index.type])) {
    [[level.var_7e74281[transition_index.type]]](transition_index, outcome);
  }
}

function shutdown_transition(transition, outcome, next_transition) {
  if(isDefined(level.var_5d720398[transition.type])) {
    level thread[[level.var_5d720398[transition.type]]](transition, outcome, next_transition);
  }
}

function clear_transition() {
  player::function_2f80d95b(&function_752a920f);
  array::run_all(level.players, &hud_message::hide_outcome);
}

function function_40a46b5b(transition, outcome) {
  if(is_true(transition.disable)) {
    return true;
  }

  if(is_true(transition.var_b5dabc6b)) {
    if(util::waslastround() || util::isoneround()) {
      return true;
    }
  }

  var_860cd9fa = isDefined(level.shouldplayovertimeround) && [[level.shouldplayovertimeround]]();

  if(isDefined(level.shouldplayovertimeround) && [[level.shouldplayovertimeround]]()) {
    if(is_true(transition.var_d0f2da62)) {
      return true;
    }
  } else if(is_true(transition.var_fb87c2b4)) {
    return true;
  }

  if(overtime::is_overtime_round()) {
    if(is_true(transition.var_e0d86f3)) {
      return true;
    }
  } else if(is_true(transition.var_7b778818)) {
    return true;
  }

  if(transition.type == "team_pose") {
    if(outcome.team == # "none") {
      return true;
    }

    if(!isDefined(struct::get("team_pose_cam", "targetname"))) {
      return true;
    }
  }

  if(transition.type == "switch_sides") {
    if(!is_true(level.roundswitch)) {
      return true;
    }
  }

  if(transition.type == "outcome") {
    if(is_true(level.skip_outcome)) {
      return true;
    }
  }

  return false;
}

function function_7e8f8c47(transitions, outcome, lui_event) {
  foreach(index, transition in transitions) {
    if(function_40a46b5b(transition, outcome)) {
      continue;
    }

    init_transition(transition, index, outcome);
  }

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
}

function function_15e28b1a(outcome) {
  function_7e8f8c47(level.var_d1455682.finaldisplaytransition, outcome, #"match_transition");
}

function function_cf3d556b(outcome) {
  if(is_true(level.var_d1455682.var_e779605d)) {
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

function round_end_wait(time) {
  if(time <= 0) {
    return;
  }

  level waittilltimeout(time * level.var_49d9aa70, #"hash_197c640e2f684a74");
}

function function_ad717b18(var_c139bfe2) {
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