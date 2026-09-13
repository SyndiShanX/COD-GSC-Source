/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\gun.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237 = [];
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  setspecialloadout();
  updategametypedvars();
  setgunladder();
  setteammode("ffa");
  level.teambased = 0;
  level.ignorekdrstats = 1;
  level.disablespawncamera = 1;
  thread waitthensetstatgroupreadonly();
  level.doprematch = 1;
  level.supportintel = 0;
  level.supportnuke = 0;
  level.disablecopycatloadout = 1;
  setomnvar("ui_killcam_copycat", 0);
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.modeonspawnplayer = ::onspawnplayer;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.ontimelimit = ::ontimelimit;
  level.onplayerscore = ::onplayerscore;
  level.bypassclasschoicefunc = scripts\mp\class::alwaysgamemodeclass;
  level.modifyunifiedpointscallback = ::modifyunifiedpointscallback;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_gngm_mode_uktl_ggt1";
  else
    game["dialog"]["gametype"] = "iw9_gngm_mode_uktl_ggnm";

  game["dialog"]["boost"] = "iw9_gngm_mode_uktl_ggbo";
  game["dialog"]["offense_obj"] = "iw9_gngm_mode_uktl_ggbo";
  game["dialog"]["defense_obj"] = "iw9_gngm_mode_uktl_ggbo";
  game["dialog"]["lasttier_enemy"] = "iw9_gngm_mode_uktl_ggfe";
  game["dialog"]["lasttier_friendly"] = "iw9_gngm_mode_uktl_ggff";
}

waitthensetstatgroupreadonly() {
  self endon("game_ended");
  wait 1;

  if(isDefined(level.playerstats)) {
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("kdr");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("losses");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("winLoss");
  }
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata(1);
  setdynamicdvar("scr_gun_setback", getmatchrulesdata("gunData", "setback"));
  setdynamicdvar("scr_gun_setbackstreak", getmatchrulesdata("gunData", "setbackStreak"));
  setdynamicdvar("scr_gun_killsperweapon", getmatchrulesdata("gunData", "killsPerWeapon"));
  setdynamicdvar("scr_gun_ladderindex", getmatchrulesdata("gunData", "ladderIndex"));
  setdynamicdvar("scr_gun_promode", 0);
}

onprecachegametype() {}

onstartgametype() {
  setclientnamemode("auto_change");

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/DM");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DM");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DM_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/DM_HINT");
  }

  setgunsfinal();
  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dm_spawn_start", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.quickmessagetoall = 1;
  level.blockweapondrops = 1;
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.setback = scripts\mp\utility\dvars::dvarintvalue("setback", 1, 0, 5);
  level.setbackstreak = scripts\mp\utility\dvars::dvarintvalue("setbackStreak", 0, 0, 5);
  level.killsperweapon = scripts\mp\utility\dvars::dvarintvalue("killsPerWeapon", 1, 1, 5);
  level.ladderindex = scripts\mp\utility\dvars::dvarintvalue("ladderIndex", 1, 1, 6);
}

onplayerconnect(player) {
  player thread keepweaponsloaded();
  player scripts\mp\class::_id_A16868D4DCD81A4B();
  player.pers["gamemodeLoadout"] = level.gun_loadouts["axis"];
  player.gungamegunindex = 0;
  player.gungameprevgunindex = 0;
  player thread refillammo();
  player thread refillsinglecountammo();
}

keepweaponsloaded() {
  self loadweaponsforplayer([level.gun_guns[0], level.gun_guns[1]], 1);
  _id_1942F036EF77C9A4 = [];

  for(;;) {
    self waittill("update_loadweapons");
    _id_1942F036EF77C9A4[0] = level.gun_guns[int(max(0, self.gungamegunindex - level.setback))];
    _id_1942F036EF77C9A4[1] = level.gun_guns[self.gungamegunindex];
    _id_1942F036EF77C9A4[2] = level.gun_guns[self.gungamegunindex + 1];
    self loadweaponsforplayer(_id_1942F036EF77C9A4, 1);
  }
}

getspawnpoint() {
  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoint = undefined;
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");

    if(spawnpoints.size > 0) {
      if(!isDefined(level.requiresminstartspawns)) {}

      spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints, 1);
    }

    if(!isDefined(spawnpoint)) {
      spawnpoints = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      spawnpoint = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(spawnpoints);
    }

    return spawnpoint;
  }

  spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, "none", "normal", "fallback");
  return spawnpoint;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("kill");
  thread waitloadoutdone();
  level notify("spawned_player");
}

waitloadoutdone() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");

  if(level.gameended && self.gungamegunindex == level.gun_guns.size)
    self.gungamegunindex = self.gungameprevgunindex;

  scripts\mp\utility\perk::giveperk("specialty_bling");
  thread givenextgun(1);
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid) {
  if(level.gameended) {
    return;
  }
  if(smeansofdeath == "MOD_FALLING" || isDefined(attacker) && isPlayer(attacker)) {
    _id_55EF6C1F428AC567 = scripts\cp_mp\utility\weapon_utility::isriotshield(objweapon.basename);
    _id_3AE8C9BE21E07046 = scripts\cp_mp\utility\weapon_utility::isknifeonly(objweapon.basename) || scripts\mp\utility\weapon::isakimbomeleeweapon(objweapon.basename) || scripts\mp\utility\weapon::isaxeweapon(objweapon.basename) || scripts\mp\utility\weapon::ismeleeoverrideweapon(objweapon);
    _id_6A7DE031C0D6FFA9 = isDefined(smeansofdeath) && smeansofdeath == "MOD_EXECUTION";

    if(!isDefined(self.ladderdeathsthisweapon))
      self.ladderdeathsthisweapon = 1;
    else
      self.ladderdeathsthisweapon++;

    if(smeansofdeath == "MOD_FALLING" || attacker == self || smeansofdeath == "MOD_MELEE" && _id_3AE8C9BE21E07046 || self.ladderdeathsthisweapon == level.setbackstreak || _id_6A7DE031C0D6FFA9) {
      self.ladderdeathsthisweapon = 0;
      self playlocalsound("iw9_mp_ui_objective_lost");
      self notify("update_loadweapons");
      self.gungameprevgunindex = self.gungamegunindex;
      self.gungamegunindex = int(max(0, self.gungamegunindex - level.setback));

      if(self.gungameprevgunindex > self.gungamegunindex) {
        scripts\mp\gamescore::giveplayerscore("stat_0BC852DBBECB5643", 1);
        thread scripts\mp\rank::scoreeventpopup("stat_0BC852DBBECB5643");
        scripts\mp\utility\stats::incpersstat("setbacks", 1);
        scripts\mp\persistence::statsetchild("round", "setbacks", self.pers["setbacks"]);

        if(isPlayer(self))
          scripts\mp\utility\stats::setextrascore1(self.pers["setbacks"]);
      }

      if(smeansofdeath == "MOD_MELEE") {
        if(self.gungameprevgunindex)
          attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_9FEDFEA2929DC7DA");

        attacker updateknivesperminute();
        attacker scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6943B98A3E7D1A00");
        attacker scripts\mp\utility\stats::incpersstat("stabs", 1);
        attacker scripts\mp\persistence::statsetchild("round", "stabs", attacker.pers["stabs"]);

        if(isPlayer(attacker))
          attacker scripts\mp\utility\stats::setextrascore0(attacker.pers["stabs"]);
      }

      if(attacker == self)
        return;
    }

    if(attacker != self && smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_IMPACT" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || (smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_EXPLOSIVE_BULLET") || smeansofdeath == "MOD_FIRE" || smeansofdeath == "MOD_MELEE" && !_id_3AE8C9BE21E07046 || _id_6A7DE031C0D6FFA9) {
      _id_0AC0B9ADAA0D681A = getweaponbasename(attacker.primaryweapon);

      if(!attacker canprogressingunrank(objweapon, _id_0AC0B9ADAA0D681A, _id_6A7DE031C0D6FFA9)) {
        return;
      }
      if(!isDefined(attacker.ladderkillsthisweapon))
        attacker.ladderkillsthisweapon = 1;
      else
        attacker.ladderkillsthisweapon++;

      if(attacker.ladderkillsthisweapon != level.killsperweapon) {
        return;
      }
      attacker.ladderkillsthisweapon = 0;
      attacker.ladderdeathsthisweapon = 0;
      attacker.gungameprevgunindex = attacker.gungamegunindex;
      attacker.gungamegunindex++;
      attacker notify("update_loadweapons");
      attacker scripts\mp\gamescore::giveplayerscore("stat_FE819F757CFE15FD", 1);

      if(attacker.gungamegunindex == level.gun_guns.size - 2)
        level.kick_afk_check = 1;

      if(attacker isonlastkill()) {
        _id_15030F107E796007 = [];

        foreach(_id_AC0E424AC96A7113 in level.players) {
          if(_id_AC0E424AC96A7113 != attacker)
            _id_15030F107E796007[_id_15030F107E796007.size] = _id_AC0E424AC96A7113;
        }

        scripts\mp\utility\dialog::leaderdialogonplayers("lasttier_enemy", _id_15030F107E796007);
        attacker scripts\mp\utility\dialog::leaderdialogonplayer("lasttier_friendly");
        attacker scripts\mp\hud_message::showsplash("gun_final_kill");
        scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
        level thread scripts\mp\hud_util::teamplayercardsplash("callout_top_gun_rank", attacker);
      }

      if(attacker.gungamegunindex < level.gun_guns.size) {
        points = scripts\mp\rank::getscoreinfovalue("stat_FE819F757CFE15FD");
        attacker thread scripts\mp\rank::scorepointspopup(points);
        attacker thread scripts\mp\rank::scoreeventpopup("stat_FE819F757CFE15FD");
        attacker playlocalsound("iw9_mp_ui_objective_taken");
        attacker thread givenextgun(0);
      }

      if(isDefined(attacker.lastgunrankincreasetime) && gettime() - attacker.lastgunrankincreasetime < 5000)
        attacker scripts\mp\utility\points::_id_0366980B6A8796AE("stat_16FA4E4E4A6AAACC");

      attacker.lastgunrankincreasetime = gettime();
    }
  }
}

givenextgun(_id_04FEE35970DD4DDF) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!_id_04FEE35970DD4DDF)
    _id_3B64EB40368C1450::set("spawn_weapon", "weapon_switch", 0);

  _id_66B3DB972AC1531E = getnextgun();
  _id_66B3DB972AC1531E = scripts\mp\weapons::updatesavedaltstate(_id_66B3DB972AC1531E);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_66B3DB972AC1531E, undefined, undefined, 1);

  if(_id_04FEE35970DD4DDF) {
    self setspawnweapon(_id_66B3DB972AC1531E);

    foreach(weapon in self.weaponlist) {
      if(weapon == _id_66B3DB972AC1531E) {
        continue;
      }
      if(isDefined(self._id_F1DDB2E2F886E31E) && getweaponbasename(weapon) == self._id_F1DDB2E2F886E31E) {
        continue;
      }
      if(isDefined(self._id_350710EA016EAC45) && getweaponbasename(weapon) == self._id_350710EA016EAC45) {
        continue;
      }
      thread scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe(weapon);
    }
  }

  self.pers["primaryWeapon"] = _id_66B3DB972AC1531E.basename;
  self.primaryweapon = _id_66B3DB972AC1531E.basename;
  self.primaryweaponobj = _id_66B3DB972AC1531E;
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_66B3DB972AC1531E);
  _id_F118B7926C3FDE57 = scripts\mp\utility\weapon::isaxeweapon(_id_66B3DB972AC1531E);

  if(_id_F118B7926C3FDE57) {
    self setweaponammoclip(_id_66B3DB972AC1531E, 1);
    thread takeweaponwhensafegungame("iw9_knifestab_mp", 0);
  } else if(self.gungamegunindex != level.gun_guns.size - 1) {
    self givestartammo(_id_66B3DB972AC1531E);
    _id_F968C960C23738E6 = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845("iw9_knifestab_mp");
    self giveweapon(_id_F968C960C23738E6);
    self assignweaponmeleeslot(_id_F968C960C23738E6);
  }

  if(!_id_04FEE35970DD4DDF) {
    currentweapon = self.lastdroppableweaponobj;
    thread takeweaponwhensafegungame(currentweapon, 1);
  }

  giveortakethrowingknife(_id_66B3DB972AC1531E.basename);
  scripts\mp\weapons::updatetogglescopestate(_id_66B3DB972AC1531E);
  self.gungameprevgunindex = self.gungamegunindex;

  if(!isDefined(self.lastgunpromotiontime))
    self.lastgunpromotiontime = gettime();

  _id_6943F322AA5378A5 = (gettime() - self.lastgunpromotiontime) / 1000;
  self.lastgunpromotiontime = gettime();

  if(isDefined(self.pers["longestTimeSpentOnWeapon"]) && _id_6943F322AA5378A5 > self.pers["longestTimeSpentOnWeapon"])
    self.pers["longestTimeSpentOnWeapon"] = _id_6943F322AA5378A5;
}

takeweaponwhensafegungame(weapon, _id_2AF5EEDF0B55AC7E) {
  self endon("death_or_disconnect");

  for(;;) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(weapon)) {
      break;
    }

    waitframe();
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);

  if(_id_2AF5EEDF0B55AC7E)
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("spawn_weapon");
}

getnextgun(_id_5ED2CD7C116C2AD7) {
  _id_111A8E98DCE6A897 = self.gungamegunindex;

  if(isDefined(_id_5ED2CD7C116C2AD7))
    _id_111A8E98DCE6A897 = _id_5ED2CD7C116C2AD7;

  _id_DD515FCF025B2E79 = level.gun_guns[_id_111A8E98DCE6A897];
  return _id_DD515FCF025B2E79;
}

ontimelimit() {
  winners = gethighestprogressedplayers();

  if(!isDefined(winners) || !winners.size)
    thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
  else if(winners.size == 1)
    thread scripts\mp\gamelogic::endgame(winners[0], game["end_reason"]["time_limit_reached"]);
  else if(winners[winners.size - 1].gungamegunindex > winners[winners.size - 2].gungamegunindex)
    thread scripts\mp\gamelogic::endgame(winners[winners.size - 1], game["end_reason"]["time_limit_reached"]);
  else
    thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
}

gethighestprogressedplayers() {
  _id_8808A5F5C406A534 = -1;
  _id_0CDD8C3D4BA7E829 = [];

  foreach(player in level.players) {
    if(isDefined(player.gungamegunindex) && player.gungamegunindex >= _id_8808A5F5C406A534) {
      _id_8808A5F5C406A534 = player.gungamegunindex;
      _id_0CDD8C3D4BA7E829[_id_0CDD8C3D4BA7E829.size] = player;
    }
  }

  return _id_0CDD8C3D4BA7E829;
}

refillammo() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload");
    _id_8A2ECC3A9D4C95DF = weaponstartammo(self.primaryweapon);
    clipammo = weaponclipsize(self.primaryweapon);
    stockammo = _id_8A2ECC3A9D4C95DF - clipammo;
    self setweaponammostock(self.primaryweapon, stockammo);
  }
}

refillsinglecountammo() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    if(scripts\mp\utility\player::isreallyalive(self) && self.team != "spectator" && isDefined(self.primaryweapon) && self getammocount(self.primaryweapon) == 0) {
      wait 2;
      self notify("reload");
      wait 1;
      continue;
    }

    waitframe();
  }
}

setgunladder() {
  level.gun_guns = [];
  level.selectedweapons = [];

  switch (level.ladderindex) {
    case 6:
    case 5:
    case 4:
    case 1:
      if(scripts\mp\utility\game::matchmakinggame() && getdvarint("dvar_0FB3E643C9CDD861", 0) == 1) {
        level.gun_guns[0] = "rand_pistol";
        level.gun_guns[1] = "rand_shotgun";
        level.gun_guns[2] = "rand_smg";
        level.gun_guns[3] = "rand_assault";
        level.gun_guns[4] = "rand_lmg";
        level.gun_guns[5] = "rand_sniper";
        level.gun_guns[6] = "rand_smg";
        level.gun_guns[7] = "rand_assault";
        level.gun_guns[8] = "rand_lmg";
        level.gun_guns[9] = "rand_launcher";
        level.gun_guns[10] = "rand_shotgun";
        level.gun_guns[11] = "rand_smg";
        level.gun_guns[12] = "rand_assault";
        level.gun_guns[13] = "rand_shotgun2";
        level.gun_guns[14] = "rand_assault";
        level.gun_guns[15] = "rand_sniper";
        level.gun_guns[16] = "rand_pistol";
        level.gun_guns[17] = "rand_knife_end";
      } else {
        level.gun_guns[0] = "rand_assault";
        level.gun_guns[1] = "rand_smg";
        level.gun_guns[2] = "rand_shotgun";
        level.gun_guns[3] = "rand_lmg";
        level.gun_guns[4] = "rand_assault";
        level.gun_guns[5] = "rand_dmr";
        level.gun_guns[6] = "rand_pistol";
        level.gun_guns[7] = "rand_assault";
        level.gun_guns[8] = "rand_smg";
        level.gun_guns[9] = "rand_launcher";
        level.gun_guns[10] = "rand_dmr";
        level.gun_guns[11] = "rand_lmg";
        level.gun_guns[12] = "rand_assault";
        level.gun_guns[13] = "rand_smg";
        level.gun_guns[14] = "rand_sniper";
        level.gun_guns[15] = "rand_shotgun";
        level.gun_guns[16] = "rand_pistol";
        level.gun_guns[17] = "rand_knife_end";
      }

      break;
    case 2:
      level.gun_guns[0] = "rand_pistol";
      level.gun_guns[1] = "rand_shotgun";
      level.gun_guns[2] = "rand_smg";
      level.gun_guns[3] = "rand_assault";
      level.gun_guns[4] = "rand_pistol";
      level.gun_guns[5] = "rand_shotgun";
      level.gun_guns[6] = "rand_smg";
      level.gun_guns[7] = "rand_assault";
      level.gun_guns[8] = "rand_pistol";
      level.gun_guns[9] = "rand_shotgun2";
      level.gun_guns[10] = "rand_smg";
      level.gun_guns[11] = "rand_assault";
      level.gun_guns[12] = "rand_pistol";
      level.gun_guns[13] = "rand_shotgun2";
      level.gun_guns[14] = "rand_smg";
      level.gun_guns[15] = "rand_assault";
      level.gun_guns[16] = "rand_pistol2";
      level.gun_guns[17] = "rand_knife_end";
      break;
    case 3:
      level.gun_guns[0] = "rand_pistol";
      level.gun_guns[1] = "rand_assault";
      level.gun_guns[2] = "rand_lmg";
      level.gun_guns[3] = "rand_launcher";
      level.gun_guns[4] = "rand_sniper";
      level.gun_guns[5] = "rand_assault";
      level.gun_guns[6] = "rand_lmg";
      level.gun_guns[7] = "rand_launcher";
      level.gun_guns[8] = "rand_sniper";
      level.gun_guns[9] = "rand_assault";
      level.gun_guns[10] = "rand_lmg";
      level.gun_guns[11] = "rand_launcher";
      level.gun_guns[12] = "rand_sniper2";
      level.gun_guns[13] = "rand_assault";
      level.gun_guns[14] = "rand_sniper2";
      level.gun_guns[15] = "rand_assault";
      level.gun_guns[16] = "rand_pistol";
      level.gun_guns[17] = "rand_knife_end";
      break;
  }

  if(level.gametype == "gun") {
    scorelimit = level.gun_guns.size;
    setdynamicdvar("scr_gun_scorelimit", scorelimit);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), scorelimit);
  }
}

setgunsfinal() {
  level.selectedweapons = [];
  _id_6B7AFEFDBEEEEC0A();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gun_guns.size; _id_AC0E594AC96AA3A8++) {
    _id_B3BF8105D61A60E1 = level.gun_guns[_id_AC0E594AC96AA3A8];

    if(scripts\engine\utility::string_starts_with(_id_B3BF8105D61A60E1, "rand_")) {
      _id_BAE77D8848F4D84D = _id_05F97F15E9CA6CB6(_id_B3BF8105D61A60E1);

      if(level.ladderindex == 4 || level.ladderindex == 5)
        level.gun_guns[_id_AC0E594AC96AA3A8] = _id_2669878CF5A1B6BC::buildweapon_blueprint(_id_BAE77D8848F4D84D["weapon"], undefined, undefined, _id_BAE77D8848F4D84D["variantID"], undefined, undefined, scripts\cp_mp\utility\game_utility::isnightmap());
      else
        level.gun_guns[_id_AC0E594AC96AA3A8] = _id_96D23570114BC7B6(_id_BAE77D8848F4D84D);

      continue;
    }

    _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(level.gun_guns[_id_AC0E594AC96AA3A8]);
    level.selectedweapons[_id_AB501F397D3CD312] = 1;
    _id_DD515FCF025B2E79 = _id_AB501F397D3CD312;
    _id_C8616C37BC30098B = 0;

    if(level.ladderindex == 4 || level.ladderindex == 5)
      _id_DD515FCF025B2E79 = _id_2669878CF5A1B6BC::buildweapon_blueprint(_id_AB501F397D3CD312, undefined, undefined, undefined, undefined, undefined, scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4());
    else
      _id_DD515FCF025B2E79 = gun_createrandomweapon(_id_AB501F397D3CD312, _id_C8616C37BC30098B, undefined, scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4());

    level.gun_guns[_id_AC0E594AC96AA3A8] = _id_DD515FCF025B2E79;
  }

  level.selectedweapons = undefined;
}

getrandomarchetype() {
  return "archetype_assault";
}

setspecialloadout() {
  level.gun_loadouts["axis"]["loadoutPrimary"] = "iw9_pi_decho";
  level.gun_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryVariantID"] = 0;
  level.gun_loadouts["axis"]["loadoutSecondary"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryVariantID"] = 0;
  level.gun_loadouts["axis"]["loadoutEquipmentPrimary"] = "none";
  level.gun_loadouts["axis"]["loadoutEquipmentSecondary"] = "none";
  level.gun_loadouts["axis"]["loadoutOffhand"] = "none";
  level.gun_loadouts["axis"]["loadoutStreakType"] = "assault";
  level.gun_loadouts["axis"]["loadoutKillstreak1"] = "none";
  level.gun_loadouts["axis"]["loadoutKillstreak2"] = "none";
  level.gun_loadouts["axis"]["loadoutKillstreak3"] = "none";
  level.gun_loadouts["axis"]["loadoutPerks"] = [];
  level.gun_loadouts["axis"]["loadoutGesture"] = "playerData";
  level.gun_loadouts["allies"] = level.gun_loadouts["axis"];
}

_id_6B7AFEFDBEEEEC0A() {
  level.weaponcategories = [];
  _id_CB89110314447B2F = 0;

  for(;;) {
    _id_22E2935C86B3B88E = tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 0);

    if(_id_22E2935C86B3B88E == "") {
      break;
    }

    if(!isDefined(level.weaponcategories[_id_22E2935C86B3B88E]))
      level.weaponcategories[_id_22E2935C86B3B88E] = [];

    _id_E1FB30830E39F39D = tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 5);

    if(_id_E1FB30830E39F39D == "" || getdvarint(_id_E1FB30830E39F39D, 0) == 1) {
      data = [];
      data["weapon"] = _id_2669878CF5A1B6BC::getweaponrootname(tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 1));
      data["min"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 2));
      data["max"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 3));
      data["perk"] = tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 4);

      if(level.ladderindex == 4 || level.ladderindex == 5) {
        if(!isDefined(game["arenaWeaponCategories"])) {
          level.arenaloadouts = 13;
          _id_3686609F08F20087::_id_B7C18DED2347456C();
        }

        data["variantID"] = _id_3686609F08F20087::_id_11A6A3EC5C206652(data["weapon"]);
      }

      data["allowed"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 7));

      if((level.ladderindex == 4 || level.ladderindex == 6) && !data["allowed"]) {
        _id_CB89110314447B2F++;
        continue;
      }

      level.weaponcategories[_id_22E2935C86B3B88E][level.weaponcategories[_id_22E2935C86B3B88E].size] = data;
    }

    _id_CB89110314447B2F++;
  }
}

_id_05F97F15E9CA6CB6(_id_22E2935C86B3B88E) {
  weaponlist = level.weaponcategories[_id_22E2935C86B3B88E];

  if(isDefined(weaponlist) && weaponlist.size > 0) {
    _id_DD515FCF025B2E79 = "";
    data = undefined;
    loopcount = 0;

    for(;;) {
      index = randomintrange(0, weaponlist.size);
      data = weaponlist[index];
      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(data["weapon"]);
      _id_AAA935A3EBF3FD7C = 1;

      if(level.ladderindex == 4 || level.ladderindex == 6)
        _id_AAA935A3EBF3FD7C = data["allowed"];

      if(isDefined(level.selectedweapons) && !isDefined(level.selectedweapons[_id_AB501F397D3CD312]) && _id_AAA935A3EBF3FD7C || loopcount > weaponlist.size) {
        level.selectedweapons[_id_AB501F397D3CD312] = 1;

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.weaponcategories[_id_22E2935C86B3B88E].size; _id_AC0E594AC96AA3A8++) {
          if(level.weaponcategories[_id_22E2935C86B3B88E][_id_AC0E594AC96AA3A8]["weapon"] == data["weapon"]) {
            level.weaponcategories[_id_22E2935C86B3B88E] = scripts\engine\utility::array_remove_index(level.weaponcategories[_id_22E2935C86B3B88E], _id_AC0E594AC96AA3A8);
            break;
          }
        }

        break;
      }

      loopcount++;
    }

    return data;
  } else
    return "none";
}

_id_96D23570114BC7B6(_id_BAE77D8848F4D84D) {
  _id_C8616C37BC30098B = randomintrange(_id_BAE77D8848F4D84D["min"], _id_BAE77D8848F4D84D["max"] + 1);
  _id_DD515FCF025B2E79 = gun_createrandomweapon(_id_BAE77D8848F4D84D["weapon"], _id_C8616C37BC30098B, _id_BAE77D8848F4D84D["variantID"], scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4());
  return _id_DD515FCF025B2E79;
}

gun_createrandomweapon(_id_AB501F397D3CD312, _id_C8616C37BC30098B, variantid, _id_11A1FA68AEB971C0) {
  if((!isDefined(_id_C8616C37BC30098B) || !getdvarint("dvar_76D3386761EF7FB6", 0)) && !istrue(level._id_C423C2360CA0DAC5))
    _id_C8616C37BC30098B = 0;

  _id_B8215055A946EEBB = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, undefined, undefined, undefined, variantid, undefined, undefined, undefined, _id_11A1FA68AEB971C0);
  _id_952F1674FA8D734F = [];

  if(_id_C8616C37BC30098B > 0) {
    _id_72E3A98D1C7327C5 = ["visual", "modifier2"];
    _id_952F1674FA8D734F = scripts\mp\weapons::_id_8DF87E6B1D13C15A(_id_B8215055A946EEBB, _id_C8616C37BC30098B, 0, _id_72E3A98D1C7327C5, 1000);
  }

  if(_id_952F1674FA8D734F.size > 0)
    _id_B8215055A946EEBB = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, _id_952F1674FA8D734F, undefined, undefined, variantid, undefined, undefined, undefined, _id_11A1FA68AEB971C0);

  return _id_B8215055A946EEBB;
}

gun_buildoverrideattachmentlist(_id_72C4B0AF1A85887E) {
  _id_0605B3BCE83E5F38 = scripts\mp\utility\weapon::getallselectableattachments(_id_72C4B0AF1A85887E);
  _id_79583F5B5010A954 = [];

  foreach(attachment in _id_0605B3BCE83E5F38) {
    if(isstartstr(attachment, "gl") || isstartstr(attachment, "ub") || isstartstr(attachment, "thermal") || attachment == "hybrid3") {
      continue;
    }
    _id_79583F5B5010A954[_id_79583F5B5010A954.size] = attachment;
  }

  return _id_79583F5B5010A954;
}

attachmentcheck(attachment, _id_517683BAD763B676, _id_A71A84CDAD3A4EBB, weaponname) {
  _id_2C4FC9C24CCFDF3C = tablelookup(_id_A71A84CDAD3A4EBB, 0, attachment, 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_517683BAD763B676.size; _id_AC0E594AC96AA3A8++) {
    _id_E012C12F441A9C1D = tablelookup(_id_A71A84CDAD3A4EBB, 0, _id_517683BAD763B676[_id_AC0E594AC96AA3A8], 1);

    if(attachment == _id_517683BAD763B676[_id_AC0E594AC96AA3A8] || _id_2669878CF5A1B6BC::attachmentsconflict(attachment, _id_517683BAD763B676[_id_AC0E594AC96AA3A8], weaponname) != "" || _id_2C4FC9C24CCFDF3C == _id_E012C12F441A9C1D)
      return 0;
  }

  return 1;
}

giveortakethrowingknife(currentweapon) {
  scripts\mp\equipment::takeequipment("primary");

  if(scripts\cp_mp\utility\weapon_utility::isknifeonly(currentweapon) || scripts\mp\utility\weapon::isakimbomeleeweapon(currentweapon) || scripts\mp\utility\weapon::isaxeweapon(currentweapon)) {
    scripts\mp\utility\perk::giveperk("specialty_scavenger");
    scripts\mp\utility\perk::giveperk("specialty_pitcher");
    scripts\mp\equipment::giveequipment("equip_throwing_knife", "primary");
    thread scripts\mp\equipment::incrementequipmentammo("equip_throwing_knife");
  }
}

isvalidthrowingknifekill(_id_0D3B1E28744413C1) {
  return _id_0D3B1E28744413C1 == "throwingknife_mp";
}

onplayerscore(event, player, _id_353F1E80E9476419, victim, _id_7EC7671A1E0C788F) {
  player scripts\mp\utility\stats::incpersstat("gamemodeScore", _id_353F1E80E9476419);
  _id_C82F49D7E44EB40D = player scripts\mp\utility\stats::getpersstat("gamemodeScore");
  player scripts\mp\persistence::statsetchild("round", "gamemodeScore", _id_C82F49D7E44EB40D);
  score = 0;

  if(event == "gained_gun_rank")
    score = 1;
  else if(event == "dropped_gun_rank") {
    _id_51B54A87BCDA2C52 = level.setback;
    score = _id_51B54A87BCDA2C52 * -1;
  } else if(event == "assist_ffa" || event == "kill")
    player scripts\mp\utility\script::bufferednotify("earned_score_buffered", _id_353F1E80E9476419);

  return score;
}

updateknivesperminute() {
  if(!isDefined(self.knivesperminute)) {
    self.numknives = 0;
    self.knivesperminute = 0;
  }

  self.numknives++;

  if(scripts\mp\utility\game::getminutespassed() < 1) {
    return;
  }
  self.knivesperminute = self.numknives / scripts\mp\utility\game::getminutespassed();
}

modifyunifiedpointscallback(points, event, player, objweapon) {
  if(isDefined(objweapon) && (objweapon.basename == "iw9_me_knife_mp" || objweapon.basename == "iw8_me_akimboblunt_mp" || objweapon.basename == "iw8_me_akimboblades_mp")) {
    if(isDefined(player) && isDefined(player.knivesperminute) && player.knivesperminute >= 10)
      return 0;
  }

  return points;
}

canprogressingunrank(objweapon, _id_0AC0B9ADAA0D681A, _id_6A7DE031C0D6FFA9) {
  if(objweapon.basename == _id_0AC0B9ADAA0D681A)
    return 1;

  if(_id_0AC0B9ADAA0D681A == "iw8_sn_crossbow_mp") {
    if(issubstr(objweapon.basename, "bolt"))
      return 1;
  }

  if(objweapon.basename == "dragonsbreath_mp")
    return 1;

  if(isonlastkill()) {
    if(isvalidthrowingknifekill(objweapon.basename))
      return 1;

    if(_id_6A7DE031C0D6FFA9)
      return 1;
  }

  return 0;
}

isonlastkill() {
  return self.gungamegunindex == level.gun_guns.size - 1;
}