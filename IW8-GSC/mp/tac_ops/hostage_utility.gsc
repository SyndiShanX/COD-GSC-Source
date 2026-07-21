/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\tac_ops\hostage_utility.gsc
***********************************************/

hostagesysteminit() {
  level.activehostagecount = 0;
  level.hostages = [];
  level.inactiveextractions = [];
  level.activeextractions = [];
  level.activeextractors = [];
  level.hostagehidespots = scripts\engine\utility::getStructArray("_encstr_81AD0860B06BD3A637D8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.hostageexitpoints = scripts\engine\utility::getStructArray("_encstr_B20F0D71D03303660720919D9B7325", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.hostageexitpoints)
  level.objective[level.objective.size] = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1.origin, 0, 90, 128);

  level.randhidespots = scripts\engine\utility::array_randomize(level.hostagehidespots);
  level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"] = loadfx("_encstr_A11629ECCC3C5EEB39958BD52BB9A3DCBCAD83BE9D0BD6561C63B0E579673387D7DCB5B5AFDC2D3B372C1B");
  thread hostagestatuswatcher();
}

numextractpointsavailable() {
  return level.inactiveextractions.size;
}

heloextracttryuse(var_0) {
  var_1 = scripts\mp\killstreaks\target_marker::gettargetmarker(var_0);

  if(!isDefined(var_1.location))
    return 0;

  if(numextractpointsavailable() == 0) {
    iprintlnbold("_encstr_96A31BD00CCFBBBF615F2049898977371D665E98B49FF3A4E1A1AF519B");

    if(isDefined(var_1.visual))
      var_1.visual delete();

    return 0;
  }

  _encstr_BE7D21F241B8412325FFAEBFE1609A81B869ABF89BA803AE7DEF67A30FF5C2B64033E6::trycreateextractpoint(var_1.location, var_1);
  var_2 = _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::gettacopstimeremainingms();

  if(var_2 < _encstr_BE7D21F241B8412325FFAEBFE1609A81B869ABF89BA803AE7DEF67A30FF5C2B64033E6::getextractiontimeconst() * 1000)
    startlastextraction();

  return 1;
}

spawnhostage(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(scripts\mp\utility\game::getgametype() == "_encstr_951904D8F1E0") {
    var_1 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_3 = "_encstr_9BB12213BDC897EBB70733BDC9362B7D1BEDE6237B73FAE8599393F6932DB9E8F589D746";
    var_4 = "_encstr_B1BB1014B72AFA0761C250022FAEB0C8AA0B";
  } else {
    var_1 = "_encstr_A7A408B9CA5D1D4E2C63";
    var_3 = "_encstr_96F32AA6F70BB21FFDAB49BB921231493B6EA02C598BF9812782C039ABAFF7A33709BE08F9972B8F4D8A8042";
    var_4 = "_encstr_A35F25E38B8F7A675823F1C3B99074A2DE05B7237BAED204706975C113C8BBEB20B39B4F7340DF";
  }

  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_6 setModel(var_3);
  var_7 setModel(var_4);
  var_7 linkTo(var_6, "_encstr_BDAB07BA596A43E9EB", (-9, 1, 0), (0, 0, 0));
  var_6 linkTo(var_5, "_encstr_B40101", (0, 0, -48), (0, 0, 0));
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_8.team = var_1;
  var_8.destination = var_0;
  var_5.trigger = var_8;
  var_8 linkTo(var_5);
  var_5.trigger makeusable();
  var_5.body = var_6;
  var_5.head = var_7;
  var_5 = drophostage(undefined, var_5, var_0, 1);
  var_5.teamscored["_encstr_9A8507BA4040188D08"] = 0;
  var_5.teamscored["_encstr_8E8405EA382B2A"] = 0;
  var_5.wasindent = 0;
  var_5.requireslos = 1;
  var_5.setdropped = ::drophostage;
  var_5.team = var_1;
  var_5.usehostagedrop = 1;
  var_5.ownerteam = var_1;
  var_5.interactteam = scripts\engine\utility::ter_op(var_1 == "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_9A19040BCDBC", "_encstr_ACFC091AE8AB2FCBE15119");
  var_5.exclusiveuse = 0;
  var_5.curprogress = 0;
  var_5.usetime = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "_encstr_9719046E3182", 500, 0);
  var_5.userate = 1;
  var_5.id = "_encstr_BAE50DE60E739BA638C72068AF47B9";
  var_5.skiptouching = 1;
  var_5.onuse = ::hostageonuse;
  var_5 thread scripts\mp\gameobjects::useobjectusethink();
  var_9 = "_encstr_95E9252DD8DEB9F56B5ACDB4D6B083AF8E2CB17DDBC1B9EBD07B37A3B03B2BBE57376DCDF6DD9B";
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_10 linkTo(var_5);
  var_5.attachobj = var_10;

  if(var_1 == "_encstr_A7A408B9CA5D1D4E2C63") {
    var_11 = "_encstr_9A19040BCDBC";
    var_12 = "_encstr_9A19040BCDBC";
  } else {
    var_11 = "_encstr_ACFC091AE8AB2FCBE15119";
    var_12 = "_encstr_ACFC091AE8AB2FCBE15119";
  }

  if(scripts\mp\utility\game::getgametype() != "_encstr_9719046E3182" && var_2) {
    var_5.trackedobject = var_5 scripts\mp\gameobjects::createtrackedobject(var_10, (0, 0, 0));
    var_5.trackedobject.objidpingfriendly = 0;
    var_5.trackedobject.objidpingenemy = 1;
    var_5.trackedobject.objpingdelay = 2.0;
    var_5.trackedobject scripts\mp\gameobjects::allowcarry(var_11);
    var_5.trackedobject scripts\mp\gameobjects::setownerteam(var_5.ownerteam);
    var_5.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconrecover, level.iconrecover);
    var_5.trackedobject.cancontestclaim = 1;
    var_5.trackedobject.stalemate = 0;
    var_5.trackedobject.wasstalemate = 1;
    var_5.trackedobject scripts\mp\gameobjects::setvisibleteam(var_12);
  }

  if(isDefined(var_5.trackedobject)) {
    var_5.trackedobject scripts\mp\gameobjects::allowcarry(var_1);
    var_5.trackedobject scripts\mp\gameobjects::setownerteam(var_1);
    var_5.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconrecover, level.iconrecover);

    if(scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5" || scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B") {
      var_5.trackedobject.cancontestclaim = 1;
      var_5.trackedobject.stalemate = 0;
      var_5.trackedobject.wasstalemate = 1;
    }

    var_5.trackedobject scripts\mp\gameobjects::setvisibleteam(var_12);
  }

  return var_5;
}

spawnallhostages(var_0) {
  for(var_1 = 0; var_1 < level.hostagehidespots.size; var_1++)
    level.hostages[var_1] = spawnhostage(level.hostagehidespots[var_1].origin, var_0);
}

spawnrandomhostages(var_0, var_1) {
  var_2 = int(min(5 - level.activehostagecount, min(level.randhidespots.size - level.spawnedhostagecount, var_0)));

  if(var_2 == 0) {
    return;
  }
  for(var_3 = 0; var_3 < var_2; var_3++)
    level.hostages[level.spawnedhostagecount + var_3] = spawnhostage(level.randhidespots[level.spawnedhostagecount + var_3].origin, var_1);

  level.spawnedhostagecount = level.spawnedhostagecount + var_2;
  level.activehostagecount = level.activehostagecount + var_2;
}

spawnwmhostagecarry() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0 setModel("_encstr_9BB12213BDC897EBB70733BDC9362B7D1BEDE6237B73FAE8599393F6932DB9E8F589D746");
  var_1 setModel("_encstr_B1BB1014B72AFA0761C250022FAEB0C8AA0B");
  var_1 linkTo(var_0, "_encstr_BDAB07BA596A43E9EB", (-9, 1, 0), (0, 0, 0));

  if(0) {
    var_0 scriptmodelplayanimdeltamotion("_encstr_816D1E149D48758B621F3248BE573B1B6671FEEDA00FD2F179D36107A36F60E8");
    var_0 linkTo(self, "_encstr_8BB30ED4AFDC43DEEAB191ACE47DB156");
  } else {
    var_0 scriptmodelplayanimdeltamotion("_encstr_8B191BEB20A63773856DB1B6C36D79EA09B84F0362B3578AF971077A95");
    var_0 linkTo(self, "_encstr_8BB30ED4AFDC43DEEAB191ACE47DB156", (-12, -8, -8), (0, 0, 30));
    var_1 hidefromplayer(self);
    var_0 hidefromplayer(self);
  }

  var_0.head = var_1;
  self.hostagecarried.wmhostage = var_0;
  return var_0;
}

hostageonuse(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
  self endon("_encstr_88C60846397B83835919");
  var_0 endon("_encstr_AD75063D571AE108");

  if(istrue(self.inlaststand)) {
    return;
  }
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0.01);
  var_0.ui_securing = undefined;
  thread scripts\mp\gameobjects::updatecurorigin();
  level.hostagecarrier = var_0;
  self.trigger makeunusable();
  var_0.hostagecarried = self;

  if(scripts\mp\utility\game::getgametype() == "_encstr_951904D8F1E0" || scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5")
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(self.team, 11, 12, level.hostagecarrier, 13);

  var_0 carrydebuff();
  thread playthanksvo();
  wait 0.4;
  var_0 spawnwmhostagecarry();
  var_0.hostagecarried.body hide(1);
  var_0.hostagecarried.head hide(1);
  self linkTo(var_0, "_encstr_A130084D2FDAD8AA8F62", (0, 0, 0), (0, 0, 0));

  if(isDefined(self.trackedobject)) {
    self.trackedobject.ownerteam = var_0.team;
    self.trackedobject.carrier = var_0;
    self.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);
  }

  if(scripts\mp\utility\game::getgametype() != "_encstr_A9190405B4E5" && isDefined(level.hostagegoalent)) {
    level.hostagegoalent.ownerteam = var_0.team;
    level.hostagegoalent scripts\mp\gameobjects::requestid(1, 1);
    level.hostagegoalent scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    level.hostagegoalent scripts\mp\gameobjects::setobjectivestatusicons(level.iconextract, level.iconpreventextract);
  } else if(scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5") {
    var_0 _encstr_BDD21DCD1BC94BE0D19BBCD6C179EC85DAACD15E07B2E6BC268EADE2B3E636::summonextractchopper(level.vipextractzones[var_0.team]);
    level.vipextractzones[var_0.team].goalent scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  }

  if(isDefined(self.outlineid))
    scripts\mp\utility\outline::outlinedisable(self.outlineid, self);

  if(scripts\mp\utility\game::getgametype() != "_encstr_9719046E3182" && scripts\mp\utility\game::getgametype() != "_encstr_A9190405B4E5" || scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B") {
    if(var_0.team == "_encstr_8E8405EA382B2A")
      var_0.hostageoutlineid = scripts\mp\utility\outline::outlineenableforteam(var_0, "_encstr_8E8405EA382B2A", "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_AD4214B3689849BEABFAB35A7A0883FD43F8C78B6BDB");
    else
      var_0.hostageoutlineid = scripts\mp\utility\outline::outlineenableforteam(var_0, "_encstr_9A8507BA4040188D08", "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_AD4214B3689849BEABFAB35A7A0883FD43F8C78B6BDB");
  }

  if(!isDefined(self.useobj))
    self.useobj = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);

  self.useobj linkTo(var_0, "_encstr_A130084D2FDAD8AA8F62");
  self.useobj makeusable();
  self.useobj setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  self.useobj sethintonobstruction("_encstr_BD1805CB69C063");

  if(scripts\mp\utility\game::getgametype() == "_encstr_951904D8F1E0")
    self.useobj setHintString(&"_encstr_A122145B8336E3B19CC7366F3DA72126E86B87E57F69");
  else
    self.useobj setHintString(&"_encstr_8F3E1845DBC8A83841154F84EF198DDDB777770BE87FC1C38F57");

  self.useobj sethintdisplayfov(360);
  self.useobj setusefov(360);
  self.useobj sethintdisplayrange(100);
  self.useobj setuserange(100);
  self.useobj setusepriority(-3);
  var_0 giveandfireoffhand("_encstr_B85116BB5149C3D148CF6B54EB086737E64953A3BA080FD2");
  var_0.carryobject = self;

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      self.useobj enableplayeruse(var_2);
      continue;
    }

    self.useobj disableplayeruse(var_2);
  }

  foreach(var_5 in level.hostages) {
    if(var_5 != self)
      var_5 disableplayeruse(var_0);
  }

  thread watchhostagedrop(var_0, self, self.useobj);

  if(isDefined(level.tacopssublevel))
    thread chemistcomplaining();

  thread laststandlistener(var_0);

  if(!self.wasindent) {}

  self.wasindent = 1;
  level notify("_encstr_8D1B160DBDCD1DB0B395BE9BE8588EBA9BEBBA83910BD195", 1);
}

playthanksvo() {
  wait 4;
  self playSound("_encstr_997015A9BB31B578A5C168CFEAB620306C81CCB091EE0F");
}

spawncmdgoal() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_884A10329CDEE0C1AC91D7D07B37D1C29DB2");
  var_0 = (-1970, -1692, 5);
  level.hostagegoalent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  level.hostagegoalent.angles = (0, 270, 0);
  level.hostagegoalent.team = "_encstr_9A8507BA4040188D08";
  level.hostagegoalent setModel("_encstr_A221163A6F3309E0B7E590EB6B3F264E2BECBAE46AF314A1");
  level.hostagegoalent setscriptablepartstate("_encstr_912B0778976260C323", "_encstr_8419044EB232");
  level.hostagegoalent playLoopSound("_encstr_A12F1108A33F918142D2F590AE7BC5D8574B68");
  level.hostagegoalent thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 60);
  waitframe();
  playFXOnTag(level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"], level.hostagegoalent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, 120, 128);
  var_1 thread goaltriggerwatcher(self);
}

goaltriggerwatcher(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_85450ED445E87F371DFB49F343672BF3");
  self endon("_encstr_85450ED445E87F371DFB49F343672BF3");
  self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

  if(isDefined(var_0.hostagecarried)) {
    drophostage(var_0, level.hostages[0], var_0.origin);
    level.hostages[0].trigger makeunusable();
    level.hostages[0] makeunusable();
    level.hostages[0].useobj unlink();
    level.hostages[0].useobj makeunusable();

    if(isDefined(level.hostages[0].outlineid))
      scripts\mp\utility\outline::outlinedisable(level.hostages[0].outlineid, level.hostages[0].body);

    thread spawnstartbradley(var_0);
  }

  self delete();
}

spawnstartbradley(var_0) {
  while(!isDefined(level.bradley))
    waitframe();

  var_1 = (-2139, -1977, 64);
  var_2 = (0, 270, 0);
  var_3 = var_0.team;
  var_4 = [];

  foreach(var_6 in scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_9775086022BE1B413B8B")) {
    if(distancesquared(var_6.origin, var_1) < 360000)
      var_6 queuedialogforplayer("_encstr_A93D1F23C3FA6BE0C1D7D5DC0798F51AB7378E0B3BCAFACAE1D193C2B13AA5ED37", "_encstr_A78B176CBD0EFA1AF6DC8E169D56F5950F1DC958C61D96ED73", 2);
  }

  wait 3;
  scripts\mp\utility\dialog::leaderdialog("_encstr_976817EE0FA38EBF34B21818CB0A6B811797E6DE999B90FB18", var_3, "_encstr_AFC610DA4059C3AAD865EDF14F59F3777559", var_4);
  scripts\mp\utility\dialog::leaderdialog("_encstr_8897126CF638D72BCD566BCBF513E41632C6B2CB", scripts\mp\utility\game::getotherteam(var_3)[0], "_encstr_AFC610DA4059C3AAD865EDF14F59F3777559", var_4);
  _encstr_91E429B96CE4A5078E6E795BE0E5B358DA563ACB1CAC6EF2139CC2238DAC2FBEE6072C7773954E17D9376C::spawnbradleynoduration(var_1, var_2, "_encstr_9A8507BA4040188D08");
}

getclosestcheckpoint(var_0) {
  var_1 = level.extractionlocent.origin;
  var_2 = var_1 - level.hostagecheckpointent[0][0].origin;
  var_3 = undefined;

  for(var_4 = 0; var_4 < level.hostagecheckpointent.size; var_4++) {
    var_5 = level.hostagecheckpointent[var_4][0].origin;
    var_6 = var_5 - var_0;

    if(vectordot(var_2, var_6) < 0)
      var_3 = var_5;
  }

  if(!isDefined(var_3))
    var_3 = level.hostagecheckpointent[0][0].origin;

  return var_3;
}

getclosestfleezone(var_0) {
  var_1 = level.hostageexitpoints[0].origin;
  var_2 = distancesquared(var_0, var_1);

  for(var_3 = 1; var_3 < level.hostageexitpoints.size; var_3++) {
    var_4 = level.hostageexitpoints[var_3].origin;
    var_5 = distancesquared(var_4, var_0);

    if(var_2 > var_5) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

hostagethreatwatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AC9E0F2C80DF7B21A9602F9778800AD259");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");

  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = distancesquared(var_1 getEye(), self.origin);

      if(var_1.team == "_encstr_9A8507BA4040188D08" && isalive(var_1)) {
        if(var_2 < 57600) {
          hostagestoprunning();
          return;
        }
      }
    }

    wait 0.5;
  }
}

hostagestoprunning() {
  self notify("_encstr_A1B6107257C393B8603921B7A3C899CBAF7D");
  self.isrunning = 0;
  drophostage(undefined, self, self.origin);
}

hostagenearbywatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1.team != "_encstr_8E8405EA382B2A") {
        continue;
      }
      var_2 = var_1 hasextractionkillstreak();
      var_3 = 0;
      var_4 = 0;

      foreach(var_6 in level.activeextractors) {
        if(var_1 == var_6)
          var_4 = 1;
      }

      foreach(var_9 in level.hostages) {
        var_10 = distancesquared(var_1 getEye(), var_9.origin);

        if(!istrue(var_9.isrunning)) {
          if(var_10 < 14400 && var_9 proxentlos(var_1)) {
            var_3 = 1;
            break;
          }
        }
      }

      if(istrue(level.lastevaccopterdeployed) || var_2 && !var_3) {
        var_1 removeextractionkillstreak();
        var_1 notify("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1");
        var_1 scripts\mp\killstreaks\killstreaks::updatekillstreakuislots();
        var_1 scripts\mp\killstreaks\killstreaks::updatekillstreakselectedui();

        if(!var_4 && istrue(level.lastevaccopterdeployed))
          var_1 delayplayerwarning("_encstr_950F2AF1592AE1283FE7DD6EC9CBBFE3E1D80D80739878D19460914A488BC8EF380B1E4DB65E2AFAA75BE06E");

        break;
      } else if(!var_4 && !var_2 && var_3) {
        var_1 clearoffhandprimary();
        var_1 scripts\mp\killstreaks\killstreaks::awardkillstreak("_encstr_A1961164BF61B71AE701D2BAE81F157B5E11E8", "_encstr_8261067B1D34AC27");
        var_1 iprintlnbold("_encstr_BA5C2244A00A88B4294B9D431D10D1DB0436B01B6301857310B23BB036041BF607472B93");
        break;
      }
    }

    wait 0.5;
  }
}

proxentlos(var_0) {
  if(!isDefined(self.requireslos))
    return 1;

  var_1 = var_0 getEye();
  var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  var_3 = [];
  var_4 = self.origin + (0, 0, 32);
  var_5 = 1;
  var_3[0] = self.visuals;
  var_3[1] = var_0;
  var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);

  if(var_6["_encstr_A53009A25003666B9818C6"] != 1 && var_5) {
    var_4 = self.origin + (0, 0, 16);
    var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  }

  if(var_6["_encstr_A53009A25003666B9818C6"] != 1) {
    var_4 = self.origin + (0, 0, 0);
    var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  }

  return var_6["_encstr_A53009A25003666B9818C6"] == 1;
}

delayplayerwarning(var_0) {
  if(!isDefined(self.lastlzwarning)) {
    self iprintlnbold(var_0);
    self.lastlzwarning = 1;
    wait 10;
    self.lastlzwarning = undefined;
  }
}

startlastextraction() {
  level.lastevaccopterdeployed = 1;
  _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::extendtacopstimelimitms(60000);
}

hasextractionkillstreak() {
  var_0 = scripts\mp\killstreaks\killstreaks::getgimmeslotkillstreakstructs();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.streakname == "_encstr_A1961164BF61B71AE701D2BAE81F157B5E11E8")
      return 1;
  }

  return 0;
}

removeextractionkillstreak() {
  var_0 = scripts\mp\killstreaks\killstreaks::getgimmeslotkillstreakstructs();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.streakname == "_encstr_A1961164BF61B71AE701D2BAE81F157B5E11E8")
      scripts\mp\killstreaks\killstreaks::removekillstreak(0);
  }
}

manageheadicons(var_0) {
  self.ownerteamid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  objective_onentity(self.ownerteamid, self);
  objective_addteamtomask(self.ownerteamid, var_0.team);
  self.teamheadicon = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_0.team, "_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA", 36);
}

moveonpath(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
  self endon("_encstr_AC9E0F2C80DF7B21A9602F9778800AD259");
  self endon("_encstr_A1B6107257C393B8603921B7A3C899CBAF7D");
  var_1 = 100;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_4 = getphysicspointaboutnavmesh(var_3);
    var_5 = distance(self.origin, var_4);

    if(var_5 == 0) {
      continue;
    }
    var_6 = var_5 / var_1;
    self.angles = vectortoangles(var_4 - self.origin);
    self moveTo(var_4, var_6, 0, 0);
    wait(var_6);
  }

  thread hostagestoprunning();
}

scorehostage(var_0, var_1) {
  level.hostages = scripts\engine\utility::array_remove(level.hostages, self);
  scripts\mp\gameobjects::deletetrackedobject();
  level.activehostagecount--;

  if(isDefined(self.useobj))
    self.useobj delete();

  self.body delete();
  self.head delete();
  self delete();
  level scripts\mp\gamescore::giveteamscoreforobjective(var_0, var_1, 0);
  self notify("_encstr_AC9E0F2C80DF7B21A9602F9778800AD259");
}

removeminimapicons() {
  scripts\mp\objidpoolmanager::returnobjectiveid(self.curobjid);

  if(isDefined(self.useobj))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.useobj.ownerteamid);

  if(isDefined(self.useobj) && isDefined(self.useobj.teamheadicon)) {
    self.useobj.teamheadicon destroy();

    foreach(var_2, var_1 in self.useobj.entityheadicons) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_1 destroy();
    }
  }
}

getphysicspointaboutnavmesh(var_0) {
  var_1 = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  var_2 = physics_raycast(var_0 + (0, 0, 48), var_0 - (0, 0, 48), var_1, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");
  var_3 = isDefined(var_2) && var_2.size > 0;

  if(var_3) {
    var_4 = var_2[0]["_encstr_BD260953AA97E3F014279D"];
    return var_4;
  }

  return var_0;
}

drophostage(var_0, var_1, var_2, var_3, var_4) {
  self notify("_encstr_AC7C1348F71DC1B742C4E5FE5BC9F989749F58C04B");

  if(!isDefined(var_0))
    var_0 = self.carrier;

  if(!isDefined(var_2))
    var_2 = self.curorigin;

  if(!isDefined(var_1))
    var_1 = self;

  var_1 notify("_encstr_88C60846397B83835919");

  if(isDefined(var_1.trackedobject)) {
    var_1.trackedobject.carrier = var_1.attachobj;
    var_1.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconrecover, level.iconrecover);

    if(isDefined(var_0) && isDefined(var_0.hostageoutlineid))
      scripts\mp\utility\outline::outlinedisable(var_0.hostageoutlineid, var_0);

    if(scripts\mp\utility\game::getgametype() != "_encstr_9719046E3182" && scripts\mp\utility\game::getgametype() != "_encstr_A9190405B4E5" || scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B")
      var_1.outlineid = scripts\mp\utility\outline::outlineenableforall(var_1.body, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_AD4214B3689849BEABFAB35A7A0883FD43F8C78B6BDB");
  }

  if(isDefined(level.hostagegoalent)) {
    level.hostagegoalent scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
    level.hostagegoalent scripts\mp\gameobjects::releaseid();
  }

  if(scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5" && isDefined(level.vipextractzones))
    level.vipextractzones[var_0.team].goalent scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");

  var_1.carried = 0;
  var_5 = var_2;
  var_1 unlink();
  var_5 = getclosestpointonnavmesh(var_2);
  var_1.origin = getphysicspointaboutnavmesh(var_5) + (0, 0, 2);
  var_1.angles = (0, var_1.angles[1], 0);

  if(!isDefined(var_3) && isDefined(var_1.useobj))
    var_1.useobj.origin = var_1.origin;

  if(isDefined(var_0)) {
    var_0.carryobject = undefined;
    var_6 = var_0.team;

    foreach(var_8 in level.hostages) {
      if(var_8 != var_1)
        var_8 enableplayeruse(var_0);
    }

    var_0 removecarrydebuff(!isDefined(var_4));
  }

  if(isDefined(var_1.wmhostage)) {
    var_1.wmhostage unlink();
    var_1.wmhostage.head delete();
    var_1.wmhostage delete();
    var_1.wmhostage = undefined;
  }

  if(isDefined(var_4))
    wait(var_4);

  if(isDefined(var_0) && isDefined(var_0.hostagecarried)) {
    var_0.hostagecarried.body show();
    var_0.hostagecarried.head show();
    var_0.hostagecarried = undefined;
  } else {
    var_1.body show();
    var_1.head show();
  }

  var_1.trigger makeusable();

  if(isDefined(var_4))
    var_0 restoreweapons();

  level.hostagecarrier = undefined;

  if(scripts\mp\utility\game::getgametype() == "_encstr_951904D8F1E0") {
    foreach(var_0 in level.players) {
      if(var_0.team != var_1.trigger.team) {
        var_1.trigger disableplayeruse(var_0);
        var_1.trigger hidefromplayer(var_0);
      }
    }

    var_1.trigger setHintString(&"_encstr_93C616F74120803849F509F34847015975716F0BA1A7C991");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_1.team, 10, 12);
  } else if(scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5") {
    var_1.trigger setHintString(&"_encstr_93C616F74120803849F509F34847015975716F0BA1A7C991");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_1.team, 10, 12);
  } else
    var_1.trigger setHintString(&"_encstr_ADA51A6AA09742F4C488BE2AD3AF1425D02DAAA07D90F4A615141D8A");

  var_1 setusepriority(-3);

  if(isDefined(var_1.curobjid))
    objective_setownerteam(var_1.curobjid, "_encstr_A7A408B9CA5D1D4E2C63");

  if(isDefined(var_1.body)) {
    var_1.body linkTo(var_1, "_encstr_B40101", (0, 0, 0), (0, 0, 0));
    var_1.body scriptmodelplayanimdeltamotion("_encstr_83191BE98FF7F73EF51C5EC7E0DB50B2050F6B1C1322A98888F9F1D36F");
  }

  return var_1;
}

restoreweapons() {
  self takeallweapons();

  foreach(var_1 in self.restoreweaponlist) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 0);

    if(scripts\mp\utility\weapon::update_health_bar_to_player(var_1))
      self assignweaponmeleeslot(var_1);
  }

  var_3 = scripts\mp\supers::getcurrentsuper();

  if(isDefined(var_3))
    thread scripts\mp\supers::givesuperweapon(var_3);

  var_4 = self.loadoutgesture;

  if(isDefined(var_4)) {
    scripts\cp_mp\gestures::cleargesture();
    scripts\cp_mp\gestures::givegesture(var_4);
  }

  var_5 = "_encstr_BA7F0830B3A7859B60B0";
  var_6 = scripts\mp\equipment::getcurrentequipment(var_5);

  if(isDefined(var_6))
    scripts\mp\equipment::giveequipment(var_6, var_5);

  var_5 = "_encstr_AC8F0AE74163F85AAA380AD8";
  var_6 = scripts\mp\equipment::getcurrentequipment(var_5);

  if(isDefined(var_6))
    scripts\mp\equipment::giveequipment(var_6, var_5);

  foreach(var_1 in self.restoreweaponlist) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var_1)) {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
      break;
    }
  }
}

carrydebuff() {
  if(istrue(level.hostagecarrystates[self.guid])) {
    return;
  }
  scripts\common\utility::allow_prone(0);
  scripts\common\utility::allow_mantle(0);
  var_0 = "_encstr_8AA510D02338F9336BC3DFE3E31383B1357A";

  if(scripts\common\utility::iscp())
    var_0 = "_encstr_96A510720BFB97F440116369F588784F8E43";

  scripts\mp\utility\player::_setsuit(var_0);
  scripts\mp\utility\perk::giveperk("_encstr_ADBE1520D8B843E906A483BA51C3791B2DB02C51D1FB40");
  self.overrideweaponspeed_speedscale = 0.75;
  scripts\mp\weapons::updatemovespeedscale();
  var_1 = "_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B";
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1);
  var_3 = [];
  var_3[var_3.size] = "_encstr_858D08AFDDDBCF83A058";
  var_4 = scripts\mp\class::buildweapon(var_2, ["_encstr_858D08AFDDDBCF83A058"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
  self.removeweaponhostagedrop = var_4;
  self.restoreweaponlist = self.weaponlist;
  self takeallweapons();
  scripts\common\utility::allow_weapon_switch(0);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_4, undefined, undefined, 1);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_4);
  thread refillsinglecountammo();
  thread refillammo();
  level.hostagecarrystates[self.guid] = 1;
}

refillsinglecountammo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_884A10329CDEE0C1AC91D7D07B37D1C29DB2");

  for(;;) {
    if(scripts\mp\utility\player::isreallyalive(self) && self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && isDefined(self.lastdroppableweaponobj) && self getcurrentweaponclipammo() == 0) {
      wait 1;
      self notify("_encstr_AF4D07932B1BDE5846");
      wait 1;
      continue;
    }

    waitframe();
  }
}

refillammo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_884A10329CDEE0C1AC91D7D07B37D1C29DB2");

  for(;;) {
    self waittill("_encstr_AF4D07932B1BDE5846");
    self givestartammo(self.currentprimaryweapon);
  }
}

removecarrydebuff(var_0) {
  if(!istrue(level.hostagecarrystates[self.guid])) {
    return;
  }
  scripts\common\utility::allow_prone(1);
  scripts\common\utility::allow_mantle(1);
  scripts\mp\utility\player::_setsuit("_encstr_917A134BBB70AF23CA99C25D1B47CDBA5A3AFADA38");
  scripts\mp\utility\perk::removeperk("_encstr_ADBE1520D8B843E906A483BA51C3791B2DB02C51D1FB40");
  self.overrideweaponspeed_speedscale = undefined;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\cp_mp\utility\inventory_utility::getridofweapon("_encstr_B85116BB5149C3D148CF6B54EB086737E64953A3BA080FD2");
  scripts\common\utility::allow_weapon_switch(1);

  if(var_0)
    restoreweapons();

  level.hostagecarrystates[self.guid] = 0;
  self notify("_encstr_884A10329CDEE0C1AC91D7D07B37D1C29DB2");
}

chemistcomplaining() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
  level endon("_encstr_884A10329CDEE0C1AC91D7D07B37D1C29DB2");

  for(;;) {
    wait(5.0 + randomfloatrange(3.0, 10.0));
    playsoundatpos(self.origin, "_encstr_AFE61D2387F5DA07C4FA1B4395B6BEC11AB0375923F51BD0CAB539CAC28D8E");
    wait(5.0 + randomfloatrange(3.0, 10.0));
  }
}

laststandlistener(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
}

watchhostagedrop(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
  self endon("_encstr_AD75063D571AE108");
  self.carried = 1;
  var_3 = 0;
  self.carrier = var_0;
  var_4 = level.framedurationseconds;

  while(self.carried) {
    if(!var_0 useButtonPressed())
      var_3 = 1;

    var_5 = 0;

    while(var_3 && var_0 useButtonPressed()) {
      var_5 = var_5 + var_4;

      if(var_5 > 0.3) {
        var_2 unlink();
        var_2 disableplayeruse(var_0);
        var_2 makeunusable();
        var_6 = var_0.origin + anglesToForward(var_0.angles) * 72.0 + (0, 0, 24);
        drophostage(var_0, var_1, var_6, undefined, 1.4);
        return;
      }

      wait(var_4);
    }

    waitframe();
  }
}

obfuscateobjectiveposition() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = 512.0;
  var_1 = var_0 / 2.0;

  for(;;) {
    var_2 = randomfloatrange(var_1 / 3.0, var_1);

    if(randomint(2) == 0)
      var_2 = var_2 * -1;

    var_3 = randomfloatrange(var_1 / 3.0, var_1);

    if(randomint(2) == 0)
      var_3 = var_3 * -1;

    var_4 = (var_2, var_3, 0);
    scripts\mp\objidpoolmanager::update_objective_position(self.curobjid, self.origin + (var_2, var_3, 0));
    wait(randomfloatrange(8, 13));
  }
}

createobjective(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  if(var_1 == -1)
    return -1;

  scripts\mp\objidpoolmanager::objective_add_objective(var_1, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0), var_0);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_1, self);
  scripts\mp\objidpoolmanager::update_objective_state(var_1, "_encstr_930B07BB1B6B3854FF");
  scripts\mp\objidpoolmanager::update_objective_icon(var_1, var_0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_1);

  if(isDefined(level.objvisall))
    [[level.objvisall]](var_1);

  return var_1;
}

hostagestatuswatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
  level endon("_encstr_8EFA1CD2B8EE8B0658A32F105FE88F1F153339DBE04FDF7FC1950DE773C0");
  level childthread hostageallygrabbedchatterwatcher();
  level childthread hostageallygrabbedwatcher();
  level childthread hostageallydroppedchatterwatcher();
  level childthread hostageallydroppedwatcher();
  level childthread hostageaxisgrabbedwatcher();
  level childthread hostagespawnpushedwatcher();

  for(;;) {
    level waittill("_encstr_8D1B160DBDCD1DB0B395BE9BE8588EBA9BEBBA83910BD195", var_0);

    switch (var_0) {
      case 1:
        level notify("_encstr_87C515D0F6CDA3C23B597D0BD836E57DD9272C13C4598C");
        break;
      case 2:
        level notify("_encstr_A221158A6F53BB80AFCB31E3CBE726417F2AFEF25AEF1C");
        break;
      case 3:
        level notify("_encstr_92221534BDDCD158CEACF58536632FFA4693ED1CC15923");
        break;
      default:
        break;
    }
  }
}

hostageallygrabbedchatterwatcher() {
  for(;;) {
    level waittill("_encstr_87C515D0F6CDA3C23B597D0BD836E57DD9272C13C4598C");
    wait 1;
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_AFE61D2387F5DA07C4FA1B4395B6BEC11AB0375923F51BD0CAB539CAC28D8E", "_encstr_9A8507BA4040188D08");
    wait 10;
  }
}

hostageallydroppedchatterwatcher() {
  for(;;) {
    level waittill("_encstr_92221534BDDCD158CEACF58536632FFA4693ED1CC15923");
    wait 1;
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_AFE61D2387F5DA07C4FA1B4395B6BEC11AB0375923F51BD0CAB539CAC28D8E", "_encstr_9A8507BA4040188D08");
    wait 10;
  }
}

hostageallygrabbedwatcher() {
  for(;;) {
    level waittill("_encstr_87C515D0F6CDA3C23B597D0BD836E57DD9272C13C4598C");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_97911BA91889306FDBB9EB53275727505E8B23BB97AC10B5E74361790A", "_encstr_9A8507BA4040188D08");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_8D4B2191E1D7D60726FAB0E2D85BAF0E342CCD5926AFCA73ACD6E5436747D9272C4CC4", "_encstr_8E8405EA382B2A");
    wait 30;
  }
}

hostageallydroppedwatcher() {
  for(;;) {
    level waittill("_encstr_92221534BDDCD158CEACF58536632FFA4693ED1CC15923");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_A9051BA98391D1E812A1D3EBC2C7209BAA07138B878A24902CC29883FE", "_encstr_9A8507BA4040188D08");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_95DE218CF0FA5BE098BEB08B36D67D1CD016379589AFB2B92BDABC34CE3AC89CBD3831", "_encstr_8E8405EA382B2A");
    wait 30;
  }
}

hostageaxisgrabbedwatcher() {
  for(;;) {
    level waittill("_encstr_A221158A6F53BB80AFCB31E3CBE726417F2AFEF25AEF1C");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_87A9206CF9F155D326F6731B13908B4C6897E5A11F985D4F592A9A53C3D44BC6A81B", "_encstr_9A8507BA4040188D08");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_B8A31C781E71187B662947E9C9D8B7C328DF73E50BD17B1323F1B3E35225", "_encstr_8E8405EA382B2A");
    wait 30;
  }
}

hostagespawnpushedwatcher() {
  for(;;) {
    level waittill("_encstr_8F5816B9E8337B7131B74927432927951247D9AB5B2B6FBF");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_8D9B1D2D40B7D019B2F1335F435FA03A93FB25073F4AE38F0F5BEF485EABDF", "_encstr_9A8507BA4040188D08");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_91AC1EAD8069439BF2F788F0FF05B6B1C26E9EA58A0107C3D97FF8F08F3328CD", "_encstr_8E8405EA382B2A");
    wait 30;
  }
}

proxcmdwatcher() {
  level endon("_encstr_AD75063D571AE108");
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", level.hostages[0].origin, 0, 120, 128);
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

  foreach(var_3 in scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_9775086022BE1B413B8B")) {
    if(distancesquared(var_3.origin, var_0.origin) < 250000)
      var_3 queuedialogforplayer("_encstr_84411C5B396812B0385EF37A931AD7FAD88783C7FFADF99498A1EE832948", "_encstr_B2A8142EF7E9FF0B9FD7C36F98D31F63A0F2C9C34279", 2);
  }

  var_0 delete();
}