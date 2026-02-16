/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\zombies.gsc
*****************************************/

main() {
  setzombiesdlclevel();
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();
  maps\mp\zombies\_mutators::main();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 1);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
  }

  setdynamicdvar("r_hudOutlineWidth", 2);
  setdynamicdvar("scr_zombies_timeLimit", 0);
  setdynamicdvar("scr_zombies_numLives", 1);
  setdynamicdvar("hover_max_travel_distance", 5000);
  setdynamicdvar("scr_game_matchstarttime", 0);
  setdynamicdvar("scr_game_playerwaittime", 5);
  setdynamicdvar("scr_game_playerwaittime_ds", 5);
  setdynamicdvar("scr_game_graceperiod", 5);
  setdynamicdvar("scr_game_graceperiod_ds", 5);
  setdynamicdvar("scr_player_healthregentime", 3);
  maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
  setspecialloadouts();
  initpickups();
  loadeffects();
  level.teambased = 1;
  level.iszombiegame = 1;
  level.disableforfeit = 1;
  level.alwaysdrawfriendlynames = 1;
  level.scorelimitoverride = 1;
  level.allowlatecomers = 1;
  level.skiplivesxpscalar = 1;
  level.nocratetimeout = 1;
  level.assists_disabled = 1;
  level.skipspawnsighttraces = 1;
  level.killstreakrewards = 0;
  level.disableweaponstats = 1;
  level.gamehasstarted = 0;
  level.rankedmatch = 0;
  level.playerteam = "allies";
  level.enemyteam = "axis";
  level.spawndistanceteamskip = "axis";
  level.laststandusetime = 2000;
  level.grenadegraceperiod = 0;
  level.playermeleedamage = 150;
  level.playerexomeleedamage = 500;
  level.tokensenabled = 0;
  level.modifyweapondamage = [];
  level.damageweapontoweapon = [];
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onspawnplayer = ::onplayerspawn;
  level.modifyplayerdamage = ::modifyplayerdamagezombies;
  level.callbackplayerlaststand = maps\mp\zombies\_zombies_laststand::callback_playerlaststandzombies;
  level.callbackplayerdamage = ::callback_playerdamage;
  level.bypassclasschoicefunc = ::zombiegameclass;
  level.ondeadevent = ::ondeadevent;
  level.onsuicidedeath = ::onsuicidedeath;
  level.weapondropfunction = ::dropweaponfordeathzombies;
  level.autoassign = ::zombiesautoassign;
  level.groundslam = maps\mp\zombies\_terminals::zombiesgroundslam;
  level.groundslamhitplayer = maps\mp\zombies\_terminals::zombiesgroundslamhitplayer;
  level.weaponweightfunc = ::zombieweaponweight;
  level.customcratefunc = maps\mp\zombies\killstreaks\_zombie_killstreaks::airdropcustomfunc;
  level.customplaydeathsound = maps\mp\zombies\_zombies_audio::zmplaydeathsound;
  level.customplaydamagesound = maps\mp\zombies\_zombies_audio::zmplaydamagesound;
  level.bot_killstreak_setup_func = maps\mp\zombies\killstreaks\_zombie_killstreaks::bot_killstreak_setup;
  level.cb_usedkillstreak = maps\mp\zombies\_util::removeksicon;
  level.callbackplayergrenadesuicide = ::ongrenadesuicide;
  level.disablespawningforplayerfunc = ::disablespawningforplayerfunc;
  level.hurttriggerfunc = ::hurtplayersthink;
  level.moversuicidecustom = ::moversuicidecustom;
}

loadeffects() {
  level._effect["mutant_blood_pool"] = loadfx("vfx/blood/dlc_zombie_gib_bloodpool");
  level._effect["mutant_gib_death"] = loadfx("vfx/blood/dlc_zombie_gib_burst");
  level._effect["electrical_arc"] = loadfx("fx/misc/electrical_arc");
  level._effect["slow_zone"] = loadfx("vfx/test/hms_mutant_ooze_impact_burst");
  level._effect["boost_jump"] = loadfx("vfx/code/high_jump_jetpack");
  level._effect["boost_lunge"] = loadfx("vfx/code/dodge_forward_jetpack");
  level._effect["boost_dodge_back"] = loadfx("vfx/code/dodge_back_jetpack");
  level._effect["boost_dodge_right"] = loadfx("vfx/code/dodge_right_jetpack");
  level._effect["boost_dodge_left"] = loadfx("vfx/code/dodge_left_jetpack");
  level._effect["torso_arm_loss_left"] = loadfx("vfx/blood/dlc_zombie_torso_loss_arm_le");
  level._effect["torso_arm_loss_left_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_arm_le_emz");
  level._effect["torso_arm_loss_left_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_arm_le_chrz");
  level._effect["torso_arm_loss_left_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_arm_le_xplod");
  level._effect["torso_arm_loss_right"] = loadfx("vfx/blood/dlc_zombie_torso_loss_arm_ri");
  level._effect["torso_arm_loss_right_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_arm_ri_emz");
  level._effect["torso_arm_loss_right_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_arm_ri_chrz");
  level._effect["torso_arm_loss_right_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_arm_ri_xplod");
  level._effect["torso_head_loss"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head");
  level._effect["torso_head_loss_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_head_emz");
  level._effect["torso_head_loss_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_head_ovrchrz");
  level._effect["torso_head_loss_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_head_xplod");
  level._effect["torso_loss_left"] = loadfx("vfx/blood/dlc_zombie_torso_loss_impact_le");
  level._effect["torso_loss_left_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_leg_le_emz");
  level._effect["torso_loss_left_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_leg_le_chrz");
  level._effect["torso_loss_left_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_leg_le_xplod");
  level._effect["torso_loss_right"] = loadfx("vfx/blood/dlc_zombie_torso_loss_impact_ri");
  level._effect["torso_loss_right_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_leg_ri_emz");
  level._effect["torso_loss_right_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_leg_ri_chrz");
  level._effect["torso_loss_right_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_leg_ri_xplod");
  level._effect["arm_loss_left"] = loadfx("vfx/blood/dlc_zombie_arm_loss_impact_le");
  level._effect["arm_loss_left_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_arm_le_emz");
  level._effect["arm_loss_left_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_arm_le_ovrchrz");
  level._effect["arm_loss_left_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_arm_le_xplod");
  level._effect["arm_loss_right"] = loadfx("vfx/blood/dlc_zombie_arm_loss_impact_ri");
  level._effect["arm_loss_right_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_arm_ri_emz");
  level._effect["arm_loss_right_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_arm_ri_ovrchrz");
  level._effect["arm_loss_right_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_arm_ri_xplod");
  level._effect["head_loss"] = loadfx("vfx/blood/dlc_zombie_head_loss_impact");
  level._effect["head_loss_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_head_emz");
  level._effect["head_loss_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_head_ovrchrz");
  level._effect["head_loss_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_head_xplod");
  level._effect["limb_loss_left"] = loadfx("vfx/blood/dlc_zombie_limb_loss_impact_le");
  level._effect["limb_loss_left_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_leg_le_emz");
  level._effect["limb_loss_left_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_leg_le_ovrchrz");
  level._effect["limb_loss_left_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_leg_le_xplod");
  level._effect["limb_loss_right"] = loadfx("vfx/blood/dlc_zombie_limb_loss_impact_ri");
  level._effect["limb_loss_right_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_leg_ri_emz");
  level._effect["limb_loss_right_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_leg_ri_ovrchrz");
  level._effect["limb_loss_right_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_leg_ri_xplod");
  level._effect["gib_full_body"] = loadfx("vfx/blood/dlc_zombie_gib_full_body");
  level._effect["gib_full_body_cheap"] = loadfx("vfx/blood/dlc_zombie_gib_full_body_cheap");
  level._effect["gib_full_body_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_gib_full_body_emz");
  level._effect["gib_full_body_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_gib_full_body_ovrchrz");
  level._effect["gib_full_body_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_gib_full_body_xplod");
  level._effect["gib_bloodpool"] = loadfx("vfx/blood/dlc_zombie_blood_tread_fx");
  level._effect["crawl_dust"] = loadfx("vfx/treadfx/DLC/crawl_dust");
  level._effect["nuke_blast"] = loadfx("vfx/gameplay/mp/zombie/zombie_nuke_burst");
  loadeyeeffects();
  level._effect["station_buy_weapon"] = loadfx("vfx/props/dlc_prop_weapon_dispenser_fx_main");
  level._effect["station_buy_weapon_pwr_on"] = loadfx("vfx/props/dlc_prop_weapon_dispenser_icon_pwr_on");
  level._effect["station_buy_exo"] = loadfx("vfx/props/dlc_prop_exo_buy_fx_main");
  level._effect["station_buy_exo_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_buy_icon_pwr_on");
  level._effect["station_buy_exo_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_buy_icon_pwr_off");
  level._effect["station_mystery_box"] = loadfx("vfx/props/dlc_prop_mystery_box_fx_main");
  level._effect["station_mystery_box_icon_on"] = loadfx("vfx/props/dlc_prop_mystery_box_icon_pwr_on");
  level._effect["station_mystery_box_icon_off"] = loadfx("vfx/props/dlc_prop_mystery_box_icon_pwr_off");
  level._effect["station_mystery_box_icon_money"] = loadfx("vfx/props/dlc_prop_mystery_box_icon_money");
  level._effect["station_upgrade_exo"] = loadfx("vfx/props/dlc_prop_exo_upgrade_fx_main");
  level._effect["station_upgrade_exo_health_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_health_pwr_on");
  level._effect["station_upgrade_exo_health_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_health_pwr_off");
  level._effect["station_upgrade_exo_reload_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_reload_pwr_on");
  level._effect["station_upgrade_exo_reload_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_reload_pwr_off");
  level._effect["station_upgrade_exo_revive_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_revive_pwr_on");
  level._effect["station_upgrade_exo_revive_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_revive_pwr_off");
  level._effect["station_upgrade_exo_slam_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_slam_pwr_on");
  level._effect["station_upgrade_exo_slam_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_slam_pwr_off");
  level._effect["station_upgrade_exo_stabilizer_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_stble_pwr_on");
  level._effect["station_upgrade_exo_stabilizer_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_stble_pwr_off");
  level._effect["station_upgrade_exo_tactarmor_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_tact_pwr_on");
  level._effect["station_upgrade_exo_tactarmor_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_tact_pwr_off");
  level._effect["station_upgrade_weapon"] = loadfx("vfx/props/dlc_prop_weapon_upgrade_fx_main");
  level._effect["station_upgrade_weapon_pwr_on"] = loadfx("vfx/props/dlc_prop_weapon_upg_icon_pwr_on");
  level._effect["weapon_cycle_slow"] = loadfx("vfx/props/dlc_prop_mystery_box_weap_lp");
  level._effect["weapon_cycle_fast"] = loadfx("vfx/props/dlc_prop_mystery_box_weap_lp_fast");

  if(maps\mp\zombies\_util::getzombieslevelnum() == 3) {
    if(level.currentgen) {} else {
      level._effect["weapon_cycle_slow"] = loadfx("vfx/props/dlc3_prop_mystery_box_weap_lp");
      level._effect["weapon_cycle_fast"] = loadfx("vfx/props/dlc3_prop_mystery_box_weap_lp_fast");
    }
  } else if(maps\mp\zombies\_util::getzombieslevelnum() == 4) {
    if(level.nextgen) {
      level._effect["weapon_cycle_slow"] = loadfx("vfx/props/dlc4_prop_mystery_box_weap_lp");
      level._effect["weapon_cycle_fast"] = loadfx("vfx/props/dlc4_prop_mystery_box_weap_lp_fast");
    }
  }

  level._effect["magic_box_move"] = loadfx("vfx/props/dlc_prop_mystery_box_weap_broken");
  level._effect["weapon_level_20"] = loadfx("vfx/props/dlc_prop_weapon_upg_fanfare");
  level._effect["magic_box_steam"] = loadfx("vfx/props/dlc_prop_mystery_box_use");
  level._effect["wall_buy_steam"] = loadfx("vfx/props/dlc_prop_weapon_dispenser_use");
  level._effect["pickup_nuke"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_apocalypse");
  level._effect["pickup_doublepoints"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_dble_pts");
  level._effect["pickup_instakill"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_insta_kill");
  level._effect["pickup_maxammo"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_max_ammo");
  level._effect["pickup_firesale"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_power_surge");
  level._effect["pickup_tombstone"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_tombstone");
  level._effect["pickup_trap"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_trap");
}

loadeyeeffectsfortype(var_0, var_1) {
  if(!isDefined(level.valideyetypes)) {
    level.valideyetypes = ["vanilla", "emp", "exploder", "fast"];
  }

  if(isDefined(level.addvalideyetypesfunc)) {
    [[level.addvalideyetypesfunc]]();
  }

  if(!isDefined(level.validheadtypes)) {
    level.validheadtypes = ["afr_dlc_a", "afr_dlc_b", "afr_dlc_c", "cau_dlc_a", "cau_dlc_b", "cau_dlc_c", "shg_dlc_b"];
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = "zombie_eye_" + var_0;
  level._effect[var_2] = loadfx("vfx/gameplay/mp/zombie/" + var_2);

  if(!var_1) {
    foreach(var_4 in level.validheadtypes) {
      var_2 = "zombie_eye_" + var_0 + "_" + var_4;
      level._effect[var_2] = loadfx("vfx/gameplay/mp/zombie/" + var_2);
    }
  }
}

geteyeeffectforzombie(var_0, var_1) {
  var_2 = var_1;

  if(isDefined(var_1) && common_scripts\utility::string_starts_with(var_1, "zombies_head_")) {
    var_2 = getsubstr(var_1, 13);
  }

  if(!isDefined(var_2) || !isDefined(common_scripts\utility::array_find(level.validheadtypes, var_2))) {
    var_3 = "zombie_eye_" + var_0;
  } else {
    var_3 = "zombie_eye_" + var_0 + "_" + var_2;
  }

  return var_3;
}

loadeyeeffects() {
  loadeyeeffectsfortype("vanilla");
  loadeyeeffectsfortype("emp");
  loadeyeeffectsfortype("exploder");
  loadeyeeffectsfortype("fast");
}

zombieweaponweight(var_0) {
  var_1 = tablelookup("mp/zombieStatsTable.csv", 0, var_0, 1);

  if(!isDefined(var_1) || var_1 == "") {
    var_1 = tablelookup("mp/statstable.csv", 4, var_0, 8);
  }

  if(!isDefined(var_1) || var_1 == "") {
    var_1 = 4;
  }

  return int(var_1);
}

initpickups() {
  level.pickupents = [];
  level.maxpickupsperround = getmaxpickupsperround();
  level.percentchancetodrop = getpercentchancetodrop();
  level.dropscheduled = 0;
  level.currentpickupcount = 0;
  level.pickuphuds = [];
  level.pickuprotation = [];
  level.pickuprotationindex = 0;
  level.pickuprecent = undefined;
  level.firesaletestcounter = 0;
  level.pickup["ammo"]["func"] = ::ammopickup;
  level.pickup["ammo"]["fx"] = "pickup_maxammo";
  level.pickup["insta_kill"]["func"] = ::instakillpickup;
  level.pickup["insta_kill"]["fx"] = "pickup_instakill";
  level.pickup["double_points"]["func"] = ::doublepointspickup;
  level.pickup["double_points"]["fx"] = "pickup_doublepoints";
  level.pickup["fire_sale"]["func"] = ::firesalepickup;
  level.pickup["fire_sale"]["fx"] = "pickup_firesale";
  level.pickup["nuke"]["func"] = ::nukepickup;
  level.pickup["nuke"]["fx"] = "pickup_nuke";
  level.pickup["trap"]["func"] = ::trappickup;
  level.pickup["trap"]["fx"] = "pickup_trap";
  prespawnpickupents();
  randomizepickuplist();
  level thread scheduledrops();
}

prespawnpickupents() {
  var_0 = 4;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    spawnpickupent();
  }
}

getpickupent() {
  var_0 = undefined;

  foreach(var_2 in level.pickupents) {
    if(!var_2.inuse) {
      var_0 = var_2;
      break;
    }
  }

  if(!isDefined(var_0)) {
    var_0 = spawnpickupent();
  }

  var_0 show();
  var_0.inuse = 1;
  var_0 dontinterpolate();
  var_0.trigger dontinterpolate();
  return var_0;
}

spawnpickupent() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("dlc_dogtags_zombie_invisible");
  var_0 ghost();
  var_0.inuse = 0;
  var_0.trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
  level.pickupents[level.pickupents.size] = var_0;
  return var_0;
}

randomizepickuplist() {
  level.pickuprotation = [];

  foreach(var_2, var_1 in level.pickup) {
    level.pickuprotation[level.pickuprotation.size] = var_2;
  }

  for(level.pickuprotation = common_scripts\utility::array_randomize(level.pickuprotation); isDefined(level.pickuprecent) && level.pickuprotation.size > 1 && level.pickuprotation[0] == level.pickuprecent; level.pickuprotation = common_scripts\utility::array_randomize(level.pickuprotation)) {}
}

selectnextpickup() {
  if(level.pickuprotationindex >= level.pickuprotation.size) {
    level.pickuprotationindex = 0;
    randomizepickuplist();
  }

  if(isDefined(level.pickuprecent) && level.pickuprotation[level.pickuprotationindex] == level.pickuprecent && level.pickuprotationindex < level.pickuprotation.size - 1) {
    var_0 = level.pickuprotation[level.pickuprotationindex];
    level.pickuprotation[level.pickuprotationindex] = level.pickuprotation[level.pickuprotationindex + 1];
    level.pickuprotation[level.pickuprotationindex + 1] = var_0;
  }

  var_1 = level.pickuprotation[level.pickuprotationindex];
  level.pickuprotationindex++;
  return var_1;
}

ispickupvalid(var_0) {
  if(isDefined(level.pickuprecent) && var_0 == level.pickuprecent) {
    return 0;
  }

  if(var_0 == "fire_sale") {
    if(!maps\mp\zombies\_wall_buys::magicboxhasmoved()) {
      return 0;
    }

    if(level.wavecounter <= 5) {
      return 0;
    }

    if(maps\mp\_utility::gameflag("fire_sale")) {
      return 0;
    }

    level.firesaletestcounter++;

    if(level.firesaletestcounter % 2 == 1) {
      return 0;
    }
  }

  if(var_0 == "trap") {
    if(isDefined(level.trappickupdisabled)) {
      return 0;
    }

    if(!maps\mp\zombies\_doors::doorhasbeenopened()) {
      return 0;
    }
  }

  return 1;
}

selectnextvalidpickup() {
  for(var_0 = selectnextpickup(); !ispickupvalid(var_0); var_0 = selectnextpickup()) {}

  return var_0;
}

selectnextvalidpickupavoid(var_0) {
  var_1 = selectnextvalidpickup();

  if(var_1 != var_0) {
    return var_1;
  }

  while(var_1 == var_0) {
    var_1 = selectnextvalidpickup();
  }

  for(var_2 = level.pickuprotation.size - 1; var_2 >= level.pickuprotationindex; var_2--) {
    level.pickuprotation[var_2 + 1] = level.pickuprotation[var_2];
  }

  level.pickuprotation[level.pickuprotationindex] = var_0;

  if(level.pickuprotationindex < level.pickuprotation.size - 1 && level.pickuprotation[level.pickuprotationindex] == level.pickuprotation[level.pickuprotationindex + 1]) {
    level.pickuprotationindex++;
  }

  return var_1;
}

scheduledrops() {
  level waittill("zombie_wave_started");
  var_0 = level.players.size * 1000;
  var_1 = level.players.size * 2000;
  var_2 = 1.14;
  var_3 = var_0 + var_1;
  pickupdebugprint("Next Scheduled at " + var_3 + " points");

  for(;;) {
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(isDefined(var_6.moneyearnedtotal)) {
        var_4 = var_4 + var_6.moneyearnedtotal;
      }
    }

    if(var_4 > var_3) {
      level.dropscheduled = 1;
      pickupdebugprint("Reached Scheduled " + var_4 + ">" + var_3);
      var_1 = var_1 * var_2;
      var_3 = var_4 + var_1;
      pickupdebugprint("Next Scheduled at " + var_3 + " points");
    }

    wait 0.5;
  }
}

getmaxpickupsperround() {
  var_0 = maps\mp\zombies\_util::getnumplayers() + 1;
  return clamp(var_0, 2, 4);
}

getpercentchancetodrop() {
  if(maps\mp\zombies\_util::getzombieslevelnum() >= 3) {
    return 1;
  } else {
    return 2;
  }
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_zombies_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
  setdynamicdvar("scr_zombies_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
  setdynamicdvar("scr_zombies_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
  setdynamicdvar("scr_zombies_halftime", 0);
  maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
  setdynamicdvar("scr_zombies_timeLimit", 0);
  maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
  setdynamicdvar("scr_zombies_numLives", 1);
  maps\mp\_utility::registernumlivesdvar(level.gametype, 1);
  setdynamicdvar("r_hudOutlineWidth", 1);
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  maps\mp\_utility::setobjectivetext("allies", &"ZOMBIES_EMPTY_STRING");
  maps\mp\_utility::setobjectivetext("axis", &"ZOMBIES_EMPTY_STRING");
  maps\mp\_utility::setobjectivescoretext("allies", &"ZOMBIES_EMPTY_STRING");
  maps\mp\_utility::setobjectivescoretext("axis", &"ZOMBIES_EMPTY_STRING");
  maps\mp\_utility::setobjectivehinttext("allies", undefined);
  maps\mp\_utility::setobjectivehinttext("axis", undefined);
  thread init_spawns();
  thread init_structs();
  var_0[0] = level.gametype;
  maps\mp\gametypes\_gameobjects::main(var_0);
  initzombiesettings();
  level thread zombievignette();
  level thread onplayerconnectzombies();
  level thread maps\mp\zombies\_util::handlenetworkeffects();
  level thread initializedefaultcharacter();
  level thread maps\mp\zombies\zombies_spawn_manager::init();
  level thread maps\mp\zombies\_wall_buys::init();
  level thread maps\mp\zombies\_power::init();
  level thread maps\mp\zombies\_doors::init();
  level thread maps\mp\zombies\_terminals::init();
  level thread maps\mp\zombies\_traps::init();
  level thread maps\mp\zombies\killstreaks\_zombie_killstreaks::init();
  level thread maps\mp\zombies\weapons\_zombie_weapons::init();
  level thread maps\mp\zombies\_zombies_audio::init();
  level thread maps\mp\zombies\_zombies_sidequests::init();
  level thread maps\mp\zombies\_debug::init();
  level thread runzombiesmode();
  level thread handlezombieshostmigration();
  thread horde_audio();

  if(isDefined(level.onstartgametypelevelfunc)) {
    [[level.onstartgametypelevelfunc]]();
  }
}

initzombiesettings() {
  maps\mp\_utility::gameflaginit("insta_kill", 0);
  maps\mp\_utility::gameflaginit("double_points", 0);
  maps\mp\_utility::gameflaginit("fire_sale", 0);
  maps\mp\_utility::gameflaginit("power_off", 0);
  level.wavecounter = 0;
  level.specialroundnumber = 0;
  level.specialroundcounter = 0;
  level.roundtype = "normal";
  level.lastenemydeathpos = (0, 0, 0);
  level.zombiegamepaused = 0;
  level.doorsopenedbitmask = 0;
  level.pointevents = [];
  level.pointevents["damage_body"] = 10;
  level.pointevents["damage_head"] = 10;
  level.pointevents["kill_trap"] = 10;
  level.pointevents["kill_limb"] = 50;
  level.pointevents["kill_streak"] = 40;
  level.pointevents["kill_body"] = 60;
  level.pointevents["kill_head"] = 100;
  level.pointevents["kill_melee"] = 130;
  level.pointevents["power_on"] = 100;
  level.pointevents["atm"] = 100;
  level.pointevents["atm_jackpot"] = 10;
  level.pointevents["cure"] = 100;
  level.pointevents["crate"] = 500;
  level.pointevents["nuke"] = 400;
  level.pointevents["reward_bronze"] = 500;
  level.pointevents["reward_silver"] = 1000;
  level.pointevents["reward_gold"] = 2000;
  level.pointevents["breach_fix"] = 200;

  if(!isDefined(level.doorbitmaskarray)) {
    level.doorbitmaskarray = [];
  }
}

setzombiesdlclevel() {
  level.zombiedlclevel = 99;
  var_0 = getDvar("mapname");

  if(var_0 == "mp_zombie_lab") {
    level.zombiedlclevel = 1;
  } else if(var_0 == "mp_zombie_brg") {
    level.zombiedlclevel = 2;
  } else if(var_0 == "mp_zombie_ark") {
    level.zombiedlclevel = 3;
  } else if(var_0 == "mp_zombie_h2o") {
    level.zombiedlclevel = 4;
  }
}

zombiesautoassign() {
  thread maps\mp\gametypes\_menus::setteam("allies");
  self.sessionteam = "allies";
}

onplayerconnectzombies() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread maps\mp\zombies\_zombies_audio::init_audio_functions();
    var_0 thread playermonitorweapon();
    var_0 thread playermonitorboostevents();
    var_0 thread playermonitortokenuse();
    var_0 thread playermonitorlastgroundpos();
    level thread createplayervariables(var_0);
    var_1 = undefined;

    if(isDefined(level.givecustomcharacters)) {
      var_0[[level.givecustomcharacters]](var_1);
    } else {
      var_0 maps\mp\zombies\_util::givecustomcharactersdefault(var_1);
    }

    if(isbot(var_0)) {
      continue;
    }
  }
}

playermonitorlastgroundpos() {
  self endon("disconnect");

  for(;;) {
    if(maps\mp\zombies\_util::getzombieslevelnum() == 4 && maps\mp\zombies\_util::is_true(self.inwater)) {
      waitframe();
      continue;
    }

    if(self isonground() && !maps\mp\zombies\_util::is_true(self.disabletombstonedropinarea)) {
      self.lastgroundposition = self.origin;
    }

    waitframe();
  }
}

playermonitortokenuse() {
  self endon("disconnect");

  if(!isbot(self)) {
    self notifyonplayercommand("TokenUseDown", "+actionslot 3");
    self notifyonplayercommand("TokenUseUp", "-actionslot 3");
  }

  for(;;) {
    self.tokenbuttonpressed = 0;
    self waittill("TokenUseDown");
    self.tokenbuttonpressed = 1;
    self waittill("TokenUseUp");
  }
}

initializedefaultcharacter() {
  var_0 = ["head_hero_cormack_sentinel_halo", "mp_exo_01a"];
  maps\mp\zombies\_util::initializecharactermodel("default", "atlas_arctic_guard_body_mp", "viewhands_security_guard", var_0);
}

createplayervariables(var_0) {
  var_0.weaponstate = [];
  var_0.pointnotifylua = [];
  var_0.hasradar = 0;
  var_0.radarshowenemydirection = 0;
  var_0.magicboxuses = 0;
  var_0.trapuses = 0;
  var_0.headshotkills = 0;
  var_0.meleekills = 0;
  var_0.sidequest = 0;
  var_0.numberofdowns = 0;
  var_0.numberofbleedouts = 0;
  var_0.exosuitround = 0;
  var_0.numupgrades = 0;

  if(maps\mp\zombies\_util::iszombieshardmode()) {
    var_0.deaths = 0;
    var_0.score = 0;
    var_0.timeplayed["total"] = 0;
    var_0.suicides = 0;
    var_0.kills = 0;
    var_0.headshots = 0;
    var_0.assists = 0;
    var_0 maps\mp\_utility::setpersstat("kills", 0);
    var_0 maps\mp\_utility::setpersstat("assists", 0);
  }

  var_0 resetmoney(500);
  var_0 inittokens();
  maps\mp\zombies\_util::clearzombiestats(var_0);
  createzombieweaponstate(var_0, "iw5_titan45zm_mp");
  level thread monitorpointnotifylua(var_0);
  level thread weaponleveldisplay(var_0);
  level thread playerinitroundmatchdata(var_0);
}

updatepersistentmoney() {
  var_0 = 8388607;
  var_1 = 128;
  var_2 = 65536;
  var_3 = self.moneycurrent;

  if(var_3 > var_0) {
    var_3 = var_0;
  }

  var_4 = int(var_3 / var_2);
  var_5 = var_3 % var_2;
  self.extrascore1 = var_4;
  maps\mp\_utility::setpersstat("extrascore1", var_4);
  self.score = var_5;
  maps\mp\_utility::setpersstat("score", var_5);
  var_6 = 67108863;
  var_7 = 1024;
  var_8 = 65536;
  var_9 = self.moneyearnedtotal;

  if(var_9 > var_6) {
    var_9 = var_6;
  }

  var_10 = int(var_9 / var_8);
  var_11 = var_9 % var_8;
  self.deaths = var_10;
  maps\mp\_utility::setpersstat("deaths", var_10);
  self.extrascore0 = var_11;
  maps\mp\_utility::setpersstat("extrascore0", var_11);
}

resetmoney(var_0) {
  self.moneycurrent = var_0;
  self.moneyearnedtotal = var_0;
  updatepersistentmoney();
}

givemoney(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0;

  if(var_1 > 9999) {
    var_1 = 9999;
  }

  self.pointnotifylua[self.pointnotifylua.size] = var_1;

  if(level.gameended) {
    return;
  }
  self.moneycurrent = self.moneycurrent + var_0;
  self.moneyearnedtotal = self.moneyearnedtotal + var_0;

  if(isDefined(self.roundmoneyearned)) {
    self.roundmoneyearned = self.roundmoneyearned + var_0;
  }

  givemoneybagsachievement();
  updatepersistentmoney();
}

givemoneybagsachievement() {
  if(self.moneycurrent < 15000 || isDefined(self.moneybags)) {
    return;
  }
  givezombieachievement("DLC1_ZOMBIE_MONEYBAGS");
  self.moneybags = 1;
}

spendmoney(var_0) {
  var_1 = 0 - var_0;

  if(var_1 < -9999) {
    var_1 = -9999;
  }

  self.pointnotifylua[self.pointnotifylua.size] = var_1;
  self.moneycurrent = self.moneycurrent - var_0;

  if(isDefined(self.roundmoneyspent)) {
    self.roundmoneyspent = self.roundmoneyspent + var_0;
  }

  updatepersistentmoney();
}

getcurrentmoney(var_0) {
  return var_0.moneycurrent;
}

inittokens() {
  var_0 = self getcommonplayerdatareservedint("tokensAvailable");
  settokens(var_0);
}

gettokenusetime() {
  return 1000;
}

hastoken(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  return self.tokens >= var_0;
}

givetoken(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  settokens(self.tokens + var_0);
}

spendtoken(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  settokens(self.tokens - var_0);
}

settokens(var_0) {
  if(level.tokensenabled) {
    if(var_0 < 0) {
      var_0 = 0;
    }

    self.tokens = var_0;
    self setcommonplayerdatareservedint("tokensAvailable", self.tokens);
    self setclientomnvar("ui_zm_token_count", self.tokens);
  } else {
    self.tokens = -1;
    self setclientomnvar("ui_zm_token_count", -1);
  }
}

createzombieweaponstate(var_0, var_1) {
  var_2 = getweaponbasename(var_1);

  if(maps\mp\zombies\_util::haszombieweaponstate(var_0, var_2)) {
    return;
  }
  var_0.weaponstate[var_2]["level"] = 1;
}

weaponleveldisplay(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    var_0 common_scripts\utility::waittill_any("weaponLevelEarned", "weapon_change");
    var_1 = maps\mp\zombies\_util::getplayerweaponzombies(var_0);
    var_2 = getweaponbasename(var_1);

    if(!maps\mp\zombies\_util::haszombieweaponstate(var_0, var_2)) {
      continue;
    }
    var_3 = var_0.weaponstate[var_2]["level"];

    if(100 < var_3) {
      var_3 = 100;
    }

    var_0 setclientomnvar("ui_horde_count", var_3);
  }
}

playerinitroundmatchdata(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("spawned");
  var_1 = 0;

  if(isDefined(level.wavecounter)) {
    var_1 = level.wavecounter - 1;
  }

  var_0 maps\mp\zombies\_util::recordplayermatchdataforroundstart(var_1);
}

monitordisconnect(var_0) {
  level endon("game_ended");
  var_0 waittill("disconnect");
  level notify("player_disconnected");
}

zombiegameclass() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level.modeloadouts[level.playerteam];
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
}

onplayerspawn() {
  if(isagent(self)) {
    self thread[[maps\mp\agents\_agent_utility::agentfunc("spawn")]]();
  } else {
    maps\mp\zombies\_util::zombieallowallboost(0, "class");
    maps\mp\zombies\_terminals::onplayerspawn();
    thread onspawnfinished();
  }
}

onspawnfinished(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("applyLoadout");
  maps\mp\killstreaks\_killstreaks::clearkillstreaks();

  if(maps\mp\zombies\_util::isonhumanteam(self)) {
    var_1 = "iw5_titan45zm_mp";

    if(isPlayer(self)) {
      if(isDefined(self.characterindex)) {
        var_2 = "ui_zm_character_" + self.characterindex + "_alive";
        setomnvar(var_2, 1);
      }

      self setlethalweapon("frag_grenade_throw_zombies_mp");
      self giveweapon("frag_grenade_throw_zombies_mp");
      self setweaponammoclip("frag_grenade_throw_zombies_mp", 4);
      maps\mp\_utility::giveperk("specialty_pistoldeath", 0);
      maps\mp\_utility::giveperk("specialty_wildcard_duallethals", 0);
      maps\mp\_utility::giveperk("specialty_coldblooded", 0);

      if(level.wavecounter <= 1 && !isDefined(self.joinedround1)) {
        self.joinedround1 = 1;
      }

      self.hideondeath = undefined;

      if(isDefined(self.body)) {
        self.body delete();
      }

      if((!isDefined(self.playedspawnweaponflourish) || !self.playedspawnweaponflourish) && (!isDefined(level.zombieinitialcountdownover) || !level.zombieinitialcountdownover)) {
        playintroweaponflourish();
        self.playedspawnweaponflourish = 1;
      } else {
        var_1 = maps\mp\zombies\_wall_buys::getupgradeweaponname(self, "iw5_titan45zm_mp");
        self giveweapon(var_1);
        self setspawnweapon(var_1);
      }
    }

    self givemaxammo(var_1);
  }
}

waittoloadweapons(var_0) {
  self endon("disconnect");

  for(;;) {
    if(self hasloadedcustomizationplayerview(self, var_0)) {
      break;
    }

    waitframe();
  }
}

freezecontrolsduringcharacterintroflourish() {
  self endon("disconnect");
  self freezecontrols(1);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(4.0);
  self freezecontrols(0);
}

getcharacterintroweaponname() {
  switch (self.characterindex) {
    case 0:
      return "char_intro_guardzm_mp";
    case 1:
      return "char_intro_execzm_mp";
    case 2:
      return "char_intro_itzm_mp";
    case 3:
    default:
      if(maps\mp\zombies\_util::getzombieslevelnum() >= 3) {
        return "char_intro_pilotzm_mp";
        return;
      }

      return "char_intro_janitorzm_mp";
      return;
  }
}

getcharacterintroidleweapon() {
  switch (self.characterindex) {
    case 3:
      return "char_intro_pilotidlezm_mp";
    default:
      return "";
  }
}

getexosuitequipweaponname() {
  switch (self.characterindex) {
    case 0:
      return "exo_suit_equip_guardzm_mp";
    case 1:
      return "exo_suit_equip_execzm_mp";
    case 2:
      return "exo_suit_equip_itzm_mp";
    case 3:
    default:
      if(maps\mp\zombies\_util::getzombieslevelnum() >= 3) {
        return "exo_suit_equip_pilotzm_mp";
        return;
      }

      return "exo_suit_equip_janitorzm_mp";
      return;
  }
}

getexosuitequipweaponduration() {
  return 2.7;
}

getexosuitperkweaponname(var_0) {
  switch (var_0) {
    case "health":
      return "exo_suit_perk_healthzm_mp";
    case "slam":
      return "exo_suit_perk_slamzm_mp";
    case "fastreload":
      return "exo_suit_perk_speedzm_mp";
    case "stabilizer":
      return "exo_suit_perk_stabilizerzm_mp";
    case "stim":
    default:
      return "exo_suit_perk_stimzm_mp";
  }
}

getexosuitperkweaponduration() {
  return 1.5;
}

playpilotintroweaponflourish() {
  self endon("disconnect");
  var_0 = "char_intro_pilotidlezm_mp";
  var_1 = "char_intro_pilotzm_mp";
  var_2[0] = "iw5_titan45zm_mp";
  var_2[1] = var_1;
  var_2[2] = var_0;
  self hasloadedcustomizationplayerview(self, var_2);
  self giveweapon(var_0);
  self switchtoweaponimmediate(var_0);
  self disableweaponswitch();
  maps\mp\zombies\_util::playerallowfire(0, "flourish");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.2);
  thread freezecontrolsduringcharacterintroflourish();
  wait 1;
  self giveweapon(var_1);
  self switchtoweaponimmediate(var_1);
  common_scripts\utility::_disableweaponswitch();
  maps\mp\zombies\_util::playerallowfire(0, "flourish");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(3.6);
  waittoloadweapons(var_2);
  common_scripts\utility::_enableweaponswitch();
  maps\mp\zombies\_util::playerallowfire(1, "flourish");
  self takeweapon(var_0);
  self takeweapon(var_1);
  self giveweapon("iw5_titan45zm_mp");
  self switchtoweaponimmediate("iw5_titan45zm_mp");
}

playintroweaponflourish() {
  if(maps\mp\zombies\_util::getzombieslevelnum() >= 3 && self.characterindex == 3) {
    playpilotintroweaponflourish();
    return;
  }

  self endon("disconnect");
  var_0 = getcharacterintroweaponname();
  var_1[0] = "iw5_titan45zm_mp";
  var_1[1] = var_0;
  waittoloadweapons(var_1);
  thread freezecontrolsduringcharacterintroflourish();
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
  self giveweapon(var_0);
  self switchtoweaponimmediate(var_0);
  common_scripts\utility::_disableweaponswitch();
  maps\mp\zombies\_util::playerallowfire(0, "flourish");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(3.6);
  common_scripts\utility::_enableweaponswitch();
  maps\mp\zombies\_util::playerallowfire(1, "flourish");
  self takeweapon(var_0);
  self giveweapon("iw5_titan45zm_mp");
  self switchtoweaponimmediate("iw5_titan45zm_mp");
}

playweaponflourish(var_0, var_1) {
  self endon("disconnect");

  if(maps\mp\zombies\_util::isplayerinlaststand(self)) {
    return;
  }
  var_2 = self getcurrentweapon(1);

  if(maps\mp\zombies\_util::iszombiekillstreakweapon(var_2) || maps\mp\zombies\_util::isrippedturretweapon(var_2)) {
    return;
  }
  self.playingweaponflourish = 1;
  self giveweapon(var_0);
  self switchtoweaponimmediate(var_0);
  common_scripts\utility::_disableweaponswitch();
  maps\mp\zombies\_util::playerallowfire(0, "flourish");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_1);
  maps\mp\zombies\_util::playerallowfire(1, "flourish");
  self takeweapon(var_0);
  common_scripts\utility::_enableweaponswitch();

  if(!maps\mp\zombies\_util::isplayerinlaststand(self)) {
    self switchtoweaponimmediate(var_2);
  }

  self.playingweaponflourish = 0;
}

closeclassmenu() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;

  if(!isagent(self)) {
    thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(-1);
  }
}

waituntilmatchstart() {
  maps\mp\_utility::gameflagwait("prematch_done");
  setomnvar("ui_match_countdown_title", 0);

  while(!isDefined(level.bot_loadouts_initialized) || level.bot_loadouts_initialized == 0) {
    wait 0.05;
  }

  while(!level.players.size) {
    wait 0.05;
  }
}

watchforhostmigrationsetround() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_end");
    var_0 = int(max(level.wavecounter, 1));
    setomnvar("ui_horde_round_number", var_0);

    foreach(var_2 in level.players) {
      if(isai(var_2)) {
        continue;
      }
      if(!isDefined(var_2)) {
        continue;
      }
      if(!isDefined(var_2.horde_perks)) {
        continue;
      }
      if(!var_2.horde_perks.size) {
        continue;
      }
      var_3 = var_2.horde_perks.size;

      for(var_4 = 0; var_4 < var_3; var_4++) {
        if(!isDefined(var_2)) {
          continue;
        }
        if(!isagent(var_2)) {
          var_2 setclientomnvar("ui_horde_update_perk", var_2.horde_perks[var_4]["index"]);
        }

        wait 0.05;
      }
    }
  }
}

getspawnpoint() {
  var_0 = self.team;

  if(maps\mp\zombies\_util::isonhumanteam(self)) {
    var_1 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_0);

    if(level.ingraceperiod) {
      var_2 = level.startspawnpoints;

      if(isDefined(level.filterstartspawnfunc)) {
        var_2 = self[[level.filterstartspawnfunc]](var_2);
      }

      var_3 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_2);
    } else if(isDefined(self.lastdeathpos)) {
      if(isDefined(level.filterrespawnfunc)) {
        var_1 = self[[level.filterrespawnfunc]](var_1);
      }

      var_3 = maps\mp\zombies\_zombies_spawnscoring::getzombiesspawnpoint_neartombstone(var_1);
    } else {
      if(isDefined(level.filterrespawnfunc)) {
        var_1 = self[[level.filterrespawnfunc]](var_1);
      }

      var_3 = maps\mp\zombies\_zombies_spawnscoring::getzombiesspawnpoint_nearteam(var_1);
    }

    return var_3;
  }

  var_1 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_0);
  var_3 = maps\mp\gametypes\_spawnscoring::getspawnpoint_safeguard(var_1);
  return var_3;
}

onnormaldeath(var_0, var_1, var_2) {}

onsuicidedeath(var_0) {
  var_1 = "ui_zm_character_" + var_0.characterindex + "_alive";
  setomnvar(var_1, 0);
}

ongrenadesuicide(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(level.players.size > 1) {
    var_0 laststanddie();
  }

  [[level.callbackplayerlaststand]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
}

disablespawningforplayerfunc(var_0) {
  return !self.hasspawned && level.wavecounter > 1 && isDefined(level.zombie_wave_running) && level.zombie_wave_running;
}

callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if((var_4 == "MOD_MELEE" || var_4 == "MOD_IMPACT") && self issprinting()) {
    thread meleesprintdeactivate();
  }

  maps\mp\gametypes\_damage::callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

meleesprintdeactivate() {
  self endon("death");
  level endon("game_ended");
  self allowsprint(0);
  waitframe();

  if(isalive(self)) {
    self allowsprint(1);
  }
}

playerinvinciblefromcrateorpowerup(var_0, var_1, var_2) {
  if(maps\mp\zombies\_util::iscrategodmode(var_0)) {
    if(isDefined(var_2) && var_2 == "MOD_TRIGGER_HURT") {
      return 0;
    }

    if(isDefined(var_1)) {
      if(maps\mp\zombies\_util::is_true(var_1.iszomboni)) {
        return 0;
      }

      if(isai(var_1) && !isscriptedagent(var_1)) {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

isfriendlyfireroundkill(var_0, var_1, var_2, var_3, var_4, var_5) {
  return maps\mp\zombies\_util::isfriendlyfireround() && isDefined(var_0) && isDefined(var_2) && isDefined(var_0.characterindex) && isDefined(var_2.characterindex) && var_0 != var_2;
}

calculatefriendlyfirerounddamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    return 0;
  }

  if(var_5 == "repulsor_zombie_mp") {
    return 0;
  }

  var_6 = maps\mp\_utility::getbaseweaponname(var_5);

  if(isDefined(var_4) && isexplosivedamagemod(var_4)) {
    return 25;
  } else if(isDefined(var_4) && maps\mp\_utility::ismeleemod(var_4)) {
    return 34;
  } else {
    var_7 = 3;
    var_8 = 0;

    if(var_6 == "iw5_em1zm_mp") {
      var_7 = 2;
    } else if(var_6 == "iw5_gm6zm_mp") {
      var_7 = 34;
    }

    if(isDefined(var_2.weaponstate) && isDefined(var_2.weaponstate[var_5]) && isDefined(var_2.weaponstate[var_5]["level"])) {
      var_8 = var_2.weaponstate[var_5]["level"];
    }

    return var_7 + var_8;
  }
}

modifyplayerdamagezombies(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_3;

  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_5)) {
    return 0;
  }

  if(isfriendlyfireroundkill(var_0, var_1, var_2, var_3, var_4, var_5)) {
    return calculatefriendlyfirerounddamage(var_0, var_1, var_2, var_3, var_4, var_5);
  }

  var_10 = 1;

  if(isDefined(var_2) && var_2.classname == "trigger_hurt" && var_9 == 999999) {
    var_10 = 0;
  }

  if(var_10) {
    if(isDefined(var_0.godmode) && var_0.godmode) {
      return 0;
    }

    if(isDefined(var_0.onlydamagedbylargeenemies) && var_0.onlydamagedbylargeenemies) {
      if(isDefined(var_2) && !(isDefined(var_2.meleesectortype) && var_2.meleesectortype == "large")) {
        return 0;
      }
    }
  }

  if(isDefined(var_2) && isDefined(var_2.owner)) {
    var_2 = var_2.owner;
  }

  var_11 = maps\mp\_utility::attackerishittingteam(var_0, var_2);
  var_12 = getweaponbasename(var_5);

  if(!isDefined(var_12)) {
    var_12 = "none";
  }

  if(isDefined(level.damageweapontoweapon[var_12])) {
    var_12 = level.damageweapontoweapon[var_12];
  }

  if(isDefined(level.defusedamagemultiplier) && maps\mp\zombies\_util::is_true(var_0.isdefusing) && isai(var_2) && !isscriptedagent(var_2)) {
    var_9 = int(var_9 * level.defusedamagemultiplier);
  }

  if(isPlayer(var_0)) {
    if(isai(var_2) && var_2 maps\mp\zombies\_util::zombiewaitingfordeath()) {
      return 0;
    }

    if(var_11) {
      return 0;
    }

    if(maps\mp\zombies\_util::isplayerinlaststand(var_0)) {
      return 0;
    }

    if(maps\mp\zombies\_util::is_true(var_0.enteringgoliath)) {
      return 0;
    }

    if(playerinvinciblefromcrateorpowerup(var_0, var_1, var_4)) {
      return 0;
    }

    if(isDefined(var_0.lastrevivetime)) {
      var_13 = 1000;

      if(gettime() - var_0.lastrevivetime < var_13) {
        return 0;
      }
    }

    if(isDefined(var_5) && (maps\mp\_utility::iskillstreakweapon(var_5) || maps\mp\zombies\_util::iszombieequipment(var_5) || maps\mp\zombies\_traps::isexplosivetrap(var_5) || var_5 == "exploder_zm_small_mp")) {
      return 0;
    }

    if(var_12 == "iw5_exocrossbowzm_mp" || var_12 == "iw5_mahemzm_mp") {
      var_9 = 20;
    }

    if(isDefined(var_2) && isai(var_2)) {
      var_13 = 500;

      if(isscriptedagent(var_2) && isDefined(var_0.lastzombiedamagetime) && gettime() - var_0.lastzombiedamagetime < var_13) {
        return 0;
      }

      var_14 = level.agentclasses[var_2.agent_type].melee_damage_scale;
      var_15 = level.agentclasses[var_2.agent_type].damage_scale;

      if(isDefined(var_14) && var_4 == "MOD_MELEE") {
        var_9 = int(max(var_9 * var_14, 1));
      } else if(isDefined(var_15)) {
        var_9 = int(max(var_9 * var_15, 1));
      }
    }

    if(maps\mp\zombies\_util::isplayerinfected(var_0)) {
      return int(min(var_9, var_0.health - 1));
    }

    if(isDefined(var_2) && isai(var_2)) {
      if(isDefined(level.ondamageplayerfunc) && isDefined(level.ondamageplayerfunc[var_2.agent_type])) {
        var_2[[level.ondamageplayerfunc[var_2.agent_type]]](var_0);
      }
    }

    if(var_5 == "exploder_zm_large_mp") {
      var_0 addzmexploderbloodfx();
    }
  }

  if(isai(var_0) && !isPlayer(var_0) && !isDefined(var_2)) {
    if(var_4 == "MOD_FALLING") {
      return 0;
    }

    if(var_5 == "exploder_zm_small_mp" || var_5 == "exploder_zm_large_mp") {
      var_9 = int(level.wavecounter * 100 + 50);
    }

    if(maps\mp\zombies\_util::isinstakill() && !var_0 maps\mp\zombies\_util::instakillimmune()) {
      var_9 = var_0.maxhealth + 10;
    }
  }

  if(isai(var_0) && !isPlayer(var_0) && isai(var_2)) {
    if(!isscriptedagent(var_2) && isalliedsentient(var_0, var_2)) {
      return 0;
    }

    if(isDefined(var_0.agent_type) && var_0.agent_type == "sq_character" && var_0.godmode) {
      return 0;
    }

    if(isDefined(var_0.agent_type) && var_0.agent_type == "zm_squadmate") {
      var_15 = level.agentclasses[var_2.agent_type].damagescalevssquadmates;

      if(isDefined(var_15)) {
        var_9 = int(var_9 * var_15);
      }
    }

    if(maps\mp\zombies\_util::is_true(var_0.nodamageself) && var_0 == var_2) {
      return 0;
    }
  }

  if(isai(var_0) && !isPlayer(var_0) && isDefined(var_1) && var_1.classname == "misc_turret") {
    if(isDefined(var_1.team) && var_1.team == var_0.team) {
      return 0;
    }
  }

  if(isDefined(var_2) && isPlayer(var_2) && isai(var_0) && !isPlayer(var_0)) {
    if(isDefined(level.modifyweapondamage[var_12])) {
      var_9 = [[level.modifyweapondamage[var_12]]](var_0, var_2, var_9, var_4, var_5, var_6, var_7, var_8);
    }

    if(isDefined(level.modifyweapondamagebyagenttype) && isDefined(var_0.agent_type)) {
      if(isDefined(level.modifyweapondamagebyagenttype[var_0.agent_type]) && isDefined(level.modifyweapondamagebyagenttype[var_0.agent_type][var_12])) {
        var_9 = [[level.modifyweapondamagebyagenttype[var_0.agent_type][var_12]]](var_0, var_2, var_9, var_4, var_5, var_6, var_7, var_8);
      }
    }

    var_9 = var_0 maps\mp\zombies\killstreaks\_zombie_killstreaks::modifydamagekillstreak(var_1, var_2, var_9, var_5, var_4);

    if(maps\mp\zombies\_util::haszombieweaponstate(var_2, var_12)) {
      var_16 = 0.2;

      if(isDefined(var_2.weaponstate[var_12]["weapon_level_increase"])) {
        var_16 = var_2.weaponstate[var_12]["weapon_level_increase"];
      }

      var_9 = int(var_9 + var_9 * var_16 * (var_2.weaponstate[var_12]["level"] - 1));
    }

    var_9 = var_0 modifyplayerequipmentdamage(var_5, var_9, var_4, var_6);

    if(isDefined(var_4) && var_4 == "MOD_MELEE") {
      if(var_2 ishighjumpallowed()) {
        var_9 = level.playerexomeleedamage;
      } else {
        var_9 = level.playermeleedamage;
      }
    }

    if(isDefined(level.modifydamagebyagenttype) && isDefined(level.modifydamagebyagenttype[var_0.agent_type])) {
      var_9 = [[level.modifydamagebyagenttype[var_0.agent_type]]](var_0, var_2, var_9, var_4, var_5, var_6, var_7, var_8);
    }

    var_9 = var_0 mutatormodifydamage(var_1, var_2, var_5, var_9, var_8, var_4);
    var_9 = var_0 trapmodifydamage(var_5, var_9, var_8, var_4);

    if(maps\mp\zombies\_util::is_true(var_0.inairforleap)) {
      var_9 = var_9 * 2;
    }

    if(isDefined(level.zombie_rewards)) {
      if(isDefined(level.laststandupgrade) && level.laststandupgrade == 1 && maps\mp\zombies\_util::isplayerinlaststand(var_2)) {
        var_9 = var_9 * 4;
      }
    }

    if(maps\mp\zombies\_util::isinstakill() && !var_0 maps\mp\zombies\_util::instakillimmune()) {
      var_9 = var_0.maxhealth + 10;
    }

    if(var_0 maps\mp\zombies\_util::zombiewaitingfordeath()) {
      return 0;
    }

    if(var_0 maps\mp\zombies\_util::zombieshouldwaitfordeath(var_0, var_2, var_9, var_4, var_5, var_6, var_7, var_8)) {
      var_0 thread maps\mp\zombies\_util::zombiedelaydeath(var_0, var_2, var_9, var_4, var_5, var_6, var_7, var_8);
      return 0;
    }

    if(!maps\mp\zombies\_util::ispendingdeath(var_0)) {
      var_2 givepointsfordamage(var_0, var_9, var_4, var_5, var_6, var_7, var_8, 0);
    }

    if(isDefined(level.processenemydamagedfunc)) {
      self thread[[level.processenemydamagedfunc]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  }

  if(isPlayer(var_0)) {
    var_0 maps\mp\zombies\_zombies_audio::player_hurt(var_2, var_9, var_4);

    if(isDefined(var_2) && isai(var_2) && isscriptedagent(var_2)) {
      var_0.lastzombiedamagetime = gettime();
    }
  } else if(isai(var_0) && isscriptedagent(var_0)) {
    var_0 maps\mp\zombies\_zombies_audio::zombie_hurt(var_2, var_9);
  }

  return var_9;
}

modifyplayerequipmentdamage(var_0, var_1, var_2, var_3) {
  if(var_2 == "MOD_IMPACT") {
    return var_1;
  }

  if(maps\mp\zombies\_util::iszombiednagrenade(var_0)) {
    return level.wavecounter * var_1;
  }

  if(isDefined(var_0) && var_0 == "repulsor_zombie_mp") {
    if(maps\mp\zombies\_util::instakillimmune()) {
      return 0;
    }

    if(isDefined(self.agent_type) && issubstr(self.agent_type, "ranged_elite_soldier_goliath")) {
      return 0;
    }

    var_4 = 0;

    foreach(var_6 in level.agentclasses) {
      var_7 = calculatezombiehealth(var_6);

      if(var_7 > var_4) {
        var_4 = var_7;
      }
    }

    return var_4 + 1;
  }

  if(isDefined(var_0) && var_0 == "teleport_zombies_mp") {
    if(var_2 == "MOD_CRUSH") {
      return var_1;
    }
  }

  if(maps\mp\zombies\_util::iszombieequipment(var_0) || maps\mp\zombies\_traps::isexplosivetrap(var_0)) {
    var_1 = level.wavecounter * randomintrange(100, 200);

    if(isDefined(level.modifyplayerequipmentdamagefunc)) {
      var_1 = [[level.modifyplayerequipmentdamagefunc]](var_0, var_1, var_3);
    }

    if(isDefined(self.agent_type) && isDefined(level.modifyequipmentdamagebyagenttype) && isDefined(level.modifyequipmentdamagebyagenttype[self.agent_type])) {
      var_1 = [[level.modifyequipmentdamagebyagenttype[self.agent_type]]](var_0, var_1, var_3);
    }
  }

  return var_1;
}

mutatormodifydamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = isDefined(level.zmdamageignoresarmor) && [[level.zmdamageignoresarmor]](var_0, var_1, var_2, var_3, var_4, var_5);

  if(!var_6) {
    if(isDefined(self.hashelmet) && maps\mp\_utility::isheadshot(var_2, var_4, var_5)) {
      var_3 = int(var_3 * 0.5);
    }

    if(isDefined(self.hasarmor) && !maps\mp\_utility::isheadshot(var_2, var_4, var_5)) {
      var_3 = int(var_3 * 0.5);
    }
  }

  return var_3;
}

zmdamageignoresarmor(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_2)) {
    if(var_2 == "repulsor_zombie_mp") {
      return 1;
    }

    if(var_2 == "explosive_touch_zombies_mp") {
      return 1;
    }

    if(var_2 == "teleport_zombies_mp" &var_5 == "MOD_CRUSH") {
      return 1;
    }
  }

  if(isDefined(var_0)) {
    if(maps\mp\zombies\_util::is_true(var_0.iszomboni)) {
      return 1;
    }

    if(maps\mp\zombies\_util::is_true(var_0.is_door)) {
      return 1;
    }
  }

  return 0;
}

trapmodifydamage(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && var_0 == "trap_sniper_zm_mp") {
    if(common_scripts\utility::cointoss()) {
      var_1 = self.health + 10;

      if(isDefined(self.maxhealth)) {
        var_1 = self.maxhealth + 10;
      }
    } else {
      var_1 = int(self.health * 0.5);

      if(isDefined(self.maxhealth)) {
        var_1 = int(self.maxhealth * 0.5);
      }
    }

    if(maps\mp\zombies\_util::istrapresistant()) {
      var_1 = int(var_1 * 0.05);
    }
  }

  if(isDefined(var_0) && var_0 == "zombie_trap_turret_mp") {
    if(maps\mp\zombies\_util::istrapresistant()) {
      var_1 = int(var_1 * 0.05);
    }
  }

  return var_1;
}

givepointsfordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = maps\mp\_utility::isheadshot(var_3, var_6, var_2, self);
  var_9 = maps\mp\_utility::ismeleemod(var_2) || var_2 == "MOD_IMPACT";
  var_10 = var_1 >= var_0.health;
  var_11 = maps\mp\_utility::iskillstreakweapon(var_3);
  var_12 = maps\mp\zombies\_util::istrapweapon(var_3);

  if(var_9 && var_6 == "shield") {
    return;
  }
  var_13 = undefined;

  if(var_10) {
    var_13 = "kill_limb";

    if(var_8) {
      var_13 = "kill_head";
      self.headshotkills++;
    }

    if(var_9 && !var_12) {
      var_13 = "kill_melee";
      self.meleekills++;
    } else {
      if(isbodyshot(var_3, var_6, var_2, self)) {
        var_13 = "kill_body";
      }

      if(var_11) {
        var_13 = "kill_streak";
      }

      if(var_12) {
        var_13 = "kill_trap";
      }

      if(isDefined(level.givepointsforkillshotfunc)) {
        var_13 = [[level.givepointsforkillshotfunc]](var_13, var_3);
      }
    }
  } else {
    if(var_11) {
      return;
    }
    if(var_12) {
      return;
    }
    var_13 = "damage_body";

    if(var_8 && (isDefined(var_3) && !maps\mp\_utility::iskillstreakweapon(var_3))) {
      var_13 = "damage_head";
    }

    if(!playercanawardpointsfordamage(var_3, var_0)) {
      return;
    }
  }

  givepointsforevent(var_13);
}

playercanawardpointsfordamage(var_0, var_1) {
  if(issubstr(var_0, "iw5_em1zm_mp") || var_0 == "turretheadenergy_mp") {
    if(isDefined(self.nextem1pointstime) && gettime() < self.nextem1pointstime) {
      return 0;
    }

    self.nextem1pointstime = gettime() + 200.0;
  } else if(isDefined(var_1) && maps\mp\zombies\_util::iszombiednagrenade(var_0)) {
    if(isDefined(var_1.nextdnaaoepointstime) && gettime() < var_1.nextdnaaoepointstime) {
      return 0;
    }

    var_1.nextdnaaoepointstime = gettime() + 1000;
  }

  if(isDefined(level.playercanawardpointsfordamagefunc) && ![[level.playercanawardpointsfordamagefunc]](var_0, var_1)) {
    return 0;
  }

  if(maps\mp\zombies\_util::iszombieshardmode()) {
    return 0;
  }

  return 1;
}

isbodyshot(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(isDefined(var_3.owner)) {
      if(var_3.code_classname == "script_vehicle") {
        return 0;
      }

      if(var_3.code_classname == "misc_turret") {
        return 0;
      }

      if(var_3.code_classname == "script_model") {
        return 0;
      }
    }

    if(isDefined(var_3.agent_type)) {
      if(var_3.agent_type == "dog" || var_3.agent_type == "alien") {
        return 0;
      }
    }
  }

  var_4 = var_1 == "torso_upper" || var_1 == "right_arm_upper" || var_1 == "left_arm_upper" || var_1 == "gun" || var_1 == "torso_lower";
  return var_4 && !maps\mp\_utility::ismeleemod(var_2) && var_2 != "MOD_IMPACT" && !maps\mp\_utility::isenvironmentweapon(var_0);
}

givepointsforevent(var_0, var_1, var_2) {
  if(isDefined(level.disablescoring) && level.disablescoring) {
    return;
  }
  var_3 = level.pointevents[var_0];

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  if(!var_3) {
    return;
  }
  if(maps\mp\_utility::gameflag("double_points")) {
    var_3 = int(var_3 * 2);
  }

  if(isDefined(var_2) && var_2) {
    var_4 = common_scripts\utility::tostring(var_3);
    var_4 = strinsertnumericdelimiters(var_4);
    self iprintlnbold(&"ZOMBIES_PLUS_CREDITS", var_4);
  }

  givemoney(var_3);
}

canbuy(var_0, var_1) {
  if(var_0 > getcurrentmoney(self)) {
    if(!isDefined(var_1) || !var_1) {
      displayneedmoremoneymessage(self);
    }

    self playlocalsound("interact_purchase_fail");
    return 0;
  }

  if(isDefined(self.playingweaponflourish) && self.playingweaponflourish) {
    self playlocalsound("interact_purchase_fail");
    return 0;
  }

  return 1;
}

attempttobuy(var_0, var_1) {
  if(!canbuy(var_0, var_1)) {
    return 0;
  }

  spendmoney(var_0);
  return 1;
}

displayneedmoremoneymessage(var_0) {
  var_0 playsoundtoplayer("ui_button_error", var_0);
  var_0 iprintlnbold(&"ZOMBIES_NEED_MORE_MONEY");
}

monitorpointnotifylua(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    if(var_0.pointnotifylua.size > 0) {
      if(!isagent(var_0)) {
        var_0 setclientomnvar("ui_zm_award_points", var_0.pointnotifylua[var_0.pointnotifylua.size - 1]);
      }

      var_0.pointnotifylua = removelastelement(var_0.pointnotifylua);
    }

    wait 0.05;
  }
}

removelastelement(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    var_1[var_2] = var_0[var_2];
  }

  return var_1;
}

maydropweaponzombies(var_0) {
  if(isai(self)) {
    return 0;
  }

  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  var_1 = getweaponbasename(var_0);

  if(var_1 == "iw5_titan45zm_mp") {
    return 0;
  }

  return 1;
}

shouldsavetombstoneweapon() {
  if(!maps\mp\zombies\_util::is_true(self.laststand) && !maps\mp\zombies\_util::is_true(self.infected)) {
    var_0 = self getcurrentprimaryweapon();
    return !maps\mp\_utility::iskillstreakweapon(var_0);
  }

  return 0;
}

dropweaponfordeathzombies(var_0, var_1, var_2) {
  if(maps\mp\zombies\_util::iszombieshardmode()) {
    return;
  }
  if(isai(self)) {
    return;
  }
  var_3 = maps\mp\zombies\_util::getplayerweaponzombies(self);

  if(shouldsavetombstoneweapon()) {
    maps\mp\zombies\_zombies_laststand::savelaststandweapons(var_3, 0);
  }

  if(isDefined(self.tombstoneweapon)) {
    var_3 = self.tombstoneweapon;
  }

  if(!maydropweaponzombies(var_3)) {
    return;
  }
  var_4 = self.origin;

  if(isDefined(var_2)) {
    var_4 = var_2;
  } else if(isDefined(var_1) && (var_1 == "MOD_TRIGGER_HURT" || var_1 == "MOD_SUICIDE") && isDefined(self.lastgroundposition)) {
    var_4 = self.lastgroundposition;
  } else if(isDefined(self.disabletombstonedropinarea) && self.disabletombstonedropinarea && isDefined(self.lastgroundposition)) {
    var_4 = self.lastgroundposition;
  }

  var_5 = (0, 0, 18);
  var_6 = spawn("script_model", var_4 + var_5);
  var_6 setModel("dlc_dogtags_zombie_invisible");
  var_6 scriptmodelplayanim("mp_dogtag_spin");
  var_6 hide();
  var_6.owner = self;
  var_6.curorigin = var_4 + var_5;
  var_6.trackingweaponname = var_3;
  var_6.visuals = spawn("script_model", var_4 + var_5);
  var_6.visuals setModel("pickups_zombies_01_tombstone");
  var_6.visuals hide();
  var_6.visuals hudoutlineenable(1, 0);
  var_6.visuals linkto(var_6, "j_dogtag", (0, 0, -12), (0, 0, 0));
  var_6.trigger = spawn("trigger_radius", var_4 + var_5, 0, 32, 32);

  foreach(var_8 in level.players) {
    if(var_6.owner == var_8) {
      var_6 showtoplayer(var_6.owner);
      var_6.visuals showtoplayer(var_6.owner);
    }
  }

  maps\mp\zombies\_util::playfxontagforclientnetwork(level._effect["pickup_tombstone"], var_6, "j_dogtag", var_6.owner);
  var_6 thread watchweaponownerdisconnect();
  var_6 thread watchweaponpickupzombies();
  var_6 thread removeweaponpickupzombies(var_2);
}

watchweaponownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self.owner waittill("disconnect");
  self.visuals delete();
  self.trigger delete();
  self delete();
}

watchweaponpickupzombies() {
  self endon("death");

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(var_0 == self.owner) {
      if(canpickuptombstone(var_0)) {
        break;
      } else {
        wait 0.25;
      }
    }
  }

  maps\mp\zombies\_wall_buys::givezombieweapon(var_0, self.trackingweaponname, undefined, level.dotombstoneweaponswitch);
  var_0 thread maps\mp\gametypes\_hud_message::splashnotify("zombie_tombstome");
  var_0 playlocalsound("zmb_pickup_general");
  self.visuals delete();
  self.trigger delete();
  self delete();
}

canpickuptombstone(var_0) {
  if(maps\mp\zombies\_util::isplayerinlaststand(var_0)) {
    return 0;
  }

  if(isDefined(var_0.playingweaponflourish) && var_0.playingweaponflourish) {
    return 0;
  }

  return 1;
}

removeweaponpickupzombies(var_0) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_0)) {
    self.owner common_scripts\utility::waittill_any("started_spawnPlayer", "disconnect");
  }

  wait 52;
  thread startweaponpickupflashing();
  wait 8;

  if(!isDefined(self)) {
    return;
  }
  self.visuals delete();
  self.trigger delete();
  self delete();
}

startweaponpickupflashing() {
  self endon("trigger");
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  for(;;) {
    self hide();
    self.visuals hide();
    wait 0.25;
    self showtoplayer(self.owner);
    self.visuals showtoplayer(self.owner);
    wait 0.25;
  }
}

ondeadevent(var_0) {
  if(var_0 != level.enemyteam) {
    maps\mp\zombies\_zombies_laststand::zombieendgame();
  }
}

setspecialloadouts() {
  level.modeloadouts["allies"] = maps\mp\gametypes\_class::getemptyloadout();
  level.modeloadouts["allies"]["loadoutPrimary"] = "none";
  level.modeloadouts["allies"]["loadoutSecondary"] = "none";
}

init_spawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  level.spawn_name = "mp_tdm_spawn";
  maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", level.spawn_name);
  maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", level.spawn_name);
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

init_structs() {
  while(!isDefined(level.struct_class_names)) {
    wait 0.05;
  }

  level.evac_points = common_scripts\utility::getStructArray("evac_point", "targetname");
}

runzombiesmode() {
  waituntilmatchstart();
  level.gamehasstarted = 1;
  level thread maps\mp\zombies\_zombies_audio::play_level_start_vox();
  level thread maps\mp\zombies\_zombies::init();
  runinitialcountdown();
  level.zombieinitialcountdownover = 1;

  for(;;) {
    updatezombiesettings();

    while(maps\mp\zombies\_util::iszombiegamepaused()) {
      waitframe();
    }

    if(isDefined(level.zombieroundstartupdate)) {
      [[level.zombieroundstartupdate]]();
    }

    runroundstart(level.wavecounter);
    level notify("zombie_wave_started");

    while(maps\mp\zombies\_util::iszombiegamepaused()) {
      waitframe();
    }

    maps\mp\zombies\_zombies_audio_announcer::announcerrounddialog(level.roundtype);

    if(isDefined(level.runwavefunc) && isDefined(level.runwavefunc[level.roundtype])) {
      level thread[[level.runwavefunc[level.roundtype]]](level.wavecounter);
    } else {
      level thread maps\mp\zombies\zombies_spawn_manager::runwave(level.wavecounter);
    }

    level waittill("zombie_wave_ended");
    runroundend();
  }
}

handlezombieshostmigration() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_begin");

    if(level.wavecounter > 4 || maps\mp\zombies\_util::iszombieshardmode()) {
      setnojipscore(1);
    }

    level.dismemberedbodyparts = [];
    level.nextdismemberedbodypartindex = 0;
  }
}

horde_audio() {
  self endon("death");
  wait 1;
  level.horde_audio_ent = spawn("script_origin", (0, 0, 0));

  for(;;) {
    level.horde_audio_ent scalevolume(0);
    level waittill("zombie_wave_started");
    wait 0.5;

    if(level.roundtype == "zombie_dog") {
      level.horde_audio_ent playSound("zmb_dog_round_start");
      wait 1.5;
      level.horde_audio_ent playLoopSound("zmb_horde_dog");
    } else if(level.roundtype == "zombie_host") {
      level.horde_audio_ent playSound("zmb_hst_round_start");
      wait 1.5;
      level.horde_audio_ent playLoopSound("zmb_horde_host");
    } else if(level.roundtype == "normal") {
      level.horde_audio_ent playSound("zmb_gen_round_start");
      wait 1.5;
      level.horde_audio_ent playLoopSound("zmb_horde_general");
    }

    level.horde_audio_ent scalevolume(1, 3);
    level waittill("zombie_wave_ended");
    level.horde_audio_ent stoploopsound();
  }
}

runinitialcountdown() {
  wait 5;
}

updatezombiesettings() {
  level.wavecounter++;

  if(maps\mp\zombies\_util::isspecialround()) {
    level.specialroundcounter++;
  }

  level.roundtype = calculateroundtype();
  level.maxpickupsperround = getmaxpickupsperround();
  level.percentchancetodrop = getpercentchancetodrop();
  level.currentpickupcount = 0;

  foreach(var_1 in level.agentclasses) {
    var_1.roundhealth = calculatezombiehealth(var_1);
  }

  if(level.specialroundnumber <= level.wavecounter - 1) {
    level.specialroundnumber = calculatenextspecialround();
  }

  if(level.wavecounter > 4) {
    setnojipscore(1);
  }

  giveroundachievement();
  level notify("zombie_round_count_update");
}

giveroundachievement() {
  var_0 = undefined;
  var_1 = maps\mp\_utility::getmapname();

  if(var_1 == "mp_zombie_h2o" && level.wavecounter == 7 && level.doorsopenedbitmask == 0) {
    giveplayerszombieachievement("DLC4_ZOMBIE_NODOORS");
  }

  switch (var_1) {
    case "mp_zombie_lab":
      var_0 = "DLC1_";
      break;
    case "mp_zombie_brg":
      var_0 = "DLC2_";
      break;
    case "mp_zombie_ark":
      var_0 = "DLC3_";
      break;
    default:
      return;
  }

  switch (level.wavecounter) {
    case 10:
      var_0 = var_0 + "ZOMBIE_ROUND10";
      break;
    case 25:
      if(var_1 == "mp_zombie_lab") {
        var_0 = var_0 + "ZOMBIE_ROUND30";
        break;
      } else if(var_1 == "mp_zombie_brg") {
        var_0 = var_0 + "ZOMBIE_ROUND25";
        break;
      } else {
        return;
      }

      break;
    case 30:
      if(var_1 == "mp_zombie_ark") {
        var_0 = var_0 + "ZOMBIE_ROUND30";
      } else {
        return;
      }

      break;
    default:
      return;
  }

  giveplayerszombieachievement(var_0);
}

calculatenextspecialround() {
  if(isDefined(level.calculatenextspecialround)) {
    return [[level.calculatenextspecialround]]();
  }

  var_0 = level.specialroundnumber + randomintrange(4, 6);
  return var_0;
}

calculateroundtype() {
  if(isDefined(level.calculateroundtypeoverridefunc)) {
    return [[level.calculateroundtypeoverridefunc]]();
  }

  if(maps\mp\zombies\_util::isspecialround()) {
    if(isDefined(level.calculatespecialroundtypeoverride)) {
      return [[level.calculatespecialroundtypeoverride]]();
    } else {
      return calculatespecialroundtype();
    }
  }

  return "normal";
}

calculatespecialroundtype() {
  var_0 = ["zombie_dog", "zombie_host"];
  var_1 = var_0[0];

  switch (level.specialroundcounter) {
    case 1:
      var_1 = "zombie_dog";
      break;
    case 2:
      var_1 = "zombie_host";
      break;
    default:
      if(!isDefined(level.specialroundarray) || level.specialroundindex == level.specialroundarray.size) {
        level.specialroundarray = common_scripts\utility::array_randomize(var_0);
        level.specialroundindex = 0;
      }

      var_1 = level.specialroundarray[level.specialroundindex];
      level.specialroundindex++;
  }

  return var_1;
}

calculatezombiehealth(var_0) {
  var_1 = 0;

  if(isDefined(var_0.healthoverridefunc)) {
    var_1 = [[var_0.healthoverridefunc]]();
  } else {
    var_2 = 150;

    if(level.wavecounter == 1) {
      var_1 = var_2;
    } else if(level.wavecounter <= 9) {
      var_1 = var_2 + (level.wavecounter - 1) * 100;
    } else {
      var_3 = 950;
      var_4 = level.wavecounter - 9;
      var_1 = var_3 * pow(1.1, var_4);
    }
  }

  var_1 = int(var_1 * var_0.health_scale);

  if(maps\mp\zombies\_util::iszombieshardmode()) {
    var_1 = int(var_1 * 1.75);
  }

  if(isDefined(var_0.roundhealth) && var_0.roundhealth > var_1) {
    var_1 = var_0.roundhealth;
  }

  return var_1;
}

runroundstart(var_0) {
  var_1 = 0;

  if(maps\mp\zombies\_util::getzombieslevelnum() == 4 && var_0 == 1 && maps\mp\zombies\_util::iszombieshardmode()) {
    var_1 = 1;
  }

  if(var_1) {
    maps\mp\zombies\_zombies_music::changezombiemusic("round_start_hard_mode");
  } else {
    maps\mp\zombies\_zombies_music::changezombiemusic("round_start");
  }

  level notify("zombie_round_countdown_started");
  var_2 = 5;

  while(var_2 > 0) {
    while(maps\mp\zombies\_util::iszombiegamepaused()) {
      waitframe();
    }

    setomnvar("ui_zm_round_countdown", var_2);
    var_2--;
    wait 1;
  }

  setomnvar("ui_zm_round_countdown", 0);

  if(isDefined(level.roundstartfunc[level.roundtype])) {
    [[level.roundstartfunc[level.roundtype]]]();
  }

  var_3 = maps\mp\gametypes\_gamelogic::getgameduration();
  setomnvar("ui_zm_round_start", var_3 * 1000);
  setomnvar("ui_horde_round_number", var_0);
  setomnvar("ui_zm_round_type", maps\mp\zombies\_util::getroundtype(level.roundtype));
  maps\mp\zombies\_zombies_music::changezombiemusic("round_" + level.roundtype);
  level maps\mp\zombies\_util::recordmatchdataforroundstart(var_0 - 1);
}

runroundend() {
  while(maps\mp\zombies\_util::iszombiegamepaused()) {
    waitframe();
  }

  thread maps\mp\zombies\_zombies_music::changezombiemusic("round_end");
  thread maps\mp\zombies\_zombies_music::changezombiemusic("round_intermission");
  level thread revivedownedplayers();

  if(isDefined(level.roundendfunc[level.roundtype])) {
    [[level.roundendfunc[level.roundtype]]]();
  }

  maps\mp\zombies\weapons\_zombie_weapons::givegrenadesafterrounds();
  level maps\mp\zombies\_util::recordmatchdataforroundend(level.wavecounter - 1);
  wait 10;
}

revivedownedplayers() {
  foreach(var_1 in level.players) {
    if(var_1.sessionstate == "spectator" || var_1.sessionstate == "dead") {
      var_2 = "ui_zm_character_" + var_1.characterindex + "_alive";
      setomnvar(var_2, 1);
      var_1 thread maps\mp\zombies\_zombies_laststand::revivefromspectatemode();
    } else if(maps\mp\zombies\_util::isplayerinlaststand(var_1)) {
      var_1 notify("revive_trigger");
    }

    if(maps\mp\zombies\_util::isplayerinfected(var_1)) {
      var_1 notify("cured", 0);
    }
  }
}

pickupdebugprint(var_0) {
  if(!maps\mp\zombies\_util::is_true(level.pickupdebugprint)) {
    return;
  }
  var_1 = maps\mp\gametypes\_gamelogic::getgameduration();
  var_2 = var_1 - int(getomnvar("ui_zm_round_start") / 1000);
}

chancetospawnpickup(var_0, var_1, var_2, var_3) {
  if(maps\mp\zombies\_util::arepickupsdisabled()) {
    return;
  }
  if(isDefined(level.candroppickupsfunc[level.roundtype]) && ![[level.candroppickupsfunc[level.roundtype]]](var_0)) {
    var_4 = 0;

    if(!var_4) {
      return;
    }
  }

  if(level.currentpickupcount >= level.maxpickupsperround) {
    return;
  }
  if(isDefined(level.canspawnpickupoverridefunc)) {
    if(![[level.canspawnpickupoverridefunc]](var_0, var_1, var_2, var_3)) {
      return 0;
    }
  }

  if(isDefined(var_2) && var_2 == "MOD_SUICIDE") {
    return;
  }
  if(maps\mp\zombies\_util::is_true(var_1.killedbynuke)) {
    return;
  }
  if(maps\mp\zombies\_util::is_true(var_1.nopickups)) {
    return;
  }
  if(isDefined(var_3) && maps\mp\zombies\_util::istrapweapon(var_3)) {
    return;
  }
  if(isDefined(var_0) && isagent(var_0) && !isscriptedagent(var_0)) {
    return;
  }
  if(isDefined(level.nopickuppenalty) && level.nopickuppenalty == 1) {
    return;
  }
  level endon("game_ended");
  var_5 = randomint(100);
  var_6 = "none";

  if(var_5 > level.percentchancetodrop) {
    if(!level.dropscheduled) {
      return;
    }
    var_6 = "score";
  } else {
    var_6 = "random";
  }

  if(isDefined(level.zone_data) && !maps\mp\zombies\_zombies_zone_manager::iszombieinenabledzone(var_1)) {
    return;
  }
  var_7 = common_scripts\utility::ter_op(level.dropscheduled, "true ", "false ");
  var_8 = common_scripts\utility::ter_op(var_5 > level.percentchancetodrop, "false ", "true ");
  var_9 = "Scheduled: " + var_7 + "Chance: " + var_8 + "(" + var_5 + "<=" + level.percentchancetodrop + ")";
  level.dropscheduled = 0;
  var_10 = selectnextvalidpickup();
  createpickup(var_10, var_1.origin, var_9);
}

createpickuporgive(var_0, var_1, var_2) {
  if(isDefined(level.zone_data) && maps\mp\zombies\_zombies_zone_manager::ispointinanyzone(var_1 + (0, 0, 1))) {
    createpickup(var_0, var_1, var_2);
  } else {
    var_3 = common_scripts\utility::random(level.players);
    [[level.pickup[var_0]["func"]]](var_3);
  }
}

createpickup(var_0, var_1, var_2) {
  var_3 = level.pickup[var_0]["model"];
  var_4 = level.pickup[var_0]["func"];
  var_5 = level.pickup[var_0]["icon"];
  var_6 = level.pickup[var_0]["fx"];
  var_7 = level.pickup[var_0]["outline"];
  level.currentpickupcount++;
  level.pickuprecent = var_0;

  if(!isDefined(var_2)) {
    var_2 = "<undefined>";
  }

  pickupdebugprint(var_0 + " Dropped - " + var_2);
  spawnpickupmodel(var_1 + (0, 0, 22), var_3, var_5, var_6, var_4, undefined, var_7);
}

spawnpickupmodel(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7[0] = getpickupent();

  if(isDefined(var_3)) {
    var_7[0] setModel("dlc_dogtags_zombie_invisible");
  } else {
    var_7[0] setModel(var_1);
  }

  if(isDefined(var_6) && var_6) {
    var_7[0] hudoutlineenable(0, 0);
  }

  var_8 = var_7[0].trigger;
  var_9 = maps\mp\gametypes\_gameobjects::createuseobject(level.playerteam, var_8, var_7, (0, 0, 16), 1);
  var_10 = var_0;
  var_9.curorigin = var_10;
  var_9.trigger.origin = var_10;
  var_9.visuals[0].origin = var_10;

  if(isDefined(var_2) && var_2 != "") {
    var_9.icon = var_8 maps\mp\_entityheadicons::setheadicon(level.playerteam, var_2, (0, 0, 30), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
  }

  var_9 maps\mp\gametypes\_gameobjects::setusetime(0);
  var_9 maps\mp\gametypes\_gameobjects::allowuse("friendly");
  var_9.onuse = var_4;

  if(isDefined(var_5)) {
    var_9.canuseobject = var_5;
  } else {
    var_9.canuseobject = ::canactivatepickup;
  }

  if(isDefined(var_3)) {
    var_9.visuals[0] scriptmodelplayanim("mp_dogtag_spin");
    var_9.visuals[0].origin = var_10 + (0, 0, -12);
    var_9.fx = level._effect[var_3];
    var_9.fxtag = "j_dogtag";
    playFXOnTag(var_9.fx, var_9.visuals[0], var_9.fxtag);
  } else {
    var_9 thread pickupbounce();
  }

  var_9 thread pickuptimer();
}

canactivatepickup(var_0) {
  if(isDefined(var_0) && isagent(var_0)) {
    return 0;
  }

  return 1;
}

pickupbounce() {
  level endon("game_ended");
  self endon("deleted");
  self endon("death");
  var_0 = self;
  var_1 = self.curorigin;
  var_2 = self.curorigin + (0, 0, 12);
  var_3 = 1.25;

  if(isDefined(self.visuals) && isDefined(self.visuals[0])) {
    var_0 = self.visuals[0];
  }

  for(;;) {
    var_0 moveto(var_2, var_3, 0.15, 0.15);
    var_0 rotateyaw(180, var_3);
    wait(var_3);
    var_0 moveto(var_1, var_3, 0.15, 0.15);
    var_0 rotateyaw(180, var_3);
    wait(var_3);
  }
}

pickuptimer() {
  self endon("deleted");
  wait 15;
  thread pickupstartflashing();
  thread pickupexpiringsound(self.curorigin);
  wait 8;
  playsoundatpos(self.curorigin, "zmb_pickup_expired");
  level thread removepickup(self);
}

pickupexpiringsound(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playLoopSound("zmb_pickup_timer");
  self waittill("deleted");
  var_1 stoploopsound();
  waitframe();
  var_1 delete();
}

pickupstartflashing() {
  self endon("deleted");

  for(;;) {
    if(isDefined(self.fx)) {
      stopFXOnTag(self.fx, self.visuals[0], self.fxtag);
    } else if(isDefined(self.visuals) && isDefined(self.visuals[0])) {
      self.visuals[0] ghost();
    }

    wait 0.25;

    if(isDefined(self.fx)) {
      playFXOnTag(self.fx, self.visuals[0], self.fxtag);
    } else if(isDefined(self.visuals) && isDefined(self.visuals[0])) {
      self.visuals[0] show();
    }

    wait 0.25;
  }
}

removepickup(var_0) {
  if(!isDefined(var_0.visuals)) {
    return;
  }
  var_0 notify("deleted");
  var_0.visuals[0] show();
  var_0.visuals[0] ghost();

  if(isDefined(var_0.fx)) {
    stopFXOnTag(var_0.fx, var_0.visuals[0], var_0.fxtag);
  }

  var_0.trigger.origin = var_0.trigger.origin - (0, 0, -10000);
  wait 1;
  var_0.visuals[0].inuse = 0;
}

ammopickup(var_0) {
  showteamsplashzombies("zombie_max_ammo");
  var_0 playlocalsound("zmb_pickup_general");
  level thread activatemaxammo();
  maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("full_reload", var_0);
  level thread removepickup(self);
}

activatemaxammo() {
  foreach(var_1 in level.players) {
    if(maps\mp\zombies\_util::isonhumanteam(var_1) && maps\mp\_utility::isreallyalive(var_1)) {
      refillammozombies(var_1);
      var_1 playersetem1maxammo();
      var_1.health = var_1.maxhealth;

      if(isDefined(level.activatemaxammofunc)) {
        var_1[[level.activatemaxammofunc]]();
      }
    }
  }
}

refillammozombies(var_0, var_1) {
  var_2 = var_0 getweaponslistprimaries();
  var_2[var_2.size] = var_0 getlethalweapon();
  var_2[var_2.size] = var_0 gettacticalweapon();

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_4 in var_2) {
    if(var_4 == "none") {
      continue;
    }
    if(maps\mp\zombies\_util::isrippedturretweapon(var_4) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_4)) {
      continue;
    }
    if(maps\mp\zombies\_util::iszombieequipment(var_4)) {
      if(!var_1) {
        maps\mp\zombies\_wall_buys::fillweaponclip(var_0, var_4);
      } else {
        maps\mp\zombies\_wall_buys::plusoneweaponclip(var_0, var_4);
      }

      continue;
    }

    var_0 givemaxammo(var_4);

    if(issubstr(var_4, "dlcgun1")) {
      var_5 = weaponclipsize(var_4);
      var_0 setweaponammoclip(var_4, var_5, "right");
    }
  }

  if(maps\mp\zombies\_util::isplayerinlaststand(var_0)) {
    var_0 maps\mp\zombies\_zombies_laststand::refillstoredweaponammo();
  }
}

instakillpickup(var_0) {
  showteamsplashzombies("zombie_insta_kill");
  var_0 playlocalsound("zmb_pickup_overdrive");
  level thread activateinstakill();
  maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("hyper_dmg", var_0);
  level thread removepickup(self);
}

refreshmeleecharge() {
  var_0 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 maps\mp\zombies\_zombies::updatemeleechargeforcurrenthealth();
    }
  }
}

activateinstakill() {
  level notify("instaKillPickup");
  level endon("game_ended");
  level endon("instaKillPickup");
  var_0 = 30;

  if(isDefined(level.instakilltime)) {
    var_0 = level.instakilltime;
  }

  level thread setendtimeomnvarwithhostmigration("ui_zm_instakill", gettime() + var_0 * 1000);
  maps\mp\_utility::gameflagset("insta_kill");
  refreshmeleecharge();
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  maps\mp\_utility::gameflagclear("insta_kill");
  refreshmeleecharge();
}

doublepointspickup(var_0) {
  showteamsplashzombies("zombie_double_points");
  var_0 playlocalsound("zmb_pickup_general");
  level thread activatedoublepoints();
  maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("multiplier", var_0);
  level thread removepickup(self);
}

activatedoublepoints() {
  level notify("doublePointsPickup");
  level endon("game_ended");
  level endon("doublePointsPickup");
  var_0 = 30;

  if(isDefined(level.doublepointstime)) {
    var_0 = level.doublepointstime;
  }

  level thread setendtimeomnvarwithhostmigration("ui_zm_doublepoints", gettime() + var_0 * 1000);
  maps\mp\_utility::gameflagset("double_points");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  maps\mp\_utility::gameflagclear("double_points");
}

firesalepickup(var_0) {
  showteamsplashzombies("zombie_fire_sale");
  var_0 playlocalsound("zmb_pickup_general");
  level thread activatefiresale();
  maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("pow_surge", var_0);
  level thread removepickup(self);
}

activatefiresale() {
  level notify("fireSalePickup");
  level endon("game_ended");
  level endon("fireSalePickup");
  var_0 = 30;

  if(isDefined(level.firesaletime)) {
    var_0 = level.firesaletime;
  }

  level thread setendtimeomnvarwithhostmigration("ui_zm_firesale", gettime() + var_0 * 1000);

  if(!maps\mp\_utility::gameflag("fire_sale")) {
    maps\mp\_utility::gameflagset("fire_sale");

    foreach(var_2 in level.magicboxlocations) {
      level thread turnonfiresalemachine(var_2);
    }
  }

  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  maps\mp\_utility::gameflagclear("fire_sale");

  foreach(var_2 in level.magicboxlocations) {
    level thread turnofffiresalemachine(var_2);
  }
}

turnonfiresalemachine(var_0) {
  while(var_0.isdispensingweapon) {
    wait 0.05;
  }

  var_0 sethintstring(&"ZOMBIES_FIRE_SALE_MAGIC_BOX");
  var_0 setsecondaryhintstring(var_0 maps\mp\zombies\_wall_buys::getmagicboxhintstringcost());
  var_0 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_0.cost));
  var_0 maps\mp\zombies\_util::tokenhintstring(1);

  if(!var_0.active) {
    var_0 maps\mp\zombies\_wall_buys::activatemagicboxeffects(var_0.modelent, var_0.light);
    level thread maps\mp\zombies\_wall_buys::watchmagicboxtrigger(var_0, 1);
  } else if(var_0.ismoving) {
    while(var_0.ismoving) {
      wait 0.05;
    }

    var_0 maps\mp\zombies\_wall_buys::activatemagicboxeffects(var_0.modelent, var_0.light);
    level thread maps\mp\zombies\_wall_buys::watchmagicboxtrigger(var_0, 1);
  }
}

turnofffiresalemachine(var_0) {
  while(var_0.isdispensingweapon) {
    wait 0.05;
  }

  if(!var_0.active) {
    var_0 sethintstring(maps\mp\zombies\_wall_buys::getmagicboxhintsting(1));
    var_0 setsecondaryhintstring(maps\mp\zombies\_wall_buys::getmagicboxhintstringcost(1));
    var_0 maps\mp\zombies\_util::tokenhintstring(0);
    var_0 maps\mp\zombies\_wall_buys::deactivatemagicboxeffects(var_0.modelent, var_0.light);
    var_0 notify("fireSaleOver");
  } else {
    var_0 sethintstring(maps\mp\zombies\_wall_buys::getmagicboxhintsting());
    var_0 setsecondaryhintstring(maps\mp\zombies\_wall_buys::getmagicboxhintstringcost());
    var_0 setsecondaryhintstring(var_0 maps\mp\zombies\_wall_buys::getmagicboxhintstringcost());
    var_0 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_0.cost));
    var_0 maps\mp\zombies\_util::tokenhintstring(1);
  }
}

trappickup(var_0) {
  showteamsplashzombies("zombie_activate_traps");
  var_0 playsoundtoteam("zmb_pickup_traps", "allies");
  level thread activatetrappickup(var_0);
  maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("security", var_0);
  level thread removepickup(self);
}

activatetrappickup(var_0) {
  var_1 = maps\mp\zombies\_traps::get_trap_time();
  level thread setendtimeomnvarwithhostmigration("ui_zm_alltraps", gettime() + var_1 * 1000);

  foreach(var_3 in level.traps) {
    var_3 maps\mp\zombies\_traps::trap_activate(var_0, 1);
  }

  foreach(var_6 in level.zombiedoors) {
    var_6 notify("trap_trigger", var_0, var_1);
  }
}

nukepickup(var_0) {
  showteamsplashzombies("zombie_nuke");
  var_0 playlocalsound("zmb_pickup_apocalypse");
  earthquake(0.35, 0.95, var_0.origin, 128);
  playFX(common_scripts\utility::getfx("nuke_blast"), var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  level thread activatenukepickup(var_0.origin);
  maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("dna_bomb", var_0);
  level thread removepickup(self);
}

activatenukepickup(var_0) {
  foreach(var_2 in level.players) {
    var_2 givepointsforevent("nuke");
  }

  var_4 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
  var_4 = sortbydistance(var_4, var_0);

  foreach(var_6 in var_4) {
    if(var_6.agentteam == level.playerteam) {
      continue;
    }
    if(var_6 maps\mp\zombies\_util::instakillimmune()) {
      continue;
    }
    wait 0.1;

    if(isalive(var_6)) {
      var_7 = "MOD_EXPLOSIVE";

      if(!isscriptedagent(var_6)) {
        var_7 = "MOD_ENERGY";
      }

      var_6.killedbynuke = 1;
      var_6 dodamage(var_6.health, var_6.origin, undefined, undefined, var_7, level.ocp_weap_name);
    }
  }
}

showteamsplashzombies(var_0) {
  foreach(var_2 in level.players) {
    if(maps\mp\zombies\_util::isonhumanteam(var_2) && maps\mp\_utility::isreallyalive(var_2)) {
      var_2 thread maps\mp\gametypes\_hud_message::splashnotify(var_0);
    }
  }
}

zombievignette() {
  if(isDefined(level.zombievignette)) {
    var_0 = newhudelem();
    var_0.x = 0;
    var_0.y = 0;
    var_0.alpha = 1.0;
    var_0.horzalign = "fullscreen";
    var_0.vertalign = "fullscreen";
    var_0.sort = 3;
    var_0 setshader(level.zombievignette, 640, 480);
  }
}

playermonitorweapon() {
  self endon("disconnect");
  self setclientomnvar("ui_energy_ammo", 1);

  for(;;) {
    self waittill("weapon_change", var_0);
    waitframe();
    thread playerdoem1logic(var_0);
  }
}

playerdoem1logic(var_0) {
  self endon("disconnect");

  if(!issubstr(var_0, "iw5_em1zm_mp")) {
    if(maps\mp\zombies\_util::playerhasem1ammoinfo() && maps\mp\zombies\_util::playergetem1ammo() <= 0 && !playerhasem1() && !maps\mp\zombies\_util::isplayerinlaststand(self)) {
      maps\mp\zombies\_util::playerclearem1ammoinfo();
    }

    return;
  }

  playersetem1ammo();
  self setweaponammostock(var_0, 0);
  thread playersetupem1ammo();
  self waittill("weapon_change");
  maps\mp\zombies\_util::playerallowfire(1, "em1");
  self notifyonplayercommandremove("fire_em1_weapon", "+attack");
  self notifyonplayercommandremove("fire_em1_weapon", "+attack_akimbo_accessible");
}

playerhasem1() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "iw5_em1zm_mp")) {
      return 1;
    }
  }

  return 0;
}

playerupdateem1omnvar() {
  var_0 = getem1maxammo(1);
  var_1 = maps\mp\zombies\_util::playergetem1ammo();
  var_2 = var_1 / var_0;
  self setclientomnvar("ui_energy_ammo", var_2);
}

playersetupem1ammo() {
  self endon("death");
  self endon("disconnect");
  self endon("weapon_change");
  self notifyonplayercommand("fire_em1_weapon", "+attack");
  self notifyonplayercommand("fire_em1_weapon", "+attack_akimbo_accessible");
  var_0 = maps\mp\zombies\_util::playergetem1ammo();
  playerupdateem1omnvar();

  if(var_0 <= 0) {
    maps\mp\zombies\_util::playerallowfire(0, "em1");
  }

  for(;;) {
    if(!self attackButtonPressed()) {
      self waittill("fire_em1_weapon");
    }

    var_1 = self getcurrentweapon();

    if(self isreloading() || !issubstr(var_1, "iw5_em1zm_mp") || !self isfiring() || self isusingoffhand()) {
      waitframe();
      continue;
    }

    var_0 = maps\mp\zombies\_util::playergetem1ammo();
    playerupdateem1omnvar();

    if(var_0 <= 0) {
      var_2 = self getweaponslistprimaries();
      var_3 = maps\mp\_utility::getbaseweaponname(var_2[0]);

      if(var_3 != "iw5_em1zm") {
        maps\mp\zombies\_util::playerallowfire(0, "em1");
        self switchtoweapon(var_2[0]);
        waitframe();
        continue;
      }

      if(var_2.size > 1) {
        var_3 = maps\mp\_utility::getbaseweaponname(var_2[1]);

        if(var_3 != "iw5_em1zm") {
          self switchtoweapon(var_2[1]);
          maps\mp\zombies\_util::playerallowfire(0, "em1");
          waitframe();
          continue;
        }
      }

      maps\mp\zombies\_util::playerallowfire(0, "em1");
      waitframe();
      continue;
    }

    waitframe();

    if(maps\mp\zombies\_util::gameflagexists("unlimited_ammo") && maps\mp\_utility::gameflag("unlimited_ammo")) {
      continue;
    }
    var_0 = maps\mp\zombies\_util::playergetem1ammo();
    maps\mp\zombies\_util::playerrecordem1ammo(var_0 - 1);
  }
}

playersetem1ammo() {
  if(!isDefined(self.pers["em1Ammo"])) {
    self.pers["em1Ammo"] = spawnStruct();
    playersetem1maxammo();
    maps\mp\zombies\_util::playerallowfire(1, "em1");
  }
}

getem1maxammo(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = 1.0;

  if(!var_0 && self hasperk("specialty_stockpile", 1)) {
    var_1 = var_1 * 1.2;
  }

  return 1800.0 * var_1;
}

playersetem1maxammo() {
  if(isDefined(self.pers["em1Ammo"])) {
    var_0 = getem1maxammo();
    self.pers["em1Ammo"].ammo = var_0;
    playerupdateem1omnvar();
    maps\mp\zombies\_util::playerallowfire(1, "em1");
  }
}

playerpostslam_deathwaiter(var_0) {
  self notify("postSlamDeathWaiter");
  self endon("postSlamDeathWaiter");
  self endon("postSlamTimedOut");
  self waittill("death");
  playerpostslam_reenableboost(var_0);
}

playerpostslam_reenableboost(var_0) {
  maps\mp\gametypes\_scrambler::playersethudempscrambledoff(var_0);
  maps\mp\_utility::playerallowhighjump(1, "postSlam");
  maps\mp\_utility::playerallowhighjumpdrop(1, "postSlam");
  maps\mp\_utility::playerallowboostjump(1, "postSlam");
  maps\mp\_utility::playerallowpowerslide(1, "postSlam");
  maps\mp\_utility::playerallowdodge(1, "postSlam");
}

playerpostslam_disableboost() {
  self notify("postSlamDisableBoost");
  self endon("postSlamDisableBoost");
  self endon("death");
  self endon("disconnect");
  var_0 = 2;
  var_1 = gettime() + var_0 * 1000;
  var_2 = maps\mp\gametypes\_scrambler::playersethudempscrambled(var_1, 1, "postSlam");
  maps\mp\_utility::playerallowhighjump(0, "postSlam");
  maps\mp\_utility::playerallowhighjumpdrop(0, "postSlam");
  maps\mp\_utility::playerallowboostjump(0, "postSlam");
  maps\mp\_utility::playerallowpowerslide(0, "postSlam");
  maps\mp\_utility::playerallowdodge(0, "postSlam");
  thread playerpostslam_deathwaiter(var_2);
  wait(var_0);
  self notify("postSlamTimedOut");
  playerpostslam_reenableboost(var_2);
}

playermonitorboostevents() {
  self endon("disconnect");
  self.exoeventtime = 0;
  self.exoboosttime = 0;
  self.exoslamtime = 0;
  self.exododgetime = 0;
  self.exoslidetime = 0;

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return_no_endon_death("exo_boost", "ground_slam", "exo_dodge", "exo_slide");
    self.exoeventtime = gettime();

    switch (var_0) {
      case "exo_boost":
        self.exoboosttime = gettime();
        break;
      case "ground_slam":
        self.exoslamtime = gettime();
        break;
      case "exo_dodge":
        self.exododgetime = gettime();
        break;
      case "exo_slide":
        self.exoslidetime = gettime();
        break;
    }
  }
}

giveplayerszombieachievement(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2.joinedround1) || !var_2.joinedround1) {
      continue;
    }
    var_2 givezombieachievement(var_0);
  }
}

givezombieachievement(var_0) {
  var_1 = maps\mp\_utility::getmapname();

  switch (var_1) {
    case "mp_zombie_lab":
      if(!issubstr(var_0, "DLC1")) {
        return;
      }
      break;
    case "mp_zombie_brg":
      if(!issubstr(var_0, "DLC2")) {
        return;
      }
      break;
    case "mp_zombie_ark":
      if(!issubstr(var_0, "DLC3")) {
        return;
      }
      break;
    case "mp_zombie_h2o":
      if(!issubstr(var_0, "DLC4")) {
        return;
      }
      break;
  }

  self giveachievement(var_0);
}

setendtimeomnvarwithhostmigration(var_0, var_1) {
  level endon("game_ended");
  level notify(var_0 + "_cancel");
  level endon(var_0 + "_cancel");

  for(;;) {
    setomnvar(var_0, var_1);
    level common_scripts\utility::waittill_notify_or_timeout("host_migration_begin", (var_1 - gettime()) / 1000.0);
    setomnvar(var_0, 0);

    if(gettime() >= var_1) {
      break;
    }

    var_2 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    var_1 = var_1 + var_2;

    if(gettime() >= var_1) {
      break;
    }
  }
}

hurtplayersthink() {
  level endon("game_ended");
  wait(randomfloat(1.0));

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self) && maps\mp\_utility::isreallyalive(var_1)) {
        var_2 = "ui_zm_character_" + var_1.characterindex + "_alive";
        setomnvar(var_2, 0);
        var_1 maps\mp\_utility::_suicide();
      }
    }

    wait 0.5;
  }
}

moversuicidecustom() {
  var_0 = "ui_zm_character_" + self.characterindex + "_alive";
  setomnvar(var_0, 0);
  maps\mp\_utility::_suicide();

  if(level.players.size < 2) {
    maps\mp\zombies\_zombies_laststand::zombieendgame(undefined, "MOD_SUICIDE");
  }
}

getroundintermissionduration() {
  return 10;
}