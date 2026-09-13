/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1c3dac686aa675cc.gsc
***********************************************/

init() {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("body", ::scavengerlootcacheused);
  enabled = _id_3ACF1C0EBAF602F2::registerquestcategory("scavenger", 1);

  if(!enabled) {
    return;
  }
  _id_3ACF1C0EBAF602F2::getquestdata("scavenger").searchcirclesize = getdvarint("dvar_57CE0DF3D7742AC0", 1000);
  _id_3ACF1C0EBAF602F2::getquestdata("scavenger").missionbasetimer = getdvarint("dvar_7328883E8F0CDD91", 300);
  _id_3ACF1C0EBAF602F2::getquestdata("scavenger").missionbonustimer = getdvarint("dvar_EC09897DE5581DCB", 60);
  _id_3ACF1C0EBAF602F2::getquestdata("scavenger").resettimeronpickup = getdvarint("dvar_33443F180A916464", 1);
  _id_3ACF1C0EBAF602F2::registertabletinit("scavenger", ::sqtablet_init);
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("scavenger", ::sq_removequestinstance);
  _id_3ACF1C0EBAF602F2::registeronplayerdisconnect("scavenger", ::sq_playerdisconnect);
  _id_3ACF1C0EBAF602F2::registerquestlocale("scavenger_locale");
  _id_3ACF1C0EBAF602F2::registercreatequestlocale("scavenger_locale", ::sq_createquestlocale);
  _id_3ACF1C0EBAF602F2::registermovequestlocale("scavenger_locale", ::sq_movequestlocale);
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("scavenger_locale", ::sq_removelocaleinstance);
  _id_3ACF1C0EBAF602F2::registercheckiflocaleisavailable("scavenger_locale", ::sq_checkiflocaleisavailable);
  _id_3ACF1C0EBAF602F2::registerquestcircletick("scavenger_locale", ::sq_circletick);
  _id_3ACF1C0EBAF602F2::registeronentergulag("scavenger_locale", ::sq_entergulag);
  _id_3ACF1C0EBAF602F2::registeronrespawn("scavenger_locale", ::sq_respawn);
  _id_3ACF1C0EBAF602F2::questtimerinit("scavenger", 1);
  _id_3ACF1C0EBAF602F2::registerontimerexpired("scavenger", ::sq_ontimerexpired);
  _id_2E06828EC179F5BE = [];
  _id_2E06828EC179F5BE[0] = _id_3ACF1C0EBAF602F2::filtercondition_isdead;
  _id_3ACF1C0EBAF602F2::registerplayerfilter("scavenger", _id_2E06828EC179F5BE);
  game["dialog"]["mission_scav_accept"] = "mission_mission_scav_accept";
  game["dialog"]["mission_scav_success"] = "mission_mission_scav_success";
}

sq_removequestinstance() {
  _id_3ACF1C0EBAF602F2::releaseteamonquest(self.team);
}

sq_playerdisconnect(_id_345221032955C106) {
  if(_id_345221032955C106.team == self.team) {
    playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
    _id_3ACF1C0EBAF602F2::getquestinstancedata("scavenger_locale", self.team).playerlist = playerlist;

    if(isDefined(self.subscribedlocale) && isDefined(self.subscribedlocale.cacheentity) && playerlist.size)
      self.subscribedlocale.cacheentity setotherent(playerlist[0]);

    if(!_id_3ACF1C0EBAF602F2::isteamvalid(_id_345221032955C106.team)) {
      self.result = "fail";
      _id_3ACF1C0EBAF602F2::removequestinstance();
    }
  }
}

sq_entergulag(player) {
  if(!checkforcorrectinstance(player)) {
    return;
  }
  player _id_3ACF1C0EBAF602F2::uiobjectivehide();
  _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(player);
}

sq_respawn(player) {
  if(!checkforcorrectinstance(player)) {
    return;
  }
  player _id_3ACF1C0EBAF602F2::uiobjectiveshow("scavenger");

  if(scripts\mp\utility\game::getsubgametype() != "champion")
    _id_3ACF1C0EBAF602F2::showquestobjicontoplayer(player);
}

checkforcorrectinstance(player) {
  if(player.team == self.subscribedinstances[0].team)
    return 1;
  else
    return 0;
}

sq_createquestlocale(placement) {
  locale = _id_3ACF1C0EBAF602F2::createlocaleinstance("scavenger_locale", "scavenger", self.team);

  if(!isDefined(placement)) {
    locale.curorigin = (0, 0, 0);
    locale.enabled = 0;
    return locale;
  }

  locale _id_3ACF1C0EBAF602F2::createquestobjicon("ui_mp_mobile_contract_search_icon", "current");
  locale.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  locale.phaseindex = 0;

  if(scripts\mp\utility\game::getsubgametype() == "champion")
    level notify("quest_objective_updated_" + self.team, locale);

  _id_3ACF1C0EBAF602F2::addquestinstance("scavenger_locale", locale);
  locale setuplocalelocation(placement);
  return locale;
}

sq_movequestlocale(_id_D8E9FE11ED726936) {
  self.phaseindex++;
  result = setuplocalelocation(_id_D8E9FE11ED726936);

  if(result) {
    self.subscribedinstances[0].currlocation = _id_D8E9FE11ED726936.origin;
    _id_3ACF1C0EBAF602F2::displayteamsplash(self.subscribedinstances[0].team, "br_scavenger_quest_next_location");
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_obj_next_nptarget", self.subscribedinstances[0].team, 1);

    if(istrue(_id_3ACF1C0EBAF602F2::getquestdata("scavenger").resettimeronpickup))
      self.subscribedinstances[0] _id_3ACF1C0EBAF602F2::questtimerset(_id_3ACF1C0EBAF602F2::getquestdata("scavenger").missionbasetimer, 1);
    else
      self.subscribedinstances[0] _id_3ACF1C0EBAF602F2::questtimeradd(_id_3ACF1C0EBAF602F2::getquestdata("scavenger").missionbonustimer);
  }
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

    if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk") {
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

  disablelootspawnpoint(_id_D8E9FE11ED726936.index);
  spawnscavengerlootcache(_id_D8E9FE11ED726936.origin, _id_D8E9FE11ED726936.angles, self);
  self.curorigin = _id_D8E9FE11ED726936.origin + (0, 0, 50);
  _id_3ACF1C0EBAF602F2::movequestobjicon(self.curorigin);
  updatescavengerhud();
  return 1;
}

sq_removelocaleinstance() {
  deletescavengerhud();
  self.playerlist = undefined;
  self.subscribedinstances = undefined;

  if(isDefined(self.cacheentity)) {
    if(self.cacheentity getscriptablepartstate("body") == "scavenger_closed")
      self.cacheentity delete();
  }
}

sq_circletick(_id_819EDACDACB810E4, _id_E86632D645C137D0) {
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
    instance failscavengerquest();
  }
}

sq_checkiflocaleisavailable() {
  return 0;
}

takequestitem(pickupent) {
  instance = _id_3ACF1C0EBAF602F2::createquestinstance("scavenger", self.team, pickupent.index, pickupent);
  instance _id_3ACF1C0EBAF602F2::registerteamonquest(self.team, self);
  instance _id_3ACF1C0EBAF602F2::registercontributingplayers(self);
  instance.team = self.team;
  instance.startlocation = self.origin;
  instance.currlocation = self.origin;
  instance.reservedplacement = pickupent.reservedplacement;
  _id_354D1457278B342C = lootcachesearchparams(instance.startlocation, instance.reservedplacement[0]);
  locale = instance _id_3ACF1C0EBAF602F2::requestquestlocale("scavenger_locale", _id_354D1457278B342C, 1);

  if(!locale.enabled) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("br_assassination_notargets", undefined, 5);
    instance.result = "no_locale";
    instance _id_3ACF1C0EBAF602F2::releaseteamonquest(self.team);
    _id_E141356311900568 = spawnStruct();
    _id_E141356311900568.origin = pickupent.origin;
    _id_E141356311900568.angles = pickupent.angles;
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk") {
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

  _id_3ACF1C0EBAF602F2::uiobjectiveshowtoteam("scavenger", self.team);
  instance.totalscavengeditems = 0;
  instance _id_3ACF1C0EBAF602F2::questtimerset(_id_3ACF1C0EBAF602F2::getquestdata("scavenger").missionbasetimer, 4);
  _id_3ACF1C0EBAF602F2::addquestinstance("scavenger", instance);
  _id_3ACF1C0EBAF602F2::startteamcontractchallenge("scavenger", self, self.team);
  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self;
  params.plundervar = _id_3ACF1C0EBAF602F2::getquestplunderreward("scavenger", _id_3ACF1C0EBAF602F2::getquestrewardtier(self.team));
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_scavenger_quest_start_team", params);
  _id_3ACF1C0EBAF602F2::displayplayersplash(self, "br_scavenger_quest_start_tablet_finder", params);

  if(!_id_2CEDCC356F1B9FC8::istutorial())
    _id_3ACF1C0EBAF602F2::giveteampoints(self.team, "stat_67EB4B642067882A");

  _id_3ACF1C0EBAF602F2::displaysquadmessagetoteam(instance.team, self, 6, _id_3ACF1C0EBAF602F2::getquestindex("scavenger"));
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_scav_accept", instance.team, 1);
}

lootcachesearchparams(searchcircleorigin, reservedplacement) {
  _id_354D1457278B342C = spawnStruct();
  _id_354D1457278B342C.searchfunc = "getUnusedLootCacheArray";
  _id_354D1457278B342C.searchcircleorigin = searchcircleorigin;
  _id_354D1457278B342C.searchradiusmax = 10000;
  _id_354D1457278B342C.searchradiusmin = 0;
  _id_354D1457278B342C.searchradiusidealmax = 4000;
  _id_354D1457278B342C.searchradiusidealmin = 2000;
  _id_354D1457278B342C.searchforcecirclecenter = 1;
  _id_354D1457278B342C.reservedplacement = reservedplacement;
  _id_354D1457278B342C.mintime = 45;

  if(gametypeoverridescavsearchparams()) {
    if(_id_354D1457278B342C.searchradiusmax < level.quest_scavdistmax)
      _id_354D1457278B342C.searchradiusmax = level.quest_scavdistmax;

    _id_354D1457278B342C.searchradiusidealmax = level.quest_scavdistmax;
    _id_354D1457278B342C.searchradiusidealmin = level.quest_scavdistmin;
  }

  return _id_354D1457278B342C;
}

gametypeoverridescavsearchparams() {
  _id_9254FE14251C6557 = 0;
  gametype = scripts\mp\utility\game::getsubgametype();

  switch (gametype) {
    case "vanilla":
    case "mini_mgl":
    case "mini":
    case "risk":
    case "plunder":
      _id_9254FE14251C6557 = 1;
      break;
  }

  return _id_9254FE14251C6557;
}

completescavengerquest(chest) {
  params = spawnStruct();
  rewardtier = _id_3ACF1C0EBAF602F2::getquestrewardtier(self.team);
  missionid = _id_3ACF1C0EBAF602F2::getquestindex("scavenger");
  _id_11D65784F0B6AFA2 = _id_3ACF1C0EBAF602F2::getquestrewardgroupindex(_id_3ACF1C0EBAF602F2::getquestrewardbuildgroupref("scavenger"));
  params.packedbits = _id_3ACF1C0EBAF602F2::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);

  if(!_id_2CEDCC356F1B9FC8::istutorial()) {
    _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_scavenger_quest_complete", params);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_scav_success", self.team, 1, 1);
  }

  self.rewardorigin = chest.origin;
  self.rewardangles = chest.angles;
  self.result = "success";
  _id_3ACF1C0EBAF602F2::removequestinstance();

  if(isDefined(level._id_52781BE0B4E8A959))
    level[[level._id_52781BE0B4E8A959]](self.team);
}

failscavengerquest() {
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_scavenger_quest_circle_failure");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_obj_circle_fail", self.team, 1);
  self.result = "fail";
  _id_3ACF1C0EBAF602F2::removequestinstance();
}

updatescavengerhud() {
  foreach(player in self.playerlist)
  player _id_3ACF1C0EBAF602F2::uiobjectivesetparameter(self.phaseindex);

  if(scripts\mp\utility\game::getsubgametype() == "champion") {
    return;
  }
  players = _id_3ACF1C0EBAF602F2::sortvalidplayersinarray(self.playerlist);

  foreach(player in players["valid"]) {
    player _id_3ACF1C0EBAF602F2::uiobjectiveshow("scavenger");
    _id_3ACF1C0EBAF602F2::showquestobjicontoplayer(player);
  }

  foreach(player in players["invalid"]) {
    player _id_3ACF1C0EBAF602F2::uiobjectivehide();
    _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(player);
  }
}

hidescavengerhudfromplayer(player) {
  _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(player);
  player _id_3ACF1C0EBAF602F2::uiobjectivehide();
}

deletescavengerhud() {
  foreach(player in self.playerlist)
  hidescavengerhudfromplayer(player);

  _id_3ACF1C0EBAF602F2::deletequestobjicon();
}

sq_ontimerexpired() {
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_scavenger_quest_timer_expired");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", self.team, 1);
}

spawnscavengerlootcache(_id_7E05C139FBBD8374, _id_5B9C864B21207FF6, locale) {
  cacheentity = spawn("script_model", _id_7E05C139FBBD8374);
  _id_7F599ACCB72658D1 = locale.playerlist[0];
  cacheentity.angles = _id_5B9C864B21207FF6;
  cacheentity setotherent(_id_7F599ACCB72658D1);
  cacheentity setModel("military_loot_crate_01_br_scavenger_01");
  cacheentity setscriptablepartstate("body", "scavenger_closed");
  cacheentity.questlocale = locale;
  locale.cacheentity = cacheentity;

  foreach(player in level.players) {
    if(player != _id_7F599ACCB72658D1 && (_id_7F599ACCB72658D1.team == "none" || player.team != _id_7F599ACCB72658D1.team))
      cacheentity disablescriptableplayeruse(player);
  }
}

scavengerlootcacheused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(istrue(player _id_362C58E8BB39BCDA::runbrgametypefunc("playerSkipLootPickup", instance))) {
    return;
  }
  if(state == "scavenger_closed" && isDefined(instance.entity)) {
    questinstance = instance.entity.questlocale.subscribedinstances[0];

    if(player.team != questinstance.team) {
      player iprintlnbold("Chest Requires a Scavenger Mission");
      return;
    }

    instance setscriptablepartstate("body", "scavenger_opening");
    _id_C0858ACEEA4BB7D9 = getdvarint("dvar_28B9017071772839", 30);
    instance.entity scripts\engine\utility::_id_AD9433AAB9FCDF04(_id_C0858ACEEA4BB7D9, "death_or_disconnect", ::delete);
    questinstance _id_3ACF1C0EBAF602F2::registercontributingplayers(player);

    switch (instance.entity.questlocale.phaseindex) {
      case 0:
        _id_3ACF1C0EBAF602F2::givequestrewardgroup("scavenger_1", player.team, instance.origin, instance.angles, questinstance.rewardscriptable);
        break;
      case 1:
        _id_3ACF1C0EBAF602F2::givequestrewardgroup("scavenger_2", player.team, instance.origin, instance.angles, questinstance.rewardscriptable);
        break;
      case 3:
        break;
    }

    if(instance.entity.questlocale.phaseindex == 2) {
      questinstance.rewardorigin = instance.origin;
      questinstance.rewardangles = instance.angles;
      _id_3ACF1C0EBAF602F2::displaysquadmessagetoteam(questinstance.team, player, 8, _id_3ACF1C0EBAF602F2::getquestindex("scavenger"));
      questinstance completescavengerquest(instance.entity);
    } else {
      _id_3ACF1C0EBAF602F2::displaysquadmessagetoteam(questinstance.team, player, 7, _id_3ACF1C0EBAF602F2::getquestindex("scavenger"));
      _id_354D1457278B342C = lootcachesearchparams(instance.origin, questinstance.reservedplacement[instance.entity.questlocale.phaseindex + 1]);
      instance.entity.questlocale _id_3ACF1C0EBAF602F2::movequestlocale("scavenger_locale", _id_354D1457278B342C);
    }

    level notify("lootcache_opened_kill_callout" + instance.origin);
    _id_96674628376EABA6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](player.team, 0);

    foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6)
    _id_F0EA4030349A33D5 notify("calloutmarkerping_warzoneKillQuestIcon");
  }
}

sqtablet_init() {
  self.reservedplacement = [];
  _id_AA9D61F3C51B6A77 = self.origin;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    _id_354D1457278B342C = lootcachesearchparams(_id_AA9D61F3C51B6A77);
    placement = _id_3ACF1C0EBAF602F2::findquestplacement("scavenger", _id_354D1457278B342C);

    if(!isDefined(placement))
      return 0;

    disablelootspawnpoint(placement.index);
    _id_AA9D61F3C51B6A77 = placement.origin;
    self.reservedplacement[_id_AC0E594AC96AA3A8] = placement;
  }

  return 1;
}