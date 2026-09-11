/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_embassy\cp_so_embassy.gsc
***********************************************************/

function main() {
  ref_11c1e();
  thread labelpc();
  thread ref_12bcf((-3688.5, -1275.5, 128));
  thread ref_12bce((-2009.28, -486.884, 60), "alley_push_04");
  thread ref_13927((-3718.76, -1644.87, 40), 100);
  thread lb_dmg_factor_main_rotor((2156, 1629, 92), 200);
  thread lb_dmg_factor_main_rotor((-1022.36, -1363.69, 84), 100);
  scripts\cp\laser_traps\cp_laser_traps::init_minigun_lifetime_shot_count("warp_custom_1", (2311.76, 1671.9, 54.1039), (2311.76, 1595.9, 54.1039), (0, 270, 0), "traverse_warp_over", (2324, 1641.94, 127.054));
  scripts\cp\laser_traps\cp_laser_traps::init_minigun_lifetime_shot_count("ladder_custom_1", (-166.454, 139.447, 46.5), (-165.454, 183.947, 195), (0, 90, 0), "ladder_up");
  level.increase_total_count_per_module_call = 1;
  ref_12844();
  init_flags();
  setdvarifuninitialized("scr_use_squads", 1);
  setdvarifuninitialized("scr_squad_max", 4);
  setdvarifuninitialized("scr_squad_leader_max", 2);
  setdvarifuninitialized("scr_ai_squad_move_type", "1");
  setdvarifuninitialized("scr_smoketest", "0");
  thread monitoraveragevelocityandupdate();
  scripts\cp\utility::coop_mode_enable();
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::registerscriptedagents();
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_precache::main();
  scripts\cp\maps\cp_so_embassy\gen\cp_so_embassy_art::main();
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_fx::main();
  setdvarifuninitialized("so_embassy_start", 0);

  if(level.createfx_enabled) {
    return;
  }

  scripts\cp\vehicle::init_vehicles();
  level thread scripts\cp\cp_objectives::objectives_init();
  level.ref_12177 = 1;
  level.hostdamagefactorlow = 0;
  level.ref_133ba = 1;
  level.map_interaction_func = &scripts\cp\maps\cp_so_embassy\cp_so_embassy_interactions::register_interactions;
  level.custom_onspawnplayer_func = &scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_124a6;
  level.custom_onplayerconnect_func = &scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::onplayerconnect;
  level.weapon_rank_event_table = "scripts/cp/maps/cp_so_embassy/cp_so_embassy_weaponrank_event.csv";
  level.player_interaction_monitor = &scripts\cp\maps\cp_so_embassy\cp_so_embassy_interactions::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &scripts\cp\maps\cp_so_embassy\cp_so_embassy_interactions::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = &scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::interaction_trigger_properties;
  level.strike_player_connect_black_screen_fn = &scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_1247b;
  level.mud_sfx = &mud_sfx;

  if(!scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_init("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_init("strike_init_done");
  }

  level thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::wait_for_pre_game_period();
  level thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::wait_for_strike_init_complete();
  level thread scripts\cp\cp_movers::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level.additional_laststand_weapon_exclusion = [];
  level.devgui_setup_func = &scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::onplayerspawneddevguisetup;

  if(level.scripted_spawner_func.size < 1) {
    scripts\engine\utility::flag_set("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_init("infil_complete");
  }

  var_0 = getDvar("cp_so_embassy_start_obj", "");

  if(isDefined(var_0) && var_0 != "") {
    level thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::rundebugstartobjective(var_0);
  }

  level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  scripts\cp\cp_compass::setupminimap("compass_map_cp_so_embassy");
  scripts\engine\utility::flag_set("infil_complete");
  scripts\engine\utility::flag_init("moody_traversal_on");
  level.vehicle.templates.deathmodel["veh8_civ_lnd_techo_rusty_green"] = "veh8_civ_lnd_techo_rebel_static_dst_green";
  thread monitorcontrolscallback();
}

function mud_sfx(var_0) {
  if(var_0 == "axis") {
    return 0;
  }

  var_1 = 60000;

  if(level.time_survived < 12 * var_1) {
    return 3;
  } else if(level.time_survived < 14 * var_1) {
    return 2;
  } else if(level.time_survived < 20 * var_1) {
    return 1;
  }

  return 0;
}

function handle_train_collision_items(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_1, "targetname");
  var_3 = sortbydistance(var_3, var_0);

  foreach(var_5 in var_3) {
    if(var_6 > 5) {
      break;
    }

    var_5 delete();
  }
}

function lb_dmg_factor_main_rotor(var_0, var_1) {
  var_2 = getnodesinradius(var_0, var_1, 0, 200);

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4.type, "Begin")) {
      destroynavlink(var_4);
    }
  }
}

function player_fired_gun() {
  var_0 = getnodesinradius((2156, 1629, 92), 100, 0, 500);
  var_1 = [];

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::is_equal(var_3.type, "Begin")) {
      var_1 = var_3;

      if(isDefined(var_3.target)) {
        var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
        var_1 = var_4;
        var_5 = getnode(var_3.target, "targetname");
        var_1 = var_5;
      }
    }
  }

  foreach(var_8 in var_1) {
    var_8.origin += (150, 0, 0);
  }

  var_1[0] connectpaths();
}

function labelpc() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "technical_truck_spawner_01_techo");
}

function ref_12bcf(var_0) {
  var_1 = getentarrayinradius(undefined, undefined, var_0, 1500);

  foreach(var_3 in var_1) {
    if(var_3.classname == "trigger_multiple_flag_set") {
      var_3 delete();
    }
  }
}

function ref_12bce(var_0, var_1) {
  var_2 = getentarrayinradius(undefined, undefined, var_0, 1500);

  foreach(var_4 in var_2) {
    if(var_4.classname == "trigger_multiple_flag_set") {
      if(scripts\engine\utility::is_equal(var_4.script_flag, "flag_string")) {
        var_4 delete();
      }
    }
  }
}

function ref_13927(var_0, var_1) {
  var_2 = getnodesinradius(var_0, var_1, 0);

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_flag_wait)) {
      var_4.script_flag_wait = undefined;
    }
  }
}

function ref_11cf3(var_0, var_1) {
  var_2 = getnodesinradius(var_0, var_1, 0, 200);

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4.type, "Begin")) {
      ref_11cf4(var_4);
    }
  }
}

function ref_11cf4() {
  scripts\engine\utility::flag_set("moody_traversal_on");
  badplace_global("moody_traversal", 10, "axis");
  wait 10;
  scripts\engine\utility::flag_clear("moody_traversal_on");
}

function ref_11cf5() {
  self endon("death");

  while(isalive(self)) {
    self waittill("traverse_begin");

    if(!scripts\engine\utility::flag("moody_traversal_on")) {
      getcorpstablestate(self.origin, 200);
    }
  }
}

function getcorpstablestate(var_0) {
  var_1 = getnodesinradius(var_0, 100, 0, 100);

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.type, "Begin")) {
      ref_11cf4(var_3);
    }
  }
}

function ref_11c1e() {
  var_0 = getEntArray("minimap_corner", "targetname");
  GscBinSkip1(0x45, 0, (5128.15, 2125.27, 25));
}

function display_ai() {
  level endon("game_ended");
  var_0 = (1, 1, 0);
  var_1 = (0, 1, 0);
  var_2 = (1, 0, 0);
  var_3 = ["axis", "allies", "total"];

  for(;;) {
    var_4 = 30;

    foreach(var_6 in var_3) {
      if(var_6 == "total") {
        var_7 = getaiarray().size;
      } else {
        var_7 = getaiarray(var_6).size;
      }

      if(var_7 < 20) {
        var_8 = var_1;
      } else if(var_7 < 30) {
        var_8 = var_0;
      } else {
        var_8 = var_2;
      }

      var_4 += 15;
    }

    waitframe();
  }
}

function ref_12844() {}

function monitoraveragevelocityandupdate() {
  setsaveddvar("MKNNNONLSK", 4);
  setsaveddvar("MMLNNQSTTL", 5);
  setsaveddvar("NQNQPRLRQM", 1);
  setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
  setsaveddvar("LTQMSPKRKO", 6);
  level.spotupdatelimit = getdvarint("LTQMSPKRKO");
  setsaveddvar("MROOOROPKL", 8);
  level.roundrobinlimit = getdvarint("MROOOROPKL");
  setsaveddvar("LKOLRONRNQ", 750);
  level.spotdistcull = getdvarint("LKOLRONRNQ");
  var_0 = getEnt("price_green_beam_fill_light", "targetname");
  var_0 setlightintensity(0);
  var_1 = getEnt("price_green_beam_rim_light", "targetname");
  var_1 setlightintensity(0);
  level.flare_light = getEnt("flare_fx_light", "targetname");
  level.flare_light_up = getEnt("flare_fx_light_up", "targetname");
  level.flare_light.og_angles = level.flare_light.angles;
  level.flare_light setlightintensity(0);
  level.flare_light_up setlightintensity(0);
  level.flare_light.intensity = undefined;
  level.flare_lifetime = 20;
  level.ref_13af4 = 0;
  level.jumpcomandsregistered = 0;
  level.vfx_htown_stab_blink_2 = 0;
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::ref_13af6();
  createthreatbiasgroup("players");
  createthreatbiasgroup("allies");
  createthreatbiasgroup("axis");
  setthreatbias("players", "axis", 10000);
  setthreatbias("allies", "axis", 9000);
  var_2 = getEnt("computer_on", "targetname");
  var_2 hide();
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::starscores();
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::openbunkerdoor();
  thread mid_encounter_package_thread();
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::ref_13d20();
  thread wavetime();
  thread ref_12a61();
  thread ref_11c4a();
  thread ref_13d1f();
  thread chopper_boss_fight_stage_trigger_think();
  thread set_relic_healthpacks();
  thread ref_1305c();
  thread set_relic_hideobjicons();
  thread playscorestatusdialog();
  thread ref_12d3c();
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::createheliextractobjectiveicons();
}

function ref_12d3c() {
  var_0 = scripts\engine\utility::getStructArray("enemy_spawner_defend_right", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.origin[1] < 20) {
      var_2.origin += (1870, 0, 0);
    }
  }
}

function ref_11c4a() {
  var_0 = [(-3522, -1400, 94), (-3475, -1400, 94), (-3381, -1400.5, 94), (-3334, -1400.5, 94)];

  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2);
    var_3.angles = (0, 90, 0);
    var_3 setModel("window_exterior_metal_bar_e_1");
  }

  var_5 = getEnt("clip128x128x8", "targetname");
  var_6 = [(-3493, -1398, 61), (-3345, -1398, 61)];

  foreach(var_2 in var_6) {
    var_8 = spawn("script_model", var_2);
    var_8.angles = (0, 0, -90);
    var_8 clonebrushmodeltoscriptmodel(var_5);
  }
}

function playscorestatusdialog() {
  var_0 = getEnt("clip32x32x32", "targetname");
  var_1 = [(977.5, -899, 20), (969, -885.5, 20), (952, -858.5, 20), (965, -848.5, 20), (982, -875.5, 20), (990.5, -889, 20)];

  foreach(var_3 in var_1) {
    var_4 = spawn("script_model", var_3);
    var_4.angles = (0, 32.647, 0);
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

function ref_13d1f() {
  var_0 = getEnt("clip64x64x8", "targetname");
  var_1 = [(-605, 380.5, 58), (-605, 380.5, 100)];

  foreach(var_3 in var_1) {
    var_4 = spawn("script_model", var_3);
    var_4.angles = (270, 182, 70.4329);
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

function chopper_boss_fight_stage_trigger_think() {
  var_0 = getEnt("player512x512x8", "targetname");
  var_1 = [(3235, 1478, 162), (3235, 966, 162), (3235, 452, 162), (3235, -60, 162), (3235, -572, 162), (3235, -1084, 162), (3235, -1595, 162), (258, -1944, 162)];

  foreach(var_3 in var_1) {
    var_4 = spawn("script_model", var_3);
    var_4.angles = (360, 270, 90);
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

function set_relic_healthpacks() {
  var_0 = getEnt("clip8x8x256", "targetname");
  var_1 = [(-3618.5, -1283, 12), (-3626, -1280, 12), (-3633.5, -1277, 12), (-3641, -1274, 12), (-3648.5, -1271, 12)];

  foreach(var_3 in var_1) {
    var_4 = spawn("script_model", var_3);
    var_4.angles = (0, 337.95, 0);
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

function ref_1305c() {
  var_0 = getEnt("clip32x32x32", "targetname");
  var_1 = [(-13.5, 682.5, 91), (-13.5, 682.5, 59), (-13.5, 682.5, 26), (19, 682.5, 91), (19, 682.5, 59), (19, 682.5, 26)];

  foreach(var_3 in var_1) {
    var_4 = spawn("script_model", var_3);
    var_4.angles = (0, 0, 0);
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

function set_relic_hideobjicons() {
  var_0 = getEnt("mantle64", "targetname");
  var_1 = [(-2979, -945, 75)];

  foreach(var_3 in var_1) {
    var_4 = spawn("script_model", var_3);
    var_4.angles = (0, 270, 0);
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

function wavetime() {
  var_0 = scripts\engine\utility::getStructArray("enemy_spawner_defend_left", "targetname")[0];
  var_0.origin = (1774.81, 2060.01, 24.617);
  var_0 = scripts\engine\utility::getStructArray("enemy_spawner_defend_left", "targetname")[4];
  var_0.origin = (1476.15, 2064.08, 25.617);
}

function ref_12a61() {}

function mid_encounter_package_thread() {
  var_0 = spawn("script_model", (-1461.5, -166.5, 14));
  var_0 setModel("hardware_plywood_bare_01");
  var_0.angles = (360, 270, 15.1987);
  var_0 = spawn("script_model", (-1463.5, -166.5, 14));
  var_0 setModel("hardware_plywood_bare_01");
  var_0.angles = (360, 270, 15.1987);
  var_0 = spawn("script_model", (-2226, -742, 56));
  var_0 setModel("hardware_plywood_bare_01");
  var_0.angles = (360, 270, 6.49972);
}

function init_hacking_table() {
  scripts\cp\cp_hacking::parsehackingtable("cp/cp_milbase_hacking_objective.csv");
}

function monitorcontrolscallback() {
  init_spawners();
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::laser_control_station_use_monitor();
  setdvarifuninitialized("cp_so_downloadtime", 240);
  ref_14379();
  scripts\cp\laser_traps\cp_laser_traps::ref_13067();
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::supportboxmaxammo();
  scripts\cp\laser_traps\cp_laser_traps::add_global_spawn_function("axis", &bomber_radiusdamage);
  scripts\cp\laser_traps\cp_laser_traps::add_global_spawn_function("allies", &brinitloadoutoption);
  thread handle_roof_spawning();
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_alley::ref_119e5();
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_alley::brloadoutcratepostcapture();
  thread ref_1321e("mike14_pickups");
  thread ref_1321e("res_pickups");
  ref_1321f();
  ref_128bb();
}

function handle_roof_spawning() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, [(-1134.05, -846.12, 16.0001), (0, 231.999, 0)]);
}

function bonuswingamescharge() {
  while(getaiarray("axis").size > 10) {
    wait 0.5;
  }

  for(;;) {
    while(getaiarray("axis").size > 6 || getaiarray("axis").size < 1) {
      if(scripts\engine\utility::flag("ai_push_player")) {
        scripts\engine\utility::flag_clear("ai_push_player");
      }

      wait 0.5;
    }

    if(!scripts\engine\utility::flag("ai_push_player")) {
      var_0 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::ref_12bcc(getaiarray("axis"));
      lootchopper_findunoccupiedpatrolzone(var_0);
      scripts\engine\utility::flag_set("ai_push_player");
    }

    wait 5;
  }
}

function lootchopper_findunoccupiedpatrolzone(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(!scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::bomb_carrier(var_3)) {
      continue;
    }

    if(var_1 > level.players.size - 1) {
      var_1 = 0;
    }

    var_3 setgoalpos(level.players[var_1].origin);
    var_3 setgoalentity(level.players[var_1], 1000);
    var_3.goalradius = 1000;
    var_1++;
  }
}

function brinitloadoutoption() {
  self setthreatbiasgroup("allies");
  self.health += 100;
  self.accuracy = 0.4;
  GscBinSkip4(0x35);
}

function brleaderdialogteam() {
  self endon("death");

  for(;;) {
    self waittill("damage");

    if(scripts\engine\utility::is_equal(self.damagemod, "MOD_EXPLOSIVE")) {
      self dodamage(self.health, self.origin);
      return;
    }

    waitframe();
  }
}

function ref_1321e(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_1 = ref_12bf4(var_1);
  var_2 = "iw8_ar_mcharlie_mp+thermal_west01+laserbalanced+fastreload+griphip";
  var_3 = "iw8_sn_mike14_mp+thermaldmr_west01+laserads_bar";
  var_4 = "iw8_ar_mike4_mp+hybrid_thermal+laserbalanced+fastreload+griphip";
  GscBinSkip1(0x45, 0, var_2);
}

function ref_12bf4(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.origin[2] < 85) {
      var_1 = var_3;
    }
  }

  return scripts\engine\utility::array_remove_array(var_0, var_1);
}

function teamanchoredwidget(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2.weaponinfo)) {
      continue;
    }

    var_3 = strtok(var_2.weaponinfo, "+");
    var_4 = var_3[0];
    var_5 = scripts\engine\utility::array_remove(var_3, var_4);
    var_6 = scripts\cp\cp_weapon::buildweapon(var_4, var_5);
    var_7 = "weapon_" + var_4;
    var_8 = scripts\cp\utility::array_merge(var_6.attachments, var_5);

    foreach(var_10 in var_8) {
      var_7 += "+" + var_10;
    }

    var_12 = spawn(var_7, var_2.origin, 1);
    var_12.angles = var_2.angles;
    var_12 itemweaponsetammo(1, 200, 0, 1);
  }
}

function ref_1321f() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "iw8_ar_mcharlie_mp+thermal_west01+laserbalanced+fastreload+griphip+fmj_medium+gunperk_marksman+ammomod_impact+gripangpro+pistolgrip03_mcharlie");
}

function ref_1238f(var_0) {
  foreach(var_2 in var_0) {
    var_3 = var_2[0];
    var_4 = var_2[1];
    var_5 = var_2[2];
    var_6 = strtok(var_3, "+");
    var_7 = var_6[0];
    var_8 = scripts\engine\utility::array_remove(var_6, var_7);
    var_9 = scripts\cp\cp_weapon::buildweapon(var_7, var_8);
    var_10 = "weapon_" + var_7;
    var_11 = scripts\cp\utility::array_merge(var_9.attachments, var_8);

    foreach(var_13 in var_11) {
      var_10 += "+" + var_13;
    }

    var_15 = spawn(var_10, var_4, 1);
    var_15.angles = var_5;
    var_16 = createheadicon(var_9);
    var_15 itemweaponsetammo(weaponclipsize(var_16), weaponmaxammo(var_16));
  }
}

function bomber_radiusdamage() {
  self.grenadeweapon = getcompleteweaponname("molotov_mp");
  self.grenadeammo = 255;
  self.grenadesafedist = 400;
  self.grenadeweapon.ammo = 255;
}

function borntime() {
  self.grenadeweapon = getcompleteweaponname("semtex_mp");
  self.grenadeammo = 255;
  self.grenadesafedist = 400;
  self.grenadeweapon.ammo = 255;
}

function init_flags() {
  scripts\engine\utility::flag_init("show_loot_boxes");
  scripts\engine\utility::flag_init("compound_cleared");
  scripts\engine\utility::flag_init("transfer_complete");
  scripts\engine\utility::flag_init("defend_start");
  scripts\engine\utility::flag_init("transfer_paused");
  scripts\engine\utility::flag_init("transfer_started");
  scripts\engine\utility::flag_init("pause_mission_spawning");
  scripts\engine\utility::flag_init("spawning_in_progress");
  scripts\engine\utility::flag_init("flares_out");
  scripts\engine\utility::flag_init("illumination_flare_enabled");
  scripts\engine\utility::flag_init("data_retrieved");
  scripts\engine\utility::flag_init("exfil_land");
  scripts\engine\utility::flag_init("exfil_touchdown");
  scripts\engine\utility::flag_init("exfil_unsafe");
  scripts\engine\utility::flag_init("start_field_push");
  scripts\engine\utility::flag_init("ai_push_player");
  scripts\engine\utility::flag_init("forever");
  scripts\engine\utility::flag_init("players_connected");
  scripts\engine\utility::flag_init("download_25_percent");
  scripts\engine\utility::flag_init("download_50_percent");
  scripts\engine\utility::flag_init("download_75_percent");
  scripts\engine\utility::flag_init("regroup_on_exfil");
  scripts\engine\utility::flag_init("download_35_percent");
  scripts\engine\utility::flag_init("care_package_space_full");
  scripts\engine\utility::flag_init("fade_in");
  scripts\engine\utility::flag_init("wave_2_start");
  scripts\engine\utility::flag_init("wave_1_start");
  scripts\engine\utility::flag_init("wave_3_start");
  scripts\engine\utility::flag_init("care_package_vo_playing");
}

function init_spawners() {
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::subscriptions();
}

function ref_14379() {
  scripts\cp\laser_traps\cp_laser_traps::ref_1437a();
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_set("players_connected");
}

function ref_128bb() {
  thread bonuswingamescharge();
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_alley::alley_start();
}

function ref_134f3() {
  var_0 = scripts\engine\utility::getStructArray("ally_spawners_heli", "targetname");
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(scripts\engine\utility::is_equal(var_4.script_type, "actor_ally_cp_usmc_ar")) {
      var_4 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      var_2++;

      if(var_2 >= 2) {
        break;
      }
    }
  }

  var_6 = getEnt("defend_vol", "targetname");
  var_7 = getaiarray("allies");
  var_8 = -108;

  foreach(var_10 in var_7) {
    var_10.target = undefined;
    var_10 notify("stop_going_to_node");
    var_10 clearpath();
    var_10 setgoalpos((-108.179, -141.79, 32));
    var_10 setgoalvolumeauto(var_6);
    var_10 forceteleport((var_8, -141.79, 32), (0, 0, 0));
    var_8 += -10;
  }
}

function ref_12f4b() {
  var_0 = scripts\engine\utility::getStruct("exfil_heli_nodes_08", "targetname");
  var_0.origin += (-768, 0, 0);
  var_1 = scripts\engine\utility::getStruct("exfil_heli_nodes_09", "targetname");
  var_1.origin += (-768, 0, 0);
  scripts\engine\utility::flag_set("pause_mission_spawning");
  visionsetnaked("cp_so_embassy_field", 5);
  wait 1;

  while(getaiarray("axis").size > level.players.size) {
    wait 0.1;
  }

  foreach(var_3 in getaiarray("allies")) {
    var_3.health = 10;
    var_3.goalradius = 1200;
    var_3 setgoalpos((1650, -59, -4));
  }

  scripts\engine\utility::flag_clear("exfil_unsafe");
  var_5 = getEnt("blima_spawn", "targetname");
  level.onlaststandkillenemy = var_5 scripts\common\vehicle::spawn_vehicle_and_gopath();
  thread givequestrewardgroup();
  thread onkioskpurchaseitem();
  thread ref_1352a();
  level.onlaststandkillenemy thread scripts\common\vehicle::godon();
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::omnvars();
  level.onlaststandkillenemy waittill("goal");
  thread giveloadouteverytime();

  while(!scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::brevent1playerthink(level.oncrateactivate, 500)) {
    wait 0.1;
  }

  level.onlaststandkillenemy setneargoalnotifydist(100);
  level.onlaststandkillenemy sethoverparams(0, 0, 0);
  level.onlaststandkillenemy vehicle_setspeed(5);
  level.onlaststandkillenemy settargetyaw(90);
  level.onlaststandkillenemy setvehgoalpos(level.onlaststandkillenemy.origin + (-75, 70, -320));
  level.onlaststandkillenemy.ref_13bfe = level.onlaststandkillenemy.origin + (-75, 70, -330);
  level.onlaststandkillenemy waittill("near_goal");
  var_6 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::ref_135eb(level.ref_13de3, "truck_04");
  thread skipfriendlyfire();
  scripts\engine\utility::flag_clear("pause_mission_spawning");
  thread audio_chopper_struggling();
  thread ref_11a6d();
  scripts\engine\utility::flag_set("exfil_unsafe");
  wait 2;
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::play_nags_from_array();
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::old_getspawnpoint_func();
  thread skipburndownforclass();
  wait 5;
  thread skipequipmentdropondeath();

  while(level.ref_12dc6.size > 1) {
    wait 0.1;
  }

  while(getaiarray("axis").size > 3) {
    wait 0.1;
  }

  scripts\engine\utility::flag_clear("exfil_unsafe");
  scripts\engine\utility::flag_set("regroup_on_exfil");

  while(!scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::brevent1playerthink(level.oncrateactivate, 500)) {
    wait 0.1;
  }

  scripts\engine\utility::flag_set("exfil_land");
  scripts\engine\utility::flag_wait("exfil_touchdown");
  setomnvar("cp_objective_index", 0);
  level notify("exfil_complete");
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function ref_1352a() {
  var_0 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134eb("ally_cp_usmc_ar", level.onlaststandkillenemy, 0);
  var_0 thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_alley::ref_11a6e();
  var_0 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134eb("ally_cp_usmc_ar", level.onlaststandkillenemy, 1);
  var_0 thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_alley::ref_11a6e();
}

function audio_chopper_struggling() {
  level waittill("rocket_impact");
  level.onlaststandkillenemy playLoopSound("hind_helicopter_dying_layer");
  level.onlaststandkillenemy playLoopSound("hind_helicopter_dying_loop");
  wait 6;
  thread givequestrewardsinstance(level.onlaststandkillenemy, 0.3);
}

function giveloadouteverytime() {
  var_0 = scripts\engine\utility::spawn_tag_origin(level.onlaststandkillenemy gettagorigin("tag_guy7"), (0, 0, 90));
  var_0 show();
  wait 0.15;
  var_0.origin = level.onlaststandkillenemy gettagorigin("tag_guy7");
  playFXOnTag(scripts\engine\utility::getfx("vfx_glow_stick"), var_0, "tag_origin");
  var_1 = (var_0.origin[0], var_0.origin[1], -20);
  var_0 moveTo(level.oncrateactivate + (100, 0, -10), 0.9);
}

function givequestrewardsinstance(var_0, var_1) {
  if(istrue(var_1)) {
    scripts\engine\utility::delaycall(var_0 + 0.05, &stoploopsound);
    return;
  }

  scripts\engine\utility::delaycall(var_0 + 0.05, &stopsounds);
}

function onkioskpurchaseitem() {
  level endon("exfil_complete");
  childthread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_12758("dx_mpa_ustl_exfillosing_arrive_losingteam");
  wait 3;
  childthread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_12758("dx_vom_ukp1_intro_flyin_20");
  level.onlaststandkillenemy waittill("goal");
  scripts\engine\utility::flag_wait("exfil_unsafe");
  wait 5;
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_12758("dx_vom_ukp1_intro_flyin_110");
  wait 1;
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_12758("dx_vom_ukp1_intro_flyin_120");
  scripts\engine\utility::flag_waitopen("exfil_unsafe");
  childthread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_12758("dx_mpa_ustl_exfillosing_arrive_losingteam");
}

function givequestrewardgroup() {
  self setscriptablepartstate("running_lights", "on");
  playFXOnTag(scripts\engine\utility::getfx("blima_light_cockpit_blue"), self, "tag_light_cockpit01");
}

function skipfriendlyfire() {
  level.onlaststandkillenemy waittill("goal");
  level.onlaststandkillenemy vehicle_setspeed(0);
  level waittill("rocket_impact");
  level endon("regroup_on_exfil");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, scripts\engine\utility::getStruct("exfil_heli_nodes_03", "targetname"));
}

function skipequipmentdropondeath() {
  scripts\engine\utility::flag_wait("regroup_on_exfil");
  var_0 = scripts\engine\utility::getStruct("exfil_heli_nodes_08", "targetname");
  var_1 = scripts\engine\utility::getStruct("exfil_heli_nodes_09", "targetname");
  level.onlaststandkillenemy settargetyaw(180);
  level.onlaststandkillenemy vehicle_setspeed(75);
  level.onlaststandkillenemy setvehgoalpos(var_1.origin + (-75, 70, -150), 1);
  level.onlaststandkillenemy settargetyaw(90);
  level.onlaststandkillenemy scripts\engine\utility::ref_143b9(8, "goal");
  level.onlaststandkillenemy sethoverparams(0, 0, 0);
  level.onlaststandkillenemy vehicle_setspeed(0);
  scripts\engine\utility::flag_wait("exfil_land");
  level.onlaststandkillenemy vehicle_setspeed(5);
  level.onlaststandkillenemy setvehgoalpos(var_1.origin + (-75, 70, -330));
  level.onlaststandkillenemy waittill("goal");
  level.onlaststandkillenemy vehicle_setspeed(0.1);
  scripts\engine\utility::flag_set("exfil_touchdown");
}

function ref_14680(var_0) {
  level.onlaststandkillenemy settargetyaw(var_0.angles[1]);
}

function skipburndownforclass() {
  var_0 = level.onlaststandkillenemy gettagorigin("tag_guy5");
  var_1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_1352b("ally_cp_usmc_ar", var_0, (0, 0, 0), undefined, 1);
  var_1 forceteleport(var_0);
  var_1 linkTo(level.onlaststandkillenemy, "tag_guy5");
  var_1.baseaccuracy = 1.8;
  var_1 allowedstances("crouch");
  wait 0.1;
  var_0 = level.onlaststandkillenemy gettagorigin("tag_guy7");
  var_2 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_1352b("ally_cp_usmc_ar", var_0, (0, 0, 0), undefined, 1);
  var_2 forceteleport(var_0);
  var_2 linkTo(level.onlaststandkillenemy, "tag_guy7");
  var_2.baseaccuracy = 1.8;
  var_2 allowedstances("crouch");
  wait 4;
  var_3 = level.vehicle.templates.aianims[level.onlaststandkillenemy scripts\common\vehicle_code::get_vehicle_classname()];
  var_4 = var_3[0].vehicle_getoutanim;
  thread scripts\cp\vehicle::matchdata_logweaponstat(level.onlaststandkillenemy, var_4);
}

function ref_11a6d() {
  var_0 = spawnStruct();
  var_0.origin = (1756, 2309, 307);
  var_0.angles = (0, 270, 0);
  var_1 = (2648, 2623, 169);
  var_2 = (1750, -165, -10);
  level.ref_12dc6 = [];
  var_3 = scripts\engine\utility::spawn_tag_origin((2733, 2051, 320), (0, 270, 0));
  ref_1353f(var_1, var_3, "enemy_cp_alq_desert_rpg");
  var_4 = getaiarray("axis")[0];
  var_5 = magicbullet("iw8_la_rpapa7_mp", var_0.origin, level.onlaststandkillenemy.origin + (0, 0, -150), var_4);
  var_5 waittill("explode");
  level notify("rocket_impact");
  var_3 = scripts\engine\utility::spawn_tag_origin((2783, 2051, 320), (0, 270, 0));
  thread ref_1353f(var_1, var_3, "enemy_cp_alq_desert_rpg");
  var_3 = scripts\engine\utility::spawn_tag_origin((1717, 2335, 267), (0, 270, 0));
  thread ref_1353f(var_1, var_3, "enemy_cp_alq_desert_rpg");
  var_3 = scripts\engine\utility::spawn_tag_origin((1575, 2301, 565), (0, 270, 0));
  thread ref_1353f(var_1, var_3, "enemy_cp_alq_desert_lmg");
  var_3 = scripts\engine\utility::spawn_tag_origin((1500, 2301, 565), (0, 270, 0));
  thread ref_1353f(var_1, var_3, "enemy_cp_alq_desert_lmg");
  wait 4;
  magicbullet("iw8_la_rpapa7_mp", var_0.origin, level.onlaststandkillenemy.origin + (200, 0, 500));
}

function ref_1353f(var_0, var_1, var_2) {
  var_3 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_1352b(var_2, var_0, (0, 0, 0), undefined, 1);
  var_3.og_fov = 1;
  var_3 allowedstances("prone");
  level.ref_12dc6[level.ref_12dc6.size] = var_3;
  thread ref_13540();
  wait 1;
  var_3 forceteleport(var_1.origin);
  var_3.baseaccuracy = 0.1;
  var_3.ignoresuppression = 1;
  var_3 allowedstances("stand", "crouch");
  var_3 linkTo(var_1);
}

function ref_13540() {
  self waittill("death");
  level.ref_12dc6 = scripts\engine\utility::array_remove(level.ref_12dc6, self);
}