/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spectating.gsc
*********************************************/

#include maps\mp\_utility;

init() {
  level.spectateOverride["allies"] = spawnStruct();
  level.spectateOverride["axis"] = spawnStruct();

  level thread onPlayerConnect();
  level thread getLevelMLGCams();
}

createMLGCamObject(icon) {
  precacheshader(icon);

  camera = spawn("script_model", (0, 0, 0));
  camera setModel("tag_origin");
  camera.angles = (0, 0, 0);

  curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  objective_add(curObjID, "active", (0, 0, 0));

  objective_icon(curObjID, icon);

  objective_playermask_hidefromall(curObjID);

  Objective_OnEntityWithRotation(curObjID, camera);

  camera.objID = curObjID;

  return camera;
}

setMLGCamVisibility(visible) {
  for(i = 0; i < level.CameraMapObjs.size; i++) {
    if(visible) {
      objective_playermask_showto(level.CameraMapObjs[i].objId, self GetEntityNumber());
    } else {
      objective_playermask_hidefrom(level.CameraMapObjs[i].objId, self GetEntityNumber());
    }
  }
}

getLevelMLGCams() {
  mapname = ToLower(getDvar("mapname"));

  camera1RawPos = TableLookup("mp/CameraPositions.csv", 0, mapname, 1);
  camera1RawAng = TableLookup("mp/CameraPositions.csv", 0, mapname, 2);
  level.CameraMapObjs = [];
  level.CameraMapObjs[0] = createMLGCamObject("compass_mlg_cam1");
  level.CameraMapObjs[1] = createMLGCamObject("compass_mlg_cam2");
  level.CameraMapObjs[2] = createMLGCamObject("compass_mlg_cam3");
  level.CameraMapObjs[3] = createMLGCamObject("compass_mlg_cam4");

  if(camera1RawPos == "") {
    return;
  }
  camera2RawPos = TableLookup("mp/CameraPositions.csv", 0, mapname, 3);
  camera2RawAng = TableLookup("mp/CameraPositions.csv", 0, mapname, 4);

  camera3RawPos = TableLookup("mp/CameraPositions.csv", 0, mapname, 5);
  camera3RawAng = TableLookup("mp/CameraPositions.csv", 0, mapname, 6);

  camera4RawPos = TableLookup("mp/CameraPositions.csv", 0, mapname, 7);
  camera4RawAng = TableLookup("mp/CameraPositions.csv", 0, mapname, 8);

  level.Camera1Pos = getCameraVecOrAng(camera1RawPos);
  level.Camera1Ang = getCameraVecOrAng(camera1RawAng);

  level.Camera2Pos = getCameraVecOrAng(camera2RawPos);
  level.Camera2Ang = getCameraVecOrAng(camera2RawAng);

  level.Camera3Pos = getCameraVecOrAng(camera3RawPos);
  level.Camera3Ang = getCameraVecOrAng(camera3RawAng);

  level.Camera4Pos = getCameraVecOrAng(camera4RawPos);
  level.Camera4Ang = getCameraVecOrAng(camera4RawAng);

  if(mapname == "mp_strikezone") {
    camera5RawPos = TableLookup("mp/CameraPositions.csv", 0, mapname + "_b", 1);
    camera5RawAng = TableLookup("mp/CameraPositions.csv", 0, mapname + "_b", 2);

    camera6RawPos = TableLookup("mp/CameraPositions.csv", 0, mapname + "_b", 3);
    camera6RawAng = TableLookup("mp/CameraPositions.csv", 0, mapname + "_b", 4);

    camera7RawPos = TableLookup("mp/CameraPositions.csv", 0, mapname + "_b", 5);
    camera7RawAng = TableLookup("mp/CameraPositions.csv", 0, mapname + "_b", 6);

    camera8RawPos = TableLookup("mp/CameraPositions.csv", 0, mapname + "_b", 7);
    camera8RawAng = TableLookup("mp/CameraPositions.csv", 0, mapname + "_b", 8);

    level.Camera5Pos = getCameraVecOrAng(camera5RawPos);
    level.Camera5Ang = getCameraVecOrAng(camera5RawAng);

    level.Camera6Pos = getCameraVecOrAng(camera6RawPos);
    level.Camera6Ang = getCameraVecOrAng(camera6RawAng);

    level.Camera7Pos = getCameraVecOrAng(camera7RawPos);
    level.Camera7Ang = getCameraVecOrAng(camera7RawAng);

    level.Camera8Pos = getCameraVecOrAng(camera8RawPos);
    level.Camera8Ang = getCameraVecOrAng(camera8RawAng);
  }
}

getCameraVecOrAng(elementString) {
  cameraAElements = StrTok(elementString, " ");
  CameraAVectorOrAng = (Int(cameraAElements[0]), Int(cameraAElements[1]), Int(cameraAElements[2]));

  return CameraAVectorOrAng;
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread onJoinedTeam();
    player thread onJoinedSpectators();
    player thread onSpectatingClient();
    player thread onFreecam();
  }
}

onJoinedTeam() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    self setSpectatePermissions();
    self setMLGCamVisibility(false);
  }
}

onJoinedSpectators() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_spectators");
    self setSpectatePermissions();
    if(self IsMLGSpectator() || (isDefined(self.pers["mlgSpectator"]) && self.pers["mlgSpectator"])) {
      self SetMLGSpectator(1);
      self SetClientOmnvar("ui_use_mlg_hud", true);
      self setMLGCamVisibility(true);
    }
  }
}

onSpectatingClient() {
  self endon("disconnect");

  for(;;) {
    self waittill("spectating_cycle");

    spectatedPlayer = self GetSpectatingPlayer();
    if(isDefined(spectatedPlayer)) {}
  }
}

onFreecam() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", channel, view);
    if(channel == "mlg_view_change") {
      self maps\mp\gametypes\_playerlogic::resetUIDvarsOnSpectate();
    }
  }
}

updateSpectateSettings() {
  level endon("game_ended");

  for(index = 0; index < level.players.size; index++)
    level.players[index] setSpectatePermissions();
}

setSpectatePermissions() {
  team = self.sessionteam;

  if(level.gameEnded && gettime() - level.gameEndTime >= 2000) {
    if(level.multiTeamBased) {
      for(i = 0; i < level.teamNameList.size; i++) {
        self allowSpectateTeam(level.teamNameList[i], false);
      }
    } else {
      self allowSpectateTeam("allies", false);
      self allowSpectateTeam("axis", false);
    }
    self allowSpectateTeam("freelook", false);
    self allowSpectateTeam("none", true);
    return;
  }

  spectateType = maps\mp\gametypes\_tweakables::getTweakableValue("game", "spectatetype");

  if(self IsMLGSpectator()) {
    spectateType = 2;
  }

  if(bot_is_fireteam_mode()) {
    spectateType = 1;
  }

  switch (spectateType) {
    case 0:
      if(level.multiTeamBased) {
        for(i = 0; i < level.teamNameList.size; i++) {
          self allowSpectateTeam(level.teamNameList[i], false);
        }
      } else {
        self allowSpectateTeam("allies", false);
        self allowSpectateTeam("axis", false);
      }
      self allowSpectateTeam("freelook", false);
      self allowSpectateTeam("none", false);
      break;

    case 1:
      if(!level.teamBased) {
        self allowSpectateTeam("allies", true);
        self allowSpectateTeam("axis", true);
        self allowSpectateTeam("none", true);
        self allowSpectateTeam("freelook", false);
      } else if(isDefined(team) && (team == "allies" || team == "axis") && !level.multiTeamBased) {
        self allowSpectateTeam(team, true);
        self allowSpectateTeam(getOtherTeam(team), false);
        self allowSpectateTeam("freelook", false);
        self allowSpectateTeam("none", false);
      } else if(isDefined(team) && IsSubStr(team, "team_") && level.multiTeamBased) {
        for(i = 0; i < level.teamNameList.size; i++) {
          if(team == level.teamNameList[i]) {
            self allowSpectateTeam(level.teamNameList[i], true);
          } else {
            self allowSpectateTeam(level.teamNameList[i], false);
          }
        }
        self allowSpectateTeam("freelook", false);
        self allowSpectateTeam("none", false);
      } else {
        if(level.multiTeamBased) {
          for(i = 0; i < level.teamNameList.size; i++) {
            self allowSpectateTeam(level.teamNameList[i], false);
          }
        } else {
          self allowSpectateTeam("allies", false);
          self allowSpectateTeam("axis", false);
        }
        self allowSpectateTeam("freelook", false);
        self allowSpectateTeam("none", false);
      }
      break;

    case 2:
      if(level.multiTeamBased) {
        for(i = 0; i < level.teamNameList.size; i++) {
          self allowSpectateTeam(level.teamNameList[i], true);
        }
      } else {
        self allowSpectateTeam("allies", true);
        self allowSpectateTeam("axis", true);
      }
      self allowSpectateTeam("freelook", true);
      self allowSpectateTeam("none", true);
      break;
  }

  if(isDefined(team) && (team == "axis" || team == "allies")) {
    if(isDefined(level.spectateOverride[team].allowFreeSpectate))
      self allowSpectateTeam("freelook", true);

    if(isDefined(level.spectateOverride[team].allowEnemySpectate))
      self allowSpectateTeam(getOtherTeam(team), true);
  }
}