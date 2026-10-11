/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_gametype_truckwar.gsc
************************************************************/

#using script_21c19cfc7139d773;
#using script_2d9d24f7c63ac143;
#using script_4cdabcd91a92977;
#using script_5bab271917698dc4;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\deathicons;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_gametype_truckwar;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\spectating;
#using scripts\mp\supers;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace br_gametype_truckwar;

function main() {
  level.var_cdc15ee14362fbf = &scripts\mp\gametypes\br_gametype_truckwar::init;
  scripts\mp\gametypes\br::main();
}

function init() {
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh9_mil_lnd_mrap");
  level thread brtruck_initfeatures();
  level thread brtruck_initpostmain();
  level thread brtruck_initdialog();
  level thread brtruck_initexternalfeatures();
  level.respawntimedisable = getdvarint(@ "hash_e12689cc1f69a798", 0);
  level.var_4b3d0771df2c44a9 = 0;
  level.var_45496c9df00f2bd4 = 1;
  level.var_af6ec941d2b4e283 = getdvarint(@ "hash_fad98da2f37e7fcf", 1) == 1;
  level.var_e12122c5431959b5 = getdvarint(@ "hash_bc6debd70e4d4f9", 1) == 1;
  level.var_944b40a215902330 = 15;
  sizeoverride = getDvar(@ "hash_8fa9e9db3f08ed0c", "80000 50000 40000 30000 20000 15000 10000 0");

  if(sizeoverride != "") {
    level.var_5a41c5287237c308 = [];
    sizesstr = strtok(sizeoverride, " ");

    foreach(size in sizesstr) {
      level.var_5a41c5287237c308[level.var_5a41c5287237c308.size] = float(size);
    }
  }

  closetimeoverride = getDvar(@ "hash_a957db23ca8fab2a", "330 120 100 90 80 70 60 50");

  if(closetimeoverride != "") {
    level.var_3d86f613dc0bfa16 = [];
    closetimestr = strtok(closetimeoverride, " ");

    foreach(size in closetimestr) {
      level.var_3d86f613dc0bfa16[level.var_3d86f613dc0bfa16.size] = float(size);
    }
  }

  delaytimeoverride = getDvar(@ "hash_61ae4ac51ff20d99", "120 120 90 75 60 45 30 20");

  if(delaytimeoverride != "") {
    level.var_dc008290077a7185 = [];
    delaytimestr = strtok(delaytimeoverride, " ");

    foreach(size in delaytimestr) {
      level.var_dc008290077a7185[level.var_dc008290077a7185.size] = float(size);
    }
  }

  level.var_59ff09549058dda2 = 1;
  level.var_5431e3914cfc0e23 = 1;
  level.var_a9ccaf325f3a76d = getdvarint(@ "hash_e1a4b7a04f5a3725", 1) == 1;
  level.var_a02389e5d5497129 = getdvarfloat(@ "hash_952460a08702c65", 50000);
  level.var_8fc109df2d334cda = getdvarfloat(@ "hash_6940ee2d192ff206", 40000);
  level.var_463aba47317cacc2 = getdvarfloat(@ "hash_4b8f9a9113c965f6", 10000);
  level.var_886566e69ee53d98 = getdvarfloat(@ "hash_c06d40315e54bc8c", 30);
  level.var_e182232b582aa5d6 = getdvarfloat(@ "hash_85028cd7a792b52", 220);
  level.var_411ce67dc4849722 = getdvarfloat(@ "hash_c9183f48bb5dc926", 40);
  level.var_f28e1ed7f6adf52d = getdvarfloat(@ "hash_3863b34660bf0d09", 60);
  level.var_84f1c23ed82e4ec5 = getdvarfloat(@ "hash_b7628db816399549", 10);
  level.var_4d77d157099cf459 = getdvarfloat(@ "hash_941583466b9ccb2d", 10);
  level.var_be52f2d0dee6b894 = getdvarint(@ "hash_d4939fdb84b794f0", 1);
  level.var_15415172069d735f = getdvarfloat(@ "hash_620ba5611e3d420b", 120);
  level.var_837cd01dc6486d8c = getdvarfloat(@ "hash_92b3c04bd3014008", 330);
  level.var_6d02a364e8331928 = getdvarfloat(@ "hash_f56e42c98f9f52bc", 1);

  if(level.var_af6ec941d2b4e283) {
    setDvar(@ "hash_39a8907d7f184021", 1);
    level.br_circle_init_func = &alternatebrcircle;
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("tag_buystation", &function_fe081d074870c23d);
  level init_airdrop_anims();
  level thread function_a614e0fee13eca53();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnectcallback);

  setdevdvarifuninitialized(@ "hash_32b7f75982043672", 0);
  level thread watchspawninput();
}

function brtruck_initfeatures() {
  if(getdvarint(@ "hash_32b7f75982043672", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::disablefeature("circle");
    scripts\mp\gametypes\br_gametypes::disablefeature("dropbag");
    scripts\mp\gametypes\br_gametypes::enablefeature("allowLateJoiners");
  }

  scripts\mp\gametypes\br_gametypes::disablefeature("gulag");
  scripts\mp\gametypes\br_gametypes::disablefeature("plunderSites");
  scripts\mp\gametypes\br_gametypes::disablefeature("vehicleSpawns");
  scripts\mp\gametypes\br_gametypes::disablefeature("c130PlaneLine");
  scripts\mp\gametypes\br_gametypes::enablefeature("tabletReplace");
}

function brtruck_initpostmain() {
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerWelcomeSplashes", &brtruck_playerwelcomesplashes);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onStartGameType", &onstartgametype);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerKilledSpawn", &playerkilledspawn);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("markPlayerAsEliminatedOnKilled", &markplayeraseliminatedonkilled);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("mayConsiderPlayerDead", &mayconsiderplayerdead);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("isTeamEliminated", &isteameliminated);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("infilSequence", &function_73bdf8b18e29b13f);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerNakedDropLoadout", &function_8d45ff943de1cfc4);
  waittillframeend();
  function_a5e20d193142774d();

  if(!isDefined(level.br_badcircleareas)) {
    level.br_badcircleareas = [];
  }

  if(issubstr(level.mapname, "saba")) {
    level.br_badcircleareas[level.br_badcircleareas.size] = scripts\mp\gametypes\br_circle::createinvalidcirclearea((67000, -40000, 0), 30000);
    level.br_badcircleareas[level.br_badcircleareas.size] = scripts\mp\gametypes\br_circle::createinvalidcirclearea((-3500, -47300, 0), 20000);
    level.br_badcircleareas[level.br_badcircleareas.size] = scripts\mp\gametypes\br_circle::createinvalidcirclearea((-42000, -64500, 0), 20000);
    level.br_badcircleareas[level.br_badcircleareas.size] = scripts\mp\gametypes\br_circle::createinvalidcirclearea((-39500, -31000, 0), 22000);
    level.br_badcircleareas[level.br_badcircleareas.size] = scripts\mp\gametypes\br_circle::createinvalidcirclearea((-49000, -8200, 0), 21000);
  }

  scripts\mp\flags::gameflaginit("use_truck_respawn", 0);
  level.ontimelimit = &brtruck_ontimelimit;
  level.modeplayerkilledspawn = &playerkilledspawn;
  brtruck_cleanupents();
  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
  level.startjuggdelivery = 0;

  if(!isDefined(level.var_c7b9749bcc6a6207)) {
    level.var_c7b9749bcc6a6207 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("veh9_mil_lnd_mrap").maxfuel;
  }

  if(level.var_af6ec941d2b4e283) {
    level thread function_d4864f0577158363();
  }
}

function function_a5e20d193142774d() {
  function_70da934903ac5a5d("classtable:classtable_br_resurgence");
  function_70da934903ac5a5d("classtable:classtable_br_resurgence_circle2");
  function_70da934903ac5a5d("classtable:classtable_br_resurgence_circle3");
}

function function_70da934903ac5a5d(table) {
  if(!isDefined(level.var_c04b5edf3f9ea340)) {
    level.var_c04b5edf3f9ea340 = [];
  }

  newloadoutindex = level.var_c04b5edf3f9ea340.size;
  var_7d958726e11b327 = scripts\mp\class::function_df2933f96d726d71(table);
  level.var_c04b5edf3f9ea340[newloadoutindex] = [];

  for(classindex = 0; classindex < var_7d958726e11b327; classindex++) {
    level.var_c04b5edf3f9ea340[newloadoutindex][level.var_c04b5edf3f9ea340[newloadoutindex].size] = function_a89b0ef8d36b3436(classindex, table);
  }

  level.var_77c121d31e587ba8 = [];

  foreach(circleindex, circleloadout in level.var_c04b5edf3f9ea340) {
    if(isDefined(level.var_c04b5edf3f9ea340[circleindex]) && level.var_c04b5edf3f9ea340[circleindex].size > 0) {
      level.var_77c121d31e587ba8[circleindex] = randomintrange(0, level.var_c04b5edf3f9ea340[circleindex].size);
    }
  }
}

function function_a89b0ef8d36b3436(classindex, table) {
  var_cfa6985254954fb3 = scripts\mp\class::function_c7a0b640c398497(table, classindex);
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = var_cfa6985254954fb3.primaryweapon.weapon;
  loadout["loadoutPrimaryAttachment"] = var_cfa6985254954fb3.primaryweapon.attachment1;
  loadout["loadoutPrimaryAttachment2"] = var_cfa6985254954fb3.primaryweapon.attachment2;
  loadout["loadoutPrimaryAttachment3"] = var_cfa6985254954fb3.primaryweapon.attachment3;
  loadout["loadoutPrimaryAttachment4"] = var_cfa6985254954fb3.primaryweapon.attachment4;
  loadout["loadoutPrimaryAttachment5"] = var_cfa6985254954fb3.primaryweapon.attachment5;
  loadout["loadoutPrimaryCamo"] = var_cfa6985254954fb3.primaryweapon.camo;
  loadout["loadoutPrimaryReticle"] = var_cfa6985254954fb3.primaryweapon.reticle;
  loadout["loadoutSecondary"] = var_cfa6985254954fb3.secondaryweapon.weapon;
  loadout["loadoutSecondaryAttachment"] = var_cfa6985254954fb3.secondaryweapon.attachment1;
  loadout["loadoutSecondaryAttachment2"] = var_cfa6985254954fb3.secondaryweapon.attachment2;
  loadout["loadoutSecondaryAttachment3"] = var_cfa6985254954fb3.secondaryweapon.attachment3;
  loadout["loadoutSecondaryAttachment4"] = var_cfa6985254954fb3.secondaryweapon.attachment4;
  loadout["loadoutSecondaryAttachment5"] = var_cfa6985254954fb3.secondaryweapon.attachment5;
  loadout["loadoutSecondaryCamo"] = var_cfa6985254954fb3.secondaryweapon.camo;
  loadout["loadoutSecondaryReticle"] = var_cfa6985254954fb3.secondaryweapon.reticle;
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = var_cfa6985254954fb3.equipment.primary;
  loadout["loadoutEquipmentSecondary"] = var_cfa6985254954fb3.equipment.secondary;
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = [var_cfa6985254954fb3.perks.perk1, var_cfa6985254954fb3.perks.perk2, var_cfa6985254954fb3.perks.perk3, var_cfa6985254954fb3.extraperks.perk1, var_cfa6985254954fb3.extraperks.perk2, var_cfa6985254954fb3.extraperks.perk3];
  loadout["loadoutGesture"] = "playerData";
  loadout["tableColumn"] = classindex;
  return loadout;
}

function brtruck_initdialog() {
  level endon("game_ended");
  game["dialog"]["match_start"] = "trkw_wzan_mdnt";
  game["dialog"]["primary_objective"] = "trkw_wzan_mdbs";
  game["dialog"]["vehicle_spawn_enabled"] = "trkw_wzan_vsnb";
  game["dialog"]["vehicle_spawn_disabled"] = "trkw_wzan_vsds";
  game["dialog"]["vehicle_under_attack"] = "trkw_wzan_vndt";
  game["dialog"]["vehicle_destroyed"] = "trkw_wzan_vhcd";
  game["dialog"]["vehicle_spawn_over"] = "trkw_wzan_vsvr";
  game["dialog"]["armor_upgraded"] = "trkw_wzan_armr";
  game["dialog"]["trophy_activated"] = "trkw_wzan_trph";
  game["dialog"]["uav_activated"] = "trkw_wzan_uav0";
  game["dialog"]["barrel_activated"] = "trkw_wzan_brrl";
  game["dialog"]["grenade_turret_activated"] = "trkw_wzan_trrt";
  game["dialog"]["engine_activated"] = "trkw_wzan_engn";
  game["dialog"]["smoke_activated"] = "trkw_wzan_smke";
  game["dialog"]["reminder_purchase"] = "trkw_wzan_rmdp";
  game["dialog"]["resurgence_on_player_disconnect"] = "rsrg_grav_tmrd";
}

function brtruck_cleanupents() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
}

function brtruck_initexternalfeatures() {
  level._effect["light_tank_land"] = loadfx("vfx/iw8_mp/killstreak/vfx_tank_dropoff_dust.vfx");
}

function onstartgametype() {
  initspawns();
  level thread initvehicles();
  level thread function_8d947898c35b8068();
  level thread function_6e7b6151aba26dc2();
}

function brtruck_playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");

  if(!istrue(self.pers["streamSyncComplete"])) {
    self waittill("player_active");
  }

  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_truckwar_prematch_welcome");
  self waittill("do_welcome_splashes");
  wait 2;
  soundalias = scripts\mp\gametypes\br_public::function_93550b34f0a49dd9("match_start", self, "dx_br_bds5_");
  soundlength = undefined;

  if(isDefined(soundalias) && soundexists(soundalias)) {
    soundlength = lookupsoundlength(soundalias) * 0.001 + 2;
  }

  thread function_9f5606e3bd1c508d("match_start", [self]);
  thread function_9f5606e3bd1c508d("primary_objective", [self], soundlength);
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("truckwar_welcome", [self]);
}

function brtruck_ontimelimit() {
  if(isDefined(level.numendgame)) {
    level thread scripts\mp\gametypes\br::startendgame(1);
  }

  level.numendgame = undefined;
}

function mayconsiderplayerdead(player) {
  return true;
}

function markplayeraseliminatedonkilled() {
  return true;
}

function vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;
  return spawndata;
}

function registervehicletype(refname, spawnvehiclecallback) {
  assert(isDefined(refname));
  vehicleinfo = spawnStruct();
  vehicleinfo.refname = refname;
  vehicleinfo.spawncallback = spawnvehiclecallback;
  vehicleinfo.vehiclespawns = scripts\cp_mp\vehicles\vehicle_spawn::function_b08e7e3a0b14f76f(refname);
  assert(isDefined(vehicleinfo.vehiclespawns));
  level.vehicleinfo[refname] = vehicleinfo;
}

function function_5c3211a52b3b56f9(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  spawndata.var_427538f5a2ad4f8b = 1;
  spawndata.var_ec76ffdbe2f37c5b = 1;
  spawndata.var_65da0a245b653cc = 1;
  spawndata.var_d04816fe2f5bcee6 = 1;
  mrap = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_lnd_mrap", spawndata, faildata);
  mrap setscriptablepartstate("tag_buystation", "buystation_usable");
  return mrap;
}

function vehiclespawn_littlebird(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata, faildata);
}

function vehiclespawn_atv(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", spawndata, faildata);
}

function vehiclespawn_tacrover(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("tac_rover", spawndata, faildata);
}

function function_c43c5200d882b134(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_utv", spawndata, faildata);
}

function function_c6436c7f3e995d85(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_hummer", spawndata, faildata);
}

function function_9d7d93def34d9958(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_overland_2016", spawndata, faildata);
}

function function_292bae242d3583b7(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_civ_lnd_dirt_bike", spawndata, faildata);
}

function initvehicles() {
  if(!isDefined(level.vehicleinfo)) {
    level.vehicleinfo = [];
  }

  if(getdvarint(hashcat(@ "hash_e4fa5e1677f011e4", "veh9_mil_lnd_mrap"), 1) == 1) {
    registervehicletype("veh9_mil_lnd_mrap", &function_5c3211a52b3b56f9);
  }

  if(getdvarint(hashcat(@ "hash_e4fa5e1677f011e4", "little_bird"), 1) == 1) {
    registervehicletype("little_bird", &vehiclespawn_littlebird);
  }

  if(getdvarint(hashcat(@ "hash_e4fa5e1677f011e4", "atv"), 1) == 1) {
    registervehicletype("atv", &vehiclespawn_atv);
  }

  if(getdvarint(hashcat(@ "hash_e4fa5e1677f011e4", "tac_rover"), 1) == 1) {
    registervehicletype("tac_rover", &vehiclespawn_tacrover);
  }

  if(getdvarint(hashcat(@ "hash_e4fa5e1677f011e4", "veh9_utv"), 1) == 1) {
    registervehicletype("veh9_utv", &function_c43c5200d882b134);
  }

  if(getdvarint(hashcat(@ "hash_e4fa5e1677f011e4", "veh9_hummer"), 1) == 1) {
    registervehicletype("veh9_hummer", &function_c6436c7f3e995d85);
  }

  if(getdvarint(hashcat(@ "hash_e4fa5e1677f011e4", "veh9_overland_2016"), 1) == 1) {
    registervehicletype("veh9_overland_2016", &function_9d7d93def34d9958);
  }

  if(getdvarint(hashcat(@ "hash_e4fa5e1677f011e4", "veh9_civ_lnd_dirt_bike"), 1) == 1) {
    registervehicletype("veh9_civ_lnd_dirt_bike", &function_292bae242d3583b7);
  }

  level waittill("prematch_fade_done");
  wait 2;

  level thread function_6de134dad6c879cf();
}

function function_9e97f797dc8e211c() {
  level.vehiclespawnlocs = [];
  level.var_8d137603bd840e40 = [];

  foreach(vehicleinfo in level.vehicleinfo) {
    switch (vehicleinfo.refname) {
      case #"hash_9396a18356201b4a":
        vehicleinfo.vehiclespawns = gettruckspawns("veh9_mil_lnd_mrap");
        break;
    }

    foreach(spawnpoint in vehicleinfo.vehiclespawns) {
      index = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[index] = spawnpoint;
      level.vehiclespawnlocs[index].refname = vehicleinfo.refname;
    }
  }

  if(false) {
    foreach(loc in level.vehiclespawnlocs) {
      if(loc.refname != "veh9_mil_lnd_mrap") {
        continue;
      }

      thread drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));
      thread drawangles(loc.origin, loc.angles, 1000, 100);
    }
  }

  level.vehiclespawnlocs = array_randomize(level.vehiclespawnlocs);

  if(false) {
    for(i = 0; i < level.vehiclespawnlocs.size; i++) {
      loc = level.vehiclespawnlocs[i];

      if(loc.refname != "veh9_mil_lnd_mrap") {
        continue;
      }

      thread drawline(loc.origin + (0, 0, 1500), loc.origin + (0, 0, 2500), 1000, (0, 1, 0));
      thread drawangles(loc.origin, loc.angles, 1000, 100);
    }
  }

  iter = 0;

  foreach(entry in level.teamnamelist) {
    if(getteamdata(entry, "players").size == 0) {
      continue;
    }

    while(iter < level.vehiclespawnlocs.size) {
      loc = level.vehiclespawnlocs[iter];

      if(isDefined(loc)) {
        if(loc.refname == "veh9_mil_lnd_mrap") {
          level.var_8d137603bd840e40[entry] = loc;
          iter++;
          break;
        }
      }

      iter++;
    }
  }

  scripts\mp\flags::gameflagset("trucks_spawn_complete");
}

function spawnvehicles() {
  vehicles = [];

  foreach(loc in level.var_8d137603bd840e40) {
    vehicleinfo = level.vehicleinfo[loc.refname];
    vehicle = [[vehicleinfo.spawncallback]](loc);
    vehicles[vehicles.size] = vehicle;
  }

  level.teamvehicles = vehicles;
  maxvehiclecount = getdvarint(@ "hash_58c9645bc2b9d636", 120);
  remainingspawncount = maxvehiclecount - vehicles.size;

  for(index = 0; index < level.vehiclespawnlocs.size && remainingspawncount > 0; index++) {
    loc = level.vehiclespawnlocs[index];

    if(isDefined(loc)) {
      if(loc.refname != "veh9_mil_lnd_mrap") {
        vehicleinfo = level.vehicleinfo[loc.refname];
        vehicle = [[vehicleinfo.spawncallback]](loc);
        remainingspawncount--;
      }
    }
  }
}

function assignvehiclestoteams() {
  vehicles = level.teamvehicles;
  level.teamvehicles = [];
  level.teamcanrespawn = [];
  level.var_e3ccf0898a949bec = [];
  index = 0;

  foreach(entry in level.teamnamelist) {
    if(getteamdata(entry, "players").size == 0) {
      continue;
    }

    vehicle = vehicles[index];
    function_20b77fbf1af1a5d(vehicle, entry);
    index++;
  }
}

function function_20b77fbf1af1a5d(vehicle, team, revive) {
  if(!isDefined(team)) {
    return;
  }

  level.teamvehicles[team] = vehicle;
  level.teamcanrespawn[team] = 1;
  setomnvar("ui_truckwar_trucks_remaining", level.teamvehicles.size);
  level thread watchvehicleingas(vehicle, team);
  level thread function_66e49bf742fccb61(vehicle, team);
  level thread function_3e5a0635a240ede5(vehicle, team);
  level thread notifyteamonvehicledeath(vehicle, team);
  level thread function_46ed8b0b237087f8(vehicle, team);
  level thread function_ad382245d8d861f3(vehicle, team);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, team);
  vehicle setscriptablepartstate("objective", "on");
  players = getteamdata(team, "players");

  foreach(player in players) {
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", vehicle.health);
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", vehicle.maxhealth);

    if(istrue(revive) && getdvarint(@ "hash_51df9c2ca5ee638", 1) == 1 && !istrue(level.var_24380db31e302a78)) {
      if(istrue(player.br_iseliminated)) {
        player.setspawnpoint = undefined;
        player thread playerrespawn(1);
      }
    }
  }

  function_5fd118f91ae96e57(vehicle);
  function_256806bcfdf38c83(team);
}

function watchvehicleingas(vehicle, team) {
  vehicle endon("death");
  level endon("game_ended");
  vehicle.var_a8c0f140c771864f = 0;
  vehicle.var_8636e467ba2ce9a = 0;
  vehicle.var_5d74ae3615ff1bba = 0;
  var_42eec56be1c18a86 = getdvarfloat(@ "hash_6e9602adcd53f742", 15);
  var_57d36501a55eb4d9 = getdvarfloat(@ "hash_88fad367b10fc4cd", 30);
  var_18dfc5318aa3c007 = getdvarfloat(@ "hash_593518c70a322693", 45);
  players = getteamdata(team, "players");

  foreach(player in players) {
    player ent_flag_init("respawn_vehicle_in_gas");
  }

  while(isDefined(vehicle)) {
    if(istrue(vehicle.infilling)) {
      waitframe();
      continue;
    }

    if(istrue(level.circleclosing)) {
      if(!vehicle.var_a8c0f140c771864f && checkdangerradius(vehicle.origin, var_42eec56be1c18a86)) {
        showsplashtoteam(team, "truckwar_gas_close");
        vehicle.var_a8c0f140c771864f = 1;
        vehicle.var_8636e467ba2ce9a = 1;
        vehicle.var_5d74ae3615ff1bba = 1;
      } else if(!vehicle.var_8636e467ba2ce9a && checkdangerradius(vehicle.origin, var_57d36501a55eb4d9)) {
        showsplashtoteam(team, "truckwar_gas_medium");
        vehicle.var_8636e467ba2ce9a = 1;
        vehicle.var_5d74ae3615ff1bba = 1;
      } else if(!vehicle.var_5d74ae3615ff1bba && checkdangerradius(vehicle.origin, var_18dfc5318aa3c007)) {
        showsplashtoteam(team, "truckwar_gas_far");
        vehicle.var_5d74ae3615ff1bba = 1;
      }
    } else {
      vehicle.var_a8c0f140c771864f = 0;
      vehicle.var_8636e467ba2ce9a = 0;
      vehicle.var_5d74ae3615ff1bba = 0;
    }

    dangercircleorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    dangercircleradius = scripts\mp\gametypes\br_circle::getdangercircleradius();
    var_dcdcea34083b6b8 = getdvarint(@ "hash_54e04086872e7d2c", 0) == 1;

    if(var_dcdcea34083b6b8 || distance2dsquared(dangercircleorigin, vehicle.origin) > dangercircleradius * dangercircleradius) {
      vehicle thread function_6c35d65fc1f38eb8();

      if(level.teamcanrespawn[team] == 1) {
        level.teamcanrespawn[team] = 0;
        players = getteamdata(team, "players");

        foreach(player in players) {
          player ent_flag_set("respawn_vehicle_in_gas");
        }

        showsplashtoteam(team, "truckwar_vehicle_spawn_disabled");
        thread function_9f5606e3bd1c508d("vehicle_spawn_disabled", level.teamdata[team]["players"]);
        level thread[[level.updategameevents]]();
      }
    } else if(level.teamcanrespawn[team] == 0) {
      vehicle notify("vehicle_gas_exit");
      vehicle.var_c2b8326ef7abcae6 = 0;
      level.teamcanrespawn[team] = 1;
      players = getteamdata(team, "players");

      foreach(player in players) {
        player ent_flag_clear("respawn_vehicle_in_gas");
      }

      showsplashtoteam(team, "truckwar_vehicle_spawn_enabled");
      thread function_9f5606e3bd1c508d("vehicle_spawn_enabled", level.teamdata[team]["players"]);
      level thread[[level.updategameevents]]();
    }

    waitframe();
  }
}

function function_6c35d65fc1f38eb8() {
  self endon("death");
  self endon("vehicle_gas_exit");

  if(istrue(self.var_c2b8326ef7abcae6)) {
    return;
  }

  self.var_c2b8326ef7abcae6 = 1;
  damagepct = getdvarfloat(@ "hash_a705a5caa6ea4daf", 0.05);
  damageamount = self.maxhealth * damagepct;

  while(isDefined(self)) {
    wait 1;
    self dodamage(damageamount, self.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
  }
}

function function_66e49bf742fccb61(vehicle, team) {
  vehicle endon("death");
  level endon("game_ended");
  vehicle.oobtime = 0;
  var_ec4ad047de451525 = getdvarfloat(@ "hash_38e9f472cca85346", 15);
  var_b36b64992d102a16 = getdvarfloat(@ "hash_32657fe607d73d8c", 5);
  wasempty = vehicle.isempty;
  wasoob = 0;
  emptytime = undefined;

  while(true) {
    if(!wasempty && vehicle.isempty) {
      emptytime = gettime() + var_ec4ad047de451525 * 1000;
    }

    wasempty = vehicle.isempty;

    if(isDefined(emptytime) && gettime() < emptytime || wasoob) {
      isoob = 0;
      inflictor = undefined;

      foreach(trigger in level.outofboundstriggers) {
        if(vehicle istouching(trigger)) {
          vehicle.oobtime += level.framedurationseconds;
          isoob = 1;
          inflictor = trigger;
          break;
        }
      }

      wasoob = isoob;

      if(!isoob) {
        vehicle.oobtime -= level.framedurationseconds;
      }

      vehicle.oobtime = clamp(vehicle.oobtime, 0, var_b36b64992d102a16);

      if(vehicle.oobtime == var_b36b64992d102a16) {
        vehicle dodamage(999999, vehicle.origin, inflictor, inflictor, "MOD_TRIGGER_HURT");
      }
    }

    waitframe();
  }
}

function function_3e5a0635a240ede5(vehicle, team) {
  vehicle endon("death");
  level endon("game_ended");
  ignoretime = getdvarfloat(@ "hash_def42f45937be461", 15) * 1000;
  lastplayedtime = undefined;

  while(isDefined(vehicle)) {
    vehicle waittill("damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon);
    vehicle.lastdamagedtime = gettime();
    function_256806bcfdf38c83(team);
    players = getteamdata(team, "players");

    foreach(player in players) {
      player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", vehicle.health);
      player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", vehicle.maxhealth);
    }

    if(smeansofdeath == "MOD_TRIGGER_HURT" || isDefined(eattacker) && eattacker.classname == "worldspawn") {
      continue;
    }

    if(isDefined(lastplayedtime) && lastplayedtime + ignoretime > gettime()) {
      continue;
    }

    lastplayedtime = gettime();
    players = getteamdata(team, "players");
    showsplashtoteam(team, "truckwar_vehicle_under_attack");
    thread function_9f5606e3bd1c508d("vehicle_under_attack", level.teamdata[team]["players"]);
  }
}

function blockhealing(team) {
  self endon("death");
  self notify("blockHealing");
  self endon("blockHealing");
  self.healingblocked = 1;
  function_256806bcfdf38c83(team);
  ignoretime = getdvarfloat(@ "hash_aa27dea6d1c24ca3", 15);
  wait ignoretime;
  self.healingblocked = 0;
  function_256806bcfdf38c83(team);
}

function function_46ed8b0b237087f8(vehicle, team) {
  vehicle endon("death");
  level endon("game_ended");

  while(isDefined(vehicle)) {
    vehicle waittill("upgrade_message", message);

    if(message != "trophy_ammo_used") {
      splashref = function_e50c00059892a159(message);
      showsplashtoteam(team, splashref);
      thread function_9f5606e3bd1c508d(message, level.teamdata[team]["players"]);

      foreach(player in level.teamdata[team]["players"]) {
        if(isDefined(player.br_kiosk) && player.br_kiosk.var_114e759371623080) {
          kiosk = player.br_kiosk;
          var_6b3c6b40c0598d85 = player scripts\mp\gametypes\br_armory_kiosk::function_b88d64cd67bbe60f(kiosk);
          player setclientomnvar("ui_buystation_limited_item_amount", var_6b3c6b40c0598d85);
        }
      }
    }

    function_256806bcfdf38c83(team);
  }
}

function private function_ad382245d8d861f3(vehicle, team) {
  level endon("game_ended");
  vehicle endon("death");
  vehicle endon("give_upgrade");
  wait 60;

  foreach(player in level.teamdata[team]["players"]) {
    player namespace_88bfae359020fdd3::ftue_triggertip("br_ftue_truckwar_upgrade");
  }
}

function function_e50c00059892a159(message) {
  switch (message) {
    case #"hash_88165be29e007e7d":
      return "truckwar_vehicle_armor_upgraded";
    case #"hash_1dce51fa1fb3327f":
      return "truckwar_vehicle_trophy_upgraded";
    case #"hash_94c61044fbf1888f":
      return "truckwar_vehicle_portable_radar_upgraded";
    case #"hash_63f403be29b3b53d":
      return "truckwar_vehicle_barrel_upgraded";
    case #"hash_ee8297c26c0e28ee":
      return "truckwar_vehicle_trophy_no_ammo";
    case #"hash_3c02a3c6ca5098cf":
      return "truckwar_vehicle_trophy_refilled";
    case #"hash_1bee7c040eb03ea4":
      return "truckwar_vehicle_turret_upgraded";
    case #"hash_e9e3a7d0d2276ee6":
      return "truckwar_vehicle_smoke_upgraded";
    case #"hash_280d7476aeedef2b":
      return "truckwar_vehicle_engine_upgraded";
  }
}

function notifyteamonvehicledeath(vehicle, team) {
  level endon("game_ended");
  players = getteamdata(team, "players");

  foreach(player in players) {
    player ent_flag_init("respawn_vehicle_death");
  }

  vehicle waittill("death");
  level.teamcanrespawn[team] = 0;
  level.teamvehicles[team] = undefined;
  setomnvar("ui_truckwar_trucks_remaining", level.teamvehicles.size);
  players = getteamdata(team, "players");

  foreach(player in players) {
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", 0);
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", 1);
    player ent_flag_set("respawn_vehicle_death");
  }

  showsplashtoteam(team, "truckwar_vehicle_destroyed");
  thread function_9f5606e3bd1c508d("vehicle_destroyed", level.teamdata[team]["players"]);
  thread function_bc2cb59695039e19(team);
  level thread[[level.updategameevents]]();
  function_256806bcfdf38c83(team);
}

function function_bc2cb59695039e19(team) {
  level endon("game_ended");

  while(true) {
    waittime = randomfloatrange(180, 300);
    wait waittime;

    if(istrue(level.teamcanrespawn[team])) {
      break;
    }

    thread function_9f5606e3bd1c508d("reminder_purchase", level.teamdata[team]["players"]);
  }
}

function gettruckspawns(vehicleref) {
  if(level.mapname != "mp_br_mechanics" && getdvarint(@ "hash_692b4b274d3b7bdc", 0) == 0) {
    spawns = getpresettruckspawns(vehicleref);

    if(isDefined(spawns) && spawns.size > 0) {
      return spawns;
    }
  }

  numvehicles = level.teamnamelist.size;
  validteamcount = 0;

  foreach(entry in level.teamnamelist) {
    if(getteamdata(entry, "players").size > 0) {
      validteamcount++;
    }
  }

  numvehicles = validteamcount;
  anglestep = 360 / numvehicles;
  circlecenter = (0, 0, 100);

  if(level.mapname == "mp_br_mechanics") {
    circlecenter = (0, 0, 100);
    var_73562bf0ddc8b02d = 9000;
  } else {
    circlecenter = (0, 0, 100);
    var_73562bf0ddc8b02d = 40000;
  }

  tracecontents = scripts\engine\trace::create_default_contents(1);
  spawns = [];

  for(i = 0; i < numvehicles; i++) {
    angles = i * anglestep;
    forward = anglesToForward((0, angles, 0));
    origin = circlecenter + forward * var_73562bf0ddc8b02d;
    groundorigin = scripts\mp\gametypes\br_public::droptogroundmultitrace(origin, 10000, -20000, tracecontents);
    origin = (origin[0], origin[1], groundorigin[2] + 200);
    vehicle = spawnStruct();
    vehicle.origin = origin;
    var_7224bacab3f8ee26 = (0, 0, 0);
    vehicle.angles = vectortoangles(forward * -1);
    vehicle.targetname = vehicleref;
    spawns[spawns.size] = vehicle;
  }

  return spawns;
}

function getpresettruckspawns(vehicleref) {
  spawnorigins = [];
  spawnorigins = getStructArray("mp_truckwar_team_start_spawn", "targetname");

  if(spawnorigins.size == 0) {
    return undefined;
  }

  spawnorigins = array_randomize(spawnorigins);
  tracecontents = scripts\engine\trace::create_default_contents(1);
  var_20acb030a0bf7a84 = 0;

  foreach(struct in spawnorigins) {
    groundorigin = scripts\mp\gametypes\br_public::droptogroundmultitrace(struct.origin, 10000, -20000, tracecontents);
    origin = (struct.origin[0], struct.origin[1], struct.origin[2] + 200);
    struct.origin = origin;
    var_20acb030a0bf7a84++;

    if(var_20acb030a0bf7a84 >= 5) {
      var_20acb030a0bf7a84 = 0;
      waitframe();
    }
  }

  spawns = [];
  numvehicles = spawnorigins.size;

  for(i = 0; i < numvehicles; i++) {
    vehicle = spawnStruct();
    vehicle.origin = spawnorigins[i].origin;
    vehicle.angles = spawnorigins[i].angles;
    vehicle.targetname = vehicleref;
    spawns[spawns.size] = vehicle;
  }

  return spawns;
}

function gethelispawns(vehicleref) {
  spawns = [];
  numvehicles = 3;
  anglestep = 360 / numvehicles;
  circlecenter = (0, 0, 100);
  var_73562bf0ddc8b02d = 1000;

  for(i = 0; i < numvehicles; i++) {
    angles = i * anglestep;
    forward = anglesToForward((0, angles, 0));
    origin = circlecenter + forward * var_73562bf0ddc8b02d;
    vehicle = spawnStruct();
    vehicle.origin = origin;
    var_7224bacab3f8ee26 = (0, 0, 0);
    vehicle.angles = vectortoangles(forward * -1);
    vehicle.targetname = vehicleref;
    spawns[spawns.size] = vehicle;
  }

  return spawns;
}

function isteameliminated(team) {
  if(!isDefined(level.teamcanrespawn)) {
    return false;
  }

  return getteamdata(team, "aliveCount") == 0 && (!istrue(level.teamcanrespawn[team]) || istrue(level.var_24380db31e302a78));
}

function playerkilledspawn(deathdata, finaldeath) {
  if(!scripts\mp\flags::gameflag("use_truck_respawn")) {
    return false;
  }

  deathdata.victim thread playerrespawn(0, deathdata, finaldeath);
  deathdata.victim thread scripts\mp\gametypes\br_spectate::spawnspectator(deathdata, finaldeath);
  return true;
}

function playerrespawn(fastrespawn, deathdata, finaldeath) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_auto_win");
  self notify("playerRespawn");
  self endon("playerRespawn");

  if(istrue(level.gameended)) {
    return;
  }

  if(istrue(level.var_24380db31e302a78) || isteameliminated(self.team) || ent_flag_exist("respawn_vehicle_death") && ent_flag("respawn_vehicle_death")) {
    thread scripts\mp\gametypes\br_spectate::triggereliminatedoverlay();
    return;
  }

  if(getdvarint(@ "hash_1560eca11fd78307", 1) == 1) {
    self endon("brWaitAndSpawnClientComplete");
  }

  spawnwait = getplayerrespawndelay(self);

  if(istrue(fastrespawn)) {
    spawnwait = 0;
  }

  var_ac5cf023ca77db21 = getdvarint(@ "hash_de56eb4b8051c0e", 5);

  if(spawnwait < var_ac5cf023ca77db21) {
    spawnwait = var_ac5cf023ca77db21;
  }

  if(level.respawntimedisable != 0) {
    spawnwait = 0;
  }

  ent_flag_init("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;
  var_a294c35cbb452cbf = spawnwait - var_ac5cf023ca77db21;
  var_d2f5422694822652 = spawnwait - var_a294c35cbb452cbf;
  blackscreenwait = spawnwait - getdvarint(@ "hash_3ae7661f87c2cf43", 5);

  if(spawnwait > 0) {
    function_b6b4285e173dd004(self);
    thread function_74ae749db3acb35e(self, spawnwait);
  }

  result = waittill_notify_or_timeout_return("respawn_vehicle_death", var_a294c35cbb452cbf);

  if(result != "respawn_vehicle_death") {
    thread updateprestreamrespawn();
    result = waittill_notify_or_timeout_return("respawn_vehicle_death", var_d2f5422694822652);
  }

  self notify("stop_updatePrestreamRespawn");
  thread fadeoutin();
  function_218d7f561bc41a41(self);
  wait 0.5;

  if(ent_flag_exist("respawn_vehicle_death") && ent_flag("respawn_vehicle_death")) {
    thread scripts\mp\gametypes\br_spectate::setbuybackpingmessage();
  } else if(ent_flag("respawn_vehicle_in_gas")) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("vehicle_in_gas");
  }

  while(ent_flag_exist("respawn_vehicle_death") && !ent_flag("respawn_vehicle_death") && !level.teamcanrespawn[self.team] || scripts\common\utility::isusingremote()) {
    waitframe();
  }

  if(ent_flag_exist("respawn_vehicle_death") && ent_flag("respawn_vehicle_death")) {
    thread scripts\mp\gametypes\br_spectate::setbuybackpingmessage();
  }

  if(isteameliminated(self.team) || ent_flag_exist("respawn_vehicle_death") && ent_flag("respawn_vehicle_death")) {
    thread scripts\mp\gametypes\br_spectate::spawnspectator(deathdata, finaldeath);
    thread scripts\mp\gametypes\br_spectate::triggereliminatedoverlay();
    setcachedclientomnvar("ui_br_transition_type", 0);
    namespace_8bfdb6eb5a3df67a::function_e68e4bb4f65f5fe4();
    return;
  }

  spawnpoint = getspawnpoint();
  streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
  flareorigin = level.teamvehicles[self.team].origin;

  if(getdvarint(@ "scr_skip_respawn_gate", 1) == 0) {
    scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
  }

  ent_flag_clear("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self.cachedomnars = [];
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();
  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, spawnpoint, 1, streamorigin, 1, undefined, 0, 0, 1);
  spawnangles = vectortoangles(flareorigin - streamorigin);
  self setplayerangles(spawnangles);
  self notify("respawn_view_set");
  scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "player_respawn");

  if(isDefined(level.teamvehicles[self.team])) {
    flareorigin = level.teamvehicles[self.team].origin;
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", level.teamvehicles[self.team].health);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", level.teamvehicles[self.team].maxhealth);
  }

  level thread scripts\mp\gametypes\br_quest_util::utilflare_shootflare(flareorigin, "revive");
  setcachedclientomnvar("ui_br_transition_type", 0);
  function_256806bcfdf38c83(self.team);
}

function private function_64e94e8b1e610263() {
  level.brgametype.respawndelay["_solos"][0] = getdvarint(@ "hash_bc01b0a06d2dbde9", 15);
  level.brgametype.respawndelay["_solos"][1] = getdvarint(@ "hash_bc01ada06d2db750", 20);
  level.brgametype.respawndelay["_solos"][2] = getdvarint(@ "hash_bc01aea06d2db983", 30);
  level.brgametype.respawndelay["_duos"][0] = getdvarint(@ "hash_fc1ef4784978935a", 15);
  level.brgametype.respawndelay["_duos"][1] = getdvarint(@ "hash_fc1ef37849789127", 20);
  level.brgametype.respawndelay["_duos"][2] = getdvarint(@ "hash_fc1ef27849788ef4", 30);
  level.brgametype.respawndelay["_trios"][0] = getdvarint(@ "hash_cc07978496a297a0", 20);
  level.brgametype.respawndelay["_trios"][1] = getdvarint(@ "hash_cc079a8496a29e39", 30);
  level.brgametype.respawndelay["_trios"][2] = getdvarint(@ "hash_cc07998496a29c06", 40);
  level.brgametype.respawndelay["_quads"][0] = getdvarint(@ "hash_f5bdd5587fd7f1f9", 25);
  level.brgametype.respawndelay["_quads"][1] = getdvarint(@ "hash_f5bdd2587fd7eb60", 35);
  level.brgametype.respawndelay["_quads"][2] = getdvarint(@ "hash_f5bdd3587fd7ed93", 45);
}

function private function_338ba9b353a9a78b(player) {
  suffixindex = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb() - 1;

  if(istrue(level.brgametype.var_bb9b77186cb79ae6)) {
    players = scripts\mp\utility\player::getteamarray(player.team);
    suffixindex = players.size - 1;

    foreach(player in players) {
      if(isDefined(player) && istrue(player.var_632bad3edb4e449e)) {
        suffixindex--;
      }
    }
  }

  suffixindex = int(max(min(suffixindex, level.brgametype.var_34af112c77c2c381.size - 1), 0));
  return level.brgametype.var_34af112c77c2c381[suffixindex];
}

function private getplayerrespawndelay(player) {
  var_53a4a1c920def4bd = function_338ba9b353a9a78b(player);

  if(level.br_circle.circleindex < 0) {
    return level.brgametype.respawndelay[var_53a4a1c920def4bd][0];
  }

  circleindex = int(min(level.br_circle.circleindex, level.brgametype.respawndelay[var_53a4a1c920def4bd].size - 1));
  return level.brgametype.respawndelay[var_53a4a1c920def4bd][circleindex];
}

function private function_74ae749db3acb35e(player, time) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("respawn_vehicle_death");

  while(time >= 0) {
    function_53c22fbe6b489ec1(player, time);
    player scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", time);
    time--;
    wait 1;
  }
}

function private function_b6b4285e173dd004(player) {
  currentvalue = player getclientomnvar("ui_resurgenceRespawnTimer");
  newvalue = currentvalue | 16384;
  player setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
}

function private function_218d7f561bc41a41(player) {
  currentvalue = player getclientomnvar("ui_resurgenceRespawnTimer");
  newvalue = currentvalue &~16384;
  player setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
}

function private function_53c22fbe6b489ec1(player, value) {
  assert(value <= 16384 - 1);
  currentvalue = player getclientomnvar("ui_resurgenceRespawnTimer");
  otherbits = currentvalue &~(16384 - 1);
  newvalue = otherbits | value;
  player setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
}

function private function_6e7b6151aba26dc2() {
  level endon("game_ended");
  level.brgametype.respawnenable = 1;
  level.brgametype.respawndelay = [];
  level.brgametype.var_34af112c77c2c381 = ["_solos", "_duos", "_trios", "_quads"];
  level.brgametype.var_bb9b77186cb79ae6 = getdvarint(@ "hash_ecd9594bd7c0b2ad", 1) == 1;
  level.brgametype.var_9524142eb719a321 = getdvarint(@ "hash_ca8ddd67c2b5771a", 1) == 1;
  level.brgametype.var_8947d8f4e61494fa = getdvarint(@ "hash_24d595ecd1de09dc", 1) == 1 && istrue(level.brgametype.var_bb9b77186cb79ae6);
  level.brgametype.var_fb997d1846bd5cf4 = getdvarint(@ "hash_895f0d248f2c4008", 1) == 1 && istrue(level.brgametype.var_9524142eb719a321);
  level.brgametype.issolos = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb() == 1;
  setomnvar("ui_br_resurgence_respawn_enabled", 1);
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  thread function_64e94e8b1e610263();
  thread function_89473c1117c46c57();
  endcircle = scripts\mp\gametypes\br_gametype_truckwar::function_e501cce5c715caf();

  foreach(var_53a4a1c920def4bd in level.brgametype.var_34af112c77c2c381) {
    for(i = 0; i < endcircle; i++) {
      overridedelay = getdvarint(hashcat(@ "hash_fd72eab87b422f51", i + 1, var_53a4a1c920def4bd), -1);

      if(overridedelay >= 0) {
        level.brgametype.respawndelay[var_53a4a1c920def4bd][i] = overridedelay;
        continue;
      }

      if(i >= level.brgametype.respawndelay[var_53a4a1c920def4bd].size) {
        level.brgametype.respawndelay[var_53a4a1c920def4bd][i] = level.brgametype.respawndelay[var_53a4a1c920def4bd][i - 1];
      }
    }
  }

  waittime = 0;

  for(i = 0; i < endcircle; i++) {
    waittime += level.br_level.br_circleclosetimes[i] + level.br_level.br_circledelaytimes[i];
  }

  waittimems = int(waittime * 1000);
  maxwaittimems = getdvarint(@ "hash_342776b421ce99fa", 90000);
  level waittill("infils_ready");
  var_e493cd71687bbcc3 = waittimems - maxwaittimems;

  if(var_e493cd71687bbcc3 > 0) {
    wait var_e493cd71687bbcc3 * 0.001;
    waittimems = maxwaittimems;
  }

  setomnvarforallclients("ui_br_resurgence_will_disable", 1);
  setomnvarforallclients("ui_br_timed_feature_end_time", int(gettime() + waittimems));
  wait waittimems * 0.001;
  setomnvarforallclients("ui_br_timed_feature_end_time", 0);
  level.brgametype.respawnenable = 0;
  level.brgametype.var_9524142eb719a321 = 0;
  level.brgametype.var_fb997d1846bd5cf4 = 0;
}

function private function_89473c1117c46c57() {
  level endon("game_ended");
  level scripts\engine\utility::flag_wait("StartGameTypeCallbackFinished");
  level.brgametype.var_38d22e79b27c8a08 = namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25() && getdvarint(@ "hash_fa76fc54e37da65d", 1);

  if(istrue(level.brgametype.var_38d22e79b27c8a08)) {
    namespace_bf9ffd2b22c7d819::function_8fe6d6539ed31a88(&function_fea438ae40d5637b);
  }
}

function private function_fea438ae40d5637b(player) {
  if(!scripts\mp\flags::gameflag("prematch_fade_done")) {
    return;
  }

  if(istrue(level.brgametype.issolos)) {
    return;
  }

  if(!istrue(level.brgametype.respawnenable)) {
    return;
  }

  if(!istrue(level.brgametype.var_bb9b77186cb79ae6)) {
    return;
  }

  if(istrue(level.brgametype.var_8947d8f4e61494fa)) {
    remainingplayers = scripts\mp\utility\player::getteamarray(player.team);

    foreach(remainingplayer in remainingplayers) {
      remainingplayer thread scripts\mp\hud_message::showsplash("truckwar_ally_rejoin_improvement", undefined, player);
    }
  }
}

function private onplayerdisconnectcallback(player) {
  if(!scripts\mp\flags::gameflag("prematch_fade_done")) {
    return;
  }

  if(istrue(level.brgametype.issolos)) {
    return;
  }

  if(!istrue(level.brgametype.respawnenable)) {
    return;
  }

  remainingplayers = level.teamdata[player.team]["players"];

  if(remainingplayers.size == 1) {
    if(istrue(level.brgametype.var_fb997d1846bd5cf4)) {
      remainingplayers[0] thread scripts\mp\hud_message::showsplash("truckwar_left_behind_improvement");
    }
  } else {
    foreach(remainingplayer in remainingplayers) {
      if(istrue(level.brgametype.var_8947d8f4e61494fa)) {
        remainingplayer thread scripts\mp\hud_message::showsplash("truckwar_ally_left_improvement", undefined, player, undefined, 1);
      }
    }
  }

  if(istrue(level.brgametype.var_bb9b77186cb79ae6)) {
    scripts\mp\gametypes\br_public::brleaderdialog("resurgence_on_player_disconnect", 1, remainingplayers, undefined, 0, undefined);
  }
}

function fadetogearingup(waittime) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(waittime) && waittime > 0) {
    wait waittime;
  }

  if(isteameliminated(self.team) || !level.teamcanrespawn[self.team]) {
    return;
  }

  var_b59f471c2c064e56 = 1;
  thread fadeoutin();
  wait var_b59f471c2c064e56 - 0.25;
  scripts\mp\gametypes\br::function_258c4f40dee8189a();
  setcachedclientomnvar("ui_br_transition_type", 2);
  wait 0.25;

  if(isteameliminated(self.team) || !level.teamcanrespawn[self.team]) {
    setcachedclientomnvar("ui_br_transition_type", 0);
    return;
  }

  if(getdvarint(@ "hash_e912e88184530f28", 1) == 1) {
    scripts\mp\gametypes\br_public::playerclearstreamhintorigin();
    spawnpoint = getspawnpoint();
    scripts\mp\gametypes\br_spectate::playerclearspectatekillchainsystem();
    scripts\mp\gametypes\br::spawnintermission(spawnpoint.origin, spawnpoint.angles);
    scripts\mp\spectating::setdisabled();
    self.intermissionspawnorigin = spawnpoint.origin;
    self.intermissionspawntime = gettime();
    ent_flag_set("playerRespawn_intermission_spawned");
  }
}

function fadeoutin() {
  level endon("game_ended");
  self endon("disconnect");
  namespace_8bfdb6eb5a3df67a::function_334a8fe67e88bbe7();
  result = waittill_any_return_no_endon_death_3("spawned_player", "respawn_vehicle_in_gas", "gulag_auto_win");

  if(result == "spawned_player" || result == "respawn_vehicle_in_gas") {
    self waittill("respawn_view_set");
  } else {
    setcachedclientomnvar("ui_br_transition_type", 0);
  }

  namespace_8bfdb6eb5a3df67a::function_e68e4bb4f65f5fe4();
}

function updateprestreamrespawn() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");
  self endon("respawn_vehicle_death");

  while(true) {
    if(ent_flag("playerRespawn_intermission_spawned")) {
      spawnpoint = getspawnpoint();
      currenttime = gettime();
      assert(isDefined(self.intermissionspawntime));
      assert(self.intermissionspawntime <= currenttime);

      if(currenttime - self.intermissionspawntime >= getdvarfloat(@ "hash_b72fc168d3582ece", 2) * 1000) {
        spawnpoint = getspawnpoint();
        streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
      }
    } else {
      spawnpoint = getspawnpoint();
      streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
    }

    wait 1;
  }
}

function initspawns() {
  level.spawnheight = getdvarfloat(@ "hash_1cdb6b91e9c4a104", 2500);
}

function getspawnpoint(isplanejump) {
  if(!isDefined(self.redeployspawn)) {
    self.redeployspawn = spawnStruct();
    return generatespawnpoint(istrue(isplanejump));
  }

  self.ti_spawn = 0;

  if(isDefined(self.setspawnpoint)) {
    spawnpoint = self.setspawnpoint;

    if(!istrue(self.setspawnpoint.notti)) {
      self.ti_spawn = 1;
      self playlocalsound("tactical_spawn");

      foreach(entry in level.teamnamelist) {
        if(entry != self.team) {
          self playsoundtoteam("tactical_spawn", entry);
        }
      }
    }

    spawnorigin = self.setspawnpoint.playerspawnpos;
    tracecontents = scripts\engine\trace::create_default_contents(1);
    groundorigin = scripts\mp\gametypes\br_public::droptogroundmultitrace(spawnorigin, 10000, -20000, tracecontents);
    spawnorigin = (spawnorigin[0], spawnorigin[1], groundorigin[2]);
    spawnorigin += (0, 0, 1) * level.brtdm_config.spawnheight[self.team];

    if(getdvarint(@ "hash_53b56fcd1ad4a8ce") == 1) {
      thread drawline(spawnorigin, groundorigin, 15, (1, 1, 0));
    }

    self.redeployspawn.origin = spawnorigin;
    self.redeployspawn.angles = self.setspawnpoint.playerspawnangles;
    self.redeployspawn.lifeid = self.lifeid;
    self.redeployspawn.time = gettime();
    scripts\mp\equipment\tac_insert::spawnpoint_clearspawnpoint(0, 1);
  } else if(self.redeployspawn.team != self.team || self.redeployspawn.lifeid != self.lifeid || istrue(self.redeployspawn.isplanejump)) {
    return generatespawnpoint(istrue(isplanejump));
  }

  return self.redeployspawn;
}

function generatespawnpoint(isplanejump) {
  spawnorigin = level.teamvehicles[self.team].origin;
  tracecontents = scripts\engine\trace::create_default_contents(1);
  result = scripts\engine\trace::ray_trace(spawnorigin + (0, 0, 10000), spawnorigin - (0, 0, 20000), undefined, tracecontents)["position"];
  spawnorigin = (spawnorigin[0], spawnorigin[1], result[2] + level.spawnheight);

  if(istrue(level.var_af6ec941d2b4e283) && getdvarint(@ "hash_202e933fd3431d24", 1) == 1) {
    if(istrue(level.circleclosing)) {
      safecircleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
      safecircleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();
      var_29d5d9f11d8593c1 = safecircleorigin - spawnorigin;
      var_e1261bd8c0a31088 = distance2d(safecircleorigin, spawnorigin);

      if(var_e1261bd8c0a31088 > safecircleradius) {
        var_12878f234651556d = vectorNormalize(var_29d5d9f11d8593c1);
        var_ffeb7fabc1a11eef = 0;
        desiredoffsetdistance = 0;

        if(level.br_circle.circleindex == 0) {
          previousradii = level.br_level.br_circleradii[level.br_circle.circleindex];
          var_ffeb7fabc1a11eef = previousradii - safecircleradius;
        } else {
          var_fb0f5a7f828190b1 = level.br_level.br_circlecenters[level.br_circle.circleindex];
          var_ffeb7fabc1a11eef = distance2d(safecircleorigin, var_fb0f5a7f828190b1);
        }

        closetime = level.br_level.br_circleclosetimes[level.br_circle.circleindex + 1];
        velocity = var_ffeb7fabc1a11eef / closetime;
        var_5fe3a6ebd9433e80 = velocity * getdvarfloat(@ "hash_4f1aee380c4c64f8", 10);
        spawnorigin += var_12878f234651556d * var_5fe3a6ebd9433e80;
        dangercircleorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
        dangercircleradius = scripts\mp\gametypes\br_circle::getdangercircleradius();

        if(distance2dsquared(spawnorigin, dangercircleorigin) > dangercircleradius * dangercircleradius) {
          var_2099c256f875ad40 = vectorNormalize(spawnorigin - dangercircleorigin);
          spawnorigin = dangercircleorigin + var_2099c256f875ad40 * dangercircleradius * 0.99;
        }
      }
    }
  }

  self.redeployspawn.origin = spawnorigin;
  self.redeployspawn.angles = level.teamvehicles[self.team].angles;
  self.redeployspawn.time = gettime();
  self.redeployspawn.team = self.team;
  self.redeployspawn.index = -1;
  self.redeployspawn.lifeid = self.lifeid;
  self.redeployspawn.isplanejump = isplanejump;
  return self.redeployspawn;
}

function watchspawninput() {
  setdevdvar(@ "hash_c8b7643c6637e674", 0);

  while(!isDefined(level.players) || level.players.size == 0) {
    waitframe();
  }

  animtoggle = 1;

  while(true) {
    waitframe();

    if(getdvarint(@ "hash_c8b7643c6637e674", 0) != 0) {
      damage = 1000;
      radiusdamage(level.teamvehicles["axis"].origin, 1000, damage, damage);

      setdevdvar("<dev string:x1c>", 0);
    }
  }
}

function addspawnlocation() {
  if(!isDefined(level.truckwarspawnlocations)) {
    level.truckwarspawnlocations = [];
  }

  level.truckwarspawnlocations[level.truckwarspawnlocations.size] = level.players[0].origin;

  println("<dev string:x37>");

  foreach(origin in level.truckwarspawnlocations) {
    println("<dev string:x55>" + origin);
  }

  println("<dev string:x69>");
}

#using_animtree("script_model");

function init_airdrop_anims() {
  level.scr_animtree["ac130"] = #animtree;
  level.scr_anim["ac130"]["truck_drop"] = % mp_mkilo23_gunner_drop_acharlie130;
  level.scr_anim["ac130"]["truck_drop_trimmed"] = % mp_mkilo23_gunner_drop_acharlie130_trimmed;
  level.scr_animtree["parachute"] = #animtree;
  level.scr_anim["parachute"]["truck_drop"] = % mp_mkilo23_gunner_drop_parachute;
  scripts\common\anim::addnotetrack_customfunction("parachute", "parachute_detach_sfx", &parachute_detach_sfx, "truck_drop");
  level.scr_anim["parachute"]["truck_drop_trimmed"] = % mp_mkilo23_gunner_drop_parachute_trimmed;
  scripts\common\anim::addnotetrack_customfunction("parachute", "parachute_detach_sfx", &parachute_detach_sfx, "truck_drop_trimmed");
  init_airrop_vehicle_anims();
}

function private function_a614e0fee13eca53() {
  flag_wait("vehicle_init_complete");

  if(!scripts\cp_mp\vehicles\vehicle::function_89dc39dc11f3988c("veh9_mil_lnd_mrap")) {
    return;
  }

  data = scripts\cp_mp\vehicles\vehicle::function_29b4292c92443328("veh9_mil_lnd_mrap");
  data.damage.class = "heavy";
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_applytabletovehicle("veh9_mil_lnd_mrap");
  data.damage.var_3259f2f4faf8eaa8 = getdvarint(@ "hash_e20f6b4a3c18e03a", 3);
}

#using_animtree("mp_vehicles_always_loaded");

function init_airrop_vehicle_anims() {
  level.scr_animtree["truck"] = #animtree;
  level.scr_anim["truck"]["truck_drop"] = % mp_mkilo23_gunner_drop_mkilo23;
  level.scr_anim["truck"]["truck_drop_trimmed"] = % mp_mkilo23_gunner_drop_mkilo23_trimmed;
}

function truck_airdrop(vehicle, position, angles, showc130) {
  animation = ter_op(istrue(showc130), "truck_drop", "truck_drop_trimmed");
  vehicle.animname = "truck";
  vehicle.var_ae21e3bf76862551 = 1;
  vehicle vehphys_forcekeyframedmotion();
  vehicle hide();
  scenenode = spawn("script_model", position);
  scenenode.angles = angles;
  scenenode setModel("tag_origin");
  objent = undefined;
  parachute = spawn("script_model", position);
  parachute.angles = angles;
  parachute.animname = "parachute";
  parachute setModel("veh8_mil_lnd_bromeo_parachute");
  parachute scripts\common\anim::setanimtree();
  parachute forcenetfieldhighlod(1);
  parachute hide();
  carrier = undefined;

  if(istrue(showc130)) {
    carrier = spawn("script_model", position);
    carrier.angles = angles;
    carrier.animname = "ac130";
    carrier setModel("veh8_mil_air_acharlie130_ks_carrier");
    carrier scripts\common\anim::setanimtree();
    carrier hide();
  }

  scenenode.vehicle = vehicle;
  scenenode.parachute = parachute;
  scenenode.carrier = carrier;
  scenenode.objent = objent;
  scenestarttime = gettime() + level.frameduration;
  scenenode.endtime = gettime();
  scenenode.vehicleendtime = scenestarttime + getanimlength(level.scr_anim["truck"][animation]) * 1000;

  if(scenenode.vehicleendtime > scenenode.endtime) {
    scenenode.endtime = scenenode.vehicleendtime;
  }

  scenenode.parachuteendtime = scenestarttime + getanimlength(level.scr_anim["parachute"][animation]) * 1000;

  if(scenenode.parachuteendtime > scenenode.endtime) {
    scenenode.endtime = scenenode.parachuteendtime;
  }

  scenenode.carrierendtime = scenestarttime + getanimlength(level.scr_anim["ac130"][animation]) * 1000;

  if(scenenode.carrierendtime > scenenode.endtime) {
    scenenode.endtime = scenenode.carrierendtime;
  }

  scenenode thread truck_airdropinternal(animation);
  return vehicle;
}

function truck_airdropinternal(animation) {
  scripts\common\anim::anim_first_frame_solo(self.vehicle, animation);
  scripts\common\anim::anim_first_frame_solo(self.parachute, animation);

  if(isDefined(self.carrier)) {
    scripts\common\anim::anim_first_frame_solo(self.carrier, animation);
  }

  waitframe();

  if(isDefined(self.vehicle)) {
    self.vehicle show();
    self.vehicle.infilling = 1;
    thread scripts\common\anim::anim_single_solo(self.vehicle, animation);
  }

  if(isDefined(self.parachute)) {
    self.parachute show();
    thread scripts\common\anim::anim_single_solo(self.parachute, animation);
  }

  if(isDefined(self.carrier)) {
    self.carrier show();
    self.carrier playLoopSound("iw8_cargotruck_drop_c130");
    self.carrier setscriptablepartstate("lights2", "on", 0);
    self.carrier setscriptablepartstate("contrails", "on", 0);
    thread scripts\common\anim::anim_single_solo(self.carrier, animation);
  }

  while(gettime() <= self.endtime) {
    if(!isDefined(self.vehicle) || istrue(self.vehicle.isdestroyed) || gettime() >= self.vehicleendtime) {
      thread truck_detachvehiclefromairdropsequence(self.vehicle);
    }

    if(isDefined(self.parachute) && gettime() >= self.parachuteendtime) {
      self.parachute delete();
    }

    if(isDefined(self.carrier) && gettime() >= self.carrierendtime) {
      self.carrier delete();
    }

    waitframe();
  }

  thread truck_detachvehiclefromairdropsequence(self.vehicle);

  if(isDefined(self.parachute)) {
    self.parachute delete();
  }

  if(isDefined(self.carrier)) {
    self.carrier delete();
  }

  self delete();
}

function truck_detachvehiclefromairdropsequence(vehicle) {
  self.vehicle = undefined;

  if(isDefined(vehicle)) {
    vehicle vehphys_setdefaultmotion();
    vehicle thread function_f004d4b200aa4c84();
  }
}

function function_f004d4b200aa4c84() {
  self endon("death");
  self physics_registerforcollisioncallback();
  waitframe();
  endtime = gettime() + 5000;
  var_e66474b0ba499331 = undefined;
  var_bec445e79e2f5b6a = undefined;

  while(gettime() < endtime) {
    if(!isDefined(var_e66474b0ba499331)) {
      var_e66474b0ba499331 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
    } else {
      var_544768e59992f277 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
      var_cdd8b2d07410aab0 = (var_544768e59992f277 - var_e66474b0ba499331) / level.framedurationseconds;

      if(isDefined(var_bec445e79e2f5b6a)) {
        if(var_bec445e79e2f5b6a - var_cdd8b2d07410aab0 >= 300) {
          truck_land(self.origin, self.angles);
          break;
        }
      }

      var_e66474b0ba499331 = var_544768e59992f277;
      var_bec445e79e2f5b6a = var_cdd8b2d07410aab0;
    }

    waitframe();
  }

  self physics_unregisterforcollisioncallback();
}

function truck_land(position, angles) {
  self.infilling = 0;
  thread function_c1bfb96a5e39a0a7(self);
  thread function_2d381b790dc27f9f(self);
  playFX(getfx("light_tank_land"), position, anglesToForward(angles));
  earthquake(0.3, 0.7, position, 800);
  playrumbleonposition("grenade_rumble", position);
  physicsexplosionsphere(position, 800, 400, 0.5);
}

function parachute_detach_sfx(parachute) {}

function showsplashtoteam(team, splashname) {
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash(splashname, level.teamdata[team]["players"]);
}

function function_9f5606e3bd1c508d(ref, players, delay) {
  if(isDefined(game["dialog"][ref])) {
    assert(isDefined(players) && players.size > 0);
    scripts\mp\gametypes\br_public::brleaderdialog(ref, 0, players, undefined, delay, undefined, "dx_br_bds5_");
  }
}

function function_73bdf8b18e29b13f(players) {
  thread function_664ea636b19a418f(players);
  level.var_6273d0c32535d86e = getdvarint(@ "hash_ec075eaac396b9bb", 0) == 1;
  level.var_eb56e1684153708a = getdvarint(@ "hash_4e6765b5f47964df", 0) == 1;

  foreach(station in level.gasstations) {
    if(!istrue(station.var_6234172895d0c06f)) {
      station setscriptablepartstate(station function_ec5f4851431f3382(), "idle");
    }
  }

  if(istrue(level.var_6273d0c32535d86e)) {
    level thread function_e3327f035a47191b();
  }

  if(!scripts\mp\gametypes\br_gametypes::isfeaturedisabled("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar(@ "hash_6dc954f6c8bf5237", 1);
  }

  scripts\mp\deathicons::removealldeathicons();
  scripts\mp\flags::gameflaginit("trucks_spawn_complete", 0);
  level thread function_9e97f797dc8e211c();
  scripts\mp\flags::gameflagwait("trucks_spawn_complete");

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isalive(player)) {
      player scripts\mp\playerlogic::spawnplayer(0);
    }

    if(istrue(player.br_iseliminated)) {
      scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(player);
    }

    player setclientomnvar("ui_br_infil_started", 1);
    player setclientomnvar("ui_br_infiled", 1);
    player namespace_8bfdb6eb5a3df67a::function_334a8fe67e88bbe7();
    player thread function_8aa3182c50a3094();
  }

  wait 2;
  scripts\mp\flags::gameflagset("prematch_fade_done");

  foreach(player in level.players) {
    player playsoundtoplayer("tw_ac130_flyby", player, player);
  }

  wait 2;
  spawnvehicles();
  assignvehiclestoteams();

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    player thread function_927a1c74689ce55a();
  }

  level thread function_4ec88c05d0625ca0();
  scripts\mp\flags::gameflagset("use_truck_respawn");
}

function function_664ea636b19a418f(players) {}

function function_8aa3182c50a3094() {
  spawnpoint = spawnStruct();
  spawnpoint.origin = level.var_8d137603bd840e40[self.team].origin;
  spawnpoint.height = getdvarint(@ "hash_7b079d61a6a1b553", 3000);
  streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
}

function function_927a1c74689ce55a() {
  scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();

  if(!isalive(self)) {
    scripts\mp\playerlogic::spawnplayer(0);
  }

  if(istrue(self.br_iseliminated)) {
    scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(self);
  }

  vehicle = level.teamvehicles[self.team];

  if(!istrue(vehicle.var_ae21e3bf76862551)) {
    level thread truck_airdrop(vehicle, vehicle.origin, vehicle.angles, 0);
  }

  getspawnpoint(1);
  var_c1763d3130bbe79a = anglesToForward((0, randomint(360), 0));
  offset = getdvarint(@ "hash_152992667994717b", 500);
  height = getdvarint(@ "hash_7b079d61a6a1b553", 3000);
  spawnorigin = self.redeployspawn.origin + var_c1763d3130bbe79a * offset + (0, 0, 1) * height;
  spawnangles = vectortoangles(self.redeployspawn.origin - spawnorigin);

  while(self isinexecutionattack() || self isinexecutionvictim()) {
    waitframe();
  }

  waitframe();
  scripts\cp_mp\armor::givestartingarmor();
  self setOrigin(spawnorigin, 1);
  self setplayerangles(spawnangles);
  thread scripts\mp\gametypes\br_c130::parachute(undefined, 0, undefined, 0);
  namespace_8bfdb6eb5a3df67a::function_e68e4bb4f65f5fe4();
  self.plotarmor = undefined;
  self clearsoundsubmix("mp_br_lobby_fade", 1.5);
  self clearsoundsubmix("deaths_door_mp", 1);
  self notify("do_welcome_splashes");
}

function function_e3327f035a47191b() {
  level.repairstations = [];

  if(istrue(level.var_eb56e1684153708a)) {
    _setdomflagiconinfo("waypoint_repair_station_idle", 1, "neutral", "MP_BR_INGAME/REPAIR_STATION", "ui_mp_br_mapmenu_icon_truckwar_repair_idle", 0);
    _setdomflagiconinfo("waypoint_repair_station_in_use", 1, "neutral", "MP_BR_INGAME/REPAIR_STATION", "ui_mp_br_mapmenu_icon_truckwar_repair_in_use", 0);
  }

  if(getdvarint(@ "hash_e9acc6ac1a49f7c0", 0) != 1) {
    var_757d4d2ce1701811 = getdvarint(@ "hash_b4a41eb239a45bb2", 90000);
    origins = function_da77fee0cba3f65a();

    foreach(origin in origins) {
      station = function_204a1f1178f8ca87(origin, sqrt(var_757d4d2ce1701811));
      station.var_757d4d2ce1701811 = var_757d4d2ce1701811;
      level.repairstations[level.repairstations.size] = station;
    }
  }

  var_757d4d2ce1701811 = getdvarint(@ "hash_15f14ba39b98e2d7", 90000);
  origins = function_d1ecd71915270559();

  foreach(origin in origins) {
    station = function_204a1f1178f8ca87(origin, sqrt(var_757d4d2ce1701811));
    station.var_757d4d2ce1701811 = var_757d4d2ce1701811;
    level.repairstations[level.repairstations.size] = station;
  }

  var_757d4d2ce1701811 = getdvarint(@ "hash_c266f4671f4c6f79", 90000);
  origins = function_b680f9a0df0c0507();

  foreach(origin in origins) {
    station = function_204a1f1178f8ca87(origin, sqrt(var_757d4d2ce1701811));
    station.var_757d4d2ce1701811 = var_757d4d2ce1701811;
    level.repairstations[level.repairstations.size] = station;
  }

  var_757d4d2ce1701811 = getdvarint(@ "hash_a2c43cbb69aa6a83", 90000);
  origins = function_40a9065852fc3b1();

  foreach(origin in origins) {
    station = function_204a1f1178f8ca87(origin, sqrt(var_757d4d2ce1701811));
    station.var_757d4d2ce1701811 = var_757d4d2ce1701811;
    level.repairstations[level.repairstations.size] = station;
  }
}

function _setdomflagiconinfo(name, bgtype, colors, string, image, pulses) {
  level.waypointcolors[name] = colors;
  level.waypointbgtype[name] = bgtype;
  level.waypointstring[name] = string;
  level.waypointshader[name] = image;
  level.waypointpulses[name] = pulses;
}

function function_204a1f1178f8ca87(origin, radius) {
  station = undefined;

  if(istrue(level.var_eb56e1684153708a)) {
    trigger = spawn("trigger_radius", origin, 0, int(radius), int(radius));
    station = scripts\mp\gametypes\obj_dom::setupobjective(trigger);
    station.pinobj = 0;
    station scripts\mp\gameobjects::allowuse("none");
    station.flagmodel hide();
    scripts\mp\objidpoolmanager::update_objective_position(station.objidnum, station.curorigin + (0, 0, 60));
    function_865f9c5d005f9a08(station.objidnum, 1);
    station scripts\mp\gameobjects::setobjectivestatusicons("waypoint_repair_station_idle");
  } else {
    station = spawnscriptable("truckwar_repair_station", origin, (0, 0, 1));
  }

  station.inuse = 0;
  station.inuseprev = 0;
  return station;
}

function function_da77fee0cba3f65a() {
  origins = [];

  if(level.mapname == "mp_br_mechanics") {
    origins[origins.size] = (1850, -50, 0);
  } else if(level.mapname == "mp_don4") {
    origins[origins.size] = (-18964, -22238, -165);
    origins[origins.size] = (5507, -29862, 62);
    origins[origins.size] = (-21604, 1168, -254);
    origins[origins.size] = (-6975, 19920, -262);
    origins[origins.size] = (-28578, 46653, 2746);
    origins[origins.size] = (-3099, 56987, 678);
    origins[origins.size] = (19946, 3582, -390);
    origins[origins.size] = (16578, -22869, -146);
    origins[origins.size] = (46055, 24809, -342);
  } else {
    origins[origins.size] = (-18964, -22238, -165);
    origins[origins.size] = (5507, -29862, 62);
    origins[origins.size] = (-21604, 1168, -254);
    origins[origins.size] = (-6975, 19920, -262);
    origins[origins.size] = (-28578, 46653, 2746);
    origins[origins.size] = (-3080, 56856, 678);
    origins[origins.size] = (19946, 3582, -390);
    origins[origins.size] = (16578, -22869, -146);
    origins[origins.size] = (46055, 24809, -342);
  }

  return origins;
}

function function_d1ecd71915270559() {
  origins = [];

  if(level.mapname == "mp_don4") {
    origins[origins.size] = (-30563, 3055, -232);
    origins[origins.size] = (-21165, -15396, -246);
    origins[origins.size] = (-27563, -2557, -256);
    origins[origins.size] = (-22268, -27419, -82);
    origins[origins.size] = (-9895, -34131, 218);
    origins[origins.size] = (10254, -20711, -231);
    origins[origins.size] = (4552, -14424, -229);
    origins[origins.size] = (-11881, 1482, -262);
    origins[origins.size] = (-18095, 6481, -262);
    origins[origins.size] = (10306, 14001, -270);
    origins[origins.size] = (17112, 2074, -534);
    origins[origins.size] = (33549, 26531, 627);
    origins[origins.size] = (44925, 17451, -308);
    origins[origins.size] = (45326, -265, 20);
    origins[origins.size] = (5317, 24973, 50);
    origins[origins.size] = (47951, -9453, 154);
  } else {
    origins[origins.size] = (-30563, 3055, -232);
    origins[origins.size] = (-21165, -15396, -246);
    origins[origins.size] = (-27563, -2557, -256);
    origins[origins.size] = (-22268, -27419, -82);
    origins[origins.size] = (-9895, -34131, 218);
    origins[origins.size] = (10254, -20711, -231);
    origins[origins.size] = (4552, -14424, -229);
    origins[origins.size] = (-11881, 1482, -262);
    origins[origins.size] = (-18095, 6481, -262);
    origins[origins.size] = (10306, 14001, -270);
    origins[origins.size] = (17112, 2074, -534);
    origins[origins.size] = (33549, 26531, 627);
    origins[origins.size] = (44925, 17451, -308);
    origins[origins.size] = (45326, -265, 20);
  }

  return origins;
}

function function_b680f9a0df0c0507() {
  origins = [];

  if(level.mapname == "mp_don4") {
    origins[origins.size] = (15625, 36254, 1510);
    origins[origins.size] = (28400, 39129, 762);
    origins[origins.size] = (-7544, 33510, -10);
    origins[origins.size] = (25786, 20693, 1383);
    origins[origins.size] = (-13791, 46397, 1833);
    origins[origins.size] = (3195, 50010, 1120);
    origins[origins.size] = (-24770, 34814, 390);
    origins[origins.size] = (-4988, 16480, -214);
  } else {
    origins[origins.size] = (15625, 36254, 1510);
    origins[origins.size] = (28400, 39129, 762);
    origins[origins.size] = (-7544, 33510, -10);
    origins[origins.size] = (26074, 20938, 1384);
    origins[origins.size] = (-13791, 46397, 1833);
    origins[origins.size] = (3195, 50010, 1120);
    origins[origins.size] = (-24770, 34814, 390);
    origins[origins.size] = (-4988, 16480, -214);
  }

  return origins;
}

function function_40a9065852fc3b1() {
  origins = [];

  if(level.mapname == "mp_don4") {
    origins[origins.size] = (18940, -24914, -199);
    origins[origins.size] = (13021, -35175, -422);
    origins[origins.size] = (37931, -30644, -513);
    origins[origins.size] = (54024, -23960, -83);
  } else {
    origins[origins.size] = (18940, -24914, -199);
    origins[origins.size] = (13021, -35175, -422);
    origins[origins.size] = (37931, -30644, -513);
    origins[origins.size] = (54024, -23960, -83);
  }

  return origins;
}

function function_4ec88c05d0625ca0() {
  if(!istrue(level.var_6273d0c32535d86e)) {
    return;
  }

  repairpct = getdvarfloat(@ "hash_e7c32b801c5b43a2", 0.025);
  repairinterval = getdvarfloat(@ "hash_9e06adb574328430", 1);

  while(true) {
    foreach(station in level.repairstations) {
      station.var_59e9b68f790a1ef1 = 0;
    }

    foreach(team, truck in level.teamvehicles) {
      if(!isDefined(truck)) {
        continue;
      }

      washealing = istrue(truck.healing);
      anyinrange = 0;

      foreach(station in level.repairstations) {
        distsq = distancesquared(truck.origin, ter_op(isDefined(station.origin), station.origin, station.curorigin));

        if(distsq < station.var_757d4d2ce1701811) {
          station markinuse();
          station.var_59e9b68f790a1ef1 = 1;
          anyinrange = 1;

          if(istrue(truck.healingblocked)) {
            continue;
          }

          if(truck.health == truck.maxhealth) {
            continue;
          }

          truck.healing = 1;

          if(!washealing) {
            function_256806bcfdf38c83(team);
          }

          var_6f17073f208628d6 = int(repairpct * truck.maxhealth);
          truck scripts\cp_mp\vehicles\vehicle_damage::function_653b96ce8310763e(var_6f17073f208628d6);
          players = getteamdata(team, "players");

          foreach(player in players) {
            if(getdvarint(@ "hash_38d15e2d7ddbf066", 0) == 1) {
              player scripts\cp_mp\damagefeedback::hudicontype("truckheal");
            }

            player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", truck.health);
            player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", truck.maxhealth);
          }

          break;
        }
      }

      if(washealing && !anyinrange) {
        truck.healing = 0;
        function_256806bcfdf38c83(team);
      }
    }

    foreach(station in level.repairstations) {
      if(!station.var_59e9b68f790a1ef1) {
        station markidle();
      }
    }

    wait repairinterval;
  }
}

function markinuse() {
  self.inuseprev = self.inuse;
  self.inuse = 1;

  if(self.inuse != self.inuseprev) {
    if(istrue(level.var_eb56e1684153708a)) {
      scripts\mp\gameobjects::setobjectivestatusicons("waypoint_repair_station_in_use");
    }
  }
}

function markidle() {
  self.inuseprev = self.inuse;
  self.inuse = 0;

  if(self.inuse != self.inuseprev) {
    if(istrue(level.var_eb56e1684153708a)) {
      scripts\mp\gameobjects::setobjectivestatusicons("waypoint_repair_station_idle");
    }
  }
}

function private function_e501cce5c715caf() {
  var_5cb3866995416341 = getdvarint(@ "hash_856015437dc2f753", 5);

  if(var_5cb3866995416341 > level.br_level.br_circleclosetimes.size - 1) {
    var_5cb3866995416341 = level.br_level.br_circleclosetimes.size - 1;
  }

  return var_5cb3866995416341;
}

function function_8d947898c35b8068() {
  level endon("game_ended");
  level.var_24380db31e302a78 = 0;
  level waittill("infils_ready");
  var_5cb3866995416341 = function_e501cce5c715caf();
  var_2948ca54731de34f = 0;

  for(i = 0; i < var_5cb3866995416341 - 1; i++) {
    var_2948ca54731de34f += level.br_level.br_circleclosetimes[i];
    var_2948ca54731de34f += level.br_level.br_circledelaytimes[i];
  }

  endtimems = gettime() + var_2948ca54731de34f * 1000;
  setomnvar("ui_gulag_timer", int(endtimems));

  while(true) {
    level waittill("br_circle_set");

    if(level.br_circle.circleindex == var_5cb3866995416341) {
      scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("truckwar_spawn_disabled", level.players);
      thread function_9f5606e3bd1c508d("vehicle_spawn_over", level.players);
      level.var_24380db31e302a78 = 1;
      setomnvar("ui_gulag_timer", 0);
      break;
    }
  }
}

function function_6de134dad6c879cf() {
  level endon("<dev string:x85>");
  testplayer = undefined;

  foreach(player in level.players) {
    if(isDefined(player)) {
      testplayer = player;
      break;
    }
  }

  testdvar = @ "hash_419dc795b2a889e0";
  setdevdvarifuninitialized(testdvar, 0);

  while(true) {
    if(getdvarint(testdvar, 0) == 0) {
      waitframe();
      continue;
    }

    playervehicle = testplayer scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(playervehicle) && !istrue(playervehicle.radaron)) {
      function_2b6f04cb613a01e8(playervehicle);
    }

    waitframe();
  }
}

function alternatebrcircle() {
  curradius = level.var_a02389e5d5497129;
  level.br_level.br_circleclosetimes = [level.var_837cd01dc6486d8c];
  level.br_level.br_circledelaytimes = [level.var_15415172069d735f];
  level.br_level.br_circleshowdelaydanger = [1];
  var_8a0c6190284443b7 = level.br_level.br_circleminimapradii;
  tempradii = ter_op(isDefined(level.var_5a41c5287237c308), level.var_5a41c5287237c308, level.br_level.br_circleradii);

  if(level.var_e12122c5431959b5) {
    level.br_level.br_circleshowdelaysafe = [0];
    level.br_level.br_circleminimapradii = [var_8a0c6190284443b7[0]];
    level.br_level.br_circleradii = [tempradii[0], tempradii[tempradii.size - 1]];
  } else {
    level.br_level.br_circleshowdelaysafe = [0];
    level.br_level.br_circleminimapradii = [int(curradius / 2)];
    level.br_level.br_circleradii = [curradius, curradius];
  }

  setDvar(@ "hash_2499127213b409af", level.var_944b40a215902330);
  circleradius = [];
  circleclosetime = [];
  delaytime = [];
  minimapradius = [];
  closetimer = level.var_e182232b582aa5d6;
  delaytimer = level.var_f28e1ed7f6adf52d;

  for(i = 1; i < level.var_944b40a215902330; i++) {
    if(level.var_e12122c5431959b5) {
      size = ter_op(i + 1 < tempradii.size - 1, tempradii[i], tempradii[tempradii.size - 2]);
      minimapsize = ter_op(i + 1 < var_8a0c6190284443b7.size - 1, var_8a0c6190284443b7[i], var_8a0c6190284443b7[var_8a0c6190284443b7.size - 2]);
      circleradius[circleradius.size] = size;
      minimapradius[minimapradius.size] = minimapsize;
    } else {
      circleradius[circleradius.size] = 57300;
      minimapradius[minimapradius.size] = 10500;
    }

    if(isDefined(level.var_3d86f613dc0bfa16)) {
      index = ter_op(level.var_3d86f613dc0bfa16.size <= i, level.var_3d86f613dc0bfa16.size - 1, i);
      closetimer = level.var_3d86f613dc0bfa16[index];
    } else {
      closetimer = max(level.var_886566e69ee53d98, closetimer - level.var_411ce67dc4849722);
    }

    if(isDefined(level.var_dc008290077a7185)) {
      index = ter_op(level.var_dc008290077a7185.size <= i, level.var_dc008290077a7185.size - 1, i);
      delaytimer = level.var_dc008290077a7185[index];
    } else {
      delaytimer = max(level.var_4d77d157099cf459, delaytimer - level.var_84f1c23ed82e4ec5);
    }

    circleclosetime[circleclosetime.size] = closetimer;
    delaytime[delaytime.size] = delaytimer;
  }

  scripts\mp\gametypes\br_circle::extendcirclelist(circleradius, circleclosetime, delaytime, minimapradius);
}

function function_d4864f0577158363() {
  level endon("game_ended");
  variance = getdvarint(@ "hash_35ac52b0e7e835aa", 10000);
  xoffset = randomfloatrange(variance * -1, variance);
  yoffset = randomfloatrange(variance * -1, variance);
  level.br_level.br_circlecenters[0] = level.br_level.br_mapcenter + (xoffset, yoffset, 0);
  level.br_level.br_circlecenters[1] = level.br_level.br_mapcenter + (xoffset, yoffset, 0);

  if(getdvarint(@ "hash_869eba038d752c6e", 1) == 1) {
    for(i = 2; i < level.br_level.br_circlecenters.size - 1; i++) {
      function_a7efa595a4c994c(i);
    }

    return;
  }

  while(true) {
    level waittill("br_circle_set");
    function_a7efa595a4c994c();
  }
}

function function_a7efa595a4c994c(index) {
  if(!isDefined(index)) {
    index = level.br_circle.circleindex + 1;
  }

  if(level.br_level.br_circlecenters.size <= index || !istrue(level.var_af6ec941d2b4e283)) {
    return;
  }

  var_d303e81057b8a554 = level.br_level.br_circlecenters[index];
  nextcircledistance = level.br_level.br_circleradii[index - 1] * level.var_6d02a364e8331928;
  randompoint = scripts\mp\gametypes\br_circle::getrandompointinboundscircle(var_d303e81057b8a554, nextcircledistance, 0.8, 1, 1, 0, 1);
  circledirection = vectorNormalize(randompoint - var_d303e81057b8a554) * nextcircledistance;
  newcenter = var_d303e81057b8a554 + circledirection;

  if(getdvarint(@ "hash_668d5b4706735002", 1) == 1 && !scripts\mp\gametypes\br_circle::isvalidpointinbounds(newcenter, 1)) {
    newcenter = var_d303e81057b8a554 - circledirection;
  }

  searchdistance = getdvarint(@ "hash_5664da3ca3493f97", 10000);
  tocenter = vectorNormalize(level.br_level.br_mapcenter - newcenter);
  contents = physics_createcontents(["physicscontents_trigger"]);

  for(trace = scripts\engine\trace::ray_trace_ents(var_d303e81057b8a554, newcenter, level.outofboundstriggers, contents); !scripts\mp\gametypes\br_circle::isvalidpointinbounds(newcenter, 1) || trace["fraction"] < 1; trace = scripts\engine\trace::ray_trace_ents(var_d303e81057b8a554, newcenter, level.outofboundstriggers, contents)) {
    newcenter += tocenter * searchdistance;
  }

  level.br_level.br_circlecenters[index + 1] = newcenter;
}

function function_1e7c5cadd2c12a32(pt) {
  bounds = level.br_level.br_mapbounds;
  pad = level.var_be52f2d0dee6b894;
  inmapbounds = pt[0] < bounds[0][0] * pad && pt[0] > bounds[1][0] * pad && pt[1] < bounds[0][1] * pad && pt[1] > bounds[1][1] * pad;
  return inmapbounds;
}

function checkdangerradius(point, time) {
  safecircleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  safecircleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_29d5d9f11d8593c1 = safecircleorigin - point;
  var_e1261bd8c0a31088 = distance2d(safecircleorigin, point);

  if(var_e1261bd8c0a31088 < safecircleradius) {
    return 0;
  }

  translationdist = 0;
  translationvec = (0, 0, 0);
  translationvelocity = 0;
  shrinkdist = 0;
  shrinkvec = 0;
  shrinkvelocity = 0;
  closetime = level.br_level.br_circleclosetimes[level.br_circle.circleindex];

  if(level.br_circle.circleindex > 0) {
    var_fb0f5a7f828190b1 = level.br_level.br_circlecenters[level.br_circle.circleindex];
    translationdist = distance2d(safecircleorigin, var_fb0f5a7f828190b1);
    translationvec = vectorNormalize(safecircleorigin - var_fb0f5a7f828190b1);
  }

  translationvelocity = translationdist / closetime;
  previousradii = level.br_level.br_circleradii[level.br_circle.circleindex];
  shrinkdist = previousradii - safecircleradius;
  shrinkvec = vectorNormalize(var_29d5d9f11d8593c1);
  shrinkvelocity = shrinkdist / closetime;
  testpoint = point + translationvec * -1 * time * translationvelocity + shrinkvec * -1 * time * shrinkvelocity;
  return scripts\mp\gametypes\br_circle::function_24c5a8d31ae262f(testpoint);
}

function function_c1bfb96a5e39a0a7(vehicle) {
  vehicle endon("death");

  while(true) {
    vehicle waittill("give_upgrade", upgradetype);

    switch (upgradetype) {
      case #"hash_25789111b74943b4":
        function_22f556fab80598eb(vehicle);
        break;
      case #"hash_13d1f84d0ae96a5f":
        function_852abb774ff2a90e(vehicle);
        break;
      case #"hash_c59e6484a3367f4":
        function_8f4da0f65951c0b(vehicle);
        break;
      case #"hash_634b246c3da5c56f":
        function_2b6f04cb613a01e8(vehicle);
        break;
      case #"hash_27cab410c0232a31":
        function_60fde27c0dd8510(vehicle);
        break;
      case #"hash_d4850e4dfbc48417":
        function_e8779dce7e960d56(vehicle);
        break;
      case #"hash_d8f795eb14c75e6":
        function_3cf1ac037cdbc2a5(vehicle);
        break;
      case #"hash_ec69fbee2cad5b9b":
        function_ab77860b63be6da6(vehicle);
        break;
    }
  }
}

function function_22f556fab80598eb(vehicle) {
  function_e9b1e17b0d0ba3(vehicle);
  vehicle.var_4f3e23ee48660f12 = 1;
  vehicle notify("upgrade_message", "armor_upgraded");
  playsoundatpos(vehicle.origin + (0, 0, 20), "veh_truckwars_add_armor");
}

function function_e9b1e17b0d0ba3(vehicle) {
  armor = ["tag_armor_body_back_01", "tag_armor_body_back_02", "tag_armor_body_back_03", "tag_armor_body_back_04", "tag_armor_body_back_05", "tag_armor_body_back_06", "tag_armor_body_back_07", "tag_armor_body_back_08", "tag_armor_body_back_09", "tag_armor_body_back_10", "tag_armor_body_back_11", "tag_armor_body_back_12", "tag_armor_body_left_01", "tag_armor_body_left_02", "tag_armor_body_left_03", "tag_armor_body_left_04", "tag_armor_body_left_05", "tag_armor_body_left_06", "tag_armor_body_left_07", "tag_armor_body_left_08", "tag_armor_body_left_09", "tag_armor_body_left_10", "tag_armor_body_left_11", "tag_armor_body_right_01", "tag_armor_body_right_02", "tag_armor_body_right_03", "tag_armor_body_right_04", "tag_armor_body_right_05", "tag_armor_body_right_06", "tag_armor_body_right_07", "tag_armor_body_right_08", "tag_armor_body_right_09", "tag_armor_body_right_10", "tag_armor_body_right_11", "tag_armor_bumper_back", "tag_armor_bumper_front", "tag_armor_cabin_front_01", "tag_armor_cabin_front_02", "tag_armor_cabin_front_03", "tag_armor_cabin_front_04", "tag_armor_cabin_front_05", "tag_armor_cabin_front_06", "tag_armor_cabin_front_07", "tag_armor_cabin_front_09", "tag_armor_cabin_left_01", "tag_armor_cabin_left_02", "tag_armor_cabin_left_03", "tag_armor_cabin_left_04", "tag_armor_cabin_left_05", "tag_armor_cabin_right_01", "tag_armor_cabin_right_02", "tag_armor_cabin_right_03", "tag_armor_cabin_right_04", "tag_armor_cabin_right_05", "tag_armor_cabin_top", "tag_armor_door_left", "tag_armor_door_right", "tag_armor_wheel_back_left", "tag_armor_wheel_back_right", "tag_armor_wheel_front_left", "tag_armor_wheel_front_right", "tag_armor_wheel_middle1_left", "tag_armor_wheel_middle1_right", "tag_armor_wheel_middle2_left", "tag_armor_wheel_middle2_right", "tag_armor_wheel_middle2_right"];

  foreach(tag in armor) {
    scripts\cp_mp\vehicles\vehicle_damage::function_963f1cb109b9c186(vehicle, tag);
  }
}

function function_35f2ff0427594776(vehicle) {
  doors = ["tag_door_front_left", "tag_door_front_right", "tag_windshield_front"];

  foreach(tag in doors) {
    scripts\cp_mp\vehicles\vehicle_damage::function_963f1cb109b9c186(vehicle, tag);
  }

  scripts\cp_mp\vehicles\vehicle_damage::function_9ae605ed3dc3bd1(vehicle);
}

function function_852abb774ff2a90e(vehicle) {
  if(scripts\engine\utility::issharedfuncdefined("vehicle_trophy", "init")) {
    var_d9a1da35dbde5e4f = scripts\engine\utility::getsharedfunc("vehicle_trophy", "init");
    vehicle.trophyammo = 3;
    vehicle.isdisabled = 0;
    vehicle thread[[var_d9a1da35dbde5e4f]](72, 280900, &function_9f13cc66529c6e8f, &trophy_protectionsuccessful);

    if(scripts\engine\utility::issharedfuncdefined("vehicle_trophyCreateExplosion", "init")) {
      vehicle.explosion = [[scripts\engine\utility::getsharedfunc("vehicle_trophyCreateExplosion", "init")]](vehicle);
    }

    vehicle notify("upgrade_message", "trophy_activated");
  }
}

function function_8f4da0f65951c0b(vehicle) {
  vehicle.trophyammo = 3;
  vehicle.isdisabled = 0;
  vehicle notify("upgrade_message", "trophy_ammo_refill");
}

function function_9f13cc66529c6e8f() {
  return true;
}

function trophy_protectionsuccessful(trophytarget) {
  explorigin = trophytarget.origin;

  if(scripts\engine\utility::issharedfuncdefined("vehicle_trophyDestroyTarget", "init")) {
    [[scripts\engine\utility::getsharedfunc("vehicle_trophyDestroyTarget", "init")]](trophytarget);
  }

  tag = "tag_origin";
  var_1331aefd6d9a100 = vectortoangles(self gettagorigin(tag) - explorigin);
  var_cc29543de9737588 = combineangles(var_1331aefd6d9a100, (-90, 0, 0));

  if(scripts\engine\utility::issharedfuncdefined("vehicle_trophyExplode", "init")) {
    self.explosion thread[[scripts\engine\utility::getsharedfunc("vehicle_trophyExplode", "init")]](explorigin, var_cc29543de9737588);
  }

  if(self.trophyammo > 0) {
    self.trophyammo--;
  }

  if(self.trophyammo == 0) {
    self.isdisabled = 1;
    self notify("upgrade_message", "trophy_no_ammo");
  }
}

function function_2b6f04cb613a01e8(vehicle) {
  vehicle thread function_8f5f2701e3cb8e9c();
  vehicle notify("upgrade_message", "uav_activated");
}

function function_8f5f2701e3cb8e9c() {
  self endon("death");
  radius = getdvarint(@ "hash_bc348a829ed932", 12000);
  time = getdvarint(@ "hash_4523720be81f63ad", 5);
  timems = time * 1000;

  while(true) {
    triggerportableradarpingteam(self.origin, self.team, radius, timems);
    wait time;
  }
}

function function_60fde27c0dd8510(vehicle) {
  turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(vehicle, "iw9_mg_mrap_mp");
  turret function_8f6d35f8c518e9a0(getdvarfloat(@ "hash_6b8ca746928c55dd", 0.07));
  turret function_ec33a72c0cb03aa6(getdvarfloat(@ "hash_8282dfac90ba34d7", 0.35));
  vehicle notify("upgrade_message", "barrel_activated");
}

function function_e8779dce7e960d56(vehicle) {
  spawndata = spawnStruct();

  if(isDefined(vehicle.var_fadc8ce0c904abda)) {
    spawndata.skinoverride = vehicle.var_fadc8ce0c904abda;
  }

  if(scripts\engine\utility::issharedfuncdefined("veh9_mil_lnd_mrap", "createGrenadeTurret")) {
    turret = [[scripts\engine\utility::getsharedfunc("veh9_mil_lnd_mrap", "createGrenadeTurret")]](vehicle, spawndata);
    scripts\cp_mp\vehicles\vehicle::vehicle_registerturret(vehicle, turret, makeweapon("iw9_tur_mrap_mp"));
    vehicle.occupantsreserving["gunner"] = undefined;
    vehicle.var_65da0a245b653cc = undefined;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(vehicle);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(vehicle);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
  }

  vehicle notify("upgrade_message", "grenade_turret_activated");
}

function function_3cf1ac037cdbc2a5(vehicle) {
  vehicle.var_ec76ffdbe2f37c5b = 0;
  vehicle.var_9cd07317ba52df4 = 1;
  vehicle notify("upgrade_message", "smoke_activated");
}

function function_ab77860b63be6da6(vehicle) {
  vehicle vehicle_settopspeedforward(42);
  vehicle.fuelmultiplier = 0.5;
  vehicle notify("upgrade_message", "engine_activated");
}

function function_5b776e8c62234d00() {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.radar)) {
    self.radar delete();
  }
}

function function_5fd118f91ae96e57(vehicle) {
  spawnorigin = vehicle gettagorigin("tag_screen_left");
  buystation = spawn("script_model", spawnorigin);
  buystation linkTo(vehicle, "tag_screen_left");
  buystation.index = 1;
  buystation.overrideindex = 10;
  buystation.playersusing = [];
  buystation.var_114e759371623080 = 1;
  vehicle.buystation = buystation;
}

function function_fe081d074870c23d(instance, part, state, player, bautouse, usestring) {
  player.var_c77002478cdfd85f = level.teamvehicles[player.team];
  buystation = level.teamvehicles[player.team].buystation;
  buystation.playersusing[buystation.playersusing.size] = player;
  player thread scripts\mp\gametypes\br_armory_kiosk::_runpurchasemenu(buystation);
}

function function_2d381b790dc27f9f(vehicle) {
  vehicle endon("death");

  while(true) {
    function_256806bcfdf38c83(vehicle.team);
    wait 0.1;
  }
}

function function_256806bcfdf38c83(team, player) {
  vehicle = level.teamvehicles[team];
  omnvarvalue = 0;

  if(isDefined(vehicle) && !istrue(vehicle.isdestroyed)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::function_97c32f66eff29610(vehicle, "uav")) {
      omnvarvalue += 1;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::function_97c32f66eff29610(vehicle, "armor")) {
      omnvarvalue += 2;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::function_97c32f66eff29610(vehicle, "trophy")) {
      omnvarvalue += 4;
      omnvarvalue += vehicle.trophyammo << 3;

      if(isDefined(vehicle.trophyammo) && vehicle.trophyammo == 3) {
        omnvarvalue += 32;
      }
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::function_97c32f66eff29610(vehicle, "barrel")) {
      omnvarvalue += 64;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::function_97c32f66eff29610(vehicle, "turret")) {
      omnvarvalue += 128;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::function_97c32f66eff29610(vehicle, "smoke")) {
      omnvarvalue += 256;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::function_97c32f66eff29610(vehicle, "engine")) {
      omnvarvalue += 512;
    }

    if(vehicle.health == vehicle.maxhealth) {
      omnvarvalue += 8192;
    } else if(!vehicle scripts\cp_mp\vehicles\vehicle_interact::function_fc271f387096702f()) {
      omnvarvalue += 2048;
    } else if(isDefined(vehicle.refuelingpercentage)) {
      omnvarvalue += 4096;
    }

    if(istrue(vehicle.flipped)) {
      omnvarvalue += 16384;
    }
  } else if(function_81c029669130c0d4(team)) {
    omnvarvalue += 32768;
  } else {
    omnvarvalue += 1024;
  }

  healthvalue = 0;
  fuelvalue = 0;

  if(isDefined(vehicle)) {
    healthvalue = clamp(vehicle.health / vehicle.maxhealth, 0, 1);
    fuelvalue = clamp(vehicle.fuel / level.var_c7b9749bcc6a6207, 0, 1);
  }

  if(isDefined(player)) {
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_armored_truck_status", omnvarvalue);
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_armored_truck_health", healthvalue);
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_armored_truck_fuel", fuelvalue);
    return;
  }

  players = getteamdata(team, "players");

  foreach(p in players) {
    p scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_armored_truck_status", omnvarvalue);
    p scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_armored_truck_health", healthvalue);
    p scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_armored_truck_fuel", fuelvalue);
  }
}

function function_de1ac98379235d8b(itemname, var_1de514083a2fbc8d) {
  if(!isDefined(var_1de514083a2fbc8d)) {
    return undefined;
  }

  player = self;
  assertex(isDefined(player));
  stock = 0;
  upgradestring = "";

  switch (itemname) {
    case #"hash_816539877a1d1fdc":
      upgradestring = "armor";
      break;
    case #"hash_ad9b9dd5f299d159":
      upgradestring = "barrel";
      break;
    case #"hash_72146e01d3915d7":
      upgradestring = "uav";
      break;
    case #"hash_7f669e169bdba303":
      upgradestring = "engine";
      break;
    case #"hash_b7d856499be19287":
      upgradestring = "turret";
      break;
    case #"hash_f7b4d170b800b77e":
      upgradestring = "smoke";
      break;
    case #"hash_1bbe99c97bde7d67":
      upgradestring = "trophy";
      break;
  }

  if(upgradestring != "") {
    vehicle = level.teamvehicles[player.team];

    if(!isDefined(vehicle)) {
      return undefined;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::function_97c32f66eff29610(vehicle, upgradestring)) {
      return 0;
    } else {
      return 1;
    }

    return;
  }

  return var_1de514083a2fbc8d;
}

function function_59566a4ce3c2c3e2() {
  return getdvarint(@ "hash_9e315c398cde8b75", 1);
}

function function_60d5992f51286201(team) {
  if(!isDefined(self) || !isDefined(self.team)) {
    return 0;
  }

  team = self.team;

  if(!isDefined(level.vehicledrop)) {
    level.vehicledrop = [];
  }

  level.vehicledrop[self.team] = 1;
  function_256806bcfdf38c83(self.team, self);

  if(function_59566a4ce3c2c3e2()) {
    thread function_7106da00352cd1e0();
  }
}

function function_81c029669130c0d4(team) {
  if(!isDefined(team)) {
    if(!isDefined(self) || !isDefined(self.team)) {
      return false;
    }

    team = self.team;
  }

  if(!isDefined(level.vehicledrop)) {
    return false;
  }

  return istrue(level.vehicledrop[team]);
}

function function_d5d633c35998ebe7(team) {
  if(!isDefined(team)) {
    return 0;
  }

  level.vehicledrop[team] = undefined;
  function_256806bcfdf38c83(team);
}

function function_7106da00352cd1e0() {
  level endon("game_ended");
  self endon("vehicle_drop_success");

  if(!isDefined(self) || !isDefined(self.team)) {
    return;
  }

  team = self.team;
  level notify("monitor_death_for_airdrop_" + team);
  level endon("monitor_death_for_airdrop_" + team);
  self waittill("death_or_disconnect");
  function_d5d633c35998ebe7(team);
}

function function_8d45ff943de1cfc4() {
  level.br_standard_loadout = function_93e3d45fc14694a2();
  noextraammo = function_9577fcf1998c53b7();
  scripts\mp\gametypes\br::givestandardtableloadout(0, 1, noextraammo);

  if(!isDefined(self.equipment) || !isDefined(self.equipment["health"])) {
    scripts\cp_mp\armor::function_be5c0cdfa0202544();
  }

  return false;
}

function function_93e3d45fc14694a2() {
  loadout = level.br_standard_loadout;

  if(isDefined(level.var_c04b5edf3f9ea340)) {
    circleindex = 0;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      circleindex = min(level.br_circle.circleindex, level.var_c04b5edf3f9ea340.size);
      circleindex = int(circleindex);
    }

    if(isDefined(level.var_77c121d31e587ba8[circleindex])) {
      loadout = level.var_c04b5edf3f9ea340[circleindex][level.var_77c121d31e587ba8[circleindex]];
    }
  }

  return loadout;
}

function function_9577fcf1998c53b7() {
  noextraammo = 0;

  if(isDefined(level.var_c04b5edf3f9ea340)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      if(level.br_circle.circleindex == level.var_c04b5edf3f9ea340.size - 1) {
        noextraammo = 1;
      }
    }
  }

  return noextraammo;
}

function function_81124b7b16101f8b() {
  var_fb932f46ef5ec56 = scripts\mp\utility\game::getsubgametype() == "truckwar";

  if(!var_fb932f46ef5ec56) {
    return;
  }

  var_13d86b0aea4f84af = scripts\mp\gametypes\br_gametype_truckwar::function_59566a4ce3c2c3e2();

  if(var_13d86b0aea4f84af) {
    if(function_6e4f7e117d4651c3()) {
      return 0;
    }
  }

  if(!function_d48c5142f8271c18()) {
    return 0;
  }

  return 1;
}

function function_6e4f7e117d4651c3() {
  player = self;
  squad = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(squadmate in squad) {
    if(isDefined(squadmate)) {
      superref = squadmate scripts\mp\supers::getcurrentsuperref();

      if(isDefined(superref) && superref == "super_vehicle_drop") {
        if(squadmate getammocount(squadmate.super.staticdata.weapon) > 0) {
          return true;
        }

        continue;
      }

      if(squadmate namespace_aead94004cf4c147::function_36b1968bfe78916b(9245)) {
        return true;
      }
    }
  }

  if(isDefined(level.var_e3ccf0898a949bec) && istrue(level.var_e3ccf0898a949bec[player.team])) {
    return true;
  }

  return false;
}

function function_d48c5142f8271c18() {
  if(scripts\mp\gametypes\br_gametype_truckwar::function_81c029669130c0d4()) {
    return false;
  }

  if(isDefined(level.teamvehicles) && !isDefined(level.teamvehicles[self.team])) {
    return true;
  }

  return false;
}