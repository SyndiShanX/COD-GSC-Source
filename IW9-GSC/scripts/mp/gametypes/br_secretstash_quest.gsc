/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_secretstash_quest.gsc
*********************************************************/

init() {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("body", ::secretstashlootcacheused);
  enabled = _id_3ACF1C0EBAF602F2::registerquestcategory("secretstash", 1);

  if(!enabled) {
    return;
  }
  _id_3ACF1C0EBAF602F2::getquestdata("secretstash").searchcirclesize = getdvarint("dvar_78BCA7221BBEDE3B", 3500);
  _id_3ACF1C0EBAF602F2::getquestdata("secretstash").missionbasetimer = getdvarint("dvar_EDB6290ECFB6C128", 180);
  _id_3ACF1C0EBAF602F2::registertabletinit("secretstash", ::sstablet_init);
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("secretstash", ::ss_removequestinstance);
  _id_3ACF1C0EBAF602F2::registeronplayerdisconnect("secretstash", ::ss_playerdisconnect);
  _id_3ACF1C0EBAF602F2::registerquestcircletick("secretstash", ::ss_circletick);
  _id_3ACF1C0EBAF602F2::registeronentergulag("secretstash", ::ss_entergulag);
  _id_3ACF1C0EBAF602F2::registeronrespawn("secretstash", ::ss_respawn);
  _id_3ACF1C0EBAF602F2::questtimerinit("secretstash", 1);
  _id_3ACF1C0EBAF602F2::registerontimerexpired("secretstash", ::ss_ontimerexpired);
}

sstablet_init() {
  _id_AA9D61F3C51B6A77 = self.origin;
  _id_354D1457278B342C = lootcachesearchparams(_id_AA9D61F3C51B6A77);
  placement = _id_3ACF1C0EBAF602F2::findquestplacement("secretstash", _id_354D1457278B342C);

  if(!isDefined(placement))
    return 0;

  disablelootspawnpoint(placement.index);
  _id_AA9D61F3C51B6A77 = placement.origin;
  self.reservedplacement = placement;
  return 1;
}

ss_circletick(_id_819EDACDACB810E4, _id_E86632D645C137D0) {
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
    instance failsecretstashquest();
  }
}

ss_entergulag(player) {
  if(!checkforcorrectinstance(player)) {
    return;
  }
  player _id_3ACF1C0EBAF602F2::uiobjectivehide();
  scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
}

ss_respawn(player) {
  if(!checkforcorrectinstance(player)) {
    return;
  }
  player _id_3ACF1C0EBAF602F2::uiobjectiveshow("secretstash");
  scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
}

ss_ontimerexpired() {
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_scavenger_quest_timer_expired");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", self.team, 1);
}

ss_removequestinstance() {
  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  _id_3ACF1C0EBAF602F2::releaseteamonquest(self.team);
}

ss_playerdisconnect(_id_345221032955C106) {
  if(_id_345221032955C106.team == self.team) {
    playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
    _id_3ACF1C0EBAF602F2::getquestinstancedata("secretstash", self.team).playerlist = playerlist;

    if(isDefined(self) && isDefined(self.cacheentity) && playerlist.size)
      self.cacheentity setotherent(playerlist[0]);

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

takequestitem(pickupent) {
  instance = _id_3ACF1C0EBAF602F2::createquestinstance("secretstash", self.team, pickupent.index, pickupent);
  instance _id_3ACF1C0EBAF602F2::registerteamonquest(self.team, self);
  instance _id_3ACF1C0EBAF602F2::registercontributingplayers(self);
  instance.team = self.team;
  instance.startlocation = self.origin;
  instance.currlocation = self.origin;
  instance.reservedplacement = pickupent.reservedplacement;
  instance.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  _id_354D1457278B342C = lootcachesearchparams(instance.startlocation, instance.reservedplacement);
  instance spawnsecretstashlootcache(instance.reservedplacement.origin, instance.reservedplacement.angles);
  instance scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("ScavengerHunt_Br", instance.reservedplacement.origin, 3500);
  instance updatesecretstashhud();
  _id_3ACF1C0EBAF602F2::uiobjectiveshowtoteam("secretstash", self.team);
  instance _id_3ACF1C0EBAF602F2::questtimerset(_id_3ACF1C0EBAF602F2::getquestdata("secretstash").missionbasetimer, 4);
  _id_3ACF1C0EBAF602F2::addquestinstance("secretstash", instance);
  _id_3ACF1C0EBAF602F2::startteamcontractchallenge("secretstash", self, self.team);
  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self;
  params.plundervar = _id_3ACF1C0EBAF602F2::getquestplunderreward("secretstash", _id_3ACF1C0EBAF602F2::getquestrewardtier(self.team));
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_secretstash_quest_start_team_notify", params);
  _id_3ACF1C0EBAF602F2::displayplayersplash(self, "br_secretstash_quest_start_tablet_finder", params);
  _id_3ACF1C0EBAF602F2::giveteampoints(self.team, "stat_67EB4B642067882A");
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
  _id_354D1457278B342C.mintime = 60;

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder") {
    if(_id_354D1457278B342C.searchradiusmax < level.quest_secretdistmax)
      _id_354D1457278B342C.searchradiusmax = level.quest_secretdistmax;

    _id_354D1457278B342C.searchradiusidealmax = level.quest_secretdistmax;
    _id_354D1457278B342C.searchradiusidealmin = level.quest_secretdistmin;
  }

  return _id_354D1457278B342C;
}

spawnsecretstashlootcache(_id_7E05C139FBBD8374, _id_5B9C864B21207FF6) {
  cacheentity = spawn("script_model", _id_7E05C139FBBD8374);
  _id_7F599ACCB72658D1 = self.playerlist[0];
  cacheentity.angles = _id_5B9C864B21207FF6;
  cacheentity setotherent(_id_7F599ACCB72658D1);
  cacheentity setModel("military_loot_crate_01_br_secretstash_01");
  cacheentity setscriptablepartstate("body", "secretstash_closed");
  cacheentity.questinstance = self;
  self.cacheentity = cacheentity;

  foreach(player in level.players) {
    if(player != _id_7F599ACCB72658D1 && (_id_7F599ACCB72658D1.team == "none" || player.team != _id_7F599ACCB72658D1.team))
      cacheentity disablescriptableplayeruse(player);
  }
}

updatesecretstashhud() {
  players = _id_3ACF1C0EBAF602F2::sortvalidplayersinarray(self.playerlist);

  foreach(player in players["valid"]) {
    player _id_3ACF1C0EBAF602F2::uiobjectiveshow("secretstash");
    scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
  }

  foreach(player in players["invalid"]) {
    player _id_3ACF1C0EBAF602F2::uiobjectivehide();
    scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
  }
}

hidesecretstashhudfromplayer(player) {
  scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
  player _id_3ACF1C0EBAF602F2::uiobjectivehide();
}

deletesecretstashhud() {
  foreach(player in self.playerlist)
  hidesecretstashhudfromplayer(player);

  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
}

secretstashlootcacheused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(istrue(player _id_362C58E8BB39BCDA::runbrgametypefunc("playerSkipLootPickup", instance))) {
    return;
  }
  if(state == "secretstash_closed" && isDefined(instance.entity)) {
    questinstance = instance.entity.questinstance;

    if(player.team != questinstance.team) {
      player iprintlnbold("Chest Requires a Scavenger Mission");
      return;
    }

    instance setscriptablepartstate("body", "secretstash_opening");
    _id_C0858ACEEA4BB7D9 = getdvarint("dvar_3B1EC176D14497EA", 30);
    instance.entity scripts\engine\utility::_id_AD9433AAB9FCDF04(_id_C0858ACEEA4BB7D9, "death_or_disconnect", ::delete);
    _id_3ACF1C0EBAF602F2::givequestrewardgroup("secretstash", player.team, instance.origin, instance.angles, questinstance.rewardscriptable);
    questinstance.rewardorigin = instance.origin;
    questinstance.rewardangles = instance.angles;
    questinstance completesecretstashquest(instance.entity);
    level notify("lootcache_opened_kill_callout" + instance.origin);
    _id_96674628376EABA6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](player.team, 0);

    foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6)
    _id_F0EA4030349A33D5 notify("calloutmarkerping_warzoneKillQuestIcon");
  }
}

completesecretstashquest(chest) {
  params = spawnStruct();
  rewardtier = 0;
  missionid = 0;
  _id_11D65784F0B6AFA2 = 0;
  params.packedbits = 0;
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_secretstash_quest_complete", params);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_scav_success", self.team, 1, 1);
  self.rewardorigin = chest.origin;
  self.rewardangles = chest.angles;
  self.result = "success";
  _id_3ACF1C0EBAF602F2::removequestinstance();
}

failsecretstashquest() {
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_scavenger_quest_circle_failure");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_obj_circle_fail", self.team, 1);
  self.result = "fail";
  _id_3ACF1C0EBAF602F2::removequestinstance();
}