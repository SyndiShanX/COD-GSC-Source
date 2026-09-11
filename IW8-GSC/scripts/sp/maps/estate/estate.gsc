/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\estate\estate.gsc
***********************************************/

function main() {
  level.door_hint_dist_scale = 0.8;
  scripts\sp\maps\estate\gen\estate_art::main();
  scripts\sp\maps\estate\estate_fx::main();
  scripts\sp\maps\estate\estate_lighting::main();
  scripts\sp\maps\estate\estate_precache::main();
  scripts\sp\maps\estate\estate_anim::main();
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
  thread scripts\sp\maps\estate\estate_util::weapon_switch_monitor();
  thread scripts\sp\maps\estate\estate_util::nvg_exterior_monitor();
  setsaveddvar("NKSSQOPQQP", 0);
  setsaveddvar("NKTRLMSRNR", 1);
  setsaveddvar("LLLTQOOTPO", 4);
  setsaveddvar("NPNOOMMTPK", 50);
  setsaveddvar("MRMLLTQQN", 64);
  setsaveddvar("TLMMOPMSK", 1);
  setsaveddvar("OKORSKLQRT", 1);
  var0 = 850;
  setsaveddvar("LRTTMPMQOO", var0);
  setsaveddvar("NTQKQKNRPQ", var0);
  setsaveddvar("RKTKKSMM", var0);
  setsaveddvar("NORSNTKLQ", 150);
  setsaveddvar("TQNRLLORQ", 5);
  setsaveddvar("LSRNSSQNN", 1);
  level.lightswitch_interact_func = &scripts\sp\maps\estate\estate_util::fusebox_interact_anim;
  level.player setviewmodel("viewmodel_arms_kyle_woodland");
  level.player setshadowmodel("default_character_shadow");

  if(!getdvarint("scr_nvg_light_shadow", 1)) {
    scripts\engine\sp\utility::set_nvg_light("player_nvg_light_ext");
  }

  if(getdvarint("greenlight")) {
    level.player hidelegs();
    level.player scripts\common\utility::allow_weapon_pickup(0, "greenlight");
  }

  level.animnodes = [];
  level.is_dark = 1;
  level.dynolight_falloff_dist = 0.5;
  scripts\engine\sp\utility::battlechatter_on("axis");
  reactive_foliage();
  level.fakeactor_spawn_func = &fakeactor_spawn;
  interiors_init();
  level.hassuppressedweapons = 1;
  level.fuseboxes = getEntArray("fusebox", "script_noteworthy");

  foreach(var2 in level.fuseboxes) {
    var2 scripts\sp\maps\estate\estate_util::fusebox_init();
  }

  level.tut_fusebox = getEnt("light_tut_fusebox", "script_noteworthy");
  level.tut_fusebox scripts\sp\maps\estate\estate_util::fusebox_init(1);
  thread scripts\sp\maps\estate\estate_util::floodlights_init();
  scripts\engine\utility::exploder("nvgon");
  thread sfx_dumpster_mantle();
  thread sfx_dumpster_land();
  thread thread_audio_doorpropagation_init();
  thread store_vehicle_nodes_ground_pos();
}

function estate_intro() {
  level.player setclienttriggeraudiozone("fade_to_black_minus_music", 0.05);
  setomnvar("ui_hide_dpad_hud", 1);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  setomnvar("ui_hide_weapon_info", 1);
  var0 = 2;
  scripts\engine\utility::delaythread(var0, &scripts\sp\introscreen::introscreen, 1);
  level.player scripts\engine\utility::delaycall(0.2, &clearclienttriggeraudiozone, 1.2);
  wait var0 + 1.95;
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
  setomnvar("ui_hide_weapon_info", 0);
  scripts\engine\utility::noself_delaycall(6, &setomnvar, "ui_hide_dpad_hud", 0);
}

function estate_precache() {
  precachemodel("uk_electrical_box_medium_01_open");
  precachemodel("veh8_civ_lnd_decho_rebel_mg_armored_darkblue");
  precachemodel("veh8_civ_lnd_decho_rebel_mg_armored_darkblue_dst");
  precachemodel("ee_electronics_mg_searchlight");
  scripts\sp\maps\estate\estate_infil::estate_infil_precache();
  scripts\sp\maps\estate\estate_grounds::estate_grounds_precache();
  scripts\sp\maps\estate\estate_escape::estate_escape_precache();
  thread scripts\sp\player\offhand_box::offhand_box_setup();
  level.player.offhands_list = ["molotov", "flash"];
  scripts\engine\sp\utility::offhandprecache(level.player.offhands_list);
}

function estate_starts() {
  scripts\engine\sp\utility::add_start("intro", &scripts\sp\maps\estate\estate_infil::intro_start, "Intro", &scripts\sp\maps\estate\estate_infil::intro_main, "infil_all", &scripts\sp\maps\estate\estate_infil::intro_catchup);
  scripts\engine\sp\utility::add_start("tall_grass", &scripts\sp\maps\estate\estate_infil::tall_grass_start, "Tall Grass", &scripts\sp\maps\estate\estate_infil::tall_grass_main, "infil_all", &scripts\sp\maps\estate\estate_infil::tall_grass_catchup);
  scripts\engine\sp\utility::add_start("Woods", &scripts\sp\maps\estate\estate_infil::woods_start, "Woods", &scripts\sp\maps\estate\estate_infil::woods_main, "infil_all", &scripts\sp\maps\estate\estate_infil::woods_catchup);
  scripts\engine\sp\utility::add_start("Gate", &scripts\sp\maps\estate\estate_infil::gate_start, "Gate entrance", &scripts\sp\maps\estate\estate_infil::gate_main, "infil_all", &scripts\sp\maps\estate\estate_infil::gate_catchup);
  scripts\engine\sp\utility::add_start("fusebox_tut", &scripts\sp\maps\estate\estate_infil::fusebox_tut_start, "Fusebox Tutorial", &scripts\sp\maps\estate\estate_infil::fusebox_tut_main, "infil_all", &scripts\sp\maps\estate\estate_infil::fusebox_tut_catchup);
  scripts\engine\sp\utility::add_start("Light", &scripts\sp\maps\estate\estate_infil::light_tutorial_start, "Light Tut.", &scripts\sp\maps\estate\estate_infil::light_tutorial_main, "infil_all", &scripts\sp\maps\estate\estate_infil::light_tutorial_catchup);
  scripts\engine\sp\utility::add_start("rappel", &scripts\sp\maps\estate\estate_infil::estate_rappel_start, "Rappel", &scripts\sp\maps\estate\estate_infil::estate_rappel_main, "infil_all", &scripts\sp\maps\estate\estate_infil::estate_rappel_catchup);
  scripts\engine\sp\utility::add_start("find_hvt_1", &scripts\sp\maps\estate\estate_grounds::find_hvt_1_start, "3 HVTs", &scripts\sp\maps\estate\estate_grounds::find_hvt_main, "estate_grounds_detail_tr", undefined);
  scripts\engine\sp\utility::add_start("find_hvt_2", &scripts\sp\maps\estate\estate_grounds::find_hvt_2_start, "2 HVTs + technical", &scripts\sp\maps\estate\estate_grounds::find_hvt_main, "estate_grounds_detail_tr", undefined);
  scripts\engine\sp\utility::add_start("find_hvt_3", &scripts\sp\maps\estate\estate_grounds::find_hvt_3_start, "1 HVT + technical + extra patrols", &scripts\sp\maps\estate\estate_grounds::find_hvt_main, "estate_grounds_detail_tr", &scripts\sp\maps\estate\estate_grounds::find_hvt_catchup);
  scripts\engine\sp\utility::add_start("goto_obj", &scripts\sp\maps\estate\estate_grounds::open_door_start, "Goto the 3rd floor", &scripts\sp\maps\estate\estate_grounds::open_door_main, "estate_grounds_detail_tr", &scripts\sp\maps\estate\estate_grounds::open_door_catchup);
  scripts\engine\sp\utility::add_start("obj_room", &scripts\sp\maps\estate\estate_escape::obj_room_start, "Objective room", &scripts\sp\maps\estate\estate_escape::obj_room_main, "estate_grounds_detail_tr", &scripts\sp\maps\estate\estate_escape::obj_room_catchup);
  scripts\engine\sp\utility::add_start("heli_attack", &scripts\sp\maps\estate\estate_escape::heli_attack_start, "Heli attack", &scripts\sp\maps\estate\estate_escape::heli_attack_main, "estate_grounds_detail_tr", &scripts\sp\maps\estate\estate_escape::heli_attack_catchup);
  scripts\engine\sp\utility::add_start("hallway_run", &scripts\sp\maps\estate\estate_escape::hallway_run_start, "Hallway run", &scripts\sp\maps\estate\estate_escape::hallway_run_main, "estate_grounds_detail_tr", &scripts\sp\maps\estate\estate_escape::hallway_run_catchup);
  scripts\engine\sp\utility::add_start("stairs_explosion", &scripts\sp\maps\estate\estate_escape::stairs_attack_start, "Stairs explosion", &scripts\sp\maps\estate\estate_escape::stairs_attack_main, "estate_grounds_detail_tr", &scripts\sp\maps\estate\estate_escape::stairs_attack_catchup);
  scripts\engine\sp\utility::add_start("escape_intro", &scripts\sp\maps\estate\estate_escape::escape_intro_start, "Escape intro", &scripts\sp\maps\estate\estate_escape::escape_intro_main, "estate_grounds_detail_tr", &scripts\sp\maps\estate\estate_escape::escape_intro_catchup);
  scripts\engine\sp\utility::add_start("escape", &scripts\sp\maps\estate\estate_escape::escape_start, "Escape", &scripts\sp\maps\estate\estate_escape::escape_main, "estate_grounds_detail_tr", &scripts\sp\maps\estate\estate_escape::escape_catchup);
  scripts\engine\sp\utility::add_start("tunnel", &scripts\sp\maps\estate\estate_escape::tunnel_start, "Tunnel", &scripts\sp\maps\estate\estate_escape::tunnel_main, "estate_grounds_detail_tr", &scripts\sp\maps\estate\estate_escape::tunnel_catchup);
  scripts\engine\sp\utility::add_start("arrest", &scripts\sp\maps\estate\estate_escape::arrest_start, "Arrest Hadir", &scripts\sp\maps\estate\estate_escape::arrest_main, "estate_grounds_detail_tr", undefined);
}

function estate_flags() {
  scripts\engine\utility::flag_init("nvg_hint_go");
  scripts\engine\utility::flag_init("player_did_alt_fire");
  scripts\engine\utility::flag_init("did_fire_hint");
  scripts\engine\utility::flag_init("did_hvt_nag");
  level.player scripts\engine\utility::ent_flag_init("switched_weapon_during_tutorial");
  scripts\sp\maps\estate\estate_infil::estate_infil_flags();
  scripts\sp\maps\estate\estate_grounds::estate_grounds_flags();
  scripts\sp\maps\estate\estate_escape::estate_escape_flags();
}

function loadout() {
  level.player takeallweapons();
  level.player scripts\engine\sp\utility::give_offhand("flash");
  GscBinSkip1(0x45, 0, scripts\sp\utility::make_weapon("iw8_sn_mike14", ["rec_mike14|2", "stockcqb_mike14|1", "front_mike14|2", "xmags_mike14|2", "laserir_bar", "silencerdmr_east01", "reflex_west01", "gripangdmr"]));
}

function player_health_difficulty_thread() {
  var0 = -1;

  while(!scripts\engine\utility::flag("grounds_cleared")) {
    var1 = scripts\sp\utility::get_adjusted_difficulty();

    if(var0 != var1) {
      var0 = var1;

      if(var0 < 1) {
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

function spawn_funcs() {
  scripts\engine\sp\utility::add_global_spawn_function("axis", &scripts\sp\maps\estate\estate_util::axis_stealth_spawnfunc);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("escalation_patroller", &scripts\sp\maps\estate\estate_grounds::escalation_patroller_init);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("lone_patroller", &scripts\sp\maps\estate\estate_grounds::init_lone_patroller);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("interrogator", &scripts\sp\maps\estate\estate_grounds::init_interrogator);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("escape_enemies", &scripts\sp\maps\estate\estate_escape::spets_spawn_func);
  getEnt("enemy_heli", "targetname") scripts\engine\sp\utility::add_spawn_function(&scripts\sp\maps\estate\estate_escape::escape_heli_spawn_func);
}

function reactive_foliage() {
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

function fakeactor_spawn() {}

function interiors_init() {
  level.interior_volumes = [];

  foreach(var1 in getEntArray("interior_volume", "targetname")) {
    level.interior_volumes[var1.script_noteworthy] = var1;
  }

  level.player thread scripts\sp\maps\estate\estate_util::indoor_monitor();
}

function store_vehicle_nodes_ground_pos() {
  var0 = getallvehiclenodes();
  var1 = 1;
  var2 = 0;

  foreach(var4 in var0) {
    var4.ground_pos = scripts\common\utility::groundpos(var4.origin);
    var2++;

    if(var2 >= var1) {
      waitframe();
      var2 = 0;
    }
  }
}

function sfx_dumpster_mantle() {
  scripts\engine\utility::flag_init("trig_audio_trashcan");
  wait 1;

  for(;;) {
    scripts\engine\utility::flag_wait("trig_audio_trashcan");
    setglobalsoundcontext("special_foley", "mantle_dumpster");
    scripts\engine\utility::flag_waitopen("trig_audio_trashcan");
    setglobalsoundcontext("special_foley", "");
  }
}

function sfx_dumpster_land() {
  scripts\engine\utility::flag_init("trig_audio_trashcan_land");
  wait 1;

  for(;;) {
    scripts\engine\utility::flag_wait("trig_audio_trashcan_land");
    setglobalsoundcontext("special_land", "land_dumpster");
    scripts\engine\utility::flag_waitopen("trig_audio_trashcan_land");
    setglobalsoundcontext("special_land", "");
  }
}

function thread_audio_doorpropagation_init() {
  level waittill("rappel_end");
  audio_door_sound_clip_init();
}

function audio_door_sound_clip_init() {
  scripts\engine\utility::flag_wait("interactive_doors_ready");
  var0 = [];
  GscBinSkip0(0x2e, 0, "pool_door_1");
}

function audio_door_clip_thread(var0) {
  var1 = scripts\sp\door::get_interactive_door(var0);
  var2 = getEnt(var0 + "_soundclip", "targetname");
  var3 = getEnt(var0 + "_propportal", "targetname");
  var3 enableaudioportal(0);
  thread audio_door_interaction_wait(var1, var2);
}

function audio_door_interaction_wait(var0, var1) {
  while(!self.open_completely) {
    var2 = waittill_door_open_or_notifies("ajar", "bashed");
    audio_door_set_state(1, var0, var1);

    if(istrue(var2)) {
      return;
    }

    var2 = waittill_door_open_or_notifies("reset_door", "first_interact");

    if(istrue(var2)) {
      return;
    }

    audio_door_set_state(0, var0, var1);
  }
}

function audio_door_set_state(var0, var1, var2) {
  var3 = 1;

  if(!var0) {
    var3 = -1;
  }

  var1 movey(var3 * 128, 0.05);
  var2 enableaudioportal(var0);
}

function waittill_door_open_or_notifies(var0, var1) {
  self endon(var0);
  self endon(var1);
  self waittill("open_completely");
  return true;
}