/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\estate\estate.gsc
***********************************************/

main() {
  level.door_hint_dist_scale = 0.8;
  scripts\sp\maps\estate\gen\estate_art.gsc::main();
  scripts\sp\maps\estate\estate_fx.gsc::main();
  scripts\sp\maps\estate\estate_lighting.gsc::main();
  scripts\sp\maps\estate\estate_precache.gsc::main();
  scripts\sp\maps\estate\estate_anim.gsc::main();
  scripts\sp\utility::nvidiaansel_allowduringcinematic(1);
  setsaveddvar("MKNNNONLSK", 4);
  setsaveddvar("MMLNNQSTTL", 10);
  setdvarifuninitialized("greenlight", 0);
  setdvarifuninitialized("use_physics_decho", 1);
  setdvarifuninitialized("use_physics_techo", 1);
  setdvarifuninitialized("swap_flashlight_fx", 1);
  setsaveddvar("LTMPKRLLNM", 256);
  setsaveddvar("OLPNKQKKTT", 128);
  estate_precache();
  scripts\engine\sp\utility::transient_init("estate_infil_start_tr");
  scripts\engine\sp\utility::transient_init("estate_infil_mid_tr");
  scripts\engine\sp\utility::transient_init("estate_infil_end_tr");
  scripts\engine\sp\utility::transient_init("estate_grounds_detail_tr");
  estate_starts();
  estate_flags();
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  scripts\stealth\clear_regions::init_hunt_regions();
  scripts\sp\nvg\nvg_player::main("nvg_estate");
  loadout();
  spawn_funcs();
  thread scripts\sp\maps\estate\estate_util.gsc::weapon_switch_monitor();
  thread scripts\sp\maps\estate\estate_util.gsc::nvg_exterior_monitor();
  setsaveddvar("NKSSQOPQQP", 0);
  setsaveddvar("NKTRLMSRNR", 1);
  setsaveddvar("LLLTQOOTPO", 4);
  setsaveddvar("NPNOOMMTPK", 50);
  setsaveddvar("MRMLLTQQN", 64);
  setsaveddvar("TLMMOPMSK", 1);
  setsaveddvar("OKORSKLQRT", 1);
  var_0 = 850;
  setsaveddvar("LRTTMPMQOO", var_0);
  setsaveddvar("NTQKQKNRPQ", var_0);
  setsaveddvar("RKTKKSMM", var_0);
  setsaveddvar("NORSNTKLQ", 150);
  setsaveddvar("TQNRLLORQ", 5);
  setsaveddvar("LSRNSSQNN", 1);
  level.lightswitch_interact_func = scripts\sp\maps\estate\estate_util.gsc::fusebox_interact_anim;
  level.player setviewmodel("viewmodel_arms_kyle_woodland");
  level.player setshadowmodel("default_character_shadow");

  if(!getdvarint("scr_nvg_light_shadow", 1))
    scripts\engine\sp\utility::set_nvg_light("player_nvg_light_ext");

  if(getdvarint("greenlight")) {
    level.player hidelegs();
    level.player scripts\common\utility::allow_weapon_pickup(0, "greenlight");
  }

  level.animnodes = [];
  level.is_dark = 1;
  level.dynolight_falloff_dist = 0.5;
  scripts\engine\sp\utility::battlechatter_on("axis");
  reactive_foliage();
  level.fakeactor_spawn_func = ::fakeactor_spawn;
  interiors_init();
  level.hassuppressedweapons = 1;
  level.fuseboxes = getEntArray("fusebox", "script_noteworthy");

  foreach(var_2 in level.fuseboxes)
  var_2 scripts\sp\maps\estate\estate_util.gsc::fusebox_init();

  level.tut_fusebox = getEnt("light_tut_fusebox", "script_noteworthy");
  level.tut_fusebox scripts\sp\maps\estate\estate_util.gsc::fusebox_init(1);
  thread scripts\sp\maps\estate\estate_util.gsc::floodlights_init();
  scripts\engine\utility::exploder("nvgon");
  level thread sfx_dumpster_mantle();
  level thread sfx_dumpster_land();
  level thread thread_audio_doorpropagation_init();
  thread store_vehicle_nodes_ground_pos();
}

estate_intro() {
  level.player setclienttriggeraudiozone("fade_to_black_minus_music", 0.05);
  setomnvar("ui_hide_dpad_hud", 1);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  setomnvar("ui_hide_weapon_info", 1);
  var_0 = 2;
  scripts\engine\utility::delaythread(var_0, scripts\sp\introscreen::introscreen, 1);
  level.player scripts\engine\utility::delaycall(0.2, ::clearclienttriggeraudiozone, 1.2);
  wait(var_0 + 1.95);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
  setomnvar("ui_hide_weapon_info", 0);
  scripts\engine\utility::noself_delaycall(6, ::setomnvar, "ui_hide_dpad_hud", 0);
}

estate_precache() {
  precachemodel("uk_electrical_box_medium_01_open");
  precachemodel("veh8_civ_lnd_decho_rebel_mg_armored_darkblue");
  precachemodel("veh8_civ_lnd_decho_rebel_mg_armored_darkblue_dst");
  precachemodel("ee_electronics_mg_searchlight");
  scripts\sp\maps\estate\estate_infil.gsc::estate_infil_precache();
  scripts\sp\maps\estate\estate_grounds.gsc::estate_grounds_precache();
  scripts\sp\maps\estate\estate_escape.gsc::estate_escape_precache();
  thread scripts\sp\player\offhand_box::offhand_box_setup();
  level.player.offhands_list = ["molotov", "flash"];
  scripts\engine\sp\utility::offhandprecache(level.player.offhands_list);
}

estate_starts() {
  scripts\engine\sp\utility::add_start("intro", scripts\sp\maps\estate\estate_infil.gsc::intro_start, "Intro", scripts\sp\maps\estate\estate_infil.gsc::intro_main, "infil_all", scripts\sp\maps\estate\estate_infil.gsc::intro_catchup);
  scripts\engine\sp\utility::add_start("tall_grass", scripts\sp\maps\estate\estate_infil.gsc::tall_grass_start, "Tall Grass", scripts\sp\maps\estate\estate_infil.gsc::tall_grass_main, "infil_all", scripts\sp\maps\estate\estate_infil.gsc::tall_grass_catchup);
  scripts\engine\sp\utility::add_start("Woods", scripts\sp\maps\estate\estate_infil.gsc::woods_start, "Woods", scripts\sp\maps\estate\estate_infil.gsc::woods_main, "infil_all", scripts\sp\maps\estate\estate_infil.gsc::woods_catchup);
  scripts\engine\sp\utility::add_start("Gate", scripts\sp\maps\estate\estate_infil.gsc::gate_start, "Gate entrance", scripts\sp\maps\estate\estate_infil.gsc::gate_main, "infil_all", scripts\sp\maps\estate\estate_infil.gsc::gate_catchup);
  scripts\engine\sp\utility::add_start("fusebox_tut", scripts\sp\maps\estate\estate_infil.gsc::fusebox_tut_start, "Fusebox Tutorial", scripts\sp\maps\estate\estate_infil.gsc::fusebox_tut_main, "infil_all", scripts\sp\maps\estate\estate_infil.gsc::fusebox_tut_catchup);
  scripts\engine\sp\utility::add_start("Light", scripts\sp\maps\estate\estate_infil.gsc::light_tutorial_start, "Light Tut.", scripts\sp\maps\estate\estate_infil.gsc::light_tutorial_main, "infil_all", scripts\sp\maps\estate\estate_infil.gsc::light_tutorial_catchup);
  scripts\engine\sp\utility::add_start("rappel", scripts\sp\maps\estate\estate_infil.gsc::estate_rappel_start, "Rappel", scripts\sp\maps\estate\estate_infil.gsc::estate_rappel_main, "infil_all", scripts\sp\maps\estate\estate_infil.gsc::estate_rappel_catchup);
  scripts\engine\sp\utility::add_start("find_hvt_1", scripts\sp\maps\estate\estate_grounds.gsc::find_hvt_1_start, "3 HVTs", scripts\sp\maps\estate\estate_grounds.gsc::find_hvt_main, "estate_grounds_detail_tr", undefined);
  scripts\engine\sp\utility::add_start("find_hvt_2", scripts\sp\maps\estate\estate_grounds.gsc::find_hvt_2_start, "2 HVTs + technical", scripts\sp\maps\estate\estate_grounds.gsc::find_hvt_main, "estate_grounds_detail_tr", undefined);
  scripts\engine\sp\utility::add_start("find_hvt_3", scripts\sp\maps\estate\estate_grounds.gsc::find_hvt_3_start, "1 HVT + technical + extra patrols", scripts\sp\maps\estate\estate_grounds.gsc::find_hvt_main, "estate_grounds_detail_tr", scripts\sp\maps\estate\estate_grounds.gsc::find_hvt_catchup);
  scripts\engine\sp\utility::add_start("goto_obj", scripts\sp\maps\estate\estate_grounds.gsc::open_door_start, "Goto the 3rd floor", scripts\sp\maps\estate\estate_grounds.gsc::open_door_main, "estate_grounds_detail_tr", scripts\sp\maps\estate\estate_grounds.gsc::open_door_catchup);
  scripts\engine\sp\utility::add_start("obj_room", scripts\sp\maps\estate\estate_escape.gsc::obj_room_start, "Objective room", scripts\sp\maps\estate\estate_escape.gsc::obj_room_main, "estate_grounds_detail_tr", scripts\sp\maps\estate\estate_escape.gsc::obj_room_catchup);
  scripts\engine\sp\utility::add_start("heli_attack", scripts\sp\maps\estate\estate_escape.gsc::heli_attack_start, "Heli attack", scripts\sp\maps\estate\estate_escape.gsc::heli_attack_main, "estate_grounds_detail_tr", scripts\sp\maps\estate\estate_escape.gsc::heli_attack_catchup);
  scripts\engine\sp\utility::add_start("hallway_run", scripts\sp\maps\estate\estate_escape.gsc::hallway_run_start, "Hallway run", scripts\sp\maps\estate\estate_escape.gsc::hallway_run_main, "estate_grounds_detail_tr", scripts\sp\maps\estate\estate_escape.gsc::hallway_run_catchup);
  scripts\engine\sp\utility::add_start("stairs_explosion", scripts\sp\maps\estate\estate_escape.gsc::stairs_attack_start, "Stairs explosion", scripts\sp\maps\estate\estate_escape.gsc::stairs_attack_main, "estate_grounds_detail_tr", scripts\sp\maps\estate\estate_escape.gsc::stairs_attack_catchup);
  scripts\engine\sp\utility::add_start("escape_intro", scripts\sp\maps\estate\estate_escape.gsc::escape_intro_start, "Escape intro", scripts\sp\maps\estate\estate_escape.gsc::escape_intro_main, "estate_grounds_detail_tr", scripts\sp\maps\estate\estate_escape.gsc::escape_intro_catchup);
  scripts\engine\sp\utility::add_start("escape", scripts\sp\maps\estate\estate_escape.gsc::escape_start, "Escape", scripts\sp\maps\estate\estate_escape.gsc::escape_main, "estate_grounds_detail_tr", scripts\sp\maps\estate\estate_escape.gsc::escape_catchup);
  scripts\engine\sp\utility::add_start("tunnel", scripts\sp\maps\estate\estate_escape.gsc::tunnel_start, "Tunnel", scripts\sp\maps\estate\estate_escape.gsc::tunnel_main, "estate_grounds_detail_tr", scripts\sp\maps\estate\estate_escape.gsc::tunnel_catchup);
  scripts\engine\sp\utility::add_start("arrest", scripts\sp\maps\estate\estate_escape.gsc::arrest_start, "Arrest Hadir", scripts\sp\maps\estate\estate_escape.gsc::arrest_main, "estate_grounds_detail_tr", undefined);
}

estate_flags() {
  scripts\engine\utility::flag_init("nvg_hint_go");
  scripts\engine\utility::flag_init("player_did_alt_fire");
  scripts\engine\utility::flag_init("did_fire_hint");
  scripts\engine\utility::flag_init("did_hvt_nag");
  level.player scripts\engine\utility::ent_flag_init("switched_weapon_during_tutorial");
  scripts\sp\maps\estate\estate_infil.gsc::estate_infil_flags();
  scripts\sp\maps\estate\estate_grounds.gsc::estate_grounds_flags();
  scripts\sp\maps\estate\estate_escape.gsc::estate_escape_flags();
}

loadout() {
  level.player takeallweapons();
  level.player scripts\engine\sp\utility::give_offhand("flash");
  var_0[0] = scripts\sp\utility::make_weapon("iw8_sn_mike14", ["rec_mike14|2", "stockcqb_mike14|1", "front_mike14|2", "xmags_mike14|2", "laserir_bar", "silencerdmr_east01", "reflex_west01", "gripangdmr"]);
  var_0[1] = scripts\sp\utility::make_weapon("iw8_pi_golf21", ["silencerpstl_west01"]);

  foreach(var_2 in var_0) {
    var_3 = 0;

    if(issubstr(var_2.basename, "_pi_") || issubstr(var_2.basename, "asierra12"))
      var_3 = 1;

    level.player giveweapon(var_2, 0, 0, 0, var_3);
    level.player scripts\engine\sp\utility::giveweaponmaxammo(var_2);
  }

  level.player switchtoweapon(var_0[0]);
  thread player_health_difficulty_thread();
}

player_health_difficulty_thread() {
  var_0 = -1;

  while(!scripts\engine\utility::flag("grounds_cleared")) {
    var_1 = scripts\sp\utility::get_adjusted_difficulty();

    if(var_0 != var_1) {
      var_0 = var_1;

      if(var_0 < 1) {
        level.player scripts\sp\player::set_player_max_health(level.player.maxhealth);
        level.player scripts\sp\player::scale_player_death_shield_duration(1);
      } else {
        level.player scripts\sp\player::set_player_max_health(80);
        level.player scripts\sp\player::scale_player_death_shield_duration(0.5);
      }
    }

    waitframe();
  }
}

spawn_funcs() {
  scripts\engine\sp\utility::add_global_spawn_function("axis", scripts\sp\maps\estate\estate_util.gsc::axis_stealth_spawnfunc);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("escalation_patroller", scripts\sp\maps\estate\estate_grounds.gsc::escalation_patroller_init);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("lone_patroller", scripts\sp\maps\estate\estate_grounds.gsc::init_lone_patroller);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("interrogator", scripts\sp\maps\estate\estate_grounds.gsc::init_interrogator);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("escape_enemies", scripts\sp\maps\estate\estate_escape.gsc::spets_spawn_func);
  getEnt("enemy_heli", "targetname") scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\estate\estate_escape.gsc::escape_heli_spawn_func);
}

reactive_foliage() {
  setsaveddvar("MKPPNSLNQQ", 50);
  setsaveddvar("MPLOLNMSRO", 35);
  setsaveddvar("NMQSKQNQLR", 7);
  setsaveddvar("NSKKMRPOQQ", 200);
  setsaveddvar("NQQSKRQMTS", 1);
  setsaveddvar("MQPQKNPQOK", 2);
  setsaveddvar("MRNRKKOPLN", 2);
  setsaveddvar("NQTLPTNSSO", 3);
  setsaveddvar("OLSKLTPPMR", 0.7);
  setsaveddvar("LQLSPQOPKM", 50);
  setsaveddvar("NTMMTOLQMQ", (1, 1, 0));
}

fakeactor_spawn() {}

interiors_init() {
  level.interior_volumes = [];

  foreach(var_1 in getEntArray("interior_volume", "targetname"))
  level.interior_volumes[var_1.script_noteworthy] = var_1;

  level.player thread scripts\sp\maps\estate\estate_util.gsc::indoor_monitor();
}

store_vehicle_nodes_ground_pos() {
  var_0 = getallvehiclenodes();
  var_1 = 1;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_4.ground_pos = scripts\common\utility::groundpos(var_4.origin);
    var_2++;

    if(var_2 >= var_1) {
      waitframe();
      var_2 = 0;
    }
  }
}

sfx_dumpster_mantle() {
  scripts\engine\utility::flag_init("trig_audio_trashcan");
  wait 1.0;

  for(;;) {
    scripts\engine\utility::flag_wait("trig_audio_trashcan");
    setglobalsoundcontext("special_foley", "mantle_dumpster");
    scripts\engine\utility::flag_waitopen("trig_audio_trashcan");
    setglobalsoundcontext("special_foley", "");
  }
}

sfx_dumpster_land() {
  scripts\engine\utility::flag_init("trig_audio_trashcan_land");
  wait 1.0;

  for(;;) {
    scripts\engine\utility::flag_wait("trig_audio_trashcan_land");
    setglobalsoundcontext("special_land", "land_dumpster");
    scripts\engine\utility::flag_waitopen("trig_audio_trashcan_land");
    setglobalsoundcontext("special_land", "");
  }
}

thread_audio_doorpropagation_init() {
  level waittill("rappel_end");
  audio_door_sound_clip_init();
}

audio_door_sound_clip_init() {
  scripts\engine\utility::flag_wait("interactive_doors_ready");
  var_0 = [];
  var_0[0] = "pool_door_1";
  var_0[1] = "pool_door_2";
  var_0[2] = "pool_door_3";
  var_0[3] = "pool_door_4";
  var_0[4] = "pool_door_5";

  foreach(var_2 in var_0)
  thread audio_door_clip_thread(var_2);
}

audio_door_clip_thread(var_0) {
  var_1 = scripts\sp\door::get_interactive_door(var_0);
  var_2 = getEnt(var_0 + "_soundclip", "targetname");
  var_3 = getEnt(var_0 + "_propportal", "targetname");
  var_3 enableaudioportal(0);
  var_1 thread audio_door_interaction_wait(var_2, var_3);
}

audio_door_interaction_wait(var_0, var_1) {
  while(!self.open_completely) {
    var_2 = waittill_door_open_or_notifies("ajar", "bashed");
    audio_door_set_state(1, var_0, var_1);

    if(istrue(var_2)) {
      return;
    }
    var_2 = waittill_door_open_or_notifies("reset_door", "first_interact");

    if(istrue(var_2)) {
      return;
    }
    audio_door_set_state(0, var_0, var_1);
  }
}

audio_door_set_state(var_0, var_1, var_2) {
  var_3 = 1;

  if(!var_0)
    var_3 = -1;

  var_1 movey(var_3 * 128, 0.05);
  var_2 enableaudioportal(var_0);
}

waittill_door_open_or_notifies(var_0, var_1) {
  self endon(var_0);
  self endon(var_1);
  self waittill("open_completely");
  return 1;
}