/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\gun.gsc
********************************/

main() {
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [
      [level.initializematchrules]
    ]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    level thread reinitializescorelimitonmigration();
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 0);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
    setdynamicdvar("scr_game_hardpoints", 0);
  }

  level.gun_cyclecount = maps\mp\_utility::getintproperty("scr_gun_cycleCount", 1);
  level.gun_weaponlist = maps\mp\_utility::getintproperty("scr_gun_weaponList", 0);
  level.gun_weaponorder = maps\mp\_utility::getintproperty("scr_gun_weaponOrder", 0);
  level.gun_weaponattachments = maps\mp\_utility::getintproperty("scr_gun_weaponAttachments", 0);
  level.gun_weaponlistend = maps\mp\_utility::getintproperty("scr_gun_weaponListEnd", 0);
  setguns();
  setscorelimit();
  level.teambased = 0;
  level.doprematch = 1;
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.ontimelimit = ::ontimelimit;
  level.onplayerscore = ::onplayerscore;
  level.bypassclasschoicefunc = ::gungameclass;
  level.streamprimariesfunc = ::streamprimariesfunc;
  level.assists_disabled = 1;
  level.setbacklevel = maps\mp\_utility::getintproperty("scr_gun_setBackLevels", 1);
  level.lastguntimevo = 0;

  if(level.matchrules_damagemultiplier)
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

  setteammode("ffa");
  game["dialog"]["gametype"] = "gg_intro";
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  game["dialog"]["humiliation"] = "gg_humiliation";
  game["dialog"]["lastgun"] = "gg_lastgun";
}

gundebug() {
  var_0 = "scr_gun_force_next";
  var_1 = "scr_gun_force_prev";
  setdvar(var_0, 0);
  setdvar(var_1, 0);

  while (!isdefined(level.player))
    waitframe();

  for (;;) {
    wait 0.1;

    if(getdvarint(var_0, 0)) {
      level.player.gungameprevgunindex = level.player.gungamegunindex;
      level.player.gungamegunindex++;
      level.player givenextgun();
      setdvar(var_0, 0);
      continue;
    }

    if(getdvarint(var_1, 0)) {
      level.player.gungameprevgunindex = level.player.gungamegunindex;

      for (level.player.gungamegunindex--; level.player.gungamegunindex < 0; level.player.gungamegunindex = level.player.gungamegunindex + level.gun_guns.size) {

      }

      level.player givenextgun();
      setdvar(var_1, 0);
    }
  }
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata(1);
  setdynamicdvar("scr_gun_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("gun", 1);
  setdynamicdvar("scr_gun_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("gun", 1);
  setdynamicdvar("scr_gun_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("gun", 0);
  setdynamicdvar("scr_gun_playerrespawndelay", 0);
  setdynamicdvar("scr_gun_waverespawndelay", 0);
  setdynamicdvar("scr_player_forcerespawn", 1);
  setdynamicdvar("scr_gun_setBackLevels", getmatchrulesdata("gunData", "setbackLevels"));
  setdynamicdvar("scr_gun_cycleCount", getmatchrulesdata("gunData", "cycleCount"));
  setdynamicdvar("scr_gun_weaponList", getmatchrulesdata("gunData", "weaponList"));
  setdynamicdvar("scr_gun_weaponOrder", getmatchrulesdata("gunData", "weaponOrder"));
  setdynamicdvar("scr_gun_weaponAttachments", getmatchrulesdata("gunData", "weaponAttachments"));
  setdynamicdvar("scr_gun_weaponListEnd", getmatchrulesdata("gunData", "weaponListEnd"));
  setdynamicdvar("scr_game_hardpoints", 0);
}

setscorelimit() {
  setdynamicdvar("scr_gun_scorelimit", level.gun_guns.size * level.gun_cyclecount);
  maps\mp\_utility::registerscorelimitdvar(level.gametype, level.gun_guns.size * level.gun_cyclecount);
}

reinitializescorelimitonmigration() {
  for (;;) {
    level waittill("host_migration_begin");
    setscorelimit();
    setdynamicdvar("scr_game_hardpoints", 0);
  }
}

onstartgametype() {
  setclientnamemode("auto_change");
  maps\mp\_utility::setobjectivetext("allies", & "OBJECTIVES_GUN");
  maps\mp\_utility::setobjectivetext("axis", & "OBJECTIVES_GUN");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_GUN");
    maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_GUN");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_GUN_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_GUN_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", & "OBJECTIVES_GUN_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", & "OBJECTIVES_GUN_HINT");
  initspawns();
  var_0 = [];
  maps\mp\gametypes\_gameobjects::main(var_0);
  level.quickmessagetoall = 1;
  level.blockweapondrops = 1;
  level thread onplayerconnect();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0.gungamegunindex = 0;
    var_0.gungameprevgunindex = 0;
    var_0.stabs = 0;
    var_0.mysetbacks = 0;
    var_0.lastleveluptime = 0;
    var_0.showsetbacksplash = 0;
    var_0 thread refillammo();
    var_0 thread refillsinglecountammo();
  }
}

getspawnpoint() {
  if(level.ingraceperiod)
    var_0 = maps\mp\gametypes\_spawnlogic::getstartspawnffa(self.pers["team"]);
  else {
    var_1 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
    var_0 = maps\mp\gametypes\_spawnscoring::getspawnpoint_freeforall(var_1);
  }

  maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_0);
  return var_0;
}

gungameclass() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  gungameclassupdate(level.gun_guns[0]);
}

gungameclassupdate(var_0) {
  self.pers["gamemodeLoadout"] = maps\mp\gametypes\_class::getemptyloadout();

  if(!maps\mp\gametypes\_class::isvalidprimary(var_0.basename))
    self.pers["loadoutSecondary"] = var_0.fullname;
  else
    self.pers["loadoutPrimary"] = var_0.fullname;
}

streamprimariesfunc() {
  var_0 = [];

  foreach(var_2 in level.gun_guns)
  var_0[var_0.size] = var_2.fullname;

  var_4 = [];

  foreach(var_2 in var_0) {
    var_6 = ["axis", "allies"];

    foreach(var_8 in var_6) {
      var_9 = spawnstruct();
      var_9.team = var_8;
      var_9.weapon = var_2;
      var_4[var_4.size] = var_9;
    }
  }

  self hasloadedcustomizationplayerview(var_4, var_0);
}

onspawnplayer() {
  thread waitloadoutdone();
}

waitloadoutdone() {
  level endon("game_ended");
  self endon("disconnect");
  level waittill("player_spawned");
  givenextgun(1);

  if(self.showsetbacksplash) {
    self.showsetbacksplash = 0;
    thread maps\mp\_events::decreasegunlevelevent();
  }
}

onplayerscore(var_0, var_1, var_2) {
  var_3 = maps\mp\gametypes\_rank::getscoreinfovalue(var_0);
  var_1 maps\mp\_utility::setextrascore0(var_1.extrascore0 + var_3);
  var_1 maps\mp\gametypes\_gamescore::updatescorestatsffa(var_1, var_3);

  if(var_0 == "gained_gun_score")
    return 1;

  if(var_0 == "dropped_gun_score") {
    var_4 = min(level.setbacklevel, self.score);
    return int(var_4 * -1);
  }

  return 0;
}

isdedicatedmeleeweapon(var_0) {
  if(weaponinventorytype(var_0) == "melee")
    return 1;

  return 0;
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isdefined(var_1)) {
    return;
  }
  if(var_3 == "MOD_TRIGGER_HURT" && !isplayer(var_1))
    var_1 = self;

  if(isdefined(var_4) && maps\mp\_utility::isdestructibleweapon(var_4) && var_1 != self) {
    return;
  }
  if(isdefined(var_4) && maps\mp\_utility::isenvironmentweapon(var_4)) {
    return;
  }
  if(var_3 == "MOD_FALLING" || isplayer(var_1)) {
    if(var_3 == "MOD_FALLING" || var_1 == self || maps\mp\_utility::ismeleemod(var_3) && !isdedicatedmeleeweapon(var_4)) {
      self playlocalsound("mp_war_objective_lost");
      self.gungameprevgunindex = self.gungamegunindex;
      self.gungamegunindex = int(max(0, self.gungamegunindex - level.setbacklevel));

      if(self.gungameprevgunindex > self.gungamegunindex) {
        self.mysetbacks++;
        maps\mp\_utility::setextrascore1(self.mysetbacks);
        self.showsetbacksplash = 1;

        if(maps\mp\_utility::ismeleemod(var_3)) {
          var_1.stabs++;
          var_1.assists = var_1.stabs;
          var_1 thread maps\mp\_events::setbackenemygunlevelevent();

          if(self.gungameprevgunindex == level.gun_guns.size * level.gun_cyclecount - 1) {
            var_1 thread maps\mp\_events::setbackfirstplayergunlevelevent();
            var_1 maps\mp\_utility::leaderdialogonplayer("humiliation", "status");
          }
        } else
          var_1.gungamesuicidetime = gettime();
      } else if(maps\mp\_utility::ismeleemod(var_3)) {
        var_1.stabs++;
        var_1.assists = var_1.stabs;
        var_1 thread maps\mp\_events::setbackenemygunlevelevent();
      }
    } else if(var_3 == "MOD_PISTOL_BULLET" || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_HEAD_SHOT" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH" || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_IMPACT" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || maps\mp\_utility::ismeleemod(var_3) && isdedicatedmeleeweapon(var_4)) {
      waittillframeend;

      if(isdefined(var_1.gungamesuicidetime) && gettime() - var_1.gungamesuicidetime <= 50) {
        return;
      }
      if(isdefined(var_1.lastleveluptime) && var_1.lastleveluptime == gettime()) {
        return;
      }
      if(maps\mp\_utility::ismeleemod(var_3)) {
        var_1.stabs++;
        var_1.assists = var_1.stabs;
        var_1 thread maps\mp\_events::setbackenemygunlevelevent();
      }

      var_4 = maps\mp\_utility::getbaseweaponname(var_4);

      if(var_1.lastleveluptime + 3000 > gettime())
        var_1 thread maps\mp\_events::quickgunlevelevent();

      var_1.lastleveluptime = gettime();
      var_1.gungameprevgunindex = var_1.gungamegunindex;
      var_1.gungamegunindex++;
      var_1 thread maps\mp\_events::increasegunlevelevent();

      if(var_1.gungamegunindex == level.gun_guns.size * level.gun_cyclecount - 1) {
        maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
        level thread maps\mp\_utility::teamplayercardsplash("callout_top_gun_rank", var_1);
        var_10 = gettime();

        if(level.lastguntimevo + 4500 < var_10) {
          level thread maps\mp\_utility::leaderdialogonplayers("lastgun", level.players, "status");
          level.lastguntimevo = var_10;
        }
      }

      if(var_1.gungamegunindex < level.gun_guns.size * level.gun_cyclecount || !level.gun_cyclecount)
        var_1 givenextgun();
    }
  }
}

givenextgun(var_0) {
  self endon("disconnect");
  self notify("giveNextGun");
  self endon("giveNextGun");
  waittillframeend;
  var_1 = getnextgun();
  gungameclassupdate(var_1);
  var_2 = var_1.fullname;
  var_3 = common_scripts\utility::ter_op(var_1.altfireonly, weaponaltweaponname(var_2), var_2);

  while (!self loadweapons(var_2))
    waitframe();

  self takeallweapons();
  maps\mp\_utility::_giveweapon(var_3);

  if(isdefined(var_0))
    self setspawnweapon(var_3);

  var_4 = maps\mp\_utility::getbaseweaponname(var_2);
  self.pers["primaryWeapon"] = var_4;
  self.primaryweapon = var_2;
  self.primaryweaponalt = var_3;
  self givestartammo(self.primaryweapon);
  self.primaryweaponstartammo = self getweaponammostock(self.primaryweapon);

  if(self.primaryweaponalt != "none")
    self.primaryweaponaltstartammo = self getweaponammostock(self.primaryweaponalt);

  var_5 = !maps\mp\_utility::is_true(var_0);

  if(var_1.altfireonly) {
    self setweaponammoclip(self.primaryweapon, 0);
    self setweaponammostock(self.primaryweapon, 0);
    self.primaryweaponstartammo = 0;
    self switchtoweapon(var_3, var_5);
  } else
    self switchtoweapon(var_2, var_5);

  self.gungameprevgunindex = self.gungamegunindex;
}

getnextgun() {
  var_0 = level.gun_guns;
  var_1 = [];
  var_2 = undefined;
  var_2 = var_0[self.gungamegunindex % var_0.size];
  var_1[var_1.size] = var_2.fullname;

  if(self.gungamegunindex + 1 < var_0.size * level.gun_cyclecount)
    var_1[var_1.size] = var_0[(self.gungamegunindex + 1) % var_0.size].fullname;

  if(self.gungamegunindex > 0)
    var_1[var_1.size] = var_0[(self.gungamegunindex - 1) % var_0.size].fullname;

  self loadweapons(var_1);
  return var_2;
}

addattachments(var_0) {
  if(var_0 == "h1_rpg")
    var_1 = "h1_rpg_mp";
  else
    var_1 = maps\mp\gametypes\_class::buildweaponname(var_0, "none", "none");

  return var_1;
}

ontimelimit() {
  level.finalkillcam_winner = "none";
  var_0 = gethighestprogressedplayers();

  if(!isdefined(var_0) || !var_0.size)
    thread maps\mp\gametypes\_gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
  else if(var_0.size == 1)
    thread maps\mp\gametypes\_gamelogic::endgame(var_0[0], game["end_reason"]["time_limit_reached"]);
  else if(var_0[var_0.size - 1].gungamegunindex > var_0[var_0.size - 2].gungamegunindex)
    thread maps\mp\gametypes\_gamelogic::endgame(var_0[var_0.size - 1], game["end_reason"]["time_limit_reached"]);
  else
    thread maps\mp\gametypes\_gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
}

gethighestprogressedplayers() {
  var_0 = -1;
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isdefined(var_3.gungamegunindex) && var_3.gungamegunindex >= var_0) {
      var_0 = var_3.gungamegunindex;
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

refillammo() {
  level endon("game_ended");
  self endon("disconnect");

  for (;;) {
    self waittill("reload");
    self setweaponammostock(self.primaryweapon, self.primaryweaponstartammo);

    if(self.primaryweaponalt != "none")
      self setweaponammostock(self.primaryweaponalt, self.primaryweaponaltstartammo);
  }
}

refillsinglecountammo() {
  level endon("game_ended");
  self endon("disconnect");

  for (;;) {
    if(maps\mp\_utility::isreallyalive(self) && self.team != "spectator" && isdefined(self.primaryweapon) && self getammocount(self.primaryweapon) == 0) {
      wait 2;
      self notify("reload");
      wait 1;
      continue;
    }

    wait 0.05;
  }
}

guninfo(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3))
    var_3 = 0;

  var_4 = spawnstruct();
  var_4.basename = var_0;
  var_4.altfireonly = var_3;
  var_5 = var_1;

  if(level.gun_weaponattachments)
    var_5 = common_scripts\utility::random(var_2);

  if(var_0 == "h1_rpg")
    var_4.fullname = "h1_rpg_mp";
  else
    var_4.fullname = maps\mp\gametypes\_class::buildweaponname(var_0, var_5, "none");

  level.gun_guns[level.gun_guns.size] = var_4;
}

setguns() {
  var_0 = "h1_meleeshovel";
  var_1 = ["none"];
  level.gun_guns = [];

  switch (level.gun_weaponlist) {
    case 0:
    default:
      var_2 = ["none", "reflex", "gl", "silencer", "acog"];
      var_3 = ["none", "silencer", "reflex", "acog"];
      var_4 = ["none", "reflex", "grip", "acog"];
      var_5 = ["none", "reflex", "grip"];
      var_6 = ["none", "acog"];
      var_7 = ["none", "silencer"];
      var_8 = ["none"];
      guninfo("h1_colt45", "none", var_7);
      guninfo("h1_ak74u", "none", var_3);
      guninfo("h1_m16", "reflex", var_2);
      guninfo("h1_saw", "grip", var_4);
      guninfo("h1_m40a3", "none", var_6);
      guninfo("h1_beretta", "none", var_7);
      guninfo("h1_p90", "none", var_3);
      guninfo("h1_mp44", "none", var_1);
      guninfo("h1_m1014", "grip", var_5);
      guninfo("h1_m21", "none", var_6);
      guninfo("h1_usp", "silencer", var_7);
      guninfo("h1_skorpion", "none", var_3);
      guninfo("h1_m4", "none", var_2);
      guninfo("h1_m60e4", "none", var_4);
      guninfo("h1_dragunov", "none", var_6);
      guninfo("h1_g3", "reflex", var_2);
      guninfo("h1_mp5", "none", var_3);
      guninfo("h1_m14", "none", var_2);
      guninfo("h1_winchester1200", "none", var_5);
      guninfo("h1_remington700", "none", var_6);
      guninfo("h1_g36c", "acog", var_2);
      guninfo("h1_deserteagle", "none", var_1);
      guninfo("h1_uzi", "silencer", var_3);
      guninfo("h1_ak47", "none", var_2);
      guninfo("h1_rpd", "reflex", var_4);
      guninfo("h1_barrett", "none", var_6);
      break;
    case 1:
      var_9 = ["none", "reflex", "silencer"];
      var_10 = ["none", "silencer", "reflex"];
      var_11 = ["none", "reflex", "grip"];
      var_12 = ["none", "silencer"];
      guninfo("h1_colt45", "none", var_12);
      guninfo("h1_ak74u", "silencer", var_10);
      guninfo("h1_m16", "none", var_9);
      guninfo("h1_beretta", "none", var_12);
      guninfo("h1_p90", "none", var_10);
      guninfo("h1_g36c", "silencer", var_9);
      guninfo("h1_m1014", "grip", var_11);
      guninfo("h1_usp", "none", var_12);
      guninfo("h1_skorpion", "none", var_10);
      guninfo("h1_m4", "none", var_9);
      guninfo("h1_g3", "none", var_9);
      guninfo("h1_mp5", "silencer", var_10);
      guninfo("h1_m14", "none", var_9);
      guninfo("h1_winchester1200", "grip", var_11);
      guninfo("h1_mp44", "none", var_1);
      guninfo("h1_deserteagle", "none", var_1);
      guninfo("h1_uzi", "none", var_10);
      guninfo("h1_ak47", "none", var_9);
      break;
    case 2:
      var_13 = ["none", "reflex", "acog"];
      var_14 = ["none", "reflex", "grip", "acog"];
      var_15 = ["none", "acog"];
      guninfo("h1_m16", "reflex", var_13);
      guninfo("h1_saw", "grip", var_14);
      guninfo("h1_m40a3", "acog", var_15);
      guninfo("h1_mp44", "none", var_1);
      guninfo("h1_m21", "none", var_15);
      guninfo("h1_m4", "acog", var_13);
      guninfo("h1_m60e4", "reflex", var_14);
      guninfo("h1_dragunov", "none", var_15);
      guninfo("h1_g3", "none", var_13);
      guninfo("h1_m14", "reflex", var_13);
      guninfo("h1_remington700", "none", var_15);
      guninfo("h1_g36c", "none", var_13);
      guninfo("h1_ak47", "none", var_13);
      guninfo("h1_rpd", "grip", var_14);
      guninfo("h1_barrett", "none", var_15);
      break;
    case 3:
      var_16 = ["none", "reflex", "gl", "silencer", "acog"];
      guninfo("h1_m16", "none", var_16);
      guninfo("h1_mp44", "none", var_1);
      guninfo("h1_m4", "none", var_16);
      guninfo("h1_g3", "none", var_16);
      guninfo("h1_g36c", "none", var_16);
      guninfo("h1_ak47", "none", var_16);
      break;
    case 4:
      var_17 = ["none", "silencer", "reflex", "acog"];
      guninfo("h1_ak74u", "none", var_17);
      guninfo("h1_p90", "none", var_17);
      guninfo("h1_skorpion", "none", var_17);
      guninfo("h1_mp5", "none", var_17);
      guninfo("h1_uzi", "none", var_17);
      break;
    case 5:
      var_18 = ["none", "acog"];
      guninfo("h1_m40a3", "none", var_18);
      guninfo("h1_m21", "none", var_18);
      guninfo("h1_dragunov", "none", var_18);
      guninfo("h1_remington700", "none", var_18);
      guninfo("h1_barrett", "none", var_18);
      break;
    case 6:
      var_19 = ["none", "reflex", "grip"];
      guninfo("h1_m1014", "none", var_19);
      guninfo("h1_winchester1200", "none", var_19);
      break;
    case 7:
      var_20 = ["none", "reflex", "grip", "acog"];
      guninfo("h1_saw", "none", var_20);
      guninfo("h1_m60e4", "none", var_20);
      guninfo("h1_rpd", "none", var_20);
      break;
    case 8:
      var_21 = ["none", "silencer"];
      guninfo("h1_colt45", "none", var_21);
      guninfo("h1_beretta", "none", var_21);
      guninfo("h1_usp", "none", var_21);
      guninfo("h1_deserteagle", "none", var_1);
      break;
    case 9:
      var_22 = ["gl"];
      guninfo("h1_m16", "gl", var_22, 1);
      guninfo("h1_m4", "gl", var_22, 1);
      guninfo("h1_g3", "gl", var_22, 1);
      guninfo("h1_m14", "gl", var_22, 1);
      guninfo("h1_g36c", "gl", var_22, 1);
      guninfo("h1_ak47", "gl", var_22, 1);
      break;
  }

  switch (level.gun_weaponorder) {
    case 0:
    default:
      break;
    case 1:
      level.gun_guns = common_scripts\utility::array_randomize(level.gun_guns);
      break;
    case 2:
      level.gun_guns = common_scripts\utility::array_reverse(level.gun_guns);
      break;
  }

  switch (level.gun_weaponlistend) {
    case 0:
    default:
      guninfo("h1_rpg", "none", var_1);
      guninfo(var_0, "none", var_1);
      break;
    case 1:
      guninfo(var_0, "none", var_1);
      guninfo("h1_rpg", "none", var_1);
      break;
    case 2:
      guninfo("h1_rpg", "none", var_1);
      break;
    case 3:
      guninfo(var_0, "none", var_1);
      break;
    case 4:
      break;
  }
}