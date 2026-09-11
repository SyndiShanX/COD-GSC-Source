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

  var0 = getDvar("cp_so_finale_start_obj", "");

  if(isDefined(var0) && var0 != "") {
    thread rundebugstartobjective(level);
  }

  level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  scripts\cp\cp_compass::setupminimap("compass_map_cp_so_finale");
  scripts\engine\utility::create_func_ref("vehicle_damage_modifier", &scripts\cp\cp_vehicles::incrementobjectiveachievementkill);
  supply_station_direction();
  thread play_operator_reply_vo();
}

function ref_11c1e() {
  var0 = getEntArray("minimap_corner", "targetname");
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

function ref_1247b(var0) {}

function play_overlord_howcopy_vo() {
  var0 = scripts\engine\utility::getStructArray("level_crate_spawn_struct", "targetname");
  weapon_xp_iw8_sn_golf28(var0);
  var0 = scripts\engine\utility::getStructArray("level_crate_refill_spawn_struct", "targetname");
  weapon_xp_iw8_sn_delta(var0);
  var1 = scripts\engine\utility::getStructArray("ammo_crate", "targetname");
  weapon_xp_iw8_sh_romeo870(var1);
  var2 = scripts\engine\utility::getStructArray("level_weapon_spawn_struct", "targetname");
  weaponclassweights(var2);
  var3 = scripts\engine\utility::getStructArray("killstreak_spawn_struct", "targetname");
  weapon_xp_iw8_sn_alpha50(var3);
}

function onplayerspawned() {
  scripts\cp\gametypes\cp_specops::givedefaultloadout();
  var0 = "iw8_ar_scharlie";
  var1 = scripts\cp\cp_weapon::buildweapon(var0, ["acog_west01_irons", "mmags_scharlie", "back_scharlie", "barlong_scharlie", "rec_scharlie"], "none", "none");
  self giveweapon(var1);
  self setweaponammoclip(var1, weaponclipsize(var1));
  self setweaponammostock(var1, weaponmaxammo(var1));
  self switchtoweapon(var1);
  var2 = "iw8_pi_mike1911";
  var3 = scripts\cp\cp_weapon::buildweapon(var2, ["rec_mike1911", "mag_mike1911", "slide_mike1911", "xmags"], "none", "none");
  self giveweapon(var3);
  self setweaponammoclip(var3, weaponclipsize(var3));
  self setweaponammostock(var3, weaponmaxammo(var3));
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

function rundebugstartobjective(var0) {
  wait 2;
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("objective_table_parsed");

  if(isDefined(level.objectivestabledata[var0])) {
    var1 = level.objectivestabledata[var0];

    if(isDefined(var1.ondebugstartfunc)) {
      [[var1.ondebugstartfunc]](var1);
    }

    thread scripts\cp\cp_objectives::run_objective(var1.objname, var1.questtype);
    return;
  }
}

function onplayerspawneddevguisetup(var0) {
  var1 = var0.name;
  var2 = undefined;

  foreach(var4 in level.players) {
    if(var4 == var0) {
      var2 = int(var5);
      break;
    }
  }

  if(isDefined(var2)) {
    thread setupdevguientries(var0, var0, var1);
    return;
  }
}

function setupdevguientries(var0, var1, var2) {}

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
    var0 = getDvar("scr_strike_name");
    var1 = undefined;

    switch (var0) {
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

function onplayerconnect(var0) {
  thread bug_test_move_startpoint();
}

function bug_test_move_startpoint() {
  if(getdvarint("scr_linkto_test", 0)) {
    var0 = scripts\engine\utility::getStructArray("default_player_start", "targetname");

    foreach(var2 in var0) {
      var2.origin = (3743, -1008, 384);
      var2.angles = (6, 265, 0);
    }

    return;
  }
}

function should_run_event(var0) {
  return false;
}

function setup_map_specific_devgui() {}

function interaction_trigger_properties(var0, var1, var2) {
  switch (var1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var1.useduration)) {
        self.interaction_trigger setuseholdduration(var1.useduration);
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

function register_create_script_arrays(var0, var1, var2, var3) {
  if(isDefined(var0)) {
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var0;
  }

  if(isDefined(var1)) {
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var1;
  }

  if(isDefined(var2)) {
    level.create_script_file_ids[var0] = "cs" + var2;
  }

  if(isDefined(var3)) {
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var3;
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
  var0 = ["assault1_volume", "assault2_volume", "assault2_volume2", "assault2_volume3", "assault2_volume4", "assault2_volume5", "assault3_volume1", "assault3_volume2", "assault3_volume3", "assault3_volume4"];

  foreach(var2 in var0) {
    level.initnonbunkerdoors[level.initnonbunkerdoors.size] = getEnt(var2, "targetname");
  }

  var0 = ["ally_riverbed_volume", "assault1_volume", "assault2_volume", "assault2_volume2", "assault2_volume3", "assault2_volume4", "assault3_volume1", "assault3_volume1", "assault3_volume2", "assault3_volume3"];

  foreach(var2 in var0) {
    level.initnonbunkerdoorkeypad[level.initnonbunkerdoorkeypad.size] = getEnt(var2, "targetname");
  }
}

function ref_131fe(var0, var1, var2, var3) {
  if(isDefined(var0)) {
    level.initlocs_keypads = scripts\engine\utility::getStructArray(var0, "targetname");
  }

  if(isDefined(var1)) {
    level.initoperationcratedata = var1;
  }

  if(isDefined(var2)) {
    level.ref_135d2["current"] = level.ref_135d2[var2];
  }

  if(isDefined(var3)) {
    level.ref_11b4c = var3;
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
  var0 = scripts\engine\utility::getStructArray("assault2_intro_spawner", "targetname");
  thread ref_135db(var0, 2);
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
  var0 = scripts\engine\utility::getStructArray("assault3_initial_hangar_spawner", "targetname");
  var1 = ref_135db(var0, 3);
  ref_135d6();
  scripts\engine\utility::flag_wait("assault3_fallback4");
  ref_131fe("assault3_back_spawner", 9, undefined, 1);
  scripts\engine\utility::flag_set("start_vindia_scene");
  wait 2;
  thread spawn_group("bomber", "alq_bomber_assault3", 0, undefined, undefined, undefined, 6);
  scripts\engine\utility::flag_wait("assault3_fallback5");
  var0 = scripts\engine\utility::getStructArray("assault3_hangar_spawner", "targetname");
  var1 = ref_135db(var0, 2);
  scripts\engine\utility::flag_wait("assault3_at_hangar");
  ref_131fe("assault3_outside_spawner", 9, undefined, 1);
  var0 = scripts\engine\utility::getStructArray("assault3_bunker_spawner", "targetname");

  foreach(var3 in var0) {
    var4 = getnode(var3.target, "targetname");
    var5 = var3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var5.fixednode = 1;
    var5.matchdata_logchallenge = 1;
    var5 setgoalnode(var4);
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
  var0 = getEnt("assault3_volume5", "targetname");
  var1 = scripts\engine\utility::getStructArray("finale_spawner", "targetname");
  var2 = var1.size;

  if(level.players.size == 2) {
    var2 = 8;
  }

  for(var3 = 0; var3 < var2; var3++) {
    var4 = var1[var3] scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var4 setgoalvolumeauto(var0);
    thread ref_13093(var4);
    wait 0.2;
  }
}

function ref_135d6() {
  var0 = scripts\engine\utility::getStructArray("alq_sniper_assault3", "targetname");

  foreach(var2 in var0) {
    var3 = scripts\engine\utility::getStruct(var2.target, "targetname");
    var4 = getnode(var3.target, "targetname");
    var5 = var2 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    thread nvidiaansel_scriptdisable(var5);
    thread ref_13439();
    var5 forceteleport(var3.origin, var3.angles);
    wait 0.1;
    var5 setgoalnode(var4);
    var5.goalradius = 32;
    var5.fixednode = 1;
  }
}

function nvidiaansel_scriptdisable(var0) {
  self endon("death");
  scripts\engine\utility::flag_wait("assault3_at_hangar");
  wait randomfloatrange(0, 1.5);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.fixednode = 0;
  self.goalradius = 32;
  wait 0.05;
  self setgoalpos(var0.origin);
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
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    if(!isDefined(var2.matchdata_logchallenge)) {
      var2 setgoalvolumeauto(level.initnonbunkerdoors[level.initoperationcratedata]);
    }
  }

  var4 = getaiarray("allies");

  foreach(var6 in var4) {
    var6 setgoalvolumeauto(level.initnonbunkerdoorkeypad[level.initoperationcratedata]);
  }

  level.player_has_grenade_crate = 1;
}

function thermitestuckto() {
  scripts\engine\utility::delaythread(3.7, &ref_12759, "dx_mpb_ukft1_ping_plunder_vendor", "start_mission");
  scripts\engine\utility::delaythread(15, &ref_12759, "dx_mpa_uktl_gamestate_timesup_thirty", "start_mission");
  scripts\engine\utility::delaythread(35, &ref_12759, "dx_mpa_uktl_hp_move_soon", "start_mission");
  var0 = 45;
  scripts\engine\utility::flag_wait_or_timeout("start_mission", var0);
  scripts\engine\utility::flag_set("start_mission");
}

function ref_137c4() {
  var0 = getEnt("intro_truck_alpha", "targetname");
  level.trial_spawn_wait = var0 scripts\common\utility::spawn_vehicle();
  level.trial_spawn_wait.script_keepdriver = 1;
  thread trial_rpg_init();
  var1 = getEnt("intro_truck_alpha_clip", "targetname");
  var1.angles += (3, 1, -1);
  var1.origin += (-3, -4, -10);
  var1 linkTo(level.trial_spawn_wait);
  wait 0.2;
  level.trial_spawn_wait notsolid();
  thread scripts\common\vehicle_paths::gopath(level.trial_spawn_wait);
  wait 1;
  level.trial_spawn_wait setwaitspeed(0);
  level.trial_spawn_wait scripts\engine\utility::waittill_notify_or_timeout("reached_wait_speed", 7.5);
  scripts\engine\utility::flag_set("infil_complete");
  level.trial_spawn_wait scripts\engine\utility::delaycall(3, &vehicle_turnengineoff);
  wait 3;
  var0 = scripts\engine\utility::getStruct("umike_driver", "targetname");
  var2 = var0 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
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

  var0 = ["tag_seat_2", "tag_seat_4", "tag_seat_7", "tag_seat_5"];
  var1 = [(-23, -10, 7), (-23, -20, 7), (-23, -17, 7), (-23, -10, 7)];
  var2 = [40, 50, 50, 40];
  var3 = [50, 40, 40, 50];

  if(!isDefined(level.trial_spawn_wait.ref_13a26)) {
    level.trial_spawn_wait.ref_13a26 = [];
  }

  var4 = undefined;
  self.animname = undefined;
  var5 = undefined;

  foreach(var7 in var0) {
    if(!isDefined(level.trial_spawn_wait.ref_13a26[var7])) {
      level.trial_spawn_wait.ref_13a26[var7] = 1;
      var4 = var7;
      var5 = var8;
      self.animname = "slot_" + var8;
      break;
    }
  }

  var9 = var1[var5];
  var10 = var2[var5];
  var11 = var3[var5];
  var12 = scripts\cp\laser_traps\cp_laser_traps::ref_124e9(self, "slot_" + var5);
  var12 linkTo(level.trial_spawn_wait, var4, var9, (0, 0, 0));
  self allowstand(0);
  self allowprone(0);
  self setstance("crouch");
  wait 0.05;
  self playerlinktodelta(var12, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
  self lerpviewangleclamp(1, 0.25, 0.25, var10, var11, 80, 80);

  while(!scripts\engine\utility::flag("infil_complete")) {
    var12 scripts\cp\cp_anim::anim_player_solo(self, var12, "infil_ride_idle");
  }

  var12 scripts\cp\cp_anim::anim_player_solo(self, var12, "infil_ride_exit");
  self unlink();
  var12 delete();
  self allowstand(1);
  self allowprone(1);
  self setstance("stand", 0, 1, 1);
}

function init_tripwires() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  wait 3;
  scripts\cp_mp\tripwire::init();
  level.tripwires.ref_11cd1 = getEntArray("tripwire_mon_clip", "targetname");

  foreach(var1 in level.tripwires.tripwires) {
    thread last_say_times();
  }
}

function last_say_times() {
  self waittill("trigger");

  if(isDefined(self.targets) && self.targets.size == 1) {
    var0 = scripts\engine\utility::getclosest(self.origin, level.tripwires.ref_11cd1);
    level.tripwires.ref_11cd1 = scripts\engine\utility::array_remove(level.tripwires.ref_11cd1, var0);

    if(isDefined(var0)) {
      var0 delete();
      return;
    }

    return;
  }
}

function current_carrier_time() {
  level.playerexitsafeareamessage = [];
  var0 = getEntArray("bombs", "script_noteworthy");

  foreach(var2 in var0) {
    if(var2.targetname == "bomb01") {
      level.playerexitsafeareamessage[0] = var2;
    } else if(var2.targetname == "bomb02") {
      level.playerexitsafeareamessage[1] = var2;
    } else if(var2.targetname == "bomb03") {
      level.playerexitsafeareamessage[2] = var2;
    } else if(var2.targetname == "bomb04") {
      level.playerexitsafeareamessage[3] = var2;
    } else if(var2.targetname == "bomb05") {
      level.playerexitsafeareamessage[4] = var2;
    }

    var2 hide();
    var2.ref_1405c = scripts\engine\utility::getStruct(var2.target, "targetname");

    if(var2.targetname != "bomb04") {
      thread crankedprogressuiupdater(var2, &cqb_laser_guy_internal, &"MP/BOMB_SITE", undefined);
    }
  }
}

function crankedprogressuiupdater(var0, var1, var2, var3) {
  var4 = spawn("script_model", self.ref_1405c.origin);

  if(isDefined(self.ref_1405c.angles)) {
    var4.angles = self.ref_1405c.angles;
  } else {
    var4.angles = (0, 0, 0);
  }

  var4.ref_11c6d = self;

  if(isDefined(var2)) {
    var4.headicon = thread scripts\cp\utility::ent_createheadicon(var4, 15, "allies", var2, 1);
    setheadiconsnaptoedges(var4.headicon, 1500);
    setheadiconmaxdistance(var4.headicon, 15);
  }

  var4 setCursorHint("HINT_BUTTON");
  var4 sethintdisplayrange(200);
  var4 sethintdisplayfov(45);
  var4 setuserange(100);
  var4 setusefov(40);
  var4 sethintonobstruction("show");
  var4 setuseholdduration("duration_medium");
  var4 sethintrequiresholding(1);
  var4 makeusable();

  if(isDefined(var1)) {
    var4 setHintString(var1);
  }

  var4.valve_steam_on = 0;
  thread ref_12f50(var4, var0, var3);
  return var4;
}

function cqb_laser_guy_internal(var0, var1) {
  var0.ref_11c6d show();
  var0.valve_steam_on = 1;
  scripts\engine\utility::flag_set(var0.ref_11c6d.targetname + "_planted");
  playsoundatpos(var0.ref_11c6d.origin, "MP_bomb_plant");
  wait 0.2;
  var1 playsoundtoteam("dx_mpb_ukft1_objectives_inform_device_set", "allies");

  if(!scripts\engine\utility::flag("bomb03_planted")) {
    thread ref_1350d(var1);
  }

  wait 1.5;
  thread ref_12758("dx_mpa_uktl_bomb_planted");
}

function ref_1350d(var0) {
  var1 = scripts\engine\utility::getStructArray("assault2_back_spawner_special", "targetname");
  var2 = scripts\engine\utility::getStructArray("alq_bomber", "targetname");
  var3 = 2;
  var4 = undefined;

  if(level.players.size <= 1) {
    var3 = 1;
  }

  for(var5 = 0; var5 < var3; var5++) {
    var2[var5].origin = var1[var5].origin;

    if(isDefined(var1[var5].angles)) {
      var2[var5].angles = var1[var5].angles;
    }

    var4 = var2[var5] scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    var4 getenemyinfo(var0);
  }

  wait 2;
  thread ref_12420(var4, "dx_mpp_ukft1_ping_enemy_bomber");
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
  var0 = scripts\engine\utility::getStruct("obj_gear_up", "targetname");
  var1 = scripts\cp\cp_objectives::requestworldid("obj_start", 1);
  level.inittutzones = var1;
  objective_setplayoutro(var1, 1);
  objective_setplayintro(var1, 1);
  objective_setminimapiconsize(var1, "icon_regular");
  objective_state(var1, "current");
  objective_position(var1, var0.origin);
  objective_setdescription(var1, &"CP_SO_FINALE/FINALE_OBJ_START");
  objective_icon(var1, "icon_waypoint_objective_general");
  objective_unpinforteam(var1, "allies");
  objective_setshowdistance(var1, 1);
  objective_setbackground(var1, 0);
  objective_setshowoncompass(var1, 1);
  objective_setpulsate(var1, 1);
}

function ref_11f6c() {
  scripts\engine\utility::flag_wait("start_mission");
  scripts\cp\cp_objectives::freeworldid("obj_start");
  objective_state(level.inittutzones, "done");
  setomnvar("cp_objective_sub_1_index", 3);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_SO_FINALE/FINALE_OBJ1", "allies", 4);
  var0 = scripts\engine\utility::getStruct("obj2_fob_mid", "targetname");
  var1 = scripts\cp\cp_objectives::requestworldid("obj1_gate1", 1);
  level.inittutzones = var1;
  objective_setplayoutro(var1, 1);
  objective_setplayintro(var1, 1);
  objective_state(var1, "current");
  objective_position(var1, var0.origin);
  objective_setdescription(var1, &"CP_SO_FINALE/FINALE_OBJ1");
  objective_icon(var1, "icon_waypoint_objective_general");
  objective_unpinforteam(var1, "allies");
  objective_setshowdistance(var1, 1);
  objective_setbackground(var1, 0);
  objective_setshowoncompass(var1, 1);
  objective_setpulsate(var1, 1);
}

function ref_11f5b() {
  thread ref_11f60();
  scripts\engine\utility::flag_wait("assault1_over");
  scripts\cp\cp_objectives::freeworldid("obj1_gate1");
  objective_state(level.inittutzones, "done");
  setomnvar("cp_objective_sub_1_index", 4);
  var0 = scripts\engine\utility::getStruct("obj2_fob_mid", "targetname");
  var1 = (0, 0, 5);
  var2 = scripts\cp\cp_objectives::requestworldid("obj2_mid", 1);
  level.inittutzones = var2;
  objective_setplayoutro(var2, 1);
  objective_setplayintro(var2, 1);
  objective_state(var2, "current");
  objective_position(var2, level.playerexitsafeareamessage[0].origin + var1);
  objective_setdescription(var2, &"MATCH_STATUS_HINT/PLANT_BOMBS");
  objective_unpinforteam(var2, "allies");
  objective_setshowdistance(var2, 1);
  objective_setbackground(var2, 0);
  objective_setshowoncompass(var2, 1);
  objective_setpulsate(var2, 1);
  objective_setlabel(var2, &"CP_SO_FINALE/PLANT_BOMBS_ALT1");
  objective_icon(var2, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_wait("bomb01_planted");
  objective_position(var2, level.playerexitsafeareamessage[1].origin + var1);
  scripts\engine\utility::flag_wait("bomb02_planted");
  objective_position(var2, level.playerexitsafeareamessage[2].origin + var1);
  scripts\engine\utility::flag_wait("bomb03_planted");
  thread ref_11d85();
}

function ref_11d85() {
  var0 = getEnt("gate_model", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var2 = getEntArray("gate_clip", "targetname");
  var3 = getEnt("gate_clip_delete", "targetname");
  wait 0.2;
  thread ref_1355d();
  var0 moveTo(var1.origin, 3);
  wait 1;
  var3 notsolid();
}

function ref_1355d() {
  var0 = scripts\engine\utility::getStructArray("assault2_gate_guard", "targetname");

  foreach(var2 in var0) {
    var3 = getnode(var2.target, "targetname");
    var4 = var2 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var4.ref_13fba = "assault3_start";
    thread ref_13092(var4);
    wait 0.2;
  }
}

function ref_11f60() {
  scripts\engine\utility::flag_wait("heli_assault2_spawned");

  for(var0 = 0; var0 < level.solution_exists_already.size; var0++) {
    var1 = level.solution_exists_already[var0];
    var2 = "fob_heli_icon" + var0;
    var1.objindex = scripts\cp\cp_objectives::requestworldid(var2, 2);
    objective_setplayintro(var1.objindex, 0);
    objective_setplayoutro(var1.objindex, 0);
    objective_setownerteam(var1.objindex, "axis");
    objective_state(var1.objindex, "active");
    objective_icon(var1.objindex, "icon_minimap_littlebird");
    objective_setlocation(var1.objindex, 0, var1);
    thread laser_sights(var1, var1.objindex);
  }
}

function ref_11f5c() {
  scripts\engine\utility::flag_wait("all_fob_juggernauts_spawned_in");

  for(var0 = 0; var0 < level.ref_11bd9.size; var0++) {
    var1 = level.ref_11bd9[var0];
    var2 = "fob_jugg_icon" + var0;
    var1.objindex = scripts\cp\cp_objectives::requestworldid(var2, 2);
    objective_setplayintro(var1.objindex, 0);
    objective_setplayoutro(var1.objindex, 0);
    objective_setownerteam(var1.objindex, "axis");
    objective_state(var1.objindex, "active");
    objective_icon(var1.objindex, "icon_minimap_juggernaut");
    objective_setminimapiconsize(var1.objindex, "icon_regular");
    objective_setlocation(var1.objindex, 0, var1);
    thread laser_sights(var1, var1.objindex);
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
  var0 = scripts\engine\utility::getStruct("obj5_reach_hangar", "targetname");
  var1 = scripts\cp\cp_objectives::requestworldid("obj5_reach_hangar", 1);
  level.inittutzones = var1;
  objective_setplayoutro(var1, 1);
  objective_setplayintro(var1, 1);
  objective_state(var1, "current");
  objective_position(var1, var0.origin);
  objective_setdescription(var1, &"CP_SO_FINALE/FINALE_OBJ_TARMAC");
  objective_setlabel(var1, "");
  objective_icon(var1, "icon_waypoint_objective_general");
  objective_unpinforteam(var1, "allies");
  objective_setshowdistance(var1, 1);
  objective_setbackground(var1, 0);
  objective_setshowoncompass(var1, 1);
  objective_setpulsate(var1, 1);
  thread ref_11f61();
}

function ref_11f61() {
  scripts\engine\utility::flag_wait("heli_assault3_fob_spawned");

  for(var0 = 0; var0 < level.sort_goal_positions_by_priority.size; var0++) {
    var1 = level.sort_goal_positions_by_priority[var0];
    var2 = "fob2_heli_icon" + var0;
    var1.objindex = scripts\cp\cp_objectives::requestworldid(var2, 2);
    objective_setplayintro(var1.objindex, 0);
    objective_setplayoutro(var1.objindex, 0);
    objective_setownerteam(var1.objindex, "axis");
    objective_state(var1.objindex, "active");
    objective_icon(var1.objindex, "icon_minimap_littlebird");
    objective_setlocation(var1.objindex, var0, var1);
    thread laser_sights(var1, var1.objindex);
  }
}

function ref_11f5e() {
  scripts\engine\utility::flag_wait("players_at_hangar");
  thread ref_11f7b();
  scripts\cp\cp_objectives::freeworldid("obj5_reach_hangar");
  objective_state(level.inittutzones, "done");
  setomnvar("cp_objective_sub_1_index", 4);
  var0 = (0, 0, 5);
  var1 = scripts\cp\cp_objectives::requestworldid("obj2_mid", 1);
  level.inittutzones = var1;
  objective_setplayoutro(var1, 1);
  objective_setplayintro(var1, 1);
  objective_state(var1, "current");
  objective_position(var1, level.playerexitsafeareamessage[4].origin + var0);
  objective_setdescription(var1, &"MATCH_STATUS_HINT/PLANT_BOMBS");
  objective_unpinforteam(var1, "allies");
  objective_setshowdistance(var1, 1);
  objective_setbackground(var1, 0);
  objective_setshowoncompass(var1, 1);
  objective_setpulsate(var1, 1);
  objective_setlabel(var1, &"CP_SO_FINALE/PLANT_BOMBS_ALT1");
  objective_icon(var1, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_wait("bomb05_planted");
}

function ref_11f7b() {
  scripts\engine\utility::flag_wait("all_vindias_spawned_in");

  for(var0 = 0; var0 < level.ref_142b4.size; var0++) {
    var1 = level.ref_142b4[var0];
    var2 = "hangar_vindia_icon" + var0;
    var1.objindex = scripts\cp\cp_objectives::requestworldid(var2, 2);
    objective_setplayintro(var1.objindex, 0);
    objective_setplayoutro(var1.objindex, 0);
    objective_setownerteam(var1.objindex, "axis");
    objective_state(var1.objindex, "active");
    objective_icon(var1.objindex, "icon_minimap_technical");
    objective_setlocation(var1.objindex, var0, var1);
    thread laser_sights(var1, var1.objindex);
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

  for(var0 = 0; var0 < level.ref_11bd9.size; var0++) {
    var1 = level.ref_11bd9[var0];
    var2 = "hangar_jugg_icon" + var0;
    var1.objindex = scripts\cp\cp_objectives::requestworldid(var2, 2);
    objective_setplayintro(var1.objindex, 0);
    objective_setplayoutro(var1.objindex, 0);
    objective_setownerteam(var1.objindex, "axis");
    objective_state(var1.objindex, "active");
    objective_icon(var1.objindex, "icon_minimap_juggernaut");
    objective_setminimapiconsize(var1.objindex, "icon_regular");
    objective_setlocation(var1.objindex, 0, var1);
    thread laser_sights(var1, var1.objindex);
  }
}

function ref_11f59() {
  scripts\cp\cp_objectives::freeworldid("obj2_mid");
  objective_state(level.inittutzones, "done");
  setomnvar("cp_objective_sub_1_index", 9);
  var0 = scripts\engine\utility::getStruct("obj7_clear_hangar", "targetname");
  var1 = scripts\cp\cp_objectives::requestworldid("obj7_cleanup", 1);
  level.inittutzones = var1;
  objective_setplayoutro(var1, 1);
  objective_setplayintro(var1, 1);
  objective_state(var1, "current");
  objective_setdescription(var1, &"CP_SO_FINALE/FINALE_OBJ4");
  objective_icon(var1, "icon_waypoint_objective_general");
  objective_unpinforteam(var1, "allies");
  objective_setshowdistance(var1, 1);
  objective_setbackground(var1, 0);
  objective_setshowoncompass(var1, 1);
  objective_setpulsate(var1, 1);
  scripts\engine\utility::flag_clear("enemy_spawning_active");
  var2 = getaiarray("axis");
  var3 = 1;
  var4 = 1;
  scripts\engine\utility::flag_wait("all_enemies_spawned_in");

  for(;;) {
    var2 = getaiarray("axis");

    if(var4 && var2.size > 0) {
      scripts\engine\utility::delaythread(1, &ref_12758, "dx_mpa_uktl_exfillosing_start_winningteam");
      var4 = 0;
    }

    if(var3 && var2.size < 8) {
      foreach(var6 in var2) {
        thread ref_131f5(var6);
      }

      var3 = 0;
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

function ref_131f5(var0) {
  var1 = scripts\cp\cp_objectives::requestworldid("enemy_icon", 3);
  self.objindex = var1;
  objective_setplayintro(var1, 0);
  objective_setplayoutro(var1, 0);
  objective_setownerteam(var1, "axis");
  objective_state(var1, "active");
  objective_icon(var1, "icon_waypoint_objective_general");
  objective_setminimapiconsize(var1, "icon_regular");
  thread laser_start_ent_thermal(var1);
  self endon("death");
  objective_onentity(var1, self);
  objective_setlocation(var1, 0, self);
  objective_setzoffset(var1, 75);
}

function laser_fx(var0) {
  self waittill("death");

  if(isDefined(var0)) {
    setheadiconimage(var0);
    return;
  }
}

function laser_sights(var0, var1) {
  self waittill("death");
  scripts\cp\cp_objectives::freeworldid(var1);
  objective_state(var0, "done");
}

function laser_start_ent_thermal(var0, var1) {
  if(isalive(self)) {
    self waittill("death");
  }

  scripts\cp\cp_objectives::freeworldid(var1);
  objective_state(var0, "done");
}

function brleaderdialogteamexcludeplayer() {
  level.thermiteboltradiusdamage = [];
  wait 1;
  var0 = scripts\engine\utility::getStructArray("initial_ally_spawner", "targetname");

  foreach(var2 in var0) {
    var3 = var2 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    thread ref_12808(var3);
    level.thermiteboltradiusdamage[level.thermiteboltradiusdamage.size] = var3;
    waitframe();
  }

  scripts\engine\utility::flag_wait("start_mission");
  level.brinfilsmokesuffix = scripts\engine\utility::getStructArray("initial_ally_respawn", "targetname");

  for(;;) {
    var0 = getaiarray("allies");
    var5 = level.brinfilsmokesuffix[randomint(level.brinfilsmokesuffix.size)];
    var6 = 4;

    if(level.players.size >= 3) {
      var6 = 2;
    }

    if(var0.size < var6) {
      var3 = var5 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      var3 setgoalvolumeauto(level.initnonbunkerdoorkeypad[level.initoperationcratedata]);
    }

    wait 0.2;
  }
}

function ref_12808(var0) {
  self endon("death");
  var1 = getnode(var0.target, "targetname");
  self setgoalnode(var1);
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

function brleaderdialogplayer(var0) {
  wait randomfloatrange(0.5, 1);
  self playSound(var0);
}

function brloadoutcratedestroycallback() {
  var0 = scripts\engine\utility::getStructArray("ally_rescue1", "targetname");
  var1 = scripts\engine\utility::getStruct("ally_rescue1_struct", "targetname");
  var2 = scripts\engine\utility::getStructArray("ally_rescue2", "targetname");
  var3 = scripts\engine\utility::getStruct("ally_rescue2_struct", "targetname");
  var4 = scripts\engine\utility::getStructArray("ally_rescue3", "targetname");
  var5 = scripts\engine\utility::getStruct("ally_rescue3_struct", "targetname");
  var6 = scripts\engine\utility::getStructArray("ally_rescue4", "targetname");
  var7 = scripts\engine\utility::getStruct("ally_rescue4_struct", "targetname");
  var8 = scripts\engine\utility::array_combine(var0, var2, var4, var6);

  foreach(var10 in var8) {
    var11 = var10 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    thread ref_1280b(var11);
  }

  thread ref_143da(var1);
  thread ref_143da(var3);
  thread ref_143da(var5);
  thread ref_143da(var7);
}

function ref_1280b(var0) {
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  var1 = getnode(var0.target, "targetname");
  self setgoalnode(var1);
  scripts\common\ai::gun_remove();
  self waittill("ally_rescued");
  scripts\common\ai::gun_recall();
  self.ignoreme = 0;
  self.ignoreall = 0;
  self setgoalpos(self.origin);
  waitframe();
  self setgoalvolumeauto(level.initialize_create_script);
}

function ref_143da(var0) {
  for(;;) {
    var1 = scripts\cp\utility::getplayersinradius(self.origin, self.radius);

    if(var1.size > 0) {
      foreach(var3 in var0) {
        if(isalive(var3)) {
          var3 notify("ally_rescued");
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
  var0 = 0;
  thread laps_data();

  for(;;) {
    if(!scripts\engine\utility::flag("enemy_spawning_active")) {
      scripts\engine\utility::flag_wait("enemy_spawning_active");
    }

    if(isDefined(level.players)) {
      var0 = level.players.size - 1;
    }

    var1 = level.ref_135d2["current"][var0];
    var2 = level.ref_135d2["wave_min"][var0];
    var3 = var1 + 4;
    var4 = gettime() + level.ref_135d2["round_time"][var0] * 1000;

    for(;;) {
      if(level.player_has_grenade_crate) {
        level.player_has_grenade_crate = 0;
        break;
      } else if(spawned_enemies() <= var2) {
        var5 = gettime() + level.ref_135d2["wave_min_time"][var0] * 1000;

        for(;;) {
          if(level.player_has_grenade_crate) {
            level.player_has_grenade_crate = 0;
            break;
          } else if(gettime() >= var5 || gettime() >= var4) {
            break;
          }

          wait 0.2;
        }

        break;
      } else if(gettime() >= var4) {
        break;
      }

      wait 0.2;
    }

    while(isDefined(level.ref_11b4c) && level.ref_11b4c <= 0) {
      wait 0.2;
    }

    for(var6 = 0; var6 < var1; var6++) {
      var7 = getaiarray("axis");

      if(spawned_enemies() <= var3 && var7.size <= 30) {
        var8 = ref_12dac();
        var9 = var8 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
        level.ref_12c8a[level.ref_12c8a.size] = var9;
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
  var0 = scripts\engine\utility::getStruct("obj7_clear_hangar", "targetname");

  for(;;) {
    var1 = getaiarray("axis");

    if(var1.size > 30) {
      var2 = prohibited_weapon_list(var0);

      if(isDefined(var2)) {
        laser_end_pos(var2);
      } else {
        wait 0.5;
      }

      continue;
    }

    wait 0.5;
  }
}

function laser_end_pos(var0) {
  var1 = sortbydistance(level.ref_12c8a, var0.origin);
  var2 = var1.size - 1;

  for(var3 = var2; var3 >= 0; var3--) {
    if(isDefined(var1[var3]) && isalive(var1[var3])) {
      var1[var3] kill();
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

  var0 = level.initlocs_keypads[level.ref_1364d];
  level.ref_1364d++;
  return var0;
}

function postspawn_axis() {
  self endon("death");
  waitframe();
  self setgoalvolumeauto(level.initnonbunkerdoors[level.initoperationcratedata]);
  var0 = scripts\engine\utility::getclosest(self.origin, level.players);
  self getenemyinfo(var0);
}

function ref_13506() {
  var0 = scripts\engine\utility::getStructArray("assault2_extras", "targetname");

  foreach(var2 in var0) {
    var3 = getnode(var2.target, "targetname");
    var4 = var2 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var4.ref_13fba = "fallback_3";
    thread ref_13092(var4, var3);
    wait 0.2;
  }
}

function ref_13092(var0, var1) {
  self endon("death");
  self.matchdata_logchallenge = 1;

  if(isDefined(var1) && var1) {
    teleport_ai_to_cover_node(var0);
  }

  for(var2 = 0; var2 <= 10; var2++) {
    self.goalradius = 4;
    self.fixednode = 1;
    self setgoalnode(var0);
    wait 0.1;
  }

  if(isDefined(self.ref_13fba)) {
    scripts\engine\utility::flag_wait(self.ref_13fba);
    self.matchdata_logchallenge = undefined;
    return;
  }
}

function ref_13093(var0) {
  self endon("death");

  if(isDefined(var0.target)) {
    var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
    var2 = getnode(var0.target, "targetname");

    for(var3 = 0; var3 <= 10; var3++) {
      self.goalradius = 64;

      if(isDefined(var1)) {
        self setgoalpos(var1.origin);
      } else {
        self setgoalnode(var2);
      }

      wait 0.1;
    }

    return;
  }
}

function ref_135db(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < var1; var3++) {
    foreach(var5 in var0) {
      var6 = var5 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      var2 = var6;
      wait 0.1;
    }

    wait 1;
  }

  return var2;
}

function spawn_group(var0, var1, var2, var3, var4, var5, var6) {
  var7 = scripts\engine\utility::getStructArray(var1, "targetname");
  var8 = undefined;

  foreach(var10 in var7) {
    var11 = var10 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);

    switch (var0) {
      case "sniper":
        thread ref_1280d(var11, var10, var2);
        break;
      case "rpg":
        thread ref_1280c(var11, var10, var2);
        var8 = var11;
        break;
      case "bomber":
        thread ref_12807(var11);
        break;
    }

    if(isDefined(var4)) {
      thread ref_12c88(var11, var0, var10, var2, var4, var5);
    }

    wait 0.1;
  }

  if(isDefined(var0) && var0 == "bomber" && isDefined(var8) && isalive(var8)) {
    scripts\engine\utility::delaythread(2, &ref_12420, var8, "dx_mpp_ukft1_ping_enemy_bomber");
    return;
  }
}

function ref_12c88(var0, var1, var2, var3, var4, var5) {
  self waittill("death");

  if(isDefined(var5)) {
    wait var5;
  } else {
    wait randomfloatrange(7, 10);
  }

  if(scripts\engine\utility::flag(var3)) {
    return;
  }

  switch (var0) {
    case "sniper":
      var6 = var1 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      thread ref_1280d(var6, var1);

      if(isDefined(var3)) {
        var7 = var4 - 1;

        if(var7 > 0) {
          thread ref_12c88(var6, "sniper", var1, var2, var3, var7);
        }
      }

      break;
    case "rpg":
      var6 = var1 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      thread ref_1280c(var6, var1);

      if(isDefined(var3)) {
        var7 = var4 - 1;

        if(var7 > 0) {
          thread ref_12c88(var6, "rpg", var1, var2, var3, var7);
        }
      }

      break;
  }
}

function ref_1280c(var0, var1, var2) {
  self endon("death");
  thread ref_12dc4(var2);

  if(!istrue(var1)) {
    self.matchdata_logchallenge = 1;
  }

  wait 0.2;
  var3 = getnode(var0.target, "targetname");

  if(scripts\engine\utility::flag("fallback_1")) {
    teleport_ai_to_cover_node(var3);
  }

  self setgoalnode(var3);
  self.goalradius = 4;
  self.fixednode = 1;
  wait 0.5;
  self.goalradius = 4;
}

function ref_12dc4(var0) {
  jumpiffalse(isDefined(var0)) LOC_0000000b;
  level endon(var0);
  self waittill("death", var1);

  if(level.ref_123da && isDefined(var1) && isPlayer(var1)) {
    ref_123db(var1, "dx_cbc_usm2_inform_killfirm_rpg");
    return;
  }
}

function ref_123db(var0, var1) {
  level.ref_123da = 0;

  if(isalive(var0)) {
    var0 playsoundtoteam(var1, "allies");
  }

  wait 4;
  level.ref_123da = 1;
}

function ref_1280d(var0, var1, var2) {
  self endon("death");
  thread ref_13439(var2);

  if(!istrue(var1)) {
    self.matchdata_logchallenge = 1;
  }

  wait 0.2;
  var3 = getnode(var0.target, "targetname");

  if(scripts\engine\utility::flag("fallback_1")) {
    teleport_ai_to_cover_node(var3);
  }

  self setgoalnode(var3);
  self.goalradius = 4;
  self.fixednode = 1;
  wait 0.5;
  self.goalradius = 4;
}

function ref_13439(var0) {
  jumpiffalse(isDefined(var0)) LOC_0000000b;
  level endon(var0);
  self waittill("death", var1);

  if(level.ref_123da && isDefined(var1) && isPlayer(var1)) {
    ref_123db(var1, "dx_mpb_ukft1_combat_killfirm_sniper");
    return;
  }
}

function ref_12807(var0) {
  self endon("death");
  thread create_opaque_ai_contents();
}

function create_opaque_ai_contents() {
  self waittill("death", var0);

  if(level.ref_123da && isDefined(var0) && isPlayer(var0)) {
    ref_123db(var0, "dx_mpb_ukft1_combat_killfirm_bomber");
    return;
  }
}

function ref_13574() {
  scripts\engine\utility::flag_wait_any("bomb02_planted", "fallback_3");
  thread ref_13578("assault2_juggernaut_spawner", "fob_juggernauts_spawned_in", "all_fob_juggernauts_spawned_in");
  thread ref_11f5c();
}

function ref_13578(var0, var1, var2) {
  var3 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var7, var5 in level.players) {
    if(var7 == 3) {
      continue;
    }

    var6 = var3[var7] scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    thread ref_12809(var6);
    thread vehicle_mp_deletenextframe(var6);
    level.ref_11bd9[level.ref_11bd9.size] = var6;

    if(!scripts\engine\utility::flag(var1)) {
      scripts\engine\utility::flag_set(var1);
      scripts\engine\utility::flag_clear("enemy_spawning_active");
      thread check_player_used_tacmap();
    }

    wait 1;
  }

  scripts\engine\utility::flag_set(var2);
}

function ref_13579(var0, var1, var2) {
  var3 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var7, var5 in level.players) {
    if(var7 >= 2) {
      continue;
    }

    var6 = var3[var7] scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    thread ref_12809(var6);
    thread vehicle_mp_deletenextframe(var6);
    level.ref_11bd9[level.ref_11bd9.size] = var6;

    if(!scripts\engine\utility::flag(var1)) {
      scripts\engine\utility::flag_set(var1);
      setmusicstate("cp_juggernaut_intro");
      thread check_player_used_tacmap();
    }

    wait 1;
  }

  scripts\engine\utility::flag_set(var2);
}

function check_player_used_tacmap() {
  wait 3;

  if(isalive(self)) {
    thread ref_12420(self, "dx_mpb_ukft1_ping_killstreaks_juggernaut_o");
  }

  wait 2.5;
  ref_12758("dx_mpa_uktl_juggernaut_enemy_use");
}

function ref_12809(var0) {
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

  var0 = scripts\cp\utility::getbaseweaponname(self.damageweapon);

  if(var0 == "iw8_sn_alpha50" || var0 == "iw8_sh_oscar12") {
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

function vehicle_mp_deletenextframe(var0) {
  self waittill("death", var1, var2, var3, var4);
  var5 = self.origin;
  var6 = self.angles;
  level.ref_11bd9 = scripts\engine\utility::array_remove(level.ref_11bd9, self);

  if(!scripts\engine\utility::flag("first_jugg_dead")) {
    scripts\engine\utility::flag_set("first_jugg_dead");
    thread check_missiles_reloaded_vo();
    thread minecart(var5, var6);
    return;
  }
}

function check_missiles_reloaded_vo() {
  level endon("assault_finished_in_victory");
  wait 3.5;
  ref_12758("dx_mpa_uktl_boost_rugby");
}

function vehicle_damage_registerdefaultstates(var0) {
  if(level.ref_11bd9.size <= var0) {
    return true;
  }

  return false;
}

function minecart(var0, var1) {
  var2 = ref_12f4f(var0, var1, &script_model_pilot_kill_watch, "offhand_wm_supportbox", &"KILLSTREAKS_HINTS/JUGG_CRATE_PICKUP", "hud_icon_killstreak_juggernaut", &vehicle_occupancy_cp_takeriotshield, 1);
}

function script_model_pilot_kill_watch(var0, var1) {
  var2 = scripts\cp\loot_system::get_empty_munition_slot(var1);

  if(isDefined(var2)) {
    var1.vehicle_occupancy_cp_handlesuicidefromvehicles = "juggernaut";
    scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var1, "juggernaut");
    var0.valve_steam_on = 1;
    return;
  }

  var1 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
}

function vehicle_occupancy_cp_takeriotshield(var0) {
  var0 endon("entitydeleted");
  thread ref_13f92(var0, "juggernaut");
}

function display_ai() {
  var0 = (1, 1, 0);
  var1 = (0, 1, 0);
  var2 = (1, 0, 0);
  var3 = ["axis", "allies", "total"];

  for(;;) {
    var4 = 30;

    foreach(var6 in var3) {
      if(var6 == "total") {
        var7 = getaiarray().size;
      } else {
        var7 = getaiarray(var6).size;
      }

      if(var7 < 9) {
        var8 = var1;
      } else if(var7 < 25) {
        var8 = var0;
      } else {
        var8 = var2;
      }

      var4 += 15;
    }

    waitframe();
  }
}

function ref_135ec(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var4 = var3 scripts\common\utility::spawn_vehicle();
    thread ref_1280e();
  }
}

function ref_1280e() {
  thread scripts\common\vehicle_paths::gopath(self);
  wait 1;
  self setwaitspeed(0);
  var0 = scripts\engine\utility::ref_143ad("death", "reached_wait_speed");
  self vehicleshowonminimap(0);

  if(isDefined(var0) && var0 == "reached_wait_speed") {
    wait 1.5;
    self vehicle_turnengineoff();
    return;
  }
}

function ref_13566() {
  scripts\engine\utility::flag_wait_any("fallback_1", "bomb01_planted");
  level.solution_exists_already = [];
  var0 = getEntArray("aq_lbravo_assault2", "targetname");

  foreach(var2 in var0) {
    if(var2.script_noteworthy == "left" && level.players.size > 2) {
      var3 = var2 scripts\common\utility::spawn_vehicle();
      thread silo_door_left();
      thread skipsplash(var3, "heli_fob", "left");
      level.solution_exists_already[level.solution_exists_already.size] = var3;
    } else if(var2.script_noteworthy == "right") {
      var3 = var2 scripts\common\utility::spawn_vehicle();
      thread silo_door_left();
      thread skipsplash(var3, "heli_fob", "right");
      level.solution_exists_already[level.solution_exists_already.size] = var3;
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

function solutions(var0) {
  if(level.solution_exists_already.size <= var0) {
    return true;
  }

  return false;
}

function ref_13567() {
  level.sort_goal_positions_by_priority = [];
  var0 = getEnt("aq_lbravo_assault3_fob2", "targetname");
  var1 = var0 scripts\common\utility::spawn_vehicle();
  var1.ref_1385b = scripts\engine\utility::getStruct("heli_fob2", "targetname");
  var1.player_too_far = 1;
  var1.player_test_ending_teleport = "start_fob2_heli_run";
  thread silo_door_runners();
  thread skipsplash(var1, undefined, undefined);
  level.sort_goal_positions_by_priority[level.sort_goal_positions_by_priority.size] = var1;
  wait 1;
  scripts\engine\utility::flag_set("heli_assault3_fob_spawned");
}

function ref_13568() {
  level.solved = [];
  var0 = getEntArray("aq_lbravo_assault3", "targetname");

  foreach(var2 in var0) {
    if(!isDefined(var2.script_noteworthy)) {
      continue;
    }

    if(var2.script_noteworthy == "left" && level.players.size > 2) {
      var2.count++;
      var3 = var2 scripts\common\utility::spawn_vehicle();
      thread silo_door_right();
      thread skipsplash(var3, "heli_hangar", "left");
      level.solved[level.solved.size] = var3;
    } else if(var2.script_noteworthy == "right") {
      var2.count++;
      var3 = var2 scripts\common\utility::spawn_vehicle();
      thread silo_door_right();
      thread skipsplash(var3, "heli_hangar", "right");
      level.solved[level.solved.size] = var3;
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

function sort_wave_spawning_ai(var0) {
  if(level.sort_goal_positions_by_priority.size <= var0) {
    return true;
  }

  return false;
}

function sort_by_ai_assigned(var0) {
  if(level.solved.size <= var0) {
    return true;
  }

  return false;
}

function sortbylastzombietime(var0) {
  if(level.sortbyhvttags.size <= var0) {
    return true;
  }

  return false;
}

function ref_13569() {
  level.sortbyhvttags = [];
  var0 = getEntArray("aq_lbravo_assault3", "targetname");

  foreach(var2 in var0) {
    if(!isDefined(var2.script_noteworthy)) {
      continue;
    }

    if(var2.script_noteworthy == "left" && level.players.size > 2) {
      var2.count++;
      var3 = var2 scripts\common\utility::spawn_vehicle();
      thread silo_jump_dogtag_revive();
      thread skipsplash(var3, "heli_hangar_end", "left");
      level.sortbyhvttags[level.sortbyhvttags.size] = var3;
    } else if(var2.script_noteworthy == "right") {
      var2.count++;
      var3 = var2 scripts\common\utility::spawn_vehicle();
      thread silo_jump_dogtag_revive();
      thread skipsplash(var3, "heli_hangar_end", "right");
      level.sortbyhvttags[level.sortbyhvttags.size] = var3;
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

function skipsplash(var0, var1, var2) {
  self endon("death");
  self.ref_11d97 = undefined;

  if(isDefined(var1)) {
    self.ref_11d97 = protect_jammer(var0, var1);
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

function ref_137b0(var0) {
  self.player_too_far = 0;
  wait 1;
  var1 = scripts\engine\utility::getStruct(self.player_test_ending_teleport, "targetname");
  thread scripts\common\vehicle::vehicle_paths(var1);
  self waittill("reached_dynamic_path_end");
  self setvehgoalpos(var0.origin, 1);
  wait 0.05;
  self settargetyaw(var0.angles[1]);
  wait 8;
  self.player_too_far = 1;
}

function prohibited_weapon_list(var0) {
  var1 = sortbydistance(level.players, self.origin);

  foreach(var3 in var1) {
    if(!scripts\cp\cp_laststand::player_in_laststand(var3)) {
      if(isDefined(var0) && var0) {
        var4 = scripts\engine\utility::getStructArray("mortar_trace", "targetname");

        if(scripts\engine\trace::ray_trace_passed(var4[0].origin, var3 getEye(), [var3])) {
          return var3;
        } else if(scripts\engine\trace::ray_trace_passed(var4[1].origin, var3 getEye(), [var3])) {
          return var3;
        }
      } else {
        return var5;
      }
    }
  }

  return undefined;
}

function proprotate(var0) {
  var1 = sortbydistance(level.players, self.origin);

  if(var1.size > 1) {
    var1 = scripts\engine\utility::array_reverse(var1);
  }

  foreach(var3 in var1) {
    if(!scripts\cp\cp_laststand::player_in_laststand(var3)) {
      if(isDefined(var0) && var0) {
        var4 = scripts\engine\utility::getStructArray("mortar_trace", "targetname");

        if(scripts\engine\trace::ray_trace_passed(var4[0].origin, var3 getEye(), [var3])) {
          return var3;
        } else if(scripts\engine\trace::ray_trace_passed(var4[1].origin, var3 getEye(), [var3])) {
          return var3;
        }
      } else {
        return var5;
      }
    }
  }

  return undefined;
}

function protect_jammer(var0, var1) {
  var2 = [];
  self.called50percentprogress = scripts\engine\utility::getStructArray(var0, "script_noteworthy");

  foreach(var4 in self.called50percentprogress) {
    if(isDefined(var4.script_parameters) && var4.script_parameters == var1) {
      var2 = var4;
      continue;
    }

    if(isDefined(var4.script_parameters) && var4.script_parameters == var1 + "_start") {
      var2 = var4;
      self.ref_1385b = var4;
    }
  }

  if(!isDefined(self.ref_1385b)) {
    self.ref_1385b = var2[0];
  }

  return var2;
}

function heli_shoot_player(var0) {
  self endon("death_or_disconnect");
  var1 = 0;

  while(var1 < 3 && isalive(var0) && !var0.inlaststand) {
    var2 = 0;
    var3 = gettime() + 2000;

    while(gettime() < var3) {
      var4 = self.ref_11c2e gettagorigin("tag_flash");
      var5 = self.ref_11c2e gettagangles("tag_flash");
      var6 = var0.origin + (0, 0, 20);

      if(scripts\engine\utility::within_fov(var4, var5, var6, 0.99) && scripts\engine\trace::ray_trace_passed(var4, var6, [self, self.ref_11c2e, var0])) {
        var2 = 1;
        break;
      }

      wait 0.1;

      if(!isalive(var0) || var0.inlaststand) {
        return;
      }
    }

    if(!var2) {
      return var2;
    }

    self.ref_11c2e startbarrelspin();
    wait 1.4;

    if(self.player_controls_failsafe) {
      var0 scripts\engine\utility::delaycall(0.5, &playsoundtoteam, "dx_mpp_ukft1_combat_inform_taking_fire", "allies");
      self.player_controls_failsafe = 0;
    }

    for(var7 = 0; var7 < 30; var7++) {
      self.ref_11c2e shootturret();
      wait 0.1;

      if(!isalive(var0) || var0.inlaststand) {
        break;
      }
    }

    self.ref_11c2e stopbarrelspin();
    wait 0.8;
    return var2;
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
  var0 = getEntArray("hangar_vindia", "script_noteworthy");

  foreach(var2 in var0) {
    if(isDefined(var2.targetname) && var2.targetname == "vindia02" && level.players.size <= 2) {
      continue;
    }

    var3 = var2 scripts\common\vehicle::spawn_vehicle_and_gopath();
    thread ref_1280f(var3);
    level.ref_142b4[level.ref_142b4.size] = var3;
  }

  scripts\engine\utility::flag_wait("all_vindias_spawned_in");
  var5 = 1;

  foreach(var3 in level.ref_142b4) {
    if(var5 && isDefined(var3)) {
      ref_12420(var3, "dx_mpb_ukft1_ping_enemy_vehicle_heavy");
      wait 2.5;

      if(isDefined(var3)) {
        ref_12758("dx_mpa_uktl_spotted_enemy_apc");
      }

      var5 = 0;
    }
  }
}

function ref_1280f(var0) {
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
  var1 = getEnt("vindia_spotlight" + var0 + 1, "targetname");
  var2 = 3;
  var1.origin = self.mainturret gettagorigin("tag_front_turret_light");
  var1.origin += anglesToForward(var1.angles) * var2;
  var1.angles = self.mainturret gettagangles("tag_front_turret_light");
  var1.angles += (10, 0, 0);
  var1 linkTo(self.mainturret, "tag_front_turret_light");
  var1.og_intensity = var1 getlightintensity();
  var1 setlightintensity(0);
  thread ref_14447();
  thread ref_1444c();
  thread ref_1444e();
  thread watch_for_death(var1);
  scripts\engine\utility::flag_wait("start_vindia_scene");

  if(!scripts\engine\utility::flag("all_vindias_spawned_in")) {
    scripts\engine\utility::flag_set("all_vindias_spawned_in");
  }

  scripts\common\vehicle::godoff();
  self.ignoreall = 0;
  self.ignoreme = 0;
  thread scripts\common\vehicle::vehicle_lights_on("headlights");
  wait 0.5;
  var1 setlightintensity(var1.og_intensity);
  wait 1;
  self.mainturret turretfireenable();
  self.mainturret startfiring();
  var3 = cos(10);
  thread ref_13a3f();

  for(;;) {
    while(!ref_13e6f(var3)) {
      wait 0.1;
    }

    while(ref_13e6f(var3)) {
      for(var4 = 0; var4 < randomintrange(4, 5); var4++) {
        self.mainturret shootturret();
        wait randomfloatrange(0.2, 0.4);
      }

      wait randomintrange(2, 4);
    }
  }
}

function ref_13e6f(var0) {
  self endon("death");
  var1 = sortbydistance(level.players, self.origin);

  foreach(var3 in var1) {
    if(scripts\cp\cp_laststand::player_in_laststand(var3)) {
      continue;
    }

    if(scripts\engine\math::within_fov_2d(self.mainturret gettagorigin("tag_flash"), self.mainturret gettagangles("tag_flash"), var3.origin, var0)) {
      return true;
    }
  }

  return false;
}

function ref_13a3f() {
  self endon("death");

  for(;;) {
    self waittill("bulletwhizby", var0);

    if(scripts\engine\utility::array_contains(level.players, var0)) {
      var0 setclientomnvar("damage_feedback_icon", "hittankarmor");
      var0 setclientomnvar("damage_feedback_icon_notify", gettime());
      var0 setclientomnvar("damage_feedback", "hittankarmor");
      var0 setclientomnvar("damage_feedback_notify", gettime());
      var0 setclientomnvar("damage_feedback_nonplayer", 1);
    }
  }
}

function ref_1444c() {
  self endon("death");
  self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
  GscBinSkip4(0x35, var0, var1, var4);
}

function ref_1444e() {
  self endon("death");
  self.mainturret waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
  GscBinSkip4(0x35, var0, var1, var4);
}

function ref_13a40(var0, var1, var2) {
  var3 = undefined;
  var4 = undefined;

  if(scripts\engine\utility::array_contains(level.players, var1)) {
    var3 = var1;

    if(isDefined(var2) && (var2 == "MOD_EXPLOSIVE" || var2 == "MOD_GRENADE_SPLASH" || var2 == "MOD_PROJECTILE_SPLASH")) {
      var4 = "standard";
    } else {
      var4 = "standard";
    }
  }

  if(isDefined(var3)) {
    if(isDefined(var0)) {
      var3 setclientomnvar("damage_feedback_icon", var4);
      var3 setclientomnvar("damage_feedback", var4);
      var3 setclientomnvar("damage_feedback_icon_notify", gettime());
      var3 setclientomnvar("damage_feedback_notify", gettime());

      if(var4 == "standard") {
        var3 setclientomnvar("ui_damage_amount", int(var0));
      }

      if(var0 >= self.health - self.healthbuffer) {
        var3 setclientomnvar("damage_feedback_kill", 1);
        return;
      }

      var3 setclientomnvar("damage_feedback_kill", 0);
      return;
    }

    return;
  }
}

function ref_14447() {
  self waittill("death");

  while(!scripts\engine\utility::flag("start_vindia_scene")) {
    self waittill("damage", var0, var1);

    if(isDefined(var1) && isPlayer(var1)) {
      scripts\engine\utility::flag_set("start_vindia_scene");
    }

    wait 0.05;
  }
}

function watch_for_death(var0) {
  self waittill("death");
  var1 = self.origin;
  var2 = self.angles;
  self setModel("veh8_mil_lnd_vindia_a1_dst");
  var3 = anglesToForward(var2);
  var4 = anglestoup(var2);
  var0 setlightintensity(0);
  playFX(level._effect["vfx_tank_death_exp"], var1, var3, var4);
  wait 4;
  playFX(level._effect["cp_trials_tank_smoke"], var1, var3, var4);
}

function ref_142b5(var0) {
  if(level.ref_142b4.size <= var0) {
    return true;
  }

  return false;
}

function teleport_ai_to_cover_node(var0) {
  var1 = var0.angles;
  var2 = var0.origin;

  if(!issubstr(var0.type, "Prone")) {
    if(issubstr(var0.type, "Left")) {
      var1 += (0, 90, 0);
    } else if(issubstr(var0.type, "Right") || issubstr(var0.type, "Cover Crouch") || issubstr(var0.type, "Conceal") || issubstr(var0.type, "Cover Stand")) {
      var1 -= (0, 90, 0);
    }
  }

  self forceteleport(var2, var1);
  self usecovernode(var0, 1);
  self setgoalnode(var0);
}

function ref_1357b(var0, var1) {
  var2 = scripts\engine\utility::getStruct(var0, "targetname");
  var2.origin = scripts\engine\utility::drop_to_ground(var2.origin);
  var3 = scripts\cp\laser_traps\cp_laser_traps::get_enter_leave_station_time(var2.origin, var2.angles);
  var4 = scripts\cp\laser_traps\cp_laser_traps::get_ending_struct(var3);
  var5 = scripts\cp\laser_traps\cp_laser_traps::get_emp_effect_duration(var3);
  thread scripts\cp\laser_traps\cp_laser_traps::get_end_ang(var3, var4, var5, var1);
}

function mud_sfx(var0) {
  if(var0 == "axis") {
    return 0;
  }

  var1 = 60000;

  if(level.time_survived < 9 * var1) {
    return 3;
  } else if(level.time_survived < 13 * var1) {
    return 2;
  }

  return 1;
}

function ref_11d32() {
  var0 = scripts\engine\utility::getStruct("mortar01", "targetname");
  var1 = scripts\engine\utility::getStruct("mortar02", "targetname");
  wait 1;
  var2 = 0;
  var3 = sortbydistance(level.players, var0.origin);

  foreach(var5 in var3) {
    if(!var2 && isDefined(var5) && !scripts\cp\cp_laststand::player_in_laststand(var5)) {
      var5 scripts\engine\utility::delaycall(1, &playsoundtoteam, "dx_vom_us2_defend_grounds_52", "allies");
      var2 = 1;
    }
  }

  while(!scripts\engine\utility::flag("assault1_over")) {
    enemy_mortar_launch(var0, 1);

    if(level.players.size > 2) {
      wait 2.5;
      enemy_mortar_launch(var1, 0);
    }

    var7 = getaiarray("axis");

    if(isDefined(var7) && var7.size < 3) {
      wait randomfloatrange(4, 5.5);
      continue;
    }

    wait randomfloatrange(5, 6.5);
  }
}

function enemy_mortar_launch(var0, var1) {
  var2 = scripts\engine\utility::getStructArray("mortar_miss_struct", "targetname");
  var3 = 2000;
  var4 = 2.25;
  var5 = var0;
  var6 = undefined;

  if(var1) {
    var6 = prohibited_weapon_list(var0, 1);
  } else {
    var6 = proprotate(var0, 1);
  }

  if(!isDefined(var6)) {
    var7 = scripts\engine\utility::array_randomize(var2);
    var6 = var7[0];
  }

  var8 = randomintrange(-250, 100);
  var9 = randomintrange(100, 250);

  if(isPlayer(var6) && var6 issprinting()) {
    var8 = -600;
    var9 = 400;
  }

  var10 = spawnStruct();
  var10.origin = var6.origin + (var8, var9, 10);
  var11 = scripts\engine\trace::ray_trace(var10.origin + (0, 0, 600), var10.origin);
  var10.origin = var11["position"];

  if(getdvarint("scr_mortar_gravity")) {
    var12 = distance(var5.origin, var10.origin);
    var4 = var12 / var3 * var4;
  }

  var13 = scripts\engine\utility::spawn_tag_origin(var5.origin, (0, 0, 0));
  var13 show();
  wait 0.15;
  playFXOnTag(level._effect["vfx_smktrail_mortar"], var13, "tag_origin");
  playFXOnTag(level._effect["vfx_mortar_trail"], var13, "tag_origin");
  playFX(level._effect["vfx_emb_flash_mortar"], var5.origin);

  if(distance2d(var10.origin, var5.origin) < 400) {
    earthquake(0.1, 2, var5.origin, 2000);

    if(isPlayer(var6)) {
      level.player playRumbleOnEntity("damage_light");
    }
  }

  wait 0.1;

  if(isPlayer(var6)) {
    var6 playRumbleOnEntity("damage_heavy");
  }

  playsoundatpos(var13.origin, "weap_mortar_fire_dist");
  var13 playLoopSound("weap_mortar_fly_lp");
  var14 = max(0.05, var4 - 1.7);
  playsoundatpos(var13.origin, "weap_mortar_incoming");
  movemortar(var13, var5.origin, var10.origin, var4);
  level notify("mortar_impact");
  var13 stoploopsound("weap_mortar_fly_lp");
  var13 delete();
  radiusdamage(var10.origin, 500, 1, 1);
  earthquake(0.4, 1.5, var10.origin, 2000);
  playrumbleonposition("damage_heavy", var6.origin);
  playFX(level._effect["vfx_mortar_explosion"], var10.origin);
  var12 = distance(var6.origin, var10.origin);

  if(300 > distance(var6.origin, var10.origin)) {
    if(isPlayer(var6) && var6.origin[2] + 100 > var10.origin[2]) {
      var6 scripts\engine\utility::delaycall(0.75, &shellshock, "default", 1);
    }
  }

  magicgrenademanual("mortar_mp", var10.origin + (0, 0, 5), (0, 0, 0), 0.05);
  physicsexplosionsphere(var10.origin, 300, 150, 100);
  return true;
}

function movemortar(var0, var1, var2, var3, var4) {
  setdvarifuninitialized("scr_mortar_gravity", "0 ");

  if(getdvarint("scr_mortar_gravity")) {
    var0.origin = var1;
    var5 = getdvarint("NPOQPMP");
    var6 = distance(var1, var2);
    var7 = var2 - var1;
    var8 = 0.5 * var5 * squared(var3) * -1;
    var9 = (var7[0] / var3, var7[1] / var3, (var7[2] - var8) / var3);
    var0 movegravity(var9, var3);
    var10 = gettime() + var3 * 1000;

    while(gettime() < var10) {
      anglemortar(var0);
      waitframe();
    }

    return;
  }

  var11 = 1200;

  if(isDefined(var4)) {
    var11 = var4;
  }

  var12 = 1 / var3 / 0.05;
  var13 = 0;

  while(var13 < 1) {
    var0.origin = scripts\engine\math::get_point_on_parabola(var1, var2, var11, var13);
    anglemortar(var0);
    var13 += var12;
    wait 0.05;
  }

  var0.origin = var2;
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

function enemy_mortar(var0) {
  wait 0.25;
  enemy_mortar_launch(var0);
  wait level.mortar_round_delay_time;
  thread enemy_mortar(var0);
}

function ref_11cc5() {
  var0 = scripts\engine\utility::getStructArray("molotov_launcher", "targetname");
  var1 = var0[0];
  var2 = scripts\engine\utility::spawn_tag_origin();
  var3 = squared(2000);

  while(!scripts\engine\utility::flag("assault1_over")) {
    var0 = scripts\engine\utility::array_randomize(var0);

    if(scripts\engine\utility::is_equal(var1, var0[0])) {
      var1 = var0[1];
    } else {
      var1 = var0[0];
    }

    var2.origin = var1.origin;
    var4 = prohibited_weapon_list(var2);
    var5 = distancesquared(var4.origin, var2.origin);

    if(var5 >= var3) {
      wait 0.1;
      continue;
    }

    if(isDefined(var4)) {
      var6 = scripts\cp\laser_traps\cp_laser_traps::put_headicon_on_tv_station_boss();
      var7 = scripts\engine\utility::getclosest(var2.origin, var6);
      no_csm(var1, var4, var7);
      wait randomfloatrange(4.5, 6.5);
    }

    wait 0.1;
  }
}

function no_csm(var0, var1, var2) {
  var3 = 6000;
  var4 = 6.25;
  var5 = spawnStruct();
  var5.origin = var0.origin;
  var6 = spawnStruct();
  var6.origin = var1.origin;
  var7 = scripts\engine\trace::ray_trace(var6.origin + (0, 0, 1000), var6.origin);
  var6.origin = var7["position"];
  var8 = distance(var5.origin, var6.origin);
  var4 = var8 / var3 * var4;
  var9 = scripts\engine\utility::spawn_tag_origin(var5.origin, (0, 0, 0));
  wait 0.1;
  var10 = max(0.05, var4 - 1.7);
  var11 = randomintrange(-100, 100);
  var12 = randomintrange(-100, 100);

  if(var1 issprinting()) {
    var11 = randomintrange(-300, 300);
    var12 = randomintrange(-300, 300);
  }

  ref_11d8e(var9, var5.origin, var1.origin + (var11, var12, 10), var4);
  level notify("mortar_impacted");
  var9 delete();

  if(!isalive(var2)) {
    return;
  }

  var2 endon("death");
  var2.grenadeweapon = getcompleteweaponname("molotov_mp");
  var13 = var2 magicgrenademanual(var1.origin + (var11, var12, 10), var1.origin);
}

function ref_11d8e(var0, var1, var2, var3) {
  var0.origin = var1;
  var4 = getdvarint("NPOQPMP");
  var5 = distance(var1, var2);
  var6 = var2 - var1;
  var7 = 0.5 * var4 * squared(var3) * -1;
  var8 = (var6[0] / var3, var6[1] / var3, (var6[2] - var7) / var3);
  var0 movegravity(var8, var3);
  var9 = gettime() + var3 * 1000;

  while(gettime() < var9) {
    building_magic_grenade_kill_watch(var0);
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

function ref_13423(var0) {
  var1 = 0.5;
  var2 = 1;
  var3 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var5 in var3) {
    playFX(level._effect["smoke_grenade_explosion"], var5.origin);
    playFX(level._effect["smoke_grenade_fx"], var5.origin);
    wait randomfloatrange(0.15, 0.3);
  }
}

function weapon_xp_iw8_sh_romeo870(var0) {
  var1 = (0, 0, 2);
  var2 = (0, -90, 0);

  foreach(var4 in var0) {
    var5 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var4.origin + var1, var4.angles + var2);
  }
}

function weapon_xp_iw8_sn_golf28(var0) {
  var1 = (0, -90, 0);

  foreach(var3 in var0) {
    switch (var3.script_parameters) {
      case "ammo":
        var4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var3.origin, var3.angles + var1);
        var4 setHintString(&"COOP_CRAFTING/AMMO_CRATE_TAKE");
        break;
      case "claymore":
        var4 = ref_12f4f(var3.origin, var3.angles, &scripts\cp\laser_traps\cp_laser_traps::handle_no_ammo_mun, var3, &"EQUIPMENT_HINTS/PICKUP_CLAYMORE", undefined, &handle_nav_bounds_buildings);
        break;
      case "flash":
        var4 = ref_12f4f(var3.origin, var3.angles, &scripts\cp\laser_traps\cp_laser_traps::player_max_exposure_time, var3, &"CP_SO_FINALE/PICKUP_FLASH", undefined, &player_looking);
        break;
      case "c4":
        var4 = ref_12f4f(var3.origin, var3.angles, &scripts\cp\laser_traps\cp_laser_traps::fogenabled, var3, &"EQUIPMENT_HINTS/PICKUP_C4", undefined, &focus_fire_outline_id);
        break;
      case "stim":
        var4 = ref_12f4f(var3.origin, var3.angles, &ref_138ab, var3, &"CP_SO_FINALE/PICKUP_STIMS", undefined, &ref_138aa);
        break;
      case "molotov":
        var4 = ref_12f4f(var3.origin, var3.angles, &scripts\cp\laser_traps\cp_laser_traps::ref_11cba, var3, &"CP_SO_FINALE/PICKUP_MOLOTOV", undefined, &ref_11cb9);
        break;
    }
  }
}

function weapon_xp_iw8_sn_delta(var0) {
  var1 = (0, -90, 0);

  foreach(var3 in var0) {
    switch (var3.script_parameters) {
      case "ammo":
        var4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var3.origin, var3.angles + var1);
        break;
      case "claymore":
        var4 = scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding(var3.origin, var3.angles + var1);
        break;
      case "flash":
        var4 = scripts\cp\laser_traps\cp_laser_traps::player_limitedammo(var3.origin, var3.angles + var1);
        break;
      case "c4":
        var4 = scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled(var3.origin, var3.angles + var1);
        break;
      case "stim":
        var4 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime(var3.origin, var3.angles + var1);
        break;
      case "molotov":
        var4 = scripts\cp\laser_traps\cp_laser_traps::ref_11cb8(var3.origin, var3.angles + var1);
        break;
      case "frag":
        var4 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(var3.origin, var3.angles + var1);
        break;
    }
  }
}

function handle_nav_bounds_buildings(var0) {
  var0 endon("entitydeleted");
  thread ref_13f95(var0, "power_claymore");
}

function player_looking(var0) {
  var0 endon("entitydeleted");
  thread ref_13f95(var0, "power_flash");
}

function focus_fire_outline_id(var0) {
  var0 endon("entitydeleted");
  thread ref_13f95(var0, "power_c4");
}

function ref_138ab(var0, var1) {
  var1 thread scripts\cp\cp_powers::givepower("equip_adrenaline", "secondary", undefined, undefined, undefined, undefined, 1, 4);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function ref_138aa(var0) {
  var0 endon("entitydeleted");
  thread ref_13f95(var0, "equip_adrenaline");
}

function ref_11cb9(var0) {
  var0 endon("entitydeleted");
  thread ref_13f95(var0, "power_molotov");
}

function ref_13f95(var0, var1) {
  var2 = [];

  foreach(var4 in level.players) {
    var5 = isDefined(var4.powers) && isDefined(var4.powers[var1]) && var4.powers[var1].charges == var4.powers[var1].maxcharges;

    if(var5) {
      var0 disableplayeruse(var4);

      if(isDefined(var0.nuke_removefadeonbnkplay)) {
        var0.nuke_removefadeonbnkplay hidefromplayer(var4);
      }

      continue;
    }

    var2 = scripts\engine\utility::array_add(var2, var4);
  }

  for(;;) {
    var7 = [];

    foreach(var4 in level.players) {
      var5 = isDefined(var4.powers) && isDefined(var4.powers[var1]) && var4.powers[var1].charges == var4.powers[var1].maxcharges;

      if(var5) {
        if(scripts\engine\utility::array_contains(var2, var4)) {
          var0 disableplayeruse(var4);

          if(isDefined(var0.nuke_removefadeonbnkplay)) {
            var0.nuke_removefadeonbnkplay hidefromplayer(var4);
          }
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(var2, var4)) {
        var0 enableplayeruse(var4);

        if(isDefined(var0.nuke_removefadeonbnkplay)) {
          var0.nuke_removefadeonbnkplay showtoplayer(var4);
        }
      }

      var7 = scripts\engine\utility::array_add(var7, var4);
    }

    var2 = var7;
    wait 0.1;
  }
}

function weaponclassweights(var0) {
  foreach(var2 in var0) {
    var3 = fire_rockets_to_target(var2.script_parameters);
    var4 = createheadicon(var3);
    var3 = spawn("weapon_" + var4, var2.origin, 1);
    var3.angles = var2.angles;

    if(var2.script_parameters == "iw8_la_mike32_mp") {
      thread ref_1432a();
    }

    var3 itemweaponsetammo(weaponclipsize(var4), weaponmaxammo(var4));
  }
}

function ref_1432a() {
  self waittill("trigger", var0);

  if(isPlayer(var0)) {
    var0 thread scripts\mp\trials\trial_pitcher::firemanager();
    return;
  }
}

function fire_rockets_to_target(var0) {
  switch (var0) {
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

function weapon_xp_iw8_sn_alpha50(var0) {
  foreach(var2 in var0) {
    switch (var2.script_parameters) {
      case "assault":
        var3 = ref_12f4f(var2.origin, var2.angles, &scrambler_cleanup_player, var2, &"KILLSTREAKS/PRECISION_AIRSTRIKE", undefined, &vo_two_remain, 1);
        break;
      case "support":
        var3 = ref_12f4f(var2.origin, var2.angles, &scrapassistdamage, var2, &"KILLSTREAKS/TOMA_STRIKE", undefined, &vo_two_remain, 1);
        break;
      case "demo":
        var3 = ref_12f4f(var2.origin, var2.angles, &screen, var2, &"KILLSTREAKS/SENTRY", undefined, &vo_two_remain, 1);
        break;
      case "recon":
        var3 = ref_12f4f(var2.origin, var2.angles, &screen, var2, &"KILLSTREAKS/SENTRY", undefined, &vo_two_remain, 1);
        break;
    }
  }
}

function scrambler_cleanup_player(var0, var1) {
  var2 = scripts\cp\loot_system::get_empty_munition_slot(var1);

  if(isDefined(var2)) {
    var1 notify("new_killstreak_loadout_aquired");
    scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var1, "precision_airstrike");
    var0.valve_steam_on = 1;
    var1.vo_stealth_broken = 1;
    var1 forceplaygestureviewmodel("ges_swipe", var0);
    var1 playlocalsound("weap_ammo_pickup");
    return;
  }

  var1 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
}

function scrapassistdamage(var0, var1) {
  var2 = scripts\cp\loot_system::get_empty_munition_slot(var1);

  if(isDefined(var2)) {
    var1 notify("new_killstreak_loadout_aquired");
    scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var1, "cluster_strike");
    var0.valve_steam_on = 1;
    var1.vo_stealth_broken = 1;
    var1 forceplaygestureviewmodel("ges_swipe", var0);
    var1 playlocalsound("weap_ammo_pickup");
    return;
  }

  var1 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
}

function screen(var0, var1) {
  var2 = scripts\cp\loot_system::get_empty_munition_slot(var1);

  if(isDefined(var2)) {
    var1 notify("new_killstreak_loadout_aquired");
    scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var1, "sentry");
    var0.valve_steam_on = 1;
    var1.vo_stealth_broken = 1;
    var1 forceplaygestureviewmodel("ges_swipe", var0);
    var1 playlocalsound("weap_ammo_pickup");
    return;
  }

  var1 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
}

function has_termal(var0, var1) {
  var1 notify("new_killstreak_loadout_aquired");
  var2 = "precision_airstrike";
  var1.vo_three_remain = "assault";
  ref_13201(var1, var2);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function hasactivepunchcard(var0, var1) {
  var2 = "cluster_strike";
  var1.vo_three_remain = "support";
  ref_13201(var1, var2);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function hasaccesscard(var0, var1) {
  var2 = "sentry";
  var1.vo_three_remain = "recon";
  ref_13201(var1, var2);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function has_zone(var0, var1) {
  var2 = "cruise_missile";
  var1.vo_three_remain = "demo";
  ref_13201(var1, var2);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function ref_13201(var0) {
  scripts\cp\cp_munitions::give_munition_to_slot(var0, 0);
}

function ref_12b40(var0, var1) {
  self endon("new_killstreak_loadout_aquired");

  for(;;) {
    self waittill("munitions_used", var2);
    waitframe();
    self.munition_splash_supress = 1;

    if(var2 == var0) {
      if(self.munition_slots[0].can_use) {
        thread vo_stealth_exchange(var0, 0, "cp_munition_1_timer");
      }

      continue;
    }

    if(var2 == var1) {
      if(self.munition_slots[1].can_use) {
        thread vo_stealth_exchange(var1, 1, "cp_munition_2_timer");
      }
    }
  }
}

function vo_stealth_exchange(var0, var1, var2) {
  self.munition_slots[var1].can_use = 0;
  var3 = undefined;

  if(var1 == 0) {
    var3 = 12;
  } else {
    var3 = 20;
  }

  thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SO_FINALE/COOLDOWN_KS", 2.5);
  wait var3;
  scripts\cp\cp_munitions::give_munition_to_slot(var0, var1);
  self.munition_slots[var1].can_use = 1;
}

function ref_13ea5(var0, var1, var2) {
  level endon("game_ended");
  self endon("disconnect");
  self sethudtutorialmessage(var0, var2);
  wait var1;
  self clearhudtutorialmessage();
}

function vo_two_remain(var0) {
  var0 endon("entitydeleted");
  thread ref_13f93(var0);
}

function ref_13f93(var0) {
  var0 endon("entitydeleted");
  var1 = [];

  foreach(var3 in level.players) {
    if(isDefined(var3.vo_stealth_broken) && var3.vo_stealth_broken) {
      var0 disableplayeruse(var3);
      var0 hidefromplayer(var3);
      continue;
    }

    var1 = scripts\engine\utility::array_add(var1, var3);
  }

  for(;;) {
    var5 = [];

    foreach(var3 in level.players) {
      if(isDefined(var3.vo_stealth_broken) && var3.vo_stealth_broken) {
        if(scripts\engine\utility::array_contains(var1, var3)) {
          var0 disableplayeruse(var3);
          var0 hidefromplayer(var3);
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(var1, var3)) {
        var0 enableplayeruse(var3);
        var0 showtoplayer(var3);
      }

      var5 = scripts\engine\utility::array_add(var5, var3);
    }

    var1 = var5;
    wait 0.1;
  }

  var0 delete();
}

function carepackage_set_visible_model(var0) {
  var0 endon("entitydeleted");
  thread ref_13f94(var0, "assault");
}

function ref_139ad(var0) {
  var0 endon("entitydeleted");
  thread ref_13f94(var0, "support");
}

function ref_12a96(var0) {
  var0 endon("entitydeleted");
  thread ref_13f94(var0, "recon");
}

function laststand_dogtag_monitor(var0) {
  var0 endon("entitydeleted");
  thread ref_13f94(var0, "demo");
}

function ref_13f94(var0, var1) {
  var0 endon("entitydeleted");
  var2 = [];

  foreach(var4 in level.players) {
    if(isDefined(var4.ref_124fd)) {
      var0 disableplayeruse(var4);
      wait 0.1;
      continue;
    }

    if(isDefined(var4.vo_three_remain) && var4.vo_three_remain == var1) {
      var0 disableplayeruse(var4);

      if(isDefined(var0.nuke_removefadeonbnkplay)) {
        var0.nuke_removefadeonbnkplay hidefromplayer(var4);
      }

      continue;
    }

    var2 = scripts\engine\utility::array_add(var2, var4);
  }

  for(;;) {
    var6 = [];

    foreach(var4 in level.players) {
      if(isDefined(var4.ref_124fd)) {
        var0 disableplayeruse(var4);
        wait 0.1;
        continue;
      }

      if(isDefined(var4.vo_three_remain) && var4.vo_three_remain == var1) {
        if(scripts\engine\utility::array_contains(var2, var4)) {
          var0 disableplayeruse(var4);

          if(isDefined(var0.nuke_removefadeonbnkplay)) {
            var0.nuke_removefadeonbnkplay hidefromplayer(var4);
          }
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(var2, var4)) {
        var0 enableplayeruse(var4);

        if(isDefined(var0.nuke_removefadeonbnkplay)) {
          var0.nuke_removefadeonbnkplay showtoplayer(var4);
        }
      }

      var6 = scripts\engine\utility::array_add(var6, var4);
    }

    var2 = var6;
    wait 0.1;
  }
}

function ref_13f92(var0, var1) {
  var0 endon("entitydeleted");
  var2 = [];

  foreach(var4 in level.players) {
    if(isDefined(self.ref_124fd)) {
      var0 disableplayeruse(var4);
      waitframe();
      continue;
    }

    if(isDefined(var4.vehicle_occupancy_cp_handlesuicidefromvehicles) && var4.vehicle_occupancy_cp_handlesuicidefromvehicles == var1) {
      var0 disableplayeruse(var4);
      var0 hidefromplayer(var4);
      continue;
    }

    var2 = scripts\engine\utility::array_add(var2, var4);
  }

  for(;;) {
    var6 = [];

    foreach(var4 in level.players) {
      if(isDefined(self.ref_124fd)) {
        var0 disableplayeruse(var4);
        waitframe();
        continue;
      }

      if(isDefined(var4.vehicle_occupancy_cp_handlesuicidefromvehicles) && var4.vehicle_occupancy_cp_handlesuicidefromvehicles == var1) {
        if(scripts\engine\utility::array_contains(var2, var4)) {
          var0 disableplayeruse(var4);
          var0 hidefromplayer(var4);
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(var2, var4)) {
        var0 enableplayeruse(var4);
        var0 showtoplayer(var4);
      }

      var6 = scripts\engine\utility::array_add(var6, var4);
    }

    var2 = var6;
    wait 0.1;
  }

  var0 delete();
}

function ref_12f4f(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = spawn("script_model", var0);

  if(isDefined(var1)) {
    var8.angles = var1;
  } else {
    var8.angles = (0, 0, 0);
  }

  if(isDefined(var3)) {
    if(isstring(var3)) {
      var8 setModel(var3);
    } else if(isstruct(var3) && isDefined(var3.target)) {
      var8.nuke_removefadeonbnkplay = getEnt(var3.target, "targetname");
    }
  }

  scripts\cp\cp_outline_utility::outlineenableforall(var8, "outline_depth_white", "equipment");

  if(isDefined(var5)) {
    var8.headicon = thread scripts\cp\utility::ent_createheadicon(var8, 15, "allies", var5, 1);
    setheadiconsnaptoedges(var8.headicon, 1500);
    setheadiconmaxdistance(var8.headicon, 15);
  }

  var8 setCursorHint("HINT_BUTTON");
  var8 sethintdisplayrange(200);
  var8 sethintdisplayfov(45);
  var8 setuserange(100);
  var8 setusefov(40);
  var8 sethintonobstruction("show");
  var8 setuseholdduration("duration_none");
  var8 makeusable();

  if(isDefined(var4)) {
    var8 setHintString(var4);
  }

  var8.valve_steam_on = 0;

  if(isDefined(var6)) {
    GscBinSkip1(0x74, var6, var8);
  }

  thread ref_12f50(var8, var2, var7);
  return var8;
}

function ref_12f50(var0, var1, var2) {
  var0 endon("entitydeleted");

  for(;;) {
    var0 waittill("trigger", var3);

    if(!isPlayer(var3)) {
      continue;
    }

    GscBinSkip1(0x74, var1, var0, var3);
  }
}

function ref_12758(var0) {
  if(!isDefined(level.ref_121a7)) {
    level.ref_121a7 = spawn("script_origin", (0, 0, 0));
  }

  level.ref_121a7 stopsounds();
  var1 = lookupsoundlength(var0) * 0.001;
  level.ref_121a7 playSound(var0);
  wait var1;
}

function ref_12759(var0, var1) {
  if(scripts\engine\utility::flag(var1)) {
    return;
  }

  level endon(var1);

  if(!isDefined(level.ref_121a7)) {
    level.ref_121a7 = spawn("script_origin", (0, 0, 0));
  }

  level.ref_121a7 stopsounds();
  var2 = lookupsoundlength(var0) * 0.001;
  level.ref_121a7 playSound(var0);
  wait var2;
}

function ref_12420(var0, var1) {
  var2 = var0 scripts\cp\utility::get_closest_living_player();

  if(isDefined(var2)) {
    var2 playsoundtoteam(var1, "allies");
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