/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_jailbreak.gsc
*************************************************************/

function init() {
  var0 = spawnStruct();
  var0.weight = getdvarfloat("scr_br_pe_jailbreak_weight", 1);
  var0.ref_140cf = &ref_140cf;
  var0.attackerswaittime = &attackerswaittime;
  var0.ref_14382 = &ref_14382;
  var0.‹Á¿ ø {
    ÏXX;
    â # / = &postinitfunc;
    var0.ref_11b78 = getdvarint("scr_br_pe_jailbreak_max_times", 1);
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("jailbreak", "00 5 10105 5 1");
    var0.£¼#w]
  j‹ ƒ½ Ï‚ UÀíÌI¸ Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("jailbreak");
  scripts\mp\gametypes\br_publicevents::ref_12b35(3, var0);
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
  var0 = !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife");
  var1 = istrue(level.usegulag);
  return var0 || var1;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var0 = forest_combat();
  wait var0;
}

function attackerswaittime() {
  level endon("game_ended");
  ref_12217(1);
  ref_14370();
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_jailbreak_incoming");
  ref_1274a("incoming");
  var0 = getdvarfloat("scr_br_pe_jailbreak_duration", 30);
  var1 = gettime() + var0 * 1000;
  setomnvar("ui_publicevent_timer_type", 2);
  setomnvar("ui_publicevent_timer", var1);
  var2 = spawn("script_origin", (0, 0, 0));
  var2 hide();

  if(var0 > 5) {
    wait var0 - 5;

    for(var3 = 0; var3 < 5; var3++) {
      var2 playSound("ui_mp_fire_sale_timer");
      wait 1;
    }
  }

  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_jailbreak_active");
  ref_1274a("now");
  setomnvar("ui_publicevent_timer_type", 0);
  var2 delete();
  wait 1;
  ref_12cad();
  ref_12217(0);
}

function forest_combat() {
  var0 = getdvarfloat("scr_br_pe_jailbreak_starttime_min", 795);
  var1 = getdvarfloat("scr_br_pe_jailbreak_starttime_max", 1110);

  if(var1 > var0) {
    return randomfloatrange(var0, var1);
  }

  return var0;
}

function ref_12217(var0) {
  scripts\mp\gametypes\br_gulag::ref_12219(var0);
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

function fix_badcover_atend(var0) {
  var1 = [];
  var2 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);

  foreach(var4 in level.teamnamelist) {
    var5 = level.teamdata[var4]["aliveCount"] > 0;

    if(var0) {
      var5 = level.teamdata[var4]["teamCount"] > 0;
    }

    if(var5) {
      foreach(var7 in level.teamdata[var4]["players"]) {
        var8 = var2 && var7 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();

        if(!isalive(var7) && !var8) {
          var1 = var7;
          continue;
        }

        if(isalive(var7) && var8) {
          var1 = var7;
        }
      }
    }
  }

  return var1;
}

function ref_12cac() {
  var0 = isalive(self) && isDefined(level.gulag) && !istrue(level.gulag.shutdown) && scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();

  if(var0) {
    thread scripts\mp\gametypes\br_gulag::vehicle_compass_cp_shouldbevisibletoplayer();
    return;
  }

  thread scripts\mp\gametypes\br_gulag::playergulagautowin("jailbreak", undefined, undefined, 1, 1);
}

function ref_12cad() {
  level endon("game_ended");
  var0 = getdvarint("scr_br_pe_jailbreak_includeeliminatedteams", 1);
  var1 = fix_badcover_atend(var0);

  foreach(var3 in var1) {
    if(!isDefined(var3)) {
      continue;
    }

    if(var0) {
      ref_12c78(var3);
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

function ref_1274a(var0) {
  var1 = [];
  var2 = [];
  var3 = [];
  var4 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  var5 = getdvarint("scr_br_pe_jailbreak_includeeliminatedteams", 1);

  foreach(var7 in level.teamnamelist) {
    var8 = level.teamdata[var7]["aliveCount"] > 0;

    if(var5) {
      var8 = level.teamdata[var7]["teamCount"] > 0;
    }

    if(var8) {
      foreach(var10 in level.teamdata[var7]["players"]) {
        var11 = var4 && var10 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();

        if(!isalive(var10) && !var11) {
          var3 = var10;
          continue;
        }

        if(isalive(var10) && var11) {
          var2 = var10;
          continue;
        }

        if(isalive(var10)) {
          var1 = var10;
        }
      }
    }
  }

  if(var1.size > 0) {
    var14 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "_active", "_active_alt");
    scripts\mp\gametypes\br_public::brleaderdialog("public_events_jailbreak_" + var0 + var14, 0, var1, 1);
  }

  if(var2.size > 0) {
    var15 = "_gulag";
    scripts\mp\gametypes\br_public::brleaderdialog("public_events_jailbreak_" + var0 + var15, 0, var2, 1);
  }

  if(var3.size > 0) {
    var16 = "_spectate";
    scripts\mp\gametypes\br_public::brleaderdialog("public_events_jailbreak_" + var0 + var16, 0, var3, 1);
    return;
  }
}