/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2654.gsc
**************************************/

init() {
  precachestring(&"CP_MERIT_COMPLETED");

  if(!mayprocessmerits()) {
    return;
  }
  level.meritcallbacks = [];
  registermeritcallback("enemyKilled", ::mt_kills);
  level thread onplayerconnect();
}

mayprocessmerits() {
  if(level.onlinegame) {
    return 1;
  }

  return 0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["postGameMerits"])) {
      var_0.pers["postGameMerits"] = 0;
    }

    var_0 thread initmeritdata();

    if(isai(var_0)) {
      continue;
    }
    var_0 thread monitoradstime();
  }
}

initmeritdata() {
  self.pers["lastBulletKillTime"] = 0;
  self.pers["bulletStreak"] = 0;
  self.explosiveinfo = [];
}

registermeritcallback(var_0, var_1) {
  if(!isDefined(level.meritcallbacks[var_0])) {
    level.meritcallbacks[var_0] = [];
  }

  level.meritcallbacks[var_0][level.meritcallbacks[var_0].size] = var_1;
}

getmeritstatus(var_0) {
  if(isDefined(self.meritdata[var_0])) {
    return self.meritdata[var_0];
  } else {
    return 0;
  }
}

mt_kills(var_0, var_1) {
  var_2 = var_0.attacker;
  var_3 = var_0.victim;

  if(!isDefined(var_2) || !isplayer(var_2)) {
    return;
  }
  var_2 processmerit("mt_kills");
}

enemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
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

domeritcallback(var_0, var_1) {
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
    for(var_3 = 0; var_3 < level.meritcallbacks[var_0].size; var_3++) {
      thread[[level.meritcallbacks[var_0][var_3]]](var_1);
    }
  } else {
    for(var_3 = 0; var_3 < level.meritcallbacks[var_0].size; var_3++) {
      thread[[level.meritcallbacks[var_0][var_3]]]();
    }
  }
}

process_agent_on_killed_merits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isplayer(var_1)) {
    if(isDefined(var_1.owner) && isplayer(var_1.owner)) {
      var_1 = var_1.owner;
    } else {
      return;
    }
  }

  var_9 = scripts\cp\utility::getweaponclass(var_4);
  var_10 = scripts\engine\utility::is_true(var_1.inlaststand);
  var_11 = scripts\engine\utility::isbulletdamage(var_3);
  var_12 = var_1 getstance();
  var_13 = self.species;
  var_14 = var_12 == "crouch";
  var_15 = var_12 == "prone" && !var_10;
  var_16 = isexplosivedamagemod(var_3);
  var_17 = var_3 == "MOD_MELEE";
  var_18 = (scripts\engine\utility::is_true(self.is_burning) || scripts\engine\utility::is_true(self.is_chem_burning)) && (!var_11 || var_4 == "incendiary_ammo_mp");
  var_19 = scripts\engine\utility::is_true(self.dismember_crawl);
  var_20 = scripts\engine\utility::is_true(self.shockmelee);
  var_21 = var_1 issprintsliding();
  var_22 = scripts\engine\utility::is_true(self.faf_burned_out);

  if(isDefined(var_0.owner)) {
    var_23 = var_1 scripts\cp\utility::is_trap(var_0, var_4) && var_0.owner == var_1;
  } else {
    var_23 = var_1 scripts\cp\utility::is_trap(var_0, var_4);
  }

  var_24 = 0;

  foreach(var_26 in getarraykeys(level.all_magic_weapons)) {
    if(scripts\cp\utility::getrawbaseweaponname(var_4) == var_26) {
      var_24 = 1;
      break;
    }
  }

  var_28 = isDefined(var_4) && (var_4 == "iw7_dischorddummy_zm" || var_4 == "iw7_facemelterdummy_zm" || var_4 == "iw7_headcutterdummy_zm" || var_4 == "iw7_shredderdummy_zm");
  var_29 = undefined;

  if(isDefined(var_4)) {
    var_29 = scripts\cp\utility::getrawbaseweaponname(var_4);
  }

  var_30 = isDefined(var_29) && (var_29 == "harpoon1" || var_29 == "harpoon2" || var_29 == "harpoon3" || var_29 == "harpoon4");

  if(var_24) {
    if(issubstr(var_4, "g18_")) {
      var_24 = isDefined(var_1.has_replaced_starting_pistol);
    }
  }

  if(var_16) {
    if(issubstr(var_4, "shuriken")) {
      var_16 = 0;
    } else if(scripts\engine\utility::is_true(var_1.kung_fu_mode)) {
      var_16 = 0;
    }
  }

  var_31 = var_1 scripts\cp\utility::coop_getweaponclass(var_4) == "weapon_sniper" && var_11;
  var_32 = var_11 && scripts\cp\utility::isheadshot(var_4, var_6, var_3, var_1);

  if(!var_17) {
    switch (var_9) {
      case "weapon_assault":
        var_1 processmerit("mt_ar_kills");
        break;
      case "weapon_smg":
        var_1 processmerit("mt_smg_kills");
        break;
      case "weapon_lmg":
        var_1 processmerit("mt_lmg_kills");
        break;
      case "weapon_shotgun":
        var_1 processmerit("mt_shotgun_kills");
        break;
      case "weapon_sniper":
        var_1 processmerit("mt_sniper_kills");
        break;
      case "weapon_pistol":
        var_1 processmerit("mt_pistol_kills");
        break;
      case "other":
        if(var_28) {
          var_1 processmerit("mt_pistol_kills");
        }

        break;
      default:
        break;
    }
  }

  switch (var_13) {
    case "zombie":
      var_1 processmerit("mt_zombie_kills");
      break;
    default:
      break;
  }

  if(var_16) {
    var_1 processmerit("mt_explosive_kills");
  }

  if(var_17) {
    var_1 processmerit("mt_melee_kills");
  }

  if(var_18) {
    var_1 processmerit("mt_fire_kills");
  }

  if(var_23) {
    var_1 processmerit("mt_trap_kills");
  }

  if(var_24) {
    var_1 processmerit("mt_magic_weapon_kills");
  }

  if(var_32) {
    var_1 processmerit("mt_headshot_kills");
  }

  if(var_19) {
    var_1 processmerit("mt_crawler_kills");
  }

  if(var_20) {
    var_1 processmerit("mt_faf_shock_melee_kills");
  }

  if(var_21) {
    var_1 processmerit("mt_sliding_kills");
  }

  if(var_28 || var_30) {
    var_1 processmerit("mt_quest_weapon_kills");
  }

  if(var_22 && var_18) {
    var_1 processmerit("mt_faf_burned_out_kills");
  }

  if(getdvar("ui_mapname") == "cp_rave") {
    if(isDefined(self.agent_type) && self.agent_type == "zombie_sasquatch") {
      var_1 processmerit("mt_dlc1_sasquatch_kills");
    }

    if(var_17) {
      if(var_4 == "iw7_golf_club_mp" || var_4 == "iw7_golf_club_mp_pap1" || var_4 == "iw7_golf_club_mp_pap2") {
        var_1 processmerit("mt_dlc1_golf_kills");
      } else if(var_4 == "iw7_spiked_bat_mp" || var_4 == "iw7_spiked_bat_mp_pap1" || var_4 == "iw7_spiked_bat_mp_pap2") {
        var_1 processmerit("mt_dlc1_bat_kills");
      } else if(var_4 == "iw7_machete_mp" || var_4 == "iw7_machete_mp_pap1" || var_4 == "iw7_machete_mp_pap2") {
        var_1 processmerit("mt_dlc1_machete_kills");
      } else if(var_4 == "iw7_two_headed_axe_mp" || var_4 == "iw7_two_headed_axe_mp_pap1" || var_4 == "iw7_two_headed_axe_mp_pap2") {
        var_1 processmerit("mt_dlc1_axe_kills");
      } else if(var_4 == "iw7_lawnmower_zm") {
        var_1 processmerit("mt_dlc1_lawnmower_kills");
      }
    }

    if(issubstr(var_4, "harpoon")) {
      var_1 processmerit("mt_dlc1_harpoon_kills");
    }

    if(scripts\engine\utility::is_true(var_1.rave_mode)) {
      var_1 processmerit("mt_dlc1_kills_in_rave");
    }
  }

  if(getdvar("ui_mapname") == "cp_disco") {
    if(var_4 == "iw7_katana_zm_pap2+camo222" || var_4 == "iw7_katana_windforce_zm") {
      var_1 processmerit("mt_dlc2_pap2_katana");
    } else if(var_4 == "iw7_nunchucks_zm_pap2+camo222") {
      var_1 processmerit("mt_dlc2_pap2_nunchucks");
    } else if(var_4 == "heart_cp") {
      var_1 processmerit("mt_dlc2_heart_kills");
    }

    if(isDefined(self.agent_type) && self.agent_type == "skater") {
      var_1 processmerit("mt_dlc2_roller_skaters");
    }

    if(var_23) {
      var_1 processmerit("mt_dlc2_trap_kills");
    } else if(scripts\engine\utility::is_true(var_1.kung_fu_mode) && !is_crafted_trap_damage(var_4)) {
      if(var_1.kungfu_style == "dragon") {
        var_1 processmerit("mt_dlc2_dragon_kills");
      } else if(var_1.kungfu_style == "crane") {
        var_1 processmerit("mt_dlc2_crane_kills");
      } else if(var_1.kungfu_style == "snake") {
        var_1 processmerit("mt_dlc2_snake_kills");
      } else if(var_1.kungfu_style == "tiger") {
        var_1 processmerit("mt_dlc2_tiger_kills");
      }
    }
  }

  if(getdvar("ui_mapname") == "cp_town") {
    if(var_17) {
      if(var_4 == "iw7_knife_zm_cleaver") {
        var_1 processmerit("mt_dlc3_cleaver_kills");
      } else if(var_4 == "iw7_knife_zm_crowbar") {
        var_1 processmerit("mt_dlc3_crowbar_kills");
      }
    } else if(issubstr(var_4, "cutie")) {
      var_1 processmerit("mt_dlc3_mad_kills");
    }

    if(isDefined(self.agent_type) && self.agent_type == "crab_mini") {
      var_1 processmerit("mt_dlc3_crab_mini");
    }

    if(isDefined(var_1.sub_perks) && isDefined(var_1.sub_perks["perk_machine_change"])) {
      if(var_1.sub_perks["perk_machine_change"] == "perk_machine_change1") {
        var_1.change_chew_1_merit = 1;
      } else if(var_1.sub_perks["perk_machine_change"] == "perk_machine_change2") {
        var_1.change_chew_2_merit = 1;
      } else if(var_1.sub_perks["perk_machine_change"] == "perk_machine_change3") {
        var_1.change_chew_3_merit = 1;
      } else if(var_1.sub_perks["perk_machine_change"] == "perk_machine_change4") {
        var_1.change_chew_4_merit = 1;
      }

      if(scripts\engine\utility::is_true(var_1.change_chew_1_merit) && scripts\engine\utility::is_true(var_1.change_chew_2_merit) && scripts\engine\utility::is_true(var_1.change_chew_3_merit) && scripts\engine\utility::is_true(var_1.change_chew_4_merit)) {
        if(!isDefined(var_1.change_chew_merit_progress)) {
          var_1 processmerit("mt_dlc3_change_chew");
          var_1.change_chew_merit_progress = 1;
        }
      }
    }
  }
}

is_crafted_trap_damage(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "iw7_robotzap_zm":
    case "zmb_robotprojectile_mp":
    case "incendiary_ammo_mp":
    case "alien_sentry_minigun_4_mp":
    case "iw7_electrictrap_zm":
      return 1;
  }

  return 0;
}

processmerit(var_0, var_1, var_2) {
  if(!mayprocessmerits()) {
    return;
  }
  if(!isplayer(self) || isai(self)) {
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
    var_9 = var_7 + var_1;
  }

  var_10 = 0;

  if(var_9 >= var_8) {
    var_11 = 1;
    var_10 = var_9 - var_8;
    var_9 = var_8;
  } else {
    var_11 = 0;
  }

  if(var_7 < var_9) {
    scripts\cp\cp_hud_util::mt_setprogress(var_0, var_9);
  }

  if(var_11) {
    thread giverankxpafterwait(var_0, var_3);
    storecompletedmerit(var_0);
    givemeritscore(level.meritinfo[var_0]["score"][var_3]);
    var_3++;
    scripts\cp\cp_hud_util::mt_setstate(var_0, var_3);
    self.meritdata[var_0] = var_3;
    thread scripts\cp\cp_hud_message::showchallengesplash(var_0);

    if(areallmerittierscomplete(var_0)) {
      processmastermerit(var_0);
    }
  }
}

areallmerittierscomplete(var_0) {
  if(self.meritdata[var_0] >= level.meritinfo[var_0]["targetval"].size) {
    return 1;
  }

  return 0;
}

get_table_name() {
  return "cp\zombies\zombie_splashtable.csv";
}

storecompletedmerit(var_0) {
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
  }
}

storecompletedoperation(var_0) {
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
  }
}

giverankxpafterwait(var_0, var_1) {
  self endon("disconnect");
  wait 0.25;
  scripts\cp\cp_persistence::give_player_xp(int(level.meritinfo[var_0]["reward"][var_1]));
}

givemeritscore(var_0) {
  var_1 = self getrankedplayerdata("cp", "challengeScore");
  self setrankedplayerdata("cp", "challengeScore", var_1 + var_0);
}

updatemerits() {
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

getmeritfilter(var_0) {
  return tablelookup("cp\allMeritsTable.csv", 0, var_0, 5);
}

isweaponmerit(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = getmeritfilter(var_0);

  if(isDefined(var_1)) {
    return 1;
  }

  return 0;
}

getweaponfrommerit(var_0) {
  return getmeritfilter(var_0);
}

isoperationmerit(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = getmeritfilter(var_0);

  if(isDefined(var_1)) {
    if(var_1 == "perk_slot_0" || var_1 == "perk_slot_1" || var_1 == "perk_slot_2" || var_1 == "proficiency" || var_1 == "equipment" || var_1 == "special_equipment" || var_1 == "attachment" || var_1 == "prestige" || var_1 == "final_killcam" || var_1 == "basic" || var_1 == "humiliation" || var_1 == "precision" || var_1 == "revenge" || var_1 == "elite" || var_1 == "intimidation" || var_1 == "operations" || scripts\cp\utility::isstrstart(var_1, "killstreaks_")) {
      return 1;
    }
  }

  if(isweaponmerit(var_0)) {
    return 1;
  }

  return 0;
}

merit_targetval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 10 + var_2 * 3);
  return int(var_3);
}

merit_rewardval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 11 + var_2 * 3);
  return int(var_3);
}

merit_scoreval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 12 + var_2 * 3);
  return int(var_3);
}

buildmerittableinfo(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_2 = 0;

  for(;;) {
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
      var_3 = var_3 + var_9;
    }

    var_4 = tablelookupbyrow(var_0, var_2, 0);
    var_2++;
  }

  return int(var_3);
}

buildmeritinfo() {
  level.meritinfo = [];
  var_0 = 0;
  var_0 = var_0 + buildmerittableinfo("cp\allMeritsTable.csv", 0);
}

ismeritunlocked(var_0) {
  var_1 = level.meritinfo[var_0]["filter"];

  if(!isDefined(var_1)) {
    return 1;
  }

  return self getteamdompoints(var_1, "challenge");
}

havedataformerit(var_0) {
  return isDefined(level.meritinfo) && isDefined(level.meritinfo[var_0]);
}

getmeritmasterchallenge(var_0) {
  var_1 = tablelookup("cp\allMeritsTable.csv", 0, var_0, 7);

  if(isDefined(var_1) && var_1 == "") {
    return undefined;
  }

  return var_1;
}

processmastermerit(var_0) {
  var_1 = level.meritinfo[var_0]["master"];

  if(isDefined(var_1)) {
    thread processmerit(var_1);
  }
}

monitoradstime() {
  self endon("disconnect");
  self.adstime = 0.0;

  for(;;) {
    if(self playerads() == 1) {
      self.adstime = self.adstime + 0.05;
    } else {
      self.adstime = 0.0;
    }

    wait 0.05;
  }
}