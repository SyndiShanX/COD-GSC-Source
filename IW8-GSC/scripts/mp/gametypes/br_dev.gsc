/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_dev.gsc
***********************************************/

function init() {}

function hidehudintermission(var0, var1) {
  level notify("commandWatcher_" + var0);
  level endon("commandWatcher_" + var0);
  setDvar(var0, "");

  for(;;) {
    waitframe();
    var2 = getDvar(var0);

    if(var2 == "") {
      continue;
    }

    setDvar(var0, "");
    var3 = strtok(var2, " ");

    if(!isDefined(var3) || var3.size < 1) {
      continue;
    }

    var4 = var3[0];
    var5 = scripts\engine\utility::array_slice(var3, 1);
    [[var1]](var4, var5);
  }
}

function setup_level_for_nightvision(var0, var1) {
  if(!isDefined(level.setup_manned_turret)) {
    return;
  }

  foreach(var3 in level.setup_manned_turret) {
    [[var3]](var0, var1);
  }
}

function ref_12b21(var0) {
  if(!isDefined(level.setup_manned_turret)) {
    level.setup_manned_turret = [];
  }

  level.setup_manned_turret[level.setup_manned_turret.size] = var0;
}

function setup_lights_in_region(var0, var1) {
  switch (var0) {
    case "st":
      thread level_getspawnpoint(var1);
      break;
    case "payload2":
      thread scripts\mp\gametypes\br_gametype_payload_dev::ref_12e0a(var1);
      break;
    default:
      break;
  }
}

function level_getspawnpoint(var0) {
  level notify("devScriptedTests");
  level endon("devScriptedTests");
  var1 = remove_map_hint(var0);

  if(!isDefined(var1)) {
    return;
  }

  var2 = [scripts\mp\gametypes\br::createspawnlocation((-21500, 46200, -300), 0, 6000), scripts\mp\gametypes\br::createspawnlocation((51000, -39000, 1401), 0, 4000), scripts\mp\gametypes\br::createspawnlocation((32000, 40000, 767), 0, 5500), scripts\mp\gametypes\br::createspawnlocation((23000, -15000, -158), 0, 6000)];

  if(!scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    var2 = undefined;
  }

  if(istrue(level.usegulag)) {
    foreach(var4 in level.gulag.arenas) {
      var4.matches = [];
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
  setDvar("NKOLRNSOKM", 1);
  setDvar("br_minplayers", 150);
  setDvar("live_lobby_minplayers_start", 150);
  setDvar("scr_br_fc_forceArena", -1);
  setDvar("scr_br_spectateMinStreamWaitDebug", 0);
  setDvar("scr_br_gulag_win_hold", 0);
  setDvar("scr_br_hold_in_gulag", 0);

  if(isDefined(level.gulag) && istrue(level.gulag.shutdown)) {
    foreach(var4 in level.gulag.arenas) {
      var4.shutdown = undefined;
    }

    level.gulag.shutdown = undefined;
  }

  foreach(var9 in level.players) {
    if(var9 calloutmarkerping_getEnt()) {
      var9 allowmovement(0);
      var9 allowfire(0);
      var9 allowmelee(0);
    }

    var9.br_infilstarted = undefined;
    var9.gulag = undefined;
    var9.jailed = undefined;
    var9.gulagarena = undefined;
    var9.ref_14439 = undefined;
    var9.ref_126cc = undefined;
    var9.ref_11e80 = undefined;
    var9.gulagloser = undefined;
    var9.gulaguses = undefined;
    var9.ref_119d7 = undefined;
    var9.set_relic_nuketimer = undefined;
    var9 notify("gulag_end");
    var9 notify("last_stand_start");
    var9 scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", var9);
    var9 setstance("stand");
    var9 calloutmarkerping_getcreatedtime(0);
    var9 playershow();
    var9.setspawnpoint = undefined;

    if(istrue(level.usegulag)) {
      var9 scripts\mp\gametypes\br_gulag::playerrespawngulagcleanup(0);
      var9 scripts\mp\gametypes\br_gulag::playergulagarenaready();
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
    for(var11 = 0; var11 < level.teamnamelist.size; var11++) {
      var12 = level.teamnamelist[var11];

      if(var12 != var1.team) {
        if(!isDefined(level.level_killstreak_spawn)) {
          level.level_killstreak_spawn = var12;
          continue;
        }

        level.level_light = var12;
        break;
      }
    }
  }

  ref_12d1c(var1, var1.team);
  ref_12d1c(var1, level.level_killstreak_spawn);

  if(isDefined(level.level_light)) {
    ref_12d1c(var1, level.level_light);
  }

  var13 = run_current_spawn_group(var1, var1.team);
  var14 = run_current_spawn_group(var1, level.level_killstreak_spawn);
  var15 = [];

  if(isDefined(level.level_light)) {
    var15 = run_current_spawn_group(var1, level.level_light);
  }

  for(var11 = 0; var11 < var13.size; var11++) {
    var16 = var13[var11];
    var17 = var14[var11];
    var18 = undefined;

    if(isDefined(level.level_light)) {
      var18 = var15[var11];
    }

    var19 = undefined;

    if(isDefined(var2)) {
      var19 = var2[var11].origin;
    } else {
      var19 = var16.origin;
    }

    ref_126c5(var16, var19, 0);
    ref_126c5(var17, var19, 1);

    if(isDefined(level.level_light)) {
      ref_126c5(var18, var19, 2);
    }
  }

  level.disablespawning = 1;
  var20 = scripts\mp\utility\game::getlivingplayers();
  level.totalplayers = var20.size;
  var1 iprintlnbold("Test ready");
  wait 2;

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "killcam1") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "killchain") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "disconnect1") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "disconnect2") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "disconnect3")) {
    killplayer(var1, var1, var14);

    if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "disconnect2")) {
      while(var1.sessionstate != "intermission") {
        waitframe();
      }

      while(var1.sessionstate == "intermission") {
        waitframe();
      }
    } else if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "disconnect3")) {
      while(var1.sessionstate != "intermission") {
        waitframe();
      }

      wait 0.5;
    } else {
      scripts\mp\gametypes\br_spectate::ref_143fa(var1);
      wait 3;

      if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "disconnect1")) {
        var1 iprintlnbold("Waiting");
        wait 10;
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "disconnect1") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "disconnect2") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "disconnect3")) {
    var21 = var1 scripts\mp\gametypes\br_spectate::ref_12580();
    kick(var21 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "killchain")) {
    for(var21 = var1 scripts\mp\gametypes\br_spectate::ref_12580(); !isDefined(var21); var21 = var1 scripts\mp\gametypes\br_spectate::ref_12580()) {
      waitframe();
    }

    killplayer(var1, var21, var14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "killchain")) {
    for(var21 = var1 scripts\mp\gametypes\br_spectate::ref_12580(); !isDefined(var21); var21 = var1 scripts\mp\gametypes\br_spectate::ref_12580()) {
      waitframe();
    }

    killplayer(var1, var21, var14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "killchain")) {
    for(var21 = var1 scripts\mp\gametypes\br_spectate::ref_12580(); !isDefined(var21); var21 = var1 scripts\mp\gametypes\br_spectate::ref_12580()) {
      waitframe();
    }

    killplayer(var1, var21, var15);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "killchain")) {
    for(var21 = var1 scripts\mp\gametypes\br_spectate::ref_12580(); !isDefined(var21); var21 = var1 scripts\mp\gametypes\br_spectate::ref_12580()) {
      waitframe();
    }

    killplayer(var1, var21, var15);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "killchain")) {
    for(var21 = var1 scripts\mp\gametypes\br_spectate::ref_12580(); !isDefined(var21); var21 = var1 scripts\mp\gametypes\br_spectate::ref_12580()) {
      waitframe();
    }

    killplayer(var1, var21, var15);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag1")) {
    foreach(var9 in var13) {
      if(var9 != var1) {
        var9.br_infilstarted = 1;
        killplayer(var1, var9, var14);
      }
    }

    wait 10;
    killplayer(var1, var1, var14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag2") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag3")) {
    killplayer(var1, var1, var14);
    var1 waittill("killcam_ended");
    wait 2;

    foreach(var9 in var13) {
      if(var9 != var1) {
        var9.br_infilstarted = 1;
        killplayer(var1, var9, var14);
      }
    }

    while(!isDefined(var1 getspectatingplayer())) {
      waitframe();
    }

    var26 = var1 getspectatingplayer();
    var26.br_infilstarted = 1;
    wait 1;

    foreach(var9 in var14) {
      var9.br_infilstarted = 1;
      killplayer(var1, var9, var15);
    }

    while(!istrue(var26.gulagarena)) {
      waitframe();
    }

    wait 5;

    if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag2")) {
      var29 = spawnStruct();
      var29.playerspawnpos = (26474, -16709, -162);
      var29.playerspawnangles = (85, 135, 0);
      var26.setspawnpoint = var29;

      foreach(var9 in var14) {
        if(istrue(var9.gulagarena)) {
          var9.br_infilstarted = 1;
          killplayer(var1, var9, var15);
          break;
        }
      }

      while(!var26 islinked()) {
        waitframe();
      }

      while(var26 islinked()) {
        waitframe();
      }

      waitframe();
      var32 = var26 getplayerangles();
      var26 setplayerangles((85, var32[1], 0));
    } else {
      killplayer(var1, var26, var15);
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag4")) {
    var1.br_infilstarted = 1;
    var33 = killplayer(var1, var1, var14);
    var33.br_infilstarted = 1;
    killplayer(var1, var33, var13);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulaggulag")) {
    var34 = getdvarint("scr_br_fc_arena1", 0);
    var35 = getdvarint("scr_br_fc_arena2", 5);
    setDvar("scr_br_fc_jailTimeout", 9999);
    setDvar("scr_br_fc_forceArena", var34);
    var1.br_infilstarted = 1;
    var33 = killplayer(var1, var1, var14);
    setDvar("scr_br_fc_forceArena", var35);

    foreach(var9 in var13) {
      if(var9 != var1) {
        var9.br_infilstarted = 1;
        killplayer(var1, var9, var14);
      }
    }

    setDvar("scr_br_fc_forceArena", var34);
    var33.br_infilstarted = 1;
    killplayer(var1, var33, var15);

    while(!istrue(var1.gulagarena) && !istrue(var33.gulagarena)) {
      waitframe();
    }

    wait 5;
    killplayer(var1, var1, undefined, var33);
    setDvar("scr_br_fc_jailTimeout", 90);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "killkill")) {
    var33 = var14[0];

    foreach(var9 in var13) {
      if(var9 != var1) {
        killplayer(var1, var9, undefined, var33);
      }
    }

    killplayer(var1, var33, undefined, var1);
    wait 10;
    killplayer(var1, var1, undefined, var33);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "killcam2")) {
    var33 = killplayer(var1, var1, var14);
    wait 3;
    killplayer(var1, var1.ref_11e80, var14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag5") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag6")) {
    var40 = undefined;

    foreach(var9 in var13) {
      if(!isDefined(var40) && var9 != var1) {
        var40 = var9;
        continue;
      }

      killplayer(var1, var9, var14);
      scripts\mp\gametypes\br_spectate::ref_143fa(var9);
    }

    var40.br_infilstarted = 1;

    if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag6")) {
      setDvar("scr_br_fc_jailTimeout", 9999);
      var34 = getdvarint("scr_br_fc_arena1", 5);
      setDvar("scr_br_fc_forceArena", var34);
      var40.ref_119d7 = 1;
    }

    killplayer(var1, var40, var14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag7")) {
    killplayer(var1, var1, var14);
    var1 waittill("killcam_ended");
    wait 2;
    var43 = undefined;

    foreach(var9 in var13) {
      if(var9 != var1) {
        var9.br_infilstarted = 1;
        var43 = var9;
        var43 scripts\mp\gametypes\br_gulag::initplayerjail();
        break;
      }
    }

    while(!isDefined(var1 getspectatingplayer())) {
      waitframe();
    }

    wait 1;
    var46 = undefined;

    foreach(var9 in var14) {
      var9.br_infilstarted = 1;
      var46 = var9;
      killplayer(var1, var9, var15);
      break;
    }

    while(!istrue(var43.gulagarena) && !istrue(var46.gulagarena)) {
      waitframe();
    }

    wait 5;
    setDvar("scr_br_gulag_win_hold", 1);
    killplayer(var1, var46, undefined, var43);

    while(var1 getspectatingplayer() != var43) {
      wait 1;
    }

    wait 5;
    setDvar("scr_br_gulag_win_hold", 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag8")) {
    level.gulag.timelimit = 3;
    setDvar("scr_br_fc_overtime", 3);
    setDvar("scr_br_fc_jailTimeout", -1);
    killplayer(var1, var1, var14);
    var1 waittill("killcam_ended");
    wait 2;
    var43 = undefined;

    foreach(var9 in var13) {
      if(var9 != var1) {
        var9.br_infilstarted = 1;
        var43 = var9;
        var43 scripts\mp\gametypes\br_gulag::initplayerjail();
        break;
      }
    }

    while(!isDefined(var1 getspectatingplayer())) {
      waitframe();
    }

    while(var1 getspectatingplayer() != var43) {
      iprintlnbold("Switch to spectating gulag player");
      waitframe();
    }

    wait 1;
    var46 = undefined;

    foreach(var9 in var14) {
      var9.br_infilstarted = 1;
      var46 = var9;
      killplayer(var1, var9, var15);
      break;
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag9")) {
    var1.br_infilstarted = 1;
    var33 = killplayer(var1, var1, var14);
    var33.br_infilstarted = 1;
    killplayer(var1, var33, var13);

    foreach(var9 in var13) {
      if(var9 != var1) {
        killplayer(var1, var9, var14);
      }
    }

    foreach(var9 in var14) {
      if(var9 != var33) {
        killplayer(var1, var9, var15);
      }
    }

    while(!istrue(var1.gulagarena)) {
      waitframe();
    }

    wait 5;
    setDvar("scr_br_gulag_win_hold", 1);
    setDvar("scr_br_spectateMinStreamWaitDebug", 3);
    killplayer(var1, var1, undefined, var33);
    wait 9;
    setDvar("scr_br_gulag_win_hold", 0);
    setDvar("scr_br_spectateMinStreamWaitDebug", 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag10")) {
    var57 = var14[0];
    var57.br_infilstarted = 1;
    killplayer(var1, var57, var15);
    var58 = var15[0];
    var58.br_infilstarted = 1;
    killplayer(var1, var58, var14);
    wait 1;
    var59 = var1;
    var59.br_infilstarted = 1;
    killplayer(var1, var59, var14);
    var60 = var14[1];
    var60.br_infilstarted = 1;
    killplayer(var1, var60, var15);

    while(!istrue(var57.gulagarena) || !istrue(var58.gulagarena) || !istrue(var59.jailed) || !istrue(var60.jailed)) {
      waitframe();
    }

    setDvar("scr_br_hold_in_gulag", 1);
    var61 = var15[1];
    var61.br_infilstarted = 1;
    killplayer(var1, var61, var14);
    wait 1;

    while(istrue(var61.set_relic_steelballs_perks)) {
      waitframe();
    }

    scripts\mp\gametypes\br_gulag::shutdowngulag("circle_index", 0);
    wait 1;
    kick(var61 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    wait 3;
    setDvar("scr_br_hold_in_gulag", 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag11")) {
    var1.br_infilstarted = 1;
    ref_1294d(var1, var1, var15);
    wait 1;
    scripts\mp\gametypes\br_gulag::shutdowngulag("circle_index", 0);
    wait 1;
    var1 scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", var1);
    wait 5;
    killplayer(var1, var1, var14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulagVIP")) {
    var62 = undefined;

    foreach(var9 in var13) {
      if(var9 != var1) {
        var62 = var9;
        break;
      }
    }

    var1.br_infilstarted = 1;
    killplayer(var1, var1, var14);
    var65 = getdvarfloat("scr_gulagvip_wait", 0.1);
    wait var65;
    scripts\mp\gametypes\br_vip_quest::ref_142c5(var1, var62, "vip");
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "twooneframe")) {
    foreach(var9 in var13) {
      if(var9 != var1) {
        killplayer(var1, var9, var14);
        break;
      }
    }

    wait 5;

    foreach(var9 in var13) {
      if(isalive(var9)) {
        vo_nag_mark_crates(var1, var9, var14);
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "suicide")) {
    foreach(var9 in var13) {
      if(var9 != var1) {
        killplayer(var1, var9, var14);
      }
    }

    wait 5;

    if(var1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var1 scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
    }

    var1 suicide();
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "team")) {
    foreach(var9 in var13) {
      if(var9 != var1) {
        vo_nag_mark_crates(var1, var9, var14);
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "moving")) {
    vo_nag_mark_crates(var1, var1, var14);

    while(!isDefined(var1.ref_126cc)) {
      waitframe();
    }

    var9 = var1.ref_126cc;
    var74 = anglesToForward(var9.angles);
    var75 = getdvarint("testforward", 5);

    for(var76 = var1 getspectatingplayer(); !isDefined(var76); var76 = var1 getspectatingplayer()) {
      var77 = var9.origin + var74 * var75;
      var9 setOrigin(var77);
      waitframe();
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "heli1") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "heli2")) {
    var26 = undefined;

    foreach(var9 in var13) {
      if(var9 != var1) {
        if(!isDefined(var26)) {
          var26 = var9;
          continue;
        }

        vo_nag_mark_crates(var1, var9, var14);
      }
    }

    wait 1;
    vo_nag_mark_crates(var1, var1, var14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    wait 1;
    var80 = getarraykeys(level.vehicle.instances["little_bird"]);
    var81 = level.vehicle.instances["little_bird"][var80[0]];
    var82 = var81 getlinkedscriptableinstance();
    var26 setOrigin(var81.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var82, "single", "vehicle_use", var26, 0);

    if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "heli2")) {
      wait 3;
      kick(var26 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "water")) {
    var1 setOrigin((28252, -32627, -415));
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "disconnectswitch1")) {
    vo_nag_mark_crates(var1, var1, var14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    var26 = var1 scripts\mp\gametypes\br_spectate::ref_12580();

    while(!var1 buttonPressed("BUTTON_RSHLDR")) {
      waitframe();
    }

    var83 = undefined;

    foreach(var9 in var13) {
      if(var9 != var1 && var9 != var26) {
        var83 = var9;
        break;
      }
    }

    wait 0.5;
    kick(var83 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "disconnectswitch2")) {
    vo_nag_mark_crates(var1, var1, var14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    var26 = var1 scripts\mp\gametypes\br_spectate::ref_12580();

    while(!var1 buttonPressed("BUTTON_RSHLDR")) {
      waitframe();
    }

    wait 0.5;
    kick(var26 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "endspectate")) {
    level.br_infils_disabled = 1;
    setDvar("br_minplayers", 2);
    level.gulag.maxuses = 0;
    wait 1;
    vo_nag_mark_crates(var1, var1, var14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    wait 2;

    foreach(var9 in var13) {
      if(var9 != var1) {
        vo_nag_mark_crates(var1, var9, var14);
      }
    }

    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    wait 2;
    var33 = var1 scripts\mp\gametypes\br_spectate::ref_12580();
    vo_nag_mark_crates(var1, var33, var15);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    wait 2;
    var33 = var1 scripts\mp\gametypes\br_spectate::ref_12580();
    vo_nag_mark_crates(var1, var33, var15);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    wait 2;
    var33 = var1 scripts\mp\gametypes\br_spectate::ref_12580();
    vo_nag_mark_crates(var1, var33, var15);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    wait 2;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "teamwipe1")) {
    setDvar("scr_br_spectateMinStreamWaitDebug", 5);

    foreach(var9 in var13) {
      if(var9 != var1) {
        vo_nag_mark_crates(var1, var9, var14);
      }
    }

    wait getdvarfloat("test_teamwipe", 5);
    var33 = vo_nag_mark_crates(var1, var1, var14);
    wait getdvarfloat("test_teamwipe2", 13);
    vo_nag_mark_crates(var1, var33, var15);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "deathswitch1")) {
    setDvar("scr_br_spectateMinStreamWaitDebug", 5);
    vo_nag_mark_crates(var1, var1, var14);
    scripts\mp\gametypes\br_spectate::ref_143fa(var1);
    var26 = var1 scripts\mp\gametypes\br_spectate::ref_12580();

    while(!var1 buttonPressed("BUTTON_RSHLDR")) {
      waitframe();
    }

    var83 = undefined;

    foreach(var9 in var13) {
      if(var9 != var1 && var9 != var26) {
        var83 = var9;
        break;
      }
    }

    wait 0.5;
    vo_nag_mark_crates(var1, var83, var14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "squadwidget")) {
    setDvar("scr_br_fc_jailTimeout", 9999);
    setDvar("scr_br_spectateMinStreamWaitDebug", 3);

    foreach(var9 in var13) {
      if(var9 != var1) {
        kick(var9 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
      }
    }

    wait 5;
    var94 = var14[0];
    var95 = var14[1];
    var94.br_infilstarted = 1;
    vo_nag_mark_crates(var1, var94, undefined, var1);
    wait getdvarfloat("test_squadwidget", 4);
    vo_nag_mark_crates(var1, var1, undefined, var95);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "killall")) {
    level.overrideingraceperiod = 1;
    var96 = var13[1];

    foreach(var9 in var13) {
      if(var9 != var96) {
        vo_nag_mark_crates(var1, var9, var14);
      }
    }

    foreach(var9 in var14) {
      vo_nag_mark_crates(var1, var9, var15);
    }

    foreach(var9 in var15) {
      vo_nag_mark_crates(var1, var9, var14);
    }

    wait 10;
    kick(var96 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    level.overrideingraceperiod = undefined;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "moneykill")) {
    foreach(var9 in var13) {
      if(var9 != var1) {
        var9 scripts\mp\gametypes\br_plunder::playersetplundercount(45);
        var9.br_infilstarted = 1;
        vo_nag_mark_crates(var1, var9, var14);
      }
    }

    wait 5;
    vo_nag_mark_crates(var1, var1, var14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "buyback1")) {
    ref_12f81(var1.origin, 500);
    setDvar("scr_br_fc_jailTimeout", -1);
    var105 = var1;
    var105.br_infilstarted = 1;
    killplayer(var1, var105, var15);
    var106 = var15[0];
    var106.br_infilstarted = 1;
    killplayer(var1, var106, var15);

    while(!istrue(var105.gulagarena)) {
      waitframe();
    }

    wait 5;
    vo_nag_mark_crates(var1, var105, []);

    while(!isDefined(var105 getspectatingplayer())) {
      waitframe();
    }

    var107 = var105 getspectatingplayer();
    var107.br_infilstarted = 1;
    var61 = undefined;

    foreach(var9 in var13) {
      if(var9 != var105 && var9 != var107) {
        var61 = var9;
        break;
      }
    }

    var61 scripts\mp\gametypes\br_plunder::playersetplundercount(45);
    killplayer(var1, var107, var15);

    while(!istrue(var107.jailed)) {
      waitframe();
    }

    while(!isDefined(var105 getspectatingplayer()) || var105 getspectatingplayer() != var107) {
      waitframe();
    }

    var110 = var15[1];
    var110.br_infilstarted = 1;
    killplayer(var1, var110, var15);

    while(!istrue(var107.gulagarena)) {
      waitframe();
    }

    wait 5;
    setDvar("scr_br_spectateMinStreamWaitDebug", 3);
    vo_nag_mark_crates(var1, var107, []);
    var61 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
    var105 thread scripts\mp\gametypes\br_gulag::playergulagautowin("dev", var61, 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "teamwipe2")) {
    vo_nag_mark_crates(var1, var1, var14);
    var1 waittill("killcam_ended");
    wait 2;
    var111 = 0;

    foreach(var9 in var13) {
      if(var9 != var1) {
        if(var111 > 0) {
          var9 scripts\mp\gametypes\br_plunder::playersetplundercount(45);
          var9.br_infilstarted = 1;
        }

        vo_nag_mark_crates(var1, var9, var15);
        var111++;
        wait 5;
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "hvt1")) {
    ref_12f81(var1.origin, 700);
    var1.br_infilstarted = 1;
    var26 = var13[1];
    var114 = spawnStruct();
    var114.vip = var26;
    var114.team = var26.team;
    var114.isvalidkillcam = "instance";
    var114.removed = 1;
    setDvar("scr_br_hold_in_gulag", 2);
    killplayer(var1, var1, var14);

    while(!istrue(var1.set_relic_nuketimer)) {
      waitframe();
    }

    var114 scripts\mp\gametypes\br_vip_quest::ref_142b7();
    wait 5;
    setDvar("scr_br_hold_in_gulag", 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "infilDeath")) {
    thread ref_14366(getdvarint("test_suicide", 1), var13[1]);
    ref_12078();
    level waittill("br_c130_left_bounds");
    wait 2;
    var13[2].br_infilstarted = 0;
    vo_nag_mark_crates(var1, var13[2], var14);
    wait 5;
    var1.br_infilstarted = 0;
    vo_nag_mark_crates(var1, var1, var14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "reconGulag1")) {
    setDvar("br_minplayers", 9);
    wait 5;
    var94 = var14[0];
    var95 = var15[0];
    kick(var14[2] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var14[1] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var15[2] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var15[1] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var13[2] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var13[1] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    wait 1;
    ref_126b5(var1);
    var94.br_infilstarted = 1;
    vo_nag_mark_crates(var1, var94, undefined, var95);
    wait 7;
    var1.br_infilstarted = 1;

    if(!var1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var1 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    }

    vo_nag_mark_crates(var1, var1, undefined, var95, 1);

    while(!istrue(var1.gulagarena)) {
      waitframe();
    }

    wait 5;
    vo_nag_mark_crates(var1, var94, undefined, var1);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "reconGulag2")) {
    var94 = var14[0];
    var95 = var14[1];
    var115 = var13[1];
    var83 = var13[2];

    if(var115 == var1) {
      var115 = var13[0];
    } else if(var83 == var1) {
      var83 = var13[0];
    }

    kick(var14[2] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var15[2] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var15[1] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    kick(var15[0] getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    vo_nag_mark_crates(var1, var83, undefined, var94);
    wait 1;
    ref_126b5(var115);
    wait 2;
    vo_nag_mark_crates(var1, var1, undefined, var94);
    var1 waittill("killcam_ended");
    wait 3;
    var95.br_infilstarted = 1;
    vo_nag_mark_crates(var1, var95, undefined, var115);
    var115.br_infilstarted = 1;

    if(!var115 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var115 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    }

    vo_nag_mark_crates(var1, var115, undefined, var94, 1);

    while(!istrue(var115.gulagarena)) {
      waitframe();
    }

    wait 5;
    vo_nag_mark_crates(var1, var115, undefined, var95);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "endGameTwoDie")) {
    setDvar("br_minplayers", 8);
    wait 5;
    scripts\mp\gametypes\br_gulag::shutdowngulag("circle_index", 0);
    var94 = var14[0];
    var115 = var13[1];
    var83 = var13[2];

    if(var115 == var1) {
      var115 = var13[0];
    } else if(var83 == var1) {
      var83 = var13[0];
    }

    vo_nag_mark_crates(var1, var14[2], undefined, var1);
    vo_nag_mark_crates(var1, var14[1], undefined, var1);
    vo_nag_mark_crates(var1, var15[2], undefined, var1);
    vo_nag_mark_crates(var1, var15[1], undefined, var1);
    vo_nag_mark_crates(var1, var15[0], undefined, var1);
    vo_nag_mark_crates(var1, var115, undefined, var94);
    vo_nag_mark_crates(var1, var83, undefined, var94);
    wait 3;
    var1 scripts\mp\juggernaut::jugg_makejuggernaut(level.juggksglobals.config);
    wait 3;
    var94 dodamage(999, var94.origin, var94, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");

    while(isalive(var1)) {
      var1 dodamage(999, var1.origin, var1, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      waitframe();
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "infiniteLoot")) {
    setomnvar("scriptable_loot_hide", 0);
    var116 = var1.origin;
    var117 = var1.angles;
    var118 = 0;
    var119 = 0;

    for(var120 = 0;; var120 = 0) {
      var121 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var116 + (var118, var119, 0), var117);
      scripts\mp\gametypes\br_pickups::spawnpickup("brloot_self_revive", var121);
      var120++;
      var118 += 10;

      if(var118 > 5000) {
        var118 = 0;
        var119 += 10;

        if(var119 > 100) {
          var119 = 0;
        }
      }

      if(var120 > 8) {
        waitframe();
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "dieToZombie")) {
    var94 = var14[0];
    var115 = var13[1];
    var83 = var13[2];

    if(var115 == var1) {
      var115 = var13[0];
    } else if(var83 == var1) {
      var83 = var13[0];
    }

    kick(var83 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    var1 scripts\mp\gametypes\br_alt_mode_zxp::ref_12723(0);
    wait 2;
    vo_nag_mark_crates(var1, var1, undefined, var94);
    var1 waittill("killcam_ended");
    wait 2;
    var115.br_infilstarted = 1;
    vo_nag_mark_crates(var1, var115, undefined, var94);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "zombieSpectatePing")) {
    var94 = var14[0];
    var115 = var13[1];
    var83 = var13[2];

    if(var115 == var1) {
      var115 = var13[0];
    } else if(var83 == var1) {
      var83 = var13[0];
    }

    kick(var83 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    var1 scripts\mp\gametypes\br_alt_mode_zxp::ref_12723(0);
    var115 scripts\mp\gametypes\br_alt_mode_zxp::ref_12723(0);
    wait 2;
    vo_nag_mark_crates(var1, var1, undefined, var94);
    var1 waittill("killcam_ended");
    wait 2;
    var122 = scripts\mp\gametypes\br_gametype_zxp::spawndogtags();
    scripts\mp\gametypes\br_gametype_zxp::ref_13238(var122, (0, 0, 200));

    for(var123 = var1 getnodeoffset_code(7); var123 == -1; var123 = var1 getnodeoffset_code(7)) {
      waitframe();
    }

    wait 2;
    var115 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
    var1 scripts\mp\gametypes\br_alt_mode_zxp::wait_for_chopper_boss_finish_turning(var115);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "endGameZombieSpectate")) {
    setDvar("br_minplayers", 8);
    wait 5;
    var94 = var14[0];
    var115 = var13[1];
    var83 = var13[2];

    if(var115 == var1) {
      var115 = var13[0];
    } else if(var83 == var1) {
      var83 = var13[0];
    }

    kick(var83 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    var115 scripts\mp\gametypes\br_alt_mode_zxp::ref_12723(0);
    wait 2;
    vo_nag_mark_crates(var1, var1, undefined, var94);
    var1 waittill("killcam_ended");
    wait 2;
    vo_nag_mark_crates(var1, var14[2], undefined, var1);
    vo_nag_mark_crates(var1, var14[1], undefined, var1);
    vo_nag_mark_crates(var1, var14[0], undefined, var1);
    vo_nag_mark_crates(var1, var15[2], undefined, var1);
    vo_nag_mark_crates(var1, var15[1], undefined, var1);
    vo_nag_mark_crates(var1, var15[0], undefined, var1);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "buyback2")) {
    setDvar("scr_br_fc_jailTimeout", -1);
    var94 = var14[0];
    var115 = var13[1];
    var83 = var13[2];

    if(var115 == var1) {
      var115 = var13[0];
    } else if(var83 == var1) {
      var83 = var13[0];
    }

    kick(var83 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    vo_nag_mark_crates(var1, var115, undefined, var94);
    var1 scripts\engine\utility::waittill_notify_or_timeout("killcam_ended", 8);
    wait 2;
    var1 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
    var115 thread scripts\mp\gametypes\br_gulag::playergulagautowin("dev", var1, 0);
    vo_nag_mark_crates(var1, var1, undefined, var94);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "throwback")) {
    var1 setOrigin((1710, -1703, 58));
    var1 setplayerangles((19, 268, 0));
    waitframe();
    waitframe();

    while(!var1 isthrowingbackgrenade()) {
      waitframe();
    }

    wait 0.5;
    var1 scripts\mp\gametypes\br_pickups::ref_1298f(9);
    wait 0.5;
    var124 = var1 getcurrentprimaryweapon();

    if(var124.basename != "iw8_fists_mp") {
      var1 scripts\mp\gametypes\br_pickups::ref_1298f(9);
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "respawnPayload")) {
    while(!var1 isspectatingplayer()) {
      waitframe();
    }

    var26 = var1 getspectatingplayer();
    wait 1;
    vo_nag_mark_crates(var1, var26, var14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "gulag12")) {
    var94 = var14[0];
    var94.br_infilstarted = 1;
    killplayer(var1, var94, var15);
    var115 = var13[1];

    if(var115 == var1) {
      var115 = var13[0];
    }

    var115.br_infilstarted = 1;
    killplayer(var1, var115, var15);

    while(!istrue(var94.gulagarena) || !istrue(var115.gulagarena)) {
      waitframe();
    }

    wait 5;
    killplayer(var1, var115, undefined, var94);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "helimg")) {
    var26 = undefined;

    foreach(var9 in var13) {
      if(var9 != var1) {
        if(!isDefined(var26)) {
          var26 = var9;
          break;
        }
      }
    }

    wait 1;
    var81 = undefined;
    var82 = undefined;

    if(isDefined(level.vehicle.instances["little_bird_mg"])) {
      var80 = getarraykeys(level.vehicle.instances["little_bird_mg"]);

      if(var80.size > 0) {
        var81 = level.vehicle.instances["little_bird_mg"][var80[0]];
      }
    }

    if(!isDefined(var81)) {
      var127 = spawnStruct();
      var127.origin = (1000, -2000, 100);
      var127.angles = (0, 0, 0);
      var127.owner = var1;
      var127.spawntype = "DEVGUI";
      var81 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var127);
    }

    var82 = var81 getlinkedscriptableinstance();
    var26 setOrigin(var81.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var82, "single", "vehicle_use", var26, 0);
    wait 5;
    var128 = "br_gunner";
    var129 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var81, var26);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var81, var128, var26);
    var26 dodamage(500, var14[0].origin, var14[0], undefined, "MOD_EXPLOSIVE", var14[0] getcurrentprimaryweapon());
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "helimg2")) {
    wait 1;
    var81 = undefined;
    var82 = undefined;

    if(isDefined(level.vehicle.instances["little_bird_mg"])) {
      var80 = getarraykeys(level.vehicle.instances["little_bird_mg"]);

      if(var80.size > 0) {
        var81 = level.vehicle.instances["little_bird_mg"][var80[0]];
      }
    }

    if(!isDefined(var81)) {
      var127 = spawnStruct();
      var127.origin = (1000, -2000, 100);
      var127.angles = (0, 0, 0);
      var127.owner = var1;
      var127.spawntype = "DEVGUI";
      var81 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var127);
    }

    var82 = var81 getlinkedscriptableinstance();
    var1 setOrigin(var81.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var82, "single", "vehicle_use", var1, 0);
    wait 5;
    var128 = "br_gunner";
    var129 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var81, var1);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var81, var128, var1);

    if(!var1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var1 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    }

    var1 dodamage(500, var14[0].origin, var14[0], undefined, "MOD_EXPLOSIVE", var14[0] getcurrentprimaryweapon());
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "truckmg")) {
    var26 = undefined;

    foreach(var9 in var13) {
      if(var9 != var1) {
        if(!isDefined(var26)) {
          var26 = var9;
          break;
        }
      }
    }

    wait 1;
    var132 = undefined;
    var82 = undefined;

    if(isDefined(level.vehicle.instances["cargo_truck_mg"])) {
      var80 = getarraykeys(level.vehicle.instances["cargo_truck_mg"]);

      if(var80.size > 0) {
        var132 = level.vehicle.instances["cargo_truck_mg"][var80[0]];
      }
    }

    if(!isDefined(var132)) {
      var127 = spawnStruct();
      var127.origin = (400, -2100, 100);
      var127.angles = (0, 0, 0);
      var127.owner = var1;
      var127.spawntype = "DEVGUI";
      var132 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var127);
    }

    var133 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cargo_truck_mg");

    foreach(var129, var135 in var133.ref_11fa5) {
      var133.ref_11fa5[var129] = 1;
    }

    foreach(var129, var135 in var133.ref_11fa4) {
      var133.ref_11fa4[var129] = 500;
    }

    var82 = var132 getlinkedscriptableinstance();
    var26 setOrigin(var132.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var82, "single", "vehicle_use", var26, 0);
    wait 5;
    var137 = "gunner";
    var129 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var132, var26);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var132, var137, var26);

    if(!var26 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var26 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    }

    var26 dodamage(500, var14[0].origin, var14[0], undefined, "MOD_RIFLE_BULLET", var14[0] getcurrentprimaryweapon());
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "truckmg2")) {
    wait 1;
    var132 = undefined;
    var82 = undefined;

    if(isDefined(level.vehicle.instances["cargo_truck_mg"])) {
      var80 = getarraykeys(level.vehicle.instances["cargo_truck_mg"]);

      if(var80.size > 0) {
        var132 = level.vehicle.instances["cargo_truck_mg"][var80[0]];
      }
    }

    if(!isDefined(var132)) {
      var127 = spawnStruct();
      var127.origin = (400, -2100, 100);
      var127.angles = (0, 0, 0);
      var127.owner = var1;
      var127.spawntype = "DEVGUI";
      var132 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var127);
    }

    var133 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cargo_truck_mg");

    foreach(var129, var135 in var133.ref_11fa5) {
      var133.ref_11fa5[var129] = 1;
    }

    foreach(var135 in var133.ref_11fa4) {
      var133.ref_11fa4[var129] = 500;
    }

    var82 = var132 getlinkedscriptableinstance();
    var1 setOrigin(var132.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var82, "single", "vehicle_use", var1, 0);
    wait 5;
    var137 = "gunner";
    var129 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var132, var1);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var132, var137, var1);

    if(!var1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var1 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    }

    for(var140 = getdvarint("scr_test_frames", 1); var140 > 0; var140--) {
      waitframe();
    }

    var1 dodamage(500, var14[0].origin, var14[0], undefined, "MOD_RIFLE_BULLET", var14[0] getcurrentprimaryweapon());
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "exfil_spectate")) {
    setDvar("br_minplayers", 8);
    wait 5;
    var26 = var13[1];

    if(var26 == var1) {
      var26 = var13[0];
    }

    foreach(var9 in var13) {
      if(var9 == var1 || var9 == var26) {
        continue;
      }

      vo_nag_mark_crates(var1, var9, var14);
    }

    foreach(var9 in var15) {
      vo_nag_mark_crates(var1, var9, var14);
    }

    wait 2;
    vo_nag_mark_crates(var1, var1, var14);
    var1 waittill("killcam_ended");
    wait 2;
    vo_nag_mark_crates(var1, var26, var14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "simulKill")) {
    setDvar("br_minplayers", 8);
    wait 5;
    var26 = var13[1];

    if(var26 == var1) {
      var26 = var13[0];
    }

    var94 = var14[0];
    var95 = var15[0];

    foreach(var33 in var14) {
      if(var33 == var94) {
        continue;
      }

      vo_nag_mark_crates(var1, var33, undefined, var1);
    }

    foreach(var33 in var15) {
      if(var33 == var95) {
        continue;
      }

      vo_nag_mark_crates(var1, var33, undefined, var1);
    }

    foreach(var62 in var13) {
      if(var62 == var26 || var62 == var1) {
        continue;
      }

      kick(var62 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    }

    wait 5;
    thread vo_nag_mark_crates(level, var1, var94, undefined);
    thread vo_nag_mark_crates(level, var1, var95, undefined);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "fd_shoot_1")) {
    var1 setOrigin((12799, 16985, 10014));
    var1 setplayerangles((351, 35, 0));
    var151 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_give_weapon();
    var152 = spawnturret("misc_turret", (23271, 24389, 13789), var151, 0);
    var74 = vectorNormalize(var1 getEye() - var152.origin);
    var153 = vectortoangles(var74);
    var152.angles = var153;
    var152 setModel("veh_s4_mil_air_dalpha_wz_turret_attach");
    var152 setmode("manual_target");
    var152 setsentryowner(undefined);
    var152 makeunusable();
    var152 setdefaultdroppitch(0);
    var152 setturretmodechangewait(1);
    var154 = 0;

    for(;;) {
      if(getdvarint("test_force", 0)) {
        setDvar("test_force", 0);
        var154 = !var154;
        var152 unmarkkeyframedmover(var154);
      }

      var152 shootturret("tag_barrel");
      waitframe();
    }

    return;
  }
}

function ref_126b5() {
  var0 = spawnStruct();
  var0.scriptablename = "brloot_killstreak_recondrone";
  var0.count = 1;
  scripts\mp\gametypes\br_pickups::takesuperpickup(var0);
  wait 1;
  var1 = getcompleteweaponname("super_default_mp");
  scripts\mp\supers::trysuperusebegin(var1);

  while(self getcurrentprimaryweapon().basename != "ks_remote_drone_mp") {
    waitframe();
  }
}

function ref_14366(var0, var1) {
  wait var0;
  var1 suicide();
}

function ref_12078() {
  level notify("onPrematchFadeDoneClear");
  thread ref_12077();
  var0 = undefined;

  if(!istrue(level.br_infils_disabled) && !scripts\mp\gametypes\br_public::isusinginfilselection()) {
    var0 = scripts\mp\gametypes\br_c130::createtestc130path();
  }

  waitframe();
  var1 = 0;
  level.debugnextpropindex = 0;
  level.delay_music_reinforcements = 0;
  scripts\mp\gametypes\br_infils::clear_tier_lights(var0, "player");
  level thread scripts\mp\gametypes\br_c130::waittoplayinfildialog();
  level notify("infils_ready");
}

function ref_12077() {
  var0 = 1.4;
  level endon("onPrematchFadeDoneClear");

  if(!isDefined(level.ref_136de)) {
    level.ref_136de = 1;
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level thread scripts\mp\gametypes\br::resetalldoors(var0 * 1.5);
  level thread scripts\cp\vehicles\little_bird_mg_cp::fulton_destroy(1);
  level thread scripts\mp\gametypes\br_vehicles::brvehicleonprematchstarted();
  level thread scripts\mp\gametypes\br_functional_poi::onprematchdone();
  scripts\mp\gametypes\br::has_focus_fire_objective();
  scripts\mp\gametypes\br_vehicles::emptyallvehicles();

  foreach(var2 in level.players) {
    var2 scripts\mp\gametypes\br_infils::setplayerprematchallows();
    var2 thread scripts\mp\gametypes\br_pickups::resetplayerinventory();

    if(istrue(var2.hasspawned)) {
      if(istrue(var2.usingascender)) {
        var2 scripts\cp_mp\auto_ascender::canseesafecircleui();
      }

      var2 thread scripts\mp\weapons::deleteplacedequipment(1);
    }
  }

  foreach(var2 in level.players) {
    if(isDefined(var2.burninginfo)) {
      var2 scripts\mp\equipment\molotov::molotov_clear_burning();
    }

    var2 scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
  }

  level notify("prematch_cleanup");

  if(!istrue(level.br_circle_disabled)) {
    level thread scripts\mp\gametypes\br_circle::ref_12e09(1);
    return;
  }
}

function ref_12f81(var0, var1) {
  if(!isDefined(level.br_circle.safecircleent)) {
    thread scripts\mp\gametypes\br_circle::ref_12e09(1);
    level.br_circle thread scripts\mp\gametypes\br_circle::circledamagetick();
  }

  waitframe();
  level notify("CirclePeekCleanup");
  var2 = 1;
  level.br_circle.starttime = gettime();
  level.br_circle.circleindex = var2;
  var3 = var2 == 0;
  var4 = var2 == level.br_level.br_circleclosetimes.size - 1;
  var5 = level.br_level.br_circledelaytimes[var2];
  var6 = level.br_level.br_circleclosetimes[var2];
  var7 = level.br_level.br_circleradii[var2 + 1];
  setomnvar("ui_br_circle_num", var2 + 1);
  level.br_circle.centertarget = var0;
  level.br_circle.safecircleent.origin = var0;
  level.br_circle.dangercircleui.hidden = 0;
  level.br_circle.dangercircleent.hidden = 0;
  level.br_circle.safecircleui.hidden = 0;
  level.br_circle.safecircleent.hidden = 0;
  level notify("update_circle_hide");
  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = var0 + (0, 0, var1);
  scripts\mp\gametypes\br_circle::setstaticuicircles(999, level.br_circle.safecircleui, level.br_circle.dangercircleui, var4);
  level notify("br_circle_set");
  waitframe();
  level notify("br_circle_started");
  level.br_circle.dangercircleent brcirclemoveTo(var0[0], var0[1], var1, 1);
}

function ref_126c5(var0, var1) {
  if(self calloutmarkerping_getEnt()) {
    self allowmovement(0);
    self allowfire(0);
    self allowmelee(0);
  }

  var2 = self getentitynumber();

  if(isDefined(level.level_logic[var2])) {
    var0 = level.level_logic[var2];
  } else {
    var3 = anglesToForward((0, 0, 0));
    var0 += var3 * var1 * 50;
    var0 = getgroundposition(var0, 15, 100);
  }

  self setOrigin(var0);
  self setplayerangles((0, 0, 0));

  if(!isDefined(level.level_logic[var2])) {
    level.level_logic[var2] = var0;
    return;
  }
}

function killplayer(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = reset_button_handler(var0, var1.origin, var2);
  }

  var1 dodamage(500, var3.origin, var3, undefined, "MOD_EXPLOSIVE", var3 getcurrentprimaryweapon());
  wait 1;

  while(isalive(var1)) {
    var1 dodamage(500, var3.origin, var3, undefined, "MOD_EXPLOSIVE", var3 getcurrentprimaryweapon());
    waitframe();
  }

  return var3;
}

function vo_nag_mark_crates(var0, var1, var2, var3, var4) {
  if(!isDefined(var3)) {
    var3 = reset_button_handler(var0, var1.origin, var2);
  }

  if(!isDefined(var3)) {
    var3 = var1;
  }

  if(!istrue(var4) && var1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    var1 scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
  }

  while(isalive(var1)) {
    var1 dodamage(500, var3.origin, var3, undefined, "MOD_EXPLOSIVE", var3 getcurrentprimaryweapon());

    if(!isalive(var1)) {
      break;
    }

    waitframe();
  }

  return var3;
}

function ref_1294d(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = reset_button_handler(var0, var1.origin, var2);
  }

  if(!isDefined(var3)) {
    var3 = var1;
  }

  if(!var1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    var1 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
  }

  while(!istrue(var1.inlaststand)) {
    var1 dodamage(30, var3.origin, var3, undefined, "MOD_EXPLOSIVE", var3 getcurrentprimaryweapon());
    wait 0.1;
  }

  return var3;
}

function reset_button_handler(var0, var1, var2) {
  var2 = sortbydistance(var2, var1);

  if(isalive(var2[0])) {
    var3 = distance2dsquared(var1, var2[0].origin);

    if(var3 < 40000) {
      return var2[0];
    }
  }

  var4 = undefined;

  for(var5 = 1; var5 < var2.size; var5++) {
    var6 = var2[var5];

    if(isalive(var6)) {
      var4 = var6;
      break;
    }
  }

  return var4;
}

function remove_map_hint(var0) {
  if(isDefined(level.level_offhand_spawn)) {
    return level.level_offhand_spawn;
  }

  var1 = scripts\mp\gamelogic::gethostplayer();

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, "clientHost")) {
    foreach(var3 in level.players) {
      if(!isai(var3) && !var3 calloutmarkerping_getEnt() && (!isDefined(var1) || var3 != var1)) {
        var1 = var3;
        break;
      }
    }
  } else if(!isDefined(var1)) {
    foreach(var3 in level.players) {
      if(!isai(var3) && !var3 calloutmarkerping_getEnt()) {
        level.level_offhand_spawn = var3;
        var1 = var3;
        break;
      }
    }
  } else {
    level.maxteamsize = 3;
  }

  if(!isDefined(level.level_offhand_spawn)) {
    level.level_offhand_spawn = var1;
  }

  return var1;
}

function calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var0, var1) {
  foreach(var3 in var0) {
    if(var3 == var1) {
      return true;
    }
  }

  return false;
}

function ref_12d1c(var0, var1) {
  var2 = level.teamdata[var1]["players"];
  var3 = 0;

  foreach(var5 in var2) {
    if(!isalive(var5) || var5.sessionstate != "playing") {
      var6 = var5 getentitynumber();

      if(isDefined(level.level_logic[var6])) {
        var5.forcespawnangles = (0, 0, 0);
        var5.forcespawnorigin = level.level_logic[var6];
      } else {
        var5.forcespawnangles = var5.angles;
        var5.forcespawnorigin = var5.origin;
      }

      ref_13623(var5, 0);
      var3 = 1;
    }

    if(istrue(var5.delay_enter_combat_after_investigating_grenade)) {
      scripts\mp\gametypes\br::ref_13f21(var5, "reviveTeam");
    }
  }

  if(var3) {
    var0 iprintlnbold("Reviving Team: " + var1);
    wait 1;
    return;
  }
}

function run_current_spawn_group(var0, var1) {
  var2 = 0;

  if(level.teamdata[var1]["teamCount"] < level.maxteamsize) {
    var2 = level.maxteamsize - level.teamdata[var1]["teamCount"];
  }

  if(var2 > 0) {
    level.ref_11c84 = &ref_13623;
    var3 = level.players.size;
    addbots(var2, var1);
    var0 iprintlnbold("Spawning Team: " + var1);
    var4 = gettime() + 10000;

    while(gettime() < var4 && level.teamdata[var1]["aliveCount"] < level.maxteamsize) {
      waitframe();
    }

    level.ref_11c84 = &scripts\mp\gametypes\br::spawnclientbr;
  }

  return level.teamdata[var1]["alivePlayers"];
}

function addbots(var0, var1) {
  setDvar("MSLNRKRRKK", "1");

  if(!isDefined(var1)) {
    var1 = "autoassign";
  }

  level thread[[level.bot_funcs["bots_spawn"]]](var0, var1);

  if(level.matchmakingmatch) {
    setmatchdata("hasBots", 1);
    return;
  }
}

function ref_13623(var0) {
  self.class = scripts\mp\gametypes\br::ref_1234a();
  self.pers["class"] = self.class;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self freezecontrols(1);
  waitframe();
  self skydive_setdeploymentstatus(0);
  self skydive_setbasejumpingstatus(0);
  var1 = !self calloutmarkerping_getEnt();

  if(var1) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;
  self freezecontrols(0);
}

function showsplash(var0) {
  foreach(var2 in level.players) {
    var2 scripts\mp\hud_message::showsplash(var0);
  }
}