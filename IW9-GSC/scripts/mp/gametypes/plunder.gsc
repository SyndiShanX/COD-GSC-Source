/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\plunder.gsc
***********************************************/

init() {
  level.firstkillplayers = [];
  level.dogtagsplayer = [];
  createtags();
  level thread removetagsongameended();
  level thread onplayerconnect();
}

setpickupcallback(callback) {
  level.plunderpickupcallback = callback;
}

createtags() {
  level.droploot = [];
  level.droploot[0] = spawnStruct();
  level.droploot[0].points = 1;
  level.droploot[0].tagmodel = "military_dogtags_iw8_white";
  level.droploot[1] = spawnStruct();
  level.droploot[1].points = 5;
  level.droploot[1].tagmodel = "military_dogtags_iw8_green";
  level.droploot[2] = spawnStruct();
  level.droploot[2].points = 10;
  level.droploot[2].tagmodel = "military_dogtags_iw8_blue";
  level.droploot[3] = spawnStruct();
  level.droploot[3].points = 20;
  level.droploot[3].tagmodel = "military_dogtags_iw8_purple";
  level.droploot[4] = spawnStruct();
  level.droploot[4].points = 40;
  level.droploot[4].tagmodel = "military_dogtags_iw8_orange";
  level.droploot[5] = spawnStruct();
  level.droploot[5].points = 80;
  level.droploot[5].tagmodel = "military_dogtags_iw8_gold";

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || scripts\mp\utility\game::getgametype() == "pill") {
    level.droploot[0].maxtags = 30;
    level.droploot[1].maxtags = 30;
    level.droploot[2].maxtags = 20;
    level.droploot[3].maxtags = 10;
    level.droploot[4].maxtags = 10;
    level.droploot[5].maxtags = 10;
  } else {
    level.droploot[0].maxtags = 32;
    level.droploot[1].maxtags = 8;
    level.droploot[2].maxtags = 4;
    level.droploot[3].maxtags = 2;
    level.droploot[4].maxtags = 1;
    level.droploot[5].maxtags = 1;
  }

  level.droploot[0].tags = createtagsofcolor(level.droploot[0]);
  level.droploot[1].tags = createtagsofcolor(level.droploot[1]);
  level.droploot[2].tags = createtagsofcolor(level.droploot[2]);
  level.droploot[3].tags = createtagsofcolor(level.droploot[3]);
  level.droploot[4].tags = createtagsofcolor(level.droploot[4]);
  level.droploot[5].tags = createtagsofcolor(level.droploot[5]);
}

createtagsofcolor(_id_DDB42D4450CAFE26) {
  _id_DDB42D4450CAFE26.dogtags = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DDB42D4450CAFE26.maxtags; _id_AC0E594AC96AA3A8++) {
    visuals = spawn("script_model", (0, 0, 0));
    visuals setModel(_id_DDB42D4450CAFE26.tagmodel);
    visuals scriptmodelplayanim("mp_dogtag_spin");
    visuals hide();
    visuals setasgametypeobjective();
    trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    trigger.targetname = "trigger_dogtag";
    trigger hide();
    _id_34744859AD58739B = spawnStruct();
    _id_34744859AD58739B.type = "useObject";
    _id_34744859AD58739B.curorigin = trigger.origin;
    _id_34744859AD58739B.entnum = trigger getentitynumber();
    _id_34744859AD58739B.lastusedtime = 0;
    _id_34744859AD58739B.visuals = visuals;
    _id_34744859AD58739B.offset3d = (0, 0, 16);
    _id_34744859AD58739B.trigger = trigger;
    _id_34744859AD58739B.triggertype = "proximity";
    _id_34744859AD58739B scripts\mp\gameobjects::allowuse("none");
    _id_DDB42D4450CAFE26.dogtags[_id_DDB42D4450CAFE26.dogtags.size] = _id_34744859AD58739B;
  }
}

gettag(tagtype) {
  _id_5D32298B837DFF31 = level.droploot[tagtype].dogtags[0];
  _id_3071102F98CBED33 = gettime();

  foreach(tag in level.droploot[tagtype].dogtags) {
    if(!isDefined(tag.lastusedtime)) {
      continue;
    }
    if(tag.interactteam == "none") {
      _id_5D32298B837DFF31 = tag;
      break;
    }

    if(tag.lastusedtime < _id_3071102F98CBED33) {
      _id_3071102F98CBED33 = tag.lastusedtime;
      _id_5D32298B837DFF31 = tag;
    }
  }

  _id_5D32298B837DFF31 notify("reset");
  _id_5D32298B837DFF31 scripts\mp\gameobjects::initializetagpathvariables();
  _id_5D32298B837DFF31.lastusedtime = gettime();
  return _id_5D32298B837DFF31;
}

spawntag(tagtype, _id_76A22C18960F72AF, _id_F835C152B2F0F136, _id_D62133FA72347087) {
  startpos = _id_76A22C18960F72AF + (0, 0, 0);
  randomangle = (0, randomfloat(360), 0);
  _id_A76189155F382805 = anglesToForward(randomangle);

  if(istrue(_id_D62133FA72347087))
    _id_A73587155F07BD39 = randomfloatrange(16, 64);
  else
    _id_A73587155F07BD39 = 0;

  startpos = startpos + _id_A73587155F07BD39 * _id_A76189155F382805;
  _id_34744859AD58739B = gettag(tagtype);
  _id_34744859AD58739B.curorigin = startpos;
  _id_34744859AD58739B.trigger.origin = startpos;
  _id_34744859AD58739B.visuals.origin = startpos;
  _id_34744859AD58739B.tagtype = tagtype;
  _id_34744859AD58739B.trigger show();
  _id_34744859AD58739B scripts\mp\gameobjects::allowuse("any");
  _id_34744859AD58739B.visuals showtoall(_id_34744859AD58739B);
  _id_34744859AD58739B.visuals setasgametypeobjective();
  return _id_34744859AD58739B;
}

dropplayerstags(victim, attacker) {
  if(isagent(victim)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "pill")
    victim droptags(victim.tagscarried, attacker);
  else {
    _id_B35CBBD03FE0C4B7 = scripts\engine\utility::array_contains(level.firstkillplayers, victim);
    _id_2674F067A8B8D724 = 1;

    if(!_id_B35CBBD03FE0C4B7) {
      _id_2674F067A8B8D724 = 5;
      level.firstkillplayers = scripts\engine\utility::array_add(level.firstkillplayers, victim);
    }

    _id_A28B6FB6A6902689 = victim.tagscarried + _id_2674F067A8B8D724;
    victim droptags(_id_A28B6FB6A6902689, attacker);
  }

  victim playersettagcount(0);
}

droptags(_id_A28B6FB6A6902689, attacker) {
  _id_1DEAA981FFB04A52 = int(_id_A28B6FB6A6902689 / 80);
  _id_02C0DC6323DDFA44 = int(_id_A28B6FB6A6902689 % 80);
  droptagsoftype(5, int(max(0, _id_1DEAA981FFB04A52)), self, attacker);
  _id_9A145F2C1CB449FA = int(_id_02C0DC6323DDFA44 / 40);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 40);
  droptagsoftype(4, int(max(0, _id_9A145F2C1CB449FA)), self, attacker);
  _id_151A715EC12E8F16 = int(_id_02C0DC6323DDFA44 / 20);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 20);
  droptagsoftype(3, int(max(0, _id_151A715EC12E8F16)), self, attacker);
  _id_2BF5DAE5C928AECC = int(_id_02C0DC6323DDFA44 / 10);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 10);
  droptagsoftype(2, int(max(0, _id_2BF5DAE5C928AECC)), self, attacker);
  _id_DD16FFD1D7814BF9 = int(_id_02C0DC6323DDFA44 / 5);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 5);
  droptagsoftype(1, int(max(0, _id_DD16FFD1D7814BF9)), self, attacker);
  _id_AA126B4DCA442C1B = int(_id_02C0DC6323DDFA44 / 1);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 1);
  droptagsoftype(0, int(max(0, _id_AA126B4DCA442C1B)), self, attacker);
}

droptagsesc(_id_A28B6FB6A6902689, attacker) {
  _id_1DEAA981FFB04A52 = int(_id_A28B6FB6A6902689 / 80);
  _id_02C0DC6323DDFA44 = int(_id_A28B6FB6A6902689 % 80);
  droptagsoftype(5, int(max(0, _id_1DEAA981FFB04A52)), self, attacker);
  _id_9A145F2C1CB449FA = int(_id_02C0DC6323DDFA44 / 40);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 40);
  droptagsoftype(4, int(max(0, _id_9A145F2C1CB449FA)), self, attacker);
  _id_151A715EC12E8F16 = int(_id_02C0DC6323DDFA44 / 20);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 20);
  droptagsoftype(3, int(max(0, _id_151A715EC12E8F16)), self, attacker);
  _id_2BF5DAE5C928AECC = int(_id_02C0DC6323DDFA44 / 10);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 10);
  droptagsoftype(2, int(max(0, _id_2BF5DAE5C928AECC)), self, attacker);
  _id_DD16FFD1D7814BF9 = int(_id_02C0DC6323DDFA44 / 5);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 5);
  droptagsoftype(1, int(max(0, _id_DD16FFD1D7814BF9)), self, attacker);
  _id_AA126B4DCA442C1B = int(_id_02C0DC6323DDFA44 / 1);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 1);
  droptagsoftype(0, int(max(0, _id_AA126B4DCA442C1B)), self, attacker);
}

droptagsoftype(tagtype, _id_A28B6FB6A6902689, victim, attacker) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A28B6FB6A6902689; _id_AC0E594AC96AA3A8++) {
    _id_34744859AD58739B = spawntag(tagtype, victim.origin, victim.team, 1);
    _id_34744859AD58739B.team = victim.team;
    level notify("new_tag_spawned", _id_34744859AD58739B);
    _id_34744859AD58739B.victim = victim;
    _id_34744859AD58739B.attacker = attacker;
    level thread monitortaguse(_id_34744859AD58739B);
  }
}

playersettagcount(_id_D86673173E8641BE) {
  if(!isDefined(self.tagscarried))
    self.tagscarried = 0;

  if(isDefined(level.plunderpickupcallback)) {
    _id_3777ECE6A73EADA5 = _id_D86673173E8641BE - self.tagscarried;
    [[level.plunderpickupcallback]](_id_3777ECE6A73EADA5);
  }

  self.tagscarried = _id_D86673173E8641BE;
  self.game_extrainfo = _id_D86673173E8641BE;

  if(scripts\mp\utility\game::getgametype() != "hvt") {
    if(scripts\mp\utility\game::getgametype() == "pill")
      self setclientomnvar("ui_pillage_currency", _id_D86673173E8641BE);
    else
      self setclientomnvar("ui_grind_tags", _id_D86673173E8641BE);
  }

  _id_15F1A1F34F8D9286 = gettagcode(_id_D86673173E8641BE);

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getgametype() != "pill") {
    entnumber = self getentitynumber();

    if(entnumber < 20)
      setomnvar("ui_droploot_inv_" + self getentitynumber(), _id_15F1A1F34F8D9286);
  }
}

gettagcode(_id_D86673173E8641BE) {
  if(_id_D86673173E8641BE == 0)
    return 0;

  _id_1DEAA981FFB04A52 = int(_id_D86673173E8641BE / 80);
  _id_02C0DC6323DDFA44 = int(_id_D86673173E8641BE % 80);
  _id_9A145F2C1CB449FA = int(_id_02C0DC6323DDFA44 / 40);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 40);
  _id_151A715EC12E8F16 = int(_id_02C0DC6323DDFA44 / 20);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 20);
  _id_2BF5DAE5C928AECC = int(_id_02C0DC6323DDFA44 / 10);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 10);
  _id_DD16FFD1D7814BF9 = int(_id_02C0DC6323DDFA44 / 5);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 5);
  _id_AA126B4DCA442C1B = int(_id_02C0DC6323DDFA44 / 1);
  _id_02C0DC6323DDFA44 = int(_id_02C0DC6323DDFA44 % 1);
  _id_15F1A1F34F8D9286 = _id_AA126B4DCA442C1B + _id_DD16FFD1D7814BF9 * 10 + _id_2BF5DAE5C928AECC * 100 + _id_151A715EC12E8F16 * 1000 + _id_9A145F2C1CB449FA * 10000 + _id_1DEAA981FFB04A52 * 100000;
  return _id_15F1A1F34F8D9286;
}

monitorjointeam() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
    playersettagcount(0);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player.isscoring = 0;
    player thread monitorjointeam();
  }
}

monitortaguse(tag) {
  level endon("game_ended");
  tag endon("deleted");
  tag endon("reset");
  wait 2.0;

  for(;;) {
    tag.trigger waittill("trigger", player);

    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(isDefined(player.classname) && player.classname == "script_vehicle") {
      continue;
    }
    if(isagent(player) && isDefined(player.owner))
      player = player.owner;

    playsoundatpos(tag.curorigin, "mp_killconfirm_tags_pickup");
    tag.visuals hide();
    tag.trigger hide();
    tag.curorigin = (0, 0, -1000);
    tag.trigger.origin = (0, 0, -1000);
    tag.visuals.origin = (0, 0, -1000);
    tag scripts\mp\gameobjects::allowuse("none");
    _id_85BF42CB2A0EE5C9 = level.droploot[tag.tagtype].points;
    player playersettagcount(player.tagscarried + _id_85BF42CB2A0EE5C9);

    if(scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(player)) {
      if(isDefined(player.cranked) && player.cranked)
        player scripts\mp\cranked::setcrankedplayerbombtimer("kill");
      else
        player scripts\mp\cranked::oncranked(undefined, player);
    }

    break;
  }
}

playercanusetags(player) {
  return 1;
}

showtoall(gameobject) {
  self hide();

  foreach(player in level.players)
  self showtoplayer(player);
}

removetagsongameended() {
  level waittill("game_ended");

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player.tagscarried)) {
      continue;
    }
    player.tagscarried = 0;
  }
}

initlootcaches() {
  lootcaches = scripts\engine\utility::getStructArray("loot_cache", "targetname");
  lootcaches = scripts\engine\utility::array_randomize(lootcaches);
  _id_B48EA81AF1E939C4 = lootcaches.size * 0.5;
  level.lootcaches = [];

  if(1) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B48EA81AF1E939C4; _id_AC0E594AC96AA3A8++)
      level.lootcaches[level.lootcaches.size] = createlootcache(lootcaches[_id_AC0E594AC96AA3A8].origin, lootcaches[_id_AC0E594AC96AA3A8].angles, -1);
  } else {
    _id_CE560CD629607C2C = _id_B48EA81AF1E939C4 * 0.4;
    _id_0E2FB3B0B7F32130 = _id_B48EA81AF1E939C4 * 0.1;
    _id_86E4D40F1F35034C = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CE560CD629607C2C; _id_AC0E594AC96AA3A8++) {
      level.lootcaches[level.lootcaches.size] = createlootcache(lootcaches[_id_AC0E594AC96AA3A8].origin, lootcaches[_id_AC0E594AC96AA3A8].angles, 1);
      _id_86E4D40F1F35034C = _id_AC0E594AC96AA3A8;
    }

    for(_id_AC0E594AC96AA3A8 = _id_86E4D40F1F35034C + 1; _id_AC0E594AC96AA3A8 < _id_0E2FB3B0B7F32130 + _id_CE560CD629607C2C; _id_AC0E594AC96AA3A8++) {
      level.lootcaches[level.lootcaches.size] = createlootcache(lootcaches[_id_AC0E594AC96AA3A8].origin, lootcaches[_id_AC0E594AC96AA3A8].angles, 3);
      _id_86E4D40F1F35034C = _id_AC0E594AC96AA3A8;
    }

    for(_id_AC0E594AC96AA3A8 = _id_86E4D40F1F35034C + 1; _id_AC0E594AC96AA3A8 < _id_B48EA81AF1E939C4; _id_AC0E594AC96AA3A8++)
      level.lootcaches[level.lootcaches.size] = createlootcache(lootcaches[_id_AC0E594AC96AA3A8].origin, lootcaches[_id_AC0E594AC96AA3A8].angles, 0);
  }
}

createlootcache(origin, angles, contents) {
  _id_B038ED928EC17A81 = scripts\cp_mp\killstreaks\airdrop::placeplcrate(contents, origin, angles);
  return _id_B038ED928EC17A81;
}

capturelootcachecallback(player) {
  player notify("opened_cache", self);
  contents = self.data.contents;

  if(contents == -1) {
    _id_8B591B0BC361AB3D = randomint(90);

    if(_id_8B591B0BC361AB3D <= 20)
      contents = 0;
    else if(_id_8B591B0BC361AB3D <= 60)
      contents = 1;
    else if(_id_8B591B0BC361AB3D <= 70)
      contents = 3;
    else if(_id_8B591B0BC361AB3D <= 80)
      contents = 5;
    else
      contents = 4;
  }

  switch (contents) {
    case 5:
      break;
    case 0:
      break;
    case 1:
      break;
    case 3:
      break;
    case 4:
      break;
    default:
      droptags(100);
      break;
  }

  player playlocalsound("ammo_crate_use", undefined, undefined, 1);
}

gettagcountfromcache(_id_9A1A76FCEEAB88E6) {
  return _id_9A1A76FCEEAB88E6 * randomfloatrange(0.8, 1.2);
}

getgunfromcache() {
  _id_111A8E98DCE6A897 = randomint(level.br_pickups.br_supportedguns.size);
  return level.br_pickups.br_supportedguns[_id_111A8E98DCE6A897];
}

getitemfromcache() {
  _id_3793828403C6873E = randomint(level.br_pickups.br_supporteditems.size);
  return level.br_pickups.br_supporteditems[_id_3793828403C6873E];
}

getgrenadeammofromcache() {
  return level.esc_lootinfo.grenadeammo;
}

getammofromcache() {
  if(!1) {
    _id_3793828403C6873E = randomint(level.esc_lootinfo.ammo.size);
    return level.esc_lootinfo.ammo[_id_3793828403C6873E];
  }

  return 105;
}

processnotifyweapondrop(_id_F015EC9CA74F51DE, player) {
  switch (_id_F015EC9CA74F51DE) {
    case 0:
      player notify("cache_common_weapon_found");
      break;
    case 1:
      player notify("cache_uncommon_weapon_found");
      break;
    case 2:
      player notify("cache_rare_weapon_found");
      break;
    case 3:
      player notify("cache_epic_weapon_found");
      break;
    case 4:
      player notify("cache_legendary_weapon_found");
      break;
  }
}

resetcacheuseability() {
  foreach(_id_B038ED928EC17A81 in level.lootcaches) {
    if(isDefined(_id_B038ED928EC17A81.useobj))
      _id_B038ED928EC17A81.useobj enableplayeruse(self);
  }
}