/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\broshot.gsc
***********************************************/

initbroshotfx() {}

forceinitbroshot() {
  level.forcebroshot = 1;
  setomnvar("_encstr_AD4511AD68FE553EC7FBA9BA8B0801FD41C8CF", 1);
  return initbroshot();
}

initbroshot(var_0) {
  if(1)
    return 0;

  level.camera_bro_shot = spawnStruct();
  level.camera_bro_shot.basecam = getEnt("_encstr_88F11236856BCAE485AFB507D7134EDBB91ADBA3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_bro_shot.char_loc[0] = getEnt("_encstr_AF451679A349E35FD7A3455D29F18A8FDFC34A7BE7DB8725", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_bro_shot.char_loc[2] = getEnt("_encstr_99541882B80773E6D821B5AA5F882D8FA0510BCA236BCF9B6173", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_bro_shot.char_loc[1] = getEnt("_encstr_9B5418C634B02758D8D195C9BE36F66CD71339EDDCD07BD1BE89", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_bro_shot.char_loc[3] = getEnt("_encstr_835418C6A10B272C6C4795C9D7D87B8DD731E47BDC86DB8EF5D8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_bro_shot.char_loc[4] = getEnt("_encstr_8B541866B05F93233EABD868F115C7494F2276E8032378416992", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_bro_shot.char_loc[5] = getEnt("_encstr_86541876DCD22591DB638030E7FC68BF99C67688F29AD77BBF5F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if((!isDefined(self) || !isDefined(level.camera_bro_shot.basecam) || !scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_AB580A05672AE35D5FFF50B8") == 0 || !scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_AB580A05672AE35D5FFF50B8")) && !istrue(level.forcebroshot))
    return 0;

  if(level.teambased && !istrue(level.forcebroshot)) {
    if(!isDefined(var_0)) {
      var_1 = getteamscore("_encstr_9A8507BA4040188D08");
      var_2 = getteamscore("_encstr_8E8405EA382B2A");

      if(var_1 == var_2)
        return 0;
    } else if(var_0 == "_encstr_8D19048EA595" || var_0 == "_encstr_8BBA05185F8B99" || var_0 == "_encstr_AF660584E6F107")
      return 0;
  }

  level.camera_bro_shot.myfov = 40;
  level.camera_bro_shot.char_loc[1].origin = level.camera_bro_shot.char_loc[0].origin + anglestoleft(level.camera_bro_shot.char_loc[1].angles) * -40.0 + anglesToForward(level.camera_bro_shot.char_loc[1].angles) * -100.0;
  level.camera_bro_shot.char_loc[2].origin = level.camera_bro_shot.char_loc[0].origin + anglestoleft(level.camera_bro_shot.char_loc[2].angles) * 60.0 + anglesToForward(level.camera_bro_shot.char_loc[2].angles) * -130.0;
  setomnvar("_encstr_8E65172FC8673666B7E3DB28E30F2381AFE19CE569108FACB6", istrue(level.upsidedowntaunts));
  sortwinnersandlosers(var_0);
  level.numwinningplayers = int(min(3, level.topplayers.size));
  level.numlosingplayers = int(min(3, level.toplosingplayers.size));
  filterpairs();

  for(var_3 = 0; var_3 < level.numwinningplayers; var_3++) {
    var_4 = level.camera_bro_shot.char_loc[var_3].origin - (0, 0, 50);
    var_5 = (var_4[0], var_4[1], var_4[2] + 100);
    var_6 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 0);
    var_7 = physics_raycast(var_5, var_4, var_6, undefined, 1, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");
    var_8 = isDefined(var_7) && var_7.size > 0;

    if(var_8) {
      var_9 = var_7[0]["_encstr_BD260953AA97E3F014279D"];
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
  return 1;
}

filterpairs() {
  var_0 = min(level.numwinningplayers, level.numlosingplayers);

  if(var_0 < level.numwinningplayers) {
    level.topplayers = scripts\engine\utility::array_remove_index(level.topplayers, level.topplayers.size - 1, 0);
    level.numwinningplayers = level.topplayers.size;
  }

  if(var_0 < level.numlosingplayers) {
    level.toplosingplayers = scripts\engine\utility::array_remove_index(level.toplosingplayers, level.toplosingplayers.size - 1, 0);
    level.numlosingplayers = level.toplosingplayers.size;
  }
}

timeoutcapturekills(var_0) {
  level endon("_encstr_82371023B5E7100523E98933725BC6E13B36");
  wait(var_0);
  thread runqueuedtaunts();
}

queuecapturekillchoice(var_0, var_1) {
  if(!isDefined(level.broshottauntqueue))
    level.broshottauntqueue = [];

  if(!isDefined(level.broshottauntqueue[var_0])) {
    level.broshottauntqueue[var_0] = var_1;

    if(0 || isDefined(level.debugbroshot)) {
      if(var_0 == 0) {
        if(level.numwinningplayers > 1)
          level.broshottauntqueue[var_0 + 1] = var_1;

        if(level.numwinningplayers > 2)
          level.broshottauntqueue[var_0 + 2] = var_1;
      }
    }
  }

  var_2 = 0;

  foreach(var_4 in level.topplayers) {
    if(!isbot(var_4))
      var_2++;
  }

  if(level.broshottauntqueue.size >= var_2) {
    if(isDefined(level.broshotintrodone))
      thread runqueuedtaunts();
    else
      thread waittorunqueuedtaunts();
  }
}

processcameradata(var_0) {
  level.camdata = [];

  if(!isDefined(level.broshottauntqueue[0]))
    level.broshottauntqueue[0] = 1;

  if(!isDefined(level.broshottauntqueue[1]) && level.numwinningplayers > 1)
    level.broshottauntqueue[1] = randomint(2) + 1;

  if(!isDefined(level.broshottauntqueue[2]) && level.numwinningplayers > 2)
    level.broshottauntqueue[2] = randomint(2) + 1;

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
  }
}

getcamdata(var_0, var_1) {
  if(var_0 == 1) {
    if(level.broshotwinnersgoodguys)
      var_2 = killsequencemarinesdata(var_1);
    else
      var_2 = killsequenceopfordata(var_1);
  } else if(level.broshotwinnersgoodguys)
    var_2 = capturesequencemarinesdata(var_1);
  else
    var_2 = capturesequenceopfordata(var_1);

  return var_2;
}

waitforintrodone() {
  level endon("_encstr_82371023B5E7100523E98933725BC6E13B36");
  level waittill("_encstr_A1820FBA0D021F500D5083E2C719C86D05");
  level.broshotintrodone = 1;
}

waittorunqueuedtaunts() {
  level endon("_encstr_82371023B5E7100523E98933725BC6E13B36");
  level waittill("_encstr_A1820FBA0D021F500D5083E2C719C86D05");
  thread runqueuedtaunts();
}

calccameraduration(var_0) {
  if(isDefined(var_0.cutframe))
    return var_0.cutframe / 30.0;

  var_1 = var_0.keys[var_0.keys.size - 1];
  return var_1.nexttrackframe / 30.0;
}

calcprestarttime(var_0) {
  return var_0.precutstartframe / 30.0;
}

runqueuedtaunts() {
  level notify("_encstr_82371023B5E7100523E98933725BC6E13B36");

  if(!isDefined(level.broshottauntqueue))
    level.broshottauntqueue = [];

  var_0 = 11.0;
  processcameradata(level.broshottauntqueue);
  var_1 = 0;

  if(isDefined(level.broshottauntqueue[2])) {
    var_2 = calccameraduration(level.camdata[2]);
    var_3 = calcprestarttime(level.camdata[1]);
    var_4 = level.broshottauntqueue[2];
    thread docapturekill(2, var_4, var_1);
    var_0 = var_0 + var_2;
    var_1 = var_1 + (var_2 - var_3);
  }

  if(isDefined(level.broshottauntqueue[1])) {
    var_2 = calccameraduration(level.camdata[1]);
    var_3 = calcprestarttime(level.camdata[0]);
    var_4 = level.broshottauntqueue[1];
    thread docapturekill(1, var_4, var_1);
    var_0 = var_0 + var_2;
    var_1 = var_1 + (var_2 - var_3);
  }

  var_4 = 0;

  if(isDefined(level.broshottauntqueue[0]))
    var_4 = level.broshottauntqueue[0];

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
  var_10 = 0.0;

  if(isDefined(level.broshottauntqueue[2])) {
    var_2 = calccameraduration(level.camdata[2]);
    thread watchcameratracks(2, var_4);
    var_10 = var_2;
  }

  if(isDefined(level.broshottauntqueue[1])) {
    var_2 = calccameraduration(level.camdata[1]);
    wait(var_10);
    thread watchcameratracks(1, var_4);
    var_10 = var_2;
  }

  wait(var_10);
  thread watchcameratracks(0, var_4);
}

notifywhentauntstimedout(var_0) {
  wait(var_0);
  level notify("_encstr_865A114B0BE39DD39358848169795B696F08D3");

  if(istrue(level.debugbroshot))
    level.players[0] resetbroshot();
}

trydof(var_0) {
  if(isDefined(var_0.dofnearstart)) {
    foreach(var_2 in level.players) {
      if(isbot(var_2)) {
        continue;
      }
      var_2.usingcustomdof = 1;
      var_2 setdepthoffield(var_0.dofnearstart, var_0.dofnearend, var_0.doffarstart, var_0.doffarend, var_0.dofnearblur, var_0.doffarblur);
    }
  }
}

watchcameratracks(var_0, var_1) {
  self notify("_encstr_82AE0FA009D888A76EC93A01733E97C670");
  self endon("_encstr_82AE0FA009D888A76EC93A01733E97C670");
  var_2 = level.camdata[var_0];
  trydof(var_2);
  var_3 = 1;

  for(var_4 = 1; isDefined(var_2) && istrue(var_4); var_3 = 0)
    var_4 = cameraactivatetrack(var_2, var_3, var_1);
}

sortwinnersandlosers(var_0) {
  if(level.teambased) {
    if(!isDefined(var_0)) {
      var_1 = getteamscore("_encstr_9A8507BA4040188D08");
      var_2 = getteamscore("_encstr_8E8405EA382B2A");
      var_3 = scripts\engine\utility::ter_op(var_1 >= var_2, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");
    } else
      var_3 = var_0;

    level.topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var_3, "_encstr_9775086022BE1B413B8B"), ::compare_player_score);
    var_4 = scripts\mp\utility\teams::getenemyplayers(var_3);
    level.toplosingplayers = scripts\engine\utility::array_sort_with_func(var_4, ::compare_player_score);
  } else {
    level.topplayers = level.placement["_encstr_AF1904A7F929"];
    level.toplosingplayers = level.placement["_encstr_AF1904A7F929"];
  }
}

startbroshot(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

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
  level.camera_anchor = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  level.camera_anchor setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.camera_anchor.angles = var_1.angles;
  createwinnersandlosersarrays(var_0);
  level.numwinningplayers = int(min(3, level.topplayers.size));
  level.numlosingplayers = int(min(3, level.toplosingplayers.size));
  filterpairs();
  level.supergunout = [];
  level.interruptabletaunts = [];
  level.firsttaunttracker = [];

  foreach(var_3 in level.players)
  var_3 hideeffectsforbroshot();

  if(!isDefined(level.broshotwinnersgoodguys))
    level.broshotwinnersgoodguys = level.topplayers[0].team == "_encstr_9A8507BA4040188D08";

  for(var_7 = 0; var_7 < 6; var_7++) {
    var_8 = 1;
    var_9 = undefined;

    if(var_7 <= level.numwinningplayers - 1)
      var_9 = level.topplayers[var_7];
    else if(var_7 <= level.numwinningplayers + level.numlosingplayers - 1) {
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
    var_3 setsoundsubmix("_encstr_974F0BAD38D71339DECDA1ED47");
    var_3 setsolid(0);
    var_3 dontinterpolate();

    if(isbot(var_3)) {
      continue;
    }
    var_3 cameralinkTo(level.camera_anchor, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
    var_3 thread scripts\mp\utility\game::setuipostgamefade(0.0);
    scripts\mp\utility\player::_visionsetnaked("_encstr_B40101", 0);

    if(!istrue(level.forcebroshot))
      var_3 thread fadetoblack(1.5);
  }

  level.broshotfirstcamblends = calcfirstcamerablendpts();

  if(level.broshotwinnersgoodguys)
    thread introsequence_marinewinner();
  else
    thread introsequence_opforwinner();

  if(!isDefined(level.debugbroshot))
    thread timeoutcapturekills(10.0);

  thread tauntinputlisten(level.topplayers);
  level thread onplayerconnect();
  startpodium(-1, self.mvparray);
}

createwinnersandlosersarrays(var_0) {
  if(istrue(level.forcebroshot)) {
    if(level.broshotwinnersgoodguys) {
      var_1 = "_encstr_9A8507BA4040188D08";
      var_2 = "_encstr_8E8405EA382B2A";
    } else {
      var_1 = "_encstr_9A8507BA4040188D08";
      var_2 = "_encstr_8E8405EA382B2A";
    }

    if(scripts\mp\utility\teams::getteamdata(var_1, "_encstr_AB580A05672AE35D5FFF50B8") > 1)
      level.topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B"), ::compare_player_score);
    else {
      level.topplayers = [];
      level.topplayers[0] = self;
    }

    if(scripts\mp\utility\teams::getteamdata(var_2, "_encstr_AB580A05672AE35D5FFF50B8") > 1) {
      level.toplosingplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var_2, "_encstr_9775086022BE1B413B8B"), ::compare_player_score);
      return;
    }

    level.topaxisplayers = [];
    level.toplosingplayers[0] = self;
    return;
  } else
    sortwinnersandlosers(var_0);
}

createmvparrayentry(var_0, var_1, var_2, var_3, var_4) {
  self.mvparray[var_0] = spawnStruct();

  if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163") {
    if(isbot(var_1))
      var_5 = var_1.loadoutarchetype;
    else
      var_5 = var_1 scripts\mp\class::cac_getcharacterarchetype();
  } else
    var_5 = var_1.loadoutarchetype;

  var_6 = tablelookuprownum("_encstr_974E16AD38CB13B0E8D1B1AC25B49D5116C41BB2E2C6CDD9", 1, var_5);

  if(isbot(var_1) || isDefined(var_1.lastarchetypeinfo)) {
    var_7 = var_1 getcustomizationbody();
    var_8 = var_1 getcustomizationhead();
    var_9 = tablelookuprownum("_encstr_861211F8CB764FCB504613CD1EBA3305FE2BFE", 1, var_8);
    var_10 = tablelookuprownum("_encstr_8EB912CDAFC7AAC1C9D23B07E0E0BDD3AD4ED283", 1, var_7);

    if(isDefined(var_1.lastarchetypeinfo))
      var_6 = tablelookuprownum("_encstr_974E16AD38CB13B0E8D1B1AC25B49D5116C41BB2E2C6CDD9", 1, var_1.lastarchetypeinfo.archetype);
  } else {
    var_7 = var_1 getcustomizationbody();
    var_8 = var_1 getcustomizationhead();
    var_9 = tablelookuprownum("_encstr_861211F8CB764FCB504613CD1EBA3305FE2BFE", 1, var_8);
    var_10 = tablelookuprownum("_encstr_8EB912CDAFC7AAC1C9D23B07E0E0BDD3AD4ED283", 1, var_7);
  }

  if(isDefined(var_3) && isDefined(var_4)) {
    var_9 = var_3;
    var_10 = var_4;
  } else {
    var_11 = var_1 scripts\mp\teams::getglcustomization();
    var_9 = tablelookuprownum("_encstr_861211F8CB764FCB504613CD1EBA3305FE2BFE", 1, var_11[1]);
    var_10 = tablelookuprownum("_encstr_8EB912CDAFC7AAC1C9D23B07E0E0BDD3AD4ED283", 1, var_11[0]);
  }

  self.mvparray[var_0].rigindex = var_6;
  self.mvparray[var_0].bodyindex = var_10;
  self.mvparray[var_0].headindex = var_9;

  if(var_2) {
    if(istrue(level.broshotwinnersgoodguys)) {
      switch (var_0) {
        case 0:
        default:
          self.mvparray[var_0].weaponname = "_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1";
          break;
        case 1:
          self.mvparray[var_0].weaponname = "_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1";
          break;
        case 2:
          self.mvparray[var_0].weaponname = "_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B";
          break;
      }
    } else {
      switch (var_0) {
        case 0:
        default:
          self.mvparray[var_0].weaponname = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";
          break;
        case 1:
          self.mvparray[var_0].weaponname = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";
          break;
        case 2:
          self.mvparray[var_0].weaponname = "_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1";
          break;
      }
    }
  } else
    self.mvparray[var_0].weaponname = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";

  self.mvparray[var_0].clantag = var_1 getclantag();
  self.mvparray[var_0].name = var_1.name;
  self.mvparray[var_0].xuid = var_1 getxuid();
  self.mvparray[var_0].podiumindex = var_0;
  self.mvparray[var_0].clientnum = var_1 getentitynumber();
  var_1 setguntypeforui(var_0);
  var_1.bro = makebrowinner(var_0, level.camera_bro_shot.char_loc[var_0]);
}

resetbroshot() {
  level.camera_bro_shot.basecam.origin = level.camera_bro_shot.char_loc[0].origin;
  level.camera_bro_shot.basecam.angles = level.camera_bro_shot.char_loc[0].angles;
  level.broshottauntqueue = undefined;
  level.broshotfirstcamblends = calcfirstcamerablendpts();

  if(level.broshotwinnersgoodguys) {
    setomnvar("_encstr_938B199BE839A29BB7570B1F7120C21D78F397E963307BB36F2D63", 2);
    thread introsequence_marinewinner();
  } else {
    setomnvar("_encstr_938B199BE839A29BB7570B1F7120C21D78F397E963307BB36F2D63", 1);
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
    if(isDefined(var_4.bro))
      var_4.bro delete();

    createmvparrayentry(var_2, var_4, var_3, var_5, var_6);
  }

  waitframe();
  startpodium(-1, self.mvparray);
}

introsequence_marinewinner() {
  var_0 = cameraintrotrackdata_marine();
  trydof(var_0);
  thread playtracks(var_0, level.camera_bro_shot.basecam);
  cameraactivatetrack(var_0);
  var_0 = cameraidletrackdata_marine();
  thread playtracks(var_0, level.camera_bro_shot.basecam);
  level notify("_encstr_A1820FBA0D021F500D5083E2C719C86D05");
  cameraactivatetrack(var_0);
}

introsequence_opforwinner() {
  var_0 = cameraintrotrackdata_opfor();
  trydof(var_0);
  thread playtracks(var_0, level.camera_bro_shot.basecam);
  cameraactivatetrack(var_0);
  var_0 = cameraidletrackdata_opfor();
  thread playtracks(var_0, level.camera_bro_shot.basecam);
  level notify("_encstr_A1820FBA0D021F500D5083E2C719C86D05");
  cameraactivatetrack(var_0);
}

introsequence() {
  var_0 = cameraintrotrackdata();
  thread playtracks(var_0, level.camera_bro_shot.basecam);
  cameraactivatetrack(var_0);
  cameraactivatetrack(var_0);
  var_0 = cameraintroidletrackdata();
  thread playtracks(var_0, level.camera_bro_shot.basecam);
  self notify("_encstr_A1820FBA0D021F500D5083E2C719C86D05");
  cameraactivatetrack(var_0);
}

capturesequencemarinesdata(var_0) {
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

capturesequenceopfordata(var_0) {
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

killsequencemarinesdata(var_0) {
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

killsequenceopfordata(var_0) {
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

killsequence(var_0) {
  var_1 = camerakilltrackdata();
  thread playtracks(var_1, var_0);
  return var_1;
}

capturesequence(var_0) {
  var_1 = cameracapturetrackdata();
  thread playtracks(var_1, var_0);
  return var_1;
}

waitpopfov(var_0, var_1) {
  self endon("_encstr_8AF40D134EEDE6A1B78EAF23F6B9AC");
  wait(var_1 / 30.0);
  popfov(var_0);
}

hideeffectsforbroshot() {
  if(self.sessionteam == "_encstr_AF8C0A1B6A1D6045925B4F7D" || self.sessionteam == "_encstr_933E090A10B17DDFB3E522") {
    return;
  }
  if(!isDefined(self.loadoutarchetype)) {
    return;
  }
  self setscriptablepartstate("_encstr_AC9506CFB2B5A0E0", "_encstr_A66C0DD0FF02F3F035C76808BF4489", 1);
  self setscriptablepartstate("_encstr_911F10C69315D02DAF205811BB7DEA20D369", "_encstr_A66C0DD0FF02F3F035C76808BF4489", 1);
  self setscriptablepartstate("_encstr_8D240885E4B5B7E4AA07", "_encstr_A7A408B9CA5D1D4E2C63", 1);
  self setscriptablepartstate("_encstr_83C90F5932BBDD183E0C8B8D2D2C1897AB", "_encstr_A7A408B9CA5D1D4E2C63", 1);
  self setscriptablepartstate("_encstr_928A0A0133D348C8822D30A9", "_encstr_BA19049F4B2D", 1);
}

spawnfilllight() {
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("_encstr_A7AB0D8C85BE9025D3EB2625E82415"), level.camera_anchor, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

fadetoblack(var_0) {
  wait 27.0;
  scripts\mp\utility\player::_visionsetnaked("_encstr_B40101", 0);

  foreach(var_2 in level.players) {
    if(isbot(var_2)) {
      continue;
    }
    var_2 visionsetfadetoblackforplayer("_encstr_BA07031663", var_0);
  }
}

cleanupequipment() {
  self notify("_encstr_935E0F139CF6D76E1A7B3AEB6E1D85E4D1");
  scripts\mp\weapons::deleteallgrenades();
  var_0 = getweaponarray();

  if(isDefined(var_0)) {
    foreach(var_2 in var_0)
    var_2 delete();
  }
}

cleanupgamemodes() {
  if(isDefined(level.teamflags)) {
    if(isDefined(level.teamflags[game["_encstr_991C0AB9ED5B57161FE89B83"]]) && isDefined(level.teamflags[game["_encstr_991C0AB9ED5B57161FE89B83"]].visuals)) {
      for(var_0 = 0; var_0 < level.teamflags[game["_encstr_991C0AB9ED5B57161FE89B83"]].visuals.size; var_0++)
        level.teamflags[game["_encstr_991C0AB9ED5B57161FE89B83"]].visuals[var_0] hide();
    }

    if(isDefined(level.teamflags[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]) && isDefined(level.teamflags[game["_encstr_B6A70A23CA6659DC91CAE4DC"]].visuals)) {
      for(var_0 = 0; var_0 < level.teamflags[game["_encstr_B6A70A23CA6659DC91CAE4DC"]].visuals.size; var_0++)
        level.teamflags[game["_encstr_B6A70A23CA6659DC91CAE4DC"]].visuals[var_0] hide();
    }
  }

  if((scripts\mp\utility\game::getgametype() == "_encstr_8218041DF5FA" || scripts\mp\utility\game::getgametype() == "_encstr_A54F06D32A2F0498") && isDefined(level.objectives)) {
    foreach(var_2 in level.objectives) {
      if(isDefined(var_2)) {
        var_2.scriptable setscriptablepartstate("_encstr_8F7905C4EDE23F", "_encstr_BA19049F4B2D");
        var_2.scriptable setscriptablepartstate("_encstr_8A0C06B1E08832D3", "_encstr_BA19049F4B2D");
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() == "_encstr_A7290676E4D2378C" && isDefined(level.objectives)) {
    foreach(var_5 in level.objectives) {
      if(isDefined(var_5) && isDefined(var_5.scriptable)) {
        var_5.scriptable setscriptablepartstate("_encstr_8F7905C4EDE23F", "_encstr_BA19049F4B2D");
        var_5.scriptable setscriptablepartstate("_encstr_8A0C06B1E08832D3", "_encstr_BA19049F4B2D");
      }
    }
  }

  if((scripts\mp\utility\game::getgametype() == "_encstr_9B0703CD93" || scripts\mp\utility\game::getgametype() == "_encstr_B60703EACA" | scripts\mp\utility\game::getgametype() == "_encstr_B807035284") && isDefined(level.objectives)) {
    foreach(var_8 in level.objectives) {
      if(isDefined(var_8) && isDefined(var_8.visuals)) {
        for(var_9 = 0; var_9 < var_8.visuals.size; var_9++) {
          if(isDefined(var_8.visuals[var_9]))
            var_8.visuals[var_9] hide();
        }
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() == "_encstr_AA5606FD1AF05085" && isDefined(level.zones)) {
    foreach(var_5 in level.zones) {
      if(isDefined(var_5) && isDefined(var_5.visuals)) {
        for(var_9 = 0; var_9 < var_5.visuals.size; var_9++)
          var_5.visuals[var_9] hide();
      }
    }
  }

  if(istrue(level.dogtagsenabled)) {
    if(isDefined(level.dogtags)) {
      foreach(var_14 in level.dogtags) {
        if(isDefined(var_14) && isDefined(var_14.visuals)) {
          for(var_9 = 0; var_9 < var_14.visuals.size; var_9++)
            var_14.visuals[var_9] hide();
        }
      }
    }
  }

  if(isDefined(level.balls)) {
    foreach(var_17 in level.balls)
    var_17.visuals[0] setscriptablepartstate("_encstr_B2AD12ABC9D193139767C1E6D8C525999852CC87", "_encstr_BECC055CF3811A", 0);
  }

  if((scripts\mp\utility\game::getgametype() == "_encstr_BDD705AD7BD143" || scripts\mp\utility\game::getgametype() == "_encstr_9A7205B39CB919") && isDefined(level.zones)) {
    foreach(var_5 in level.zones) {
      if(isDefined(var_5) && isDefined(var_5.useobj) && isDefined(var_5.useobj.chevrons)) {
        foreach(var_21 in var_5.useobj.chevrons) {
          for(var_9 = 0; var_9 < var_21.numchevrons; var_9++)
            var_21 setscriptablepartstate("_encstr_917509E648C510D3A7781F" + var_9, "_encstr_BA19049F4B2D");
        }
      }
    }
  }
}

tauntinputlisten(var_0) {
  wait 3.0;

  for(var_1 = 0; var_1 < 3; var_1++) {
    if(!isDefined(var_0[var_1]) || isbot(var_0[var_1]) || !scripts\engine\utility::array_contains(level.players, var_0[var_1])) {
      continue;
    }
    var_0[var_1] thread listenfortauntinput(var_1);
  }
}

getdisplayweapon(var_0) {
  var_1 = createheadicon(var_0.lastdroppableweaponobj);

  if(!issubstr(var_1, var_0.pers["_encstr_BE310E88C361A8C3DBA8445586D31770"]) && !issubstr(var_1, var_0.pers["_encstr_85891093AA774080F789052B879FB0971F72"]))
    var_1 = createheadicon(var_0.spawnweaponobj);

  if(issubstr(var_1, "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") || issubstr(var_1, "_encstr_87610AB4EE83FAD6374B3395") || issubstr(var_1, "_encstr_8386085CBC67F9711A30"))
    var_1 = var_0.pers["_encstr_85891093AA774080F789052B879FB0971F72"];

  if(issubstr(var_1, "_encstr_87910A37ABDC8DA1EA1B6D6E") || issubstr(var_1, "_encstr_ABCC07DA161D16E62C"))
    var_1 = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";

  return var_1;
}

camera_move_helper(var_0, var_1, var_2, var_3) {
  self predictstreampos(var_0.origin);
  wait(var_2);
  level.camera_anchor scriptmodelclearanim();
  var_4 = distance(level.camera_anchor.origin, var_0.origin);
  var_5 = var_4 / var_1;

  if(var_5 < level.framedurationseconds)
    var_5 = level.framedurationseconds;

  level.camera_anchor.move_target = var_0;
  level.camera_anchor moveTo(var_0.origin, var_5);
  level.camera_anchor rotateTo(var_0.angles, var_5);

  if(isDefined(var_3)) {
    wait(var_5 - var_3);
    thread scripts\mp\utility\game::setuipostgamefade(var_3);
  }
}

endbroshot() {
  level.broshotrunning = undefined;
  self notify("_encstr_8AF40D134EEDE6A1B78EAF23F6B9AC");

  foreach(var_1 in level.players)
  var_1 clearsoundsubmix("_encstr_974F0BAD38D71339DECDA1ED47");
}

makebrowinner(var_0, var_1) {
  var_2 = spawn("_encstr_8B211183A693105B187E973892C8933B9B5F38", var_1.origin, 0, 0, var_0, "_encstr_A78C12A94168635A569B8E34A11627856C1D959C");
  var_2.angles = var_1.angles;

  if(istrue(level.nukegameover) && var_0 == 0)
    playFX(scripts\engine\utility::getfx("_encstr_8F52106BF6DCE6BE37D84E952B9BEB58E61A"), var_1.origin);

  var_2 motionblurhqenable();
  return var_2;
}

listenfortauntinput(var_0) {
  if(!isai(self)) {
    self notifyonplayercommand("_encstr_B83A108B90E8571AD72D44FD1887F239D008", "_encstr_A9E60828803C73F11780");
    self notifyonplayercommand("_encstr_87CB13432D7031A1A03BF47D5069EB6A5789878BFB", "_encstr_97120D65B983599519EB1D86C9B7EE");
  }

  thread listenforcapturekill(var_0);
  thread waitforintrodone();
  self waittill("_encstr_9B3D0AD1855D37A3EB2BCD46");
}

popfov(var_0) {
  foreach(var_2 in level.players) {
    if(!isai(var_2))
      var_2 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", var_0);
  }
}

listenforcapturekill(var_0) {
  self endon("_encstr_850D0D5937E380189F9A6379838DD0");
  self endon("_encstr_A5A30C1B334B0895C67B8012C383");
  self endon("_encstr_8AF40D134EEDE6A1B78EAF23F6B9AC");
  childthread listenforcapture(var_0);
  childthread listenforkill(var_0);
}

listenforcapture(var_0) {
  self waittill("_encstr_87CB13432D7031A1A03BF47D5069EB6A5789878BFB");
  self setclientomnvar("_encstr_9B6B1A8B6B69293A2F5E73A7B101C980F75A1E43E8391A761F6968C0", 2);
  thread queuecapturekill(var_0, 2);
}

listenforkill(var_0) {
  self waittill("_encstr_B83A108B90E8571AD72D44FD1887F239D008");
  self setclientomnvar("_encstr_9B6B1A8B6B69293A2F5E73A7B101C980F75A1E43E8391A761F6968C0", 1);
  thread queuecapturekill(var_0, 1);
}

listenfortaunt(var_0, var_1) {
  self endon("_encstr_A5A30C1B334B0895C67B8012C383");
  self endon("_encstr_8AF40D134EEDE6A1B78EAF23F6B9AC");

  for(;;) {
    self waittill("_encstr_99010C51824FD9971AE3EB9FF3A1" + var_1);
    thread dotaunt(var_0, var_1);
    waitframe();
  }
}

queuecapturekill(var_0, var_1) {
  self notify("_encstr_850D0D5937E380189F9A6379838DD0");

  if(isDefined(level.overridebroslot))
    var_0 = level.overridebroslot - 1;

  queuecapturekillchoice(var_0, var_1);
}

calcfirstcamerablendpts() {
  var_0 = [];
  var_0[0] = spawnStruct();
  var_0[1] = spawnStruct();
  var_1 = int(min(level.numwinningplayers, 3)) - 1;
  var_2 = [];

  if(level.broshotwinnersgoodguys) {
    switch (var_1) {
      case 0:
        var_2[0] = "_encstr_ACB628E2A36259F530DE9FB2BA1E1759D5FFA775E3D2A3780B0A4E1BB787FE974586B0CF31B7357F5168";
        var_2[1] = "_encstr_929323E88B031F71107F213530386930914B39CAE9085F4901D74EE1C341A8EE5A71F7ABDB";
        break;
      case 1:
        var_2[0] = "_encstr_AB87255AEE07EBD60EF5953719D79DC2DA2BFA9587B21BD5A356AFABB9FAD80BDAD7C2D791E632";
        var_2[1] = "_encstr_8F93235ABBC1AFDA1CAFB2378C7D9D2CDA59F56B959C1B97D7EA9BF56C2C6BF5B0FA8CCD23";
        break;
      case 2:
        var_2[0] = "_encstr_9187254BEE1CAFB6E07DCA3791EBCE85B695AFCAC3591BBAD195AFABE6AF36855BBEB0F5CCC946";
        var_2[1] = "_encstr_B49323104BDA98583277EBC574D1C05F57822E18F25BCEA08135CFAF9B86A8080F992B634A";
        break;
    }
  } else {
    switch (var_1) {
      case 0:
        var_2[0] = "_encstr_9ADB2596EE07AFDA38F556CD23EB76B0B62BEB598795D8BA8E2BEBED0EFA360BD6FA85EB896E1D";
        var_2[1] = "_encstr_926F23335B073FD0080F4010CB0FA9FBFA47A049B7FB0F9AFF37F0A1CF49A04FC2610FCE4B";
        break;
      case 1:
        var_2[0] = "_encstr_8EDB25EFC301B7AB713171C843199C9BB88FEF2B4820D7FBD498B180EF69D043FD58A7913A4D2B";
        var_2[1] = "_encstr_A66F23D3BBE7DFF0282F6030AB6FC9DBDAA74069979B6FBADFD7D0C1AF69406FA2416E602F";
        break;
      case 2:
        var_2[0] = "_encstr_9BDB252DBBE0F5DA07FAACE6C87D3BB0D6ACBE95F0AC6CEAE8CA7D7B83BE6C2CDAFA16D7994E8C";
        var_2[1] = "_encstr_916F23E1674A5927AF76F24A3910578E883B5F7DEBA09EBFC0689B41A157B7C930E74BEA71";
        break;
    }
  }

  thread playfirstcamblendpt(var_1, var_2[0], var_0[0]);
  thread playfirstcamblendpt(var_1, var_2[1], var_0[1]);
  return var_0;
}

playfirstcamblendpt(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.camera_bro_shot.char_loc[var_0].origin);
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3.angles = level.camera_bro_shot.char_loc[var_0].angles;
  var_3 scriptmodelplayanimdeltamotion(var_1);
  wait 0.5;
  var_2.firstblendtargetpos = var_3.origin;
  var_2.firstblendtargetrot = var_3.angles;
}

cameraintrotrackdata_marine() {
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
  var_0.keys[0].stranim = "_encstr_87B322F8C3B8071003977DE0849719C3554AD170AA439568E7C57E709B9780F73E71A850";
  var_0.keys[0].nexttrackframe = 161;
  return var_0;
}

cameraintrotrackdata_opfor() {
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
  var_0.keys[0].stranim = "_encstr_B1591F9B97CFE0382889C9A06FDFB02772277F035BB33E606F9D539E56C9A870EA";
  var_0.keys[0].nexttrackframe = 240;
  return var_0;
}

cameraidletrackdata_marine() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "_encstr_A1961F79B40A775DE101A20AC06717471815C7E145E8C7E9C38809D2C06B41FF13";
  var_0.keys[0].nexttrackframe = 191;
  return var_0;
}

cameraidletrackdata_opfor() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "_encstr_85041C4BBBC1D7DA837DB237467D3B0BAD2BBE4B19B1ACFADE1CEB1BC26B";
  var_0.keys[0].nexttrackframe = 161;
  return var_0;
}

cameraexecutetrackdata_opfor_1st() {
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
  var_0.keys[0].stranim = "_encstr_9ADB2596EE07AFDA38F556CD23EB76B0B62BEB598795D8BA8E2BEBED0EFA360BD6FA85EB896E1D";
  var_0.keys[0].nexttrackframe = 489;
  return var_0;
}

cameraexecutetrackdata_opfor_2nd() {
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
  var_0.keys[0].stranim = "_encstr_8EDB25EFC301B7AB713171C843199C9BB88FEF2B4820D7FBD498B180EF69D043FD58A7913A4D2B";
  var_0.keys[0].nexttrackframe = 236;
  return var_0;
}

cameraexecutetrackdata_opfor_3rd() {
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
  var_0.keys[0].stranim = "_encstr_9BDB252DBBE0F5DA07FAACE6C87D3BB0D6ACBE95F0AC6CEAE8CA7D7B83BE6C2CDAFA16D7994E8C";
  var_0.keys[0].nexttrackframe = 211;
  return var_0;
}

cameraexecutetrackdata_marines_1st() {
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
  var_0.keys[0].stranim = "_encstr_ACB628E2A36259F530DE9FB2BA1E1759D5FFA775E3D2A3780B0A4E1BB787FE974586B0CF31B7357F5168";
  var_0.keys[0].nexttrackframe = 80;
  var_0.keys[1] = spawnStruct();
  var_0.keys[1].frame = 80;
  var_0.keys[1].nexttrackframe = 117;
  var_0.keys[1].fovanimframe = 0;
  var_0.keys[1].fovzoomstyle = "_encstr_8E420DE9EDDA98B4AC16C936162359";
  var_0.keys[2] = spawnStruct();
  var_0.keys[2].frame = 117;
  var_0.keys[2].nexttrackframe = 351;
  var_0.keys[2].fovanimframe = 0;
  var_0.keys[2].fovzoomstyle = "_encstr_8B880E3B782B3B528F416928DF5B3D4D";
  return var_0;
}

cameraexecutetrackdata_marines_1st_alt() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 45;
  var_0.keys[0].stranim = "_encstr_ACB628E2A36259F530DE9FB2BA1E1759D5FFA775E3D2A3780B0A4E1BB787FE974586B0CF31B7357F5168";
  var_0.keys[0].nexttrackframe = 45;
  var_0.keys[0].fovanimframe = 16;
  var_0.keys[0].fovzoomstyle = "_encstr_8E420DE9EDDA98B4AC16C936162359";
  var_0.keys[1] = spawnStruct();
  var_0.keys[1].frame = 45;
  var_0.keys[1].timescaleold = 1.0;
  var_0.keys[1].timescale = 0.333;
  var_0.keys[1].timescaleramptime = 4.0;
  var_0.keys[1].nexttrackframe = 165;
  var_0.keys[2] = spawnStruct();
  var_0.keys[2].frame = 165;
  var_0.keys[2].timescaleold = 0.333;
  var_0.keys[2].timescale = 1.0;
  var_0.keys[2].timescaleramptime = 2.0;
  var_0.keys[2].nexttrackframe = 251;
  return var_0;
}

cameraexecutetrackdata_marines_2nd() {
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
  var_0.keys[0].stranim = "_encstr_AB87255AEE07EBD60EF5953719D79DC2DA2BFA9587B21BD5A356AFABB9FAD80BDAD7C2D791E632";
  var_0.keys[0].nexttrackframe = 140;
  return var_0;
}

cameraexecutetrackdata_marines_3rd() {
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
  var_0.keys[0].stranim = "_encstr_9187254BEE1CAFB6E07DCA3791EBCE85B695AFCAC3591BBAD195AFABE6AF36855BBEB0F5CCC946";
  var_0.keys[0].nexttrackframe = 171;
  return var_0;
}

cameramercytrackdata_marines_1st() {
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
  var_0.keys[0].stranim = "_encstr_929323E88B031F71107F213530386930914B39CAE9085F4901D74EE1C341A8EE5A71F7ABDB";
  var_0.keys[0].nexttrackframe = 300;
  return var_0;
}

cameramercytrackdata_marines_2nd() {
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
  var_0.keys[0].stranim = "_encstr_8F93235ABBC1AFDA1CAFB2378C7D9D2CDA59F56B959C1B97D7EA9BF56C2C6BF5B0FA8CCD23";
  var_0.keys[0].nexttrackframe = 156;
  return var_0;
}

cameramercytrackdata_marines_3rd() {
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
  var_0.keys[0].stranim = "_encstr_B49323104BDA98583277EBC574D1C05F57822E18F25BCEA08135CFAF9B86A8080F992B634A";
  var_0.keys[0].nexttrackframe = 161;
  return var_0;
}

cameramercytrackdata_opfor_1st() {
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
  var_0.keys[0].stranim = "_encstr_926F23335B073FD0080F4010CB0FA9FBFA47A049B7FB0F9AFF37F0A1CF49A04FC2610FCE4B";
  var_0.keys[0].nexttrackframe = 401;
  return var_0;
}

cameramercytrackdata_opfor_2nd() {
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
  var_0.keys[0].stranim = "_encstr_A66F23D3BBE7DFF0282F6030AB6FC9DBDAA74069979B6FBADFD7D0C1AF69406FA2416E602F";
  var_0.keys[0].nexttrackframe = 166;
  return var_0;
}

cameramercytrackdata_opfor_3rd() {
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
  var_0.keys[0].stranim = "_encstr_916F23E1674A5927AF76F24A3910578E883B5F7DEBA09EBFC0689B41A157B7C930E74BEA71";
  var_0.keys[0].nexttrackframe = 131;
  return var_0;
}

cameraintrotrackdata() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 34.3;
  var_0.keys[0].stranim = "_encstr_99491CBA9059F19713B87566CD1E77860BE84132E069F2E7AE9E796D48E5";
  var_0.keys[0].nexttrackframe = 116;
  var_0.keys[1] = spawnStruct();
  var_0.keys[1].frame = 116;
  var_0.keys[1].fovkey = 46.8;
  var_0.keys[1].stranim = "_encstr_9B491C674FFA6035C051275DC527A721EB3B71788D9BCAC5B99E828389B8";
  var_0.keys[1].nexttrackframe = 160;
  return var_0;
}

cameraintroidletrackdata() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 46.8;
  var_0.keys[0].stranim = "_encstr_A3C719CAB3431F3DE8CF1DEE4169472F0169217279318FF9589B1D";
  return var_0;
}

camerakilltrackdata() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].fovkey = 34.3;
  var_0.keys[0].nexttrackframe = 396;
  var_0.keys[0].stranim = "_encstr_A5A3215C1F189019235708E2A23147A7155F1FC0610918757C6A277FC1A0634993E6CD";
  return var_0;
}

cameracapturetrackdata() {
  var_0 = spawnStruct();
  var_0.keys = [];
  var_0.keys[0] = spawnStruct();
  var_0.keys[0].frame = 0;
  var_0.keys[0].nexttrackframe = 34;
  var_0.keys[0].fovkey = 34.3;
  var_0.keys[0].stranim = "_encstr_A351229BF3AF97885067387893A70123029F1811CFA3B77217F3B07067B85E5F6A0590BF";
  var_0.keys[1] = spawnStruct();
  var_0.keys[1].frame = 34;
  var_0.keys[1].fovkey = 46.8;
  var_0.keys[1].nexttrackframe = 253;
  var_0.keys[1].stranim = "_encstr_8F51224B7770BEDA07D7ACB923D7EC58DA59EBADB2936CBCAFE0D573B143FAD82CADEB12";
  return var_0;
}

playlerptrack(var_0, var_1) {
  var_2 = var_0.keys[0];
  var_2.lerp_camera_anchor = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_2.lerp_camera_anchor setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.lerp_camera_anchor.origin = var_1.origin;
  var_2.lerp_camera_anchor.angles = var_1.angles;
  var_2.lerp_camera_anchor scriptmodelplayanimdeltamotion(var_2.stranim);
}

playtracks(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.keys.size; var_2++) {
    var_3 = var_0.keys[var_2];
    var_4 = undefined;

    if(var_2 > 0)
      var_4 = var_0.keys[var_2 - 1];

    if(isDefined(var_3.stranim)) {
      var_3.camera_anchor = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
      var_3.camera_anchor setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      var_3.camera_anchor.origin = var_1.origin;
      var_3.camera_anchor.angles = var_1.angles;
      var_3.camera_anchor scriptmodelplayanimdeltamotion(var_3.stranim);
    } else
      var_3.camera_anchor = var_4.camera_anchor;

    if(isDefined(var_3.fovkey)) {
      var_3.fov = var_3.fovkey;
      continue;
    }

    var_3.fov = var_4.fov;
  }

  var_0.currenttrackindex = 0;
}

cameraactivatetrack(var_0, var_1, var_2) {
  self endon("_encstr_82AE0FA009D888A76EC93A01733E97C670");
  self endon("_encstr_8AF40D134EEDE6A1B78EAF23F6B9AC");
  self notify("_encstr_83320FD572FA2F88A15770801BD9236BD2");
  self endon("_encstr_83320FD572FA2F88A15770801BD9236BD2");
  var_3 = var_0.keys[var_0.currenttrackindex];
  popfov(var_3.fov);

  if(istrue(var_1)) {
    if(isDefined(var_3.lerp_camera_anchor))
      childthread cameralerpto(var_3.lerp_camera_anchor, var_3.camera_anchor, 0.5);
    else {
      var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.broshotfirstcamblends[var_2 - 1].firstblendtargetpos);
      var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      var_4.angles = level.broshotfirstcamblends[var_2 - 1].firstblendtargetrot;
      childthread cameralerpto(var_4, var_3.camera_anchor, 0.5);
    }
  } else {
    foreach(var_6 in level.players) {
      if(isbot(var_6)) {
        continue;
      }
      var_6 cameraunlink();
      var_6 cameralinkTo(var_3.camera_anchor, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
    }

    level.lastactivatedcameraobject = var_3.camera_anchor;
  }

  if(isDefined(var_3.fovanimframe) && isDefined(var_3.fovzoomstyle))
    childthread dofovzoom(var_3.fovanimframe, var_3.fovzoomstyle);

  if(isDefined(var_3.timescale)) {}

  if(isDefined(var_3.nexttrackframe))
    wait((var_3.nexttrackframe - var_3.frame) / 30.0);

  var_0.currenttrackindex++;
  return isDefined(var_0.keys[var_0.currenttrackindex]);
}

cameralerpto(var_0, var_1, var_2) {
  if(isDefined(level.lastactivatedcameraobject)) {
    var_3 = getdvarfloat("_encstr_8EED0A5D8D6D291F8FE9CFF4");
    setDvar("_encstr_8EED0A5D8D6D291F8FE9CFF4", 2.0);
    var_4 = level.lastactivatedcameraobject.origin;
    var_5 = level.lastactivatedcameraobject.angles;
    level.temp_anchor = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
    level.temp_anchor setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    level.temp_anchor.angles = var_5;

    foreach(var_7 in level.players) {
      if(isbot(var_7)) {
        continue;
      }
      var_7 cameraunlink();
      var_7 cameralinkTo(level.temp_anchor, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
    }

    level.temp_anchor moveTo(var_0.origin, var_2, 0, var_2 / 2.0);
    level.temp_anchor rotateTo(var_0.angles, var_2, 0, var_2 / 2.0);
    level.lastactivatedcameraobject = level.temp_anchor;
    wait(var_2);
    setDvar("_encstr_8EED0A5D8D6D291F8FE9CFF4", var_3);
  } else
    level.lastactivatedcameraobject = var_1;

  foreach(var_7 in level.players) {
    if(isbot(var_7)) {
      continue;
    }
    var_7 cameraunlink();
    var_7 cameralinkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  }

  level.lastactivatedcameraobject = var_1;
}

resetfovzoom() {
  foreach(var_1 in level.players) {
    if(isbot(var_1)) {
      continue;
    }
    var_1 lerpfovbypreset("_encstr_8B1608EC43B8D647A113");
  }
}

dofovzoom(var_0, var_1) {
  wait(var_0 / 30.0);

  foreach(var_3 in level.players) {
    if(isbot(var_3)) {
      continue;
    }
    var_3 lerpfovbypreset(var_1);
  }
}

cameratrackintrocam() {
  self endon("_encstr_8AF40D134EEDE6A1B78EAF23F6B9AC");
  popfov(34.3);
  level.camera_anchor scriptmodelplayanimdeltamotion("_encstr_99491CBA9059F19713B87566CD1E77860BE84132E069F2E7AE9E796D48E5");
  wait 3.86667;
  popfov(46.8);
  level.camera_anchor scriptmodelplayanimdeltamotion("_encstr_9B491C674FFA6035C051275DC527A721EB3B71788D9BCAC5B99E828389B8");
}

cameratrackkillcam() {
  popfov(34.3);
  level.camera_anchor scriptmodelplayanimdeltamotion("_encstr_A5A3215C1F189019235708E2A23147A7155F1FC0610918757C6A277FC1A0634993E6CD");
}

cameratrackcapturecam() {
  self endon("_encstr_8AF40D134EEDE6A1B78EAF23F6B9AC");
  popfov(34.3);
  level.camera_anchor scriptmodelplayanimdeltamotion("_encstr_B6C32014F421A1355399FFCB586EF78A7305118D551D3A59DEC8B7C388A097D2C3A9");
  wait 1.13333;
  popfov(46.8);
}

docapturekill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("_encstr_A5A30C1B334B0895C67B8012C383");
  self endon("_encstr_8AF40D134EEDE6A1B78EAF23F6B9AC");
  var_8 = var_2 - 0.5;

  if(var_8 > 0) {
    wait(var_8);
    playlerptrack(level.camdata[var_0], level.camera_bro_shot.char_loc[var_0]);
  } else
    var_8 = 0;

  wait(var_2 - var_8);
  playtracks(level.camdata[var_0], level.camera_bro_shot.char_loc[var_0]);
  var_9 = "_encstr_A5E0119D7CD1E55377DF48782BAFC9055AE5AF" + var_0;
  var_10 = "_encstr_A5E0119D7CD1E55377DF48782BAFC9055AE5AF" + var_0;
  setomnvar(var_10, var_1);

  if(isDefined(var_3))
    thread doslowmo(var_3, var_5, var_4, var_6, var_7);

  var_11 = 300;
  var_12 = float(var_11) / 30.0;
  var_13 = var_12;
  wait(var_13);
  level.taunts_done = 1;
  self notify("_encstr_9B3D0AD1855D37A3EB2BCD46");
}

doslowmo(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_8AF40D134EEDE6A1B78EAF23F6B9AC");

  if(!isDefined(level.never_kill_off_after_stealth)) {
    createheadiconatorigin("_encstr_88450D5BFE9771301B893B8033E37D");
    level.never_kill_off_after_stealth = 1;
  }

  wait(var_0);
  setslowmotion(1.0, var_1, var_3);
  wait(var_2);
  setslowmotion(var_1, 1.0, var_4);
}

dotaunt(var_0, var_1) {
  self notify("_encstr_A5A30C1B334B0895C67B8012C383");
  self endon("_encstr_8AF40D134EEDE6A1B78EAF23F6B9AC");

  if(isDefined(self.changedarchetypeinfo)) {
    var_2 = level.archetypeids[self.changedarchetypeinfo.archetype];
    var_3 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_84B415C293C6D0B2D15EC1CAA039AC33B2C995E6C6B2CD", var_2, "_encstr_A359073D69DFC0F9CA", var_1 - 1);
  } else
    var_3 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_A359073D69DFC0F9CA", var_1 - 1);

  if(isDefined(level.overridebroslot))
    var_0 = level.overridebroslot - 1;

  if(isDefined(level.overridetaunt))
    var_3 = tablelookup("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 0, level.overridetaunt, 1);

  var_4 = tablelookuprownum("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 1, var_3);
  var_5 = tablelookup("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 0, var_4, 5);

  if(var_5 == "_encstr_B40101") {
    return;
  }
  var_6 = tablelookup("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 0, var_4, 19);
  var_7 = tablelookup("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 0, var_4, 20);
  var_8 = tablelookup("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 0, var_4, 21);
  var_9 = tablelookup("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 0, var_4, 12) == "_encstr_AA4C0259";
  var_10 = tablelookup("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 0, var_4, 9);
  var_11 = "_encstr_A5E0119D7CD1E55377DF48782BAFC9055AE5AF" + var_0;

  if(isDefined(level.interruptabletaunts[var_0]) && level.interruptabletaunts[var_0] == var_10) {
    self notify("_encstr_9B3D0AD1855D37A3EB2BCD46");
    return;
  }

  var_12 = 1;

  if(!isDefined(level.firsttaunttracker[var_11]) && !var_12) {
    if(!(var_9 && isDefined(level.supergunout[var_11]))) {
      level.firsttaunttracker[var_11] = 1;
      putgunaway(var_11);
    }

    if(!var_9)
      level.supergunout[var_11] = undefined;
  }

  if(var_9 && !isDefined(level.supergunout[var_11])) {
    level.firsttaunttracker[var_11] = undefined;
    takesupergunout(var_11, var_5);
    level.supergunout[var_11] = 1;
  }

  var_13 = tablelookup("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 0, var_4, 17);
  var_14 = tablelookup("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 0, var_4, 18);

  if(var_0 > 0 && var_13 != "_encstr_B40101" && var_14 != "_encstr_B40101") {
    if(var_0 == 1)
      var_10 = var_13;
    else if(var_0 == 2)
      var_10 = var_14;
  }

  scripts\mp\broshot_utilities::processepictaunt(var_10, var_0, 1);
  var_15 = "_encstr_A5E0119D7CD1E55377DF48782BAFC9055AE5AF" + var_0;
  setomnvar(var_15, var_4);
  var_16 = float(var_8) / 30.0;
  var_17 = var_16;

  if(var_6 != "_encstr_B40101")
    var_17 = var_17 * float(var_6);

  level.camera_anchor scriptmodelclearanim();
  level.camera_anchor.angles = level.camera_bro_shot.basecam.angles;
  level.camera_anchor.origin = level.camera_bro_shot.basecam.origin;
  level.camera_anchor scriptmodelplayanimdeltamotion("_encstr_A5A3215C1F189019235708E2A23147A7155F1FC0610918757C6A277FC1A0634993E6CD");
  level.interruptabletaunts[var_0] = var_10;
  thread interruptblocker(var_0, var_16);
  wait(var_17);
  level.taunts_done = 1;
  self notify("_encstr_9B3D0AD1855D37A3EB2BCD46");
}

queueanimationafter(var_0, var_1) {
  self endon("_encstr_8AF40D134EEDE6A1B78EAF23F6B9AC");
  wait(var_1 - 0.1);
  level.camera_anchor scriptmodelclearanim();
  level.camera_anchor.angles = level.camera_bro_shot.basecam.angles;
  level.camera_anchor.origin = level.camera_bro_shot.basecam.origin;
  self scriptmodelplayanimdeltamotion(var_0);
}

interruptblocker(var_0, var_1) {
  self notify("_encstr_B6850F6CBD6B89ED7DE6D10B27E82B8CF5" + var_0);
  self endon("_encstr_B6850F6CBD6B89ED7DE6D10B27E82B8CF5" + var_0);
  wait(var_1);
  level.interruptabletaunts[var_0] = undefined;
}

getaltgunanimstring() {
  var_0 = getdisplayweapon(self);

  if(issubstr(var_0, "_encstr_998608A5DD737D734ED9") || issubstr(var_0, "_encstr_AA320AD75F8B3768C0DAC1C3") || issubstr(var_0, "_encstr_99511544F3A24743B9E9D22E4F51DBA239997CCC28600F"))
    return "_encstr_874305A1720B08";

  return "_encstr_B40101";
}

getgunanimstring() {
  var_0 = getdisplayweapon(self);

  if(issubstr(var_0, "_encstr_AD470CB568D84331CFEFC79ACB91"))
    return "_encstr_A5960811632770FD6BB7";

  if(issubstr(var_0, "_encstr_AD9C07E0478148252A"))
    return "_encstr_AD9C07E0478148252A";

  if(issubstr(var_0, "_encstr_A9A205B960DA12"))
    return "_encstr_A9A205B960DA12";

  if(issubstr(var_0, "_encstr_83DE0BC6D02CC976ACE60DF63A") || issubstr(var_0, "_encstr_8AB60633E836170B"))
    return "_encstr_ADCF0E09F0F87380E9834EFB073BF2B7";

  if(issubstr(var_0, "_encstr_A59306426009CA07"))
    return "_encstr_A59306426009CA07";

  if(issubstr(var_0, "_encstr_961904BF105A"))
    return "_encstr_961904BF105A";

  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  switch (var_1) {
    case "_encstr_8ACC0DEC0F42B1A0263F50189B45B9":
      return "_encstr_A6C7065BACB1CA95";
    case "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36":
      return "_encstr_8D940738966ED1DB8D";
    case "_encstr_82EF0C97EDA73962101FCEFF0171":
    case "_encstr_AF710BF4355A9195B0FF0AEAD0":
      return "_encstr_BE1904DCDA9D";
    case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
    case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
      return "_encstr_ADCF0E09F0F87380E9834EFB073BF2B7";
    case "_encstr_A3710BEEACC2E0B737EB36B676":
      return "_encstr_9A190463ADB3";
    case "_encstr_88670C4077366F270E071EC9720C":
    case "_encstr_A1710B57AD31DBCDCDF1422A60":
    case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
      return "_encstr_850707F7E5833355B8";
    case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
      return "_encstr_A65B084B38A76BEFC350";
    case "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195":
      return "_encstr_A1470989E6EB65D9D83F30";
    default:
      return "_encstr_AD9C07E0478148252A";
  }
}

getgunanimindex() {
  var_0 = getdisplayweapon(self);
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(issubstr(var_0, "_encstr_AD470CB568D84331CFEFC79ACB91"))
    return 11;

  if(issubstr(var_0, "_encstr_A9A205B960DA12"))
    return 12;

  if(issubstr(var_0, "_encstr_AD9C07E0478148252A") && !issubstr(var_0, "_encstr_8DFC0A6FB0C09DD227CC5DD7") && !issubstr(var_0, "_encstr_A5ED12384DFC612F120F6B7D7FFBE3988427A3D0")) {
    if(issubstr(var_0, "_encstr_998608A5DD737D734ED9") || issubstr(var_0, "_encstr_AA320AD75F8B3768C0DAC1C3") || issubstr(var_0, "_encstr_99511544F3A24743B9E9D22E4F51DBA239997CCC28600F"))
      return 13;

    return 8;
  }

  if(issubstr(var_0, "_encstr_83DE0BC6D02CC976ACE60DF63A") || issubstr(var_0, "_encstr_8AB60633E836170B"))
    return 2;

  if(issubstr(var_0, "_encstr_A59306426009CA07"))
    return 9;

  if(issubstr(var_0, "_encstr_961904BF105A"))
    return 10;

  if(issubstr(var_0, "_encstr_88E108ADBD50B72B483B") || issubstr(var_0, "_encstr_ABCC07DA161D16E62C"))
    return 7;

  switch (var_1) {
    case "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36":
      return 0;
    case "_encstr_82EF0C97EDA73962101FCEFF0171":
    case "_encstr_AF710BF4355A9195B0FF0AEAD0":
      return 1;
    case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
    case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
      return 2;
    case "_encstr_A3710BEEACC2E0B737EB36B676":
      return 3;
    case "_encstr_88670C4077366F270E071EC9720C":
    case "_encstr_A1710B57AD31DBCDCDF1422A60":
    case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
      return 4;
    case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
      return 5;
    case "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195":
      return 6;
    case "_encstr_8ACC0DEC0F42B1A0263F50189B45B9":
    default:
      return 7;
  }
}

setguntypeforui(var_0) {
  var_1 = "_encstr_885B18EAB4AF98E4DEDC34DEE87DEE2B580EDBCDD73A970EACBE" + var_0;

  if(var_0 > 2)
    setomnvar(var_1, 7);
  else
    setomnvar(var_1, getgunanimindex());
}

putgunaway(var_0) {
  var_1 = getgunanimstring();
  var_2 = var_1 + "_encstr_B26C0A518B28F489C79FEF87" + getaltgunanimstring();
  var_3 = tablelookuprownum("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 1, var_2);
  setomnvar(var_0, -1);
  var_4 = getgunputawayduration(var_1);
  wait(var_4);
}

takesupergunout(var_0, var_1) {
  var_2 = getrigtransstringfromref(var_1) + "_encstr_AF980B150A2A160F6F9B53D9A1";
  var_3 = tablelookuprownum("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 1, var_2);
  setomnvar(var_0, var_3 + 30000);
  var_4 = getrigsupertakeoutdurationfromref(var_1);
  wait(var_4);
}

getrigtransstringfromref(var_0) {
  var_1 = "_encstr_B40101";

  switch (var_0) {
    case "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D":
    default:
      var_1 = "_encstr_A6F605D3E90561";
      break;
  }

  return var_1;
}

getgunputawayduration(var_0) {
  var_1 = 0.0;

  switch (var_0) {
    case "_encstr_AD9C07E0478148252A":
    default:
      var_1 = 1.067;
      break;
    case "_encstr_A1470989E6EB65D9D83F30":
      var_1 = 1.567;
      break;
    case "_encstr_9A190463ADB3":
      var_1 = 1.333;
      break;
    case "_encstr_8D940738966ED1DB8D":
      var_1 = 2.233;
      break;
    case "_encstr_A65B084B38A76BEFC350":
      var_1 = 1.233;
      break;
    case "_encstr_A9A205B960DA12":
    case "_encstr_BE1904DCDA9D":
      var_1 = 1.2;
      break;
    case "_encstr_850707F7E5833355B8":
      var_1 = 1.367;
      break;
    case "_encstr_ADCF0E09F0F87380E9834EFB073BF2B7":
      var_1 = 1.233;
      break;
    case "_encstr_A6C7065BACB1CA95":
      var_1 = 1.233;
      break;
  }

  return var_1 - 0.2;
}

getrigsupertakeoutdurationfromref(var_0) {
  var_1 = 0.0;

  switch (var_0) {
    case "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D":
    default:
      var_1 = 1.733;
      break;
  }

  return var_1 - 0.2;
}

getrigsuperputawaydurationfromref(var_0) {
  var_1 = 0.0;

  switch (var_0) {
    case "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D":
    default:
      var_1 = 1.267;
      break;
  }

  return var_1 - 0.2;
}

compare_player_score(var_0, var_1) {
  return var_0.score >= var_1.score;
}

onplayerconnect() {
  self endon("_encstr_8AF40D134EEDE6A1B78EAF23F6B9AC");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!isai(var_0))
      thread startlatejoinpodium(var_0);
  }
}

startlatejoinpodium(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.25;
  var_0 cameralinkTo(level.camera_anchor, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  var_1 = var_0 getentitynumber();
  startpodium(var_1, self.mvparray);
}

changetestrig(var_0, var_1) {
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

  for(var_7 = 0; var_7 < var_6; var_7++)
    level.topplayers[var_7] setguntypeforui(var_7);

  waitframe();
  startpodium(-1, self.mvparray);
}

changetesttaunt(var_0) {
  level.overridetaunt = var_0;
}

changetestslot(var_0) {
  level.overridebroslot = var_0;

  if(!isDefined(level.topplayers[var_0 - 1])) {
    var_1 = 0;

    if(isDefined(level.overriderig))
      var_1 = level.overriderig;

    changetestrig(var_1, var_0);
  }
}