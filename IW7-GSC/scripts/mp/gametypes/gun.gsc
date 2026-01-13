/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\gun.gsc
*********************************************/

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
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
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
  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_DM");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_DM");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_DM");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_DM");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_DM_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_DM_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_DM_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_DM_HINT");
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
  var_0 = [];
  scripts\mp\gameobjects::main(var_0);
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
    level waittill("connected", var_0);
    var_0 thread keepweaponsloaded();
    var_0.gun_firstspawn = 1;
    var_0.pers["class"] = "gamemode";
    var_0.pers["lastClass"] = "";
    var_0.class = var_0.pers["class"];
    var_0.lastclass = var_0.pers["lastClass"];
    var_0.pers["gamemodeLoadout"] = level.gun_loadouts["axis"];
    var_0.gungamegunindex = 0;
    var_0.gungameprevgunindex = 0;
    var_0 thread refillammo();
    var_0 thread refillsinglecountammo();
    var_0 scripts\mp\utility::func_F6FF(level.gun_guns[0], 1);
  }
}

keepweaponsloaded() {
  self loadweaponsforplayer([level.gun_guns[0], level.gun_guns[1]]);
  var_0 = [];
  for(;;) {
    self waittill("update_loadweapons");
    var_0[0] = level.gun_guns[int(max(0, self.gungamegunindex - level.setback))];
    var_0[1] = level.gun_guns[self.gungamegunindex];
    var_0[2] = level.gun_guns[self.gungamegunindex + 1];
    self loadweaponsforplayer(var_0);
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
    var_0 = undefined;
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
    if(var_1.size > 0) {
      var_0 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1, 1);
    }

    if(!isDefined(var_0)) {
      var_1 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      var_0 = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(var_1);
    }

    return var_0;
  }

  var_1 = scripts\mp\spawnlogic::getteamspawnpoints(self.pers["team"]);
  var_2 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(self.pers["team"]);
  var_0 = scripts\mp\spawnscoring::getspawnpoint(var_1, var_2);
  return var_2;
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

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(level.gameended) {
    return;
  }

  if(var_3 == "MOD_FALLING" || isDefined(var_1) && isplayer(var_1)) {
    var_0A = scripts\mp\weapons::isriotshield(var_4);
    var_0B = scripts\mp\weapons::isknifeonly(var_4) || scripts\mp\weapons::isaxeweapon(var_4);
    if(!isDefined(self.ladderdeathsthisweapon)) {
      self.ladderdeathsthisweapon = 1;
    } else {
      self.ladderdeathsthisweapon++;
    }

    if(var_3 == "MOD_FALLING" || var_1 == self || var_3 == "MOD_MELEE" && var_0B || self.ladderdeathsthisweapon == level.setbackstreak) {
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

        thread scripts\mp\utility::giveunifiedpoints("dropped_gun_score", var_4, undefined, 0, 1);
        scripts\mp\utility::func_F6FF(level.gun_guns[self.gungamegunindex], 1);
      }

      if(var_3 == "MOD_MELEE") {
        if(self.gungameprevgunindex) {
          var_1 thread scripts\mp\utility::giveunifiedpoints("dropped_enemy_gun_rank");
        }

        var_1 updateknivesperminute();
        var_1 scripts\mp\awards::givemidmatchaward("mode_gun_melee");
        var_1 scripts\mp\utility::incperstat("stabs", 1);
        var_1 scripts\mp\persistence::statsetchild("round", "stabs", var_1.pers["stabs"]);
        if(isplayer(var_1)) {
          var_1 scripts\mp\utility::setextrascore0(var_1.pers["stabs"]);
        }
      }

      if(var_1 == self) {
        return;
      }
    }

    if((var_1 != self && var_3 == "MOD_PISTOL_BULLET") || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_HEAD_SHOT" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH" || var_3 == "MOD_IMPACT" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_MELEE" && !var_0B) {
      var_0C = getweaponbasename(var_4);
      var_0D = getweaponbasename(var_1.primaryweapon);
      if(var_0C != var_0D && !var_1 isvalidthrowingknifekill(var_4)) {
        return;
      }

      if(!isDefined(var_1.ladderkillsthisweapon)) {
        var_1.ladderkillsthisweapon = 1;
      } else {
        var_1.ladderkillsthisweapon++;
      }

      if(var_1.ladderkillsthisweapon != level.killsperweapon) {
        return;
      }

      var_1.ladderkillsthisweapon = 0;
      var_1.ladderdeathsthisweapon = 0;
      var_1.gungameprevgunindex = var_1.gungamegunindex;
      var_1.gungamegunindex++;
      var_1 notify("update_loadweapons");
      var_1 thread scripts\mp\utility::giveunifiedpoints("gained_gun_score", var_4, undefined, 0, 1);
      if(var_1.gungamegunindex == level.gun_guns.size - 2) {
        level.kick_afk_check = 1;
      }

      if(var_1.gungamegunindex == level.gun_guns.size - 1) {
        scripts\mp\utility::playsoundonplayers("mp_enemy_obj_captured");
        level thread scripts\mp\utility::teamplayercardsplash("callout_top_gun_rank", var_1);
      }

      if(var_1.gungamegunindex < level.gun_guns.size) {
        var_0E = scripts\mp\rank::getscoreinfovalue("gained_gun_rank");
        var_1 thread scripts\mp\rank::scorepointspopup(var_0E);
        var_1 thread scripts\mp\rank::scoreeventpopup("gained_gun_rank");
        var_1 playlocalsound("mp_war_objective_taken");
        var_1 thread givenextgun(0);
        var_1 scripts\mp\utility::func_F6FF(level.gun_guns[var_1.gungamegunindex], 1);
      }

      if(isDefined(var_1.lastgunrankincreasetime) && gettime() - var_1.lastgunrankincreasetime < 5000) {
        var_1 scripts\mp\awards::givemidmatchaward("mode_gun_quick_kill");
      }

      var_1.lastgunrankincreasetime = gettime();
    }
  }
}

givenextgun(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(!var_0) {
    scripts\engine\utility::allow_weapon_switch(0);
  }

  var_1 = getnextgun();
  var_1 = scripts\mp\weapons::updatesavedaltstate(var_1);
  scripts\mp\utility::_giveweapon(var_1);
  if(var_0) {
    self setspawnweapon(var_1);
    foreach(var_3 in self.weaponlist) {
      if(var_3 != var_1) {
        thread scripts\mp\utility::takeweaponwhensafe(var_3);
      }
    }
  }

  self.pers["primaryWeapon"] = var_1;
  self.primaryweapon = var_1;
  scripts\mp\utility::_switchtoweapon(var_1);
  var_5 = scripts\mp\weapons::isaxeweapon(var_1);
  if(var_5) {
    self setweaponammoclip(var_1, 1);
    thread takeweaponwhensafegungame("iw7_knife_mp_gg", 0);
  } else if(self.gungamegunindex != level.gun_guns.size - 1) {
    self givestartammo(var_1);
    self giveweapon("iw7_knife_mp_gg");
    self assignweaponmeleeslot("iw7_knife_mp_gg");
  }

  if(!var_0) {
    var_6 = self.lastdroppableweaponobj;
    thread takeweaponwhensafegungame(var_6, 1);
  }

  giveortakethrowingknife(var_1);
  scripts\mp\weapons::updatetogglescopestate(var_1);
  self.gungameprevgunindex = self.gungamegunindex;
}

takeweaponwhensafegungame(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    if(!scripts\mp\utility::iscurrentweapon(var_0)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\mp\utility::_takeweapon(var_0);
  if(var_1) {
    scripts\engine\utility::allow_weapon_switch(1);
  }
}

getnextgun() {
  var_0 = level.gun_guns[self.gungamegunindex];
  return var_0;
}

ontimelimit() {
  var_0 = gethighestprogressedplayers();
  if(!isDefined(var_0) || !var_0.size) {
    thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(var_0.size == 1) {
    thread scripts\mp\gamelogic::endgame(var_0[0], game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(var_0[var_0.size - 1].gungamegunindex > var_0[var_0.size - 2].gungamegunindex) {
    thread scripts\mp\gamelogic::endgame(var_0[var_0.size - 1], game["end_reason"]["time_limit_reached"]);
    return;
  }

  thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
}

gethighestprogressedplayers() {
  var_0 = -1;
  var_1 = [];
  foreach(var_3 in level.players) {
    if(isDefined(var_3.gungamegunindex) && var_3.gungamegunindex >= var_0) {
      var_0 = var_3.gungamegunindex;
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
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

  var_0 = level.gun_guns.size;
  setdynamicdvar("scr_gun_scorelimit", var_0);
  scripts\mp\utility::registerscorelimitdvar(level.gametype, var_0);
}

setgunsfinal() {
  level.selectedweapons = [];
  buildrandomweapontable();
  for(var_0 = 0; var_0 < level.gun_guns.size; var_0++) {
    var_1 = level.gun_guns[var_0];
    if(scripts\mp\utility::isstrstart(var_1, "rand_")) {
      level.gun_guns[var_0] = getrandomweaponfromcategory(var_1);
      continue;
    }

    var_2 = scripts\mp\utility::getweaponrootname(level.gun_guns[var_0]);
    level.selectedweapons[var_2] = 1;
    var_3 = var_2;
    var_4 = 0;
    var_3 = modifyweapon(var_3, var_4);
    level.gun_guns[var_0] = var_3;
  }

  level.selectedweapons = undefined;
}

getrandomarchetype() {
  var_0 = randomint(120);
  if(var_0 > 100) {
    return "archetype_heavy";
  }

  if(var_0 > 80) {
    return "archetype_scout";
  }

  if(var_0 > 60) {
    return "archetype_assassin";
  }

  if(var_0 > 40) {
    return "archetype_engineer";
  }

  if(var_0 > 20) {
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
  var_0 = 0;
  for(;;) {
    var_1 = tablelookupbyrow("mp\gunGameWeapons.csv", var_0, 0);
    if(var_1 == "") {
      break;
    }

    if(!isDefined(level.weaponcategories[var_1])) {
      level.weaponcategories[var_1] = [];
    }

    var_2 = tablelookupbyrow("mp\gunGameWeapons.csv", var_0, 5);
    if(var_2 == "" || getdvarint(var_2, 0) == 1) {
      var_3 = [];
      var_3["weapon"] = tablelookupbyrow("mp\gunGameWeapons.csv", var_0, 1);
      var_3["min"] = int(tablelookupbyrow("mp\gunGameWeapons.csv", var_0, 2));
      var_3["max"] = int(tablelookupbyrow("mp\gunGameWeapons.csv", var_0, 3));
      var_3["perk"] = tablelookupbyrow("mp\gunGameWeapons.csv", var_0, 4);
      var_3["variant"] = getlootvariant(var_3["weapon"]);
      var_3["allowed"] = int(tablelookupbyrow("mp\gunGameWeapons.csv", var_0, 7));
      if(level.ladderindex == 4 && var_3["variant"] == "") {
        var_0++;
        continue;
      }

      level.weaponcategories[var_1][level.weaponcategories[var_1].size] = var_3;
    }

    var_0++;
  }
}

getrandomweaponfromcategory(var_0) {
  var_1 = level.weaponcategories[var_0];
  if(isDefined(var_1) && var_1.size > 0) {
    var_2 = "";
    var_3 = undefined;
    var_4 = 0;
    for(;;) {
      var_5 = randomintrange(0, var_1.size);
      var_3 = var_1[var_5];
      var_6 = scripts\mp\utility::getweaponrootname(var_3["weapon"]);
      var_7 = 1;
      if(level.ladderindex == 4) {
        var_7 = var_3["allowed"];
      }

      if((!isDefined(level.selectedweapons[var_6]) && var_7) || var_4 > var_1.size) {
        level.selectedweapons[var_6] = 1;
        var_2 = var_3["weapon"];
        for(var_8 = 0; var_8 < level.weaponcategories[var_0].size; var_8++) {
          if(level.weaponcategories[var_0][var_8]["weapon"] == var_2) {
            level.weaponcategories[var_0] = scripts\mp\utility::array_remove_index(level.weaponcategories[var_0], var_8);
            break;
          }
        }

        break;
      }

      var_4++;
    }

    if(var_2 == var_6) {
      var_9 = randomintrange(var_3["min"], var_3["max"] + 1);
      var_2 = modifyweapon(var_2, var_9, var_3);
    }

    return var_2;
  }

  return "none";
}

getlootvariant(var_0) {
  var_1 = [];
  var_2 = "";
  var_3 = scripts\mp\utility::getweaponrootname(var_0);
  var_1 = tablelookup("mp\gunGameWeapons.csv", 1, var_3, 6);
  if(var_1.size > 0) {
    if(var_1.size > 1) {
      var_1 = strtok(var_1, "+");
      var_2 = scripts\engine\utility::random(var_1);
    } else {
      var_2 = var_1[0];
    }

    var_4 = "mp\loot\weapon\" + var_3 + ".csv ";
    var_5 = tablelookup(var_4, 0, int(var_2), 1);
    var_6 = tablelookup("mp\loot\iw7_weapon_loot_master.csv", 1, var_5, 1);
    if(var_6 == "") {
      var_2 = "";
    }
  }

  return var_2;
}

checkmk2variant(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, int(var_1), 1);
  if(issubstr(var_2, "mk2stub")) {
    return var_1;
  }

  var_3 = randomint(100);
  if(var_3 < 25) {
    var_4 = int(var_1);
    var_4 = var_4 + 32;
    var_1 = tablelookup(var_0, 0, var_4, 0);
  }

  return var_1;
}

modifyweapon(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;
  var_5 = level.ladderindex == 4;
  var_6 = "";
  if(isDefined(var_2) && var_2["variant"] != "") {
    var_6 = var_2["variant"];
  }

  var_7 = var_6 != "";
  var_8 = "mp\loot\weapon\" + var_0 + ".csv ";
  if(var_1 > 0) {
    var_9 = scripts\mp\utility::getweaponattachmentarrayfromstats(var_0);
    if(var_9.size > 0) {
      var_0A = getvalidattachments(var_9, var_5, var_0, var_8, var_6);
      var_0B = var_0A.size;
      for(var_0C = 0; var_0C < var_1; var_0C++) {
        var_0D = "";
        while(var_0D == "" && var_0B > 0) {
          var_0B--;
          var_0E = randomint(var_0A.size);
          if(attachmentcheck(var_0A[var_0E], var_3)) {
            var_0D = var_0A[var_0E];
            var_3[var_3.size] = var_0D;
            if(scripts\mp\utility::getattachmenttype(var_0D) == "rail") {
              var_4 = 1;
            }
          }
        }
      }
    }
  }

  var_0F = "none";
  var_10 = "none";
  if(scripts\mp\utility::istrue(var_5) && var_7) {
    var_11 = scripts\mp\class::buildweaponname(var_0, var_3, var_0F, var_10, int(var_6));
  } else {
    var_11 = scripts\mp\class::buildweaponname(var_1, var_4, var_10, var_11);
  }

  return var_11;
}

attachmentcheck(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2] || !scripts\mp\utility::attachmentscompatible(var_0, var_1[var_2])) {
      return 0;
    }
  }

  return 1;
}

getvalidattachments(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = [];
  var_7 = [];
  if(scripts\mp\utility::istrue(var_1) && var_4 != "") {
    var_6 = tablelookup(var_3, 0, int(var_4), 17);
    var_6 = strtok(var_6, "+");
    var_7 = tablelookup(var_3, 0, int(var_4), 18);
    var_7 = strtok(var_7, "+");
    for(var_8 = 0; var_8 < var_6.size; var_8++) {
      var_6[var_8] = scripts\mp\utility::attachmentmap_tobase(var_6[var_8]);
    }
  }

  foreach(var_0A in var_0) {
    var_0B = scripts\mp\utility::getattachmenttype(var_0A);
    if(var_7.size > 0 && scripts\engine\utility::array_contains(var_7, var_0B)) {
      continue;
    }

    if(var_6.size > 0 && scripts\engine\utility::array_contains(var_6, var_0A)) {
      continue;
    }

    switch (var_0A) {
      case "silencer":
        break;

      default:
        var_5[var_5.size] = var_0A;
        break;
    }
  }

  return var_5;
}

giveortakethrowingknife(var_0) {
  var_1 = "primary";
  var_2 = scripts\mp\powers::getcurrentequipment(var_1);
  if(isDefined(var_2)) {
    scripts\mp\powers::removepower(var_2);
  }

  if(scripts\mp\weapons::isknifeonly(var_0) || scripts\mp\weapons::isaxeweapon(var_0)) {
    scripts\mp\utility::giveperk("specialty_scavenger");
    scripts\mp\utility::giveperk("specialty_pitcher");
    scripts\mp\powers::givepower("power_bioSpike", var_1, undefined, undefined, 1);
  }
}

isvalidthrowingknifekill(var_0) {
  return var_0 == "throwingknifec4_mp";
}

onplayerscore(var_0, var_1, var_2) {
  var_1 scripts\mp\utility::incperstat("gamemodeScore", var_2, 1);
  var_3 = var_1 scripts\mp\utility::getpersstat("gamemodeScore");
  var_1 scripts\mp\persistence::statsetchild("round", "gamemodeScore", var_3);
  var_4 = 0;
  if(var_0 == "gained_gun_score") {
    var_4 = 1;
  } else if(var_0 == "dropped_gun_score") {
    var_5 = level.setback;
    var_4 = var_5 * -1;
  } else if(var_0 == "assist_ffa" || var_0 == "kill") {
    var_1 scripts\mp\utility::bufferednotify("earned_score_buffered", var_2);
  }

  return var_4;
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

modifyunifiedpointscallback(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && var_3 == "iw7_knife_mp_gg" || var_3 == "iw7_knife_mp") {
    if(isDefined(var_2) && isDefined(var_2.knivesperminute) && var_2.knivesperminute >= 10) {
      return 0;
    }
  }

  return var_0;
}