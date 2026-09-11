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
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("dm", var0);
  scripts\mp\spawnlogic::registerspawnset("dm_fallback", var1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.blockweapondrops = 1;
  thread ref_12028();
  thread play_player_disguise_vo();
  thread onplayerconnect();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.ref_11b39 = scripts\mp\utility\dvars::dvarintvalue("initialAmmoCount", 1, 0, 15);
  level.ref_11b3c = scripts\mp\utility\dvars::dvarintvalue("killRewardAmmoCount", 1, 0, 15);
  level.ref_11b3b = scripts\mp\utility\dvars::dvarintvalue("oneShotKill", 1, 0, 1);
  level.ref_11b3a = spawnStruct();
  var0 = getDvar("scr_oic_weapon");
  level.ref_11b3a.ref_11df4 = var0;
  level.ref_11b3a.weapon = scripts\mp\utility\weapon::getweaponrootname(var0);
  level.ref_11b3a.ref_11fba = 0;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);
    var0.pers["class"] = "gamemode";
    var0.pers["lastClass"] = "";
    var0.class = var0.pers["class"];
    var0.lastclass = var0.pers["lastClass"];
    var0.pers["gamemodeLoadout"] = level.ref_11fb8["axis"];
    var0 loadweaponsforplayer([level.ref_11b3a.ref_11df4], 1);
    var0.ref_11fb5 = 1;
    var0.ref_11fb7 = 0;
  }
}

function getspawnpoint() {
  if(self.ref_11fb5) {
    thread ref_11da5();
  }

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

  var0 = scripts\mp\spawnlogic::getspawnpoint(self, "none", "dm", "dm_fallback");
  return var0;
}

function ref_11da5() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("graceperiod_done");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(5);

  if(!self.ref_11fb7) {
    scripts\mp\menus::addtoteam("spectator", 1);
    return;
  }
}

function onspawnplayer() {
  if(isDefined(self.ref_11fb9) && self.ref_11fb9) {
    scriptablenousestate();
  } else {
    self.ref_11fb9 = 0;
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
  var0 = weaponclipsize(self.primaryweapon);

  if(level.ref_11b39 > var0) {
    self setweaponammoclip(self.primaryweapon, var0);
    self setweaponammostock(self.primaryweapon, level.ref_11b39 - var0);

    if(self.primaryweapons[0] hasattachment("akimbo", 1)) {
      self setweaponammoclip(self.primaryweapon, level.ref_11b39 - var0, "left");
    }
  } else {
    self setweaponammoclip(self.primaryweapon, level.ref_11b39);
    self setweaponammostock(self.primaryweapon, 0);

    if(self.primaryweapons[0] hasattachment("akimbo", 1)) {
      self setweaponammoclip(self.primaryweapon, level.ref_11b39, "left");
    }
  }

  scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe("iw8_fists_mp");
  var1 = getcompleteweaponname("iw8_knifestab_mp");
  self giveweapon(var1);
  self assignweaponmeleeslot(var1);
  self.ref_11fb7 = 1;
  self setclientomnvar("ui_oic_lives", self.pers["lives"] + 1);
}

function ref_12606() {
  var0 = self.pers["lives"];

  if(var0 == 1) {
    scripts\mp\utility\dialog::leaderdialogonplayer("oic_lives_two");
    return;
  }

  if(var0 == 0) {
    var1 = scripts\engine\utility::ter_op(randomint(100) < 30, "oic_lives_last_alt", "oic_lives_last");
    scripts\mp\utility\dialog::leaderdialogonplayer(var1);
    return;
  }
}

function modifyplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(var4 == "MOD_PISTOL_BULLET" || var4 == "MOD_RIFLE_BULLET" || var4 == "MOD_HEAD_SHOT") {
    var3 = 999;
  }

  return var3;
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
  level.ref_13b93 = gettime();

  if(var1.pers["cur_kill_streak"] > var1 scripts\mp\utility\stats::getpersstat("killChains")) {
    var1.pers["killChains"] = var1.pers["cur_kill_streak"];
    var1 scripts\mp\utility\stats::setextrascore1(var1.pers["cur_kill_streak"]);
    return;
  }
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1) && isPlayer(var1) && self != var1) {
    if(isDefined(var3) && var3 == "MOD_EXECUTION") {
      var1.ref_11fb9 += level.ref_11b3c + 2;
    } else {
      var1.ref_11fb9 += level.ref_11b3c;
    }

    if(var1 attackButtonPressed()) {
      thread ref_14383();
    } else {
      scriptablenousestate(var1);
    }

    if(scripts\mp\utility\game::getgametypenumlives() && self.pers["deaths"] == scripts\mp\utility\game::getgametypenumlives()) {
      monitor_victim_cash_drops(var1);
    }

    if(var3 == "MOD_MELEE") {
      var1 scripts\mp\utility\stats::incpersstat("stabs", 1);
      var1 scripts\mp\persistence::statsetchild("round", "stabs", var1.pers["stabs"]);

      if(isPlayer(var1)) {
        var1 scripts\mp\utility\stats::setextrascore0(var1.pers["stabs"]);
      }
    }

    if(scripts\mp\utility\game::matchmakinggame()) {
      foreach(var11 in level.players) {
        if(isDefined(var11.sessionstate) && (var11.sessionstate == "spectator" || var11.sessionstate == "spectating")) {
          var12 = var11 getspectatingplayer();

          if(isDefined(var12) && isDefined(var1) && var12 == var1) {
            var11 playlocalsound("mp_bombplaced_friendly");
            var13 = scripts\mp\rank::getscoreinfovalue("kill_bonus");
            var11 thread scripts\mp\rank::giverankxp("kill_bonus", var13);
            var11 setclientomnvar("ui_oic_wager", gettime());
          }
        }
      }

      return;
    }

    return;
  }
}

function onplayerscore(var0, var1, var2, var3) {
  var1 scripts\mp\utility\stats::incpersstat("gamemodeScore", var2);
  var4 = int(var1 scripts\mp\utility\stats::getpersstat("gamemodeScore"));
  var1 scripts\mp\persistence::statsetchild("round", "gamemodeScore", var4);

  if(issubstr(var0, "super_")) {
    return 0;
  }

  if(issubstr(var0, "kill_ss")) {
    return 0;
  }

  if(issubstr(var0, "kill")) {
    var5 = scripts\mp\rank::getscoreinfovalue("score_increment");
    return var5;
  } else if(var1 == "assist_ffa") {
    var2 scripts\mp\utility\script::bufferednotify("earned_score_buffered", var3);
  }

  return 0;
}

function onsuicidedeath(var0) {
  if(scripts\mp\utility\game::getgametypenumlives() && var0.pers["deaths"] == scripts\mp\utility\game::getgametypenumlives()) {
    monitor_victim_cash_drops(var0);
    return;
  }
}

function ononeleftevent(var0) {
  var1 = scripts\mp\utility\game::getlastlivingplayer();
  logstring("last one alive, win: " + var1.name);
  level.finalkillcam_winner = "none";
  level thread scripts\mp\gamelogic::endgame(var1, game["end_reason"]["enemies_eliminated"], game["end_reason"]["br_eliminated"]);
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
  var0 = self.primaryweapon;
  var1 = self getweaponammostock(var0);
  var2 = self getweaponammoclip(var0);
  var3 = weaponclipsize(var0);

  if(var2 + self.ref_11fb9 > var3) {
    self setweaponammoclip(var0, var3);
    self setweaponammostock(var0, var1 + var2 + self.ref_11fb9 - var3);

    if(isDefined(self.primaryweapons[0]) && self.primaryweapons[0] hasattachment("akimbo", 1)) {
      var4 = self getweaponammoclip(var0, "left");
      self setweaponammoclip(var0, var1 + var4 + self.ref_11fb9 - var3, "left");
    }
  } else {
    self setweaponammoclip(var0, var2 + self.ref_11fb9);

    if(isDefined(self.primaryweapons[0]) && self.primaryweapons[0] hasattachment("akimbo", 1)) {
      var4 = self getweaponammoclip(var0, "left");
      self setweaponammoclip(var0, var4 + self.ref_11fb9, "left");
    }
  }

  self playlocalsound("scavenger_pack_pickup");
  self.ref_11fb9 = 0;
}

function monitor_victim_cash_drops(var0) {
  thread scripts\mp\hud_message::showsplash("out_of_lives");
  thread scripts\mp\hud_util::teamplayercardsplash("callout_eliminated", self);

  if(isDefined(var0)) {
    var0 thread scripts\mp\hud_message::showsplash("target_eliminated");
    var0 thread scripts\mp\events::killeventtextpopup("target_eliminated", 0);
  }

  var1 = [];

  foreach(var3 in level.players) {
    if(var3.pers["deaths"] < scripts\mp\utility\game::getgametypenumlives() && var3.ref_11fb7) {
      var1 = var3;
      var3 scripts\mp\utility\points::giveunifiedpoints("survivor");
    }
  }

  if(var1.size > 2) {
    scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
  } else if(var1.size == 2) {
    scripts\mp\utility\sound::playsoundonplayers("mp_obj_captured");
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", var1[0], var1[1].team);
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", var1[1], var1[0].team);
  }

  scripts\mp\utility\dialog::leaderdialogonplayers("oic_enemy_eliminated", level.players);
}

function ref_126e7(var0) {
  level endon("game_ended");
  self endon("disconnect");

  while(scripts\mp\utility\player::isinkillcam()) {
    waitframe();
  }

  self notifyonplayercommand("selected_player", "+usereload");
  self notifyonplayercommand("selected_player", "+activate");

  for(;;) {
    self waittill("selected_player");
    var1 = self getspectatingplayer();

    if(isDefined(var1)) {
      self.ref_14314 = var1.name;
      self playlocalsound("recondrone_tag_plr");
    }
  }
}

function play_player_disguise_vo() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("graceperiod_done");
  var0 = undefined;
  jumpiffalse(scripts\mp\utility\game::matchmakinggame()) LOC_00000033;
  var0 = getdvarint("scr_oic_finalUAVTime", 5);

  for(;;) {
    var1 = [];

    foreach(var3 in level.players) {
      if(var3.pers["deaths"] < scripts\mp\utility\game::getgametypenumlives() && var3.ref_11fb7) {
        var1 = var3;
      }
    }

    if(var1.size < 4) {
      level notify("end_one_off_sweeps");

      foreach(var3 in level.players) {
        if(scripts\mp\utility\player::isreallyalive(var3)) {
          triggeroneoffradarsweep(var3);
        }
      }

      wait scripts\engine\utility::ter_op(isDefined(var0), var0, 5);
    }

    wait 0.5;
  }
}

function ref_12028() {
  level endon("game_ended");
  level endon("end_one_off_sweeps");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.ref_13b93 = gettime();
  var0 = undefined;
  var1 = undefined;

  if(scripts\mp\utility\game::matchmakinggame()) {
    var0 = getdvarint("scr_oic_noKillsUAVTime", 15);
    var1 = getdvarint("scr_oic_timeBetweenSweeps", 5);
  }

  var2 = scripts\engine\utility::ter_op(isDefined(var0), var0, 30);
  var2 *= 1000;
  var3 = scripts\engine\utility::ter_op(isDefined(var1), var1, 15);

  for(;;) {
    if(gettime() > level.ref_13b93 + var2) {
      foreach(var5 in level.players) {
        if(scripts\mp\utility\player::isreallyalive(var5)) {
          triggeroneoffradarsweep(var5);
        }
      }

      wait var3;
    }

    wait 1;
  }
}

function ref_13158() {
  if(scripts\mp\utility\game::matchmakinggame() && getdvarint("scr_oic_randomWeapon", 2) > 0) {
    var0 = getrandomweapon(getdvarint("scr_oic_randomWeapon", 2));
    level.ref_11b3a.weapon = var0["weapon"];
    level.ref_11b3a.ref_11fba = var0["variantID"];
  }

  if(!isDefined(level.ref_11b3a.weapon) || level.ref_11b3a.weapon == "none") {
    level.ref_11b3a.weapon = "iw8_pi_golf21";
  }

  var1 = tv_station_boss_should_break_stealth_immediately();

  if(var1 > 1) {
    level.ref_11b39 *= var1;
    level.ref_11b3c *= var1;
    return;
  }
}

function tv_station_boss_should_break_stealth_immediately() {
  switch (level.ref_11b3a.weapon) {
    case "iw8_ar_falpha":
      return 3;
    case "iw8_pi_mike9":
      if(level.ref_11b3a.ref_11fba == 1) {
        return 3;
      }
    case "iw8_ar_falima":
      if(level.ref_11b3a.ref_11fba == 6 || level.ref_11b3a.ref_11fba == 9) {
        return 3;
      }
    case "iw8_sm_smgolf45":
      if(level.ref_11b3a.ref_11fba == 2) {
        return 2;
      }
    default:
      return 1;
  }
}

function getrandomweapon(var0) {
  level.ref_11fb6 = spawnStruct();
  level.ref_11fb6.ref_1457d = [];
  level.ref_11fb6.ref_1457d["rand_pistol"] = 80;
  level.ref_11fb6.ref_1457d["rand_smg"] = 40;
  level.ref_11fb6.ref_1457d["rand_assault"] = 40;
  level.ref_11fb6.ref_1457d["rand_lmg"] = 25;
  level.ref_11fb6.ref_1457d["rand_sniper"] = 40;
  buildrandomweapontable();

  if(var0 == 2) {
    level.ref_11fb6.ref_1457d["rand_pistol"] = 100;
    level.ref_11fb6.ref_1457d["rand_smg"] = 0;
    level.ref_11fb6.ref_1457d["rand_assault"] = 0;
    level.ref_11fb6.ref_1457d["rand_lmg"] = 0;
    level.ref_11fb6.ref_1457d["rand_sniper"] = 0;
  } else if(var0 == 3) {
    level.ref_11fb6.ref_1457d["rand_pistol"] = 0;
    level.ref_11fb6.ref_1457d["rand_smg"] = 0;
    level.ref_11fb6.ref_1457d["rand_assault"] = 0;
    level.ref_11fb6.ref_1457d["rand_lmg"] = 0;
    level.ref_11fb6.ref_1457d["rand_sniper"] = 100;
  } else if(var0 == 4) {
    level.ref_11fb6.ref_1457d["rand_pistol"] = 0;
    level.ref_11fb6.ref_1457d["rand_smg"] = 100;
    level.ref_11fb6.ref_1457d["rand_assault"] = 0;
    level.ref_11fb6.ref_1457d["rand_lmg"] = 0;
    level.ref_11fb6.ref_1457d["rand_sniper"] = 0;
  } else if(var0 == 5) {
    level.ref_11fb6.ref_1457d["rand_pistol"] = 0;
    level.ref_11fb6.ref_1457d["rand_smg"] = 0;
    level.ref_11fb6.ref_1457d["rand_assault"] = 100;
    level.ref_11fb6.ref_1457d["rand_lmg"] = 0;
    level.ref_11fb6.ref_1457d["rand_sniper"] = 0;
  } else if(var0 == 6) {
    level.ref_11fb6.ref_1457d["rand_pistol"] = 0;
    level.ref_11fb6.ref_1457d["rand_smg"] = 0;
    level.ref_11fb6.ref_1457d["rand_assault"] = 0;
    level.ref_11fb6.ref_1457d["rand_lmg"] = 100;
    level.ref_11fb6.ref_1457d["rand_sniper"] = 0;
  } else if(var0 == 7) {
    level.ref_11fb6.ref_1457d["rand_pistol"] = 0;
    level.ref_11fb6.ref_1457d["rand_smg"] = 0;
    level.ref_11fb6.ref_1457d["rand_assault"] = 0;
    level.ref_11fb6.ref_1457d["rand_lmg"] = 100;
    level.ref_11fb6.ref_1457d["rand_sniper"] = 50;
  }

  var1 = risk_flagspawnminradius(level.ref_11fb6.ref_1457d);
  var2 = getrandomweaponfromcategory(var1);
  return var2;
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

    var2 = [];
    var2 = tablelookupbyrow("mp/gunGameWeapons.csv", var0, 1);
    var2 = int(tablelookupbyrow("mp/gunGameWeapons.csv", var0, 2));
    var2 = int(tablelookupbyrow("mp/gunGameWeapons.csv", var0, 3));
    var2 = int(tablelookupbyrow("mp/gunGameWeapons.csv", var0, 8));

    if(!var2["allowed"]) {
      var0++;
      continue;
    }

    var3 = scripts\mp\gametypes\gun::remappedhpzoneorder(var2["weapon"]);
    var2 = scripts\mp\class::ref_139e7(var2["weapon"], var3);
    level.weaponcategories[var1][level.weaponcategories[var1].size] = var2;
  }
}

function getrandomweaponfromcategory(var0) {
  var1 = [];
  var2 = level.weaponcategories[var0];

  if(isDefined(var2) && var2.size > 0) {
    var3 = "";
    var4 = undefined;

    for(var5 = 0;; var5++) {
      var6 = randomintrange(0, var2.size);
      var4 = var2[var6];
      var7 = scripts\mp\utility\weapon::getweaponrootname(var4["weapon"]);

      if(!isDefined(var1[var7]) || var5 > var2.size) {
        var1 = 1;

        for(var8 = 0; var8 < level.weaponcategories[var0].size; var8++) {
          if(level.weaponcategories[var0][var8]["weapon"] == var4["weapon"]) {
            level.weaponcategories[var0] = scripts\engine\utility::array_remove_index(level.weaponcategories[var0], var8);
            break;
          }
        }

        break;
      }
    }

    return var4;
  }

  return "none";
}

function setspecialloadouts() {
  level.ref_11fb8["allies"]["loadoutPrimary"] = level.ref_11b3a.weapon;
  level.ref_11fb8["allies"]["loadoutPrimaryAttachment"] = "none";
  level.ref_11fb8["allies"]["loadoutPrimaryAttachment2"] = "none";
  level.ref_11fb8["allies"]["loadoutPrimaryCamo"] = "none";
  level.ref_11fb8["allies"]["loadoutPrimaryReticle"] = "none";
  level.ref_11fb8["allies"]["loadoutPrimaryAddBlueprintAttachments"] = scripts\engine\utility::ter_op(level.ref_11b3a.ref_11fba != 0, 1, 0);
  level.ref_11fb8["allies"]["loadoutPrimaryVariantID"] = level.ref_11b3a.ref_11fba;
  level.ref_11fb8["allies"]["loadoutSecondary"] = "none";
  level.ref_11fb8["allies"]["loadoutSecondaryAttachment"] = "none";
  level.ref_11fb8["allies"]["loadoutSecondaryAttachment2"] = "none";
  level.ref_11fb8["allies"]["loadoutSecondaryCamo"] = "none";
  level.ref_11fb8["allies"]["loadoutSecondaryReticle"] = "none";
  level.ref_11fb8["allies"]["loadoutSecondaryVariantID"] = 0;
  level.ref_11fb8["allies"]["loadoutEquipmentPrimary"] = "none";
  level.ref_11fb8["allies"]["loadoutEquipmentSecondary"] = "none";
  level.ref_11fb8["allies"]["loadoutStreakType"] = "assault";
  level.ref_11fb8["allies"]["loadoutKillstreak1"] = "none";
  level.ref_11fb8["allies"]["loadoutKillstreak2"] = "none";
  level.ref_11fb8["allies"]["loadoutKillstreak3"] = "none";
  level.aon_loadouts["allies"]["loadoutPerks"] = ["specialty_hustle"];
  level.ref_11fb8["allies"]["loadoutGesture"] = "playerData";
  level.ref_11fb8["allies"]["loadoutFieldUpgrade1"] = "super_deadsilence";
  level.ref_11fb8["allies"]["loadoutFieldUpgrade2"] = "none";
  level.ref_11fb8["axis"] = level.ref_11fb8["allies"];
}

function risk_flagspawnminradius(var0) {
  var1 = [];
  var2 = [];
  var3 = 0;

  foreach(var7, var5 in var0) {
    if(var5 > 0) {
      var6 = 0;

      if(!var6) {
        var3 += var5;
        var1 = var7;
        var2 = var3;
      }
    }
  }

  var8 = randomint(var3);
  var7 = undefined;

  for(var9 = 0; var9 < var1.size; var9++) {
    var3 = var2[var9];

    if(var8 < var3) {
      var7 = var1[var9];
      break;
    }
  }

  return var7;
}