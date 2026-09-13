/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6d7a5191b485700d.gsc
***********************************************/

init() {
  enabled = _id_029458C0B233BE34::registerquestcategory("vip", 1);
  _id_029458C0B233BE34::getquestdata("vip").missionbasetimer = getdvarint("dvar_27FA2B7A6B886242", 180);
  _id_029458C0B233BE34::registertabletinit("vip", ::_id_F172FE1E275011B7);
  _id_029458C0B233BE34::registerremovequestinstance("vip", ::vip_removequestinstance);
  _id_029458C0B233BE34::registeronplayerdisconnect("vip", ::vip_playerdisconnect);
  _id_029458C0B233BE34::registerquestlocale("vip_locale");
  _id_029458C0B233BE34::registercreatequestlocale("vip_locale", ::_id_897693B0FA673903);
  _id_029458C0B233BE34::registermovequestlocale("vip_locale", ::_id_FC1D3FC9C942B74C);
  _id_029458C0B233BE34::registerremovequestinstance("vip_locale", ::_id_0ADB88145D57C768);
  _id_029458C0B233BE34::registercheckiflocaleisavailable("vip_locale", ::_id_D1C5AF1EFD532365);
  _id_029458C0B233BE34::registeronentergulag("vip_locale", ::_id_3317A5C2ABE47A53);
  _id_029458C0B233BE34::registeronrespawn("vip_locale", ::_id_02E60F92D0310D73);
  _id_029458C0B233BE34::questtimerinit("vip", 1);
  _id_029458C0B233BE34::registerontimerexpired("vip", ::vip_ontimerexpired);
  _id_2E06828EC179F5BE = [];
  _id_2E06828EC179F5BE[0] = _id_029458C0B233BE34::filtercondition_isdead;
  _id_029458C0B233BE34::registerplayerfilter("vip", _id_2E06828EC179F5BE);
  _id_DDBE560ED182FE89();
}

vip_removequestinstance() {
  _id_029458C0B233BE34::uiobjectivehidefromteam(self.team);
  _id_029458C0B233BE34::releaseteamonquest(self.team);
}

vip_playerdisconnect(_id_345221032955C106) {
  if(_id_345221032955C106.team == self.team) {
    playerlist = scripts\cp\utility::getplayersinteam(self.team);
    _id_029458C0B233BE34::getquestinstancedata("vip_locale", self.team).playerlist = playerlist;

    if(isDefined(self.subscribedlocale) && isDefined(self.subscribedlocale.cacheentity) && playerlist.size)
      self.subscribedlocale.cacheentity setotherent(playerlist[0]);

    if(!_id_029458C0B233BE34::isteamvalid(_id_345221032955C106.team)) {
      self.result = "fail";
      _id_029458C0B233BE34::removequestinstance();
    }
  }
}

_id_3317A5C2ABE47A53(player) {}

_id_02E60F92D0310D73(player) {}

_id_897693B0FA673903(placement) {
  locale = _id_029458C0B233BE34::createlocaleinstance("vip_locale", "vip", self.team);

  if(!isDefined(placement)) {
    locale.curorigin = (0, 0, 0);
    locale.enabled = 0;
    return locale;
  }

  locale _id_029458C0B233BE34::createquestobjicon("ui_mp_br_mapmenu_icon_assassin_objective_enemy", "current");
  locale.playerlist = scripts\cp\utility::getplayersinteam(self.team);
  locale.phaseindex = 0;
  _id_029458C0B233BE34::addquestinstance("vip_locale", locale);
  locale setuplocalelocation(placement);
  return locale;
}

_id_FC1D3FC9C942B74C(_id_D8E9FE11ED726936) {
  self.phaseindex++;
  result = setuplocalelocation(_id_D8E9FE11ED726936);

  if(result) {
    self.subscribedinstances[0].currlocation = _id_D8E9FE11ED726936.origin;
    _id_029458C0B233BE34::displayteamsplash(self.subscribedinstances[0].team, "br_scavenger_quest_next_location");

    if(istrue(_id_029458C0B233BE34::getquestdata("vip").resettimeronpickup))
      self.subscribedinstances[0] _id_029458C0B233BE34::questtimerset(_id_029458C0B233BE34::getquestdata("vip").missionbasetimer, 1);
    else
      self.subscribedinstances[0] _id_029458C0B233BE34::questtimeradd(_id_029458C0B233BE34::getquestdata("vip").missionbonustimer);
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
  updatescavengerhud();
  return 1;
}

_id_0ADB88145D57C768() {
  deletescavengerhud();
  self.playerlist = undefined;
  self.subscribedinstances = undefined;

  if(isDefined(self.cacheentity)) {
    if(self.cacheentity getscriptablepartstate("body") == "scavenger_closed")
      self.cacheentity delete();
  }
}

_id_A046424449F502BC(_id_819EDACDACB810E4, _id_E86632D645C137D0) {}

_id_D1C5AF1EFD532365() {
  return 0;
}

takequestitem(pickupent) {
  instance = _id_029458C0B233BE34::createquestinstance("vip", self.team, pickupent.index, pickupent);
  instance _id_029458C0B233BE34::registerteamonquest(self.team, self);
  instance _id_029458C0B233BE34::registercontributingplayers(self);
  instance.team = self.team;
  instance.startlocation = self.origin;
  instance.currlocation = self.origin;
  instance.reservedplacement = pickupent.reservedplacement;
  instance.tablet = pickupent;
  instance.tablet.keepinmap = 1;
  instance.vip = self;

  if(!isDefined(instance.reservedplacement))
    instance.reservedplacement = [pickupent.origin];

  level thread _id_029458C0B233BE34::_id_7BCB36BCE60B1F7A(instance);
  _id_029458C0B233BE34::uiobjectiveshowtoteam("vip", self.team);
  instance.totalscavengeditems = 0;
  instance _id_029458C0B233BE34::questtimerset(_id_029458C0B233BE34::getquestdata("vip").missionbasetimer, 4);
  _id_029458C0B233BE34::addquestinstance("vip", instance);
  _id_029458C0B233BE34::startteamcontractchallenge("vip", self, self.team);
  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self;
  params.plundervar = _id_029458C0B233BE34::getquestplunderreward("vip", _id_029458C0B233BE34::getquestrewardtier(self.team));
  _id_029458C0B233BE34::displayteamsplash(instance.team, "br_vip_quest_start_vip_team", params);
  _id_029458C0B233BE34::displayplayersplash(instance.vip, "br_vip_quest_start_tablet_finder", params);
  instance thread _id_666CE4B3D0B55066(self);
}

_id_666CE4B3D0B55066(player) {
  level endon("stop_vip_squad_spawning");
  thread _id_ADF642D588D55D0F(player);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
    level.players[_id_AC0E594AC96AA3A8] setplayermusicstate("cp_juggernaut_intro");

  level._id_57BF2E93ADDF2744 = [];
  level._id_A9DF3AC87BA5CAFB = 0;
  _id_493893E55A72D472 = ["smg", "shotgun", "sniper"];
  _id_F9FA10E07F13F5FD = scripts\engine\utility::random(_id_493893E55A72D472);
  _id_00378D6643D1B02A = getdvarint("dvar_7E8E0E297E75DD4F", 0);

  if(_id_00378D6643D1B02A)
    _id_F9FA10E07F13F5FD = _id_493893E55A72D472[_id_00378D6643D1B02A - 1];

  _id_EFCA84967AF5BBAC = scripts\engine\utility::getStructArray("blima_vip_squad", "targetname");

  foreach(_id_EA5A0CA0515A7B2A in _id_EFCA84967AF5BBAC)
  _id_EA5A0CA0515A7B2A.script_noteworthy = _id_F9FA10E07F13F5FD;

  _id_18A73A64992DD07D::run_spawn_module("blima_vip_squad");
  _id_EFCA84967AF5BBAC = scripts\engine\utility::getStructArray("blima_vip_squad_2", "targetname");

  foreach(_id_EA5A0CA0515A7B2A in _id_EFCA84967AF5BBAC)
  _id_EA5A0CA0515A7B2A.script_noteworthy = _id_F9FA10E07F13F5FD;

  _id_18A73A64992DD07D::run_spawn_module("blima_vip_squad_2");
  wait 1;
  _id_537A712B2BE3193C::_id_E4F3059610095250(undefined, 0, "vip_contract_spawn");
  thread _id_5085F1C520DF2871();
  level notify("stop_vip_squad_spawning");
}

_id_5085F1C520DF2871() {
  wait 1;
  vip_completequest();
}

_id_DDBE560ED182FE89() {
  _id_18A73A64992DD07D::registerambientgroup("blima_vip_squad", 0, 6, 6, 0.1, 0, "blima_vip_squad", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("blima_vip_squad", ::_id_9F4D554E3AE3D383);
  _id_18A73A64992DD07D::registerambientgroup("blima_vip_squad_2", 0, 6, 6, 0.1, 0, "blima_vip_squad_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("blima_vip_squad_2", ::_id_9F4D554E3AE3D383);
  _id_18A73A64992DD07D::registerambientgroup("mindia8_vip_squad", 0, 12, undefined, 0.1, 0, "mindia8_vip_squad", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("mindia8_vip_jugg", 0, 2, undefined, 0.1, 0, "mindia8_vip_jugg", undefined, undefined, undefined);
}

_id_9F4D554E3AE3D383(group) {
  body = "body_mp_milsim_balkan_sf_1_1";
  head = "head_mp_milsim_balkan_sf_1_1";
  weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_sm_uzulu_mp", ["thermal", "none", "none", "none", "silencer", "laserrange_smg"], "none", "none");
  _id_A664AAD02EE98BD2 = "frag_grenade_mp";
  _id_F9FA10E07F13F5FD = self.spawner.script_noteworthy;

  switch (_id_F9FA10E07F13F5FD) {
    case "shotgun":
      body = "body_mp_eastern_nikto_2_1";
      head = "head_mp_eastern_nikto_3_1";
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_sh_dpapa12_mp", ["none", "none", "none", "muzzlemelee_dpapa12", "caldb_dpapa12", "none"], "none", "none");
      _id_A664AAD02EE98BD2 = "molotov_mp";
      break;
    case "sniper":
      body = "body_mp_eastern_azur_8_1";
      head = "head_mp_eastern_azur_8_1";
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_sn_xmike109_mp", ["brakesnpr_xmike109", "calcust1_xmike109", "thermal_alpha50_mp", "none", "none", "none"], "none", "none");
      _id_A664AAD02EE98BD2 = "frag_grenade_mp";
      break;
    case "lmg":
      body = "body_mp_eastern_velikan_1_1";
      head = "head_mp_eastern_velikan_1_1";
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_lm_mgolf36_mp", ["thermal", "none", "none", "none", "none", "none"], "none", "none");
      _id_A664AAD02EE98BD2 = "semtex_mp";
      break;
    case "smg":
      body = "body_mp_eastern_rodion_7_1";
      head = "head_mp_eastern_rodion_7_1";
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_sm_uzulu_mp", ["thermal", "none", "none", "none", "silencer", "laserrange_smg"], "none", "none");
      _id_A664AAD02EE98BD2 = "smoke_grenade_mp";
      break;
    default:
      break;
  }

  _id_16C92180949DB961(body, head, weapon, _id_A664AAD02EE98BD2);
}

_id_16C92180949DB961(body, head, weapon, _id_A664AAD02EE98BD2) {
  self setModel(body);

  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self attach(head, "", 1);
  self.headmodel = head;
  _id_18A73A64992DD07D::give_soldier_armor();
  _id_18A73A64992DD07D::give_soldier_helmet();
  self.allowpain = 0;
  self.equip_armor = 1;
  self._id_B5218CF00DAD94EF = 840;
  self.goalradius = 2048;

  if(isDefined(self.weapon))
    self takeweapon(self.weapon);

  self.weapon = weapon;
  scripts\common\utility::initweapon(self.weapon);
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = makeweapon(_id_A664AAD02EE98BD2);
  self.grenadeammo = 2;
  self.script_forcegrenade = 1;
  self.accuracy = 0.4;
  self.dontkilloff = 1;
  thread _id_537A712B2BE3193C::_id_9C0FBE62C1B9D660();
  thread watchchangeweapon();
  thread _id_173F238005CB70B9::_id_596D07FACB536BBC();
  _id_173F238005CB70B9::_id_38E18AC0E9DFFAF1("vip_contract_spawn");
}

watchchangeweapon() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    objweapon = self getcurrentweapon();

    if(isDefined(objweapon))
      dochangeweapon(objweapon);

    self waittill("weapon_change");
  }
}

dochangeweapon(objweapon) {
  _id_74502A9E0EF1F19C::updatelauncherusage();
  _id_74502A9E0EF1F19C::updatedragonsbreath(objweapon);
}

_id_E8B14B6C2439A458() {
  if(!isDefined(level._id_A9DF3AC87BA5CAFB))
    level._id_A9DF3AC87BA5CAFB = 0;

  level._id_A9DF3AC87BA5CAFB++;
}

_id_95A4AB723C5E0D9B() {
  self waittill("death");
  level._id_A9DF3AC87BA5CAFB--;
}

_id_ADF642D588D55D0F(player) {
  level endon("stop_vip_squad_spawning");
  player waittill("last_stand");
  vip_failquest();
}

lootcachesearchparams(searchcircleorigin, reservedplacement) {
  _id_354D1457278B342C = spawnStruct();
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

vip_completequest() {
  params = spawnStruct();
  rewardtier = _id_029458C0B233BE34::getquestrewardtier(self.team);
  missionid = _id_029458C0B233BE34::getquestindex("vip");
  _id_11D65784F0B6AFA2 = _id_029458C0B233BE34::getquestrewardgroupindex(_id_029458C0B233BE34::getquestrewardbuildgroupref("vip"));
  params.packedbits = _id_029458C0B233BE34::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);
  _id_029458C0B233BE34::displayteamsplash(self.team, "br_vip_quest_complete", params);
  level notify("stop_vip_squad_spawning");
  _id_029458C0B233BE34::_id_20739E471AE0C29B("allies", 1500);
  self.result = "success";
  _id_029458C0B233BE34::removequestinstance();
}

vip_failquest() {
  _id_029458C0B233BE34::displayteamsplash(self.team, "br_vip_quest_you_killed_the_vip");
  self.result = "fail";
  _id_029458C0B233BE34::removequestinstance();
  level notify("stop_vip_squad_spawning");
}

updatescavengerhud() {
  foreach(player in self.playerlist)
  player _id_029458C0B233BE34::uiobjectivesetparameter(self.phaseindex);

  players = _id_029458C0B233BE34::sortvalidplayersinarray(self.playerlist);

  foreach(player in players["valid"]) {
    player _id_029458C0B233BE34::uiobjectiveshow("vip");
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

vip_ontimerexpired() {
  vip_completequest();
}

_id_F172FE1E275011B7() {
  return 1;
}