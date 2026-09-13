/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\broshot.gsc
***********************************************/

initbroshotfx() {}

forceinitbroshot() {
  level.forcebroshot = 1;
  setomnvar("ui_broshot_debug", 1);
  return initbroshot();
}

initbroshot(winner) {
  if(1)
    return 0;

  level.camera_bro_shot = spawnStruct();
  level.camera_bro_shot.basecam = getEnt("camera_mp_broshot", "targetname");
  level.camera_bro_shot.char_loc[0] = getEnt("character_loc_broshot", "targetname");
  level.camera_bro_shot.char_loc[2] = getEnt("character_loc_broshot_a", "targetname");
  level.camera_bro_shot.char_loc[1] = getEnt("character_loc_broshot_b", "targetname");
  level.camera_bro_shot.char_loc[3] = getEnt("character_loc_broshot_c", "targetname");
  level.camera_bro_shot.char_loc[4] = getEnt("character_loc_broshot_d", "targetname");
  level.camera_bro_shot.char_loc[5] = getEnt("character_loc_broshot_e", "targetname");

  if((!isDefined(self) || !isDefined(level.camera_bro_shot.basecam) || !scripts\mp\utility\teams::getteamdata("allies", "teamCount") == 0 || !scripts\mp\utility\teams::getteamdata("axis", "teamCount")) && !istrue(level.forcebroshot))
    return 0;

  if(level.teambased && !istrue(level.forcebroshot)) {
    if(!isDefined(winner)) {
      _id_43A41488C3C487DF = getteamscore("allies");
      _id_18A3FAB290E780C2 = getteamscore("axis");

      if(_id_43A41488C3C487DF == _id_18A3FAB290E780C2)
        return 0;
    } else if(winner == "tie" || winner == "none" || winner == "draw")
      return 0;
  }

  level.camera_bro_shot.myfov = 40;
  level.camera_bro_shot.char_loc[1].origin = level.camera_bro_shot.char_loc[0].origin + anglestoleft(level.camera_bro_shot.char_loc[1].angles) * -40.0 + anglesToForward(level.camera_bro_shot.char_loc[1].angles) * -100.0;
  level.camera_bro_shot.char_loc[2].origin = level.camera_bro_shot.char_loc[0].origin + anglestoleft(level.camera_bro_shot.char_loc[2].angles) * 60.0 + anglesToForward(level.camera_bro_shot.char_loc[2].angles) * -130.0;
  setomnvar("ui_broshot_upside_down", istrue(level.upsidedowntaunts));
  sortwinnersandlosers(winner);
  level.numwinningplayers = int(min(3, level.topplayers.size));
  level.numlosingplayers = int(min(3, level.toplosingplayers.size));
  filterpairs();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.numwinningplayers; _id_AC0E594AC96AA3A8++) {
    _id_287942E67BC0E559 = level.camera_bro_shot.char_loc[_id_AC0E594AC96AA3A8].origin - (0, 0, 50);
    _id_364E0D405C6B4AC8 = (_id_287942E67BC0E559[0], _id_287942E67BC0E559[1], _id_287942E67BC0E559[2] + 100);
    contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 0);
    _id_BC1FB594D8A6E68A = physics_raycast(_id_364E0D405C6B4AC8, _id_287942E67BC0E559, contents, undefined, 1, "physicsquery_closest");
    hit = isDefined(_id_BC1FB594D8A6E68A) && _id_BC1FB594D8A6E68A.size > 0;

    if(hit) {
      _id_2E3BC21C15E7AB6C = _id_BC1FB594D8A6E68A[0]["position"];
      level.camera_bro_shot.char_loc[_id_AC0E594AC96AA3A8].origin = _id_2E3BC21C15E7AB6C;
    }

    level.camera_bro_shot.char_loc[_id_AC0E594AC96AA3A8].angles = level.camera_bro_shot.char_loc[_id_AC0E594AC96AA3A8].angles;
  }

  for(_id_AC0E594AC96AA3A8 = level.numwinningplayers; _id_AC0E594AC96AA3A8 < level.numwinningplayers + level.numlosingplayers; _id_AC0E594AC96AA3A8++) {
    _id_1A76078D68FFCF56 = _id_AC0E594AC96AA3A8 - level.numwinningplayers;
    level.camera_bro_shot.char_loc[_id_AC0E594AC96AA3A8].origin = level.camera_bro_shot.char_loc[_id_1A76078D68FFCF56].origin;
    level.camera_bro_shot.char_loc[_id_AC0E594AC96AA3A8].angles = level.camera_bro_shot.char_loc[_id_1A76078D68FFCF56].angles;
  }

  self.mvparray = [];
  return 1;
}

filterpairs() {
  maxplayers = min(level.numwinningplayers, level.numlosingplayers);

  if(maxplayers < level.numwinningplayers) {
    level.topplayers = scripts\engine\utility::array_remove_index(level.topplayers, level.topplayers.size - 1, 0);
    level.numwinningplayers = level.topplayers.size;
  }

  if(maxplayers < level.numlosingplayers) {
    level.toplosingplayers = scripts\engine\utility::array_remove_index(level.toplosingplayers, level.toplosingplayers.size - 1, 0);
    level.numlosingplayers = level.toplosingplayers.size;
  }
}

timeoutcapturekills(_id_33480CF21EC32E0A) {
  level endon("queuedTauntsRun");
  wait(_id_33480CF21EC32E0A);
  thread runqueuedtaunts();
}

queuecapturekillchoice(_id_EF50426720E1DBB8, _id_DC061F521C45D732) {
  if(!isDefined(level.broshottauntqueue))
    level.broshottauntqueue = [];

  if(!isDefined(level.broshottauntqueue[_id_EF50426720E1DBB8])) {
    level.broshottauntqueue[_id_EF50426720E1DBB8] = _id_DC061F521C45D732;

    if(0 || isDefined(level.debugbroshot)) {
      if(_id_EF50426720E1DBB8 == 0) {
        if(level.numwinningplayers > 1)
          level.broshottauntqueue[_id_EF50426720E1DBB8 + 1] = _id_DC061F521C45D732;

        if(level.numwinningplayers > 2)
          level.broshottauntqueue[_id_EF50426720E1DBB8 + 2] = _id_DC061F521C45D732;
      }
    }
  }

  _id_DD48ADF94C85B955 = 0;

  foreach(player in level.topplayers) {
    if(!isbot(player))
      _id_DD48ADF94C85B955++;
  }

  if(level.broshottauntqueue.size >= _id_DD48ADF94C85B955) {
    if(isDefined(level.broshotintrodone))
      thread runqueuedtaunts();
    else
      thread waittorunqueuedtaunts();
  }
}

processcameradata(broshottauntqueue) {
  level.camdata = [];

  if(!isDefined(level.broshottauntqueue[0]))
    level.broshottauntqueue[0] = 1;

  if(!isDefined(level.broshottauntqueue[1]) && level.numwinningplayers > 1)
    level.broshottauntqueue[1] = randomint(2) + 1;

  if(!isDefined(level.broshottauntqueue[2]) && level.numwinningplayers > 2)
    level.broshottauntqueue[2] = randomint(2) + 1;

  if(isDefined(level.broshottauntqueue[2])) {
    _id_DC061F521C45D732 = level.broshottauntqueue[2];
    camdata = getcamdata(_id_DC061F521C45D732, 2);
    level.camdata[2] = camdata;
  }

  if(isDefined(level.broshottauntqueue[1])) {
    _id_DC061F521C45D732 = level.broshottauntqueue[1];
    camdata = getcamdata(_id_DC061F521C45D732, 1);
    level.camdata[1] = camdata;
  }

  if(isDefined(level.broshottauntqueue[0])) {
    _id_DC061F521C45D732 = level.broshottauntqueue[0];
    camdata = getcamdata(_id_DC061F521C45D732, 0);
    level.camdata[0] = camdata;
  }
}

getcamdata(_id_A3C84AB96DDD225A, _id_3184BA5A4BF7B83C) {
  if(_id_A3C84AB96DDD225A == 1) {
    if(level.broshotwinnersgoodguys)
      camdata = killsequencemarinesdata(_id_3184BA5A4BF7B83C);
    else
      camdata = killsequenceopfordata(_id_3184BA5A4BF7B83C);
  } else if(level.broshotwinnersgoodguys)
    camdata = capturesequencemarinesdata(_id_3184BA5A4BF7B83C);
  else
    camdata = capturesequenceopfordata(_id_3184BA5A4BF7B83C);

  return camdata;
}

waitforintrodone() {
  level endon("queuedTauntsRun");
  level waittill("bro_intro_done");
  level.broshotintrodone = 1;
}

waittorunqueuedtaunts() {
  level endon("queuedTauntsRun");
  level waittill("bro_intro_done");
  thread runqueuedtaunts();
}

calccameraduration(camdata) {
  if(isDefined(camdata.cutframe))
    return camdata.cutframe / 30.0;

  _id_C1D347E93E51BC6C = camdata.keys[camdata.keys.size - 1];
  return _id_C1D347E93E51BC6C.nexttrackframe / 30.0;
}

calcprestarttime(_id_27400324A80D4773) {
  return _id_27400324A80D4773.precutstartframe / 30.0;
}

runqueuedtaunts() {
  level notify("queuedTauntsRun");

  if(!isDefined(level.broshottauntqueue))
    level.broshottauntqueue = [];

  _id_2D4061E492391603 = 11.0;
  processcameradata(level.broshottauntqueue);
  _id_98125A9AD5CDA4F2 = 0;

  if(isDefined(level.broshottauntqueue[2])) {
    _id_61E64F268F4ACBF8 = calccameraduration(level.camdata[2]);
    _id_F3EB62956BD9CCDB = calcprestarttime(level.camdata[1]);
    _id_DC061F521C45D732 = level.broshottauntqueue[2];
    thread docapturekill(2, _id_DC061F521C45D732, _id_98125A9AD5CDA4F2);
    _id_2D4061E492391603 = _id_2D4061E492391603 + _id_61E64F268F4ACBF8;
    _id_98125A9AD5CDA4F2 = _id_98125A9AD5CDA4F2 + (_id_61E64F268F4ACBF8 - _id_F3EB62956BD9CCDB);
  }

  if(isDefined(level.broshottauntqueue[1])) {
    _id_61E64F268F4ACBF8 = calccameraduration(level.camdata[1]);
    _id_F3EB62956BD9CCDB = calcprestarttime(level.camdata[0]);
    _id_DC061F521C45D732 = level.broshottauntqueue[1];
    thread docapturekill(1, _id_DC061F521C45D732, _id_98125A9AD5CDA4F2);
    _id_2D4061E492391603 = _id_2D4061E492391603 + _id_61E64F268F4ACBF8;
    _id_98125A9AD5CDA4F2 = _id_98125A9AD5CDA4F2 + (_id_61E64F268F4ACBF8 - _id_F3EB62956BD9CCDB);
  }

  _id_DC061F521C45D732 = 0;

  if(isDefined(level.broshottauntqueue[0]))
    _id_DC061F521C45D732 = level.broshottauntqueue[0];

  _id_8D513C9B1F80D201 = 0;
  _id_722284CFDE39144C = 0;
  _id_975C5DD24836A94A = 0;
  _id_5E43DF6956102D20 = 0;
  _id_6AFD65073A4E3895 = 0;

  if(level.broshotwinnersgoodguys) {
    if(_id_DC061F521C45D732 == 1) {
      _id_8D513C9B1F80D201 = 3.16667;
      _id_722284CFDE39144C = 0.733333;
      _id_975C5DD24836A94A = 0.2;
      _id_5E43DF6956102D20 = 0.25;
      _id_6AFD65073A4E3895 = 0.15;
    } else {
      _id_8D513C9B1F80D201 = 2.5;
      _id_722284CFDE39144C = 1.4;
      _id_975C5DD24836A94A = 0.2;
      _id_5E43DF6956102D20 = 0.25;
      _id_6AFD65073A4E3895 = 0.15;
    }
  } else if(_id_DC061F521C45D732 == 1) {
    _id_8D513C9B1F80D201 = 5.33333;
    _id_722284CFDE39144C = 0.5;
    _id_975C5DD24836A94A = 0.2;
    _id_5E43DF6956102D20 = 0.25;
    _id_6AFD65073A4E3895 = 0.15;
  } else {
    _id_8D513C9B1F80D201 = 6.66667;
    _id_722284CFDE39144C = 0.6;
    _id_975C5DD24836A94A = 0.2;
    _id_5E43DF6956102D20 = 0.25;
    _id_6AFD65073A4E3895 = 0.15;
  }

  thread docapturekill(0, _id_DC061F521C45D732, _id_98125A9AD5CDA4F2, _id_8D513C9B1F80D201, _id_722284CFDE39144C, _id_975C5DD24836A94A, _id_5E43DF6956102D20, _id_6AFD65073A4E3895);
  thread notifywhentauntstimedout(_id_2D4061E492391603);
  waitframe();
  _id_60FFA59036109947 = 0.0;

  if(isDefined(level.broshottauntqueue[2])) {
    _id_61E64F268F4ACBF8 = calccameraduration(level.camdata[2]);
    thread watchcameratracks(2, _id_DC061F521C45D732);
    _id_60FFA59036109947 = _id_61E64F268F4ACBF8;
  }

  if(isDefined(level.broshottauntqueue[1])) {
    _id_61E64F268F4ACBF8 = calccameraduration(level.camdata[1]);
    wait(_id_60FFA59036109947);
    thread watchcameratracks(1, _id_DC061F521C45D732);
    _id_60FFA59036109947 = _id_61E64F268F4ACBF8;
  }

  wait(_id_60FFA59036109947);
  thread watchcameratracks(0, _id_DC061F521C45D732);
}

notifywhentauntstimedout(_id_2D4061E492391603) {
  wait(_id_2D4061E492391603);
  level notify("taunts_timed_out");

  if(istrue(level.debugbroshot))
    level.players[0] resetbroshot();
}

trydof(camdata) {
  if(isDefined(camdata.dofnearstart)) {
    foreach(player in level.players) {
      if(isbot(player)) {
        continue;
      }
      player.usingcustomdof = 1;
      player setdepthoffield(camdata.dofnearstart, camdata.dofnearend, camdata.doffarstart, camdata.doffarend, camdata.dofnearblur, camdata.doffarblur);
    }
  }
}

watchcameratracks(_id_184641A60898574C, _id_DC061F521C45D732) {
  self notify("play_cam_track");
  self endon("play_cam_track");
  camdata = level.camdata[_id_184641A60898574C];
  trydof(camdata);
  _id_A3EB549C5F0D5E43 = 1;

  for(playing = 1; isDefined(camdata) && istrue(playing); _id_A3EB549C5F0D5E43 = 0)
    playing = cameraactivatetrack(camdata, _id_A3EB549C5F0D5E43, _id_DC061F521C45D732);
}

sortwinnersandlosers(winner) {
  if(level.teambased) {
    if(!isDefined(winner)) {
      _id_43A41488C3C487DF = getteamscore("allies");
      _id_18A3FAB290E780C2 = getteamscore("axis");
      _id_EC15CE3E7A9D1D86 = scripts\engine\utility::ter_op(_id_43A41488C3C487DF >= _id_18A3FAB290E780C2, "allies", "axis");
    } else
      _id_EC15CE3E7A9D1D86 = winner;

    level.topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(_id_EC15CE3E7A9D1D86, "players"), ::compare_player_score);
    enemies = scripts\mp\utility\teams::getenemyplayers(_id_EC15CE3E7A9D1D86);
    level.toplosingplayers = scripts\engine\utility::array_sort_with_func(enemies, ::compare_player_score);
  } else {
    level.topplayers = level.placement["all"];
    level.toplosingplayers = level.placement["all"];
  }
}

startbroshot(winner) {
  if(!isDefined(winner))
    winner = self;

  level.broshotrunning = 1;
  cleanupequipment();
  cleanupgamemodes();
  camera = spawnStruct();
  camera.origin = level.camera_bro_shot.char_loc[0].origin;
  camera.angles = level.camera_bro_shot.char_loc[0].angles;
  level.camera_bro_shot.basecam.origin = camera.origin;
  level.camera_bro_shot.basecam.angles = camera.angles;

  foreach(player in level.players) {
    player scripts\mp\playerlogic::respawn_asspectator(camera.origin, camera.angles);
    player scripts\mp\gamelogic::freezeplayerforroundend();
    player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("broshot::startBroshot()");
  }

  removeallcorpses();
  level.active_camera = camera;
  level.camera_anchor = spawn("script_model", camera.origin);
  level.camera_anchor setModel("tag_origin");
  level.camera_anchor.angles = camera.angles;
  createwinnersandlosersarrays(winner);
  level.numwinningplayers = int(min(3, level.topplayers.size));
  level.numlosingplayers = int(min(3, level.toplosingplayers.size));
  filterpairs();
  level.supergunout = [];
  level.interruptabletaunts = [];
  level.firsttaunttracker = [];

  foreach(player in level.players)
  player hideeffectsforbroshot();

  if(!isDefined(level.broshotwinnersgoodguys))
    level.broshotwinnersgoodguys = level.topplayers[0].team == "allies";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
    _id_7C6311737CB7A0B2 = 1;
    _id_365691351D8D6FE0 = undefined;

    if(_id_AC0E594AC96AA3A8 <= level.numwinningplayers - 1)
      _id_365691351D8D6FE0 = level.topplayers[_id_AC0E594AC96AA3A8];
    else if(_id_AC0E594AC96AA3A8 <= level.numwinningplayers + level.numlosingplayers - 1) {
      _id_7C6311737CB7A0B2 = 0;
      _id_365691351D8D6FE0 = level.toplosingplayers[_id_AC0E594AC96AA3A8 - level.numwinningplayers];
    }

    if(!isDefined(_id_365691351D8D6FE0)) {
      break;
    }

    if(!isDefined(_id_365691351D8D6FE0.loadoutarchetype)) {
      continue;
    }
    _id_2659C231D0E9EFAF = undefined;
    _id_FD0C53898E32C971 = undefined;

    if(istrue(level.debugbroshot)) {
      if(level.broshotwinnersgoodguys) {
        if(_id_7C6311737CB7A0B2) {
          _id_2659C231D0E9EFAF = 10;
          _id_FD0C53898E32C971 = 6;
        } else {
          _id_2659C231D0E9EFAF = 1;
          _id_FD0C53898E32C971 = 1;
        }
      } else if(_id_7C6311737CB7A0B2) {
        _id_2659C231D0E9EFAF = 1;
        _id_FD0C53898E32C971 = 1;
      } else {
        _id_2659C231D0E9EFAF = 10;
        _id_FD0C53898E32C971 = 6;
      }
    }

    createmvparrayentry(_id_AC0E594AC96AA3A8, _id_365691351D8D6FE0, _id_7C6311737CB7A0B2, _id_2659C231D0E9EFAF, _id_FD0C53898E32C971);
  }

  foreach(player in level.players) {
    player setsolid(0);
    player dontinterpolate();

    if(isbot(player)) {
      continue;
    }
    player cameralinkTo(level.camera_anchor, "tag_origin", 1);
    player thread scripts\mp\utility\game::setuipostgamefade(0);
    scripts\cp_mp\utility\player_utility::_visionsetnaked("", 0);

    if(!istrue(level.forcebroshot))
      player thread fadetoblack(1.5);
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

createwinnersandlosersarrays(winner) {
  if(istrue(level.forcebroshot)) {
    if(level.broshotwinnersgoodguys) {
      _id_EC15CE3E7A9D1D86 = "allies";
      _id_1C1DEE64DF9A9C2E = "axis";
    } else {
      _id_EC15CE3E7A9D1D86 = "allies";
      _id_1C1DEE64DF9A9C2E = "axis";
    }

    if(scripts\mp\utility\teams::getteamdata(_id_EC15CE3E7A9D1D86, "teamCount") > 1)
      level.topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(_id_EC15CE3E7A9D1D86, "players"), ::compare_player_score);
    else {
      level.topplayers = [];
      level.topplayers[0] = self;
    }

    if(scripts\mp\utility\teams::getteamdata(_id_1C1DEE64DF9A9C2E, "teamCount") > 1) {
      level.toplosingplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(_id_1C1DEE64DF9A9C2E, "players"), ::compare_player_score);
      return;
    }

    level.topaxisplayers = [];
    level.toplosingplayers[0] = self;
    return;
  } else
    sortwinnersandlosers(winner);
}

createmvparrayentry(_id_AC0E594AC96AA3A8, _id_365691351D8D6FE0, _id_7C6311737CB7A0B2, _id_2659C231D0E9EFAF, _id_FD0C53898E32C971) {
  self.mvparray[_id_AC0E594AC96AA3A8] = spawnStruct();

  if(scripts\mp\utility\game::getgametype() == "infect") {
    if(isbot(_id_365691351D8D6FE0))
      _id_AC2C3E638BB2043D = _id_365691351D8D6FE0.loadoutarchetype;
    else
      _id_AC2C3E638BB2043D = _id_365691351D8D6FE0 scripts\mp\class::cac_getcharacterarchetype();
  } else
    _id_AC2C3E638BB2043D = _id_365691351D8D6FE0.loadoutarchetype;

  rigindex = tablelookuprownum("mp/battleRigTable.csv", 1, _id_AC2C3E638BB2043D);

  if(isbot(_id_365691351D8D6FE0) || isDefined(_id_365691351D8D6FE0.lastarchetypeinfo)) {
    bodymodelname = _id_365691351D8D6FE0 getcustomizationbody();
    headmodelname = _id_365691351D8D6FE0 getcustomizationhead();
    headindex = tablelookuprownum("mp/cac/heads.csv", 1, headmodelname);
    bodyindex = tablelookuprownum("mp/cac/bodies.csv", 1, bodymodelname);

    if(isDefined(_id_365691351D8D6FE0.lastarchetypeinfo))
      rigindex = tablelookuprownum("mp/battleRigTable.csv", 1, _id_365691351D8D6FE0.lastarchetypeinfo.archetype);
  } else {
    bodymodelname = _id_365691351D8D6FE0 getcustomizationbody();
    headmodelname = _id_365691351D8D6FE0 getcustomizationhead();
    headindex = tablelookuprownum("mp/cac/heads.csv", 1, headmodelname);
    bodyindex = tablelookuprownum("mp/cac/bodies.csv", 1, bodymodelname);
  }

  if(isDefined(_id_2659C231D0E9EFAF) && isDefined(_id_FD0C53898E32C971)) {
    headindex = _id_2659C231D0E9EFAF;
    bodyindex = _id_FD0C53898E32C971;
  } else {
    _id_56E7CF38A4910BA2 = _id_365691351D8D6FE0 scripts\mp\teams::getglcustomization();
    headindex = tablelookuprownum("mp/cac/heads.csv", 1, _id_56E7CF38A4910BA2[1]);
    bodyindex = tablelookuprownum("mp/cac/bodies.csv", 1, _id_56E7CF38A4910BA2[0]);
  }

  self.mvparray[_id_AC0E594AC96AA3A8].rigindex = rigindex;
  self.mvparray[_id_AC0E594AC96AA3A8].bodyindex = bodyindex;
  self.mvparray[_id_AC0E594AC96AA3A8].headindex = headindex;

  if(_id_7C6311737CB7A0B2) {
    if(istrue(level.broshotwinnersgoodguys)) {
      switch (_id_AC0E594AC96AA3A8) {
        case 0:
        default:
          self.mvparray[_id_AC0E594AC96AA3A8].weaponname = "iw8_ar_mike4_mp";
          break;
        case 1:
          self.mvparray[_id_AC0E594AC96AA3A8].weaponname = "iw8_ar_mike4_mp";
          break;
        case 2:
          self.mvparray[_id_AC0E594AC96AA3A8].weaponname = "iw8_pi_golf21_mp";
          break;
      }
    } else {
      switch (_id_AC0E594AC96AA3A8) {
        case 0:
        default:
          self.mvparray[_id_AC0E594AC96AA3A8].weaponname = "iw9_me_fists_mp";
          break;
        case 1:
          self.mvparray[_id_AC0E594AC96AA3A8].weaponname = "iw9_me_fists_mp";
          break;
        case 2:
          self.mvparray[_id_AC0E594AC96AA3A8].weaponname = "iw8_ar_mike4_mp";
          break;
      }
    }
  } else
    self.mvparray[_id_AC0E594AC96AA3A8].weaponname = "iw9_me_fists_mp";

  self.mvparray[_id_AC0E594AC96AA3A8].clantag = _id_365691351D8D6FE0 getclantag();
  self.mvparray[_id_AC0E594AC96AA3A8].name = _id_365691351D8D6FE0.name;
  self.mvparray[_id_AC0E594AC96AA3A8].xuid = _id_365691351D8D6FE0 getxuid();
  self.mvparray[_id_AC0E594AC96AA3A8].podiumindex = _id_AC0E594AC96AA3A8;
  self.mvparray[_id_AC0E594AC96AA3A8].clientnum = _id_365691351D8D6FE0 getentitynumber();
  _id_365691351D8D6FE0 setguntypeforui(_id_AC0E594AC96AA3A8);
  _id_365691351D8D6FE0.bro = makebrowinner(_id_AC0E594AC96AA3A8, level.camera_bro_shot.char_loc[_id_AC0E594AC96AA3A8]);
}

resetbroshot() {
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
  numwinningplayers = int(min(3, level.topplayers.size));
  numlosingplayers = int(min(3, level.toplosingplayers.size));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
    _id_7C6311737CB7A0B2 = 1;
    _id_365691351D8D6FE0 = undefined;
    _id_2659C231D0E9EFAF = undefined;
    _id_FD0C53898E32C971 = undefined;

    if(_id_AC0E594AC96AA3A8 <= numwinningplayers - 1) {
      _id_365691351D8D6FE0 = level.topplayers[_id_AC0E594AC96AA3A8];

      if(level.broshotwinnersgoodguys) {
        _id_2659C231D0E9EFAF = 10;
        _id_FD0C53898E32C971 = 6;
      } else {
        _id_2659C231D0E9EFAF = 1;
        _id_FD0C53898E32C971 = 1;
      }
    } else if(_id_AC0E594AC96AA3A8 <= numwinningplayers + numlosingplayers - 1) {
      _id_7C6311737CB7A0B2 = 0;
      _id_365691351D8D6FE0 = level.toplosingplayers[_id_AC0E594AC96AA3A8 - numwinningplayers];

      if(level.broshotwinnersgoodguys) {
        _id_2659C231D0E9EFAF = 1;
        _id_FD0C53898E32C971 = 1;
      } else {
        _id_2659C231D0E9EFAF = 10;
        _id_FD0C53898E32C971 = 6;
      }
    }

    if(!isDefined(_id_365691351D8D6FE0)) {
      break;
    }

    if(!isDefined(_id_365691351D8D6FE0.loadoutarchetype)) {
      continue;
    }
    if(isDefined(_id_365691351D8D6FE0.bro))
      _id_365691351D8D6FE0.bro delete();

    createmvparrayentry(_id_AC0E594AC96AA3A8, _id_365691351D8D6FE0, _id_7C6311737CB7A0B2, _id_2659C231D0E9EFAF, _id_FD0C53898E32C971);
  }

  waitframe();
  startpodium(-1, self.mvparray);
}

introsequence_marinewinner() {
  camdata = cameraintrotrackdata_marine();
  trydof(camdata);
  thread playtracks(camdata, level.camera_bro_shot.basecam);
  cameraactivatetrack(camdata);
  camdata = cameraidletrackdata_marine();
  thread playtracks(camdata, level.camera_bro_shot.basecam);
  level notify("bro_intro_done");
  cameraactivatetrack(camdata);
}

introsequence_opforwinner() {
  camdata = cameraintrotrackdata_opfor();
  trydof(camdata);
  thread playtracks(camdata, level.camera_bro_shot.basecam);
  cameraactivatetrack(camdata);
  camdata = cameraidletrackdata_opfor();
  thread playtracks(camdata, level.camera_bro_shot.basecam);
  level notify("bro_intro_done");
  cameraactivatetrack(camdata);
}

introsequence() {
  camdata = cameraintrotrackdata();
  thread playtracks(camdata, level.camera_bro_shot.basecam);
  cameraactivatetrack(camdata);
  cameraactivatetrack(camdata);
  camdata = cameraintroidletrackdata();
  thread playtracks(camdata, level.camera_bro_shot.basecam);
  self notify("bro_intro_done");
  cameraactivatetrack(camdata);
}

capturesequencemarinesdata(index) {
  switch (index) {
    case 0:
    default:
      camdata = cameramercytrackdata_marines_1st();
      break;
    case 1:
      camdata = cameramercytrackdata_marines_2nd();
      break;
    case 2:
      camdata = cameramercytrackdata_marines_3rd();
      break;
  }

  return camdata;
}

capturesequenceopfordata(index) {
  switch (index) {
    case 0:
    default:
      camdata = cameramercytrackdata_opfor_1st();
      break;
    case 1:
      camdata = cameramercytrackdata_opfor_2nd();
      break;
    case 2:
      camdata = cameramercytrackdata_opfor_3rd();
      break;
  }

  return camdata;
}

killsequencemarinesdata(index) {
  switch (index) {
    case 0:
    default:
      camdata = cameraexecutetrackdata_marines_1st();
      break;
    case 1:
      camdata = cameraexecutetrackdata_marines_2nd();
      break;
    case 2:
      camdata = cameraexecutetrackdata_marines_3rd();
      break;
  }

  return camdata;
}

killsequenceopfordata(index) {
  switch (index) {
    case 0:
    default:
      camdata = cameraexecutetrackdata_opfor_1st();
      break;
    case 1:
      camdata = cameraexecutetrackdata_opfor_2nd();
      break;
    case 2:
      camdata = cameraexecutetrackdata_opfor_3rd();
      break;
  }

  return camdata;
}

killsequence(_id_B6F39E71200FE477) {
  camdata = camerakilltrackdata();
  thread playtracks(camdata, _id_B6F39E71200FE477);
  return camdata;
}

capturesequence(_id_B6F39E71200FE477) {
  camdata = cameracapturetrackdata();
  thread playtracks(camdata, _id_B6F39E71200FE477);
  return camdata;
}

waitpopfov(_id_38C5195A6BDC8D34, _id_96F902EB4385B572) {
  self endon("broshot_done");
  wait(_id_96F902EB4385B572 / 30.0);
  popfov(_id_38C5195A6BDC8D34);
}

hideeffectsforbroshot() {
  if(self.sessionteam == "spectator" || self.sessionteam == "codcaster") {
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

spawnfilllight() {
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("FX_BRO_LIGHT"), level.camera_anchor, "tag_origin");
}

fadetoblack(_id_BB6F264BF4547737) {
  wait 27.0;
  scripts\cp_mp\utility\player_utility::_visionsetnaked("", 0);

  foreach(player in level.players) {
    if(isbot(player)) {
      continue;
    }
    player visionsetfadetoblackforplayer("bw", _id_BB6F264BF4547737);
  }
}

cleanupequipment() {
  self notify("bro_shot_start");
  scripts\mp\weapons::deleteallgrenades();
  dropped_weapons = getweaponarray();

  if(isDefined(dropped_weapons)) {
    foreach(_id_76F4143215683892 in dropped_weapons)
    _id_76F4143215683892 delete();
  }
}

cleanupgamemodes() {
  if(isDefined(level.teamflags)) {
    if(isDefined(level.teamflags[game["attackers"]]) && isDefined(level.teamflags[game["attackers"]].visuals)) {
      for(index = 0; index < level.teamflags[game["attackers"]].visuals.size; index++)
        level.teamflags[game["attackers"]].visuals[index] hide();
    }

    if(isDefined(level.teamflags[game["defenders"]]) && isDefined(level.teamflags[game["defenders"]].visuals)) {
      for(index = 0; index < level.teamflags[game["defenders"]].visuals.size; index++)
        level.teamflags[game["defenders"]].visuals[index] hide();
    }
  }

  if((scripts\mp\utility\game::getgametype() == "dom" || scripts\mp\utility\game::getgametype() == "siege") && isDefined(level.objectives)) {
    foreach(flag in level.objectives) {
      if(isDefined(flag)) {
        flag.scriptable setscriptablepartstate("flag", "off");
        flag.scriptable setscriptablepartstate("pulse", "off");
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() == "grind" && isDefined(level.objectives)) {
    foreach(zone in level.objectives) {
      if(isDefined(zone) && isDefined(zone.scriptable)) {
        zone.scriptable setscriptablepartstate("flag", "off");
        zone.scriptable setscriptablepartstate("pulse", "off");
      }
    }
  }

  if((scripts\mp\utility\game::getgametype() == "sr" || scripts\mp\utility\game::getgametype() == "dd" | scripts\mp\utility\game::getgametype() == "sd") && isDefined(level.objectives)) {
    foreach(_id_EEF26A325310D3AF in level.objectives) {
      if(isDefined(_id_EEF26A325310D3AF) && isDefined(_id_EEF26A325310D3AF.visuals)) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_EEF26A325310D3AF.visuals.size; _id_AC0E594AC96AA3A8++) {
          if(isDefined(_id_EEF26A325310D3AF.visuals[_id_AC0E594AC96AA3A8]))
            _id_EEF26A325310D3AF.visuals[_id_AC0E594AC96AA3A8] hide();
        }
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() == "front" && isDefined(level.zones)) {
    foreach(zone in level.zones) {
      if(isDefined(zone) && isDefined(zone.visuals)) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < zone.visuals.size; _id_AC0E594AC96AA3A8++)
          zone.visuals[_id_AC0E594AC96AA3A8] hide();
      }
    }
  }

  if(istrue(level.dogtagsenabled)) {
    if(isDefined(level.dogtags)) {
      foreach(tag in level.dogtags) {
        if(isDefined(tag) && isDefined(tag.visuals)) {
          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < tag.visuals.size; _id_AC0E594AC96AA3A8++)
            tag.visuals[_id_AC0E594AC96AA3A8] hide();
        }
      }
    }
  }

  if(isDefined(level.balls)) {
    foreach(ball in level.balls)
    ball.visuals[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
  }

  if((scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "grnd") && isDefined(level.zones)) {
    foreach(zone in level.zones) {
      if(isDefined(zone) && isDefined(zone.useobj) && isDefined(zone.useobj.chevrons)) {
        foreach(_id_0EAE85273686F4F4 in zone.useobj.chevrons) {
          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0EAE85273686F4F4.numchevrons; _id_AC0E594AC96AA3A8++)
            _id_0EAE85273686F4F4 setscriptablepartstate("chevron_" + _id_AC0E594AC96AA3A8, "off");
        }
      }
    }
  }
}

tauntinputlisten(topplayers) {
  wait 3.0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(topplayers[_id_AC0E594AC96AA3A8]) || isbot(topplayers[_id_AC0E594AC96AA3A8]) || !scripts\engine\utility::array_contains(level.players, topplayers[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    topplayers[_id_AC0E594AC96AA3A8] thread listenfortauntinput(_id_AC0E594AC96AA3A8);
  }
}

getdisplayweapon(player) {
  weapon = getcompleteweaponname(player.lastdroppableweaponobj);

  if(!issubstr(weapon, player.pers["primaryWeapon"]) && !issubstr(weapon, player.pers["secondaryWeapon"]))
    weapon = getcompleteweaponname(player.spawnweaponobj);

  if(issubstr(weapon, "iw9_me_fists_mp") || issubstr(weapon, "iw8_knife") || issubstr(weapon, "iw7_axe"))
    weapon = player.pers["secondaryWeapon"];

  if(issubstr(weapon, "nunchucks") || issubstr(weapon, "katana"))
    weapon = "iw9_me_fists_mp";

  return weapon;
}

camera_move_helper(moveto, speed, _id_56EBC7F3844CB706, _id_F69BA8D7B96E8326) {
  self _meth_BC667001F9DD3808(moveto.origin);
  wait(_id_56EBC7F3844CB706);
  level.camera_anchor scriptmodelclearanim();
  dist = distance(level.camera_anchor.origin, moveto.origin);
  movetime = dist / speed;

  if(movetime < level.framedurationseconds)
    movetime = level.framedurationseconds;

  level.camera_anchor.move_target = moveto;
  level.camera_anchor moveTo(moveto.origin, movetime);
  level.camera_anchor rotateTo(moveto.angles, movetime);

  if(isDefined(_id_F69BA8D7B96E8326)) {
    wait(movetime - _id_F69BA8D7B96E8326);
    thread scripts\mp\utility\game::setuipostgamefade(1, _id_F69BA8D7B96E8326);
  }

  self clearpredictedstreampos();
}

endbroshot() {
  level.broshotrunning = undefined;
  self notify("broshot_done");
}

makebrowinner(_id_02A6356DE634D45B, _id_7A8CEFA1BB50F856) {
  bro = spawn("script_character", _id_7A8CEFA1BB50F856.origin, 0, 0, _id_02A6356DE634D45B, "MPClientCharacter");
  bro.angles = _id_7A8CEFA1BB50F856.angles;

  if(istrue(level.nukeinfo._id_F30E30BC8F212949) && _id_02A6356DE634D45B == 0)
    playFX(scripts\engine\utility::getfx("mons_screen_ash"), _id_7A8CEFA1BB50F856.origin);

  bro motionblurhqenable();
  return bro;
}

listenfortauntinput(_id_3184BA5A4BF7B83C) {
  if(!isai(self)) {
    self notifyonplayercommand("bro_action_kill", "+attack");
    self notifyonplayercommand("bro_action_capture", "+speed_throw");
  }

  thread listenforcapturekill(_id_3184BA5A4BF7B83C);
  thread waitforintrodone();
  self waittill("taunt_end");
}

popfov(_id_38C5195A6BDC8D34) {
  foreach(player in level.players) {
    if(!isai(player))
      player setclientdvar("cg_fov", _id_38C5195A6BDC8D34);
  }
}

listenforcapturekill(_id_3184BA5A4BF7B83C) {
  self endon("taunt_queued");
  self endon("taunt_start");
  self endon("broshot_done");
  childthread listenforcapture(_id_3184BA5A4BF7B83C);
  childthread listenforkill(_id_3184BA5A4BF7B83C);
}

listenforcapture(_id_3184BA5A4BF7B83C) {
  self waittill("bro_action_capture");
  self setclientomnvar("ui_broshot_choice_lock_in", 2);
  thread queuecapturekill(_id_3184BA5A4BF7B83C, 2);
}

listenforkill(_id_3184BA5A4BF7B83C) {
  self waittill("bro_action_kill");
  self setclientomnvar("ui_broshot_choice_lock_in", 1);
  thread queuecapturekill(_id_3184BA5A4BF7B83C, 1);
}

listenfortaunt(_id_3184BA5A4BF7B83C, index) {
  self endon("taunt_start");
  self endon("broshot_done");

  for(;;) {
    self waittill("bro_action_" + index);
    thread dotaunt(_id_3184BA5A4BF7B83C, index);
    waitframe();
  }
}

queuecapturekill(_id_3184BA5A4BF7B83C, _id_A3C84AB96DDD225A) {
  self notify("taunt_queued");

  if(isDefined(level.overridebroslot))
    _id_3184BA5A4BF7B83C = level.overridebroslot - 1;

  queuecapturekillchoice(_id_3184BA5A4BF7B83C, _id_A3C84AB96DDD225A);
}

calcfirstcamerablendpts() {
  data = [];
  data[0] = spawnStruct();
  data[1] = spawnStruct();
  _id_C2B49C10C3AAAC1C = int(min(level.numwinningplayers, 3)) - 1;
  anims = [];

  if(level.broshotwinnersgoodguys) {
    switch (_id_C2B49C10C3AAAC1C) {
      case 0:
        anims[0] = "iw8_mp_end_game_execute_us_cam_a_1st_ar";
        anims[1] = "iw8_mp_end_game_mercy_us_cam_a_1st";
        break;
      case 1:
        anims[0] = "iw8_mp_end_game_execute_us_cam_a_2nd";
        anims[1] = "iw8_mp_end_game_mercy_us_cam_a_2nd";
        break;
      case 2:
        anims[0] = "iw8_mp_end_game_execute_us_cam_a_3rd";
        anims[1] = "iw8_mp_end_game_mercy_us_cam_a_3rd";
        break;
    }
  } else {
    switch (_id_C2B49C10C3AAAC1C) {
      case 0:
        anims[0] = "iw8_mp_end_game_execute_op_cam_a_1st";
        anims[1] = "iw8_mp_end_game_mercy_op_cam_a_1st";
        break;
      case 1:
        anims[0] = "iw8_mp_end_game_execute_op_cam_a_2nd";
        anims[1] = "iw8_mp_end_game_mercy_op_cam_a_2nd";
        break;
      case 2:
        anims[0] = "iw8_mp_end_game_execute_op_cam_a_3rd";
        anims[1] = "iw8_mp_end_game_mercy_op_cam_a_3rd";
        break;
    }
  }

  thread playfirstcamblendpt(_id_C2B49C10C3AAAC1C, anims[0], data[0]);
  thread playfirstcamblendpt(_id_C2B49C10C3AAAC1C, anims[1], data[1]);
  return data;
}

playfirstcamblendpt(_id_C2B49C10C3AAAC1C, stranim, data) {
  temp_anchor = spawn("script_model", level.camera_bro_shot.char_loc[_id_C2B49C10C3AAAC1C].origin);
  temp_anchor setModel("tag_origin");
  temp_anchor.angles = level.camera_bro_shot.char_loc[_id_C2B49C10C3AAAC1C].angles;
  temp_anchor scriptmodelplayanimdeltamotion(stranim);
  wait 0.5;
  data.firstblendtargetpos = temp_anchor.origin;
  data.firstblendtargetrot = temp_anchor.angles;
}

cameraintrotrackdata_marine() {
  data = spawnStruct();
  data.keys = [];
  data.dofnearstart = 10;
  data.dofnearend = 50;
  data.doffarstart = 320;
  data.doffarend = 640;
  data.dofnearblur = 7;
  data.doffarblur = 5.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_intro_us_cam_a_ar";
  data.keys[0].nexttrackframe = 161;
  return data;
}

cameraintrotrackdata_opfor() {
  data = spawnStruct();
  data.keys = [];
  data.dofnearstart = 10;
  data.dofnearend = 50;
  data.doffarstart = 160;
  data.doffarend = 680;
  data.dofnearblur = 7;
  data.doffarblur = 5.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_intro_op_cam_a";
  data.keys[0].nexttrackframe = 240;
  return data;
}

cameraidletrackdata_marine() {
  data = spawnStruct();
  data.keys = [];
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_idle_us_cam_ar";
  data.keys[0].nexttrackframe = 191;
  return data;
}

cameraidletrackdata_opfor() {
  data = spawnStruct();
  data.keys = [];
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_idle_op_cam";
  data.keys[0].nexttrackframe = 161;
  return data;
}

cameraexecutetrackdata_opfor_1st() {
  data = spawnStruct();
  data.keys = [];
  data.precutstartframe = 5;
  data.dofnearstart = 10;
  data.dofnearend = 50;
  data.doffarstart = 80;
  data.doffarend = 260;
  data.dofnearblur = 7;
  data.doffarblur = 5.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_execute_op_cam_a_1st";
  data.keys[0].nexttrackframe = 489;
  return data;
}

cameraexecutetrackdata_opfor_2nd() {
  data = spawnStruct();
  data.keys = [];
  data.cutframe = 105;
  data.precutstartframe = 20;
  data.dofnearstart = 10;
  data.dofnearend = 80;
  data.doffarstart = 100;
  data.doffarend = 200;
  data.dofnearblur = 7;
  data.doffarblur = 4.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_execute_op_cam_a_2nd";
  data.keys[0].nexttrackframe = 236;
  return data;
}

cameraexecutetrackdata_opfor_3rd() {
  data = spawnStruct();
  data.keys = [];
  data.cutframe = 90;
  data.precutstartframe = 0;
  data.dofnearstart = 10;
  data.dofnearend = 80;
  data.doffarstart = 120;
  data.doffarend = 240;
  data.dofnearblur = 7;
  data.doffarblur = 4.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_execute_op_cam_a_3rd";
  data.keys[0].nexttrackframe = 211;
  return data;
}

cameraexecutetrackdata_marines_1st() {
  data = spawnStruct();
  data.keys = [];
  data.precutstartframe = 0;
  data.dofnearstart = 10;
  data.dofnearend = 50;
  data.doffarstart = 140;
  data.doffarend = 200;
  data.dofnearblur = 7;
  data.doffarblur = 5.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_execute_us_cam_a_1st_ar";
  data.keys[0].nexttrackframe = 80;
  data.keys[1] = spawnStruct();
  data.keys[1].frame = 80;
  data.keys[1].nexttrackframe = 117;
  data.keys[1].fovanimframe = 0;
  data.keys[1].fovzoomstyle = "zombiearcade";
  data.keys[2] = spawnStruct();
  data.keys[2].frame = 117;
  data.keys[2].nexttrackframe = 351;
  data.keys[2].fovanimframe = 0;
  data.keys[2].fovzoomstyle = "zombiedefault";
  return data;
}

cameraexecutetrackdata_marines_1st_alt() {
  data = spawnStruct();
  data.keys = [];
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_execute_us_cam_a_1st_ar";
  data.keys[0].nexttrackframe = 45;
  data.keys[0].fovanimframe = 16;
  data.keys[0].fovzoomstyle = "zombiearcade";
  data.keys[1] = spawnStruct();
  data.keys[1].frame = 45;
  data.keys[1].timescaleold = 1.0;
  data.keys[1].timescale = 0.333;
  data.keys[1].timescaleramptime = 4.0;
  data.keys[1].nexttrackframe = 165;
  data.keys[2] = spawnStruct();
  data.keys[2].frame = 165;
  data.keys[2].timescaleold = 0.333;
  data.keys[2].timescale = 1.0;
  data.keys[2].timescaleramptime = 2.0;
  data.keys[2].nexttrackframe = 251;
  return data;
}

cameraexecutetrackdata_marines_2nd() {
  data = spawnStruct();
  data.keys = [];
  data.cutframe = 51;
  data.precutstartframe = 0;
  data.dofnearstart = 10;
  data.dofnearend = 80;
  data.doffarstart = 100;
  data.doffarend = 200;
  data.dofnearblur = 7;
  data.doffarblur = 4.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_execute_us_cam_a_2nd";
  data.keys[0].nexttrackframe = 140;
  return data;
}

cameraexecutetrackdata_marines_3rd() {
  data = spawnStruct();
  data.keys = [];
  data.cutframe = 60;
  data.precutstartframe = 10;
  data.dofnearstart = 10;
  data.dofnearend = 80;
  data.doffarstart = 120;
  data.doffarend = 240;
  data.dofnearblur = 7;
  data.doffarblur = 4.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_execute_us_cam_a_3rd";
  data.keys[0].nexttrackframe = 171;
  return data;
}

cameramercytrackdata_marines_1st() {
  data = spawnStruct();
  data.keys = [];
  data.precutstartframe = 10;
  data.dofnearstart = 10;
  data.dofnearend = 50;
  data.doffarstart = 80;
  data.doffarend = 160;
  data.dofnearblur = 7;
  data.doffarblur = 5.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_mercy_us_cam_a_1st";
  data.keys[0].nexttrackframe = 300;
  return data;
}

cameramercytrackdata_marines_2nd() {
  data = spawnStruct();
  data.keys = [];
  data.cutframe = 48;
  data.precutstartframe = 10;
  data.dofnearstart = 10;
  data.dofnearend = 80;
  data.doffarstart = 100;
  data.doffarend = 200;
  data.dofnearblur = 7;
  data.doffarblur = 4.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_mercy_us_cam_a_2nd";
  data.keys[0].nexttrackframe = 156;
  return data;
}

cameramercytrackdata_marines_3rd() {
  data = spawnStruct();
  data.keys = [];
  data.cutframe = 85;
  data.precutstartframe = 10;
  data.dofnearstart = 10;
  data.dofnearend = 80;
  data.doffarstart = 120;
  data.doffarend = 240;
  data.dofnearblur = 7;
  data.doffarblur = 4.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_mercy_us_cam_a_3rd";
  data.keys[0].nexttrackframe = 161;
  return data;
}

cameramercytrackdata_opfor_1st() {
  data = spawnStruct();
  data.keys = [];
  data.precutstartframe = 10;
  data.dofnearstart = 10;
  data.dofnearend = 50;
  data.doffarstart = 80;
  data.doffarend = 160;
  data.dofnearblur = 7;
  data.doffarblur = 5.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_mercy_op_cam_a_1st";
  data.keys[0].nexttrackframe = 401;
  return data;
}

cameramercytrackdata_opfor_2nd() {
  data = spawnStruct();
  data.keys = [];
  data.cutframe = 91;
  data.precutstartframe = 10;
  data.dofnearstart = 10;
  data.dofnearend = 80;
  data.doffarstart = 100;
  data.doffarend = 200;
  data.dofnearblur = 7;
  data.doffarblur = 4.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_mercy_op_cam_a_2nd";
  data.keys[0].nexttrackframe = 166;
  return data;
}

cameramercytrackdata_opfor_3rd() {
  data = spawnStruct();
  data.keys = [];
  data.cutframe = 59;
  data.precutstartframe = 0;
  data.dofnearstart = 10;
  data.dofnearend = 80;
  data.doffarstart = 120;
  data.doffarend = 240;
  data.dofnearblur = 7;
  data.doffarblur = 4.5;
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 45;
  data.keys[0].stranim = "iw8_mp_end_game_mercy_op_cam_a_3rd";
  data.keys[0].nexttrackframe = 131;
  return data;
}

cameraintrotrackdata() {
  data = spawnStruct();
  data.keys = [];
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 34.3;
  data.keys[0].stranim = "iw8_mp_end_game_intro_cam_A";
  data.keys[0].nexttrackframe = 116;
  data.keys[1] = spawnStruct();
  data.keys[1].frame = 116;
  data.keys[1].fovkey = 46.8;
  data.keys[1].stranim = "iw8_mp_end_game_intro_cam_B";
  data.keys[1].nexttrackframe = 160;
  return data;
}

cameraintroidletrackdata() {
  data = spawnStruct();
  data.keys = [];
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 46.8;
  data.keys[0].stranim = "iw8_mp_end_game_idle_cam";
  return data;
}

camerakilltrackdata() {
  data = spawnStruct();
  data.keys = [];
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].fovkey = 34.3;
  data.keys[0].nexttrackframe = 396;
  data.keys[0].stranim = "iw8_mp_end_game_execute_stab_cam";
  return data;
}

cameracapturetrackdata() {
  data = spawnStruct();
  data.keys = [];
  data.keys[0] = spawnStruct();
  data.keys[0].frame = 0;
  data.keys[0].nexttrackframe = 34;
  data.keys[0].fovkey = 34.3;
  data.keys[0].stranim = "iw8_mp_end_game_mercy_punch_cam_A";
  data.keys[1] = spawnStruct();
  data.keys[1].frame = 34;
  data.keys[1].fovkey = 46.8;
  data.keys[1].nexttrackframe = 253;
  data.keys[1].stranim = "iw8_mp_end_game_mercy_punch_cam_B";
  return data;
}

playlerptrack(_id_379DE5A38F0E582A, _id_55D450FCC0007B0A) {
  key = _id_379DE5A38F0E582A.keys[0];
  key.lerp_camera_anchor = spawn("script_model", _id_55D450FCC0007B0A.origin);
  key.lerp_camera_anchor setModel("tag_origin");
  key.lerp_camera_anchor.origin = _id_55D450FCC0007B0A.origin;
  key.lerp_camera_anchor.angles = _id_55D450FCC0007B0A.angles;
  key.lerp_camera_anchor scriptmodelplayanimdeltamotion(key.stranim);
}

playtracks(_id_379DE5A38F0E582A, _id_55D450FCC0007B0A) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_379DE5A38F0E582A.keys.size; _id_AC0E594AC96AA3A8++) {
    key = _id_379DE5A38F0E582A.keys[_id_AC0E594AC96AA3A8];
    _id_C1D347E93E51BC6C = undefined;

    if(_id_AC0E594AC96AA3A8 > 0)
      _id_C1D347E93E51BC6C = _id_379DE5A38F0E582A.keys[_id_AC0E594AC96AA3A8 - 1];

    if(isDefined(key.stranim)) {
      key.camera_anchor = spawn("script_model", _id_55D450FCC0007B0A.origin);
      key.camera_anchor setModel("tag_origin");
      key.camera_anchor.origin = _id_55D450FCC0007B0A.origin;
      key.camera_anchor.angles = _id_55D450FCC0007B0A.angles;
      key.camera_anchor scriptmodelplayanimdeltamotion(key.stranim);
    } else
      key.camera_anchor = _id_C1D347E93E51BC6C.camera_anchor;

    if(isDefined(key.fovkey)) {
      key.fov = key.fovkey;
      continue;
    }

    key.fov = _id_C1D347E93E51BC6C.fov;
  }

  _id_379DE5A38F0E582A.currenttrackindex = 0;
}

cameraactivatetrack(_id_379DE5A38F0E582A, _id_A3EB549C5F0D5E43, _id_DC061F521C45D732) {
  self endon("play_cam_track");
  self endon("broshot_done");
  self notify("trackActivated");
  self endon("trackActivated");
  key = _id_379DE5A38F0E582A.keys[_id_379DE5A38F0E582A.currenttrackindex];
  popfov(key.fov);

  if(istrue(_id_A3EB549C5F0D5E43)) {
    if(isDefined(key.lerp_camera_anchor))
      childthread cameralerpto(key.lerp_camera_anchor, key.camera_anchor, 0.5);
    else {
      _id_F278737BE85CBB79 = spawn("script_model", level.broshotfirstcamblends[_id_DC061F521C45D732 - 1].firstblendtargetpos);
      _id_F278737BE85CBB79 setModel("tag_origin");
      _id_F278737BE85CBB79.angles = level.broshotfirstcamblends[_id_DC061F521C45D732 - 1].firstblendtargetrot;
      childthread cameralerpto(_id_F278737BE85CBB79, key.camera_anchor, 0.5);
    }
  } else {
    foreach(player in level.players) {
      if(isbot(player)) {
        continue;
      }
      player cameraunlink();
      player cameralinkTo(key.camera_anchor, "tag_origin", 1);
    }

    level.lastactivatedcameraobject = key.camera_anchor;
  }

  if(isDefined(key.fovanimframe) && isDefined(key.fovzoomstyle))
    childthread dofovzoom(key.fovanimframe, key.fovzoomstyle);

  if(isDefined(key.timescale)) {}

  if(isDefined(key.nexttrackframe))
    wait((key.nexttrackframe - key.frame) / 30.0);

  _id_379DE5A38F0E582A.currenttrackindex++;
  return isDefined(_id_379DE5A38F0E582A.keys[_id_379DE5A38F0E582A.currenttrackindex]);
}

cameralerpto(_id_BCB9076F20166085, _id_BE50EB3BA78BA09A, _id_A326F793BDAF5565) {
  if(isDefined(level.lastactivatedcameraobject)) {
    _id_C5E6EEAF9A329540 = getdvarfloat("r_mbVelocityScale");
    setDvar("r_mbVelocityScale", 2.0);
    pos = level.lastactivatedcameraobject.origin;
    _id_CB89120314447D62 = level.lastactivatedcameraobject.angles;
    level.temp_anchor = spawn("script_model", pos);
    level.temp_anchor setModel("tag_origin");
    level.temp_anchor.angles = _id_CB89120314447D62;

    foreach(player in level.players) {
      if(isbot(player)) {
        continue;
      }
      player cameraunlink();
      player cameralinkTo(level.temp_anchor, "tag_origin", 1);
    }

    level.temp_anchor moveTo(_id_BCB9076F20166085.origin, _id_A326F793BDAF5565, 0, _id_A326F793BDAF5565 / 2.0);
    level.temp_anchor rotateTo(_id_BCB9076F20166085.angles, _id_A326F793BDAF5565, 0, _id_A326F793BDAF5565 / 2.0);
    level.lastactivatedcameraobject = level.temp_anchor;
    wait(_id_A326F793BDAF5565);
    setDvar("r_mbVelocityScale", _id_C5E6EEAF9A329540);
  } else
    level.lastactivatedcameraobject = _id_BE50EB3BA78BA09A;

  foreach(player in level.players) {
    if(isbot(player)) {
      continue;
    }
    player cameraunlink();
    player cameralinkTo(_id_BE50EB3BA78BA09A, "tag_origin", 1);
  }

  level.lastactivatedcameraobject = _id_BE50EB3BA78BA09A;
}

resetfovzoom() {
  foreach(player in level.players) {
    if(isbot(player)) {
      continue;
    }
    player lerpfovbypreset("default");
  }
}

dofovzoom(frame, style) {
  wait(frame / 30.0);

  foreach(player in level.players) {
    if(isbot(player)) {
      continue;
    }
    player lerpfovbypreset(style);
  }
}

cameratrackintrocam() {
  self endon("broshot_done");
  popfov(34.3);
  level.camera_anchor scriptmodelplayanimdeltamotion("iw8_mp_end_game_intro_cam_A");
  wait 3.86667;
  popfov(46.8);
  level.camera_anchor scriptmodelplayanimdeltamotion("iw8_mp_end_game_intro_cam_B");
}

cameratrackkillcam() {
  popfov(34.3);
  level.camera_anchor scriptmodelplayanimdeltamotion("iw8_mp_end_game_execute_stab_cam");
}

cameratrackcapturecam() {
  self endon("broshot_done");
  popfov(34.3);
  level.camera_anchor scriptmodelplayanimdeltamotion("iw8_mp_end_game_mercy_punch_cam");
  wait 1.13333;
  popfov(46.8);
}

docapturekill(_id_3184BA5A4BF7B83C, _id_A3C84AB96DDD225A, _id_74B5B12BB6514385, _id_8D513C9B1F80D201, _id_722284CFDE39144C, _id_DDDA893373141A2F, _id_9D2B0F581001A8A5, _id_C89891D578C0DDE1) {
  self notify("taunt_start");
  self endon("broshot_done");
  _id_59C57549DA6D9513 = _id_74B5B12BB6514385 - 0.5;

  if(_id_59C57549DA6D9513 > 0) {
    wait(_id_59C57549DA6D9513);
    playlerptrack(level.camdata[_id_3184BA5A4BF7B83C], level.camera_bro_shot.char_loc[_id_3184BA5A4BF7B83C]);
  } else
    _id_59C57549DA6D9513 = 0;

  wait(_id_74B5B12BB6514385 - _id_59C57549DA6D9513);
  playtracks(level.camdata[_id_3184BA5A4BF7B83C], level.camera_bro_shot.char_loc[_id_3184BA5A4BF7B83C]);
  _id_5DC16A923D52FD33 = "ui_broshot_anim_" + _id_3184BA5A4BF7B83C;
  _id_1B9C866C93DCCB5D = "ui_broshot_anim_" + _id_3184BA5A4BF7B83C;
  setomnvar(_id_1B9C866C93DCCB5D, _id_A3C84AB96DDD225A);

  if(isDefined(_id_8D513C9B1F80D201))
    thread doslowmo(_id_8D513C9B1F80D201, _id_DDDA893373141A2F, _id_722284CFDE39144C, _id_9D2B0F581001A8A5, _id_C89891D578C0DDE1);

  _id_D1B808A43D179E7B = 300;
  animduration = float(_id_D1B808A43D179E7B) / 30.0;
  waittime = animduration;
  wait(waittime);
  level.taunts_done = 1;
  self notify("taunt_end");
}

doslowmo(_id_8D513C9B1F80D201, _id_DDDA893373141A2F, _id_722284CFDE39144C, _id_BB5329AF4376A152, _id_C89891D578C0DDE1) {
  self endon("broshot_done");

  if(!isDefined(level.endround_timescalefactor)) {
    soundsettimescalefactorfromtable("end_of_round");
    level.endround_timescalefactor = 1;
  }

  wait(_id_8D513C9B1F80D201);
  setslowmotion(1.0, _id_DDDA893373141A2F, _id_BB5329AF4376A152);
  wait(_id_722284CFDE39144C);
  setslowmotion(_id_DDDA893373141A2F, 1.0, _id_C89891D578C0DDE1);
}

dotaunt(_id_3184BA5A4BF7B83C, _id_FDE619F85610523C) {
  self notify("taunt_start");
  self endon("broshot_done");

  if(isDefined(self.changedarchetypeinfo)) {
    _id_6D1A148EFA806994 = level.archetypeids[self.changedarchetypeinfo.archetype];
    _id_A8E6C933E77A1022 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", _id_6D1A148EFA806994, "taunts", _id_FDE619F85610523C - 1);
  } else
    _id_A8E6C933E77A1022 = self getplayerdata(level.loadoutsgroup, "squadMembers", "taunts", _id_FDE619F85610523C - 1);

  if(isDefined(level.overridebroslot))
    _id_3184BA5A4BF7B83C = level.overridebroslot - 1;

  if(isDefined(level.overridetaunt))
    _id_A8E6C933E77A1022 = tablelookup("mp/cac/taunts.csv", 0, level.overridetaunt, 1);

  _id_635CB55857199A8D = tablelookuprownum("mp/cac/taunts.csv", 1, _id_A8E6C933E77A1022);
  _id_DEC75E358B233A01 = tablelookup("mp/cac/taunts.csv", 0, _id_635CB55857199A8D, 5);

  if(_id_DEC75E358B233A01 == "") {
    return;
  }
  _id_D680B3F017BE4744 = tablelookup("mp/cac/taunts.csv", 0, _id_635CB55857199A8D, 19);
  _id_B5174D77C64E0C92 = tablelookup("mp/cac/taunts.csv", 0, _id_635CB55857199A8D, 20);
  _id_D1B808A43D179E7B = tablelookup("mp/cac/taunts.csv", 0, _id_635CB55857199A8D, 21);
  _id_CA2E4CB842EC90E7 = tablelookup("mp/cac/taunts.csv", 0, _id_635CB55857199A8D, 12) == "Y";
  _id_AA58C038AB33E912 = tablelookup("mp/cac/taunts.csv", 0, _id_635CB55857199A8D, 9);
  _id_5DC16A923D52FD33 = "ui_broshot_anim_" + _id_3184BA5A4BF7B83C;

  if(isDefined(level.interruptabletaunts[_id_3184BA5A4BF7B83C]) && level.interruptabletaunts[_id_3184BA5A4BF7B83C] == _id_AA58C038AB33E912) {
    self notify("taunt_end");
    return;
  }

  _id_A2BD9CAFE4A13224 = 1;

  if(!isDefined(level.firsttaunttracker[_id_5DC16A923D52FD33]) && !_id_A2BD9CAFE4A13224) {
    if(!(_id_CA2E4CB842EC90E7 && isDefined(level.supergunout[_id_5DC16A923D52FD33]))) {
      level.firsttaunttracker[_id_5DC16A923D52FD33] = 1;
      putgunaway(_id_5DC16A923D52FD33);
    }

    if(!_id_CA2E4CB842EC90E7)
      level.supergunout[_id_5DC16A923D52FD33] = undefined;
  }

  if(_id_CA2E4CB842EC90E7 && !isDefined(level.supergunout[_id_5DC16A923D52FD33])) {
    level.firsttaunttracker[_id_5DC16A923D52FD33] = undefined;
    takesupergunout(_id_5DC16A923D52FD33, _id_DEC75E358B233A01);
    level.supergunout[_id_5DC16A923D52FD33] = 1;
  }

  _id_5572F6201CB359FD = tablelookup("mp/cac/taunts.csv", 0, _id_635CB55857199A8D, 17);
  _id_60F15279BC6109E8 = tablelookup("mp/cac/taunts.csv", 0, _id_635CB55857199A8D, 18);

  if(_id_3184BA5A4BF7B83C > 0 && _id_5572F6201CB359FD != "" && _id_60F15279BC6109E8 != "") {
    if(_id_3184BA5A4BF7B83C == 1)
      _id_AA58C038AB33E912 = _id_5572F6201CB359FD;
    else if(_id_3184BA5A4BF7B83C == 2)
      _id_AA58C038AB33E912 = _id_60F15279BC6109E8;
  }

  scripts\mp\broshot_utilities::processepictaunt(_id_AA58C038AB33E912, _id_3184BA5A4BF7B83C, 1);
  _id_1B9C866C93DCCB5D = "ui_broshot_anim_" + _id_3184BA5A4BF7B83C;
  setomnvar(_id_1B9C866C93DCCB5D, _id_635CB55857199A8D);
  animduration = float(_id_D1B808A43D179E7B) / 30.0;
  waittime = animduration;

  if(_id_D680B3F017BE4744 != "")
    waittime = waittime * float(_id_D680B3F017BE4744);

  level.camera_anchor scriptmodelclearanim();
  level.camera_anchor.angles = level.camera_bro_shot.basecam.angles;
  level.camera_anchor.origin = level.camera_bro_shot.basecam.origin;
  level.camera_anchor scriptmodelplayanimdeltamotion("iw8_mp_end_game_execute_stab_cam");
  level.interruptabletaunts[_id_3184BA5A4BF7B83C] = _id_AA58C038AB33E912;
  thread interruptblocker(_id_3184BA5A4BF7B83C, animduration);
  wait(waittime);
  level.taunts_done = 1;
  self notify("taunt_end");
}

queueanimationafter(animname, time) {
  self endon("broshot_done");
  wait(time - 0.1);
  level.camera_anchor scriptmodelclearanim();
  level.camera_anchor.angles = level.camera_bro_shot.basecam.angles;
  level.camera_anchor.origin = level.camera_bro_shot.basecam.origin;
  self scriptmodelplayanimdeltamotion(animname);
}

interruptblocker(_id_3184BA5A4BF7B83C, waittime) {
  self notify("combo_started_" + _id_3184BA5A4BF7B83C);
  self endon("combo_started_" + _id_3184BA5A4BF7B83C);
  wait(waittime);
  level.interruptabletaunts[_id_3184BA5A4BF7B83C] = undefined;
}

getaltgunanimstring() {
  weapon = getdisplayweapon(self);

  if(issubstr(weapon, "iw7_nrg") || issubstr(weapon, "iw7_udm45") || issubstr(weapon, "iw7_ump45_mpr_akimbo"))
    return "_alt";

  return "";
}

getgunanimstring() {
  weapon = getdisplayweapon(self);

  if(issubstr(weapon, "minilmg_mpl"))
    return "augfury";

  if(issubstr(weapon, "akimbo"))
    return "akimbo";

  if(issubstr(weapon, "mp28"))
    return "mp28";

  if(issubstr(weapon, "chargeshot") || issubstr(weapon, "venom"))
    return "assault_rifle";

  if(issubstr(weapon, "knife"))
    return "knife";

  if(issubstr(weapon, "axe"))
    return "axe";

  _id_A77E978567103B98 = scripts\mp\utility\weapon::getweapongroup(weapon);

  switch (_id_A77E978567103B98) {
    case "weapon_melee":
      return "melee";
    case "weapon_pistol":
      return "pistol";
    case "weapon_beam":
    case "weapon_smg":
      return "smg";
    case "weapon_battle":
    case "weapon_assault":
      return "assault_rifle";
    case "weapon_lmg":
      return "lmg";
    case "weapon_rail":
    case "weapon_sniper":
    case "weapon_dmr":
      return "sniper";
    case "weapon_shotgun":
      return "shotgun";
    case "weapon_projectile":
      return "launcher";
    default:
      return "akimbo";
  }
}

getgunanimindex() {
  _id_E5B1AAB0CEEB33C5 = getdisplayweapon(self);
  _id_A77E978567103B98 = scripts\mp\utility\weapon::getweapongroup(_id_E5B1AAB0CEEB33C5);

  if(issubstr(_id_E5B1AAB0CEEB33C5, "minilmg_mpl"))
    return 11;

  if(issubstr(_id_E5B1AAB0CEEB33C5, "mp28"))
    return 12;

  if(issubstr(_id_E5B1AAB0CEEB33C5, "akimbo") && !issubstr(_id_E5B1AAB0CEEB33C5, "akimbofmg") && !issubstr(_id_E5B1AAB0CEEB33C5, "mod_akimboshotgun")) {
    if(issubstr(_id_E5B1AAB0CEEB33C5, "iw7_nrg") || issubstr(_id_E5B1AAB0CEEB33C5, "iw7_udm45") || issubstr(_id_E5B1AAB0CEEB33C5, "iw7_ump45_mpr_akimbo"))
      return 13;

    return 8;
  }

  if(issubstr(_id_E5B1AAB0CEEB33C5, "chargeshot") || issubstr(_id_E5B1AAB0CEEB33C5, "venom"))
    return 2;

  if(issubstr(_id_E5B1AAB0CEEB33C5, "knife"))
    return 9;

  if(issubstr(_id_E5B1AAB0CEEB33C5, "axe"))
    return 10;

  if(issubstr(_id_E5B1AAB0CEEB33C5, "nunchuk") || issubstr(_id_E5B1AAB0CEEB33C5, "katana"))
    return 7;

  switch (_id_A77E978567103B98) {
    case "weapon_pistol":
      return 0;
    case "weapon_beam":
    case "weapon_smg":
      return 1;
    case "weapon_assault":
      return 2;
    case "weapon_lmg":
      return 3;
    case "weapon_rail":
    case "weapon_sniper":
    case "weapon_dmr":
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

setguntypeforui(_id_3184BA5A4BF7B83C) {
  omnvar = "ui_broshot_weapon_type_" + _id_3184BA5A4BF7B83C;

  if(_id_3184BA5A4BF7B83C > 2)
    setomnvar(omnvar, 7);
  else
    setomnvar(omnvar, getgunanimindex());
}

putgunaway(_id_1812C7DD1624DC00) {
  _id_43BC54DDEC3FEC7D = getgunanimstring();
  _id_6EF85594D9B35967 = _id_43BC54DDEC3FEC7D + "_put_away" + getaltgunanimstring();
  _id_44980C5064894DC5 = tablelookuprownum("mp/cac/taunts.csv", 1, _id_6EF85594D9B35967);
  setomnvar(_id_1812C7DD1624DC00, -1);
  _id_7F29F791CAF2AE9D = getgunputawayduration(_id_43BC54DDEC3FEC7D);
  wait(_id_7F29F791CAF2AE9D);
}

takesupergunout(_id_1812C7DD1624DC00, _id_DEC75E358B233A01) {
  _id_6EF85594D9B35967 = getrigtransstringfromref(_id_DEC75E358B233A01) + "transout_0";
  _id_44980C5064894DC5 = tablelookuprownum("mp/cac/taunts.csv", 1, _id_6EF85594D9B35967);
  setomnvar(_id_1812C7DD1624DC00, _id_44980C5064894DC5 + 30000);
  _id_7F29F791CAF2AE9D = getrigsupertakeoutdurationfromref(_id_DEC75E358B233A01);
  wait(_id_7F29F791CAF2AE9D);
}

getrigtransstringfromref(_id_C03623632BCF6B39) {
  _id_809E009DDFE27728 = "";

  switch (_id_C03623632BCF6B39) {
    case "archetype_assault":
    default:
      _id_809E009DDFE27728 = "war_";
      break;
  }

  return _id_809E009DDFE27728;
}

getgunputawayduration(_id_4C5C21C55A7AFC1C) {
  _id_7F29F791CAF2AE9D = 0.0;

  switch (_id_4C5C21C55A7AFC1C) {
    case "akimbo":
    default:
      _id_7F29F791CAF2AE9D = 1.067;
      break;
    case "launcher":
      _id_7F29F791CAF2AE9D = 1.567;
      break;
    case "lmg":
      _id_7F29F791CAF2AE9D = 1.333;
      break;
    case "pistol":
      _id_7F29F791CAF2AE9D = 2.233;
      break;
    case "shotgun":
      _id_7F29F791CAF2AE9D = 1.233;
      break;
    case "mp28":
    case "smg":
      _id_7F29F791CAF2AE9D = 1.2;
      break;
    case "sniper":
      _id_7F29F791CAF2AE9D = 1.367;
      break;
    case "assault_rifle":
      _id_7F29F791CAF2AE9D = 1.233;
      break;
    case "melee":
      _id_7F29F791CAF2AE9D = 1.233;
      break;
  }

  return _id_7F29F791CAF2AE9D - 0.2;
}

getrigsupertakeoutdurationfromref(_id_C03623632BCF6B39) {
  _id_7F29F791CAF2AE9D = 0.0;

  switch (_id_C03623632BCF6B39) {
    case "archetype_assault":
    default:
      _id_7F29F791CAF2AE9D = 1.733;
      break;
  }

  return _id_7F29F791CAF2AE9D - 0.2;
}

getrigsuperputawaydurationfromref(_id_C03623632BCF6B39) {
  _id_7F29F791CAF2AE9D = 0.0;

  switch (_id_C03623632BCF6B39) {
    case "archetype_assault":
    default:
      _id_7F29F791CAF2AE9D = 1.267;
      break;
  }

  return _id_7F29F791CAF2AE9D - 0.2;
}

compare_player_score(left, right) {
  return left.score >= right.score;
}

onplayerconnect() {
  self endon("broshot_done");

  for(;;) {
    level waittill("connected", player);

    if(!isai(player))
      thread startlatejoinpodium(player);
  }
}

startlatejoinpodium(player) {
  player endon("disconnect");
  wait 0.25;
  player cameralinkTo(level.camera_anchor, "tag_origin", 1);
  _id_EB8CB3AB1DD0C90E = player getentitynumber();
  startpodium(_id_EB8CB3AB1DD0C90E, self.mvparray);
}

changetestrig(_id_56EF9ADA31420438, _id_021864792A2F4900) {
  level.overriderig = _id_56EF9ADA31420438;
  podiumindex = _id_021864792A2F4900 - 1;
  headindex = 0;
  bodyindex = 0;
  rigindex = 0;

  switch (_id_56EF9ADA31420438) {
    case 1:
    default:
      headindex = 4;
      bodyindex = 18;
      rigindex = 6;
      break;
    case 2:
      headindex = 12;
      bodyindex = 5;
      rigindex = 1;
      break;
    case 3:
      headindex = 28;
      bodyindex = 1;
      rigindex = 2;
      break;
    case 4:
      headindex = 57;
      bodyindex = 28;
      rigindex = 3;
      break;
    case 5:
      headindex = 45;
      bodyindex = 39;
      rigindex = 4;
      break;
    case 6:
      headindex = 27;
      bodyindex = 31;
      rigindex = 5;
      break;
  }

  self.mvparray = [];
  _id_3C96DB658445965E = max(_id_021864792A2F4900, level.topplayers.size);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3C96DB658445965E; _id_AC0E594AC96AA3A8++) {
    self.mvparray[_id_AC0E594AC96AA3A8] = spawnStruct();
    self.mvparray[_id_AC0E594AC96AA3A8].rigindex = rigindex;
    self.mvparray[_id_AC0E594AC96AA3A8].bodyindex = bodyindex;
    self.mvparray[_id_AC0E594AC96AA3A8].headindex = headindex;
    self.mvparray[_id_AC0E594AC96AA3A8].weaponname = getdisplayweapon(level.players[0]);
    self.mvparray[_id_AC0E594AC96AA3A8].clantag = level.players[0] getclantag();
    self.mvparray[_id_AC0E594AC96AA3A8].name = level.players[0].name;
    self.mvparray[_id_AC0E594AC96AA3A8].xuid = level.players[0] getxuid();
    self.mvparray[_id_AC0E594AC96AA3A8].podiumindex = _id_021864792A2F4900;
    self.mvparray[_id_AC0E594AC96AA3A8].clientnum = level.players[0] getentitynumber();

    if(!isDefined(level.topplayers[_id_AC0E594AC96AA3A8])) {
      self.topplayers[_id_AC0E594AC96AA3A8] = spawnStruct();
      level.topplayers[_id_AC0E594AC96AA3A8].bro = makebrowinner(_id_AC0E594AC96AA3A8, level.camera_bro_shot.char_loc[_id_AC0E594AC96AA3A8]);
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3C96DB658445965E; _id_AC0E594AC96AA3A8++)
    level.topplayers[_id_AC0E594AC96AA3A8] setguntypeforui(_id_AC0E594AC96AA3A8);

  waitframe();
  startpodium(-1, self.mvparray);
}

changetesttaunt(_id_18163E77E0207CF2) {
  level.overridetaunt = _id_18163E77E0207CF2;
}

changetestslot(_id_01185ACD40F71AAD) {
  level.overridebroslot = _id_01185ACD40F71AAD;

  if(!isDefined(level.topplayers[_id_01185ACD40F71AAD - 1])) {
    _id_F216B0F9E16A12B0 = 0;

    if(isDefined(level.overriderig))
      _id_F216B0F9E16A12B0 = level.overriderig;

    changetestrig(_id_F216B0F9E16A12B0, _id_01185ACD40F71AAD);
  }
}