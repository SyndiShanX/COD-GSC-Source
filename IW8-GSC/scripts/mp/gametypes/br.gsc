/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br.gsc
***********************************************/

function main() {
  level.ref_14434 = 1;
  level.nobroshot = 1;
  level.clearstockondrop = 1;
  level.loadoutdefaultfiresalediscount = 1;
  level.armoronweaponswitchlongpress = 1;
  level.iscacprimaryweapongroup = 1;
  level.noweaponfalloff = 0;
  level.half_size = 2;
  level.vehicle_occupancy_forceweaponswitchallowed = 1;
  level.client_activate = 0;
  level.debug_safehouse_regroup_start = getdvarint("scr_br_allowLoadout", 0);
  level.debug_show2dvotext = getdvarint("scr_br_allowLoadoutOnlyInPreLobby", 0);
  level.delay_spawn_room_soldiers = getdvarint("scr_br_meleefinisher_clamp", 0);
  level.delay_spawn_tanks = getdvarint("scr_br_meleefinisher_damage", 120);
  level.deletehistoryhud = getdvarfloat("scr_br_s4shotgun_scalar", 1);
  level.deletecrateimmediate = getdvarfloat("scr_br_s4pistol_scalar", 1);
  level.deleteallglass = getdvarint("scr_br_remove_stimregen_onhit", 0);
  level.deleteable = getdvarint("scr_br_remove_natregen_onhit", 1);
  level.deletescriptableinstanceaftertime_proc = getdvarint("scr_br_stim_cancel_threshold", 1);
  level.deletesecretstashhud = getdvarfloat("scr_br_stim_movespeed_scalar", 1.2);
  level.delay_show_balloon = getdvarint("scr_br_me_proj_head_dmg", 300);
  level.delay_show_marker_to_tv_station = getdvarint("scr_br_me_proj_neck_dmg", 300);
  level.delay_spawn_nav_repulsor = getdvarint("scr_br_me_proj_utorso_dmg", 300);
  level.delay_show_player_clip = getdvarint("scr_br_me_proj_uarm_dmg", 300);
  level.br_sniper_fixed_hs_damage = getdvarint("scr_br_fixed_sniper_hsdmg", 0);
  level.br_speedboost_pickup_enabled = getdvarint("scr_br_speedboost_pickup_enable", 1);
  level.decide_new_code = getdvarint("scr_br_circle_frailty_enabled", 0);

  if(level.decide_new_code == 1) {
    level.decoy_clearaithreatbiasgroup = getdvarfloat("scr_player_gas_timer_mult_time_1", 60);
    level.decoy_giveassistpoint = getdvarfloat("scr_player_gas_timer_mult_time_2", 90);
    level.decoy_delaystoptrackingassist = getdvarfloat("scr_player_gas_timer_mult_time_3", 120);
    level.decoy_aicanseeanyplayer = getdvarfloat("scr_br_circle_frailty_multi_1", 1.1);
    level.decoy_canseeplayer = getdvarfloat("scr_br_circle_frailty_multi_2", 1.2);
    level.decoy_aiseenplayerrecently = getdvarfloat("scr_br_circle_frailty_multi_3", 1.3);
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(level.br_speedboost_pickup_enabled == 1) {
    _keypadscriptableused_bunkeralt::init();
    _keypadscriptableused::init();
    scripts\mp\utility\sound::besttime("mp_tu_canteen_sfx");
  }

  setdvarifuninitialized("wsow_event_dvar_hot_reload", 0);
  scripts\mp\gametypes\br_gametypes::init();

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("allowLateJoiners")) {
    level.brkillchainchance = 1;
  }

  level.defend_spawn_crates = getdvarint("scr_br_death_watch", 1.5);
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function ref_12803() {
  scripts\mp\gametypes\br_alt_mode_inflation::init();
  thread scripts\mp\gametypes\br_zones::init();
  thread scripts\mp\gametypes\br_c130airdrop::init();
  thread scripts\mp\gametypes\br_jugg_common::init();
  thread scripts\mp\gametypes\br_dev::init();
  scripts\mp\utility\sound::besttime("weapon_turret_aa");

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("postMainInit")) {
    scripts\mp\gametypes\br_gametypes::ref_12e05("postMainInit");
    return;
  }
}

function waitthensetstatgroupreadonly() {
  self endon("game_ended");
  wait 1;

  if(isDefined(level.playerstats)) {
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("losses");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("winLoss");
    return;
  }
}

function entcleanup() {
  for(var_0 = 1; var_0 < 10; var_0++) {
    _delete_ents("script_noteworthy", "locale_" + var_0);
  }

  _delete_ents("script_noteworthy", "locale_99");
}

function _delete_ents(var_0, var_1) {
  var_2 = getEntArray(var_1, var_0);
  scripts\engine\utility::array_call(var_2, &delete);
}

function totalroundtime(var_0) {
  var_1 = tablelookupgetnumcols("mp/classtable_br.csv") - 1;
  GscBinSkip1(0x45, "loadoutArchetype", "archetype_assault");
}

function searchcircleorigin(var_0, var_1, var_2) {
  if(!isDefined(level.deletescriptableinstanceaftertime)) {
    level.deletescriptableinstanceaftertime = totalroundtime(var_0);
  }

  self.pers["gamemodeLoadout"] = level.deletescriptableinstanceaftertime;
  self.class = "gamemode";
  self.prevweaponobj = undefined;
  var_3 = scripts\mp\class::loadout_getclassstruct();
  var_3 = scripts\mp\class::loadout_updateclass(var_3, "gamemode");
  scripts\mp\class::preloadandqueueclassstruct(var_3, 1, 1);
  self takeallweapons();
  scripts\mp\class::giveloadout(self.team, "gamemode", var_1, var_1);

  if(!issubstr(var_3.loadoutprimaryobject.basename, "fist")) {
    self givestartammo(var_3.loadoutprimaryobject);
  }

  if(!issubstr(var_3.loadoutprimaryobject.basename, "fist")) {
    self givestartammo(var_3.loadoutsecondaryobject);
  }

  scriptednode(self);
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();

  if(!istrue(var_2)) {
    scripts\mp\gametypes\br_weapons::delay_add_to_chopper_boss_drone_target_array();
  }

  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
  self notify("ammo_update");
}

function ref_11e23() {
  if(disable_collect_leads()) {
    var_0 = 0;

    if(istrue(self.shouldhumanspawntags)) {
      return;
    }

    var_1 = isDefined(self.shouldhumanspawntags) && !self.shouldhumanspawntags;

    if(var_1) {
      var_0 = 1;
    }

    var_2 = disablealltablets();
    searchcircleorigin(var_2, var_0);

    if(var_1) {
      self.shouldhumanspawntags = 1;
    }
  } else if(disable_fulton_group_interactions()) {
    givematchloadoutfordropbags();
  } else if(disable_cinematic_skip()) {
    var_3 = disable_usability_for_duration();
    var_4 = disable_timer();
    givematchloadout(var_3, var_4);
  } else {
    scripts\mp\utility\script::laststand_dogtags("The naked-drop loadout was not provided. Probably because the drop function should be overridden or scr_br_allowLoadoutOnlyInPreLobby should be set to 0. See IWH-426702.");
  }

  if(isDefined(level.obit_activation) && level.obit_activation.ref_129da == 1) {
    disablearmorykiosk();
    return;
  }
}

function nakeddrop() {
  var_0 = scripts\mp\gametypes\br_gulag::set_solution();

  if(var_0 && scripts\mp\gametypes\br_gametypes::tutorial_showtext("playerAdditionalGulagDropLogic")) {
    scripts\mp\gametypes\br_gametypes::ref_12e05("playerAdditionalGulagDropLogic");
  }

  if(!var_0 && istrue(level.br_prematchstarted) && !istrue(self.gulag)) {
    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("playerNakedDropLoadout")) {
      scripts\mp\gametypes\br_gametypes::ref_12e05("playerNakedDropLoadout");
    } else {
      ref_11e23();
    }
  }

  thread defend_wave_2();
}

function ref_1195b() {
  if(istrue(self.use_armor)) {
    self.use_armor = undefined;
    return;
  }

  var_0 = self.class;

  if(istrue(self.thrownspecialcount)) {
    if(istrue(level.scriptedphysicaldofenabled)) {
      if(isDefined(self.wam_sequence)) {
        var_0 = self.wam_sequence;
      }
    } else {
      self.pers["gamemodeLoadout"] = level.br_respawn_loadout;
      var_0 = "gamemode";
    }
  }

  var_1 = scripts\mp\class::preloadandqueueclass(var_0, 1);
  thread scripts\mp\class::swaploadout();

  if(var_0 != "gamemode") {
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw8_fists_mp");
  }

  self.ref_13bcc = 0;

  if(!istrue(self.ref_1285b)) {
    if(istrue(level.scriptedphysicaldofenabled)) {
      disablearmorykiosk();
    }
  }

  self.ref_1285b = 1;

  if(!istrue(self.thrownspecialcount)) {
    if(istrue(level.br_prematchstarted)) {
      if(istrue(level.scriptedphysicaldofenabled)) {
        disablearmorykiosk();
      }

      self.thrownspecialcount = 1;
    }
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("playerDropLoadout")) {
    scripts\mp\gametypes\br_gametypes::ref_12e05("playerDropLoadout");
  }

  thread defend_wave_2();
}

function managerespawnfade(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var_5 = 70;
  var_6 = var_1.origin - var_0.origin;
  var_7 = (var_6[0], var_6[1], 0);
  var_8 = 0;

  if(length2d(var_7) > 0.001) {
    var_9 = vectorNormalize(var_7);
    var_10 = vectortoangles(var_9);
    var_8 = angleclamp180(var_10[1]);
  }

  var_11 = var_0.origin;
  var_12 = (cos(var_8), sin(var_8), 0);
  var_12 = vectorNormalize(var_12);
  var_12 *= var_5;
  var_13 = scripts\mp\gametypes\br_public::ref_12a1c(var_11, var_12[0], var_12[1], var_2, var_3, var_4, var_0);

  if(var_13["fraction"] < 1) {
    var_14 = var_13["position"] + (0, 0, 0.001);
    var_15 = var_11 + (0, 0, 30);
    var_16 = scripts\engine\trace::ray_trace(var_15, var_14, var_0, var_4);

    if(var_16["fraction"] >= 1) {
      var_1 setOrigin(var_14);
      return;
    }
  }

  var_13 = scripts\mp\gametypes\br_public::ref_12a1c(var_11, 0, 0, var_2, var_3, var_4);

  if(var_13["fraction"] < 1) {
    var_17 = var_13["position"] + (0, 0, 0.2);
    var_18 = var_13["position"] + (0, 0, 1);
    var_19 = playerphysicstrace(var_17, var_18);

    if(var_19 == var_18) {
      var_1 setOrigin(var_13["position"]);
      return;
    }
  }

  var_1 kill(var_0.origin);
}

function disablearmorykiosk() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("giveStartFieldUpgrade")) {
    return;
  }

  if(istrue(level.allowsupers)) {
    var_0 = scripts\mp\supers::getcurrentsuper();

    if(isDefined(var_0)) {
      scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
      return;
    }

    return;
  }

  scripts\mp\gametypes\br_pickups::forcegivesuper(self.ref_11954);
}

function emp_drone(var_0, var_1) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isalive(var_0)) {
    return false;
  }

  if(istrue(var_0.gulag)) {
    return false;
  }

  if(!isDefined(var_0.team)) {
    return false;
  }

  if(isDefined(var_1) && var_1.team != var_0.team) {
    return false;
  }

  if(isDefined(var_1) && var_1 == var_0) {
    return false;
  }

  return true;
}

function emp_drone_clean_up(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.pers["squadMemberIndex"]) || !isDefined(var_0.ref_13ab3)) {
    return;
  }

  var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_0.team, 1);
  var_2 = "outline_nodepth_brplayer" + var_0.pers["squadMemberIndex"];
  var_3 = getdvarint("scr_br_hudoutlineForTeammatesDistance", 1024);
  var_4 = squared(var_3);
  var_5 = emp_drone(var_0);

  foreach(var_7 in var_1) {
    var_8 = var_7 getentitynumber();
    var_9 = var_5 && emp_drone(var_7, var_0);

    if(var_9) {
      var_10 = distancesquared(var_0.origin, var_7.origin);

      if(var_10 > var_4) {
        var_9 = 0;
      }
    }

    if(!var_9) {
      if(isDefined(var_0.ref_13ab3[var_8])) {
        scripts\mp\utility\outline::outlinedisable(var_0.ref_13ab3[var_8], var_0);
        var_0.ref_13ab3[var_8] = undefined;
      }

      continue;
    }

    if(!isDefined(var_0.ref_13ab3[var_8])) {
      var_0.ref_13ab3[var_8] = scripts\mp\utility\outline::outlineenableforplayer(var_0, var_7, var_2, "level_script");
    }
  }
}

function emp_drone_clean_up_func(var_0) {
  var_0 endon("disconnect");

  for(;;) {
    level waittill("update_circle_hide");
    emp_drone_clean_up(var_0);
  }
}

function emissive(var_0) {
  var_0 endon("disconnect");

  if(!isDefined(var_0.pers["squadMemberIndex"])) {
    return;
  }

  if(!istrue(level.br_infils_disabled)) {
    var_0 waittill("infil_jump_done");
  }

  var_0.ref_13ab3 = [];
  thread emp_drone_clean_up_func(var_0);

  for(;;) {
    emp_drone_clean_up(var_0);
    wait 1;
  }
}

function initializetweakableoverrides() {
  if(!isDefined(level.tweakablesinitialized)) {
    thread scripts\mp\tweakables::init();
    return;
  }
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_br_brLoadouts", getmatchrulesdata("brData", "brLoadouts"));
  setdynamicdvar("scr_br_crateDropTimer", getmatchrulesdata("brData", "crateDropTimer"));
  setdynamicdvar("scr_br_infilC130", getmatchrulesdata("brData", "infilC130"));
  setdynamicdvar("scr_br_gulag", getmatchrulesdata("brData", "gulag"));
  setdynamicdvar("scr_br_circleDamageMultiplier", getmatchrulesdata("brData", "circleDamageMultiplier"));
  setdynamicdvar("scr_br_startingWeapon", getmatchrulesdata("brData", "startingWeapon"));
  setdynamicdvar("scr_br_roundlimit", 1);
  scripts\mp\utility\game::registerroundlimitdvar("br", 1);
  setdynamicdvar("scr_br_winlimit", 1);
  scripts\mp\utility\game::registerwinlimitdvar("br", 1);
  setdynamicdvar("scr_br_promode", 0);
  scripts\mp\utility\game::registerlaststandinvulntimerdvar(0);
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.numendgame = scripts\mp\utility\dvars::dvarintvalue("numEndGame", 4, 0, 20);
  level.brloadouts = scripts\mp\utility\dvars::dvarintvalue("brLoadouts", 0, 0, 5);
  level.cratedroptimer = scripts\mp\utility\dvars::dvarintvalue("crateDropTimer", 60, 0, 300);
  level.goalenabletimer = scripts\mp\utility\dvars::dvarfloatvalue("goalEnableTimer", 60, 0, 300);
  level.goalmovetimer = scripts\mp\utility\dvars::dvarfloatvalue("goalMoveTimer", 0, 0, 300);
  level.radarendgame = scripts\mp\utility\dvars::dvarfloatvalue("radarEndGame", 1, 0, 1);
  level.infilcanusec130 = scripts\mp\utility\dvars::dvarfloatvalue("infilC130", 1, 0, 1);
  level.usegulag = scripts\mp\utility\dvars::dvarfloatvalue("gulag", 1, 0, 1);
  level.circledamagemultiplier = scripts\mp\utility\dvars::dvarfloatvalue("circleDamageMultiplier", 1, 0.5, 4);
  level.startingweapon = scripts\mp\utility\dvars::dvarintvalue("startingWeapon", 0, 0, 8);
  level.timetoadd = 30;
}

function ref_12341() {
  var_0 = "";

  if(!istrue(level.br_prematchstarted) && istrue(level.br_prematchffa)) {
    var_0 = ref_1234a();
  } else {
    var_1 = level.br_loadouts["default"];

    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("getDefaultLoadout")) {
      var_1 = scripts\mp\gametypes\br_gametypes::ref_12e05("getDefaultLoadout");
    }

    self.pers["gamemodeLoadout"] = var_1;
    var_0 = "gamemode";
  }

  self.pers["class"] = var_0;
  return var_0;
}

function binoculars_clearpendingtimer() {
  if(self calloutmarkerping_getEnt()) {
    if(self.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"] == "equip_molotov") {
      self.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"] = "equip_frag";
      return;
    }

    return;
  }
}

function ref_14290() {
  wait 5;
  iprintln("Loadout verification starting in 10 seconds.");
  wait 5;
  iprintln("5 seconds to start.");
  wait 5;
  iprintln("Verification start!");

  for(var_0 = 0; var_0 < level.ref_1195f; var_0++) {
    iprintln("Loadout: " + var_0);
    self.pers["gamemodeLoadout"] = level.ref_1285d[level.ref_12861[var_0]];
    self.class = "gamemode";
    scripts\mp\class::preloadandqueueclass(self.pers["class"]);
    scripts\mp\class::swaploadout();
    scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
    wait 5;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.secondaryweapon);
    wait 4;
  }

  self.pers["gamemodeLoadout"] = level.ref_1285d[level.ref_12861[0]];
  self.class = "gamemode";
  scripts\mp\class::preloadandqueueclass(self.pers["class"]);
  scripts\mp\class::swaploadout();
  scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
  iprintln("Verification done!");
}

function ref_1234a() {
  var_0 = "";

  if(getdvarint("scr_br_use_set_loadouts", 1)) {
    if(!isDefined(level.ref_12861)) {
      level.ref_12861 = [];

      for(var_1 = 0; var_1 < level.ref_1195f; var_1++) {
        level.ref_12861[level.ref_12861.size] = var_1;
      }

      if(getDvar("scr_br_prematch_loadout_override") == "" && getdvarint("scr_br_verify_prematch_loadouts", 0) == 0) {
        level.ref_12861 = scripts\engine\utility::array_randomize(level.ref_12861);
      }

      self.ref_1285c = level.ref_1195f - 2;
    }

    if(!isDefined(self.ref_1285c) || self.ref_1285c < 0 || self.ref_1285c >= level.ref_1195f - 1) {
      self.ref_1285c = 0;
    } else {
      self.ref_1285c++;
    }

    self.pers["gamemodeLoadout"] = level.ref_1285d[level.ref_12861[self.ref_1285c]];
    var_0 = "gamemode";
    binoculars_clearpendingtimer();
  } else {
    var_0 = "default" + randomint(10) + 1;
  }

  return var_0;
}

function ref_12858() {
  level endon("game_ended");

  while(!isDefined(level.weaponlootmapdata)) {
    waitframe();
  }

  level.ref_1285d = [];
  var_0 = [];
  GscBinSkip0(0x2e, "classIdxPrimaryArray", []);
}

function firstinfectedsplash(var_0) {
  var_1 = 0;
  var_2 = 2;
  var_3 = 2;
  var_4 = 1;
  var_5 = 1;
  var_6 = 2;
  var_7 = 2;
  var_8 = [var_2, var_3, var_4, var_5, var_6, var_7];

  while(var_1 < var_8.size) {
    var_9 = 0;
    var_10 = 0;
    var_11 = 5;

    while(var_9 < var_8[var_1]) {
      var_12 = search_turret_fire_think(var_1);

      if(!scripts\engine\utility::array_contains(var_0["classIdxPrimaryArray"], var_12) || var_10 >= var_11) {
        var_9++;
        var_10 = 0;
        var_0[var_0["classIdxPrimaryArray"].size] = var_12;
        continue;
      }

      var_10++;
    }

    var_1++;
  }

  var_13 = 0;

  for(var_14 = 0; var_14 < var_0["classIdxPrimaryArray"].size; var_14++) {
    if(var_13 < 3) {
      if(randomint(4) == 1) {
        var_15 = search_turret_fire_think(6);
      } else {
        var_15 = search_turret_fire_think(5);
      }

      var_13++;
    } else {
      var_15 = search_turret_fire_think(7);
    }

    var_0[var_0["classIdxSecondaryArray"].size] = var_15;
  }

  var_0 = scripts\engine\utility::array_randomize(var_0["classIdxPrimaryArray"]);
  var_0 = scripts\engine\utility::array_randomize(var_0["classIdxSecondaryArray"]);
  return var_0;
}

function ref_1285a() {
  level endon("game_ended");

  while(!isDefined(level.weaponlootmapdata)) {
    waitframe();
  }

  level.ref_1285d = [];
  var_0 = "mp/classtable_br_eventbp.csv";
  var_1 = 0;
  var_2 = tablelookupgetnumcols(var_0) - 1;

  while(var_1 < var_2) {
    level.ref_1285d[level.ref_1285d.size] = ref_1402f(var_0, var_1);
    var_1++;
  }
}

function search_turret_fire_think(var_0) {
  var_1 = 0;

  switch (var_0) {
    case 0:
      var_1 = 0 + randomint(10);
      break;
    case 1:
      var_1 = 10 + randomint(7);
      break;
    case 2:
      var_1 = 23 + randomint(5);
      break;
    case 3:
      var_1 = 28 + randomint(8);
      break;
    case 4:
      var_1 = 36 + randomint(6);
      break;
    case 5:
      var_1 = randomint(42);
      break;
    case 6:
      var_1 = 42 + randomint(3);
      break;
    case 7:
      var_1 = 17 + randomint(6);
      break;
    default:
      break;
  }

  return var_1;
}

function ref_1400b(var_0, var_1, var_2) {
  if(var_1 == var_2) {
    if(var_2 > 0) {
      var_2--;
    } else {
      var_2 = 1;
    }
  }

  var_3 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}

function ref_1402f(var_0, var_1) {
  var_2 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}

function riskspawn_getspawnlocationsbytier(var_0) {
  var_1 = [];

  if(var_0 == "lethal") {
    var_1 = ["equip_at_mine", "equip_claymore", "equip_c4", "equip_frag", "equip_molotov", "equip_semtex", "equip_thermite", "equip_throwing_knife", "equip_throwing_knife_fire", "equip_throwing_knife_electric", "equip_throwing_knife_drill"];
  } else if(var_0 == "tactical") {
    var_1 = ["equip_adrenaline", "equip_concussion", "equip_decoy", "equip_flash", "equip_gas_grenade", "equip_hb_sensor", "equip_smoke", "equip_snapshot_grenade"];
  }

  var_2 = var_1[randomint(var_1.size)];
  return var_2;
}

function ref_12859(var_0) {
  var_1 = tablelookupgetnumcols(var_0) - 1;
  level.ref_1285d = [];
  var_2 = 0;

  if(getDvar("scr_br_prematch_loadout_override") != "") {
    var_3 = strtok(getDvar("scr_br_prematch_loadout_override"), " ");
    var_4 = [];

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      var_4 = int(var_3[var_4.size]);
    }

    for(var_6 = 0; var_6 < var_4.size; var_6++) {
      level.ref_1285d[level.ref_1285d.size] = init_swivelroom_currsolution_marquee(var_4[var_6], var_0);
    }

    level.ref_1195f = var_4.size;
    return;
  } else if(getdvarint("scr_br_use_set_loadouts", 1)) {
    if(getdvarint("scr_br_verify_prematch_loadouts", 0) == 1 && getdvarint("scr_br_prematch_loadout_set", -1) == -1) {
      var_6 = 0;
      level.ref_1195f = var_5;
    } else {
      var_6 = int(randomint(var_5 - 1) * 0.1) * 10;

      if(getdvarint("scr_br_prematch_loadout_set", -1) != -1) {
        var_6 = getdvarint("scr_br_prematch_loadout_set", -1);
      }

      var_5 = var_6 + 10;
    }
  }

  for(var_7 = var_6; var_7 < var_5; var_7++) {
    level.ref_1285d[level.ref_1285d.size] = init_swivelroom_currsolution_marquee(var_7, var_4);
  }
}

function init_swivelroom_currsolution_marquee(var_0, var_1) {
  GscBinSkip1(0x45, "loadoutArchetype", "archetype_assault");
}

function defineplayerloadout() {
  level.br_loadouts["default"]["loadoutArchetype"] = "archetype_assault";
  level.br_loadouts["default"]["loadoutPrimary"] = "none";
  level.br_loadouts["default"]["loadoutPrimaryAttachment"] = "none";
  level.br_loadouts["default"]["loadoutPrimaryAttachment2"] = "none";
  level.br_loadouts["default"]["loadoutPrimaryCamo"] = "none";
  level.br_loadouts["default"]["loadoutPrimaryReticle"] = "none";
  level.br_loadouts["default"]["loadoutSecondary"] = "none";
  level.br_loadouts["default"]["loadoutSecondaryAttachment"] = "none";
  level.br_loadouts["default"]["loadoutSecondaryAttachment2"] = "none";
  level.br_loadouts["default"]["loadoutSecondaryCamo"] = "none";
  level.br_loadouts["default"]["loadoutSecondaryReticle"] = "none";
  level.br_loadouts["default"]["loadoutMeleeSlot"] = "iw8_fists_mp";
  level.br_loadouts["default"]["loadoutEquipmentPrimary"] = "none";
  level.br_loadouts["default"]["loadoutEquipmentSecondary"] = "none";
  level.br_loadouts["default"]["loadoutStreakType"] = "assault";
  level.br_loadouts["default"]["loadoutKillstreak1"] = "none";
  level.br_loadouts["default"]["loadoutKillstreak2"] = "none";
  level.br_loadouts["default"]["loadoutKillstreak3"] = "none";
  level.br_loadouts["default"]["loadoutSuper"] = "super_br_extract";
  level.br_loadouts["default"]["loadoutPerks"] = ["specialty_null"];
  level.br_loadouts["default"]["loadoutGesture"] = "playerData";
  level.br_loadouts["allies"] = level.br_loadouts["default"];
  level.br_loadouts["axis"] = level.br_loadouts["default"];
  level.br_respawn_loadout = level.br_loadouts["default"];
  level.br_respawn_loadout["loadoutSecondary"] = "iw8_pi_t9semiauto";
}

function onprecachegametype() {
  level._effect["vfx_gas_ring_player"] = loadfx("vfx/iw8_cp/br_ring/vfx_gas_ring_player.vfx");
  level._effect["vfx_gas_ring_puffy"] = loadfx("vfx/iw8_cp/br_ring/vfx_gas_ring_puffy.vfx");
  level._effect["vfx_br_infil_jump_smoke_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_02"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx");
  level._effect["vfx_gas_mask_break"] = loadfx("vfx/iw8_br/gameplay/vfx_br_gasmask_dest.vfx");
}

function onstartgametype() {
  level.blockweapondrops = 1;
  level.customlaststandactionset = "brlaststand";
  scripts\mp\playeractions::registeractionset(level.customlaststandactionset, ["usability", "weapon_switch", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "gesture", "allow_jump", "sprint", "crouch", "prone", "melee", "fire"]);
  level.graceperiod = 3;
  level.ingraceperiod = level.graceperiod;
  level.prematchperiodend = 0;

  if(!level.allowsupers) {
    level.setsuperweapondisabled = &ref_131c8;
  }

  setclientnamemode("auto_change");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"OBJECTIVES/DM");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/DM");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/DM_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"OBJECTIVES/DM_HINT");
  }

  initspawns();

  if(!ref_11a5c()) {
    scripts\mp\gametypes\br_circle::initcircle();
  }

  scripts\mp\gametypes\br_weapons::br_ammo_init();
  scripts\mp\gametypes\br_c130::init();
  scripts\mp\gametypes\br_pickups::delete_objective_on_death_safe();
  scripts\mp\gametypes\br_pickups::initpickupusability();
  scripts\mp\gametypes\br_callouts::init();
  scripts\mp\gametypes\br_functional_poi::init();

  if(!ref_11a5c()) {
    scripts\mp\gametypes\br_quest_util::init_quest_util();
  }

  scripts\cp_mp\vehicles\vehicle_compass::calloutmarkerping_init();
  scripts\mp\gametypes\br_lootcache::brlootcache_init();
  scripts\mp\gametypes\br_loot_cache_trapped::init();
  scripts\mp\gametypes\br_publicevents::init();
  scripts\mp\gametypes\br_challenges::init();
  scripts\mp\gametypes\br_alt_mode_escape::init();
  scripts\mp\gametypes\br_alt_mode_gxp::init();
  scripts\mp\gametypes\br_alt_mode_zai::init();
  scripts\mp\gametypes\br_alt_mode_zxp::init();
  scripts\mp\gametypes\br_containmentprotocol::init();
  scripts\mp\gametypes\br_satellite_hunt::init();
  scripts\mp\gametypes\br_alt_mode_bblitz::init();
  scripts\mp\gametypes\br_alt_mode_brshot::init();
  level.br_pickups.crates = [];
  level.br_pickups.portablekiosks = [];
  level.br_pickups.outercrates = [];
  scripts\mp\gametypes\br_gulag::initgulag();
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", &ref_1411d);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br", "superSlotCleanUp", &scripts\mp\gametypes\br_pickups::ref_1398a);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br", "challengeEvaluator", &scripts\mp\gametypes\br_challenges::getallspawninstances);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "registerCrateForCleanup", &airdrop_registercrateforcleanup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "brLoadoutCrateFirstActivation", &br_ammorestock_playeruse);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "makeWeaponFromCrate", &airdrop_makeweaponfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "makeItemFromCrate", &airdrop_makeitemfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "makeItemsFromCrate", &airdrop_makeitemsfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "br_giveDropBagLoadout", &airdrop_br_givedropbagloadout);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "brOnLoadoutCrateDestroyed", &br_armor_repair_end);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gasmask", "breakGasMaskBR", &scripts\mp\gametypes\br_pickups::disable_near_snake_cam_after_open);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "skipPlayerVO", &ending_viewing_players_setup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "playSoundToSquad", &scripts\mp\gametypes\br_public::ref_1276a);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getSquadPlayers", &scripts\mp\gametypes\br_public::round_enemy_stuck_logic);
  _hidesafecircleui::stopusingbomb();
  initloot();
  thread onprematchstarted();
  thread turnofftimer();
  thread watchprematchdone();
  level thread scripts\mp\gametypes\br_vehicles::brvehiclesonstartgametype();

  if(scripts\mp\utility\game::round_vehicle_logic() == "rat_race") {
    thread scripts\mp\gametypes\br_gametype_rat_race::ref_14363();
  } else {
    thread scripts\mp\gametypes\br_gametype_dmz::ref_14363();
  }

  thread updateplayerlocationcallouts();
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&brdpadcallback);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&setup_teleport_rooms);

  if(getdvarint("scr_disableLoadout", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  }

  if(disable_fulton_group_interactions()) {
    thread scripts\mp\gametypes\br_rewards::initdropbagsystem();
    thread cleanupdropbagsoncircle();
  }

  level.killstreakbeginusefunc = &display_hint_single;
  scripts\mp\gametypes\br_gametypes::ref_12e05("onStartGameType");
}

function ref_1411d(var_0, var_1) {
  return true;
}

function has_focus_fire_objective() {
  var_0 = getEntArray("grenade", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isDefined(var_2.weapon_name) && var_2.weapon_name == "molotov_mp") {
      thread scripts\mp\equipment\molotov::ref_11cb5(var_2);
    }
  }
}

function ref_12076() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(getdvarint("scr_br_bigFallModeEnabled", 0)) {
    level.client_activate = 1;
  }

  if(scripts\cp_mp\utility\game_utility::tutorialzoneenter()) {
    scripts\mp\gametypes\br_ww2::ref_145ee();
  }

  if(!istrue(level.ref_133e0)) {
    thread resetalldoors(level);
    level thread scripts\cp\vehicles\little_bird_mg_cp::fulton_destroy(1);
    level thread scripts\mp\gametypes\br_vehicles::brvehicleonprematchstarted();
    level thread scripts\mp\equipment\binoculars::teamuseonly();
  }

  level thread scripts\mp\gametypes\br_functional_poi::onprematchdone();

  if(!istrue(level.ref_133e0)) {
    has_focus_fire_objective();
    scripts\mp\gametypes\br_vehicles::emptyallvehicles();

    if(!istrue(level.br_infils_disabled)) {
      foreach(var_1 in level.players) {
        var_1 scripts\mp\gametypes\br_infils::setplayerprematchallows();
        var_1 thread scripts\mp\gametypes\br_pickups::resetplayerinventory();

        if(istrue(var_1.hasspawned)) {
          if(istrue(var_1.usingascender)) {
            var_1 scripts\cp_mp\auto_ascender::canseesafecircleui();
          }

          var_1 thread scripts\mp\weapons::deleteplacedequipment(1);
        }
      }
    }

    foreach(var_1 in level.players) {
      if(isDefined(var_1.burninginfo)) {
        var_1 scripts\mp\equipment\molotov::molotov_clear_burning();
      }

      var_1 scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
    }

    level notify("prematch_cleanup");
  }

  level.little_bird_mp_initmines = 0;

  foreach(var_6 in level.br_prematchloot) {
    var_6 setscriptablepartstate(level.br_prematchlootparts[var_7], "visible");
  }

  level.br_prematchloot = undefined;
  level.br_prematchlootparts = undefined;

  if(!scripts\mp\gametypes\br_public::isusinginfilselection() && disable_flag()) {
    scripts\mp\gametypes\br_infils::classselectionbeginnonexclusion();
  }

  var_8 = getdvarint("wsow_event_dvar_hot_reload", 0);

  if(istrue(var_8)) {
    ref_12bb7();
  }

  if(!istrue(level.br_circle_disabled)) {
    level thread scripts\mp\gametypes\br_circle::ref_12e09(1);
    return;
  }
}

function ref_12bb7() {
  if(!istrue(getdvarint("scr_br_gulag", 1))) {
    if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("gulag")) {
      level scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
    }

    level.usegulag = 0;
    setomnvar("ui_gulag_state", 0);
    setomnvar("ui_gulag_show_closing_state", 2);
  }

  if(!istrue(level.br_circle_disabled)) {
    level scripts\mp\gametypes\br_circle::cacheentity();
    level thread scripts\mp\gametypes\br_circle::allplayers_setphysicaldof();
    return;
  }
}

function onprematchstarted() {
  thread ref_12076();
  var_0 = undefined;

  if(!istrue(level.br_infils_disabled) && !scripts\mp\gametypes\br_public::isusinginfilselection()) {
    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("createC130PathStruct")) {
      var_0 = scripts\mp\gametypes\br_gametypes::ref_12e05("createC130PathStruct");
    } else {
      var_0 = scripts\mp\gametypes\br_c130::createtestc130path();
    }
  }

  if(!istrue(level.ref_133e0) && !scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    foreach(var_2 in level.teamnamelist) {
      setteamradar(var_2, 1);
      setteamradarstrength(var_2, 1);
    }
  }

  if(scripts\mp\utility\game::round_vehicle_logic() != "zxp") {
    thread scripts\mp\music_and_dialog::stopsuspensemusic();
  }

  level waittill("prematch_started");

  if(ref_11a5c()) {
    scripts\mp\gametypes\br_circle::initcircle();
    scripts\mp\gametypes\br_quest_util::init_quest_util();
  }

  if(!istrue(level.ref_133e0)) {
    var_4 = getdvarint("scr_br_radar_strength", 0);

    foreach(var_2 in level.teamnamelist) {
      if(var_4) {
        setteamradar(var_2, 1);
        setteamradarstrength(var_2, var_4);
        continue;
      }

      setteamradar(var_2, 0);
      setteamradarstrength(var_2, 0);
    }
  }

  if(istrue(level.debug_safehouse_regroup_start) && istrue(level.debug_show2dvotext)) {
    setomnvarforallclients("ui_options_menu", 0);
  }

  var_7 = 0;
  level.debugnextpropindex = 0;
  level.delay_music_reinforcements = 0;

  if(!istrue(level.br_infils_disabled)) {
    if(!istrue(level.infilcanusec130) && !istrue(level.infilcanusemap)) {
      level.infilcanusec130 = 1;
    }

    if(istrue(level.infilcanusemap)) {
      if(disable_fulton_group_interactions() && !dialog_mount_nag_watcher()) {
        scripts\mp\gametypes\br_rewards::ref_1284d(1);
      }

      scripts\mp\gametypes\br_infils::spawnselectioninfil("player");
      waitframe();

      foreach(var_9 in level.players) {
        var_9 stopanimscriptsceneevent();
        var_9 notify("infil_jump_done");

        if(!var_9.brmapselectionafk) {
          var_9 thread scripts\mp\gametypes\br_infils::ref_13aec();
          continue;
        }

        thread sendafksquadmembertogulag();
      }
    }

    setdvarifuninitialized("scr_br_use_script_model_infil", 0);

    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("infilSequence")) {
      scripts\mp\gametypes\br_gametypes::ref_12e05("infilSequence");
    } else if(istrue(level.infilcanusec130) && !istrue(level.infilcanusemap)) {
      var_11 = undefined;

      if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("getInfilPlayers")) {
        var_11 = scripts\mp\gametypes\br_gametypes::ref_12e05("getInfilPlayers");
      }

      if(!getdvarint("scr_br_use_script_model_infil", 0)) {
        scripts\mp\gametypes\br_infils::clear_tier_lights(var_0, "player", var_11);
      } else {
        scripts\mp\gametypes\br_infils::clear_tier_lights(var_0, "script_model");

        if(isDefined(level.infilstruct) && isDefined(level.infilstruct.transporttime)) {
          var_7 = level.infilstruct.transporttime;
        }
      }

      level thread scripts\mp\gametypes\br_c130::waittoplayinfildialog();
    }
  } else {
    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("skipInfilSequence")) {
      scripts\mp\gametypes\br_gametypes::ref_12e05("skipInfilSequence");
    }

    scripts\mp\flags::gameflagset("prematch_fade_done");
    waitframe();
    level.allowprematchdamage = 0;
    var_11 = undefined;

    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("getInfilPlayers")) {
      var_11 = scripts\mp\gametypes\br_gametypes::ref_12e05("getInfilPlayers");
    }

    if(!isDefined(var_11) || var_11.size > 0) {
      scripts\mp\gametypes\br_infils::ref_1435f(var_11);
    }

    foreach(var_9 in level.players) {
      var_9.plotarmor = undefined;

      if(istrue(level.client_activate)) {
        var_9 skydive_setdeploymentstatus(1);
        var_9 skydive_setbasejumpingstatus(1);
        continue;
      }

      var_9 skydive_setdeploymentstatus(0);
      var_9 skydive_setbasejumpingstatus(0);
    }

    scripts\mp\flags::gameflagset("br_ready_to_jump");
  }

  thread setup_player_killstreak_loadouts();
  thread setup_weapons_at_pos();

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("teamSpectate")) {
    level thread scripts\mp\gametypes\br_spectate::spectate_init();
  }

  level.br_prematchstarted = 1;
  level notify("infils_ready");
}

function setup_weapons_at_pos() {
  if(scripts\mp\utility\game::updatex1stashhud()) {
    return;
  }

  scripts\mp\scoreboard::ref_128b0();

  if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
    if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch()) {
      setclientmatchdata("isPublicMatch", 1);
    } else {
      setclientmatchdata("isPublicMatch", 0);
    }
  }

  level scripts\engine\utility::waittill_notify_or_timeout("br_c130_left_bounds", 120);
  scripts\mp\scoreboard::ref_128b0();
}

function setup_player_killstreak_loadouts() {
  level endon("game_ended");

  if(disable_fulton_group_interactions() && dialog_mount_nag_watcher()) {
    if(!scripts\mp\gametypes\br_public::validtousesticker() && !scripts\mp\gametypes\br_public::tutorial_playSound()) {
      var_0 = disable_weapon_swap_until_swap_finished();
      scripts\mp\gametypes\br_rewards::kioskreviveplayer(var_0);

      if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("dropBagLoop")) {
        for(;;) {
          scripts\mp\gametypes\br_rewards::kioskreviveplayer(var_0);
        }
      }
    }
  }

  level.dropbagstruct = undefined;
}

function resetalldoors(var_0) {
  level endon("game_ended");

  if(isDefined(var_0)) {
    wait var_0;
  }

  difficulty_update_time(200);
}

function setup_teleport_rooms(var_0, var_1) {
  if(isDefined(var_0) && var_0 == "exit_squad_eliminated") {
    self setclientomnvar("ui_br_squad_eliminated_active", 0);
    return;
  }
}

function updateplayerlocationcallouts() {
  level endon("game_ended");

  if(!isDefined(level.calloutglobals.calloutzones)) {
    level.calloutglobals.calloutzones = getEntArray("location_volume", "targetname");
  }

  jumpiftrue(level.calloutglobals.calloutzones.size) LOC_00000040;
  return;
}

function getusingproxdoors() {
  return false;
}

function watchprematchdone() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level notify("br_prematchEnded");
  var_0 = scripts\mp\utility\game::getlivingplayers();
  level.totalplayers = var_0.size;
  var_1 = 0;

  foreach(var_3 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var_3, "aliveCount") > 0) {
      var_1++;
    }
  }

  level.ref_1385e = max(1, var_1);
  level.ref_12855 = gettime();
  level.recordfinalkillcam = 1;
  level.ignorescoring = 0;
  level.disableweaponstats = 0;
  level.disablestattracking = 0;
  level.prematchaddkillfunc = undefined;
  level.getarenapickupattachmentoverrides = 0;
  difficulty_think();

  foreach(var_6 in level.players) {
    ref_12c6f(var_6);
  }

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("allowLateJoiners")) {
    level.allowlatecomers = 0;
    setnojiptime(1, 1);
    setnojipscore(1, 1);
  }

  vehicle_getarrayinradius();
  setomnvar("scriptable_loot_hide", 0);

  foreach(var_6 in level.players) {
    var_6 setclientdvar("ui_opensummary", 1);

    if(isalive(var_6)) {
      var_6.health = var_6.maxhealth;
      var_6 scripts\cp\vehicles\vehicle_compass_cp::ref_1383b("alive_not_downed");
    }
  }

  scripts\mp\gametypes\br_analytics::detonatedripfx(var_0.size);
  ref_1319b(level);
}

function turnofftimer() {
  wait 1;
  setomnvar("ui_match_timer_hidden", 1);
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function tolerance() {
  if(!scripts\mp\gametypes\br_public::tutorial_playSound()) {
    level.startingspawns = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");

    if(level.startingspawns.size == 0) {
      level.startingspawns = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
    }

    level.prematchspawnorigins = getprematchlocationspawnorigins();
    return;
  }
}

function debugspawnlocations() {
  for(;;) {
    foreach(var_1 in level.prematchspawnorigins) {
      var_2 = getprematchradius(var_1);
      var_3 = var_2[0];
      var_4 = var_2[1];
      var_2 = undefined;

      if(var_3 > 0) {}
    }

    waitframe();
  }
}

function ref_14070() {
  var_0 = getdvarint("scr_useProfileSpawn", 0) != 0;
  return (!istrue(level.br_prematchstarted) || istrue(level.debug_safehouse_gunshop_start)) && !istrue(level.skipprematchdropspawn) && !var_0 && !istrue(level.stop_end_breach_fx);
}

function getspawnpoint(var_0) {
  if(isDefined(self.ref_1286f)) {
    var_1 = self.ref_1286f;
    self.ref_1286f = undefined;
    return var_1;
  }

  if(isDefined(self.thrust_fx_model)) {
    var_1 = self.thrust_fx_model;
    return var_1;
  }

  if(!isDefined(level.prematchspawnorigins)) {
    tolerance();
  }

  if(istrue(var_1) || ref_14070()) {
    var_2 = (0, randomintrange(0, 360), 0);
    var_4 = getprematchspawnorigin();
    var_5 = getprematchradius(var_4);
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_5 = undefined;
    var_8 = randomfloatrange(var_6, var_7);

    if(getdvarint("scr_br_streamFurthestInitial", 0) == 1) {
      var_10 = vectortoangles(var_4.origin);
      var_2 = (0, var_10[1], 0) * -1;
      var_8 = var_7;
    }

    if(isDefined(var_4.angles)) {
      var_2 = var_4.angles;
    }

    var_11 = anglesToForward(var_2) * -1;
    var_12 = var_11 * var_8;
    var_13 = var_4.origin + var_12;
    var_13 = scripts\mp\gametypes\br_c130::ref_1342e(var_4.origin, var_13, 30);

    if(isDefined(self.setspawnpoint)) {
      var_14 = scripts\mp\gametypes\br_public::getinfilspawnoffset();
      var_13 = self.setspawnpoint.playerspawnpos + (0, 0, var_14);
      var_2 = self.setspawnpoint.playerspawnangles;
      scripts\mp\equipment\tac_insert::ref_13681(0, 1);
    }

    var_1 = spawnStruct();
    var_1.origin = var_13;
    var_1.angles = var_2;
    var_1.index = -1;
    return var_1;
  }

  var_15 = level.startingspawns;
  var_1 = scripts\mp\spawnlogic::getspawnpoint_random(var_15);

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_1.origin = (0, 0, 0);
    var_1.angles = (0, 0, 0);
    var_1.index = -1;
  }

  return var_1;
}

function createspawnlocation(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.minradius = var_1;
  var_3.radius = var_2;
  return var_3;
}

function getprematchlocationspawnorigins() {
  var_0 = 0;
  var_1 = scripts\engine\utility::getStructArray("br_prematch_insertion_point", "targetname");

  if(isDefined(level.delete_script_object)) {
    var_0 = 1;
    var_1 = level.delete_script_object;
  } else if(!var_1.size) {
    var_0 = 1;
    var_1 = getEntArray("vehicle_volume", "script_noteworthy");
  }

  foreach(var_3 in var_1) {
    var_3.groundorigin = var_3.origin;

    if(!isDefined(var_3.radius)) {
      var_3.radius = 5000;
    }

    if(!isDefined(var_3.minradius)) {
      var_3.minradius = 500;
    }
  }

  var_5 = scripts\mp\gametypes\br_gametypes::ref_12e05("prematchSpawnMaxLocations");

  if(!isDefined(var_5)) {
    var_5 = getdvarint("scr_br_maxprematchlocations", 5);
  }

  if(var_5 > 0 && var_5 < var_1.size) {
    var_1 = scripts\engine\utility::array_slice(scripts\engine\utility::array_randomize(var_1), 0, var_5);
  }

  foreach(var_3 in var_1) {
    if(var_0) {
      var_3.origin = getoffsetspawnorigin(var_3.origin);
      continue;
    }

    var_7 = getoffsetspawnorigin(var_3.origin)[2];

    if(var_3.origin[2] < var_7) {
      var_3.origin = (var_3.origin[0], var_3.origin[1], var_7);
    }
  }

  return var_1;
}

function getoffsetspawnorigin(var_0, var_1) {
  var_2 = scripts\engine\trace::create_default_contents(1);
  var_3 = (0, 0, 5000);
  var_4 = var_0 + var_3;
  var_5 = var_0 - var_3;
  var_6 = scripts\engine\trace::ray_trace(var_4, var_5, undefined, var_2);
  var_7 = var_0;

  if(var_6["hittype"] != "hittype_none") {
    var_7 = var_6["position"];
  }

  if(!isDefined(var_1)) {
    var_8 = scripts\mp\gametypes\br_public::getinfilspawnoffset();
    var_1 = (0, 0, var_8);
  }

  return var_7 + var_1;
}

function resetcircuitbreakers(var_0, var_1) {
  var_2 = 5000;
  var_3 = -5000;
  var_4 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_0, var_2, var_3);

  if(!isDefined(var_1)) {
    var_5 = scripts\mp\gametypes\br_public::getinfilspawnoffset();
    var_1 = (0, 0, var_5);
  }

  return var_4 + var_1;
}

function relic_squadlink_toofar_hud_logic() {
  var_0 = int(150 / scripts\mp\gametypes\br_public::replace_sat_piece_on_deathordisconnect());
  return var_0;
}

function getprematchspawnorigin() {
  var_0 = scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("doFirstUnusedPrematchSpawnOrigin");

  if(istrue(var_0) && isDefined(level.ref_12864)) {
    var_1 = 0;

    for(var_2 = 0; var_2 < level.prematchspawnorigins.size; var_2++) {
      if(level.ref_12864[var_2] < level.ref_12864[var_1]) {
        var_1 = var_2;
      }
    }

    level.ref_12864[var_1]++;
    var_3 = level.prematchspawnorigins[var_1];
    return var_3;
  }

  if(!isDefined(level.prematchspawnoriginnextidx)) {
    if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("randomizePrematchSpawnOriginNextIdx")) {
      level.prematchspawnoriginnextidx = 0;
    } else {
      level.prematchspawnoriginnextidx = randomint(level.prematchspawnorigins.size);
    }

    level.ref_12865 = [];

    for(var_2 = 0; var_2 < level.prematchspawnorigins.size; var_2++) {
      level.ref_12865[var_2] = 0;
    }
  }

  var_3 = scripts\mp\gametypes\br_public::round_at_max(self.sessionteam, self.squadindex, "prematchSpawnOrigin");

  if(!isDefined(var_3)) {
    var_3 = level.prematchspawnorigins[level.prematchspawnoriginnextidx];
    scripts\mp\gametypes\br_public::ref_131c3(self.sessionteam, self.squadindex, "prematchSpawnOrigin", var_3);
    level.ref_12865[level.prematchspawnoriginnextidx]++;
    var_4 = scripts\mp\gametypes\br_gametypes::ref_12e05("prematchSpawnNumTeamsPerLocation");

    if(!isDefined(var_4)) {
      var_5 = relic_squadlink_toofar_hud_logic();
      var_4 = int(var_5 / level.prematchspawnorigins.size);
    }

    if(level.ref_12865[level.prematchspawnoriginnextidx] >= var_4) {
      level.prematchspawnoriginnextidx = (level.prematchspawnoriginnextidx + 1) % level.prematchspawnorigins.size;
    }
  }

  var_6 = getdvarint("scr_br_overrideprematchspawn", -1);

  if(var_6 >= 0 && var_6 < level.prematchspawnorigins.size) {
    var_3 = level.prematchspawnorigins[var_6];
  }

  return var_3;
}

function onplayerconnect(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0.ui_dom_securing = undefined;
  var_0.ui_dom_stalemate = undefined;
  var_0.needtoplayintro = undefined;
  var_0.br_infil_type = undefined;
  var_0.equipment = [];
  var_0.delay_give_tactical_grenade = 1;
  var_0 thread scripts\mp\gametypes\br_weapons::br_ammo_player_init();
  var_0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("playerWelcomeSplashes")) {
    var_0 thread scripts\mp\gametypes\br_gametypes::ref_12e05("playerWelcomeSplashes");
  } else {
    thread ref_126f1();
  }

  ref_12c6f(var_0);
  scripts\mp\gametypes\br_gametypes::ref_12e05("onPlayerConnect", var_0);

  if(scripts\mp\gametypes\br_gametype_olaride::arefactionpointsenabled()) {
    var_0 thread scripts\mp\gametypes\br_gametype_olaride::loadplayerhvveventpoints();
  }

  if(!istrue(level.prematchstarted)) {
    var_0.radarmode = "slow_radar";
    level waittill("prematch_started");
    wait 1.4;
  }

  if(!isDefined(var_0.streakdata)) {
    waittillframeend();
  }

  if(isDefined(var_0)) {
    if(!scripts\mp\gametypes\br_public::uniquelootitemid() && !scripts\mp\gametypes\br_public::validtousesticker() && !scripts\mp\gametypes\br_public::tutorial_playSound() && !scripts\mp\utility\game::updatex1stashhud()) {
      if(!istrue(level.ref_133e0)) {
        var_0 scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
        var_0 scripts\mp\gametypes\br_pickups::resetplayerinventory();
      }

      var_0 scripts\cp_mp\utility\game_utility::startkeyearning();
    }

    thread ref_11d22();
    var_1 = getDvar("scr_br_radar_mode", "");

    if(var_1 != "") {
      var_0.radarmode = var_1;
    } else {
      var_0.radarmode = "normal_radar";
    }

    scripts\mp\gametypes\br_quest_util::onplayerconnect(var_0);
    threat_sight_monitor(var_0);
    var_0 scripts\mp\gametypes\br_gulag::updatecanusegulag();
    return;
  }
}

function ref_126f1() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;

  if(!istrue(game["liveLobbyCompleted"])) {
    scripts\mp\hud_message::showsplash("br_prematch_welcome");

    if(istrue(level.vehicle_collision_getleveldata)) {
      self setplayermusicstate("event01_lobby");
    }
  }

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");

    if(isDefined(game["dialog"]["match_desc"])) {
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("match_desc", self, 0);
    }

    while(!self isonground()) {
      waitframe();
    }
  } else {
    level waittill("prematch_done");
  }

  scripts\mp\gametypes\br_analytics::detachriotshield(self);
  wait 1;
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("primary_objective", self, 0);
}

function onspawnplayer() {
  self notify("br_spawned");
  var_0 = istrue(self.gulag);
  scripts\mp\gametypes\br_pickups::initplayer(var_0);
  scripts\mp\gametypes\br_functional_poi::initplayer();

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("armor")) {
    scripts\mp\gametypes\br_armor::teamfriendlyto();
  }

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("teamSpectate")) {
    scripts\mp\gametypes\br_spectate::initplayer();
  }

  self.oldprimarygun = undefined;
  self.newprimarygun = undefined;
  self.healthregendisabled = 0;
  self.br_lastscenecheck = gettime();
  self.needtoplayintro = undefined;
  self.gunnlessweapon = undefined;
  self.disable_hotjoining_after_time = undefined;
  self.ref_12885 = undefined;

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("waitLoadoutDone")) {
    thread waitloadoutdone();
  }

  level.superdelay = 0;
  level.superpointsmod = 1;
  self.br_perks = [0, 0, 0, 0, 0];
  self.br_perkpoints = 0;

  if(level.ref_121c8) {
    self getclientomnvar();
  } else {
    self weaponswitchbuttonPressed();
  }

  if(level.ref_121c9) {
    self skydive_cutautodeployon();
  } else {
    self skydive_cutautodeployoff();
  }

  if(getdvarint("scr_br_hudoutlineForTeammates", 0) > 0) {
    thread emissive(level);
  }

  if(getdvarint("scr_game_hcmode") == 1) {
    self.healthregendisabled = 1;
  }

  scripts\mp\gametypes\br_public::ref_1319e(0);
  scripts\mp\gametypes\br_public::ref_1319c(0);
  ref_1401f(self, self, 0, 1);
  thread ref_14006();
}

function waittill_return(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0, var_2, var_3);
  var_1 notify("returned", var_2, var_3, var_0);
}

function waittill_confirm_or_cancel(var_0, var_1, var_2) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death")) {
    self endon("death");
  }

  var_3 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_3);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_3);
  }

  jumpiffalse(isDefined(var_2)) LOC_00000058;
  GscBinSkip4(0x35, var_2, var_3);

  var_3 waittill("returned", var_4, var_5, var_6);
  var_3 notify("die");
  var_7 = spawnStruct();
  var_7.location = var_4;
  var_7.angles = var_5;
  var_7.string = var_6;
  return var_7;
}

function ref_13c34(var_0) {
  var_1 = var_0 + (0, 0, 10000);
  var_2 = var_0 - (0, 0, 10000);
  var_3 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();
  var_4 = level.activekillstreaks;
  var_5 = scripts\engine\utility::array_combine(var_3, var_4);
  var_6 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 0, 0, 0);
  return scripts\engine\trace::ray_trace(var_1, var_2, var_5, var_6, 0, 1);
}

function giveprematchloadout() {
  self endon("death_or_disconnect");

  if(!istrue(level.br_prematchffa)) {
    return;
  }

  if(isDefined(level.calculateclientmatchdataextrainfopayload)) {
    self[[level.calculateclientmatchdataextrainfopayload]]();
    return;
  }
}

function calculateclientmatchdataextrainfopayload() {
  var_0 = getdvarint("scr_br_allow_prematch_perks", 0) == 1;

  if(!var_0) {
    thread scripts\mp\class::loadout_clearperks();
  }

  waitframe();

  if(!level.allowsupers && !istrue(level.scriptedphysicaldofenabled) || getDvar("scr_br_gametype", "") == "reveal" || getdvarint("scr_br_force_prematch_ammo_drop", 1) == 1) {
    scripts\mp\gametypes\br_pickups::ref_12c81();
    scripts\mp\gametypes\br_pickups::forcegivesuper("super_ammo_drop", 0);
    return;
  }
}

function givematchloadout(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  if(!isDefined(var_1)) {
    var_1 = 20;
  }

  var_2 = self;
  var_3 = var_2 scripts\mp\class::loadout_getorbuildclassstruct(var_2.class);

  if(!isDefined(var_3)) {
    return;
  }

  var_2.prevweaponobj = undefined;
  var_2 scripts\mp\class::loadout_clearperks();
  var_2 scripts\mp\class::loadout_updateplayerperks(var_3);
  scriptednode(var_2);
  var_4 = 0;

  if(isDefined(var_3.loadoutsecondaryobject) && !nullweapon(var_3.loadoutsecondaryobject)) {
    scripts\mp\gametypes\br_weapons::br_forcegivecustomweapon(var_2, var_3.loadoutsecondaryobject, var_3.loadoutsecondaryfullname, var_3.loadoutsecondary, var_0, var_1);
    var_4++;
  }

  if(isDefined(var_3.loadoutprimaryobject) && !nullweapon(var_3.loadoutprimaryobject)) {
    scripts\mp\gametypes\br_weapons::br_forcegivecustomweapon(var_2, var_3.loadoutprimaryobject, var_3.loadoutprimaryfullname, var_3.loadoutprimary, var_0, var_1);
    var_4++;
  }

  if(var_4 > 1) {
    var_2 takeweapon("iw8_fists_mp");
  }

  var_5 = [];

  if(isDefined(var_3.loadoutequipmentprimary)) {
    GscBinSkip0(0x2e, var_5.size, var_3.loadoutequipmentprimary);
  }

  if(isDefined(var_3.loadoutequipmentsecondary)) {
    GscBinSkip0(0x2e, var_5.size, var_3.loadoutequipmentsecondary);
  }

  foreach(var_7 in var_5) {
    if(isDefined(level.br_pickups.br_equipnametoscriptable[var_7])) {
      var_8 = level.br_pickups.br_equipnametoscriptable[var_7];
      scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_2, var_8, 1);
    }
  }
}

function givematchloadoutfordropbags() {
  var_0 = self;
  var_0.prevweaponobj = undefined;
  var_0 scripts\mp\class::loadout_clearperks();
  scriptednode(var_0);
}

function prematchdeployparachute() {
  self endon("disconnect");

  while(self.sessionstate != "playing") {
    waitframe();
  }

  thread scripts\cp_mp\parachute::startfreefall(2, 0, undefined, undefined, 1, 0);
}

function getprematchradius(var_0) {
  var_1 = var_0.radius;
  var_2 = var_0.minradius;
  var_3 = getdvarint("scr_br_prematch_spawn_max_radius", -1);

  if(var_3 >= 0) {
    var_1 = var_3;
  }

  var_3 = getdvarint("scr_br_prematch_spawn_min_radius", -1);

  if(var_3 >= 0) {
    var_2 = var_3;
  }

  if(var_2 >= var_1) {
    var_1 = var_2 + 1;
  }

  return [var_2, var_1];
}

function scriptednode(var_0) {
  if(istrue(level.playerkillstreakgetownerlookatignoreents)) {
    return;
  }

  if(!level.teambased) {
    return;
  }

  var_1 = level.maxteamsize == 1;
  var_2 = istrue(var_0.shouldgetnewspawnpoint);

  if(var_1 && !var_2 && !istrue(level.brking_initpostmain)) {
    return;
  }

  if(!tvstation_fastrope_init(var_0)) {
    return;
  }

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  var_0 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
}

function search_update_delay(var_0) {
  if(!tvstation_fastrope_init(var_0)) {
    return;
  }

  if(!var_0 scripts\mp\gametypes\br_public::shouldlink()) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  var_0 scripts\mp\perks\perks::bears();
}

function waitloadoutdone() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self waittill("giveLoadout");

  if(scripts\mp\gametypes\br_public::validtousesticker() || scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    scripts\mp\gametypes\br_armor::searchcirclesize();
    return;
  }

  if(!istrue(level.br_prematchstarted)) {
    thread giveprematchloadout();
    scripts\mp\gametypes\br_armor::searchcirclesize();

    if(!istrue(self.ref_12860)) {
      self.ref_12860 = 1;
      scripts\engine\utility::delaythread(1, &scripts\mp\gametypes\br_public::dmztut_endgamewithreward, "prematch_enter", self);
      var_0 = game["music"]["br_lobby_intro"].size - 1;
      var_1 = randomint(var_0);
      self setplayermusicstate(game["music"]["br_lobby_intro"][var_1]);
    }

    var_2 = getdvarint("scr_useProfileSpawn", 0) != 0;

    if(istrue(level.infilcanusemap) && !var_2) {
      level waittill("begin_infil_map_selection");
      scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
      scripts\mp\gametypes\br_pickups::resetplayerinventory();
    }

    level waittill("infils_ready");

    if(level.allowsupers) {
      scripts\mp\supers::clearsuper(0);
    }
  }

  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  var_3 = istrue(self.gulag) || scripts\mp\gametypes\br_public::validtousesticker() || istrue(self.ref_12ca8);
  scripts\mp\gametypes\br_pickups::resetplayerinventory(var_3);

  if(!var_3) {
    scripts\mp\gametypes\br_armor::searchcirclesize();
  }

  scriptednode(self);

  if(istrue(self.isrespawn)) {
    return;
  }

  if(istrue(self.gulag) || istrue(self.ref_12ca8)) {
    return;
  }

  if(!istrue(level.br_infils_disabled) && !istrue(self.watch_for_usb_notetrack_switchoff)) {
    thread scripts\mp\gametypes\br_infils::setplayerprematchallows();
    return;
  }
}

function onplayerscore(var_0, var_1, var_2, var_3) {
  return var_2;
}

function brmodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = var_3;

  if(level.tacticalmode) {
    var_3 = scripts\mp\damage::gamemodemodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(var_1 scripts\mp\gametypes\br_public::isplayeringulag() && istrue(var_1.gulagarena) && getdvarint("scr_gulag_mp_damage", 1)) {
    return var_3;
  }

  if(!isDefined(var_10)) {
    var_10 = var_3;
  }

  if(var_3 > 0) {
    if(istrue(var_1.tracking_max_health)) {
      var_1 notify("br_try_armor_cancel");
    }

    var_12 = scripts\mp\utility\weapon::getweaponrootname(var_5);
    var_13 = scripts\mp\utility\weapon::getweaponbasenamescript(var_5);
    var_14 = weaponclass(var_5);

    if(var_4 == "MOD_FALLING") {
      if(isDefined(level.ref_11c94)) {
        var_3 = var_1[[level.ref_11c94]](var_3);
      } else if(var_1 scripts\mp\utility\killstreak::isjuggernaut()) {} else if(getdvarint("scr_br_alt_mode_rocketjump", 0)) {
        if(var_1 isskydiving()) {
          var_1 skydive_interrupt();
        }

        var_3 = 0;
      } else if(isDefined(self.br_maxarmorhealth)) {
        var_3 = self.maxhealth + self.br_maxarmorhealth;
      } else {
        var_3 = self.maxhealth;
      }
    } else if(isDefined(var_0) && var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() && !istrue(var_0.stadium_one_death_func)) {
      if(isDefined(level.ref_11c96)) {
        var_3 = var_1[[level.ref_11c96]](var_3);
      } else if(var_1 scripts\mp\utility\killstreak::isjuggernaut()) {} else {
        var_15 = self.maxhealth;

        if(isDefined(self.br_maxarmorhealth)) {
          var_15 += self.br_maxarmorhealth;
        }

        var_3 = scripts\mp\utility\script::roundup(var_3 * var_15 / level.ref_12602);
      }
    } else if(var_12 == "iw8_sn_crossbow" && var_4 != "MOD_PISTOL_BULLET") {} else if(var_4 == "MOD_MELEE") {
      var_3 = int(var_10);
      var_3 = ref_11c9c(var_3, var_5);

      if(isDefined(var_0)) {
        if(var_0 scripts\mp\utility\perk::_hasperk("serum_gadget")) {
          var_16 = _findnewlocaleplacement::randomoffsetmortar();
          var_3 = int(var_3 * var_16);
        }
      }
    } else if(scripts\mp\utility\weapon::iskillstreakweapon(var_5)) {
      if(istrue(var_1.inlaststand) && scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_5) == "precision_airstrike") {
        if(isDefined(var_1.disable_hotjoining_after_time)) {
          var_17 = gettime() - var_1.disable_hotjoining_after_time < 5000;

          if(var_17) {
            var_3 = 0;
          }
        }
      }
    } else if(var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH" || var_4 == "MOD_FIRE") {
      if(getdvarint("scr_br_alt_mode_rocketjump", 0) && isDefined(var_0)) {
        var_3 = 0;
        thread debug_showcardlocs(var_1);
      }

      if(var_12 == "claymore_mp" || var_12 == "claymore_radial_mp") {
        var_3 = int(var_3 * 1.5);
      }
    } else if(getdvarint("scr_br_alt_mode_gg", 0) && var_4 != "MOD_TRIGGER_HURT") {
      var_3 = difficulty_allowseekafterthreshold(var_9, var_14, var_12, var_8, var_3);
    } else if(getdvarint("scr_br_clamp_step_damage", istrue(level.half_size)) && var_4 != "MOD_TRIGGER_HURT") {
      var_3 = died_poorly_funcs(var_9, var_14, var_12, var_8, var_10, var_3, var_5, var_4);
    }

    if(isDefined(var_5)) {
      if(var_5.type == "grenade") {
        switch (var_5.basename) {
          case "frag_grenade_mp":
            var_3 = int(var_3 * getdvarfloat("scr_br_lethal_frag_multiplier", 2));
            break;
          case "claymore_mp":
            var_3 = int(var_3 * getdvarfloat("scr_br_lethal_claymore_multiplier", 1.667));
            break;
          case "semtex_mp":
            var_3 = int(var_3 * getdvarfloat("scr_br_lethal_semtex_multiplier", 1.5));
            break;
          case "at_mine_ap_mp":
            var_3 = int(var_3 * getdvarfloat("scr_br_atMine_multiplier", 1.4));
            break;
          case "molotov_mp":
            var_3 = int(var_3 * getdvarfloat("scr_br_molotov_multiplier", 1.45));
            break;
          case "throwingknife_drill_mp":
          case "throwingknife_electric_mp":
          case "throwingknife_fire_mp":
          case "throwingknife_mp":
            if(var_8 == "head" || var_8 == "helmet") {
              var_3 = getdvarint("scr_br_lethal_throwingKnife_set", 300);
            } else {
              var_3 = getdvarint("scr_br_lethal_throwingKnife_set", 200);
            }

            break;
        }
      }
    }

    if(disablebunker11cachelocations(var_1)) {
      if(var_12 != "rock_mp") {
        var_3 = 0;

        if(isDefined(var_2)) {
          var_2 thread scripts\mp\damagefeedback::updatedamagefeedback("standard", 0, 0, "standard", 0);
        }
      } else {
        var_3 = 1;
      }

      if(var_1.health - var_3 <= 0) {
        var_3 = 0;
      }
    }

    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("modifyPlayerDamage")) {
      var_18 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_2, self, var_3, var_5, var_4, var_0, var_6, var_7);
      var_18.shitloc = var_8;
      var_18.idflags = var_9;
      var_3 = thread scripts\mp\gametypes\br_gametypes::ref_12e05("modifyPlayerDamage", var_18);
    }

    if(var_3 == 10000 && level.delay_spawn_room_soldiers == 1) {
      var_3 = int(level.delay_spawn_tanks);
    }

    if(level.decide_new_code == 1 && istrue(self.unset_relic_shieldsonly) && isDefined(var_4) && var_4 != "MOD_TRIGGER_HURT") {
      var_3 = guard_shack_mantle(var_3, var_1);
    }

    if(var_13 == "s4_me_icepick_mp" || var_13 == "s4_me_axe_mp") {
      switch (var_8) {
        case "none":
          break;
        case "head":
          var_3 = level.delay_show_balloon;
          break;
        case "neck":
          var_3 = level.delay_show_marker_to_tv_station;
          break;
        case "torso_upper":
          var_3 = level.delay_spawn_nav_repulsor;
          break;
        case "right_arm_upper":
          var_3 = level.delay_show_player_clip;
          break;
        case "left_arm_upper":
          var_3 = level.delay_show_player_clip;
          break;
      }
    }

    if(isDefined(var_0) && isDefined(var_0.objweapon)) {
      if(var_0.objweapon.basename == "tur_gun_fd_mp_seeking") {
        var_3 = int(var_3 * level.pipe_room_dogtag_revive);
      } else if(var_0.objweapon.basename == "tur_gun_bt_mp") {
        var_3 = int(var_3 * level.pipe_room_dogtag_revive);
      }
    }
  }

  if(isDefined(var_2) && isPlayer(var_2) && var_2 method_87da(1)) {
    if(var_3 > var_11) {
      var_3 = var_11;
    }
  }

  return var_3;
}

function ref_11c9c(var_0, var_1) {
  if(isDefined(level.player_equip_regen)) {
    var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);

    if(var_2 == "iw8_fists") {
      return (var_0 * level.player_equip_regen);
    }

    return;
  }

  return var_1;
}

function elevator_lower(var_0) {
  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("modifyVehicleDamage")) {
    return scripts\mp\gametypes\br_gametypes::ref_12e05("modifyVehicleDamage", var_0);
  } else if(isDefined(level.playerbrsquadleaderscore)) {
    return [[level.playerbrsquadleaderscore]](var_0);
  }

  return var_0.damage;
}

function ref_11c66(var_0) {
  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("allowMeleeVehicleDamage")) {
    return scripts\mp\gametypes\br_gametypes::ref_12e05("allowMeleeVehicleDamage", var_0);
  }

  return 0;
}

function ref_120ab(var_0) {
  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("onVehicleDamaged")) {
    thread scripts\mp\gametypes\br_gametypes::ref_12e05("onVehicleDamaged", var_0);
    return;
  }
}

function ref_11c6b(var_0) {
  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("ignoreVehicleExplosiveDamage")) {
    return scripts\mp\gametypes\br_gametypes::ref_12e05("ignoreVehicleExplosiveDamage", var_0);
  }

  return 0;
}

function ref_11c82(var_0) {
  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("shouldLastStandDamageScale")) {
    return scripts\mp\gametypes\br_gametypes::ref_12e05("shouldLastStandDamageScale", var_0);
  }

  return 1;
}

function ref_11c67(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "supply_c130_loot":
      case "heavy_weapon_crate":
      case "battle_royale_chopper_loot":
      case "kiosk_drop":
      case "battle_royale_loadout":
      case "battle_royale_c130_loot":
      case "battle_royale_juggernaut":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function ref_11c87(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = istrue(var_1.managerespawnfade);

    if(!var_2) {
      var_2 = isDefined(var_1.cratetype) && ref_11c67(var_1.cratetype);
    }

    if(var_2) {
      managerespawnfade(var_1, var_0, 75, -75);
      return true;
    }
  }

  if(isscriptabledefined()) {
    var_3 = undefined;

    if(isDefined(var_1)) {
      var_3 = getclosestpointonnavmesh(var_1.origin);

      if(isDefined(var_3)) {
        var_4 = var_3 + (0, 0, 5);
        var_5 = playerphysicstrace(var_3, var_4);

        if(var_5 != var_4) {
          var_3 = undefined;
        }
      }
    }

    if(!isDefined(var_3)) {
      var_6 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_0.origin, 30);
      var_3 = getclosestpointonnavmesh(var_6);
    }

    if(isDefined(var_3) && isDefined(var_1) && istrue(var_1.manageprematchfade)) {
      var_7 = [];

      if(isDefined(var_1.stage1accradius) && isarray(var_1.stage1accradius)) {
        var_7 = var_1.stage1accradius;
      }

      var_8 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1);
      var_9 = scripts\engine\trace::ray_trace(var_0 gettagorigin("tag_eye"), var_3, scripts\engine\utility::array_add(var_7, var_1), var_8);

      if(isDefined(var_9["hittype"]) && var_9["hittype"] != "hittype_none" || !canspawn(var_3)) {
        var_3 = undefined;
      }
    }

    if(isDefined(var_3)) {
      var_0 setOrigin(var_3);
      return true;
    }
  }

  return false;
}

function debug_showcardlocs(var_0) {
  var_1 = (self.origin[0], self.origin[1], self.origin[2] + 36);

  if(self isonground()) {
    var_2 = (self.origin[0], self.origin[1], self.origin[2] + 20);
    self setOrigin(var_2);
  }

  var_3 = var_1 - var_0.origin;
  var_3 = vectorNormalize(var_3);
  var_4 = getdvarfloat("scr_br_alt_mode_rocketjump_mult", 1300);
  var_5 = undefined;

  if(var_3[2] > -0.3) {
    var_5 = getdvarfloat("scr_br_alt_mode_rocketjump_minz", 600);
  }

  var_6 = distance2d(var_0.origin, self.origin) - 20;
  var_7 = clamp(var_6, 0, 80) / 100 * 0.5;
  var_8 = 1;
  var_9 = var_8 - var_7;
  var_3 = var_3 * var_4 * var_9;

  if(isDefined(var_5)) {
    var_10 = var_8 - var_7 * 0.5;
    var_5 *= var_10;
    var_3 = (var_3[0], var_3[1], max(var_5, var_3[2]));
  }

  self setvelocity(var_3);
}

function difficulty_allowseekafterthreshold(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && var_0 &level.idflags_penetration) {
    var_5 = 1;
  } else {
    var_5 = 0;
  }

  if(!var_5) {
    switch (var_2) {
      case "pistol":
        if(var_3 == "iw8_pi_decho" || var_3 == "iw8_pi_cpapa") {
          if(var_4 == "head" || var_4 == "helmet") {
            var_5 = 250;
          } else {
            var_5 = 150;
          }
        }

        break;
      case "sniper":
        if(var_3 == "iw8_sn_crossbowx") {
          var_5 = 250;
        }

        break;
      default:
        break;
    }
  }

  return var_5;
}

function tutzonetriggerlogic(var_0) {
  return isDefined(var_0) && var_0 &level.idflags_penetration;
}

function usefailvehiclemsg(var_0) {
  return var_0 == "iw8_sn_delta" || var_0 == "iw8_sn_golf28" || var_0 == "iw8_sn_mike14" || var_0 == "iw8_sn_sbeta" || var_0 == "iw8_sn_sksierra";
}

function use_respawn_rules(var_0) {
  return var_0 == "s4_mr_gecho43" || var_0 == "s4_mr_m1golf" || var_0 == "s4_mr_svictor40" || var_0 == "s4_mr_malpha1916";
}

function vehicle_collision_handleevent(var_0, var_1, var_2) {
  return var_0 == "iw8_sn_xmike109" && var_1 == "MOD_PISTOL_BULLET" && var_2 == 1;
}

function unset_maze_ai_stealth_settings(var_0) {
  return var_0 == "iw8_sh_oscar12" || var_0 == "iw8_sh_aalpha12" || var_0 == "iw8_sh_t9fullauto" || var_0 == "iw8_sh_dpapa12" || var_0 == "iw8_sh_t9semiauto" || var_0 == "s4_sh_bromeo5";
}

function died_poorly_funcs(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = tutzonetriggerlogic(var_0);

  if(!var_8) {
    switch (var_1) {
      case "rifle":
        var_9 = var_5 / var_4;

        if(getweaponammopoolname(var_6) == "WEAPON/AMMO_SLUGS") {
          if(level.deletescavengerhud >= 0) {
            var_9 = var_5 / var_4;
            var_5 = min(var_5, level.deletescavengerhud);
            var_5 = int(var_9 * var_5);
          }

          break;
        }

        if(scripts\cp_mp\utility\weapon_utility::tv_station_boss(var_1)) {
          var_10 = 1;
        } else if(usefailvehiclemsg(var_2)) {
          if(var_3 == "head" || var_3 == "helmet") {
            var_5 = getdvarint("scr_br_min_snprsemi_headshot_dmg", 175);
            break;
          }

          var_10 = 1;
        } else if(var_2 == "iw8_ar_kilo433" || var_2 == "iw8_ar_t9accurate" || var_2 == "iw8_sn_t9precisionsemi") {
          var_10 = level.half_size + 1;
        } else {
          var_10 = level.half_size;
        }

        var_6 = difficulty_init(var_5, var_7, var_10);
        var_6 = int(var_10 * var_6);
        break;
      case "pistol":
      case "mg":
        if(var_3 == "iw8_pi_mike" && var_7 hasattachment("barauto_mike")) {
          return (var_6 * 0.9);
        } else if(var_3 == "iw8_pi_t9fullauto") {
          return var_6;
        } else if(var_3 == "iw8_pi_papa320" && var_7 hasattachment("akimbo_papa320")) {
          return (var_6 * 0.9);
        } else {
          var_9 = var_6 / var_5;
          var_6 = difficulty_init(var_5, var_7, level.half_size);
          var_6 = int(var_9 * var_6);
        }

        break;
      case "sniper":
        if(level.br_sniper_fixed_hs_damage == 0) {
          break;
        }

        if(var_4 == "head" || var_4 == "helmet") {
          if(vehicle_collision_handleevent(var_3, var_8, var_6)) {
            var_6 = 75;
          } else if(usefailvehiclemsg(var_3)) {
            var_6 = getdvarint("scr_br_min_snprsemi_headshot_dmg", 175);
          } else if(use_respawn_rules(var_3)) {
            return var_6;
          } else {
            var_6 = getdvarint("scr_br_min_snpr_headshot_dmg", 250);
          }
        } else if(vehicle_collision_handleevent(var_3, var_8, var_6)) {
          return var_6;
        } else {
          var_9 = var_6 / var_5;

          if(usefailvehiclemsg(var_3) || var_3 == "iw8_sn_kilo98") {
            var_11 = 1;
          } else if(var_4 == "iw8_sn_romeo700") {
            var_11 = 3;
          } else {
            var_11 = level.half_size;
          }

          var_8 = difficulty_init(var_7, var_10, var_11);
          var_8 = int(var_11 * var_8);
        }

        break;
      case "smg":
        if(var_5 == "iw8_sm_t9cqb" || var_5 == "iw8_sm_t9flechette" && var_9 == "MOD_EXPLOSIVE_BULLET") {
          return var_8;
        } else if(scripts\cp_mp\utility\weapon_utility::tv_station_boss(var_5)) {
          var_12 = 1;

          if(var_5 == "iw8_sm_t9burst") {
            var_12 = 2;
          }
        } else {
          var_12 = 3;
        }

        var_9 = var_10 / var_8;
        var_10 = difficulty_init(var_8, var_9, var_12);
        var_10 = int(var_9 * var_10);

        if(var_9 hasattachment("calcust_mpapa5") && var_10 >= 30 && var_10 != 36) {
          var_10 *= 0.92;
        }

        break;
      case "spread":
        if(var_6 == "iw8_pi_t9pistolshot" && var_9 hasattachment("akimbo_pi_t9pistolshot") && var_9 hasattachment("extclip_pi_t9pistolshot01")) {
          return (var_10 * 0.95);
        }

        if(var_6 == "iw8_pi_t9pistolshot") {
          return var_10;
        }

        if(level.delete_door_clip >= 0) {
          if(unset_maze_ai_stealth_settings(var_6) && level.delete_dropped_weapon >= 0) {
            var_13 = level.delete_dropped_weapon;
          } else {
            var_13 = level.delete_door_clip;
          }

          var_9 /= var_10;
          var_9 = min(var_9, var_13);
          var_9 = int(var_9 * var_9);
        }
      default:
        break;
    }
  }

  return var_9;
}

function disablebunker11cachelocations(var_0) {
  return istrue(var_0.gulag) && !istrue(var_0.gulagarena);
}

function difficulty_init(var_0, var_1, var_2) {
  var_3 = 0;

  if(var_2 == 4) {
    var_3 = var_1 clearvehiclesticker();
  } else if(var_2 == 3) {
    var_3 = var_1 getweaponclassint();
  } else if(var_2 == 2) {
    var_3 = var_1 getmid3damage();
  }

  if(var_3 <= 0) {
    var_3 = var_1.mindamage;
  }

  if(var_2 == 1 || var_3 <= 0) {
    var_3 = var_1.maxdamage;
  }

  if(var_0 < var_3) {
    return int(var_3);
  }

  return var_0;
}

function onplayerdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(scripts\mp\utility\weapon::iskillstreakweapon(var_6)) {
    if(scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_6) == "precision_airstrike" && istrue(level.vehicle_collision_getleveldata)) {
      return;
    }
  }

  if(isDefined(var_1) && var_1 != var_2 && isPlayer(var_1)) {
    if(var_3 >= var_7) {
      var_3 = var_7;
    }

    if(var_3 > 0) {
      var_14 = scripts\mp\utility\weapon::getweaponbasenamescript(var_6);

      if(var_14 == "rock_mp" && isalive(var_2)) {
        var_2 playlocalsound("br_gulag_rock_player_impact");
      }

      if((var_14 == "snowball_mp" || var_14 == "coal_mp") && isalive(var_2)) {
        scripts\mp\gametypes\br_alt_mode_hh::airstrike_watchownerdisown(var_14, var_1, var_2);
      }
    }

    var_1 scripts\mp\gametypes\br_public::updatebrscoreboardstat("damageDealt", var_1.pers["damage"]);
  } else if(isDefined(var_0) && var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_15 = var_0;

    if(isDefined(var_15.owner) && isPlayer(var_15.owner) && var_15.owner != var_2) {
      var_15.owner scripts\mp\gametypes\br_public::updatebrscoreboardstat("damageDealt", var_15.owner.pers["damage"]);
    }
  } else if(isDefined(var_0) && var_0 _calloutmarkerping_isvehicleoccupiedbyenemy::unrescuable_fail()) {
    var_16 = var_0;

    if(isDefined(var_16.owner) && isPlayer(var_16.owner) && var_16.owner != var_2) {
      var_16.owner scripts\mp\gametypes\br_public::updatebrscoreboardstat("damageDealt", var_16.owner.pers["damage"]);
    }
  }

  if(isDefined(var_6) && scripts\mp\utility\weapon::iskillstreakweapon(var_6)) {
    var_17 = var_3 >= var_7 && scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_6) == "precision_airstrike";
    var_18 = istrue(var_2.inlaststand);

    if(var_17 && var_18) {
      var_2.disable_hotjoining_after_time = gettime();
    }
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("onPlayerDamaged")) {
    var_19 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, var_2, var_3, var_6, var_5, var_0, undefined, var_9);
    thread scripts\mp\gametypes\br_gametypes::ref_12e05("onPlayerDamaged", var_19);
    return;
  }
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  var_0.hostdamagepercenthigh = 0;
  var_6 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_6 == "dmz" || var_6 == "rat_race" || var_6 == "risk" || var_6 == "kingslayer" || var_6 == "rumble" || var_6 == "payload" || var_6 == "rumble_invasion" || var_6 == "gold_war") {
    return;
  }

  var_7 = scripts\mp\utility\game::getlivingplayers();

  if(isDefined(level.numendgame)) {
    if(var_7.size <= level.numendgame) {
      thread startendgame(level);
    }
  }

  var_8 = level.totalplayers - var_7.size;
  var_9 = 0;

  foreach(var_11 in level.players) {
    if(isDefined(var_11.score) && var_11.score > var_9) {
      var_9 = var_11.score;
    }

    if(isDefined(var_11.petwatch) && isalive(var_11)) {
      var_12 = 1 - var_8 / level.totalplayers;
      var_11 scripts\cp_mp\pet_watch::ref_13e23(var_12, 5);
    }
  }

  if(!level.teambased) {
    var_0.score = level.totalplayers - var_7.size;

    foreach(var_11 in var_7) {
      var_11.score = var_0.score + 1;
    }

    return;
  }
}

function getalivecount(var_0) {
  var_1 = 0;
  jumpiffalse(istrue(var_0)) LOC_00000046;

  foreach(var_3 in level.teamnamelist) {
    var_1 += scripts\mp\utility\teams::getteamdata(var_3, "aliveCount");
  }

  goto LOC_000000c8;
}

function doplayerkilledsplashes(var_0, var_1) {
  if(istrue(level.usegulag) && var_0 scripts\mp\gametypes\br_public::isplayeringulag()) {
    return;
  }

  var_2 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(var_0.team, var_0.squadindex);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(var_4 != var_0) {
      var_4 thread scripts\mp\hud_message::showsplash("br_teammate_dead", undefined, var_0);
    }
  }
}

function ref_13387() {
  if(istrue(level.usegulag) && !istrue(level.gulag.shutdown)) {
    var_0 = getalivecount(0);

    if(var_0 <= getdvarint("scr_br_fc_num_players_disable", -1)) {
      scripts\mp\gametypes\br_gulag::shutdowngulag("player_count", var_0);
      return;
    }

    return;
  }
}

function ref_13388() {
  if(istrue(level.usegulag) && !istrue(level.gulag.shutdown)) {
    var_0 = getdvarint("scr_br_fc_num_teams_disable", -1);

    if(var_0 < 0) {
      return;
    }

    var_1 = ref_11f43(0);

    if(var_1 <= var_0) {
      scripts\mp\gametypes\br_gulag::shutdowngulag("team_count", var_1);
      return;
    }

    return;
  }
}

function onplayerdisconnect(var_0) {
  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("teamSpectate")) {
    thread scripts\mp\gametypes\br_spectate::ref_11be2(var_0, undefined, 0);
  }

  if(istrue(level.br_prematchstarted)) {
    thread ref_13387();
    thread ref_13388();
    thread scripts\mp\gametypes\br_gulag::onplayerdisconnect(var_0);

    if(isDefined(var_0) && istrue(var_0.inlaststand) && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "kingslayer" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
      var_0 thread scripts\mp\gametypes\br_pickups::droponplayerdeath();

      if(isDefined(var_0.watch_for_attack)) {
        var_0.watch_for_attack thread scripts\mp\damage::ref_125e3();
      }
    }
  }

  thread scripts\mp\gametypes\br_analytics::destpoint(var_0, int(scripts\mp\utility\player::isreallyalive(var_0)));

  if(isDefined(var_0)) {
    if(isDefined(var_0.team)) {
      var_1 = scripts\mp\utility\teams::getenemyteams(var_0.team);
      var_2 = [];

      foreach(var_4 in var_1) {
        if(scripts\mp\utility\teams::getteamdata(var_4, "aliveCount")) {
          var_2 = var_4;
        }
      }

      var_6 = var_2.size + 1;

      if(scripts\mp\flags::gameflag("prematch_done")) {
        var_7 = forceunsetdemeanor(var_6);
        var_8 = var_7[0];
        var_9 = var_7[1];
        var_10 = var_7[2];
        var_7 = undefined;

        if(var_8 > 0) {
          scriptableusepart(var_0, var_8, undefined, "disconnect");
          var_0.matchbonus = var_9;
          var_0.ref_12394 = var_10;
        }

        ref_1319a(var_0, var_6);
        var_0 scripts\cp_mp\utility\game_utility::ref_13168(var_6);
        scripts\mp\gamelogic::ammobox_onplayerholduse(var_0, var_6);
        var_0 scripts\mp\gametypes\br_challenges::ref_11e53();
      }

      thread setup_intel(var_0);
    }

    if(scripts\mp\flags::gameflag("prematch_done")) {
      ref_138d6(var_0);
      ref_13fcc(var_0);
    }
  }

  thread ref_14006();
}

function ref_13fcc(var_0) {
  scripts\mp\gamelogic::ref_128af(var_0);
  scripts\mp\scoreboard::ref_128a8(var_0);
  var_1 = getdvarint("online_mp_clientmatchdata_enabled", 0);

  if(var_1) {
    var_0 setshowinrealism();
    return;
  }
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(istrue(level.br_prematchstarted)) {
    if(var_3 == "MOD_EXECUTION") {
      self.ref_14436 = 1;
    } else {
      self.ref_14436 = 0;
    }

    scripts\mp\gametypes\br_pickups::droponplayerdeath(var_1);
    doplayerkilledsplashes(self, var_1);
    ref_13387();
    ref_13388();
    ref_12641(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  scripts\mp\gametypes\br_jugg_common::onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  scripts\mp\gametypes\br_pickups::resetplayerinventory();
  onplayerscore("kill", var_1, 0, self);

  if(isDefined(self.watch_for_molotov_ambush_and_spawners)) {
    scripts\mp\utility\outline::outlinedisable(self.watch_for_molotov_ambush_and_spawners, self);
    self.watch_for_molotov_ambush_and_spawners = undefined;
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("onPlayerKilled")) {
    var_10 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_2, var_4, var_3, var_0, undefined, var_5);
    var_10.hitloc = var_6;
    thread scripts\mp\gametypes\br_gametypes::ref_12e05("onPlayerKilled", var_10);
  }

  searchradiusmax(var_0, var_1, var_4);

  if(!istrue(level.br_prematchstarted)) {
    scripts\mp\gametypes\br_plunder::playerplunderlivelobbydropondeath(var_3);
    return;
  }

  thread scripts\mp\gametypes\br_quest_util::onplayerkilled(var_1, self);
  thread scripts\mp\gametypes\br_respawn::playerdied(var_1, var_4);
  scripts\mp\gametypes\br_public::ref_1319e(0);
  scripts\mp\gametypes\br_public::ref_1319c(0);
  ref_1401f(self, self, 0, 1);

  if(istrue(self.inlaststand)) {
    if(isPlayer(var_1)) {
      incrementcleanupsstat(var_1);
    }
  }

  var_11 = scripts\mp\gametypes\br_gametypes::ref_12e05("markPlayerAsEliminatedOnKilled");

  if(!isDefined(var_11)) {
    var_11 = !istrue(level.usegulag);
  }

  if(var_11) {
    ref_11b15(self, "onPlayerKilled");
  }

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    if(isbot(self) && isPlayer(var_1) && !istrue(var_1 scripts\mp\gametypes\br_public::isplayeringulag())) {
      var_1 notify("killed_enemy");
    }
  }

  if(istrue(level.disable_super_in_turret.brmayconsiderplayerdead)) {
    self.ref_1443f = scripts\mp\gametypes\br_public::ref_125f3();
  }

  if(istrue(level.disable_super_in_turret.brlootchoppercratecapturecallback)) {
    self.ref_14438 = scripts\mp\gametypes\br_public::ref_125ec();
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("kiosk_onPlayerKilled")) {
    scripts\mp\gametypes\br_gametypes::ref_12e05("kiosk_onPlayerKilled", self);
  }

  var_12 = getdvarint("scr_spawn_hvv_tokens", 0) > 0;
  var_13 = scripts\mp\gametypes\br_public::isplayeringulag();

  if(var_12 && !var_13) {
    var_14 = getdvarfloat("scr_br_hvv_token_chance_on_death", 0.5);

    if(randomfloat(1) < var_14) {
      scripts\mp\gametypes\br_gametype_olaride::spawnherovillaintoken(self.origin, var_1.angles + (0, 90, 0), self);
    }
  }

  thread ref_14006();
}

function ref_11b15(var_0, var_1) {
  ref_12640(var_0, 1, var_1);
  var_0.delay_enter_combat_after_investigating_grenade = 1;
  level notify("br_player_eliminated");
  ref_14007(var_0);
  var_0 scripts\mp\gamelogic::updateplayerleaderboardstats();
}

function ref_13f21(var_0, var_1) {
  ref_12640(var_0, 0, var_1);
  var_0.delay_enter_combat_after_investigating_grenade = 0;
  var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  ref_14007(var_0);
}

function ref_12641(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(getdvarint("scr_br_print_alive_count", 1) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife")) {
    var_10 = "*-- Kill: " + gettime() + ", ";
    var_10 += scripts\engine\utility::ter_op(isDefined(var_1) && !isstruct(var_1), var_1 getentitynumber(), "?") + scripts\engine\utility::ter_op(isDefined(var_0), "," + var_0 getentitynumber(), "") + "->";
    var_10 += scripts\engine\utility::ter_op(isDefined(self), self getentitynumber(), "?");
    var_10 += scripts\engine\utility::ter_op(isDefined(var_3), ", " + var_3, "");
    logstring(var_10);
    return;
  }
}

function ref_12640(var_0, var_1) {
  if(getdvarint("scr_br_print_alive_count", 1) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife")) {
    var_2 = scripts\engine\utility::ter_op(istrue(var_0), "*-- Mark: ", "*-- Unmark: ") + gettime() + ", ";
    var_2 += scripts\engine\utility::ter_op(isDefined(self), self getentitynumber(), "?") + ", ";
    var_2 += scripts\engine\utility::ter_op(isDefined(var_1), var_1, "gamemode");
    logstring(var_2);
    return;
  }
}

function ref_1263f(var_0, var_1, var_2) {
  if(getdvarint("scr_br_print_alive_count", 1) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife")) {
    var_3 = scripts\engine\utility::ter_op(istrue(var_0), "*-- Add: ", "*-- Remove: ") + gettime() + ", ";
    var_3 += scripts\engine\utility::ter_op(isDefined(self), self getentitynumber(), "?") + ", " + var_1 + ", ";
    var_3 += scripts\engine\utility::ter_op(isDefined(var_2), var_2, "none");
    logstring(var_3);
    return;
  }
}

function getglobalbattlepassxpmultiplier(var_0) {
  if(getdvarint("scr_br_print_alive_count", 1) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife")) {
    foreach(var_2 in level.players) {
      if(isalive(var_2) && !istrue(var_2.delay_enter_combat_after_investigating_grenade) && !var_2 scripts\mp\gametypes\br_public::ref_125ec() && !var_2 scripts\mp\gametypes\br_public::ref_125f3() && var_2.team != var_0) {
        scripts\mp\utility\script::laststand_dogtags("Player isn't eliminated and didn't win: " + var_2 getentitynumber());
      }
    }

    return;
  }
}

function ref_14007() {
  var_0 = self;
  var_1 = 0;
  var_2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

  foreach(var_4 in var_2) {
    if(istrue(var_4.delay_enter_combat_after_investigating_grenade)) {
      var_1 |= 1 << var_4.pers["squadMemberIndex"] - 1;
    }
  }

  foreach(var_4 in var_2) {
    var_4 setclientomnvar("ui_br_eliminated", var_1);
  }

  if(istrue(level.matchmakingmatch)) {
    var_8 = var_0 getfireteammembers();

    if(isDefined(var_8) && var_8.size > 0) {
      var_9 = 2;

      foreach(var_4 in var_8) {
        if(isDefined(var_4) && !istrue(var_4.delay_enter_combat_after_investigating_grenade)) {
          var_9 = 0;
          break;
        }
      }

      var_0 setclientomnvar("ui_br_squad_eliminated_active", var_9);

      foreach(var_4 in var_8) {
        var_4 setclientomnvar("ui_br_squad_eliminated_active", var_9);
      }

      return;
    }

    return;
  }
}

function incrementcleanupsstat() {
  var_0 = self;

  if(!isDefined(var_0.br_cleanups)) {
    var_0.br_cleanups = 0;
  }

  var_0.br_cleanups++;
  var_0 scripts\mp\gametypes\br_public::updatebrscoreboardstat("cleanups", var_0.br_cleanups);
}

function registercrateforcleanup(var_0) {
  level.br_pickups.crates[level.br_pickups.crates.size] = var_0;
}

function dropshield(var_0) {}

function makeitemsfromcrate(var_0) {
  var_1 = self.data;

  if(var_1.type == "personal") {
    makepersonalweaponfromcrate(var_0);
    return;
  }

  if(var_1.type == "weapon") {
    var_2 = randomintrange(2, 4);
    var_3 = 6 - var_2;
  } else {
    var_2 = randomintrange(1, 2);
    var_3 = 6 - var_2;
  }

  var_4 = 0;

  for(var_5 = 0; var_5 < var_2 && var_4 < level.br_pickups.br_dropoffsets.size; var_5++) {
    if(isDefined(makeweaponfromcrate(var_4))) {
      var_4++;
    }
  }

  for(var_5 = 0; var_5 < var_3 && var_4 < level.br_pickups.br_dropoffsets.size; var_5++) {
    if(isDefined(makeitemfromcrate(var_4))) {
      var_4++;
    }
  }
}

function makeweaponfromcrate(var_0) {
  var_1 = scripts\engine\utility::random(level.br_pickups.br_crateguns);
  var_2 = scripts\mp\gametypes\br_pickups::relics_monitor_on_player(var_1);

  if(!isDefined(var_2)) {
    return;
  }

  var_3 = scripts\engine\utility::drop_to_ground(self.origin + level.br_pickups.br_dropoffsets[var_0], 50, -200, (0, 0, 1)) + (0, 0, 24);
  var_4 = scripts\mp\gametypes\br_weapons::createspawnweaponatpos(var_3, (0, 0, 90), var_2);

  if(isDefined(var_4)) {
    var_4.isweaponfromcrate = 1;
  }

  return var_4;
}

function makeitemfromcrate(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(self.origin + level.br_pickups.br_dropoffsets[var_0], 50, -200, (0, 0, 1)) + (0, 0, 12);
  var_2 = scripts\engine\utility::random(level.br_pickups.br_crateitems);
  var_3 = var_2;
  var_4 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var_1, (0, 0, 90));
  var_5 = scripts\mp\gametypes\br_pickups::spawnpickup(var_3, var_4, 1);
  return var_5;
}

function ref_11aa0(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(self.origin + level.br_pickups.br_dropoffsets[0], 50, -200, (0, 0, 1)) + (0, 0, 12);
  var_2 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var_1, (0, 0, 90));
  var_3 = scripts\mp\gametypes\br_pickups::spawnpickup(var_0, var_2, 1);
  return var_3;
}

function makepersonalweaponfromcrate(var_0) {
  var_1 = self.data;
  var_2 = scripts\engine\utility::drop_to_ground(self.origin + (0, 0, 6), 50, -200, (0, 0, 1)) + (0, 0, 24);
  var_3 = scripts\mp\gametypes\br_weapons::createspawnweaponatposfromname(var_2, var_1.personalweaponfullname);

  if(isDefined(var_3)) {
    var_3.isweaponfromcrate = 1;
    var_0 loadweaponsforplayer([var_1.personalweaponfullname]);
  }

  return var_3;
}

function iconvisall(var_0, var_1) {}

function objvisall(var_0) {
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_0);
}

function initloot() {
  level.br_weaponweights = [];
  level.br_weaponweights["iw8_ar_mike4"] = 20;
  level.br_weaponweights["iw8_sm_mpapa5"] = 40;
  level.br_weaponweights["iw8_sh_dpapa12"] = 40;
  level.br_weaponweights["iw8_la_gromeo"] = 30;
  level.br_weaponweights["iw8_lm_kilo121"] = 10;
  level.br_weaponweights["iw8_sn_alpha50"] = 10;
  level.br_weaponweights["iw8_knife"] = 5;
  level.br_weaponweights["iw8_pi_golf21"] = 50;
  level.br_weaponweights["iw8_ar_akilo47"] = 20;
  level.br_weaponweighttotal = 0;

  foreach(var_1 in level.br_weaponweights) {
    level.br_weaponweighttotal += var_1;
  }

  level.attachmentmap = [];
  level.attachmentmap["iw8_ar_mike4"] = [];
  level.attachmentmap["iw8_ar_akilo47"] = [];
  level.attachmentmap["iw8_sm_mpapa5"] = [];
  level.attachmentmap["iw8_lm_kilo121"] = [];
  level.attachmentmap["iw8_sn_alpha50"] = [];
  level.attachmentmap["iw8_pi_golf21"] = [];
  level.attachmentmap["iw8_ar_akilo47"] = [];
  level.baseraritymap = [];
  level.baseraritymap["iw8_ar_mike4"] = 1;
  level.baseraritymap["iw8_ar_akilo47"] = 1;
  level.baseraritymap["iw8_sm_mpapa5"] = 1;
  level.baseraritymap["iw8_sh_dpapa12"] = 1;
  level.baseraritymap["iw8_la_gromeo"] = 1;
  level.baseraritymap["iw8_lm_kilo121"] = 1;
  level.baseraritymap["iw8_sn_alpha50"] = 3;
  level.baseraritymap["iw8_knife"] = 0;
  level.baseraritymap["iw8_pi_golf21"] = 0;
  level.attachraritymap = [];
  level.attachraritymap["holo"] = 1;
  level.attachraritymap["silencer"] = 2;
  level.attachraritymap["gl"] = 2;
}

function weaponlocallowed(var_0, var_1) {
  foreach(var_3 in var_1) {
    var_4 = var_3.origin[2] - 24;
    var_5 = var_3.origin[2] + 90 - 24;

    if(scripts\engine\utility::distance_2d_squared(var_3.origin, var_0.origin) < 147456 && var_0.origin[2] >= var_4 && var_0.origin[2] <= var_5) {
      return false;
    }
  }

  return true;
}

function startendgame(var_0) {
  if(istrue(level.br_debugsolotest)) {
    return;
  }

  scripts\mp\gamelogic::pausetimer();
  level.timepausestart = gettime();
  level.timelimitoverride = 1;
}

function debugtestcirclevfx(var_0) {
  if(isDefined(level.circleemitters)) {
    destroyemitters(level.circleemitters);
  }

  level notify("runDebugVFXCircleTest");
  waitframe();

  switch (var_0) {
    case 1:
      thread rundebugvfxcircletest(level, 1000, 0, 15);
      break;
    case 2:
      thread rundebugvfxcircletest(level, 2500, 1000, 20);
      break;
    case 3:
      thread rundebugvfxcircletest(level, 4500, 2500, 25);
      break;
    case 4:
      thread rundebugvfxcircletest(level, 7000, 4500, 40);
      break;
    case 5:
      thread rundebugvfxcircletest(level, 10500, 7000, 70);
      break;
    case 6:
      thread rundebugvfxcircletest(level, 15000, 10500, 80);
      break;
    case 7:
      thread rundebugvfxcircletest(level, 20000, 15000, 80);
      break;
    case 8:
      thread rundebugvfxcircletest(level, 50000, 20000, 80);
      break;
  }
}

function groundraycast(var_0) {
  var_1 = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 1);
  var_2 = var_0 + (0, 0, 10000);
  var_3 = var_2 + (0, 0, -20000);
  var_4 = physics_raycast(var_2, var_3, var_1, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var_4) && var_4.size > 0) {
    return var_4[0]["position"];
  }

  return (0, 0, 0);
}

function debugplayercirclevfx() {
  for(;;) {
    waitframe();

    if(!isDefined(level.circledebugpos) || !isDefined(level.circledebugradius)) {
      continue;
    }

    var_0 = distance2d(self.origin, level.circledebugpos) < level.circledebugradius;

    if(istrue(self.debugcircleincircle)) {
      if(!var_0 && level.debugcircleplayerfx == 0) {
        playFXOnTag(level._effect["vfx_gas_ring_player"], self, "tag_eye");
        level.debugcircleplayerfx = 1;
        self.debugcircleincircle = 0;
      }

      continue;
    }

    if(var_0 && !self.debugcircleincircle) {
      self.debugcircleincircle = 1;
      stopFXOnTag(level._effect["vfx_gas_ring_player"], self, "tag_eye");
      level.debugcircleplayerfx = 0;
    }
  }
}

function rundebugvfxcircletest(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("runDebugVFXCircleTest");

  if(!istrue(level.debugcircleplayerfx)) {
    thread debugplayercirclevfx();
  }

  var_4 = 5;
  var_5 = groundraycast(level.players[0], level.players[0].origin);
  level.circleemitters = spawnentsincircle(var_5, var_0, var_3);
  level.circledebugpos = var_5;
  wait 0.1;
  spawnvfxincircle(level.circleemitters);
  var_6 = var_2;

  while(var_2 > 0) {
    var_7 = var_2 / var_6;
    var_8 = var_1 + (var_0 - var_1) * var_7;

    if(var_4 < 0) {
      destroyemitters(level.circleemitters);

      if(var_8 <= 0) {
        return;
      }

      level.circledebugradius = var_8;
      var_4 = 5;
      level.circleemitters = spawnentsincircle(var_5, var_8, var_3);
      wait 0.1;
      spawnvfxincircle(level.circleemitters);
    } else {
      updateemitterpositions(var_5, var_8, level.circleemitters);
    }

    var_2 -= level.framedurationseconds;
    var_4 -= level.framedurationseconds;
    waitframe();
  }
}

function destroyemitters(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1])) {
      stopFXOnTag(level._effect["vfx_gas_ring_puffy"], var_0[var_1], "tag_origin");
      var_0[var_1] delete();
    }
  }
}

function updateemitterpositions(var_0, var_1, var_2) {
  var_3 = var_2.size;
  var_4 = 6.2831 * var_1;
  var_5 = 360 / var_3;

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_7 = var_5 * var_6;
    var_8 = sin(var_7) * var_1;
    var_9 = cos(var_7) * var_1;
    var_10 = groundraycast(var_0 + (var_9, var_8, 0));
    var_2[var_6].origin = var_10;
    var_2[var_6].angles = (0, var_7 + 180, 0);
  }
}

function spawnentsincircle(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 6.2831 * var_1;
  var_5 = var_4 / var_2;

  if(var_5 < 200) {
    iprintlnbold("Using " + int(var_5) + " emitters");
  } else {
    iprintlnbold("Can't use " + int(var_5) + " emitters, using 200 instead");
  }

  var_5 = min(var_5, 200);
  var_6 = 360 / var_5;

  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_8 = var_6 * var_7;
    var_9 = sin(var_8) * var_1;
    var_10 = cos(var_8) * var_1;
    var_11 = groundraycast(var_0 + (var_10, var_9, 0));
    var_3 = spawn("script_model", var_11);
    var_3[var_7] setModel("tag_origin");
    var_3[var_7].origin = var_11;
    var_3[var_7].angles = (0, var_8 + 180, 0);
  }

  return var_3;
}

function spawnvfxincircle(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    playFXOnTag(level._effect["vfx_gas_ring_puffy"], var_0[var_1], "tag_origin");
  }
}

function debuggiveperkpoints() {
  var_0 = scripts\mp\utility\game::getlivingplayers();

  foreach(var_2 in var_0) {
    var_2.br_perkpoints += 5;
  }
}

function ontimelimit() {
  if(isDefined(level.numendgame)) {
    thread startendgame(level);
  }

  level.numendgame = undefined;
}

function onplayerjointeam(var_0) {
  if(!isDefined(var_0.team)) {
    scripts\mp\utility\script::laststand_dogtags("onPlayerJoinTeam: !isDefined( player.team ) - " + var_0.name);
  }

  if(!scripts\mp\utility\teams::isgameplayteam(var_0.team)) {
    scripts\mp\utility\script::laststand_dogtags("onPlayerJoinTeam: !isGameplayTeam( player.team ) - " + var_0.name + " " + var_0.team);
  }

  thread ref_1206e(var_0);
}

function ref_1206e(var_0) {
  self endon("disconnect");
  waittillframeend();

  if(level.teambased) {
    var_1 = [];

    for(var_2 = 1; var_2 < scripts\mp\gametypes\br_public::replace_sat_piece_on_deathordisconnect() + 1; var_2++) {
      var_1 = var_2;
    }

    var_3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);
    var_4 = 1;

    foreach(var_6 in var_3) {
      if(istrue(var_6.unicornpoints)) {
        continue;
      }

      if(istrue(var_6.tutorial_usingparachute)) {
        var_4 = 0;
      }

      if(isDefined(var_6.pers["squadMemberIndex"])) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_6.pers["squadMemberIndex"]);
      }
    }

    if(var_1.size == 0 && !isDefined(var_0.pers["squadMemberIndex"])) {
      scripts\mp\utility\script::laststand_dogtags("No pers[\"squadMemberIndex\"] available, things are broken! - squadsize = " + scripts\mp\gametypes\br_public::replace_sat_piece_on_deathordisconnect() + ", team = " + var_0.team + ", squadIndex = " + var_0.squadindex + ", team size = " + var_3.size);
      return;
    }

    var_8 = undefined;

    if(isDefined(var_0.pers["squadMemberIndex"])) {
      var_8 = var_0.pers["squadMemberIndex"];
    } else {
      var_8 = var_1[0];
    }

    if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("squadLeader")) {
      ref_1319d(var_0, var_4);
    }

    ref_131a8(var_0, var_8);
    return;
  }
}

function ondeadevent(var_0) {
  if(istrue(level.br_debugsolotest) || scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "kingslayer" || scripts\mp\utility\game::round_vehicle_logic() == "rumble" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war") {
    return;
  }

  if(isDefined(var_0) && var_0 != "all") {
    thread ref_1209a(var_0);
    var_1 = [];

    foreach(var_3 in scripts\mp\utility\teams::getenemyteams(var_0)) {
      if(scripts\mp\utility\teams::getteamdata(var_3, "aliveCount")) {
        var_1 = var_3;
      }
    }

    var_5 = var_1.size + 1;

    foreach(var_7 in scripts\mp\utility\teams::getteamdata(var_0, "players")) {
      var_7 scripts\cp_mp\utility\game_utility::ref_13168(var_5);
      ref_138d6(var_7);
    }

    scripts\mp\gamelogic::default_ondeadevent(var_0);
    return;
  }
}

function ref_11f43(var_0) {
  var_1 = 0;
  var_2 = level.teamnamelist;

  foreach(var_4 in var_2) {
    if(scripts\mp\utility\teams::getteamdata(var_4, "aliveCount")) {
      if(var_0) {
        var_1++;
        continue;
      }

      var_5 = 0;
      var_6 = scripts\mp\utility\teams::getteamdata(var_4, "players");

      foreach(var_8 in var_6) {
        if(isDefined(var_8) && !var_8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        var_1++;
      }
    }
  }

  return var_1;
}

function ref_1209a(var_0) {
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level.teamnamelist) {
    if(var_4 == var_0) {
      continue;
    }

    var_5 = scripts\mp\utility\teams::getteamdata(var_4, "aliveCount");

    if(var_5) {
      var_1 = var_4;
      var_6 = var_5;

      if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("remainingPlayersAliveOnTeam")) {
        var_6 = scripts\mp\gametypes\br_gametypes::ref_12e05("remainingPlayersAliveOnTeam", var_4);
      }

      var_2 += var_5;
    }
  }

  var_8 = var_1.size + 1;
  ref_1209b(var_0, var_8, var_2, 0);
  wait 20;
  thread scripts\mp\gamelogic::setupelevatordoor();
}

function ref_1209b(var_0, var_1, var_2, var_3, var_4, var_5) {
  soundsettimescalefactorfromtable(var_0, var_1);
  scripts\mp\gametypes\br_analytics::dialog_monitor_getoffground(var_0, var_1);
  var_6 = forceunsetdemeanor(var_1);
  var_7 = var_6[0];
  var_8 = var_6[1];
  var_9 = var_6[2];
  var_6 = undefined;
  var_10 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  foreach(var_12 in var_10) {
    if(isDefined(var_12)) {
      scriptableusepart(var_12, var_7, undefined, "squadEliminated");
      var_12.ref_1287a = var_7;
      var_12.matchbonus = var_8;
      var_12.ref_12394 = var_9;
    }
  }

  if(!istrue(var_4)) {
    wait 1.5;
  }

  if(!istrue(level.vehicle_collision_getleveldata)) {
    if(!istrue(var_3) && var_2 < 5) {
      scripts\mp\gametypes\br_public::brleaderdialog("top_5_lose", 0, var_10, 1);
    } else if(!istrue(var_3) && var_2 < 10) {
      scripts\mp\gametypes\br_public::brleaderdialog("top_10_lose", 0, var_10, 1);
    } else if(!istrue(var_3) && var_2 < 25) {
      scripts\mp\gametypes\br_public::brleaderdialog("top_25_lose", 0, var_10, 1);
    }

    if(!istrue(var_5)) {
      scripts\mp\gametypes\br_public::brleaderdialog("team_loss", 0, var_10, 1);
    }
  }

  foreach(var_12 in var_10) {
    if(isDefined(var_12)) {
      thread setup_intel(var_12);
      ref_1319a(var_12, var_1);
      ref_138d6(var_12);
      scripts\mp\gamelogic::ammobox_onplayerholduse(var_12, var_1);
      ref_13fcc(var_12);
    }
  }

  ref_13120(var_0);
}

function setup_intel(var_0) {
  var_1 = self;
  var_1 endon("disconnnect");

  if(var_0 < 4) {
    var_1 scripts\cp_mp\pet_watch::below_player_eye_allowance();
  }

  var_2 = gettime();
  var_1 setclientomnvar("ui_br_player_position", var_0);

  if(!istrue(var_1.br_spectatorinitialized) && !var_1 scripts\mp\gametypes\br_public::ref_125f3() && !var_1 scripts\mp\gametypes\br_public::ref_125ec()) {
    var_1 waittill("br_spectatorInitialized");
  }

  var_1 setclientomnvar("ui_br_squad_eliminated_active", 1);
  var_1 setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
  var_1 setclientomnvar("ui_round_end_reason", game["end_reason"]["br_eliminated"]);
  var_1 scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  var_1 notify("br_team_fully_eliminated");
}

function ref_1319a(var_0) {
  var_1 = self;

  if(!isDefined(var_1) || istrue(var_1.ref_12396)) {
    return;
  }

  var_1.ref_12396 = 1;
  var_1.ref_13ab8 = var_0;

  if(var_0 <= 25) {
    var_1 scripts\mp\utility\stats::incpersstat("topTwentyFive", 1);

    if(var_0 <= 10) {
      var_1 scripts\mp\utility\stats::incpersstat("topTen", 1);

      if(var_0 <= 5) {
        var_1 scripts\mp\utility\stats::incpersstat("topFive", 1);

        if(var_0 == 1) {
          var_1 scripts\mp\utility\stats::incpersstat("wins", 1);
        }
      }
    }

    var_1 scripts\mp\gamelogic::updateplayerleaderboardstats();
    return;
  }
}

function forceunsetdemeanor(var_0) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return [0, 0, 0];
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("calculateBRBonusXP")) {
    return scripts\mp\gametypes\br_gametypes::ref_12e05("calculateBRBonusXP", var_0);
  }

  if(usingtacmap()) {
    return [0, 0, 0];
  }

  if(isDefined(level.ref_133c0) && istrue(level.ref_133c0)) {
    return [0, 0, 0];
  }

  var_1 = getdvarfloat("scr_br_time_XP_milisecond", 0.0039);

  if(!isDefined(level.ref_13864) || !isDefined(var_0) || !isDefined(level.ref_14676) || level.ref_13864 <= 0 || var_0 <= 0 || level.ref_14676 <= 0) {
    return [0, 0, 0];
  }

  var_2 = gettime() - level.ref_13864;
  var_3 = int(var_1 * var_2 + 0.5);
  var_4 = level.ref_14676 * (level.ref_14678 - var_0 + 1);
  var_5 = var_3 + var_4;
  return [var_5, var_3, var_4];
}

function usingtacmap() {
  return getdvarint("scr_subType_overrideRespawnTest", scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife"));
}

function usingobject() {
  return getdvarint("scr_subType_overrideBigTeamTest", scripts\mp\menus::ref_13733());
}

function ref_12c6f() {
  scripts\cp\vehicles\vehicle_compass_cp::ref_12c6e("driving");
  scripts\cp\vehicles\vehicle_compass_cp::ref_12c6e("alive_in_gas");
  scripts\cp\vehicles\vehicle_compass_cp::ref_12c6e("alive_not_downed");
}

function ref_138d6() {
  scripts\cp\vehicles\vehicle_compass_cp::ref_138d5("driving");
  scripts\cp\vehicles\vehicle_compass_cp::ref_138d5("alive_in_gas");
  scripts\cp\vehicles\vehicle_compass_cp::ref_138d5("alive_not_downed");
}

function searchradiusmax(var_0, var_1, var_2) {
  var_3 = self;

  if(isDefined(var_1) && var_1 _calloutmarkerping_handleluinotify_mappingdeletemarker::updateexpiredlootleader()) {
    if(isDefined(var_3.team) && isDefined(var_1.team) && var_3.team != var_1.team) {
      if(isDefined(var_2) && isDefined(var_2.basename) && var_2.basename == "tur_gun_bt_mp") {
        var_4 = var_1.vehicle.owner;

        if(isDefined(var_4) && var_4 != var_1) {
          var_4 thread scripts\mp\utility\points::sec_sys_struct_1("br_bt_turret_assist");
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function scriptableusepart(var_0, var_1, var_2) {
  if(!isDefined(self) || isbot(self) || initmaxspeedforpathlengthtable(self)) {
    return;
  }

  if(!game["timePassed"]) {
    return;
  }

  if(!(scripts\mp\utility\game::matchmakinggame() || getdvarint("force_ranking"))) {
    return;
  }

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("allowEndGameXPBonus") && (usingtacmap() || usingobject())) {
    return;
  }

  if(!getdvarint("scr_rebirth_bonus_xp_allowed", 1)) {
    var_3 = scripts\mp\utility\game::round_vehicle_logic();

    if(var_3 == "rebirth" || var_3 == "rebirth_reverse" || var_3 == "treasure_hunt" || var_3 == "rebirth_dbd" || var_3 == "rebirth_dbd_reverse") {
      return;
    }
  }

  if(isDefined(self.dialog_wait_ready) && self.dialog_wait_ready == 0) {
    return;
  }

  var_4 = 0;
  var_5 = 0;

  if(!isDefined(var_2)) {
    var_2 = "undefined";
  }

  switch (var_2) {
    case "disconnect":
      var_4 = 1;
      var_5 = 1;
      break;
    case "squadEliminated":
      var_4 = 1;
      var_5 = 1;
      break;
    case "endGame":
    case "winner":
      var_4 = 1;
      var_5 = 1;
      break;
    case "undefined":
    default:
      var_4 = 0;
      var_5 = 1;
      break;
  }

  if(isDefined(self.ref_1287a)) {
    var_0 -= self.ref_1287a;
  }

  if(var_0 > 0) {
    scripts\mp\rank::giverankxp("br_timeXPBonus", var_0, var_1, var_4, var_5);
    scripts\mp\gametypes\br_analytics::deregisterscriptableinstance(var_0, var_2);
  }

  self.dialog_wait_ready = 0;
}

function ref_1319b() {
  var_0 = 545000;
  var_1 = var_0;
  var_2 = max(1, level.maxteamsize);
  var_3 = 0;

  foreach(var_5 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var_5, "teamCount")) {
      var_3++;
    }
  }

  var_3 = max(1, var_3);
  var_7 = 200;
  var_8 = 25;
  var_9 = int(var_3 * (var_3 + 1) / 2);
  var_9 = max(var_9, 1);
  var_10 = int(var_1 / var_9 * var_2 + 0.9);
  var_10 = int(clamp(var_10, var_8, var_7));
  var_11 = getdvarint("scr_br_placement_XP_share", var_10);
  level.ref_14676 = var_11;
  level.ref_14678 = var_3;
  level.ref_13864 = gettime();
}

function searchradiusidealmax(var_0) {
  if(!isDefined(level.ref_145a5)) {
    level.ref_145a5 = freight_lift_combat();
  }

  var_1 = self.lastnormalweaponobj;
  var_2 = int(var_0 * level.ref_145a5);
  scriptableusestate("", var_2, var_1, 1, 0);
}

function freight_lift_combat() {
  var_0 = getdvarfloat("scr_br_weapon_XP_milsecond");

  if(var_0 != 0) {
    return var_0;
  }

  var_1 = 0.0031;
  return var_1;
}

function scriptableusestate(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2) || scripts\mp\utility\weapon::iskillstreakweapon(var_2) || scripts\mp\utility\weapon::isvehicleweapon(var_2)) {
    return;
  }

  if(isDefined(self.owner) && !isbot(self)) {
    scriptableusestate(self.owner, var_0, var_1, var_2);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }

  if(!isDefined(var_1) || var_1 <= 0) {
    return;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!var_3) {
    scripts\mp\utility\points::displayscoreeventpoints(var_1, var_0);
  }

  if(!level.playerxpenabled) {
    return;
  }

  thread ref_1435e(var_0, var_1, var_2, var_4);
}

function ref_1435e(var_0, var_1, var_2, var_3) {
  self endon("disconnect");

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!var_3) {
    waitframe();
    scripts\mp\utility\script::waittillslowprocessallowed();
  }

  var_4 = 0;

  if(!isDefined(var_2) || !scripts\mp\weaponrank::weaponshouldgetxp(var_2.basename)) {
    return;
  }

  var_4 = var_1;
  var_4 *= scripts\mp\weaponrank::getweaponrankxpmultipliertotal();
  var_4 = int(var_4);
  scripts\mp\rank::incrankxp(0, var_2, var_4, "brWeaponXp");

  if(level.playerxpenabled && !isai(self)) {
    if(isDefined(var_2) && (scripts\mp\utility\weapon::iscacprimaryweapon(var_2) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_2))) {
      if(!scripts\mp\utility\weapon::ispickedupweapon(var_2) || scripts\mp\utility\game::getgametype() == "br") {
        scripts\common\utility::ref_13e0a(level.ref_11b31, scripts\mp\utility\weapon::getweaponrootname(var_2), "xp_earned", var_4, -1, var_2);
        return;
      }

      return;
    }

    return;
  }
}

function freeze_bomb_vest_timer(var_0) {
  var_1 = 100;
  var_2 = 1;

  if(usingtacmap()) {
    var_2 = 0.6;
  } else {
    var_2 = 20;
  }

  var_3 = int(var_1 + var_0 * var_2 * 80 / (40 + var_0));
  var_4 = 50;
  var_3 = var_3 - var_3 % var_4 + var_4;
  return var_3;
}

function resetpostgamestateonjoinedspectators() {
  self endon("disconnect");
  var_0 = gettime();

  if(!istrue(self.br_spectatorinitialized)) {
    self waittill("br_spectatorInitialized");
  }

  var_1 = 3;
  var_2 = (gettime() - var_0) / 1000;

  if(var_2 < var_1) {
    wait var_1 - var_2;
  }

  self setclientomnvar("post_game_state", 0);
}

function ononeleftevent(var_0) {
  if(istrue(level.br_debugsolotest)) {
    return;
  }

  if(level.teambased) {
    var_1 = scripts\mp\utility\game::getlastlivingplayer(var_0);

    if(isDefined(var_1)) {
      if(istrue(scripts\mp\gametypes\br_gametypes::ref_12e05("disableLastManStandingDialog", var_1))) {
        return;
      }

      var_1 scripts\engine\utility::delaythread(0.5, &scripts\mp\gametypes\br_public::brleaderdialog, "last_man_standing", 0, [var_1]);
      return;
    }

    return;
  }

  level.lastplayerwins = scripts\mp\utility\game::getlastlivingplayer();
  level thread scripts\mp\gamelogic::endgame(level.lastplayerwins, game["end_reason"]["enemies_eliminated"]);
}

function onsuicidedeath(var_0) {
  if(!level.teambased) {
    var_1 = scripts\mp\utility\game::getlivingplayers();
    var_0.score = level.totalplayers - var_1.size;

    foreach(var_3 in var_1) {
      var_3.score = var_0.score + 1;
    }
  }

  if(!isgamebattlematch() && istrue(var_0.elevator_manager)) {
    if(!isDefined(var_0.hostdamagepercenthigh)) {
      var_0.hostdamagepercenthigh = 1;
    } else {
      var_0.hostdamagepercenthigh++;
    }

    if(var_0.hostdamagepercenthigh >= getdvarint("scr_br_kick_consecutive_suicides", 5)) {
      level thread scripts\mp\teams::vehomn_controlsarefadedoutorhidden(var_0);
      return;
    }

    return;
  }
}

function ref_11e38() {
  if(isDefined(level.forcedend)) {
    return (scripts\mp\gametypes\br_public::tutorial_playSound() && level.forcedend);
  }

  return false;
}

function brendgame(var_0, var_1, var_2, var_3) {
  if(level.gameended) {
    return;
  }

  if(isDefined(var_1)) {
    logstring("[KEY_MOMENT] BrEndGame " + var_1);
  } else {
    logstring("[KEY_MOMENT] BrEndGame");
  }

  if(!istrue(var_3)) {
    getglobalbattlepassxpmultiplier(var_0);
  }

  level.gameendtime = gettime();
  level.gameended = 1;
  level notify("game_ended", var_0);

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    if(var_1 == 25) {
      level.defensefactormod = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("DMZTut", "empty")) {
        var_4 = scripts\cp_mp\utility\script_utility::getsharedfunc("DMZTut", "empty");
        level.defenderflagreset = var_4;
      }
    } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("DMZTut", "endGameVO")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("DMZTut", "endGameVO")]]();
    }
  }

  scripts\mp\gametypes\br_gulag::shutdowngulag("end_game", 0, 1);

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    level.playerzombiethermalupdate = 1;
  }

  if(!isDefined(level.get_rid_of_minigun)) {
    scripts\mp\gametypes\br_vehicles::emptyallvehicles();
  }

  thread scripts\mp\gametypes\br_gametypes::ref_12e05("endGame", var_0);

  if(ref_11e38()) {
    scripts\mp\gamelogic::endgame_regularmp(var_0, var_1, game["end_reason"]["br_eliminated"]);
    return;
  }

  setomnvarforallclients("ui_br_transition_type", 0);
  var_5 = undefined;
  jumpiffalse(isDefined(var_0) && var_0 != "tie") LOC_000002f8;
  var_5 = scripts\mp\utility\teams::getteamdata(var_0, "players");
  ref_145cb(var_5);
  level scripts\engine\utility::delaythread(1, &scripts\mp\gametypes\br_challenges::ref_11b1d, var_0);

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(scripts\mp\gametypes\br_public::uniquelootitemid() && scripts\engine\utility::is_equal(var_1, 25)) {
    var_2 = 0;
  }

  if(isDefined(level.victorydialogvoiceoverride) && var_2) {
    scripts\mp\gametypes\br_public::brleaderdialog("team_victory", 0, var_5, undefined, undefined, undefined, level.victorydialogvoiceoverride);
    goto LOC_000001a4;
  }

  jumpiffalse(var_2) LOC_000001a4;
  scripts\mp\gametypes\br_public::brleaderdialog("team_victory", 0, var_5);
  var_6 = forceunsetdemeanor(1);
  var_7 = var_6[0];
  var_8 = var_6[1];
  var_9 = var_6[2];
  var_6 = undefined;
  scripts\mp\gametypes\br_analytics::dialog_monitor_getoffground(var_0, 1);
  scripts\mp\gametypes\br_ending::ref_13fbc(var_5);

  foreach(var_11 in var_5) {
    if(!isDefined(var_11)) {
      continue;
    }

    if(istrue(var_11.inlaststand)) {
      if(var_11 scripts\mp\laststand::playanim_aibegindismountturret("self_revive_on_kill_success", var_11)) {
        var_11 scripts\mp\laststand::onrevive(1);
      }
    }

    var_11 scripts\mp\gametypes\br_pickups::hangar_doors_opening_quadrace();

    if(istrue(var_11.tracking_max_health)) {
      var_11 notify("br_try_armor_cancel");
    }

    var_11 scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    var_11.spawnprotection = 1;
    var_11 setclientomnvar("ui_br_player_position", 1);
    scriptableusepart(var_11, var_7, undefined, "winner");
    var_11.matchbonus = var_8;
    var_11.ref_12394 = var_9;
    var_11 scripts\cp_mp\pet_watch::below_player_eye_allowance();
    scripts\mp\gametypes\br_analytics::destroyscorelaunchonly(var_11, "player_win");
    ref_1319a(var_11, 1);
    var_11 scripts\cp_mp\utility\game_utility::ref_13168(1);
    ref_138d6(var_11);
    scripts\mp\gamelogic::ammobox_onplayerholduse(var_11, 0);
    var_11 scripts\mp\gamelogic::updateplayerleaderboardstats();
    ref_13fcc(var_11);

    if(var_11 ispcplayer()) {
      var_11 setclientomnvar("nVidiaHighlights_events", 23);
    }

    if(scripts\mp\gametypes\br_public::tutorial_playSound() && !isbot(var_11)) {
      var_11 thread[[level.mover_init]]();
    }
  }

  ref_13120(var_0);
  goto LOC_000005a4;
}

function ref_145cb(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in var_0) {
    if(!isDefined(var_2) || !isPlayer(var_2)) {
      continue;
    }

    var_2 scripts\mp\gametypes\br_ending::namehud();
  }
}

function handleendgamesplash(var_0) {
  var_1 = [];

  if(isDefined(var_0) && var_0 != "tie") {
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");
  }

  var_2 = scripts\mp\gamelogic::reinforcement_icon_objective_id();

  if(scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "kingslayer" || scripts\mp\utility\game::round_vehicle_logic() == "rumble" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war") {
    thread scripts\mp\music_and_dialog::ref_12789(var_1);
  }

  foreach(var_4 in var_1) {
    var_4 setclientomnvar("post_game_state", var_2);
    var_4 setclientomnvar("ui_br_end_game_splash_type", 1);
  }
}

function setup_player_stealth(var_0) {
  if(isDefined(var_0) && var_0 != "tie") {
    var_1 = scripts\mp\gamelogic::reinforcement_icon_objective_id();

    foreach(var_3 in level.players) {
      if(isDefined(var_3.ref_126cc) && var_3.ref_126cc.team == var_0 && var_3.team != var_0 && !isDefined(var_3.shoulddropbrprimary)) {
        var_3 setclientomnvar("post_game_state", var_1);
        var_3 setclientomnvar("ui_br_end_game_splash_type", 1);
        var_3.shoulddropbrprimary = 1;
      }
    }

    return;
  }
}

function setup_player_marks(var_0) {
  if(isDefined(var_0) && var_0 != "tie") {
    var_1 = scripts\mp\gamelogic::reinforcement_icon_objective_id();

    foreach(var_3 in level.players) {
      if(var_3.team != var_0 && !isDefined(var_3.shoulddropbrprimary)) {
        var_3 setclientomnvar("post_game_state", var_1);
        var_3 setclientomnvar("ui_br_end_game_splash_type", 1);
        var_3.shoulddropbrprimary = 1;
      }
    }

    return;
  }
}

function brdpadcallback(var_0, var_1) {
  if(istrue(level.stop_end_breach_fx)) {
    return;
  }

  if(isDefined(var_0)) {
    switch (var_0) {
      case "dpad_slot_down":
        if(scripts\mp\gametypes\br_public::uniquelootitemid() && var_1 == 0) {
          if(isDefined(level.lootchopper_spawn)) {
            self thread[[level.lootchopper_spawn]](var_0, var_1);
          }

          break;
        }

        thread scripts\mp\gametypes\br_pickups::ref_1298f(var_1);
        break;
      case "dpad_slot_up":
        scripts\mp\gametypes\br_pickups::useitemfrominventory(var_1);
        break;
      case "dpad_perk_buy":
        scripts\mp\gametypes\br_perks::buyperkinslot(var_1);
        break;
      case "dpad_mayday":
        thread scripts\cp\vehicles\little_bird_mg_cp::fulton_hostage_vo();
        break;
      case "try_use_heal_slot":
        var_2 = var_1;
        scripts\mp\gametypes\br_pickups::ref_126e1(var_2);
        break;
      case "br_drop_all":
        if(scripts\mp\gametypes\br_public::uniquelootitemid() && var_1 == 0) {
          if(isDefined(level.lootchopper_spawn)) {
            self thread[[level.lootchopper_spawn]](var_0, var_1);
          }

          break;
        }

        scripts\mp\gametypes\br_pickups::ref_12988(var_1);
        break;
      default:
        break;
    }
  }
}

function get_int_or_0(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return int(var_0);
}

function parachutecomplete() {
  if(disable_fulton_group_interactions() && !dialog_mount_nag_watcher() && !istrue(self.dropbagspawned) && !istrue(level.ref_1284c)) {
    if(scripts\mp\gametypes\br_public::updatedragonsbreath()) {
      thread scripts\mp\gametypes\br_rewards::spawndropbagonlanding();

      foreach(var_1 in level.teamdata[self.team]["players"]) {
        var_1.dropbagspawned = 1;
      }
    }
  }

  if(scripts\mp\flags::gameflag("prematch_done")) {
    thread scripts\mp\gametypes\br_armory_kiosk::ref_1334a(5);
  }

  thread scripts\cp_mp\gestures::ref_13e1a();
}

function spawnintermission(var_0, var_1) {
  scripts\mp\playerlogic::setspawnvariables();
  self freezecontrols(1);
  scripts\mp\utility\player::updatesessionstate("intermission");
  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;
  self spawn(var_0, var_1);
  scripts\mp\utility\player::ref_12898("playerlogic::spawnIntermission() !!!CODE SPAWN!!! @" + var_0);
  scripts\mp\utility\player::setdof_spectator();
}

function emp_drone_proximity_explode(var_0) {
  if(!isDefined(self.ref_1286f) || self calloutmarkerping_getEnt()) {
    if(!istrue(game["switchedsides"])) {
      self setclientomnvar("ui_br_extended_load_screen", 0);
    }

    return;
  }

  thread emp_drone_should_take_damage();

  if(!isDefined(self.thrust_fx_model)) {
    var_1 = self.ref_1286f.origin;
    var_2 = scripts\mp\gametypes\br_public::ref_126b8(var_1);
    var_3 = getdvarint("scr_br_drop_prespawn_timeout_ms", 9000);
    scripts\mp\gametypes\br_public::ref_126b9(var_2, var_3, 1);

    if(!istrue(level.ref_14623) && !istrue(self.ref_14623)) {
      ending_fade_in();
      self setclientomnvar("ui_br_transition_type", 4);
    }

    wait 0.5;
    spawnintermission(var_2, self.ref_1286f.angles);
    scripts\mp\spectating::setdisabled();
  } else {
    self.thrust_fx_model = undefined;
  }

  scripts\mp\gametypes\br_public::ref_126ed();
  self freezecontrols(0);
}

function emp_drone_should_take_damage() {
  self endon("disconnect");
  self waittill("brWaitAndSpawnClientComplete");
  self clearpredictedstreampos();

  if(!istrue(level.ref_14623)) {
    self setclientomnvar("ui_br_transition_type", 0);
  }

  if(!istrue(game["switchedsides"])) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }
}

function brprematchaddkill() {
  self.kills++;
}

function eliminate_drone_attack_max_cooldown(var_0) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    self.pers["damage"] = self.pers["damage"] + var_0;
    return;
  }
}

function difficulty_think() {
  foreach(var_1 in level.players) {
    var_1.kills = 0;
    var_1.pers["kills"] = 0;
    var_1.score = 0;
    var_1.pers["score"] = 0;
    var_1.egress_landlord_vo = 0;
    var_1.pers["contracts"] = 0;
    var_1 scripts\mp\gametypes\br_public::updatebrscoreboardstat("missionsCompleted", 0);
    var_1.pers["damage"] = 0;
    var_1 scripts\mp\gametypes\br_public::updatebrscoreboardstat("damageDealt", 0);
  }
}

function difficulty_update_time(var_0) {
  level endon("game_ended");
  var_1 = getentitylessscriptablearrayinradius(undefined, undefined, undefined, undefined, "door");
  var_2 = 0;
  var_3 = isDefined(var_0) && isint(var_0);

  foreach(var_5 in var_1) {
    if(!var_5 scriptabledoorisclosed()) {
      var_5 vehicle_getinputvalue();

      if(var_3) {
        var_2++;

        if(var_2 >= var_0) {
          var_2 = 0;
          waitframe();
        }
      }
    }
  }
}

function ref_126eb(var_0) {
  var_1 = spawnStruct();
  thread ref_143f1(var_1);
  thread ref_143fc(var_1, var_0);
  var_1 waittill("waittill_proc");
  return var_1.result;
}

function ref_143f1(var_0) {
  var_0 endon("waittill_proc");
  self waittill("luinotifyserver", var_1, var_2);
  var_0.result = [var_1, var_2];
  var_0 notify("waittill_proc");
}

function ref_143fc(var_0, var_1) {
  var_0 endon("waittill_proc");
  wait var_1;
  var_0 notify("waittill_proc");
}

function playerselectspawnclass() {
  self endon("death_or_disconnect");
  self endon("last_stand_start");
  self endon("halo_kick_c130");
  level endon("game_ended");
  level endon("end_spawn_selection");

  if(getdvarint("scr_force_cac_sre_callstack", 0) == 1 && scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "sandbox" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
    var_0 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
    scripts\mp\utility\script::laststand_dogtags("playerSelectSpawnClass() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + var_0);
  }

  self setclientomnvar("ui_options_menu", 2);
  var_1 = "custom1";
  self.pers["class"] = var_1;
  self.class = var_1;
  scripts\mp\class::preloadandqueueclass(var_1);
  var_2 = getdvarfloat("scr_dropbag_timeout", 10);
  var_3 = 0;
  var_4 = var_2 > 0;

  for(;;) {
    var_5 = undefined;
    var_6 = undefined;

    if(var_4) {
      var_7 = ref_126eb(1);

      if(!isDefined(var_7)) {
        var_3 += 1;

        if(var_3 > var_2) {
          self setclientomnvar("ui_options_menu", 0);
          return 0;
        }

        self setclientomnvar("ui_options_menu", 2);
        continue;
      }

      var_5 = var_7[0];
      var_6 = var_7[1];
    } else {
      self waittill("luinotifyserver", var_5, var_6);
    }

    if(var_5 == "exit_loadout_bag") {
      return 0;
    } else if(var_5 != "class_select") {
      continue;
    }

    var_8 = 0;

    if(var_6 >= 0) {
      var_9 = scripts\mp\menus::getclasschoice(var_6);
      self.pers["class"] = var_9;
      self.class = var_9;
      scripts\mp\class::preloadandqueueclass(var_9);
      var_8 = 1;
    }

    self setclientomnvar("ui_options_menu", 0);
    return var_8;
  }
}

function playerselectspawnsequence() {
  var_0 = self;
  var_0.issquadleader = undefined;
  var_0.br_infilstarted = 0;
  var_0 endon("disconnect");
  scripts\mp\gametypes\br_vehicles::emptyallvehicles();
  var_1 = 1;
  var_2 = scripts\mp\gametypes\br_infils::getspawnselectionlockedtimer();
  var_3 = getdvarint("scr_br_match_timer", 25);
  var_4 = var_2 + 0.5 + var_3;
  var_0 thread scripts\mp\gametypes\br_infils::infilallfadetoblack(var_1, var_4, 1);
  wait var_1;
  var_0 freezecontrols(1);
  thread monitorjumpmasterclaim();

  if(disable_flag()) {
    playerselectspawnclass(var_0);
  }

  playerselectspawnlocation(var_0);
  var_0 setclientomnvar("ui_options_menu", 0);
  var_0 freezecontrols(0);
}

function playerstartselectspawnclassnonexclusion() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 freezecontrols(1);

  if(disable_flag()) {
    playerselectspawnclass(var_0);
  }

  var_0 setclientomnvar("ui_options_menu", 0);
  var_0 freezecontrols(0);
}

function playerselectspawnlocation() {
  var_0 = self;
  var_0 beginlocationselection(0, 0, 0, 0, 4);

  while(!scripts\mp\flags::gameflag("end_spawn_selection")) {
    var_1 = waittill_confirm_or_cancel("confirm_location_alt", "cancel_location");

    if(!isDefined(var_1) || var_1.string == "cancel_location") {
      continue;
    }

    waittillframeend();
    scripts\mp\gametypes\br_infils::handleinfillocationselection(var_1);
    waitframe();
  }

  var_0 endlocationselection();
}

function monitorjumpmasterclaim() {
  var_0 = self;
  var_0 endon("disconnect");
  thread listenforjumpmasterclaimluanotify();

  for(var_1 = 0; !scripts\mp\flags::gameflag("end_spawn_selection"); var_1 = 1) {
    var_2 = var_0 scripts\engine\utility::waittill_any_ents_return(var_0, "attempt_jumpmaster_claim", var_0, "squad_jumpmaster_claimed", level, "end_spawn_selection");

    if(var_2 == "attempt_jumpmaster_claim") {
      if(!var_1) {
        var_0 scripts\mp\gametypes\br_public::updatebrscoreboardstat("jumpMasterState", 2);
        var_0.issquadleader = 1;
        var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(48);
        var_3 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

        foreach(var_5 in var_3) {
          if(var_5 != var_0) {
            var_5.issquadleader = 0;
            var_5 scripts\mp\gametypes\br_public::updatebrscoreboardstat("jumpMasterState", 0);
            var_5 notify("squad_jumpmaster_claimed");
            var_5 scripts\mp\utility\lower_message::setlowermessageomnvar(49);
          }
        }
      } else {
        var_0 scripts\mp\gametypes\br_public::updatebrscoreboardstat("jumpMasterState", 1);
        var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(53);
      }

      continue;
    }

    if(var_2 == "squad_jumpmaster_claimed") {}
  }
}

function listenforjumpmasterclaimluanotify() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("listenClaimJumpMaster");
  var_0 endon("listenClaimJumpMaster");
  level endon("end_spawn_selection");

  for(;;) {
    var_0 waittill("luinotifyserver", var_1);

    if(var_1 == "attempt_jumpmaster_claim") {
      var_0 notify("attempt_jumpmaster_claim");
    }
  }
}

function sendafksquadmembertogulag() {
  var_0 = self;
  var_0.br_infilstarted = 1;
  var_0 setclientomnvar("ui_br_infil_started", 1);
  var_0 setclientomnvar("ui_br_infiled", 1);
  var_0 playershow(1);
  var_0 kill();
}

function defend_wave_2() {
  self endon("disconnect");
  self setclientomnvar("ui_br_display_perk_info", 1);
  wait 0.1;
  self setclientomnvar("ui_br_display_perk_info", 0);
}

function delay_delete_reinforcement_called_icon(var_0, var_1, var_2) {
  var_0.gettingloadout = 1;
  var_3 = undefined;

  if(isDefined(var_0.preloadedclassstruct)) {
    var_3 = var_0.preloadedclassstruct;
    var_0.preloadedclassstruct = undefined;
  } else {
    var_3 = var_0 scripts\mp\class::loadout_getclassstruct();
    var_3 = var_0 scripts\mp\class::loadout_updateclass(var_3, var_0.class);
  }

  var_0.classstruct = var_3;
  var_4 = istrue(var_0.inlaststand);
  var_5 = defaultbreakeraction(var_0, var_1, var_2);
  var_0.prevweaponobj = undefined;
  var_0 scripts\mp\class::loadout_clearperks(1);
  var_0 scripts\mp\class::loadout_updateplayerperks(var_3);
  scriptednode(var_0);

  if(isDefined(var_0.classstruct.loadoutsecondaryobject)) {
    scripts\mp\gametypes\br_weapons::br_forcegivecustomweapon(var_0, var_0.classstruct.loadoutsecondaryobject, var_0.classstruct.loadoutsecondaryfullname, var_0.classstruct.loadoutsecondary);
  }

  if(isDefined(var_0.classstruct.loadoutprimaryobject)) {
    scripts\mp\gametypes\br_weapons::br_forcegivecustomweapon(var_0, var_0.classstruct.loadoutprimaryobject, var_0.classstruct.loadoutprimaryfullname, var_0.classstruct.loadoutprimary);
  }

  var_6 = [];

  if(isDefined(var_0.classstruct.loadoutequipmentprimary)) {
    GscBinSkip0(0x2e, var_6.size, var_0.classstruct.loadoutequipmentprimary);
  }

  if(isDefined(var_0.classstruct.loadoutequipmentsecondary)) {
    GscBinSkip0(0x2e, var_6.size, var_0.classstruct.loadoutequipmentsecondary);
  }

  foreach(var_8 in var_6) {
    if(isDefined(level.br_pickups.br_equipnametoscriptable[var_8])) {
      var_9 = level.br_pickups.br_equipnametoscriptable[var_8];
      scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_0, var_9, 1);

      if(isDefined(var_5.nvgwatcher) && var_5.nvgwatcher.type == var_9) {
        scripts\mp\gametypes\br_pickups::lootused(var_5.nvgwatcher, undefined, "visible", var_0, 1);
      } else if(isDefined(var_5.nvidiaansel_allowduringcinematic) && var_5.nvidiaansel_allowduringcinematic.type == var_9) {
        scripts\mp\gametypes\br_pickups::lootused(var_5.nvidiaansel_allowduringcinematic, undefined, "visible", var_0, 1);
      }
    }
  }

  var_0.gettingloadout = 0;
  var_0 notify("giveLoadout");
  thread defend_wave_2();

  if(var_4) {
    var_11 = var_0 getcurrentprimaryweapon();

    if(!issameweapon(var_11)) {
      var_11 = getcompleteweaponname(var_11);
    }

    self.laststandoldweaponobj = var_11;
    var_12 = brchooselaststandweapon(var_0);

    if(!issameweapon(var_12)) {
      var_12 = getcompleteweaponname(var_12);
    }

    var_0 scripts\mp\laststand::givelaststandweapon(var_12);

    if(!var_0 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var_0 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
      return;
    }

    return;
  }
}

function defaultbreakeraction(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.ml_p3_to_safehouse_transition = 0;
  var_3.ref_14598 = [];
  var_3.nvgwatcher = undefined;
  var_3.nvidiaansel_allowduringcinematic = undefined;

  if(istrue(var_2)) {
    var_3.ml_p3_to_safehouse_transition = int(6.5);

    if(getdvarint("scr_br_dropBehindDistant", 0)) {
      var_3.ml_p3_to_safehouse_transition += 14;
    }
  }

  foreach(var_5 in var_0.equippedweapons) {
    var_6 = scripts\mp\utility\weapon::getweaponrootname(var_5.basename);

    if(issameweapon(var_5) && var_5.inventorytype == "primary") {
      if(var_6 != "iw8_fists" && var_6 != "iw8_knifestab") {
        var_7 = var_0 scripts\mp\gametypes\br_extract_quest::operatorsfxalias(var_5);

        if(istrue(var_1) && !var_7) {
          var_8 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_3, var_0.origin, var_0.angles, var_0);
          var_9 = scripts\mp\gametypes\br_weapons::weaponspawn(var_5, var_0, var_8, 0, 1);

          if(isDefined(var_9)) {
            var_10 = var_0 getweaponammoclip(var_5);
            var_11 = var_0 getweaponammoclip(var_5, "left");
            var_12 = 0;

            if(var_5.hasalternate) {
              var_13 = var_5 getaltweapon();

              if(!scripts\mp\gametypes\br_weapons::debug_spawn_crate_on_train(var_5, var_13)) {
                var_12 = var_0 getweaponammoclip(var_13);
              }
            }

            scripts\mp\gametypes\br_pickups::ref_119f5(var_9, var_10, var_11, var_12);
            var_3.ref_14598[var_3.ref_14598.size] = var_9;
          }
        }
      }

      var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_5);
    }
  }

  if(isDefined(var_0.equipment["primary"])) {
    if(istrue(var_1)) {
      var_15 = var_0 scripts\mp\equipment::getequipmentslotammo("primary");
      var_16 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, var_0.equipment["primary"]);

      if(isDefined(var_16) && var_15 > 0) {
        var_8 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_3, var_0.origin, var_0.angles, var_0);
        var_9 = scripts\mp\gametypes\br_pickups::spawnpickup(var_16, var_8, var_15, 1);

        if(isDefined(var_9)) {
          var_3.nvgwatcher = var_9;
        }
      }
    }

    var_0 scripts\mp\equipment::takeequipment("primary");
  }

  if(isDefined(var_0.equipment["secondary"])) {
    if(istrue(var_1)) {
      var_15 = var_0 scripts\mp\equipment::getequipmentslotammo("secondary");
      var_16 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, var_0.equipment["secondary"]);

      if(isDefined(var_16) && var_15 > 0) {
        var_8 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_3, var_0.origin, var_0.angles, var_0);
        var_9 = scripts\mp\gametypes\br_pickups::spawnpickup(var_16, var_8, var_15, 1);

        if(isDefined(var_9)) {
          var_3.nvidiaansel_allowduringcinematic = var_9;
          var_9 scripts\mp\gametypes\br_pickups::modeloadoutupdateammo(var_0, var_9.type);
        }
      }
    }

    var_0 scripts\mp\equipment::takeequipment("secondary");
  }

  var_0 giveweapon(getcompleteweaponname("iw8_fists_mp"));
  return var_3;
}

function deleteobjective() {
  self endon("disconnect");
  self freezecontrols(1);
  self setclientomnvar("ui_open_loadout_bag", 1);
  var_0 = playerselectspawnclass();
  self setclientomnvar("ui_options_menu", 0);
  self setclientomnvar("ui_open_loadout_bag", 0);
  self freezecontrols(0);
  return var_0;
}

function br_givedropbagloadout(var_0) {
  if(istrue(self.tracking_max_health)) {
    var_0 notify("br_try_armor_cancel");
  }

  var_1 = deleteobjective(var_0);

  if(istrue(var_1)) {
    scripts\cp_mp\killstreaks\airdrop::dropspecialistbonus(var_0);
  } else {
    return;
  }

  delay_delete_reinforcement_called_icon(var_0, 1, 1);
  var_2 = scripts\engine\utility::ter_op(isstartstr(var_0.class, "custom"), 1, 0);
  var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_12053(var_2);

  if(scripts\mp\utility\game::getgametype() == "br") {
    var_3 = self.origin;
    var_0 endon("disconnect");
    wait 0.5;
    scripts\mp\gametypes\br_analytics::destroy_intro_tank(var_0, var_3, self);
    scripts\mp\gametypes\br_analytics::destroyscorelaunchonly(var_0, "dropbag_used");

    if(isDefined(var_0.primaryweaponobj)) {
      var_0.primaryweaponobj.customweaponname = createheadicon(var_0.primaryweaponobj);
    }

    if(isDefined(var_0.secondaryweaponobj)) {
      var_0.secondaryweaponobj.customweaponname = createheadicon(var_0.secondaryweaponobj);
      return;
    }

    return;
  }
}

function eliminate_drone_attack_min_cooldown(var_0) {
  level notify("dropbag_kill_callout_" + self.origin);

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::destroy_bad_traversals(self.team, self.origin);
    return;
  }
}

function cleanupdropbagsoncircle() {
  if(!getdvarint("scr_br_cleanup_drop_bags_on_first_circle", 0)) {
    return;
  }

  level waittill("br_circle_started");

  while(level.br_pickups.crates.size > 0) {
    var_0 = [];

    foreach(var_2 in level.br_pickups.crates) {
      if(isDefined(var_2) && (!isDefined(var_2.curprogress) || var_2.curprogress == 0)) {
        var_2 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        continue;
      }

      var_0 = var_2;
    }

    level.br_pickups.crates = var_0;
    var_0 = undefined;
    wait 1;
  }
}

function brchooselaststandweapon() {
  var_0 = self;
  var_1 = var_0 scripts\mp\gametypes\br_public::ref_12570();

  if(!isDefined(var_1)) {
    var_1 = "iw8_gunless";
  }

  return var_1;
}

function ref_12551(var_0) {
  _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("laststand");
  scripts\mp\gametypes\br_gulag::ref_12551(var_0);
}

function ref_11c6f(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_2, var_4, var_3, var_0, undefined, var_5);
  var_9.hitloc = var_6;

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("lastStandAllowed") && !scripts\mp\gametypes\br_gametypes::ref_12e05("lastStandAllowed", var_9)) {
    return false;
  }

  return true;
}

function vandalize_internal(var_0) {
  var_1 = var_0.attacker;

  if(!isDefined(var_1)) {
    return false;
  }

  if(istrue(var_0.assistedsuicide)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    return false;
  }

  return true;
}

function enemy_mines_init(var_0) {
  if(!vandalize_internal(var_0)) {
    var_0.dokillcam = 0;
  }

  if(!var_0.dokillcam) {
    var_0.victim clearpredictedstreampos();
  }

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("teamSpectate")) {
    scripts\mp\gametypes\br_spectate::ref_11be2(var_0.victim, var_0.attacker, 1);
    return;
  }
}

function tvstation_fastrope_init(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isalive(var_0)) {
    return false;
  }

  if(istrue(var_0.gulag)) {
    return false;
  }

  if(istrue(var_0.inlaststand)) {
    return false;
  }

  return true;
}

function rpg_think(var_0) {
  var_1 = [];
  var_2 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  foreach(var_4 in var_2) {
    if(tvstation_fastrope_init(var_4)) {
      var_1 = var_4;
    }
  }

  return var_1;
}

function ref_12046(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_public::ref_12570();

  if(tvstation_fastrope_init(var_1) && !isDefined(var_2)) {
    var_3 = rpg_think(var_1.team);

    if(var_3.size < 2 && !istrue(level.watch_for_icbm_spawners)) {
      if(var_1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
        var_1 scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
      }
    }

    if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("armor")) {
      var_1 scripts\mp\gametypes\br_armor::disable_map_ammo_munitions();
      return;
    }

    return;
  }
}

function emp_drone_pick_up_use_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1) && var_1 != var_2 && var_3 >= var_2.health) {
    ref_12046(var_1, var_2);
    return;
  }
}

function disableallarmorykiosks(var_0) {
  switch (var_0) {
    case "nothing":
      return 0;
    case "noammo":
      return 1;
    case "limitedammo":
      return 2;
    case "standardammo":
      return 3;
    case "dropbag":
      return 4;
    case "dropbagtime":
      return 5;
    case "pistolarmordropbagtime":
      return 6;
    case "pistolarmor":
      return 7;
    case "altmodegoldengun":
      return 8;
    default:
      return 0;
  }
}

function disabledfeatures() {
  var_0 = "pistolarmordropbagtime";
  var_1 = getDvar("scr_br_loadout_option", var_0);
  var_2 = disableallarmorykiosks(var_1);
  level.delay_put_players_in_black_screen = var_2;
}

function disable_flag() {
  return isDefined(level.delay_put_players_in_black_screen) && (level.delay_put_players_in_black_screen == 1 || level.delay_put_players_in_black_screen == 2 || level.delay_put_players_in_black_screen == 3);
}

function disable_fulton_group_interactions() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("drogBagLoadout")) {
    return false;
  }

  return isDefined(level.delay_put_players_in_black_screen) && (level.delay_put_players_in_black_screen == 4 || level.delay_put_players_in_black_screen == 5 || level.delay_put_players_in_black_screen == 6);
}

function dialog_mount_nag_watcher() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("drogBagLoadout")) {
    return false;
  }

  return isDefined(level.delay_put_players_in_black_screen) && (level.delay_put_players_in_black_screen == 5 || level.delay_put_players_in_black_screen == 6);
}

function disable_weapon_swap_until_swap_finished() {
  var_0 = [];

  if(!isDefined(level.br_level)) {
    GscBinSkip0(0x2e, var_0.size, 1);
  }

  var_1 = scripts\mp\gametypes\br_gametypes::reinforcement_manager("dropBagDelay");

  if(isDefined(var_1)) {
    var_0 = var_1;
    return var_0;
  }

  var_2 = -15;
  var_3 = scripts\mp\gametypes\br_circle::relic_amped_pick_random_valid_player(0);
  var_4 = max(0, var_3 + var_2);
  var_5 = getdvarfloat("scr_br_dropbag_delay", var_4);

  if(var_5 < 0) {
    var_5 = var_4;
  }

  var_0 = var_5;

  if(getdvarint("scr_br_dropbag2_enabled", 0) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("dropBagLoop")) {
    var_6 = 15;
    var_7 = scripts\mp\gametypes\br_gulag::run_hud_logic();
    var_8 = max(0, var_7 + var_6);
    var_9 = getdvarfloat("scr_br_dropbag2_delay", var_8);
    var_0 = var_9;
  }

  return var_0;
}

function disable_collect_leads() {
  return isDefined(level.delay_put_players_in_black_screen) && (level.delay_put_players_in_black_screen == 6 || level.delay_put_players_in_black_screen == 7 || level.delay_put_players_in_black_screen == 8);
}

function disablealltablets() {
  switch (level.delay_put_players_in_black_screen) {
    case 8:
    case 7:
    case 6:
      return 0;
    default:
      break;
  }
}

function disable_cinematic_skip() {
  return isDefined(level.delay_put_players_in_black_screen) && (level.delay_put_players_in_black_screen == 1 || level.delay_put_players_in_black_screen == 2 || level.delay_put_players_in_black_screen == 3);
}

function disable_usability_for_duration() {
  if(isDefined(level.delay_put_players_in_black_screen)) {
    if(level.delay_put_players_in_black_screen == 2) {
      return 0.5;
    } else if(level.delay_put_players_in_black_screen == 3) {
      return 1;
    }
  }

  return 0;
}

function disable_timer() {
  if(isDefined(level.delay_put_players_in_black_screen)) {
    if(level.delay_put_players_in_black_screen == 2) {
      return 20;
    }
  }
}

function ref_125fc() {
  var_0 = spawnStruct();
  var_0.ref_12889 = [];
  var_0.brtdm_config = [];
  var_0.brtruck_cleanupents = [];
  var_0.brtruck_ontimelimit = [];
  var_0.offhands = [];
  var_0.nvidiaansel_overridecollisionradius = [];
  var_1 = [];
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var_4) && !issubstr(var_4.basename, "iw8_fists_mp") && !scripts\mp\utility\weapon::unset_relic_mythic(var_4.basename)) {
      var_1 = var_4;
    }
  }

  foreach(var_7 in var_1) {
    var_8 = createheadicon(var_7);
    var_0.brtdm_config[var_8] = weaponclipsize(var_7);
    var_0.brtruck_ontimelimit[var_8] = self getweaponammostock(var_7);

    if(scripts\mp\utility\weapon::turnexfiltoside(var_7)) {
      var_0.brtruck_cleanupents[var_8] = self getweaponammoclip(var_7, "left");
    }

    if(getsubstr(var_8, 0, 4) == "alt_") {
      continue;
    }

    var_0.ref_12889[var_0.ref_12889.size] = var_7;
  }

  if(self.lastcacweaponobj != getcompleteweaponname("none")) {
    foreach(var_4 in var_0.ref_12889) {
      if(self.lastcacweaponobj == var_4) {
        var_0.current = self.lastcacweaponobj;
        break;
      }
    }
  }

  var_12 = self getweaponslistoffhands();

  foreach(var_14 in var_12) {
    if(var_14.basename == "bandage_br") {
      continue;
    }

    var_15 = self getweaponammoclip(var_14);

    if(var_15 <= 0) {
      continue;
    }

    var_0.offhands[var_0.offhands.size] = var_14;
    var_16 = createheadicon(var_14);
    var_0.brtdm_config[var_16] = var_15;
  }

  foreach(var_19 in self.equipment) {
    var_0.nvidiaansel_overridecollisionradius[var_19] = var_20;
  }

  var_0.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent) {
    var_0.super = self.equipment["super"];
  }

  self.ref_12eb0 = var_0;
}

function ref_125fb() {
  self takeallweapons(0, 1);
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  self.equipment["primary"] = undefined;
  self.equipment["secondary"] = undefined;
  self.equipment["health"] = undefined;
  self.equipment["super"] = undefined;
  var_0 = getcompleteweaponname("iw8_fists_mp");

  if(self.ref_12eb0.ref_12889.size < 2) {
    self giveweapon(var_0);
  }

  var_1 = 0;

  foreach(var_3 in self.ref_12eb0.ref_12889) {
    var_4 = createheadicon(var_3);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3);

    if(!var_1) {
      self assignweaponprimaryslot(var_4);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_3);
      var_1 = 1;
    }

    scripts\mp\weapons::fixupplayerweapons(self, var_4);
  }

  foreach(var_7 in self.ref_12eb0.offhands) {
    var_8 = scripts\mp\equipment::getequipmentreffromweapon(var_7);

    if(!isDefined(var_8)) {
      continue;
    }

    var_9 = self.ref_12eb0.nvidiaansel_overridecollisionradius[var_8];

    if(!isDefined(var_9)) {
      continue;
    }

    scripts\mp\equipment::giveequipment(var_8, var_9);
  }

  foreach(var_4, var_12 in self.ref_12eb0.brtruck_ontimelimit) {
    self setweaponammostock(var_4, var_12);
    var_3 = getcompleteweaponname(getweaponbasename(var_4));
    var_13 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_3);

    if(isDefined(var_13)) {
      self.br_ammo[var_13] = var_12;
      scripts\mp\gametypes\br_weapons::br_ammo_player_hud_update_ammotype(var_13);
    }
  }

  foreach(var_4, var_12 in self.ref_12eb0.brtdm_config) {
    self setweaponammoclip(var_4, var_12);
  }

  foreach(var_4, var_12 in self.ref_12eb0.brtruck_cleanupents) {
    self setweaponammoclip(var_4, var_12, "left");
  }

  waitframe();
  var_16 = var_0;

  if(isDefined(self.ref_12eb0.current)) {
    var_16 = self.ref_12eb0.current;
  } else if(isDefined(self.ref_12eb0.ref_12889[0])) {
    var_16 = self.ref_12eb0.ref_12889[0];
  }

  self switchtoweaponimmediate(var_16);

  if(isDefined(self.ref_12eb0.super)) {
    var_17 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self.ref_12eb0.super]];
    scripts\mp\gametypes\br_pickups::forcegivesuper(var_17, 0);
  }

  thread scripts\cp_mp\gestures::ref_13e1a();
  self.ref_12eb0 = undefined;
}

function ending_player_disconnect_thread() {
  foreach(var_1 in level.players) {
    if(isPlayer(var_1) && var_1 scripts\mp\utility\player::isinkillcam()) {
      var_1 notify("abort_killcam");
      var_1.cancelkillcam = 1;
    }
  }
}

function disabled_seats_for_vehicle(var_0) {
  var_1 = getdvarint("scr_br_invulnerability_time", 30);

  if(var_1 > var_0) {
    var_1 = var_0;
  }

  wait var_0 - var_1;
  level.allowprematchdamage = 0;
  wait var_1 / 2;
  ending_player_disconnect_thread();
  wait var_1 / 2;
}

function ref_11b81() {
  var_0 = scripts\mp\gametypes\br_gametypes::ref_12e05("maySpawn");

  if(isDefined(var_0)) {
    return var_0;
  }

  return scripts\mp\playerlogic::mayspawn();
}

function spawnclientbr(var_0) {
  self endon("disconnect");
  self.ref_13b4f = undefined;

  if(scripts\mp\gametypes\br_public::iswaitingtoentergulag(self)) {
    self notify("attempted_spawn");
    scripts\mp\gametypes\br_gulag::entergulag(self);
    self.waitingtospawn = 0;
    return;
  }

  if(istrue(self.waitingtospawnamortize) || scripts\mp\gametypes\br_public::use_csm(self) || istrue(scripts\mp\gametypes\br_gametypes::ref_12e05("spawnHandled", self))) {
    self notify("attempted_spawn");
    self.waitingtospawn = 0;
    return;
  }

  if(!ref_11b81()) {
    waitframe();
    self notify("attempted_spawn");

    if(istrue(level.stop_visited_once) || istrue(level.snatchspawnalltoc130done) || istrue(level.debugnextpropindex)) {
      if(isDefined(level.brlatespawnplayer)) {
        self thread[[level.brlatespawnplayer]]();
      }

      return;
    }

    return;
  }

  if(istrue(var_0)) {
    level.snatchspawnalltoc130done = 0;
  }

  if(istrue(level.stop_visited_once) || istrue(level.snatchspawnalltoc130done) || istrue(level.debugnextpropindex)) {
    if(isDefined(level.brlatespawnplayer)) {
      self thread[[level.brlatespawnplayer]]();
    }

    return;
  }

  if(!istrue(level.debug_safehouse_regroup_start)) {
    if(isDefined(level.bypassclasschoicefunc)) {
      self.class = self[[level.bypassclasschoicefunc]]();
    } else {
      self.class = ref_12341();
    }
  }

  if(getdvarint("scr_br_verify_prematch_loadouts", 0) == 1) {
    thread ref_14290();
  }

  var_1 = getdvarint("scr_br_drop_prespawn", 1);
  var_2 = var_1 && ref_14070() && !isbot(self);

  if(var_1 > 1) {
    var_2 = var_2 && !istrue(self.hasspawned);
  }

  if(var_2) {
    self.ref_1286f = getspawnpoint(var_2);
  }

  scripts\mp\playerlogic::waitandspawnclient(var_0);
  self freezecontrols(1);

  if(ref_14070()) {
    thread prematchdeployparachute();
  }

  waitframe();
  self skydive_setdeploymentstatus(0);
  self skydive_setbasejumpingstatus(0);
  var_3 = !self calloutmarkerping_getEnt();
  var_4 = scripts\mp\teams::getcustomization()["body"];
  var_5 = gettime();

  if(var_3) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedcustomizationviewmodels(var_4) && !self hasloadedviewweapons(self.weaponlist)) {
      if(var_5 + 3000 < gettime()) {
        break;
      }

      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;
  self freezecontrols(0);
}

function didgasmaskpipschange(var_0, var_1, var_2) {
  var_3 = 360 / var_0.size;
  var_4 = getdvarint("scr_br_x1OpsFinalCircleRadiusOffset", 10000);
  var_5 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_6 = 0;

  if(isDefined(var_2)) {
    var_6 = var_2;
  } else {
    var_6 = scripts\mp\gametypes\br_circle::getdangercircleradius() - var_4;
  }

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    var_8 = var_6 * cos(var_3 * var_7);
    var_9 = var_6 * sin(var_3 * var_7);
    var_10 = var_5[0] + var_8;
    var_11 = var_5[1] + var_9;
    var_12 = 0;
    var_13 = (var_10, var_11, var_12);

    if(var_1) {
      foreach(var_15 in var_0) {
        var_15.emp_target_list = var_13;
      }

      continue;
    }

    var_0[var_7].emp_target_list = var_13;
  }
}

function ref_1254d() {
  if(scripts\cp_mp\execution::hasexecution()) {
    self.ref_12eae = self.executionref;
    scripts\cp_mp\execution::_clearexecution();
    self disableexecutionattack();
    return;
  }
}

function ref_1254e() {
  if(isDefined(self.ref_12eae)) {
    scripts\cp_mp\execution::_giveexecution(self.ref_12eae);
    self enableexecutionattack();
    self.ref_12eae = undefined;
    return;
  }
}

function ref_144ae() {
  level endon("game_ended");
  self notify("br_squad_leader_shift");
  self endon("br_squad_leader_shift");
  var_0 = self;
  var_1 = var_0.team;
  var_2 = var_0.squadindex;
  var_3 = scripts\mp\utility\game::round_vehicle_logic();

  for(;;) {
    var_4 = "";

    if(var_3 == "dmz" || var_3 == "rat_race" || var_3 == "sandbox" || var_3 == "risk" || var_3 == "rumble" || var_3 == "payload" || var_3 == "gold_war") {
      var_4 = var_0 scripts\engine\utility::ref_143b4("disconnect", "br_pass_squad_leader");
    } else {
      var_4 = var_0 scripts\engine\utility::ref_143b6("death", "disconnect", "remove_from_alive_count", "br_pass_squad_leader");
    }

    if(var_4 == "br_pass_squad_leader") {
      if(!ref_13aae(var_1)) {
        var_0 playlocalsound("br_pickup_deny");
        continue;
      }
    }

    if(var_4 != "disconnect") {
      if(!scripts\mp\flags::gameflag("prematch_done")) {
        continue;
      }

      if(!istrue(var_0.br_infilstarted)) {
        continue;
      }
    }

    if(arenastpday(var_0, var_1, var_2)) {
      return;
    }
  }
}

function ref_131a8(var_0) {
  var_1 = self;
  var_1.pers["squadMemberIndex"] = var_0;
  var_2 = var_1.game_extrainfo & 65528;
  var_2 |= var_0;
  var_1.game_extrainfo = var_2;
}

function ref_1319d(var_0) {
  var_1 = self;

  if(var_0 == var_1 scripts\mp\gametypes\br_public::updatedragonsbreath()) {
    return;
  }

  var_1.tutorial_usingparachute = var_0;

  if(var_0) {
    var_1.game_extrainfo |= 64;
    thread ref_144ae();
    return;
  }

  var_1.game_extrainfo &= ~64;
}

function arenastpday(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_0)) {
    var_0 = var_2.team;
  }

  if(!isDefined(var_1)) {
    var_1 = var_2.squadindex;
  }

  if(isDefined(var_2) && !var_2 scripts\mp\gametypes\br_public::updatedragonsbreath()) {
    return 0;
  }

  if(isDefined(var_2)) {
    var_2.should_update_track_timer = 1;
  }

  var_3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_2.squadindex);
  var_4 = 0;
  var_5 = undefined;

  foreach(var_7 in var_3) {
    var_8 = ref_12512(var_7);

    if(var_8 > var_4) {
      var_4 = var_8;
      var_5 = var_7;
    }
  }

  var_10 = 0;

  if(isDefined(var_5)) {
    if(isDefined(var_2)) {
      ref_1319d(var_2, 0);
    }

    ref_1319d(var_5, 1);
    var_10 = 1;

    if(!istrue(level.debugnextpropindex)) {
      level scripts\mp\gametypes\br_public::dmztut_endgamewithreward("deploy_squad_leader", var_5, 1, 0);
    }
  }

  ref_1401e(var_0, var_1);
  return var_10;
}

function ref_13aae(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_1);
  var_3 = 0;

  foreach(var_5 in var_2) {
    if(!isDefined(var_5) || var_5 scripts\mp\gametypes\br_public::updatedragonsbreath()) {
      continue;
    }

    if(!isalive(var_5)) {
      continue;
    }

    if(var_5 ismlgspectator() || var_5 isspectatingplayer()) {
      continue;
    }

    if(var_5 scripts\mp\gametypes\br_public::isplayeringulag()) {
      continue;
    }

    if(!istrue(var_5.should_update_track_timer)) {
      var_3 = 1;
      break;
    }
  }

  return var_3;
}

function ref_1401e(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_1);
  var_3 = ref_13aae(var_0, var_1);

  foreach(var_5 in var_2) {
    var_5 setclientomnvar("ui_br_squad_leader_can_pass", var_3);
  }
}

function ref_12512(var_0) {
  if(!isDefined(var_0) || var_0 scripts\mp\gametypes\br_public::updatedragonsbreath() || var_0 ismlgspectator() || var_0 isspectatingplayer() || !isalive(var_0)) {
    return 0;
  }

  if(var_0 scripts\mp\gametypes\br_public::isplayeringulag()) {
    return 1;
  }

  if(istrue(var_0.inlaststand)) {
    return 2;
  }

  if(istrue(var_0.should_update_track_timer)) {
    return 3;
  }

  return 4;
}

function ref_13ac7(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\utility\teams::getteamdata(var_2, "players");

  foreach(var_6 in var_4) {
    if(!istrue(var_6.gulag)) {
      var_6 thread scripts\mp\hud_message::showsplash(var_0, var_3, var_1);
    }
  }
}

function ref_131c8(var_0) {
  self.issuperdisabled = var_0;

  if(!var_0) {
    new_agent_def_main();
    return;
  }

  var_1 = scripts\mp\supers::getcurrentsuper();

  if(isDefined(var_1)) {
    var_2 = var_1.staticdata.weapon;
    var_3 = self getweaponammoclip(var_2);
    self.loadoutextraperksfromgamemode = var_3;
  }

  self notify("super_disable_start");
  thread scripts\mp\supers::watchsuperdisableplayer();
}

function new_agent_def_main() {
  var_0 = "super_delay_mp";
  var_1 = scripts\mp\supers::getcurrentsuper();

  if(isDefined(var_1)) {
    var_2 = var_1.staticdata.weapon;
    var_3 = 0;

    if(isDefined(self.loadoutextraperksfromgamemode)) {
      var_3 = self.loadoutextraperksfromgamemode;
      self.loadoutextraperksfromgamemode = undefined;
    }

    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
    self setweaponammoclip(var_2, var_3);
    self assignweaponoffhandspecial(var_2);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
  }

  self notify("super_disable_end");
}

function roundnumber() {
  if(!istrue(self.issuperdisabled)) {
    return 0;
  }

  var_0 = 0;

  if(isDefined(self.loadoutextraperksfromgamemode)) {
    var_0 = self.loadoutextraperksfromgamemode;
  }

  return var_0;
}

function ref_12099(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
    if(!isDefined(var_1) || var_1.size == 0) {
      var_2 = var_0 getcurrentweapon();
      var_3 = var_0 getcurrentweaponclipammo();
      var_4 = weaponclipsize(var_2);

      if(var_3 < var_4) {
        var_0 setweaponammoclip(var_2, var_4);
        var_0 scripts\mp\damagefeedback::hudicontype("br_ammo");
        var_0 playlocalsound("iw8_support_box_use");
        return true;
      }
    }
  }

  foreach(var_6 in var_1) {
    var_7 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_6);

    if(var_6.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var_6.underbarrel) == "ubshtgn") {
      var_8 = weaponclipsize(var_6);
      var_9 = int(var_8);
      var_0 setweaponammoclip(var_6, var_9);
      var_6.ref_12cc1 = 1;
      continue;
    } else if(scripts\mp\utility\weapon::update_health_on_spawn(var_6)) {
      var_0 setweaponammoclip(var_6, var_6.clipsize);
      var_6.ref_12cc1 = 1;
      continue;
    } else if(!isDefined(var_7)) {
      continue;
    }

    var_10 = int(level.br_ammo_max[var_7] / level.br_ammo_clipsize[var_7]);
    var_0 scripts\mp\gametypes\br_weapons::delay_delete_alerted_icon(var_6, var_10);
    var_6.ref_12cc1 = 1;
  }

  if(isDefined(var_0.equipment["primary"])) {
    var_0 scripts\mp\equipment::incrementequipmentammo(var_0.equipment["primary"], 2);
  }

  if(isDefined(var_0.equipment["secondary"])) {
    var_0 scripts\mp\equipment::incrementequipmentammo(var_0.equipment["secondary"], 2);
  }

  var_0 scripts\mp\damagefeedback::hudicontype("ammobox");
  scripts\mp\equipment\support_box::ref_139ae(var_0);
  thread scripts\mp\equipment\support_box::supportbox_onplayeruseanim();
  return true;
}

function ref_11ffe(var_0) {
  var_1 = var_0 scripts\mp\equipment::getequipmentmaxammo("equip_armorplate");

  if(var_1 <= 0) {
    return false;
  }

  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_0, "brloot_armor_plate", 1, var_1, 0);
  var_0 scripts\mp\damagefeedback::hudicontype("br_armor");
  scripts\mp\equipment\support_box::ref_139ae(var_0);
  thread scripts\mp\equipment\support_box::supportbox_onplayeruseanim();
  return true;
}

function airdrop_registercrateforcleanup(var_0) {
  registercrateforcleanup(var_0);
}

function br_ammorestock_playeruse(var_0) {
  dropshield(var_0);
}

function airdrop_makeweaponfromcrate() {
  makeweaponfromcrate();
}

function airdrop_makeitemfromcrate() {
  makeitemfromcrate();
}

function airdrop_makeitemsfromcrate(var_0) {
  makeitemsfromcrate(var_0);
}

function airdrop_br_givedropbagloadout(var_0) {
  br_givedropbagloadout(var_0);
}

function br_armor_repair_end(var_0) {
  eliminate_drone_attack_min_cooldown(var_0);
}

function br_armor_plate_used(var_0) {
  scripts\mp\gametypes\br_gametypes::ref_12e05("initCrateData", var_0);
}

function ref_12082(var_0) {
  var_1 = var_0 getcurrentprimaryweapon();
  var_0 scripts\mp\gametypes\br_weapons::delay_delete_alerted_icon(var_1);
  var_0 scripts\mp\gametypes\br_plunder::ref_12627(level.scavengerplunderamount);
}

function ref_1205c(var_0, var_1) {
  var_0 scripts\mp\gametypes\br_pickups::setup_train_array(var_1, "primary");
}

function ref_1203b(var_0, var_1) {
  switch (var_0) {
    case "iw8_fulton_bag_mp":
      thread _debug_rooftopobjstart::playerwager(var_1);
      break;
    case "slinger_br":
      thread scripts\mp\equipment\slinger::slinger_used(var_1);
      break;
    case "rock_mp":
      thread scripts\mp\gametypes\br_gulag::rock_used(var_1);
      break;
    case "coal_mp":
      var_1 thread scripts\mp\gametypes\br_alt_mode_hh::airstrike_watchgameend();
      break;
    default:
      break;
  }

  if(var_0 == "rock_mp" && istrue(self.ref_13b4f)) {
    var_1 delete();
    self.ref_13b4f = undefined;
    return;
  }
}

function ref_120b0(var_0) {
  scripts\mp\gametypes\br_weapons::takeweaponpickup(var_0);
}

function ref_120af(var_0) {
  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
}

function ref_12691() {
  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("playerShouldRespawn")) {
    return scripts\mp\gametypes\br_gametypes::ref_12e05("playerShouldRespawn");
  }

  if(!istrue(level.br_prematchstarted)) {
    return 1;
  }

  if(scripts\mp\gametypes\br_public::iswaitingtoentergulag(self)) {
    return 1;
  }

  if(scripts\mp\gametypes\br_public::use_csm(self)) {
    return 1;
  }

  return 0;
}

function emp_drone_damage_monitor(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_gametypes::ref_12e05("playerKilledSpawn", var_0, var_1);

  if(isDefined(var_2)) {
    return var_2;
  } else if(scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "kingslayer" || scripts\mp\utility\game::round_vehicle_logic() == "rumble" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war") {
    if(getdvarint("scr_bmo_use_spawn_fix", 1) == 1) {
      if(scripts\mp\utility\game::updatehistoryhud(self)) {
        return 1;
      }

      if(!scripts\mp\flags::gameflag("prematch_done")) {
        return 0;
      }

      if(istrue(var_0.victim.hasrespawntoken) || istrue(level.ref_14062)) {
        if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
          if(isbot(var_0.victim)) {
            return 1;
          }
        }

        if(scripts\mp\utility\game::round_vehicle_logic() == "rat_race") {
          var_0.victim thread scripts\mp\gametypes\br_gametype_rat_race::playerrespawn();
        } else {
          var_0.victim thread scripts\mp\gametypes\br_gametype_dmz::playerrespawn();
        }

        var_3 = scripts\mp\utility\teams::getteamdata(var_0.victim.team, "teamCount");

        if(var_3 > 1) {
          var_0.victim thread scripts\mp\gametypes\br_spectate::spawnspectator(var_0, var_1, 1);
        }

        return 1;
      }
    } else {
      if(!scripts\mp\flags::gameflag("prematch_done")) {
        return 0;
      }

      if(istrue(var_1.victim.hasrespawntoken) || istrue(level.ref_14062)) {
        if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
          if(isbot(var_1.victim)) {
            return 1;
          }
        } else if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          var_1.victim thread scripts\mp\playerlogic::respawn_asspectator(var_1.victim.origin + (0, 0, 60), var_1.victim.angles);
        }

        var_1.victim thread scripts\mp\gametypes\br_gametype_dmz::playerrespawn();
        return 1;
      }
    }
  } else if(!ref_12691()) {
    if(!scripts\mp\utility\damage::playershoulddofauxdeath(0)) {
      var_1.victim thread scripts\mp\gametypes\br_spectate::spawnspectator(var_1, var_2);
    }

    return 1;
  }

  return 0;
}

function dyn_door(var_0) {
  var_1 = scripts\mp\gametypes\br_gametypes::ref_12e05("mayConsiderPlayerDead", var_0);

  if(isDefined(var_1)) {
    return var_1;
  }

  return dynamic_door(var_0);
}

function dynamic_door(var_0) {
  var_1 = var_0 scripts\mp\gametypes\br_gulag::trygulagspawn();

  if(scripts\mp\flags::gameflag("prematch_done") && !var_1) {
    ref_11b15(var_0, "considerPlayerDead");
  }

  return !var_1;
}

function ref_13f24() {}

function ref_11d22() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = gettime();

  for(;;) {
    self waittill("weapon_change");
    var_1 = gettime();
    var_2 = var_1 - var_0;
    var_0 = var_1;

    if(ref_13301() && var_2 > 3000) {
      thread searchradiusidealmax(var_2);
    }

    var_3 = self.lastnormalweaponobj;

    if(isDefined(var_3)) {
      var_4 = int(var_2 / 1000);
      var_5 = getweaponvariantindex(var_3);
      var_6 = var_3.basename;

      if(getsubstr(var_6, 0, 4) == "iw8_" || getsubstr(var_6, 0, 3) == "s4_") {
        var_6 = scripts\mp\utility\weapon::getweaponrootname(var_3);
      }

      scripts\common\utility::ref_13e0a(level.ref_11b31, var_6, "time_used_s", var_4, var_5, var_3);
    }
  }
}

function ref_13301() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("weaponXpOverTime")) {
    return false;
  }

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("weaponXpOverTime")) {
    return true;
  }

  if(scripts\mp\gametypes\br_public::validtousesticker() || scripts\mp\gametypes\br_public::uniquelootitemid() || scripts\mp\utility\game::updatex1stashhud()) {
    return false;
  }

  return true;
}

function weaponshouldgetxp(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  return weaponhasranks(var_1);
}

function weaponhasranks(var_0) {
  if(!isDefined(level.weaponranktable.maxweaponranks[var_0])) {
    return 0;
  }

  var_1 = level.weaponranktable.maxweaponranks[var_0] > 0;
  return var_1;
}

function bush_zones() {
  var_0 = scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "kingslayer" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war" || istrue(level.vehicle_collision_getleveldata) || isDefined(level.ref_12d05) || isDefined(level.ref_12ce8);

  if(var_0) {
    return;
  }

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("playerCountLandmarks")) {
    return;
  }

  level endon("game_ended");
  level waittill("prematch_started");
  var_1 = scripts\mp\utility\game::round_vehicle_logic() == "rebirth_reverse";
  ref_1269d(level, 50, var_1);
  ref_1269d(level, 25, var_1);
  ref_1269d(level, 10, var_1);
  ref_1269d(level, 5, var_1);
}

function ref_1269d(var_0, var_1) {
  level endon("game_ended");
  var_2 = reinforcement_type();

  while(var_2.size > var_0) {
    level scripts\engine\utility::waittill_either("br_player_eliminated", "players_remaining_changed");
    var_2 = reinforcement_type();

    if(var_2.size <= var_0) {
      var_3 = !istrue(level.usegulag) || istrue(level.gulag.shutdown);

      if(var_1 || var_3) {
        scripts\mp\gametypes\br_public::brleaderdialog("top_" + var_0, 0, undefined, 1);
      }

      break;
    }
  }
}

function reinforcement_type() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(istrue(var_2.delay_enter_combat_after_investigating_grenade)) {
      continue;
    }

    if(var_2 scripts\mp\gametypes\br_public::ref_125f3()) {
      continue;
    }

    if(var_2 scripts\mp\gametypes\br_public::ref_125ec()) {
      continue;
    }

    if(level.codcasterenabled) {
      if(var_2 ismlgspectator()) {
        continue;
      }
    }

    var_0 = var_2;
  }

  return var_0;
}

function ref_12c6a(var_0) {
  if(isDefined(var_0.gulaguses) && var_0.gulaguses > 0) {
    return;
  }

  if(istrue(var_0.play_cinderblock_broken_fx) && !istrue(level.ref_133bf)) {
    return;
  }

  var_1 = var_0 scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
  var_0.pers["afkResetTime"] = var_1;
  var_0.pers["distTrackingPassed"] = undefined;
  var_0.pers["totalDistTraveledAFK"] = undefined;
  var_0 thread scripts\mp\playerlogic::totaldisttracking(var_0.origin, 1);
}

function ref_12036(var_0) {
  ref_12c6a(var_0);

  if(isalive(var_0) && !istrue(var_0.inlaststand)) {
    var_0.elevator_manager = undefined;
  }

  var_0 scripts\cp_mp\vehicles\vehicle_compass::fulton_initanims();
}

function ref_1401f(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.pers["squadMemberIndex"])) {
    if(!isDefined(level.deletescriptableinstance)) {
      level.deletescriptableinstance = [];
    }

    var_4 = get_int_or_0(level.deletescriptableinstance[var_0.team]);

    if(!isalive(var_0)) {
      var_3 = 1;
      var_2 = 0;
    }

    var_5 = var_0 == var_1;
    var_6 = var_0.pers["squadMemberIndex"];
    var_7 = int(ceil(clamp(var_2, 0, 1) * 128));
    var_8 = var_7;

    if(istrue(var_3)) {
      var_0 scripts\mp\gametypes\br_public::ref_131a6(0);
    } else if(var_5) {
      var_0 scripts\mp\gametypes\br_public::ref_131a6(1);
    }

    var_9 = var_6 * 8;
    var_10 = (var_8 & 255) << var_9;
    var_11 = ~(255 << var_9);
    var_12 = var_4 &var_11;
    var_13 = var_12 + var_10;
    level.deletescriptableinstance[var_0.team] = var_13;
    var_14 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

    if(isDefined(var_14) && var_14.size > 0) {
      foreach(var_16 in var_14) {
        var_16 setclientomnvar("ui_br_squad_revive_status", var_13);
      }

      return;
    }

    return;
  }
}

function forest_barrel_damage_watch(var_0) {
  var_1 = [0, 0, 0, 0];

  if(isDefined(var_0) && isDefined(var_0.ejectplayerfromturret)) {
    var_2 = 0;

    foreach(var_4 in var_0.ejectplayerfromturret) {
      var_5 = scripts\mp\gametypes\br_quest_util::getquesttableindex(var_7);
      var_6 = int(clamp(var_4, 0, 15)) << 4;
      var_1 = var_6 + var_5;
      var_2++;

      if(var_2 >= 4) {
        break;
      }
    }
  }

  var_8 = [];
  var_8[0] = (var_1[0] << 8) + var_1[1];
  var_8[1] = (var_1[2] << 8) + var_1[3];
  var_8[2] = get_int_or_0(var_0.defaultclassindex);
  var_9 = int(clamp(get_int_or_0(var_0.pers["squadMemberIndex"]) - 1, 0, 3));
  var_8[3] = var_9 << 14;
  var_8[3] = var_8[3] + get_int_or_0(var_0.pers["damage"]);
  return var_8;
}

function ref_12065() {
  if(!isDefined(self.sessionteam) || self.sessionteam == "spectator" || self.sessionteam == "none" || isDefined(self.thrust_fx_model) || self calloutmarkerping_getEnt()) {
    return false;
  }

  if(scripts\mp\menus::shouldmodesetsquads() && !isDefined(self.squadindex)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::tutorial_playSound() && !isbot(self)) {
    self setclientomnvar("ui_br_extended_load_screen", 1);
    return false;
  }

  if(!ref_14070()) {
    return true;
  }

  var_0 = scripts\mp\gametypes\br_gametypes::ref_12e05("onConnectSpawnPoint");

  if(!isDefined(var_0)) {
    var_0 = getspawnpoint();
  }

  self.thrust_fx_model = var_0;
  var_1 = scripts\mp\gametypes\br_gametypes::ref_12e05("initialPrespawnZOffset");

  if(isDefined(var_1)) {
    self.thrust_fx_model.origin += (0, 0, var_1);
  }

  if(istrue(game["switchedsides"])) {
    setomnvar("ui_current_round", 1);
  }

  self setclientomnvar("ui_br_extended_load_screen", 1);
  var_2 = scripts\mp\gametypes\br_public::ref_126b8(var_0.origin);
  spawnintermission(var_2, var_0.angles);
  var_3 = getdvarint("scr_br_initial_stream_timeout_ms", 15000);
  scripts\mp\gametypes\br_public::ref_126b9(var_2, var_3, 1, 1);
  return false;
}

function ref_125f1() {
  return self.sessionstate == "intermission" && isDefined(self.thrust_fx_model);
}

function waittillmatch_wait() {
  var_0 = -1;

  if(isDefined(self.lastdroppableweaponobj)) {
    var_0 = getaltbunkerindexforname(self.lastdroppableweaponobj);
  }

  self setclientomnvar("ui_br_last_droppable_weapon", var_0);
}

function endgame_luidecisionreceived(var_0) {
  var_1 = scripts\mp\gametypes\br_gametypes::ref_12e05("regenHealthAdd", var_0);

  if(isDefined(var_1)) {
    return var_1;
  }

  return var_0;
}

function endgame_finitewaves_vo(var_0) {
  var_1 = scripts\mp\gametypes\br_gametypes::ref_12e05("regenDelaySpeed", var_0);

  if(isDefined(var_1)) {
    return var_1;
  }

  return var_0;
}

function elements_hidden(var_0, var_1, var_2) {
  scripts\mp\gametypes\br_gametypes::ref_12e05("addToTeamLives", var_0, var_1);
  ref_1263f(var_0, 1, var_1, var_2);
}

function elevator_doors_open(var_0, var_1, var_2) {
  scripts\mp\gametypes\br_gametypes::ref_12e05("removeFromTeamLives", var_0, var_1);
  ref_1263f(var_0, 0, var_1, var_2);
}

function ref_14006() {
  level notify("updatePlayerAndTeamCountUI");
  level endon("updatePlayerAndTeamCountUI");
  waittillframeend();
  var_0 = level.players.size;
  var_1 = 0;
  var_2 = 0;
  var_3 = [];
  var_4 = [];

  for(var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = level.players[var_5];

    if(!istrue(var_6.delay_enter_combat_after_investigating_grenade)) {
      if(istrue(var_6.iszombie) || istrue(var_6.unset_relic_gun_game)) {
        var_2++;
      } else {
        var_1++;
        var_3 = 1;
        var_4 = var_6.team;
      }
    }

    if(!scripts\engine\utility::array_contains_key(var_3, var_6.team)) {
      var_7 = scripts\mp\gametypes\br_gametypes::ref_12e05("isTeamEliminated", var_6.team);

      if(isDefined(var_7)) {
        if(!var_7) {
          var_3 = 1;
          var_4 = var_6.team;
        }
      }
    }
  }

  var_9 = (var_2 << 16) + (var_3.size << 8) + var_1;
  setomnvar("ui_br_match_stats", var_9);
}

function demo_debug_nuke() {
  var_0 = 0;
  level.teamswithplayers = [];
  var_1 = 0;

  foreach(var_3 in level.teamnamelist) {
    var_4 = scripts\mp\utility\teams::getteamdata(var_3, "teamCount");

    if(var_4) {
      var_0 += var_4;
      var_1++;
      level.teamswithplayers[level.teamswithplayers.size] = var_3;

      if(var_1 > 1) {
        break;
      }
    }
  }

  if(scripts\mp\utility\game::matchmakinggame() && !level.ingraceperiod && (!isDefined(level.disableforfeit) || !level.disableforfeit) && !scripts\mp\menus::brking_updateteamscore()) {
    if(level.teambased) {
      if(level.teamswithplayers.size == 1 && game["state"] == "playing") {
        thread scripts\mp\gamelogic::onforfeit(level.teamswithplayers[0]);
        return;
      }

      if(level.teamswithplayers.size > 1) {
        level.forfeitinprogress = undefined;
        level notify("abort_forfeit");
      }
    } else {
      if(var_0 == 1 && level.maxplayercount > 1) {
        thread scripts\mp\gamelogic::onforfeit();
        return;
      }

      if(var_0 > 1) {
        level.forfeitinprogress = undefined;
        level notify("abort_forfeit");
      }
    }
  }

  if(level.teamswithplayers.size == 1 && istrue(level.br_debugsolotest)) {
    return;
  }

  if(!scripts\mp\utility\game::getgametypenumlives() && (!isDefined(level.disablespawning) || !level.disablespawning)) {
    return;
  }

  if(!scripts\mp\utility\game::gamehasstarted()) {
    return;
  }

  if(level.ingraceperiod && !isDefined(level.overrideingraceperiod)) {
    return;
  }

  debugprintvipstates();
  debugthink();

  if(level.teambased) {
    var_6 = [];
    var_7 = 0;
    var_8 = 0;
    var_9 = [];
    var_10 = [];

    foreach(var_12 in level.teamnamelist) {
      var_6 = 0;

      if(!istrue(level.disablespawning)) {
        foreach(var_14 in scripts\mp\utility\teams::getteamdata(var_12, "players")) {
          if(!istrue(var_14.hasspawned) || var_14.team == "spectator" || var_14.team == "follower" || var_14.team == "free") {
            continue;
          }

          if(var_14.pers["lives"]) {
            var_6 = var_6[var_12] + var_14.pers["lives"];
            var_7 = 1;
          }
        }
      }

      var_16 = scripts\mp\utility\teams::getteamdata(var_12, "aliveCount");

      if(!var_8 && var_16 > 0) {
        var_8 = 1;
      }

      var_17 = 1;
      var_18 = scripts\mp\gametypes\br_gametypes::ref_12e05("isTeamEliminated", var_12);

      if(isDefined(var_18)) {
        if(!var_18) {
          var_17 = 0;
        }
      }

      if(var_17 && scripts\mp\utility\teams::getteamdata(var_12, "hasSpawned") && var_16 <= 0 && !var_6[var_12] && !scripts\mp\utility\teams::getteamdata(var_12, "deathEvent")) {
        var_9 = var_12;
        continue;
      }

      if(var_16 == 2 && !scripts\mp\utility\teams::getteamdata(var_12, "twoLeft")) {
        if(scripts\mp\utility\game::round_vehicle_logic() != "brdov" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "kingslayer" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
          var_19 = scripts\mp\utility\teams::getteamdata(var_12, "alivePlayers");
          var_20 = scripts\engine\utility::random(var_19);
          level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_20, "inform_last_two");
        }

        scripts\mp\utility\teams::setteamdata(var_12, "twoLeft", 1);
        continue;
      }

      if(var_16 == 1) {
        if(gettime() > scripts\mp\utility\teams::getteamdata(var_12, "oneLeftTime") + 5000 && !scripts\mp\utility\teams::getteamdata(var_12, "oneLeft")) {
          var_21 = 0;
          var_19 = scripts\mp\utility\teams::getteamdata(var_12, "players");

          foreach(var_14 in var_19) {
            if(!isalive(var_14)) {
              var_21 += var_14.pers["lives"];
            }
          }

          if(var_21 == 0) {
            scripts\mp\utility\teams::setteamdata(var_12, "oneLeftTime", gettime());
            scripts\mp\utility\teams::setteamdata(var_12, "oneLeft", 1);

            if(var_19.size > 1) {
              [[level.ononeleftevent]](var_12);
            }
          }
        }

        continue;
      }

      scripts\mp\utility\teams::setteamdata(var_12, "oneLeft", 0);
    }

    if(!var_8 && !var_7) {
      if(istrue(level.postgameexfil) && level.gameended) {
        level notify("exfil_continue_game_end");
      }

      if(istrue(level.nukeincoming)) {
        return;
      }

      return [[level.ondeadevent]]("all");
    }

    if(istrue(level.postgameexfil) && level.gameended) {
      level notify("exfil_continue_game_end");
    }

    if(!istrue(level.skipondeadevent) && !istrue(level.nukeincoming)) {
      foreach(var_12 in var_9) {
        if(level.multiteambased) {
          scripts\mp\utility\teams::setteamdata(var_12, "deathEvent", 1);
          [[level.ondeadevent]](var_12);
          continue;
        }

        return [[level.ondeadevent]](var_12);
      }
    }
  } else {
    var_6 = 0;

    foreach(var_14 in level.players) {
      if(var_14.team == "spectator" || var_14.team == "follower") {
        continue;
      }

      var_6 += var_14.pers["lives"];
    }

    var_29 = 0;

    foreach(var_12 in level.teamnamelist) {
      var_29 += scripts\mp\utility\teams::getteamdata(var_12, "aliveCount");
    }

    if(!var_29 && !var_6) {
      if(istrue(level.nukeincoming)) {
        return;
      }

      return [[level.ondeadevent]]("all");
    }

    var_32 = scripts\mp\utility\game::getpotentiallivingplayers();

    if(var_32.size == 1) {
      return [[level.ononeleftevent]]("all");
    }
  }

  scripts\mp\gametypes\br_gametypes::ref_12e05("postUpdateGameEvents");
}

function ref_11a5c() {
  return istrue(level.ref_11a5d) && getdvarint("br_lowpop_allow_tweaks", 1);
}

function delay_loading_screen_omnvar(var_0) {
  var_1 = istrue(var_0) && scripts\mp\gametypes\br_gulag::checkgulagusecount();
  return istrue(self.inlaststand) && !istrue(self.shouldgetnewspawnpoint) && !var_1;
}

function delay_delete_tv_station_boss_icon() {
  var_0 = [];
  var_1 = [];
  var_2 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  jumpiffalse(level.teambased) LOC_00000135;

  foreach(var_4 in level.teamnamelist) {
    var_5 = 0;

    foreach(var_7 in level.teamdata[var_4]["alivePlayers"]) {
      if(delay_loading_screen_omnvar(var_7, var_2)) {
        continue;
      }

      var_5 = 1;
      break;
    }

    if(var_5) {
      foreach(var_7 in level.teamdata[var_4]["alivePlayers"]) {
        if(delay_loading_screen_omnvar(var_7, var_2)) {
          continue;
        }

        var_0 = var_7;
      }

      continue;
    }

    foreach(var_7 in level.teamdata[var_4]["alivePlayers"]) {
      if(delay_loading_screen_omnvar(var_7, var_2)) {
        var_1 = var_7;
      }
    }
  }

  goto LOC_0000017e;
}

function debugprintvipstates() {
  if(!getdvarint("scr_br_laststandfinisher", 0)) {
    return;
  }

  if(istrue(level.watch_for_flash_detonation)) {
    return;
  }

  if(scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "kingslayer" || scripts\mp\utility\game::round_vehicle_logic() == "rumble" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war") {
    return;
  }

  var_0 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  var_1 = 0;
  var_2 = 0;
  jumpiffalse(level.teambased) LOC_00000120;

  foreach(var_4 in level.teamnamelist) {
    var_5 = 0;

    foreach(var_7 in level.teamdata[var_4]["alivePlayers"]) {
      if(delay_loading_screen_omnvar(var_7, var_0)) {
        var_2 = 1;
        continue;
      }

      var_5 = 1;
      break;
    }

    if(var_5) {
      var_1++;

      if(var_1 > 1) {
        return;
      }
    }
  }

  goto LOC_00000172;
}

function debugthink(var_0, var_1) {
  if(!istrue(level.delay_makeuseable)) {
    return 0;
  }

  if(istrue(scripts\mp\gametypes\br_public::tutorial_playSound())) {
    return 0;
  }

  if(isDefined(level.start_escape_silo)) {
    return 0;
  }

  level.start_escape_silo = 1;
  var_2 = scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("ignoreZombiesLastStandWipe");
  var_3 = scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("ignoreGhostsLastStandWipe");
  var_4 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  var_5 = [];
  var_6 = 0;
  var_7 = [];

  foreach(var_9 in level.teamnamelist) {
    var_10 = 1;
    var_5 = [];
    var_11 = 0;
    var_12 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic(var_9);

    for(var_13 = 0; var_13 < var_12.size; var_13++) {
      var_14 = var_12[var_13];
      var_15 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(var_9, var_14);

      foreach(var_17 in var_15) {
        var_18 = istrue(var_4) && var_17 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();

        if(var_18) {
          continue;
        }

        if(var_2 && var_17 scripts\mp\gametypes\br_public::ref_125f3()) {
          continue;
        }

        if(var_3 && var_17 scripts\mp\gametypes\br_public::ref_125ec()) {
          continue;
        }

        if(istrue(var_1) && isDefined(var_0) && var_0 == var_17) {
          var_11 = 1;
          continue;
        }

        var_19 = istrue(var_17.inlaststand) || isDefined(var_0) && var_0 == var_17;

        if(var_19 && !istrue(var_17.shouldgetnewspawnpoint) && !var_17 scripts\mp\gametypes\br_public::ref_125f3() && !var_17 scripts\mp\gametypes\br_public::ref_125ec()) {
          var_5 = var_17;
          continue;
        }

        var_10 = 0;
        break;
      }
    }

    if(var_10 && (var_5.size > 0 || istrue(var_1) && var_11)) {
      var_21 = [];

      foreach(var_17 in var_5) {
        if(isDefined(self.watch_for_attack) && !scripts\engine\utility::array_contains(var_21, self.watch_for_attack)) {
          self.watch_for_attack.ref_145d0 = self.watch_for_player_enter_puddle_trigger;
          var_21 = self.watch_for_attack;
        }

        if(isDefined(var_0) && var_0 == var_17) {
          var_6 = 1;
        }

        var_17 notify("squad_wipe_death");
        var_17.ref_13749 = 1;
        var_17 scripts\mp\utility\damage::_suicide(0);
      }

      if(istrue(var_1) && isDefined(var_0) && isDefined(var_0.watch_for_attack) && !scripts\engine\utility::array_contains(var_21, var_0.watch_for_attack)) {
        if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("assignLastStandAttacker")) {
          var_0 scripts\mp\gametypes\br_gametypes::ref_12e05("assignLastStandAttacker", var_21);
        } else {
          var_21 = var_0.watch_for_attack;
        }
      }

      foreach(var_25 in var_21) {
        var_25 thread scripts\mp\events::killeventtextpopup("team_wiped", 0);
        var_25 thread scripts\mp\utility\points::giveunifiedpoints("team_wiped", var_25.ref_145d0);
        var_25.ref_145d0 = undefined;
        thread ref_13ad0(var_25, var_0, var_25);

        if(!isDefined(var_7[var_25.team])) {
          var_7 = 1;
          var_25 playsoundtoteam("ui_team_wipe_splash", var_25.team);
        }
      }
    }
  }

  level.start_escape_silo = undefined;
  return var_6;
}

function ref_13ad0(var_0, var_1, var_2) {
  waitframe();

  if(getdvarint("scr_disable_br_teamwiped_message", 1)) {
    if(isDefined(var_0)) {
      obituary(var_0, var_1, var_2, "MOD_TEAM_WIPED", scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(var_1.team, var_1.squadindex));
      return;
    }

    return;
  }
}

function disable_all_turrets_permanently(var_0) {
  if(disablebunker11cachelocations(var_0)) {
    return false;
  }

  if(isagent(var_0)) {
    return false;
  }

  return true;
}

function threat_sight_monitor(var_0) {
  if(var_0 scripts\mp\utility\game::rankingenabled() && var_0 hasplayerdata()) {
    var_0 setplayerdata("mp", "aarValue", 0, 0);
    var_0 setplayerdata("mp", "aarValue", 1, 0);
    var_0 setplayerdata("mp", "aarValue", 2, 0);
    var_0 setplayerdata("mp", "aarValue", 3, 0);
    var_0 setplayerdata("mp", "aarValue", 4, 0);
    var_0 setplayerdata("mp", "aarValue", 5, 0);
    var_1 = var_0 getplayerdata("common", "mpProgression", "playerLevel", "xp");
    var_0 setplayerdata("mp", "aarValue", 6, var_1);
    var_0 setplayerdata("mp", "aarValue", 7, var_1);
    return;
  }
}

function ref_13120(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  foreach(var_3 in var_1) {
    if(!var_3 scripts\mp\utility\game::rankingenabled() || !var_3 hasplayerdata()) {
      continue;
    }

    var_4 = var_3.pers["combatXP"];

    if(!isDefined(var_4)) {
      var_4 = 0;
    }

    var_3 setplayerdata("mp", "aarValue", 0, var_4);
    var_5 = var_3.pers["missionXP"];

    if(!isDefined(var_5)) {
      var_5 = 0;
    }

    var_3 setplayerdata("mp", "aarValue", 1, var_5);
    var_6 = var_3.pers["lootingXP"];

    if(!isDefined(var_6)) {
      var_6 = 0;
    }

    var_3 setplayerdata("mp", "aarValue", 2, var_6);
    var_7 = 0;

    if(isDefined(var_3.matchbonus)) {
      var_7 = int(var_3.matchbonus);
    }

    var_3 setplayerdata("mp", "aarValue", 4, var_7);
    var_8 = 0;

    if(isDefined(var_3.ref_12394)) {
      var_8 = int(var_3.ref_12394);
    }

    var_3 setplayerdata("mp", "aarValue", 5, var_8);
    var_9 = var_3 getplayerdata("mp", "aarValue", 6);
    var_10 = var_9 + var_3.pers["summary"]["xp"];
    var_3 setplayerdata("mp", "aarValue", 7, var_10);
  }
}

function disabledvehicles(var_0, var_1) {
  if(isDefined(self.vehicle)) {
    var_2 = var_0.streakname;

    if(var_2 == "manual_turret") {
      return false;
    }
  }

  return true;
}

function display_hint_single(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0.owner;

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!istrue(var_0.ref_133ce) && !var_1 scripts\mp\gametypes\br_pickups::make_chair_ai_spawner(var_0)) {
    return 0;
  }

  var_2 = scripts\mp\gametypes\br_gametypes::ref_12e05("onKillstreakBeginUseFunc", var_0);

  if(isDefined(var_2)) {
    return var_2;
  }

  return scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakbeginuse(var_0);
}

function elevator_init(var_0) {
  return var_0 == 1;
}

function votes() {
  var_0 = self.currentprimaryweapon;

  if(isDefined(var_0) && isDefined(var_0.basename) && (var_0.basename == "iw8_spotter_scope_mp" || var_0.basename == "iw8_spotter_scope_mp_ch3")) {
    self setweaponammoclip(var_0, self getcurrentweaponclipammo() + 1);
    return;
  }
}

function ending_viewing_players_setup(var_0) {
  if(!isDefined(var_0.operatorcustomization) || !isDefined(var_0.operatorcustomization.voice) || var_0 scripts\mp\gametypes\br_public::ref_125f3() || var_0 scripts\mp\gametypes\br_public::ref_125ec()) {
    return true;
  }

  return false;
}

function ending_fade_in(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_compass_tacopsmap_cursor_pos_override_x", var_0);
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_compass_tacopsmap_cursor_pos_override_y", var_1);
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_compass_tacopsmap_size_override", var_2);
    return;
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_compass_tacopsmap_cursor_pos_override_x", level.br_circle.dangercircleent.origin[0]);
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_compass_tacopsmap_cursor_pos_override_y", level.br_circle.dangercircleent.origin[1]);
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_compass_tacopsmap_size_override", level.br_circle.dangercircleent.origin[2]);
    return;
  }

  _calloutmarkerping_handleluinotify_added::ref_13133("ui_compass_tacopsmap_cursor_pos_override_x", 0);
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_compass_tacopsmap_cursor_pos_override_y", 0);
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_compass_tacopsmap_size_override", 0);
}

function prematchperiod() {
  if(istrue(game["switchedsides"])) {
    level.connectingplayers = getdvarint("party_partyPlayerCountNum");

    if(getdvarint("scr_live_lobby", 0) == 1 && !istrue(level.ref_133e0)) {
      game["inLiveLobby"] = 0;
      game["liveLobbyCompleted"] = 1;
      level.allowprematchdamage = 1;

      if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("allowLateJoiners")) {
        setnojipscore(1, 1);
        setnojiptime(1, 1);
        level.nojip = 1;
      }

      level scripts\mp\gamelogic::livelobbymatchstarttimer("match_starting_in", 15);
      level notify("start_prematch");
      level.prematchperiod = 0;
    } else if(!istrue(level.ref_133e0)) {
      level.allowprematchdamage = 1;
      level scripts\mp\gamelogic::livelobbymatchstarttimer("match_starting_in", 15);
    }

    if(istrue(level.ref_133e0)) {
      while(!level.players.size) {
        waitframe();
      }
    }

    level notify("prematch_started");
    physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 2);
    level.prematchstarted = 1;
    level.prematchperiodend = 0;
    scripts\mp\gamelogic::matchstarttimerskip();
    physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 0);
    return true;
  }

  return false;
}

function risk_flagspawncountchange() {
  if(isDefined(level.defend_main)) {
    return level.defend_main;
  }

  var_0 = ["iw8_me_t9loadout", "iw8_me_t9mace", "iw8_me_t9etool", "iw8_me_t9machete", "iw8_me_t9mace", "iw8_me_t9bat", "iw8_me_t9sledgehammer", "iw8_me_t9sai", "iw8_me_t9battleaxe"];
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  level.defend_main = var_2;
  return var_2;
}

function risktokencount() {
  if(isDefined(level.delete_undeployed_subway_cars)) {
    return level.delete_undeployed_subway_cars;
  }

  var_0 = ["s4_me_knife", "s4_me_katana", "s4_me_leiomano"];
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  level.delete_undeployed_subway_cars = var_2;
  return var_2;
}

function riskspawn_initialset() {
  if(isDefined(level.demoforcesre)) {
    return level.demoforcesre;
  }

  var_0 = ["s4_mg_bromeo37", "s4_mg_dpapa27", "s4_mg_mgolf42", "s4_mg_tyankee11"];
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  level.demoforcesre = var_2;
  return var_2;
}

function risktokencountondeath() {
  if(isDefined(level.demotehvt)) {
    return level.demotehvt;
  }

  var_0 = ["s4_sh_becho", "s4_sh_bromeo5", "s4_sh_lindia98", "s4_sh_mike97"];
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  level.demotehvt = var_2;
  return var_2;
}

function ending_fade_out() {
  var_0 = getdvarint("scr_br_recheckAFK", 0);
  return var_0;
}

function guard_shack_mantle(var_0, var_1) {
  if(!isDefined(var_1.ref_125e4)) {
    return var_0;
  }

  var_2 = var_0;
  var_3 = (gettime() - var_1.ref_125e4) * 0.001;

  if(var_3 >= level.decoy_clearaithreatbiasgroup && var_3 < level.decoy_giveassistpoint) {
    var_2 *= level.decoy_aicanseeanyplayer;
    return var_2;
  }

  if(var_3 >= level.decoy_giveassistpoint && var_3 < level.decoy_delaystoptrackingassist) {
    var_2 *= level.decoy_canseeplayer;
    return var_2;
  }

  if(var_3 >= level.decoy_delaystoptrackingassist) {
    var_2 *= level.decoy_aiseenplayerrecently;
    return var_2;
  }

  return var_2;
}