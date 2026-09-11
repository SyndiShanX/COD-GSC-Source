/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_jailbreak.gsc
*************************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("scr_br_pe_jailbreak_weight", 1);
  var_0.ref_140cf = &ref_140cf;
  var_0.attackerswaittime = &attackerswaittime;
  var_0.ref_14382 = &ref_14382;
  var_0.‹Á¿ ø {
    ÏXX;
    â # / = &postinitfunc;
    var_0.ref_11b78 = getdvarint("scr_br_pe_jailbreak_max_times", 1);
    var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("jailbreak", "00 5 10105 5 1");
    var_0.£¼#w]
  j‹ ƒ½ Ï‚ UÀíÌI¸ Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("jailbreak");
  scripts\mp\gametypes\br_publicevents::ref_12b35(3, var_0);
}

function postinitfunc() {
  game["dialog"]["public_events_jailbreak_incoming_active"] = "public_events_jailbreak_start_inmatch";
  game["dialog"]["public_events_jailbreak_incoming_active_alt"] = "public_events_jailbreak_start_alive";
  game["dialog"]["public_events_jailbreak_incoming_gulag"] = "public_events_jailbreak_start_gulag";
  game["dialog"]["public_events_jailbreak_incoming_spectate"] = "public_events_jailbreak_start_eliminated";
  game["dialog"]["public_events_jailbreak_now_active"] = "public_events_jailbreak_begin_inmatch";
  game["dialog"]["public_events_jailbreak_now_active_alt"] = "public_events_jailbreak_end_alive";
  game["dialog"]["public_events_jailbreak_now_gulag"] = "public_events_jailbreak_end_gulag";
  game["dialog"]["public_events_jailbreak_now_spectate"] = "public_events_jailbreak_begin_eliminated";
}

function ref_140cf() {
  var_0 = !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife");
  var_1 = istrue(level.usegulag);
  return var_0 || var_1;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var_0 = forest_combat();
  wait var_0;
}

function attackerswaittime() {
  level endon("game_ended");
  ref_12217(1);
  ref_14370();
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_jailbreak_incoming");
  ref_1274a("incoming");
  var_0 = getdvarfloat("scr_br_pe_jailbreak_duration", 30);
  var_1 = gettime() + var_0 * 1000;
  setomnvar("ui_publicevent_timer_type", 2);
  setomnvar("ui_publicevent_timer", var_1);
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 hide();

  if(var_0 > 5) {
    wait var_0 - 5;

    for(var_3 = 0; var_3 < 5; var_3++) {
      var_2 playSound("ui_mp_fire_sale_timer");
      wait 1;
    }
  }

  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_jailbreak_active");
  ref_1274a("now");
  setomnvar("ui_publicevent_timer_type", 0);
  var_2 delete();
  wait 1;
  ref_12cad();
  ref_12217(0);
}

function forest_combat() {
  var_0 = getdvarfloat("scr_br_pe_jailbreak_starttime_min", 795);
  var_1 = getdvarfloat("scr_br_pe_jailbreak_starttime_max", 1110);

  if(var_1 > var_0) {
    return randomfloatrange(var_0, var_1);
  }

  return var_0;
}

function ref_12217(var_0) {
  scripts\mp\gametypes\br_gulag::ref_12219(var_0);
}

function ref_14370() {
  level endon("game_ended");
  wait 1;

  for(;;) {
    if(!scripts\mp\gametypes\br_gulag::calloutmarkerping_cp_setupcptimeouts()) {
      break;
    }

    waitframe();
  }
}

function fix_badcover_atend(var_0) {
  var_1 = [];
  var_2 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);

  foreach(var_4 in level.teamnamelist) {
    var_5 = level.teamdata[var_4]["aliveCount"] > 0;

    if(var_0) {
      var_5 = level.teamdata[var_4]["teamCount"] > 0;
    }

    if(var_5) {
      foreach(var_7 in level.teamdata[var_4]["players"]) {
        var_8 = var_2 && var_7 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();

        if(!isalive(var_7) && !var_8) {
          var_1 = var_7;
          continue;
        }

        if(isalive(var_7) && var_8) {
          var_1 = var_7;
        }
      }
    }
  }

  return var_1;
}

function ref_12cac() {
  var_0 = isalive(self) && isDefined(level.gulag) && !istrue(level.gulag.shutdown) && scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();

  if(var_0) {
    thread scripts\mp\gametypes\br_gulag::vehicle_compass_cp_shouldbevisibletoplayer();
    return;
  }

  thread scripts\mp\gametypes\br_gulag::playergulagautowin("jailbreak", undefined, undefined, 1, 1);
}

function ref_12cad() {
  level endon("game_ended");
  var_0 = getdvarint("scr_br_pe_jailbreak_includeeliminatedteams", 1);
  var_1 = fix_badcover_atend(var_0);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(var_0) {
      ref_12c78(var_3);
    }

    thread ref_12cac();
    waitframe();
  }
}

function ref_12c78() {
  self.ref_12396 = undefined;
  self.emergency_cleanupents = undefined;
  self.ref_128af = undefined;
  self.dialog_wait_ready = undefined;
  self.br_spectatorinitialized = undefined;
  self setclientomnvar("ui_br_player_position", 155);
  self setclientomnvar("ui_br_squad_eliminated_active", 0);
  self setclientomnvar("ui_round_end_title", 0);
  self setclientomnvar("ui_round_end_reason", 0);
}

function ref_1274a(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  var_5 = getdvarint("scr_br_pe_jailbreak_includeeliminatedteams", 1);

  foreach(var_7 in level.teamnamelist) {
    var_8 = level.teamdata[var_7]["aliveCount"] > 0;

    if(var_5) {
      var_8 = level.teamdata[var_7]["teamCount"] > 0;
    }

    if(var_8) {
      foreach(var_10 in level.teamdata[var_7]["players"]) {
        var_11 = var_4 && var_10 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();

        if(!isalive(var_10) && !var_11) {
          var_3 = var_10;
          continue;
        }

        if(isalive(var_10) && var_11) {
          var_2 = var_10;
          continue;
        }

        if(isalive(var_10)) {
          var_1 = var_10;
        }
      }
    }
  }

  if(var_1.size > 0) {
    var_14 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "_active", "_active_alt");
    scripts\mp\gametypes\br_public::brleaderdialog("public_events_jailbreak_" + var_0 + var_14, 0, var_1, 1);
  }

  if(var_2.size > 0) {
    var_15 = "_gulag";
    scripts\mp\gametypes\br_public::brleaderdialog("public_events_jailbreak_" + var_0 + var_15, 0, var_2, 1);
  }

  if(var_3.size > 0) {
    var_16 = "_spectate";
    scripts\mp\gametypes\br_public::brleaderdialog("public_events_jailbreak_" + var_0 + var_16, 0, var_3, 1);
    return;
  }
}