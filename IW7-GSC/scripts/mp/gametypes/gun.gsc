/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\gun.gsc
****************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 0);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  setspecialloadout();
  updategametypedvars();
  setgunladder();
  setteammode("ffa");
  level.teambased = 0;
  level.ignorekdrstats = 1;
  level.doprematch = 1;
  level.supportintel = 0;
  level.supportnuke = 0;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.ontimelimit = ::ontimelimit;
  level.onplayerscore = ::onplayerscore;
  level.bypassclasschoicefunc = ::alwaysgamemodeclass;
  level.modifyunifiedpointscallback = ::modifyunifiedpointscallback;
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "gungame";
  game["dialog"]["offense_obj"] = "killall_intro";
  game["dialog"]["defense_obj"] = "ffa_intro";
}

alwaysgamemodeclass() {
  return "gamemode";
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata(1);
  setdynamicdvar("scr_gun_setback", getmatchrulesdata("gunData", "setback"));
  setdynamicdvar("scr_gun_setbackStreak", getmatchrulesdata("gunData", "setbackStreak"));
  setdynamicdvar("scr_gun_killsPerWeapon", getmatchrulesdata("gunData", "killsPerWeapon"));
  setdynamicdvar("scr_gun_ladderIndex", getmatchrulesdata("gunData", "ladderIndex"));
  setdynamicdvar("scr_gun_promode", 0);
}

onprecachegametype() {}

onstartgametype() {
  setclientnamemode("auto_change");
  scripts\mp\utility::setobjectivetext("allies", & "OBJECTIVES_DM");
  scripts\mp\utility::setobjectivetext("axis", & "OBJECTIVES_DM");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", & "OBJECTIVES_DM");
    scripts\mp\utility::setobjectivescoretext("axis", & "OBJECTIVES_DM");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", & "OBJECTIVES_DM_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", & "OBJECTIVES_DM_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", & "OBJECTIVES_DM_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", & "OBJECTIVES_DM_HINT");
  setgunsfinal();
  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dm_spawn_start", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn_secondary", 1, 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  var_00 = [];
  scripts\mp\gameobjects::main(var_00);
  level.quickmessagetoall = 1;
  level.blockweapondrops = 1;
  level thread onplayerconnect();
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.setback = scripts\mp\utility::dvarintvalue("setback", 1, 0, 5);
  level.setbackstreak = scripts\mp\utility::dvarintvalue("setbackStreak", 0, 0, 5);
  level.killsperweapon = scripts\mp\utility::dvarintvalue("killsPerWeapon", 1, 1, 5);
  level.ladderindex = scripts\mp\utility::dvarintvalue("ladderIndex", 1, 1, 4);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread keepweaponsloaded();
    var_00.gun_firstspawn = 1;
    var_00.pers["class"] = "gamemode";
    var_00.pers["lastClass"] = "";
    var_00.class = var_00.pers["class"];
    var_00.lastclass = var_00.pers["lastClass"];
    var_00.pers["gamemodeLoadout"] = level.gun_loadouts["axis"];
    var_00.gungamegunindex = 0;
    var_00.gungameprevgunindex = 0;
    var_00 thread refillammo();
    var_00 thread refillsinglecountammo();
    var_00 scripts\mp\utility::func_F6FF(level.gun_guns[0], 1);
  }
}

keepweaponsloaded() {
  self loadweaponsforplayer([level.gun_guns[0], level.gun_guns[1]]);
  var_00 = [];
  for(;;) {
    self waittill("update_loadweapons");
    var_00[0] = level.gun_guns[int(max(0, self.gungamegunindex - level.setback))];
    var_00[1] = level.gun_guns[self.gungamegunindex];
    var_00[2] = level.gun_guns[self.gungamegunindex + 1];
    self loadweaponsforplayer(var_00);
  }
}

getspawnpoint() {
  if(isplayer(self) && self.gun_firstspawn) {
    self.gun_firstspawn = 0;
    if(scripts\engine\utility::cointoss()) {
      scripts\mp\menus::addtoteam("axis", 1);
    } else {
      scripts\mp\menus::addtoteam("allies", 1);
    }
  }

  if(level.ingraceperiod) {
    var_00 = undefined;
    var_01 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
    if(var_01.size > 0) {
      var_00 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_01, 1);
    }

    if(!isDefined(var_00)) {
      var_01 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      var_00 = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(var_01);
    }

    return var_00;
  }

  var_01 = scripts\mp\spawnlogic::getteamspawnpoints(self.pers["team"]);
  var_02 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(self.pers["team"]);
  var_00 = scripts\mp\spawnscoring::getspawnpoint(var_01, var_02);
  return var_02;
}

onspawnplayer() {
  thread waitloadoutdone();
  level notify("spawned_player");
}

waitloadoutdone() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  if(level.gameended && self.gungamegunindex == level.gun_guns.size) {
    self.gungamegunindex = self.gungameprevgunindex;
  }

  scripts\mp\utility::giveperk("specialty_bling");
  thread givenextgun(1);
}

onplayerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(level.gameended) {
    return;
  }

  if(param_03 == "MOD_FALLING" || isDefined(param_01) && isplayer(param_01)) {
    var_0A = scripts\mp\weapons::isriotshield(param_04);
    var_0B = scripts\mp\weapons::isknifeonly(param_04) || scripts\mp\weapons::isaxeweapon(param_04);
    if(!isDefined(self.ladderdeathsthisweapon)) {
      self.ladderdeathsthisweapon = 1;
    } else {
      self.ladderdeathsthisweapon++;
    }

    if(param_03 == "MOD_FALLING" || param_01 == self || param_03 == "MOD_MELEE" && var_0B || self.ladderdeathsthisweapon == level.setbackstreak) {
      self.ladderdeathsthisweapon = 0;
      self playlocalsound("mp_war_objective_lost");
      self notify("update_loadweapons");
      self.gungameprevgunindex = self.gungamegunindex;
      self.gungamegunindex = int(max(0, self.gungamegunindex - level.setback));
      if(self.gungameprevgunindex > self.gungamegunindex) {
        scripts\mp\utility::incperstat("setbacks", 1);
        scripts\mp\persistence::statsetchild("round", "setbacks", self.pers["setbacks"]);
        if(isplayer(self)) {
          scripts\mp\utility::setextrascore1(self.pers["setbacks"]);
        }

        thread scripts\mp\utility::giveunifiedpoints("dropped_gun_score", param_04, undefined, 0, 1);
        scripts\mp\utility::func_F6FF(level.gun_guns[self.gungamegunindex], 1);
      }

      if(param_03 == "MOD_MELEE") {
        if(self.gungameprevgunindex) {
          param_01 thread scripts\mp\utility::giveunifiedpoints("dropped_enemy_gun_rank");
        }

        param_01 updateknivesperminute();
        param_01 scripts\mp\awards::givemidmatchaward("mode_gun_melee");
        param_01 scripts\mp\utility::incperstat("stabs", 1);
        param_01 scripts\mp\persistence::statsetchild("round", "stabs", param_01.pers["stabs"]);
        if(isplayer(param_01)) {
          param_01 scripts\mp\utility::setextrascore0(param_01.pers["stabs"]);
        }
      }

      if(param_01 == self) {
        return;
      }
    }

    if((param_01 != self && param_03 == "MOD_PISTOL_BULLET") || param_03 == "MOD_RIFLE_BULLET" || param_03 == "MOD_HEAD_SHOT" || param_03 == "MOD_PROJECTILE" || param_03 == "MOD_PROJECTILE_SPLASH" || param_03 == "MOD_IMPACT" || param_03 == "MOD_GRENADE" || param_03 == "MOD_GRENADE_SPLASH" || param_03 == "MOD_EXPLOSIVE" || param_03 == "MOD_MELEE" && !var_0B) {
      var_0C = getweaponbasename(param_04);
      var_0D = getweaponbasename(param_01.primaryweapon);
      if(var_0C != var_0D && !param_01 isvalidthrowingknifekill(param_04)) {
        return;
      }

      if(!isDefined(param_01.ladderkillsthisweapon)) {
        param_01.ladderkillsthisweapon = 1;
      } else {
        param_01.ladderkillsthisweapon++;
      }

      if(param_01.ladderkillsthisweapon != level.killsperweapon) {
        return;
      }

      param_01.ladderkillsthisweapon = 0;
      param_01.ladderdeathsthisweapon = 0;
      param_01.gungameprevgunindex = param_01.gungamegunindex;
      param_01.gungamegunindex++;
      param_01 notify("update_loadweapons");
      param_01 thread scripts\mp\utility::giveunifiedpoints("gained_gun_score", param_04, undefined, 0, 1);
      if(param_01.gungamegunindex == level.gun_guns.size - 2) {
        level.kick_afk_check = 1;
      }

      if(param_01.gungamegunindex == level.gun_guns.size - 1) {
        scripts\mp\utility::playsoundonplayers("mp_enemy_obj_captured");
        level thread scripts\mp\utility::teamplayercardsplash("callout_top_gun_rank", param_01);
      }

      if(param_01.gungamegunindex < level.gun_guns.size) {
        var_0E = scripts\mp\rank::getscoreinfovalue("gained_gun_rank");
        param_01 thread scripts\mp\rank::scorepointspopup(var_0E);
        param_01 thread scripts\mp\rank::scoreeventpopup("gained_gun_rank");
        param_01 playlocalsound("mp_war_objective_taken");
        param_01 thread givenextgun(0);
        param_01 scripts\mp\utility::func_F6FF(level.gun_guns[param_01.gungamegunindex], 1);
      }

      if(isDefined(param_01.lastgunrankincreasetime) && gettime() - param_01.lastgunrankincreasetime < 5000) {
        param_01 scripts\mp\awards::givemidmatchaward("mode_gun_quick_kill");
      }

      param_01.lastgunrankincreasetime = gettime();
    }
  }
}

givenextgun(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(!param_00) {
    scripts\engine\utility::allow_weapon_switch(0);
  }

  var_01 = getnextgun();
  var_01 = scripts\mp\weapons::updatesavedaltstate(var_01);
  scripts\mp\utility::_giveweapon(var_01);
  if(param_00) {
    self setspawnweapon(var_01);
    foreach(var_03 in self.weaponlist) {
      if(var_03 != var_01) {
        thread scripts\mp\utility::takeweaponwhensafe(var_03);
      }
    }
  }

  self.pers["primaryWeapon"] = var_01;
  self.primaryweapon = var_01;
  scripts\mp\utility::_switchtoweapon(var_01);
  var_05 = scripts\mp\weapons::isaxeweapon(var_01);
  if(var_05) {
    self setweaponammoclip(var_01, 1);
    thread takeweaponwhensafegungame("iw7_knife_mp_gg", 0);
  } else if(self.gungamegunindex != level.gun_guns.size - 1) {
    self givestartammo(var_01);
    self giveweapon("iw7_knife_mp_gg");
    self assignweaponmeleeslot("iw7_knife_mp_gg");
  }

  if(!param_00) {
    var_06 = self.lastdroppableweaponobj;
    thread takeweaponwhensafegungame(var_06, 1);
  }

  giveortakethrowingknife(var_01);
  scripts\mp\weapons::updatetogglescopestate(var_01);
  self.gungameprevgunindex = self.gungamegunindex;
}

takeweaponwhensafegungame(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    if(!scripts\mp\utility::iscurrentweapon(param_00)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\mp\utility::_takeweapon(param_00);
  if(param_01) {
    scripts\engine\utility::allow_weapon_switch(1);
  }
}

getnextgun() {
  var_00 = level.gun_guns[self.gungamegunindex];
  return var_00;
}

ontimelimit() {
  var_00 = gethighestprogressedplayers();
  if(!isDefined(var_00) || !var_00.size) {
    thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(var_00.size == 1) {
    thread scripts\mp\gamelogic::endgame(var_00[0], game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(var_00[var_00.size - 1].gungamegunindex > var_00[var_00.size - 2].gungamegunindex) {
    thread scripts\mp\gamelogic::endgame(var_00[var_00.size - 1], game["end_reason"]["time_limit_reached"]);
    return;
  }

  thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
}

gethighestprogressedplayers() {
  var_00 = -1;
  var_01 = [];
  foreach(var_03 in level.players) {
    if(isDefined(var_03.gungamegunindex) && var_03.gungamegunindex >= var_00) {
      var_00 = var_03.gungamegunindex;
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

refillammo() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("reload");
    self givestartammo(self.primaryweapon);
  }
}

refillsinglecountammo() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    if(scripts\mp\utility::isreallyalive(self) && self.team != "spectator" && isDefined(self.primaryweapon) && self getrunningforwardpainanim(self.primaryweapon) == 0) {
      if(getweaponbasename(self.primaryweapon) == "iw7_glprox_mp") {
        self givemaxammo(self.primaryweapon);
      } else {
        wait(2);
        self notify("reload");
        wait(1);
      }

      continue;
    }

    wait(0.05);
  }
}

setgunladder() {
  level.gun_guns = [];
  level.selectedweapons = [];
  switch (level.ladderindex) {
    case 1:
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
      level.gun_guns[13] = "rand_shotgun";
      level.gun_guns[14] = "rand_assault";
      level.gun_guns[15] = "rand_sniper";
      level.gun_guns[16] = "iw7_g18_mpr";
      level.gun_guns[17] = "iw7_knife_mp";
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
      level.gun_guns[9] = "rand_shotgun";
      level.gun_guns[10] = "rand_smg";
      level.gun_guns[11] = "rand_assault";
      level.gun_guns[12] = "rand_pistol";
      level.gun_guns[13] = "rand_shotgun";
      level.gun_guns[14] = "rand_smg";
      level.gun_guns[15] = "rand_assault";
      level.gun_guns[16] = "iw7_g18_mpr";
      level.gun_guns[17] = "iw7_knife_mp";
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
      level.gun_guns[12] = "rand_sniper";
      level.gun_guns[13] = "rand_assault";
      level.gun_guns[14] = "rand_sniper";
      level.gun_guns[15] = "rand_assault";
      level.gun_guns[16] = "iw7_g18_mpl_single";
      level.gun_guns[17] = "iw7_knife_mp";
      break;

    case 4:
      level.gun_guns[0] = "rand_pistol_epic";
      level.gun_guns[1] = "rand_shotgun";
      level.gun_guns[2] = "rand_smg";
      level.gun_guns[3] = "rand_assault";
      level.gun_guns[4] = "rand_lmg";
      level.gun_guns[5] = "rand_sniper";
      level.gun_guns[6] = "rand_smg";
      level.gun_guns[7] = "rand_assault";
      level.gun_guns[8] = "rand_lmg";
      level.gun_guns[9] = "rand_smg";
      level.gun_guns[10] = "rand_shotgun";
      level.gun_guns[11] = "rand_smg";
      level.gun_guns[12] = "rand_assault";
      level.gun_guns[13] = "rand_shotgun";
      level.gun_guns[14] = "rand_assault";
      level.gun_guns[15] = "rand_sniper";
      level.gun_guns[16] = "rand_pistol_epic2";
      level.gun_guns[17] = "rand_melee_end_epic";
      break;
  }

  var_00 = level.gun_guns.size;
  setdynamicdvar("scr_gun_scorelimit", var_00);
  scripts\mp\utility::registerscorelimitdvar(level.gametype, var_00);
}

setgunsfinal() {
  level.selectedweapons = [];
  buildrandomweapontable();
  for(var_00 = 0; var_00 < level.gun_guns.size; var_00++) {
    var_01 = level.gun_guns[var_00];
    if(scripts\mp\utility::isstrstart(var_01, "rand_")) {
      level.gun_guns[var_00] = getrandomweaponfromcategory(var_01);
      continue;
    }

    var_02 = scripts\mp\utility::getweaponrootname(level.gun_guns[var_00]);
    level.selectedweapons[var_02] = 1;
    var_03 = var_02;
    var_04 = 0;
    var_03 = modifyweapon(var_03, var_04);
    level.gun_guns[var_00] = var_03;
  }

  level.selectedweapons = undefined;
}

getrandomarchetype() {
  var_00 = randomint(120);
  if(var_00 > 100) {
    return "archetype_heavy";
  }

  if(var_00 > 80) {
    return "archetype_scout";
  }

  if(var_00 > 60) {
    return "archetype_assassin";
  }

  if(var_00 > 40) {
    return "archetype_engineer";
  }

  if(var_00 > 20) {
    return "archetype_sniper";
  }

  return "archetype_assault";
}

setspecialloadout() {
  level.gun_loadouts["axis"]["loadoutPrimary"] = "iw7_revolver";
  level.gun_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondary"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
  level.gun_loadouts["axis"]["loadoutEquipment"] = "specialty_null";
  level.gun_loadouts["axis"]["loadoutOffhand"] = "none";
  level.gun_loadouts["axis"]["loadoutStreakType"] = "assault";
  level.gun_loadouts["axis"]["loadoutKillstreak1"] = "none";
  level.gun_loadouts["axis"]["loadoutKillstreak2"] = "none";
  level.gun_loadouts["axis"]["loadoutKillstreak3"] = "none";
  level.gun_loadouts["axis"]["loadoutPerks"] = [];
  level.gun_loadouts["axis"]["loadoutGesture"] = "playerData";
  level.gun_loadouts["axis"]["loadoutJuggernaut"] = 0;
  level.gun_loadouts["allies"] = level.gun_loadouts["axis"];
}

buildrandomweapontable() {
  level.weaponcategories = [];
  var_00 = 0;
  for(;;) {
    var_01 = tablelookupbyrow("mp\gunGameWeapons.csv", var_00, 0);
    if(var_01 == "") {
      break;
    }

    if(!isDefined(level.weaponcategories[var_01])) {
      level.weaponcategories[var_01] = [];
    }

    var_02 = tablelookupbyrow("mp\gunGameWeapons.csv", var_00, 5);
    if(var_02 == "" || getdvarint(var_02, 0) == 1) {
      var_03 = [];
      var_03["weapon"] = tablelookupbyrow("mp\gunGameWeapons.csv", var_00, 1);
      var_03["min"] = int(tablelookupbyrow("mp\gunGameWeapons.csv", var_00, 2));
      var_03["max"] = int(tablelookupbyrow("mp\gunGameWeapons.csv", var_00, 3));
      var_03["perk"] = tablelookupbyrow("mp\gunGameWeapons.csv", var_00, 4);
      var_03["variant"] = getlootvariant(var_03["weapon"]);
      var_03["allowed"] = int(tablelookupbyrow("mp\gunGameWeapons.csv", var_00, 7));
      if(level.ladderindex == 4 && var_03["variant"] == "") {
        var_00++;
        continue;
      }

      level.weaponcategories[var_01][level.weaponcategories[var_01].size] = var_03;
    }

    var_00++;
  }
}

getrandomweaponfromcategory(param_00) {
  var_01 = level.weaponcategories[param_00];
  if(isDefined(var_01) && var_01.size > 0) {
    var_02 = "";
    var_03 = undefined;
    var_04 = 0;
    for(;;) {
      var_05 = randomintrange(0, var_01.size);
      var_03 = var_01[var_05];
      var_06 = scripts\mp\utility::getweaponrootname(var_03["weapon"]);
      var_07 = 1;
      if(level.ladderindex == 4) {
        var_07 = var_03["allowed"];
      }

      if((!isDefined(level.selectedweapons[var_06]) && var_07) || var_04 > var_01.size) {
        level.selectedweapons[var_06] = 1;
        var_02 = var_03["weapon"];
        for(var_08 = 0; var_08 < level.weaponcategories[param_00].size; var_08++) {
          if(level.weaponcategories[param_00][var_08]["weapon"] == var_02) {
            level.weaponcategories[param_00] = scripts\mp\utility::array_remove_index(level.weaponcategories[param_00], var_08);
            break;
          }
        }

        break;
      }

      var_04++;
    }

    if(var_02 == var_06) {
      var_09 = randomintrange(var_03["min"], var_03["max"] + 1);
      var_02 = modifyweapon(var_02, var_09, var_03);
    }

    return var_02;
  }

  return "none";
}

getlootvariant(param_00) {
  var_01 = [];
  var_02 = "";
  var_03 = scripts\mp\utility::getweaponrootname(param_00);
  var_01 = tablelookup("mp\gunGameWeapons.csv", 1, var_03, 6);
  if(var_01.size > 0) {
    if(var_01.size > 1) {
      var_01 = strtok(var_01, "+");
      var_02 = scripts\engine\utility::random(var_01);
    } else {
      var_02 = var_01[0];
    }

    var_04 = "mp\loot\weapon\" + var_03 + ".csv ";
    var_05 = tablelookup(var_04, 0, int(var_02), 1);
    var_06 = tablelookup("mp\loot\iw7_weapon_loot_master.csv", 1, var_05, 1);
    if(var_06 == "") {
      var_02 = "";
    }
  }

  return var_02;
}

checkmk2variant(param_00, param_01) {
  var_02 = tablelookup(param_00, 0, int(param_01), 1);
  if(issubstr(var_02, "mk2stub")) {
    return param_01;
  }

  var_03 = randomint(100);
  if(var_03 < 25) {
    var_04 = int(param_01);
    var_04 = var_04 + 32;
    param_01 = tablelookup(param_00, 0, var_04, 0);
  }

  return param_01;
}

modifyweapon(param_00, param_01, param_02) {
  var_03 = [];
  var_04 = 0;
  var_05 = level.ladderindex == 4;
  var_06 = "";
  if(isDefined(param_02) && param_02["variant"] != "") {
    var_06 = param_02["variant"];
  }

  var_07 = var_06 != "";
  var_08 = "mp\loot\weapon\" + param_00 + ".csv ";
  if(param_01 > 0) {
    var_09 = scripts\mp\utility::getweaponattachmentarrayfromstats(param_00);
    if(var_09.size > 0) {
      var_0A = getvalidattachments(var_09, var_05, param_00, var_08, var_06);
      var_0B = var_0A.size;
      for(var_0C = 0; var_0C < param_01; var_0C++) {
        var_0D = "";
        while(var_0D == "" && var_0B > 0) {
          var_0B--;
          var_0E = randomint(var_0A.size);
          if(attachmentcheck(var_0A[var_0E], var_03)) {
            var_0D = var_0A[var_0E];
            var_03[var_03.size] = var_0D;
            if(scripts\mp\utility::getattachmenttype(var_0D) == "rail") {
              var_04 = 1;
            }
          }
        }
      }
    }
  }

  var_0F = "none";
  var_10 = "none";
  if(scripts\mp\utility::istrue(var_05) && var_07) {
    var_11 = scripts\mp\class::buildweaponname(param_00, var_03, var_0F, var_10, int(var_06));
  } else {
    var_11 = scripts\mp\class::buildweaponname(param_01, var_04, var_10, var_11);
  }

  return var_11;
}

attachmentcheck(param_00, param_01) {
  for(var_02 = 0; var_02 < param_01.size; var_02++) {
    if(param_00 == param_01[var_02] || !scripts\mp\utility::attachmentscompatible(param_00, param_01[var_02])) {
      return 0;
    }
  }

  return 1;
}

getvalidattachments(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [];
  var_06 = [];
  var_07 = [];
  if(scripts\mp\utility::istrue(param_01) && param_04 != "") {
    var_06 = tablelookup(param_03, 0, int(param_04), 17);
    var_06 = strtok(var_06, "+");
    var_07 = tablelookup(param_03, 0, int(param_04), 18);
    var_07 = strtok(var_07, "+");
    for(var_08 = 0; var_08 < var_06.size; var_08++) {
      var_06[var_08] = scripts\mp\utility::attachmentmap_tobase(var_06[var_08]);
    }
  }

  foreach(var_0A in param_00) {
    var_0B = scripts\mp\utility::getattachmenttype(var_0A);
    if(var_07.size > 0 && scripts\engine\utility::array_contains(var_07, var_0B)) {
      continue;
    }

    if(var_06.size > 0 && scripts\engine\utility::array_contains(var_06, var_0A)) {
      continue;
    }

    switch (var_0A) {
      case "silencer":
        break;

      default:
        var_05[var_05.size] = var_0A;
        break;
    }
  }

  return var_05;
}

giveortakethrowingknife(param_00) {
  var_01 = "primary";
  var_02 = scripts\mp\powers::getcurrentequipment(var_01);
  if(isDefined(var_02)) {
    scripts\mp\powers::removepower(var_02);
  }

  if(scripts\mp\weapons::isknifeonly(param_00) || scripts\mp\weapons::isaxeweapon(param_00)) {
    scripts\mp\utility::giveperk("specialty_scavenger");
    scripts\mp\utility::giveperk("specialty_pitcher");
    scripts\mp\powers::givepower("power_bioSpike", var_01, undefined, undefined, 1);
  }
}

isvalidthrowingknifekill(param_00) {
  return param_00 == "throwingknifec4_mp";
}

onplayerscore(param_00, param_01, param_02) {
  param_01 scripts\mp\utility::incperstat("gamemodeScore", param_02, 1);
  var_03 = param_01 scripts\mp\utility::getpersstat("gamemodeScore");
  param_01 scripts\mp\persistence::statsetchild("round", "gamemodeScore", var_03);
  var_04 = 0;
  if(param_00 == "gained_gun_score") {
    var_04 = 1;
  } else if(param_00 == "dropped_gun_score") {
    var_05 = level.setback;
    var_04 = var_05 * -1;
  } else if(param_00 == "assist_ffa" || param_00 == "kill") {
    param_01 scripts\mp\utility::bufferednotify("earned_score_buffered", param_02);
  }

  return var_04;
}

updateknivesperminute() {
  if(!isDefined(self.knivesperminute)) {
    self.numknives = 0;
    self.knivesperminute = 0;
  }

  self.numknives++;
  if(scripts\mp\utility::getminutespassed() < 1) {
    return;
  }

  self.knivesperminute = self.numknives / scripts\mp\utility::getminutespassed();
}

modifyunifiedpointscallback(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03) && param_03 == "iw7_knife_mp_gg" || param_03 == "iw7_knife_mp") {
    if(isDefined(param_02) && isDefined(param_02.knivesperminute) && param_02.knivesperminute >= 10) {
      return 0;
    }
  }

  return param_00;
}