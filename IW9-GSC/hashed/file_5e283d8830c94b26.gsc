/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5e283d8830c94b26.gsc
***********************************************/

init() {
  enabled = _id_029458C0B233BE34::registerquestcategory("intel", 1);
  _id_029458C0B233BE34::getquestdata("intel").missionbasetimer = getdvarint("dvar_7328883E8F0CDD91", 300);
  _id_029458C0B233BE34::getquestdata("intel").missionbonustimer = getdvarint("dvar_EC09897DE5581DCB", 60);
  _id_029458C0B233BE34::getquestdata("intel").resettimeronpickup = getdvarint("dvar_33443F180A916464", 1);
  _id_029458C0B233BE34::registertabletinit("intel", ::_id_7BAFA85EFC93610E);
  _id_029458C0B233BE34::registerremovequestinstance("intel", ::_id_4ADD5A34AB36A129);
  _id_029458C0B233BE34::registeronplayerdisconnect("intel", ::_id_03EDF2D72B62E817);
  _id_029458C0B233BE34::registerquestlocale("intel_locale");
  _id_029458C0B233BE34::registercreatequestlocale("intel_locale", ::_id_5929FE520F0B26EC);
  _id_029458C0B233BE34::registermovequestlocale("intel_locale", ::_id_7DAAFC9EE30D93D3);
  _id_029458C0B233BE34::registerremovequestinstance("intel_locale", ::_id_89A23544264220A1);
  _id_029458C0B233BE34::registercheckiflocaleisavailable("intel_locale", ::_id_75D41562678098D8);
  _id_029458C0B233BE34::questtimerinit("intel", 1);
  _id_029458C0B233BE34::registerontimerexpired("intel", ::_id_9CE3019DC74F3813);
  _id_2E06828EC179F5BE = [];
  _id_2E06828EC179F5BE[0] = _id_029458C0B233BE34::filtercondition_isdead;
  _id_029458C0B233BE34::registerplayerfilter("intel", _id_2E06828EC179F5BE);
}

_id_4ADD5A34AB36A129() {
  _id_029458C0B233BE34::releaseteamonquest(self.team);
}

_id_03EDF2D72B62E817(_id_345221032955C106) {
  if(_id_345221032955C106.team == self.team) {
    playerlist = scripts\cp\utility::getplayersinteam(self.team);
    _id_029458C0B233BE34::getquestinstancedata("intel_locale", self.team).playerlist = playerlist;

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

_id_5929FE520F0B26EC(placement) {
  locale = _id_029458C0B233BE34::createlocaleinstance("intel_locale", "intel", self.team);

  if(!isDefined(placement)) {
    locale.curorigin = (0, 0, 0);
    locale.enabled = 0;
    return locale;
  }

  locale _id_029458C0B233BE34::createquestobjicon("ui_mp_br_mapmenu_icon_scavengerhunt_objective", "current");
  locale.playerlist = scripts\cp\utility::getplayersinteam(self.team);
  locale.phaseindex = 0;
  _id_029458C0B233BE34::addquestinstance("intel_locale", locale);
  locale setuplocalelocation(placement);
  return locale;
}

_id_7DAAFC9EE30D93D3(_id_D8E9FE11ED726936) {
  self.phaseindex++;
  result = setuplocalelocation(_id_D8E9FE11ED726936);

  if(result) {
    self.subscribedinstances[0].currlocation = _id_D8E9FE11ED726936.origin;
    _id_029458C0B233BE34::displayteamsplash(self.subscribedinstances[0].team, "cp_intel_quest_relocated");

    if(istrue(_id_029458C0B233BE34::getquestdata("intel").resettimeronpickup))
      self.subscribedinstances[0] _id_029458C0B233BE34::questtimerset(_id_029458C0B233BE34::getquestdata("intel").missionbasetimer, 1);
    else
      self.subscribedinstances[0] _id_029458C0B233BE34::questtimeradd(_id_029458C0B233BE34::getquestdata("intel").missionbonustimer);
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

  self.curorigin = _id_D8E9FE11ED726936.origin + (0, 0, 50);
  _id_029458C0B233BE34::movequestobjicon(self.curorigin);
  updatescavengerhud();
  return 1;
}

_id_89A23544264220A1() {
  deletescavengerhud();
  self.playerlist = undefined;
  self.subscribedinstances = undefined;

  if(isDefined(self.cacheentity)) {
    if(self.cacheentity getscriptablepartstate("body") == "scavenger_closed")
      self.cacheentity delete();
  }
}

sq_circletick(_id_819EDACDACB810E4, _id_E86632D645C137D0) {}

_id_75D41562678098D8() {
  return 0;
}

takequestitem(pickupent) {
  instance = _id_029458C0B233BE34::createquestinstance("intel", self.team, pickupent.index, pickupent);
  instance _id_029458C0B233BE34::registerteamonquest(self.team, self);
  instance _id_029458C0B233BE34::registercontributingplayers(self);
  instance.team = self.team;
  instance.startlocation = self.origin;
  instance.currlocation = self.origin;
  instance.reservedplacement = pickupent.reservedplacement;
  instance.tablet = pickupent;

  if(!isDefined(instance.reservedplacement))
    instance.reservedplacement = [pickupent.origin];

  instance._id_CD211FFD5BCD4C44 = [];
  _id_988C3FD02BCBD450 = scripts\engine\utility::getStructArray("tablet_spawn", "targetname");
  current_struct = scripts\engine\utility::getclosest(pickupent.origin, _id_988C3FD02BCBD450);
  instance._id_A52C81F5E957AA03 = current_struct;

  if(!isDefined(current_struct))
    return 0;

  while(isDefined(current_struct) && isDefined(current_struct.target)) {
    _id_F099E5D6D03AB553 = scripts\engine\utility::getStructArray(current_struct.target, "targetname");
    current_struct = undefined;

    foreach(target in _id_F099E5D6D03AB553) {
      if(isDefined(target.script_noteworthy) && target.script_noteworthy == "intel_group") {
        current_struct = target;
        break;
      }
    }

    if(isDefined(current_struct)) {
      current_struct._id_2BAF32589BB8BB5C = instance._id_CD211FFD5BCD4C44.size;
      instance._id_CD211FFD5BCD4C44[instance._id_CD211FFD5BCD4C44.size] = current_struct;
    }
  }

  foreach(_id_343EDA7720E6E6DF in instance._id_CD211FFD5BCD4C44) {
    _id_FBDF1E4D02565ACE = scripts\engine\utility::getStructArray(_id_343EDA7720E6E6DF.target, "targetname");
    _id_343EDA7720E6E6DF._id_413171B8B9E8BEE0 = [];

    foreach(target in _id_FBDF1E4D02565ACE) {
      if(isDefined(target.script_noteworthy)) {
        switch (target.script_noteworthy) {
          case "usb":
            _id_343EDA7720E6E6DF._id_413171B8B9E8BEE0[_id_343EDA7720E6E6DF._id_413171B8B9E8BEE0.size] = target;
            break;
          case "laptop":
            _id_343EDA7720E6E6DF._id_413171B8B9E8BEE0[_id_343EDA7720E6E6DF._id_413171B8B9E8BEE0.size] = target;
            break;
          case "photo":
            _id_343EDA7720E6E6DF._id_413171B8B9E8BEE0[_id_343EDA7720E6E6DF._id_413171B8B9E8BEE0.size] = target;
            break;
        }
      }

      target.instance = instance;
      target._id_343EDA7720E6E6DF = _id_343EDA7720E6E6DF;
    }
  }

  _id_029458C0B233BE34::_id_2DAB18ED103A9C6A(instance._id_CD211FFD5BCD4C44.size);
  _id_029458C0B233BE34::_id_AFB3C7102E36A404(instance);
  _id_029458C0B233BE34::_id_5B04CC6859711D68(instance);
  _id_029458C0B233BE34::_id_2247D0E9C5C2A383(instance);
  level thread _id_E0AA25365EB31157(instance);
  _id_029458C0B233BE34::uiobjectiveshowtoteam("intel", self.team);
  _id_029458C0B233BE34::addquestinstance("intel", instance);
  _id_029458C0B233BE34::startteamcontractchallenge("intel", self, self.team);
  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self;
  params.plundervar = _id_029458C0B233BE34::getquestplunderreward("intel", _id_029458C0B233BE34::getquestrewardtier(self.team));
  _id_029458C0B233BE34::displayteamsplash(self.team, "cp_intel_quest_start_team", params);
  _id_029458C0B233BE34::displayplayersplash(self, "cp_intel_quest_start_tablet_finder", params);
  _id_029458C0B233BE34::displaysquadmessagetoteam(instance.team, self, 6, _id_029458C0B233BE34::getquestindex("intel"));
}

_id_E0AA25365EB31157(instance) {
  num = 0;
  _id_295F13E8BBE53101 = undefined;
  locale = undefined;

  foreach(_id_343EDA7720E6E6DF in instance._id_CD211FFD5BCD4C44) {
    _id_295F13E8BBE53101 = scripts\engine\utility::random(_id_343EDA7720E6E6DF._id_413171B8B9E8BEE0);
    _id_295F13E8BBE53101 thread _id_C24E4CA5D49D119D(instance);
    _id_295F13E8BBE53101 thread _id_E434EA40C9FC14FD(instance, _id_295F13E8BBE53101.origin);
    _id_295F13E8BBE53101 thread _id_F7648189DBBFF9D8(instance);
    _id_343EDA7720E6E6DF._id_295F13E8BBE53101 = _id_295F13E8BBE53101;

    if(num == 0) {
      locale = instance _id_5929FE520F0B26EC(_id_343EDA7720E6E6DF);
      instance _id_029458C0B233BE34::subscribetoquestlocale(locale);
      instance.origin = _id_295F13E8BBE53101.origin;
      instance.angles = _id_295F13E8BBE53101.angles;
    } else {
      locale _id_7DAAFC9EE30D93D3(_id_343EDA7720E6E6DF);
      instance.origin = _id_295F13E8BBE53101.origin;
      instance.angles = _id_295F13E8BBE53101.angles;
    }

    instance waittill("intel_collected");
    num++;
  }

  _id_029458C0B233BE34::_id_0F4FA3A0202D55F8(instance);
  _id_C058970A10D37D8B = spawnStruct();
  _id_C058970A10D37D8B.origin = getclosestpointonnavmesh(instance.origin);
  _id_C058970A10D37D8B.angles = instance.angles;
  _id_029458C0B233BE34::_id_20739E471AE0C29B(instance.team, 1000);
  instance _id_E9F843322CFA7650(_id_295F13E8BBE53101);
}

_id_E434EA40C9FC14FD(instance, origin) {
  if(!isDefined(instance._id_22C6386E9B094F2D))
    instance._id_22C6386E9B094F2D = [];

  interact = spawn("script_model", origin);
  interact.angles = (0, 0, 0);
  interact setModel("tag_origin");
  interact.targetname = "tablet_intel_interaction";
  interact.type = self.script_noteworthy;
  interact.instance = instance;
  interact makeusable();
  hintstring = &"CP_INCURSION/INTEL_COLLECT";
  interact setHintString(hintstring);
  interact setCursorHint("HINT_BUTTON");
  interact sethintdisplayrange(190);
  interact sethintdisplayfov(140);
  interact setuserange(105);
  interact setusefov(65);
  interact sethintonobstruction("show");
  interact setuseholdduration("duration_short");
  interact thread _id_BF63624FD4AC6C87();
  instance._id_22C6386E9B094F2D[instance._id_22C6386E9B094F2D.size] = interact;
}

_id_BF63624FD4AC6C87() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player())
        continue;
    }
  }
}

_id_C84513A9419F454C(player) {
  switch (self.type) {
    case "usb":
      break;
    case "laptop":
      player thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");

      if(isDefined(self.instance._id_5A818B70A2F6955E)) {
        foreach(_id_B940651E35F1E359 in self.instance._id_5A818B70A2F6955E) {
          if(_id_B940651E35F1E359.model == "device_laptop_01_open")
            _id_B940651E35F1E359 scripts\cp\utility::delayentdelete(0.5);
        }
      }

      break;
    case "photo":
      player scripts\cp\utility::playerplaytakephotoanim();
      break;
  }

  self.instance notify("intel_collected");
  _id_927C100116C67FAE();
}

_id_927C100116C67FAE() {
  if(isDefined(self) && isent(self))
    self delete();
}

_id_C24E4CA5D49D119D(instance) {
  if(!isDefined(self.target)) {
    return;
  }
  if(!isDefined(instance._id_5A818B70A2F6955E))
    instance._id_5A818B70A2F6955E = [];

  targets = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(target in targets) {
    if(isDefined(target.script_noteworthy) && target.script_noteworthy == "intel_model") {
      model = spawn("script_model", target.origin);
      model.angles = target.angles;
      model setModel(target.script_parameters);
      _id_4F9A7D3A4C53171F = 0;

      switch (target.script_parameters) {
        case "military_radio_crate_01":
          _id_4F9A7D3A4C53171F = 1;
          break;
      }

      if(_id_4F9A7D3A4C53171F)
        model._id_DBE4316E115900D3 = createnavobstaclebyent(model);

      instance._id_5A818B70A2F6955E[instance._id_5A818B70A2F6955E.size] = model;
    }
  }
}

_id_F7648189DBBFF9D8(instance) {
  level endon("game_ended");
  instance endon("intel_collected");

  if(!isDefined(self) || !isDefined(self._id_343EDA7720E6E6DF.radius)) {
    return;
  }
  while(!isDefined(instance.subscribedlocale))
    wait 0.25;

  radius = self._id_343EDA7720E6E6DF.radius * self._id_343EDA7720E6E6DF.radius;
  objindex = instance.subscribedlocale.objectiveiconid;

  if(!isDefined(objindex)) {
    return;
  }
  objective_hidefromplayersinmask(objindex);
  objective_addalltomask(objindex);
  waitframe();

  foreach(player in level.players) {
    player._id_6F668D2179EB8EAF = undefined;
    objective_removeclientfrommask(objindex, player);
  }

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(!level.players[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(distance2dsquared(level.players[_id_AC0E594AC96AA3A8].origin, self._id_343EDA7720E6E6DF.origin) < radius) {
        level.players[_id_AC0E594AC96AA3A8] _id_3AAB334BEE0D924C(objindex);
        continue;
      }

      level.players[_id_AC0E594AC96AA3A8] _id_5AC3FD6BBC018E52(objindex);
    }

    wait 0.1;
  }
}

_id_3AAB334BEE0D924C(objindex) {
  if(istrue(self._id_6F668D2179EB8EAF)) {
    return;
  }
  self._id_6F668D2179EB8EAF = 1;
  thread scripts\cp\cp_hud_message::tutorialprint(&"CP_STRIKE/SEARCH_AREA_ENTER", 3);
  objective_addclienttomask(objindex, self);
}

_id_5AC3FD6BBC018E52(objindex) {
  if(!istrue(self._id_6F668D2179EB8EAF)) {
    return;
  }
  self._id_6F668D2179EB8EAF = undefined;
  thread scripts\cp\cp_hud_message::tutorialprint(&"CP_STRIKE/SEARCH_AREA_EXIT", 3);
  objective_removeclientfrommask(objindex, self);
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
  return _id_354D1457278B342C;
}

_id_E9F843322CFA7650(chest) {
  params = spawnStruct();
  rewardtier = _id_029458C0B233BE34::getquestrewardtier(self.team);
  missionid = _id_029458C0B233BE34::getquestindex("intel");
  _id_11D65784F0B6AFA2 = _id_029458C0B233BE34::getquestrewardgroupindex(_id_029458C0B233BE34::getquestrewardbuildgroupref("intel"));
  params.packedbits = _id_029458C0B233BE34::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);
  _id_029458C0B233BE34::displayteamsplash("allies", "cp_intel_quest_complete", params);
  self.rewardorigin = chest.origin;
  self.rewardangles = chest.angles;
  self.result = "success";
  _id_029458C0B233BE34::_id_91BEF971C660791F();
  _id_029458C0B233BE34::removequestinstance();
}

failscavengerquest() {
  _id_029458C0B233BE34::displayteamsplash(self.team, "cp_intel_quest_circle_failure");
  self.result = "fail";
  _id_029458C0B233BE34::removequestinstance();
}

updatescavengerhud() {
  foreach(player in self.playerlist)
  player _id_029458C0B233BE34::uiobjectivesetparameter(self.phaseindex);

  players = _id_029458C0B233BE34::sortvalidplayersinarray(self.playerlist);

  foreach(player in players["valid"]) {
    player _id_029458C0B233BE34::uiobjectiveshow("intel");
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

_id_9CE3019DC74F3813() {}

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

_id_7BAFA85EFC93610E() {
  return 1;
}