/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\plunder.gsc
***********************************************/

function init() {
  level.firstkillplayers = [];
  level.dogtagsplayer = [];
  createtags();
  thread removetagsongameended();
  thread onplayerconnect();
}

function setpickupcallback(var_0) {
  level.plunderpickupcallback = var_0;
}

function createtags() {
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

  if(scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "pill") {
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

function createtagsofcolor(var_0) {
  var_0.dogtags = [];

  for(var_1 = 0; var_1 < var_0.maxtags; var_1++) {
    var_2 = spawn("script_model", (0, 0, 0));
    var_2 setModel(var_0.tagmodel);
    var_2 scriptmodelplayanim("mp_dogtag_spin");
    var_2 hide();
    var_2 setasgametypeobjective();
    var_3 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    var_3.targetname = "trigger_dogtag";
    var_3 hide();
    var_4 = spawnStruct();
    var_4.type = "useObject";
    var_4.curorigin = var_3.origin;
    var_4.entnum = var_3 getentitynumber();
    var_4.lastusedtime = 0;
    var_4.visuals = var_2;
    var_4.offset3d = (0, 0, 16);
    var_4.trigger = var_3;
    var_4.triggertype = "proximity";
    var_4 scripts\mp\gameobjects::allowuse("none");
    var_0.dogtags[var_0.dogtags.size] = var_4;
  }
}

function gettag(var_0) {
  var_1 = level.droploot[var_0].dogtags[0];
  var_2 = gettime();

  foreach(var_4 in level.droploot[var_0].dogtags) {
    if(!isDefined(var_4.lastusedtime)) {
      continue;
    }

    if(var_4.interactteam == "none") {
      var_1 = var_4;
      break;
    }

    if(var_4.lastusedtime < var_2) {
      var_2 = var_4.lastusedtime;
      var_1 = var_4;
    }
  }

  var_1 notify("reset");
  var_1 scripts\mp\gameobjects::initializetagpathvariables();
  var_1.lastusedtime = gettime();
  return var_1;
}

function spawntag(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + (0, 0, 0);
  var_5 = (0, randomfloat(360), 0);
  var_6 = anglesToForward(var_5);

  if(istrue(var_3)) {
    var_7 = randomfloatrange(16, 64);
  } else {
    var_7 = 0;
  }

  var_5 += var_7 * var_7;
  var_8 = gettag(var_1);
  var_8.curorigin = var_5;
  var_8.trigger.origin = var_5;
  var_8.visuals.origin = var_5;
  var_8.tagtype = var_1;
  var_8.trigger show();
  var_8 scripts\mp\gameobjects::allowuse("any");
  showtoall(var_8.visuals, var_8);
  var_8.visuals setasgametypeobjective();
  return var_8;
}

function dropplayerstags(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "pill") {
    droptags(var_0, var_0.tagscarried, var_1);
  } else {
    var_2 = scripts\engine\utility::array_contains(level.firstkillplayers, var_0);
    var_3 = 1;

    if(!var_2) {
      var_3 = 5;
      level.firstkillplayers = scripts\engine\utility::array_add(level.firstkillplayers, var_0);
    }

    var_4 = var_0.tagscarried + var_3;
    droptags(var_0, var_4, var_1);
  }

  playersettagcount(var_0, 0);
}

function droptags(var_0, var_1) {
  var_2 = int(var_0 / 80);
  var_3 = int(var_0 % 80);
  droptagsoftype(5, int(max(0, var_2)), self, var_1);
  var_4 = int(var_3 / 40);
  var_3 = int(var_3 % 40);
  droptagsoftype(4, int(max(0, var_4)), self, var_1);
  var_5 = int(var_3 / 20);
  var_3 = int(var_3 % 20);
  droptagsoftype(3, int(max(0, var_5)), self, var_1);
  var_6 = int(var_3 / 10);
  var_3 = int(var_3 % 10);
  droptagsoftype(2, int(max(0, var_6)), self, var_1);
  var_7 = int(var_3 / 5);
  var_3 = int(var_3 % 5);
  droptagsoftype(1, int(max(0, var_7)), self, var_1);
  var_8 = int(var_3 / 1);
  var_3 = int(var_3 % 1);
  droptagsoftype(0, int(max(0, var_8)), self, var_1);
}

function droptagsesc(var_0, var_1) {
  var_2 = int(var_0 / 80);
  var_3 = int(var_0 % 80);
  droptagsoftype(5, int(max(0, var_2)), self, var_1);
  var_4 = int(var_3 / 40);
  var_3 = int(var_3 % 40);
  droptagsoftype(4, int(max(0, var_4)), self, var_1);
  var_5 = int(var_3 / 20);
  var_3 = int(var_3 % 20);
  droptagsoftype(3, int(max(0, var_5)), self, var_1);
  var_6 = int(var_3 / 10);
  var_3 = int(var_3 % 10);
  droptagsoftype(2, int(max(0, var_6)), self, var_1);
  var_7 = int(var_3 / 5);
  var_3 = int(var_3 % 5);
  droptagsoftype(1, int(max(0, var_7)), self, var_1);
  var_8 = int(var_3 / 1);
  var_3 = int(var_3 % 1);
  droptagsoftype(0, int(max(0, var_8)), self, var_1);
}

function droptagsoftype(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = spawntag(var_0, var_2.origin, var_2.team, 1);
    var_5.team = var_2.team;
    level notify("new_tag_spawned", var_5);
    var_5.victim = var_2;
    var_5.attacker = var_3;
    thread monitortaguse(level);
  }
}

function playersettagcount(var_0) {
  if(!isDefined(self.tagscarried)) {
    self.tagscarried = 0;
  }

  if(isDefined(level.plunderpickupcallback)) {
    var_1 = var_0 - self.tagscarried;
    [[level.plunderpickupcallback]](var_1);
  }

  self.tagscarried = var_0;
  self.game_extrainfo = var_0;

  if(scripts\mp\utility\game::getgametype() != "hvt") {
    if(scripts\mp\utility\game::getgametype() == "pill") {
      self setclientomnvar("ui_pillage_currency", var_0);
    } else {
      self setclientomnvar("ui_grind_tags", var_0);
    }
  }

  var_2 = gettagcode(var_0);

  if(scripts\mp\utility\game::getgametype() != "br" && scripts\mp\utility\game::getgametype() != "pill") {
    var_3 = self getentitynumber();

    if(var_3 < 20) {
      setomnvar("ui_droploot_inv_" + self getentitynumber(), var_2);
      return;
    }

    return;
  }
}

function gettagcode(var_0) {
  if(var_0 == 0) {
    return 0;
  }

  var_1 = int(var_0 / 80);
  var_2 = int(var_0 % 80);
  var_3 = int(var_2 / 40);
  var_2 = int(var_2 % 40);
  var_4 = int(var_2 / 20);
  var_2 = int(var_2 % 20);
  var_5 = int(var_2 / 10);
  var_2 = int(var_2 % 10);
  var_6 = int(var_2 / 5);
  var_2 = int(var_2 % 5);
  var_7 = int(var_2 / 1);
  var_2 = int(var_2 % 1);
  var_8 = var_7 + var_6 * 10 + var_5 * 100 + var_4 * 1000 + var_3 * 10000 + var_1 * 100000;
  return var_8;
}

function monitorjointeam() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::ref_143A5("joined_team", "joined_spectators");
    playersettagcount(0);
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.isscoring = 0;
    thread monitorjointeam();
  }
}

function monitortaguse(var_0) {
  level endon("game_ended");
  var_0 endon("deleted");
  var_0 endon("reset");
  wait 2;

  for(;;) {
    var_0.trigger waittill("trigger", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }

    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }

    if(isagent(var_1) && isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }

    playsoundatpos(var_0.curorigin, "mp_killconfirm_tags_pickup");
    var_0.visuals hide();
    var_0.trigger hide();
    var_0.curorigin = (0, 0, -1000);
    var_0.trigger.origin = (0, 0, -1000);
    var_0.visuals.origin = (0, 0, -1000);
    var_0 scripts\mp\gameobjects::allowuse("none");
    var_2 = level.droploot[var_0.tagtype].points;
    playersettagcount(var_1, var_1.tagscarried + var_2);

    if(isDefined(level.supportcranked) && level.supportcranked) {
      if(isDefined(var_1.cranked) && var_1.cranked) {
        var_1 scripts\mp\cranked::setcrankedplayerbombtimer("kill");
      } else {
        var_1 scripts\mp\cranked::oncranked(undefined, var_1);
      }
    }

    if(scripts\mp\utility\game::getgametype() == "hvt") {
      var_1 scripts\mp\gametypes\hvt::ref_13A27();
    }

    break;
  }
}

function playercanusetags(var_0) {
  return true;
}

function showtoall(var_0) {
  self hide();

  foreach(var_2 in level.players) {
    self showtoplayer(var_2);
  }
}

function removetagsongameended() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(!isDefined(var_1.tagscarried)) {
      continue;
    }

    var_1.tagscarried = 0;
  }
}

function initlootcaches() {
  var_0 = scripts\engine\utility::getStructArray("loot_cache", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0.size * 0.5;
  level.lootcaches = [];
  jumpiffalse(1) LOC_00000064;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    level.lootcaches[level.lootcaches.size] = createlootcache(var_0[var_2].origin, var_0[var_2].angles, -1);
  }

  return;
}

function createlootcache(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\killstreaks\airdrop::placeplcrate(var_2, var_0, var_1);
  return var_3;
}

function capturelootcachecallback(var_0) {
  var_0 notify("opened_cache", self);
  var_1 = self.data.contents;

  if(var_1 == -1) {
    var_2 = randomint(90);

    if(var_2 <= 20) {
      var_1 = 0;
    } else if(var_2 <= 60) {
      var_1 = 1;
    } else if(var_2 <= 70) {
      var_1 = 3;
    } else if(var_2 <= 80) {
      var_1 = 5;
    } else {
      var_1 = 4;
    }
  }

  switch (var_1) {
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

  var_0 playlocalsound("ammo_crate_use");
}

function gettagcountfromcache(var_0) {
  return var_0 * randomfloatrange(0.8, 1.2);
}

function getgunfromcache() {
  var_0 = randomint(level.br_pickups.br_supportedguns.size);
  return level.br_pickups.br_supportedguns[var_0];
}

function getitemfromcache() {
  var_0 = randomint(level.br_pickups.br_supporteditems.size);
  return level.br_pickups.br_supporteditems[var_0];
}

function getgrenadeammofromcache() {
  return level.esc_lootinfo.grenadeammo;
}

function getammofromcache() {
  if(!1) {
    var_0 = randomint(level.esc_lootinfo.ammo.size);
    return level.esc_lootinfo.ammo[var_0];
  }

  return 105;
}

function processnotifyweapondrop(var_0, var_1) {
  switch (var_0) {
    case 0:
      var_1 notify("cache_common_weapon_found");
      break;
    case 1:
      var_1 notify("cache_uncommon_weapon_found");
      break;
    case 2:
      var_1 notify("cache_rare_weapon_found");
      break;
    case 3:
      var_1 notify("cache_epic_weapon_found");
      break;
    case 4:
      var_1 notify("cache_legendary_weapon_found");
      break;
  }
}

function banktags(var_0) {
  var_1 = self getplayerdata("common", "bankedEscapeCurrency");
  self setplayerdata("common", "bankedEscapeCurrency", var_1 + var_0);
}

function resetcacheuseability() {
  foreach(var_1 in level.lootcaches) {
    if(isDefined(var_1.useobj)) {
      var_1.useobj enableplayeruse(self);
    }
  }
}