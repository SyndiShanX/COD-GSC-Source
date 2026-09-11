/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\gun.gsc
***********************************************/

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0 = [];
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
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
  level.loadoutdefaultfiresalediscount = 1;
  thread waitthensetstatgroupreadonly();
  level.doprematch = 1;
  level.supportintel = 0;
  level.supportnuke = 0;
  level.disablecopycatloadout = 1;
  setomnvar("ui_killcam_copycat", 0);
  level.onprecachegametype = &onprecachegametype;
  level.onstartgametype = &onstartgametype;
  level.onplayerconnect = &onplayerconnect;
  level.modeonspawnplayer = &onspawnplayer;
  level.getspawnpoint = &getspawnpoint;
  level.onplayerkilled = &onplayerkilled;
  level.ontimelimit = &ontimelimit;
  level.onplayerscore = &onplayerscore;
  level.bypassclasschoicefunc = &alwaysgamemodeclass;
  level.modifyunifiedpointscallback = &modifyunifiedpointscallback;
  game["dialog"]["gametype"] = "gametype_gungame";
  game["dialog"]["boost"] = "boost_gungame";
  game["dialog"]["offense_obj"] = "boost_gungame";
  game["dialog"]["defense_obj"] = "boost_gungame";
  game["dialog"]["lasttier_enemy"] = "lasttier_enemy";
  game["dialog"]["lasttier_friendly"] = "lasttier_friendly";
}

function waitthensetstatgroupreadonly() {
  self endon("game_ended");
  wait 1;

  if(isDefined(level.playerstats)) {
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("kdr");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("losses");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("winLoss");
    return;
  }
}

function alwaysgamemodeclass() {
  return "gamemode";
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata(1);
  setdynamicdvar("scr_gun_setback", getmatchrulesdata("gunData", "setback"));
  setdynamicdvar("scr_gun_setbackStreak", getmatchrulesdata("gunData", "setbackStreak"));
  setdynamicdvar("scr_gun_killsPerWeapon", getmatchrulesdata("gunData", "killsPerWeapon"));
  setdynamicdvar("scr_gun_ladderIndex", getmatchrulesdata("gunData", "ladderIndex"));
  setdynamicdvar("scr_gun_promode", 0);
}

function onprecachegametype() {}

function onstartgametype() {
  setclientnamemode("auto_change");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"OBJECTIVES/DM");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/DM");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/DM_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"OBJECTIVES/DM_HINT");
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
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  var_4 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var_3);
  scripts\mp\spawnlogic::registerspawnset("fallback", var_4);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.quickmessagetoall = 1;
  level.blockweapondrops = 1;
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.setback = scripts\mp\utility\dvars::dvarintvalue("setback", 1, 0, 5);
  level.setbackstreak = scripts\mp\utility\dvars::dvarintvalue("setbackStreak", 0, 0, 5);
  level.killsperweapon = scripts\mp\utility\dvars::dvarintvalue("killsPerWeapon", 1, 1, 5);
  level.ladderindex = scripts\mp\utility\dvars::dvarintvalue("ladderIndex", 1, 1, 6);
}

function onplayerconnect(var_0) {
  thread keepweaponsloaded();
  var_0.pers["class"] = "gamemode";
  var_0.pers["lastClass"] = "";
  var_0.class = var_0.pers["class"];
  var_0.lastclass = var_0.pers["lastClass"];
  var_0.pers["gamemodeLoadout"] = level.gun_loadouts["axis"];
  var_0.gungamegunindex = 0;
  var_0.gungameprevgunindex = 0;
  thread refillammo();
  thread refillsinglecountammo();
}

function keepweaponsloaded() {
  self loadweaponsforplayer([level.gun_guns[0], level.gun_guns[1]], 1);
  var_0 = [];
  self waittill("update_loadweapons");
  GscBinSkip0(0x2e, 0, level.gun_guns[int(max(0, self.gungamegunindex - level.setback))]);
}

function getspawnpoint() {
  if(level.ingraceperiod) {
    var_0 = undefined;
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");

    if(var_1.size > 0) {
      if(isDefined(level.requiresminstartspawns)) {}

      var_0 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1, 1);
    }

    if(!isDefined(var_0)) {
      var_1 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      var_0 = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(var_1);
    }

    return var_0;
  }

  var_0 = scripts\mp\spawnlogic::getspawnpoint(self, "none", "normal", "fallback");
  return var_0;
}

function onspawnplayer() {
  self setclientomnvar("ui_match_status_hint_text", 0);
  thread waitloadoutdone();
  level notify("spawned_player");
}

function waitloadoutdone() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");

  if(level.gameended && self.gungamegunindex == level.gun_guns.size) {
    self.gungamegunindex = self.gungameprevgunindex;
  }

  scripts\mp\utility\perk::giveperk("specialty_bling");
  thread givenextgun(1);
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(level.gameended) {
    return;
  }

  if(var_3 == "MOD_FALLING" || isDefined(var_1) && isPlayer(var_1)) {
    var_10 = scripts\mp\riotshield::isriotshield(var_4.basename);
    var_11 = scripts\mp\utility\weapon::isknifeonly(var_4.basename) || scripts\mp\utility\weapon::turret_aimed_at_last_known(var_4.basename) || scripts\mp\utility\weapon::isaxeweapon(var_4.basename) || scripts\mp\utility\weapon::update_health_bar_to_player(var_4);
    var_12 = isDefined(var_3) && var_3 == "MOD_EXECUTION";

    if(!isDefined(self.ladderdeathsthisweapon)) {
      self.ladderdeathsthisweapon = 1;
    } else {
      self.ladderdeathsthisweapon++;
    }

    if(var_3 == "MOD_FALLING" || var_1 == self || var_3 == "MOD_MELEE" && var_11 || self.ladderdeathsthisweapon == level.setbackstreak || var_12) {
      self.ladderdeathsthisweapon = 0;
      self playlocalsound("mp_war_objective_lost");
      self notify("update_loadweapons");
      self.gungameprevgunindex = self.gungamegunindex;
      self.gungamegunindex = int(max(0, self.gungamegunindex - level.setback));

      if(self.gungameprevgunindex > self.gungamegunindex) {
        scripts\mp\gamescore::giveplayerscore("dropped_gun_rank", 1);
        thread scripts\mp\rank::scoreeventpopup("dropped_gun_rank");
        scripts\mp\utility\stats::incpersstat("setbacks", 1);
        scripts\mp\persistence::statsetchild("round", "setbacks", self.pers["setbacks"]);

        if(isPlayer(self)) {
          scripts\mp\utility\stats::setextrascore1(self.pers["setbacks"]);
        }
      }

      if(var_3 == "MOD_MELEE") {
        if(self.gungameprevgunindex) {
          var_1 thread scripts\mp\utility\points::giveunifiedpoints("dropped_enemy_gun_rank");
        }

        updateknivesperminute(var_1);
        var_1 scripts\mp\awards::givemidmatchaward("mode_gun_melee");
        var_1 scripts\mp\utility\stats::incpersstat("stabs", 1);
        var_1 scripts\mp\persistence::statsetchild("round", "stabs", var_1.pers["stabs"]);

        if(isPlayer(var_1)) {
          var_1 scripts\mp\utility\stats::setextrascore0(var_1.pers["stabs"]);
        }
      }

      if(var_1 == self) {
        return;
      }
    }

    if(var_1 != self && var_3 == "MOD_PISTOL_BULLET" || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_HEAD_SHOT" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH" || var_3 == "MOD_IMPACT" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_FIRE" || var_3 == "MOD_MELEE" && !var_11 || var_12) {
      var_13 = getweaponbasename(var_1.primaryweapon);

      if(!get_available_unique_id(var_1, var_4, var_13, var_12)) {
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
      var_1 scripts\mp\gamescore::giveplayerscore("gained_gun_rank", 1);

      if(var_1.gungamegunindex == level.gun_guns.size - 2) {
        level.kick_afk_check = 1;
      }

      if(update_readings(var_1)) {
        var_14 = [];

        foreach(var_16 in level.players) {
          if(var_16 != var_1) {
            var_14 = var_16;
          }
        }

        scripts\mp\utility\dialog::leaderdialogonplayers("lasttier_enemy", var_14);
        var_1 scripts\mp\utility\dialog::leaderdialogonplayer("lasttier_friendly");
        scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
        level thread scripts\mp\hud_util::teamplayercardsplash("callout_top_gun_rank", var_1);
      }

      if(var_1.gungamegunindex < level.gun_guns.size) {
        var_18 = scripts\mp\rank::getscoreinfovalue("gained_gun_rank");
        var_1 thread scripts\mp\rank::scorepointspopup(var_18);
        var_1 thread scripts\mp\rank::scoreeventpopup("gained_gun_rank");
        var_1 playlocalsound("mp_war_objective_taken");
        thread givenextgun(var_1);
      }

      if(isDefined(var_1.lastgunrankincreasetime) && gettime() - var_1.lastgunrankincreasetime < 5000) {
        var_1 scripts\mp\awards::givemidmatchaward("mode_gun_quick_kill");
      }

      var_1.lastgunrankincreasetime = gettime();
      return;
    }

    return;
  }
}

function givenextgun(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!var_0) {
    scripts\common\utility::allow_weapon_switch(0);
  }

  var_1 = getnextgun();
  var_1 = scripts\mp\weapons::updatesavedaltstate(var_1);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);

  if(var_0) {
    self setspawnweapon(var_1);

    foreach(var_3 in self.weaponlist) {
      if(var_3 != var_1) {
        thread scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe(var_3);
      }
    }
  }

  self.pers["primaryWeapon"] = var_1.basename;
  self.primaryweapon = var_1.basename;
  self.primaryweaponobj = var_1;
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
  var_5 = scripts\mp\utility\weapon::isaxeweapon(var_1);

  if(var_5) {
    self setweaponammoclip(var_1, 1);
    thread takeweaponwhensafegungame("iw8_knifestab_mp", 0);
  } else if(self.gungamegunindex != level.gun_guns.size - 1) {
    self givestartammo(var_1);
    var_6 = getcompleteweaponname("iw8_knifestab_mp");
    self giveweapon(var_6);
    self assignweaponmeleeslot(var_6);
  }

  if(!var_0) {
    var_7 = self.lastdroppableweaponobj;
    thread takeweaponwhensafegungame(var_7, 1);
  }

  giveortakethrowingknife(var_1.basename);
  scripts\mp\weapons::updatetogglescopestate(var_1);
  self.gungameprevgunindex = self.gungamegunindex;

  if(!isDefined(self.lastgunpromotiontime)) {
    self.lastgunpromotiontime = gettime();
  }

  var_8 = (gettime() - self.lastgunpromotiontime) / 1000;
  self.lastgunpromotiontime = gettime();

  if(isDefined(self.pers["longestTimeSpentOnWeapon"]) && var_8 > self.pers["longestTimeSpentOnWeapon"]) {
    self.pers["longestTimeSpentOnWeapon"] = var_8;
    return;
  }
}

function takeweaponwhensafegungame(var_0, var_1) {
  self endon("death_or_disconnect");

  for(;;) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_0)) {
      break;
    }

    waitframe();
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);

  if(var_1) {
    scripts\common\utility::allow_weapon_switch(1);
    return;
  }
}

function getnextgun(var_0) {
  var_1 = self.gungamegunindex;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  var_2 = level.gun_guns[var_1];
  return var_2;
}

function ontimelimit() {
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

function gethighestprogressedplayers() {
  var_0 = -1;
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(var_3.gungamegunindex) && var_3.gungamegunindex >= var_0) {
      var_0 = var_3.gungamegunindex;
      var_1 = var_3;
    }
  }

  return var_1;
}

function refillammo() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload");
    var_0 = weaponstartammo(self.primaryweapon);
    var_1 = weaponclipsize(self.primaryweapon);
    var_2 = var_0 - var_1;
    self setweaponammostock(self.primaryweapon, var_2);
  }
}

function refillsinglecountammo() {
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

function setgunladder() {
  level.gun_guns = [];
  level.selectedweapons = [];

  switch (level.ladderindex) {
    case 10:
    case 7:
    case 6:
    case 5:
    case 4:
    case 1:
      if(scripts\mp\utility\game::matchmakinggame() && getdvarint("scr_gun_classic_ladder", 0) == 1) {
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
        level.gun_guns[16] = "rand_pistol";
        level.gun_guns[17] = "rand_knife_end";
      } else {
        level.gun_guns[0] = "rand_assault";
        level.gun_guns[1] = "rand_smg";
        level.gun_guns[2] = "rand_shotgun";
        level.gun_guns[3] = "rand_lmg";
        level.gun_guns[4] = "rand_assault";
        level.gun_guns[5] = "rand_sniper";
        level.gun_guns[6] = "rand_pistol";
        level.gun_guns[7] = "rand_assault";
        level.gun_guns[8] = "rand_smg";
        level.gun_guns[9] = "rand_launcher";
        level.gun_guns[10] = "rand_shotgun";
        level.gun_guns[11] = "rand_lmg";
        level.gun_guns[12] = "rand_assault";
        level.gun_guns[13] = "rand_smg";
        level.gun_guns[14] = "rand_shotgun";
        level.gun_guns[15] = "rand_sniper";
        level.gun_guns[16] = "rand_pistol";
        level.gun_guns[17] = "rand_knife_end";
      }

      break;
    case 8:
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
      level.gun_guns[16] = "rand_pistol";
      level.gun_guns[17] = "rand_knife_end";
      break;
    case 9:
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
      level.gun_guns[16] = "rand_pistol";
      level.gun_guns[17] = "rand_knife_end";
      break;
  }

  if(level.gametype == "gun") {
    var_0 = level.gun_guns.size;
    setdynamicdvar("scr_gun_scorelimit", var_0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), var_0);
    return;
  }
}

function setgunsfinal() {
  level.selectedweapons = [];
  buildrandomweapontable();
  var_0 = 0;

  while(var_0 < level.gun_guns.size) {
    var_1 = level.gun_guns[var_0];

    if(scripts\mp\utility\script::isstrstart(var_1, "rand_")) {
      var_2 = getrandomweaponfromcategory(var_1);

      if(level.ladderindex == 4 || level.ladderindex == 5) {
        level.gun_guns[var_0] = scripts\mp\class::fixcollision(var_2["weapon"], undefined, undefined, var_2["variantID"], undefined, undefined, scripts\cp_mp\utility\game_utility::isnightmap());
      } else {
        level.gun_guns[var_0] = fixuppickuporigin(var_2);
      }
    } else {
      var_3 = scripts\mp\utility\weapon::getweaponrootname(level.gun_guns[var_0]);
      level.selectedweapons[var_3] = 1;
      var_4 = var_3;
      var_5 = 0;

      if(level.ladderindex == 4 || level.ladderindex == 5) {
        var_6 = remappedhpzoneorder(var_3);
        var_7 = scripts\mp\class::ref_139e7(var_3, var_6);
        var_4 = scripts\mp\class::fixcollision(var_3, undefined, undefined, var_7, undefined, undefined, scripts\cp_mp\utility\game_utility::isnightmap());
      } else {
        var_7 = 0;

        if(level.ladderindex == 6) {
          var_6 = remappedhpzoneorder(var_4);
          var_7 = scripts\mp\class::ref_139e7(var_4, var_6);
        }

        var_7 = randomintrange(2, 5);
        var_5 = set_station_track_available_time(var_4, var_7, var_7, scripts\cp_mp\utility\game_utility::isnightmap());
      }

      level.gun_guns[var_1] = var_5;
    }

    var_1++;
  }

  level.selectedweapons = undefined;
}

function getrandomarchetype() {
  return "archetype_assault";
}

function setspecialloadout() {
  level.gun_loadouts["axis"]["loadoutPrimary"] = "iw8_pi_cpapa";
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
  level.gun_loadouts["axis"]["loadoutEquipment"] = "specialty_null";
  level.gun_loadouts["axis"]["loadoutOffhand"] = "none";
  level.gun_loadouts["axis"]["loadoutStreakType"] = "assault";
  level.gun_loadouts["axis"]["loadoutKillstreak1"] = "none";
  level.gun_loadouts["axis"]["loadoutKillstreak2"] = "none";
  level.gun_loadouts["axis"]["loadoutKillstreak3"] = "none";
  level.gun_loadouts["axis"]["loadoutPerks"] = [];
  level.gun_loadouts["axis"]["loadoutGesture"] = "playerData";
  level.gun_loadouts["allies"] = level.gun_loadouts["axis"];
}

function buildrandomweapontable() {
  level.weaponcategories = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/gunGameWeapons.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    if(!isDefined(level.weaponcategories[var_1])) {
      level.weaponcategories[var_1] = [];
    }

    var_2 = tablelookupbyrow("mp/gunGameWeapons.csv", var_0, 5);

    if(var_2 == "" || getdvarint(var_2, 0) == 1) {
      var_3 = [];
      GscBinSkip0(0x2e, "weapon", scripts\mp\utility\weapon::getweaponrootname(tablelookupbyrow("mp/gunGameWeapons.csv", var_0, 1)));
    }
  }
}

function getrandomweaponfromcategory(var_0) {
  var_1 = level.weaponcategories[var_0];

  if(isDefined(var_1) && var_1.size > 0) {
    var_2 = "";
    var_3 = undefined;

    for(var_4 = 0;; var_4++) {
      var_5 = randomintrange(0, var_1.size);
      var_3 = var_1[var_5];
      var_6 = scripts\mp\utility\weapon::getweaponrootname(var_3["weapon"]);
      var_7 = 1;

      if(level.ladderindex == 4 || level.ladderindex == 6) {
        var_7 = var_3["allowed"];
      }

      if(!isDefined(level.selectedweapons[var_6]) && var_7 || var_4 > var_1.size) {
        level.selectedweapons[var_6] = 1;

        for(var_8 = 0; var_8 < level.weaponcategories[var_0].size; var_8++) {
          if(level.weaponcategories[var_0][var_8]["weapon"] == var_3["weapon"]) {
            level.weaponcategories[var_0] = scripts\engine\utility::array_remove_index(level.weaponcategories[var_0], var_8);
            break;
          }
        }

        break;
      }
    }

    if(level.ladderindex == 4 || level.ladderindex == 6) {
      var_9 = remappedhpzoneorder(var_3["weapon"]);
      var_3 = scripts\mp\class::ref_139e7(var_3["weapon"], var_9);
    } else if(level.ladderindex == 5) {
      var_3 = scripts\mp\class::ref_139e7(var_3["weapon"], "-1");
    }

    return var_3;
  }

  return "none";
}

function fixuppickuporigin(var_0) {
  var_1 = randomintrange(var_0["min"], var_0["max"] + 1);
  var_2 = set_station_track_available_time(var_0["weapon"], var_1, var_0["variantID"], scripts\cp_mp\utility\game_utility::isnightmap());
  return var_2;
}

function remappedhpzoneorder(var_0) {
  var_1 = [];
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_1 = tablelookup("mp/gunGameWeapons.csv", 1, var_2, 6);
  return var_1;
}

function modifyweapon(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;
  var_5 = level.ladderindex == 4;
  var_6 = "";

  if(isDefined(var_2) && var_2["variant"] != "") {
    var_6 = var_2["variant"];
  }

  var_7 = var_6 != "";
  var_8 = "mp/loot/weapon/" + var_0 + ".csv";
  var_9 = scripts\mp\utility\weapon::getweapongunsmithattachmenttable(var_0);

  if(var_1 > 0) {
    var_10 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_0);

    if(var_10.size > 0) {
      var_11 = scripts\mp\utility\weapon::register_wave_spawner(var_0);
      var_12 = var_11.size;

      for(var_13 = 0; var_13 < var_1; var_13++) {
        var_14 = "";

        while(var_14 == "" && var_12 > 0) {
          var_12--;
          var_15 = randomint(var_11.size);
          var_14 = var_11[var_15];

          if(attachmentcheck(var_14, var_3, var_9, var_0)) {
            var_3 = var_14;

            if(scripts\mp\utility\weapon::getattachmenttype(var_14) == "rail") {
              var_4 = 1;
            }
          }
        }
      }
    }
  }

  var_16 = "none";
  var_17 = "none";

  if(istrue(var_5) && var_7) {
    var_18 = scripts\mp\class::buildweapon(var_0, var_3, var_16, var_17, int(var_6));
  } else {
    var_18 = scripts\mp\class::buildweapon(var_1, var_4, var_17, var_18);
  }

  return var_18;
}

function set_station_track_available_time(var_0, var_1, var_2, var_3) {
  if(level.ladderindex == 6) {
    if(!isDefined(var_1)) {
      var_1 = randomintrange(2, 5);
    }

    var_4 = scripts\mp\class::buildweapon(var_0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_3);
    var_5 = set_spawner_type(var_0);
    var_6 = [];

    for(var_7 = 0; var_7 < var_1; var_7++) {
      var_8 = scripts\mp\weapons::getrandomgraverobberattachment(var_4, var_5);

      if(!isDefined(var_8)) {
        break;
      }

      var_9 = scripts\mp\weapons::addattachmenttoweapon(var_4, var_8);

      if(isDefined(var_9)) {
        var_4 = var_9;
      }

      var_6 = var_8;
    }

    var_4 = scripts\mp\class::fixsuperforbr(var_0, var_6, undefined, undefined, var_2, undefined, undefined, undefined, var_3);
    return var_4;
  }

  if(isDefined(var_8) && var_8 != 0) {
    var_4 = scripts\mp\class::fixcollision(var_6, undefined, undefined, var_8, undefined, undefined, var_9);
  } else {
    var_4 = scripts\mp\class::buildweapon(var_7, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_4);
  }

  if(!isDefined(var_8)) {
    var_8 = randomintrange(2, 5);
  }

  var_5 = set_spawner_type(var_4);

  for(var_7 = 0; var_7 < var_8; var_7++) {
    var_8 = scripts\mp\weapons::getrandomgraverobberattachment(var_4, var_5);

    if(!isDefined(var_8)) {
      break;
    }

    var_9 = scripts\mp\weapons::addattachmenttoweapon(var_4, var_8);

    if(isDefined(var_9)) {
      var_4 = var_9;
    }
  }

  return var_4;
}

function set_spawner_type(var_0) {
  var_1 = scripts\mp\utility\weapon::register_wave_spawner(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isstartstr(var_4, "gl") || isstartstr(var_4, "ub") || isstartstr(var_4, "thermal") || var_4 == "hybrid3") {
      continue;
    }

    var_2 = var_4;
  }

  return var_2;
}

function attachmentcheck(var_0, var_1, var_2, var_3) {
  var_4 = tablelookup(var_2, 0, var_0, 1);

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = tablelookup(var_2, 0, var_1[var_5], 1);

    if(var_0 == var_1[var_5] || scripts\mp\utility\weapon::attachmentsconflict(var_0, var_1[var_5], var_3) != "" || var_4 == var_6) {
      return false;
    }
  }

  return true;
}

function getvalidattachments(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = [];
  var_7 = [];

  if(istrue(var_1) && var_4 != "") {
    var_6 = tablelookup(var_3, 0, int(var_4), 17);
    var_6 = strtok(var_6, "+");
    var_7 = tablelookup(var_3, 0, int(var_4), 18);
    var_7 = strtok(var_7, "+");

    for(var_8 = 0; var_8 < var_6.size; var_8++) {
      var_6 = scripts\mp\utility\weapon::attachmentmap_tobase(var_6[var_8]);
    }
  }

  foreach(var_10 in var_0) {
    var_11 = scripts\mp\utility\weapon::getattachmenttype(var_10);

    if(var_7.size > 0 && scripts\engine\utility::array_contains(var_7, var_11)) {
      continue;
    }

    if(var_6.size > 0 && scripts\engine\utility::array_contains(var_6, var_10)) {
      continue;
    }

    if(!scripts\mp\utility\weapon::carriedpunchcard(var_2, var_10)) {
      var_5[var_11] = undefined;
      continue;
    }

    switch (var_10) {
      case "xmags":
      case "silencer":
        break;
      default:
        if(!issubstr(var_10, "silencer")) {
          var_5 = var_10;
        }

        break;
    }
  }

  return var_5;
}

function giveortakethrowingknife(var_0) {
  scripts\mp\equipment::takeequipment("primary");

  if(scripts\mp\utility\weapon::isknifeonly(var_0) || scripts\mp\utility\weapon::turret_aimed_at_last_known(var_0) || scripts\mp\utility\weapon::isaxeweapon(var_0)) {
    scripts\mp\utility\perk::giveperk("specialty_scavenger");
    scripts\mp\utility\perk::giveperk("specialty_pitcher");
    scripts\mp\equipment::giveequipment("equip_throwing_knife_fire", "primary");
    thread scripts\mp\equipment::incrementequipmentammo("equip_throwing_knife_fire");
    return;
  }
}

function isvalidthrowingknifekill(var_0) {
  return var_0 == "throwingknife_mp" || var_0 == "throwingknife_fire_mp" || var_0 == "throwingknife_electric_mp" || var_0 == "throwingknife_drill_mp";
}

function onplayerscore(var_0, var_1, var_2, var_3) {
  var_1 scripts\mp\utility\stats::incpersstat("gamemodeScore", var_2);
  var_4 = var_1 scripts\mp\utility\stats::getpersstat("gamemodeScore");
  var_1 scripts\mp\persistence::statsetchild("round", "gamemodeScore", var_4);
  var_5 = 0;

  if(var_0 == "gained_gun_rank") {
    var_5 = 1;
  } else if(var_0 == "dropped_gun_rank") {
    var_6 = level.setback;
    var_5 = var_6 * -1;
  } else if(var_0 == "assist_ffa" || var_0 == "kill") {
    var_1 scripts\mp\utility\script::bufferednotify("earned_score_buffered", var_2);
  }

  return var_5;
}

function updateknivesperminute() {
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

function modifyunifiedpointscallback(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && (var_3.basename == "iw8_knife_mp" || var_3.basename == "iw8_me_akimboblunt_mp" || var_3.basename == "iw8_me_akimboblades_mp")) {
    if(isDefined(var_2) && isDefined(var_2.knivesperminute) && var_2.knivesperminute >= 10) {
      return 0;
    }
  }

  return var_0;
}

function get_available_unique_id(var_0, var_1, var_2) {
  if(var_0.basename == var_1) {
    return true;
  }

  if(var_1 == "iw8_sn_crossbow_mp") {
    if(issubstr(var_0.basename, "bolt")) {
      return true;
    }
  }

  if(var_0.basename == "dragonsbreath_mp") {
    return true;
  }

  if(var_1 == "iw8_sn_xmike109_mp" || var_1 == "iw8_sh_aalpha12_mp") {
    return true;
  }

  if(update_readings()) {
    if(isvalidthrowingknifekill(var_0.basename)) {
      return true;
    }

    if(var_2) {
      return true;
    }
  }

  return false;
}

function update_readings() {
  return self.gungamegunindex == level.gun_guns.size - 1;
}