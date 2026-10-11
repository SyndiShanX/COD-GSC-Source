/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\spawncamera.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\arm;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\playerlogic;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnselection;
#using scripts\mp\spectating;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#namespace spawncamera;

function init() {
  if(!isDefined(level.disablespawncamera)) {
    level.disablespawncamera = getdvarint(@ "scr_game_disablespawncamera", 1) == 1;
  }

  level.snaptospawncamera = getdvarint(@ "hash_1a2c3b67392b6657", 1) == 1;
  level.evaluatefrontline = getdvarint(@ "hash_405e7e20d91344cc", 0) == 1;
  level.evaluatespawnforcameraselection = getdvarint(@ "hash_c7c93411ff36195c", 1) == 1;
  level.usestaticspawnselectioncamera = getdvarint(@ "hash_67329f458977df45", 0);
  level.var_45abec6de5366021 = getdvarvector(@ "hash_ee64455059eaeef8", (0, 0, 0));

  if(length(level.var_45abec6de5366021) < 1) {
    level.var_45abec6de5366021 = undefined;
  }

  level.var_7b73a66e2d4ca32f = getdvarvector(@ "hash_f1fe5a0456713312", (0, 0, 0));

  if(length(level.var_7b73a66e2d4ca32f) < 1) {
    level.var_7b73a66e2d4ca32f = undefined;
  }

  level.useunifiedspawnselectioncameraheight = getdvarint(@ "hash_9d6d762163aa3df", 1);
  level.var_7dca174e7f878079 = getdvarint(@ "hash_119957cbc3ce1a03", 0);

  if(!isDefined(level.var_1063c425ddab3330)) {
    level.var_1063c425ddab3330 = &createdefaultcameras;
  }

  if(!isDefined(level.updatedefaultcamera)) {
    level.updatedefaultcamera = &blank_func;
  }

  if(!isDefined(level.updategamemodecamera)) {
    level.updategamemodecamera = &blank_func;
  }

  if(!istrue(level.disablespawncamera)) {
    initcameras();
  }
}

function blank_func() {}

function initcameras() {
  level.spawncameras = [];
  level.currentcamera = [];

  foreach(entry in level.teamnamelist) {
    if(scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e() && level.mapname == "mp_don3_mobile") {
      level.currentcamera[entry] = scripts\cp_mp\utility\game_utility::getlocaleid();
      continue;
    }

    level.currentcamera[entry] = "default";
  }

  cameras = getStructArray("spawn_selection_camera", "targetname");

  if(cameras.size == 0 || level.mapname == "mp_aniyah_tac") {
    [[level.var_1063c425ddab3330]]();
    level.var_1091b5d43ba7a905 = 1;
    return;
  }

  foreach(camera in cameras) {
    ref = camera.script_label;

    if(!isDefined(ref) || ref == "spawn_selection_camera") {
      ref = camera.script_noteworthy;
    }

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      locale = camera.script_noteworthy;

      if(!isDefined(locale) || isDefined(locale) && locale != level.localeid) {
        continue;
      }
    }

    if(!isDefined(level.spawncameras[ref])) {
      level.spawncameras[ref] = [];
    }

    team = camera.script_team;

    if(team == "all") {
      foreach(entry in level.teamnamelist) {
        level.spawncameras[ref][entry] = camera;
      }

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

  [[level.var_1063c425ddab3330]]();
  level.var_1091b5d43ba7a905 = 1;
}

function createdefaultcameras() {
  if(isDefined(level.spawncameras["default"])) {
    allfound = 1;

    foreach(entry in level.teamnamelist) {
      if(!isDefined(level.spawncameras["default"][entry])) {
        allfound = 0;
        break;
      }
    }

    if(allfound) {
      return;
    }
  } else {
    level.spawncameras["default"] = [];
  }

  cornercenter = (0, 0, 0);

  if(isDefined(level.mapcorners) && isDefined(level.mapcorners[0]) && isDefined(level.mapcorners[1])) {
    level.mapcornervector = level.mapcorners[1].origin - level.mapcorners[0].origin;
    level.mapcornercenter = level.mapcorners[0].origin + level.mapcornervector * 0.5;
  }

  foreach(entry in level.teamnamelist) {
    if(isDefined(level.spawncameras["default"][entry])) {
      level.spawncameras["default"][entry].radiantplaced = 1;
      continue;
    }

    camerastruct = spawnStruct();
    camerastruct.origin = (0, 0, 0);
    camerastruct.angles = (0, 0, 0);
    level.spawncameras["default"][entry] = camerastruct;
  }

  level.spawncamerastartspawnallies = getstartspawnavg("allies");
  level.spawncamerastartspawnaxis = getstartspawnavg("axis");
  level.spawncamerastartspawnaxisang = ter_op(distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[0].origin) < distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[1].origin), level.mapcorners[0].angles, level.mapcorners[1].angles);
  spawnvector = level.spawncamerastartspawnaxis - level.spawncamerastartspawnallies;
  spawncenter = level.spawncamerastartspawnallies + spawnvector * 0.5;

  if(distancesquared(level.spawncamerastartspawnallies, level.mapcorners[0].origin) < distancesquared(level.spawncamerastartspawnallies, level.mapcorners[1].origin)) {
    cornerfwd = anglesToForward(level.mapcorners[0].angles);
    cornerright = anglestoright(level.mapcorners[0].angles);

    if(abs(vectordot(spawnvector, cornerfwd)) > abs(vectordot(spawnvector, cornerright))) {
      level.spawncamerastartspawnalliesvec = cornerfwd;
    } else {
      level.spawncamerastartspawnalliesvec = cornerright;
    }
  } else {
    cornerfwd = anglesToForward(level.mapcorners[1].angles);
    cornerright = anglestoright(level.mapcorners[1].angles);

    if(abs(vectordot(spawnvector, cornerfwd)) > abs(vectordot(spawnvector, cornerright))) {
      level.spawncamerastartspawnalliesvec = cornerfwd;
    } else {
      level.spawncamerastartspawnalliesvec = cornerright;
    }
  }

  if(distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[0].origin) < distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[1].origin)) {
    cornerfwd = anglesToForward(level.mapcorners[0].angles);
    cornerright = anglestoright(level.mapcorners[0].angles);

    if(abs(vectordot(spawnvector, cornerfwd)) > abs(vectordot(spawnvector, cornerright))) {
      level.spawncamerastartspawnaxisvec = cornerfwd;
    } else {
      level.spawncamerastartspawnaxisvec = cornerright;
    }
  } else {
    cornerfwd = anglesToForward(level.mapcorners[1].angles);
    cornerright = anglestoright(level.mapcorners[1].angles);

    if(abs(vectordot(spawnvector, cornerfwd)) > abs(vectordot(spawnvector, cornerright))) {
      level.spawncamerastartspawnaxisvec = cornerfwd;
    } else {
      level.spawncamerastartspawnaxisvec = cornerright;
    }
  }

  spawndist = distance(level.spawncamerastartspawnallies, level.spawncamerastartspawnaxis);
  level.spawncameradistfactor = spawndist;
  orientdefaulttomapcenterusingmapcorners();
}

function createspawncamera() {
  if(isDefined(level.updatedefaultcamera)) {
    [[level.updatedefaultcamera]]();
  }

  if(isDefined(level.updategamemodecamera)) {
    self[[level.updategamemodecamera]]();
  }

  spectatepos = self.origin + (0, 0, 60);
  var_6788dc28320974a = self.angles;

  if(isDefined(self.squadspectatepos)) {
    self.deathspectatepos = self.squadspectatepos;
    self.deathspectateangles = self.squadspectateang;
  } else {
    self.deathspectatepos = spectatepos;
    self.deathspectateangles = var_6788dc28320974a;
  }

  if(!isDefined(self.spawncameraent)) {
    cameraent = spawn("script_model", self.deathspectatepos);
    cameraent scripts\cp_mp\ent_manager::registerspawncount(1);
    cameraent setModel("tag_origin");
    cameraent.angles = self.deathspectateangles;
    self.spawncameraent = cameraent;
    return;
  }

  self.spawncameraent.origin = self.deathspectatepos;
  self.spawncameraent.angles = self.deathspectateangles;
}

function startspawncamera(var_ad4dd16f29e24b77, holdduration, var_dfab0807d83a77fe) {
  self endon("disconnect");
  printspawnmessage("spawnCamera::startSpawnCamera() START");
  hideminimap(1);
  self cleardamageindicators();

  if(!(istrue(self.inspawncamera) && getdvarint(@ "hash_7958073a99a0d67e", 1) == 1)) {
    createspawncamera();
  }

  if(!isDefined(self.spawncameraent)) {
    printspawnmessage("spawnCamera::startSpawnCamera() UNDEFINED SPAWNCAMERAENT!!!");
    thread playslamzoomflash(0, getspawncamerawaittime(), 0.5);
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
  setdof_default();
  waitframe();
  scripts\mp\spectating::setdisabled();
  updatesessionstate("spectator");
  self setclientomnvar("ui_in_spawn_camera", 1);

  if(!isDefined(var_ad4dd16f29e24b77)) {
    var_ad4dd16f29e24b77 = 0;
  }

  if(!isDefined(holdduration)) {
    holdduration = 0.25;
  }

  if(!isDefined(var_dfab0807d83a77fe)) {
    var_dfab0807d83a77fe = 0.25;
  }

  thread playslamzoomflash(var_ad4dd16f29e24b77, holdduration, var_dfab0807d83a77fe);
  thread removecameraondisconnect(self.spawncameraent);
  waittill_any_timeout_no_endon_death_1(0.1, "force_spawn");
  self cameralinkTo(self.spawncameraent, "tag_origin", 1, 1);
  printspawnmessage("spawnCamera::startSpawnCamera() CameralinkTo()");
  self clearadditionalstreampos();
  thread snaptospawncamera();
}

function getspawncamerawaittime() {
  if(isDefined(self.spawncameratime)) {
    return self.spawncameratime;
  }

  if(istrue(self.squadspawnaborted) || !istrue(level.snaptospawncamera) && (istrue(self.skippedkillcam) || !isDefined(self.killcamwatchtime) || self.killcamwatchtime < 2)) {
    return 2.5;
  }

  return 1.5;
}

function getspawncamerablendtime() {
  return true;
}

function getspawncamera() {
  if(istrue(self.var_1305ad103fdd8962) && isDefined(self.var_d309f60efb44e349)) {
    return self.var_d309f60efb44e349;
  }

  spawncamera = undefined;
  team = self.team;

  if(!isDefined(team)) {
    team = self.sessionteam;
  }

  if(!isgameplayteam(team)) {
    printspawnmessage("spawncamera::getSpawnCamera() - !isGameplayTeam() = " + team + "camera was undefined, forcing allies default");
    spawncamera = level.spawncameras["default"]["allies"];
    return spawncamera;
  }

  if(function_bf0e17930d534ab1()) {
    self.forcedspawncameraref = "default";
  }

  if(istrue(level.usestaticspawnselectioncamera)) {
    level.currentcamera[team] = "default";
    spawncamera = level.spawncameras[level.currentcamera[team]][team];
    temp = scripts\mp\spawnselection::getstaticcameraposition(team);
    spawncamera.origin = temp.origin;
    spawncamera.angles = temp.angles;
  } else if(isDefined(self.forcedspawncameraref)) {
    if(isDefined(level.spawncameras[self.forcedspawncameraref])) {
      spawncamera = level.spawncameras[self.forcedspawncameraref][team];
    } else if(issubstr(self.forcedspawncameraref, "squad")) {
      ref = self.forcedspawncameraref;

      if(ref == "squad_leader") {
        index = level.squaddata[team][self.sessionsquadid].squadleader.sessionuimemberindex;
      } else {
        index = int(getsubstr(ref, ref.size - 1, ref.size));
      }

      goalplayer = undefined;

      if(isDefined(level.squaddata[team]) && isDefined(level.squaddata[team][self.sessionsquadid]) && isDefined(level.squaddata[team][self.sessionsquadid].players[index])) {
        goalplayer = level.squaddata[team][self.sessionsquadid].players[index];
      }

      if(isDefined(goalplayer)) {
        forward = level.spawnselectionteamforward[team];
        heightoffset = 7000;

        if(istrue(level.useunifiedspawnselectioncameraheight)) {
          heightoffset = scripts\mp\spawnselection::function_87bbbee0bbf27304();
        }

        goalposition = goalplayer.origin + forward * -8500 + (0, 0, heightoffset);
        goalvector = vectorNormalize(goalplayer.origin - goalposition);
        goalangles = vectortoanglessafe(goalvector, (0, 0, 1));
        goalposition += scripts\mp\gametypes\arm::calculatecameraoffset(team, goalplayer.origin);
        spawncamera = spawnStruct();
        spawncamera.origin = goalposition;
        spawncamera.angles = goalangles;
      }
    } else if(issubstr(self.forcedspawncameraref, "vehicle")) {
      ref = self.forcedspawncameraref;
      vehicleent = undefined;

      if(isDefined(level.spawnselectionlocations[ref]) && isDefined(level.spawnselectionlocations[ref][team])) {
        vehicleent = level.spawnselectionlocations[ref][team].dynamicent;
      }

      forward = level.spawnselectionteamforward[team];

      if(isDefined(vehicleent) && !istrue(vehicleent.isdestroyed)) {
        goalposition = [];
        goalangles = [];
        heightoffset = 7000;

        if(istrue(level.useunifiedspawnselectioncameraheight)) {
          heightoffset = scripts\mp\spawnselection::function_87bbbee0bbf27304();
        }

        goalposition = vehicleent.origin + forward * -8500 + (0, 0, heightoffset);
        groundpos = level.spawnselectionlocations[ref][team].anchorentity.origin;
        camerapos = groundpos + forward * -8500 + (0, 0, heightoffset);
        toground = vectorNormalize(groundpos - camerapos);
        goalangles = vectortoanglessafe(toground, (0, 0, 1));
        goalposition += scripts\mp\gametypes\arm::calculatecameraoffset(team, groundpos);
        spawncamera = spawnStruct();
        spawncamera.origin = goalposition;
        spawncamera.angles = goalangles;
      }
    }
  } else if(istrue(level.evaluatespawnforcameraselection) && isDefined(level.lastspawnpos) && isDefined(level.lastspawnpos[team])) {
    testpos = level.lastspawnpos[team];
    closestdistsq = undefined;
    closestcam = undefined;

    foreach(team, cam in level.spawncameras[level.currentcamera[team]]) {
      distsq = distancesquared(cam.origin, testpos);

      if(!isDefined(closestcam) || distsq < closestdistsq) {
        closestcam = cam;
        closestdistsq = distsq;
      }
    }

    spawncamera = closestcam;
  } else if(istrue(level.evaluatefrontline)) {
    frontlineinfo = calulatefrontline();
    closestdistsq = undefined;
    closestcam = undefined;

    foreach(team, cam in level.spawncameras[level.currentcamera[team]]) {
      teamdistsq = distancesquared(cam.origin, frontlineinfo.teamavg[team]);
      frontlinedistsq = distancesquared(cam.origin, frontlineinfo.origin);

      if(!isDefined(closestcam) || teamdistsq < frontlinedistsq) {
        closestcam = cam;
        closestdistsq = teamdistsq;
      }
    }

    spawncamera = closestcam;
  } else {
    if(istrue(level.usec130spawn)) {
      while(!isDefined(level.currentcamera[team])) {
        waitframe();
      }
    }

    if(!isstring(level.currentcamera[team])) {
      spawncamera = spawnStruct();
      spawncamera.origin = level.currentcamera[team].origin;
      spawncamera.angles = level.currentcamera[team].angles;
      spawncamera.usingintermissionpos = 1;
    } else {
      spawncamera = level.spawncameras[level.currentcamera[team]][team];
    }
  }

  if(!isDefined(spawncamera)) {
    printspawnmessage("spawncamera::getSpawnCamera() - self.forcedSpawnCameraRef = " + self.forcedspawncameraref + "camera was undefined, forcing default");
    spawncamera = level.spawncameras["default"][team];
  }

  self.var_d309f60efb44e349 = spawncamera;
  return spawncamera;
}

function movetospawncamerainitial() {
  self endon("disconnect");
  self notify("newMoveToSpawnCameraInitiated");
  self endon("newMoveToSpawnCameraInitiated");
  self endon("tac_ops_spawn_focus_changed");
  self endon("slamZoomInitiated");
  spawncamera = getspawncamera();
  spawncamerapos = spawncamera.origin;
  spawncameraang = spawncamera.angles;
  lookatpos = self.spawncameraent.origin;
  var_832ded18d6904999 = vectorNormalize(lookatpos - spawncamera.origin);
  var_318eea579595b65e = vectortoanglessafe(var_832ded18d6904999, (0, 0, 1));
  self.spawncameraent.angles = var_318eea579595b65e;
  dist = distance(lookatpos, spawncamerapos);
  time = dist / 3520;
  time = clamp(time, 1.5, 3);
  self.spawncameratargetpos = spawncamerapos;
  self.spawncameratargetang = spawncameraang;
  self.spawncameratime = time;
  self.spawncameraendtime = gettime() + time * 1000;

  if(!istrue(spawncamera.usingintermissionpos)) {
    self.spawncameraent moveTo(spawncamerapos, time, time * 0.3, time * 0.4);
    self.spawncameraent rotateTo(spawncameraang, time, time * 0.3, time * 0.4);
    wait 1;
  } else {
    self.spawncameraent.origin = spawncamerapos;
    self.spawncameraent.angles = spawncameraang;
    self.deathspectatepos = spawncamerapos;
  }

  applythermal();
  thread startoperatorsound();

  if(isDefined(self) && isDefined(self.spawncameraent) && !istrue(self.inspawnselection)) {
    var_ae753108f3dff053 = anglesToForward(spawncameraang) * 300;
    var_ae753108f3dff053 *= (1, 1, 0);
    self earthquakeforplayer(0.03, 15, spawncamerapos, 1000);
  }

  self notify("spawn_camera_idle");
}

function movetospawncamera(var_7c207c285f05dbb2) {
  self endon("disconnect");
  self notify("newMoveToSpawnCameraInitiated");
  self endon("newMoveToSpawnCameraInitiated");
  self endon("tac_ops_map_selection_valid");
  self endon("tac_ops_spawn_focus_changed");
  self endon("slamZoomInitiated");
  spawncamera = getspawncamera();
  spawncamerapos = spawncamera.origin;
  spawncameraang = spawncamera.angles;

  if(isDefined(self.spawncameratargetpos) && isDefined(self.spawncameratargetang) && self.spawncameratargetpos == spawncamerapos && self.spawncameratargetang == spawncameraang) {
    return;
  }

  lookatpos = self.spawncameraent.origin;
  var_832ded18d6904999 = vectorNormalize(lookatpos - spawncamera.origin);
  self.spawncameratargetpos = spawncamerapos;
  self.spawncameratargetang = spawncameraang;
  self.spawncameraent moveTo(spawncamerapos, 1, 0.25, 0.75);
  self.spawncameraent rotateTo(spawncameraang, 1, 0.25, 0.75);
  wait 1;

  if(isDefined(self) && isDefined(self.spawncameraent) && !istrue(self.inspawnselection)) {
    var_ae753108f3dff053 = anglesToForward(spawncameraang) * 300;
    var_ae753108f3dff053 *= (1, 1, 0);
    self.spawncameraent moveTo(spawncamerapos + var_ae753108f3dff053, 15, 1, 1);
    self earthquakeforplayer(0.03, 15, spawncamerapos, 1000);
  }

  printspawnmessage("spawnCamera::moveToSpawnCamera() moveTo(): " + spawncamerapos + ", + rotateTo(): " + spawncameraang);
  self notify("spawn_camera_idle");
}

function snaptospawncamera() {
  self endon("disconnect");

  while(!istrue(self.cansnapcamera)) {
    waitframe();
  }

  spawncamera = getspawncamera();
  self.spawncameraent dontinterpolate();
  self.spawncameraent.origin = spawncamera.origin;
  self.spawncameraent.angles = spawncamera.angles;

  if(isDefined(spawncamera.var_6930961c8a8d33fc)) {
    thread scripts\mp\gametypes\br_public::playerstreamhintlocation(spawncamera.var_6930961c8a8d33fc);
  }

  if(!istrue(level.nukeinfo.detonated)) {
    self visionsetnakedforplayer("", 0);
  }

  applythermal();
  thread startoperatorsound();

  if(isDefined(self) && isDefined(self.spawncameraent) && !istrue(self.inspawnselection)) {
    var_ae753108f3dff053 = anglesToForward(self.spawncameraent.angles) * 300;
    var_ae753108f3dff053 *= (1, 1, 0);
    self.spawncameraent moveTo(self.spawncameraent.origin + var_ae753108f3dff053, 15, 1, 1);
    self earthquakeforplayer(0.03, 15, self.spawncameraent.origin, 1000);
  }

  printspawnmessage("spawnCamera::snapToSpawnCamera() Origin: " + spawncamera.origin + ", Angles: " + spawncamera.angles);
  self notify("spawn_camera_idle");
}

function endspawncamera() {
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

  if(istrue(self.var_f9cd51a4708ec70f)) {
    deletespawncamera();
    return;
  }

  hideminimap(1);
  thread streamforslamzoomonspawn();
  runslamzoomonspawn();
}

function deletespawncamera() {
  self cameraunlink();
  self.spawncameraent scripts\cp_mp\ent_manager::deregisterspawn();
  self.spawncameraent delete();
  self.spawncameraent = undefined;
  self.isusingspawnmapcamera = undefined;
  self.inspawncamera = 0;
  self.var_d309f60efb44e349 = undefined;
  self notify("spawn_camera_deleted");
}

function removecameraondisconnect(cameraent) {
  self endon("spawn_camera_deleted");
  self waittill("disconnect");

  if(isDefined(cameraent)) {
    cameraent scripts\cp_mp\ent_manager::deregisterspawn();
    cameraent delete();
  }
}

function streamforslamzoomonspawn() {
  self endon("disconnect");
  self waittill("spawncamera_start");

  if(istrue(self.prestreaminglocation)) {
    self notify("playerPrestreamLocationWait");
    self.prestreaminglocation = undefined;
    self notify("playerPrestreamComplete");
  }

  self function_a304dc5184b0df29(0);
  self predictstreamposuntilcleared(self getEye());
  self waittill("spawn_camera_complete");
  self clearpredictedstreampos();
  self function_a304dc5184b0df29(1);
}

function runslamzoomonspawn(var_595879a0845617f6) {
  self endon("disconnect");
  printspawnmessage("spawnCamera::runSlamZoomOnspawn() START");
  self waittill("spawncamera_start");
  printspawnmessage("spawnCamera::runSlamZoomOnspawn() spawncamera_start PASSED");
  self notify("slamZoomInitiated");
  _freezecontrols(1, undefined, "slamZoom");
  scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
  scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("spawncamera::runSlamZoomOnspawn()");
  self useinvisibleplayerduringspawnselection(1);
  self.plotarmor = 1;
  val::set("slamZoom", "vehicle_use", 0);
  scripts\mp\spectating::setdisabled();
  updatesessionstate("spectator");
  self cameralinkTo(self.spawncameraent, "tag_origin", 1);
  printspawnmessage("spawnCamera::runSlamZoomOnspawn() CameralinkTo()");
  handlemovetoblended();
  deletespawncamera();

  if(self.team == "spectator") {
    scripts\mp\playerlogic::removefromalivecount();
    self setclientomnvar("ui_in_spawn_camera", 0);

    if(!istrue(level.nukeinfo.detonated)) {
      self visionsetnakedforplayer("", 0.5);
    }

    _freezecontrols(0, undefined, "slamZoom");
    self useinvisibleplayerduringspawnselection(0);
    self.plotarmor = 0;
    thread scripts\mp\spectating::setspectatepermissions();
    return;
  }

  updatesessionstate("playing");

  if(istrue(self.shouldgetnewspawnpoint)) {
    spawnpoint = scripts\mp\playerlogic::getspawnpoint();
    self setOrigin(spawnpoint.spawnorigin);
    self setplayerangles(spawnpoint.spawnangles);
    scripts\mp\spawnlogic::finalizespawnpointchoice(spawnpoint.spawnpoint);
    self.shouldgetnewspawnpoint = undefined;
    self.selectedspawnarea = undefined;
  }

  thread function_d28ef4117a443666();
  self setclientomnvar("ui_in_spawn_camera", 0);

  if(!istrue(level.nukeinfo.detonated)) {
    self visionsetnakedforplayer("", 0.5);
  }

  _freezecontrols(0, undefined, "slamZoom");
  scripts\cp_mp\utility\player_utility::function_6fb380927695ee76();
  scripts\cp_mp\utility\player_utility::function_985b0973f29da4f8("spawncamera::runSlamZoomOnspawn()");
  self useinvisibleplayerduringspawnselection(0);
  self.plotarmor = 0;
  val::reset_all("slamZoom");
  self notify("spawned_player");
  level notify("player_spawned", self, self.wasrevivespawn);
  thread scripts\mp\playerlogic::setspawnnotifyomnvar();
  self.wasrevivespawn = undefined;
  self.delayedspawnedplayernotify = undefined;
  self.spawndata = undefined;
  printspawnmessage("spawnCamera::runSlamZoomOnspawn() COMPLETE");
}

function function_d28ef4117a443666() {
  self endon("death_or_disconnect");

  if(isDefined(self.var_f109e15fae27ddc2) && isDefined(self.var_f109e15fae27ddc2.origin) && isDefined(self.var_f109e15fae27ddc2.angles) && isDefined(self.platformoffset)) {
    self setOrigin(self.var_f109e15fae27ddc2.origin + rotatevector(self.platformoffset, self.var_f109e15fae27ddc2.angles));
  }

  waitframe();

  if(isDefined(self.var_f109e15fae27ddc2) && isDefined(self.var_f109e15fae27ddc2.origin) && isDefined(self.var_f109e15fae27ddc2.angles) && isDefined(self.platformoffset)) {
    printspawnmessage("spawnCamera::runSlamZoomOnspawn() Set origin on moving platform\nPlatform vehicle type: " + default_to(self.var_f109e15fae27ddc2.targetname, "undefined") + "\n\tPlatform origin: " + self.var_f109e15fae27ddc2.origin + "\n\tPlatform angles: " + self.var_f109e15fae27ddc2.angles + "\n\tPlatform offset: " + self.platformoffset + "\n\tFinal position: " + self.var_f109e15fae27ddc2.origin + rotatevector(self.platformoffset, self.var_f109e15fae27ddc2.angles));
    self function_a055801da45d769(self.var_f109e15fae27ddc2.origin + rotatevector(self.platformoffset, self.var_f109e15fae27ddc2.angles), self.var_f109e15fae27ddc2);
  }

  self.var_f109e15fae27ddc2 = undefined;
  self.platformoffset = undefined;
}

function handlemoveTo(duration) {
  self endon("disconnect");
  targetpos = self getEye();
  targetangles = self.angles;
  var_4158f3e6af3fc2e7 = (targetpos[0], targetpos[1], self.spawncameraent.origin[2]);
  var_4158f3e6af3fc2e7 += anglesToForward(targetangles) * -480;
  self.spawncameraent moveTo(var_4158f3e6af3fc2e7, 0.75, 0.25, 0.25);
  var_f10bfd0a124a36dc = vectorNormalize(targetpos - var_4158f3e6af3fc2e7);
  var_318eea579595b65e = vectortoanglessafe(var_f10bfd0a124a36dc, (0, 0, 1));
  self.spawncameraent rotateTo(var_318eea579595b65e, 0.75, 0.25, 0.25);
  wait 0.75;
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  behindspawnpos = targetpos + anglesToForward(targetangles) * -60;
  self.spawncameraent moveTo(behindspawnpos, 0.5, 0.1, 0.4);
  self.spawncameraent rotateTo(targetangles, 0.7, 0.45, 0.05);
  wait 0.5;
  thread playslamzoomflash();
  self.spawncameraent moveTo(targetpos, 0.6, 0.1, 0.1);
  wait 0.2;
  self visionsetnakedforplayer("", 0);
}

function handlemovetoblended(duration) {
  self endon("disconnect");
  self endon("kill_handle_move_to_blended");
  printspawnmessage("spawnCamera::handlemoveTo() START");

  if(isDefined(level.var_840e89b17ac632ee)) {
    self[[level.var_840e89b17ac632ee]]();
  }

  targetpos = self.spawndata.spawnorigin + (0, 0, 60);
  targetangles = self.spawndata.spawnangles;

  if(isDefined(self.forcespawncameraorg)) {
    targetpos = self.forcespawncameraorg;
    targetangles = self.forcespawncameraang;
    self.forcespawncameraorg = undefined;
    self.forcespawncameraang = undefined;
  }

  anglecheck = angle_diff(self.spawncameraent.angles[1], targetangles[1]) < 45;
  distcheck = distance2dsquared(self.spawncameraent.origin, targetpos) > 1000000;
  thread fadeblackforgeo(targetpos);

  if(!anglecheck || !distcheck) {
    if(!istrue(level.nukeinfo.detonated)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        removethermal();
        self visionsetnakedforplayer("", 0);
      } else {
        self visionsetnakedforplayer("respawn_camera_night", 0);
      }
    }

    wait 0.05;
    self.spawncameraent moveTo(targetpos, 1, 0.1, 0.9);
    self.spawncameraent rotateTo(targetangles, 1, 0.9, 0.1);
    printspawnmessage("spawnCamera::handlemoveTo() FULL Blend Set");

    if(!istrue(level.nukeinfo.detonated)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);
      }
    }

    wait 0.8;
    wait 0.2;
  } else {
    var_f10bfd0a124a36dc = vectorNormalize(targetpos - self.spawncameraent.origin);
    var_318eea579595b65e = vectortoanglessafe(var_f10bfd0a124a36dc, (0, 0, 1));
    self.spawncameraent rotateTo(var_318eea579595b65e, 0.7, 0.2, 0.2);
    printspawnmessage("spawnCamera::handlemoveTo() FIRST HALF Blend Set");

    if(!istrue(level.nukeinfo.detonated)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        removethermal();
        self visionsetnakedforplayer("", 0);
      } else {
        self visionsetnakedforplayer("respawn_camera_night", 0);
      }
    }

    wait 0.05;
    self.spawncameraent moveTo(targetpos, 1, 0.1, 0.9);

    if(!istrue(level.nukeinfo.detonated)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);
      }
    }

    wait 0.5;
    self.spawncameraent rotateTo(targetangles, 0.5, 0.2, 0.1);
    printspawnmessage("spawnCamera::handlemoveTo() SECOND HALF Blend Set");
    wait 0.3;
    wait 0.2;
  }

  printspawnmessage("spawnCamera::handlemoveTo() COMPLETE");
  self notify("spawn_camera_complete");
}

function fadeblackforgeo(targetpos) {
  self endon("disconnect");
  content = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  contentoverride = physics_createcontents(content);
  airtrace = scripts\engine\trace::ray_trace(self.spawncameraent.origin, targetpos, undefined, contentoverride);
  groundtrace = scripts\engine\trace::ray_trace(targetpos, self.spawncameraent.origin, undefined, contentoverride);
  airfrac = airtrace["fraction"];
  groundfrac = groundtrace["fraction"];
  var_4727e885c8a34003 = 0.11;

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
      airfrac = min(airfrac, 0.95);
      groundfrac = 0;
      var_4727e885c8a34003 = 0.75;
    } else {
      airfrac = min(airfrac, 0.95);
      groundfrac = 0;
    }
  }

  if(istrue(self.shouldgetnewspawnpoint)) {
    airfrac = min(airfrac, 0.5);
    groundfrac = 0;
    thread waitandgetnewspawnpoint();
  }

  if(airfrac < 1) {
    if(airfrac - 0.22 > 0) {
      wait airfrac - 0.22;
    }

    thread playslamzoomflash(0.1, 1 - airfrac - groundfrac + var_4727e885c8a34003, 0.25);
  }
}

function waitandgetnewspawnpoint() {
  self endon("disconnect");
  self waittill("fadeUp_start");
  self notify("kill_handle_move_to_blended");
}

function clear_plr_vehicle_submix() {
  self endon("disconnect");
  wait 1.5;
  self clearsoundsubmix("iw8_mp_vehicle_spawn", 1);
}

function playslamzoomflash(var_ad4dd16f29e24b77, holdduration, var_dfab0807d83a77fe) {
  self endon("disconnect");
  self.cansnapcamera = 0;

  if(!isDefined(var_dfab0807d83a77fe)) {
    var_dfab0807d83a77fe = 0.5;
  }

  self notify("fadeDown_start");

  if(isDefined(var_ad4dd16f29e24b77) && var_ad4dd16f29e24b77 > 0) {
    var_c8d49bba66d8db34 = 0;
    framecount = var_ad4dd16f29e24b77 / level.framedurationseconds;
    var_11b42fd8a12916ad = 1 / framecount;
    currentframe = 0;

    while(currentframe < framecount) {
      currentframe++;
      var_c8d49bba66d8db34 += var_11b42fd8a12916ad;
      var_c8d49bba66d8db34 = clamp(var_c8d49bba66d8db34, 0, 1);
      self setclientomnvar("ui_world_fade", var_c8d49bba66d8db34);
      waitframe();
    }
  }

  self notify("fadeDown_complete");
  self.cansnapcamera = 1;

  if(isDefined(holdduration) && holdduration > 0) {
    wait holdduration;
  }

  self notify("fadeUp_start");

  if(isDefined(var_dfab0807d83a77fe) && var_dfab0807d83a77fe > 0) {
    var_c8d49bba66d8db34 = 1;
    framecount = var_dfab0807d83a77fe / level.framedurationseconds;
    var_11b42fd8a12916ad = 1 / framecount;
    currentframe = 0;

    while(currentframe < framecount) {
      currentframe++;
      var_c8d49bba66d8db34 -= var_11b42fd8a12916ad;
      var_c8d49bba66d8db34 = clamp(var_c8d49bba66d8db34, 0, 1);
      self setclientomnvar("ui_world_fade", var_c8d49bba66d8db34);
      waitframe();
    }
  } else {
    self setclientomnvar("ui_world_fade", 0);
  }

  self notify("fadeUp_complete");
}

function movecameratomappos(player, var_9813182985677b23, finalangles) {
  self moveTo(var_9813182985677b23, 1, 0.5, 0.5);
  self rotateTo(finalangles, 1, 0.5, 0.5);
  player thread startoperatorsound();
  wait 1.1;
}

function applythermal() {
  if(istrue(self.spawncameraskipthermalonce)) {
    self.spawncameraskipthermalonce = 0;
    return;
  }

  if(istrue(self.spawncameraskipthermal)) {
    return;
  }

  if(!istrue(level.nukeinfo.detonated)) {
    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      self visionsetnakedforplayer("respawn_camera_night", 0);
      return;
    }

    self visionsetnakedforplayer("respawn_camera", 0);
  }
}

function removethermal() {}

function startoperatorsound() {
  self endon("disconnect");
  self endon("game_ended");

  if(isDefined(self.operatorsfx)) {
    return;
  }

  if(istrue(level.nukeinfo.incoming)) {
    return;
  }

  self.operatorsfx = spawn("script_origin", (0, 0, 0));
  self.operatorsfx showonlytoplayer(self);
  self setsoundsubmix("iw8_mp_spawn_camera");
  var_1d6df6a17cee3314 = getteamvoiceinfix(self.team);
  dronechatter = "dx_mpo_" + var_1d6df6a17cee3314 + "op_drone_deathchatter";

  if(!soundexists(dronechatter)) {
    dronechatter = "dx_mpo_ruop_drone_deathchatter";
  }

  self.operatorsfxalias = dronechatter;
  self.operatorsfx playLoopSound(dronechatter);
  thread endoperatorsfxondisconnect();
}

function endoperatorsfxondisconnect() {
  self endon("spawned_player");
  ent = self.operatorsfx;
  alias = self.operatorsfxalias;
  self waittill("disconnect");

  if(isDefined(ent)) {
    ent stoploopsound(alias);
    ent delete();
  }
}

function setgamemodecamera(team, cameraent) {
  level.spawncameras["gamemode"][team] = cameraent;
  setspawncamera(team, "gamemode");
}

function setspawncamera(team, ref) {
  level.currentcamera[team] = ref;
}

function orientdefaulttomapcenterusingmapcorners() {
  var_f3185b6ab68825a3 = (level.spawncamerastartspawnallies[2] + level.spawncamerastartspawnaxis[2]) * 0.5;
  var_8b608c6b5e96c8e4 = (level.mapcornercenter[0], level.mapcornercenter[1], var_f3185b6ab68825a3);

  if(!istrue(level.spawncameras["default"]["allies"].radiantplaced)) {
    heightoffset = function_9dd9773c51f39a12();

    if(heightoffset > 0) {
      alliescamerapos = var_8b608c6b5e96c8e4 + level.spawncamerastartspawnalliesvec * level.spawncameradistfactor * -0.85 + (0, 0, heightoffset);
    } else {
      alliescamerapos = var_8b608c6b5e96c8e4 + level.spawncamerastartspawnalliesvec * level.spawncameradistfactor * -0.85 + (0, 0, 1) * level.spawncameradistfactor * 0.45;
    }

    var_6841474d6fed394f = vectorNormalize(var_8b608c6b5e96c8e4 - alliescamerapos);
    var_9ae75568303e010c = vectortoanglessafe(var_6841474d6fed394f, (0, 0, 1));
    level.spawncameras["default"]["allies"].origin = alliescamerapos;
    level.spawncameras["default"]["allies"].angles = var_9ae75568303e010c;
  }

  if(!istrue(level.spawncameras["default"]["axis"].radiantplaced)) {
    heightoffset = function_9dd9773c51f39a12();

    if(heightoffset > 0) {
      axiscamerapos = var_8b608c6b5e96c8e4 + level.spawncamerastartspawnaxisvec * level.spawncameradistfactor * -0.85 + (0, 0, heightoffset);
    } else {
      axiscamerapos = var_8b608c6b5e96c8e4 + level.spawncamerastartspawnaxisvec * level.spawncameradistfactor * -0.85 + (0, 0, 1) * level.spawncameradistfactor * 0.45;
    }

    var_6841474d6fed394f = vectorNormalize(var_8b608c6b5e96c8e4 - axiscamerapos);
    var_e05dfad1728e7b21 = vectortoanglessafe(var_6841474d6fed394f, (0, 0, 1));
    level.spawncameras["default"]["axis"].origin = axiscamerapos;
    level.spawncameras["default"]["axis"].angles = var_e05dfad1728e7b21;
  }
}

function function_9dd9773c51f39a12() {
  if(level.var_7dca174e7f878079 > 0) {
    return level.var_7dca174e7f878079;
  }

  switch (level.mapname) {
    case #"hash_c860b74f2269590c":
      return 3000;
    default:
      return 0;
  }
}

function orientdefaulttofrontline() {
  alliesplayers = getfriendlyplayers("allies", 1);
  var_aac62807b84149b5 = level.spawncamerastartspawnallies;

  if(alliesplayers.size > 0) {
    var_aac62807b84149b5 = (0, 0, 0);

    foreach(player in alliesplayers) {
      var_aac62807b84149b5 += player.origin;
    }

    var_aac62807b84149b5 /= alliesplayers.size;
  }

  axisplayers = getfriendlyplayers("axis", 1);
  var_e4c7b343246f2158 = level.spawncamerastartspawnaxis;

  if(axisplayers.size > 0) {
    var_e4c7b343246f2158 = (0, 0, 0);

    foreach(player in axisplayers) {
      var_e4c7b343246f2158 += player.origin;
    }

    var_e4c7b343246f2158 /= axisplayers.size;
  }

  frontlinevector = var_e4c7b343246f2158 - var_aac62807b84149b5;
  var_447333acccb3f053 = vectorNormalize(frontlinevector);
  frontlinedistsq = vectordot(frontlinevector, frontlinevector);

  if(frontlinedistsq < 1048576) {
    return;
  }

  alliescamerapos = level.mapcornercenter + var_447333acccb3f053 * level.spawncameradistfactor * -0.5 + (0, 0, 1) * level.spawncameradistfactor * 0.2;
  var_6841474d6fed394f = vectorNormalize(level.mapcornercenter - alliescamerapos);
  var_9ae75568303e010c = vectortoanglessafe(var_6841474d6fed394f, (0, 0, 1));
  level.spawncameras["default"]["allies"].origin = alliescamerapos;
  level.spawncameras["default"]["allies"].angles = var_9ae75568303e010c;
  axiscamerapos = level.mapcornercenter + var_447333acccb3f053 * level.spawncameradistfactor * 0.5 + (0, 0, 1) * level.spawncameradistfactor * 0.2;
  var_6841474d6fed394f = vectorNormalize(level.mapcornercenter - axiscamerapos);
  var_e05dfad1728e7b21 = vectortoanglessafe(var_6841474d6fed394f, (0, 0, 1));
  level.spawncameras["default"]["axis"].origin = axiscamerapos;
  level.spawncameras["default"]["axis"].angles = var_e05dfad1728e7b21;
  thread drawline(alliescamerapos, level.mapcornercenter, 60, (0, 0, 1));
  thread drawline(axiscamerapos, level.mapcornercenter, 60, (1, 0, 0));
}

function calulatefrontline() {
  alliesplayers = getfriendlyplayers("allies", 1);
  var_aac62807b84149b5 = getstartspawnavg("allies");

  if(alliesplayers.size > 0) {
    var_aac62807b84149b5 = (0, 0, 0);

    foreach(player in alliesplayers) {
      var_aac62807b84149b5 += player.origin;
    }

    var_aac62807b84149b5 /= alliesplayers.size;
  }

  axisplayers = getfriendlyplayers("axis", 1);
  var_e4c7b343246f2158 = getstartspawnavg("axis");

  if(axisplayers.size > 0) {
    var_e4c7b343246f2158 = (0, 0, 0);

    foreach(player in axisplayers) {
      var_e4c7b343246f2158 += player.origin;
    }

    var_e4c7b343246f2158 /= axisplayers.size;
  }

  frontlinevector = var_e4c7b343246f2158 - var_aac62807b84149b5;
  var_447333acccb3f053 = vectorNormalize(frontlinevector);
  frontlineinfo = spawnStruct();
  frontlineinfo.origin = (var_aac62807b84149b5 + var_e4c7b343246f2158) * 0.5;
  frontlineinfo.angles = vectorcross(var_447333acccb3f053, (0, 0, 1));
  frontlineinfo.teamavg = [];
  frontlineinfo.teamavg["allies"] = var_aac62807b84149b5;
  frontlineinfo.teamavg["axis"] = var_e4c7b343246f2158;
  return frontlineinfo;
}

function getstartspawnavg(team, classname) {
  if(isDefined(level.startspawnavg) && isDefined(level.startspawnavg[team])) {
    return level.startspawnavg[team];
  }

  if(!isDefined(level.startspawnavg)) {
    level.startspawnavg = [];
  }

  level.startspawnavg[team] = (0, 0, 0);

  if(isDefined(classname)) {
    spawns = scripts\mp\spawnlogic::getspawnpointarray(classname);
  } else {
    spawns = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + team + "_start");
  }

  spawnavg = (0, 0, 0);

  foreach(s in spawns) {
    spawnavg += s.origin;
  }

  if(spawns.size > 0) {
    spawnavg /= spawns.size;
  }

  level.startspawnavg[team] = spawnavg;
  return level.startspawnavg[team];
}

function angle_diff(value1, value2) {
  return 180 - abs(abs(value1 - value2) - 180);
}

function function_bf0e17930d534ab1() {
  return getgametype() == "risk" || isgroundwarcoremode();
}

function function_71a2a6a6f52ab30b(keyarray, team, forward, forwardoffset, heightoffset) {
  foreach(key in keyarray) {
    if(istrue(level.useunifiedspawnselectioncameraheight)) {
      heightoffset = scripts\mp\spawnselection::function_87bbbee0bbf27304();
    }

    if(istrue(level.usespawnselection)) {
      groundpos = level.spawnselectionlocations[key][team].anchorentity.origin;
    } else if(isDefined(level.spawncameras[key][team])) {
      groundpos = level.spawncameras[key][team].origin;
    } else {
      return;
    }

    camerapos = groundpos + forward * forwardoffset + (0, 0, heightoffset);
    toground = vectorNormalize(groundpos - camerapos);
    cameraang = vectortoanglessafe(toground, (0, 0, 1));
    camerapos += calculatecameraoffset(team, groundpos);

    if(!isDefined(level.spawncameras[key])) {
      level.spawncameras[key] = [];
    }

    if(!isDefined(level.spawncameras[key][team])) {
      level.spawncameras[key][team] = spawn("script_origin", (0, 0, 0));
    }

    level.spawncameras[key][team].origin = camerapos;
    level.spawncameras[key][team].angles = cameraang;
  }
}

function calculatecameraoffset(team, objectiveorigin) {
  switch (level.mapname) {
    case #"hash_7a28db3c5928c489":
      var_fc87d6fc10744d44 = 0.25;
      var_6e9b9701b439aeb7 = 0.35;
      break;
    case #"hash_863773b8960b3944":
      var_fc87d6fc10744d44 = 0.25;
      var_6e9b9701b439aeb7 = 0.8;
      break;
    case #"hash_a8b272dba33a4aed":
      var_fc87d6fc10744d44 = 0.5;
      var_6e9b9701b439aeb7 = 0.3;
      break;
    default:
      var_fc87d6fc10744d44 = 0;
      var_6e9b9701b439aeb7 = 0;
      break;
  }

  len = distance(objectiveorigin, level.hqmidpoint);

  if(len < 2048) {
    return (0, 0, 0);
  }

  if(team == "axis") {
    var_4881f7fe7fc2bae2 = distance(level.gw_objstruct.axishqloc.trigger.origin, objectiveorigin);
    fulloffset = level.hqvecttomid_axis;
  } else {
    var_4881f7fe7fc2bae2 = distance(level.gw_objstruct.allieshqloc.trigger.origin, objectiveorigin);
    fulloffset = level.hqvecttomid_allies;
  }

  if(var_4881f7fe7fc2bae2 < 2048) {
    return (fulloffset * var_fc87d6fc10744d44);
  }

  if(var_4881f7fe7fc2bae2 > level.hqdisttomid) {
    if(team == "axis") {
      var_4881f7fe7fc2bae2 = distance(level.gw_objstruct.allieshqloc.trigger.origin, objectiveorigin);
    } else {
      var_4881f7fe7fc2bae2 = distance(level.gw_objstruct.axishqloc.trigger.origin, objectiveorigin);
    }

    percentage = 100 - var_4881f7fe7fc2bae2 * 100 / level.hqdisttomid;
    offset = fulloffset * var_6e9b9701b439aeb7 * -1 * percentage / 100;
    return offset;
  }

  percentage = 100 - var_4881f7fe7fc2bae2 * 100 / level.hqdisttomid;
  offset = fulloffset * var_fc87d6fc10744d44 * percentage / 100;
  return offset;
}

function function_581a8fc6f76d525d() {
  return !istrue(level.disablespawncamera) && istrue(scripts\mp\flags::gameflag("prematch_done")) && !istrue(self.skipspawncamera) && !istrue(level.usespawnselection);
}

function function_cdff2f0b5dcf3aa1() {
  self.var_1305ad103fdd8962 = 1;
  spawncamera = scripts\mp\spawncamera::getspawncamera();
  streamorigin = scripts\mp\gametypes\br_public::playerstreamhintlocation(spawncamera.origin);
}