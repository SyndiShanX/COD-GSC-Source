/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_third_person_toggle.gsc
**************************************************************/

#using scripts\common\ui;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\teams;
#using scripts\mp\utility\connect_event_aggregator;
#using scripts\mp\utility\game;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace br_third_person_toggle;

function autoexec function_2f0b4e181f91c25d() {
  if(!getdvarint(@ "hash_75fee18e32915f50", 0)) {
    return;
  }

  level.var_6bec823e343dacea = 1;
  scripts\mp\utility\connect_event_aggregator::registeronconnectcallback(&function_a9734af6e99f9094);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_960c3bd1e16e8bd5);
  level scripts\common\ui::lui_registercallback("toggle_camera_view", &function_ec4e95e034624607);
}

function private function_a9734af6e99f9094() {
  self endon("disconnect");

  if(!isbot(self)) {
    self notifyonplayercommand("third_person_down_press", "+actionslot 2");
    self notifyonplayercommand("third_person_down_release", "-actionslot 2");
    self notifyonplayercommand("third_person_toggle", "third_person_toggle");
  }

  thread function_c27d3cdcab46cbc2();
}

function private function_960c3bd1e16e8bd5() {
  var_aa1caebf050b34cc = self getclientomnvar("ui_toggle_third_person");

  if(istrue(var_aa1caebf050b34cc)) {
    thirdpersontoggle(1);
    return;
  }

  thirdpersontoggle(0);
}

function private function_ec4e95e034624607(value) {
  thirdpersontoggle();
}

function private function_c27d3cdcab46cbc2() {
  self endon("disconnect");
  pressedtime = 0;
  var_e8f400f6f31d7f6f = 500;
  var_a8c5a8705ebf33f5 = var_e8f400f6f31d7f6f / 1000;
  var_40ec201cab12ba90 = 1000;
  value = undefined;

  while(true) {
    if(pressedtime == 0) {
      value = utility::waittill_any_return_3("third_person_down_press", "third_person_down_release", "third_person_toggle");
    } else {
      value = utility::waittill_any_timeout_1(var_a8c5a8705ebf33f5, "third_person_down_release");
    }

    if(!isalive(self) || !isDefined(value)) {
      continue;
    }

    shouldtoggle = 0;

    if(value == "third_person_down_release") {
      pressedtime = 0;
    } else if(value == "timeout") {
      if(isDefined(self.var_2e208b49f21aaed9) && gettime() - self.var_2e208b49f21aaed9 <= var_e8f400f6f31d7f6f) {
        shouldtoggle = 0;
      } else if(self getclientomnvar("loot_container_open") != 0) {
        shouldtoggle = 0;
      } else {
        shouldtoggle = 1;
      }

      pressedtime = 0;
    } else if(value == "third_person_toggle") {
      shouldtoggle = 1;
      pressedtime = 0;
    } else if(pressedtime == 0) {
      pressedtime = gettime();
    }

    if(shouldtoggle) {
      thirdpersontoggle();
    }
  }
}

function private thirdpersontoggle(override) {
  if(!isPlayer(self)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  if(!function_f6a4c1d71c0bae67()) {
    return;
  }

  if(isalive(self) && !self isvehicleactive() && !istrue(self.var_bdeecf4a8259041c)) {
    isthirdperson = self getcamerathirdperson();

    if(isDefined(override)) {
      isthirdperson = !override;
    }

    self setcamerathirdperson(!isthirdperson);
    self setclientomnvar("ui_toggle_third_person", !isthirdperson);

    if(!isDefined(override)) {
      function_cb22a71dbdfb420d(isthirdperson);
    }
  }
}

function private function_f6a4c1d71c0bae67() {
  player = self;

  if(!player val::get("third_person_toggle")) {
    return false;
  }

  if(player isinexecutionattack() || player isinexecutionvictim()) {
    return false;
  }

  return true;
}

function private function_cb22a71dbdfb420d(isthirdperson) {
  player = self;

  if(!isDefined(player.var_ef45d7edf975f10f)) {
    player.var_ef45d7edf975f10f = int(gettime() / 1000);
  } else {
    player.var_ef45d7edf975f10f = int(gettime() / 1000) - player.var_ef45d7edf975f10f;
  }

  circleindex = -1;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
    circleindex = level.br_circle.circleindex;
  }

  operatorref = "none";
  operatorskin = "none";
  [operatorref, operatorskin] = player scripts\mp\teams::function_e7fe5b7d4b92813c();

  if(!isDefined(operatorref)) {
    operatorref = "unknown";
  }

  if(!isDefined(operatorskin)) {
    operatorskin = "unknown";
  }

  params = ["player_xuid", player getxuid(), "team", player.team, "player_entity_num", player getentitynumber(), "playlist_id", getplaylistid(), "playlist_name", getplaylistname(), "game_type", scripts\mp\utility\game::getgametype(), "sub_game_type", scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5(), "circle_index", circleindex, "third_person", isthirdperson, "since_last_toggle", player.var_ef45d7edf975f10f, "map", level.mapname, "operator_ref", operatorref, "operator_skin", operatorskin];
  player dlog_recordplayerevent("dlog_event_br_third_person_toggle", params);
}