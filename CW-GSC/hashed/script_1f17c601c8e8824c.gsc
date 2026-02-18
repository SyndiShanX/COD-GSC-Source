/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1f17c601c8e8824c.gsc
***********************************************/

#using script_396f7d71538c9677;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapon_utils;
#namespace battlechatter;

function devgui_think() {
  setDvar(#"devgui_mpdialog", "<dev string:x38>");
  setDvar(#"testalias_player", "<dev string:x3c>");
  setDvar(#"testalias_taacom", "<dev string:x5a>");
  setDvar(#"testalias_commander", "<dev string:x77>");

  while(true) {
    wait 1;
    player = util::gethostplayer();

    if(!isDefined(player)) {
      continue;
    }

    spacing = getdvarfloat(#"testdialog_spacing", 0.25);

    switch (getdvarstring(#"devgui_mpdialog", "<dev string:x38>")) {
      case # "hash_7912e80189f9c6":
        player thread test_player_dialog(0);
        player thread test_taacom_dialog(spacing);
        player thread test_commander_dialog(2 * spacing);
        break;
      case # "hash_69c6be086f76a9d4":
        player thread test_player_dialog(0);
        player thread test_commander_dialog(spacing);
        break;
      case # "hash_3af5f0a904b3f8fa":
        player thread test_other_dialog(0);
        player thread test_commander_dialog(spacing);
        break;
      case # "hash_32945da5f7ac491":
        player thread test_taacom_dialog(0);
        player thread test_commander_dialog(spacing);
        break;
      case # "hash_597b27a5c8857d19":
        player thread test_player_dialog(0);
        player thread test_taacom_dialog(spacing);
        break;
      case # "hash_74f798193af006b3":
        player thread test_other_dialog(0);
        player thread test_taacom_dialog(spacing);
        break;
      case # "hash_5bd6a2c5d0ff3cb2":
        player thread test_other_dialog(0);
        player thread test_player_dialog(spacing);
        break;
      case # "hash_4a5a66c89be92eb":
        player thread play_conv_self_other();
        break;
      case # "hash_18683ef7652f40ed":
        player thread play_conv_other_self();
        break;
      case # "hash_2b559b1a5e81715f":
        player thread play_conv_other_other();
        break;
    }

    setDvar(#"devgui_mpdialog", "<dev string:x38>");
  }
}

function test_other_dialog(delay) {
  players = arraysort(level.players, self.origin);

  foreach(player in players) {
    if(player != self && isalive(player)) {
      player thread test_player_dialog(delay);
      return;
    }
  }
}

function test_player_dialog(delay) {
  if(!isDefined(delay)) {
    delay = 0;
  }

  wait delay;
  self playsoundontag(getdvarstring(#"testalias_player", "<dev string:x38>"), "<dev string:x9b>");
}

function test_taacom_dialog(delay) {
  if(!isDefined(delay)) {
    delay = 0;
  }

  wait delay;
  self playlocalsound(getdvarstring(#"testalias_taacom", "<dev string:x38>"));
}

function test_commander_dialog(delay) {
  if(!isDefined(delay)) {
    delay = 0;
  }

  wait delay;
  self playlocalsound(getdvarstring(#"testalias_commander", "<dev string:x38>"));
}

function play_test_dialog(dialogkey) {
  dialogalias = self get_player_dialog_alias(dialogkey, undefined);
  self playsoundontag(dialogalias, "<dev string:x9b>");
}

function response_key() {
  switch (self getmpdialogname()) {
    case # "spectre":
      return "<dev string:xa5>";
    case # "battery":
      return "<dev string:xb0>";
    case # "outrider":
      return "<dev string:xbb>";
    case # "prophet":
      return "<dev string:xc7>";
    case # "firebreak":
      return "<dev string:xd2>";
    case # "reaper":
      return "<dev string:xdf>";
    case # "ruin":
      return "<dev string:xe9>";
    case # "seraph":
      return "<dev string:xf1>";
    case # "nomad":
      return "<dev string:xfb>";
  }

  return "<dev string:x38>";
}

function play_conv_self_other() {
  num = randomintrange(0, 4);
  self play_test_dialog("<dev string:x104>" + num);
  wait 4;
  players = arraysort(level.players, self.origin);

  foreach(player in players) {
    if(player != self && isalive(player)) {
      player play_test_dialog("<dev string:x112>" + self response_key() + num);
      break;
    }
  }
}

function play_conv_other_self() {
  num = randomintrange(0, 4);
  players = arraysort(level.players, self.origin);

  foreach(player in players) {
    if(player != self && isalive(player)) {
      player play_test_dialog("<dev string:x104>" + num);
      break;
    }
  }

  wait 4;
  self play_test_dialog("<dev string:x112>" + player response_key() + num);
}

function play_conv_other_other() {
  num = randomintrange(0, 4);
  players = arraysort(level.players, self.origin);

  foreach(player in players) {
    if(player != self && isalive(player)) {
      player play_test_dialog("<dev string:x104>" + num);
      firstplayer = player;
      break;
    }
  }

  wait 4;

  foreach(player in players) {
    if(player != self && player !== firstplayer && isalive(player)) {
      player play_test_dialog("<dev string:x112>" + firstplayer response_key() + num);
      break;
    }
  }
}