/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_jailbreak.gsc
*************************************************************/

#using script_3583ff375ab3a91e;
#using script_5bc60484d17fa95c;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\gametypes\br_twotwo_gulag;
#using scripts\mp\utility\game;
#namespace br_publicevent_jailbreak;

function autoexec main() {
  scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82(%"jailbreak", &init);
}

function init(eventinfo) {
  eventinfo.validatefunc = &validatefunc;
  eventinfo.activatefunc = &activatefunc;
  eventinfo.waitfunc = &waitfunc;
  eventinfo.postinitfunc = &postinitfunc;
}

function postinitfunc() {
  game["dialog"]["public_events_jailbreak_incoming_active"] = "pblc_grav_jbwr";
  game["dialog"]["public_events_jailbreak_incoming_active_alt"] = "pblc_grav_jbwr";
  game["dialog"]["public_events_jailbreak_now_active"] = "pblc_grav_jbct";
  game["dialog"]["public_events_jailbreak_now_active_alt"] = "pblc_grav_jbct";
  game["dialog"]["public_events_jailbreak_now_gulag"] = "pblc_grav_jbgn";
  game["dialog"]["public_events_jailbreak_now_spectate"] = "pblc_grav_jbsn";
}

function validatefunc() {
  isonelife = !scripts\mp\gametypes\br_gametypes::isfeaturedisabled("oneLife");
  var_b5c6b5ad4d7c67dd = istrue(level.usegulag);
  return isonelife || var_b5c6b5ad4d7c67dd;
}

function waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  eventstarttime = calculateeventstarttime();
  wait eventstarttime;
}

function activatefunc() {
  level endon("game_ended");
  pauseallgulagfights(1);
  waitforgulagfightstocomplete();
  scripts\mp\gametypes\br_publicevents::showsplashtoall("br_pe_jailbreak_incoming");
  playjailbreakvo("incoming");
  eventduration = getdvarfloat(@ "hash_9e78730ec3baa38c", 30);
  eventendtime = gettime() + eventduration * 1000;
  setomnvar("ui_publicevent_timer_type", 2);
  setomnvar("ui_publicevent_timer", eventendtime);
  clockobject = spawn("script_origin", (0, 0, 0));
  clockobject hide();

  if(eventduration > 5) {
    wait eventduration - 5;

    for(i = 0; i < 5; i++) {
      clockobject playSound("ui_mp_fire_sale_timer");
      wait 1;
    }
  }

  scripts\mp\gametypes\br_publicevents::showsplashtoall("br_pe_jailbreak_active");
  playjailbreakvo("now");
  setomnvar("ui_publicevent_timer_type", 0);
  clockobject delete();
  wait 1;
  playerlist = respawnplayers();
  level thread forcestopwaitforgulagtoempty();
  waitforgulagtoempty(playerlist);
  level notify("waitForGulagToEmptySuccess");
  pauseallgulagfights(0);
}

function forcestopwaitforgulagtoempty() {
  if(!istrue(getdvarint(@ "hash_50e4237b891b5501", 1))) {
    return;
  }

  level endon("game_ended");
  level endon("waitForGulagToEmptySuccess");
  waittime = 10;

  if(isDefined(level.gulag) && isDefined(level.gulag.var_1dc4b5e63b8d0243)) {
    waittime = level.gulag.var_1dc4b5e63b8d0243;
  }

  wait waittime;
  level notify("forceStopWaitForGulagToEmpty");
}

function calculateeventstarttime() {
  minstarttime = getdvarfloat(@ "scr_br_pe_jailbreak_starttime_min", 795);
  maxstarttime = getdvarfloat(@ "scr_br_pe_jailbreak_starttime_max", 1110);

  if(maxstarttime > minstarttime) {
    return randomfloatrange(minstarttime, maxstarttime);
  }

  return minstarttime;
}

function pauseallgulagfights(var_1fd0410e54d2ffd8) {
  scripts\mp\gametypes\br_gulag::pausegulag(var_1fd0410e54d2ffd8);
}

function waitforgulagfightstocomplete() {
  level endon("game_ended");
  wait 1;

  while(true) {
    if(!scripts\mp\gametypes\br_gulag::areanygulagfightsactive()) {
      break;
    }

    waitframe();
  }
}

function waitforgulagtoempty(playerlist) {
  level endon("game_ended");
  level endon("forceStopWaitForGulagToEmpty");

  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("gulag")) {
    return;
  }

  var_b2203c3c0f607d88 = 0;

  while(!var_b2203c3c0f607d88) {
    var_b2203c3c0f607d88 = 1;

    foreach(p in playerlist) {
      if(p scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
        var_b2203c3c0f607d88 = 0;
        break;
      }
    }

    waitframe();
  }
}

function buildrespawnlist(var_827c53020f6f228f) {
  respawnplayers = [];
  var_ae6415479f782a1b = isDefined(level.gulag);

  foreach(entry in level.teamnamelist) {
    if(entry == "spectator" || entry == "codcaster") {
      continue;
    }

    var_6ba9b6124f692dfa = level.teamdata[entry]["aliveCount"] > 0;

    if(var_827c53020f6f228f) {
      var_6ba9b6124f692dfa = level.teamdata[entry]["teamCount"] > 0;
    }

    if(var_6ba9b6124f692dfa) {
      foreach(player in level.teamdata[entry]["players"]) {
        var_87fe48f5f9047e82 = var_ae6415479f782a1b && player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag();

        if(!isalive(player) && !var_87fe48f5f9047e82) {
          respawnplayers[respawnplayers.size] = player;
          continue;
        }

        if(isalive(player) && var_87fe48f5f9047e82) {
          respawnplayers[respawnplayers.size] = player;
          continue;
        }

        if(namespace_eb17b46cdcb98eea::function_1980065ce4dc067b() && !isalive(player) && var_87fe48f5f9047e82) {
          respawnplayers[respawnplayers.size] = player;
        }
      }
    }
  }

  return respawnplayers;
}

function respawnplayer() {
  isingulag = isalive(self) && isDefined(level.gulag) && !istrue(level.gulag.shutdown) && scripts\mp\gametypes\br_public::isplayerinorgoingtogulag();

  if(isingulag) {
    thread scripts\mp\gametypes\br_gulag::jailbreakeventplayer();
  } else {
    thread scripts\mp\gametypes\br_gulag::playergulagautowin("jailbreak", undefined, undefined, 1, 1);
  }

  self notify("jailbreak_respawn");

  if(namespace_eb17b46cdcb98eea::function_1980065ce4dc067b()) {
    arena = namespace_ad49798629176e96::function_2f4344abdc200e43(self);

    if(!isDefined(arena)) {
      arena = namespace_ad49798629176e96::function_de20b194b1a37513(self);
    }

    if(isDefined(arena)) {
      if(array_contains(arena.arenaplayers, self)) {
        arena.arenaplayers = array_remove(arena.arenaplayers, self);
      } else if(array_contains(arena.jailedplayers, self)) {
        arena.jailedplayers = array_remove(arena.jailedplayers, self);
      }

      if(isDefined(arena.var_654c981854394718)) {
        if(array_contains(arena.var_654c981854394718, self)) {
          arena.var_654c981854394718 = array_remove(arena.var_654c981854394718, self);
        }
      }

      scripts\mp\gametypes\br_gulag::playerdestroyhud(arena);
      scripts\mp\gametypes\br_gulag::updatematchqueuepositions(arena);

      if(scripts\mp\gametypes\br_twotwo_gulag::function_6e3541fd8fab45bc()) {
        scripts\mp\gametypes\br_twotwo_gulag::function_cc5468bb6e866411(arena);
      }
    }
  }

  if(!isbot(self) && scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    aeeventname = #"hash_774f005e1bf7d1d3";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    params = [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"hash_14cdeb43c9c858c1"), isingulag];

    if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
      callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
    }
  }
}

function respawnplayers() {
  level endon("game_ended");
  var_827c53020f6f228f = getdvarint(@ "hash_c622900a5fa1e2c6", 1);
  playerlist = buildrespawnlist(var_827c53020f6f228f);

  foreach(player in playerlist) {
    if(!isDefined(player)) {
      continue;
    }

    player thread respawnplayer();
  }

  return playerlist;
}

function playjailbreakvo(aliasname) {
  activeplayers = [];
  gulagplayers = [];
  spectateplayers = [];
  var_a11643fdeedee81b = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  var_827c53020f6f228f = getdvarint(@ "hash_c622900a5fa1e2c6", 1);

  foreach(entry in level.teamnamelist) {
    var_6ba9b6124f692dfa = level.teamdata[entry]["aliveCount"] > 0;

    if(var_827c53020f6f228f) {
      var_6ba9b6124f692dfa = level.teamdata[entry]["teamCount"] > 0;
    }

    if(var_6ba9b6124f692dfa) {
      foreach(player in level.teamdata[entry]["players"]) {
        var_87fe48f5f9047e82 = var_a11643fdeedee81b && player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag();

        if(!isalive(player) && !var_87fe48f5f9047e82) {
          spectateplayers[spectateplayers.size] = player;
          continue;
        }

        if(isalive(player) && var_87fe48f5f9047e82) {
          gulagplayers[gulagplayers.size] = player;
          continue;
        }

        if(isalive(player)) {
          activeplayers[activeplayers.size] = player;
        }
      }
    }
  }

  if(activeplayers.size > 0) {
    activesuffix = ter_op(cointoss(), "_active", "_active_alt");
    scripts\mp\gametypes\br_public::brleaderdialog("public_events_jailbreak_" + aliasname + activesuffix, 0, activeplayers, 1, 1);
  }

  if(gulagplayers.size > 0) {
    var_35c7a746aa1c8e9e = "_gulag";
    scripts\mp\gametypes\br_public::brleaderdialog("public_events_jailbreak_" + aliasname + var_35c7a746aa1c8e9e, 0, gulagplayers, 1, 1);
  }

  if(spectateplayers.size > 0) {
    spectatesuffix = "_spectate";
    scripts\mp\gametypes\br_public::brleaderdialog("public_events_jailbreak_" + aliasname + spectatesuffix, 0, spectateplayers, 1, 1);
  }
}