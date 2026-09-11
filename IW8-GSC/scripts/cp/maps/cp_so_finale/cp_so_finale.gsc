/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_finale\cp_so_finale.gsc
*********************************************************/

function main() {
  ref_11c1e();
  setdvarifuninitialized("scr_use_squads", 1);
  setdvarifuninitialized("scr_squad_max", 4);
  setdvarifuninitialized("scr_squad_leader_max", 2);
  setdvarifuninitialized("scr_ai_squad_move_type", "1");
  setdvarifuninitialized("scr_smoketest", "0");
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  scripts\engine\utility::flag_init("scriptables_ready");
  scripts\cp\maps\cp_so_finale\cp_so_finale_precache::main();
  scripts\cp\maps\cp_so_finale\gen\cp_so_finale_art::main();
  scripts\cp\maps\cp_so_finale\cp_so_finale_fx::main();
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_tan", "truck_minimap", "script_vehicle_iw8_truck_pindia_tan");
  setDvar("NPONLLLSPL", 1.25);
  setDvar("PKKMTTRQO", 4);
  setDvar("NKLMONNPNN", 2048);
  setDvar("MROOOROPKL", 8);
  setDvar("LTQMSPKRKO", 8);

  if(level.createfx_enabled) {
    return;
  }

  scripts\cp\vehicle::init_vehicles();
  level thread scripts\cp\cp_objectives::objectives_init();
  level.ref_12177 = 1;
  level.hostdamagefactorlow = 0;
  level.ref_133ba = 1;
  level.map_interaction_func = &scripts\cp\maps\cp_so_finale\cp_so_finale_interactions::register_interactions;
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
  level.weapon_rank_event_table = "scripts/cp/maps/cp_so_finale/cp_so_finale_weaponrank_event.csv";
  level.player_interaction_monitor = &scripts\cp\maps\cp_so_finale\cp_so_finale_interactions::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &scripts\cp\maps\cp_so_finale\cp_so_finale_interactions::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = &interaction_trigger_properties;
  level.strike_player_connect_black_screen_fn = &ref_1247b;
  level.mud_sfx = &mud_sfx;
  scripts\cp_mp\tripwire::precache("tripwire_start", "equipment_wm_tripwire_ceiling");
  scripts\cp_mp\tripwire::precache("tripwire_start", "equipment_wm_tripwire_wall");
  scripts\cp_mp\tripwire::precachetrap("tripwire_trap_frag", "offhand_wm_grenade_mike67", 1);
  ref_12846();

  if(!scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_init("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_init("strike_init_done");
  }

  thread wait_for_pre_game_period();
  thread wait_for_strike_init_complete();
  level thread scripts\cp\cp_movers::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level.additional_laststand_weapon_exclusion = [];
  thread setup_map_specific_devgui();
  setup_create_script();
  level.devgui_setup_func = &onplayerspawneddevguisetup;

  if(level.scripted_spawner_func.size < 1) {
    scripts\engine\utility::flag_set("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_init("infil_complete");
  }

  var_0 = getDvar("cp_so_finale_start_obj", "");

  if(isDefined(var_0) && var_0 != "") {
    thread rundebugstartobjective(level);
  }

  level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  scripts\cp\cp_compass::setupminimap("compass_map_cp_so_finale");
  scripts\engine\utility::create_func_ref("vehicle_damage_modifier", &scripts\cp\cp_vehicles::incrementobjectiveachievementkill);
  supply_station_direction();
  thread play_operator_reply_vo();
}

function ref_11c1e() {
  var_0 = getEntArray("minimap_corner", "targetname");
  GscBinSkip1(0x45, 0, (-44914, 36320, -668.5));
}

function ref_12846() {
  scripts\engine\utility::flag_init("start_mission");
  scripts\engine\utility::flag_init("enemy_mortar_launched");
  scripts\engine\utility::flag_init("assault1_over");
  scripts\engine\utility::flag_init("enemy_spawning_active");
  scripts\engine\utility::flag_init("assault2_over");
  scripts\engine\utility::flag_init("bomb01_planted");
  scripts\engine\utility::flag_init("bomb02_planted");
  scripts\engine\utility::flag_init("bomb03_planted");
  scripts\engine\utility::flag_init("heli_assault2_spawned");
  scripts\engine\utility::flag_init("fob_juggernauts_spawned_in");
  scripts\engine\utility::flag_init("all_fob_juggernauts_spawned_in");
  scripts\engine\utility::flag_init("first_jugg_dead");
  scripts\engine\utility::flag_init("assault3_setup");
  scripts\engine\utility::flag_init("heli_assault3_fob_spawned");
  scripts\engine\utility::flag_init("heli_assault3_spawned");
  scripts\engine\utility::flag_init("start_vindia_scene");
  scripts\engine\utility::flag_init("all_vindias_spawned_in");
  scripts\engine\utility::flag_init("assault3_at_hangar");
  scripts\engine\utility::flag_init("bomb04_planted");
  scripts\engine\utility::flag_init("bomb05_planted");
  scripts\engine\utility::flag_init("heli_assault3_hangar_spawned");
  scripts\engine\utility::flag_init("hangar_juggernauts_spawned_in");
  scripts\engine\utility::flag_init("all_hangar_juggernauts_spawned_in");
  scripts\engine\utility::flag_init("all_enemies_spawned_in");
  scripts\engine\utility::flag_init("assault_finished_in_victory");
  scripts\cp\laser_traps\cp_laser_traps::add_global_spawn_function("axis", &postspawn_axis);
}

function ref_1247b(var_0) {}

function play_overlord_howcopy_vo() {
  var_0 = scripts\engine\utility::getStructArray("level_crate_spawn_struct", "targetname");
  weapon_xp_iw8_sn_golf28(var_0);
  var_0 = scripts\engine\utility::getStructArray("level_crate_refill_spawn_struct", "targetname");
  weapon_xp_iw8_sn_delta(var_0);
  var_1 = scripts\engine\utility::getStructArray("ammo_crate", "targetname");
  weapon_xp_iw8_sh_romeo870(var_1);
  var_2 = scripts\engine\utility::getStructArray("level_weapon_spawn_struct", "targetname");
  weaponclassweights(var_2);
  var_3 = scripts\engine\utility::getStructArray("killstreak_spawn_struct", "targetname");
  weapon_xp_iw8_sn_alpha50(var_3);
}

function onplayerspawned() {
  scripts\cp\gametypes\cp_specops::givedefaultloadout();
  var_0 = "iw8_ar_scharlie";
  var_1 = scripts\cp\cp_weapon::buildweapon(var_0, ["acog_west01_irons", "mmags_scharlie", "back_scharlie", "barlong_scharlie", "rec_scharlie"], "none", "none");
  self giveweapon(var_1);
  self setweaponammoclip(var_1, weaponclipsize(var_1));
  self setweaponammostock(var_1, weaponmaxammo(var_1));
  self switchtoweapon(var_1);
  var_2 = "iw8_pi_mike1911";
  var_3 = scripts\cp\cp_weapon::buildweapon(var_2, ["rec_mike1911", "mag_mike1911", "slide_mike1911", "xmags"], "none", "none");
  self giveweapon(var_3);
  self setweaponammoclip(var_3, weaponclipsize(var_3));
  self setweaponammostock(var_3, weaponmaxammo(var_3));
  self.weaponlist = self getweaponslistprimaries();
  self.vo_three_remain = "none";
  self.vo_stealth_broken = 0;
  self.vehicle_occupancy_cp_handlesuicidefromvehicles = "none";
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0], 1);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0])) {
    self.primaryweaponobj = self.weaponlist[0];
  }

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1])) {
    self.secondaryweaponobj = self.weaponlist[1];
  }

  self setclientomnvar("ui_hide_minimap", 0);
  level.hostdamagefactorlow++;
  thread ref_143e1();

  if(!scripts\engine\utility::flag("infil_complete")) {
    thread trial_radar_sweeps();
    return;
  }
}

function ref_143e1() {
  self endon("death_or_disconnect");
  self.ref_124fd = undefined;
  self waittill("munitions_used");
  self.ref_124fd = 1;
}

function rundebugstartobjective(var_0) {
  wait 2;
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("objective_table_parsed");

  if(isDefined(level.objectivestabledata[var_0])) {
    var_1 = level.objectivestabledata[var_0];

    if(isDefined(var_1.ondebugstartfunc)) {
      [[var_1.ondebugstartfunc]](var_1);
    }

    thread scripts\cp\cp_objectives::run_objective(var_1.objname, var_1.questtype);
    return;
  }
}

function onplayerspawneddevguisetup(var_0) {
  var_1 = var_0.name;
  var_2 = undefined;

  foreach(var_4 in level.players) {
    if(var_4 == var_0) {
      var_2 = int(var_5);
      break;
    }
  }

  if(isDefined(var_2)) {
    thread setupdevguientries(var_0, var_0, var_1);
    return;
  }
}

function setupdevguientries(var_0, var_1, var_2) {}

function wait_for_pre_game_period() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  wait 0.2;
}

function wait_for_strike_init_complete() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("personal_ent_zones_initialized");

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
    var_0 = getDvar("scr_strike_name");
    var_1 = undefined;

    switch (var_0) {
      case "putnewstrikehere":
        break;
      default:
        break;
    }

    return;
  }
}

function registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

function onplayerconnect(var_0) {
  thread bug_test_move_startpoint();
}

function bug_test_move_startpoint() {
  if(getdvarint("scr_linkto_test", 0)) {
    var_0 = scripts\engine\utility::getStructArray("default_player_start", "targetname");

    foreach(var_2 in var_0) {
      var_2.origin = (3743, -1008, 384);
      var_2.angles = (6, 265, 0);
    }

    return;
  }
}

function should_run_event(var_0) {
  return false;
}

function setup_map_specific_devgui() {}

function interaction_trigger_properties(var_0, var_1, var_2) {
  switch (var_1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var_1.useduration)) {
        self.interaction_trigger setuseholdduration(var_1.useduration);
      }

      break;
  }
}

function setup_create_script() {
  level.threadedscriptspawners = 1;
  level.create_script_file_ids = [];
  level.cs_scripted_spawners = [];
  level.scripted_spawners = [];
  level.cs_scripted_spawners_triggers = [];
  level.scripted_spawners_triggers = [];
  level.cs_scripted_spawners_models = [];
  level.scripted_spawners_models = [];
  level.createscriptfilesinitialized = 0;
  level.scripted_spawner_func_strings = [];
  level.scripted_spawner_map_strings = [];
  level.scripted_spawner_func = [];
  register_create_script_arrays("cp_so_finale_create_script", "cp_so_finale_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_so_finale\cp_so_finale_create_script::main);
}

function register_create_script_arrays(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var_0;
  }

  if(isDefined(var_1)) {
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var_1;
  }

  if(isDefined(var_2)) {
    level.create_script_file_ids[var_0] = "cs" + var_2;
  }

  if(isDefined(var_3)) {
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var_3;
    return;
  }
}

function play_operator_reply_vo() {
  ref_1321b();
  level.initlocs_keypads = scripts\engine\utility::getStructArray("assault1_spawner", "targetname");
  level.ref_11bd9 = [];
  level.site_axis_spawnfunc = [];
  level.skipdeathicon = 0;
  level.ref_123da = 1;
  levelobjectives_init();
  play_overlord_howcopy_vo();
  scripts\cp\laser_traps\cp_laser_traps::ref_1437a();
  thread brleaderdialogteamexcludeplayer();
  thread current_carrier_time();
  thread ref_11f8f();
  ref_137c4();
  thread init_tripwires();
  thread thermitestuckto();
  scripts\engine\utility::flag_wait("start_mission");
  level notify("stop_timer_endon");
  scripts\engine\utility::delaythread(4.7, &ref_12758, "dx_mpa_uktl_boost_enemy_inbound");
  scripts\cp\laser_traps\cp_laser_traps::ref_13067();
  thread nocrash();
  scripts\engine\utility::flag_set("enemy_spawning_active");
  carepackage_spawn();
  carepackage_unlink_from_heli();
  carepackage_waittill_settle();
}

function ref_1321b() {
  level.initnonbunkerdoors = [];
  level.initnonbunkerdoorkeypad = [];
  level.initoperationcratedata = 0;
  var_0 = ["assault1_volume", "assault2_volume", "assault2_volume2", "assault2_volume3", "assault2_volume4", "assault2_volume5", "assault3_volume1", "assault3_volume2", "assault3_volume3", "assault3_volume4"];

  foreach(var_2 in var_0) {
    level.initnonbunkerdoors[level.initnonbunkerdoors.size] = getEnt(var_2, "targetname");
  }

  var_0 = ["ally_riverbed_volume", "assault1_volume", "assault2_volume", "assault2_volume2", "assault2_volume3", "assault2_volume4", "assault3_volume1", "assault3_volume1", "assault3_volume2", "assault3_volume3"];

  foreach(var_2 in var_0) {
    level.initnonbunkerdoorkeypad[level.initnonbunkerdoorkeypad.size] = getEnt(var_2, "targetname");
  }
}

function ref_131fe(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    level.initlocs_keypads = scripts\engine\utility::getStructArray(var_0, "targetname");
  }

  if(isDefined(var_1)) {
    level.initoperationcratedata = var_1;
  }

  if(isDefined(var_2)) {
    level.ref_135d2["current"] = level.ref_135d2[var_2];
  }

  if(isDefined(var_3)) {
    level.ref_11b4c = var_3;
  } else {
    level.ref_11b4c = 1;
  }

  ref_13f78();
}

function carepackage_spawn() {
  scripts\engine\utility::delaythread(0.3, &spawn_group, "sniper", "alq_sniper_assault1", 1, "assault1_over", "assault1_over", 1, 18);
  scripts\engine\utility::delaythread(0.4, &spawn_group, "rpg", "alq_rpg_assault1", 1, "assault1_over", "assault1_over", 1, 18);
  scripts\engine\utility::delaythread(1.5, &ref_11d32);
  scripts\engine\utility::flag_wait("assault1_over");
  ref_131fe("assault2_front_spawner", 1, "fob_start_array", 1);
  var_0 = scripts\engine\utility::getStructArray("assault2_intro_spawner", "targetname");
  thread ref_135db(var_0, 2);
}

function carepackage_unlink_from_heli() {
  scripts\engine\utility::flag_wait("players_in_fob");
  thread ref_13506();
  thread ref_135ec("truck_spawn1");
  scripts\engine\utility::delaythread(0.2, &ref_12758, "dx_mpa_uktl_hint_fightback");
  ref_1357b("killstreak_drop_1", "cluster_strike");
  thread ref_13566();
  thread ref_13574();
  scripts\engine\utility::flag_wait("fallback_1");
  ref_131fe("assault2_mid_spawner", 2, undefined, 1);
  thread spawn_group("sniper", "alq_sniper_assault2", 1, undefined, "fallback_3", 2, 30);
  scripts\engine\utility::flag_wait("fallback_2");
  level.brinfilsmokesuffix = scripts\engine\utility::getStructArray("fob_ally_respawn", "targetname");
  ref_131fe("assault2_back_spawner", 3, "fob_end_array", 1);
  scripts\engine\utility::flag_wait("fallback_3");
  ref_131fe("assault2_back_spawner", 4, undefined, 1);
  scripts\engine\utility::flag_wait("fallback_4");
  ref_131fe("assault2_back_spawner", 5, undefined, 1);
  scripts\engine\utility::flag_wait("assault2_over");
  ref_131fe("assault2_jugg_location_spawner");
}

function carepackage_waittill_settle() {
  scripts\engine\utility::flag_wait("assault3_setup");
  level.brinfilsmokesuffix = scripts\engine\utility::getStructArray("fob2_ally_respawn", "targetname");
  ref_131fe("assault3_mid_spawner", 6, "hangar_array");
  thread ref_13567();
  thread ref_135f2();
  scripts\engine\utility::delaythread(3, &ref_12758, "dx_mpa_uktl_boost_tdm");
  ref_1357b("killstreak_drop_2", "cruise_missile");
  scripts\engine\utility::flag_wait("assault3_fallback2");
  ref_131fe("assault3_mid_spawner", 7, undefined, 1);
  thread ref_135ec("truck_spawn5");
  scripts\engine\utility::flag_wait("assault3_fallback3");
  ref_131fe("assault3_mid2_spawner", 8, undefined, 1);
  var_0 = scripts\engine\utility::getStructArray("assault3_initial_hangar_spawner", "targetname");
  var_1 = ref_135db(var_0, 3);
  ref_135d6();
  scripts\engine\utility::flag_wait("assault3_fallback4");
  ref_131fe("assault3_back_spawner", 9, undefined, 1);
  scripts\engine\utility::flag_set("start_vindia_scene");
  wait 2;
  thread spawn_group("bomber", "alq_bomber_assault3", 0, undefined, undefined, undefined, 6);
  scripts\engine\utility::flag_wait("assault3_fallback5");
  var_0 = scripts\engine\utility::getStructArray("assault3_hangar_spawner", "targetname");
  var_1 = ref_135db(var_0, 2);
  scripts\engine\utility::flag_wait("assault3_at_hangar");
  ref_131fe("assault3_outside_spawner", 9, undefined, 1);
  var_0 = scripts\engine\utility::getStructArray("assault3_bunker_spawner", "targetname");

  foreach(var_3 in var_0) {
    var_4 = getnode(var_3.target, "targetname");
    var_5 = var_3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_5.fixednode = 1;
    var_5.matchdata_logchallenge = 1;
    var_5 setgoalnode(var_4);
    wait 0.2;
  }

  thread setupspecialdaypickupweapons();
  scripts\engine\utility::flag_wait("bomb05_planted");
  scripts\engine\utility::flag_set("enemy_spawning_active");
  thread ref_13423("smoke_final_struct");
  wait 0.7;
  ref_13556();
  wait 4;
  ref_13556();
  scripts\engine\utility::flag_set("all_enemies_spawned_in");
}

function ref_13556() {
  var_0 = getEnt("assault3_volume5", "targetname");
  var_1 = scripts\engine\utility::getStructArray("finale_spawner", "targetname");
  var_2 = var_1.size;

  if(level.players.size == 2) {
    var_2 = 8;
  }

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_1[var_3] scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_4 setgoalvolumeauto(var_0);
    thread ref_13093(var_4);
    wait 0.2;
  }
}

function ref_135d6() {
  var_0 = scripts\engine\utility::getStructArray("alq_sniper_assault3", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_4 = getnode(var_3.target, "targetname");
    var_5 = var_2 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    thread nvidiaansel_scriptdisable(var_5);
    thread ref_13439();
    var_5 forceteleport(var_3.origin, var_3.angles);
    wait 0.1;
    var_5 setgoalnode(var_4);
    var_5.goalradius = 32;
    var_5.fixednode = 1;
  }
}

function nvidiaansel_scriptdisable(var_0) {
  self endon("death");
  scripts\engine\utility::flag_wait("assault3_at_hangar");
  wait randomfloatrange(0, 1.5);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.fixednode = 0;
  self.goalradius = 32;
  wait 0.05;
  self setgoalpos(var_0.origin);
  wait randomfloatrange(5, 6.5);
  self kill();
}

function setupspecialdaypickupweapons() {
  thread ref_13423("smoke_struct");
  wait 0.7;
  scripts\engine\utility::flag_clear("first_jugg_dead");
  thread ref_13579("assault3_juggernaut_spawner", "hangar_juggernauts_spawned_in", "all_hangar_juggernauts_spawned_in");
  thread ref_11f5f();
}

function ref_13f78() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.matchdata_logchallenge)) {
      var_2 setgoalvolumeauto(level.initnonbunkerdoors[level.initoperationcratedata]);
    }
  }

  var_4 = getaiarray("allies");

  foreach(var_6 in var_4) {
    var_6 setgoalvolumeauto(level.initnonbunkerdoorkeypad[level.initoperationcratedata]);
  }

  level.player_has_grenade_crate = 1;
}

function thermitestuckto() {
  scripts\engine\utility::delaythread(3.7, &ref_12759, "dx_mpb_ukft1_ping_plunder_vendor", "start_mission");
  scripts\engine\utility::delaythread(15, &ref_12759, "dx_mpa_uktl_gamestate_timesup_thirty", "start_mission");
  scripts\engine\utility::delaythread(35, &ref_12759, "dx_mpa_uktl_hp_move_soon", "start_mission");
  var_0 = 45;
  scripts\engine\utility::flag_wait_or_timeout("start_mission", var_0);
  scripts\engine\utility::flag_set("start_mission");
}

function ref_137c4() {
  var_0 = getEnt("intro_truck_alpha", "targetname");
  level.trial_spawn_wait = var_0 scripts\common\utility::spawn_vehicle();
  level.trial_spawn_wait.script_keepdriver = 1;
  thread trial_rpg_init();
  var_1 = getEnt("intro_truck_alpha_clip", "targetname");
  var_1.angles += (3, 1, -1);
  var_1.origin += (-3, -4, -10);
  var_1 linkTo(level.trial_spawn_wait);
  wait 0.2;
  level.trial_spawn_wait notsolid();
  thread scripts\common\vehicle_paths::gopath(level.trial_spawn_wait);
  wait 1;
  level.trial_spawn_wait setwaitspeed(0);
  level.trial_spawn_wait scripts\engine\utility::waittill_notify_or_timeout("reached_wait_speed", 7.5);
  scripts\engine\utility::flag_set("infil_complete");
  level.trial_spawn_wait scripts\engine\utility::delaycall(3, &vehicle_turnengineoff);
  wait 3;
  var_0 = scripts\engine\utility::getStruct("umike_driver", "targetname");
  var_2 = var_0 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
}

function trial_rpg_init() {
  while(!isDefined(self.driver)) {
    wait 0.1;
  }

  self.driver delete();
}

function trial_radar_sweeps() {
  while(!isDefined(level.trial_spawn_wait)) {
    waitframe();
  }

  if(scripts\engine\utility::flag("infil_complete")) {
    return;
  }

  var_0 = ["tag_seat_2", "tag_seat_4", "tag_seat_7", "tag_seat_5"];
  var_1 = [(-23, -10, 7), (-23, -20, 7), (-23, -17, 7), (-23, -10, 7)];
  var_2 = [40, 50, 50, 40];
  var_3 = [50, 40, 40, 50];

  if(!isDefined(level.trial_spawn_wait.ref_13a26)) {
    level.trial_spawn_wait.ref_13a26 = [];
  }

  var_4 = undefined;
  self.animname = undefined;
  var_5 = undefined;

  foreach(var_7 in var_0) {
    if(!isDefined(level.trial_spawn_wait.ref_13a26[var_7])) {
      level.trial_spawn_wait.ref_13a26[var_7] = 1;
      var_4 = var_7;
      var_5 = var_8;
      self.animname = "slot_" + var_8;
      break;
    }
  }

  var_9 = var_1[var_5];
  var_10 = var_2[var_5];
  var_11 = var_3[var_5];
  var_12 = scripts\cp\laser_traps\cp_laser_traps::ref_124e9(self, "slot_" + var_5);
  var_12 linkTo(level.trial_spawn_wait, var_4, var_9, (0, 0, 0));
  self allowstand(0);
  self allowprone(0);
  self setstance("crouch");
  wait 0.05;
  self playerlinktodelta(var_12, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
  self lerpviewangleclamp(1, 0.25, 0.25, var_10, var_11, 80, 80);

  while(!scripts\engine\utility::flag("infil_complete")) {
    var_12 scripts\cp\cp_anim::anim_player_solo(self, var_12, "infil_ride_idle");
  }

  var_12 scripts\cp\cp_anim::anim_player_solo(self, var_12, "infil_ride_exit");
  self unlink();
  var_12 delete();
  self allowstand(1);
  self allowprone(1);
  self setstance("stand", 0, 1, 1);
}

function init_tripwires() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  wait 3;
  scripts\cp_mp\tripwire::init();
  level.tripwires.ref_11cd1 = getEntArray("tripwire_mon_clip", "targetname");

  foreach(var_1 in level.tripwires.tripwires) {
    thread last_say_times();
  }
}

function last_say_times() {
  self waittill("trigger");

  if(isDefined(self.targets) && self.targets.size == 1) {
    var_0 = scripts\engine\utility::getclosest(self.origin, level.tripwires.ref_11cd1);
    level.tripwires.ref_11cd1 = scripts\engine\utility::array_remove(level.tripwires.ref_11cd1, var_0);

    if(isDefined(var_0)) {
      var_0 delete();
      return;
    }

    return;
  }
}

function current_carrier_time() {
  level.playerexitsafeareamessage = [];
  var_0 = getEntArray("bombs", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2.targetname == "bomb01") {
      level.playerexitsafeareamessage[0] = var_2;
    } else if(var_2.targetname == "bomb02") {
      level.playerexitsafeareamessage[1] = var_2;
    } else if(var_2.targetname == "bomb03") {
      level.playerexitsafeareamessage[2] = var_2;
    } else if(var_2.targetname == "bomb04") {
      level.playerexitsafeareamessage[3] = var_2;
    } else if(var_2.targetname == "bomb05") {
      level.playerexitsafeareamessage[4] = var_2;
    }

    var_2 hide();
    var_2.ref_1405c = scripts\engine\utility::getStruct(var_2.target, "targetname");

    if(var_2.targetname != "bomb04") {
      thread crankedprogressuiupdater(var_2, &cqb_laser_guy_internal, &"MP/BOMB_SITE", undefined);
    }
  }
}

function crankedprogressuiupdater(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", self.ref_1405c.origin);

  if(isDefined(self.ref_1405c.angles)) {
    var_4.angles = self.ref_1405c.angles;
  } else {
    var_4.angles = (0, 0, 0);
  }

  var_4.ref_11c6d = self;

  if(isDefined(var_2)) {
    var_4.headicon = thread scripts\cp\utility::ent_createheadicon(var_4, 15, "allies", var_2, 1);
    setheadiconsnaptoedges(var_4.headicon, 1500);
    setheadiconmaxdistance(var_4.headicon, 15);
  }

  var_4 setCursorHint("HINT_BUTTON");
  var_4 sethintdisplayrange(200);
  var_4 sethintdisplayfov(45);
  var_4 setuserange(100);
  var_4 setusefov(40);
  var_4 sethintonobstruction("show");
  var_4 setuseholdduration("duration_medium");
  var_4 sethintrequiresholding(1);
  var_4 makeusable();

  if(isDefined(var_1)) {
    var_4 setHintString(var_1);
  }

  var_4.valve_steam_on = 0;
  thread ref_12f50(var_4, var_0, var_3);
  return var_4;
}

function cqb_laser_guy_internal(var_0, var_1) {
  var_0.ref_11c6d show();
  var_0.valve_steam_on = 1;
  scripts\engine\utility::flag_set(var_0.ref_11c6d.targetname + "_planted");
  playsoundatpos(var_0.ref_11c6d.origin, "MP_bomb_plant");
  wait 0.2;
  var_1 playsoundtoteam("dx_mpb_ukft1_objectives_inform_device_set", "allies");

  if(!scripts\engine\utility::flag("bomb03_planted")) {
    thread ref_1350d(var_1);
  }

  wait 1.5;
  thread ref_12758("dx_mpa_uktl_bomb_planted");
}

function ref_1350d(var_0) {
  var_1 = scripts\engine\utility::getStructArray("assault2_back_spawner_special", "targetname");
  var_2 = scripts\engine\utility::getStructArray("alq_bomber", "targetname");
  var_3 = 2;
  var_4 = undefined;

  if(level.players.size <= 1) {
    var_3 = 1;
  }

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_2[var_5].origin = var_1[var_5].origin;

    if(isDefined(var_1[var_5].angles)) {
      var_2[var_5].angles = var_1[var_5].angles;
    }

    var_4 = var_2[var_5] scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    var_4 getenemyinfo(var_0);
  }

  wait 2;
  thread ref_12420(var_4, "dx_mpp_ukft1_ping_enemy_bomber");
}

function levelobjectives_init() {
  level.objectives_table = "cp/cp_so_finale_objectives.csv";
  level.objectiveregistration = &levelregisterobjectives;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

function levelregisterobjectives() {
  scripts\cp\cp_objectives::registerobjective("obj_start", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj1_gate1", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj2_mid", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj3_gate2", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj4_juggs", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj5_reach_hangar", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj6_kill_helis", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj7_cleanup", undefined, undefined, undefined, undefined, undefined);
}

function ref_11f8f() {
  ref_11f6b();
  ref_11f6c();
  ref_11f5b();
  ref_11f5d();
  ref_11f5e();
  ref_11f59();
}

function ref_11f6b() {
  setomnvar("cp_objective_index", 1);
  setomnvar("cp_objective_sub_1_index", 2);
  var_0 = scripts\engine\utility::getStruct("obj_gear_up", "targetname");
  var_1 = scripts\cp\cp_objectives::requestworldid("obj_start", 1);
  level.inittutzones = var_1;
  objective_setplayoutro(var_1, 1);
  objective_setplayintro(var_1, 1);
  objective_setminimapiconsize(var_1, "icon_regular");
  objective_state(var_1, "current");
  objective_position(var_1, var_0.origin);
  objective_setdescription(var_1, &"CP_SO_FINALE/FINALE_OBJ_START");
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_unpinforteam(var_1, "allies");
  objective_setshowdistance(var_1, 1);
  objective_setbackground(var_1, 0);
  objective_setshowoncompass(var_1, 1);
  objective_setpulsate(var_1, 1);
}

function ref_11f6c() {
  scripts\engine\utility::flag_wait("start_mission");
  scripts\cp\cp_objectives::freeworldid("obj_start");
  objective_state(level.inittutzones, "done");
  setomnvar("cp_objective_sub_1_index", 3);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_SO_FINALE/FINALE_OBJ1", "allies", 4);
  var_0 = scripts\engine\utility::getStruct("obj2_fob_mid", "targetname");
  var_1 = scripts\cp\cp_objectives::requestworldid("obj1_gate1", 1);
  level.inittutzones = var_1;
  objective_setplayoutro(var_1, 1);
  objective_setplayintro(var_1, 1);
  objective_state(var_1, "current");
  objective_position(var_1, var_0.origin);
  objective_setdescription(var_1, &"CP_SO_FINALE/FINALE_OBJ1");
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_unpinforteam(var_1, "allies");
  objective_setshowdistance(var_1, 1);
  objective_setbackground(var_1, 0);
  objective_setshowoncompass(var_1, 1);
  objective_setpulsate(var_1, 1);
}

function ref_11f5b() {
  thread ref_11f60();
  scripts\engine\utility::flag_wait("assault1_over");
  scripts\cp\cp_objectives::freeworldid("obj1_gate1");
  objective_state(level.inittutzones, "done");
  setomnvar("cp_objective_sub_1_index", 4);
  var_0 = scripts\engine\utility::getStruct("obj2_fob_mid", "targetname");
  var_1 = (0, 0, 5);
  var_2 = scripts\cp\cp_objectives::requestworldid("obj2_mid", 1);
  level.inittutzones = var_2;
  objective_setplayoutro(var_2, 1);
  objective_setplayintro(var_2, 1);
  objective_state(var_2, "current");
  objective_position(var_2, level.playerexitsafeareamessage[0].origin + var_1);
  objective_setdescription(var_2, &"MATCH_STATUS_HINT/PLANT_BOMBS");
  objective_unpinforteam(var_2, "allies");
  objective_setshowdistance(var_2, 1);
  objective_setbackground(var_2, 0);
  objective_setshowoncompass(var_2, 1);
  objective_setpulsate(var_2, 1);
  objective_setlabel(var_2, &"CP_SO_FINALE/PLANT_BOMBS_ALT1");
  objective_icon(var_2, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_wait("bomb01_planted");
  objective_position(var_2, level.playerexitsafeareamessage[1].origin + var_1);
  scripts\engine\utility::flag_wait("bomb02_planted");
  objective_position(var_2, level.playerexitsafeareamessage[2].origin + var_1);
  scripts\engine\utility::flag_wait("bomb03_planted");
  thread ref_11d85();
}

function ref_11d85() {
  var_0 = getEnt("gate_model", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = getEntArray("gate_clip", "targetname");
  var_3 = getEnt("gate_clip_delete", "targetname");
  wait 0.2;
  thread ref_1355d();
  var_0 moveTo(var_1.origin, 3);
  wait 1;
  var_3 notsolid();
}

function ref_1355d() {
  var_0 = scripts\engine\utility::getStructArray("assault2_gate_guard", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getnode(var_2.target, "targetname");
    var_4 = var_2 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_4.ref_13fba = "assault3_start";
    thread ref_13092(var_4);
    wait 0.2;
  }
}

function ref_11f60() {
  scripts\engine\utility::flag_wait("heli_assault2_spawned");

  for(var_0 = 0; var_0 < level.solution_exists_already.size; var_0++) {
    var_1 = level.solution_exists_already[var_0];
    var_2 = "fob_heli_icon" + var_0;
    var_1.objindex = scripts\cp\cp_objectives::requestworldid(var_2, 2);
    objective_setplayintro(var_1.objindex, 0);
    objective_setplayoutro(var_1.objindex, 0);
    objective_setownerteam(var_1.objindex, "axis");
    objective_state(var_1.objindex, "active");
    objective_icon(var_1.objindex, "icon_minimap_littlebird");
    objective_setlocation(var_1.objindex, 0, var_1);
    thread laser_sights(var_1, var_1.objindex);
  }
}

function ref_11f5c() {
  scripts\engine\utility::flag_wait("all_fob_juggernauts_spawned_in");

  for(var_0 = 0; var_0 < level.ref_11bd9.size; var_0++) {
    var_1 = level.ref_11bd9[var_0];
    var_2 = "fob_jugg_icon" + var_0;
    var_1.objindex = scripts\cp\cp_objectives::requestworldid(var_2, 2);
    objective_setplayintro(var_1.objindex, 0);
    objective_setplayoutro(var_1.objindex, 0);
    objective_setownerteam(var_1.objindex, "axis");
    objective_state(var_1.objindex, "active");
    objective_icon(var_1.objindex, "icon_minimap_juggernaut");
    objective_setminimapiconsize(var_1.objindex, "icon_regular");
    objective_setlocation(var_1.objindex, 0, var_1);
    thread laser_sights(var_1, var_1.objindex);
  }
}

function ref_11f5d() {
  scripts\cp\cp_objectives::freeworldid("obj2_mid");
  objective_state(level.inittutzones, "done");
  setomnvar("cp_objective_sub_1_index", 7);
  level.ref_135d2["current"] = level.ref_135d2["fob2_array"];
  scripts\engine\utility::flag_set("assault2_over");
  scripts\engine\utility::flag_set("assault3_setup");
  scripts\engine\utility::flag_set("enemy_spawning_active");
  var_0 = scripts\engine\utility::getStruct("obj5_reach_hangar", "targetname");
  var_1 = scripts\cp\cp_objectives::requestworldid("obj5_reach_hangar", 1);
  level.inittutzones = var_1;
  objective_setplayoutro(var_1, 1);
  objective_setplayintro(var_1, 1);
  objective_state(var_1, "current");
  objective_position(var_1, var_0.origin);
  objective_setdescription(var_1, &"CP_SO_FINALE/FINALE_OBJ_TARMAC");
  objective_setlabel(var_1, "");
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_unpinforteam(var_1, "allies");
  objective_setshowdistance(var_1, 1);
  objective_setbackground(var_1, 0);
  objective_setshowoncompass(var_1, 1);
  objective_setpulsate(var_1, 1);
  thread ref_11f61();
}

function ref_11f61() {
  scripts\engine\utility::flag_wait("heli_assault3_fob_spawned");

  for(var_0 = 0; var_0 < level.sort_goal_positions_by_priority.size; var_0++) {
    var_1 = level.sort_goal_positions_by_priority[var_0];
    var_2 = "fob2_heli_icon" + var_0;
    var_1.objindex = scripts\cp\cp_objectives::requestworldid(var_2, 2);
    objective_setplayintro(var_1.objindex, 0);
    objective_setplayoutro(var_1.objindex, 0);
    objective_setownerteam(var_1.objindex, "axis");
    objective_state(var_1.objindex, "active");
    objective_icon(var_1.objindex, "icon_minimap_littlebird");
    objective_setlocation(var_1.objindex, var_0, var_1);
    thread laser_sights(var_1, var_1.objindex);
  }
}

function ref_11f5e() {
  scripts\engine\utility::flag_wait("players_at_hangar");
  thread ref_11f7b();
  scripts\cp\cp_objectives::freeworldid("obj5_reach_hangar");
  objective_state(level.inittutzones, "done");
  setomnvar("cp_objective_sub_1_index", 4);
  var_0 = (0, 0, 5);
  var_1 = scripts\cp\cp_objectives::requestworldid("obj2_mid", 1);
  level.inittutzones = var_1;
  objective_setplayoutro(var_1, 1);
  objective_setplayintro(var_1, 1);
  objective_state(var_1, "current");
  objective_position(var_1, level.playerexitsafeareamessage[4].origin + var_0);
  objective_setdescription(var_1, &"MATCH_STATUS_HINT/PLANT_BOMBS");
  objective_unpinforteam(var_1, "allies");
  objective_setshowdistance(var_1, 1);
  objective_setbackground(var_1, 0);
  objective_setshowoncompass(var_1, 1);
  objective_setpulsate(var_1, 1);
  objective_setlabel(var_1, &"CP_SO_FINALE/PLANT_BOMBS_ALT1");
  objective_icon(var_1, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_wait("bomb05_planted");
}

function ref_11f7b() {
  scripts\engine\utility::flag_wait("all_vindias_spawned_in");

  for(var_0 = 0; var_0 < level.ref_142b4.size; var_0++) {
    var_1 = level.ref_142b4[var_0];
    var_2 = "hangar_vindia_icon" + var_0;
    var_1.objindex = scripts\cp\cp_objectives::requestworldid(var_2, 2);
    objective_setplayintro(var_1.objindex, 0);
    objective_setplayoutro(var_1.objindex, 0);
    objective_setownerteam(var_1.objindex, "axis");
    objective_state(var_1.objindex, "active");
    objective_icon(var_1.objindex, "icon_minimap_technical");
    objective_setlocation(var_1.objindex, var_0, var_1);
    thread laser_sights(var_1, var_1.objindex);
  }

  for(;;) {
    wait 0.1;
  }

  LOC_000000c1:
    wait 1;

  if(!scripts\engine\utility::flag("assault_finished_in_victory")) {
    ref_12758("dx_mpa_uktl_destroyed_enemy_apc");
    return;
  }
}

function ref_11f5f() {
  scripts\engine\utility::flag_wait("all_hangar_juggernauts_spawned_in");

  for(var_0 = 0; var_0 < level.ref_11bd9.size; var_0++) {
    var_1 = level.ref_11bd9[var_0];
    var_2 = "hangar_jugg_icon" + var_0;
    var_1.objindex = scripts\cp\cp_objectives::requestworldid(var_2, 2);
    objective_setplayintro(var_1.objindex, 0);
    objective_setplayoutro(var_1.objindex, 0);
    objective_setownerteam(var_1.objindex, "axis");
    objective_state(var_1.objindex, "active");
    objective_icon(var_1.objindex, "icon_minimap_juggernaut");
    objective_setminimapiconsize(var_1.objindex, "icon_regular");
    objective_setlocation(var_1.objindex, 0, var_1);
    thread laser_sights(var_1, var_1.objindex);
  }
}

function ref_11f59() {
  scripts\cp\cp_objectives::freeworldid("obj2_mid");
  objective_state(level.inittutzones, "done");
  setomnvar("cp_objective_sub_1_index", 9);
  var_0 = scripts\engine\utility::getStruct("obj7_clear_hangar", "targetname");
  var_1 = scripts\cp\cp_objectives::requestworldid("obj7_cleanup", 1);
  level.inittutzones = var_1;
  objective_setplayoutro(var_1, 1);
  objective_setplayintro(var_1, 1);
  objective_state(var_1, "current");
  objective_setdescription(var_1, &"CP_SO_FINALE/FINALE_OBJ4");
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_unpinforteam(var_1, "allies");
  objective_setshowdistance(var_1, 1);
  objective_setbackground(var_1, 0);
  objective_setshowoncompass(var_1, 1);
  objective_setpulsate(var_1, 1);
  scripts\engine\utility::flag_clear("enemy_spawning_active");
  var_2 = getaiarray("axis");
  var_3 = 1;
  var_4 = 1;
  scripts\engine\utility::flag_wait("all_enemies_spawned_in");

  for(;;) {
    var_2 = getaiarray("axis");

    if(var_4 && var_2.size > 0) {
      scripts\engine\utility::delaythread(1, &ref_12758, "dx_mpa_uktl_exfillosing_start_winningteam");
      var_4 = 0;
    }

    if(var_3 && var_2.size < 8) {
      foreach(var_6 in var_2) {
        thread ref_131f5(var_6);
      }

      var_3 = 0;
    }

    wait 0.1;
  }

  LOC_00000139:
    scripts\engine\utility::flag_set("assault_finished_in_victory");
  setomnvar("cp_objective_index", 0);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_SO_FINALE/FINALE_OBJ_COMPLETE3", "allies", 5);
  thread ref_12758("dx_mpa_uktl_exfillosing_end_winningteam");
  wait 4;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function ref_131f5(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("enemy_icon", 3);
  self.objindex = var_1;
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_setownerteam(var_1, "axis");
  objective_state(var_1, "active");
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_setminimapiconsize(var_1, "icon_regular");
  thread laser_start_ent_thermal(var_1);
  self endon("death");
  objective_onentity(var_1, self);
  objective_setlocation(var_1, 0, self);
  objective_setzoffset(var_1, 75);
}

function laser_fx(var_0) {
  self waittill("death");

  if(isDefined(var_0)) {
    setheadiconimage(var_0);
    return;
  }
}

function laser_sights(var_0, var_1) {
  self waittill("death");
  scripts\cp\cp_objectives::freeworldid(var_1);
  objective_state(var_0, "done");
}

function laser_start_ent_thermal(var_0, var_1) {
  if(isalive(self)) {
    self waittill("death");
  }

  scripts\cp\cp_objectives::freeworldid(var_1);
  objective_state(var_0, "done");
}

function brleaderdialogteamexcludeplayer() {
  level.thermiteboltradiusdamage = [];
  wait 1;
  var_0 = scripts\engine\utility::getStructArray("initial_ally_spawner", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    thread ref_12808(var_3);
    level.thermiteboltradiusdamage[level.thermiteboltradiusdamage.size] = var_3;
    waitframe();
  }

  scripts\engine\utility::flag_wait("start_mission");
  level.brinfilsmokesuffix = scripts\engine\utility::getStructArray("initial_ally_respawn", "targetname");

  for(;;) {
    var_0 = getaiarray("allies");
    var_5 = level.brinfilsmokesuffix[randomint(level.brinfilsmokesuffix.size)];
    var_6 = 4;

    if(level.players.size >= 3) {
      var_6 = 2;
    }

    if(var_0.size < var_6) {
      var_3 = var_5 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      var_3 setgoalvolumeauto(level.initnonbunkerdoorkeypad[level.initoperationcratedata]);
    }

    wait 0.2;
  }
}

function ref_12808(var_0) {
  self endon("death");
  var_1 = getnode(var_0.target, "targetname");
  self setgoalnode(var_1);
  self.ignoreall = 1;
  self.ignoreme = 1;

  if(self.animname == "leader") {
    thread watchtrashcanplayerexit();
  } else if(self.animname == "ally1") {
    thread brloadoutupdateammo();
  } else if(self.animname == "quartermaster") {
    thread ref_1294f();
  }

  scripts\engine\utility::flag_wait("start_mission");

  if(self.animname == "leader") {
    thread watchthrowingkifefireswipe();
  } else if(self.animname == "ally1") {
    thread brleaderdialogplayer("dx_vom_fsa1_tarmac_intro_50");
  } else if(self.animname == "ally2") {
    thread brleaderdialogplayer("dx_vom_fsa2_tarmac_intro_60");
  } else if(self.animname == "ally3") {
    thread brleaderdialogplayer("dx_vom_fsa3_tarmac_intro_70");
  }

  self.ignoreall = 0;
  self.ignoreme = 0;
  self setgoalpos(self.origin);
  waitframe();
  self setgoalvolumeauto(level.initnonbunkerdoorkeypad[level.initoperationcratedata]);
}

function watchtrashcanplayerexit() {
  wait 4;
  self playSound("dx_vom_lf3_rooftop_street_40");
}

function brloadoutupdateammo() {
  wait 6;
  self playSound("dx_vom_lf3_rooftop_street_50");
}

function ref_1294f() {
  wait 8;
  self playSound("dx_vom_lf3_pre_charge_setup_100");
}

function watchthrowingkifefireswipe() {
  self playSound("dx_vom_lf3_containers_heliattack_10");
}

function brleaderdialogplayer(var_0) {
  wait randomfloatrange(0.5, 1);
  self playSound(var_0);
}

function brloadoutcratedestroycallback() {
  var_0 = scripts\engine\utility::getStructArray("ally_rescue1", "targetname");
  var_1 = scripts\engine\utility::getStruct("ally_rescue1_struct", "targetname");
  var_2 = scripts\engine\utility::getStructArray("ally_rescue2", "targetname");
  var_3 = scripts\engine\utility::getStruct("ally_rescue2_struct", "targetname");
  var_4 = scripts\engine\utility::getStructArray("ally_rescue3", "targetname");
  var_5 = scripts\engine\utility::getStruct("ally_rescue3_struct", "targetname");
  var_6 = scripts\engine\utility::getStructArray("ally_rescue4", "targetname");
  var_7 = scripts\engine\utility::getStruct("ally_rescue4_struct", "targetname");
  var_8 = scripts\engine\utility::array_combine(var_0, var_2, var_4, var_6);

  foreach(var_10 in var_8) {
    var_11 = var_10 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    thread ref_1280b(var_11);
  }

  thread ref_143da(var_1);
  thread ref_143da(var_3);
  thread ref_143da(var_5);
  thread ref_143da(var_7);
}

function ref_1280b(var_0) {
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  var_1 = getnode(var_0.target, "targetname");
  self setgoalnode(var_1);
  scripts\common\ai::gun_remove();
  self waittill("ally_rescued");
  scripts\common\ai::gun_recall();
  self.ignoreme = 0;
  self.ignoreall = 0;
  self setgoalpos(self.origin);
  waitframe();
  self setgoalvolumeauto(level.initialize_create_script);
}

function ref_143da(var_0) {
  for(;;) {
    var_1 = scripts\cp\utility::getplayersinradius(self.origin, self.radius);

    if(var_1.size > 0) {
      foreach(var_3 in var_0) {
        if(isalive(var_3)) {
          var_3 notify("ally_rescued");
        }
      }
    }

    wait 0.2;
  }
}

function nocrash() {
  level endon("game_ended");
  level.ref_12c8a = [];
  level.ref_1364d = 0;
  level.ref_135d2["gate_array"] = [8, 10, 14, 16];
  level.ref_135d2["fob_start_array"] = [8, 15, 22, 30];
  level.ref_135d2["fob_end_array"] = [10, 16, 30, 38];
  level.ref_135d2["fob2_array"] = [10, 16, 20, 28];
  level.ref_135d2["hangar_array"] = [10, 16, 30, 38];
  level.ref_135d2["round_time"] = [30, 40, 50, 60];
  level.ref_135d2["wave_min"] = [2, 3, 4, 5];
  level.ref_135d2["wave_min_time"] = [8, 8, 10, 12];
  level.ref_135d2["current"] = level.ref_135d2["gate_array"];
  level.player_has_grenade_crate = 1;
  level.ref_11b4c = undefined;
  var_0 = 0;
  thread laps_data();

  for(;;) {
    if(!scripts\engine\utility::flag("enemy_spawning_active")) {
      scripts\engine\utility::flag_wait("enemy_spawning_active");
    }

    if(isDefined(level.players)) {
      var_0 = level.players.size - 1;
    }

    var_1 = level.ref_135d2["current"][var_0];
    var_2 = level.ref_135d2["wave_min"][var_0];
    var_3 = var_1 + 4;
    var_4 = gettime() + level.ref_135d2["round_time"][var_0] * 1000;

    for(;;) {
      if(level.player_has_grenade_crate) {
        level.player_has_grenade_crate = 0;
        break;
      } else if(spawned_enemies() <= var_2) {
        var_5 = gettime() + level.ref_135d2["wave_min_time"][var_0] * 1000;

        for(;;) {
          if(level.player_has_grenade_crate) {
            level.player_has_grenade_crate = 0;
            break;
          } else if(gettime() >= var_5 || gettime() >= var_4) {
            break;
          }

          wait 0.2;
        }

        break;
      } else if(gettime() >= var_4) {
        break;
      }

      wait 0.2;
    }

    while(isDefined(level.ref_11b4c) && level.ref_11b4c <= 0) {
      wait 0.2;
    }

    for(var_6 = 0; var_6 < var_1; var_6++) {
      var_7 = getaiarray("axis");

      if(spawned_enemies() <= var_3 && var_7.size <= 30) {
        var_8 = ref_12dac();
        var_9 = var_8 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
        level.ref_12c8a[level.ref_12c8a.size] = var_9;
      }

      wait randomfloatrange(0.4, 0.7);
    }

    if(isDefined(level.ref_11b4c)) {
      level.ref_11b4c--;
    }

    if(!scripts\engine\utility::flag("assault1_over")) {
      scripts\engine\utility::flag_wait("assault1_over");
    }
  }
}

function laps_data() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStruct("obj7_clear_hangar", "targetname");

  for(;;) {
    var_1 = getaiarray("axis");

    if(var_1.size > 30) {
      var_2 = prohibited_weapon_list(var_0);

      if(isDefined(var_2)) {
        laser_end_pos(var_2);
      } else {
        wait 0.5;
      }

      continue;
    }

    wait 0.5;
  }
}

function laser_end_pos(var_0) {
  var_1 = sortbydistance(level.ref_12c8a, var_0.origin);
  var_2 = var_1.size - 1;

  for(var_3 = var_2; var_3 >= 0; var_3--) {
    if(isDefined(var_1[var_3]) && isalive(var_1[var_3])) {
      var_1[var_3] kill();
      return;
    }
  }
}

function spawned_enemies() {
  level.ref_12c8a = scripts\engine\utility::array_removedead_or_dying(level.ref_12c8a);
  level.ref_12c8a = scripts\engine\utility::array_removeundefined(level.ref_12c8a);
  return min(level.ref_12c8a.size, 32);
}

function ref_12dac() {
  if(level.ref_1364d >= level.initlocs_keypads.size) {
    level.ref_1364d = 0;
  }

  var_0 = level.initlocs_keypads[level.ref_1364d];
  level.ref_1364d++;
  return var_0;
}

function postspawn_axis() {
  self endon("death");
  waitframe();
  self setgoalvolumeauto(level.initnonbunkerdoors[level.initoperationcratedata]);
  var_0 = scripts\engine\utility::getclosest(self.origin, level.players);
  self getenemyinfo(var_0);
}

function ref_13506() {
  var_0 = scripts\engine\utility::getStructArray("assault2_extras", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getnode(var_2.target, "targetname");
    var_4 = var_2 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_4.ref_13fba = "fallback_3";
    thread ref_13092(var_4, var_3);
    wait 0.2;
  }
}

function ref_13092(var_0, var_1) {
  self endon("death");
  self.matchdata_logchallenge = 1;

  if(isDefined(var_1) && var_1) {
    teleport_ai_to_cover_node(var_0);
  }

  for(var_2 = 0; var_2 <= 10; var_2++) {
    self.goalradius = 4;
    self.fixednode = 1;
    self setgoalnode(var_0);
    wait 0.1;
  }

  if(isDefined(self.ref_13fba)) {
    scripts\engine\utility::flag_wait(self.ref_13fba);
    self.matchdata_logchallenge = undefined;
    return;
  }
}

function ref_13093(var_0) {
  self endon("death");

  if(isDefined(var_0.target)) {
    var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_2 = getnode(var_0.target, "targetname");

    for(var_3 = 0; var_3 <= 10; var_3++) {
      self.goalradius = 64;

      if(isDefined(var_1)) {
        self setgoalpos(var_1.origin);
      } else {
        self setgoalnode(var_2);
      }

      wait 0.1;
    }

    return;
  }
}

function ref_135db(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    foreach(var_5 in var_0) {
      var_6 = var_5 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      var_2 = var_6;
      wait 0.1;
    }

    wait 1;
  }

  return var_2;
}

function spawn_group(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::getStructArray(var_1, "targetname");
  var_8 = undefined;

  foreach(var_10 in var_7) {
    var_11 = var_10 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);

    switch (var_0) {
      case "sniper":
        thread ref_1280d(var_11, var_10, var_2);
        break;
      case "rpg":
        thread ref_1280c(var_11, var_10, var_2);
        var_8 = var_11;
        break;
      case "bomber":
        thread ref_12807(var_11);
        break;
    }

    if(isDefined(var_4)) {
      thread ref_12c88(var_11, var_0, var_10, var_2, var_4, var_5);
    }

    wait 0.1;
  }

  if(isDefined(var_0) && var_0 == "bomber" && isDefined(var_8) && isalive(var_8)) {
    scripts\engine\utility::delaythread(2, &ref_12420, var_8, "dx_mpp_ukft1_ping_enemy_bomber");
    return;
  }
}

function ref_12c88(var_0, var_1, var_2, var_3, var_4, var_5) {
  self waittill("death");

  if(isDefined(var_5)) {
    wait var_5;
  } else {
    wait randomfloatrange(7, 10);
  }

  if(scripts\engine\utility::flag(var_3)) {
    return;
  }

  switch (var_0) {
    case "sniper":
      var_6 = var_1 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      thread ref_1280d(var_6, var_1);

      if(isDefined(var_3)) {
        var_7 = var_4 - 1;

        if(var_7 > 0) {
          thread ref_12c88(var_6, "sniper", var_1, var_2, var_3, var_7);
        }
      }

      break;
    case "rpg":
      var_6 = var_1 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      thread ref_1280c(var_6, var_1);

      if(isDefined(var_3)) {
        var_7 = var_4 - 1;

        if(var_7 > 0) {
          thread ref_12c88(var_6, "rpg", var_1, var_2, var_3, var_7);
        }
      }

      break;
  }
}

function ref_1280c(var_0, var_1, var_2) {
  self endon("death");
  thread ref_12dc4(var_2);

  if(!istrue(var_1)) {
    self.matchdata_logchallenge = 1;
  }

  wait 0.2;
  var_3 = getnode(var_0.target, "targetname");

  if(scripts\engine\utility::flag("fallback_1")) {
    teleport_ai_to_cover_node(var_3);
  }

  self setgoalnode(var_3);
  self.goalradius = 4;
  self.fixednode = 1;
  wait 0.5;
  self.goalradius = 4;
}

function ref_12dc4(var_0) {
  jumpiffalse(isDefined(var_0)) LOC_0000000b;
  level endon(var_0);
  self waittill("death", var_1);

  if(level.ref_123da && isDefined(var_1) && isPlayer(var_1)) {
    ref_123db(var_1, "dx_cbc_usm2_inform_killfirm_rpg");
    return;
  }
}

function ref_123db(var_0, var_1) {
  level.ref_123da = 0;

  if(isalive(var_0)) {
    var_0 playsoundtoteam(var_1, "allies");
  }

  wait 4;
  level.ref_123da = 1;
}

function ref_1280d(var_0, var_1, var_2) {
  self endon("death");
  thread ref_13439(var_2);

  if(!istrue(var_1)) {
    self.matchdata_logchallenge = 1;
  }

  wait 0.2;
  var_3 = getnode(var_0.target, "targetname");

  if(scripts\engine\utility::flag("fallback_1")) {
    teleport_ai_to_cover_node(var_3);
  }

  self setgoalnode(var_3);
  self.goalradius = 4;
  self.fixednode = 1;
  wait 0.5;
  self.goalradius = 4;
}

function ref_13439(var_0) {
  jumpiffalse(isDefined(var_0)) LOC_0000000b;
  level endon(var_0);
  self waittill("death", var_1);

  if(level.ref_123da && isDefined(var_1) && isPlayer(var_1)) {
    ref_123db(var_1, "dx_mpb_ukft1_combat_killfirm_sniper");
    return;
  }
}

function ref_12807(var_0) {
  self endon("death");
  thread create_opaque_ai_contents();
}

function create_opaque_ai_contents() {
  self waittill("death", var_0);

  if(level.ref_123da && isDefined(var_0) && isPlayer(var_0)) {
    ref_123db(var_0, "dx_mpb_ukft1_combat_killfirm_bomber");
    return;
  }
}

function ref_13574() {
  scripts\engine\utility::flag_wait_any("bomb02_planted", "fallback_3");
  thread ref_13578("assault2_juggernaut_spawner", "fob_juggernauts_spawned_in", "all_fob_juggernauts_spawned_in");
  thread ref_11f5c();
}

function ref_13578(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_7, var_5 in level.players) {
    if(var_7 == 3) {
      continue;
    }

    var_6 = var_3[var_7] scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    thread ref_12809(var_6);
    thread vehicle_mp_deletenextframe(var_6);
    level.ref_11bd9[level.ref_11bd9.size] = var_6;

    if(!scripts\engine\utility::flag(var_1)) {
      scripts\engine\utility::flag_set(var_1);
      scripts\engine\utility::flag_clear("enemy_spawning_active");
      thread check_player_used_tacmap();
    }

    wait 1;
  }

  scripts\engine\utility::flag_set(var_2);
}

function ref_13579(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_7, var_5 in level.players) {
    if(var_7 >= 2) {
      continue;
    }

    var_6 = var_3[var_7] scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    thread ref_12809(var_6);
    thread vehicle_mp_deletenextframe(var_6);
    level.ref_11bd9[level.ref_11bd9.size] = var_6;

    if(!scripts\engine\utility::flag(var_1)) {
      scripts\engine\utility::flag_set(var_1);
      setmusicstate("cp_juggernaut_intro");
      thread check_player_used_tacmap();
    }

    wait 1;
  }

  scripts\engine\utility::flag_set(var_2);
}

function check_player_used_tacmap() {
  wait 3;

  if(isalive(self)) {
    thread ref_12420(self, "dx_mpb_ukft1_ping_killstreaks_juggernaut_o");
  }

  wait 2.5;
  ref_12758("dx_mpa_uktl_juggernaut_enemy_use");
}

function ref_12809(var_0) {
  self endon("death");
  GscBinSkip4(0x35);
}

function vehicle_mp_deletenextframelate() {
  jumpiftrue(isalive(self)) LOC_00000009;
  return;
}

function ref_1459d() {
  if(!isDefined(self.damageweapon)) {
    return false;
  }

  var_0 = scripts\cp\utility::getbaseweaponname(self.damageweapon);

  if(var_0 == "iw8_sn_alpha50" || var_0 == "iw8_sh_oscar12") {
    return true;
  }

  return false;
}

function ref_11ca4() {
  if(!isDefined(self.damagemod)) {
    return false;
  }

  if(self.damagemod == "MOD_EXPLOSIVE" || self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_GRENADE_SPLASH") {
    return true;
  }

  return false;
}

function juggernaut_pain_cooldown() {
  self notify("start_new_cooldown");
  self endon("start_new_cooldown");
  wait 7;
  self.stuncooldown = 0;
}

function vehicle_mp_deletenextframe(var_0) {
  self waittill("death", var_1, var_2, var_3, var_4);
  var_5 = self.origin;
  var_6 = self.angles;
  level.ref_11bd9 = scripts\engine\utility::array_remove(level.ref_11bd9, self);

  if(!scripts\engine\utility::flag("first_jugg_dead")) {
    scripts\engine\utility::flag_set("first_jugg_dead");
    thread check_missiles_reloaded_vo();
    thread minecart(var_5, var_6);
    return;
  }
}

function check_missiles_reloaded_vo() {
  level endon("assault_finished_in_victory");
  wait 3.5;
  ref_12758("dx_mpa_uktl_boost_rugby");
}

function vehicle_damage_registerdefaultstates(var_0) {
  if(level.ref_11bd9.size <= var_0) {
    return true;
  }

  return false;
}

function minecart(var_0, var_1) {
  var_2 = ref_12f4f(var_0, var_1, &script_model_pilot_kill_watch, "offhand_wm_supportbox", &"KILLSTREAKS_HINTS/JUGG_CRATE_PICKUP", "hud_icon_killstreak_juggernaut", &vehicle_occupancy_cp_takeriotshield, 1);
}

function script_model_pilot_kill_watch(var_0, var_1) {
  var_2 = scripts\cp\loot_system::get_empty_munition_slot(var_1);

  if(isDefined(var_2)) {
    var_1.vehicle_occupancy_cp_handlesuicidefromvehicles = "juggernaut";
    scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var_1, "juggernaut");
    var_0.valve_steam_on = 1;
    return;
  }

  var_1 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
}

function vehicle_occupancy_cp_takeriotshield(var_0) {
  var_0 endon("entitydeleted");
  thread ref_13f92(var_0, "juggernaut");
}

function display_ai() {
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

      if(var_7 < 9) {
        var_8 = var_1;
      } else if(var_7 < 25) {
        var_8 = var_0;
      } else {
        var_8 = var_2;
      }

      var_4 += 15;
    }

    waitframe();
  }
}

function ref_135ec(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    thread ref_1280e();
  }
}

function ref_1280e() {
  thread scripts\common\vehicle_paths::gopath(self);
  wait 1;
  self setwaitspeed(0);
  var_0 = scripts\engine\utility::ref_143ad("death", "reached_wait_speed");
  self vehicleshowonminimap(0);

  if(isDefined(var_0) && var_0 == "reached_wait_speed") {
    wait 1.5;
    self vehicle_turnengineoff();
    return;
  }
}

function ref_13566() {
  scripts\engine\utility::flag_wait_any("fallback_1", "bomb01_planted");
  level.solution_exists_already = [];
  var_0 = getEntArray("aq_lbravo_assault2", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "left" && level.players.size > 2) {
      var_3 = var_2 scripts\common\utility::spawn_vehicle();
      thread silo_door_left();
      thread skipsplash(var_3, "heli_fob", "left");
      level.solution_exists_already[level.solution_exists_already.size] = var_3;
    } else if(var_2.script_noteworthy == "right") {
      var_3 = var_2 scripts\common\utility::spawn_vehicle();
      thread silo_door_left();
      thread skipsplash(var_3, "heli_fob", "right");
      level.solution_exists_already[level.solution_exists_already.size] = var_3;
    }

    wait 1.5;
  }

  scripts\engine\utility::flag_set("heli_assault2_spawned");
  wait 3;

  if(isDefined(level.solution_exists_already[0])) {
    ref_12420(level.solution_exists_already[0], "dx_mpb_ukft1_ping_concat_high");
    return;
  }
}

function solutions(var_0) {
  if(level.solution_exists_already.size <= var_0) {
    return true;
  }

  return false;
}

function ref_13567() {
  level.sort_goal_positions_by_priority = [];
  var_0 = getEnt("aq_lbravo_assault3_fob2", "targetname");
  var_1 = var_0 scripts\common\utility::spawn_vehicle();
  var_1.ref_1385b = scripts\engine\utility::getStruct("heli_fob2", "targetname");
  var_1.player_too_far = 1;
  var_1.player_test_ending_teleport = "start_fob2_heli_run";
  thread silo_door_runners();
  thread skipsplash(var_1, undefined, undefined);
  level.sort_goal_positions_by_priority[level.sort_goal_positions_by_priority.size] = var_1;
  wait 1;
  scripts\engine\utility::flag_set("heli_assault3_fob_spawned");
}

function ref_13568() {
  level.solved = [];
  var_0 = getEntArray("aq_lbravo_assault3", "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }

    if(var_2.script_noteworthy == "left" && level.players.size > 2) {
      var_2.count++;
      var_3 = var_2 scripts\common\utility::spawn_vehicle();
      thread silo_door_right();
      thread skipsplash(var_3, "heli_hangar", "left");
      level.solved[level.solved.size] = var_3;
    } else if(var_2.script_noteworthy == "right") {
      var_2.count++;
      var_3 = var_2 scripts\common\utility::spawn_vehicle();
      thread silo_door_right();
      thread skipsplash(var_3, "heli_hangar", "right");
      level.solved[level.solved.size] = var_3;
    }

    wait 1.5;
  }

  scripts\engine\utility::flag_set("heli_assault3_spawned");
  wait 3;

  if(isDefined(level.solved[0])) {
    ref_12420(level.solved[0], "dx_mpb_ukft1_ping_concat_high");
    return;
  }
}

function sort_wave_spawning_ai(var_0) {
  if(level.sort_goal_positions_by_priority.size <= var_0) {
    return true;
  }

  return false;
}

function sort_by_ai_assigned(var_0) {
  if(level.solved.size <= var_0) {
    return true;
  }

  return false;
}

function sortbylastzombietime(var_0) {
  if(level.sortbyhvttags.size <= var_0) {
    return true;
  }

  return false;
}

function ref_13569() {
  level.sortbyhvttags = [];
  var_0 = getEntArray("aq_lbravo_assault3", "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }

    if(var_2.script_noteworthy == "left" && level.players.size > 2) {
      var_2.count++;
      var_3 = var_2 scripts\common\utility::spawn_vehicle();
      thread silo_jump_dogtag_revive();
      thread skipsplash(var_3, "heli_hangar_end", "left");
      level.sortbyhvttags[level.sortbyhvttags.size] = var_3;
    } else if(var_2.script_noteworthy == "right") {
      var_2.count++;
      var_3 = var_2 scripts\common\utility::spawn_vehicle();
      thread silo_jump_dogtag_revive();
      thread skipsplash(var_3, "heli_hangar_end", "right");
      level.sortbyhvttags[level.sortbyhvttags.size] = var_3;
    }

    wait 1.5;
  }

  scripts\engine\utility::flag_set("heli_assault3_hangar_spawned");
  wait 3;

  if(isDefined(level.sortbyhvttags[0])) {
    ref_12420(level.sortbyhvttags[0], "dx_mpb_ukft1_ping_concat_high");
    return;
  }
}

function skipsplash(var_0, var_1, var_2) {
  self endon("death");
  self.ref_11d97 = undefined;

  if(isDefined(var_1)) {
    self.ref_11d97 = protect_jammer(var_0, var_1);
  }

  self setvehgoalpos(self.ref_1385b.origin, 1);
  wait 0.05;
  self settargetyaw(self.ref_1385b.angles[1]);
  self sethoverparams(150, 10, 3);
  self setCanDamage(1);
  self setvehicleteam("axis");
  self.script_team = "axis";
  self.script_bulletshield = 0;
  self.waittill_any_timeout_no_endon_death_3 = 0;
  self.godmode = 0;
  self.healthbuffer = 17000;
  GscBinSkip4(0x35);
}

function ref_137b0(var_0) {
  self.player_too_far = 0;
  wait 1;
  var_1 = scripts\engine\utility::getStruct(self.player_test_ending_teleport, "targetname");
  thread scripts\common\vehicle::vehicle_paths(var_1);
  self waittill("reached_dynamic_path_end");
  self setvehgoalpos(var_0.origin, 1);
  wait 0.05;
  self settargetyaw(var_0.angles[1]);
  wait 8;
  self.player_too_far = 1;
}

function prohibited_weapon_list(var_0) {
  var_1 = sortbydistance(level.players, self.origin);

  foreach(var_3 in var_1) {
    if(!scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      if(isDefined(var_0) && var_0) {
        var_4 = scripts\engine\utility::getStructArray("mortar_trace", "targetname");

        if(scripts\engine\trace::ray_trace_passed(var_4[0].origin, var_3 getEye(), [var_3])) {
          return var_3;
        } else if(scripts\engine\trace::ray_trace_passed(var_4[1].origin, var_3 getEye(), [var_3])) {
          return var_3;
        }
      } else {
        return var_5;
      }
    }
  }

  return undefined;
}

function proprotate(var_0) {
  var_1 = sortbydistance(level.players, self.origin);

  if(var_1.size > 1) {
    var_1 = scripts\engine\utility::array_reverse(var_1);
  }

  foreach(var_3 in var_1) {
    if(!scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      if(isDefined(var_0) && var_0) {
        var_4 = scripts\engine\utility::getStructArray("mortar_trace", "targetname");

        if(scripts\engine\trace::ray_trace_passed(var_4[0].origin, var_3 getEye(), [var_3])) {
          return var_3;
        } else if(scripts\engine\trace::ray_trace_passed(var_4[1].origin, var_3 getEye(), [var_3])) {
          return var_3;
        }
      } else {
        return var_5;
      }
    }
  }

  return undefined;
}

function protect_jammer(var_0, var_1) {
  var_2 = [];
  self.called50percentprogress = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");

  foreach(var_4 in self.called50percentprogress) {
    if(isDefined(var_4.script_parameters) && var_4.script_parameters == var_1) {
      var_2 = var_4;
      continue;
    }

    if(isDefined(var_4.script_parameters) && var_4.script_parameters == var_1 + "_start") {
      var_2 = var_4;
      self.ref_1385b = var_4;
    }
  }

  if(!isDefined(self.ref_1385b)) {
    self.ref_1385b = var_2[0];
  }

  return var_2;
}

function heli_shoot_player(var_0) {
  self endon("death_or_disconnect");
  var_1 = 0;

  while(var_1 < 3 && isalive(var_0) && !var_0.inlaststand) {
    var_2 = 0;
    var_3 = gettime() + 2000;

    while(gettime() < var_3) {
      var_4 = self.ref_11c2e gettagorigin("tag_flash");
      var_5 = self.ref_11c2e gettagangles("tag_flash");
      var_6 = var_0.origin + (0, 0, 20);

      if(scripts\engine\utility::within_fov(var_4, var_5, var_6, 0.99) && scripts\engine\trace::ray_trace_passed(var_4, var_6, [self, self.ref_11c2e, var_0])) {
        var_2 = 1;
        break;
      }

      wait 0.1;

      if(!isalive(var_0) || var_0.inlaststand) {
        return;
      }
    }

    if(!var_2) {
      return var_2;
    }

    self.ref_11c2e startbarrelspin();
    wait 1.4;

    if(self.player_controls_failsafe) {
      var_0 scripts\engine\utility::delaycall(0.5, &playsoundtoteam, "dx_mpp_ukft1_combat_inform_taking_fire", "allies");
      self.player_controls_failsafe = 0;
    }

    for(var_7 = 0; var_7 < 30; var_7++) {
      self.ref_11c2e shootturret();
      wait 0.1;

      if(!isalive(var_0) || var_0.inlaststand) {
        break;
      }
    }

    self.ref_11c2e stopbarrelspin();
    wait 0.8;
    return var_2;
  }
}

function silo_door_left() {
  while(!isDefined(self.driver)) {
    wait 0.1;
  }

  scripts\engine\utility::waittill_any_ents(self, "death", self.driver, "death");
  level.solution_exists_already = scripts\engine\utility::array_remove(level.solution_exists_already, self);

  if(isDefined(self)) {
    ref_12420(self, "dx_mpb_ukft1_combat_killfirm_helo");
    return;
  }
}

function silo_door_runners() {
  while(!isDefined(self.driver)) {
    wait 0.1;
  }

  scripts\engine\utility::waittill_any_ents(self, "death", self.driver, "death");
  level.sort_goal_positions_by_priority = scripts\engine\utility::array_remove(level.sort_goal_positions_by_priority, self);

  if(isDefined(self)) {
    ref_12420(self, "dx_mpb_ukft1_combat_killfirm_helo");
    return;
  }
}

function silo_door_right() {
  while(!isDefined(self.driver)) {
    wait 0.1;
  }

  scripts\engine\utility::waittill_any_ents(self, "death", self.driver, "death");
  level.solved = scripts\engine\utility::array_remove(level.solved, self);

  if(isDefined(self)) {
    ref_12420(self, "dx_mpb_ukft1_combat_killfirm_helo");
    return;
  }
}

function silo_jump_dogtag_revive() {
  while(!isDefined(self.driver)) {
    wait 0.1;
  }

  scripts\engine\utility::waittill_any_ents(self, "death", self.driver, "death");
  level.sortbyhvttags = scripts\engine\utility::array_remove(level.sortbyhvttags, self);

  if(isDefined(self)) {
    ref_12420(self, "dx_mpb_ukft1_combat_killfirm_helo");
    return;
  }
}

function heli_crash_on_pilot_death() {
  while(!isDefined(self.driver)) {
    wait 0.1;
  }

  self.driver.health += 100;
  self.driver waittill("death");

  if(scripts\common\vehicle::vehicle_is_crashing()) {
    return;
  }

  self dodamage(self.health - self.healthbuffer + 1, self.origin);
}

function ref_135f2() {
  level.ref_142b4 = [];
  var_0 = getEntArray("hangar_vindia", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.targetname) && var_2.targetname == "vindia02" && level.players.size <= 2) {
      continue;
    }

    var_3 = var_2 scripts\common\vehicle::spawn_vehicle_and_gopath();
    thread ref_1280f(var_3);
    level.ref_142b4[level.ref_142b4.size] = var_3;
  }

  scripts\engine\utility::flag_wait("all_vindias_spawned_in");
  var_5 = 1;

  foreach(var_3 in level.ref_142b4) {
    if(var_5 && isDefined(var_3)) {
      ref_12420(var_3, "dx_mpb_ukft1_ping_enemy_vehicle_heavy");
      wait 2.5;

      if(isDefined(var_3)) {
        ref_12758("dx_mpa_uktl_spotted_enemy_apc");
      }

      var_5 = 0;
    }
  }
}

function ref_1280f(var_0) {
  self endon("death");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.team = "axis";
  self.nodeath = 1;
  scripts\common\vehicle::godon();
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(self);
  self.mainturret turretfiredisable();
  self.mainturret stopfiring();
  self.mainturret makeunusable();
  self.mgturret[0] setmode("manual");
  self.mgturret[0] makeunusable();
  self.mgturret[0] hide();
  var_1 = getEnt("vindia_spotlight" + var_0 + 1, "targetname");
  var_2 = 3;
  var_1.origin = self.mainturret gettagorigin("tag_front_turret_light");
  var_1.origin += anglesToForward(var_1.angles) * var_2;
  var_1.angles = self.mainturret gettagangles("tag_front_turret_light");
  var_1.angles += (10, 0, 0);
  var_1 linkTo(self.mainturret, "tag_front_turret_light");
  var_1.og_intensity = var_1 getlightintensity();
  var_1 setlightintensity(0);
  thread ref_14447();
  thread ref_1444c();
  thread ref_1444e();
  thread watch_for_death(var_1);
  scripts\engine\utility::flag_wait("start_vindia_scene");

  if(!scripts\engine\utility::flag("all_vindias_spawned_in")) {
    scripts\engine\utility::flag_set("all_vindias_spawned_in");
  }

  scripts\common\vehicle::godoff();
  self.ignoreall = 0;
  self.ignoreme = 0;
  thread scripts\common\vehicle::vehicle_lights_on("headlights");
  wait 0.5;
  var_1 setlightintensity(var_1.og_intensity);
  wait 1;
  self.mainturret turretfireenable();
  self.mainturret startfiring();
  var_3 = cos(10);
  thread ref_13a3f();

  for(;;) {
    while(!ref_13e6f(var_3)) {
      wait 0.1;
    }

    while(ref_13e6f(var_3)) {
      for(var_4 = 0; var_4 < randomintrange(4, 5); var_4++) {
        self.mainturret shootturret();
        wait randomfloatrange(0.2, 0.4);
      }

      wait randomintrange(2, 4);
    }
  }
}

function ref_13e6f(var_0) {
  self endon("death");
  var_1 = sortbydistance(level.players, self.origin);

  foreach(var_3 in var_1) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }

    if(scripts\engine\math::within_fov_2d(self.mainturret gettagorigin("tag_flash"), self.mainturret gettagangles("tag_flash"), var_3.origin, var_0)) {
      return true;
    }
  }

  return false;
}

function ref_13a3f() {
  self endon("death");

  for(;;) {
    self waittill("bulletwhizby", var_0);

    if(scripts\engine\utility::array_contains(level.players, var_0)) {
      var_0 setclientomnvar("damage_feedback_icon", "hittankarmor");
      var_0 setclientomnvar("damage_feedback_icon_notify", gettime());
      var_0 setclientomnvar("damage_feedback", "hittankarmor");
      var_0 setclientomnvar("damage_feedback_notify", gettime());
      var_0 setclientomnvar("damage_feedback_nonplayer", 1);
    }
  }
}

function ref_1444c() {
  self endon("death");
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  GscBinSkip4(0x35, var_0, var_1, var_4);
}

function ref_1444e() {
  self endon("death");
  self.mainturret waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  GscBinSkip4(0x35, var_0, var_1, var_4);
}

function ref_13a40(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  if(scripts\engine\utility::array_contains(level.players, var_1)) {
    var_3 = var_1;

    if(isDefined(var_2) && (var_2 == "MOD_EXPLOSIVE" || var_2 == "MOD_GRENADE_SPLASH" || var_2 == "MOD_PROJECTILE_SPLASH")) {
      var_4 = "standard";
    } else {
      var_4 = "standard";
    }
  }

  if(isDefined(var_3)) {
    if(isDefined(var_0)) {
      var_3 setclientomnvar("damage_feedback_icon", var_4);
      var_3 setclientomnvar("damage_feedback", var_4);
      var_3 setclientomnvar("damage_feedback_icon_notify", gettime());
      var_3 setclientomnvar("damage_feedback_notify", gettime());

      if(var_4 == "standard") {
        var_3 setclientomnvar("ui_damage_amount", int(var_0));
      }

      if(var_0 >= self.health - self.healthbuffer) {
        var_3 setclientomnvar("damage_feedback_kill", 1);
        return;
      }

      var_3 setclientomnvar("damage_feedback_kill", 0);
      return;
    }

    return;
  }
}

function ref_14447() {
  self waittill("death");

  while(!scripts\engine\utility::flag("start_vindia_scene")) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && isPlayer(var_1)) {
      scripts\engine\utility::flag_set("start_vindia_scene");
    }

    wait 0.05;
  }
}

function watch_for_death(var_0) {
  self waittill("death");
  var_1 = self.origin;
  var_2 = self.angles;
  self setModel("veh8_mil_lnd_vindia_a1_dst");
  var_3 = anglesToForward(var_2);
  var_4 = anglestoup(var_2);
  var_0 setlightintensity(0);
  playFX(level._effect["vfx_tank_death_exp"], var_1, var_3, var_4);
  wait 4;
  playFX(level._effect["cp_trials_tank_smoke"], var_1, var_3, var_4);
}

function ref_142b5(var_0) {
  if(level.ref_142b4.size <= var_0) {
    return true;
  }

  return false;
}

function teleport_ai_to_cover_node(var_0) {
  var_1 = var_0.angles;
  var_2 = var_0.origin;

  if(!issubstr(var_0.type, "Prone")) {
    if(issubstr(var_0.type, "Left")) {
      var_1 += (0, 90, 0);
    } else if(issubstr(var_0.type, "Right") || issubstr(var_0.type, "Cover Crouch") || issubstr(var_0.type, "Conceal") || issubstr(var_0.type, "Cover Stand")) {
      var_1 -= (0, 90, 0);
    }
  }

  self forceteleport(var_2, var_1);
  self usecovernode(var_0, 1);
  self setgoalnode(var_0);
}

function ref_1357b(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2.origin = scripts\engine\utility::drop_to_ground(var_2.origin);
  var_3 = scripts\cp\laser_traps\cp_laser_traps::get_enter_leave_station_time(var_2.origin, var_2.angles);
  var_4 = scripts\cp\laser_traps\cp_laser_traps::get_ending_struct(var_3);
  var_5 = scripts\cp\laser_traps\cp_laser_traps::get_emp_effect_duration(var_3);
  thread scripts\cp\laser_traps\cp_laser_traps::get_end_ang(var_3, var_4, var_5, var_1);
}

function mud_sfx(var_0) {
  if(var_0 == "axis") {
    return 0;
  }

  var_1 = 60000;

  if(level.time_survived < 9 * var_1) {
    return 3;
  } else if(level.time_survived < 13 * var_1) {
    return 2;
  }

  return 1;
}

function ref_11d32() {
  var_0 = scripts\engine\utility::getStruct("mortar01", "targetname");
  var_1 = scripts\engine\utility::getStruct("mortar02", "targetname");
  wait 1;
  var_2 = 0;
  var_3 = sortbydistance(level.players, var_0.origin);

  foreach(var_5 in var_3) {
    if(!var_2 && isDefined(var_5) && !scripts\cp\cp_laststand::player_in_laststand(var_5)) {
      var_5 scripts\engine\utility::delaycall(1, &playsoundtoteam, "dx_vom_us2_defend_grounds_52", "allies");
      var_2 = 1;
    }
  }

  while(!scripts\engine\utility::flag("assault1_over")) {
    enemy_mortar_launch(var_0, 1);

    if(level.players.size > 2) {
      wait 2.5;
      enemy_mortar_launch(var_1, 0);
    }

    var_7 = getaiarray("axis");

    if(isDefined(var_7) && var_7.size < 3) {
      wait randomfloatrange(4, 5.5);
      continue;
    }

    wait randomfloatrange(5, 6.5);
  }
}

function enemy_mortar_launch(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray("mortar_miss_struct", "targetname");
  var_3 = 2000;
  var_4 = 2.25;
  var_5 = var_0;
  var_6 = undefined;

  if(var_1) {
    var_6 = prohibited_weapon_list(var_0, 1);
  } else {
    var_6 = proprotate(var_0, 1);
  }

  if(!isDefined(var_6)) {
    var_7 = scripts\engine\utility::array_randomize(var_2);
    var_6 = var_7[0];
  }

  var_8 = randomintrange(-250, 100);
  var_9 = randomintrange(100, 250);

  if(isPlayer(var_6) && var_6 issprinting()) {
    var_8 = -600;
    var_9 = 400;
  }

  var_10 = spawnStruct();
  var_10.origin = var_6.origin + (var_8, var_9, 10);
  var_11 = scripts\engine\trace::ray_trace(var_10.origin + (0, 0, 600), var_10.origin);
  var_10.origin = var_11["position"];

  if(getdvarint("scr_mortar_gravity")) {
    var_12 = distance(var_5.origin, var_10.origin);
    var_4 = var_12 / var_3 * var_4;
  }

  var_13 = scripts\engine\utility::spawn_tag_origin(var_5.origin, (0, 0, 0));
  var_13 show();
  wait 0.15;
  playFXOnTag(level._effect["vfx_smktrail_mortar"], var_13, "tag_origin");
  playFXOnTag(level._effect["vfx_mortar_trail"], var_13, "tag_origin");
  playFX(level._effect["vfx_emb_flash_mortar"], var_5.origin);

  if(distance2d(var_10.origin, var_5.origin) < 400) {
    earthquake(0.1, 2, var_5.origin, 2000);

    if(isPlayer(var_6)) {
      level.player playRumbleOnEntity("damage_light");
    }
  }

  wait 0.1;

  if(isPlayer(var_6)) {
    var_6 playRumbleOnEntity("damage_heavy");
  }

  playsoundatpos(var_13.origin, "weap_mortar_fire_dist");
  var_13 playLoopSound("weap_mortar_fly_lp");
  var_14 = max(0.05, var_4 - 1.7);
  playsoundatpos(var_13.origin, "weap_mortar_incoming");
  movemortar(var_13, var_5.origin, var_10.origin, var_4);
  level notify("mortar_impact");
  var_13 stoploopsound("weap_mortar_fly_lp");
  var_13 delete();
  radiusdamage(var_10.origin, 500, 1, 1);
  earthquake(0.4, 1.5, var_10.origin, 2000);
  playrumbleonposition("damage_heavy", var_6.origin);
  playFX(level._effect["vfx_mortar_explosion"], var_10.origin);
  var_12 = distance(var_6.origin, var_10.origin);

  if(300 > distance(var_6.origin, var_10.origin)) {
    if(isPlayer(var_6) && var_6.origin[2] + 100 > var_10.origin[2]) {
      var_6 scripts\engine\utility::delaycall(0.75, &shellshock, "default", 1);
    }
  }

  magicgrenademanual("mortar_mp", var_10.origin + (0, 0, 5), (0, 0, 0), 0.05);
  physicsexplosionsphere(var_10.origin, 300, 150, 100);
  return true;
}

function movemortar(var_0, var_1, var_2, var_3, var_4) {
  setdvarifuninitialized("scr_mortar_gravity", "0 ");

  if(getdvarint("scr_mortar_gravity")) {
    var_0.origin = var_1;
    var_5 = getdvarint("NPOQPMP");
    var_6 = distance(var_1, var_2);
    var_7 = var_2 - var_1;
    var_8 = 0.5 * var_5 * squared(var_3) * -1;
    var_9 = (var_7[0] / var_3, var_7[1] / var_3, (var_7[2] - var_8) / var_3);
    var_0 movegravity(var_9, var_3);
    var_10 = gettime() + var_3 * 1000;

    while(gettime() < var_10) {
      anglemortar(var_0);
      waitframe();
    }

    return;
  }

  var_11 = 1200;

  if(isDefined(var_4)) {
    var_11 = var_4;
  }

  var_12 = 1 / var_3 / 0.05;
  var_13 = 0;

  while(var_13 < 1) {
    var_0.origin = scripts\engine\math::get_point_on_parabola(var_1, var_2, var_11, var_13);
    anglemortar(var_0);
    var_13 += var_12;
    wait 0.05;
  }

  var_0.origin = var_2;
}

function anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

function enemy_mortar(var_0) {
  wait 0.25;
  enemy_mortar_launch(var_0);
  wait level.mortar_round_delay_time;
  thread enemy_mortar(var_0);
}

function ref_11cc5() {
  var_0 = scripts\engine\utility::getStructArray("molotov_launcher", "targetname");
  var_1 = var_0[0];
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_3 = squared(2000);

  while(!scripts\engine\utility::flag("assault1_over")) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    if(scripts\engine\utility::is_equal(var_1, var_0[0])) {
      var_1 = var_0[1];
    } else {
      var_1 = var_0[0];
    }

    var_2.origin = var_1.origin;
    var_4 = prohibited_weapon_list(var_2);
    var_5 = distancesquared(var_4.origin, var_2.origin);

    if(var_5 >= var_3) {
      wait 0.1;
      continue;
    }

    if(isDefined(var_4)) {
      var_6 = scripts\cp\laser_traps\cp_laser_traps::put_headicon_on_tv_station_boss();
      var_7 = scripts\engine\utility::getclosest(var_2.origin, var_6);
      no_csm(var_1, var_4, var_7);
      wait randomfloatrange(4.5, 6.5);
    }

    wait 0.1;
  }
}

function no_csm(var_0, var_1, var_2) {
  var_3 = 6000;
  var_4 = 6.25;
  var_5 = spawnStruct();
  var_5.origin = var_0.origin;
  var_6 = spawnStruct();
  var_6.origin = var_1.origin;
  var_7 = scripts\engine\trace::ray_trace(var_6.origin + (0, 0, 1000), var_6.origin);
  var_6.origin = var_7["position"];
  var_8 = distance(var_5.origin, var_6.origin);
  var_4 = var_8 / var_3 * var_4;
  var_9 = scripts\engine\utility::spawn_tag_origin(var_5.origin, (0, 0, 0));
  wait 0.1;
  var_10 = max(0.05, var_4 - 1.7);
  var_11 = randomintrange(-100, 100);
  var_12 = randomintrange(-100, 100);

  if(var_1 issprinting()) {
    var_11 = randomintrange(-300, 300);
    var_12 = randomintrange(-300, 300);
  }

  ref_11d8e(var_9, var_5.origin, var_1.origin + (var_11, var_12, 10), var_4);
  level notify("mortar_impacted");
  var_9 delete();

  if(!isalive(var_2)) {
    return;
  }

  var_2 endon("death");
  var_2.grenadeweapon = getcompleteweaponname("molotov_mp");
  var_13 = var_2 magicgrenademanual(var_1.origin + (var_11, var_12, 10), var_1.origin);
}

function ref_11d8e(var_0, var_1, var_2, var_3) {
  var_0.origin = var_1;
  var_4 = getdvarint("NPOQPMP");
  var_5 = distance(var_1, var_2);
  var_6 = var_2 - var_1;
  var_7 = 0.5 * var_4 * squared(var_3) * -1;
  var_8 = (var_6[0] / var_3, var_6[1] / var_3, (var_6[2] - var_7) / var_3);
  var_0 movegravity(var_8, var_3);
  var_9 = gettime() + var_3 * 1000;

  while(gettime() < var_9) {
    building_magic_grenade_kill_watch(var_0);
    waitframe();
  }
}

function building_magic_grenade_kill_watch() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

function ref_13423(var_0) {
  var_1 = 0.5;
  var_2 = 1;
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    playFX(level._effect["smoke_grenade_explosion"], var_5.origin);
    playFX(level._effect["smoke_grenade_fx"], var_5.origin);
    wait randomfloatrange(0.15, 0.3);
  }
}

function weapon_xp_iw8_sh_romeo870(var_0) {
  var_1 = (0, 0, 2);
  var_2 = (0, -90, 0);

  foreach(var_4 in var_0) {
    var_5 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var_4.origin + var_1, var_4.angles + var_2);
  }
}

function weapon_xp_iw8_sn_golf28(var_0) {
  var_1 = (0, -90, 0);

  foreach(var_3 in var_0) {
    switch (var_3.script_parameters) {
      case "ammo":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var_3.origin, var_3.angles + var_1);
        var_4 setHintString(&"COOP_CRAFTING/AMMO_CRATE_TAKE");
        break;
      case "claymore":
        var_4 = ref_12f4f(var_3.origin, var_3.angles, &scripts\cp\laser_traps\cp_laser_traps::handle_no_ammo_mun, var_3, &"EQUIPMENT_HINTS/PICKUP_CLAYMORE", undefined, &handle_nav_bounds_buildings);
        break;
      case "flash":
        var_4 = ref_12f4f(var_3.origin, var_3.angles, &scripts\cp\laser_traps\cp_laser_traps::player_max_exposure_time, var_3, &"CP_SO_FINALE/PICKUP_FLASH", undefined, &player_looking);
        break;
      case "c4":
        var_4 = ref_12f4f(var_3.origin, var_3.angles, &scripts\cp\laser_traps\cp_laser_traps::fogenabled, var_3, &"EQUIPMENT_HINTS/PICKUP_C4", undefined, &focus_fire_outline_id);
        break;
      case "stim":
        var_4 = ref_12f4f(var_3.origin, var_3.angles, &ref_138ab, var_3, &"CP_SO_FINALE/PICKUP_STIMS", undefined, &ref_138aa);
        break;
      case "molotov":
        var_4 = ref_12f4f(var_3.origin, var_3.angles, &scripts\cp\laser_traps\cp_laser_traps::ref_11cba, var_3, &"CP_SO_FINALE/PICKUP_MOLOTOV", undefined, &ref_11cb9);
        break;
    }
  }
}

function weapon_xp_iw8_sn_delta(var_0) {
  var_1 = (0, -90, 0);

  foreach(var_3 in var_0) {
    switch (var_3.script_parameters) {
      case "ammo":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var_3.origin, var_3.angles + var_1);
        break;
      case "claymore":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding(var_3.origin, var_3.angles + var_1);
        break;
      case "flash":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::player_limitedammo(var_3.origin, var_3.angles + var_1);
        break;
      case "c4":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled(var_3.origin, var_3.angles + var_1);
        break;
      case "stim":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime(var_3.origin, var_3.angles + var_1);
        break;
      case "molotov":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::ref_11cb8(var_3.origin, var_3.angles + var_1);
        break;
      case "frag":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(var_3.origin, var_3.angles + var_1);
        break;
    }
  }
}

function handle_nav_bounds_buildings(var_0) {
  var_0 endon("entitydeleted");
  thread ref_13f95(var_0, "power_claymore");
}

function player_looking(var_0) {
  var_0 endon("entitydeleted");
  thread ref_13f95(var_0, "power_flash");
}

function focus_fire_outline_id(var_0) {
  var_0 endon("entitydeleted");
  thread ref_13f95(var_0, "power_c4");
}

function ref_138ab(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("equip_adrenaline", "secondary", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function ref_138aa(var_0) {
  var_0 endon("entitydeleted");
  thread ref_13f95(var_0, "equip_adrenaline");
}

function ref_11cb9(var_0) {
  var_0 endon("entitydeleted");
  thread ref_13f95(var_0, "power_molotov");
}

function ref_13f95(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    var_5 = isDefined(var_4.powers) && isDefined(var_4.powers[var_1]) && var_4.powers[var_1].charges == var_4.powers[var_1].maxcharges;

    if(var_5) {
      var_0 disableplayeruse(var_4);

      if(isDefined(var_0.nuke_removefadeonbnkplay)) {
        var_0.nuke_removefadeonbnkplay hidefromplayer(var_4);
      }

      continue;
    }

    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  for(;;) {
    var_7 = [];

    foreach(var_4 in level.players) {
      var_5 = isDefined(var_4.powers) && isDefined(var_4.powers[var_1]) && var_4.powers[var_1].charges == var_4.powers[var_1].maxcharges;

      if(var_5) {
        if(scripts\engine\utility::array_contains(var_2, var_4)) {
          var_0 disableplayeruse(var_4);

          if(isDefined(var_0.nuke_removefadeonbnkplay)) {
            var_0.nuke_removefadeonbnkplay hidefromplayer(var_4);
          }
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(var_2, var_4)) {
        var_0 enableplayeruse(var_4);

        if(isDefined(var_0.nuke_removefadeonbnkplay)) {
          var_0.nuke_removefadeonbnkplay showtoplayer(var_4);
        }
      }

      var_7 = scripts\engine\utility::array_add(var_7, var_4);
    }

    var_2 = var_7;
    wait 0.1;
  }
}

function weaponclassweights(var_0) {
  foreach(var_2 in var_0) {
    var_3 = fire_rockets_to_target(var_2.script_parameters);
    var_4 = createheadicon(var_3);
    var_3 = spawn("weapon_" + var_4, var_2.origin, 1);
    var_3.angles = var_2.angles;

    if(var_2.script_parameters == "iw8_la_mike32_mp") {
      thread ref_1432a();
    }

    var_3 itemweaponsetammo(weaponclipsize(var_4), weaponmaxammo(var_4));
  }
}

function ref_1432a() {
  self waittill("trigger", var_0);

  if(isPlayer(var_0)) {
    var_0 thread scripts\mp\trials\trial_pitcher::firemanager();
    return;
  }
}

function fire_rockets_to_target(var_0) {
  switch (var_0) {
    case "iw8_la_juliet_mp":
      return scripts\cp\cp_weapon::buildweapon("iw8_la_juliet_mp", [], "none", "none", -1);
    case "iw8_sn_delta_mp":
      return scripts\cp\cp_weapon::buildweapon_variant("iw8_sn_delta", "none", "none", 2);
    case "iw8_lm_kilo121_mp":
      return scripts\cp\cp_weapon::buildweapon_variant("iw8_lm_kilo121", "none", "none", 2);
    case "iw8_sh_oscar12_mp":
      return scripts\cp\cp_weapon::buildweapon("iw8_sh_oscar12_mp", ["reflex_east02", "stockh_oscar12", "drums_oscar12", "barmid_oscar12"], "none", "none");
    case "iw8_ar_scharlie_mp":
      return scripts\cp\cp_weapon::buildweapon_variant("iw8_ar_scharlie", "none", "none", 2);
    case "iw8_sm_papa90_mp":
      return scripts\cp\cp_weapon::buildweapon_variant("iw8_sm_papa90", "none", "none", 1);
    case "iw8_la_rpapa7_mp":
      return scripts\cp\cp_weapon::buildweapon("iw8_la_rpapa7_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
    case "iw8_la_mike32_mp":
      return scripts\cp\cp_weapon::buildweapon("iw8_la_mike32_mp", ["calcust", "lnchrscope_mike32"]);
    case "iw8_ar_akilo47_mp":
    default:
      return scripts\cp\cp_weapon::buildweapon_variant("iw8_ar_akilo47", "none", "none", 3);
  }
}

function weapon_xp_iw8_sn_alpha50(var_0) {
  foreach(var_2 in var_0) {
    switch (var_2.script_parameters) {
      case "assault":
        var_3 = ref_12f4f(var_2.origin, var_2.angles, &scrambler_cleanup_player, var_2, &"KILLSTREAKS/PRECISION_AIRSTRIKE", undefined, &vo_two_remain, 1);
        break;
      case "support":
        var_3 = ref_12f4f(var_2.origin, var_2.angles, &scrapassistdamage, var_2, &"KILLSTREAKS/TOMA_STRIKE", undefined, &vo_two_remain, 1);
        break;
      case "demo":
        var_3 = ref_12f4f(var_2.origin, var_2.angles, &screen, var_2, &"KILLSTREAKS/SENTRY", undefined, &vo_two_remain, 1);
        break;
      case "recon":
        var_3 = ref_12f4f(var_2.origin, var_2.angles, &screen, var_2, &"KILLSTREAKS/SENTRY", undefined, &vo_two_remain, 1);
        break;
    }
  }
}

function scrambler_cleanup_player(var_0, var_1) {
  var_2 = scripts\cp\loot_system::get_empty_munition_slot(var_1);

  if(isDefined(var_2)) {
    var_1 notify("new_killstreak_loadout_aquired");
    scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var_1, "precision_airstrike");
    var_0.valve_steam_on = 1;
    var_1.vo_stealth_broken = 1;
    var_1 forceplaygestureviewmodel("ges_swipe", var_0);
    var_1 playlocalsound("weap_ammo_pickup");
    return;
  }

  var_1 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
}

function scrapassistdamage(var_0, var_1) {
  var_2 = scripts\cp\loot_system::get_empty_munition_slot(var_1);

  if(isDefined(var_2)) {
    var_1 notify("new_killstreak_loadout_aquired");
    scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var_1, "cluster_strike");
    var_0.valve_steam_on = 1;
    var_1.vo_stealth_broken = 1;
    var_1 forceplaygestureviewmodel("ges_swipe", var_0);
    var_1 playlocalsound("weap_ammo_pickup");
    return;
  }

  var_1 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
}

function screen(var_0, var_1) {
  var_2 = scripts\cp\loot_system::get_empty_munition_slot(var_1);

  if(isDefined(var_2)) {
    var_1 notify("new_killstreak_loadout_aquired");
    scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var_1, "sentry");
    var_0.valve_steam_on = 1;
    var_1.vo_stealth_broken = 1;
    var_1 forceplaygestureviewmodel("ges_swipe", var_0);
    var_1 playlocalsound("weap_ammo_pickup");
    return;
  }

  var_1 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
}

function has_termal(var_0, var_1) {
  var_1 notify("new_killstreak_loadout_aquired");
  var_2 = "precision_airstrike";
  var_1.vo_three_remain = "assault";
  ref_13201(var_1, var_2);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function hasactivepunchcard(var_0, var_1) {
  var_2 = "cluster_strike";
  var_1.vo_three_remain = "support";
  ref_13201(var_1, var_2);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function hasaccesscard(var_0, var_1) {
  var_2 = "sentry";
  var_1.vo_three_remain = "recon";
  ref_13201(var_1, var_2);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function has_zone(var_0, var_1) {
  var_2 = "cruise_missile";
  var_1.vo_three_remain = "demo";
  ref_13201(var_1, var_2);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function ref_13201(var_0) {
  scripts\cp\cp_munitions::give_munition_to_slot(var_0, 0);
}

function ref_12b40(var_0, var_1) {
  self endon("new_killstreak_loadout_aquired");

  for(;;) {
    self waittill("munitions_used", var_2);
    waitframe();
    self.munition_splash_supress = 1;

    if(var_2 == var_0) {
      if(self.munition_slots[0].can_use) {
        thread vo_stealth_exchange(var_0, 0, "cp_munition_1_timer");
      }

      continue;
    }

    if(var_2 == var_1) {
      if(self.munition_slots[1].can_use) {
        thread vo_stealth_exchange(var_1, 1, "cp_munition_2_timer");
      }
    }
  }
}

function vo_stealth_exchange(var_0, var_1, var_2) {
  self.munition_slots[var_1].can_use = 0;
  var_3 = undefined;

  if(var_1 == 0) {
    var_3 = 12;
  } else {
    var_3 = 20;
  }

  thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SO_FINALE/COOLDOWN_KS", 2.5);
  wait var_3;
  scripts\cp\cp_munitions::give_munition_to_slot(var_0, var_1);
  self.munition_slots[var_1].can_use = 1;
}

function ref_13ea5(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");
  self sethudtutorialmessage(var_0, var_2);
  wait var_1;
  self clearhudtutorialmessage();
}

function vo_two_remain(var_0) {
  var_0 endon("entitydeleted");
  thread ref_13f93(var_0);
}

function ref_13f93(var_0) {
  var_0 endon("entitydeleted");
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(var_3.vo_stealth_broken) && var_3.vo_stealth_broken) {
      var_0 disableplayeruse(var_3);
      var_0 hidefromplayer(var_3);
      continue;
    }

    var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  for(;;) {
    var_5 = [];

    foreach(var_3 in level.players) {
      if(isDefined(var_3.vo_stealth_broken) && var_3.vo_stealth_broken) {
        if(scripts\engine\utility::array_contains(var_1, var_3)) {
          var_0 disableplayeruse(var_3);
          var_0 hidefromplayer(var_3);
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(var_1, var_3)) {
        var_0 enableplayeruse(var_3);
        var_0 showtoplayer(var_3);
      }

      var_5 = scripts\engine\utility::array_add(var_5, var_3);
    }

    var_1 = var_5;
    wait 0.1;
  }

  var_0 delete();
}

function carepackage_set_visible_model(var_0) {
  var_0 endon("entitydeleted");
  thread ref_13f94(var_0, "assault");
}

function ref_139ad(var_0) {
  var_0 endon("entitydeleted");
  thread ref_13f94(var_0, "support");
}

function ref_12a96(var_0) {
  var_0 endon("entitydeleted");
  thread ref_13f94(var_0, "recon");
}

function laststand_dogtag_monitor(var_0) {
  var_0 endon("entitydeleted");
  thread ref_13f94(var_0, "demo");
}

function ref_13f94(var_0, var_1) {
  var_0 endon("entitydeleted");
  var_2 = [];

  foreach(var_4 in level.players) {
    if(isDefined(var_4.ref_124fd)) {
      var_0 disableplayeruse(var_4);
      wait 0.1;
      continue;
    }

    if(isDefined(var_4.vo_three_remain) && var_4.vo_three_remain == var_1) {
      var_0 disableplayeruse(var_4);

      if(isDefined(var_0.nuke_removefadeonbnkplay)) {
        var_0.nuke_removefadeonbnkplay hidefromplayer(var_4);
      }

      continue;
    }

    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  for(;;) {
    var_6 = [];

    foreach(var_4 in level.players) {
      if(isDefined(var_4.ref_124fd)) {
        var_0 disableplayeruse(var_4);
        wait 0.1;
        continue;
      }

      if(isDefined(var_4.vo_three_remain) && var_4.vo_three_remain == var_1) {
        if(scripts\engine\utility::array_contains(var_2, var_4)) {
          var_0 disableplayeruse(var_4);

          if(isDefined(var_0.nuke_removefadeonbnkplay)) {
            var_0.nuke_removefadeonbnkplay hidefromplayer(var_4);
          }
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(var_2, var_4)) {
        var_0 enableplayeruse(var_4);

        if(isDefined(var_0.nuke_removefadeonbnkplay)) {
          var_0.nuke_removefadeonbnkplay showtoplayer(var_4);
        }
      }

      var_6 = scripts\engine\utility::array_add(var_6, var_4);
    }

    var_2 = var_6;
    wait 0.1;
  }
}

function ref_13f92(var_0, var_1) {
  var_0 endon("entitydeleted");
  var_2 = [];

  foreach(var_4 in level.players) {
    if(isDefined(self.ref_124fd)) {
      var_0 disableplayeruse(var_4);
      waitframe();
      continue;
    }

    if(isDefined(var_4.vehicle_occupancy_cp_handlesuicidefromvehicles) && var_4.vehicle_occupancy_cp_handlesuicidefromvehicles == var_1) {
      var_0 disableplayeruse(var_4);
      var_0 hidefromplayer(var_4);
      continue;
    }

    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  for(;;) {
    var_6 = [];

    foreach(var_4 in level.players) {
      if(isDefined(self.ref_124fd)) {
        var_0 disableplayeruse(var_4);
        waitframe();
        continue;
      }

      if(isDefined(var_4.vehicle_occupancy_cp_handlesuicidefromvehicles) && var_4.vehicle_occupancy_cp_handlesuicidefromvehicles == var_1) {
        if(scripts\engine\utility::array_contains(var_2, var_4)) {
          var_0 disableplayeruse(var_4);
          var_0 hidefromplayer(var_4);
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(var_2, var_4)) {
        var_0 enableplayeruse(var_4);
        var_0 showtoplayer(var_4);
      }

      var_6 = scripts\engine\utility::array_add(var_6, var_4);
    }

    var_2 = var_6;
    wait 0.1;
  }

  var_0 delete();
}

function ref_12f4f(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawn("script_model", var_0);

  if(isDefined(var_1)) {
    var_8.angles = var_1;
  } else {
    var_8.angles = (0, 0, 0);
  }

  if(isDefined(var_3)) {
    if(isstring(var_3)) {
      var_8 setModel(var_3);
    } else if(isstruct(var_3) && isDefined(var_3.target)) {
      var_8.nuke_removefadeonbnkplay = getEnt(var_3.target, "targetname");
    }
  }

  scripts\cp\cp_outline_utility::outlineenableforall(var_8, "outline_depth_white", "equipment");

  if(isDefined(var_5)) {
    var_8.headicon = thread scripts\cp\utility::ent_createheadicon(var_8, 15, "allies", var_5, 1);
    setheadiconsnaptoedges(var_8.headicon, 1500);
    setheadiconmaxdistance(var_8.headicon, 15);
  }

  var_8 setCursorHint("HINT_BUTTON");
  var_8 sethintdisplayrange(200);
  var_8 sethintdisplayfov(45);
  var_8 setuserange(100);
  var_8 setusefov(40);
  var_8 sethintonobstruction("show");
  var_8 setuseholdduration("duration_none");
  var_8 makeusable();

  if(isDefined(var_4)) {
    var_8 setHintString(var_4);
  }

  var_8.valve_steam_on = 0;

  if(isDefined(var_6)) {
    GscBinSkip1(0x74, var_6, var_8);
  }

  thread ref_12f50(var_8, var_2, var_7);
  return var_8;
}

function ref_12f50(var_0, var_1, var_2) {
  var_0 endon("entitydeleted");

  for(;;) {
    var_0 waittill("trigger", var_3);

    if(!isPlayer(var_3)) {
      continue;
    }

    GscBinSkip1(0x74, var_1, var_0, var_3);
  }
}

function ref_12758(var_0) {
  if(!isDefined(level.ref_121a7)) {
    level.ref_121a7 = spawn("script_origin", (0, 0, 0));
  }

  level.ref_121a7 stopsounds();
  var_1 = lookupsoundlength(var_0) * 0.001;
  level.ref_121a7 playSound(var_0);
  wait var_1;
}

function ref_12759(var_0, var_1) {
  if(scripts\engine\utility::flag(var_1)) {
    return;
  }

  level endon(var_1);

  if(!isDefined(level.ref_121a7)) {
    level.ref_121a7 = spawn("script_origin", (0, 0, 0));
  }

  level.ref_121a7 stopsounds();
  var_2 = lookupsoundlength(var_0) * 0.001;
  level.ref_121a7 playSound(var_0);
  wait var_2;
}

function ref_12420(var_0, var_1) {
  var_2 = var_0 scripts\cp\utility::get_closest_living_player();

  if(isDefined(var_2)) {
    var_2 playsoundtoteam(var_1, "allies");
    return;
  }
}

#using_animtree("");

function supply_station_direction() {
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["infil_ride_idle"] = $cp_scripted_plane_sit_loop_02;
  level.scr_animname["slot_0"]["infil_ride_idle"] = "cp_scripted_plane_sit_loop_02";
  level.scr_eventanim["slot_0"]["infil_ride_idle"] = "plane_sit_loop_02";
  level.scr_anim["slot_0"]["infil_ride_exit"] = % cp_scripted_plane_sit_exit;
  level.scr_animname["slot_0"]["infil_ride_exit"] = "cp_scripted_plane_sit_exit";
  level.scr_eventanim["slot_0"]["infil_ride_exit"] = "plane_sit_exit";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["infil_ride_idle"] = % cp_scripted_plane_sit_loop_01;
  level.scr_animname["slot_1"]["infil_ride_idle"] = "cp_scripted_plane_sit_loop_01";
  level.scr_eventanim["slot_1"]["infil_ride_idle"] = "plane_sit_loop_01";
  level.scr_anim["slot_1"]["infil_ride_exit"] = % cp_scripted_plane_sit_exit;
  level.scr_animname["slot_1"]["infil_ride_exit"] = "cp_scripted_plane_sit_exit";
  level.scr_eventanim["slot_1"]["infil_ride_exit"] = "plane_sit_exit";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["infil_ride_idle"] = % cp_scripted_plane_sit_loop_02;
  level.scr_animname["slot_2"]["infil_ride_idle"] = "cp_scripted_plane_sit_loop_02";
  level.scr_eventanim["slot_2"]["infil_ride_idle"] = "plane_sit_loop_02";
  level.scr_anim["slot_2"]["infil_ride_exit"] = % cp_scripted_plane_sit_exit;
  level.scr_animname["slot_2"]["infil_ride_exit"] = "cp_scripted_plane_sit_exit";
  level.scr_eventanim["slot_2"]["infil_ride_exit"] = "plane_sit_exit";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["infil_ride_idle"] = % cp_scripted_plane_sit_loop_03;
  level.scr_animname["slot_3"]["infil_ride_idle"] = "cp_scripted_plane_sit_loop_03";
  level.scr_eventanim["slot_3"]["infil_ride_idle"] = "plane_sit_loop_03";
  level.scr_anim["slot_3"]["infil_ride_exit"] = % cp_scripted_plane_sit_exit;
  level.scr_animname["slot_3"]["infil_ride_exit"] = "cp_scripted_plane_sit_exit";
  level.scr_eventanim["slot_3"]["infil_ride_exit"] = "plane_sit_exit";
}