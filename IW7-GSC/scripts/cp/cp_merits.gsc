/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_merits.gsc
************************************/

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
  if(level.onlinegame && !scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    return 1;
  }

  return 0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isDefined(var_00.pers["postGameMerits"])) {
      var_00.pers["postGameMerits"] = 0;
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

registermeritcallback(param_00, param_01) {
  if(!isDefined(level.meritcallbacks[param_00])) {
    level.meritcallbacks[param_00] = [];
  }

  level.meritcallbacks[param_00][level.meritcallbacks[param_00].size] = param_01;
}

getmeritstatus(param_00) {
  if(isDefined(self.meritdata[param_00])) {
    return self.meritdata[param_00];
  }

  return 0;
}

mt_kills(param_00, param_01) {
  var_02 = param_00.var_4F;
  var_03 = param_00.victim;
  if(!isDefined(var_02) || !isplayer(var_02)) {
    return;
  }

  var_02 processmerit("mt_kills");
}

enemykilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("disconnect");
  var_08 = spawnStruct();
  var_08.victim = self;
  var_08.einflictor = param_00;
  var_08.var_4F = param_01;
  var_08.idamage = param_02;
  var_08.smeansofdeath = param_03;
  var_08.sweapon = param_04;
  var_08.sprimaryweapon = param_05;
  var_08.shitloc = param_06;
  var_08.time = gettime();
  var_08.modifiers = param_07;
  var_08.victimonground = var_08.victim isonground();
  domeritcallback("enemyKilled", var_08);
  var_08.var_4F notify("playerKilledMeritsProcessed");
}

domeritcallback(param_00, param_01) {
  if(!mayprocessmerits()) {
    return;
  }

  if(isDefined(param_01)) {
    var_02 = param_01.player;
    if(!isDefined(var_02)) {
      var_02 = param_01.var_4F;
    }

    if(isDefined(var_02) && isai(var_02)) {
      return;
    }
  }

  if(getdvarint("disable_merits") > 0) {
    return;
  }

  if(!isDefined(level.meritcallbacks[param_00])) {
    return;
  }

  if(isDefined(param_01)) {
    for(var_03 = 0; var_03 < level.meritcallbacks[param_00].size; var_03++) {
      thread[[level.meritcallbacks[param_00][var_03]]](param_01);
    }

    return;
  }

  for(var_03 = 0; var_03 < level.meritcallbacks[param_00].size; var_03++) {
    thread[[level.meritcallbacks[param_00][var_03]]]();
  }
}

process_agent_on_killed_merits(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(param_01)) {
    return;
  }

  if(!isplayer(param_01)) {
    if(isDefined(param_01.triggerportableradarping) && isplayer(param_01.triggerportableradarping)) {
      param_01 = param_01.triggerportableradarping;
    } else {
      return;
    }
  }

  var_09 = scripts\cp\utility::getweaponclass(param_04);
  var_0A = scripts\engine\utility::istrue(param_01.inlaststand);
  var_0B = scripts\engine\utility::isbulletdamage(param_03);
  var_0C = param_01 getstance();
  var_0D = self.species;
  var_0E = var_0C == "crouch";
  var_0F = var_0C == "prone" && !var_0A;
  var_10 = isexplosivedamagemod(param_03);
  var_11 = param_03 == "MOD_MELEE";
  var_12 = (scripts\engine\utility::istrue(self.is_burning) || scripts\engine\utility::istrue(self.is_chem_burning)) && !var_0B || param_04 == "incendiary_ammo_mp";
  var_13 = scripts\engine\utility::istrue(self.dismember_crawl);
  var_14 = scripts\engine\utility::istrue(self.shockmelee);
  var_15 = param_01 issprintsliding();
  var_16 = scripts\engine\utility::istrue(self.faf_burned_out);
  if(isDefined(param_00.triggerportableradarping)) {
    var_17 = param_01 scripts\cp\utility::is_trap(param_00, param_04) && param_00.triggerportableradarping == param_01;
  } else {
    var_17 = param_02 scripts\cp\utility::is_trap(param_01, param_05);
  }

  var_18 = 0;
  foreach(var_1A in getarraykeys(level.all_magic_weapons)) {
    if(scripts\cp\utility::getrawbaseweaponname(param_04) == var_1A) {
      if(getdvar("ui_mapname") == "cp_final" && var_1A == "arclassic") {
        var_18 = 0;
      } else {
        var_18 = 1;
      }

      break;
    }
  }

  var_1C = isDefined(param_04) && param_04 == "iw7_dischorddummy_zm" || param_04 == "iw7_facemelterdummy_zm" || param_04 == "iw7_headcutterdummy_zm" || param_04 == "iw7_shredderdummy_zm";
  var_1D = isDefined(param_04) && issubstr(param_04, "venomx");
  var_1E = isDefined(param_04) && param_04 == "iw7_entangler2_zm" || param_04 == "ghost_grenade_launcher";
  var_1F = undefined;
  if(isDefined(param_04)) {
    var_1F = scripts\cp\utility::getrawbaseweaponname(param_04);
  }

  var_20 = isDefined(var_1F) && var_1F == "harpoon1" || var_1F == "harpoon2" || var_1F == "harpoon3" || var_1F == "harpoon4";
  if(var_18) {
    if(issubstr(param_04, "g18_")) {
      var_18 = isDefined(param_01.has_replaced_starting_pistol);
    }

    if(isDefined(param_01.pap2_card_weapon) && param_04 == param_01.pap2_card_weapon) {
      var_18 = 0;
    }
  }

  if(var_10) {
    if(issubstr(param_04, "shuriken")) {
      var_10 = 0;
    } else if(scripts\engine\utility::istrue(param_01.kung_fu_mode)) {
      var_10 = 0;
    }
  }

  var_21 = issubstr(param_04, "longshot");
  var_22 = param_01 scripts\cp\utility::coop_getweaponclass(param_04) == "weapon_sniper" && var_0B;
  var_23 = var_0B && scripts\cp\utility::isheadshot(param_04, param_06, param_03, param_01) && !var_1D;
  var_24 = issubstr(param_04, "m8");
  if(!var_11) {
    switch (var_09) {
      case "weapon_assault":
        param_01 processmerit("mt_ar_kills");
        break;

      case "weapon_smg":
        param_01 processmerit("mt_smg_kills");
        break;

      case "weapon_lmg":
        param_01 processmerit("mt_lmg_kills");
        break;

      case "weapon_shotgun":
        param_01 processmerit("mt_shotgun_kills");
        break;

      case "weapon_sniper":
        if(!var_21 && !var_24) {
          param_01 processmerit("mt_sniper_kills");
        } else if(var_21 && !scripts\cp\agents\gametype_zombie::checkaltmodestatus(param_04)) {
          param_01 processmerit("mt_shotgun_kills");
        } else if(var_21 && scripts\cp\agents\gametype_zombie::checkaltmodestatus(param_04)) {
          param_01 processmerit("mt_sniper_kills");
        } else if(var_24 && !scripts\cp\agents\gametype_zombie::checkaltmodestatus(param_04)) {
          param_01 processmerit("mt_ar_kills");
        } else if(var_24 && scripts\cp\agents\gametype_zombie::checkaltmodestatus(param_04)) {
          param_01 processmerit("mt_sniper_kills");
        }
        break;

      case "weapon_pistol":
        param_01 processmerit("mt_pistol_kills");
        break;

      case "other":
        if(var_1C) {
          param_01 processmerit("mt_pistol_kills");
        }
        break;

      default:
        break;
    }
  }

  switch (var_0D) {
    case "zombie":
      if(self.agent_type != "alien_rhino" && self.agent_type != "alien_phantom" && self.agent_type != "alien_goon") {
        param_01 processmerit("mt_zombie_kills");
      }
      break;

    default:
      break;
  }

  if(var_10) {
    param_01 processmerit("mt_explosive_kills");
  }

  if(var_11) {
    param_01 processmerit("mt_melee_kills");
  }

  if(var_12) {
    param_01 processmerit("mt_fire_kills");
  }

  if(var_17) {
    param_01 processmerit("mt_trap_kills");
  }

  if(var_18) {
    param_01 processmerit("mt_magic_weapon_kills");
  }

  if(var_23) {
    param_01 processmerit("mt_headshot_kills");
  }

  if(var_13) {
    param_01 processmerit("mt_crawler_kills");
  }

  if(var_14) {
    param_01 processmerit("mt_faf_shock_melee_kills");
  }

  if(var_15) {
    param_01 processmerit("mt_sliding_kills");
  }

  if(var_1C || var_20) {
    param_01 processmerit("mt_quest_weapon_kills");
  }

  if(var_16 && var_12) {
    param_01 processmerit("mt_faf_burned_out_kills");
  }

  if(getdvar("ui_mapname") == "cp_rave") {
    if(isDefined(self.agent_type) && self.agent_type == "zombie_sasquatch") {
      param_01 processmerit("mt_dlc1_sasquatch_kills");
    }

    if(var_11) {
      if(param_04 == "iw7_golf_club_mp" || param_04 == "iw7_golf_club_mp_pap1" || param_04 == "iw7_golf_club_mp_pap2") {
        param_01 processmerit("mt_dlc1_golf_kills");
      } else if(param_04 == "iw7_spiked_bat_mp" || param_04 == "iw7_spiked_bat_mp_pap1" || param_04 == "iw7_spiked_bat_mp_pap2") {
        param_01 processmerit("mt_dlc1_bat_kills");
      } else if(param_04 == "iw7_machete_mp" || param_04 == "iw7_machete_mp_pap1" || param_04 == "iw7_machete_mp_pap2") {
        param_01 processmerit("mt_dlc1_machete_kills");
      } else if(param_04 == "iw7_two_headed_axe_mp" || param_04 == "iw7_two_headed_axe_mp_pap1" || param_04 == "iw7_two_headed_axe_mp_pap2") {
        param_01 processmerit("mt_dlc1_axe_kills");
      } else if(param_04 == "iw7_lawnmower_zm") {
        param_01 processmerit("mt_dlc1_lawnmower_kills");
      }
    }

    if(issubstr(param_04, "harpoon")) {
      param_01 processmerit("mt_dlc1_harpoon_kills");
    }

    if(scripts\engine\utility::istrue(param_01.rave_mode)) {
      param_01 processmerit("mt_dlc1_kills_in_rave");
    }
  }

  if(getdvar("ui_mapname") == "cp_disco") {
    if(param_04 == "iw7_katana_zm_pap2+camo222" || param_04 == "iw7_katana_windforce_zm") {
      param_01 processmerit("mt_dlc2_pap2_katana");
    } else if(param_04 == "iw7_nunchucks_zm_pap2+camo222") {
      param_01 processmerit("mt_dlc2_pap2_nunchucks");
    } else if(param_04 == "heart_cp") {
      param_01 processmerit("mt_dlc2_heart_kills");
    }

    if(isDefined(self.agent_type) && self.agent_type == "skater") {
      param_01 processmerit("mt_dlc2_roller_skaters");
    }

    if(var_17) {
      param_01 processmerit("mt_dlc2_trap_kills");
    } else if(scripts\engine\utility::istrue(param_01.kung_fu_mode) && !is_crafted_trap_damage(param_04)) {
      if(param_01.kungfu_style == "dragon") {
        param_01 processmerit("mt_dlc2_dragon_kills");
      } else if(param_01.kungfu_style == "crane") {
        param_01 processmerit("mt_dlc2_crane_kills");
      } else if(param_01.kungfu_style == "snake") {
        param_01 processmerit("mt_dlc2_snake_kills");
      } else if(param_01.kungfu_style == "tiger") {
        param_01 processmerit("mt_dlc2_tiger_kills");
      }
    }
  }

  if(getdvar("ui_mapname") == "cp_town") {
    if(var_11) {
      if(param_04 == "iw7_knife_zm_cleaver") {
        param_01 processmerit("mt_dlc3_cleaver_kills");
      } else if(param_04 == "iw7_knife_zm_crowbar") {
        param_01 processmerit("mt_dlc3_crowbar_kills");
      }
    } else if(issubstr(param_04, "cutie")) {
      param_01 processmerit("mt_dlc3_mad_kills");
    }

    if(isDefined(self.agent_type) && self.agent_type == "crab_mini") {
      param_01 processmerit("mt_dlc3_crab_mini");
    }

    if(isDefined(param_01.sub_perks) && isDefined(param_01.sub_perks["perk_machine_change"])) {
      if(param_01.sub_perks["perk_machine_change"] == "perk_machine_change1") {
        param_01.change_chew_1_merit = 1;
      } else if(param_01.sub_perks["perk_machine_change"] == "perk_machine_change2") {
        param_01.change_chew_2_merit = 1;
      } else if(param_01.sub_perks["perk_machine_change"] == "perk_machine_change3") {
        param_01.change_chew_3_merit = 1;
      } else if(param_01.sub_perks["perk_machine_change"] == "perk_machine_change4") {
        param_01.change_chew_4_merit = 1;
      }

      if(scripts\engine\utility::istrue(param_01.change_chew_1_merit) && scripts\engine\utility::istrue(param_01.change_chew_2_merit) && scripts\engine\utility::istrue(param_01.change_chew_3_merit) && scripts\engine\utility::istrue(param_01.change_chew_4_merit)) {
        if(!isDefined(param_01.change_chew_merit_progress)) {
          param_01 processmerit("mt_dlc3_change_chew");
          param_01.change_chew_merit_progress = 1;
        }
      }
    }
  }

  if(getdvar("ui_mapname") == "cp_final") {
    if(var_1D) {
      param_01 processmerit("mt_dlc4_venomx_kills");
    }

    if(var_1E) {
      param_01 processmerit("mt_dlc4_entangler_kills");
    }

    if(isDefined(self.agent_type)) {
      if(self.agent_type == "alien_rhino") {
        param_01 processmerit("mt_dlc4_rhino_kills");
      } else if(self.agent_type == "alien_phantom") {
        param_01 processmerit("mt_dlc4_phantom_kills");
      } else if(self.agent_type == "alien_goon") {
        param_01 processmerit("mt_dlc4_goon_kills");
      } else if(self.agent_type == "karatemaster" || self.agent_type == "zombie_clown") {
        param_01 processmerit("mt_dlc4_special_wave_kills");
      }
    }

    if(var_17) {
      param_01 processmerit("mt_dlc4_trap_kills");
    }
  }
}

is_crafted_trap_damage(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  switch (param_00) {
    case "iw7_robotzap_zm":
    case "zmb_robotprojectile_mp":
    case "incendiary_ammo_mp":
    case "alien_sentry_minigun_4_mp":
    case "iw7_electrictrap_zm":
      return 1;
  }

  return 0;
}

processmerit(param_00, param_01, param_02) {
  if(!mayprocessmerits()) {
    return;
  }

  if(!isplayer(self) || isai(self)) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!havedataformerit(param_00)) {
    return;
  }

  var_03 = getmeritstatus(param_00);
  if(var_03 == 5) {
    return;
  }

  var_04 = isDefined(level.meritinfo[param_00]["operation"]);
  if(var_03 > level.meritinfo[param_00]["targetval"].size) {
    var_05 = var_03 == level.meritinfo[param_00]["targetval"].size + 1;
    var_06 = isDefined(self.operationsmaxed) && isDefined(self.operationsmaxed[param_00]);
    if(var_05 && !var_06) {
      var_03 = level.meritinfo[param_00]["targetval"].size;
    } else {
      return;
    }
  }

  var_07 = scripts\cp\cp_hud_util::mt_getprogress(param_00);
  var_08 = level.meritinfo[param_00]["targetval"][var_03];
  if(!isDefined(var_08)) {
    return;
  }

  if(isDefined(param_02) && param_02) {
    var_09 = param_01;
  } else {
    var_09 = var_08 + param_02;
  }

  var_0A = 0;
  if(var_09 >= var_08) {
    var_0B = 1;
    var_0A = var_09 - var_08;
    var_09 = var_08;
  } else {
    var_0B = 0;
  }

  if(var_07 < var_09) {
    scripts\cp\cp_hud_util::mt_setprogress(param_00, var_09);
  }

  if(var_0B) {
    thread giverankxpafterwait(param_00, var_03);
    storecompletedmerit(param_00);
    givemeritscore(level.meritinfo[param_00]["score"][var_03]);
    var_03++;
    scripts\cp\cp_hud_util::mt_setstate(param_00, var_03);
    self.meritdata[param_00] = var_03;
    if(param_00 != "mt_dlc4_troll2") {
      thread scripts\cp\cp_hud_message::showchallengesplash(param_00);
    }

    if(areallmerittierscomplete(param_00)) {
      processmastermerit(param_00);
    }
  }
}

areallmerittierscomplete(param_00) {
  if(self.meritdata[param_00] >= level.meritinfo[param_00]["targetval"].size) {
    return 1;
  }

  return 0;
}

get_table_name() {
  return "cp\zombies\zombie_splashtable.csv";
}

storecompletedmerit(param_00) {
  if(!isDefined(self.meritscompleted)) {
    self.meritscompleted = [];
  }

  var_01 = 0;
  foreach(var_03 in self.meritscompleted) {
    if(var_03 == param_00) {
      var_01 = 1;
    }
  }

  if(!var_01) {
    self.meritscompleted[self.meritscompleted.size] = param_00;
  }
}

storecompletedoperation(param_00) {
  if(!isDefined(self.operationscompleted)) {
    self.operationscompleted = [];
  }

  var_01 = 0;
  foreach(var_03 in self.operationscompleted) {
    if(var_03 == param_00) {
      var_01 = 1;
      break;
    }
  }

  if(!var_01) {
    self.operationscompleted[self.operationscompleted.size] = param_00;
  }
}

giverankxpafterwait(param_00, param_01) {
  self endon("disconnect");
  wait(0.25);
  scripts\cp\cp_persistence::give_player_xp(int(level.meritinfo[param_00]["reward"][param_01]));
}

givemeritscore(param_00) {
  var_01 = self getplayerdata("cp", "challengeScore");
  self setplayerdata("cp", "challengeScore", var_01 + param_00);
}

updatemerits() {
  self.meritdata = [];
  self endon("disconnect");
  if(!mayprocessmerits()) {
    return;
  }

  var_00 = 0;
  foreach(var_05, var_02 in level.meritinfo) {
    var_00++;
    if(var_00 % 20 == 0) {
      wait(0.05);
    }

    self.meritdata[var_05] = 0;
    var_03 = var_02["index"];
    var_04 = scripts\cp\cp_hud_util::mt_getstate(var_05);
    self.meritdata[var_05] = var_04;
  }
}

getmeritfilter(param_00) {
  return tablelookup("cp\allMeritsTable.csv", 0, param_00, 5);
}

isweaponmerit(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = getmeritfilter(param_00);
  if(isDefined(var_01)) {
    return 1;
  }

  return 0;
}

getweaponfrommerit(param_00) {
  return getmeritfilter(param_00);
}

isoperationmerit(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = getmeritfilter(param_00);
  if(isDefined(var_01)) {
    if(var_01 == "perk_slot_0" || var_01 == "perk_slot_1" || var_01 == "perk_slot_2" || var_01 == "proficiency" || var_01 == "equipment" || var_01 == "special_equipment" || var_01 == "attachment" || var_01 == "prestige" || var_01 == "final_killcam" || var_01 == "basic" || var_01 == "humiliation" || var_01 == "precision" || var_01 == "revenge" || var_01 == "elite" || var_01 == "intimidation" || var_01 == "operations" || scripts\cp\utility::isstrstart(var_01, "killstreaks_")) {
      return 1;
    }
  }

  if(isweaponmerit(param_00)) {
    return 1;
  }

  return 0;
}

merit_targetval(param_00, param_01, param_02) {
  var_03 = tablelookup(param_00, 0, param_01, 10 + param_02 * 3);
  return int(var_03);
}

merit_rewardval(param_00, param_01, param_02) {
  var_03 = tablelookup(param_00, 0, param_01, 11 + param_02 * 3);
  return int(var_03);
}

merit_scoreval(param_00, param_01, param_02) {
  var_03 = tablelookup(param_00, 0, param_01, 12 + param_02 * 3);
  return int(var_03);
}

buildmerittableinfo(param_00, param_01) {
  var_02 = 0;
  var_03 = 0;
  var_02 = 0;
  for(;;) {
    var_04 = tablelookupbyrow(param_00, var_02, 0);
    if(var_04 == "") {
      break;
    }

    var_05 = getmeritmasterchallenge(var_04);
    level.meritinfo[var_04] = [];
    level.meritinfo[var_04]["index"] = var_02;
    level.meritinfo[var_04]["type"] = param_01;
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

    for(var_07 = 0; var_07 < 5; var_07++) {
      var_08 = merit_targetval(param_00, var_04, var_07);
      var_09 = merit_rewardval(param_00, var_04, var_07);
      var_0A = merit_scoreval(param_00, var_04, var_07);
      if(var_08 == 0) {
        break;
      }

      level.meritinfo[var_04]["targetval"][var_07] = var_08;
      level.meritinfo[var_04]["reward"][var_07] = var_09;
      level.meritinfo[var_04]["score"][var_07] = var_0A;
      var_03 = var_03 + var_09;
    }

    var_04 = tablelookupbyrow(param_00, var_02, 0);
    var_02++;
  }

  return int(var_03);
}

buildmeritinfo() {
  level.meritinfo = [];
  var_00 = 0;
  var_00 = var_00 + buildmerittableinfo("cp\allMeritsTable.csv", 0);
}

ismeritunlocked(param_00) {
  var_01 = level.meritinfo[param_00]["filter"];
  if(!isDefined(var_01)) {
    return 1;
  }

  return self isitemunlocked(var_01, "challenge");
}

havedataformerit(param_00) {
  return isDefined(level.meritinfo) && isDefined(level.meritinfo[param_00]);
}

getmeritmasterchallenge(param_00) {
  var_01 = tablelookup("cp\allMeritsTable.csv", 0, param_00, 7);
  if(isDefined(var_01) && var_01 == "") {
    return undefined;
  }

  return var_01;
}

processmastermerit(param_00) {
  var_01 = level.meritinfo[param_00]["master"];
  if(isDefined(var_01)) {
    thread processmerit(var_01);
  }
}

monitoradstime() {
  self endon("disconnect");
  self.adstime = 0;
  for(;;) {
    if(self getweaponrankinfominxp() == 1) {
      self.adstime = self.adstime + 0.05;
    } else {
      self.adstime = 0;
    }

    wait(0.05);
  }
}