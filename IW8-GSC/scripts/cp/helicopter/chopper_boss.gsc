/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\helicopter\chopper_boss.gsc
**************************************************/

function init() {
  level.struct_filter = &cp_struct_filter;
  scripts\engine\utility::init_struct_class();
  clean_up_structs();
  delete_on_load();
  setdefaultleveldata();
  setdefaultdvars();
  setupcallbacks();
  scripts\cp\utility::initgameflags();
  init_global_cp_flags();
  setupexplodertriggers();
  setdefaultgameparameters();
  setdefaultvisionset();
  setdefaultjiprules();
  loadglobalfx();
  specialentitymonitor();
  initdestructables();
  scripts\cp\scriptable::scriptable_cpglobalcallback();
  scripts\common\exploder::setupexploders();
  shellshock_init();
  inithud();
  initkilltriggerspawn();
  scripts\common\fx::initfx();
  scripts\mp\callbacksetup::setupdamageflags();
  scripts\cp\cp_damagefeedback::init();
  scripts\cp\cp_movers::init();
  scripts\cp\coop_fx::main();
  scripts\cp\cp_merits::buildmeritinfo();
  scripts\cp\cp_endgame::init();
  scripts\cp\cp_laststand::init_laststand();
  scripts\cp\cp_loadout::init();
  thread scripts\cp\cp_equipment::subway_car_move_think();

  if(shouldverifydedicatedconfig()) {
    thread verifydedicatedconfiguration();
  }

  level.leanthread = getdvarint("scr_runlean_playerthread_count", 0) == 1;
  level.script = tolower(getDvar("mapname"));
  level.gametype = tolower(getDvar("g_gametype"));
  level.codcasterenabled = getdvarint("com_codcasterEnabled", 0) == 1;
  level.systemlink = getdvarint("systemlink", 0) == 1;
  level.useperbullethitmarkers = getdvarint("ui_use_per_bullet_hitmarkers", 0) == 1;
  level.splitscreen = issplitscreen();
  level.onlinegame = getdvarint("onlinegame");
  level.rankedmatch = level.onlinegame || getdvarint("force_ranking");
  level.matchmakingmatch = level.onlinegame;
  level.playerxpenabled = level.matchmakingmatch || getdvarint("force_ranking");
  level.weaponxpenabled = level.playerxpenabled;
  level.challengesallowed = level.matchmakingmatch && !getdvarint("xblive_privatematch") || getdvarint("force_ranking") || getdvarint("debug_challenges");
  level.enforceantiboosting = level.playerxpenabled || level.weaponxpenabled || level.challengesallowed;
  level.onlinestatsenabled = level.rankedmatch;
  level.ref_12376 = getdvarint("LOPLPOKTOP", 0);
  level.starttimeutcseconds = getsystemtime();
  level.current_personal_interaction_structs = [];
  level.aud_interior_plane_audio_zones = [];
  level.weapon_drop_cooldown = [];
  level.grenade_drop_cooldown = [];
  level.tacticalmode = 0;
  level.teamnamelist = ["axis", "allies"];
  level.func["scriptModelPlayAnim"] = &scriptmodelplayanim;
  level.func["precacheMpAnim"] = &precachempanim;
  level.func["scriptModelClearAnim"] = &scriptmodelclearanim;
  level.vehiclefriendlydamage = getdvarint("scr_vehicleFriendlyDamage", 0) > 0;
  scripts\cp\cp_anim::init();
  level.framedurationseconds = level.frameduration / 1000;
  waypoint_init();
  level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level thread scripts\cp\cp_visionsets::vision_set_management();
  level thread scripts\cp\init_cp_mp::init();
  level.lastslowprocessframe = 0;
  scripts\cp\utility::gameflaginit("prematch_done", 0);
  scripts\cp\utility::gameflaginit("infil_setup_complete", 0);
  scripts\cp\utility::gameflaginit("infil_will_run", 0);
  scripts\cp\utility::gameflaginit("infil_started", 0);
  level thread scripts\cp\utility\spawn_event_aggregator::init();
  scripts\cp\utility\lui_game_event_aggregator::init();
  level thread scripts\cp\utility\disconnect_event_aggregator::init();
  level thread scripts\cp\utility\player_frame_update_aggregator::init();
  level scripts\cp_mp\utility\game_utility::game_utility_init();
  level thread scripts\cp_mp\utility\shellshock_utility::shellshock_utility_init();
  level thread scripts\cp\cp_destruction::init_destruction();
  level thread scripts\cp\crafting_system::init_craftingsystem(1);
  level thread scripts\cp\cp_munitions::init_munitions();
  level thread scripts\cp\cp_outline_utility::init();
  level thread scripts\cp\inventory\cp_ac130::init();
  level thread scripts\cp\cp_deployablebox::init();
  level thread scripts\cp\drone\scout_drone::init();
  level thread scripts\cp_mp\targetmarkergroups::init();
  level thread scripts\mp\objidpoolmanager::init();
  level thread scripts\mp\playeractions::init();
  thread scripts\cp_mp\xmike109::init();
  thread trackplayedtime();
  level thread scripts\cp\drone\emp_drone::init();
  thread scripts\mp\mp_agent_damage::init();
  scripts\mp\playeractions::addaction("mantle", &scripts\common\utility::allow_mantle);
  level thread scripts\mp\sentientpoolmanager::init();
  level thread scripts\cp\cp_relics::init();
  level thread scripts\cp\cp_player_battlechatter::init();
  level thread scripts\cp_mp\vehicles\vehicle::vehicle_init();
  scripts\cp_mp\entityheadicons::init();
  level thread scripts\cp_mp\killstreaks\init::init();
  level thread scripts\cp_mp\emp_debuff::emp_debuff_init();
  level thread scripts\engine\scriptable_door::system_init();
  thread scripts\cp_mp\gestures::init();
  thread scripts\cp\gestures_cp::init_cp();

  if(!scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    level thread scripts\cp\respawn\cp_respawn::main();
    level.respawn_func = undefined;
  }

  level thread scripts\cp_mp\execution::execution_init();
  thread watchslowmo();
  scripts\common\utility::allow_add("gesture", &scripts\cp\utility\player::allow_gesture);
  scripts\common\utility::allow_add("supers", &scripts\common\utility::allow_supers);
  scripts\common\utility::allow_add("health_regen", &scripts\cp\utility\player::allow_health_regen);
  scripts\common\utility::allow_add("one_hit_melee_victim", &scripts\cp\utility\player::allow_one_hit_melee_victim);
  scripts\common\utility::allow_add("flashed", &scripts\cp\utility\player::allow_flashed);
  scripts\common\utility::allow_add("stunned", &scripts\cp\utility\player::allow_stunned);
  scripts\common\utility::allow_add("stick_kill", &scripts\cp\utility\player::allow_stick_kill);
  level.livescount = 1;
  scripts\engine\utility::delaythread(60, &scripts\cp\laser_traps\cp_laser_traps::little_bird_mg_cp_ondeathrespawncallback);
}

function trackplayedtime() {
  level endon("game_ended");
  scripts\cp\utility::gameflagwait("prematch_done");

  while(!level.gameended) {
    wait 1;

    foreach(var_1 in level.players) {
      trackplayedtimeupdate(var_1);
    }
  }
}

function trackplayedtimeupdate() {
  if(isDefined(self.timeplayed)) {
    var_0 = self.sessionteam;

    if(!isDefined(self.timeplayed[var_0])) {
      self.timeplayed[var_0] = 0;
    } else {
      self.timeplayed[var_0]++;
    }

    if(var_0 != "spectator" && var_0 != "follower") {
      self.timeplayed["total"]++;
      self.timeplayed["missionTeam"]++;

      if(!scripts\cp\utility\player::isreallyalive(self)) {
        self.timeplayed["timeDead"]++;
        return;
      }

      return;
    }

    return;
  }
}

function cp_struct_filter(var_0) {
  if(!isDefined(level.struct_filter_kvps)) {
    level.struct_filter_kvps = [];
  }

  switch (var_0.targetname) {
    case "lighttank_drop":
      return false;
  }

  level.struct_filter_kvps[var_0.targetname] = var_0.targetname;
  return true;
}

function clean_up_structs() {
  if(isDefined(level.struct_filter_kvps)) {
    var_0 = getarraykeys(level.struct_filter_kvps);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {}

    level.struct_filter_kvps = undefined;
  }

  var_2 = level.struct;
  level.struct = [];

  for(var_1 = 0; var_1 < var_2.size; var_1++) {
    if(isDefined(var_2[var_1])) {
      level.struct[level.struct.size] = var_2[var_1];
    }
  }
}

function ref_145ED(var_0, var_1, var_2) {
  getentitylessscriptablearray("dlog_event_cp_runtime_struct_data", ["key", var_0, "pair", var_1, "count", var_2]);
}

function waypoint_init() {
  if(level.splitscreen) {
    level.waypoint_size = 15;
  } else {
    level.waypoint_size = 8;
  }

  level.waypoint_alpha = 0.75;
  level.waypoint_index = 0;
}

function findboxcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

function init_global_cp_flags() {
  scripts\engine\utility::flag_init("strike_init_done");
  scripts\engine\utility::flag_init("infil_complete");
  scripts\engine\utility::flag_init("introscreen_over");
  scripts\engine\utility::flag_init("interactions_initialized");
  scripts\engine\utility::flag_init("level_ready_for_script");
  scripts\engine\utility::flag_init("player_spawned_with_loadout");
  thread ref_130F0();
}

function ref_130F0() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait_all("strike_init_done", "infil_complete", "introscreen_over", "interactions_initialized");
  scripts\engine\utility::flag_set("level_ready_for_script");
}

function setdefaultleveldata() {
  level.splitscreen = issplitscreen();
  level.onlinegame = getdvarint("onlinegame");
  level.playerxpenabled = level.onlinegame;
  level.rankedmatch = level.onlinegame && !getdvarint("xblive_privatematch") || getdvarint("force_ranking");
  level.script = tolower(getDvar("mapname"));
  level.mapname = scripts\cp_mp\utility\game_utility::getmapname();
  level.gametype = tolower(getDvar("ui_gametype"));
  level.otherteam["allies"] = "axis";
  level.otherteam["axis"] = "allies";
  level.multiteambased = 0;
  level.teambased = 1;
  level.func = [];
  level.createfx_enabled = getDvar("createfx") != "";
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.hardcoremode = 0;
  level.numgametypereservedobjectives = 0;
  level.reclaimedreservedobjectives = [];
  level.date = scripts\cp\utility::get_actual_time_from_civil(8);
  level.default_goalradius = 2048;
  level.path_node_table = "cp/cp_path_node_table.csv";
  init_create_script();
}

function setdefaultdvars() {
  setDvar("ui_inhostmigration", 0);
  setDvar("camera_thirdPerson", getdvarint("scr_thirdPerson"));
  setDvar("bg_compassShowEnemies", getDvar("scr_game_forceuav"));
  setDvar("isMatchMakingGame", scripts\cp\utility::matchmakinggame());
  setDvar("ui_overtime", 0);
  setDvar("ui_allow_teamchange", 1);
  setDvar("g_deadChat", 1);
  setDvar("min_wait_for_players", 5);
  setDvar("ui_friendlyfire", 0);
  setDvar("cg_drawFriendlyHUDGrenades", 0);
  setDvar("cg_drawCrosshair", scripts\engine\utility::ter_op(level.hardcoremode == 1, 0, 1));
  setDvar("cg_drawCrosshairNames", 1);
  setDvar("cg_drawFriendlyNamesAlways", 0);
  setDvar("scr_print_dialogue_alias", 0);
  setDvar("mantle_force_legacy_system", 1);
  setDvar("scr_init_cs_files", "");
  setdvarifuninitialized("scr_slowmo", "");
}

function setupcallbacks() {
  level.callbackstartgametype = &coopstartgametype;
  level.frontend4 = &blank;
  level.callbackplayerconnect = &defaultplayerconnect;
  level.callbackplayerdisconnect = &defaultplayerdisconnect;
  level.callbackplayerdamage = &defaultplayerdamage;
  level.callbackplayerimpaled = &callback_agent_impaled;
  level.callbackplayerkilled = &defaultplayerkilled;
  level.callbackplayermigrated = &defaultplayermigrated;
  level.callbackhostmigration = &defaulthostmigration;
  level.getspawnpoint = &defaultgetspawnpoint;
  level.onspawnplayer = &blank;
  level.onprecachegametype = &blank;
  level.onstartgametype = &blank;
  level.playermaxhealth = &defaultplayermaxhealth;
  level.playerinitinvulnerability = &player_init_invulnerability;
  level.spawnplayerfunc = &spawnplayer;
  level.enterspectatorfunc = &enterspectator;
  level.intermissionfunc = &spawnintermission;
  level.getkilltriggerspawnloc = &getkilltriggerspawnloc;
  level.initagentscriptvariables = &scripts\cp\cp_agent_utils::initagentscriptvariables;
  level.setagentteam = &scripts\cp\cp_agent_utils::set_agent_team;
  level.agentvalidateattacker = &scripts\cp\cp_agent_utils::validateattacker;
  level.agentfunc = &scripts\cp\cp_agent_utils::agentfunc;
  level.getfreeagent = &scripts\cp\cp_agent_utils::getfreeagent;
  level.addtocharactersarray = &scripts\cp\cp_agent_utils::addtocharactersarray;
  level.callbackplayerlaststand = &scripts\cp\helicopter\utility::callback_defaultplayerlaststand;
  level.endgame = &scripts\cp\cp_endgame::ref_13445;
  level.forceendgame = &scripts\cp\cp_endgame::ref_13446;
}

function loadglobalfx() {
  level._effect["slide_dust"] = loadfx("vfx/core/screen/vfx_scrnfx_tocam_slidedust_m");
}

function defaultplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {}

function defaultplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

function watchslowmo() {
  for(;;) {
    if(getDvar("scr_slowmo") != "") {
      break;
    }

    wait 1;
  }

  var_0 = getdvarfloat("scr_slowmo");
  setslowmotion(var_0, var_0, 0);
  thread watchslowmo();
}

function callback_agent_impaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread impale(var_0, self, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

function impale(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(level.harpoon_impale_additional_func)) {
    [[level.harpoon_impale_additional_func]](var_2, var_0, var_1, var_4, var_5, var_6, var_7, var_8);
    return;
  }

  var_1 startragdoll();
  var_9 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
  var_10 = var_4 + var_5 * 4096;
  var_11 = scripts\engine\trace::ray_trace_detail(var_4, var_10, undefined, var_9, undefined, 1);
  var_10 = var_11["position"] - var_5 * 12;
  var_12 = length(var_10 - var_4);
  var_13 = var_12 / 1250;
  var_13 = clamp(var_13, 0.05, 1);
  wait 0.05;
  var_14 = var_5;
  var_15 = anglestoup(var_0.angles);
  var_16 = vectorcross(var_14, var_15);
  var_17 = scripts\engine\utility::spawn_tag_origin(var_4, axistoangles(var_14, var_16, var_15));
  var_17 moveTo(var_10, var_13);
  var_18 = spawnragdollconstraint(var_1, var_6, var_7, var_8);
  var_18.origin = var_17.origin;
  var_18.angles = var_17.angles;
  var_18 linkTo(var_17);
  thread impale_cleanup(var_1, var_17, var_13 + 0.05, var_18);
}

function impale_cleanup(var_0, var_1, var_2, var_3) {
  var_0 scripts\engine\utility::ref_143BA(var_2, "death", "disconnect");
  var_3 delete();
  var_1 delete();
}

function setupexplodertriggers() {}

function specialentitymonitor() {
  thread trackgrenades();
  thread trackmissiles();
  thread trackcarepackages();
}

function trackgrenades() {
  for(;;) {
    level.grenades = getEntArray("grenade", "classname");
    wait 0.05;
  }
}

function trackmissiles() {
  for(;;) {
    level.missiles = getEntArray("rocket", "classname");
    wait 0.05;
  }
}

function trackcarepackages() {
  for(;;) {
    level.carepackages = getEntArray("care_package", "targetname");
    wait 0.05;
  }
}

function defaultplayermaxhealth() {
  if(istrue(self.keep_perks)) {
    if(scripts\cp\utility::has_zombie_perk("perk_machine_tough")) {
      return 200;
    }

    return 180;
  }

  return 180;
}

function setdefaultgameparameters() {
  game["thermal_vision"] = "thermal_mp";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["clientid"] = 0;
  game["state"] = "playing";
  game["status"] = "normal";
}

function setdefaultvisionset() {
  visionsetnaked("", 0);
  visionsetnight("default_night_mp");
  visionsetmissilecam("missilecam");
  visionsetthermal(game["thermal_vision"]);
  visionsetpain("pain_mp", 0);
}

function setdefaultjiprules() {
  setnojipscore(0, 1);
  setnojiptime(0, 1);
}

function defaultgetspawnpoint() {
  return getassignedspawnpoint(scripts\engine\utility::getStructArray("default_player_start", "targetname"));
}

function getassignedspawnpoint(var_0) {
  var_1 = self getentitynumber();
  return var_0[var_1];
}

function defaultendgame() {
  level.gameended = 1;
  setomnvar("allow_server_pause", 0);
  level notify("game_ended", "allies");
  wait 0.05;
  exitlevel(0);
}

function coopstartgametype() {
  [[level.onprecachegametype]]();
  thread monitor_num_players();
  resetlevelflags();
  resetlevelarrays();

  if(isDefined(level.scripted_spawner_func)) {
    level.cs_creation_counter = 0;

    if(isarray(level.scripted_spawner_func)) {
      foreach(var_1 in level.scripted_spawner_func) {
        [[var_1]](1, "cs" + var_2);
      }
    } else if(istrue(level.threadedscriptspawners)) {
      [[level.scripted_spawner_func]](1);
    } else {
      [[level.scripted_spawner_func]]();
    }
  }

  scripts\cp\cp_analytics::ref_119B9();
  scripts\cp\perks\cp_perks::initperks();
  scripts\cp\cp_weaponrank::init();
  thread scripts\cp\cp_powers::init();
  scripts\cp\cp_merits::init();
  thread runprematch();
  thread graceperiodmonitor();
  scripts\cp\cp_aiparachute::strict_ff_enable();
  sysprint("Ready for Compass");
  thread startgame();
  level thread scripts\mp\mp_agent::init_spawn_times();
  level thread scripts\cp\cp_mapselect::init();

  if(!istrue(level.dev_build)) {
    scripts\cp\utility::add_demo_button_combo(["touchpad", "swap_weapon_release"], &demo_toggle_infiniteammo, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["touchpad", "swap_weapon", "swap_weapon_release"], &demo_toggle_infiniteammo, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["touchpad", "stance_release"], &demo_toggle_ufo, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["touchpad", "stance", "stance_release"], &demo_toggle_ufo, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["touchpad", "use_release"], &demo_toggle_godmode, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["touchpad", "use", "use_release"], &demo_toggle_godmode, undefined, 1);
  } else {
    scripts\cp\utility::add_demo_button_combo(["ads", "use", "A", "use_release", "A_release"], &scripts\cp\cp_modular_spawning::print_active_modules_to_screen, "Show Active Modules", 2);
  }

  game["gamestarted"] = 1;
  thread wait_for_strike_init_complete();
  scripts\cp\cp_agent_damage::register_ai_damage_callbacks();
  scripts\cp\cp_agent_damage::register_ai_drop_funcs();
}

function init_create_script() {
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
}

function wait_for_strike_init_complete() {
  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
    return;
  }
}

function resetlevelflags() {
  level.fauxvehiclecount = 0;
  level.gameended = 0;
  level.graceperiod = 10;
  level.ingraceperiod = level.graceperiod;
  level.noragdollents = getEntArray("noragdoll", "targetname");
  level.friendlyfire = 0;
  level.starttime = gettime();
  level.autoassignlowteamconsistent = -1;
}

function resetlevelarrays() {
  level.players = [];
  level.participants = [];
  level.characters = [];
  level.helis = [];
  level.turrets = [];
  level.ims = [];
  level.ugvs = [];
  level.balldrones = [];
  level.fake_players = [];
  level.demo_button_combos = [];
  thread scripts\common\utility::allow_init();
}

function runprematch() {
  level notify("coop_pre_match");
  level endon("coop_pre_match");
  level endon("game_ended");
  setomnvar("ui_prematch_period", 1);

  if(isDefined(level.prematchfunc)) {
    [[level.prematchfunc]]();
  }

  scripts\cp\utility::gameflagset("prematch_done");
  setomnvar("ui_prematch_period", 0);
}

function graceperiodmonitor() {
  level notify("coop_grace_period");
  level endon("game_ended");
  level endon("coop_grace_period");

  while(getactiveclientcount() == 0) {
    wait 0.05;
  }

  while(level.ingraceperiod > 0) {
    wait 1;
    level.ingraceperiod--;
  }

  level.ingraceperiod = 0;
}

function startgame() {
  [[level.onstartgametype]]();
}

function shouldverifydedicatedconfig() {
  return getDvar("dedicated") == "dedicated LAN server" || getDvar("dedicated") == "dedicated internet server";
}

function verifydedicatedconfiguration() {
  for(;;) {
    if(level.rankedmatch) {
      exitlevel(0);
    }

    if(!getdvarint("xblive_privatematch")) {
      exitlevel(0);
    }

    if(getDvar("dedicated") != "dedicated LAN server" && getDvar("dedicated") != "dedicated internet server") {
      exitlevel(0);
    }

    wait 5;
  }
}

function refreshuimatchinprogressomnvarvalue() {
  var_0 = 0;

  if(level.players.size > 1) {
    var_0 = 1;
  }

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_match_in_progress", var_0);
  }
}

function defaultplayerconnect() {
  self endon("disconnect");
  self.statusicon = "hud_status_connecting";
  self waittill("begin");
  self.statusicon = "";
  var_0 = gettime();
  level notify("connected", self);
  initplayersessionstats();
  setplayerconnectscriptfields();
  initclientdvars();
  setupsavedactionslots();
  initplayerperks();
  initlaststand();
  scripts\cp\cp_armor::armorinit(self);
  scripts\cp\perks\cp_prestige::initplayerprestige();
  scripts\cp\perks\cp_perks::init_each_perk();
  scripts\cp\cp_damage::initplayerdamagefunctions();
  self.no_team_outlines = 0;
  self.no_outline = 0;
  self.enemy_list = [];

  if(scripts\cp\utility::coop_mode_has("outline")) {
    thread scripts\cp\cp_outline::playeroutlinemonitor();
  }

  thread demo_allowed_debug_outline();
  thread scripts\cp\cp_vo::initandstartvosystem();
  thread scripts\cp\cp_merits::updatemerits();
  thread track_forward_velocity();
  self setclientomnvar("ui_scoreboard_freeze", 0);

  if(self ishost()) {
    level.player = self;
  }

  waittillframeend();
  addplayertolevelarrays(self);

  if(game["state"] == "postgame") {
    self.connectedpostgame = 1;
    self setclientdvars("cg_drawSpectatorMessages", 0);
    spawnintermission();
    return;
  }

  if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["think"])) {
    self thread[[level.bot_funcs["think"]]]();
  }

  level endon("game_ended");

  if(isDefined(level.hostmigrationtimer)) {
    thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();
  }

  if(isDefined(level.onplayerconnectaudioinit)) {
    [[level.onplayerconnectaudioinit]]();
  }

  if(!isai(self)) {
    playermonitor();
  }

  if(getdvarint("scr_playtest_munitions", 0)) {
    thread give_playtest_munitions();
  }

  spawnplayer();
}

function demo_allowed_debug_outline() {
  self endon("disconnect");
  thread demo_debug_outline_button_watcher();

  for(;;) {
    self waittill("demo_debug_outline");

    if(getdvarint("scr_demo_debug", 0)) {
      if(isDefined(level.debug_outline)) {
        setDvar("scr_show_teleport_reason", 0);
        level.debug_outline = undefined;
        scripts\cp\cp_outline::unset_outline();
        scripts\cp\cp_outline::restore_outline_settings();
        announcement("DEBUG - Outline Turned Off!");
        iprintln("DEBUG - Outline Turned Off!");
      } else {
        setDvar("scr_show_teleport_reason", 1);
        level.debug_outline = 1;
        scripts\cp\cp_outline::save_outline_settings();
        demo_debug_outline_settings();
        level thread scripts\cp\cp_outline::set_outline("outline_nodepth_red");
        announcement("DEBUG - Outline Turned On!");
        iprintln("DEBUG - Outline Turned On!");
      }

      wait 0.1;
      continue;
    }

    wait 1;
  }
}

function demo_toggle_godmode() {}

function demo_toggle_ufo() {}

function demo_toggle_infiniteammo() {
  var_0 = getdvarint("player_sustainAmmo", 0);

  if(var_0 == 0) {
    announcement("Infinite Ammo - On");
    var_0 = 1;
  } else {
    announcement("Infinite Ammo - Off");
    var_0 = 0;
  }

  setDvar("player_sustainAmmo", var_0);
}

function laststand_damage_shield() {
  var_0 = getaiarray("axis");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] kill(level.players[0].origin, level.players[0]);
  }
}

function demo_debug_outline_button_watcher() {
  self endon("disconnect");
  self notifyonplayercommand("first", "-actionslot 1");
  self notifyonplayercommand("second", "-actionslot 2");
  self notifyonplayercommand("third", "+usereload");

  for(;;) {
    var_0 = scripts\engine\utility::ref_143BF(2, "first");

    if(var_0 == "timeout") {
      continue;
    }

    var_0 = scripts\engine\utility::ref_143BF(2, "second");

    if(var_0 == "timeout") {
      continue;
    }

    var_0 = scripts\engine\utility::ref_143BF(2, "first");

    if(var_0 == "timeout") {
      continue;
    }

    var_0 = scripts\engine\utility::ref_143BF(2, "second");

    if(var_0 == "timeout") {
      continue;
    }

    var_0 = scripts\engine\utility::ref_143BF(2, "third");

    if(var_0 == "timeout") {
      continue;
    }

    self notify("demo_debug_outline");
    waitframe();
  }
}

function demo_debug_outline_settings() {
  setDvar("r_hudOutlineFillColor0", ".5 .5 .5 1");
  setDvar("r_hudOutlineFillColor1", "1 1 1 .2");
  setDvar("r_hudOutlineOccludedOutlineColor", "1 .25 .25 1");
  setDvar("r_hudOutlineOccludedInlineColor", ".7 .7 .7 1");
  setDvar("r_hudOutlineOccludedInteriorColor", "1 0 0 1");
  setDvar("r_hudOutlineOccludedColorFromFill", 1);
}

function track_forward_velocity() {
  self endon("disconnect");
  self waittill("spawned_player");
  self.velo_array = [];
  self.average_velo = (0, 0, 0);
  self.mag_array = [];
  self.average_mag = 0;
  self.velo_forward = self.origin;

  for(;;) {
    var_0 = self getvelocity();
    var_1 = [];
    var_2 = [1024 * min(length(var_0) / 240, 1)];

    if(var_0 != (0, 0, 0)) {
      var_1 = var_0;
    }

    var_3 = int(min(19, self.velo_array.size));
    var_4 = var_2[0];

    for(var_5 = 0; var_5 < var_3; var_5++) {
      var_1 = self.velo_array[var_5];
      var_2 = self.mag_array[var_5];
      var_4 += self.mag_array[var_5];
    }

    self.velo_array = var_1;
    self.mag_array = var_2;
    self.average_mag = var_4 / self.mag_array.size;

    if(self.velo_array.size > 0) {
      self.average_velo = calculate_average_velocity(self.velo_array);
    }

    var_6 = self getEye();
    self.velo_forward = self.origin + vectorNormalize(self.average_velo) * self.average_mag;
    wait 0.25;
  }
}

function calculate_average_velocity(var_0) {
  if(var_0.size == 1) {
    return var_0[0];
  }

  var_1 = var_0[0];

  for(var_2 = 1; var_2 < var_0.size; var_2++) {
    var_1 += var_0[var_2];
  }

  return var_1 / var_0.size;
}

function give_playtest_munitions() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 2;
  self.munition_splash_supress = 1;

  if(allow_munitions(self)) {
    scripts\cp\cp_munitions::give_munition_to_slot("ammo_crate", 1);
    scripts\cp\cp_munitions::give_munition_to_slot("armor", 2);
    scripts\cp\cp_munitions::give_munition_to_slot("grenade_crate", 3);
  }

  self.munition_splash_supress = undefined;
}

function allow_munitions(var_0) {
  if(isDefined(level.allow_munitions)) {
    return [[level.allow_munitions]](var_0);
  }

  return 1;
}

function playermonitor() {
  thread slidemonitor();
  thread forceendmonitor();
  setup_button_notifys();
  thread scripts\cp\cp_munitions::givemunitionfromluinotify();
  thread player_role_monitor(self);
  thread scripts\cp\cp_loadout::change_loadout_watcher(self);
}

function setplayerconnectscriptfields() {
  self.guid = scripts\cp\utility::getuniqueid();
  self.clientid = game["clientid"];
  game["clientid"]++;
  self.usingonlinedataoffline = self isusingonlinedataoffline();
  self.connected = 1;
  self.waitingtospawn = 0;
  self.movespeedscaler = 1;
  self.objectivescaler = 1;
  self.inlaststand = 0;
}

function initclientdvars() {
  initclientdvarssplitscreenspecific();
  self setclientdvars("cg_drawSpectatorMessages", 1, "cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0, "ui_altscene", 0);

  if(level.teambased) {
    self setclientdvar("cg_everyoneHearsEveryone", 0);
    return;
  }
}

function initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("cg_fovScale", "0.75");
    setDvar("r_materialBloomHQScriptMasterEnable", 0);
    return;
  }

  self setclientdvars("cg_fovScale", "1");
}

function setupsavedactionslots() {
  self.saved_actionslotdata = [];

  for(var_0 = 1; var_0 <= 4; var_0++) {
    self.saved_actionslotdata[var_0] = spawnStruct();
    self.saved_actionslotdata[var_0].type = "";
    self.saved_actionslotdata[var_0].item = undefined;
  }

  if(!self isconsoleplayer()) {
    for(var_0 = 5; var_0 <= 8; var_0++) {
      self.saved_actionslotdata[var_0] = spawnStruct();
      self.saved_actionslotdata[var_0].type = "";
      self.saved_actionslotdata[var_0].item = undefined;
    }

    return;
  }
}

function initplayerperks() {
  self.perks = [];
  self.perksperkname = [];
}

function slidemonitor() {
  self endon("disconnect");

  for(;;) {
    self waittill("sprint_slide_begin");
    self playFX(level._effect["slide_dust"], self getEye());
  }
}

function forceendmonitor() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "arcade_off") {
      self notify("adjustedStance");
    }

    if(var_0 == "end_game") {
      exitlevel(0);
    }
  }
}

function setup_button_notifys() {
  self setactionslot(1, "");
  self setactionslot(2, "");
  self setactionslot(3, "");
  self setactionslot(4, "");
  self notifyonplayercommand("D_pad_up", "+actionslot 1");
  self notifyonplayercommand("D_pad_down", "+actionslot 2");
  self notifyonplayercommand("D_pad_left", "+actionslot 3");
  self notifyonplayercommand("D_pad_right", "+actionslot 4");
}

function spawnintermission(var_0) {
  setglobalintermissionspawninfo();
  var_1 = self.forcespawnangles;
  spawnplayer();
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer()) {
    self setclientdvar("cg_fov", "90");
  }

  scripts\cp\utility::updatesessionstate("intermission");
}

function setglobalintermissionspawninfo() {
  var_0 = getglobalintermissionpoint();
  setforcespawninfo(var_0.origin, var_0.angles);
}

function setforcespawninfo(var_0, var_1) {
  self.forcespawnorigin = var_0;
  self.forcespawnangles = var_1;
}

function getglobalintermissionpoint() {
  var_0 = getEntArray("mp_global_intermission", "classname");
  return var_0[0];
}

function spawnplayer(var_0) {
  thread spawnplayer_internal(var_0);
}

function spawnplayer_internal(var_0) {
  level endon("game_ended");
  self notify("spawnPlayer_internal");
  self endon("spawnPlayer_internal");
  self endon("disconnect");
  self endon("joined_spectators");

  if(self.waitingtospawn) {
    return;
  }

  waitforspawn();
  spawnplayer_actual(var_0);
}

function waitforspawn() {
  self.waitingtospawn = 1;

  if(scripts\cp\utility::isusingremote()) {
    self waittill("stopped_using_remote");
  }

  self.waitingtospawn = 0;
}

function clearmatchhasmorethan1playervariablesonroundend() {
  game["numPlayersConsideredPlaying"] = 0;
  game["matchHasMoreThan1Player"] = 0;
}

function updatematchhasmorethan1playeromnvaronplayersfirstspawn() {
  if(!isDefined(game["numPlayersConsideredPlaying"])) {
    clearmatchhasmorethan1playervariablesonroundend();
  }

  var_0 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]++;

  if(!game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] > 1) {
      game["matchHasMoreThan1Player"] = 1;
    }
  }

  if(game["matchHasMoreThan1Player"]) {
    if(!var_0) {
      for(var_1 = 0; var_1 < level.players.size; var_1++) {
        level.players[var_1] setclientomnvar("match_has_more_than_1_player", 1);
      }
    } else {
      self setclientomnvar("match_has_more_than_1_player", 1);
    }
  }

  self.ref_11B20 = 1;
}

function updatematchhasmorethan1playeromnvaronplayerdisconnect() {
  if(istrue(self.ref_11B20)) {
    var_0 = game["matchHasMoreThan1Player"];
    game["numPlayersConsideredPlaying"]--;

    if(game["matchHasMoreThan1Player"]) {
      if(game["numPlayersConsideredPlaying"] <= 1) {
        game["matchHasMoreThan1Player"] = 0;
      }
    }

    if(!game["matchHasMoreThan1Player"]) {
      if(var_0) {
        for(var_1 = 0; var_1 < level.players.size; var_1++) {
          level.players[var_1] setclientomnvar("match_has_more_than_1_player", 0);
        }
      }
    }

    self.ref_11B20 = 0;
    return;
  }
}

function spawnplayer_actual(var_0) {
  self notify("spawned");
  self notify("started_spawnPlayer");

  if(istrue(var_0)) {
    if(level.gameended) {
      self spawn(getspawnorigin(self, 1), getspawnangles(self));
    } else {
      self.forcespawnangles = level.br_ac130.angles;
      self spawn(getspawnorigin(self, level.br_ac130.origin), getspawnangles(self));
      self playerhide();
      self.bspawningviaac130 = 1;
      var_0 = undefined;
    }
  } else if(level.gameended) {
    self spawn(getspawnorigin(self, 1), getspawnangles(self));
  } else {
    self spawn(getspawnorigin(self), getspawnangles(self));
  }

  resetplayerspawneffects();
  resetplayerspawnscriptfields();
  resetplayerdamagemodifiers();
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 0);

  if(!var_0) {
    nonfauxspawnsetup();
  }

  if(isai(self)) {
    spawnaihandler(var_0);
  }

  [[level.onspawnplayer]](var_0);

  if(istrue(self.bspawningviaac130)) {} else if(!scripts\cp\cp_endgame::gamealreadyended() && !istrue(var_0)) {}

  if(!var_0) {
    scripts\cp\cp_visionsets::create_visionset_stack(self);
  }

  if(var_0) {
    self[[level.custom_giveloadout]](var_0);
  }

  if(getdvarint("camera_thirdPerson")) {
    scripts\cp\utility::setthirdpersondof(1);
  }

  scripts\cp\utility::giveperk("specialty_pistoldeath");
  self painvisionon();
  waittillframeend();

  if(var_0) {
    self playerhide();
    scripts\cp\utility::allow_player_ignore_me(1);
  }

  if(!istrue(self.ref_11B20)) {
    updatematchhasmorethan1playeromnvaronplayersfirstspawn();
  }

  self notify("spawned_player");
  level notify("player_spawned", self);
  thread hudbooted();
  thread watch_target_health();
  thread allow_dvar_infammo();

  if(!scripts\cp\pvpe\pvpe::pvpe_enabled() || !istrue(level.dogtag_revive)) {
    if(!var_0) {
      thread respawn_on();
    }
  }

  thread scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_monitorplayerusability(self);
  thread abilityleft::claymore_crate_update_hint_logic_alt(self);

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    self.disable_super = 1;
  }

  self.no_outline = 0;
  self.no_team_outlines = 0;
  scripts\cp\utility::_unsetperk("specialty_spygame");
  scripts\cp\utility::_unsetperk("specialty_coldblooded");
  scripts\cp\utility::_unsetperk("specialty_noscopeoutline");
  scripts\cp\utility::_unsetperk("specialty_heartbreaker");
}

function respawn_on() {
  if(!isDefined(self.respawn_active)) {
    self.respawn_active = 1;
    self setclientomnvar("cp_team_respawn_display", 1);
    thread scripts\cp\respawn\cp_respawn::getcpcratedropcaststart();
    return;
  }
}

function override_nvg_with_extraction_on_dpad() {}

function hudbooted() {
  self endon("disconnect");
  resetplayerspawnomnvar();
}

function open_loadout_menu() {
  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    self waittill("open_loadout_menu");
    self setclientomnvar("ui_options_menu", 2);
    return;
  }
}

function resetplayerspawnomnvar() {
  self setclientomnvar("ui_hud_shake", 0);
  self setclientomnvar("ui_refresh_hud", 1);
  self setclientomnvar("zm_ui_player_in_laststand", 0);
  self setclientomnvar("ui_hide_minimap", 0);
  scripts\cp\utility::init_vehicle_omnvars();
}

function resetplayerspawneffects() {
  self stopshellshock();
  self stoprumble("damage_heavy");
  self setdepthoffield(0, 0, 512, 512, 4, 0);

  if(self isconsoleplayer()) {
    self setclientdvar("cg_fov", "65");
    return;
  }
}

function resetplayerdamagemodifiers() {
  if(isDefined(self.additivedamagemodifiers)) {
    var_0 = getarraykeys(self.additivedamagemodifiers);

    foreach(var_2 in var_0) {
      scripts\cp\utility::removedamagemodifier(var_2, 1);
    }
  }

  if(isDefined(self.multiplicativedamagemodifiers)) {
    var_0 = getarraykeys(self.multiplicativedamagemodifiers);

    foreach(var_2 in var_0) {
      scripts\cp\utility::removedamagemodifier(var_2, 0);
    }

    return;
  }
}

function resetplayerspawnscriptfields() {
  var_0 = getspawnteamassignment();
  self.team = var_0;
  self.sessionteam = getspawnsessionteamassignment(var_0);
  self.pers["team"] = var_0;
  self.fauxdead = undefined;
  self.movespeedscaler = 1;
  scripts\common\input_allow::clear_allow_info("weapon");
  scripts\common\input_allow::clear_allow_info("offhandWeaps");
  self.hasriotshieldequipped = 0;
  self.hasriotshield = 0;
}

function getspawnsessionteamassignment(var_0) {
  if(isDefined(level.playerspawnsessionteamassignmentfunc)) {
    return [[level.playerspawnsessionteamassignmentfunc]](self, var_0);
  }

  return var_0;
}

function getspawnteamassignment() {
  if(isDefined(level.playerspawnteamassignmentfunc)) {
    return [[level.playerspawnteamassignmentfunc]](self);
  }

  return "allies";
}

function nonfauxspawnsetup() {
  resetnonfauxspawnscriptfields();
  scripts\cp\utility::updatesessionstate("playing");
}

function resetnonfauxspawnscriptfields() {
  self.maxhealth = self[[level.playermaxhealth]]();
  self.health = self.maxhealth;
  self.avoidkillstreakonspawntimer = 5;
  self.friendlydamage = undefined;
  self.hasspawned = 1;
  self.spawntime = gettime();
  self.objectivescaler = 1;
}

function spawnaihandler(var_0) {
  if(!var_0) {
    if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["player_spawned"])) {
      self[[level.bot_funcs["player_spawned"]]]();
      return;
    }

    return;
  }
}

function getspawnorigin(var_0, var_1) {
  var_2 = undefined;
  var_3 = istrue(level.skip_nav_check_on_spectate_respawn);

  if(!var_3 && isDefined(var_0.forcespawnorigin)) {
    var_2 = var_0.forcespawnorigin;
    var_2 = getclosestpointonnavmesh(var_2);

    if(isDefined(var_1)) {
      var_2 = var_0.forcespawnorigin;
    }

    var_0.forcespawnorigin = undefined;
  } else {
    var_4 = var_0[[level.getspawnpoint]]();
    var_2 = scripts\engine\utility::ter_op(istrue(level.disable_start_spawn_on_navmesh), scripts\engine\utility::drop_to_ground(var_4.origin, 32, -100), getclosestpointonnavmesh(var_4.origin));

    if(isDefined(var_1)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function getspawnangles(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.forcespawnangles)) {
    var_1 = var_0.forcespawnangles;
    var_0.forcespawnangles = undefined;
  } else {
    var_2 = var_0[[level.getspawnpoint]]();
    var_1 = scripts\engine\utility::ter_op(isDefined(var_2.angles), var_2.angles, (0, 0, 0));
  }

  return var_1;
}

function shouldfreezeplayercontrolatspawn() {
  if(game["state"] == "postgame") {
    return true;
  }

  return false;
}

function enterspectator() {
  var_0 = getglobalintermissionpoint();
  self setspectatedefaults(var_0.origin, var_0.angles);
  setforcespawninfo(var_0.origin, var_0.angles);
  setspectaterules();
  scripts\cp\utility::updatesessionstate("spectator");
}

function setspectaterules() {
  if(isDefined(level.spectaterulesfunc)) {
    [[level.spectaterulesfunc]](self);
    return;
  }

  defaultspectaterules(self);
}

function defaultspectaterules(var_0) {
  var_0 allowspectateteam("allies", 1);
  var_0 allowspectateteam("axis", 1);
  var_0 allowspectateteam("freelook", 0);
  var_0 allowspectateteam("none", 1);
}

function defaultplayerdisconnect(var_0) {
  if(!isDefined(self.connected)) {
    return;
  }

  scripts\cp\cp_analytics::on_player_disconnect(var_0);
  removeplayerfromlevelarrays(self);

  if(disconnectshouldforceend()) {
    level thread[[level.forceendgame]]();
  }

  if(isDefined(level.onplayerdisconnect)) {
    level thread[[level.onplayerdisconnect]](self, var_0);
  }

  updatematchhasmorethan1playeromnvaronplayerdisconnect();
}

function disconnectshouldforceend() {
  if(level.splitscreen) {
    return (level.players.size <= 1);
  }

  var_0 = 0;

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      var_0 = scripts\cp\cp_laststand::gameshouldend(var_2);
    }
  }

  return var_0;
}

function addplayertolevelarrays(var_0) {
  level.players[level.players.size] = var_0;
  level.participants[level.participants.size] = var_0;
  level.characters[level.characters.size] = var_0;
}

function removeplayerfromlevelarrays(var_0) {
  level.players = scripts\engine\utility::array_remove(level.players, var_0);
  level.participants = scripts\engine\utility::array_remove(level.participants, var_0);
  level.characters = scripts\engine\utility::array_remove(level.characters, var_0);
}

function defaultplayermigrated() {
  if(self ishost()) {
    initclientdvarssplitscreenspecific();
  }

  if(ishumanplayer(self)) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(ishumanplayer(var_2)) {
        var_0++;
      }
    }

    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= var_0 * 2 / 3) {
      level notify("hostmigration_enoughplayers");
      return;
    }

    return;
  }
}

function ishumanplayer(var_0) {
  return !isbot(var_0) && !initmaxspeedforpathlengthtable(var_0);
}

function defaulthostmigration() {
  if(level.gameended) {
    return;
  }

  level.hostmigrationreturnedplayercount = 0;

  foreach(var_1 in level.characters) {
    var_1.hostmigrationcontrolsfrozen = 0;
  }

  level.hostmigrationtimer = 1;
  setDvar("ui_inhostmigration", 1);
  level notify("host_migration_begin");

  foreach(var_1 in level.characters) {
    if(isDefined(var_1)) {
      var_1 thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();
    }

    if(isPlayer(var_1)) {
      var_1 setclientomnvar("ui_session_state", var_1.sessionstate);
    }
  }

  setDvar("ui_game_state", game["state"]);
  level endon("host_migration_begin");
  scripts\cp\cp_hostmigration::hostmigrationwait();
  level.hostmigrationtimer = undefined;
  setDvar("ui_inhostmigration", 0);

  if(isDefined(level.hostmigrationend)) {
    level thread[[level.hostmigrationend]]();
  }

  level notify("host_migration_end");
}

function initdestructables() {
  var_0 = getEntArray("destructable", "targetname");

  if(getDvar("scr_destructables") == "0") {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_0[var_1] delete();
    }

    return;
  }

  for(var_1 = 0; var_1 < var_1.size; var_1++) {
    thread destructable_think();
  }
}

function destructable_think() {
  var_0 = 40;
  var_1 = 0;

  if(isDefined(self.script_accumulate)) {
    var_0 = self.script_accumulate;
  }

  if(isDefined(self.script_threshold)) {
    var_1 = self.script_threshold;
  }

  if(isDefined(self.script_fxid)) {
    self.fx = loadfx(self.script_fxid);
  }

  var_2 = 0;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_3, var_4);

    if(var_3 >= var_1) {
      var_2 += var_3;

      if(var_2 >= var_0) {
        thread destructable_destruct();
        return;
      }
    }
  }
}

function destructable_destruct() {
  var_0 = self;

  if(isDefined(var_0.fx)) {
    playFX(var_0.fx, var_0.origin + (0, 0, 6));
  }

  var_0 delete();
}

function inithud() {
  level.uiparent = spawnStruct();
  level.uiparent.horzalign = "left";
  level.uiparent.vertalign = "top";
  level.uiparent.alignx = "left";
  level.uiparent.aligny = "top";
  level.uiparent.x = 0;
  level.uiparent.y = 0;
  level.uiparent.width = 0;
  level.uiparent.height = 0;
  level.uiparent.children = [];
  level.fontheight = 12;
  level.hud["allies"] = spawnStruct();
  level.hud["axis"] = spawnStruct();
  level.primaryprogressbary = -61;
  level.primaryprogressbarx = 0;
  level.primaryprogressbarheight = 9;
  level.primaryprogressbarwidth = 120;
  level.primaryprogressbartexty = -75;
  level.primaryprogressbartextx = 0;
  level.primaryprogressbarfontsize = 1.2;
  level.teamprogressbary = 32;
  level.teamprogressbarheight = 14;
  level.teamprogressbarwidth = 192;
  level.teamprogressbartexty = 8;
  level.teamprogressbarfontsize = 1.65;
  level.lowertextyalign = "BOTTOM";
  level.lowertexty = -140;
  level.lowertextfontsize = 1.2;
}

function player_init_health_regen() {
  self.regenduration = 1;
}

function player_init_invulnerability() {
  self.haveinvulnerabilityavailable = 1;
}

function player_init_damageshield() {
  self.damageshieldexpiretime = gettime();
}

function blank(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

function initplayersessionstats() {
  self setplayerdata("cp", "alienSession", "team_shots", 0);
  self setplayerdata("cp", "alienSession", "team_kills", 0);
  self setplayerdata("cp", "alienSession", "team_hives", 0);
  self setplayerdata("cp", "alienSession", "downed", 0);
  self setplayerdata("cp", "alienSession", "hivesDestroyed", 0);
  self setplayerdata("cp", "alienSession", "prestigenerfs", 0);
  self setplayerdata("cp", "alienSession", "repairs", 0);
  self setplayerdata("cp", "alienSession", "drillPlants", 0);
  self setplayerdata("cp", "alienSession", "deployables", 0);
  self setplayerdata("cp", "alienSession", "challengesCompleted", 0);
  self setplayerdata("cp", "alienSession", "challengesAttempted", 0);
  self setplayerdata("cp", "alienSession", "trapKills", 0);
  self setplayerdata("cp", "alienSession", "currencyTotal", 0);
  self setplayerdata("cp", "alienSession", "currencySpent", 0);
  self setplayerdata("cp", "alienSession", "kills", 0);
  self setplayerdata("cp", "alienSession", "revives", 0);
  self setplayerdata("cp", "alienSession", "time", 0);
  self setplayerdata("cp", "alienSession", "score", 0);
  self setplayerdata("cp", "alienSession", "shots", 0);
  self setplayerdata("cp", "alienSession", "last_stand_count", 0);
  self setplayerdata("cp", "alienSession", "deaths", 0);
  self setplayerdata("cp", "alienSession", "headShots", 0);
  self setplayerdata("cp", "alienSession", "hits", 0);
  self setplayerdata("cp", "alienSession", "resources", 0);
  self setplayerdata("cp", "alienSession", "waveNum", 0);
}

function initlaststand() {
  if(isDefined(level.player_init_laststand_func)) {
    [[level.player_init_laststand_func]]();
    return;
  }

  scripts\cp\cp_laststand::default_player_init_laststand();
}

function initkilltriggerspawn() {
  level.killtriggerspawnlocs = scripts\engine\utility::getStructArray("respawn_edge", "targetname");
}

function getkilltriggerspawnloc() {
  return scripts\engine\utility::getclosest(self.origin, level.killtriggerspawnlocs);
}

function startagentstealth() {
  if(scripts\engine\utility::flag_exist("interactions_initialized")) {
    scripts\engine\utility::flag_wait("interactions_initialized");
    return;
  }

  wait 0.2;
}

function luinotifywatcherforcpsystems() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("stop_watch_for_LUINotifies");
  self endon("stop_watch_for_LUINotifies");
  var_0 = 0;

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(isDefined(var_1)) {
      switch (var_1) {
        case "disable_player_view":
          break;
        case "enable_player_view":
          break;
        case "skill_updated":
          scripts\cp\classes\cp_class_progression::giveskillpointsthruluinotify(var_2);
          break;
        case "dpad_slot_up":
          break;
        case "dpad_slot_right":
          scripts\cp\crafting_system::givecrafteditemthruluinotify(var_2);
          break;
      }
    }
  }
}

function playgestureforcraftingandskillpointstablet(var_0) {
  self endon("disconnect");

  if(!isDefined(var_0)) {
    return;
  }

  switch (var_0) {
    case 1:
      self forceplaygestureviewmodel("ges_hack_loop_end");
      break;
    case 0:
      self forceplaygestureviewmodel("ges_hack_loop");
      break;
  }

  scripts\common\utility::allow_fire(var_0);
  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_weapon_switch(var_0);
  scripts\common\utility::allow_usability(var_0);
  scripts\common\utility::allow_ads(var_0);
}

function player_role_monitor(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  wait 1;
  var_1 = 0;
  var_2 = 120;
  broadcast_status(var_0, 0);
  broadcast_role(var_0);

  for(;;) {
    waitframe();
    var_1 += 1;

    if(var_1 == var_2) {
      var_1 = 0;
      broadcast_role(var_0);
    }
  }
}

function broadcast_role(var_0) {
  var_1 = var_0 getentitynumber();
  var_2 = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "cpFieldUpgrade");
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var_1, "playerRole", var_2);
}

function broadcast_status(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var_2, "playerStatus", var_1);
}

function watch_target_health() {
  self endon("death");
  self endon("disconnect");
  self.targethealthinfo = [];

  for(;;) {
    var_0 = getdvarint("scr_enemy_healthbars", 0);

    if(var_0 == 1) {
      if(self adsButtonPressed()) {
        var_1 = self getEye();
        var_2 = self getplayerangles();
        var_3 = anglesToForward(var_2);
        var_4 = var_1 + var_3 * 10000;
        var_5 = scripts\engine\trace::_bullet_trace(var_1, var_4, 1, self, 0, 0, 0, 0, 0);
        var_6 = var_5["entity"];

        if(isDefined(var_6) && issentient(var_6) && !isPlayer(var_6)) {
          if(isDefined(var_6.team) && var_6.team == self.team) {
            wait 0.1;
            continue;
          }

          update_target_health_variable("ui_target_health", var_6.health);
          update_target_health_variable("ui_target_max_health", var_6.maxhealth);
          update_target_health_variable("ui_target_entity_num", var_6 getentitynumber());
        } else {
          update_target_health_variable("ui_target_entity_num", -1);
        }
      } else {
        update_target_health_variable("ui_target_entity_num", -1);
      }
    }

    wait 0.1;
  }
}

function update_target_health_variable(var_0, var_1) {
  wait 0.05;

  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(self.targethealthinfo[var_0]) || var_1 != self.targethealthinfo[var_0]) {
    self setclientomnvar(var_0, var_1);
    self.targethealthinfo[var_0] = var_1;
    return;
  }
}

function allow_dvar_infammo() {
  wait 5;

  if(getdvarint("scr_player_infammo", 0) == 0) {
    return;
  }

  var_0 = 0;

  while(var_0 < 30) {
    var_0++;

    if(!isDefined(level.infil_in_progress_buffer)) {
      break;
    }

    wait 2;
  }

  scripts\cp\coop_super::team_unlimited_ammo();
}

function monitor_num_players() {
  scripts\engine\utility::flag_init("player_count_determined");
  var_0 = getDvar("party_partyPlayerCountNum");

  if(var_0 != "1") {
    level.only_one_player = 0;
    scripts\engine\utility::flag_set("player_count_determined");
    return;
  }

  level.only_one_player = 1;
  scripts\engine\utility::flag_set("player_count_determined");

  while(!isDefined(level.players)) {
    wait 0.1;
  }

  for(;;) {
    if(level.players.size > 1) {
      break;
    }

    wait 1;
  }

  level.only_one_player = 0;
  level notify("multiple_players");
}

function shellshock_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "gasInterruptDelayFunc", &gas_getblurinterruptdelayms);
}

function gas_getblurinterruptdelayms(var_0) {
  return 200;
}

function delete_on_load() {
  scripts\engine\utility::array_delete(getEntArray("delete_on_load", "targetname"));
  scripts\engine\utility::delaythread(0.05, &scripts\engine\utility::array_delete, getEntArray("delete_on_firstframeend", "targetname"));
}