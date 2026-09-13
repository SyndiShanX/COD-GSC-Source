/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\infect.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  matchmakingmatch = getdvarint("onlinegame") && !getdvarint("xblive_privatematch");

  if(matchmakingmatch)
    level.isgroundwarinfected = getdvarint("dvar_119729A5FCBD2AAB", 0);

  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[_id_9BBACB179DEA3237.size] = "grnd";

  if(istrue(level.isgroundwarinfected))
    _id_9BBACB179DEA3237[_id_9BBACB179DEA3237.size] = "arm";

  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\dvars::setoverridewatchdvar("scorelimit", 0);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.extratimeincreasecount = 0;
  level.extratimeincreasecountcap = getdvarint("dvar_12925902A8E3C314", 20);
  level.ignorekdrstats = 1;
  level.didhalfscorevoboost = 0;
  thread waitthensetstatgroupreadonly();
  level.teambased = 1;
  level.supportintel = 0;
  level.disableforfeit = 1;
  level.nobuddyspawns = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.modeonspawnplayer = ::onspawnplayer;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.onnormaldeath = ::onnormaldeath;
  level.ondeadevent = ::ondeadevent;
  level.ontimelimit = ::ontimelimit;
  level.bypassclasschoicefunc = scripts\mp\class::alwaysgamemodeclass;
  level.addjuggsettings = ::infectjugg_setconfig;
  level.gamemodespawnprotectedcallback = ::gamemodespawnprotectedcallback;
  level._id_29F84151A47F0A35 = ::_id_48C5A587383A90E7;
  level.disablecopycatloadout = 1;
  setomnvar("ui_killcam_copycat", 0);
  level.infectednightmode = getdvarint("dvar_298B7643D2BD0413", 0);
  level.infecteddisablenvg = getdvarint("dvar_B236732B505B9983", 0);
  level.onlineprimaryoverride = getdvarint("dvar_2712996CCB16A4DE", 0);

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_infc_mode_uktl_int1";
  else
    game["dialog"]["gametype"] = "iw9_infc_mode_uktl_name";

  game["dialog"]["boost"] = "iw9_infc_mode_uktl_bost";
  game["dialog"]["offense_obj"] = "iw9_infc_mode_uktl_bost";
  game["dialog"]["defense_obj"] = "iw9_infc_mode_uktl_bost";
  game["dialog"]["infected_first"] = "iw9_infc_mode_uktl_inf1";
  game["dialog"]["halfway_enemy_score"] = "iw9_infc_mode_uktl_ihls";
  game["dialog"]["halfway_friendly_score"] = "iw9_infc_mode_uktl_ihfr";
  game["dialog"]["infected_lastalive"] = "iw9_infc_mode_uktl_infl";
}

waitthensetstatgroupreadonly() {
  self endon("game_ended");
  wait 1;

  if(isDefined(level.playerstats)) {
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("kdr");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("losses");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("winLoss");
  }
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_infect_numinitialinfected", getmatchrulesdata("infectData", "numInitialInfected"));
  setdynamicdvar("scr_infect_weaponsurvivorprimary", getmatchrulesdata("infectData", "weaponSurvivorPrimary"));
  setdynamicdvar("scr_infect_weaponsurvivorsecondary", getmatchrulesdata("infectData", "weaponSurvivorSecondary"));
  setdynamicdvar("scr_infect_lethalsurvivor", getmatchrulesdata("infectData", "lethalSurvivor"));
  setdynamicdvar("scr_infect_tacticalsurvivor", getmatchrulesdata("infectData", "tacticalSurvivor"));
  setdynamicdvar("scr_infect_supersurvivor", getmatchrulesdata("infectData", "superSurvivor"));
  setdynamicdvar("scr_infect_supersurvivortwo", getmatchrulesdata("infectData", "superSurvivorTwo"));
  setdynamicdvar("scr_infect_weaponinfectprimary", getmatchrulesdata("infectData", "weaponInfectPrimary"));
  setdynamicdvar("scr_infect_weaponinfectsecondary", getmatchrulesdata("infectData", "weaponInfectSecondary"));
  setdynamicdvar("scr_infect_lethalinfect", getmatchrulesdata("infectData", "lethalInfect"));
  setdynamicdvar("scr_infect_tacticalinfect", getmatchrulesdata("infectData", "tacticalInfect"));
  setdynamicdvar("scr_infect_weaponinitialprimary", getmatchrulesdata("infectData", "weaponInitialPrimary"));
  setdynamicdvar("scr_infect_weaponinitialsecondary", getmatchrulesdata("infectData", "weaponInitialSecondary"));
  setdynamicdvar("scr_infect_superinfect", getmatchrulesdata("infectData", "superInfect"));
  setdynamicdvar("dvar_BFAD61C7EDF9BA5B", getmatchrulesdata("infectData", "superInfectTwo"));
  setdynamicdvar("scr_infect_infectextratimeperkill", getmatchrulesdata("infectData", "infectExtraTimePerKill"));
  setdynamicdvar("scr_infect_survivoralivescore", getmatchrulesdata("infectData", "survivorAliveScore"));
  setdynamicdvar("scr_infect_survivorscoretime", getmatchrulesdata("infectData", "survivorScoreTime"));
  setdynamicdvar("scr_infect_survivorscorepertick", getmatchrulesdata("infectData", "survivorScorePerTick"));
  setdynamicdvar("scr_infect_infectstreakbonus", getmatchrulesdata("infectData", "infectStreakBonus"));
  setdynamicdvar("scr_infect_enableinfectedtracker", getmatchrulesdata("infectData", "enableInfectedTracker"));
  setdynamicdvar("scr_infect_enableping", getmatchrulesdata("infectData", "enablePing"));
  setdynamicdvar("scr_infect_giveTKOnTISpawn", getmatchrulesdata("infectData", "giveTKOnTISpawn"));
  setdynamicdvar("scr_team_fftype", 0);
  setdynamicdvar("scr_infect_promode", 0);
  _id_EB86A5CD1650B4AF = getdvarint("dvar_631ED7C8A44A2B15", 0);

  if(_id_EB86A5CD1650B4AF != getdvarint("scr_thirdperson", 0))
    setdynamicdvar("scr_thirdperson", _id_EB86A5CD1650B4AF);
}

onstartgametype() {
  setclientnamemode("auto_change");

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/INFECT");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/INFECT");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/INFECT_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/INFECT_HINT");
  }

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    scripts\cp_mp\parachute::initparachutedvars();

    if(!isDefined(level._id_624C83B532EFCE04))
      level._id_624C83B532EFCE04 = getdvarint("dvar_DDEE91E1CB8A1829", 1);

    level.infectparachuteheightoffset = getdvarint("dvar_11C720F90B371E56", 3000);
    level.alwaysdoskyspawnontacinsert = getdvarint("dvar_9F8C0B29C8FB3BEF", 0);
    level.skydiveontacinsertplacement = getdvarint("dvar_497ACC345B08A223", 0);
    level.allowskydivecutparachute = getdvarint("dvar_756DCD63DD986F4C", 0);
    level._id_BB88666E1E748431 = getdvarfloat("dvar_AE7EC88A72783B3E", 2.0);
    level.perkpackage_checkifready_callback = ::perkpackage_checkifready_callback;
    level.tacinsert_gamemode_callback = ::tacinsert_gamemode_callback;
    level._id_F91A05BC873BD121 = ::_id_911CBBEBF68AF0D8;
  }

  initspawns();
  level.quickmessagetoall = 1;
  level.blockweapondrops = 1;
  level.infect_allowsuicide = 0;
  level.infect_skipsounds = 0;
  level.playgotinfectedsoundcount = 0;
  level.infect_chosefirstinfected = 0;
  level.infect_choosingfirstinfected = 0;
  level.infect_teamscores["axis"] = 0;
  level.infect_teamscores["allies"] = 0;
  level.infect_players = [];
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", ::vehicle_compass_infect_shouldbevisibletoplayer);

  if(istrue(level.isgroundwarinfected)) {
    _id_3BA4F32E41F63B36::emergency_cleanupents();
    thread init_infectgroundwarvehicles();
    thread _id_4B1E3F35C961E700();
  }
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.numinitialinfected = scripts\mp\utility\dvars::dvarintvalue("numInitialInfected", 1, 1, 9);
  level.survivorprimaryweapon = getDvar("scr_infect_weaponsurvivorprimary", "iw9_sh_mbravo_mp");
  level.survivorsecondaryweapon = getDvar("scr_infect_weaponsurvivorsecondary", "iw9_pi_golf17_mp");
  level.survivorlethal = getDvar("scr_infect_lethalsurvivor", "equip_claymore");
  level.survivortactical = getDvar("scr_infect_tacticalsurvivor", "equip_concussion");
  level.survivorsuper = getDvar("scr_infect_supersurvivor", "super_tac_cover");
  level.survivorsupertwo = getDvar("scr_infect_supersurvivortwo", "none");
  level.infectedprimaryweapon = getDvar("scr_infect_weaponinfectprimary", "iw9_me_knife_mp");
  level.infectedsecondaryweapon = getDvar("scr_infect_weaponinfectsecondary", "iw9_me_fists_mp");
  level.initialprimaryweapon = getDvar("scr_infect_weaponinitialprimary", "iw9_sh_mbravo_mp");
  level.initialsecondaryweapon = getDvar("scr_infect_weaponinitialsecondary", "iw9_pi_golf17_mp");
  level.infectedlethal = getDvar("scr_infect_lethalinfect", "equip_throwing_knife");
  level.infectedtactical = getDvar("scr_infect_tacticalinfect", "equip_tac_insert");
  level.infectedsuper = getDvar("scr_infect_superinfect", "super_deadsilence");
  level.infectedsupertwo = getDvar("dvar_BFAD61C7EDF9BA5B", "none");
  level.infectextratimeperkill = scripts\mp\utility\dvars::dvarfloatvalue("infectExtraTimePerKill", 30, 0, 60);
  level.survivoralivescore = scripts\mp\utility\dvars::dvarintvalue("survivorAliveScore", 25, 0, 100);
  level.survivorscoretime = scripts\mp\utility\dvars::dvarfloatvalue("survivorScoreTime", 30, 0, 60);
  level.survivorscorepertick = scripts\mp\utility\dvars::dvarintvalue("survivorScorePerTick", 50, 0, 100);
  level.infectstreakbonus = scripts\mp\utility\dvars::dvarintvalue("infectStreakBonus", 50, 0, 100);
  level.enableinfectedtracker = scripts\mp\utility\dvars::dvarintvalue("enableInfectedTracker", 0, 0, 1);
  level.enableping = scripts\mp\utility\dvars::dvarintvalue("enablePing", 0, 0, 1);
  level.givetkontispawn = scripts\mp\utility\dvars::dvarintvalue("giveTKOnTISpawn", 0, 0, 1);
  level.infectbonusscore = getdvarint("scr_infect_infectBonusScore", 150);
  level.infectbonussuperonspawn = getdvarint("dvar_3CF02BA1288E7934", 0);
  level.infectbonussuperontacinsert = getdvarint("dvar_21521ABC03C44042", 0);
  level._id_5B8EACB759C64658 = getdvarint("dvar_79432649C9607465", 20);
  level._id_6466716A73FF8F0B = getdvarint("dvar_E72561ACFDEA085A", 3);
  level._id_5AAA30C2942D7A75 = getdvarint("dvar_B577C0842850BF7E", 24);
  level._id_6F84C741AB4B49D1 = getdvarint("dvar_2748C18C28569B64", 1);
  level.survivorstreakoverride = [];
  survivorstreakoverride = getDvar("dvar_57BBA4DA542DFA17", "");

  if(survivorstreakoverride != "")
    level.survivorstreakoverride = strtok(survivorstreakoverride, ",");

  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  if(issubstr(mapname, "mp_m_") && mapname != "mp_m_speed") {
    level.survivorsuper = fixupsupersandtacticalsforgunfightmaps(0, 0);
    level.survivorsupertwo = fixupsupersandtacticalsforgunfightmaps(0, 1);
    level.infectedsuper = fixupsupersandtacticalsforgunfightmaps(1, 0);
    level.infectedsupertwo = fixupsupersandtacticalsforgunfightmaps(1, 1);
  }

  if(level.survivorsuper == level.survivorsupertwo)
    level.survivorsupertwo = "none";
  else if(level.survivorsuper == "none" && level.survivorsupertwo != "none") {
    level.survivorsuper = level.survivorsupertwo;
    level.survivorsupertwo = "none";
  }

  if(level.infectedsuper == level.infectedsupertwo)
    level.infectedsupertwo = "none";
  else if(level.infectedsuper == "none" && level.infectedsupertwo != "none") {
    level.infectedsuper = level.infectedsupertwo;
    level.infectedsupertwo = "none";
  }

  thread buildandloadweapons();
}

_id_3AEE9E3BC9B34C5F() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.allweapons.size; _id_AC0E594AC96AA3A8++) {
    weaponname = level.allweapons[_id_AC0E594AC96AA3A8];

    if(weaponname == "none") {
      continue;
    }
    if(getsubstr(weaponname, weaponname.size - 3) != "_mp")
      level.allweapons[_id_AC0E594AC96AA3A8] = level.allweapons[_id_AC0E594AC96AA3A8] + "_mp";
  }
}

buildandloadweapons() {
  waitframe();

  if(level.onlineprimaryoverride) {
    switch (level.survivorprimaryweapon) {
      case "iw8_sh_dpapa12":
        level.arenaloadouts = 10;
        break;
      case "iw8_ar_akilo47":
        level.arenaloadouts = 7;
        break;
      case "iw8_pi_decho":
        level.arenaloadouts = 9;
        break;
      case "iw8_sm_papa90":
        level.arenaloadouts = 8;
        break;
      case "iw8_sn_alpha50":
        level.arenaloadouts = 11;
        break;
      default:
        level.arenaloadouts = 7;
        break;
    }

    game["arenaRandomLoadout"] = scripts\engine\utility::array_randomize(game["arenaLoadouts"]);
    level.survivorprimaryweapon = game["arenaRandomLoadout"][0]["loadoutPrimary"];

    if(game["arenaRandomLoadout"][0]["loadoutSecondary"] != "none")
      level.survivorsecondaryweapon = game["arenaRandomLoadout"][0]["loadoutSecondary"];

    level.initialprimaryweapon = game["arenaRandomLoadout"][0]["loadoutPrimary"];

    if(game["arenaRandomLoadout"][0]["loadoutSecondary"] != "none")
      level.initialsecondaryweapon = game["arenaRandomLoadout"][0]["loadoutSecondary"];
  }

  level.allweapons = [];
  level.allweapons[level.allweapons.size] = level.survivorprimaryweapon;
  level.allweapons[level.allweapons.size] = level.survivorsecondaryweapon;
  level.allweapons[level.allweapons.size] = level.infectedprimaryweapon;
  level.allweapons[level.allweapons.size] = level.infectedsecondaryweapon;
  level.allweapons[level.allweapons.size] = level.initialprimaryweapon;
  level.allweapons[level.allweapons.size] = level.initialsecondaryweapon;
  level.allweapons = scripts\engine\utility::array_remove_duplicates(level.allweapons);
  _id_3AEE9E3BC9B34C5F();

  foreach(weapon in level.allweapons) {
    if(weapon != "none") {
      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
      _id_657BBAA6EE802E63 = [];

      if(level.onlineprimaryoverride) {
        if(weapon == level.allweapons[0] || weapon == level.allweapons[4]) {
          for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
            _id_AB0F600188412CF1 = _id_AC0E594AC96AA3A8;

            if(_id_AC0E594AC96AA3A8 == 1)
              _id_AB0F600188412CF1 = "";

            attachment = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment" + _id_AB0F600188412CF1];

            if(attachment != "none")
              _id_657BBAA6EE802E63[_id_657BBAA6EE802E63.size] = attachment;
          }
        }

        if(weapon == level.allweapons[1] || weapon == level.allweapons[5]) {
          for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
            _id_AB0F600188412CF1 = _id_AC0E594AC96AA3A8;

            if(_id_AC0E594AC96AA3A8 == 1)
              _id_AB0F600188412CF1 = "";

            attachment = game["arenaRandomLoadout"][0]["loadoutSecondaryAttachment" + _id_AB0F600188412CF1];

            if(attachment != "none")
              _id_657BBAA6EE802E63[_id_657BBAA6EE802E63.size] = attachment;
          }
        }
      }

      if(level.infectednightmode)
        game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment"] = getthermalscopeperweaponclass();

      _id_CD825705B33212CB = "none";
      _id_6A42D475DFB96A31 = "none";
      _id_2CF0771420522CB6 = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, _id_657BBAA6EE802E63, _id_CD825705B33212CB, _id_6A42D475DFB96A31);
      _id_DD515FCF025B2E79 = getcompleteweaponname(_id_2CF0771420522CB6);
    }
  }

  level thread setspecialloadouts();
}

getthermalscopeperweaponclass() {
  weapon = game["arenaRandomLoadout"][0]["loadoutPrimary"] + "_mp";
  weapon_class = weaponclass(weapon);
  level.weapon_class = weapon_class;
  attachment = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment"];

  switch (weapon_class) {
    case "mg":
    case "rifle":
    case "smg":
      _id_EA0C0140406F46FA = randomintrange(0, 3);

      if(_id_EA0C0140406F46FA == 0)
        attachment = "thermal";
      else if(_id_EA0C0140406F46FA == 0)
        attachment = "thermal2";
      else
        attachment = "hybrid3";

      break;
    case "sniper":
      _id_EA0C0140406F46FA = randomintrange(0, 3);

      if(_id_EA0C0140406F46FA == 0)
        attachment = "thermal";
      else if(_id_EA0C0140406F46FA == 0)
        attachment = "thermal2";
      else
        attachment = "thermalvz";

      break;
    case "spread":
      attachment = "thermal";
    case "rocketlauncher":
      break;
    case "pistol":
      break;
    default:
      break;
  }

  return attachment;
}

stripweapsuffix(weaponname) {
  if(issubstr(weaponname, "mpr"))
    weaponname = scripts\mp\utility\script::strip_suffix(weaponname, "_mpr");
  else if(issubstr(weaponname, "mpl"))
    weaponname = scripts\mp\utility\script::strip_suffix(weaponname, "_mpl");
  else
    weaponname = scripts\mp\utility\script::strip_suffix(weaponname, "_mp");

  return weaponname;
}

fixupsupersandtacticalsforgunfightmaps(_id_CACEB3FF609E8C65, _id_B9949D9C8FF08844) {
  if(istrue(_id_B9949D9C8FF08844))
    super = scripts\engine\utility::ter_op(_id_CACEB3FF609E8C65, level.infectedsupertwo, level.survivorsupertwo);
  else
    super = scripts\engine\utility::ter_op(_id_CACEB3FF609E8C65, level.infectedsuper, level.survivorsuper);

  switch (super) {
    case "super_weapon_drop":
    case "super_emp_drone":
    case "super_recon_drone":
      super = "super_ammo_drop";
      break;
    case "super_tac_insert":
      if(_id_CACEB3FF609E8C65 && level.infectedtactical == "equip_tac_insert")
        level.infectedtactical = "none";
      else if(level.survivortactical == "equip_tac_insert")
        level.survivortactical = "none";

      break;
    case "super_trophy":
      if(_id_CACEB3FF609E8C65 && level.infectedtactical == "equip_trophy")
        level.infectedtactical = "none";
      else if(level.survivortactical == "equip_trophy")
        level.survivortactical = "none";

      break;
  }

  return super;
}

onplayerconnect(player) {
  player.gamemodefirstspawn = 1;
  player.gamemodejoinedatstart = 1;
  player.infectedrejoined = 0;
  player.waitedtospawn = 0;

  if(!scripts\mp\flags::gameflag("prematch_done") || istrue(level.infect_countdowninprogress))
    player.waitedtospawn = 1;

  player scripts\mp\class::_id_A16868D4DCD81A4B();
  player loadweaponsforplayer(level.allweapons, 1);

  if(scripts\mp\flags::gameflag("prematch_done")) {
    player.gamemodejoinedatstart = 0;

    if(isDefined(level.infect_chosefirstinfected) && level.infect_chosefirstinfected)
      player.survivalstarttime = gettime();
  }

  if(isDefined(level.infect_players[player.name]))
    player.infectedrejoined = 1;

  if(isDefined(player.isinitialinfected))
    player.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
  else if(player.infectedrejoined)
    player.pers["gamemodeLoadout"] = level.infect_loadouts["axis"];
  else
    player.pers["gamemodeLoadout"] = level.infect_loadouts["allies"];

  player thread monitorsurvivaltime();

  if(istrue(level.isgroundwarinfected) && istrue(level._id_624C83B532EFCE04))
    player thread skydivehintnotify();
}

givesurvivortimescore() {
  level endon("game_ended");

  for(;;) {
    wait(level.survivorscoretime);

    foreach(player in level.players) {
      if(player.team == "allies")
        player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F228812C2D41927F", undefined, level.survivorscorepertick);
    }
  }
}

initspawns() {
  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    level.gamemodestartspawnpointnames = [];
    _id_48501209A3E177A7 = "mp_gw_spawn_allies_start";
    _id_AE7D0107AD485428 = "mp_gw_spawn_axis_start";
    level.gamemodestartspawnpointnames["allies"] = _id_48501209A3E177A7;
    level.gamemodestartspawnpointnames["axis"] = _id_AE7D0107AD485428;
    level.gamemodespawnpointnames = [];
    level.gamemodespawnpointnames["allies"] = "mp_tdm_spawn";
    level.gamemodespawnpointnames["axis"] = "mp_tdm_spawn";
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);

    if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_aniyah")
      scripts\mp\spawnlogic::setactivespawnlogic("GroundWarTTLOS", "Crit_Default");
    else if(scripts\cp_mp\utility\game_utility::islargemap())
      scripts\mp\spawnlogic::setactivespawnlogic("GroundWar", "Crit_Default");
    else
      scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");

    scripts\mp\spawnlogic::addstartspawnpoints("mp_gw_spawn_allies_start");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_gw_spawn_axis_start");
    scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_gw_spawn_allies_start");
    scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_gw_spawn_axis_start");
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start");
    _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start");
    scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
    scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
    _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
    _id_29D9D2428185616D = _id_79F898A92FDBA4B2(_id_29D9D2428185616D);
    _id_3A5288F40C8BE099 = _id_79F898A92FDBA4B2(_id_3A5288F40C8BE099);
    scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
    scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
    _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
    _id_29D9D2428185616D = _id_79F898A92FDBA4B2(_id_29D9D2428185616D);
    _id_3A5288F40C8BE099 = _id_79F898A92FDBA4B2(_id_3A5288F40C8BE099);
    scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
    scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
  }
}

getspawnpoint() {
  if(isPlayer(self) && self.gamemodefirstspawn) {
    self.gamemodefirstspawn = 0;
    scripts\mp\class::_id_A16868D4DCD81A4B();
    _id_473FA7402CDB132B = "allies";

    if(self.infectedrejoined)
      _id_473FA7402CDB132B = "axis";

    scripts\mp\menus::addtoteam(_id_473FA7402CDB132B, 1);
    thread monitordisconnect();
  }

  if(level.ingraceperiod) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_random(spawnpoints);
  } else
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["team"], "normal", "fallback");

  return spawnpoint;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  self.teamchangedthisframe = undefined;
  self.infect_spawnpos = self.origin;
  self.infectedkillsthislife = 0;

  if(self.pers["team"] == "axis") {
    scripts\mp\battlechatter_mp::disablebattlechatter(self);

    if(istrue(level.isgroundwarinfected))
      self._id_4DA443F197C8014E = 1;

    if(istrue(level.allowskydivecutparachute))
      self skydive_cutparachuteon();
    else
      self skydive_cutparachuteoff();
  }

  updateteamscores();

  if(!level.infect_choosingfirstinfected) {
    level.infect_choosingfirstinfected = 1;
    level thread choosefirstinfected();
  }

  if(!scripts\mp\flags::gameflag("prematch_done") || istrue(level.infect_countdowninprogress))
    self.waitedtospawn = 0;

  if(self.infectedrejoined) {
    if(!level.infect_allowsuicide) {
      level notify("infect_stopCountdown");
      level.infect_chosefirstinfected = 1;
      level.infect_allowsuicide = 1;

      foreach(player in level.players) {
        if(isDefined(player.infect_isbeingchosen))
          player.infect_isbeingchosen = undefined;
      }
    }

    foreach(player in level.players) {
      if(isDefined(player.isinitialinfected))
        player thread setinitialtonormalinfected();
    }

    if(level.infect_teamscores["axis"] == 1)
      self.isinitialinfected = 1;

    initsurvivaltime(1);
  }

  thread onspawnfinished();
  thread updatematchstatushintonspawn();
  level notify("spawned_player");
}

spawnwithplayersecondary() {
  _id_BD5CCE7508E151A9 = self getweaponslistprimaries();
  _id_0820724B64FC1515 = self getcurrentprimaryweapon();

  if(_id_BD5CCE7508E151A9.size > 1) {
    if(scripts\cp_mp\utility\weapon_utility::isknifeonly(_id_0820724B64FC1515)) {
      foreach(weapon in _id_BD5CCE7508E151A9) {
        if(weapon != _id_0820724B64FC1515)
          self setspawnweapon(weapon);
      }
    }
  }
}

setdefaultammoclip(team) {
  setdefaultammoclip = 1;

  if(isDefined(self.isinitialinfected)) {
    if(scripts\mp\utility\game::isusingdefaultclass(team, 1))
      setdefaultammoclip = 0;
  } else if(scripts\mp\utility\game::isusingdefaultclass(team, 0))
    setdefaultammoclip = 0;

  return setdefaultammoclip;
}

onspawnfinished() {
  self endon("death_or_disconnect");
  self waittill("giveLoadout");

  if(istrue(self.waitedtospawn)) {
    self.waitedtospawn = 0;
    self.suicidedfromspawnwait = 1;
    wait 0.1;
    self suicide();
  }

  self.last_infected_class = self.infected_class;

  if(self.pers["team"] == "allies") {
    if(level.enableping)
      scripts\mp\utility\perk::giveperk("specialty_boom");

    if(istrue(level.isgroundwarinfected))
      thread givesuperpointsonprematchdone();

    spawnwithplayersecondary();

    if(level.infectednightmode && !level.infecteddisablenvg && !isbot(self))
      thread nvgwatcher();
  } else if(self.pers["team"] == "axis") {
    if(istrue(level.allowskydivecutparachute))
      self skydive_cutparachuteon();
    else {
      self._id_4DA443F197C8014E = 1;
      self skydive_cutparachuteoff();
    }

    if(level.enableping)
      scripts\mp\utility\perk::giveperk("specialty_boom");

    _id_50BECD9157AF76C1 = 1.05;

    if(!istrue(level.isgroundwarinfected)) {
      _id_D2DA5F8C74DBC049 = int(floor(level.infect_teamscores["axis"] / 3));
      _id_D2DA5F8C74DBC049 = _id_D2DA5F8C74DBC049 * 0.01;
      _id_50BECD9157AF76C1 = max(1.0, _id_50BECD9157AF76C1 - _id_D2DA5F8C74DBC049);
    }

    self.overrideweaponspeed_speedscale = _id_50BECD9157AF76C1;
    thread setinfectedmsg();

    if(level.infectedtactical == "equip_tac_insert" && !istrue(self.isinitialinfected)) {
      if(level.givetkontispawn || !level.givetkontispawn && !self.ti_spawn)
        scripts\mp\equipment::giveequipment(level.infectedlethal, "primary");
      else
        scripts\mp\equipment::decrementequipmentammo(level.infectedlethal, 1);
    }

    if(level.infectedtactical != "equip_tac_insert" || level.infectedtactical == "none")
      scripts\mp\equipment::giveequipment(level.infectedtactical, "secondary");
    else
      scripts\mp\utility\perk::giveperk("specialty_tacticalinsertion");
  }

  giveextrainfectedperks();

  if(istrue(self.movedtoinfected)) {
    if(!istrue(level.isgroundwarinfected) || istrue(level.isgroundwarinfected) && level.mapname == "mp_aniyah")
      self.movedtoinfected = undefined;

    thread scripts\mp\supers::givesuperpoints(350, undefined, 1);
  }

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(self.loadoutprimary);

  if(_id_AB501F397D3CD312 != "iw9_me_knife") {
    _id_F968C960C23738E6 = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845("iw9_knifestab_mp");
    self giveweapon(_id_F968C960C23738E6);
    self assignweaponmeleeslot(_id_F968C960C23738E6);

    if(self.loadoutsecondary == "iw9_me_knife_mp") {
      scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe("iw9_me_knife_mp");
      self giveweapon("iw9_me_knife_mp");
    }
  }

  if(istrue(self.faux_spawn_infected)) {
    if(isDefined(scripts\mp\supers::getcurrentsuper()) && scripts\mp\supers::getcurrentsuperref() == "super_deadsilence")
      thread startdeadsilence();
  }

  self.faux_spawn_infected = undefined;

  if(istrue(self.isparachutespawning)) {
    waitframe();
    self.isparachutespawning = undefined;
    thread scripts\cp_mp\parachute::startfreefall(level._id_BB88666E1E748431, 0, undefined, undefined, 1);
  }

  thread scripts\mp\supers::givesuperpoints(level.infectbonussuperonspawn, undefined, 1);
  thread waitthensetgendersoundcontext();
}

waitthensetgendersoundcontext() {
  self endon("death_or_disconnect");
  wait 0.2;

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("female");
  else
    self _meth_555E2D32E2756625("");
}

givesuperpointsonprematchdone() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!isDefined(level.infect_countdowninprogress) || istrue(level.infect_countdowninprogress))
    level waittill("infect_countdown_ended");

  thread scripts\mp\supers::givesuperpoints(200, undefined, 1);
}

managefists(primary, _id_D7B9856A19F9B6B5) {
  if(primary != "iw9_me_fists" || _id_D7B9856A19F9B6B5 != "iw9_me_fists") {
    if(primary == "none" && _id_D7B9856A19F9B6B5 == "none") {
      return;
    }
    scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe("iw9_me_fists_mp");
    return;
  }
}

giveextrainfectedperks() {
  if(self.pers["team"] == "allies")
    _id_50D0559DCBA571E2 = ["specialty_fastreload"];
  else if(istrue(self.isinitialinfected))
    _id_50D0559DCBA571E2 = ["specialty_longersprint", "specialty_quickdraw", "specialty_falldamage", "specialty_bulletaccuracy", "specialty_quickswap"];
  else
    _id_50D0559DCBA571E2 = ["specialty_longersprint", "specialty_quickdraw", "specialty_falldamage"];

  foreach(perk in _id_50D0559DCBA571E2)
  scripts\mp\utility\perk::giveperk(perk);
}

setinfectedmodels() {}

setinfectedmsg() {
  if(isDefined(self.isinitialinfected)) {
    if(!isDefined(self.showninfected) || !self.showninfected) {
      thread scripts\mp\rank::scoreeventpopup("stat_F873E0803181E932");
      self.showninfected = 1;
    }
  } else if(isDefined(self.changingtoregularinfected)) {
    self.changingtoregularinfected = undefined;

    if(isDefined(self.changingtoregularinfectedbykill)) {
      self.changingtoregularinfectedbykill = undefined;
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F873E0803181E932");
    }
  } else if(!isDefined(self.showninfected) || !self.showninfected) {
    thread scripts\mp\rank::scoreeventpopup("stat_907BBE9CD1A3124E");
    self.showninfected = 1;
  }
}

choosefirstinfected() {
  level endon("game_ended");
  level endon("infect_stopCountdown");
  level endon("force_end");
  level.infect_allowsuicide = 0;
  scripts\mp\flags::gameflagwait("prematch_done");
  level.infect_countdowninprogress = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  setomnvar("ui_match_start_text", "first_infected_in");
  _id_B710552E5D79A601 = 15;

  while(_id_B710552E5D79A601 > 0 && !level.gameended) {
    foreach(_id_AC0E424AC96A7113 in level.players)
    _id_AC0E424AC96A7113 setclientomnvar("ui_match_start_countdown", _id_B710552E5D79A601);

    _id_B710552E5D79A601--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  }

  setomnvar("ui_match_start_text", "match_starting_in");

  foreach(_id_AC0E424AC96A7113 in level.players)
  _id_AC0E424AC96A7113 setclientomnvar("ui_match_start_countdown", 0);

  level.infect_countdowninprogress = 0;
  level notify("infect_countdown_ended");
  _id_A4DCD8346351D366 = [];

  foreach(player in level.players) {
    if(scripts\mp\utility\game::matchmakinggame() && level.players.size > 1 && player ishost()) {
      continue;
    }
    if(player.team == "spectator") {
      continue;
    }
    if(!player.hasspawned) {
      continue;
    }
    _id_A4DCD8346351D366[_id_A4DCD8346351D366.size] = player;
  }

  level.firstinfectedsplash = 0;

  if(_id_A4DCD8346351D366.size <= level.numinitialinfected && _id_A4DCD8346351D366.size > 1)
    level.numinitialinfected = _id_A4DCD8346351D366.size - 1;

  _id_7CEA7652605D7BD5 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.numinitialinfected; _id_AC0E594AC96AA3A8++) {
    _id_42181A2341CDF880 = _id_A4DCD8346351D366[randomint(_id_A4DCD8346351D366.size)];
    _id_7CEA7652605D7BD5[_id_7CEA7652605D7BD5.size] = _id_42181A2341CDF880;
    _id_A4DCD8346351D366 = scripts\engine\utility::array_remove(_id_A4DCD8346351D366, _id_42181A2341CDF880);
  }

  foreach(_id_42181A2341CDF880 in _id_7CEA7652605D7BD5)
  _id_42181A2341CDF880 setfirstinfected(1);

  level.infect_allowsuicide = 1;

  foreach(player in level.players) {
    if(istrue(player.isinitialinfected)) {
      player thread scripts\mp\hud_message::showsplash("first_infected");
      player scripts\mp\utility\dialog::leaderdialogonplayer("infected_first");
      continue;
    }

    player thread scripts\mp\hud_message::showsplash("first_survivor");
    player.survivalstarttime = gettime();
  }
}

setfirstinfected(_id_E9EC3C871BE9D510) {
  self endon("death_or_disconnect");

  if(_id_E9EC3C871BE9D510)
    self.infect_isbeingchosen = 1;

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote() || isDefined(self.vehiclereserved))
    waitframe();

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle)) {
    data = spawnStruct();
    data.allowairexit = 1;
    data.exittype = "INVOLUNTARY";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(vehicle, undefined, self, data, 1);

    while(scripts\cp_mp\utility\player_utility::isinvehicle())
      waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!isalive(self))
    waitframe();

  while(istrue(self.usingascender))
    waitframe();

  if(_id_E9EC3C871BE9D510) {
    scripts\mp\menus::addtoteam("axis", undefined, 1);
    thread monitordisconnect();
    level.infect_chosefirstinfected = 1;
    self.infect_isbeingchosen = undefined;
    self._id_4DA443F197C8014E = 1;

    if(istrue(level.allowskydivecutparachute))
      self skydive_cutparachuteon();
    else
      self skydive_cutparachuteoff();

    updateteamscores();

    if(scripts\mp\utility\player::isfemale())
      self playlocalsound("Fem_breathing_better");
    else
      self playlocalsound("breathing_better");
  }

  self.isinitialinfected = 1;
  scripts\mp\utility\stats::incpersstat("firstInfected", 1);
  self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  self.faux_spawn_infected = 1;
  self.operatorcustomization = undefined;
  self.pers["perkPackageData"].forcereset = 1;
  waittillframeend;
  thread scripts\mp\playerlogic::spawnplayer(1);
  self setplayermusicstate("mx_mp_br_zombieresurgence_zombierespawn");

  if(istrue(level.isgroundwarinfected))
    thread scripts\mp\supers::givesuperpoints(350, undefined, 1);

  if(_id_E9EC3C871BE9D510)
    level.infect_players[self.name] = 1;

  level.firstinfectedsplash = 1;

  if(!level.firstinfectedsplash)
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_first_infected", self);

  if(!level.infect_skipsounds) {
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_infected_loss");
    level.infect_skipsounds = 1;
  }

  thread waitthenshowinfecttext();
  initsurvivaltime(1);
}

waitthenshowinfecttext() {
  self endon("death_or_disconnect");
  wait 4;
  self iprintlnbold(&"SPLASHES/INFECT_ALL");
}

startdeadsilence() {
  thread scripts\mp\supers::givesuperpoints(4000, undefined, 1);
  wait 0.5;
  thread scripts\mp\perks\perkpackage::perkpackage_forceusesuper();
}

setinitialtonormalinfected(_id_AFD26C4701021BED, smeansofdeath) {
  level endon("game_ended");
  self endon("death");
  self.isinitialinfected = undefined;
  self.changingtoregularinfected = 1;

  if(isDefined(_id_AFD26C4701021BED))
    self.changingtoregularinfectedbykill = 1;

  while(!scripts\mp\utility\player::isreallyalive(self))
    waitframe();

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(self ismeleeing())
    waitframe();

  while(!scripts\mp\utility\player::isreallyalive(self))
    waitframe();

  self.pers["gamemodeLoadout"] = level.infect_loadouts["axis"];
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  self.faux_spawn_infected = 1;

  if(isDefined(scripts\mp\supers::getcurrentsuper()) && scripts\mp\supers::getcurrentsuper().isinuse)
    thread scripts\mp\supers::superusefinished(0);

  self.pers["perkPackageData"].forcereset = 1;
  waitframe();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid) {
  if(level.gameended) {
    return;
  }
  _id_5A0EE87D3A8FC462 = 0;
  _id_4125D811C53D9546 = 0;
  level thread shouldplayhalfwayvo();

  if(self.team == "axis") {}

  if(self.team == "allies" && isDefined(attacker)) {
    self.operatorcustomization = undefined;

    if(isPlayer(attacker) && attacker != self)
      _id_5A0EE87D3A8FC462 = 1;
    else if(level.infect_allowsuicide && (attacker == self || !isPlayer(attacker))) {
      _id_5A0EE87D3A8FC462 = 1;
      _id_4125D811C53D9546 = 1;
    }
  }

  if(self.team == "allies" && istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
    if(isDefined(level.nukeinfo.player) && self == level.nukeinfo.player) {
      _id_5A0EE87D3A8FC462 = 0;
      _id_4125D811C53D9546 = 0;
    }
  }

  if(isPlayer(attacker) && attacker.team == "allies" && attacker != self) {
    attacker scripts\mp\utility\stats::incpersstat("killsAsSurvivor", 1);
    attacker scripts\mp\persistence::statsetchild("round", "killsAsSurvivor", attacker.pers["killsAsSurvivor"]);
  } else if(isPlayer(attacker) && attacker.team == "axis" && attacker != self) {
    attacker scripts\mp\utility\stats::incpersstat("killsAsInfected", 1);
    attacker scripts\mp\persistence::statsetchild("round", "killsAsInfected", attacker.pers["killsAsInfected"]);

    if(isPlayer(attacker))
      attacker scripts\mp\utility\stats::setextrascore1(attacker.pers["killsAsInfected"]);
  }

  if(_id_5A0EE87D3A8FC462) {
    thread delayedprocesskill(attacker, _id_4125D811C53D9546);

    if(_id_4125D811C53D9546) {
      foreach(player in level.players) {
        if(isDefined(player.isinitialinfected))
          player thread setinitialtonormalinfected();
      }
    } else if(isDefined(attacker.isinitialinfected)) {
      foreach(player in level.players) {
        if(isDefined(player.isinitialinfected))
          player thread setinitialtonormalinfected(1);
      }
    } else if(level.infectstreakbonus > 0) {
      if(!isDefined(attacker.infectedkillsthislife))
        attacker.infectedkillsthislife = 1;
      else
        attacker.infectedkillsthislife++;

      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_86CFB765FD354404", undefined, level.infectstreakbonus * attacker.infectedkillsthislife);
    } else
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_86CFB765FD354404");

    if(scripts\mp\utility\dvars::getwatcheddvar("timelimit") != 0) {
      _id_A3AAA6A031AB1D3F = 1;

      if(scripts\mp\utility\game::matchmakinggame()) {
        level.extratimeincreasecount++;
        _id_A3AAA6A031AB1D3F = level.extratimeincreasecount <= level.extratimeincreasecountcap;
      }

      if(_id_A3AAA6A031AB1D3F) {
        if(!isDefined(level.extratime))
          level.extratime = level.infectextratimeperkill;
        else
          level.extratime = level.extratime + level.infectextratimeperkill;
      }
    }

    setsurvivaltime(1);
  } else {
    if(isbot(self))
      self.classcallback = "gamemode";

    if(isDefined(self.isinitialinfected)) {
      self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
      self.infected_class = "axis_initial";
    } else {
      self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
      self.infected_class = self.pers["team"];
    }
  }
}

delayedprocesskill(attacker, _id_4125D811C53D9546) {
  self.movedtoinfected = 1;
  wait 0.15;
  self.teamchangedthisframe = 1;
  self.operatorcustomization = undefined;
  scripts\mp\menus::addtoteam("axis");

  if(istrue(level.isgroundwarinfected) && level.mapname != "mp_aniyah")
    setfaketispawnpoint();

  updateteamscores();
  level.infect_players[self.name] = 1;
  thread monitordisconnect();

  if(level.infect_teamscores["allies"] > 1) {
    if(istrue(level.isgroundwarinfected)) {
      level.playgotinfectedsoundcount++;

      if(level.playgotinfectedsoundcount > 3)
        level.playgotinfectedsoundcount = 1;

      if(istrue(level._id_6F84C741AB4B49D1)) {
        if(level.infect_teamscores["allies"] <= level._id_5AAA30C2942D7A75) {
          level notify("infect_enable_axis_uav");
          thread _id_F14F087EBC3BEAC2();
        }
      }
    }

    self setplayermusicstate("mx_mp_br_zombieresurgence_zombierespawn");

    if(level.playgotinfectedsoundcount == 1) {
      scripts\mp\utility\sound::playsoundonplayers("iw9_mp_infected_loss", "allies");
      scripts\mp\utility\sound::playsoundonplayers("iw9_mp_infected_gain", "axis");
      thread scripts\mp\hud_util::teamplayercardsplash("callout_got_infected", self, "allies");
    }

    if(!_id_4125D811C53D9546) {
      thread scripts\mp\hud_util::teamplayercardsplash("callout_infected", attacker, "axis");

      if(!isDefined(level.survivorscoreevent)) {
        _id_A5D020AA6ADB222F = getdvarint("scr_infect_survivorinitialscore", 50);

        if(_id_A5D020AA6ADB222F > 0)
          level.survivorscoreevent = _id_A5D020AA6ADB222F;
        else
          level.survivorscoreevent = scripts\mp\rank::getscoreinfovalue("stat_F228812C2D41927F");
      } else
        level.survivorscoreevent = level.survivorscoreevent + level.survivoralivescore;

      foreach(player in level.players) {
        if(!scripts\mp\utility\player::isreallyalive(player) || self.sessionstate == "spectator") {
          continue;
        }
        if(player.team == "allies" && player != self && distance(player.infect_spawnpos, player.origin) > 32)
          player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F228812C2D41927F", undefined, level.survivorscoreevent);

        if(player.team == "axis" && player != attacker && player != self)
          player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_8FCF8BBD78A0502E", undefined, level.infectbonusscore);
      }
    }
  } else if(level.infect_teamscores["allies"] == 1)
    onfinalsurvivor();
  else if(level.infect_teamscores["allies"] == 0)
    onsurvivorseliminated();

  if(isbot(self))
    self.classcallback = "gamemode";

  if(isDefined(self.isinitialinfected)) {
    self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
    self.infected_class = "axis_initial";
  } else {
    self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
    self.infected_class = self.pers["team"];
  }
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(istrue(level.matchmakingmatch) && isDefined(attacker) && isDefined(victim)) {
    _id_06980251E86D0A47 = attacker getfireteammembers();

    if(isDefined(_id_06980251E86D0A47) && _id_06980251E86D0A47.size > 0) {
      foreach(_id_80EF668C09FFB70F in _id_06980251E86D0A47) {
        if(isDefined(_id_80EF668C09FFB70F) && victim == _id_80EF668C09FFB70F) {
          attacker scripts\mp\killstreaks\killstreaks::givestreakpoints("stat_EF9582D72160F199", -1, 0);
          attacker.nukepoints = scripts\engine\utility::ter_op(attacker.nukepoints > 0, attacker.nukepoints - 1, 0);
          break;
        }
      }
    }
  }
}

onfinalsurvivor() {
  scripts\mp\utility\sound::playsoundonplayers("iw9_mp_infected_mark_last");
  setmusicstate("mx_mp_br_zombieresurgence_circle_close_final_1");

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(player.team == "allies") {
      player scripts\mp\utility\dialog::leaderdialogonplayer("infected_lastalive");
      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_B59CC083FE34FA92");
      player scripts\mp\utility\stats::incpersstat("lastSurvivor", 1);

      if(scripts\mp\utility\game::matchmakinggame() && !player scripts\mp\utility\killstreak::isjuggernaut()) {
        player.maxhealth = 200;
        player notify("force_regeneration");
      }

      thread scripts\mp\hud_util::teamplayercardsplash("callout_final_survivor", player);

      if(level.infectednightmode) {} else if(scripts\mp\utility\game::matchmakinggame() && !player scripts\mp\utility\killstreak::isjuggernaut())
        level thread _id_3730CA06A1EE0C25(player);

      break;
    }
  }
}

_id_3730CA06A1EE0C25(_id_8084EFA02D906BB2) {
  level endon("game_ended");
  _id_8084EFA02D906BB2 endon("disconnect");
  _id_8084EFA02D906BB2 endon("eliminated");

  for(;;) {
    if(level.infect_teamscores["allies"] > 1) {
      _id_8084EFA02D906BB2.health = scripts\engine\utility::ter_op(_id_8084EFA02D906BB2.health > 100, 100, _id_8084EFA02D906BB2.health);
      _id_8084EFA02D906BB2.maxhealth = 100;
      break;
    }

    waitframe();
  }
}

_id_4B1E3F35C961E700() {
  level notify("infect_radar_thread");
  level endon("game_ended");
  level endon("infect_radar_thread");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!isDefined(level.infect_countdowninprogress) || istrue(level.infect_countdowninprogress))
    level waittill("infect_countdown_ended");

  if(istrue(level._id_6F84C741AB4B49D1)) {
    level waittill("infect_enable_axis_uav");
    setteamradar("axis", 1);
    return;
  }

  for(;;) {
    foreach(player in level.players) {
      if(player.team == "axis")
        triggeroneoffradarsweep(player);
    }

    if(level.infect_teamscores["allies"] > level._id_5AAA30C2942D7A75) {
      wait(level._id_5B8EACB759C64658);
      continue;
    }

    wait(level._id_6466716A73FF8F0B);
  }
}

_id_F14F087EBC3BEAC2() {
  level notify("infect_radar_listen_for_disable");
  level endon("game_ended");
  level endon("infect_radar_listen_for_disable");

  while(level.infect_teamscores["allies"] <= level._id_5AAA30C2942D7A75)
    waitframe();

  setteamradar("axis", 0);
  thread _id_4B1E3F35C961E700();
}

monitordisconnect() {
  level endon("game_ended");
  self endon("eliminated");
  self notify("infect_monitor_disconnect");
  self endon("infect_monitor_disconnect");
  team = self.team;

  if(!isDefined(team) && isDefined(self.bot_team))
    team = self.bot_team;

  self waittill("disconnect");
  updateteamscores();

  if(isDefined(self.infect_isbeingchosen) || level.infect_chosefirstinfected) {
    if(level.infect_teamscores["axis"] && level.infect_teamscores["allies"]) {
      if(team == "allies" && level.infect_teamscores["allies"] == 1)
        onfinalsurvivor();
      else if(team == "axis" && level.infect_teamscores["axis"] == 1) {
        foreach(player in level.players) {
          if(player != self && player.team == "axis")
            player setfirstinfected(0);
        }
      }
    } else if(level.infect_teamscores["allies"] == 0) {
      if(istrue(level.hostmigration))
        scripts\mp\hostmigration::waittillhostmigrationdone();

      onsurvivorseliminated();
    } else if(level.infect_teamscores["axis"] == 0) {
      if(level.infect_teamscores["allies"] == 1)
        level thread scripts\mp\gamelogic::endgame("allies", game["end_reason"][tolower(game["axis"]) + "_eliminated"]);
      else if(level.infect_teamscores["allies"] > 1) {
        level.infect_chosefirstinfected = 0;
        level thread choosefirstinfected();
      }
    }
  } else if(istrue(level.infect_countdowninprogress) && level.infect_teamscores["allies"] == 0 && level.infect_teamscores["axis"] == 0) {
    level notify("infect_stopCountdown");
    level.infect_choosingfirstinfected = 0;

    foreach(_id_AC0E424AC96A7113 in level.players)
    _id_AC0E424AC96A7113 setclientomnvar("ui_match_start_countdown", 0);
  }

  self.isinitialinfected = undefined;
}

ondeadevent(team) {
  return;
}

ontimelimit() {
  level thread scripts\mp\gamelogic::endgame("allies", game["end_reason"]["time_limit_reached"]);
}

onsurvivorseliminated() {
  level thread scripts\mp\gamelogic::endgame("axis", game["end_reason"]["survivors_eliminated"]);
}

getteamsize(team) {
  _id_A61C75B156FC1EE0 = 0;

  foreach(player in level.players) {
    if(player.sessionstate == "spectator" && !player.spectatekillcam && !istrue(player.inspawncamera)) {
      continue;
    }
    if(player.team == team)
      _id_A61C75B156FC1EE0++;
  }

  return _id_A61C75B156FC1EE0;
}

updateteamscores() {
  level.infect_teamscores["allies"] = getteamsize("allies");
  game["teamScores"]["allies"] = level.infect_teamscores["allies"];
  setteamscore("allies", level.infect_teamscores["allies"]);
  level.infect_teamscores["axis"] = getteamsize("axis");
  game["teamScores"]["axis"] = level.infect_teamscores["axis"];
  setteamscore("axis", level.infect_teamscores["axis"]);
  totalplayers = level.infect_teamscores["axis"] + level.infect_teamscores["allies"];

  if(!istrue(level.nojip) && totalplayers > 0) {
    _id_A2DA1DA8598191A0 = level.infect_teamscores["axis"] / totalplayers;

    if(_id_A2DA1DA8598191A0 > level.scorepercentagecutoff) {
      setnojipscore(1, 1);
      level.nojip = 1;
    }
  }
}

setspecialloadouts() {
  waitframe();

  if(!isDefined(level.survivorprimaryweapon) || level.survivorprimaryweapon == "")
    level.survivorprimaryweapon = "iw9_sh_mbravo_mp";

  if(!isDefined(level.survivorsecondaryweapon) || level.survivorsecondaryweapon == "")
    level.survivorsecondaryweapon = "iw9_pi_golf17_mp";

  if(!isDefined(level.infectedprimaryweapon) || level.infectedprimaryweapon == "")
    level.infectedprimaryweapon = "iw9_me_knife_mp";

  if(!isDefined(level.infectedsecondaryweapon) || level.infectedsecondaryweapon == "")
    level.infectedsecondaryweapon = "iw9_me_fists_mp";

  if(!isDefined(level.initialprimaryweapon) || level.initialprimaryweapon == "")
    level.initialprimaryweapon = "iw9_sh_mbravo_mp";

  if(isDefined(level.infectedprimaryweapon) && level.infectedprimaryweapon == "iw9_me_knife_mp") {
    level.infectedprimaryweapon = "iw9_me_knife_mp";

    if(isDefined(level.infectedsecondaryweapon) && level.infectedsecondaryweapon == "iw9_me_knife_mp")
      level.infectedsecondaryweapon = "none";
  }

  if(!isDefined(level.initialsecondaryweapon) || level.initialsecondaryweapon == "")
    level.initialsecondaryweapon = "iw9_pi_golf17_mp";

  if(!isDefined(level.survivorlethal) || level.survivorlethal == "")
    level.survivorlethal = "equip_claymore";

  if(!isDefined(level.survivortactical) || level.survivortactical == "")
    level.survivortactical = "equip_concussion";

  if(!isDefined(level.infectedlethal) || level.infectedlethal == "")
    level.infectedlethal = "equip_throwing_knife";

  if(!isDefined(level.infectedtactical) || level.infectedtactical == "")
    level.infectedtactical = "equip_tac_insert";

  level.infect_allyrigs = [];
  level.infect_allyrigs[level.infect_allyrigs.size] = "archetype_assault";

  if(scripts\mp\utility\game::isusingdefaultclass("allies", 0))
    level.infect_loadouts["allies"] = scripts\mp\utility\game::getmatchrulesspecialclass("allies", 0);
  else if(level.onlineprimaryoverride) {
    level.infect_loadouts["allies"]["loadoutPrimary"] = level.survivorprimaryweapon;
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment"];
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment2"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment2"];
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment3"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment3"];
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment4"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment4"];
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment5"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment5"];
    level.infect_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
    level.infect_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
    level.infect_loadouts["allies"]["loadoutPrimaryVariantID"] = 0;
    level.infect_loadouts["allies"]["loadoutSecondary"] = level.survivorsecondaryweapon;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment"] = level.attachmentsurvivorsecondary;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment2"] = level.attachmentsurvivorsecondarytwo;
    level.infect_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryVariantID"] = 0;
    level.infect_loadouts["allies"]["loadoutEquipmentPrimary"] = level.survivorlethal;
    level.infect_loadouts["allies"]["loadoutEquipmentSecondary"] = level.survivortactical;
    level.infect_loadouts["allies"]["loadoutSuper"] = "none";
    level.infect_loadouts["allies"]["loadoutStreakType"] = "assault";

    if(level.survivorstreakoverride.size > 0) {
      level.infect_loadouts["allies"]["loadoutKillstreak1"] = level.survivorstreakoverride[0];
      level.infect_loadouts["allies"]["loadoutKillstreak2"] = level.survivorstreakoverride[1];
      level.infect_loadouts["allies"]["loadoutKillstreak3"] = level.survivorstreakoverride[2];
      level.infect_loadouts["allies"]["loadoutPerks"] = ["specialty_warhead", "specialty_scavenger_plus", "specialty_restock"];
    } else {
      level.infect_loadouts["allies"]["loadoutKillstreak1"] = "none";
      level.infect_loadouts["allies"]["loadoutKillstreak2"] = "none";
      level.infect_loadouts["allies"]["loadoutKillstreak3"] = "none";
      level.infect_loadouts["allies"]["loadoutUsingSpecialist"] = 1;
      level.infect_loadouts["allies"]["loadoutPerks"] = ["specialty_hardline"];
      level.infect_loadouts["allies"]["loadoutExtraPerks"] = ["specialty_scavenger_plus", "specialty_warhead", "specialty_restock"];
    }

    level.infect_loadouts["allies"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["allies"]["loadoutFieldUpgrade1"] = level.survivorsuper;
    level.infect_loadouts["allies"]["loadoutFieldUpgrade2"] = level.survivorsupertwo;
  } else {
    level.infect_loadouts["allies"]["loadoutPrimary"] = level.survivorprimaryweapon;
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment"] = level.attachmentsurvivorprimary;
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
    level.infect_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
    level.infect_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
    level.infect_loadouts["allies"]["loadoutPrimaryVariantID"] = 0;
    level.infect_loadouts["allies"]["loadoutSecondary"] = level.survivorsecondaryweapon;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment"] = level.attachmentsurvivorsecondary;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment2"] = level.attachmentsurvivorsecondarytwo;
    level.infect_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryVariantID"] = 0;
    level.infect_loadouts["allies"]["loadoutEquipmentPrimary"] = level.survivorlethal;
    level.infect_loadouts["allies"]["loadoutEquipmentSecondary"] = level.survivortactical;
    level.infect_loadouts["allies"]["loadoutSuper"] = "none";
    level.infect_loadouts["allies"]["loadoutStreakType"] = "assault";

    if(level.survivorstreakoverride.size > 0) {
      level.infect_loadouts["allies"]["loadoutKillstreak1"] = level.survivorstreakoverride[0];
      level.infect_loadouts["allies"]["loadoutKillstreak2"] = level.survivorstreakoverride[1];
      level.infect_loadouts["allies"]["loadoutKillstreak3"] = level.survivorstreakoverride[2];
      level.infect_loadouts["allies"]["loadoutPerks"] = ["specialty_warhead", "specialty_scavenger_plus", "specialty_restock"];
    } else {
      level.infect_loadouts["allies"]["loadoutKillstreak1"] = "none";
      level.infect_loadouts["allies"]["loadoutKillstreak2"] = "none";
      level.infect_loadouts["allies"]["loadoutKillstreak3"] = "none";
      level.infect_loadouts["allies"]["loadoutUsingSpecialist"] = 1;
      level.infect_loadouts["allies"]["loadoutPerks"] = ["specialty_hardline"];
      level.infect_loadouts["allies"]["loadoutExtraPerks"] = ["specialty_scavenger_plus", "specialty_warhead", "specialty_restock"];
    }

    level.infect_loadouts["allies"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["allies"]["loadoutFieldUpgrade1"] = level.survivorsuper;
    level.infect_loadouts["allies"]["loadoutFieldUpgrade2"] = level.survivorsupertwo;

    if(level.enableping) {}
  }

  _id_53B5E2FC5C7A4F64 = [];

  if(istrue(level.isgroundwarinfected))
    _id_53B5E2FC5C7A4F64[_id_53B5E2FC5C7A4F64.size] = "specialty_restock";

  if(scripts\mp\utility\game::isusingdefaultclass("axis", 1)) {
    level.infect_loadouts["axis_initial"] = scripts\mp\utility\game::getmatchrulesspecialclass("axis", 1);
    level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
  } else if(level.onlineprimaryoverride) {
    level.infect_loadouts["axis_initial"]["loadoutPrimary"] = level.initialprimaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment"];
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment2"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment2"];
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment3"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment3"];
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment4"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment4"];
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment5"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment5"];
    level.infect_loadouts["axis_initial"]["loadoutPrimaryVariantID"] = 0;
    level.infect_loadouts["axis_initial"]["loadoutSecondary"] = level.initialsecondaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment"] = level.attachmentinitialsecondary;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment2"] = level.attachmentinitialsecondarytwo;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryVariantID"] = 0;
    level.infect_loadouts["axis_initial"]["loadoutEquipmentPrimary"] = level.infectedlethal;
    level.infect_loadouts["axis_initial"]["loadoutEquipmentSecondary"] = level.infectedtactical;
    level.infect_loadouts["axis_initial"]["loadoutSuper"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPerks"] = _id_53B5E2FC5C7A4F64;
    level.infect_loadouts["axis_initial"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["axis_initial"]["loadoutFieldUpgrade1"] = level.infectedsuper;
    level.infect_loadouts["axis_initial"]["loadoutFieldUpgrade2"] = level.infectedsupertwo;
  } else {
    level.infect_loadouts["axis_initial"]["loadoutPrimary"] = level.initialprimaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment"] = level.attachmentinitialprimary;
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPrimaryCamo"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPrimaryReticle"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPrimaryVariantID"] = 0;
    level.infect_loadouts["axis_initial"]["loadoutSecondary"] = level.initialsecondaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment"] = level.attachmentinitialsecondary;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment2"] = level.attachmentinitialsecondarytwo;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryVariantID"] = 0;
    level.infect_loadouts["axis_initial"]["loadoutEquipmentPrimary"] = level.infectedlethal;
    level.infect_loadouts["axis_initial"]["loadoutEquipmentSecondary"] = level.infectedtactical;
    level.infect_loadouts["axis_initial"]["loadoutSuper"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPerks"] = _id_53B5E2FC5C7A4F64;
    level.infect_loadouts["axis_initial"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["axis_initial"]["loadoutFieldUpgrade1"] = level.infectedsuper;
    level.infect_loadouts["axis_initial"]["loadoutFieldUpgrade2"] = level.infectedsupertwo;

    if(level.enableinfectedtracker) {}

    if(level.enableping) {}
  }

  _id_2DE7FC1792EE7C9B = [];

  if(istrue(level.isgroundwarinfected))
    _id_2DE7FC1792EE7C9B[_id_2DE7FC1792EE7C9B.size] = "specialty_restock";

  if(scripts\mp\utility\game::isusingdefaultclass("axis", 0)) {
    level.infect_loadouts["axis"] = scripts\mp\utility\game::getmatchrulesspecialclass("axis", 0);
    level.infect_loadouts["axis"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis"]["loadoutKillstreak3"] = "none";
  } else {
    level.infect_loadouts["axis"]["loadoutPrimary"] = level.infectedprimaryweapon;
    level.infect_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
    level.infect_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
    level.infect_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
    level.infect_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
    level.infect_loadouts["axis"]["loadoutPrimaryVariantID"] = 0;
    level.infect_loadouts["axis"]["loadoutSecondary"] = level.infectedsecondaryweapon;
    level.infect_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
    level.infect_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
    level.infect_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["axis"]["loadoutSecondaryVariantID"] = -1;
    level.infect_loadouts["axis"]["loadoutEquipmentPrimary"] = level.infectedlethal;
    level.infect_loadouts["axis"]["loadoutEquipmentSecondary"] = level.infectedtactical;
    level.infect_loadouts["axis"]["loadoutSuper"] = level.infectedsuper;
    level.infect_loadouts["axis"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis"]["loadoutKillstreak3"] = "none";
    level.infect_loadouts["axis"]["loadoutPerks"] = _id_2DE7FC1792EE7C9B;
    level.infect_loadouts["axis"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["axis"]["loadoutFieldUpgrade1"] = level.infectedsuper;
    level.infect_loadouts["axis"]["loadoutFieldUpgrade2"] = level.infectedsupertwo;

    if(level.enableinfectedtracker) {}

    if(level.enableping) {}
  }

  level.infect_loadouts["allies"] = _id_2C5507ACFC56949D(level.infect_loadouts["allies"]);
  level.infect_loadouts["axis"] = _id_2C5507ACFC56949D(level.infect_loadouts["axis"]);
  level.infect_loadouts["axis_initial"] = _id_2C5507ACFC56949D(level.infect_loadouts["axis_initial"]);
}

_id_2C5507ACFC56949D(loadout) {
  if(!isDefined(loadout)) {
    return;
  }
  switch (loadout["loadoutFieldUpgrade1"]) {
    case "super_tac_insert":
      if(loadout["loadoutEquipmentSecondary"] == "equip_tac_insert")
        loadout["loadoutEquipmentSecondary"] = "none";

      break;
    case "super_trophy":
      if(loadout["loadoutEquipmentSecondary"] == "equip_trophy")
        loadout["loadoutEquipmentSecondary"] = "none";

      break;
    default:
      break;
  }

  switch (loadout["loadoutFieldUpgrade2"]) {
    case "super_tac_insert":
      if(loadout["loadoutEquipmentSecondary"] == "equip_tac_insert")
        loadout["loadoutEquipmentSecondary"] = "none";

      break;
    case "super_trophy":
      if(loadout["loadoutEquipmentSecondary"] == "equip_trophy")
        loadout["loadoutEquipmentSecondary"] = "none";

      break;
    default:
      break;
  }

  return loadout;
}

addsurvivorattachmentsprimary(weapon) {
  level.attachmentsurvivorprimary = "none";
  group = scripts\mp\utility\weapon::getweapongroup(weapon);

  if(group == "weapon_shotgun")
    level.attachmentsurvivorprimary = "barrelrange";
  else if(group == "weapon_assault" || group == "weapon_battle" || group == "weapon_smg" || group == "weapon_lmg" || group == "weapon_pistol" || weapon == "iw7_m1c")
    level.attachmentsurvivorprimary = "highcal";
}

addinitialattachmentsprimary(weapon) {
  level.attachmentinitialprimary = "none";
  group = scripts\mp\utility\weapon::getweapongroup(weapon);

  if(group == "weapon_shotgun")
    level.attachmentinitialprimary = "barrelrange";
  else if(group == "weapon_assault" || group == "weapon_battle" || group == "weapon_smg" || group == "weapon_lmg" || group == "weapon_pistol" || weapon == "iw7_m1c")
    level.attachmentinitialprimary = "highcal";
}

addsurvivorattachmentssecondary(weapon) {
  level.attachmentsurvivorsecondary = "none";
  level.attachmentsurvivorsecondarytwo = "none";
  group = scripts\mp\utility\weapon::getweapongroup(weapon);

  if(group == "weapon_pistol")
    level.attachmentsurvivorsecondary = "highcal";

  if(scripts\mp\utility\game::matchmakinggame()) {
    if(weapon == "iw7_g18c") {
      level.attachmentsurvivorsecondary = "akimbo";
      level.attachmentsurvivorsecondarytwo = "highcal";
    }
  }
}

addinitialattachmentssecondary(weapon) {
  level.attachmentinitialsecondary = "none";
  level.attachmentinitialsecondarytwo = "none";
  group = scripts\mp\utility\weapon::getweapongroup(weapon);

  if(group == "weapon_pistol")
    level.attachmentinitialsecondary = "highcal";

  if(scripts\mp\utility\game::matchmakinggame()) {
    if(weapon == "iw7_g18c") {
      level.attachmentinitialsecondary = "akimbo";
      level.attachmentinitialsecondarytwo = "highcal";
    }
  }
}

monitorsurvivaltime() {
  self endon("death_or_disconnect");
  self endon("infected");
  level endon("game_ended");

  for(;;) {
    if(!level.infect_chosefirstinfected || !isDefined(self.survivalstarttime) || !isalive(self)) {
      waitframe();
      continue;
    }

    setsurvivaltime(0);
    wait 1.0;
  }
}

initsurvivaltime(_id_CACEB3FF609E8C65) {
  scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(_id_CACEB3FF609E8C65) && _id_CACEB3FF609E8C65)
    self notify("infected");
}

setsurvivaltime(_id_CACEB3FF609E8C65) {
  if(!isDefined(self.survivalstarttime))
    self.survivalstarttime = self.spawntime;

  _id_26F7788064111742 = int((gettime() - self.survivalstarttime) / 1000);

  if(_id_26F7788064111742 > 999)
    _id_26F7788064111742 = 999;

  scripts\mp\utility\stats::setextrascore0(_id_26F7788064111742);

  if(isDefined(_id_CACEB3FF609E8C65) && _id_CACEB3FF609E8C65)
    self notify("infected");
}

shouldplayhalfwayvo() {
  if(!level.didhalfscorevoboost && getteamscore("axis") >= int(level.players.size - level.players.size / 2)) {
    team = "axis";
    scripts\mp\utility\dialog::leaderdialog("halfway_friendly_score", team, "status");
    _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(team);

    foreach(_id_F90358454413407F in _id_B0C33D224B825287)
    scripts\mp\utility\dialog::leaderdialog("halfway_enemy_score", _id_F90358454413407F, "status");

    level.didhalfscorevoboost = 1;
  }
}

updatematchstatushintonspawn() {
  level endon("game_ended");

  if(self.team == "allies")
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("infect_survive");
  else
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("infect_all");
}

nvgwatcher() {
  self endon("death");
  self endon("spawned");
  scripts\mp\flags::gameflagwait("prematch_done");
  timer = 0;
  _id_7809DB68000AEFEE = 0;

  for(;;) {
    if(self isnightvisionon()) {
      timer = timer + level.framedurationseconds;

      if(timer >= 1 && !_id_7809DB68000AEFEE) {
        scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/LOW_BATTERY");
        _id_7809DB68000AEFEE = 1;
      }

      if(timer >= 2) {
        self nightvisionviewoff();
        self setclientomnvar("ui_infect_nvg_hud_icon", 1);
        _id_3B64EB40368C1450::set("nvgWatcher", "nvg", 0);
        rechargenvg();
        _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("nvgWatcher");
        _id_7809DB68000AEFEE = 0;
        self setclientomnvar("ui_infect_nvg_hud_icon", 0);
        timer = 0;
      }
    }

    wait(level.framedurationseconds);
  }
}

rechargenvg() {
  timer = 0;

  while(timer < 5) {
    timer = timer + level.framedurationseconds;

    if(self isnightvisionon())
      self nightvisionviewoff();

    wait(level.framedurationseconds);
  }
}

perkpackage_checkifready_callback() {
  if(self.team == "axis") {
    if(scripts\mp\utility\perk::_hasperk("specialty_tacticalinsertion"))
      scripts\mp\utility\perk::removeperk("specialty_tacticalinsertion");

    if(!scripts\mp\utility\perk::_hasperk("specialty_tacticalinsertion"))
      scripts\mp\utility\perk::giveperk("specialty_tacticalinsertion");

    scripts\mp\equipment::giveequipment(level.infectedtactical, "secondary");
  }
}

tacinsert_gamemode_callback() {
  thread clearandrestoreinfectedtacinsert();
}

_id_911CBBEBF68AF0D8(spawnposition) {
  if(isDefined(level._id_2054BB1CC6580CE4)) {
    foreach(volume in level._id_2054BB1CC6580CE4) {
      if(ispointinvolume(spawnposition, volume))
        return 0;
    }
  }

  return 1;
}

_id_79F898A92FDBA4B2(spawnpointarray) {
  if(isDefined(spawnpointarray) && spawnpointarray.size > 0) {
    foreach(spawnpoint in spawnpointarray) {
      if(!_id_911CBBEBF68AF0D8(spawnpoint.origin))
        spawnpointarray = scripts\engine\utility::array_remove(spawnpointarray, spawnpoint);
    }
  }

  return spawnpointarray;
}

clearandrestoreinfectedtacinsert() {
  self.setspawnpoint.issuper = 1;
  self.loadoutfieldupgrade1 = "none";
  self.loadoutfieldupgrade2 = "none";
  self.loadoutfieldupgrade1 = level.infectedsuper;
  self.loadoutfieldupgrade2 = level.infectedsupertwo;
  wait 0.1;

  if(!isDefined(self.setspawnpoint) || !level._id_624C83B532EFCE04) {
    return;
  }
  if(istrue(level.skydiveontacinsertplacement)) {
    if(isDefined(self) && scripts\mp\utility\player::isreallyalive(self)) {
      self notify("giveLoadout_start");
      scripts\mp\supers::clearsuper();
      scripts\mp\perks\perkpackage::perkpackage_reset();
      self.perkpackagedata.istwomode = 1;
      scripts\mp\perks\perkpackage::perkpackage_setstate(0);
      self.perkpackagedata.super = "super_select";
      class = "gamemode";
      globalstruct = scripts\mp\class::loadout_getglobalclassstruct();
      globalstruct = scripts\mp\class::loadout_updateglobalclass(globalstruct, class);
      scripts\mp\class::loadout_updatefieldupgrades(globalstruct, class);

      if(scripts\mp\utility\perk::_hasperk("specialty_tacticalinsertion"))
        scripts\mp\utility\perk::removeperk("specialty_tacticalinsertion");

      if(!scripts\mp\utility\perk::_hasperk("specialty_tacticalinsertion"))
        scripts\mp\utility\perk::giveperk("specialty_tacticalinsertion");

      scripts\mp\equipment::giveequipment(level.infectedtactical, "secondary");
      thread scripts\mp\supers::givesuperpoints(level.infectbonussuperontacinsert, undefined, 1);
    }

    thread suicideandskydive();
  }
}

suicideandskydive() {
  if(scripts\mp\utility\player::isreallyalive(self)) {
    self.skipdeathicon = 1;
    self suicide();
    waitframe();

    if(isDefined(self)) {
      self.deaths = self.deaths - 1;
      self.pers["deaths"] = self.pers["deaths"] - 1;
    }
  }

  wait 1;

  if(isDefined(self))
    self.skipdeathicon = undefined;
}

registervehicletype(refname, _id_E4015CFE956F4F3F) {
  vehicleinfo = spawnStruct();
  vehicleinfo.refname = refname;
  vehicleinfo.spawncallback = _id_E4015CFE956F4F3F;
  vehicleinfo.vehiclespawns = scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F(refname);

  if(!isDefined(level.vehicleinfo))
    level.vehicleinfo = [];

  level.vehicleinfo[refname] = vehicleinfo;
}

init_infectgroundwarvehicles() {
  registervehicletype("atv", ::vehiclespawn_atv);
  level.vehiclespawnlocs = [];

  foreach(vehicleinfo in level.vehicleinfo) {
    if(vehicleinfo.refname == "atv") {
      if(level.mapname == "mp_farms2_gw" && level.localeid == "locale_9") {
        _id_7591ED99E87A77D3 = [];
        _id_060EC3549226CE8D = [];
        _id_7591ED99E87A77D3[0] = (46022, 1039, 56);
        _id_060EC3549226CE8D[0] = (7, 289, 0);
        _id_7591ED99E87A77D3[1] = (47881, -1404, 115);
        _id_060EC3549226CE8D[1] = (8, 294, 0);
        _id_7591ED99E87A77D3[2] = (47970, -22545, -320);
        _id_060EC3549226CE8D[2] = (9, 105, 0);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7591ED99E87A77D3.size; _id_AC0E594AC96AA3A8++) {
          _id_81C8D769CECC738E = spawnStruct();
          _id_81C8D769CECC738E.origin = _id_7591ED99E87A77D3[_id_AC0E594AC96AA3A8];
          _id_81C8D769CECC738E.angles = _id_060EC3549226CE8D[_id_AC0E594AC96AA3A8];
          _id_81C8D769CECC738E.script_noteworthy = "locale_9";
          _id_81C8D769CECC738E.targetname = "atv_spawn";
          _id_81C8D769CECC738E.vehicletype = "veh9_mil_lnd_atv_physics_mp";
          vehicleinfo.vehiclespawns[vehicleinfo.vehiclespawns.size] = _id_81C8D769CECC738E;
        }

        foreach(spawnpoint in vehicleinfo.vehiclespawns) {
          if(distancesquared(spawnpoint.origin, (53109, -8400, -710)) < 16384) {
            spawnpoint.origin = (46868, -457, 18);
            spawnpoint.angles = (11, 252, 0);
            continue;
          }

          if(distancesquared(spawnpoint.origin, (48215, -1671, 56)) < 16384) {
            spawnpoint.origin = (47906, -676, 55);
            spawnpoint.angles = (11, 309, 0);
          }
        }
      } else if(level.mapname == "mp_downtown_gw" && level.localeid == "locale_6") {
        _id_7591ED99E87A77D3 = [];
        _id_060EC3549226CE8D = [];
        _id_7591ED99E87A77D3[0] = (17806, -20823, -110);
        _id_060EC3549226CE8D[0] = (11, 358, 0);
        _id_7591ED99E87A77D3[1] = (16109, -24057, -144);
        _id_060EC3549226CE8D[1] = (1, 90, 0);
        _id_7591ED99E87A77D3[2] = (18227, -704, -448);
        _id_060EC3549226CE8D[2] = (7, 266, 0);
        _id_7591ED99E87A77D3[3] = (19180, 332, -447);
        _id_060EC3549226CE8D[3] = (6, 298, 0);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7591ED99E87A77D3.size; _id_AC0E594AC96AA3A8++) {
          _id_81C8D769CECC738E = spawnStruct();
          _id_81C8D769CECC738E.origin = _id_7591ED99E87A77D3[_id_AC0E594AC96AA3A8];
          _id_81C8D769CECC738E.angles = _id_060EC3549226CE8D[_id_AC0E594AC96AA3A8];
          _id_81C8D769CECC738E.script_noteworthy = "locale_6";
          _id_81C8D769CECC738E.targetname = "atv_spawn";
          _id_81C8D769CECC738E.vehicletype = "veh9_mil_lnd_atv_physics_mp";
          vehicleinfo.vehiclespawns[vehicleinfo.vehiclespawns.size] = _id_81C8D769CECC738E;
        }

        foreach(spawnpoint in vehicleinfo.vehiclespawns) {
          if(distancesquared(spawnpoint.origin, (18368, -21157, -107)) < 16384) {
            spawnpoint.origin = (16572, -19828, 86);
            spawnpoint.angles = (2, 55, 0);
            continue;
          }

          if(distancesquared(spawnpoint.origin, (19526, -15475, -97)) < 16384) {
            spawnpoint.origin = (19177, -15490, -116);
            spawnpoint.angles = (2, 64, 0);
          }
        }
      }
    }

    foreach(spawnpoint in vehicleinfo.vehiclespawns) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy == level.localeid) {
        index = level.vehiclespawnlocs.size;
        level.vehiclespawnlocs[index] = spawnpoint;
        level.vehiclespawnlocs[index].refname = vehicleinfo.refname;
      }
    }
  }

  if(0) {
    foreach(loc in level.vehiclespawnlocs)
    thread scripts\mp\utility\debug::drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  _id_FC617751F654A141 = level.numnonrallyvehicles;

  if(!isDefined(level.numnonrallyvehicles))
    _id_FC617751F654A141 = 25;

  if(0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
      loc = level.vehiclespawnlocs[_id_AC0E594AC96AA3A8];
      thread scripts\mp\utility\debug::drawline(loc.origin + (0, 0, 1500), loc.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
    loc = level.vehiclespawnlocs[_id_AC0E594AC96AA3A8];

    if(isDefined(loc)) {
      vehicleinfo = level.vehicleinfo[loc.refname];
      [[vehicleinfo.spawncallback]](loc);
    }
  }
}

vehiclespawn_atv(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", spawndata, _id_EE8DA5624236DC89);
}

vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;
  return spawndata;
}

infectjugg_setconfig() {
  health = getdvarint("dvar_BE3134DFF20F353A", 2000);
  self.maxhealth = health;
  self.startinghealth = health;
}

gamemodespawnprotectedcallback(eattacker, victim, idamage, objweapon, smeansofdeath) {
  _id_1F6FA3102BC4A682 = 0;

  if(eattacker.team == "axis" && _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename) && !scripts\mp\utility\weapon::weaponbypassspawnprotection(objweapon) && smeansofdeath != "MOD_MELEE")
    _id_1F6FA3102BC4A682 = 1;

  return _id_1F6FA3102BC4A682;
}

setfaketispawnpoint() {
  spawnpoint = getspawnpoint();
  setspawnpoint = spawn("script_model", spawnpoint.origin);
  setspawnpoint.playerspawnpos = spawnpoint.origin;
  setspawnpoint.playerspawnangles = spawnpoint.angles;
  setspawnpoint.notti = 0;
  setspawnpoint.issuper = 1;
  setspawnpoint.skipscriptable = 1;
  self.setspawnpoint = setspawnpoint;
}

vehicle_compass_infect_shouldbevisibletoplayer(vehicle, player) {
  return 1;
}

skydivehintnotify() {
  self endon("disconnect");
  self notify("skydive_spawn_tutorial");
  self endon("skydive_spawn_tutorial");
  _id_E9DEF77708D779B7 = 0;
  _id_63366D9D88CE51F8 = 1;

  for(;;) {
    if(_id_63366D9D88CE51F8)
      self waittill("giveLoadout");
    else
      self waittill("spawned");

    if(self.pers["team"] == "allies") {
      continue;
    }
    if(_id_E9DEF77708D779B7 < 2) {
      if(!_id_E9DEF77708D779B7)
        wait 5;

      scripts\mp\utility\lower_message::setlowermessageomnvar("infect_super_tac_hint");
      wait 5;
      scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
      _id_E9DEF77708D779B7++;
      continue;
    }

    break;
  }
}

_id_48C5A587383A90E7() {
  _id_6F2AB6D7F309B05D = getdvarint("dvar_71EA7A20EBC4487E", 0);
  return _id_6F2AB6D7F309B05D;
}