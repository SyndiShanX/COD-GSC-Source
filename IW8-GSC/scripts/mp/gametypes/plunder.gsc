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

function setpickupcallback(var0) {
  level.plunderpickupcallback = var0;
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

function createtagsofcolor(var0) {
  var0.dogtags = [];

  for(var1 = 0; var1 < var0.maxtags; var1++) {
    var2 = spawn("script_model", (0, 0, 0));
    var2 setModel(var0.tagmodel);
    var2 scriptmodelplayanim("mp_dogtag_spin");
    var2 hide();
    var2 setasgametypeobjective();
    var3 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    var3.targetname = "trigger_dogtag";
    var3 hide();
    var4 = spawnStruct();
    var4.type = "useObject";
    var4.curorigin = var3.origin;
    var4.entnum = var3 getentitynumber();
    var4.lastusedtime = 0;
    var4.visuals = var2;
    var4.offset3d = (0, 0, 16);
    var4.trigger = var3;
    var4.triggertype = "proximity";
    var4 scripts\mp\gameobjects::allowuse("none");
    var0.dogtags[var0.dogtags.size] = var4;
  }
}

function gettag(var0) {
  var1 = level.droploot[var0].dogtags[0];
  var2 = gettime();

  foreach(var4 in level.droploot[var0].dogtags) {
    if(!isDefined(var4.lastusedtime)) {
      continue;
    }

    if(var4.interactteam == "none") {
      var1 = var4;
      break;
    }

    if(var4.lastusedtime < var2) {
      var2 = var4.lastusedtime;
      var1 = var4;
    }
  }

  var1 notify("reset");
  var1 scripts\mp\gameobjects::initializetagpathvariables();
  var1.lastusedtime = gettime();
  return var1;
}

function spawntag(var0, var1, var2, var3) {
  var4 = var1 + (0, 0, 0);
  var5 = (0, randomfloat(360), 0);
  var6 = anglesToForward(var5);

  if(istrue(var3)) {
    var7 = randomfloatrange(16, 64);
  } else {
    var7 = 0;
  }

  var5 += var7 * var7;
  var8 = gettag(var1);
  var8.curorigin = var5;
  var8.trigger.origin = var5;
  var8.visuals.origin = var5;
  var8.tagtype = var1;
  var8.trigger show();
  var8 scripts\mp\gameobjects::allowuse("any");
  showtoall(var8.visuals, var8);
  var8.visuals setasgametypeobjective();
  return var8;
}

function dropplayerstags(var0, var1) {
  if(isagent(var0)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "pill") {
    droptags(var0, var0.tagscarried, var1);
  } else {
    var2 = scripts\engine\utility::array_contains(level.firstkillplayers, var0);
    var3 = 1;

    if(!var2) {
      var3 = 5;
      level.firstkillplayers = scripts\engine\utility::array_add(level.firstkillplayers, var0);
    }

    var4 = var0.tagscarried + var3;
    droptags(var0, var4, var1);
  }

  playersettagcount(var0, 0);
}

function droptags(var0, var1) {
  var2 = int(var0 / 80);
  var3 = int(var0 % 80);
  droptagsoftype(5, int(max(0, var2)), self, var1);
  var4 = int(var3 / 40);
  var3 = int(var3 % 40);
  droptagsoftype(4, int(max(0, var4)), self, var1);
  var5 = int(var3 / 20);
  var3 = int(var3 % 20);
  droptagsoftype(3, int(max(0, var5)), self, var1);
  var6 = int(var3 / 10);
  var3 = int(var3 % 10);
  droptagsoftype(2, int(max(0, var6)), self, var1);
  var7 = int(var3 / 5);
  var3 = int(var3 % 5);
  droptagsoftype(1, int(max(0, var7)), self, var1);
  var8 = int(var3 / 1);
  var3 = int(var3 % 1);
  droptagsoftype(0, int(max(0, var8)), self, var1);
}

function droptagsesc(var0, var1) {
  var2 = int(var0 / 80);
  var3 = int(var0 % 80);
  droptagsoftype(5, int(max(0, var2)), self, var1);
  var4 = int(var3 / 40);
  var3 = int(var3 % 40);
  droptagsoftype(4, int(max(0, var4)), self, var1);
  var5 = int(var3 / 20);
  var3 = int(var3 % 20);
  droptagsoftype(3, int(max(0, var5)), self, var1);
  var6 = int(var3 / 10);
  var3 = int(var3 % 10);
  droptagsoftype(2, int(max(0, var6)), self, var1);
  var7 = int(var3 / 5);
  var3 = int(var3 % 5);
  droptagsoftype(1, int(max(0, var7)), self, var1);
  var8 = int(var3 / 1);
  var3 = int(var3 % 1);
  droptagsoftype(0, int(max(0, var8)), self, var1);
}

function droptagsoftype(var0, var1, var2, var3) {
  for(var4 = 0; var4 < var1; var4++) {
    var5 = spawntag(var0, var2.origin, var2.team, 1);
    var5.team = var2.team;
    level notify("new_tag_spawned", var5);
    var5.victim = var2;
    var5.attacker = var3;
    thread monitortaguse(level);
  }
}

function playersettagcount(var0) {
  if(!isDefined(self.tagscarried)) {
    self.tagscarried = 0;
  }

  if(isDefined(level.plunderpickupcallback)) {
    var1 = var0 - self.tagscarried;
    [[level.plunderpickupcallback]](var1);
  }

  self.tagscarried = var0;
  self.game_extrainfo = var0;

  if(scripts\mp\utility\game::getgametype() != "hvt") {
    if(scripts\mp\utility\game::getgametype() == "pill") {
      self setclientomnvar("ui_pillage_currency", var0);
    } else {
      self setclientomnvar("ui_grind_tags", var0);
    }
  }

  var2 = gettagcode(var0);

  if(scripts\mp\utility\game::getgametype() != "br" && scripts\mp\utility\game::getgametype() != "pill") {
    var3 = self getentitynumber();

    if(var3 < 20) {
      setomnvar("ui_droploot_inv_" + self getentitynumber(), var2);
      return;
    }

    return;
  }
}

function gettagcode(var0) {
  if(var0 == 0) {
    return 0;
  }

  var1 = int(var0 / 80);
  var2 = int(var0 % 80);
  var3 = int(var2 / 40);
  var2 = int(var2 % 40);
  var4 = int(var2 / 20);
  var2 = int(var2 % 20);
  var5 = int(var2 / 10);
  var2 = int(var2 % 10);
  var6 = int(var2 / 5);
  var2 = int(var2 % 5);
  var7 = int(var2 / 1);
  var2 = int(var2 % 1);
  var8 = var7 + var6 * 10 + var5 * 100 + var4 * 1000 + var3 * 10000 + var1 * 100000;
  return var8;
}

function monitorjointeam() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
    playersettagcount(0);
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);
    var0.isscoring = 0;
    thread monitorjointeam();
  }
}

function monitortaguse(var0) {
  level endon("game_ended");
  var0 endon("deleted");
  var0 endon("reset");
  wait 2;

  for(;;) {
    var0.trigger waittill("trigger", var1);

    if(!scripts\mp\utility\player::isreallyalive(var1)) {
      continue;
    }

    if(isDefined(var1.classname) && var1.classname == "script_vehicle") {
      continue;
    }

    if(isagent(var1) && isDefined(var1.owner)) {
      var1 = var1.owner;
    }

    playsoundatpos(var0.curorigin, "mp_killconfirm_tags_pickup");
    var0.visuals hide();
    var0.trigger hide();
    var0.curorigin = (0, 0, -1000);
    var0.trigger.origin = (0, 0, -1000);
    var0.visuals.origin = (0, 0, -1000);
    var0 scripts\mp\gameobjects::allowuse("none");
    var2 = level.droploot[var0.tagtype].points;
    playersettagcount(var1, var1.tagscarried + var2);

    if(isDefined(level.supportcranked) && level.supportcranked) {
      if(isDefined(var1.cranked) && var1.cranked) {
        var1 scripts\mp\cranked::setcrankedplayerbombtimer("kill");
      } else {
        var1 scripts\mp\cranked::oncranked(undefined, var1);
      }
    }

    if(scripts\mp\utility\game::getgametype() == "hvt") {
      var1 scripts\mp\gametypes\hvt::ref_13a27();
    }

    break;
  }
}

function playercanusetags(var0) {
  return true;
}

function showtoall(var0) {
  self hide();

  foreach(var2 in level.players) {
    self showtoplayer(var2);
  }
}

function removetagsongameended() {
  level waittill("game_ended");

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    if(!isDefined(var1.tagscarried)) {
      continue;
    }

    var1.tagscarried = 0;
  }
}

function initlootcaches() {
  var0 = scripts\engine\utility::getStructArray("loot_cache", "targetname");
  var0 = scripts\engine\utility::array_randomize(var0);
  var1 = var0.size * 0.5;
  level.lootcaches = [];
  jumpiffalse(1) LOC_00000064;

  for(var2 = 0; var2 < var1; var2++) {
    level.lootcaches[level.lootcaches.size] = createlootcache(var0[var2].origin, var0[var2].angles, -1);
  }

  return;
}

function createlootcache(var0, var1, var2) {
  var3 = scripts\cp_mp\killstreaks\airdrop::placeplcrate(var2, var0, var1);
  return var3;
}

function capturelootcachecallback(var0) {
  var0 notify("opened_cache", self);
  var1 = self.data.contents;

  if(var1 == -1) {
    var2 = randomint(90);

    if(var2 <= 20) {
      var1 = 0;
    } else if(var2 <= 60) {
      var1 = 1;
    } else if(var2 <= 70) {
      var1 = 3;
    } else if(var2 <= 80) {
      var1 = 5;
    } else {
      var1 = 4;
    }
  }

  switch (var1) {
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

  var0 playlocalsound("ammo_crate_use");
}

function gettagcountfromcache(var0) {
  return var0 * randomfloatrange(0.8, 1.2);
}

function getgunfromcache() {
  var0 = randomint(level.br_pickups.br_supportedguns.size);
  return level.br_pickups.br_supportedguns[var0];
}

function getitemfromcache() {
  var0 = randomint(level.br_pickups.br_supporteditems.size);
  return level.br_pickups.br_supporteditems[var0];
}

function getgrenadeammofromcache() {
  return level.esc_lootinfo.grenadeammo;
}

function getammofromcache() {
  if(!1) {
    var0 = randomint(level.esc_lootinfo.ammo.size);
    return level.esc_lootinfo.ammo[var0];
  }

  return 105;
}

function processnotifyweapondrop(var0, var1) {
  switch (var0) {
    case 0:
      var1 notify("cache_common_weapon_found");
      break;
    case 1:
      var1 notify("cache_uncommon_weapon_found");
      break;
    case 2:
      var1 notify("cache_rare_weapon_found");
      break;
    case 3:
      var1 notify("cache_epic_weapon_found");
      break;
    case 4:
      var1 notify("cache_legendary_weapon_found");
      break;
  }
}

function banktags(var0) {
  var1 = self getplayerdata("common", "bankedEscapeCurrency");
  self setplayerdata("common", "bankedEscapeCurrency", var1 + var0);
}

function resetcacheuseability() {
  foreach(var1 in level.lootcaches) {
    if(isDefined(var1.useobj)) {
      var1.useobj enableplayeruse(self);
    }
  }
}