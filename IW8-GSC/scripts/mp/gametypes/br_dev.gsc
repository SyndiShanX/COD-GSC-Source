/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_dev.gsc
***********************************************/

function init() {}

function hidehudintermission(var_0, var_1) {
  level notify("commandWatcher_" + var_0);
  level endon("commandWatcher_" + var_0);
  setDvar(var_0, "");

  for(;;) {
    waitframe();
    var_2 = getDvar(var_0);

    if(var_2 == "") {
      continue;
    }

    setDvar(var_0, "");
    var_3 = strtok(var_2, " ");

    if(!isDefined(var_3) || var_3.size < 1) {
      continue;
    }

    var_4 = var_3[0];
    var_5 = scripts\engine\utility::array_slice(var_3, 1);
    [[var_1]](var_4, var_5);
  }
}

function setup_level_for_nightvision(var_0, var_1) {
  if(!isDefined(level.setup_manned_turret)) {
    return;
  }

  foreach(var_3 in level.setup_manned_turret) {
    [[var_3]](var_0, var_1);
  }
}

function ref_12b21(var_0) {
  if(!isDefined(level.setup_manned_turret)) {
    level.setup_manned_turret = [];
  }

  level.setup_manned_turret[level.setup_manned_turret.size] = var_0;
}

function setup_lights_in_region(var_0, var_1) {
  switch (var_0) {
    case "st":
      thread level_getspawnpoint(var_1);
      break;
    case "payload2":
      thread scripts\mp\gametypes\br_gametype_payload_dev::ref_12e0a(var_1);
      break;
    default:
      break;
  }
}

function level_getspawnpoint(var_0) {
  level notify("devScriptedTests");
  level endon("devScriptedTests");
  var_1 = remove_map_hint(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = [scripts\mp\gametypes\br::createspawnlocation((-21500, 46200, -300), 0, 6000), scripts\mp\gametypes\br::createspawnlocation((51000, -39000, 1401), 0, 4000), scripts\mp\gametypes\br::createspawnlocation((32000, 40000, 767), 0, 5500), scripts\mp\gametypes\br::createspawnlocation((23000, -15000, -158), 0, 6000)];

  if(!scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    var_2 = undefined;
  }

  if(istrue(level.usegulag)) {
    foreach(var_4 in level.gulag.arenas) {
      var_4.matches = [];
    }

    level.gulag.arenas = sortbydistance(level.gulag.arenas, level.mapcorners[0].origin);
    level.gulag.maxuses = -1;
    level.gulag.timelimit = 15;
    setDvar("scr_br_fc_overtime", 15);
    setDvar("scr_br_fc_jailTimeout", 95);
  }

  scripts\mp\flags::gameflagset("prematch_done");
  level notify("prematch_over");
  setomnvar("ui_prematch_period", 0);
  level.maxteamsize = 3;
  level.br_prematchstarted = 1;
  level.teammaxfill = 1;
  level.disablespawning = 0;
  level.ignorescoring = 0;
  level.allowprematchdamage = 1;
  setDvar("bot_DisableAllAI", 1);
  setDvar("br_minplayers", 150);
  setDvar("live_lobby_minplayers_start", 150);
  setDvar("scr_br_fc_forceArena", -1);
  setDvar("scr_br_spectateMinStreamWaitDebug", 0);
  setDvar("scr_br_gulag_win_hold", 0);
  setDvar("scr_br_hold_in_gulag", 0);

  if(isDefined(level.gulag) && istrue(level.gulag.shutdown)) {
    foreach(var_4 in level.gulag.arenas) {
      var_4.shutdown = undefined;
    }

    level.gulag.shutdown = undefined;
  }

  foreach(var_9 in level.players) {
    if(var_9 calloutmarkerping_getEnt()) {
      var_9 allowmovement(0);
      var_9 allowfire(0);
      var_9 allowmelee(0);
    }

    var_9.br_infilstarted = undefined;
    var_9.gulag = undefined;
    var_9.jailed = undefined;
    var_9.gulagarena = undefined;
    var_9.ref_14439 = undefined;
    var_9.ref_126cc = undefined;
    var_9.ref_11e80 = undefined;
    var_9.gulagloser = undefined;
    var_9.gulaguses = undefined;
    var_9.ref_119d7 = undefined;
    var_9.set_relic_nuketimer = undefined;
    var_9 notify("gulag_end");
    var_9 notify("last_stand_start");
    var_9 scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", var_9);
    var_9 setstance("stand");
    var_9 calloutmarkerping_getcreatedtime(0);
    var_9 playershow();
    var_9.setspawnpoint = undefined;

    if(istrue(level.usegulag)) {
      var_9 scripts\mp\gametypes\br_gulag::playerrespawngulagcleanup(0);
      var_9 scripts\mp\gametypes\br_gulag::playergulagarenaready();
    }
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    level.br_circle.dangercircleui.hidden = 1;
    level.br_circle.dangercircleent.hidden = 1;
    level.br_circle.safecircleui.hidden = 1;
    level.br_circle.safecircleent.hidden = 1;
    level notify("update_circle_hide");
  }

  if(!isDefined(level.level_logic)) {
    level.level_logic = [];
  }

  if(!isDefined(level.level_killstreak_spawn)) {
    for(var_11 = 0; var_11 < level.teamnamelist.size; var_11++) {
      var_12 = level.teamnamelist[var_11];

      if(var_12 != var_1.team) {
        if(!isDefined(level.level_killstreak_spawn)) {
          level.level_killstreak_spawn = var_12;
          continue;
        }

        level.level_light = var_12;
        break;
      }
    }
  }

  ref_12d1c(var_1, var_1.team);
  ref_12d1c(var_1, level.level_killstreak_spawn);

  if(isDefined(level.level_light)) {
    ref_12d1c(var_1, level.level_light);
  }

  var_13 = run_current_spawn_group(var_1, var_1.team);
  var_14 = run_current_spawn_group(var_1, level.level_killstreak_spawn);
  var_15 = [];

  if(isDefined(level.level_light)) {
    var_15 = run_current_spawn_group(var_1, level.level_light);
  }

  for(var_11 = 0; var_11 < var_13.size; var_11++) {
    var_16 = var_13[var_11];
    var_17 = var_14[var_11];
    var_18 = undefined;

    if(isDefined(level.level_light)) {
      var_18 = var_15[var_11];
    }

    var_19 = undefined;

    if(isDefined(var_2)) {
      var_19 = var_2[var_11].origin;
    } else {
      var_19 = var_16.origin;
    }

    ref_126c5(var_16, var_19, 0);
    ref_126c5(var_17, var_19, 1);

    if(isDefined(level.level_light)) {
      ref_126c5(var_18, var_19, 2);
    }
  }

  level.disablespawning = 1;
  var_20 = scripts\mp\utility\game::getlivingplayers();
  level.totalplayers = var_20.size;
  var_1 iprintlnbold("Test ready");
  wait 2;

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "killcam1") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "killchain") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "disconnect1") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "disconnect2") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "disconnect3")) {
    killplayer(var_1, var_1, var_14);

    if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "disconnect2")) {
      while(var_1.sessionstate != "intermission") {
        waitframe();
      }

      while(var_1.sessionstate == "intermission") {
        waitframe();
      }
    } else if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "disconnect3")) {
      while(var_1.sessionstate != "intermission") {
        waitframe();
      }

      wait 0.5;
    } else {
      scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
      wait 3;

      if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "disconnect1")) {
        var_1 iprintlnbold("Waiting");
        wait 10;
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "disconnect1") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "disconnect2") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "disconnect3")) {
    var_21 = var_1 scripts\mp\gametypes\br_spectate::ref_12580();
    kick(var_21 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "killchain")) {
    for(var_21 = var_1 scripts\mp\gametypes\br_spectate::ref_12580(); !isDefined(var_21); var_21 = var_1 scripts\mp\gametypes\br_spectate::ref_12580()) {
      waitframe();
    }

    killplayer(var_1, var_21, var_14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "killchain")) {
    for(var_21 = var_1 scripts\mp\gametypes\br_spectate::ref_12580(); !isDefined(var_21); var_21 = var_1 scripts\mp\gametypes\br_spectate::ref_12580()) {
      waitframe();
    }

    killplayer(var_1, var_21, var_14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "killchain")) {
    for(var_21 = var_1 scripts\mp\gametypes\br_spectate::ref_12580(); !isDefined(var_21); var_21 = var_1 scripts\mp\gametypes\br_spectate::ref_12580()) {
      waitframe();
    }

    killplayer(var_1, var_21, var_15);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "killchain")) {
    for(var_21 = var_1 scripts\mp\gametypes\br_spectate::ref_12580(); !isDefined(var_21); var_21 = var_1 scripts\mp\gametypes\br_spectate::ref_12580()) {
      waitframe();
    }

    killplayer(var_1, var_21, var_15);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "killchain")) {
    for(var_21 = var_1 scripts\mp\gametypes\br_spectate::ref_12580(); !isDefined(var_21); var_21 = var_1 scripts\mp\gametypes\br_spectate::ref_12580()) {
      waitframe();
    }

    killplayer(var_1, var_21, var_15);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag1")) {
    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_9.br_infilstarted = 1;
        killplayer(var_1, var_9, var_14);
      }
    }

    wait 10;
    killplayer(var_1, var_1, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag2") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag3")) {
    killplayer(var_1, var_1, var_14);
    var_1 waittill("killcam_ended");
    wait 2;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_9.br_infilstarted = 1;
        killplayer(var_1, var_9, var_14);
      }
    }

    while(!isDefined(var_1 getspectatingplayer())) {
      waitframe();
    }

    var_26 = var_1 getspectatingplayer();
    var_26.br_infilstarted = 1;
    wait 1;

    foreach(var_9 in var_14) {
      var_9.br_infilstarted = 1;
      killplayer(var_1, var_9, var_15);
    }

    while(!istrue(var_26.gulagarena)) {
      waitframe();
    }

    wait 5;

    if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag2")) {
      var_29 = spawnStruct();
      var_29.playerspawnpos = (26474, -16709, -162);
      var_29.playerspawnangles = (85, 135, 0);
      var_26.setspawnpoint = var_29;

      foreach(var_9 in var_14) {
        if(istrue(var_9.gulagarena)) {
          var_9.br_infilstarted = 1;
          killplayer(var_1, var_9, var_15);
          break;
        }
      }

      while(!var_26 islinked()) {
        waitframe();
      }

      while(var_26 islinked()) {
        waitframe();
      }

      waitframe();
      var_32 = var_26 getplayerangles();
      var_26 setplayerangles((85, var_32[1], 0));
    } else {
      killplayer(var_1, var_26, var_15);
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag4")) {
    var_1.br_infilstarted = 1;
    var_33 = killplayer(var_1, var_1, var_14);
    var_33.br_infilstarted = 1;
    killplayer(var_1, var_33, var_13);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulaggulag")) {
    var_34 = getdvarint("scr_br_fc_arena1", 0);
    var_35 = getdvarint("scr_br_fc_arena2", 5);
    setDvar("scr_br_fc_jailTimeout", 9999);
    setDvar("scr_br_fc_forceArena", var_34);
    var_1.br_infilstarted = 1;
    var_33 = killplayer(var_1, var_1, var_14);
    setDvar("scr_br_fc_forceArena", var_35);

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_9.br_infilstarted = 1;
        killplayer(var_1, var_9, var_14);
      }
    }

    setDvar("scr_br_fc_forceArena", var_34);
    var_33.br_infilstarted = 1;
    killplayer(var_1, var_33, var_15);

    while(!istrue(var_1.gulagarena) && !istrue(var_33.gulagarena)) {
      waitframe();
    }

    wait 5;
    killplayer(var_1, var_1, undefined, var_33);
    setDvar("scr_br_fc_jailTimeout", 90);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "killkill")) {
    var_33 = var_14[0];

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        killplayer(var_1, var_9, undefined, var_33);
      }
    }

    killplayer(var_1, var_33, undefined, var_1);
    wait 10;
    killplayer(var_1, var_1, undefined, var_33);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "killcam2")) {
    var_33 = killplayer(var_1, var_1, var_14);
    wait 3;
    killplayer(var_1, var_1.ref_11e80, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag5") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag6")) {
    var_40 = undefined;

    foreach(var_9 in var_13) {
      if(!isDefined(var_40) && var_9 != var_1) {
        var_40 = var_9;
        continue;
      }

      killplayer(var_1, var_9, var_14);
      scripts\mp\gametypes\br_spectate::ref_143fa(var_9);
    }

    var_40.br_infilstarted = 1;

    if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag6")) {
      setDvar("scr_br_fc_jailTimeout", 9999);
      var_34 = getdvarint("scr_br_fc_arena1", 5);
      setDvar("scr_br_fc_forceArena", var_34);
      var_40.ref_119d7 = 1;
    }

    killplayer(var_1, var_40, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag7")) {
    killplayer(var_1, var_1, var_14);
    var_1 waittill("killcam_ended");
    wait 2;
    var_43 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_9.br_infilstarted = 1;
        var_43 = var_9;
        var_43 scripts\mp\gametypes\br_gulag::initplayerjail();
        break;
      }
    }

    while(!isDefined(var_1 getspectatingplayer())) {
      waitframe();
    }

    wait 1;
    var_46 = undefined;

    foreach(var_9 in var_14) {
      var_9.br_infilstarted = 1;
      var_46 = var_9;
      killplayer(var_1, var_9, var_15);
      break;
    }

    while(!istrue(var_43.gulagarena) && !istrue(var_46.gulagarena)) {
      waitframe();
    }

    wait 5;
    setDvar("scr_br_gulag_win_hold", 1);
    killplayer(var_1, var_46, undefined, var_43);

    while(var_1 getspectatingplayer() != var_43) {
      wait 1;
    }

    wait 5;
    setDvar("scr_br_gulag_win_hold", 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag8")) {
    level.gulag.timelimit = 3;
    setDvar("scr_br_fc_overtime", 3);
    setDvar("scr_br_fc_jailTimeout", -1);
    killplayer(var_1, var_1, var_14);
    var_1 waittill("killcam_ended");
    wait 2;
    var_43 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_9.br_infilstarted = 1;
        var_43 = var_9;
        var_43 scripts\mp\gametypes\br_gulag::initplayerjail();
        break;
      }
    }

    while(!isDefined(var_1 getspectatingplayer())) {
      waitframe();
    }

    while(var_1 getspectatingplayer() != var_43) {
      iprintlnbold("Switch to spectating gulag player");
      waitframe();
    }

    wait 1;
    var_46 = undefined;

    foreach(var_9 in var_14) {
      var_9.br_infilstarted = 1;
      var_46 = var_9;
      killplayer(var_1, var_9, var_15);
      break;
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag9")) {
    var_1.br_infilstarted = 1;
    var_33 = killplayer(var_1, var_1, var_14);
    var_33.br_infilstarted = 1;
    killplayer(var_1, var_33, var_13);

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        killplayer(var_1, var_9, var_14);
      }
    }

    foreach(var_9 in var_14) {
      if(var_9 != var_33) {
        killplayer(var_1, var_9, var_15);
      }
    }

    while(!istrue(var_1.gulagarena)) {
      waitframe();
    }

    wait 5;
    setDvar("scr_br_gulag_win_hold", 1);
    setDvar("scr_br_spectateMinStreamWaitDebug", 3);
    killplayer(var_1, var_1, undefined, var_33);
    wait 9;
    setDvar("scr_br_gulag_win_hold", 0);
    setDvar("scr_br_spectateMinStreamWaitDebug", 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag10")) {
    var_57 = var_14[0];
    var_57.br_infilstarted = 1;
    killplayer(var_1, var_57, var_15);
    var_58 = var_15[0];
    var_58.br_infilstarted = 1;
    killplayer(var_1, var_58, var_14);
    wait 1;
    var_59 = var_1;
    var_59.br_infilstarted = 1;
    killplayer(var_1, var_59, var_14);
    var_60 = var_14[1];
    var_60.br_infilstarted = 1;
    killplayer(var_1, var_60, var_15);

    while(!istrue(var_57.gulagarena) || !istrue(var_58.gulagarena) || !istrue(var_59.jailed) || !istrue(var_60.jailed)) {
      waitframe();
    }

    setDvar("scr_br_hold_in_gulag", 1);
    var_61 = var_15[1];
    var_61.br_infilstarted = 1;
    killplayer(var_1, var_61, var_14);
    wait 1;

    while(istrue(var_61.set_relic_steelballs_perks)) {
      waitframe();
    }

    scripts\mp\gametypes\br_gulag::shutdowngulag("circle_index", 0);
    wait 1;
    kick(var_61 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    wait 3;
    setDvar("scr_br_hold_in_gulag", 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag11")) {
    var_1.br_infilstarted = 1;
    ref_1294d(var_1, var_1, var_15);
    wait 1;
    scripts\mp\gametypes\br_gulag::shutdowngulag("circle_index", 0);
    wait 1;
    var_1 scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", var_1);
    wait 5;
    killplayer(var_1, var_1, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulagVIP")) {
    var_62 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_62 = var_9;
        break;
      }
    }

    var_1.br_infilstarted = 1;
    killplayer(var_1, var_1, var_14);
    var_65 = getdvarfloat("scr_gulagvip_wait", 0.1);
    wait var_65;
    scripts\mp\gametypes\br_vip_quest::ref_142c5(var_1, var_62, "vip");
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "twooneframe")) {
    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        killplayer(var_1, var_9, var_14);
        break;
      }
    }

    wait 5;

    foreach(var_9 in var_13) {
      if(isalive(var_9)) {
        vo_nag_mark_crates(var_1, var_9, var_14);
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "suicide")) {
    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        killplayer(var_1, var_9, var_14);
      }
    }

    wait 5;

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var_1 scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
    }

    var_1 suicide();
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "team")) {
    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        vo_nag_mark_crates(var_1, var_9, var_14);
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "moving")) {
    vo_nag_mark_crates(var_1, var_1, var_14);

    while(!isDefined(var_1.ref_126cc)) {
      waitframe();
    }

    var_9 = var_1.ref_126cc;
    var_74 = anglesToForward(var_9.angles);
    var_75 = getdvarint("testforward", 5);

    for(var_76 = var_1 getspectatingplayer(); !isDefined(var_76); var_76 = var_1 getspectatingplayer()) {
      var_77 = var_9.origin + var_74 * var_75;
      var_9 setOrigin(var_77);
      waitframe();
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "heli1") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "heli2")) {
    var_26 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        if(!isDefined(var_26)) {
          var_26 = var_9;
          continue;
        }

        vo_nag_mark_crates(var_1, var_9, var_14);
      }
    }

    wait 1;
    vo_nag_mark_crates(var_1, var_1, var_14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    wait 1;
    var_80 = getarraykeys(level.vehicle.instances["little_bird"]);
    var_81 = level.vehicle.instances["little_bird"][var_80[0]];
    var_82 = var_81 getlinkedscriptableinstance();
    var_26 setOrigin(var_81.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var_82, "single", "vehicle_use", var_26, 0);

    if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "heli2")) {
      wait 3;
      kick(var_26 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "water")) {
    var_1 setOrigin((28252, -32627, -415));
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "disconnectswitch1")) {
    vo_nag_mark_crates(var_1, var_1, var_14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    var_26 = var_1 scripts\mp\gametypes\br_spectate::ref_12580();

    while(!var_1 buttonPressed("BUTTON_RSHLDR")) {
      waitframe();
    }

    var_83 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1 && var_9 != var_26) {
        var_83 = var_9;
        break;
      }
    }

    wait 0.5;
    kick(var_83 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "disconnectswitch2")) {
    vo_nag_mark_crates(var_1, var_1, var_14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    var_26 = var_1 scripts\mp\gametypes\br_spectate::ref_12580();

    while(!var_1 buttonPressed("BUTTON_RSHLDR")) {
      waitframe();
    }

    wait 0.5;
    kick(var_26 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "endspectate")) {
    level.br_infils_disabled = 1;
    setDvar("br_minplayers", 2);
    level.gulag.maxuses = 0;
    wait 1;
    vo_nag_mark_crates(var_1, var_1, var_14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    wait 2;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        vo_nag_mark_crates(var_1, var_9, var_14);
      }
    }

    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    wait 2;
    var_33 = var_1 scripts\mp\gametypes\br_spectate::ref_12580();
    vo_nag_mark_crates(var_1, var_33, var_15);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    wait 2;
    var_33 = var_1 scripts\mp\gametypes\br_spectate::ref_12580();
    vo_nag_mark_crates(var_1, var_33, var_15);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    wait 2;
    var_33 = var_1 scripts\mp\gametypes\br_spectate::ref_12580();
    vo_nag_mark_crates(var_1, var_33, var_15);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    wait 2;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "teamwipe1")) {
    setDvar("scr_br_spectateMinStreamWaitDebug", 5);

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        vo_nag_mark_crates(var_1, var_9, var_14);
      }
    }

    wait getdvarfloat("test_teamwipe", 5);
    var_33 = vo_nag_mark_crates(var_1, var_1, var_14);
    wait getdvarfloat("test_teamwipe2", 13);
    vo_nag_mark_crates(var_1, var_33, var_15);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "deathswitch1")) {
    setDvar("scr_br_spectateMinStreamWaitDebug", 5);
    vo_nag_mark_crates(var_1, var_1, var_14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var_1);
    var_26 = var_1 scripts\mp\gametypes\br_spectate::ref_12580();

    while(!var_1 buttonPressed("BUTTON_RSHLDR")) {
      waitframe();
    }

    var_83 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1 && var_9 != var_26) {
        var_83 = var_9;
        break;
      }
    }

    wait 0.5;
    vo_nag_mark_crates(var_1, var_83, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "squadwidget")) {
    setDvar("scr_br_fc_jailTimeout", 9999);
    setDvar("scr_br_spectateMinStreamWaitDebug", 3);

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        kick(var_9 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
      }
    }

    wait 5;
    var_94 = var_14[0];
    var_95 = var_14[1];
    var_94.br_infilstarted = 1;
    vo_nag_mark_crates(var_1, var_94, undefined, var_1);
    wait getdvarfloat("test_squadwidget", 4);
    vo_nag_mark_crates(var_1, var_1, undefined, var_95);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "killall")) {
    level.overrideingraceperiod = 1;
    var_96 = var_13[1];

    foreach(var_9 in var_13) {
      if(var_9 != var_96) {
        vo_nag_mark_crates(var_1, var_9, var_14);
      }
    }

    foreach(var_9 in var_14) {
      vo_nag_mark_crates(var_1, var_9, var_15);
    }

    foreach(var_9 in var_15) {
      vo_nag_mark_crates(var_1, var_9, var_14);
    }

    wait 10;
    kick(var_96 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    level.overrideingraceperiod = undefined;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "moneykill")) {
    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_9 scripts\mp\gametypes\br_plunder::playersetplundercount(45);
        var_9.br_infilstarted = 1;
        vo_nag_mark_crates(var_1, var_9, var_14);
      }
    }

    wait 5;
    vo_nag_mark_crates(var_1, var_1, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "buyback1")) {
    ref_12f81(var_1.origin, 500);
    setDvar("scr_br_fc_jailTimeout", -1);
    var_105 = var_1;
    var_105.br_infilstarted = 1;
    killplayer(var_1, var_105, var_15);
    var_106 = var_15[0];
    var_106.br_infilstarted = 1;
    killplayer(var_1, var_106, var_15);

    while(!istrue(var_105.gulagarena)) {
      waitframe();
    }

    wait 5;
    vo_nag_mark_crates(var_1, var_105, []);

    while(!isDefined(var_105 getspectatingplayer())) {
      waitframe();
    }

    var_107 = var_105 getspectatingplayer();
    var_107.br_infilstarted = 1;
    var_61 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_105 && var_9 != var_107) {
        var_61 = var_9;
        break;
      }
    }

    var_61 scripts\mp\gametypes\br_plunder::playersetplundercount(45);
    killplayer(var_1, var_107, var_15);

    while(!istrue(var_107.jailed)) {
      waitframe();
    }

    while(!isDefined(var_105 getspectatingplayer()) || var_105 getspectatingplayer() != var_107) {
      waitframe();
    }

    var_110 = var_15[1];
    var_110.br_infilstarted = 1;
    killplayer(var_1, var_110, var_15);

    while(!istrue(var_107.gulagarena)) {
      waitframe();
    }

    wait 5;
    setDvar("scr_br_spectateMinStreamWaitDebug", 3);
    vo_nag_mark_crates(var_1, var_107, []);
    var_61 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
    var_105 thread scripts\mp\gametypes\br_gulag::playergulagautowin("dev", var_61, 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "teamwipe2")) {
    vo_nag_mark_crates(var_1, var_1, var_14);
    var_1 waittill("killcam_ended");
    wait 2;
    var_111 = 0;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        if(var_111 > 0) {
          var_9 scripts\mp\gametypes\br_plunder::playersetplundercount(45);
          var_9.br_infilstarted = 1;
        }

        vo_nag_mark_crates(var_1, var_9, var_15);
        var_111++;
        wait 5;
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "hvt1")) {
    ref_12f81(var_1.origin, 700);
    var_1.br_infilstarted = 1;
    var_26 = var_13[1];
    var_114 = spawnStruct();
    var_114.vip = var_26;
    var_114.team = var_26.team;
    var_114.isvalidkillcam = "instance";
    var_114.removed = 1;
    setDvar("scr_br_hold_in_gulag", 2);
    killplayer(var_1, var_1, var_14);

    while(!istrue(var_1.set_relic_nuketimer)) {
      waitframe();
    }

    var_114 scripts\mp\gametypes\br_vip_quest::ref_142b7();
    wait 5;
    setDvar("scr_br_hold_in_gulag", 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "infilDeath")) {
    thread ref_14366(getdvarint("test_suicide", 1), var_13[1]);
    ref_12078();
    level waittill("br_c130_left_bounds");
    wait 2;
    var_13[2].br_infilstarted = 0;
    vo_nag_mark_crates(var_1, var_13[2], var_14);
    wait 5;
    var_1.br_infilstarted = 0;
    vo_nag_mark_crates(var_1, var_1, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "reconGulag1")) {
    setDvar("br_minplayers", 9);
    wait 5;
    var_94 = var_14[0];
    var_95 = var_15[0];
    kick(var_14[2] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var_14[1] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var_15[2] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var_15[1] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var_13[2] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var_13[1] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    wait 1;
    ref_126b5(var_1);
    var_94.br_infilstarted = 1;
    vo_nag_mark_crates(var_1, var_94, undefined, var_95);
    wait 7;
    var_1.br_infilstarted = 1;

    if(!var_1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var_1 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    }

    vo_nag_mark_crates(var_1, var_1, undefined, var_95, 1);

    while(!istrue(var_1.gulagarena)) {
      waitframe();
    }

    wait 5;
    vo_nag_mark_crates(var_1, var_94, undefined, var_1);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "reconGulag2")) {
    var_94 = var_14[0];
    var_95 = var_14[1];
    var_115 = var_13[1];
    var_83 = var_13[2];

    if(var_115 == var_1) {
      var_115 = var_13[0];
    } else if(var_83 == var_1) {
      var_83 = var_13[0];
    }

    kick(var_14[2] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var_15[2] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var_15[1] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var_15[0] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    vo_nag_mark_crates(var_1, var_83, undefined, var_94);
    wait 1;
    ref_126b5(var_115);
    wait 2;
    vo_nag_mark_crates(var_1, var_1, undefined, var_94);
    var_1 waittill("killcam_ended");
    wait 3;
    var_95.br_infilstarted = 1;
    vo_nag_mark_crates(var_1, var_95, undefined, var_115);
    var_115.br_infilstarted = 1;

    if(!var_115 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var_115 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    }

    vo_nag_mark_crates(var_1, var_115, undefined, var_94, 1);

    while(!istrue(var_115.gulagarena)) {
      waitframe();
    }

    wait 5;
    vo_nag_mark_crates(var_1, var_115, undefined, var_95);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "endGameTwoDie")) {
    setDvar("br_minplayers", 8);
    wait 5;
    scripts\mp\gametypes\br_gulag::shutdowngulag("circle_index", 0);
    var_94 = var_14[0];
    var_115 = var_13[1];
    var_83 = var_13[2];

    if(var_115 == var_1) {
      var_115 = var_13[0];
    } else if(var_83 == var_1) {
      var_83 = var_13[0];
    }

    vo_nag_mark_crates(var_1, var_14[2], undefined, var_1);
    vo_nag_mark_crates(var_1, var_14[1], undefined, var_1);
    vo_nag_mark_crates(var_1, var_15[2], undefined, var_1);
    vo_nag_mark_crates(var_1, var_15[1], undefined, var_1);
    vo_nag_mark_crates(var_1, var_15[0], undefined, var_1);
    vo_nag_mark_crates(var_1, var_115, undefined, var_94);
    vo_nag_mark_crates(var_1, var_83, undefined, var_94);
    wait 3;
    var_1 scripts\mp\juggernaut::jugg_makejuggernaut(level.juggksglobals.config);
    wait 3;
    var_94 dodamage(999, var_94.origin, var_94, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");

    while(isalive(var_1)) {
      var_1 dodamage(999, var_1.origin, var_1, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      waitframe();
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "infiniteLoot")) {
    setomnvar("scriptable_loot_hide", 0);
    var_116 = var_1.origin;
    var_117 = var_1.angles;
    var_118 = 0;
    var_119 = 0;

    for(var_120 = 0;; var_120 = 0) {
      var_121 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var_116 + (var_118, var_119, 0), var_117);
      scripts\mp\gametypes\br_pickups::spawnpickup("brloot_self_revive", var_121);
      var_120++;
      var_118 += 10;

      if(var_118 > 5000) {
        var_118 = 0;
        var_119 += 10;

        if(var_119 > 100) {
          var_119 = 0;
        }
      }

      if(var_120 > 8) {
        waitframe();
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "dieToZombie")) {
    var_94 = var_14[0];
    var_115 = var_13[1];
    var_83 = var_13[2];

    if(var_115 == var_1) {
      var_115 = var_13[0];
    } else if(var_83 == var_1) {
      var_83 = var_13[0];
    }

    kick(var_83 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    var_1 scripts\mp\gametypes\br_alt_mode_zxp::ref_12723(0);
    wait 2;
    vo_nag_mark_crates(var_1, var_1, undefined, var_94);
    var_1 waittill("killcam_ended");
    wait 2;
    var_115.br_infilstarted = 1;
    vo_nag_mark_crates(var_1, var_115, undefined, var_94);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "zombieSpectatePing")) {
    var_94 = var_14[0];
    var_115 = var_13[1];
    var_83 = var_13[2];

    if(var_115 == var_1) {
      var_115 = var_13[0];
    } else if(var_83 == var_1) {
      var_83 = var_13[0];
    }

    kick(var_83 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    var_1 scripts\mp\gametypes\br_alt_mode_zxp::ref_12723(0);
    var_115 scripts\mp\gametypes\br_alt_mode_zxp::ref_12723(0);
    wait 2;
    vo_nag_mark_crates(var_1, var_1, undefined, var_94);
    var_1 waittill("killcam_ended");
    wait 2;
    var_122 = scripts\mp\gametypes\br_gametype_zxp::spawndogtags();
    scripts\mp\gametypes\br_gametype_zxp::ref_13238(var_122, (0, 0, 200));

    for(var_123 = var_1 getnodeoffset_code(7); var_123 == -1; var_123 = var_1 getnodeoffset_code(7)) {
      waitframe();
    }

    wait 2;
    var_115 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
    var_1 scripts\mp\gametypes\br_alt_mode_zxp::wait_for_chopper_boss_finish_turning(var_115);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "endGameZombieSpectate")) {
    setDvar("br_minplayers", 8);
    wait 5;
    var_94 = var_14[0];
    var_115 = var_13[1];
    var_83 = var_13[2];

    if(var_115 == var_1) {
      var_115 = var_13[0];
    } else if(var_83 == var_1) {
      var_83 = var_13[0];
    }

    kick(var_83 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    var_115 scripts\mp\gametypes\br_alt_mode_zxp::ref_12723(0);
    wait 2;
    vo_nag_mark_crates(var_1, var_1, undefined, var_94);
    var_1 waittill("killcam_ended");
    wait 2;
    vo_nag_mark_crates(var_1, var_14[2], undefined, var_1);
    vo_nag_mark_crates(var_1, var_14[1], undefined, var_1);
    vo_nag_mark_crates(var_1, var_14[0], undefined, var_1);
    vo_nag_mark_crates(var_1, var_15[2], undefined, var_1);
    vo_nag_mark_crates(var_1, var_15[1], undefined, var_1);
    vo_nag_mark_crates(var_1, var_15[0], undefined, var_1);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "buyback2")) {
    setDvar("scr_br_fc_jailTimeout", -1);
    var_94 = var_14[0];
    var_115 = var_13[1];
    var_83 = var_13[2];

    if(var_115 == var_1) {
      var_115 = var_13[0];
    } else if(var_83 == var_1) {
      var_83 = var_13[0];
    }

    kick(var_83 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    vo_nag_mark_crates(var_1, var_115, undefined, var_94);
    var_1 scripts\engine\utility::waittill_notify_or_timeout("killcam_ended", 8);
    wait 2;
    var_1 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
    var_115 thread scripts\mp\gametypes\br_gulag::playergulagautowin("dev", var_1, 0);
    vo_nag_mark_crates(var_1, var_1, undefined, var_94);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "throwback")) {
    var_1 setOrigin((1710, -1703, 58));
    var_1 setplayerangles((19, 268, 0));
    waitframe();
    waitframe();

    while(!var_1 isthrowingbackgrenade()) {
      waitframe();
    }

    wait 0.5;
    var_1 scripts\mp\gametypes\br_pickups::ref_1298f(9);
    wait 0.5;
    var_124 = var_1 getcurrentprimaryweapon();

    if(var_124.basename != "iw8_fists_mp") {
      var_1 scripts\mp\gametypes\br_pickups::ref_1298f(9);
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "respawnPayload")) {
    while(!var_1 isspectatingplayer()) {
      waitframe();
    }

    var_26 = var_1 getspectatingplayer();
    wait 1;
    vo_nag_mark_crates(var_1, var_26, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "gulag12")) {
    var_94 = var_14[0];
    var_94.br_infilstarted = 1;
    killplayer(var_1, var_94, var_15);
    var_115 = var_13[1];

    if(var_115 == var_1) {
      var_115 = var_13[0];
    }

    var_115.br_infilstarted = 1;
    killplayer(var_1, var_115, var_15);

    while(!istrue(var_94.gulagarena) || !istrue(var_115.gulagarena)) {
      waitframe();
    }

    wait 5;
    killplayer(var_1, var_115, undefined, var_94);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "helimg")) {
    var_26 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        if(!isDefined(var_26)) {
          var_26 = var_9;
          break;
        }
      }
    }

    wait 1;
    var_81 = undefined;
    var_82 = undefined;

    if(isDefined(level.vehicle.instances["little_bird_mg"])) {
      var_80 = getarraykeys(level.vehicle.instances["little_bird_mg"]);

      if(var_80.size > 0) {
        var_81 = level.vehicle.instances["little_bird_mg"][var_80[0]];
      }
    }

    if(!isDefined(var_81)) {
      var_127 = spawnStruct();
      var_127.origin = (1000, -2000, 100);
      var_127.angles = (0, 0, 0);
      var_127.owner = var_1;
      var_127.spawntype = "DEVGUI";
      var_81 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var_127);
    }

    var_82 = var_81 getlinkedscriptableinstance();
    var_26 setOrigin(var_81.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var_82, "single", "vehicle_use", var_26, 0);
    wait 5;
    var_128 = "br_gunner";
    var_129 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_81, var_26);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_81, var_128, var_26);
    var_26 dodamage(500, var_14[0].origin, var_14[0], undefined, "MOD_EXPLOSIVE", var_14[0] getcurrentprimaryweapon());
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "helimg2")) {
    wait 1;
    var_81 = undefined;
    var_82 = undefined;

    if(isDefined(level.vehicle.instances["little_bird_mg"])) {
      var_80 = getarraykeys(level.vehicle.instances["little_bird_mg"]);

      if(var_80.size > 0) {
        var_81 = level.vehicle.instances["little_bird_mg"][var_80[0]];
      }
    }

    if(!isDefined(var_81)) {
      var_127 = spawnStruct();
      var_127.origin = (1000, -2000, 100);
      var_127.angles = (0, 0, 0);
      var_127.owner = var_1;
      var_127.spawntype = "DEVGUI";
      var_81 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var_127);
    }

    var_82 = var_81 getlinkedscriptableinstance();
    var_1 setOrigin(var_81.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var_82, "single", "vehicle_use", var_1, 0);
    wait 5;
    var_128 = "br_gunner";
    var_129 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_81, var_1);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_81, var_128, var_1);

    if(!var_1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var_1 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    }

    var_1 dodamage(500, var_14[0].origin, var_14[0], undefined, "MOD_EXPLOSIVE", var_14[0] getcurrentprimaryweapon());
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "truckmg")) {
    var_26 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        if(!isDefined(var_26)) {
          var_26 = var_9;
          break;
        }
      }
    }

    wait 1;
    var_132 = undefined;
    var_82 = undefined;

    if(isDefined(level.vehicle.instances["cargo_truck_mg"])) {
      var_80 = getarraykeys(level.vehicle.instances["cargo_truck_mg"]);

      if(var_80.size > 0) {
        var_132 = level.vehicle.instances["cargo_truck_mg"][var_80[0]];
      }
    }

    if(!isDefined(var_132)) {
      var_127 = spawnStruct();
      var_127.origin = (400, -2100, 100);
      var_127.angles = (0, 0, 0);
      var_127.owner = var_1;
      var_127.spawntype = "DEVGUI";
      var_132 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var_127);
    }

    var_133 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cargo_truck_mg");

    foreach(var_129, var_135 in var_133.ref_11fa5) {
      var_133.ref_11fa5[var_129] = 1;
    }

    foreach(var_129, var_135 in var_133.ref_11fa4) {
      var_133.ref_11fa4[var_129] = 500;
    }

    var_82 = var_132 getlinkedscriptableinstance();
    var_26 setOrigin(var_132.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var_82, "single", "vehicle_use", var_26, 0);
    wait 5;
    var_137 = "gunner";
    var_129 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_132, var_26);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_132, var_137, var_26);

    if(!var_26 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var_26 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    }

    var_26 dodamage(500, var_14[0].origin, var_14[0], undefined, "MOD_RIFLE_BULLET", var_14[0] getcurrentprimaryweapon());
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "truckmg2")) {
    wait 1;
    var_132 = undefined;
    var_82 = undefined;

    if(isDefined(level.vehicle.instances["cargo_truck_mg"])) {
      var_80 = getarraykeys(level.vehicle.instances["cargo_truck_mg"]);

      if(var_80.size > 0) {
        var_132 = level.vehicle.instances["cargo_truck_mg"][var_80[0]];
      }
    }

    if(!isDefined(var_132)) {
      var_127 = spawnStruct();
      var_127.origin = (400, -2100, 100);
      var_127.angles = (0, 0, 0);
      var_127.owner = var_1;
      var_127.spawntype = "DEVGUI";
      var_132 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var_127);
    }

    var_133 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cargo_truck_mg");

    foreach(var_129, var_135 in var_133.ref_11fa5) {
      var_133.ref_11fa5[var_129] = 1;
    }

    foreach(var_135 in var_133.ref_11fa4) {
      var_133.ref_11fa4[var_129] = 500;
    }

    var_82 = var_132 getlinkedscriptableinstance();
    var_1 setOrigin(var_132.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var_82, "single", "vehicle_use", var_1, 0);
    wait 5;
    var_137 = "gunner";
    var_129 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_132, var_1);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_132, var_137, var_1);

    if(!var_1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var_1 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    }

    for(var_140 = getdvarint("scr_test_frames", 1); var_140 > 0; var_140--) {
      waitframe();
    }

    var_1 dodamage(500, var_14[0].origin, var_14[0], undefined, "MOD_RIFLE_BULLET", var_14[0] getcurrentprimaryweapon());
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "exfil_spectate")) {
    setDvar("br_minplayers", 8);
    wait 5;
    var_26 = var_13[1];

    if(var_26 == var_1) {
      var_26 = var_13[0];
    }

    foreach(var_9 in var_13) {
      if(var_9 == var_1 || var_9 == var_26) {
        continue;
      }

      vo_nag_mark_crates(var_1, var_9, var_14);
    }

    foreach(var_9 in var_15) {
      vo_nag_mark_crates(var_1, var_9, var_14);
    }

    wait 2;
    vo_nag_mark_crates(var_1, var_1, var_14);
    var_1 waittill("killcam_ended");
    wait 2;
    vo_nag_mark_crates(var_1, var_26, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "simulKill")) {
    setDvar("br_minplayers", 8);
    wait 5;
    var_26 = var_13[1];

    if(var_26 == var_1) {
      var_26 = var_13[0];
    }

    var_94 = var_14[0];
    var_95 = var_15[0];

    foreach(var_33 in var_14) {
      if(var_33 == var_94) {
        continue;
      }

      vo_nag_mark_crates(var_1, var_33, undefined, var_1);
    }

    foreach(var_33 in var_15) {
      if(var_33 == var_95) {
        continue;
      }

      vo_nag_mark_crates(var_1, var_33, undefined, var_1);
    }

    foreach(var_62 in var_13) {
      if(var_62 == var_26 || var_62 == var_1) {
        continue;
      }

      kick(var_62 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    }

    wait 5;
    thread vo_nag_mark_crates(level, var_1, var_94, undefined);
    thread vo_nag_mark_crates(level, var_1, var_95, undefined);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "fd_shoot_1")) {
    var_1 setOrigin((12799, 16985, 10014));
    var_1 setplayerangles((351, 35, 0));
    var_151 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_give_weapon();
    var_152 = spawnturret("misc_turret", (23271, 24389, 13789), var_151, 0);
    var_74 = vectorNormalize(var_1 getEye() - var_152.origin);
    var_153 = vectortoangles(var_74);
    var_152.angles = var_153;
    var_152 setModel("veh_s4_mil_air_dalpha_wz_turret_attach");
    var_152 setmode("manual_target");
    var_152 setsentryowner(undefined);
    var_152 makeunusable();
    var_152 setdefaultdroppitch(0);
    var_152 setturretmodechangewait(1);
    var_154 = 0;

    for(;;) {
      if(getdvarint("test_force", 0)) {
        setDvar("test_force", 0);
        var_154 = !var_154;
        var_152 unmarkkeyframedmover(var_154);
      }

      var_152 shootturret("tag_barrel");
      waitframe();
    }

    return;
  }
}

function ref_126b5() {
  var_0 = spawnStruct();
  var_0.scriptablename = "brloot_killstreak_recondrone";
  var_0.count = 1;
  scripts\mp\gametypes\br_pickups::takesuperpickup(var_0);
  wait 1;
  var_1 = getcompleteweaponname("super_default_mp");
  scripts\mp\supers::trysuperusebegin(var_1);

  while(self getcurrentprimaryweapon().basename != "ks_remote_drone_mp") {
    waitframe();
  }
}

function ref_14366(var_0, var_1) {
  wait var_0;
  var_1 suicide();
}

function ref_12078() {
  level notify("onPrematchFadeDoneClear");
  thread ref_12077();
  var_0 = undefined;

  if(!istrue(level.br_infils_disabled) && !scripts\mp\gametypes\br_public::isusinginfilselection()) {
    var_0 = scripts\mp\gametypes\br_c130::createtestc130path();
  }

  waitframe();
  var_1 = 0;
  level.debugnextpropindex = 0;
  level.delay_music_reinforcements = 0;
  scripts\mp\gametypes\br_infils::clear_tier_lights(var_0, "player");
  level thread scripts\mp\gametypes\br_c130::waittoplayinfildialog();
  level notify("infils_ready");
}

function ref_12077() {
  var_0 = 1.4;
  level endon("onPrematchFadeDoneClear");

  if(!isDefined(level.ref_136de)) {
    level.ref_136de = 1;
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level thread scripts\mp\gametypes\br::resetalldoors(var_0 * 1.5);
  level thread scripts\cp\vehicles\little_bird_mg_cp::fulton_destroy(1);
  level thread scripts\mp\gametypes\br_vehicles::brvehicleonprematchstarted();
  level thread scripts\mp\gametypes\br_functional_poi::onprematchdone();
  scripts\mp\gametypes\br::has_focus_fire_objective();
  scripts\mp\gametypes\br_vehicles::emptyallvehicles();

  foreach(var_2 in level.players) {
    var_2 scripts\mp\gametypes\br_infils::setplayerprematchallows();
    var_2 thread scripts\mp\gametypes\br_pickups::resetplayerinventory();

    if(istrue(var_2.hasspawned)) {
      if(istrue(var_2.usingascender)) {
        var_2 scripts\cp_mp\auto_ascender::canseesafecircleui();
      }

      var_2 thread scripts\mp\weapons::deleteplacedequipment(1);
    }
  }

  foreach(var_2 in level.players) {
    if(isDefined(var_2.burninginfo)) {
      var_2 scripts\mp\equipment\molotov::molotov_clear_burning();
    }

    var_2 scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
  }

  level notify("prematch_cleanup");

  if(!istrue(level.br_circle_disabled)) {
    level thread scripts\mp\gametypes\br_circle::ref_12e09(1);
    return;
  }
}

function ref_12f81(var_0, var_1) {
  if(!isDefined(level.br_circle.safecircleent)) {
    thread scripts\mp\gametypes\br_circle::ref_12e09(1);
    level.br_circle thread scripts\mp\gametypes\br_circle::circledamagetick();
  }

  waitframe();
  level notify("CirclePeekCleanup");
  var_2 = 1;
  level.br_circle.starttime = gettime();
  level.br_circle.circleindex = var_2;
  var_3 = var_2 == 0;
  var_4 = var_2 == level.br_level.br_circleclosetimes.size - 1;
  var_5 = level.br_level.br_circledelaytimes[var_2];
  var_6 = level.br_level.br_circleclosetimes[var_2];
  var_7 = level.br_level.br_circleradii[var_2 + 1];
  setomnvar("ui_br_circle_num", var_2 + 1);
  level.br_circle.centertarget = var_0;
  level.br_circle.safecircleent.origin = var_0;
  level.br_circle.dangercircleui.hidden = 0;
  level.br_circle.dangercircleent.hidden = 0;
  level.br_circle.safecircleui.hidden = 0;
  level.br_circle.safecircleent.hidden = 0;
  level notify("update_circle_hide");
  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = var_0 + (0, 0, var_1);
  scripts\mp\gametypes\br_circle::setstaticuicircles(999, level.br_circle.safecircleui, level.br_circle.dangercircleui, var_4);
  level notify("br_circle_set");
  waitframe();
  level notify("br_circle_started");
  level.br_circle.dangercircleent brcirclemoveTo(var_0[0], var_0[1], var_1, 1);
}

function ref_126c5(var_0, var_1) {
  if(self calloutmarkerping_getEnt()) {
    self allowmovement(0);
    self allowfire(0);
    self allowmelee(0);
  }

  var_2 = self getentitynumber();

  if(isDefined(level.level_logic[var_2])) {
    var_0 = level.level_logic[var_2];
  } else {
    var_3 = anglesToForward((0, 0, 0));
    var_0 += var_3 * var_1 * 50;
    var_0 = getgroundposition(var_0, 15, 100);
  }

  self setOrigin(var_0);
  self setplayerangles((0, 0, 0));

  if(!isDefined(level.level_logic[var_2])) {
    level.level_logic[var_2] = var_0;
    return;
  }
}

function killplayer(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = reset_button_handler(var_0, var_1.origin, var_2);
  }

  var_1 dodamage(500, var_3.origin, var_3, undefined, "MOD_EXPLOSIVE", var_3 getcurrentprimaryweapon());
  wait 1;

  while(isalive(var_1)) {
    var_1 dodamage(500, var_3.origin, var_3, undefined, "MOD_EXPLOSIVE", var_3 getcurrentprimaryweapon());
    waitframe();
  }

  return var_3;
}

function vo_nag_mark_crates(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = reset_button_handler(var_0, var_1.origin, var_2);
  }

  if(!isDefined(var_3)) {
    var_3 = var_1;
  }

  if(!istrue(var_4) && var_1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    var_1 scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
  }

  while(isalive(var_1)) {
    var_1 dodamage(500, var_3.origin, var_3, undefined, "MOD_EXPLOSIVE", var_3 getcurrentprimaryweapon());

    if(!isalive(var_1)) {
      break;
    }

    waitframe();
  }

  return var_3;
}

function ref_1294d(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = reset_button_handler(var_0, var_1.origin, var_2);
  }

  if(!isDefined(var_3)) {
    var_3 = var_1;
  }

  if(!var_1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    var_1 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
  }

  while(!istrue(var_1.inlaststand)) {
    var_1 dodamage(30, var_3.origin, var_3, undefined, "MOD_EXPLOSIVE", var_3 getcurrentprimaryweapon());
    wait 0.1;
  }

  return var_3;
}

function reset_button_handler(var_0, var_1, var_2) {
  var_2 = sortbydistance(var_2, var_1);

  if(isalive(var_2[0])) {
    var_3 = distance2dsquared(var_1, var_2[0].origin);

    if(var_3 < 40000) {
      return var_2[0];
    }
  }

  var_4 = undefined;

  for(var_5 = 1; var_5 < var_2.size; var_5++) {
    var_6 = var_2[var_5];

    if(isalive(var_6)) {
      var_4 = var_6;
      break;
    }
  }

  return var_4;
}

function remove_map_hint(var_0) {
  if(isDefined(level.level_offhand_spawn)) {
    return level.level_offhand_spawn;
  }

  var_1 = scripts\mp\gamelogic::gethostplayer();

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "clientHost")) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && !var_3 calloutmarkerping_getEnt() && (!isDefined(var_1) || var_3 != var_1)) {
        var_1 = var_3;
        break;
      }
    }
  } else if(!isDefined(var_1)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && !var_3 calloutmarkerping_getEnt()) {
        level.level_offhand_spawn = var_3;
        var_1 = var_3;
        break;
      }
    }
  } else {
    level.maxteamsize = 3;
  }

  if(!isDefined(level.level_offhand_spawn)) {
    level.level_offhand_spawn = var_1;
  }

  return var_1;
}

function calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return true;
    }
  }

  return false;
}

function ref_12d1c(var_0, var_1) {
  var_2 = level.teamdata[var_1]["players"];
  var_3 = 0;

  foreach(var_5 in var_2) {
    if(!isalive(var_5) || var_5.sessionstate != "playing") {
      var_6 = var_5 getentitynumber();

      if(isDefined(level.level_logic[var_6])) {
        var_5.forcespawnangles = (0, 0, 0);
        var_5.forcespawnorigin = level.level_logic[var_6];
      } else {
        var_5.forcespawnangles = var_5.angles;
        var_5.forcespawnorigin = var_5.origin;
      }

      ref_13623(var_5, 0);
      var_3 = 1;
    }

    if(istrue(var_5.delay_enter_combat_after_investigating_grenade)) {
      scripts\mp\gametypes\br::ref_13f21(var_5, "reviveTeam");
    }
  }

  if(var_3) {
    var_0 iprintlnbold("Reviving Team: " + var_1);
    wait 1;
    return;
  }
}

function run_current_spawn_group(var_0, var_1) {
  var_2 = 0;

  if(level.teamdata[var_1]["teamCount"] < level.maxteamsize) {
    var_2 = level.maxteamsize - level.teamdata[var_1]["teamCount"];
  }

  if(var_2 > 0) {
    level.ref_11c84 = &ref_13623;
    var_3 = level.players.size;
    addbots(var_2, var_1);
    var_0 iprintlnbold("Spawning Team: " + var_1);
    var_4 = gettime() + 10000;

    while(gettime() < var_4 && level.teamdata[var_1]["aliveCount"] < level.maxteamsize) {
      waitframe();
    }

    level.ref_11c84 = &scripts\mp\gametypes\br::spawnclientbr;
  }

  return level.teamdata[var_1]["alivePlayers"];
}

function addbots(var_0, var_1) {
  setDvar("bot_spawnControlledByDvar", "1");

  if(!isDefined(var_1)) {
    var_1 = "autoassign";
  }

  level thread[[level.bot_funcs["bots_spawn"]]](var_0, var_1);

  if(level.matchmakingmatch) {
    setmatchdata("hasBots", 1);
    return;
  }
}

function ref_13623(var_0) {
  self.class = scripts\mp\gametypes\br::ref_1234a();
  self.pers["class"] = self.class;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self freezecontrols(1);
  waitframe();
  self skydive_setdeploymentstatus(0);
  self skydive_setbasejumpingstatus(0);
  var_1 = !self calloutmarkerping_getEnt();

  if(var_1) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;
  self freezecontrols(0);
}

function showsplash(var_0) {
  foreach(var_2 in level.players) {
    var_2 scripts\mp\hud_message::showsplash(var_0);
  }
}