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
    level waittill("connected", var0);

    if(!isDefined(var0.pers["postGameMerits"])) {
      var0.pers["postGameMerits"] = 0;
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

function registermeritcallback(var0, var1) {
  if(!isDefined(level.meritcallbacks[var0])) {
    level.meritcallbacks[var0] = [];
  }

  level.meritcallbacks[var0][level.meritcallbacks[var0].size] = var1;
}

function getmeritstatus(var0) {
  if(isDefined(self.meritdata[var0])) {
    return self.meritdata[var0];
  }

  return 0;
}

function mt_kills(var0, var1) {
  var2 = var0.attacker;
  var3 = var0.victim;

  if(!isDefined(var2) || !isPlayer(var2)) {
    return;
  }

  processmerit(var2, "mt_kills");
}

function enemykilled(var0, var1, var2, var3, var4, var5, var6, var7) {
  self endon("disconnect");
  var8 = spawnStruct();
  var8.victim = self;
  var8.einflictor = var0;
  var8.attacker = var1;
  var8.idamage = var2;
  var8.smeansofdeath = var3;
  var8.sweapon = var4;
  var8.sprimaryweapon = var5;
  var8.shitloc = var6;
  var8.time = gettime();
  var8.modifiers = var7;
  var8.victimonground = var8.victim isonground();
  domeritcallback("enemyKilled", var8);
  var8.attacker notify("playerKilledMeritsProcessed");
}

function domeritcallback(var0, var1) {
  if(!mayprocessmerits()) {
    return;
  }

  if(isDefined(var1)) {
    var2 = var1.player;

    if(!isDefined(var2)) {
      var2 = var1.attacker;
    }

    if(isDefined(var2) && isai(var2)) {
      return;
    }
  }

  if(getdvarint("disable_merits") > 0) {
    return;
  }

  if(!isDefined(level.meritcallbacks[var0])) {
    return;
  }

  if(isDefined(var1)) {
    var3 = 0;

    if(var3 < level.meritcallbacks[var0].size) {
      GscBinSkip1(0x74, level.meritcallbacks[var0][var3], var1);
    }

    return;
  }

  var3 = 0;

  if(var3 < level.meritcallbacks[var1].size) {
    GscBinSkip1(0x74, level.meritcallbacks[var1][var3]);
  }
}

function process_agent_on_killed_merits(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(!isDefined(var1)) {
    return;
  }

  if(!isPlayer(var1)) {
    if(isDefined(var1.owner) && isPlayer(var1.owner)) {
      var1 = var1.owner;
    } else {
      return;
    }
  }

  var9 = scripts\cp\utility::getweaponclass(var4);
  var10 = istrue(var1.inlaststand);
  var11 = scripts\engine\utility::isbulletdamage(var3);
  var12 = var1 getstance();
  var13 = self.species;
  var14 = var12 == "crouch";
  var15 = var12 == "prone" && !var10;
  var16 = isexplosivedamagemod(var3);
  var17 = var3 == "MOD_MELEE";
  var18 = (istrue(self.is_burning) || istrue(self.is_chem_burning)) && (!var11 || var4.basename == "incendiary_ammo_mp");
  var19 = istrue(self.dismember_crawl);
  var20 = istrue(self.shockmelee);
  var21 = var1 issprintsliding();
  var22 = istrue(self.faf_burned_out);

  if(isDefined(var0.owner)) {
    var23 = var1 scripts\cp\utility::is_trap(var0, var4) && var0.owner == var1;
  } else {
    var23 = var2 scripts\cp\utility::is_trap(var1, var5);
  }

  var24 = 0;

  if(isDefined(level.all_magic_weapons)) {
    foreach(var26 in getarraykeys(level.all_magic_weapons)) {
      if(scripts\cp\utility::getrawbaseweaponname(var5) == var26) {
        var24 = 1;
        break;
      }
    }
  }

  var28 = isDefined(var5) && (var5.basename == "iw7_dischorddummy_zm" || var5.basename == "iw7_facemelterdummy_zm" || var5.basename == "iw7_headcutterdummy_zm" || var5.basename == "iw7_shredderdummy_zm");
  var29 = undefined;

  if(isDefined(var5)) {
    var29 = scripts\cp\utility::getrawbaseweaponname(var5);
  }

  var30 = isDefined(var29) && (var29 == "harpoon1" || var29 == "harpoon2" || var29 == "harpoon3" || var29 == "harpoon4");

  if(var24) {
    if(issubstr(var5.basename, "g18_")) {
      var24 = isDefined(var2.has_replaced_starting_pistol);
    }
  }

  if(var17) {
    if(issubstr(var5.basename, "shuriken")) {
      var17 = 0;
    } else if(istrue(var2.kung_fu_mode)) {
      var17 = 0;
    }
  }

  var31 = var5.classname == "weapon_sniper" && var12;
  var32 = var12 && scripts\cp\utility::isheadshot(var5, var7, var4, var2);

  if(!var18) {
    switch (var10) {
      case "weapon_assault":
        processmerit(var2, "mt_ar_kills");
        break;
      case "weapon_smg":
        processmerit(var2, "mt_smg_kills");
        break;
      case "weapon_lmg":
        processmerit(var2, "mt_lmg_kills");
        break;
      case "weapon_shotgun":
        processmerit(var2, "mt_shotgun_kills");
        break;
      case "weapon_sniper":
        processmerit(var2, "mt_sniper_kills");
        break;
      case "weapon_pistol":
        processmerit(var2, "mt_pistol_kills");
        break;
      case "other":
        if(var28) {
          processmerit(var2, "mt_pistol_kills");
        }

        break;
      default:
        break;
    }
  }

  switch (var14) {
    case "zombie":
      processmerit(var2, "mt_zombie_kills");
      break;
    default:
      break;
  }

  if(var17) {
    processmerit(var2, "mt_explosive_kills");
  }

  if(var18) {
    processmerit(var2, "mt_melee_kills");
  }

  if(var19) {
    processmerit(var2, "mt_fire_kills");
  }

  if(var23) {
    processmerit(var2, "mt_trap_kills");
  }

  if(var24) {
    processmerit(var2, "mt_magic_weapon_kills");
  }

  if(var32) {
    processmerit(var2, "mt_headshot_kills");
  }

  if(var20) {
    processmerit(var2, "mt_crawler_kills");
  }

  if(var21) {
    processmerit(var2, "mt_faf_shock_melee_kills");
  }

  if(var22) {
    processmerit(var2, "mt_sliding_kills");
  }

  if(var28 || var30) {
    processmerit(var2, "mt_quest_weapon_kills");
  }

  if(var23 && var19) {
    processmerit(var2, "mt_faf_burned_out_kills");
  }

  var33 = var5.basename;

  if(getDvar("NSQLTTMRMP") == "cp_rave") {
    if(isDefined(self.agent_type) && self.agent_type == "zombie_sasquatch") {
      processmerit(var2, "mt_dlc1_sasquatch_kills");
    }

    if(var18) {
      if(var33 == "iw7_golf_club_mp" || var33 == "iw7_golf_club_mp_pap1" || var33 == "iw7_golf_club_mp_pap2") {
        processmerit(var2, "mt_dlc1_golf_kills");
      } else if(var33 == "iw7_spiked_bat_mp" || var33 == "iw7_spiked_bat_mp_pap1" || var33 == "iw7_spiked_bat_mp_pap2") {
        processmerit(var2, "mt_dlc1_bat_kills");
      } else if(var33 == "iw7_machete_mp" || var33 == "iw7_machete_mp_pap1" || var33 == "iw7_machete_mp_pap2") {
        processmerit(var2, "mt_dlc1_machete_kills");
      } else if(var33 == "iw7_two_headed_axe_mp" || var33 == "iw7_two_headed_axe_mp_pap1" || var33 == "iw7_two_headed_axe_mp_pap2") {
        processmerit(var2, "mt_dlc1_axe_kills");
      } else if(var33 == "iw7_lawnmower_zm") {
        processmerit(var2, "mt_dlc1_lawnmower_kills");
      }
    }

    if(issubstr(var33, "harpoon")) {
      processmerit(var2, "mt_dlc1_harpoon_kills");
    }

    if(istrue(var2.rave_mode)) {
      processmerit(var2, "mt_dlc1_kills_in_rave");
    }
  }

  if(getDvar("NSQLTTMRMP") == "cp_disco") {
    if(var33 == "iw7_katana_zm_pap2+camo222" || var33 == "iw7_katana_windforce_zm") {
      processmerit(var2, "mt_dlc2_pap2_katana");
    } else if(var33 == "iw7_nunchucks_zm_pap2+camo222") {
      processmerit(var2, "mt_dlc2_pap2_nunchucks");
    } else if(var33 == "heart_cp") {
      processmerit(var2, "mt_dlc2_heart_kills");
    }

    if(isDefined(self.agent_type) && self.agent_type == "skater") {
      processmerit(var2, "mt_dlc2_roller_skaters");
    }

    if(var23) {
      processmerit(var2, "mt_dlc2_trap_kills");
      return;
    }

    if(istrue(var2.kung_fu_mode) && !is_crafted_trap_damage(var33)) {
      if(var2.kungfu_style == "dragon") {
        processmerit(var2, "mt_dlc2_dragon_kills");
        return;
      }

      if(var2.kungfu_style == "crane") {
        processmerit(var2, "mt_dlc2_crane_kills");
        return;
      }

      if(var2.kungfu_style == "snake") {
        processmerit(var2, "mt_dlc2_snake_kills");
        return;
      }

      if(var2.kungfu_style == "tiger") {
        processmerit(var2, "mt_dlc2_tiger_kills");
        return;
      }

      return;
    }

    return;
  }
}

function is_crafted_trap_damage(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  switch (var0) {
    case "alien_sentry_minigun_4_mp":
    case "iw7_robotzap_zm":
    case "zmb_robotprojectile_mp":
    case "incendiary_ammo_mp":
    case "iw7_electrictrap_zm":
      return true;
  }

  return false;
}

function processmerit(var0, var1, var2) {
  if(!mayprocessmerits()) {
    return;
  }

  if(!isPlayer(self) || isai(self)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!havedataformerit(var0)) {
    return;
  }

  var3 = getmeritstatus(var0);

  if(var3 == 5) {
    return;
  }

  var4 = isDefined(level.meritinfo[var0]["operation"]);

  if(var3 > level.meritinfo[var0]["targetval"].size) {
    var5 = var3 == level.meritinfo[var0]["targetval"].size + 1;
    var6 = isDefined(self.operationsmaxed) && isDefined(self.operationsmaxed[var0]);

    if(var5 && !var6) {
      var3 = level.meritinfo[var0]["targetval"].size;
    } else {
      return;
    }
  }

  var7 = scripts\cp\cp_hud_util::mt_getprogress(var0);
  var8 = level.meritinfo[var0]["targetval"][var3];

  if(!isDefined(var8)) {
    return;
  }

  if(isDefined(var2) && var2) {
    var9 = var1;
  } else {
    var9 = var8 + var2;
  }

  var10 = 0;

  if(var9 >= var9) {
    var11 = 1;
    var10 = var9 - var9;
    var9 = var9;
  } else {
    var11 = 0;
  }

  if(var9 < var10) {
    scripts\cp\cp_hud_util::mt_setprogress(var2, var10);
  }

  if(var11) {
    thread giverankxpafterwait(var2, var7);
    storecompletedmerit(var2);
    givemeritscore(level.meritinfo[var2]["score"][var7]);
    var7++;
    scripts\cp\cp_hud_util::mt_setstate(var2, var7);
    self.meritdata[var2] = var7;
    thread scripts\cp\cp_hud_message::showchallengesplash(var2);

    if(areallmerittierscomplete(var2)) {
      processmastermerit(var2);
      return;
    }

    return;
  }
}

function areallmerittierscomplete(var0) {
  if(self.meritdata[var0] >= level.meritinfo[var0]["targetval"].size) {
    return true;
  }

  return false;
}

function get_table_name() {
  return "mp/splashtable.csv";
}

function storecompletedmerit(var0) {
  if(!isDefined(self.meritscompleted)) {
    self.meritscompleted = [];
  }

  var1 = 0;

  foreach(var3 in self.meritscompleted) {
    if(var3 == var0) {
      var1 = 1;
    }
  }

  if(!var1) {
    self.meritscompleted[self.meritscompleted.size] = var0;
    return;
  }
}

function storecompletedoperation(var0) {
  if(!isDefined(self.operationscompleted)) {
    self.operationscompleted = [];
  }

  var1 = 0;

  foreach(var3 in self.operationscompleted) {
    if(var3 == var0) {
      var1 = 1;
      break;
    }
  }

  if(!var1) {
    self.operationscompleted[self.operationscompleted.size] = var0;
    return;
  }
}

function giverankxpafterwait(var0, var1) {
  self endon("disconnect");
  wait 0.25;
  scripts\cp\cp_persistence::give_player_xp(int(level.meritinfo[var0]["reward"][var1]));
  scripts\cp\drone\emp_drone::giverankxp(var0, level.meritinfo[var0]["reward"][var1], undefined);
}

function givemeritscore(var0) {
  var1 = self getplayerdata("cp", "challengeScore");

  if(isDefined(var1)) {
    self setplayerdata("cp", "challengeScore", var1 + var0);
    return;
  }
}

function updatemerits() {
  self.meritdata = [];
  self endon("disconnect");

  if(!mayprocessmerits()) {
    return;
  }

  var0 = 0;

  foreach(var5, var2 in level.meritinfo) {
    var0++;

    if(var0 % 20 == 0) {
      wait 0.05;
    }

    self.meritdata[var5] = 0;
    var3 = var2["index"];
    var4 = scripts\cp\cp_hud_util::mt_getstate(var5);
    self.meritdata[var5] = var4;
  }
}

function getmeritfilter(var0) {
  return tablelookup("cp/allMeritsTable.csv", 0, var0, 5);
}

function isweaponmerit(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = getmeritfilter(var0);

  if(isDefined(var1)) {
    return true;
  }

  return false;
}

function getweaponfrommerit(var0) {
  return getmeritfilter(var0);
}

function isoperationmerit(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = getmeritfilter(var0);

  if(isDefined(var1)) {
    if(var1 == "perk_slot_0" || var1 == "perk_slot_1" || var1 == "perk_slot_2" || var1 == "proficiency" || var1 == "equipment" || var1 == "special_equipment" || var1 == "attachment" || var1 == "prestige" || var1 == "final_killcam" || var1 == "basic" || var1 == "humiliation" || var1 == "precision" || var1 == "revenge" || var1 == "elite" || var1 == "intimidation" || var1 == "operations" || scripts\cp\utility::isstrstart(var1, "killstreaks_")) {
      return true;
    }
  }

  if(isweaponmerit(var0)) {
    return true;
  }

  return false;
}

function merit_targetval(var0, var1, var2) {
  var3 = tablelookup(var0, 0, var1, 10 + var2 * 3);
  return int(var3);
}

function merit_rewardval(var0, var1, var2) {
  var3 = tablelookup(var0, 0, var1, 11 + var2 * 3);
  return int(var3);
}

function merit_scoreval(var0, var1, var2) {
  var3 = tablelookup(var0, 0, var1, 12 + var2 * 3);
  return int(var3);
}

function buildmerittableinfo(var0, var1) {
  var2 = 0;
  var3 = 0;

  for(var2 = 0;; var2++) {
    var4 = tablelookupbyrow(var0, var2, 0);

    if(var4 == "") {
      break;
    }

    var5 = getmeritmasterchallenge(var4);
    level.meritinfo[var4] = [];
    level.meritinfo[var4]["index"] = var2;
    level.meritinfo[var4]["type"] = var1;
    level.meritinfo[var4]["targetval"] = [];
    level.meritinfo[var4]["reward"] = [];
    level.meritinfo[var4]["score"] = [];
    level.meritinfo[var4]["filter"] = getmeritfilter(var4);
    level.meritinfo[var4]["master"] = var5;

    if(isoperationmerit(var4)) {
      level.meritinfo[var4]["operation"] = 1;
      level.meritinfo[var4]["spReward"] = [];

      if(isweaponmerit(var4)) {
        var6 = getweaponfrommerit(var4);

        if(isDefined(var6)) {
          level.meritinfo[var4]["weapon"] = var6;
        }
      }
    }

    for(var7 = 0; var7 < 5; var7++) {
      var8 = merit_targetval(var0, var4, var7);
      var9 = merit_rewardval(var0, var4, var7);
      var10 = merit_scoreval(var0, var4, var7);

      if(var8 == 0) {
        break;
      }

      level.meritinfo[var4]["targetval"][var7] = var8;
      level.meritinfo[var4]["reward"][var7] = var9;
      level.meritinfo[var4]["score"][var7] = var10;
      var3 += var9;
    }

    var4 = tablelookupbyrow(var0, var2, 0);
  }

  return int(var3);
}

function buildmeritinfo() {
  level.meritinfo = [];
  var0 = 0;
  var0 += buildmerittableinfo("cp/allMeritsTable.csv", 0);
}

function ismeritunlocked(var0) {
  var1 = level.meritinfo[var0]["filter"];

  if(!isDefined(var1)) {
    return 1;
  }

  return self isitemunlocked(var1, "challenge");
}

function havedataformerit(var0) {
  return isDefined(level.meritinfo) && isDefined(level.meritinfo[var0]);
}

function getmeritmasterchallenge(var0) {
  var1 = tablelookup("cp/allMeritsTable.csv", 0, var0, 7);

  if(isDefined(var1) && var1 == "") {
    return undefined;
  }

  return var1;
}

function processmastermerit(var0) {
  var1 = level.meritinfo[var0]["master"];

  if(isDefined(var1)) {
    thread processmerit(var1);
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