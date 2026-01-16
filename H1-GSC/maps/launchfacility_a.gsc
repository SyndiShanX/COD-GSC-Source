/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\launchfacility_a.gsc
********************************/

dead_script() {
  common_scripts\_ca_blockout::init();
  maps\createart\launchfacility_a_art::main();
  level thread maps\launchfacility_a_fx::main();
  maps\launchfacility_a_precache::main();
  maps\_load::main();
  maps\launchfacility_a_anim::main();
  level thread maps\launchfacility_a_amb::main();
  maps\launchfacility_a_lighting::main();
}

main() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  if(getdvar("beautiful_corner") == "1") {
    dead_script();
    return;
  }

  if(getdvar("debug_bmp") == "")
    setdvar("debug_bmp", "0");

  if(getdvar("debug_launch") == "")
    setdvar("debug_launch", "0");

  initprecache();
  createthreatbiasgroup("player");
  level.team01 = [];
  level.team02 = [];
  level.team03 = [];
  level.cosine["45"] = cos(45);
  level.balconyflag = getent("balcony_flag", "script_noteworthy");
  level.bmpexcluders = [];
  level.hindattacker = undefined;
  level.peoplespeaking = 0;
  level.team01breacher = undefined;
  level.team02breacher = undefined;
  level.team03breacher = undefined;
  level.sniperkills = 0;
  level.sniperconfirmdialogue = 1;
  level.snipertarget = undefined;
  level.sniperinterval = 5;
  level.snipersactive = 0;
  level.playermaxdistancetobmpc4 = 256;
  level.playermaxdistancetobmpc4squared = level.playermaxdistancetobmpc4 * level.playermaxdistancetobmpc4;
  level.playermaxdistancefrombmp = 1024;
  level.playermaxdistancefrombmpsquared = level.playermaxdistancefrombmp * level.playermaxdistancefrombmp;
  level.playerdistancetoai = 256;
  level.playerdistancetoaisquared = level.playerdistancetoai * level.playerdistancetoai;
  level.axiskilledbyplayer = 0;
  level.playerparticipationcontainer = 10;
  level.playerparticipationgate = 15;
  level.minbmpexplosiondmg = 50;
  level.maxbmpexplosiondmg = 100;
  level.bmpcannonrange = 2048;
  level.bmpmgrange = 850;
  level.bmpmgrangesquared = level.bmpmgrange * level.bmpmgrange;
  level.playervehicledamagerange = 256;
  level.playervehicledamagerangesquared = level.playervehicledamagerange * level.playervehicledamagerange;
  level.ent = undefined;
  level.aideletedistance = 512;
  level.enemyarmor = [];
  level.enemyarmorindex = 0;
  level.maxfriendlieskilled = 2;
  level.cosine = [];
  level.cosine["35"] = cos(35);
  level.cosine["45"] = cos(45);
  level.cosine["180"] = cos(180);
  level.color["white"] = (1, 1, 1);
  level.color["red"] = (1, 0, 0);
  level.color["blue"] = (0.1, 0.3, 1);
  level.c4_callback_thread = ::c4_callback_thread_launchfacility;
  level.spawnercallbackthread = ::ai_think;
  level.excludedai = [];
  level.acolornodetriggers = [];
  level.mig29_near_distance_override = 11880;
  var_0 = getentarray("trigger_multiple", "classname");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isdefined(var_0[var_1].script_noteworthy) && getsubstr(var_0[var_1].script_noteworthy, 0, 10) == "colornodes")
      level.acolornodetriggers = common_scripts\utility::array_add(level.acolornodetriggers, var_0[var_1]);
  }

  maps\_utility::add_start("container", ::start_container, & "STARTS_CONTAINER");
  maps\_utility::add_start("tarmac", ::start_tarmac, & "STARTS_TARMAC");
  maps\_utility::add_start("gate", ::start_gate, & "STARTS_GATE");
  maps\_utility::add_start("vents", ::start_vents, & "STARTS_VENTS");
  maps\_utility::default_start(::start_default);
  level.weaponclipmodels = [];
  level.weaponclipmodels[0] = "weapon_m16_clip";
  level.weaponclipmodels[1] = "weapon_saw_clip";
  level.weaponclipmodels[2] = "weapon_ak47_clip";
  level.weaponclipmodels[3] = "weapon_dragunov_clip";
  level.weaponclipmodels[4] = "weapon_g3_clip";
  level.weaponclipmodels[5] = "weapon_g36_clip";
  maps\createart\launchfacility_a_art::main();
  maps\launchfacility_a_precache::main();
  level thread maps\launchfacility_a_fx::main();
  maps\_c4::main();
  thread maps\_leak::main();
  thread common_scripts\_pipes::main();
  maps\_load::main();
  maps\launchfacility_a_anim::main();
  maps\launchfacility_a_lighting::main();
  maps\launchfacility_a_aud::main();
  maps\_nightvision::main();
  maps\_javelin::init();
  maps\_compass::setupminimap("compass_map_launchfacility_a");
  level thread maps\launchfacility_a_amb::main();
  common_scripts\utility::flag_init("aa_first_bmp_section");
  common_scripts\utility::flag_init("aa_container_to_gate_section");
  common_scripts\utility::flag_init("aa_tarmac_bmp01_section");
  common_scripts\utility::flag_init("aa_tarmac_bmp02_section");
  common_scripts\utility::flag_init("bmp_02_spawned");
  common_scripts\utility::flag_init("bmp_03_spawned");
  common_scripts\utility::flag_init("bmp_04_spawned");
  common_scripts\utility::flag_init("obj_gain_access_given");
  common_scripts\utility::flag_init("obj_gain_access_complete");
  common_scripts\utility::flag_init("obj_enemy_armor_given");
  common_scripts\utility::flag_init("obj_enemy_armor_complete");
  common_scripts\utility::flag_init("obj_north_tarmac_given");
  common_scripts\utility::flag_init("obj_north_tarmac_complete");
  common_scripts\utility::flag_init("obj_rappel_given");
  common_scripts\utility::flag_init("obj_rappel_complete");
  common_scripts\utility::flag_init("container_loudspeaker");
  common_scripts\utility::flag_init("friendly_shoots_down_heli");
  common_scripts\utility::flag_init("friendly_shoots_down_heli_new");
  common_scripts\utility::flag_init("enemy_can_blow_up_truck");
  common_scripts\utility::flag_init("hind_intro_dialogue");
  common_scripts\utility::flag_init("friendlies_past_killzone");
  common_scripts\utility::flag_init("inside_perimeter");
  common_scripts\utility::flag_init("stop_alarm");
  common_scripts\utility::flag_init("hind_crash");
  common_scripts\utility::flag_init("heli_attractor_deleted");
  common_scripts\utility::flag_init("flanking_wall_breached");
  common_scripts\utility::flag_init("blow_the_gate");
  common_scripts\utility::flag_init("bmp_02_destroyed");
  common_scripts\utility::flag_init("gate_sequence_starting");
  common_scripts\utility::flag_init("migs_flyby1");
  common_scripts\utility::flag_init("migs_flyby2");
  common_scripts\utility::flag_init("music_gimme_sitrep");
  common_scripts\utility::flag_init("bmp_03_destroyed");
  common_scripts\utility::flag_init("bmp_04_destroyed");
  common_scripts\utility::flag_init("one_bmp_left");
  common_scripts\utility::flag_init("blackhawk_dudes_unloaded");
  common_scripts\utility::flag_init("hinds_appear");
  common_scripts\utility::flag_init("hind_rocket_sequence");
  common_scripts\utility::flag_init("hind_missiles_fired");
  common_scripts\utility::flag_init("vent01_open");
  common_scripts\utility::flag_init("vent02_open");
  common_scripts\utility::flag_init("vent03_open");
  common_scripts\utility::flag_init("rappel_started");
  common_scripts\utility::flag_init("team01_hooked_up");
  common_scripts\utility::flag_init("team02_hooked_up");
  common_scripts\utility::flag_init("team03_hooked_up");
  common_scripts\utility::flag_init("player_reached_kill_max");
  common_scripts\utility::flag_init("level_fade_out");
  precachemodel("projectile_stinger_missile");
  initdifficulty();
  initplayer();
  vehicle_patrol_init();
  disable_color_trigs();
  maps\jake_tools::hideall();
  launch_lid_setup();
  thread migs_flyby1();
  thread migs_flyby2();
  thread sniper_activity();
  thread vent_flashlights();
  common_scripts\utility::array_thread(getvehiclenodearray("plane_sound", "script_noteworthy"), vehicle_scripts\_mig29::plane_sound_node);
  common_scripts\utility::array_thread(getentarray("hostiles_container_runners", "script_noteworthy"), maps\_utility::add_spawn_function, ::ai_chain_and_seek);
  common_scripts\utility::array_thread(getentarray("hostiles_player_seek", "script_noteworthy"), maps\_utility::add_spawn_function, ::ai_player_seek);
  common_scripts\utility::array_thread(getentarray("hostiles_vehicle_support", "script_noteworthy"), maps\_utility::add_spawn_function, ::ai_vehicle_support);
  common_scripts\utility::array_thread(getentarray("enemy_rpd", "script_noteworthy"), maps\_utility::add_spawn_function, ::ai_enemy_rpd);
  var_2 = [];
  var_2[0] = "bmp_02";
  var_2[1] = "bmp_03";
  var_2[2] = "bmp_04";
  thread vehicle_bmp_setup(var_2);
  thread vehicle_truck_setup();
  var_3 = getentarray("c4_plant", "targetname");

  if(var_3.size > 0)
    common_scripts\utility::array_thread(var_3, ::c4_plant_think);
}

debug() {
  thread maps\jake_tools::print3dthread("X", (-6271, -16779, -964), 10);
}

start_default() {
  aa_approach_init();
  soundscripts\_snd::snd_message("start_default_checkpoint");
}

start_container() {
  initfriendlies("container");
  soundscripts\_snd::snd_message("start_container_checkpoint");
}

start_gate() {
  initfriendlies("gate");
  aa_gate_init();
  soundscripts\_snd::snd_message("start_gate_checkpoint");
  wait 0.5;
  common_scripts\utility::flag_set("bmp_02_destroyed");
}

start_tarmac() {
  initfriendlies("tarmac");
  soundscripts\_snd::snd_message("start_tarmac_checkpoint");
}

start_vents() {
  initfriendlies("vents");
  aa_vents_init();
  soundscripts\_snd::snd_message("start_vents_checkpoint");
}

aa_approach_init() {
  common_scripts\utility::flag_set("aa_first_bmp_section");
  thread loudspeaker();
  thread music_intro();
  thread launchfacility_a_intro_dvars();
  thread aa_gate_init();
  initfriendlies("default");
  thread dialogue_intro();
  thread dialogue_c4_hints();
  maps\_utility::battlechatter_off("allies");
  maps\jake_tools::triggersenable("colornodes_approach", "script_noteworthy", 1);
  maps\jake_tools::triggersenable("colornodes_container", "script_noteworthy", 1);
  thread alarm_sound_thread();
  thread obj_gain_access();
  thread reach_container_area();
  thread container_rpg_moment();
  thread exit_container_area();
  thread hind_intro_think();
  thread heli_guy_death();
  thread container_heli_sequence();
  thread flanking_wall_breached();
}

music_intro() {
  common_scripts\utility::flag_wait("music_gimme_sitrep");
  wait 2;
  soundscripts\_snd::snd_message("start_gimme_sitrep_music_mix");

  for (;;) {
    maps\_utility::musicplaywrapper("launch_a_action_music");
    wait 115;
    musicstop(1);
    wait 1.2;
  }
}

launchfacility_a_intro_dvars() {
  common_scripts\utility::flag_wait("introscreen_complete");
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", "0");
}

container_rpg_moment() {
  level endon("exit_container_area");
  common_scripts\utility::flag_wait("reach_container_area");
  common_scripts\utility::flag_wait("heli_attractor_deleted");
  var_0 = getent("volume_containers", "targetname");
  var_1 = getentarray("rpg_source", "targetname");
  var_2 = getentarray("rpg_target", "targetname");
  wait 2;
  thread rpg_ambient(var_1, var_2, 2);
  wait(randomfloatrange(10, 20));

  for (;;) {
    wait 0.5;

    while (!level.player istouching(var_0)) {
      var_3 = randomintrange(1, 3);
      thread rpg_ambient(var_1, var_2, var_3);
      wait(randomfloatrange(10, 20));
    }
  }
}

loudspeaker() {
  common_scripts\utility::flag_wait("container_loudspeaker");
  dialogue_loudspeaker("launchfacility_a_rul_highalert");
  common_scripts\utility::flag_wait("inside_perimeter");
  wait 1;
  level thread dialogue_loudspeaker("launchfacility_a_rul_underattack");
  common_scripts\utility::flag_wait("migs_flyby1");
  wait 7.5;
  dialogue_loudspeaker("launchfacility_a_rul_redspentznaz");

  while (!common_scripts\utility::flag("obj_enemy_armor_complete")) {
    dialogue_loudspeaker("launchfacility_a_rul_motherland");

    if(common_scripts\utility::flag("obj_enemy_armor_complete")) {
      break;
    }

    wait 3;

    if(common_scripts\utility::flag("obj_enemy_armor_complete")) {
      break;
    }

    dialogue_loudspeaker("launchfacility_a_rul_avengefallen");

    if(common_scripts\utility::flag("obj_enemy_armor_complete")) {
      break;
    }

    wait 3;

    if(common_scripts\utility::flag("obj_enemy_armor_complete")) {
      break;
    }

    dialogue_loudspeaker("launchfacility_a_rul_restorehonor");
  }

  dialogue_loudspeaker("launchfacility_a_rul_preptubes");

  for (;;) {
    dialogue_loudspeaker("launchfacility_a_rul_motherland");
    wait 2;
    dialogue_loudspeaker("launchfacility_a_rul_avengefallen");
    wait 3;
    dialogue_loudspeaker("launchfacility_a_rul_restorehonor");
  }
}

dialogue_intro() {
  waittillframeend;
  level.grigsby maps\_utility::delaythread(1.5, maps\_anim::anim_single_solo, level.grigsby, "spin");
  level.peoplespeaking = 1;
  level maps\_utility::radio_dialogue_queue("launchfacility_a_hqr_stillworking");
  common_scripts\utility::flag_set("obj_gain_access_given");
  level.peoplespeaking = 0;
  common_scripts\utility::flag_wait("hind_intro_dialogue");
  var_0 = maps\jake_tools::get_closest_ally();
  level.peoplespeaking = 1;
  maps\_utility::battlechatter_on("allies");
  wait 3;
  level.price maps\jake_tools::dialogue_execute("launchfacility_a_price_gogogo1");
  level maps\_utility::radio_dialogue_queue("launchfacility_a_recon_sniperteamtwo");
  level.price maps\jake_tools::dialogue_execute("launchfacility_a_price_keepposted");
  common_scripts\utility::flag_set("container_loudspeaker");
  level.peoplespeaking = 0;
  wait 5;
  thread dialogue_smoke_hints();
}

dialogue_smoke_hints() {
  common_scripts\utility::flag_wait("bmp_02_spawned");
  level endon("bmp_02_destroyed");
  level endon("bmp_bypassed");
  level endon("player_reached_kill_max");

  if(common_scripts\utility::flag("bmp_02_destroyed")) {
    return;
  }
  common_scripts\utility::flag_wait_either("reach_container_halfwaypoint", "enter_container_area");
  var_0 = 0;
  var_1 = getent("volume_smoke", "targetname");
  var_1.smokethrown = 0;
  var_1 thread maps\jake_tools::smoke_detect();
  thread dialogue_smoke_hints_cleanup(var_1);

  while (var_1.smokethrown == 0) {
    var_0++;

    if(var_0 == 1)
      level maps\_utility::radio_dialogue_queue("launchfacility_a_recon_enemiestonorth");
    else if(var_0 == 2)
      level.price maps\jake_tools::dialogue_execute("launchfacility_a_price_smoke_nag_01");
    else if(var_0 == 3)
      level.grigsby maps\jake_tools::dialogue_execute("launchfacility_a_grigsby_smoke_nag_01");
    else
      break;

    while (isdefined(level.current_hint))
      wait 0.05;

    thread maps\_utility::hint(&"SCRIPT_PLATFORM_LAUNCHFACILITY_A_HINT_SMOKE", 5);
    wait(randomfloatrange(6, 11));
  }

  if(var_1.smokethrown == 0) {
    var_2 = [];
    var_2[0] = level.price;
    var_2[1] = level.grigsby;
    var_3 = common_scripts\utility::get_array_of_closest(level.player.origin, level.squad, var_2);
    var_4 = var_3[var_3.size - 1];

    if(isdefined(var_4) && isalive(var_4)) {
      var_4 thread maps\jake_tools::dialogue_execute("launchfacility_a_marine_01_throwing_smoke");
      var_5 = maps\_vehicle::get_vehicle_from_targetname("bmp_02");
      var_6 = var_4.grenadeweapon;
      var_4.grenadeweapon = "smoke_grenade_american";
      var_4.grenadeammo++;
      var_4 magicgrenademanual(var_5.origin, (0, 0, 0), 0);
      var_1 notify("smoke_has_been_thrown");
      var_4.grenadeweapon = var_6;
    }
  }
}

dialogue_c4_hints() {
  common_scripts\utility::flag_wait("bmp_02_spawned");
  level endon("bmp_02_destroyed");
  level endon("bmp_bypassed");
  level endon("player_reached_kill_max");

  if(common_scripts\utility::flag("bmp_02_destroyed")) {
    return;
  }
  if(common_scripts\utility::flag("bmp_bypassed")) {
    return;
  }
  if(common_scripts\utility::flag("player_reached_kill_max")) {
    return;
  }
  var_0 = getent("volume_smoke", "targetname");
  var_0 waittill("smoke_has_been_thrown");
  wait 2;
  thread bmp_nags("bmp_02_destroyed", 1);
}

dialogue_smoke_hints_cleanup(var_0) {
  var_0 waittill("smoke_has_been_thrown");
  thread maps\_utility::hint_fade();
}

flanking_wall_breached() {
  common_scripts\utility::flag_wait("flanking_wall_breached");

  if(common_scripts\utility::flag("exit_container_area")) {
    return;
  }
  common_scripts\utility::flag_set("exit_container_area");
  var_0 = getent("killspawner_exit_container", "targetname");
  var_0 notify("trigger", level.player);
}

alarm_sound_thread() {
  var_0 = getent("origin_sound_alarm", "targetname");
  var_0 playloopsound("emt_alarm_base_alert");
  common_scripts\utility::flag_wait("stop_alarm");
  var_0 stoploopsound("emt_alarm_base_alert");
}

friendlies_blow_bmp02() {
  level endon("bmp_02_destroyed");
  common_scripts\utility::flag_wait("bmp_bypassed");
  thread squad_bmp_destroy("bmp_02");
}

firemg(var_0, var_1, var_2) {
  self endon("death");

  if(!isdefined(var_2))
    var_2 = level.player;

  if(!isdefined(var_1))
    var_1 = 0;

  self setturrettargetent(var_2, (0, 0, var_1));
  var_3 = 0.1;

  if(!isdefined(var_0))
    var_0 = randomintrange(8, 20);

  self.turretfiring = 1;
  var_4 = 0;

  while (var_4 < var_0) {
    var_4++;
    wait(var_3);
    self fireweapon();
  }

  self.turretfiring = 0;
}

reach_container_area() {
  common_scripts\utility::flag_wait("reach_container_area");
  thread maps\_utility::autosave_by_name("container");
  wait 2;
}

container_heli_sequence() {
  while (!isdefined(level.friendly_at4))
    wait 0.05;

  var_0 = getnode("node_at4_guy", "targetname");
  createthreatbiasgroup("ignored");
  level.friendly_at4 maps\jake_tools::set_threatbiasgroup("ignored");
  setignoremegroup("ignored", "axis");
  setignoremegroup("axis", "ignored");
  level.friendly_at4 maps\jake_tools::set_animname("frnd");
  level.friendly_at4.ignoreme = 1;
  var_0 maps\_anim::anim_reach_solo(level.friendly_at4, "AT4_fire_start");
  level.friendly_at4 allowedstances("crouch");
  common_scripts\utility::flag_wait("friendly_shoots_down_heli_new");
  level.friendly_at4 allowedstances("crouch", "stand", "prone");
  level.friendly_at4 attach("weapon_stinger", "TAG_INHAND");
  var_0 thread maps\_anim::anim_single_solo(level.friendly_at4, "AT4_fire");
  level.friendly_at4 waittillmatch("single anim", "fire");
  var_1 = level.friendly_at4 gettagorigin("TAG_INHAND");
  var_2 = magicbullet("rpg_player", var_1, level.ehindintro.origin);
  var_2 setmodel("projectile_stinger_missile");
  level.friendly_at4 waittillmatch("single anim", "end");
  var_3 = level.friendly_at4 gettagorigin("TAG_INHAND");
  var_4 = level.friendly_at4 gettagangles("TAG_INHAND");
  level.friendly_at4 detach("weapon_stinger", "TAG_INHAND");
  var_5 = spawn("script_model", var_3);
  var_5 setmodel("weapon_stinger");
  var_5.angles = var_4;
  var_0 thread maps\_anim::anim_loop_solo(level.friendly_at4, "AT4_idle", undefined, "stop_idle");
  common_scripts\utility::flag_wait("migs_flyby1");

  if(isdefined(level.friendly_at4)) {
    var_0 notify("stop_idle");

    if(isdefined(level.friendly_at4.magic_bullet_shield))
      level.friendly_at4 maps\_utility::stop_magic_bullet_shield();

    level.friendly_at4 delete();
    var_5 delete();
  }
}

container_heli_sequence2() {
  while (!isdefined(level.friendly_at4))
    wait 0.05;

  var_0 = getnode("node_at4_guy", "targetname");
  createthreatbiasgroup("ignored");
  level.friendly_at4 maps\jake_tools::set_threatbiasgroup("ignored");
  setignoremegroup("ignored", "axis");
  setignoremegroup("axis", "ignored");
  level.friendly_at4 maps\jake_tools::set_animname("frnd");
  level.friendly_at4.ignoreme = 1;
  var_0 maps\_anim::anim_reach_solo(level.friendly_at4, "RPG_conceal_idle_start");
  var_0 thread maps\_anim::anim_loop_solo(level.friendly_at4, "RPG_conceal_idle", undefined, "stop_idle");
  common_scripts\utility::flag_wait("friendly_shoots_down_heli");
  var_0 notify("stop_idle");
  var_0 maps\_anim::anim_single_solo(level.friendly_at4, "RPG_conceal_2_standR");
  var_1 = level.friendly_at4 gettagorigin("TAG_WEAPON_RIGHT");
  magicbullet("rpg_player", var_1, level.ehindintro.origin);
  level.friendly_at4 maps\_anim::anim_single_solo(level.friendly_at4, "RPG_standR_2_conceal");
  var_0 thread maps\_anim::anim_loop_solo(level.friendly_at4, "RPG_conceal_idle", undefined, "stop_idle");
  common_scripts\utility::flag_wait("exit_container_area");

  if(isdefined(level.friendly_at4)) {
    if(isdefined(level.friendly_at4.magic_bullet_shield))
      level.friendly_at4 maps\_utility::stop_magic_bullet_shield();

    level.friendly_at4 delete();
  }
}

hind_crash_failsafe() {
  level.ehindintro endon("death");
  wait 4.75;
  level.ehindintro notify("death");
}

hind_intro_think() {
  level.ehindintro = maps\_vehicle::spawn_vehicle_from_targetname("hind_intro_flyby_01");
  level thread maps\_vehicle::gopath(level.ehindintro);
  var_0 = "tag_origin";
  var_1 = spawn("script_origin", level.ehindintro gettagorigin(var_0));
  var_1 linkto(level.ehindintro, var_0);

  if(getdvar("debug_launch") == "1")
    var_1 thread maps\jake_tools::print3dthread("TARGET");

  wait 3.5;
  level.ehindintro thread firemg(randomintrange(14, 17), 80);
  wait 2;
  level.player playsound("h1r_hind_pass_by");
  wait 2;
  var_2 = getent("hind_intro_target2", "targetname");
  level.ehindintro thread firemg(randomintrange(20, 24), 80, var_2);
  wait 1;
  common_scripts\utility::flag_set("hind_intro_dialogue");
  wait 2;
  common_scripts\utility::flag_set("friendly_shoots_down_heli_new");
  wait 3;
  common_scripts\utility::flag_set("friendly_shoots_down_heli");
  level.ehindintro thread hind_crash_failsafe();
  level.ehindintro thread hind_earthquake();
  wait 1;
  var_3 = missile_createattractorent(var_1, 100000, 60000);
  wait 1;
  level.ehindintro thread firemg(15, 80);
  level.ehindintro waittill("death");
  missile_deleteattractor(var_3);
  common_scripts\utility::flag_set("heli_attractor_deleted");
  level.ehindintro waittill("crash_done");
  common_scripts\utility::flag_set("hind_crash");
  common_scripts\utility::flag_set("stop_alarm");
  wait 0.5;
  var_4 = getent("hind_crash", "targetname");
}

hind_earthquake() {
  self waittill("death");
  earthquake(0.4, 2, self.origin, 4000);
}

hind_intro_think2() {
  var_0 = getent("hind_crash", "script_noteworthy");
  level.ehindintro = maps\_vehicle::waittill_vehiclespawn("hind_intro");
  level.ehindintro setmaxpitchroll(50, 30);
  level.ehindintro vehicle_setspeed(120, 15, 15);
  wait 1;
  common_scripts\utility::flag_set("hind_intro_dialogue");
  wait 0.5;
  level.ehindintro thread firemg(15, 80);
  common_scripts\utility::flag_set("friendly_shoots_down_heli");
  var_1 = missile_createattractorent(level.ehindintro, 10000, 6000);
  level.ehindintro thread hind_crash_failsafe();
  wait 2.5;
  missile_deleteattractor(var_1);
  common_scripts\utility::flag_set("heli_attractor_deleted");
  level.ehindintro waittill("crash_done");
  common_scripts\utility::flag_set("hind_crash");
  common_scripts\utility::flag_set("stop_alarm");
}

heli_guy_death() {
  common_scripts\utility::flag_wait("friendly_shoots_down_heli");
  wait 19;
  var_0 = getent("heli_dude", "targetname");
  var_1 = var_0 stalingradspawn();
  maps\_utility::spawn_failed(var_1);
  var_2 = var_1.origin + (100, -50, -100);
  var_1.skipdeathanim = 1;
  var_1 kill();
  wait 0.1;
  physicsexplosionsphere(var_2, 356, 128, 10);
}

hind_crash_fx() {
  self endon("death");
  wait 1.2;
  playfxontag(level._effect["heli_aerial_explosion"], self, "tag_body");
  thread common_scripts\utility::play_sound_in_space("explo_metal_rand", self.origin);

  for (;;) {
    playfxontag(level._effect["smoke_trail_heli"], self, "tag_engine_right");
    wait 0.01;
  }
}

exit_container_area() {
  common_scripts\utility::flag_wait("exit_container_area");
  thread ignore_friendlies_till_past_killzone();
  var_0 = getent("volume_containers", "targetname");
  var_0 thread ai_in_volume_chase_player();
  thread truck_blows_up();
  thread left_gate_nag();
}

left_gate_nag() {
  level endon("obj_gain_access_complete");
  common_scripts\utility::flag_wait("bmp_02_destroyed");
  var_0 = getent("volume_leftgate", "script_noteworthy");

  for (;;) {
    wait(randomfloatrange(15, 30));

    if(level.player istouching(var_0)) {
      level.dialoguegatehint_number++;

      if(level.dialoguegatehint_number > level.dialoguegatehint_max)
        level.dialoguegatehint_number = 1;

      var_1 = "launchfacility_a_gate_hint_0" + level.dialoguegatehint_number;
      level maps\_utility::radio_dialogue_queue(var_1);
    }
  }
}

truck_blows_up() {
  level endon("right_gate_approach");
  common_scripts\utility::flag_wait("bmp_02_destroyed");
  common_scripts\utility::flag_wait("truck_approach");
  common_scripts\utility::flag_set("enemy_can_blow_up_truck");
  var_0 = level.player geteye();
  var_1 = getent("truck_troops_perimeter", "script_noteworthy");

  while (common_scripts\utility::flag("enemy_can_blow_up_truck")) {
    if(!isdefined(var_1)) {
      return;
    }
    var_2 = common_scripts\utility::within_fov(var_0, level.player getplayerangles(), var_1.origin, level.cosine["45"]);

    if(var_2) {
      break;
    }

    wait 0.05;
  }

  if(!isdefined(var_1)) {
    return;
  }
  var_3 = maps\jake_tools::get_closest_ally();

  if(isdefined(var_3))
    var_3 thread maps\_utility::play_sound_on_entity("US_grg_threat_rpg");

  var_4 = getent("rpg_source_right_1", "script_noteworthy");
  var_5 = getent("truck_rpg_target", "targetname");
  var_6 = missile_createattractorent(var_5, 10000, 6000);
  magicbullet("rpg", var_4.origin, var_5.origin);
  wait 3;
  missile_deleteattractor(var_6);
}

ignore_friendlies_till_past_killzone() {
  var_0 = getent("trig_ignoreme", "targetname");

  for (var_1 = 0; var_1 < level.squad.size; var_1++)
    level.squad[var_1] thread ignoreme_when_in_trigger(var_0);
}

ignoreme_when_in_trigger(var_0) {
  level endon("friendlies_past_killzone");

  for (;;) {
    wait 0.05;
    var_0 waittill("trigger", var_1);

    if(var_1 != self) {
      continue;
    }
    self.ignoreme = 1;
    self.a.disablepain = 1;
    maps\jake_tools::set_maxsightdistsqrd(128);

    while (self istouching(var_0))
      wait 0.05;

    self.ignoreme = 0;
    self.a.disablepain = 0;
    maps\jake_tools::reset_maxsightdistsqrd();
  }
}

aa_gate_init() {
  thread balcony_think();
  thread gate_squad_advance_no_bmp();
  thread gate_left_approach();
  thread gate_right_approach();
  thread gate_right_reach();
  thread gate_player_participation();
  thread gate_sequence();
  var_0 = getent("missile_model03", "targetname");
  var_1 = getent("missile_03_shadow_origin", "targetname");
  var_0 overridelightingorigin(var_1.origin);
  var_2 = getent("missile_model04", "targetname");
  var_3 = getent("missile_04_shadow_origin", "targetname");
  var_2 overridelightingorigin(var_3.origin);
  var_4 = getent("missile_model05", "targetname");
  var_5 = getent("missile_05_shadow_origin", "targetname");
  var_4 overridelightingorigin(var_5.origin);
  var_6 = getent("missile_model06", "targetname");
  var_7 = getent("missile_06_shadow_origin", "targetname");
  var_6 overridelightingorigin(var_7.origin);
}

balcony_think() {
  level endon("gate_sequence_starting");
  common_scripts\utility::flag_wait("reached_balcony");
  level thread gate_blowup();
  var_0 = getent("obj_gain_access", "targetname");
  var_1 = maps\jake_tools::get_closest_ally(var_0);
  var_1 maps\jake_tools::dialogue_execute("launchfacility_a_marine1_gate_blow");
  wait 1;
  common_scripts\utility::flag_set("blow_the_gate");
}

gate_squad_advance_no_bmp() {
  common_scripts\utility::flag_wait("bmp_02_destroyed");
  common_scripts\utility::flag_clear("aa_first_bmp_section");
  common_scripts\utility::flag_set("aa_container_to_gate_section");
  disable_color_trigs();
  maps\jake_tools::triggersenable("colornodes_gate_no_bmp", "script_noteworthy", 1);
  var_0 = getent("killspawner_exit_container", "targetname");
  var_0 notify("trigger", level.player);
  var_1 = getent("volume_containers", "targetname");
  var_2 = maps\jake_tools::getaiarraytouchingvolume("axis", undefined, var_1);

  if(var_2.size > 0) {
    for (var_3 = 0; var_3 < var_2.size; var_3++)
      var_2[var_3].health = 1;

    thread maps\_utility::ai_delete_when_out_of_sight(var_2, level.aideletedistance);
  }

  wait 2;

  while (level.peoplespeaking)
    wait 0.5;

  level.peoplespeaking = 1;
  level maps\_utility::radio_dialogue_queue("launchfacility_a_cmd_sitrep");
  common_scripts\utility::flag_set("music_gimme_sitrep");
  level.price maps\jake_tools::dialogue_execute("launchfacility_a_price_were_inside");
  level.peoplespeaking = 0;
  common_scripts\utility::flag_set("inside_perimeter");
  wait 1.5;
}

gate_left_approach() {
  common_scripts\utility::flag_wait("reached_left_gate");

  if(getdvar("debug_bmp") == "1")
    return;
}

gate_right_approach() {
  common_scripts\utility::flag_wait("right_gate_approach");
  level.peoplespeaking = 1;
  level.grigsby maps\jake_tools::dialogue_execute("launchfacility_a_griggs_moreground");
  level.price maps\jake_tools::dialogue_execute("launchfacility_a_price_alreadygot");
  level.peoplespeaking = 0;
  common_scripts\utility::flag_set("migs_flyby1");
}

gate_right_push_forward() {
  level endon("blow_the_gate");
  common_scripts\utility::flag_wait("migs_flyby1");
  wait 8;
  var_0 = getent("retreat_gate", "targetname");

  while (!level.player istouching(var_0))
    wait 3;

  level.price maps\jake_tools::dialogue_execute("launchfacility_a_pri_breachgate");
}

gate_player_participation() {
  level endon("reached_balcony");
  level endon("gate_sequence_starting");
  common_scripts\utility::flag_wait("bmp_02_destroyed");
  level thread player_kill_counter(level.playerparticipationgate);
  common_scripts\utility::flag_clear("player_reached_kill_max");
  wait 0.5;
  common_scripts\utility::flag_wait("player_reached_kill_max");

  if(getdvar("debug_bmp") == "1") {}

  var_0 = getentarray("reached_right_gate_additional", "targetname");
  var_1 = getentarray("reached_right_gate", "targetname");

  for (var_2 = 0; var_2 < var_0.size; var_2++)
    var_0[var_2] common_scripts\utility::trigger_on();

  common_scripts\utility::array_thread(var_0, ::gate_right_reach_trig_wait);
  level waittill("level_ent_updated");

  for (var_2 = 0; var_2 < var_0.size; var_2++)
    var_0[var_2] notify("cancel");

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_1[var_2] notify("cancel");

  common_scripts\utility::flag_set("gate_sequence_starting");
}

gate_right_reach() {
  level endon("reached_balcony");
  var_0 = getentarray("reached_right_gate", "targetname");
  common_scripts\utility::array_thread(var_0, ::gate_right_reach_trig_wait);
  level waittill("level_ent_updated");

  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] notify("cancel");

  common_scripts\utility::flag_set("gate_sequence_starting");
}

gate_sequence() {
  common_scripts\utility::flag_wait("gate_sequence_starting");
  thread maps\_utility::autosave_by_name("right_gate");
  var_0 = level.ent stalingradspawn();
  maps\_utility::spawn_failed(var_0);
  var_0 thread friendly_blows_gate();
  level thread gate_blowup();
}

c4_detonation_beep() {
  var_0 = getent("gate_explosives", "targetname");
  thread common_scripts\utility::play_sound_in_space("h1_launch_a_c4_plant", var_0.origin);
  wait 1;

  while (!common_scripts\utility::flag("blow_the_gate")) {
    thread common_scripts\utility::play_sound_in_space("h1_launch_a_c4_plant_beep", var_0.origin);
    wait 1;
  }
}

gate_blowup() {
  thread maps\_utility::autosave_by_name("gate_being_blown");
  var_0 = getentarray("killspawners_gate", "script_noteworthy");

  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] notify("trigger", level.player);

  common_scripts\utility::flag_wait("blow_the_gate");
  common_scripts\utility::flag_clear("aa_container_to_gate_section");
  common_scripts\utility::flag_set("aa_tarmac_bmp01_section");
  common_scripts\_exploder::exploder(500);
  var_2 = getent("gate_explosives", "targetname");
  thread common_scripts\utility::play_sound_in_space("h1_launch_a_c4_gate", var_2.origin);
  radiusdamage(var_2.origin, 256, 200, 50);
  earthquake(0.6, 1, var_2.origin, 2000);
  disable_color_trigs();
  maps\jake_tools::triggersenable("colornodes_tarmac_front", "script_noteworthy", 1);
  maps\jake_tools::triggersenable("colornodes_tarmac_rear", "script_noteworthy", 1);
  maps\jake_tools::triggersenable("colornodes_tarmac_always_on", "script_noteworthy", 1);
  var_3 = getent("colornodes_tarmac_front_start", "targetname");
  var_3 notify("trigger", level.player);
  var_4 = getentarray("triggers_bmp_tarmac", "script_noteworthy");

  for (var_1 = 0; var_1 < var_4.size; var_1++)
    var_4[var_1] notify("trigger", level.player);

  common_scripts\utility::flag_set("obj_gain_access_complete");
  thread maps\_utility::autosave_by_name("gate_blown");
  thread aa_tarmac_init();
  var_5 = getentarray("volumes_perimeter", "script_noteworthy");
  var_6 = [];
  var_7 = undefined;

  for (var_1 = 0; var_1 < var_5.size; var_1++) {
    var_7 = undefined;
    var_7 = maps\jake_tools::getaiarraytouchingvolume("axis", undefined, var_5[var_1]);

    if(var_7.size > 0)
      var_6 = maps\_utility::array_merge(var_6, var_7);
  }

  if(var_6.size > 0) {
    for (var_1 = 0; var_1 < var_6.size; var_1++)
      var_6[var_1].health = 1;

    thread maps\_utility::ai_delete_when_out_of_sight(var_6, level.aideletedistance);
  }
}

friendly_blows_gate() {
  self endon("death");
  maps\_utility::disable_ai_color();
  self.animname = "frnd";
  maps\jake_tools::invulnerable(1);
  self.ignoreme = 1;
  maps\_utility::setflashbangimmunity(1);
  level.peoplespeaking = 1;
  thread maps\jake_tools::dialogue_execute("launchfacility_a_marine1_gate_blow");
  soundscripts\_snd::snd_message("start_blow_the_gate_mix");
  var_0 = getent("node_gate_destroy", "targetname");
  var_1 = getnode(var_0.target, "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "C4_gate_plant_start");
  var_2 = getent("gate_explosives", "targetname");
  var_0 thread maps\_anim::anim_single_solo(self, "C4_gate_plant");
  self waittillmatch("single anim", "c4plant");
  self attach("weapon_c4", "TAG_INHAND");
  self waittillmatch("single anim", "c4swap");
  self detach("weapon_c4", "TAG_INHAND");
  var_3 = self gettagorigin("TAG_INHAND");
  var_4 = self gettagangles("TAG_INHAND");
  var_5 = spawn("script_model", var_3);
  var_5 setmodel("weapon_c4");
  var_5.angles = var_4;
  thread maps\jake_tools::dialogue_execute("launchfacility_a_marine2_gate_getback");
  thread c4_detonation_beep();
  maps\jake_tools::setgoalradius(var_1.radius);
  self setgoalnode(var_1);
  self waittill("goal");
  wait 0.5;
  maps\jake_tools::resetgoalradius();
  maps\jake_tools::dialogue_execute("launchfacility_a_marine2_fireinhole");
  level.peoplespeaking = 0;
  common_scripts\utility::flag_set("blow_the_gate");
  var_5 delete();
  wait 1;
  maps\_utility::enable_ai_color();
  wait 6;
  maps\jake_tools::invulnerable(0);
  self.ignoreme = 0;
}

gate_right_reach_trig_wait() {
  self endon("cancel");
  level endon("player_in_balcony");
  var_0 = getent(self.script_linkto, "script_linkname");
  self waittill("trigger");
  level.ent = var_0;
  level notify("level_ent_updated");
}

aa_tarmac_init() {
  common_scripts\utility::flag_set("friendlies_past_killzone");
  soundscripts\_snd::snd_message("start_tarmac_mix");
  thread tarmac_colornodes_think();
  common_scripts\utility::array_thread(level.squad, ::tarmac_friendly_engagement_think);
  thread reach_tarmac_halfwaypoint();
  thread tarmac_objectives();
  thread obj_enemy_armor();
  thread dialogue_tarmac_hints();
  thread proceed_to_vents();
}

tarmac_objectives() {
  maps\_vehicle::waittill_vehiclespawn("bmp_04");
  level.peoplespeaking = 1;
  level.price thread maps\jake_tools::dialogue_execute("launchfacility_a_price_tothetarmac");
  level.peoplespeaking = 0;
  wait 5;
  level.peoplespeaking = 1;
  level.grigsby maps\jake_tools::dialogue_execute("launchfacility_a_griggs_morebmps");
  level.price maps\jake_tools::dialogue_execute("launchfacility_a_price_knockemout");
  level.peoplespeaking = 0;
  common_scripts\utility::flag_set("obj_enemy_armor_given");
  common_scripts\utility::flag_wait_either("bmp_03_destroyed", "bmp_04_destroyed");
  common_scripts\utility::flag_set("one_bmp_left");
  common_scripts\utility::flag_clear("aa_tarmac_bmp01_section");
  common_scripts\utility::flag_set("aa_tarmac_bmp02_section");
  wait 4;
  common_scripts\utility::flag_set("migs_flyby2");
}

dialogue_tarmac_hints() {
  common_scripts\utility::flag_wait("obj_enemy_armor_given");
  wait 10;

  if(common_scripts\utility::flag("one_bmp_left")) {
    return;
  }
  level.peoplespeaking = 1;
  level.grigsby maps\jake_tools::dialogue_execute("launchfacility_a_griggs_userpghint");
  level.peoplespeaking = 0;
  wait 10;

  if(common_scripts\utility::flag("one_bmp_left")) {
    return;
  }
  level.peoplespeaking = 1;
  level.grigsby maps\jake_tools::dialogue_execute("launchfacility_a_griggs_vehicles_hint_01");
  level.peoplespeaking = 0;
  wait 13;
  thread bmp_nags("obj_enemy_armor_complete", 0, 1);
}

tarmac_friendly_engagement_think() {
  self endon("death");
}

reach_tarmac_halfwaypoint() {
  common_scripts\utility::flag_wait("reach_tarmac_halfwaypoint");
  common_scripts\utility::flag_set("player_near_launchtube_03");
  wait 2;
  common_scripts\utility::flag_set("player_near_launchtube_04");
  wait 1;
}

ignoreme_thread(var_0) {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  if(!isdefined(self)) {
    return;
  }
  self.ignoreme = var_0;
}

tarmac_colornodes_think() {
  thread bmp_03_colornodes();
  thread bmp_04_colornodes();
}

bmp_03_colornodes() {
  level endon("obj_enemy_armor_complete");
  common_scripts\utility::flag_wait("bmp_03_destroyed");
  maps\jake_tools::triggersenable("colornodes_tarmac_front", "script_noteworthy", 0);
  maps\jake_tools::triggersenable("colornodes_tarmac_bmp_04_dead", "script_noteworthy", 0);
  maps\jake_tools::triggersenable("colornodes_tarmac_bmp_03_dead", "script_noteworthy", 1);
  var_0 = getentarray("colornodes_tarmac_bmp_03_dead", "script_noteworthy");
  var_1 = common_scripts\utility::getclosest(level.player.origin, var_0);
  var_1 notify("trigger", level.player);
}

bmp_04_colornodes() {
  level endon("obj_enemy_armor_complete");
  common_scripts\utility::flag_wait("bmp_04_destroyed");
  maps\jake_tools::triggersenable("colornodes_tarmac_rear", "script_noteworthy", 0);
  maps\jake_tools::triggersenable("colornodes_tarmac_bmp_03_dead", "script_noteworthy", 0);
  maps\jake_tools::triggersenable("colornodes_tarmac_bmp_04_dead", "script_noteworthy", 1);
  var_0 = getentarray("colornodes_tarmac_bmp_04_dead", "script_noteworthy");
  var_1 = common_scripts\utility::getclosest(level.player.origin, var_0);
  var_1 notify("trigger", level.player);
}

proceed_to_vents() {
  common_scripts\utility::flag_wait("obj_enemy_armor_complete");
  level.price.ignoresuppression = 1;
  level.grigsby.ignoresuppression = 1;
  thread aa_vents_init();
  var_0 = getaiarray("axis");
  thread maps\_utility::ai_delete_when_out_of_sight(var_0, level.aideletedistance);
  common_scripts\utility::flag_set("player_near_launchtube_06");
  wait 2;
  common_scripts\utility::flag_set("player_near_launchtube_05");
}

aa_vents_init() {
  soundscripts\_snd::snd_message("start_vents_mix");
  thread blackhawk_arrive();
  thread vents_objectives();
  thread vents_friendly_movement();
  thread hind_rocket_sequence();
  thread obj_north_tarmac();
  thread obj_rappel();
  thread player_rappel();
  thread vent_sequence();
  thread hind_attack();
  thread level_end();
}

vents_objectives() {
  wait 1;
  common_scripts\utility::flag_set("obj_north_tarmac_given");
  common_scripts\utility::flag_wait("obj_rappel_given");
  common_scripts\utility::flag_set("obj_north_tarmac_complete");
}

blackhawk_arrive() {
  thread blackhawk_think();
  wait 1;
  var_0 = getent("trigger_blackhawk", "script_noteworthy");
  var_0 notify("trigger", level.player);
  wait 7;
  level.peoplespeaking = 1;
  level maps\_utility::radio_dialogue("launchfacility_a_friendlies_east");
  level.price maps\jake_tools::dialogue_execute("launchfacility_a_price_copyteamthree");
  level.peoplespeaking = 0;
  thread vent_dialogue();
}

vent_dialogue() {
  level waittill("cutting_vents");
  level thread maps\_utility::radio_dialogue_queue("launchfacility_a_gm3_cutvents");
  level thread maps\_utility::radio_dialogue_queue("launchfacility_a_gm1_cutting");
}

blackhawk_think() {
  var_0 = maps\_vehicle::waittill_vehiclespawn("blackhawk");
  var_1 = var_0.riders;
  common_scripts\utility::array_thread(var_1, ::ai_friendly_reinforcements_think, var_0);
  common_scripts\utility::array_thread(var_1, ::attach_saw, "chopperTeam");
  common_scripts\utility::array_thread(var_1, maps\_utility::set_ignoresuppression, 1);
  var_0 waittill("unloading");
  common_scripts\utility::flag_set("blackhawk_dudes_unloaded");
  wait 11;
  var_2 = common_scripts\utility::getstruct("blackhawk_depart_path", "script_noteworthy");
  var_0 maps\_utility::vehicle_detachfrompath();
  var_0 thread maps\_utility::vehicle_dynamicpath(var_2, 0);
}

ai_friendly_reinforcements_think(var_0) {
  self endon("death");
  self.ignoreme = 1;
  wait 0.5;

  if(isdefined(self.script_noteworthy) && self.script_noteworthy == "pilot") {
    if(isdefined(self.magic_bullet_shield))
      maps\_utility::stop_magic_bullet_shield();
  }

  var_0 waittill("unloading");
}

vents_friendly_movement() {
  disable_color_trigs();
  maps\jake_tools::triggersenable("colornodes_vents", "script_noteworthy", 1);
  var_0 = getent("colornodes_vents", "script_noteworthy");
  var_0 notify("trigger", level.player);
  thread team02_rappel();
  thread team03_rappel();
  common_scripts\utility::flag_wait("team01_hooked_up");
  level.price thread maps\jake_tools::dialogue_execute("launchfacility_a_price_ropesout_01");
  common_scripts\utility::flag_set("obj_rappel_given");
  thread vent_nag();
  wait 2;
  common_scripts\utility::flag_set("hinds_appear");
}

vent_explode(var_0) {
  var_1 = getent("exploder_sound_" + var_0, "targetname");
  thread common_scripts\utility::play_sound_in_space("detpack_explo_metal", var_1.origin);
  common_scripts\_exploder::exploder(var_0);
}

vent_sequence() {
  if(getdvarint("use_old_ventsequence") == 1) {
    vent_sequence_preh1();
    return;
  }

  level.team01_sawguysfinished = 0;
  level.team01_sawguysinposition = 0;
  level.team01_ventopen = 0;
  var_0 = getent("vent_team_01", "targetname");
  var_1 = getentarray("node_rappel_team_1", "targetname");
  var_2 = getentarray("node_saw_team_1", "targetname");
  level.team01 = [];
  level.team01[0] = level.price;
  level.team01[1] = level.grigsby;
  var_3 = getaiarray("allies");
  var_4 = [];

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
    if(maps\_utility::is_in_array(level.team01, var_3[var_5])) {
      continue;
    }
    if(maps\_utility::is_in_array(level.team02, var_3[var_5])) {
      continue;
    }
    if(maps\_utility::is_in_array(level.team03, var_3[var_5])) {
      continue;
    }
    var_4[var_4.size] = var_3[var_5];
  }

  level.team01[2] = common_scripts\utility::getclosest(var_0.origin, var_4);
  level.team01[0].rappelnode = var_2[0];
  level.team01[1].rappelnode = var_2[1];
  level.team01[2].rappelnode = var_1[0];
  var_6 = getent("vent_02", "targetname");
  var_6 thread vent_drop();
  common_scripts\utility::array_thread(level.team01, ::friendly_vent_think, level.team01, "01", var_6, "01");
  level.team02_sawguysfinished = 0;
  level.team02_sawguysinposition = 0;
  level.team02_ventopen = 0;
  var_7 = getent("vent_team_02", "targetname");
  var_8 = getentarray("node_rappel_team_2", "targetname");
  var_9 = getentarray("node_saw_team_2", "targetname");
  level.team03_sawguysfinished = 0;
  level.team03_sawguysinposition = 0;
  level.team03_ventopen = 0;
  var_10 = getent("vent_team_03", "targetname");
  var_11 = getentarray("node_rappel_team_3", "targetname");
  var_12 = getentarray("node_saw_team_3", "targetname");
  level.team02 = maps\_utility::array_removedead(level.team02);
  level.team02 = common_scripts\utility::get_array_of_closest(var_7.origin, level.team02, undefined, level.team02.size);
  common_scripts\utility::flag_wait("blackhawk_dudes_unloaded");
  level.team03 = maps\_utility::array_removedead(level.team03);
  level.team03 = common_scripts\utility::get_array_of_closest(var_10.origin, level.team03, undefined, level.team03.size);
  level.team03[2].rappelnode = var_9[0];
  level.team03[3].rappelnode = var_9[1];
  level.team02[2].rappelnode = var_8[0];
  var_13 = getent("vent_03", "targetname");
  var_13 thread vent_drop();
  level.team03[0].rappelnode = var_12[0];
  level.team03[1].rappelnode = var_12[1];
  level.team02[0].rappelnode = var_11[0];
  level.team02[1].rappelnode = var_11[1];
  var_14 = getent("vent_01", "targetname");
  var_14 thread vent_drop();
  level.team03[0] thread friendly_vent_think(level.team03, "03", var_14, "03");
  level.team03[1] thread friendly_vent_think(level.team03, "03", var_14, "03");
  level.team02[0] thread friendly_vent_think(level.team02, "02", var_14, "03");
  level.team02[1] thread friendly_vent_think(level.team02, "02", var_14, "03");
  level.team03[2] thread friendly_vent_think(level.team03, "03", var_13, "02");
  level.team03[3] thread friendly_vent_think(level.team03, "03", var_13, "02");
  level.team02[2] thread friendly_vent_think(level.team02, "02", var_13, "02");
}

vent_sequence_preh1() {
  level.team01_sawguysfinished = 0;
  level.team01_sawguysinposition = 0;
  level.team01_ventopen = 0;
  var_0 = getent("vent_team_01", "targetname");
  var_1 = getentarray("node_rappel_team_1", "targetname");
  var_2 = getentarray("node_saw_team_1", "targetname");
  level.team01 = [];
  level.team01[0] = level.price;
  level.team01[1] = level.grigsby;
  var_3 = getaiarray("allies");
  var_4 = [];

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
    if(maps\_utility::is_in_array(level.team01, var_3[var_5])) {
      continue;
    }
    if(maps\_utility::is_in_array(level.team02, var_3[var_5])) {
      continue;
    }
    if(maps\_utility::is_in_array(level.team03, var_3[var_5])) {
      continue;
    }
    var_4[var_4.size] = var_3[var_5];
  }

  level.team01[2] = common_scripts\utility::getclosest(var_0.origin, var_4);
  level.team01 = common_scripts\utility::get_array_of_closest(var_0.origin, level.team01, undefined, level.team01.size);
  level.team01[0].rappelnode = var_2[0];
  level.team01[1].rappelnode = var_2[1];
  level.team01[2].rappelnode = var_1[0];
  var_6 = getent("vent_02", "targetname");
  var_6 thread vent_drop();
  common_scripts\utility::array_thread(level.team01, ::friendly_vent_think_preh1, level.team01, "01", var_6);
  level.team02_sawguysfinished = 0;
  level.team02_sawguysinposition = 0;
  level.team02_ventopen = 0;
  var_0 = getent("vent_team_02", "targetname");
  var_7 = getentarray("node_rappel_team_2", "targetname");
  var_8 = getentarray("node_saw_team_2", "targetname");
  level.team02 = maps\_utility::array_removedead(level.team02);
  level.team02 = common_scripts\utility::get_array_of_closest(var_0.origin, level.team02, undefined, level.team02.size);
  level.team02[0].rappelnode = var_8[0];
  level.team02[1].rappelnode = var_8[1];
  level.team02[2].rappelnode = var_7[0];
  var_6 = getent("vent_03", "targetname");
  var_6 thread vent_drop();
  common_scripts\utility::array_thread(level.team02, ::friendly_vent_think_preh1, level.team02, "02", var_6);
  level.team03_sawguysfinished = 0;
  level.team03_sawguysinposition = 0;
  level.team03_ventopen = 0;
  var_0 = getent("vent_team_03", "targetname");
  var_9 = getentarray("node_rappel_team_3", "targetname");
  var_10 = getentarray("node_saw_team_3", "targetname");
  common_scripts\utility::flag_wait("blackhawk_dudes_unloaded");
  level.team03 = maps\_utility::array_removedead(level.team03);
  level.team03 = common_scripts\utility::get_array_of_closest(var_0.origin, level.team03, undefined, level.team03.size);
  level.team03[0].rappelnode = var_10[0];
  level.team03[1].rappelnode = var_10[1];
  level.team03[2].rappelnode = var_9[0];
  level.team03[3].rappelnode = var_9[1];
  var_6 = getent("vent_01", "targetname");
  var_6 thread vent_drop();
  common_scripts\utility::array_thread(level.team03, ::friendly_vent_think_preh1, level.team03, "03", var_6);
}

saw_notify_start(var_0) {
  var_0 notify("start_sparks");
}

saw_notify_stop(var_0) {
  var_0 notify("stop");
}

saw_notify_switch(var_0) {
  var_0 notify("switch");
}

saw_notify_pickup(var_0) {
  var_0 notify("saw_pickup");
}

saw_sound_and_fx(var_0, var_1, var_2) {
  self waittill("saw_pickup");
  self notify("delete_saw");
  self attach("weapon_saw_rescue", "TAG_INHAND");
  var_3 = self.rappelnode.script_parameters;
  var_4 = "saw_" + var_3 + "_object";
  self setanimlimited(maps\_utility::getanim_from_animname(var_4, "frnd"), 1);

  if(var_0 == "1")
    thread maps\_utility::play_sound_on_entity(level.scr_sound["launch_chopsaw1"]);
  else
    thread maps\_utility::play_sound_on_entity(level.scr_sound["launch_chopsaw2"]);

  self waittill("start_sparks");
  thread saw_sparks();
  self waittill("stop");
  self notify("stop_sparks");
  var_1 notify("rapeller_ready");
  self waittill("start_sparks");
  thread saw_sparks();
  self waittill("stop");
  self notify("stop_sparks");

  if(isdefined(var_2) && var_2 == 1)
    var_1 notify("vent_drop");

  self waittill("switch");
  var_5 = self gettagorigin("TAG_INHAND");
  var_6 = self gettagangles("TAG_INHAND");
  self detach("weapon_saw_rescue", "TAG_INHAND");
  var_7 = spawn("script_model", var_5);
  var_7 setmodel("weapon_saw_rescue");
  var_7.angles = var_6;
}

vent_drop() {
  var_0 = spawn("script_origin", self.origin + (0, 0, -350));
  self waittill("vent_drop");
  maps\_utility::ent_flag_set("vent_dropping");
  thread common_scripts\utility::play_sound_in_space("launch_grate_falling", var_0.origin);
  var_1 = 2.5;
  var_2 = self.angles + (0, 0, 25);
  self movez(-1000, var_1, var_1 / 3);
  self rotateto(var_2, 1, 0.2);
  wait(var_1);
  self hide();
}

saw_sparks() {
  self endon("stop_sparks");

  for (;;) {
    playfxontag(common_scripts\utility::getfx("saw_sparks"), self, "TAG_SPARKS");
    wait 0.1;
  }
}

friendly_vent_think(var_0, var_1, var_2, var_3) {
  if(!isdefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  if(!isdefined(self.rappelnode)) {
    return;
  }
  self.issawdude = 0;
  var_4 = undefined;
  self pushplayer(1);
  self.hookedup = 0;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = maps\_utility::spawn_anim_model("rope");
  self.rappelnode thread maps\_anim::anim_first_frame_solo(var_7, "rappel_setup_start");
  var_7 hide();

  switch (var_3) {
    case "01":
      if(self != level.price && self != level.grigsby)
        level.othersquadfriendly = self;

      var_5 = "team01_hooked_up";
      var_6 = "vent02_open";

      if(!var_2 maps\_utility::ent_flag_exist("vent_dropping"))
        var_2 maps\_utility::ent_flag_init("vent_dropping");

      break;
    case "02":
      var_5 = "team02_hooked_up";
      var_6 = "vent03_open";

      if(!var_2 maps\_utility::ent_flag_exist("vent_dropping"))
        var_2 maps\_utility::ent_flag_init("vent_dropping");

      break;
    case "03":
      var_5 = "team03_hooked_up";
      var_6 = "vent01_open";

      if(!var_2 maps\_utility::ent_flag_exist("vent_dropping"))
        var_2 maps\_utility::ent_flag_init("vent_dropping");

      break;
  }

  if(issubstr(self.rappelnode.targetname, "node_saw_team")) {
    self.issawdude = 1;
    var_8 = self.rappelnode.script_parameters;
    maps\_utility::disable_ai_color();
    var_9 = getnode("team_" + var_1 + "_saw_start_node_" + var_8, "targetname");

    if(var_1 == "01") {
      get_to_node_no_matter_what(var_9, 30);
      wait 2;
    } else {
      self setgoalnode(var_9);
      self waittill("goal");
    }

    switch (var_1) {
      case "01":
        if(level.team01_sawguysinposition == 0)
          var_4 = 0;
        else
          var_4 = 1;

        level.team01_sawguysinposition++;

        while (level.team01_sawguysinposition != 2)
          wait 0.05;

        break;
      case "02":
        if(level.team02_sawguysinposition == 0)
          var_4 = 0;
        else
          var_4 = 1;

        level.team02_sawguysinposition++;

        while (level.team02_sawguysinposition != 2)
          wait 0.05;

        break;
      case "03":
        if(level.team03_sawguysinposition == 0)
          var_4 = 0;
        else
          var_4 = 1;

        level.team03_sawguysinposition++;

        while (level.team03_sawguysinposition != 4)
          wait 0.05;

        break;
    }

    wait(randomfloatrange(0.5, 0.75));
    self.disablearrivals = 1;
    self.rappelnode maps\_anim::anim_reach_solo(self, "saw_" + var_8 + "_start");
    level notify("cutting_vents");
    thread saw_sound_and_fx(var_8, var_2, var_4);
    self.rappelnode maps\_anim::anim_single_solo(self, "saw_" + var_8);

    if(self.issawdude == 1)
      self setgoalpos(self.origin);

    thread vent_flag(var_3, var_6);
  }

  if(self.issawdude == 0)
    var_2 waittill("rapeller_ready");

  var_10 = undefined;
  var_11 = undefined;

  if(isdefined(self.rappelnode) && isdefined(self.rappelnode.script_noteworthy) && self.rappelnode.script_noteworthy == "rappel_variation_1") {
    var_10 = "rappel_setup_to_stand_1";
    var_11 = "rappel_stand_idle_1";
  } else if(isdefined(self.rappelnode) && isdefined(self.rappelnode.script_noteworthy) && self.rappelnode.script_noteworthy == "rappel_variation_2") {
    var_10 = "rappel_setup_to_stand_2";
    var_11 = "rappel_stand_idle_2";
  } else {
    var_10 = "rappel_setup_to_stand_2";
    var_11 = "rappel_stand_idle_3";
  }

  maps\_utility::disable_ai_color();

  if(self.issawdude == 0)
    self.rappelnode maps\_anim::anim_reach_solo(self, var_10);

  if(self.issawdude == 0 && !var_2 maps\_utility::ent_flag("vent_dropping")) {
    thread maps\_anim::orient_to_entity_until_flags(var_2, maps\_utility::make_array(var_6));
    var_2 maps\_utility::ent_flag_wait("vent_dropping");
    wait 0.5;
  }

  var_7 show();
  self.rappelnode thread maps\_anim::anim_single_solo(var_7, var_10);
  self.rappelnode maps\_anim::anim_single_solo(self, var_10);
  self.rappelnode thread maps\_anim::anim_loop_solo(self, var_11, undefined, "stop_idle");
  self.rappelnode thread maps\_anim::anim_loop_solo(var_7, var_11, undefined, "stop_idle");
  self.hookedup = 1;
  var_12 = 1;

  for (var_13 = 0; var_13 < var_0.size; var_13++) {
    if(!isdefined(var_0[var_13].hookedup)) {
      continue;
    }
    if(var_0[var_13].hookedup == 0)
      var_12 = 0;
  }

  if(var_12)
    common_scripts\utility::flag_set(var_5);

  if(self == level.price || self == level.grigsby)
    self waittill("rappel_down_vent");
  else
    wait(randomfloatrange(1, 3));

  self.rappelnode notify("stop_idle");
  self.rappelnode thread maps\_anim::anim_single_solo(var_7, "rappel_drop");
  self.rappelnode maps\_anim::anim_single_solo(self, "rappel_drop");

  if(isdefined(self.magic_bullet_shield))
    maps\_utility::stop_magic_bullet_shield();

  self delete();
}

friendly_vent_think_preh1(var_0, var_1, var_2) {
  if(!isdefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  if(!isdefined(self.rappelnode)) {
    return;
  }
  self.issawdude = 0;
  var_3 = undefined;
  self pushplayer(1);
  self.hookedup = 0;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = maps\_utility::spawn_anim_model("rope");
  self.rappelnode thread maps\_anim::anim_first_frame_solo(var_6, "rappel_setup_start");
  var_6 hide();

  switch (var_1) {
    case "01":
      if(self != level.price && self != level.grigsby)
        level.othersquadfriendly = self;

      var_4 = "team01_hooked_up";
      var_5 = "vent02_open";
      break;
    case "02":
      var_4 = "team02_hooked_up";
      var_5 = "vent03_open";
      break;
    case "03":
      var_4 = "team03_hooked_up";
      var_5 = "vent01_open";
      break;
  }

  if(issubstr(self.rappelnode.targetname, "node_saw_team")) {
    self.issawdude = 1;
    var_7 = self.rappelnode.script_parameters;
    maps\_utility::disable_ai_color();
    var_8 = getnode("team_" + var_1 + "_saw_start_node_" + var_7, "targetname");

    if(var_1 == "01")
      get_to_node_no_matter_what(var_8, 30);
    else {
      self setgoalnode(var_8);
      self waittill("goal");
    }

    switch (var_1) {
      case "01":
        if(level.team01_sawguysinposition == 0)
          var_3 = 0;
        else
          var_3 = 1;

        level.team01_sawguysinposition++;

        while (level.team01_sawguysinposition != 2)
          wait 0.05;

        break;
      case "02":
        if(level.team02_sawguysinposition == 0)
          var_3 = 0;
        else
          var_3 = 1;

        level.team02_sawguysinposition++;

        while (level.team02_sawguysinposition != 2)
          wait 0.05;

        break;
      case "03":
        if(level.team03_sawguysinposition == 0)
          var_3 = 0;
        else
          var_3 = 1;

        level.team03_sawguysinposition++;

        while (level.team03_sawguysinposition != 2)
          wait 0.05;

        break;
    }

    wait(randomfloatrange(0.5, 0.75));
    self.disablearrivals = 1;
    self.rappelnode maps\_anim::anim_reach_solo(self, "saw_" + var_7 + "_start");
    level notify("cutting_vents");
    thread saw_sound_and_fx(var_7, var_2, var_3);
    self.rappelnode maps\_anim::anim_single_solo(self, "saw_" + var_7);

    if(self.issawdude == 1)
      self setgoalpos(self.origin);

    thread vent_flag(var_1, var_5);
  }

  if(self.issawdude == 0)
    common_scripts\utility::flag_wait(var_5);

  var_9 = undefined;
  var_10 = undefined;

  if(isdefined(self.rappelnode) && isdefined(self.rappelnode.script_noteworthy) && self.rappelnode.script_noteworthy == "rappel_variation_1") {
    var_9 = "rappel_setup_to_stand_1";
    var_10 = "rappel_stand_idle_1";
  } else if(isdefined(self.rappelnode) && isdefined(self.rappelnode.script_noteworthy) && self.rappelnode.script_noteworthy == "rappel_variation_2") {
    var_9 = "rappel_setup_to_stand_2";
    var_10 = "rappel_stand_idle_2";
  } else {
    var_9 = "rappel_setup_to_stand_2";
    var_10 = "rappel_stand_idle_3";
  }

  maps\_utility::disable_ai_color();

  if(self.issawdude == 0)
    self.rappelnode maps\_anim::anim_reach_solo(self, var_9);

  var_6 show();
  self.rappelnode thread maps\_anim::anim_single_solo(var_6, var_9);
  self.rappelnode maps\_anim::anim_single_solo(self, var_9);
  self.rappelnode thread maps\_anim::anim_loop_solo(self, var_10, undefined, "stop_idle");
  self.rappelnode thread maps\_anim::anim_loop_solo(var_6, var_10, undefined, "stop_idle");
  self.hookedup = 1;
  var_11 = 1;

  for (var_12 = 0; var_12 < var_0.size; var_12++) {
    if(!isdefined(var_0[var_12].hookedup)) {
      continue;
    }
    if(var_0[var_12].hookedup == 0)
      var_11 = 0;
  }

  if(var_11)
    common_scripts\utility::flag_set(var_4);

  if(self == level.price || self == level.grigsby)
    self waittill("rappel_down_vent");
  else
    wait(randomfloatrange(1, 3));

  self.rappelnode notify("stop_idle");
  self.rappelnode thread maps\_anim::anim_single_solo(var_6, "rappel_drop");
  self.rappelnode maps\_anim::anim_single_solo(self, "rappel_drop");

  if(isdefined(self.magic_bullet_shield))
    maps\_utility::stop_magic_bullet_shield();

  self delete();
}

get_to_node_no_matter_what(var_0, var_1) {
  thread teleport_or_timeout(var_0, var_1);
  self setgoalnode(var_0);
  self waittill("goal");
  self.madeittogoal = 1;
}

teleport_or_timeout(var_0, var_1) {
  wait 5;
  self endon("goal");
  common_scripts\utility::waittill_notify_or_timeout("bad_path", var_1);
  thread teleport_behind_player_back(var_0);
}

teleport_behind_player_back(var_0) {
  while (!isdefined(self.madeittogoal)) {
    wait 0.05;
    var_1 = level.player geteye();
    var_2 = common_scripts\utility::within_fov(var_1, level.player getplayerangles(), var_0.origin, level.cosine["45"]);

    if(!var_2 && !isdefined(self.madeittogoal)) {
      self forceteleport(var_0.origin, var_0.angles);
      break;
    }
  }
}

rope_anim(var_0, var_1, var_2, var_3) {
  var_0 maps\_anim::anim_single_solo(var_1, var_2);
  var_0 thread maps\_anim::anim_loop_solo(var_1, var_3, undefined, "stop_idle");
}

vent_flag(var_0, var_1) {
  switch (var_0) {
    case "01":
      level.team01_sawguysfinished++;

      while (level.team01_sawguysfinished != 2)
        wait 0.05;

      break;
    case "02":
      level.team02_sawguysfinished++;

      while (level.team02_sawguysfinished != 2)
        wait 0.05;

      break;
    case "03":
      level.team03_sawguysfinished++;

      while (level.team03_sawguysfinished != 2)
        wait 0.05;

      break;
  }

  if(!common_scripts\utility::flag(var_1))
    common_scripts\utility::flag_set(var_1);
}

team03_rappel() {
  common_scripts\utility::flag_wait("team03_hooked_up");
  level thread maps\_utility::radio_dialogue_queue("launchfacility_a_gm3_rapellingnow");
  wait 3;
  level thread maps\_utility::radio_dialogue_queue("launchfacility_a_marine3_teamin");
}

team02_rappel() {
  common_scripts\utility::flag_wait("team02_hooked_up");
  level thread maps\_utility::radio_dialogue_queue("launchfacility_a_marine2_rappelling");
}

trigger_monitor_player_lean() {
  self endon("stop_monitor_lean");

  for (;;) {
    if(level.player isleaning())
      common_scripts\utility::trigger_off();
    else
      common_scripts\utility::trigger_on();

    waitframe();
  }
}

player_rappel() {
  var_0 = getnode("player_rappel_node", "targetname");
  var_1 = maps\_utility::spawn_anim_model("player_rope");
  var_1 hide();
  common_scripts\utility::flag_wait("obj_rappel_given");
  var_2 = getent("obj_rappel", "targetname");
  var_3 = spawn("script_model", var_2.origin);
  var_3 setmodel("rope_coil");
  var_3.angles = var_2.angles;
  var_4 = spawn("script_model", var_2.origin);
  var_4 setmodel("rope_coil_obj");
  var_4.angles = var_2.angles;
  var_5 = getent("trig_rappel", "targetname");
  var_5 sethintstring(&"SCRIPT_PLATFORM_HINTSTR_RAPPEL");
  var_5 thread trigger_monitor_player_lean();

  for (;;) {
    var_5 waittill("trigger");
    waitframe();

    if(!level.player isleaning()) {
      var_5 notify("stop_monitor_lean");
      break;
    }
  }

  level.player playsound("rappel_clipout_plr");
  thread rappel_rumble();
  soundscripts\_snd::snd_message("start_rappel_mix");
  var_5 common_scripts\utility::trigger_off();
  var_4 delete();
  common_scripts\utility::flag_set("obj_rappel_complete");
  level.player enableinvulnerability();
  level.player disableweapons();
  maps\_utility::enable_scuff_footsteps_sound(0);
  level.player allowlean(0);
  thread player_squad_rappel();
  var_6 = maps\_utility::spawn_anim_model("player_rappel");
  var_6 hide();
  var_0 maps\_anim::anim_first_frame_solo(var_6, "rappel");
  var_6 maps\_utility::lerp_player_view_to_tag("tag_player", 0.5, 0.9, 35, 35, 45, 0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player playerlinktodelta(var_6, "tag_player", 0.9, 5, 5, 45, 0);
  level.player common_scripts\utility::delaycall(3.25, ::lerpviewangleclamp, 0.25, 0, 0, 5, 5, 45, 35);
  var_6 show();
  var_1 show();
  var_0 thread maps\_anim::anim_single_solo(var_6, "rappel");
  var_0 notify("stop_idle");
  var_0 thread maps\_anim::anim_single_solo(var_1, "rappel_for_player");
}

rappel_rumble() {
  var_0 = [];
  var_0 = maps\_utility::rumble_sequence_add_key(var_0, 0.23, "generic_attack_light_500");
  var_0 = maps\_utility::rumble_sequence_add_key(var_0, 1.05, "generic_attack_light_2000");
  var_0 = maps\_utility::rumble_sequence_add_key(var_0, 2.37, "generic_attack_light_1500");
  var_0 = maps\_utility::rumble_sequence_add_key(var_0, 3.46, "generic_attack_light_1500");
  var_0 = maps\_utility::rumble_sequence_add_key(var_0, 4.48, "generic_attack_light_1500");
  var_0 = maps\_utility::rumble_sequence_add_key(var_0, 5.54, "generic_attack_light_2000");
  var_0 = maps\_utility::rumble_sequence_add_key(var_0, 7.28, "generic_attack_light_1000");
  level.player thread maps\_utility::rumble_sequence_play(var_0);
}

player_squad_rappel() {
  wait 1.2;
  level.price notify("rappel_down_vent");
  wait 1;
  level.grigsby notify("rappel_down_vent");
  common_scripts\utility::flag_set("rappel_down_vent_started");
  wait 2;
  level thread maps\_utility::radio_dialogue("launchfacility_a_price_inside_facility");
  wait 0.75;
  wait 0.25;
  common_scripts\utility::flag_set("level_fade_out");
}

hind_attack() {
  common_scripts\utility::flag_wait("hinds_appear");
  var_0 = getentarray("hind_attack_point_higher", "script_noteworthy");
  var_1 = getentarray("hind_attack_point_lower", "script_noteworthy");
  wait 1.5;
  thread hind_attack_think(var_0, "hind_end_higher");
  thread hind_attack_think(var_1, "hind_end_lower");
  thread hind_sequence();
}

hind_sequence() {
  thread maps\_utility::autosave_by_name("hinds_closing");

  if(!common_scripts\utility::flag("obj_rappel_complete")) {
    level.peoplespeaking = 1;
    level maps\_utility::radio_dialogue_queue("launchfacility_a_recon_two_helis");
    level.peoplespeaking = 0;
    wait 4.6;
    common_scripts\utility::flag_set("hind_rocket_sequence");
  }
}

hind_rocket_sequence() {
  level endon("obj_rappel_complete");
  common_scripts\utility::flag_wait("hind_rocket_sequence");
  var_0 = getent("rocket_target", "targetname");
  var_1 = getent("rocket_damage", "targetname");
  var_1 thread hind_tree_explosion();
  var_1 thread hind_tree_fx(var_0);
  level.hindattacker setlookatent(var_0);
  var_2 = maps\jake_tools::get_closest_ally();

  if(isdefined(var_2))
    var_2 maps\jake_tools::dialogue_execute("launchfacility_a_gm1_incoming");

  wait 0.5;
  level.hindattacker maps\_helicopter_globals::fire_missile("ffar_hind_nodamage", 2, var_0, 0.75);
  wait 0.5;
  level.hindattacker clearlookatent();
  wait 3;
  common_scripts\utility::flag_set("hind_missiles_fired");
}

hind_tree_explosion() {
  level endon("hind_missiles_fired");
  var_0 = getent("rocket_target", "targetname");

  for (;;) {
    self waittill("damage", var_1, var_2);

    if(isplayer(var_2)) {
      continue;
    }
    var_3 = randomintrange(1, 4);
    thread common_scripts\utility::play_sound_in_space("launch_rocket_hit_treeline", var_0.origin);
    earthquake(0.8, 2, var_0.origin, 2000);
    var_4 = randomfloatrange(0, 150);
    playfx(common_scripts\utility::getfx("hind_explosion"), var_0.origin + (var_4, 0, 0));
  }
}

hind_tree_fx(var_0) {
  self waittill("damage", var_1, var_2);

  if(isplayer(var_2)) {
    return;
  }
  thread hind_trees_fall();
  var_3 = getentarray("tree_fire", "targetname");

  for (var_4 = 0; var_4 < var_3.size; var_4++)
    playfx(level._effect["tree_fire_fx"][var_4], var_3[var_4].origin);

  var_0 thread common_scripts\utility::play_loopsound_in_space("medfire");
}

hind_trees_fall() {
  var_0 = getentarray("trees_end", "script_noteworthy");
  var_1 = 18;
  var_2 = 35;

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = randomfloatrange(0.5, 1.5);
    var_5 = var_0[var_3].angles;
    var_5 = var_5 + (randomfloatrange(var_1, var_2), randomfloatrange(var_1, var_2), randomfloatrange(var_1, var_2));
    var_0[var_3] thread hind_tree_rotate(var_5, var_4);
  }
}

hind_tree_rotate(var_0, var_1) {
  self rotateto(var_0, var_1, var_1 / 2, var_1 / 2);
}

hind_go_to_vent() {
  if(!isdefined(self)) {
    return;
  }
  common_scripts\utility::flag_wait("obj_rappel_complete");
  var_0 = getent("hind_above_vent", "targetname");
  self clearlookatent();
  self vehicle_setspeed(200, 15, 15);
  self setvehgoalpos(var_0.origin, 1);
}

hind_attack_think(var_0, var_1) {
  level endon("obj_rappel_complete");
  var_2 = maps\_vehicle::spawn_vehicle_from_targetname(var_1);
  var_2 vehicle_turnengineoff();
  var_3 = spawn("script_origin", var_2.origin);
  var_3 linkto(var_2);
  var_3 playloopsound("launch_a_vent_hind_low_engine");

  if(isdefined(var_2.script_noteworthy) && var_2.script_noteworthy == "hind_rocket_attacker")
    level.hindattacker = var_2;

  var_2 endon("death");

  if(var_1 == "hind_end_lower")
    var_2 thread hind_go_to_vent();

  var_4 = getent(var_2.target, "targetname");
  var_2 vehicle_setspeed(120, 15, 15);
  var_2 setneargoalnotifydist(500);
  var_5 = getent(var_4.target, "targetname");
  var_2 setvehgoalpos(var_5.origin, 0);
  var_2 waittill("near_goal");
  var_2 maps\_utility::vehicle_detachfrompath();
  var_2 thread hind_guns_think();
  var_6 = getent(var_5.script_linkto, "script_linkname");
  var_2 setvehgoalpos(var_6.origin, 1);
  var_2 waittill("near_goal");
  var_3 stoploopsound("launch_a_vent_hind_low_engine");
  var_2 setlookatent(level.player);
  var_2 vehicle_setspeed(30, 15, 15);
  var_5 = var_6;
  var_7 = 0;

  for (;;) {
    var_7 = 0;

    if(isdefined(var_5.script_linkto)) {
      var_8 = getsubstr(var_5.targetname, 7);
      var_9 = getent("strafe_volume_" + var_8, "targetname");

      if(level.player istouching(var_9)) {
        var_5 = getent(var_5.script_linkto, "script_linkname");
        var_2 clearlookatent();
        var_2 vehicle_setspeed(200, 15, 15);
        var_7 = 1;
      }
    }

    if(var_7 == 0) {
      var_5 = getent(var_5.target, "targetname");
      var_2 setlookatent(level.player);
      var_2 vehicle_setspeed(30, 15, 15);
    }

    var_2 setvehgoalpos(var_5.origin, 0);
    var_2 waittill("near_goal");
  }
}

hind_guns_think() {
  level endon("obj_rappel_complete");
  self endon("death");
  common_scripts\utility::flag_wait("hind_missiles_fired");

  for (;;) {
    wait(randomfloatrange(2, 5));
    thread firemg(randomintrange(8, 17));
    wait(randomfloatrange(2, 5));
  }
}

level_end() {
  common_scripts\utility::flag_wait("level_fade_out");
  maps\_loadout_code::saveplayerweaponstatepersistent("launchfacility_a");
  maps\_utility::nextmission();
}

vent_nag() {
  level endon("obj_rappel_complete");
  wait 6.5;
  thread vent_nag_cleanup();

  if(!common_scripts\utility::flag("obj_rappel_complete"))
    thread maps\_utility::hint(&"LAUNCHFACILITY_A_HINTSTR_RAPPEL_DOWN_SHAFT", 9999);

  while (!common_scripts\utility::flag("obj_rappel_complete")) {
    wait(randomfloatrange(6, 10));
    level.launchfacility_a_price_ropenag_number++;

    if(level.launchfacility_a_price_ropenag_number > level.launchfacility_a_price_ropenag_max)
      level.launchfacility_a_price_ropenag_number = 1;

    var_0 = "launchfacility_a_price_ropenag_0" + level.launchfacility_a_price_ropenag_number;
    level.price maps\jake_tools::dialogue_execute(var_0);
  }
}

vent_nag_cleanup() {
  common_scripts\utility::flag_wait("obj_rappel_complete");
  thread maps\_utility::hint_fade();
}

friendly_breach_vent(var_0, var_1) {
  self endon("death");
  maps\_utility::disable_ai_color();
  var_2 = getent("node_scripted_vent_" + var_0, "script_noteworthy");
  var_2 maps\_anim::anim_reach_solo(self, "C4_plant_start");
  var_2 maps\_anim::anim_single_solo(self, "C4_plant");
  maps\_utility::enable_ai_color();
  wait 3;

  switch (var_0) {
    case "01":
      thread vent_explode(600);
      break;
    case "02":
      thread vent_explode(700);
      break;
    case "03":
      thread vent_explode(800);
      break;
  }

  common_scripts\utility::flag_set(var_1);
}

aa_utility() {}

initdifficulty() {
  var_0 = maps\_utility::getdifficulty();
  level.skill = undefined;

  switch (var_0) {
    case "easy":
    case "gimp":
      level.skill = "easy";
      break;
    case "medium":
      level.skill = "medium";
      break;
    case "difficult":
    case "hard":
      level.skill = "hard";
      break;
    case "fu":
      level.skill = "veteran";
      break;
  }

  var_1 = getentarray("gameskill_easy", "script_noteworthy");
  var_2 = getentarray("gameskill_medium", "script_noteworthy");

  switch (level.skill) {
    case "medium":
      common_scripts\utility::array_thread(var_1, ::deleteweapons);
      break;
    case "veteran":
    case "hard":
      common_scripts\utility::array_thread(var_1, ::deleteweapons);
      common_scripts\utility::array_thread(var_2, ::deleteweapons);
      break;
  }
}

bmp_nags(var_0, var_1, var_2) {
  level endon(var_0);

  while (!common_scripts\utility::flag(var_0)) {
    level.launchfacility_a_price_bmp_nag_number++;

    if(level.launchfacility_a_price_bmp_nag_number > level.launchfacility_a_price_bmp_nag_max)
      level.launchfacility_a_price_bmp_nag_number = 1;

    var_3 = "launchfacility_a_price_bmp_nag_0" + level.launchfacility_a_price_bmp_nag_number;

    if(level.launchfacility_a_price_bmp_nag_number == 7 || level.launchfacility_a_price_bmp_nag_number == 8)
      level.grigsby maps\jake_tools::dialogue_execute(var_3);
    else
      level.price maps\jake_tools::dialogue_execute(var_3);

    if(isdefined(var_1) && var_1 == 1) {
      while (isdefined(level.current_hint))
        wait 0.05;

      thread maps\_utility::hint(&"SCRIPT_PLATFORM_LAUNCHFACILITY_A_HINT_PLANT_C4_GLOW", 7);
    }

    if(isdefined(var_2) && var_2 == 1) {
      wait(randomfloatrange(20, 30));
      continue;
    }

    wait(randomfloatrange(10, 15));
  }
}

deleteweapons() {
  if(isdefined(self))
    self delete();
}

migs_flyby1() {
  common_scripts\utility::flag_wait("migs_flyby1");
  var_0 = getent("trigger_migs_intro", "script_noteworthy");
  var_0 notify("trigger", level.player);
}

migs_flyby2() {
  common_scripts\utility::flag_wait("migs_flyby2");
  var_0 = getent("trigger_migs_end", "script_noteworthy");
  var_0 notify("trigger", level.player);
}

sniper_activity() {
  level.asniper_orgs = getentarray("sniper_position_container", "targetname");
  common_scripts\utility::flag_wait("obj_gain_access_complete");
  level.asniper_orgs = getentarray("sniper_position_tarmac", "targetname");
}

rpg_ambient(var_0, var_1, var_2) {
  var_3 = 0;

  while (var_3 < var_2) {
    var_3++;
    var_4 = common_scripts\utility::getfarthest(level.player.origin, var_0);
    var_0 = common_scripts\utility::array_remove(var_0, var_4);
    var_5 = common_scripts\utility::getclosest(level.player.origin, var_1);
    var_1 = common_scripts\utility::array_remove(var_1, var_5);
    magicbullet("rpg", var_4.origin, var_5.origin);
    wait(randomfloatrange(1.5, 2.5));
  }
}

c4_plant_think() {
  var_0 = self.script_noteworthy;
  var_1 = getent(self.target, "targetname");
  var_1 waittill("trigger");
  maps\_c4::c4_location(undefined, (0, 0, 0), (0, 0, 0), self.origin);
  self waittill("c4_detonation");
  common_scripts\_exploder::exploder(var_0);
  thread common_scripts\utility::play_sound_in_space("detpack_explo_concrete");

  if(isdefined(level.c4_callback_thread))
    self thread[[level.c4_callback_thread]]();
}

launch_lid_setup() {
  thread launch_lid_think("03");
  thread launch_lid_think("04");
  thread launch_lid_think("05");
  thread launch_lid_think("06");
}

launch_flag_management(var_0) {
  var_1 = "player_near_launchtube_" + var_0;
  common_scripts\utility::flag_wait(var_1);
  var_2 = undefined;
  wait 2;

  if(var_0 == "03")
    var_2 = "player_near_launchtube_04";

  if(var_0 == "04")
    var_2 = "player_near_launchtube_03";

  if(var_0 == "05")
    var_2 = "player_near_launchtube_06";

  if(var_0 == "06")
    var_2 = "player_near_launchtube_05";

  if(!common_scripts\utility::flag(var_2))
    common_scripts\utility::flag_set(var_2);
}

launch_lid_think(var_0) {
  thread launch_flag_management(var_0);
  var_1 = "player_near_launchtube_" + var_0;
  var_2 = getent("lid_arm_" + var_0, "targetname");
  var_3 = getent("lid_" + var_0, "targetname");
  var_4 = getent("lid_model_" + var_0, "targetname");
  var_4 linkto(var_3);
  var_5 = getent("lid_arm_model_" + var_0, "targetname");
  var_5 linkto(var_2);
  var_3.trigger = getent("trigger_hurt_player_lid_" + var_0, "targetname");
  var_3.trigger enablelinkto();
  var_6 = getent("lid_fx_" + var_0, "targetname");
  var_6.opening = 0;
  var_7 = getent("lid_origin_" + var_0, "targetname");
  var_3.rotationdummy = spawn("script_origin", (0, 0, 0));
  var_3.rotationdummy.angles = var_7.angles;
  var_3.rotationdummy.origin = var_7.origin;
  var_2.rotationdummy = spawn("script_origin", (0, 0, 0));
  var_2.rotationdummy.angles = var_7.angles;
  var_2.rotationdummy.origin = var_7.origin;
  var_3 linkto(var_3.rotationdummy);
  var_2 linkto(var_2.rotationdummy);
  var_3.trigger linkto(var_3.rotationdummy);
  var_8 = getent("missile" + var_0, "targetname");
  var_9 = getent("missile_model" + var_0, "targetname");
  var_9 linkto(var_8);
  var_10 = getent(var_8.target, "targetname");
  var_2.rotationdummy rotatepitch(125, 0.5);
  var_2.rotationdummy moveto(var_2.rotationdummy.origin + (0, 0, -50), 0.5);
  common_scripts\utility::flag_wait(var_1);
  var_6 thread launch_lid_alarm();
  var_6 playsound(level.scr_sound["launch_tube_prepare"], "sounddone");
  playfx(level._effect["launchtube_steam"], var_6.origin);
  var_6 waittill("sounddone");
  var_11 = getent("badplace_lid_" + var_0, "targetname");
  badplace_brush("badplace_lid_volume" + var_0, 0, var_11, "allies", "axis");
  var_12 = 20;
  var_6.opening = 1;
  var_3 thread lid_kill(var_0, var_6);
  var_6 thread launch_lid_sound();
  var_8 thread missile_move();
  var_3.rotationdummy rotatepitch(-125, var_12, 2, 2);
  var_2.rotationdummy rotatepitch(-125, var_12 / 1.5, 1, 1);
  var_2.rotationdummy moveto(var_2.rotationdummy.origin + (0, 0, 50), var_12 / 2.5, 0, 2);
  wait(var_12 - 1);
  var_6.opening = 0;
  var_6 notify("stopped_opening");
  wait 2;
  var_3.rotationdummy delete();
  var_2.rotationdummy delete();
  var_7 delete();
}

lid_kill(var_0, var_1) {
  while (var_1.opening == 1) {
    wait 0.05;

    if(level.player istouching(self.trigger)) {
      level notify("new_quote_string");
      setdvar("ui_deadquote", & "LAUNCHFACILITY_A_DEADQUOTE_KILLED_BY_LID");
      level.player kill();
    }
  }
}

missile_move() {
  self moveto(self.origin + (0, 0, 175), 18, 4, 4);
}

launch_lid_sound() {
  self playsound(level.scr_sound["launch_tube_open_start"]);
  wait 1;
  thread common_scripts\utility::play_loop_sound_on_entity(level.scr_sound["launch_tube_open_loop"]);
  self waittill("stopped_opening");
  self notify("stop sound" + level.scr_sound["launch_tube_open_loop"]);
  self playsound(level.scr_sound["launch_tube_open_end"]);
}

launch_lid_alarm() {
  if(isdefined(level.lidloopplaying) && level.lidloopplaying == 1) {
    return;
  }
  level.lidloopplaying = 1;
  maps\_utility::play_sound_on_entity("emt_alarm_launch_doors");
  level.lidloopplaying = 0;
}

disable_color_trigs() {
  common_scripts\utility::array_thread(level.acolornodetriggers, common_scripts\utility::trigger_off);
}

dialogue_loudspeaker(var_0) {
  level.player maps\_utility::play_sound_on_entity(level.scr_sound[var_0]);
}

squad_bmp_destroy(var_0) {
  var_1 = var_0 + "_destroyed";
  level endon(var_1);
  var_2 = "player_near_" + var_0;

  while (common_scripts\utility::flag(var_2))
    wait 0.5;

  self notify("clear_c4");
  maps\_utility::radio_dialogue("launchfacility_a_marine_01_blowing_bmp");

  if(isdefined(self)) {
    if(!common_scripts\utility::flag(var_1)) {
      self endon("death");
      var_3 = self getentitynumber();
      thread vehicle_death(var_3);
    }
  }
}

player_kill_counter(var_0) {
  level notify("reset_kill_counter");
  level endon("reset_kill_counter");
  common_scripts\utility::flag_clear("player_reached_kill_max");
  level.axiskilledbyplayer = 0;

  while (level.axiskilledbyplayer < var_0)
    wait 2;

  common_scripts\utility::flag_set("player_reached_kill_max");
}

c4_callback_thread_launchfacility() {
  switch (self.script_noteworthy) {
    case "100":
      common_scripts\utility::flag_set("flanking_wall_breached");
      break;
  }
}

obj_gain_access() {
  common_scripts\utility::flag_wait("obj_gain_access_given");
  var_0 = 1;
  var_1 = getent("obj_gain_access", "targetname");
  objective_add(var_0, "active", & "LAUNCHFACILITY_A_OBJ_GAIN_ACCESS", var_1.origin);
  objective_current(var_0);
  common_scripts\utility::flag_wait("obj_gain_access_complete");
  objective_state(var_0, "done");
}

obj_enemy_armor() {
  common_scripts\utility::flag_wait("obj_enemy_armor_given");
  objective_add(10, "invisible", & "LAUNCHFACILITY_A_OBJ_ENEMY_ARMOR");
  objective_state(10, "active");
  objective_string(10, & "LAUNCHFACILITY_A_OBJ_ENEMY_ARMOR", level.enemyarmor.size);
  objective_current(10);
  common_scripts\utility::flag_wait("obj_enemy_armor_complete");
  objective_state(10, "done");
}

obj_enemy_armor_vehicle_think() {
  level.enemyarmorindex++;
  var_0 = level.enemyarmorindex;
  level.enemyarmor = common_scripts\utility::array_add(level.enemyarmor, self);
  objective_string(10, & "LAUNCHFACILITY_A_OBJ_ENEMY_ARMOR", level.enemyarmor.size);
  objective_additionalposition(10, var_0, self.origin);

  if(level.enemyarmorindex == 2) {
    wait 1;
    objective_string(10, & "LAUNCHFACILITY_A_OBJ_ENEMY_ARMOR", level.enemyarmor.size);
  }

  thread obj_enemy_armor_vehicle_death(var_0);
  thread obj_enemy_armor_vehicle_position(var_0);
}

obj_enemy_armor_vehicle_death(var_0) {
  self waittill("death");
  level.enemyarmor = common_scripts\utility::array_remove(level.enemyarmor, self);
  waittillframeend;
  objective_additionalposition(10, var_0, (0, 0, 0));

  if(level.enemyarmor.size == 0) {
    common_scripts\utility::flag_set("obj_enemy_armor_complete");
    objective_state(10, "invisible");
    common_scripts\utility::flag_clear("aa_tarmac_bmp02_section");
  }

  objective_string(10, & "LAUNCHFACILITY_A_OBJ_ENEMY_ARMOR", level.enemyarmor.size);
}

obj_enemy_armor_vehicle_position(var_0) {
  objective_additionalentity(10, var_0, self);
}

obj_north_tarmac() {
  common_scripts\utility::flag_wait("obj_north_tarmac_given");
  var_0 = 11;
  var_1 = getent("obj_north_tarmac", "targetname");
  objective_add(var_0, "active", & "LAUNCHFACILITY_A_OBJ_NORTH_TARMAC", var_1.origin);
  objective_current(var_0);
  common_scripts\utility::flag_wait("obj_north_tarmac_complete");
  objective_state(var_0, "done");
}

obj_rappel() {
  common_scripts\utility::flag_wait("obj_rappel_given");
  var_0 = 12;
  var_1 = getent("obj_rappel", "targetname");
  objective_add(var_0, "active", & "LAUNCHFACILITY_A_OBJ_RAPPEL", var_1.origin);
  objective_current(var_0);
  common_scripts\utility::flag_wait("obj_rappel_complete");
  objective_state(var_0, "done");
}

vehicle_bmp_setup(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++)
    thread vehicle_bmp_think(var_0[var_1]);
}

vehicle_truck_setup() {
  var_0 = getentarray("truck_troops", "targetname");

  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] thread vehicle_truck_think();
}

vehicle_truck_think() {
  self endon("death");
  truck_death_think();
}

truck_death_think() {
  self endon("death");
  var_0 = 0;

  for (;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(isdefined(var_2) && !isplayer(var_2)) {
      if(!common_scripts\utility::flag("enemy_can_blow_up_truck"))
        continue;
    }

    if(!isdefined(var_1)) {
      continue;
    }
    if(var_1 <= 0) {
      continue;
    }
    var_5 = getdamagetype(var_5);

    if(var_5 == "rocket") {
      if(var_1 >= 300) {
        break;
      }
    } else if(var_5 == "c4") {
      if(var_1 >= 250) {
        break;
      }
    } else
      continue;
  }

  thread common_scripts\utility::play_sound_in_space("exp_armor_vehicle", self.origin);
  earthquake(0.6, 2, self.origin, 2000);
  self notify("death");
}

vehicle_bmp_death_wait() {
  self waittill("death");
  target_remove(self);
}

vehicle_bmp_think(var_0) {
  maps\_utility::add_hint_string("armor_damage", & "SCRIPT_ARMOR_DAMAGE", undefined, 1);
  var_1 = maps\_vehicle::waittill_vehiclespawn(var_0);
  target_set(var_1, (0, 0, 0));
  target_setjavelinonly(var_1, 1);
  var_1 thread vehicle_bmp_death_wait();
  common_scripts\utility::flag_set(var_0 + "_spawned");

  if(isdefined(var_1.script_noteworthy) && var_1.script_noteworthy == "objective_tarmac_armor")
    var_1 thread obj_enemy_armor_vehicle_think();

  var_1 thread vehicle_turret_think();
  var_1 thread vehicle_death_think();
  var_1 thread maps\_vehicle_code::damage_hints();
  var_1 thread vehicle_patrol_think();
  var_1 thread vehicle_c4_think();
  var_1 thread vehicle_enemies_setup();

  if(var_0 == "bmp_02")
    var_1 thread friendlies_blow_bmp02();

  var_2 = getent("badplace_" + var_0, "targetname");

  if(isdefined(var_2))
    badplace_brush(var_0, 0, var_2, "allies");

  var_1 waittill("death");
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3.angles = var_1.angles;
  var_3.origin = var_1.origin;
  var_4 = var_0 + "_destroyed";
  common_scripts\utility::flag_set(var_4);

  if(isdefined(var_2))
    badplace_delete(var_0);
}

vehicle_damage_hints() {
  self endon("death");

  for (;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isplayer(var_1)) {
      continue;
    }
    switch (tolower(var_4)) {
      case "mod_grenade_splash":
      case "mod_grenade":
        thread maps\_utility::hint_fade();
        thread maps\_utility::hint(&"SCRIPT_ARMOR_DAMAGE", 5, undefined, 1);
        wait 10;
        break;
    }
  }
}

vehicle_death_think() {
  self endon("death");
  var_0 = self getentitynumber();
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  for (;;) {
    self waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isplayer(var_5)) {
      continue;
    }
    if(!isdefined(var_4)) {
      continue;
    }
    if(var_4 <= 0) {
      continue;
    }
    var_8 = getdamagetype(var_8);

    if(var_8 == "rocket") {
      if(var_4 >= 900) {
        var_3 = 1;
        break;
      }

      if(var_4 >= 300) {
        var_1++;

        if(var_1 == 1)
          thread vehicle_smoke();

        if(var_1 == 2) {
          var_2 = 1;
          break;
        }
      }
    }

    if(var_8 == "c4") {
      if(var_4 >= 250) {
        break;
      }
    }
  }

  if(var_2 || var_3)
    thread bmp_death_dialogue();

  thread vehicle_death(var_0);
}

bmp_death_dialogue() {
  wait 1;
  level.dialoguerpggoodshot_number++;

  if(level.dialoguerpggoodshot_number > level.dialoguerpggoodshot_max)
    level.dialoguerpggoodshot_number = 1;

  var_0 = "launchfacility_a_rpg_kill_0" + level.dialoguerpggoodshot_number;

  if(!level.peoplespeaking) {
    level.peoplespeaking = 1;
    level maps\_utility::radio_dialogue(var_0);
    level.peoplespeaking = 0;
  }
}

vehicle_smoke() {
  wait 1;
  level.dialoguerpghit_number++;

  if(level.dialoguerpghit_number > level.dialoguerpghit_max)
    level.dialoguerpghit_number = 1;

  var_0 = "launchfacility_a_rpg_hit_0" + level.dialoguerpghit_number;

  if(!level.peoplespeaking) {
    level.peoplespeaking = 1;
    level maps\_utility::radio_dialogue(var_0);
    level.peoplespeaking = 0;
  }

  var_1 = spawn("script_origin", (0, 0, 0));
  var_1.origin = self gettagorigin("tag_origin");
  var_1 linkto(self);

  while (isalive(self)) {
    playfx(common_scripts\utility::getfx("smoke_trail_bmp"), var_1.origin);
    playfx(common_scripts\utility::getfx("smoke_trail_bmp"), var_1.origin + (50, 50, -50));
    wait 0.1;
  }

  self waittill("death");
  var_1 delete();
}

getdamagetype(var_0) {
  if(!isdefined(var_0))
    return "unknown";

  var_0 = tolower(var_0);

  switch (var_0) {
    case "mod_explosive_splash":
    case "mod_explosive":
      return "c4";
    case "mod_projectile_splash":
    case "mod_projectile":
      return "rocket";
    case "mod_grenade_splash":
    case "mod_grenade":
      return "grenade";
    case "unknown":
      return "unknown";
    default:
      return "unknown";
  }
}

vehicle_get_target(var_0) {
  var_1 = maps\_helicopter_globals::getenemytarget(level.bmpcannonrange, level.cosine["180"], 1, 1, 0, 1, var_0);
  return var_1;
}

vehicle_get_target_player_only() {
  var_0 = level.squad;
  var_1 = maps\_helicopter_globals::getenemytarget(level.bmpcannonrange, level.cosine["180"], 0, 1, 0, 0, var_0);
  return var_1;
}

vehicle_debug() {
  self endon("death");

  for (;;) {
    wait 0.5;
    thread maps\jake_tools::debug_circle(self.origin, level.bmpmgrange, 0.5, level.color["red"], undefined, 1);
    thread maps\jake_tools::debug_circle(self.origin, level.bmpcannonrange, 0.5, level.color["blue"], undefined, 1);
  }
}

vehicle_turret_think() {
  self endon("death");
  self endon("c4_detonation");
  thread maps\_vehicle::mgoff();
  self.turretfiring = 0;
  var_0 = undefined;
  var_1 = undefined;

  if(getdvar("debug_bmp") == "1")
    thread vehicle_debug();

  for (;;) {
    wait 0.05;

    if(!isdefined(var_0))
      var_0 = vehicle_get_target_player_only();
    else if(isdefined(var_0) && !isplayer(var_0))
      var_0 = vehicle_get_target_player_only();

    if(isdefined(var_0) && isplayer(var_0)) {
      var_2 = 0;
      var_2 = sighttracepassed(self.origin, level.player.origin + (0, 0, 150), 0, self);

      if(!var_2)
        var_0 = vehicle_get_target(level.bmpexcluders);
    } else
      var_0 = vehicle_get_target(level.bmpexcluders);

    if(isdefined(var_0) && isalive(var_0)) {
      var_3 = var_0.origin + (0, 0, 32);
      self setturrettargetvec(var_3);

      if(getdvar("debug_bmp") == "1")
        thread maps\_utility::draw_line_until_notify(self.origin + (0, 0, 32), var_3, 1, 0, 0, self, "stop_drawing_line");

      var_4 = randomfloatrange(2, 3);
      common_scripts\utility::waittill_notify_or_timeout("turret_rotate_stopped", var_4);

      if(isdefined(var_0) && isalive(var_0)) {
        if(distancesquared(var_0.origin, self.origin) <= level.bmpmgrangesquared) {
          if(!self.mgturret[0] isfiringturret())
            thread maps\_vehicle::mgon();

          wait 0.5;

          if(!self.mgturret[0] isfiringturret()) {
            thread maps\_vehicle::mgoff();

            if(!self.turretfiring)
              thread vehicle_fire_main_cannon();
          }
        } else {
          thread maps\_vehicle::mgoff();

          if(!self.turretfiring)
            thread vehicle_fire_main_cannon();
        }
      }
    }

    if(getdvar("debug_bmp") == "1")
      self notify("stop_drawing_line");
  }
}

vehicle_fire_main_cannon() {
  self endon("death");
  self endon("c4_detonation");
  var_0 = weaponfiretime("bmp_turret");
  var_1 = randomintrange(3, 8);
  self.turretfiring = 1;
  var_2 = 0;

  while (var_2 < var_1) {
    var_2++;
    wait(var_0);
    self fireweapon();
  }

  self.turretfiring = 0;
}

vehicle_c4_think() {
  var_0 = self getentitynumber();
  var_1 = (0, -33, 10);
  var_2 = (0, 90, -90);
  var_3 = (129, 0, 35);
  var_4 = (0, 90, 144);
  maps\_c4::c4_location("rear_hatch_open_jnt_left", var_1, var_2);
  maps\_c4::c4_location("tag_origin", var_3, var_4);
  self.rearc4location = spawn("script_origin", self.origin);
  self.frontc4location = spawn("script_origin", self.origin);
  self.rearc4location linkto(self, "rear_hatch_open_jnt_left", var_1, var_2);
  self.frontc4location linkto(self, "tag_origin", var_3, var_4);

  if(getdvar("debug_launch") == "1") {
    self.frontc4location thread maps\jake_tools::print3dthread("Front");
    self.rearc4location thread maps\jake_tools::print3dthread("Back");
  }

  self waittill("c4_detonation");
  self.frontc4location delete();
  self.rearc4location delete();
  var_5 = maps\jake_tools::get_ai_within_radius(512, self.origin, "axis");

  if(isdefined(var_5) && var_5.size > 0)
    common_scripts\utility::array_thread(var_5, maps\jake_tools::ai_stun, 0.75);

  thread vehicle_death(var_0);
}

vehicle_death(var_0) {
  self notify("clear_c4");
  maps\_utility::arcademode_kill(self.origin, "explosive", 150);
  setplayerignoreradiusdamage(1);

  if(distancesquared(self.origin, level.player.origin) <= level.bmpmgrangesquared)
    level.player playrumbleonentity("generic_attack_heavy_750");

  earthquake(0.6, 2, self.origin, 2000);
  self notify("death");
  thread common_scripts\utility::play_sound_in_space("h1_exp_armor_vehicle", self gettagorigin("tag_turret"));
  var_1 = maps\jake_tools::get_ai_within_radius(1024, self.origin, "axis");

  if(isdefined(var_1) && var_1.size > 0)
    common_scripts\utility::array_thread(var_1, maps\jake_tools::ai_stun, 0.85);

  radiusdamage(self.origin, 256, level.maxbmpexplosiondmg, level.minbmpexplosiondmg);
  thread player_token_vehicle_damage(self.origin);
  thread maps\_utility::autosave_by_name("bmp_" + var_0 + "_destroyed");
  wait 2;
  setplayerignoreradiusdamage(0);
}

player_token_vehicle_damage(var_0) {
  if(distancesquared(var_0, level.player.origin) <= level.playervehicledamagerangesquared)
    level.player dodamage(level.player.health / 3, (0, 0, 0));
}

vehicle_enemies_setup() {
  if(!isdefined(self.script_linkto)) {
    return;
  }
  var_0 = getent(self.script_linkto, "script_linkname");
  var_0 notify("trigger", level.player);
  var_1 = getentarray(var_0.script_linkto, "script_linkname");
  common_scripts\utility::array_thread(var_1, ::vehicle_ai_killspawner_triggers_think, self);
  var_2 = getentarray("triggers_" + self.vehicle_spawner.targetname, "script_noteworthy");
  common_scripts\utility::array_thread(var_2, ::vehicle_ai_movement_triggers_think, self);
}

vehicle_ai_killspawner_triggers_think(var_0) {
  var_0 waittill("death");
  self notify("trigger", level.player);
}

vehicle_ai_movement_triggers_think(var_0) {
  var_0 endon("death");
  var_1 = getent(self.target, "targetname");

  for (;;) {
    self waittill("trigger", var_2);

    if(var_2 != var_0) {
      continue;
    }
    var_0 notify("changing_volume", var_1);
    var_0.enemyvolume = var_1;
    var_0 waittill("changing_volume");
    wait 5;
  }
}

ai_vehicle_support() {
  self endon("death");
  var_0 = getent(self.script_linkto, "script_linkname");
  var_1 = getsubstr(var_0.script_noteworthy, 7);
  var_2 = maps\_vehicle::get_vehicle_from_targetname(var_1);
  thread ai_vehicle_support_vehicle_dead(var_2);
  wait 0.05;

  if(isdefined(var_2.enemyvolume))
    maps\jake_tools::set_goalvolume(undefined, var_2.enemyvolume);

  for (;;) {
    var_2 waittill("changing_volume", var_3);
    maps\jake_tools::set_goalvolume(undefined, var_3);
    wait 0.05;
  }
}

ai_vehicle_support_vehicle_dead(var_0) {
  self endon("death");
  var_0 waittill("death");
  self.health = 1;
  thread ai_player_seek();
}

ai_enemy_rpd() {
  self endon("death");
}

vehicle_patrol_init() {
  level.avehiclenodes = [];
  var_0 = getvehiclenodearray("go_right", "script_noteworthy");
  var_1 = getvehiclenodearray("go_left", "script_noteworthy");
  level.avehiclenodes = maps\_utility::array_merge(var_0, var_1);
}

vehicle_patrol_think() {
  self endon("death");
  var_0 = self.attachedpath;
  self waittill("reached_end_node");

  switch (self.vehicle_spawner.targetname) {
    case "bmp_02":
      self.balconypositionorg = getent("bmp_02_balcony_org", "targetname");
      break;
    case "bmp_03":
      self.balconypositionorg = getent("bmp_03_balcony_org", "targetname");
      break;
    case "bmp_04":
      self.balconypositionorg = getent("bmp_04_balcony_org", "targetname");
      break;
    default:
  }

  self vehicle_turnengineoff();
  var_1 = 0;

  for (;;) {
    wait 0.05;
    var_2 = [];
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = [];
    var_8 = undefined;
    var_3 = var_0 maps\_utility::get_last_ent_in_chain("vehiclenode");
    var_2 = level.avehiclenodes;
    var_2 = common_scripts\utility::array_remove(var_2, var_3);
    var_9 = level.avehiclenodes;
    var_10 = var_3.script_vehiclenodegroup;

    for (var_11 = 0; var_11 < var_9.size; var_11++) {
      if(var_9[var_11].script_vehiclenodegroup != var_10)
        var_2 = common_scripts\utility::array_remove(var_2, var_9[var_11]);
    }

    for (var_11 = 0; var_11 < var_2.size; var_11++) {
      if(isdefined(var_2[var_11].script_noteworthy) && var_2[var_11].script_noteworthy == "go_left") {
        var_4 = var_2[var_11];
        var_4.end = undefined;
        continue;
      }

      if(isdefined(var_2[var_11].script_noteworthy) && var_2[var_11].script_noteworthy == "go_right") {
        var_5 = var_2[var_11];
        var_5.end = undefined;
      }
    }

    var_7[0] = var_3;

    if(isdefined(var_4)) {
      var_4.end = var_4 maps\_utility::get_last_ent_in_chain("vehiclenode");
      var_7 = common_scripts\utility::array_add(var_7, var_4.end);
    }

    if(isdefined(var_5)) {
      var_5.end = var_5 maps\_utility::get_last_ent_in_chain("vehiclenode");
      var_7 = common_scripts\utility::array_add(var_7, var_5.end);
    }

    var_12 = undefined;

    if(level.player istouching(level.balconyflag))
      var_12 = self.balconypositionorg.origin;
    else
      var_12 = level.player.origin;

    var_8 = common_scripts\utility::getclosest(var_12, var_7);

    if(var_8 == var_3)
      var_6 = undefined;
    else if(isdefined(var_4) && var_8 == var_4.end)
      var_6 = var_4;
    else if(isdefined(var_5) && var_8 == var_5.end)
      var_6 = var_5;

    if(!isdefined(var_6)) {
      if(distancesquared(self.rearc4location.origin, level.player.origin) <= level.playermaxdistancetobmpc4squared) {
        var_13 = bullettracepassed(level.player.origin, self gettagorigin("tag_turret"), 0, self);

        if(var_13) {
          if(isdefined(var_4))
            var_6 = var_4;
        }
      } else if(distancesquared(self.frontc4location.origin, level.player.origin) <= level.playermaxdistancetobmpc4squared) {
        var_13 = bullettracepassed(level.player.origin, self gettagorigin("tag_turret"), 0, self);

        if(var_13) {
          if(isdefined(var_5))
            var_6 = var_5;
        }
      }
    }

    if(isdefined(var_6)) {
      self attachpath(var_6);

      if(isdefined(var_6.script_wheeldirection))
        maps\_vehicle_code::wheeldirectionchange(var_6.script_wheeldirection);

      var_0 = var_6;

      if(!var_1) {
        thread maps\launchfacility_a_aud::bmp_start_moving();
        var_1 = 1;
      }

      self vehicle_setspeed(5, 2, 2);
      self waittill("reached_end_node");
      continue;
    }

    if(var_1) {
      thread maps\launchfacility_a_aud::bmp_stop_moving();
      var_1 = 0;
    }

    wait 3;
  }
}

ai_think(var_0) {
  if(var_0.team == "axis")
    var_0 thread ai_axis_think();

  if(var_0.team == "allies")
    var_0 thread ai_allies_think();
}

ai_allies_think() {
  self endon("death");
  self.animname = "frnd";
  thread ai_friendly_waittill_death();

  if(!isdefined(self.magic_bullet_shield))
    thread maps\_utility::magic_bullet_shield();

  maps\_utility::setflashbangimmunity(1);

  if(isdefined(self.script_forcecolor)) {
    switch (self.script_forcecolor) {
      case "r":
        level.team01 = common_scripts\utility::array_add(level.team01, self);

        if(getdvar("debug_launch") == "1")
          thread maps\jake_tools::print3dthread("Team 01");

        break;
      case "o":
        level.team01 = common_scripts\utility::array_add(level.team01, self);

        if(getdvar("debug_launch") == "1")
          thread maps\jake_tools::print3dthread("Wingman");

        break;
      case "y":
        level.team02 = common_scripts\utility::array_add(level.team02, self);

        if(getdvar("debug_launch") == "1")
          thread maps\jake_tools::print3dthread("Team 02");

        break;
      case "g":
        level.team03 = common_scripts\utility::array_add(level.team03, self);

        if(getdvar("debug_launch") == "1")
          thread maps\jake_tools::print3dthread("Team 03");

        break;
    }
  }

  for (;;) {
    self waittill("damage", var_0, var_1);
    level.bmpexcluders = common_scripts\utility::array_add(level.bmpexcluders, self);
    self.ignoreme = 1;
    wait 1;
    self.a.disablepain = 1;
    wait(randomfloatrange(3, 5));
    self.ignoreme = 0;
    level.bmpexcluders = common_scripts\utility::array_remove(level.bmpexcluders, self);
    self.a.disablepain = 0;
  }
}

ai_friendly_waittill_death() {
  self waittill("death");

  if(maps\_utility::is_in_array(level.bmpexcluders, self))
    common_scripts\utility::array_remove(level.bmpexcluders, self);
}

ai_axis_think() {
  self endon("death");
  self.animname = "hostile";
  thread ai_axis_death();
  thread ai_axis_player_distance();
  thread ai_axis_sniper_fodder();
}

ai_axis_player_distance() {
  self endon("death");

  for (;;) {
    wait 0.25;

    if(level.snipersactive) {
      continue;
    }
    if(distancesquared(self.origin, level.player.origin) <= level.playerdistancetoaisquared)
      self notify("close_to_player");
  }
}

ai_axis_sniper_fodder() {
  self endon("death");

  for (;;) {
    self waittill("close_to_player");

    if(level.peoplespeaking) {
      continue;
    }
    if(level.snipersactive) {
      continue;
    }
    var_0 = level.player geteye();
    var_1 = self gettagorigin("TAG_EYE");
    var_2 = common_scripts\utility::within_fov(var_0, level.player getplayerangles(), var_1, level.cosine["35"]);

    if(!var_2) {
      continue;
    }
    var_3 = sighttracepassed(var_0, var_1, 0, undefined);

    if(!var_3) {
      continue;
    }
    var_1 = self gettagorigin("TAG_EYE");

    if(getdvar("debug_launch") == "1")
      thread maps\jake_tools::print3dthread("target");

    for (var_4 = 0; var_4 < level.asniper_orgs.size; var_4++) {
      var_5 = sighttracepassed(level.asniper_orgs[var_4].origin, var_1, 1, self);

      if(var_5) {
        thread sniper_execute(var_1, level.asniper_orgs[var_4]);
        break;
      }
    }
  }
}

sniper_execute(var_0, var_1) {
  if(!isdefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  if(level.snipersactive) {
    return;
  }
  level.snipersactive = 1;
  level.snipertarget = self;
  level notify("sniper_target_updated");
  level.sniperkills++;

  if(getdvar("debug_launch") == "1") {
    level notify("stop_drawing_line");
    thread maps\_utility::draw_line_until_notify(var_1.origin, var_0, 1, 0, 0, level, "stop_drawing_line");
  }

  var_2 = randomintrange(1, 3);
  var_3 = 0;

  while (var_3 < var_2) {
    var_3++;

    if(var_3 == 1)
      playfxontag(common_scripts\utility::getfx("headshot"), self, "tag_eye");

    magicbullet("m14_scoped", var_1.origin, var_0);
    bullettracer(var_1.origin, var_0, 1);
    thread common_scripts\utility::play_sound_in_space("weap_m82sniper_fire_launcha", level.player.origin);

    if(var_3 != var_2)
      wait(randomfloatrange(0.25, 0.75));
  }

  wait(randomfloatrange(0.75, 1.5));

  if(level.sniperconfirmdialogue) {
    level.dialoguesniperconfirm_number++;

    if(level.dialoguesniperconfirm_number > level.dialoguesniperconfirm_max)
      level.dialoguesniperconfirm_number = 1;

    var_4 = "launchfacility_a_sniper_confirm_0" + level.dialoguesniperconfirm_number;

    if(!level.peoplespeaking)
      level maps\_utility::radio_dialogue_queue(var_4);
  }

  wait(level.sniperinterval);
  level.snipersactive = 0;
}

ai_axis_death() {
  self waittill("death", var_0);

  if(!isdefined(var_0)) {
    return;
  }
  if(isplayer(var_0)) {
    level.axiskilledbyplayer++;

    if(getdvar("debug_launch") == "1")
      return;
  }
}

ai_in_volume_chase_player() {
  var_0 = getaiarray("axis");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] istouching(self)) {
      var_0[var_1].goalradius = 600;
      var_0[var_1] setgoalentity(level.player);
    }
  }
}

ai_chain_and_seek() {
  self endon("death");
  self waittill("reached_path_end");
  thread ai_player_seek();
}

ai_player_seek() {
  self endon("death");
  var_0 = distance(self.origin, level.player.origin);

  for (;;) {
    wait 2;
    self.goalradius = var_0;
    self setgoalentity(level.player);
    var_0 = var_0 - 175;

    if(var_0 < 512) {
      var_0 = 512;
      return;
    }
  }
}

initplayer() {
  level.player maps\jake_tools::set_threatbiasgroup("player");
  var_0 = getentarray("trigger_player_location", "targetname");
}

initfriendlies(var_0) {
  waittillframeend;
  level.squad = [];
  level.price = maps\_utility::spawn_script_noteworthy("price");
  level.grigsby = maps\_utility::spawn_script_noteworthy("grigsby");
  level.squad[0] = level.price;
  level.squad[1] = level.grigsby;
  level.othersquadfriendly = undefined;
  level.excludedai = [];
  level.excludedai[0] = level.price;
  level.excludedai[1] = level.grigsby;

  switch (var_0) {
    case "default":
      level.friendly_at4 = maps\_utility::spawn_script_noteworthy("friendly_at4");
      var_1 = maps\_utility::array_spawn(getentarray("friendly_support", "script_noteworthy"));
      level.squad = maps\_utility::array_merge(level.squad, var_1);
      break;
    case "container":
      level.friendly_at4 = maps\_utility::spawn_script_noteworthy("friendly_at4");
      var_1 = maps\_utility::array_spawn(getentarray("friendly_support", "script_noteworthy"));
      level.squad = maps\_utility::array_merge(level.squad, var_1);
      break;
    case "gate":
      var_1 = maps\_utility::array_spawn(getentarray("friendly_support", "script_noteworthy"));
      level.squad = maps\_utility::array_merge(level.squad, var_1);
      break;
    case "tarmac":
      break;
    case "vents":
      var_1 = maps\_utility::array_spawn(getentarray("friendly_support", "script_noteworthy"));
      level.squad = maps\_utility::array_merge(level.squad, var_1);
      break;
    default:
  }

  common_scripts\utility::array_thread(level.team01, ::attach_saw, "startTeam");
  var_2 = level.squad;
  var_3 = getnodearray("nodeStart_" + var_0, "targetname");
  var_4 = 0;
  var_5 = undefined;

  while (var_4 < 3) {
    wait 0.05;

    for (var_6 = 0; var_6 < var_3.size; var_6++) {
      if(isdefined(var_3[var_6].script_noteworthy)) {
        switch (var_3[var_6].script_noteworthy) {
          case "nodePrice":
            level.price maps\jake_tools::start_teleport(var_3[var_6]);
            var_2 = common_scripts\utility::array_remove(var_2, level.price);
            var_3 = common_scripts\utility::array_remove(var_3, var_3[var_6]);
            var_4++;
            break;
          case "nodeGrigsby":
            level.grigsby maps\jake_tools::start_teleport(var_3[var_6]);
            var_2 = common_scripts\utility::array_remove(var_2, level.grigsby);
            var_3 = common_scripts\utility::array_remove(var_3, var_3[var_6]);
            var_4++;
            break;
          case "nodePlayer":
            var_5 = var_3[var_6];
            var_3 = common_scripts\utility::array_remove(var_3, var_3[var_6]);
            var_4++;
            break;
        }
      }
    }
  }

  if(var_2.size > 0) {
    for (var_6 = 0; var_6 < var_2.size; var_6++)
      var_2[var_6] maps\jake_tools::start_teleport(var_3[var_6]);
  }

  level.player setorigin(var_5.origin);
  level.player setplayerangles(var_5.angles);
  level.excludedai[0] = level.price;
  level.excludedai[1] = level.grigsby;
}

attach_saw(var_0) {
  if(!isdefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  if(self == level.price || self == level.grigsby || var_0 == "chopperTeam") {
    if(self gettagindex("TAG_STOWED_BACK") >= 0) {
      var_1 = spawn("script_model", self.origin);
      var_1 setmodel("weapon_saw_rescue");
      var_1 linkto(self, "TAG_STOWED_BACK", (0, 3, 0), (180, 191, 0));
      self waittill("delete_saw");
      var_1 unlink();
      var_1 delete();
    }
  }
}

initprecache() {
  precachestring(&"LAUNCHFACILITY_A_OBJ_GAIN_ACCESS");
  precachestring(&"LAUNCHFACILITY_A_OBJ_RIGHT_GATE");
  precachestring(&"LAUNCHFACILITY_A_OBJ_ENEMY_ARMOR");
  precachestring(&"LAUNCHFACILITY_A_OBJ_NORTH_TARMAC");
  precachestring(&"LAUNCHFACILITY_A_OBJ_RAPPEL");
  precacheitem("m14_scoped");
  precacheitem("rpg_player");
  precacheitem("hind_turret");
  precacheitem("hind_FFAR");
  precacheitem("hind_FFAR_nodamage");
  precachemodel("weapon_c4");
  precachemodel("weapon_c4_obj");
  precachemodel("rope_coil_obj");
  precachemodel("rope_coil");
  precachemodel("worldbody_h1_sas_woodland");
  precachemodel("weapon_rpd_MG_Setup");
  precachemodel("weapon_stinger");
  precachemodel("weapon_saw_rescue");
  precacheshader("h1_hud_tutorial_blur");
  precacheshader("h1_hud_tutorial_border");
  precachestring(&"SCRIPT_ARMOR_DAMAGE");
  precachestring(&"LAUNCHFACILITY_A_DEBUG_LEVEL_END");
  precachestring(&"SCRIPT_PLATFORM_LAUNCHFACILITY_A_HINT_SMOKE");
  precachestring(&"SCRIPT_PLATFORM_LAUNCHFACILITY_A_HINT_PLANT_C4_GLOW");
  precachestring(&"LAUNCHFACILITY_A_HINTSTR_C4_PLANT");
  precachestring(&"LAUNCHFACILITY_A_HINTSTR_C4_DETONATE");
  precachestring(&"SCRIPT_PLATFORM_HINTSTR_RAPPEL");
  precachestring(&"LAUNCHFACILITY_A_HINTSTR_RAPPEL_DOWN_SHAFT");
  precachestring(&"LAUNCHFACILITY_A_HINTSTR_EXPLOSIVES_PLANTED");
  precacherumble("generic_attack_light_500");
  precacherumble("generic_attack_light_1000");
  precacherumble("generic_attack_light_1500");
  precacherumble("generic_attack_light_2000");
  precacherumble("generic_attack_heavy_750");
}

vehicle_path_disconnector() {
  var_0 = getent(self.target, "targetname");
  var_0 notsolid();
  var_0.origin = var_0.origin - (0, 0, 1024);

  for (;;) {
    self waittill("trigger", var_1);

    if(!isdefined(var_0.pathsdisconnected)) {
      var_0 solid();
      var_0 disconnectpaths();
      var_0 notsolid();
      var_0.pathsdisconnected = 1;
    }

    thread vehicle_reconnects_paths(var_0);
  }
}

vehicle_reconnects_paths(var_0) {
  var_0 notify("waiting_for_path_reconnection");
  var_0 endon("waiting_for_path_reconnection");
  wait 0.5;
  var_0 solid();
  var_0 connectpaths();
  var_0 notsolid();
  var_0.pathsdisconnected = undefined;
}

vent_flashlights() {
  var_0 = getentarray("vent_flashlight_FX_origin", "targetname");

  if(!maps\_utility::is_start_or_after_start("vents"))
    common_scripts\utility::flag_wait("obj_enemy_armor_complete");

  foreach(var_2 in var_0)
  playfx(level._effect["vent_flashlight"], var_2.origin);
}