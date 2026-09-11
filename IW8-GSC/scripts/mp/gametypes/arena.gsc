/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arena.gsc
***********************************************/

function main() {
  game["isLaunchChunk"] = getdvarint("MPNRKLKOKR", 0) != 0;

  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_arena_arenaloadouts", getmatchrulesdata("arenaData", "arenaLoadouts"));
  setdynamicdvar("scr_arena_loadoutchangeround", getmatchrulesdata("arenaData", "loadoutChangeRound"));
  setdynamicdvar("scr_arena_switchspawns", getmatchrulesdata("arenaData", "switchSpawns"));
  setdynamicdvar("scr_arena_winCondition", getmatchrulesdata("arenaData", "winCondition"));
  setdynamicdvar("scr_arena_objModifier", getmatchrulesdata("arenaData", "objModifier"));
  setdynamicdvar("scr_arena_spawnFlag", getmatchrulesdata("arenaData", "spawnFlag"));
  setdynamicdvar("scr_arena_flagCaptureTime", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("scr_arena_tacticaltimemod", getmatchrulesdata("arenaData", "tacticalTimeMod"));
  setdynamicdvar("scr_arena_blastshieldmod", getmatchrulesdata("arenaData", "blastShieldMod"));
  setdynamicdvar("scr_arena_blastshieldclamp", getmatchrulesdata("arenaData", "blastShieldClamp"));
  setdynamicdvar("scr_arena_startWeapon", getmatchrulesdata("arenaData", "startWeapon"));
  setdynamicdvar("scr_arena_weaponTier1", getmatchrulesdata("arenaData", "weaponTier1"));
  setdynamicdvar("scr_arena_weaponTier2", getmatchrulesdata("arenaData", "weaponTier2"));
  setdynamicdvar("scr_arena_weaponTier3", getmatchrulesdata("arenaData", "weaponTier3"));
  setdynamicdvar("scr_arena_weaponTier4", getmatchrulesdata("arenaData", "weaponTier4"));
  setdynamicdvar("scr_arena_weaponTier5", getmatchrulesdata("arenaData", "weaponTier5"));
  setdynamicdvar("scr_arena_weaponTier6", getmatchrulesdata("arenaData", "weaponTier6"));
  setdynamicdvar("scr_arena_weaponTier7", getmatchrulesdata("arenaData", "weaponTier7"));
  setdynamicdvar("scr_arena_weaponTier8", getmatchrulesdata("arenaData", "weaponTier8"));
  setdynamicdvar("scr_arena_arenaAttachments", getmatchrulesdata("arenaData", "arenaAttachments"));
  setdynamicdvar("scr_arena_arenaSuper", getmatchrulesdata("arenaData", "arenaSuper"));
  setdynamicdvar("scr_arena_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
  }

  foreach(var3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var3, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/WAR");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/WAR_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var3, &"OBJECTIVES/WAR_HINT");
  }

  initspawns();

  if(game["roundsPlayed"] == 0) {
    thread setroundwinstreakarray();
  }

  thread adjustroundendtimer();
  thread waittooverridegraceperiod();
  var5 = 1;

  if(istrue(level.ref_1343f)) {
    if(!level.brmissionscompleted && game["roundsPlayed"] == 0 && istrue(game["practiceRound"])) {
      level.extratime = 30;
      game["didSnowFight"] = 1;
      level.arenaloadouts = 3;
      var5 = 0;
    } else if(level.brmissionscompleted) {
      level.arenaloadouts = 3;
      var5 = 0;
    }

    level.ref_13443["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
    level.ref_13443["screen"] = loadfx("vfx/iw8/weap/_impact/snowball/vfx_imp_snowball_scrn.vfx");

    if(!var5) {
      ref_1343f();
    }
  }

  if(var5) {
    if(israndomloadouts() || usbs_pulled_out() || usb_right() || usb_tape_animation_test()) {
      thread updaterandomloadout();
    } else if(ispickuploadouts()) {
      buildrandomweapontable();

      if(!isDefined(game["roundsPlayed"]) || isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
        level.startweapon.weapon = getrandomweaponforweapontier(level.startweapon.weapon, 1);
        level.arenaweapont1.weapon = getrandomweaponforweapontier(level.arenaweapont1.weapon);
        level.arenaweapont2.weapon = getrandomweaponforweapontier(level.arenaweapont2.weapon);
        level.arenaweapont3.weapon = getrandomweaponforweapontier(level.arenaweapont3.weapon);
        level.arenaweapont4.weapon = getrandomweaponforweapontier(level.arenaweapont4.weapon);
        level.arenaweapont5.weapon = getrandomweaponforweapontier(level.arenaweapont5.weapon);
        level.arenaweapont6.weapon = getrandomweaponforweapontier(level.arenaweapont6.weapon);
        level.arenaweapont7.weapon = getrandomweaponforweapontier(level.arenaweapont7.weapon);
        level.arenaweapont8.weapon = getrandomweaponforweapontier(level.arenaweapont8.weapon);
        level.startweapon.variantid = regroup_at_truck(level.startweapon.weapon);
        level.arenaweapont1.variantid = regroup_at_truck(level.arenaweapont1.weapon);
        level.arenaweapont2.variantid = regroup_at_truck(level.arenaweapont2.weapon);
        level.arenaweapont3.variantid = regroup_at_truck(level.arenaweapont3.weapon);
        level.arenaweapont4.variantid = regroup_at_truck(level.arenaweapont4.weapon);
        level.arenaweapont5.variantid = regroup_at_truck(level.arenaweapont5.weapon);
        level.arenaweapont6.variantid = regroup_at_truck(level.arenaweapont6.weapon);
        level.arenaweapont7.variantid = regroup_at_truck(level.arenaweapont7.weapon);
        level.arenaweapont8.variantid = regroup_at_truck(level.arenaweapont8.weapon);
      } else if(level.loadoutchangeround == 0 || game["roundsPlayed"] % level.loadoutchangeround != 0) {
        level.startweapon.weapon = game["startWeapon"]["weapon"];
        level.arenaweapont1.weapon = game["arenaWeaponT1"]["weapon"];
        level.arenaweapont2.weapon = game["arenaWeaponT2"]["weapon"];
        level.arenaweapont3.weapon = game["arenaWeaponT3"]["weapon"];
        level.arenaweapont4.weapon = game["arenaWeaponT4"]["weapon"];
        level.arenaweapont5.weapon = game["arenaWeaponT5"]["weapon"];
        level.arenaweapont6.weapon = game["arenaWeaponT6"]["weapon"];
        level.arenaweapont7.weapon = game["arenaWeaponT7"]["weapon"];
        level.arenaweapont8.weapon = game["arenaWeaponT8"]["weapon"];
        level.startweapon.variantid = game["startWeapon"]["variantID"];
        level.arenaweapont1.variantid = game["arenaWeaponT1"]["variantID"];
        level.arenaweapont2.variantid = game["arenaWeaponT2"]["variantID"];
        level.arenaweapont3.variantid = game["arenaWeaponT3"]["variantID"];
        level.arenaweapont4.variantid = game["arenaWeaponT4"]["variantID"];
        level.arenaweapont5.variantid = game["arenaWeaponT5"]["variantID"];
        level.arenaweapont6.variantid = game["arenaWeaponT6"]["variantID"];
        level.arenaweapont7.variantid = game["arenaWeaponT7"]["variantID"];
        level.arenaweapont8.variantid = game["arenaWeaponT8"]["variantID"];
      } else if(game["roundsPlayed"] % level.loadoutchangeround == 0) {
        level.startweapon.weapon = getrandomweaponforweapontier(level.startweapon.weapon, 1);
        level.arenaweapont1.weapon = getrandomweaponforweapontier(level.arenaweapont1.weapon);
        level.arenaweapont2.weapon = getrandomweaponforweapontier(level.arenaweapont2.weapon);
        level.arenaweapont3.weapon = getrandomweaponforweapontier(level.arenaweapont3.weapon);
        level.arenaweapont4.weapon = getrandomweaponforweapontier(level.arenaweapont4.weapon);
        level.arenaweapont5.weapon = getrandomweaponforweapontier(level.arenaweapont5.weapon);
        level.arenaweapont6.weapon = getrandomweaponforweapontier(level.arenaweapont6.weapon);
        level.arenaweapont7.weapon = getrandomweaponforweapontier(level.arenaweapont7.weapon);
        level.arenaweapont8.weapon = getrandomweaponforweapontier(level.arenaweapont8.weapon);
        level.startweapon.variantid = regroup_at_truck(level.startweapon.weapon);
        level.arenaweapont1.variantid = regroup_at_truck(level.arenaweapont1.weapon);
        level.arenaweapont2.variantid = regroup_at_truck(level.arenaweapont2.weapon);
        level.arenaweapont3.variantid = regroup_at_truck(level.arenaweapont3.weapon);
        level.arenaweapont4.variantid = regroup_at_truck(level.arenaweapont4.weapon);
        level.arenaweapont5.variantid = regroup_at_truck(level.arenaweapont5.weapon);
        level.arenaweapont6.variantid = regroup_at_truck(level.arenaweapont6.weapon);
        level.arenaweapont7.variantid = regroup_at_truck(level.arenaweapont7.weapon);
        level.arenaweapont8.variantid = regroup_at_truck(level.arenaweapont8.weapon);
      }

      game["startWeapon"]["weapon"] = level.startweapon.weapon;
      game["arenaWeaponT1"]["weapon"] = level.arenaweapont1.weapon;
      game["arenaWeaponT2"]["weapon"] = level.arenaweapont2.weapon;
      game["arenaWeaponT3"]["weapon"] = level.arenaweapont3.weapon;
      game["arenaWeaponT4"]["weapon"] = level.arenaweapont4.weapon;
      game["arenaWeaponT5"]["weapon"] = level.arenaweapont5.weapon;
      game["arenaWeaponT6"]["weapon"] = level.arenaweapont6.weapon;
      game["arenaWeaponT7"]["weapon"] = level.arenaweapont7.weapon;
      game["arenaWeaponT8"]["weapon"] = level.arenaweapont8.weapon;
      game["startWeapon"]["variantID"] = level.startweapon.variantid;
      game["arenaWeaponT1"]["variantID"] = level.arenaweapont1.variantid;
      game["arenaWeaponT2"]["variantID"] = level.arenaweapont2.variantid;
      game["arenaWeaponT3"]["variantID"] = level.arenaweapont3.variantid;
      game["arenaWeaponT4"]["variantID"] = level.arenaweapont4.variantid;
      game["arenaWeaponT5"]["variantID"] = level.arenaweapont5.variantid;
      game["arenaWeaponT6"]["variantID"] = level.arenaweapont6.variantid;
      game["arenaWeaponT7"]["variantID"] = level.arenaweapont7.variantid;
      game["arenaWeaponT8"]["variantID"] = level.arenaweapont8.variantid;
      level.lethaldelay = 0;
      defineplayerloadout();

      if(!istrue(level.ref_1343f)) {
        initweaponmap();
        thread setupweapons();
      } else {
        ref_1343f();
      }
    } else if(isgungameloadouts()) {
      level.blockweapondrops = 1;
      thread updatearenagungameloadout(0);
    } else if(isrvsgungameloadouts()) {
      level.blockweapondrops = 1;
      thread updatearenagungameloadout(1);
    }
  }

  if(!isnormalloadouts()) {
    buildloadoutsforweaponstreaming();
  }

  setupwaypointicons();
  seticonnames();

  if(level.objmodifier == 1) {
    setupendzones(level);
  }

  if(level.spawnflag) {
    var6 = 0;

    if(!scripts\mp\flags::gameflag("prematch_done") && game["roundsPlayed"] == 0) {
      var6 = 1;
    }

    thread spawngameendflagzone(level);
  }

  physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 0);

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    if(game["roundsPlayed"] == 0) {
      thread outlineenemyplayers();
      thread removeenemyoutlines();
    }
  }

  if(!isDefined(game["pingEnabled"])) {
    game["pingEnabled"] = getdvarint("OLMLQMOSRL", 0);
  }

  if(istrue(game["pingEnabled"])) {
    scripts\cp_mp\vehicles\vehicle_compass::calloutmarkerping_init();
    return;
  }
}

function waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");
  level.overrideingraceperiod = 1;
  level.ingraceperiod = 5;
}

function alwaysgamemodeclass() {
  return "gamemode";
}

function adjustroundendtimer() {
  wait 1;
  level.roundenddelay = 4;
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();

  if(level.dogtagsenabled) {
    level.dogtagallyonusecb = &dogtagallyonusecb;
    level.dogtagenemyonusecb = &dogtagenemyonusecb;
  }

  if(getdvarint("allow_enemy_proxchat", 0) == 1) {
    setDvar("LOSOOOTNMS", 1);
    var0 = 128;
    var1 = getdvarint("proxchat_radius_override", 0);

    if(var1 != 0) {
      var0 = var1;
    }

    setDvar("NNMLSMNTOQ", var0);
  }

  level.arenaloadouts = scripts\mp\utility\dvars::dvarintvalue("arenaLoadouts", 1, 1, 16);
  level.loadoutchangeround = scripts\mp\utility\dvars::dvarintvalue("loadoutChangeRound", 3, 0, 5);
  level.switchspawns = scripts\mp\utility\dvars::dvarintvalue("switchSpawns", 1, 0, 1);
  level.wincondition = scripts\mp\utility\dvars::dvarintvalue("winCondition", 1, 0, 2);
  setomnvar("ui_arena_loadout_type", level.arenaloadouts);
  setomnvar("ui_wincondition", level.wincondition);
  level.objmodifier = scripts\mp\utility\dvars::dvarintvalue("objModifier", 0, 0, 2);
  level.spawnflag = scripts\mp\utility\dvars::dvarintvalue("spawnFlag", 0, 0, 1);

  if(level.spawnflag) {
    level.ontimelimitgraceperiod = getdvarfloat("scr_arena_overtime_timelimit", 10);
    level.currenttimelimitdelay = 0;
    level.canprocessot = 1;
  }

  level.tacticaltimemod = scripts\mp\utility\dvars::dvarfloatvalue("tacticalTimeMod", 2.5, 0.5, 5);
  level.startweapon = spawnStruct();
  level.arenaweapont1 = spawnStruct();
  level.arenaweapont2 = spawnStruct();
  level.arenaweapont3 = spawnStruct();
  level.arenaweapont4 = spawnStruct();
  level.arenaweapont5 = spawnStruct();
  level.arenaweapont6 = spawnStruct();
  level.arenaweapont7 = spawnStruct();
  level.arenaweapont8 = spawnStruct();
  level.startweapon.weapon = getDvar("scr_arena_startWeapon", "none");
  level.arenaweapont1.weapon = getDvar("scr_arena_weaponTier1", "iw8_pi_golf21_mp");
  level.arenaweapont2.weapon = getDvar("scr_arena_weaponTier2", "iw8_sh_dpapa12_mp");
  level.arenaweapont3.weapon = getDvar("scr_arena_weaponTier3", "iw8_sm_mpapa5_mp");
  level.arenaweapont4.weapon = getDvar("scr_arena_weaponTier4", "iw8_ar_mike4_mp");
  level.arenaweapont5.weapon = getDvar("scr_arena_weaponTier5", "iw8_sn_alpha50_mp");
  level.arenaweapont6.weapon = getDvar("scr_arena_weaponTier6", "equip_frag");
  level.arenaweapont7.weapon = getDvar("scr_arena_weaponTier7", "equip_concussion");
  level.arenaweapont8.weapon = getDvar("scr_arena_weaponTier8", "equip_adrenaline");
  level.calloutmarkerpingvo_getcalloutaliasstringentity = getdvarint("scr_arena_arenaAttachments", 0);
  level.calloutmarkerpingvo_getcalloutaliasstringvehicle = getDvar("scr_arena_arenaSuper", "none");

  if(level.calloutmarkerpingvo_getcalloutaliasstringvehicle == "none") {
    setomnvar("ui_disable_fieldupgrades", 1);
    return;
  }
}

function getrandomweaponforweapontier(var0, var1) {
  if(issubstr(var0, "rand")) {
    if(var0 == "random") {
      var0 = getrandomspawnweapon();
    } else {
      var0 = getrandomweaponfromcategory(var0, var1);
    }
  }

  return var0;
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_allies_start");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_axis_start");
  var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn");

  if(var0.size > 0 || var1.size > 0) {
    scripts\mp\spawnlogic::addstartspawnpoints("mp_arena_spawn_allies_start");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_arena_spawn_axis_start");
    level.alliesstartspawn = "mp_arena_spawn_allies_start";
    level.axisstartspawn = "mp_arena_spawn_axis_start";
  } else {
    scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
    level.alliesstartspawn = "mp_sd_spawn_attacker";
    level.axisstartspawn = "mp_sd_spawn_defender";
  }

  if(var2.size > 0) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_arena_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_arena_spawn");
    level.spawntype = "mp_arena_spawn";
  } else {
    var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");

    if(var2.size > 0) {
      scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
      scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
      level.spawntype = "mp_tdm_spawn";
    } else {
      level.alwaysusestartspawns = 1;
    }
  }

  var3 = scripts\mp\spawnlogic::getspawnpointarray(level.spawntype);
  var4 = scripts\mp\spawnlogic::getspawnpointarray(level.spawntype);
  scripts\mp\spawnlogic::registerspawnset("normal", var3);
  scripts\mp\spawnlogic::registerspawnset("fallback", var4);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function validatespawns(var0) {
  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = 0;
  var5 = scripts\mp\spawnlogic::getspawnpointarray(var0);

  foreach(var7 in var5) {
    if(isDefined(var7.script_noteworthy)) {
      if(!var1) {
        var1 = var7.script_noteworthy == "1";
      }

      if(!var2) {
        var2 = var7.script_noteworthy == "2";
      }

      if(!var3) {
        var3 = var7.script_noteworthy == "3";
        level.hasthreespawns = 1;
      }

      continue;
    }

    if(var4 == 0) {
      var7.script_noteworthy = "1";
      var4++;
      continue;
    }

    if(var4 == 1) {
      var7.script_noteworthy = "2";
      var4++;
      continue;
    }

    if(var4 == 2) {
      var7.script_noteworthy = "3";
      var4++;
      level.hasthreespawns = 1;
    }
  }
}

function getspawnpoint() {
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  var0 = undefined;
  var1 = level.axisstartspawn;
  var2 = 0;

  if(self.pers["team"] == game["attackers"]) {
    var1 = level.alliesstartspawn;
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn() || istrue(level.alwaysusestartspawns) || dotournamentendgame()) {
    scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
    var3 = scripts\mp\spawnlogic::getspawnpointarray(var1);

    if(istrue(level.switchspawns) && game["roundsPlayed"] > 0) {
      var4 = scripts\mp\utility\teams::getteamcount(self.pers["team"]);

      if(var4 > 3) {
        foreach(var6 in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
          if(isDefined(var6.pers["arena_spawn_pos"])) {
            var6.pers["arena_spawn_pos"] = "0";
          }
        }

        var2 = 1;
      }
    }

    if(istrue(level.switchspawns) && game["roundsPlayed"] > 0 && !var2) {
      if(self.pers["arena_spawn_pos"] == "1") {
        self.pers["arena_spawn_pos"] = "2";
      } else if(scripts\mp\utility\teams::getteamcount(self.pers["team"], 0) == 3 && istrue(level.hasthreespawns) && self.pers["arena_spawn_pos"] == "2") {
        self.pers["arena_spawn_pos"] = "3";
      } else if(self.pers["arena_spawn_pos"] == "3") {
        self.pers["arena_spawn_pos"] = "1";
      } else {
        self.pers["arena_spawn_pos"] = "1";
      }

      var0 = getswitchside_spawnpoint(var3, self.pers["arena_spawn_pos"]);
    }

    if(!isDefined(var0)) {
      if(istrue(self.switching_teams_arena) && isDefined(self.pers["arena_spawn_pos"])) {
        cleanupspawn_scriptnoteworthy();
        var0 = getspawnpoint_startspawn(var3);
        self.switching_teams_arena = undefined;

        if(isDefined(var0)) {
          self.ref_13685 = var0.angles;
        }
      } else {
        var0 = getspawnpoint_startspawn(var3);

        if(isDefined(var0)) {
          self.ref_13685 = var0.angles;
        }
      }

      if(!isDefined(var0)) {
        var4 = scripts\mp\utility\teams::getteamcount(self.pers["team"]);

        if(var4 > 3) {
          var8 = undefined;
          var9 = 0;

          foreach(var6 in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
            if(istrue(var6.fine_drop_pos)) {
              var9++;
              continue;
            }

            break;
          }

          foreach(var6 in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
            if(var6 == self) {
              continue;
            }

            if(istrue(var6.fine_drop_pos)) {
              continue;
            }

            if(!istrue(var6.hasspawned)) {
              continue;
            }

            if(isDefined(var6.pers["arena_spawn_pos"])) {
              if(level.usedspawnposone[self.pers["team"]] == 1 && level.usedspawnpostwo[self.pers["team"]] == 1 && level.usedspawnposthree[self.pers["team"]] == 1) {
                level.usedspawnposone[self.pers["team"]] = 0;
                level.usedspawnpostwo[self.pers["team"]] = 0;
                level.usedspawnposthree[self.pers["team"]] = 0;
              }

              if(var6.pers["arena_spawn_pos"] == "1" && level.usedspawnposone[self.pers["team"]] == 0) {
                level.usedspawnposone[self.pers["team"]]++;
                var6.fine_drop_pos = 1;
                var8 = var6;
                break;
              }

              if(var6.pers["arena_spawn_pos"] == "2" && level.usedspawnpostwo[self.pers["team"]] == 0) {
                level.usedspawnpostwo[self.pers["team"]]++;
                var6.fine_drop_pos = 1;
                var8 = var6;
                break;
              }

              if(var6.pers["arena_spawn_pos"] == "3" && level.usedspawnposthree[self.pers["team"]] == 0) {
                level.usedspawnposthree[self.pers["team"]]++;
                var6.fine_drop_pos = 1;
                var8 = var6;
                break;
              }

              level.usedspawnposone[self.pers["team"]]++;
              var6.fine_drop_pos = 1;
              var8 = var6;
              break;
            }
          }

          if(isDefined(var8)) {
            var0 = scripts\mp\spawnscoring::findteammatebuddyspawn(var8);

            if(isDefined(var8.ref_13685)) {
              var0.angles = var8.ref_13685;
            }
          }
        }
      }

      if(!isDefined(var0)) {
        scripts\mp\spawnlogic::activatespawnset("normal");
        var0 = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["team"], "normal", "fallback");
      }

      if(isDefined(var0.script_noteworthy) && var0.script_noteworthy != "" && istrue(level.switchspawns) && game["roundsPlayed"] == 0) {
        self.pers["arena_spawn_pos"] = var0.script_noteworthy;
      }
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal");
    var0 = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["team"], "normal", "fallback");
  }

  return var0;
}

function cleanupspawn_scriptnoteworthy() {
  var0 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];

  if(var0 == game["attackers"]) {
    var1 = level.alliesstartspawn;
    var2 = level.axisstartspawn;
  } else {
    var1 = level.axisstartspawn;
    var2 = level.alliesstartspawn;
  }

  var3 = scripts\mp\spawnlogic::getspawnpointarray(var1);

  foreach(var5 in var3) {
    if(var5.script_noteworthy == self.pers["arena_spawn_pos"]) {
      var5.selected = 0;
    }
  }

  var3 = scripts\mp\spawnlogic::getspawnpointarray(var2);

  foreach(var5 in var3) {
    foreach(var9 in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
      if(var9 != self && isDefined(var9.pers["arena_spawn_pos"]) && var5.script_noteworthy != var9.pers["arena_spawn_pos"]) {
        var5.selected = 0;
      }
    }
  }
}

function getspawnpoint_startspawn(var0, var1) {
  if(!isDefined(var0)) {
    return undefined;
  }

  var2 = undefined;
  var0 = scripts\mp\spawnscoring::checkdynamicspawns(var0);

  foreach(var4 in var0) {
    if(!isDefined(var4.selected)) {
      continue;
    }

    if(var4.selected) {
      continue;
    }

    if(var4.script_noteworthy == "1") {
      var2 = var4;
      break;
    } else if(var4.script_noteworthy == "2") {
      var2 = var4;
      break;
    }

    var2 = var4;
  }

  if(isDefined(var2)) {
    var2.selected = 1;
  }

  return var2;
}

function getswitchside_spawnpoint(var0, var1) {
  if(!isDefined(var0)) {
    return undefined;
  }

  var2 = 0;

  foreach(var4 in var0) {
    if(var4.script_noteworthy == var1) {
      if(istrue(var4.selected)) {
        var2 = 1;
        continue;
      }

      var4.selected = 1;
      return var4;
    }
  }

  return undefined;
}

function onplayerconnect(var0) {
  if(istrue(level.allowkillstreaks)) {
    level.allowkillstreaks = 0;
  }

  var0.arenadamage = 0;
  var0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var0.pers["damage"])) {
    var0 scripts\mp\utility\stats::setextrascore0(var0.pers["damage"]);
  }

  if(!isnormalloadouts()) {
    var0 setclientomnvar("ui_skip_loadout", 1);
    var0.pers["class"] = "gamemode";
    var0.pers["lastClass"] = "";
    var0.class = var0.pers["class"];
    var0.lastclass = var0.pers["lastClass"];

    if(israndomloadouts() || usbs_pulled_out() || usb_right() || usb_tape_animation_test()) {
      var0.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
    } else if(ispickuploadouts()) {
      var0.pers["gamemodeLoadout"] = level.arena_loadouts["axis"];
    }

    if(isgungameloadouts() || isrvsgungameloadouts()) {
      var0.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][getgungameloadoutindex(var0)];

      if(game["roundsPlayed"] == 0) {
        setenemyloadoutomnvars(var0);
      }
    }

    foreach(var2 in level.teamnamelist) {
      if(isDefined(var0.pers["team"]) && game["roundWinStreak"][var2] > 0 && var0.pers["team"] == var2) {
        var0.pers["gamemodeLoadout"]["roundWinStreakPrimaryCamoTeam"] = var2;
        var0.pers["gamemodeLoadout"]["roundWinStreakPrimaryCamo"] = ref_131bd();
        var0.pers["gamemodeLoadout"]["roundWinStreakecondaryCamoTeam"] = var2;
        var0.pers["gamemodeLoadout"]["roundWinStreakSecondaryCamo"] = ref_131bd();
      }
    }
  }

  if(istrue(level.switchspawns) && !isDefined(var0.pers["arena_spawn_pos"])) {
    var0.pers["arena_spawn_pos"] = "0";
  }

  thread onjoinedteam();

  if(!isnormalloadouts()) {
    updatehighpriorityweapons(var0);
  }

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);

  if(istrue(game["pingEnabled"])) {
    var0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();
    return;
  }
}

function onplayerdisconnect(var0) {
  ref_131cb(1);

  if(istrue(game["pingEnabled"])) {
    var1 = 1;

    foreach(var3 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamcount(var3) > 4) {
        var1 = 0;
        break;
      }
    }

    setDvar("OLMLQMOSRL", var1);
    return;
  }
}

function onjoinedteam() {
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
    ref_131cb();
  }
}

function onspawnplayer() {
  thread onspawnfinished();
  level notify("spawned_player");
  thread updatematchstatushintonspawn();
  scripts\mp\menus::updatesquadomnvars(self.team, self.squadindex);
}

function onspawnfinished() {
  self endon("death_or_disconnect");

  if(istrue(game["practiceRound"]) || istrue(level.brmissionscompleted)) {
    thread ref_13441();
  }

  thread damagewatcher();

  if(!isnormalloadouts()) {
    self waittill("giveLoadout");
    runarenaloadoutrulesonplayer();
  }

  thread modifyblastshieldperk();

  if(level.calloutmarkerpingvo_doesoperatorsupportalias) {
    scripts\mp\utility\perk::giveperk("specialty_quickswap");
  }

  wait 0.1;
  self.hasarenaspawned = 1;
  wait 0.15;

  if(!scripts\mp\flags::gameflag("prematch_done") && game["roundsPlayed"] == 0) {
    if(level.spawnflag && isDefined(level.matchcountdowntime) && level.matchcountdowntime > 5) {
      if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
        scripts\mp\utility\dialog::leaderdialogonplayer("obj_indepth", "introboost");
      }
    }

    level scripts\engine\utility::ref_143a5("prematch_done", "removeArenaOutlines");
  }

  self setclientomnvar("ui_player_notify_loadout", gettime());
}

function ref_131cb(var0) {
  var1 = getdvarint("scr_player_maxhealth", 100);
  var2 = scripts\mp\utility\teams::getteamdata("allies", "teamCount");

  if(var2) {
    level.alliesmaxhealth = scripts\mp\utility\teams::getteamdata("allies", "teamCount") * var1;
    setomnvar("ui_arena_allies_health_max", level.alliesmaxhealth);

    if(!istrue(var0) && !scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::mayspawn()) {
      self waittill("spawned_player");
    }

    var3 = 0;

    foreach(var5 in scripts\mp\utility\teams::getteamdata("allies", "players")) {
      var3 += var5.health;
    }

    level.allieshealth = var3;

    if(level.allieshealth < 0) {
      level.allieshealth = 0;
    }

    setomnvar("ui_arena_allies_health", level.allieshealth);
  } else {
    setomnvar("ui_arena_allies_health", 0);
  }

  var7 = scripts\mp\utility\teams::getteamdata("axis", "teamCount");

  if(var7) {
    level.axismaxhealth = scripts\mp\utility\teams::getteamdata("axis", "teamCount") * var1;
    setomnvar("ui_arena_axis_health_max", level.axismaxhealth);

    if(!istrue(var0) && !scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::mayspawn()) {
      self waittill("spawned_player");
    }

    var8 = 0;

    foreach(var5 in scripts\mp\utility\teams::getteamdata("axis", "players")) {
      var8 += var5.health;
    }

    level.axishealth = var8;

    if(level.axishealth < 0) {
      level.axishealth = 0;
    }

    setomnvar("ui_arena_axis_health", level.axishealth);
    return;
  }

  setomnvar("ui_arena_axis_health", 0);
}

function modifyblastshieldperk() {
  var0 = scripts\mp\utility\dvars::dvarintvalue("blastShieldMod", 65, 0, 100) / 100;

  if(var0 == 0) {
    scripts\mp\utility\perk::removeperk("specialty_blastshield");
    return;
  }
}

function onplayerdamaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  if(isDefined(var1) && var1 != var2 && isPlayer(var1)) {
    if(istrue(level.ref_1343f) && (var6.basename == "snowball_mp" || var6.basename == "pball_mp")) {
      playfxontagforclients(level.ref_13443["screen"], var2, "tag_eye", var2);
    }

    if(var3 >= var7) {
      var3 = var7;
    }

    var1.arenadamage += var3;
    var1 scripts\mp\persistence::statsetchild("round", "damage", var1.pers["damage"]);
    var1 scripts\mp\utility\stats::setextrascore0(var1.pers["damage"]);
    return;
  }
}

function damagewatcher() {
  self notify("startDamageWatcher");
  self endon("startDamageWatcher");
  level endon("game_ended");
  self endon("disconnect");
  self.totaldamagetaken = 0;

  for(;;) {
    scripts\engine\utility::ref_143aa("damage", "force_regeneration", "removeAdrenaline", "healed", "healhRegenThink", "vampirism", "spawned_player");

    if(self.team == "allies") {
      var0 = 0;

      foreach(var2 in scripts\mp\utility\teams::getteamdata("allies", "players")) {
        var0 += var2.health;
      }

      level.allieshealth = var0;

      if(level.allieshealth < 0) {
        level.allieshealth = 0;
      }

      setomnvar("ui_arena_allies_health", level.allieshealth);
    } else {
      var4 = 0;

      foreach(var2 in scripts\mp\utility\teams::getteamdata("axis", "players")) {
        var4 += var2.health;
      }

      level.axishealth = var4;

      if(level.axishealth < 0) {
        level.axishealth = 0;
      }

      setomnvar("ui_arena_axis_health", level.axishealth);
    }

    if(istrue(self.iscapturing)) {
      var7 = undefined;

      if(level.objmodifier == 1) {
        if(self.team == game["defenders"]) {
          level.attackerendzone.curprogress = 50;
          level.attackerendzone.teamprogress[self.team] = 50;
          var7 = level.attackerendzone;
        } else if(self.team == game["attackers"]) {
          level.defenderendzone.curprogress = 50;
          level.defenderendzone.teamprogress[self.team] = 50;
          var7 = level.defenderendzone;
        }

        scripts\mp\objidpoolmanager::objective_set_progress(var7.objidnum, var7.curprogress / var7.usetime);
      }
    }
  }
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);

  if(!isnormalloadouts()) {
    if(isbot(var0)) {
      var0.classcallback = "gamemode";
    }
  }

  if(game["state"] == "postgame") {
    var1.finalkill = 1;
    return;
  }
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  scripts\mp\menus::updatesquadomnvars(self.team, self.squadindex);

  if(!isnormalloadouts()) {
    if(isbot(self)) {
      self.classcallback = "gamemode";
    }
  }

  if(isDefined(var1) && (var4.basename == "snowball_mp" || var4.basename == "pball_mp")) {
    var1 thread scripts\mp\utility\points::giveunifiedpoints("snowball_kill");
  }

  thread checkallowspectating();
}

function checkallowspectating() {
  waitframe();
  var0 = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var0 = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var0 = 1;
  }

  if(var0) {
    scripts\mp\spectating::updatespectatesettings();
    return;
  }
}

function ontimelimit() {
  if(level.gameended) {
    return;
  }

  physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 3);

  if(level.wincondition == 1) {
    checkliveswinner();
    return;
  }

  if(level.wincondition == 2) {
    checkhealthwinner();
    return;
  }

  checkhealthwinner();
}

function ontimelimitot() {
  physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 1);
  thread startotmechanics();
}

function checkliveswinner() {
  if(scripts\mp\utility\teams::getteamdata("allies", "aliveCount") > scripts\mp\utility\teams::getteamdata("axis", "aliveCount")) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("allies", game["end_reason"]["arena_time_lives_win"], game["end_reason"]["arena_time_lives_loss"]);
    return;
  }

  if(scripts\mp\utility\teams::getteamdata("axis", "aliveCount") > scripts\mp\utility\teams::getteamdata("allies", "aliveCount")) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("axis", game["end_reason"]["arena_time_lives_win"], game["end_reason"]["arena_time_lives_loss"]);
    return;
  }

  checkhealthwinner();
}

function checkhealthwinner() {
  if(level.axishealth < level.allieshealth) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("allies", game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
    return;
  }

  if(level.allieshealth < level.axishealth) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("axis", game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
    return;
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    if(dotournamentendgame()) {
      game["canScoreOnTie"] = 1;

      if(game["finalRound"] == 1) {
        game["canScoreOnTie"] = 0;

        if(!isDefined(game["roundsTied"])) {
          game["roundsTied"] = 1;
        } else {
          game["roundsTied"]++;
        }

        if(game["roundsTied"] >= 2) {
          var0 = scripts\mp\gamelogic::getbetterteam();
          thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["arena_tournament_tie_win"], game["end_reason"]["arena_tournament_tie_loss"]);
          return;
        }

        thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
        return;
      }

      thread arena_endgame("tie", game["end_reason"]["cyber_tie"]);
      return;
    }

    if(!isDefined(game["roundsTied"])) {
      game["roundsTied"] = 1;
    } else {
      game["roundsTied"]++;
    }

    game["canScoreOnTie"] = game["roundsTied"] >= 2;

    if(game["canScoreOnTie"]) {
      thread arena_endgame("tie", game["end_reason"]["cyber_tie"]);
      return;
    }

    thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
    return;
  }

  thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
}

function ondeadevent(var0) {
  if(var0 == game["attackers"]) {
    thread arena_endgame(level, game["defenders"]);
    return;
  }

  if(var0 == game["defenders"]) {
    thread arena_endgame(level, game["attackers"]);
    return;
  }
}

function ontimelimitdeadevent(var0) {}

function checkshouldallowtradekilltie(var0) {
  var1 = [];

  foreach(var3 in level.teamnamelist) {
    var1 = 0;
  }

  foreach(var6 in level.players) {
    if(!istrue(var6.hasspawned) || var6.team == "spectator" || var6.team == "follower") {
      continue;
    }

    var1 = var1[var6.team] + var6.pers["lives"];
  }

  var8 = 0;

  foreach(var3 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var3, "aliveCount")) {
      var8 = 1;
      break;
    }
  }

  var11 = 0;

  foreach(var13 in var1) {
    if(var13) {
      var11 = 1;
      break;
    }
  }

  if(!var8 && !var11) {
    return "tie";
  }

  foreach(var3 in level.teamnamelist) {
    if(!scripts\mp\utility\teams::getteamdata(var3, "aliveCount") && !var1[var3]) {
      if(level.multiteambased) {
        if(!scripts\mp\utility\teams::getteamdata(var3, "deathEvent") && scripts\mp\utility\teams::getteamdata(var3, "hasSpawned")) {
          scripts\mp\utility\teams::setteamdata(var3, "deathEvent", 1);
          return var0;
        }

        continue;
      }

      return var0;
    }
  }

  foreach(var3 in level.teamnamelist) {
    var18 = scripts\mp\utility\teams::getteamdata(var3, "aliveCount") == 1;

    if(var18) {
      var19 = 0;
      var20 = undefined;
      var21 = scripts\mp\utility\teams::getteamdata(var3, "players");

      foreach(var6 in var21) {
        if(!isalive(var6)) {
          var19 += var6.pers["lives"];
        }
      }

      if(var19 == 0) {
        if(!scripts\mp\utility\teams::getteamdata(var3, "oneLeft") && gettime() > scripts\mp\utility\teams::getteamdata(var3, "oneLeftTime") + 5000) {
          scripts\mp\utility\teams::setteamdata(var3, "oneLeftTime", gettime());
          scripts\mp\utility\teams::setteamdata(var3, "oneLeft", 1);

          if(var21.size > 1) {
            return var0;
          }
        }
      }

      continue;
    }

    scripts\mp\utility\teams::setteamdata(var3, "oneLeft", 0);
  }

  return var0;
}

function arena_endgame(var0, var1, var2, var3, var4) {
  if(var0 != "tie") {
    if(istrue(level.nukeincoming)) {
      return;
    }

    waittillframeend();
    var0 = checkshouldallowtradekilltie(var0);
  }

  if(isgungameloadouts() || isrvsgungameloadouts()) {
    setenemyloadoutomnvarsatmatchend(level, var0);
  }

  if(var0 != "tie") {
    game["roundsTied"] = 0;
    game["previousWinningTeam"] = var0;

    foreach(var6 in level.teamnamelist) {
      if(var6 == var0) {
        game["roundWinStreak"][var0]++;
        continue;
      }

      game["roundWinStreak"][var6] = 0;
    }

    if(!scripts\mp\utility\game::iswinbytworulegametype()) {
      switch (game["roundWinStreak"][var0]) {
        case 2:
          game["dialog"]["round_success"] = "round_win_streak_2";
          break;
        case 3:
          game["dialog"]["round_success"] = "round_win_streak_3";
          break;
        case 4:
          game["dialog"]["round_success"] = "round_win_streak_4";
          break;
        case 5:
          var8 = scripts\mp\utility\game::getroundswon(var0);
          var9 = scripts\mp\utility\dvars::getwatcheddvar("winlimit");

          if(var9 == 6 && var8 != var9 - 1) {
            game["dialog"]["round_success"] = "round_win_streak_5";
          }

          break;
        default:
          break;
      }
    }

    if(game["finalRound"] == 1) {
      if(game["roundWinStreak"][var0] > 3) {
        game["dialog"]["mission_success"] = "gamestate_win_comeback";
      }
    }
  } else {
    game["previousWinningTeam"] = "";
  }

  scripts\cp_mp\pet_watch::ref_13fbd();
  thread scripts\mp\gamelogic::endgame(var0, var1, var2, var3, var4);
}

function setroundwinstreakarray() {
  foreach(var1 in level.teamnamelist) {
    game["roundWinStreak"][var1] = 0;
  }
}

function ref_12043(var0) {
  if(istrue(game["pingEnabled"])) {
    var1 = 1;

    foreach(var3 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamcount(var3) > 4) {
        var1 = 0;
        break;
      }
    }

    setDvar("OLMLQMOSRL", var1);
    return;
  }
}

function runarenaloadoutrulesonplayer() {
  if(israndomloadouts() || israndompreviewloadouts() || usb_right() || usb_tape_animation_test()) {
    if(israndompreviewloadouts()) {
      if(self.pers["gamemodeLoadout"]["loadoutSecondary"] == "none") {
        scripts\cp_mp\utility\inventory_utility::_takeweapon("iw8_fists_mp");
        return;
      }

      return;
    }

    return;
  }

  if(ispickuploadouts()) {
    if(game["roundsPlayed"] == 0) {
      wait 0.1;
    } else {
      wait 0.25;
    }

    if(level.takefists) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon("iw8_fists_mp");
      return;
    }

    return;
  }
}

function updatehighpriorityweapons() {
  self loadweaponsforplayer(level.loadweapons, 1);
}

function buildloadoutsforweaponstreaming() {
  level.loadweapons = [];
  level.takefists = 0;

  if(ispickuploadouts()) {
    if(level.startweapon.weapon == "none") {
      var0 = "iw8_fists_mp";
      var1 = getcompleteweaponname(var0);
      var0 = createheadicon(var1);
    } else {
      jumpiffalse(issubstr(level.startweapon.weapon, "equip")) LOC_0000006e;
      var0 = "iw8_fists_mp";
      var1 = getcompleteweaponname(var0);
      var0 = createheadicon(var1);
      goto LOC_000001d8;
    }

    LOC_000001d8:
      level.loadweapons[level.loadweapons.size] = var1;
    return;
  }

  var10 = [];
  var11 = [];
  var12 = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
  var13 = var12["loadoutPrimary"];
  var14 = var12["loadoutSecondary"];

  if(var13 != "none") {
    var10 = buildprimaries(var13, var12, 1);
  }

  if(var14 != "none") {
    var11 = buildsecondaries(var14, var12, 1);
  }

  if(level.loadoutchangeround != 0) {
    var15 = game["arenaRandomLoadoutIndex"] + 1;

    if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size - 1) {
      var15 = 0;
    }

    var16 = game["arenaRandomLoadout"][var15];
    var17 = var16["loadoutPrimary"];
    var18 = var16["loadoutSecondary"];

    if(var17 != "none") {
      var10 = buildprimaries(var17, var16);
    }

    if(var18 != "none") {
      var11 = buildsecondaries(var18, var16);
    }
  }

  level.loadweapons = scripts\engine\utility::array_combine(var10, var11);
}

function buildprimaries(var0, var1, var2) {
  var3 = [];

  for(var4 = 1; var4 < 6; var4++) {
    var5 = var4;

    if(var4 == 1) {
      var5 = "";
    }

    var6 = var1["loadoutPrimaryAttachment" + var5];

    if(var6 != "none") {
      var3 = var6;
    }
  }

  var7 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var8 = "none";
  var9 = "none";
  var10 = undefined;
  var11 = undefined;
  var12 = undefined;
  var13 = undefined;

  if(istrue(level.ref_136cb) && istrue(var2)) {
    var8 = rotate_silo_gyro_lights();
    game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimaryCamo"] = var8;

    if(ref_140dc(var0)) {
      var12 = rotateeffect();
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimaryCosmeticAttachment"] = var12;
    }

    if(ref_140dd(var0)) {
      var13 = rotateplayer();
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimarySticker"] = var13[0];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimarySticker1"] = var13[1];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimarySticker2"] = var13[2];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimarySticker3"] = var13[3];
    }
  } else if(istrue(level.setplayerselfrevivingextrainfo)) {
    var8 = rotate_silo_gyro_lights();
    game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimaryCamo"] = var8;

    if(ref_140dc(var0)) {
      var12 = rotateeffect();
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimaryCosmeticAttachment"] = var12;
    }

    if(ref_140dd(var0)) {
      var13 = rotateplayer();
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimarySticker"] = var13[0];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimarySticker1"] = var13[1];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimarySticker2"] = var13[2];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimarySticker3"] = var13[3];
    }
  }

  var14 = scripts\mp\class::buildweapon(var7, var3, var8, var9, var10, var11, var12, var13);
  var15 = createheadicon(var14);
  return var15;
}

function buildsecondaries(var0, var1, var2) {
  var3 = [];

  for(var4 = 1; var4 < 6; var4++) {
    var5 = var4;

    if(var4 == 1) {
      var5 = "";
    }

    var6 = var1["loadoutSecondaryAttachment" + var5];

    if(var6 != "none") {
      var3 = var6;
    }
  }

  var7 = "none";
  var8 = "none";
  var9 = undefined;
  var10 = undefined;
  var11 = undefined;
  var12 = undefined;

  if(istrue(level.ref_136cb) && istrue(var2)) {
    var7 = rotate_silo_gyro_lights();
    game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondaryCamo"] = var7;

    if(ref_140dc(var0)) {
      var11 = rotateeffect();
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondaryCosmeticAttachment"] = var11;
    }

    if(ref_140dd(var0)) {
      var12 = rotateplayer();
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondarySticker"] = var12[0];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondarySticker1"] = var12[1];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondarySticker2"] = var12[2];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondarySticker3"] = var12[3];
    }
  } else if(istrue(level.setplayerselfrevivingextrainfo) && istrue(var2)) {
    var7 = rotate_silo_gyro_lights();
    game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondaryCamo"] = var7;

    if(ref_140dc(var0)) {
      var11 = rotateeffect();
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondaryCosmeticAttachment"] = var11;
    }

    if(ref_140dd(var0)) {
      var12 = rotateplayer();
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondarySticker"] = var12[0];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondarySticker1"] = var12[1];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondarySticker2"] = var12[2];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondarySticker3"] = var12[3];
    }
  }

  var13 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var14 = scripts\mp\class::buildweapon(var13, var3, var7, var8);
  var15 = createheadicon(var14);
  return var15;
}

function rotate_silo_gyro_lights() {
  var0 = "none";

  if(istrue(level.calloutmarkerpingvo_getcalloutaliasstringworld)) {
    var1 = ["camo_06g", "camo_07i", "camo_08j", "camo_10i", "camo_10j", "camo_07i"];
    var0 = scripts\engine\utility::random(var1);
  } else if(istrue(level.calloutmarkerpingvo_getcalloutaliasstringloot)) {
    var1 = ["camo_03j", "camo_05b", "camo_05b", "camo_09i"];
    var0 = scripts\engine\utility::random(var1);
  } else if(istrue(level.setplayerselfrevivingextrainfo)) {
    var1 = ["camo_05h", "camo_08b", "camo_08g", "camo_09j", "camo_10c", "camo_10g", "camo_10h", "camo_10i", "camo_10j"];
    var0 = scripts\engine\utility::random(var1);
  }

  return var0;
}

function ref_140dc(var0) {
  var1 = scripts\mp\utility\weapon::getweaponrootname(var0);
  return var1 != "iw8_me_riotshield" && var1 != "iw8_knife" && var1 != "iw8_fists" && var1 != "iw8_fists_mp" && var1 != "iw8_me_akimboblades" && var1 != "iw8_me_akimboblunt" && var1 != "iw8_gunless" && var1 != "iw8_la_gromeo" && var1 != "iw8_la_t9standard_mp" && var1 != "iw8_la_mike32" && var1 != "iw8_la_t9launcher_mp" && var1 != "iw8_la_juliet" && var1 != "iw8_la_kgolf";
}

function ref_140dd(var0) {
  return var0 != "iw8_knife_mp" && var0 != "iw8_me_akimboblades_mp" && var0 != "iw8_me_akimboblunt_mp";
}

function rotateeffect() {
  var0 = "none";

  if(istrue(level.calloutmarkerpingvo_getcalloutaliasstringworld)) {
    var1 = ["cos_032", "cos_285", "cos_053", "cos_299"];
    var0 = scripts\engine\utility::random(var1);
  } else if(istrue(level.calloutmarkerpingvo_getcalloutaliasstringloot)) {
    var1 = ["cos_291", "cos_292", "cos_293", "cos_146"];
    var0 = scripts\engine\utility::random(var1);
  } else if(istrue(level.setplayerselfrevivingextrainfo)) {
    var1 = ["cos_381", "cos_379", "cos_393", "cos_380", "cos_365", "cos_357", "cos_355", "cos_232", "cos_026", "cos_030", "cos_223"];
    var0 = scripts\engine\utility::random(var1);
  }

  return var0;
}

function rotateplayer() {
  var0 = [];

  if(istrue(level.calloutmarkerpingvo_getcalloutaliasstringworld)) {
    var1 = ["i/sticker_211", "i/sticker_212", "i/sticker_101", "i/sticker_134"];
    var0 = scripts\engine\utility::random(var1);
    var0 = scripts\engine\utility::random(var1);
    var0 = scripts\engine\utility::random(var1);
    var0 = scripts\engine\utility::random(var1);
  } else if(istrue(level.calloutmarkerpingvo_getcalloutaliasstringloot)) {
    var1 = ["i/sticker_246", "i/sticker_199", "i/sticker_202"];
    var0 = scripts\engine\utility::random(var1);
    var0 = scripts\engine\utility::random(var1);
    var0 = scripts\engine\utility::random(var1);
    var0 = scripts\engine\utility::random(var1);
  } else if(istrue(level.setplayerselfrevivingextrainfo)) {
    var1 = ["i/sticker_372", "i/sticker_253", "i/sticker_373", "i/sticker_182", "i/sticker_233", "i/sticker_273", "i/sticker_245", "i/sticker_239", "i/sticker_248", "i/sticker_200", "i/sticker_118", "i/sticker_029"];
    var0 = scripts\engine\utility::random(var1);
    var0 = scripts\engine\utility::random(var1);
    var0 = scripts\engine\utility::random(var1);
    var0 = scripts\engine\utility::random(var1);
  }

  return var0;
}

function ref_13272() {
  level.arenaweapont1 = fix_collisiontwo(level.arenaweapont1);
  level.arenaweapont2 = fix_collisiontwo(level.arenaweapont2);
  level.arenaweapont3 = fix_collisiontwo(level.arenaweapont3);
  level.arenaweapont4 = fix_collisiontwo(level.arenaweapont4);
  level.arenaweapont5 = fix_collisiontwo(level.arenaweapont5);
  level.arenaweapont6 = fix_collisiontwo(level.arenaweapont6);
  level.arenaweapont7 = fix_collisiontwo(level.arenaweapont7);
  level.arenaweapont8 = fix_collisiontwo(level.arenaweapont8);
}

function fix_collisiontwo(var0) {
  var0.weapon = var0.weapon;

  if(!issubstr(var0.weapon, "equip") && var0.weapon != "none") {
    var1 = [];
    var2 = "none";
    var3 = "none";
    var4 = undefined;
    var5 = undefined;
    var6 = undefined;
    var7 = [];
    GscBinSkip0(0x2e, 0, "none");
  }

  return var7;
}

function ref_13227() {
  level.arenaweapont1 = fireoffsplashforplayer(level.arenaweapont1);
  level.arenaweapont2 = fireoffsplashforplayer(level.arenaweapont2);
  level.arenaweapont3 = fireoffsplashforplayer(level.arenaweapont3);
  level.arenaweapont4 = fireoffsplashforplayer(level.arenaweapont4);
  level.arenaweapont5 = fireoffsplashforplayer(level.arenaweapont5);
  level.arenaweapont6 = fireoffsplashforplayer(level.arenaweapont6);
  level.arenaweapont7 = fireoffsplashforplayer(level.arenaweapont7);
  level.arenaweapont8 = fireoffsplashforplayer(level.arenaweapont8);
}

function fireoffsplashforplayer(var0) {
  var0.weapon = var0.weapon;

  if(!issubstr(var0.weapon, "equip") && var0.weapon != "none") {
    var1 = [];
    var2 = "none";
    var3 = "none";
    var4 = var0.variantid;
    var5 = undefined;
    var6 = undefined;
    var7 = [];
    GscBinSkip0(0x2e, 0, "none");
  }

  return var7;
}

function ref_13274() {
  level.startweapon = ref_13280(level.startweapon);
  level.arenaweapont1 = ref_13280(level.arenaweapont1);
  level.arenaweapont2 = ref_13280(level.arenaweapont2);
  level.arenaweapont3 = ref_13280(level.arenaweapont3);
  level.arenaweapont4 = ref_13280(level.arenaweapont4);
  level.arenaweapont5 = ref_13280(level.arenaweapont5);
  level.arenaweapont6 = ref_13280(level.arenaweapont6);
  level.arenaweapont7 = ref_13280(level.arenaweapont7);
  level.arenaweapont8 = ref_13280(level.arenaweapont8);
}

function ref_13280(var0) {
  var0.weapon = var0.weapon;

  if(!issubstr(var0.weapon, "equip") && var0.weapon != "none") {
    var1 = [];
    var2 = "none";
    var3 = "none";
    var4 = undefined;
    var5 = scripts\mp\utility\weapon::getweaponrootname(var0.weapon);
    var1 = registerdonetskmap(var5 + "_mp");
    var0.weaponobj = scripts\mp\class::buildweapon(var5, var1, var2, var3, var4);
  }

  return var0;
}

function registerlocation(var0) {
  var1 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var2 = registerdonetskmap(var1 + "_mp");
  return var2;
}

function defineplayerloadout(var0) {
  var1 = [];
  GscBinSkip0(0x2e, 0, "none");
}

function ref_131bd() {
  var0 = ["camo_01a", "camo_01b", "camo_01c", "camo_01d", "camo_01d", "camo_01e", "camo_01f", "camo_01g", "camo_01h", "camo_01i", "camo_01j", "camo_02a", "camo_02b", "camo_02c", "camo_02d", "camo_02d", "camo_02e", "camo_02f", "camo_02g", "camo_02h", "camo_02i", "camo_02j", "camo_03a", "camo_03b", "camo_03c", "camo_03d", "camo_03d", "camo_03e", "camo_03f", "camo_03g", "camo_03h", "camo_03i", "camo_03j", "camo_04a", "camo_04b", "camo_04c", "camo_04d", "camo_04d", "camo_04e", "camo_04f", "camo_04g", "camo_04h", "camo_04i", "camo_04j", "camo_05a", "camo_05b", "camo_05c", "camo_05d", "camo_05d", "camo_05e", "camo_05f", "camo_05g", "camo_05h", "camo_05i", "camo_05j", "camo_06a", "camo_06b", "camo_06c", "camo_06d", "camo_06d", "camo_06e", "camo_06f", "camo_06g", "camo_06h", "camo_06i", "camo_06j", "camo_07a", "camo_07b", "camo_07c", "camo_07d", "camo_07d", "camo_07e", "camo_07f", "camo_07g", "camo_07h", "camo_07i", "camo_07j", "camo_08a", "camo_08b", "camo_08c", "camo_08d", "camo_08d", "camo_08e", "camo_08f", "camo_08g", "camo_08h", "camo_08i", "camo_08j", "camo_09a", "camo_09b", "camo_09c", "camo_09d", "camo_09d", "camo_09e", "camo_09f", "camo_09g", "camo_09h", "camo_09i", "camo_09j", "camo_10a", "camo_10b", "camo_10c", "camo_10d", "camo_10d", "camo_10e", "camo_10f", "camo_10g", "camo_10h", "camo_10i", "camo_10j"];
  var1 = "none";

  foreach(var3 in level.teamnamelist) {
    if(game["roundWinStreak"][var3] == 0) {
      continue;
    }

    if(game["roundWinStreak"][var3] > 5) {
      var1 = "camo_11d";
      continue;
    }

    switch (game["roundWinStreak"][var3]) {
      case 0:
        break;
      case 1:
        var1 = scripts\engine\utility::random(var0);
        break;
      case 2:
        var1 = "camo_11a";
        break;
      case 3:
        var1 = "camo_11b";
        break;
      case 4:
        var1 = "camo_11c";
        break;
      case 5:
        var1 = "camo_11d";
        break;
    }
  }

  return var1;
}

function updaterandomloadout() {
  if(israndomloadouts() || usbs_pulled_out() || usb_right() || usb_tape_animation_test()) {
    if(game["roundsPlayed"] == 0) {
      if(istrue(game["practiceRound"])) {
        cacherandomloadouts();
        game["arenaRandomLoadoutIndex"] = 0;
        return;
      }

      if(!isDefined(game["practiceRound"]) || istrue(game["didSnowFight"])) {
        if(istrue(game["didSnowFight"])) {
          game["didSnowFight"] = undefined;
        }

        cacherandomloadouts();
        game["arenaRandomLoadoutIndex"] = 0;
        return;
      }

      return;
    }

    if(level.loadoutchangeround != 0) {
      if(game["roundsPlayed"] % level.loadoutchangeround == 0) {
        game["arenaRandomLoadoutIndex"]++;
      }

      if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size) {
        game["arenaRandomLoadoutIndex"] = 0;
        return;
      }

      return;
    }

    game["arenaRandomLoadoutIndex"] = 0;
    return;
  }
}

function cacherandomloadouts() {
  game["arenaRandomLoadout"] = [];
  var0 = [];
  var1 = 0;
  var2 = scripts\engine\utility::ter_op(usb_right(), "mp/classtable_arena_blueprints.csv", "mp/classTable_arena.csv");

  if(scripts\mp\utility\game::getgametype() == "infect") {
    var2 = "mp/classtable_infect.csv";
  }

  if(israndompreviewloadouts()) {
    var1 = 144;
  } else if(usb_left()) {
    var1 = 0;
  } else if(usbwm()) {
    var1 = 57;
  } else if(usbserver()) {
    var1 = 93;
  } else if(usbvm()) {
    var1 = 123;
  } else if(use_airdrop_fx()) {
    var1 = 146;
  } else if(usbmodel()) {
    var1 = 188;
  }

  while(scripts\mp\class::table_getloadoutname(var2, var1) != "") {
    var0 = updateloadoutarray(var2, var1);
    var1++;

    if(israndompreviewloadouts()) {
      if(var1 == 0) {
        break;
      }

      continue;
    }

    if(usb_left()) {
      if(var1 == 57) {
        break;
      }

      continue;
    }

    if(usbwm()) {
      if(var1 == 93) {
        break;
      }

      continue;
    }

    if(usbserver()) {
      if(var1 == 123) {
        break;
      }

      continue;
    }

    if(usbvm()) {
      if(var1 == 146) {
        break;
      }

      continue;
    }

    if(use_airdrop_fx()) {
      if(var1 == 188) {
        break;
      }
    }
  }

  var3 = undefined;
  var4 = undefined;
  var5 = getDvar("scr_arena_overrideWeapons", "");
  var6 = getdvarfloat("scr_arena_overrideWeaponChance", 0);

  if(var5 != "" && var6 > 0) {
    var7 = strtok(var5, ",");

    foreach(var9 in var7) {
      var10 = strtok(var9, "|");

      if(var10.size == 2) {
        var11 = var10[0];
        var12 = int(var10[1]);
        var13 = scripts\mp\utility\weapon::ref_1458c(var11, var12);

        if(var13) {
          if(!isDefined(var3)) {
            var3 = [];
            var4 = var6;
          }

          var14 = spawnStruct();
          var14.ref_12d96 = var11;
          var14.variantid = var12;
          var3 = var14;
        }
      }
    }
  }

  var0 = arenaloadouts_select(var0, 99, var3, var4);
  game["arenaRandomLoadout"] = scripts\engine\utility::array_randomize(var0);
}

function updateloadoutarray(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, "loadoutPrimaryAddBlueprintAttachments", scripts\mp\class::ref_139e4(var0, var1, 0));
}

function arenaloadouts_select(var0, var1, var2, var3) {
  var4 = [];
  var5 = [];

  for(var6 = 0; var6 < var1 && var0.size > 0; var6++) {
    var7 = var0[randomint(var0.size)];
    var8 = var7["loadoutPrimary"];

    if(isDefined(var2) && isDefined(var3)) {
      var9 = arenaloadouts_getweapongroup(var8);
      var10 = calloutmarkerpingvo_getaffirmaliasstringloot(var2, var9);

      if(var10.size > 0) {
        if(randomfloat(1) < var3) {
          var11 = randomint(var10.size);
          var12 = var10[var11];
          var2 = scripts\engine\utility::array_remove_index(var2, var11);
          var7 = 1;
          var7 = var12.ref_12d96;
          var7 = var12.variantid;
          var7 = "none";
          var7 = "none";

          for(var13 = 0; var13 < scripts\mp\class::getmaxprimaryattachments(); var13++) {
            var14 = scripts\mp\class::getattachmentloadoutstring(var13, "primary");
            var7 = "none";
          }
        }
      }
    }

    var5 = var7;
    var0 = arenaloadouts_removeclass(var0, var8);
  }

  return var5;
}

function calloutmarkerpingvo_getaffirmaliasstringloot(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    if(arenaloadouts_getweapongroup(var4.ref_12d96) == var1) {
      var2 = var4;
    }
  }

  return var2;
}

function arenaloadouts_removeclass(var0, var1) {
  var2 = [];
  var3 = arenaloadouts_getweapongroup(var1);

  foreach(var5 in var0) {
    var6 = arenaloadouts_getweapongroup(var5["loadoutPrimary"]);

    if(var3 != var6) {
      var2 = var5;
    }
  }

  return var2;
}

function arenaloadouts_getweapongroup(var0) {
  var1 = "none";

  if(var0 != "none") {
    var1 = scripts\mp\utility\weapon::getweapongroup(var0);

    if(var1 == "weapon_dmr") {
      var1 = "weapon_sniper";
    }
  }

  return var1;
}

function buildrandomweapontable() {
  level.weaponcategories = [];
  level.allweapons = [];

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/arenaGGWeapons.csv", var0, 4);

    if(var1 == "snow") {
      var0++;
      continue;
    }

    if(var1 == "") {
      break;
    }

    var2 = strtok(var1, "+");

    foreach(var4 in var2) {
      if(!isDefined(level.weaponcategories[var4])) {
        level.weaponcategories[var4] = [];
      }

      var5 = [];
      var5 = tablelookupbyrow("mp/arenaGGWeapons.csv", var0, 0);
      level.weaponcategories[var4][level.weaponcategories[var4].size] = var5;
      level.allweapons[var5["weapon"]] = var5["weapon"];
    }
  }
}

function getrandomweaponfromcategory(var0, var1) {
  if(istrue(var1) && var0 == "rand_sniperdmr") {
    if(!isDefined(game["arenaStartWeaponClass"])) {
      var0 = scripts\engine\utility::ter_op(randomint(100) > 49, "rand_sniper", "rand_dmr");
      game["arenaStartWeaponClass"] = var0;
    } else {
      if(game["arenaStartWeaponClass"] == "rand_sniper") {
        var0 = "rand_dmr";
      } else {
        var0 = "rand_sniper";
      }

      game["arenaStartWeaponClass"] = var0;
    }
  }

  var2 = level.weaponcategories[var0];

  if(isDefined(var2) && var2.size > 0) {
    var3 = "";
    var4 = undefined;

    for(var5 = 0;; var5++) {
      var6 = randomintrange(0, var2.size);
      var4 = var2[var6];
      var7 = scripts\mp\utility\weapon::getweaponrootname(var4["weapon"]);

      if(var5 > var2.size) {
        level.selectedweapons[var7] = 1;
        var3 = var4["weapon"];

        for(var8 = 0; var8 < level.weaponcategories[var0].size; var8++) {
          if(level.weaponcategories[var0][var8]["weapon"] == var3) {
            break;
          }
        }

        break;
      }
    }

    return var3;
  }

  return "none";
}

function initweaponmap() {
  level.baseraritymap = [];
  level.baseraritymap[level.arenaweapont1.weapon] = 0;
  level.baseraritymap[level.arenaweapont2.weapon] = 1;
  level.baseraritymap[level.arenaweapont3.weapon] = 2;
  level.baseraritymap[level.arenaweapont4.weapon] = 3;
  level.baseraritymap[level.arenaweapont5.weapon] = 4;
  level.baseraritymap[level.arenaweapont6.weapon] = 5;
  level.baseraritymap[level.arenaweapont7.weapon] = 6;
  level.baseraritymap[level.arenaweapont8.weapon] = 0;
}

function regroup_at_truck(var0) {
  if(updatec4vehiclemultkill() && !issubstr(var0, "equip") && var0 != "none") {
    var1 = "mp/classtable_arena_blueprints.csv";
    var2 = 0;
    var3 = "";
    var4 = scripts\mp\utility\weapon::getweaponrootname(var0);

    while(scripts\mp\class::table_getloadoutname(var1, var2) != "") {
      var3 = scripts\mp\class::table_getweapon(var1, var2, 0);

      if(var4 == var3) {
        break;
      }

      var2++;
    }

    if(var4 != "") {
      var5 = scripts\mp\class::ref_139e6("mp/classtable_arena_blueprints.csv", var2, 0, var4);
      return var5;
    }

    return 0;
  }

  return 0;
}

function setupweapons() {
  var0 = scripts\engine\utility::getStructArray("weapon_pickup", "targetname");

  if(istrue(level.ref_136cb) || istrue(level.setplayerselfrevivingextrainfo)) {
    ref_13272();
  } else if(updatec4vehiclemultkill()) {
    ref_13227();
  } else {
    ref_13274();
  }

  foreach(var2 in var0) {
    if(var2.script_label == "1") {
      spawnweapon(var2, level.arenaweapont1);
      continue;
    }

    if(var2.script_label == "2") {
      spawnweapon(var2, level.arenaweapont2);
      continue;
    }

    if(var2.script_label == "3") {
      spawnweapon(var2, level.arenaweapont3);
      continue;
    }

    if(var2.script_label == "4") {
      spawnweapon(var2, level.arenaweapont4);
      continue;
    }

    if(var2.script_label == "5") {
      spawnweapon(var2, level.arenaweapont5);
      continue;
    }

    if(var2.script_label == "6") {
      spawnweapon(var2, level.arenaweapont6);
      continue;
    }

    if(var2.script_label == "7") {
      spawnweapon(var2, level.arenaweapont7);
      continue;
    }

    if(var2.script_label == "8") {
      spawnweapon(var2, level.arenaweapont8);
    }
  }
}

function getrandomspawnweapon() {
  var0 = level.allweapons;

  if(isDefined(var0) && var0.size > 0) {
    var1 = "";
    var2 = undefined;

    for(var3 = 0;; var3++) {
      var4 = scripts\engine\utility::random(var0);

      if(!issubstr(var4, "equip")) {
        var5 = scripts\mp\utility\weapon::getweaponrootname(var4);
      } else {
        var5 = var4;
      }

      if(var3 > var0.size) {
        level.selectedweapons[var5] = 1;
        var1 = var4;

        for(var6 = 0; var6 < level.allweapons.size; var6++) {
          if(level.allweapons[var4] == var1) {
            break;
          }
        }

        break;
      }
    }

    return var1;
  }

  return "none";
}

function registerdonetskmap(var0) {
  var1 = [];

  if(level.calloutmarkerpingvo_getcalloutaliasstringentity == 1) {
    if(weaponclass(var0) == "sniper" || weaponclass(var0) == "dmr") {
      GscBinSkip0(0x2e, var1.size, "scope");
    }
  }

  if(weaponclass(var0) == "sniper") {
    switch (var0) {
      case "iw8_sn_alpha50_mp":
        GscBinSkip0(0x2e, var1.size, "stocks");

      case "iw8_sn_delta_mp":
        GscBinSkip0(0x2e, var1.size, "stockcust");

      case "iw8_sn_hdromeo_mp":
        GscBinSkip0(0x2e, var1.size, "stockh");

      case "iw8_sn_xmike109_mp":
        GscBinSkip0(0x2e, var1.size, "stocks");

      case "iw8_sn_romeo700_mp":
        GscBinSkip0(0x2e, var1.size, "scope");

      default:
        break;
    }
  }

  if(var1.size == 0) {
    GscBinSkip0(0x2e, var1.size, "none");
  }

  return var1;
}

function spawnweapon(var0, var1, var2) {
  if(isDefined(var2)) {
    var3 = var1;
  } else {
    var3 = var2.weapon;
  }

  if(var3 == "none") {
    return;
  }

  var4 = player_give_infinite_rocks(var1);

  if(isDefined(var1.script_noteworthy) && var1.script_noteworthy == "wall") {} else {
    var5 = var1.origin + (0, 0, 16);
    var6 = var1.origin + (0, 0, -16);
    var7 = scripts\engine\trace::ray_trace(var5, var6, undefined, scripts\engine\trace::create_default_contents(1));

    if(var7["fraction"] < 1) {
      var4 = var7["position"] + (0, 0, 2);
    }
  }

  var8 = "";
  var9 = getequipmentmodel(var3);

  if(var9 != "") {
    if(istrue(level.ref_1343f) && var3 == "equip_snowball") {
      if(isPlayer(var1)) {
        var8 = "single";
      } else if(isDefined(var1.script_noteworthy) && var1.script_noteworthy == "wall") {
        var8 = "single";
      } else if(scripts\engine\utility::cointoss()) {
        if(scripts\engine\utility::cointoss()) {
          var8 = "pile";
        } else {
          var8 = "single";
        }
      } else {
        var8 = "pyramid";
      }

      if(!isPlayer(var1) && var1.script_label == "6" && !level.ref_12344) {
        if(distance(var1.origin, (0, 0, 138)) < 10) {
          level.ref_12344 = 1;
          var3 = "equip_pball";
          var8 = "single";
        }
      } else if(!isPlayer(var1) && var1.script_label == "8" && !level.ref_12344) {
        if(distance(var1.origin, (0, 0, -50)) < 10) {
          if(scripts\engine\utility::cointoss()) {
            level.ref_12344 = 1;
            var3 = "equip_pball";
            var8 = "single";
          }
        }
      }

      switch (var8) {
        case "pile":
          var9 = "decor_snowball_pile_01";
          var4 -= (0, 0, 3);
          break;
        case "pyramid":
          var9 = "decor_snowball_pyramid_01";
          var4 -= (0, 0, 3);
          break;
        default:
          var9 = "weapon_wm_snowball";
          break;
      }

      var10 = spawn("script_model", var4);
      var10 setModel(var9);
    } else {
      var10 = spawn("script_model", var8);
      var10 setModel(var10);
    }

    if(isDefined(var2.angles)) {
      if(var4 == "equip_claymore" || var4 == "equip_at_mine" || var4 == "equip_trophy") {
        if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "wall" || isDefined(var2.ref_12f52) && var2.ref_12f52 == "wall") {
          var10.angles = (270, var2.angles[1], 90);
        } else {
          var10.angles = (0, var2.angles[1], 0);
        }
      } else if(var4 == "equip_c4" || var4 == "equip_thermite" || var4 == "equip_throwing_knife") {
        if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "wall" || isDefined(var2.ref_12f52) && var2.ref_12f52 == "wall") {
          var10.angles = (180, var2.angles[1], 180);
        } else {
          var10.angles = (0, var2.angles[1], 90);
        }
      } else {
        var10.angles = (0, 90, 0);
        var10.origin += (0, 0, 2);
      }
    } else {
      var10.angles = (0, 0, 90);
    }

    var11 = 96;
    var12 = 96;
    var13 = getequipmenthintstring(var10, var4);
    var14 = getequipmenthinticon(var10, var4);
    var10.equipment = var4;
    var10 makeusable();
    var10 sethinttag("tag_origin");
    var10 setCursorHint("HINT_BUTTON");
    var10 sethinticon(var14);
    var10 setuseholdduration("duration_short");
    var10 setusehideprogressbar(1);
    var10 setHintString(var13);
    var10 setusepriority(0);
    var10 sethintdisplayrange(var12);
    var10 sethintdisplayfov(120);
    var10 setuserange(var11);
    var10 setusefov(210);
    var10 sethintonobstruction("hide");
    thread outlineequipmentwatchplayerprox(var10, var10);
    var10.ref_1292d = spawn("trigger_radius", var10.origin, 0, 32, 32);
    thread vehicle_collision_registereventinternal();

    if(istrue(level.ref_1343f)) {
      thread ref_144f3(var10, var2);
      var10.targetname = "dropped_weapon";
      return;
    }

    thread watchequipmentpickup();
    var10.targetname = "dropped_equipment";
    return;
  }

  var15 = undefined;
  var15 = scripts\mp\utility\weapon::getweaponrootname(var4);
  var16 = [];

  if(istrue(level.ref_136cb) || istrue(level.setplayerselfrevivingextrainfo) || updatec4vehiclemultkill()) {
    var17 = var3.weaponobj;
  } else {
    var17 = registerdonetskmap(var16 + "_mp");
    var17 = scripts\mp\class::buildweapon(var16, var17, "none", "none", -1);
  }

  var18 = createheadicon(var17);
  var19 = spawn("weapon_" + var18, var9, 17);
  var19 sethintdisplayrange(96);
  var19 setuserange(96);
  var19 setuseholdduration("duration_short");
  var19 setusefov(210);
  var19.targetname = "dropped_weapon";
  var19.objweapon = var17;

  if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "wall") {
    var20 = anglestoright(var3.angles);
    var21 = vectorNormalize(var20) * 30;
    var5 = var3.origin + var21 + (0, 0, 16);
    var6 = var3.origin + var21 + (0, 0, -100);
    var7 = scripts\engine\trace::ray_trace(var5, var6, undefined, scripts\engine\trace::create_default_contents(1));
    var22 = var3.origin;

    if(var7["fraction"] < 1) {
      var22 = var7["position"];
    }

    var19.deafen_ai_near_pa_for_duration = var22;
  }

  manageweaponstartingammo(var19, var18);

  if(isDefined(var3.angles)) {
    if(var16 == "iw8_me_riotshield") {
      if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "wall" || isDefined(var3.ref_12f52) && var3.ref_12f52 == "wall") {
        var19.angles = (var3.angles[0], var3.angles[1] - 90, var3.angles[2]);
      } else {
        var19.angles = (var3.angles[0] - 90, var3.angles[1], var3.angles[2]);
      }
    } else if(var16 == "iw8_sn_crossbow") {
      if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "wall") {
        var19.angles = (var3.angles[0], var3.angles[1], var3.angles[2] + 90);
      } else {
        var19.angles = (var3.angles[0], var3.angles[1], var3.angles[2] + 90);
      }
    } else {
      var19.angles = var3.angles;
    }
  } else {
    var19.angles = (0, 0, 90);
  }

  thread outlinewatchplayerprox();
  thread watchpickup();
}

function player_give_infinite_rocks(var0) {
  if(level.mapname == "mp_m_speedball") {
    if(var0.script_label == "3" && distance(var0.origin, (-488.2, -399.9, 54.25)) < 10) {
      var0.origin = (-488.2, -409.9, 54.25);
    } else if(var0.script_label == "5" && distance(var0.origin, (657.3, 644.6, 56)) < 10) {
      var0.origin = (665.3, 644.6, 56);
    }
  } else if(level.mapname == "mp_m_stadium") {
    if(var0.script_label == "5" && distance(var0.origin, (400.748, 762, -291.005)) < 10) {
      var0.ref_12f52 = "wall";
    } else if(var0.script_label == "2" && distance(var0.origin, (38.354, -115, -298.312)) < 10) {
      var0.ref_12f52 = "wall";
    } else if(var0.script_label == "2" && distance(var0.origin, (-36.354, 83, -298.312)) < 10) {
      var0.ref_12f52 = "wall";
    }
  }

  return var0.origin;
}

function getequipmentmodel(var0) {
  switch (var0) {
    case "equip_frag":
      return "offhand_wm_grenade_mike67";
    case "equip_semtex":
      return "offhand_wm_grenade_semtex";
    case "equip_c4":
      return "offhand_wm_c4";
    case "equip_claymore":
      return "offhand_wm_claymore_held";
    case "equip_at_mine":
      return "offhand_wm_at_mine";
    case "equip_throwing_knife":
      return "weapon_wm_me_soscar_knife_offhand_thrown";
    case "equip_throwing_knife_fire":
      return "weapon_wm_me_soscar_knife_fire_offhand_thrown_mp";
    case "equip_throwing_knife_electric":
      return "weapon_wm_me_soscar_knife_offhand_thrown_v66";
    case "equip_throwing_knife_drill":
      return "weapon_wm_me_drill_knife_offhand_thrown";
    case "equip_molotov":
      return "offhand_wm_molotov";
    case "equip_thermite":
      return "offhand_wm_grenade_thermite";
    case "equip_flash":
      return "offhand_wm_grenade_flash";
    case "equip_snapshot_grenade":
      return "offhand_wm_grenade_snapshot_mp";
    case "equip_smoke":
      return "offhand_wm_grenade_smoke";
    case "equip_concussion":
      return "offhand_wm_grenade_concussion";
    case "equip_trophy":
      return "offhand_wm_trophy_system";
    case "equip_decoy":
      return "offhand_wm_grenade_decoy";
    case "equip_adrenaline":
      return "offhand_wm_stim";
    case "equip_snowball":
      return "weapon_wm_snowball";
    case "equip_pball":
      return "weapon_wm_snowball";
    default:
      return "";
  }
}

function getequipmenthintstring(var0) {
  switch (var0) {
    case "equip_frag":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_FRAG";
    case "equip_semtex":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_SEMTEX";
    case "equip_c4":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_C4";
    case "equip_claymore":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_CLAYMORE";
    case "equip_at_mine":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_ATMINE";
    case "equip_throwing_knife":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_TKNIFE";
    case "equip_throwing_knife_fire":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_TKNIFE_FIRE";
    case "equip_throwing_knife_electric":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_TKNIFE_ELECTRIC";
    case "equip_throwing_knife_drill":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_TKNIFE_DRILL";
    case "equip_molotov":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_MOLOTOV";
    case "equip_thermite":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_THERMITE";
    case "equip_snowball":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_SNOWBALL";
    case "equip_pball":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_PBALL";
    case "equip_flash":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_FLASH";
    case "equip_snapshot_grenade":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_SNAPSHOT";
    case "equip_smoke":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_SMOKE";
    case "equip_concussion":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_STUN";
    case "equip_trophy":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_TROPHY_SYSTEM";
    case "equip_decoy":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_DECOY";
    case "equip_adrenaline":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_STIM";
    default:
      return "";
  }
}

function getequipmenthinticon(var0) {
  var1 = "mp/arenaGGWeapons.csv";
  var2 = tablelookup(var1, 0, var0, 3);
  return var2;
}

function manageweaponstartingammo(var0, var1) {
  var2 = weaponclipsize(var1);
  var3 = 0;

  if(level.magcount != 3) {
    var4 = !level.magcount;

    if(var4) {
      var2 = 0;
      var3 = 0;
    } else {
      var3 = level.magcount - 1;
    }

    if(level.magcount == 7) {
      var3 = weaponmaxammo(var1);
    } else {
      var3 = var2 * var3;
    }
  } else {
    var3 = var2 * 2;
  }

  var0 itemweaponsetammo(var2, var3);
}

function watchequipmentpickup() {
  self endon("death");
  self waittill("trigger", var0, var1);
  var2 = 0;
  var3 = checkissameequip(var0);
  var4 = checkpickupequiptypeammocount(var0);
  var5 = var0 scripts\mp\equipment::getequipmentmaxammo(self.equipment);
  var6 = checkcurrentequiptypeammocount(var0);

  if(var3) {
    if(var4 == var5) {
      var2 = 1;
    }
  }

  if(var3 && !var2) {
    var0 scripts\mp\equipment::incrementequipmentammo(self.equipment, 1);
  } else if(var6 && !var3) {
    dropoldequipinplace(var0, var0 scripts\mp\equipment::getcurrentequipment(self.equiptype));
  }

  if(!var3) {
    var0 scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);
  }

  if(var3 && var2) {
    var0 iprintlnbold(&"MP_INGAME_ONLY/EQUIPMENT_MAXED");
    thread watchequipmentpickup();
    return;
  }

  var0 playlocalsound("scavenger_pack_pickup");
  clearweaponoutlines();
  self makeunusable();
  self delete();
}

function checkpickupequiptypeammocount(var0) {
  return var0 scripts\mp\equipment::getequipmentammo(self.equipment);
}

function checkcurrentequiptypeammocount(var0) {
  var1 = var0 scripts\mp\equipment::getcurrentequipment(self.equiptype);

  if(isDefined(var1)) {
    return var0 scripts\mp\equipment::getequipmentammo(var1);
  }

  return 0;
}

function checkissameequip(var0) {
  var1 = var0 scripts\mp\equipment::getcurrentequipment(self.equiptype);

  if(isDefined(var1)) {
    return (self.equipment == var1);
  }

  return 0;
}

function dropoldequipinplace(var0) {
  spawnweapon(self, var0, 1);
}

function watchpickup() {
  self endon("death");
  self waittill("trigger", var0, var1);
  clearweaponoutlines();

  if(isDefined(var1)) {
    var1 sethintdisplayrange(96);
    var1 setuserange(96);
    var1 setuseholdduration("duration_short");
    thread outlinewatchplayerprox();
    thread watchpickup();
    return;
  }
}

function vehicle_collision_registereventinternal() {
  level endon("game_ended");
  self endon("deleted");
  self endon("death");
  var0 = undefined;

  for(;;) {
    wait 0.05;
    self.ref_1292d waittill("trigger", var1);

    if(!scripts\mp\utility\player::isreallyalive(var1)) {
      continue;
    }

    if(istrue(var1.inlaststand)) {
      continue;
    }

    if(!isDefined(var1.initialized_gameobject_vars)) {
      continue;
    }

    if(!scripts\mp\gameobjects::proxtriggerlos(var1)) {
      continue;
    }

    var0 = var1 scripts\mp\equipment::getcurrentequipment(self.equiptype);
    var2 = 0;
    var3 = checkissameequip(var1);
    var4 = checkcurrentequiptypeammocount(var1);
    var0 = var1 scripts\mp\equipment::getcurrentequipment(self.equiptype);

    if(isDefined(var0) && !var3 && var4 > 0) {
      continue;
    }

    var5 = checkpickupequiptypeammocount(var1);
    var6 = var1 scripts\mp\equipment::getequipmentmaxammo(self.equipment);

    if(var3) {
      if(var5 == var6) {
        var2 = 1;
      }
    }

    if(var3 && !var2) {
      var1 scripts\mp\equipment::incrementequipmentammo(self.equipment, 1);
    }

    if(var3 && var2) {
      continue;
    }

    if(!isDefined(var0) || isDefined(var0) && !var3 && var4 == 0) {
      var1 scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);
    }

    var1 playlocalsound("scavenger_pack_pickup");
    clearweaponoutlines();
    self makeunusable();
    self delete();
  }
}

function updatearenagungameloadout(var0) {
  if(game["roundsPlayed"] == 0) {
    cachearenagungameloadouts(var0);
    game["arenaRandomLoadoutIndex"] = 0;
    return;
  }
}

function cachearenagungameloadouts(var0) {
  game["arenaRandomLoadout"] = [];
  var1 = [];
  var2 = "mp/classTable_arena.csv";

  if(var0) {
    var3 = [14, 24, 12, 29, 1, 8, 31, 34, 10, 2];
  } else {
    var3 = [2, 10, 34, 31, 8, 1, 29, 12, 24, 14];
  }

  for(var4 = 0; var4 < var3.size; var4++) {
    var2 = updateloadoutarray(var3, var3[var4]);
  }

  game["arenaRandomLoadout"] = var2;
}

function setenemyloadoutomnvars() {
  var0 = undefined;

  if(!isDefined(self.pers["team"])) {
    var1 = "allies";
  } else {
    var1 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  }

  foreach(var3 in level.players) {
    if(var3.team == var1) {
      var1 = var3;
      break;
    }
  }

  if(!isDefined(var1)) {
    var1 = self;
  }

  var5 = "mp/arenaGGWeapons.csv";
  self setclientomnvar("ui_arena_en_primary", -1);
  self setclientomnvar("ui_arena_en_secondary", -1);
  self setclientomnvar("ui_arena_en_lethal", -1);
  self setclientomnvar("ui_arena_en_tactical", -1);
  var6 = int(tablelookup(var5, 0, var1.pers["gamemodeLoadout"]["loadoutPrimary"], 1));
  self setclientomnvar("ui_arena_en_primary", var6);
  var7 = int(tablelookup(var5, 0, var1.pers["gamemodeLoadout"]["loadoutSecondary"], 1));
  self setclientomnvar("ui_arena_en_secondary", var7);
  var8 = int(tablelookup(var5, 0, var1.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"], 1));
  self setclientomnvar("ui_arena_en_lethal", var8);
  var9 = int(tablelookup(var5, 0, var1.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"], 1));
  self setclientomnvar("ui_arena_en_tactical", var9);
}

function getgungameloadoutindex(var0) {
  var1 = 0;

  if(game["roundsPlayed"] == 0) {
    var1 = 0;
  } else if(isgungameloadouts()) {
    var1 = game["roundsWon"][var0.pers["team"]];
  } else {
    var1 = game["roundsWon"][scripts\mp\utility\game::getotherteam(var0.pers["team"])[0]];
  }

  return var1;
}

function getgungameloadoutomnvarindex(var0, var1) {
  var2 = 0;

  if(isgungameloadouts()) {
    var2 = game["roundsWon"][var0.pers["team"]];

    if(isDefined(var1) && var1 == var0.pers["team"]) {
      var2 += 1;
    }
  } else {
    var2 = game["roundsWon"][scripts\mp\utility\game::getotherteam(var0.pers["team"])[0]];

    if(isDefined(var1) && var1 == scripts\mp\utility\game::getotherteam(var0.pers["team"])[0]) {
      var2 += 1;
    }
  }

  return var2;
}

function setenemyloadoutomnvarsatmatchend(var0) {
  foreach(var2 in level.players) {
    var3 = undefined;

    if(!isDefined(var2.pers["team"])) {
      var4 = "allies";
    } else {
      var4 = scripts\mp\utility\game::getotherteam(var2.pers["team"])[0];
    }

    foreach(var6 in level.players) {
      if(var6.team == var4) {
        var3 = var6;
        break;
      }
    }

    if(!isDefined(var3)) {
      var3 = var2;
    }

    var3.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][getgungameloadoutomnvarindex(var3, var0)];
    var8 = "mp/arenaGGWeapons.csv";
    var2 setclientomnvar("ui_arena_en_primary", -1);
    var2 setclientomnvar("ui_arena_en_secondary", -1);
    var2 setclientomnvar("ui_arena_en_lethal", -1);
    var2 setclientomnvar("ui_arena_en_tactical", -1);
    var9 = int(tablelookup(var8, 0, var3.pers["gamemodeLoadout"]["loadoutPrimary"], 1));
    var2 setclientomnvar("ui_arena_en_primary", var9);
    var10 = int(tablelookup(var8, 0, var3.pers["gamemodeLoadout"]["loadoutSecondary"], 1));
    var2 setclientomnvar("ui_arena_en_secondary", var10);
    var11 = int(tablelookup(var8, 0, var3.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"], 1));
    var2 setclientomnvar("ui_arena_en_lethal", var11);
    var12 = int(tablelookup(var8, 0, var3.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"], 1));
    var2 setclientomnvar("ui_arena_en_tactical", var12);
  }
}

function spawngameendflagzone(var0) {
  var1 = getEntArray("flag_arena", "targetname");

  if(!isDefined(var1[0])) {
    return;
  }

  level.arenaflag = var1[0];
  var2 = var1[0];

  if(isDefined(var2.target)) {
    GscBinSkip1(0x45, 0, getEnt(var2.target, "targetname"));
  }

  GscBinSkip1(0x45, 0, spawn("script_model", var2.origin));
}

function showflagoutline() {
  waitframe();

  if(isDefined(level.arenaflag) && isDefined(level.arenaflag.flagmodel)) {
    level.arenaflag.flagmodel.outlinedid = scripts\mp\utility\outline::outlineenableforall(level.arenaflag.flagmodel, "outline_nodepth_orange", "level_script");
  }

  thread removeflagoutlineongameend();
}

function arenaflag_onusebegin(var0) {
  var0.iscapturing = 1;
  level.canprocessot = 0;
  var1 = scripts\mp\gameobjects::getownerteam();

  if(var1 == "neutral") {
    var0 setclientomnvar("ui_objective_state", 1);
  }

  self.neutralizing = istrue(level.flagneutralization) && var1 != "neutral";
  self.ref_126cd = 1;

  if(!istrue(self.neutralized)) {
    self.didstatusnotify = 0;
  }

  var2 = scripts\engine\utility::ter_op(istrue(level.flagneutralization), level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(var2);

  if(istrue(level.capturedecay)) {
    thread scripts\mp\gameobjects::useobjectdecay(var0.team);
  }

  if(var2 > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var0.team)[0];
    scripts\mp\gametypes\obj_dom::updateflagcapturestate(var0.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icontaking, level.iconlosing);
    return;
  }
}

function arenaflag_onuseupdate(var0, var1, var2, var3) {
  var4 = scripts\mp\gameobjects::getownerteam();

  if(var1 > 0.05 && var2 && !self.didstatusnotify) {
    if(var4 == "neutral") {
      if(level.flagcapturetime > 0.05) {
        scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var0);
        var5 = scripts\mp\utility\game::getotherteam(var0)[0];
        scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, var5);
      }
    } else if(level.flagcapturetime > 0.05) {
      scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, var4);
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var0);
    }

    self.didstatusnotify = 1;
    return;
  }
}

function arenaflag_onuseend(var0, var1, var2) {
  level.canprocessot = 1;
  self.didstatusnotify = 0;

  if(var2) {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  if(isPlayer(var1)) {
    var1.iscapturing = 0;
    var1 setclientomnvar("ui_objective_state", 0);
    var1.ui_dom_securing = undefined;
  }

  var3 = scripts\mp\gameobjects::getownerteam();

  if(var3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    thread scripts\mp\gametypes\obj_dom::updateflagstate(var3, 0);
  }

  if(!var2) {
    self.neutralized = 0;
    return;
  }
}

function arenaflag_onuse(var0) {
  level.canprocessot = 1;
  var1 = var0.team;
  var2 = scripts\mp\gameobjects::getownerteam();
  var3 = scripts\mp\utility\game::getotherteam(var1)[0];
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;
  scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, var3);
  scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, var1);
  thread scripts\mp\utility\print::printandsoundoneveryone(var1, var3, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var0);
  scripts\mp\gametypes\obj_dom::dompoint_setcaptured(var1, var0);

  if(!self.neutralized) {
    var4 = 3;

    if(self.objectivekey == "_a") {
      var4 = 1;
    } else if(self.objectivekey == "_b") {
      var4 = 2;
    }

    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, var0, var1, var2, self);
    }

    self.firstcapture = 0;
  }

  game["dialog"]["round_success"] = "gamestate_win_capture";
  game["dialog"]["round_failure"] = "gamestate_lost_capture";
  thread arena_endgame(level, var0.team, game["end_reason"]["arena_otflag_completed"]);
}

function arenaflag_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread scripts\mp\gametypes\obj_dom::updateflagstate("contested", 0);
  thread forcegameendcontesttimeout();
}

function calloutmarkerping_watchentitydeathorenemydisconnect(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();

  if(var1 == "neutral") {
    if(var0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var0);
    } else if(isDefined(self.lastprogressteam)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, self.lastprogressteam);
    }
  } else {
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, scripts\mp\utility\game::getotherteam(var1)[0]);
  }

  if(var0 == "none" || var1 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

function forcegameendcontesttimeout() {
  level notify("start_overtime_timeout");
  level endon("start_overtime_timeout");
  level endon("game_ended");

  if(!isDefined(level.ottimecontested)) {
    level.ottimecontested = 0;
  }

  while(level.ottimecontested < 5000) {
    wait level.framedurationseconds;
    level.ottimecontested += level.frameduration;
  }

  level.canprocessot = 1;
}

function disableotflag() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::disableobject();

  if(isDefined(self.scriptable)) {
    self.scriptable delete();
  }

  self.flagmodel hide();
}

function removeflagoutlineongameend() {
  level waittill("game_ended");

  if(isDefined(level.arenaflag) && isDefined(level.arenaflag.flagmodel.outlinedid)) {
    scripts\mp\utility\outline::outlinedisable(level.arenaflag.flagmodel.outlinedid, level.arenaflag.flagmodel);
    return;
  }
}

function deleteotpreview() {
  level scripts\engine\utility::ref_143a5("prematch_done", "start_mode_setup");
  disableotflag();
}

function setupendzones() {
  if(level.mapname == "mp_shipment") {
    level.attackerendzone = getEntArray("flag_goal_defender", "targetname");
    level.defenderendzone = getEntArray("flag_goal_attackers", "targetname");
  } else if(level.mapname == "mp_m_hill") {
    level.attackerendzone = getEntArray("flag_goal_defender", "targetname");
    level.defenderendzone = getEntArray("flag_goal_attacker", "targetname");
  } else {
    level.attackerendzone = getEntArray("flag_goal_attacker", "targetname");
    level.defenderendzone = getEntArray("flag_goal_defender", "targetname");
  }

  level.attackerendzone = createendzone(level.attackerendzone[0], game["attackers"]);
  level.defenderendzone = createendzone(level.defenderendzone[0], game["defenders"]);
  level.objectives["_b"] = level.attackerendzone;
  level.objectives["_c"] = level.defenderendzone;
}

function createendzone(var0) {
  if(isDefined(self.target)) {
    GscBinSkip1(0x45, 0, getEnt(self.target, "targetname"));
  }

  GscBinSkip1(0x45, 0, spawn("script_model", self.origin));
}

function endzone_onusebegin(var0) {
  var0.iscapturing = 1;
  level.canprocessot = 0;
  var1 = scripts\mp\gameobjects::getownerteam();

  if(var1 == "neutral") {
    var0 setclientomnvar("ui_objective_state", 1);
  }

  self.neutralizing = istrue(level.flagneutralization) && var1 != "neutral";

  if(!istrue(self.neutralized)) {
    self.didstatusnotify = 0;
  }

  var2 = scripts\engine\utility::ter_op(istrue(level.flagneutralization), level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(var2);

  if(istrue(level.capturedecay)) {
    thread scripts\mp\gameobjects::useobjectdecay(var0.team);
  }

  if(var2 > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var0.team)[0];
    scripts\mp\gametypes\obj_dom::updateflagcapturestate(var0.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingendzone, level.icontakingendzone);
    return;
  }
}

function endzone_onuseend(var0, var1, var2) {
  level.canprocessot = 1;

  if(var2) {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  if(isPlayer(var1)) {
    var1.iscapturing = 0;
    var1 setclientomnvar("ui_objective_state", 0);
    var1.ui_dom_securing = undefined;
  }

  var3 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);

  if(!var2) {
    self.neutralized = 0;
    return;
  }
}

function endzone_onuse(var0) {
  level.canprocessot = 1;
  var1 = var0.team;
  var2 = scripts\mp\gameobjects::getownerteam();
  var3 = scripts\mp\utility\game::getotherteam(var1)[0];
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;
  thread scripts\mp\utility\print::printandsoundoneveryone(var1, var3, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var0);
  endzone_setcaptured(var1, var0);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, var0, var1, var2, self);
    }
  }

  thread arena_endgame(level, var0.team, game["end_reason"]["objective_completed"], undefined, 0);
}

function endzone_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestendzone);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

function endzone_onuncontested(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  self.processot = 1;
}

function endzone_setcaptured(var0, var1) {
  scripts\mp\gameobjects::setownerteam(var0);
  self notify("capture", var1);
  self notify("assault", var1);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  self.neutralized = 0;

  if(self.touchlist[var0].size == 0) {
    self.touchlist = self.oldtouchlist;
  }

  thread giveflagcapturexp(self.touchlist[var0], var1);

  if(isDefined(level.matchrecording_logevent)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), scripts\engine\utility::ter_op(var0 == "allies", 1, 2));
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + var0);
}

function endzone_stompprogressreward(var0) {
  var0 thread scripts\mp\rank::scoreeventpopup("defend");
  var0 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
}

function getcapturetype() {
  var0 = "normal";

  if(level.capturetype == 2) {
    var0 = "neutralize";
  } else if(level.capturetype == 3) {
    var0 = "persistent";
  }

  return var0;
}

function giveflagcapturexp(var0, var1) {
  level endon("game_ended");
  var2 = var1;

  if(isDefined(var2.owner)) {
    var2 = var2.owner;
  }

  level.lastcaptime = gettime();

  if(isPlayer(var2)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition", var2);
    var2 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var2.origin);
  }

  var3 = getarraykeys(var0);

  for(var4 = 0; var4 < var3.size; var4++) {
    var5 = var0[var3[var4]].player;

    if(isDefined(var5.owner)) {
      var5 = var5.owner;
    }

    if(!isPlayer(var5)) {
      continue;
    }

    var5 scripts\mp\utility\stats::incpersstat("captures", 1);
    var5 scripts\mp\persistence::statsetchild("round", "captures", var5.pers["captures"]);
    var5 thread scripts\mp\rank::scoreeventpopup("capture");
    var5 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure");
    wait 0.05;
  }
}

function startotmechanics() {
  if(level.objmodifier == 1) {
    foreach(var1 in level.objectives) {
      if(var1.objectivekey != "_a") {
        deleteendzone(var1);
      }
    }
  }

  level.canprocessot = 1;

  if(!isDefined(level.arenaflag.objidnum)) {
    level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);
  }

  level.arenaflag scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  level.arenaflag scripts\mp\gameobjects::enableobject();
  level.arenaflag scripts\mp\gameobjects::allowuse("enemy");
  level.arenaflag.flagmodel show();

  if(level.spawnflag) {
    game["dialog"]["overtime"] = "gamestate_overtime_flagspawn";
  }

  thread ref_13311();
  level.arenaflag.flagmodel playSound("flag_spawned");
  scripts\mp\utility\game::setmlgannouncement(10, "free");
  thread showflagoutline();

  if(istrue(level.ref_1343f)) {
    foreach(var4 in level.players) {
      if(isalive(var4)) {
        var5 = var4 scripts\mp\equipment::getcurrentequipment("primary");

        if(isDefined(var5) && var5 == "equip_snowball") {
          var4 scripts\mp\equipment::incrementequipmentammo("equip_snowball", 10);
        } else if(!isDefined(var5)) {
          var4 scripts\mp\equipment::giveequipment("equip_snowball", "primary");
          var4 scripts\mp\equipment::incrementequipmentammo("equip_snowball", 10);
        }
      }
    }

    return;
  }
}

function ref_13311() {
  wait 0.15;

  if(istrue(level.arenaflag.ref_126cd)) {
    return;
  }

  foreach(var1 in level.players) {
    if(var1 issplitscreenplayer() && !var1 issplitscreenplayerprimary()) {
      continue;
    }

    var1 scripts\mp\utility\dialog::leaderdialogonplayer("overtime");
  }
}

function deleteendzone() {
  self notify("monitor_flag_control");
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::releaseid();
  self.trigger = undefined;
  self notify("deleted");
  self.visibleteam = "none";

  if(isDefined(self.scriptable)) {
    self.scriptable delete();
  }

  self.flagmodel delete();
}

function dogtagallyonusecb(var0) {
  var0.health = var0.maxhealth;
  var0 notify("healed");
}

function dogtagenemyonusecb(var0) {
  var0.health = var0.maxhealth;
  var0 notify("healed");
}

function outlineenemyplayers() {
  level endon("prematch_done");
  level endon("removeArenaOutlines");

  for(;;) {
    level waittill("spawned_player");
    waitframe();

    foreach(var1 in level.players) {
      var2 = var1 getentitynumber();

      if(!isDefined(var1.outlinedenemies)) {
        if(!isDefined(level.activeoutlines)) {
          level.activeoutlines = 1;
        } else {
          level.activeoutlines++;
        }
      }

      foreach(var4 in level.players) {
        if(var4 != var1 && var4.team != var1.team) {
          if(isDefined(var1.outlinedenemies)) {
            scripts\mp\utility\outline::outlinedisable(var1.outlinedenemies, var1);
          }

          var1.outlinedenemies = scripts\mp\utility\outline::outlineenableforteam(var1, var4.team, "outline_nodepth_orange", "level_script");
          break;
        }
      }
    }
  }
}

function removeenemyoutlines() {
  thread notifyremoveoutlines();
  level scripts\engine\utility::ref_143a5("prematch_done", "removeArenaOutlines");

  foreach(var1 in level.players) {
    var2 = var1 getentitynumber();

    if(isDefined(var1.outlinedenemies)) {
      level.activeoutlines--;
      scripts\mp\utility\outline::outlinedisable(var1.outlinedenemies, var1);
      var1.outlinedenemies = undefined;
    }
  }
}

function notifyremoveoutlines() {
  level endon("prematch_done");
  level waittill("match_start_real_countdown");

  if(level.prematchperiodend > 5) {
    var0 = int(max(level.prematchperiodend - 5, 5));
  } else {
    var0 = int(max(level.prematchperiodend - 2, 2));
  }

  wait var0;
  level notify("removeArenaOutlines");
}

function outlineequipmentwatchplayerprox(var0, var1) {
  self endon("death");
  self endon("trigger");
  self.outlinedplayers = [];
  var2 = level.baseraritymap[var1];
  var3 = getoutlineasset(var2, var1);

  for(;;) {
    foreach(var5 in level.players) {
      if(isDefined(var5.hasarenaspawned)) {
        var6 = distance2dsquared(self.origin, var5.origin);
        var7 = var5 getentitynumber();

        if(var6 < 490000) {
          if(!isDefined(self.outlinedplayers[var7])) {
            if(!isDefined(level.activeoutlines)) {
              level.activeoutlines = 1;
            } else {
              level.activeoutlines++;
            }

            self.outlinedplayers[var7] = scripts\mp\utility\outline::outlineenableforplayer(self, var5, var3, "level_script");
          }
        } else if(isDefined(self.outlinedplayers[var7])) {
          level.activeoutlines--;
          scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[var7], self);
          self.outlinedplayers[var7] = undefined;
        }
      }
    }

    waitframe();
  }
}

function outlinewatchplayerprox() {
  self endon("death");
  self endon("trigger");
  self.outlinedplayers = [];
  var0 = scripts\mp\weapons::getitemweaponname();
  var1 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var2 = level.baseraritymap[var1 + "_mp"];
  var3 = getoutlineasset(var2);

  for(;;) {
    foreach(var5 in level.players) {
      if(isDefined(var5.hasarenaspawned)) {
        var6 = distance2dsquared(self.origin, var5.origin);
        var7 = var5 getentitynumber();

        if(var6 < 490000) {
          if(!isDefined(self.outlinedplayers[var7])) {
            if(!isDefined(level.activeoutlines)) {
              level.activeoutlines = 1;
            } else {
              level.activeoutlines++;
            }

            self.outlinedplayers[var7] = scripts\mp\utility\outline::outlineenableforplayer(self, var5, var3, "level_script");
          }
        } else if(isDefined(self.outlinedplayers[var7])) {
          level.activeoutlines--;
          scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[var7], self);
          self.outlinedplayers[var7] = undefined;
        }
      }
    }

    waitframe();
  }
}

function getoutlineasset(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  var2 = "white";
  var3 = int(min(var0, 8));

  switch (var3) {
    case 0:
      var2 = "outline_depth_white";
      break;
    case 1:
      var2 = "outline_depth_green";
      break;
    case 2:
      var2 = "outline_depth_cyan";
      break;
    case 3:
      var2 = "outline_depth_red";
      break;
    case 4:
      var2 = "outline_depth_orange";
      break;
    case 5:
      var2 = "outline_depth_yellow";
      break;
    case 6:
      var2 = "outline_depth_blue";
      break;
    case 7:
      var2 = "outline_depth_green";
      break;
    case 8:
      var2 = "outline_depth_red";
      break;
  }

  if(istrue(level.ref_1343f) && isDefined(var1) && var1 == "equip_pball") {
    var2 = "outline_depth_yellow";
  }

  return var2;
}

function clearweaponoutlines() {
  foreach(var1 in self.outlinedplayers) {
    level.activeoutlines--;
    scripts\mp\utility\outline::outlinedisable(var1, self);
    var1 = undefined;
  }
}

function selflookatfriendly() {
  level endon("prematch_ended");
  var0 = undefined;
  var1 = 0;

  while(isDefined(level.matchcountdowntime) && level.matchcountdowntime > 5) {
    var2 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

    if(var2.size > 1) {
      var1 = 1;
      break;
    }

    waitframe();
  }

  if(var1) {
    var3 = self.angles;
    var4 = 0;
    var5 = scripts\mp\utility\teams::getteamdata(self.team, "players");

    foreach(var7 in var5) {
      if(var7 != self) {
        var0 = var7;
      }
    }

    var9 = var0.origin - self.origin;
    var10 = self.origin - var0.origin;
    var11 = anglestoright(self.angles);
    var12 = vectordot(var11, var9);
    var13 = 0;
    var14 = 0;

    if(var12 < 0) {
      var15 = 85;
      var13 = 1;
    } else {
      var15 = -90;
      var15 = 1;
    }

    if(isDefined(var1)) {
      if(var14) {
        if(!isbot(self)) {
          wait 0.5;

          if(self.currentweapon.basename != "none") {
            self forceplaygestureviewmodel("ges_crush_turnleft");
          }
        }
      } else if(!isbot(self)) {
        wait 0.5;

        if(self.currentweapon.basename != "none") {
          self forceplaygestureviewmodel("ges_crush_turnright");
        }
      }

      wait 3;
      scripts\mp\utility\player::_freezecontrols(0);
      return;
    }

    scripts\mp\utility\player::_freezecontrols(0);
    return;
  }

  scripts\mp\utility\player::_freezecontrols(0);
}

function updatematchstatushintonspawn() {
  level endon("game_ended");
  self setclientomnvar("ui_match_status_hint_text", 0);
}

function seticonnames() {
  level.iconcaptureendzone = "waypoint_capture_endzone";
  level.icondefendendzone = "waypoint_defend_endzone";
  level.iconcontestendzone = "waypoint_contesting_endzone";
  level.icontakingendzone = "waypoint_taking_endzone";
  level.iconlosingendzone = "waypoint_losing_endzone";
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
  level.icondefending = "waypoint_defending";
}

function setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_taking_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_losing_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contesting_endzone", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_dom_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_taking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defending_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocked_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_losing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_captureneutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_a", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dom_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_ot_a", 1, "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dogtags", 1, "enemy", "", "icon_minimap_dogtag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dogtags_friendly", 1, "friendly", "", "icon_minimap_dogtag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dogtags_skull", 1, "enemy", "", "icon_minimap_dogtag_skull", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dogtags_skull_fr", 1, "friendly", "", "icon_minimap_dogtag_skull", 0);
}

function isnormalloadouts() {
  return level.arenaloadouts == 1;
}

function israndomloadouts() {
  return level.arenaloadouts == 2;
}

function ispickuploadouts() {
  return level.arenaloadouts == 3 || level.arenaloadouts == 14;
}

function isgungameloadouts() {
  return level.arenaloadouts == 4;
}

function isrvsgungameloadouts() {
  return level.arenaloadouts == 5;
}

function israndompreviewloadouts() {
  return level.arenaloadouts == 6;
}

function usb_left() {
  return level.arenaloadouts == 7;
}

function usbwm() {
  return level.arenaloadouts == 8;
}

function usbserver() {
  return level.arenaloadouts == 9;
}

function usbvm() {
  return level.arenaloadouts == 10;
}

function use_airdrop_fx() {
  return level.arenaloadouts == 11;
}

function usbmodel() {
  return level.arenaloadouts == 12;
}

function usb_right() {
  return level.arenaloadouts == 13;
}

function updatec4vehiclemultkill() {
  return level.arenaloadouts == 14;
}

function usb_tape_animation_test() {
  return level.arenaloadouts == 15;
}

function usbs_pulled_out() {
  return level.arenaloadouts == 16;
}

function ref_1343f() {
  if(istrue(game["practiceRound"]) || istrue(level.brmissionscompleted)) {
    level.startweapon.weapon = "equip_snowball";
    level.lethaldelay = 0;
    defineplayerloadout(1);
  }

  initweaponmap();
  thread ref_1326d();
}

function ref_1326d() {
  level.arenaweapont1.weapon = "equip_snowball";

  if(!istrue(level.brmissionscompleted) && !istrue(game["practiceRound"])) {
    level.arenaweapont1.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont1.weapon, "equip_snowball");
    level.arenaweapont2.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont2.weapon, "equip_snowball");
    level.arenaweapont3.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont3.weapon, "equip_snowball");
    level.arenaweapont4.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont4.weapon, "equip_snowball");
    level.arenaweapont5.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont5.weapon, "equip_snowball");
    level.arenaweapont6.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont6.weapon, "equip_snowball");
    level.arenaweapont7.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont7.weapon, "equip_snowball");
    level.arenaweapont8.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont8.weapon, "equip_snowball");
  }

  level.ref_12344 = 0;
  var0 = scripts\engine\utility::getStructArray("weapon_pickup", "targetname");

  foreach(var2 in var0) {
    if(istrue(level.brmissionscompleted) || istrue(game["practiceRound"]) || level.arenaloadouts != 3) {
      spawnweapon(var2, level.arenaweapont1);
      continue;
    }

    if(var2.script_label == "1") {
      spawnweapon(var2, level.arenaweapont1);
      continue;
    }

    if(var2.script_label == "2") {
      spawnweapon(var2, level.arenaweapont2);
      continue;
    }

    if(var2.script_label == "3") {
      spawnweapon(var2, level.arenaweapont3);
      continue;
    }

    if(var2.script_label == "4") {
      spawnweapon(var2, level.arenaweapont4);
      continue;
    }

    if(var2.script_label == "5") {
      spawnweapon(var2, level.arenaweapont5);
      continue;
    }

    if(var2.script_label == "6") {
      spawnweapon(var2, level.arenaweapont6);
      continue;
    }

    if(var2.script_label == "7") {
      spawnweapon(var2, level.arenaweapont7);
      continue;
    }

    if(var2.script_label == "8") {
      spawnweapon(var2, level.arenaweapont8);
    }
  }
}

function ref_144f3(var0, var1) {
  self endon("death");
  self waittill("trigger", var2, var3);
  var4 = 0;
  var5 = checkissameequip(var2);
  var6 = checkpickupequiptypeammocount(var2);

  if(self.equipment == "equip_snowball") {
    var7 = 10;
  } else {
    var7 = 1;
  }

  var8 = checkcurrentequiptypeammocount(var3);
  var9 = 1;

  switch (var2) {
    case "pile":
      var9 = 10;
      break;
    case "pyramid":
      var9 = 5;
      break;
    default:
      var9 = 1;
      break;
  }

  if(var6) {
    if(var7 == var7) {
      var5 = 1;
    }
  }

  if(var6 && !var5) {
    var3 scripts\mp\equipment::incrementequipmentammo(self.equipment, var9);
  } else if(var8 && !var6 && !isPlayer(var1)) {
    dropoldequipinplace(var3, var3 scripts\mp\equipment::getcurrentequipment(self.equiptype));
  }

  if(!var6) {
    var3 scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);

    if(self.equipment == "equip_snowball" && !var5) {
      var3 scripts\mp\equipment::incrementequipmentammo(self.equipment, var9);
    }
  }

  if(var6 && var5) {
    var3 iprintlnbold(&"MP_INGAME_ONLY/EQUIPMENT_MAXED");
    thread watchequipmentpickup();
    return;
  }

  var3 playlocalsound("scavenger_pack_pickup");
  playFX(level.ref_13443["vanish"], self.origin);
  clearweaponoutlines();

  if(!isPlayer(var1)) {
    thread ref_14398(level);
  }

  self makeunusable();
  self delete();
}

function ref_14398(var0) {
  level endon("game_ended");
  wait 15;
  playFX(level.ref_13443["vanish"], var0.origin);
  spawnweapon(var0, level.arenaweapont1);
}

function ref_13441() {
  level scripts\mp\flags::gameflagwait("prematch_done");
  wait 1;
  self allowmelee(0);
}

function removefromlittlebirdmglistondeath() {
  if(scripts\mp\utility\game::matchmakinggame()) {
    return getdvarint("scr_arena_knivesout", 0);
  } else if(validateevents(level.arenaweapont1.weapon) && validateevents(level.arenaweapont2.weapon) && validateevents(level.arenaweapont3.weapon) && validateevents(level.arenaweapont4.weapon) && validateevents(level.arenaweapont5.weapon) && validateevents(level.arenaweapont6.weapon) && validateevents(level.arenaweapont7.weapon) && validateevents(level.arenaweapont8.weapon)) {
    if(validateevents(level.startweapon.weapon)) {
      return 2;
    } else {
      return 1;
    }
  }

  return 0;
}

function validateevents(var0) {
  if(var0 == "equip_throwing_knife" || var0 == "equip_throwing_knife_fire" || var0 == "equip_throwing_knife_electric" || var0 == "equip_throwing_knife_drill") {
    return 1;
  }

  return 0;
}

function player_give_intel_3_ks() {
  switch (level.calloutmarkerpingvo_getcalloutaliasstringvehicle) {
    case "super_weapon_drop":
    case "super_emp_drone":
    case "super_recon_drone":
      level.calloutmarkerpingvo_getcalloutaliasstringvehicle = "super_ammo_drop";
      break;
    default:
      break;
  }

  return level.calloutmarkerpingvo_getcalloutaliasstringvehicle;
}