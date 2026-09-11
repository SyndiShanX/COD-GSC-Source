/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_globallogic.gsc
***********************************************/

function init() {
  level.struct_filter = &cp_struct_filter;
  level.ref_12d73 = "vfx/iw8/core/blima/vfx_blima_explosion.vfx";
  scripts\engine\utility::init_struct_class();
  clean_up_structs();
  delete_on_load();
  setdefaultleveldata();
  setdefaultdvars();
  setupcallbacks();
  scripts\cp\utility::initgameflags();
  scripts\cp\utility::initlevelflags();
  init_global_cp_flags();
  super_displayed();
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
  binoculars_addheadicon();
  scripts\common\fx::initfx();
  scripts\mp\callbacksetup::setupdamageflags();
  scripts\cp\cp_damagefeedback::init();
  scripts\cp\cp_movers::init();
  scripts\cp\coop_fx::main();
  scripts\cp\cp_merits::buildmeritinfo();
  scripts\cp\cp_endgame::init();
  scripts\cp\cp_laststand::init_laststand();
  scripts\cp\cp_loadout::init();
  scripts\cp\cp_create_script_utility::thermitestucktoshield();
  thread scripts\cp\cp_equipment::subway_car_move_think();

  if(shouldverifydedicatedconfig()) {
    thread verifydedicatedconfiguration();
  }

  level.leanthread = getdvarint("scr_runlean_playerthread_count", 0) == 1;
  level.script = tolower(getDvar("mapname"));
  level.gametype = tolower(getDvar("NKTMKRMSKR"));
  level.codcasterenabled = getdvarint("MOSNOQPOSS", 0) == 1;
  level.systemlink = getdvarint("LPSPMQSNPQ", 0) == 1;
  level.useperbullethitmarkers = getdvarint("OMRLPMMPRL", 0) == 1;
  level.splitscreen = issplitscreen();
  level.onlinegame = getdvarint("LTSNLQNRKO");
  level.rankedmatch = level.onlinegame || getdvarint("OSPNSPSKL");
  level.matchmakingmatch = level.onlinegame && !getdvarint("LSTLQTSSRM");
  level.playerxpenabled = level.matchmakingmatch || getdvarint("OSPNSPSKL");
  level.weaponxpenabled = level.playerxpenabled;
  level.challengesallowed = level.matchmakingmatch || getdvarint("OSPNSPSKL") || getdvarint("debug_challenges");
  level.enforceantiboosting = level.playerxpenabled || level.weaponxpenabled || level.challengesallowed;
  level.onlinestatsenabled = level.rankedmatch;
  level.starttimeutcseconds = getsystemtime();
  level.ref_12376 = getdvarint("LOPLPOKTOP", 0);
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
  thread scripts\cp\cp_analytics::initsegmentstats();
  level thread scripts\cp\cp_analytics::lootchopper_getattackerdata();
  thread scripts\cp_mp\xmike109::init();
  thread trackplayedtime();

  if(getdvarint("LLQQOPKTKM") != 1) {
    level thread scripts\cp\drone\emp_drone::init();
  }

  thread scripts\mp\mp_agent_damage::init();
  thread scripts\mp\ammorestock::init();
  scripts\mp\playeractions::addaction("mantle", &scripts\common\utility::allow_mantle);
  scripts\mp\playeractions::addaction("weapon_pickup", &scripts\common\utility::allow_weapon_pickup);
  level thread scripts\mp\sentientpoolmanager::init();
  level thread scripts\cp\cp_relics::init();
  level thread scripts\cp\cp_player_battlechatter::init();
  _calloutmarkerping_handleluinotify_cleared::ref_13a9e();
  level thread scripts\cp_mp\vehicles\vehicle::vehicle_init();
  scripts\cp_mp\utility\player_utility::temp_debug_wait_and_stop_music_loop();
  scripts\cp_mp\entityheadicons::init();
  level thread scripts\cp_mp\killstreaks\init::init();
  level thread scripts\cp_mp\emp_debuff::emp_debuff_init();
  level thread scripts\engine\scriptable_door::system_init();
  thread scripts\cp_mp\gestures::init();
  thread scripts\cp\gestures_cp::init_cp();

  if(!scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    level thread scripts\cp\respawn\cp_respawn::main();
  }

  level thread scripts\cp\extraction\cp_extraction::main();
  level thread scripts\cp_mp\execution::execution_init();
  level thread scripts\cp\equipment\cp_incendiarylauncher::strike_scriptorigincreate();

  if(getdvarint("scr_dogtag_revive", 0) != 0) {
    level.dogtag_revive = 1;
  }

  thread watchslowmo();
  scripts\common\utility::allow_add("gesture", &scripts\cp\utility\player::allow_gesture);
  scripts\common\utility::allow_add("supers", &scripts\common\utility::allow_supers);
  scripts\common\utility::allow_add("health_regen", &scripts\cp\utility\player::allow_health_regen);
  scripts\common\utility::allow_add("one_hit_melee_victim", &scripts\cp\utility\player::allow_one_hit_melee_victim);
  scripts\common\utility::allow_add("flashed", &scripts\cp\utility\player::allow_flashed);
  scripts\common\utility::allow_add("stunned", &scripts\cp\utility\player::allow_stunned);
  scripts\common\utility::allow_add("stick_kill", &scripts\cp\utility\player::allow_stick_kill);
  level.livescount = 1;
  scripts\common\utility::ref_13629();
}

function trackplayedtime() {
  level endon("game_ended");
  scripts\cp\utility::gameflagwait("prematch_done");

  while(!level.gameended) {
    wait 1;

    foreach(var1 in level.players) {
      trackplayedtimeupdate(var1);
    }
  }
}

function trackplayedtimeupdate() {
  if(isDefined(self.timeplayed)) {
    var0 = self.sessionteam;

    if(!isDefined(self.timeplayed[var0])) {
      self.timeplayed[var0] = 0;
    } else {
      self.timeplayed[var0]++;
    }

    if(var0 != "spectator" && var0 != "follower") {
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

function cp_struct_filter(var0) {
  if(!isDefined(level.struct_filter_kvps)) {
    level.struct_filter_kvps = [];
  }

  switch (var0.targetname) {
    case "lighttank_drop":
      return false;
  }

  level.struct_filter_kvps[var0.targetname] = var0.targetname;
  return true;
}

function clean_up_structs() {
  if(getDvar("NSQLTTMRMP") == "cp_landlord_2") {
    var0 = scripts\engine\utility::getStructArray("default_player_start", "targetname");
    var0[0].origin = (4143.57, 61393.6, 774.27);
    var0[0].angles = (0, 181.31, 0);
    var0[1].origin = (4134.67, 61466.8, 774.54);
    var0[1].angles = (0, 181.31, 0);
    var0[2].origin = (4140.57, 61429.5, 774.09);
    var0[2].angles = (0, 181.31, 0);
    var0[3].origin = (4144.67, 61338.1, 775.37);
    var0[3].angles = (0, 181.31, 0);
  }

  if(isDefined(level.struct_filter_kvps)) {
    level.struct_filter_kvps = undefined;
  }

  var1 = level.struct;
  level.struct = [];

  for(var2 = 0; var2 < var1.size; var2++) {
    if(isDefined(var1[var2])) {
      level.struct[level.struct.size] = var1[var2];
    }
  }
}

function ref_145ed(var0, var1, var2) {
  getentitylessscriptablearray("dlog_event_cp_runtime_struct_data", ["key", var0, "pair", var1, "count", var2]);
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

function findboxcenter(var0, var1) {
  var2 = (0, 0, 0);
  var2 = var1 - var0;
  var2 = (var2[0] / 2, var2[1] / 2, var2[2] / 2) + var0;
  return var2;
}

function init_global_cp_flags() {
  scripts\engine\utility::flag_init("level_stealth_initialized");
  scripts\engine\utility::flag_init("strike_init_done");
  scripts\engine\utility::flag_init("infil_complete");
  scripts\engine\utility::flag_init("introscreen_over");
  scripts\engine\utility::flag_init("interactions_initialized");
  scripts\engine\utility::flag_init("level_ready_for_script");
  scripts\engine\utility::flag_init("player_spawned_with_loadout");
  scripts\engine\utility::flag_init("ready_for_devgui");
  thread ref_130f0();
}

function super_displayed() {
  scripts\engine\utility::create_func_ref("create_script_init", &init_laser);
}

function ref_130f0() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait_all("strike_init_done", "infil_complete", "introscreen_over", "interactions_initialized");
  scripts\engine\utility::flag_set("level_ready_for_script");
}

function setdefaultleveldata() {
  level.splitscreen = issplitscreen();
  level.onlinegame = getdvarint("LTSNLQNRKO");
  level.playerxpenabled = level.onlinegame;
  level.rankedmatch = level.onlinegame && !getdvarint("LSTLQTSSRM") || getdvarint("OSPNSPSKL");
  level.script = tolower(getDvar("mapname"));
  level.mapname = scripts\cp_mp\utility\game_utility::getmapname();
  level.gametype = tolower(getDvar("MOLPOSLOMO"));
  level.otherteam["allies"] = "axis";
  level.otherteam["axis"] = "allies";
  level.multiteambased = 0;
  level.teambased = 1;
  level.func = [];
  level.createfx_enabled = getDvar("LSTTOTKPNP") != "";
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
  setDvar("NOSLRNTRKL", getdvarint("scr_thirdPerson"));
  setDvar("MPOKQNLPRM", getDvar("scr_game_forceuav"));
  setDvar("isMatchMakingGame", scripts\cp\utility::matchmakinggame());
  setDvar("ui_overtime", 0);
  setDvar("ui_allow_teamchange", 1);
  setDvar("SLLNLPRON", 1);
  setDvar("MSKKKKOPKS", 5);
  setDvar("ui_friendlyfire", 0);
  setDvar("LMQOKPRSML", 0);
  setDvar("LOPKSRNTTS", scripts\engine\utility::ter_op(level.hardcoremode == 1, 0, 1));
  setDvar("LROTSRRQMQ", 1);
  setDvar("NKMOPQSPMO", 0);
  setDvar("scr_print_dialogue_alias", 0);
  setDvar("scr_init_cs_files", "");
  setDvar("LSQQNTRKKL", defaultplayermaxhealth());
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
  level.callbackplayerlaststand = &scripts\cp\cp_laststand::callback_defaultplayerlaststand;
  level.endgame = &scripts\cp\cp_endgame::endgame;
  level.forceendgame = &scripts\cp\cp_endgame::forceendgame;

  if(getDvar("MOLPOSLOMO") == "cp_survival") {
    level.intermissionfunc = &spawnintermission;
    return;
  }
}

function loadglobalfx() {
  level._effect["slide_dust"] = loadfx("vfx/core/screen/vfx_scrnfx_tocam_slidedust_m");
}

function defaultplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {}

function defaultplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {}

function watchslowmo() {
  var0 = "";

  for(;;) {
    if(getDvar("scr_slowmo", var0) != var0) {
      break;
    }

    wait 1;
  }

  var1 = getdvarfloat("scr_slowmo");
  setslowmotion(var1, var1, 0);
  thread watchslowmo();
}

function callback_agent_impaled(var0, var1, var2, var3, var4, var5, var6, var7) {
  thread impale(var0, self, var1, var2, var3, var4, var5, var6, var7);
}

function impale(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(isDefined(level.harpoon_impale_additional_func)) {
    [[level.harpoon_impale_additional_func]](var2, var0, var1, var4, var5, var6, var7, var8);
    return;
  }

  var1 startragdoll();
  var9 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
  var10 = var4 + var5 * 4096;
  var11 = scripts\engine\trace::ray_trace_detail(var4, var10, undefined, var9, undefined, 1);
  var10 = var11["position"] - var5 * 12;
  var12 = length(var10 - var4);
  var13 = var12 / 1250;
  var13 = clamp(var13, 0.05, 1);
  wait 0.05;
  var14 = var5;
  var15 = anglestoup(var0.angles);
  var16 = vectorcross(var14, var15);
  var17 = scripts\engine\utility::spawn_tag_origin(var4, axistoangles(var14, var16, var15));
  var17 moveTo(var10, var13);
  var18 = spawnragdollconstraint(var1, var6, var7, var8);
  var18.origin = var17.origin;
  var18.angles = var17.angles;
  var18 linkTo(var17);
  thread impale_cleanup(var1, var17, var13 + 0.05, var18);
}

function impale_cleanup(var0, var1, var2, var3) {
  var0 scripts\engine\utility::ref_143ba(var2, "death", "disconnect");
  var3 delete();
  var1 delete();
}

function setupexplodertriggers() {
  var0 = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_damage"];

  foreach(var2 in var0) {
    var3 = getEntArray(var2, "classname");

    for(var4 = 0; var4 < var3.size; var4++) {
      if(isDefined(var3[var4].script_prefab_exploder)) {
        var3[var4].script_exploder = var3[var4].script_prefab_exploder;
      }

      if(isDefined(var3[var4].script_exploder)) {
        thread exploder_load(level);
      }
    }
  }
}

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

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    visionsetpain("pain_mp_night", 0);
    return;
  }

  visionsetpain("pain_mp", 0);
}

function setdefaultjiprules() {
  setnojipscore(0, 1);
  setnojiptime(0, 1);
}

function defaultgetspawnpoint() {
  return getassignedspawnpoint(scripts\engine\utility::getStructArray("default_player_start", "targetname"));
}

function getassignedspawnpoint(var0) {
  var1 = self getentitynumber();
  return var0[var1];
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
  scripts\cp\cp_create_script_utility::thirtypercent_music();
  scripts\cp\cp_analytics::ref_119b9();
  scripts\cp\perks\cp_perks::initperks();
  scripts\cp\cp_weaponrank::init();
  thread scripts\cp\cp_powers::init();
  scripts\cp\cp_merits::init();
  thread runprematch();
  thread graceperiodmonitor();
  scripts\cp\cp_aiparachute::strict_ff_enable();
  sysprint("Ready for Compass");
  scripts\mp\flags::levelflaginit("game_over", 0);
  thread startgame();
  level thread scripts\mp\mp_agent::init_spawn_times();
  level thread scripts\cp\cp_mapselect::init();
  level thread scripts\cp\cp_vehicles::coopvehicles_init();
  level scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&getcoremapdropzones);

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
  level.vehicle_mp_create = &vehicle_lights_manager;
}

function vehicle_lights_manager() {}

function init_laser() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
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
    level endon("game_ended");
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\cp\coop_stealth::weapon_xp_iw8_sn_kilo98()) {
    scripts\mp\vehicles\cargo_truck_mg_mp::main();
    scripts\engine\utility::flag_set("level_stealth_initialized");
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

    if(!getdvarint("LSTLQTSSRM")) {
      exitlevel(0);
    }

    if(getDvar("dedicated") != "dedicated LAN server" && getDvar("dedicated") != "dedicated internet server") {
      exitlevel(0);
    }

    wait 5;
  }
}

function refreshuimatchinprogressomnvarvalue() {
  var0 = 0;

  if(level.players.size > 1) {
    var0 = 1;
  }

  foreach(var2 in level.players) {
    var2 setclientomnvar("ui_match_in_progress", var0);
  }
}

function defaultplayerconnect() {
  self endon("disconnect");
  self.statusicon = "hud_status_connecting";
  self waittill("begin");
  self.statusicon = "";
  var0 = gettime();
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
  self.cargo_truck_mg_gunnerdamagemodignorefunc = 0;
  thread ref_13203();

  if(scripts\cp\utility::coop_mode_has("outline")) {
    thread scripts\cp\cp_outline::playeroutlinemonitor();
  }

  thread demo_allowed_debug_outline();
  thread scripts\cp\cp_vo::initandstartvosystem();
  thread scripts\cp\cp_merits::updatemerits();
  thread scripts\cp\utility\auto_ascender_ai::ref_145bd();
  thread track_forward_velocity();
  self.pers["matchdataWeaponStats"] = [];
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

  scripts\cp_mp\utility\game_utility::startkeyearning();
  spawnplayer();
}

function getcoremapdropzones() {
  if(!isalive(self)) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(istrue(self.inlaststand)) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(istrue(self.being_revived)) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(istrue(self.isreviving)) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(self isreloading()) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(istrue(self.binvehicle)) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(self isonladder()) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(self issprintsliding()) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(self issupersprinting()) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(self isjumping()) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(self isgestureplaying()) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(self isviewmodelanimplaying()) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(self isthrowinggrenade()) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(self isparachuting()) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(self isinfreefall()) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(istrue(self.isjuggernaut)) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(self islinked()) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  if(!self isonground()) {
    scripts\cp_mp\execution::disableexecutionattackwrapper();
    return;
  }

  scripts\cp_mp\execution::enableexecutionattackwrapper();
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
  var0 = getdvarint("player_sustainAmmo", 0);

  if(var0 == 0) {
    announcement("Infinite Ammo - On");
    var0 = 1;
  } else {
    announcement("Infinite Ammo - Off");
    var0 = 0;
  }

  setDvar("player_sustainAmmo", var0);
}

function laststand_damage_shield() {
  var0 = getaiarray("axis");

  for(var1 = 0; var1 < var0.size; var1++) {
    var0[var1] kill(level.players[0].origin, level.players[0]);
  }
}

function demo_debug_outline_button_watcher() {
  self endon("disconnect");
  self notifyonplayercommand("first", "-actionslot 1");
  self notifyonplayercommand("second", "-actionslot 2");
  self notifyonplayercommand("third", "+usereload");

  for(;;) {
    var0 = scripts\engine\utility::ref_143bf(2, "first");

    if(var0 == "timeout") {
      continue;
    }

    var0 = scripts\engine\utility::ref_143bf(2, "second");

    if(var0 == "timeout") {
      continue;
    }

    var0 = scripts\engine\utility::ref_143bf(2, "first");

    if(var0 == "timeout") {
      continue;
    }

    var0 = scripts\engine\utility::ref_143bf(2, "second");

    if(var0 == "timeout") {
      continue;
    }

    var0 = scripts\engine\utility::ref_143bf(2, "third");

    if(var0 == "timeout") {
      continue;
    }

    self notify("demo_debug_outline");
    waitframe();
  }
}

function demo_debug_outline_settings() {
  setDvar("LRMPROLMKN", ".5 .5 .5 1");
  setDvar("NTOSKSTKQQ", "1 1 1 .2");
  setDvar("NSNOLMTLLL", "1 .25 .25 1");
  setDvar("LSRTPRNOLS", ".7 .7 .7 1");
  setDvar("LNNOSQKRTP", "1 0 0 1");
  setDvar("RKSQOKQNK", 1);
}

function ref_13203() {
  self notify("setup_player_stealth");
  self endon("setup_player_stealth");
  self endon("disconnect");
  self waittill("spawned_player");

  if(scripts\cp\coop_stealth::weapon_xp_iw8_sn_kilo98()) {
    scripts\engine\utility::flag_wait("level_stealth_initialized");
    scripts\stealth\player::main();
    scripts\engine\utility::ent_flag_clear("stealth_use_real_lighting");
    thread scripts\cp\coop_stealth::ref_139bf();
    thread scripts\cp\coop_stealth::ref_13b3a();
    return;
  }
}

function track_forward_velocity() {
  self notify("track_forward_velocity");
  self endon("track_forward_velocity");
  self endon("disconnect");
  self waittill("spawned_player");
  self.velo_array = [];
  self.average_velo = (0, 0, 0);
  self.mag_array = [];
  self.average_mag = 0;
  self.velo_forward = self.origin;
  self.ref_14288 = [];
  var0 = 0;
  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = undefined;

  for(;;) {
    var5 = self getvelocity();
    var6 = [];
    var7 = [1024 * min(length(var5) / 240, 1)];
    var8 = [];

    if(var5 != (0, 0, 0)) {
      if(!isDefined(var4) || distance2dsquared(self.origin, var4) >= 62500) {
        var0 = 1;
        var1 = 1;
        var2 = 0;
        var3 = 0;
        var8 = self.origin;
        var6 = var5;
        var4 = self.origin;
      } else {
        var2++;
        var3++;

        if(var2 >= 12) {
          var2 = 0;
          var0 = 0;
        }

        if(var3 >= 5) {
          var3 = 0;
          var1 = 0;
        }
      }
    } else {
      var2++;
      var3++;

      if(var2 >= 12) {
        var2 = 0;
        var0 = 0;
      }

      if(var3 >= 5) {
        var3 = 0;
        var1 = 0;
      }
    }

    var9 = var7[0];
    var10 = int(min(20, self.velo_array.size));

    for(var11 = 0; var11 < var10; var11++) {
      if(!var0 && var11 + 1 >= var10) {
        var0 = 1;
        break;
      }

      var6 = self.velo_array[var11];
      var7 = self.mag_array[var11];
      var9 += self.mag_array[var11];
    }

    var12 = 5;

    if(isDefined(level.little_bird_mg_exitend)) {
      var12 = level.little_bird_mg_exitend;
    }

    var10 = int(min(var12, self.ref_14288.size));

    for(var11 = 0; var11 < var10; var11++) {
      if(!var1 && var11 + 1 >= var10) {
        var1 = 1;
        break;
      }

      var13 = var8.size;
      var8 = self.ref_14288[var11];
    }

    self.ref_14288 = var8;
    self.velo_array = var6;

    if(self.velo_array.size > 0) {
      self.average_velo = calculate_average_velocity(self.velo_array);
    }

    self.mag_array = var7;
    self.average_mag = var9 / self.mag_array.size;
    self.velo_forward = self.origin + vectorNormalize(self.average_velo) * self.average_mag;
    wait 0.5;
  }
}

function calculate_average_velocity(var0) {
  if(var0.size == 1) {
    return var0[0];
  }

  var1 = var0[0];

  for(var2 = 1; var2 < var0.size; var2++) {
    var1 += var0[var2];
  }

  return var1 / var0.size;
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

function allow_munitions(var0) {
  if(isDefined(level.allow_munitions)) {
    return [[level.allow_munitions]](var0);
  }

  return 1;
}

function playermonitor() {
  thread slidemonitor();
  thread forceendmonitor();
  setup_button_notifys();
  thread scripts\cp\cp_munitions::givemunitionfromluinotify();
  thread ref_12471(self);
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
  self setclientdvars("cg_drawSpectatorMessages", 1, "QKMSSSLPK", 0, "SKNSKQTQR", 1, "OLKRNORMOQ", 1, "LTLQSKRKQM", 0, "ui_altscene", 0);

  if(level.teambased) {
    self setclientdvar("LQKPQMPRQN", 0);
    return;
  }
}

function initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("NSSLSNKPN", "0.75");
    setDvar("r_materialBloomHQScriptMasterEnable", 0);
    return;
  }

  self setclientdvars("NSSLSNKPN", "1");
}

function setupsavedactionslots() {
  self.saved_actionslotdata = [];

  for(var0 = 1; var0 <= 4; var0++) {
    self.saved_actionslotdata[var0] = spawnStruct();
    self.saved_actionslotdata[var0].type = "";
    self.saved_actionslotdata[var0].item = undefined;
  }

  if(!self isconsoleplayer()) {
    for(var0 = 5; var0 <= 8; var0++) {
      self.saved_actionslotdata[var0] = spawnStruct();
      self.saved_actionslotdata[var0].type = "";
      self.saved_actionslotdata[var0].item = undefined;
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
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    if(var0 == "arcade_off") {
      self notify("adjustedStance");
    }

    if(var0 == "end_game") {
      level thread[[level.forceendgame]]();
      self notify("disconnect");
    }
  }
}

function setup_button_notifys() {
  self setactionslot(1, "");

  if(istrue(level.disable_nvg)) {
    self setactionslot(2, "");
  }

  self setactionslot(3, "");
  self setactionslot(4, "");
  self notifyonplayercommand("D_pad_up", "+actionslot 1");
  self notifyonplayercommand("D_pad_down", "+actionslot 2");
  self notifyonplayercommand("D_pad_left", "+actionslot 3");
  self notifyonplayercommand("D_pad_right", "+actionslot 4");
}

function spawnintermission(var0) {
  self endon("disconnect");
  setglobalintermissionspawninfo();
  var1 = self.forcespawnangles;
  self predictstreampos(self.forcespawnorigin, 1);
  wait 2;

  while(!self ispredictedstreamposready()) {
    wait 0.5;
  }

  spawnplayer();
  self setclientdvar("LQKPQMPRQN", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer()) {
    self setclientdvar("QTSPTNLOL", "90");
  }

  scripts\cp\utility::updatesessionstate("intermission");
}

function ref_13667(var0) {
  self visionsetnakedforplayer("flir_0_black_to_white", 0);
  self setclientdvar("LQKPQMPRQN", 1);
  scripts\cp\utility::updatesessionstate("intermission");
}

function setglobalintermissionspawninfo() {
  var0 = getglobalintermissionpoint();
  setforcespawninfo(var0.origin, var0.angles);
}

function setforcespawninfo(var0, var1) {
  self.forcespawnorigin = var0;
  self.forcespawnangles = var1;
}

function getglobalintermissionpoint() {
  var0 = getEntArray("mp_global_intermission", "classname");
  return var0[0];
}

function spawnplayer(var0) {
  thread spawnplayer_internal(var0);
}

function spawnplayer_internal(var0) {
  level endon("game_ended");
  self notify("spawnPlayer_internal");
  self endon("spawnPlayer_internal");
  self endon("disconnect");
  self endon("joined_spectators");

  if(self.waitingtospawn) {
    return;
  }

  waitforspawn();
  spawnplayer_actual(var0);
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

  var0 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]++;

  if(!game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] > 1) {
      game["matchHasMoreThan1Player"] = 1;
    }
  }

  if(game["matchHasMoreThan1Player"]) {
    if(!var0) {
      for(var1 = 0; var1 < level.players.size; var1++) {
        level.players[var1] setclientomnvar("match_has_more_than_1_player", 1);
      }
    } else {
      self setclientomnvar("match_has_more_than_1_player", 1);
    }
  }

  self.ref_11b20 = 1;
}

function updatematchhasmorethan1playeromnvaronplayerdisconnect() {
  if(istrue(self.ref_11b20)) {
    var0 = game["matchHasMoreThan1Player"];
    game["numPlayersConsideredPlaying"]--;

    if(game["matchHasMoreThan1Player"]) {
      if(game["numPlayersConsideredPlaying"] <= 1) {
        game["matchHasMoreThan1Player"] = 0;
      }
    }

    if(!game["matchHasMoreThan1Player"]) {
      if(var0) {
        for(var1 = 0; var1 < level.players.size; var1++) {
          level.players[var1] setclientomnvar("match_has_more_than_1_player", 0);
        }
      }
    }

    self.ref_11b20 = 0;
    return;
  }
}

function spawnplayer_actual(var0) {
  self notify("spawned");
  self notify("started_spawnPlayer");
  var1 = getDvar("restart_checkpoint");

  if(var1 != "") {
    var2 = scripts\mp\brclientmatchdata::getoperatorspecificaccessoryweapon(var1, "player_spawn");
    self.forcespawnorigin = var2.origin;
    self.getquestrewardstablevalue = var2;

    if(!isDefined(var2.angles)) {
      var2.angles = (0, 0, 0);
    }

    self.forcespawnangles = var2.angles;
    var2 thread scripts\mp\brclientmatchdata::getpreviousplacement(self);
  }

  if(istrue(var0)) {
    if(level.gameended) {
      self spawn(getspawnorigin(self, 1), getspawnangles(self));
    } else {
      self playerhide();
      self dontinterpolate();
      self.forcespawnangles = level.br_ac130.angles;
      thread scripts\cp\respawn\cp_respawn::ref_12768(0, 1.5, 1, "black");
      self setadditionalstreampos(level.br_ac130.origin);
      self cameraset("cam_orbit_br_ac130");
      self spawn(level.br_ac130.origin, level.br_ac130.ref_12205.angle);
      self playerhide();
      var0 = undefined;
      scripts\cp\respawn\cp_respawn::camera_setup_for_lerping(self, level.br_ac130);
    }
  } else if(level.gameended) {
    self spawn(getspawnorigin(self, 1), getspawnangles(self));
  } else {
    self spawn(getspawnorigin(self), getspawnangles(self));
  }

  resetplayerspawneffects();
  resetplayerspawnscriptfields();
  resetplayerdamagemodifiers();
  var0 = scripts\engine\utility::ter_op(isDefined(var0), var0, 0);

  if(!var0) {
    nonfauxspawnsetup();
  }

  if(level.gametype == "cp_survival" && !scripts\cp\utility::try_start_driving_func() && !istrue(level.dogtag_revive)) {
    if(!var0 && !istrue(self.bspawningviaac130)) {
      self setclientomnvar("ui_session_state", "spectator");
    }
  }

  if(isai(self)) {
    spawnaihandler(var0);
  }

  [[level.onspawnplayer]](var0);

  if(!var0) {
    scripts\cp\cp_visionsets::create_visionset_stack(self);
  }

  self[[level.custom_giveloadout]](var0, undefined, self.juggernautoutsidegoalradius);

  if(getdvarint("NOSLRNTRKL")) {
    scripts\cp\utility::setthirdpersondof(1);
  }

  scripts\cp\utility::giveperk("specialty_pistoldeath");
  self painvisionon();

  if(istrue(level.disable_nvg)) {
    self setactionslot(2, "");
  }

  self setactionslot(3, "altmode");
  self setclientomnvar("ui_hide_objectives", 0);
  waittillframeend();

  if(var0) {
    self playerhide();
    scripts\cp\utility::allow_player_ignore_me(1);
  }

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    if(!istrue(self.ref_11b20)) {
      updatematchhasmorethan1playeromnvaronplayersfirstspawn();
    }
  }

  self notify("spawned_player");
  level notify("player_spawned", self);
  thread hudbooted();
  thread watch_target_health();
  thread allow_dvar_infammo();

  if(!scripts\cp\pvpe\pvpe::pvpe_enabled() || !istrue(level.dogtag_revive)) {
    if(var0) {}
  }

  thread scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_monitorplayerusability(self);
  thread abilityleft::claymore_crate_update_hint_logic_alt(self);
  thread scripts\cp\perks\cp_perks::markedentities_think();

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    self.disable_super = 1;
  }

  self.no_outline = 0;
  self.no_team_outlines = 0;
  scripts\cp\utility::_unsetperk("specialty_spygame");
  scripts\cp\utility::_unsetperk("specialty_coldblooded");
  scripts\cp\utility::_unsetperk("specialty_noscopeoutline");
  scripts\cp\utility::_unsetperk("specialty_heartbreaker");

  if(istrue(self.bspawningviaac130)) {
    scripts\cp\cp_laststand::give_fists_if_no_real_weapon(self);
    return;
  }

  if(!scripts\cp\cp_endgame::gamealreadyended() && !istrue(var0)) {
    if(!scripts\cp\utility::turn_off_sniper_laser() && !istrue(self.unset_relic_oneclip)) {
      thread open_loadout_menu();
      scripts\engine\utility::ref_143a5("loadout_given", "start_hotjoining_via_c130");

      if(!istrue(self.ref_11b20)) {
        updatematchhasmorethan1playeromnvaronplayersfirstspawn();
      }

      if(isDefined(level.ref_127f6)) {
        self thread[[level.ref_127f6]]();
      }

      if(level.gametype == "cp_survival") {
        self setclientomnvar("ui_session_state", "playing");
        return;
      }

      return;
    }

    return;
  }
}

function respawn_on() {
  if(!isDefined(self.respawn_active)) {
    self.respawn_active = 1;
    self setclientomnvar("cp_team_respawn_display", 1);
    thread scripts\cp\respawn\cp_respawn::getcpcratedropcaststart();
    return;
  }
}

function override_nvg_with_extraction_on_dpad() {
  self.extraction_active = 1;
  thread scripts\cp\extraction\cp_extraction::extraction_function_toggle();
}

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
  self setclientomnvar("cp_super_fired", 0);
  var0 = self getentitynumber();
  setomnvar("cp_team_oriented_super_ended", var0);

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    self setclientomnvar("ui_hide_minimap", 0);
  } else {
    self setclientomnvar("ui_hide_minimap", 1);
  }

  scripts\cp\utility::init_vehicle_omnvars();
}

function resetplayerspawneffects() {
  self stopshellshock();
  self stoprumble("damage_heavy");
  self setdepthoffield(0, 0, 512, 512, 4, 0);

  if(self isconsoleplayer()) {
    self setclientdvar("QTSPTNLOL", "65");
    return;
  }
}

function resetplayerdamagemodifiers() {
  if(isDefined(self.additivedamagemodifiers)) {
    var0 = getarraykeys(self.additivedamagemodifiers);

    foreach(var2 in var0) {
      scripts\cp\utility::removedamagemodifier(var2, 1);
    }
  }

  if(isDefined(self.multiplicativedamagemodifiers)) {
    var0 = getarraykeys(self.multiplicativedamagemodifiers);

    foreach(var2 in var0) {
      scripts\cp\utility::removedamagemodifier(var2, 0);
    }

    return;
  }
}

function resetplayerspawnscriptfields() {
  var0 = getspawnteamassignment();
  self.team = var0;
  self.sessionteam = getspawnsessionteamassignment(var0);
  self.pers["team"] = var0;
  self.fauxdead = undefined;
  self.movespeedscaler = 1;
  scripts\common\input_allow::clear_allow_info("weapon");
  scripts\common\input_allow::clear_allow_info("offhandWeaps");
  self.hasriotshieldequipped = 0;
  self.hasriotshield = 0;
}

function getspawnsessionteamassignment(var0) {
  if(isDefined(level.playerspawnsessionteamassignmentfunc)) {
    return [[level.playerspawnsessionteamassignmentfunc]](self, var0);
  }

  return var0;
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

function spawnaihandler(var0) {
  if(!var0) {
    if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["player_spawned"])) {
      self[[level.bot_funcs["player_spawned"]]]();
      return;
    }

    return;
  }
}

function getspawnorigin(var0, var1) {
  var2 = undefined;
  var3 = istrue(level.skip_nav_check_on_spectate_respawn);

  if(isDefined(var0.forcespawnorigin)) {
    var2 = var0.forcespawnorigin;

    if(!var3) {
      var2 = getclosestpointonnavmesh(var2);
    }

    if(isDefined(var1)) {
      var2 = var0.forcespawnorigin;
    }

    var0.forcespawnorigin = undefined;
  } else {
    var4 = var0[[level.getspawnpoint]]();
    var2 = scripts\engine\utility::ter_op(istrue(level.disable_start_spawn_on_navmesh), scripts\engine\utility::drop_to_ground(var4.origin, 32, -100), getclosestpointonnavmesh(var4.origin));

    if(isDefined(var1)) {
      var2 = var4;
    }
  }

  return var2;
}

function getspawnangles(var0) {
  var1 = undefined;

  if(isDefined(var0.forcespawnangles)) {
    var1 = var0.forcespawnangles;
    var0.forcespawnangles = undefined;
  } else {
    var2 = var0[[level.getspawnpoint]]();
    var1 = scripts\engine\utility::ter_op(isDefined(var2.angles), var2.angles, (0, 0, 0));
  }

  return var1;
}

function shouldfreezeplayercontrolatspawn() {
  if(game["state"] == "postgame") {
    return true;
  }

  return false;
}

function enterspectator() {
  var0 = getglobalintermissionpoint();
  self setspectatedefaults(var0.origin, var0.angles);
  setforcespawninfo(var0.origin, var0.angles);
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

function defaultspectaterules(var0) {
  var0 allowspectateteam("allies", 1);
  var0 allowspectateteam("axis", 1);
  var0 allowspectateteam("freelook", 0);
  var0 allowspectateteam("none", 1);
}

function defaultplayerdisconnect(var0) {
  if(!isDefined(self.connected)) {
    return;
  }

  scripts\cp\cp_analytics::on_player_disconnect(var0);
  removeplayerfromlevelarrays(self);

  if(disconnectshouldforceend()) {
    ref_12c58();

    if(level.players.size == 0) {
      level thread scripts\cp\cp_endgame::endgame("axis", scripts\cp\cp_endgame::get_end_game_string_index("host_end"));
    } else {
      level thread scripts\cp\cp_endgame::endgame("axis", scripts\cp\cp_endgame::get_end_game_string_index("kia"));
    }
  }

  if(isDefined(level.onplayerdisconnect)) {
    level thread[[level.onplayerdisconnect]](self, var0);
  }

  updatematchhasmorethan1playeromnvaronplayerdisconnect();
  level notify("player_disconnect");
}

function disconnectshouldforceend() {
  if(level.splitscreen) {
    return (level.players.size <= 1);
  }

  if(level.players.size < 1) {
    return 1;
  }

  var0 = 0;

  foreach(var2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var2)) {
      var0 = scripts\cp\cp_laststand::gameshouldend(var2);
    }
  }

  return var0;
}

function addplayertolevelarrays(var0) {
  level.players[level.players.size] = var0;
  level.participants[level.participants.size] = var0;
  level.characters[level.characters.size] = var0;
}

function removeplayerfromlevelarrays(var0) {
  level.players = scripts\engine\utility::array_remove(level.players, var0);
  level.participants = scripts\engine\utility::array_remove(level.participants, var0);
  level.characters = scripts\engine\utility::array_remove(level.characters, var0);
}

function defaultplayermigrated() {
  if(self ishost()) {
    initclientdvarssplitscreenspecific();
  }

  if(ishumanplayer(self)) {
    var0 = 0;

    foreach(var2 in level.players) {
      if(ishumanplayer(var2)) {
        var0++;
      }
    }

    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= var0 * 2 / 3) {
      level notify("hostmigration_enoughplayers");
      return;
    }

    return;
  }
}

function ishumanplayer(var0) {
  return !isbot(var0) && !initmaxspeedforpathlengthtable(var0);
}

function defaulthostmigration() {
  if(level.gameended) {
    return;
  }

  level.hostmigrationreturnedplayercount = 0;

  foreach(var1 in level.characters) {
    var1.hostmigrationcontrolsfrozen = 0;
  }

  level.hostmigrationtimer = 1;
  setDvar("ui_inhostmigration", 1);
  level notify("host_migration_begin");

  foreach(var1 in level.characters) {
    if(isDefined(var1)) {
      var1 thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();
    }

    if(isPlayer(var1)) {
      var1 setclientomnvar("ui_session_state", var1.sessionstate);
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
  var0 = getEntArray("destructable", "targetname");

  if(getDvar("scr_destructables") == "0") {
    for(var1 = 0; var1 < var0.size; var1++) {
      var0[var1] delete();
    }

    return;
  }

  for(var1 = 0; var1 < var1.size; var1++) {
    thread destructable_think();
  }
}

function destructable_think() {
  var0 = 40;
  var1 = 0;

  if(isDefined(self.script_accumulate)) {
    var0 = self.script_accumulate;
  }

  if(isDefined(self.script_threshold)) {
    var1 = self.script_threshold;
  }

  if(isDefined(self.script_fxid)) {
    self.fx = loadfx(self.script_fxid);
  }

  var2 = 0;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var3, var4);

    if(var3 >= var1) {
      var2 += var3;

      if(var2 >= var0) {
        thread destructable_destruct();
        return;
      }
    }
  }
}

function destructable_destruct() {
  var0 = self;

  if(isDefined(var0.fx)) {
    playFX(var0.fx, var0.origin + (0, 0, 6));
  }

  var0 delete();
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

function exploder_load(var0) {
  level endon("killexplodertridgers" + var0.script_exploder);
  var0 waittill("trigger");

  if(isDefined(var0.script_chance) && randomfloat(1) > var0.script_chance) {
    if(isDefined(var0.script_delay)) {
      wait var0.script_delay;
    } else {
      wait 4;
    }

    thread exploder_load(level);
    return;
  }

  scripts\engine\utility::exploder(var0.script_exploder);
  level notify("killexplodertridgers" + var0.script_exploder);
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

function blank(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {}

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
  self setplayerdata("cp", "alienSession", "currency", 0);
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
  var0 = 0;

  for(;;) {
    self waittill("luinotifyserver", var1, var2);

    if(isDefined(var1)) {
      switch (var1) {
        case "disable_player_view":
          break;
        case "enable_player_view":
          break;
        case "skill_updated":
          scripts\cp\classes\cp_class_progression::giveskillpointsthruluinotify(var2);
          break;
        case "dpad_slot_up":
          break;
        case "dpad_slot_right":
          scripts\cp\crafting_system::givecrafteditemthruluinotify(var2);
          break;
      }
    }
  }
}

function playgestureforcraftingandskillpointstablet(var0) {
  self endon("disconnect");

  if(!isDefined(var0)) {
    return;
  }

  switch (var0) {
    case 1:
      self forceplaygestureviewmodel("ges_hack_loop_end");
      break;
    case 0:
      self forceplaygestureviewmodel("ges_hack_loop");
      break;
  }

  scripts\common\utility::allow_fire(var0);
  scripts\common\utility::allow_melee(var0);
  scripts\common\utility::allow_weapon_switch(var0);
  scripts\common\utility::allow_usability(var0);
  scripts\common\utility::allow_ads(var0);
}

function ref_12471(var0) {
  var0 endon("disconnect");
  level endon("game_ended");
  wait 1;
  var1 = 0;
  var2 = 120;

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    elevator_raise(var0);
  }

  broadcast_status(var0, 0);
  broadcast_role(var0);
  var3 = scripts\cp\utility::turn_off_sniper_laser();
  var4 = scripts\cp\utility::trialympic_fire();

  for(;;) {
    waitframe();
    var1 += 1;

    if(var1 == var2) {
      var1 = 0;
      broadcast_role(var0);

      if(var3) {
        waitframe();
        elevator_raise(var0);
        continue;
      }

      if(var4) {
        waitframe();
        elevator_model(var0);
      }
    }
  }
}

function elevator_raise(var0) {
  var1 = var0 getentitynumber();
  var2 = var0 getplayerdata("cp", "alienSession", "currency");
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var1, "currency", var2);
}

function broadcast_role(var0) {
  var1 = var0 getentitynumber();
  var2 = var0 getplayerdata(level.loadoutsgroup, "squadMembers", "cpFieldUpgrade");
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var1, "playerRole", var2);
}

function elevator_model(var0) {
  var1 = var0 getentitynumber();

  if(!isDefined(var0.get_track_setting)) {
    var0.get_track_setting = 0;
  }

  if(!isDefined(var0.get_track_end_struct)) {
    var0.get_track_end_struct = 0;
  }

  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var1, "carryItem2", var0.get_track_end_struct);
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var1, "carryItem", var0.get_track_setting);
}

function broadcast_status(var0, var1) {
  var2 = var0 getentitynumber();
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var2, "playerStatus", var1);
}

function watch_target_health() {
  self endon("death");
  self endon("disconnect");
  self.targethealthinfo = [];

  for(;;) {
    var0 = getdvarint("scr_enemy_healthbars", 0);

    if(var0 == 1) {
      if(self adsButtonPressed()) {
        var1 = self getEye();
        var2 = self getplayerangles();
        var3 = anglesToForward(var2);
        var4 = var1 + var3 * 10000;
        var5 = scripts\engine\trace::_bullet_trace(var1, var4, 1, self, 0, 0, 0, 0, 0);
        var6 = var5["entity"];

        if(isDefined(var6) && issentient(var6) && !isPlayer(var6)) {
          if(isDefined(var6.team) && var6.team == self.team) {
            wait 0.1;
            continue;
          }

          update_target_health_variable("ui_target_health", var6.health);
          update_target_health_variable("ui_target_max_health", var6.maxhealth);
          update_target_health_variable("ui_target_entity_num", var6 getentitynumber());
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

function update_target_health_variable(var0, var1) {
  wait 0.05;

  if(!isDefined(var1)) {
    return;
  }

  if(!isDefined(self.targethealthinfo[var0]) || var1 != self.targethealthinfo[var0]) {
    self setclientomnvar(var0, var1);
    self.targethealthinfo[var0] = var1;
    return;
  }
}

function allow_dvar_infammo() {
  wait 5;

  if(getdvarint("scr_player_infammo", 0) == 0) {
    return;
  }

  var0 = 0;

  while(var0 < 30) {
    var0++;

    if(!isDefined(level.infil_in_progress_buffer)) {
      break;
    }

    wait 2;
  }

  scripts\cp\coop_super::team_unlimited_ammo();
}

function monitor_num_players() {
  scripts\engine\utility::flag_init("player_count_determined");
  var0 = getDvar("NKSQNMMRRQ");

  if(var0 != "1") {
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

function gas_getblurinterruptdelayms(var0) {
  return 200;
}

function delete_on_load() {
  scripts\engine\utility::array_delete(getEntArray("delete_on_load", "targetname"));
  scripts\engine\utility::delaythread(0.05, &scripts\engine\utility::array_delete, getEntArray("delete_on_firstframeend", "targetname"));
}

function ref_12c58() {
  setDvar("restart_checkpoint", "");
  setDvar("cp_landlord_start_obj", "");
  setDvar("cp_arms_dealer_start_obj", "");
  setDvar("cp_smuggler_start_obj", "");
  setDvar("cp_dwn_twn_2_start_obj", "");
  setDvar("intro_vo", "");
}

function binoculars_addheadicon() {
  setDvar("heartbeatSensorEnemyDistanceWarningThreshold", 1500);
  setDvar("heartbeatSensorMaxDrawRange", 1800);
  setDvar("NLLRSSOQMQ", 1800);
  setDvar("NSKNMSMOLP", 1000);
  setDvar("NOQKLLMRO", 1800);
  setDvar("heartbeatSensorTabletSweepRadius", 500);
  setDvar("heartbeatSensorTabletIconSize", 60);
  setDvar("hearbeatSensorUseCurrentOrientation", 0);
}