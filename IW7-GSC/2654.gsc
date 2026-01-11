/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2654.gsc
***************************************/

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
    level waittill("connected", var_00);

    if(!isDefined(var_0.pers["postGameMerits"])) {
      var_0.pers["postGameMerits"] = 0;
    }

    var_00 thread initmeritdata();

    if(isai(var_00)) {
      continue;
    }
    var_00 thread monitoradstime();
  }
}

initmeritdata() {
  self.pers["lastBulletKillTime"] = 0;
  self.pers["bulletStreak"] = 0;
  self.explosiveinfo = [];
}

registermeritcallback(var_00, var_01) {
  if(!isDefined(level.meritcallbacks[var_00])) {
    level.meritcallbacks[var_00] = [];
  }

  level.meritcallbacks[var_00][level.meritcallbacks[var_00].size] = var_01;
}

getmeritstatus(var_00) {
  if(isDefined(self.meritdata[var_00])) {
    return self.meritdata[var_00];
  } else {
    return 0;
  }
}

mt_kills(var_00, var_01) {
  var_02 = var_0.attacker;
  var_03 = var_0.victim;

  if(!isDefined(var_02) || !isplayer(var_02)) {
    return;
  }
  var_02 processmerit("mt_kills");
}

enemykilled(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  self endon("disconnect");
  var_08 = spawnStruct();
  var_8.victim = self;
  var_8.einflictor = var_00;
  var_8.attacker = var_01;
  var_8.idamage = var_02;
  var_8.smeansofdeath = var_03;
  var_8.sweapon = var_04;
  var_8.sprimaryweapon = var_05;
  var_8.shitloc = var_06;
  var_8.time = gettime();
  var_8.modifiers = var_07;
  var_8.victimonground = var_8.victim isonground();
  domeritcallback("enemyKilled", var_08);
  var_8.attacker notify("playerKilledMeritsProcessed");
}

domeritcallback(var_00, var_01) {
  if(!mayprocessmerits()) {
    return;
  }
  if(isDefined(var_01)) {
    var_02 = var_1.player;

    if(!isDefined(var_02)) {
      var_02 = var_1.attacker;
    }

    if(isDefined(var_02) && isai(var_02)) {
      return;
    }
  }

  if(getdvarint("disable_merits") > 0) {
    return;
  }
  if(!isDefined(level.meritcallbacks[var_00])) {
    return;
  }
  if(isDefined(var_01)) {
    for(var_03 = 0; var_03 < level.meritcallbacks[var_00].size; var_3++) {
      thread[[level.meritcallbacks[var_00][var_03]]](var_01);
    }
  } else {
    for(var_03 = 0; var_03 < level.meritcallbacks[var_00].size; var_3++) {
      thread[[level.meritcallbacks[var_00][var_03]]]();
    }
  }
}

process_agent_on_killed_merits(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(!isDefined(var_01)) {
    return;
  }
  if(!isplayer(var_01)) {
    if(isDefined(var_1.owner) && isplayer(var_1.owner)) {
      var_01 = var_1.owner;
    } else {
      return;
    }
  }

  var_09 = scripts\cp\utility::getweaponclass(var_04);
  var_10 = scripts\engine\utility::is_true(var_1.inlaststand);
  var_11 = scripts\engine\utility::isbulletdamage(var_03);
  var_12 = var_01 getstance();
  var_13 = self.species;
  var_14 = var_12 == "crouch";
  var_15 = var_12 == "prone" && !var_10;
  var_16 = isexplosivedamagemod(var_03);
  var_17 = var_03 == "MOD_MELEE";
  var_18 = (scripts\engine\utility::is_true(self.is_burning) || scripts\engine\utility::is_true(self.is_chem_burning)) && (!var_11 || var_04 == "incendiary_ammo_mp");
  var_19 = scripts\engine\utility::is_true(self.dismember_crawl);
  var_20 = scripts\engine\utility::is_true(self.shockmelee);
  var_21 = var_01 issprintsliding();
  var_22 = scripts\engine\utility::is_true(self.faf_burned_out);

  if(isDefined(var_0.owner)) {
    var_23 = var_01 scripts\cp\utility::is_trap(var_00, var_04) && var_0.owner == var_01;
  } else {
    var_23 = var_01 scripts\cp\utility::is_trap(var_00, var_04);
  }

  var_24 = 0;

  foreach(var_26 in getarraykeys(level.all_magic_weapons)) {
    if(scripts\cp\utility::getrawbaseweaponname(var_04) == var_26) {
      var_24 = 1;
      break;
    }
  }

  var_28 = isDefined(var_04) && (var_04 == "iw7_dischorddummy_zm" || var_04 == "iw7_facemelterdummy_zm" || var_04 == "iw7_headcutterdummy_zm" || var_04 == "iw7_shredderdummy_zm");
  var_29 = undefined;

  if(isDefined(var_04)) {
    var_29 = scripts\cp\utility::getrawbaseweaponname(var_04);
  }

  var_30 = isDefined(var_29) && (var_29 == "harpoon1" || var_29 == "harpoon2" || var_29 == "harpoon3" || var_29 == "harpoon4");

  if(var_24) {
    if(issubstr(var_04, "g18_")) {
      var_24 = isDefined(var_1.has_replaced_starting_pistol);
    }
  }

  if(var_16) {
    if(issubstr(var_04, "shuriken")) {
      var_16 = 0;
    } else if(scripts\engine\utility::is_true(var_1.kung_fu_mode)) {
      var_16 = 0;
    }
  }

  var_31 = var_01 scripts\cp\utility::coop_getweaponclass(var_04) == "weapon_sniper" && var_11;
  var_32 = var_11 && scripts\cp\utility::isheadshot(var_04, var_06, var_03, var_01);

  if(!var_17) {
    switch (var_09) {
      case "weapon_assault":
        var_01 processmerit("mt_ar_kills");
        break;
      case "weapon_smg":
        var_01 processmerit("mt_smg_kills");
        break;
      case "weapon_lmg":
        var_01 processmerit("mt_lmg_kills");
        break;
      case "weapon_shotgun":
        var_01 processmerit("mt_shotgun_kills");
        break;
      case "weapon_sniper":
        var_01 processmerit("mt_sniper_kills");
        break;
      case "weapon_pistol":
        var_01 processmerit("mt_pistol_kills");
        break;
      case "other":
        if(var_28) {
          var_01 processmerit("mt_pistol_kills");
        }

        break;
      default:
        break;
    }
  }

  switch (var_13) {
    case "zombie":
      var_01 processmerit("mt_zombie_kills");
      break;
    default:
      break;
  }

  if(var_16) {
    var_01 processmerit("mt_explosive_kills");
  }

  if(var_17) {
    var_01 processmerit("mt_melee_kills");
  }

  if(var_18) {
    var_01 processmerit("mt_fire_kills");
  }

  if(var_23) {
    var_01 processmerit("mt_trap_kills");
  }

  if(var_24) {
    var_01 processmerit("mt_magic_weapon_kills");
  }

  if(var_32) {
    var_01 processmerit("mt_headshot_kills");
  }

  if(var_19) {
    var_01 processmerit("mt_crawler_kills");
  }

  if(var_20) {
    var_01 processmerit("mt_faf_shock_melee_kills");
  }

  if(var_21) {
    var_01 processmerit("mt_sliding_kills");
  }

  if(var_28 || var_30) {
    var_01 processmerit("mt_quest_weapon_kills");
  }

  if(var_22 && var_18) {
    var_01 processmerit("mt_faf_burned_out_kills");
  }

  if(getdvar("ui_mapname") == "cp_rave") {
    if(isDefined(self.agent_type) && self.agent_type == "zombie_sasquatch") {
      var_01 processmerit("mt_dlc1_sasquatch_kills");
    }

    if(var_17) {
      if(var_04 == "iw7_golf_club_mp" || var_04 == "iw7_golf_club_mp_pap1" || var_04 == "iw7_golf_club_mp_pap2") {
        var_01 processmerit("mt_dlc1_golf_kills");
      } else if(var_04 == "iw7_spiked_bat_mp" || var_04 == "iw7_spiked_bat_mp_pap1" || var_04 == "iw7_spiked_bat_mp_pap2") {
        var_01 processmerit("mt_dlc1_bat_kills");
      } else if(var_04 == "iw7_machete_mp" || var_04 == "iw7_machete_mp_pap1" || var_04 == "iw7_machete_mp_pap2") {
        var_01 processmerit("mt_dlc1_machete_kills");
      } else if(var_04 == "iw7_two_headed_axe_mp" || var_04 == "iw7_two_headed_axe_mp_pap1" || var_04 == "iw7_two_headed_axe_mp_pap2") {
        var_01 processmerit("mt_dlc1_axe_kills");
      } else if(var_04 == "iw7_lawnmower_zm") {
        var_01 processmerit("mt_dlc1_lawnmower_kills");
      }
    }

    if(issubstr(var_04, "harpoon")) {
      var_01 processmerit("mt_dlc1_harpoon_kills");
    }

    if(scripts\engine\utility::is_true(var_1.rave_mode)) {
      var_01 processmerit("mt_dlc1_kills_in_rave");
    }
  }

  if(getdvar("ui_mapname") == "cp_disco") {
    if(var_04 == "iw7_katana_zm_pap2+camo222" || var_04 == "iw7_katana_windforce_zm") {
      var_01 processmerit("mt_dlc2_pap2_katana");
    } else if(var_04 == "iw7_nunchucks_zm_pap2+camo222") {
      var_01 processmerit("mt_dlc2_pap2_nunchucks");
    } else if(var_04 == "heart_cp") {
      var_01 processmerit("mt_dlc2_heart_kills");
    }

    if(isDefined(self.agent_type) && self.agent_type == "skater") {
      var_01 processmerit("mt_dlc2_roller_skaters");
    }

    if(var_23) {
      var_01 processmerit("mt_dlc2_trap_kills");
    } else if(scripts\engine\utility::is_true(var_1.kung_fu_mode) && !is_crafted_trap_damage(var_04)) {
      if(var_1.kungfu_style == "dragon") {
        var_01 processmerit("mt_dlc2_dragon_kills");
      } else if(var_1.kungfu_style == "crane") {
        var_01 processmerit("mt_dlc2_crane_kills");
      } else if(var_1.kungfu_style == "snake") {
        var_01 processmerit("mt_dlc2_snake_kills");
      } else if(var_1.kungfu_style == "tiger") {
        var_01 processmerit("mt_dlc2_tiger_kills");
      }
    }
  }

  if(getdvar("ui_mapname") == "cp_town") {
    if(var_17) {
      if(var_04 == "iw7_knife_zm_cleaver") {
        var_01 processmerit("mt_dlc3_cleaver_kills");
      } else if(var_04 == "iw7_knife_zm_crowbar") {
        var_01 processmerit("mt_dlc3_crowbar_kills");
      }
    } else if(issubstr(var_04, "cutie"))
      var_01 processmerit("mt_dlc3_mad_kills");

    if(isDefined(self.agent_type) && self.agent_type == "crab_mini") {
      var_01 processmerit("mt_dlc3_crab_mini");
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
          var_01 processmerit("mt_dlc3_change_chew");
          var_1.change_chew_merit_progress = 1;
        }
      }
    }
  }
}

is_crafted_trap_damage(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  switch (var_00) {
    case "iw7_robotzap_zm":
    case "zmb_robotprojectile_mp":
    case "incendiary_ammo_mp":
    case "alien_sentry_minigun_4_mp":
    case "iw7_electrictrap_zm":
      return 1;
  }

  return 0;
}

processmerit(var_00, var_01, var_02) {
  if(!mayprocessmerits()) {
    return;
  }
  if(!isplayer(self) || isai(self)) {
    return;
  }
  if(!isDefined(var_01)) {
    var_01 = 1;
  }

  if(!havedataformerit(var_00)) {
    return;
  }
  var_03 = getmeritstatus(var_00);

  if(var_03 == 5) {
    return;
  }
  var_04 = isDefined(level.meritinfo[var_00]["operation"]);

  if(var_03 > level.meritinfo[var_00]["targetval"].size) {
    var_05 = var_03 == level.meritinfo[var_00]["targetval"].size + 1;
    var_06 = isDefined(self.operationsmaxed) && isDefined(self.operationsmaxed[var_00]);

    if(var_05 && !var_06) {
      var_03 = level.meritinfo[var_00]["targetval"].size;
    } else {
      return;
    }
  }

  var_07 = scripts\cp\cp_hud_util::mt_getprogress(var_00);
  var_08 = level.meritinfo[var_00]["targetval"][var_03];

  if(!isDefined(var_08)) {
    return;
  }
  if(isDefined(var_02) && var_02) {
    var_09 = var_01;
  } else {
    var_09 = var_07 + var_01;
  }

  var_10 = 0;

  if(var_09 >= var_08) {
    var_11 = 1;
    var_10 = var_09 - var_08;
    var_09 = var_08;
  } else
    var_11 = 0;

  if(var_07 < var_09) {
    scripts\cp\cp_hud_util::mt_setprogress(var_00, var_09);
  }

  if(var_11) {
    thread giverankxpafterwait(var_00, var_03);
    storecompletedmerit(var_00);
    givemeritscore(level.meritinfo[var_00]["score"][var_03]);
    var_3++;
    scripts\cp\cp_hud_util::mt_setstate(var_00, var_03);
    self.meritdata[var_00] = var_03;
    thread scripts\cp\cp_hud_message::showchallengesplash(var_00);

    if(areallmerittierscomplete(var_00)) {
      processmastermerit(var_00);
    }
  }
}

areallmerittierscomplete(var_00) {
  if(self.meritdata[var_00] >= level.meritinfo[var_00]["targetval"].size) {
    return 1;
  }

  return 0;
}

get_table_name() {
  return "cp\zombies\zombie_splashtable.csv";
}

storecompletedmerit(var_00) {
  if(!isDefined(self.meritscompleted)) {
    self.meritscompleted = [];
  }

  var_01 = 0;

  foreach(var_03 in self.meritscompleted) {
    if(var_03 == var_00) {
      var_01 = 1;
    }
  }

  if(!var_01) {
    self.meritscompleted[self.meritscompleted.size] = var_00;
  }
}

storecompletedoperation(var_00) {
  if(!isDefined(self.operationscompleted)) {
    self.operationscompleted = [];
  }

  var_01 = 0;

  foreach(var_03 in self.operationscompleted) {
    if(var_03 == var_00) {
      var_01 = 1;
      break;
    }
  }

  if(!var_01) {
    self.operationscompleted[self.operationscompleted.size] = var_00;
  }
}

giverankxpafterwait(var_00, var_01) {
  self endon("disconnect");
  wait 0.25;
  scripts\cp\cp_persistence::give_player_xp(int(level.meritinfo[var_00]["reward"][var_01]));
}

givemeritscore(var_00) {
  var_01 = self getrankedplayerdata("cp", "challengeScore");
  self setrankedplayerdata("cp", "challengeScore", var_01 + var_00);
}

updatemerits() {
  self.meritdata = [];
  self endon("disconnect");

  if(!mayprocessmerits()) {
    return;
  }
  var_00 = 0;

  foreach(var_05, var_02 in level.meritinfo) {
    var_0++;

    if(var_00 % 20 == 0) {
      wait 0.05;
    }

    self.meritdata[var_05] = 0;
    var_03 = var_2["index"];
    var_04 = scripts\cp\cp_hud_util::mt_getstate(var_05);
    self.meritdata[var_05] = var_04;
  }
}

getmeritfilter(var_00) {
  return tablelookup("cp\allMeritsTable.csv", 0, var_00, 5);
}

isweaponmerit(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  var_01 = getmeritfilter(var_00);

  if(isDefined(var_01)) {
    return 1;
  }

  return 0;
}

getweaponfrommerit(var_00) {
  return getmeritfilter(var_00);
}

isoperationmerit(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  var_01 = getmeritfilter(var_00);

  if(isDefined(var_01)) {
    if(var_01 == "perk_slot_0" || var_01 == "perk_slot_1" || var_01 == "perk_slot_2" || var_01 == "proficiency" || var_01 == "equipment" || var_01 == "special_equipment" || var_01 == "attachment" || var_01 == "prestige" || var_01 == "final_killcam" || var_01 == "basic" || var_01 == "humiliation" || var_01 == "precision" || var_01 == "revenge" || var_01 == "elite" || var_01 == "intimidation" || var_01 == "operations" || scripts\cp\utility::isstrstart(var_01, "killstreaks_")) {
      return 1;
    }
  }

  if(isweaponmerit(var_00)) {
    return 1;
  }

  return 0;
}

merit_targetval(var_00, var_01, var_02) {
  var_03 = tablelookup(var_00, 0, var_01, 10 + var_02 * 3);
  return int(var_03);
}

merit_rewardval(var_00, var_01, var_02) {
  var_03 = tablelookup(var_00, 0, var_01, 11 + var_02 * 3);
  return int(var_03);
}

merit_scoreval(var_00, var_01, var_02) {
  var_03 = tablelookup(var_00, 0, var_01, 12 + var_02 * 3);
  return int(var_03);
}

buildmerittableinfo(var_00, var_01) {
  var_02 = 0;
  var_03 = 0;
  var_02 = 0;

  for(;;) {
    var_04 = tablelookupbyrow(var_00, var_02, 0);

    if(var_04 == "") {
      break;
    }
    var_05 = getmeritmasterchallenge(var_04);
    level.meritinfo[var_04] = [];
    level.meritinfo[var_04]["index"] = var_02;
    level.meritinfo[var_04]["type"] = var_01;
    level.meritinfo[var_04]["targetval"] = [];
    level.meritinfo[var_04]["reward"] = [];
    level.meritinfo[var_04]["score"] = [];
    level.meritinfo[var_04]["filter"] = getmeritfilter(var_04);
    level.meritinfo[var_04]["master"] = var_05;

    if(isoperationmerit(var_04)) {
      level.meritinfo[var_04]["operation"] = 1;
      level.meritinfo[var_04]["spReward"] = [];

      if(isweaponmerit(var_04)) {
        var_06 = getweaponfrommerit(var_04);

        if(isDefined(var_06)) {
          level.meritinfo[var_04]["weapon"] = var_06;
        }
      }
    }

    for(var_07 = 0; var_07 < 5; var_7++) {
      var_08 = merit_targetval(var_00, var_04, var_07);
      var_09 = merit_rewardval(var_00, var_04, var_07);
      var_10 = merit_scoreval(var_00, var_04, var_07);

      if(var_08 == 0) {
        break;
      }
      level.meritinfo[var_04]["targetval"][var_07] = var_08;
      level.meritinfo[var_04]["reward"][var_07] = var_09;
      level.meritinfo[var_04]["score"][var_07] = var_10;
      var_03 = var_03 + var_09;
    }

    var_04 = tablelookupbyrow(var_00, var_02, 0);
    var_2++;
  }

  return int(var_03);
}

buildmeritinfo() {
  level.meritinfo = [];
  var_00 = 0;
  var_00 = var_00 + buildmerittableinfo("cp\allMeritsTable.csv", 0);
}

ismeritunlocked(var_00) {
  var_01 = level.meritinfo[var_00]["filter"];

  if(!isDefined(var_01)) {
    return 1;
  }

  return self getteamdompoints(var_01, "challenge");
}

havedataformerit(var_00) {
  return isDefined(level.meritinfo) && isDefined(level.meritinfo[var_00]);
}

getmeritmasterchallenge(var_00) {
  var_01 = tablelookup("cp\allMeritsTable.csv", 0, var_00, 7);

  if(isDefined(var_01) && var_01 == "") {
    return undefined;
  }

  return var_01;
}

processmastermerit(var_00) {
  var_01 = level.meritinfo[var_00]["master"];

  if(isDefined(var_01)) {
    thread processmerit(var_01);
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