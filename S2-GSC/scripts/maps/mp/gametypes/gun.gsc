/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\gun.gsc
*********************************************/

main() {
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 0);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
    _setdynamicdvar("scr_game_radarMode", 1);
  }

  level.gun_cyclecount = maps\mp\_utility::getintproperty("scr_gun_cycleCount", 1);
  level.gun_weaponlist = maps\mp\_utility::getintproperty("scr_gun_weaponList", 0);
  level.gun_weaponorder = maps\mp\_utility::getintproperty("scr_gun_weaponOrder", 0);
  level.gun_weaponattachments = maps\mp\_utility::getintproperty("scr_gun_weaponAttachments", 1);
  level.gun_weaponlistend = maps\mp\_utility::getintproperty("scr_gun_weaponListEnd", 0);
  level.gun_usevariants = maps\mp\_utility::getintproperty("scr_gun_useVariants", 0);
  _id_869C();
  setscorelimit();
  setspecialloadout(level.gun_guns[0]);
  maps\mp\_utility::_id_873B(0);
  level.doprematch = 1;
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level._id_6B7B = ::_id_6B7B;
  level.ontimelimit = ::ontimelimit;
  level._id_6B7F = ::_id_6B7F;
  level._id_1DEA = ::_id_48E5;
  level.thermalvisionon = 1;
  level._id_2FAB = 1;
  level.disabledivisionstats = 1;
  level._id_2F8B = 1;
  level.disableallplayerstats = 1;
  level.disableweaponchallenges = 1;
  level.disabledivisionchallenges = 1;
  level.disablewinlossstats = 1;
  level.enableaudiozoom = maps\mp\_utility::getintproperty("scr_setback_levels", 1);
  level.lastguntimevo = 0;
  level.mgnestsdisabled = 1;
  level.disabledivisionpassives = 1;
  maps\mp\_utility::disableallstreaks();

  if(level.matchrules_damagemultiplier) {
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
  }

  _setteammode("ffa");
  setDvar("2693", 1);
  _setdynamicdvar("scr_game_compassRadarUpdateTime", 9);
  game["dialog"]["gametype"] = "gg_intro";
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  game["dialog"]["humiliation"] = "gg_humiliation";
  game["dialog"]["lastgun"] = "gg_lastgun";
  thread ongameexit();
}

ongameexit() {
  level waittill("exitLevel_called");
  setDvar("2693", 0);
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata(1);
  _setdynamicdvar("scr_gun_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("gun", 1);
  _setdynamicdvar("scr_gun_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("gun", 1);
  _setdynamicdvar("scr_gun_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("gun", 0);
  _setdynamicdvar("scr_gun_playerrespawndelay", 0);
  _setdynamicdvar("scr_gun_waverespawndelay", 0);
  _setdynamicdvar("scr_player_forcerespawn", 1);
  _setdynamicdvar("scr_setback_levels", _getmatchrulesdata("gunData", "setbackLevels"));
  _setdynamicdvar("scr_gun_cycleCount", _getmatchrulesdata("gunData", "cycleCount"));
  _setdynamicdvar("scr_gun_weaponList", _getmatchrulesdata("gunData", "weaponList"));
  _setdynamicdvar("scr_gun_weaponOrder", _getmatchrulesdata("gunData", "weaponOrder"));
  _setdynamicdvar("scr_gun_weaponAttachments", _getmatchrulesdata("gunData", "weaponAttachments"));
  _setdynamicdvar("scr_gun_weaponListEnd", _getmatchrulesdata("gunData", "weaponListEnd"));
  _setdynamicdvar("scr_gun_useVariants", _getmatchrulesdata("gunData", "useVariants"));
}

setscorelimit() {
  _setdynamicdvar("scr_gun_scorelimit", level.gun_guns_raw.size * level.gun_cyclecount);
  maps\mp\_utility::registerscorelimitdvar(level.gametype, level.gun_guns_raw.size * level.gun_cyclecount);
}

onstartgametype() {
  _setclientnamemode("auto_change");
  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_DM");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_DM");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DM");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DM");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DM_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DM_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_DM_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_DM_HINT");
  _id_050D::_id_10E4();
  var_0 = [];
  _id_04D1::main(var_0);
  level.quickmessagetoall = 1;
  level.blockweapondrops = 1;
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.gungamegunindex = 0;
    var_0.gungameprevgunindex = 0;
    var_0.stabs = 0;
    var_0.mysetbacks = 0;
    var_0.lastleveluptime = 0;
    var_0.showsetbacksplash = 0;
    var_0 thread refillammo();
    var_0 thread refillsinglecountammo();
  }
}

_id_48E5(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level.gun_loadout;
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  maps\mp\gametypes\_class::giveloadout(self.team, self.class);

  if(var_0) {
    self loadweapons(level.gun_guns[0]["builtWeaponName"]);
  }
}

onspawnplayer() {
  maps\mp\_utility::giveperk("specialty_longersprint");
  maps\mp\_utility::giveperk("specialty_sprintfastrecovery");
  maps\mp\_utility::giveperk("specialty_fastclimb");
  maps\mp\_utility::giveperk("specialty_fastmantle");
  maps\mp\_utility::giveperk("specialty_fastoffhand");
  maps\mp\_utility::giveperk("specialty_sprintequipment");
  maps\mp\_utility::giveperk("specialty_throwequipmentfarther");
  maps\mp\_utility::giveperk("specialty_increasedmeleedamage");
  self disableweaponswitch();
  self sd_bombs();
  _id_48E5(0);
  thread waitloadoutdone();
}

waitloadoutdone() {
  level endon("game_ended");
  self endon("disconnect");
  level waittill("player_spawned");
  givenextgun(1);

  if(self.showsetbacksplash) {
    self.showsetbacksplash = 0;
    self._id_5BB5 = undefined;
    thread _id_047A::decreasegunlevelevent();
  }
}

_id_6B7F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = maps\mp\gametypes\_rank::getscoreinfovalue(var_0);
  var_1 maps\mp\_utility::setextrascore0(var_1._id_008F + var_5);
  var_1 _id_04D2::updatescorestatsffa(var_1, var_5);

  if(var_0 == "gained_gun_score") {
    return 1;
  } else if(var_0 == "dropped_gun_score") {
    return level.enableaudiozoom * -1;
  }

  return 0;
}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_1)) {
    return;
  }
  if(var_3 == "MOD_TRIGGER_HURT" && !isPlayer(var_1)) {
    var_1 = self;
  }

  if(var_3 == "MOD_FALLING" || isPlayer(var_1)) {
    if(var_3 == "MOD_FALLING" || var_1 == self || maps\mp\_utility::ismeleemod(var_3) && var_4 != "riotshield_mp" || var_4 == "boost_slam_mp") {
      self playlocalsound("mp_war_objective_lost");
      self.gungameprevgunindex = self.gungamegunindex;
      self.gungamegunindex = int(max(0, self.gungamegunindex - level.enableaudiozoom));

      if(self.gungameprevgunindex > self.gungamegunindex) {
        self.mysetbacks++;
        maps\mp\_utility::setextrascore1(self.mysetbacks);
        self.showsetbacksplash = 1;

        if(maps\mp\_utility::ismeleemod(var_3) || var_4 == "boost_slam_mp") {
          var_1.stabs++;
          var_1._id_0021 = var_1.stabs;
          var_1 thread _id_047A::stopdynamicambience();

          if(self.gungameprevgunindex == level.gun_guns.size * level.gun_cyclecount - 1) {
            var_1 thread _id_047A::enablefocus();
            maps\mp\_utility::leaderdialogonplayer("humiliation", "status");
          }
        }
      }
    } else if((var_3 == "MOD_PISTOL_BULLET" || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_HEAD_SHOT" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH" || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_IMPACT" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || maps\mp\_utility::_id_5697(var_3, var_4) || maps\mp\_utility::ismeleemod(var_3) && var_4 == "riotshield_mp") && var_4 != "v2_rocket_mp") {
      if(isDefined(var_1._id_5BB5) && var_1._id_5BB5 == var_4) {
        if(isDefined(var_1.lastkilllifeid) && var_1.lastkilllifeid == var_1._id_5CC6 || isDefined(var_1.lastleveluptime) && var_1.lastleveluptime + 1000 > gettime()) {
          return;
        }
      }

      if(var_1._id_48CF != var_4 && (!maps\mp\_utility::_id_5670(var_1._id_48CF) || var_1._id_48CF != "alt+" + var_4) && (!isDefined(var_1.lethalweapon) || var_1.lethalweapon != var_4) && !issubstr(var_4, "bipod")) {
        return;
      }
      var_1._id_5BB5 = var_4;
      var_1.lastkilllifeid = var_1._id_5CC6;

      if(var_1.lastleveluptime + 5000 > gettime()) {
        var_1 thread _id_047A::quickgunlevelevent();
      }

      var_1.lastleveluptime = gettime();
      var_1.gungameprevgunindex = var_1.gungamegunindex;
      var_1.gungamegunindex++;
      var_1 thread _id_047A::increasegunlevelevent();

      if(var_1.gungamegunindex == level.gun_guns.size * level.gun_cyclecount - 1) {
        maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
        level thread maps\mp\_utility::teamplayercardsplash("callout_top_gun_rank", var_1);
        var_10 = gettime();

        if(level.lastguntimevo + 4500 < var_10) {
          level thread maps\mp\_utility::leaderdialogonplayers("lastgun", [var_1], "status");
          level.lastguntimevo = var_10;
        }
      }

      if(var_1.gungamegunindex < level.gun_guns.size * level.gun_cyclecount) {
        var_1 givenextgun(0, var_4);
      }
    }
  }
}

givenextgun(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("giveNextGun");
  self endon("giveNextGun");
  waittillframeend;

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_2 = getnextgun();
  var_3 = var_2["builtWeaponName"];
  setspecialloadout(var_2);
  self._id_48CF = var_3;

  while(!self loadweapons(var_3)) {
    waitframe();
  }

  if(self same_color_code_as_last_time()) {
    _id_028D::forcedismountweapon();
  }

  self takeallweapons();
  maps\mp\_utility::_giveweapon(var_3);
  self givestartammo(var_3);

  if(var_0) {
    self switchtoweaponimmediate(var_3);
  } else {
    self switchtoweapon(var_3);
  }

  if(isDefined(var_0) && var_0 == 1) {
    self setspawnweapon(var_3);
  }

  var_4 = maps\mp\_utility::_id_4431(var_3);
  self.pers["primaryWeapon"] = var_4;
  self.primaryweapon = var_3;
  self.lethalweapon = undefined;

  if(var_2["forcedLethal"] != "") {
    self.lethalweapon = var_2["forcedLethal"];
    self setlethalweapon(self.lethalweapon);
    self giveweapon(self.lethalweapon);
    self setweaponammoclip(self.lethalweapon, 1);
  }

  var_5 = self._id_0079;
  maps\mp\_utility::_id_06D4(var_5, var_2["division"]);
  self setclientomnvar("ui_show_division_sniper_ability_prompt", 0);

  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    _id_04CB::_id_8725(2, var_3);
    _id_04CB::_id_8725(3, var_3);
    _id_04CB::_id_8725(0, var_3);
  }

  if(maps\mp\_utility::getmapname() != "mp_sandbox_01") {
    var_6 = maps\mp\gametypes\_class::_id_1F93(self._id_0079, "allies");
    self setplayerdata(common_scripts\utility::_id_46A9(), "activeCostume", var_6);
    self.costume = maps\mp\gametypes\_class::cao_getcostumebyindex(var_6);
    var_7 = maps\mp\gametypes\_class::_id_1F95();
    self.costume[1] = var_7[1];
    maps\mp\gametypes\_class::checkforcostumeset();
    _id_0510::playercostume();
  }

  self notify("applyLoadout");
  self.gungameprevgunindex = self.gungamegunindex;
}

getnextgun() {
  var_0 = level.gun_guns;
  var_1 = [];
  var_2 = undefined;
  var_3 = var_0[self.gungamegunindex % var_0.size];
  var_4 = var_3["builtWeaponName"];
  var_1[var_1.size] = var_4;

  if(self.gungamegunindex + 1 < var_0.size * level.gun_cyclecount) {
    var_1[var_1.size] = var_0[(self.gungamegunindex + 1) % var_0.size]["builtWeaponName"];
  }

  if(self.gungamegunindex > 0) {
    var_1[var_1.size] = var_0[(self.gungamegunindex - 1) % var_0.size]["builtWeaponName"];
  }

  self loadweapons(var_1);
  return var_3;
}

ontimelimit() {
  level.finalkillcam_winner = "none";
  var_0 = gethighestprogressedplayers();

  if(!isDefined(var_0) || !var_0.size) {
    thread maps\mp\gametypes\_gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
  } else if(var_0.size == 1) {
    thread maps\mp\gametypes\_gamelogic::endgame(var_0[0], game["end_reason"]["time_limit_reached"]);
  } else if(var_0[var_0.size - 1].gungamegunindex > var_0[var_0.size - 2].gungamegunindex) {
    thread maps\mp\gametypes\_gamelogic::endgame(var_0[var_0.size - 1], game["end_reason"]["time_limit_reached"]);
  } else {
    thread maps\mp\gametypes\_gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
  }
}

gethighestprogressedplayers() {
  var_0 = -1;
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(var_3.gungamegunindex) && var_3.gungamegunindex >= var_0) {
      var_0 = var_3.gungamegunindex;
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

refillammo() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload");
    self givestartammo(self.primaryweapon);

    if(isDefined(self.lethalweapon)) {
      self givestartammo(self.lethalweapon);

      if(self.lethalweapon == "throwingknife_mp") {
        _id_04C7::updatedamagefeedback("resupply_throwingknife");
      } else {
        _id_04C7::updatedamagefeedback("resupply_equipment");
      }
    }

    if(self.primaryweapon == "killstreak_molotov_cocktail_mp") {
      self switchtoweaponimmediate(self.primaryweapon);
    }
  }
}

refillsinglecountammo() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    if(maps\mp\_utility::isreallyalive(self) && self.team != "spectator" && (isDefined(self.primaryweapon) && _weapontype(self.primaryweapon) != "melee" && self getammocount(self.primaryweapon) == 0 || isDefined(self.lethalweapon) && self getammocount(self.lethalweapon) == 0)) {
      wait 2;
      self notify("reload");
      wait 1;
      continue;
    }

    waitframe();
  }
}

setspecialloadout(var_0) {
  level.gun_loadout = maps\mp\gametypes\_class::getemptyloadout();
  level.gun_loadout["loadoutDivision"] = var_0["division"];

  if(maps\mp\gametypes\_class::isvalidprimary(var_0["builtWeaponName"])) {
    level.gun_loadout["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(maps\mp\_utility::_id_452A(var_0["builtWeaponName"]), 0);
  } else if(maps\mp\gametypes\_class::isvalidsecondary(var_0["builtWeaponName"], 0)) {
    level.gun_loadout["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(maps\mp\_utility::_id_452A(var_0["builtWeaponName"]), 0);
  }

  for(var_1 = 0; var_1 < 9; var_1++) {
    level.gun_loadout["loadoutPerksGUID"][var_1] = 0;
  }

  if(var_0["forcedLethal"] != "") {
    level.gun_loadout["loadoutEquipmentStruct"] = maps\mp\_utility::_id_44CE(maps\mp\_utility::_id_452A(var_0["forcedLethal"]), 0);
  }
}

addgun(var_0) {
  level.gun_guns_raw[level.gun_guns_raw.size] = var_0;
}

_id_869C() {
  level.gun_guns_raw = [];

  switch (level.gun_weaponlist) {
    case 0:
    default:
      addgun("rand_smg");
      addgun("rand_rifle_auto");
      addgun("rand_smg");
      addgun("rand_shotgun");
      addgun("rand_rifle_auto");
      addgun("rand_smg_division");
      addgun("rand_rifle_single");
      addgun("rand_shotgun_division");
      addgun("rand_lmg");
      addgun("rand_sniper_4x");
      addgun("rand_rifle_division");
      addgun("rand_lmg_division");
      addgun("rand_sniper");
      addgun("rand_pistol");
      addgun("rand_launcher");
      addgun("rand_pistol_akimbo");
      addgun("rand_difficult_sniper");
      break;
    case 1:
      addgun("rand_shotgun_division");
      addgun("rand_smg_division");
      addgun("rand_rifle_division");
      addgun("rand_lmg_division");
      addgun("rand_sniper_division");
      break;
    case 2:
      addgun("rand_fire_shotgun");
      addgun("rand_launcher");
      addgun("rand_shotgun_division");
      addgun("rand_fire_molotov");
      addgun("rand_fire_flamethrower");
      addgun("rand_fire_shotgun");
      addgun("rand_launcher");
      addgun("rand_fire_shotgun");
      addgun("rand_fire_flamethrower");
      break;
    case 3:
      addgun("rand_pistol_akimbo");
      addgun("rand_shotgun");
      addgun("rand_smg");
      addgun("rand_shotgun");
      addgun("rand_smg");
      addgun("rand_shotgun_division");
      addgun("rand_smg");
      addgun("rand_smg");
      addgun("rand_rifle_auto");
      addgun("rand_smg");
      addgun("rand_rifle_auto");
      addgun("rand_smg");
      addgun("rand_smg_division");
      addgun("rand_rifle_auto");
      addgun("rand_pistol_akimbo");
      addgun("rand_launcher");
      break;
    case 4:
      addgun("rand_pistol");
      addgun("rand_rifle_auto");
      addgun("rand_rifle_single");
      addgun("rand_rifle_auto");
      addgun("rand_rifle_single");
      addgun("rand_lmg");
      addgun("rand_sniper_4x");
      addgun("rand_rifle_auto");
      addgun("rand_rifle_division");
      addgun("rand_lmg");
      addgun("rand_sniper");
      addgun("rand_lmg");
      addgun("rand_sniper");
      addgun("rand_pistol");
      addgun("rand_shotgun_sniper");
      break;
    case 5:
      addgun("rand_rifle_auto");
      addgun("rand_rifle_auto");
      addgun("rand_rifle_auto");
      addgun("rand_rifle_auto");
      addgun("rand_rifle_single");
      addgun("rand_rifle_single");
      addgun("rand_rifle_single");
      addgun("rand_rifle_division");
      break;
    case 6:
      addgun("rand_smg");
      addgun("rand_smg");
      addgun("rand_smg");
      addgun("rand_smg");
      addgun("rand_smg");
      addgun("rand_smg");
      addgun("rand_smg_division");
      break;
    case 7:
      addgun("rand_sniper");
      addgun("rand_sniper");
      addgun("rand_sniper");
      addgun("rand_sniper_division");
      break;
    case 8:
      addgun("rand_lmg");
      addgun("rand_lmg");
      addgun("rand_lmg");
      addgun("rand_lmg");
      addgun("rand_lmg_division");
      break;
    case 9:
      addgun("rand_shotgun");
      addgun("rand_shotgun");
      addgun("rand_shotgun");
      addgun("rand_shotgun_division");
      break;
    case 10:
      addgun("rand_pistol");
      addgun("rand_pistol");
      addgun("rand_pistol");
      break;
    case 11:
      addgun("rand_pistol_akimbo");
      addgun("rand_pistol_akimbo");
      addgun("rand_pistol_akimbo");
      break;
    case 12:
      addgun("rand_launcher");
      addgun("rand_launcher");
      break;
  }

  switch (level.gun_weaponorder) {
    case 0:
    default:
      break;
    case 1:
      level.gun_guns_raw = common_scripts\utility::array_randomize(level.gun_guns_raw);
      break;
    case 2:
      level.gun_guns_raw = common_scripts\utility::_id_0FA2(level.gun_guns_raw);
      break;
  }

  switch (level.gun_weaponlistend) {
    case 0:
    default:
      addgun("rand_melee_end");
      break;
    case 1:
      addgun("rand_launcher");
      break;
    case 2:
      addgun("rand_pistol_akimbo");
      break;
    case 3:
      addgun("rand_shotgun_sniper");
      break;
    case 4:
      addgun("rand_sniper_iron");
      break;
    case 5:
      addgun("rand_fire_molotov");
      break;
    case 6:
      addgun("rand_fire_flamethrower");
      break;
    case 7:
      addgun("rand_satchel_end");
      break;
    case 8:
      break;
  }

  thread setgunsfinal();
}

setgunsfinal() {
  level.gungameweaponnamelist = [];
  buildrandomweapontable();
  var_0 = [];
  var_1 = _tablegetcolumncount("mp/attachmentcombos_mtx12.csv");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = _tablelookupbyrow("mp/attachmentcombos_mtx12.csv", 0, var_2);
    var_0[var_3] = var_2;
  }

  if(!isDefined(level.attachmentmap_uniquetobase)) {
    maps\mp\_utility::buildattachmentmaps();
  }

  level.gun_guns = [];

  for(var_4 = 0; var_4 < level.gun_guns_raw.size; var_4++) {
    var_5 = level.gun_guns_raw[var_4];

    if(maps\mp\_utility::isstrstart(var_5, "rand_")) {
      level.gun_guns[level.gun_guns.size] = getrandomweaponfromcategory(var_5, var_0);
      continue;
    }

    level.gun_guns[level.gun_guns.size]["builtWeaponName"] = var_5;
  }

  level.gungameweaponnamelist = undefined;
}

buildrandomweapontable() {
  level.gungameoptionstable = [];
  var_0 = _tablegetrowcount("mp/gunGameTable.csv");

  for(var_1 = 1; var_1 < var_0; var_1++) {
    var_2 = _tablelookupbyrow("mp/gunGameTable.csv", var_1, 0);

    if(var_2 == "") {
      break;
    }

    if(!isDefined(level.gungameoptionstable[var_2])) {
      level.gungameoptionstable[var_2] = [];
    }

    var_3 = [];
    var_3["categoryName"] = var_2;
    var_3["weaponName"] = _tablelookupbyrow("mp/gunGameTable.csv", var_1, 1);
    var_3["minAttachments"] = int(_tablelookupbyrow("mp/gunGameTable.csv", var_1, 5));
    var_3["maxAttachments"] = int(_tablelookupbyrow("mp/gunGameTable.csv", var_1, 6));
    var_3["forcedAttachments"] = _tablelookupbyrow("mp/gunGameTable.csv", var_1, 2);
    var_3["forcedAttachments"] = strtok(var_3["forcedAttachments"], "+");
    var_3["banOptic"] = 1 == int(_tablelookupbyrow("mp/gunGameTable.csv", var_1, 4));
    var_3["forceAltMode"] = 1 == int(_tablelookupbyrow("mp/gunGameTable.csv", var_1, 3));
    var_3["division"] = int(_tablelookupbyrow("mp/gunGameTable.csv", var_1, 7));
    var_3["allowedVariants"] = _tablelookupbyrow("mp/gunGameTable.csv", var_1, 8);
    var_3["allowedVariants"] = strtok(var_3["allowedVariants"], "+");
    var_3["forcedLethal"] = _tablelookupbyrow("mp/gunGameTable.csv", var_1, 9);
    level.gungameoptionstable[var_2][level.gungameoptionstable[var_2].size] = var_3;
  }
}

getrandomweaponfromcategory(var_0, var_1) {
  var_2 = level.gungameoptionstable[var_0];

  if(isDefined(var_2) && var_2.size > 0) {
    var_2 = common_scripts\utility::array_randomize(var_2);
    var_3 = undefined;

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_3 = var_2[var_4];

      if(isDefined(level.gungameweaponnamelist[var_3["weaponName"]]) && level.gungameweaponnamelist[var_3["weaponName"]]) {
        continue;
      }
      if(!level.gun_usevariants || var_3["allowedVariants"].size > 0) {
        break;
      }
    }

    if(!isDefined(var_3)) {
      return undefined;
    }

    var_5 = var_3["weaponName"];
    level.gungameweaponnamelist[var_5] = 1;
    var_6 = 0;

    if(level.gun_usevariants) {
      if(var_3["allowedVariants"].size > 0) {
        var_7 = common_scripts\utility::random(var_3["allowedVariants"]);
        var_7 = strtok(var_7, ":");
        var_8 = int(var_7[0]) - 1;
        var_6 = int(var_7[1]);
        var_5 = maps/aachen_b_precache(var_5, "_mp");
        var_5 = var_5 + "_loot" + var_8 + "_mp";
      } else if(var_5 != "killstreak_molotov_cocktail_mp" && var_5 != "flamethrower_mp" && var_5 != "flamethrower_german_mp" && var_0 != "rand_equipment")
        return undefined;
    }

    var_9 = [];

    if(level.gun_weaponattachments) {
      var_9 = var_3["forcedAttachments"];
      var_10 = _randomintrange(var_3["minAttachments"], var_3["maxAttachments"] + 1);
      var_9 = common_scripts\utility::_id_0F8C(var_9, getattachmentsforweapon(var_3, var_10, var_1, var_9));
    }

    var_11 = [];

    for(var_4 = 0; var_4 < var_9.size; var_4++) {
      var_11[var_4] = maps\mp\_utility::_id_452A(var_9[var_4]);
    }

    for(var_4 = var_9.size; var_4 < 6; var_4++) {
      var_11[var_4] = 0;
    }

    var_12 = maps\mp\gametypes\_class::buildweaponname(var_5, var_11[0], var_11[1], var_11[2], var_11[3], var_11[4], var_11[5], var_6, 0, 0, 0, 0, undefined, 5);

    if(level.gun_weaponattachments && var_3["forceAltMode"]) {
      var_12 = "alt+" + var_12;
    }

    var_3["builtWeaponName"] = var_12;
    return var_3;
  } else
    return undefined;
}

getattachmentsforweapon(var_0, var_1, var_2, var_3) {
  if(var_1 <= 0) {
    return [];
  }

  var_4 = var_0["weaponName"];
  var_5 = _getweaponattachmentsbasenames(var_4);
  var_5 = common_scripts\utility::array_randomize(var_5);
  var_6 = var_3;
  var_7 = [];

  for(var_8 = 0; var_8 < var_5.size; var_8++) {
    var_9 = 0;
    var_10 = var_5[var_8];

    if(_id_04CB::_id_56CA(var_4, var_10)) {
      var_9 = 1;
    }

    if(!var_9 && var_0["banOptic"] && (issubstr(var_10, "iron_sight") || issubstr(var_10, "telescopic_sight") || issubstr(var_10, "lens_sight") || issubstr(var_10, "aperture_sight"))) {
      var_9 = 1;
    }

    if(!var_9 && (issubstr(var_10, "special_grip") || issubstr(var_10, "akimbo") || issubstr(var_10, "m30_rifle") || issubstr(var_10, "tactical_knife") || issubstr(var_10, "suppressor")) || issubstr(var_10, "bipod") || issubstr(var_10, "hold_breath") || issubstr(var_10, "extended_mag") || issubstr(var_10, "bayonet") || issubstr(var_10, "grenade_launcher")) {
      var_9 = 1;
    }

    if(!var_9 && isDefined(var_6) && var_6.size > 0) {
      foreach(var_12 in var_6) {
        if(isDefined(var_2[var_12])) {
          var_13 = tablelookup("mp/attachmentcombos_mtx12.csv", 0, var_10, var_2[var_12]);

          if(isDefined(var_13) && var_13 != "") {
            var_9 = 1;
            break;
          }
        }
      }
    }

    if(!var_9) {
      var_6[var_6.size] = var_10;
      var_7[var_7.size] = var_10;

      if(var_7.size >= var_1) {
        break;
      }
    }
  }

  return var_7;
}