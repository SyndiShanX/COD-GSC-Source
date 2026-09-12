/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\oic.gsc
***********************************************/

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
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
  setdynamicdvar("scr_oic_initialAmmoCount", getmatchrulesdata("oicData", "initialAmmoCount"));
  setdynamicdvar("scr_oic_killRewardAmmoCount", getmatchrulesdata("oicData", "killRewardAmmoCount"));
  setdynamicdvar("scr_oic_oneShotKill", getmatchrulesdata("oicData", "oneShotKill"));
  setdynamicdvar("scr_oic_weapon", getmatchrulesdata("oicData", "weapon"));
  setdynamicdvar("scr_oic_promode", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");
  scripts\mp\utility\game::setobjectivetext("allies", &"OBJECTIVES/OIC");
  scripts\mp\utility\game::setobjectivetext("axis", &"OBJECTIVES/OIC");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/OIC");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/OIC");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/OIC_SCORE");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/OIC_SCORE");
  }

  scripts\mp\utility\game::setobjectivehinttext("allies", &"OBJECTIVES/OIC_HINT");
  scripts\mp\utility\game::setobjectivehinttext("axis", &"OBJECTIVES/OIC_HINT");
  ref_13158();
  setspecialloadouts();
  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dm_spawn_start", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn_secondary", 1, 1);
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("dm", var_0);
  scripts\mp\spawnlogic::registerspawnset("dm_fallback", var_1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.blockweapondrops = 1;
  thread ref_12028();
  thread play_player_disguise_vo();
  thread onplayerconnect();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.ref_11B39 = scripts\mp\utility\dvars::dvarintvalue("initialAmmoCount", 1, 0, 15);
  level.ref_11B3C = scripts\mp\utility\dvars::dvarintvalue("killRewardAmmoCount", 1, 0, 15);
  level.ref_11B3B = scripts\mp\utility\dvars::dvarintvalue("oneShotKill", 1, 0, 1);
  level.ref_11B3A = spawnStruct();
  var_0 = getDvar("scr_oic_weapon");
  level.ref_11B3A.ref_11DF4 = var_0;
  level.ref_11B3A.weapon = scripts\mp\utility\weapon::getweaponrootname(var_0);
  level.ref_11B3A.ref_11FBA = 0;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.pers["class"] = "gamemode";
    var_0.pers["lastClass"] = "";
    var_0.class = var_0.pers["class"];
    var_0.lastclass = var_0.pers["lastClass"];
    var_0.pers["gamemodeLoadout"] = level.ref_11FB8["axis"];
    var_0 loadweaponsforplayer([level.ref_11B3A.ref_11DF4], 1);
    var_0.ref_11FB5 = 1;
    var_0.ref_11FB7 = 0;
  }
}

function getspawnpoint() {
  if(self.ref_11FB5) {
    thread ref_11DA5();
  }

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

  var_0 = scripts\mp\spawnlogic::getspawnpoint(self, "none", "dm", "dm_fallback");
  return var_0;
}

function ref_11DA5() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("graceperiod_done");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(5);

  if(!self.ref_11FB7) {
    scripts\mp\menus::addtoteam("spectator", 1);
    return;
  }
}

function onspawnplayer() {
  if(isDefined(self.ref_11FB9) && self.ref_11FB9) {
    scriptablenousestate();
  } else {
    self.ref_11FB9 = 0;
  }

  thread waitloadoutdone();
  level notify("spawned_player");

  if(scripts\mp\utility\game::getgametypenumlives() != 0) {
    thread ref_12606();
    return;
  }
}

function waitloadoutdone() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  var_0 = weaponclipsize(self.primaryweapon);

  if(level.ref_11B39 > var_0) {
    self setweaponammoclip(self.primaryweapon, var_0);
    self setweaponammostock(self.primaryweapon, level.ref_11B39 - var_0);

    if(self.primaryweapons[0] hasattachment("akimbo", 1)) {
      self setweaponammoclip(self.primaryweapon, level.ref_11B39 - var_0, "left");
    }
  } else {
    self setweaponammoclip(self.primaryweapon, level.ref_11B39);
    self setweaponammostock(self.primaryweapon, 0);

    if(self.primaryweapons[0] hasattachment("akimbo", 1)) {
      self setweaponammoclip(self.primaryweapon, level.ref_11B39, "left");
    }
  }

  scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe("iw8_fists_mp");
  var_1 = getcompleteweaponname("iw8_knifestab_mp");
  self giveweapon(var_1);
  self assignweaponmeleeslot(var_1);
  self.ref_11FB7 = 1;
  self setclientomnvar("ui_oic_lives", self.pers["lives"] + 1);
}

function ref_12606() {
  var_0 = self.pers["lives"];

  if(var_0 == 1) {
    scripts\mp\utility\dialog::leaderdialogonplayer("oic_lives_two");
    return;
  }

  if(var_0 == 0) {
    var_1 = scripts\engine\utility::ter_op(randomint(100) < 30, "oic_lives_last_alt", "oic_lives_last");
    scripts\mp\utility\dialog::leaderdialogonplayer(var_1);
    return;
  }
}

function modifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_HEAD_SHOT") {
    var_3 = 999;
  }

  return var_3;
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  level.ref_13B93 = gettime();

  if(var_1.pers["cur_kill_streak"] > var_1 scripts\mp\utility\stats::getpersstat("killChains")) {
    var_1.pers["killChains"] = var_1.pers["cur_kill_streak"];
    var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["cur_kill_streak"]);
    return;
  }
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1) && self != var_1) {
    if(isDefined(var_3) && var_3 == "MOD_EXECUTION") {
      var_1.ref_11FB9 += level.ref_11B3C + 2;
    } else {
      var_1.ref_11FB9 += level.ref_11B3C;
    }

    if(var_1 attackButtonPressed()) {
      thread ref_14383();
    } else {
      scriptablenousestate(var_1);
    }

    if(scripts\mp\utility\game::getgametypenumlives() && self.pers["deaths"] == scripts\mp\utility\game::getgametypenumlives()) {
      monitor_victim_cash_drops(var_1);
    }

    if(var_3 == "MOD_MELEE") {
      var_1 scripts\mp\utility\stats::incpersstat("stabs", 1);
      var_1 scripts\mp\persistence::statsetchild("round", "stabs", var_1.pers["stabs"]);

      if(isPlayer(var_1)) {
        var_1 scripts\mp\utility\stats::setextrascore0(var_1.pers["stabs"]);
      }
    }

    if(scripts\mp\utility\game::matchmakinggame()) {
      foreach(var_11 in level.players) {
        if(isDefined(var_11.sessionstate) && (var_11.sessionstate == "spectator" || var_11.sessionstate == "spectating")) {
          var_12 = var_11 getspectatingplayer();

          if(isDefined(var_12) && isDefined(var_1) && var_12 == var_1) {
            var_11 playlocalsound("mp_bombplaced_friendly");
            var_13 = scripts\mp\rank::getscoreinfovalue("kill_bonus");
            var_11 thread scripts\mp\rank::giverankxp("kill_bonus", var_13);
            var_11 setclientomnvar("ui_oic_wager", gettime());
          }
        }
      }

      return;
    }

    return;
  }
}

function onplayerscore(var_0, var_1, var_2, var_3) {
  var_1 scripts\mp\utility\stats::incpersstat("gamemodeScore", var_2);
  var_4 = int(var_1 scripts\mp\utility\stats::getpersstat("gamemodeScore"));
  var_1 scripts\mp\persistence::statsetchild("round", "gamemodeScore", var_4);

  if(issubstr(var_0, "super_")) {
    return 0;
  }

  if(issubstr(var_0, "kill_ss")) {
    return 0;
  }

  if(issubstr(var_0, "kill")) {
    var_5 = scripts\mp\rank::getscoreinfovalue("score_increment");
    return var_5;
  } else if(var_1 == "assist_ffa") {
    var_2 scripts\mp\utility\script::bufferednotify("earned_score_buffered", var_3);
  }

  return 0;
}

function onsuicidedeath(var_0) {
  if(scripts\mp\utility\game::getgametypenumlives() && var_0.pers["deaths"] == scripts\mp\utility\game::getgametypenumlives()) {
    monitor_victim_cash_drops(var_0);
    return;
  }
}

function ononeleftevent(var_0) {
  var_1 = scripts\mp\utility\game::getlastlivingplayer();
  logstring("last one alive, win: " + var_1.name);
  level.finalkillcam_winner = "none";
  level thread scripts\mp\gamelogic::endgame(var_1, game["end_reason"]["enemies_eliminated"], game["end_reason"]["br_eliminated"]);
}

function ref_14383() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("oic_waitGiveAmmo");
  self endon("oic_waitGiveAmmo");

  while(self attackButtonPressed()) {
    waitframe();
  }

  scriptablenousestate();
}

function scriptablenousestate() {
  var_0 = self.primaryweapon;
  var_1 = self getweaponammostock(var_0);
  var_2 = self getweaponammoclip(var_0);
  var_3 = weaponclipsize(var_0);

  if(var_2 + self.ref_11FB9 > var_3) {
    self setweaponammoclip(var_0, var_3);
    self setweaponammostock(var_0, var_1 + var_2 + self.ref_11FB9 - var_3);

    if(isDefined(self.primaryweapons[0]) && self.primaryweapons[0] hasattachment("akimbo", 1)) {
      var_4 = self getweaponammoclip(var_0, "left");
      self setweaponammoclip(var_0, var_1 + var_4 + self.ref_11FB9 - var_3, "left");
    }
  } else {
    self setweaponammoclip(var_0, var_2 + self.ref_11FB9);

    if(isDefined(self.primaryweapons[0]) && self.primaryweapons[0] hasattachment("akimbo", 1)) {
      var_4 = self getweaponammoclip(var_0, "left");
      self setweaponammoclip(var_0, var_4 + self.ref_11FB9, "left");
    }
  }

  self playlocalsound("scavenger_pack_pickup");
  self.ref_11FB9 = 0;
}

function monitor_victim_cash_drops(var_0) {
  thread scripts\mp\hud_message::showsplash("out_of_lives");
  thread scripts\mp\hud_util::teamplayercardsplash("callout_eliminated", self);

  if(isDefined(var_0)) {
    var_0 thread scripts\mp\hud_message::showsplash("target_eliminated");
    var_0 thread scripts\mp\events::killeventtextpopup("target_eliminated", 0);
  }

  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.pers["deaths"] < scripts\mp\utility\game::getgametypenumlives() && var_3.ref_11FB7) {
      var_1 = var_3;
      var_3 scripts\mp\utility\points::giveunifiedpoints("survivor");
    }
  }

  if(var_1.size > 2) {
    scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
  } else if(var_1.size == 2) {
    scripts\mp\utility\sound::playsoundonplayers("mp_obj_captured");
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", var_1[0], var_1[1].team);
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", var_1[1], var_1[0].team);
  }

  scripts\mp\utility\dialog::leaderdialogonplayers("oic_enemy_eliminated", level.players);
}

function ref_126E7(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  while(scripts\mp\utility\player::isinkillcam()) {
    waitframe();
  }

  self notifyonplayercommand("selected_player", "+usereload");
  self notifyonplayercommand("selected_player", "+activate");

  for(;;) {
    self waittill("selected_player");
    var_1 = self getspectatingplayer();

    if(isDefined(var_1)) {
      self.ref_14314 = var_1.name;
      self playlocalsound("recondrone_tag_plr");
    }
  }
}

function play_player_disguise_vo() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("graceperiod_done");
  var_0 = undefined;
  jumpiffalse(scripts\mp\utility\game::matchmakinggame()) LOC_00000033;
  var_0 = getdvarint("scr_oic_finalUAVTime", 5);

  for(;;) {
    var_1 = [];

    foreach(var_3 in level.players) {
      if(var_3.pers["deaths"] < scripts\mp\utility\game::getgametypenumlives() && var_3.ref_11FB7) {
        var_1 = var_3;
      }
    }

    if(var_1.size < 4) {
      level notify("end_one_off_sweeps");

      foreach(var_3 in level.players) {
        if(scripts\mp\utility\player::isreallyalive(var_3)) {
          triggeroneoffradarsweep(var_3);
        }
      }

      wait scripts\engine\utility::ter_op(isDefined(var_0), var_0, 5);
    }

    wait 0.5;
  }
}

function ref_12028() {
  level endon("game_ended");
  level endon("end_one_off_sweeps");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.ref_13B93 = gettime();
  var_0 = undefined;
  var_1 = undefined;

  if(scripts\mp\utility\game::matchmakinggame()) {
    var_0 = getdvarint("scr_oic_noKillsUAVTime", 15);
    var_1 = getdvarint("scr_oic_timeBetweenSweeps", 5);
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 30);
  var_2 *= 1000;
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 15);

  for(;;) {
    if(gettime() > level.ref_13B93 + var_2) {
      foreach(var_5 in level.players) {
        if(scripts\mp\utility\player::isreallyalive(var_5)) {
          triggeroneoffradarsweep(var_5);
        }
      }

      wait var_3;
    }

    wait 1;
  }
}

function ref_13158() {
  if(scripts\mp\utility\game::matchmakinggame() && getdvarint("scr_oic_randomWeapon", 2) > 0) {
    var_0 = getrandomweapon(getdvarint("scr_oic_randomWeapon", 2));
    level.ref_11B3A.weapon = var_0["weapon"];
    level.ref_11B3A.ref_11FBA = var_0["variantID"];
  }

  if(!isDefined(level.ref_11B3A.weapon) || level.ref_11B3A.weapon == "none") {
    level.ref_11B3A.weapon = "iw8_pi_golf21";
  }

  var_1 = tv_station_boss_should_break_stealth_immediately();

  if(var_1 > 1) {
    level.ref_11B39 *= var_1;
    level.ref_11B3C *= var_1;
    return;
  }
}

function tv_station_boss_should_break_stealth_immediately() {
  switch (level.ref_11B3A.weapon) {
    case "iw8_ar_falpha":
      return 3;
    case "iw8_pi_mike9":
      if(level.ref_11B3A.ref_11FBA == 1) {
        return 3;
      }
    case "iw8_ar_falima":
      if(level.ref_11B3A.ref_11FBA == 6 || level.ref_11B3A.ref_11FBA == 9) {
        return 3;
      }
    case "iw8_sm_smgolf45":
      if(level.ref_11B3A.ref_11FBA == 2) {
        return 2;
      }
    default:
      return 1;
  }
}

function getrandomweapon(var_0) {
  level.ref_11FB6 = spawnStruct();
  level.ref_11FB6.ref_1457D = [];
  level.ref_11FB6.ref_1457D["rand_pistol"] = 80;
  level.ref_11FB6.ref_1457D["rand_smg"] = 40;
  level.ref_11FB6.ref_1457D["rand_assault"] = 40;
  level.ref_11FB6.ref_1457D["rand_lmg"] = 25;
  level.ref_11FB6.ref_1457D["rand_sniper"] = 40;
  buildrandomweapontable();

  if(var_0 == 2) {
    level.ref_11FB6.ref_1457D["rand_pistol"] = 100;
    level.ref_11FB6.ref_1457D["rand_smg"] = 0;
    level.ref_11FB6.ref_1457D["rand_assault"] = 0;
    level.ref_11FB6.ref_1457D["rand_lmg"] = 0;
    level.ref_11FB6.ref_1457D["rand_sniper"] = 0;
  } else if(var_0 == 3) {
    level.ref_11FB6.ref_1457D["rand_pistol"] = 0;
    level.ref_11FB6.ref_1457D["rand_smg"] = 0;
    level.ref_11FB6.ref_1457D["rand_assault"] = 0;
    level.ref_11FB6.ref_1457D["rand_lmg"] = 0;
    level.ref_11FB6.ref_1457D["rand_sniper"] = 100;
  } else if(var_0 == 4) {
    level.ref_11FB6.ref_1457D["rand_pistol"] = 0;
    level.ref_11FB6.ref_1457D["rand_smg"] = 100;
    level.ref_11FB6.ref_1457D["rand_assault"] = 0;
    level.ref_11FB6.ref_1457D["rand_lmg"] = 0;
    level.ref_11FB6.ref_1457D["rand_sniper"] = 0;
  } else if(var_0 == 5) {
    level.ref_11FB6.ref_1457D["rand_pistol"] = 0;
    level.ref_11FB6.ref_1457D["rand_smg"] = 0;
    level.ref_11FB6.ref_1457D["rand_assault"] = 100;
    level.ref_11FB6.ref_1457D["rand_lmg"] = 0;
    level.ref_11FB6.ref_1457D["rand_sniper"] = 0;
  } else if(var_0 == 6) {
    level.ref_11FB6.ref_1457D["rand_pistol"] = 0;
    level.ref_11FB6.ref_1457D["rand_smg"] = 0;
    level.ref_11FB6.ref_1457D["rand_assault"] = 0;
    level.ref_11FB6.ref_1457D["rand_lmg"] = 100;
    level.ref_11FB6.ref_1457D["rand_sniper"] = 0;
  } else if(var_0 == 7) {
    level.ref_11FB6.ref_1457D["rand_pistol"] = 0;
    level.ref_11FB6.ref_1457D["rand_smg"] = 0;
    level.ref_11FB6.ref_1457D["rand_assault"] = 0;
    level.ref_11FB6.ref_1457D["rand_lmg"] = 100;
    level.ref_11FB6.ref_1457D["rand_sniper"] = 50;
  }

  var_1 = risk_flagspawnminradius(level.ref_11FB6.ref_1457D);
  var_2 = getrandomweaponfromcategory(var_1);
  return var_2;
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

    var_2 = [];
    var_2 = tablelookupbyrow("mp/gunGameWeapons.csv", var_0, 1);
    var_2 = int(tablelookupbyrow("mp/gunGameWeapons.csv", var_0, 2));
    var_2 = int(tablelookupbyrow("mp/gunGameWeapons.csv", var_0, 3));
    var_2 = int(tablelookupbyrow("mp/gunGameWeapons.csv", var_0, 8));

    if(!var_2["allowed"]) {
      var_0++;
      continue;
    }

    var_3 = scripts\mp\gametypes\gun::remappedhpzoneorder(var_2["weapon"]);
    var_2 = scripts\mp\class::ref_139E7(var_2["weapon"], var_3);
    level.weaponcategories[var_1][level.weaponcategories[var_1].size] = var_2;
  }
}

function getrandomweaponfromcategory(var_0) {
  var_1 = [];
  var_2 = level.weaponcategories[var_0];

  if(isDefined(var_2) && var_2.size > 0) {
    var_3 = "";
    var_4 = undefined;

    for(var_5 = 0;; var_5++) {
      var_6 = randomintrange(0, var_2.size);
      var_4 = var_2[var_6];
      var_7 = scripts\mp\utility\weapon::getweaponrootname(var_4["weapon"]);

      if(!isDefined(var_1[var_7]) || var_5 > var_2.size) {
        var_1 = 1;

        for(var_8 = 0; var_8 < level.weaponcategories[var_0].size; var_8++) {
          if(level.weaponcategories[var_0][var_8]["weapon"] == var_4["weapon"]) {
            level.weaponcategories[var_0] = scripts\engine\utility::array_remove_index(level.weaponcategories[var_0], var_8);
            break;
          }
        }

        break;
      }
    }

    return var_4;
  }

  return "none";
}

function setspecialloadouts() {
  level.ref_11FB8["allies"]["loadoutPrimary"] = level.ref_11B3A.weapon;
  level.ref_11FB8["allies"]["loadoutPrimaryAttachment"] = "none";
  level.ref_11FB8["allies"]["loadoutPrimaryAttachment2"] = "none";
  level.ref_11FB8["allies"]["loadoutPrimaryCamo"] = "none";
  level.ref_11FB8["allies"]["loadoutPrimaryReticle"] = "none";
  level.ref_11FB8["allies"]["loadoutPrimaryAddBlueprintAttachments"] = scripts\engine\utility::ter_op(level.ref_11B3A.ref_11FBA != 0, 1, 0);
  level.ref_11FB8["allies"]["loadoutPrimaryVariantID"] = level.ref_11B3A.ref_11FBA;
  level.ref_11FB8["allies"]["loadoutSecondary"] = "none";
  level.ref_11FB8["allies"]["loadoutSecondaryAttachment"] = "none";
  level.ref_11FB8["allies"]["loadoutSecondaryAttachment2"] = "none";
  level.ref_11FB8["allies"]["loadoutSecondaryCamo"] = "none";
  level.ref_11FB8["allies"]["loadoutSecondaryReticle"] = "none";
  level.ref_11FB8["allies"]["loadoutSecondaryVariantID"] = 0;
  level.ref_11FB8["allies"]["loadoutEquipmentPrimary"] = "none";
  level.ref_11FB8["allies"]["loadoutEquipmentSecondary"] = "none";
  level.ref_11FB8["allies"]["loadoutStreakType"] = "assault";
  level.ref_11FB8["allies"]["loadoutKillstreak1"] = "none";
  level.ref_11FB8["allies"]["loadoutKillstreak2"] = "none";
  level.ref_11FB8["allies"]["loadoutKillstreak3"] = "none";
  level.aon_loadouts["allies"]["loadoutPerks"] = ["specialty_hustle"];
  level.ref_11FB8["allies"]["loadoutGesture"] = "playerData";
  level.ref_11FB8["allies"]["loadoutFieldUpgrade1"] = "super_deadsilence";
  level.ref_11FB8["allies"]["loadoutFieldUpgrade2"] = "none";
  level.ref_11FB8["axis"] = level.ref_11FB8["allies"];
}

function risk_flagspawnminradius(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = 0;

  foreach(var_7, var_5 in var_0) {
    if(var_5 > 0) {
      var_6 = 0;

      if(!var_6) {
        var_3 += var_5;
        var_1 = var_7;
        var_2 = var_3;
      }
    }
  }

  var_8 = randomint(var_3);
  var_7 = undefined;

  for(var_9 = 0; var_9 < var_1.size; var_9++) {
    var_3 = var_2[var_9];

    if(var_8 < var_3) {
      var_7 = var_1[var_9];
      break;
    }
  }

  return var_7;
}