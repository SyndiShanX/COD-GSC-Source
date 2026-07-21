/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\dronehive.gsc
***********************************************/

init() {
  level.dronemissilespawnarray = getEntArray("_encstr_B666134EACB5B78E56D44B37CDD2632B351CC277E6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.dronemissilespawnarray)
  var_1.targetent = getEnt(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

weapongivendronehive(var_0) {
  return 1;
}

tryusedronehive(var_0) {
  return usedronehive(self, var_0.lifeid, var_0);
}

usedronehive(var_0, var_1, var_2) {
  if(isDefined(self.underwater) && self.underwater)
    return 0;

  var_3 = var_0 scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_2);

  if(!var_3)
    return 0;

  var_0 scripts\common\utility::allow_weapon_switch(0);
  level thread monitordisownkillstreaks(var_0);
  level thread monitorgameend(var_0);
  level thread monitorobjectivecamera(var_0);
  level thread rundronehive(var_0, var_1, var_2.streakname, var_2);
  return 1;
}

watchhostmigrationstartedinit(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");

    if(isDefined(self)) {
      var_0 thermalvisionon();
      continue;
    }

    var_0 setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 2);
  }
}

watchhostmigrationfinishedinit(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");

    if(isDefined(self)) {
      var_0 setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 1);
      var_0 setclientomnvar("_encstr_82311AEA4BFA8327CA910BD1DE9CD76BA5B9372DD8959B7DB156CCD1", self.missilesleft);
      continue;
    }

    var_0 setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 2);
  }
}

watchclosetogoal(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1);

  while(isDefined(self)) {
    var_2 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), level.characters, var_1);

    if(isDefined(var_2["_encstr_BD260953AA97E3F014279D"]) && distancesquared(self.origin, var_2["_encstr_BD260953AA97E3F014279D"]) < 5000) {
      break;
    }

    waitframe();
  }

  self.streakinfo notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
}

rundronehive(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = "_encstr_979710CD5F90A7BFF583223A49405B5CA0EB";
  var_5 = "_encstr_BE541946E4DEB9B2F5A1A5CEACAF0727BDD4CA8D3AD236B2F5DAC1";
  var_6 = "_encstr_935E169BDD961D6C1AFA318D2C1995BE8D34B46319D76BE0";
  level thread scripts\mp\hud_util::teamplayercardsplash(var_4, var_0);
  var_0 notifyonplayercommand("_encstr_BE64111F8B564EF7581A93DF2A28DFAC01E10C", "_encstr_A9E60828803C73F11780");
  var_0 notifyonplayercommand("_encstr_BE64111F8B564EF7581A93DF2A28DFAC01E10C", "_encstr_85D21AE322E335C047434F596D2BC333A837576EFFD586FE998ACDF7");
  var_7 = getbestmissilespawnpoint(var_0, level.dronemissilespawnarray);
  var_8 = var_7.origin * (1, 1, 0) + (0, 0, level.mapcenter[2] + 10000);
  var_9 = var_7.targetent.origin;
  var_10 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname(var_5), var_8, var_9, var_0);
  var_10 setCanDamage(1);
  var_10 disablemissileboosting();
  var_10 setmissileminimapvisible(1);
  var_10.team = var_0.team;
  var_10.lifeid = var_1;
  var_10.type = "_encstr_A1530723371D084D2A";
  var_10.owner = var_0;
  var_10.entitynumber = var_10 getentitynumber();
  var_10.streakinfo = var_3;
  var_10.weapon_name = "_encstr_BE541946E4DEB9B2F5A1A5CEACAF0727BDD4CA8D3AD236B2F5DAC1";
  level.rockets[var_10.entitynumber] = var_10;
  level.remotemissileinprogress = 1;
  level thread monitordeath(var_10, 1);
  level thread monitorboost(var_10);
  missileeyes(var_0, var_10);
  var_0 setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 1);
  var_10 thread watchhostmigrationstartedinit(var_0);
  var_10 thread watchhostmigrationfinishedinit(var_0);
  var_10 thread scripts\mp\utility\killstreak::watchsupertrophynotify(var_0);
  var_0 scripts\common\utility::_id_13E0A(level._id_11B2A, var_2, var_10.origin);
  var_11 = 0;
  var_10.missilesleft = 2;
  var_12 = 2;
  var_0 setclientomnvar("_encstr_82311AEA4BFA8327CA910BD1DE9CD76BA5B9372DD8959B7DB156CCD1", var_10.missilesleft);

  for(;;) {
    var_13 = var_10 scripts\engine\utility::_id_143AD("_encstr_AD75063D571AE108", "_encstr_BE64111F8B564EF7581A93DF2A28DFAC01E10C");
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(var_13 == "_encstr_AD75063D571AE108") {
      break;
    }

    if(!isDefined(var_10)) {
      break;
    }

    if(istrue(var_10.unlimitedammo)) {
      if(istrue(var_10.lasttimefired)) {
        if(gettime() < var_10.lasttimefired + var_12 * 1000 && var_11 == 0)
          continue;
      }

      level thread firerapidmissiles(var_10, var_11, var_3, var_6);
      var_11++;
      var_10.lasttimefired = gettime();
      var_10.missilesleft = 2 - var_11;
      var_14 = var_10.missilesleft;

      if(var_10.missilesleft == 0)
        var_14 = -1;

      var_0 setclientomnvar("_encstr_82311AEA4BFA8327CA910BD1DE9CD76BA5B9372DD8959B7DB156CCD1", var_14);

      if(var_11 == 2) {
        var_11 = 0;
        var_10.missilesleft = 2;
        var_0 thread resetmissiles(var_10, var_12);
      }

      continue;
    }

    if(var_11 < 2) {
      if(!istrue(var_10.singlefire)) {
        level thread spawnswitchblade(var_10, var_11, var_3, var_6);
        var_11++;
        var_10.missilesleft = 2 - var_11;
        var_0 setclientomnvar("_encstr_82311AEA4BFA8327CA910BD1DE9CD76BA5B9372DD8959B7DB156CCD1", var_10.missilesleft);

        if(var_11 == 2)
          var_10 enablemissileboosting();
      }
    }
  }

  level thread returnplayer(var_0);
  scripts\mp\utility\print::printgameaction("_encstr_8A3B1E57B0706C33E1364F4692716A26D948E302FAA1DCEB3FC057F10B8B13F5", var_0);
}

firerapidmissiles(var_0, var_1, var_2, var_3) {
  var_4 = var_1;

  for(var_5 = 0; var_5 < 2; var_5++) {
    level thread spawnswitchblade(var_0, var_4, var_2, var_3);
    var_4++;

    if(var_4 > 1)
      var_4 = 0;

    wait 0.1;
  }
}

resetmissiles(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait(var_1);
  self setclientomnvar("_encstr_82311AEA4BFA8327CA910BD1DE9CD76BA5B9372DD8959B7DB156CCD1", var_0.missilesleft);
}

monitorlockedtarget() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = [];
  var_1 = [];

  for(;;) {
    var_2 = [];
    var_0 = scripts\mp\utility\killstreak::getenemytargets();

    foreach(var_4 in var_0) {
      var_5 = self.owner worldpointinreticle_circle(var_4.origin, 65, 90);

      if(var_5) {
        self.owner thread scripts\mp\utility\debug::drawline(self.origin, var_4.origin, 10, (0, 0, 1));
        var_2[var_2.size] = var_4;
      }
    }

    if(var_2.size) {
      var_1 = sortbydistance(var_2, self.origin);
      self.lasttargetlocked = var_1[0];
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.25);
    }

    wait 0.05;
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

spawnswitchblade(var_0, var_1, var_2, var_3) {
  var_0.owner playlocalsound("_encstr_A3C80F4AF0E9DFB1709519F44369C36705");
  var_4 = var_0 gettagangles("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = (100, 100, 100);
  var_8 = (15000, 15000, 15000);

  if(var_1)
    var_7 = var_7 * -1;

  var_9 = scripts\engine\trace::_bullet_trace(var_0.origin, var_0.origin + var_5 * var_8, 0, var_0);
  var_8 = var_8 * var_9["_encstr_A53009A25003666B9818C6"];
  var_10 = var_0.origin + var_6 * var_7;
  var_11 = var_0.origin + var_5 * var_8;
  var_12 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname(var_3), var_10, var_11, var_0.owner);
  var_13 = var_0 getclosesttargetinview(var_0.owner, var_11);

  if(isDefined(var_13))
    var_12 missile_settargetEnt(var_13);

  var_12 setCanDamage(1);
  var_12 setmissileminimapvisible(1);
  var_12.team = var_0.team;
  var_12.lifeid = var_0.lifeid;
  var_12.type = var_0.type;
  var_12.owner = var_0.owner;
  var_12.entitynumber = var_12 getentitynumber();
  var_12.streakinfo = var_2;
  var_12.weapon_name = "_encstr_935E169BDD961D6C1AFA318D2C1995BE8D34B46319D76BE0";
  level.rockets[var_12.entitynumber] = var_12;
  level thread monitordeath(var_12, 0);
}

getclosesttargetinview(var_0, var_1) {
  var_2 = scripts\mp\utility\killstreak::getenemytargets(var_0);
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_2) {
    if(!isDefined(var_6) || !scripts\mp\utility\player::isreallyalive(var_6)) {
      continue;
    }
    if(istrue(var_6.trinityrocketlocked)) {
      continue;
    }
    var_7 = distance2dsquared(var_6.origin, var_1);

    if(var_7 < 262144 && istrue(canseetarget(var_6))) {
      if(!isDefined(var_4) || var_7 < var_4) {
        var_3 = var_6;
        var_4 = var_7;
      }
    }
  }

  if(isDefined(var_3)) {
    var_3.trinityrocketlocked = 1;
    var_3 thread watchtarget();
  }

  return var_3;
}

canseetarget(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_3 = [var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_0 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"), var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37")];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var_3[var_4], self, var_2)) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

watchtarget() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AD75063D571AE108");
  self.trinityrocketlocked = undefined;
}

looptriggeredeffect(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    triggerfx(var_0);
    wait 0.25;
  }
}

getnextmissilespawnindex(var_0) {
  var_1 = var_0 + 1;

  if(var_1 == level.dronemissilespawnarray.size)
    var_1 = 0;

  return var_1;
}

monitorboost(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0.owner waittill("_encstr_BE64111F8B564EF7581A93DF2A28DFAC01E10C");
    var_0 notify("_encstr_BE64111F8B564EF7581A93DF2A28DFAC01E10C");
  }
}

getbestmissilespawnpoint(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_4)) {
      continue;
    }
    if(var_4.team == var_0.team) {
      continue;
    }
    if(var_4.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  if(!var_2.size)
    return var_1[randomint(var_1.size)];

  var_6 = scripts\engine\utility::array_randomize(var_1);
  var_7 = var_6[0];

  foreach(var_9 in var_6) {
    var_9.sightedenemies = 0;

    for(var_10 = 0; var_10 < var_2.size; var_10++) {
      var_11 = var_2[var_10];

      if(!scripts\mp\utility\player::isreallyalive(var_11)) {
        var_2[var_10] = var_2[var_2.size - 1];
        var_2[var_2.size - 1] = undefined;
        var_10--;
        continue;
      }

      if(scripts\engine\trace::_bullet_trace_passed(var_11.origin + (0, 0, 32), var_9.origin, 0, var_11)) {
        var_9.sightedenemies = var_9.sightedenemies + 1;
        return var_9;
      }

      wait 0.05;
      scripts\mp\hostmigration::waittillhostmigrationdone();
    }

    if(var_9.sightedenemies == var_2.size)
      return var_9;

    if(var_9.sightedenemies > var_7.sightedenemies)
      var_7 = var_9;
  }

  return var_7;
}

missileeyes(var_0, var_1) {
  var_2 = 0.5;
  var_0 scripts\mp\utility\player::_freezecontrols(1);
  var_0 cameralinkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 controlslinkTo(var_1);
  var_0 thermalvisionon();
  var_0 setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", 1);
  var_0 setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(15000));
  level thread unfreezecontrols(var_0, var_2);
}

unfreezecontrols(var_0, var_1, var_2) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1 - 0.35);
  var_0 scripts\mp\utility\player::_freezecontrols(0);
}

monitordisownkillstreaks(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_B87110FB5E37D19287DA98E6332BD6C88EA3");
  var_0 childthread monitorownerstatus("_encstr_81170C244F9CBDE72C01BB99A298");
  var_0 childthread monitorownerstatus("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
}

monitorownerstatus(var_0) {
  self waittill(var_0);
  level thread returnplayer(self);
}

monitorgameend(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_B87110FB5E37D19287DA98E6332BD6C88EA3");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 1;
  level thread returnplayer(var_0, 0, var_1);
}

monitorobjectivecamera(var_0) {
  var_0 endon("_encstr_B87110FB5E37D19287DA98E6332BD6C88EA3");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_BE2B0E376618C796A1085B62D1E74EBF");
  level thread returnplayer(var_0, 1);
}

monitordeath(var_0, var_1) {
  var_0 waittill("_encstr_AD75063D571AE108");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(isDefined(var_0.targeffect))
    var_0.targeffect delete();

  if(isDefined(var_0.entitynumber))
    level.rockets[var_0.entitynumber] = undefined;

  if(var_1)
    level.remotemissileinprogress = undefined;
}

returnplayer(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!istrue(var_2))
    self.streakinfo notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

  var_0 setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 2);
  var_0 notify("_encstr_B87110FB5E37D19287DA98E6332BD6C88EA3");
  var_0 thermalvisionoff();
  var_0 controlsunlink();
  var_0 cameraunlink();
  var_0 setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 0);
  var_0 scripts\common\utility::allow_weapon_switch(1);
}

watchgastrigger(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    if(level.teambased && var_2.team == var_0.team && var_2 != var_0) {
      continue;
    }
    if(istrue(var_2.gettinggassed)) {
      continue;
    }
    thread applygasdamageovertime(var_0, var_1, var_2);
  }
}

applygasdamageovertime(var_0, var_1, var_2) {
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2.gettinggassed = 1;

  while(var_2 istouching(self)) {
    var_2 dodamage(20, self.origin, var_0, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_1);
    var_3 = scripts\engine\utility::_id_143B9(0.5, "_encstr_AD75063D571AE108");

    if(var_3 == "_encstr_AD75063D571AE108") {
      break;
    }
  }

  if(istrue(var_2.gettinggassed))
    var_2.gettinggassed = undefined;
}