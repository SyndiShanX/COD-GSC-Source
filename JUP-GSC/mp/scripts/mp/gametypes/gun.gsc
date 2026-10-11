/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\gun.gsc
***********************************************/

#using script_15eddb0fac236a22;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\uav;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arena;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\team_gun;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\persistence;
#using scripts\mp\playerstats_interface;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace gun;

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed = [];
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registertimelimitdvar(getgametype(), 600);
    registerroundlimitdvar(getgametype(), 1);
    registerwinlimitdvar(getgametype(), 0);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
  }

  setspecialloadout();
  updategametypedvars();
  setgunladder();

  if(function_c1cddd7ae3bc2698()) {
    level.teambased = 1;
    level.ignorekdrstats = 1;
    level.disablespawncamera = 1;
    level.var_ff35df662c18a63d = getdvarint(@ "hash_73aac3f6d560f91f", 10);
  } else {
    setteammode("ffa");
    level.teambased = 0;
    level.ignorekdrstats = 1;
    level.disablespawncamera = 1;
  }

  if(!function_c1cddd7ae3bc2698()) {
    level thread scripts\cp_mp\killstreaks\uav::function_6394127938ed8257(3);
  }

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
  level.bypassclasschoicefunc = &scripts\mp\class::alwaysgamemodeclass;
  level.modifyunifiedpointscallback = &modifyunifiedpointscallback;

  if(function_c1cddd7ae3bc2698()) {
    level.getspawnpoint = &function_deaacd9c07dbc9fe;
    level.modifyunifiedpointscallback = undefined;
    level.onplayerscore = undefined;
    level.onplayerkilled = &function_849e633648f1596f;
    level.ontimelimit = &scripts\mp\gamelogic::default_ontimelimit;
  }

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    game["dialog"]["gametype"] = "dx_mp_gunn_game_uktl_ggt1";
  } else {
    game["dialog"]["gametype"] = "dx_mp_gunn_game_uktl_ggnm";
  }

  game["dialog"]["boost"] = "dx_mp_gunn_game_uktl_ggbo";
  game["dialog"]["offense_obj"] = "dx_mp_gunn_game_uktl_ggbo";
  game["dialog"]["defense_obj"] = "dx_mp_gunn_game_uktl_ggbo";
  game["dialog"]["lasttier_enemy"] = "dx_mp_gunn_game_uktl_ggfe";
  game["dialog"]["lasttier_friendly"] = "dx_mp_gunn_game_uktl_ggff";

  if(function_c1cddd7ae3bc2698()) {
    game["dialog"]["gametype"] = "dx_mp_mtgg_mode_t141_name";
  }

  setdevdvarifuninitialized(@ "hash_131d7c69641a09e6", 0);
  setdevdvarifuninitialized(@ "hash_4d0d7b8829a798cf", 0);
}

function waitthensetstatgroupreadonly() {
  self endon("game_ended");
  wait 1;

  if(isDefined(level.playerstats)) {
    makeplayerstatgroupreadonly("kdr");
    makeplayerstatgroupreadonly("losses");
    makeplayerstatgroupreadonly("winLoss");
  }
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  var_29fe567a5ca5271d = getmatchrulesdata("gunData", "gunGameWeaponsTable");
  level.var_29fe567a5ca5271d = getscriptbundle(hashcat(%"hash_adeeae037d337c6", var_29fe567a5ca5271d));
  assertex(isDefined(level.var_29fe567a5ca5271d), "<dev string:x1c>");
  var_a07458d2aa01e093 = getmatchrulesdata("gunData", "gunGameWeaponTierList");

  if(isDefined(var_a07458d2aa01e093)) {
    level.gungameweapons = getscriptbundle(hashcat(%"hash_586ba1c6dbd22d07", var_a07458d2aa01e093));
    assertex(isDefined(level.gungameweapons), "<dev string:x70>" + var_a07458d2aa01e093);
  }

  level.var_1a933adf9d114ff4 = getmatchrulesdata("gunData", "meleeGivesScore");
  level.setback = getmatchrulesdata("gunData", "setback");
  level.setbackstreak = getmatchrulesdata("gunData", "setbackStreak");
  level.killsperweapon = getmatchrulesdata("gunData", "killsPerWeapon");
  level.ladderindex = getmatchrulesdata("gunData", "ladderIndex");
  level.useladderindex = getmatchrulesdata("gunData", "useLadderIndex");
  setdynamicdvar(@ "hash_d35ca3409324ec94", 0);
}

function onprecachegametype() {}

function onstartgametype() {
  setclientnamemode("auto_change");

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/DM");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/DM");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/DM_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/DM_HINT");
  }

  setgunsfinal();

  if(function_c1cddd7ae3bc2698()) {
    function_4acafac11df3da39();
  } else {
    initspawns();
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.quickmessagetoall = 1;
  level.blockweapondrops = 1;

  level thread function_976d13e05a73c64e();
  level thread function_d5a7aac125289e1d();
}

function initspawns() {
  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll", "Crit_Default");
  }

  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dm_spawn_start", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn_secondary", 1, 1);
  spawns = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", spawns);
  scripts\mp\spawnlogic::registerspawnset("fallback", spawnssecondary);
}

function function_4acafac11df3da39() {
  if(getdvarint(@ "hash_742caa13b3c2e685")) {
    return;
  }

  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);

  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else if(getdvarint(@ "t10", 0) > 0) {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  } else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Frontline");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  spawns = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", spawns);
  scripts\mp\spawnlogic::registerspawnset("fallback", spawnssecondary);

  if(istrue(level.testtdmanywhere)) {
    x = getdvarfloat(@ "hash_b6294c84c04e377b", randomfloatrange(-4096, 4096));
    y = getdvarfloat(@ "hash_b6294b84c04e3548", randomfloatrange(-4096, 4096));
    z = getdvarfloat(@ "hash_b6294e84c04e3be1", randomfloatrange(0, 512));
    level.mapcenter = (x, y, z);
    return;
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function onplayerconnect(player) {
  player thread keepweaponsloaded();
  player scripts\mp\class::function_a16868d4dcd81a4b();
  player.pers["gamemodeLoadout"] = level.gun_loadouts["axis"];
  player.gungamegunindex = 0;
  player.gungameprevgunindex = 0;
  player thread refillammo();
  player thread refillsinglecountammo();

  if(function_c1cddd7ae3bc2698() && !isbot(player)) {
    player notifyonplayercommand("gun_game_next", "+weapnext");
  }
}

function keepweaponsloaded() {
  self loadweaponsforplayer([level.gun_guns[0], level.gun_guns[1]], 1);
  closeweapons = [];

  while(true) {
    self waittill("update_loadweapons");
    closeweapons[0] = level.gun_guns[int(max(0, self.gungamegunindex - level.setback))];
    closeweapons[1] = level.gun_guns[self.gungamegunindex];
    closeweapons[2] = level.gun_guns[self.gungamegunindex + 1];
    self loadweaponsforplayer(closeweapons, 1);
  }
}

function getspawnpoint() {
  if(level.ingraceperiod) {
    spawnpoint = undefined;
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");

    if(spawnpoints.size > 0) {
      if(!isDefined(level.requiresminstartspawns)) {
        assertex(spawnpoints.size >= 8, "<dev string:xbc>" + 8 + "<dev string:xdb>");
      }

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

function function_deaacd9c07dbc9fe() {
  spawnteam = self.pers["team"];
  spawnpoint = undefined;

  if(istrue(level.testtdmanywhere)) {
    var_4a31bbf837fe3389 = level.tdmanywherefrontline.anchorrt * randomfloatrange(level.tdmanywhere_perpenoffset * -1, level.tdmanywhere_perpenoffset);
    var_fc4e89bc101f9a57 = undefined;

    if(spawnteam == "axis") {
      var_fc4e89bc101f9a57 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset * -1;
    } else {
      var_fc4e89bc101f9a57 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
    }

    spawnpoint = spawnStruct();
    spawnpoint.origin = level.mapcenter + var_4a31bbf837fe3389 + var_fc4e89bc101f9a57 + (0, 0, level.tdmanywhere_dropheight);
    spawnpoint.angles = (0, 0, 0);
    spawnpoint.index = 1;
  } else if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "fallback");
  }

  return spawnpoint;
}

function onspawnplayer(revivespawn) {
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill");
  thread waitloadoutdone();
  self setclientomnvar("show_change_weapon_prompt", 0);
  level notify("spawned_player");
}

function waitloadoutdone() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");

  if(function_c1cddd7ae3bc2698()) {
    function_aa7d3b7589a7323e();
  }

  if(level.gameended && self.gungamegunindex == level.gun_guns.size) {
    self.gungamegunindex = self.gungameprevgunindex;
  }

  giveperk("specialty_bling");
  thread givenextgun(1);
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid) {
  if(level.gameended) {
    return;
  }

  if(smeansofdeath == "MOD_FALLING" || isDefined(attacker) && isPlayer(attacker)) {
    ismeleeweapon = isriotshield(objweapon.basename);
    isknife = isknifeonly(objweapon.basename) || isakimbomeleeweapon(objweapon.basename) || isaxeweapon(objweapon.basename) || ismeleeoverrideweapon(objweapon);
    isexecution = isDefined(smeansofdeath) && smeansofdeath == "MOD_EXECUTION";
    var_93dff29841ceccf0 = isDefined(smeansofdeath) && smeansofdeath == "MOD_MELEE_TAKEDOWN";

    if(!isDefined(self.ladderdeathsthisweapon)) {
      self.ladderdeathsthisweapon = 1;
    } else {
      self.ladderdeathsthisweapon++;
    }

    if(smeansofdeath == "MOD_FALLING" || attacker == self || smeansofdeath == "MOD_MELEE" && isknife || self.ladderdeathsthisweapon == level.setbackstreak || isexecution || var_93dff29841ceccf0) {
      self.ladderdeathsthisweapon = 0;
      self notify("update_loadweapons");
      self.gungameprevgunindex = self.gungamegunindex;
      self.gungamegunindex = int(max(0, self.gungamegunindex - level.setback));

      if(self.gungameprevgunindex > self.gungamegunindex) {
        scripts\mp\gamescore::giveplayerscore(#"dropped_gun_rank", 1);
        thread scripts\mp\rank::scoreeventpopup(#"dropped_gun_rank");
        incpersstat("setbacks", 1);
        scripts\mp\persistence::statsetchild("round", "setbacks", self.pers["setbacks"]);
        self playlocalsound("jup_mode_gun_rank_down");

        if(isPlayer(self)) {
          setextrascore1(self.pers["setbacks"]);
        }
      }

      if(smeansofdeath == "MOD_MELEE") {
        if(self.gungameprevgunindex) {
          attacker thread doscoreevent(#"hash_9fedfea2929dc7da");
        }

        attacker updateknivesperminute();
        attacker scripts\mp\utility\points::doscoreevent(#"mode_gun_melee");
        attacker incpersstat("stabs", 1);
        attacker scripts\mp\persistence::statsetchild("round", "stabs", attacker.pers["stabs"]);

        if(isPlayer(attacker)) {
          attacker setextrascore0(attacker.pers["stabs"]);
        }
      }

      if(attacker == self) {
        return;
      }
    }

    if(attacker != self && smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_IMPACT" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_FIRE" || smeansofdeath == "MOD_MELEE" && !isknife && istrue(level.var_1a933adf9d114ff4) || smeansofdeath == "MOD_MELEE" && isknife || isexecution) {
      baseprimary = getweaponbasename(attacker.primaryweapon);

      if(!attacker canprogressingunrank(objweapon, baseprimary, isexecution)) {
        return;
      }

      if(!isDefined(attacker.ladderkillsthisweapon)) {
        attacker.ladderkillsthisweapon = 1;
      } else {
        attacker.ladderkillsthisweapon++;
      }

      if(attacker.ladderkillsthisweapon != level.killsperweapon) {
        return;
      }

      attacker.ladderkillsthisweapon = 0;
      attacker.ladderdeathsthisweapon = 0;
      attacker.gungameprevgunindex = attacker.gungamegunindex;
      attacker.gungamegunindex++;
      attacker notify("update_loadweapons");
      attacker scripts\mp\gamescore::giveplayerscore(#"gained_gun_rank", 1);

      if(attacker.gungamegunindex == level.gun_guns.size - 2) {
        level.kick_afk_check = 1;
      }

      if(attacker isonlastkill()) {
        losingplayers = [];

        foreach(p in level.players) {
          if(p != attacker) {
            losingplayers[losingplayers.size] = p;
          }
        }

        scripts\mp\utility\dialog::leaderdialogonplayers("lasttier_enemy", losingplayers);
        attacker scripts\mp\utility\dialog::leaderdialogonplayer("lasttier_friendly");
        attacker scripts\mp\hud_message::showsplash("gun_final_kill");
        scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
        level thread teamplayercardsplash("callout_top_gun_rank", attacker);
      }

      if(attacker.gungamegunindex < level.gun_guns.size) {
        points = scripts\mp\rank::getscoreinfovalue(#"gained_gun_rank");
        attacker thread scripts\mp\rank::scorepointspopup(points);
        attacker thread scripts\mp\rank::scoreeventpopup(#"gained_gun_rank");
        attacker playlocalsound("jup_mode_gun_rank_up");
        attacker thread givenextgun(0);
      }

      if(isDefined(attacker.lastgunrankincreasetime) && gettime() - attacker.lastgunrankincreasetime < 5000) {
        attacker scripts\mp\utility\points::doscoreevent(#"mode_gun_quick_kill");
      }

      attacker.lastgunrankincreasetime = gettime();
    }
  }
}

function function_849e633648f1596f(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid) {
  awardteam = attacker.pers["team"];

  if(!isDefined(level.var_9b6e5e563299fef9)) {
    level.var_9b6e5e563299fef9 = [];
  }

  if(!isDefined(level.var_b0ad9e7ef6c53ce7)) {
    level.var_b0ad9e7ef6c53ce7 = [];
  }

  if(!isDefined(level.var_9b6e5e563299fef9[awardteam])) {
    level.var_9b6e5e563299fef9[awardteam] = level.var_ff35df662c18a63d;
  }

  if(!isDefined(level.var_b0ad9e7ef6c53ce7[awardteam])) {
    level.var_b0ad9e7ef6c53ce7[awardteam] = 0;
  }

  currentscore = getteamscore(awardteam) + 1;
  ismeleeweapon = isriotshield(objweapon.basename);
  isknife = isknifeonly(objweapon.basename) || isakimbomeleeweapon(objweapon.basename) || isaxeweapon(objweapon.basename) || ismeleeoverrideweapon(objweapon);
  isexecution = isDefined(smeansofdeath) && smeansofdeath == "MOD_EXECUTION";

  if(smeansofdeath == "MOD_FALLING" || attacker == self || smeansofdeath == "MOD_MELEE" && isknife) {
    if(smeansofdeath == "MOD_MELEE") {
      attacker scripts\mp\utility\points::doscoreevent(#"mode_gun_melee");
      attacker incpersstat("stabs", 1);
      attacker scripts\mp\persistence::statsetchild("round", "stabs", attacker.pers["stabs"]);

      if(isPlayer(attacker)) {
        attacker setextrascore0(attacker.pers["stabs"]);
      }
    }

    return;
  }

  if(currentscore == level.var_9b6e5e563299fef9[awardteam]) {
    level.var_b0ad9e7ef6c53ce7[awardteam]++;
    level.var_9b6e5e563299fef9[awardteam] += level.var_ff35df662c18a63d;

    foreach(player in getteamdata(awardteam, "players")) {
      player.gungamegunindex = level.var_b0ad9e7ef6c53ce7[awardteam];
      player.gungameprevgunindex = level.var_b0ad9e7ef6c53ce7[awardteam] - 1;
      points = scripts\mp\rank::getscoreinfovalue(#"gained_gun_rank");
      player thread scripts\mp\rank::scorepointspopup(points);
      player thread scripts\mp\rank::scoreeventpopup(#"gained_gun_rank");
      player playlocalsound("jup_mode_team_gun_rank_up_splash");
      player thread function_27748d0b77246b9d();
      player thread givenextgun(0);
    }
  }
}

function givenextgun(dosetspawnweapon) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!dosetspawnweapon) {
    val::set("spawn_weapon", "weapon_switch", 0);
  }

  if(function_c1cddd7ae3bc2698() && !dosetspawnweapon) {
    result = wait_button_pressed_or_timeout(5);

    if(!istrue(result)) {
      return;
    }
  }

  waitframe();
  newweaponobj = getnextgun();
  newweaponobj = scripts\mp\weapons::updatesavedaltstate(newweaponobj);
  _giveweapon(newweaponobj, undefined, undefined, 1);

  if(function_c1cddd7ae3bc2698() && !dosetspawnweapon) {
    self playlocalsound("jup_mode_team_gun_rank_up_gain");
  }

  if(dosetspawnweapon) {
    self setspawnweapon(newweaponobj);

    foreach(weapon in self.weaponlist) {
      if(weapon == newweaponobj) {
        continue;
      }

      if(isDefined(self.climbweapon) && getweaponbasename(weapon) == self.climbweapon) {
        continue;
      }

      if(isDefined(self.swimweapon) && getweaponbasename(weapon) == self.swimweapon) {
        continue;
      }

      thread takeweaponwhensafe(weapon);
    }
  }

  self.pers["primaryWeapon"] = newweaponobj.basename;
  self.primaryweapon = newweaponobj.basename;
  self.primaryweaponobj = newweaponobj;
  namespace_6b49ddb858f34366::function_adcb155953291ec7(1, 0);
  _switchtoweapon(newweaponobj);
  isaxe = isaxeweapon(newweaponobj);

  if(isaxe) {
    self setweaponammoclip(newweaponobj, 1);
    thread takeweaponwhensafegungame("iw9_knifestab_mp", 0);
  } else if(self.gungamegunindex != level.gun_guns.size - 1) {
    self givestartammo(newweaponobj);
    knifeweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("iw9_knifestab_mp");
    self giveweapon(knifeweapon);
    self assignweaponmeleeslot(knifeweapon);
  }

  if(!dosetspawnweapon) {
    currentweapon = self.lastdroppableweaponobj;
    thread takeweaponwhensafegungame(currentweapon, 1);
  }

  giveortakethrowingknife(newweaponobj.basename);
  scripts\mp\weapons::updatetogglescopestate(newweaponobj);
  self.gungameprevgunindex = self.gungamegunindex;

  if(!isDefined(self.lastgunpromotiontime)) {
    self.lastgunpromotiontime = gettime();
  }

  timespentonweapon = (gettime() - self.lastgunpromotiontime) / 1000;
  self.lastgunpromotiontime = gettime();

  if(isDefined(self.pers["longestTimeSpentOnWeapon"]) && timespentonweapon > self.pers["longestTimeSpentOnWeapon"]) {
    self.pers["longestTimeSpentOnWeapon"] = timespentonweapon;
  }
}

function function_27748d0b77246b9d() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("gun_game_next");

  for(i = 1; i < 6; i++) {
    self playlocalsound("jup_mode_team_gun_rank_timer_0" + i);
    wait 1;
  }
}

function wait_button_pressed_or_timeout(time) {
  self endon("disconnect");
  self notify("wait_button_pressed_or_timeout");
  self endon("wait_button_pressed_or_timeout");
  self setclientomnvar("show_change_weapon_prompt", 1);
  msg = waittill_any_timeout_2(time, "gun_game_next");
  self setclientomnvar("show_change_weapon_prompt", 0);
  return true;
}

function takeweaponwhensafegungame(weapon, allowswitch) {
  self endon("death_or_disconnect");

  while(true) {
    if(!iscurrentweapon(weapon)) {
      break;
    }

    waitframe();
  }

  _takeweapon(weapon);

  if(allowswitch) {
    val::reset_all("spawn_weapon");
  }
}

function getnextgun(indexoverride) {
  gunindex = self.gungamegunindex;

  if(isDefined(indexoverride)) {
    gunindex = indexoverride;
  }

  newweapon = level.gun_guns[gunindex];
  return newweapon;
}

function ontimelimit() {
  winners = gethighestprogressedplayers();

  if(!isDefined(winners) || !winners.size) {
    thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(winners.size == 1) {
    thread scripts\mp\gamelogic::endgame(winners[0], game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(winners[winners.size - 1].gungamegunindex > winners[winners.size - 2].gungamegunindex) {
    thread scripts\mp\gamelogic::endgame(winners[winners.size - 1], game["end_reason"]["time_limit_reached"]);
    return;
  }

  thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
}

function gethighestprogressedplayers() {
  highestprogress = -1;
  highestprogressedplayers = [];

  foreach(player in level.players) {
    if(isDefined(player.gungamegunindex) && player.gungamegunindex >= highestprogress) {
      highestprogress = player.gungamegunindex;
      highestprogressedplayers[highestprogressedplayers.size] = player;
    }
  }

  return highestprogressedplayers;
}

function refillammo() {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    self waittill("reload");
    currentweapon = self getcurrentweapon();
    clipsize = weaponclipsize(currentweapon);

    if(isaxeweapon(currentweapon)) {
      self setweaponammoclip(currentweapon, clipsize);
      continue;
    }

    startingammo = weaponstartammo(currentweapon);
    stockammo = startingammo - clipsize;
    self setweaponammostock(currentweapon, stockammo);
  }
}

function refillsinglecountammo() {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    if(isreallyalive(self) && self.team != "spectator" && isDefined(self.primaryweapon) && self getammocount(self getcurrentweapon()) == 0) {
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

  if(istrue(level.useladderindex)) {
    switch (level.ladderindex) {
      case 1:
      case 4:
      case 5:
      case 6:
        if(matchmakinggame() && getdvarint(@ "hash_fb3e643c9cdd861", 0) == 1) {
          level.gun_guns[0] = {
            #weaponcategory: "rand_pistol"};
          level.gun_guns[1] = {
            #weaponcategory: "rand_shotgun"};
          level.gun_guns[2] = {
            #weaponcategory: "rand_smg"};
          level.gun_guns[3] = {
            #weaponcategory: "rand_assault"};
          level.gun_guns[4] = {
            #weaponcategory: "rand_lmg"};
          level.gun_guns[5] = {
            #weaponcategory: "rand_sniper"};
          level.gun_guns[6] = {
            #weaponcategory: "rand_smg"};
          level.gun_guns[7] = {
            #weaponcategory: "rand_assault"};
          level.gun_guns[8] = {
            #weaponcategory: "rand_lmg"};
          level.gun_guns[9] = {
            #weaponcategory: "rand_launcher"};
          level.gun_guns[10] = {
            #weaponcategory: "rand_shotgun"};
          level.gun_guns[11] = {
            #weaponcategory: "rand_smg"};
          level.gun_guns[12] = {
            #weaponcategory: "rand_assault"};
          level.gun_guns[13] = {
            #weaponcategory: "rand_shotgun"};
          level.gun_guns[14] = {
            #weaponcategory: "rand_assault"};
          level.gun_guns[15] = {
            #weaponcategory: "rand_sniper"};
          level.gun_guns[16] = {
            #weaponcategory: "rand_pistol"};
          level.gun_guns[17] = {
            #weaponcategory: "rand_knife_end"};
        } else {
          level.gun_guns[0] = {
            #weaponcategory: "rand_assault"};
          level.gun_guns[1] = {
            #weaponcategory: "rand_smg"};
          level.gun_guns[2] = {
            #weaponcategory: "rand_shotgun"};
          level.gun_guns[3] = {
            #weaponcategory: "rand_lmg"};
          level.gun_guns[4] = {
            #weaponcategory: "rand_assault"};
          level.gun_guns[5] = {
            #weaponcategory: "rand_dmr"};
          level.gun_guns[6] = {
            #weaponcategory: "rand_pistol"};
          level.gun_guns[7] = {
            #weaponcategory: "rand_assault"};
          level.gun_guns[8] = {
            #weaponcategory: "rand_smg"};
          level.gun_guns[9] = {
            #weaponcategory: "rand_launcher"};
          level.gun_guns[10] = {
            #weaponcategory: "rand_dmr"};
          level.gun_guns[11] = {
            #weaponcategory: "rand_lmg"};
          level.gun_guns[12] = {
            #weaponcategory: "rand_assault"};
          level.gun_guns[13] = {
            #weaponcategory: "rand_smg"};
          level.gun_guns[14] = {
            #weaponcategory: "rand_sniper"};
          level.gun_guns[15] = {
            #weaponcategory: "rand_shotgun"};
          level.gun_guns[16] = {
            #weaponcategory: "rand_pistol"};
          level.gun_guns[17] = {
            #weaponcategory: "rand_knife_end"};
        }

        break;
      case 2:
        level.gun_guns[0] = {
          #weaponcategory: "rand_pistol"};
        level.gun_guns[1] = {
          #weaponcategory: "rand_shotgun"};
        level.gun_guns[2] = {
          #weaponcategory: "rand_smg"};
        level.gun_guns[3] = {
          #weaponcategory: "rand_assault"};
        level.gun_guns[4] = {
          #weaponcategory: "rand_pistol"};
        level.gun_guns[5] = {
          #weaponcategory: "rand_shotgun"};
        level.gun_guns[6] = {
          #weaponcategory: "rand_smg"};
        level.gun_guns[7] = {
          #weaponcategory: "rand_assault"};
        level.gun_guns[8] = {
          #weaponcategory: "rand_pistol"};
        level.gun_guns[9] = {
          #weaponcategory: "rand_shotgun"};
        level.gun_guns[10] = {
          #weaponcategory: "rand_smg"};
        level.gun_guns[11] = {
          #weaponcategory: "rand_assault"};
        level.gun_guns[12] = {
          #weaponcategory: "rand_pistol"};
        level.gun_guns[13] = {
          #weaponcategory: "rand_shotgun2"};
        level.gun_guns[14] = {
          #weaponcategory: "rand_smg"};
        level.gun_guns[15] = {
          #weaponcategory: "rand_assault"};
        level.gun_guns[16] = {
          #weaponcategory: "rand_pistol"};
        level.gun_guns[17] = {
          #weaponcategory: "rand_knife_end"};
        break;
      case 3:
        level.gun_guns[0] = {
          #weaponcategory: "rand_pistol"};
        level.gun_guns[1] = {
          #weaponcategory: "rand_assault"};
        level.gun_guns[2] = {
          #weaponcategory: "rand_lmg"};
        level.gun_guns[3] = {
          #weaponcategory: "rand_launcher"};
        level.gun_guns[4] = {
          #weaponcategory: "rand_sniper"};
        level.gun_guns[5] = {
          #weaponcategory: "rand_assault"};
        level.gun_guns[6] = {
          #weaponcategory: "rand_lmg"};
        level.gun_guns[7] = {
          #weaponcategory: "rand_launcher"};
        level.gun_guns[8] = {
          #weaponcategory: "rand_sniper"};
        level.gun_guns[9] = {
          #weaponcategory: "rand_assault"};
        level.gun_guns[10] = {
          #weaponcategory: "rand_lmg"};
        level.gun_guns[11] = {
          #weaponcategory: "rand_launcher"};
        level.gun_guns[12] = {
          #weaponcategory: "rand_sniper2"};
        level.gun_guns[13] = {
          #weaponcategory: "rand_assault"};
        level.gun_guns[14] = {
          #weaponcategory: "rand_sniper2"};
        level.gun_guns[15] = {
          #weaponcategory: "rand_assault"};
        level.gun_guns[16] = {
          #weaponcategory: "rand_pistol"};
        level.gun_guns[17] = {
          #weaponcategory: "rand_knife_end"};
        break;
      case 7:
        level.gun_guns[0] = {
          #weaponcategory: "rand_pistol"};
        level.gun_guns[1] = {
          #weaponcategory: "rand_assault"};
        level.gun_guns[2] = {
          #weaponcategory: "rand_lmg"};
        level.gun_guns[3] = {
          #weaponcategory: "rand_smg"};
        level.gun_guns[4] = {
          #weaponcategory: "rand_sniper"};
        level.gun_guns[5] = {
          #weaponcategory: "rand_pistol"};
        level.gun_guns[6] = {
          #weaponcategory: "rand_lmg"};
        level.gun_guns[7] = {
          #weaponcategory: "rand_battle_rifle"};
        level.gun_guns[8] = {
          #weaponcategory: "rand_dmr"};
        level.gun_guns[9] = {
          #weaponcategory: "rand_assault"};
        level.gun_guns[10] = {
          #weaponcategory: "rand_smg"};
        level.gun_guns[11] = {
          #weaponcategory: "rand_battle_rifle"};
        level.gun_guns[12] = {
          #weaponcategory: "rand_dmr"};
        level.gun_guns[13] = {
          #weaponcategory: "rand_assault"};
        level.gun_guns[14] = {
          #weaponcategory: "rand_smg"};
        level.gun_guns[15] = {
          #weaponcategory: "rand_smg"};
        level.gun_guns[16] = {
          #weaponcategory: "rand_pistol"};
        level.gun_guns[17] = {
          #weaponcategory: "rand_knife_end"};
        break;
    }
  } else {
    level.gun_guns = level.gungameweapons.weaponlist;
  }

  if(level.gametype == "gun") {
    scorelimit = level.gun_guns.size;
    setdynamicdvar(@ "hash_a7992f287575dd31", scorelimit);
    registerscorelimitdvar(getgametype(), scorelimit);
  }
}

function setgunsfinal() {
  level.selectedweapons = [];
  function_102741e35aa549ae();

  for(i = 0; i < level.gun_guns.size; i++) {
    curgun = level.gun_guns[i];

    if(string_starts_with(curgun.weaponcategory, "rand_")) {
      weapondata = function_5f97f15e9ca6cb6(curgun.weaponcategory);

      if(level.ladderindex == 4 || level.ladderindex == 5) {
        level.gun_guns[i] = buildweapon_blueprint(weapondata["weapon"], undefined, undefined, weapondata["variantID"], undefined, undefined, scripts\cp_mp\utility\game_utility::isnightmap());
      } else {
        level.gun_guns[i] = function_96d23570114bc7b6(weapondata);
      }

      continue;
    }

    rootname = getweaponrootname(level.gun_guns[i]);
    level.selectedweapons[rootname] = 1;
    newweapon = rootname;
    numattachments = 0;

    if(level.ladderindex == 4 || level.ladderindex == 5) {
      newweapon = buildweapon_blueprint(rootname, undefined, undefined, undefined, undefined, undefined, scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4());
    } else {
      newweapon = gun_createrandomweapon(rootname, numattachments, undefined, scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4());
    }

    level.gun_guns[i] = newweapon;
  }

  level.selectedweapons = undefined;
}

function getrandomarchetype() {
  return "archetype_assault";
}

function setspecialloadout() {
  level.gun_loadouts["axis"]["loadoutPrimary"] = "none";
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

function function_6b7afefdbeeeec0a() {
  level.weaponcategories = [];

  for(row = 0; true; row++) {
    categoryname = tablelookupbyrow("mp/gunGameWeapons.csv", row, 0);

    if(categoryname == "") {
      break;
    }

    if(!isDefined(level.weaponcategories[categoryname])) {
      level.weaponcategories[categoryname] = [];
    }

    requiredpack = tablelookupbyrow("mp/gunGameWeapons.csv", row, 5);

    if(requiredpack == "" || getdvarint(requiredpack, 0) == 1) {
      data = [];
      data["weapon"] = getweaponrootname(tablelookupbyrow("mp/gunGameWeapons.csv", row, 1));
      data["min"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", row, 2));
      data["max"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", row, 3));
      data["perk"] = tablelookupbyrow("mp/gunGameWeapons.csv", row, 4);

      if(level.ladderindex == 4 || level.ladderindex == 5) {
        if(!isDefined(game["arenaWeaponCategories"])) {
          level.arenaloadouts = 13;
          scripts\mp\gametypes\arena::function_b7c18ded2347456c();
        }

        data["variantID"] = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(data["weapon"]);
      }

      data["allowed"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", row, 7));

      if((level.ladderindex == 4 || level.ladderindex == 6) && !data["allowed"]) {
        row++;
        continue;
      }

      level.weaponcategories[categoryname][level.weaponcategories[categoryname].size] = data;
    }
  }
}

function function_102741e35aa549ae() {
  level.weaponcategories = [];

  foreach(ggweapondata in level.var_29fe567a5ca5271d.weaponstable) {
    if(!isDefined(level.weaponcategories[ggweapondata.groupname])) {
      level.weaponcategories[ggweapondata.groupname] = [];
    }

    data = [];
    data["weapon"] = ggweapondata.baseweapon;
    data["min"] = ggweapondata.minattachments;
    data["max"] = ggweapondata.maxattachments;
    data["perk"] = ggweapondata.bonusperk;

    if(level.ladderindex == 4 || level.ladderindex == 5) {
      if(!isDefined(game["arenaWeaponCategories"])) {
        level.arenaloadouts = 13;
        scripts\mp\gametypes\arena::function_b7c18ded2347456c();
      }

      data["variantID"] = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(data["weapon"]);
    }

    data["allowed"] = ggweapondata.var_dea829db5b5247a9;

    if((level.ladderindex == 4 || level.ladderindex == 6) && !data["allowed"]) {
      continue;
    }

    level.weaponcategories[ggweapondata.groupname][level.weaponcategories[ggweapondata.groupname].size] = data;
  }
}

function function_5f97f15e9ca6cb6(categoryname) {
  weaponlist = level.weaponcategories[categoryname];

  if(isDefined(weaponlist) && weaponlist.size > 0) {
    newweapon = "";
    data = undefined;

    for(loopcount = 0; true; loopcount++) {
      index = randomintrange(0, weaponlist.size);
      data = weaponlist[index];
      rootname = getweaponrootname(data["weapon"]);
      var_aaa935a3ebf3fd7c = 1;

      if(level.ladderindex == 4 || level.ladderindex == 6) {
        var_aaa935a3ebf3fd7c = data["allowed"];
      }

      if(isDefined(level.selectedweapons) && !isDefined(level.selectedweapons[rootname]) && var_aaa935a3ebf3fd7c || loopcount > weaponlist.size) {
        level.selectedweapons[rootname] = 1;

        for(i = 0; i < level.weaponcategories[categoryname].size; i++) {
          if(level.weaponcategories[categoryname][i]["weapon"] == data["weapon"]) {
            level.weaponcategories[categoryname] = array_remove_index(level.weaponcategories[categoryname], i);
            break;
          }
        }

        break;
      }
    }

    return data;
  }

  assertmsg("<dev string:xec>" + categoryname + "<dev string:x10d>" + level.var_29fe567a5ca5271d);
  return "none";
}

function function_96d23570114bc7b6(weapondata) {
  numattachments = randomintrange(weapondata["min"], weapondata["max"] + 1);
  newweapon = gun_createrandomweapon(weapondata["weapon"], numattachments, weapondata["variantID"], scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4());
  return newweapon;
}

function gun_createrandomweapon(rootname, numattachments, variantid, hasnvg) {
  if((!isDefined(numattachments) || !getdvarint(@ "hash_76d3386761ef7fb6", 0)) && !istrue(level.var_c423c2360ca0dac5)) {
    numattachments = 0;
  }

  var_b8215055a946eebb = buildweapon(rootname, undefined, undefined, undefined, variantid, undefined, undefined, undefined, hasnvg);
  var_952f1674fa8d734f = [];

  if(numattachments > 0) {
    slotexcludelist = ["visual", "modifier2"];
    var_952f1674fa8d734f = scripts\mp\weapons::function_8df87e6b1d13c15a(var_b8215055a946eebb, numattachments, 0, slotexcludelist, 1000);
  }

  if(var_952f1674fa8d734f.size > 0) {
    var_b8215055a946eebb = buildweapon(rootname, var_952f1674fa8d734f, undefined, undefined, variantid, undefined, undefined, undefined, hasnvg);
  }

  return var_b8215055a946eebb;
}

function gun_buildoverrideattachmentlist(randomweapon) {
  possibleattachments = getallselectableattachments(randomweapon);
  var_79583f5b5010a954 = [];

  foreach(attachment in possibleattachments) {
    if(isstartstr(attachment, "gl") || isstartstr(attachment, "ub") || isstartstr(attachment, "thermal") || attachment == "hybrid3") {
      continue;
    }

    var_79583f5b5010a954[var_79583f5b5010a954.size] = attachment;
  }

  return var_79583f5b5010a954;
}

function attachmentcheck(attachment, var_517683bad763b676, var_a71a84cdad3a4ebb, weaponname) {
  attachmentcategory = tablelookup(var_a71a84cdad3a4ebb, 0, attachment, 1);

  for(i = 0; i < var_517683bad763b676.size; i++) {
    var_e012c12f441a9c1d = tablelookup(var_a71a84cdad3a4ebb, 0, var_517683bad763b676[i], 1);

    if(attachment == var_517683bad763b676[i] || attachmentsconflict(attachment, var_517683bad763b676[i], weaponname) != "" || attachmentcategory == var_e012c12f441a9c1d) {
      return false;
    }
  }

  return true;
}

function giveortakethrowingknife(currentweapon) {
  scripts\mp\equipment::takeequipment("primary");

  if(isknifeonly(currentweapon) || isakimbomeleeweapon(currentweapon) || isaxeweapon(currentweapon)) {
    giveperk("specialty_scavenger");
    giveperk("specialty_pitcher");
    scripts\mp\equipment::giveequipment("equip_throwing_knife", "primary");
    thread scripts\mp\equipment::incrementequipmentammo("equip_throwing_knife");
  }
}

function isvalidthrowingknifekill(killweapon) {
  return killweapon == "throwingknife_mp";
}

function onplayerscore(event, player, originalpoints, victim, eventinfo) {
  player incpersstat("gamemodeScore", originalpoints);
  newscore = player getpersstat("gamemodeScore");
  player scripts\mp\persistence::statsetchild("round", "gamemodeScore", newscore);
  score = 0;

  if(event == "gained_gun_rank") {
    score = 1;
  } else if(event == "dropped_gun_rank") {
    setbackscore = level.setback;
    score = setbackscore * -1;
  } else if(event == "assist_ffa" || event == "kill") {
    player bufferednotify("earned_score_buffered", originalpoints);
  }

  assert(isDefined(score));
  return score;
}

function updateknivesperminute() {
  if(!isDefined(self.knivesperminute)) {
    self.numknives = 0;
    self.knivesperminute = 0;
  }

  self.numknives++;

  if(getminutespassed() < 1) {
    return;
  }

  self.knivesperminute = self.numknives / getminutespassed();
}

function modifyunifiedpointscallback(points, event, player, objweapon) {
  if(isDefined(objweapon) && (objweapon.basename == "iw9_me_knife_mp" || objweapon.basename == "jup_jp23_me_knife_mp" || objweapon.basename == "iw8_me_akimboblunt_mp" || objweapon.basename == "iw8_me_akimboblades_mp")) {
    if(isDefined(player) && isDefined(player.knivesperminute) && player.knivesperminute >= 10) {
      return 0;
    }
  }

  return points;
}

function canprogressingunrank(objweapon, baseprimary, isexecution) {
  if(objweapon.basename == baseprimary && !(objweapon.basename == "jup_jp23_me_knife_mp")) {
    return true;
  }

  if(baseprimary == "iw8_sn_crossbow_mp") {
    if(issubstr(objweapon.basename, "bolt")) {
      return true;
    }
  }

  if(objweapon.basename == "dragonsbreath_mp") {
    return true;
  }

  if(isonlastkill()) {
    if(isvalidthrowingknifekill(objweapon.basename)) {
      return true;
    }

    if(isexecution) {
      return true;
    }
  }

  return false;
}

function isonlastkill() {
  return self.gungamegunindex == level.gun_guns.size - 1;
}

function function_d5a7aac125289e1d() {
  level endon("<dev string:x14d>");

  while(true) {
    dovalidate = getdvarint(@ "hash_d5afb25002d2a396", 0);
    setDvar(@ "hash_d5afb25002d2a396", 0);

    if(dovalidate) {
      foreach(class in level.weaponcategories) {
        foreach(weapon in class) {
          level.players[0] takeallweapons();
          setDvar(@ "scr_giveweapon", weapon["<dev string:x15b>"]);
          wait 1;
          adddebugcommand("<dev string:x165>" + "<dev string:x178>" + weapon["<dev string:x15b>"] + "<dev string:x187>");
          wait 2;
        }
      }
    }

    waitframe();
  }
}

function function_976d13e05a73c64e() {
  level endon("<dev string:x14d>");

  while(true) {
    rankup = getdvarint(@ "hash_131d7c69641a09e6", 0);
    rankdown = getdvarint(@ "hash_4d0d7b8829a798cf", 0);

    if(rankup || rankdown) {
      foreach(player in level.players) {
        baseprimary = getweaponbasename(player.primaryweapon);
        player.gungameprevgunindex = player.gungamegunindex;
        updategun = 0;

        if(rankup) {
          newrank = player.gungamegunindex + 1;

          if(newrank >= level.gun_guns.size - 1) {
            player iprintlnbold("<dev string:x18c>");
          } else {
            player.gungamegunindex++;
            updategun = 1;
            player scripts\mp\gamescore::giveplayerscore(#"gained_gun_rank", 1);
            points = scripts\mp\rank::getscoreinfovalue(#"gained_gun_rank");
            player thread scripts\mp\rank::scorepointspopup(points);
            player thread scripts\mp\rank::scoreeventpopup(#"gained_gun_rank");
            player playlocalsound("<dev string:x1c4>");
          }

          setDvar(@ "hash_131d7c69641a09e6", 0);
        } else {
          newrank = player.gungamegunindex - 1;

          if(newrank < 0) {
            player iprintlnbold("<dev string:x1dc>");
          } else {
            player.gungamegunindex--;
            updategun = 1;
            player scripts\mp\gamescore::giveplayerscore(#"dropped_gun_rank", 1);
            player incpersstat("<dev string:x215>", 1);
            player scripts\mp\persistence::statsetchild("<dev string:x221>", "<dev string:x215>", player.pers["<dev string:x215>"]);
            player playlocalsound("<dev string:x22a>");

            if(isPlayer(player)) {
              player setextrascore1(player.pers["<dev string:x215>"]);
            }
          }

          setDvar(@ "hash_4d0d7b8829a798cf", 0);
        }

        if(istrue(updategun)) {
          player notify("<dev string:x244>");
          player thread givenextgun(0);
          player.lastgunrankincreasetime = gettime();
        }
      }
    }

    waitframe();
  }
}

function function_277a84f0f23bdb9b() {
  while(true) {
    wait 6;
    setDvar(@ "hash_131d7c69641a09e6", 1);
  }
}

# /