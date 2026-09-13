/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_extract_quest.gsc
*****************************************************/

init() {
  enabled = _id_3ACF1C0EBAF602F2::registerquestcategory("blueprintextract", 1);

  if(!enabled) {
    return;
  }
  _id_3ACF1C0EBAF602F2::registertabletinit("blueprintextract", ::extracttablet_init);
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("blueprintextract", ::extractquest_removequestinstance);
  _id_3ACF1C0EBAF602F2::registerquestlocale("blueprintextract_locale");
  _id_3ACF1C0EBAF602F2::registercreatequestlocale("blueprintextract_locale", ::extractlocale_createquestlocale);
  _id_3ACF1C0EBAF602F2::registercheckiflocaleisavailable("blueprintextract_locale", ::extractlocale_checkiflocaleisavailable);
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("blueprintextract_locale", ::extractlocale_removelocaleinstance);
  _id_3ACF1C0EBAF602F2::registerquestcircletick("blueprintextract_locale", ::extractlocale_circletick);
  _id_3ACF1C0EBAF602F2::registeronentergulag("blueprintextract_locale", ::extractlocale_onentergulag);
  _id_3ACF1C0EBAF602F2::registeronrespawn("blueprintextract_locale", ::extractlocale_onrespawn);
  _id_3ACF1C0EBAF602F2::getquestdata("blueprintextract_locale").nextid = 0;
  _id_3ACF1C0EBAF602F2::questtimerinit("blueprintextract", 1);
  _id_3ACF1C0EBAF602F2::registerontimerexpired("blueprintextract", ::extract_ontimerexpired);

  if(!istrue(level.br_plunder_enabled)) {
    _id_6AFF3948CF4CCA03::initheliextractanims();
    _id_6AFF3948CF4CCA03::inithelipropanims();
    level._effect["vfx_extract_smoke"] = loadfx("vfx/iw8_br/gameplay/vfx_br_adv_supply_drop_marker");
    _id_6AFF3948CF4CCA03::plunder_initrepositories();
    _id_6AFF3948CF4CCA03::inithelirepository();
  }

  if(!_id_6AFF3948CF4CCA03::isplunderextractionenabled())
    scripts\engine\scriptable::scriptable_addusedcallback(_id_6AFF3948CF4CCA03::plundersiteused);

  _id_EC80AF5C96553608 = getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk";
  level.extractmissionhelipadscriptable = scripts\engine\utility::ter_op(_id_EC80AF5C96553608, "brloot_quest_extract_site_plunder", "brloot_quest_extract_site_br");
  level.extractmissionhelipadmodel = scripts\engine\utility::ter_op(_id_EC80AF5C96553608, "brloot_quest_extract_site_model_plunder", "brloot_quest_extract_site_model_br");
  level.plunderrepositories.data["extractHelipadPlunder"].prevcallback = level.plunderrepositories.data["extractHelipadPlunder"].usecallback;
  level.plunderrepositories.data["extractHelipadPlunder"].usecallback = ::extracthelipadusecallback;
  level.plunderrepositories.data["extractHelipadBR"].prevcallback = level.plunderrepositories.data["extractHelipadBR"].usecallback;
  level.plunderrepositories.data["extractHelipadBR"].usecallback = ::extracthelipadusecallback;
  game["dialog"]["mission_extract_accept"] = "bm_exfil_arrived";
  game["dialog"]["mission_extract_success"] = "contract_misc_success";
}

extracthelipadusecallback(entity, player, amount) {
  player.lastplunderbankindex = entity.index;
  player notify("heliDeposit");

  if(amount > 0 && istrue(level.br_plunder_enabled) && (getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk"))
    [[level.plunderrepositories.data["extractHelipadPlunder"].prevcallback]](entity, player, amount);
}

extractquest_removequestinstance() {
  _id_3ACF1C0EBAF602F2::releaseteamonquest(self.team);
  _id_3ACF1C0EBAF602F2::uiobjectivehidefromteam(self.team);
  extractupdatehud(0, undefined);

  if(isDefined(self.carryingplayer))
    self.carryingplayer unsetweaponcarry();

  self.subscribedlocale thread extractupdateiconsframeend();
}

extractlocale_removelocaleinstance() {
  foreach(instance in self.subscribedinstances)
  instance thread _id_3ACF1C0EBAF602F2::removequestinstance();

  _id_3ACF1C0EBAF602F2::deletequestobjicon();
  self.helipadscriptable thread removeextracthelipad();
}

extracttablet_init() {
  _id_354D1457278B342C = getsearchparams(self);
  placement = _id_3ACF1C0EBAF602F2::findquestplacement("blueprintextract", _id_354D1457278B342C);

  if(!isDefined(placement))
    return 0;

  self.reservedplacement = placement;
  return 1;
}

extractlocale_createquestlocale(placement) {
  _id_3ACF1C0EBAF602F2::getquestdata("blueprintextract_locale").nextid++;
  locale = _id_3ACF1C0EBAF602F2::createlocaleinstance("blueprintextract_locale", "blueprintextract", "ExtractPoint:" + _id_3ACF1C0EBAF602F2::getquestdata("blueprintextract_locale").nextid);

  if(!isDefined(placement)) {
    locale.curorigin = (0, 0, 0);
    locale.enabled = 0;
    return locale;
  }

  locale.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  locale.helipad = spawn("script_model", placement.origin);
  locale.helipad setModel(level.extractmissionhelipadmodel);
  _id_7F599ACCB72658D1 = locale.playerlist[0];
  locale.helipad setotherent(_id_7F599ACCB72658D1);
  locale.helipad setscriptablepartstate(level.extractmissionhelipadscriptable, "activeCurrent");
  locale.helipad.forceextractscriptable = 1;
  locale.helipadscriptable = locale.helipad getlinkedscriptableinstance();
  locale.helipadscriptable.activestate = "active";
  locale.helipadscriptable.activecurrstate = "activeCurrent";
  locale.helipadscriptable.disabledstate = "hidden";
  locale.helipadscriptable.disabledcurrstate = "hidden";
  locale.helipadscriptable.questcomplete = 0;
  locale.locationpad = placement;
  locale _id_3ACF1C0EBAF602F2::createquestobjicon("ui_mp_br_mapmenu_icon_extraction_objective", "current", placement.origin);
  locale.lastcircletick = -1;
  locale.curorigin = placement.origin;
  _id_3ACF1C0EBAF602F2::addquestinstance("blueprintextract_locale", locale);
  return locale;
}

extractlocale_islocaleavailable(position) {
  _id_FA87325ECB907960 = spawnStruct();
  _id_FA87325ECB907960.origin = position;
  _id_354D1457278B342C = getsearchparams(_id_FA87325ECB907960);
  placement = _id_3ACF1C0EBAF602F2::findquestplacement("blueprintextract", _id_354D1457278B342C);
  return isDefined(placement);
}

removeextracthelipad() {
  if(getDvar("dvar_7611A2790A0BF7FE", "") != "plunder" && getDvar("dvar_7611A2790A0BF7FE", "") != "risk")
    self setscriptablepartstate(level.extractmissionhelipadscriptable, "hidden");

  if(isDefined(self.heli))
    self waittill("heli_left");

  self.entity delete();
}

extractlocale_checkiflocaleisavailable(_id_354D1457278B342C) {}

extractlocale_circletick(_id_819EDACDACB810E4, _id_E86632D645C137D0) {
  if(!isDefined(self.helipad)) {
    return;
  }
  currenttime = gettime();

  if(self.lastcircletick == currenttime) {
    return;
  }
  self.lastcircletick = currenttime;
  dist = distance2d(self.curorigin, _id_819EDACDACB810E4);

  if(dist > _id_E86632D645C137D0) {
    foreach(instance in self.subscribedinstances) {
      _id_3ACF1C0EBAF602F2::displayteamsplash(instance.team, "br_blueprint_extract_quest_circle_failure");
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_obj_circle_fail", instance.team, 1);
      instance.result = "circle";
    }

    _id_3ACF1C0EBAF602F2::removequestinstance();
  }
}

extractlocale_onentergulag(player) {
  extracthideiconfromplayer(player);
}

extractlocale_onrespawn(player) {
  if(player.team == self.subscribedinstances[0].team)
    extractshowicontoplayer(player);
}

extractupdateicons() {
  objective_showtoplayersinmask(self.objectiveiconid);
  objective_removeallfrommask(self.objectiveiconid);

  foreach(instance in self.subscribedinstances) {
    foreach(player in scripts\mp\utility\teams::getteamdata(instance.team, "players")) {
      if(!player _id_2CEDCC356F1B9FC8::isplayeringulag())
        objective_addclienttomask(self.objectiveiconid, player);
    }
  }
}

extracthideiconfromplayer(player) {
  objective_removeclientfrommask(self.objectiveiconid, player);
}

extractshowicontoplayer(player) {
  objective_addclienttomask(self.objectiveiconid, player);
}

extractupdateiconsframeend() {
  self endon("removed");
  waittillframeend;
  extractupdateicons();
}

extractupdatehud(_id_C8029619477A0D4B, carryingplayer) {
  _id_5A9EE04D167FCC27 = 0;
  lootid = -1;

  if(_id_C8029619477A0D4B) {
    _id_5A9EE04D167FCC27 = carryingplayer getentitynumber();
    lootid = self.extractunlockablelootid;
  }

  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    player _id_3ACF1C0EBAF602F2::uiobjectivesetparameter(_id_5A9EE04D167FCC27);
    player _id_3ACF1C0EBAF602F2::uiobjectivesetlootid(lootid);
    _id_7E57BAEA00CBE019 = isDefined(carryingplayer) && player == carryingplayer;
    _id_58BB02942155F96C = _id_C8029619477A0D4B && _id_7E57BAEA00CBE019;
    player setclientomnvar("ui_br_has_extract_bag", _id_58BB02942155F96C);
  }
}

takequestitem(pickupent) {
  quests = _id_3ACF1C0EBAF602F2::getallactivequestsforteam(self.team);

  if(isDefined(quests) && quests.size > 0) {
    foreach(_id_12461E617D024EF9 in quests)
    _id_12461E617D024EF9.instance _id_3ACF1C0EBAF602F2::removequestinstance();
  }

  instance = _id_3ACF1C0EBAF602F2::createquestinstance("blueprintextract", self.team, pickupent.index, pickupent);
  instance _id_3ACF1C0EBAF602F2::registerteamonquest(self.team, self);
  instance.team = self.team;
  instance.tablet = pickupent;
  instance.extractunlockablelootid = pickupent.extractunlockablelootid;
  _id_89CAD6E3DA206570 = getdvarint("dvar_244206CE2E68A9D8", 240);
  instance _id_3ACF1C0EBAF602F2::questtimerset(_id_89CAD6E3DA206570, 4);
  _id_354D1457278B342C = getsearchparams(pickupent);
  locale = instance _id_3ACF1C0EBAF602F2::requestquestlocale("blueprintextract_locale", _id_354D1457278B342C, 1);

  if(!locale.enabled) {
    instance.result = "no_locale";
    instance _id_3ACF1C0EBAF602F2::releaseteamonquest(self.team);
    return;
  }

  locale extractupdateicons();
  _id_3ACF1C0EBAF602F2::uiobjectiveshowtoteam("blueprintextract", self.team);
  _id_3ACF1C0EBAF602F2::addquestinstance("blueprintextract", instance);
  _id_3ACF1C0EBAF602F2::startteamcontractchallenge("blueprintextract", self, self.team);

  if(!level.br_plunder_enabled) {
    foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players"))
    player.plundercount = 0;
  }

  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self;
  params.plundervar = _id_3ACF1C0EBAF602F2::getquestplunderreward("blueprintextract", _id_3ACF1C0EBAF602F2::getquestrewardtier(self.team));
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_blueprint_extract_quest_start_team", params);
  _id_3ACF1C0EBAF602F2::displayplayersplash(self, "br_blueprint_extract_quest_start_tablet_finder", params);
  _id_3ACF1C0EBAF602F2::displaysquadmessagetoteam(instance.team, self, 6, _id_3ACF1C0EBAF602F2::getquestindex("blueprintextract"));
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_extract_accept", instance.team, 1);
  setweaponcarry(locale, pickupent.extractunlockablelootid);
  instance.carryingplayer = self;

  foreach(player in level.players) {
    if(player != self)
      locale.helipadscriptable disablescriptablepartplayeruse(level.extractmissionhelipadscriptable, player);
  }

  instance extractupdatehud(1, self);
  instance thread watchweapondeathordisconnect(self);
  instance thread watchfordeposit(self);
}

setweaponcarry(locale, _id_26F195548422121E) {
  self.extractquest_alwaysallowdeposit = 1;
  self.extractquest_helipadid = locale.helipadscriptable.index;
  self.extractquest_missionitem = "brloot_blueprintextract_tablet";
  self.extractquest_unlockablelootid = _id_26F195548422121E;
}

unsetweaponcarry() {
  self.extractquest_alwaysallowdeposit = undefined;
  self.extractquest_helipadid = undefined;
  self.extractquest_missionitem = undefined;
  self.extractquest_unlockablelootid = undefined;
}

extract_removemissionweapon(_id_12461E617D024EF9) {
  if(self hasweapon(_id_12461E617D024EF9.weapon)) {
    _id_2B1D0E57C66A43D0 = makeweapon("iw9_me_fists_mp");
    _id_F98CB4EB8D8C216C = scripts\cp_mp\utility\inventory_utility::iscurrentweapon(_id_12461E617D024EF9.weapon);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_12461E617D024EF9.weapon);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_2B1D0E57C66A43D0, undefined, undefined, 1);

    if(_id_F98CB4EB8D8C216C)
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(_id_2B1D0E57C66A43D0);
  }
}

extract_ismissionweapon(weapon) {
  if(!isDefined(self.extractquest_missionweapon))
    return 0;

  return self.extractquest_missionweapon == weapon;
}

watchweapondrop(player) {
  self endon("removed");

  for(;;) {
    player waittill("weapon_change");

    if(isDefined(player) && !player hasweapon(self.weapon)) {
      dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
      tablet = _id_7E52B56769FA7774::spawnpickup("brloot_blueprintextract_tablet", _id_CB4FAD49263E20C4);
      tablet.reservedplacement = self.subscribedlocale.locationpad;
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("br_blueprint_extract_quest_failure", player.team, 1, 1);
      _id_3ACF1C0EBAF602F2::displayteamsplash(player.team, "br_blueprint_extract_quest_failure");
      player unsetweaponcarry();
      self.result = "fail";
      thread _id_3ACF1C0EBAF602F2::removequestinstance();
      return;
    }
  }
}

watchweapondeathordisconnect(player) {
  self endon("removed");
  team = player.team;

  for(;;) {
    player waittill("death_or_disconnect");
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("br_blueprint_extract_quest_failure", team, 1, 1);
    _id_3ACF1C0EBAF602F2::displayteamsplash(team, "br_blueprint_extract_quest_failure");

    if(isDefined(player))
      player unsetweaponcarry();

    self.result = "fail";
    thread _id_3ACF1C0EBAF602F2::removequestinstance();
    return;
  }
}

watchfordeposit(player) {
  self endon("removed");

  for(;;) {
    player waittill("heliDeposit");

    if(player.lastplunderbankindex == self.subscribedlocale.helipadscriptable.index) {
      _id_945DE91375D26C76 = "blueprint_unlock_" + self.extractunlockablelootid;
      optionalnumber = _id_3ACF1C0EBAF602F2::getquestunlockableindexfromlootid(self.extractunlockablelootid);

      foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
        _id_F0EA4030349A33D5 scripts\cp_mp\challenges::onunlockitem(_id_945DE91375D26C76);

        if(optionalnumber > 0)
          _id_F0EA4030349A33D5 thread scripts\mp\hud_message::showsplash("br_unlockable_weapon_splash", optionalnumber);
      }

      self.subscribedlocale.helipadscriptable.questcomplete = 1;
      _id_3ACF1C0EBAF602F2::displaysquadmessagetoteam(self.team, player, 8, _id_3ACF1C0EBAF602F2::getquestindex("blueprintextract"));
      displaydelayedmissioncompletesplash(player);
      missionid = _id_3ACF1C0EBAF602F2::getquestindex("blueprintextract");
      _id_3ACF1C0EBAF602F2::displaysquadmessagetoteam(self.team, player, 8, missionid);
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_extract_success", self.team, 1, 1);
      self.rewardorigin = self.subscribedlocale.helipad.origin;
      self.rewardangles = self.subscribedlocale.helipad.angles;
      self.result = "success";
      thread _id_3ACF1C0EBAF602F2::removequestinstance();
      return;
    }
  }
}

displaydelayedmissioncompletesplash(player) {
  level endon("game_ended");
  team = self.team;
  params = spawnStruct();
  rewardtier = _id_3ACF1C0EBAF602F2::getquestrewardtier(player.team);
  missionid = _id_3ACF1C0EBAF602F2::getquestindex("blueprintextract");
  _id_11D65784F0B6AFA2 = _id_3ACF1C0EBAF602F2::getquestrewardgroupindex(_id_3ACF1C0EBAF602F2::getquestrewardbuildgroupref("blueprintextract"));
  unlockableindex = _id_3ACF1C0EBAF602F2::getquestunlockableindexfromlootid(self.extractunlockablelootid);
  params.packedbits = _id_3ACF1C0EBAF602F2::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2, unlockableindex);
  waitframe();
  _id_3ACF1C0EBAF602F2::displayteamsplash(team, "br_blueprint_extract_quest_complete", params);
}

getsearchparams(tablet) {
  _id_354D1457278B342C = spawnStruct();
  _id_354D1457278B342C.searchfunc = "getInactiveHelipads";
  _id_354D1457278B342C.searchcircleorigin = (tablet.origin[0], tablet.origin[1], 0);
  _id_354D1457278B342C.searchradiusmax = 30000;
  _id_354D1457278B342C.searchradiusmin = 0;
  _id_354D1457278B342C.searchradiusidealmax = getdvarint("dvar_3F4A769B64C24A7D", 20000);
  _id_354D1457278B342C.searchradiusidealmin = getdvarint("dvar_51284059DE901D6F", 15000);
  _id_354D1457278B342C.searchforcecirclecenter = 1;
  _id_354D1457278B342C.reservedplacement = tablet.reservedplacement;
  return _id_354D1457278B342C;
}

extract_ontimerexpired() {
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_blueprint_extract_quest_timer_expired");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", self.team, 1);
}