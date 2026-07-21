/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\plunder.gsc
***********************************************/

init() {
  level.firstkillplayers = [];
  level.dogtagsplayer = [];
  createtags();
  level thread removetagsongameended();
  level thread onplayerconnect();
}

setpickupcallback(var_0) {
  level.plunderpickupcallback = var_0;
}

createtags() {
  level.droploot = [];
  level.droploot[0] = spawnStruct();
  level.droploot[0].points = 1;
  level.droploot[0].tagmodel = "_encstr_A56A1BF7FB71F804E7B6F2396F0D58151337D279D8D3CFA74BDAE46DDA";
  level.droploot[1] = spawnStruct();
  level.droploot[1].points = 5;
  level.droploot[1].tagmodel = "_encstr_BE1B1B5BD2B196A3B027F2AF23B79D8E589D6EFAD2BB837DB3392BB237";
  level.droploot[2] = spawnStruct();
  level.droploot[2].points = 10;
  level.droploot[2].tagmodel = "_encstr_8CFD1ADD63D0EC6B0F8B5B2151506FE30BD75B679BE060FFA620938A";
  level.droploot[3] = spawnStruct();
  level.droploot[3].points = 20;
  level.droploot[3].tagmodel = "_encstr_AC611CE02FE4A8696AEAD3C847A287B351BF88F95797CA07A3D34E675D7A";
  level.droploot[4] = spawnStruct();
  level.droploot[4].points = 40;
  level.droploot[4].tagmodel = "_encstr_84CD1C70848CA8DDFA3B0BBF9BE2AC88599F3B8E2CFF5AAF321333D5BF6A";
  level.droploot[5] = spawnStruct();
  level.droploot[5].points = 80;
  level.droploot[5].tagmodel = "_encstr_95271AE5AFD23894011353F7DD2D971B9E5767B7BB27138FF90F7967";

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" || scripts\mp\utility\game::getgametype() == "_encstr_A20D05FBEB01F2") {
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

createtagsofcolor(var_0) {
  var_0.dogtags = [];

  for(var_1 = 0; var_1 < var_0.maxtags; var_1++) {
    var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_2 setModel(var_0.tagmodel);
    var_2 scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6");
    var_2 hide();
    var_2 setasgametypeobjective();
    var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (0, 0, 0), 0, 32, 32);
    var_3.targetname = "_encstr_AF980F150AAA1F2765EB36231FA2BB97C0";
    var_3 hide();
    var_4 = spawnStruct();
    var_4.type = "_encstr_8CC00AABB9599E984D2BD81D";
    var_4.curorigin = var_3.origin;
    var_4.entnum = var_3 getentitynumber();
    var_4.lastusedtime = 0;
    var_4.visuals = var_2;
    var_4.offset3d = (0, 0, 16);
    var_4.trigger = var_3;
    var_4.triggertype = "_encstr_83650AB19BA26B100D3CE35A";
    var_4 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    var_0.dogtags[var_0.dogtags.size] = var_4;
  }
}

gettag(var_0) {
  var_1 = level.droploot[var_0].dogtags[0];
  var_2 = gettime();

  foreach(var_4 in level.droploot[var_0].dogtags) {
    if(!isDefined(var_4.lastusedtime)) {
      continue;
    }
    if(var_4.interactteam == "_encstr_8BBA05185F8B99") {
      var_1 = var_4;
      break;
    }

    if(var_4.lastusedtime < var_2) {
      var_2 = var_4.lastusedtime;
      var_1 = var_4;
    }
  }

  var_1 notify("_encstr_88F20627959BCAE8");
  var_1 scripts\mp\gameobjects::initializetagpathvariables();
  var_1.lastusedtime = gettime();
  return var_1;
}

spawntag(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + (0, 0, 0);
  var_5 = (0, randomfloat(360), 0);
  var_6 = anglesToForward(var_5);

  if(istrue(var_3))
    var_7 = randomfloatrange(16, 64);
  else
    var_7 = 0;

  var_4 = var_4 + var_7 * var_6;
  var_8 = gettag(var_0);
  var_8.curorigin = var_4;
  var_8.trigger.origin = var_4;
  var_8.visuals.origin = var_4;
  var_8.tagtype = var_0;
  var_8.trigger show();
  var_8 scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
  var_8.visuals showtoall(var_8);
  var_8.visuals setasgametypeobjective();
  return var_8;
}

dropplayerstags(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "_encstr_A20D05FBEB01F2")
    var_0 droptags(var_0.tagscarried, var_1);
  else {
    var_2 = scripts\engine\utility::array_contains(level.firstkillplayers, var_0);
    var_3 = 1;

    if(!var_2) {
      var_3 = 5;
      level.firstkillplayers = scripts\engine\utility::array_add(level.firstkillplayers, var_0);
    }

    var_4 = var_0.tagscarried + var_3;
    var_0 droptags(var_4, var_1);
  }

  var_0 playersettagcount(0);
}

droptags(var_0, var_1) {
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

droptagsesc(var_0, var_1) {
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

droptagsoftype(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = spawntag(var_0, var_2.origin, var_2.team, 1);
    var_5.team = var_2.team;
    level notify("_encstr_871E107D55071984D9C07FC790315FD28B7D", var_5);
    var_5.victim = var_2;
    var_5.attacker = var_3;
    level thread monitortaguse(var_5);
  }
}

playersettagcount(var_0) {
  if(!isDefined(self.tagscarried))
    self.tagscarried = 0;

  if(isDefined(level.plunderpickupcallback)) {
    var_1 = var_0 - self.tagscarried;
    [[level.plunderpickupcallback]](var_1);
  }

  self.tagscarried = var_0;
  self.game_extrainfo = var_0;

  if(scripts\mp\utility\game::getgametype() != "_encstr_B1190448CD80") {
    if(scripts\mp\utility\game::getgametype() == "_encstr_A20D05FBEB01F2")
      self setclientomnvar("_encstr_96D4147308480BE0C1048B885BA9808FA56B68C0AF51", var_0);
    else
      self setclientomnvar("_encstr_81730E57C86EEFAB43A08771957BB2A3", var_0);
  }

  var_2 = gettagcode(var_0);

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB" && scripts\mp\utility\game::getgametype() != "_encstr_A20D05FBEB01F2") {
    var_3 = self getentitynumber();

    if(var_3 < 20)
      setomnvar("_encstr_935411AB4B7D32E4EDE01BB7B73AF5D2CD3BAF" + self getentitynumber(), var_2);
  }
}

gettagcode(var_0) {
  if(var_0 == 0)
    return 0;

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

monitorjointeam() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
    playersettagcount(0);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0.isscoring = 0;
    var_0 thread monitorjointeam();
  }
}

monitortaguse(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8BE208E31FA8E1631D65");
  var_0 endon("_encstr_88F20627959BCAE8");
  wait 2.0;

  for(;;) {
    var_0.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      continue;
    }
    if(isagent(var_1) && isDefined(var_1.owner))
      var_1 = var_1.owner;

    playsoundatpos(var_0.curorigin, "_encstr_B6521B4D9B5942F899A0A3B5E68C228ABFA11D7BC773196398A7DBE579");
    var_0.visuals hide();
    var_0.trigger hide();
    var_0.curorigin = (0, 0, -1000);
    var_0.trigger.origin = (0, 0, -1000);
    var_0.visuals.origin = (0, 0, -1000);
    var_0 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    var_2 = level.droploot[var_0.tagtype].points;
    var_1 playersettagcount(var_1.tagscarried + var_2);

    if(isDefined(level.supportcranked) && level.supportcranked) {
      if(isDefined(var_1.cranked) && var_1.cranked)
        var_1 scripts\mp\cranked::setcrankedplayerbombtimer("_encstr_ABD70578F3D02C");
      else
        var_1 scripts\mp\cranked::oncranked(undefined, var_1);
    }

    if(scripts\mp\utility\game::getgametype() == "_encstr_B1190448CD80")
      var_1 _encstr_86361DAFC76BFBD02C8280C06AAFB0277227292323A2BE6258DBD3B057DBD8::_id_13A27();

    break;
  }
}

playercanusetags(var_0) {
  return 1;
}

showtoall(var_0) {
  self hide();

  foreach(var_2 in level.players)
  self showtoplayer(var_2);
}

removetagsongameended() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

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

initlootcaches() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_96110B21404808677FF8974B62", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0.size * 0.5;
  level.lootcaches = [];

  if(1) {
    for(var_2 = 0; var_2 < var_1; var_2++)
      level.lootcaches[level.lootcaches.size] = createlootcache(var_0[var_2].origin, var_0[var_2].angles, -1);
  } else {
    var_3 = var_1 * 0.4;
    var_4 = var_1 * 0.1;
    var_5 = 0;

    for(var_2 = 0; var_2 < var_3; var_2++) {
      level.lootcaches[level.lootcaches.size] = createlootcache(var_0[var_2].origin, var_0[var_2].angles, 1);
      var_5 = var_2;
    }

    for(var_2 = var_5 + 1; var_2 < var_4 + var_3; var_2++) {
      level.lootcaches[level.lootcaches.size] = createlootcache(var_0[var_2].origin, var_0[var_2].angles, 3);
      var_5 = var_2;
    }

    for(var_2 = var_5 + 1; var_2 < var_1; var_2++)
      level.lootcaches[level.lootcaches.size] = createlootcache(var_0[var_2].origin, var_0[var_2].angles, 0);
  }
}

createlootcache(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\killstreaks\airdrop::placeplcrate(var_2, var_0, var_1);
  return var_3;
}

capturelootcachecallback(var_0) {
  var_0 notify("_encstr_862C0D8567AB820DE189F7079098C5", self);
  var_1 = self.data.contents;

  if(var_1 == -1) {
    var_2 = randomint(90);

    if(var_2 <= 20)
      var_1 = 0;
    else if(var_2 <= 60)
      var_1 = 1;
    else if(var_2 <= 70)
      var_1 = 3;
    else if(var_2 <= 80)
      var_1 = 5;
    else
      var_1 = 4;
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

  var_0 playlocalsound("_encstr_A3C80F4AF0E9DFB1709519F44369C36705");
}

gettagcountfromcache(var_0) {
  return var_0 * randomfloatrange(0.8, 1.2);
}

getgunfromcache() {
  var_0 = randomint(level.br_pickups.br_supportedguns.size);
  return level.br_pickups.br_supportedguns[var_0];
}

getitemfromcache() {
  var_0 = randomint(level.br_pickups.br_supporteditems.size);
  return level.br_pickups.br_supporteditems[var_0];
}

getgrenadeammofromcache() {
  return level.esc_lootinfo.grenadeammo;
}

getammofromcache() {
  if(!1) {
    var_0 = randomint(level.esc_lootinfo.ammo.size);
    return level.esc_lootinfo.ammo[var_0];
  }

  return 105;
}

processnotifyweapondrop(var_0, var_1) {
  switch (var_0) {
    case 0:
      var_1 notify("_encstr_B8F71ADF9F2A2B0877F6D8901D3F28C8031753410F2278D86F4BE0C9");
      break;
    case 1:
      var_1 notify("_encstr_91881C1B2CB134B2BED5DCB1BDADDABD377DBBCA0B1C7B377D99B7ABDC32");
      break;
    case 2:
      var_1 notify("_encstr_8CF918707AB6A1D907F237B6FDDF43739ED39880F18FF793EB0C");
      break;
    case 3:
      var_1 notify("_encstr_8F13185F1FAAAB88F7F7BB901E8F6055E2C3CFFD4F22E0C0EE8F");
      break;
    case 4:
      var_1 notify("_encstr_AB381D96FF97D23DB663FFEF5048F48A4D0B110B553B0B4FF8B1FBC73860AC");
      break;
  }
}

banktags(var_0) {
  var_1 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_BD571562489DE4AFB98D5B43A70397260348EBEAD85FD8");
  self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_BD571562489DE4AFB98D5B43A70397260348EBEAD85FD8", var_1 + var_0);
}

resetcacheuseability() {
  foreach(var_1 in level.lootcaches) {
    if(isDefined(var_1.useobj))
      var_1.useobj enableplayeruse(self);
  }
}