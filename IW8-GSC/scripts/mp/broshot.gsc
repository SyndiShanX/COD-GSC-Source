/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\broshot.gsc
***********************************************/

function initbroshotfx() {}

function forceinitbroshot() {
  level.forcebroshot = 1;
  setomnvar("ui_broshot_debug", 1);
  return initbroshot();
}

function initbroshot(var_0) {
  if(true) {
    return false;
  }

  level.camera_bro_shot = spawnStruct();
  level.camera_bro_shot.basecam = getEnt("camera_mp_broshot", "targetname");
  level.camera_bro_shot.char_loc[0] = getEnt("character_loc_broshot", "targetname");
  level.camera_bro_shot.char_loc[2] = getEnt("character_loc_broshot_a", "targetname");
  level.camera_bro_shot.char_loc[1] = getEnt("character_loc_broshot_b", "targetname");
  level.camera_bro_shot.char_loc[3] = getEnt("character_loc_broshot_c", "targetname");
  level.camera_bro_shot.char_loc[4] = getEnt("character_loc_broshot_d", "targetname");
  level.camera_bro_shot.char_loc[5] = getEnt("character_loc_broshot_e", "targetname");

  if((!isDefined(self) || !isDefined(level.camera_bro_shot.basecam) || !scripts\mp\utility\teams::getteamdata("allies", "teamCount") == 0 || !scripts\mp\utility\teams::getteamdata("axis", "teamCount")) && !istrue(level.forcebroshot)) {
    return false;
  }

  if(level.teambased && !istrue(level.forcebroshot)) {
    if(!isDefined(var_0)) {
      var_1 = getteamscore("allies");
      var_2 = getteamscore("axis");

      if(var_1 == var_2) {
        return false;
      }
    } else if(var_0 == "tie" || var_0 == "none" || var_0 == "draw") {
      return false;
    }
  }

  level.camera_bro_shot.myfov = 40;
  level.camera_bro_shot.char_loc[1].origin = level.camera_bro_shot.char_loc[0].origin + anglestoleft(level.camera_bro_shot.char_loc[1].angles) * -40 + anglesToForward(level.camera_bro_shot.char_loc[1].angles) * -100;
  level.camera_bro_shot.char_loc[2].origin = level.camera_bro_shot.char_loc[0].origin + anglestoleft(level.camera_bro_shot.char_loc[2].angles) * 60 + anglesToForward(level.camera_bro_shot.char_loc[2].angles) * -130;
  setomnvar("ui_broshot_upside_down", istrue(level.upsidedowntaunts));
  sortwinnersandlosers(var_0);
  level.numwinningplayers = int(min(3, level.topplayers.size));
  level.numlosingplayers = int(min(3, level.toplosingplayers.size));
  filterpairs();

  for(var_3 = 0; var_3 < level.numwinningplayers; var_3++) {
    var_4 = level.camera_bro_shot.char_loc[var_3].origin - (0, 0, 50);
    var_5 = (var_4[0], var_4[1], var_4[2] + 100);
    var_6 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 0);
    var_7 = physics_raycast(var_5, var_4, var_6, undefined, 1, "physicsquery_closest");
    var_8 = isDefined(var_7) && var_7.size > 0;

    if(var_8) {
      var_9 = var_7[0]["position"];
      level.camera_bro_shot.char_loc[var_3].origin = var_9;
    }

    level.camera_bro_shot.char_loc[var_3].angles = level.camera_bro_shot.char_loc[var_3].angles;
  }

  for(var_3 = level.numwinningplayers; var_3 < level.numwinningplayers + level.numlosingplayers; var_3++) {
    var_10 = var_3 - level.numwinningplayers;
    level.camera_bro_shot.char_loc[var_3].origin = level.camera_bro_shot.char_loc[var_10].origin;
    level.camera_bro_shot.char_loc[var_3].angles = level.camera_bro_shot.char_loc[var_10].angles;
  }

  self.mvparray = [];
  return true;
}

function filterpairs() {
  var_0 = min(level.numwinningplayers, level.numlosingplayers);

  if(var_0 < level.numwinningplayers) {
    level.topplayers = scripts\engine\utility::array_remove_index(level.topplayers, level.topplayers.size - 1, 0);
    level.numwinningplayers = level.topplayers.size;
  }

  if(var_0 < level.numlosingplayers) {
    level.toplosingplayers = scripts\engine\utility::array_remove_index(level.toplosingplayers, level.toplosingplayers.size - 1, 0);
    level.numlosingplayers = level.toplosingplayers.size;
    return;
  }
}

function timeoutcapturekills(var_0) {
  level endon("queuedTauntsRun");
  wait var_0;
  thread runqueuedtaunts();
}

function queuecapturekillchoice(var_0, var_1) {
  if(!isDefined(level.broshottauntqueue)) {
    level.broshottauntqueue = [];
  }

  if(!isDefined(level.broshottauntqueue[var_0])) {
    level.broshottauntqueue[var_0] = var_1;

    if(0 || isDefined(level.debugbroshot)) {
      if(var_0 == 0) {
        if(level.numwinningplayers > 1) {
          level.broshottauntqueue[var_0 + 1] = var_1;
        }

        if(level.numwinningplayers > 2) {
          level.broshottauntqueue[var_0 + 2] = var_1;
        }
      }
    }
  }

  var_2 = 0;

  foreach(var_4 in level.topplayers) {
    if(!isbot(var_4)) {
      var_2++;
    }
  }

  if(level.broshottauntqueue.size >= var_2) {
    if(isDefined(level.broshotintrodone)) {
      thread runqueuedtaunts();
      return;
    }

    thread waittorunqueuedtaunts();
    return;
  }
}

function processcameradata(var_0) {
  level.camdata = [];

  if(!isDefined(level.broshottauntqueue[0])) {
    level.broshottauntqueue[0] = 1;
  }

  if(!isDefined(level.broshottauntqueue[1]) && level.numwinningplayers > 1) {
    level.broshottauntqueue[1] = randomint(2) + 1;
  }

  if(!isDefined(level.broshottauntqueue[2]) && level.numwinningplayers > 2) {
    level.broshottauntqueue[2] = randomint(2) + 1;
  }

  if(isDefined(level.broshottauntqueue[2])) {
    var_1 = level.broshottauntqueue[2];
    var_2 = getcamdata(var_1, 2);
    level.camdata[2] = var_2;
  }

  if(isDefined(level.broshottauntqueue[1])) {
    var_1 = level.broshottauntqueue[1];
    var_2 = getcamdata(var_1, 1);
    level.camdata[1] = var_2;
  }

  if(isDefined(level.broshottauntqueue[0])) {
    var_1 = level.broshottauntqueue[0];
    var_2 = getcamdata(var_1, 0);
    level.camdata[0] = var_2;
    return;
  }
}

function getcamdata(var_0, var_1) {
  if(var_0 == 1) {
    if(level.broshotwinnersgoodguys) {
      var_2 = killsequencemarinesdata(var_1);
    } else {
      var_2 = killsequenceopfordata(var_2);
    }
  } else if(level.broshotwinnersgoodguys) {
    var_2 = capturesequencemarinesdata(var_2);
  } else {
    var_2 = capturesequenceopfordata(var_2);
  }

  return var_2;
}

function waitforintrodone() {
  level endon("queuedTauntsRun");
  level waittill("bro_intro_done");
  level.broshotintrodone = 1;
}

function waittorunqueuedtaunts() {
  level endon("queuedTauntsRun");
  level waittill("bro_intro_done");
  thread runqueuedtaunts();
}

function calccameraduration(var_0) {
  if(isDefined(var_0.cutframe)) {
    return (var_0.cutframe / 30);
  }

  var_1 = var_0.keys[var_0.keys.size - 1];
  return var_1.nexttrackframe / 30;
}

function calcprestarttime(var_0) {
  return var_0.precutstartframe / 30;
}

function runqueuedtaunts() {
  level notify("queuedTauntsRun");

  if(!isDefined(level.broshottauntqueue)) {
    level.broshottauntqueue = [];
  }

  var_0 = 11;
  processcameradata(level.broshottauntqueue);
  var_1 = 0;

  if(isDefined(level.broshottauntqueue[2])) {
    var_2 = calccameraduration(level.camdata[2]);
    var_3 = calcprestarttime(level.camdata[1]);
    var_4 = level.broshottauntqueue[2];
    thread docapturekill(2, var_4, var_1);
    var_0 += var_2;
    var_1 += var_2 - var_3;
  }

  if(isDefined(level.broshottauntqueue[1])) {
    var_2 = calccameraduration(level.camdata[1]);
    var_3 = calcprestarttime(level.camdata[0]);
    var_4 = level.broshottauntqueue[1];
    thread docapturekill(1, var_4, var_1);
    var_0 += var_2;
    var_1 += var_2 - var_3;
  }

  var_4 = 0;

  if(isDefined(level.broshottauntqueue[0])) {
    var_4 = level.broshottauntqueue[0];
  }

  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  if(level.broshotwinnersgoodguys) {
    if(var_4 == 1) {
      var_5 = 3.16667;
      var_6 = 0.733333;
      var_7 = 0.2;
      var_8 = 0.25;
      var_9 = 0.15;
    } else {
      var_5 = 2.5;
      var_6 = 1.4;
      var_7 = 0.2;
      var_8 = 0.25;
      var_9 = 0.15;
    }
  } else if(var_4 == 1) {
    var_5 = 5.33333;
    var_6 = 0.5;
    var_7 = 0.2;
    var_8 = 0.25;
    var_9 = 0.15;
  } else {
    var_5 = 6.66667;
    var_6 = 0.6;
    var_7 = 0.2;
    var_8 = 0.25;
    var_9 = 0.15;
  }

  thread docapturekill(0, var_4, var_1, var_5, var_6, var_7, var_8, var_9);
  thread notifywhentauntstimedout(var_0);
  waitframe();
  var_10 = 0;

  if(isDefined(level.broshottauntqueue[2])) {
    var_2 = calccameraduration(level.camdata[2]);
    thread watchcameratracks(2, var_4);
    var_10 = var_2;
  }

  if(isDefined(level.broshottauntqueue[1])) {
    var_2 = calccameraduration(level.camdata[1]);
    wait var_10;
    thread watchcameratracks(1, var_4);
    var_10 = var_2;
  }

  wait var_10;
  thread watchcameratracks(0, var_4);
}

function notifywhentauntstimedout(var_0) {
  wait var_0;
  level notify("taunts_timed_out");

  if(istrue(level.debugbroshot)) {
    resetbroshot(level.players[0]);
    return;
  }
}

function trydof(var_0) {
  if(isDefined(var_0.dofnearstart)) {
    foreach(var_2 in level.players) {
      if(isbot(var_2)) {
        continue;
      }

      var_2.usingcustomdof = 1;
      var_2 setdepthoffield(var_0.dofnearstart, var_0.dofnearend, var_0.doffarstart, var_0.doffarend, var_0.dofnearblur, var_0.doffarblur);
    }

    return;
  }
}

function watchcameratracks(var_0, var_1) {
  self notify("play_cam_track");
  self endon("play_cam_track");
  var_2 = level.camdata[var_0];
  trydof(var_2);
  var_3 = 1;
  var_4 = 1;

  while(isDefined(var_2) && istrue(var_4)) {
    var_4 = cameraactivatetrack(var_2, var_3, var_1);
    var_3 = 0;
  }
}

function sortwinnersandlosers(var_0) {
  if(level.teambased) {
    if(!isDefined(var_0)) {
      var_1 = getteamscore("allies");
      var_2 = getteamscore("axis");
      var_3 = scripts\engine\utility::ter_op(var_1 >= var_2, "allies", "axis");
    } else {
      var_3 = var_3;
    }

    level.topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var_3, "players"), &compare_player_score);
    var_4 = scripts\mp\utility\teams::getenemyplayers(var_3);
    level.toplosingplayers = scripts\engine\utility::array_sort_with_func(var_4, &compare_player_score);
    return;
  }

  level.topplayers = level.placement["all"];
  level.toplosingplayers = level.placement["all"];
}

function startbroshot(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  level.broshotrunning = 1;
  cleanupequipment();
  cleanupgamemodes();
  var_1 = spawnStruct();
  var_1.origin = level.camera_bro_shot.char_loc[0].origin;
  var_1.angles = level.camera_bro_shot.char_loc[0].angles;
  level.camera_bro_shot.basecam.origin = var_1.origin;
  level.camera_bro_shot.basecam.angles = var_1.angles;

  foreach(var_3 in level.players) {
    var_3 scripts\mp\playerlogic::respawn_asspectator(var_1.origin, var_1.angles);
    var_3 scripts\mp\gamelogic::freezeplayerforroundend();
    var_3 playerhide();
  }

  removeallcorpses();
  level.active_camera = var_1;
  level.camera_anchor = spawn("script_model", var_1.origin);
  level.camera_anchor setModel("tag_origin");
  level.camera_anchor.angles = var_1.angles;
  createwinnersandlosersarrays(var_0);
  level.numwinningplayers = int(min(3, level.topplayers.size));
  level.numlosingplayers = int(min(3, level.toplosingplayers.size));
  filterpairs();
  level.supergunout = [];
  level.interruptabletaunts = [];
  level.firsttaunttracker = [];

  foreach(var_3 in level.players) {
    hideeffectsforbroshot(var_3);
  }

  if(!isDefined(level.broshotwinnersgoodguys)) {
    level.broshotwinnersgoodguys = level.topplayers[0].team == "allies";
  }

  for(var_7 = 0; var_7 < 6; var_7++) {
    var_8 = 1;
    var_9 = undefined;

    if(var_7 <= level.numwinningplayers - 1) {
      var_9 = level.topplayers[var_7];
    } else if(var_7 <= level.numwinningplayers + level.numlosingplayers - 1) {
      var_8 = 0;
      var_9 = level.toplosingplayers[var_7 - level.numwinningplayers];
    }

    if(!isDefined(var_9)) {
      break;
    }

    if(!isDefined(var_9.loadoutarchetype)) {
      continue;
    }

    var_10 = undefined;
    var_11 = undefined;

    if(istrue(level.debugbroshot)) {
      if(level.broshotwinnersgoodguys) {
        if(var_8) {
          var_10 = 10;
          var_11 = 6;
        } else {
          var_10 = 1;
          var_11 = 1;
        }
      } else if(var_8) {
        var_10 = 1;
        var_11 = 1;
      } else {
        var_10 = 10;
        var_11 = 6;
      }
    }

    createmvparrayentry(var_7, var_9, var_8, var_10, var_11);
  }

  foreach(var_3 in level.players) {
    var_3 setsoundsubmix("mp_broshot");
    var_3 setsolid(0);
    var_3 dontinterpolate();

    if(isbot(var_3)) {
      continue;
    }

    var_3 cameralinkTo(level.camera_anchor, "tag_origin", 1);
    var_3 thread scripts\mp\utility\game::setuipostgamefade(0);
    scripts\mp\utility\player::_visionsetnaked("", 0);

    if(!istrue(level.forcebroshot)) {
      thread fadetoblack(var_3);
    }
  }

  level.broshotfirstcamblends = calcfirstcamerablendpts();

  if(level.broshotwinnersgoodguys) {
    thread introsequence_marinewinner();
  } else {
    thread introsequence_opforwinner();
  }

  if(!isDefined(level.debugbroshot)) {
    thread timeoutcapturekills(10);
  }

  thread tauntinputlisten(level.topplayers);
  thread onplayerconnect();
  startpodium(-1, self.mvparray);
}

function createwinnersandlosersarrays(var_0) {
  if(istrue(level.forcebroshot)) {
    if(level.broshotwinnersgoodguys) {
      var_1 = "allies";
      var_2 = "axis";
    } else {
      var_1 = "allies";
      var_2 = "axis";
    }

    if(scripts\mp\utility\teams::getteamdata(var_1, "teamCount") > 1) {
      level.topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var_1, "players"), &compare_player_score);
    } else {
      level.topplayers = [];
      level.topplayers[0] = self;
    }

    if(scripts\mp\utility\teams::getteamdata(var_2, "teamCount") > 1) {
      level.toplosingplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var_2, "players"), &compare_player_score);
      return;
    }

    level.topaxisplayers = [];
    level.toplosingplayers[0] = self;
    return;
  }

  sortwinnersandlosers(var_2);
}

function createmvparrayentry(var_0, var_1, var_2, var_3, var_4) {
  self.mvparray[var_0] = spawnStruct();

  if(scripts\mp\utility\game::getgametype() == "infect") {
    if(isbot(var_1)) {
      var_5 = var_1.loadoutarchetype;
    } else {
      var_5 = var_2 scripts\mp\class::cac_getcharacterarchetype();
    }
  } else {
    var_5 = var_3.loadoutarchetype;
  }

  var_6 = tablelookuprownum("mp/battleRigTable.csv", 1, var_5);

  if(isbot(var_3) || isDefined(var_3.lastarchetypeinfo)) {
    var_7 = var_3 getcustomizationbody();
    var_8 = var_3 getcustomizationhead();
    var_9 = tablelookuprownum("mp/cac/heads.csv", 1, var_8);
    var_10 = tablelookuprownum("mp/cac/bodies.csv", 1, var_7);

    if(isDefined(var_3.lastarchetypeinfo)) {
      var_6 = tablelookuprownum("mp/battleRigTable.csv", 1, var_3.lastarchetypeinfo.archetype);
    }
  } else {
    var_7 = var_5 getcustomizationbody();
    var_8 = var_5 getcustomizationhead();
    var_9 = tablelookuprownum("mp/cac/heads.csv", 1, var_8);
    var_10 = tablelookuprownum("mp/cac/bodies.csv", 1, var_7);
  }

  if(isDefined(var_7) && isDefined(var_8)) {
    var_9 = var_7;
    var_10 = var_8;
  } else {
    var_11 = var_5 scripts\mp\teams::getglcustomization();
    var_9 = tablelookuprownum("mp/cac/heads.csv", 1, var_11[1]);
    var_10 = tablelookuprownum("mp/cac/bodies.csv", 1, var_11[0]);
  }

  self.mvparray[var_5].rigindex = var_10;
  self.mvparray[var_5].bodyindex = var_10;
  self.mvparray[var_5].headindex = var_9;

  if(var_6) {
    if(istrue(level.broshotwinnersgoodguys)) {
      switch (var_5) {
        case 0:
        default:
          self.mvparray[var_5].weaponname = "iw8_ar_mike4_mp";
          break;
        case 1:
          self.mvparray[var_5].weaponname = "iw8_ar_mike4_mp";
          break;
        case 2:
          self.mvparray[var_5].weaponname = "iw8_pi_golf21_mp";
          break;
      }
    } else {
      switch (var_5) {
        case 0:
        default:
          self.mvparray[var_5].weaponname = "iw8_fists_mp";
          break;
        case 1:
          self.mvparray[var_5].weaponname = "iw8_fists_mp";
          break;
        case 2:
          self.mvparray[var_5].weaponname = "iw8_ar_mike4_mp";
          break;
      }
    }
  } else {
    self.mvparray[var_5].weaponname = "iw8_fists_mp";
  }

  self.mvparray[var_5].clantag = var_5 getclantag();
  self.mvparray[var_5].name = var_5.name;
  self.mvparray[var_5].xuid = var_5 getxuid();
  self.mvparray[var_5].podiumindex = var_5;
  self.mvparray[var_5].clientnum = var_5 getentitynumber();
  setguntypeforui(var_5, var_5);
  var_5.bro = makebrowinner(var_5, level.camera_bro_shot.char_loc[var_5]);
}

function resetbroshot() {
  level.camera_bro_shot.basecam.origin = level.camera_bro_shot.char_loc[0].origin;
  level.camera_bro_shot.basecam.angles = level.camera_bro_shot.char_loc[0].angles;
  level.broshottauntqueue = undefined;
  level.broshotfirstcamblends = calcfirstcamerablendpts();

  if(level.broshotwinnersgoodguys) {
    setomnvar("ui_broshot_debug_restart", 2);
    thread introsequence_marinewinner();
  } else {
    setomnvar("ui_broshot_debug_restart", 1);
    thread introsequence_opforwinner();
  }

  thread tauntinputlisten(level.topplayers);
  level.forcebroshot = 1;
  createwinnersandlosersarrays();
  var_0 = int(min(3, level.topplayers.size));
  var_1 = int(min(3, level.toplosingplayers.size));

  for(var_2 = 0; var_2 < 6; var_2++) {
    var_3 = 1;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;

    if(var_2 <= var_0 - 1) {
      var_4 = level.topplayers[var_2];

      if(level.broshotwinnersgoodguys) {
        var_5 = 10;
        var_6 = 6;
      } else {
        var_5 = 1;
        var_6 = 1;
      }
    } else if(var_2 <= var_0 + var_1 - 1) {
      var_3 = 0;
      var_4 = level.toplosingplayers[var_2 - var_0];

      if(level.broshotwinnersgoodguys) {
        var_5 = 1;
        var_6 = 1;
      } else {
        var_5 = 10;
        var_6 = 6;
      }
    }

    if(!isDefined(var_4)) {
      break;
    }

    if(!isDefined(var_4.loadoutarchetype)) {
      continue;
    }

    if(isDefined(var_4.bro)) {
      var_4.bro delete();
    }

    createmvparrayentry(var_2, var_4, var_3, var_5, var_6);
  }

  waitframe();
  startpodium(-1, self.mvparray);
}

function introsequence_marinewinner() {
  var_0 = cameraintrotrackdata_marine();
  trydof(var_0);
  thread playtracks(var_0, level.camera_bro_shot.basecam);
  cameraactivatetrack(var_0);
  var_0 = cameraidletrackdata_marine();
  thread playtracks(var_0, level.camera_bro_shot.basecam);
  level notify("bro_intro_done");
  cameraactivatetrack(var_0);
}

function introsequence_opforwinner() {
  var_0 = cameraintrotrackdata_opfor();
  trydof(var_0);
  thread playtracks(var_0, level.camera_bro_shot.basecam);
  cameraactivatetrack(var_0);
  var_0 = cameraidletrackdata_opfor();
  thread playtracks(var_0, level.camera_bro_shot.basecam);
  level notify("bro_intro_done");
  cameraactivatetrack(var_0);
}

function introsequence() {
  var_0 = cameraintrotrackdata();
  thread playtracks(var_0, level.camera_bro_shot.basecam);
  cameraactivatetrack(var_0);
  cameraactivatetrack(var_0);
  var_0 = cameraintroidletrackdata();
  thread playtracks(var_0, level.camera_bro_shot.basecam);
  self notify("bro_intro_done");
  cameraactivatetrack(var_0);
}

function capturesequencemarinesdata(var_0) {
  switch (var_0) {
    case 0:
    default:
      var_1 = cameramercytrackdata_marines_1st();
      break;
    case 1:
      var_1 = cameramercytrackdata_marines_2nd();
      break;
    case 2:
      var_1 = cameramercytrackdata_marines_3rd();
      break;
  }

  return var_1;
}

function capturesequenceopfordata(var_0) {
  switch (var_0) {
    case 0:
    default:
      var_1 = cameramercytrackdata_opfor_1st();
      break;
    case 1:
      var_1 = cameramercytrackdata_opfor_2nd();
      break;
    case 2:
      var_1 = cameramercytrackdata_opfor_3rd();
      break;
  }

  return var_1;
}

function killsequencemarinesdata(var_0) {
  switch (var_0) {
    case 0:
    default:
      var_1 = cameraexecutetrackdata_marines_1st();
      break;
    case 1:
      var_1 = cameraexecutetrackdata_marines_2nd();
      break;
    case 2:
      var_1 = cameraexecutetrackdata_marines_3rd();
      break;
  }

  return var_1;
}

function killsequenceopfordata(var_0) {
  switch (var_0) {
    case 0:
    default:
      var_1 = cameraexecutetrackdata_opfor_1st();
      break;
    case 1:
      var_1 = cameraexecutetrackdata_opfor_2nd();
      break;
    case 2:
      var_1 = cameraexecutetrackdata_opfor_3rd();
      break;
  }

  return var_1;
}

function killsequence(var_0) {
  var_1 = camerakilltrackdata();
  thread playtracks(var_1, var_0);
  return var_1;
}

function capturesequence(var_0) {
  var_1 = cameracapturetrackdata();
  thread playtracks(var_1, var_0);
  return var_1;
}

function waitpopfov(var_0, var_1) {
  self endon("broshot_done");
  wait var_1 / 30;
  popfov(var_0);
}

function hideeffectsforbroshot() {
  if(self.sessionteam == "spectator" || self.sessionteam == "follower") {
    return;
  }

  if(!isDefined(self.loadoutarchetype)) {
    return;
  }

  self setscriptablepartstate("cloak", "offImmediate", 1);
  self setscriptablepartstate("armorUpMaterial", "offImmediate", 1);
  self setscriptablepartstate("armorUp", "neutral", 1);
  self setscriptablepartstate("adrenalineHeal", "neutral", 1);
  self setscriptablepartstate("pts_drone", "off", 1);
}

function spawnfilllight() {
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("FX_BRO_LIGHT"), level.camera_anchor, "tag_origin");
}

function fadetoblack(var_0) {
  wait 27;
  scripts\mp\utility\player::_visionsetnaked("", 0);

  foreach(var_2 in level.players) {
    if(isbot(var_2)) {
      continue;
    }

    var_2 visionsetfadetoblackforplayer("bw", var_0);
  }
}

function cleanupequipment() {
  self notify("bro_shot_start");
  scripts\mp\weapons::deleteallgrenades();
  var_0 = getweaponarray();

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      var_2 delete();
    }

    return;
  }
}

function cleanupgamemodes() {
  if(isDefined(level.teamflags)) {
    if(isDefined(level.teamflags[game["attackers"]]) && isDefined(level.teamflags[game["attackers"]].visuals)) {
      for(var_0 = 0; var_0 < level.teamflags[game["attackers"]].visuals.size; var_0++) {
        level.teamflags[game["attackers"]].visuals[var_0] hide();
      }
    }

    if(isDefined(level.teamflags[game["defenders"]]) && isDefined(level.teamflags[game["defenders"]].visuals)) {
      for(var_0 = 0; var_0 < level.teamflags[game["defenders"]].visuals.size; var_0++) {
        level.teamflags[game["defenders"]].visuals[var_0] hide();
      }
    }
  }

  if((scripts\mp\utility\game::getgametype() == "dom" || scripts\mp\utility\game::getgametype() == "siege") && isDefined(level.objectives)) {
    foreach(var_2 in level.objectives) {
      if(isDefined(var_2)) {
        var_2.scriptable setscriptablepartstate("flag", "off");
        var_2.scriptable setscriptablepartstate("pulse", "off");
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() == "grind" && isDefined(level.objectives)) {
    foreach(var_5 in level.objectives) {
      if(isDefined(var_5) && isDefined(var_5.scriptable)) {
        var_5.scriptable setscriptablepartstate("flag", "off");
        var_5.scriptable setscriptablepartstate("pulse", "off");
      }
    }
  }

  if((scripts\mp\utility\game::getgametype() == "sr" || scripts\mp\utility\game::getgametype() == "dd" | scripts\mp\utility\game::getgametype() == "sd") && isDefined(level.objectives)) {
    foreach(var_8 in level.objectives) {
      if(isDefined(var_8) && isDefined(var_8.visuals)) {
        for(var_9 = 0; var_9 < var_8.visuals.size; var_9++) {
          if(isDefined(var_8.visuals[var_9])) {
            var_8.visuals[var_9] hide();
          }
        }
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() == "front" && isDefined(level.zones)) {
    foreach(var_5 in level.zones) {
      if(isDefined(var_5) && isDefined(var_5.visuals)) {
        for(var_9 = 0; var_9 < var_5.visuals.size; var_9++) {
          var_5.visuals[var_9] hide();
        }
      }
    }
  }

  if(istrue(level.dogtagsenabled)) {
    if(isDefined(level.dogtags)) {
      foreach(var_14 in level.dogtags) {
        if(isDefined(var_14) && isDefined(var_14.visuals)) {
          for(var_9 = 0; var_9 < var_14.visuals.size; var_9++) {
            var_14.visuals[var_9] hide();
          }
        }
      }
    }
  }

  if(isDefined(level.balls)) {
    foreach(var_17 in level.balls) {
      var_17.visuals[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
    }
  }

  if((scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "grnd") && isDefined(level.zones)) {
    foreach(var_5 in level.zones) {
      if(isDefined(var_5) && isDefined(var_5.useobj) && isDefined(var_5.useobj.chevrons)) {
        foreach(var_21 in var_5.useobj.chevrons) {
          for(var_9 = 0; var_9 < var_21.numchevrons; var_9++) {
            var_21 setscriptablepartstate("chevron_" + var_9, "off");
          }
        }
      }
    }

    return;
  }
}

function tauntinputlisten(var_0) {
  wait 3;

  for(var_1 = 0; var_1 < 3; var_1++) {
    if(!isDefined(var_0[var_1]) || isbot(var_0[var_1]) || !scripts\engine\utility::array_contains(level.players, var_0[var_1])) {
      continue;
    }

    thread listenfortauntinput(var_0[var_1]);
  }
}

function getdisplayweapon(var_0) {
  var_1 = createheadicon(var_0.lastdroppableweaponobj);

  if(!issubstr(var_1, var_0.pers["primaryWeapon"]) && !issubstr(var_1, var_0.pers["secondaryWeapon"])) {
    var_1 = createheadicon(var_0.spawnweaponobj);
  }

  if(issubstr(var_1, "iw8_fists_mp") || issubstr(var_1, "iw8_knife") || issubstr(var_1, "iw7_axe")) {
    var_1 = var_0.pers["secondaryWeapon"];
  }

  if(issubstr(var_1, "nunchucks") || issubstr(var_1, "katana")) {
    var_1 = "iw8_fists_mp";
  }

  return var_1;
}

function camera_move_helper(var_0, var_1, var_2, var_3) {
  self predictstreampos(var_0.origin);
  wait var_2;
  level.camera_anchor scriptmodelclearanim();
  var_4 = distance(level.camera_anchor.origin, var_0.origin);
  var_5 = var_4 / var_1;

  if(var_5 < level.framedurationseconds) {
    var_5 = level.framedurationseconds;
  }

  level.camera_anchor.move_target = var_0;
  level.camera_anchor moveTo(var_0.origin, var_5);
  level.camera_anchor rotateTo(var_0.angles, var_5);

  if(isDefined(var_3)) {
    wait var_5 - var_3;
    thread scripts\mp\utility\game::setuipostgamefade(var_3);
    return;
  }
}

function endbroshot() {
  level.broshotrunning = undefined;
  self notify("broshot_done");

  foreach(var_1 in level.players) {
    var_1 clearsoundsubmix("mp_broshot");
  }
}

function makebrowinner(var_0, var_1) {
  var_2 = spawn("script_character", var_1.origin, 0, 0, var_0, "MPClientCharacter");
  var_2.angles = var_1.angles;

  if(istrue(level.nukegameover) && var_0 == 0) {
    playFX(scripts\engine\utility::getfx("mons_screen_ash"), var_1.origin);
  }

  var_2 motionblurhqenable();
  return var_2;
}

function listenfortauntinput(var_0) {
  if(!isai(self)) {
    self notifyonplayercommand("bro_action_kill", "+attack");
    self notifyonplayercommand("bro_action_capture", "+speed_throw");
  }

  thread listenforcapturekill(var_0);
  thread waitforintrodone();
  self waittill("taunt_end");
}

function popfov(var_0) {
  foreach(var_2 in level.players) {
    if(!isai(var_2)) {
      var_2 setclientdvar("cg_fov", var_0);
    }
  }
}

function listenforcapturekill(var_0) {
  self endon("taunt_queued");
  self endon("taunt_start");
  self endon("broshot_done");
  GscBinSkip4(0x35, var_0);
}

function listenforcapture(var_0) {
  self waittill("bro_action_capture");
  self setclientomnvar("ui_broshot_choice_lock_in", 2);
  thread queuecapturekill(var_0, 2);
}

function listenforkill(var_0) {
  self waittill("bro_action_kill");
  self setclientomnvar("ui_broshot_choice_lock_in", 1);
  thread queuecapturekill(var_0, 1);
}

function listenfortaunt(var_0, var_1) {
  self endon("taunt_start");
  self endon("broshot_done");

  for(;;) {
    self waittill("bro_action_" + var_1);
    thread dotaunt(var_0, var_1);
    waitframe();
  }
}

function queuecapturekill(var_0, var_1) {
  self notify("taunt_queued");

  if(isDefined(level.overridebroslot)) {
    var_0 = level.overridebroslot - 1;
  }

  queuecapturekillchoice(var_0, var_1);
}

function calcfirstcamerablendpts() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, spawnStruct());
}

function playfirstcamblendpt(var_0, var_1, var_2) {
  var_3 = spawn("script_model", level.camera_bro_shot.char_loc[var_0].origin);
  var_3 setModel("tag_origin");
  var_3.angles = level.camera_bro_shot.char_loc[var_0].angles;
  var_3 scriptmodelplayanimdeltamotion(var_1);
  wait 0.5;
  var_2.firstblendtargetpos = var_3.origin;
  var_2.firstblendtargetrot = var_3.angles;
}

function cameraintrotrackdata_marine() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.dofnearstart = 10;
  var_0.dofnearend = 50;
  var_0.doffarstart = 320;
  var_0.doffarend = 640;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 5.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_intro_us_cam_a_ar";
  var_0.keys[0].nexttrackframe = 161;
  return var_0;
}

function cameraintrotrackdata_opfor() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.dofnearstart = 10;
  var_0.dofnearend = 50;
  var_0.doffarstart = 160;
  var_0.doffarend = 680;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 5.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_intro_op_cam_a";
  var_0.keys[0].nexttrackframe = 240;
  return var_0;
}

function cameraidletrackdata_marine() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_idle_us_cam_ar";
  var_0.keys[0].nexttrackframe = 191;
  return var_0;
}

function cameraidletrackdata_opfor() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_idle_op_cam";
  var_0.keys[0].nexttrackframe = 161;
  return var_0;
}

function cameraexecutetrackdata_opfor_1st() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.precutstartframe = 5;
  var_0.dofnearstart = 10;
  var_0.dofnearend = 50;
  var_0.doffarstart = 80;
  var_0.doffarend = 260;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 5.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_execute_op_cam_a_1st";
  var_0.keys[0].nexttrackframe = 489;
  return var_0;
}

function cameraexecutetrackdata_opfor_2nd() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.cutframe = 105;
  var_0.precutstartframe = 20;
  var_0.dofnearstart = 10;
  var_0.dofnearend = 80;
  var_0.doffarstart = 100;
  var_0.doffarend = 200;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 4.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_execute_op_cam_a_2nd";
  var_0.keys[0].nexttrackframe = 236;
  return var_0;
}

function cameraexecutetrackdata_opfor_3rd() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.cutframe = 90;
  var_0.precutstartframe = 0;
  var_0.dofnearstart = 10;
  var_0.dofnearend = 80;
  var_0.doffarstart = 120;
  var_0.doffarend = 240;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 4.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_execute_op_cam_a_3rd";
  var_0.keys[0].nexttrackframe = 211;
  return var_0;
}

function cameraexecutetrackdata_marines_1st() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.precutstartframe = 0;
  var_0.dofnearstart = 10;
  var_0.dofnearend = 50;
  var_0.doffarstart = 140;
  var_0.doffarend = 200;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 5.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_execute_us_cam_a_1st_ar";
  var_0.keys[0].nexttrackframe = 80;
  var_0.keys[1] = spawnStruct();
  var_0.keys[1].frame = 80;
  var_0.keys[1].nexttrackframe = 117;
  var_0.keys[1].fovanimframe = 0;
  var_0.keys[1].fovzoomstyle = "zombiearcade";
  var_0.keys[2] = spawnStruct();
  var_0.keys[2].frame = 117;
  var_0.keys[2].nexttrackframe = 351;
  var_0.keys[2].fovanimframe = 0;
  var_0.keys[2].fovzoomstyle = "zombiedefault";
  return var_0;
}

function cameraexecutetrackdata_marines_1st_alt() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_execute_us_cam_a_1st_ar";
  var_0.keys[0].nexttrackframe = 45;
  var_0.keys[0].fovanimframe = 16;
  var_0.keys[0].fovzoomstyle = "zombiearcade";
  var_0.keys[1] = spawnStruct();
  var_0.keys[1].frame = 45;
  var_0.keys[1].timescaleold = 1;
  var_0.keys[1].timescale = 0.333;
  var_0.keys[1].timescaleramptime = 4;
  var_0.keys[1].nexttrackframe = 165;
  var_0.keys[2] = spawnStruct();
  var_0.keys[2].frame = 165;
  var_0.keys[2].timescaleold = 0.333;
  var_0.keys[2].timescale = 1;
  var_0.keys[2].timescaleramptime = 2;
  var_0.keys[2].nexttrackframe = 251;
  return var_0;
}

function cameraexecutetrackdata_marines_2nd() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.cutframe = 51;
  var_0.precutstartframe = 0;
  var_0.dofnearstart = 10;
  var_0.dofnearend = 80;
  var_0.doffarstart = 100;
  var_0.doffarend = 200;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 4.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_execute_us_cam_a_2nd";
  var_0.keys[0].nexttrackframe = 140;
  return var_0;
}

function cameraexecutetrackdata_marines_3rd() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.cutframe = 60;
  var_0.precutstartframe = 10;
  var_0.dofnearstart = 10;
  var_0.dofnearend = 80;
  var_0.doffarstart = 120;
  var_0.doffarend = 240;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 4.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_execute_us_cam_a_3rd";
  var_0.keys[0].nexttrackframe = 171;
  return var_0;
}

function cameramercytrackdata_marines_1st() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.precutstartframe = 10;
  var_0.dofnearstart = 10;
  var_0.dofnearend = 50;
  var_0.doffarstart = 80;
  var_0.doffarend = 160;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 5.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_mercy_us_cam_a_1st";
  var_0.keys[0].nexttrackframe = 300;
  return var_0;
}

function cameramercytrackdata_marines_2nd() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.cutframe = 48;
  var_0.precutstartframe = 10;
  var_0.dofnearstart = 10;
  var_0.dofnearend = 80;
  var_0.doffarstart = 100;
  var_0.doffarend = 200;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 4.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_mercy_us_cam_a_2nd";
  var_0.keys[0].nexttrackframe = 156;
  return var_0;
}

function cameramercytrackdata_marines_3rd() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.cutframe = 85;
  var_0.precutstartframe = 10;
  var_0.dofnearstart = 10;
  var_0.dofnearend = 80;
  var_0.doffarstart = 120;
  var_0.doffarend = 240;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 4.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_mercy_us_cam_a_3rd";
  var_0.keys[0].nexttrackframe = 161;
  return var_0;
}

function cameramercytrackdata_opfor_1st() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.precutstartframe = 10;
  var_0.dofnearstart = 10;
  var_0.dofnearend = 50;
  var_0.doffarstart = 80;
  var_0.doffarend = 160;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 5.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_mercy_op_cam_a_1st";
  var_0.keys[0].nexttrackframe = 401;
  return var_0;
}

function cameramercytrackdata_opfor_2nd() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.cutframe = 91;
  var_0.precutstartframe = 10;
  var_0.dofnearstart = 10;
  var_0.dofnearend = 80;
  var_0.doffarstart = 100;
  var_0.doffarend = 200;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 4.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_mercy_op_cam_a_2nd";
  var_0.keys[0].nexttrackframe = 166;
  return var_0;
}

function cameramercytrackdata_opfor_3rd() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.cutframe = 59;
  var_0.precutstartframe = 0;
  var_0.dofnearstart = 10;
  var_0.dofnearend = 80;
  var_0.doffarstart = 120;
  var_0.doffarend = 240;
  var_0.dofnearblur = 7;
  var_0.doffarblur = 4.5;
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "iw8_mp_end_game_mercy_op_cam_a_3rd";
  var_0.keys[0].nexttrackframe = 131;
  return var_0;
}

function cameraintrotrackdata() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 34.3;
  var_0.keys[0].stranim = "iw8_mp_end_game_intro_cam_A";
  var_0.keys[0].nexttrackframe = 116;
  var_0.keys[1] = spawnStruct();
  var_0.keys[1].frame = 116;
  var_0.keys[1].fovkey = 46.8;
  var_0.keys[1].stranim = "iw8_mp_end_game_intro_cam_B";
  var_0.keys[1].nexttrackframe = 160;
  return var_0;
}

function cameraintroidletrackdata() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 46.8;
  var_0.keys[0].stranim = "iw8_mp_end_game_idle_cam";
  return var_0;
}

function camerakilltrackdata() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 34.3;
  var_0.keys[0].nexttrackframe = 396;
  var_0.keys[0].stranim = "iw8_mp_end_game_execute_stab_cam";
  return var_0;
}

function cameracapturetrackdata() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].nexttrackframe = 34;
  var_0.keys[0].fovkey = 34.3;
  var_0.keys[0].stranim = "iw8_mp_end_game_mercy_punch_cam_A";
  var_0.keys[1] = spawnStruct();
  var_0.keys[1].frame = 34;
  var_0.keys[1].fovkey = 46.8;
  var_0.keys[1].nexttrackframe = 253;
  var_0.keys[1].stranim = "iw8_mp_end_game_mercy_punch_cam_B";
  return var_0;
}

function playlerptrack(var_0, var_1) {
  var_2 = var_0.keys[0];
  var_2.lerp_camera_anchor = spawn("script_model", var_1.origin);
  var_2.lerp_camera_anchor setModel("tag_origin");
  var_2.lerp_camera_anchor.origin = var_1.origin;
  var_2.lerp_camera_anchor.angles = var_1.angles;
  var_2.lerp_camera_anchor scriptmodelplayanimdeltamotion(var_2.stranim);
}

function playtracks(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.keys.size; var_2++) {
    var_3 = var_0.keys[var_2];
    var_4 = undefined;

    if(var_2 > 0) {
      var_4 = var_0.keys[var_2 - 1];
    }

    if(isDefined(var_3.stranim)) {
      var_3.camera_anchor = spawn("script_model", var_1.origin);
      var_3.camera_anchor setModel("tag_origin");
      var_3.camera_anchor.origin = var_1.origin;
      var_3.camera_anchor.angles = var_1.angles;
      var_3.camera_anchor scriptmodelplayanimdeltamotion(var_3.stranim);
    } else {
      var_3.camera_anchor = var_4.camera_anchor;
    }

    if(isDefined(var_3.fovkey)) {
      var_3.fov = var_3.fovkey;
      continue;
    }

    var_3.fov = var_4.fov;
  }

  var_0.currenttrackindex = 0;
}

function cameraactivatetrack(var_0, var_1, var_2) {
  self endon("play_cam_track");
  self endon("broshot_done");
  self notify("trackActivated");
  self endon("trackActivated");
  var_3 = var_0.keys[var_0.currenttrackindex];
  popfov(var_3.fov);

  if(istrue(var_1)) {
    if(isDefined(var_3.lerp_camera_anchor)) {
      GscBinSkip4(0x35, var_3.lerp_camera_anchor, var_3.camera_anchor, 0.5);
    }

    var_4 = spawn("script_model", level.broshotfirstcamblends[var_2 - 1].firstblendtargetpos);
    var_4 setModel("tag_origin");
    var_4.angles = level.broshotfirstcamblends[var_2 - 1].firstblendtargetrot;
    GscBinSkip4(0x35, var_4, var_3.camera_anchor, 0.5);
  }

  foreach(var_6 in level.players) {
    if(isbot(var_6)) {
      continue;
    }

    var_6 cameraunlink();
    var_6 cameralinkTo(var_4.camera_anchor, "tag_origin", 1);
  }

  level.lastactivatedcameraobject = var_4.camera_anchor;

  if(isDefined(var_4.fovanimframe) && isDefined(var_4.fovzoomstyle)) {
    GscBinSkip4(0x35, var_4.fovanimframe, var_4.fovzoomstyle);
  }

  if(isDefined(var_4.timescale)) {}

  if(isDefined(var_4.nexttrackframe)) {
    wait(var_4.nexttrackframe - var_4.frame) / 30;
  }

  var_1.currenttrackindex++;
  return isDefined(var_1.keys[var_1.currenttrackindex]);
}

function cameralerpto(var_0, var_1, var_2) {
  if(isDefined(level.lastactivatedcameraobject)) {
    var_3 = getdvarfloat("r_mbVelocityScale");
    setDvar("r_mbVelocityScale", 2);
    var_4 = level.lastactivatedcameraobject.origin;
    var_5 = level.lastactivatedcameraobject.angles;
    level.temp_anchor = spawn("script_model", var_4);
    level.temp_anchor setModel("tag_origin");
    level.temp_anchor.angles = var_5;

    foreach(var_7 in level.players) {
      if(isbot(var_7)) {
        continue;
      }

      var_7 cameraunlink();
      var_7 cameralinkTo(level.temp_anchor, "tag_origin", 1);
    }

    level.temp_anchor moveTo(var_0.origin, var_2, 0, var_2 / 2);
    level.temp_anchor rotateTo(var_0.angles, var_2, 0, var_2 / 2);
    level.lastactivatedcameraobject = level.temp_anchor;
    wait var_2;
    setDvar("r_mbVelocityScale", var_3);
  } else {
    level.lastactivatedcameraobject = var_1;
  }

  foreach(var_7 in level.players) {
    if(isbot(var_7)) {
      continue;
    }

    var_7 cameraunlink();
    var_7 cameralinkTo(var_1, "tag_origin", 1);
  }

  level.lastactivatedcameraobject = var_1;
}

function resetfovzoom() {
  foreach(var_1 in level.players) {
    if(isbot(var_1)) {
      continue;
    }

    var_1 lerpfovbypreset("default");
  }
}

function dofovzoom(var_0, var_1) {
  wait var_0 / 30;

  foreach(var_3 in level.players) {
    if(isbot(var_3)) {
      continue;
    }

    var_3 lerpfovbypreset(var_1);
  }
}

function cameratrackintrocam() {
  self endon("broshot_done");
  popfov(34.3);
  level.camera_anchor scriptmodelplayanimdeltamotion("iw8_mp_end_game_intro_cam_A");
  wait 3.86667;
  popfov(46.8);
  level.camera_anchor scriptmodelplayanimdeltamotion("iw8_mp_end_game_intro_cam_B");
}

function cameratrackkillcam() {
  popfov(34.3);
  level.camera_anchor scriptmodelplayanimdeltamotion("iw8_mp_end_game_execute_stab_cam");
}

function cameratrackcapturecam() {
  self endon("broshot_done");
  popfov(34.3);
  level.camera_anchor scriptmodelplayanimdeltamotion("iw8_mp_end_game_mercy_punch_cam");
  wait 1.13333;
  popfov(46.8);
}

function docapturekill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("taunt_start");
  self endon("broshot_done");
  var_8 = var_2 - 0.5;

  if(var_8 > 0) {
    wait var_8;
    playlerptrack(level.camdata[var_0], level.camera_bro_shot.char_loc[var_0]);
  } else {
    var_8 = 0;
  }

  wait var_2 - var_8;
  playtracks(level.camdata[var_0], level.camera_bro_shot.char_loc[var_0]);
  var_9 = "ui_broshot_anim_" + var_0;
  var_10 = "ui_broshot_anim_" + var_0;
  setomnvar(var_10, var_1);

  if(isDefined(var_3)) {
    thread doslowmo(var_3, var_5, var_4, var_6, var_7);
  }

  var_11 = 300;
  var_12 = float(var_11) / 30;
  var_13 = var_12;
  wait var_13;
  level.taunts_done = 1;
  self notify("taunt_end");
}

function doslowmo(var_0, var_1, var_2, var_3, var_4) {
  self endon("broshot_done");

  if(!isDefined(level.never_kill_off_after_stealth)) {
    createheadiconatorigin("end_of_round");
    level.never_kill_off_after_stealth = 1;
  }

  wait var_0;
  setslowmotion(1, var_1, var_3);
  wait var_2;
  setslowmotion(var_1, 1, var_4);
}

function dotaunt(var_0, var_1) {
  self notify("taunt_start");
  self endon("broshot_done");

  if(isDefined(self.changedarchetypeinfo)) {
    var_2 = level.archetypeids[self.changedarchetypeinfo.archetype];
    var_3 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", var_2, "taunts", var_1 - 1);
  } else {
    var_3 = self getplayerdata(level.loadoutsgroup, "squadMembers", "taunts", var_3 - 1);
  }

  if(isDefined(level.overridebroslot)) {
    var_1 = level.overridebroslot - 1;
  }

  if(isDefined(level.overridetaunt)) {
    var_3 = tablelookup("mp/cac/taunts.csv", 0, level.overridetaunt, 1);
  }

  var_4 = tablelookuprownum("mp/cac/taunts.csv", 1, var_3);
  var_5 = tablelookup("mp/cac/taunts.csv", 0, var_4, 5);

  if(var_5 == "") {
    return;
  }

  var_6 = tablelookup("mp/cac/taunts.csv", 0, var_4, 19);
  var_7 = tablelookup("mp/cac/taunts.csv", 0, var_4, 20);
  var_8 = tablelookup("mp/cac/taunts.csv", 0, var_4, 21);
  var_9 = tablelookup("mp/cac/taunts.csv", 0, var_4, 12) == "Y";
  var_10 = tablelookup("mp/cac/taunts.csv", 0, var_4, 9);
  var_11 = "ui_broshot_anim_" + var_1;

  if(isDefined(level.interruptabletaunts[var_1]) && level.interruptabletaunts[var_1] == var_10) {
    self notify("taunt_end");
    return;
  }

  var_12 = 1;

  if(!isDefined(level.firsttaunttracker[var_11]) && !var_12) {
    if(!(var_9 && isDefined(level.supergunout[var_11]))) {
      level.firsttaunttracker[var_11] = 1;
      putgunaway(var_11);
    }

    if(!var_9) {
      level.supergunout[var_11] = undefined;
    }
  }

  if(var_9 && !isDefined(level.supergunout[var_11])) {
    level.firsttaunttracker[var_11] = undefined;
    takesupergunout(var_11, var_5);
    level.supergunout[var_11] = 1;
  }

  var_13 = tablelookup("mp/cac/taunts.csv", 0, var_4, 17);
  var_14 = tablelookup("mp/cac/taunts.csv", 0, var_4, 18);

  if(var_1 > 0 && var_13 != "" && var_14 != "") {
    if(var_1 == 1) {
      var_10 = var_13;
    } else if(var_1 == 2) {
      var_10 = var_14;
    }
  }

  scripts\mp\broshot_utilities::processepictaunt(var_10, var_1, 1);
  var_15 = "ui_broshot_anim_" + var_1;
  setomnvar(var_15, var_4);
  var_16 = float(var_8) / 30;
  var_17 = var_16;

  if(var_6 != "") {
    var_17 *= float(var_6);
  }

  level.camera_anchor scriptmodelclearanim();
  level.camera_anchor.angles = level.camera_bro_shot.basecam.angles;
  level.camera_anchor.origin = level.camera_bro_shot.basecam.origin;
  level.camera_anchor scriptmodelplayanimdeltamotion("iw8_mp_end_game_execute_stab_cam");
  level.interruptabletaunts[var_1] = var_10;
  thread interruptblocker(var_1, var_16);
  wait var_17;
  level.taunts_done = 1;
  self notify("taunt_end");
}

function queueanimationafter(var_0, var_1) {
  self endon("broshot_done");
  wait var_1 - 0.1;
  level.camera_anchor scriptmodelclearanim();
  level.camera_anchor.angles = level.camera_bro_shot.basecam.angles;
  level.camera_anchor.origin = level.camera_bro_shot.basecam.origin;
  self scriptmodelplayanimdeltamotion(var_0);
}

function interruptblocker(var_0, var_1) {
  self notify("combo_started_" + var_0);
  self endon("combo_started_" + var_0);
  wait var_1;
  level.interruptabletaunts[var_0] = undefined;
}

function getaltgunanimstring() {
  var_0 = getdisplayweapon(self);

  if(issubstr(var_0, "iw7_nrg") || issubstr(var_0, "iw7_udm45") || issubstr(var_0, "iw7_ump45_mpr_akimbo")) {
    return "_alt";
  }

  return "";
}

function getgunanimstring() {
  var_0 = getdisplayweapon(self);

  if(issubstr(var_0, "minilmg_mpl")) {
    return "augfury";
  }

  if(issubstr(var_0, "akimbo")) {
    return "akimbo";
  }

  if(issubstr(var_0, "mp28")) {
    return "mp28";
  }

  if(issubstr(var_0, "chargeshot") || issubstr(var_0, "venom")) {
    return "assault_rifle";
  }

  if(issubstr(var_0, "knife")) {
    return "knife";
  }

  if(issubstr(var_0, "axe")) {
    return "axe";
  }

  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  switch (var_1) {
    case "weapon_melee":
      return "melee";
    case "weapon_pistol":
      return "pistol";
    case "weapon_beam":
    case "weapon_smg":
      return "smg";
    case "weapon_assault":
    case "weapon_tactical":
      return "assault_rifle";
    case "weapon_lmg":
      return "lmg";
    case "weapon_rail":
    case "weapon_dmr":
    case "weapon_sniper":
      return "sniper";
    case "weapon_shotgun":
      return "shotgun";
    case "weapon_projectile":
      return "launcher";
    default:
      return "akimbo";
  }
}

function getgunanimindex() {
  var_0 = getdisplayweapon(self);
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(issubstr(var_0, "minilmg_mpl")) {
    return 11;
  }

  if(issubstr(var_0, "mp28")) {
    return 12;
  }

  if(issubstr(var_0, "akimbo") && !issubstr(var_0, "akimbofmg") && !issubstr(var_0, "mod_akimboshotgun")) {
    if(issubstr(var_0, "iw7_nrg") || issubstr(var_0, "iw7_udm45") || issubstr(var_0, "iw7_ump45_mpr_akimbo")) {
      return 13;
    }

    return 8;
  }

  if(issubstr(var_0, "chargeshot") || issubstr(var_0, "venom")) {
    return 2;
  }

  if(issubstr(var_0, "knife")) {
    return 9;
  }

  if(issubstr(var_0, "axe")) {
    return 10;
  }

  if(issubstr(var_0, "nunchuk") || issubstr(var_0, "katana")) {
    return 7;
  }

  switch (var_1) {
    case "weapon_pistol":
      return 0;
    case "weapon_beam":
    case "weapon_smg":
      return 1;
    case "weapon_assault":
    case "weapon_tactical":
      return 2;
    case "weapon_lmg":
      return 3;
    case "weapon_rail":
    case "weapon_dmr":
    case "weapon_sniper":
      return 4;
    case "weapon_shotgun":
      return 5;
    case "weapon_projectile":
      return 6;
    case "weapon_melee":
    default:
      return 7;
  }
}

function setguntypeforui(var_0) {
  var_1 = "ui_broshot_weapon_type_" + var_0;

  if(var_0 > 2) {
    setomnvar(var_1, 7);
    return;
  }

  setomnvar(var_1, getgunanimindex());
}

function putgunaway(var_0) {
  var_1 = getgunanimstring();
  var_2 = var_1 + "_put_away" + getaltgunanimstring();
  var_3 = tablelookuprownum("mp/cac/taunts.csv", 1, var_2);
  setomnvar(var_0, -1);
  var_4 = getgunputawayduration(var_1);
  wait var_4;
}

function takesupergunout(var_0, var_1) {
  var_2 = getrigtransstringfromref(var_1) + "transout_0";
  var_3 = tablelookuprownum("mp/cac/taunts.csv", 1, var_2);
  setomnvar(var_0, var_3 + 30000);
  var_4 = getrigsupertakeoutdurationfromref(var_1);
  wait var_4;
}

function getrigtransstringfromref(var_0) {
  var_1 = "";

  switch (var_0) {
    case "archetype_assault":
    default:
      var_1 = "war_";
      break;
  }

  return var_1;
}

function getgunputawayduration(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "akimbo":
    default:
      var_1 = 1.067;
      break;
    case "launcher":
      var_1 = 1.567;
      break;
    case "lmg":
      var_1 = 1.333;
      break;
    case "pistol":
      var_1 = 2.233;
      break;
    case "shotgun":
      var_1 = 1.233;
      break;
    case "mp28":
    case "smg":
      var_1 = 1.2;
      break;
    case "sniper":
      var_1 = 1.367;
      break;
    case "assault_rifle":
      var_1 = 1.233;
      break;
    case "melee":
      var_1 = 1.233;
      break;
  }

  return var_1 - 0.2;
}

function getrigsupertakeoutdurationfromref(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "archetype_assault":
    default:
      var_1 = 1.733;
      break;
  }

  return var_1 - 0.2;
}

function getrigsuperputawaydurationfromref(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "archetype_assault":
    default:
      var_1 = 1.267;
      break;
  }

  return var_1 - 0.2;
}

function compare_player_score(var_0, var_1) {
  return var_0.score >= var_1.score;
}

function onplayerconnect() {
  self endon("broshot_done");

  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {
      thread startlatejoinpodium(var_0);
    }
  }
}

function startlatejoinpodium(var_0) {
  var_0 endon("disconnect");
  wait 0.25;
  var_0 cameralinkTo(level.camera_anchor, "tag_origin", 1);
  var_1 = var_0 getentitynumber();
  startpodium(var_1, self.mvparray);
}

function changetestrig(var_0, var_1) {
  level.overriderig = var_0;
  var_2 = var_1 - 1;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  switch (var_0) {
    case 1:
    default:
      var_3 = 4;
      var_4 = 18;
      var_5 = 6;
      break;
    case 2:
      var_3 = 12;
      var_4 = 5;
      var_5 = 1;
      break;
    case 3:
      var_3 = 28;
      var_4 = 1;
      var_5 = 2;
      break;
    case 4:
      var_3 = 57;
      var_4 = 28;
      var_5 = 3;
      break;
    case 5:
      var_3 = 45;
      var_4 = 39;
      var_5 = 4;
      break;
    case 6:
      var_3 = 27;
      var_4 = 31;
      var_5 = 5;
      break;
  }

  self.mvparray = [];
  var_6 = max(var_1, level.topplayers.size);

  for(var_7 = 0; var_7 < var_6; var_7++) {
    self.mvparray[var_7] = spawnStruct();
    self.mvparray[var_7].rigindex = var_5;
    self.mvparray[var_7].bodyindex = var_4;
    self.mvparray[var_7].headindex = var_3;
    self.mvparray[var_7].weaponname = getdisplayweapon(level.players[0]);
    self.mvparray[var_7].clantag = level.players[0] getclantag();
    self.mvparray[var_7].name = level.players[0].name;
    self.mvparray[var_7].xuid = level.players[0] getxuid();
    self.mvparray[var_7].podiumindex = var_1;
    self.mvparray[var_7].clientnum = level.players[0] getentitynumber();

    if(!isDefined(level.topplayers[var_7])) {
      self.topplayers[var_7] = spawnStruct();
      level.topplayers[var_7].bro = makebrowinner(var_7, level.camera_bro_shot.char_loc[var_7]);
    }
  }

  for(var_7 = 0; var_7 < var_6; var_7++) {
    setguntypeforui(level.topplayers[var_7], var_7);
  }

  waitframe();
  startpodium(-1, self.mvparray);
}

function changetesttaunt(var_0) {
  level.overridetaunt = var_0;
}

function changetestslot(var_0) {
  level.overridebroslot = var_0;

  if(!isDefined(level.topplayers[var_0 - 1])) {
    var_1 = 0;

    if(isDefined(level.overriderig)) {
      var_1 = level.overriderig;
    }

    changetestrig(var_1, var_0);
    return;
  }
}