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

function initbroshot(var0) {
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
    if(!isDefined(var0)) {
      var1 = getteamscore("allies");
      var2 = getteamscore("axis");

      if(var1 == var2) {
        return false;
      }
    } else if(var0 == "tie" || var0 == "none" || var0 == "draw") {
      return false;
    }
  }

  level.camera_bro_shot.myfov = 40;
  level.camera_bro_shot.char_loc[1].origin = level.camera_bro_shot.char_loc[0].origin + anglestoleft(level.camera_bro_shot.char_loc[1].angles) * -40 + anglesToForward(level.camera_bro_shot.char_loc[1].angles) * -100;
  level.camera_bro_shot.char_loc[2].origin = level.camera_bro_shot.char_loc[0].origin + anglestoleft(level.camera_bro_shot.char_loc[2].angles) * 60 + anglesToForward(level.camera_bro_shot.char_loc[2].angles) * -130;
  setomnvar("ui_broshot_upside_down", istrue(level.upsidedowntaunts));
  sortwinnersandlosers(var0);
  level.numwinningplayers = int(min(3, level.topplayers.size));
  level.numlosingplayers = int(min(3, level.toplosingplayers.size));
  filterpairs();

  for(var3 = 0; var3 < level.numwinningplayers; var3++) {
    var4 = level.camera_bro_shot.char_loc[var3].origin - (0, 0, 50);
    var5 = (var4[0], var4[1], var4[2] + 100);
    var6 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 0);
    var7 = physics_raycast(var5, var4, var6, undefined, 1, "physicsquery_closest");
    var8 = isDefined(var7) && var7.size > 0;

    if(var8) {
      var9 = var7[0]["position"];
      level.camera_bro_shot.char_loc[var3].origin = var9;
    }

    level.camera_bro_shot.char_loc[var3].angles = level.camera_bro_shot.char_loc[var3].angles;
  }

  for(var3 = level.numwinningplayers; var3 < level.numwinningplayers + level.numlosingplayers; var3++) {
    var10 = var3 - level.numwinningplayers;
    level.camera_bro_shot.char_loc[var3].origin = level.camera_bro_shot.char_loc[var10].origin;
    level.camera_bro_shot.char_loc[var3].angles = level.camera_bro_shot.char_loc[var10].angles;
  }

  self.mvparray = [];
  return true;
}

function filterpairs() {
  var0 = min(level.numwinningplayers, level.numlosingplayers);

  if(var0 < level.numwinningplayers) {
    level.topplayers = scripts\engine\utility::array_remove_index(level.topplayers, level.topplayers.size - 1, 0);
    level.numwinningplayers = level.topplayers.size;
  }

  if(var0 < level.numlosingplayers) {
    level.toplosingplayers = scripts\engine\utility::array_remove_index(level.toplosingplayers, level.toplosingplayers.size - 1, 0);
    level.numlosingplayers = level.toplosingplayers.size;
    return;
  }
}

function timeoutcapturekills(var0) {
  level endon("queuedTauntsRun");
  wait var0;
  thread runqueuedtaunts();
}

function queuecapturekillchoice(var0, var1) {
  if(!isDefined(level.broshottauntqueue)) {
    level.broshottauntqueue = [];
  }

  if(!isDefined(level.broshottauntqueue[var0])) {
    level.broshottauntqueue[var0] = var1;

    if(0 || isDefined(level.debugbroshot)) {
      if(var0 == 0) {
        if(level.numwinningplayers > 1) {
          level.broshottauntqueue[var0 + 1] = var1;
        }

        if(level.numwinningplayers > 2) {
          level.broshottauntqueue[var0 + 2] = var1;
        }
      }
    }
  }

  var2 = 0;

  foreach(var4 in level.topplayers) {
    if(!isbot(var4)) {
      var2++;
    }
  }

  if(level.broshottauntqueue.size >= var2) {
    if(isDefined(level.broshotintrodone)) {
      thread runqueuedtaunts();
      return;
    }

    thread waittorunqueuedtaunts();
    return;
  }
}

function processcameradata(var0) {
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
    var1 = level.broshottauntqueue[2];
    var2 = getcamdata(var1, 2);
    level.camdata[2] = var2;
  }

  if(isDefined(level.broshottauntqueue[1])) {
    var1 = level.broshottauntqueue[1];
    var2 = getcamdata(var1, 1);
    level.camdata[1] = var2;
  }

  if(isDefined(level.broshottauntqueue[0])) {
    var1 = level.broshottauntqueue[0];
    var2 = getcamdata(var1, 0);
    level.camdata[0] = var2;
    return;
  }
}

function getcamdata(var0, var1) {
  if(var0 == 1) {
    if(level.broshotwinnersgoodguys) {
      var2 = killsequencemarinesdata(var1);
    } else {
      var2 = killsequenceopfordata(var2);
    }
  } else if(level.broshotwinnersgoodguys) {
    var2 = capturesequencemarinesdata(var2);
  } else {
    var2 = capturesequenceopfordata(var2);
  }

  return var2;
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

function calccameraduration(var0) {
  if(isDefined(var0.cutframe)) {
    return (var0.cutframe / 30);
  }

  var1 = var0.keys[var0.keys.size - 1];
  return var1.nexttrackframe / 30;
}

function calcprestarttime(var0) {
  return var0.precutstartframe / 30;
}

function runqueuedtaunts() {
  level notify("queuedTauntsRun");

  if(!isDefined(level.broshottauntqueue)) {
    level.broshottauntqueue = [];
  }

  var0 = 11;
  processcameradata(level.broshottauntqueue);
  var1 = 0;

  if(isDefined(level.broshottauntqueue[2])) {
    var2 = calccameraduration(level.camdata[2]);
    var3 = calcprestarttime(level.camdata[1]);
    var4 = level.broshottauntqueue[2];
    thread docapturekill(2, var4, var1);
    var0 += var2;
    var1 += var2 - var3;
  }

  if(isDefined(level.broshottauntqueue[1])) {
    var2 = calccameraduration(level.camdata[1]);
    var3 = calcprestarttime(level.camdata[0]);
    var4 = level.broshottauntqueue[1];
    thread docapturekill(1, var4, var1);
    var0 += var2;
    var1 += var2 - var3;
  }

  var4 = 0;

  if(isDefined(level.broshottauntqueue[0])) {
    var4 = level.broshottauntqueue[0];
  }

  var5 = 0;
  var6 = 0;
  var7 = 0;
  var8 = 0;
  var9 = 0;

  if(level.broshotwinnersgoodguys) {
    if(var4 == 1) {
      var5 = 3.16667;
      var6 = 0.733333;
      var7 = 0.2;
      var8 = 0.25;
      var9 = 0.15;
    } else {
      var5 = 2.5;
      var6 = 1.4;
      var7 = 0.2;
      var8 = 0.25;
      var9 = 0.15;
    }
  } else if(var4 == 1) {
    var5 = 5.33333;
    var6 = 0.5;
    var7 = 0.2;
    var8 = 0.25;
    var9 = 0.15;
  } else {
    var5 = 6.66667;
    var6 = 0.6;
    var7 = 0.2;
    var8 = 0.25;
    var9 = 0.15;
  }

  thread docapturekill(0, var4, var1, var5, var6, var7, var8, var9);
  thread notifywhentauntstimedout(var0);
  waitframe();
  var10 = 0;

  if(isDefined(level.broshottauntqueue[2])) {
    var2 = calccameraduration(level.camdata[2]);
    thread watchcameratracks(2, var4);
    var10 = var2;
  }

  if(isDefined(level.broshottauntqueue[1])) {
    var2 = calccameraduration(level.camdata[1]);
    wait var10;
    thread watchcameratracks(1, var4);
    var10 = var2;
  }

  wait var10;
  thread watchcameratracks(0, var4);
}

function notifywhentauntstimedout(var0) {
  wait var0;
  level notify("taunts_timed_out");

  if(istrue(level.debugbroshot)) {
    resetbroshot(level.players[0]);
    return;
  }
}

function trydof(var0) {
  if(isDefined(var0.dofnearstart)) {
    foreach(var2 in level.players) {
      if(isbot(var2)) {
        continue;
      }

      var2.usingcustomdof = 1;
      var2 setdepthoffield(var0.dofnearstart, var0.dofnearend, var0.doffarstart, var0.doffarend, var0.dofnearblur, var0.doffarblur);
    }

    return;
  }
}

function watchcameratracks(var0, var1) {
  self notify("play_cam_track");
  self endon("play_cam_track");
  var2 = level.camdata[var0];
  trydof(var2);
  var3 = 1;
  var4 = 1;

  while(isDefined(var2) && istrue(var4)) {
    var4 = cameraactivatetrack(var2, var3, var1);
    var3 = 0;
  }
}

function sortwinnersandlosers(var0) {
  if(level.teambased) {
    if(!isDefined(var0)) {
      var1 = getteamscore("allies");
      var2 = getteamscore("axis");
      var3 = scripts\engine\utility::ter_op(var1 >= var2, "allies", "axis");
    } else {
      var3 = var3;
    }

    level.topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var3, "players"), &compare_player_score);
    var4 = scripts\mp\utility\teams::getenemyplayers(var3);
    level.toplosingplayers = scripts\engine\utility::array_sort_with_func(var4, &compare_player_score);
    return;
  }

  level.topplayers = level.placement["all"];
  level.toplosingplayers = level.placement["all"];
}

function startbroshot(var0) {
  if(!isDefined(var0)) {
    var0 = self;
  }

  level.broshotrunning = 1;
  cleanupequipment();
  cleanupgamemodes();
  var1 = spawnStruct();
  var1.origin = level.camera_bro_shot.char_loc[0].origin;
  var1.angles = level.camera_bro_shot.char_loc[0].angles;
  level.camera_bro_shot.basecam.origin = var1.origin;
  level.camera_bro_shot.basecam.angles = var1.angles;

  foreach(var3 in level.players) {
    var3 scripts\mp\playerlogic::respawn_asspectator(var1.origin, var1.angles);
    var3 scripts\mp\gamelogic::freezeplayerforroundend();
    var3 playerhide();
  }

  removeallcorpses();
  level.active_camera = var1;
  level.camera_anchor = spawn("script_model", var1.origin);
  level.camera_anchor setModel("tag_origin");
  level.camera_anchor.angles = var1.angles;
  createwinnersandlosersarrays(var0);
  level.numwinningplayers = int(min(3, level.topplayers.size));
  level.numlosingplayers = int(min(3, level.toplosingplayers.size));
  filterpairs();
  level.supergunout = [];
  level.interruptabletaunts = [];
  level.firsttaunttracker = [];

  foreach(var3 in level.players) {
    hideeffectsforbroshot(var3);
  }

  if(!isDefined(level.broshotwinnersgoodguys)) {
    level.broshotwinnersgoodguys = level.topplayers[0].team == "allies";
  }

  for(var7 = 0; var7 < 6; var7++) {
    var8 = 1;
    var9 = undefined;

    if(var7 <= level.numwinningplayers - 1) {
      var9 = level.topplayers[var7];
    } else if(var7 <= level.numwinningplayers + level.numlosingplayers - 1) {
      var8 = 0;
      var9 = level.toplosingplayers[var7 - level.numwinningplayers];
    }

    if(!isDefined(var9)) {
      break;
    }

    if(!isDefined(var9.loadoutarchetype)) {
      continue;
    }

    var10 = undefined;
    var11 = undefined;

    if(istrue(level.debugbroshot)) {
      if(level.broshotwinnersgoodguys) {
        if(var8) {
          var10 = 10;
          var11 = 6;
        } else {
          var10 = 1;
          var11 = 1;
        }
      } else if(var8) {
        var10 = 1;
        var11 = 1;
      } else {
        var10 = 10;
        var11 = 6;
      }
    }

    createmvparrayentry(var7, var9, var8, var10, var11);
  }

  foreach(var3 in level.players) {
    var3 setsoundsubmix("mp_broshot");
    var3 setsolid(0);
    var3 dontinterpolate();

    if(isbot(var3)) {
      continue;
    }

    var3 cameralinkTo(level.camera_anchor, "tag_origin", 1);
    var3 thread scripts\mp\utility\game::setuipostgamefade(0);
    scripts\mp\utility\player::_visionsetnaked("", 0);

    if(!istrue(level.forcebroshot)) {
      thread fadetoblack(var3);
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

function createwinnersandlosersarrays(var0) {
  if(istrue(level.forcebroshot)) {
    if(level.broshotwinnersgoodguys) {
      var1 = "allies";
      var2 = "axis";
    } else {
      var1 = "allies";
      var2 = "axis";
    }

    if(scripts\mp\utility\teams::getteamdata(var1, "teamCount") > 1) {
      level.topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var1, "players"), &compare_player_score);
    } else {
      level.topplayers = [];
      level.topplayers[0] = self;
    }

    if(scripts\mp\utility\teams::getteamdata(var2, "teamCount") > 1) {
      level.toplosingplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var2, "players"), &compare_player_score);
      return;
    }

    level.topaxisplayers = [];
    level.toplosingplayers[0] = self;
    return;
  }

  sortwinnersandlosers(var2);
}

function createmvparrayentry(var0, var1, var2, var3, var4) {
  self.mvparray[var0] = spawnStruct();

  if(scripts\mp\utility\game::getgametype() == "infect") {
    if(isbot(var1)) {
      var5 = var1.loadoutarchetype;
    } else {
      var5 = var2 scripts\mp\class::cac_getcharacterarchetype();
    }
  } else {
    var5 = var3.loadoutarchetype;
  }

  var6 = tablelookuprownum("mp/battleRigTable.csv", 1, var5);

  if(isbot(var3) || isDefined(var3.lastarchetypeinfo)) {
    var7 = var3 getcustomizationbody();
    var8 = var3 getcustomizationhead();
    var9 = tablelookuprownum("mp/cac/heads.csv", 1, var8);
    var10 = tablelookuprownum("mp/cac/bodies.csv", 1, var7);

    if(isDefined(var3.lastarchetypeinfo)) {
      var6 = tablelookuprownum("mp/battleRigTable.csv", 1, var3.lastarchetypeinfo.archetype);
    }
  } else {
    var7 = var5 getcustomizationbody();
    var8 = var5 getcustomizationhead();
    var9 = tablelookuprownum("mp/cac/heads.csv", 1, var8);
    var10 = tablelookuprownum("mp/cac/bodies.csv", 1, var7);
  }

  if(isDefined(var7) && isDefined(var8)) {
    var9 = var7;
    var10 = var8;
  } else {
    var11 = var5 scripts\mp\teams::getglcustomization();
    var9 = tablelookuprownum("mp/cac/heads.csv", 1, var11[1]);
    var10 = tablelookuprownum("mp/cac/bodies.csv", 1, var11[0]);
  }

  self.mvparray[var5].rigindex = var10;
  self.mvparray[var5].bodyindex = var10;
  self.mvparray[var5].headindex = var9;

  if(var6) {
    if(istrue(level.broshotwinnersgoodguys)) {
      switch (var5) {
        case 0:
        default:
          self.mvparray[var5].weaponname = "iw8_ar_mike4_mp";
          break;
        case 1:
          self.mvparray[var5].weaponname = "iw8_ar_mike4_mp";
          break;
        case 2:
          self.mvparray[var5].weaponname = "iw8_pi_golf21_mp";
          break;
      }
    } else {
      switch (var5) {
        case 0:
        default:
          self.mvparray[var5].weaponname = "iw8_fists_mp";
          break;
        case 1:
          self.mvparray[var5].weaponname = "iw8_fists_mp";
          break;
        case 2:
          self.mvparray[var5].weaponname = "iw8_ar_mike4_mp";
          break;
      }
    }
  } else {
    self.mvparray[var5].weaponname = "iw8_fists_mp";
  }

  self.mvparray[var5].clantag = var5 getclantag();
  self.mvparray[var5].name = var5.name;
  self.mvparray[var5].xuid = var5 getxuid();
  self.mvparray[var5].podiumindex = var5;
  self.mvparray[var5].clientnum = var5 getentitynumber();
  setguntypeforui(var5, var5);
  var5.bro = makebrowinner(var5, level.camera_bro_shot.char_loc[var5]);
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
  var0 = int(min(3, level.topplayers.size));
  var1 = int(min(3, level.toplosingplayers.size));

  for(var2 = 0; var2 < 6; var2++) {
    var3 = 1;
    var4 = undefined;
    var5 = undefined;
    var6 = undefined;

    if(var2 <= var0 - 1) {
      var4 = level.topplayers[var2];

      if(level.broshotwinnersgoodguys) {
        var5 = 10;
        var6 = 6;
      } else {
        var5 = 1;
        var6 = 1;
      }
    } else if(var2 <= var0 + var1 - 1) {
      var3 = 0;
      var4 = level.toplosingplayers[var2 - var0];

      if(level.broshotwinnersgoodguys) {
        var5 = 1;
        var6 = 1;
      } else {
        var5 = 10;
        var6 = 6;
      }
    }

    if(!isDefined(var4)) {
      break;
    }

    if(!isDefined(var4.loadoutarchetype)) {
      continue;
    }

    if(isDefined(var4.bro)) {
      var4.bro delete();
    }

    createmvparrayentry(var2, var4, var3, var5, var6);
  }

  waitframe();
  startpodium(-1, self.mvparray);
}

function introsequence_marinewinner() {
  var0 = cameraintrotrackdata_marine();
  trydof(var0);
  thread playtracks(var0, level.camera_bro_shot.basecam);
  cameraactivatetrack(var0);
  var0 = cameraidletrackdata_marine();
  thread playtracks(var0, level.camera_bro_shot.basecam);
  level notify("bro_intro_done");
  cameraactivatetrack(var0);
}

function introsequence_opforwinner() {
  var0 = cameraintrotrackdata_opfor();
  trydof(var0);
  thread playtracks(var0, level.camera_bro_shot.basecam);
  cameraactivatetrack(var0);
  var0 = cameraidletrackdata_opfor();
  thread playtracks(var0, level.camera_bro_shot.basecam);
  level notify("bro_intro_done");
  cameraactivatetrack(var0);
}

function introsequence() {
  var0 = cameraintrotrackdata();
  thread playtracks(var0, level.camera_bro_shot.basecam);
  cameraactivatetrack(var0);
  cameraactivatetrack(var0);
  var0 = cameraintroidletrackdata();
  thread playtracks(var0, level.camera_bro_shot.basecam);
  self notify("bro_intro_done");
  cameraactivatetrack(var0);
}

function capturesequencemarinesdata(var0) {
  switch (var0) {
    case 0:
    default:
      var1 = cameramercytrackdata_marines_1st();
      break;
    case 1:
      var1 = cameramercytrackdata_marines_2nd();
      break;
    case 2:
      var1 = cameramercytrackdata_marines_3rd();
      break;
  }

  return var1;
}

function capturesequenceopfordata(var0) {
  switch (var0) {
    case 0:
    default:
      var1 = cameramercytrackdata_opfor_1st();
      break;
    case 1:
      var1 = cameramercytrackdata_opfor_2nd();
      break;
    case 2:
      var1 = cameramercytrackdata_opfor_3rd();
      break;
  }

  return var1;
}

function killsequencemarinesdata(var0) {
  switch (var0) {
    case 0:
    default:
      var1 = cameraexecutetrackdata_marines_1st();
      break;
    case 1:
      var1 = cameraexecutetrackdata_marines_2nd();
      break;
    case 2:
      var1 = cameraexecutetrackdata_marines_3rd();
      break;
  }

  return var1;
}

function killsequenceopfordata(var0) {
  switch (var0) {
    case 0:
    default:
      var1 = cameraexecutetrackdata_opfor_1st();
      break;
    case 1:
      var1 = cameraexecutetrackdata_opfor_2nd();
      break;
    case 2:
      var1 = cameraexecutetrackdata_opfor_3rd();
      break;
  }

  return var1;
}

function killsequence(var0) {
  var1 = camerakilltrackdata();
  thread playtracks(var1, var0);
  return var1;
}

function capturesequence(var0) {
  var1 = cameracapturetrackdata();
  thread playtracks(var1, var0);
  return var1;
}

function waitpopfov(var0, var1) {
  self endon("broshot_done");
  wait var1 / 30;
  popfov(var0);
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

function fadetoblack(var0) {
  wait 27;
  scripts\mp\utility\player::_visionsetnaked("", 0);

  foreach(var2 in level.players) {
    if(isbot(var2)) {
      continue;
    }

    var2 visionsetfadetoblackforplayer("bw", var0);
  }
}

function cleanupequipment() {
  self notify("bro_shot_start");
  scripts\mp\weapons::deleteallgrenades();
  var0 = getweaponarray();

  if(isDefined(var0)) {
    foreach(var2 in var0) {
      var2 delete();
    }

    return;
  }
}

function cleanupgamemodes() {
  if(isDefined(level.teamflags)) {
    if(isDefined(level.teamflags[game["attackers"]]) && isDefined(level.teamflags[game["attackers"]].visuals)) {
      for(var0 = 0; var0 < level.teamflags[game["attackers"]].visuals.size; var0++) {
        level.teamflags[game["attackers"]].visuals[var0] hide();
      }
    }

    if(isDefined(level.teamflags[game["defenders"]]) && isDefined(level.teamflags[game["defenders"]].visuals)) {
      for(var0 = 0; var0 < level.teamflags[game["defenders"]].visuals.size; var0++) {
        level.teamflags[game["defenders"]].visuals[var0] hide();
      }
    }
  }

  if((scripts\mp\utility\game::getgametype() == "dom" || scripts\mp\utility\game::getgametype() == "siege") && isDefined(level.objectives)) {
    foreach(var2 in level.objectives) {
      if(isDefined(var2)) {
        var2.scriptable setscriptablepartstate("flag", "off");
        var2.scriptable setscriptablepartstate("pulse", "off");
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() == "grind" && isDefined(level.objectives)) {
    foreach(var5 in level.objectives) {
      if(isDefined(var5) && isDefined(var5.scriptable)) {
        var5.scriptable setscriptablepartstate("flag", "off");
        var5.scriptable setscriptablepartstate("pulse", "off");
      }
    }
  }

  if((scripts\mp\utility\game::getgametype() == "sr" || scripts\mp\utility\game::getgametype() == "dd" | scripts\mp\utility\game::getgametype() == "sd") && isDefined(level.objectives)) {
    foreach(var8 in level.objectives) {
      if(isDefined(var8) && isDefined(var8.visuals)) {
        for(var9 = 0; var9 < var8.visuals.size; var9++) {
          if(isDefined(var8.visuals[var9])) {
            var8.visuals[var9] hide();
          }
        }
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() == "front" && isDefined(level.zones)) {
    foreach(var5 in level.zones) {
      if(isDefined(var5) && isDefined(var5.visuals)) {
        for(var9 = 0; var9 < var5.visuals.size; var9++) {
          var5.visuals[var9] hide();
        }
      }
    }
  }

  if(istrue(level.dogtagsenabled)) {
    if(isDefined(level.dogtags)) {
      foreach(var14 in level.dogtags) {
        if(isDefined(var14) && isDefined(var14.visuals)) {
          for(var9 = 0; var9 < var14.visuals.size; var9++) {
            var14.visuals[var9] hide();
          }
        }
      }
    }
  }

  if(isDefined(level.balls)) {
    foreach(var17 in level.balls) {
      var17.visuals[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
    }
  }

  if((scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "grnd") && isDefined(level.zones)) {
    foreach(var5 in level.zones) {
      if(isDefined(var5) && isDefined(var5.useobj) && isDefined(var5.useobj.chevrons)) {
        foreach(var21 in var5.useobj.chevrons) {
          for(var9 = 0; var9 < var21.numchevrons; var9++) {
            var21 setscriptablepartstate("chevron_" + var9, "off");
          }
        }
      }
    }

    return;
  }
}

function tauntinputlisten(var0) {
  wait 3;

  for(var1 = 0; var1 < 3; var1++) {
    if(!isDefined(var0[var1]) || isbot(var0[var1]) || !scripts\engine\utility::array_contains(level.players, var0[var1])) {
      continue;
    }

    thread listenfortauntinput(var0[var1]);
  }
}

function getdisplayweapon(var0) {
  var1 = createheadicon(var0.lastdroppableweaponobj);

  if(!issubstr(var1, var0.pers["primaryWeapon"]) && !issubstr(var1, var0.pers["secondaryWeapon"])) {
    var1 = createheadicon(var0.spawnweaponobj);
  }

  if(issubstr(var1, "iw8_fists_mp") || issubstr(var1, "iw8_knife") || issubstr(var1, "iw7_axe")) {
    var1 = var0.pers["secondaryWeapon"];
  }

  if(issubstr(var1, "nunchucks") || issubstr(var1, "katana")) {
    var1 = "iw8_fists_mp";
  }

  return var1;
}

function camera_move_helper(var0, var1, var2, var3) {
  self predictstreampos(var0.origin);
  wait var2;
  level.camera_anchor scriptmodelclearanim();
  var4 = distance(level.camera_anchor.origin, var0.origin);
  var5 = var4 / var1;

  if(var5 < level.framedurationseconds) {
    var5 = level.framedurationseconds;
  }

  level.camera_anchor.move_target = var0;
  level.camera_anchor moveTo(var0.origin, var5);
  level.camera_anchor rotateTo(var0.angles, var5);

  if(isDefined(var3)) {
    wait var5 - var3;
    thread scripts\mp\utility\game::setuipostgamefade(var3);
    return;
  }
}

function endbroshot() {
  level.broshotrunning = undefined;
  self notify("broshot_done");

  foreach(var1 in level.players) {
    var1 clearsoundsubmix("mp_broshot");
  }
}

function makebrowinner(var0, var1) {
  var2 = spawn("script_character", var1.origin, 0, 0, var0, "MPClientCharacter");
  var2.angles = var1.angles;

  if(istrue(level.nukegameover) && var0 == 0) {
    playFX(scripts\engine\utility::getfx("mons_screen_ash"), var1.origin);
  }

  var2 motionblurhqenable();
  return var2;
}

function listenfortauntinput(var0) {
  if(!isai(self)) {
    self notifyonplayercommand("bro_action_kill", "+attack");
    self notifyonplayercommand("bro_action_capture", "+speed_throw");
  }

  thread listenforcapturekill(var0);
  thread waitforintrodone();
  self waittill("taunt_end");
}

function popfov(var0) {
  foreach(var2 in level.players) {
    if(!isai(var2)) {
      var2 setclientdvar("QTSPTNLOL", var0);
    }
  }
}

function listenforcapturekill(var0) {
  self endon("taunt_queued");
  self endon("taunt_start");
  self endon("broshot_done");
  GscBinSkip4(0x35, var0);
}

function listenforcapture(var0) {
  self waittill("bro_action_capture");
  self setclientomnvar("ui_broshot_choice_lock_in", 2);
  thread queuecapturekill(var0, 2);
}

function listenforkill(var0) {
  self waittill("bro_action_kill");
  self setclientomnvar("ui_broshot_choice_lock_in", 1);
  thread queuecapturekill(var0, 1);
}

function listenfortaunt(var0, var1) {
  self endon("taunt_start");
  self endon("broshot_done");

  for(;;) {
    self waittill("bro_action_" + var1);
    thread dotaunt(var0, var1);
    waitframe();
  }
}

function queuecapturekill(var0, var1) {
  self notify("taunt_queued");

  if(isDefined(level.overridebroslot)) {
    var0 = level.overridebroslot - 1;
  }

  queuecapturekillchoice(var0, var1);
}

function calcfirstcamerablendpts() {
  var0 = [];
  GscBinSkip0(0x2e, 0, spawnStruct());
}

function playfirstcamblendpt(var0, var1, var2) {
  var3 = spawn("script_model", level.camera_bro_shot.char_loc[var0].origin);
  var3 setModel("tag_origin");
  var3.angles = level.camera_bro_shot.char_loc[var0].angles;
  var3 scriptmodelplayanimdeltamotion(var1);
  wait 0.5;
  var2.firstblendtargetpos = var3.origin;
  var2.firstblendtargetrot = var3.angles;
}

function cameraintrotrackdata_marine() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.dofnearstart = 10;
  var0.dofnearend = 50;
  var0.doffarstart = 320;
  var0.doffarend = 640;
  var0.dofnearblur = 7;
  var0.doffarblur = 5.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_intro_us_cam_a_ar";
  var0.keys[0].nexttrackframe = 161;
  return var0;
}

function cameraintrotrackdata_opfor() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.dofnearstart = 10;
  var0.dofnearend = 50;
  var0.doffarstart = 160;
  var0.doffarend = 680;
  var0.dofnearblur = 7;
  var0.doffarblur = 5.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_intro_op_cam_a";
  var0.keys[0].nexttrackframe = 240;
  return var0;
}

function cameraidletrackdata_marine() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_idle_us_cam_ar";
  var0.keys[0].nexttrackframe = 191;
  return var0;
}

function cameraidletrackdata_opfor() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_idle_op_cam";
  var0.keys[0].nexttrackframe = 161;
  return var0;
}

function cameraexecutetrackdata_opfor_1st() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.precutstartframe = 5;
  var0.dofnearstart = 10;
  var0.dofnearend = 50;
  var0.doffarstart = 80;
  var0.doffarend = 260;
  var0.dofnearblur = 7;
  var0.doffarblur = 5.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_execute_op_cam_a_1st";
  var0.keys[0].nexttrackframe = 489;
  return var0;
}

function cameraexecutetrackdata_opfor_2nd() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.cutframe = 105;
  var0.precutstartframe = 20;
  var0.dofnearstart = 10;
  var0.dofnearend = 80;
  var0.doffarstart = 100;
  var0.doffarend = 200;
  var0.dofnearblur = 7;
  var0.doffarblur = 4.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_execute_op_cam_a_2nd";
  var0.keys[0].nexttrackframe = 236;
  return var0;
}

function cameraexecutetrackdata_opfor_3rd() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.cutframe = 90;
  var0.precutstartframe = 0;
  var0.dofnearstart = 10;
  var0.dofnearend = 80;
  var0.doffarstart = 120;
  var0.doffarend = 240;
  var0.dofnearblur = 7;
  var0.doffarblur = 4.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_execute_op_cam_a_3rd";
  var0.keys[0].nexttrackframe = 211;
  return var0;
}

function cameraexecutetrackdata_marines_1st() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.precutstartframe = 0;
  var0.dofnearstart = 10;
  var0.dofnearend = 50;
  var0.doffarstart = 140;
  var0.doffarend = 200;
  var0.dofnearblur = 7;
  var0.doffarblur = 5.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_execute_us_cam_a_1st_ar";
  var0.keys[0].nexttrackframe = 80;
  var0.keys[1] = spawnStruct();
  var0.keys[1].frame = 80;
  var0.keys[1].nexttrackframe = 117;
  var0.keys[1].fovanimframe = 0;
  var0.keys[1].fovzoomstyle = "zombiearcade";
  var0.keys[2] = spawnStruct();
  var0.keys[2].frame = 117;
  var0.keys[2].nexttrackframe = 351;
  var0.keys[2].fovanimframe = 0;
  var0.keys[2].fovzoomstyle = "zombiedefault";
  return var0;
}

function cameraexecutetrackdata_marines_1st_alt() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_execute_us_cam_a_1st_ar";
  var0.keys[0].nexttrackframe = 45;
  var0.keys[0].fovanimframe = 16;
  var0.keys[0].fovzoomstyle = "zombiearcade";
  var0.keys[1] = spawnStruct();
  var0.keys[1].frame = 45;
  var0.keys[1].timescaleold = 1;
  var0.keys[1].timescale = 0.333;
  var0.keys[1].timescaleramptime = 4;
  var0.keys[1].nexttrackframe = 165;
  var0.keys[2] = spawnStruct();
  var0.keys[2].frame = 165;
  var0.keys[2].timescaleold = 0.333;
  var0.keys[2].timescale = 1;
  var0.keys[2].timescaleramptime = 2;
  var0.keys[2].nexttrackframe = 251;
  return var0;
}

function cameraexecutetrackdata_marines_2nd() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.cutframe = 51;
  var0.precutstartframe = 0;
  var0.dofnearstart = 10;
  var0.dofnearend = 80;
  var0.doffarstart = 100;
  var0.doffarend = 200;
  var0.dofnearblur = 7;
  var0.doffarblur = 4.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_execute_us_cam_a_2nd";
  var0.keys[0].nexttrackframe = 140;
  return var0;
}

function cameraexecutetrackdata_marines_3rd() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.cutframe = 60;
  var0.precutstartframe = 10;
  var0.dofnearstart = 10;
  var0.dofnearend = 80;
  var0.doffarstart = 120;
  var0.doffarend = 240;
  var0.dofnearblur = 7;
  var0.doffarblur = 4.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_execute_us_cam_a_3rd";
  var0.keys[0].nexttrackframe = 171;
  return var0;
}

function cameramercytrackdata_marines_1st() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.precutstartframe = 10;
  var0.dofnearstart = 10;
  var0.dofnearend = 50;
  var0.doffarstart = 80;
  var0.doffarend = 160;
  var0.dofnearblur = 7;
  var0.doffarblur = 5.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_mercy_us_cam_a_1st";
  var0.keys[0].nexttrackframe = 300;
  return var0;
}

function cameramercytrackdata_marines_2nd() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.cutframe = 48;
  var0.precutstartframe = 10;
  var0.dofnearstart = 10;
  var0.dofnearend = 80;
  var0.doffarstart = 100;
  var0.doffarend = 200;
  var0.dofnearblur = 7;
  var0.doffarblur = 4.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_mercy_us_cam_a_2nd";
  var0.keys[0].nexttrackframe = 156;
  return var0;
}

function cameramercytrackdata_marines_3rd() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.cutframe = 85;
  var0.precutstartframe = 10;
  var0.dofnearstart = 10;
  var0.dofnearend = 80;
  var0.doffarstart = 120;
  var0.doffarend = 240;
  var0.dofnearblur = 7;
  var0.doffarblur = 4.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_mercy_us_cam_a_3rd";
  var0.keys[0].nexttrackframe = 161;
  return var0;
}

function cameramercytrackdata_opfor_1st() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.precutstartframe = 10;
  var0.dofnearstart = 10;
  var0.dofnearend = 50;
  var0.doffarstart = 80;
  var0.doffarend = 160;
  var0.dofnearblur = 7;
  var0.doffarblur = 5.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_mercy_op_cam_a_1st";
  var0.keys[0].nexttrackframe = 401;
  return var0;
}

function cameramercytrackdata_opfor_2nd() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.cutframe = 91;
  var0.precutstartframe = 10;
  var0.dofnearstart = 10;
  var0.dofnearend = 80;
  var0.doffarstart = 100;
  var0.doffarend = 200;
  var0.dofnearblur = 7;
  var0.doffarblur = 4.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_mercy_op_cam_a_2nd";
  var0.keys[0].nexttrackframe = 166;
  return var0;
}

function cameramercytrackdata_opfor_3rd() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.cutframe = 59;
  var0.precutstartframe = 0;
  var0.dofnearstart = 10;
  var0.dofnearend = 80;
  var0.doffarstart = 120;
  var0.doffarend = 240;
  var0.dofnearblur = 7;
  var0.doffarblur = 4.5;
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 45;
  var0.keys[0].stranim = "iw8_mp_end_game_mercy_op_cam_a_3rd";
  var0.keys[0].nexttrackframe = 131;
  return var0;
}

function cameraintrotrackdata() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 34.3;
  var0.keys[0].stranim = "iw8_mp_end_game_intro_cam_A";
  var0.keys[0].nexttrackframe = 116;
  var0.keys[1] = spawnStruct();
  var0.keys[1].frame = 116;
  var0.keys[1].fovkey = 46.8;
  var0.keys[1].stranim = "iw8_mp_end_game_intro_cam_B";
  var0.keys[1].nexttrackframe = 160;
  return var0;
}

function cameraintroidletrackdata() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 46.8;
  var0.keys[0].stranim = "iw8_mp_end_game_idle_cam";
  return var0;
}

function camerakilltrackdata() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].fovkey = 34.3;
  var0.keys[0].nexttrackframe = 396;
  var0.keys[0].stranim = "iw8_mp_end_game_execute_stab_cam";
  return var0;
}

function cameracapturetrackdata() {
  var0 = spawnStruct();
  var0.keys = [];
  var0.keys[0] = spawnStruct();
  var0.keys[0].frame = 0;
  var0.keys[0].nexttrackframe = 34;
  var0.keys[0].fovkey = 34.3;
  var0.keys[0].stranim = "iw8_mp_end_game_mercy_punch_cam_A";
  var0.keys[1] = spawnStruct();
  var0.keys[1].frame = 34;
  var0.keys[1].fovkey = 46.8;
  var0.keys[1].nexttrackframe = 253;
  var0.keys[1].stranim = "iw8_mp_end_game_mercy_punch_cam_B";
  return var0;
}

function playlerptrack(var0, var1) {
  var2 = var0.keys[0];
  var2.lerp_camera_anchor = spawn("script_model", var1.origin);
  var2.lerp_camera_anchor setModel("tag_origin");
  var2.lerp_camera_anchor.origin = var1.origin;
  var2.lerp_camera_anchor.angles = var1.angles;
  var2.lerp_camera_anchor scriptmodelplayanimdeltamotion(var2.stranim);
}

function playtracks(var0, var1) {
  for(var2 = 0; var2 < var0.keys.size; var2++) {
    var3 = var0.keys[var2];
    var4 = undefined;

    if(var2 > 0) {
      var4 = var0.keys[var2 - 1];
    }

    if(isDefined(var3.stranim)) {
      var3.camera_anchor = spawn("script_model", var1.origin);
      var3.camera_anchor setModel("tag_origin");
      var3.camera_anchor.origin = var1.origin;
      var3.camera_anchor.angles = var1.angles;
      var3.camera_anchor scriptmodelplayanimdeltamotion(var3.stranim);
    } else {
      var3.camera_anchor = var4.camera_anchor;
    }

    if(isDefined(var3.fovkey)) {
      var3.fov = var3.fovkey;
      continue;
    }

    var3.fov = var4.fov;
  }

  var0.currenttrackindex = 0;
}

function cameraactivatetrack(var0, var1, var2) {
  self endon("play_cam_track");
  self endon("broshot_done");
  self notify("trackActivated");
  self endon("trackActivated");
  var3 = var0.keys[var0.currenttrackindex];
  popfov(var3.fov);

  if(istrue(var1)) {
    if(isDefined(var3.lerp_camera_anchor)) {
      GscBinSkip4(0x35, var3.lerp_camera_anchor, var3.camera_anchor, 0.5);
    }

    var4 = spawn("script_model", level.broshotfirstcamblends[var2 - 1].firstblendtargetpos);
    var4 setModel("tag_origin");
    var4.angles = level.broshotfirstcamblends[var2 - 1].firstblendtargetrot;
    GscBinSkip4(0x35, var4, var3.camera_anchor, 0.5);
  }

  foreach(var6 in level.players) {
    if(isbot(var6)) {
      continue;
    }

    var6 cameraunlink();
    var6 cameralinkTo(var4.camera_anchor, "tag_origin", 1);
  }

  level.lastactivatedcameraobject = var4.camera_anchor;

  if(isDefined(var4.fovanimframe) && isDefined(var4.fovzoomstyle)) {
    GscBinSkip4(0x35, var4.fovanimframe, var4.fovzoomstyle);
  }

  if(isDefined(var4.timescale)) {}

  if(isDefined(var4.nexttrackframe)) {
    wait(var4.nexttrackframe - var4.frame) / 30;
  }

  var1.currenttrackindex++;
  return isDefined(var1.keys[var1.currenttrackindex]);
}

function cameralerpto(var0, var1, var2) {
  if(isDefined(level.lastactivatedcameraobject)) {
    var3 = getdvarfloat("NMORQOTSK");
    setDvar("NMORQOTSK", 2);
    var4 = level.lastactivatedcameraobject.origin;
    var5 = level.lastactivatedcameraobject.angles;
    level.temp_anchor = spawn("script_model", var4);
    level.temp_anchor setModel("tag_origin");
    level.temp_anchor.angles = var5;

    foreach(var7 in level.players) {
      if(isbot(var7)) {
        continue;
      }

      var7 cameraunlink();
      var7 cameralinkTo(level.temp_anchor, "tag_origin", 1);
    }

    level.temp_anchor moveTo(var0.origin, var2, 0, var2 / 2);
    level.temp_anchor rotateTo(var0.angles, var2, 0, var2 / 2);
    level.lastactivatedcameraobject = level.temp_anchor;
    wait var2;
    setDvar("NMORQOTSK", var3);
  } else {
    level.lastactivatedcameraobject = var1;
  }

  foreach(var7 in level.players) {
    if(isbot(var7)) {
      continue;
    }

    var7 cameraunlink();
    var7 cameralinkTo(var1, "tag_origin", 1);
  }

  level.lastactivatedcameraobject = var1;
}

function resetfovzoom() {
  foreach(var1 in level.players) {
    if(isbot(var1)) {
      continue;
    }

    var1 lerpfovbypreset("default");
  }
}

function dofovzoom(var0, var1) {
  wait var0 / 30;

  foreach(var3 in level.players) {
    if(isbot(var3)) {
      continue;
    }

    var3 lerpfovbypreset(var1);
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

function docapturekill(var0, var1, var2, var3, var4, var5, var6, var7) {
  self notify("taunt_start");
  self endon("broshot_done");
  var8 = var2 - 0.5;

  if(var8 > 0) {
    wait var8;
    playlerptrack(level.camdata[var0], level.camera_bro_shot.char_loc[var0]);
  } else {
    var8 = 0;
  }

  wait var2 - var8;
  playtracks(level.camdata[var0], level.camera_bro_shot.char_loc[var0]);
  var9 = "ui_broshot_anim_" + var0;
  var10 = "ui_broshot_anim_" + var0;
  setomnvar(var10, var1);

  if(isDefined(var3)) {
    thread doslowmo(var3, var5, var4, var6, var7);
  }

  var11 = 300;
  var12 = float(var11) / 30;
  var13 = var12;
  wait var13;
  level.taunts_done = 1;
  self notify("taunt_end");
}

function doslowmo(var0, var1, var2, var3, var4) {
  self endon("broshot_done");

  if(!isDefined(level.never_kill_off_after_stealth)) {
    createheadiconatorigin("end_of_round");
    level.never_kill_off_after_stealth = 1;
  }

  wait var0;
  setslowmotion(1, var1, var3);
  wait var2;
  setslowmotion(var1, 1, var4);
}

function dotaunt(var0, var1) {
  self notify("taunt_start");
  self endon("broshot_done");

  if(isDefined(self.changedarchetypeinfo)) {
    var2 = level.archetypeids[self.changedarchetypeinfo.archetype];
    var3 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", var2, "taunts", var1 - 1);
  } else {
    var3 = self getplayerdata(level.loadoutsgroup, "squadMembers", "taunts", var3 - 1);
  }

  if(isDefined(level.overridebroslot)) {
    var1 = level.overridebroslot - 1;
  }

  if(isDefined(level.overridetaunt)) {
    var3 = tablelookup("mp/cac/taunts.csv", 0, level.overridetaunt, 1);
  }

  var4 = tablelookuprownum("mp/cac/taunts.csv", 1, var3);
  var5 = tablelookup("mp/cac/taunts.csv", 0, var4, 5);

  if(var5 == "") {
    return;
  }

  var6 = tablelookup("mp/cac/taunts.csv", 0, var4, 19);
  var7 = tablelookup("mp/cac/taunts.csv", 0, var4, 20);
  var8 = tablelookup("mp/cac/taunts.csv", 0, var4, 21);
  var9 = tablelookup("mp/cac/taunts.csv", 0, var4, 12) == "Y";
  var10 = tablelookup("mp/cac/taunts.csv", 0, var4, 9);
  var11 = "ui_broshot_anim_" + var1;

  if(isDefined(level.interruptabletaunts[var1]) && level.interruptabletaunts[var1] == var10) {
    self notify("taunt_end");
    return;
  }

  var12 = 1;

  if(!isDefined(level.firsttaunttracker[var11]) && !var12) {
    if(!(var9 && isDefined(level.supergunout[var11]))) {
      level.firsttaunttracker[var11] = 1;
      putgunaway(var11);
    }

    if(!var9) {
      level.supergunout[var11] = undefined;
    }
  }

  if(var9 && !isDefined(level.supergunout[var11])) {
    level.firsttaunttracker[var11] = undefined;
    takesupergunout(var11, var5);
    level.supergunout[var11] = 1;
  }

  var13 = tablelookup("mp/cac/taunts.csv", 0, var4, 17);
  var14 = tablelookup("mp/cac/taunts.csv", 0, var4, 18);

  if(var1 > 0 && var13 != "" && var14 != "") {
    if(var1 == 1) {
      var10 = var13;
    } else if(var1 == 2) {
      var10 = var14;
    }
  }

  scripts\mp\broshot_utilities::processepictaunt(var10, var1, 1);
  var15 = "ui_broshot_anim_" + var1;
  setomnvar(var15, var4);
  var16 = float(var8) / 30;
  var17 = var16;

  if(var6 != "") {
    var17 *= float(var6);
  }

  level.camera_anchor scriptmodelclearanim();
  level.camera_anchor.angles = level.camera_bro_shot.basecam.angles;
  level.camera_anchor.origin = level.camera_bro_shot.basecam.origin;
  level.camera_anchor scriptmodelplayanimdeltamotion("iw8_mp_end_game_execute_stab_cam");
  level.interruptabletaunts[var1] = var10;
  thread interruptblocker(var1, var16);
  wait var17;
  level.taunts_done = 1;
  self notify("taunt_end");
}

function queueanimationafter(var0, var1) {
  self endon("broshot_done");
  wait var1 - 0.1;
  level.camera_anchor scriptmodelclearanim();
  level.camera_anchor.angles = level.camera_bro_shot.basecam.angles;
  level.camera_anchor.origin = level.camera_bro_shot.basecam.origin;
  self scriptmodelplayanimdeltamotion(var0);
}

function interruptblocker(var0, var1) {
  self notify("combo_started_" + var0);
  self endon("combo_started_" + var0);
  wait var1;
  level.interruptabletaunts[var0] = undefined;
}

function getaltgunanimstring() {
  var0 = getdisplayweapon(self);

  if(issubstr(var0, "iw7_nrg") || issubstr(var0, "iw7_udm45") || issubstr(var0, "iw7_ump45_mpr_akimbo")) {
    return "_alt";
  }

  return "";
}

function getgunanimstring() {
  var0 = getdisplayweapon(self);

  if(issubstr(var0, "minilmg_mpl")) {
    return "augfury";
  }

  if(issubstr(var0, "akimbo")) {
    return "akimbo";
  }

  if(issubstr(var0, "mp28")) {
    return "mp28";
  }

  if(issubstr(var0, "chargeshot") || issubstr(var0, "venom")) {
    return "assault_rifle";
  }

  if(issubstr(var0, "knife")) {
    return "knife";
  }

  if(issubstr(var0, "axe")) {
    return "axe";
  }

  var1 = scripts\mp\utility\weapon::getweapongroup(var0);

  switch (var1) {
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
  var0 = getdisplayweapon(self);
  var1 = scripts\mp\utility\weapon::getweapongroup(var0);

  if(issubstr(var0, "minilmg_mpl")) {
    return 11;
  }

  if(issubstr(var0, "mp28")) {
    return 12;
  }

  if(issubstr(var0, "akimbo") && !issubstr(var0, "akimbofmg") && !issubstr(var0, "mod_akimboshotgun")) {
    if(issubstr(var0, "iw7_nrg") || issubstr(var0, "iw7_udm45") || issubstr(var0, "iw7_ump45_mpr_akimbo")) {
      return 13;
    }

    return 8;
  }

  if(issubstr(var0, "chargeshot") || issubstr(var0, "venom")) {
    return 2;
  }

  if(issubstr(var0, "knife")) {
    return 9;
  }

  if(issubstr(var0, "axe")) {
    return 10;
  }

  if(issubstr(var0, "nunchuk") || issubstr(var0, "katana")) {
    return 7;
  }

  switch (var1) {
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

function setguntypeforui(var0) {
  var1 = "ui_broshot_weapon_type_" + var0;

  if(var0 > 2) {
    setomnvar(var1, 7);
    return;
  }

  setomnvar(var1, getgunanimindex());
}

function putgunaway(var0) {
  var1 = getgunanimstring();
  var2 = var1 + "_put_away" + getaltgunanimstring();
  var3 = tablelookuprownum("mp/cac/taunts.csv", 1, var2);
  setomnvar(var0, -1);
  var4 = getgunputawayduration(var1);
  wait var4;
}

function takesupergunout(var0, var1) {
  var2 = getrigtransstringfromref(var1) + "transout_0";
  var3 = tablelookuprownum("mp/cac/taunts.csv", 1, var2);
  setomnvar(var0, var3 + 30000);
  var4 = getrigsupertakeoutdurationfromref(var1);
  wait var4;
}

function getrigtransstringfromref(var0) {
  var1 = "";

  switch (var0) {
    case "archetype_assault":
    default:
      var1 = "war_";
      break;
  }

  return var1;
}

function getgunputawayduration(var0) {
  var1 = 0;

  switch (var0) {
    case "akimbo":
    default:
      var1 = 1.067;
      break;
    case "launcher":
      var1 = 1.567;
      break;
    case "lmg":
      var1 = 1.333;
      break;
    case "pistol":
      var1 = 2.233;
      break;
    case "shotgun":
      var1 = 1.233;
      break;
    case "mp28":
    case "smg":
      var1 = 1.2;
      break;
    case "sniper":
      var1 = 1.367;
      break;
    case "assault_rifle":
      var1 = 1.233;
      break;
    case "melee":
      var1 = 1.233;
      break;
  }

  return var1 - 0.2;
}

function getrigsupertakeoutdurationfromref(var0) {
  var1 = 0;

  switch (var0) {
    case "archetype_assault":
    default:
      var1 = 1.733;
      break;
  }

  return var1 - 0.2;
}

function getrigsuperputawaydurationfromref(var0) {
  var1 = 0;

  switch (var0) {
    case "archetype_assault":
    default:
      var1 = 1.267;
      break;
  }

  return var1 - 0.2;
}

function compare_player_score(var0, var1) {
  return var0.score >= var1.score;
}

function onplayerconnect() {
  self endon("broshot_done");

  for(;;) {
    level waittill("connected", var0);

    if(!isai(var0)) {
      thread startlatejoinpodium(var0);
    }
  }
}

function startlatejoinpodium(var0) {
  var0 endon("disconnect");
  wait 0.25;
  var0 cameralinkTo(level.camera_anchor, "tag_origin", 1);
  var1 = var0 getentitynumber();
  startpodium(var1, self.mvparray);
}

function changetestrig(var0, var1) {
  level.overriderig = var0;
  var2 = var1 - 1;
  var3 = 0;
  var4 = 0;
  var5 = 0;

  switch (var0) {
    case 1:
    default:
      var3 = 4;
      var4 = 18;
      var5 = 6;
      break;
    case 2:
      var3 = 12;
      var4 = 5;
      var5 = 1;
      break;
    case 3:
      var3 = 28;
      var4 = 1;
      var5 = 2;
      break;
    case 4:
      var3 = 57;
      var4 = 28;
      var5 = 3;
      break;
    case 5:
      var3 = 45;
      var4 = 39;
      var5 = 4;
      break;
    case 6:
      var3 = 27;
      var4 = 31;
      var5 = 5;
      break;
  }

  self.mvparray = [];
  var6 = max(var1, level.topplayers.size);

  for(var7 = 0; var7 < var6; var7++) {
    self.mvparray[var7] = spawnStruct();
    self.mvparray[var7].rigindex = var5;
    self.mvparray[var7].bodyindex = var4;
    self.mvparray[var7].headindex = var3;
    self.mvparray[var7].weaponname = getdisplayweapon(level.players[0]);
    self.mvparray[var7].clantag = level.players[0] getclantag();
    self.mvparray[var7].name = level.players[0].name;
    self.mvparray[var7].xuid = level.players[0] getxuid();
    self.mvparray[var7].podiumindex = var1;
    self.mvparray[var7].clientnum = level.players[0] getentitynumber();

    if(!isDefined(level.topplayers[var7])) {
      self.topplayers[var7] = spawnStruct();
      level.topplayers[var7].bro = makebrowinner(var7, level.camera_bro_shot.char_loc[var7]);
    }
  }

  for(var7 = 0; var7 < var6; var7++) {
    setguntypeforui(level.topplayers[var7], var7);
  }

  waitframe();
  startpodium(-1, self.mvparray);
}

function changetesttaunt(var0) {
  level.overridetaunt = var0;
}

function changetestslot(var0) {
  level.overridebroslot = var0;

  if(!isDefined(level.topplayers[var0 - 1])) {
    var1 = 0;

    if(isDefined(level.overriderig)) {
      var1 = level.overriderig;
    }

    changetestrig(var1, var0);
    return;
  }
}