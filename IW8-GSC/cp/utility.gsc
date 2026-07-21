/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\utility.gsc
***********************************************/

_giveweapon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = -1;

  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = undefined;

  if(issameweapon(var_0))
    var_4 = var_0;
  else
    var_4 = asmdevgetallstates(var_0);

  if(var_4 hasattachment("_encstr_AD9C07E0478148252A", 1) || var_4 hasattachment("_encstr_8A1808DA22D9BA27938E", 1) || isDefined(var_2) && var_2 == 1)
    self giveweapon(var_4, var_1, 1, -1, var_3);
  else
    self giveweapon(var_4, var_1, 0, -1, var_3);

  thread updatelaststandpistol(var_4);
  return var_4;
}

setplayerstunned() {
  if(!isDefined(self.isstunned))
    self.isstunned = 1;
  else
    self.isstunned++;
}

waittillphysicsmodelstops() {
  wait 0.5;

  for(;;) {
    var_0 = self physics_getbodyid(0);
    var_1 = physics_getbodylinvel(var_0);

    if(lengthsquared(var_1) > 0.5) {
      wait 0.1;
      continue;
    }

    break;
  }

  self physicsstopserver();
}

setplayerunstunned() {
  self.isstunned--;
}

setupdamagetriggers(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");

  wait 1;
  var_1 = getEnt("_encstr_96210E62494313E9C1F00FDFA0FBA5DA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_AF9A141E176B162161EBF2D929223A93E0774CF7355D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = isDefined(var_1);
  var_4 = getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");
  var_5 = getDvar("_encstr_ADE50BEB2F7C519F9918E82B68");
  var_0.last_good_pos = undefined;
  var_0.outofbounds = 1;
  var_6 = undefined;

  if(var_5 == "_encstr_B2660A666F36C7FB7B29F797")
    var_7 = "_encstr_8495107270A3C5CBB878172D8343EF4CD788";
  else
    var_7 = "_encstr_A5700AC1FF0B18C95A662920";

  for(;;) {
    var_8 = 0;

    if(var_3)
      var_8 = var_0 istouching(var_1);
    else
      var_8 = !var_0 istouching(var_2);

    var_9 = var_0 isonground();
    var_10 = var_0 isonladder();
    var_11 = scripts\cp\cp_laststand::player_in_laststand(var_0);

    if(!var_9 || var_11 || var_10) {
      wait 0.5;
      continue;
    }

    if(var_8) {
      var_0.last_good_pos = var_0.origin;
      var_6 = undefined;

      if(var_0.outofbounds)
        var_0 thread hint_prompt(var_7, 0);

      var_0.outofbounds = 0;
    } else if(!var_0.outofbounds) {
      var_0 thread hint_prompt(var_7, 1);
      var_0.outofbounds = 1;
      var_6 = gettime() + 5000;
    } else if(isDefined(var_6) && gettime() > var_6) {
      if(isDefined(var_0.hostagecarried) && isDefined(level.hostage) && isDefined(level.hostage_drop))
        level.hostage[[level.hostage_drop]](var_0, level.hostage, var_0.last_good_pos, 0, 0.4);

      var_0 dodamage(var_0.health + 1000, var_0.origin, var_1, var_1, "_encstr_BDB50C41D83F8F9F030B60E80F5B");
      var_0 thread hint_prompt(var_7, 0);
      var_0 thread warp_to_last_good_pos();
    }

    wait 0.5;
  }
}

warp_to_last_good_pos() {
  self setOrigin(self.last_good_pos);
}

updatelaststandpistol(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(level.last_stand_weapons)) {
      var_1 = getweaponbasename(var_0);

      if(scripts\engine\utility::array_contains(level.last_stand_weapons, var_1)) {
        self.last_stand_pistol = var_0;
        return;
      }
    }
  }

  var_2 = self getweaponslistall();
  var_3 = 0;

  if(isDefined(self.last_stand_pistol)) {
    var_4 = getweaponbasename(self.last_stand_pistol);

    foreach(var_6 in var_2) {
      var_7 = getweaponbasename(var_6);

      if(var_7 == var_4) {
        var_3 = 1;
        return;
      }
    }
  }

  if(!var_3) {
    if(isDefined(level.last_stand_weapons)) {
      foreach(var_6 in var_2) {
        var_7 = getweaponbasename(var_6);

        for(var_10 = level.last_stand_weapons.size - 1; var_10 > -1; var_10--) {
          if(var_7 == level.last_stand_weapons[var_10]) {
            var_3 = 1;
            self.last_stand_pistol = var_6;
            return;
          }
        }
      }
    }

    var_12 = getrawbaseweaponname(self.default_starting_pistol);

    if(isDefined(self.weapon_build_models) && isDefined(self.weapon_build_models[var_12]))
      self.last_stand_pistol = asmdevgetallstates(self.weapon_build_models[var_12]);
    else
      self.last_stand_pistol = self.default_starting_pistol;
  }
}

giveperk(var_0) {
  if(issubstr(var_0, "_encstr_B82F1206A2EA7F98D11BA350EFFFD1B3638D7098")) {
    _setperk(var_0);
    return;
  }

  _setperk(var_0);
  _setextraperks(var_0);
}

_hasperk(var_0) {
  var_1 = self.perks;

  if(!isDefined(var_1))
    return 0;

  if(isDefined(var_1[var_0]))
    return 1;

  return 0;
}

takeperk(var_0) {
  if(issubstr(var_0, "_encstr_B82F1206A2EA7F98D11BA350EFFFD1B3638D7098")) {
    _unsetperk(var_0);
    return;
  }

  _unsetperk(var_0);
  _unsetextraperks(var_0);
}

_setperk(var_0) {
  self.perks[var_0] = 1;
  self.perksperkname[var_0] = var_0;
  var_1 = level.perksetfuncs[var_0];

  if(isDefined(var_1))
    self thread[[var_1]]();

  self setperk(var_0, !isDefined(level.scriptperks[var_0]));
}

_setextraperks(var_0) {
  if(isDefined(level.extraperkmap[var_0])) {
    foreach(var_2 in level.extraperkmap[var_0]) {
      _setperk(var_2);
      _setextraperks(var_2);
    }
  }
}

_unsetperk(var_0) {
  self.perks[var_0] = undefined;
  self.perksperkname[var_0] = undefined;

  if(isDefined(level.perkunsetfuncs[var_0]))
    self thread[[level.perkunsetfuncs[var_0]]]();

  self unsetperk(var_0, !isDefined(level.scriptperks[var_0]));
}

_unsetextraperks(var_0) {
  if(isDefined(level.extraperkmap[var_0])) {
    foreach(var_2 in level.extraperkmap[var_0]) {
      _unsetperk(var_2);
      _unsetextraperks(var_2);
    }
  }
}

_clearperks() {
  foreach(var_2, var_1 in self.perks) {
    if(isDefined(level.perkunsetfuncs[var_2]))
      self[[level.perkunsetfuncs[var_2]]]();
  }

  self.perks = [];
  self.perksperkname = [];
  self clearperks();
}

clearlowermessages() {
  if(isDefined(self.lowermessages)) {
    for(var_0 = 0; var_0 < self.lowermessages.size; var_0++)
      self.lowermessages[var_0] = undefined;
  }

  if(!isDefined(self.lowermessage)) {
    return;
  }
  updatelowermessage();
}

setlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_5))
    var_5 = 0;

  if(!isDefined(var_6))
    var_6 = 0.85;

  if(!isDefined(var_7))
    var_7 = 3.0;

  if(!isDefined(var_8))
    var_8 = 0;

  if(!isDefined(var_9))
    var_9 = 1;

  addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  updatelowermessage();
}

play_bink_video(var_0, var_1, var_2) {
  level thread play_bink_video_internal(var_0, var_1, var_2);
}

play_bink_video_internal(var_0, var_1, var_2) {
  foreach(var_4 in level.players)
  var_4 freezecontrolswrapper(1);

  playcinematicforall(var_0);
  wait(var_1);

  foreach(var_4 in level.players) {
    var_4 freezecontrolswrapper(0);

    if(!isDefined(var_2) || !var_2)
      var_4 thread player_black_screen(0, 1, 0.5, 1);
  }
}

updatelowermessage() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self)) {
    return;
  }
  var_0 = getlowermessage();

  if(!isDefined(var_0)) {
    if(isDefined(self.lowermessage)) {
      self.lowermessage.alpha = 0;
      self.lowermessage settext("_encstr_B40101");

      if(isDefined(self.lowertimer))
        self.lowertimer.alpha = 0;
    }
  } else {
    self.lowermessage settext(var_0.text);
    self.lowermessage.alpha = 0.85;
    self.lowertimer.alpha = 1;
    self.lowermessage.hidewhenindemo = var_0.hidewhenindemo;
    self.lowermessage.hidewheninmenu = var_0.hidewheninmenu;

    if(var_0.shouldfade) {
      self.lowermessage fadeovertime(min(var_0.fadetoalphatime, 60));
      self.lowermessage.alpha = var_0.fadetoalpha;
    }

    if(var_0.time > 0 && var_0.showtimer)
      self.lowertimer settimer(max(var_0.time - (gettime() - var_0.addtime) / 1000, 0.1));
    else {
      if(var_0.time > 0 && !var_0.showtimer) {
        self.lowertimer settext("_encstr_B40101");
        self.lowermessage fadeovertime(min(var_0.time, 60));
        self.lowermessage.alpha = 0;
        thread clearondeath(var_0);
        thread clearafterfade(var_0);
        return;
      }

      self.lowertimer settext("_encstr_B40101");
    }
  }
}

addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = undefined;

  foreach(var_12 in self.lowermessages) {
    if(var_12.name == var_0) {
      if(var_12.text == var_1 && var_12.priority == var_3) {
        return;
      }
      var_10 = var_12;
      break;
    }
  }

  if(!isDefined(var_10)) {
    var_10 = spawnStruct();
    self.lowermessages[self.lowermessages.size] = var_10;
  }

  var_10.name = var_0;
  var_10.text = var_1;
  var_10.time = var_2;
  var_10.addtime = gettime();
  var_10.priority = var_3;
  var_10.showtimer = var_4;
  var_10.shouldfade = var_5;
  var_10.fadetoalpha = var_6;
  var_10.fadetoalphatime = var_7;
  var_10.hidewhenindemo = var_8;
  var_10.hidewheninmenu = var_9;
  sortlowermessages();
}

sortlowermessages() {
  for(var_0 = 1; var_0 < self.lowermessages.size; var_0++) {
    var_1 = self.lowermessages[var_0];
    var_2 = var_1.priority;

    for(var_3 = var_0 - 1; var_3 >= 0 && var_2 > self.lowermessages[var_3].priority; var_3--)
      self.lowermessages[var_3 + 1] = self.lowermessages[var_3];

    self.lowermessages[var_3 + 1] = var_1;
  }
}

getlowermessage() {
  if(!isDefined(self.lowermessages))
    return undefined;

  return self.lowermessages[0];
}

clearondeath(var_0) {
  self notify("_encstr_8ED910FFE29707B35FBF36A063BA9FBDF8CF");
  self endon("_encstr_8ED910FFE29707B35FBF36A063BA9FBDF8CF");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  clearlowermessage(var_0.name);
}

clearafterfade(var_0) {
  wait(var_0.time);
  clearlowermessage(var_0.name);
  self notify("_encstr_8ED910FFE29707B35FBF36A063BA9FBDF8CF");
}

clearlowermessage(var_0) {
  removelowermessage(var_0);
  updatelowermessage();
}

removelowermessage(var_0) {
  if(isDefined(self.lowermessages)) {
    for(var_1 = self.lowermessages.size; var_1 > 0; var_1--) {
      if(self.lowermessages[var_1 - 1].name != var_0) {
        continue;
      }
      var_2 = self.lowermessages[var_1 - 1];

      for(var_3 = var_1; var_3 < self.lowermessages.size; var_3++) {
        if(isDefined(self.lowermessages[var_3]))
          self.lowermessages[var_3 - 1] = self.lowermessages[var_3];
      }

      self.lowermessages[self.lowermessages.size - 1] = undefined;
    }

    sortlowermessages();
  }
}

freezecontrolswrapper(var_0) {
  if(isDefined(level.hostmigrationtimer)) {
    self.hostmigrationcontrolsfrozen = 1;
    self freezecontrols(1);
    return;
  }

  self freezecontrols(var_0);
  self.controlsfrozen = var_0;
}

setthirdpersondof(var_0) {
  if(var_0)
    self setdepthoffield(0, 110, 512, 4096, 6, 1.8);
  else
    self setdepthoffield(0, 0, 512, 512, 4, 0);
}

setusingremote(var_0) {
  if(isDefined(self.carryicon))
    self.carryicon.alpha = 0;

  self.usingremote = var_0;

  if(scripts\common\utility::is_offhand_weapons_allowed())
    scripts\common\utility::allow_offhand_weapons(0);

  self notify("_encstr_86070DEB73A488448FCB4970221B0D");
  self setclientomnvar("_encstr_85DD1BD3A8285F52D845C7F767F0DD636663DB5A319A3FCA405BF7C403", 1);
  self notify("_encstr_86070DEB73A488448FCB4970221B0D");
}

isusingremote() {
  return isDefined(self.usingremote);
}

updatesessionstate(var_0, var_1) {
  self.sessionstate = var_0;

  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";

  self.statusicon = var_1;
  self setclientomnvar("_encstr_8BCB112DF3390A3B3A66FB3F820F10911F73FD", var_0);
}

getuniqueid() {
  if(isDefined(self.pers["_encstr_917205E4A0C380"]))
    return self.pers["_encstr_917205E4A0C380"];

  var_0 = self getguid();

  if(var_0 == "_encstr_81FB113061820ACA17131F272B2F8242DA0948") {
    if(isDefined(level.guidgen))
      level.guidgen++;
    else
      level.guidgen = 1;

    var_0 = "_encstr_AC29077FFB0AD8B75B" + level.guidgen;
  }

  self.pers["_encstr_917205E4A0C380"] = var_0;
  return self.pers["_encstr_917205E4A0C380"];
}

gameflagset(var_0) {
  game["_encstr_B2A9066FF1CB8F67"][var_0] = 1;
  level notify(var_0);
}

gameflaginit(var_0, var_1) {
  game["_encstr_B2A9066FF1CB8F67"][var_0] = var_1;
}

gameflag(var_0) {
  return game["_encstr_B2A9066FF1CB8F67"][var_0];
}

gameflagwait(var_0) {
  while(!gameflag(var_0))
    level waittill(var_0);
}

matchmakinggame() {
  return level.onlinegame && !getdvarint("_encstr_93390B136AA2628AA8A93529D4");
}

inovertime() {
  return isDefined(game["_encstr_A16D07532531CB4BF7"]) && game["_encstr_A16D07532531CB4BF7"] == "_encstr_8B6D0940CC35339149DA08";
}

initlevelflags() {
  if(!isDefined(level.levelflags))
    level.levelflags = [];
}

initgameflags() {
  if(!isDefined(game["_encstr_B2A9066FF1CB8F67"]))
    game["_encstr_B2A9066FF1CB8F67"] = [];
}

isenemy(var_0) {
  if(level.teambased)
    return isplayeronenemyteam(var_0);
  else
    return isplayerffaenemy(var_0);
}

isplayeronenemyteam(var_0) {
  return var_0.team != self.team;
}

isplayerffaenemy(var_0) {
  if(isDefined(var_0.owner))
    return var_0.owner != self;
  else
    return var_0 != self;
}

isgameplayteam(var_0) {
  return isDefined(var_0) && scripts\engine\utility::array_contains(level.teamnamelist, var_0);
}

notusableforjoiningplayers(var_0) {
  self notify("_encstr_A12D1810DF14F3BF42D6718DACDAF3D86143D0587BD98A5B5BBA");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A12D1810DF14F3BF42D6718DACDAF3D86143D0587BD98A5B5BBA");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_1);

    if(isDefined(var_1) && var_1 != var_0)
      self disableplayeruse(var_1);
  }
}

setselfusable(var_0) {
  self makeusable();

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self disableplayeruse(var_2);
      continue;
    }

    self enableplayeruse(var_2);
  }
}

isenvironmentweapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(issameweapon(var_0)) {
    if(var_0.basename == "_encstr_A91012E8AE39395947AFB54BB9A5CE57B9EB6BE0")
      return 1;
    else
      return 0;
  }

  if(var_0 == "_encstr_A91012E8AE39395947AFB54BB9A5CE57B9EB6BE0")
    return 1;

  return 0;
}

issuperweapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = createheadicon(var_0);
  else
    var_1 = var_0;

  if(isDefined(level.superweapons) && isDefined(level.superweapons[var_1]))
    return 1;

  return 0;
}

strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size)
    return var_0;

  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1)
    return getsubstr(var_0, 0, var_0.size - var_1.size);

  return var_0;
}

playteamfxforclient(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(self.team != var_0)
    var_6 = spawnfxforclient(scripts\engine\utility::getfx(var_3), var_1, self);
  else
    var_6 = spawnfxforclient(scripts\engine\utility::getfx(var_2), var_1, self);

  if(isDefined(var_6))
    triggerfx(var_6);

  var_6 thread delayentdelete(var_4);

  if(isDefined(var_5) && var_5)
    var_6 thread deleteonplayerdeathdisconnect(self);

  return var_6;
}

toggle_team_emp_effects(var_0, var_1, var_2, var_3) {
  var_4 = [];

  foreach(var_6 in level.players) {
    if(!var_6 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(var_6.team != var_0) {
      continue;
    }
    var_4[var_4.size] = var_6;
  }

  if(istrue(var_1)) {
    foreach(var_6 in var_4)
    thread toggle_player_emp_effects(var_6, 1, var_2);
  } else {
    foreach(var_6 in var_4)
    thread toggle_player_emp_effects(var_6, 0);
  }
}

toggle_player_emp_effects(var_0, var_1, var_2) {
  if(istrue(var_1)) {
    var_3 = getcompleteweaponname("_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB");
    var_4 = scripts\cp_mp\utility\damage_utility::packdamagedata;
    var_5 = [[var_4]](var_0, var_0, 1, var_3);
    var_0 thread _emp_grenade_apply_player(var_5, var_2);
  } else
    var_0 notify("_encstr_99C40CA749E1F16B80389FEB2BB9");
}

_emp_grenade_apply_player(var_0, var_1) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  _emp_grenade_end_early(var_0, var_1);

  if(isDefined(var_0.victim))
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();
}

_emp_grenade_end_early(var_0, var_1) {
  var_0.victim endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_1))
    var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_99C40CA749E1F16B80389FEB2BB9", var_1);
  else
    self waittill("_encstr_99C40CA749E1F16B80389FEB2BB9");
}

delayentdelete(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);

  if(isDefined(self))
    self delete();
}

deleteonplayerdeathdisconnect(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
  self delete();
}

isstrstart(var_0, var_1) {
  return getsubstr(var_0, 0, var_1.size) == var_1;
}

getbaseweaponname(var_0) {
  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  var_2 = strtok(var_1, "_encstr_BA4C02DF");
  var_3 = 0;

  if(var_2[0] == "_encstr_B419040BB1A3")
    var_3++;

  if(var_2[var_3] == "_encstr_921904C3C7E2")
    var_1 = var_2[var_3] + "_encstr_BA4C02DF" + var_2[var_3 + 1];
  else if(var_2[var_3] == "_encstr_B21904D2EE0E" || var_2[var_3] == "_encstr_BD0703AF7C") {
    var_4 = ["_encstr_AD07034A38", "_encstr_990703B843", "_encstr_AA07038DB6", "_encstr_A30703C763", "_encstr_A10703BB40", "_encstr_9707038CB6", "_encstr_A607036B40", "_encstr_8707037C7F"];

    if(scripts\engine\utility::array_contains(var_4, var_2[var_3 + 1]))
      var_1 = var_2[var_3] + "_encstr_BA4C02DF" + var_2[var_3 + 1] + "_encstr_BA4C02DF" + var_2[var_3 + 2];
    else
      var_1 = var_2[var_3] + "_encstr_BA4C02DF" + var_2[var_3 + 1];
  }

  return var_1;
}

getzbaseweaponname(var_0, var_1) {
  var_2 = strtok(var_0, "_encstr_BA4C02DF");

  if(var_2[0] == "_encstr_BD1904D15712" || var_2[0] == "_encstr_BE19045AEED8" || var_2[0] == "_encstr_921904C3C7E2") {
    if(isDefined(var_1) && var_1 > 1)
      var_0 = var_2[0] + "_encstr_970703EB3D" + var_2[1] + var_1;
    else
      var_0 = var_2[0] + "_encstr_970703EB3D" + var_2[1];
  } else if(var_2[0] == "_encstr_B419040BB1A3") {
    if(isDefined(var_1) && var_1 > 1)
      var_0 = var_2[1] + "_encstr_970703EB3D" + var_2[2] + var_1;
    else
      var_0 = var_2[1] + "_encstr_970703EB3D" + var_2[2];
  }

  return var_0;
}

get_closest_entrance(var_0) {
  if(!isDefined(level.window_entrances))
    return undefined;

  var_1 = sortbydistance(level.window_entrances, var_0);

  foreach(var_3 in var_1) {
    if(var_3.enabled)
      return var_3;
  }

  return undefined;
}

entrance_is_fully_repaired(var_0) {
  if(!isDefined(var_0.barrier))
    return 1;

  var_1 = [[level.next_board_to_repair_func]](var_0);

  if(!isDefined(var_1))
    return 1;

  return 0;
}

is_weapon_purchase_disabled() {
  return istrue(level.weapon_purchase_disabled);
}

get_attachment_from_interaction(var_0) {
  var_1 = var_0.item.model;
  var_2 = "_encstr_AB020801B25B20016BD7";
  var_3 = "_encstr_B4870A7F59154AF7A830CD55";

  switch (var_1) {
    case "_encstr_92D6255BEC8B983E2B52D1B82B1F6A20A66FE3F563B6A875CF4A2B22F38BAD107AA97F43379B48":
      var_2 = "_encstr_9AC20C0B27C68573CAF5890B6E56";
      break;
    default:
      break;
  }

  return var_2;
}

are_any_consumables_active() {
  foreach(var_2, var_1 in self.consumables) {
    if(var_1.on == 1)
      return 1;
  }

  return 0;
}

getrawbaseweaponname(var_0) {
  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  var_2 = strtok(var_1, "_encstr_BA4C02DF");

  if(var_2[0] == "_encstr_BD1904D15712" || var_2[0] == "_encstr_BE19045AEED8" || var_2[0] == "_encstr_921904C3C7E2")
    var_1 = var_2[1];
  else if(var_2[0] == "_encstr_B419040BB1A3")
    var_1 = var_2[2];

  return var_1;
}

getintproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarint(var_0, var_1);
  return var_2;
}

leaderdialogonplayer(var_0, var_1, var_2, var_3) {
  if(!isDefined(game["_encstr_B2DA070A5F8BAB87AF"][var_0])) {
    return;
  }
  var_4 = self.pers["_encstr_8AEF05472BC2D6"];

  if(isDefined(var_4) && (var_4 == "_encstr_8E8405EA382B2A" || var_4 == "_encstr_9A8507BA4040188D08")) {
    var_5 = game["_encstr_8F8206ACFA5A81B5"][var_4] + game["_encstr_B2DA070A5F8BAB87AF"][var_0];
    self queuedialogforplayer(var_5, var_0, 2, var_1, var_2, var_3);
  }
}

_setactionslot(var_0, var_1, var_2) {
  self.saved_actionslotdata[var_0].type = var_1;
  self.saved_actionslotdata[var_0].item = var_2;
  self setactionslot(var_0, var_1, var_2);
}

getkillstreakweapon(var_0) {
  return tablelookup(level.global_tables["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"].path, level.global_tables["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"].ref_col, var_0, level.global_tables["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"].weapon_col);
}

_objective_delete(var_0) {
  objective_delete(var_0);

  if(!isDefined(level.reclaimedreservedobjectives)) {
    level.reclaimedreservedobjectives = [];
    level.reclaimedreservedobjectives[0] = var_0;
  } else
    level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size] = var_0;
}

touchingbadtrigger(var_0) {
  var_1 = getEntArray("_encstr_85FE0DD5727A27098513298817CA23", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_3 in var_1) {
    if(self istouching(var_3) && (level.mapname != "_encstr_B60B087A8BB9ED2A6835" || var_3.dmg > 0))
      return 1;
  }

  var_5 = getEntArray("_encstr_BD3E0A4EC2325A85E82DEDB9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_5) {
    if(self istouching(var_3))
      return 1;
  }

  if(isDefined(var_0) && var_0 == "_encstr_83EA08AFD5932B4058D0") {
    var_8 = getEntArray("_encstr_9A2E0D927013C27B38F88CA5072303", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_3 in var_8) {
      if(self istouching(var_3))
        return 1;
    }
  }

  return 0;
}

playsoundinspace(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(isarray(var_0))
      var_0 = scripts\engine\utility::random(var_0);

    var_3 = lookupsoundlength(var_0);
    playsoundatpos(var_1, var_0);

    if(isDefined(var_2))
      wait(var_3 / 1000);

    return var_3;
  }
}

play_random_sound_in_space(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(!isarray(var_0)) {
      var_3 = [];
      var_3[0] = var_0;
      var_0 = var_3[0];
    }

    var_4 = scripts\engine\utility::random(var_0);
    var_5 = lookupsoundlength(var_4);
    playsoundatpos(var_1, var_4);

    if(isDefined(var_2))
      wait(var_5);

    return var_5;
  }
}

play_looping_sound_on_ent(var_0) {
  if(soundexists(var_0))
    self playLoopSound(var_0);
}

stop_looping_sound_on_ent(var_0) {
  if(soundexists(var_0))
    self stoploopsound(var_0);
}

playdeathsound() {
  var_0 = randomintrange(1, 8);
  var_1 = "_encstr_979608DF73C8E70B73A1";

  if(self hasfemalecustomizationmodel())
    var_1 = "_encstr_B82907C2887BC62B39";

  if(self.team == "_encstr_8E8405EA382B2A") {
    var_2 = var_1 + "_encstr_A52710BECD2D4E23C04133D38A6678DA8B91" + var_0;

    if(soundexists(var_2))
      self playSound(var_2);
  } else {
    var_2 = var_1 + "_encstr_A50311FA46CA0BD1A1FA2CD62BC95A8DB0DCFA" + var_0;

    if(soundexists(var_2))
      self playSound(var_2);
  }
}

isfmjdamage(var_0, var_1, var_2) {
  return isDefined(var_2) && var_2 _hasperk("_encstr_872D180B63F7EE100E3CA1B36776B0A1B7DBE3F09A7316D8E50F") && isDefined(var_1) && scripts\engine\utility::isbulletdamage(var_1);
}

ischangingweapon() {
  return isDefined(self.changingweapon);
}

getattachmenttype(var_0) {
  if(!isDefined(var_0))
    return "_encstr_8BBA05185F8B99";

  var_1 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_0, 2);

  if(!isDefined(var_1) || isDefined(var_1) && var_1 == "_encstr_B40101") {
    var_2 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

    if(var_2 == "_encstr_BACB074025B01AAA28")
      var_1 = tablelookup("_encstr_8814261F1070E26A7B96F4EF0697738F40E8AF8FD1112423BB3EBCE5652D4B7C69703337B2897B4B", 4, var_0, 2);
  }

  return var_1;
}

weaponhasattachment(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "_encstr_8BBA05185F8B99" || var_0 == "_encstr_B40101")
    return 0;

  var_2 = getweaponattachmentsbasenames(var_0);

  foreach(var_4 in var_2) {
    if(var_4 == var_1)
      return 1;
  }

  return 0;
}

getweaponattachmentsbasenames(var_0) {
  var_1 = getweaponattachments(var_0);

  foreach(var_4, var_3 in var_1)
  var_1[var_4] = attachmentmap_tobase(var_3);

  return var_1;
}

attachmentmap_tobase(var_0) {
  if(isDefined(level.attachmentmap_uniquetobase[var_0]))
    var_0 = level.attachmentmap_uniquetobase[var_0];

  return var_0;
}

useeventtimestamp(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "_encstr_AB1A088A2B783257C116") || var_0 == "_encstr_B27A1082F9336B55771306F0584283B87187";
}

useeventtype(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "_encstr_AD3E09B95A632BDC6CCA27");
}

tv_station_fastrope_two_infil_rider_start_targetname(var_0) {
  return var_0 == "_encstr_BEE308C2D9C177A398E1" || var_0 == "_encstr_B699078DC2C637D63B" || var_0 == "_encstr_AFBD0CD88536DC6BCE91E4575BDC";
}

isjuggernaut() {
  if(isDefined(self.unittype) && self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")
    return 1;

  if(isDefined(self.isjuggernaut) && self.isjuggernaut == 1)
    return 1;

  if(isDefined(self.isjuggernautdef) && self.isjuggernautdef == 1)
    return 1;

  if(isDefined(self.isjuggernautgl) && self.isjuggernautgl == 1)
    return 1;

  if(isDefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1)
    return 1;

  if(isDefined(self.isjuggernautmaniac) && self.isjuggernautmaniac == 1)
    return 1;

  if(isDefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom == 1)
    return 1;

  return 0;
}

attachmentmap_tounique(var_0, var_1) {
  var_2 = undefined;

  if(issameweapon(var_1))
    var_2 = createheadicon(var_1);
  else
    var_2 = var_1;

  var_3 = getweaponrootname(var_1);

  if(var_3 != var_2) {
    var_4 = getweaponbasename(var_1);

    if(isDefined(level.attachmentmap_basetounique[var_4]) && isDefined(level.attachmentmap_uniquetobase[var_0]) && isDefined(level.attachmentmap_basetounique[var_4][level.attachmentmap_uniquetobase[var_0]])) {
      var_5 = level.attachmentmap_uniquetobase[var_0];
      return level.attachmentmap_basetounique[var_4][var_5];
    } else if(isDefined(level.attachmentmap_basetounique[var_4]) && isDefined(level.attachmentmap_basetounique[var_4][var_0]))
      return level.attachmentmap_basetounique[var_4][var_0];
    else {
      var_6 = strtok(var_4, "_encstr_BA4C02DF");

      if(var_6.size > 3) {
        var_7 = var_6[0] + "_encstr_BA4C02DF" + var_6[1] + "_encstr_BA4C02DF" + var_6[2];

        if(isDefined(level.attachmentmap_basetounique[var_7]) && isDefined(level.attachmentmap_basetounique[var_7][var_0]))
          return level.attachmentmap_basetounique[var_7][var_0];
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_3]) && isDefined(level.attachmentmap_basetounique[var_3][var_0]))
    return level.attachmentmap_basetounique[var_3][var_0];
  else {
    var_8 = weapongroupmap(var_3);

    if(isDefined(level.attachmentmap_basetounique[var_8]) && isDefined(level.attachmentmap_basetounique[var_8][var_0]))
      return level.attachmentmap_basetounique[var_8][var_0];
  }

  return var_0;
}

weapongroupmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].group))
    return level.weaponmapdata[var_0].group;

  return undefined;
}

weaponnumbermap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].number))
    return level.weaponmapdata[var_0].number;

  return undefined;
}

allowridekillstreakplayerexit(var_0, var_1) {
  if(isDefined(var_0))
    self endon(var_0);

  if(isDefined(var_1))
    var_2 = self;
  else {
    if(!isDefined(self.owner)) {
      return;
    }
    var_2 = self.owner;
  }

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 endon("_encstr_920E0BE7880931BA61B86733C0");
  var_2 notify("_encstr_9B5F0F14F6EB6FA8FF4F08A0FF1D62B313");
  var_2 endon("_encstr_AA5610F9DC803089F759B390BA98CAD38389");
  self endon("_encstr_AD75063D571AE108");
  thread allow_force_player_exit();

  if(!isDefined(level.framedurationseconds))
    level.framedurationseconds = level.frameduration / 1000;

  var_3 = level.framedurationseconds;
  var_4 = 0.75;
  var_5 = 1;

  for(;;) {
    var_6 = 0;

    if(var_5 == 1) {
      var_2 setclientomnvar("_encstr_AF5311AE4BF5ACF0D2D1FA0727F6B327ACCD9B", 0);
      var_5 = 0;
    }

    while(var_2 useButtonPressed()) {
      var_6 = var_6 + var_3;
      var_5 = 1;
      var_2 setclientomnvar("_encstr_AF5311AE4BF5ACF0D2D1FA0727F6B327ACCD9B", var_6 / var_4);

      if(var_6 > var_4) {
        self notify("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
        return;
      }

      wait(var_3);
    }

    wait(var_3);
  }
}

allow_force_player_exit() {
  self endon("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  level waittill("_encstr_B49D197ED2390528B23798510FF18D59437B6EF56E92AF51907718");
  self notify("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
}

killstreak_createobjective(var_0, var_1, var_2, var_3, var_4) {
  var_5 = nonobjective_requestobjectiveid(1);
  objective_position(var_5, self.origin);
  objective_icon(var_5, var_0);
  objective_state(var_5, "_encstr_930B07BB1B6B3854FF");
  objective_setbackground(var_5, 1);

  if(!isDefined(self getlinkedparent()) && !istrue(var_3))
    update_objective_position(var_5, self.origin);
  else if(istrue(var_3) && istrue(var_4))
    update_objective_onentitywithrotation(var_5, self);
  else
    update_objective_onentity(var_5, self);

  if(isDefined(var_1)) {
    objective_setownerteam(var_5, var_1);

    if(!level.teambased && isDefined(self.owner)) {
      if(istrue(var_2))
        scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var_5, self.owner);
      else
        scripts\mp\objidpoolmanager::objective_teammask_single(var_5, var_1);
    }
  } else
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_5);

  return var_5;
}

vo_ten_remain(var_0, var_1, var_2) {
  var_3 = nonobjective_requestobjectiveid(1);

  if(var_3 == -1)
    return -1;

  objective_delete(var_3);
  objective_state(var_3, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_position(var_3, (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !istrue(var_1))
    update_objective_position(var_3, self.origin);
  else if(istrue(var_1) && istrue(var_2))
    update_objective_onentitywithrotation(var_3, self);
  else
    update_objective_onentity(var_3, self);

  objective_state(var_3, "_encstr_930B07BB1B6B3854FF");
  objective_icon(var_3, var_0);
  objective_setbackground(var_3, 1);
  objective_setownerteam(var_3, self.team);
  scripts\cp\cp_objectives::minimap_objective_playermask_hidefromall(var_3);
  return var_3;
}

update_objective_position(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_position(var_0, var_1);
}

update_objective_onentity(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_onentity(var_0, var_1);
}

update_objective_onentitywithrotation(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_onentity(var_0, var_1);
  objective_setrotateonminimap(var_0, 1);
}

nonobjective_returnobjectiveid(var_0) {
  scripts\cp\cp_objectives::freeworldidbyobjid(var_0);
}

nonobjective_requestobjectiveid(var_0) {
  return scripts\cp\cp_objectives::requestworldid("_encstr_B44D0E36872885EB5286A26ACB3A0F3A", 1);
}

clearusingremote(var_0) {
  scripts\common\utility::allow_vehicle_use(1);
  scripts\common\utility::allow_crate_use(1);
  scripts\common\utility::allow_ads(1);

  if(isDefined(self.carryicon))
    self.carryicon.alpha = 1;

  self.usingremote = undefined;

  if(!isDefined(var_0)) {
    scripts\common\utility::allow_offhand_weapons(1);
    _freezecontrols(0);
  }

  self setclientomnvar("_encstr_85DD1BD3A8285F52D845C7F767F0DD636663DB5A319A3FCA405BF7C403", 0);
  self notify("_encstr_A5D2156EE8DEE0C15646F5EACD96E6D9FA9359B5DED1CA");
}

cp_add_dialogue_line(var_0) {
  if(getdvarint("_encstr_B42B0D7B2520389FE10D2818521073", 0)) {
    return;
  }
  if(istrue(level.livescount)) {
    return;
  }
  if(!isDefined(level.dialogue_huds))
    level.dialogue_huds = [];

  if(level.dialogue_huds.size == 5) {
    var_1 = level.dialogue_huds[0];
    level.dialogue_huds = scripts\engine\utility::array_remove_index(level.dialogue_huds, 0);
    scripts\engine\utility::update_dialogue_huds();
    var_1 thread scripts\engine\utility::destroy_dialogue_hud();
  }

  if(soundexists("_encstr_A3E01D07B0691003CF7A0950C3F745387B3483874C4F18584B92461B2A837D")) {
    foreach(var_3 in level.players)
    var_3 playlocalsound("_encstr_A3E01D07B0691003CF7A0950C3F745387B3483874C4F18584B92461B2A837D");
  }

  var_5 = "_encstr_A60703890B";
  var_6 = 1;

  if(isDefined(level.dialoguelinescale))
    var_6 = level.dialoguelinescale;

  var_7 = newhudelem();
  var_7.elemtype = "_encstr_9779056EEA2583";
  var_7.font = "_encstr_8B1608EC43B8D647A113";
  var_7.fontscale = var_6;
  var_7.x = 0;
  var_7.y = 0;
  var_7.width = 0;
  var_7.height = int(level.fontheight * var_6);
  var_7.xoffset = 0;
  var_7.yoffset = 0;
  var_8 = level.dialogue_huds.size;
  level.dialogue_huds[var_8] = var_7;
  var_7.foreground = 1;
  var_7.sort = 20;
  var_7.x = 40;
  var_7.y = 260 + var_8 * (12 * var_6);
  var_7.label = var_0;
  var_7.alpha = 0;
  var_7 fadeovertime(0.2);
  var_7.alpha = 1;
  var_7 endon("_encstr_AD75063D571AE108");
  wait 8;
  level.dialogue_huds = scripts\engine\utility::array_remove(level.dialogue_huds, var_7);
  scripts\engine\utility::update_dialogue_huds();
  var_7 thread cp_destroy_dialogue_hud();
}

cp_destroy_dialogue_hud() {
  var_0 = 1;

  if(isDefined(level.dialoguelinescale))
    var_0 = level.dialoguelinescale;

  self endon("_encstr_AD75063D571AE108");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y = self.y - 12 * var_0;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

getfirstprimaryweapon() {
  var_0 = self getweaponslistprimaries();
  return var_0[0];
}

set_visionset_for_watching_players(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_players_watching(var_4, var_5);

  foreach(var_8 in var_6) {
    var_8 notify("_encstr_A6D61C1B3458B9EC4BB9ECFADD5847360DA5373BEBEC96DC5ADE7337CA1D");

    if(isDefined(var_3) && var_3)
      var_8 visionsetmissilecamforplayer(var_0, var_1);
    else
      var_8 visionsetnakedforplayer(var_0, var_1);

    if(var_0 != "_encstr_B40101" && isDefined(var_2)) {
      var_8 thread reset_visionset_on_team_change(self, var_1 + var_2);
      var_8 thread reset_visionset_on_disconnect(self);

      if(var_8 isinkillcam())
        var_8 thread reset_visionset_on_spawn();
    }
  }
}

get_players_watching(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = self getentitynumber();
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 == self) {
      continue;
    }
    var_6 = 0;

    if(!var_1) {
      if(var_5.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_5.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
        var_7 = var_5 getspectatingplayer();

        if(isDefined(var_7) && var_7 == self)
          var_6 = 1;
      }

      if(var_5.forcespectatorclient == var_2)
        var_6 = 1;
    }

    if(!var_0) {
      if(var_5.killcamentity == var_2)
        var_6 = 1;
    }

    if(var_6)
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

reset_visionset_on_team_change(var_0, var_1) {
  self endon("_encstr_A6D61C1B3458B9EC4BB9ECFADD5847360DA5373BEBEC96DC5ADE7337CA1D");
  var_2 = gettime();
  var_3 = self.team;

  while(gettime() - var_2 < var_1 * 1000) {
    if(self.team != var_3 || !scripts\engine\utility::array_contains(var_0 get_players_watching(), self)) {
      self visionsetnakedforplayer("_encstr_B40101", 0.0);
      self notify("_encstr_932313AE040AC5F979B338012B81B303322D1E259B");
      break;
    }

    wait 0.05;
  }
}

reset_visionset_on_disconnect(var_0) {
  self endon("_encstr_A6D61C1B3458B9EC4BB9ECFADD5847360DA5373BEBEC96DC5ADE7337CA1D");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.vision_set_override))
    self visionsetnakedforplayer(level.vision_set_override, 0.0);
  else
    self visionsetnakedforplayer("_encstr_B40101", 0.0);
}

reset_visionset_on_spawn() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_BA350853C128FB939DB9");

  if(isDefined(level.vision_set_override))
    self visionsetnakedforplayer(level.vision_set_override, 0.0);
  else
    self visionsetnakedforplayer("_encstr_B40101", 0.0);
}

isinkillcam() {
  return self.spectatekillcam;
}

createfontstring(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !var_2)
    var_3 = newclienthudelem(self);
  else
    var_3 = newhudelem();

  var_3.elemtype = "_encstr_9779056EEA2583";
  var_3.font = var_0;
  var_3.fontscale = var_1;
  var_3.basefontscale = var_1;
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = 0;
  var_3.height = int(level.fontheight * var_1);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 setparent(level.uiparent);
  var_3.hidden = 0;
  return var_3;
}

setparent(var_0) {
  if(isDefined(self.parent) && self.parent == var_0) {
    return;
  }
  if(isDefined(self.parent))
    self.parent removechild(self);

  self.parent = var_0;
  self.parent addchild(self);

  if(isDefined(self.point))
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
  else
    setpoint("_encstr_AF9F08DB601069806D49");
}

removechild(var_0) {
  var_0.parent = undefined;

  if(self.children[self.children.size - 1] != var_0) {
    self.children[var_0.index] = self.children[self.children.size - 1];
    self.children[var_0.index].index = var_0.index;
  }

  self.children[self.children.size - 1] = undefined;
  var_0.index = undefined;
}

addchild(var_0) {
  var_0.index = self.children.size;
  self.children[self.children.size] = var_0;
  removedestroyedchildren();
}

removedestroyedchildren() {
  if(isDefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }
  self.childchecktime = gettime();
  var_0 = [];

  foreach(var_3, var_2 in self.children) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2.index = var_0.size;
    var_0[var_0.size] = var_2;
  }

  self.children = var_0;
}

setpoint(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = 0;

  var_5 = getparent();

  if(var_4)
    self moveovertime(var_4);

  if(!isDefined(var_2))
    var_2 = 0;

  self.xoffset = var_2;

  if(!isDefined(var_3))
    var_3 = 0;

  self.yoffset = var_3;
  self.point = var_0;
  self.alignx = "_encstr_A5C407E1658D3339B3";
  self.aligny = "_encstr_8F8D07BB035BDAD5CD";

  if(issubstr(var_0, "_encstr_AC190439DF9A"))
    self.aligny = "_encstr_AC190479FF92";

  if(issubstr(var_0, "_encstr_A146079E6DF9115CFD"))
    self.aligny = "_encstr_A146078E65FB5158DD";

  if(issubstr(var_0, "_encstr_A5AD0568058CE3"))
    self.alignx = "_encstr_A5AD056A019C63";

  if(issubstr(var_0, "_encstr_8253061E6BDF6331"))
    self.alignx = "_encstr_8253060E2B5FE330";

  if(!isDefined(var_1))
    var_1 = var_0;

  self.relativepoint = var_1;
  var_6 = "_encstr_BAC512BEE718EBC723A9C16A94030203300209C7";
  var_7 = "_encstr_8F8D07BB035BDAD5CD";

  if(issubstr(var_1, "_encstr_AC190439DF9A"))
    var_7 = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";

  if(issubstr(var_1, "_encstr_A146079E6DF9115CFD"))
    var_7 = "_encstr_BD6B122E4FF3ABF775C13060EA0B87E3FFEAA115";

  if(issubstr(var_1, "_encstr_A5AD0568058CE3"))
    var_6 = "_encstr_AD16101BCA66A37DB0194D579B470B261BB2";

  if(issubstr(var_1, "_encstr_8253061E6BDF6331"))
    var_6 = "_encstr_85B111AA1808586B88E38BBBE346B389C840E7";

  if(var_5 == level.uiparent) {
    self.horzalign = var_6;
    self.vertalign = var_7;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(strip_suffix(var_6, "_encstr_9A9D0C77C92FEDB3E6BD8A42CB7A") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_6 == "_encstr_A5C407E1658D3339B3" || var_5.alignx == "_encstr_A5C407E1658D3339B3") {
    var_8 = int(var_5.width / 2);

    if(var_6 == "_encstr_AD16101BCA66A37DB0194D579B470B261BB2" || var_5.alignx == "_encstr_8253060E2B5FE330")
      var_9 = -1;
    else
      var_9 = 1;
  } else {
    var_8 = var_5.width;

    if(var_6 == "_encstr_AD16101BCA66A37DB0194D579B470B261BB2")
      var_9 = -1;
    else
      var_9 = 1;
  }

  self.x = var_5.x + var_8 * var_9;

  if(strip_suffix(var_7, "_encstr_9A9D0C77C92FEDB3E6BD8A42CB7A") == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_7 == "_encstr_8F8D07BB035BDAD5CD" || var_5.aligny == "_encstr_8F8D07BB035BDAD5CD") {
    var_10 = int(var_5.height / 2);

    if(var_7 == "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8" || var_5.aligny == "_encstr_A146078E65FB5158DD")
      var_11 = -1;
    else
      var_11 = 1;
  } else {
    var_10 = var_5.height;

    if(var_7 == "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8")
      var_11 = -1;
    else
      var_11 = 1;
  }

  self.y = var_5.y + var_10 * var_11;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;

  switch (self.elemtype) {
    case "_encstr_B61904310B39":
      setpointbar(var_0, var_1, var_2, var_3);
      break;
  }

  updatechildren();
}

getparent() {
  return self.parent;
}

setpointbar(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "_encstr_A5AD056A019C63";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "_encstr_A5AD056A019C63")
    self.bar.x = self.x;
  else if(self.alignx == "_encstr_8253060E2B5FE330")
    self.bar.x = self.x - self.width;
  else
    self.bar.x = self.x - int(self.width / 2);

  if(self.aligny == "_encstr_AC190479FF92")
    self.bar.y = self.y;
  else if(self.aligny == "_encstr_A146078E65FB5158DD")
    self.bar.y = self.y;

  updatebar(self.bar.frac);
}

updatebar(var_0, var_1) {
  if(self.elemtype == "_encstr_B61904310B39")
    updatebarscale(var_0, var_1);
}

updatebarscale(var_0, var_1) {
  var_2 = int(self.width * var_0 + 0.5);

  if(!var_2)
    var_2 = 1;

  self.bar.frac = var_0;
  self.bar setshader(self.bar.shader, var_2, self.height);

  if(isDefined(var_1) && var_2 < self.width) {
    if(var_1 > 0)
      self.bar scaleovertime((1 - var_0) / var_1, self.width, self.height);
    else if(var_1 < 0)
      self.bar scaleovertime(var_0 / (-1 * var_1), 1, self.height);
  }

  self.bar.rateofchange = var_1;
  self.bar.lastupdatetime = gettime();
}

updatechildren() {
  for(var_0 = 0; var_0 < self.children.size; var_0++) {
    var_1 = self.children[var_0];
    var_1 setpoint(var_1.point, var_1.relativepoint, var_1.xoffset, var_1.yoffset);
  }
}

createicon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_4 = newclienthudelem(self);
  else
    var_4 = newhudelem();

  var_4.elemtype = "_encstr_A3C505966CBDE6";
  var_4.x = 0;
  var_4.y = 0;
  var_4.width = var_1;
  var_4.height = var_2;
  var_4.basewidth = var_4.width;
  var_4.baseheight = var_4.height;
  var_4.xoffset = 0;
  var_4.yoffset = 0;
  var_4.children = [];
  var_4 setparent(level.uiparent);
  var_4.hidden = 0;

  if(isDefined(var_0)) {
    var_4 setshader(var_0, var_1, var_2);
    var_4.shader = var_0;
  }

  return var_4;
}

destroyelem() {
  var_0 = [];

  for(var_1 = 0; var_1 < self.children.size; var_1++) {
    if(isDefined(self.children[var_1]))
      var_0[var_0.size] = self.children[var_1];
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] setparent(getparent());

  if(self.elemtype == "_encstr_B61904310B39" || self.elemtype == "_encstr_AB280BE2CF3307AAA160220AC0")
    self.bar destroy();

  self destroy();
}

showelem() {
  if(!self.hidden) {
    return;
  }
  self.hidden = 0;

  if(self.elemtype == "_encstr_B61904310B39" || self.elemtype == "_encstr_AB280BE2CF3307AAA160220AC0") {
    if(self.alpha != 0.5)
      self.alpha = 0.5;

    self.bar.hidden = 0;

    if(self.bar.alpha != 1)
      self.bar.alpha = 1;
  } else if(self.alpha != 1)
    self.alpha = 1;
}

hideelem() {
  if(self.hidden) {
    return;
  }
  self.hidden = 1;

  if(self.alpha != 0)
    self.alpha = 0;

  if(self.elemtype == "_encstr_B61904310B39" || self.elemtype == "_encstr_AB280BE2CF3307AAA160220AC0") {
    self.bar.hidden = 1;

    if(self.bar.alpha != 0)
      self.bar.alpha = 0;
  }
}

createprimaryprogressbartext(var_0, var_1, var_2, var_3) {
  if(isagent(self))
    return undefined;

  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = -25;

  if(self issplitscreenplayer())
    var_1 = var_1 + 20;

  var_4 = level.primaryprogressbarfontsize;
  var_5 = "_encstr_8B1608EC43B8D647A113";

  if(isDefined(var_2))
    var_4 = var_2;

  if(isDefined(var_3))
    var_5 = var_3;

  var_6 = createfontstring(var_5, var_4);
  var_6 setpoint("_encstr_A5C407E57585313DB1", undefined, level.primaryprogressbartextx + var_0, level.primaryprogressbartexty + var_1);
  var_6.sort = -1;
  return var_6;
}

createprimaryprogressbar(var_0, var_1, var_2, var_3) {
  if(isagent(self))
    return undefined;

  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = -25;

  if(self issplitscreenplayer())
    var_1 = var_1 + 20;

  if(!isDefined(var_2))
    var_2 = level.primaryprogressbarwidth;

  if(!isDefined(var_3))
    var_3 = level.primaryprogressbarheight;

  var_4 = createbar((1, 1, 1), var_2, var_3);
  var_4 setpoint("_encstr_A5C407E57585313DB1", undefined, level.primaryprogressbarx + var_0, level.primaryprogressbary + var_1);
  return var_4;
}

createbar(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.frac = 0;
  var_4.color = var_0;
  var_4.sort = -2;
  var_4.shader = "_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120";
  var_4 setshader("_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120", var_1, var_2);
  var_4.hidden = 0;

  if(isDefined(var_3))
    var_4.flashfrac = var_3;

  var_5 = newclienthudelem(self);
  var_5.elemtype = "_encstr_B61904310B39";
  var_5.width = var_1;
  var_5.height = var_2;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.bar = var_4;
  var_5.children = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  var_5 setparent(level.uiparent);
  var_5 setshader("_encstr_929210CB2BA86FFEB853E3571327CBC1164F", var_1 + 4, var_2 + 4);
  var_5.hidden = 0;
  return var_5;
}

isgameparticipant(var_0) {
  if(isaigameparticipant(var_0))
    return 1;

  if(isPlayer(var_0))
    return 1;

  return 0;
}

isaigameparticipant(var_0) {
  if(isagent(var_0) && isDefined(var_0.agent_gameparticipant) && var_0.agent_gameparticipant == 1)
    return 1;

  if(isbot(var_0))
    return 1;

  return 0;
}

setteamheadicon(var_0, var_1) {
  if(!level.teambased) {
    return;
  }
  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "_encstr_8BBA05185F8B99";
    self.entityheadicon = undefined;
  }

  var_2 = game["_encstr_ABF711ACB9A3B4E8CBF5A1950BC896C6DEB9EB" + var_0];
  self.entityheadiconteam = var_0;

  if(isDefined(var_1))
    self.entityheadiconoffset = var_1;
  else
    self.entityheadiconoffset = (0, 0, 0);

  self notify("_encstr_8B6B1C22BCB920915F2A25C3EB779721ADF185E7494850D0C379AA82E758");

  if(var_0 == "_encstr_8BBA05185F8B99") {
    if(isDefined(self.entityheadicon))
      self.entityheadicon destroy();

    return;
  }

  var_3 = newteamhudelem(var_0);
  var_3.archived = 1;
  var_3.x = self.origin[0] + self.entityheadiconoffset[0];
  var_3.y = self.origin[1] + self.entityheadiconoffset[1];
  var_3.z = self.origin[2] + self.entityheadiconoffset[2];
  var_3.alpha = 0.8;
  var_3 setshader(var_2, 10, 10);
  var_3 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_3;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

setplayerheadicon(var_0, var_1) {
  if(level.teambased) {
    return;
  }
  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "_encstr_8BBA05185F8B99";
    self.entityheadicon = undefined;
  }

  self notify("_encstr_8B6B1C22BCB920915F2A25C3EB779721ADF185E7494850D0C379AA82E758");

  if(!isDefined(var_0)) {
    if(isDefined(self.entityheadicon))
      self.entityheadicon destroy();

    return;
  }

  var_2 = var_0.team;
  self.entityheadiconteam = var_2;

  if(isDefined(var_1))
    self.entityheadiconoffset = var_1;
  else
    self.entityheadiconoffset = (0, 0, 0);

  var_3 = game["_encstr_ABF711ACB9A3B4E8CBF5A1950BC896C6DEB9EB" + var_2];
  var_4 = newclienthudelem(var_0);
  var_4.archived = 1;
  var_4.x = self.origin[0] + self.entityheadiconoffset[0];
  var_4.y = self.origin[1] + self.entityheadiconoffset[1];
  var_4.z = self.origin[2] + self.entityheadiconoffset[2];
  var_4.alpha = 0.8;
  var_4 setshader(var_3, 10, 10);
  var_4 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_4;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

keepiconpositioned() {
  self.entityheadicon linkwaypointtotargetwithoffset(self, self.entityheadiconoffset);
}

destroyheadiconsondeath() {
  self endon("_encstr_8B6B1C22BCB920915F2A25C3EB779721ADF185E7494850D0C379AA82E758");
  self waittill("_encstr_AD75063D571AE108");

  if(!isDefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}

setheadicon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isgameparticipant(var_0) && !isPlayer(var_0)) {
    return;
  }
  if(!isDefined(self.entityheadicons))
    self.entityheadicons = [];

  if(!isDefined(var_5))
    var_5 = 1;

  if(!isDefined(var_6))
    var_6 = 0.05;

  if(!isDefined(var_7))
    var_7 = 1;

  if(!isDefined(var_8))
    var_8 = 1;

  if(!isDefined(var_9))
    var_9 = 0;

  if(!isDefined(var_10))
    var_10 = 1;

  if(!isPlayer(var_0) && var_0 == "_encstr_8BBA05185F8B99") {
    foreach(var_13, var_12 in self.entityheadicons) {
      if(isDefined(var_12))
        var_12 destroy();

      self.entityheadicons[var_13] = undefined;
    }
  } else {
    if(isPlayer(var_0)) {
      if(isDefined(self.entityheadicons[var_0.guid])) {
        self.entityheadicons[var_0.guid] destroy();
        self.entityheadicons[var_0.guid] = undefined;
      }

      if(var_1 == "_encstr_B40101") {
        return;
      }
      if(isDefined(var_0.team)) {
        if(isDefined(self.entityheadicons[var_0.team])) {
          self.entityheadicons[var_0.team] destroy();
          self.entityheadicons[var_0.team] = undefined;
        }
      }

      var_12 = newclienthudelem(var_0);
      self.entityheadicons[var_0.guid] = var_12;
    } else {
      if(isDefined(self.entityheadicons[var_0])) {
        self.entityheadicons[var_0] destroy();
        self.entityheadicons[var_0] = undefined;
      }

      if(var_1 == "_encstr_B40101") {
        return;
      }
      foreach(var_13, var_15 in self.entityheadicons) {
        if(var_13 == "_encstr_8E8405EA382B2A" || var_13 == "_encstr_9A8507BA4040188D08") {
          continue;
        }
        var_16 = getplayerforguid(var_13);

        if(var_16.team == var_0) {
          self.entityheadicons[var_13] destroy();
          self.entityheadicons[var_13] = undefined;
        }
      }

      var_12 = newteamhudelem(var_0);
      self.entityheadicons[var_0] = var_12;
    }

    if(!isDefined(var_3) || !isDefined(var_4)) {
      var_3 = 10;
      var_4 = 10;
    }

    var_12.archived = var_5;
    var_12.x = self.origin[0] + var_2[0];
    var_12.y = self.origin[1] + var_2[1];
    var_12.z = self.origin[2] + var_2[2];
    var_12.alpha = 0.85;
    var_12 setshader(var_1, var_3, var_4);
    var_12 setwaypoint(var_7, var_8, var_9, var_10);
    var_12 thread keeppositioned(self, var_2, var_6);
    thread destroyiconsondeath();

    if(isPlayer(var_0))
      var_12 thread destroyonownerdisconnect(var_0);

    if(isPlayer(self))
      var_12 thread destroyonownerdisconnect(self);
  }
}

showheadicon(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2.alpha = 0.85;
  }
}

hideheadicon(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2.alpha = 0;
  }
}

getplayerforguid(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.guid == var_0)
      return var_2;
  }

  return undefined;
}

getpotentiallivingplayers() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

getplayersinradius(var_0, var_1, var_2, var_3) {
  var_4 = ["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"];
  return getentitiesinradius(var_0, var_1, var_2, var_3, physics_createcontents(var_4));
}

getactorsinradius(var_0, var_1, var_2, var_3) {
  var_4 = ["_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763"];
  return getentitiesinradius(var_0, var_1, var_2, var_3, physics_createcontents(var_4));
}

getentitiesinradius(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 <= 0)
    return [];

  var_5 = undefined;

  if(isDefined(var_3)) {
    if(isarray(var_3))
      var_5 = var_3;
    else
      var_5 = [var_3];
  }

  var_6 = physics_querypoint(var_0, var_1, var_4, var_5, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");
  var_7 = [];

  if(!isDefined(var_2)) {
    foreach(var_9 in var_6) {
      var_10 = var_9["_encstr_850E077B0BF30318B9"];
      var_7[var_7.size] = var_10;
    }
  } else {
    foreach(var_9 in var_6) {
      var_10 = var_9["_encstr_850E077B0BF30318B9"];

      if(isDefined(var_10.team) && var_10.team == var_2)
        var_7[var_7.size] = var_10;
    }
  }

  return var_7;
}

keeppositioned(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 = isDefined(var_0.classname) && !isownercarepakage(var_0);

  if(var_3)
    self linkwaypointtotargetwithoffset(var_0, var_1);

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }
    if(!var_3) {
      var_4 = var_0.origin;
      self.x = var_4[0] + var_1[0];
      self.y = var_4[1] + var_1[1];
      self.z = var_4[2] + var_1[2];
    }

    if(var_2 > 0.05) {
      self.alpha = 0.85;
      self fadeovertime(var_2);
      self.alpha = 0;
    }

    wait(var_2);
  }
}

isownercarepakage(var_0) {
  return isDefined(var_0.targetname) && var_0.targetname == "_encstr_BAE50DE60E739BA638C72068AF47B9";
}

destroyiconsondeath() {
  self notify("_encstr_888B14C859E6D1937BE52536B7B9E6D3B92295B0A3A1");
  self endon("_encstr_888B14C859E6D1937BE52536B7B9E6D3B92295B0A3A1");
  self waittill("_encstr_AD75063D571AE108");

  if(!isDefined(self.entityheadicons)) {
    return;
  }
  foreach(var_2, var_1 in self.entityheadicons) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1 destroy();
  }
}

destroyonownerdisconnect(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  self destroy();
}

_suicide() {
  if(!isusingremote() && !isDefined(self.fauxdead))
    self suicide();
}

player_lua_progressbar(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = lua_progress_bar_think(var_0, var_1, var_2, var_3, var_4, var_5);
  return var_6;
}

lua_progress_bar_think(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 1;
  self.usetime = var_1;
  var_0 thread create_lua_progress_bar(self, var_3);
  var_0.hasprogressbar = 1;
  var_6 = lua_progress_bar_think_loop(var_0, self, var_2, var_4, var_5);

  if(isalive(var_0))
    var_0.hasprogressbar = 0;

  if(!isDefined(self))
    return 0;

  self.inuse = 0;
  self.curprogress = 0;
  return var_6;
}

create_lua_progress_bar(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", var_1);
  var_2 = -1;

  while(scripts\cp_mp\utility\player_utility::_isalive() && isDefined(var_0) && var_0.inuse && !level.gameended) {
    if(var_2 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime)
        var_0.curprogress = var_0.usetime;
    }

    var_2 = var_0.userate;
    self setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_0.curprogress / var_0.usetime);
    wait 0.05;
  }

  wait 0.5;
  self setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
}

lua_progress_bar_think_loop(var_0, var_1, var_2, var_3, var_4) {
  while(!level.gameended && isDefined(self) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && (var_0 useButtonPressed() || isDefined(var_3) || var_0 attackButtonPressed() && isDefined(var_4)) && should_continue_progress_bar_think(var_0)) {
    wait 0.05;

    if(isDefined(var_1) && isDefined(var_2)) {
      if(distancesquared(var_0.origin, var_1.origin) > var_2)
        return 0;
    }

    self.curprogress = self.curprogress + 50 * self.userate;
    self.userate = 1;

    if(self.curprogress >= self.usetime) {
      var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 1);
      return var_0 scripts\cp_mp\utility\player_utility::_isalive();
    }
  }

  return 0;
}

should_continue_progress_bar_think(var_0) {
  if(isDefined(level.should_continue_progress_bar_think))
    return [[level.should_continue_progress_bar_think]](var_0);
  else
    return !scripts\cp\cp_laststand::player_in_laststand(var_0);
}

isplayingsolo() {
  if(getmaxclients() == 1)
    return 1;

  return 0;
}

removefromparticipantsarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.participants.size; var_1++) {
    if(level.participants[var_1] == self) {
      for(var_0 = 1; var_1 < level.participants.size - 1; var_1++)
        level.participants[var_1] = level.participants[var_1 + 1];

      level.participants[var_1] = undefined;
      break;
    }
  }
}

removefromcharactersarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.characters.size; var_1++) {
    if(level.characters[var_1] == self) {
      for(var_0 = 1; var_1 < level.characters.size - 1; var_1++)
        level.characters[var_1] = level.characters[var_1 + 1];

      level.characters[var_1] = undefined;
      break;
    }
  }
}

removefromspawnedgrouparray() {
  if(isDefined(self.group_name)) {
    if(isDefined(level.spawned_group) && isDefined(level.spawned_group[self.group_name]))
      level.spawned_group[self.group_name] = scripts\engine\utility::array_remove(level.spawned_group[self.group_name], self);
  }
}

createtimer(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "_encstr_9A6C06E43B201F1A";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

relic_bang_and_boom_dropfunc(var_0) {
  if(var_0 > 20)
    return "_encstr_B61216E504A9835B0F9B0850A75AF6D7F2ABD0EDDF424F40";
  else if(var_0 > 10)
    return "_encstr_A9B919BAA5F5B507D7E8A56BCA4EBEB1F6EACD8E23DBDDE6AF2603";
  else if(var_0 > 5)
    return "_encstr_88981FAE96AF5B83EB474B6B5693BE36B75737A332DEBB37F586C21B66AF6EB21B";
  else if(var_0 > 1.5)
    return "_encstr_962A22AB96EBDA07BEE85AD6AC9CFAD8B7D5B947C8BDEEB9FA17BA8539E89593F5B9B28D";
  else
    return "_encstr_B6AF180B8909B0EFAF8BE810E26330885D0DB5B12CED983887F7";
}

respawn_flare_wavesv_used_playereffects(var_0, var_1) {
  var_2 = 1;

  if(isDefined(var_1))
    var_2 = var_1;

  var_3 = undefined;

  switch (var_0) {
    case 300:
      if(istrue(var_2) && scripts\engine\utility::cointoss())
        var_3 = "_encstr_AC3A1E190FBE8D0737F56358DCE6FA1DB46B2B8DA1956CD6F553B5D2CDD74C60";
      else
        var_3 = "_encstr_86CD1E388A077A6148DEB37622FBD7B13165D26AFB2BD152C7CB47B1C0C1C7EB";

      break;
    case 120:
      if(istrue(var_2) && scripts\engine\utility::cointoss())
        var_3 = "_encstr_96251E8150598630329631A1B797AED30BC5B96EB865886F8FEE7B39C5992377";
      else
        var_3 = "_encstr_B1031ED7C231ABC306071F2F7B2779F438C80F9E3808734A48B50F0755C07708";

      break;
    case 60:
      if(istrue(var_2) && scripts\engine\utility::cointoss())
        var_3 = "_encstr_AA561EF998713887AF59220BDB8E69D583BB1D5EA10550132FE2413CF099F78B";
      else
        var_3 = "_encstr_923A1E8BE9B8226090EE24AE40E8878B0B6B371F51DD6A23C93B5DB418419387";

      break;
    case 30:
      if(istrue(var_2) && scripts\engine\utility::cointoss())
        var_3 = "_encstr_95171FDD3801C34BCF313B9ECF8789D3A39D6BC0CA909E8C01A791BE7F46E977A9";
      else
        var_3 = "_encstr_91521FD208577652BB3F7AFF082707EB1B888587A0CD81C2CF2B92C3C3F1982369";

      break;
    case 10:
      if(istrue(var_2) && scripts\engine\utility::cointoss())
        var_3 = "_encstr_86351F72F08FF6EB4BB07471BE938FFB0BA0EA9AD843AECFA6AF107B5DB9C7D3E1";
      else
        var_3 = "_encstr_91411F3473A6C75AA7C1823A48DBD9D3D851BDAB83091FA4D7DA3F132037016E9B";

      break;
  }

  return var_3;
}

_detachall(var_0) {
  if(!istrue(var_0))
    self.headmodel = undefined;

  if(isDefined(self.riotshieldmodel))
    riotshield_detach(1);

  if(isDefined(self.riotshieldmodelstowed))
    riotshield_detach(0);

  self.hasriotshieldequipped = 0;

  if(!istrue(var_0))
    self detachall();

  scripts\cp\equipment\nvg::clearnvg(istrue(var_0));
}

is_valid_perk(var_0) {
  var_1 = getarraykeys(level.alien_perks["_encstr_AF0B073B6F4A609047"]);

  if(scripts\engine\utility::array_contains(var_1, var_0))
    return 1;

  var_2 = getarraykeys(level.alien_perks["_encstr_9A0B071C2B4E5BF513"]);

  if(scripts\engine\utility::array_contains(var_2, var_0))
    return 1;

  var_3 = getarraykeys(level.alien_perks["_encstr_A50B07389527DAEB23"]);
  return scripts\engine\utility::array_contains(var_3, var_0);
}

is_consumable_active(var_0) {
  if(isDefined(self.consumables) && isDefined(self.consumables[var_0]) && isDefined(self.consumables[var_0].on) && self.consumables[var_0].on == 1)
    return 1;
  else
    return 0;
}

notify_used_consumable(var_0) {
  self notify(self.consumables[var_0].usednotify);
}

notify_timeup_consumable(var_0) {
  self notify(level.consumables[var_0].timeupnotify);
}

drawline(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 * 20);

  for(var_5 = 0; var_5 < var_4; var_5++)
    wait 0.05;
}

is_upgrade_enabled(var_0) {
  if(!is_using_extinction_tokens())
    return 0;

  if(self getplayerdata("_encstr_850703B7D9", "_encstr_AF781750614F56D2015D92CFA50869D2C43881261EDD028FE0", var_0))
    return 1;
  else
    return 0;
}

allow_player_teleport(var_0, var_1) {
  if(var_0) {
    if(!isDefined(self.teleportdisableflags) && isDefined(var_1)) {
      foreach(var_3 in self.teleportdisableflags) {
        if(var_3 == var_1)
          self.teleportdisableflags = scripts\engine\utility::array_remove(self.teleportdisableflags, var_1);
      }
    }

    self.disabledteleportation--;

    if(!self.disabledteleportation) {
      self.teleportdisableflags = [];
      self.can_teleport = 1;
      self notify("_encstr_A6D50D1BB09B7D8E2BB1AC83BD9C47");
    }
  } else {
    if(!isDefined(self.teleportdisableflags))
      self.teleportdisableflags = [];

    if(isDefined(var_1))
      self.teleportdisableflags[self.teleportdisableflags.size] = var_1;

    self.disabledteleportation++;
    self.can_teleport = 0;
  }
}

ismeleeenabled() {
  return !isDefined(self.disabledmelee) || !self.disabledmelee;
}

isteleportenabled() {
  return !isDefined(self.disabledteleportation) || !self.disabledteleportation;
}

allow_player_interactions(var_0) {
  if(var_0) {
    self.disabledinteractions--;

    if(!self.disabledinteractions)
      self.interactions_disabled = undefined;
  } else {
    self.disabledinteractions++;
    self.interactions_disabled = 1;
  }
}

areinteractionsenabled() {
  return self.disabledinteractions < 1;
}

_linkTo(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";

  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  if(!isDefined(var_4))
    var_4 = (0, 0, 0);

  if(!isDefined(self.playerlinkedcounter))
    self.playerlinkedcounter = 0;

  self.playerlinkedcounter++;

  if(self.playerlinkedcounter == 1)
    self linkTo(var_1, var_2, var_3, var_4);
}

_unlink() {
  if(isplayerlinked()) {
    self.playerlinkedcounter--;

    if(self.playerlinkedcounter <= 0) {
      self.playerlinkedcounter = 0;
      self unlink();
    }
  }
}

get_linked_struct() {
  var_0 = scripts\engine\utility::get_linked_structs();

  if(!var_0.size)
    return undefined;

  return var_0[0];
}

isplayerlinked() {
  return isDefined(self.playerlinkedcounter) && self.playerlinkedcounter > 0;
}

enable_infinite_ammo(var_0) {
  if(var_0) {
    self.infiniteammocounter++;
    self setclientomnvar("_encstr_9728159A3B19BB4F405B1AC220A1873310810709A3E045", 1);
  } else {
    if(self.infiniteammocounter > 0)
      self.infiniteammocounter--;

    if(!self.infiniteammocounter)
      self setclientomnvar("_encstr_9728159A3B19BB4F405B1AC220A1873310810709A3E045", 0);
  }
}

isinfiniteammoenabled() {
  return self.infiniteammocounter >= 1;
}

brjugg_playerwelcomesplashes(var_0) {
  if(!isDefined(self.move_door_to_pos))
    self.move_door_to_pos = 0;

  if(var_0) {
    self.move_door_to_pos++;
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
  } else {
    self.move_door_to_pos--;

    if(self.move_door_to_pos < 0)
      self.move_door_to_pos = 0;

    if(!self.move_door_to_pos) {
      self skydive_setbasejumpingstatus(0);
      self skydive_setdeploymentstatus(0);
    }
  }
}

brjugg_setconfig(var_0) {
  if(!isDefined(self.move_entity))
    self.move_entity = 0;

  if(var_0) {
    self.move_entity++;
    hideminimap(1);
  } else {
    self.move_entity--;

    if(self.move_entity < 0)
      self.move_entity = 0;

    if(!self.move_entity)
      showminimap();
  }
}

trophy_get_part_by_tag() {
  if(isDefined(self.move_entity) && self.move_entity > 0)
    return 1;

  return 0;
}

allow_player_ignore_me(var_0) {
  if(var_0) {
    self.enabledignoreme++;
    self.ignoreme = 1;
  } else {
    self.enabledignoreme--;

    if(!self.enabledignoreme)
      self.ignoreme = 0;
  }
}

brjugg_startdelivery(var_0) {
  if(var_0) {
    self.move_hvt_from_under_heli++;
    self.shouldskiplaststand = 1;
  } else {
    self.move_hvt_from_under_heli--;

    if(!self.move_hvt_from_under_heli)
      self.shouldskiplaststand = 0;
  }
}

brjugg_setjuggwatchers(var_0) {
  if(var_0) {
    self.move_gate++;
    self.shouldskipdeathsshield = 1;
  } else {
    self.move_gate--;

    if(!self.move_gate)
      self.shouldskipdeathsshield = 0;
  }
}

update_bomb_vest_cell_phone_holder_timer() {
  return self.move_hvt_from_under_heli >= 1;
}

uihidden() {
  return self.move_gate >= 1;
}

isignoremeenabled() {
  return self.enabledignoreme >= 1;
}

force_usability_enabled() {
  scripts\common\input_allow::clear_allow_info("_encstr_9BE40A0BC09BCEF7C0F33441");
  self enableusability();
}

is_using_extinction_tokens() {
  return 0;

  if(getdvarint("_encstr_92C50B538A35C4D2549A0A6AA2") > 0)
    return 1;

  return 0;
}

coop_getweaponclass(var_0) {
  if(!isDefined(var_0))
    return "_encstr_8BBA05185F8B99";

  if(issameweapon(var_0) && nullweapon(var_0))
    return "_encstr_8BBA05185F8B99";

  if(isstring(var_0) && var_0 == "_encstr_8BBA05185F8B99")
    return "_encstr_8BBA05185F8B99";

  var_1 = getbaseweaponname(var_0);
  var_2 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 4, var_1, 1);

  if(var_2 == "_encstr_B40101" && isDefined(level.game_mode_statstable)) {
    if(isDefined(var_0)) {
      var_1 = getbaseweaponname(var_0);
      var_2 = tablelookup(level.game_mode_statstable, 4, var_1, 2);
    }
  }

  if(isenvironmentweapon(var_0))
    var_2 = "_encstr_BADE0AEE56581CF6B9FAD6CE";
  else if(issameweapon(var_0) && nullweapon(var_0))
    var_2 = "_encstr_8261067B1D34AC27";
  else if(isstring(var_0) && var_0 == "_encstr_8BBA05185F8B99")
    var_2 = "_encstr_8261067B1D34AC27";
  else if(var_2 == "_encstr_B40101")
    var_2 = "_encstr_8261067B1D34AC27";

  return var_2;
}

is_holding_deployable() {
  return istrue(self.is_holding_deployable);
}

has_special_weapon() {
  return istrue(self.has_special_weapon);
}

filloffhandweapons(var_0, var_1) {
  var_2 = self getweaponslistoffhands();
  var_3 = 0;
  var_4 = undefined;
  var_5 = 0;

  foreach(var_7 in var_2) {
    if(var_7 != var_0) {
      if(nullweapon(var_7)) {
        continue;
      }
      var_8 = var_7.basename;

      if(var_8 != "_encstr_A3F41649A2C7ED284B38AD9F4F7450A4A71AC0119AC71110" && var_8 != "_encstr_A72F0FB0B196AC37474EB7831AE5D7ADE0" && var_8 != "_encstr_B6DD125ADD63F5858D5A567319D88D9126F5DAC1")
        self takeweapon(var_7);

      continue;
    }

    if(!nullweapon(var_7)) {
      var_5 = self getammocount(var_7);
      self setweaponammostock(var_7, var_5 + var_1);
      var_3 = 1;
      break;
    }
  }

  if(var_3 == 0) {
    _giveweapon(var_0);
    self setweaponammostock(var_0, var_1);
  }
}

getequipmenttype(var_0) {
  switch (var_0) {
    case "_encstr_A5EE0FB90AFB612C833F6D7B539A788880":
    case "_encstr_95E8104FDBDA7D272B1CAE3637B793AFAD0E":
    case "_encstr_BE7612A2731819435BD7FF939B702A5408FE98AD":
    case "_encstr_8B76125B2A543086C2379FBDF78AC7A0F549ADB3":
    case "_encstr_ABBD14B4B5072CC659D6AC9BA3F59B384BB6AC7DD6C1":
    case "_encstr_8C29148AB066B33EF8CF0BE843F085030D29A211583F":
    case "_encstr_96D117C193B71E4BB5A547BCF5CA1E83C6BD37A59D56FA5B38":
    case "_encstr_8C5A1231DEEA37D82D9BD9F5312BA33AE5AFADC1":
    case "_encstr_85411A7360F80713EB85CFE79D834A4588A82D3C7978D15AB1CFEF83":
    case "_encstr_AACD13E8A1E47BDD4B9BECDACDA5332B6C43F5B5C1":
    case "_encstr_81430B218B3F7018458997D78A":
    case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
    case "_encstr_A99213D77C53903D97DB1E01C34FF8C8AFCD277D15":
    case "_encstr_BDA70A2F5F1AF5F8A009AA40":
    case "_encstr_9AAE0876FCB7603101DB":
    case "_encstr_B8E306B10D7D9ED6":
    case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
    case "_encstr_914A1099390B3BFA9DC9B2DC16232BFA9E6B":
    case "_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0":
    case "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83":
    case "_encstr_92590EFBF91ED25750D8D7DC30B88E8A":
    case "_encstr_B8D30758E3EE7827BA":
    case "_encstr_99410C4B48C39AB7D0CD95B769DB":
    case "_encstr_BA730BF8AFF178988293F158B9":
    case "_encstr_8DCB085BEF657B4DCF0B":
    case "_encstr_92A70ABB8267F5E0D89F6351":
    case "_encstr_9301076F8808DCFA41":
    case "_encstr_8A78055C8D488C":
      var_1 = "_encstr_B116071BCAD186858D";
      break;
    case "_encstr_846910C0E18BF19DDE41E8C56AD89AB79550":
    case "_encstr_AF1B0FF3C5AFFA6B90E09DE75978BF02FF":
    case "_encstr_BDC9145E757AAF080F8FF0B1DF4A81FD021F45488DC3":
    case "_encstr_8C26185BD0EF873FF8CF0CF25710844F18AB43D37BB5AFF928B9":
    case "_encstr_A5B5199B56E79DDFE16AD89E30378820FBC1743BDB2FE1FA587569":
    case "_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E":
    case "_encstr_92EA0A290B32FF88A90170EB":
    case "_encstr_848B1005B77834C3C596A39A192F6361A831":
    case "_encstr_AC9E13EF0EFB5B29CB802FC7F0C11692592D79E5F7":
    case "_encstr_8C910E2F850A5358F63B88E8E737F0B1":
    case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
    case "_encstr_AAE3152B1D2710FDA1C785A3CB6AB5B8CAF35121099D80":
    case "_encstr_8823119675DAFF897F878020BB99612B219D8F":
    case "_encstr_A65517E81AAC93DA7B4CC2C9D26CAF3B4E5673C28CB2F56B0E":
    case "_encstr_A5051483F6E4A385B1FAEC5673959C853ADE93EBE9B5":
    case "_encstr_A5051483F6E4A385B1FAEC5673959C853ADE93EBB5C1":
    case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
    case "_encstr_BAE70F650B12EFA13AD74838BB45FEFD2A":
    case "_encstr_95280B25B782E8858022721FD6":
    case "_encstr_9697082017E133B762B2":
    case "_encstr_B48F074AB8A8FE9AB1":
    case "_encstr_840B0BA36F78D7A8D6B3C61BEB":
    case "_encstr_BE7206A2D07B1322":
    case "_encstr_88A906570DDE7B21":
      var_1 = "_encstr_99C209E34FC743616118AB";
      break;
    default:
      var_1 = undefined;
      break;
  }

  return var_1;
}

giveperkoffhand(var_0) {
  if(var_0 == "_encstr_8BBA05185F8B99" || var_0 == "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249")
    self setoffhandsecondaryclass("_encstr_8BBA05185F8B99");
  else {
    self.secondarygrenade = var_0;

    if(issubstr(var_0, "_encstr_851A049F8337")) {
      switch (var_0) {
        case "_encstr_BAE70F650B12EFA13AD74838BB45FEFD2A":
        case "_encstr_BE7612A2731819435BD7FF939B702A5408FE98AD":
        case "_encstr_8B76125B2A543086C2379FBDF78AC7A0F549ADB3":
        case "_encstr_8C29148AB066B33EF8CF0BE843F085030D29A211583F":
        case "_encstr_A99213D77C53903D97DB1E01C34FF8C8AFCD277D15":
        case "_encstr_BDA70A2F5F1AF5F8A009AA40":
        case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
        case "_encstr_914A1099390B3BFA9DC9B2DC16232BFA9E6B":
        case "_encstr_92A70ABB8267F5E0D89F6351":
          self setoffhandsecondaryclass("_encstr_8A78055C8D488C");
          break;
        case "_encstr_8D2E157420B63003616B9F8F7D2394379AC5F72748E1C1":
        case "_encstr_85411A7360F80713EB85CFE79D834A4588A82D3C7978D15AB1CFEF83":
        case "_encstr_AACD13E8A1E47BDD4B9BECDACDA5332B6C43F5B5C1":
        case "_encstr_B8E306B10D7D9ED6":
        case "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83":
          self setoffhandsecondaryclass("_encstr_92590EFBF91ED25750D8D7DC30B88E8A");
          break;
        case "_encstr_8C26185BD0EF873FF8CF0CF25710844F18AB43D37BB5AFF928B9":
        case "_encstr_A5B5199B56E79DDFE16AD89E30378820FBC1743BDB2FE1FA587569":
        case "_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E":
        case "_encstr_92EA0A290B32FF88A90170EB":
        case "_encstr_848B1005B77834C3C596A39A192F6361A831":
        case "_encstr_8C910E2F850A5358F63B88E8E737F0B1":
        case "_encstr_A65517E81AAC93DA7B4CC2C9D26CAF3B4E5673C28CB2F56B0E":
        case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
          self setoffhandsecondaryclass("_encstr_88A906570DDE7B21");
          break;
        case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
        case "_encstr_AAE3152B1D2710FDA1C785A3CB6AB5B8CAF35121099D80":
        case "_encstr_8823119675DAFF897F878020BB99612B219D8F":
          self setoffhandsecondaryclass("_encstr_BE7206A2D07B1322");
          break;
        case "_encstr_846910C0E18BF19DDE41E8C56AD89AB79550":
        case "_encstr_AF1B0FF3C5AFFA6B90E09DE75978BF02FF":
        case "_encstr_95E8104FDBDA7D272B1CAE3637B793AFAD0E":
        default:
          self setoffhandsecondaryclass("_encstr_8261067B1D34AC27");
          break;
      }

      _giveweapon(var_0, 0);

      switch (var_0) {
        case "_encstr_846910C0E18BF19DDE41E8C56AD89AB79550":
        case "_encstr_AF1B0FF3C5AFFA6B90E09DE75978BF02FF":
        case "_encstr_8C26185BD0EF873FF8CF0CF25710844F18AB43D37BB5AFF928B9":
        case "_encstr_A5B5199B56E79DDFE16AD89E30378820FBC1743BDB2FE1FA587569":
        case "_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E":
        case "_encstr_92EA0A290B32FF88A90170EB":
        case "_encstr_848B1005B77834C3C596A39A192F6361A831":
        case "_encstr_AC9E13EF0EFB5B29CB802FC7F0C11692592D79E5F7":
        case "_encstr_8C910E2F850A5358F63B88E8E737F0B1":
        case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
        case "_encstr_8823119675DAFF897F878020BB99612B219D8F":
        case "_encstr_A65517E81AAC93DA7B4CC2C9D26CAF3B4E5673C28CB2F56B0E":
        case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
          self setweaponammoclip(var_0, 1);
          break;
        default:
          self givestartammo(var_0);
          break;
      }

      _setperk(var_0);
      return;
    }

    _setperk(var_0);
  }
}

_launchgrenade(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self launchgrenade(var_0, var_1, var_2, var_3, var_5);

  if(!isDefined(var_4))
    var_6.notthrown = 1;
  else
    var_6.notthrown = var_4;

  var_6 setotherent(self);
  return var_6;
}

moveplayerperpendicularly(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 1200;

  if(isDefined(var_1))
    var_2 = vectorNormalize(var_1);
  else
    var_2 = anglesToForward(self.angles);

  var_3 = vectorcross((0, 0, 1), var_2);
  var_4 = vectorNormalize(var_3);
  self knockback(var_4, var_0);
}

blockperkfunction(var_0) {
  if(!isDefined(self.perksblocked[var_0]))
    self.perksblocked[var_0] = 1;
  else
    self.perksblocked[var_0]++;

  if(self.perksblocked[var_0] == 1 && _hasperk(var_0)) {
    foreach(var_6, var_2 in level.extraperkmap) {
      if(var_0 == var_6) {
        foreach(var_4 in var_2) {
          if(!isDefined(self.perksblocked[var_4]))
            self.perksblocked[var_4] = 1;
          else
            self.perksblocked[var_4]++;

          if(self.perksblocked[var_4] == 1) {}
        }

        break;
      }
    }
  }
}

unblockperkfunction(var_0) {
  self.perksblocked[var_0]--;

  if(self.perksblocked[var_0] == 0) {
    self.perksblocked[var_0] = undefined;

    if(_hasperk(var_0)) {
      foreach(var_6, var_2 in level.extraperkmap) {
        if(var_0 == var_6) {
          foreach(var_4 in var_2) {
            self.perksblocked[var_4]--;

            if(self.perksblocked[var_4] == 0)
              self.perksblocked[var_4] = undefined;
          }

          break;
        }
      }
    }
  }
}

getweaponclass(var_0) {
  var_1 = getbaseweaponname(var_0);
  var_2 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 4, var_1, 1);

  if(var_2 == "_encstr_B40101") {
    var_3 = strip_suffix(var_0.basename, "_encstr_8B1A043798E0");
    var_2 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 4, var_3, 1);
  }

  if(isenvironmentweapon(var_0.basename))
    var_2 = "_encstr_BADE0AEE56581CF6B9FAD6CE";
  else if(iskillstreakweapon(var_0.basename))
    var_2 = "_encstr_85CE0B9770B02C73A1760F06D2";
  else if(issuperweapon(var_0.basename))
    var_2 = "_encstr_BEB406F03B72BB3B";
  else if(var_0.basename == "_encstr_8BBA05185F8B99")
    var_2 = "_encstr_8261067B1D34AC27";
  else if(var_2 == "_encstr_B40101")
    var_2 = "_encstr_8261067B1D34AC27";

  return var_2;
}

removedamagemodifier(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1) {
    if(!isDefined(self.additivedamagemodifiers)) {
      return;
    }
    self.additivedamagemodifiers[var_0] = undefined;
  } else {
    if(!isDefined(self.multiplicativedamagemodifiers)) {
      return;
    }
    self.multiplicativedamagemodifiers[var_0] = undefined;
  }
}

adddamagemodifier(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2) {
    if(!isDefined(self.additivedamagemodifiers))
      self.additivedamagemodifiers = [];

    self.additivedamagemodifiers[var_0] = var_1;
  } else {
    if(!isDefined(self.multiplicativedamagemodifiers))
      self.multiplicativedamagemodifiers = [];

    self.multiplicativedamagemodifiers[var_0] = var_1;
  }
}

getdamagemodifiertotal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 1.0;

  if(isDefined(self.additivedamagemodifiers)) {
    foreach(var_9 in self.additivedamagemodifiers)
    var_7 = var_7 + (var_9 - 1.0);
  }

  var_11 = 1.0;

  if(isDefined(self.multiplicativedamagemodifiers)) {
    foreach(var_9 in self.multiplicativedamagemodifiers)
    var_11 = var_11 * var_9;
  }

  return var_7 * var_11;
}

isinventoryprimaryweapon(var_0) {
  switch (weaponinventorytype(var_0)) {
    case "_encstr_B4DC085639F9C2779108":
    case "_encstr_BA7F0830B3A7859B60B0":
      return 1;
    default:
      return 0;
  }
}

_enablecollisionnotifies(var_0) {
  if(!isDefined(self.enabledcollisionnotifies))
    self.enabledcollisionnotifies = 0;

  if(var_0) {
    if(self.enabledcollisionnotifies == 0)
      self enablecollisionnotifies(1);

    self.enabledcollisionnotifies++;
  } else {
    if(self.enabledcollisionnotifies == 1)
      self enablecollisionnotifies(0);

    self.enabledcollisionnotifies--;
  }
}

has_tag(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  var_2 = getnumparts(var_0);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(tolower(getpartname(var_0, var_3)) == tolower(var_1))
      return 1;
  }

  return 0;
}

is_trap(var_0, var_1) {
  if(isDefined(var_1) && (var_1.basename == "_encstr_B21F10B4BBDCBE31592CD6E83958E0F5D3AD" || var_1.basename == "_encstr_B604160B63CF0719C327A81807FED1A9928EF30D78E1F540" || var_1.basename == "_encstr_95EA12634B068F1BBFBFCF3B3D536B41434EA8B7" || var_1.basename == "_encstr_ACCE114BBB73AF8C5AB96CF647930BC1BEA7B6" || var_1.basename == "_encstr_A6D2144BBBCD7D6C43C9ED6BBDDC0786ACC9B2FA4FDA" || var_1.basename == "_encstr_8A3312F33F96A6950B3A504053636DB963EF8279" || var_1.basename == "_encstr_97BF14B477B9D7951B95D88E9396B11D27851CEBD3D6" || var_1.basename == "_encstr_82BC0FC83BDF11DCE243E9ED971B88E02D" || var_1.basename == "_encstr_95F313A20783219430940639F883F3FA260B41C25A" || var_1.basename == "_encstr_A9E91060307FDFFD0F40A8136BFF7B77050F"))
    return 1;

  if(!isDefined(var_0))
    return 0;

  if(isDefined(var_0.tesla_type))
    return 1;

  if(!isDefined(var_0.script_noteworthy) && !isDefined(var_0.targetname))
    return 0;

  if(isDefined(var_0.targetname) && (var_0.targetname == "_encstr_AF6910866D10578F6FF0925A984DC643684E" || var_0.targetname == "_encstr_86A911C15732238DB2BE9DCA73AC392C3ABD9C"))
    return 1;

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_B8980A334BE4ACBEE89CB083")
    return 1;

  return 0;
}

riotshieldname() {
  var_0 = self getweaponslist("_encstr_BA7F0830B3A7859B60B0");

  if(!self.hasriotshield) {
    return;
  }
  foreach(var_2 in var_0) {
    if(weapontype(var_2) == "_encstr_A5450BC280BF4B604068C33187")
      return var_2;
  }
}

player_has_special_ammo(var_0, var_1) {
  return isDefined(var_0.special_ammo_type) && var_0.special_ammo_type == var_1;
}

has_stun_ammo(var_0) {
  if(isDefined(self.special_ammo_type))
    return player_has_special_ammo(self, "_encstr_B4870A7F59154AF7A830CD55");

  if(!isDefined(var_0))
    var_1 = self getcurrentweapon();
  else if(issameweapon(var_0))
    var_1 = var_0;
  else
    var_1 = asmdevgetallstates(var_0);

  if(nullweapon(var_1))
    var_1 = self getweaponslistprimaries()[0];

  var_2 = getrawbaseweaponname(var_1);

  if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[var_2]) && self.special_ammocount[var_2] > 0)
    return 1;

  if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[var_2]) && self.special_ammocount_comb[var_2] > 0)
    return 1;

  return 0;
}

is_ricochet_damage() {
  return level.ricochetdamage;
}

is_hardcore_mode() {
  return level.hardcoremode;
}

is_casual_mode() {
  return level.casualmode == 1;
}

valuehud(var_0) {
  if(isDefined(var_0) && var_0.basename != "_encstr_8BBA05185F8B99") {
    if(issuperweapon(var_0.basename))
      return 1;

    var_1 = getequipmenttype(var_0.basename);

    if(isDefined(var_1) && var_1 == "_encstr_B116071BCAD186858D")
      return 1;
  }

  return 0;
}

isriotshield(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0))
    return 0;

  if(isstring(var_0) && var_0 == "_encstr_8BBA05185F8B99")
    return 0;

  return weapontype(var_0) == "_encstr_A5450BC280BF4B604068C33187";
}

isaltmodeweapon(var_0) {
  if(!isDefined(var_0) || var_0 == "_encstr_8BBA05185F8B99")
    return 0;

  return weaponinventorytype(var_0) == "_encstr_B4DC085639F9C2779108";
}

hasriotshield() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(isriotshield(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

is_empty_string(var_0) {
  return var_0 == "_encstr_B40101";
}

notifyafterframeend(var_0, var_1) {
  self waittill(var_0);
  waittillframeend;
  self notify(var_1);
}

player_last_death_pos() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.last_death_pos = self.origin;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F");
    self.last_death_pos = self.origin;
  }
}

isheadshot(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(isDefined(var_3.owner)) {
      if(var_3.code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
        return 0;

      if(var_3.code_classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E")
        return 0;

      if(var_3.code_classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0")
        return 0;
    }

    if(isDefined(var_3.agent_type)) {
      if(var_3.agent_type == "_encstr_AA180446F6EC" || var_3.agent_type == "_encstr_97BB06B0C64B59B9")
        return 0;
    }
  }

  return (var_1 == "_encstr_81CC0586952C91" || var_1 == "_encstr_A6CC076A05751852B3" || var_1 == "_encstr_9ABA05E87F4B70") && var_2 != "_encstr_8DED0A21C79B660BC7588981" && var_2 != "_encstr_A1ED0BA9FF84562B60BA073E83" && var_2 != "_encstr_A33D0BC1B520DF371B57D94933" && var_2 != "_encstr_8D4E0A501FCB898912CB3FA3" && var_2 != "_encstr_87280E1FB705D168313D1FD197B1A799" && !isenvironmentweapon(var_0.basename);
}

getteamarray(var_0, var_1) {
  var_2 = [];

  if(!isDefined(var_1) || var_1) {
    foreach(var_4 in level.characters) {
      if(var_4.team == var_0)
        var_2[var_2.size] = var_4;
    }
  } else {
    foreach(var_4 in level.players) {
      if(var_4.team == var_0)
        var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

getotherteam(var_0) {
  if(level.multiteambased) {}

  if(var_0 == "_encstr_9A8507BA4040188D08")
    return "_encstr_8E8405EA382B2A";
  else if(var_0 == "_encstr_8E8405EA382B2A")
    return "_encstr_9A8507BA4040188D08";
  else
    return "_encstr_8BBA05185F8B99";
}

player_black_screen(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A3BC0D2DB544180EEAE7AFB7FF9258");
  self endon("_encstr_AD75063D571AE108");
  self.player_black_screen = newclienthudelem(self);
  self.player_black_screen.x = 0;
  self.player_black_screen.y = 0;
  self.player_black_screen setshader("_encstr_83AB065EE1391A7B", 640, 480);
  self.player_black_screen.alignx = "_encstr_A5AD056A019C63";
  self.player_black_screen.aligny = "_encstr_AC190479FF92";
  self.player_black_screen.sort = 1;
  self.player_black_screen.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.player_black_screen.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.player_black_screen.alpha = 0;
  self.player_black_screen.foreground = 1;

  if(!istrue(var_3))
    self.player_black_screen fadeovertime(var_0);

  self.player_black_screen.alpha = 1;

  if(!istrue(var_3))
    wait(var_0 + 0.05);

  wait(var_1);
  self.player_black_screen fadeovertime(var_2);
  self.player_black_screen.alpha = 0;
  wait(var_2 + 0.05);
  self.player_black_screen destroy();
}

riotshield_hasweapon() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(isriotshield(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

riotshield_attach(var_0, var_1) {
  var_2 = undefined;

  if(var_0) {
    self.riotshieldmodel = var_1;
    var_2 = "_encstr_BE860CEA7128332BDB0821C70301";
  } else {
    self.riotshieldmodelstowed = var_1;
    var_2 = "_encstr_81941033E6A7397E4A7713397B01CE0B7BFC";
  }

  if(!isDefined(self.initlocs_donetsk) || self.initlocs_donetsk != var_2) {
    self.initlocs_donetsk = var_2;
    self attachshieldmodel(var_1, var_2);
  }

  self.hasriotshield = riotshield_hasweapon();
}

riotshield_detach(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(var_0) {
    var_1 = self.riotshieldmodel;
    var_2 = "_encstr_BE860CEA7128332BDB0821C70301";
  } else {
    var_1 = self.riotshieldmodelstowed;
    var_2 = "_encstr_81941033E6A7397E4A7713397B01CE0B7BFC";
  }

  if(isDefined(self.initlocs_donetsk) && self.initlocs_donetsk == var_2) {
    self.initlocs_donetsk = undefined;
    self detachshieldmodel(var_1, var_2);
  }

  if(var_0)
    self.riotshieldmodel = undefined;
  else
    self.riotshieldmodelstowed = undefined;

  self.hasriotshield = riotshield_hasweapon();
}

launchshield(var_0, var_1) {
  if(riotshield_hasweapon()) {
    if(isDefined(self.riotshieldmodel))
      riotshield_detach(1);

    if(isDefined(self.riotshieldmodelstowed))
      riotshield_detach(0);
  }
}

riotshield_move(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  if(var_0) {
    var_3 = self.riotshieldmodel;
    var_1 = "_encstr_BE860CEA7128332BDB0821C70301";
    var_2 = "_encstr_81941033E6A7397E4A7713397B01CE0B7BFC";
  } else {
    var_3 = self.riotshieldmodelstowed;
    var_1 = "_encstr_81941033E6A7397E4A7713397B01CE0B7BFC";
    var_2 = "_encstr_BE860CEA7128332BDB0821C70301";
  }

  if(!isDefined(self.initlocs_donetsk) || self.initlocs_donetsk != var_2) {
    self.initlocs_donetsk = var_2;
    self moveshieldmodel(var_3, var_1, var_2);
  }

  if(var_0) {
    self.riotshieldmodelstowed = var_3;
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodel = var_3;
    self.riotshieldmodelstowed = undefined;
  }
}

riotshield_clear() {
  self.hasriotshieldequipped = 0;
  self.hasriotshield = 0;
  self.riotshieldmodelstowed = undefined;
  self.riotshieldmodel = undefined;
}

remove_crafting_item() {
  self setclientomnvar("_encstr_A3461C022FF7099B17A1C0183BEB4B403FDA18FFB17F91DBF1AA2048D280", 0);

  if(isDefined(level.crafting_remove_func))
    self[[level.crafting_remove_func]]();

  self.current_crafting_struct = undefined;
}

store_weapons_status(var_0, var_1) {
  self.copy_fullweaponlist = self getweaponslistall();
  self.copy_weapon_current = get_current_weapon(self, var_1);
  self.copy_weapon_level = [];
  var_2 = [];

  foreach(var_4 in self.copy_fullweaponlist) {
    if(var_4.isalternate) {
      continue;
    }
    if(issubstr(var_4.basename, "_encstr_95AE0F5A7770AFB2872B6CBA8E96BDB9F5")) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  self.copy_fullweaponlist = var_2;

  foreach(var_4 in self.copy_fullweaponlist) {
    var_7 = createheadicon(var_4);
    self.copy_weapon_ammo_clip[var_7] = self getweaponammoclip(var_4);
    self.copy_weapon_ammo_stock[var_7] = self getweaponammostock(var_4);

    if(issubstr(var_4.basename, "_encstr_AD9C07E0478148252A"))
      self.copy_weapon_ammo_clip_left[var_7] = self getweaponammoclip(var_4, "_encstr_A5AD056A019C63");

    var_8 = getrawbaseweaponname(var_4);

    if(isDefined(self.pap[var_8]))
      self.copy_weapon_level[var_7] = self.pap[var_8].lvl;
  }

  if(isDefined(var_0)) {
    var_10 = [];

    foreach(var_4 in self.copy_fullweaponlist) {
      var_12 = 0;

      foreach(var_14 in var_0) {
        if(var_4 == var_14) {
          var_12 = 1;
          break;
        } else if(var_4 getbaseweapon() == var_14) {
          var_12 = 1;
          break;
        }
      }

      if(var_12) {
        continue;
      }
      var_10[var_10.size] = var_4;
    }

    self.copy_fullweaponlist = var_10;

    foreach(var_14 in var_0) {
      if(self.copy_weapon_current == var_14) {
        self.copy_weapon_current = isundefinedweapon();
        break;
      }
    }
  }
}

get_current_weapon(var_0, var_1) {
  var_2 = var_0 getcurrentweapon();

  if(istrue(var_1) && is_melee_weapon(var_2))
    var_2 = var_0 getweaponslistall()[1];

  return var_2;
}

is_melee_weapon(var_0, var_1) {
  var_2 = undefined;

  if(issameweapon(var_0))
    var_2 = var_0.basename;
  else
    var_2 = var_0;

  switch (var_2) {
    case "_encstr_8E65135F38C6A8EAB342E369512AA2DF81E18BE665":
    case "_encstr_B66F1A2CD88EBEA5EEE67DB5B99699ACAF9EB6D7DC57C9672DB3F64E":
    case "_encstr_82711889D16B9F84376A3972C8633F0F66421D3FFC73FF8DCFC0":
    case "_encstr_8109182A24EB49CB7BC3CEF410D931ADFF68E527F8E190B2A70B":
    case "_encstr_961D17BF154BB728772609B05BB1010B41382128EA72BD915A":
    case "_encstr_8E5417408A53EF788757C8DA162741537113A829D2ECD790B7":
    case "_encstr_859716621B6C872470DB767D9FF86D3FF6F34B1BA0A40F5A":
    case "_encstr_A9861488B30B77A06BB1EC55AF13A8AFC70B90382A37":
    case "_encstr_8DAB144C3B67988A736184426FD0A037AA3263E0A7F0":
    case "_encstr_923813BFF78CE17B782867AF0630B53986737B0765":
    case "_encstr_BA7B13FB933FF7282E9F332B5F62A0BFC2FC60F1EE":
    case "_encstr_AFD017B0D8D1BE96DDE6D7AD37D2662BAFE9D6F5CEECA5E48D":
    case "_encstr_861D180BB13A7DB4EE6EEBD637D23395FAA7B6FAE45838E0AC27":
    case "_encstr_B6A4160BD847D7D2DD6EBEDA375A33ACF53D6BEB73B2398C":
    case "_encstr_ADC716C1F58409438BDEB7C7A3B21C1017C8C89E1CF7B00A":
    case "_encstr_8C3511B08DE8D75A779B7DB5DC2D3359AF3DDA":
    case "_encstr_ACA813FB2772EF6BB83BE0CBB9721D170BFC5BA3AA":
    case "_encstr_876714B4DD9BD7B573A53359BE3DDABE4E5883E0CA27":
    case "_encstr_960D12A38043510F4BB8837FC18099B66837E589":
    case "_encstr_88E912C0B30386871BAB27A80F0B4287859058E2":
    case "_encstr_A1B616E25B2321F8E073218725CBB59F2172EFC07372970C":
    case "_encstr_82D812CBDF32A0DA5EA3D583109390999BB70C3B":
    case "_encstr_BED80D7C9C59D95BF870DBDFA9F018":
      return 1;
    case "_encstr_95A9135ADDDCBE6D0B47C2B92CFA4FB6FA8385388C":
    case "_encstr_BAA91358AB4F81CA925B534527598AA88FC2C1F342":
    case "_encstr_8BB7168017FF2E1DEB2D1E93C3A25F132F8B38B9F341039D":
    case "_encstr_99B71651D782E9FBFD8062DACBDED75A6955DD9F31E8EACE":
    case "_encstr_A9210EC85FB796AF6273D7680EB9B598":
    case "_encstr_AF5711D3773301C0270A89D083470A2871E253":
    case "_encstr_A20A1003CF665603D89A290832391929D312":
    case "_encstr_A90A1071F7A2C9A71B81C19BE8E09B3EF0E3":
    case "_encstr_8B060B2DDDE6BE0B0F95FAD3D6":
    case "_encstr_828E18D82BCF01CC92C7F9FF5F8B81B93B07A35015D3D8739B53":
    case "_encstr_97411361BCE37F672B68ABD321259DC7E32FE6E556":
    case "_encstr_8343142C9707BEEB38F7B39B09BAED3F903FD8582771":
    case "_encstr_9612142A5324BF5F8037AC935720A577A46B63A2B9D5":
    case "_encstr_810813AA3FE649D5B8D2ABF288CA509787EC6541F1":
    case "_encstr_AFF30DCA8B6F69F6AABB50174E4248":
      if(istrue(var_1))
        return 0;
      else
        return 1;
    default:
      return 0;
  }
}

is_primary_melee_weapon(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  switch (var_1) {
    case "_encstr_95A9135ADDDCBE6D0B47C2B92CFA4FB6FA8385388C":
    case "_encstr_BAA91358AB4F81CA925B534527598AA88FC2C1F342":
    case "_encstr_8BB7168017FF2E1DEB2D1E93C3A25F132F8B38B9F341039D":
    case "_encstr_99B71651D782E9FBFD8062DACBDED75A6955DD9F31E8EACE":
    case "_encstr_A9210EC85FB796AF6273D7680EB9B598":
    case "_encstr_AF5711D3773301C0270A89D083470A2871E253":
    case "_encstr_A20A1003CF665603D89A290832391929D312":
    case "_encstr_A90A1071F7A2C9A71B81C19BE8E09B3EF0E3":
    case "_encstr_8B060B2DDDE6BE0B0F95FAD3D6":
      return 1;
  }

  return 0;
}

restore_weapons_status(var_0) {
  if(!isDefined(self.copy_fullweaponlist) || !isDefined(self.copy_weapon_current) || !isDefined(self.copy_weapon_ammo_clip) || !isDefined(self.copy_weapon_ammo_stock)) {}

  var_1 = self getweaponslistall();

  foreach(var_3 in var_1) {
    if(!scripts\engine\utility::array_contains(self.copy_fullweaponlist, var_3) && !in_inclusion_list(var_0, var_3))
      self takeweapon(var_3);
  }

  if(isDefined(self._id_12D4D)) {
    if(!scripts\engine\utility::array_contains(self.copy_fullweaponlist, self._id_12D4D))
      self.copy_fullweaponlist[self.copy_fullweaponlist.size] = self._id_12D4D;

    self._id_12D4D = undefined;
  }

  foreach(var_3 in self.copy_fullweaponlist) {
    if(!self hasweapon(var_3))
      self giveweapon(var_3, -1, 0, -1, 1);

    var_6 = createheadicon(var_3);

    if(isDefined(self.powerprimarygrenade) && self.powerprimarygrenade == var_6)
      self assignweaponoffhandprimary(var_3);

    if(isDefined(self.powersecondarygrenade) && self.powersecondarygrenade == var_6)
      self assignweaponoffhandsecondary(var_3);

    if(isDefined(self.specialoffhandgrenade) && self.specialoffhandgrenade == var_6)
      self assignweaponoffhandspecial(var_3);

    if(isDefined(self.copy_weapon_ammo_clip[var_6]))
      self setweaponammoclip(var_3, self.copy_weapon_ammo_clip[var_6]);

    if(isDefined(self.copy_weapon_ammo_clip_left)) {
      if(isDefined(self.copy_weapon_ammo_clip_left[var_6]))
        self setweaponammoclip(var_3, self.copy_weapon_ammo_clip_left[var_6], "_encstr_A5AD056A019C63");
    }

    if(isDefined(self.copy_weapon_ammo_stock[var_6]))
      self setweaponammostock(var_3, self.copy_weapon_ammo_stock[var_6]);

    if(isDefined(self.copy_weapon_level[var_6])) {
      var_7 = spawnStruct();
      var_7.lvl = self.copy_weapon_level[var_6];
      self.pap[getrawbaseweaponname(var_3)] = var_7;
    }
  }

  var_9 = self.copy_weapon_current;

  if(getqueuedspleveltransients(var_9)) {
    foreach(var_11 in self.copy_fullweaponlist) {
      if(scripts\cp\cp_weapon::isbulletweapon(var_11)) {
        var_9 = var_11;
        break;
      }
    }
  }

  if(scripts\common\utility::is_weapon_switch_allowed())
    self switchtoweaponimmediate(var_9);

  if(!istrue(self.bspawningviaac130)) {
    self.copy_fullweaponlist = undefined;
    self.copy_weapon_current = undefined;
    self.copy_weapon_ammo_clip = undefined;
    self.copy_weapon_ammo_stock = undefined;
    self.copy_weapon_ammo_clip_left = undefined;
  }

  if(isDefined(level.arcade_last_stand_power_func))
    self[[level.arcade_last_stand_power_func]]();
}

restore_primary_weapons_only(var_0) {
  if(!isDefined(self.copy_fullweaponlist) || !isDefined(self.copy_weapon_current) || !isDefined(self.copy_weapon_ammo_clip) || !isDefined(self.copy_weapon_ammo_stock)) {}

  self.primary_weapons = [];
  var_1 = 0;

  foreach(var_3 in self.copy_fullweaponlist) {
    if(isinventoryprimaryweapon(var_3)) {
      self.primary_weapons[var_1] = var_3;
      var_1 = var_1 + 1;
    }
  }

  var_5 = 0;

  foreach(var_3 in self.primary_weapons) {
    if(var_5 < 3) {
      if(var_3.isalternate) {
        continue;
      }
      if(!self hasweapon(var_3))
        self giveweapon(var_3, -1, 0, -1, 1);

      var_7 = createheadicon(var_3);
      self setweaponammoclip(var_3, self.copy_weapon_ammo_clip[var_7]);
      self setweaponammostock(var_3, self.copy_weapon_ammo_stock[var_7]);

      if(isDefined(self.copy_weapon_level[var_7])) {
        var_8 = spawnStruct();
        var_8.lvl = self.copy_weapon_level[var_7];
        self.pap[getrawbaseweaponname(var_3)] = var_8;
      }

      var_5++;
    }
  }

  var_10 = self.copy_weapon_current;

  if(!isDefined(var_10) || !self hasweapon(var_10) || nullweapon(var_10))
    var_10 = getweapontoswitchbackto();

  self switchtoweaponimmediate(var_10);
  self.copy_fullweaponlist = undefined;
  self.copy_weapon_current = undefined;
  self.copy_weapon_ammo_clip = undefined;
  self.copy_weapon_ammo_stock = undefined;
}

clear_weapons_status() {
  self.copy_fullweaponlist = [];
  self.copy_weapon_current = isundefinedweapon();
  self.copy_weapon_ammo_clip = [];
  self.copy_weapon_ammo_clip_left = [];
  self.copy_weapon_ammo_stock = [];
  self.copy_weapon_level = [];
}

add_to_weapons_status(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_6 = undefined;
    var_7 = undefined;

    if(issameweapon(var_5)) {
      var_6 = var_5;
      var_7 = createheadicon(var_5);
    } else {
      var_6 = asmdevgetallstates(var_5);
      var_7 = var_5;
    }

    self.copy_fullweaponlist[self.copy_fullweaponlist.size] = var_6;
    self.copy_weapon_ammo_clip[var_7] = var_1[var_7];
    self.copy_weapon_ammo_stock[var_7] = var_2[var_7];
  }

  self.copy_weapon_current = var_3;
}

in_inclusion_list(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  return scripts\engine\utility::array_contains(var_0, var_1);
}

vec_multiply(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

restore_super_weapon() {
  self giveweapon("_encstr_BEB611F03B72BB3B07E435BCF9772051117388");
  self assignweaponoffhandspecial("_encstr_BEB611F03B72BB3B07E435BCF9772051117388");
  self.specialoffhandgrenade = "_encstr_BEB611F03B72BB3B07E435BCF9772051117388";

  if(istrue(self.consumable_meter_full))
    self setweaponammoclip("_encstr_BEB611F03B72BB3B07E435BCF9772051117388", 1);
}

getcloseststruct(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_1, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_4 = sortbydistance(var_3, var_0)[0];

  if(isDefined(var_2) && distancesquared(var_0, var_4.origin) > squared(var_2))
    return undefined;

  return var_4;
}

is_zombie_agent() {
  return isagent(self) && isDefined(self.species) && (self.species == "_encstr_ABC70986AE5B0BE6DED232" || self.species == "_encstr_BACB074025B01AAA28");
}

is_soldier_agent() {
  return isagent(self) && isDefined(self.species) && self.species == "_encstr_A9C20643EAB52C9B";
}

coop_mode_has(var_0) {
  if(!isDefined(level.coop_mode_feature))
    return 0;

  return isDefined(level.coop_mode_feature[var_0]);
}

coop_mode_enable(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(level.coop_mode_feature))
      level.coop_mode_feature = [];

    if(isarray(var_0)) {
      foreach(var_2 in var_0)
      level.coop_mode_feature[var_2] = 1;
    } else
      level.coop_mode_feature[var_0] = 1;
  }
}

make_entity_sentient_cp(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1)
    return self makeentitysentient(var_0, 1);
  else
    return self makeentitysentient(var_0);
}

get_attacker_as_player(var_0) {
  if(isDefined(var_0)) {
    if(isPlayer(var_0))
      return var_0;

    if(isDefined(var_0.owner) && isPlayer(var_0.owner))
      return var_0.owner;
  }

  return undefined;
}

removeexcludedattachments(var_0) {
  if(isDefined(level.excludedattachments)) {
    foreach(var_2 in level.excludedattachments) {
      foreach(var_4 in var_0) {
        if(attachmentmap_tobase(var_4) == var_2)
          var_0 = scripts\engine\utility::array_remove(var_0, var_4);
      }
    }
  }

  return var_0;
}

getrandomweaponattachments(var_0, var_1, var_2) {
  var_3 = [];

  if(weaponhaspassive(var_0, var_1, "_encstr_A2061B8FD977D3135B9A2948F27531E8A77F9F0524E71959C5E2B840CB")) {
    if(0) {
      var_4 = getavailableattachments(var_0, var_2, 0);
      var_3[var_3.size] = var_4[randomint(var_4.size)];
    } else {
      var_5 = int(max(0, 5 - var_2.size));

      if(var_5 > 0) {
        var_6 = randomintrange(1, var_5 + 1);
        var_3 = buildrandomattachmentarray(var_0, var_6, var_2);
      }
    }
  }

  return var_3;
}

weaponhaspassive(var_0, var_1, var_2) {
  var_3 = getweaponpassives(var_0, var_1);

  if(!isDefined(var_3) || var_3.size <= 0)
    return 0;

  foreach(var_5 in var_3) {
    if(var_2 == var_5)
      return 1;
  }

  return 0;
}

buildrandomattachmentarray(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = scripts\cp\cp_weapon::getattachmenttypeslist(var_0, var_2);

  if(var_4.size > 0) {
    var_3 = [];
    var_5 = scripts\engine\utility::array_randomize_objects(var_4);

    foreach(var_10, var_7 in var_5) {
      if(var_1 <= 0) {
        break;
      }

      var_8 = 1;

      switch (var_10) {
        case "_encstr_9B780BB3D839A28A5078DFABB8":
        case "_encstr_A19A0772BF43C35FD9":
          var_8 = 1;
          break;
        case "_encstr_851F05E3C813A5":
        case "_encstr_88190407B038":
        case "_encstr_960D052F10EBF0":
          var_8 = 0;
          break;
        default:
          var_8 = randomintrange(1, var_1 + 1);
          break;
      }

      if(var_8 > 0) {
        if(var_8 > var_7.size)
          var_8 = var_7.size;

        var_1 = var_1 - var_8;

        for(var_7 = scripts\engine\utility::array_randomize_objects(var_7); var_8 > 0; var_8--) {
          var_9 = var_7[var_7.size - var_8];

          if(!issubstr(var_9, "_encstr_8719040B93AD") && !issubstr(var_9, "_encstr_BD2A077E6B3841FAA5"))
            var_3[var_3.size] = var_9;
        }
      }
    }
  }

  return var_3;
}

getavailableattachments(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = getweaponattachmentarrayfromstats(var_0);
  var_4 = [];

  foreach(var_6 in var_3) {
    var_7 = getattachmenttype(var_6);

    if(!var_2 && var_7 == "_encstr_851F05E3C813A5") {
      continue;
    }
    if(isDefined(var_1) && listhasattachment(var_1, var_6)) {
      continue;
    }
    var_4[var_4.size] = var_6;
  }

  return var_4;
}

listhasattachment(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 == var_1)
      return 1;
  }

  return 0;
}

getweaponattachmentarrayfromstats(var_0) {
  var_1 = getweaponrootname(var_0);

  if(!isDefined(level.weaponattachments))
    level.weaponattachments = [];

  if(!isDefined(level.weaponattachments[var_1])) {
    var_2 = [];

    for(var_3 = 0; var_3 < 10; var_3++) {
      var_4 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 4, var_1, 10 + var_3);

      if(var_4 == "_encstr_B40101") {
        break;
      }

      var_2[var_2.size] = var_4;
    }

    level.weaponattachments[var_1] = var_2;
  }

  return level.weaponattachments[var_1];
}

getweaponpaintjobid(var_0) {
  return -1;
}

getweaponcamo(var_0) {
  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_BD42193DF6AD892DCA05D80BE559C9AB565838EDB9A6BD9195B1B9", var_0, "_encstr_B19005D885B5F6");

  if(isDefined(var_1) && var_1 != "_encstr_8BBA05185F8B99")
    return var_1;
  else
    return "_encstr_8BBA05185F8B99";
}

getweaponcosmeticattachment(var_0) {
  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_BD42193DF6AD892DCA05D80BE559C9AB565838EDB9A6BD9195B1B9", var_0, "_encstr_88AC1316CD5A9A3BEBCB973F34541E073007CDED93");

  if(isDefined(var_1) && var_1 != "_encstr_8BBA05185F8B99")
    return var_1;
  else
    return "_encstr_8BBA05185F8B99";
}

getweaponreticle(var_0) {
  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_BD42193DF6AD892DCA05D80BE559C9AB565838EDB9A6BD9195B1B9", var_0, "_encstr_925008E456475A6CB195");

  if(isDefined(var_1) && var_1 != "_encstr_8BBA05185F8B99")
    return var_1;
  else
    return "_encstr_8BBA05185F8B99";
}

mpbuildweaponname(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = weaponattachdefaultmap(var_0);
  var_10 = buildweaponassetname(var_0, var_4);
  var_11 = coop_getweaponclass(var_10);

  if(isDefined(var_9))
    var_1 = scripts\engine\utility::array_combine_unique(var_1, var_9);

  var_1 = weaponattachremoveextraattachments(var_1);
  var_1 = removeexcludedattachments(var_1);

  for(var_12 = 0; var_12 < var_1.size; var_12++)
    var_1[var_12] = attachmentmap_tounique(var_1[var_12], var_10);

  if(isDefined(var_9)) {
    for(var_12 = 0; var_12 < var_9.size; var_12++)
      var_9[var_12] = attachmentmap_tounique(var_9[var_12], var_10);
  }

  if(isDefined(var_9))
    var_1 = scripts\engine\utility::array_combine_unique(var_1, var_9);

  var_1 = scripts\engine\utility::array_remove(var_1, "_encstr_8BBA05185F8B99");

  if(isDefined(var_8) && var_8 != "_encstr_8BBA05185F8B99")
    var_1[var_1.size] = var_8;

  if(var_1.size > 0)
    var_1 = filterattachments(var_1);

  var_13 = [];

  foreach(var_15 in var_1) {
    var_16 = attachmentmap_toextra(var_15);

    if(isDefined(var_16))
      var_13[var_13.size] = attachmentmap_tounique(var_16, var_10);
  }

  if(var_13.size > 0)
    var_1 = scripts\engine\utility::array_combine_unique(var_1, var_13);

  if(var_1.size > 0)
    var_1 = scripts\engine\utility::alphabetize(var_1);

  var_10 = reassign_weapon_name(var_10, var_1);

  foreach(var_19 in var_1)
  var_10 = var_10 + ("_encstr_BE4C0295" + var_19);

  if(issubstr(var_10, "_encstr_921904C3C7E2")) {
    var_10 = buildweaponnamecamo(var_10, var_2, var_4);
    var_21 = 0;

    if(isholidayweapon(var_10, var_4))
      var_21 = isholidayweaponusingdefaultscope(var_10, var_1);

    if(var_21)
      var_10 = var_10 + "_encstr_937908566E6CBDC15662";
    else
      var_10 = buildweaponnamereticle(var_10, var_3);

    var_10 = buildweaponnamevariantid(var_10, var_4);
  }

  return var_10;
}

reassign_weapon_name(var_0, var_1) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_0)]))
    return var_0;
  else {
    switch (var_0) {
      case "_encstr_999B0FC47322C7423F4F23EF99D5A93DC0":
        if(istrue(self.base_weapon))
          var_0 = "_encstr_999B0FC47322C7423F4F23EF99D5A93DC0";
        else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs))
            var_0 = "_encstr_999B0FC47322C7423F4F23EF99D5A93DC0";
          else
            var_0 = "_encstr_AB9E1480DB7608C8C6FB4143F42F91E993B13B0913C6";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 2) {
          if(istrue(self.bang_bangs))
            var_0 = "_encstr_AB9E1480DB7608C8C6FB4143F42F91E993B13B0913C6";
          else
            var_0 = "_encstr_999E14192747A11198CFCB0703B75FFD0FF1B846A38F";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 3)
          var_0 = "_encstr_999E14192747A11198CFCB0703B75FFD0FF1B846A38F";

        break;
      case "_encstr_BE63160FB774588380BA51FBEF189FBDB8A619E3D5BFB078":
        if(istrue(self.base_weapon))
          var_0 = "_encstr_BE63160FB774588380BA51FBEF189FBDB8A619E3D5BFB078";
        else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs))
            var_0 = "_encstr_BE63160FB774588380BA51FBEF189FBDB8A619E3D5BFB078";
          else
            var_0 = "_encstr_851C1BA9B7941788A70AD15A224188FD5820A1BA4FBF6B1FBF87473AC1";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 2) {
          if(istrue(self.bang_bangs))
            var_0 = "_encstr_851C1BA9B7941788A70AD15A224188FD5820A1BA4FBF6B1FBF87473AC1";
          else
            var_0 = "_encstr_B21C1BD2EECDEB3ADDF6F51A2B58469519AF161ECABEDAC1F583581C91";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 3)
          var_0 = "_encstr_B21C1BD2EECDEB3ADDF6F51A2B58469519AF161ECABEDAC1F583581C91";

        break;
      case "_encstr_83EA1297DFB4D95BA030CC57890192F2ED770F6B":
        if(istrue(self.base_weapon))
          var_0 = "_encstr_83EA1297DFB4D95BA030CC57890192F2ED770F6B";
        else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs))
            var_0 = "_encstr_83EA1297DFB4D95BA030CC57890192F2ED770F6B";
          else
            var_0 = "_encstr_A260173B7BA757BB8BC3FA5F25E7CA88B47FFBC0D0594152EF";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 2) {
          if(istrue(self.bang_bangs))
            var_0 = "_encstr_A260173B7BA757BB8BC3FA5F25E7CA88B47FFBC0D0594152EF";
          else
            var_0 = "_encstr_B66017FF97A31F0668C7CAFF2D893A01988F0201F9E8CF5002";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 3)
          var_0 = "_encstr_B66017FF97A31F0668C7CAFF2D893A01988F0201F9E8CF5002";

        break;
      case "_encstr_8D7511B98FA389CCA2B1776680E853AB47C8EB":
        if(istrue(self.base_weapon))
          var_0 = "_encstr_8D7511B98FA389CCA2B1776680E853AB47C8EB";
        else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs))
            var_0 = "_encstr_8D7511B98FA389CCA2B1776680E853AB47C8EB";
          else
            var_0 = "_encstr_A3E41651E8423934E8A01129F319903938A8578ECA78FB57";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 2) {
          if(istrue(self.bang_bangs))
            var_0 = "_encstr_A3E41651E8423934E8A01129F319903938A8578ECA78FB57";
          else
            var_0 = "_encstr_ACE4169CA31B29A8B758789E0BEB73CDFFDDCBF741BE386B";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 3)
          var_0 = "_encstr_ACE4169CA31B29A8B758789E0BEB73CDFFDDCBF741BE386B";

        break;
      case "_encstr_8B060B2DDDE6BE0B0F95FAD3D6":
        if(scripts\engine\utility::array_contains(var_1, "_encstr_AB8F08524AF58B16D03B"))
          var_0 = "_encstr_A90A1071F7A2C9A71B81C19BE8E09B3EF0E3";
        else if(scripts\engine\utility::array_contains(var_1, "_encstr_998F08F873AF19D1C33A"))
          var_0 = "_encstr_A20A1003CF665603D89A290832391929D312";

        break;
      case "_encstr_A9210EC85FB796AF6273D7680EB9B598":
        if(scripts\engine\utility::array_contains(var_1, "_encstr_A54A0BDA11A359A5268380108F"))
          var_0 = "_encstr_BAA91358AB4F81CA925B534527598AA88FC2C1F342";
        else if(scripts\engine\utility::array_contains(var_1, "_encstr_8D4A0BAD851D16E61683B0E08C"))
          var_0 = "_encstr_95A9135ADDDCBE6D0B47C2B92CFA4FB6FA8385388C";

        break;
      case "_encstr_AF5711D3773301C0270A89D083470A2871E253":
        if(scripts\engine\utility::array_contains(var_1, "_encstr_8D590EAAFBA002E23BB9EA37EFF34FDF"))
          var_0 = "_encstr_99B71651D782E9FBFD8062DACBDED75A6955DD9F31E8EACE";
        else if(scripts\engine\utility::array_contains(var_1, "_encstr_AF590EDD7565E0C327DA88B3D34F8722"))
          var_0 = "_encstr_8BB7168017FF2E1DEB2D1E93C3A25F132F8B38B9F341039D";

        break;
      case "_encstr_B6271396DDCDD766DB27D9AC3393B256F4CA7D9EAD":
        if(scripts\engine\utility::array_contains(var_1, "_encstr_8BB90BF803AD6935EAAA1F9FD2"))
          var_0 = "_encstr_AF5918D3773301C44FCB0971B2030D9838FD378D0581C09FDB17";
        else if(scripts\engine\utility::array_contains(var_1, "_encstr_83B90BBA48138F3B61FFA1C8B6"))
          var_0 = "_encstr_A959185ABBDCEB997B279D5699E4592BD3B2D7A75BFAE02C38C8";

        break;
      case "_encstr_82471034B48F976090332F21842D356928E8":
        if(scripts\engine\utility::array_contains(var_1, "_encstr_9B5C0D16B48B6329C40F930807084B"))
          var_0 = "_encstr_8A6F15B4EE73BECDD04E2B2323599CBE4FADBE83160789";

        break;
      case "_encstr_A21B1096EEE6FA23D2E636347B4EC8EBF4AD":
        if(scripts\engine\utility::array_contains(var_1, "_encstr_BE6E0D8CB49BC6867B27C8E00B0789"))
          var_0 = "_encstr_B4B615704BF3FFC9EF23E66B07BBF13708724940C2FA9B";

        break;
      case "_encstr_AF6112F28BFC17F778BFE5E55BF8BB2786267B3A":
        if(scripts\engine\utility::array_contains(var_1, "_encstr_863D07CDB703B78821"))
          var_0 = "_encstr_A5A11796BBDCF599C21BB25B2B1B1DAC93FAA7ADD738B00726";

        break;
      case "_encstr_BDCD12B4DD6EBE0D591623B15DA33A2B93AFE9B5":
        if(scripts\engine\utility::array_contains(var_1, "_encstr_B28F07341B0E85C198"))
          var_0 = "_encstr_BE65170FB77458F3105A9FD7EBB09BBD08A60269EF03D078C6";

        break;
    }
  }

  return var_0;
}

get_weapon_variant_id(var_0, var_1) {
  var_2 = getbaseweaponname(var_1);
  return -1;
}

weaponhasvariants(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  switch (var_0) {
    case "_encstr_8C8D0B5F176C019788EB420DC2":
    case "_encstr_95430B5863DBA7909F4B9A802E":
    case "_encstr_8AAA0F96BB73EBB1D0C24ECE2BCD1ABDE8":
    case "_encstr_8386085CBC67F9711A30":
    case "_encstr_BD0D09E45302E7C237D92F":
    case "_encstr_BA110E013F7CDF398D48D0298B48BF58":
    case "_encstr_B42B0A6F23823897F02BC059":
    case "_encstr_B45A0D098FDAB1E75BD9EBC3A1262F":
    case "_encstr_88E70BC0B30386FF1727B32AFF":
    case "_encstr_8186089F5F73B918AE52":
      return 0;
    default:
      return 1;
  }
}

weaponattachremoveextraattachments(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = attachmentmap_tounique(var_4, var_1);
    var_6 = attachmentmap_toextra(var_5);

    if(isDefined(var_6))
      var_2[var_2.size] = var_6;
  }

  var_8 = [];

  foreach(var_4 in var_0) {
    var_10 = 0;

    foreach(var_6 in var_2) {
      if(var_4 == var_6) {
        var_10 = 1;
        break;
      }
    }

    if(!var_10)
      var_8[var_8.size] = var_4;
  }

  return var_8;
}

weaponattachdefaultmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].attachdefaults))
    return level.weaponmapdata[var_0].attachdefaults;

  return undefined;
}

weaponassetnamemap(var_0, var_1) {
  if(iskillstreakweapon(var_0))
    return var_0;

  if(isDefined(var_1)) {
    var_2 = var_0 + "_encstr_854C021F" + var_1;

    if(isDefined(level.weaponlootmapdata[var_2]) && isDefined(level.weaponlootmapdata[var_2].assetoverridename))
      return level.weaponlootmapdata[var_2].assetoverridename;
  }

  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].assetname))
    return level.weaponmapdata[var_0].assetname;

  return var_0;
}

iskillstreakweapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  if(isDefined(level.killstreakweaponmap) && isDefined(level.killstreakweaponmap[var_1]))
    return 1;

  return 0;
}

buildweaponassetname(var_0, var_1) {
  return weaponassetnamemap(var_0, var_1);
}

getweaponassetfromrootweapon(var_0, var_1) {
  var_2 = "_encstr_85331038937FC097B223A0947F0AF1E89656" + var_0 + "_encstr_96A70506895E33";
  var_3 = tablelookup(var_2, 0, var_1, 3);
  return var_3;
}

getweaponvariantattachments(var_0, var_1) {
  var_2 = [];
  var_3 = getweaponpassives(var_0, var_1);

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      var_6 = getpassiveattachment(var_5);

      if(!isDefined(var_6)) {
        continue;
      }
      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

getpassiveattachment(var_0) {
  var_1 = getpassivestruct(var_0);

  if(!isDefined(var_1) || !isDefined(var_1.attachmentref))
    return undefined;

  return var_1.attachmentref;
}

getweaponpassives(var_0, var_1) {
  return getpassivesforweapon(var_0, var_1);
}

getpassivesforweapon(var_0, var_1) {
  var_2 = getlootinfoforweapon(var_0, var_1);

  if(isDefined(var_2))
    return var_2.passives;

  return undefined;
}

getlootinfoforweapon(var_0, var_1) {
  var_2 = getweaponrootname(var_0);

  if(!isDefined(level.lootweaponcache))
    level.lootweaponcache = [];

  if(isDefined(level.lootweaponcache[var_2]) && isDefined(level.lootweaponcache[var_2][var_1])) {
    var_3 = level.lootweaponcache[var_2][var_1];
    return var_3;
  }

  var_3 = cachelootweaponweaponinfo(var_0, var_2, var_1);

  if(isDefined(var_3))
    return var_3;

  return undefined;
}

getweaponrootname(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  var_2 = level.weaponrootcache[var_1];

  if(isDefined(var_2))
    return var_2;

  var_3 = var_1;
  var_4 = strtok(var_1, "_encstr_BA4C02DF");
  var_5 = 0;

  if(var_4[0] == "_encstr_B419040BB1A3")
    var_5++;

  if(var_4[var_5] == "_encstr_B21904D2EE0E" || var_4[var_5] == "_encstr_BD0703AF7C") {
    var_6 = ["_encstr_AD07034A38", "_encstr_990703B843", "_encstr_AA07038DB6", "_encstr_A30703C763", "_encstr_A10703BB40", "_encstr_9707038CB6", "_encstr_A607036B40", "_encstr_8707037C7F", "_encstr_820703E04B"];

    if(scripts\engine\utility::array_contains(var_6, var_4[var_5 + 1]))
      var_1 = var_4[var_5] + "_encstr_BA4C02DF" + var_4[var_5 + 1] + "_encstr_BA4C02DF" + var_4[var_5 + 2];
    else
      var_1 = var_4[var_5] + "_encstr_BA4C02DF" + var_4[var_5 + 1];
  }

  if(level.weaponrootcache.size < 100)
    level.weaponrootcache[var_3] = var_1;

  return var_1;
}

relic_nuketimer_globalthread(var_0) {
  var_1 = getweaponrootname(var_0);

  if(isDefined(level.weaponmapdata[var_1]) && isDefined(level.weaponmapdata[var_1].assetname))
    var_0 = level.weaponmapdata[var_1].assetname;

  return var_0;
}

weapon_is_a_cp_mod(var_0, var_1) {
  if(isDefined(var_0[var_1 + 3]) && isDefined(var_0[var_1 + 4]))
    return 1;

  return 0;
}

weapon_is_cp_loot(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  return issubstr(var_1, "_encstr_AACA08D8F6B6DAD67B9B") || issubstr(var_1, "_encstr_B28609CBEB8615C3AFDD68") || issubstr(var_1, "_encstr_811F05C0D722E1") || issubstr(var_1, "_encstr_8CA50A7230B9C18D9DFF4003") || issubstr(var_1, "_encstr_A56005CAC14BD8") || issubstr(var_1, "_encstr_BDC708DCB52A81480593");
}

weapon_is_dlc2_melee(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  return issubstr(var_1, "_encstr_ABCC07DA161D16E62C") || issubstr(var_1, "_encstr_87910A37ABDC8DA1EA1B6D6E");
}

weapon_is_dlc_melee(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  return issubstr(var_1, "_encstr_AC820B588B25BF089F7125AD4C") || issubstr(var_1, "_encstr_B40B0BE249FFC21DABAF8AD7C9") || issubstr(var_1, "_encstr_B1CB0859917FF833E352") || issubstr(var_1, "_encstr_A1DD0A3F27C2B4C7D68D8B56");
}

cachelootweaponweaponinfo(var_0, var_1, var_2) {
  if(!isDefined(level.lootweaponcache[var_1]))
    level.lootweaponcache[var_1] = [];

  var_3 = getweaponloottable(var_0);
  var_4 = readweaponinfofromtable(var_3, var_2);
  level.lootweaponcache[var_1][var_2] = var_4;
  return var_4;
}

readweaponinfofromtable(var_0, var_1) {
  var_2 = tablelookuprownum(var_0, 0, var_1);
  var_3 = spawnStruct();
  var_3.ref = tablelookupbyrow(var_0, var_2, 1);
  var_3.weaponasset = tablelookupbyrow(var_0, var_2, 3);
  var_3.passives = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_5 = tablelookupbyrow(var_0, var_2, 5 + var_4);

    if(isDefined(var_5) && var_5 != "_encstr_B40101")
      var_3.passives[var_3.passives.size] = var_5;
  }

  return var_3;
}

init_drop_locations(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9");
  var_1.angles = var_0.angles;
  var_1.targetname = var_0.targetname;
  return var_1;
}

create_fake_loot(var_0) {
  if(istrue(self.available)) {
    return;
  }
  if(istrue(level.little_bird_mg_cp_spawncallback)) {
    return;
  }
  self show();
  self.available = 1;
  var_1 = undefined;

  if(isDefined(var_0)) {
    if(isstring(var_0))
      var_1 = [var_0];
    else
      var_1 = var_0;
  } else if(istrue(level.little_bird_mg_cp_onexitvehicle))
    var_1 = ["_encstr_A9941ED5621570B0D3095843027FF5886DC627470A3F208FBB421689EB37AD50", "_encstr_A38916B1626C78B04B6FC3CB93A2054B37FD9EA90AC5C0F6"];
  else
    var_1 = ["_encstr_99F3154C4EB17BF6D1EB6BD5DCA5474BB7737D58B6DAF6", "_encstr_A9941ED5621570B0D3095843027FF5886DC627470A3F208FBB421689EB37AD50", "_encstr_A38916B1626C78B04B6FC3CB93A2054B37FD9EA90AC5C0F6"];

  self.loot_type = scripts\engine\utility::random(var_1);
  var_2 = &"_encstr_8E9719AB7791FA8F56B710689FBB13E73AD32D3D1F6976F36F6FA8";

  switch (self.loot_type) {
    case "_encstr_A9941ED5621570B0D3095843027FF5886DC627470A3F208FBB421689EB37AD50":
      var_2 = &"_encstr_BADE146805D79025BC3A258A398288A2F51A29828AA8";
      break;
    case "_encstr_A38916B1626C78B04B6FC3CB93A2054B37FD9EA90AC5C0F6":
      var_2 = &"_encstr_A1C4128678576595FD28D121A0CAD71DCBD1B50D";
      break;
    case "_encstr_97DC21C666B99207E389CF57F8B8D43A67F001FF45E9DA5F6A50FB3B8856BB02FD9DD2":
      var_2 = &"_encstr_A58E1948C1ABC913C1A50EE3DE991FD6F9539F9FCDB956A774F5B5";
      break;
  }

  self setModel("_encstr_AB7E215269940BF6C0719FBF0B213A27C703EA0BB37EDF687177D1BC319803F3E55922");
  self.origin = self.origin + (0, 0, 16);

  if(self tagexists("_encstr_BA300854E318F1FF9699"))
    sethintobject("_encstr_BA300854E318F1FF9699", "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, var_2, 25, "_encstr_97C20EB5FD43A179CC6AD05152651579", "_encstr_BD1805CB69C063", 128, 80, 128, 80);
  else
    sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, var_2, 25, "_encstr_97C20EB5FD43A179CC6AD05152651579", "_encstr_BD1805CB69C063", 128, 80, 128, 80);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(!var_3 is_valid_player()) {
      continue;
    }
    if(!scripts\cp\loot_system::give_munition(self.loot_type, var_3)) {
      continue;
    }
    self playsoundtoplayer("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B", var_3);
    self makeunusable();
    self hide();
    self.available = 0;
    return;
  }
}

filterattachments(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      var_3 = var_0[var_2];

      if(var_3 == "_encstr_8BBA05185F8B99") {
        continue;
      }
      var_4 = 1;

      for(var_5 = 0; var_5 < var_1.size; var_5++) {
        if(var_3 == var_1[var_5]) {
          var_4 = 0;
          break;
        }

        var_6 = scripts\cp\cp_weapon::attachmentsconflict(var_3, var_1[var_5]);

        if(var_6 != "_encstr_B40101") {
          var_4 = 0;
          var_1 = scripts\engine\utility::array_remove_index(var_1, var_5);
          var_7 = [];
          var_7 = strtok(var_6, "_encstr_974C0246");

          foreach(var_10, var_9 in var_7)
          var_0 = scripts\engine\utility::array_insert(var_0, var_9, var_2 + 1 + var_10);

          break;
        }
      }

      if(var_4)
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

attachmentiscosmetic(var_0) {
  return isDefined(var_0) && scripts\engine\utility::string_starts_with(var_0, "_encstr_BE91055A80D60F");
}

attachmentmap_toextra(var_0) {
  var_1 = undefined;

  if(isDefined(level.attachmentmap_uniquetoextra[var_0]))
    var_1 = level.attachmentmap_uniquetoextra[var_0];

  return var_1;
}

getpassivestruct(var_0) {
  if(!isDefined(level.passivemap[var_0]))
    return undefined;

  var_1 = level.passivemap[var_0];
  return var_1;
}

map_check(var_0) {
  if(!isDefined(var_0))
    return 1;

  switch (var_0) {
    case 0:
      if(level.script == "_encstr_B67B07D80EF5E9D698")
        return 1;
      else
        return 0;
    case 1:
      if(level.script == "_encstr_B88808122B88E37680F3")
        return 1;
      else
        return 0;
    case 2:
      if(level.script == "_encstr_8B1309EB697197372EF152")
        return 1;
      else
        return 0;
    case 3:
      if(level.script == "_encstr_91B908B1E0D7A3DBDD73")
        return 1;
      else
        return 0;
    default:
      return 1;
  }
}

buildweaponname(var_0, var_1, var_2, var_3, var_4) {
  if(isstrstart(var_0, "_encstr_85C50578238EE0"))
    var_2 = 0;

  var_5 = [];

  foreach(var_7 in var_1)
  var_5[var_5.size] = attachmentmap_tounique(var_7, var_0);

  var_9 = getrawbaseweaponname(var_0);
  var_10 = var_0;
  var_11 = var_9 == "_encstr_AA1904B6266E" || var_9 == "_encstr_95CD086C86955E8E5836" || var_9 == "_encstr_AD07038A6A" || var_9 == "_encstr_BE20075A839F405F42" || var_9 == "_encstr_9960059F982174" || var_9 == "_encstr_B284058A9B1303";

  if(var_11) {
    var_12 = 0;

    foreach(var_7 in var_5) {
      if(getattachmenttype(var_7) == "_encstr_851F05E3C813A5") {
        var_12 = 1;
        break;
      }
    }

    if(!var_12)
      var_5[var_5.size] = var_9 + "_encstr_B8FB06FF97EA2708";
  }

  if(var_5.size > 0) {
    var_15 = scripts\engine\utility::array_remove_duplicates(var_5);
    var_5 = scripts\engine\utility::alphabetize(var_15);
  }

  foreach(var_7 in var_5)
  var_10 = var_10 + ("_encstr_BE4C0295" + var_7);

  if(issubstr(var_10, "_encstr_BE19045AEED8") || issubstr(var_10, "_encstr_921904C3C7E2")) {
    var_10 = buildweaponnamecamo(var_10, var_2);

    if(var_4 != "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33" && isDefined(var_3))
      var_10 = buildweaponnamereticle(var_10, var_3);
  } else if(!scripts\cp\cp_weapon::isvalidzombieweapon(var_10 + "_encstr_851A049F8337"))
    var_10 = var_0 + "_encstr_851A049F8337";
  else {
    var_10 = buildweaponnamecamo(var_10, var_2);
    var_10 = buildweaponnamereticle(var_10, var_3);
    var_10 = var_10 + "_encstr_851A049F8337";
  }

  return var_10;
}

buildweaponnamevariantid(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0)
    return var_0;

  var_0 = var_0 + ("_encstr_A1DD06A721F23091" + var_1);
  return var_0;
}

isholidayweapon(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0)
    return 0;

  if(var_1 == 6) {
    var_2 = getweaponrootname(var_0);
    return var_2 == "_encstr_887C0BA5BB6E7D93B4830E5627" || var_2 == "_encstr_A3BD0A2DF307C901EADF2937" || var_2 == "_encstr_863C09D3DF77A80B625BFB";
  }

  return 0;
}

ismark2weapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  return var_0 >= 32;
}

isholidayweaponusingdefaultscope(var_0, var_1) {
  var_2 = attachmentmap_tounique("_encstr_B8FB06FF97EA2708", getweaponbasename(var_0));
  return isDefined(var_2) && scripts\engine\utility::array_contains(var_1, var_2);
}

is_pap_camo(var_0) {
  if(isDefined(level.pap_1_camo) && var_0 == level.pap_1_camo)
    return 1;
  else if(isDefined(level.pap_2_camo) && var_0 == level.pap_2_camo)
    return 1;

  return 0;
}

buildweaponnamecamo(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    return var_0;

  if(var_1 == "_encstr_8BBA05185F8B99")
    return var_0;

  return var_0 + "_encstr_A1EF079A4FA1106773" + var_1;
}

getweaponqualitybyid(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0)
    return 0;

  var_2 = getweaponloottable(var_0);
  var_3 = int(tablelookup(var_2, 0, var_1, 4));
  return var_3;
}

buildweaponnamereticle(var_0, var_1) {
  if(!isDefined(var_1))
    return var_0;

  var_2 = int(tablelookup("_encstr_87B614A0123F80A55B87EFE9AF01FF48042F40F97ACE", 1, var_1, 5));

  if(!isDefined(var_2) || var_2 == 0)
    return var_0;

  var_0 = var_0 + ("_encstr_AF7107DA3E7AAF52E8" + var_2);
  return var_0;
}

has_zombie_perk(var_0) {
  if(!isDefined(self.zombies_perks))
    return 0;

  return istrue(self.zombies_perks[var_0]);
}

drawsphere(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = (1, 1, 1);

  var_4 = int(var_2 * 20);

  for(var_5 = 0; var_5 < var_4; var_5++)
    wait 0.05;
}

has_auto_revive() {
  return istrue(self.has_auto_revive) || istrue(self.c130_revive);
}

set_alien_emissive(var_0, var_1) {
  var_2 = self.maxemissive - self.defaultemissive;
  var_3 = var_1 * var_2 + self.defaultemissive;
  self emissiveblend(var_0, var_3);
}

get_adjusted_armor(var_0, var_1) {
  if(var_0 + level.deployablebox_vest_rank[var_1] > level.deployablebox_vest_max)
    return level.deployablebox_vest_max;

  return var_0 + level.deployablebox_vest_rank[var_1];
}

alien_mode_has(var_0) {
  var_0 = tolower(var_0);

  if(!isDefined(level.alien_mode_feature))
    return 0;

  if(!isDefined(level.alien_mode_feature[var_0]))
    return 0;

  return level.alien_mode_feature[var_0];
}

enable_alien_scripted() {
  self.alien_scripted = 1;
  self notify("_encstr_934B18B0C6D22BDCAFB62C5A73FAC6DB7B07EBE4ACCDE8B0E4A3");
}

is_normal_upright(var_0) {
  var_1 = (0, 0, 1);
  var_2 = 0.85;
  return vectordot(var_0, var_1) > var_2;
}

get_synch_direction_list(var_0) {
  if(!isDefined(self.synch_attack_setup))
    return [];

  if(!isDefined(self.synch_attack_setup.synch_directions))
    return [];

  if(!self.synch_attack_setup.type_specific)
    return self.synch_attack_setup.synch_directions;

  var_1 = scripts\cp\cp_agent_utils::get_agent_type(var_0);

  if(!isDefined(self.synch_attack_setup.synch_directions[var_1]))
    var_2 = "_encstr_965411A62F37D84340B0D18E586CDA04ED7340" + self.synch_attack_setup.identifier + "_encstr_93E117360D9F123B806A8BE22859EECA4115BEDB6B09AA2A21" + var_1;

  return self.synch_attack_setup.synch_directions[var_1];
}

getrandomindex(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0)
  var_1 = var_1 + var_3;

  var_5 = randomintrange(0, var_1);
  var_1 = 0;

  foreach(var_7, var_3 in var_0) {
    var_1 = var_1 + var_3;

    if(var_5 <= var_1)
      return var_7;
  }

  return 0;
}

get_closest_living_player(var_0, var_1) {
  var_2 = 1073741824;

  if(isDefined(var_0))
    var_2 = var_0;

  var_3 = undefined;
  var_4 = level.players;

  if(isDefined(var_1))
    var_4 = var_1;

  foreach(var_6 in var_4) {
    if(isDefined(level.ignoredbycheck) && [[level.ignoredbycheck]](self, var_6)) {
      continue;
    }
    if(scripts\cp\cp_laststand::player_in_laststand(var_6)) {
      continue;
    }
    var_7 = distancesquared(self.origin, var_6.origin);

    if(var_6 scripts\cp_mp\utility\player_utility::_isalive() && var_7 < var_2) {
      var_3 = var_6;
      var_2 = var_7;
    }
  }

  return var_3;
}

get_array_of_valid_players(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(level.players[var_3] is_valid_player())
      var_2[var_2.size] = level.players[var_3];
  }

  if(!isDefined(var_0) || !var_0)
    return var_2;

  return scripts\engine\utility::get_array_of_closest(var_1, var_2);
}

is_valid_player(var_0, var_1) {
  if(!isPlayer(self))
    return 0;

  if(!isDefined(self))
    return 0;

  if(!isalive(self))
    return 0;

  if(self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return 0;

  if(!isDefined(var_0) && scripts\cp\cp_laststand::player_in_laststand(self))
    return 0;

  if(!isDefined(var_1))
    var_1 = 1;

  if(!istrue(var_1) && (istrue(self.infreefall) || istrue(self.inparachute)))
    return 0;

  return 1;
}

any_player_nearby(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0) < var_1)
      return 1;
  }

  return 0;
}

give_closest_player_nearby(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in level.players) {
    if(isDefined(var_2) && var_5.team != var_2) {
      continue;
    }
    if(distancesquared(var_5.origin, var_0) < var_1)
      var_3[var_3.size] = var_5;
  }

  if(var_3.size > 0) {
    var_7 = sortbydistance(var_3, var_0);
    return var_7[0];
  }

  return undefined;
}

are_all_players_nearby(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0) > var_1)
      return 0;

    wait 0.05;
  }

  return 1;
}

give_all_players_nearby(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(distancesquared(level.players[var_3].origin, var_0) < var_1)
      var_2[var_2.size] = level.players[var_3];
  }

  return var_2;
}

player_pain_vo(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(getdvarint("_encstr_A24416B98DC9FA37F6BE0E36B05ECAE4D7E0B04B9BD7ECDE", 0) == 1) {
    return;
  }
  var_1 = 5500;
  var_2 = gettime();

  if(!isDefined(self.next_pain_vo_time))
    self.next_pain_vo_time = var_2 + randomintrange(var_1, var_1 + 2000);
  else if(var_2 < self.next_pain_vo_time) {
    return;
  }
  while(scripts\cp\cp_music_and_dialog::vo_is_playing())
    wait 0.1;

  if(isDefined(self.vo_prefix)) {
    if(soundexists(self.vo_prefix + "_encstr_923709DBC12EE1600B2865"))
      playlocalsound_safe(self.vo_prefix + "_encstr_923709DBC12EE1600B2865");
    else if(soundexists(self.vo_prefix + "_encstr_B60D055B0E3128"))
      playlocalsound_safe(self.vo_prefix + "_encstr_B60D055B0E3128");
  }

  var_3 = "_encstr_AB9313FB081C43B667D889F08993C839488D668299";

  if(isDefined(var_0)) {
    if(isDefined(var_0.agent_type)) {
      switch (var_0.agent_type) {
        case "_encstr_824C070F170FFBDD20":
          var_3 = "_encstr_9ACA14BBC02AED6361F0EE4B59249E40066D475BFFD5";
          break;
        case "_encstr_9A9B081B635B1483757C":
          var_3 = scripts\engine\utility::random(["_encstr_911B1659B27263EA1190DF43798AAEF6935B2B3F0B625F3F", "_encstr_8F1B16C190E8770253B0798370A3FD27038F444BBB30775A", "_encstr_A31B16D2739AD593CA8CBE1C585ACDD74EC2A3DA4B739DCC"]);
          break;
        default:
          var_3 = "_encstr_AB9313FB081C43B667D889F08993C839488D668299";
          break;
      }
    }
  }

  scripts\cp\cp_vo::try_to_play_vo(var_3, "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18");
  self.next_pain_vo_time = var_2 + randomintrange(var_1, var_1 + 1500);
}

player_pain_breathing_sfx() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(getdvarint("_encstr_A24416B98DC9FA37F6BE0E36B05ECAE4D7E0B04B9BD7ECDE", 0) == 1) {
    return;
  }
  if(is_playing_pain_breathing_sfx(self)) {
    return;
  }
  if(above_pain_breathing_sfx_threshold(self)) {
    return;
  }
  set_is_playing_pain_breathing_sfx(self, 1);
  var_0 = get_pain_breathing_sfx_alias(self);

  if(isDefined(var_0)) {
    if(soundexists(var_0)) {
      while(!above_pain_breathing_sfx_threshold(self) && !level.gameended) {
        if(!istrue(self.vo_system_playing_vo))
          playlocalsound_safe(var_0);

        wait 1.5;
      }
    }

    set_is_playing_pain_breathing_sfx(self, 0);
  }
}

is_playing_pain_breathing_sfx(var_0) {
  return istrue(var_0.is_playing_pain_breathing_sfx);
}

above_pain_breathing_sfx_threshold(var_0) {
  var_1 = 0.3;
  return var_0.health / var_0.maxhealth > var_1;
}

set_is_playing_pain_breathing_sfx(var_0, var_1) {
  var_0.is_playing_pain_breathing_sfx = var_1;
}

get_pain_breathing_sfx_alias(var_0) {
  if(!level.gameended) {
    if(var_0.vo_prefix == "_encstr_B119045043D9")
      return "_encstr_9B2D0C58BFCEE305FDE90B12B02D";
    else if(var_0.vo_prefix == "_encstr_831904D9F2F7")
      return "_encstr_8B1F0CE3F24133D8287EB1701228";
    else if(var_0.vo_prefix == "_encstr_B4190483CCFA")
      return "_encstr_8C200C5ADEF74B3C1BA1A3EF38B0";
    else if(var_0.vo_prefix == "_encstr_86190483D0AF")
      return "_encstr_B68A0C1C43FAE0C6E4F5388596CD";
    else if(var_0.vo_prefix == "_encstr_A6190490B3C6")
      return "_encstr_A1A40C83D751698D5BC7A717D903";
    else
      return "_encstr_8C200C5ADEF74B3C1BA1A3EF38B0";
  }
}

playvoforpillage(var_0) {
  var_1 = var_0.vo_prefix + "_encstr_BE3C0AFF5FF5088893EAF883";

  if(scripts\cp\cp_vo::alias_2d_version_exists(var_0, var_1))
    var_0 playlocalsound_safe(scripts\cp\cp_vo::get_alias_2d_version(var_0, var_1));
  else if(soundexists(var_1))
    var_0 playlocalsound_safe(var_1);
}

deployable_box_onuse_message(var_0) {
  var_1 = "_encstr_B40101";

  if(isDefined(var_0) && isDefined(var_0.boxtype) && isDefined(level.boxsettings[var_0.boxtype].eventstring))
    var_1 = level.boxsettings[var_0.boxtype].eventstring;

  thread setlowermessage("_encstr_9AB40F3256E0B1BDF20B4CD82BD757E695", var_1, 3);
}

is_goon(var_0) {
  switch (var_0) {
    case "_encstr_A3CE06A740D02E07":
    case "_encstr_A7CE0617780F32EB":
    case "_encstr_A1CE06D9DEF6B946":
    case "_encstr_A77205F710801E":
      return 1;
    default:
      return 0;
  }
}

mark_dangerous_nodes(var_0, var_1, var_2) {}

healthregeninit(var_0) {
  level.healthregendisabled = var_0;
}

alien_health_per_player_init() {
  level.alien_health_per_player_scalar = [];
  level.alien_health_per_player_scalar[1] = 0.9;
  level.alien_health_per_player_scalar[2] = 1.0;
  level.alien_health_per_player_scalar[3] = 1.3;
  level.alien_health_per_player_scalar[4] = 1.8;
}

playerhealthregen() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    scripts\engine\utility::_id_143A5("_encstr_B2BE0788BAF573592F", "_encstr_864C1459EDDEE045DB8163C97BFFE8903247F5C39487");

    if(!canregenhealth()) {
      continue;
    }
    var_0 = scripts\cp\cp_laststand::gethealthcap();
    var_1 = self.health / var_0;

    if(var_1 >= 1) {
      self.health = var_0;
      continue;
    }

    thread healthregen(gettime(), var_1);
    thread breathingmanager(gettime(), var_1);
  }
}

get_within_range(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) <= var_2)
      var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

healthregen(var_0, var_1) {
  self notify("_encstr_AA7D13C37B919B5363C2E994D398B2CB9A93219A3B");
  self endon("_encstr_AA7D13C37B919B5363C2E994D398B2CB9A93219A3B");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(isDefined(self.selfdamaging) && self.selfdamaging)
    wait 0.2;

  if(ishealthregendisabled()) {
    return;
  }
  var_2 = spawnStruct();
  getregendata(var_2);
  wait(var_2.activatetime);
  var_3 = gettime();

  for(;;) {
    var_4 = scripts\cp\cp_laststand::gethealthcap();
    var_2 = spawnStruct();
    getregendata(var_2);
    var_1 = self.health / self.maxhealth;

    if(self.health < int(var_4)) {
      var_5 = int(self.health + var_2.regenamount);

      if(var_5 > var_4)
        var_5 = var_4;

      self.health = var_5;
    } else
      break;

    scripts\engine\utility::_id_143B9(var_2.waittimebetweenregen, "_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
  }

  self notify("_encstr_8FB50718DD41DB3FA9");

  if(isDefined(level.playerinitinvulnerability))
    self[[level.playerinitinvulnerability]]();

  resetattackerlist();
}

breathingmanager(var_0, var_1) {
  self notify("_encstr_92F11189C9CA2CD1434BB9B36A0B9BB0B32B93");
  self endon("_encstr_92F11189C9CA2CD1434BB9B36A0B9BB0B32B93");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isusingremote()) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  self.breathingstoptime = var_0 + 6000 * self.regenduration;
  wait(6 * self.regenduration);

  if(!level.gameended) {
    if(!isDefined(self.vo_prefix)) {
      return;
    }
    if(!istrue(self.vo_system_playing_vo)) {
      if(isfemale())
        playlocalsound_safe("_encstr_9A181532ACB6D7C427B2583AD0A59B3BFAC4AC3AE8AC4E");
      else
        playlocalsound_safe("_encstr_8B2011A1E2E211DBF8B88D4071489B2C9B5F38");
    }
  }
}

getregendata(var_0) {
  level.longregentime = 5000;
  level.healthoverlaycutoff = 0.2;
  level.invultime_preshield = 0.35;
  level.invultime_onshield = 0.5;
  level.invultime_postshield = 0.3;
  level.playerhealth_regularregendelay = 2400;
  level.worthydamageratio = 0.1;
  self.prestigehealthregennerfscalar = scripts\cp\perks\cp_prestige::prestige_getslowhealthregenscalar();
  var_1 = 1;

  if(isDefined(self.perk_data)) {
    if(isDefined(self.perk_data["_encstr_939F1253D0677DFD2FACB3028159CFBF711CA1DB"]))
      var_1 = self.perk_data["_encstr_939F1253D0677DFD2FACB3028159CFBF711CA1DB"];
    else
      var_1 = self.perk_data["_encstr_91B50734CA58631D1A"].regen_time_scalar;
  }

  if(self.prestigehealthregennerfscalar == 1.0) {
    if(is_consumable_active("_encstr_97F01C80A26A51110B97FB65815B7BD1D93B2B3B1AC5CF2B5BD7FE6F9C87")) {
      var_0.activatetime = 0.45;
      var_0.waittimebetweenregen = 0.045;
      var_0.regenamount = 0.1;
    } else {
      var_0.activatetime = 6;
      var_0.waittimebetweenregen = 0.05;
      var_0.regenamount = 6 * var_1;
    }
  } else {
    var_0.activatetime = 6 * self.prestigehealthregennerfscalar;
    var_0.waittimebetweenregen = 0.05 * self.prestigehealthregennerfscalar;
    var_0.regenamount = 6;
  }
}

resetattackerlist(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1.75;
  resetattackerlist_internal();
}

resetattackerlist_internal() {
  self.attackers = [];
  self.attackerdata = [];
}

canregenhealth() {
  if(getdvarint("_encstr_84E3197B21762F4F10870912A1A85953155992320EC39F4650A108", 0) == 1)
    return 0;

  if(istrue(self.isjuggernaut))
    return 0;

  if(scripts\cp\cp_laststand::player_in_laststand(self))
    return 0;

  if(istrue(self.fauxdead))
    return 0;

  if(istrue(self.little_bird))
    return 0;

  if(istrue(self._id_12B72))
    return 0;

  return 1;
}

playerpainbreathingsound() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  wait 2;

  for(;;) {
    wait 0.2;

    if(shouldplaypainbreathingsound()) {
      if(self.vo_prefix == "_encstr_B119045043D9") {
        if(soundexists("_encstr_A68013B5A7A7592E03F767D368C43D3BA771B04BE0"))
          playlocalsound_safe("_encstr_A68013B5A7A7592E03F767D368C43D3BA771B04BE0");
      } else
        playlocalsound_safe("_encstr_87560F31E4592C470D2DB99DF586AB4EE8");

      wait 0.784;
      wait(0.1 + randomfloat(0.8));
    }
  }
}

shouldplaypainbreathingsound() {
  if(ishealthregendisabled() || isusingremote() || isDefined(self.breathingstoptime) && gettime() < self.breathingstoptime || self.health > self.maxhealth * 0.55 || level.gameended)
    return 0;
  else
    return 1;
}

ishealthregendisabled() {
  return isDefined(level.healthregendisabled) && level.healthregendisabled || isDefined(self.healthregendisabled) && self.healthregendisabled;
}

playerarmor() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(self.bodyarmorhp))
    self.bodyarmorhp = 0;

  var_0 = self getentitynumber();
  var_1 = 0;
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_0, "_encstr_8F7C0CCFEDE203419AE748B877B2", 0);

  for(;;) {
    scripts\engine\utility::_id_143A5("_encstr_990C0F38C6859795397D2385B52CEC9519", "_encstr_A51E0D97F041C2B1E0466B32559A9E");

    if(!isDefined(self.bodyarmorhp)) {
      if(var_1 > 0) {
        scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_0, "_encstr_8F7C0CCFEDE203419AE748B877B2", 0);
        var_1 = 0;
      }

      continue;
    }

    if(var_1 != self.bodyarmorhp) {
      var_2 = int(self.bodyarmorhp);
      scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_0, "_encstr_8F7C0CCFEDE203419AE748B877B2", var_1);
      var_1 = self.bodyarmorhp;
    }
  }
}

allow_secondary_offhand_weapons(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledsecondaryoffhandweapons))
      self.disabledsecondaryoffhandweapons = 0;

    self.disabledsecondaryoffhandweapons--;

    if(!self.disabledsecondaryoffhandweapons)
      self enableoffhandsecondaryweapons();
  } else {
    if(!isDefined(self.disabledsecondaryoffhandweapons))
      self.disabledsecondaryoffhandweapons = 0;

    self.disabledsecondaryoffhandweapons++;
    self disableoffhandsecondaryweapons();
  }
}

register_physics_collisions() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B4A311D88B980FC8731413C30F96A87BD84283");

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    level notify("_encstr_83EB08F3E1931B7B5091", self, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

global_physics_sound_monitor() {
  level notify("_encstr_A7A0102B9399A31AD91FC1204DA56041386A");
  level endon("_encstr_A7A0102B9399A31AD91FC1204DA56041386A");

  for(;;) {
    level waittill("_encstr_83EB08F3E1931B7B5091", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(var_0) && isDefined(var_0.phys_sound_func))
      level thread[[var_0.phys_sound_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }
}

register_physics_collision_func(var_0, var_1) {
  var_0.phys_sound_func = var_1;
}

addtotraplist() {
  if(!scripts\engine\utility::array_contains(level.placed_crafted_traps, self))
    level.placed_crafted_traps = scripts\engine\utility::array_add_safe(level.placed_crafted_traps, self);

  level.placed_crafted_traps = scripts\engine\utility::array_removeundefined(level.placed_crafted_traps);
}

removefromtraplist() {
  if(scripts\engine\utility::array_contains(level.placed_crafted_traps, self))
    level.placed_crafted_traps = scripts\engine\utility::array_remove(level.placed_crafted_traps, self);

  level.placed_crafted_traps = scripts\engine\utility::array_removeundefined(level.placed_crafted_traps);
}

ent_is_near_equipment(var_0) {
  var_1 = 16384;

  if(level.turrets.size) {
    var_2 = sortbydistance(level.turrets, var_0.origin);

    if(distance2dsquared(var_2[0].origin, var_0.origin) < var_1)
      return 1;
  }

  if(isDefined(level.placed_crafted_traps) && level.placed_crafted_traps.size) {
    foreach(var_4 in level.placed_crafted_traps) {
      if(!isDefined(var_4)) {
        continue;
      }
      if(distance2dsquared(var_4.origin, var_0.origin) < var_1)
        return 1;
    }
  }

  if(isDefined(level.near_equipment_func))
    return [[level.near_equipment_func]](var_0);

  return 0;
}

set_crafted_inventory_item(var_0, var_1, var_2) {
  if(isDefined(var_2.current_crafted_inventory))
    var_2.current_crafted_inventory = undefined;

  var_2.current_crafted_inventory = spawnStruct();
  var_2.current_crafted_inventory.item = var_0;
  var_2.current_crafted_inventory.restore_func = var_1;
}

remove_crafted_item_from_inventory(var_0) {
  var_0.current_crafted_inventory = undefined;
}

remove_crafted_item_from_dpad(var_0, var_1) {
  switch (var_1) {
    case "_encstr_BE8A0823AF39ADE9B260":
      break;
    case "_encstr_91570A8CDEBBDCFA23380B46":
      break;
    case "_encstr_A3D70A63CA333AD78CC15832":
      break;
    case "_encstr_91DC0B4EA53BA13AD78C0E0B23":
      break;
  }
}

add_crafted_item_to_dpad(var_0, var_1, var_2) {
  switch (var_1) {
    case "_encstr_BE8A0823AF39ADE9B260":
      break;
    case "_encstr_91570A8CDEBBDCFA23380B46":
      break;
    case "_encstr_A3D70A63CA333AD78CC15832":
      break;
    case "_encstr_91DC0B4EA53BA13AD78C0E0B23":
      break;
  }
}

item_handleownerdisconnect(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify(var_0);
  self endon(var_0);
  self.owner waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  foreach(var_2 in level.players) {
    if(var_2 is_valid_player(1)) {
      self.owner = var_2;

      if(self.classname != "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0")
        self setsentryowner(self.owner);

      break;
    }
  }

  thread item_handleownerdisconnect(var_0);
}

restore_player_perk() {
  if(isDefined(self.restoreperk)) {
    giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

wait_restore_player_perk() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.05;
  restore_player_perk();
}

remove_player_perks() {
  if(_hasperk("_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B")) {
    self.restoreperk = "_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B";
    _unsetperk("_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B");
  }
}

item_timeout(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(self.lifespan))
    self.lifespan = var_1;

  if(isDefined(var_0))
    self.lifespan = var_0;

  while(self.lifespan) {
    wait 1.0;
    scripts\cp\cp_hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby))
      self.lifespan = max(0, self.lifespan - 1.0);
  }

  while(isDefined(self) && isDefined(self.inuseby))
    wait 0.05;

  if(isDefined(self.zap_model))
    self.zap_model delete();

  if(isDefined(var_2))
    self notify(var_2);
  else
    self notify("_encstr_AD75063D571AE108");
}

item_oncarrierdeath(var_0) {
  self endon("_encstr_B8B00782A191CB07D9");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = var_0 scripts\engine\utility::_id_143AD("_encstr_AD75063D571AE108", "_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 notify("_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");
}

item_oncarrierdisconnect(var_0) {
  self endon("_encstr_B8B00782A191CB07D9");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self.carriedgascan))
    self.carriedgascan delete();
  else if(isDefined(self.carriedmedusa))
    self.carriedmedusa delete();
  else if(isDefined(self.carried_trap))
    self.carried_trap delete();
  else if(isDefined(self.carriedboombox))
    self.carriedboombox delete();
  else if(isDefined(self.carried_fireworks_trap))
    self.carried_fireworks_trap delete();
  else if(isDefined(self.carriedrevocator))
    self.carriedrevocator delete();

  self delete();
}

item_ongameended(var_0) {
  self endon("_encstr_B8B00782A191CB07D9");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self delete();
}

should_be_affected_by_trap(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    return 0;

  if(!isalive(var_0))
    return 0;

  if(!isagent(var_0))
    return 0;

  if(!isDefined(var_0.agent_type))
    return 0;

  if(!isDefined(var_0.isactive) || !var_0.isactive)
    return 0;

  if(!isDefined(var_1) && isDefined(var_0.entered_playspace) && !var_0.entered_playspace)
    return 0;

  if(istrue(var_0.marked_for_death))
    return 0;

  if(!isDefined(var_0.team))
    return 0;

  if(var_0.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_0.agent_type == "_encstr_A60E0DA22F1BF540F8660F84DAD6A1" || var_0.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B")
    return 0;

  if(!istrue(var_2) && istrue(var_0.is_suicide_bomber))
    return 0;

  if(istrue(var_0.is_coaster_zombie))
    return 0;

  return 1;
}

set_quest_icon(var_0) {
  increment_num_of_quest_piece_completed();
  set_quest_icon_internal(var_0);
}

set_quest_icon_internal(var_0) {
  setomnvarbit("_encstr_A1EA13107FADF16BE2791F25CFBB699E18FF6020BF", var_0, 1);
  setclientmatchdata("_encstr_AFAA0CF20380DBE3B74B07074BCE", "_encstr_A1E30D037B15D7CB09588BB8081169" + var_0, 1);
}

set_completed_quest_mark(var_0) {
  setomnvarbit("_encstr_8E7D194F5BD7C6DEB6C136958E2B8CEB8B57ACB9A3EBAD5893B6B9", var_0, 1);
}

increment_num_of_quest_piece_completed() {
  if(!isDefined(level.num_of_quest_pieces_completed))
    level.num_of_quest_pieces_completed = 0;

  level.num_of_quest_pieces_completed++;

  if(level.num_of_quest_pieces_completed == level.cp_zmb_number_of_quest_pieces) {
    foreach(var_1 in level.players)
    var_1 scripts\cp\cp_achievement::update_achievement("_encstr_8C7B1252AD1BB8DB3D09DFA7C934848067C52D9A", 24);
  }
}

playplayerandnpcsounds(var_0, var_1, var_2) {
  var_0 playlocalsound_safe(var_1);
  var_0 playsoundtoteam(var_2, "_encstr_9A8507BA4040188D08", var_0);
  var_0 playsoundtoteam(var_2, "_encstr_8E8405EA382B2A", var_0);
}

roundup(var_0) {
  if(var_0 - int(var_0) >= 0.5)
    return int(var_0 + 1);
  else
    return int(var_0);
}

damage_over_time(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!should_apply_dot(var_0)) {
    return;
  }
  var_0 endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_3))
    var_3 = 600;

  if(!isDefined(var_2))
    var_2 = 5;

  if(!isDefined(var_4))
    var_4 = "_encstr_BDB50C41D83F8F9F030B60E80F5B";

  if(!isDefined(var_5))
    var_5 = "_encstr_86640B2DEEDCD791EDA3EB9E5B";

  if(isDefined(var_7)) {
    var_0 setscriptablestateflag(var_0, var_7, 1);

    if(isDefined(level.scriptablestatefunc))
      var_0 thread[[level.scriptablestatefunc]](var_0);
  }

  var_9 = 0;
  var_10 = 6;
  var_11 = var_2 / var_10;
  var_12 = var_3 / var_10;

  for(var_13 = 0; var_13 < var_10; var_13++) {
    wait(var_11);

    if(isalive(var_0)) {
      var_0.flame_damage_time = gettime() + 500;

      if(var_0.health - var_12 <= 0) {
        if(isDefined(var_8))
          level notify(var_8);
      }

      if(isDefined(var_1)) {
        var_0 dodamage(var_12, var_0.origin, var_1, var_1, var_4, var_5);
        continue;
      }

      var_0 dodamage(var_12, var_0.origin, undefined, undefined, var_4, var_5);
    }
  }

  if(isDefined(var_7))
    var_0 setscriptablestateflag(var_0, var_7);

  if(istrue(var_0.marked_for_death))
    var_0.marked_for_death = undefined;

  if(istrue(var_0.flame_damage_time))
    var_0.flame_damage_time = undefined;
}

setscriptablestateflag(var_0, var_1, var_2) {
  switch (var_1) {
    case "_encstr_B1170FD8DEB526A5CD562350391B0B9BB2":
    case "_encstr_B1170FD8DEB526A5CD562358391B0B9BB2":
      if(istrue(var_2))
        var_0.is_afflicted = 1;
      else
        var_0.is_afflicted = undefined;

      break;
    case "_encstr_A9B10826EAC9374BCDB3":
      if(istrue(var_2))
        var_0.is_burning = var_2;
      else
        var_0.is_burning = undefined;

      break;
    case "_encstr_A5E50C8BF312F6E8220C9148371C":
      if(istrue(var_2)) {
        var_0.is_electrified = var_2;
        var_0.allowpain = 1;
        var_0.stun_hit_time = gettime() + 3000;
      } else {
        var_0.is_electrified = undefined;
        var_0.allowpain = 0;
      }

      break;
    case "_encstr_AF9C0847F32F37622B4A":
      if(istrue(var_2))
        var_0.stunned = var_2;
      else
        var_0.stunned = undefined;

      break;
    case "_encstr_9BAD098D862B5B09EA39B9":
    case "_encstr_9BAD098D862B5B89EA39B9":
      if(istrue(var_2))
        var_0.is_chem_burning = 1;
      else
        var_0.is_chem_burning = undefined;

      break;
    default:
      break;
  }
}

door_entitylessscriptable_togglelock(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = undefined;

  if(isDefined(var_1)) {
    var_5 = getentitylessscriptablearrayinradius(undefined, undefined, var_1, 64);

    if(var_5.size > 0) {
      var_3 = undefined;

      if(var_5.size == 1) {
        var_3 = var_5[0];
        var_4 = 1;
      } else {
        var_6 = var_5.size;
        var_7 = 9999999;

        for(var_8 = 0; var_8 < var_6; var_8++) {
          var_9 = distancesquared(var_5[var_8].origin, var_1);

          if(var_9 < var_7) {
            var_7 = var_9;
            var_3 = var_5[var_8];
            var_4 = 1;
          }
        }
      }
    }
  }

  if(isDefined(var_1) && !istrue(var_4)) {
    return;
  }
  if(istrue(var_2))
    var_3 setscriptablepartstate("_encstr_B16705D9AFE22E", "_encstr_A350079E35DACF8944");

  if(var_0)
    var_3 scriptabledoorfreeze(1);
  else
    var_3 scriptabledoorfreeze(0);
}

should_apply_dot(var_0) {
  if(isDefined(var_0.agent_type) && (var_0.agent_type == "_encstr_9B07038DB1" || var_0.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_0.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B" || var_0.agent_type == "_encstr_A60E0DA22F1BF540F8660F84DAD6A1"))
    return 0;

  return 1;
}

update_trap_placement_internal(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_5 = var_2.carriedtrapoffset;
  var_6 = var_2.carriedtrapangles;
  var_7 = var_2.placementradius;
  var_8 = var_2.placementheighttolerance;
  var_9 = var_2.modelplacement;
  var_10 = var_2.modelplacementfailed;
  var_11 = var_2.placecancelablestring;
  var_12 = var_2.placestring;
  var_13 = var_2.cannotplacestring;
  var_0 endon("_encstr_B8B00782A191CB07D9");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.canbeplaced = 1;
  var_14 = -1;

  for(;;) {
    var_15 = self canplayerplacesentry(1, var_7);
    var_0.origin = var_15["_encstr_97FE07DE392D76D2CD"];
    var_0.angles = var_15["_encstr_A7610758E6CED8569B"];
    var_1.origin = var_0.origin + var_5;
    var_1.angles = var_0.angles + var_6;

    if(isDefined(self.onslide))
      var_0.canbeplaced = 0;
    else
      var_0.canbeplaced = self isonground() && var_15["_encstr_9B7C07725D17A39473"] && abs(var_0.origin[2] - self.origin[2]) < var_8;

    if(ent_is_near_equipment(var_0))
      var_0.canbeplaced = 0;

    if(isDefined(var_3) && isDefined(level.discotrap_active) && isDefined(level.dance_floor_volume)) {
      if(var_0 istouching(level.dance_floor_volume))
        var_0.canbeplaced = 0;
    }

    if(isDefined(var_15["_encstr_850E077B0BF30318B9"]))
      var_0.moving_platform = var_15["_encstr_850E077B0BF30318B9"];
    else
      var_0.moving_platform = undefined;

    if(var_0.canbeplaced != var_14) {
      if(var_0.canbeplaced) {
        if(!isDefined(var_4))
          var_1 setModel(var_9);

        if(isDefined(var_0.firstplacement))
          self forceusehinton(var_11);
        else
          self forceusehinton(var_12);
      } else {
        if(!isDefined(var_4))
          var_1 setModel(var_10);

        self forceusehinton(var_13);
      }
    }

    var_14 = var_0.canbeplaced;
    wait 0.05;
  }
}

usegrenadegesture(var_0, var_1) {
  if(var_0 cangiveandfireoffhand(var_0 getvalidtakeweapon()) && !var_0 isgestureplaying()) {
    var_0 setweaponammostock(var_1, 1);
    var_0 giveandfireoffhand(var_1);
  }
}

is_codxp() {
  return getDvar("_encstr_BAB40A1F9B6A095E57A2D2DB", "_encstr_B40101") != "_encstr_B40101";
}

too_close_to_other_interactions(var_0) {
  var_1 = sortbydistance(level.current_interaction_structs, var_0);

  if(var_1.size >= 1) {
    if(distancesquared(var_1[0].origin, var_0) < 9216)
      return 1;
  }

  return 0;
}

getweapontoswitchbackto() {
  var_0 = undefined;

  if(isDefined(self.last_weapon))
    var_0 = self.last_weapon;
  else
    var_0 = self getcurrentweapon();

  var_1 = 0;
  var_2 = level.additional_laststand_weapon_exclusion;

  if(nullweapon(var_0))
    var_1 = 1;
  else if(scripts\engine\utility::array_contains(var_2, var_0))
    var_1 = 1;
  else if(scripts\engine\utility::array_contains(var_2, var_0 getbaseweapon()))
    var_1 = 1;
  else if(is_melee_weapon(var_0, 1))
    var_1 = 1;

  if(var_1) {
    var_3 = self getweaponslistall();

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(nullweapon(var_3[var_4]))
        continue;
      else if(scripts\engine\utility::array_contains(var_2, var_3[var_4]))
        continue;
      else if(scripts\engine\utility::array_contains(var_2, var_3[var_4] getbaseweapon()))
        continue;
      else if(is_melee_weapon(var_3[var_4], 1))
        continue;
      else if(!scripts\cp\cp_weapon::isprimaryweapon(var_3[var_4]))
        continue;
      else {
        var_1 = 0;
        var_0 = var_3[var_4];
        break;
      }
    }
  }

  if(var_1) {
    var_0 = getcompleteweaponname("_encstr_AFF30DCA8B6F69F6AABB50174E4248");

    if(!self hasweapon(var_0))
      _giveweapon(var_0, undefined, undefined, 1);
  }

  return var_0;
}

getvalidtakeweapon(var_0) {
  var_1 = self getcurrentweapon();
  var_2 = 0;
  var_3 = level.additional_laststand_weapon_exclusion;

  if(isDefined(var_0))
    var_3 = scripts\engine\utility::array_combine(var_0, var_3);

  if(nullweapon(var_1))
    var_2 = 1;
  else if(isDefined(var_1.inventorytype) && var_1.inventorytype == "_encstr_A6F50BE0BADBF520E957EDF159")
    var_2 = 1;
  else if(scripts\engine\utility::array_contains(var_3, var_1))
    var_2 = 1;
  else if(scripts\engine\utility::array_contains(var_3, var_1 getbaseweapon()))
    var_2 = 1;
  else if(!turn_off_sniper_laser() && is_melee_weapon(var_1, 1))
    var_2 = 1;

  if(isDefined(self.last_valid_weapon) && self hasweapon(self.last_valid_weapon) && var_2) {
    var_1 = self.last_valid_weapon;

    if(nullweapon(var_1))
      var_2 = 1;
    else if(isDefined(var_1.inventorytype) && var_1.inventorytype == "_encstr_A6F50BE0BADBF520E957EDF159")
      var_2 = 1;
    else if(scripts\engine\utility::array_contains(var_3, var_1))
      var_2 = 1;
    else if(scripts\engine\utility::array_contains(var_3, var_1 getbaseweapon()))
      var_2 = 1;
    else if(is_melee_weapon(var_1, 1))
      var_2 = 1;
    else
      var_2 = 0;
  }

  if(var_2) {
    var_4 = self getweaponslistall();

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      if(nullweapon(var_4[var_5]))
        continue;
      else if(scripts\engine\utility::array_contains(var_3, var_4[var_5]))
        continue;
      else if(scripts\engine\utility::array_contains(var_3, var_4[var_5] getbaseweapon()))
        continue;
      else if(is_melee_weapon(var_4[var_5], 1))
        continue;
      else if(isDefined(var_4[var_5].inventorytype) && var_4[var_5].inventorytype == "_encstr_A6F50BE0BADBF520E957EDF159")
        continue;
      else {
        var_2 = 0;
        var_1 = var_4[var_5];
        break;
      }
    }
  }

  return var_1;
}

getcurrentcamoname(var_0) {
  var_1 = getweaponcamoname(var_0);

  if(!isDefined(var_1))
    return undefined;

  switch (var_1) {
    case "_encstr_993A066C0BB5B706":
      return "_encstr_8B92075E37537AA093";
    case "_encstr_AB3A0696FF8BA269":
      return "_encstr_8392077BDB70C5E2BF";
    case "_encstr_833A0660FF159815":
      return "_encstr_9B92076C2CD67B81C8";
    case "_encstr_9B3A062EC64A47F3":
      return "_encstr_999207BE56DAD70333";
    case "_encstr_863A068FCF9AF8F2":
      return "_encstr_AF92073791B590FF32";
    case "_encstr_8B3A065EA9E8EF2F":
      return "_encstr_8D9207B116ADBD0CA6";
    case "_encstr_8D3A063ED65A5743":
      return "_encstr_A59207C2810D5A52CA";
    case "_encstr_A53A068FC3490ACF":
      return "_encstr_869207668E020FCBFF";
    case "_encstr_AC3A06D82CDABD83":
      return "_encstr_A39207B7976DEA60CF";
    case "_encstr_B83A068F08A8679F":
      return "_encstr_8F9207D80B6BB7604E";
    default:
      return var_1;
  }

  return undefined;
}

add_to_notify_queue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(self.notify_queue))
    self.notify_queue = [];

  if(!isDefined(self.notify_queue[var_0]))
    self.notify_queue[var_0] = 0;
  else
    self.notify_queue[var_0]++;

  if(self.notify_queue[var_0] > 0)
    wait(0.05 * self.notify_queue[var_0]);

  if(isDefined(self))
    self notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  waittillframeend;

  if(isDefined(self)) {
    if(isDefined(self.notify_queue[var_0])) {
      self.notify_queue[var_0]--;

      if(self.notify_queue[var_0] < 1)
        self.notify_queue[var_0] = undefined;
    }
  }
}

take_fists_weapon(var_0) {
  foreach(var_2 in var_0 getweaponslistall()) {
    if(issubstr(var_2.basename, "_encstr_A3860AD02337F9349ADFF1C7"))
      var_0 takeweapon(var_2);
  }
}

playlocalsound_safe(var_0) {
  if(soundexists(var_0))
    self playlocalsound(var_0);
}

stoplocalsound_safe(var_0) {
  if(soundexists(var_0))
    self stoplocalsound(var_0);
}

playsoundatpos_safe(var_0, var_1) {
  if(soundexists(var_1))
    playsoundatpos(var_0, var_1);
}

playsoundtoplayer_safe(var_0, var_1) {
  if(soundexists(var_0))
    var_1 playsoundtoplayer(var_0, var_1);
}

agentcantbeignored() {
  return isDefined(self.agent_type) && isDefined(level.ignoreimmune) && scripts\engine\utility::array_contains(level.ignoreimmune, self.agent_type);
}

agentisfnfimmune() {
  return isDefined(self.agent_type) && isDefined(level.fnfimmune) && scripts\engine\utility::array_contains(level.fnfimmune, self.agent_type);
}

agentisinstakillimmune() {
  return isDefined(self.agent_type) && isDefined(level.instakillimmune) && scripts\engine\utility::array_contains(level.instakillimmune, self.agent_type);
}

agentisspecialzombie() {
  return isDefined(self.agent_type) && isDefined(level.specialzombie) && scripts\engine\utility::array_contains(level.specialzombie, self.agent_type);
}

firegesturegrenade(var_0, var_1) {
  var_2 = var_0 getcurrentweapon();

  if(cangiveandfireoffhand(var_2)) {
    var_0 setweaponammostock(var_1, 1);
    var_0 giveandfireoffhand(var_1);
  }
}

cangiveandfireoffhand(var_0) {
  if(!isDefined(var_0))
    return 1;

  if(isDefined(level.invalid_gesture_weapon)) {
    if(isDefined(level.invalid_gesture_weapon[getweaponbasename(var_0)]))
      return 0;
    else
      return 1;
  } else
    return 1;
}

play_interaction_gesture(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_950F128B670F1FC807F755FAE887E3E545394868";

  if(getweaponbasename(self getcurrentweapon()) != "_encstr_8E9E17A5DDCDF5832B9B2B8E9CC247B4DEDC272C5AB1FAB583")
    thread firegesturegrenade(self, var_0);
}

playerplaypickupanim(var_0) {
  self notify("_encstr_B6AE15018C8610651BC9489123EB2B885C0D89DB266C48");
  self endon("_encstr_B6AE15018C8610651BC9489123EB2B885C0D89DB266C48");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || isplayerads()) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = "_encstr_9A730FB4DDE0D79DB29B7D0796C6D65D38";

  var_1 = getcompleteweaponname("_encstr_8BBA05185F8B99");
  var_2 = self getcurrentprimaryweapon();

  if(isnullweapon(var_2, var_1)) {
    return;
  }
  if(self isgestureplaying(var_0)) {
    self stopgestureviewmodel(var_0, 0, 1);
    wait 0.05;
  }

  self forceplaygestureviewmodel(var_0);
}

playerplaytakephotoanim() {
  var_0 = "_encstr_BA6811A240D9779BCE25797BB51633FC07684A";
  var_1 = self getcurrentweapon();
  var_2 = getcompleteweaponname(var_0);
  thread _freeze_until_phototaken();
  _giveweapon(var_2);
  self switchtoweapon(var_2);
  self setclientomnvar("_encstr_9B9C0E4F4B38D3F19808276B86C82B6A", 7);
  var_3 = 3;
  wait(var_3);

  if(isPlayer(self)) {
    self takeweapon(var_2);
    self switchtoweapon(var_1);
    self setclientomnvar("_encstr_9B9C0E4F4B38D3F19808276B86C82B6A", 0);
    return 1;
  }

  return 0;
}

_freeze_until_phototaken() {
  var_0 = self getstance();
  _togglecellphoneallows(1);
  restrict_player_stance_to_this(1, var_0);
  var_1 = 1.6;
  wait(var_1);
  _togglecellphoneallows(0);
  restrict_player_stance_to_this(0, var_0);
}

_togglecellphoneallows(var_0) {
  _freezelookcontrols(var_0);
  scripts\common\utility::allow_movement(!var_0);
  scripts\common\utility::allow_jump(!var_0);
  scripts\common\utility::allow_usability(!var_0);
  scripts\common\utility::allow_melee(!var_0);
  scripts\common\utility::allow_offhand_weapons(!var_0);
  scripts\common\utility::allow_weapon_switch(!var_0);
  scripts\common\utility::allow_sprint(!var_0);
}

restrict_player_stance_to_this(var_0, var_1) {
  if(istrue(var_0))
    _player_allowed_stances(1, var_1);
  else
    _player_allowed_stances(0, var_1);
}

_player_allowed_stances(var_0, var_1) {
  if(istrue(var_0)) {
    switch (var_1) {
      case "_encstr_A5AD069B231F0BAF":
        scripts\common\utility::allow_crouch(0);
        scripts\common\utility::allow_prone(0);
        break;
      case "_encstr_B13D076BED70539F23":
        scripts\common\utility::allow_stand(0);
        scripts\common\utility::allow_prone(0);
        break;
      case "_encstr_922406F1A6FD5E05":
        scripts\common\utility::allow_crouch(0);
        scripts\common\utility::allow_stand(0);
        break;
    }
  } else {
    switch (var_1) {
      case "_encstr_A5AD069B231F0BAF":
        scripts\common\utility::allow_crouch(1);
        scripts\common\utility::allow_prone(1);
        break;
      case "_encstr_B13D076BED70539F23":
        scripts\common\utility::allow_stand(1);
        scripts\common\utility::allow_prone(1);
        break;
      case "_encstr_922406F1A6FD5E05":
        scripts\common\utility::allow_crouch(1);
        scripts\common\utility::allow_stand(1);
        break;
    }
  }
}

deactivatebrushmodel(var_0, var_1) {
  var_0 notsolid();

  if(istrue(var_1))
    var_0 hide();
}

rankingenabled() {
  if(!isPlayer(self))
    return 0;

  return level.onlinegame && !self.usingonlinedataoffline;
}

debugprintline(var_0) {}

ent_createheadicon(var_0, var_1, var_2, var_3, var_4) {
  if(!level.teambased)
    return undefined;

  if(!isDefined(var_2))
    var_2 = "_encstr_9A8507BA4040188D08";

  var_5 = deleteheadicon(var_0);
  setheadiconenemyimage(var_5, var_3);
  addclienttoheadiconmask(var_5, var_1);
  setheadiconmaxdistance(var_5, 0);
  setheadiconsnaptoedges(var_5, 2250);
  setheadiconowner(var_5, var_2);

  if(isDefined(var_4))
    setheadiconzoffset(var_5, var_4);

  removeclientfromheadiconmask(var_5, var_2);
  hideheadiconfromplayersinmask(var_5);
  thread watchheadicon(var_0, var_5);
  return var_5;
}

watchheadicon(var_0, var_1) {
  var_0 endon("_encstr_B650130C39D6B2491BD8AFF5D78DE2949F139571C9" + var_1);
  var_0 waittill("_encstr_AD75063D571AE108");
  thread ent_deleteheadicon(var_0, var_1);
}

ent_deleteheadicon(var_0, var_1) {
  var_0 notify("_encstr_B650130C39D6B2491BD8AFF5D78DE2949F139571C9" + var_1);

  if(isDefined(var_1) && var_1 != -1)
    setheadiconimage(var_1);
}

getlastweapon() {
  return self.lastweaponobj;
}

isnmlactive() {
  return istrue(level.nml_proto);
}

addtostructarray(var_0, var_1, var_2) {
  if(!isDefined(level.struct_class_names[var_0][var_1]))
    level.struct_class_names[var_0][var_1] = [];

  level.struct_class_names[var_0][var_1][level.struct_class_names[var_0][var_1].size] = var_2;
}

is_in_active_volume(var_0) {
  if(!isDefined(level.active_spawn_volumes))
    return 1;

  var_1 = sortbydistance(level.active_spawn_volumes, var_0);

  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0, var_3))
      return 1;
  }

  return 0;
}

give_max_ammo_to_player(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_0 givemaxammo(var_3);

    if(weaponmaxammo(var_3) == weaponclipsize(var_3))
      var_0 setweaponammoclip(var_3, weaponclipsize(var_3));
  }

  var_5 = getarraykeys(var_0.powers);

  foreach(var_7 in var_5) {
    if(var_0.powers[var_7].slot == "_encstr_AC8F0AE74163F85AAA380AD8") {
      continue;
    }
    var_0 thread recharge_power(var_7);
  }
}

recharge_power(var_0) {
  var_1 = self.powers[var_0].slot;

  if(istrue(self.powers[var_0].active)) {
    while(istrue(self.powers[var_0].active))
      wait 0.05;
  }

  if(istrue(self.powers[var_0].updating)) {
    while(istrue(self.powers[var_0].updating))
      wait 0.05;
  }

  thread scripts\cp\cp_powers::givepower(var_0, var_1, undefined, undefined, undefined, undefined, 1);

  if(istrue(level.secondary_power)) {
    if(isDefined(level.power_modifycooldownrate))
      self[[level.power_modifycooldownrate]](10, "_encstr_AC8F0AE74163F85AAA380AD8");
  }

  if(istrue(level.infinite_grenades)) {
    if(isDefined(level.power_modifycooldownrate))
      self[[level.power_modifycooldownrate]](100);
  }
}

objective_update(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  scripts\cp\cp_objectives::objective_update_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

obj(var_0) {
  if(!isDefined(level.objectives))
    level.objectives = [];

  if(!isDefined(level.objectives[var_0]))
    level.objectives[var_0] = level.objectives.size + 1;

  return level.objectives[var_0];
}

objective_complete(var_0) {
  scripts\cp\cp_objectives::delete_objective(var_0);
  var_1 = scripts\cp\cp_objectives::get_objective_type(var_0);

  if(isDefined(var_1)) {
    if(var_1 == "_encstr_8A5707E9C2BFCEF0ED")
      return;
  }

  scripts\cp\cp_objectives::reset_objective_omnvars(var_0);
}

hint_prompt(var_0, var_1, var_2) {
  if(istrue(var_1))
    var_3 = int(tablelookup("_encstr_915C100813DDDF135F409B37348790A7B21B", 1, var_0, 0));
  else
    var_3 = 0;

  self setclientomnvar("_encstr_A3AD0E1299C1C2EBD2554FF0C20D3A99", var_3);

  if(isDefined(var_2)) {
    wait(var_2);
    self setclientomnvar("_encstr_A3AD0E1299C1C2EBD2554FF0C20D3A99", 0);
  }
}

processed_tilt(var_0) {
  var_1 = tablelookup("_encstr_BA7613889150F9305383C0C98B53BD67DB0D3B939C", 1, var_0, 0);

  if(isDefined(var_1))
    return var_1;
  else
    return 0;
}

_id_13070(var_0, var_1) {
  var_2 = processed_tilt(var_1);
  var_3 = 1;

  if(!isDefined(var_0.get_track_setting) || var_0.get_track_setting == 0)
    var_0.get_track_setting = int(var_2);
  else {
    var_0.get_track_end_struct = int(var_2);
    var_3 = 2;
  }

  var_4 = spawnStruct();
  var_4.get_total_successful_vehicle_spawns_from_module = var_1;
  var_4.slot = var_3;
  scripts\cp\cp_globallogic::elevator_model(var_0);
  return var_4;
}

_id_12BC6(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1 == 1)
    var_0.get_track_setting = 0;
  else if(var_1 == 2)
    var_0.get_track_end_struct = 0;

  scripts\cp\cp_globallogic::elevator_model(var_0);
}

addentrytodevgui(var_0) {
  level thread addentrytodevgui_internal(var_0);
}

addentrytodevgui_internal(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_92C5119CAC85465ED7CCED4EFA8CACEC3BABA5"))
    scripts\engine\utility::flag_wait("_encstr_92C5119CAC85465ED7CCED4EFA8CACEC3BABA5");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  wait 2;
  var_1 = "_encstr_B40101";
  var_2 = strtok(var_0, "_encstr_874C029E");
  var_3 = "_encstr_974C0246";
  var_4 = 0;

  foreach(var_6 in var_2) {
    var_7 = strtok(var_6, "_encstr_974C0246");
    var_8 = 1;
    var_9 = var_7.size;

    foreach(var_11 in var_7) {
      if(var_8 < var_9)
        var_1 = var_1 + var_11 + var_3;
      else
        var_1 = var_1 + var_11;

      var_8++;
    }

    var_4++;

    if(var_4 < var_2.size)
      var_1 = var_1 + "_encstr_874C029E";
  }
}

array_sort_by_handler(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = ::defaultsortfunc;

  var_2 = istrue(var_2);

  for(var_3 = 0; var_3 < var_0.size - 1; var_3++) {
    for(var_4 = var_3 + 1; var_4 < var_0.size; var_4++) {
      if(var_2) {
        if(var_0[var_4][[var_1]]() > var_0[var_3][[var_1]]()) {
          var_5 = var_0[var_4];
          var_0[var_4] = var_0[var_3];
          var_0[var_3] = var_5;
        }

        continue;
      }

      if(var_0[var_4][[var_1]]() < var_0[var_3][[var_1]]()) {
        var_5 = var_0[var_4];
        var_0[var_4] = var_0[var_3];
        var_0[var_3] = var_5;
      }
    }
  }

  return var_0;
}

array_compare(var_0, var_1) {
  if(var_0.size != var_1.size)
    return 0;

  foreach(var_5, var_3 in var_0) {
    if(!isDefined(var_1[var_5]))
      return 0;

    var_4 = var_1[var_5];

    if(var_4 != var_3)
      return 0;
  }

  return 1;
}

defaultsortfunc(var_0, var_1) {
  return randomint(100);
}

set_segmented_health_regen_parameters(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.max_health_cap = var_0 / 100;
  var_6.min_health_cap = var_1 / 100;
  var_6.segment_size = var_2 / 100;
  var_6.pre_regen_wait = var_3;
  var_6.per_regen_amount = var_4 / 100;
  var_6.between_regen_wait = var_5;
  level.segmented_health_regen_parameters = var_6;
}

segmented_health_regen(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_BA7721E8AD757E709287A8388522BDAF581F079315E75DFF0811A2AB7934ED3FD84B54");
  var_0 endon("_encstr_BA7721E8AD757E709287A8388522BDAF581F079315E75DFF0811A2AB7934ED3FD84B54");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_1 = level.segmented_health_regen_parameters;
  var_0.max_health_cap = int(var_0.maxhealth * var_1.max_health_cap);
  var_0.min_health_cap = int(var_0.maxhealth * var_1.min_health_cap);
  var_0.segment_size = int(var_0.maxhealth * var_1.segment_size);
  var_0.pre_regen_wait = var_1.pre_regen_wait;
  var_0.per_regen_amount = int(var_0.maxhealth * var_1.per_regen_amount);
  var_0.between_regen_wait = var_1.between_regen_wait;
  set_current_health_regen_segment(var_0, var_0.max_health_cap);

  for(;;) {
    var_0 scripts\engine\utility::_id_143AD("_encstr_B2BE0788BAF573592F", "_encstr_9695073995D94BD959");
    update_current_health_regen_segment(var_0);

    if(!can_do_segmented_health_regen(var_0)) {
      continue;
    }
    var_0 thread segmented_health_regen_internal(var_0);
  }
}

segmented_health_regen_internal(var_0) {
  var_0 notify("_encstr_BD782016D1C4539D9A3B5B512990E90971742050E3106FA2983ED3E5FB4DE05010A3");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_BD782016D1C4539D9A3B5B512990E90971742050E3106FA2983ED3E5FB4DE05010A3");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_B2BE0788BAF573592F");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  wait(var_0.pre_regen_wait);

  for(;;) {
    var_0.health = int(min(int(min(var_0.health + var_0.per_regen_amount, var_0.current_health_regen_segment_ceiling)), var_0.maxhealth));

    if(var_0.health == var_0.current_health_regen_segment_ceiling) {
      return;
    }
    wait(var_0.between_regen_wait);
  }
}

set_current_health_regen_segment(var_0, var_1) {
  var_0.current_health_regen_segment_ceiling = int(var_1);
  var_0.current_health_regen_segment_floor = int(var_1 - var_0.segment_size);
}

update_current_health_regen_segment(var_0) {
  if(var_0.current_health_regen_segment_ceiling == var_0.min_health_cap) {
    return;
  }
  if(var_0.health < var_0.current_health_regen_segment_floor)
    set_current_health_regen_segment(var_0, find_new_health_regen_segment_ceiling(var_0));
}

find_new_health_regen_segment_ceiling(var_0) {
  var_1 = int((var_0.max_health_cap - var_0.min_health_cap) / var_0.segment_size);

  for(var_2 = 0; var_2 <= var_1 + 1; var_2++) {
    var_3 = var_0.min_health_cap + var_2 * var_0.segment_size;

    if(var_3 >= var_0.health)
      return int(min(var_3, var_0.maxhealth));
  }
}

can_do_segmented_health_regen(var_0) {
  if(is_segmented_health_regen_disabled(var_0))
    return 0;

  if(scripts\cp\cp_laststand::player_in_laststand(var_0))
    return 0;

  return 1;
}

is_segmented_health_regen_disabled(var_0) {
  return istrue(var_0.segmented_health_regen_disabled);
}

disable_segmented_health_regen(var_0) {
  var_0.segmented_health_regen_disabled = 1;
}

enable_segmented_health_regen(var_0) {
  var_0.segmented_health_regen_disabled = 0;
}

is_friendly_damage(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team)
      return 1;

    if(isDefined(var_1.owner) && isDefined(var_1.owner.team) && var_1.owner.team == var_0.team)
      return 1;
  }

  return 0;
}

draw_debug_rectangle(var_0, var_1) {
  var_2 = var_0[0];
  var_3 = var_1[0];
  var_4 = var_0[1];
  var_5 = var_1[1];
  var_6 = max(var_0[2], var_1[2]);
  var_7 = (var_2, var_5, var_6);
  var_8 = (var_3, var_4, var_6);
}

vehicle_createhealthbar(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2 = var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);

  if(isDefined(var_2))
    var_1 linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 190), (0, 0, 0));
  else
    var_1 linkTo(var_0);

  var_3 = vehicle_gethealthbarid();

  if(!isDefined(var_3)) {
    return;
  }
  var_0.healthbarid = var_3;
  var_4 = 1;

  if(!isDefined(level.healthbars))
    level.healthbars = [];

  level.healthbars[var_0.healthbarid] = var_1;
  setomnvar("_encstr_9B021A17FBD1D16DE7A910F79F6438822C0B0F2BF708D7D1B8E0E571" + var_0.healthbarid, var_1);
  setomnvar("_encstr_883F1B90AAE99388D731E1ED37C350478CE34960C27D2FE6F35DFFD1DF" + var_0.healthbarid, var_4);
  setomnvar("_encstr_8E251D5D5ABE4BDCB316D62B7DB1B4D91A8E7DE80B73DABE34CAB01BA30DFA" + var_0.healthbarid, 1);
}

vehicle_gethealthbarid() {
  if(!isDefined(level.healthbars))
    level.healthbars = [];

  var_0 = undefined;

  for(var_1 = 0; var_1 < 7; var_1++) {
    if(!isDefined(level.healthbars[var_1])) {
      var_0 = var_1;
      break;
    }
  }

  return var_0;
}

vehicle_freehealthbarui() {
  if(isDefined(self.healthbarid)) {
    var_0 = level.healthbars[self.healthbarid];
    var_0 delete();
    setomnvar("_encstr_9B021A17FBD1D16DE7A910F79F6438822C0B0F2BF708D7D1B8E0E571" + self.healthbarid, undefined);
    setomnvar("_encstr_8E251D5D5ABE4BDCB316D62B7DB1B4D91A8E7DE80B73DABE34CAB01BA30DFA" + self.healthbarid, 0);
    setomnvar("_encstr_883F1B90AAE99388D731E1ED37C350478CE34960C27D2FE6F35DFFD1DF" + self.healthbarid, 0);
    level.healthbars[self.healthbarid] = undefined;
    self.healthbarid = undefined;
  }
}

vehile_updatehealthbar(var_0) {
  if(isDefined(self.healthbarid))
    setomnvar("_encstr_8E251D5D5ABE4BDCB316D62B7DB1B4D91A8E7DE80B73DABE34CAB01BA30DFA" + self.healthbarid, var_0);
}

create_waypoint(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = 1.0;

  var_6 = undefined;

  if(var_2 != "_encstr_AF1904A7F929")
    var_6 = newteamhudelem(var_2);
  else
    var_6 = newhudelem();

  var_6.id = var_0;
  var_6.x = var_1[0];
  var_6.y = var_1[1];
  var_6.z = var_1[2];
  var_6.team = var_2;
  var_6.isflashing = 0;
  var_6.isshown = 1;

  if(issplitscreen())
    var_6 setshader(var_3, 8, 8);
  else
    var_6 setshader(var_3, 15, 15);

  var_6 setwaypoint(0, 1, 1);

  if(isDefined(var_4))
    var_6.alpha = var_4;
  else
    var_6.alpha = 0.75;

  var_6.basealpha = var_6.alpha;
  return var_6;
}

waypoint_delete(var_0) {
  var_0 destroy();
}

_freezecontrols(var_0, var_1, var_2) {
  if(!isDefined(self.pers)) {
    return;
  }
  if(!isDefined(self.pers["_encstr_9AC0161BF6DCD193DEC6B12B4E64935695D356D4472C36B6"]))
    self.pers["_encstr_9AC0161BF6DCD193DEC6B12B4E64935695D356D4472C36B6"] = 0;

  if(var_0)
    self.pers["_encstr_9AC0161BF6DCD193DEC6B12B4E64935695D356D4472C36B6"]++;
  else if(istrue(var_1))
    self.pers["_encstr_9AC0161BF6DCD193DEC6B12B4E64935695D356D4472C36B6"] = 0;
  else
    self.pers["_encstr_9AC0161BF6DCD193DEC6B12B4E64935695D356D4472C36B6"]--;

  if(self.pers["_encstr_9AC0161BF6DCD193DEC6B12B4E64935695D356D4472C36B6"] <= 0) {
    self.pers["_encstr_9AC0161BF6DCD193DEC6B12B4E64935695D356D4472C36B6"] = 0;
    self freezecontrols(0);
    self.controlsfrozen = 0;
  } else {
    self freezecontrols(1);
    self.controlsfrozen = 1;
  }
}

_freezelookcontrols(var_0, var_1) {
  if(!isDefined(self.pers)) {
    return;
  }
  if(!isDefined(self.pers["_encstr_9B531A53EF402BF388C88A021341CFA5D015DADD0308B74F2D0172EA"]))
    self.pers["_encstr_9B531A53EF402BF388C88A021341CFA5D015DADD0308B74F2D0172EA"] = 0;

  if(var_0)
    self.pers["_encstr_9B531A53EF402BF388C88A021341CFA5D015DADD0308B74F2D0172EA"]++;
  else if(istrue(var_1))
    self.pers["_encstr_9B531A53EF402BF388C88A021341CFA5D015DADD0308B74F2D0172EA"] = 0;
  else
    self.pers["_encstr_9B531A53EF402BF388C88A021341CFA5D015DADD0308B74F2D0172EA"]--;

  if(self.pers["_encstr_9B531A53EF402BF388C88A021341CFA5D015DADD0308B74F2D0172EA"] <= 0) {
    self.pers["_encstr_9B531A53EF402BF388C88A021341CFA5D015DADD0308B74F2D0172EA"] = 0;
    self freezelookcontrols(0);
    self.lookcontrolsfrozen = 0;
  } else {
    self freezelookcontrols(1);
    self.lookcontrolsfrozen = 1;
  }
}

_setdof_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self)) {
    return;
  }
  var_0 = max(var_0, 0.0);
  var_1 = clamp(var_1, 1.0, 9994.0);
  var_2 = clamp(var_2, 2.0, 9998.0);
  var_3 = clamp(var_3, 3.0, 9999);

  if(var_2 > 9994.0)
    var_5 = 0.0;

  self setdepthoffield(var_0, var_1, var_2, var_3, var_4, var_5);
}

setdof_dynamic() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  setdof_default();

  if(isai(self)) {
    return;
  }
  var_0 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_A60119487802A71B0FC0568F305BCBE829E016EA88DA307605DCD9"];
  var_1 = physics_createcontents(var_0);
  var_2 = ["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"];
  var_3 = physics_createcontents(var_2);
  var_4 = 1;
  var_5 = 1;
  var_6 = cos(27);
  var_7 = 1;
  var_8 = 0;
  var_9 = [];
  var_9["_encstr_88180476B2B7"] = spawnStruct();
  var_9["_encstr_88180476B2B7"].nearstartfactor = getdvarfloat("_encstr_85AB127810CF67152A9F2337E3BFEDC15F6A9FE7", 0.01);
  var_9["_encstr_88180476B2B7"].nearendfactor = getdvarfloat("_encstr_B6EF10E24894D735987BB28D0DF8316F4DE0", 0.95);
  var_9["_encstr_88180476B2B7"].farstartfactor = getdvarfloat("_encstr_81971174B8C1779FC368C1ABE83DD3BF5915F7", 1.5);
  var_9["_encstr_88180476B2B7"].farendfactor = getdvarfloat("_encstr_AA450F5AF02C5FBF20D57D2E81A987FFC0", 2.5);
  var_9["_encstr_88180476B2B7"].nearblur = getdvarfloat("_encstr_84F911D04F960635B286EEEEDDEB554EFF1F7B", 3.9);
  var_9["_encstr_88180476B2B7"].farblur = getdvarfloat("_encstr_977310C0127F5721778ADE3165D3CEFF67BA", 2.25);
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"] = spawnStruct();
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"].nearstartfactor = getdvarfloat("_encstr_BA7A0E7D952AF78825BFA0B1F37943E9", 0.01);
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"].nearendfactor = getdvarfloat("_encstr_8CD40C5A60D5C1ABA1B772BDD869", 0.95);
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"].farstartfactor = getdvarfloat("_encstr_ACE90DDF223129A007A8D1FB099363", 1.5);
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"].farendfactor = getdvarfloat("_encstr_A2E60B6AC01C4FAF30A50D3E91", 2.5);
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"].nearblur = getdvarfloat("_encstr_A6790D5AF02C5FBD2BF34A0291F8C2", 7.0);
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"].farblur = getdvarfloat("_encstr_97590CE2FF3317017638F0239512", 3.5);

  for(;;) {
    waitframe();
    var_10 = "_encstr_88180476B2B7";

    if(istrue(self.usingcustomdof)) {
      continue;
    }
    var_11 = self playerads() > 0.9;

    if(var_7 && !var_11) {
      if(var_8) {
        var_8 = 0;
        _setdof_internal(0, 0, 512, 512, 4, 0);
      }

      continue;
    }

    var_12 = self getEye();
    var_13 = self getplayerangles();
    var_14 = anglesToForward(var_13);
    var_15 = -1;
    var_16 = undefined;
    var_17 = undefined;
    var_18 = undefined;
    var_19 = undefined;

    if(var_4) {
      var_20 = 0;

      foreach(var_22 in level.players) {
        if(!scripts\cp_mp\utility\player_utility::playersareenemies(self, var_22)) {
          continue;
        }
        if(!var_22 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        var_23 = var_22 getEye();
        var_24 = vectordot(var_14, vectorNormalize(var_23 - var_12));

        if(var_24 < var_6) {
          continue;
        }
        var_25 = distance(var_12, var_23);

        if(!isDefined(var_16) || var_25 < var_16) {
          if(var_22 sightconetrace(var_12, self) > 0)
            var_16 = var_25;
        }

        if(!isDefined(var_17) || var_25 > var_17) {
          if(var_22 sightconetrace(var_12, self) > 0)
            var_17 = var_25;
        }
      }
    }

    var_27 = var_12 + var_14 * 10000;
    var_28 = scripts\engine\trace::sphere_trace(var_12, var_27, 0.1, self, var_1, 0);
    var_19 = distance(var_12, var_28["_encstr_BD260953AA97E3F014279D"]);
    var_29 = scripts\engine\trace::sphere_trace(var_12, var_27, 20.0, self, var_3, 0);
    var_30 = var_29["_encstr_850E077B0BF30318B9"];
    var_31 = isDefined(var_30) && isPlayer(var_30) && scripts\cp_mp\utility\player_utility::playersareenemies(self, var_30);
    var_32 = var_31 && var_30 sightconetrace(var_12, self) > 0;

    if(!isDefined(var_16) || var_19 < var_16)
      var_16 = var_19;

    if(!isDefined(var_17) || var_19 > var_17)
      var_17 = var_19;

    var_8 = 1;
    var_33 = max(abs(var_16 - var_17) * 0.5, 300.0);
    var_34 = 0.0;
    var_35 = max(var_16 - 50.0, 1.0);
    var_36 = var_17 + 50.0;
    var_37 = var_36 + var_33;
    var_38 = scripts\engine\utility::ter_op(var_32, 6.0, 4.0);
    var_39 = scripts\engine\utility::ter_op(var_32, 2.5, 1.25);
    _setdof_internal(var_34, var_35, var_36, var_37, var_38, var_39);
  }
}

setdof_killer() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.usingcustomdof = 1;
  setdof_killer_update();
  setdof_default();
}

setdof_killer_update() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8D831549924785F861D46379F9D07944CFBA6053AA8F35");
  var_0 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_A60119487802A71B0FC0568F305BCBE829E016EA88DA307605DCD9"];
  var_1 = physics_createcontents(var_0);
  var_2 = vectorNormalize(self.origin - self.lastkilledby.origin);
  var_3 = self.origin + (0, 0, 42);
  var_4 = var_3 + var_2 * 120.0;
  var_5 = scripts\engine\trace::sphere_trace(var_3, var_4, 2.0, self, var_1, 0);
  var_6 = var_5["_encstr_BD260953AA97E3F014279D"];

  while(istrue(self.usingcustomdof)) {
    if(!isDefined(self.lastkilledby)) {
      break;
    }

    var_7 = distance(var_6, self.lastkilledby.origin);
    var_8 = 0.0;
    var_9 = max(var_7 - 12.0, 1.0);
    var_10 = var_7 + 12.0;
    var_11 = var_10 + 50.0;
    var_12 = 8.0;
    var_13 = 4.5;
    _setdof_internal(var_8, var_9, var_10, var_11, var_12, var_13);
    waitframe();
  }
}

setdof_default() {
  self.usingcustomdof = 0;
  _setdof_internal(0, 0, 512, 512, 4, 0);
}

setdof_spectator() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 128, 512, 4000, 6, 1.8);
}

setdof_infil() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 128, 512, 4000, 6, 1.8);
}

setdof_apache() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 7, 3.5);
}

setdof_cruisethird() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 7, 3.5);
}

setdof_cruisefirst() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 1000, 7, 0);
}

setdof_tank() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 120, 1000, 6500, 7, 3.5);
}

setdof_thirdperson() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 110, 512, 4096, 6, 1.8);
}

draw_line_until_endons(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_4)) {
    if(isarray(var_4)) {
      foreach(var_7 in var_4)
      self endon(var_7);
    } else
      self endon(var_4);
  }

  if(!isDefined(var_5))
    var_5 = var_0 + (0, 0, 256);

  for(;;)
    waitframe();
}

play_sound_on_tag(var_0, var_1) {
  if(isDefined(var_1))
    playsoundatpos(self gettagorigin(var_1), var_0);
  else
    playsoundatpos(self.origin, var_0);
}

get_point_in_local_ent_space(var_0, var_1) {
  var_2 = var_0.origin;
  var_3 = anglestoup(var_0.angles);
  var_4 = anglestoleft(var_0.angles);
  var_5 = anglesToForward(var_0.angles);
  var_6 = var_1[0] * var_5[0] + var_1[1] * var_4[0] + var_1[2] * var_3[0] + var_2[0];
  var_7 = var_1[0] * var_5[1] + var_1[1] * var_4[1] + var_1[2] * var_3[1] + var_2[1];
  var_8 = var_1[0] * var_5[2] + var_1[1] * var_4[2] + var_1[2] * var_3[2] + var_2[2];
  var_9 = (var_6, var_7, var_8);
  return var_9;
}

_scriptnoteworthycheck(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_1))
    return 0;

  if(!isDefined(var_0.script_noteworthy))
    return 0;

  if(var_0.script_noteworthy != var_1)
    return 0;

  return 1;
}

show_self_pressed_buttons() {
  for(;;) {
    var_0 = "_encstr_B40101";

    if(self buttonPressed("_encstr_91D609E97F4BE94F26CF53"))
      var_0 = var_0 + "_encstr_B20703ACC3";

    if(self buttonPressed("_encstr_A1610CC5152B99900BD96D352027"))
      var_0 = var_0 + "_encstr_ADA40761CEBA4B4656";

    if(self stancebuttonPressed())
      var_0 = var_0 + "_encstr_85CC088AA0B321A28FFD";

    if(self useButtonPressed())
      var_0 = var_0 + "_encstr_849505A6C88707";

    if(self fragButtonPressed())
      var_0 = var_0 + "_encstr_A93706BEEB82683A";

    if(self meleeButtonPressed())
      var_0 = var_0 + "_encstr_A28E0761DA59B195B2";

    if(self jumpbuttonPressed())
      var_0 = var_0 + "_encstr_A2D606B58A2B12B8";

    if(self attackButtonPressed())
      var_0 = var_0 + "_encstr_950F08014B3B49403787";

    if(self secondaryoffhandbuttonPressed())
      var_0 = var_0 + "_encstr_91970BB19BBFF8686392E18B2B";

    if(self adsButtonPressed())
      var_0 = var_0 + "_encstr_869505C1869077";

    self iprintln(var_0);
    wait 0.05;
  }
}

remove_cursor_hint() {
  var_0 = self;

  if(isDefined(self.cursor_hint_ent)) {
    var_0 = self.cursor_hint_ent;
    var_0 scripts\engine\utility::delaycall(0.5, ::delete);
  }

  if(isDefined(var_0) && !isstruct(var_0))
    var_0 makeunusable();

  if(isDefined(self))
    notify_delay("_encstr_A2A10F864BE61DD74656B9479CDBE52B91", 0.05);
}

notify_delay(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  if(var_1 > 0)
    wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  self notify(var_0);
}

create_cursor_hint(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = self;

  if(isstruct(var_14) || var_14.classname == "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9" || isDefined(var_1)) {
    var_14 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
    self.cursor_hint_ent = var_14;
    thread hint_ent_notify_trigger();
  }

  if(isDefined(var_1)) {
    var_15 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";

    if(isDefined(var_0)) {
      var_15 = var_0;
      var_14.origin = self gettagorigin(var_15);
    }

    if(isDefined(self.model) && self.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0" && scripts\engine\utility::hastag(self.model, var_15))
      var_14 linkTo(self, var_15, var_1, (0, 0, 0));
    else if(isDefined(var_0))
      var_14 linkTo(self, var_15, var_1, (0, 0, 0));
    else if(isDefined(self.angles)) {
      var_14.origin = var_14.origin + rotatevector(var_1, self.angles);

      if(isent(self))
        var_14 linkTo(self);
    } else {
      var_14.origin = var_14.origin + var_1;

      if(isent(self))
        var_14 linkTo(self);
    }
  } else if(isDefined(var_0))
    var_14 sethinttag(var_0);

  if(isDefined(var_8) && var_8)
    var_14 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  else
    var_14 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");

  if(isDefined(var_2))
    var_14 setHintString(var_2);

  var_16 = 360;

  if(isDefined(var_3))
    var_16 = var_3;

  var_14 sethintdisplayfov(var_16);
  var_17 = 65;

  if(isDefined(var_13))
    var_17 = var_13;

  var_14 setusefov(var_17);
  var_18 = 500;

  if(isDefined(var_4))
    var_18 = var_4;

  var_14 sethintdisplayrange(var_18);
  var_19 = 80;

  if(isDefined(var_5))
    var_19 = var_5;

  var_14 setuserange(var_19);

  if(isDefined(var_6) && var_6)
    var_14 sethintonobstruction("_encstr_BD1805CB69C063");
  else
    var_14 sethintonobstruction("_encstr_BECC055CF3811A");

  if(isDefined(var_7) && var_7)
    var_14 sethintrequiresmashing(var_7);

  if(!isDefined(var_10))
    var_10 = "_encstr_82370F09B522B08D175A6876A32BC8E07B";

  var_14 setuseholdduration(var_10);

  if(var_10 == "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD" || var_10 == "_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9")
    var_14 sethintrequiresholding(1);

  thread hint_delete_on_trigger();

  if(isDefined(var_9))
    var_14 sethinticon(var_9);

  if(isDefined(var_11))
    var_14 setusecommand(var_11);

  if(isDefined(var_12))
    var_14 sethintlockplayermovement(1);
  else
    var_14 sethintlockplayermovement(0);

  var_14 makeusable();
  return var_14;
}

hint_ent_notify_trigger() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A2A10F864BE61DD74656B9479CDBE52B91");
  self.cursor_hint_ent waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
  self notify("_encstr_8F5C086405E70FBA4B4A", var_0);
}

hint_delete_on_trigger() {
  self endon("_encstr_A2A10F864BE61DD74656B9479CDBE52B91");
  var_0 = self;

  if(isDefined(self.cursor_hint_ent))
    var_0 = self.cursor_hint_ent;

  hint_delete_on_trigger_waittill(var_0);
  thread remove_cursor_hint();
}

hint_delete_on_trigger_waittill(var_0) {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
}

outline_fade_alpha_for_index(var_0, var_1, var_2) {
  thread outline_fade_alpha_for_index_internal(var_0, var_1, var_2);
}

outline_fade_alpha_for_index_internal(var_0, var_1, var_2) {
  level notify("_encstr_B4F018D0D5467DDE57D163B473CAFA58D883862CEB33C28CB2D7" + var_0);
  level endon("_encstr_B4F018D0D5467DDE57D163B473CAFA58D883862CEB33C28CB2D7" + var_0);
  var_0++;
  var_3 = "_encstr_AC0B17772F418310A411207BC384B8C85A67EFE7FBAA5618C7" + var_0;
  var_4 = getDvar(var_3);
  var_4 = strtok(var_4, "_encstr_974C0246");
  var_5 = var_4[0] + "_encstr_974C0246" + var_4[1] + "_encstr_974C0246" + var_4[2] + "_encstr_974C0246";
  var_6 = float(var_4[3]);
  var_7 = var_1 - var_6;
  var_8 = 0.05;
  var_9 = int(var_2 / var_8);

  if(var_9 > 0) {
    for(var_10 = var_7 / var_9; var_9; var_9--) {
      var_6 = var_6 + var_10;
      var_6 = clamp(var_6, 0, 1);
      setsaveddvar(var_3, var_5 + var_6);
      wait(var_8);
    }
  }

  setsaveddvar(var_3, var_5 + var_1);
}

add_wait(var_0, var_1, var_2, var_3) {
  init_waits();
  var_4 = spawnStruct();
  var_4.caller = self;
  var_4.func = var_0;
  var_4.parms = [];

  if(isDefined(var_1))
    var_4.parms[var_4.parms.size] = var_1;

  if(isDefined(var_2))
    var_4.parms[var_4.parms.size] = var_2;

  if(isDefined(var_3))
    var_4.parms[var_4.parms.size] = var_3;

  if(!isDefined(level.waits.wait_any_func_array))
    level.waits.wait_any_func_array = [var_4];
  else
    level.waits.wait_any_func_array[level.waits.wait_any_func_array.size] = var_4;
}

init_waits() {
  if(!scripts\engine\utility::add_init_script("_encstr_A94D06770B5A3ACD", ::init_waits)) {
    return;
  }
  level.waits = spawnStruct();
  level.waits.wait_any_func_array = [];
  level.waits.run_func_after_wait_array = [];
  level.waits.run_call_after_wait_array = [];
  level.waits.run_noself_call_after_wait_array = [];
  level.waits.do_wait_endons_array = [];
  level.waits.abort_wait_any_func_array = [];
}

add_wait_asserter() {
  level notify("_encstr_87A517B750904CD1EB1D2FE9FC93CA1C9E885F6F988BACBAE5");
  level endon("_encstr_87A517B750904CD1EB1D2FE9FC93CA1C9E885F6F988BACBAE5");

  for(var_0 = 0; var_0 < 20; var_0++)
    waittillframeend;
}

do_wait_any() {
  init_waits();
  do_wait(level.waits.wait_any_func_array.size - 1);
}

do_wait(var_0) {
  init_waits();

  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = spawnStruct();
  var_2 = level.waits.wait_any_func_array;
  var_3 = level.waits.do_wait_endons_array;
  var_4 = level.waits.run_func_after_wait_array;
  var_5 = level.waits.run_call_after_wait_array;
  var_6 = level.waits.run_noself_call_after_wait_array;
  var_7 = level.waits.abort_wait_any_func_array;
  level.waits.wait_any_func_array = [];
  level.waits.run_func_after_wait_array = [];
  level.waits.do_wait_endons_array = [];
  level.waits.abort_wait_any_func_array = [];
  level.waits.run_call_after_wait_array = [];
  level.waits.run_noself_call_after_wait_array = [];
  var_1.count = var_2.size;
  var_1 scripts\engine\utility::array_levelthread(var_2, ::waittill_func_ends, var_3);
  var_1 thread do_abort(var_7);
  var_1 endon("_encstr_A56212C2B9CBD7CC57E636377DC213EDC98E2B23");

  for(;;) {
    if(var_1.count <= var_0) {
      break;
    }

    var_1 waittill("_encstr_91380B206D534BE75235679BE7");
  }

  var_1 notify("_encstr_8D2F106163B928217D6B8FEF1F3B90336A4D");
  scripts\engine\utility::array_levelthread(var_4, ::exec_func, []);
  scripts\engine\utility::array_levelthread(var_5, ::exec_call);
  scripts\engine\utility::array_levelthread(var_6, ::exec_call_noself);
}

exec_call(var_0) {
  if(var_0.parms.size == 0)
    var_0.caller call[[var_0.func]]();
  else if(var_0.parms.size == 1)
    var_0.caller call[[var_0.func]](var_0.parms[0]);
  else if(var_0.parms.size == 2)
    var_0.caller call[[var_0.func]](var_0.parms[0], var_0.parms[1]);
  else if(var_0.parms.size == 3)
    var_0.caller call[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2]);

  if(var_0.parms.size == 4)
    var_0.caller call[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3]);

  if(var_0.parms.size == 5)
    var_0.caller call[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3], var_0.parms[4]);
}

exec_call_noself(var_0) {
  if(var_0.parms.size == 0)
    call[[var_0.func]]();
  else if(var_0.parms.size == 1)
    call[[var_0.func]](var_0.parms[0]);
  else if(var_0.parms.size == 2)
    call[[var_0.func]](var_0.parms[0], var_0.parms[1]);
  else if(var_0.parms.size == 3)
    call[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2]);

  if(var_0.parms.size == 4)
    call[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3]);

  if(var_0.parms.size == 5)
    call[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3], var_0.parms[4]);
}

exec_func(var_0, var_1) {
  if(!isDefined(var_0.caller)) {
    return;
  }
  for(var_2 = 0; var_2 < var_1.size; var_2++)
    var_1[var_2].caller endon(var_1[var_2].ender);

  if(var_0.parms.size == 0)
    var_0.caller[[var_0.func]]();
  else if(var_0.parms.size == 1)
    var_0.caller[[var_0.func]](var_0.parms[0]);
  else if(var_0.parms.size == 2)
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1]);
  else if(var_0.parms.size == 3)
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2]);

  if(var_0.parms.size == 4)
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3]);

  if(var_0.parms.size == 5)
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3], var_0.parms[4]);
}

do_abort(var_0) {
  self endon("_encstr_8D2F106163B928217D6B8FEF1F3B90336A4D");

  if(!var_0.size) {
    return;
  }
  var_1 = 0;
  self.abort_count = var_0.size;
  var_2 = [];
  scripts\engine\utility::array_levelthread(var_0, ::waittill_abort_func_ends, var_2);

  for(;;) {
    if(self.abort_count <= var_1) {
      break;
    }

    self waittill("_encstr_A98A115812FABB83EFD49DA8A890C537E977E7");
  }

  self notify("_encstr_A56212C2B9CBD7CC57E636377DC213EDC98E2B23");
}

waittill_abort_func_ends(var_0, var_1) {
  self endon("_encstr_8D2F106163B928217D6B8FEF1F3B90336A4D");
  self endon("_encstr_A56212C2B9CBD7CC57E636377DC213EDC98E2B23");
  exec_func(var_0, var_1);
  self.abort_count--;
  self notify("_encstr_A98A115812FABB83EFD49DA8A890C537E977E7");
}

waittill_func_ends(var_0, var_1) {
  self endon("_encstr_8D2F106163B928217D6B8FEF1F3B90336A4D");
  self endon("_encstr_A56212C2B9CBD7CC57E636377DC213EDC98E2B23");
  exec_func(var_0, var_1);
  self.count--;
  self notify("_encstr_91380B206D534BE75235679BE7");
}

waittill_msg(var_0) {
  self waittill(var_0);
}

create_client_overlay(var_0, var_1, var_2) {
  if(isDefined(var_2))
    var_3 = newclienthudelem(var_2);
  else
    var_3 = newhudelem();

  var_3.x = 0;
  var_3.y = 0;
  var_3 setshader(var_0, 640, 480);
  var_3.alignx = "_encstr_A5AD056A019C63";
  var_3.aligny = "_encstr_AC190479FF92";
  var_3.sort = 1;
  var_3.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_3.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_3.alpha = var_1;
  var_3.foreground = 1;
  return var_3;
}

createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = undefined;

  if(isDefined(var_11))
    var_12 = var_11;
  else
    var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);

  var_12 sethintobject(undefined, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  if(!isDefined(var_4))
    var_12 setusepriority(0);

  if(!isDefined(var_11))
    return var_12;
}

clearhintobject(var_0) {}

get_actual_time_from_civil(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_1))
    var_3 = var_1;
  else {
    var_3 = getsystemtime();

    if(isDefined(level.isdaylightsavings) && level.isdaylightsavings)
      var_3 = var_3 + 3600;
  }

  if(isDefined(var_0))
    var_3 = var_3 - 3600 * var_0;

  var_4 = 1970;
  var_5 = floor(var_3 / 31536000);

  if(var_5 != 0)
    var_6 = floor((var_5 + 2) / 4);
  else
    var_6 = 0;

  var_3 = var_3 - var_5 * 31536000;
  var_3 = var_3 - var_6 * 86400;
  var_4 = var_4 + var_5;

  if(!is_divisible_by(var_4, 4)) {
    var_7 = floor(var_5 / 4);
    var_8 = var_5 / 4;
    var_9 = var_8 - var_7;

    if(var_9 >= 0.75)
      var_10 = 1;
    else
      var_10 = 0;
  } else
    var_10 = 0;

  if(var_3 != 0) {
    var_11 = floor(var_3 / 86400);
    var_3 = var_3 - var_11 * 86400;
  } else
    var_11 = 0;

  if(var_3 != 0) {
    var_12 = floor(var_3 / 3600);
    var_3 = var_3 - var_12 * 3600;
  } else
    var_12 = 0;

  if(var_3 != 0) {
    var_13 = floor(var_3 / 60);
    var_3 = var_3 - var_13 * 60;
  } else
    var_13 = 0;

  var_14 = determine_correct_month(var_11 + 1, var_10);
  var_14["_encstr_824905270B0F9B"] = var_4;
  var_14["_encstr_877B067A570DB8DE"] = var_12;
  var_14["_encstr_BEC3088821F5EBF4B7E3"] = var_13;
  var_14["_encstr_8D9F08CD5936BDB9C8B9"] = var_3;

  if(isDefined(var_2))
    return var_14;

  if(isDefined(level.isdaylightsavings)) {
    level notify("_encstr_93FC0B6B60F37F5F7123756B4A", var_4, var_14["_encstr_87300D0A30E833FC11178C72DB60C7"], var_14["_encstr_8B6705A5BE33C3"], var_12, var_13, var_3);
    return var_14;
  } else {
    var_14 = is_daylight_savings(var_14, var_0, var_1);
    level notify("_encstr_93FC0B6B60F37F5F7123756B4A", var_4, var_14["_encstr_87300D0A30E833FC11178C72DB60C7"], var_14["_encstr_8B6705A5BE33C3"], var_12, var_13, var_3);
    return var_14;
  }
}

is_daylight_savings(var_0, var_1, var_2) {
  var_3 = 0;

  if(var_0["_encstr_87300D0A30E833FC11178C72DB60C7"] == "_encstr_A1A406E9921A4F80" && var_0["_encstr_824905270B0F9B"] == 2017)
    var_3 = 1;
  else if(var_0["_encstr_87300D0A30E833FC11178C72DB60C7"] == "_encstr_91EA09882B362B6B4C954E" || var_0["_encstr_87300D0A30E833FC11178C72DB60C7"] == "_encstr_A92E08644725AB614BC0" || var_0["_encstr_87300D0A30E833FC11178C72DB60C7"] == "_encstr_82F609DE25D95BD34B10EB")
    var_3 = 0;
  else if(var_0["_encstr_87300D0A30E833FC11178C72DB60C7"] != "_encstr_A1A406E9921A4F80" && var_0["_encstr_87300D0A30E833FC11178C72DB60C7"] != "_encstr_8CA406A0981B400D")
    var_3 = 1;
  else if(var_0["_encstr_87300D0A30E833FC11178C72DB60C7"] == "_encstr_A1A406E9921A4F80" && var_0["_encstr_8B6705A5BE33C3"] >= 14)
    var_3 = 1;
  else if(var_0["_encstr_87300D0A30E833FC11178C72DB60C7"] == "_encstr_85C709A0E753214B0ECA30" && var_0["_encstr_8B6705A5BE33C3"] <= 6)
    var_3 = 0;
  else
    var_3 = 0;

  if(var_3) {
    level.isdaylightsavings = 1;
    var_0 = get_actual_time_from_civil(var_1, var_2, 1);
  } else
    level.isdaylightsavings = 0;

  return var_0;
}

does_day_fit_in_current_month(var_0, var_1, var_2) {
  var_3 = 30;

  switch (var_1) {
    case "_encstr_A92E08644725AB614BC0":
      var_3 = 31;
      break;
    case "_encstr_82F609DE25D95BD34B10EB":
      if(var_2)
        var_3 = 29;
      else
        var_3 = 28;

      break;
    case "_encstr_A1A406E9921A4F80":
      var_3 = 31;
      break;
    case "_encstr_8CA406A0981B400D":
      var_3 = 30;
      break;
    case "_encstr_8E19049D7FE2":
      var_3 = 31;
      break;
    case "_encstr_95DD054C5B6620":
      var_3 = 30;
      break;
    case "_encstr_84DD05D005BA9B":
      var_3 = 31;
      break;
    case "_encstr_8C650714EA765DB98E":
      var_3 = 31;
      break;
    case "_encstr_85D70A9B62A335E05B4A3B4A":
      var_3 = 30;
      break;
    case "_encstr_BEF1081518FB5D42909D":
      var_3 = 31;
      break;
    case "_encstr_85C709A0E753214B0ECA30":
      var_3 = 30;
      break;
    case "_encstr_91EA09882B362B6B4C954E":
      var_3 = 31;
      break;
    default:
      break;
  }

  if(var_0 > var_3)
    return 1;
  else
    return 0;
}

determine_correct_month(var_0, var_1) {
  var_2 = [];
  var_2["_encstr_849306B218BD43FB"] = undefined;
  var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = undefined;
  var_2["_encstr_8B6705A5BE33C3"] = undefined;
  var_3 = int(istrue(var_1));

  if(var_0 <= 31) {
    var_2["_encstr_849306B218BD43FB"] = 1;
    var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = "_encstr_A92E08644725AB614BC0";
    var_2["_encstr_8B6705A5BE33C3"] = var_0;
    return var_2;
  } else if(var_0 <= 59 + var_3) {
    var_2["_encstr_849306B218BD43FB"] = 2;
    var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = "_encstr_82F609DE25D95BD34B10EB";
    var_2["_encstr_8B6705A5BE33C3"] = var_0 - 31;
    return var_2;
  } else if(var_0 <= 90 + var_3) {
    var_2["_encstr_849306B218BD43FB"] = 3;
    var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = "_encstr_A1A406E9921A4F80";
    var_2["_encstr_8B6705A5BE33C3"] = var_0 - (59 + var_3);
    return var_2;
  } else if(var_0 <= 120 + var_3) {
    var_2["_encstr_849306B218BD43FB"] = 4;
    var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = "_encstr_8CA406A0981B400D";
    var_2["_encstr_8B6705A5BE33C3"] = var_0 - (90 + var_3);
    return var_2;
  } else if(var_0 <= 151 + var_3) {
    var_2["_encstr_849306B218BD43FB"] = 5;
    var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = "_encstr_8E19049D7FE2";
    var_2["_encstr_8B6705A5BE33C3"] = var_0 - (120 + var_3);
    return var_2;
  } else if(var_0 <= 182 + var_3) {
    var_2["_encstr_849306B218BD43FB"] = 6;
    var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = "_encstr_95DD054C5B6620";
    var_2["_encstr_8B6705A5BE33C3"] = var_0 - (151 + var_3);
    return var_2;
  } else if(var_0 <= 212 + var_3) {
    var_2["_encstr_849306B218BD43FB"] = 7;
    var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = "_encstr_84DD05D005BA9B";
    var_2["_encstr_8B6705A5BE33C3"] = var_0 - (182 + var_3);
    return var_2;
  } else if(var_0 <= 243 + var_3) {
    var_2["_encstr_849306B218BD43FB"] = 8;
    var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = "_encstr_8C650714EA765DB98E";
    var_2["_encstr_8B6705A5BE33C3"] = var_0 - (212 + var_3);
    return var_2;
  } else if(var_0 <= 273 + var_3) {
    var_2["_encstr_849306B218BD43FB"] = 9;
    var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = "_encstr_85D70A9B62A335E05B4A3B4A";
    var_2["_encstr_8B6705A5BE33C3"] = var_0 - (243 + var_3);
    return var_2;
  } else if(var_0 <= 304 + var_3) {
    var_2["_encstr_849306B218BD43FB"] = 10;
    var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = "_encstr_99F108E96CD17B26BD4E";
    var_2["_encstr_8B6705A5BE33C3"] = var_0 - (273 + var_3);
    return var_2;
  } else if(var_0 <= 335 + var_3) {
    var_2["_encstr_849306B218BD43FB"] = 11;
    var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = "_encstr_85C709A0E753214B0ECA30";
    var_2["_encstr_8B6705A5BE33C3"] = var_0 - (304 + var_3);
    return var_2;
  } else {
    var_2["_encstr_849306B218BD43FB"] = 12;
    var_2["_encstr_87300D0A30E833FC11178C72DB60C7"] = "_encstr_91EA09882B362B6B4C954E";
    var_2["_encstr_8B6705A5BE33C3"] = var_0 - (335 + var_3);
    return var_2;
  }
}

set_friendlyfire_warnings(var_0) {
  if(var_0)
    self.friendlyfire_warnings_disable = undefined;
  else
    self.friendlyfire_warnings_disable = 1;
}

battlechatter_on(var_0) {
  thread battlechatter_on_thread(var_0);
}

battlechatter_on_thread(var_0) {
  level endon("_encstr_97C519B6E95B0349CFAAE0A0F3A3039B9F9FCC3C7FE348BD3792B8");
  scripts\cp\cp_battlechatter::bcs_setup_chatter_toggle_array();

  while(!isDefined(anim.chatinitialized))
    waitframe();

  anim.bcs_enabled = 1;
  wait 1.5;

  if(isDefined(var_0)) {
    scripts\cp\cp_battlechatter::set_battlechatter_variable(var_0, 1);
    var_1 = getaiarray(var_0);
  } else {
    foreach(var_0 in anim.teams)
    scripts\cp\cp_battlechatter::set_battlechatter_variable(var_0, 1);

    var_1 = getaiarray();
  }

  if(isDefined(level.jackal) && isDefined(level.jackal.active_jackals))
    var_1 = scripts\engine\utility::array_combine(var_1, level.jackal.active_jackals);

  for(var_4 = 0; var_4 < var_1.size; var_4++)
    var_1[var_4] set_battlechatter(1);
}

set_battlechatter(var_0) {
  if(!isDefined(anim.chatinitialized) || !anim.chatinitialized) {
    return;
  }
  if(istrue(self.battlechatter_removed)) {
    return;
  }
  if(var_0) {
    if(isDefined(self.script_bcdialog) && !self.script_bcdialog)
      self.battlechatterallowed = 0;
    else
      self.battlechatterallowed = 1;
  } else {
    self.battlechatterallowed = 0;

    if(isDefined(self.battlechatter) && istrue(self.battlechatter.isspeaking))
      self waittill("_encstr_B4650E6A50F57FA2732F75694AD85307");
  }
}

getvehiclearray() {
  return vehicle_getarray();
}

get_player_from_self() {
  if(isDefined(self)) {
    if(!scripts\engine\utility::array_contains(level.players, self))
      return level.player;
    else
      return self;
  } else
    return level.players[0];
}

player_looking_at(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 0.8;

  var_4 = get_player_from_self();
  var_5 = var_4 getEye();
  var_6 = vectortoangles(var_0 - var_5);
  var_7 = anglesToForward(var_6);
  var_8 = var_4 getplayerangles();
  var_9 = anglesToForward(var_8);
  var_10 = vectordot(var_7, var_9);

  if(var_10 < var_1)
    return 0;

  if(isDefined(var_2))
    return 1;

  return scripts\engine\trace::ray_trace_detail_passed(var_0, var_5, var_3, scripts\engine\trace::create_default_contents(1));
}

is_divisible_by(var_0, var_1) {
  if(floor(var_0 / var_1) > var_0 / var_1)
    return 1;
  else
    return 0;
}

array_merge(var_0, var_1) {
  if(var_0.size == 0)
    return var_1;

  if(var_1.size == 0)
    return var_0;

  var_2 = var_0;

  foreach(var_4 in var_1) {
    var_5 = 0;

    foreach(var_7 in var_0) {
      if(var_7 == var_4) {
        var_5 = 1;
        break;
      }
    }

    if(var_5)
      continue;
    else
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

create_sunflare_setting(var_0) {
  if(!isDefined(level.sunflare_settings))
    level.sunflare_settings = [];

  var_1 = spawnStruct();
  var_1.name = var_0;
  level.sunflare_settings[var_0] = var_1;
  return var_1;
}

vectortoanglessafe(var_0, var_1) {
  var_2 = vectorcross(var_0, var_1);
  var_1 = vectorcross(var_2, var_0);
  var_3 = axistoangles(var_0, var_2, var_1);
  return var_3;
}

createuseent(var_0) {
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);
  var_1.curprogress = 0;
  var_1.usetime = 0;
  var_1.userate = 8000;
  var_1.inuse = 0;
  return var_1;
}

getinteractionbynoteworthy(var_0) {
  foreach(var_2 in level.current_interaction_structs) {
    if(var_2.script_noteworthy == var_0)
      return var_2;
  }

  return undefined;
}

quicksort(var_0, var_1) {
  return quicksortmid(var_0, 0, var_0.size - 1, var_1);
}

quicksortmid(var_0, var_1, var_2, var_3) {
  var_4 = var_1;
  var_5 = var_2;

  if(!isDefined(var_3))
    var_3 = ::quicksort_compare;

  if(var_2 - var_1 >= 1) {
    var_6 = var_0[var_1];

    while(var_5 > var_4) {
      while([[var_3]](var_0[var_4].patrolscore, var_6.patrolscore) && var_4 <= var_2 && var_5 > var_4)
        var_4++;

      while(![[var_3]](var_0[var_5].patrolscore, var_6.patrolscore) && var_5 >= var_1 && var_5 >= var_4)
        var_5--;

      if(var_5 > var_4)
        var_0 = swap(var_0, var_4, var_5);
    }

    var_0 = swap(var_0, var_1, var_5);
    var_0 = quicksortmid(var_0, var_1, var_5 - 1, var_3);
    var_0 = quicksortmid(var_0, var_5 + 1, var_2, var_3);
  } else
    return var_0;

  return var_0;
}

quicksort_compare(var_0, var_1) {
  return var_0 <= var_1;
}

swap(var_0, var_1, var_2) {
  var_3 = var_0[var_1];
  var_0[var_1] = var_0[var_2];
  var_0[var_2] = var_3;
  return var_0;
}

hideminimap(var_0) {
  if(!isDefined(self.minimapstatetracker))
    self.minimapstatetracker = 0;

  var_1 = self.minimapstatetracker;
  self.minimapstatetracker--;

  if(self.minimapstatetracker < 0)
    self.minimapstatetracker = 0;

  if(istrue(var_0) || self.minimapstatetracker == 0 && var_1 > self.minimapstatetracker) {
    self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 1);

    if(istrue(var_0))
      self.minimapstatetracker = 0;
  }
}

showminimap() {
  if(trophy_get_part_by_tag()) {
    return;
  }
  if(!isDefined(self.minimapstatetracker))
    self.minimapstatetracker = 0;

  var_0 = self.minimapstatetracker;
  self.minimapstatetracker++;

  if(self.minimapstatetracker == 1 && var_0 < self.minimapstatetracker)
    self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 0);
}

getplayerdataloadoutgroup() {
  if(getdvarint("_encstr_95B00B1305A628A6159AC9282A"))
    return "_encstr_A6DC101B53ABFB7E88FB542F8B7085BF4DEB";
  else
    return "_encstr_B8A30FC8463D282A65B07FF929C89DD3F0";
}

disableplayerminimap() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");
    hideminimap(1);
  }
}

allow_change_stance(var_0) {
  var_1 = self getstance();

  switch (var_1) {
    case "_encstr_A5AD069B231F0BAF":
      scripts\common\utility::allow_crouch(var_0);
      scripts\common\utility::allow_prone(var_0);
      break;
    case "_encstr_B13D076BED70539F23":
      scripts\common\utility::allow_stand(var_0);
      scripts\common\utility::allow_prone(var_0);
      break;
    case "_encstr_922406F1A6FD5E05":
      scripts\common\utility::allow_stand(var_0);
      scripts\common\utility::allow_crouch(var_0);
      break;
  }
}

getplayersinteam(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_9A8507BA4040188D08";

  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

teleportallplayersinteamtostructs(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_3) || var_3.size < 4) {
    return;
  }
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  var_4 = 0;

  foreach(var_6 in getplayersinteam(var_0)) {
    var_3[var_4].angles = scripts\engine\utility::ter_op(isDefined(var_3[var_4].angles), var_3[var_4].angles, (0, 0, 0));
    var_6 setOrigin(var_3[var_4].origin);
    var_6 setplayerangles(var_3[var_4].angles);
    var_6 dontinterpolate();
    var_4++;
  }

  if(!istrue(var_2)) {
    return;
  }
  level thread thread_teleportplayertoteamstructs_latejoin(var_0, var_1);
}

thread_teleportplayertoteamstructs_latejoin(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_A2FD1C9BC15B23AC88CF5776C7B0F9EBF579B2810B251BE75037726CD7B1" + var_0);
  level endon("_encstr_A2FD1C9BC15B23AC88CF5776C7B0F9EBF579B2810B251BE75037726CD7B1" + var_0);

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_2);
    level thread teleportplayertoteamstructs_latejoin(var_2, var_1);
  }
}

teleportplayertoteamstructs_latejoin(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  waitframe();
  teleportplayertoteamstructs(var_0, var_1);
}

teleportplayertoteamstructs(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_2) || var_2.size < 4) {
    return;
  }
  var_3 = randomintrange(0, var_2.size);
  var_2[var_3].angles = scripts\engine\utility::ter_op(isDefined(var_2[var_3].angles), var_2[var_3].angles, (0, 0, 0));
  var_0 setOrigin(var_2[var_3].origin);
  var_0 setplayerangles(var_2[var_3].angles);
  var_0 dontinterpolate();
}

string_is_single_digit_integer(var_0) {
  if(var_0.size > 1)
    return 0;

  var_1 = [];
  var_1["_encstr_934C0218"] = 1;
  var_1["_encstr_A34C02BB"] = 1;
  var_1["_encstr_A74C0222"] = 1;
  var_1["_encstr_A14C023B"] = 1;
  var_1["_encstr_AC4C024A"] = 1;
  var_1["_encstr_B84C027E"] = 1;
  var_1["_encstr_8F4C026A"] = 1;
  var_1["_encstr_914C02DC"] = 1;
  var_1["_encstr_864C02F9"] = 1;
  var_1["_encstr_8B4C0227"] = 1;

  if(isDefined(var_1[var_0]))
    return 1;

  return 0;
}

init_vehicle_omnvars() {
  self setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", -1);
  self setclientomnvar("_encstr_A93C12AB4BFAB3CAA1D7BDD836BA07583747EB81", -1);
  self setclientomnvar("_encstr_BA3C1265BBE6D35FD10102DAF833D247789DC7B9", -1);
  self setclientomnvar("_encstr_B13C127DDBF1938723F6D21A59858B0E1099DFA2", -1);
  self setclientomnvar("_encstr_A23C12CD2C819DC1681F2048C7353BEBFA135076", -1);
  self setclientomnvar("_encstr_8D3C128564C9D5995857581B9F7DF33302CB68AD", -1);
}

printgameaction(var_0, var_1) {
  if(getdvarint("_encstr_97F11A28822A07D317B8F7EE85279BBFD70A4010B906B70B3FDFF066", 0) == 1) {
    return;
  }
  var_2 = "_encstr_B40101";

  if(isDefined(var_1))
    var_2 = "_encstr_B44C0203" + var_1 getentitynumber() + "_encstr_8D4C02E8" + var_1.name + "_encstr_AF07039E3E";
}

isplayerads() {
  return self playerads() > 0.5;
}

isairdenied() {
  if(isai(self))
    return 0;

  if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return 0;

  return 0;
}

get_center_point_of_array(var_0) {
  var_1 = (0, 0, 0);

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1 = (var_1[0] + var_0[var_2].origin[0], var_1[1] + var_0[var_2].origin[1], var_1[2] + var_0[var_2].origin[2]);

  return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
}

sethintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  self makeusable();

  if(isDefined(var_0))
    self sethinttag(var_0);

  if(isDefined(var_1))
    self setCursorHint(var_1);
  else
    self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");

  if(isDefined(var_2))
    self sethinticon(var_2);

  if(isDefined(var_3))
    self setHintString(var_3);

  if(isDefined(var_4)) {
    var_4 = int(clamp(var_4, -10, 1));
    self setusepriority(var_4);
  } else
    self setusepriority(-10);

  if(isDefined(var_5)) {
    self setuseholdduration(var_5);

    if(var_5 == "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD" || var_5 == "_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9")
      self sethintrequiresholding(1);
  } else
    self setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");

  if(isDefined(var_6))
    self sethintonobstruction(var_6);
  else
    self sethintonobstruction("_encstr_BECC055CF3811A");

  if(isDefined(var_7))
    self sethintdisplayrange(var_7);
  else
    self sethintdisplayrange(200);

  if(isDefined(var_8))
    self sethintdisplayfov(var_8);
  else
    self sethintdisplayfov(160);

  if(isDefined(var_9))
    self setuserange(var_9);
  else
    self setuserange(50);

  if(isDefined(var_10))
    self setusefov(var_10);
  else
    self setusefov(120);
}

is_indoors(var_0) {
  var_1 = 0;
  var_2 = (0, 0, 0);

  if(isent(var_0))
    var_2 = var_0.origin;
  else if(isvector(var_0))
    var_2 = var_0;
  else if(isstruct(var_0))
    var_2 = var_0.origin;

  var_3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(var_2, var_2 + (0, 0, 10000), undefined, var_3))
    var_1 = 1;

  return var_1;
}

is_indoors_vehicleignored(var_0) {
  var_1 = 0;
  var_2 = (0, 0, 0);

  if(isent(var_0))
    var_2 = var_0.origin;
  else if(isvector(var_0))
    var_2 = var_0;
  else if(isstruct(var_0))
    var_2 = var_0.origin;

  var_3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(var_2, var_2 + (0, 0, 10000), undefined, var_3))
    var_1 = 1;

  return var_1;
}

isgesture(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  if(issubstr(var_1, "_encstr_A69F097F45DBCF92BBF74E"))
    return 1;
  else if(issubstr(var_1, "_encstr_8E550E681AD383D8FB0F5E580BFF2079"))
    return 1;
  else
    return 0;
}

actionslotoverride(var_0, var_1, var_2, var_3) {
  self setweaponhudiconoverride("_encstr_8DE40B413BB3F2B0A85BE9184B" + var_0, var_1);

  if(isDefined(var_2))
    setactionslotoverrideammo(var_0, var_2);

  if(isDefined(var_3))
    thread actionslotoverridecallback(var_0, var_3);
}

actionslotoverridecallback(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A720118A339025DBB525225B0898839A30BF04" + var_0);
  self notifyonplayercommand("_encstr_8DE40B413BB3F2B0A85BE9184B" + var_0, "_encstr_85D60DE3229235805F461754801159" + var_0);

  for(;;) {
    self waittill("_encstr_8DE40B413BB3F2B0A85BE9184B" + var_0);
    self thread[[var_1]]();
  }
}

actionslotoverrideremove(var_0) {
  self notify("_encstr_A720118A339025DBB525225B0898839A30BF04" + var_0);
  self setweaponhudiconoverrideammo("_encstr_8DE40B413BB3F2B0A85BE9184B" + var_0, -1);
  self setweaponhudiconoverride("_encstr_8DE40B413BB3F2B0A85BE9184B" + var_0, "_encstr_8BBA05185F8B99");
}

setactionslotoverrideammo(var_0, var_1) {
  self setweaponhudiconoverrideammo("_encstr_8DE40B413BB3F2B0A85BE9184B" + var_0, var_1);
}

demo_button_combo_debug_watcher() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self.debug_button_combos))
    setup_debug_button_combos_for_player();

  self notifyonplayercommand("_encstr_87070365F7", "_encstr_AF5C0E59B08DA32D7B7337D8ED3A1098");
  self notifyonplayercommand("_encstr_AFE90BAB07F5E456D82B0B9B95", "_encstr_84380E9DF9C8A45A701D770377A596B9");
  self notifyonplayercommand("_encstr_9767056D0FBFA8", "_encstr_9A5C0E7471AFC0EA624018717863626F");
  self notifyonplayercommand("_encstr_82320DC87BBB73F5E4956395C2DC59", "_encstr_B6380E5A0B1B1DD2B737371BDE1D04C8");
  self notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_97410B23BD6B976233901AF2F8");
  self notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_B4C60AD707B2BDC0E6CE1309");
  self notifyonplayercommand("_encstr_BE750C2313502753DDB1F7DFB7F5", "_encstr_AA2A0BA05B7B203642ABFFEBA3");
  self notifyonplayercommand("_encstr_BE750C2313502753DDB1F7DFB7F5", "_encstr_85CD0A8E305134D2A5FF4B07");
  self notifyonplayercommand("_encstr_A96D079BEB99884E52", "_encstr_A6E308B2DCE8B0B936B2");
  self notifyonplayercommand("_encstr_977A0F7B5BE605AAA5579048B8B9A77637", "_encstr_AA8B08A1EA73F3E04BB7");
  self notifyonplayercommand("_encstr_AD1904291F7B", "_encstr_97120D65B983599519EB1D86C9B7EE");
  self notifyonplayercommand("_encstr_91D10CF187F7F96B583115F8576B", "_encstr_A52F0DF89B22FF1545787B02C3C7FF");
  self notifyonplayercommand("_encstr_999A07C61338F9A23A", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_A7FF0F119BBD127A08F1DAE1C46FB7BEF5", "_encstr_BA1E086D0980540AA6C7");
  self notifyonplayercommand("_encstr_82E0094310C338C39B5EE9", "_encstr_8D9D07AC99F68DD5E6");
  self notifyonplayercommand("_encstr_82E0094310C338C39B5EE9", "_encstr_816F0E3A8450778C7C1FD358BF13330B");
  self notifyonplayercommand("_encstr_82E0094310C338C39B5EE9", "_encstr_85CE0DEB40D1278283F68E855EBB4B");
  self notifyonplayercommand("_encstr_A736118EDBABB10D83858CFA272BD8B2C2B995", "_encstr_A5190716A2E0430BBB");
  self notifyonplayercommand("_encstr_A736118EDBABB10D83858CFA272BD8B2C2B995", "_encstr_81E90E6D63D7B70FB8475F16B8E3E3E2");
  self notifyonplayercommand("_encstr_AFCB0C5B83DFB3A1C04BE9E047D0", "_encstr_A6E60A229B175A3B48A543AB");
  self notifyonplayercommand("_encstr_9A2414E6BB1607EBDDAC161CB7DCBEC9CAD8560B6E2B", "_encstr_84B90A5ABBCAC238B959E1E8");
  self notifyonplayercommand("_encstr_994C0238", "_encstr_B44609DFE707CF394E1651");
  self notifyonplayercommand("_encstr_95BA0A14EB93CAC6AC8537AC", "_encstr_8BF80920C9D08F50F9B85B");
  self notifyonplayercommand("_encstr_8253061E6BDF6331", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");
  var_0 = ["_encstr_87070365F7", "_encstr_AFE90BAB07F5E456D82B0B9B95", "_encstr_9767056D0FBFA8", "_encstr_82320DC87BBB73F5E4956395C2DC59", "_encstr_AB19049D0FC0", "_encstr_BE750C2313502753DDB1F7DFB7F5", "_encstr_A96D079BEB99884E52", "_encstr_977A0F7B5BE605AAA5579048B8B9A77637", "_encstr_994C0238", "_encstr_95BA0A14EB93CAC6AC8537AC", "_encstr_8253060E2B5FE330", "_encstr_AD1904291F7B", "_encstr_91D10CF187F7F96B583115F8576B", "_encstr_999A07C61338F9A23A", "_encstr_A7FF0F119BBD127A08F1DAE1C46FB7BEF5", "_encstr_82E0094310C338C39B5EE9", "_encstr_A736118EDBABB10D83858CFA272BD8B2C2B995", "_encstr_AFCB0C5B83DFB3A1C04BE9E047D0", "_encstr_9A2414E6BB1607EBDDAC161CB7DCBEC9CAD8560B6E2B"];
  var_1 = [];
  var_2 = 2;
  var_3 = undefined;

  for(;;) {
    var_4 = level.demo_button_combos;
    var_5 = scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_0);

    if(getdvarint("_encstr_B4CE0FE68D93BE8C56DABDAF23594CAECE", 0)) {
      var_6 = gettime();

      if(!isDefined(var_3))
        var_3 = var_6 + var_2 * 1000;

      var_1[var_1.size] = var_5;

      if(var_6 >= var_3) {
        var_3 = undefined;
        var_1 = [];
        continue;
      } else {
        var_3 = var_6 + var_2 * 1000;
        var_1 = validate_button_combo(var_1);

        if(var_1.size < 1)
          var_3 = undefined;
      }
    }
  }
}

setup_debug_button_combos_for_player() {}

add_demo_button_combo(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.button_combo = var_0;
  var_4.func = var_1;
  var_4.message = var_2;
  var_4.timeout = var_3;
  level.demo_button_combos[level.demo_button_combos.size] = var_4;
}

validate_button_combo(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level.demo_button_combos.size; var_2++) {
    var_3 = level.demo_button_combos[var_2];
    var_4 = level.demo_button_combos[var_2].button_combo;

    if(var_0.size <= var_4.size) {
      if(var_0[var_0.size - 1] == var_4[var_0.size - 1]) {
        if(var_0.size == var_4.size) {
          if(isDefined(var_3.message))
            announcement(var_3.message);

          var_0 = [];
          self thread[[var_3.func]]();
        }

        var_1 = var_0;
        break;
      }
    }
  }

  return var_1;
}

getenemyteams(var_0) {
  var_1 = level.teamnamelist;
  var_1 = scripts\engine\utility::array_remove(var_1, var_0);
  return var_1;
}

isfemale() {
  return isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39";
}

getgametype() {
  return level.gametype;
}

register_create_script(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0))
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var_0;

  if(isDefined(var_1))
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var_1;

  if(isDefined(var_2))
    level.create_script_file_ids[var_0] = "_encstr_8A0703D983" + var_2;

  if(isDefined(var_3))
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var_3;
}

array_notify(var_0, var_1, var_2) {
  foreach(var_5, var_4 in var_0)
  var_4 notify(var_1, var_2);
}

addtoactivekillstreaklist(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(istrue(var_4)) {
    var_7 = 0;

    if(var_2 isusingremote())
      var_7 = 1;

    var_8 = undefined;

    if(level.teambased)
      var_8 = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, var_5, 1, 10000, undefined, undefined, 1, var_7);
    else
      var_8 = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_2, "_encstr_A62C214CED91A9090910CB07C021F9E20F0D92835BE1C24DF0F0171B0898B50AC11118", var_5, 1, 10000, undefined, undefined, 1);

    thread removeteamheadicononnotify(var_8, var_6);
  }
}

removeteamheadicononnotify(var_0, var_1) {
  var_2 = ["_encstr_AD75063D571AE108"];

  if(isDefined(var_1))
    var_2[var_2.size] = var_1;

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_2);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_0);
}

killstreak_make_vehicle(var_0, var_1, var_2, var_3, var_4) {
  self.vehiclename = var_0;
  self.scorepopup = var_1;
  self.vodestroyed = var_2;
  self.votimeout = var_3;
  self.destroyedsplash = var_4;
  self enableplayermarks("_encstr_85CE0B9770B02C73A1760F06D2");
  self filteroutplayermarks(self.team);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);

  if(isDefined(self.owner))
    self.owner notify("_encstr_A30D18C8C3284D80CB429792D7F1A392B8AF3ACA27D7D3A3DD08", self);
}

killstreak_set_pre_mod_damage_callback(var_0, var_1) {
  killstreak_vehicle_callback_init();
  scripts\cp\vehicles\damage_cp::set_pre_mod_damage_callback(var_0, level.kspremoddamagecallback);
  self.kspremoddamagecallback = var_1;
}

killstreak_set_post_mod_damage_callback(var_0, var_1) {
  killstreak_vehicle_callback_init();
  scripts\cp\vehicles\damage_cp::set_post_mod_damage_callback(var_0, level.kspostmoddamagecallback);
  self.kspostmoddamagecallback = var_1;
}

killstreak_set_death_callback(var_0, var_1) {
  killstreak_vehicle_callback_init();
  scripts\cp\vehicles\damage_cp::set_death_callback(var_0, level.ksdeathcallback);
  self.ksdeathcallback = var_1;
}

killstreak_vehicle_callback_init() {
  if(!istrue(level.kscallbackinitcomplete)) {
    level.kscallbackinitcomplete = 1;
    level.kspremoddamagecallback = ::killstreak_pre_mod_damage_callback;
    level.kspostmoddamagecallback = ::killstreak_post_mod_damage_callback;
    level.ksdeathcallback = ::killstreak_death_callback;
  }
}

killstreak_pre_mod_damage_callback(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.attacker;

  if(!istrue(self.killoneshot)) {
    if(isDefined(var_2) && isDefined(self.owner) && var_2 == self.owner)
      var_1 = int(ceil(var_1 * 0.5));

    var_0.damage = var_1;
  }

  var_3 = 1;
  var_4 = self.kspremoddamagecallback;

  if(isDefined(var_4))
    var_3 = self[[var_4]](var_0);

  return var_3;
}

killstreak_post_mod_damage_callback(var_0) {
  killstreakhit(var_0.attacker, var_0.objweapon, self, var_0.meansofdeath, var_0.damage);
  var_1 = 1;
  var_2 = self.kspostmoddamagecallback;

  if(isDefined(var_2))
    var_1 = self[[var_2]](var_0);

  return var_1;
}

killstreak_death_callback(var_0) {
  onkillstreakkilled(self.streakname, var_0.attacker, var_0.objweapon, var_0.meansofdeath, var_0.damage, self.scorepopup, self.vodestroyed, self.destroyedsplash);
  var_1 = 1;
  var_2 = self.ksdeathcallback;

  if(isDefined(var_2))
    var_1 = self[[var_2]](var_0);

  return var_1;
}

killstreakhit(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && isPlayer(var_0) && isDefined(var_2.owner) && isDefined(var_2.owner.team)) {
    if(scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_2.owner)) {
      if(iskillstreakweapon(var_1.basename)) {
        return;
      }
      var_5 = createheadicon(var_1);

      if(!isDefined(var_0.lasthittime[var_5]))
        var_0.lasthittime[var_5] = 0;

      if(var_0.lasthittime[var_5] == gettime()) {
        return;
      }
      var_0.lasthittime[var_5] = gettime();

      if(onlinestatsenabled()) {}

      if(isDefined(var_3) && scripts\engine\utility::isbulletdamage(var_3) || isprojectiledamage(var_3)) {
        var_0.lastdamagetime = gettime();
        var_6 = scripts\cp\cp_weapon::getweapongroup(var_1.basename);

        if(var_6 == "_encstr_A3710BEEACC2E0B737EB36B676") {
          if(!isDefined(var_0.shotslandedlmg))
            var_0.shotslandedlmg = 1;
          else
            var_0.shotslandedlmg++;
        }
      }
    }
  }
}

isprojectiledamage(var_0) {
  var_1 = "_encstr_878D34DF77C511B0493C5C97D511E1582DC1475FD990B85581C506ABA1E13F109897B3CF253730152AAC0DA766217D18FD0FCF73BFC5";

  if(issubstr(var_1, var_0))
    return 1;

  return 0;
}

onkillstreakkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;
  var_10 = undefined;

  if(isDefined(var_1) && isDefined(self.owner)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner))
      var_1 = var_1.owner;
  } else if(isDefined(var_1) && isDefined(self.team) && isDefined(var_1.team)) {
    if(isenemy(var_1) && isPlayer(var_1))
      var_10 = var_1;
  }

  if(isDefined(var_10)) {
    if(isDefined(var_7))
      var_10 scripts\cp\cp_player_battlechatter::killstreakdestroyed(var_0);

    thread scripts\mp\mp_agent_damage::killedkillstreak(var_0, var_10, var_2);

    if(!tryingtoleave())
      thread scripts\mp\ammorestock::killstreakkilled(var_0, self.owner, self, var_10, var_4, var_3, var_2, var_5);

    scripts\cp_mp\gestures::processcalloutdeath(self, var_10);
    var_9 = 1;
  }

  if(isDefined(self.owner) && isDefined(var_6)) {}

  if(!istrue(var_8))
    self notify("_encstr_AD75063D571AE108");

  return var_9;
}

skydivestreamhintdvars(var_0) {
  skydiveontacinsertplacement();
  skydivehintnotify(var_0 + "_encstr_A3B30F896BABA2018658C35318B9CE9A73", var_0 + "_encstr_83250B095395603B1107607FDD");
}

skydivehintnotify(var_0, var_1) {
  if(!isDefined(level.heli_structs_entrances))
    level.heli_structs_entrances = [];

  if(!isDefined(level.heli_structs_goals))
    level.heli_structs_goals = [];

  var_2 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_3 = scripts\engine\utility::getStruct(var_1, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level.heli_structs_entrances[level.heli_structs_entrances.size] = var_2;
  level.heli_structs_goals[level.heli_structs_goals.size] = var_3;
}

skydiveontacinsertplacement() {
  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size >= 1)
    level.heli_structs_entrances = [];

  if(isDefined(level.heli_structs_goals) && level.heli_structs_goals.size >= 1)
    level.heli_structs_goals = [];
}

try_start_driving_func() {
  if(getdvarint("_encstr_833B13E0F70A9EBD7ABCEDF8D252EBA17FA778D077", 0))
    return 1;

  return level.script == "_encstr_8B82108D07AF93585A237D6CB7D60E1B951E" || level.script == "_encstr_ABB40E5E9BB78D683307878123218F50" || level.script == "_encstr_AA9C0D9E404FBBDD6643B1C0AABDAB" || level.script == "_encstr_AC530FEAD3702BBEA039A770D918C2BFAF";
}

turn_off_sniper_laser() {
  if(level.gametype == "_encstr_B6570B78A33FB39B3317E886AB")
    return 1;

  return 0;
}

tryingtoleave() {
  return level.gametype == "_encstr_8B6B0B26FA20C3E85FFAA84F0B";
}

truck_detachvehiclefromairdropsequence() {
  if(level.gametype == "_encstr_839E0CBFD1801B5DB0D34C932998")
    return 1;

  return 0;
}

trialympic_fire() {
  var_0 = getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");

  if(var_0 == "_encstr_8B82108D07AF93585A237D6CB7D60E1B951E" || var_0 == "_encstr_ABB40E5E9BB78D683307878123218F50")
    return 1;

  return 0;
}

issimultaneouskillenabled() {
  if(!isDefined(level.simultaneouskillenabled))
    level.simultaneouskillenabled = getdvarint("_encstr_A3ED0B751E5F0B7A8F49291169", 0) == 0;

  return level.simultaneouskillenabled;
}

onlinestatsenabled() {
  if(!isPlayer(self))
    return 0;

  return level.onlinestatsenabled && !self.usingonlinedataoffline;
}

privatematch() {
  return level.onlinegame && getdvarint("_encstr_93390B136AA2628AA8A93529D4");
}

getenemycount(var_0, var_1) {
  var_2 = 0;
  var_3 = getenemyteams(var_0);

  foreach(var_5 in var_3)
  var_2 = var_2 + getteamcount(var_5, istrue(var_1));

  return var_2;
}

getteamcount(var_0, var_1) {
  if(istrue(var_1))
    return level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"].size;
  else
    return level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"].size;
}

getenemyplayers(var_0, var_1) {
  var_2 = [];
  var_3 = getenemyteams(var_0);

  foreach(var_5 in var_3) {
    if(istrue(var_1)) {
      foreach(var_7 in level.teamdata[var_5]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {
        if(isDefined(var_7) && isalive(var_7) && !isDefined(var_7.fauxdead))
          var_2[var_2.size] = var_7;
      }

      continue;
    }

    foreach(var_7 in level.teamdata[var_5]["_encstr_9775086022BE1B413B8B"])
    var_2[var_2.size] = var_7;
  }

  return var_2;
}

_id_123FE(var_0, var_1) {
  var_2 = level.players;

  if(isDefined(var_1)) {
    if(!isarray(var_1))
      var_2 = [var_1];
    else
      var_2 = var_1;
  }

  foreach(var_4 in var_2)
  var_4 setplayermusicstate(var_0);
}

_id_14441(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_884A10329CDEE0C1AC91D7D07B37D1C29DB2");
  self endon("_encstr_878827C01B85818ECB1FCE45E90F316FEEE340A8A29AA7C3C72CDEB3C903394F97DAD891CA750FBBD7");
  var_1 = self;
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 64);
  var_2 = 1.5;
  var_3 = ["_encstr_AC822360CA62D30BDB7126294D4FB1978D438938627D71615BA737972ECFF82FF5CB118A3F", "_encstr_85B92416A340A97F83B1429915A66FB8E0B04FABAFEFC59FDB515AA7353D48B46190D39961EA"];

  for(;;) {
    var_4 = [];
    var_5 = getentitylessscriptablearrayinradius(undefined, undefined, var_1.origin, var_0);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(var_5[var_6] scriptableisdoor())
        var_4[var_4.size] = var_5[var_6];
    }

    for(var_7 = 0; var_7 < var_4.size; var_7++)
      var_4[var_7] setscriptablepartstate("_encstr_B16705D9AFE22E", "_encstr_A6E508181F1B0BDEA2F0", 0);

    wait(var_2);
  }
}

questtimeradd() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_2 is_valid_player())
      var_0++;
  }

  return var_0;
}

_id_13C3E(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_BA1F193B6B2843AAB8C98FCF114092B7B031798260E001138BF7AB");
  self endon("_encstr_BA1F193B6B2843AAB8C98FCF114092B7B031798260E001138BF7AB");

  if(!isDefined(var_1))
    var_1 = 0.1;

  for(;;) {
    wait(var_1);

    if(!isDefined(self)) {
      continue;
    }
    if(!isDefined(self.origin)) {
      continue;
    }
    if(isDefined(self.last_good_pos) && self.origin == self.last_good_pos) {
      continue;
    }
    if(!isalive(self)) {
      continue;
    }
    if(self isjumping()) {
      continue;
    }
    if(self isparachuting()) {
      continue;
    }
    if(self isonladder()) {
      continue;
    }
    if(!self isonground()) {
      continue;
    }
    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      continue;
    }
    if(isDefined(level.outofboundstriggers)) {
      foreach(var_3 in level.outofboundstriggers) {
        if(self istouching(var_3))
          continue;
      }
    }

    if(isDefined(level.landmine_trig) && self istouching(level.landmine_trig)) {
      continue;
    }
    if(istrue(self.spectating)) {
      continue;
    }
    if(istrue(self.spawner_dropoff)) {
      continue;
    }
    if(istrue(self.landmine_active)) {
      continue;
    }
    if(istrue(var_0) && !ispointonnavmesh(self.origin)) {
      continue;
    }
    self.last_good_pos = self.origin;
  }
}