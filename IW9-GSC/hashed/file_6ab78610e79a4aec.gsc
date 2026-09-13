/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6ab78610e79a4aec.gsc
***********************************************/

init() {
  enabled = _id_3ACF1C0EBAF602F2::registerquestcategory("timedrun", 1);

  if(!enabled) {
    return;
  }
  _id_3ACF1C0EBAF602F2::getquestdata("timedrun").missionbasetimer = getdvarint("dvar_73B9A21075D1C16F", 120);
  _id_3ACF1C0EBAF602F2::getquestdata("timedrun").kiosksearchradiusmax = getdvarint("dvar_D2B0F83481549836", 23000);
  _id_3ACF1C0EBAF602F2::getquestdata("timedrun").kiosksearchradiusmin = getdvarint("dvar_D28D0A34812C4514", 10000);
  _id_3ACF1C0EBAF602F2::getquestdata("timedrun").kiosksearchradiusidealmax = getdvarint("dvar_E87E65B835A44C31", 23000);
  _id_3ACF1C0EBAF602F2::getquestdata("timedrun").kiosksearchradiusidealmin = getdvarint("dvar_E8A257B835CCA81F", 17000);
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("timedrun", ::tr_removequestinstance);
  _id_3ACF1C0EBAF602F2::registeronplayerdisconnect("timedrun", ::tr_playerdisconnect);

  if(!enabled) {
    return;
  }
  _id_3ACF1C0EBAF602F2::registertabletinit("timedrun", ::trtablet_init);
  _id_3ACF1C0EBAF602F2::registerquestlocale("timedrun_locale");
  _id_3ACF1C0EBAF602F2::registercreatequestlocale("timedrun_locale", ::tr_createquestlocale);
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("timedrun_locale", ::tr_removelocaleinstance);
  _id_3ACF1C0EBAF602F2::registeronentergulag("timedrun_locale", ::tr_entergulag);
  _id_3ACF1C0EBAF602F2::registeronrespawn("timedrun_locale", ::tr_respawn);
  _id_3ACF1C0EBAF602F2::registerquestcircletick("timedrun_locale", ::tr_circletick);
  _id_3ACF1C0EBAF602F2::registerquestthink("timedrun_locale", ::tr_detectwinners, 0.1);
  game["dialog"]["mission_timedrun_accept"] = "mission_mission_time_accept";
  game["dialog"]["mission_timedrun_fail"] = "mission_mission_time_failed";
}

trtablet_init() {
  _id_354D1457278B342C = tr_kiosksearchparams(self);
  placement = _id_3ACF1C0EBAF602F2::findquestplacement("timedrun", _id_354D1457278B342C);

  if(!isDefined(placement))
    return 0;

  self.reservedplacement = placement;
  return 1;
}

takequestitem(pickupent) {
  instance = _id_3ACF1C0EBAF602F2::createquestinstance("timedrun", self.team, pickupent.index, pickupent);
  instance _id_3ACF1C0EBAF602F2::registerteamonquest(self.team, self);
  instance.team = self.team;
  instance.startlocation = self.origin;
  instance.startplayer = self;
  _id_3ACF1C0EBAF602F2::giveteampoints(self.team, "stat_67EB4B642067882A");
  _id_11697EC79FBC884C = tr_kiosksearchparams(pickupent);
  instance.starttime = gettime();
  locale = instance _id_3ACF1C0EBAF602F2::requestquestlocale("timedrun_locale", _id_11697EC79FBC884C, 1);
  locale.team = self.team;

  if(!locale.enabled) {
    instance.result = "no_locale";
    instance _id_3ACF1C0EBAF602F2::releaseteamonquest(self.team);
    _id_E141356311900568 = spawnStruct();
    _id_E141356311900568.origin = pickupent.origin;
    _id_E141356311900568.angles = pickupent.angles;
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder") {
      _id_6B5E1783915835C1 = "mp/loot_set_cache_contents_dmz.csv";
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 1, "health", _id_6B5E1783915835C1);
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 2, "ammo", _id_6B5E1783915835C1);
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 1, 1, "plunder", _id_6B5E1783915835C1);
    } else {
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 1, "health");
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 2, "ammo");
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 1, 1, "plunder");
    }

    return;
  }

  _id_3ACF1C0EBAF602F2::questtimerinit("timedrun", 1);
  _id_3ACF1C0EBAF602F2::registerontimerexpired("timedrun", ::tr_ontimerexpired);
  instance _id_3ACF1C0EBAF602F2::questtimerset(getdvarint("dvar_7DE6F07B99F49585", getdvarint("dvar_73B9A21075D1C16F", 120)), 4);
  _id_3ACF1C0EBAF602F2::addquestinstance("timedrun", instance);
  _id_3ACF1C0EBAF602F2::startteamcontractchallenge("timedrun", self, self.team);
  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self;
  params.plundervar = _id_3ACF1C0EBAF602F2::getquestplunderreward("timedrun", _id_3ACF1C0EBAF602F2::getquestrewardtier(self.team));
  _id_3ACF1C0EBAF602F2::displayplayersplash(self, "br_timedrun_quest_start_tablet_finder", params);
  _id_3ACF1C0EBAF602F2::displayteamsplash(instance.team, "br_timedrun_quest_start_team_notify", params);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_timedrun_accept", instance.team, 1, 1);
}

checkforcorrectinstance(player) {
  if(player.team == self.subscribedinstances[0].team)
    return 1;
  else
    return 0;
}

tr_vehiclesearchparams(searchcircleorigin) {
  _id_354D1457278B342C = spawnStruct();
  _id_354D1457278B342C.searchfunc = "GetEntitylessScriptableArray";
  _id_354D1457278B342C.searchcircleorigin = searchcircleorigin;
  _id_354D1457278B342C.searchradiusmax = 6000;
  _id_354D1457278B342C.searchradiusmin = 0;
  _id_354D1457278B342C.searchradiusidealmax = 4000;
  _id_354D1457278B342C.searchradiusidealmin = 0;
  _id_354D1457278B342C.mintime = 1;
  return _id_354D1457278B342C;
}

tr_kiosksearchparams(tablet) {
  _id_354D1457278B342C = spawnStruct();
  _id_354D1457278B342C.searchfunc = "getKiosks";
  _id_354D1457278B342C.partname = "br_plunder_box";
  _id_354D1457278B342C.statename = "visible";
  _id_354D1457278B342C.searchcircleorigin = tablet.origin;
  _id_354D1457278B342C.searchradiusmax = _id_3ACF1C0EBAF602F2::getquestdata("timedrun").kiosksearchradiusmax;
  _id_354D1457278B342C.searchradiusmin = _id_3ACF1C0EBAF602F2::getquestdata("timedrun").kiosksearchradiusmin;
  _id_354D1457278B342C.searchradiusidealmax = _id_3ACF1C0EBAF602F2::getquestdata("timedrun").kiosksearchradiusidealmax;
  _id_354D1457278B342C.searchradiusidealmin = _id_3ACF1C0EBAF602F2::getquestdata("timedrun").kiosksearchradiusidealmin;
  _id_354D1457278B342C.searchforcecirclecenter = 1;
  _id_354D1457278B342C.reservedplacement = tablet.reservedplacement;
  _id_354D1457278B342C.mintime = 1;
  return _id_354D1457278B342C;
}

tr_findvehicle(_id_354D1457278B342C) {
  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(distance2d(self.startlocation, player.origin) < 1500) {
      if(isDefined(player.vehicle))
        return;
    }
  }

  _id_BD572A35F03CED5B = getentarrayinradius("script_vehicle", "classname", _id_354D1457278B342C.searchcircleorigin, _id_354D1457278B342C.searchradiusmax);
  _id_BD572A35F03CED5B = sortbydistance(_id_BD572A35F03CED5B, _id_354D1457278B342C.searchcircleorigin);

  foreach(vehicle in _id_BD572A35F03CED5B) {
    if(vehicle.isempty) {
      self.targetvehicle = vehicle;
      break;
    } else if(vehicle.ownerteam == self.team) {
      break;
    }
  }

  if(!isDefined(self.targetvehicle)) {
    return;
  }
  self.vehicleoutline = scripts\mp\utility\outline::outlineenableforteam(self.targetvehicle, self.team, "outlinefill_nodepth_yellow", "level_script");
  thread cleanupvehicleoutline();
  thread watchforentervehicle();
}

watchforentervehicle() {
  level endon("game_ended");
  self endon("remove_TR_Outline");
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  scripts\engine\utility::waittill_any_ents_array(_id_A6AB8D0FDA441DC2, "vehicle_enter");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(distance2d(player.origin, self.targetvehicle.origin) < 2000) {
      scripts\mp\utility\outline::outlinedisable(self.vehicleoutline, self.targetvehicle);
      self notify("remove_TR_Outline");
    }
  }
}

cleanupvehicleoutline() {
  level endon("game_ended");
  self endon("remove_TR_Outline");

  for(;;) {
    if(self.targetvehicle.isempty != 1 || gettime() > self.starttime + 60000) {
      scripts\mp\utility\outline::outlinedisable(self.vehicleoutline, self.targetvehicle);
      self notify("remove_TR_Outline");
    }

    wait 0.2;
  }
}

tr_createquestlocale(placement) {
  locale = _id_3ACF1C0EBAF602F2::createlocaleinstance("timedrun_locale", "timedrun", self.team);

  if(!isDefined(placement)) {
    locale.curorigin = (0, 0, 0);
    locale.enabled = 0;
    return locale;
  }

  locale.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  locale.curorigin = placement.origin;
  locale _id_3ACF1C0EBAF602F2::createquestobjicon("ui_mp_mobile_contract_timedrun_icon", "current", locale.curorigin + (0, 0, 65));
  _id_3ACF1C0EBAF602F2::addquestinstance("timedrun_locale", locale);
  locale setuplocalelocation(placement);
  return locale;
}

setuplocalelocation(_id_D8E9FE11ED726936) {
  if(!isDefined(_id_D8E9FE11ED726936)) {
    instance = self.subscribedinstances[0];

    foreach(player in scripts\mp\utility\teams::getteamdata(instance.team, "players"))
    player scripts\mp\utility\lower_message::setlowermessageomnvar("br_assassination_notargets", undefined, 5);

    instance.result = "no_locale";
    _id_E141356311900568 = spawnStruct();
    _id_E141356311900568.origin = self.curorigin;
    _id_E141356311900568.angles = (0, 0, 0);
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder") {
      _id_6B5E1783915835C1 = "mp/loot_set_cache_contents_dmz.csv";
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 1, "health", _id_6B5E1783915835C1);
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 2, "ammo", _id_6B5E1783915835C1);
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 1, 1, "plunder", _id_6B5E1783915835C1);
    } else {
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 1, "health");
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 2, "ammo");
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 1, 1, "plunder");
    }

    instance _id_3ACF1C0EBAF602F2::removequestinstance();
    return 0;
  }

  self.targetkiosk = _id_D8E9FE11ED726936;
  thread timedrun_finishlinevfx(self.targetkiosk.origin);
  updatetimedrunhud();
  return 1;
}

timedrun_finishlinevfx(spawn_origin, team) {
  finishlinevfx = spawnfx(level._effect["vfx_marker_base_orange_pulse"], spawn_origin + (0, 0, 10));
  finishlinevfx.angles = vectortoangles((0, 0, 1));
  finishlinevfx hide();
  wait 0.5;
  triggerfx(finishlinevfx);

  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players"))
  finishlinevfx showtoplayer(player);

  self.finishlinevfx = finishlinevfx;
}

tr_removequestinstance() {
  _id_3ACF1C0EBAF602F2::releaseteamonquest(self.team);
}

tr_removelocaleinstance() {
  deletetimedrunhud();
  self.finishlinevfx delete();
  self.playerlist = undefined;
  self.subscribedinstances = undefined;
}

tr_detectwinners() {
  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(distance(player.origin, self.curorigin) < 150)
      self.subscribedinstances[0] completetimedrunquest(self.targetkiosk);
  }
}

completetimedrunquest(_id_15B89FF206500554) {
  params = spawnStruct();
  rewardtier = _id_3ACF1C0EBAF602F2::getquestrewardtier(self.team);
  missionid = _id_3ACF1C0EBAF602F2::getquestindex("timedrun");
  _id_11D65784F0B6AFA2 = _id_3ACF1C0EBAF602F2::getquestrewardgroupindex(_id_3ACF1C0EBAF602F2::getquestrewardbuildgroupref("timedrun"));
  params.packedbits = _id_3ACF1C0EBAF602F2::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_timedrun_quest_complete", params);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_misc_success", self.team, 1, 1);
  _id_51F2B611A0573B40 = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(player in _id_51F2B611A0573B40) {
    if(isDefined(player) && !istrue(player.br_iseliminated))
      _id_4384ABBF498DF6A7::kiosksetupfiresaleforplayer(_id_15B89FF206500554, player);
  }

  self.rewardmodifier = undefined;
  self.result = "success";
  _id_3ACF1C0EBAF602F2::removequestinstance();
}

failtimedrunquest() {
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_timedrun_quest_circle_failure");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_obj_circle_fail", self.team, 1, 1);
  self.result = "fail";
  _id_3ACF1C0EBAF602F2::removequestinstance();
}

tr_ontimerexpired() {
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_timedrun_quest_timer_expired");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_timedrun_fail", self.team, 1, 1);
}

tr_circletick(_id_819EDACDACB810E4, _id_E86632D645C137D0) {
  if(!isDefined(self.lastcircletick))
    self.lastcircletick = -1;

  currenttime = gettime();

  if(self.lastcircletick == currenttime) {
    return;
  }
  self.lastcircletick = currenttime;
  dist = distance2d(self.curorigin, _id_819EDACDACB810E4);

  if(dist > _id_E86632D645C137D0) {
    foreach(instance in self.subscribedinstances)
    instance failtimedrunquest();
  }
}

tr_playerdisconnect(_id_345221032955C106) {
  if(_id_345221032955C106.team == self.team) {
    _id_3ACF1C0EBAF602F2::getquestinstancedata("timedrun_locale", self.team).playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");

    if(!_id_3ACF1C0EBAF602F2::isteamvalid(_id_345221032955C106.team)) {
      self.result = "fail";
      _id_3ACF1C0EBAF602F2::removequestinstance();
    }
  }
}

tr_entergulag(player) {
  if(!checkforcorrectinstance(player)) {
    return;
  }
  player _id_3ACF1C0EBAF602F2::uiobjectivehide();
  _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(player);
}

tr_respawn(player) {
  if(scripts\mp\utility\game::getsubgametype() == "champion" || !checkforcorrectinstance(player)) {
    return;
  }
  player _id_3ACF1C0EBAF602F2::uiobjectiveshow("timedrun");
  _id_3ACF1C0EBAF602F2::showquestobjicontoplayer(player);
}

updatetimedrunhud() {
  if(scripts\mp\utility\game::getsubgametype() == "champion") {
    level notify("quest_objective_updated_" + self.id, self);

    foreach(player in self.playerlist)
    player _id_3ACF1C0EBAF602F2::uiobjectiveshow("timedrun");

    return;
  }

  players = _id_3ACF1C0EBAF602F2::sortvalidplayersinarray(self.playerlist);

  foreach(player in players["valid"]) {
    player _id_3ACF1C0EBAF602F2::uiobjectiveshow("timedrun");
    _id_3ACF1C0EBAF602F2::showquestobjicontoplayer(player);
  }

  foreach(player in players["invalid"]) {
    player _id_3ACF1C0EBAF602F2::uiobjectivehide();
    _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(player);
  }
}

hidetimedrunhudfromplayer(player) {
  _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(player);
  player _id_3ACF1C0EBAF602F2::uiobjectivehide();
}

deletetimedrunhud() {
  foreach(player in self.playerlist)
  hidetimedrunhudfromplayer(player);

  _id_3ACF1C0EBAF602F2::deletequestobjicon();
}