/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\combat_utility.gsc
***********************************************/

gettargetangleoffset(var_0) {
  var_1 = self getshootatpos() + (0, 0, -3);
  var_2 = (var_1[0] - var_0[0], var_1[1] - var_0[1], var_1[2] - var_0[2]);
  var_2 = vectorNormalize(var_2);
  var_3 = var_2[2] * -1;
  return var_3;
}

getremainingburstdelaytime() {
  var_0 = (gettime() - self.a.lastshoottime) / 1000;
  var_1 = getburstdelaytime();

  if(var_1 > var_0)
    return var_1 - var_0;

  return 0;
}

getburstdelaytime() {
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingsidearm())
    return randomfloatrange(0.15, 0.55);
  else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::weapon_pump_action_shotgun())
    return randomfloatrange(1.0, 1.7);
  else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::weapon_genade_launcher())
    return scripts\asm\shared\utility::grenadelauncherfirerate();
  else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper())
    return scripts\asm\shared\utility::getsniperburstdelaytime();
  else if(self.fastburst)
    return randomfloatrange(0.1, 0.35);
  else
    return randomfloatrange(0.2, 0.4);
}

shootuntilshootbehaviorchange() {}

getuniqueflagnameindex() {
  anim.animflagnameindex++;
  return anim.animflagnameindex;
}

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");

setupaim(var_0) {
  self setanim(%_encstr_AD650FC58333F2CBC5387F0BBB83EC8DE7, 1, 0.2);

  if(scripts\engine\utility::actor_is3d())
    self setflaggedanimknoblimited("_encstr_82EB0C85632F07A3486950FE0971", _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::animarray("_encstr_91450FDF83BB13D27CB0EBDF410F8BD379"), 1, var_0);
  else
    self setanimknoblimited(_encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::animarray("_encstr_91450FDF83BB13D27CB0EBDF410F8BD379"), 1, var_0);

  self setanimknoblimited(_encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::animarray("_encstr_8C1E0B1E7581B93178301FBFF0"), 1, var_0);
  self setanimknoblimited(_encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::animarray("_encstr_8D030D581991FA855AB67D19DE7773"), 1, var_0);
  self setanimknoblimited(_encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::animarray("_encstr_A9440D5FA911506610C818523169C5"), 1, var_0);
  self setanimknoblimited(_encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::animarray("_encstr_8B7E0E854632FA585A6B7D4EB4760D1D"), 1, var_0);
  self.facialidx = _encstr_B282169B8DE496C13ACDE52C9BB4B6F29958D8595C3B6E1B::playfacialanim(undefined, "_encstr_8719040B4BB5", self.facialidx);
}

issingleshot() {
  if(weaponburstcount(self.weapon) > 0)
    return 0;
  else if(weaponisauto(self.weapon) || weaponisbeam(self.weapon))
    return 0;

  return 1;
}

shotgunpumpsound(var_0) {
  if(!_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::weapon_pump_action_shotgun()) {
    return;
  }
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  self notify("_encstr_888C17E61ADED13BABB97D07BAB5E0D7CDB7D537237DCA738C");
  self endon("_encstr_888C17E61ADED13BABB97D07BAB5E0D7CDB7D537237DCA738C");
  thread stopshotgunpumpaftertime(2.0);
  self waittillmatch(var_0, "_encstr_B4430A6D6737F9134D1A5373");
  self playSound("_encstr_ADB8101B7F2966A087F319539D4F989DE283");
  self notify("_encstr_888C17E61ADED13BABB97D07BAB5E0D7CDB7D537237DCA738C");
}

stopshotgunpumpaftertime(var_0) {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  self endon("_encstr_888C17E61ADED13BABB97D07BAB5E0D7CDB7D537237DCA738C");
  wait(var_0);
  self notify("_encstr_888C17E61ADED13BABB97D07BAB5E0D7CDB7D537237DCA738C");
}

rechamber(var_0) {}

putgunbackinhandonkillanimscript() {
  self endon("_encstr_8C25132BF1EFA3BD18CF0BF75B30460B1849220259");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(self.primaryweapon, "_encstr_8253060E2B5FE330");
}

reload(var_0, var_1) {}

addgrenadethrowanimoffset(var_0, var_1) {
  if(!isDefined(anim.grenadethrowanims)) {
    anim.grenadethrowanims = [];
    anim.grenadethrowoffsets = [];
  }

  var_2 = anim.grenadethrowanims.size;
  anim.grenadethrowanims[var_2] = var_0;
  anim.grenadethrowoffsets[var_2] = var_1;
}

initgrenadethrowanims() {}

getgrenadethrowoffset(var_0) {
  var_1 = (0, 0, 64);
  return var_1;
}

throwgrenadeatplayerasap_combat_utility() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(level.players[var_0].numgrenadesinprogresstowardsplayer == 0) {
      level.players[var_0].grenadetimers["_encstr_8A78055C8D488C"] = 0;
      level.players[var_0].grenadetimers["_encstr_A7D70E338D169B1ABED9E4B29BB01995"] = 0;
      level.players[var_0].grenadetimers["_encstr_ABBE07B995566D569C"] = 0;
    }
  }

  anim.throwgrenadeatplayerasap = 1;
}

setactivegrenadetimer(var_0) {
  self.activegrenadetimer = spawnStruct();

  if(isPlayer(var_0)) {
    self.activegrenadetimer.isplayertimer = 1;
    self.activegrenadetimer.player = var_0;
    self.activegrenadetimer.timername = self.grenadeweapon.basename;
  } else {
    self.activegrenadetimer.isplayertimer = 0;
    self.activegrenadetimer.timername = "_encstr_85190481CBA0" + self.grenadeweapon.basename;
  }
}

usingplayergrenadetimer() {
  return self.activegrenadetimer.isplayertimer;
}

setgrenadetimer(var_0, var_1) {
  if(var_0.isplayertimer) {
    var_2 = var_0.player;
    var_3 = var_2.grenadetimers[var_0.timername];
    var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
  } else {
    var_3 = anim.grenadetimers[var_0.timername];
    anim.grenadetimers[var_0.timername] = max(var_1, var_3);
  }
}

getdesiredgrenadetimervalue() {
  var_0 = undefined;

  if(usingplayergrenadetimer()) {
    var_1 = self.activegrenadetimer.player;
    var_0 = gettime() + var_1.gs.playergrenadebasetime + randomint(var_1.gs.playergrenaderangetime);
  } else
    var_0 = gettime() + 30000 + randomint(30000);

  return var_0;
}

getgrenadetimertime(var_0) {
  if(var_0.isplayertimer)
    return var_0.player.grenadetimers[var_0.timername];
  else
    return anim.grenadetimers[var_0.timername];
}

maythrowdoublegrenade(var_0) {
  if(scripts\engine\utility::player_died_recently())
    return 0;

  if(!var_0.gs.double_grenades_allowed)
    return 0;

  var_1 = gettime();

  if(var_1 < var_0.grenadetimers["_encstr_A2BE0F32DEBA318D59D7D94EB2E6858CB2"])
    return 0;

  if(var_1 > var_0.lastfraggrenadetoplayerstart + 3000)
    return 0;

  if(var_1 < var_0.lastfraggrenadetoplayerstart + 500)
    return 0;

  return var_0.numgrenadesinprogresstowardsplayer < 2;
}

mygrenadecooldownelapsed() {
  return gettime() >= self.a.nextgrenadetrytime;
}

grenadecooldownelapsed(var_0) {
  if(scripts\engine\utility::player_died_recently())
    return 0;

  if(self.script_forcegrenade == 1)
    return 1;

  if(!mygrenadecooldownelapsed())
    return 0;

  if(gettime() >= getgrenadetimertime(self.activegrenadetimer))
    return 1;

  if(self.activegrenadetimer.isplayertimer && self.activegrenadetimer.timername == "_encstr_95810C99C9C2ECCEC9B2DCC246CA")
    return maythrowdoublegrenade(var_0);

  return 0;
}

trygrenadeposproc(var_0, var_1, var_2, var_3) {
  if(!self isgrenadepossafe(var_0, var_1))
    return 0;
  else if(distancesquared(self.origin, var_1) < 40000)
    return 0;

  var_4 = physicstrace(var_1 + (0, 0, 1), var_1 + (0, 0, -500));

  if(var_4 == var_1 + (0, 0, -500))
    return 0;

  var_4 = var_4 + (0, 0, 0.1);
  return trygrenadethrow(var_0, var_4, var_2, var_3);
}

trygrenadethrow(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {}

reducegiptponkillanimscript(var_0) {
  self endon("_encstr_964A24D9F0609B5F33494F2567C1983FAFF08CEF1F5FA0B858135061B1F8ECA8B2A7E5932BD5");
  self waittill("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  var_0.numgrenadesinprogresstowardsplayer--;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

dogrenadethrow(var_0, var_1, var_2, var_3) {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");

  if(!self.arriving)
    self orientmode("_encstr_812A0F0196B3F8C79A470D3B7743BB6046", var_1);

  _encstr_88C92737B1934B831DDC5E0BE6A5ADCB980B1D1DC6CAB1A12CD1A3AC937DBB9CC2071C59278B3BB9C6::evaluateattackevent(self.grenadeweapon.basename);
  self notify("_encstr_A1EA155813AFB307A2F4112B0DFA3F591C276048BF752A");
  self setflaggedanimknoballrestart("_encstr_86CE0AB888B3BA6FD8F8B175", var_0, %_encstr_AD9B0589ED9197, fasteranimspeed(), 0.1, 1);
  thread _encstr_953E1CDC6CC94B07E89BCB169BD2B65EDC7B3A953A4E168DB56E17CE378D::donotetracksforever("_encstr_86CE0AB888B3BA6FD8F8B175", "_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  var_4 = _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::getgrenademodel();
  var_5 = "_encstr_8BBA05185F8B99";

  for(;;) {
    self waittill("_encstr_86CE0AB888B3BA6FD8F8B175", var_6);

    if(var_6 == "_encstr_A5B70D7956F390C3527D691935230B" || var_6 == "_encstr_A9D00EB327ACB9C2C859AF9396CE0D47") {
      var_5 = attachgrenademodel(var_4, "_encstr_8BC20B34E359B14F487C686005");
      self.isholdinggrenade = 1;
    }

    if(var_6 == "_encstr_97E30EEC9359DC0B19ACBE47D027BDDD" || var_6 == "_encstr_BD630E11DB6FC0F8F78DA131B85AC014") {
      break;
    }

    if(var_6 == "_encstr_961804BD954A") {
      self.activegrenadetimer.player.numgrenadesinprogresstowardsplayer--;
      self notify("_encstr_964A24D9F0609B5F33494F2567C1983FAFF08CEF1F5FA0B858135061B1F8ECA8B2A7E5932BD5");
      return 0;
    }
  }

  self notify("_encstr_964A24D9F0609B5F33494F2567C1983FAFF08CEF1F5FA0B858135061B1F8ECA8B2A7E5932BD5");

  if(usingplayergrenadetimer())
    thread watchgrenadetowardsplayer(self.activegrenadetimer.player, var_2);

  self throwgrenade();

  if(!usingplayergrenadetimer())
    setgrenadetimer(self.activegrenadetimer, var_2);

  if(var_3 && self.activegrenadetimer.isplayertimer) {
    var_13 = self.activegrenadetimer.player;

    if(var_13.numgrenadesinprogresstowardsplayer > 1 || gettime() - var_13.lastgrenadelandednearplayertime < 2000)
      var_13.grenadetimers["_encstr_A2BE0F32DEBA318D59D7D94EB2E6858CB2"] = gettime() + min(5000, var_13.gs.playerdoublegrenadetime);
  }

  self notify("_encstr_82F513C36BE74BF9C1A2C96E40D17F779A436286F8");

  if(var_5 != "_encstr_8BBA05185F8B99")
    self detach(var_4, var_5);
  else {}

  self.isholdinggrenade = undefined;
  self.grenadeawareness = self.oldgrenawareness;
  self.oldgrenawareness = undefined;
  self waittillmatch("_encstr_86CE0AB888B3BA6FD8F8B175", "_encstr_961804BD954A");
  self notify("_encstr_8D5313C29F6307695F85F9B03324CD49438A2ADFF3");
  self notify("_encstr_8C25132BF1EFA3BD18CF0BF75B30460B1849220259");
  self setanim(%_encstr_AFC40F5731874ACB982171C578A8E55350, 1, 0.2);
  self setanim(%_encstr_AD650FC58333F2CBC5387F0BBB83EC8DE7, 1);
  self aiclearanim(var_0, 0.2);
}

watchgrenadetowardsplayer(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  watchgrenadetowardsplayerinternal(var_1);
  var_0.numgrenadesinprogresstowardsplayer--;
}

watchgrenadetowardsplayerinternal(var_0) {
  var_1 = self.activegrenadetimer;
  var_2 = spawnStruct();
  var_2 thread watchgrenadetowardsplayertimeout(5);
  var_2 endon("_encstr_83E021EEC28E8D86E8E4ACE6B0C856A8B7772C93236E41C6C2BC56E42AA5ADACDB571D");
  var_3 = self.grenadeweapon.basename;
  var_4 = getgrenadeithrew();

  if(!isDefined(var_4)) {
    return;
  }
  setgrenadetimer(var_1, min(gettime() + 5000, var_0));
  var_5 = 62500;
  var_6 = 160000;

  if(var_3 == "_encstr_A7D70E338D169B1ABED9E4B29BB01995") {
    var_5 = 810000;
    var_6 = 1690000;
  }

  var_7 = level.players;
  var_8 = var_4.origin;

  for(;;) {
    wait 0.1;

    if(!isDefined(var_4)) {
      break;
    }

    if(distancesquared(var_4.origin, var_8) < 400) {
      var_9 = [];

      for(var_10 = 0; var_10 < var_7.size; var_10++) {
        var_11 = var_7[var_10];
        var_12 = distancesquared(var_4.origin, var_11.origin);

        if(var_12 < var_5) {
          var_11 grenadelandednearplayer(var_1, var_0);
          continue;
        }

        if(var_12 < var_6)
          var_9[var_9.size] = var_11;
      }

      var_7 = var_9;

      if(var_7.size == 0) {
        break;
      }
    }

    var_8 = var_4.origin;
  }
}

grenadelandednearplayer(var_0, var_1) {
  var_2 = self;
  anim.throwgrenadeatplayerasap = undefined;

  if(gettime() - var_2.lastgrenadelandednearplayertime < 3000)
    var_2.grenadetimers["_encstr_A2BE0F32DEBA318D59D7D94EB2E6858CB2"] = gettime() + var_2.gs.playerdoublegrenadetime;

  var_2.lastgrenadelandednearplayertime = gettime();
  var_3 = var_2.grenadetimers[var_0.timername];
  var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
}

getgrenadeithrew() {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_0);
  return var_0;
}

watchgrenadetowardsplayertimeout(var_0) {
  wait(var_0);
  self notify("_encstr_83E021EEC28E8D86E8E4ACE6B0C856A8B7772C93236E41C6C2BC56E42AA5ADACDB571D");
}

attachgrenademodel(var_0, var_1) {
  self attach(var_0, var_1);
  thread detachgrenadeonscriptchange(var_0, var_1);
  return var_1;
}

detachgrenadeonscriptchange(var_0, var_1) {
  self endon("_encstr_82F513C36BE74BF9C1A2C96E40D17F779A436286F8");
  self waittill("_encstr_85140F22139204D9DDF8E3DF36CDE82275");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.oldgrenawareness)) {
    self.grenadeawareness = self.oldgrenawareness;
    self.oldgrenawareness = undefined;
  }

  self detach(var_0, var_1);
}

offsettoorigin(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoup(self.angles);
  var_1 = var_1 * var_0[0];
  var_2 = var_2 * var_0[1];
  var_3 = var_3 * var_0[2];
  return var_1 + var_2 + var_3;
}

grenadeline(var_0, var_1) {
  level notify("_encstr_AC980A29036B48BC81E3E861");
  level endon("_encstr_AC980A29036B48BC81E3E861");
  var_0 = self.origin + offsettoorigin(var_0);

  for(;;)
    wait 0.05;
}

getgrenadedropvelocity() {
  var_0 = randomfloat(360);
  var_1 = randomfloatrange(30, 75);
  var_2 = sin(var_1);
  var_3 = cos(var_1);
  var_4 = cos(var_0) * var_3;
  var_5 = sin(var_0) * var_3;
  var_6 = randomfloatrange(100, 200);
  var_7 = (var_4, var_5, var_2) * var_6;
  return var_7;
}

dropgrenade() {
  if(isDefined(self.nodropgrenade)) {
    return;
  }
  var_0 = self gettagorigin("_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
  var_1 = getgrenadedropvelocity();
  self magicgrenademanual(var_0, var_1, 3);
}

shouldhelpadvancingteammate() {
  if(level.advancetoenemygroup[self.team] > 0 && level.advancetoenemygroup[self.team] < level.advancetoenemygroupmax) {
    if(gettime() - level.lastadvancetoenemytime[self.team] > 4000)
      return 0;

    var_0 = level.lastadvancetoenemyattacker[self.team];

    if(var_0 == self)
      return 0;

    var_1 = isDefined(var_0) && distancesquared(self.origin, var_0.origin) < 65536;

    if((var_1 || distancesquared(self.origin, level.lastadvancetoenemysrc[self.team]) < 65536) && (!isDefined(self.enemy) || distancesquared(self.enemy.origin, level.lastadvancetoenemydest[self.team]) < 262144))
      return 1;
  }

  return 0;
}

checkadvanceonenemyconditions() {
  if(!isDefined(level.lastadvancetoenemytime[self.team]))
    return 0;

  if(shouldhelpadvancingteammate())
    return 1;

  if(gettime() - level.lastadvancetoenemytime[self.team] < level.advancetoenemyinterval)
    return 0;

  if(!issentient(self.enemy))
    return 0;

  if(level.advancetoenemygroup[self.team])
    level.advancetoenemygroup[self.team] = 0;

  var_0 = isDefined(self.advance_regardless_of_numbers) && self.advance_regardless_of_numbers;

  if(!var_0 && getaicount(self.team) < getaicount(self.enemy.team))
    return 0;

  return 1;
}

tryrunningtoenemy(var_0) {
  if(!isDefined(self.enemy))
    return 0;

  if(self.fixednode)
    return 0;

  if(self.combatmode == "_encstr_81240791CBC8C34B18" || self.combatmode == "_encstr_99DD1261DB105BC73BFEFAD2A1858F9920B514F1")
    return 0;

  if(!self isingoal(self.enemy.origin))
    return 0;

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::islongrangeai())
    return 0;

  if(!checkadvanceonenemyconditions())
    return 0;

  if(isDefined(self.usingnavmesh) && self.usingnavmesh)
    return 0;

  self findreacquiredirectpath(var_0);

  if(self reacquiremove()) {
    self.keepclaimednodeifvalid = 0;
    self.keepclaimednode = 0;
    self.a.magicreloadwhenreachenemy = 1;

    if(level.advancetoenemygroup[self.team] == 0) {
      level.lastadvancetoenemytime[self.team] = gettime();
      level.lastadvancetoenemyattacker[self.team] = self;
    }

    level.lastadvancetoenemysrc[self.team] = self.origin;
    level.lastadvancetoenemydest[self.team] = self.enemy.origin;
    level.advancetoenemygroup[self.team]++;
    return 1;
  }

  return 0;
}

getpitchtoshootspot(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = var_0 - self getshootatpos();
  var_1 = vectorNormalize(var_1);
  var_2 = vectortoangles(var_1)[0];
  return angleclamp180(var_2);
}

watchreloading() {
  self.isreloading = 0;
  self.lastreloadstarttime = -1;

  for(;;) {
    self waittill("_encstr_8A730DD6B72A37C984A7486847CA23");
    self.isreloading = 1;
    self.lastreloadstarttime = gettime();
    _encstr_88C92737B1934B831DDC5E0BE6A5ADCB980B1D1DC6CAB1A12CD1A3AC937DBB9CC2071C59278B3BB9C6::evaluatereloadevent();
    waittillreloadfinished();
    self.isreloading = 0;
  }
}

waittillreloadfinished() {
  thread timednotify(4, "_encstr_A9030E85F7A2D060146B5028D7F70895");
  self endon("_encstr_A9030E85F7A2D060146B5028D7F70895");
  self endon("_encstr_88A80D134FDE4B2FA8A7CBBF2B45DD");

  for(;;) {
    self waittill("_encstr_AF4D07932B1BDE5846");
    var_0 = self getcurrentweapon();

    if(nullweapon(var_0)) {
      break;
    }

    if(self getcurrentweaponclipammo() >= weaponclipsize(var_0)) {
      break;
    }
  }

  self notify("_encstr_A9030E85F7A2D060146B5028D7F70895");
}

timednotify(var_0, var_1) {
  self endon(var_1);
  wait(var_0);
  self notify(var_1);
}

checkgrenadethrowdist() {
  var_0 = self.enemy.origin - self.origin;
  var_1 = lengthsquared((var_0[0], var_0[1], 0));

  if(self.grenadeweapon.basename == "_encstr_A7D70E338D169B1ABED9E4B29BB01995")
    return var_1 < 589824;

  return var_1 >= 40000 && var_1 <= 1562500;
}

monitorflash() {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(level.neverstopmonitoringflash))
    self endon("_encstr_ADAD16871485D8F8E7BA8810739726589D9F5715A4EE38BB");

  for(;;) {
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    self waittill("_encstr_ABE70A08F0C68B546D12A8E7", var_1, var_0, var_2, var_3, var_4);

    if(isDefined(self.flashbangimmunity) && self.flashbangimmunity) {
      continue;
    }
    if(isDefined(self.script_immunetoflash) && self.script_immunetoflash != 0) {
      continue;
    }
    if(isDefined(self.team) && isDefined(var_4) && self.team == var_4) {
      var_0 = 3 * (var_0 - 0.75);

      if(var_0 < 0) {
        continue;
      }
      if(isDefined(self.teamflashbangimmunity))
        continue;
    }

    var_5 = 0.2;

    if(var_0 > 1 - var_5)
      var_0 = 1.0;
    else
      var_0 = var_0 / (1 - var_5);

    var_6 = 4.5 * var_0;

    if(var_6 < 0.25) {
      continue;
    }
    self.flashingteam = var_4;
    flashbangstart(var_6);
    self notify("_encstr_91940E3A905C33DE1041DAC17588E75B", var_1, var_3);
  }
}

flashbangstart(var_0) {
  if(isDefined(self.flashbangimmunity) && self.flashbangimmunity) {
    return;
  }
  if(isDefined(self.syncedmeleetarget)) {
    return;
  }
  if(self isinscriptedstate() || scripts\asm\asm_bb::bb_isanimScripted()) {
    return;
  }
  if(!self.allowpain || !self.allowpain_internal) {
    return;
  }
  var_1 = gettime() + var_0 * 1000.0;

  if(isDefined(self.flashendtime))
    self.flashendtime = max(self.flashendtime, var_1);
  else {
    self.flashendtime = var_1;

    if(isDefined(self.asm))
      scripts\asm\asm::asm_setstate("_encstr_92FD185B9001C81F788CD9831B495AE6AC557A4B7728EBD8C262");
  }

  self notify("_encstr_8E400866D8589B1AB2C8");
}

fasteranimspeed() {
  return 1.5;
}

randomfasteranimspeed() {
  return randomfloatrange(1, 1.2);
}

player_sees_my_scope() {
  var_0 = self getEye();

  foreach(var_2 in level.players) {
    if(!self cansee(var_2)) {
      continue;
    }
    var_3 = var_2 getEye();
    var_4 = vectortoangles(var_0 - var_3);
    var_5 = anglesToForward(var_4);
    var_6 = var_2 getplayerangles();
    var_7 = anglesToForward(var_6);
    var_8 = vectordot(var_5, var_7);

    if(var_8 < 0.805) {
      continue;
    }
    if(scripts\engine\utility::cointoss() && var_8 >= 0.996) {
      continue;
    }
    return 1;
  }

  return 0;
}

combat_playfacialanim(var_0, var_1) {
  self.facialidx = _encstr_B282169B8DE496C13ACDE52C9BB4B6F29958D8595C3B6E1B::playfacialanim(var_0, var_1, self.facialidx);
}

#using_animtree("_encstr_B40101");

combat_clearfacialanim() {
  self.facialidx = undefined;
  self aiclearanim(%_encstr_81CC0586952C91, 0.2);
}