/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_history_quest.gsc
*****************************************************/

init() {
  enabled = _id_3ACF1C0EBAF602F2::registerquestcategory("history", 1);

  if(!enabled) {
    return;
  }
  _id_3ACF1C0EBAF602F2::getquestdata("history").missionbasetimer = getdvarint("dvar_1225F4A756603591", 240);
  _id_3ACF1C0EBAF602F2::getquestdata("history").dvarlocations = getdvarint("dvar_237B2FFCE8991450", 0);
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("history", ::his_removequestinstance);
  _id_3ACF1C0EBAF602F2::registeronplayerdisconnect("history", ::his_playerdisconnect);
  _id_3ACF1C0EBAF602F2::registeronrespawn("history", ::his_respawn);
  _id_3ACF1C0EBAF602F2::registerquestthink("history", ::_id_5CB7CB503AEA12C8, 0.1);
  _id_3ACF1C0EBAF602F2::questtimerinit("history", 0);
  _id_3ACF1C0EBAF602F2::registerontimerexpired("history", ::his_ontimerexpired);
  createallhistorydestinations();
}

his_respawn(player) {
  if(!checkforcorrectinstance(player)) {
    return;
  }
  player _id_3ACF1C0EBAF602F2::uiobjectiveshow("history");
  _id_3ACF1C0EBAF602F2::showquestobjicontoplayer(player);
}

his_ontimerexpired() {
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", self.team, 1);
}

his_removequestinstance() {
  if(isDefined(self.currentdestination)) {
    foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
      self.currentdestination.gameobject hidefromplayer(player);
      self.currentdestination.gameobject disableplayeruse(player);
    }
  }

  deletehistoryhud();
  _id_3ACF1C0EBAF602F2::releaseteamonquest(self.team);
}

his_playerdisconnect(_id_345221032955C106) {
  if(_id_345221032955C106.team == self.team) {
    if(!_id_3ACF1C0EBAF602F2::isteamvalid(_id_345221032955C106.team)) {
      self.result = "fail";
      _id_3ACF1C0EBAF602F2::removequestinstance();
    }
  }
}

checkforcorrectinstance(player) {
  if(player.team == self.team)
    return 1;
  else
    return 0;
}

givequest(team, id, player, modifier, rewardscriptable) {
  instance = _id_3ACF1C0EBAF602F2::createquestinstance("history", team, id, rewardscriptable);
  instance _id_3ACF1C0EBAF602F2::registerteamonquest(team, player);
  instance.team = self.team;
  instance.startlocation = self.origin;
  instance.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  instance.destprogress = 0;
  instance _id_3ACF1C0EBAF602F2::createquestobjicon("ui_mp_br_mapmenu_icon_x1_02_objective", "current", (0, 0, 0));

  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players"))
  instance _id_3ACF1C0EBAF602F2::showquestobjicontoplayer(player);

  instance setfirsthistorydestination();
  _id_3ACF1C0EBAF602F2::uiobjectiveshowtoteam("history", self.team);
  instance _id_3ACF1C0EBAF602F2::questtimerset(_id_3ACF1C0EBAF602F2::getquestdata("history").missionbasetimer, 4);
  _id_3ACF1C0EBAF602F2::addquestinstance("history", instance);
  _id_3ACF1C0EBAF602F2::startteamcontractchallenge("history", self, self.team);
  params = spawnStruct();
  params.plundervar = _id_3ACF1C0EBAF602F2::getquestplunderreward("history", _id_3ACF1C0EBAF602F2::getquestrewardtier(self.team));
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_history_quest_start_team_notify", params);
  return instance;
}

applyquest() {
  player = self;

  if(isDefined(level.questinfo.quests["history"].instances[player.team])) {
    return;
  }
  instance = givequest(player.team, "", player, "");

  if(isDefined(instance))
    instance thread oninstanceremoved();

  return instance;
}

oninstanceremoved() {
  instance = self;
  instance waittill("removed");
  instance notify("update");
}

createallhistorydestinations() {
  if(level.mapname == "mp_br_mechanics") {
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[0] = createhistorydestination((-814, -1073, 30));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[1] = createhistorydestination((174, -1394, 30));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[2] = createhistorydestination((358, -767, 30));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[3] = createhistorydestination((607, 465, 30));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[4] = createhistorydestination((33, 1106, 30));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[5] = createhistorydestination((-34, 257, 30));
  } else if(_id_3ACF1C0EBAF602F2::getquestdata("history").dvarlocations) {
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[0] = getdvarvector("dvar_2CB65FC00F6CC800", (47129, -10802, 101));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[1] = getdvarvector("dvar_2CB662C00F6CCE99", (-38441, -2006, -118));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[2] = getdvarvector("dvar_2CB661C00F6CCC66", (41891, -41209, -621));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[3] = getdvarvector("dvar_2CB664C00F6CD2FF", (-37283, -19054, 220));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[4] = getdvarvector("dvar_2CB663C00F6CD0CC", (21348, 16554, 192));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[5] = getdvarvector("dvar_2CB666C00F6CD765", (18691, -34849, -496));
  } else {
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[0] = createhistorydestination((47129, -10802, 101));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[1] = createhistorydestination((-38441, -2006, -118));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[2] = createhistorydestination((41891, -41209, -621));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[3] = createhistorydestination((-37283, -19054, 220));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[4] = createhistorydestination((21348, 16554, 192));
    _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[5] = createhistorydestination((18691, -34849, -496));
  }

  _id_3ACF1C0EBAF602F2::getquestdata("history").numrequireddestinations = getdvarint("dvar_E6E6458E790F4FC7", 1);
}

createhistorydestination(_id_5923058289B3D96B) {
  destination = spawnStruct();
  destination.origin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(_id_5923058289B3D96B, 0, -200) + (0, 0, 20);
  destination.gameobject = spawn("script_model", destination.origin);
  destination.gameobject setModel("electronics_keycard_office_02_black_gold");
  destination.gameobject.angles = (45, 0, 45);
  destination.gameobject hide();
  destination.gameobject thread _id_D2D089EE1F5A18CF();
  return destination;
}

_id_D2D089EE1F5A18CF() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", player);
    player _id_61EDE860368601BE(self);
    player playlocalsound("br_pickup_generic");
  }
}

_id_61EDE860368601BE(destination) {
  questinstance = _id_3ACF1C0EBAF602F2::getquestinstancedata("history", self.team);

  foreach(player in scripts\mp\utility\teams::getteamdata(questinstance.team, "players")) {
    questinstance.currentdestination.gameobject hidefromplayer(player);
    questinstance.currentdestination.gameobject disableplayeruse(player);
  }

  questinstance reachhistorydestination();
}

sethistorydestination() {
  if(isDefined(self.currentdestination)) {
    foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
      self.currentdestination.gameobject hidefromplayer(player);
      self.currentdestination.gameobject disableplayeruse(player);
    }
  }

  self.currentdestination = _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[self.currentdestindex];
  _id_3ACF1C0EBAF602F2::movequestobjicon(self.currentdestination.origin + (0, 0, 38));

  if(!istrue(self.currentdestination.gameobject._id_3871DBBF9F536AD6)) {
    self.currentdestination.gameobject._id_3871DBBF9F536AD6 = 1;
    self.currentdestination.gameobject disableplayeruseforallplayers();
    self.currentdestination.gameobject scripts\mp\gameobjects::sethintobject(undefined, undefined, undefined, &"MP_BR_INGAME/X1_CARD_USE", undefined, "duration_none", undefined, 200, 90, 72, 90);
    self.currentdestination.gameobject setuseprioritymax();
  }

  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    self.currentdestination.gameobject showtoplayer(player);
    self.currentdestination.gameobject enableplayeruse(player);
  }

  updatehistoryhud();
}

setfirsthistorydestination() {
  self.destorder = [];

  for(index = 0; index < _id_3ACF1C0EBAF602F2::getquestdata("history").destinations.size; index++)
    self.destorder[index] = index;

  self.destorder = scripts\engine\utility::array_randomize(self.destorder);
  self.currentdestindex = self.destorder[0];
  self.currentdestination = _id_3ACF1C0EBAF602F2::getquestdata("history").destinations[self.currentdestindex];
  sethistorydestination();
}

setnexthistorydestination() {
  self.currentdestindex = self.destorder[self.destprogress];
  sethistorydestination();
}

reachhistorydestination() {
  self.destprogress++;

  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players"))
  player scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(7);

  if(self.destprogress < _id_3ACF1C0EBAF602F2::getquestdata("history").numrequireddestinations) {
    setnexthistorydestination();
    _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_history_quest_next_destination");
  } else
    his_completemission();
}

_id_5CB7CB503AEA12C8() {
  if(istrue(self.forcefail))
    failhistoryquest();
}

his_completemission() {
  params = spawnStruct();
  rewardtier = _id_3ACF1C0EBAF602F2::getquestrewardtier(self.team);
  missionid = _id_3ACF1C0EBAF602F2::getquestindex("history");
  _id_11D65784F0B6AFA2 = _id_3ACF1C0EBAF602F2::getquestrewardgroupindex(_id_3ACF1C0EBAF602F2::getquestrewardbuildgroupref("history"));
  params.packedbits = _id_3ACF1C0EBAF602F2::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);

  if(getdvarint("dvar_4B7D23AD6FCA65D8", 1)) {
    players = level.teamdata[self.team]["alivePlayers"];
    _id_3ACF1C0EBAF602F2::displaysplashtoplayers(players, "br_history_quest_complete", params);
  } else
    _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_history_quest_complete", params);

  self.rewardorigin = self.playerlist[0].origin;
  self.rewardangles = self.playerlist[0].angles;
  self.result = "success";
  _id_3ACF1C0EBAF602F2::removequestinstance();
}

failhistoryquest() {
  self.result = "fail";
  _id_3ACF1C0EBAF602F2::removequestinstance();
}

updatehistoryhud() {
  foreach(player in self.playerlist) {
    player _id_3ACF1C0EBAF602F2::uiobjectiveshow("history");
    _id_3ACF1C0EBAF602F2::showquestobjicontoplayer(player);
  }
}

hidehistoryhudfromplayer(player) {
  _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(player);
  player _id_3ACF1C0EBAF602F2::uiobjectivehide();
}

deletehistoryhud() {
  foreach(player in self.playerlist) {
    if(isDefined(player))
      hidehistoryhudfromplayer(player);
  }

  _id_3ACF1C0EBAF602F2::deletequestobjicon();

  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players"))
  player scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(7);
}