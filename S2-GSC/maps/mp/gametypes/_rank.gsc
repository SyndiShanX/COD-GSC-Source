/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_rank.gsc
*********************************************/

getranktable() {
  if(maps\mp\_utility::iszombiegameshattermode()) {
    return "mp/zm_shotgun_rankTable.csv";
  }

  if(maps\mp\_utility::func_585F() || maps\mp\gametypes\_hud_util::func_5527()) {
    return "mp/cp_rankTable.csv";
  }

  return "mp/rankTable.csv";
}

init() {
  var_00 = getranktable();
  level.rankscale = getrankscale();
  level.divisionrankscale = getdivisionrankscale();
  level.weaponrankscale = getweaponrankscale();
  level.var_5F0C = func_4567();
  level.scoreinfo = [];
  level.ranktable = [];
  level.maxrank = int(tablelookup(var_00, 0, "maxrank", 1));
  level.maxprestige = int(tablelookup(var_00, 0, "maxprestige", 1));
  level.maxrankfinalprestige = int(tablelookup(var_00, 0, "maxrankfinalprestige", 1));
  level.var_AAD3 = 0;
  setdvarifuninitialized("spv_rankedPlayMatchBonusXP_win", 0);
  setdvarifuninitialized("spv_rankedPlayMatchBonusXP_tie", 0);
  setdvarifuninitialized("spv_rankedPlayMatchBonusXP_loss", 0);
  var_01 = 0;
  for(var_02 = tablelookup(getranktable(), 0, var_01, 1); isDefined(var_02) && var_02 != ""; var_02 = tablelookup(var_00, 0, var_01, 1)) {
    level.ranktable[var_01][1] = tablelookup(var_00, 0, var_01, 1);
    level.ranktable[var_01][2] = tablelookup(var_00, 0, var_01, 2);
    level.ranktable[var_01][3] = tablelookup(var_00, 0, var_01, 3);
    level.ranktable[var_01][7] = tablelookup(var_00, 0, var_01, 7);
    level.ranktable[var_01][18] = tablelookup(var_00, 0, var_01, 18);
    var_01++;
  }

  maps\mp\gametypes\_missions::buildchallegeinfo();
  level thread onplayerconnect();
}

rankinghubenabled() {
  return function_0367() && !issplitscreen() && !function_02A4();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isai(var_00) && var_00 maps\mp\_utility::rankingenabled() || maps\mp\_utility::func_585F() || rankinghubenabled()) {
      var_01 = var_00 getprestigelevel();
      var_02 = var_00 maps\mp\gametypes\_persistence::statget("experience");
      if(var_02 < 0) {
        var_02 = 0;
      }

      var_03 = var_00 method_8507() - var_02;
      var_04 = var_00 method_8507();
    } else if(isai(var_00)) {
      var_00 maps\mp\_utility::func_8568();
      var_02 = var_00.pers["rankxp"];
      var_01 = var_00.pers["prestige"];
      var_03 = 0;
      var_04 = var_02;
    } else {
      var_01 = 0;
      var_02 = 0;
      var_03 = 0;
      var_04 = var_02;
    }

    var_00.pers["rankxp"] = var_02;
    var_00.pers["redeemedxp"] = var_03;
    var_00.pers["prestige"] = var_01;
    if(!isDefined(var_00.pers["participation"])) {
      var_00.pers["participation"] = 0;
    }

    var_05 = var_00 getrankforxp(var_00 getrankxp());
    var_00.pers["rank"] = var_05;
    if(isai(var_00)) {
      var_00 maps\mp\_utility::func_8567();
    }

    var_00.var_AAD5 = 0;
    var_00.postgamepromotion = 0;
    var_00.explosivekills[0] = 0;
    var_00 setrank(var_05, var_01);
    var_06 = getrankinfomaxxp(level.maxrank) - var_03;
    var_00.pers["masterPrestige"] = var_01 == level.maxprestige && var_02 >= var_06;
    if(!function_0367() && var_00.clientid < level.var_608C) {
      setmatchdata("players", var_00.clientid, "prestige", var_01);
      setmatchdata("players", var_00.clientid, "start_rank", maps\mp\_utility::func_2314(var_00.pers["rank"]));
    }

    if(!isDefined(var_00.pers["postGameChallenges"])) {
      var_00 setclientdvars("ui_challenge_1_ref", "", "ui_challenge_2_ref", "", "ui_challenge_3_ref", "", "ui_challenge_4_ref", "", "ui_challenge_5_ref", "", "ui_challenge_6_ref", "", "ui_challenge_7_ref", "");
    }

    var_00 setclientdvar("ui_promotion", 0);
    if(!isDefined(var_00.pers["summary"])) {
      var_00.pers["summary"] = [];
      var_00.pers["summary"]["xp"] = 0;
      var_00.pers["summary"]["xpToScaleWithActiveBoosts"] = 0;
      var_00.pers["summary"]["weaponXpToScaleWithActiveBoosts"] = [];
      var_00.pers["summary"]["divisionXpToScaleWithActiveBoosts"] = [];
      var_00.pers["summary"]["score"] = 0;
      var_00.pers["summary"]["challenge"] = 0;
      var_00.pers["summary"]["match"] = 0;
      var_00.pers["summary"]["misc"] = 0;
      var_00.pers["summary"]["entitlementXP"] = 0;
      var_00.pers["summary"]["clanWarsXP"] = 0;
      var_00.pers["summary"]["doubleXp"] = 0;
      var_00.pers["summary"]["matchStartXp"] = var_04;
    }

    if(getDvar("4017") != "1") {
      if(!function_0367()) {
        var_00 setclientdvar("3635", 0);
      }

      var_00 thread maps\mp\gametypes\_missions::updatechallenges();
    }

    var_00 thread monitorinventoryxpupdates();
  }
}

getrankscale() {
  var_00 = getdvarint("4262");
  var_01 = getdvarint("5919");
  var_02 = function_03B9("rank");
  var_03 = max(var_00, var_01);
  var_03 = max(var_03, var_02);
  if(var_03 > 2) {
    var_03 = 2;
  }

  if(var_03 > 4 || var_03 < 0) {
    exitlevel(0);
  }

  return var_03;
}

getdivisionrankscale() {
  var_00 = getdvarint("3039");
  var_01 = getdvarint("5918");
  var_02 = function_03B9("division");
  var_03 = max(var_00, var_01);
  var_03 = max(var_03, var_02);
  if(var_03 > 2) {
    var_03 = 2;
  }

  if(var_03 > 4 || var_03 < 0) {
    exitlevel(0);
  }

  return var_03;
}

getweaponrankscale() {
  var_00 = getdvarint("858");
  var_01 = getdvarint("5917");
  var_02 = function_03B9("weapon");
  var_03 = max(var_00, var_01);
  var_03 = max(var_03, var_02);
  if(var_03 > 2) {
    var_03 = 2;
  }

  if(var_03 > 4 || var_03 < 0) {
    exitlevel(0);
  }

  return var_03;
}

func_4567() {
  var_00 = getdvarint("239");
  if(var_00 > 4 || var_00 < 0) {
    exitlevel(0);
  }

  return var_00;
}

func_57A1(param_00) {
  if(isDefined(level.scoreinfo[param_00])) {
    return 1;
  }

  return 0;
}

func_7C06(param_00, param_01, param_02, param_03) {
  level.scoreinfo[param_00]["value"] = param_01;
  level.scoreinfo[param_00]["allowPlayerScore"] = 0;
  level.scoreinfo[param_00]["playSplash"] = 0;
  if(isDefined(param_02) && param_02) {
    level.scoreinfo[param_00]["allowPlayerScore"] = 1;
  }

  if(isDefined(param_03) && param_03) {
    level.scoreinfo[param_00]["playSplash"] = 1;
  }
}

func_0C28(param_00) {
  return level.scoreinfo[param_00]["allowPlayerScore"];
}

func_8B9E(param_00) {
  return level.scoreinfo[param_00]["playSplash"];
}

getscoreinfovalue(param_00) {
  var_01 = "scr_" + level.gametype + "_score_" + param_00;
  if(getDvar(var_01) != "") {
    return getdvarint(var_01);
  }

  return level.scoreinfo[param_00]["value"];
}

getrankinfominxp(param_00) {
  return int(level.ranktable[param_00][2]);
}

getrankinfoxpamt(param_00) {
  return int(level.ranktable[param_00][3]);
}

getrankinfomaxxp(param_00) {
  return int(level.ranktable[param_00][7]);
}

getrankinfofull(param_00) {
  return tablelookupistring(getranktable(), 0, param_00, 16);
}

getrankinfolevel(param_00) {
  return int(tablelookup(getranktable(), 0, param_00, 13));
}

func_4659(param_00) {
  return level.ranktable[param_00][18];
}

giverankxp(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(maps\mp\_utility::func_551F() && !function_0367()) {
    return;
  }

  if(getdvarint("spv_playofthegame_use_all_kills") == 1 || !isDefined(param_02) || issubstr(param_02, "flamethrower") || !maps\mp\_utility::iskillstreakweapon(param_02) && !issubstr(param_02, "frag") && !issubstr(param_02, "semtex") && !issubstr(param_02, "betty")) {
    param_01 thread maps\mp\gametypes\_potg::func_4AE2(param_00, param_02, param_03, param_05);
  }

  if(func_8B9E(param_00) && !level.var_53C7 || !maps / mp / gametypes / scorestreak_training::func_57BC(param_00)) {
    param_01 thread maps\mp\gametypes\_hud_message::func_9102(param_00);
  }

  var_06 = param_00;
  if(param_01 maps\mp\_utility::_hasperk("specialty_extraobjectivescore") && isDefined(level.scoreinfo[param_00 + "_pro"])) {
    var_06 = var_06 + "_pro";
  }

  param_01 giverankxp(var_06, undefined, param_02, param_04, undefined, param_03);
  param_01 thread maps\mp\gametypes\_gamelogic::func_47C6(param_02, var_06, param_04);
  param_01 thread maps\mp\gametypes\_divisions::func_4783(param_01.var_79, var_06);
  if(func_0C28(var_06)) {
    param_01 maps\mp\gametypes\_gamescore::func_47A7(var_06, param_01, param_03, param_02, param_04);
  }

  lib_0468::func_A1A(param_00, param_01, param_02, param_03, param_04);
}

giverankxp(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon("disconnect");
  if(isDefined(self.owner) && !isbot(self)) {
    self.owner giverankxp(param_00, param_01, param_02, param_03, param_04, param_05);
    return;
  }

  if(isai(self)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }

  if(!function_0367()) {
    if(level.teambased && (!level.teamcount["allies"] || !level.teamcount["axis"]) && param_00 != "win") {
      return;
    }

    if(!level.teambased && level.teamcount["allies"] + level.teamcount["axis"] < 2) {
      return;
    }
  }

  if(isDefined(level.var_2F98) && level.var_2F98) {
    return;
  }

  if(maps\mp\_utility::practiceroundgame()) {
    return;
  }

  if(function_03AF()) {
    if(param_00 == "win") {
      param_01 = getdvarint("spv_rankedPlayMatchBonusXP_win");
    } else if(param_00 == "tie") {
      param_01 = getdvarint("spv_rankedPlayMatchBonusXP_tie");
    } else if(param_00 == "loss") {
      param_01 = getdvarint("spv_rankedPlayMatchBonusXP_loss");
    } else {
      return;
    }
  }

  if(!isDefined(param_01)) {
    if(maps\mp\_utility::_hasperk("specialty_killstreaks") && param_00 == "airdrop_kill" || param_00 == "fritzx_kill" || param_00 == "mortar_strike_kill" || param_00 == "missile_strike_kill" || param_00 == "airstrike_kill" || param_00 == "firebomb_kill" || param_00 == "fighter_strike_kill" || param_00 == "plane_gunner_kill" || param_00 == "flamethrower_kill" || param_00 == "attack_dogs_kill" || param_00 == "paratroopers_kill" || param_00 == "molotovs_kill" || param_00 == "v2_rocket_kill") {
      param_01 = getscoreinfovalue("kill");
    } else {
      param_01 = getscoreinfovalue(param_00);
    }
  }

  if(param_01 == 0) {
    return;
  }

  if(param_01 > 0 && !isDefined(self.var_5F0B) && !function_0367()) {
    self.var_5F0B = 1;
    lootservicevalidateplaytime(self.var_1D6);
  }

  var_06 = param_01;
  var_07 = 0;
  switch (param_00) {
    case "win":
    case "loss":
    case "challenge":
    case "divisionLevel":
    case "weaponLevel":
    case "tie":
      break;

    default:
      if(maps\mp\_utility::getgametypenumlives() > 0 && param_00 != "shield_damage" && !maps\mp\_utility::isprophuntgametype()) {
        var_08 = max(1, int(5 / maps\mp\_utility::getgametypenumlives()));
        if(level.gametype == "sr") {
          var_08 = max(1, int(2.5 / maps\mp\_utility::getgametypenumlives()));
        }

        var_06 = int(var_06 * var_08);
      }

      if(isDefined(level.var_6859) && level.var_6859) {
        if(level.teambased && level.var_685E.team == self.team) {
          var_06 = var_06 * level.var_685E.var_AAD4;
        } else if(!level.teambased && level.var_685E.player == self) {
          var_06 = var_06 * level.var_685E.var_AAD4;
        }

        var_06 = int(var_06);
      }

      if(param_00 == "kill" || param_00 == "divisions_infantry_kill" || param_00 == "divisions_airborne_kill" || param_00 == "divisions_armored_kill" || param_00 == "divisions_mountain_kill" || param_00 == "divisions_cavalry_kill" || param_00 == "division_resistance_kill" || param_00 == "division_grenadier_kill" || param_00 == "division_commando_kill" || param_00 == "division_scout_kill" || param_00 == "division_artillery_kill") {
        var_09 = maps\mp\_utility::func_472B(param_02);
        var_0A = maps\mp\_utility::func_452A(param_02);
        if(isDefined(var_0A) && var_0A != 0) {
          if(var_09 == "cond2" || var_09 == "cond1") {
            var_0B = maps\mp\_utility::getbaseweaponname(param_02);
            var_0C = maps\mp\_utility::func_452A(var_0B);
            if(isDefined(var_0C) && var_0C != 0) {
              var_0D = tablelookup("mp/statstable.csv", 18, maps\mp\_utility::unsignedint_to_hexstring_fixed(var_0C), 34);
              if(var_0D == "0") {
                if(var_09 == "cond1") {
                  var_0A = var_0C + 1;
                } else if(var_09 == "cond2") {
                  var_0A = var_0C + 2;
                }
              } else if(var_0D == "1") {
                if(var_09 == "cond2") {
                  var_0A = var_0C + 1;
                }
              }
            }
          }
        }

        var_0E = maps\mp\_utility::unsignedint_to_hexstring_fixed(var_0A);
        var_0F = float(tablelookup("mp/statstable.csv", 18, var_0E, 49));
        if(var_0F != 0) {
          var_06 = int(var_06 * var_0F);
        }
      }

      if(isDefined(self.var_2680) && isDefined(self.var_2680["xp"])) {
        var_10 = int(var_06 + var_06 * self.var_2680["xp"]["bonusTotal"]);
        var_06 = var_10;
      }

      var_07 = self getclanwarsbonus();
      self.pers["summary"]["xpToScaleWithActiveBoosts"] = self.pers["summary"]["xpToScaleWithActiveBoosts"] + var_06;
      break;
  }

  var_11 = int(var_06 * var_07);
  func_47B4(var_06 + var_11);
  var_12 = maps\mp\gametypes\_missions::func_584F(param_04);
  if(var_12) {
    param_02 = self getcurrentweapon();
  }

  if(param_00 == "shield_damage") {
    param_02 = self getcurrentweapon();
    param_03 = "MOD_MELEE";
  }

  self.pers["summary"]["clanWarsXP"] = self.pers["summary"]["clanWarsXP"] + var_11;
  self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_06 + var_11;
  switch (param_00) {
    case "win":
    case "loss":
    case "tie":
      self.pers["summary"]["match"] = self.pers["summary"]["match"] + var_06;
      break;

    case "challenge":
    case "divisionLevel":
    case "weaponLevel":
      self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + var_06;
      break;

    default:
      if(func_57A1(param_00)) {
        self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_06;
      } else {
        self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + var_06;
      }
      break;
  }
}

givexpfromactiveboosts() {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }

  var_00 = level.rankscale;
  var_01 = level.weaponrankscale;
  var_02 = level.divisionrankscale;
  if(self method_86B4(0) > 1) {
    var_00 = max(var_00, getdvarint("party_rankXPScale"));
    var_01 = max(var_01, getdvarint("party_weaponXPScale"));
    var_02 = max(var_02, getdvarint("party_divisionXPScale"));
  }

  if(isDefined(self.pers["summary"]["xpToScaleWithActiveBoosts"]) && self.pers["summary"]["xpToScaleWithActiveBoosts"] > 0) {
    var_03 = self.pers["summary"]["xpToScaleWithActiveBoosts"];
    var_04 = var_03;
    if(var_00 > 1) {
      var_04 = int(var_04 * var_00);
      self.pers["summary"]["doubleXp"] = self.pers["summary"]["doubleXp"] + int(max(0, var_04 - var_03));
    } else if(self getrankedplayerdata(common_scripts\utility::func_46AE(), "hasDoubleXPItem")) {
      self.pers["summary"]["doubleXp"] = self.pers["summary"]["doubleXp"] + int(var_04);
      var_04 = int(var_04 * 2);
    }

    if(self getrankedplayerdata(common_scripts\utility::func_46AE(), "hasBonusXPItem")) {
      self.pers["summary"]["entitlementXP"] = self.pers["summary"]["entitlementXP"] + int(var_04 * 0.25);
      var_04 = int(var_04 * 1.25);
    }

    var_04 = int(max(0, var_04 - var_03));
    func_47B4(var_04);
    self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_04;
  }

  self.pers["summary"]["xpToScaleWithActiveBoosts"] = 0;
  if(isDefined(self.pers["summary"]["weaponXpToScaleWithActiveBoosts"])) {
    foreach(var_06 in self.pers["summary"]["weaponXpToScaleWithActiveBoosts"]) {
      var_07 = var_06["weaponName"];
      var_08 = var_06["xp"];
      var_04 = var_08;
      if(var_01 > 1) {
        var_04 = int(var_04 * var_01);
      } else if(self getrankedplayerdata(common_scripts\utility::func_46AE(), "hasDoubleWeaponXPItem")) {
        var_04 = int(var_04 * 2);
      }

      if(self getrankedplayerdata(common_scripts\utility::func_46AE(), "hasBonusWeaponXPItem")) {
        var_04 = int(var_04 * 1.25);
      }

      var_04 = int(max(0, var_04 - var_08));
      if(var_04 > 0) {
        thread maps\mp\gametypes\_gamelogic::func_47C3(var_07, var_04);
      }
    }
  }

  self.pers["summary"]["weaponXpToScaleWithActiveBoosts"] = [];
  if(isDefined(self.pers["summary"]["divisionXpToScaleWithActiveBoosts"])) {
    foreach(var_0B in self.pers["summary"]["divisionXpToScaleWithActiveBoosts"]) {
      var_0C = var_0B["divisionIndex"];
      var_08 = var_0B["xp"];
      var_04 = var_08;
      if(var_02 > 1) {
        var_04 = int(var_04 * var_02);
      } else if(self getrankedplayerdata(common_scripts\utility::func_46AE(), "hasDoubleDivisionXPItem")) {
        var_04 = int(var_04 * 2);
      }

      if(self getrankedplayerdata(common_scripts\utility::func_46AE(), "hasBonusDivisionXPItem")) {
        var_04 = int(var_04 * 1.25);
      }

      var_04 = int(max(0, var_04 - var_08));
      if(var_04 > 0) {
        thread maps\mp\gametypes\_divisions::func_4782(var_0C, var_04);
      }
    }
  }

  self.pers["summary"]["divisionXpToScaleWithActiveBoosts"] = [];
}

func_47B4(param_00) {
  var_01 = func_465C();
  var_02 = func_465F();
  func_50EB(param_00);
  if(function_0367()) {
    self luinotifyevent(&"rankxp_gained", 2, var_01 + var_02, getrankxp());
  }

  var_03 = maps\mp\_utility::rankingenabled() && func_A157(var_01);
  if(var_03) {
    thread updaterankannouncehud();
    if(function_0367()) {
      playFXOnTag(level._effect["level_up"], self, "tag_origin");
      lib_0378::func_8D74("hqs_level_up_flag_start");
    }
  }

  syncxpstat();
  if(var_03 && function_0367() && getdvarint("5956", 0) == 1) {
    self uploadhub1v1leaderboarddata();
  }
}

func_A157(param_00) {
  var_01 = getrank();
  if(var_01 == self.pers["rank"]) {
    return 0;
  }

  var_02 = self.pers["rank"];
  self.pers["rank"] = var_01;
  var_03 = func_465C() - param_00;
  var_04 = -1;
  if(isDefined(self.bufferedstats) && isDefined(self.bufferedstats["timePlayedTotal"]) && isDefined(self.bufferedstats["timePlayedTotal"].value)) {
    var_04 = self.bufferedstats["timePlayedTotal"].value;
  }

  function_00F5("script_mp_rankup_player: playerName %s, oldRank %d, newRank %d, xpGain %d, timePlayed %d", self.name, var_02 + 1, var_01 + 1, var_03, var_04);
  for(var_05 = var_02 + 1; var_05 <= var_01; var_05++) {
    if(var_05 == 1) {
      lib_0468::func_A25(0, "mp");
    }

    lib_0468::func_A25(var_05, "mp");
  }

  var_06 = self.pers["prestige"];
  if(getdvarint("spv_hub_masterPrestigeDrops_kswitch", 1) == 0) {
    if(var_06 == level.maxprestige && var_01 >= level.maxrank) {
      lib_0468::ae_sendmasterprestigerankevent(var_01, "mp");
    }
  }

  thread setsize(var_01 - var_02);
  if(var_06 == level.maxprestige && var_01 == level.maxrank + 1) {
    lib_0468::func_A2A("general", 11);
  }

  self setrank(var_01);
  return 1;
}

setsize(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  var_01 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "cacTokens");
  self setrankedplayerdata(common_scripts\utility::func_46AE(), "cacTokens", var_01 + param_00);
}

updaterankannouncehud() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  var_00 = self.pers["team"];
  if(!isDefined(var_00)) {
    return;
  }

  if(!maps\mp\_utility::levelflag("game_over")) {
    level common_scripts\utility::waittill_notify_or_timeout("game_over", 0.25);
  }

  thread maps\mp\gametypes\_hud_message::func_7A6C(func_4659(self.pers["rank"]), getrankinfolevel(self.pers["rank"]), self.pers["prestige"]);
  for(var_01 = 0; var_01 < level.players.size; var_01++) {
    var_02 = level.players[var_01];
    var_03 = var_02.pers["team"];
    if(isDefined(var_03) && var_02 != self) {
      if(var_03 == var_00) {
        var_02 maps\mp\gametypes\_hud_message::ranksplashnotify(self);
      }
    }
  }
}

func_AAD2(param_00, param_01) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  if(param_01 == 0 && param_00 != "tac_insert_destroyed" && param_00 != "dropped_gun_score" && param_00 != "bankrupt_blades_score" && param_00 != "bankrupt_blades_score_suicide") {
    return;
  }

  while(level.var_AAD3 == gettime()) {
    wait 0.05;
  }

  level.var_AAD3 = gettime();
  self notify("xpPointsPopup");
  self endon("xpPointsPopup");
  if(level.gametype != "blades") {
    self.var_AAD5 = self.var_AAD5 + param_01;
    self setclientomnvar("ui_points_popup", self.var_AAD5);
  }

  var_02 = tablelookuprownum("mp/xp_event_table.csv", 0, param_00);
  if(!isDefined(var_02) || isDefined(var_02) && var_02 == -1) {} else {
    self setclientomnvar("ui_points_popup_event", var_02);
  }

  wait(1);
  self.var_AAD5 = 0;
}

getrank() {
  var_00 = getrankxp();
  var_01 = self.pers["rank"];
  if(var_00 < getrankinfominxp(var_01) + getrankinfoxpamt(var_01)) {
    return var_01;
  }

  return getrankforxp(var_00);
}

getrankforxp(param_00) {
  var_01 = self.pers["prestige"];
  var_02 = var_01 == level.maxprestige && param_00 > getrankinfomaxxp(level.maxrank);
  if(var_02) {
    var_03 = level.maxrank;
    var_04 = level.maxrankfinalprestige;
  } else {
    var_03 = 0;
    var_04 = level.maxrank;
  }

  if(param_00 >= getrankinfomaxxp(var_04)) {
    return var_04;
  }

  while(var_03 <= var_04) {
    var_05 = var_03 + int(var_04 - var_03 / 2);
    if(param_00 >= getrankinfominxp(var_05) && param_00 <= getrankinfomaxxp(var_05)) {
      return var_05;
    }

    if(param_00 > getrankinfomaxxp(var_05)) {
      var_03 = var_05 + 1;
      continue;
    }

    var_04 = var_05 - 1;
  }

  if(maps\mp\_utility::func_585F() || maps\mp\gametypes\_hud_util::func_5527()) {
    return var_04;
  }

  var_06 = -1;
  return var_06;
}

getprestigelevel() {
  if(isai(self) && isDefined(self.pers["prestige_fake"])) {
    return self.pers["prestige_fake"];
  }

  return maps\mp\gametypes\_persistence::statget("prestige");
}

func_465C() {
  if(isDefined(self.pers["rankxp"])) {
    return self.pers["rankxp"];
  }

  return 0;
}

func_465F() {
  if(isDefined(self.pers["redeemedxp"])) {
    return self.pers["redeemedxp"];
  }

  return 0;
}

getrankxp() {
  return func_465C() + func_465F();
}

func_50EB(param_00) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }

  var_01 = func_465C();
  var_02 = self.pers["prestige"];
  if(var_02 == level.maxprestige) {
    var_03 = getrankinfomaxxp(level.maxrankfinalprestige) - func_465F();
  } else if(getdvarint("1258", 0) == 1 || getdvarint("2803", 0) == 1) {
    var_03 = getrankinfominxp(level.maxrank) - func_465F();
  } else {
    var_03 = getrankinfomaxxp(level.maxrank) - func_465F();
  }

  var_04 = int(min(var_01, var_03)) + param_00;
  if(var_04 > var_03) {
    var_04 = var_03;
  }

  self.pers["rankxp"] = var_04;
  func_775B(var_02, var_04);
}

func_775B(param_00, param_01) {
  var_02 = getrankinfomaxxp(level.maxrank) - func_465F();
  if(param_00 == level.maxprestige && param_01 >= var_02 && !self.pers["masterPrestige"]) {
    self.pers["masterPrestige"] = 1;
    thread maps\mp\gametypes\_hud_message::func_9104("prestigeMaster");
  }
}

syncxpstat() {
  var_00 = func_465C();
  maps\mp\gametypes\_persistence::statset("experience", var_00);
}

monitorinventoryxpupdates() {
  self endon("disconnect");
  level endon("game_ended");
  if(!function_02A3() || !function_0367() || common_scripts\utility::func_562E(level.var_A259)) {
    return;
  }

  for(;;) {
    self waittill("client_stats_update");
    var_00 = self.pers["redeemedxp"];
    var_01 = self method_8507() - self.pers["rankxp"];
    if(var_01 > var_00) {
      var_02 = var_00 + self.pers["rankxp"];
      self.pers["redeemedxp"] = var_01;
      if(maps\mp\_utility::rankingenabled() && func_A157(var_02)) {
        thread updaterankannouncehud();
        playFXOnTag(level._effect["level_up"], self, "tag_origin");
        lib_0378::func_8D74("hqs_level_up_flag_start");
        if(getdvarint("5956", 0) == 1) {
          self uploadhub1v1leaderboarddata();
        }
      }
    }
  }
}