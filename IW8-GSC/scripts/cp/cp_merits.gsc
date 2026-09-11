/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_merits.gsc
***********************************************/

function init() {
  precachestring(&"CP_MERIT_COMPLETED");

  if(!mayprocessmerits()) {
    return;
  }

  level.meritcallbacks = [];
  registermeritcallback("enemyKilled", &mt_kills);
  thread onplayerconnect();
}

function mayprocessmerits() {
  return false;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["postGameMerits"])) {
      var_0.pers["postGameMerits"] = 0;
    }

    thread initmeritdata();
    thread monitoradstime();
    LOC_00000047:
  }
}

function initmeritdata() {
  self.pers["lastBulletKillTime"] = 0;
  self.pers["bulletStreak"] = 0;
  self.explosiveinfo = [];
}

function registermeritcallback(var_0, var_1) {
  if(!isDefined(level.meritcallbacks[var_0])) {
    level.meritcallbacks[var_0] = [];
  }

  level.meritcallbacks[var_0][level.meritcallbacks[var_0].size] = var_1;
}

function getmeritstatus(var_0) {
  if(isDefined(self.meritdata[var_0])) {
    return self.meritdata[var_0];
  }

  return 0;
}

function mt_kills(var_0, var_1) {
  var_2 = var_0.attacker;
  var_3 = var_0.victim;

  if(!isDefined(var_2) || !isPlayer(var_2)) {
    return;
  }

  processmerit(var_2, "mt_kills");
}

function enemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("disconnect");
  var_8 = spawnStruct();
  var_8.victim = self;
  var_8.einflictor = var_0;
  var_8.attacker = var_1;
  var_8.idamage = var_2;
  var_8.smeansofdeath = var_3;
  var_8.sweapon = var_4;
  var_8.sprimaryweapon = var_5;
  var_8.shitloc = var_6;
  var_8.time = gettime();
  var_8.modifiers = var_7;
  var_8.victimonground = var_8.victim isonground();
  domeritcallback("enemyKilled", var_8);
  var_8.attacker notify("playerKilledMeritsProcessed");
}

function domeritcallback(var_0, var_1) {
  if(!mayprocessmerits()) {
    return;
  }

  if(isDefined(var_1)) {
    var_2 = var_1.player;

    if(!isDefined(var_2)) {
      var_2 = var_1.attacker;
    }

    if(isDefined(var_2) && isai(var_2)) {
      return;
    }
  }

  if(getdvarint("disable_merits") > 0) {
    return;
  }

  if(!isDefined(level.meritcallbacks[var_0])) {
    return;
  }

  if(isDefined(var_1)) {
    var_3 = 0;

    if(var_3 < level.meritcallbacks[var_0].size) {
      GscBinSkip1(0x74, level.meritcallbacks[var_0][var_3], var_1);
    }

    return;
  }

  var_3 = 0;

  if(var_3 < level.meritcallbacks[var_1].size) {
    GscBinSkip1(0x74, level.meritcallbacks[var_1][var_3]);
  }
}

function process_agent_on_killed_merits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1)) {
    return;
  }

  if(!isPlayer(var_1)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1 = var_1.owner;
    } else {
      return;
    }
  }

  var_9 = scripts\cp\utility::getweaponclass(var_4);
  var_10 = istrue(var_1.inlaststand);
  var_11 = scripts\engine\utility::isbulletdamage(var_3);
  var_12 = var_1 getstance();
  var_13 = self.species;
  var_14 = var_12 == "crouch";
  var_15 = var_12 == "prone" && !var_10;
  var_16 = isexplosivedamagemod(var_3);
  var_17 = var_3 == "MOD_MELEE";
  var_18 = (istrue(self.is_burning) || istrue(self.is_chem_burning)) && (!var_11 || var_4.basename == "incendiary_ammo_mp");
  var_19 = istrue(self.dismember_crawl);
  var_20 = istrue(self.shockmelee);
  var_21 = var_1 issprintsliding();
  var_22 = istrue(self.faf_burned_out);

  if(isDefined(var_0.owner)) {
    var_23 = var_1 scripts\cp\utility::is_trap(var_0, var_4) && var_0.owner == var_1;
  } else {
    var_23 = var_2 scripts\cp\utility::is_trap(var_1, var_5);
  }

  var_24 = 0;

  if(isDefined(level.all_magic_weapons)) {
    foreach(var_26 in getarraykeys(level.all_magic_weapons)) {
      if(scripts\cp\utility::getrawbaseweaponname(var_5) == var_26) {
        var_24 = 1;
        break;
      }
    }
  }

  var_28 = isDefined(var_5) && (var_5.basename == "iw7_dischorddummy_zm" || var_5.basename == "iw7_facemelterdummy_zm" || var_5.basename == "iw7_headcutterdummy_zm" || var_5.basename == "iw7_shredderdummy_zm");
  var_29 = undefined;

  if(isDefined(var_5)) {
    var_29 = scripts\cp\utility::getrawbaseweaponname(var_5);
  }

  var_30 = isDefined(var_29) && (var_29 == "harpoon1" || var_29 == "harpoon2" || var_29 == "harpoon3" || var_29 == "harpoon4");

  if(var_24) {
    if(issubstr(var_5.basename, "g18_")) {
      var_24 = isDefined(var_2.has_replaced_starting_pistol);
    }
  }

  if(var_17) {
    if(issubstr(var_5.basename, "shuriken")) {
      var_17 = 0;
    } else if(istrue(var_2.kung_fu_mode)) {
      var_17 = 0;
    }
  }

  var_31 = var_5.classname == "weapon_sniper" && var_12;
  var_32 = var_12 && scripts\cp\utility::isheadshot(var_5, var_7, var_4, var_2);

  if(!var_18) {
    switch (var_10) {
      case "weapon_assault":
        processmerit(var_2, "mt_ar_kills");
        break;
      case "weapon_smg":
        processmerit(var_2, "mt_smg_kills");
        break;
      case "weapon_lmg":
        processmerit(var_2, "mt_lmg_kills");
        break;
      case "weapon_shotgun":
        processmerit(var_2, "mt_shotgun_kills");
        break;
      case "weapon_sniper":
        processmerit(var_2, "mt_sniper_kills");
        break;
      case "weapon_pistol":
        processmerit(var_2, "mt_pistol_kills");
        break;
      case "other":
        if(var_28) {
          processmerit(var_2, "mt_pistol_kills");
        }

        break;
      default:
        break;
    }
  }

  switch (var_14) {
    case "zombie":
      processmerit(var_2, "mt_zombie_kills");
      break;
    default:
      break;
  }

  if(var_17) {
    processmerit(var_2, "mt_explosive_kills");
  }

  if(var_18) {
    processmerit(var_2, "mt_melee_kills");
  }

  if(var_19) {
    processmerit(var_2, "mt_fire_kills");
  }

  if(var_23) {
    processmerit(var_2, "mt_trap_kills");
  }

  if(var_24) {
    processmerit(var_2, "mt_magic_weapon_kills");
  }

  if(var_32) {
    processmerit(var_2, "mt_headshot_kills");
  }

  if(var_20) {
    processmerit(var_2, "mt_crawler_kills");
  }

  if(var_21) {
    processmerit(var_2, "mt_faf_shock_melee_kills");
  }

  if(var_22) {
    processmerit(var_2, "mt_sliding_kills");
  }

  if(var_28 || var_30) {
    processmerit(var_2, "mt_quest_weapon_kills");
  }

  if(var_23 && var_19) {
    processmerit(var_2, "mt_faf_burned_out_kills");
  }

  var_33 = var_5.basename;

  if(getDvar("NSQLTTMRMP") == "cp_rave") {
    if(isDefined(self.agent_type) && self.agent_type == "zombie_sasquatch") {
      processmerit(var_2, "mt_dlc1_sasquatch_kills");
    }

    if(var_18) {
      if(var_33 == "iw7_golf_club_mp" || var_33 == "iw7_golf_club_mp_pap1" || var_33 == "iw7_golf_club_mp_pap2") {
        processmerit(var_2, "mt_dlc1_golf_kills");
      } else if(var_33 == "iw7_spiked_bat_mp" || var_33 == "iw7_spiked_bat_mp_pap1" || var_33 == "iw7_spiked_bat_mp_pap2") {
        processmerit(var_2, "mt_dlc1_bat_kills");
      } else if(var_33 == "iw7_machete_mp" || var_33 == "iw7_machete_mp_pap1" || var_33 == "iw7_machete_mp_pap2") {
        processmerit(var_2, "mt_dlc1_machete_kills");
      } else if(var_33 == "iw7_two_headed_axe_mp" || var_33 == "iw7_two_headed_axe_mp_pap1" || var_33 == "iw7_two_headed_axe_mp_pap2") {
        processmerit(var_2, "mt_dlc1_axe_kills");
      } else if(var_33 == "iw7_lawnmower_zm") {
        processmerit(var_2, "mt_dlc1_lawnmower_kills");
      }
    }

    if(issubstr(var_33, "harpoon")) {
      processmerit(var_2, "mt_dlc1_harpoon_kills");
    }

    if(istrue(var_2.rave_mode)) {
      processmerit(var_2, "mt_dlc1_kills_in_rave");
    }
  }

  if(getDvar("NSQLTTMRMP") == "cp_disco") {
    if(var_33 == "iw7_katana_zm_pap2+camo222" || var_33 == "iw7_katana_windforce_zm") {
      processmerit(var_2, "mt_dlc2_pap2_katana");
    } else if(var_33 == "iw7_nunchucks_zm_pap2+camo222") {
      processmerit(var_2, "mt_dlc2_pap2_nunchucks");
    } else if(var_33 == "heart_cp") {
      processmerit(var_2, "mt_dlc2_heart_kills");
    }

    if(isDefined(self.agent_type) && self.agent_type == "skater") {
      processmerit(var_2, "mt_dlc2_roller_skaters");
    }

    if(var_23) {
      processmerit(var_2, "mt_dlc2_trap_kills");
      return;
    }

    if(istrue(var_2.kung_fu_mode) && !is_crafted_trap_damage(var_33)) {
      if(var_2.kungfu_style == "dragon") {
        processmerit(var_2, "mt_dlc2_dragon_kills");
        return;
      }

      if(var_2.kungfu_style == "crane") {
        processmerit(var_2, "mt_dlc2_crane_kills");
        return;
      }

      if(var_2.kungfu_style == "snake") {
        processmerit(var_2, "mt_dlc2_snake_kills");
        return;
      }

      if(var_2.kungfu_style == "tiger") {
        processmerit(var_2, "mt_dlc2_tiger_kills");
        return;
      }

      return;
    }

    return;
  }
}

function is_crafted_trap_damage(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  switch (var_0) {
    case "alien_sentry_minigun_4_mp":
    case "iw7_robotzap_zm":
    case "zmb_robotprojectile_mp":
    case "incendiary_ammo_mp":
    case "iw7_electrictrap_zm":
      return true;
  }

  return false;
}

function processmerit(var_0, var_1, var_2) {
  if(!mayprocessmerits()) {
    return;
  }

  if(!isPlayer(self) || isai(self)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!havedataformerit(var_0)) {
    return;
  }

  var_3 = getmeritstatus(var_0);

  if(var_3 == 5) {
    return;
  }

  var_4 = isDefined(level.meritinfo[var_0]["operation"]);

  if(var_3 > level.meritinfo[var_0]["targetval"].size) {
    var_5 = var_3 == level.meritinfo[var_0]["targetval"].size + 1;
    var_6 = isDefined(self.operationsmaxed) && isDefined(self.operationsmaxed[var_0]);

    if(var_5 && !var_6) {
      var_3 = level.meritinfo[var_0]["targetval"].size;
    } else {
      return;
    }
  }

  var_7 = scripts\cp\cp_hud_util::mt_getprogress(var_0);
  var_8 = level.meritinfo[var_0]["targetval"][var_3];

  if(!isDefined(var_8)) {
    return;
  }

  if(isDefined(var_2) && var_2) {
    var_9 = var_1;
  } else {
    var_9 = var_8 + var_2;
  }

  var_10 = 0;

  if(var_9 >= var_9) {
    var_11 = 1;
    var_10 = var_9 - var_9;
    var_9 = var_9;
  } else {
    var_11 = 0;
  }

  if(var_9 < var_10) {
    scripts\cp\cp_hud_util::mt_setprogress(var_2, var_10);
  }

  if(var_11) {
    thread giverankxpafterwait(var_2, var_7);
    storecompletedmerit(var_2);
    givemeritscore(level.meritinfo[var_2]["score"][var_7]);
    var_7++;
    scripts\cp\cp_hud_util::mt_setstate(var_2, var_7);
    self.meritdata[var_2] = var_7;
    thread scripts\cp\cp_hud_message::showchallengesplash(var_2);

    if(areallmerittierscomplete(var_2)) {
      processmastermerit(var_2);
      return;
    }

    return;
  }
}

function areallmerittierscomplete(var_0) {
  if(self.meritdata[var_0] >= level.meritinfo[var_0]["targetval"].size) {
    return true;
  }

  return false;
}

function get_table_name() {
  return "mp/splashtable.csv";
}

function storecompletedmerit(var_0) {
  if(!isDefined(self.meritscompleted)) {
    self.meritscompleted = [];
  }

  var_1 = 0;

  foreach(var_3 in self.meritscompleted) {
    if(var_3 == var_0) {
      var_1 = 1;
    }
  }

  if(!var_1) {
    self.meritscompleted[self.meritscompleted.size] = var_0;
    return;
  }
}

function storecompletedoperation(var_0) {
  if(!isDefined(self.operationscompleted)) {
    self.operationscompleted = [];
  }

  var_1 = 0;

  foreach(var_3 in self.operationscompleted) {
    if(var_3 == var_0) {
      var_1 = 1;
      break;
    }
  }

  if(!var_1) {
    self.operationscompleted[self.operationscompleted.size] = var_0;
    return;
  }
}

function giverankxpafterwait(var_0, var_1) {
  self endon("disconnect");
  wait 0.25;
  scripts\cp\cp_persistence::give_player_xp(int(level.meritinfo[var_0]["reward"][var_1]));
  scripts\cp\drone\emp_drone::giverankxp(var_0, level.meritinfo[var_0]["reward"][var_1], undefined);
}

function givemeritscore(var_0) {
  var_1 = self getplayerdata("cp", "challengeScore");

  if(isDefined(var_1)) {
    self setplayerdata("cp", "challengeScore", var_1 + var_0);
    return;
  }
}

function updatemerits() {
  self.meritdata = [];
  self endon("disconnect");

  if(!mayprocessmerits()) {
    return;
  }

  var_0 = 0;

  foreach(var_5, var_2 in level.meritinfo) {
    var_0++;

    if(var_0 % 20 == 0) {
      wait 0.05;
    }

    self.meritdata[var_5] = 0;
    var_3 = var_2["index"];
    var_4 = scripts\cp\cp_hud_util::mt_getstate(var_5);
    self.meritdata[var_5] = var_4;
  }
}

function getmeritfilter(var_0) {
  return tablelookup("cp/allMeritsTable.csv", 0, var_0, 5);
}

function isweaponmerit(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = getmeritfilter(var_0);

  if(isDefined(var_1)) {
    return true;
  }

  return false;
}

function getweaponfrommerit(var_0) {
  return getmeritfilter(var_0);
}

function isoperationmerit(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = getmeritfilter(var_0);

  if(isDefined(var_1)) {
    if(var_1 == "perk_slot_0" || var_1 == "perk_slot_1" || var_1 == "perk_slot_2" || var_1 == "proficiency" || var_1 == "equipment" || var_1 == "special_equipment" || var_1 == "attachment" || var_1 == "prestige" || var_1 == "final_killcam" || var_1 == "basic" || var_1 == "humiliation" || var_1 == "precision" || var_1 == "revenge" || var_1 == "elite" || var_1 == "intimidation" || var_1 == "operations" || scripts\cp\utility::isstrstart(var_1, "killstreaks_")) {
      return true;
    }
  }

  if(isweaponmerit(var_0)) {
    return true;
  }

  return false;
}

function merit_targetval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 10 + var_2 * 3);
  return int(var_3);
}

function merit_rewardval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 11 + var_2 * 3);
  return int(var_3);
}

function merit_scoreval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 12 + var_2 * 3);
  return int(var_3);
}

function buildmerittableinfo(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  for(var_2 = 0;; var_2++) {
    var_4 = tablelookupbyrow(var_0, var_2, 0);

    if(var_4 == "") {
      break;
    }

    var_5 = getmeritmasterchallenge(var_4);
    level.meritinfo[var_4] = [];
    level.meritinfo[var_4]["index"] = var_2;
    level.meritinfo[var_4]["type"] = var_1;
    level.meritinfo[var_4]["targetval"] = [];
    level.meritinfo[var_4]["reward"] = [];
    level.meritinfo[var_4]["score"] = [];
    level.meritinfo[var_4]["filter"] = getmeritfilter(var_4);
    level.meritinfo[var_4]["master"] = var_5;

    if(isoperationmerit(var_4)) {
      level.meritinfo[var_4]["operation"] = 1;
      level.meritinfo[var_4]["spReward"] = [];

      if(isweaponmerit(var_4)) {
        var_6 = getweaponfrommerit(var_4);

        if(isDefined(var_6)) {
          level.meritinfo[var_4]["weapon"] = var_6;
        }
      }
    }

    for(var_7 = 0; var_7 < 5; var_7++) {
      var_8 = merit_targetval(var_0, var_4, var_7);
      var_9 = merit_rewardval(var_0, var_4, var_7);
      var_10 = merit_scoreval(var_0, var_4, var_7);

      if(var_8 == 0) {
        break;
      }

      level.meritinfo[var_4]["targetval"][var_7] = var_8;
      level.meritinfo[var_4]["reward"][var_7] = var_9;
      level.meritinfo[var_4]["score"][var_7] = var_10;
      var_3 += var_9;
    }

    var_4 = tablelookupbyrow(var_0, var_2, 0);
  }

  return int(var_3);
}

function buildmeritinfo() {
  level.meritinfo = [];
  var_0 = 0;
  var_0 += buildmerittableinfo("cp/allMeritsTable.csv", 0);
}

function ismeritunlocked(var_0) {
  var_1 = level.meritinfo[var_0]["filter"];

  if(!isDefined(var_1)) {
    return 1;
  }

  return self isitemunlocked(var_1, "challenge");
}

function havedataformerit(var_0) {
  return isDefined(level.meritinfo) && isDefined(level.meritinfo[var_0]);
}

function getmeritmasterchallenge(var_0) {
  var_1 = tablelookup("cp/allMeritsTable.csv", 0, var_0, 7);

  if(isDefined(var_1) && var_1 == "") {
    return undefined;
  }

  return var_1;
}

function processmastermerit(var_0) {
  var_1 = level.meritinfo[var_0]["master"];

  if(isDefined(var_1)) {
    thread processmerit(var_1);
    return;
  }
}

function monitoradstime() {
  self endon("disconnect");
  self.adstime = 0;

  for(;;) {
    if(self playerads() == 1) {
      self.adstime += 0.05;
    } else {
      self.adstime = 0;
    }

    wait 0.05;
  }
}