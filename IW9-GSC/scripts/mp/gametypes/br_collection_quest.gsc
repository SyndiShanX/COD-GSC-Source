/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_collection_quest.gsc
********************************************************/

init() {
  enabled = _id_3ACF1C0EBAF602F2::registerquestcategory("collection", 0);

  if(!enabled) {
    return;
  }
  level.scr_br_collection_findpath = getdvarint("scr_br_collection_findpath", 0) != 0;
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("collection", ::col_removequestinstance);
  _id_3ACF1C0EBAF602F2::registerquestlocale("collect_locale");
  _id_3ACF1C0EBAF602F2::registerquestthink("collect_locale", ::col_localethink_itemspawn, 3);
  _id_3ACF1C0EBAF602F2::registerquestthink("collect_locale", ::col_localethink_objectivevisibility, 0.2);
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("collect_locale", ::col_removelocaleinstance);
  _id_3ACF1C0EBAF602F2::registercreatequestlocale("collect_locale", ::col_createquestlocale);
  _id_3ACF1C0EBAF602F2::registercheckiflocaleisavailable("collect_locale", ::col_checkiflocaleisavailable);
  _id_3ACF1C0EBAF602F2::registerquestcircletick("collect_locale", ::col_circletick);
  _id_3ACF1C0EBAF602F2::getquestdata("collect_locale").nextid = 0;
}

col_removequestinstance() {
  locale = _id_3ACF1C0EBAF602F2::getquestinstancedata("collect_locale", self.team);
  locale hideuielements(self);
  _id_3ACF1C0EBAF602F2::uiobjectivehidefromteam(self.team);

  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players"))
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(locale.objectiveiconid, player);

  _id_3ACF1C0EBAF602F2::releaseteamonquest(self.team);
}

takequestitem(pickupent) {
  _id_3ACF1C0EBAF602F2::uiobjectiveshowtoteam("collection", self.team);
  instance = _id_3ACF1C0EBAF602F2::createquestinstance("collection", self.team, pickupent.index, pickupent);
  instance.team = self.team;
  instance.startlocation = checkpoint(self.origin);
  instance _id_3ACF1C0EBAF602F2::registerteamonquest(self.team, self);
  _id_354D1457278B342C = spawnStruct();
  _id_354D1457278B342C.searchfunc = "questPointsArray";
  _id_354D1457278B342C.searchcircleorigin = instance.startlocation;
  _id_354D1457278B342C.searchradiusmax = 10000;
  _id_354D1457278B342C.searchradiusmin = 0;
  _id_354D1457278B342C.searchradiusidealmax = 6000;
  _id_354D1457278B342C.searchradiusidealmin = 4000;
  _id_354D1457278B342C.mintime = 30;
  _id_354D1457278B342C.initialplayer = self;
  _id_354D1457278B342C.questtypes = 7;
  locale = instance _id_3ACF1C0EBAF602F2::requestquestlocale("collect_locale", _id_354D1457278B342C);
  instance.totalcollecteditems = 0;

  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players"))
  player.collecteditems = 0;

  locale updatelocaleplayerlist();
  locale updateusablestateall();
  locale showuielements(instance);
  _id_3ACF1C0EBAF602F2::addquestinstance("collection", instance);
  _id_3ACF1C0EBAF602F2::startteamcontractchallenge("collection", self, self.team);
  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self;
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_scavenger_quest_start_team", params);
  _id_3ACF1C0EBAF602F2::displayplayersplash(self, "br_scavenger_quest_start_tablet_finder");
}

updatelocaleplayerlist() {
  _id_B87D7E190BAFBD80 = [];

  foreach(instance in self.subscribedinstances) {
    team = instance.team;

    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      if(!isDefined(player)) {
        continue;
      }
      _id_B87D7E190BAFBD80[_id_B87D7E190BAFBD80.size] = player;
    }
  }

  self.playerlist = _id_B87D7E190BAFBD80;
}

updateusablestateall() {
  foreach(item in self.itemlist)
  updateusablestate(item);
}

updateusablestate(item) {
  foreach(player in level.players) {
    if(scripts\engine\utility::array_contains(self.playerlist, player)) {
      item enableplayeruse(player);
      item showtoplayer(player);
      continue;
    }

    item disableplayeruse(player);
  }
}

showuielements(instance) {
  foreach(player in scripts\mp\utility\teams::getteamdata(instance.team, "players")) {
    scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
    updatecollectionuiforplayer(instance, player);
  }
}

updatecollectionui(instance) {
  foreach(player in scripts\mp\utility\teams::getteamdata(instance.team, "players"))
  updatecollectionuiforplayer(instance, player);
}

updatecollectionuiforplayer(instance, player) {
  player _id_3ACF1C0EBAF602F2::uiobjectivesetparameter(instance.totalcollecteditems);
}

determineobjectiveiconvisibility() {
  foreach(player in self.playerlist) {
    if(distance2d(player.origin, self.curorigin) > 0) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objectiveiconid, player);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objectiveiconid, player);
  }
}

hideuielements(instance) {
  foreach(player in scripts\mp\utility\teams::getteamdata(instance.team, "players")) {
    scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
    player _id_3ACF1C0EBAF602F2::uiobjectivehide();
  }
}

findpoint() {
  point = self.curorigin + scripts\engine\math::random_vector_2d() * randomintrange(0, 2900);
  point = checkpoint(point);
  point = point + (0, 0, 10);

  foreach(item in self.itemlist) {
    if(distance(item.origin, point) < 100)
      return undefined;
  }

  if(level.scr_br_collection_findpath) {
    path = self.playerlist[0] findpath(self.curorigin, point, 0, 0);

    if(isDefined(path)) {
      return point;
      return;
    }

    return undefined;
    return;
  } else
    return point;
}

forcespawnitem() {
  if(isDefined(self.previouspoints) && self.previouspoints.size > 0) {
    point = self.previouspoints[0];
    self.previouspoints = scripts\engine\utility::array_remove(self.previouspoints, self.previouspoints[0]);
  } else {
    for(index = 0; index < 30; index++) {
      point = findpoint();

      if(!isDefined(point))
        return point;
    }
  }
}

spawnitem(point) {
  self.numitems++;
  _id_D9A39BCC719E38E5 = spawn("script_model", point);
  _id_D9A39BCC719E38E5 setModel("box_wooden_grenade_01");
  _id_D9A39BCC719E38E5 makeusable();
  _id_D9A39BCC719E38E5 setCursorHint("HINT_NOICON");
  _id_D9A39BCC719E38E5 setuseholdduration("duration_short");
  _id_D9A39BCC719E38E5 sethintdisplayfov(150);
  _id_D9A39BCC719E38E5 setusefov(150);
  _id_D9A39BCC719E38E5 setuserange(150);
  _id_D9A39BCC719E38E5 setHintString(&"MP/SCAV_PICKUP_PROMPT");
  _id_D9A39BCC719E38E5 setasgametypeobjective();
  _id_D9A39BCC719E38E5.locale = self;
  _id_D9A39BCC719E38E5 thread stashthink();
  self.itemlist[self.itemlist.size] = _id_D9A39BCC719E38E5;
}

stashthink() {
  self endon("death");
  self endon("remove_locale");

  for(;;) {
    self waittill("trigger", player);
    thread usestash(player);
  }
}

usestash(player) {
  locale = self.locale;
  instance = _id_3ACF1C0EBAF602F2::getquestinstancedata("collection", player.team);

  if(isDefined(instance)) {
    self hide();
    self makeunusable();
    self.origin = self.origin + (0, 0, -500);
    self delete();
    player.collecteditems++;
    instance.totalcollecteditems++;
    locale updatecollectionui(instance);
    locale.numitems = locale.numitems - 1;

    if(!isDefined(locale.previouspoints))
      locale.previouspoints = [];

    locale.previouspoints = scripts\engine\utility::array_add(locale.previouspoints, self.origin);
    locale.itemlist = scripts\engine\utility::array_remove(locale.itemlist, self);

    if(instance.totalcollecteditems >= 10)
      instance thread completecollectionquest(self);
  }
}

completecollectionquest(_id_9FA8F246C7E9BD8E) {
  rewardtier = _id_3ACF1C0EBAF602F2::getquestrewardtier(self.team);
  reward = _id_3ACF1C0EBAF602F2::getquestplunderreward("collection", rewardtier);
  params = spawnStruct();
  missionid = _id_3ACF1C0EBAF602F2::getquestindex("collection");
  params.packedbits = _id_3ACF1C0EBAF602F2::packsplashparambits(missionid, rewardtier);
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.id, "br_scavenger_quest_complete", params);
  _id_3ACF1C0EBAF602F2::giveteamplunderflat(self.team, reward);
  self.rewardorigin = _id_9FA8F246C7E9BD8E.origin;
  self.rewardangles = _id_9FA8F246C7E9BD8E.angles;
  self.result = "success";
  _id_3ACF1C0EBAF602F2::removequestinstance();

  if(isDefined(level._id_52781BE0B4E8A959))
    level[[level._id_52781BE0B4E8A959]](self.team);
}

failcollectionquest() {
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.id, "br_scavenger_quest_circle_failure");
  self.result = "fail";
  _id_3ACF1C0EBAF602F2::removequestinstance();
}

col_checkiflocaleisavailable() {
  if(self.subscribedinstances.size < 4)
    return 1;
  else
    return 0;
}

col_createquestlocale(placement) {
  _id_3ACF1C0EBAF602F2::getquestdata("collect_locale").nextid++;
  locale = _id_3ACF1C0EBAF602F2::createlocaleinstance("collect_locale", "collection", "ColLoc:" + _id_3ACF1C0EBAF602F2::getquestdata("collect_locale").nextid);
  locale.curorigin = placement.origin;
  locale col_createcircleobjectiveicon();
  locale.itemlist = [];
  locale scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Collection_Br", locale.curorigin, 2000);
  locale scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
  _id_3ACF1C0EBAF602F2::addquestinstance("collect_locale", locale);
  return locale;
}

col_createcircleobjectiveicon() {
  self.objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self.objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self.objectiveiconid, "current", (0, 0, 0), "ui_mp_br_mapmenu_icon_scavengerhunt_tablet");
    scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, self.curorigin);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objectiveiconid, 2);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objectiveiconid, 1);
  } else {}
}

col_localethink_itemspawn() {
  if(!isDefined(self.numitems)) {
    self.numitems = 0;
    self.nextitem = 0;
  }

  if(self.nextitem % 3 == 0 || self.numitems < 5) {
    if(self.numitems < 15) {
      if(isDefined(self.nextpoint)) {
        spawnitem(self.nextpoint);
        self.nextpoint = undefined;
      } else
        forcespawnitem();
    }
  }

  self.nextitem++;
}

col_localethink_objectivevisibility() {
  determineobjectiveiconvisibility();

  if(!isDefined(self.nextpoint))
    self.nextpoint = findpoint();
}

col_removelocaleinstance() {
  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  self.playerlist = undefined;
  self.subscribedinstances = undefined;

  foreach(item in self.itemlist) {
    item notify("remove_locale");
    item hide();
    item makeunusable();
    item.origin = item.origin + (0, 0, -500);
    item delete();
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

col_circletick(_id_819EDACDACB810E4, _id_E86632D645C137D0) {
  if(!isDefined(self.lastcircletick))
    self.lastcircletick = -1;

  currenttime = gettime();

  if(self.lastcircletick == currenttime) {
    return;
  }
  self.lastcircletick = currenttime;
  dist = distance2d(self.curorigin, _id_819EDACDACB810E4);

  if(dist > _id_E86632D645C137D0) {
    foreach(_id_FB5FDFAFC29F4513 in self.subscribedinstances)
    _id_3ACF1C0EBAF602F2::getquestinstancedata("collection", _id_FB5FDFAFC29F4513) failcollectionquest();
  }
}

checkpoint(point) {
  if(isnavmeshloaded())
    point = getclosestpointonnavmesh(point);

  return point;
}