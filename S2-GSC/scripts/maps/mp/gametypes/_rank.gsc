/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_rank.gsc
***********************************************/

getranktable() {
  if(maps\mp\_utility::iszombiegameshattermode())
    return "mp/zm_shotgun_rankTable.csv";
  else if(maps\mp\_utility::_id_585F() || maps\mp\gametypes\_hud_util::_id_5527())
    return "mp/cp_rankTable.csv";
  else
    return "mp/rankTable.csv";
}

init() {
  var_0 = getranktable();
  level.rankscale = getrankscale();
  level.divisionrankscale = getdivisionrankscale();
  level.weaponrankscale = getweaponrankscale();
  level._id_5F0C = _id_4567();
  level.scoreinfo = [];
  level.ranktable = [];
  level.maxrank = int(tablelookup(var_0, 0, "maxrank", 1));
  level.maxprestige = int(tablelookup(var_0, 0, "maxprestige", 1));
  level.maxrankfinalprestige = int(tablelookup(var_0, 0, "maxrankfinalprestige", 1));
  level._id_AAD3 = 0;
  setdvarifuninitialized("spv_rankedPlayMatchBonusXP_win", 0);
  setdvarifuninitialized("spv_rankedPlayMatchBonusXP_tie", 0);
  setdvarifuninitialized("spv_rankedPlayMatchBonusXP_loss", 0);
  var_1 = 0;

  for(var_2 = tablelookup(getranktable(), 0, var_1, 1); isDefined(var_2) && var_2 != ""; var_2 = tablelookup(var_0, 0, var_1, 1)) {
    level.ranktable[var_1][1] = tablelookup(var_0, 0, var_1, 1);
    level.ranktable[var_1][2] = tablelookup(var_0, 0, var_1, 2);
    level.ranktable[var_1][3] = tablelookup(var_0, 0, var_1, 3);
    level.ranktable[var_1][7] = tablelookup(var_0, 0, var_1, 7);
    level.ranktable[var_1][18] = tablelookup(var_0, 0, var_1, 18);
    var_1++;
  }

  maps\mp\gametypes\_missions::_id_1D41();
  level thread onplayerconnect();
}

rankinghubenabled() {
  return _func_367() && !_func_135() && !_func_2A4();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!_func_0C1(var_0) && (var_0 maps\mp\_utility::rankingenabled() || maps\mp\_utility::_id_585F() || rankinghubenabled())) {
      var_1 = var_0 getprestigelevel();
      var_2 = var_0 maps\mp\gametypes\_persistence::statget("experience");

      if(var_2 < 0)
        var_2 = 0;

      var_3 = var_0 _meth_8507() - var_2;
      var_4 = var_0 _meth_8507();
    } else if(_func_0C1(var_0)) {
      var_0 maps\mp\_utility::_id_8568();
      var_2 = var_0.pers["rankxp"];
      var_1 = var_0.pers["prestige"];
      var_3 = 0;
      var_4 = var_2;
    } else {
      var_1 = 0;
      var_2 = 0;
      var_3 = 0;
      var_4 = var_2;
    }

    var_0.pers["rankxp"] = var_2;
    var_0.pers["redeemedxp"] = var_3;
    var_0.pers["prestige"] = var_1;

    if(!isDefined(var_0.pers["participation"]))
      var_0.pers["participation"] = 0;

    var_5 = var_0 getrankforxp(var_0 getrankxp());
    var_0.pers["rank"] = var_5;

    if(_func_0C1(var_0))
      var_0 maps\mp\_utility::_id_8567();

    var_0._id_AAD5 = 0;
    var_0.postgamepromotion = 0;
    var_0._id_3962[0] = 0;
    var_0 setrank(var_5, var_1);
    var_6 = getrankinfomaxxp(level.maxrank) - var_3;
    var_0.pers["masterPrestige"] = var_1 == level.maxprestige && var_2 >= var_6;

    if(!_func_367() && var_0.clientid < level._id_608C) {
      setmatchdata("players", var_0.clientid, "prestige", var_1);
      setmatchdata("players", var_0.clientid, "start_rank", maps\mp\_utility::_id_2314(var_0.pers["rank"]));
    }

    if(!isDefined(var_0.pers["postGameChallenges"]))
      var_0 setclientdvars("ui_challenge_1_ref", "", "ui_challenge_2_ref", "", "ui_challenge_3_ref", "", "ui_challenge_4_ref", "", "ui_challenge_5_ref", "", "ui_challenge_6_ref", "", "ui_challenge_7_ref", "");

    var_0 setclientdvar("ui_promotion", 0);

    if(!isDefined(var_0.pers["summary"])) {
      var_0.pers["summary"] = [];
      var_0.pers["summary"]["xp"] = 0;
      var_0.pers["summary"]["xpToScaleWithActiveBoosts"] = 0;
      var_0.pers["summary"]["weaponXpToScaleWithActiveBoosts"] = [];
      var_0.pers["summary"]["divisionXpToScaleWithActiveBoosts"] = [];
      var_0.pers["summary"]["score"] = 0;
      var_0.pers["summary"]["challenge"] = 0;
      var_0.pers["summary"]["match"] = 0;
      var_0.pers["summary"]["misc"] = 0;
      var_0.pers["summary"]["entitlementXP"] = 0;
      var_0.pers["summary"]["clanWarsXP"] = 0;
      var_0.pers["summary"]["doubleXp"] = 0;
      var_0.pers["summary"]["matchStartXp"] = var_4;
    }

    if(getDvar("4017") != "1") {
      if(!_func_367())
        var_0 setclientdvar("3635", 0);

      var_0 thread maps\mp\gametypes\_missions::updatechalleges();
    }

    var_0 thread monitorinventoryxpupdates();
  }
}

getrankscale() {
  var_0 = getdvarint("4262");
  var_1 = getdvarint("5919");
  var_2 = _func_3B9("rank");
  var_3 = max(var_0, var_1);
  var_3 = max(var_3, var_2);

  if(var_3 > 2)
    var_3 = 2;

  if(var_3 > 4 || var_3 < 0)
    exitlevel(0);

  return var_3;
}

getdivisionrankscale() {
  var_0 = getdvarint("3039");
  var_1 = getdvarint("5918");
  var_2 = _func_3B9("division");
  var_3 = max(var_0, var_1);
  var_3 = max(var_3, var_2);

  if(var_3 > 2)
    var_3 = 2;

  if(var_3 > 4 || var_3 < 0)
    exitlevel(0);

  return var_3;
}

getweaponrankscale() {
  var_0 = getdvarint("858");
  var_1 = getdvarint("5917");
  var_2 = _func_3B9("weapon");
  var_3 = max(var_0, var_1);
  var_3 = max(var_3, var_2);

  if(var_3 > 2)
    var_3 = 2;

  if(var_3 > 4 || var_3 < 0)
    exitlevel(0);

  return var_3;
}

_id_4567() {
  var_0 = getdvarint("239");

  if(var_0 > 4 || var_0 < 0)
    exitlevel(0);

  return var_0;
}

_id_57A1(var_0) {
  if(isDefined(level.scoreinfo[var_0]))
    return 1;
  else
    return 0;
}

_id_7C06(var_0, var_1, var_2, var_3) {
  level.scoreinfo[var_0]["value"] = var_1;
  level.scoreinfo[var_0]["allowPlayerScore"] = 0;
  level.scoreinfo[var_0]["playSplash"] = 0;

  if(isDefined(var_2) && var_2)
    level.scoreinfo[var_0]["allowPlayerScore"] = 1;

  if(isDefined(var_3) && var_3)
    level.scoreinfo[var_0]["playSplash"] = 1;
}

_id_0C28(var_0) {
  return level.scoreinfo[var_0]["allowPlayerScore"];
}

_id_8B9E(var_0) {
  return level.scoreinfo[var_0]["playSplash"];
}

getscoreinfovalue(var_0) {
  var_1 = "scr_" + level.gametype + "_score_" + var_0;

  if(getDvar(var_1) != "")
    return getdvarint(var_1);

  return level.scoreinfo[var_0]["value"];
}

getrankinfominxp(var_0) {
  return int(level.ranktable[var_0][2]);
}

getrankinfoxpamt(var_0) {
  return int(level.ranktable[var_0][3]);
}

getrankinfomaxxp(var_0) {
  return int(level.ranktable[var_0][7]);
}

getrankinfofull(var_0) {
  return _func_1AF(getranktable(), 0, var_0, 16);
}

getrankinfolevel(var_0) {
  return int(tablelookup(getranktable(), 0, var_0, 13));
}

_id_4659(var_0) {
  return level.ranktable[var_0][18];
}

_id_1457(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(maps\mp\_utility::_id_551F() && !_func_367()) {
    return;
  }
  if(getdvarint("spv_playofthegame_use_all_kills") == 1 || !isDefined(var_2) || issubstr(var_2, "flamethrower") || !maps\mp\_utility::iskillstreakweapon(var_2) && !issubstr(var_2, "frag") && !issubstr(var_2, "semtex") && !issubstr(var_2, "betty"))
    var_1 thread _id_04F0::_id_4AE2(var_0, var_2, var_3, var_5);

  if(_id_8B9E(var_0) && (!level._id_53C7 || !maps\mp\gametypes\scorestreak_training::_id_57BC(var_0)))
    var_1 thread maps\mp\gametypes\_hud_message::_id_9102(var_0);

  var_6 = var_0;

  if(var_1 maps\mp\_utility::_hasperk("specialty_extraobjectivescore") && isDefined(level.scoreinfo[var_0 + "_pro"]))
    var_6 = var_6 + "_pro";

  var_1 giverankxp(var_6, undefined, var_2, var_4, undefined, var_3);
  var_1 thread maps\mp\gametypes\_gamelogic::_id_47C6(var_2, var_6, var_4);
  var_1 thread _id_04CA::_id_4783(var_1._id_0079, var_6);

  if(_id_0C28(var_6))
    var_1 _id_04D2::_id_47A7(var_6, var_1, var_3, var_2, var_4);

  _id_0468::_id_0A1A(var_0, var_1, var_2, var_3, var_4);
}

giverankxp(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("disconnect");

  if(isDefined(self._id_0117) && !isbot(self)) {
    self._id_0117 giverankxp(var_0, var_1, var_2, var_3, var_4, var_5);
    return;
  }

  if(_func_0C1(self)) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(!_func_367()) {
    if(level.teambased && (!level.teamcount["allies"] || !level.teamcount["axis"]) && var_0 != "win") {
      return;
    }
    if(!level.teambased && level.teamcount["allies"] + level.teamcount["axis"] < 2)
      return;
  }

  if(isDefined(level._id_2F98) && level._id_2F98) {
    return;
  }
  if(maps\mp\_utility::_id_761E()) {
    return;
  }
  if(_func_3AF()) {
    if(var_0 == "win")
      var_1 = getdvarint("spv_rankedPlayMatchBonusXP_win");
    else if(var_0 == "tie")
      var_1 = getdvarint("spv_rankedPlayMatchBonusXP_tie");
    else if(var_0 == "loss")
      var_1 = getdvarint("spv_rankedPlayMatchBonusXP_loss");
    else
      return;
  }

  if(!isDefined(var_1)) {
    if(maps\mp\_utility::_hasperk("specialty_killstreaks") && (var_0 == "airdrop_kill" || var_0 == "fritzx_kill" || var_0 == "mortar_strike_kill" || var_0 == "missile_strike_kill" || var_0 == "airstrike_kill" || var_0 == "firebomb_kill" || var_0 == "fighter_strike_kill" || var_0 == "plane_gunner_kill" || var_0 == "flamethrower_kill" || var_0 == "attack_dogs_kill" || var_0 == "paratroopers_kill" || var_0 == "molotovs_kill" || var_0 == "v2_rocket_kill"))
      var_1 = getscoreinfovalue("kill");
    else
      var_1 = getscoreinfovalue(var_0);
  }

  if(var_1 == 0) {
    return;
  }
  if(var_1 > 0 && !isDefined(self._id_5F0B) && !_func_367()) {
    self._id_5F0B = 1;
    _func_29A(self._id_01D6);
  }

  var_6 = var_1;
  var_7 = 0;

  switch (var_0) {
    case "win":
    case "loss":
    case "challenge":
    case "divisionLevel":
    case "weaponLevel":
    case "tie":
      break;
    default:
      if(maps\mp\_utility::getgametypenumlives() > 0 && var_0 != "shield_damage" && !maps\mp\_utility::isprophuntgametype()) {
        var_8 = max(1, int(5 / maps\mp\_utility::getgametypenumlives()));

        if(level.gametype == "sr")
          var_8 = max(1, int(2.5 / maps\mp\_utility::getgametypenumlives()));

        var_6 = int(var_6 * var_8);
      }

      if(isDefined(level._id_6859) && level._id_6859) {
        if(level.teambased && level._id_685E.team == self.team)
          var_6 = var_6 * level._id_685E._id_AAD4;
        else if(!level.teambased && level._id_685E.player == self)
          var_6 = var_6 * level._id_685E._id_AAD4;

        var_6 = int(var_6);
      }

      if(var_0 == "kill" || var_0 == "divisions_infantry_kill" || var_0 == "divisions_airborne_kill" || var_0 == "divisions_armored_kill" || var_0 == "divisions_mountain_kill" || var_0 == "divisions_cavalry_kill" || var_0 == "division_resistance_kill" || var_0 == "division_grenadier_kill" || var_0 == "division_commando_kill" || var_0 == "division_scout_kill" || var_0 == "division_artillery_kill") {
        var_9 = maps\mp\_utility::_id_472B(var_2);
        var_10 = maps\mp\_utility::_id_452A(var_2);

        if(isDefined(var_10) && var_10 != 0) {
          if(var_9 == "cond2" || var_9 == "cond1") {
            var_11 = maps\mp\_utility::_id_4431(var_2);
            var_12 = maps\mp\_utility::_id_452A(var_11);

            if(isDefined(var_12) && var_12 != 0) {
              var_13 = tablelookup("mp/statstable.csv", 18, maps\mp\_utility::unsignedint_to_hexstring_fixed(var_12), 34);

              if(var_13 == "0") {
                if(var_9 == "cond1")
                  var_10 = var_12 + 1;
                else if(var_9 == "cond2")
                  var_10 = var_12 + 2;
              } else if(var_13 == "1") {
                if(var_9 == "cond2")
                  var_10 = var_12 + 1;
              }
            }
          }
        }

        var_14 = maps\mp\_utility::unsignedint_to_hexstring_fixed(var_10);
        var_15 = _func_0AD(tablelookup("mp/statstable.csv", 18, var_14, 49));

        if(var_15 != 0)
          var_6 = int(var_6 * var_15);
      }

      if(isDefined(self._id_2680) && isDefined(self._id_2680["xp"])) {
        var_16 = int(var_6 + var_6 * self._id_2680["xp"]["bonusTotal"]);
        var_6 = var_16;
      }

      var_7 = self _meth_8536();
      self.pers["summary"]["xpToScaleWithActiveBoosts"] = self.pers["summary"]["xpToScaleWithActiveBoosts"] + var_6;
      break;
  }

  var_17 = int(var_6 * var_7);
  _id_47B4(var_6 + var_17);
  var_18 = maps\mp\gametypes\_missions::_id_584F(var_4);

  if(var_18)
    var_2 = self getcurrentweapon();

  if(var_0 == "shield_damage") {
    var_2 = self getcurrentweapon();
    var_3 = "MOD_MELEE";
  }

  self.pers["summary"]["clanWarsXP"] = self.pers["summary"]["clanWarsXP"] + var_17;
  self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + (var_6 + var_17);

  switch (var_0) {
    case "win":
    case "loss":
    case "tie":
      self.pers["summary"]["match"] = self.pers["summary"]["match"] + var_6;
      break;
    case "challenge":
    case "divisionLevel":
    case "weaponLevel":
      self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + var_6;
      break;
    default:
      if(_id_57A1(var_0))
        self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_6;
      else
        self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + var_6;

      break;
  }
}

givexpfromactiveboosts() {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_0 = level.rankscale;
  var_1 = level.weaponrankscale;
  var_2 = level.divisionrankscale;

  if(self _meth_86B4(0) > 1) {
    var_0 = max(var_0, getdvarint("party_rankXPScale"));
    var_1 = max(var_1, getdvarint("party_weaponXPScale"));
    var_2 = max(var_2, getdvarint("party_divisionXPScale"));
  }

  if(isDefined(self.pers["summary"]["xpToScaleWithActiveBoosts"]) && self.pers["summary"]["xpToScaleWithActiveBoosts"] > 0) {
    var_3 = self.pers["summary"]["xpToScaleWithActiveBoosts"];
    var_4 = var_3;

    if(var_0 > 1) {
      var_4 = int(var_4 * var_0);
      self.pers["summary"]["doubleXp"] = self.pers["summary"]["doubleXp"] + int(max(0, var_4 - var_3));
    } else if(self getplayerdata(common_scripts\utility::_id_46AE(), "hasDoubleXPItem")) {
      self.pers["summary"]["doubleXp"] = self.pers["summary"]["doubleXp"] + int(var_4);
      var_4 = int(var_4 * 2);
    }

    if(self getplayerdata(common_scripts\utility::_id_46AE(), "hasBonusXPItem")) {
      self.pers["summary"]["entitlementXP"] = self.pers["summary"]["entitlementXP"] + int(var_4 * 0.25);
      var_4 = int(var_4 * 1.25);
    }

    var_4 = int(max(0, var_4 - var_3));
    _id_47B4(var_4);
    self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_4;
  }

  self.pers["summary"]["xpToScaleWithActiveBoosts"] = 0;

  if(isDefined(self.pers["summary"]["weaponXpToScaleWithActiveBoosts"])) {
    foreach(var_6 in self.pers["summary"]["weaponXpToScaleWithActiveBoosts"]) {
      var_7 = var_6["weaponName"];
      var_8 = var_6["xp"];
      var_4 = var_8;

      if(var_1 > 1)
        var_4 = int(var_4 * var_1);
      else if(self getplayerdata(common_scripts\utility::_id_46AE(), "hasDoubleWeaponXPItem"))
        var_4 = int(var_4 * 2);

      if(self getplayerdata(common_scripts\utility::_id_46AE(), "hasBonusWeaponXPItem"))
        var_4 = int(var_4 * 1.25);

      var_4 = int(max(0, var_4 - var_8));

      if(var_4 > 0)
        thread maps\mp\gametypes\_gamelogic::_id_47C3(var_7, var_4);
    }
  }

  self.pers["summary"]["weaponXpToScaleWithActiveBoosts"] = [];

  if(isDefined(self.pers["summary"]["divisionXpToScaleWithActiveBoosts"])) {
    foreach(var_11 in self.pers["summary"]["divisionXpToScaleWithActiveBoosts"]) {
      var_12 = var_11["divisionIndex"];
      var_8 = var_11["xp"];
      var_4 = var_8;

      if(var_2 > 1)
        var_4 = int(var_4 * var_2);
      else if(self getplayerdata(common_scripts\utility::_id_46AE(), "hasDoubleDivisionXPItem"))
        var_4 = int(var_4 * 2);

      if(self getplayerdata(common_scripts\utility::_id_46AE(), "hasBonusDivisionXPItem"))
        var_4 = int(var_4 * 1.25);

      var_4 = int(max(0, var_4 - var_8));

      if(var_4 > 0)
        thread _id_04CA::_id_4782(var_12, var_4);
    }
  }

  self.pers["summary"]["divisionXpToScaleWithActiveBoosts"] = [];
}

_id_47B4(var_0) {
  var_1 = _id_465C();
  var_2 = _id_465F();
  _id_50EB(var_0);

  if(_func_367())
    self _meth_85EF(&"rankxp_gained", 2, var_1 + var_2, getrankxp());

  var_3 = maps\mp\_utility::rankingenabled() && _id_A157(var_1);

  if(var_3) {
    thread updaterankannouncehud();

    if(_func_367()) {
      _func_147(level._effect["level_up"], self, "tag_origin");
      _id_0378::_id_8D74("hqs_level_up_flag_start");
    }
  }

  _id_9575();

  if(var_3 && _func_367() && getdvarint("5956", 0) == 1)
    self _meth_801C();
}

_id_A157(var_0) {
  var_1 = _id_4652();

  if(var_1 == self.pers["rank"])
    return 0;

  var_2 = self.pers["rank"];
  self.pers["rank"] = var_1;
  var_3 = _id_465C() - var_0;
  var_4 = -1;

  if(isDefined(self.bufferedstats) && isDefined(self.bufferedstats["timePlayedTotal"]) && isDefined(self.bufferedstats["timePlayedTotal"].value))
    var_4 = self.bufferedstats["timePlayedTotal"].value;

  _func_0F5("script_mp_rankup_player: playerName %s, oldRank %d, newRank %d, xpGain %d, timePlayed %d", self.name, var_2 + 1, var_1 + 1, var_3, var_4);

  for(var_5 = var_2 + 1; var_5 <= var_1; var_5++) {
    if(var_5 == 1)
      _id_0468::_id_0A25(0, "mp");

    _id_0468::_id_0A25(var_5, "mp");
  }

  var_6 = self.pers["prestige"];

  if(getdvarint("spv_hub_masterPrestigeDrops_kswitch", 1) == 0) {
    if(var_6 == level.maxprestige && var_1 >= level.maxrank)
      _id_0468::ae_sendmasterprestigerankevent(var_1, "mp");
  }

  thread _id_099C(var_1 - var_2);

  if(var_6 == level.maxprestige && var_1 == level.maxrank + 1)
    _id_0468::_id_0A2A("general", 11);

  self setrank(var_1);
  return 1;
}

_id_099C(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_1 = self getplayerdata(common_scripts\utility::_id_46AE(), "cacTokens");
  self setplayerdata(common_scripts\utility::_id_46AE(), "cacTokens", var_1 + var_0);
}

updaterankannouncehud() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  var_0 = self.pers["team"];

  if(!isDefined(var_0)) {
    return;
  }
  if(!maps\mp\_utility::levelflag("game_over"))
    level common_scripts\utility::waittill_notify_or_timeout("game_over", 0.25);

  thread maps\mp\gametypes\_hud_message::_id_7A6C(_id_4659(self.pers["rank"]), getrankinfolevel(self.pers["rank"]), self.pers["prestige"]);

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    var_2 = level.players[var_1];
    var_3 = var_2.pers["team"];

    if(isDefined(var_3) && var_2 != self) {
      if(var_3 == var_0)
        var_2 maps\mp\gametypes\_hud_message::ranksplashnotify(self);
    }
  }
}

_id_AAD2(var_0, var_1) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(var_1 == 0 && var_0 != "tac_insert_destroyed" && var_0 != "dropped_gun_score" && var_0 != "bankrupt_blades_score" && var_0 != "bankrupt_blades_score_suicide") {
    return;
  }
  while(level._id_AAD3 == gettime())
    waitframe();

  level._id_AAD3 = gettime();
  self notify("xpPointsPopup");
  self endon("xpPointsPopup");

  if(level.gametype != "blades") {
    self._id_AAD5 = self._id_AAD5 + var_1;
    self _meth_82FF("ui_points_popup", self._id_AAD5);
  }

  var_2 = _func_1B1("mp/xp_event_table.csv", 0, var_0);

  if(!isDefined(var_2) || isDefined(var_2) && var_2 == -1) {} else
    self _meth_82FF("ui_points_popup_event", var_2);

  wait 1;
  self._id_AAD5 = 0;
}

_id_4652() {
  var_0 = getrankxp();
  var_1 = self.pers["rank"];

  if(var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1))
    return var_1;
  else
    return getrankforxp(var_0);
}

getrankforxp(var_0) {
  var_1 = self.pers["prestige"];
  var_2 = var_1 == level.maxprestige && var_0 > getrankinfomaxxp(level.maxrank);

  if(var_2) {
    var_3 = level.maxrank;
    var_4 = level.maxrankfinalprestige;
  } else {
    var_3 = 0;
    var_4 = level.maxrank;
  }

  if(var_0 >= getrankinfomaxxp(var_4))
    return var_4;

  while(var_3 <= var_4) {
    var_5 = var_3 + int((var_4 - var_3) / 2);

    if(var_0 >= getrankinfominxp(var_5) && var_0 <= getrankinfomaxxp(var_5))
      return var_5;

    if(var_0 > getrankinfomaxxp(var_5)) {
      var_3 = var_5 + 1;
      continue;
    }

    var_4 = var_5 - 1;
  }

  if(maps\mp\_utility::_id_585F() || maps\mp\gametypes\_hud_util::_id_5527())
    return var_4;

  var_6 = -1;
  return var_6;
}

getprestigelevel() {
  if(_func_0C1(self) && isDefined(self.pers["prestige_fake"]))
    return self.pers["prestige_fake"];
  else
    return maps\mp\gametypes\_persistence::statget("prestige");
}

_id_465C() {
  if(isDefined(self.pers["rankxp"]))
    return self.pers["rankxp"];
  else
    return 0;
}

_id_465F() {
  if(isDefined(self.pers["redeemedxp"]))
    return self.pers["redeemedxp"];
  else
    return 0;
}

getrankxp() {
  return _id_465C() + _id_465F();
}

_id_50EB(var_0) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_1 = _id_465C();
  var_2 = self.pers["prestige"];

  if(var_2 == level.maxprestige)
    var_3 = getrankinfomaxxp(level.maxrankfinalprestige) - _id_465F();
  else if(getdvarint("1258", 0) == 1 || getdvarint("2803", 0) == 1)
    var_3 = getrankinfominxp(level.maxrank) - _id_465F();
  else
    var_3 = getrankinfomaxxp(level.maxrank) - _id_465F();

  var_4 = int(_func_0AF(var_1, var_3)) + var_0;

  if(var_4 > var_3)
    var_4 = var_3;

  self.pers["rankxp"] = var_4;
  _id_775B(var_2, var_4);
}

_id_775B(var_0, var_1) {
  var_2 = getrankinfomaxxp(level.maxrank) - _id_465F();

  if(var_0 == level.maxprestige && var_1 >= var_2 && !self.pers["masterPrestige"]) {
    self.pers["masterPrestige"] = 1;
    thread maps\mp\gametypes\_hud_message::_id_9104("prestigeMaster");
  }
}

_id_9575() {
  var_0 = _id_465C();
  maps\mp\gametypes\_persistence::statset("experience", var_0);
}

monitorinventoryxpupdates() {
  self endon("disconnect");
  level endon("game_ended");

  if(!_func_2A3() || !_func_367() || common_scripts\utility::_id_562E(level._id_A259)) {
    return;
  }
  for(;;) {
    self waittill("client_stats_update");
    var_0 = self.pers["redeemedxp"];
    var_1 = self _meth_8507() - self.pers["rankxp"];

    if(var_1 > var_0) {
      var_2 = var_0 + self.pers["rankxp"];
      self.pers["redeemedxp"] = var_1;

      if(maps\mp\_utility::rankingenabled() && _id_A157(var_2)) {
        thread updaterankannouncehud();
        _func_147(level._effect["level_up"], self, "tag_origin");
        _id_0378::_id_8D74("hqs_level_up_flag_start");

        if(getdvarint("5956", 0) == 1)
          self _meth_801C();
      }
    }
  }
}