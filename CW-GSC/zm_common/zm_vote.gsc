/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_vote.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\popups_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\zm_utility;
#namespace zm_vote;

function init() {
  clientfield::register_clientuimodel("sr_vote_prompt.numPlayersNeeded", 1, 2, "int", 0);
  clientfield::register_clientuimodel("sr_vote_prompt.show", 1, 3, "int", 0);
  clientfield::register_clientuimodel("sr_vote_prompt.starter", 1, 7, "int", 0);
  clientfield::register_clientuimodel("sr_vote_prompt.status", 1, 2, "int", 0);
}

function function_c65468ef(var_2d1ee75a, var_ac9c0ee1, var_f965fa7, var_556c090f = 0) {
  if(is_true(level.var_6f754d87)) {
    return 0;
  }

  a_e_players = function_a1ef346b();
  arrayremovevalue(a_e_players, var_2d1ee75a);
  b_debug = 0;

  b_debug = getdvarint(#"hash_23982855c95ec06", 0) > 0;

  if(a_e_players.size > 0 || b_debug) {
    level.var_6f754d87 = 1;

    if(isDefined(level.var_1ea1d494)) {
      level.var_1ea1d494 sethintstring("");
    }

    var_8b9e1fe4 = spawnStruct();
    var_8b9e1fe4.var_2d1ee75a = var_2d1ee75a;
    var_8b9e1fe4.var_96d8430e = [];
    var_8b9e1fe4.var_e6ae7b0 = [];
    var_8b9e1fe4.var_ac9c0ee1 = var_ac9c0ee1;
    var_8b9e1fe4.var_f965fa7 = var_f965fa7;
    level.var_c5beea37 = var_8b9e1fe4;
    callback::on_spawned(&function_287ce935);
    callback::on_disconnect(&function_3728d19b);

    if(!b_debug) {
      var_2d1ee75a thread function_287ce935(var_8b9e1fe4, 1);
    } else {
      a_e_players = getplayers();
    }

    foreach(e_player in a_e_players) {
      e_player thread function_287ce935(var_8b9e1fe4);
    }

    var_8b9e1fe4 thread function_e7c57e4();
    b_passed = var_8b9e1fe4 function_4b4f57db(var_556c090f);
    level.var_6f754d87 = 0;

    if(is_true(b_passed)) {
      var_8b9e1fe4 notify(#"vote_passed");
    } else {
      b_passed = 0;

      if(isDefined(level.var_1ea1d494)) {
        level.var_1ea1d494 sethintstring(level.var_1ea1d494.var_9d7362a4);
      }

      level thread popups::displayteammessagetoall(var_f965fa7, var_2d1ee75a);
    }

    callback::remove_on_spawned(&function_287ce935);
    callback::remove_on_disconnect(&function_3728d19b);

    foreach(e_player in getplayers()) {
      e_player clientfield::set_player_uimodel("sr_vote_prompt.show", 0);
    }

    level.var_c5beea37 = undefined;
    var_8b9e1fe4 struct::delete();
  } else {
    b_passed = 1;
  }

  return b_passed;
}

function function_4b4f57db(var_556c090f = 0) {
  self endon(#"vote_canceled");

  while(true) {
    var_d46eae05 = 0;

    foreach(player in function_a1ef346b()) {
      if(!zm_utility::function_1a01f2f7(player)) {
        var_d46eae05++;
      }
    }

    switch (var_d46eae05) {
      case 2:
        var_33a40292 = 2;
        break;
      case 3:
        var_33a40292 = 2;
        break;
      case 4:
        var_33a40292 = 3;
        break;
      case 5:
        var_33a40292 = 3;
        break;
      default:
        var_33a40292 = 1;
        break;
    }

    if(var_556c090f) {
      var_33a40292 = var_d46eae05;
    }

    function_1eaaceab(self.var_96d8430e);
    function_1eaaceab(self.var_e6ae7b0);
    var_162efdd8 = var_33a40292 - self.var_96d8430e.size;

    foreach(player in getplayers()) {
      player clientfield::set_player_uimodel("sr_vote_prompt.numPlayersNeeded", math::clamp(var_162efdd8, 0, var_d46eae05));
    }

    if(var_162efdd8 <= 0) {
      wait 0.5;
      return 1;
    } else if(self.var_96d8430e.size + self.var_e6ae7b0.size >= var_d46eae05) {
      wait 0.5;
      return 0;
    }

    waitframe(1);
  }
}

function function_e7c57e4() {
  self endon(#"delete", #"death", #"vote_passed", #"vote_canceled");
  wait 30;
  self notify(#"vote_canceled");
}

function function_287ce935(var_8b9e1fe4, var_e058812d = 0) {
  var_8b9e1fe4 = isDefined(var_8b9e1fe4) ? var_8b9e1fe4 : level.var_c5beea37;

  if(!isDefined(var_8b9e1fe4)) {
    return;
  }

  if(!isPlayer(var_8b9e1fe4.var_2d1ee75a)) {
    return;
  }

  self notify("1b72edef6a8e42ef");
  self endon("1b72edef6a8e42ef");
  var_8b9e1fe4 endon(#"vote_passed", #"vote_canceled");
  self endon(#"death");
  self clientfield::set_player_uimodel("sr_vote_prompt.starter", var_8b9e1fe4.var_2d1ee75a getentitynumber());
  var_f4f8379d = 0;

  if(var_e058812d || isbot(self)) {
    var_f4f8379d = 1;
  }

  self clientfield::set_player_uimodel("sr_vote_prompt.status", var_f4f8379d);
  self clientfield::set_player_uimodel("sr_vote_prompt.show", var_8b9e1fe4.var_ac9c0ee1);

  while(var_f4f8379d == 0) {
    waitresult = self waittill(#"menuresponse");
    response = waitresult.response;

    if(response === # "hash_4555ff5843fd0c43") {
      var_f4f8379d = 1;
      self clientfield::set_player_uimodel("sr_vote_prompt.status", var_f4f8379d);
      continue;
    }

    if(response === # "hash_690c429815dfb9dc") {
      var_f4f8379d = 2;
      self clientfield::set_player_uimodel("sr_vote_prompt.status", var_f4f8379d);
    }
  }

  if(var_f4f8379d === 1) {
    if(!isDefined(var_8b9e1fe4.var_96d8430e)) {
      var_8b9e1fe4.var_96d8430e = [];
    } else if(!isarray(var_8b9e1fe4.var_96d8430e)) {
      var_8b9e1fe4.var_96d8430e = array(var_8b9e1fe4.var_96d8430e);
    }

    if(!isinarray(var_8b9e1fe4.var_96d8430e, self)) {
      var_8b9e1fe4.var_96d8430e[var_8b9e1fe4.var_96d8430e.size] = self;
    }

    return;
  }

  if(var_f4f8379d === 2) {
    if(!isDefined(var_8b9e1fe4.var_e6ae7b0)) {
      var_8b9e1fe4.var_e6ae7b0 = [];
    } else if(!isarray(var_8b9e1fe4.var_e6ae7b0)) {
      var_8b9e1fe4.var_e6ae7b0 = array(var_8b9e1fe4.var_e6ae7b0);
    }

    if(!isinarray(var_8b9e1fe4.var_e6ae7b0, self)) {
      var_8b9e1fe4.var_e6ae7b0[var_8b9e1fe4.var_e6ae7b0.size] = self;
    }
  }
}

function function_3728d19b() {
  if(isDefined(level.var_c5beea37)) {
    var_8b9e1fe4 = level.var_c5beea37;
    var_8b9e1fe4 notify(#"vote_canceled");
  }
}