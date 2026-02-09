/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq.gsc
*****************************************************/

main() {
  maps\_utility::template_level("enemyhq");
  maps\createart\enemyhq_art::main();
  maps\enemyhq_fx::main();
  maps\enemyhq_precache::main();
  maps\enemyhq_anim::main();
  setDvar("debug_bcprint", "on");
  enemyhq_pre_load();
  enemyhq_starts();
  maps\_utility::set_console_status();
  maps\_utility::setsaveddvar_cg_ng("r_specularcolorscale", 2.25, 6.0);
  maps\_utility::setsaveddvar_cg_ng("r_diffusecolorscale", 1.3, 1);
  setsaveddvar("r_ssaofadedepth", 256);
  setsaveddvar("r_ssaorejectdepth", 1024);
  maps\_load::main();
  maps\enemyhq_audio::main();
  maps\_patrol_anims::main();
  maps\_patrol_anims_gundown::main();
  thread maps\_teargas::initteargas();
  thread lights();
  maps\_c4::main();
  maps\_drone_ai::init();
  maps\_dog_control::init_dog_control();
  maps\enemyhq_remoteturret::remote_turret_init("player_view_controller");
  maps\_global_fx_code::global_fx("ehq_flare_ambient_FX_origin", "vfx/ambient/props/vfx_handflare_ehq", undefined, "vfx_handflare_ehq");
  maps\enemyhq_code::init_color_trigger_listeners("atrium_color_triggers");
  setsaveddvar("fx_alphathreshold", 9);
  setsaveddvar("r_hudoutlineenable", 1);

  if(maps\_utility::is_gen4())
    setsaveddvar("fx_alphathreshold", 2);
  else
    setsaveddvar("fx_alphathreshold", 9);

  var_0 = getEntArray("start_dog_sniffing", "targetname");
  common_scripts\utility::array_thread(var_0, maps\enemyhq_code::handle_dog_modes);
  var_0 = getEntArray("stop_dog_sniffing", "targetname");
  common_scripts\utility::array_thread(var_0, maps\enemyhq_code::handle_dog_modes);
  var_0 = getEntArray("start_dog_sneak", "targetname");
  common_scripts\utility::array_thread(var_0, maps\enemyhq_code::handle_dog_modes);
  var_0 = getEntArray("stop_dog_sneak", "targetname");
  common_scripts\utility::array_thread(var_0, maps\enemyhq_code::handle_dog_modes);
  maps\_utility::array_spawn_function_noteworthy("delete_at_path_end", maps\enemyhq_code::delete_ai_at_path_end);
  level.disable_teargas_ally_badplaces = 1;
  setsaveddvar("cg_cinematicFullScreen", "0");
  common_scripts\utility::exploder(8011);
  common_scripts\utility::exploder(8010);
  common_scripts\utility::exploder(9080);
  common_scripts\utility::exploder(9090);
  common_scripts\utility::exploder(5150);
}

enemyhq_starts() {
  maps\_utility::add_start("intro", maps\enemyhq_rooftop_intro::setup_rooftop_intro, "Intro", maps\enemyhq_rooftop_intro::begin_rooftop_intro);
  maps\_utility::add_start("introroof", maps\enemyhq_rooftop_intro::setup_rooftop_shoot, "Intro shoot", maps\enemyhq_rooftop_intro::begin_rooftop_shoot);
  maps\_utility::add_start("drive_in", maps\enemyhq_intro::setup_drive_in, "Drive in", maps\enemyhq_intro::begin_drive_in);
  maps\_utility::add_start("atrium", maps\enemyhq_atrium::setup_atrium, "Atrium Combat", maps\enemyhq_atrium::begin_atrium);
  maps\_utility::add_start("vip", maps\enemyhq_vip::setup_vip, "VIP Suite", maps\enemyhq_vip::begin_vip);
  maps\_utility::add_start("traverse", maps\enemyhq_traverse::setup_traverse, "Traverse", maps\enemyhq_traverse::begin_traverse);
  maps\_utility::add_start("basement_teargas", maps\enemyhq_basement::setup_teargas, "Basement Teargas", maps\enemyhq_basement::begin_teargas);
  maps\_utility::add_start("basement_combat", maps\enemyhq_basement::setup_combat, "Basement Combat", maps\enemyhq_basement::begin_combat);
  maps\_utility::add_start("clubhouse_breach", maps\enemyhq_basement::setup_clubhouse, "Clubhouse Breach", maps\enemyhq_basement::begin_clubhouse);
  maps\_utility::add_start("hvt_rescue", maps\enemyhq_basement::setup_hvt, "HVT Rescue", maps\enemyhq_basement::begin_hvt);
  maps\_utility::add_start("new_finale", maps\enemyhq_finale::setup_new_finale, "New Finale", maps\enemyhq_finale::begin_new_finale);
}

enemyhq_pre_load() {
  maps\enemyhq_rooftop_intro::enemyhq_rooftop_intro_pre_load();
  maps\enemyhq_intro::enemyhq_intro_pre_load();
  maps\enemyhq_atrium::enemyhq_atrium_pre_load();
  maps\enemyhq_vip::enemyhq_vip_pre_load();
  maps\enemyhq_traverse::enemyhq_traverse_pre_load();
  maps\enemyhq_basement::enemyhq_basement_pre_load();
  maps\enemyhq_finale::enemyhq_finale_pre_load();
  common_scripts\utility::flag_init("FLAG_link_veh_crash_paths");
  common_scripts\utility::flag_init("FLAG_player_enter_truck");
  precacheitem("m9a1");
  precacheitem("l115a3");
  precachemodel("viewmodel_reddot_reflex_iw6");
  precacheitem("teargas_grenade");
  precacheitem("remote_sniper");
  precacheitem("nosound_magicbullet");
  precachemodel("pbk_flood_light_generator");
  precachemodel("viewhands_us_rangers");
  precachemodel("weapon_m4m203_acog");
  precachemodel("generic_prop_raven");
  precachemodel("weapon_us_smoke_grenade_burnt2");
  precachemodel("hesh_stealth_head_mask");
  precachemodel("head_hesh_stealth_z");
  precachemodel("vehicle_man_7t_front_door_RI_obj");
  precachemodel("vehicle_iveco_lynx_destroyed_iw6");
  precachemodel("prop_sas_gasmask");
  precachemodel("prop_sas_gasmask_attach");
  precacheshader("gasmask_overlay_delta2");
  precacheshader("hud_dog_melee");
  precacheitem("scuba_mask_on");
  precacheitem("scuba_mask_off");
  precachemodel("soccer_ball");
  precachemodel("weapon_mk14_iw6");
  precachemodel("weapon_mp443");
  precachemodel("viewmodel_mp443");
  precacheitem("test_detonator_black_ice");
  precachemodel("viewhands_player_us_rangers");
  precacherumble("light_1s");
  precacherumble("light_2s");
  precacherumble("light_3s");
  maps\_vehicle::build_deathfx_override("script_vehicle_man_7t_k9_physics", undefined, "vehicle_man_7t_k9_iw6", "vfx/moments/enemyhq/vfx_ehq_truckexp", undefined, undefined);
  maps\_vehicle::build_deathfx_override("script_vehicle_iveco_lynx_physics", undefined, "vehicle_iveco_lynx_iw6", "vfx/moments/enemyhq/vfx_ehq_truckexp", undefined, undefined);
  maps\_vehicle::build_deathfx_override("script_vehicle_man_7t_k9", undefined, "vehicle_man_7t_k9_iw6", "vfx/moments/enemyhq/vfx_ehq_truckexp", undefined, undefined);
  maps\_vehicle::build_deathfx_override("script_vehicle_iveco_lynx", undefined, "vehicle_iveco_lynx_iw6", "vfx/moments/enemyhq/vfx_ehq_truckexp", undefined, undefined);
  maps\_vehicle::build_light_override("script_vehicle_man_7t_k9", "headlight_truck_left", "tag_headlight_left", "vfx/ambient/lights/vfx_headlight_truck_ehq", "headlightsL");
  maps\_vehicle::build_light_override("script_vehicle_man_7t_k9", "headlight_truck_right", "tag_headlight_right", "vfx/ambient/lights/vfx_headlight_truck_ehq", "headlightsR");
  maps\_utility::add_hint_string("tear_hint", &"ENEMY_HQ_FRAG_TO_THROW_TEARGAS", maps\enemyhq_basement::teargas_hint_wait);
  maps\_utility::add_hint_string("zoom_hint", &"ENEMY_HQ_ZOOMHINT", maps\enemyhq_rooftop_intro::zoom_hint_wait);
  maps\_utility::add_hint_string("zoom_noglyph_hint", &"ENEMY_HQ_ZOOMHINT_NO_GLYPH", maps\enemyhq_rooftop_intro::zoom_hint_wait);
  maps\_utility::add_hint_string("sniperuse_hint", &"ENEMY_HQ_ACTIONSLOT_1_TO_USE_REMOTE", maps\enemyhq_code::sniperuse_hint_wait);
  maps\_utility::add_hint_string("riley_hint", &"ENEMY_HQ_PRESS_LB_TO_COMMAND", maps\enemyhq_code::dog_hint_check);
  maps\_utility::add_hint_string("blow_charges", &"ENEMY_HQ_BLOWCHARGES", maps\enemyhq_code::hint_blow_charges_wait);
  maps\_utility_dogs::init_dog_pc("a");
}

setup_common(var_0) {
  setup_player(var_0);
  spawn_allies(var_0);
  var_1 = getent("finale_dead_truck_clip", "targetname");

  if(isDefined(var_1))
    var_1 notsolid();

  var_1 = getent("finale_dead_truck", "targetname");

  if(isDefined(var_1))
    var_1 hide();
}

setup_player(var_0) {
  if(isDefined(var_0))
    var_1 = var_0 + "_start";
  else
    var_1 = level.start_point + "_start";

  var_2 = common_scripts\utility::getstruct(var_1, "targetname");

  if(isDefined(var_2)) {
    level.player setorigin(var_2.origin);
    level.player setplayerangles(var_2.angles);
  } else
    iprintlnbold("can't find startpoint for " + level.start_point);

  if(level.start_point == "atrium") {
    level.player giveweapon("mk32_dud+eotech_sp_mk32dud", 0, 0, 0, 1);
    thread maps\enemyhq_rooftop_intro::handle_m32_launcher();
  }
}

spawn_allies(var_0) {
  level.allies = [];
  level.allies[level.allies.size] = spawn_ally("ally1", var_0);
  level.allies[level.allies.size] = spawn_ally("ally2", var_0);
  level.allies[level.allies.size] = spawn_ally("ally4", var_0);
  level.allies[0].animname = "baker";
  level.allies[1].animname = "keegan";
  level.allies[2].animname = "hesh";
  level.allies[0].npcid = "mrk";
  level.allies[1].npcid = "kgn";
  level.allies[2].npcid = "hsh";

  foreach(var_2 in level.allies)
  self.goalradius = 25;

  var_4 = spawn_ally("dog", var_0);
  var_4 setup_dog();
  level.player_dog = var_4;
  level.player thread maps\_dog_control::enable_dog_control(level.dog);

  if(isDefined(level.start_point) && level.start_point != "intro" && level.start_point != "introroof" && level.start_point != "drive_in") {}

  maps\_utility::delaythread(0.05, maps\_utility::set_team_bcvoice, "allies", "taskforce");
  level.allies[2] attach("weapon_mts_255_small", "tag_stowed_back", 1);
}

setup_dog() {
  level.dog = self;
  level.dog.animname = "dog";
  level.dog.meleealwayswin = 1;
  level.dog.script_stealthgroup = "dog";
  level.dog.script_nobark = 1;
  level.dog.script_friendname = "Riley";
  level.dog.name = "Riley";
  level.dog.goalradius = 512;
  level.dog.goalheight = 128;
  level.dog.pathenemyfightdist = level.dog.goalradius;
  level.dog.fixednode = 1;
  level.dog setdogattackradius(128);
  level.dog setthreatbiasgroup("dog");
  setthreatbias("dog", "axis", 75);
  level.dog pushplayer(1);
  level.dog maps\enemyhq_code::set_move_rate(0.7);
}

spawn_ally(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_1))
    var_2 = level.start_point + "_" + var_0;
  else
    var_2 = var_1 + "_" + var_0;

  var_3 = maps\enemyhq_code::spawn_targetname_at_struct_targetname(var_0, var_2);

  if(!isDefined(var_3))
    return undefined;

  var_3 maps\_utility::make_hero();

  if(!isDefined(var_3.magic_bullet_shield))
    var_3 maps\_utility::magic_bullet_shield();

  var_3.countryid = "US";
  var_3.voice = "delta";
  return var_3;
}

lights() {
  var_0 = getEntArray("flickerlight1", "targetname");

  foreach(var_2 in var_0)
  var_2 thread flareflicker();
}

flareflicker() {
  while(isDefined(self)) {
    wait(randomfloatrange(0.05, 0.1));
    self setlightintensity(randomfloatrange(0.6, 1.8));
  }
}

flare_flicker(var_0, var_1) {
  var_2 = getent(self.target, "targetname");

  if(!isDefined(var_0))
    var_0 = 0.6;

  if(!isDefined(var_1))
    var_1 = 1.8;

  thread common_scripts\utility::play_loop_sound_on_entity("flare_burn_loop");

  while(isDefined(self)) {
    wait(randomfloatrange(0.05, 0.1));
    var_2 setlightintensity(randomfloatrange(var_0, var_1));
  }
}