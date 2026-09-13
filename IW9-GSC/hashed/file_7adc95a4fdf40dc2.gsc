/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7adc95a4fdf40dc2.gsc
***********************************************/

init() {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("body", ::scavengerlootcacheused);
  enabled = _id_029458C0B233BE34::registerquestcategory("scavenger", 1);
  _id_029458C0B233BE34::getquestdata("scavenger").missionbasetimer = getdvarint("dvar_7328883E8F0CDD91", 300);
  _id_029458C0B233BE34::getquestdata("scavenger").missionbonustimer = getdvarint("dvar_EC09897DE5581DCB", 60);
  _id_029458C0B233BE34::getquestdata("scavenger").resettimeronpickup = getdvarint("dvar_33443F180A916464", 1);
  _id_029458C0B233BE34::registertabletinit("scavenger", ::sqtablet_init);
  _id_029458C0B233BE34::registerremovequestinstance("scavenger", ::sq_removequestinstance);
  _id_029458C0B233BE34::registeronplayerdisconnect("scavenger", ::sq_playerdisconnect);
  _id_029458C0B233BE34::registerquestlocale("scavenger_locale");
  _id_029458C0B233BE34::registercreatequestlocale("scavenger_locale", ::sq_createquestlocale);
  _id_029458C0B233BE34::registermovequestlocale("scavenger_locale", ::sq_movequestlocale);
  _id_029458C0B233BE34::registerremovequestinstance("scavenger_locale", ::sq_removelocaleinstance);
  _id_029458C0B233BE34::registercheckiflocaleisavailable("scavenger_locale", ::sq_checkiflocaleisavailable);
  _id_029458C0B233BE34::registeronentergulag("scavenger_locale", ::sq_entergulag);
  _id_029458C0B233BE34::registeronrespawn("scavenger_locale", ::sq_respawn);
  _id_029458C0B233BE34::questtimerinit("scavenger", 0);
  _id_029458C0B233BE34::registerontimerexpired("scavenger", ::sq_ontimerexpired);
  _id_2E06828EC179F5BE = [];
  _id_2E06828EC179F5BE[0] = _id_029458C0B233BE34::filtercondition_isdead;
  _id_029458C0B233BE34::registerplayerfilter("scavenger", _id_2E06828EC179F5BE);
}

sq_removequestinstance() {
  _id_029458C0B233BE34::releaseteamonquest(self.team);
}

sq_playerdisconnect(_id_345221032955C106) {
  if(_id_345221032955C106.team == self.team) {
    playerlist = scripts\cp\utility::getplayersinteam(self.team);
    _id_029458C0B233BE34::getquestinstancedata("scavenger_locale", self.team).playerlist = playerlist;

    if(isDefined(self.subscribedlocale) && isDefined(self.subscribedlocale.cacheentity) && playerlist.size)
      self.subscribedlocale.cacheentity setotherent(playerlist[0]);

    if(!_id_029458C0B233BE34::isteamvalid(_id_345221032955C106.team)) {
      self.result = "fail";
      _id_029458C0B233BE34::removequestinstance();
    }
  }
}

sq_entergulag(player) {}

sq_respawn(player) {}

checkforcorrectinstance(player) {}

sq_createquestlocale(placement) {
  locale = _id_029458C0B233BE34::createlocaleinstance("scavenger_locale", "scavenger", self.team);

  if(!isDefined(placement)) {
    locale.curorigin = (0, 0, 0);
    locale.enabled = 0;
    return locale;
  }

  locale _id_029458C0B233BE34::createquestobjicon("ui_mp_br_mapmenu_icon_scavengerhunt_objective", "current");
  locale.playerlist = scripts\cp\utility::getplayersinteam(self.team);
  locale.phaseindex = 0;
  _id_029458C0B233BE34::addquestinstance("scavenger_locale", locale);
  locale setuplocalelocation(placement);
  return locale;
}

sq_movequestlocale(_id_D8E9FE11ED726936) {
  self.phaseindex++;
  result = setuplocalelocation(_id_D8E9FE11ED726936);

  if(result) {
    self.subscribedinstances[0].currlocation = _id_D8E9FE11ED726936.origin;
    _id_029458C0B233BE34::displayteamsplash(self.subscribedinstances[0].team, "br_scavenger_quest_next_location");

    if(istrue(_id_029458C0B233BE34::getquestdata("scavenger").resettimeronpickup))
      self.subscribedinstances[0] _id_029458C0B233BE34::questtimerset(_id_029458C0B233BE34::getquestdata("scavenger").missionbasetimer, 1);
    else
      self.subscribedinstances[0] _id_029458C0B233BE34::questtimeradd(_id_029458C0B233BE34::getquestdata("scavenger").missionbonustimer);
  }
}

setuplocalelocation(_id_D8E9FE11ED726936) {
  if(!isDefined(_id_D8E9FE11ED726936)) {
    instance = self.subscribedinstances[0];
    instance.result = "no_locale";
    _id_E141356311900568 = spawnStruct();
    _id_E141356311900568.origin = self.curorigin;
    _id_E141356311900568.angles = (0, 0, 0);
    _id_E141356311900568.itemsdropped = 0;
    instance _id_029458C0B233BE34::removequestinstance();
    return 0;
  }

  _id_029458C0B233BE34::_id_645F05D6B8A3A257(_id_D8E9FE11ED726936.index);
  spawnscavengerlootcache(_id_D8E9FE11ED726936.origin, _id_D8E9FE11ED726936.angles, self);
  self.curorigin = _id_D8E9FE11ED726936.origin + (0, 0, 50);
  _id_029458C0B233BE34::movequestobjicon(self.curorigin);
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

sq_circletick(_id_819EDACDACB810E4, _id_E86632D645C137D0) {}

sq_checkiflocaleisavailable() {
  return 0;
}

takequestitem(pickupent) {
  instance = _id_029458C0B233BE34::createquestinstance("scavenger", self.team, pickupent.index, pickupent);
  instance _id_029458C0B233BE34::registerteamonquest(self.team, self);
  instance _id_029458C0B233BE34::registercontributingplayers(self);
  instance.team = self.team;
  instance.startlocation = self.origin;
  instance.currlocation = self.origin;
  instance.tablet = pickupent;
  instance.tablet.keepinmap = 1;
  _id_988C3FD02BCBD450 = scripts\engine\utility::getStructArray("tablet_spawn", "targetname");
  current_struct = scripts\engine\utility::getclosest(self.origin, _id_988C3FD02BCBD450);
  instance._id_A52C81F5E957AA03 = current_struct;
  instance._id_291CEE6DCDEAA433 = [];
  instance._id_BA39C0BD611CE3F3 = self.origin;
  instance._id_291CEE6DCDEAA433 = _id_029458C0B233BE34::_id_61816329786A4614(current_struct, "scavenger_search_region");

  if(isDefined(instance._id_291CEE6DCDEAA433) && instance._id_291CEE6DCDEAA433.size > 0) {
    if(isDefined(instance._id_291CEE6DCDEAA433[0]))
      instance._id_BA39C0BD611CE3F3 = instance._id_291CEE6DCDEAA433[0];
  }

  _id_029458C0B233BE34::_id_AFB3C7102E36A404(instance);
  _id_029458C0B233BE34::_id_5B04CC6859711D68(instance);
  _id_029458C0B233BE34::_id_2247D0E9C5C2A383(instance);
  reservedplacement = undefined;

  if(isDefined(instance.reservedplacement))
    reservedplacement = instance.reservedplacement[0];

  _id_354D1457278B342C = lootcachesearchparams(instance._id_BA39C0BD611CE3F3.origin, reservedplacement, instance._id_BA39C0BD611CE3F3.radius);
  locale = instance _id_029458C0B233BE34::requestquestlocale("scavenger_locale", _id_354D1457278B342C, 1);

  if(!locale.enabled) {
    instance.result = "no_locale";
    instance _id_029458C0B233BE34::releaseteamonquest(self.team);
    _id_E141356311900568 = spawnStruct();
    _id_E141356311900568.origin = pickupent.origin;
    _id_E141356311900568.angles = pickupent.angles;
    _id_E141356311900568.itemsdropped = 0;
    return;
  }

  level thread _id_029458C0B233BE34::_id_7BCB36BCE60B1F7A(instance);
  _id_029458C0B233BE34::uiobjectiveshowtoteam("scavenger", self.team);
  instance.totalscavengeditems = 0;
  instance _id_029458C0B233BE34::questtimerset(_id_029458C0B233BE34::getquestdata("scavenger").missionbasetimer, 4);
  _id_029458C0B233BE34::addquestinstance("scavenger", instance);
  _id_029458C0B233BE34::startteamcontractchallenge("scavenger", self, self.team);
  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self;
  params.plundervar = _id_029458C0B233BE34::getquestplunderreward("scavenger", _id_029458C0B233BE34::getquestrewardtier(self.team));
  _id_029458C0B233BE34::displayteamsplash(self.team, "br_scavenger_quest_start_team", params);
  _id_029458C0B233BE34::displayplayersplash(self, "br_scavenger_quest_start_tablet_finder", params);
  _id_029458C0B233BE34::displaysquadmessagetoteam(instance.team, self, 6, _id_029458C0B233BE34::getquestindex("scavenger"));
}

lootcachesearchparams(searchcircleorigin, reservedplacement, _id_921B9D1AB6394420) {
  _id_354D1457278B342C = spawnStruct();
  _id_354D1457278B342C.searchfunc = "getUnusedLootCacheArrayRegion";
  _id_354D1457278B342C.searchcircleorigin = searchcircleorigin;
  _id_354D1457278B342C.searchradiusmax = 10000;
  _id_354D1457278B342C.searchradiusmin = 0;
  _id_354D1457278B342C.searchradiusidealmax = 4000;
  _id_354D1457278B342C.searchradiusidealmin = 1000;
  _id_354D1457278B342C.searchforcecirclecenter = 1;
  _id_354D1457278B342C.reservedplacement = reservedplacement;
  _id_354D1457278B342C.mintime = 45;

  if(isDefined(_id_921B9D1AB6394420))
    _id_354D1457278B342C.searchradiusidealmax = _id_921B9D1AB6394420;

  return _id_354D1457278B342C;
}

completescavengerquest(chest) {
  params = spawnStruct();
  rewardtier = _id_029458C0B233BE34::getquestrewardtier(self.team);
  missionid = _id_029458C0B233BE34::getquestindex("scavenger");
  _id_11D65784F0B6AFA2 = _id_029458C0B233BE34::getquestrewardgroupindex(_id_029458C0B233BE34::getquestrewardbuildgroupref("scavenger"));
  params.packedbits = _id_029458C0B233BE34::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);
  _id_029458C0B233BE34::displayteamsplash("allies", "br_scavenger_quest_complete", params);
  self.rewardorigin = chest.origin;
  self.rewardangles = chest.angles;
  self.result = "success";
  _id_029458C0B233BE34::removequestinstance();
}

failscavengerquest() {
  _id_029458C0B233BE34::displayteamsplash(self.team, "br_scavenger_quest_circle_failure");
  self.result = "fail";
  _id_029458C0B233BE34::removequestinstance();
}

updatescavengerhud() {
  foreach(player in self.playerlist)
  player _id_029458C0B233BE34::uiobjectivesetparameter(self.phaseindex);

  players = _id_029458C0B233BE34::sortvalidplayersinarray(self.playerlist);

  foreach(player in players["valid"]) {
    player _id_029458C0B233BE34::uiobjectiveshow("scavenger");
    _id_029458C0B233BE34::showquestobjicontoplayer(player);
  }

  foreach(player in players["invalid"]) {
    player _id_029458C0B233BE34::uiobjectivehide();
    _id_029458C0B233BE34::hidequestobjiconfromplayer(player);
  }
}

hidescavengerhudfromplayer(player) {
  _id_029458C0B233BE34::hidequestobjiconfromplayer(player);
  player _id_029458C0B233BE34::uiobjectivehide();
}

deletescavengerhud() {
  foreach(player in self.playerlist)
  hidescavengerhudfromplayer(player);

  _id_029458C0B233BE34::deletequestobjicon();
}

sq_ontimerexpired() {}

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
  if(state == "scavenger_closed" && isDefined(instance.entity)) {
    questinstance = instance.entity.questlocale.subscribedinstances[0];

    if(player.team != questinstance.team) {
      player iprintlnbold("Chest Requires a Scavenger Mission");
      return;
    }

    instance setscriptablepartstate("body", "scavenger_opening");
    _id_C0858ACEEA4BB7D9 = getdvarint("dvar_28B9017071772839", 30);
    instance.entity scripts\engine\utility::_id_AD9433AAB9FCDF04(_id_C0858ACEEA4BB7D9, "death_or_disconnect", ::delete);
    questinstance _id_029458C0B233BE34::registercontributingplayers(player);
    _id_C058970A10D37D8B = spawnStruct();
    _id_C058970A10D37D8B.origin = getclosestpointonnavmesh(instance.origin);
    _id_C058970A10D37D8B.angles = instance.angles;
    _id_0F32587863D62696 = getdvarint("dvar_22863E9F09833EA1", 750);
    _id_5135C5D4EFE78004 = getdvarint("dvar_E51B9D94348018DF", 5);
    _id_621A9290C31AFF23 = getdvarint("dvar_E51B9C94348016AC", 5);
    _id_7A9FF609DDE1A3E2 = getdvarint("dvar_E51B9F9434801D45", 5);

    switch (instance.entity.questlocale.phaseindex) {
      case 0:
        _id_029458C0B233BE34::givequestrewardgroup("scavenger_1", player.team, instance.origin, instance.angles, questinstance.rewardscriptable);
        _id_C058970A10D37D8B _id_7F7EE7F5BFA0FA7F(_id_5135C5D4EFE78004);

        if(isDefined(questinstance._id_291CEE6DCDEAA433) && questinstance._id_291CEE6DCDEAA433.size > 0) {
          if(isDefined(questinstance._id_291CEE6DCDEAA433[1]))
            questinstance._id_BA39C0BD611CE3F3 = questinstance._id_291CEE6DCDEAA433[1];
        }

        level notify("quest_send_ai_wave");
        break;
      case 1:
        _id_029458C0B233BE34::givequestrewardgroup("scavenger_2", player.team, instance.origin, instance.angles, questinstance.rewardscriptable);
        _id_C058970A10D37D8B _id_7F7EE7F5BFA0FA7F(_id_621A9290C31AFF23);

        if(isDefined(questinstance._id_291CEE6DCDEAA433) && questinstance._id_291CEE6DCDEAA433.size > 0) {
          if(isDefined(questinstance._id_291CEE6DCDEAA433[2]))
            questinstance._id_BA39C0BD611CE3F3 = questinstance._id_291CEE6DCDEAA433[2];
        }

        break;
      case 2:
        _id_C058970A10D37D8B _id_7F7EE7F5BFA0FA7F(_id_7A9FF609DDE1A3E2);
        _id_029458C0B233BE34::_id_20739E471AE0C29B(instance.team, _id_0F32587863D62696);
        level notify("quest_send_ai_wave");
        break;
      case 3:
        break;
    }

    if(instance.entity.questlocale.phaseindex == 2) {
      questinstance.rewardorigin = instance.origin;
      questinstance.rewardangles = instance.angles;
      _id_029458C0B233BE34::displaysquadmessagetoteam(questinstance.team, player, 8, _id_029458C0B233BE34::getquestindex("scavenger"));
      _id_029458C0B233BE34::_id_0F4FA3A0202D55F8(questinstance);
      questinstance completescavengerquest(instance.entity);
    } else {
      _id_029458C0B233BE34::displaysquadmessagetoteam(questinstance.team, player, 7, _id_029458C0B233BE34::getquestindex("scavenger"));
      _id_354D1457278B342C = lootcachesearchparams(questinstance._id_BA39C0BD611CE3F3.origin, undefined, questinstance._id_BA39C0BD611CE3F3.radius);
      instance.entity.questlocale _id_029458C0B233BE34::movequestlocale("scavenger_locale", _id_354D1457278B342C);
    }

    level notify("lootcache_opened_kill_callout" + instance.origin);
    _id_96674628376EABA6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](player.team, 0);

    foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6)
    _id_F0EA4030349A33D5 notify("calloutmarkerping_warzoneKillQuestIcon");
  }
}

_id_7F7EE7F5BFA0FA7F(amount) {
  _id_7BC24930907ACD4D = ["brloot_armor_plate", "brloot_ammo_762", "brloot_ammo_919", "brloot_ammo_50cal", "brloot_ammo_12g"];
  _id_029458C0B233BE34::_id_DEAE0E47B5BDD68D(amount, _id_7BC24930907ACD4D);
}

sqtablet_init() {
  return 1;
}