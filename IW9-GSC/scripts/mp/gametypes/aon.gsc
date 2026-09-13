/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\aon.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 20);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_094024C05E74D1A1();
  updategametypedvars();
  level.teambased = 0;
  setteammode("ffa");
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerscore = ::onplayerscore;
  level.onplayerconnect = ::onplayerconnect;
  level.blockweapondrops = 1;
  level.denyclasschoice = 1;
  level.bypassclasschoicefunc = scripts\mp\class::alwaysgamemodeclass;
  _id_0FD32F08E72B657F::addspecialistdialog();
  _id_E88D9EC1D5270BAD();
  level.bots_gametype_handles_class_choice = 1;
  game["dialog"]["gametype"] = "gametype_aon";
  game["dialog"]["ffa_lead_first"] = "iw9_mffa_mode_uktl_ffp1";
  game["dialog"]["ffa_lead_second"] = "iw9_mffa_mode_uktl_ffp2";
  game["dialog"]["ffa_lead_third"] = "iw9_mffa_mode_uktl_ffp3";
  game["dialog"]["ffa_lead_last"] = "iw9_mffa_mode_uktl_ffp3";
  game["dialog"]["offense_obj"] = "iw9_mffa_mode_uktl_bost";
  game["dialog"]["defense_obj"] = "iw9_mffa_mode_uktl_bost";
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawn);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_51F7D7A1E73CE81D", getmatchrulesdata("aonData", "perkRef1"));
  setdynamicdvar("dvar_66E3421F64DE8BB8", getmatchrulesdata("aonData", "perkRef2"));
  setdynamicdvar("dvar_48D22D4340BDAF5F", getmatchrulesdata("aonData", "perkRef3"));
  setdynamicdvar("dvar_36CD4F12C763E1FA", getmatchrulesdata("aonData", "perkRef4"));
  setdynamicdvar("dvar_7954A01F18F7FF09", getmatchrulesdata("aonData", "perkKills1"));
  setdynamicdvar("dvar_E544E1784E62977C", getmatchrulesdata("aonData", "perkKills2"));
  setdynamicdvar("dvar_B7DF94EF10AB8413", getmatchrulesdata("aonData", "perkKills3"));
  setdynamicdvar("dvar_9CE4576A217F3616", getmatchrulesdata("aonData", "perkKills4"));
  setdynamicdvar("scr_war_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("scr_war_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/WAR");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/WAR_HINT");
  }

  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dm_spawn_start", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  setomnvar("ui_disable_killstreaks", 1);
  setomnvar("ui_disable_fieldupgrades", 1);
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level._id_2F35CB1FB5F0D1BE[0].ref = getDvar("dvar_51F7D7A1E73CE81D", "specialty_scavenger_plus");
  level._id_2F35CB1FB5F0D1BE[0].kills = getdvarint("dvar_7954A01F18F7FF09", 1);
  level._id_2F35CB1FB5F0D1BE[1].ref = getDvar("dvar_66E3421F64DE8BB8", "specialty_hustle");
  level._id_2F35CB1FB5F0D1BE[1].kills = getdvarint("dvar_E544E1784E62977C", 1);
  level._id_2F35CB1FB5F0D1BE[2].ref = getDvar("dvar_48D22D4340BDAF5F", "specialty_grenade_expert");
  level._id_2F35CB1FB5F0D1BE[2].kills = getdvarint("dvar_B7DF94EF10AB8413", 1);
  level._id_2F35CB1FB5F0D1BE[3].ref = getDvar("dvar_36CD4F12C763E1FA", "specialty_restock");
  level._id_2F35CB1FB5F0D1BE[3].kills = getdvarint("dvar_9CE4576A217F3616", 1);
}

getspawnpoint() {
  spawnpoint = undefined;

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");

    if(!isDefined(level.requiresminstartspawns)) {}

    if(spawnpoints.size > 0)
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints, 1);

    if(!isDefined(spawnpoint)) {
      spawnpoints = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      spawnpoint = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(spawnpoints);
    }
  } else
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, "none", "normal", "fallback");

  return spawnpoint;
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

onplayerscore(event, player, _id_353F1E80E9476419, victim, _id_7EC7671A1E0C788F) {
  player scripts\mp\utility\stats::incpersstat("gamemodeScore", _id_353F1E80E9476419);
  _id_C82F49D7E44EB40D = int(player scripts\mp\utility\stats::getpersstat("gamemodeScore"));
  player scripts\mp\persistence::statsetchild("round", "gamemodeScore", _id_C82F49D7E44EB40D);

  if(event != "stat_EF9582D72160F199")
    return 0;

  if(player._id_C393133EB539CB6F < level._id_2F35CB1FB5F0D1BE.size) {
    player._id_1F60935B8C07D0DA++;
    _id_BAF2E061187EAE3A = clamp(player._id_1F60935B8C07D0DA / player._id_20B605AC2F213F6D, 0.0, 1.0);
    player setclientomnvar(level._id_2F35CB1FB5F0D1BE[player._id_C393133EB539CB6F]._id_B771CCC29A7C4099, _id_BAF2E061187EAE3A);

    if(_id_BAF2E061187EAE3A >= 1.0) {
      player scripts\mp\utility\perk::giveperk(level._id_2F35CB1FB5F0D1BE[player._id_C393133EB539CB6F].ref);
      player setclientomnvar(level._id_2F35CB1FB5F0D1BE[player._id_C393133EB539CB6F]._id_9F0625676FF25429, 1);
      player._id_C393133EB539CB6F++;

      if(player._id_C393133EB539CB6F < level._id_2F35CB1FB5F0D1BE.size) {
        player._id_1F60935B8C07D0DA = 0;
        player._id_20B605AC2F213F6D = level._id_2F35CB1FB5F0D1BE[player._id_C393133EB539CB6F].kills;
      }
    }
  }

  return scripts\mp\rank::getscoreinfovalue("stat_CADE9C820001F3BF");
}

onplayerconnect(player) {
  player scripts\mp\class::_id_A16868D4DCD81A4B();
  player.pers["gamemodeLoadout"] = level._id_A955231DDEC95FAF;
  primaryweapon = player.pers["gamemodeLoadout"]["loadoutPrimary"];
  secondaryweapon = player.pers["gamemodeLoadout"]["loadoutSecondary"];
  player loadweaponsforplayer([primaryweapon, secondaryweapon], 1);
}

onplayerspawn() {
  scripts\engine\utility::flag_wait("aon_perks_registered");
  _id_2C5507ACFC56949D(self);
  _id_BC342804FA29FA70(self);
  self._id_1F60935B8C07D0DA = 0;
  self._id_C393133EB539CB6F = 0;
  self._id_20B605AC2F213F6D = level._id_2F35CB1FB5F0D1BE[0].kills;
}

_id_094024C05E74D1A1() {
  level._id_2F35CB1FB5F0D1BE = [];
  level._id_2F35CB1FB5F0D1BE[0] = spawnStruct();
  level._id_2F35CB1FB5F0D1BE[0].ref = "none";
  level._id_2F35CB1FB5F0D1BE[0].kills = 1;
  level._id_2F35CB1FB5F0D1BE[0]._id_B771CCC29A7C4099 = "ui_aon_perk_progress_0";
  level._id_2F35CB1FB5F0D1BE[0]._id_9F0625676FF25429 = "ui_aon_perk_splash_0";
  level._id_2F35CB1FB5F0D1BE[1] = spawnStruct();
  level._id_2F35CB1FB5F0D1BE[1].ref = "none";
  level._id_2F35CB1FB5F0D1BE[1].kills = 1;
  level._id_2F35CB1FB5F0D1BE[1]._id_B771CCC29A7C4099 = "ui_aon_perk_progress_1";
  level._id_2F35CB1FB5F0D1BE[1]._id_9F0625676FF25429 = "ui_aon_perk_splash_1";
  level._id_2F35CB1FB5F0D1BE[2] = spawnStruct();
  level._id_2F35CB1FB5F0D1BE[2].ref = "none";
  level._id_2F35CB1FB5F0D1BE[2].kills = 1;
  level._id_2F35CB1FB5F0D1BE[2]._id_B771CCC29A7C4099 = "ui_aon_perk_progress_2";
  level._id_2F35CB1FB5F0D1BE[2]._id_9F0625676FF25429 = "ui_aon_perk_splash_2";
  level._id_2F35CB1FB5F0D1BE[3] = spawnStruct();
  level._id_2F35CB1FB5F0D1BE[3].ref = "none";
  level._id_2F35CB1FB5F0D1BE[3].kills = 1;
  level._id_2F35CB1FB5F0D1BE[3]._id_B771CCC29A7C4099 = "ui_aon_perk_progress_3";
  level._id_2F35CB1FB5F0D1BE[3]._id_9F0625676FF25429 = "ui_aon_perk_splash_3";
  scripts\engine\utility::flag_set("aon_perks_registered");
}

_id_2C5507ACFC56949D(player) {
  level endon("game_ended");
  player endon("disconnect");

  foreach(weapon in player.weaponlist) {
    if(isDefined(weapon) && !istrue(weapon.ismelee)) {
      player setweaponammoclip(weapon, 0);
      player setweaponammostock(weapon, 0);
    }
  }
}

_id_E88D9EC1D5270BAD() {
  level._id_A955231DDEC95FAF = [];
  level._id_A955231DDEC95FAF["loadoutPrimary"] = "iw9_me_knife_mp";
  level._id_A955231DDEC95FAF["loadoutPrimaryAttachment"] = "none";
  level._id_A955231DDEC95FAF["loadoutPrimaryAttachment2"] = "none";
  level._id_A955231DDEC95FAF["loadoutPrimaryCamo"] = "none";
  level._id_A955231DDEC95FAF["loadoutPrimaryReticle"] = "none";
  level._id_A955231DDEC95FAF["loadoutPrimaryVariantID"] = 0;
  level._id_A955231DDEC95FAF["loadoutSecondary"] = "iw9_pi_golf17_mp";
  level._id_A955231DDEC95FAF["loadoutSecondaryAttachment"] = "none";
  level._id_A955231DDEC95FAF["loadoutSecondaryAttachment2"] = "none";
  level._id_A955231DDEC95FAF["loadoutSecondaryCamo"] = "none";
  level._id_A955231DDEC95FAF["loadoutSecondaryReticle"] = "none";
  level._id_A955231DDEC95FAF["loadoutSecondaryVariantID"] = 0;
  level._id_A955231DDEC95FAF["loadoutEquipmentPrimary"] = "equip_throwing_knife";
  level._id_A955231DDEC95FAF["loadoutEquipmentSecondary"] = "none";
  level._id_A955231DDEC95FAF["loadoutSuper"] = "none";
  level._id_A955231DDEC95FAF["loadoutStreakType"] = "assault";
  level._id_A955231DDEC95FAF["loadoutKillstreak1"] = "none";
  level._id_A955231DDEC95FAF["loadoutKillstreak2"] = "none";
  level._id_A955231DDEC95FAF["loadoutKillstreak3"] = "none";
  level._id_A955231DDEC95FAF["loadoutUsingSpecialist"] = 1;
  level._id_A955231DDEC95FAF["loadoutPerks"] = ["specialty_null"];
  level._id_A955231DDEC95FAF["loadoutExtraPerks"] = ["specialty_null"];
  level._id_A955231DDEC95FAF["loadoutGesture"] = "playerData";
  level._id_A955231DDEC95FAF["loadoutFieldUpgrade1"] = "none";
  level._id_A955231DDEC95FAF["loadoutFieldUpgrade2"] = "none";
}

_id_BC342804FA29FA70(player) {
  player setclientomnvar("ui_spawn_perk_0", level._id_2F35CB1FB5F0D1BE[0].ref);
  player setclientomnvar("ui_spawn_perk_1", level._id_2F35CB1FB5F0D1BE[1].ref);
  player setclientomnvar("ui_spawn_perk_2", level._id_2F35CB1FB5F0D1BE[2].ref);
  player setclientomnvar("ui_spawn_perk_3", level._id_2F35CB1FB5F0D1BE[3].ref);
  player setclientomnvar(level._id_2F35CB1FB5F0D1BE[0]._id_B771CCC29A7C4099, 0.0);
  player setclientomnvar(level._id_2F35CB1FB5F0D1BE[1]._id_B771CCC29A7C4099, 0.0);
  player setclientomnvar(level._id_2F35CB1FB5F0D1BE[2]._id_B771CCC29A7C4099, 0.0);
  player setclientomnvar(level._id_2F35CB1FB5F0D1BE[3]._id_B771CCC29A7C4099, 0.0);
  player setclientomnvar(level._id_2F35CB1FB5F0D1BE[0]._id_9F0625676FF25429, 0);
  player setclientomnvar(level._id_2F35CB1FB5F0D1BE[1]._id_9F0625676FF25429, 0);
  player setclientomnvar(level._id_2F35CB1FB5F0D1BE[2]._id_9F0625676FF25429, 0);
  player setclientomnvar(level._id_2F35CB1FB5F0D1BE[3]._id_9F0625676FF25429, 0);
}