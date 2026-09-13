/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6388860e9e2a83bd.gsc
***********************************************/

init() {
  enabled = _id_3ACF1C0EBAF602F2::registerquestcategory("vip", 1);

  if(!enabled) {
    return;
  }
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("vip", ::vip_removequestinstance);
  _id_3ACF1C0EBAF602F2::registeronplayerkilled("vip", ::vip_playerdied);
  _id_3ACF1C0EBAF602F2::registeronplayerdisconnect("vip", ::vip_playerdisconnect);
  _id_3ACF1C0EBAF602F2::registeronentergulag("vip", ::vip_onentergulag);
  _id_3ACF1C0EBAF602F2::registeronrespawn("vip", ::vip_onrespawn);
  _id_3ACF1C0EBAF602F2::registerquestthink("vip", ::vip_questthink_iconposition, 2);
  game["dialog"]["hvt_accept"] = "contract_hvt_accept";
  game["dialog"]["mission_hvt_accept_first_person"] = "mission_mission_hvt_accept_first_person";
  game["dialog"]["mission_hvt_success_third_person"] = "mission_mission_hvt_success_third_person";
  game["dialog"]["mission_hvt_success_first_person"] = "mission_mission_hvt_success_first_person";
  game["dialog"]["mission_hvt_failure"] = "mission_mission_hvt_failure";
  game["dialog"]["mission_hvt_eliminated"] = "mission_mission_hvt_eliminated";
  _id_3ACF1C0EBAF602F2::questtimerinit("vip", 1);
  _id_3ACF1C0EBAF602F2::registerontimerexpired("vip", ::vip_ontimerexpired);
}

takequestitem(pickupent) {
  instance = _id_3ACF1C0EBAF602F2::createquestinstance("vip", self.team, pickupent.index, pickupent);
  instance _id_3ACF1C0EBAF602F2::registerteamonquest(self.team, self);
  _id_3ACF1C0EBAF602F2::giveteampoints(self.team, "stat_67EB4B642067882A");
  instance.team = self.team;
  instance.vip = self;
  instance.vip _id_2CEDCC356F1B9FC8::setplayermostwantedextrainfo(1);
  instance _id_3ACF1C0EBAF602F2::createquestobjicon("ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active", self.origin + (0, 0, 100));
  instance viphud_setupvisibility();
  instance _id_3ACF1C0EBAF602F2::questtimerset(getdvarint("dvar_7F10F216178D1D16", 180), 4);
  _id_3ACF1C0EBAF602F2::addquestinstance("vip", instance);
  _id_3ACF1C0EBAF602F2::startteamcontractchallenge("vip", self, self.team);
  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = instance.vip;
  params.excludedteams = [];
  params.excludedteams[0] = instance.team;
  params.plundervar = _id_3ACF1C0EBAF602F2::getquestplunderreward("vip", _id_3ACF1C0EBAF602F2::getquestrewardtier(self.team));
  _id_3ACF1C0EBAF602F2::displayteamsplash(instance.team, "br_vip_quest_start_vip_team", params);
  _id_3ACF1C0EBAF602F2::displayplayersplash(instance.vip, "br_vip_quest_start_tablet_finder", params);
  _id_3ACF1C0EBAF602F2::displaysplashtoplayersinradius("br_vip_quest_vip_spawn_alert", self.origin, 5000, level.questinfo.defaultfilter, params);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteamexcludeplayer("hvt_accept", instance.team, instance.vip, 1, undefined, 0.5);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("mission_hvt_accept_first_person", instance.vip, 1, undefined, 0.5);
}

viphud_setupvisibility() {
  objective_addalltomask(self.objectiveiconid);
  _id_5C882C8F7BB9C72A = _id_3ACF1C0EBAF602F2::sortvalidplayersinarray(level.players);

  foreach(player in _id_5C882C8F7BB9C72A["valid"])
  _id_3ACF1C0EBAF602F2::showquestobjicontoplayer(player);

  foreach(player in _id_5C882C8F7BB9C72A["invalid"])
  _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(player);

  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(!player _id_2CEDCC356F1B9FC8::isplayeringulag())
      viphud_showtoplayer(player);

    _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(player);
  }
}

vip_playerdied(attacker, victim) {
  if(victim _id_2CEDCC356F1B9FC8::isplayeringulag() || attacker _id_2CEDCC356F1B9FC8::isplayeringulag()) {
    return;
  }
  vip_playerremoved(victim, attacker);
}

vip_playerdisconnect(player) {
  vip_playerremoved(player);
}

vip_onentergulag(player) {
  viphud_hidefromplayer(player);
}

vip_onrespawn(player) {
  if(player.team == self.team)
    viphud_showtoplayer(player);

  _id_3ACF1C0EBAF602F2::showquestobjicontoplayer(player);
}

vip_playerremoved(_id_52BA90EA34B9317E, attacker) {
  if(_id_52BA90EA34B9317E.team == self.team) {
    if(_id_52BA90EA34B9317E == self.vip)
      vip_failquest(attacker);
    else
      viphud_hidefromplayer(_id_52BA90EA34B9317E);
  } else
    _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(_id_52BA90EA34B9317E);
}

vip_ontimerexpired() {
  vip_completequest();
}

vip_removequestinstance() {
  level notify("calloutmarkerping_warzoneKillQuestIconGlobal_" + self.objectiveiconid);
  _id_3ACF1C0EBAF602F2::releaseteamonquest(self.team);
  viphud_deletehud();
}

viphud_showtoplayer(player) {
  player _id_3ACF1C0EBAF602F2::uiobjectiveshow("vip");
  player _id_3ACF1C0EBAF602F2::uiobjectivesetparameter(self.vip getentitynumber());
  _id_3ACF1C0EBAF602F2::showquestobjicontoplayer(player);
}

viphud_hidefromplayer(player) {
  player _id_3ACF1C0EBAF602F2::uiobjectivehide();
  _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(player);
}

viphud_deletehud() {
  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players"))
  viphud_hidefromplayer(player);

  _id_3ACF1C0EBAF602F2::deletequestobjicon();
}

vip_respawnplayer(player, _id_4AC881E2A39322A5, _id_DF2FBB13C226BE75) {
  if(istrue(player.inlaststand))
    player scripts\mp\laststand::finishreviveplayer("use_hold_revive_success", player);

  if(!isalive(player) && !player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
    player thread _id_67708F418B1FAC79::playergulagautowin("vipRespawn", _id_4AC881E2A39322A5);
  else if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
    player thread _id_67708F418B1FAC79::playerpulloutofgulagwin(_id_4AC881E2A39322A5, _id_DF2FBB13C226BE75);
}

vip_completequest() {
  params = spawnStruct();
  rewardtier = _id_3ACF1C0EBAF602F2::getquestrewardtier(self.team);
  missionid = _id_3ACF1C0EBAF602F2::getquestindex("vip");
  _id_11D65784F0B6AFA2 = _id_3ACF1C0EBAF602F2::getquestrewardgroupindex(_id_3ACF1C0EBAF602F2::getquestrewardbuildgroupref("vip"));
  params.packedbits = _id_3ACF1C0EBAF602F2::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_vip_quest_complete", params);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteamexcludeplayer("mission_hvt_success_third_person", self.team, self.vip, 1, undefined, 0.5);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("mission_hvt_success_first_person", self.vip, 1, undefined, 0.5);
  self.vip _id_2CEDCC356F1B9FC8::setplayermostwantedextrainfo(0);

  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players"))
  vip_respawnplayer(player, self.vip, "vip");

  self.rewardmodifier = undefined;
  self.rewardorigin = self.vip.origin;
  self.rewardangles = self.vip.angles;
  self.result = "success";
  thread _id_3ACF1C0EBAF602F2::removequestinstance();
}

vip_failquest(attacker) {
  if(isDefined(attacker) && isPlayer(attacker) && attacker.team != self.team) {
    params = spawnStruct();
    rewardtier = _id_3ACF1C0EBAF602F2::getquestrewardtier(attacker.team);
    missionid = _id_3ACF1C0EBAF602F2::getquestindex("vip");
    self.rewardmodifier = "_killer";
    _id_11D65784F0B6AFA2 = _id_3ACF1C0EBAF602F2::getquestrewardgroupindex(_id_3ACF1C0EBAF602F2::getquestrewardbuildgroupref("vip", self.rewardmodifier, self.modifier));
    params.packedbits = _id_3ACF1C0EBAF602F2::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);
    _id_3ACF1C0EBAF602F2::displayteamsplash(attacker.team, "br_vip_quest_you_killed_the_vip", params);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_hvt_eliminated", attacker.team, 1, 1);
    _id_3ACF1C0EBAF602F2::givequestrewardsinstance(attacker.team, self.vip.origin, self.vip.angles, self.rewardscriptable);
    self.vip _id_2CEDCC356F1B9FC8::setplayermostwantedextrainfo(0);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_hvt_failure", self.team, 1, 1);
    self.rewardmodifier = undefined;
    self.result = "fail";
  }

  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_vip_quest_failure");
  self.rewardmodifier = undefined;
  self.result = "fail";
  _id_3ACF1C0EBAF602F2::removequestinstance();
}

vip_questthink_iconposition() {
  _id_3ACF1C0EBAF602F2::movequestobjicon(self.vip.origin + (0, 0, 100));
}

_id_5F352FB76C54705C() {
  quests = _id_3ACF1C0EBAF602F2::getquestdata("vip");

  if(!isDefined(quests))
    return 0;

  foreach(instance in quests.instances) {
    if(instance.vip == self)
      return 1;
  }

  return 0;
}