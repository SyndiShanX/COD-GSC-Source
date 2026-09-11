/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\gun.gsc
***********************************************/

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var0 = [];
  scripts\mp\gameobjects::main(var0);

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

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var1, &"OBJECTIVES/DM");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/DM");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/DM_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var1, &"OBJECTIVES/DM_HINT");
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
  var3 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  var4 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var3);
  scripts\mp\spawnlogic::registerspawnset("fallback", var4);
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

function onplayerconnect(var0) {
  thread keepweaponsloaded();
  var0.pers["class"] = "gamemode";
  var0.pers["lastClass"] = "";
  var0.class = var0.pers["class"];
  var0.lastclass = var0.pers["lastClass"];
  var0.pers["gamemodeLoadout"] = level.gun_loadouts["axis"];
  var0.gungamegunindex = 0;
  var0.gungameprevgunindex = 0;
  thread refillammo();
  thread refillsinglecountammo();
}

function keepweaponsloaded() {
  self loadweaponsforplayer([level.gun_guns[0], level.gun_guns[1]], 1);
  var0 = [];
  self waittill("update_loadweapons");
  GscBinSkip0(0x2e, 0, level.gun_guns[int(max(0, self.gungamegunindex - level.setback))]);
}

function getspawnpoint() {
  if(level.ingraceperiod) {
    var0 = undefined;
    var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");

    if(var1.size > 0) {
      if(isDefined(level.requiresminstartspawns)) {}

      var0 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1, 1);
    }

    if(!isDefined(var0)) {
      var1 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      var0 = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(var1);
    }

    return var0;
  }

  var0 = scripts\mp\spawnlogic::getspawnpoint(self, "none", "normal", "fallback");
  return var0;
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

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(level.gameended) {
    return;
  }

  if(var3 == "MOD_FALLING" || isDefined(var1) && isPlayer(var1)) {
    var10 = scripts\mp\riotshield::isriotshield(var4.basename);
    var11 = scripts\mp\utility\weapon::isknifeonly(var4.basename) || scripts\mp\utility\weapon::turret_aimed_at_last_known(var4.basename) || scripts\mp\utility\weapon::isaxeweapon(var4.basename) || scripts\mp\utility\weapon::update_health_bar_to_player(var4);
    var12 = isDefined(var3) && var3 == "MOD_EXECUTION";

    if(!isDefined(self.ladderdeathsthisweapon)) {
      self.ladderdeathsthisweapon = 1;
    } else {
      self.ladderdeathsthisweapon++;
    }

    if(var3 == "MOD_FALLING" || var1 == self || var3 == "MOD_MELEE" && var11 || self.ladderdeathsthisweapon == level.setbackstreak || var12) {
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

      if(var3 == "MOD_MELEE") {
        if(self.gungameprevgunindex) {
          var1 thread scripts\mp\utility\points::giveunifiedpoints("dropped_enemy_gun_rank");
        }

        updateknivesperminute(var1);
        var1 scripts\mp\awards::givemidmatchaward("mode_gun_melee");
        var1 scripts\mp\utility\stats::incpersstat("stabs", 1);
        var1 scripts\mp\persistence::statsetchild("round", "stabs", var1.pers["stabs"]);

        if(isPlayer(var1)) {
          var1 scripts\mp\utility\stats::setextrascore0(var1.pers["stabs"]);
        }
      }

      if(var1 == self) {
        return;
      }
    }

    if(var1 != self && var3 == "MOD_PISTOL_BULLET" || var3 == "MOD_RIFLE_BULLET" || var3 == "MOD_HEAD_SHOT" || var3 == "MOD_PROJECTILE" || var3 == "MOD_PROJECTILE_SPLASH" || var3 == "MOD_IMPACT" || var3 == "MOD_GRENADE" || var3 == "MOD_GRENADE_SPLASH" || var3 == "MOD_EXPLOSIVE" || var3 == "MOD_FIRE" || var3 == "MOD_MELEE" && !var11 || var12) {
      var13 = getweaponbasename(var1.primaryweapon);

      if(!get_available_unique_id(var1, var4, var13, var12)) {
        return;
      }

      if(!isDefined(var1.ladderkillsthisweapon)) {
        var1.ladderkillsthisweapon = 1;
      } else {
        var1.ladderkillsthisweapon++;
      }

      if(var1.ladderkillsthisweapon != level.killsperweapon) {
        return;
      }

      var1.ladderkillsthisweapon = 0;
      var1.ladderdeathsthisweapon = 0;
      var1.gungameprevgunindex = var1.gungamegunindex;
      var1.gungamegunindex++;
      var1 notify("update_loadweapons");
      var1 scripts\mp\gamescore::giveplayerscore("gained_gun_rank", 1);

      if(var1.gungamegunindex == level.gun_guns.size - 2) {
        level.kick_afk_check = 1;
      }

      if(update_readings(var1)) {
        var14 = [];

        foreach(var16 in level.players) {
          if(var16 != var1) {
            var14 = var16;
          }
        }

        scripts\mp\utility\dialog::leaderdialogonplayers("lasttier_enemy", var14);
        var1 scripts\mp\utility\dialog::leaderdialogonplayer("lasttier_friendly");
        scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
        level thread scripts\mp\hud_util::teamplayercardsplash("callout_top_gun_rank", var1);
      }

      if(var1.gungamegunindex < level.gun_guns.size) {
        var18 = scripts\mp\rank::getscoreinfovalue("gained_gun_rank");
        var1 thread scripts\mp\rank::scorepointspopup(var18);
        var1 thread scripts\mp\rank::scoreeventpopup("gained_gun_rank");
        var1 playlocalsound("mp_war_objective_taken");
        thread givenextgun(var1);
      }

      if(isDefined(var1.lastgunrankincreasetime) && gettime() - var1.lastgunrankincreasetime < 5000) {
        var1 scripts\mp\awards::givemidmatchaward("mode_gun_quick_kill");
      }

      var1.lastgunrankincreasetime = gettime();
      return;
    }

    return;
  }
}

function givenextgun(var0) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!var0) {
    scripts\common\utility::allow_weapon_switch(0);
  }

  var1 = getnextgun();
  var1 = scripts\mp\weapons::updatesavedaltstate(var1);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var1, undefined, undefined, 1);

  if(var0) {
    self setspawnweapon(var1);

    foreach(var3 in self.weaponlist) {
      if(var3 != var1) {
        thread scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe(var3);
      }
    }
  }

  self.pers["primaryWeapon"] = var1.basename;
  self.primaryweapon = var1.basename;
  self.primaryweaponobj = var1;
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var1);
  var5 = scripts\mp\utility\weapon::isaxeweapon(var1);

  if(var5) {
    self setweaponammoclip(var1, 1);
    thread takeweaponwhensafegungame("iw8_knifestab_mp", 0);
  } else if(self.gungamegunindex != level.gun_guns.size - 1) {
    self givestartammo(var1);
    var6 = getcompleteweaponname("iw8_knifestab_mp");
    self giveweapon(var6);
    self assignweaponmeleeslot(var6);
  }

  if(!var0) {
    var7 = self.lastdroppableweaponobj;
    thread takeweaponwhensafegungame(var7, 1);
  }

  giveortakethrowingknife(var1.basename);
  scripts\mp\weapons::updatetogglescopestate(var1);
  self.gungameprevgunindex = self.gungamegunindex;

  if(!isDefined(self.lastgunpromotiontime)) {
    self.lastgunpromotiontime = gettime();
  }

  var8 = (gettime() - self.lastgunpromotiontime) / 1000;
  self.lastgunpromotiontime = gettime();

  if(isDefined(self.pers["longestTimeSpentOnWeapon"]) && var8 > self.pers["longestTimeSpentOnWeapon"]) {
    self.pers["longestTimeSpentOnWeapon"] = var8;
    return;
  }
}

function takeweaponwhensafegungame(var0, var1) {
  self endon("death_or_disconnect");

  for(;;) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var0)) {
      break;
    }

    waitframe();
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);

  if(var1) {
    scripts\common\utility::allow_weapon_switch(1);
    return;
  }
}

function getnextgun(var0) {
  var1 = self.gungamegunindex;

  if(isDefined(var0)) {
    var1 = var0;
  }

  var2 = level.gun_guns[var1];
  return var2;
}

function ontimelimit() {
  var0 = gethighestprogressedplayers();

  if(!isDefined(var0) || !var0.size) {
    thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(var0.size == 1) {
    thread scripts\mp\gamelogic::endgame(var0[0], game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(var0[var0.size - 1].gungamegunindex > var0[var0.size - 2].gungamegunindex) {
    thread scripts\mp\gamelogic::endgame(var0[var0.size - 1], game["end_reason"]["time_limit_reached"]);
    return;
  }

  thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
}

function gethighestprogressedplayers() {
  var0 = -1;
  var1 = [];

  foreach(var3 in level.players) {
    if(isDefined(var3.gungamegunindex) && var3.gungamegunindex >= var0) {
      var0 = var3.gungamegunindex;
      var1 = var3;
    }
  }

  return var1;
}

function refillammo() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload");
    var0 = weaponstartammo(self.primaryweapon);
    var1 = weaponclipsize(self.primaryweapon);
    var2 = var0 - var1;
    self setweaponammostock(self.primaryweapon, var2);
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
    var0 = level.gun_guns.size;
    setdynamicdvar("scr_gun_scorelimit", var0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), var0);
    return;
  }
}

function setgunsfinal() {
  level.selectedweapons = [];
  buildrandomweapontable();
  var0 = 0;

  while(var0 < level.gun_guns.size) {
    var1 = level.gun_guns[var0];

    if(scripts\mp\utility\script::isstrstart(var1, "rand_")) {
      var2 = getrandomweaponfromcategory(var1);

      if(level.ladderindex == 4 || level.ladderindex == 5) {
        level.gun_guns[var0] = scripts\mp\class::fixcollision(var2["weapon"], undefined, undefined, var2["variantID"], undefined, undefined, scripts\cp_mp\utility\game_utility::isnightmap());
      } else {
        level.gun_guns[var0] = fixuppickuporigin(var2);
      }
    } else {
      var3 = scripts\mp\utility\weapon::getweaponrootname(level.gun_guns[var0]);
      level.selectedweapons[var3] = 1;
      var4 = var3;
      var5 = 0;

      if(level.ladderindex == 4 || level.ladderindex == 5) {
        var6 = remappedhpzoneorder(var3);
        var7 = scripts\mp\class::ref_139e7(var3, var6);
        var4 = scripts\mp\class::fixcollision(var3, undefined, undefined, var7, undefined, undefined, scripts\cp_mp\utility\game_utility::isnightmap());
      } else {
        var7 = 0;

        if(level.ladderindex == 6) {
          var6 = remappedhpzoneorder(var4);
          var7 = scripts\mp\class::ref_139e7(var4, var6);
        }

        var7 = randomintrange(2, 5);
        var5 = set_station_track_available_time(var4, var7, var7, scripts\cp_mp\utility\game_utility::isnightmap());
      }

      level.gun_guns[var1] = var5;
    }

    var1++;
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

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/gunGameWeapons.csv", var0, 0);

    if(var1 == "") {
      break;
    }

    if(!isDefined(level.weaponcategories[var1])) {
      level.weaponcategories[var1] = [];
    }

    var2 = tablelookupbyrow("mp/gunGameWeapons.csv", var0, 5);

    if(var2 == "" || getdvarint(var2, 0) == 1) {
      var3 = [];
      GscBinSkip0(0x2e, "weapon", scripts\mp\utility\weapon::getweaponrootname(tablelookupbyrow("mp/gunGameWeapons.csv", var0, 1)));
    }
  }
}

function getrandomweaponfromcategory(var0) {
  var1 = level.weaponcategories[var0];

  if(isDefined(var1) && var1.size > 0) {
    var2 = "";
    var3 = undefined;

    for(var4 = 0;; var4++) {
      var5 = randomintrange(0, var1.size);
      var3 = var1[var5];
      var6 = scripts\mp\utility\weapon::getweaponrootname(var3["weapon"]);
      var7 = 1;

      if(level.ladderindex == 4 || level.ladderindex == 6) {
        var7 = var3["allowed"];
      }

      if(!isDefined(level.selectedweapons[var6]) && var7 || var4 > var1.size) {
        level.selectedweapons[var6] = 1;

        for(var8 = 0; var8 < level.weaponcategories[var0].size; var8++) {
          if(level.weaponcategories[var0][var8]["weapon"] == var3["weapon"]) {
            level.weaponcategories[var0] = scripts\engine\utility::array_remove_index(level.weaponcategories[var0], var8);
            break;
          }
        }

        break;
      }
    }

    if(level.ladderindex == 4 || level.ladderindex == 6) {
      var9 = remappedhpzoneorder(var3["weapon"]);
      var3 = scripts\mp\class::ref_139e7(var3["weapon"], var9);
    } else if(level.ladderindex == 5) {
      var3 = scripts\mp\class::ref_139e7(var3["weapon"], "-1");
    }

    return var3;
  }

  return "none";
}

function fixuppickuporigin(var0) {
  var1 = randomintrange(var0["min"], var0["max"] + 1);
  var2 = set_station_track_available_time(var0["weapon"], var1, var0["variantID"], scripts\cp_mp\utility\game_utility::isnightmap());
  return var2;
}

function remappedhpzoneorder(var0) {
  var1 = [];
  var2 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var1 = tablelookup("mp/gunGameWeapons.csv", 1, var2, 6);
  return var1;
}

function modifyweapon(var0, var1, var2) {
  var3 = [];
  var4 = 0;
  var5 = level.ladderindex == 4;
  var6 = "";

  if(isDefined(var2) && var2["variant"] != "") {
    var6 = var2["variant"];
  }

  var7 = var6 != "";
  var8 = "mp/loot/weapon/" + var0 + ".csv";
  var9 = scripts\mp\utility\weapon::getweapongunsmithattachmenttable(var0);

  if(var1 > 0) {
    var10 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var0);

    if(var10.size > 0) {
      var11 = scripts\mp\utility\weapon::register_wave_spawner(var0);
      var12 = var11.size;

      for(var13 = 0; var13 < var1; var13++) {
        var14 = "";

        while(var14 == "" && var12 > 0) {
          var12--;
          var15 = randomint(var11.size);
          var14 = var11[var15];

          if(attachmentcheck(var14, var3, var9, var0)) {
            var3 = var14;

            if(scripts\mp\utility\weapon::getattachmenttype(var14) == "rail") {
              var4 = 1;
            }
          }
        }
      }
    }
  }

  var16 = "none";
  var17 = "none";

  if(istrue(var5) && var7) {
    var18 = scripts\mp\class::buildweapon(var0, var3, var16, var17, int(var6));
  } else {
    var18 = scripts\mp\class::buildweapon(var1, var4, var17, var18);
  }

  return var18;
}

function set_station_track_available_time(var0, var1, var2, var3) {
  if(level.ladderindex == 6) {
    if(!isDefined(var1)) {
      var1 = randomintrange(2, 5);
    }

    var4 = scripts\mp\class::buildweapon(var0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var3);
    var5 = set_spawner_type(var0);
    var6 = [];

    for(var7 = 0; var7 < var1; var7++) {
      var8 = scripts\mp\weapons::getrandomgraverobberattachment(var4, var5);

      if(!isDefined(var8)) {
        break;
      }

      var9 = scripts\mp\weapons::addattachmenttoweapon(var4, var8);

      if(isDefined(var9)) {
        var4 = var9;
      }

      var6 = var8;
    }

    var4 = scripts\mp\class::fixsuperforbr(var0, var6, undefined, undefined, var2, undefined, undefined, undefined, var3);
    return var4;
  }

  if(isDefined(var8) && var8 != 0) {
    var4 = scripts\mp\class::fixcollision(var6, undefined, undefined, var8, undefined, undefined, var9);
  } else {
    var4 = scripts\mp\class::buildweapon(var7, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var4);
  }

  if(!isDefined(var8)) {
    var8 = randomintrange(2, 5);
  }

  var5 = set_spawner_type(var4);

  for(var7 = 0; var7 < var8; var7++) {
    var8 = scripts\mp\weapons::getrandomgraverobberattachment(var4, var5);

    if(!isDefined(var8)) {
      break;
    }

    var9 = scripts\mp\weapons::addattachmenttoweapon(var4, var8);

    if(isDefined(var9)) {
      var4 = var9;
    }
  }

  return var4;
}

function set_spawner_type(var0) {
  var1 = scripts\mp\utility\weapon::register_wave_spawner(var0);
  var2 = [];

  foreach(var4 in var1) {
    if(isstartstr(var4, "gl") || isstartstr(var4, "ub") || isstartstr(var4, "thermal") || var4 == "hybrid3") {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function attachmentcheck(var0, var1, var2, var3) {
  var4 = tablelookup(var2, 0, var0, 1);

  for(var5 = 0; var5 < var1.size; var5++) {
    var6 = tablelookup(var2, 0, var1[var5], 1);

    if(var0 == var1[var5] || scripts\mp\utility\weapon::attachmentsconflict(var0, var1[var5], var3) != "" || var4 == var6) {
      return false;
    }
  }

  return true;
}

function getvalidattachments(var0, var1, var2, var3, var4) {
  var5 = [];
  var6 = [];
  var7 = [];

  if(istrue(var1) && var4 != "") {
    var6 = tablelookup(var3, 0, int(var4), 17);
    var6 = strtok(var6, "+");
    var7 = tablelookup(var3, 0, int(var4), 18);
    var7 = strtok(var7, "+");

    for(var8 = 0; var8 < var6.size; var8++) {
      var6 = scripts\mp\utility\weapon::attachmentmap_tobase(var6[var8]);
    }
  }

  foreach(var10 in var0) {
    var11 = scripts\mp\utility\weapon::getattachmenttype(var10);

    if(var7.size > 0 && scripts\engine\utility::array_contains(var7, var11)) {
      continue;
    }

    if(var6.size > 0 && scripts\engine\utility::array_contains(var6, var10)) {
      continue;
    }

    if(!scripts\mp\utility\weapon::carriedpunchcard(var2, var10)) {
      var5[var11] = undefined;
      continue;
    }

    switch (var10) {
      case "xmags":
      case "silencer":
        break;
      default:
        if(!issubstr(var10, "silencer")) {
          var5 = var10;
        }

        break;
    }
  }

  return var5;
}

function giveortakethrowingknife(var0) {
  scripts\mp\equipment::takeequipment("primary");

  if(scripts\mp\utility\weapon::isknifeonly(var0) || scripts\mp\utility\weapon::turret_aimed_at_last_known(var0) || scripts\mp\utility\weapon::isaxeweapon(var0)) {
    scripts\mp\utility\perk::giveperk("specialty_scavenger");
    scripts\mp\utility\perk::giveperk("specialty_pitcher");
    scripts\mp\equipment::giveequipment("equip_throwing_knife_fire", "primary");
    thread scripts\mp\equipment::incrementequipmentammo("equip_throwing_knife_fire");
    return;
  }
}

function isvalidthrowingknifekill(var0) {
  return var0 == "throwingknife_mp" || var0 == "throwingknife_fire_mp" || var0 == "throwingknife_electric_mp" || var0 == "throwingknife_drill_mp";
}

function onplayerscore(var0, var1, var2, var3) {
  var1 scripts\mp\utility\stats::incpersstat("gamemodeScore", var2);
  var4 = var1 scripts\mp\utility\stats::getpersstat("gamemodeScore");
  var1 scripts\mp\persistence::statsetchild("round", "gamemodeScore", var4);
  var5 = 0;

  if(var0 == "gained_gun_rank") {
    var5 = 1;
  } else if(var0 == "dropped_gun_rank") {
    var6 = level.setback;
    var5 = var6 * -1;
  } else if(var0 == "assist_ffa" || var0 == "kill") {
    var1 scripts\mp\utility\script::bufferednotify("earned_score_buffered", var2);
  }

  return var5;
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

function modifyunifiedpointscallback(var0, var1, var2, var3) {
  if(isDefined(var3) && (var3.basename == "iw8_knife_mp" || var3.basename == "iw8_me_akimboblunt_mp" || var3.basename == "iw8_me_akimboblades_mp")) {
    if(isDefined(var2) && isDefined(var2.knivesperminute) && var2.knivesperminute >= 10) {
      return 0;
    }
  }

  return var0;
}

function get_available_unique_id(var0, var1, var2) {
  if(var0.basename == var1) {
    return true;
  }

  if(var1 == "iw8_sn_crossbow_mp") {
    if(issubstr(var0.basename, "bolt")) {
      return true;
    }
  }

  if(var0.basename == "dragonsbreath_mp") {
    return true;
  }

  if(var1 == "iw8_sn_xmike109_mp" || var1 == "iw8_sh_aalpha12_mp") {
    return true;
  }

  if(update_readings()) {
    if(isvalidthrowingknifekill(var0.basename)) {
      return true;
    }

    if(var2) {
      return true;
    }
  }

  return false;
}

function update_readings() {
  return self.gungamegunindex == level.gun_guns.size - 1;
}