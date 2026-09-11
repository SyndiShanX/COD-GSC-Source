/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spawncamera.gsc
***********************************************/

function init() {
  if(!isDefined(level.loadoutdefaultfiresalediscount)) {
    level.loadoutdefaultfiresalediscount = getdvarint("scr_game_disablespawncamera", 0) == 1;
  }

  level.snaptospawncamera = getdvarint("scr_game_spawncamera_snap", 1) == 1;
  level.evaluatefrontline = getdvarint("scr_game_spawncamera_frontline", 0) == 1;
  level.evaluatespawnforcameraselection = getdvarint("scr_game_spawncamera_spawnpoint", 1) == 1;
  level.updatedefaultcamera = &blank_func;
  level.updategamemodecamera = &blank_func;

  if(!istrue(level.loadoutdefaultfiresalediscount)) {
    initcameras();
    return;
  }
}

function blank_func() {}

function initcameras() {
  level.spawncameras = [];
  level.currentcamera = [];

  foreach(var1 in level.teamnamelist) {
    level.currentcamera[var1] = "default";
  }

  var3 = scripts\engine\utility::getStructArray("spawn_selection_camera", "targetname");

  if(var3.size == 0 || level.mapname == "mp_aniyah_tac") {
    createdefaultcameras();
    return;
  }

  foreach(var5 in var3) {
    var6 = var5.script_label;

    if(!isDefined(var6) || var6 == "spawn_selection_camera") {
      var6 = var5.script_noteworthy;
    }

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      var7 = var5.script_noteworthy;

      if(!isDefined(var7) || isDefined(var7) && var7 != level.localeid) {
        continue;
      }
    }

    if(!isDefined(level.spawncameras[var6])) {
      level.spawncameras[var6] = [];
    }

    var8 = var5.script_team;

    if(var8 == "all") {
      foreach(var1 in level.teamnamelist) {
        level.spawncameras[var6][var1] = var5;
      }

      continue;
    }

    if(istrue(level.usestaticspawnselectioncamera)) {
      var11 = scripts\mp\spawnselection::getstaticcameraposition(var8);
      var5.origin = var11.origin;
      var5.angles = var11.angles;
    }

    level.spawncameras[var6][var8] = var5;
  }

  createdefaultcameras();
}

function createdefaultcameras() {
  if(isDefined(level.spawncameras["default"])) {
    var0 = 1;

    foreach(var2 in level.teamnamelist) {
      if(!isDefined(level.spawncameras["default"][var2])) {
        var0 = 0;
        break;
      }
    }

    if(var0) {
      return;
    }
  } else {
    level.spawncameras["default"] = [];
  }

  var4 = (0, 0, 0);

  if(isDefined(level.mapcorners) && isDefined(level.mapcorners[0]) && isDefined(level.mapcorners[1])) {
    level.mapcornervector = level.mapcorners[1].origin - level.mapcorners[0].origin;
    level.mapcornercenter = level.mapcorners[0].origin + level.mapcornervector * 0.5;
  }

  foreach(var2 in level.teamnamelist) {
    if(isDefined(level.spawncameras["default"][var2])) {
      level.spawncameras["default"][var2].radiantplaced = 1;
      continue;
    }

    var6 = spawnStruct();
    var6.origin = (0, 0, 0);
    var6.angles = (0, 0, 0);
    level.spawncameras["default"][var2] = var6;
  }

  level.spawncamerastartspawnallies = getstartspawnavg("allies");
  level.spawncamerastartspawnaxis = getstartspawnavg("axis");
  level.spawncamerastartspawnaxisang = scripts\engine\utility::ter_op(distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[0].origin) < distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[1].origin), level.mapcorners[0].angles, level.mapcorners[1].angles);
  var8 = level.spawncamerastartspawnaxis - level.spawncamerastartspawnallies;
  var9 = level.spawncamerastartspawnallies + var8 * 0.5;

  if(distancesquared(level.spawncamerastartspawnallies, level.mapcorners[0].origin) < distancesquared(level.spawncamerastartspawnallies, level.mapcorners[1].origin)) {
    var10 = anglesToForward(level.mapcorners[0].angles);
    var11 = anglestoright(level.mapcorners[0].angles);

    if(abs(vectordot(var8, var10)) > abs(vectordot(var8, var11))) {
      level.spawncamerastartspawnalliesvec = var10;
    } else {
      level.spawncamerastartspawnalliesvec = var11;
    }
  } else {
    var10 = anglesToForward(level.mapcorners[1].angles);
    var11 = anglestoright(level.mapcorners[1].angles);

    if(abs(vectordot(var10, var10)) > abs(vectordot(var10, var11))) {
      level.spawncamerastartspawnalliesvec = var10;
    } else {
      level.spawncamerastartspawnalliesvec = var11;
    }
  }

  if(distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[0].origin) < distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[1].origin)) {
    var10 = anglesToForward(level.mapcorners[0].angles);
    var11 = anglestoright(level.mapcorners[0].angles);

    if(abs(vectordot(var10, var10)) > abs(vectordot(var10, var11))) {
      level.spawncamerastartspawnaxisvec = var10;
    } else {
      level.spawncamerastartspawnaxisvec = var11;
    }
  } else {
    var10 = anglesToForward(level.mapcorners[1].angles);
    var11 = anglestoright(level.mapcorners[1].angles);

    if(abs(vectordot(var10, var10)) > abs(vectordot(var10, var11))) {
      level.spawncamerastartspawnaxisvec = var10;
    } else {
      level.spawncamerastartspawnaxisvec = var11;
    }
  }

  var12 = distance(level.spawncamerastartspawnallies, level.spawncamerastartspawnaxis);
  level.spawncameradistfactor = var12;
  orientdefaulttomapcenterusingmapcorners();
}

function init_trap_room_traps() {
  if(isDefined(level.updatedefaultcamera)) {
    [[level.updatedefaultcamera]]();
  }

  if(isDefined(level.updategamemodecamera)) {
    self[[level.updategamemodecamera]]();
  }

  var0 = self.origin + (0, 0, 60);
  var1 = self.angles;

  if(isDefined(self.squadspectatepos)) {
    self.deathspectatepos = self.squadspectatepos;
    self.deathspectateangles = self.squadspectateang;
  } else {
    self.deathspectatepos = var0;
    self.deathspectateangles = var1;
  }

  if(!isDefined(self.spawncameraent)) {
    var2 = spawn("script_model", self.deathspectatepos);
    var2 scripts\cp_mp\ent_manager::registerspawncount(1);
    var2 setModel("tag_origin");
    var2.angles = self.deathspectateangles;
    self.spawncameraent = var2;
    return;
  }

  self.spawncameraent.origin = self.deathspectatepos;
  self.spawncameraent.angles = self.deathspectateangles;
}

function startspawncamera(var0, var1, var2) {
  self endon("disconnect");
  scripts\mp\utility\player::ref_12898("spawnCamera::startSpawnCamera() START");
  scripts\mp\utility\player::hideminimap(1);
  init_trap_room_traps();

  if(!isDefined(self.spawncameraent)) {
    scripts\mp\utility\player::ref_12898("spawnCamera::startSpawnCamera() UNDEFINED SPAWNCAMERAENT!!!");
    thread playslamzoomflash(0, getspawncamerawaittime(), 0.5);
    return;
  }

  if(istrue(level.loadoutdefaultfiresalediscount) && scripts\mp\utility\game::getgametype() != "arm") {
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

  if(isDefined(self.setspawnpoint)) {
    return;
  }

  self.inspawncamera = 1;
  scripts\mp\utility\player::setdof_default();
  waitframe();
  scripts\mp\spectating::setdisabled();
  scripts\mp\utility\player::updatesessionstate("spectator");
  self setclientomnvar("ui_in_spawn_camera", 1);

  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(var1)) {
    var1 = 0.25;
  }

  if(!isDefined(var2)) {
    var2 = 0.25;
  }

  thread playslamzoomflash(var0, var1, var2);
  scripts\engine\utility::ref_143bf(0.1, "force_spawn");
  thread removecameraondisconnect(self.spawncameraent);
  self cameralinkTo(self.spawncameraent, "tag_origin", 1, 1);
  scripts\mp\utility\player::ref_12898("spawnCamera::startSpawnCamera() CameralinkTo()");
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

function room_door_windows() {
  return true;
}

function getspawncamera() {
  var0 = undefined;

  if(scripts\mp\utility\game::unset_relic_landlocked()) {
    self.forcedspawncameraref = "default";
  }

  if(isDefined(self.forcedspawncameraref)) {
    if(isDefined(level.spawncameras[self.forcedspawncameraref])) {
      var0 = level.spawncameras[self.forcedspawncameraref][self.team];
    } else if(issubstr(self.forcedspawncameraref, "squad")) {
      var1 = self.forcedspawncameraref;

      if(var1 == "squad_leader") {
        var2 = level.squaddata[self.team][self.squadindex].squadleaderindex;
      } else {
        var2 = int(getsubstr(var2, var2.size - 1, var2.size));
      }

      var3 = undefined;

      if(isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self.squadindex]) && isDefined(level.squaddata[self.team][self.squadindex].players[var2])) {
        var3 = level.squaddata[self.team][self.squadindex].players[var2];
      }

      if(isDefined(var3)) {
        var4 = level.spawnselectionteamforward[self.team];
        var5 = var3.origin + var4 * -8500 + (0, 0, 7000);
        var6 = vectorNormalize(var3.origin - var5);
        var7 = scripts\mp\utility\script::vectortoanglessafe(var6, (0, 0, 1));

        if(istrue(level.useunifiedspawnselectioncameraheight)) {
          var8 = scripts\mp\spawnselection::getunifedspawnselectioncameraheight();
          var5 = (var5[0], var5[1], var8);
        }

        var5 += scripts\mp\gametypes\arm::calculatecameraoffset(self.team, var3.origin);
        var1 = spawnStruct();
        var1.origin = var5;
        var1.angles = var7;
      }
    } else if(issubstr(self.forcedspawncameraref, "vehicle")) {
      var1 = self.forcedspawncameraref;
      var9 = undefined;

      if(isDefined(level.spawnselectionlocations[var1]) && isDefined(level.spawnselectionlocations[var1][self.team])) {
        var9 = level.spawnselectionlocations[var1][self.team].dynamicent;
      }

      var4 = level.spawnselectionteamforward[self.team];

      if(isDefined(var9) && !istrue(var9.isdestroyed)) {
        var5 = [];
        var7 = [];

        if(istrue(level.usestaticspawnselectioncamera)) {
          var10 = scripts\mp\spawnselection::getstaticcameraposition(self.team);
          var5 = var10.origin;
          var7 = var10.angles;
        } else {
          var5 = var9.origin + var4 * -8500 + (0, 0, 7000);

          if(istrue(level.useunifiedspawnselectioncameraheight)) {
            var8 = scripts\mp\spawnselection::getunifedspawnselectioncameraheight();
            var5 = (var5[0], var5[1], var8);
          }

          var11 = level.spawnselectionlocations[var1][self.team].anchorentity.origin;
          var12 = var11 + var4 * -8500 + (0, 0, 7000);
          var13 = vectorNormalize(var11 - var12);
          var7 = scripts\mp\utility\script::vectortoanglessafe(var13, (0, 0, 1));
          var5 += scripts\mp\gametypes\arm::calculatecameraoffset(self.team, var11);
        }

        var1 = spawnStruct();
        var1.origin = var5;
        var1.angles = var7;
      }
    }
  } else if(istrue(level.evaluatespawnforcameraselection) && isDefined(level.was_seq3_gassed) && isDefined(level.was_seq3_gassed[self.team])) {
    var14 = level.was_seq3_gassed[self.team];
    var15 = undefined;
    var16 = undefined;

    foreach(var20, var18 in level.spawncameras[level.currentcamera[self.team]]) {
      var19 = distancesquared(var18.origin, var14);

      if(!isDefined(var16) || var19 < var15) {
        var16 = var18;
        var15 = var19;
      }
    }

    var1 = var16;
  } else if(istrue(level.evaluatefrontline)) {
    var21 = calulatefrontline();
    var15 = undefined;
    var16 = undefined;

    foreach(var18 in level.spawncameras[level.currentcamera[self.team]]) {
      var23 = distancesquared(var18.origin, var21.teamavg[self.team]);
      var24 = distancesquared(var18.origin, var21.origin);

      if(!isDefined(var16) || var23 < var24) {
        var16 = var18;
        var15 = var23;
      }
    }

    var1 = var16;
  } else {
    if(istrue(level.usec130spawn)) {
      while(!isDefined(level.currentcamera[self.team])) {
        waitframe();
      }
    }

    if(!isstring(level.currentcamera[self.team])) {
      var1 = spawnStruct();
      var1.origin = level.currentcamera[self.team].origin;
      var1.angles = level.currentcamera[self.team].angles;
      var1.usingintermissionpos = 1;
    } else {
      var1 = level.spawncameras[level.currentcamera[self.team]][self.team];
    }
  }

  if(!isDefined(var1)) {
    if(isDefined(level.availablespawnlocations) && isDefined(level.availablespawnlocations[self.team])) {
      level.currentcamera[self.team] = level.availablespawnlocations[self.team][0];
      var1 = level.spawncameras[level.currentcamera[self.team]][self.team];
    } else {
      level.currentcamera[self.team] = "default";
      var1 = level.spawncameras[level.currentcamera[self.team]][self.team];
    }
  }

  return var1;
}

function movetospawncamerainitial() {
  self endon("disconnect");
  self notify("newMoveToSpawnCameraInitiated");
  self endon("newMoveToSpawnCameraInitiated");
  self endon("tac_ops_spawn_focus_changed");
  self endon("slamZoomInitiated");
  var0 = getspawncamera();
  var1 = var0.origin;
  var2 = var0.angles;
  var3 = self.spawncameraent.origin;
  var4 = vectorNormalize(var3 - var0.origin);
  var5 = scripts\mp\utility\script::vectortoanglessafe(var4, (0, 0, 1));
  self.spawncameraent.angles = var5;
  var6 = distance(var3, var1);
  var7 = var6 / 3520;
  var7 = clamp(var7, 1.5, 3);
  self.spawncameratargetpos = var1;
  self.spawncameratargetang = var2;
  self.spawncameratime = var7;
  self.spawncameraendtime = gettime() + var7 * 1000;

  if(!istrue(var0.usingintermissionpos)) {
    self.spawncameraent moveTo(var1, var7, var7 * 0.3, var7 * 0.4);
    self.spawncameraent rotateTo(var2, var7, var7 * 0.3, var7 * 0.4);
    wait 1;
  } else {
    self.spawncameraent.origin = var1;
    self.spawncameraent.angles = var2;
    self.deathspectatepos = var1;
  }

  applythermal();
  thread startoperatorsound();

  if(isDefined(self) && isDefined(self.spawncameraent) && !istrue(self.inspawnselection)) {
    var8 = anglesToForward(var2) * 300;
    var8 *= (1, 1, 0);
    self earthquakeforplayer(0.03, 15, var1, 1000);
  }

  self notify("spawn_camera_idle");
}

function movetospawncamera(var0) {
  self endon("disconnect");
  self notify("newMoveToSpawnCameraInitiated");
  self endon("newMoveToSpawnCameraInitiated");
  self endon("tac_ops_map_selection_valid");
  self endon("tac_ops_spawn_focus_changed");
  self endon("slamZoomInitiated");
  var1 = getspawncamera();
  var2 = var1.origin;
  var3 = var1.angles;

  if(isDefined(self.spawncameratargetpos) && isDefined(self.spawncameratargetang) && self.spawncameratargetpos == var2 && self.spawncameratargetang == var3) {
    return;
  }

  var4 = self.spawncameraent.origin;
  var5 = vectorNormalize(var4 - var1.origin);
  self.spawncameratargetpos = var2;
  self.spawncameratargetang = var3;
  self.spawncameraent moveTo(var2, 1, 0.25, 0.75);
  self.spawncameraent rotateTo(var3, 1, 0.25, 0.75);
  wait 1;

  if(isDefined(self) && isDefined(self.spawncameraent) && !istrue(self.inspawnselection)) {
    var6 = anglesToForward(var3) * 300;
    var6 *= (1, 1, 0);
    self.spawncameraent moveTo(var2 + var6, 15, 1, 1);
    self earthquakeforplayer(0.03, 15, var2, 1000);
  }

  self notify("spawn_camera_idle");
}

function snaptospawncamera() {
  self endon("disconnect");

  while(!istrue(self.get_bomb_icon_on_cell_phone_func)) {
    waitframe();
  }

  var0 = getspawncamera();
  self.spawncameraent dontinterpolate();
  self.spawncameraent.origin = var0.origin;
  self.spawncameraent.angles = var0.angles;
  scripts\mp\utility\player::ref_12898("spawnCamera::snapToSpawnCamera()");

  if(!istrue(level.nukedetonated)) {
    self visionsetnakedforplayer("", 0);
  }

  applythermal();
  thread startoperatorsound();

  if(isDefined(self) && isDefined(self.spawncameraent) && !istrue(self.inspawnselection)) {
    var1 = anglesToForward(self.spawncameraent.angles) * 300;
    var1 *= (1, 1, 0);
    self.spawncameraent moveTo(self.spawncameraent.origin + var1, 15, 1, 1);
    self earthquakeforplayer(0.03, 15, self.spawncameraent.origin, 1000);
  }

  self notify("spawn_camera_idle");
}

function endspawncamera() {
  if(isDefined(self.ref_12135)) {
    self clearsoundsubmix("iw8_mp_spawn_camera");
    self.ref_12135 stoploopsound(self.ref_12136);
    self.ref_12135 delete();
    self.ref_12135 = undefined;
    self.ref_12136 = undefined;
  }

  if(!isDefined(self.spawncameraent)) {
    return;
  }

  if(istrue(level.gameended)) {
    return;
  }

  scripts\mp\utility\player::hideminimap(1);
  thread ref_13917();
  runslamzoomonspawn();
}

function deletespawncamera() {
  self cameraunlink();
  self.spawncameraent scripts\cp_mp\ent_manager::deregisterspawn();
  self.spawncameraent delete();
  self.spawncameraent = undefined;
  self.isusingspawnmapcamera = undefined;
  self.inspawncamera = 0;
  self notify("spawn_camera_deleted");
}

function removecameraondisconnect(var0) {
  self endon("spawn_camera_deleted");
  self waittill("disconnect");

  if(isDefined(var0)) {
    var0 scripts\cp_mp\ent_manager::deregisterspawn();
    var0 delete();
    return;
  }
}

function ref_13917() {
  self endon("disconnect");
  self waittill("spawncamera_start");
  self predictstreampos(self getEye());
  self waittill("spawn_camera_complete");
  self clearpredictedstreampos();
}

function runslamzoomonspawn(var0) {
  self endon("disconnect");
  scripts\mp\utility\player::ref_12898("spawnCamera::runSlamZoomOnspawn() START");
  self waittill("spawncamera_start");
  scripts\mp\utility\player::ref_12898("spawnCamera::runSlamZoomOnspawn() spawncamera_start PASSED");
  self notify("slamZoomInitiated");
  scripts\mp\utility\player::_freezecontrols(1, undefined, "slamZoom");
  self playerhide();
  self setbeingrevived(1);
  self.plotarmor = 1;
  scripts\common\utility::allow_vehicle_use(0);
  scripts\mp\spectating::setdisabled();
  scripts\mp\utility\player::updatesessionstate("spectator");
  self cameralinkTo(self.spawncameraent, "tag_origin", 1);
  scripts\mp\utility\player::ref_12898("spawnCamera::runSlamZoomOnspawn() CameralinkTo()");
  handlemovetoblended();
  deletespawncamera();

  if(self.team == "spectator") {
    scripts\mp\playerlogic::removefromalivecount();
    self setclientomnvar("ui_in_spawn_camera", 0);

    if(!istrue(level.nukedetonated)) {
      self visionsetnakedforplayer("", 0.5);
    }

    scripts\mp\utility\player::_freezecontrols(0, undefined, "slamZoom");
    self setbeingrevived(0);
    self.plotarmor = 0;
    thread scripts\mp\spectating::setspectatepermissions();
    return;
  }

  scripts\mp\utility\player::updatesessionstate("playing");

  if(istrue(self.ref_132ff)) {
    var1 = scripts\mp\playerlogic::getspawnpoint();
    self setOrigin(var1.spawnorigin);
    self setplayerangles(var1.spawnangles);
    scripts\mp\spawnlogic::finalizespawnpointchoice(var1.spawnpoint);
    self.ref_132ff = undefined;
    self.selectedspawnarea = undefined;
  }

  self setclientomnvar("ui_in_spawn_camera", 0);

  if(!istrue(level.nukedetonated)) {
    self visionsetnakedforplayer("", 0.5);
  }

  scripts\mp\utility\player::_freezecontrols(0, undefined, "slamZoom");
  self playershow();
  self setbeingrevived(0);
  self.plotarmor = 0;
  scripts\common\utility::allow_vehicle_use(1);
  self notify("spawned_player");
  level notify("player_spawned", self, self.wasrevivespawn);
  thread scripts\mp\playerlogic::setspawnnotifyomnvar();
  self.wasrevivespawn = undefined;
  self.delayedspawnedplayernotify = undefined;
  self.spawndata = undefined;
  scripts\mp\utility\player::ref_12898("spawnCamera::runSlamZoomOnspawn() COMPLETE");
}

function handlemoveTo(var0) {
  self endon("disconnect");
  var1 = self getEye();
  var2 = self.angles;
  var3 = (var1[0], var1[1], self.spawncameraent.origin[2]);
  var3 += anglesToForward(var2) * -480;
  self.spawncameraent moveTo(var3, 0.75, 0.25, 0.25);
  var4 = vectorNormalize(var1 - var3);
  var5 = scripts\mp\utility\script::vectortoanglessafe(var4, (0, 0, 1));
  self.spawncameraent rotateTo(var5, 0.75, 0.25, 0.25);
  wait 0.75;
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  var6 = var1 + anglesToForward(var2) * -60;
  self.spawncameraent moveTo(var6, 0.5, 0.1, 0.4);
  self.spawncameraent rotateTo(var2, 0.7, 0.45, 0.05);
  wait 0.5;
  thread playslamzoomflash();
  self.spawncameraent moveTo(var1, 0.6, 0.1, 0.1);
  wait 0.2;
  self visionsetnakedforplayer("", 0);
}

function handlemovetoblended(var0) {
  self endon("disconnect");
  self endon("kill_handle_move_to_blended");
  scripts\mp\utility\player::ref_12898("spawnCamera::handlemoveTo() START");
  var1 = self.spawndata.spawnorigin + (0, 0, 60);
  var2 = self.spawndata.spawnangles;

  if(isDefined(self.forcespawncameraorg)) {
    var1 = self.forcespawncameraorg;
    var2 = self.forcespawncameraang;
    self.forcespawncameraorg = undefined;
    self.forcespawncameraang = undefined;
  }

  var3 = angle_diff(self.spawncameraent.angles[1], var2[1]) < 45;
  var4 = distance2dsquared(self.spawncameraent.origin, var1) > 1000000;
  thread fadeblackforgeo(var1);

  if(!var3 || !var4) {
    if(!istrue(level.nukedetonated)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        removethermal();
        self visionsetnakedforplayer("", 0);
      } else {
        self visionsetnakedforplayer("respawn_camera_night", 0);
      }
    }

    wait 0.05;
    self.spawncameraent moveTo(var1, 1, 0.1, 0.9);
    self.spawncameraent rotateTo(var2, 1, 0.9, 0.1);
    scripts\mp\utility\player::ref_12898("spawnCamera::handlemoveTo() FULL Blend Set");

    if(!istrue(level.nukedetonated)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);
      }
    }

    wait 0.8;
    wait 0.2;
  } else {
    var5 = vectorNormalize(var1 - self.spawncameraent.origin);
    var6 = scripts\mp\utility\script::vectortoanglessafe(var5, (0, 0, 1));
    self.spawncameraent rotateTo(var6, 0.7, 0.2, 0.2);
    scripts\mp\utility\player::ref_12898("spawnCamera::handlemoveTo() FIRST HALF Blend Set");

    if(!istrue(level.nukedetonated)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        removethermal();
        self visionsetnakedforplayer("", 0);
      } else {
        self visionsetnakedforplayer("respawn_camera_night", 0);
      }
    }

    wait 0.05;
    self.spawncameraent moveTo(var1, 1, 0.1, 0.9);

    if(!istrue(level.nukedetonated)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);
      }
    }

    wait 0.5;
    self.spawncameraent rotateTo(var2, 0.5, 0.2, 0.1);
    scripts\mp\utility\player::ref_12898("spawnCamera::handlemoveTo() SECOND HALF Blend Set");
    wait 0.3;
    wait 0.2;
  }

  scripts\mp\utility\player::ref_12898("spawnCamera::handlemoveTo() COMPLETE");
  self notify("spawn_camera_complete");
}

function fadeblackforgeo(var0) {
  var1 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var2 = physics_createcontents(var1);
  var3 = scripts\engine\trace::ray_trace(self.spawncameraent.origin, var0, undefined, var2);
  var4 = scripts\engine\trace::ray_trace(var0, self.spawncameraent.origin, undefined, var2);
  var5 = var3["fraction"];
  var6 = var4["fraction"];
  var7 = 0.11;

  if(istrue(self.spawningintovehicle)) {
    self setsoundsubmix("iw8_mp_vehicle_spawn", 0.1);
    thread clear_plr_vehicle_submix();
  }

  if(istrue(self.spawningintovehicle) || scripts\cp_mp\utility\game_utility::isnightmap()) {
    self.spawningintovehicle = undefined;

    if(isDefined(self.ref_14268) && self.ref_14268 == "light_tank") {
      var5 = min(var5, 0.95);
      var6 = 0;
      var7 = 0.75;
    } else {
      var5 = min(var5, 0.95);
      var6 = 0;
    }
  }

  if(istrue(self.ref_132ff)) {
    var5 = min(var5, 0.5);
    var6 = 0;
    thread ref_14360();
  }

  if(var5 < 1) {
    var5 = clamp(var5 - 0.1, 0, 0.95);

    if(var5 - 0.22 > 0) {
      wait var5 - 0.22;
    }

    thread playslamzoomflash(0.1, 1 - var5 - var6 + var7, 0.25);
    return;
  }
}

function ref_14360() {
  self endon("disconnect");
  self waittill("fadeUp_start");
  self notify("kill_handle_move_to_blended");
}

function clear_plr_vehicle_submix() {
  wait 2.5;
  self clearsoundsubmix("iw8_mp_vehicle_spawn", 1);
}

function playslamzoomflash(var0, var1, var2) {
  self endon("disconnect");
  self.get_bomb_icon_on_cell_phone_func = 0;

  if(!isDefined(var2)) {
    var2 = 0.5;
  }

  self notify("fadeDown_start");

  if(isDefined(var0) && var0 > 0) {
    var3 = 0;
    var4 = var0 / level.framedurationseconds;
    var5 = 1 / var4;
    var6 = 0;

    while(var6 < var4) {
      var6++;
      var3 += var5;
      var3 = clamp(var3, 0, 1);
      self setclientomnvar("ui_world_fade", var3);
      waitframe();
    }
  } else {
    self setclientomnvar("ui_world_fade", 1);
  }

  self notify("fadeDown_complete");
  self.get_bomb_icon_on_cell_phone_func = 1;

  if(isDefined(var1) && var1 > 0) {
    wait var1;
  }

  self notify("fadeUp_start");

  if(isDefined(var2) && var2 > 0) {
    var3 = 1;
    var4 = var2 / level.framedurationseconds;
    var5 = 1 / var4;
    var6 = 0;

    while(var6 < var4) {
      var6++;
      var3 -= var5;
      var3 = clamp(var3, 0, 1);
      self setclientomnvar("ui_world_fade", var3);
      waitframe();
    }
  } else {
    self setclientomnvar("ui_world_fade", 0);
  }

  self notify("fadeUp_complete");
}

function movecameratomappos(var0, var1, var2) {
  self moveTo(var1, 1, 0.5, 0.5);
  self rotateTo(var2, 1, 0.5, 0.5);
  thread startoperatorsound();
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

  if(!istrue(level.nukedetonated)) {
    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      self visionsetnakedforplayer("respawn_camera_night", 0);
      return;
    }

    self visionsetnakedforplayer("respawn_camera", 0);
    return;
  }
}

function removethermal() {}

function startoperatorsound() {
  self endon("disconnect");
  self endon("game_ended");

  if(isDefined(self.ref_12135)) {
    return;
  }

  if(istrue(level.nukeincoming)) {
    return;
  }

  self.ref_12135 = spawn("script_origin", (0, 0, 0));
  self.ref_12135 showonlytoplayer(self);
  self setsoundsubmix("iw8_mp_spawn_camera");
  var0 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
  var1 = "dx_mpo_" + var0 + "op_drone_deathchatter";

  if(!soundexists(var1)) {
    var1 = "dx_mpo_usop_drone_deathchatter";
  }

  self.ref_12136 = var1;
  self.ref_12135 playLoopSound(var1);
  thread needs_radar();
}

function needs_radar() {
  self endon("spawned_player");
  var0 = self.ref_12135;
  var1 = self.ref_12136;
  self waittill("disconnect");

  if(isDefined(var0)) {
    var0 stoploopsound(var1);
    var0 delete();
    return;
  }
}

function setgamemodecamera(var0, var1) {
  level.spawncameras["gamemode"][var0] = var1;
  setspawncamera(var0, "gamemode");
}

function setspawncamera(var0, var1) {
  level.currentcamera[var0] = var1;
}

function orientdefaulttomapcenterusingmapcorners() {
  if(!istrue(level.spawncameras["default"]["allies"].radiantplaced)) {
    var0 = level.mapcornercenter + level.spawncamerastartspawnalliesvec * level.spawncameradistfactor * -0.85 + (0, 0, 1) * level.spawncameradistfactor * 0.45;
    var1 = vectorNormalize(level.mapcornercenter - var0);
    var2 = scripts\mp\utility\script::vectortoanglessafe(var1, (0, 0, 1));
    level.spawncameras["default"]["allies"].origin = var0;
    level.spawncameras["default"]["allies"].angles = var2;
  }

  if(!istrue(level.spawncameras["default"]["axis"].radiantplaced)) {
    var3 = level.mapcornercenter + level.spawncamerastartspawnaxisvec * level.spawncameradistfactor * -0.85 + (0, 0, 1) * level.spawncameradistfactor * 0.45;
    var1 = vectorNormalize(level.mapcornercenter - var3);
    var4 = scripts\mp\utility\script::vectortoanglessafe(var1, (0, 0, 1));
    level.spawncameras["default"]["axis"].origin = var3;
    level.spawncameras["default"]["axis"].angles = var4;
    return;
  }
}

function orientdefaulttofrontline() {
  var0 = scripts\mp\utility\teams::getfriendlyplayers("allies", 1);
  var1 = level.spawncamerastartspawnallies;

  if(var0.size > 0) {
    var1 = (0, 0, 0);

    foreach(var3 in var0) {
      var1 += var3.origin;
    }

    var1 /= var0.size;
  }

  var5 = scripts\mp\utility\teams::getfriendlyplayers("axis", 1);
  var6 = level.spawncamerastartspawnaxis;

  if(var5.size > 0) {
    var6 = (0, 0, 0);

    foreach(var3 in var5) {
      var6 += var3.origin;
    }

    var6 /= var5.size;
  }

  var9 = var6 - var1;
  var10 = vectorNormalize(var9);
  var11 = vectordot(var9, var9);

  if(var11 < 1048576) {
    return;
  }

  var12 = level.mapcornercenter + var10 * level.spawncameradistfactor * -0.5 + (0, 0, 1) * level.spawncameradistfactor * 0.2;
  var13 = vectorNormalize(level.mapcornercenter - var12);
  var14 = scripts\mp\utility\script::vectortoanglessafe(var13, (0, 0, 1));
  level.spawncameras["default"]["allies"].origin = var12;
  level.spawncameras["default"]["allies"].angles = var14;
  var15 = level.mapcornercenter + var10 * level.spawncameradistfactor * 0.5 + (0, 0, 1) * level.spawncameradistfactor * 0.2;
  var13 = vectorNormalize(level.mapcornercenter - var15);
  var16 = scripts\mp\utility\script::vectortoanglessafe(var13, (0, 0, 1));
  level.spawncameras["default"]["axis"].origin = var15;
  level.spawncameras["default"]["axis"].angles = var16;
  thread scripts\mp\utility\debug::drawline(var12, level.mapcornercenter, 60, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(var15, level.mapcornercenter, 60, (1, 0, 0));
}

function calulatefrontline() {
  var0 = scripts\mp\utility\teams::getfriendlyplayers("allies", 1);
  var1 = getstartspawnavg("allies");

  if(var0.size > 0) {
    var1 = (0, 0, 0);

    foreach(var3 in var0) {
      var1 += var3.origin;
    }

    var1 /= var0.size;
  }

  var5 = scripts\mp\utility\teams::getfriendlyplayers("axis", 1);
  var6 = getstartspawnavg("axis");

  if(var5.size > 0) {
    var6 = (0, 0, 0);

    foreach(var3 in var5) {
      var6 += var3.origin;
    }

    var6 /= var5.size;
  }

  var9 = var6 - var1;
  var10 = vectorNormalize(var9);
  var11 = spawnStruct();
  var11.origin = (var1 + var6) * 0.5;
  var11.angles = vectorcross(var10, (0, 0, 1));
  var11.teamavg = [];
  var11.teamavg["allies"] = var1;
  var11.teamavg["axis"] = var6;
  return var11;
}

function getstartspawnavg(var0) {
  if(isDefined(level.startspawnavg) && isDefined(level.startspawnavg[var0])) {
    return level.startspawnavg[var0];
  }

  if(!isDefined(level.startspawnavg)) {
    level.startspawnavg = [];
  }

  level.startspawnavg[var0] = (0, 0, 0);
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var0 + "_start");
  var2 = (0, 0, 0);

  foreach(var4 in var1) {
    var2 += var4.origin;
  }

  if(var1.size > 0) {
    var2 /= var1.size;
  }

  level.startspawnavg[var0] = var2;
  return level.startspawnavg[var0];
}

function angle_diff(var0, var1) {
  return 180 - abs(abs(var0 - var1) - 180);
}