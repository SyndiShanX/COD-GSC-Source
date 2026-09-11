/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_safehouse\cp_so_safehouse.gsc
***************************************************************/

function main() {
  setdvarifuninitialized("scr_use_squads", 1);
  setdvarifuninitialized("scr_squad_max", 4);
  setdvarifuninitialized("scr_squad_leader_max", 2);
  setdvarifuninitialized("scr_ai_squad_move_type", "1");
  setdvarifuninitialized("scr_smoketest", "0");
  setsaveddvar("MQPQKNPQOK", 2);
  setsaveddvar("MRNRKKOPLN", 2);
  setsaveddvar("NQTLPTNSSO", 3);
  setsaveddvar("OLSKLTPPMR", 0.7);
  setsaveddvar("LQLSPQOPKM", 50);
  setsaveddvar("NTMMTOLQMQ", (-550, 0, 0));
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  scripts\engine\utility::create_func_ref("set_vehicle_anims_umike", &scripts\cp\vehicle::ref_13119);
  scripts\engine\utility::create_func_ref("vehicle_damage_modifier", &scripts\cp\cp_vehicles::incrementobjectiveachievementkill);
  scripts\cp\maps\cp_so_safehouse\cp_so_safehouse_precache::main();
  scripts\cp\maps\cp_so_safehouse\gen\cp_so_safehouse_art::main();
  scripts\cp\maps\cp_so_safehouse\cp_so_safehouse_fx::main();
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
  level.map_interaction_func = &scripts\cp\maps\cp_so_safehouse\cp_so_safehouse_interactions::register_interactions;
  level.custom_onspawnplayer_func = &ref_124a6;
  level.custom_onplayerconnect_func = &onplayerconnect;
  level.weapon_rank_event_table = "scripts/cp/maps/cp_so_safehouse/cp_so_safehouse_weaponrank_event.csv";
  level.player_interaction_monitor = &scripts\cp\maps\cp_so_safehouse\cp_so_safehouse_interactions::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &scripts\cp\maps\cp_so_safehouse\cp_so_safehouse_interactions::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = &interaction_trigger_properties;
  level.strike_player_connect_black_screen_fn = &ref_1247b;
  level.mud_sfx = &mud_sfx;

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
  level.devgui_setup_func = &onplayerspawneddevguisetup;

  if(level.scripted_spawner_func.size < 1) {
    scripts\engine\utility::flag_set("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_init("infil_complete");
  }

  var_0 = getDvar("cp_so_safehouse_start_obj", "");

  if(isDefined(var_0) && var_0 != "") {
    thread rundebugstartobjective(level);
  }

  level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  scripts\cp\cp_compass::setupminimap("compass_map_cp_so_safehouse");
  scripts\engine\utility::flag_set("infil_complete");
  level.laststand_enter_gamemodespecificaction = &enter_laststand;
  level.laststand_exit_gamemodespecificaction = &exit_laststand;
  thread weapon_xp_iw8_sn_crossbow();
}

function mud_sfx(var_0) {
  if(var_0 == "axis") {
    return 0;
  }

  var_1 = 60000;

  if(level.time_survived < 8 * var_1) {
    return 3;
  } else if(level.time_survived < 10 * var_1) {
    return 2;
  } else if(level.time_survived < 16 * var_1) {
    return 1;
  }

  return 0;
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

function enter_laststand(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(var_4 != var_0 && !istrue(var_4.inlaststand)) {
      var_2 = var_4;
    }
  }

  if(var_2.size == 1) {
    ref_1243d(var_2[0], "dx_mpa_rutl_lastalive_revive", 5, 10);
  }

  if(scripts\engine\utility::is_equal(var_1, level.silo_thrust_dogtag_revive)) {
    level.silo_thrust_dogtag_revive.milestonephasepercent_lzs = var_0;

    foreach(var_4 in level.players) {
      var_7 = scripts\engine\utility::ter_op(var_4 == var_0, &"CP_SO_SAFEHOUSE/HELO_DOWNED_PLAYER", &"CP_SO_SAFEHOUSE/HELO_DOWNED_ALLY");
      thread logevent_kidnapevent(var_4, var_4, var_7);
    }
  }

  scripts\cp\gametypes\cp_specops::enter_laststand(var_0, var_1);
}

function exit_laststand(var_0) {
  scripts\cp\gametypes\cp_specops::exit_laststand_func(var_0);

  if(isDefined(var_0.min_dist_sq_from_node)) {
    var_0 switchtoweapon(var_0.min_dist_sq_from_node);
    var_0.min_dist_sq_from_node = undefined;
  }

  ref_1243d(var_0, "dx_mpa_rutl_gamestate_losing", 1, 5);
}

function init_loot_structs() {
  var_0 = spawnStruct();
  var_0.origin = (0, 0, 1000);
  var_0.angles = (0, 0, 0);
  var_0.name = "alpha";
  var_0.script_noteworthy = "infil_lbravo";
  var_0.script_team = "allies";
  var_0.spawnflags = int(1);
  var_0.targetname = "cp_infil";
  var_0.target = "infil_scene";
  level.struct_class_names["targetname"]["cp_infil"] = [var_0];
  var_0 = spawnStruct();
  var_0.origin = (-2000, -5000, 1000);
  var_0.angles = (0, 3, 0);
  var_0.targetname = "infil_scene";
  var_0.target = "lbravoAlphaAdvancedPath";
  level.struct_class_names["targetname"]["infil_scene"] = [var_0];
  var_0 = spawnStruct();
  var_0.ref_12f91 = int(1);
  var_0.classname = "script_struct_heli";
  var_0.target = "custom3194";
  var_0.script_decel = int(50);
  var_0.angles = (0, 318, 0);
  var_0.lookahead = int(1);
  var_0.origin = (-600, -1000, 1000);
  var_0.script_accel = int(50);
  var_0.speed = int(120);
  var_0.targetname = "lbravoAlphaAdvancedPath";
  level.struct_class_names["targetname"]["lbravoAlphaAdvancedPath"] = [var_0];
  var_0 = spawnStruct();
  var_0.script_decel = int(20);
  var_0.script_goalyaw = 1;
  var_0.target = "custom3208";
  var_0.targetname = "custom3194";
  var_0.radius = int(400);
  var_0.angles = (0, 325, 0);
  var_0.lookahead = int(1);
  var_0.origin = (-300, -500, 1000);
  var_0.ref_12f91 = int(1);
  var_0.classname = "script_struct_heli";
  var_0.script_accel = int(20);
  var_0.speed = int(120);
  level.struct_class_names["targetname"]["custom3194"] = [var_0];
  var_0 = spawnStruct();
  var_0.script_decel = int(20);
  var_0.script_goalyaw = 1;
  var_0.targetname = "custom3208";
  var_0.radius = int(200);
  var_0.angles = (0, 165, 0);
  var_0.lookahead = int(1);
  var_0.origin = (0, 0, 500);
  var_0.ref_12f91 = int(1);
  var_0.classname = "script_struct_heli";
  var_0.script_accel = int(20);
  var_0.speed = int(100);
  level.struct_class_names["targetname"]["custom3208"] = [var_0];
}

function weapon_xp_iw8_sm_victor() {
  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(!isDefined(level.spawn_points)) {
    return scripts\cp\gametypes\cp_specops::getspawnpoint();
  }

  return scripts\engine\utility::random(level.spawn_points);
}

function weapon_xp_iw8_sn_mike14(var_0) {
  thread scripts\cp\helicopter\chopper_boss::spawnplayer_internal(0);
}

function weapon_xp_iw8_sn_hdromeo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  scripts\cp\cp_laststand::enter_camera_zoomout();

  if(istrue(var_0.fauxdead)) {
    var_0.fauxdead = undefined;
    var_0 scripts\cp\cp_laststand::enter_bleed_out(var_0);
    var_0 scripts\cp\cp_laststand::playslamzoomflash();
  } else {
    scripts\cp\cp_laststand::camera_zoomout(var_0, var_1, undefined);
  }

  scripts\cp\cp_laststand::exit_camera_zoomout();

  if(!isDefined(level.players_in_respawn_queue)) {
    level.players_in_respawn_queue = [];
  }

  level.players_in_respawn_queue = scripts\engine\utility::array_add(level.players_in_respawn_queue, var_0);
  var_12 = 0;
  var_13 = undefined;

  foreach(var_15 in level.players) {
    if(var_15.sessionstate == "spectator") {
      var_12++;
    }
  }

  if(var_12 == level.players.size - 1) {
    foreach(var_15 in level.players) {
      if(var_15.sessionstate == "spectator") {}
    }
  }

  foreach(var_15 in level.players) {
    if(!istrue(level.player_cam_disable)) {
      level.player_cam_disable = 1;

      foreach(var_15 in level.players) {
        var_15.respawn_active = 0;
      }
    }
  }

  for(;;) {
    var_23 = var_0 scripts\engine\utility::ref_143ad("respawn_player", "auto_respawn");

    if(isDefined(var_23)) {
      if(istrue(var_0.binc130)) {
        continue;
      }

      if(var_23 == "auto_respawn") {
        foreach(var_15 in level.players) {
          var_15 thread scripts\cp\cp_hud_message::showsplash("auto_respawn");
        }
      }

      level.players_in_respawn_queue = scripts\engine\utility::array_remove(level.players_in_respawn_queue, var_0);
      return 1;
    }
  }
}

function ref_124a6() {
  scripts\cp\gametypes\cp_specops::givedefaultloadout();
  self setsuit("iw8_suit_cp");
  var_0 = "iw8_ar_scharlie_mp";
  var_1 = ["fastreload", "front_scharlie", "gripang", "mag_scharlie", "pistolgrip01_scharlie", "rec_scharlie", "reflex_west01_irons", "selectsemi", "stocks_scharlie"];
  var_2 = scripts\cp\cp_weapon::buildweapon(var_0, var_1, "none", "none", 0);
  self giveweapon(var_2);
  self setweaponammoclip(var_2, weaponclipsize(var_2));
  self setweaponammostock(var_2, weaponmaxammo(var_2));
  self switchtoweapon(var_2);
  var_3 = "iw8_sh_romeo870_mp";
  var_1 = ["barshort_romeo870", "fmj_small", "griprail_romeo870", "gripvertpro_romeo870", "ironsdefault_romeo870", "rec_romeo870", "stockno_romeo870"];
  var_4 = scripts\cp\cp_weapon::buildweapon(var_3, var_1, "none", "none", 0);
  self giveweapon(var_4);
  self setweaponammoclip(var_4, weaponclipsize(var_4));
  self setweaponammostock(var_4, weaponmaxammo(var_4));
  thread scripts\cp\cp_powers::givepower("power_claymore", "primary", undefined, undefined, undefined, undefined, 1, 4);
  thread scripts\cp\cp_powers::givepower("power_flash", "secondary", undefined, undefined, undefined, undefined, 1, 4);
  self.weaponlist = self getweaponslistprimaries();
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0], 1);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0])) {
    self.primaryweaponobj = self.weaponlist[0];
  }

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1])) {
    self.secondaryweaponobj = self.weaponlist[1];
  }

  self setclientomnvar("ui_hide_minimap", 0);
  thread hostagetemppistol();
  level.hostdamagefactorlow++;
  level notify("connectedPlayerCount");
}

function ref_1247b(var_0) {}

function rundebugstartobjective(var_0) {
  wait 2;
  scripts\engine\utility::flag_wait("infil_complete");

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

function onplayerconnect(var_0) {}

function onplayerspawned() {}

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
  register_create_script_arrays("cp_so_safehouse_create_script", "cp_so_safehouse_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_so_safehouse\cp_so_safehouse_create_script::main);
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

function ref_12df6() {
  if(isDefined(level.ref_13ac6[self.team])) {
    self thread[[level.ref_13ac6[self.team]]]();
    return;
  }
}

function ref_14379() {
  while(!isDefined(level.players) || level.players.size < 1) {
    wait 1;
  }

  wait 3;
  scripts\cp\laser_traps\cp_laser_traps::ref_1437a();
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_set("players_connected");
}

function hostagetemppistol() {
  self endon("death_or_disconnect");
  self.ref_14389 = 1;
  waitframe();
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("black", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0.lowresbackground = 1;
  var_1 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self playerlinktoabsolute(var_1);
  self setmovespeedscale(0);
  scripts\engine\utility::flag_wait("players_connected");
  var_0 fadeovertime(1);
  var_0.alpha = 0;
  wait 0.3;
  self unlink();
  completepayloadpunish(1, 1);
  wait 1;

  if(isDefined(var_0)) {
    var_0 destroy();
  }

  var_1 delete();
}

function infil_player_allow(var_0) {
  if(self ishost() && getdvarint("scr_infil_spectator") == 1) {
    scripts\common\utility::allow_weapon(var_0, "infil");
    return;
  }

  scripts\common\utility::allow_movement(var_0, "infil");
  scripts\common\utility::allow_prone(var_0, "infil");
  scripts\common\utility::allow_crouch(var_0, "infil");
  scripts\common\utility::allow_jump(var_0, "infil");
  scripts\common\utility::allow_fire(var_0, "infil");
  scripts\common\utility::allow_ads(var_0, "infil");
  scripts\common\utility::allow_sprint(var_0, "infil");
  scripts\common\utility::allow_melee(var_0, "infil");
  scripts\common\utility::allow_reload(var_0, "infil");
  scripts\common\utility::allow_lean(var_0, "infil");
  scripts\common\utility::allow_slide(var_0, "infil");
  scripts\common\utility::allow_offhand_weapons(var_0, "infil");
  scripts\common\utility::allow_weapon_switch(var_0, "infil");
  scripts\common\utility::allow_usability(var_0, "infil");
  scripts\common\utility::allow_script_weapon_switch(var_0, "infil");
}

function init_flags() {
  scripts\engine\utility::flag_init("players_connected");
  scripts\engine\utility::flag_init("all_bombs_defused");
  scripts\engine\utility::flag_init("attack_heli_in_position");
  scripts\engine\utility::flag_init("bomb_exploded");
  scripts\engine\utility::flag_init("exfil_boss_killed");
  scripts\engine\utility::flag_init("exfil_arrived");
}

function stopstreamtomovingplane() {
  level.cpvehiclename = [];

  foreach(var_1 in ["field", "construction", "heli"]) {
    var_2 = scripts\engine\utility::getStruct("bomb_site_" + var_1, "targetname");
    var_2.set_relic_landlocked = scripts\engine\utility::getStructArray("guard_spawner_" + var_1, "targetname");
    var_2.keypad_damagedeathdisconnectwatch = scripts\engine\utility::getStructArray("defuse_spawner_" + var_1, "targetname");
    var_2.name = var_1;
    var_2.blend_movespeedscale_cpso = [];
    thread ref_13f77();
    level.cpvehiclename[var_1] = var_2;
  }
}

function ref_13f77() {
  for(;;) {
    waitframe();

    if(self.blend_movespeedscale_cpso.size > 0) {
      self.blend_movespeedscale_cpso = scripts\engine\utility::array_removedead(self.blend_movespeedscale_cpso);
    }
  }
}

function store_platform_models() {
  level.current_checkpoint = 0;
  level.bombs = [];
  level.bombs[level.bombs.size] = ref_1350b((-1222.5, 2396.75, 3.25), (0, -277.936, 0), "field");
  level.bombs[level.bombs.size] = ref_1350b((1030.25, 1982, 318), (0, 86.6868, 0), "heli");
  level.bombs[level.bombs.size] = ref_1350b((-655.25, -2000.5, 125.75), (0, 339.723, 0), "construction");
}

function stoppingpower_clearhcronperkscleared() {
  scripts\cp\laser_traps\cp_laser_traps::stopinteract();

  foreach(var_1 in scripts\engine\utility::getStructArray("spawner", "script_noteworthy")) {
    var_1.spawn_functions = [];
  }

  thread ref_135ba();
}

function cqb_laser_guy() {
  foreach(var_1 in level.cpvehiclename) {
    scripts\cp\laser_traps\cp_laser_traps::array_spawn_function(var_1.set_relic_landlocked, &ref_133a7, var_1);
    scripts\cp\laser_traps\cp_laser_traps::array_spawn_function(var_1.keypad_damagedeathdisconnectwatch, &ref_133a7, var_1);
    var_2 = [];

    foreach(var_4 in var_1.set_relic_landlocked) {
      if(scripts\engine\utility::array_contains_key(var_2, var_4.script_type)) {
        var_2[var_2[var_4.script_type].size] = var_4;
        continue;
      }

      var_2 = [var_4];
    }

    var_6 = [];
    var_7 = rear_minigun_speed();

    while(var_6.size < var_7) {
      var_8 = 0;
      var_9 = 1;

      while(var_6.size < var_7 && var_9) {
        var_9 = 0;

        foreach(var_11 in var_2) {
          if(var_8 < var_11.size) {
            var_6 = var_11[var_8];
            var_9 = 1;

            if(var_6.size >= var_7) {
              break;
            }
          }
        }

        var_8++;
      }
    }

    var_1.blend_movespeedscale_cpso = scripts\cp\laser_traps\cp_laser_traps::can_spawn_extras(var_6);
    thread ref_133a9();
  }
}

function ref_133a7(var_0) {
  if(!isDefined(self.target)) {
    self setgoalpos(var_0.origin);
    self.goalradius = var_0.radius;
  }

  if(issubstr(self.agent_type, "lmg") || issubstr(self.agent_type, "rpg")) {
    self.disablepistol = 1;
  }

  self endon("death");

  while(!istrue(var_0.bomb.defused)) {
    foreach(var_2 in level.players) {
      if(distance2dsquared(var_2.origin, var_0.origin) < 2250000) {
        self getenemyinfo(var_2);
      }
    }

    waitframe();
  }

  self.goalradius = 500;
  var_4 = 0;

  if(isDefined(self.enemy) && isalive(self.enemy) && isPlayer(self.enemy) && !self.enemy.inlaststand) {
    var_2 = self.enemy;
  } else {
    var_2 = race_set_checkpoint();
  }

  if(!isDefined(var_2)) {
    goto LOC_00000161;
  }

  GscBinSkip4(0x35, var_2);

  for(;;) {
    var_7 = 1;

    foreach(var_2 in level.players) {
      if(scripts\engine\utility::within_fov(var_2 getEye(), var_2 getgunangles(), self.origin, 0)) {
        var_7 = 0;
        break;
      }
    }

    if(var_7) {
      scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
      return;
    }

    waitframe();
  }
}

function ref_133a9() {
  thread ref_133a8();
  GscBinSkip1(0x45, "forward", []);
}

function ref_133a8() {
  self.bomb waittill("trigger");
  self.ref_13e14 = 1;
  var_0 = 0;
  var_1 = scripts\engine\utility::random(getEntArray("boss_spawner_" + self.name, "targetname"));

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getStruct("boss_spawner_" + self.name, "targetname");
    var_0 = 1;
  } else {
    var_0 = scripts\engine\utility::getStructArray(var_1.target, "targetname").size;
  }

  while(getaiarray("axis").size + var_0 > 48) {
    waitframe();
  }

  jumpiffalse(isstruct(var_1)) LOC_0000009e;
  var_2 = [var_1 scripts\cp\laser_traps\cp_laser_traps::spawn_ai()];
  thread vehicle_occupancy_clearallowmovementplayer(var_2[0]);
  goto LOC_00000154;
}

function siteusedinternal() {
  nonbunkerdoors();
  self.script_disconnectpaths = 0;
  self.ref_12307 = spawn("script_model", self.origin);
  self.ref_12307 setModel("veh8_mil_air_lbravo_personnel_platform");
  self.ref_12307 linkTo(self, "tag_origin", (0, 0, -73), (0, 0, 0));
  ref_13b33(&heli_crash_on_pilot_death);
  var_0 = undefined;

  foreach(var_2 in scripts\engine\utility::getStructArray(self.target, "targetname")) {
    if(!isDefined(var_2.script_type)) {
      var_0 = var_2;
      break;
    }
  }

  thread scripts\common\vehicle::vehicle_paths(var_0);
  var_4 = createnavbadplacebybounds((-483.75, -1444, 187.375), (180, 30, 130), (0, 0, 0));
  scripts\engine\utility::waittill_either("unloaded", "death");
  destroynavobstacle(var_4);

  if(!isalive(self)) {
    self.ref_12307 delete();
    return;
  }

  scripts\engine\utility::waittill_either("reached_dynamic_path_end", "death");
  self.ref_12307 delete();
}

function ref_13dd3() {
  self.godmode = 1;

  while(!scripts\common\vehicle_code::vehicle_is_stopped()) {
    waitframe();
  }

  self.godmode = 0;
  self waittill("death");
  var_0 = self.origin;
  var_1 = self.angles;
  waitframe();

  if(isDefined(self.riders)) {
    scripts\engine\utility::array_call(self.riders, &delete);
  }

  self delete();
  var_2 = spawn("script_model", var_0);
  var_2 setModel("veh8_mil_lnd_tromeo_static_dst");
  var_2.angles = var_1;
  var_2 show();
  var_3 = spawn("script_model", var_0);
  var_3.angles = var_1;
  var_4 = getEnt("tromeo_dst_col", "targetname");
  var_3 clonebrushmodeltoscriptmodel(var_4);
  var_3 disconnectPaths();
}

function isplayeronground() {
  level.players[0] notifyonplayercommand("kill_tromeo", "+attack");

  while(self.godmode) {
    level.players[0] waittill("kill_tromeo");
  }

  self dodamage(99999999, self.origin);
}

function ref_13b33(var_0) {
  self endon("death");
  self childthread[[var_0]]();
}

function vehicle_occupancy_clearallowmovementplayer(var_0) {
  ref_1243d(level.players, "dx_mpa_rutl_juggernaut_enemy_use", 5, undefined, 1);
  setmusicstate("cp_juggernaut_intro");
  self endon("death");
  self waittill("goal");
  self.goalradius = 2000;
  thread ref_12809();

  for(;;) {
    if(isDefined(self.enemy)) {
      self getenemyinfo(self.enemy);
      self setgoalpos(self.enemy.origin);
      wait 1;
      continue;
    }

    var_1 = race_set_checkpoint(var_0);

    if(!isDefined(var_1)) {
      waitframe();
      continue;
    }

    self getenemyinfo(var_1);
    self setgoalpos(var_1.origin);
    wait 1;
  }
}

function ref_12809() {
  self endon("death");

  if(!isDefined(level.juggernauts)) {
    level.juggernauts = [];
  }

  level.juggernauts[level.juggernauts.size] = self;
  thread vehicle_mp_deletenextframelate();
  GscBinSkip4(0x35);
}

function vehicle_mp_deletenextframelate() {
  if(!isalive(self)) {
    return;
  }

  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!istrue(self.allowpain)) {
      if(isDefined(var_9) && getweaponbasename(var_9) == "flash") {
        self.allowpain = 1;
      }
    }

    if(var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE" || var_4 == "MOD_GRENADE_SPLASH") {
      if(istrue(self.allowpain) && (!isDefined(var_9) || !scripts\engine\utility::is_equal(var_9.basename, "flash"))) {
        self notify("jugg_stunned");
      }

      self.minpaindamage = 0;

      if(isDefined(var_1) && isPlayer(var_1)) {
        var_10 = var_0 / 2;

        if(var_10 < 50) {
          var_10 = 50;
        } else if(var_10 > 150) {
          var_10 = 100;
        }
      } else {
        var_10 = 25;
      }

      self dodamage(var_10, var_4, var_2);
      self.minpaindamage = self.minpainvalue;
    }
  }
}

function juggernaut_pain_cooldown() {
  for(;;) {
    self waittill("jugg_stunned");
    self.stuncooldown = 1;
    self.allowpain = 0;
    wait 7;
    self.stuncooldown = 0;
    self.allowpain = 1;
  }
}

function isgunlessweapon() {}

function silo_thrust_platforms(var_0) {
  level.silo_thrust_dogtag_revive = self;
  self endon("death");
  nonbunkerdoors();
  GscBinSkip4(0x35);
}

function nonbunkerdoors() {
  self setvehicleteam("axis");
  self.script_team = "axis";
  self.godmode = 0;
  self.script_bulletshield = 0;
  self setCanDamage(1);
  self vehicleshowonminimap(1);
  self aiupdatecoverexposetype(1);
  ref_1333a();
}

function ref_1333a() {
  self.objindex = scripts\cp\cp_objectives::requestworldid("obj_" + self getentitynumber(), 5);
  objective_setplayintro(self.objindex, 0);
  objective_setplayoutro(self.objindex, 0);
  objective_setownerteam(self.objindex, "axis");
  objective_state(self.objindex, "active");

  if(issubstr(self.model, "lbravo")) {
    objective_icon(self.objindex, "icon_minimap_littlebird");
  } else if(issubstr(self.model, "tromeo")) {
    objective_icon(self.objindex, "icon_minimap_atv");
  } else {
    objective_icon(self.objindex, "icon_minimap_juggernaut");
  }

  objective_setlocation(self.objindex, 0, self);
  thread laser_sights(self.objindex, "obj_" + self getentitynumber());
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

function ispubliceventoftypeactive() {
  for(;;) {
    var_0 = rotatevectorinverted(self.minigun gettagorigin("tag_flash") - self.origin, self.angles);
    var_1 = self.origin + rotatevector(var_0, self.angles);
    waitframe();
  }
}

function heli_movement() {
  var_0 = scripts\engine\utility::getStructArray("attack_heli_struct", "targetname");
  self.initlocs_nonmorsephones = undefined;
  self.player_closes_in = 1;

  for(;;) {
    if(!isDefined(self.target_player)) {
      waitframe();
      continue;
    }

    if(istrue(self.player_closes_in)) {
      var_1 = 60;
      self.player_closes_in = undefined;
    } else {
      var_2 = scripts\engine\utility::ter_op(isDefined(self.ref_124ca), 20, 10);
      var_1 = clamp(distance(self.origin, self.initlocs_nonmorsephones.origin) / 5, var_2, 40);
    }

    self.initlocs_nonmorsephones = printer(var_0, self.target_player);
    skip_soldier_spawn(self.initlocs_nonmorsephones.origin, var_1);

    if(!isDefined(self.ref_124ca)) {
      scripts\engine\utility::ref_143ba(randomfloatrange(3, 5), "new_target_player", "player_looking");
      continue;
    }

    if(radiussq()) {
      wait 2;
      continue;
    }

    var_3 = level scripts\engine\utility::waittill_notify_or_timeout_return("player_fired_rpg", 0.8);

    if(var_3 == "player_fired_rpg" && radiussq()) {
      wait 2;
    }
  }
}

function radiussq() {
  foreach(var_1 in level.players) {
    if(istrue(var_1.inlaststand) || !isDefined(var_1.waittill_drone_timeout)) {
      continue;
    }

    if(scripts\engine\utility::time_has_passed(var_1.waittill_drone_timeout["time"], 0.4)) {
      continue;
    }

    var_2 = vectorNormalize(self.origin - var_1.waittill_drone_timeout["origin"]);
    var_3 = anglesToForward(var_1.waittill_drone_timeout["angles"]);
    var_4 = scripts\engine\math::anglebetweenvectors(var_2, var_3);

    if(var_4 < 45) {
      return true;
    }
  }

  return false;
}

function printer(var_0, var_1) {
  if(isDefined(self.milestonephasepercent_lzs)) {
    var_2 = sortbydistance(var_0, self.milestonephasepercent_lzs.origin);
    var_3 = var_2[var_2.size - 1];
    self.milestonephasepercent_lzs = undefined;
    return var_3;
  }

  var_4 = [];
  var_5 = [];

  foreach(var_3 in sortbydistance(var_2, var_3.origin)) {
    var_7 = distance2dsquared(var_3.origin, var_3.origin);

    if(var_7 > 4000000) {
      break;
    }

    if(var_7 < 1000000) {
      continue;
    }

    if(scripts\engine\utility::is_equal(var_3, self.initlocs_nonmorsephones)) {
      continue;
    }

    var_5 = var_3;
    var_8 = rotatevectorinverted(self.minigun gettagorigin("tag_flash") - self.origin, self.angles);
    var_9 = vectortoangles(scripts\engine\utility::flatten_vector(var_3.origin - var_3.origin));
    var_10 = var_3.origin + rotatevector(var_8, var_9);

    if(scripts\engine\trace::ray_trace_passed(var_10, var_3.origin + (0, 0, 20), scripts\engine\utility::array_combine(level.players, [self, self.minigun]))) {
      var_4 = var_3;
    }

    waitframe();

    if(var_4.size > 3) {
      break;
    }
  }

  if(var_4.size) {
    return scripts\engine\utility::random(var_4);
  }

  return scripts\engine\utility::random(var_5);
}

function skip_soldier_spawn(var_0, var_1) {
  self notify("nav_new_path");
  self endon("nav_new_path");
  var_2 = findpath3d(self.origin, var_0);

  if(!isDefined(var_2)) {
    iprintlnbold("No nav3d data for heli! Heli flying will be bad .");
    return;
  }

  var_3 = 0;
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 37);
  self vehicle_setspeed(var_1, var_1 * 0.5, var_1 * 0.5);

  foreach(var_5 in var_2) {
    if(var_6 == var_2.size - 1) {
      var_3 = 1;
    }

    self setvehgoalpos(var_5, var_3);
    scripts\engine\utility::ref_143a5("near_goal", "goal");
  }

  self notify("nav_goal");
}

function single_loop(var_0) {
  for(var_1 = 0; var_1 < 3 && siteused(var_0); var_1++) {
    var_2 = 0;
    var_3 = gettime() + 2000;

    while(gettime() < var_3) {
      var_4 = var_0.origin + (0, 0, 20);
      self.turret_pointer.origin = var_4;
      var_5 = self.minigun gettagorigin("tag_flash");
      var_6 = self.minigun gettagangles("tag_flash");

      if(scripts\engine\utility::within_fov(var_5, var_6, var_4, 0.99)) {
        var_2 = 1;
        break;
      }

      wait 0.1;

      if(!siteused(var_0)) {
        return;
      }
    }

    if(!var_2) {
      return;
    }

    self.minigun startbarrelspin();
    var_7 = 200;
    self.turret_pointer moveTo(var_0.origin + anglesToForward(var_0.angles) * var_7, 2, 1, 1);
    wait 2;

    for(var_8 = 0; var_8 < 30; var_8++) {
      if(var_7 > 0) {
        var_7 -= 20;
      }

      self.turret_pointer moveTo(var_0.origin + anglesToForward(var_0.angles) * var_7 + (0, 0, 20), 0.1, 0.05, 0.05);
      self.minigun shootturret();
      wait 0.1;

      if(!siteused(var_0)) {
        break;
      }
    }

    self.minigun stopbarrelspin();
    wait 1;
  }
}

function siteused(var_0) {
  if(!isalive(var_0)) {
    return false;
  }

  if(var_0.inlaststand) {
    return false;
  }

  if(isDefined(self.attacker)) {
    return false;
  }

  return true;
}

function heli_damage_monitor(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  jumpiffalse(var_0 != self) LOC_00000017;
  var_0 endon("death");

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(var_0 == self && isDefined(var_10) && var_10.basename == "iw8_la_rpapa7_mp") {
      waitframe();

      if(!scripts\common\vehicle::vehicle_is_crashing()) {
        self dodamage(self.health - self.healthbuffer + 1, self.origin);
      }
    }

    if(!isPlayer(var_2)) {
      continue;
    }

    self.attacker = var_2;
  }
}

function skipfirstraise(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  if(var_0 != self) {
    var_0 endon("death");
  }

  var_1 = cos(15);

  for(;;) {
    var_2 = undefined;

    foreach(var_4 in level.players) {
      var_5 = var_4 getEye();
      var_6 = var_4 getgunangles();
      var_7 = anglesToForward(var_6);

      if(scripts\engine\utility::within_fov(var_5, var_6, var_0.origin, var_1)) {
        var_8 = vectorNormalize(var_0.origin - var_5) * 150;

        if(sighttracepassed(var_5, var_0.origin - var_8, 0, var_4)) {
          var_2 = var_4;
          break;
        }

        waitframe();
      }
    }

    var_2 = undefined;
    var_7 = undefined;

    if(!isDefined(self.ref_124ca) && isDefined(var_1) || isDefined(self.ref_124ca) && !isDefined(var_1)) {
      if(isDefined(var_1)) {
        self notify("player_looking", var_1);
      }

      self.ref_124ca = var_1;
    }

    wait 0.2;
  }
}

function callback_trigger(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 1;
  }

  return scripts\engine\utility::is_equal(var_0, var_1);
}

function heli_crash_on_pilot_death() {
  self.driver waittill("death");

  if(scripts\common\vehicle::vehicle_is_crashing()) {
    return;
  }

  self dodamage(self.health - self.healthbuffer + 1, self.origin);
}

function race_set_checkpoint(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self.attacker)) {
    var_2 = self.attacker;
    self.attacker = undefined;
  } else if(isDefined(self.ref_124ca)) {
    var_2 = self.ref_124ca;
  } else if(isDefined(var_0) && !istrue(var_0.bomb.defused)) {
    if(isDefined(var_0.bomb.playerusing) && (!istrue(var_1) || ref_124bf(var_0.bomb.playerusing))) {
      var_2 = var_0.bomb.playerusing;
    } else {
      var_2 = progression_deadzone(var_0.bomb.origin, var_1);
    }
  } else {
    var_2 = progression_deadzone(self.origin, var_1);
  }

  return var_2;
}

function progression_deadzone(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isalive(var_4) || var_4.inlaststand) {
      continue;
    }

    if(istrue(var_1) && !ref_124bf(var_4)) {
      continue;
    }

    var_2 = var_4;
  }

  var_4 = scripts\engine\utility::getclosest(var_0, var_2);
  return var_4;
}

function ref_124bf(var_0) {
  var_1 = var_0 getEye();
  var_2 = level.players;

  if(isent(self)) {
    var_2 = scripts\engine\utility::array_add(var_2, self);
  }

  if(isDefined(self.linked_ents)) {
    var_2 = scripts\engine\utility::array_combine(var_2, self.linked_ents);
  }

  if(scripts\engine\trace::ray_trace_passed(var_1, var_1 + (0, 0, 256), var_2)) {
    return 1;
  }

  waitframe();
  return scripts\engine\trace::ray_trace_passed(var_1, self.origin, var_2);
}

function questenabled(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  while(!isDefined(var_2)) {
    if(!isDefined(var_3)) {
      var_3 = var_1;
    } else if(var_3 % var_0.size == var_1 % var_0.size) {
      break;
    }

    var_4 = var_0[var_1 % var_0.size];

    if(isDefined(var_4.script_count) && isDefined(var_4.spawned)) {
      var_4.spawned = scripts\engine\utility::array_removedead_or_dying(var_4.spawned);

      if(var_4.spawned.size >= var_4.script_count) {
        var_1++;
        continue;
      }
    }

    if(!istrue(var_4.script_forcespawn) && (scripts\engine\utility::get_array_of_closest(var_4.origin, level.players, undefined, undefined, 500).size || c130airdrop_dropcrates(var_4))) {
      var_1++;
      continue;
    }

    var_2 = var_1 % var_0.size;
  }

  return var_2;
}

function c130airdrop_dropcrates() {
  var_0 = [self.origin + (0, 0, 18), self.origin + (0, 0, 72), self.origin + rotatevector((0, 10, 0), self.angles) + (0, 0, 60), self.origin + rotatevector((0, -10, 0), self.angles) + (0, 0, 60)];

  foreach(var_2 in level.players) {
    var_3 = var_2 getEye();
    var_4 = var_2 getgunangles();

    foreach(var_6 in var_0) {
      if(scripts\engine\utility::within_fov(var_3, var_4, var_6, 0)) {
        if(sighttracepassed(var_3, var_6, 0, var_2)) {
          return true;
        }

        waitframe();
        var_3 = var_2 getEye();
        var_4 = var_2 getgunangles();
      }
    }
  }

  return false;
}

function rear_minigun_speed() {
  switch (level.players.size) {
    case 2:
    case 1:
      return 4;
    default:
      return 8;
  }
}

function qm_intro_dialogue() {
  switch (level.players.size) {
    case 2:
    case 1:
      switch (level.current_checkpoint) {
        case 0:
          return 4;
        case 1:
          return 8;
        default:
          return 12;
      }
    default:
      switch (level.current_checkpoint) {
        case 0:
          return 8;
        case 1:
          return 12;
        default:
          return 16;
      }

      break;
  }
}

function reaper_waitingformissilereload() {
  switch (level.current_checkpoint) {
    case 0:
      return 1;
    case 1:
      return 0.5;
    default:
      return 0.25;
  }
}

function ref_13548(var_0) {
  while(!scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, undefined, undefined, 500).size) {
    waitframe();
  }

  thread ref_1354b();
  level scripts\engine\utility::thread_on_notify("exfil_arriving", &ref_1354b);
  var_1 = scripts\engine\utility::getStructArray("exfil_spawner", "targetname");
  scripts\engine\utility::array_thread(var_1, &scripts\cp\laser_traps\cp_laser_traps::add_spawn_function, &onentercallback);

  for(var_2 = 0; !scripts\engine\utility::flag("exfil_arrived"); var_2++) {
    switch (var_2) {
      case 0:
        if(level.players.size > 2) {
          var_3 = 8;
        } else {
          var_3 = 4;
        }

        break;
      case 1:
        if(level.players.size > 2) {
          var_3 = 12;
        } else {
          var_3 = 8;
        }

        break;
      default:
        if(level.players.size > 2) {
          var_3 = 16;
        } else {
          var_3 = 12;
        }

        break;
    }

    var_4 = [];

    while(var_4.size < var_3) {
      for(var_5 = 0; var_5 < var_1.size && var_4.size < var_3; var_5++) {
        var_6 = var_1[var_5];
        var_7 = scripts\engine\utility::getclosest(var_6.origin, level.players);

        if(distancesquared(var_7.origin, var_6.origin) < 250000) {
          continue;
        }

        if(!c130airdrop_dropcrates(var_6)) {
          var_8 = ref_12980(var_6);

          if(isDefined(var_8)) {
            var_4 = var_8;
          }
        }

        waitframe();
      }

      waitframe();
    }

    while(var_4.size > level.players.size) {
      wait 1;
      var_4 = scripts\engine\utility::array_removedead_or_dying(var_4);
    }
  }
}

function ref_1354b() {
  var_0 = scripts\engine\utility::getStructArray("exfil_juggernaut_spawner", "targetname");
  scripts\engine\utility::array_thread(var_0, &scripts\cp\laser_traps\cp_laser_traps::add_spawn_function, &onentercallback);
  scripts\engine\utility::array_thread(var_0, &scripts\cp\laser_traps\cp_laser_traps::add_spawn_function, &ref_12809);
  var_1 = scripts\engine\utility::ter_op(level.players.size > 2, 2, 1);
  var_2 = 0;

  if(!isDefined(level.juggernauts)) {
    level.juggernauts = [];
  }

  foreach(var_5, var_4 in level.juggernauts) {
    if(isalive(var_4)) {
      var_2++;
    }
  }

  if(var_2 >= var_1) {
    return;
  }

  if(var_1 - var_2 > 1) {
    ref_1243d(level.players, "dx_cps_kama_callout_juggernaut_spawning_10", 2);
  } else {
    ref_1243d(level.players, "dx_mpa_rutl_rugby_enemy_close_goal", 2);
  }

  setmusicstate("cp_juggernaut_intro");

  while(var_2 < var_1) {
    foreach(var_7 in var_0) {
      if(!c130airdrop_dropcrates(var_7)) {
        var_8 = ref_12980(var_7);

        if(isDefined(var_8)) {
          var_2++;
        }

        if(var_2 >= var_1) {
          break;
        }
      }
    }

    var_5 = undefined;
    var_7 = undefined;
    wait 2;
  }
}

function ref_1354a() {
  level waittill("exfil_called");
  var_0 = [];

  if(isDefined(level.silo_thrust_dogtag_revive) && isalive(level.silo_thrust_dogtag_revive)) {
    level.silo_thrust_dogtag_revive scripts\engine\utility::thread_on_notify_no_endon_death("death", &scripts\engine\utility::flag_set, "exfil_boss_killed");
    GscBinSkip0(0x2e, 0, level.silo_thrust_dogtag_revive);
  }

  var_1 = scripts\common\utility::getvehiclespawner("boss_spawner_heli", "targetname");
  var_2 = var_1 scripts\common\vehicle::spawn_vehicle_and_gopath();
  var_0 = var_2;
  waitframe();
  ref_1243d(level.players, "dx_cps_kama_callout_helicopter_attacking_20", 2, undefined, 1);
  thread silo_thrust_platforms();
  var_2 scripts\engine\utility::thread_on_notify_no_endon_death("death", &scripts\engine\utility::flag_set, "exfil_boss_killed");
  ref_11e5c("objective_boss", &"CP_SO_SAFEHOUSE/OBJECTIVE_DEFEAT", "icon_waypoint_vehicle_little_bird", "axis", var_0, undefined, "exfil_boss_killed");
}

function ref_11cf2() {
  if(isalive(self)) {
    self waittill("death");
  }

  level.ref_13a86++;
}

function onentercallback() {
  self endon("death");

  if(!isDefined(self.target)) {
    self.goalradius = 1000;
    var_0 = scripts\engine\utility::getStruct("lz", "targetname");
    self setgoalpos(var_0.origin);
  }

  if(issubstr(self.agent_type, "lmg") || issubstr(self.agent_type, "rpg")) {
    self.disablepistol = 1;
    return;
  }
}

function ref_135ba() {
  level.spawn_queue = [];

  for(;;) {
    wait 0.1;

    if(level.spawn_queue.size) {
      var_0 = level.spawn_queue[0];
      var_1 = var_0 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
      var_0 notify("spawned", var_1);
      level.spawn_queue = scripts\engine\utility::array_remove(level.spawn_queue, var_0);
    }
  }
}

function ref_12980() {
  level.spawn_queue[level.spawn_queue.size] = self;
  self waittill("spawned", var_0);
  return var_0;
}

function getcash(var_0, var_1) {
  self notify("new_chase_target");
  self endon("new_chase_target");
  self endon("death");
  var_0 endon("death");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  for(;;) {
    self setgoalpos(var_0.origin);
    wait var_1;
  }
}

function target_play_death_anim() {
  var_0 = squared(300);
  var_1 = gettime();
  var_2 = 1;

  while(var_2) {
    foreach(var_4 in level.players) {
      if(distance2dsquared(var_4.origin, (-1050, 514, 0)) < var_0) {
        continue;
      }

      var_2 = 0;
      break;
    }

    waitframe();
  }

  scripts\cp\laser_traps\cp_laser_traps::ref_13067();
  setomnvar("cp_countdown_color", 0);
  var_6 = [330, 330, 330, 330];
  level.ref_13b8b = var_6[level.players.size - 1];
  setomnvar("cp_wave_timer", gettime() + int(level.ref_13b8b * 1000));
  setomnvar("cp_round_num", 1);
  var_7 = level.ref_13b8b;
  level.ref_13b88 = 1;

  while(level.ref_13b8b > 0 && !scripts\engine\utility::flag("all_bombs_defused")) {
    level notify("timer_tick");

    if(level.ref_13b8b <= 30) {
      foreach(var_4 in level.players) {
        if(level.ref_13b8b > 20) {
          var_4 playSound("ui_mp_timer_countdown");
          continue;
        }

        if(level.ref_13b8b > 10) {
          var_4 playSound("ui_mp_timer_countdown_10");
          continue;
        }

        if(level.ref_13b8b > 5) {
          var_4 playSound("ui_mp_timer_countdown_half_sec");
          continue;
        }

        if(level.ref_13b8b > 1.5) {
          var_4 playSound("ui_mp_timer_countdown_quarter_sec");
          continue;
        }

        var_4 playSound("ui_mp_timer_countdown_1");
      }
    }

    setomnvar("cp_countdown_color", level.ref_13b8b <= 30);
    wait 1;
    var_10 = 1;

    if(var_10) {
      level.ref_13b8b--;
    }
  }

  thread little_bird_mg_initcollision();

  if(scripts\engine\utility::flag("all_bombs_defused")) {
    return;
  }

  level endon("all_bombs_defused");
  bombs_explode();
}

function little_bird_mg_initcollision() {
  setomnvar("cp_round_num", 0);
  level.ref_13b88 = 0;

  for(var_0 = 0; var_0 < 30; var_0++) {
    wait 0.05;
    setomnvar("cp_wave_timer", gettime() + int(level.ref_13b8b * 1000));
  }

  setomnvar("cp_countdown_color", 0);
}

function init_player() {
  var_0 = self;
  var_0.maxvisibledist = 2000;
  thread ref_14481();

  foreach(var_2 in level.bombs) {
    objective_addclienttomask(var_3, var_0);
  }

  thread spawn_backup_helispawner_jammer2();
  wait 2;
  scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var_0, ["ammo_crate", "grenade_crate"][level.infil_lbravo_is_alive]);
  level.infil_lbravo_is_alive = !level.infil_lbravo_is_alive;
}

function ref_14481() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("weapon_fired", var_0);

    if(isDefined(var_0) && var_0.basename == "iw8_la_rpapa7_mp") {
      self.waittill_drone_timeout = [];
      self.waittill_drone_timeout["time"] = gettime();
      self.waittill_drone_timeout["origin"] = self getEye();
      self.waittill_drone_timeout["angles"] = self getplayerangles();
      level notify("player_fired_rpg", self);
    }
  }
}

function spawn_backup_helispawner_jammer2() {
  level waittill("game_ended");
  self setclientomnvar("ui_hide_hud", 1);
}

function give_auto_revive() {
  self endon("death_or_disconnect");
  self.has_auto_revive = 1;

  while(istrue(self.has_auto_revive)) {
    self waittill("last_stand");
    wait 0.1;

    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      scripts\cp\cp_laststand::instant_revive(self);

      if(isDefined(self.dogtag)) {
        self.dogtag delete();
      }
    }
  }
}

function stoppingpowercanonehitkill(var_0) {
  var_1 = self;
  var_2 = "obj_bomb_" + var_0;

  if(var_0 == 0) {
    objective_setdescription(var_0, &"CP_SO_SAFEHOUSE/OBJECTIVE1");
  }

  var_3 = scripts\cp\cp_objectives::requestworldid(var_2, 3);
  objective_setlabel(var_3, &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS");
  objective_setplayintro(var_3, 1);
  objective_setplayoutro(var_3, 0);
  objective_position(var_3, var_1.origin + (0, 0, 12));
  objective_state(var_3, "current");
  var_4 = ["icon_waypoint_dom_a", "icon_waypoint_dom_b", "icon_waypoint_dom_c", "icon_waypoint_dom_d", "icon_waypoint_dom_e"];

  if(var_3 < var_4.size) {
    objective_icon(var_3, var_4[var_0]);
  } else {
    objective_icon(var_3, "icon_waypoint_dom_e");
  }

  wait 0.5;
}

function logevent_xpearned() {
  self endon("death_or_disconnect");

  if(scripts\engine\utility::flag("all_bombs_defused")) {
    return;
  }

  level waittill("timer_tick");
  self.timer = scripts\cp\utility::createtimer("hudsmall", 1.5);
  self.timer scripts\cp\utility::setpoint("CENTER", "CENTER", 0, -180);
  self.timer settimer(level.ref_13b8b);
  self.timer.color = (1, 1, 1);
  self.timer.archived = 0;
  self.timer.foreground = 1;
}

function init_fx() {
  level._effect["coop_bomb_defusal_explode"] = loadfx("vfx/iw8_cp/coop_bomb_defusal/vfx_bomb_explosion.vfx");
  level._effect["bomb_vest_explode"] = loadfx("vfx/iw8/level/piccadilly/vfx_pic_explo_suicide_bomb_end.vfx");
}

function subway_black_screen_fade_in() {
  level.mini_map_origin_fix = [];
  level.mini_map_origin_fix["a_front"] = [(-636, -1284, 0), (0, 50, 0)];
  level.mini_map_origin_fix["market_gate"] = [(-1792, 564, 0), (0, -25, 0)];
  level.mini_map_origin_fix["street_1"] = [(-774, 1885, 0), (0, -131, 0)];
  level.mini_map_origin_fix["street_2"] = [(141, 1364, 0), (0, -27, 0)];
  level.mini_map_origin_fix["courtyard"] = [(669, -471, 0), (0, 240, 0)];
  level.mini_map_origin_fix["market_alley"] = [(-476, 502, 0), (0, -25, 0)];
  level.bombs[0].minigun_attack_min_cooldown = ["street_1", "market_alley", "market_gate", "courtyard", "street_2", "a_front"];
  level.bombs[1].minigun_attack_min_cooldown = ["street_2", "market_alley", "courtyard", "market_gate", "a_front", "street_1"];
  level.bombs[2].minigun_attack_min_cooldown = ["a_front", "market_alley", "courtyard", "market_gate", "street_1", "street_2"];
}

function takeplayerweaponaway() {}

function init_fan_blades(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawnStruct();
  var_11.classname = "script_struct_heli";
  var_11.targetname = var_0;
  var_11.target = var_1;
  var_11.origin = var_2;
  var_11.angles = var_3;
  var_11.speed = scripts\engine\utility::ter_op(isDefined(var_4), var_4, int(100));
  var_11.script_accel = scripts\engine\utility::ter_op(isDefined(var_5), var_5, int(20));
  var_11.script_decel = scripts\engine\utility::ter_op(isDefined(var_6), var_6, int(20));
  var_11.radius = scripts\engine\utility::ter_op(isDefined(var_7), var_7, int(400));
  var_11.script_goalyaw = scripts\engine\utility::ter_op(isDefined(var_8), var_8, 1);
  var_11.lookahead = scripts\engine\utility::ter_op(isDefined(var_9), var_9, 1);
  var_11.ref_12f91 = scripts\engine\utility::ter_op(isDefined(var_8), var_8, 1);
  level.struct_class_names["targetname"][var_0] = [var_11];
  return var_11;
}

function superslotcleanup() {
  if(getdvarint("scr_skip_infils", 0) == 1) {
    if(scripts\engine\utility::flag_exist("infil_complete")) {
      scripts\engine\utility::flag_set("infil_complete");
    }

    return;
  }

  scripts\cp\infilexfil\lbravo_infil_cp::initanims("alpha");
  var_0 = [];
  GscBinSkip0(0x2e, 0, [0, 1]);
}

function ref_1357f(var_0) {
  var_1 = spawnVehicle("veh8_mil_air_lbravo", "infil_lbravo_alpha", "lbravo_infil_cp", var_0.origin, var_0.angles);
  return var_1;
}

function switchespaused() {
  ref_1238e("iw8_me_riotshield_mp", (-1055, 375, 102), (-14, 90, 0));
  ref_1238e("iw8_me_riotshield_mp", (-1015, 377, 102), (-14, 90, 0));
  ref_1238e("iw8_lm_kilo121_mp", (-951, 518.75, 91.5), (279.099, 89.9925, -100.98));
  ref_1238e("iw8_lm_kilo121_mp", (-965.5, 519.75, 91), (279.099, 89.9925, -100.98));
  ref_1238e("iw8_la_rpapa7_mp", (-1022, 625.5, 90.625), (-65, 90, 90));
  ref_1238e("iw8_la_rpapa7_mp", (-1011, 625.5, 90.625), (-65, 90, 90));
  scripts\cp\laser_traps\cp_laser_traps::ref_13433((-951.75, 577.5, 107.125), (0, 98, 0));
  scripts\cp\laser_traps\cp_laser_traps::player_limitedammo((-975, 557.25, 73), (0, 86, 0));
  scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime((-957.5, 537.25, 105.125), (0, 250, 0));
  scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback((-951, 471.75, 107.125), (0, 86, 0));
  scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding((-965, 492.5, 73), (0, 75, 0));
  scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled((-975, 457.5, 73), (0, 95, 0));
  scripts\cp\laser_traps\cp_laser_traps::ref_11cb8((-952.5, 432.25, 107.125), (0, 110, 0));
}

function teamanchoredinfoomnvars() {
  ref_135f6((-975, 616, 72), (0, 25, 0), "ammo_crate");
  ref_135f6((-975, 415, 72), (0, -25, 0), "grenade_crate");
}

function switch_weapon_from_minigun() {
  foreach(var_1 in getEntArray("trigger_hurt", "classname")) {
    if(var_1.origin[2] == -32) {
      var_1 delete();
      break;
    }
  }

  var_3 = spawn("script_model", (1006.75, -2239, 123.75));
  var_3.angles = (0, 3.998, 0);
  var_4 = getEnt("clip64x64x64", "targetname");
  var_3 clonebrushmodeltoscriptmodel(var_4);
}

function weapon_xp_iw8_sn_crossbow() {
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  switch_weapon_from_minigun();
  init_flags();
  stopstreamtomovingplane();
  init_fx();
  superslotcleanup();
  level.ignorescoring = 1;
  ref_14379();
  store_platform_models();
  subway_black_screen_fade_in();
  stoppingpower_clearhcronperkscleared();
  switchespaused();
  teamanchoredinfoomnvars();
  level.custom_player_hotjoin_func = &init_player;
  level.infil_lbravo_is_alive = 0;

  foreach(var_1 in level.players) {
    thread init_player();
  }

  thread target_play_death_anim();
  setomnvar("cp_objective_index", 1);
  setomnvar("cp_objective_sub_4_index", 2);

  foreach(var_4 in level.bombs) {
    thread stoppingpowercanonehitkill(var_4);
  }

  thread cqb_laser_guy();
  thread ref_11b3e();
  thread get_drone_movement_vector();

  while(level.current_checkpoint < level.bombs.size) {
    level waittill("bomb_defused");
  }

  scripts\engine\utility::flag_set("all_bombs_defused");
  setomnvar("cp_objective_sub_4_index", 6);
  var_6 = scripts\engine\utility::getStruct("lz", "targetname");
  thread ref_13548(var_6);
  ref_11e5c("objective_lz", &"CP_SO_SAFEHOUSE/OBJECTIVE_EXFIL_LBL", undefined, "allies", undefined, var_6.origin + (0, 0, 15), "exfil_arrived");
  thread friendly_dmg_text_cooldown(var_6);
  level waittill("exfil_called");
  wait 60;

  if(isDefined(level.silo_thrust_dogtag_revive) && isalive(level.silo_thrust_dogtag_revive)) {
    thread logevent_munitionused(&"CP_SO_SAFEHOUSE/OBJECTIVE_EXFIL_CLEAR", 15);
    level.silo_thrust_dogtag_revive waittill("death");
  }

  thread ref_13549();
  level waittill("mission_complete");
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function friendly_dmg_text_cooldown(var_0) {
  ref_11a9a(var_0, &"CP_SO_SAFEHOUSE/CALL_EXFIL");
  var_1 = getgroundposition(var_0.origin, 1);
  magicgrenademanual("deploy_airdrop_mp", var_1, (0, 0, 0), 0.01);
  level notify("exfil_called");
}

function ref_13549() {
  var_0 = scripts\common\utility::getvehiclespawner("exfil_heli", "targetname");
  var_1 = undefined;

  foreach(var_3 in scripts\engine\utility::getStructArray(var_0.target, "targetname")) {
    if(isDefined(var_3.script_type)) {
      continue;
    }

    var_1 = var_3;
    break;
  }

  var_5 = 0;

  while(isDefined(var_1.target)) {
    var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    var_5++;

    switch (var_5) {
      case 5:
      case 4:
        var_1.origin += (0, 0, 50);
        break;
    }
  }

  var_6 = var_0 scripts\common\vehicle::spawn_vehicle_and_gopath();

  if(isDefined(var_6) && isDefined(var_6.riders)) {
    foreach(var_8 in var_6.riders) {
      var_8.ignoreme = 1;
    }
  }

  var_10 = spawn("script_model", var_6.origin);
  var_10 setModel("veh8_mil_air_lbravo_personnel_platform");
  var_10 linkTo(var_6, "tag_origin", (0, 0, -73), (0, 0, 0));
  var_11 = spawn("script_model", var_6.origin);
  var_11 dontinterpolate();
  var_11.angles = var_6.angles;
  var_11 linkTo(var_6);
  var_12 = getEnt("exfil_heli_col", "targetname");
  var_11 clonebrushmodeltoscriptmodel(var_12);
  var_13 = anglestoright(var_6.angles) * 64;
  var_14 = anglestoright(var_6.angles) * -64;
  var_15 = anglesToForward(var_6.angles) * 64;
  var_16 = anglesToForward(var_6.angles) * -64;
  ref_11a87(var_6, var_13 + var_15);
  ref_11a87(var_6, var_14 + var_15);
  ref_11a87(var_6, var_13 + var_16);
  ref_11a87(var_6, var_14 + var_16);
  level notify("exfil_arriving");
  ref_11e5c("objective_exfil", &"CP_SO_SAFEHOUSE/OBJECTIVE_HELI_LBL", "icon_waypoint_vehicle_little_bird", "allies", var_6, undefined, "mission_complete", 1, 0);
  waitframe();
  level.should_do_damage_check_func = &ref_132c0;
  scripts\engine\utility::flag_wait("exfil_arrived");
  thread logevent_munitionused(&"CP_SO_SAFEHOUSE/REGROUP_EXFIL", 15);

  for(;;) {
    var_17 = [];

    foreach(var_19 in level.players) {
      if(var_19.inlaststand || distance2dsquared(var_19.origin, var_6.origin) > 40000) {
        continue;
      }

      var_17 = var_19;
    }

    if(var_17.size > 0 && isDefined(level.waittill_any_timeout_3) && scripts\engine\utility::time_has_passed(level.players, 10)) {
      scripts\engine\utility::random(var_17) scripts\cp\cp_player_battlechatter::dosound("obj_exfil_nag");
      level.waittill_any_timeout_3 = gettime();
    }

    if(var_17.size == level.players.size) {
      break;
    }

    waitframe();
  }

  level notify("mission_complete");
}

function ref_11a87(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin + var_1);
  var_2 dontinterpolate();
  var_2.angles = var_0.angles;
  var_2 linkTo(var_0);
  var_3 = getEnt("clip256x256x256", "targetname");
  var_2 clonebrushmodeltoscriptmodel(var_3);
}

function ref_132c0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_5.team == "allies") {
    return false;
  }

  return true;
}

function ref_11a9a(var_0) {
  if(!isDefined(self.origin)) {
    return;
  }

  var_1 = spawn("script_model", self.origin);
  var_1 endon("death");
  var_1.isusable = 1;
  var_1 setCursorHint("hint_button");
  var_1 sethintdisplayfov(360);
  var_1 setusefov(135);
  var_1 sethintdisplayrange(500);
  var_1 setuserange(80);
  var_1 sethintonobstruction("show");
  var_1 setuseholdduration("duration_none");
  var_1 sethintlockplayermovement(1);
  var_1 makeusable();
  var_1 setHintString(var_0);
  var_1.userate = 1;
  var_1.laststandfinisherdone = 4;
  var_1.curprogress = 0;
  var_1.usetime = 5;
  var_1.inuse = 0;
  var_1.playerusing = undefined;
  var_1 waittill("trigger", var_2);
  var_1 delete();
}

function ref_11e5c(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  thread ref_11e5d(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

function ref_11e5d(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = scripts\cp\cp_objectives::requestworldid(var_0, 3);

  if(isDefined(var_1)) {
    objective_setlabel(var_9, var_1);
  }

  objective_state(var_9, "current");

  if(!isDefined(var_2)) {
    var_2 = "icon_waypoint_objective_general";
  }

  objective_icon(var_9, var_2);

  if(isDefined(var_3)) {
    objective_setownerteam(var_9, var_3);
  }

  if(isDefined(var_4)) {
    if(!isarray(var_4)) {
      var_4 = [var_4];
    }

    var_10 = 0;

    foreach(var_12 in var_4) {
      objective_setlocation(var_9, var_10, var_12);

      if(isDefined(var_5)) {
        objective_setzoffset(var_9, var_5);
      }

      var_10++;
    }
  } else if(isDefined(var_5)) {
    objective_position(var_9, var_5);
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(!isDefined(var_8)) {
    var_8 = 1;
  }

  objective_setplayintro(var_9, var_7);
  objective_setplayoutro(var_9, var_8);
  level waittill(var_6);
  objective_state(var_9, "done");
}

function propinputwatch(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(istrue(var_3.spectating) || istrue(var_3.inlaststand)) {
      continue;
    }

    var_1 = var_3.origin;
  }

  if(var_1.size == 0) {
    return scripts\engine\utility::random(level.mini_map_origin_fix);
  }

  var_5 = averagepoint(var_1);
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in level.mini_map_origin_fix) {
    if(isDefined(var_0) && var_0[0] == var_9[0]) {
      continue;
    }

    var_10 = distance2dsquared(var_5, var_9[0]);

    if(!isDefined(var_6) || var_10 > var_6) {
      var_6 = var_10;
      var_7 = var_9;
    }
  }

  return var_7;
}

function projdistsq(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = self.origin;
  }

  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    var_6 = distance2dsquared(var_0, var_5[0]);

    if(!isDefined(var_2) || var_6 < var_2) {
      var_2 = var_6;
      var_3 = var_7;
    }
  }

  return var_3;
}

function get_drone_movement_vector() {
  for(var_0 = 0; var_0 < 3; var_0++) {
    level waittill("bomb_defused", var_1, var_2);
    thread minigameinfo(var_1, var_2, 2, 1);
    thread minigameinfo(var_1, var_2, 5);
  }
}

function minigameinfo(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  wait var_2;
  var_4 = undefined;
  var_5 = undefined;

  for(var_6 = 0; var_6 < var_0.minigun_attack_min_cooldown.size; var_6++) {
    var_4 = var_0.minigun_attack_min_cooldown[var_6];

    if(!istrue(level.mini_map_origin_fix[var_4]["has_package"])) {
      var_5 = level.mini_map_origin_fix[var_4];
      break;
    }
  }

  if(!isDefined(var_5)) {
    thread logevent_munitionused(&"CP_SO_SAFEHOUSE/CAREPACKAGE_DONE", 3);
    return;
  }

  ref_1243d(level.players, "dx_mpa_rutl_airdrop_friendly_use", 1, 30);

  if(!istrue(var_3)) {
    var_7 = [ &"CP_SO_SAFEHOUSE/CAREPACKAGE_DROP_A", &"CP_SO_SAFEHOUSE/CAREPACKAGE_DROP_B", &"CP_SO_SAFEHOUSE/CAREPACKAGE_DROP_C", &"CP_SO_SAFEHOUSE/CAREPACKAGE_DROP_D"];
    var_8 = var_7[var_0.objindex];
    thread logevent_munitionused(var_8, 3);
  }

  level.mini_map_origin_fix[var_4]["has_package"] = 1;
  level childthread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(8000, 20000, var_5[1], var_5[0] + (0, 0, 1000), undefined, &weapon_xp_iw8_sn_sbeta);
}

function voqueue() {}

function logevent_munitionused(var_0, var_1) {
  foreach(var_3 in level.players) {
    thread logevent_kidnapevent(var_3, var_0, var_1);
  }
}

function logevent_kidnapevent(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("new_msg");
  var_0 endon("new_msg");
  var_0 clearhudtutorialmessage();
  wait 0.5;
  var_0 sethudtutorialmessage(var_1);
  wait var_2;
  var_0 clearhudtutorialmessage();
}

function weapon_xp_iw8_sn_sbeta(var_0, var_1, var_2) {
  if(scripts\cp\laser_traps\cp_laser_traps::ref_124d0(var_0)) {
    thread logevent_kidnapevent(var_0, &"CP_BR/MUN_SLOTS_FULL", 3);
    return false;
  }

  if(!isDefined(level.get_dropoff_point_spawner)) {
    level.get_dropoff_point_spawner = 0;
  }

  var_3 = projdistsq(var_0.origin, level.mini_map_origin_fix);
  var_4 = ["sentry", "sentry", "juggernaut"];
  var_5 = ["dx_mpa_rutl_sentry_gun_achieve", "dx_mpa_rutl_sentry_gun_achieve", "dx_mpa_rutl_juggernaut_achieve"];
  var_6 = var_5[level.get_dropoff_point_spawner];
  ref_1243d(var_0, var_6, 1, 10);
  level.mini_map_origin_fix[var_3]["has_package"] = 0;
  scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var_0, var_4[level.get_dropoff_point_spawner]);
  level.get_dropoff_point_spawner++;

  if(level.get_dropoff_point_spawner >= var_4.size) {
    level.get_dropoff_point_spawner = 0;
  }

  return true;
}

function ref_1435c() {
  self.ref_12c9d = 1;

  while(self.ref_12c9d > 0) {
    self waittillmatch("munitions_used", "respawn");
    var_0 = level.players_in_respawn_queue[0];
    var_1 = projdistsq(self.origin, level.ref_12c8e);
    var_0.forcespawnorigin = level.ref_12c8e[var_1][0];
    var_0.forcespawnangles = level.ref_12c8e[var_1][1];
  }

  self.ref_12c9d = undefined;
}

function pretrograd_interaction_effects() {
  foreach(var_1 in level.players) {
    if(istrue(var_1.spectating)) {
      continue;
    }

    if(ref_124b1(var_1)) {
      return true;
    }
  }

  return false;
}

function ref_124b1(var_0) {
  for(var_1 = 0; var_1 < var_0.munition_slots.size; var_1++) {
    if(var_0 scripts\cp\loot_system::is_empty_or_none(var_1)) {
      continue;
    }

    if(var_0.munition_slots[var_1].ref == "respawn") {
      return true;
    }
  }

  return false;
}

function prev_weapon_taccover() {
  foreach(var_1 in level.players) {
    if(istrue(var_1.spectating)) {
      return true;
    }
  }

  return false;
}

function ref_11b3e() {
  ref_1243d(level.players, "dx_mpa_rutl_boost_genericround");
  ref_1243d(level.players, "dx_mpa_rutl_boost_infected", 10);
}

function bombs_explode() {
  var_0 = [];

  foreach(var_2 in level.bombs) {
    if(!istrue(var_2.defused)) {
      var_0 = var_2;
    }
  }

  var_4 = [];

  foreach(var_2 in var_0) {
    if(!istrue(var_2.inuse)) {
      var_4 = var_2;
    }
  }

  var_7 = 0;

  foreach(var_2 in var_0) {
    thread explode(var_2);
    wait randomfloatrange(0.1, 0.3);
  }

  scripts\engine\utility::flag_wait("bomb_exploded");
  wait 2;
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

function explode(var_0) {
  var_1 = self;
  var_1 endon("bomb_defused");
  var_2 = gettime();

  if(var_1.inuse) {
    var_1 waittill("not_in_use");
  }

  if(!var_0 || scripts\engine\utility::time_has_passed(var_2, 1)) {
    foreach(var_4 in level.players) {
      var_1 playsoundtoplayer("exp_bombsite_lr", var_4);
    }
  }

  playFX(level._effect["bomb_vest_explode"], var_1.origin);
  playFX(level._effect["coop_bomb_defusal_explode"], var_1.origin);
  earthquake(1, 2, var_1.origin, 3000);

  foreach(var_7 in getaiarrayinradius(var_1.origin, 1000)) {
    var_7 kill(var_1.origin);
  }

  foreach(var_4 in level.players) {
    if(distance2dsquared(var_4.origin, var_1.origin) < squared(1000)) {
      var_4 kill(var_1.origin);
    }
  }

  objective_state(var_1.objindex, "failed");
  var_1.exploded = 1;
  var_1 hide();
  scripts\engine\utility::flag_set("bomb_exploded");
}

function ref_1350b(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3.objindex = level.bombs.size;
  var_3.angles = var_1;
  var_3.name = var_2;
  var_3 setModel("offhand_wm_briefcase_bomb");
  thread ref_1448e();

  if(isDefined(var_2) && scripts\engine\utility::array_contains_key(level.cpvehiclename, var_2)) {
    level.cpvehiclename[var_2].bomb = var_3;
  }

  return var_3;
}

function ref_135f6(var_0, var_1, var_2) {
  var_3 = "military_crate_large_stackable_01";

  if(var_2 == "ammo_crate") {
    var_4 = &"CP_SO_SAFEHOUSE/TAKE_AMMO_CRATE";
    var_5 = "cp_crafted_icon_ammo_crate";
    var_6 = "cp_crafted_icon_ammo_crate";
    var_7 = &ref_124aa;
    var_8 = &"CP_SO_SAFEHOUSE/HAVE_AMMO_CRATE_RED";
  } else {
    var_4 = &"CP_SO_SAFEHOUSE/TAKE_GRENADE_CRATE";
    var_5 = "cp_crafted_icon_explosive";
    var_6 = "cp_crafted_icon_explosive";
    var_7 = &ref_124ac;
    var_8 = &"CP_SO_SAFEHOUSE/HAVE_GRENADE_CRATE_RED";
  }

  var_9 = scripts\cp\laser_traps\cp_laser_traps::ref_139aa(var_5, var_6, &ref_14541, var_8, var_4, var_5, var_6, var_7, undefined, var_8);
  addclienttoheadiconmask(var_9.headiconid, 30);
  setheadiconmaxdistance(var_9.headiconid, 200);
  var_9.type = var_7;
  var_10 = spawn("script_model", var_9.origin);
  var_10 dontinterpolate();
  var_10.angles = var_9.angles;
  var_11 = getEnt("military_crate_col", "targetname");
  var_10 clonebrushmodeltoscriptmodel(var_11);
  return var_9;
}

function ref_14541(var_0, var_1) {
  if(scripts\cp\laser_traps\cp_laser_traps::ref_124d0(var_1)) {
    thread logevent_kidnapevent(var_1, &"CP_BR/MUN_SLOTS_FULL", 3);
    return false;
  }

  for(var_2 = 0; var_2 < var_1.munition_slots.size; var_2++) {
    if(var_1.munition_slots[var_2].ref == "ammo_crate") {
      var_1 scripts\cp\cp_munitions::remove_munition(var_2, "ammo_crate");
    }

    if(var_1.munition_slots[var_2].ref == "grenade_crate") {
      var_1 scripts\cp\cp_munitions::remove_munition(var_2, "grenade_crate");
    }
  }

  var_1 scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var_1, var_0.type);
  return true;
}

function ref_124ac(var_0) {
  if(!isDefined(var_0.munition_slots)) {
    return false;
  }

  for(var_1 = 0; var_1 < var_0.munition_slots.size; var_1++) {
    if(var_0.munition_slots[var_1].ref == "grenade_crate") {
      return true;
    }
  }

  return false;
}

function ref_124aa(var_0) {
  if(!isDefined(var_0.munition_slots)) {
    return false;
  }

  for(var_1 = 0; var_1 < var_0.munition_slots.size; var_1++) {
    if(var_0.munition_slots[var_1].ref == "ammo_crate") {
      return true;
    }
  }

  return false;
}

function propclonepower() {
  var_0 = [9, 13, 16, 16];

  if(!isDefined(level.players) || level.players.size < 1) {
    return var_0[0];
  }

  return var_0[level.players.size - 1];
}

function propcontrolshud() {
  var_0 = [14, 14, 10, 10];

  if(!isDefined(level.players) || level.players.size < 1) {
    return var_0[0];
  }

  return var_0[level.players.size - 1];
}

function propdeathfx() {
  var_0 = [0.4, 0.4, 0.4, 0.4];

  if(!isDefined(level.players) || level.players.size < 1) {
    return var_0[0];
  }

  return var_0[level.players.size - 1];
}

function ref_1448e() {
  self endon("death");
  self endon("bomb_defused");
  self.isusable = 1;
  var_0 = self;
  var_1 = [ &"CP_SO_SAFEHOUSE/OBJECTIVE_A", &"CP_SO_SAFEHOUSE/OBJECTIVE_B", &"CP_SO_SAFEHOUSE/OBJECTIVE_C", &"CP_SO_SAFEHOUSE/OBJECTIVE_D"];
  var_0 setCursorHint("HINT_NOICON");
  var_0 sethintdisplayfov(360);
  var_0 setusefov(360);
  var_0 sethintdisplayrange(500);
  var_0 setuserange(84);
  var_0 sethintonobstruction("show");
  var_0 setuseholdduration("duration_short");
  var_0 sethintlockplayermovement(1);
  var_0 setHintString(var_1[self.objindex]);
  var_0 setusepriority(-10);
  var_0 makeusable();
  var_0.curprogress = 0;
  var_0.userate = 1;
  var_0.laststanddowneddata = propcontrolshud();
  var_0.laststandfinisherdone = propdeathfx();
  var_0.usetime = propclonepower();
  var_0.inuse = 0;
  var_0.playerusing = undefined;
  var_0.ref_1387d = getcompleteweaponname("briefcase_bomb_defuse_mp");

  for(;;) {
    if(!isDefined(var_0.laststanddowneddata) || !isDefined(var_0.laststandfinisherdone) || !isDefined(var_0.usetime)) {
      var_0.laststanddowneddata = propcontrolshud();
      var_0.laststandfinisherdone = propdeathfx();
      var_0.usetime = propclonepower();
      wait 1;
      continue;
    }

    GscBinSkip4(0x35, var_0);
  }
}

function ref_14368(var_0) {
  var_0 endon("death");
  var_0 endon("trigger");

  if(true) {
    return;
  }

  wait var_0.laststanddowneddata;

  for(;;) {
    var_0.curprogress -= level.framedurationseconds * var_0.laststandfinisherdone;
    var_1 = clamp(var_0.curprogress / var_0.usetime, 0, 1);
    objective_setprogress(self.objindex, var_1);

    if(var_0.curprogress <= 0) {
      objective_setshowprogress(self.objindex, 0);
      var_0.curprogress = 0;
      return;
    }

    waitframe();
  }
}

function ref_1448f(var_0, var_1) {
  var_0 endon("death_or_disconnect");
  var_0 endon("last_stand");
  var_1.userate = scripts\engine\utility::ter_op(isDefined(var_0.objectivescaler), var_0.objectivescaler, var_1.userate);

  while(get_alertreset_alias(var_0, var_1) && var_0 useButtonPressed()) {
    var_1.curprogress += level.framedurationseconds * var_1.userate;
    var_2 = clamp(var_1.curprogress / var_1.usetime, 0, 1);
    objective_setprogress(self.objindex, var_2);
    var_0 setclientomnvar("ui_securing_progress", var_2);

    if(var_1.curprogress >= var_1.usetime) {
      return true;
    }

    waitframe();
  }

  return false;
}

function ref_1387f(var_0, var_1) {
  var_0 endon("death_or_disconnect");

  if(isDefined(var_0 getcurrentweapon()) && var_0 getcurrentweapon().basename == "iw8_lm_dblmg_mp") {
    scripts\cp\cp_weapon::minigamefinishcount(var_0);

    while(var_0 getcurrentweapon().basename == "iw8_lm_dblmg_mp" || var_0 getcurrentweapon().basename == "none") {
      waitframe();
    }
  }

  var_1.ref_13f76 = var_0 getcurrentweapon();
  var_0 setclientomnvar("ui_securing_progress", var_1.curprogress / var_1.usetime);
  var_1.inuse = 1;
  self notify("in_use");

  if(!isDefined(level.waittill_end_condition_met) || scripts\engine\utility::time_has_passed(level.waittill_end_condition_met, 10)) {
    level.waittill_end_condition_met = gettime();

    if(self.objindex == 0) {
      ref_1243d(level.players, "dx_mpa_rutl_bomb_defusing_a", 1);
    } else if(self.objindex == 1) {
      ref_1243d(level.players, "dx_mpa_rutl_bomb_defusing_b", 1);
    } else {
      ref_1243d(level.players, "dx_mpa_rutl_bomb_defusing", 1);
    }
  }

  var_1 makeunusable();
  objective_setlabel(self.objindex, &"MP_INGAME_ONLY/OBJ_DEFUSING_CAPS");
  objective_setshowprogress(self.objindex, 1);
  objective_sethot(self.objindex, 1);
  var_0 setmovespeedscale(0.2);
  var_0 giveweapon(var_1.ref_1387d);
  var_0 scripts\cp\cp_weapons::switchtoweaponreliable(var_1.ref_1387d);
  var_0 setclientomnvar("ui_securing", 9);
  var_0 scripts\common\utility::allow_movement(0, "bomb_use");
  var_0 scripts\common\utility::allow_jump(0, "bomb_use");
  var_0 scripts\common\utility::allow_mount_side(0, "bomb_use");
  var_0 scripts\common\utility::allow_mount_top(0, "bomb_use");
  var_0 scripts\common\utility::allow_mantle(0, "bomb_use");
  var_0 scripts\common\utility::allow_offhand_weapons(0, "bomb_use");
  var_0 scripts\common\utility::brjugg_onplayerkilled(0, "bomb_use");
  var_0 scripts\common\utility::allow_weapon_pickup(0, "bomb_use");
  return true;
}

function ref_138f5(var_0, var_1, var_2) {
  var_0 endon("death_or_disconnect");
  var_0 scripts\common\utility::allow_movement(1, "bomb_use");
  var_0 scripts\common\utility::allow_jump(1, "bomb_use");
  var_0 scripts\common\utility::allow_mount_side(1, "bomb_use");
  var_0 scripts\common\utility::allow_mount_top(1, "bomb_use");
  var_0 scripts\common\utility::allow_mantle(1, "bomb_use");
  var_0 scripts\common\utility::allow_offhand_weapons(1, "bomb_use");
  var_0 scripts\common\utility::brjugg_onplayerkilled(1, "bomb_use");
  var_0 setmovespeedscale(0.2);
  var_0 scripts\cp\cp_weapons::switchtoweaponreliable(var_1.ref_13f76);
  var_0 takeweapon(var_1.ref_1387d);

  if(istrue(var_0.inlaststand)) {
    thread logevent_kidnapevent(var_0, &"CP_SO_SAFEHOUSE/DROP_BOMB_HINT", 3);
    var_0.min_dist_sq_from_node = var_1.ref_13f76;
  }

  objective_setlabel(self.objindex, &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS");
  objective_sethot(self.objindex, 0);
  var_1.inuse = 0;
  self notify("not_in_use");
  var_1 makeusable();
  var_0 setclientomnvar("ui_securing", 0);
  var_0 setclientomnvar("ui_securing_progress", var_1.curprogress / var_1.usetime);
  var_0 scripts\common\utility::allow_weapon_pickup(1, "bomb_use");
  var_0 setmovespeedscale(1);
}

function keypad_disable_for_time(var_0) {
  self makeunusable();
  self.isusable = 0;
  objective_state(self.objindex, "done");
  self.defused = 1;
  level.current_checkpoint++;

  if(level.current_checkpoint < level.bombs.size - 1) {
    ref_1243d(level.players, "dx_mpa_rutl_bomb_defused", 3);
  } else if(level.current_checkpoint < level.bombs.size) {
    ref_1243d(level.players, "dx_mpa_rutl_boost_winning_matchpoint", 3);
  } else {
    ref_1243d(level.players, "dx_mpa_rutl_exfilwinning_start_winningteam", 3);
  }

  self notify("bomb_defused");
  level notify("bomb_defused", self, var_0);
}

function get_carry_item_omnvar(var_0, var_1) {
  return get_alertreset_alias(var_0, var_1);
}

function get_alertreset_alias(var_0, var_1) {
  if(!trial_use_headicon()) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var_0 meleeButtonPressed()) {
    return false;
  }

  if(!self.isusable) {
    return false;
  }

  return true;
}

function trial_use_headicon() {
  if(isDefined(self.last_stand_state)) {
    return false;
  }

  return true;
}

function completepayloadpunish(var_0, var_1, var_2) {
  var_3 = self;

  if(!isPlayer(var_3)) {
    return;
  }

  var_3.movespeedscale = 0;
  var_3 setmovespeedscale(0);

  if(!isDefined(var_3.movespeedscale)) {
    var_3.movespeedscale = 1;
  }

  var_4 = &movespeed_get_func;
  var_5 = &movespeed_set_func;
  thread player_speed_proc(var_3, var_0, var_1, var_4, var_5, "blend_movespeedscale");
}

function player_speed_proc(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify(var_4);
  self endon(var_4);
  var_6 = [[var_2]](var_5);
  var_7 = var_0;

  if(isDefined(var_1) && var_1 > 0) {
    var_8 = var_7 - var_6;
    var_9 = 0.05;
    var_10 = var_1 / var_9;
    var_11 = var_8 / var_10;

    while(abs(var_7 - var_6) > abs(var_11 * 1.1)) {
      var_6 += var_11;
      [[var_3]](var_6, var_5);
      wait var_9;
    }
  }

  [[var_3]](var_7, var_5);
}

function movespeed_get_func(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(!isDefined(self.movespeedscales) || !isDefined(self.movespeedscales[var_0])) {
    return 1;
  }

  return self.movespeedscales[var_0];
}

function movespeed_set_func(var_0, var_1) {
  var_2 = 1;

  if(!isDefined(var_1)) {
    var_1 = "default";
  }

  self.movespeedscales[var_1] = var_0;

  foreach(var_0 in self.movespeedscales) {
    if(var_0 == 1) {
      self.movespeedscales = scripts\engine\utility::array_remove_key(self.movespeedscales, var_4);
    }

    var_2 *= var_0;
  }

  self.movespeedscale = var_2;
  self setmovespeedscale(self.movespeedscale);
}

function ref_1243d(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    wait var_3;
  }

  if(isDefined(var_2)) {
    if(!isDefined(level.waittill_dropped_cash_collected)) {
      level.waittill_dropped_cash_collected = [];
    }

    var_4 = level.waittill_dropped_cash_collected[var_0];

    if(!isDefined(var_4) || scripts\engine\utility::time_has_passed(var_4, var_2)) {
      level.waittill_dropped_cash_collected[var_0] = gettime();
    } else {
      return 0;
    }
  }

  if(isarray(self)) {
    foreach(var_6 in self) {
      thread ref_1243a(var_6, var_0);
    }

    return;
  }

  thread ref_1243a(var_0, var_1);
}

function ref_1243a(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");

  if(isarray(var_0)) {
    var_0 = scripts\engine\utility::random(var_0);
  }

  if(!soundexists(var_0)) {
    return false;
  }

  if(istrue(var_2.dialogue_playing)) {
    if(isDefined(var_1)) {
      var_2 scripts\engine\utility::waittill_notify_or_timeout("vo_done", var_1);
    }

    if(istrue(var_2.dialogue_playing)) {
      return false;
    }
  }

  var_2.dialogue_playing = 1;
  var_2.current_dialogue = var_0;
  var_2 playlocalsound(var_0);
  wait lookupsoundlength(var_0) / 1000;
  var_2.dialogue_playing = 0;
  var_2.current_dialogue = "";
  var_2 notify("vo_done", var_0);
  return true;
}

function ref_1238e(var_0, var_1, var_2, var_3, var_4) {
  [var_6] = strtok(var_0, "+");
  var_7 = scripts\engine\utility::array_remove(var_5, var_6);
  var_8 = scripts\cp\cp_weapon::buildweapon(var_6, var_7);
  var_9 = "weapon_" + var_6;
  var_10 = scripts\cp\utility::array_merge(var_8.attachments, var_7);

  foreach(var_12 in var_10) {
    var_9 += "+" + var_12;
  }

  var_14 = spawn(var_9, var_1, 1);
  var_14.angles = var_2;
  var_3 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, weaponclipsize(var_6));
  var_4 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, weaponmaxammo(var_6));
  var_14 itemweaponsetammo(var_3, var_4);
  return var_14;
}