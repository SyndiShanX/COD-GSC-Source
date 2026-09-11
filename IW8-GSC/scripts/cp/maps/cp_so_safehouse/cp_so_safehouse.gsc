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

  var0 = getDvar("cp_so_safehouse_start_obj", "");

  if(isDefined(var0) && var0 != "") {
    thread rundebugstartobjective(level);
  }

  level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  scripts\cp\cp_compass::setupminimap("compass_map_cp_so_safehouse");
  scripts\engine\utility::flag_set("infil_complete");
  level.laststand_enter_gamemodespecificaction = &enter_laststand;
  level.laststand_exit_gamemodespecificaction = &exit_laststand;
  thread weapon_xp_iw8_sn_crossbow();
}

function mud_sfx(var0) {
  if(var0 == "axis") {
    return 0;
  }

  var1 = 60000;

  if(level.time_survived < 8 * var1) {
    return 3;
  } else if(level.time_survived < 10 * var1) {
    return 2;
  } else if(level.time_survived < 16 * var1) {
    return 1;
  }

  return 0;
}

function display_ai() {
  level endon("game_ended");
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

      if(var7 < 20) {
        var8 = var1;
      } else if(var7 < 30) {
        var8 = var0;
      } else {
        var8 = var2;
      }

      var4 += 15;
    }

    waitframe();
  }
}

function enter_laststand(var0, var1) {
  var2 = [];

  foreach(var4 in level.players) {
    if(var4 != var0 && !istrue(var4.inlaststand)) {
      var2 = var4;
    }
  }

  if(var2.size == 1) {
    ref_1243d(var2[0], "dx_mpa_rutl_lastalive_revive", 5, 10);
  }

  if(scripts\engine\utility::is_equal(var1, level.silo_thrust_dogtag_revive)) {
    level.silo_thrust_dogtag_revive.milestonephasepercent_lzs = var0;

    foreach(var4 in level.players) {
      var7 = scripts\engine\utility::ter_op(var4 == var0, &"CP_SO_SAFEHOUSE/HELO_DOWNED_PLAYER", &"CP_SO_SAFEHOUSE/HELO_DOWNED_ALLY");
      thread logevent_kidnapevent(var4, var4, var7);
    }
  }

  scripts\cp\gametypes\cp_specops::enter_laststand(var0, var1);
}

function exit_laststand(var0) {
  scripts\cp\gametypes\cp_specops::exit_laststand_func(var0);

  if(isDefined(var0.min_dist_sq_from_node)) {
    var0 switchtoweapon(var0.min_dist_sq_from_node);
    var0.min_dist_sq_from_node = undefined;
  }

  ref_1243d(var0, "dx_mpa_rutl_gamestate_losing", 1, 5);
}

function init_loot_structs() {
  var0 = spawnStruct();
  var0.origin = (0, 0, 1000);
  var0.angles = (0, 0, 0);
  var0.name = "alpha";
  var0.script_noteworthy = "infil_lbravo";
  var0.script_team = "allies";
  var0.spawnflags = int(1);
  var0.targetname = "cp_infil";
  var0.target = "infil_scene";
  level.struct_class_names["targetname"]["cp_infil"] = [var0];
  var0 = spawnStruct();
  var0.origin = (-2000, -5000, 1000);
  var0.angles = (0, 3, 0);
  var0.targetname = "infil_scene";
  var0.target = "lbravoAlphaAdvancedPath";
  level.struct_class_names["targetname"]["infil_scene"] = [var0];
  var0 = spawnStruct();
  var0.ref_12f91 = int(1);
  var0.classname = "script_struct_heli";
  var0.target = "custom3194";
  var0.script_decel = int(50);
  var0.angles = (0, 318, 0);
  var0.lookahead = int(1);
  var0.origin = (-600, -1000, 1000);
  var0.script_accel = int(50);
  var0.speed = int(120);
  var0.targetname = "lbravoAlphaAdvancedPath";
  level.struct_class_names["targetname"]["lbravoAlphaAdvancedPath"] = [var0];
  var0 = spawnStruct();
  var0.script_decel = int(20);
  var0.script_goalyaw = 1;
  var0.target = "custom3208";
  var0.targetname = "custom3194";
  var0.radius = int(400);
  var0.angles = (0, 325, 0);
  var0.lookahead = int(1);
  var0.origin = (-300, -500, 1000);
  var0.ref_12f91 = int(1);
  var0.classname = "script_struct_heli";
  var0.script_accel = int(20);
  var0.speed = int(120);
  level.struct_class_names["targetname"]["custom3194"] = [var0];
  var0 = spawnStruct();
  var0.script_decel = int(20);
  var0.script_goalyaw = 1;
  var0.targetname = "custom3208";
  var0.radius = int(200);
  var0.angles = (0, 165, 0);
  var0.lookahead = int(1);
  var0.origin = (0, 0, 500);
  var0.ref_12f91 = int(1);
  var0.classname = "script_struct_heli";
  var0.script_accel = int(20);
  var0.speed = int(100);
  level.struct_class_names["targetname"]["custom3208"] = [var0];
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

function weapon_xp_iw8_sn_mike14(var0) {
  thread scripts\cp\helicopter\chopper_boss::spawnplayer_internal(0);
}

function weapon_xp_iw8_sn_hdromeo(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  scripts\cp\cp_laststand::enter_camera_zoomout();

  if(istrue(var0.fauxdead)) {
    var0.fauxdead = undefined;
    var0 scripts\cp\cp_laststand::enter_bleed_out(var0);
    var0 scripts\cp\cp_laststand::playslamzoomflash();
  } else {
    scripts\cp\cp_laststand::camera_zoomout(var0, var1, undefined);
  }

  scripts\cp\cp_laststand::exit_camera_zoomout();

  if(!isDefined(level.players_in_respawn_queue)) {
    level.players_in_respawn_queue = [];
  }

  level.players_in_respawn_queue = scripts\engine\utility::array_add(level.players_in_respawn_queue, var0);
  var12 = 0;
  var13 = undefined;

  foreach(var15 in level.players) {
    if(var15.sessionstate == "spectator") {
      var12++;
    }
  }

  if(var12 == level.players.size - 1) {
    foreach(var15 in level.players) {
      if(var15.sessionstate == "spectator") {}
    }
  }

  foreach(var15 in level.players) {
    if(!istrue(level.player_cam_disable)) {
      level.player_cam_disable = 1;

      foreach(var15 in level.players) {
        var15.respawn_active = 0;
      }
    }
  }

  for(;;) {
    var23 = var0 scripts\engine\utility::ref_143ad("respawn_player", "auto_respawn");

    if(isDefined(var23)) {
      if(istrue(var0.binc130)) {
        continue;
      }

      if(var23 == "auto_respawn") {
        foreach(var15 in level.players) {
          var15 thread scripts\cp\cp_hud_message::showsplash("auto_respawn");
        }
      }

      level.players_in_respawn_queue = scripts\engine\utility::array_remove(level.players_in_respawn_queue, var0);
      return 1;
    }
  }
}

function ref_124a6() {
  scripts\cp\gametypes\cp_specops::givedefaultloadout();
  self setsuit("iw8_suit_cp");
  var0 = "iw8_ar_scharlie_mp";
  var1 = ["fastreload", "front_scharlie", "gripang", "mag_scharlie", "pistolgrip01_scharlie", "rec_scharlie", "reflex_west01_irons", "selectsemi", "stocks_scharlie"];
  var2 = scripts\cp\cp_weapon::buildweapon(var0, var1, "none", "none", 0);
  self giveweapon(var2);
  self setweaponammoclip(var2, weaponclipsize(var2));
  self setweaponammostock(var2, weaponmaxammo(var2));
  self switchtoweapon(var2);
  var3 = "iw8_sh_romeo870_mp";
  var1 = ["barshort_romeo870", "fmj_small", "griprail_romeo870", "gripvertpro_romeo870", "ironsdefault_romeo870", "rec_romeo870", "stockno_romeo870"];
  var4 = scripts\cp\cp_weapon::buildweapon(var3, var1, "none", "none", 0);
  self giveweapon(var4);
  self setweaponammoclip(var4, weaponclipsize(var4));
  self setweaponammostock(var4, weaponmaxammo(var4));
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

function ref_1247b(var0) {}

function rundebugstartobjective(var0) {
  wait 2;
  scripts\engine\utility::flag_wait("infil_complete");

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

function onplayerconnect(var0) {}

function onplayerspawned() {}

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
  register_create_script_arrays("cp_so_safehouse_create_script", "cp_so_safehouse_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_so_safehouse\cp_so_safehouse_create_script::main);
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
  var0 = newclienthudelem(self);
  var0.x = 0;
  var0.y = 0;
  var0 setshader("black", 640, 480);
  var0.alignx = "left";
  var0.aligny = "top";
  var0.sort = 1;
  var0.horzalign = "fullscreen";
  var0.vertalign = "fullscreen";
  var0.alpha = 1;
  var0.foreground = 1;
  var0.lowresbackground = 1;
  var1 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self playerlinktoabsolute(var1);
  self setmovespeedscale(0);
  scripts\engine\utility::flag_wait("players_connected");
  var0 fadeovertime(1);
  var0.alpha = 0;
  wait 0.3;
  self unlink();
  completepayloadpunish(1, 1);
  wait 1;

  if(isDefined(var0)) {
    var0 destroy();
  }

  var1 delete();
}

function infil_player_allow(var0) {
  if(self ishost() && getdvarint("scr_infil_spectator") == 1) {
    scripts\common\utility::allow_weapon(var0, "infil");
    return;
  }

  scripts\common\utility::allow_movement(var0, "infil");
  scripts\common\utility::allow_prone(var0, "infil");
  scripts\common\utility::allow_crouch(var0, "infil");
  scripts\common\utility::allow_jump(var0, "infil");
  scripts\common\utility::allow_fire(var0, "infil");
  scripts\common\utility::allow_ads(var0, "infil");
  scripts\common\utility::allow_sprint(var0, "infil");
  scripts\common\utility::allow_melee(var0, "infil");
  scripts\common\utility::allow_reload(var0, "infil");
  scripts\common\utility::allow_lean(var0, "infil");
  scripts\common\utility::allow_slide(var0, "infil");
  scripts\common\utility::allow_offhand_weapons(var0, "infil");
  scripts\common\utility::allow_weapon_switch(var0, "infil");
  scripts\common\utility::allow_usability(var0, "infil");
  scripts\common\utility::allow_script_weapon_switch(var0, "infil");
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

  foreach(var1 in ["field", "construction", "heli"]) {
    var2 = scripts\engine\utility::getStruct("bomb_site_" + var1, "targetname");
    var2.set_relic_landlocked = scripts\engine\utility::getStructArray("guard_spawner_" + var1, "targetname");
    var2.keypad_damagedeathdisconnectwatch = scripts\engine\utility::getStructArray("defuse_spawner_" + var1, "targetname");
    var2.name = var1;
    var2.blend_movespeedscale_cpso = [];
    thread ref_13f77();
    level.cpvehiclename[var1] = var2;
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

  foreach(var1 in scripts\engine\utility::getStructArray("spawner", "script_noteworthy")) {
    var1.spawn_functions = [];
  }

  thread ref_135ba();
}

function cqb_laser_guy() {
  foreach(var1 in level.cpvehiclename) {
    scripts\cp\laser_traps\cp_laser_traps::array_spawn_function(var1.set_relic_landlocked, &ref_133a7, var1);
    scripts\cp\laser_traps\cp_laser_traps::array_spawn_function(var1.keypad_damagedeathdisconnectwatch, &ref_133a7, var1);
    var2 = [];

    foreach(var4 in var1.set_relic_landlocked) {
      if(scripts\engine\utility::array_contains_key(var2, var4.script_type)) {
        var2[var2[var4.script_type].size] = var4;
        continue;
      }

      var2 = [var4];
    }

    var6 = [];
    var7 = rear_minigun_speed();

    while(var6.size < var7) {
      var8 = 0;
      var9 = 1;

      while(var6.size < var7 && var9) {
        var9 = 0;

        foreach(var11 in var2) {
          if(var8 < var11.size) {
            var6 = var11[var8];
            var9 = 1;

            if(var6.size >= var7) {
              break;
            }
          }
        }

        var8++;
      }
    }

    var1.blend_movespeedscale_cpso = scripts\cp\laser_traps\cp_laser_traps::can_spawn_extras(var6);
    thread ref_133a9();
  }
}

function ref_133a7(var0) {
  if(!isDefined(self.target)) {
    self setgoalpos(var0.origin);
    self.goalradius = var0.radius;
  }

  if(issubstr(self.agent_type, "lmg") || issubstr(self.agent_type, "rpg")) {
    self.disablepistol = 1;
  }

  self endon("death");

  while(!istrue(var0.bomb.defused)) {
    foreach(var2 in level.players) {
      if(distance2dsquared(var2.origin, var0.origin) < 2250000) {
        self getenemyinfo(var2);
      }
    }

    waitframe();
  }

  self.goalradius = 500;
  var4 = 0;

  if(isDefined(self.enemy) && isalive(self.enemy) && isPlayer(self.enemy) && !self.enemy.inlaststand) {
    var2 = self.enemy;
  } else {
    var2 = race_set_checkpoint();
  }

  if(!isDefined(var2)) {
    goto LOC_00000161;
  }

  GscBinSkip4(0x35, var2);

  for(;;) {
    var7 = 1;

    foreach(var2 in level.players) {
      if(scripts\engine\utility::within_fov(var2 getEye(), var2 getgunangles(), self.origin, 0)) {
        var7 = 0;
        break;
      }
    }

    if(var7) {
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
  var0 = 0;
  var1 = scripts\engine\utility::random(getEntArray("boss_spawner_" + self.name, "targetname"));

  if(!isDefined(var1)) {
    var1 = scripts\engine\utility::getStruct("boss_spawner_" + self.name, "targetname");
    var0 = 1;
  } else {
    var0 = scripts\engine\utility::getStructArray(var1.target, "targetname").size;
  }

  while(getaiarray("axis").size + var0 > 48) {
    waitframe();
  }

  jumpiffalse(isstruct(var1)) LOC_0000009e;
  var2 = [var1 scripts\cp\laser_traps\cp_laser_traps::spawn_ai()];
  thread vehicle_occupancy_clearallowmovementplayer(var2[0]);
  goto LOC_00000154;
}

function siteusedinternal() {
  nonbunkerdoors();
  self.script_disconnectpaths = 0;
  self.ref_12307 = spawn("script_model", self.origin);
  self.ref_12307 setModel("veh8_mil_air_lbravo_personnel_platform");
  self.ref_12307 linkTo(self, "tag_origin", (0, 0, -73), (0, 0, 0));
  ref_13b33(&heli_crash_on_pilot_death);
  var0 = undefined;

  foreach(var2 in scripts\engine\utility::getStructArray(self.target, "targetname")) {
    if(!isDefined(var2.script_type)) {
      var0 = var2;
      break;
    }
  }

  thread scripts\common\vehicle::vehicle_paths(var0);
  var4 = createnavbadplacebybounds((-483.75, -1444, 187.375), (180, 30, 130), (0, 0, 0));
  scripts\engine\utility::waittill_either("unloaded", "death");
  destroynavobstacle(var4);

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
  var0 = self.origin;
  var1 = self.angles;
  waitframe();

  if(isDefined(self.riders)) {
    scripts\engine\utility::array_call(self.riders, &delete);
  }

  self delete();
  var2 = spawn("script_model", var0);
  var2 setModel("veh8_mil_lnd_tromeo_static_dst");
  var2.angles = var1;
  var2 show();
  var3 = spawn("script_model", var0);
  var3.angles = var1;
  var4 = getEnt("tromeo_dst_col", "targetname");
  var3 clonebrushmodeltoscriptmodel(var4);
  var3 disconnectPaths();
}

function isplayeronground() {
  level.players[0] notifyonplayercommand("kill_tromeo", "+attack");

  while(self.godmode) {
    level.players[0] waittill("kill_tromeo");
  }

  self dodamage(99999999, self.origin);
}

function ref_13b33(var0) {
  self endon("death");
  self childthread[[var0]]();
}

function vehicle_occupancy_clearallowmovementplayer(var0) {
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

    var1 = race_set_checkpoint(var0);

    if(!isDefined(var1)) {
      waitframe();
      continue;
    }

    self getenemyinfo(var1);
    self setgoalpos(var1.origin);
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
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(!istrue(self.allowpain)) {
      if(isDefined(var9) && getweaponbasename(var9) == "flash") {
        self.allowpain = 1;
      }
    }

    if(var4 == "MOD_EXPLOSIVE" || var4 == "MOD_GRENADE" || var4 == "MOD_GRENADE_SPLASH") {
      if(istrue(self.allowpain) && (!isDefined(var9) || !scripts\engine\utility::is_equal(var9.basename, "flash"))) {
        self notify("jugg_stunned");
      }

      self.minpaindamage = 0;

      if(isDefined(var1) && isPlayer(var1)) {
        var10 = var0 / 2;

        if(var10 < 50) {
          var10 = 50;
        } else if(var10 > 150) {
          var10 = 100;
        }
      } else {
        var10 = 25;
      }

      self dodamage(var10, var4, var2);
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

function silo_thrust_platforms(var0) {
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

function ispubliceventoftypeactive() {
  for(;;) {
    var0 = rotatevectorinverted(self.minigun gettagorigin("tag_flash") - self.origin, self.angles);
    var1 = self.origin + rotatevector(var0, self.angles);
    waitframe();
  }
}

function heli_movement() {
  var0 = scripts\engine\utility::getStructArray("attack_heli_struct", "targetname");
  self.initlocs_nonmorsephones = undefined;
  self.player_closes_in = 1;

  for(;;) {
    if(!isDefined(self.target_player)) {
      waitframe();
      continue;
    }

    if(istrue(self.player_closes_in)) {
      var1 = 60;
      self.player_closes_in = undefined;
    } else {
      var2 = scripts\engine\utility::ter_op(isDefined(self.ref_124ca), 20, 10);
      var1 = clamp(distance(self.origin, self.initlocs_nonmorsephones.origin) / 5, var2, 40);
    }

    self.initlocs_nonmorsephones = printer(var0, self.target_player);
    skip_soldier_spawn(self.initlocs_nonmorsephones.origin, var1);

    if(!isDefined(self.ref_124ca)) {
      scripts\engine\utility::ref_143ba(randomfloatrange(3, 5), "new_target_player", "player_looking");
      continue;
    }

    if(radiussq()) {
      wait 2;
      continue;
    }

    var3 = level scripts\engine\utility::waittill_notify_or_timeout_return("player_fired_rpg", 0.8);

    if(var3 == "player_fired_rpg" && radiussq()) {
      wait 2;
    }
  }
}

function radiussq() {
  foreach(var1 in level.players) {
    if(istrue(var1.inlaststand) || !isDefined(var1.waittill_drone_timeout)) {
      continue;
    }

    if(scripts\engine\utility::time_has_passed(var1.waittill_drone_timeout["time"], 0.4)) {
      continue;
    }

    var2 = vectorNormalize(self.origin - var1.waittill_drone_timeout["origin"]);
    var3 = anglesToForward(var1.waittill_drone_timeout["angles"]);
    var4 = scripts\engine\math::anglebetweenvectors(var2, var3);

    if(var4 < 45) {
      return true;
    }
  }

  return false;
}

function printer(var0, var1) {
  if(isDefined(self.milestonephasepercent_lzs)) {
    var2 = sortbydistance(var0, self.milestonephasepercent_lzs.origin);
    var3 = var2[var2.size - 1];
    self.milestonephasepercent_lzs = undefined;
    return var3;
  }

  var4 = [];
  var5 = [];

  foreach(var3 in sortbydistance(var2, var3.origin)) {
    var7 = distance2dsquared(var3.origin, var3.origin);

    if(var7 > 4000000) {
      break;
    }

    if(var7 < 1000000) {
      continue;
    }

    if(scripts\engine\utility::is_equal(var3, self.initlocs_nonmorsephones)) {
      continue;
    }

    var5 = var3;
    var8 = rotatevectorinverted(self.minigun gettagorigin("tag_flash") - self.origin, self.angles);
    var9 = vectortoangles(scripts\engine\utility::flatten_vector(var3.origin - var3.origin));
    var10 = var3.origin + rotatevector(var8, var9);

    if(scripts\engine\trace::ray_trace_passed(var10, var3.origin + (0, 0, 20), scripts\engine\utility::array_combine(level.players, [self, self.minigun]))) {
      var4 = var3;
    }

    waitframe();

    if(var4.size > 3) {
      break;
    }
  }

  if(var4.size) {
    return scripts\engine\utility::random(var4);
  }

  return scripts\engine\utility::random(var5);
}

function skip_soldier_spawn(var0, var1) {
  self notify("nav_new_path");
  self endon("nav_new_path");
  var2 = findpath3d(self.origin, var0);

  if(!isDefined(var2)) {
    iprintlnbold("No nav3d data for heli! Heli flying will be bad .");
    return;
  }

  var3 = 0;
  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, 37);
  self vehicle_setspeed(var1, var1 * 0.5, var1 * 0.5);

  foreach(var5 in var2) {
    if(var6 == var2.size - 1) {
      var3 = 1;
    }

    self setvehgoalpos(var5, var3);
    scripts\engine\utility::ref_143a5("near_goal", "goal");
  }

  self notify("nav_goal");
}

function single_loop(var0) {
  for(var1 = 0; var1 < 3 && siteused(var0); var1++) {
    var2 = 0;
    var3 = gettime() + 2000;

    while(gettime() < var3) {
      var4 = var0.origin + (0, 0, 20);
      self.turret_pointer.origin = var4;
      var5 = self.minigun gettagorigin("tag_flash");
      var6 = self.minigun gettagangles("tag_flash");

      if(scripts\engine\utility::within_fov(var5, var6, var4, 0.99)) {
        var2 = 1;
        break;
      }

      wait 0.1;

      if(!siteused(var0)) {
        return;
      }
    }

    if(!var2) {
      return;
    }

    self.minigun startbarrelspin();
    var7 = 200;
    self.turret_pointer moveTo(var0.origin + anglesToForward(var0.angles) * var7, 2, 1, 1);
    wait 2;

    for(var8 = 0; var8 < 30; var8++) {
      if(var7 > 0) {
        var7 -= 20;
      }

      self.turret_pointer moveTo(var0.origin + anglesToForward(var0.angles) * var7 + (0, 0, 20), 0.1, 0.05, 0.05);
      self.minigun shootturret();
      wait 0.1;

      if(!siteused(var0)) {
        break;
      }
    }

    self.minigun stopbarrelspin();
    wait 1;
  }
}

function siteused(var0) {
  if(!isalive(var0)) {
    return false;
  }

  if(var0.inlaststand) {
    return false;
  }

  if(isDefined(self.attacker)) {
    return false;
  }

  return true;
}

function heli_damage_monitor(var0) {
  if(!isDefined(var0)) {
    var0 = self;
  }

  jumpiffalse(var0 != self) LOC_00000017;
  var0 endon("death");

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);

    if(var0 == self && isDefined(var10) && var10.basename == "iw8_la_rpapa7_mp") {
      waitframe();

      if(!scripts\common\vehicle::vehicle_is_crashing()) {
        self dodamage(self.health - self.healthbuffer + 1, self.origin);
      }
    }

    if(!isPlayer(var2)) {
      continue;
    }

    self.attacker = var2;
  }
}

function skipfirstraise(var0) {
  if(!isDefined(var0)) {
    var0 = self;
  }

  if(var0 != self) {
    var0 endon("death");
  }

  var1 = cos(15);

  for(;;) {
    var2 = undefined;

    foreach(var4 in level.players) {
      var5 = var4 getEye();
      var6 = var4 getgunangles();
      var7 = anglesToForward(var6);

      if(scripts\engine\utility::within_fov(var5, var6, var0.origin, var1)) {
        var8 = vectorNormalize(var0.origin - var5) * 150;

        if(sighttracepassed(var5, var0.origin - var8, 0, var4)) {
          var2 = var4;
          break;
        }

        waitframe();
      }
    }

    var2 = undefined;
    var7 = undefined;

    if(!isDefined(self.ref_124ca) && isDefined(var1) || isDefined(self.ref_124ca) && !isDefined(var1)) {
      if(isDefined(var1)) {
        self notify("player_looking", var1);
      }

      self.ref_124ca = var1;
    }

    wait 0.2;
  }
}

function callback_trigger(var0, var1) {
  if(!isDefined(var0) && !isDefined(var1)) {
    return 1;
  }

  return scripts\engine\utility::is_equal(var0, var1);
}

function heli_crash_on_pilot_death() {
  self.driver waittill("death");

  if(scripts\common\vehicle::vehicle_is_crashing()) {
    return;
  }

  self dodamage(self.health - self.healthbuffer + 1, self.origin);
}

function race_set_checkpoint(var0, var1) {
  var2 = undefined;

  if(isDefined(self.attacker)) {
    var2 = self.attacker;
    self.attacker = undefined;
  } else if(isDefined(self.ref_124ca)) {
    var2 = self.ref_124ca;
  } else if(isDefined(var0) && !istrue(var0.bomb.defused)) {
    if(isDefined(var0.bomb.playerusing) && (!istrue(var1) || ref_124bf(var0.bomb.playerusing))) {
      var2 = var0.bomb.playerusing;
    } else {
      var2 = progression_deadzone(var0.bomb.origin, var1);
    }
  } else {
    var2 = progression_deadzone(self.origin, var1);
  }

  return var2;
}

function progression_deadzone(var0, var1) {
  var2 = [];

  foreach(var4 in level.players) {
    if(!isalive(var4) || var4.inlaststand) {
      continue;
    }

    if(istrue(var1) && !ref_124bf(var4)) {
      continue;
    }

    var2 = var4;
  }

  var4 = scripts\engine\utility::getclosest(var0, var2);
  return var4;
}

function ref_124bf(var0) {
  var1 = var0 getEye();
  var2 = level.players;

  if(isent(self)) {
    var2 = scripts\engine\utility::array_add(var2, self);
  }

  if(isDefined(self.linked_ents)) {
    var2 = scripts\engine\utility::array_combine(var2, self.linked_ents);
  }

  if(scripts\engine\trace::ray_trace_passed(var1, var1 + (0, 0, 256), var2)) {
    return 1;
  }

  waitframe();
  return scripts\engine\trace::ray_trace_passed(var1, self.origin, var2);
}

function questenabled(var0, var1) {
  var2 = undefined;
  var3 = undefined;

  while(!isDefined(var2)) {
    if(!isDefined(var3)) {
      var3 = var1;
    } else if(var3 % var0.size == var1 % var0.size) {
      break;
    }

    var4 = var0[var1 % var0.size];

    if(isDefined(var4.script_count) && isDefined(var4.spawned)) {
      var4.spawned = scripts\engine\utility::array_removedead_or_dying(var4.spawned);

      if(var4.spawned.size >= var4.script_count) {
        var1++;
        continue;
      }
    }

    if(!istrue(var4.script_forcespawn) && (scripts\engine\utility::get_array_of_closest(var4.origin, level.players, undefined, undefined, 500).size || c130airdrop_dropcrates(var4))) {
      var1++;
      continue;
    }

    var2 = var1 % var0.size;
  }

  return var2;
}

function c130airdrop_dropcrates() {
  var0 = [self.origin + (0, 0, 18), self.origin + (0, 0, 72), self.origin + rotatevector((0, 10, 0), self.angles) + (0, 0, 60), self.origin + rotatevector((0, -10, 0), self.angles) + (0, 0, 60)];

  foreach(var2 in level.players) {
    var3 = var2 getEye();
    var4 = var2 getgunangles();

    foreach(var6 in var0) {
      if(scripts\engine\utility::within_fov(var3, var4, var6, 0)) {
        if(sighttracepassed(var3, var6, 0, var2)) {
          return true;
        }

        waitframe();
        var3 = var2 getEye();
        var4 = var2 getgunangles();
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

function ref_13548(var0) {
  while(!scripts\engine\utility::get_array_of_closest(var0.origin, level.players, undefined, undefined, 500).size) {
    waitframe();
  }

  thread ref_1354b();
  level scripts\engine\utility::thread_on_notify("exfil_arriving", &ref_1354b);
  var1 = scripts\engine\utility::getStructArray("exfil_spawner", "targetname");
  scripts\engine\utility::array_thread(var1, &scripts\cp\laser_traps\cp_laser_traps::add_spawn_function, &onentercallback);

  for(var2 = 0; !scripts\engine\utility::flag("exfil_arrived"); var2++) {
    switch (var2) {
      case 0:
        if(level.players.size > 2) {
          var3 = 8;
        } else {
          var3 = 4;
        }

        break;
      case 1:
        if(level.players.size > 2) {
          var3 = 12;
        } else {
          var3 = 8;
        }

        break;
      default:
        if(level.players.size > 2) {
          var3 = 16;
        } else {
          var3 = 12;
        }

        break;
    }

    var4 = [];

    while(var4.size < var3) {
      for(var5 = 0; var5 < var1.size && var4.size < var3; var5++) {
        var6 = var1[var5];
        var7 = scripts\engine\utility::getclosest(var6.origin, level.players);

        if(distancesquared(var7.origin, var6.origin) < 250000) {
          continue;
        }

        if(!c130airdrop_dropcrates(var6)) {
          var8 = ref_12980(var6);

          if(isDefined(var8)) {
            var4 = var8;
          }
        }

        waitframe();
      }

      waitframe();
    }

    while(var4.size > level.players.size) {
      wait 1;
      var4 = scripts\engine\utility::array_removedead_or_dying(var4);
    }
  }
}

function ref_1354b() {
  var0 = scripts\engine\utility::getStructArray("exfil_juggernaut_spawner", "targetname");
  scripts\engine\utility::array_thread(var0, &scripts\cp\laser_traps\cp_laser_traps::add_spawn_function, &onentercallback);
  scripts\engine\utility::array_thread(var0, &scripts\cp\laser_traps\cp_laser_traps::add_spawn_function, &ref_12809);
  var1 = scripts\engine\utility::ter_op(level.players.size > 2, 2, 1);
  var2 = 0;

  if(!isDefined(level.juggernauts)) {
    level.juggernauts = [];
  }

  foreach(var5, var4 in level.juggernauts) {
    if(isalive(var4)) {
      var2++;
    }
  }

  if(var2 >= var1) {
    return;
  }

  if(var1 - var2 > 1) {
    ref_1243d(level.players, "dx_cps_kama_callout_juggernaut_spawning_10", 2);
  } else {
    ref_1243d(level.players, "dx_mpa_rutl_rugby_enemy_close_goal", 2);
  }

  setmusicstate("cp_juggernaut_intro");

  while(var2 < var1) {
    foreach(var7 in var0) {
      if(!c130airdrop_dropcrates(var7)) {
        var8 = ref_12980(var7);

        if(isDefined(var8)) {
          var2++;
        }

        if(var2 >= var1) {
          break;
        }
      }
    }

    var5 = undefined;
    var7 = undefined;
    wait 2;
  }
}

function ref_1354a() {
  level waittill("exfil_called");
  var0 = [];

  if(isDefined(level.silo_thrust_dogtag_revive) && isalive(level.silo_thrust_dogtag_revive)) {
    level.silo_thrust_dogtag_revive scripts\engine\utility::thread_on_notify_no_endon_death("death", &scripts\engine\utility::flag_set, "exfil_boss_killed");
    GscBinSkip0(0x2e, 0, level.silo_thrust_dogtag_revive);
  }

  var1 = scripts\common\utility::getvehiclespawner("boss_spawner_heli", "targetname");
  var2 = var1 scripts\common\vehicle::spawn_vehicle_and_gopath();
  var0 = var2;
  waitframe();
  ref_1243d(level.players, "dx_cps_kama_callout_helicopter_attacking_20", 2, undefined, 1);
  thread silo_thrust_platforms();
  var2 scripts\engine\utility::thread_on_notify_no_endon_death("death", &scripts\engine\utility::flag_set, "exfil_boss_killed");
  ref_11e5c("objective_boss", &"CP_SO_SAFEHOUSE/OBJECTIVE_DEFEAT", "icon_waypoint_vehicle_little_bird", "axis", var0, undefined, "exfil_boss_killed");
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
    var0 = scripts\engine\utility::getStruct("lz", "targetname");
    self setgoalpos(var0.origin);
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
      var0 = level.spawn_queue[0];
      var1 = var0 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
      var0 notify("spawned", var1);
      level.spawn_queue = scripts\engine\utility::array_remove(level.spawn_queue, var0);
    }
  }
}

function ref_12980() {
  level.spawn_queue[level.spawn_queue.size] = self;
  self waittill("spawned", var0);
  return var0;
}

function getcash(var0, var1) {
  self notify("new_chase_target");
  self endon("new_chase_target");
  self endon("death");
  var0 endon("death");

  if(!isDefined(var1)) {
    var1 = 1;
  }

  for(;;) {
    self setgoalpos(var0.origin);
    wait var1;
  }
}

function target_play_death_anim() {
  var0 = squared(300);
  var1 = gettime();
  var2 = 1;

  while(var2) {
    foreach(var4 in level.players) {
      if(distance2dsquared(var4.origin, (-1050, 514, 0)) < var0) {
        continue;
      }

      var2 = 0;
      break;
    }

    waitframe();
  }

  scripts\cp\laser_traps\cp_laser_traps::ref_13067();
  setomnvar("cp_countdown_color", 0);
  var6 = [330, 330, 330, 330];
  level.ref_13b8b = var6[level.players.size - 1];
  setomnvar("cp_wave_timer", gettime() + int(level.ref_13b8b * 1000));
  setomnvar("cp_round_num", 1);
  var7 = level.ref_13b8b;
  level.ref_13b88 = 1;

  while(level.ref_13b8b > 0 && !scripts\engine\utility::flag("all_bombs_defused")) {
    level notify("timer_tick");

    if(level.ref_13b8b <= 30) {
      foreach(var4 in level.players) {
        if(level.ref_13b8b > 20) {
          var4 playSound("ui_mp_timer_countdown");
          continue;
        }

        if(level.ref_13b8b > 10) {
          var4 playSound("ui_mp_timer_countdown_10");
          continue;
        }

        if(level.ref_13b8b > 5) {
          var4 playSound("ui_mp_timer_countdown_half_sec");
          continue;
        }

        if(level.ref_13b8b > 1.5) {
          var4 playSound("ui_mp_timer_countdown_quarter_sec");
          continue;
        }

        var4 playSound("ui_mp_timer_countdown_1");
      }
    }

    setomnvar("cp_countdown_color", level.ref_13b8b <= 30);
    wait 1;
    var10 = 1;

    if(var10) {
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

  for(var0 = 0; var0 < 30; var0++) {
    wait 0.05;
    setomnvar("cp_wave_timer", gettime() + int(level.ref_13b8b * 1000));
  }

  setomnvar("cp_countdown_color", 0);
}

function init_player() {
  var0 = self;
  var0.maxvisibledist = 2000;
  thread ref_14481();

  foreach(var2 in level.bombs) {
    objective_addclienttomask(var3, var0);
  }

  thread spawn_backup_helispawner_jammer2();
  wait 2;
  scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var0, ["ammo_crate", "grenade_crate"][level.infil_lbravo_is_alive]);
  level.infil_lbravo_is_alive = !level.infil_lbravo_is_alive;
}

function ref_14481() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("weapon_fired", var0);

    if(isDefined(var0) && var0.basename == "iw8_la_rpapa7_mp") {
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

function stoppingpowercanonehitkill(var0) {
  var1 = self;
  var2 = "obj_bomb_" + var0;

  if(var0 == 0) {
    objective_setdescription(var0, &"CP_SO_SAFEHOUSE/OBJECTIVE1");
  }

  var3 = scripts\cp\cp_objectives::requestworldid(var2, 3);
  objective_setlabel(var3, &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS");
  objective_setplayintro(var3, 1);
  objective_setplayoutro(var3, 0);
  objective_position(var3, var1.origin + (0, 0, 12));
  objective_state(var3, "current");
  var4 = ["icon_waypoint_dom_a", "icon_waypoint_dom_b", "icon_waypoint_dom_c", "icon_waypoint_dom_d", "icon_waypoint_dom_e"];

  if(var3 < var4.size) {
    objective_icon(var3, var4[var0]);
  } else {
    objective_icon(var3, "icon_waypoint_dom_e");
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

function init_fan_blades(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var11 = spawnStruct();
  var11.classname = "script_struct_heli";
  var11.targetname = var0;
  var11.target = var1;
  var11.origin = var2;
  var11.angles = var3;
  var11.speed = scripts\engine\utility::ter_op(isDefined(var4), var4, int(100));
  var11.script_accel = scripts\engine\utility::ter_op(isDefined(var5), var5, int(20));
  var11.script_decel = scripts\engine\utility::ter_op(isDefined(var6), var6, int(20));
  var11.radius = scripts\engine\utility::ter_op(isDefined(var7), var7, int(400));
  var11.script_goalyaw = scripts\engine\utility::ter_op(isDefined(var8), var8, 1);
  var11.lookahead = scripts\engine\utility::ter_op(isDefined(var9), var9, 1);
  var11.ref_12f91 = scripts\engine\utility::ter_op(isDefined(var8), var8, 1);
  level.struct_class_names["targetname"][var0] = [var11];
  return var11;
}

function superslotcleanup() {
  if(getdvarint("scr_skip_infils", 0) == 1) {
    if(scripts\engine\utility::flag_exist("infil_complete")) {
      scripts\engine\utility::flag_set("infil_complete");
    }

    return;
  }

  scripts\cp\infilexfil\lbravo_infil_cp::initanims("alpha");
  var0 = [];
  GscBinSkip0(0x2e, 0, [0, 1]);
}

function ref_1357f(var0) {
  var1 = spawnVehicle("veh8_mil_air_lbravo", "infil_lbravo_alpha", "lbravo_infil_cp", var0.origin, var0.angles);
  return var1;
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
  foreach(var1 in getEntArray("trigger_hurt", "classname")) {
    if(var1.origin[2] == -32) {
      var1 delete();
      break;
    }
  }

  var3 = spawn("script_model", (1006.75, -2239, 123.75));
  var3.angles = (0, 3.998, 0);
  var4 = getEnt("clip64x64x64", "targetname");
  var3 clonebrushmodeltoscriptmodel(var4);
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

  foreach(var1 in level.players) {
    thread init_player();
  }

  thread target_play_death_anim();
  setomnvar("cp_objective_index", 1);
  setomnvar("cp_objective_sub_4_index", 2);

  foreach(var4 in level.bombs) {
    thread stoppingpowercanonehitkill(var4);
  }

  thread cqb_laser_guy();
  thread ref_11b3e();
  thread get_drone_movement_vector();

  while(level.current_checkpoint < level.bombs.size) {
    level waittill("bomb_defused");
  }

  scripts\engine\utility::flag_set("all_bombs_defused");
  setomnvar("cp_objective_sub_4_index", 6);
  var6 = scripts\engine\utility::getStruct("lz", "targetname");
  thread ref_13548(var6);
  ref_11e5c("objective_lz", &"CP_SO_SAFEHOUSE/OBJECTIVE_EXFIL_LBL", undefined, "allies", undefined, var6.origin + (0, 0, 15), "exfil_arrived");
  thread friendly_dmg_text_cooldown(var6);
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

function friendly_dmg_text_cooldown(var0) {
  ref_11a9a(var0, &"CP_SO_SAFEHOUSE/CALL_EXFIL");
  var1 = getgroundposition(var0.origin, 1);
  magicgrenademanual("deploy_airdrop_mp", var1, (0, 0, 0), 0.01);
  level notify("exfil_called");
}

function ref_13549() {
  var0 = scripts\common\utility::getvehiclespawner("exfil_heli", "targetname");
  var1 = undefined;

  foreach(var3 in scripts\engine\utility::getStructArray(var0.target, "targetname")) {
    if(isDefined(var3.script_type)) {
      continue;
    }

    var1 = var3;
    break;
  }

  var5 = 0;

  while(isDefined(var1.target)) {
    var1 = scripts\engine\utility::getStruct(var1.target, "targetname");
    var5++;

    switch (var5) {
      case 5:
      case 4:
        var1.origin += (0, 0, 50);
        break;
    }
  }

  var6 = var0 scripts\common\vehicle::spawn_vehicle_and_gopath();

  if(isDefined(var6) && isDefined(var6.riders)) {
    foreach(var8 in var6.riders) {
      var8.ignoreme = 1;
    }
  }

  var10 = spawn("script_model", var6.origin);
  var10 setModel("veh8_mil_air_lbravo_personnel_platform");
  var10 linkTo(var6, "tag_origin", (0, 0, -73), (0, 0, 0));
  var11 = spawn("script_model", var6.origin);
  var11 dontinterpolate();
  var11.angles = var6.angles;
  var11 linkTo(var6);
  var12 = getEnt("exfil_heli_col", "targetname");
  var11 clonebrushmodeltoscriptmodel(var12);
  var13 = anglestoright(var6.angles) * 64;
  var14 = anglestoright(var6.angles) * -64;
  var15 = anglesToForward(var6.angles) * 64;
  var16 = anglesToForward(var6.angles) * -64;
  ref_11a87(var6, var13 + var15);
  ref_11a87(var6, var14 + var15);
  ref_11a87(var6, var13 + var16);
  ref_11a87(var6, var14 + var16);
  level notify("exfil_arriving");
  ref_11e5c("objective_exfil", &"CP_SO_SAFEHOUSE/OBJECTIVE_HELI_LBL", "icon_waypoint_vehicle_little_bird", "allies", var6, undefined, "mission_complete", 1, 0);
  waitframe();
  level.should_do_damage_check_func = &ref_132c0;
  scripts\engine\utility::flag_wait("exfil_arrived");
  thread logevent_munitionused(&"CP_SO_SAFEHOUSE/REGROUP_EXFIL", 15);

  for(;;) {
    var17 = [];

    foreach(var19 in level.players) {
      if(var19.inlaststand || distance2dsquared(var19.origin, var6.origin) > 40000) {
        continue;
      }

      var17 = var19;
    }

    if(var17.size > 0 && isDefined(level.waittill_any_timeout_3) && scripts\engine\utility::time_has_passed(level.players, 10)) {
      scripts\engine\utility::random(var17) scripts\cp\cp_player_battlechatter::dosound("obj_exfil_nag");
      level.waittill_any_timeout_3 = gettime();
    }

    if(var17.size == level.players.size) {
      break;
    }

    waitframe();
  }

  level notify("mission_complete");
}

function ref_11a87(var0, var1) {
  var2 = spawn("script_model", var0.origin + var1);
  var2 dontinterpolate();
  var2.angles = var0.angles;
  var2 linkTo(var0);
  var3 = getEnt("clip256x256x256", "targetname");
  var2 clonebrushmodeltoscriptmodel(var3);
}

function ref_132c0(var0, var1, var2, var3, var4, var5) {
  if(var5.team == "allies") {
    return false;
  }

  return true;
}

function ref_11a9a(var0) {
  if(!isDefined(self.origin)) {
    return;
  }

  var1 = spawn("script_model", self.origin);
  var1 endon("death");
  var1.isusable = 1;
  var1 setCursorHint("hint_button");
  var1 sethintdisplayfov(360);
  var1 setusefov(135);
  var1 sethintdisplayrange(500);
  var1 setuserange(80);
  var1 sethintonobstruction("show");
  var1 setuseholdduration("duration_none");
  var1 sethintlockplayermovement(1);
  var1 makeusable();
  var1 setHintString(var0);
  var1.userate = 1;
  var1.laststandfinisherdone = 4;
  var1.curprogress = 0;
  var1.usetime = 5;
  var1.inuse = 0;
  var1.playerusing = undefined;
  var1 waittill("trigger", var2);
  var1 delete();
}

function ref_11e5c(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  thread ref_11e5d(var0, var1, var2, var3, var4, var5, var6, var7, var8);
}

function ref_11e5d(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = scripts\cp\cp_objectives::requestworldid(var0, 3);

  if(isDefined(var1)) {
    objective_setlabel(var9, var1);
  }

  objective_state(var9, "current");

  if(!isDefined(var2)) {
    var2 = "icon_waypoint_objective_general";
  }

  objective_icon(var9, var2);

  if(isDefined(var3)) {
    objective_setownerteam(var9, var3);
  }

  if(isDefined(var4)) {
    if(!isarray(var4)) {
      var4 = [var4];
    }

    var10 = 0;

    foreach(var12 in var4) {
      objective_setlocation(var9, var10, var12);

      if(isDefined(var5)) {
        objective_setzoffset(var9, var5);
      }

      var10++;
    }
  } else if(isDefined(var5)) {
    objective_position(var9, var5);
  }

  if(!isDefined(var7)) {
    var7 = 1;
  }

  if(!isDefined(var8)) {
    var8 = 1;
  }

  objective_setplayintro(var9, var7);
  objective_setplayoutro(var9, var8);
  level waittill(var6);
  objective_state(var9, "done");
}

function propinputwatch(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(istrue(var3.spectating) || istrue(var3.inlaststand)) {
      continue;
    }

    var1 = var3.origin;
  }

  if(var1.size == 0) {
    return scripts\engine\utility::random(level.mini_map_origin_fix);
  }

  var5 = averagepoint(var1);
  var6 = undefined;
  var7 = undefined;

  foreach(var9 in level.mini_map_origin_fix) {
    if(isDefined(var0) && var0[0] == var9[0]) {
      continue;
    }

    var10 = distance2dsquared(var5, var9[0]);

    if(!isDefined(var6) || var10 > var6) {
      var6 = var10;
      var7 = var9;
    }
  }

  return var7;
}

function projdistsq(var0, var1) {
  if(!isDefined(var0)) {
    var0 = self.origin;
  }

  var2 = undefined;
  var3 = undefined;

  foreach(var5 in var1) {
    var6 = distance2dsquared(var0, var5[0]);

    if(!isDefined(var2) || var6 < var2) {
      var2 = var6;
      var3 = var7;
    }
  }

  return var3;
}

function get_drone_movement_vector() {
  for(var0 = 0; var0 < 3; var0++) {
    level waittill("bomb_defused", var1, var2);
    thread minigameinfo(var1, var2, 2, 1);
    thread minigameinfo(var1, var2, 5);
  }
}

function minigameinfo(var0, var1, var2, var3) {
  level endon("game_ended");
  wait var2;
  var4 = undefined;
  var5 = undefined;

  for(var6 = 0; var6 < var0.minigun_attack_min_cooldown.size; var6++) {
    var4 = var0.minigun_attack_min_cooldown[var6];

    if(!istrue(level.mini_map_origin_fix[var4]["has_package"])) {
      var5 = level.mini_map_origin_fix[var4];
      break;
    }
  }

  if(!isDefined(var5)) {
    thread logevent_munitionused(&"CP_SO_SAFEHOUSE/CAREPACKAGE_DONE", 3);
    return;
  }

  ref_1243d(level.players, "dx_mpa_rutl_airdrop_friendly_use", 1, 30);

  if(!istrue(var3)) {
    var7 = [ &"CP_SO_SAFEHOUSE/CAREPACKAGE_DROP_A", &"CP_SO_SAFEHOUSE/CAREPACKAGE_DROP_B", &"CP_SO_SAFEHOUSE/CAREPACKAGE_DROP_C", &"CP_SO_SAFEHOUSE/CAREPACKAGE_DROP_D"];
    var8 = var7[var0.objindex];
    thread logevent_munitionused(var8, 3);
  }

  level.mini_map_origin_fix[var4]["has_package"] = 1;
  level childthread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(8000, 20000, var5[1], var5[0] + (0, 0, 1000), undefined, &weapon_xp_iw8_sn_sbeta);
}

function voqueue() {}

function logevent_munitionused(var0, var1) {
  foreach(var3 in level.players) {
    thread logevent_kidnapevent(var3, var0, var1);
  }
}

function logevent_kidnapevent(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 notify("new_msg");
  var0 endon("new_msg");
  var0 clearhudtutorialmessage();
  wait 0.5;
  var0 sethudtutorialmessage(var1);
  wait var2;
  var0 clearhudtutorialmessage();
}

function weapon_xp_iw8_sn_sbeta(var0, var1, var2) {
  if(scripts\cp\laser_traps\cp_laser_traps::ref_124d0(var0)) {
    thread logevent_kidnapevent(var0, &"CP_BR/MUN_SLOTS_FULL", 3);
    return false;
  }

  if(!isDefined(level.get_dropoff_point_spawner)) {
    level.get_dropoff_point_spawner = 0;
  }

  var3 = projdistsq(var0.origin, level.mini_map_origin_fix);
  var4 = ["sentry", "sentry", "juggernaut"];
  var5 = ["dx_mpa_rutl_sentry_gun_achieve", "dx_mpa_rutl_sentry_gun_achieve", "dx_mpa_rutl_juggernaut_achieve"];
  var6 = var5[level.get_dropoff_point_spawner];
  ref_1243d(var0, var6, 1, 10);
  level.mini_map_origin_fix[var3]["has_package"] = 0;
  scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var0, var4[level.get_dropoff_point_spawner]);
  level.get_dropoff_point_spawner++;

  if(level.get_dropoff_point_spawner >= var4.size) {
    level.get_dropoff_point_spawner = 0;
  }

  return true;
}

function ref_1435c() {
  self.ref_12c9d = 1;

  while(self.ref_12c9d > 0) {
    self waittillmatch("munitions_used", "respawn");
    var0 = level.players_in_respawn_queue[0];
    var1 = projdistsq(self.origin, level.ref_12c8e);
    var0.forcespawnorigin = level.ref_12c8e[var1][0];
    var0.forcespawnangles = level.ref_12c8e[var1][1];
  }

  self.ref_12c9d = undefined;
}

function pretrograd_interaction_effects() {
  foreach(var1 in level.players) {
    if(istrue(var1.spectating)) {
      continue;
    }

    if(ref_124b1(var1)) {
      return true;
    }
  }

  return false;
}

function ref_124b1(var0) {
  for(var1 = 0; var1 < var0.munition_slots.size; var1++) {
    if(var0 scripts\cp\loot_system::is_empty_or_none(var1)) {
      continue;
    }

    if(var0.munition_slots[var1].ref == "respawn") {
      return true;
    }
  }

  return false;
}

function prev_weapon_taccover() {
  foreach(var1 in level.players) {
    if(istrue(var1.spectating)) {
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
  var0 = [];

  foreach(var2 in level.bombs) {
    if(!istrue(var2.defused)) {
      var0 = var2;
    }
  }

  var4 = [];

  foreach(var2 in var0) {
    if(!istrue(var2.inuse)) {
      var4 = var2;
    }
  }

  var7 = 0;

  foreach(var2 in var0) {
    thread explode(var2);
    wait randomfloatrange(0.1, 0.3);
  }

  scripts\engine\utility::flag_wait("bomb_exploded");
  wait 2;
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

function explode(var0) {
  var1 = self;
  var1 endon("bomb_defused");
  var2 = gettime();

  if(var1.inuse) {
    var1 waittill("not_in_use");
  }

  if(!var0 || scripts\engine\utility::time_has_passed(var2, 1)) {
    foreach(var4 in level.players) {
      var1 playsoundtoplayer("exp_bombsite_lr", var4);
    }
  }

  playFX(level._effect["bomb_vest_explode"], var1.origin);
  playFX(level._effect["coop_bomb_defusal_explode"], var1.origin);
  earthquake(1, 2, var1.origin, 3000);

  foreach(var7 in getaiarrayinradius(var1.origin, 1000)) {
    var7 kill(var1.origin);
  }

  foreach(var4 in level.players) {
    if(distance2dsquared(var4.origin, var1.origin) < squared(1000)) {
      var4 kill(var1.origin);
    }
  }

  objective_state(var1.objindex, "failed");
  var1.exploded = 1;
  var1 hide();
  scripts\engine\utility::flag_set("bomb_exploded");
}

function ref_1350b(var0, var1, var2) {
  var3 = spawn("script_model", var0);
  var3.objindex = level.bombs.size;
  var3.angles = var1;
  var3.name = var2;
  var3 setModel("offhand_wm_briefcase_bomb");
  thread ref_1448e();

  if(isDefined(var2) && scripts\engine\utility::array_contains_key(level.cpvehiclename, var2)) {
    level.cpvehiclename[var2].bomb = var3;
  }

  return var3;
}

function ref_135f6(var0, var1, var2) {
  var3 = "military_crate_large_stackable_01";

  if(var2 == "ammo_crate") {
    var4 = &"CP_SO_SAFEHOUSE/TAKE_AMMO_CRATE";
    var5 = "cp_crafted_icon_ammo_crate";
    var6 = "cp_crafted_icon_ammo_crate";
    var7 = &ref_124aa;
    var8 = &"CP_SO_SAFEHOUSE/HAVE_AMMO_CRATE_RED";
  } else {
    var4 = &"CP_SO_SAFEHOUSE/TAKE_GRENADE_CRATE";
    var5 = "cp_crafted_icon_explosive";
    var6 = "cp_crafted_icon_explosive";
    var7 = &ref_124ac;
    var8 = &"CP_SO_SAFEHOUSE/HAVE_GRENADE_CRATE_RED";
  }

  var9 = scripts\cp\laser_traps\cp_laser_traps::ref_139aa(var5, var6, &ref_14541, var8, var4, var5, var6, var7, undefined, var8);
  addclienttoheadiconmask(var9.headiconid, 30);
  setheadiconmaxdistance(var9.headiconid, 200);
  var9.type = var7;
  var10 = spawn("script_model", var9.origin);
  var10 dontinterpolate();
  var10.angles = var9.angles;
  var11 = getEnt("military_crate_col", "targetname");
  var10 clonebrushmodeltoscriptmodel(var11);
  return var9;
}

function ref_14541(var0, var1) {
  if(scripts\cp\laser_traps\cp_laser_traps::ref_124d0(var1)) {
    thread logevent_kidnapevent(var1, &"CP_BR/MUN_SLOTS_FULL", 3);
    return false;
  }

  for(var2 = 0; var2 < var1.munition_slots.size; var2++) {
    if(var1.munition_slots[var2].ref == "ammo_crate") {
      var1 scripts\cp\cp_munitions::remove_munition(var2, "ammo_crate");
    }

    if(var1.munition_slots[var2].ref == "grenade_crate") {
      var1 scripts\cp\cp_munitions::remove_munition(var2, "grenade_crate");
    }
  }

  var1 scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var1, var0.type);
  return true;
}

function ref_124ac(var0) {
  if(!isDefined(var0.munition_slots)) {
    return false;
  }

  for(var1 = 0; var1 < var0.munition_slots.size; var1++) {
    if(var0.munition_slots[var1].ref == "grenade_crate") {
      return true;
    }
  }

  return false;
}

function ref_124aa(var0) {
  if(!isDefined(var0.munition_slots)) {
    return false;
  }

  for(var1 = 0; var1 < var0.munition_slots.size; var1++) {
    if(var0.munition_slots[var1].ref == "ammo_crate") {
      return true;
    }
  }

  return false;
}

function propclonepower() {
  var0 = [9, 13, 16, 16];

  if(!isDefined(level.players) || level.players.size < 1) {
    return var0[0];
  }

  return var0[level.players.size - 1];
}

function propcontrolshud() {
  var0 = [14, 14, 10, 10];

  if(!isDefined(level.players) || level.players.size < 1) {
    return var0[0];
  }

  return var0[level.players.size - 1];
}

function propdeathfx() {
  var0 = [0.4, 0.4, 0.4, 0.4];

  if(!isDefined(level.players) || level.players.size < 1) {
    return var0[0];
  }

  return var0[level.players.size - 1];
}

function ref_1448e() {
  self endon("death");
  self endon("bomb_defused");
  self.isusable = 1;
  var0 = self;
  var1 = [ &"CP_SO_SAFEHOUSE/OBJECTIVE_A", &"CP_SO_SAFEHOUSE/OBJECTIVE_B", &"CP_SO_SAFEHOUSE/OBJECTIVE_C", &"CP_SO_SAFEHOUSE/OBJECTIVE_D"];
  var0 setCursorHint("HINT_NOICON");
  var0 sethintdisplayfov(360);
  var0 setusefov(360);
  var0 sethintdisplayrange(500);
  var0 setuserange(84);
  var0 sethintonobstruction("show");
  var0 setuseholdduration("duration_short");
  var0 sethintlockplayermovement(1);
  var0 setHintString(var1[self.objindex]);
  var0 setusepriority(-10);
  var0 makeusable();
  var0.curprogress = 0;
  var0.userate = 1;
  var0.laststanddowneddata = propcontrolshud();
  var0.laststandfinisherdone = propdeathfx();
  var0.usetime = propclonepower();
  var0.inuse = 0;
  var0.playerusing = undefined;
  var0.ref_1387d = getcompleteweaponname("briefcase_bomb_defuse_mp");

  for(;;) {
    if(!isDefined(var0.laststanddowneddata) || !isDefined(var0.laststandfinisherdone) || !isDefined(var0.usetime)) {
      var0.laststanddowneddata = propcontrolshud();
      var0.laststandfinisherdone = propdeathfx();
      var0.usetime = propclonepower();
      wait 1;
      continue;
    }

    GscBinSkip4(0x35, var0);
  }
}

function ref_14368(var0) {
  var0 endon("death");
  var0 endon("trigger");

  if(true) {
    return;
  }

  wait var0.laststanddowneddata;

  for(;;) {
    var0.curprogress -= level.framedurationseconds * var0.laststandfinisherdone;
    var1 = clamp(var0.curprogress / var0.usetime, 0, 1);
    objective_setprogress(self.objindex, var1);

    if(var0.curprogress <= 0) {
      objective_setshowprogress(self.objindex, 0);
      var0.curprogress = 0;
      return;
    }

    waitframe();
  }
}

function ref_1448f(var0, var1) {
  var0 endon("death_or_disconnect");
  var0 endon("last_stand");
  var1.userate = scripts\engine\utility::ter_op(isDefined(var0.objectivescaler), var0.objectivescaler, var1.userate);

  while(get_alertreset_alias(var0, var1) && var0 useButtonPressed()) {
    var1.curprogress += level.framedurationseconds * var1.userate;
    var2 = clamp(var1.curprogress / var1.usetime, 0, 1);
    objective_setprogress(self.objindex, var2);
    var0 setclientomnvar("ui_securing_progress", var2);

    if(var1.curprogress >= var1.usetime) {
      return true;
    }

    waitframe();
  }

  return false;
}

function ref_1387f(var0, var1) {
  var0 endon("death_or_disconnect");

  if(isDefined(var0 getcurrentweapon()) && var0 getcurrentweapon().basename == "iw8_lm_dblmg_mp") {
    scripts\cp\cp_weapon::minigamefinishcount(var0);

    while(var0 getcurrentweapon().basename == "iw8_lm_dblmg_mp" || var0 getcurrentweapon().basename == "none") {
      waitframe();
    }
  }

  var1.ref_13f76 = var0 getcurrentweapon();
  var0 setclientomnvar("ui_securing_progress", var1.curprogress / var1.usetime);
  var1.inuse = 1;
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

  var1 makeunusable();
  objective_setlabel(self.objindex, &"MP_INGAME_ONLY/OBJ_DEFUSING_CAPS");
  objective_setshowprogress(self.objindex, 1);
  objective_sethot(self.objindex, 1);
  var0 setmovespeedscale(0.2);
  var0 giveweapon(var1.ref_1387d);
  var0 scripts\cp\cp_weapons::switchtoweaponreliable(var1.ref_1387d);
  var0 setclientomnvar("ui_securing", 9);
  var0 scripts\common\utility::allow_movement(0, "bomb_use");
  var0 scripts\common\utility::allow_jump(0, "bomb_use");
  var0 scripts\common\utility::allow_mount_side(0, "bomb_use");
  var0 scripts\common\utility::allow_mount_top(0, "bomb_use");
  var0 scripts\common\utility::allow_mantle(0, "bomb_use");
  var0 scripts\common\utility::allow_offhand_weapons(0, "bomb_use");
  var0 scripts\common\utility::brjugg_onplayerkilled(0, "bomb_use");
  var0 scripts\common\utility::allow_weapon_pickup(0, "bomb_use");
  return true;
}

function ref_138f5(var0, var1, var2) {
  var0 endon("death_or_disconnect");
  var0 scripts\common\utility::allow_movement(1, "bomb_use");
  var0 scripts\common\utility::allow_jump(1, "bomb_use");
  var0 scripts\common\utility::allow_mount_side(1, "bomb_use");
  var0 scripts\common\utility::allow_mount_top(1, "bomb_use");
  var0 scripts\common\utility::allow_mantle(1, "bomb_use");
  var0 scripts\common\utility::allow_offhand_weapons(1, "bomb_use");
  var0 scripts\common\utility::brjugg_onplayerkilled(1, "bomb_use");
  var0 setmovespeedscale(0.2);
  var0 scripts\cp\cp_weapons::switchtoweaponreliable(var1.ref_13f76);
  var0 takeweapon(var1.ref_1387d);

  if(istrue(var0.inlaststand)) {
    thread logevent_kidnapevent(var0, &"CP_SO_SAFEHOUSE/DROP_BOMB_HINT", 3);
    var0.min_dist_sq_from_node = var1.ref_13f76;
  }

  objective_setlabel(self.objindex, &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS");
  objective_sethot(self.objindex, 0);
  var1.inuse = 0;
  self notify("not_in_use");
  var1 makeusable();
  var0 setclientomnvar("ui_securing", 0);
  var0 setclientomnvar("ui_securing_progress", var1.curprogress / var1.usetime);
  var0 scripts\common\utility::allow_weapon_pickup(1, "bomb_use");
  var0 setmovespeedscale(1);
}

function keypad_disable_for_time(var0) {
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
  level notify("bomb_defused", self, var0);
}

function get_carry_item_omnvar(var0, var1) {
  return get_alertreset_alias(var0, var1);
}

function get_alertreset_alias(var0, var1) {
  if(!trial_use_headicon()) {
    return false;
  }

  if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var0 meleeButtonPressed()) {
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

function completepayloadpunish(var0, var1, var2) {
  var3 = self;

  if(!isPlayer(var3)) {
    return;
  }

  var3.movespeedscale = 0;
  var3 setmovespeedscale(0);

  if(!isDefined(var3.movespeedscale)) {
    var3.movespeedscale = 1;
  }

  var4 = &movespeed_get_func;
  var5 = &movespeed_set_func;
  thread player_speed_proc(var3, var0, var1, var4, var5, "blend_movespeedscale");
}

function player_speed_proc(var0, var1, var2, var3, var4, var5) {
  self notify(var4);
  self endon(var4);
  var6 = [[var2]](var5);
  var7 = var0;

  if(isDefined(var1) && var1 > 0) {
    var8 = var7 - var6;
    var9 = 0.05;
    var10 = var1 / var9;
    var11 = var8 / var10;

    while(abs(var7 - var6) > abs(var11 * 1.1)) {
      var6 += var11;
      [[var3]](var6, var5);
      wait var9;
    }
  }

  [[var3]](var7, var5);
}

function movespeed_get_func(var0) {
  if(!isDefined(var0)) {
    var0 = "default";
  }

  if(!isDefined(self.movespeedscales) || !isDefined(self.movespeedscales[var0])) {
    return 1;
  }

  return self.movespeedscales[var0];
}

function movespeed_set_func(var0, var1) {
  var2 = 1;

  if(!isDefined(var1)) {
    var1 = "default";
  }

  self.movespeedscales[var1] = var0;

  foreach(var0 in self.movespeedscales) {
    if(var0 == 1) {
      self.movespeedscales = scripts\engine\utility::array_remove_key(self.movespeedscales, var4);
    }

    var2 *= var0;
  }

  self.movespeedscale = var2;
  self setmovespeedscale(self.movespeedscale);
}

function ref_1243d(var0, var1, var2, var3) {
  if(isDefined(var3)) {
    wait var3;
  }

  if(isDefined(var2)) {
    if(!isDefined(level.waittill_dropped_cash_collected)) {
      level.waittill_dropped_cash_collected = [];
    }

    var4 = level.waittill_dropped_cash_collected[var0];

    if(!isDefined(var4) || scripts\engine\utility::time_has_passed(var4, var2)) {
      level.waittill_dropped_cash_collected[var0] = gettime();
    } else {
      return 0;
    }
  }

  if(isarray(self)) {
    foreach(var6 in self) {
      thread ref_1243a(var6, var0);
    }

    return;
  }

  thread ref_1243a(var0, var1);
}

function ref_1243a(var0, var1) {
  var2 = self;
  var2 endon("disconnect");

  if(isarray(var0)) {
    var0 = scripts\engine\utility::random(var0);
  }

  if(!soundexists(var0)) {
    return false;
  }

  if(istrue(var2.dialogue_playing)) {
    if(isDefined(var1)) {
      var2 scripts\engine\utility::waittill_notify_or_timeout("vo_done", var1);
    }

    if(istrue(var2.dialogue_playing)) {
      return false;
    }
  }

  var2.dialogue_playing = 1;
  var2.current_dialogue = var0;
  var2 playlocalsound(var0);
  wait lookupsoundlength(var0) / 1000;
  var2.dialogue_playing = 0;
  var2.current_dialogue = "";
  var2 notify("vo_done", var0);
  return true;
}

function ref_1238e(var0, var1, var2, var3, var4) {
  [var6] = strtok(var0, "+");
  var7 = scripts\engine\utility::array_remove(var5, var6);
  var8 = scripts\cp\cp_weapon::buildweapon(var6, var7);
  var9 = "weapon_" + var6;
  var10 = scripts\cp\utility::array_merge(var8.attachments, var7);

  foreach(var12 in var10) {
    var9 += "+" + var12;
  }

  var14 = spawn(var9, var1, 1);
  var14.angles = var2;
  var3 = scripts\engine\utility::ter_op(isDefined(var3), var3, weaponclipsize(var6));
  var4 = scripts\engine\utility::ter_op(isDefined(var4), var4, weaponmaxammo(var6));
  var14 itemweaponsetammo(var3, var4);
  return var14;
}