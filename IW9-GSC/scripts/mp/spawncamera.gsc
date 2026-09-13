/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spawncamera.gsc
***********************************************/

init() {
  if(!isDefined(level.disablespawncamera))
    level.disablespawncamera = getdvarint("scr_game_disablespawncamera", 1) == 1;

  level.snaptospawncamera = getdvarint("dvar_1A2C3B67392B6657", 1) == 1;
  level.evaluatefrontline = getdvarint("dvar_405E7E20D91344CC", 0) == 1;
  level.evaluatespawnforcameraselection = getdvarint("dvar_C7C93411FF36195C", 1) == 1;
  level.usestaticspawnselectioncamera = getdvarint("dvar_67329F458977DF45", 0);
  level._id_45ABEC6DE5366021 = getdvarvector("dvar_EE64455059EAEEF8", (0, 0, 0));

  if(length(level._id_45ABEC6DE5366021) < 1)
    level._id_45ABEC6DE5366021 = undefined;

  level._id_7B73A66E2D4CA32F = getdvarvector("dvar_F1FE5A0456713312", (0, 0, 0));

  if(length(level._id_7B73A66E2D4CA32F) < 1)
    level._id_7B73A66E2D4CA32F = undefined;

  level.useunifiedspawnselectioncameraheight = getdvarint("dvar_09D6D762163AA3DF", 1);
  level._id_7DCA174E7F878079 = getdvarint("dvar_119957CBC3CE1A03", 0);

  if(!isDefined(level._id_1063C425DDAB3330))
    level._id_1063C425DDAB3330 = ::createdefaultcameras;

  if(!isDefined(level.updatedefaultcamera))
    level.updatedefaultcamera = ::blank_func;

  if(!isDefined(level.updategamemodecamera))
    level.updategamemodecamera = ::blank_func;

  if(!istrue(level.disablespawncamera))
    initcameras();
}

blank_func() {}

initcameras() {
  level.spawncameras = [];
  level.currentcamera = [];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E() && level.mapname == "mp_don3_mobile") {
      level.currentcamera[_id_F90358454413407F] = scripts\cp_mp\utility\game_utility::getlocaleid();
      continue;
    }

    level.currentcamera[_id_F90358454413407F] = "default";
  }

  _id_7C381FE62B0CDA6B = scripts\engine\utility::getStructArray("spawn_selection_camera", "targetname");

  if(_id_7C381FE62B0CDA6B.size == 0 || level.mapname == "mp_aniyah_tac") {
    [[level._id_1063C425DDAB3330]]();
    level._id_1091B5D43BA7A905 = 1;
    return;
  }

  foreach(camera in _id_7C381FE62B0CDA6B) {
    ref = camera.script_label;

    if(!isDefined(ref) || ref == "spawn_selection_camera")
      ref = camera.script_noteworthy;

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      locale = camera.script_noteworthy;

      if(!isDefined(locale) || isDefined(locale) && locale != level.localeid)
        continue;
    }

    if(!isDefined(level.spawncameras[ref]))
      level.spawncameras[ref] = [];

    team = camera.script_team;

    if(team == "all") {
      foreach(_id_F90358454413407F in level.teamnamelist)
      level.spawncameras[ref][_id_F90358454413407F] = camera;

      continue;
    }

    if(istrue(level.usestaticspawnselectioncamera)) {
      temp = scripts\mp\spawnselection::getstaticcameraposition(team);
      camera.origin = temp.origin;
      camera.angles = temp.angles;
    }

    level.spawncameras[ref][team] = camera;

    if(team == "axis") {
      level.spawncameras[ref]["team_three"] = camera;
      level.spawncameras[ref]["team_four"] = camera;
    }
  }

  [[level._id_1063C425DDAB3330]]();
  level._id_1091B5D43BA7A905 = 1;
}

createdefaultcameras() {
  if(isDefined(level.spawncameras["default"])) {
    _id_B4973DD709C9573C = 1;

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(!isDefined(level.spawncameras["default"][_id_F90358454413407F])) {
        _id_B4973DD709C9573C = 0;
        break;
      }
    }

    if(_id_B4973DD709C9573C)
      return;
  } else
    level.spawncameras["default"] = [];

  _id_15B6110595408C7D = (0, 0, 0);

  if(isDefined(level.mapcorners) && isDefined(level.mapcorners[0]) && isDefined(level.mapcorners[1])) {
    level.mapcornervector = level.mapcorners[1].origin - level.mapcorners[0].origin;
    level.mapcornercenter = level.mapcorners[0].origin + level.mapcornervector * 0.5;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(isDefined(level.spawncameras["default"][_id_F90358454413407F])) {
      level.spawncameras["default"][_id_F90358454413407F].radiantplaced = 1;
      continue;
    }

    _id_1F1C8D335BF8F19F = spawnStruct();
    _id_1F1C8D335BF8F19F.origin = (0, 0, 0);
    _id_1F1C8D335BF8F19F.angles = (0, 0, 0);
    level.spawncameras["default"][_id_F90358454413407F] = _id_1F1C8D335BF8F19F;
  }

  level.spawncamerastartspawnallies = getstartspawnavg("allies");
  level.spawncamerastartspawnaxis = getstartspawnavg("axis");
  level.spawncamerastartspawnaxisang = scripts\engine\utility::ter_op(distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[0].origin) < distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[1].origin), level.mapcorners[0].angles, level.mapcorners[1].angles);
  spawnvector = level.spawncamerastartspawnaxis - level.spawncamerastartspawnallies;
  _id_9005B92B370647A5 = level.spawncamerastartspawnallies + spawnvector * 0.5;

  if(distancesquared(level.spawncamerastartspawnallies, level.mapcorners[0].origin) < distancesquared(level.spawncamerastartspawnallies, level.mapcorners[1].origin)) {
    _id_513B04C90CF2A835 = anglesToForward(level.mapcorners[0].angles);
    _id_F073BD569BA4662E = anglestoright(level.mapcorners[0].angles);

    if(abs(vectordot(spawnvector, _id_513B04C90CF2A835)) > abs(vectordot(spawnvector, _id_F073BD569BA4662E)))
      level.spawncamerastartspawnalliesvec = _id_513B04C90CF2A835;
    else
      level.spawncamerastartspawnalliesvec = _id_F073BD569BA4662E;
  } else {
    _id_513B04C90CF2A835 = anglesToForward(level.mapcorners[1].angles);
    _id_F073BD569BA4662E = anglestoright(level.mapcorners[1].angles);

    if(abs(vectordot(spawnvector, _id_513B04C90CF2A835)) > abs(vectordot(spawnvector, _id_F073BD569BA4662E)))
      level.spawncamerastartspawnalliesvec = _id_513B04C90CF2A835;
    else
      level.spawncamerastartspawnalliesvec = _id_F073BD569BA4662E;
  }

  if(distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[0].origin) < distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[1].origin)) {
    _id_513B04C90CF2A835 = anglesToForward(level.mapcorners[0].angles);
    _id_F073BD569BA4662E = anglestoright(level.mapcorners[0].angles);

    if(abs(vectordot(spawnvector, _id_513B04C90CF2A835)) > abs(vectordot(spawnvector, _id_F073BD569BA4662E)))
      level.spawncamerastartspawnaxisvec = _id_513B04C90CF2A835;
    else
      level.spawncamerastartspawnaxisvec = _id_F073BD569BA4662E;
  } else {
    _id_513B04C90CF2A835 = anglesToForward(level.mapcorners[1].angles);
    _id_F073BD569BA4662E = anglestoright(level.mapcorners[1].angles);

    if(abs(vectordot(spawnvector, _id_513B04C90CF2A835)) > abs(vectordot(spawnvector, _id_F073BD569BA4662E)))
      level.spawncamerastartspawnaxisvec = _id_513B04C90CF2A835;
    else
      level.spawncamerastartspawnaxisvec = _id_F073BD569BA4662E;
  }

  spawndist = distance(level.spawncamerastartspawnallies, level.spawncamerastartspawnaxis);
  level.spawncameradistfactor = spawndist;
  orientdefaulttomapcenterusingmapcorners();
}

createspawncamera() {
  if(isDefined(level.updatedefaultcamera))
    [[level.updatedefaultcamera]]();

  if(isDefined(level.updategamemodecamera))
    self[[level.updategamemodecamera]]();

  _id_20C95F6491F59D0C = self.origin + (0, 0, 60);
  _id_06788DC28320974A = self.angles;

  if(isDefined(self.squadspectatepos)) {
    self.deathspectatepos = self.squadspectatepos;
    self.deathspectateangles = self.squadspectateang;
  } else {
    self.deathspectatepos = _id_20C95F6491F59D0C;
    self.deathspectateangles = _id_06788DC28320974A;
  }

  if(!isDefined(self.spawncameraent)) {
    cameraent = spawn("script_model", self.deathspectatepos);
    cameraent scripts\cp_mp\ent_manager::registerspawncount(1);
    cameraent setModel("tag_origin");
    cameraent.angles = self.deathspectateangles;
    self.spawncameraent = cameraent;
  } else {
    self.spawncameraent.origin = self.deathspectatepos;
    self.spawncameraent.angles = self.deathspectateangles;
  }
}

startspawncamera(_id_AD4DD16F29E24B77, _id_F61019386E1B1034, _id_DFAB0807D83A77FE) {
  self endon("disconnect");
  scripts\mp\utility\player::printspawnmessage("spawnCamera::startSpawnCamera() START");
  scripts\mp\utility\player::hideminimap(1);
  self cleardamageindicators();

  if(!(istrue(self.inspawncamera) && getdvarint("dvar_7958073A99A0D67E", 1) == 1))
    createspawncamera();

  if(!isDefined(self.spawncameraent)) {
    scripts\mp\utility\player::printspawnmessage("spawnCamera::startSpawnCamera() UNDEFINED SPAWNCAMERAENT!!!");
    thread playslamzoomflash(0.0, getspawncamerawaittime(), 0.5);
    return;
  }

  if(istrue(level.disablespawncamera) && !istrue(level.usespawnselection)) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(istrue(self.inspawncamera)) {
    return;
  }
  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self.setspawnpoint) && !istrue(level.usespawnselection)) {
    return;
  }
  self.inspawncamera = 1;
  scripts\mp\utility\player::setdof_default();
  waitframe();
  scripts\mp\spectating::setdisabled();
  scripts\mp\utility\player::updatesessionstate("spectator");
  self setclientomnvar("ui_in_spawn_camera", 1);

  if(!isDefined(_id_AD4DD16F29E24B77))
    _id_AD4DD16F29E24B77 = 0.0;

  if(!isDefined(_id_F61019386E1B1034))
    _id_F61019386E1B1034 = 0.25;

  if(!isDefined(_id_DFAB0807D83A77FE))
    _id_DFAB0807D83A77FE = 0.25;

  thread playslamzoomflash(_id_AD4DD16F29E24B77, _id_F61019386E1B1034, _id_DFAB0807D83A77FE);
  thread removecameraondisconnect(self.spawncameraent);
  scripts\engine\utility::waittill_any_timeout_no_endon_death_1(0.1, "force_spawn");
  self cameralinkTo(self.spawncameraent, "tag_origin", 1, 1);
  scripts\mp\utility\player::printspawnmessage("spawnCamera::startSpawnCamera() CameralinkTo()");
  self clearadditionalstreampos();
  thread snaptospawncamera();
}

getspawncamerawaittime() {
  if(isDefined(self.spawncameratime))
    return self.spawncameratime;
  else if(istrue(self.squadspawnaborted) || !istrue(level.snaptospawncamera) && (istrue(self.skippedkillcam) || !isDefined(self.killcamwatchtime) || self.killcamwatchtime < 2.0))
    return 2.5;
  else
    return 1.5;
}

getspawncamerablendtime() {
  return 1.0;
}

getspawncamera() {
  if(istrue(self._id_1305AD103FDD8962) && isDefined(self._id_D309F60EFB44E349))
    return self._id_D309F60EFB44E349;

  _id_0DC51DE4E8CBD07B = undefined;
  team = self.team;

  if(!isDefined(team))
    team = self.sessionteam;

  if(!scripts\mp\utility\teams::isgameplayteam(team)) {
    scripts\mp\utility\player::printspawnmessage("spawncamera::getSpawnCamera() - !isGameplayTeam() = " + team + "camera was undefined, forcing allies default");
    _id_0DC51DE4E8CBD07B = level.spawncameras["default"]["allies"];
    return _id_0DC51DE4E8CBD07B;
  }

  if(_id_BF0E17930D534AB1())
    self.forcedspawncameraref = "default";

  if(istrue(level.usestaticspawnselectioncamera)) {
    level.currentcamera[team] = "default";
    _id_0DC51DE4E8CBD07B = level.spawncameras[level.currentcamera[team]][team];
    temp = scripts\mp\spawnselection::getstaticcameraposition(team);
    _id_0DC51DE4E8CBD07B.origin = temp.origin;
    _id_0DC51DE4E8CBD07B.angles = temp.angles;
  } else if(isDefined(self.forcedspawncameraref)) {
    if(isDefined(level.spawncameras[self.forcedspawncameraref]))
      _id_0DC51DE4E8CBD07B = level.spawncameras[self.forcedspawncameraref][team];
    else if(issubstr(self.forcedspawncameraref, "squad")) {
      ref = self.forcedspawncameraref;

      if(ref == "squad_leader")
        index = level.squaddata[team][self._id_0FF97225579DE16A]._id_D6EE3E704C6731D4._id_3F78C6A0862F9E25;
      else
        index = int(getsubstr(ref, ref.size - 1, ref.size));

      _id_356A015AA1975023 = undefined;

      if(isDefined(level.squaddata[team]) && isDefined(level.squaddata[team][self._id_0FF97225579DE16A]) && isDefined(level.squaddata[team][self._id_0FF97225579DE16A].players[index]))
        _id_356A015AA1975023 = level.squaddata[team][self._id_0FF97225579DE16A].players[index];

      if(isDefined(_id_356A015AA1975023)) {
        forward = level.spawnselectionteamforward[team];
        heightoffset = 7000;

        if(istrue(level.useunifiedspawnselectioncameraheight))
          heightoffset = scripts\mp\spawnselection::_id_87BBBEE0BBF27304();

        _id_2F38DABD01860335 = _id_356A015AA1975023.origin + forward * -8500 + (0, 0, heightoffset);
        _id_67794FF6E49C4961 = vectorNormalize(_id_356A015AA1975023.origin - _id_2F38DABD01860335);
        _id_8003B0D4F9FBEE0E = scripts\mp\utility\script::vectortoanglessafe(_id_67794FF6E49C4961, (0, 0, 1));
        _id_2F38DABD01860335 = _id_2F38DABD01860335 + _id_3BA4F32E41F63B36::calculatecameraoffset(team, _id_356A015AA1975023.origin);
        _id_0DC51DE4E8CBD07B = spawnStruct();
        _id_0DC51DE4E8CBD07B.origin = _id_2F38DABD01860335;
        _id_0DC51DE4E8CBD07B.angles = _id_8003B0D4F9FBEE0E;
      }
    } else if(issubstr(self.forcedspawncameraref, "vehicle")) {
      ref = self.forcedspawncameraref;
      _id_A5D118F040F60DB0 = undefined;

      if(isDefined(level.spawnselectionlocations[ref]) && isDefined(level.spawnselectionlocations[ref][team]))
        _id_A5D118F040F60DB0 = level.spawnselectionlocations[ref][team].dynamicent;

      forward = level.spawnselectionteamforward[team];

      if(isDefined(_id_A5D118F040F60DB0) && !istrue(_id_A5D118F040F60DB0.isdestroyed)) {
        _id_2F38DABD01860335 = [];
        _id_8003B0D4F9FBEE0E = [];
        heightoffset = 7000;

        if(istrue(level.useunifiedspawnselectioncameraheight))
          heightoffset = scripts\mp\spawnselection::_id_87BBBEE0BBF27304();

        _id_2F38DABD01860335 = _id_A5D118F040F60DB0.origin + forward * -8500 + (0, 0, heightoffset);
        groundpos = level.spawnselectionlocations[ref][team].anchorentity.origin;
        camerapos = groundpos + forward * -8500 + (0, 0, heightoffset);
        _id_6D399A908D913B0B = vectorNormalize(groundpos - camerapos);
        _id_8003B0D4F9FBEE0E = scripts\mp\utility\script::vectortoanglessafe(_id_6D399A908D913B0B, (0, 0, 1));
        _id_2F38DABD01860335 = _id_2F38DABD01860335 + _id_3BA4F32E41F63B36::calculatecameraoffset(team, groundpos);
        _id_0DC51DE4E8CBD07B = spawnStruct();
        _id_0DC51DE4E8CBD07B.origin = _id_2F38DABD01860335;
        _id_0DC51DE4E8CBD07B.angles = _id_8003B0D4F9FBEE0E;
      }
    }
  } else if(istrue(level.evaluatespawnforcameraselection) && isDefined(level.lastspawnpos) && isDefined(level.lastspawnpos[team])) {
    _id_90128D0639A1315D = level.lastspawnpos[team];
    _id_84D4866087B00608 = undefined;
    _id_EFC4986F445EB28F = undefined;

    foreach(team, cam in level.spawncameras[level.currentcamera[team]]) {
      distsq = distancesquared(cam.origin, _id_90128D0639A1315D);

      if(!isDefined(_id_EFC4986F445EB28F) || distsq < _id_84D4866087B00608) {
        _id_EFC4986F445EB28F = cam;
        _id_84D4866087B00608 = distsq;
      }
    }

    _id_0DC51DE4E8CBD07B = _id_EFC4986F445EB28F;
  } else if(istrue(level.evaluatefrontline)) {
    frontlineinfo = calulatefrontline();
    _id_84D4866087B00608 = undefined;
    _id_EFC4986F445EB28F = undefined;

    foreach(team, cam in level.spawncameras[level.currentcamera[team]]) {
      _id_11A0B195B1442008 = distancesquared(cam.origin, frontlineinfo.teamavg[team]);
      _id_3C61D0A28315E5A6 = distancesquared(cam.origin, frontlineinfo.origin);

      if(!isDefined(_id_EFC4986F445EB28F) || _id_11A0B195B1442008 < _id_3C61D0A28315E5A6) {
        _id_EFC4986F445EB28F = cam;
        _id_84D4866087B00608 = _id_11A0B195B1442008;
      }
    }

    _id_0DC51DE4E8CBD07B = _id_EFC4986F445EB28F;
  } else {
    if(istrue(level.usec130spawn)) {
      while(!isDefined(level.currentcamera[team]))
        waitframe();
    }

    if(!isstring(level.currentcamera[team])) {
      _id_0DC51DE4E8CBD07B = spawnStruct();
      _id_0DC51DE4E8CBD07B.origin = level.currentcamera[team].origin;
      _id_0DC51DE4E8CBD07B.angles = level.currentcamera[team].angles;
      _id_0DC51DE4E8CBD07B.usingintermissionpos = 1;
    } else
      _id_0DC51DE4E8CBD07B = level.spawncameras[level.currentcamera[team]][team];
  }

  if(!isDefined(_id_0DC51DE4E8CBD07B)) {
    scripts\mp\utility\player::printspawnmessage("spawncamera::getSpawnCamera() - self.forcedSpawnCameraRef = " + self.forcedspawncameraref + "camera was undefined, forcing default");
    _id_0DC51DE4E8CBD07B = level.spawncameras["default"][team];
  }

  self._id_D309F60EFB44E349 = _id_0DC51DE4E8CBD07B;
  return _id_0DC51DE4E8CBD07B;
}

movetospawncamerainitial() {
  self endon("disconnect");
  self notify("newMoveToSpawnCameraInitiated");
  self endon("newMoveToSpawnCameraInitiated");
  self endon("tac_ops_spawn_focus_changed");
  self endon("slamZoomInitiated");
  _id_0DC51DE4E8CBD07B = getspawncamera();
  _id_62CDE7B5D0D68C0B = _id_0DC51DE4E8CBD07B.origin;
  _id_3BFC32B66FE06445 = _id_0DC51DE4E8CBD07B.angles;
  lookatpos = self.spawncameraent.origin;
  _id_832DED18D6904999 = vectorNormalize(lookatpos - _id_0DC51DE4E8CBD07B.origin);
  _id_318EEA579595B65E = scripts\mp\utility\script::vectortoanglessafe(_id_832DED18D6904999, (0, 0, 1));
  self.spawncameraent.angles = _id_318EEA579595B65E;
  dist = distance(lookatpos, _id_62CDE7B5D0D68C0B);
  time = dist / 3520;
  time = clamp(time, 1.5, 3.0);
  self.spawncameratargetpos = _id_62CDE7B5D0D68C0B;
  self.spawncameratargetang = _id_3BFC32B66FE06445;
  self.spawncameratime = time;
  self.spawncameraendtime = gettime() + time * 1000;

  if(!istrue(_id_0DC51DE4E8CBD07B.usingintermissionpos)) {
    self.spawncameraent moveTo(_id_62CDE7B5D0D68C0B, time, time * 0.3, time * 0.4);
    self.spawncameraent rotateTo(_id_3BFC32B66FE06445, time, time * 0.3, time * 0.4);
    wait 1.0;
  } else {
    self.spawncameraent.origin = _id_62CDE7B5D0D68C0B;
    self.spawncameraent.angles = _id_3BFC32B66FE06445;
    self.deathspectatepos = _id_62CDE7B5D0D68C0B;
  }

  applythermal();
  thread startoperatorsound();

  if(isDefined(self) && isDefined(self.spawncameraent) && !istrue(self.inspawnselection)) {
    _id_AE753108F3DFF053 = anglesToForward(_id_3BFC32B66FE06445) * 300;
    _id_AE753108F3DFF053 = _id_AE753108F3DFF053 * (1, 1, 0);
    self earthquakeforplayer(0.03, 15.0, _id_62CDE7B5D0D68C0B, 1000);
  }

  self notify("spawn_camera_idle");
}

movetospawncamera(_id_7C207C285F05DBB2) {
  self endon("disconnect");
  self notify("newMoveToSpawnCameraInitiated");
  self endon("newMoveToSpawnCameraInitiated");
  self endon("tac_ops_map_selection_valid");
  self endon("tac_ops_spawn_focus_changed");
  self endon("slamZoomInitiated");
  _id_0DC51DE4E8CBD07B = getspawncamera();
  _id_62CDE7B5D0D68C0B = _id_0DC51DE4E8CBD07B.origin;
  _id_3BFC32B66FE06445 = _id_0DC51DE4E8CBD07B.angles;

  if(isDefined(self.spawncameratargetpos) && isDefined(self.spawncameratargetang) && self.spawncameratargetpos == _id_62CDE7B5D0D68C0B && self.spawncameratargetang == _id_3BFC32B66FE06445) {
    return;
  }
  lookatpos = self.spawncameraent.origin;
  _id_832DED18D6904999 = vectorNormalize(lookatpos - _id_0DC51DE4E8CBD07B.origin);
  self.spawncameratargetpos = _id_62CDE7B5D0D68C0B;
  self.spawncameratargetang = _id_3BFC32B66FE06445;
  self.spawncameraent moveTo(_id_62CDE7B5D0D68C0B, 1.0, 0.25, 0.75);
  self.spawncameraent rotateTo(_id_3BFC32B66FE06445, 1.0, 0.25, 0.75);
  wait 1.0;

  if(isDefined(self) && isDefined(self.spawncameraent) && !istrue(self.inspawnselection)) {
    _id_AE753108F3DFF053 = anglesToForward(_id_3BFC32B66FE06445) * 300;
    _id_AE753108F3DFF053 = _id_AE753108F3DFF053 * (1, 1, 0);
    self.spawncameraent moveTo(_id_62CDE7B5D0D68C0B + _id_AE753108F3DFF053, 15.0, 1.0, 1.0);
    self earthquakeforplayer(0.03, 15.0, _id_62CDE7B5D0D68C0B, 1000);
  }

  scripts\mp\utility\player::printspawnmessage("spawnCamera::moveToSpawnCamera() moveTo(): " + _id_62CDE7B5D0D68C0B + ", + rotateTo(): " + _id_3BFC32B66FE06445);
  self notify("spawn_camera_idle");
}

snaptospawncamera() {
  self endon("disconnect");

  while(!istrue(self.cansnapcamera))
    waitframe();

  _id_0DC51DE4E8CBD07B = getspawncamera();
  self.spawncameraent dontinterpolate();
  self.spawncameraent.origin = _id_0DC51DE4E8CBD07B.origin;
  self.spawncameraent.angles = _id_0DC51DE4E8CBD07B.angles;

  if(isDefined(_id_0DC51DE4E8CBD07B._id_6930961C8A8D33FC))
    thread _id_2CEDCC356F1B9FC8::playerstreamhintlocation(_id_0DC51DE4E8CBD07B._id_6930961C8A8D33FC);

  if(!istrue(level.nukeinfo._id_AD590A75663898F3))
    self visionsetnakedforplayer("", 0);

  applythermal();
  thread startoperatorsound();

  if(isDefined(self) && isDefined(self.spawncameraent) && !istrue(self.inspawnselection)) {
    _id_AE753108F3DFF053 = anglesToForward(self.spawncameraent.angles) * 300;
    _id_AE753108F3DFF053 = _id_AE753108F3DFF053 * (1, 1, 0);
    self.spawncameraent moveTo(self.spawncameraent.origin + _id_AE753108F3DFF053, 15.0, 1.0, 1.0);
    self earthquakeforplayer(0.03, 15.0, self.spawncameraent.origin, 1000);
  }

  scripts\mp\utility\player::printspawnmessage("spawnCamera::snapToSpawnCamera() Origin: " + _id_0DC51DE4E8CBD07B.origin + ", Angles: " + _id_0DC51DE4E8CBD07B.angles);
  self notify("spawn_camera_idle");
}

endspawncamera() {
  if(isDefined(self.operatorsfx)) {
    self clearsoundsubmix("iw8_mp_spawn_camera");
    self.operatorsfx stoploopsound(self.operatorsfxalias);
    self.operatorsfx delete();
    self.operatorsfx = undefined;
    self.operatorsfxalias = undefined;
  }

  if(!isDefined(self.spawncameraent)) {
    return;
  }
  if(istrue(level.gameended)) {
    return;
  }
  if(istrue(self._id_F9CD51A4708EC70F)) {
    deletespawncamera();
    return;
  }

  scripts\mp\utility\player::hideminimap(1);
  thread streamforslamzoomonspawn();
  runslamzoomonspawn();
}

deletespawncamera() {
  self cameraunlink();
  self.spawncameraent scripts\cp_mp\ent_manager::deregisterspawn();
  self.spawncameraent delete();
  self.spawncameraent = undefined;
  self.isusingspawnmapcamera = undefined;
  self.inspawncamera = 0;
  self._id_D309F60EFB44E349 = undefined;
  self notify("spawn_camera_deleted");
}

removecameraondisconnect(cameraent) {
  self endon("spawn_camera_deleted");
  self waittill("disconnect");

  if(isDefined(cameraent)) {
    cameraent scripts\cp_mp\ent_manager::deregisterspawn();
    cameraent delete();
  }
}

streamforslamzoomonspawn() {
  self endon("disconnect");
  self waittill("spawncamera_start");

  if(istrue(self.prestreaminglocation)) {
    self notify("playerPrestreamLocationWait");
    self.prestreaminglocation = undefined;
    self notify("playerPrestreamComplete");
  }

  self _meth_A304DC5184B0DF29(0);
  self _meth_BC667001F9DD3808(self getEye());
  self waittill("spawn_camera_complete");
  self clearpredictedstreampos();
  self _meth_A304DC5184B0DF29(1);
}

runslamzoomonspawn(_id_595879A0845617F6) {
  self endon("disconnect");
  scripts\mp\utility\player::printspawnmessage("spawnCamera::runSlamZoomOnspawn() START");
  self waittill("spawncamera_start");
  scripts\mp\utility\player::printspawnmessage("spawnCamera::runSlamZoomOnspawn() spawncamera_start PASSED");
  self notify("slamZoomInitiated");
  scripts\mp\utility\player::_freezecontrols(1, undefined, "slamZoom");
  scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("spawncamera::runSlamZoomOnspawn()");
  self useinvisibleplayerduringspawnselection(1);
  self.plotarmor = 1;
  _id_3B64EB40368C1450::set("slamZoom", "vehicle_use", 0);
  scripts\mp\spectating::setdisabled();
  scripts\mp\utility\player::updatesessionstate("spectator");
  self cameralinkTo(self.spawncameraent, "tag_origin", 1);
  scripts\mp\utility\player::printspawnmessage("spawnCamera::runSlamZoomOnspawn() CameralinkTo()");
  handlemovetoblended();
  deletespawncamera();

  if(self.team == "spectator") {
    scripts\mp\playerlogic::removefromalivecount();
    self setclientomnvar("ui_in_spawn_camera", 0);

    if(!istrue(level.nukeinfo._id_AD590A75663898F3))
      self visionsetnakedforplayer("", 0.5);

    scripts\mp\utility\player::_freezecontrols(0, undefined, "slamZoom");
    self useinvisibleplayerduringspawnselection(0);
    self.plotarmor = 0;
    thread scripts\mp\spectating::setspectatepermissions();
    return;
  }

  scripts\mp\utility\player::updatesessionstate("playing");

  if(istrue(self.shouldgetnewspawnpoint)) {
    spawnpoint = scripts\mp\playerlogic::getspawnpoint();
    self setOrigin(spawnpoint.spawnorigin);
    self setplayerangles(spawnpoint.spawnangles);
    scripts\mp\spawnlogic::finalizespawnpointchoice(spawnpoint.spawnpoint);
    self.shouldgetnewspawnpoint = undefined;
    self.selectedspawnarea = undefined;
  }

  thread _id_D28EF4117A443666();
  self setclientomnvar("ui_in_spawn_camera", 0);

  if(!istrue(level.nukeinfo._id_AD590A75663898F3))
    self visionsetnakedforplayer("", 0.5);

  scripts\mp\utility\player::_freezecontrols(0, undefined, "slamZoom");
  scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("spawncamera::runSlamZoomOnspawn()");
  self useinvisibleplayerduringspawnselection(0);
  self.plotarmor = 0;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("slamZoom");
  self notify("spawned_player");
  level notify("player_spawned", self, self.wasrevivespawn);
  thread scripts\mp\playerlogic::setspawnnotifyomnvar();
  self.wasrevivespawn = undefined;
  self.delayedspawnedplayernotify = undefined;
  self.spawndata = undefined;
  scripts\mp\utility\player::printspawnmessage("spawnCamera::runSlamZoomOnspawn() COMPLETE");
}

_id_D28EF4117A443666() {
  self endon("death_or_disconnect");

  if(isDefined(self._id_F109E15FAE27DDC2) && isDefined(self._id_F109E15FAE27DDC2.origin) && isDefined(self._id_F109E15FAE27DDC2.angles) && isDefined(self._id_9066885BD8B59751))
    self setOrigin(self._id_F109E15FAE27DDC2.origin + rotatevector(self._id_9066885BD8B59751, self._id_F109E15FAE27DDC2.angles));

  waitframe();

  if(isDefined(self._id_F109E15FAE27DDC2) && isDefined(self._id_F109E15FAE27DDC2.origin) && isDefined(self._id_F109E15FAE27DDC2.angles) && isDefined(self._id_9066885BD8B59751)) {
    scripts\mp\utility\player::printspawnmessage("spawnCamera::runSlamZoomOnspawn() Set origin on moving platform\nPlatform vehicle type: " + scripts\engine\utility::_id_53C4C53197386572(self._id_F109E15FAE27DDC2.targetname, "undefined") + "\n\tPlatform origin: " + self._id_F109E15FAE27DDC2.origin + "\n\tPlatform angles: " + self._id_F109E15FAE27DDC2.angles + "\n\tPlatform offset: " + self._id_9066885BD8B59751 + "\n\tFinal position: " + self._id_F109E15FAE27DDC2.origin + rotatevector(self._id_9066885BD8B59751, self._id_F109E15FAE27DDC2.angles));
    self _meth_0A055801DA45D769(self._id_F109E15FAE27DDC2.origin + rotatevector(self._id_9066885BD8B59751, self._id_F109E15FAE27DDC2.angles), self._id_F109E15FAE27DDC2);
  }

  self._id_F109E15FAE27DDC2 = undefined;
  self._id_9066885BD8B59751 = undefined;
}

handlemoveTo(duration) {
  self endon("disconnect");
  targetpos = self getEye();
  targetangles = self.angles;
  _id_4158F3E6AF3FC2E7 = (targetpos[0], targetpos[1], self.spawncameraent.origin[2]);
  _id_4158F3E6AF3FC2E7 = _id_4158F3E6AF3FC2E7 + anglesToForward(targetangles) * -480;
  self.spawncameraent moveTo(_id_4158F3E6AF3FC2E7, 0.75, 0.25, 0.25);
  _id_F10BFD0A124A36DC = vectorNormalize(targetpos - _id_4158F3E6AF3FC2E7);
  _id_318EEA579595B65E = scripts\mp\utility\script::vectortoanglessafe(_id_F10BFD0A124A36DC, (0, 0, 1));
  self.spawncameraent rotateTo(_id_318EEA579595B65E, 0.75, 0.25, 0.25);
  wait 0.75;
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  _id_AE819214D26D3BBA = targetpos + anglesToForward(targetangles) * -60;
  self.spawncameraent moveTo(_id_AE819214D26D3BBA, 0.5, 0.1, 0.4);
  self.spawncameraent rotateTo(targetangles, 0.7, 0.45, 0.05);
  wait 0.5;
  thread playslamzoomflash();
  self.spawncameraent moveTo(targetpos, 0.6, 0.1, 0.1);
  wait 0.2;
  self visionsetnakedforplayer("", 0);
}

handlemovetoblended(duration) {
  self endon("disconnect");
  self endon("kill_handle_move_to_blended");
  scripts\mp\utility\player::printspawnmessage("spawnCamera::handlemoveTo() START");

  if(isDefined(level._id_840E89B17AC632EE))
    self[[level._id_840E89B17AC632EE]]();

  targetpos = self.spawndata.spawnorigin + (0, 0, 60);
  targetangles = self.spawndata.spawnangles;

  if(isDefined(self.forcespawncameraorg)) {
    targetpos = self.forcespawncameraorg;
    targetangles = self.forcespawncameraang;
    self.forcespawncameraorg = undefined;
    self.forcespawncameraang = undefined;
  }

  _id_E3ACCE2D88CF3BF4 = angle_diff(self.spawncameraent.angles[1], targetangles[1]) < 45;
  _id_D43D6364668556C7 = distance2dsquared(self.spawncameraent.origin, targetpos) > 1000000;
  thread fadeblackforgeo(targetpos);

  if(!_id_E3ACCE2D88CF3BF4 || !_id_D43D6364668556C7) {
    if(!istrue(level.nukeinfo._id_AD590A75663898F3)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        removethermal();
        self visionsetnakedforplayer("", 0);
      } else
        self visionsetnakedforplayer("respawn_camera_night", 0);
    }

    wait 0.05;
    self.spawncameraent moveTo(targetpos, 1.0, 0.1, 0.9);
    self.spawncameraent rotateTo(targetangles, 1.0, 0.9, 0.1);
    scripts\mp\utility\player::printspawnmessage("spawnCamera::handlemoveTo() FULL Blend Set");

    if(!istrue(level.nukeinfo._id_AD590A75663898F3)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap())
        self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);
    }

    wait 0.8;
    wait 0.2;
  } else {
    _id_F10BFD0A124A36DC = vectorNormalize(targetpos - self.spawncameraent.origin);
    _id_318EEA579595B65E = scripts\mp\utility\script::vectortoanglessafe(_id_F10BFD0A124A36DC, (0, 0, 1));
    self.spawncameraent rotateTo(_id_318EEA579595B65E, 0.7, 0.2, 0.2);
    scripts\mp\utility\player::printspawnmessage("spawnCamera::handlemoveTo() FIRST HALF Blend Set");

    if(!istrue(level.nukeinfo._id_AD590A75663898F3)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        removethermal();
        self visionsetnakedforplayer("", 0);
      } else
        self visionsetnakedforplayer("respawn_camera_night", 0);
    }

    wait 0.05;
    self.spawncameraent moveTo(targetpos, 1.0, 0.1, 0.9);

    if(!istrue(level.nukeinfo._id_AD590A75663898F3)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap())
        self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);
    }

    wait 0.5;
    self.spawncameraent rotateTo(targetangles, 0.5, 0.2, 0.1);
    scripts\mp\utility\player::printspawnmessage("spawnCamera::handlemoveTo() SECOND HALF Blend Set");
    wait 0.3;
    wait 0.2;
  }

  scripts\mp\utility\player::printspawnmessage("spawnCamera::handlemoveTo() COMPLETE");
  self notify("spawn_camera_complete");
}

fadeblackforgeo(targetpos) {
  self endon("disconnect");
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  _id_19A552C4BCE63400 = scripts\engine\trace::ray_trace(self.spawncameraent.origin, targetpos, undefined, contentoverride);
  _id_0DB1541018D7BADF = scripts\engine\trace::ray_trace(targetpos, self.spawncameraent.origin, undefined, contentoverride);
  _id_9759221A13E07F1B = _id_19A552C4BCE63400["fraction"];
  _id_8BB2698C2ACB0FC6 = _id_0DB1541018D7BADF["fraction"];
  _id_4727E885C8A34003 = 0.11;

  if(istrue(self.spawningintovehicle)) {
    if(isDefined(self.vehiclereserved) && isDefined(self.vehiclereserved.vehiclename) && self.vehiclereserved.vehiclename == "veh9_palfa") {
      if(isDefined(self.vehiclereserved.occupants) && self.vehiclereserved.occupants.size == 0) {
        self setsoundsubmix("iw8_mp_vehicle_spawn", 0.1);
        thread clear_plr_vehicle_submix();
      }
    } else {
      self setsoundsubmix("iw8_mp_vehicle_spawn", 0.1);
      thread clear_plr_vehicle_submix();
    }
  }

  if(istrue(self.spawningintovehicle) || scripts\cp_mp\utility\game_utility::isnightmap()) {
    self.spawningintovehicle = undefined;

    if(isDefined(self.vehiclespawninginto) && self.vehiclespawninginto == "light_tank") {
      _id_9759221A13E07F1B = min(_id_9759221A13E07F1B, 0.95);
      _id_8BB2698C2ACB0FC6 = 0.0;
      _id_4727E885C8A34003 = 0.75;
    } else {
      _id_9759221A13E07F1B = min(_id_9759221A13E07F1B, 0.95);
      _id_8BB2698C2ACB0FC6 = 0.0;
    }
  }

  if(istrue(self.shouldgetnewspawnpoint)) {
    _id_9759221A13E07F1B = min(_id_9759221A13E07F1B, 0.5);
    _id_8BB2698C2ACB0FC6 = 0.0;
    thread waitandgetnewspawnpoint();
  }

  if(_id_9759221A13E07F1B < 1.0) {
    if(_id_9759221A13E07F1B - 0.22 > 0.0)
      wait(_id_9759221A13E07F1B - 0.22);

    thread playslamzoomflash(0.1, 1.0 - _id_9759221A13E07F1B - _id_8BB2698C2ACB0FC6 + _id_4727E885C8A34003, 0.25);
  }
}

waitandgetnewspawnpoint() {
  self endon("disconnect");
  self waittill("fadeUp_start");
  self notify("kill_handle_move_to_blended");
}

clear_plr_vehicle_submix() {
  self endon("disconnect");
  wait 1.5;
  self clearsoundsubmix("iw8_mp_vehicle_spawn", 1);
}

playslamzoomflash(_id_AD4DD16F29E24B77, _id_F61019386E1B1034, _id_DFAB0807D83A77FE) {
  self endon("disconnect");
  self.cansnapcamera = 0;

  if(!isDefined(_id_DFAB0807D83A77FE))
    _id_DFAB0807D83A77FE = 0.5;

  self notify("fadeDown_start");

  if(isDefined(_id_AD4DD16F29E24B77) && _id_AD4DD16F29E24B77 > 0) {
    _id_C8D49BBA66D8DB34 = 0.0;
    _id_67C7CB82CFC5EE69 = _id_AD4DD16F29E24B77 / level.framedurationseconds;
    _id_11B42FD8A12916AD = 1.0 / _id_67C7CB82CFC5EE69;
    _id_4A1830F604C82B9F = 0;

    while(_id_4A1830F604C82B9F < _id_67C7CB82CFC5EE69) {
      _id_4A1830F604C82B9F++;
      _id_C8D49BBA66D8DB34 = _id_C8D49BBA66D8DB34 + _id_11B42FD8A12916AD;
      _id_C8D49BBA66D8DB34 = clamp(_id_C8D49BBA66D8DB34, 0.0, 1.0);
      self setclientomnvar("ui_world_fade", _id_C8D49BBA66D8DB34);
      waitframe();
    }
  } else {}

  self notify("fadeDown_complete");
  self.cansnapcamera = 1;

  if(isDefined(_id_F61019386E1B1034) && _id_F61019386E1B1034 > 0)
    wait(_id_F61019386E1B1034);

  self notify("fadeUp_start");

  if(isDefined(_id_DFAB0807D83A77FE) && _id_DFAB0807D83A77FE > 0) {
    _id_C8D49BBA66D8DB34 = 1.0;
    _id_67C7CB82CFC5EE69 = _id_DFAB0807D83A77FE / level.framedurationseconds;
    _id_11B42FD8A12916AD = 1.0 / _id_67C7CB82CFC5EE69;
    _id_4A1830F604C82B9F = 0;

    while(_id_4A1830F604C82B9F < _id_67C7CB82CFC5EE69) {
      _id_4A1830F604C82B9F++;
      _id_C8D49BBA66D8DB34 = _id_C8D49BBA66D8DB34 - _id_11B42FD8A12916AD;
      _id_C8D49BBA66D8DB34 = clamp(_id_C8D49BBA66D8DB34, 0.0, 1.0);
      self setclientomnvar("ui_world_fade", _id_C8D49BBA66D8DB34);
      waitframe();
    }
  } else
    self setclientomnvar("ui_world_fade", 0.0);

  self notify("fadeUp_complete");
}

movecameratomappos(player, _id_9813182985677B23, finalangles) {
  self moveTo(_id_9813182985677B23, 1.0, 0.5, 0.5);
  self rotateTo(finalangles, 1.0, 0.5, 0.5);
  player thread startoperatorsound();
  wait 1.1;
}

applythermal() {
  if(istrue(self.spawncameraskipthermalonce)) {
    self.spawncameraskipthermalonce = 0;
    return;
  }

  if(istrue(self.spawncameraskipthermal)) {
    return;
  }
  if(!istrue(level.nukeinfo._id_AD590A75663898F3)) {
    if(scripts\cp_mp\utility\game_utility::isnightmap())
      self visionsetnakedforplayer("respawn_camera_night", 0);
    else
      self visionsetnakedforplayer("respawn_camera", 0);
  }
}

removethermal() {}

startoperatorsound() {
  self endon("disconnect");
  self endon("game_ended");

  if(isDefined(self.operatorsfx)) {
    return;
  }
  if(istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
    return;
  }
  self.operatorsfx = spawn("script_origin", (0, 0, 0));
  self.operatorsfx showonlytoplayer(self);
  self setsoundsubmix("iw8_mp_spawn_camera");
  _id_1D6DF6A17CEE3314 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
  _id_53787B74A16A9D5E = "dx_mpo_" + _id_1D6DF6A17CEE3314 + "op_drone_deathchatter";

  if(!soundexists(_id_53787B74A16A9D5E))
    _id_53787B74A16A9D5E = "dx_mpo_ruop_drone_deathchatter";

  self.operatorsfxalias = _id_53787B74A16A9D5E;
  self.operatorsfx playLoopSound(_id_53787B74A16A9D5E);
  thread endoperatorsfxondisconnect();
}

endoperatorsfxondisconnect() {
  self endon("spawned_player");
  ent = self.operatorsfx;
  alias = self.operatorsfxalias;
  self waittill("disconnect");

  if(isDefined(ent)) {
    ent stoploopsound(alias);
    ent delete();
  }
}

setgamemodecamera(team, cameraent) {
  level.spawncameras["gamemode"][team] = cameraent;
  setspawncamera(team, "gamemode");
}

setspawncamera(team, ref) {
  level.currentcamera[team] = ref;
}

orientdefaulttomapcenterusingmapcorners() {
  _id_F3185B6AB68825A3 = (level.spawncamerastartspawnallies[2] + level.spawncamerastartspawnaxis[2]) * 0.5;
  _id_8B608C6B5E96C8E4 = (level.mapcornercenter[0], level.mapcornercenter[1], _id_F3185B6AB68825A3);

  if(!istrue(level.spawncameras["default"]["allies"].radiantplaced)) {
    heightoffset = _id_9DD9773C51F39A12();

    if(heightoffset > 0)
      _id_74A2D868CFE3A64E = _id_8B608C6B5E96C8E4 + level.spawncamerastartspawnalliesvec * level.spawncameradistfactor * -0.85 + (0, 0, heightoffset);
    else
      _id_74A2D868CFE3A64E = _id_8B608C6B5E96C8E4 + level.spawncamerastartspawnalliesvec * level.spawncameradistfactor * -0.85 + (0, 0, 1) * level.spawncameradistfactor * 0.45;

    _id_6841474D6FED394F = vectorNormalize(_id_8B608C6B5E96C8E4 - _id_74A2D868CFE3A64E);
    _id_9AE75568303E010C = scripts\mp\utility\script::vectortoanglessafe(_id_6841474D6FED394F, (0, 0, 1));
    level.spawncameras["default"]["allies"].origin = _id_74A2D868CFE3A64E;
    level.spawncameras["default"]["allies"].angles = _id_9AE75568303E010C;
  }

  if(!istrue(level.spawncameras["default"]["axis"].radiantplaced)) {
    heightoffset = _id_9DD9773C51F39A12();

    if(heightoffset > 0)
      _id_06A277D0D2E8D5DF = _id_8B608C6B5E96C8E4 + level.spawncamerastartspawnaxisvec * level.spawncameradistfactor * -0.85 + (0, 0, heightoffset);
    else
      _id_06A277D0D2E8D5DF = _id_8B608C6B5E96C8E4 + level.spawncamerastartspawnaxisvec * level.spawncameradistfactor * -0.85 + (0, 0, 1) * level.spawncameradistfactor * 0.45;

    _id_6841474D6FED394F = vectorNormalize(_id_8B608C6B5E96C8E4 - _id_06A277D0D2E8D5DF);
    _id_E05DFAD1728E7B21 = scripts\mp\utility\script::vectortoanglessafe(_id_6841474D6FED394F, (0, 0, 1));
    level.spawncameras["default"]["axis"].origin = _id_06A277D0D2E8D5DF;
    level.spawncameras["default"]["axis"].angles = _id_E05DFAD1728E7B21;
  }
}

_id_9DD9773C51F39A12() {
  if(level._id_7DCA174E7F878079 > 0)
    return level._id_7DCA174E7F878079;

  switch (level.mapname) {
    case "mp_fort":
      return 3000;
    default:
      return 0;
  }
}

orientdefaulttofrontline() {
  _id_2005D12681400473 = scripts\mp\utility\teams::getfriendlyplayers("allies", 1);
  _id_AAC62807B84149B5 = level.spawncamerastartspawnallies;

  if(_id_2005D12681400473.size > 0) {
    _id_AAC62807B84149B5 = (0, 0, 0);

    foreach(player in _id_2005D12681400473)
    _id_AAC62807B84149B5 = _id_AAC62807B84149B5 + player.origin;

    _id_AAC62807B84149B5 = _id_AAC62807B84149B5 / _id_2005D12681400473.size;
  }

  _id_650728BA49299C62 = scripts\mp\utility\teams::getfriendlyplayers("axis", 1);
  _id_E4C7B343246F2158 = level.spawncamerastartspawnaxis;

  if(_id_650728BA49299C62.size > 0) {
    _id_E4C7B343246F2158 = (0, 0, 0);

    foreach(player in _id_650728BA49299C62)
    _id_E4C7B343246F2158 = _id_E4C7B343246F2158 + player.origin;

    _id_E4C7B343246F2158 = _id_E4C7B343246F2158 / _id_650728BA49299C62.size;
  }

  _id_D711E0E99DD33B05 = _id_E4C7B343246F2158 - _id_AAC62807B84149B5;
  _id_447333ACCCB3F053 = vectorNormalize(_id_D711E0E99DD33B05);
  _id_3C61D0A28315E5A6 = vectordot(_id_D711E0E99DD33B05, _id_D711E0E99DD33B05);

  if(_id_3C61D0A28315E5A6 < 1048576) {
    return;
  }
  _id_74A2D868CFE3A64E = level.mapcornercenter + _id_447333ACCCB3F053 * level.spawncameradistfactor * -0.5 + (0, 0, 1) * level.spawncameradistfactor * 0.2;
  _id_6841474D6FED394F = vectorNormalize(level.mapcornercenter - _id_74A2D868CFE3A64E);
  _id_9AE75568303E010C = scripts\mp\utility\script::vectortoanglessafe(_id_6841474D6FED394F, (0, 0, 1));
  level.spawncameras["default"]["allies"].origin = _id_74A2D868CFE3A64E;
  level.spawncameras["default"]["allies"].angles = _id_9AE75568303E010C;
  _id_06A277D0D2E8D5DF = level.mapcornercenter + _id_447333ACCCB3F053 * level.spawncameradistfactor * 0.5 + (0, 0, 1) * level.spawncameradistfactor * 0.2;
  _id_6841474D6FED394F = vectorNormalize(level.mapcornercenter - _id_06A277D0D2E8D5DF);
  _id_E05DFAD1728E7B21 = scripts\mp\utility\script::vectortoanglessafe(_id_6841474D6FED394F, (0, 0, 1));
  level.spawncameras["default"]["axis"].origin = _id_06A277D0D2E8D5DF;
  level.spawncameras["default"]["axis"].angles = _id_E05DFAD1728E7B21;
  thread scripts\mp\utility\debug::drawline(_id_74A2D868CFE3A64E, level.mapcornercenter, 60.0, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(_id_06A277D0D2E8D5DF, level.mapcornercenter, 60.0, (1, 0, 0));
}

calulatefrontline() {
  _id_2005D12681400473 = scripts\mp\utility\teams::getfriendlyplayers("allies", 1);
  _id_AAC62807B84149B5 = getstartspawnavg("allies");

  if(_id_2005D12681400473.size > 0) {
    _id_AAC62807B84149B5 = (0, 0, 0);

    foreach(player in _id_2005D12681400473)
    _id_AAC62807B84149B5 = _id_AAC62807B84149B5 + player.origin;

    _id_AAC62807B84149B5 = _id_AAC62807B84149B5 / _id_2005D12681400473.size;
  }

  _id_650728BA49299C62 = scripts\mp\utility\teams::getfriendlyplayers("axis", 1);
  _id_E4C7B343246F2158 = getstartspawnavg("axis");

  if(_id_650728BA49299C62.size > 0) {
    _id_E4C7B343246F2158 = (0, 0, 0);

    foreach(player in _id_650728BA49299C62)
    _id_E4C7B343246F2158 = _id_E4C7B343246F2158 + player.origin;

    _id_E4C7B343246F2158 = _id_E4C7B343246F2158 / _id_650728BA49299C62.size;
  }

  _id_D711E0E99DD33B05 = _id_E4C7B343246F2158 - _id_AAC62807B84149B5;
  _id_447333ACCCB3F053 = vectorNormalize(_id_D711E0E99DD33B05);
  frontlineinfo = spawnStruct();
  frontlineinfo.origin = (_id_AAC62807B84149B5 + _id_E4C7B343246F2158) * 0.5;
  frontlineinfo.angles = vectorcross(_id_447333ACCCB3F053, (0, 0, 1));
  frontlineinfo.teamavg = [];
  frontlineinfo.teamavg["allies"] = _id_AAC62807B84149B5;
  frontlineinfo.teamavg["axis"] = _id_E4C7B343246F2158;
  return frontlineinfo;
}

getstartspawnavg(team, classname) {
  if(isDefined(level.startspawnavg) && isDefined(level.startspawnavg[team]))
    return level.startspawnavg[team];

  if(!isDefined(level.startspawnavg))
    level.startspawnavg = [];

  level.startspawnavg[team] = (0, 0, 0);

  if(isDefined(classname))
    _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray(classname);
  else
    _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + team + "_start");

  _id_B71BF0010307A61C = (0, 0, 0);

  foreach(s in _id_29D9D2428185616D)
  _id_B71BF0010307A61C = _id_B71BF0010307A61C + s.origin;

  if(_id_29D9D2428185616D.size > 0)
    _id_B71BF0010307A61C = _id_B71BF0010307A61C / _id_29D9D2428185616D.size;

  level.startspawnavg[team] = _id_B71BF0010307A61C;
  return level.startspawnavg[team];
}

angle_diff(_id_456C3AB4CCDC8D5D, _id_456C37B4CCDC86C4) {
  return 180 - abs(abs(_id_456C3AB4CCDC8D5D - _id_456C37B4CCDC86C4) - 180);
}

_id_BF0E17930D534AB1() {
  return scripts\mp\utility\game::getgametype() == "risk" || scripts\mp\utility\game::isgroundwarcoremode();
}

_id_71A2A6A6F52AB30B(_id_204E074713EB37B5, team, forward, _id_0EAF618DB8FDDBE9, heightoffset) {
  foreach(key in _id_204E074713EB37B5) {
    if(istrue(level.useunifiedspawnselectioncameraheight))
      heightoffset = scripts\mp\spawnselection::_id_87BBBEE0BBF27304();

    if(istrue(level.usespawnselection))
      groundpos = level.spawnselectionlocations[key][team].anchorentity.origin;
    else if(isDefined(level.spawncameras[key][team]))
      groundpos = level.spawncameras[key][team].origin;
    else
      return;

    camerapos = groundpos + forward * _id_0EAF618DB8FDDBE9 + (0, 0, heightoffset);
    _id_6D399A908D913B0B = vectorNormalize(groundpos - camerapos);
    cameraang = scripts\mp\utility\script::vectortoanglessafe(_id_6D399A908D913B0B, (0, 0, 1));
    camerapos = camerapos + calculatecameraoffset(team, groundpos);

    if(!isDefined(level.spawncameras[key]))
      level.spawncameras[key] = [];

    if(!isDefined(level.spawncameras[key][team]))
      level.spawncameras[key][team] = spawn("script_origin", (0, 0, 0));

    level.spawncameras[key][team].origin = camerapos;
    level.spawncameras[key][team].angles = cameraang;
  }
}

calculatecameraoffset(team, _id_800054CA1A89DACE) {
  switch (level.mapname) {
    case "mp_quarry2":
      _id_FC87D6FC10744D44 = 0.25;
      _id_6E9B9701B439AEB7 = 0.35;
      break;
    case "mp_farms2":
      _id_FC87D6FC10744D44 = 0.25;
      _id_6E9B9701B439AEB7 = 0.8;
      break;
    case "mp_aniyah":
      _id_FC87D6FC10744D44 = 0.5;
      _id_6E9B9701B439AEB7 = 0.3;
      break;
    default:
      _id_FC87D6FC10744D44 = 0.0;
      _id_6E9B9701B439AEB7 = 0.0;
      break;
  }

  _id_46F432042B3473D8 = distance(_id_800054CA1A89DACE, level.hqmidpoint);

  if(_id_46F432042B3473D8 < 2048)
    return (0, 0, 0);

  if(team == "axis") {
    _id_4881F7FE7FC2BAE2 = distance(level.gw_objstruct.axishqloc.trigger.origin, _id_800054CA1A89DACE);
    _id_3B776694EEAC2BEB = level.hqvecttomid_axis;
  } else {
    _id_4881F7FE7FC2BAE2 = distance(level.gw_objstruct.allieshqloc.trigger.origin, _id_800054CA1A89DACE);
    _id_3B776694EEAC2BEB = level.hqvecttomid_allies;
  }

  if(_id_4881F7FE7FC2BAE2 < 2048)
    return _id_3B776694EEAC2BEB * _id_FC87D6FC10744D44;

  if(_id_4881F7FE7FC2BAE2 > level.hqdisttomid) {
    if(team == "axis")
      _id_4881F7FE7FC2BAE2 = distance(level.gw_objstruct.allieshqloc.trigger.origin, _id_800054CA1A89DACE);
    else
      _id_4881F7FE7FC2BAE2 = distance(level.gw_objstruct.axishqloc.trigger.origin, _id_800054CA1A89DACE);

    _id_2BF3C98575BA0BE1 = 100 - _id_4881F7FE7FC2BAE2 * 100 / level.hqdisttomid;
    offset = _id_3B776694EEAC2BEB * _id_6E9B9701B439AEB7 * -1.0 * (_id_2BF3C98575BA0BE1 / 100);
    return offset;
  } else {
    _id_2BF3C98575BA0BE1 = 100 - _id_4881F7FE7FC2BAE2 * 100 / level.hqdisttomid;
    offset = _id_3B776694EEAC2BEB * _id_FC87D6FC10744D44 * (_id_2BF3C98575BA0BE1 / 100);
    return offset;
  }
}

_id_581A8FC6F76D525D() {
  return !istrue(level.disablespawncamera) && istrue(scripts\mp\flags::gameflag("prematch_done")) && !istrue(self.skipspawncamera) && !istrue(level.usespawnselection);
}

_id_CDFF2F0B5DCF3AA1() {
  self._id_1305AD103FDD8962 = 1;
  _id_0DC51DE4E8CBD07B = getspawncamera();
  _id_11F3B4465C8B637B = _id_2CEDCC356F1B9FC8::playerstreamhintlocation(_id_0DC51DE4E8CBD07B.origin);
}