/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\remotemissile.gsc
***********************************************/

init() {
  level.missileremotelaunchvert = 14000;
  level.missileremotelaunchhorz = 7000;
  level.missileremotelaunchtargetdist = 1500;
  level.rockets = [];
  level.remotemissile_fx["_encstr_860808CB78E2984063BA"] = loadfx("_encstr_84961F14FC80F62B208AA2FAE5EBD0DBD5875D58F34018512B50F3FD4D77172808");
}

tryusepredatormissile(var_0, var_1) {
  scripts\mp\utility\player::setusingremote("_encstr_8F0E0E93CA5B7B8EB2D6A5DCCD5A1B56");
  var_2 = scripts\mp\killstreaks\killstreaks::initridekillstreak();

  if(var_2 != "_encstr_88E30897BDF1B71F7823") {
    if(var_2 != "_encstr_8D820B49520F0EC02DDE6367EC")
      scripts\mp\utility\player::clearusingremote();

    return 0;
  }

  self setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 1);
  level thread _fire(var_0, self);
  return 1;
}

getbestspawnpoint(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3.validplayers = [];
    var_3.spawnscore = 0;
  }

  foreach(var_6 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_6)) {
      continue;
    }
    if(var_6.team == self.team) {
      continue;
    }
    if(var_6.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    var_7 = 999999999;
    var_8 = undefined;

    foreach(var_3 in var_0) {
      var_3.validplayers[var_3.validplayers.size] = var_6;
      var_10 = distance2d(var_3.targetent.origin, var_6.origin);

      if(var_10 <= var_7) {
        var_7 = var_10;
        var_8 = var_3;
      }
    }

    var_8.spawnscore = var_8.spawnscore + 2;
  }

  var_13 = var_0[0];

  foreach(var_3 in var_0) {
    foreach(var_6 in var_3.validplayers) {
      var_3.spawnscore = var_3.spawnscore + 1;

      if(scripts\engine\trace::_bullet_trace_passed(var_6.origin + (0, 0, 32), var_3.origin, 0, var_6))
        var_3.spawnscore = var_3.spawnscore + 3;

      if(var_3.spawnscore > var_13.spawnscore) {
        var_13 = var_3;
        continue;
      }

      if(var_3.spawnscore == var_13.spawnscore) {
        if(scripts\engine\utility::cointoss())
          var_13 = var_3;
      }
    }
  }

  return var_13;
}

_fire(var_0, var_1) {
  var_2 = getEntArray("_encstr_B666134EACB5B78E56D44B37CDD2632B351CC277E6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.target))
      var_4.targetent = getEnt(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  if(var_2.size > 0)
    var_6 = var_1 getbestspawnpoint(var_2);
  else
    var_6 = undefined;

  if(isDefined(var_6)) {
    var_7 = var_6.origin;
    var_8 = var_6.targetent.origin;
    var_9 = vectorNormalize(var_7 - var_8);
    var_7 = var_9 * 14000 + var_8;
    var_10 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_B6CE1C27B2ADF6A395DA5AE6B95AB156AF83C9ED352B1B1D2DC62BBEB5C1"), var_7, var_8, var_1);
  } else {
    var_11 = (0, 0, level.missileremotelaunchvert);
    var_12 = level.missileremotelaunchhorz;
    var_13 = level.missileremotelaunchtargetdist;
    var_14 = anglesToForward(var_1.angles);
    var_7 = var_1.origin + var_11 + var_14 * var_12 * -1;
    var_8 = var_1.origin + var_14 * var_13;
    var_10 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_B6CE1C27B2ADF6A395DA5AE6B95AB156AF83C9ED352B1B1D2DC62BBEB5C1"), var_7, var_8, var_1);
  }

  if(!isDefined(var_10)) {
    var_1 scripts\mp\utility\player::clearusingremote();
    return;
  }

  var_10.team = var_1.team;
  var_10 thread handledamage();
  var_10.lifeid = var_0;
  var_10.type = "_encstr_A1530723371D084D2A";
  level.remotemissileinprogress = 1;
  missileeyes(var_1, var_10);
}

handledamage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8BE208E31FA8E1631D65");
  self setCanDamage(1);

  for(;;)
    self waittill("_encstr_B2BE0788BAF573592F");
}

missileeyes(var_0, var_1) {
  var_0 endon("_encstr_81170C244F9CBDE72C01BB99A298");
  var_0 endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  var_1 thread rocket_cleanupondeath();
  var_0 thread player_cleanupongameended(var_1);
  var_0 thread player_cleanuponteamchange(var_1);
  var_0 visionsetmissilecamforplayer("_encstr_8A8C09A5D372D6302FEE93", 0);
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_1)) {
    var_0 visionsetmissilecamforplayer(game["_encstr_8E4A0FA5C837EB73F67241705A0A33ED43"], 1.0);
    var_0 thermalvisionon();
    var_0 thread delayedfofoverlay();
    var_0 cameralinkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_0 controlslinkTo(var_1);

    if(getdvarint("_encstr_82570B397A4D3192935192A562"))
      var_0 scripts\mp\utility\player::setthirdpersondof(0);

    var_1 waittill("_encstr_AD75063D571AE108");
    var_0 thermalvisionoff();

    if(isDefined(var_1))
      var_0 scripts\common\utility::_id_13E0A(level._id_11B2A, "_encstr_BD9D11F3DEDA859B83DFD0F6D78020C83BA27F", var_1.origin);

    var_0 controlsunlink();
    var_0 scripts\mp\utility\player::_freezecontrols(1);

    if(!level.gameended)
      var_0 setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 2);

    wait 0.5;
    var_0 cameraunlink();

    if(getdvarint("_encstr_82570B397A4D3192935192A562"))
      var_0 scripts\mp\utility\player::setthirdpersondof(1);
  }

  var_0 setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 0);
  var_0 scripts\mp\utility\player::clearusingremote();
}

delayedfofoverlay() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.15;
}

player_cleanuponteamchange(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");

  if(self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    self controlsunlink();
    self cameraunlink();

    if(getdvarint("_encstr_82570B397A4D3192935192A562"))
      scripts\mp\utility\player::setthirdpersondof(1);
  }

  scripts\mp\utility\player::clearusingremote();
  level.remotemissileinprogress = undefined;
}

rocket_cleanupondeath() {
  var_0 = self getentitynumber();
  level.rockets[var_0] = self;
  self waittill("_encstr_AD75063D571AE108");
  level.rockets[var_0] = undefined;
  level.remotemissileinprogress = undefined;
}

player_cleanupongameended(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self controlsunlink();
  self cameraunlink();

  if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    scripts\mp\utility\player::setthirdpersondof(1);
}