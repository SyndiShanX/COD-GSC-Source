/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\highway\highway.gsc
***********************************************/

main() {
  init_precache();
  scripts\sp\maps\highway\highway_lighting.gsc::init_lighting();
  scripts\engine\sp\utility::add_hint_string("prone", &"HIGHWAY/PRONE", ::player_isprone);
  scripts\engine\sp\utility::add_hint_string("prone_toggle", &"HIGHWAY/PRONE_TOGGLE", ::player_isprone);
  scripts\engine\sp\utility::add_hint_string("ads", &"HIGHWAY/ADS");
  scripts\engine\sp\utility::add_hint_string("ads_toggle", &"HIGHWAY/ADS_TOGGLE");
  scripts\engine\sp\utility::add_hint_string("zoom_in", &"HIGHWAY/ZOOM_IN", ::player_zoomedin);
  scripts\engine\sp\utility::add_hint_string("zoom_out", &"HIGHWAY/ZOOM_OUT", ::player_zoomedout);
  scripts\engine\sp\utility::add_hint_string("throw_molotov", &"HIGHWAY/THROW_MOLOTOV", ::player_throwingmolotov);
  scripts\sp\maps\highway\gen\highway_art.gsc::main();
  scripts\sp\maps\highway\highway_fx.gsc::main();
  scripts\sp\maps\highway\highway_precache.gsc::main();
  scripts\sp\maps\highway\highway_anim.gsc::init_anims();
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rebel", "truck_suicide", "script_vehicle_iw8_truck_techo_rebel");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty", "truck_highway", "script_vehicle_iw8_truck_techo_whitedirty");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_black", "truck_highway", "script_vehicle_iw8_truck_techo_blackdirty");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_red", "truck_highway", "script_vehicle_iw8_truck_techo_reddirty");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_tan", "truck_highway", "script_vehicle_iw8_truck_techo_tandirty");
  scripts\vehicle\vindia::main("veh8_mil_lnd_vindia_a2", "apc_highway", "script_vehicle_iw8_vindia_a2");
  scripts\engine\sp\utility::transient_init("highway_bunker_tr");
  scripts\engine\sp\utility::transient_init("highway_main_tr");
  scripts\engine\sp\utility::set_default_start("ride");
  scripts\engine\sp\utility::add_start("ride", ::ride_start, "Ride", ::ride_main, "highway_all");
  scripts\engine\sp\utility::add_start("intro", ::intro_start, "Intro", ::intro_main, "highway_all");
  scripts\engine\sp\utility::add_start("roof", ::roof_start, "Roof", ::roof_main, "highway_all", ::roof_catchup);
  scripts\engine\sp\utility::add_start("tutorial", ::tutorial_start, "Tutorial", ::tutorial_main, "highway_all", ::tutorial_catchup);
  scripts\engine\sp\utility::add_start("scouting", ::scouting_start, "Scouting", ::scouting_main, "highway_all");
  scripts\engine\sp\utility::add_start("dogs", ::dogs_start, "Dogs", ::dogs_main, "highway_all");
  scripts\engine\sp\utility::add_start("assassinate", ::assassinate_start, "Assassinate", ::assassinate_main, "highway_all");
  scripts\engine\sp\utility::add_start("trap", ::trap_start, "Trap", ::trap_main, "highway_all");
  scripts\engine\sp\utility::add_start("convoy", ::convoy_start, "Convoy", ::convoy_main, "highway_all");
  scripts\engine\sp\utility::add_start("ambush", ::ambush_start, "Ambush", ::ambush_main, "highway_all");
  scripts\engine\sp\utility::add_start("fallback", ::fallback_start, "Fallback", ::fallback_main, "highway_all");
  scripts\engine\sp\utility::add_start("reinforcements", ::reinforcements_start, "Reinforcements", ::reinforcements_main, "highway_all");
  scripts\engine\sp\utility::add_start("assault", ::assault_start, "Assault", ::assault_main, "highway_all");
  scripts\engine\sp\utility::add_start("mortars", ::mortars_start, "Mortars", ::mortars_main, "highway_all");
  scripts\engine\sp\utility::add_start("suicide", ::suicide_start, "Suicide", ::suicide_main, "highway_all");
  scripts\engine\sp\utility::add_start("restock", ::restock_start, "Restock", ::restock_main, "highway_all");
  scripts\engine\sp\utility::add_start("radio", ::radio_start, "Radio", ::radio_main, "highway_all");
  scripts\engine\sp\utility::add_start("sniper", ::sniper_start, "Sniper", ::sniper_main, "highway_all");
  scripts\engine\sp\utility::add_start("squad", ::squad_start, "Squad", ::squad_main, "highway_all");
  scripts\engine\sp\utility::add_start("jets", ::jets_start, "Jets", ::jets_main, "highway_all");
  scripts\engine\sp\utility::add_start("armor", ::armor_start, "Armor", ::armor_main, "highway_all");
  scripts\engine\sp\utility::add_start("russians", ::russians_start, "Russians", ::russians_main, "highway_all");
  scripts\engine\sp\utility::add_start("cover", ::cover_start, "Cover", ::cover_main, "highway_all");
  scripts\engine\sp\utility::add_start("crash", ::crash_start, "Crash", ::crash_main, "highway_all");
  scripts\engine\sp\utility::add_start("gas", ::gas_start, "Gas", ::gas_main, "highway_all");
  scripts\engine\sp\utility::add_start("drag", ::drag_start, "Drag", ::drag_main, "highway_all");
  scripts\engine\sp\utility::add_start("bunker", ::bunker_start, "Bunker", ::bunker_main, "highway_bunker_only");
  scripts\engine\sp\utility::intro_screen_custom_func(::intro_fadeup);
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  init_level();
  init_player();
  scripts\sp\player\ballistics::init_ballistics();
  init_vfx();
  init_wind();
}

intro_fadeup() {
  thread scripts\sp\hud_util::fade_out(0);
  wait 0.2;
  thread scripts\sp\hud_util::fade_in(0);
}

init_precache() {
  precachemodel("hat_gasmask");
  precachemodel("prop_gasmask");
  precachemodel("veh8_mil_lnd_vindia_a2");
  precachemodel("offhand_wm_grenade_smoke");
  precachemodel("veh8_mil_lnd_vindia_wheel_01_dst");
  precachemodel("highway_suniform25_bomb");
  precachemodel("body_hero_farah_nobraids");
  precachemodel("military_radio_crate_01");
  precachemodel("offhand_wm_cellphone_old_on");
  precachemodel("cinderblock_01_02");
  precachemodel("com_flashlight_on_xforward");
  precachemodel("equipment_binoculars_01");
  precachemodel("stray_desert_dog_01");
  precachemodel("equipment_mortar_shell_improvised_01");
  precachemodel("misc_wm_mortar");
  precachemodel("weapon_wm_bomb_ied_bomb");
  precachemodel("body_sla_rebels_lmg_2_1");
  precachemodel("head_sc_m_ahmadzai_civ");
  precachemodel("veh8_civ_lnd_zuniform_static_dst");
  precachemodel("Prop_child_hadir_gas_mask");
  precachemodel("head_hero_farah_gasmask");
  precachemodel("box_wooden_grenade_02");
  precacheshader("gasmask_overlay_delta2");
  precachemodel("offhand_wm_grenade_mike67");
  precachemodel("hardware_plywood_bare_01_48_hod");
  precacheshader("ui_black_circle_vignette");
  precachemodel("head_al_qatala_2_cqc");
}

init_vfx() {
  level._effect["vfx_suicide_truck_disable"] = loadfx("vfx/iw8/level/highway/vfx_suicide_truck_disable");
  level._effect["vfx_suicidetruck_explosion"] = loadfx("vfx/iw8/level/highway/vfx_suicidetruck_explosion");
  level._effect["vfx_suicide_truck_armor_break"] = loadfx("vfx/iw8/level/highway/vfx_suicide_truck_armor_break");
  level._effect["vfx_vindia_tire_sparks"] = loadfx("vfx/iw8/level/highway/vfx_vindia_tire_sparks");
  level._effect["vfx_vindia_smoke_grenade_trail"] = loadfx("vfx/iw8/level/highway/vfx_vindia_smoke_grenade_trail");
  level._effect["vfx_vindia_smoke_grenade_fire"] = loadfx("vfx/iw8/level/highway/vfx_vindia_smoke_grenade_fire");
  level._effect["vfx_vindia_smk_gren_left"] = loadfx("vfx/iw8/level/highway/vfx_vindia_smk_gren_left");
  level._effect["vfx_techo_disable"] = loadfx("vfx/iw8/level/highway/vfx_techo_disable");
  level._effect["vfx_jet_engine"] = loadfx("vfx/iw8/level/highway/vfx_jet_engine");
  level._effect["vfx_jet_wing_trail"] = loadfx("vfx/iw8/level/highway/vfx_jet_wing_trail");
  level._effect["vfx_suniform25_bomb_trail"] = loadfx("vfx/iw8/level/highway/vfx_suniform25_bomb_trail");
  level._effect["vfx_suniform25_bomb_explosion"] = loadfx("vfx/iw8/level/highway/vfx_suniform25_bomb_explosion");
  level._effect["vfx_mortar_trail"] = loadfx("vfx/iw8/level/highway/vfx_mortar_trail");
  level._effect["vfx_mortar_impact"] = loadfx("vfx/iw8/level/highway/vfx_mortar_impact");
  level._effect["vfx_mortar_fire"] = loadfx("vfx/iw8/level/highway/vfx_mortar_fire");
  level._effect["vfx_tutorial_target_explosion"] = loadfx("vfx/iw8/level/highway/vfx_tutorial_target_explosion");
  level._effect["vfx_watermelon_explosion"] = loadfx("vfx/iw8/level/highway/vfx_watermelon_explosion");
  level._effect["vfx_vindia_tire_break"] = loadfx("vfx/iw8/level/highway/vfx_vindia_tire_break");
  level._effect["vfx_sniper_glint"] = loadfx("vfx/iw8/level/highway/vfx_sniper_glint");
  level._effect["vfx_sniper_bullet_impact"] = loadfx("vfx/iw8/level/highway/vfx_sniper_bullet_impact");
  level._effect["vfx_sniper_muzzle_flash"] = loadfx("vfx/iw8/level/highway/vfx_sniper_muzzle_flash");
  level._effect["vfx_sniper_dust_kickup"] = loadfx("vfx/iw8/level/highway/vfx_sniper_dust_kickup");
  level._effect["vfx_sniper_bullet_trail"] = loadfx("vfx/iw8/level/highway/vfx_sniper_bullet_trail");
  level._effect["vfx_tear_gas_explosion"] = loadfx("vfx/iw8/level/highway/vfx_tear_gas_explosion");
  level._effect["vfx_tear_gas_cloud"] = loadfx("vfx/iw8/level/highway/vfx_tear_gas_cloud");
  level._effect["vfx_tear_gas_screen"] = loadfx("vfx/iw8/level/highway/vfx_tear_gas_screen");
}

init_level() {
  var_0 = ["frag", "flash", "molotov", "ied"];
  scripts\engine\sp\utility::offhandprecache(var_0);
  level.aigibfunction = scripts\sp\gibbing::gibbing_gibai;
  level.autosave.enemydistcheck = 0;
  scripts\sp\utility::context_melee_enable(0);
  level.flags = 0;
  level_setredshirtgoalamount(3);
  scripts\sp\maps\highway\highway_utility.gsc::level_objectiveinit();
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(32, 1);
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(64, 0);
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(512, 1);
  scripts\engine\utility::flag_init("level_dialoguePlaying");
  scripts\engine\utility::flag_init("level_enemyAssaultPlayerSeek");
  scripts\engine\utility::flag_init("convoy_enemyCommanderReached");
  scripts\engine\utility::flag_init("convoy_vehiclesStopped");
  scripts\engine\utility::flag_init("restock_playerLeftBunker");
  scripts\engine\utility::flag_init("sniper_enemyRelocating");
  scripts\engine\utility::flag_init("bunker_playerFallenBack");
  setsaveddvar("MKNNNONLSK", 4);
  setsaveddvar("MMLNNQSTTL", 10);
  setsaveddvar("LTMPKRLLNM", 25000);
  setsaveddvar("OLPNKQKKTT", 22000);
  setsaveddvar("PKKMTTRQO", 4);
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\sp\utility::battlechatter_on("axis");
  var_1 = scripts\engine\utility::getStructArray("level_allyStairStruct", "targetname");

  foreach(var_3 in var_1)
  createnavbadplacebybounds(var_3.origin, (var_3.radius, var_3.radius, var_3.radius), (0, 0, 0), "allies");

  var_5 = getnodearray("traverse", "targetname");

  foreach(var_7 in var_5) {
    if(scripts\engine\utility::is_equal(var_7.script_parameters, "level_townLadderNodeBegin"))
      createnavbadplacebybounds(var_7.origin, (16, 16, 16), (0, 0, 0), "axis");
  }

  level_spawnhadirtruck();
  level_redbarreldistantlogic();
  level_setupoilpump();
  thread level_ballisticsniperammopickuplogic();
  restock_connectiedpaths();
  var_9 = getEnt("weapon_iw8_sn_sbeta+rec_sbeta+reargrip_sbeta+ironsdefault_sbeta+xmags+stockl_sbeta+barlong_sbeta+strap_sbeta", "code_classname");
  var_9.origin = (834.469, -2059.13, 896.75);
  var_10 = getEnt("weapon_iw8_sm_beta+rec_beta+front_beta+reflex_east02+xmags_beta+stockl_beta", "code_classname");
  var_11 = spawn("weapon_iw8_sm_beta+rec_beta+front_beta+reflex_east02+xmagslrg_beta+stockl_beta", var_10.origin, var_10.spawnflags);
  var_11.angles = var_10.angles;
  var_11.targetname = var_10.targetname;
  var_11 scripts\anim\shared.gsc::setscriptammo("weapon_iw8_sm_beta", var_10, undefined);
  var_10 delete();
  scripts\engine\sp\utility::add_global_spawn_function("axis", scripts\sp\player\ballistics::ballistics_aiignoreballisticsweaponpain);
}

init_player() {
  level.player.flags = 0;
  player_giveprimaryoffhandweapon();
  player_givesecondaryoffhandweapon();
  level.player setviewmodel("viewmodel_arms_alex_desert");
  level.player setshadowmodel("default_character_shadow");
  level.player scripts\sp\utility::allow_weapon_first_raise_anims(0);
  thread player_trackvariablezoom();
  thread player_dropballisticsweaponlogic();
}

ride_start() {
  if(getdvarint("introMovie"))
    level.player setclienttriggeraudiozone("bink_fadeout_amb", 0.5);
}

ride_main() {
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 0.05);
  level.player scripts\engine\utility::delaycall(0.3, ::setclienttriggeraudiozone, "highway_intro_ride", 1.0);
  level.player lerpfovscalefactor(0, 0);
  scripts\sp\maps\highway\highway_utility.gsc::level_setfailonfriendlyfire(1);
  var_0 = level_addmissionnarrativeobjective();
  var_1 = level_gettownanimationstruct();
  var_2 = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  var_3 = ride_spawnVehicle();
  var_4 = level_spawnfarah();
  var_4.anim_playvo_func = scripts\engine\utility::playsoundontag;
  thread scripts\sp\maps\highway\highway_lighting.gsc::ride_lighting(var_3);
  thread scripts\sp\maps\highway\highway_lighting.gsc::ride_dof(var_4);
  var_5 = ride_spawnanimateddriverally();
  var_6 = ride_spawnanimatedalexally();
  var_7 = ride_spawnanimatedgateallies();
  var_8 = scripts\sp\maps\highway\highway_anim.gsc::ride_getgatetypes();
  var_9 = [];

  foreach(var_11 in var_8) {
    var_12 = scripts\engine\sp\utility::spawn_anim_model("HOD_intro_truck_gate_" + var_11);
    var_9 = scripts\engine\utility::array_add(var_9, var_12);
  }

  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_5, "");
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_4, "");
  var_4 scripts\common\utility::demeanor_override("casual_gun");
  var_1 scripts\common\anim::anim_first_frame_solo(var_3, "ride");
  var_3 thread scripts\common\anim::anim_first_frame_solo(var_4, "ride", "tag_body_animate");
  var_3 thread scripts\common\anim::anim_first_frame_solo(var_6, "ride", "tag_body_animate");
  var_3 thread scripts\common\anim::anim_first_frame_solo(var_5, "ride", "tag_body_animate");
  var_3 thread scripts\common\anim::anim_first_frame_solo(var_2, "ride_camera", "tag_body_animate");
  var_3 thread scripts\common\anim::anim_first_frame(var_7, "ride", "tag_body_animate");
  var_4 linkTo(var_3, "tag_body_animate");
  var_5 linkTo(var_3, "tag_body_animate");
  var_6 linkTo(var_3, "tag_body_animate");
  var_2 linkTo(var_3, "tag_body_animate");
  scripts\sp\maps\highway\highway_utility.gsc::player_rigenterabsolute(var_2);
  var_2 hide();
  thread ride_farahmodellogic(var_2, var_4);
  thread ride_audiologic();
  thread ride_cinematiccamerasettings();
  var_1 thread scripts\common\anim::anim_single_solo(var_3, "ride");
  var_3 thread scripts\common\anim::anim_single_solo(var_4, "ride", "tag_body_animate");
  var_3 thread scripts\common\anim::anim_single_solo(var_6, "ride", "tag_body_animate");
  var_3 thread scripts\common\anim::anim_single_solo(var_5, "ride", "tag_body_animate");
  var_1 thread scripts\common\anim::anim_single(var_9, "ride");
  var_1 thread scripts\common\anim::anim_single(var_7, "ride");
  var_3 scripts\common\anim::anim_single_solo(var_2, "ride_camera", "tag_body_animate");
  var_6 delete();
  level.player freezecontrols(0);
  scripts\sp\maps\highway\highway_utility.gsc::player_rigexit(var_2, 1);
  scripts\sp\maps\highway\highway_utility.gsc::player_rigenter(var_2, 0, 0, 0, 0, 0);
  var_14 = 0.5;
  level.player lerpviewangleclamp(var_14, 0, 0, 30, 30, 20, 20);
  var_3 thread scripts\common\anim::anim_single_solo(var_2, "ride", "tag_body_animate");
  var_15 = var_2 scripts\engine\utility::getanim("ride");
  var_16 = getanimlength(var_15);
  var_17 = var_16 - var_14;
  thread ride_screenshakelogic(var_17);
  wait(var_17);
  level.player lerpviewangleclamp(var_14, 0, 0, 0, 0, 0, 0);
  wait(var_14);
  var_4 unlink();
  var_5 unlink();
  var_2 unlink();
  scripts\engine\utility::array_delete(var_7);
  objective_delete(var_0);
  scripts\sp\maps\highway\highway_utility.gsc::player_rigexit(var_2);
  thread scripts\sp\maps\highway\highway_lighting.gsc::ride_end();
}

ride_screenshakelogic(var_0) {
  var_1 = gettime() + var_0 * 1000;
  var_2 = 0.2;
  var_3 = 0.4;
  var_4 = 0.5;
  var_5 = 0.2;
  var_6 = 0.5;
  var_7 = 0.4;
  var_8 = 0.2;
  var_9 = 0.5;
  var_10 = 4.0;
  var_11 = 0.5;

  for(;;) {
    if(gettime() + var_11 * 1000 >= var_1) {
      break;
    }

    var_12 = randomfloatrange(var_2, var_3);
    var_13 = randomfloatrange(var_8, var_9);
    var_14 = randomfloatrange(var_2, var_3);
    level.player screenshakeonentity(var_12, var_13, var_14, 1, 0, 0, 1000, var_4, var_7, var_10);
    wait(var_11);
  }
}

ride_farahmodellogic(var_0, var_1) {
  var_2 = var_1.model;
  var_1 setModel("body_hero_farah_nobraids");
  scripts\sp\maps\highway\highway_utility.gsc::animation_waittillnotetrack(var_0, "swap_farah_model");
  var_1 setModel(var_2);
}

ride_audiologic() {
  setmusicstate("mx_highway_walkntalk");
  thread ride_gatesfxlogic();
  wait 0.1;
  level.player playSound("scn_highway_intro_whoosh");
  wait 0.4;
  level.player playSound("scn_highway_intro_drive_lr");
}

ride_gatesfxlogic() {
  wait 10;
  thread scripts\engine\utility::play_sound_in_space("scn_highway_intro_gate_open", (-2446, -1732, 1080));
  wait 8;
  thread scripts\engine\utility::play_sound_in_space("scn_highway_intro_gate_close", (-2446, -1732, 1080));
  level.player clearclienttriggeraudiozone(6.0);
}

ride_cinematiccamerasettings() {
  hidecinematicletterboxing(0, 0);
  wait 5;
  getrandomnodedestination(2, 0);
}

ride_spawnVehicle() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("ride_vehicle");
  var_0.targetname = "ride_vehicle";
  return var_0;
}

ride_getvehicle() {
  return getEnt("ride_vehicle", "targetname");
}

ride_spawnanimateddriverally() {
  var_0 = getspawner("ride_animatedDriverAllySpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "ride_animatedDriverAlly";
  var_1.targetname = "ride_animatedAlly";
  var_1 scripts\engine\sp\utility::set_goalRadius(32);
  var_1 scripts\common\utility::demeanor_override("casual_gun");
  return var_1;
}

ride_spawnanimatedalexally() {
  var_0 = getspawner("ride_alexAllySpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "ride_animatedAlexAlly";
  var_2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  var_1 scripts\anim\shared.gsc::forceuseweapon(var_2, "primary");
  return var_1;
}

ride_spawnanimatedgateallies() {
  var_0 = getspawnerarray("ride_animatedGateAllySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.animname = "ride_animatedGateAlly" + var_3.script_index;
    var_3 scripts\common\ai::gun_remove();
    scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_3, "");
  }

  return var_1;
}

ride_getanimatedallies() {
  return getEntArray("ride_animatedAlly", "targetname");
}

intro_start() {
  scripts\sp\maps\highway\highway_utility.gsc::level_setfailonfriendlyfire(1);
  var_0 = level_spawnfarah();
  var_0 scripts\common\utility::demeanor_override("casual_gun");
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_0, "");
  var_1 = ride_spawnVehicle();
  var_2 = level_gettownanimationstruct();
  var_2 scripts\common\anim::anim_last_frame_solo(var_1, "ride");
  var_3 = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  var_4 = getanimlength(var_3 scripts\engine\utility::getanim("ride"));
  var_5 = getanimlength(var_3 scripts\engine\utility::getanim("ride_camera"));
  var_6 = var_4 + var_5;
  var_7 = getanimlength(var_0 scripts\engine\utility::getanim("ride"));
  var_8 = var_6 / (var_7 - 0.05);
  var_1 thread scripts\common\anim::anim_single_solo(var_0, "ride", "tag_body_animate");
  scripts\engine\utility::delaythread(0.05, scripts\common\anim::anim_set_time_solo, var_0, "ride", var_8);
  var_9 = scripts\sp\maps\highway\highway_utility.gsc::ai_getanimationfinalorigin(var_3, "ride", var_1);
  var_10 = scripts\sp\maps\highway\highway_utility.gsc::ai_getanimationfinalangles(var_3, "ride", var_1);
  var_3 delete();
  level.player setOrigin(var_9);
  level.player setplayerangles(var_10);
}

intro_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("intro");
  player_givesecondaryweapon();
  thread intro_playerspeedscalinglogic();
  var_0 = level_getfarah();
  scripts\sp\maps\highway\highway_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"HIGHWAY/OBJECTIVE_FOLLOW_FARAH");
  thread intro_plankanimationscenelogic();
  var_0.anim_playvo_func = undefined;
  var_1 = level_gettownanimationstruct();
  intro_hadirscenelogic(var_1);
  intro_setupanimatedfarahscope(var_1);
  var_2 = intro_spawnanimatedphoneally();
  var_3 = scripts\engine\sp\utility::spawn_anim_model("intro_animatedPhone");
  var_4 = [var_2, var_3];
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_4, "intro_phoneIdleA");
  var_5 = intro_spawnanimatedcinderblockallies();
  var_6 = scripts\sp\maps\highway\highway_anim.gsc::intro_getcinderblockanimations();
  var_7 = [];

  for(var_8 = 0; var_8 < var_6.size; var_8++) {
    var_7[var_8] = scripts\engine\sp\utility::spawn_anim_model("intro_animatedCinderblock" + var_8);
    var_1 scripts\common\anim::anim_first_frame_solo(var_7[var_8], "intro_cinderblockEnter");
  }

  var_9 = scripts\engine\sp\utility::spawn_anim_model("intro_animatedCinderblockSledgehammer");
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_5, "intro_cinderblockIdleA");
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_9, "intro_cinderblockIdleA");
  var_10 = intro_spawnanimatedstairsally();
  var_11 = scripts\sp\maps\highway\highway_anim.gsc::intro_getstairscrateanimations();
  var_12 = [];

  for(var_8 = 0; var_8 < var_11.size; var_8++)
    var_12[var_8] = scripts\engine\sp\utility::spawn_anim_model("intro_animatedStairsCrate" + var_8);

  var_13 = scripts\engine\utility::array_add(var_12, var_10);
  var_1 scripts\common\anim::anim_first_frame(var_13, "intro_stairsEnter");
  intro_scenealogic(var_1, var_0, var_10, var_12);
  intro_sceneblogic(var_1, var_0);
  intro_sceneclogic(var_1, var_0, var_4, var_5, var_7, var_9);
  var_14 = scripts\engine\utility::array_combine(var_7, [var_9], [var_3]);
  thread intro_animatedpropscleanuplogic(var_14);
}

intro_playerspeedscalinglogic() {
  var_0 = level_getfarah();
  var_0 endon("death");
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  scripts\sp\player::player_movement_state("creep");
  level endon("intro_levelHasSniper");
  var_1 = 70;
  var_2 = 120;
  var_3 = 30;
  var_4 = 130;

  for(;;) {
    var_5 = distance(var_0.origin, level.player.origin);
    var_6 = scripts\engine\math::normalize_value(var_3, var_4, var_5);
    var_7 = scripts\engine\math::factor_value(var_1, var_2, var_6);
    scripts\engine\sp\utility::player_speed_set(var_7);
    waitframe();
  }
}

intro_scenealogic(var_0, var_1, var_2, var_3) {
  var_4 = "intro_animatedStairsAlly";
  thread intro_stairsanimationscenelogic(var_0, var_2, var_3, var_4);
  thread intro_dialoguejokesectionalogic(var_1);
  scripts\sp\maps\highway\highway_utility.gsc::animation_waittillend(var_1);
  scripts\engine\utility::exploder("release_birds_1");
  scripts\sp\maps\highway\highway_utility.gsc::animation_single(var_0, var_1, "intro_farahSceneA");
  var_5 = ["dx_vom_far_intro_village_65", "dx_vom_far_intro_village_80"];
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_5, 10, level, "player_nearAI", 9);
  var_6 = scripts\sp\maps\highway\highway_utility.gsc::ai_getanimationfinalorigin(var_1, "intro_farahSceneB", var_0);
  scripts\sp\maps\highway\highway_utility.gsc::player_waittillnearai(var_1, 200, var_6, undefined, undefined, 10, undefined, undefined);
  level notify(var_4);
}

intro_sceneblogic(var_0, var_1) {
  thread intro_dialoguejokesectionblogic(var_1);
  var_2 = var_1.anglelerprate;
  var_1.anglelerprate = 20;
  scripts\sp\maps\highway\highway_utility.gsc::animation_reachtosingleintoloop(var_0, var_1, "intro_farahSceneB", "intro_farahSceneBIdle");
  var_1.anglelerprate = var_2;
  var_3 = ["dx_vom_far_intro_village_220", "dx_vom_far_intro_village_230", "dx_vom_far_intro_rooftop_110"];
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_3, 8, level, "player_nearAI", 8, undefined, undefined, "intro_farahSceneBNag", "intro_farahSceneBIdle", var_0);
  var_4 = scripts\sp\maps\highway\highway_utility.gsc::ai_getanimationfinalorigin(var_1, "intro_farahSceneC", var_0);
  scripts\sp\maps\highway\highway_utility.gsc::player_waittillnearai(var_1, 250, var_4, undefined, undefined, 10, undefined, undefined, 128);
}

intro_sceneclogic(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\utility::exploder("release_birds_2");
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_2);
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_2, "intro_phoneEnter", "intro_phoneIdleB");
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_3);
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_5);
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintolastframe(var_0, var_4, "intro_cinderblockEnter");
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintolastframe(var_0, var_5, "intro_cinderblockEnter");
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_3, "intro_cinderblockEnter", "intro_cinderblockIdleB");
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_1);
  scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_1, "intro_farahSceneC", "intro_farahSceneCIdle");
  var_6 = ["dx_vom_far_intro_rooftop_100"];
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_6, 5, level, "player_nearAI", 3, undefined, undefined, "intro_farahSceneCNag", "intro_farahSceneCIdle", var_0);
  var_7 = scripts\sp\maps\highway\highway_utility.gsc::ai_getanimationfinalorigin(var_1, "roof_sceneAEnter", var_0);
  scripts\sp\maps\highway\highway_utility.gsc::player_waittillnearai(var_1, 300, var_7, undefined, undefined, 10, undefined, undefined, 128);
}

intro_hadirscenelogic(var_0) {
  var_1 = level_spawnhadir();
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_1, "");
  var_2 = scripts\engine\sp\utility::spawn_anim_weapon("intro_animatedHadirSniper", undefined, undefined, 0);
  var_2.targetname = "intro_hadirSniper";
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_0, [var_1, var_2], "intro_hadirIdle");
}

intro_getanimatedhadirsniper() {
  return getEnt("intro_hadirSniper", "targetname");
}

intro_setupanimatedfarahscope(var_0) {
  var_1 = scripts\engine\sp\utility::spawn_anim_model("intro_animatedFarahScope");
  var_1.targetname = "intro_farahScope";
  var_0 = level_gettownanimationstruct();
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "roof_sceneCEnter");
}

intro_getanimatedfarahscope() {
  return getEnt("intro_farahScope", "targetname");
}

intro_plankanimationscenelogic() {
  level endon("intro_levelHasSniper");
  var_0 = getspawnerarray("intro_animatedPlankAllySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.targetname = "intro_animatedAlly";
    var_3.animname = "intro_animatedPlankAlly" + var_3.script_index;
    var_3 scripts\engine\sp\utility::disable_surprise();
    var_3 scripts\engine\sp\utility::disable_bulletwhizbyreaction();
    var_3 scripts\engine\utility::disable_pain();
    var_3 pushplayer(1);
    var_3.script_pushable = 0;

    if(scripts\engine\utility::is_equal(var_3.demeanoroverride, "casual")) {
      var_3 scripts\common\ai::gun_remove();
      var_3.gunremoved = 1;
    }
  }

  var_5 = scripts\engine\sp\utility::spawn_anim_model("intro_animatedPlankCrate");
  var_6 = scripts\engine\utility::array_add(var_1, var_5);
  var_7 = scripts\engine\utility::getStruct("intro_plankAnimationStruct", "targetname");
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_single(var_7, var_6, "intro_plankEnter");
  thread intro_plankanimationscenecratelogic(var_5);
  var_8 = getEnt("intro_nearPlankAlliesTrigger", "targetname");
  var_8 waittill("trigger");

  foreach(var_10 in var_6) {
    if(!isDefined(var_10)) {
      continue;
    }
    var_10 delete();
  }
}

intro_plankanimationscenecratelogic(var_0) {
  level.player endon("death");
  var_0 endon("entitydeleted");
  scripts\sp\maps\highway\highway_utility.gsc::animation_waittillend(var_0);

  for(;;) {
    var_1 = sighttracepassed(var_0.origin, level.player getEye(), 0, level.player, 1);

    if(!var_1) {
      break;
    }

    waitframe();
  }

  var_0 delete();
}

intro_spawnanimatedphoneally() {
  var_0 = getspawner("intro_animatedPhoneAllySpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.targetname = "intro_animatedAlly";
  var_1.animname = "intro_animatedPhoneAlly";
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_1, "");
  var_1 scripts\common\ai::gun_remove();
  var_1.gunremoved = 1;
  return var_1;
}

intro_spawnanimatedcinderblockallies() {
  var_0 = getspawnerarray("intro_animatedCinderblockAllySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.targetname = "intro_animatedAlly";
    var_3.animname = "intro_animatedCinderblockAlly" + var_3.script_index;
    scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_3, "");
    var_4 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
    var_3 scripts\anim\shared.gsc::forceuseweapon(var_4, "primary");
  }

  return var_1;
}

intro_spawnanimatedstairsally() {
  var_0 = getspawner("intro_animatedStairsAllySpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.targetname = "intro_animatedAlly";
  var_1.animname = "intro_animatedStairsAlly";
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_1, "");
  return var_1;
}

intro_stairsanimationscenelogic(var_0, var_1, var_2, var_3) {
  intro_stairsanimationwaittillscene(var_1, var_3);
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_1, "intro_stairsEnter", "intro_stairsIdle");
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintolastframe(var_0, var_2, "intro_stairsEnter");
}

intro_stairsanimationwaittillscene(var_0, var_1) {
  level endon(var_1);

  for(;;) {
    var_2 = sighttracepassed(var_0 getEye(), level.player getEye(), 0, var_0, 1);

    if(var_2) {
      break;
    }

    waitframe();
  }
}

intro_dialoguejokesectionalogic(var_0) {
  level.player endon("death");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_intro_joke_10", 1.0);
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_intro_joke_20", 0.25);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_intro_joke_30", 0.4);
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_intro_joke_40", 0.25);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_intro_joke_50");
}

intro_dialoguejokesectionblogic(var_0) {
  level.player endon("death");
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_intro_joke_60");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_intro_joke_70");
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_intro_joke_80");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_intro_joke_90");
}

intro_animatedpropscleanuplogic(var_0) {
  level.player waittill("tutorial_playerFoundAllies");

  foreach(var_2 in var_0)
  var_2 delete();

  var_4 = ride_getvehicle();
  var_4 delete();
}

intro_getanimatedallies() {
  return getEntArray("intro_animatedAlly", "targetname");
}

roof_start() {
  scripts\sp\maps\highway\highway_utility.gsc::level_setfailonfriendlyfire(1);
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_0, "");
  var_1 = level_gettownanimationstruct();
  intro_hadirscenelogic(var_1);
  intro_setupanimatedfarahscope(var_1);
  var_2 = level_gethadir();
  var_2 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 scripts\engine\sp\utility::set_ignoreall(1);
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_2, "");
  player_givesecondaryweapon();
  thread intro_playerspeedscalinglogic();
  scripts\engine\sp\utility::set_start_location("start_roof", [level.player]);
}

roof_main() {
  roof_setuptutorialallies();
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  var_2 = intro_getanimatedhadirsniper();
  var_3 = level_gettownanimationstruct();
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_intro_village_104", 2.0);
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_intro_village_105", 4.0);
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_0);
  scripts\sp\maps\highway\highway_utility.gsc::animation_single(var_3, var_0, "roof_farahEnter");
  roof_scenealogic(var_3, var_0, var_1, var_2);
  roof_sceneblogic(var_3, var_0, var_1, var_2);
  roof_scenesniperlogic(var_3, var_0, var_1, var_2);
  roof_sceneclogic(var_3, var_0, var_1);

  if(5.0)
    wait 5.0;
}

roof_scenealogic(var_0, var_1, var_2, var_3) {
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_2);
  var_4 = roof_gethadirclip();
  var_4 delete();
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_3, "roof_sceneAEnter", "roof_sceneAIdle");
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_1, "roof_sceneAEnter", "roof_sceneAIdle");
  scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_2, "roof_sceneAEnter", "roof_sceneAIdle");
  thread roof_sceneanaglogic(var_0, var_2, var_3);
  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();
  var_5 = scripts\sp\maps\highway\highway_utility.gsc::level_objectivegetindex();
  scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_MEET_HADIR", var_2.origin);
  objective_onentity(var_5, var_2);
  objective_setzoffset(var_5, 72);
  scripts\sp\maps\highway\highway_utility.gsc::player_waittillnearai(var_2, 150, undefined, undefined, undefined, 10);
  objective_delete(var_5);
}

roof_sceneanaglogic(var_0, var_1, var_2) {
  level endon("player_nearAI");

  for(;;) {
    scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop([var_1, var_2]);
    childthread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_2, "roof_sceneANag", "roof_sceneAIdle");
    var_0 scripts\common\anim::anim_single_solo(var_1, "roof_sceneANag");
    scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_0, var_1, "roof_sceneAIdle");
    var_3 = var_1 scripts\engine\utility::getanim("roof_sceneAIdle")[0];
    var_4 = getanimlength(var_3);
    wait(var_4);
  }
}

roof_sceneblogic(var_0, var_1, var_2, var_3) {
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop([var_1, var_2, var_3]);
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_1, "roof_sceneBEnter", "roof_sceneBIdle");
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_2, "roof_sceneBEnter", "roof_sceneBIdle");
  var_0 scripts\common\anim::anim_single_solo(var_3, "roof_sceneBEnter");
}

roof_scenesniperlogic(var_0, var_1, var_2, var_3) {
  level.player scripts\sp\utility::allow_weapon_first_raise_anims(1);
  var_4 = roof_spawnsniperweapon(var_3.origin, var_3.angles);
  var_3 delete();
  var_5 = ["dx_vom_had_intro_gun_80"];
  var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_5, 10, var_4, "trigger", 10, undefined, undefined, "roof_sceneBNag", "roof_sceneBIdle", var_0);
  var_6 = ["dx_vom_far_intro_gun_90"];
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_6, 10, var_4, "trigger", 17);
  var_7 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_GRAB_SNIPER", var_4.origin + (0, 0, 12));
  level.player scripts\sp\player::focus_display_hint(11, undefined, var_4, "trigger");
  var_4 waittill("trigger");
  level notify("intro_levelHasSniper");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  scripts\sp\player::player_movement_state("default");
  thread roof_sniperpickupplayerdisablelogic();
  var_8 = player_getballisticsweaponobject();
  level.player setweaponammoclip(var_8, weaponclipsize(var_8));
  level.player setweaponammostock(var_8, weaponmaxammo(var_8));
  objective_delete(var_7);
  level_addmissionnarrativeobjective();
  level.player thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_intro_gun_95", 3.2);
  level.player thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_intro_gun_110", 8.0);
}

roof_sniperpickupplayerdisablelogic() {
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_sprint(0);
  level.player scripts\common\utility::allow_jump(0);
  level.player scripts\common\utility::allow_ads(0);
  level.player scripts\common\utility::allow_fire(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\common\utility::allow_weapon_switch(0);
  wait 8.0;
  level.player scripts\common\utility::allow_prone(1);
  level.player scripts\common\utility::allow_sprint(1);
  level.player scripts\common\utility::allow_jump(1);
  level.player scripts\common\utility::allow_ads(1);
  level.player scripts\common\utility::allow_fire(1);
  level.player scripts\common\utility::allow_offhand_weapons(1);
  level.player scripts\common\utility::allow_weapon_switch(1);
}

roof_sceneclogic(var_0, var_1, var_2) {
  var_3 = 2.0;
  wait(var_3);
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_2);
  scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_2, "roof_sceneCEnter", "roof_sceneCIdle");
  var_2 pushplayer(1);
  var_2.script_pushable = 0;
  var_2 scripts\common\utility::demeanor_override("casual_gun");
  thread roof_scenefarahspotlogic(var_0, var_1, var_2);
}

roof_scenefarahspotlogic(var_0, var_1, var_2) {
  var_3 = 1.8;
  wait(var_3);
  thread roof_scenefarahanimationlogic(var_0, var_1, var_2);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_intro_gun_70");

  if(!player_isprone())
    var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_intro_gun_120", 0.75, level, "tutorial_goProneComplete");
}

roof_scenefarahanimationlogic(var_0, var_1, var_2) {
  setmusicstate("");
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_1);
  var_3 = intro_getanimatedfarahscope();
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_3, "roof_sceneCEnter", "roof_sceneCIdle");
  scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_1, "roof_sceneCEnter", "roof_sceneCIdle");
  var_4 = roof_getfarahclip();
  var_4 delete();
}

roof_spawnsniperweapon(var_0, var_1) {
  var_2 = "weapon_" + player_getprimaryweaponname();
  var_3 = spawn(var_2, var_0, 1);
  var_3.angles = var_1;
  var_3.script_ammo_max = 1;
  return var_3;
}

roof_setuptutorialallies() {
  var_0 = tutorial_spawnallies();
  var_1 = tutorial_getsignalally();
  var_2 = scripts\engine\utility::array_remove(var_0, var_1);
  var_3 = tutorial_getallynodes();
  scripts\sp\maps\highway\highway_utility.gsc::ai_takecoveratnodes(var_2, var_3);
}

roof_gethadirclip() {
  return getEnt("roof_hadirClip", "targetname");
}

roof_getfarahclip() {
  return getEnt("tutorial_farahClip", "targetname");
}

roof_catchup() {
  var_0 = roof_gethadirclip();
  var_0 delete();
  var_1 = roof_getfarahclip();
  var_1 delete();
}

tutorial_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_0, "");
  var_1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var_1);
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_0, "intro_farahSceneCIdle");
  var_2 = level_spawnhadir();
  var_2 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 scripts\engine\sp\utility::set_ignoreall(1);
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_2, "");
  player_givefullloadout();
  roof_setuptutorialallies();
  level_spawnredshirts();
}

tutorial_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("tutorial");
  scripts\sp\maps\highway\highway_utility.gsc::level_setfailonfriendlyfire(0);
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  thread tutorial_allieslogic();
  setsaveddvar("LKKMQRSKTS", 0);
  setsaveddvar("MMLNNQSTTL", 30);
  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();

  if(!player_isprone())
    tutorial_goprone(var_0);

  if(!level.player playerads())
    tutorial_ads(var_0);

  tutorial_signalallylogic(var_0, var_1);

  if(!player_sniperzoomedin())
    tutorial_zoomin(var_0);

  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_0, "Farah");
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_1, "Hadir");
  tutorial_alliessearch(var_0);
  thread tutorial_primarytargetlogic();
  thread tutorial_secondarytargetlogic();
  level.player scripts\engine\utility::waittill_multiple("tutorial_primary_target_shot", "tutorial_secondary_target_shot");
  level_addmissionnarrativeobjective();
  setsaveddvar("LKKMQRSKTS", 1);
}

tutorial_allieslogic() {
  level.player waittill("tutorial_playerFoundAllies");
  var_0 = ride_getanimatedallies();

  foreach(var_2 in var_0) {
    scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_2);
    var_2 delete();
  }

  var_4 = intro_getanimatedallies();

  foreach(var_2 in var_4) {
    var_2 scripts\engine\sp\utility::anim_stopanimScripted();
    scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_2);
    var_2.targetname = "level_redShirt";
    var_2.animname = "level_redShirt";
    var_2 scripts\common\utility::clear_demeanor_override();
    var_2 pushplayer(0);
    var_2.script_pushable = 1;

    if(istrue(var_2.gunremoved))
      var_2 scripts\common\ai::gun_recall();

    if(isDefined(var_2.script_friendname))
      scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_2, var_2.script_friendname);
  }

  thread level_redshirtslogic();
}

tutorial_spawnallies() {
  var_0 = getspawnerarray("tutorial_allySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3 scripts\engine\sp\utility::set_ignoreall(1);
    var_3.targetname = "intro_highwayAlly";
    var_3.animname = "tutorial_ally";
    var_3.name = "";
    var_3 scripts\engine\sp\utility::set_baseaccuracy(0.1);
    var_3 scripts\common\ai::magic_bullet_shield();
    var_3 scripts\engine\sp\utility::set_grenadeweapon("molotov");
    var_3 scripts\engine\sp\utility::set_grenadeammo(3);
  }

  foreach(var_3 in var_1)
  var_1[var_3.script_index] = var_3;

  return var_1;
}

tutorial_getallies() {
  return getEntArray("intro_highwayAlly", "targetname");
}

tutorial_getallynodes() {
  return getnodearray("tutorial_allyNode", "targetname");
}

tutorial_goprone(var_0) {
  var_1 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_GO_PRONE", (-547, -1740, 1204));
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_intro_prone_10", 5.0, level, "tutorial_goProneComplete");
  var_2 = ["dx_vom_far_intro_prone_20", "dx_vom_far_intro_prone_30"];
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_2, 8, level, "tutorial_goProneComplete", 15);
  var_3 = getkeybinding("+stance");

  if(level.player usinggamepad() || var_3["count"] || level.player getlocalplayerprofiledata("proneType") == 2)
    scripts\engine\sp\utility::display_hint("prone", undefined, 7.0);
  else
    scripts\engine\sp\utility::display_hint("prone_toggle", undefined, 7.0);

  while(!player_isprone())
    waitframe();

  objective_delete(var_1);
  level notify("tutorial_goProneComplete");
}

tutorial_ads(var_0) {
  var_1 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_AIM_DOWN_SIGHTS");
  scripts\sp\maps\highway\highway_utility.gsc::waittill_nodialogueplaying();
  var_2 = ["dx_vom_far_intro_tut_12", "dx_vom_far_intro_tut_14", "dx_vom_far_intro_tut_13"];
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_2, 4, level.player, "ads_pressed", 1.0);

  if(level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledGamepad") || !level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledKeyboard"))
    scripts\engine\sp\utility::display_hint("ads_toggle", undefined, 6.0, level.player, "ads_pressed");
  else
    scripts\engine\sp\utility::display_hint("ads", undefined, 6.0, level.player, "ads_pressed");

  for(;;) {
    level.player waittill("ads_pressed");

    if(player_holdingballisticsweapon()) {
      break;
    }

    var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_2, 4, level.player, "ads_pressed", 1.5);
  }

  while(!player_fullads())
    waitframe();

  objective_delete(var_1);
}

tutorial_signalallylogic(var_0, var_1) {
  var_2 = tutorial_getsignalally();
  var_2 endon("death");
  var_2 attach("com_flashlight_on_xforward", "tag_accessory_left");
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_2, var_2, "tutorial_idle");
  childthread tutorial_allysignaleffectslogic(var_2);
  var_3 = ["dx_vom_far_tutorial_zoom_00", "dx_vom_far_tutorial_zoom_04", "dx_vom_far_tutorial_zoom_01", "dx_vom_far_tutorial_zoom_03", "dx_vom_far_tutorial_zoom_02"];
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_3, 10, level, "tutorial_signalAllyLookedAt", 1.5);
  var_4 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_FIND_SIGNAL", var_2 gettagorigin("j_wrist_ri"));
  level.player scripts\sp\player::focus_display_hint(15, undefined, level, "tutorial_signalAllyLookedAt");
  var_5 = 500;
  var_6 = 0;

  for(;;) {
    var_7 = var_2 gettagorigin("j_wrist_ri");
    var_8 = level.player getEye();
    var_9 = vectorNormalize(var_7 - var_8);
    var_10 = anglesToForward(level.player getplayerangles());
    var_11 = vectordot(var_9, var_10);
    var_12 = sighttracepassed(var_7, var_8, 0, var_2, 1);

    if(player_fullads() && player_holdingballisticsweapon() && var_11 > 0.9999 && var_12) {
      if(!var_6)
        var_6 = gettime();

      if(gettime() >= var_6 + var_5) {
        break;
      }
    } else
      var_6 = 0;

    waitframe();
  }

  level notify("tutorial_signalAllyLookedAt");
  tutorial_deletesniperbench();
  var_13 = getnode("tutorial_hadirNode", "targetname");
  var_1 setgoalnode(var_13);
  var_1 pushplayer(0);
  var_1.script_pushable = 1;
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_1);
  scripts\sp\maps\highway\highway_utility.gsc::waittill_nodialogueplaying();
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_zoom_05", 0.2);
  objective_delete(var_4);
}

tutorial_allysignaleffectslogic(var_0) {
  var_0 endon("tutorial_allyStopSignal");
  var_1 = 1.0;
  var_2 = 1.5;
  var_3 = 1;
  var_4 = 3;
  var_5 = 0.2;
  var_6 = 0.3;

  for(;;) {
    var_7 = randomintrange(var_3, var_4);

    for(var_8 = 0; var_8 < var_7; var_8++) {
      var_9 = var_0 gettagorigin("tag_light");
      var_10 = anglesToForward(var_0 gettagangles("tag_light"));
      playFX(level._effect["vfx_highway_mirror_glint"], var_9, var_10);
      var_11 = randomfloatrange(var_5, var_6);
      wait(var_11);
    }

    var_12 = randomfloatrange(var_1, var_2);
    wait(var_12);
  }
}

tutorial_deletesniperbench() {
  var_0 = tutorial_getsniperbench();
  scripts\engine\utility::array_delete(var_0);
}

tutorial_getsniperbench() {
  return getEntArray("tutorial_sniperBench", "targetname");
}

tutorial_zoomin(var_0) {
  var_1 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_ZOOM_IN");
  var_2 = 1.0;
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_zoom_10", var_2, level.player, "player_variableZoomedIn");
  var_3 = gettime() + var_2 * 1000;
  var_4 = lookupsoundlength("dx_vom_far_tutorial_zoom_10");
  var_5 = var_3 + var_4;
  scripts\engine\sp\utility::display_hint_forced("zoom_in", undefined, 1.5, level.player, "player_variableZoomedIn");
  var_6 = 4.0;
  var_6 = var_6 + (var_2 + var_4 * 0.001);
  var_7 = ["dx_vom_far_tutorial_zoom_40", "dx_vom_far_tutorial_zoom_30", "dx_vom_far_tutorial_zoom_50"];
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_7, 8.0, level.player, "player_variableZoomedIn", var_6);
  level.player waittill("player_variableZoomedIn");

  if(gettime() < var_5) {
    objective_delete(var_1);
    return;
  }

  scripts\sp\maps\highway\highway_utility.gsc::waittill_nodialogueplaying();
  scripts\sp\maps\highway\highway_utility.gsc::waittill_time(var_5);
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_zoom_20", 1.0);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_zoom_21", 0.5);
  objective_delete(var_1);
}

tutorial_alliessearch(var_0) {
  var_1 = tutorial_getanimationorigin();
  var_2 = tutorial_spawnprimarytarget();
  var_1 scripts\common\anim::anim_first_frame_solo(var_2, "tutorial_targetEnter");
  tutorial_setalliesnames();
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_zoom_110");
  var_3 = tutorial_getallies();
  var_4 = tutorial_getsignalally();
  var_5 = scripts\engine\utility::array_remove(var_3, var_4);
  var_4 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_fsa1_tutorial_zoom_120", 1.5);
  var_6 = (0, 0, 0);

  foreach(var_8 in var_5)
  var_6 = var_6 + var_8.origin;

  var_6 = var_6 + (0, 0, 300);
  var_6 = var_6 / var_5.size;
  var_10 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_FIND_ALLIES", var_6);
  var_4 notify("tutorial_allyStopSignal");
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_fsa_10", 3.5, level.player, "tutorial_playerFoundAllies");
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_4);
  scripts\sp\maps\highway\highway_utility.gsc::animation_single(var_4, var_4, "tutorial_enter");
  var_11 = getnode("tutorial_signalAllyNode", "script_noteworthy");
  var_4 scripts\engine\sp\utility::set_goalRadius(4);
  var_4 setgoalnode(var_11);
  var_4 detach("com_flashlight_on_xforward", "tag_accessory_left");
  var_4 scripts\sp\maps\highway\highway_utility.gsc::ai_resetstances();
  var_12 = ["dx_vom_far_tutorial_fsa_20", "dx_vom_far_tutorial_fsa_30", "dx_vom_far_tutorial_fsa_40"];
  var_13 = ["dx_vom_far_tutorial_fsa_42", "dx_vom_far_tutorial_fsa_43", "dx_vom_far_tutorial_fsa_41"];
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_12, 10, level.player, "tutorial_playerFoundAllies", 20, var_13, ::player_sniperzoomedin);
  level.player scripts\sp\player::focus_display_hint(15, undefined, level.player, "tutorial_playerFoundAllies");
  var_14 = 750;
  var_15 = 0;

  for(;;) {
    var_16 = undefined;
    var_17 = level.player getEye();
    var_18 = anglesToForward(level.player getplayerangles());
    var_19 = -2147483647;
    var_18 = anglesToForward(level.player getgunangles());

    foreach(var_8 in var_5) {
      var_21 = vectorNormalize(var_8 getEye() - level.player getEye());
      var_22 = vectordot(var_18, var_21);

      if(var_22 > var_19) {
        var_19 = var_22;
        var_16 = var_8;
      }
    }

    var_24 = isDefined(var_16) && var_19 > 0.999981 && sighttracepassed(var_17, var_16 getEye(), 0, var_16, 1);

    if(var_24 && player_sniperzoomedin()) {
      if(!var_15)
        var_15 = gettime();

      if(gettime() >= var_15 + var_14) {
        break;
      }
    } else
      var_15 = 0;

    waitframe();
  }

  level.player notify("tutorial_playerFoundAllies");
  scripts\sp\maps\highway\highway_utility.gsc::waittill_nodialogueplaying();
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_fsa_60");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_fsa_70", 0.5);
  var_17 = level.player getEye();
  var_18 = anglesToForward(level.player getplayerangles());
  var_19 = -2147483647;
  var_18 = anglesToForward(level.player getgunangles());
  var_25 = undefined;

  foreach(var_8 in var_5) {
    var_21 = vectorNormalize(var_8 getEye() - level.player getEye());
    var_22 = vectordot(var_18, var_21);

    if(var_22 > var_19) {
      var_19 = var_22;
      var_25 = var_8;
    }
  }

  var_25.script_noteworthy = "intro_chosenHighwayAlly";
  objective_delete(var_10);
  tutorial_placetargetlogic(var_2, var_1, var_25);
}

tutorial_placetargetlogic(var_0, var_1, var_2) {
  var_3 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_KEEP_SIGHTS", var_2.origin);
  objective_onentity(var_3, var_2);
  objective_setzoffset(var_3, 72);
  thread tutorial_placetargetdialoguelogic(var_2);
  var_2 waittill("tutorial_chosenAllyPlaceTarget");
  var_4 = 1.0;
  wait(var_4);
  var_5 = var_2.node;
  var_1 scripts\sp\anim::anim_reach_solo(var_2, "tutorial_targetEnter");
  var_1 thread scripts\common\anim::anim_single_solo(var_0, "tutorial_targetEnter");
  var_1 scripts\common\anim::anim_single_solo(var_2, "tutorial_targetEnter");
  var_2 scripts\engine\sp\utility::set_goalRadius(64);

  if(isDefined(var_5))
    var_2 setgoalnode(var_5);

  objective_delete(var_3);
}

tutorial_placetargetdialoguelogic(var_0) {
  var_1 = level_getfarah();
  var_2 = tutorial_getfarahcommandallylines();
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_2[var_0.script_index], 1.0);
  var_3 = tutorial_getallyreplylines();
  var_0 notify("tutorial_chosenAllyPlaceTarget");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_3[var_0.script_index], undefined, undefined, undefined, 1);
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_target_140", 0.75);
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_30", 5.0);
  var_0 waittill("goal");
  wait 4.25;
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_" + var_0.aliasname + "_tutorial_target_190", undefined, undefined, undefined, 1);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_target_210");
}

tutorial_getsignalally() {
  return getEnt("tutorial_signalAlly", "script_noteworthy");
}

tutorial_getanimationorigin() {
  return getEnt("tutorial_animationOrigin", "targetname");
}

tutorial_primarytargetlogic() {
  var_0 = tutorial_getprimarytarget();
  thread tutorial_primarytargetaim(var_0);
  thread tutorial_primarytargetmiss(var_0);
  level.player scripts\sp\player::focus_display_hint(25, undefined, var_0, "ballistics_bulletDamage");
  var_1 = var_0.origin + (0, 0, 50);
  var_2 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SHOOT_JUG", var_1, &"HIGHWAY/LABEL_SHOOT");
  var_0 waittill("ballistics_bulletDamage");
  objective_delete(var_2);
  playFX(level._effect["vfx_tutorial_target_explosion"], var_0.origin);
  var_0 delete();
  level.player notify("aimed_for_gravity_primary");
  level.player notify("aimed_for_wind_primary");
  level.player notify("tutorial_primary_target_shot");
}

tutorial_primarytargetaim(var_0) {
  level endon("ballistics_impact");
  tutorial_primarytargetaimgravity(var_0);
  tutorial_primarytargetaimwind(var_0);
}

tutorial_primarytargetaimgravity(var_0) {
  var_1 = level_getfarah();
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_40", 0.5, level, "ballistics_impact");
  var_2 = ["dx_vom_far_tutorial_adjust_50", "dx_vom_far_tutorial_adjust_60", "dx_vom_far_tutorial_adjust_70"];
  var_3 = ["dx_vom_far_tutorial_zoom_40", "dx_vom_far_tutorial_zoom_30", "dx_vom_far_tutorial_zoom_50"];
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_2, 7, level.player, "aimed_for_gravity_primary", 6.0, var_3, ::player_sniperzoomedin);
  var_4 = 300;
  var_5 = 0;

  for(;;) {
    var_6 = scripts\sp\player\ballistics::ballistics_doesbullettrajectoryhitentity(level.player getEye(), level.player getplayerangles(), var_0, 0);

    if(var_6 && player_sniperzoomedin()) {
      if(!var_5)
        var_5 = gettime();

      if(gettime() >= var_5 + var_4) {
        break;
      }
    } else
      var_5 = 0;

    waitframe();
  }

  level.player notify("aimed_for_gravity_primary");
  scripts\sp\maps\highway\highway_utility.gsc::waittill_nodialogueplaying();
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_adjust_80");
}

tutorial_primarytargetaimwind(var_0) {
  var_1 = level_getfarah();
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_target_160");

  if(level.ballistics.winddirectionaimstring == "left")
    var_2 = ["dx_vom_far_tutorial_adjust_100", "dx_vom_far_tutorial_adjust_130", "dx_vom_far_tutorial_adjust_145"];
  else
    var_2 = ["dx_vom_far_tutorial_adjust_110", "dx_vom_far_tutorial_adjust_160", "dx_vom_far_tutorial_adjust_175"];

  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_2, 8, level.player, "aimed_for_wind_primary", 2.5);
  var_3 = 300;
  var_4 = 0;

  for(;;) {
    var_5 = scripts\sp\player\ballistics::ballistics_doesbullettrajectoryhitentity(level.player getEye(), level.player getplayerangles(), var_0, 1);

    if(var_5 && player_sniperzoomedin()) {
      if(!var_4)
        var_4 = gettime();

      if(gettime() >= var_4 + var_3) {
        break;
      }
    } else
      var_4 = 0;

    waitframe();
  }

  level.player notify("aimed_for_wind_primary");
  scripts\sp\maps\highway\highway_utility.gsc::waittill_nodialogueplaying();
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_zoom_100", 0.5);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_210", 0.5, level, "ballistics_impact");
  var_6 = ["dx_vom_far_tutorial_adjust_211", "dx_vom_far_tutorial_adjust_212", "dx_vom_far_tutorial_adjust_213"];
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_6, 7, level, "ballistics_impact", 6.0);
}

tutorial_primarytargetmiss(var_0) {
  var_0 endon("ballistics_bulletDamage");
  var_1 = level_getfarah();
  var_2 = level_gethadir();
  level waittill("ballistics_impact", var_3);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_10", 0.5);
  var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_tutorial_adjust_20", 1.5);

  if(level.ballistics.winddirectionaimstring == "left")
    var_4 = "dx_vom_far_tutorial_adjust_145";
  else
    var_4 = "dx_vom_far_tutorial_adjust_175";

  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_4, 3.5);
}

tutorial_secondarytargetlogic() {
  var_0 = level_getfarah();
  var_1 = tutorial_getsecondarytarget();
  thread tutorial_secondaryaim(var_1);
  var_1 waittill("ballistics_bulletDamage");
  var_2 = getEnt(var_1.target, "targetname");
  playFX(level._effect["vfx_watermelon_explosion"], var_2.origin);
  var_2 delete();
  var_1 delete();
  level.player notify("tutorial_secondary_target_shot");
}

tutorial_secondaryaim(var_0) {
  level.player waittill("tutorial_primary_target_shot");

  if(!isDefined(var_0)) {
    return;
  }
  level.player scripts\sp\player::focus_display_hint(35, undefined, var_0, "ballistics_bulletDamage");
  var_1 = var_0.origin + (0, 0, 50);
  var_2 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SHOOT_WATERMELON", var_1, &"HIGHWAY/LABEL_SHOOT");
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::call_on_notify_no_self("ballistics_bulletDamage", ::objective_delete, var_2);
  thread tutorial_secondarytargetlookat(var_0);
}

tutorial_secondarytargetlookat(var_0) {
  var_0 endon("ballistics_bulletDamage");
  var_1 = level_getfarah();
  var_2 = level_gethadir();
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_stop();
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_350", 0.5);
  var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_tutorial_jug_100", 1.0);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_230", 0.5);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_melon_10", 1);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_melon_20", 1);
  tutorial_secondarylookatbuilding(var_0);
  scripts\sp\maps\highway\highway_utility.gsc::waittill_nodialogueplaying();
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_melon_60", 0.5, var_0, "ballistics_bulletDamage");

  if(!player_sniperzoomedin()) {
    scripts\engine\sp\utility::display_hint("zoom_in");
    var_3 = 0.5;
    var_4 = 4;
    var_5 = ["dx_vom_far_tutorial_zoom_40", "dx_vom_far_tutorial_zoom_30", "dx_vom_far_tutorial_zoom_50"];
    var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_5, var_4, level.player, "sprint_pressed", var_3);

    for(;;) {
      level.player waittill("sprint_pressed");

      if(player_fullads() && player_holdingballisticsweapon()) {
        break;
      }

      var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_5, 3, level.player, "sprint_pressed", 0.25);
    }
  }

  scripts\sp\maps\highway\highway_utility.gsc::waittill_nodialogueplaying();
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_melon_70", 0.5, var_0, "ballistics_bulletDamage");
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_melon_90", 1.0, level, "ballistics_impact");
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_melon_91", 11.0, level, "ballistics_impact");
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_melon_92", 17.0, level, "ballistics_impact");
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_melon_93", 24.0, level, "ballistics_impact");
  childthread tutorial_secondarytargetmisslogic(var_0);
}

tutorial_secondarylookatbuilding(var_0) {
  var_1 = level_getfarah();

  if(player_sniperzoomedin())
    scripts\engine\sp\utility::display_hint("zoom_out", undefined, undefined, level, "tutorial_secondaryTargetLookedAt");

  var_2 = scripts\engine\utility::getStruct("tutorial_secondaryLookAtStruct", "targetname");
  var_3 = ["dx_vom_far_tutorial_melon_30", "dx_vom_far_tutorial_melon_50"];
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_3, 8, level, "tutorial_secondaryTargetLookedAt", 6);

  for(;;) {
    var_4 = vectorNormalize(var_2.origin - level.player getEye());
    var_5 = anglesToForward(level.player getplayerangles());
    var_6 = vectordot(var_4, var_5);
    var_7 = sighttracepassed(var_2.origin, level.player getEye(), 0, level.player, 1);

    if(player_fullads() && player_holdingballisticsweapon() && var_6 > 0.999949 && var_7) {
      break;
    }

    waitframe();
  }

  level notify("tutorial_secondaryTargetLookedAt");
}

tutorial_secondarytargetmisslogic(var_0) {
  var_1 = level_getfarah();

  for(;;) {
    level waittill("ballistics_impact", var_2);
    var_3 = var_2 - var_0.origin;
    var_4 = vectorNormalize(level.player.origin - var_0.origin);
    var_5 = anglestoup(level.player getplayerangles());
    var_6 = anglestoright(level.player getplayerangles());
    var_7 = vectordot(var_3, var_6);
    var_8 = vectordot(var_3, var_5);
    var_9 = 10.0;
    var_10 = 12.0;
    var_11 = 4.0;
    var_12 = abs(var_7) > var_9;
    var_13 = var_8 > var_10 + var_11 || var_8 < var_11 * -1;

    if(var_12) {
      var_14 = var_7 > 0;
      var_15 = !var_14;
    } else {
      var_14 = 0;
      var_15 = 0;
    }

    if(var_13) {
      var_16 = var_8 > 0;
      var_17 = !var_16;
    } else {
      var_16 = 0;
      var_17 = 0;
    }

    if(var_14) {
      if(var_13) {
        if(var_16)
          var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_250", 1.0);
        else
          var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_260", 1.0);
      } else
        var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_310", 1.0);

      continue;
    }

    if(var_15) {
      if(var_13) {
        if(var_16)
          var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_280", 1.0);
        else
          var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_290", 1.0);
      } else
        var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_320", 1.0);

      continue;
    }

    if(var_16) {
      var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_330", 1.0);
      continue;
    }

    if(var_17)
      var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_340", 1.0);
  }
}

tutorial_spawnprimarytarget() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("tutorial_primaryTarget");
  var_0.targetname = "tutorial_primary_target";
  return var_0;
}

tutorial_getprimarytarget() {
  return getEnt("tutorial_primary_target", "targetname");
}

tutorial_getsecondarytarget() {
  return getEnt("tutorial_secondary_target", "targetname");
}

tutorial_getfarahcommandallylines() {
  return ["dx_vom_far_tutorial_target_60", "dx_vom_far_tutorial_target_30", "dx_vom_far_tutorial_target_40", "dx_vom_far_tutorial_target_50", "dx_vom_far_tutorial_target_20"];
}

tutorial_getallyreplylines() {
  return ["dx_vom_fsf2_tutorial_target_80", "dx_vom_fsa2_tutorial_target_80", "dx_vom_fsa3_tutorial_target_80", "dx_vom_fsf1_tutorial_target_80", "dx_vom_fsa1_tutorial_target_80"];
}

tutorial_getallyreadylines() {
  return ["dx_vom_fsf2_tutorial_target_190", "dx_vom_fsa1_tutorial_target_190", "dx_vom_fsa2_tutorial_target_190", "dx_vom_fsa3_tutorial_target_190", "dx_vom_fsf1_tutorial_target_190"];
}

tutorial_setalliesnames() {
  var_0 = tutorial_getallies();
  var_0 = scripts\sp\maps\highway\highway_utility.gsc::array_sortbyscriptindex(var_0);
  var_1 = tutorial_getallynames();
  var_2 = tutorial_getallyaliasnames();

  foreach(var_5, var_4 in var_0) {
    var_4.name = var_1[var_4.script_index];
    var_4.aliasname = var_2[var_4.script_index];
  }
}

tutorial_getallynames() {
  return ["Nida", "Imaad", "Raza", "Ayah", "Ali"];
}

tutorial_getallyaliasnames() {
  return ["fsf2", "fsa2", "fsa3", "fsf1", "fsa1"];
}

tutorial_catchup() {
  var_0 = tutorial_getsecondarytarget();
  var_0 delete();
  tutorial_deletesniperbench();
}

scouting_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var_1);
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_0, "intro_farahSceneCIdle");
  var_2 = level_spawnhadir();
  var_2 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var_3 = tutorial_spawnallies();
  var_4 = tutorial_getallynodes();

  for(var_5 = 0; var_5 < var_3.size; var_5++)
    var_3[var_5] scripts\engine\sp\utility::teleport_ai(var_4[var_5]);

  tutorial_setalliesnames();
  level_addmissionnarrativeobjective();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility.gsc::player_startpronehack();
}

scouting_main() {
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue_stop();
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_220", 0.5);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_tutorial_melon_100", 1.0);
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_melon_110", 0.5);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_melon_150", 0.5);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_dogs_10");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_dogs_12", 0.5);
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_dogs_14", 0.5);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_dogs_16", 0.5);
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_dogs_18", 9);
}

dogs_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var_1);
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_0, "intro_farahSceneCIdle");
  var_2 = level_spawnhadir();
  var_2 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var_3 = tutorial_spawnallies();
  var_4 = tutorial_getallynodes();

  for(var_5 = 0; var_5 < var_3.size; var_5++)
    var_3[var_5] scripts\engine\sp\utility::teleport_ai(var_4[var_5]);

  tutorial_setalliesnames();
  level_addmissionnarrativeobjective();
  level_spawnredshirts();
}

dogs_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("dogs");
  var_0 = dogs_spawndogs();
  thread dogs_pathlogic(var_0);
  thread dogs_runlogic(var_0);
  dogs_dialoguelogic(var_0);

  if(istrue(10))
    wait 10;
}

dogs_pathlogic(var_0) {
  level endon("ballistics_impact");
  level endon("dogs_forceRun");
  scripts\engine\utility::array_wait(var_0, "reached_path_end");
  level notify("dogs_pathReachedEnd");
}

dogs_runlogic(var_0) {
  level endon("dogs_pathReachedEnd");
  level scripts\engine\utility::waittill_any("ballistics_impact", "dogs_forceRun");
  var_1 = scripts\engine\utility::getStructArray("dogs_runPositionStruct", "targetname");

  foreach(var_3 in var_0) {
    var_3 scripts\common\utility::demeanor_override("sprint");
    var_3 notify("stop_going_to_node");
    var_4 = sortbydistance(var_1, var_3.origin)[0];
    var_3 scripts\engine\sp\utility::set_goal_radius(64);
    var_3 thread scripts\sp\spawner::go_to_node(var_4);
    var_1 = scripts\engine\utility::array_remove(var_1, var_4);
  }

  scripts\engine\utility::array_wait(var_0, "goal");
  level notify("dogs_pathReachedEnd");
}

dogs_dialoguelogic(var_0) {
  level endon("ballistics_impact");
  level endon("dogs_forceRun");
  thread dogs_dialogueplayermisslogic(var_0);
  thread dogs_dialoguedeathlogic(var_0);
  var_1 = level_getfarah();
  var_2 = 6.0;
  var_3 = 2.0;
  var_4 = 13.0;
  var_5 = 3.0;
  var_6 = 7.5;
  wait(var_2);
  thread dogs_playerspotteddogslogic(var_0);
  var_7 = level scripts\engine\utility::waittill_notify_or_timeout_return("dogs_playerSpottedDogs", var_3);

  if(scripts\engine\utility::is_equal(var_7, "dogs_playerSpottedDogs")) {
    level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_dogs_30");
    thread dogs_playerspotteddogslogic(var_0, var_5);
    var_7 = level scripts\engine\utility::waittill_notify_or_timeout_return("dogs_playerSpottedDogs", var_4);

    if(scripts\engine\utility::is_equal(var_7, "dogs_playerSpottedDogs"))
      level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_dogs_50");
    else
      var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_dogs_60");
  } else {
    var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_dogs_40");
    level notify("dogs_playerSpottedDogs");
    thread dogs_playerspotteddogslogic(var_0, var_5);
    var_7 = level scripts\engine\utility::waittill_notify_or_timeout_return("dogs_playerSpottedDogs", var_4);

    if(scripts\engine\utility::is_equal(var_7, "dogs_playerSpottedDogs"))
      level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_dogs_50");
    else
      var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_dogs_60");
  }

  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_dogs_20", 3.5);
}

dogs_playerspotteddogslogic(var_0, var_1) {
  level endon("ballistics_impact");
  level endon("dogs_playerSpottedDogs");
  level endon("dogs_pathReachedEnd");

  foreach(var_3 in var_0)
  var_3 endon("death");

  if(istrue(var_1))
    wait(var_1);

  var_5 = 500;
  var_6 = 0;

  for(;;) {
    waitframe();
    var_7 = (0, 0, 0);

    foreach(var_3 in var_0)
    var_7 = var_7 + var_3.origin;

    var_7 = var_7 / var_0.size;
    var_10 = anglesToForward(level.player getplayerangles());
    var_11 = vectorNormalize(var_7 - level.player getEye());
    var_12 = vectordot(var_10, var_11);
    var_13 = var_12 >= 0.999848;
    var_14 = sighttracepassed(var_7, level.player getEye(), 0, level.player, 1);
    var_15 = length(level.player getnormalizedcameramovement());
    var_16 = var_15 <= 0.65;

    if(player_sniperzoomedin() && var_13 && var_16 && var_14) {
      if(!var_6)
        var_6 = gettime();

      if(gettime() >= var_6 + var_5) {
        break;
      }
    } else
      var_6 = 0;
  }

  level notify("dogs_playerSpottedDogs");
}

dogs_dialoguedeathlogic(var_0) {
  foreach(var_2 in var_0)
  var_2 endon("entitydeleted");

  var_4 = level_getfarah();
  scripts\engine\utility::array_any_wait(var_0, "death");
  level notify("dogs_playerShotDog");
  var_4 scripts\sp\maps\highway\highway_utility.gsc::dialogue_stop();
  var_4 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_dogs_80", 1.0);
  var_4 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_dogs_20", 2.0);
}

dogs_dialogueplayermisslogic(var_0) {
  foreach(var_2 in var_0)
  var_2 endon("entitydeleted");

  level endon("dogs_playerShotDog");
  var_4 = level_getfarah();
  level waittill("ballistics_impact");
  var_4 scripts\sp\maps\highway\highway_utility.gsc::dialogue_stop();
  var_4 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_dogs_90", 1);
  var_4 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_dogs_20", 2);
}

dogs_spawndogs() {
  var_0 = getspawnerarray("dogs_dogSpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3 scripts\engine\sp\utility::set_goalRadius(64);
    var_3 scripts\engine\sp\utility::set_ignoreall(1);
  }

  return var_1;
}

assassinate_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var_1);
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_0, "intro_farahSceneCIdle");
  var_2 = level_spawnhadir();
  var_2 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var_3 = tutorial_spawnallies();
  var_4 = tutorial_getallynodes();

  for(var_5 = 0; var_5 < var_3.size; var_5++)
    var_3[var_5] scripts\engine\sp\utility::teleport_ai(var_4[var_5]);

  tutorial_setalliesnames();
  var_6 = dogs_spawndogs();
  thread dogs_pathlogic(var_6);
  thread dogs_runlogic(var_6);
  level_spawnredshirts();
}

assassinate_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("assassinate");
  var_0 = assassinate_spawnVehicle();
  var_1 = assassinate_spawnenemiesinvehicle(var_0);
  thread scripts\common\vehicle_paths::gopath(var_0);
  var_2 = level_getfarah();
  thread assassinate_dogslogic();
  thread assassinate_dialoguelogic(var_0, var_1, var_2);
  thread assassinate_sfxlogic(var_0);
  thread assassinate_enemieslogic(var_0, var_1);
  scripts\engine\sp\utility::waittill_dead_or_dying(var_1);
  var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_combat_90", 1);
}

assassinate_dogslogic() {
  var_0 = 3.0;
  wait(var_0);
  level notify("dogs_forceRun");
}

assassinate_dialoguetruck(var_0) {
  wait 4;
  var_1 = level_getfarah();
  var_2 = tutorial_getsignalally();
  var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_fsa1_scout_reveal_10", undefined, undefined, undefined, 1);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_reveal_30", 0.5);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_reveal_50", 0.5);
  var_3 = gettime() + 6000;
  var_4 = 0;

  for(;;) {
    if(gettime() >= var_3) {
      break;
    }

    var_5 = anglesToForward(level.player getplayerangles());
    var_6 = vectorNormalize(var_0.origin - level.player getEye());
    var_7 = vectordot(var_5, var_6);
    var_8 = sighttracepassed(var_0.origin, level.player getEye(), 0, var_0, 1);

    if(var_7 >= 0.999848 && var_8) {
      var_4 = 1;
      break;
    }

    waitframe();
  }

  if(var_4)
    level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_scout_reveal_60", 1);
  else
    var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_reveal_70", 1);

  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_reveal_80", 0.5);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_reveal_90");
}

assassinate_sfxlogic(var_0) {
  var_0 playSound("scn_highway_truck_incoming_dist_01");
  wait 4.0;
  setmusicstate("mx_highway_singlecar");
}

assassinate_dialoguelogic(var_0, var_1, var_2) {
  level endon("assassinate_enemiesAlerted");
  childthread assassinate_dialoguetruck(var_0);
  childthread assassinate_dialogueinstructionslogic(var_1);
  childthread assassinate_dialogueenemydeathslogic();
  level waittill("assassinate_enemiesClimbing");
  var_3 = tutorial_getsignalally();
  var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_watch_ali_10");
  var_3 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_fsa1_scout_watch_20", undefined, undefined, undefined, 1);
  var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_watch_70", 0.5);
}

assassinate_dialogueinstructionslogic(var_0) {
  level endon("ballistics_impact");
  level.player endon("weapon_fired");
  thread assassinate_dialoguemisslogic(var_0);
  level waittill("assassinate_enemiesClimbing");
  var_1 = level_getfarah();
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_watch_80", 8.0);
  var_2 = "assassinate_playerSpottedEnemies";
  var_3 = ["dx_vom_far_scout_watch_120", "dx_vom_far_scout_watch_130", "dx_vom_far_scout_watch_140"];
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_3, 8, level, var_2, 6);
  var_4 = 250;
  var_5 = 0;

  for(;;) {
    var_6 = level.player getEye();
    var_7 = anglesToForward(level.player getplayerangles());
    var_8 = scripts\engine\sp\utility::get_average_origin(var_0);
    var_9 = vectorNormalize(var_8 - var_6);
    var_10 = vectordot(var_7, var_9);
    var_11 = sighttracepassed(var_8, var_6, 0, level.player, 1);

    if(player_sniperzoomedin() && var_10 >= 0.999848 && var_11) {
      if(!var_5)
        var_5 = gettime();

      if(gettime() >= var_5 + var_4) {
        break;
      }
    } else
      var_5 = 0;

    waitframe();
  }

  level notify(var_2);
  scripts\sp\maps\highway\highway_utility.gsc::waittill_nodialogueplaying();
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_tutorial_fsa_60", 0.2);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_watch_82", 2.0);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_melon_90", 2.0);
  var_12 = ["dx_vom_far_convoy_watch_60", "dx_vom_far_scout_watch_83", "dx_vom_far_scout_watch_100"];
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_12, 8, level.player, "weapon_fired", 6);
}

assassinate_dialoguemisslogic(var_0) {
  foreach(var_2 in var_0)
  var_2 endon("death");

  var_4 = level_gethadir();
  var_5 = level_getfarah();
  var_6 = 1;

  for(;;) {
    level waittill("ballistics_impact", var_7);
    var_8 = undefined;
    var_9 = level.player getEye();
    var_10 = anglesToForward(level.player getplayerangles());
    var_11 = -2147483647;
    var_10 = anglesToForward(level.player getgunangles());

    foreach(var_2 in var_0) {
      var_13 = vectorNormalize(var_2 getEye() - level.player getEye());
      var_14 = vectordot(var_10, var_13);

      if(var_14 > var_11) {
        var_11 = var_14;
        var_8 = var_2;
      }
    }

    var_16 = var_7 - var_8.origin;
    var_10 = vectorNormalize(level.player.origin - var_8.origin);
    var_17 = anglestoup(level.player getplayerangles());
    var_18 = anglestoright(level.player getplayerangles());
    var_19 = vectordot(var_16, var_18);
    var_20 = vectordot(var_16, var_17);
    var_21 = 10.0;
    var_22 = 12.0;
    var_23 = 4.0;
    var_24 = abs(var_19) > var_21;
    var_25 = var_20 > var_22 + var_23 || var_20 < var_23 * -1;

    if(var_24) {
      var_26 = var_19 > 0;
      var_27 = !var_26;
    } else {
      var_26 = 0;
      var_27 = 0;
    }

    if(var_25) {
      var_28 = var_20 > 0;
      var_29 = !var_28;
    } else {
      var_28 = 0;
      var_29 = 0;
    }

    if(var_26) {
      if(var_25) {
        if(var_28)
          var_5 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_250", 1.5);
        else
          var_5 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_260", 1.5);
      } else
        var_5 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_310", 1.5);
    } else if(var_27) {
      if(var_25) {
        if(var_28)
          var_5 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_280", 1.5);
        else
          var_5 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_290", 1.5);
      } else
        var_5 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_320", 1.5);
    } else if(var_28 || var_29)
      var_5 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_60", 1.5);

    if(var_6) {
      var_4 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_convoy_bc_160", 0.5);
      var_6 = 0;
    }
  }
}

assassinate_dialogueenemydeathslogic() {
  var_0 = level_getfarah();

  for(;;) {
    var_1 = assassinate_getenemies();
    level waittill("ballistics_impact");

    foreach(var_3 in var_1)
    waitframe();

    var_5 = assassinate_getenemies();
    var_5 = scripts\sp\maps\highway\highway_utility.gsc::array_removedeaddyingorundefined(var_5);

    if(var_5.size && var_5.size < var_1.size) {
      var_6 = var_5.size == 1;

      if(var_6)
        var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_combat_50", 1, level, "ballistics_impact");
      else
        var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_backup_110", 1, level, "ballistics_impact");
    } else if(!var_5.size) {
      break;
    }

    waitframe();
  }
}

assassinate_enemieslogic(var_0, var_1) {
  level endon("assassinate_enemiesDead");
  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();
  var_2 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SCOUT_ENEMY_VEHICLE");
  objective_onentity(var_2, var_0);
  objective_setzoffset(var_2, 72);
  level thread scripts\sp\maps\highway\highway_utility.gsc::call_on_notify_no_self("assassinate_enemiesAlerted", ::objective_delete, var_2);
  var_3 = level_getfarah();

  foreach(var_5 in var_1)
  var_5 scripts\engine\sp\utility::set_ignoreall(1);

  thread assassinate_driverdeathlogic(var_0, var_1);
  thread assassinate_enemiesdeathlogic(var_1);
  thread assassinate_playeralertsenemies(var_0, var_1);
  level endon("assassinate_enemiesAlerted");
  var_0 waittill("stopped_path");
  level notify("assassinate_enemiesClimbing");
  objective_delete(var_2);
  var_2 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SHOOT_ENEMIES");
  objective_setzoffset(var_2, 72);
  var_1 = scripts\sp\maps\highway\highway_utility.gsc::array_removedeaddyingorundefined(var_1);
  var_7 = assassinate_getcrawlcovernodes();
  var_8 = assassinate_getanimationstruct();

  foreach(var_11, var_5 in var_1) {
    objective_setlocation(var_2, var_11, var_5);
    var_5 thread scripts\sp\maps\highway\highway_utility.gsc::call_on_notify_no_self("death", ::objective_unsetlocation, var_2, var_11);
    var_8 scripts\common\anim::anim_first_frame_solo(var_5, "assassinate_enter");
    var_5 allowedstances("prone");
    scripts\sp\maps\highway\highway_utility.gsc::ai_instantlyremovefromvehicle(var_5);
    var_5 attach("equipment_binoculars_01", "tag_accessory_left", 1);
    thread assassinate_enemybinocularslogic(var_5);
    thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_8, var_5, "assassinate_enter", "assassinate_idle");
    var_10 = sortbydistance(var_7, var_5.origin)[0];
    thread assassinate_enemyreactlogic(var_5, var_10);
    var_7 = scripts\engine\utility::array_remove(var_7, var_10);
  }
}

assassinate_enemybinocularslogic(var_0) {
  scripts\engine\utility::waittill_any_ents(var_0, "death", level, "ballistics_impact");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 detach("equipment_binoculars_01", "tag_accessory_left");
}

assassinate_driverdeathlogic(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(!scripts\engine\utility::is_equal(var_4.vehicle_position, 0)) {
      continue;
    }
    var_2 = var_4;
  }

  if(!isDefined(var_2)) {
    return;
  }
  var_2 endon("entitydeleted");
  var_2 waittill("death");

  if(!isDefined(var_2.ridingvehicle)) {
    return;
  }
  playFX(level.g_effect["human_gib_fullbody"], var_2 gettagorigin("j_spine4"));
  var_2 delete();
}

assassinate_getanimationstruct() {
  return scripts\engine\utility::getStruct("assassinate_animationStruct", "targetname");
}

assassinate_enemyreactlogic(var_0, var_1) {
  var_0 endon("death");
  var_2 = assassinate_getanimationstruct();
  var_3 = "assassinate_entered";
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_notifyonnotetrack(var_0, var_3);
  var_4 = scripts\engine\utility::waittill_any_ents_return(level, "ballistics_impact", var_0, var_3);

  if(var_4 == var_3) {
    level waittill("ballistics_impact");
    scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_0);
    var_2 scripts\common\anim::anim_single_solo(var_0, "assassinate_react");
  } else {
    scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_0);
    var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  }

  var_0 setgoalnode(var_1);
}

assassinate_enemiesdeathlogic(var_0) {
  var_1 = var_0.size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    scripts\engine\utility::array_any_wait(var_0, "death");
    var_0 = scripts\sp\maps\highway\highway_utility.gsc::array_removedeaddyingorundefined(var_0);
    level notify("assassinate_enemyDeath");
  }

  level notify("assassinate_enemiesDead");
}

assassinate_playeralertsenemies(var_0, var_1) {
  level endon("assassinate_enemiesClimbing");

  for(;;) {
    level waittill("ballistics_impact", var_2);
    var_1 = scripts\sp\maps\highway\highway_utility.gsc::array_removedeaddyingorundefined(var_1);

    if(!var_1.size) {
      level notify("assassinate_enemiesAlerted");
      break;
    }

    var_3 = scripts\engine\sp\utility::get_average_origin(var_1);
    var_4 = distance(var_2, var_3);

    if(var_4 > 2500) {
      continue;
    }
    level notify("assassinate_enemiesAlerted");
    break;
  }

  waitframe();
  var_1 = scripts\sp\maps\highway\highway_utility.gsc::array_removedeaddyingorundefined(var_1);

  foreach(var_6 in var_1) {
    var_6 scripts\engine\sp\utility::set_ignoreall(0);
    var_6 scripts\engine\sp\utility::set_ignoreme(0);
    var_6 scripts\common\utility::clear_demeanor_override();
  }

  if(var_1.size) {
    var_8 = level_getfarah();
    var_8 scripts\sp\maps\highway\highway_utility.gsc::dialogue_stop();
    var_8 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_alert_10", 0.2);
    var_8 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_alert_10", 1.5);
  }

  var_9 = ambush_getallynodes();
  var_10 = tutorial_getallies();

  foreach(var_12 in var_10) {
    var_12 scripts\engine\sp\utility::set_ignoreall(0);
    var_12 scripts\engine\sp\utility::set_ignoreme(0);
  }

  scripts\sp\maps\highway\highway_utility.gsc::ai_takecoveratnodes(var_10, var_9);
  var_14 = isDefined(var_0.driver) && isalive(var_0.driver);
  var_15 = isDefined(var_0.currentnode) && scripts\engine\utility::is_equal(var_0.currentnode.script_ent_flag_wait, "trap_setupTruck");

  if(!var_14) {
    var_0 vehicle_setspeed(0, 15, 15);
    var_0 setwaitspeed(0);
    var_0 waittill("reached_wait_speed");
  } else if(!var_15) {
    var_0 vehicle_setspeed(40, 15, 15);
    var_16 = scripts\engine\utility::waittill_any_ents_return(var_0.driver, "death", var_0, "stopped_path");

    if(var_16 == "death") {
      var_0 vehicle_setspeed(0, 15, 15);
      var_0 setwaitspeed(0);
      var_0 waittill("reached_wait_speed");
    }
  } else if(var_15)
    var_0 waittill("stopped_path");

  var_0 scripts\common\vehicle::vehicle_unload();
  var_1 = scripts\sp\maps\highway\highway_utility.gsc::array_removedeaddyingorundefined(var_1);

  foreach(var_6 in var_1) {
    var_6 scripts\engine\sp\utility::set_goalRadius(256);
    var_18 = tutorial_getsignalally();
    var_6 setgoalentity(var_18);
    var_6 scripts\common\utility::demeanor_override("sprint");
  }
}

#using_animtree("vehicles");

assassinate_spawnVehicle() {
  var_0 = scripts\common\utility::getvehiclespawner("assassinate_vehicle", "targetname");
  var_1 = var_0 scripts\common\utility::spawn_vehicle();
  var_1.targetname = "assassinate_vehicle";
  var_1.dontunloadonend = 1;
  var_1 scripts\common\vehicle::godon();
  var_1 scripts\engine\utility::ent_flag_init("trap_setupTruck");
  var_1 useanimtree(#animtree);
  return var_1;
}

assassinate_getvehicle() {
  var_0 = vehicle_getarray();

  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::is_equal(var_2.targetname, "assassinate_vehicle"))
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  return var_0[0];
}

assassinate_spawnenemiesinvehicle(var_0) {
  var_1 = assassinate_getspawners();

  foreach(var_3 in var_1)
  var_3.script_forcespawn = 1;

  var_5 = var_0 scripts\common\vehicle_code::spawn_group(var_1);

  foreach(var_7 in var_5) {
    var_7.targetname = "assassinate_enemy";
    var_7 scripts\engine\sp\utility::set_goalRadius(64);
    var_7.script_parameters = "gib_force";
    var_7.animname = "assassinate_enemy" + var_7.script_index;
    var_7.skipdeathanim = 1;
    var_7.noragdoll = undefined;
  }

  return var_5;
}

assassinate_getspawners() {
  return getspawnerarray("assassinate_enemySpawner");
}

assassinate_getenemies() {
  return getEntArray("assassinate_enemy", "targetname");
}

assassinate_getcrawlcovernodes() {
  return getnodearray("assassinate_crawlCoverNode", "targetname");
}

trap_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var_1);
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_0, "intro_farahSceneCIdle");
  var_2 = level_spawnhadir();
  var_2 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var_3 = assassinate_spawnVehicle();
  scripts\common\vehicle_paths::gopath(var_3);
  var_3 vehicle_setspeed(9999, 8000, 8000);
  var_4 = tutorial_spawnallies();
  var_5 = tutorial_getallynodes();

  for(var_6 = 0; var_6 < var_4.size; var_6++)
    var_4[var_6] scripts\engine\sp\utility::teleport_ai(var_5[var_6]);

  tutorial_setalliesnames();
  level_spawnredshirts();
}

trap_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("trap");
  var_0 = tutorial_getsignalally();
  var_1 = level_getfarah();
  var_2 = level_gethadir();
  thread trap_converationdialoguelogic(var_1, var_2);
  var_3 = 2.0;
  wait(var_3);
  var_4 = tutorial_getallies();
  var_5 = [var_0];

  for(var_6 = var_5.size; var_6 < 2; var_6++) {
    var_7 = scripts\engine\utility::array_remove_array(var_4, var_5);
    var_8 = scripts\engine\utility::random(var_7);
    var_5 = scripts\engine\utility::array_add(var_5, var_8);
  }

  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();
  var_9 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_COVER_ALLIES");
  objective_setzoffset(var_9, 72);

  foreach(var_6, var_11 in var_5) {
    var_11.script_startingposition = var_6;
    var_11.animname = "trap_IEDAlly" + var_6;
    objective_setlocation(var_9, var_6, var_11);
  }

  var_12 = assassinate_getvehicle();
  var_12 scripts\common\vehicle::vehicle_load_ai(var_5, 0);
  var_12 scripts\engine\utility::ent_flag_wait("loaded");
  var_12 playSound("scn_highway_truck_trap_drive_01");
  var_12 scripts\engine\utility::delaycall(1.4, ::playsound, "scn_highway_truck_trap_drive_02");
  var_12 scripts\engine\utility::ent_flag_set("trap_setupTruck");
  var_12 vehicle_setspeed(15, 15, 15);

  while(!var_12 vehicle_getspeed())
    waitframe();

  var_12 setwaitspeed(0);
  var_12 waittill("reached_wait_speed");
  var_12 notify("kill_treads_forever");
  var_12 scripts\engine\utility::delaycall(6.5, ::playsound, "scn_highway_truck_trap_hood_up");
  var_12 scripts\engine\utility::delaycall(10.5, ::playsound, "scn_highway_truck_trap_hood_down_01");
  var_13 = scripts\engine\sp\utility::spawn_anim_model("trap_IED");
  var_12.animname = "trap_vehicle";
  var_12 thread scripts\common\anim::anim_single_solo(var_13, "trap_placeIED");
  var_12 thread scripts\common\anim::anim_single_solo(var_12, "trap_placeIED");

  foreach(var_11 in var_5)
  scripts\sp\maps\highway\highway_utility.gsc::ai_instantlyremovefromvehicle(var_11);

  var_12 scripts\common\anim::anim_single(var_5, "trap_placeIED");
  var_16 = tutorial_getallynodes();
  scripts\sp\maps\highway\highway_utility.gsc::ai_takecoveratnodes(var_4, var_16);
  var_17 = trap_getallyexplosivesreadylines();
  objective_delete(var_9);
  var_9 = level_addmissionnarrativeobjective();
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_17[var_0.script_index]);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_trap_set_10", 1);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_trap_set_20", 1);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_trap_set_30");
  var_13 delete();

  if(8.5)
    wait 8.5;

  objective_delete(var_9);
}

trap_converationdialoguelogic(var_0, var_1) {
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_trap_prep_ali_10", 1.5);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_trap_prep_10", 2.5);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_trap_prep_11", 1.0);
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_scout_convo_10", 2.5);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_convo_20", 1.0);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_convo_30");
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_scout_convo_40", 1.0);
}

trap_getallyexplosivesreadylines() {
  return ["dx_vom_fsa1_trap_prep_ali_20", "dx_vom_fsa3_trap_prep_imaad_20", "dx_vom_fsa2_trap_prep_ayah_20", "dx_vom_fsf2_trap_prep_raza_20", "dx_vom_fsf1_trap_prep_nida_20"];
}

convoy_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var_1);
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_0, "intro_farahSceneCIdle");
  var_2 = level_spawnhadir();
  var_2 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var_3 = assassinate_spawnVehicle();
  var_4 = var_3 scripts\sp\maps\highway\highway_utility.gsc::get_lastentinspline(var_3.currentnode, ::getvehiclenode);
  var_3 vehicle_teleport(var_4.origin, var_4.angles);
  var_5 = tutorial_spawnallies();
  var_6 = tutorial_getallynodes();

  for(var_7 = 0; var_7 < var_5.size; var_7++)
    var_5[var_7] scripts\engine\sp\utility::teleport_ai(var_6[var_7]);

  tutorial_setalliesnames();
  level_spawnredshirts();
}

convoy_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("convoy");
  var_0 = tutorial_getallies();

  foreach(var_2 in var_0) {
    var_2 scripts\engine\sp\utility::set_ignoreall(1);
    var_2 scripts\engine\sp\utility::set_ignoreme(1);
  }

  var_4 = convoy_spawnvehicles();
  var_5 = convoy_spawnenemiesinvehicles(var_4);
  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();
  var_6 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SCOUT_ENEMY_CONVOY");
  objective_setzoffset(var_6, 72);

  foreach(var_9, var_8 in var_4)
  objective_setlocation(var_6, var_9, var_8);

  thread ambush_iedlogic();
  thread convoy_dialoguelogic();
  thread convoy_earlyambushstealthbrokenlogic();
  thread convoy_vehicleslogic(var_4);
  thread convoy_sfxlogic(var_4);
}

convoy_earlyambushstealthbrokenlogic() {
  level waittill("ballistics_impact");
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(1, 1);
}

convoy_dialoguelogic() {
  level endon("ballistics_impact");
  var_0 = level_getfarah();
  var_1 = tutorial_getsignalally();
  var_2 = level_gethadir();
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_fsa1_convoy_reveal_10");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_reveal_20");
  level.player endon("weapon_fired");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_reveal_30");
  var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_convoy_reveal_40", 0.15);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_reveal_50", 0.25);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_" + var_1.aliasname + "_convoy_watch_10", 1.0);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_watch_10", 0.5);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_watch_21", 4.5);
}

convoy_spawnvehicles() {
  var_0 = scripts\common\utility::getvehiclespawnerarray("convoy_vehicle", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    var_4.targetname = "convoy_vehicle";
    var_4 scripts\common\vehicle::godon();
    var_4.donotunloadondriverdeath = 1;
    var_4.dontunloadonend = 1;
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

convoy_getvehicles() {
  var_0 = vehicle_getarray();

  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::is_equal(var_2.targetname, "convoy_vehicle"))
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  return var_0;
}

convoy_spawnenemiesinvehicles(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::get_linked_spawners();

    foreach(var_6 in var_4)
    var_6.script_forcespawn = 1;

    var_8 = var_3 scripts\common\vehicle_code::spawn_group(var_4);
    var_1 = scripts\engine\sp\utility::array_merge(var_1, var_8);
  }

  foreach(var_11 in var_1) {
    var_11 scripts\engine\sp\utility::set_ignoreall(1);
    var_11 scripts\common\utility::demeanor_override("patrol");
    var_11 scripts\engine\sp\utility::set_grenadeammo(3);
  }

  return var_1;
}

convoy_getspawners() {
  return getspawnerarray("convoy_enemySpawner");
}

convoy_getenemies() {
  return getEntArray("convoy_enemy", "targetname");
}

convoy_getvehiclescovernodes() {
  return getnodearray("vehicle_techoCoverNode", "targetname");
}

convoy_vehicleslogic(var_0) {
  foreach(var_2 in var_0)
  thread convoy_vehiclepathlogic(var_2);

  thread convoy_vehiclesunloadlogic(var_0);
}

convoy_vehiclesunloadlogic(var_0) {
  level endon("ballistics_impact");
  level endon("level_iedDetonated");
  var_1 = [];

  foreach(var_3 in var_0)
  var_1 = scripts\engine\sp\utility::array_merge(var_1, var_3.riders);

  foreach(var_6 in var_1) {
    if(!scripts\engine\utility::is_equal(var_6.script_noteworthy, "convoy_enemyUnload")) {
      continue;
    }
    thread convoy_unloadenemylogic(var_6, 1);
  }

  var_8 = [];
  var_9 = getEntArray("convoy_animatedEnemy", "script_noteworthy");
  var_9 = scripts\sp\maps\highway\highway_utility.gsc::array_sortbyscriptindex(var_9);

  foreach(var_11 in var_9) {
    if(scripts\engine\utility::array_contains(var_8, var_11.ridingvehicle)) {
      continue;
    }
    var_8 = scripts\engine\utility::array_add(var_8, var_11.ridingvehicle);
  }

  while(var_8.size) {
    var_13 = scripts\engine\utility::array_any_wait_return(var_8, "reached_wait_speed");

    foreach(var_11 in var_9) {
      if(!scripts\engine\utility::is_equal(var_11.ridingvehicle, var_13)) {
        continue;
      }
      thread convoy_unloadanimatedenemylogic(var_11);
    }

    var_8 = scripts\engine\utility::array_remove(var_8, var_13);
  }

  var_16 = scripts\engine\utility::array_remove_array(var_0, var_8);

  foreach(var_18 in var_16) {
    if(var_18 vehicle_getspeed()) {
      continue;
    }
    var_16 = scripts\engine\utility::array_remove(var_16, var_18);
  }

  if(var_16.size)
    scripts\engine\utility::array_wait(var_0, "reached_wait_speed");

  scripts\engine\utility::flag_set("convoy_vehiclesStopped");
}

convoy_unloadanimatedenemylogic(var_0) {
  level endon("ballistics_impact");
  level endon("level_iedDetonated");
  var_0.ridingvehicle thread scripts\common\vehicle_aianim::guy_unload(var_0, var_0.vehicle_position);
  var_0 waittill("jumpedout");
  var_1 = assassinate_getvehicle();
  var_0.animname = "convoy_enemy" + var_0.script_index;

  if(var_0.script_index == 0) {
    scripts\sp\maps\highway\highway_utility.gsc::animation_reachtosingle(var_1, var_0, "convoy_enter");
    ambush_triggeried();
  } else if(var_0.script_index == 1) {
    var_1 scripts\sp\anim::anim_reach_solo(var_0, "convoy_enter");
    level notify("convoy_enemiesAtTruck");
    scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_1, var_0, "convoy_enter", "convoy_idle");
    scripts\engine\utility::flag_wait("convoy_enemyCommanderReached");
    scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_0);
    scripts\sp\maps\highway\highway_utility.gsc::animation_singleintolastframe(var_1, var_0, "convoy_exit");
  } else {
    var_1 scripts\sp\anim::anim_reach_solo(var_0, "convoy_enter");
    scripts\engine\utility::flag_set("convoy_enemyCommanderReached");
    scripts\sp\maps\highway\highway_utility.gsc::animation_singleintolastframe(var_1, var_0, "convoy_enter");
  }
}

convoy_unloadenemylogic(var_0, var_1) {
  level endon("ballistics_impact");
  level endon("level_iedDetonated");

  if(var_1)
    var_0.ridingvehicle waittill("reached_wait_speed");

  var_0.ridingvehicle thread scripts\common\vehicle_aianim::guy_unload(var_0, var_0.vehicle_position);
  var_0 waittill("jumpedout");
  var_0 setgoalpos(var_0.origin);
}

convoy_vehiclepathlogic(var_0) {
  scripts\common\vehicle_paths::gopath(var_0);
  thread convoy_vehiclealertedspeeduplogic(var_0);
  thread convoy_vehicledriverdeathlogic(var_0);

  while(!var_0 vehicle_getspeed())
    waitframe();

  var_0 setwaitspeed(0);
}

convoy_vehiclealertedspeeduplogic(var_0) {
  var_0 endon("reached_wait_speed");
  level waittill("ballistics_impact");
  waitframe();

  if(!var_0 vehicle_getspeed()) {
    return;
  }
  if(!isDefined(var_0.driver)) {
    return;
  }
  if(!isalive(var_0.driver)) {
    return;
  }
  var_0 vehicle_setspeed(30, 15, 15);
}

convoy_vehicledriverdeathlogic(var_0) {
  var_0 endon("reached_wait_speed");
  var_0 scripts\engine\utility::ent_flag_wait("loaded");
  var_0.driver waittill("death");

  if(!var_0 vehicle_getspeed()) {
    return;
  }
  var_0 vehicle_setspeed(0, 15, 15);
}

convoy_sfxlogic(var_0) {
  setmusicstate("mx_highway_multicar");
  var_0[0] playSound("scn_highway_convoy_incoming_dist_01");
  level scripts\engine\utility::waittill_any("ballistics_impact", "level_iedDetonated");
  setmusicstate("");
}

ambush_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var_1);
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_0, "intro_farahSceneCIdle");
  var_2 = level_spawnhadir();
  var_2 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var_3 = convoy_spawnvehicles();
  convoy_spawnenemiesinvehicles(var_3);
  var_4 = scripts\engine\utility::array_add(var_3, assassinate_spawnVehicle());

  foreach(var_6 in var_4) {
    var_7 = var_6 scripts\sp\maps\highway\highway_utility.gsc::get_lastentinspline(var_6.currentnode, ::getvehiclenode);
    var_6 vehicle_teleport(var_7.origin, var_7.angles);
    var_6 attachpath(var_7);
  }

  var_9 = [];

  foreach(var_6 in var_3)
  var_9 = scripts\engine\sp\utility::array_merge(var_9, var_6.riders);

  foreach(var_13 in var_9) {
    if(!scripts\engine\utility::is_equal(var_13.script_noteworthy, "convoy_enemyUnload")) {
      continue;
    }
    thread convoy_unloadenemylogic(var_13, 0);
  }

  var_15 = [];
  var_16 = getEntArray("convoy_animatedEnemy", "script_noteworthy");
  var_16 = scripts\sp\maps\highway\highway_utility.gsc::array_sortbyscriptindex(var_16);

  foreach(var_18 in var_16) {
    if(scripts\engine\utility::array_contains(var_15, var_18.ridingvehicle)) {
      continue;
    }
    var_15 = scripts\engine\utility::array_add(var_15, var_18.ridingvehicle);
  }

  while(var_15.size) {
    var_20 = var_15[0];

    foreach(var_18 in var_16) {
      if(!scripts\engine\utility::is_equal(var_18.ridingvehicle, var_20)) {
        continue;
      }
      thread convoy_unloadanimatedenemylogic(var_18);
    }

    var_15 = scripts\engine\utility::array_remove(var_15, var_20);
  }

  level_spawnredshirts();
  var_23 = tutorial_spawnallies();
  var_24 = tutorial_getallynodes();

  for(var_25 = 0; var_25 < var_23.size; var_25++)
    var_23[var_25] scripts\engine\sp\utility::teleport_ai(var_24[var_25]);

  tutorial_setalliesnames();
  thread ambush_iedlogic();
  scripts\engine\utility::flag_set("convoy_vehiclesStopped");
}

ambush_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("ambush");
  thread ambush_dialoguelogic();
  thread ambush_allieslogic();
  thread ambush_enemieslogic();
  scripts\sp\maps\highway\highway_utility.gsc::waittill_remainingenemycount(7);
  level notify("fallback_enemiesFallback");

  if(2)
    wait 2;
}

ambush_iedlogic() {
  level scripts\engine\utility::waittill_any("convoy_enemiesAtTruck", "ballistics_impact");
  var_0 = ambush_getied();
  var_0 thread scripts\sp\equipment\ied::ieddetonationlogic(level.player, 0.8, 75);
  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();
  var_1 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_AMBUSH_ENEMY_CONVOY", var_0.origin);
  var_2 = var_0.origin;
  var_0 waittill("detonated");
  thread scripts\engine\utility::play_sound_in_space("scn_highway_rigged_truck_expl", var_2);
  var_3 = assassinate_getvehicle();
  var_3 kill();
}

ambush_getied() {
  return getEnt("ambush_iedOrigin", "targetname");
}

ambush_triggeried() {
  var_0 = ambush_getied();
  var_0.interact delete();
  var_0 thread scripts\sp\equipment\ied::ieddetonate(var_0.origin, level.player);
}

ambush_dialoguelogic() {
  thread ambush_instructionsdialoguelogic();
  var_0 = level scripts\engine\utility::waittill_any_return("ballistics_impact", "level_iedDetonated");
  var_1 = convoy_getvehicles();
  var_2 = 0;

  foreach(var_4 in var_1)
  var_2 = var_2 + var_4 vehicle_getspeed();

  var_6 = level_getfarah();

  if(var_0 == "level_iedDetonated") {
    var_6 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_alert_10", 1.5);
    var_6 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_attack_10", 0.5);
  } else {
    if(var_2) {
      var_6 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_alert_10", 1);
      var_6 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_scout_alert_20", 1.5);
    }

    var_6 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_alert_10", 1.5);
  }

  level endon("reinforcements_vehiclesSpawned");
  childthread ambush_locationcalloutlogic();
  childthread ambush_enemyballistickillcalloutlogic();
  childthread ambush_enemybarrelkillcalloutlogic();
}

ambush_instructionsdialoguelogic() {
  level endon("ballistics_impact");
  level endon("level_iedDetonated");
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  scripts\engine\utility::flag_wait("convoy_vehiclesStopped");
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_watch_30", 5.0, level, "convoy_enemiesAtTruck");
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_watch_31", 8.0, level, "convoy_enemiesAtTruck");
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_convoy_watch_32", 9.0, level, "convoy_enemiesAtTruck");
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_watch_40", 11.0);
  level waittill("convoy_enemiesAtTruck");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_watch_70", 4.0);
  var_2 = ambush_getied();
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_watch_50", 0.75, var_2, "detonated");
  var_3 = 0.5;
  var_4 = lookupsoundlength("dx_vom_far_convoy_watch_50") * 0.001;
  var_5 = var_3 + var_4 + 5;
  var_6 = ["dx_vom_far_convoy_watch_60", "dx_vom_far_convoy_watch_80"];
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_6, 6, var_2, "detonated", var_5);
}

ambush_locationcalloutlogic() {
  var_0 = level_getfarah();
  var_1 = [];

  for(;;) {
    var_2 = ambush_getlocationvolumes();
    var_3 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");

    foreach(var_5 in var_2) {
      var_6 = 0;
      var_7 = ambush_getvolumelines(var_5);
      var_7 = scripts\engine\utility::array_remove_array(var_7, var_1);

      if(var_7.size) {
        foreach(var_9 in var_3) {
          if(length(var_9.velocity)) {
            continue;
          }
          if(var_9 istouching(var_5)) {
            var_10 = scripts\engine\utility::random(var_7);
            var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_10);
            var_1 = scripts\engine\utility::array_add(var_1, var_10);
            var_6 = 1;
            break;
          }
        }
      }

      if(var_6) {
        wait 8;
        break;
      }
    }

    waitframe();
  }
}

ambush_enemyballistickillcalloutlogic() {
  var_0 = level_getfarah();
  var_1 = ["dx_vom_far_convoy_backup_110", "dx_vom_far_sniper_kill_10", "dx_vom_far_tutorial_adjust_220"];
  var_2 = [var_0, var_0, var_0];
  var_3 = var_1;
  var_4 = var_2;
  var_5 = 8.0;

  for(;;) {
    var_6 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
    var_7 = scripts\sp\maps\highway\highway_utility.gsc::array_waittill_ballisticdeath(var_6);

    if(!var_3.size) {
      var_3 = var_1;
      var_4 = var_2;
    }

    var_8 = randomint(var_3.size);
    var_9 = var_3[var_8];
    var_10 = var_4[var_8];
    var_10 scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_9, 0.5);
    var_3 = scripts\engine\utility::array_remove_index(var_3, var_8);
    var_4 = scripts\engine\utility::array_remove_index(var_4, var_8);
    wait(var_5);
  }
}

ambush_enemybarrelkillcalloutlogic() {
  var_0 = level_getfarah();
  var_1 = ["dx_vom_far_convoy_multikill_10", "dx_vom_far_convoy_multikill_30", "dx_vom_far_convoy_multikill_20"];
  var_2 = [var_0, var_0, var_0];
  var_3 = 0;

  for(;;) {
    level waittill("red_barrel_explosion", var_4, var_5);

    if(var_5 < 2) {
      continue;
    }
    var_6 = var_1[var_3];
    var_7 = var_2[var_3];
    var_7 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_1[var_3], 2.0);
    var_3 = scripts\engine\math::wrap(0, var_1.size - 1, var_3 + 1);
  }
}

ambush_getvolumelines(var_0) {
  return strtok(var_0.script_parameters, " ");
}

ambush_getlocationvolumes() {
  return getEntArray("ambush_locationVolume", "targetname");
}

ambush_allieslogic() {
  level scripts\engine\utility::waittill_any("ballistics_impact", "level_iedDetonated");
  var_0 = tutorial_getallies();

  foreach(var_2 in var_0) {
    var_2 scripts\engine\sp\utility::set_ignoreall(0);
    var_2 scripts\engine\sp\utility::set_ignoreme(0);
  }

  var_4 = ambush_getallynodes();
  scripts\sp\maps\highway\highway_utility.gsc::ai_takecoveratnodes(var_0, var_4);
}

ambush_getallynodes() {
  return getnodearray("ambush_allyNode", "targetname");
}

ambush_enemieslogic() {
  level scripts\engine\utility::waittill_any("ballistics_impact", "level_iedDetonated");
  scripts\engine\sp\utility::autosave_by_name_silent("ambush_alerted");
  var_0 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
  var_1 = ambush_getenemycovernodes();

  foreach(var_3 in var_0) {
    var_3 scripts\engine\sp\utility::set_goalRadius(128);
    var_4 = scripts\engine\utility::random(var_1);
    var_5 = isDefined(var_3.ridingvehicle);
    var_6 = scripts\sp\maps\highway\highway_utility.gsc::math_getchance(85) && !isDefined(var_3.ridingvehicle);

    if(var_6 && !var_5)
      var_7 = "prone";
    else
      var_7 = undefined;

    thread ambush_enemylogic(var_3, var_5, var_4, var_7);
    var_1 = scripts\engine\utility::array_remove(var_1, var_4);
  }

  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(1, 1);
  wait 5.0;
  var_9 = ambush_spawnenemies();

  foreach(var_3 in var_9)
  thread ambush_enemylogic(var_3, 0);
}

ambush_spawnenemies() {
  var_0 = getspawnerarray("ambush_enemySpawner");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);

    if(!scripts\common\ai::spawn_failed(var_4))
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

ambush_getenemycovernodes() {
  return getnodearray("ambush_enemyCoverNode", "targetname");
}

ambush_getenemiesgoalvolume() {
  return getEnt("ambush_enemyVolume", "targetname");
}

ambush_enemylogic(var_0, var_1, var_2, var_3) {
  level endon("fallback_enemiesFallback");
  var_0 endon("death");
  var_0 scripts\common\utility::clear_demeanor_override();
  var_0 scripts\engine\sp\utility::set_ignoreall(0);
  var_0.vehiclerunexit = 1;

  if(var_1) {
    if(var_0.ridingvehicle vehicle_getspeed())
      var_0.ridingvehicle waittill("reached_wait_speed");
    else
      waitframe();

    var_0.ridingvehicle thread scripts\common\vehicle_aianim::guy_unload(var_0, var_0.vehicle_position);
  }

  if(isDefined(var_3)) {
    var_0 allowedstances(var_3);
    var_0 scripts\sp\maps\highway\highway_utility.gsc::ai_waittillinstance(var_3);
  }

  if(isDefined(var_2)) {
    var_0 setgoalnode(var_2);
    var_0 waittill("goal");
  }

  var_4 = ambush_getenemiesgoalvolume();
  var_0 setgoalvolumeauto(var_4);
}

fallback_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var_1);
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_0, "intro_farahSceneCIdle");
  var_2 = level_spawnhadir();
  var_2 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var_3 = convoy_spawnvehicles();
  var_3 = scripts\engine\utility::array_add(var_3, assassinate_spawnVehicle());

  foreach(var_5 in var_3) {
    var_6 = var_5 scripts\sp\maps\highway\highway_utility.gsc::get_lastentinspline(var_5.currentnode, ::getvehiclenode);
    var_5 vehicle_teleport(var_6.origin, var_6.angles);
    var_5 attachpath(var_6);
  }

  var_8 = convoy_getspawners();
  var_9 = fallback_getenemygoalvolume();
  var_10 = ambush_getenemycovernodes();

  for(var_11 = 0; var_11 < 7; var_11++) {
    var_12 = var_8[var_11] scripts\engine\sp\utility::spawn_ai(1);
    var_6 = scripts\engine\utility::random(var_10);
    var_10 = scripts\engine\utility::array_remove(var_10, var_6);
    var_12 forceteleport(var_6.origin, var_6.angles);
    var_12 setgoalvolumeauto(var_9);
  }

  var_13 = tutorial_spawnallies();
  var_14 = tutorial_getallynodes();

  for(var_15 = 0; var_15 < var_13.size; var_15++)
    var_13[var_15] scripts\engine\sp\utility::teleport_ai(var_14[var_15]);

  tutorial_setalliesnames();
  scripts\engine\utility::array_thread(var_13, scripts\engine\sp\utility::set_ignoreall, 0);
  level_spawnredshirts();
}

fallback_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("fallback");
  fallback_enemieslogic();
  scripts\sp\maps\highway\highway_utility.gsc::waittill_remainingenemycount(5);
}

fallback_enemieslogic() {
  fallback_spawnenemies();
  var_0 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
  var_1 = fallback_getenemygoalvolume();

  foreach(var_3 in var_0) {
    wait(randomfloatrange(0.25, 2.0));

    if(!scripts\sp\maps\highway\highway_utility.gsc::ai_isalive(var_3)) {
      continue;
    }
    var_3 scripts\sp\maps\highway\highway_utility.gsc::ai_resetstances();
    var_3 setgoalvolumeauto(var_1);
  }
}

fallback_spawnenemies() {
  var_0 = fallback_getspawners();

  foreach(var_2 in var_0)
  var_3 = var_2 scripts\engine\sp\utility::spawn_ai();
}

fallback_getenemygoalvolume() {
  return getEnt("fallback_enemyVolume", "targetname");
}

fallback_getspawners() {
  return getspawnerarray("fallback_enemySpawners");
}

fallback_getenemies() {
  return getEntArray("fallback_enemy", "targetname");
}

reinforcements_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var_1);
  scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_0, "intro_farahSceneCIdle");
  var_2 = level_spawnhadir();
  var_2 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var_3 = convoy_getspawners();
  var_4 = fallback_getenemygoalvolume();
  var_5 = getnodearray("fallback_enemyCoverNode", "targetname");

  for(var_6 = 0; var_6 < 5; var_6++) {
    var_7 = var_3[var_6] scripts\engine\sp\utility::spawn_ai();
    var_8 = scripts\engine\utility::random(var_5);
    var_5 = scripts\engine\utility::array_remove(var_5, var_8);
    var_7 forceteleport(var_8.origin, var_8.angles);
    var_7 setgoalvolumeauto(var_4);
  }

  var_9 = tutorial_spawnallies();
  scripts\engine\utility::array_thread(var_9, scripts\engine\sp\utility::set_ignoreall, 0);
  var_10 = convoy_spawnvehicles();
  var_10 = scripts\engine\utility::array_add(var_10, assassinate_spawnVehicle());

  foreach(var_12 in var_10) {
    var_8 = var_12 scripts\sp\maps\highway\highway_utility.gsc::get_lastentinspline(var_12.currentnode, ::getvehiclenode);
    var_12 vehicle_teleport(var_8.origin, var_8.angles);
    var_12 attachpath(var_8);
  }

  level_spawnredshirts();
}

reinforcements_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("reinforcements");
  var_0 = convoy_getvehicles();

  foreach(var_2 in var_0) {
    if(var_2.model != "veh8_mil_lnd_pindia_cream" && var_2.model != "veh8_mil_lnd_pindia_red") {
      continue;
    }
    earthquake(0.15, 0.7, level.player.origin, 9999);
    playrumbleonposition("damage_heavy", level.player.origin);
    playFX(level._effect["vfx_mortar_impact"], var_2.origin);
    var_2.vehicle_skipdeathmodel = 1;
    var_2 kill();
  }

  var_4 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");

  foreach(var_6 in var_4) {
    var_6 cleargoalvolume();
    var_6 setgoalpos(var_6.origin);
  }

  var_8 = reinforcements_spawnvehicles();
  thread reinforcements_allieslogic(var_8);
  thread reinforcements_vehicleslogic(var_8, 0);
  thread reinforcements_vehiclessfxlogic(var_8);
  thread reinforcements_vehiclesstoppedautosave(var_8);
  thread reinforcements_dialoguelogic(var_8);
}

reinforcements_dialoguelogic(var_0) {
  thread reinforcements_vehiclesdisableddialoguelogic();
  thread reinforcements_vehiclesunloadedlogic(var_0);
  var_1 = level_getfarah();
  var_2 = level_gethadir();
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_backup_21", 3.0);
  scripts\engine\utility::array_wait(var_0, "stopped_path");
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_backup_23", 3);
  var_3 = tutorial_getsignalally();
  var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_convoy_backup_24");
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_backup_25");
  var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_convoy_backup_ali_10", 2);
  level endon("vehicle_techoDisable");
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_backup_90", 2.0);
  var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_convoy_backup_70", 2.0);
}

reinforcements_vehiclesdisableddialoguelogic() {
  var_0 = level_getfarah();
  var_1 = ["dx_vom_far_convoy_backup_100", "dx_vom_far_convoy_backup_110", "dx_vom_far_convoy_backup_120"];
  var_2 = 0;

  for(;;) {
    level waittill("vehicle_techoDisable");
    var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_1[var_2], 1.0);
    var_2 = scripts\engine\math::wrap(0, var_1.size - 1, var_2 + 1);
  }
}

reinforcements_vehiclesunloadedlogic(var_0) {
  scripts\engine\utility::array_wait(var_0, "unloading");
  var_1 = level_gethadir();
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_convoy_backup_140", 3);
}

reinforcements_allieslogic(var_0) {
  level waittill("reinforcements_loaded");
  var_1 = tutorial_getallies();
  var_2 = reinforcements_getallypaths();

  foreach(var_4 in var_1) {
    var_4 scripts\engine\sp\utility::set_goalRadius(48);
    var_4 scripts\engine\sp\utility::set_ignoreall(1);
    var_4 scripts\engine\sp\utility::set_ignoreme(1);
    var_4.disablearrivals = 1;
    var_4.disableexits = 1;
    var_4.noragdoll = 1;
    var_5 = sortbydistance(var_2, var_4.origin)[0];
    var_4 thread scripts\sp\spawner::go_to_node(var_5);

    if(istrue(var_4.magic_bullet_shield))
      var_4 scripts\common\ai::stop_magic_bullet_shield();
  }

  var_7 = level_getfarah();
  var_7 scripts\common\utility::clear_demeanor_override();
  var_7 scripts\engine\sp\utility::set_ignoreall(0);
  var_7 scripts\engine\sp\utility::set_ignoreme(0);
  var_8 = level_getfarahtownnode();
  var_7 scripts\engine\sp\utility::set_goalRadius(32);
  var_7 setgoalnode(var_8);
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_7);
  var_9 = intro_getanimatedfarahscope();
  var_9 delete();
  var_10 = level_gethadir();
  var_10 scripts\common\utility::clear_demeanor_override();
  var_10 scripts\engine\sp\utility::set_ignoreall(0);
  var_10 scripts\engine\sp\utility::set_ignoreme(0);
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(64, 1);
  scripts\engine\utility::array_any_wait(var_1, "death");
  level notify("reinforcements_allyDeath");
}

reinforcements_spawnvehicles() {
  var_0 = vehicle_spawntechos("reinforcements_vehicleSpawner", "reinforcements_vehicle");

  foreach(var_2 in var_0)
  var_2 scripts\engine\utility::ent_flag_init("reinforcements_pickupEnemiesLoaded");

  level notify("reinforcements_vehiclesSpawned");
  return var_0;
}

reinforcements_getvehicles() {
  var_0 = vehicle_getarray();

  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::is_equal(var_2.targetname, "reinforcements_vehicle"))
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  return var_0;
}

reinforcements_vehicleslogic(var_0, var_1) {
  scripts\engine\utility::array_wait(var_0, "spawnedRiders");
  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();
  var_2 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_DISABLE_VEHICLES");
  objective_setzoffset(var_2, 100);
  var_3 = [];

  foreach(var_6, var_5 in var_0) {
    objective_setlocation(var_2, var_6, var_5);
    var_5 thread scripts\sp\maps\highway\highway_utility.gsc::call_on_notify_no_self("vehicle_disabled", ::objective_unsetlocation, var_2, var_6);
    var_3 = scripts\engine\sp\utility::array_merge(var_3, var_5.riders);
  }

  foreach(var_8 in var_3) {
    var_8.targetname = "reinforcements_enemy";

    if(scripts\engine\utility::is_equal(var_8.vehicle_position, 0) && !var_1)
      level.ballistics.ignoreentities = scripts\engine\utility::array_add(level.ballistics.ignoreentities, var_8);
  }

  var_10 = [];

  foreach(var_5 in var_0) {
    if(var_1) {
      var_5 scripts\engine\utility::ent_flag_set("reinforcements_pickupEnemiesLoaded");
      var_12 = var_5 scripts\sp\maps\highway\highway_utility.gsc::get_lastentinspline(var_5.currentnode, ::getvehiclenode);
      var_5 attachpath(var_12);
      var_5 scripts\common\vehicle::vehicle_unload();
      continue;
    }

    if(scripts\engine\utility::is_equal(var_5.script_noteworthy, "reinforcements_pickupEnemies"))
      var_10 = scripts\engine\utility::array_add(var_10, var_5);

    var_5 scripts\common\vehicle_paths::gopath();
  }

  if(!var_1) {
    scripts\engine\utility::array_wait(var_10, "stopped_path");
    var_14 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
    var_15 = scripts\engine\utility::array_remove_array(var_14, var_3);
    scripts\engine\utility::array_thread(var_14, scripts\common\utility::demeanor_override, "sprint");
    var_16 = floor(var_15.size / var_10.size);

    for(var_17 = 0; var_17 < var_10.size; var_17++) {
      var_15 = sortbydistance(var_15, var_10[var_17].origin);
      var_18 = var_17 == var_10.size - 1;

      if(var_18)
        var_19 = var_15;
      else {
        var_19 = [];

        for(var_20 = 0; var_20 < var_16; var_20++) {
          var_19 = scripts\engine\utility::array_add(var_19, var_15[var_20]);
          var_15 = scripts\engine\utility::array_remove(var_15, var_15[var_20]);
        }
      }

      var_10[var_17] thread scripts\common\vehicle::vehicle_load_ai(var_19, 0);
    }

    thread reinforcements_cleanupenemieslogic();
    scripts\engine\utility::array_ent_flag_wait(var_10, "loaded");
    scripts\engine\sp\utility::autosave_by_name_silent("reinforcements_loaded");
  }

  level notify("reinforcements_loaded");
  var_14 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");

  foreach(var_8 in var_14)
  thread level_enemyassaulttownlogic(var_8, 1);

  if(!var_1) {
    foreach(var_5 in var_0) {
      var_5 scripts\engine\utility::ent_flag_set("reinforcements_pickupEnemiesLoaded");
      thread vehicle_techodisablelogic(var_5);

      foreach(var_8 in var_5.riders) {
        if(scripts\engine\utility::array_contains(level.ballistics.ignoreentities, var_8))
          level.ballistics.ignoreentities = scripts\engine\utility::array_remove(level.ballistics.ignoreentities, var_8);

        if(istrue(var_8.drivingvehicle))
          thread reinforcements_driverdeathlogic(var_8, var_5);
      }
    }

    vehicle_waittillarraymoving(var_0);
    level notify("sfx_reinforcements_moving");

    foreach(var_5 in var_0)
    var_5 setwaitspeed(0);
  }
}

reinforcements_vehiclessfxlogic(var_0) {
  var_0[1] playSound("scn_highway_reinforcements_ridge_01");
  setmusicstate("mx_highway_reinforcements");
  level waittill("sfx_reinforcements_moving");
  wait 0.1;
  var_0[0] playSound("scn_highway_reinforcements_incoming_01");
  var_0[2] playSound("scn_highway_reinforcements_incoming_02");

  foreach(var_2 in var_0)
  thread reinforcements_vehicledoorsfxlogic(var_2);

  scripts\engine\utility::array_wait(var_0, "reached_wait_speed");
}

reinforcements_vehicledoorsfxlogic(var_0) {
  var_0 waittill("reached_wait_speed");
  var_0 playSound("scn_highway_truck_doors_open");
}

reinforcements_driverdeathlogic(var_0, var_1) {
  var_1 endon("vehicle_disabled");
  var_1 endon("reached_end_node");
  var_0 endon("jumpedout");
  var_0 waittill("death");
  var_2 = var_1 gettagorigin("tag_driver");
  var_1 notify("vehicle_disabled", var_2);

  if(var_1 vehicle_getspeed()) {
    var_1 vehicle_setspeed(0, 30, 30);
    var_1 setwaitspeed(0);
    var_1 waittill("reached_wait_speed");
    var_1 thread scripts\common\vehicle::vehicle_unload();
  }

  var_3 = level_getfarah();
  var_3 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_convoy_backup_64", 1.0);
}

reinforcements_vehiclesstoppedautosave(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::is_equal(var_3.script_noteworthy, "reinforcements_pickupEnemies"))
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  level waittill("reinforcements_loaded");
  vehicle_waittillarraymoving(var_0);
  scripts\engine\utility::array_wait(var_0, "reached_wait_speed");
  scripts\engine\sp\utility::autosave_by_name_silent("reinforcements_vehiclesStopped");
}

reinforcements_cleanupenemieslogic(var_0) {
  level endon("reinforcements_loaded");
  wait 5.0;
  var_1 = 0.2;
  var_2 = 0.4;
  var_3 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");

  foreach(var_5 in var_3) {
    if(isDefined(var_5.ridingvehicle)) {
      continue;
    }
    var_6 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("allies");
    var_7 = sortbydistance(var_6, var_5.origin)[0];
    magicbullet(var_7.weapon, var_7 gettagorigin("tag_flash"), var_5 getEye());
    playFX(level.g_effect["vfx_gib_explode"], var_5 getEye());
    var_5 kill();
    var_8 = randomfloatrange(var_1, var_2);
    wait(var_8);
  }
}

reinforcements_getenemies() {
  return getEntArray("reinforcements_enemy", "targetname");
}

reinforcements_getallypaths() {
  return scripts\engine\utility::getStructArray("reinforcements_allyPath", "targetname");
}

assault_start() {
  var_0 = level_spawnfarah();
  var_1 = level_spawnhadir();
  player_givefullloadout();
  var_2 = reinforcements_spawnvehicles();
  thread reinforcements_vehicleslogic(var_2, 1);
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(64, 1);
}

assault_main() {
  thread assault_enemieslogic();
  scripts\sp\maps\highway\highway_utility.gsc::waittill_remainingenemycount(6);
}

assault_enemieslogic() {
  var_0 = reinforcements_getvehicles();
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_3 scripts\engine\utility::ent_flag("reinforcements_pickupEnemiesLoaded"))
      var_1++;
  }

  var_5 = var_1 == var_0.size;

  if(!var_5) {
    scripts\engine\utility::array_ent_flag_wait(var_0, "reinforcements_pickupEnemiesLoaded");
    vehicle_waittillarraymoving(var_0);
  }

  scripts\engine\utility::array_wait(var_0, "unloaded");
  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();
  scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SURVIVE");
  var_6 = assault_getextraenemyspawners();
  var_7 = scripts\engine\sp\utility::array_spawn(var_6, 0, 1);
  thread assault_enemymagicmolotovgrenadelogic();

  foreach(var_9 in var_7)
  thread level_enemyassaulttownlogic(var_9, 0);
}

assault_enemymagicmolotovgrenadelogic() {
  level.player endon("death");
  level endon("mortars_fire");
  level.player endon("damage_fire");
  var_0 = 25.0;
  var_1 = 2.0;
  wait(var_0 - var_1);
  scripts\sp\maps\highway\highway_utility.gsc::player_waittillmaxhealth();
  var_2 = scripts\engine\utility::random(scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis"));

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = level_gethadir();
  var_3 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_cbc_had_inform_incoming_molotov");
  var_3 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_cbc_had_order_move_combat", 0.5);
  wait(var_1);
  var_4 = anglestoup(level.player.angles);
  var_5 = anglesToForward(level.player.angles);
  var_6 = level.player scripts\engine\utility::spawn_script_origin();
  var_6 thread scripts\sp\equipment\molotov::molotovexplode(level.player.origin, var_4, var_5, level.player, var_2);
}

assault_getextraenemyspawners() {
  return getspawnerarray("assault_enemySpawner");
}

mortars_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(64, 1);
}

mortars_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("mortars");
  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();
  var_0 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_ELIMINATE_MORTARS");
  thread mortars_farahdialoguehints();
  thread mortars_dialoguefeedbacklogic();
  thread mortars_mortarspawninglogic();
  setmusicstate("");
  level waittill("mortars_allCrewsDead");
  objective_delete(var_0);
}

mortars_mortarspawninglogic() {
  var_0 = mortars_getmodels();
  var_1 = 1;
  var_2 = 3.0;

  for(var_3 = 0; var_3 < 3; var_3++) {
    var_4 = var_0;

    foreach(var_6 in var_4) {
      if(!scripts\engine\utility::is_equal(var_6.script_index, var_3))
        var_4 = scripts\engine\utility::array_remove(var_4, var_6);
    }

    if(var_4.size)
      var_8 = scripts\engine\utility::random(var_4);
    else
      var_8 = scripts\engine\utility::random(var_0);

    thread mortars_modellogic(var_1, var_8, var_2);
    var_0 = scripts\engine\utility::array_remove(var_0, var_8);

    if(var_1)
      var_1 = 0;

    level waittill("mortars_crewDisabled");
    thread scripts\engine\sp\utility::autosave_now();
  }

  level notify("mortars_allCrewsDead");
}

mortars_farahdialoguehints() {
  level endon("mortars_crewDisabled");
  level waittill("mortars_impact");
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_mortar_reveal_10", 2);
  var_2 = player_getballisticsweaponobject();

  if(!level.player hasweapon(var_2)) {
    var_3 = ["dx_vom_far_mortar_reveal_60", "dx_vom_far_mortar_reveal_70", "dx_vom_far_mortar_reveal_80"];
    var_4 = 0;
    var_5 = 2;
    var_6 = 4;
    var_7 = scripts\sp\maps\highway\highway_utility.gsc::level_objectivegetindex();
    var_8 = player_getdroppedsniper();
    scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_GRAB_SNIPER", var_8.origin, &"HIGHWAY/LABEL_GRAB_SNIPER");
    objective_onentity(var_7, var_8);
    objective_setzoffset(var_7, 10);
    wait(var_5);

    while(!level.player hasweapon(var_2)) {
      var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_3[var_4]);
      var_4 = scripts\engine\math::wrap(0, var_3.size - 1, var_4 + 1);
      wait(var_6);
    }

    objective_delete(var_7);
  }

  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_mortar_reveal_41", 0.5);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_mortar_reveal_90", 2);
  mortars_dialoguewarningslogic();
}

mortars_dialoguewarningslogic() {
  level endon("mortars_allCrewsDead");
  var_0 = level_getfarah();
  var_1 = level_gethadir();

  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_ents_return(level, "mortars_zeroedInOnPlayer", level, "mortars_goingToKillPlayer");

    if(var_2 == "mortars_zeroedInOnPlayer") {
      var_3 = ["dx_vom_far_mortar_reveal_100", "dx_vom_far_mortar_reveal_110", "dx_vom_far_mortar_reveal_120"];
      var_4 = [var_0, var_0, var_1];
    } else {
      var_3 = ["dx_vom_had_mortar_reveal_130", "dx_vom_had_mortar_reveal_140"];
      var_4 = [var_1, var_0];
    }

    var_5 = randomint(var_3.size);
    var_6 = var_3[var_5];
    var_7 = var_4[var_5];
    var_7 scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_6);
  }
}

mortars_dialoguefeedbacklogic() {
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  var_2 = ["dx_vom_alx_mortar_team1_90", "dx_vom_alx_mortar_team2_110", "dx_vom_alx_mortar_team3_110"];
  var_3 = [level.player, level.player, level.player];
  var_4 = ["dx_vom_alx_mortar_team1_50", "dx_vom_alx_mortar_team2_70", "dx_vom_alx_mortar_team3_70"];
  var_5 = ["dx_vom_had_mortar_team2_20", "dx_vom_had_mortar_team3_10"];
  var_6 = [var_1, var_1];
  var_7 = 0;
  var_8 = 0;

  for(var_9 = 0; var_9 < 3; var_9++) {
    var_10 = var_9 == 2;

    if(!var_7) {
      if(var_10) {
        level.player thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_mortar_team3_30", 10.0, level, "mortars_crewSpotted");
        var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_tutorial_adjust_342", 12.0, level, "mortars_crewSpotted");
        var_11 = ["dx_vom_far_mortar_team3_40", "dx_vom_far_mortar_team3_50", "dx_vom_far_mortar_team3_60"];
        var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_11, 8, level, "mortars_crewSpotted", 13);
      }

      level waittill("mortars_crewSpotted");
    }

    var_7 = 0;
    level.player thread scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_4[var_8], 1.0);
    var_11 = ["dx_vom_far_mortar_team2_80", "dx_vom_far_mortar_team2_90", "dx_vom_far_mortar_team2_100"];
    var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_11, 8, level, "mortars_crewDisabled", 6);
    level waittill("mortars_crewDisabled");
    var_12 = var_3[var_8];
    var_13 = var_2[var_8];
    var_12 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_13, 1.5);
    var_14 = level scripts\engine\utility::waittill_any_return("mortars_fire", "mortars_crewSpotted");

    if(var_14 == "mortars_crewSpotted") {
      var_7 = 1;
      var_8 = scripts\engine\math::wrap(0, var_2.size - 1, var_8 + 1);
      continue;
    }

    if(var_10) {
      break;
    }

    var_15 = var_6[var_8];
    var_16 = var_5[var_8];
    var_15 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_16, 2.0);
    var_8 = scripts\engine\math::wrap(0, var_2.size - 1, var_8 + 1);
  }
}

mortars_modellogic(var_0, var_1, var_2) {
  var_1 endon("mortars_stop");
  var_1 show();
  var_1.animname = "mortars_mortar";
  var_1 scripts\common\anim::setanimtree();
  var_3 = getspawnerarray(var_1.target);
  var_4 = [];

  foreach(var_9, var_6 in var_3) {
    var_7 = var_6 scripts\engine\sp\utility::spawn_ai(1);
    var_8 = var_7 scripts\engine\utility::get_linked_nodes();
    var_7.crawlnode = scripts\engine\utility::random(var_8);
    var_7 scripts\engine\sp\utility::set_ignoreall(1);
    var_7.animname = "mortar_ai" + var_7.script_index;
    var_7.targetname = "mortars_enemy";
    var_7 allowedstances("prone");
    var_4 = scripts\engine\utility::array_add(var_4, var_7);
  }

  thread mortars_enemieslogic(var_4, var_1, var_2);
  childthread mortars_playerspottedlogic(var_1);
  var_10 = level.player.origin;
  var_11 = player_gettouchingtownrooftoptrigger();

  if(var_0)
    var_12 = 0;
  else
    var_12 = 1;

  for(;;) {
    if(var_0)
      var_13 = 500;
    else
      var_13 = 2500 - 500.0 * var_12;

    var_1 waittill("mortars_fire");

    if(var_12 == 5)
      level notify("mortars_goingToKillPlayer");

    thread mortars_firemortarprojectile(var_13, var_1);
    var_1 waittill("mortars_impact", var_14);
    var_15 = var_11;
    var_11 = player_gettouchingtownrooftoptrigger();
    var_16 = var_10;
    var_10 = level.player.origin;
    var_17 = isDefined(var_15);
    var_18 = isDefined(var_11);
    var_19 = distancesquared(level.player.origin, var_16);
    var_20 = var_19 >= 65536;

    if(var_17) {
      if(var_18)
        var_21 = var_11 != var_15;
      else
        var_21 = 1;
    } else if(var_18)
      var_21 = 1;
    else
      var_21 = var_20;

    var_22 = level_getredshirts();

    foreach(var_24 in var_22) {
      if(distancesquared(var_24.origin, var_14) > 262144) {
        continue;
      }
      if(istrue(var_24.magic_bullet_shield))
        var_24 scripts\common\ai::stop_magic_bullet_shield();

      var_24 scripts\engine\sp\utility::ai_ragdoll_immediate();
    }

    var_26 = var_12 == 5 && !var_21;
    var_27 = var_12 > 2;
    var_28 = var_27 || var_0;

    if(var_26)
      level.player kill();

    if(var_0) {
      var_29 = level_getheroes();

      foreach(var_31 in var_29)
      var_31 notify("flashbang", (0, 0, 0), 1, 1, level.player, "axis");

      var_4 = getaiarray("axis");
      var_33 = mortars_getenemies();
      var_4 = scripts\engine\utility::array_remove_array(var_4, var_33);
      scripts\engine\sp\utility::array_kill(var_4);
      scripts\engine\sp\utility::autosave_by_name("mortars_initial");
      playFX(level._effect["vfx_mortar_impact"], level.player.origin);
      physicsexplosionsphere(level.player.origin, 512, 256.0, 150);
      earthquake(0.4, 1.25, level.player.origin, 50000);
      playrumbleonposition("damage_heavy", level.player.origin);
      var_0 = 0;
    }

    if(var_28) {
      var_34 = level.player.health / level.player.damagemultiplier * 0.05;
      level.player scripts\sp\utility::do_damage(var_34, var_14);
      level.player scripts\engine\sp\utility::player_gesture_force("ges_frag_block");
      level.player scripts\engine\utility::delaycall(0.2, ::shellshock, "default_nosound", 4.0);
    }

    if(var_21) {
      var_12 = 1;
      continue;
    }

    if(var_27)
      level notify("mortars_zeroedInOnPlayer");

    var_12++;
  }
}

mortars_playerspottedlogic(var_0) {
  for(;;) {
    var_1 = anglesToForward(level.player getplayerangles());
    var_2 = vectorNormalize(var_0.origin - level.player getEye());
    var_3 = vectordot(var_1, var_2);

    if(player_sniperzoomedin() && var_3 >= 0.999962) {
      level notify("mortars_crewSpotted");
      break;
    }

    waitframe();
  }
}

mortars_enemieslogic(var_0, var_1, var_2) {
  var_3 = scripts\engine\sp\utility::spawn_anim_model("mortars_backpack");
  thread mortars_enemiesanimationlogic(var_1, var_0, var_3, var_2);
  mortars_enemieswaittillalerted(var_1, var_0);
  var_1 notify("mortars_stop");
  level notify("mortars_crewDisabled");
  var_4 = [var_1, var_3];

  foreach(var_6 in var_4) {
    scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_6);
    var_6 scripts\engine\sp\utility::anim_stopanimScripted();
  }

  var_0 = scripts\sp\maps\highway\highway_utility.gsc::array_removedeaddyingorundefined(var_0);

  foreach(var_9 in var_0)
  thread mortars_enemyreactlogic(var_1, var_9);
}

mortars_enemyreactlogic(var_0, var_1) {
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_1);
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 scripts\common\utility::clear_demeanor_override();
  var_1 allowedstances("prone");
  var_0 scripts\common\anim::anim_single_solo(var_1, "mortars_react");
  var_1 scripts\engine\sp\utility::set_goal_radius(512);
  var_1 setgoalnode(var_1.crawlnode);
}

mortars_enemiesanimationlogic(var_0, var_1, var_2, var_3) {
  var_0 endon("mortars_stop");
  var_4 = scripts\engine\utility::array_combine(var_1, [var_2], [var_0]);
  childthread scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_0, var_4, "mortars_idle");

  if(isDefined(var_3))
    wait(var_3);

  var_4 = scripts\engine\utility::array_combine(var_1, [var_0], [var_2]);
  var_5 = 7.0;
  var_6 = 9.0;

  for(;;) {
    scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_4);

    foreach(var_8 in var_1)
    level.scr_goaltime["mortar_ai" + var_8.script_index]["mortars_idle"] = 0.0;

    childthread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_0, var_4, "mortars_fire", "mortars_idle");
    scripts\engine\sp\utility::array_wait_match(var_1, "single anim", "mortars_fire");
    var_0 notify("mortars_fire");
    scripts\engine\sp\utility::array_wait_match(var_1, "single anim", "end");
    var_0 waittill("mortars_impact");
    var_10 = randomfloatrange(var_5, var_6);
    wait(var_10);
  }
}

mortars_enemieswaittillalerted(var_0, var_1) {
  var_0 endon("mortars_stop");

  foreach(var_3 in var_1) {
    var_3 endon("death");
    var_3 endon("entitydeleted");
  }

  for(;;) {
    level waittill("ballistics_impact");

    if(!player_sniperzoomedin()) {
      continue;
    }
    var_5 = anglesToForward(level.player getgunangles());
    var_6 = vectorNormalize(var_0.origin - level.player getEye());
    var_7 = vectordot(var_5, var_6);

    if(var_7 < 0.999962) {
      continue;
    }
    break;
  }
}

mortars_getenemies() {
  return getEntArray("mortars_enemy", "targetname");
}

mortars_firemortarprojectile(var_0, var_1) {
  level notify("mortars_fire");
  thread mortars_mortarinairflaglogic(var_1);
  var_2 = scripts\engine\trace::create_world_contents();
  var_3 = (0, 0, -1);
  var_4 = level.player.origin + anglesToForward(level.player.angles) * var_0;
  var_4 = var_4 + scripts\engine\utility::randomvector(300);
  var_4 = var_4 + (0, 0, 512);
  var_5 = var_4 + var_3 * (var_4 * 2);
  var_6 = var_1.origin;
  var_7 = scripts\engine\trace::ray_trace(var_4, var_5, undefined, var_2)["position"];
  thread scripts\engine\utility::play_sound_in_space("weap_mortar_fire_dist", var_6);
  physicsexplosionsphere(var_6, 350, 350, 200);
  var_8 = spawn("script_model", var_6);
  var_8 setModel("equipment_mortar_shell_improvised_01");
  playFX(level._effect["vfx_mortar_fire"], var_6, anglesToForward(var_1.angles));
  playFXOnTag(level._effect["vfx_mortar_trail"], var_8, "tag_origin");
  var_9 = lookupsoundlength("weap_mortar_incoming") * 0.001 * 0.8;
  var_10 = max(0.05, 7 - var_9 - 0.5);
  var_8 scripts\engine\utility::delaythread(var_10, scripts\engine\utility::playsoundontag, "weap_mortar_incoming", "tag_origin");
  var_8 playLoopSound("weap_mortar_fly_lp");
  var_11 = 0.00714286;
  var_12 = 0;

  while(var_12 < 1) {
    var_13 = var_8.origin;
    var_8.origin = scripts\engine\math::get_point_on_parabola(var_6, var_7, 3000, var_12);
    var_14 = var_12 * 2 - 1;
    var_15 = (var_14 * var_14 * -1 + 1) * 600;
    var_16 = vectorNormalize(level.ballistics.wind);
    var_8.origin = var_8.origin + var_16 * var_15;
    var_8.angles = vectortoangles(var_8.origin - var_13);
    var_12 = var_12 + var_11;
    waitframe();
  }

  var_8 stoploopsound("weap_mortar_fly_lp");
  mortars_explodemortarprojectile(var_8, 1, var_1);
}

mortars_explodemortarprojectile(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_0 delete();

  if(var_1) {
    if(level.player playerads())
      var_4 = 0.09;
    else
      var_4 = 0.4;

    physicsexplosionsphere(var_3, 512, 256.0, 150);
    earthquake(var_4, 1.25, var_3, 50000);
    playrumbleonposition("damage_heavy", var_3);
    thread mortars_explodemortarsfx(var_3);
  }

  playFX(level._effect["vfx_mortar_impact"], var_3);
  scripts\engine\utility::exploder("vfx_dust_interior");
  var_2 notify("mortars_impact", var_3);
  level notify("mortars_impact", var_3);
}

mortars_mortarinairflaglogic(var_0) {
  level endon("mortars_fire");
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(2, 1);
  var_0 waittill("mortars_impact");
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(2, 0);
}

mortars_explodemortarsfx(var_0) {
  var_1 = spawn("script_origin", var_0 + (0, 0, 1));
  var_1 playexplosionsound("weap_mortar_expl_trans", "exp");
  wait 8.0;
  var_1 delete();
}

mortars_getmodels() {
  return getEntArray("mortars_model", "targetname");
}

suicide_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(64, 1);
}

suicide_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("suicide");
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(64, 0);
  var_0 = suicide_spawnVehicle();
  thread vehicle_suicidetrucklogic(var_0);
  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();
  var_1 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_STOP_SUICIDE_TRUCK");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 100);
  thread suicide_playersawvehiclelogic(var_0);
  thread suicide_dialoguelogic(var_0);
  var_0 waittill("vehicle_disabled");
  level_openbunkerouterdoor();
  var_2 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("allies");

  foreach(var_4 in var_2) {
    var_4 scripts\asm\asm_bb::bb_setcovernode(undefined);
    var_4 scripts\engine\sp\utility::set_goal_pos(var_4.origin);
    var_4 scripts\sp\maps\highway\highway_utility.gsc::ai_resetstances();
    var_4 scripts\common\utility::demeanor_override("casual_gun");
  }

  var_6 = level_gethadir();
  var_7 = getnode("suicide_hadirNode", "targetname");
  var_6 scripts\engine\sp\utility::set_goal_node(var_7);
  var_8 = level_getfarah();
  var_9 = getnode("suicide_farahNode", "targetname");
  var_8 scripts\engine\sp\utility::set_goal_node(var_9);
  level waittill("vehicle_suicideShellshockOver");
  objective_delete(var_1);
  var_1 = level_addmissionnarrativeobjective();
  var_8 = level_getfarah();
  var_8 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_svbied_truck_120", 2);

  if(0.5)
    wait 0.5;

  objective_delete(var_1);
}

suicide_playersawvehiclelogic(var_0) {
  level.player endon("death");
  var_1 = gettime() + 5000;

  for(;;) {
    if(gettime() >= var_1) {
      break;
    }

    var_2 = level.player getEye();
    var_3 = var_0.origin;
    var_4 = player_fullads();
    var_5 = scripts\engine\utility::within_fov(var_2, level.player getgunangles(), var_3, 0.999391);
    var_6 = sighttracepassed(var_2, var_3, 0, var_0, 1);

    if(var_4 && var_5 && var_6) {
      break;
    }

    waitframe();
  }

  level notify("suicide_playerSawVehicle");
}

suicide_dialoguelogic(var_0) {
  level.player endon("death");
  thread suicide_dialoguehintslogic(var_0);
  var_1 = level_getfarah();
  var_2 = level_gethadir();
  level waittill("suicide_playerSawVehicle");
  thread suicide_musiclogic();
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_svbied_truck_10", 1.0, var_0, "vehicle_disabled");
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_svbied_truck_30", 7, var_0, "vehicle_disabled");
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_svbied_truck_40", 12, var_0, "vehicle_disabled");
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_svbied_truck_90", 18, var_0, "vehicle_disabled");
  var_2 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_svbied_truck_60", 22, var_0, "vehicle_disabled");
  var_2 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_svbied_truck_100", 27, var_0, "vehicle_disabled");
}

suicide_dialoguehintslogic(var_0) {
  var_0 endon("vehicle_disabled");
  var_1 = level_getfarah();
  level waittill("vehicle_suicideTruckArmorBreak");
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_svbied_truck_70", 0.5);
}

suicide_spawnVehicle() {
  return vehicle_spawnsuicidetruck("suicide_vehicleSpawner", "suicide_vehicle");
}

suicide_getvehicles() {
  var_0 = vehicle_getarray();

  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::is_equal(var_2.targetname, "suicide_vehicle"))
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  return var_0;
}

restock_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_openbunkerouterdoor();
  level_spawnredshirts();
  var_0 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("allies");
  scripts\engine\utility::array_thread(var_0, scripts\common\utility::demeanor_override, "casual_gun");
}

restock_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("restock");
  thread restock_dialoguelogic();
  thread restock_allieslogic();
  thread restock_playerlogic();
  level waittill("restock_playerAtBunker");
  thread restock_setupradioally();
  scripts\engine\utility::flag_wait("restock_playerLeftBunker");
  var_0 = level_addmissionnarrativeobjective();

  if(12)
    wait 12;

  objective_delete(var_0);
}

restock_dialoguelogic() {
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  thread restock_dialoguesectionalogic(var_0, var_1);
  var_2 = ["dx_vom_far_mines_setup_40", "dx_vom_far_mines_setup_50", "dx_vom_far_mines_setup_60"];
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_2, 10, level, "restock_playerAtBunker", 30);
  level waittill("restock_playerLeftBunker");
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_resupply_ieds_00", 1.0);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_resupply_ieds_10");
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_resupply_ieds_20");
}

restock_dialoguesectionalogic(var_0, var_1) {
  level endon("restock_playerLeftBunker");
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_mines_setup_10");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_mines_setup_20", 0.5);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_mines_setup_30", 0.5);
}

restock_allieslogic() {
  level_setredshirtgoalamount(4);
  var_0 = 5.0;
  wait(var_0);
  var_1 = level_gethadir();
  var_2 = scripts\engine\utility::getStruct("restock_hadirAnimationStruct", "targetname");
  var_3 = getnode("restock_hadirNode", "targetname");
  var_1 scripts\engine\utility::set_movement_speed(56);
  thread restock_plantingallylogic(var_1, var_2, var_3, 7.0, "restock_hadirIED");
  var_0 = 3.0;
  wait(var_0);
  var_4 = level_getfarah();
  var_5 = scripts\engine\utility::getStruct("restock_farahAnimationStruct", "targetname");
  var_6 = getnode("restock_farahNode", "targetname");
  var_4 scripts\engine\utility::set_movement_speed(56);
  thread restock_plantingallylogic(var_4, var_5, var_6, 0.0, "restock_farahIED");
}

restock_plantingallylogic(var_0, var_1, var_2, var_3, var_4) {
  var_0 scripts\engine\sp\utility::set_goalRadius(4);

  if(!scripts\engine\utility::flag("restock_playerLeftBunker")) {
    thread restock_allyplace(var_0, var_1, var_4);
    scripts\engine\utility::flag_wait("restock_playerLeftBunker");
  }

  if(istrue(var_3)) {
    scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_0);
    scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_0, "restock_idle");
    wait(var_3);
  }

  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_0);
  var_1 scripts\common\anim::anim_single_solo(var_0, "restock_exit");
  var_0 setgoalnode(var_2);
}

restock_allyplace(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  level endon("restock_playerLeftBunker");
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_reach(var_1, var_0, "restock_enter");
  var_3 = scripts\engine\utility::waittill_any_ents_return(var_0, "goal", level, "restock_playerAtBunker");
  var_4 = scripts\engine\sp\utility::spawn_anim_model(var_2);
  scripts\sp\maps\highway\highway_utility.gsc::animation_single(var_1, [var_0, var_4], "restock_enter");
  level.player thread scripts\sp\equipment\ied::iedfiremain(var_4);

  if(!scripts\engine\utility::flag("restock_playerLeftBunker"))
    scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_1, var_0, "restock_idle");
}

restock_playerlogic() {
  var_0 = scripts\sp\maps\highway\highway_utility.gsc::level_objectivegetindex();
  scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_RESUPPLY", (825.25, -2040.5, 928), &"HIGHWAY/LABEL_RESUPPLY");
  thread scripts\sp\player::focus_display_hint(11, undefined, level, "restock_playerAtBunker");
  var_1 = level_getbunkervolume();

  while(!level.player istouching(var_1))
    waitframe();

  level notify("restock_playerAtBunker");
  restock_preplaceieds();

  while(level.player istouching(var_1))
    waitframe();

  objective_delete(var_0);
  var_2 = player_getballisticsweaponobject();

  if(!level.player hasweapon(var_2)) {
    var_3 = ["dx_vom_far_intro_gun_160", "dx_vom_far_intro_gun_165", "dx_vom_far_intro_gun_170"];
    var_4 = level_getfarah();
    var_4 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_3, 8, level, "restock_playerLeftBunker", 2);
    var_0 = scripts\sp\maps\highway\highway_utility.gsc::level_objectivegetindex();
    var_5 = player_getdroppedsniper();
    scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_GRAB_SNIPER", var_5.origin, &"HIGHWAY/LABEL_GRAB_SNIPER");
    objective_onentity(var_0, var_5);
    thread scripts\sp\player::focus_display_hint(8, undefined, level, "restock_playerLeftBunker");

    for(;;) {
      if(!level.player istouching(var_1) && level.player hasweapon(var_2)) {
        break;
      }

      waitframe();
    }

    objective_delete(var_0);
  }

  scripts\engine\utility::flag_set("restock_playerLeftBunker");
}

restock_connectiedpaths() {
  var_0 = scripts\engine\utility::getStructArray("restock_preplacedIED", "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.target)) {
      continue;
    }
    var_3 = getEntArray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      var_6 = var_5.spawnflags & 1;

      if(!var_6) {
        continue;
      }
      var_5 connectpaths();
    }
  }
}

restock_preplaceieds() {
  var_0 = scripts\engine\utility::getStructArray("restock_preplacedIED", "targetname");

  foreach(var_2 in var_0) {
    var_3 = restock_preplaceied(var_2.origin, var_2.angles);

    if(!isDefined(var_2.target)) {
      continue;
    }
    var_4 = getEntArray(var_2.target, "targetname");
    var_5 = getscriptablearray(var_2.target, "targetname");
    var_4 = scripts\engine\utility::array_remove_array(var_4, var_5);
    thread restock_replacediedlogic(var_3, var_4, var_5, var_2.radius);
  }
}

restock_preplaceied(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("weapon_wm_bomb_ied_bomb");
  level.player thread scripts\sp\equipment\ied::iedfiremain(var_2);
  return var_2;
}

restock_replacediedlogic(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;
  var_0 waittill("detonated");

  foreach(var_6 in var_1) {
    var_7 = var_6.spawnflags & 1;

    if(var_7)
      var_6 disconnectPaths();

    if(istrue(var_6.script_delete)) {
      var_6 delete();
      continue;
    }

    var_6 physicslaunchserver(var_6.origin - (0, 0, 10), (0, 0, 9500));
  }

  foreach(var_10 in var_2) {
    if(istrue(var_10.script_delete)) {
      var_10 delete();
      continue;
    }

    var_10 setscriptablepartstate("base", "explosion");
  }

  if(isDefined(var_3))
    createnavbadplacebybounds(var_4, (var_3, var_3, var_3), (0, 0, 0));
}

restock_getiedpathentities() {
  return getEntArray("restock_IEDPaths", "script_noteworthy");
}

restock_getfarahnode() {
  return getnode("restock_farahNode", "targetname");
}

restock_gethadirnode() {
  return getnode("restock_hadirNode", "targetname");
}

restock_getredshirtnodes() {
  return getnodearray("restock_redShirtNode", "targetname");
}

restock_setupradioally() {
  var_0 = radio_spawnradioally();
  var_1 = level_gettownanimationstruct();
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_reachtoidle(var_1, var_0, "radio_allyEnterIdle");
}

radio_start() {
  level_spawnhadir();
  var_0 = level_spawnfarah();
  var_1 = restock_getfarahnode();
  var_0 forceteleport(var_1.origin, var_1.angles);
  var_0 scripts\engine\sp\utility::set_goalRadius(4);
  var_0 setgoalnode(var_1);
  player_givefullloadout();
  level_setredshirtgoalamount(4);
  level_spawnredshirts();
  var_2 = level_getredshirts();
  var_3 = restock_getredshirtnodes();

  foreach(var_5 in var_2) {
    var_6 = sortbydistance(var_3, var_5.origin)[0];

    if(!isDefined(var_6)) {
      break;
    }

    var_5 scripts\engine\sp\utility::teleport_ai(var_6);
    var_5 scripts\engine\sp\utility::set_goalRadius(64);
    var_3 = scripts\engine\utility::array_remove(var_3, var_6);
  }

  thread restock_setupradioally();
  restock_preplaceieds();
  scripts\engine\sp\utility::set_start_location("start_sniper", [level.player]);
}

radio_main() {
  level.player endon("death");
  scripts\engine\sp\utility::autosave_by_name_silent("radio");
  var_0 = radio_getinteractstruct();
  var_1 = level_getfarah();
  var_2 = radio_getradioally();
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_sniper_radio_10");
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_sniper_radio_20");
  thread scripts\sp\player::focus_display_hint(1.0);
  var_3 = ["dx_vom_far_sniper_radio_30", "dx_vom_far_sniper_radio_40", "dx_vom_far_sniper_radio_50"];
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_3, 13, level, "radio_playerNearAI", 13);
  var_4 = level_getredshirts();
  scripts\engine\utility::array_thread(var_4, scripts\common\utility::clear_demeanor_override);
  var_2 scripts\common\utility::clear_demeanor_override();
  var_5 = var_0.origin + (0, 0, 10);
  var_6 = scripts\sp\maps\highway\highway_utility.gsc::level_objectivegetindex();
  scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_CONTACT_CAPTAIN_PRICE", var_5, &"HIGHWAY/LABEL_RADIO");
  thread scripts\sp\player::focus_display_hint(10, undefined, level, "radio_playerNearAI");
  thread radio_waittillplayernearradio(var_0, 200, 0.939693);
  level waittill("radio_playerNearAI");
  var_7 = level_gettownanimationstruct();
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_2);
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintoloop(var_7, var_2, "radio_allyEnter", "radio_allyIdle");
  var_2 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_fsa1_sniper_radio_55");
  var_8 = scripts\engine\utility::spawn_tag_origin(var_0.origin);
  var_8 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HIGHWAY/CURSOR_CONTACT_CAPTAIN_PRICE", undefined, undefined, 55);
  var_8 waittill("trigger");
  objective_delete(var_6);
  var_6 = level_addmissionnarrativeobjective();
  level.player scripts\engine\sp\utility::set_player_demeanor("safe");
  var_9 = scripts\engine\utility::spawn_script_origin(var_8.origin, var_8.angles);
  var_9.name = "Cpt. Price";
  var_9.animname = "price";
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_sniper_radio_60", 0.25);
  var_9 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_pri_sniper_radio_70", 0.2);
  level.player thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_sniper_combat_15", 6);
  var_9 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_pri_sniper_combat_20", 8.5);

  if(1.0)
    wait 1.0;

  var_2.targetname = "level_redShirt";
  var_10 = level_redshirtgetclosestonscreen();
  var_11 = var_10 getEye();
  var_12 = sniper_getenemynodes();
  var_13 = scripts\engine\utility::random(var_12);
  sniper_fireshot(var_13, var_11);
  var_11 = var_10 getEye();

  if(getdvarint("NTMLLPTNLT"))
    playFX(level.g_effect["vfx_gib_explode"], var_11);

  thread scripts\engine\utility::play_sound_in_space("gib_fullbody", var_11);
  thread sniper_playerscreenbloodeffectlogic(var_11);
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_2);
  var_2 scripts\engine\sp\utility::anim_stopanimScripted();
  var_2 scripts\common\ai::stop_magic_bullet_shield();
  setmusicstate("mx_highway_sniper_death");

  if(var_2 == var_10) {
    var_2.diequietly = 1;
    var_2.skipdeathanim = 1;
    var_2 thread[[level.aigibfunction]](var_2, var_11, "MOD_RIFLE_BULLET");
  } else
    var_2 thread[[level.aigibfunction]](var_10, var_11, "MOD_RIFLE_BULLET");

  var_14 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("allies");

  foreach(var_16 in var_14)
  var_16 allowedstances("prone");

  var_18 = radio_getallypronenodes();
  scripts\sp\maps\highway\highway_utility.gsc::ai_takecoveratnodes(var_14, var_18);
  wait 0.15;
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.player scripts\engine\sp\utility::player_gesture_force("ges_frag_block");
  var_19 = level_getheroes();
  scripts\engine\utility::array_thread(var_19, scripts\common\utility::clear_demeanor_override);
  objective_delete(var_6);
}

radio_getallypronenodes() {
  return getnodearray("radio_allyProneNode", "targetname");
}

radio_radioallysurvivedlogic(var_0) {
  var_0 endon("death");
  var_0 scripts\engine\sp\utility::set_goalRadius(4);
  var_1 = radio_getradioallynode();
  var_0 setgoalnode(var_1);
  var_0 waittill("goal");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::ai_resetstances();
}

radio_spawnradioally() {
  var_0 = getspawner("radio_allySpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.targetname = "radio_ally";
  var_1.animname = "radio_ally";
  var_1 scripts\common\ai::magic_bullet_shield();
  var_1 setModel("body_sla_rebels_lmg_2_1");
  scripts\sp\maps\highway\highway_utility.gsc::ai_attachhead(var_1, "head_sc_m_ahmadzai_civ");

  if(isDefined(var_1.hatmodel))
    var_1 detach(var_1.hatmodel);

  var_1.hatmodel = undefined;
  return var_1;
}

radio_getradioally() {
  return getEnt("radio_ally", "targetname");
}

radio_getradioallynode() {
  return getnode("radio_radioAllyNode", "targetname");
}

radio_waittillplayernearradio(var_0, var_1, var_2) {
  var_3 = var_1 * var_1;

  for(;;) {
    waitframe();
    var_4 = distancesquared(level.player.origin, var_0.origin);

    if(var_4 > var_3) {
      continue;
    }
    var_5 = sighttracepassed(level.player getEye(), var_0.origin, 0, level.player, 1);

    if(!var_5) {
      continue;
    }
    var_6 = anglesToForward(level.player getplayerangles());
    var_7 = vectorNormalize(var_0.origin - level.player getEye());
    var_8 = vectordot(var_6, var_7);
    var_9 = var_8 >= var_2;

    if(!var_9) {
      continue;
    }
    break;
  }

  level notify("radio_playerNearAI");
}

radio_getinteractstruct() {
  return scripts\engine\utility::getStruct("radio_interactStruct", "targetname");
}

sniper_start() {
  var_0 = level_spawnfarah();
  var_1 = level_spawnhadir();
  player_givefullloadout();
  level_setredshirtgoalamount(4);
  level_spawnredshirts();
  var_2 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("allies");
  var_3 = radio_getallypronenodes();

  foreach(var_5 in var_2) {
    if(scripts\common\ai::spawn_failed(var_5)) {
      continue;
    }
    var_5 allowedstances("prone");
    var_6 = sortbydistance(var_3, var_5.origin)[0];

    if(!isDefined(var_6)) {
      break;
    }

    var_5 scripts\engine\sp\utility::teleport_ai(var_6);
    var_5 scripts\engine\sp\utility::set_goalRadius(64);
    var_3 = scripts\engine\utility::array_remove(var_3, var_6);
  }

  restock_preplaceieds();
  scripts\engine\sp\utility::set_start_location("start_sniper", [level.player]);
}

sniper_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("sniper");
  var_0 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_ELIMINATE_ENEMY_SNIPER");
  thread sniper_windshiftlogic();
  thread sniper_allieslogic();
  var_1 = sniper_spawnenemy();
  thread sniper_enemylogic(var_1);
  thread sniper_dialoguelogic(var_1);
  var_1 waittill("death");
  thread sniper_postdeathlogic(var_0);
}

sniper_postdeathlogic(var_0) {
  setmusicstate("");
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_sniper_relocate_60", 1.0);
  var_1 = level_getfarah();
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_sniper_kill_10", 1.0);
  objective_delete(var_0);
}

sniper_allieslogic() {
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(32, 0);
}

sniper_windshiftlogic(var_0) {
  if(istrue(var_0))
    wait(var_0);

  var_1 = wind_getrandomdirectionindex();
  wind_setdirection(var_1, 2000, 1);
}

sniper_dialoguelogic(var_0) {
  var_0 endon("death");
  level.player endon("death");
  var_1 = level_getfarah();
  var_2 = level_gethadir();
  childthread sniper_dialoguesightedlogic(var_0);
  childthread sniper_dialoguerelocatelogic();
  childthread sniper_dialogueintrologic();
  var_3 = ["dx_vom_had_sniper_combat_45", "dx_vom_far_sniper_combat_150", "dx_vom_had_sniper_combat_47"];
  var_4 = [var_2, var_1, var_2];
  var_5 = 1.5;
  var_6 = 0;
  var_7 = ["dx_vom_far_sniper_combat_83", "dx_vom_far_sniper_combat_81", "dx_vom_far_sniper_combat_88"];
  var_8 = 0;
  var_9 = 8;
  var_10 = ["dx_vom_far_sniper_nags_10", "dx_vom_far_sniper_nags_20", "dx_vom_far_sniper_nags_30"];
  var_11 = 0;

  for(;;) {
    var_12 = scripts\engine\utility::waittill_any_ents_or_timeout_return(var_9, level, "sniper_redShirtDeath", level, "sniper_enemyRelocating");

    if(scripts\engine\utility::is_equal(var_12, "timeout")) {
      if(player_sniperzoomedin() && !sniper_playerlookingatenemy(var_0)) {
        var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_10[var_11]);
        var_11 = scripts\engine\math::wrap(0, var_10.size - 1, var_11 + 1);
      } else {
        var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_7[var_8]);
        var_8 = scripts\engine\math::wrap(0, var_7.size - 1, var_8 + 1);
      }

      continue;
    }

    if(scripts\engine\utility::is_equal(var_12, "sniper_redShirtDeath")) {
      var_4[var_6] thread scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_3[var_6], var_5);
      var_6 = scripts\engine\math::wrap(0, var_3.size - 1, var_6 + 1);
      continue;
    }

    if(scripts\engine\utility::is_equal(var_12, "sniper_enemyRelocating"))
      level waittill("sniper_enemyRelocated");
  }
}

sniper_dialoguesightedlogic(var_0) {
  var_1 = 0;
  var_2 = 500;

  for(;;) {
    var_3 = anglesToForward(level.player getplayerangles());
    var_4 = vectorNormalize(var_0.origin - level.player getEye());
    var_5 = vectordot(var_3, var_4);

    if(player_sniperzoomedin() && var_5 >= 0.999962) {
      if(!var_1)
        var_1 = gettime();

      if(gettime() >= var_1 + var_2) {
        break;
      }
    } else
      var_1 = 0;

    waitframe();
  }

  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_sniper_combat_120");
}

sniper_dialogueintrologic() {
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_sniper_combat_10", 1.5);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_sniper_combat_40", 0.75);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_sniper_combat_42", 1.0);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_sniper_combat_50", 4.0);
}

sniper_dialoguerelocatelogic() {
  level waittill("sniper_enemyRelocating");
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_sniper_wind_10", 1.0);
  var_0 = level_getfarah();
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_sniper_wind_40", 1.0);

  if(level.ballistics.winddirectionaimstring == "left")
    var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_sniper_wind_80");
  else
    var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_sniper_wind_60");

  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_sniper_relocate_34", 1.0);

  for(;;) {
    level waittill("sniper_enemyRelocating");
    level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_sniper_relocate_10", 1.0);
  }
}

sniper_enemylogic(var_0) {
  var_0 allowedstances("crouch");
  thread sniper_enemyglinton(var_0);
  var_1 = sniper_getenemynodes();
  var_2 = scripts\engine\utility::random(var_1);
  var_0 scripts\engine\sp\utility::teleport_ai(var_2);
  var_0 scripts\engine\sp\utility::set_goalRadius(4);
  thread sniper_combatlogic(var_0, var_2);
}

sniper_enemyglinton(var_0) {
  playFXOnTag(level._effect["vfx_sniper_glint"], var_0, "tag_flash");
  scripts\engine\utility::waittill_any_ents(var_0, "death", level, "sniper_enemyRelocating");

  if(!isDefined(var_0)) {
    return;
  }
  if(!var_0 tagexists("tag_flash")) {
    return;
  }
  stopFXOnTag(level._effect["vfx_sniper_glint"], var_0, "tag_flash");
}

sniper_combatlogic(var_0, var_1) {
  var_0 endon("death");
  level.player endon("death");
  childthread sniper_enemyspottedlogic(var_0);
  childthread sniper_killplayerlogic(var_0);
  thread sniper_enemytargetentitylogic(var_0);
  var_2 = 5.5;
  var_3 = 6.5;
  var_4 = 0;
  var_5 = min(4, level_getredshirts().size);
  var_6 = 1;
  var_7 = 0;
  var_8 = 3;

  for(;;) {
    var_9 = randomfloatrange(var_2, var_3);
    var_10 = var_7 >= var_8;

    if(var_10) {
      wait(var_9);
      var_11 = "timeout";
    } else
      var_11 = level scripts\engine\utility::waittill_notify_or_timeout_return("sniper_enemySpotted", var_9);

    if(scripts\engine\utility::is_equal(var_11, "timeout")) {
      var_12 = undefined;

      if(var_4 >= var_5)
        var_12 = level.player;
      else {
        var_13 = level_redshirtgetclosestonscreen();

        if(!isDefined(var_13)) {
          var_14 = level_getredshirts();
          var_14 = sortbydistance(var_14, level.player getEye());
          var_12 = var_14[0];
        } else
          var_12 = var_13;
      }

      if(isDefined(var_12))
        var_15 = var_12 getEye();
      else
        var_15 = level.player getEye() + (0, 0, 10);

      thread sniper_fireshot(var_0, var_15);
      var_4++;
      var_10 = var_7 >= var_8;

      if(var_10) {
        level waittill("sniper_enemySpotted");
        var_11 = "sniper_bulletImpact";
      } else
        var_11 = level scripts\engine\utility::waittill_any_return("sniper_enemySpotted", "sniper_bulletImpact");

      if(scripts\engine\utility::is_equal(var_11, "sniper_enemySpotted")) {
        var_16 = var_1 scripts\engine\utility::get_linked_nodes()[0];
        childthread sniper_enemyrelocate(var_0, var_1, var_16);
        var_7++;
        var_4 = int(max(0, var_4 - var_6));
        var_1 = var_16;
        level waittill("sniper_enemyRelocated");
      } else if(scripts\engine\utility::is_equal(var_11, "sniper_bulletImpact")) {
        if(isDefined(var_12) && var_12 != level.player) {
          level notify("sniper_redShirtDeath", var_12.name);
          var_0[[level.aigibfunction]](var_12, var_15, "MOD_RIFLE_BULLET");
          thread sniper_playerscreenbloodeffectlogic(var_15);
        }
      }

      continue;
    }

    var_16 = var_1 scripts\engine\utility::get_linked_nodes()[0];
    childthread sniper_enemyrelocate(var_0, var_1, var_16);
    var_1 = var_16;
    var_7++;
    level waittill("sniper_enemyRelocated");
    var_4 = int(max(0, var_4 - var_6));
  }
}

sniper_playerscreenbloodeffectlogic(var_0) {
  var_1 = 130;

  if(distance(var_0, level.player getEye()) > var_1) {
    return;
  }
  level.player thread scripts\sp\player::bloodoverlay(1.0, 3.0, 4.0);
  level.player thread scripts\sp\player::damagebloodoverlaydirectional(var_0, "MOD_RIFLE_BULLET", 8.0);
}

sniper_playerlookingatenemy(var_0) {
  var_1 = anglesToForward(level.player getplayerangles());
  var_2 = vectorNormalize(var_0 getEye() - level.player getEye());
  var_3 = vectordot(var_1, var_2);
  return var_3 >= 0.999889;
}

sniper_enemyrelocate(var_0, var_1, var_2) {
  var_3 = var_2.origin - var_1.origin;
  scripts\engine\utility::flag_set("sniper_enemyRelocating", var_3);
  var_0 allowedstances("prone");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::ai_waittillinstance("prone");
  var_0 scripts\engine\sp\utility::set_goalRadius(4);
  scripts\sp\maps\highway\highway_utility.gsc::ai_movealongpath(var_0, var_2);
  var_4 = 0.5;
  wait(var_4);

  if(isDefined(var_2.script_stance))
    var_0 allowedstances(var_2.script_stance);
  else
    var_0 allowedstances("crouch");

  var_5 = 2.0;
  wait(var_5);
  scripts\engine\utility::flag_clear("sniper_enemyRelocating");
  level notify("sniper_enemyRelocated");
  thread sniper_enemyglinton(var_0);
}

sniper_enemyspottedlogic(var_0) {
  var_1 = 2000;
  var_2 = squared(var_1);

  for(;;) {
    level waittill("ballistics_impact", var_3);

    if(distancesquared(var_3, var_0.origin) > var_2) {
      continue;
    }
    level notify("sniper_enemySpotted");
  }
}

sniper_enemytargetentitylogic(var_0) {
  var_1 = scripts\engine\utility::spawn_script_origin();
  var_2 = 100;
  var_0 setentitytarget(var_1);

  while(isalive(var_0)) {
    var_3 = vectorNormalize(level.player getEye() - var_0 getEye());
    var_1.origin = var_0 getEye() + var_3 * var_2;
    waitframe();
  }

  var_1 delete();
}

sniper_killplayerlogic(var_0) {
  var_1 = 20.0;
  var_2 = 28.0;
  var_3 = -9.0;
  var_4 = -13.0;
  var_5 = -6.0;
  var_6 = -1.0;
  var_7 = 0;
  var_8 = 100;
  var_9 = -50;

  for(;;) {
    var_10 = 0;
    var_11 = sighttracepassed(level.player getEye(), var_0 getEye(), 0, level.player, 1);

    if(scripts\engine\utility::flag("sniper_enemyRelocating"))
      var_10 = var_10 + var_6;
    else if(var_11) {
      var_12 = level.player getstance();

      if(var_12 == "crouch")
        var_10 = var_10 + var_1;
      else if(var_12 == "stand")
        var_10 = var_10 + var_2;

      if(level.player issprinting())
        var_10 = var_10 + var_4;
      else if(length(level.player getvelocity()))
        var_10 = var_10 + var_3;
    } else
      var_10 = var_10 + var_5;

    var_10 = var_10 / 20;
    var_7 = clamp(var_7 + var_10, 0, var_8);

    if(var_7 >= var_8) {
      thread sniper_fireshot(var_0, level.player getEye());
      level waittill("sniper_bulletImpact");
      var_11 = sighttracepassed(level.player getEye(), var_0 getEye(), 0, level.player, 1);

      if(var_11 && !scripts\engine\utility::flag("sniper_enemyRelocating")) {
        playFX(level.g_effect["vfx_gib_explode"], level.player getEye());
        thread scripts\engine\utility::play_sound_in_space("gib_fullbody", level.player getEye());
        wait 0.1;
        level.player kill();
      } else
        var_7 = var_7 + var_9;
    }

    waitframe();
  }
}

sniper_fireshot(var_0, var_1) {
  if(isai(var_0)) {
    var_2 = var_0 gettagorigin("tag_flash");
    var_3 = var_0 gettagangles("tag_flash");
    var_0 shoot();
  } else {
    var_2 = var_0.origin;
    var_3 = var_0.angles;
  }

  playFX(level._effect["vfx_sniper_dust_kickup"], var_0.origin);
  playFX(level._effect["vfx_sniper_muzzle_flash"], var_2, var_3);
  scripts\engine\utility::delaythread(1.25, scripts\engine\utility::play_sound_in_space, "sniper_fireDistant", var_2);
  var_4 = scripts\engine\utility::spawn_tag_origin(var_2);
  var_4 notsolid();
  playFXOnTag(level._effect["vfx_sniper_bullet_trail"], var_4, "tag_origin");
  var_5 = 0.0333333;
  var_6 = 0;
  var_7 = (0, 0, 0);

  while(var_6 < 1) {
    var_8 = var_4.origin;
    var_4.origin = scripts\engine\math::get_point_on_parabola(var_2, var_1, 50, var_6);
    var_7 = vectorNormalize(var_4.origin - var_8);
    var_6 = var_6 + var_5;
    waitframe();
  }

  var_4.origin = var_1;
  scripts\engine\utility::delaythread(0.25, scripts\engine\utility::play_sound_in_space, "sniper_impact_crack_highway", var_1);
  level notify("sniper_bulletImpact");
  physicsexplosionsphere(var_1, 90, 90, 150);
  earthquake(0.15, 0.7, level.player.origin, 9999);
  playrumbleonposition("damage_heavy", level.player.origin);
  var_9 = distance(var_2, var_1);
  var_10 = var_9 / 1.5;
  var_11 = var_1 + var_7 * (var_10 * 2.0);
  var_4 moveTo(var_11, 2.0);
  var_4 scripts\engine\utility::delaycall(2.0, ::delete);
}

sniper_getimpactstructs() {
  return scripts\engine\utility::getStructArray("sniper_impactStruct", "targetname");
}

sniper_spawnenemy() {
  var_0 = sniper_getenemyspawner();
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.targetname = "sniper_enemy";
  var_1.dontevershoot = 1;
  var_1 scripts\engine\utility::disable_pain();
  var_1 scripts\engine\sp\utility::set_moveplaybackrate(1.5);
  var_1.disablepistol = 1;
  var_1.script_parameters = "gib_force";
  return var_1;
}

sniper_getenemy() {
  return getEnt("sniper_enemy", "targetname");
}

sniper_getenemyspawner() {
  return getspawner("sniper_enemySpawner", "targetname");
}

sniper_getenemynodes() {
  return getnodearray("sniper_enemyNode", "targetname");
}

squad_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  thread sniper_windshiftlogic();
  restock_preplaceieds();
}

squad_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("squad");
  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();
  var_0 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_ELIMINATE_MORTARS");
  thread squad_allieslogic();
  thread squad_dialoguelogic();
  thread squad_enemieslogic();
  level waittill("mortars_crewDisabled");
  var_1 = squad_getmortarmodels();

  foreach(var_3 in var_1)
  var_3 notify("mortars_stop");

  objective_delete(var_0);
  var_0 = level_addmissionnarrativeobjective();

  while(scripts\sp\maps\highway\highway_utility.gsc::level_getflag(2))
    waitframe();

  if(2.0)
    wait 2.0;

  objective_delete(var_0);
}

squad_enemieslogic() {
  level endon("mortars_crewDisabled");
  var_0 = 1.25;
  var_1 = 4.0;
  var_2 = squad_getmortarmodels();

  foreach(var_6, var_4 in var_2) {
    var_5 = var_1 + var_0 * var_6;
    thread mortars_modellogic(0, var_4, var_5);
  }
}

squad_allieslogic() {
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(32, 1);
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(64, 1);
  var_0 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("allies");

  foreach(var_2 in var_0)
  var_2 scripts\sp\maps\highway\highway_utility.gsc::ai_resetstances();
}

squad_dialoguelogic() {
  level endon("mortars_crewDisabled");
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  var_1 childthread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_russian_jets_10", 4.0, level, "mortars_impact");
  var_0 childthread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_russian_jets_30", 7.0);
  level waittill("mortars_impact");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_mortar_team3_20", 4);
}

squad_getmortarmodels() {
  return getEntArray("squad_mortarModel", "targetname");
}

squad_getvehiclespawners() {
  return scripts\common\utility::getvehiclespawnerarray("squad_vehicleSpawner", "targetname");
}

squad_spawnvehicles() {
  var_0 = squad_getvehiclespawners();
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    var_4.targetname = "squad_vehicle";
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

squad_getvehicles() {
  var_0 = vehicle_getarray();

  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::is_equal(var_2.targetname, "squad_vehicle"))
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  return var_0;
}

jets_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(64, 1);
  restock_preplaceieds();
  var_0 = level_addmissionnarrativeobjective();
  scripts\engine\utility::exploder("jets_explo");
}

jets_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("jets");
  var_0 = level_addmissionnarrativeobjective();
  var_1 = jets_getvehiclespawners();
  var_2 = [];
  var_3 = ["scn_highway_bombrun_jet1_by", "scn_highway_bombrun_jet2_by", undefined, "scn_highway_bombrun_jet3and4_by"];
  var_4 = [0, 6.2, undefined, 9.2];

  foreach(var_8, var_6 in var_1) {
    var_7 = jets_spawnVehicle(var_6);
    var_7.spawnnumber = var_8;
    thread jets_vehiclelogic(var_7);
    thread jets_sfxlogic(var_7, var_3[var_8], var_4[var_8]);
  }

  thread jets_dialoguelogic();
  thread sfx_jets_bomb_expl();
  level waittill("vehicle_suniform25BombImpact");
  var_9 = wind_getrandomdirectionindex();
  wind_setdirection(var_9, 2000, 0);
  scripts\engine\utility::exploder("explo");

  if(12)
    wait 12;

  objective_delete(var_0);
}

sfx_jets_bomb_expl() {
  level waittill("vehicle_suniform25BombImpact", var_0);
  thread scripts\engine\utility::play_sound_in_space("scn_highway_bombrun_jet1_bomb_expl", var_0);
  wait 2;
  level waittill("vehicle_suniform25BombImpact", var_0);
  thread scripts\engine\utility::play_sound_in_space("scn_highway_bombrun_jet2_bomb_expl", var_0);
  wait 2;
  level waittill("vehicle_suniform25BombImpact", var_0);
  thread scripts\engine\utility::play_sound_in_space("scn_highway_bombrun_jet3and4_bomb_expl", var_0);
}

jets_sfxlogic(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  if(istrue(var_2))
    wait(var_2);

  var_0 playSound(var_1);
}

jets_dialoguelogic() {
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  level waittill("vehicle_suniform25BombImpact", var_2);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_russian_jets_40", 5.0);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_russian_jets_41");
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_russian_jets_45", 1.0);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_russian_jets_50", 6.5);
}

jets_getvehiclespawners() {
  return scripts\common\utility::getvehiclespawnerarray("jets_vehicleSpawner", "targetname");
}

jets_spawnVehicle(var_0) {
  var_1 = var_0 scripts\common\utility::spawn_vehicle();
  var_1 scripts\common\vehicle::godon();
  return var_1;
}

jets_vehiclelogic(var_0) {
  thread scripts\common\vehicle_paths::gopath(var_0);
  thread vehicle_suniform25effects(var_0);
  playFXOnTag(level._effect["vfx_jet_engine"], var_0, "TAG_ENGINE_LEFT");
  playFXOnTag(level._effect["vfx_jet_engine"], var_0, "TAG_ENGINE_RIGHT");
  playFXOnTag(level._effect["vfx_jet_wing_trail"], var_0, "TAG_WINGTIP_LEFT");
  playFXOnTag(level._effect["vfx_jet_wing_trail"], var_0, "TAG_WINGTIP_RIGHT");
  playFXOnTag(level._effect["vfx_suniform25_jet_swirl"], var_0, "TAG_ORIGIN");
  var_0 endon("death");
  var_1 = var_0.currentnode;

  for(;;) {
    if(!scripts\engine\utility::is_equal(var_0.currentnode, var_1)) {
      if(scripts\engine\utility::is_equal(var_0.currentnode.script_noteworthy, "jets_vehicleNodeDropBomb"))
        thread vehicle_suniform25dropbomb(var_0);
    }

    var_1 = var_0.currentnode;
    waitframe();
  }
}

armor_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(64, 1);
  restock_preplaceieds();
}

armor_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("armor");
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(16, 0);
  var_0 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
  scripts\engine\utility::array_delete(var_0);
  var_1 = armor_spawnvehicles();

  foreach(var_3 in var_1)
  thread armor_vehiclelogic(var_3, 0);

  thread armor_audiologic(var_1);
  thread armor_dialoguelogic(var_1);
  thread armor_vehicleenemieslogic(var_1);
  thread armor_objectivelogic(var_1);
  thread armor_vehiclesstoppedautosave(var_1);
  thread armor_notifylevelonvehicleendpath(var_1);
  thread armor_clearvehiclessmokegrenades(var_1);
  thread armor_achievementlogic();
  var_5 = level_getfarah();
  var_5 scripts\sp\maps\highway\highway_utility.gsc::ai_resetstances();
  var_6 = getnode("restock_hadirNode", "targetname");
  var_5 scripts\engine\sp\utility::set_goal_node(var_6);
  scripts\sp\maps\highway\highway_utility.gsc::waittill_remainingenemycountortimeout(12, 90);
  level notify("armor_playerSpottedVehicle");

  if(0)
    wait 0;
}

armor_objectivelogic(var_0) {
  var_1 = [level];
  var_2 = ["armor_allVehiclesStopped", "vehicle_tireBreak"];
  level.player scripts\sp\player::focus_display_hint(30, undefined, var_1, var_2);
  var_3 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_STOP_RUSSIAN_ASSAULT");

  foreach(var_6, var_5 in var_0) {
    objective_setlocation(var_3, var_6, var_5);
    objective_setzoffset(var_3, 125);
    var_5 thread scripts\sp\maps\highway\highway_utility.gsc::call_on_notify_no_self("vehicle_tireBreak", ::objective_unsetlocation, var_3, var_6);
  }
}

armor_vehiclesstoppedautosave(var_0) {
  scripts\engine\utility::array_wait(var_0, "reached_wait_speed");
  scripts\engine\sp\utility::autosave_by_name_silent("armor_vehiclesStopped");
}

armor_vehicleenemieslogic(var_0) {
  scripts\engine\utility::array_wait(var_0, "reached_wait_speed");
  var_1 = [];

  foreach(var_3 in var_0)
  var_1 = scripts\engine\utility::array_combine(var_1, var_3.riders);

  foreach(var_6 in var_1)
  thread level_enemyassaulttownlogic(var_6, 1);
}

armor_audiologic(var_0) {
  wait 8;
  var_0[1] playSound("scn_highway_apc_drive_in_01");
  wait 3;
  setmusicstate("mx_highway_apc");
  var_0[0] playLoopSound("veh_apc_highway_engine_lp_01");
  var_0[1] playLoopSound("veh_apc_highway_engine_lp_02");
  var_0[2] playLoopSound("veh_apc_highway_engine_lp_03");
  var_0[3] playLoopSound("veh_apc_highway_engine_lp_04");

  foreach(var_2 in var_0)
  thread armor_vehicletireaudiologic(var_2);

  wait 21;
  var_0[1] playSound("scn_highway_apc_drive_in_02");
  wait 25;
  thread mus_ethnic_battle();
}

armor_vehicletireaudiologic(var_0) {
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkTo(var_0);
  var_1 playLoopSound("veh_apc_highway_tires_lp");
  var_0 waittill("reached_wait_speed");
  var_0 stoploopsound();
  var_1 scripts\engine\sp\utility::sound_fade_and_delete(2, 1);
}

armor_vehiclelogic(var_0, var_1) {
  if(var_1) {
    var_2 = var_0 scripts\sp\maps\highway\highway_utility.gsc::get_lastentinspline(var_0.currentnode, ::getvehiclenode);
    var_0 attachpath(var_2);
    var_0 thread scripts\common\vehicle::vehicle_unload();
  } else {
    scripts\engine\utility::exploder("armor_smoke");
    thread armor_vehiclespottedlogic(var_0);
    wait 2;
    thread scripts\common\vehicle_paths::gopath(var_0);
    var_0 vehicle_setspeed(10, 15);

    while(!var_0 vehicle_getspeed())
      waitframe();

    var_0 setwaitspeed(0);
  }

  var_0 waittill("spawnedRiders", var_3);
  var_0 vehicle_turnengineoff();
  var_0 stopsounds();
  var_0 stoploopsound();

  foreach(var_5 in var_3)
  thread level_enemyassaulttownlogic(var_5, 1);
}

armor_vehiclespottedlogic(var_0) {
  var_0 endon("reached_end_node");
  var_0 endon("vehicle_disabled");
  level endon("armor_playerSpottedVehicle");
  thread armor_vehiclespottedspeedlogic(var_0);
  var_1 = gettime() + 35000;

  for(;;) {
    if(gettime() >= var_1) {
      break;
    }

    var_2 = vectorNormalize(var_0.origin - level.player getEye());
    var_3 = anglesToForward(level.player getplayerangles());
    var_4 = vectordot(var_2, var_3);

    if(player_fullads() && var_4 >= 0.999848) {
      break;
    }

    waitframe();
  }

  level notify("armor_playerSpottedVehicle");
}

armor_vehiclespottedspeedlogic(var_0) {
  var_0 endon("reached_end_node");
  var_0 endon("vehicle_disabled");
  level waittill("armor_playerSpottedVehicle");
  var_0 vehicle_setspeed(12, 10);
}

armor_clearvehiclessmokegrenades(var_0) {
  scripts\engine\utility::array_wait(var_0, "vehicle_vindiaSmokeGrenadeDisperse");
  scripts\engine\utility::array_wait(var_0, "vehicle_vindiaSmokeGrenadeDisperse");
  var_1 = vehicle_getvindiasmokegrenades();
  var_1 = scripts\engine\utility::array_removeundefined(var_1);
  var_1 = sortbydistance(var_1, level.player.origin);

  for(var_2 = 6; var_2 < var_1.size; var_2++) {
    stopFXOnTag(level._effect["vfx_vindia_smk_gren_left"], var_1[var_2], "tag_fx");
    var_1[var_2] delete();
  }
}

armor_achievementlogic() {
  var_0 = 3;

  for(var_1 = 0; var_1 < var_0; var_1++)
    level waittill("vehicle_vindiaDisable");

  scripts\sp\utility::giveachievement_wrapper("pitstop");
}

armor_spawnvehicles() {
  return vehicle_spawnvindias("armor_vehicleVindiaSpawner", "armor_vehicleVindia");
}

armor_getvehicles() {
  var_0 = vehicle_getarray();

  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::is_equal(var_2.targetname, "armor_vehicleVindia"))
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  return var_0;
}

armor_dialoguelogic(var_0) {
  level endon("vehicle_tireBreak");
  level endon("vehicle_vindiaReachedEndNode");
  var_1 = level_getfarah();
  var_2 = level_gethadir();
  thread armor_dialogicfeedbacklogic();
  var_2 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_russian_apcs_90", 10, level, "armor_playerSpottedVehicle");
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_russian_apcs_10", 21, level, "armor_playerSpottedVehicle");
  var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_russian_apcs_45", 33, level, "armor_playerSpottedVehicle");
  level waittill("armor_playerSpottedVehicle");
  var_2 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_russian_apcs_22", 1, level, "ballistics_impact");
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_russian_apcs_50", 10);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_russian_apcs_70", 4);
}

armor_dialogicfeedbacklogic() {
  level endon("vehicle_vindiaReachedEndNode");
  var_0 = level_gethadir();
  var_1 = level_getfarah();
  var_2 = ["dx_vom_had_russian_apcs_20", "dx_vom_had_russian_apcs_47", "dx_vom_far_russian_apcs_40"];
  var_3 = [var_0, var_0, var_1];
  var_4 = 0.25;
  var_5 = 0;
  var_6 = ["dx_vom_had_russian_apcs_80", "dx_vom_far_convoy_backup_110"];
  var_7 = [var_0, var_1];
  var_8 = 0.25;
  var_9 = 0;
  var_10 = [2, 3];
  var_11 = var_10[0];
  var_12 = ["dx_vom_far_russian_apcs_100"];
  var_13 = [var_1];
  var_14 = 0.25;
  var_15 = 0;
  var_16 = 0;

  for(;;) {
    var_17 = level scripts\engine\utility::waittill_any_return("vehicle_vindiaBodyShot", "vehicle_tireBreak", "vehicle_vindiaSmokeGrenade");

    if(var_17 == "vehicle_vindiaBodyShot" && !var_15) {
      var_3[var_5] thread scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_2[var_5], var_4);
      var_5 = scripts\engine\math::wrap(0, var_2.size - 1, var_5 + 1);
      continue;
    }

    if(var_17 == "vehicle_tireBreak") {
      var_15 = 1;
      var_18 = var_10[var_9];

      if(var_11 == var_18) {
        var_7[var_9] thread scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_6[var_9], var_8);
        var_9 = scripts\engine\math::wrap(0, var_6.size - 1, var_9 + 1);
        var_11 = 0;
      } else
        var_11++;

      continue;
    }

    if(var_17 == "vehicle_vindiaSmokeGrenade" && var_12.size) {
      var_19 = var_12[0];
      var_1 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_19, 4);
      var_12 = scripts\engine\utility::array_remove(var_12, var_19);
    }
  }
}

armor_notifylevelonvehicleendpath(var_0) {
  scripts\engine\utility::array_any_wait(var_0, "reached_end_node");
  level notify("vehicle_vindiaReachedEndNode");
}

mus_ethnic_battle() {}

russians_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(64, 1);
  restock_preplaceieds();
  var_0 = armor_spawnvehicles();

  foreach(var_2 in var_0)
  thread armor_vehiclelogic(var_2, 1);

  var_0 = sortbydistance(var_0, level.player.origin);
  thread vehicle_vindiasmokegrenadelogic(var_0[0], 0);
  thread mus_ethnic_battle();
  scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_STOP_RUSSIAN_ASSAULT");
}

russians_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("russians");
  setsaveddvar("NLRRTORQPN", 3);
  var_0 = armor_getvehicles();
  russians_setenemygoalcount(22);
  thread russians_enemyinfinitespawninglogic(var_0);
  level scripts\engine\utility::waittill_multiple("russians_playerKillCountReached", "russians_playerSurvivalTimeReached");

  if(1.5)
    wait 1.5;
}

russians_enemyinfinitespawninglogic(var_0) {
  level endon("russians_stopSpawning");

  foreach(var_2 in var_0) {
    if(var_2 vehicle_getspeed())
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  childthread russians_playerkillcounterlogic();
  childthread russians_playerinfiniteenemiessurvivaltimelogic();
  var_4 = russians_getenemyinfinitespawners();
  var_5 = level_gettowninnerenemygoalvolume();

  for(;;) {
    waitframe();
    var_6 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
    var_7 = russians_getenemygoalcount();

    if(var_6.size >= var_7) {
      continue;
    }
    var_8 = scripts\engine\utility::random(var_4);
    var_9 = var_8 scripts\engine\sp\utility::spawn_ai(1);

    if(isDefined(var_9)) {
      var_8.count = 9999;
      thread russians_infiniteenemylogic(var_9, var_5);
      wait 1.95;
    }
  }
}

russians_setenemygoalcount(var_0) {
  level.russiansenemygoalcount = var_0;
}

russians_getenemygoalcount() {
  return level.russiansenemygoalcount;
}

russians_infiniteenemylogic(var_0, var_1) {
  var_0 endon("death");
  var_0 scripts\common\utility::demeanor_override("sprint");
  var_0 setgoalvolumeauto(var_1);

  while(!var_0 istouching(var_1))
    waitframe();

  var_0 scripts\common\utility::clear_demeanor_override();
}

russians_playerkillcounterlogic() {
  level.player endon("death");
  var_0 = 0;
  var_1 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
  var_2 = 0;

  for(;;) {
    var_3 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
    var_4 = scripts\engine\utility::array_remove_array(var_1, var_3);

    foreach(var_6 in var_4) {
      if(!russians_playerkillcounterworthy(var_6)) {
        continue;
      }
      var_0++;
    }

    if(var_0 >= 7.5 && !var_2) {
      scripts\engine\sp\utility::autosave_by_name("russians_halfway_kills");
      var_2 = 1;
    }

    if(var_0 >= 15) {
      break;
    }

    var_1 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
    waitframe();
  }

  level notify("russians_playerKillCountReached");
}

russians_playerkillcounterworthy(var_0) {
  if(!scripts\engine\utility::is_equal(var_0.lastattacker, level.player))
    return 0;

  if(!isDefined(var_0.damagemod))
    return 0;

  if(var_0.damagemod == "MOD_EXPLOSIVE")
    return 0;

  if(var_0.damagemod == "MOD_GRENADE")
    return 0;

  if(var_0.damagemod == "MOD_GRENADE_SPLASH")
    return 0;

  if(var_0.damagemod == "MOD_PROJECTILE")
    return 0;

  if(var_0.damagemod == "MOD_PROJECTILE_SPLASH")
    return 0;

  var_1 = level_gettowninnerenemygoalvolume();
  var_2 = level_gettownouterenemygoalvolume();

  if(!var_0 istouching(var_1) && !var_0 istouching(var_2))
    return 0;

  return 1;
}

russians_playerinfiniteenemiessurvivaltimelogic() {
  level.player endon("death");
  wait 20.0;
  scripts\engine\sp\utility::autosave_by_name("russians_halfway_time");
  wait 20.0;
  level notify("russians_playerSurvivalTimeReached");
}

russians_getenemyinfinitespawners() {
  return getspawnerarray("russians_enemyInfiniteSpawner");
}

cover_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(64, 1);
  russians_setenemygoalcount(22);
  var_0 = armor_spawnvehicles();

  foreach(var_2 in var_0)
  armor_vehiclelogic(var_2, 1);

  thread russians_enemyinfinitespawninglogic(var_0);
  var_0 = sortbydistance(var_0, level.player.origin);
  thread vehicle_vindiasmokegrenadelogic(var_0[0], 0);
  thread mus_ethnic_battle();
  scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_STOP_RUSSIAN_ASSAULT");
  setmusicstate("mx_highway_apc");
}

cover_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("cover");
  var_0 = level_gethadir();
  var_1 = level_getfarah();
  var_0 scripts\engine\sp\utility::set_battlechatter(0);
  var_1 scripts\engine\sp\utility::set_battlechatter(0);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_russian_combat_10");
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_russian_combat_20", 0.5);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_cbc_had_inform_incoming_flashbang", 0.5);
  scripts\sp\maps\highway\highway_utility.gsc::player_waittillmaxhealth();
  scripts\engine\sp\utility::autosave_by_name_silent("cover_healthy");
  scripts\sp\maps\highway\highway_utility.gsc::level_deletereservedobjectives();
  thread cover_playerflashbanglogic();
  scripts\engine\utility::flag_set("level_enemyAssaultPlayerSeek");
  var_2 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
  var_2 = sortbydistance(var_2, level.player.origin);

  foreach(var_4 in var_2) {
    var_4 scripts\engine\sp\utility::set_goalRadius(600);
    var_4 setgoalentity(level.player);
    var_4 scripts\engine\sp\utility::set_grenadeammo(0);
  }

  russians_setenemygoalcount(7);

  for(var_6 = 6; var_6 < var_2.size; var_6++) {
    var_2[var_6].diequietly = 1;
    var_2[var_6] kill();
  }

  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  var_0 scripts\engine\sp\utility::set_attackeraccuracy(0);
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(512, 0);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_russian_combat_41", 1.0, undefined, undefined, 0);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_gas_truck_20", 0.5);
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_gas_truck_140", 0.25);
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_gas_truck_150", 0.2);
  wait 2.0;
  scripts\engine\sp\utility::autosave_by_name_silent("cover_getToTruck");
  level.player scripts\sp\player::set_focus_objectives_update_display(1);
  level.player scripts\sp\player::set_focus_infinite_hold(0);
  var_7 = cover_getplayerinteract();
  var_7 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"HIGHWAY/CURSOR_HELP", 65, 800, 60);
  thread scripts\sp\player::focus_display_hint(14.0, undefined, level, "russians_stopSpawning");
  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();
  var_8 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_HELP_HADIR", var_7.origin + (0, 0, 5), &"HIGHWAY/LABEL_HELP");
  var_9 = getnode("cover_hadirNode", "targetname");
  var_0 setgoalnode(var_9);
  var_0 scripts\common\utility::demeanor_override("sprint");
  var_10 = ["dx_vom_had_gas_truck_180", "dx_vom_had_gas_truck_190", "dx_vom_had_gas_truck_30", "dx_vom_had_gas_truck_40"];
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_10, 10, level, "russians_stopSpawning", 9);
  var_11 = 40000;
  var_12 = gettime() + var_11;
  var_13 = 600;

  for(;;) {
    if(distance(level.player.origin, var_7.origin) <= var_13) {
      break;
    }

    if(gettime() >= var_12) {
      break;
    }

    waitframe();
  }

  level notify("russians_stopSpawning");
  level_cleanupieds();
  var_14 = scripts\engine\utility::getStructArray("cover_hadirIEDStruct", "targetname");

  foreach(var_16 in var_14)
  scripts\sp\equipment\ied::iedplaydetonateeffects(var_16.origin);

  scripts\sp\equipment\ied::iedplaydetonateeffects(level.player.origin);
  earthquake(0.35, 1.5, level.player.origin, 9999);
  level.player playRumbleOnEntity("damage_heavy");
  level.player shellshock("default", 3.0);
  var_2 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
  scripts\engine\sp\utility::array_kill(var_2);
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_gas_tailgate_10", 1.5, var_7, "trigger");
  var_0 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_gas_tailgate_20", 5.5, var_7, "trigger");
  var_10 = ["dx_vom_had_gas_tailgate_30", "dx_vom_had_gas_tailgate_40", "dx_vom_had_gas_tailgate_50"];
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue_naglogic(var_10, 10, var_7, "trigger", 9);
  thread scripts\sp\player::focus_display_hint(2.0, undefined, var_7, "trigger");
  var_7 waittill("trigger");
  objective_delete(var_8);
  var_18 = getEnt("cover_playerInteractModel", "targetname");

  if(isDefined(var_18))
    var_18 delete();
}

sfx_hadir_truck() {
  var_0 = level_gethadirtruck();
  var_0 playSound("scn_highway_gas_truck_start");
  wait 0.1;
  var_0 playSound("scn_highway_gas_truck_grenade_bounce");
}

cover_playerflashbanglogic() {
  var_0 = 0.25;
  var_1 = 0.5;
  var_2 = 7.0;
  var_3 = 6.0;
  var_4 = level.player.attackeraccuracy;
  level.player scripts\sp\utility::set_player_attacker_accuracy(0);
  level.player enableinvulnerability();
  thread scripts\engine\utility::play_sound_in_space("cover_flashbang", level.player.origin);
  level.player shellshock("highway_cover_flashbang", var_2);
  var_5 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_5 fadeovertime(var_0);
  var_5.alpha = 1.0;
  wait(var_0);
  cover_spawnenemies();
  var_5 fadeovertime(var_1);
  var_5.alpha = 0.0;
  wait(var_1);
  var_5 destroy();
  wait(var_3);
  level.player scripts\sp\utility::set_player_attacker_accuracy(var_4);
  level.player disableinvulnerability();
}

cover_spawnenemies() {
  var_0 = getspawnerarray("cover_enemySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1)
  var_3.fixednode = 1;
}

cover_getplayerinteract() {
  return getEnt("cover_playerInteract", "targetname");
}

crash_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_battlechatter(0);
  var_1 = level_spawnhadir();
  var_1 scripts\common\utility::demeanor_override("sprint");
  var_1 scripts\engine\sp\utility::set_battlechatter(0);
  player_givefullloadout();
  scripts\engine\sp\utility::set_start_location("start_crash", [level.player, var_1]);
}

crash_main() {
  level.player scripts\sp\utility::set_player_attacker_accuracy(0);
  var_0 = level_addmissionnarrativeobjective();
  thread crash_dialoguelogic();
  var_1 = level_gethadirtruck();
  var_2 = level_gethadirtruckboard();
  var_3 = crash_getanimationstruct();
  setmusicstate("");
  thread sfx_hadir_truck();
  thread crash_playeranimationlogic(var_3);
  var_3 thread scripts\common\anim::anim_single_solo(var_2, "crash_enter");
  var_3 scripts\common\anim::anim_single_solo(var_1, "crash_enter");
  thread crash_hadiranimationlogic(var_3);
  var_3 thread scripts\common\anim::anim_single_solo(var_2, "crash_exit");
  var_3 scripts\common\anim::anim_single_solo(var_1, "crash_exit");
  thread audio_post_gas();
  physicsexplosionsphere(var_1.origin, 400, 200, 100);
  earthquake(0.3, 1.0, level.player.origin, 9999);
  level.player playRumbleOnEntity("damage_heavy");
  objective_delete(var_0);
}

audio_post_gas() {
  level.player setclienttriggeraudiozone("highway_ending_01");
}

crash_dialoguelogic() {
  var_0 = level_gethadir();
  level.player scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_alx_gas_tailgate_60", 4.0);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_gas_tailgate_80");
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_gas_tailgate_100", 0.5);
}

crash_playeranimationlogic(var_0) {
  gas_playerpistolweaponlogic();
  var_1 = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  var_1 hide();
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "crash_enter");
  var_2 = 0.4;

  if(level.player ispcplayer())
    setsaveddvar("OMNONNMOTP", "0.1 500 2.8 10000");

  thread scripts\sp\maps\highway\highway_utility.gsc::player_rigenter(var_1, var_2, 10, 10, 10, 10);
  var_1 scripts\engine\utility::delaycall(var_2, ::show);
  var_0 scripts\common\anim::anim_single_solo(var_1, "crash_enter");
  scripts\sp\maps\highway\highway_utility.gsc::player_rigexit(var_1);

  if(level.player ispcplayer())
    setsaveddvar("OMNONNMOTP", "0.1 500 4 10000");
}

crash_hadiranimationlogic(var_0) {
  var_1 = level_gethadir();
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "crash_exit");
  var_2 = scripts\engine\sp\utility::spawn_anim_model("level_hadirGasMask");
  var_1 attach("offhand_wm_grenade_mike67", "tag_accessory_right");
  var_0 scripts\common\anim::anim_single_solo(var_2, "crash_exit");
  level_hadirattachgasmask();
  var_2 delete();
  var_1 detach("offhand_wm_grenade_mike67", "tag_accessory_right");
}

crash_getanimationstruct() {
  return scripts\engine\utility::getStruct("crash_animationStruct", "targetname");
}

gas_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_battlechatter(0);
  var_1 = level_spawnhadir();
  var_1 scripts\common\utility::demeanor_override("sprint");
  var_1 scripts\engine\sp\utility::set_battlechatter(0);
  level_hadirattachgasmask();
  gas_playerpistolweaponlogic();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(512, 0);
  var_2 = level_gethadirtruck();
  var_2.origin = (-2046.09, -1181.6, 915.984);
  var_2.angles = (15.4519, 85.4758, 1.78625);
  scripts\engine\sp\utility::set_start_location("start_crash", [level.player, var_1]);
}

gas_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("gas");
  var_0 = getspawnerarray("gas_aiSpawner");

  foreach(var_2 in var_0)
  thread gas_dyingailogic(var_2);

  thread gas_allieslogic();
  thread gas_explosionlogic();
  thread gas_playerexposedlogic();
  thread gas_dialoguelogic();
  thread gas_objectivelogic();
  level waittill("gas_playerPassedOutEnd");
  wait 4.0;
}

gas_allieslogic() {
  var_0 = level_gethadir();
  var_1 = level_getfarah();
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 = getnode("gas_hadirPath", "targetname");
  var_0 thread scripts\sp\spawner::go_to_node(var_2);
  var_0 scripts\common\utility::clear_demeanor_override();
  var_3 = getnode("gas_farahNode", "targetname");
  var_1 setgoalnode(var_3);
  var_1 scripts\common\utility::clear_demeanor_override();
}

gas_dyingailogic(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.target)) {
      var_4 = getEntArray(var_3.target, "targetname");

      foreach(var_6 in var_4)
      var_6 endon("trigger");
    }
  }

  scripts\engine\utility::array_any_wait(var_1, "trigger");
  var_9 = spawnStruct();
  var_9.origin = var_0.origin;
  var_9.angles = var_0.angles;
  var_10 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_10.animname = "gas_dyingAI" + var_10.script_index;
  var_10 thread audio_play_bodyfalls_for_htf_anims();
  var_10 scripts\common\ai::gun_remove();
  var_10 scripts\engine\sp\utility::set_ignoreall(1);
  var_10 scripts\engine\sp\utility::set_ignoreme(1);
  var_10 endon("damage");
  thread gas_dyingaidamagelogic(var_10);
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintolastframe(var_9, var_10, "gas_dying");

  if(!isDefined(var_0.script_threshold)) {
    return;
  }
  waitframe();
  var_9 scripts\common\anim::anim_set_time_solo(var_10, "gas_dying", var_0.script_threshold);
}

audio_play_bodyfalls_for_htf_anims() {
  var_0 = self.animname;

  if(var_0 == "gas_dyingAI3") {
    scripts\engine\utility::delaycall(1.8, ::playsound, "hwy_generic_cough_1_enemy_3");
    scripts\engine\utility::delaycall(3.5, ::playsound, "hod_yard_010_death_enemy_02_05");
    scripts\engine\utility::delaycall(5.3, ::playsound, "hwy_generic_cough_1_enemy_3");
  }

  if(var_0 == "gas_dyingAI1") {
    scripts\engine\utility::delaycall(3.0, ::playsound, "hod_yard_010_death_enemy_02_03");
    scripts\engine\utility::delaycall(1.8, ::playsound, "hwy_generic_cough_1_enemy_1");
  }
}

gas_dyingaidamagelogic(var_0) {
  var_0 waittill("damage");
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 scripts\engine\sp\utility::ai_ragdoll_immediate();
}

gas_explosionlogic() {
  var_0 = level_gethadirtruck();
  var_0 setModel("veh8_civ_lnd_zuniform_static_dst");
  thread gas_explosionsfxlogic(var_0.origin);
  var_1 = gas_getbarrels();
  var_1 = sortbydistance(var_1, var_0.origin);
  playFX(level._effect["vfx_tear_gas_explosion"], var_0.origin);
  earthquake(0.15, 0.5, var_0.origin, 50000);
  thread gas_killai();
  var_2 = scripts\engine\sp\utility::getallweapons();
  scripts\engine\utility::array_delete(var_2);
  var_3 = scripts\sp\destructibles\red_barrel::getallredbarrels();

  foreach(var_5 in var_3)
  var_5 notify("death");
}

gas_explosionsfxlogic(var_0) {
  var_1 = spawn("script_origin", var_0 + (0, 0, 1));
  var_1 playexplosionsound("scn_highway_gas_truck_exp", "exp");
  scripts\engine\utility::delaythread(2.0, scripts\engine\utility::play_sound_in_space, "scn_highway_gas_truck_gas_leak", var_0);
  wait 10;
  var_1 delete();
}

gas_getbarrels() {
  return getEntArray("gas_barrel", "targetname");
}

gas_playerpistolweaponlogic() {
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
  level.player giveweapon(var_0, 0, 0, 0, 1);
  level.player switchtoweapon(var_0);
  level.player setweaponammostock(var_0, 0);
  level.player scripts\common\utility::allow_reload(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\common\utility::allow_weapon_pickup(0);
  level.player scripts\common\utility::allow_weapon_switch(0);
  level.player disableemptyclipweaponswitch(1);
}

gas_killai() {
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(32, 0);
  scripts\sp\maps\highway\highway_utility.gsc::level_setflag(64, 0);
  var_0 = getaiarray();
  var_1 = level_getheroes();
  var_2 = scripts\engine\utility::array_remove_array(var_0, var_1);

  foreach(var_4 in var_2) {
    if(istrue(var_4.magic_bullet_shield))
      var_4 scripts\common\ai::stop_magic_bullet_shield();

    if(isDefined(var_4.weapon) && !scripts\sp\maps\highway\highway_utility.gsc::weapon_empty(var_4.weapon))
      var_4 scripts\common\ai::gun_remove();

    var_4 scripts\sp\utility::do_damage(var_4.health + 9999, var_4.origin, undefined, undefined, "MOD_GRENADE", "molotov");
  }
}

gas_playerexposedlogic() {
  level.player endon("death");
  visionsetnaked("highway_gas_close", 1.5);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  level.player scripts\common\utility::allow_mount_side(0);
  level.player scripts\common\utility::allow_mount_top(0);
  var_0 = "ges_frag_block";

  if(!scripts\sp\maps\highway\highway_utility.gsc::weapon_empty(level.player.currentweapon))
    level.player scripts\engine\sp\utility::player_gesture_force(var_0);

  wait(level.player getgestureanimlength(var_0));
  thread gas_playerexposedproneimpactlogic();
  thread gas_playerexposedblurlogic();
  thread gas_playerexposedfovlogic();
  thread gas_playerexposedspeedlogic();
  var_1 = 0.15;
  var_2 = 22.0 * var_1;
  var_3 = 1.0;
  var_4 = scripts\sp\hud_util::create_client_overlay("ui_black_circle_vignette", 0);
  var_4 fadeovertime(var_2);
  var_4.alpha = var_3;
  var_5 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_6 = level.player scripts\engine\utility::spawn_script_origin();
  var_6 linkTo(level.player);
  thread gas_playerexposedblackoverlaylogic(var_5, var_6);
  var_7 = gettime();
  var_8 = var_7 + 22000;
  var_9 = getEnt("gas_playerPassOutTrigger", "targetname");
  var_10 = ["ges_ph_cough_a", "ges_ph_cough_c", "ges_ph_cough_a", "ges_ph_cough_b", "ges_ph_cough_c"];
  var_11 = ["gas_player_cough_1", "gas_player_cough_1", "gas_player_cough_3", "gas_player_cough_3", "gas_player_cough"];
  var_12 = var_10[0];
  var_13 = var_10;
  var_14 = var_11;
  var_15 = 0;
  var_16 = 500;
  var_17 = 200;
  var_18 = 1000;
  var_19 = 400;
  var_20 = 1100;
  var_21 = scripts\engine\math::normalize_value(var_7, var_7 + 22000, gettime());
  var_22 = scripts\engine\math::factor_value(var_17, var_19, var_21);
  var_23 = scripts\engine\math::factor_value(var_18, var_20, var_21);
  var_24 = randomfloatrange(var_22, var_23);
  var_25 = gettime() + var_24;

  for(;;) {
    if(level.player istouching(var_9)) {
      break;
    }

    var_26 = gettime();

    if(var_26 >= var_8) {
      break;
    }

    var_21 = scripts\engine\math::normalize_value(var_7, var_8, var_26);

    if(!var_15 && var_26 >= var_7 + var_16) {
      playFXOnTag(level._effect["vfx_tear_gas_screen"], level.player, "tag_origin");
      var_15 = 1;
    }

    if(var_26 >= var_25) {
      if(var_13.size) {
        var_27 = var_13[0];
        level.player thread scripts\sp\player\gestures::player_gestures_input_disable(var_27, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1);
        level.player playgestureviewmodel(var_27);
        var_28 = level.player getgestureanimlength(var_27) * 1000;
        var_13 = scripts\engine\utility::array_remove(var_13, var_27);
      } else
        var_28 = 0;

      if(!var_14.size)
        var_14 = var_11;

      var_29 = var_14[0];
      level.player playSound(var_29);
      level.player playRumbleOnEntity("damage_light");
      var_14 = scripts\engine\utility::array_remove(var_14, var_29);
      var_22 = scripts\engine\math::factor_value(var_17, var_19, var_21);
      var_23 = scripts\engine\math::factor_value(var_18, var_20, var_21);
      var_24 = randomfloatrange(var_22, var_23);
      var_30 = lookupsoundlength(var_29);
      var_24 = var_24 + max(var_28, var_30);
      var_25 = gettime() + var_24;
    }

    waitframe();
  }

  level notify("gas_playerPassedOutStart");
  thread gas_playerpassoutlogic();
  level waittill("gas_playerPassedOutEnd");
  var_4 destroy();
  var_5 destroy();
  var_6 delete();
  setblur(0, 0);
}

gas_playerexposedproneimpactlogic() {
  level.player endon("death");
  level endon("gas_playerPassedOutEnd");
  var_0 = player_isprone();
  var_1 = 0.15;

  for(;;) {
    if(player_isprone() && !var_0) {
      wait(var_1);
      level.player playRumbleOnEntity("damage_heavy");
      earthquake(0.3, 0.5, level.player.origin - (0, 0, 20), 99999);
    }

    var_0 = player_isprone();
    waitframe();
  }
}

gas_playerexposedblurlogic() {
  level.player endon("death");
  level endon("gas_playerPassedOutEnd");
  var_0 = 3.5;
  var_1 = 5.0;
  var_2 = 2.0;
  var_3 = 2.5;
  var_4 = 0.55;
  var_5 = 0.65;
  var_6 = 1.1;
  var_7 = 1.25;

  for(;;) {
    var_8 = randomfloatrange(var_2, var_3);
    var_9 = randomfloatrange(var_4, var_5);
    setblur(var_8, var_9);
    wait(var_9);
    var_10 = randomfloatrange(var_6, var_7);
    setblur(0, var_10);
    wait(var_10);
    var_11 = randomfloatrange(var_0, var_1);
    wait(var_11);
  }
}

gas_playerexposedfovlogic() {
  level.player endon("death");
  level endon("gas_playerPassedOutEnd");
  var_0 = gettime();
  var_1 = var_0 + 22000;
  var_2 = 55;
  var_3 = 65;
  var_4 = 4.0;
  var_5 = 6.0;
  var_6 = 5.0;
  var_7 = 7.0;
  var_8 = 0;

  for(;;) {
    var_9 = gettime();
    var_10 = scripts\engine\math::normalize_value(var_0, var_1, var_9);
    var_11 = 1 - var_10;
    var_12 = sin(var_8);
    var_13 = scripts\engine\math::factor_value(var_4, var_5, var_10);
    var_14 = var_12 * var_13;
    var_15 = scripts\engine\math::factor_value(var_2, var_3, var_11);
    var_16 = var_15 + var_14;
    level.player modifybasefov(var_16, 0.05);
    var_17 = scripts\engine\math::factor_value(var_6, var_7, var_10);
    var_8 = scripts\engine\math::wrap(0, 360, var_8 + var_17);
    waitframe();
  }
}

gas_playerexposedspeedlogic() {
  level.player endon("death");
  level endon("gas_playerPassedOutEnd");
  var_0 = 85;
  var_1 = 0.3;
  var_2 = 22.0 * var_1;
  scripts\engine\sp\utility::player_speed_set(var_0, var_2);
}

gas_playerexposedblackoverlaylogic(var_0, var_1) {
  level.player endon("death");
  level endon("gas_playerPassedOutEnd");
  var_2 = gettime();
  var_3 = var_2 + 22000;
  var_4 = 0.5;
  var_5 = 6.0;
  var_6 = 0.5;
  var_7 = 0.7;
  var_8 = 0.05;
  var_9 = 0.3;
  var_10 = 0.5;
  var_11 = 1.2;
  var_12 = 0.5;
  var_13 = 1.0;

  for(;;) {
    var_14 = gettime();
    var_15 = scripts\engine\math::normalize_value(var_2, var_3, var_14);
    var_16 = 1 - var_15;
    var_17 = scripts\engine\math::factor_value(var_4, var_5, var_16);
    var_18 = scripts\engine\math::factor_value(var_6, var_7, var_15);
    var_19 = scripts\engine\math::factor_value(var_8, var_9, var_15);
    wait(var_17);
    var_0 fadeovertime(var_18);
    var_20 = scripts\engine\math::factor_value(var_12, var_13, var_15);
    var_0.alpha = var_20;
    wait(var_18);
    var_1 playSound("gas_heartbeat");
    level.player playRumbleOnEntity("damage_heavy");
    wait(var_19);
    var_21 = scripts\engine\math::factor_value(var_10, var_11, var_15);
    var_0 fadeovertime(var_21);
    var_0.alpha = 0;
    wait(var_21);
  }
}

gas_playerpassoutlogic() {
  var_0 = "ges_stumble_2";
  var_1 = 1.5;
  level.player scripts\common\utility::allow_mantle(0);
  level.player scripts\common\utility::allow_sprint(0);
  level.player scripts\common\utility::allow_fire(0);
  level.player scripts\common\utility::allow_reload(0);
  level.player scripts\common\utility::allow_weapon_switch(0);
  level.player scripts\common\utility::allow_ads(0);
  level.player scripts\common\utility::allow_melee(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  wait(var_1 - 0.5);
  level.player playSound("player_death_generic");
  level.player setsoundsubmix("sp_hwy_fade_outs", 7.0, 1.0);
  wait 0.5;
  level.player giveweapon("iw8_gunless");
  level.player switchtoweapon("iw8_gunless");
  level.player allowcrouch(0);
  level.player allowstand(0);
  var_2 = 1.0;
  wait(var_2);
  var_3 = 2.0;
  var_4 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_4 fadeovertime(var_3);
  var_4.alpha = 1.0;
  wait(var_3);
  level notify("gas_playerPassedOutEnd");
  level.player allowstand(1);
  level.player allowprone(0);
  wait 4.0;
  var_4 destroy();
}

gas_getplayermask() {
  return getEnt("gas_playerGasMask", "targetname");
}

gas_dialoguelogic() {
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_gas_truck_60", 6.5);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_gas_truck_65", 0.5);
  var_0 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_gas_truck_70", 0.5);
  var_1 scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_had_gas_truck_72", 0.5);
}

gas_objectivelogic() {
  level.player scripts\sp\player::set_focus_objectives_update_display(0);
  level.player scripts\sp\player::set_focus_infinite_hold(0);
  scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_GET_GAS_MASK", (784, -2088, 928), &"HIGHWAY/LABEL_GAS_MASK");
}

gas_getanimationstruct() {
  return scripts\engine\utility::getStruct("gas_animationStruct", "targetname");
}

drag_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_battlechatter(0);
  var_1 = level_spawnhadir();
  var_1 scripts\engine\sp\utility::set_battlechatter(0);
  level_hadirattachgasmask();
  visionsetnaked("highway_gas_close", 0);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  level.player giveweapon("iw8_gunless");
  level.player switchtoweapon("iw8_gunless");
  thread audio_post_gas();
}

drag_main() {
  level.player clearsoundsubmix("sp_hwy_fade_outs", 7.0);
  level.player setsoundsubmix("sp_hwy_amb_scn_lpf", 1.0, 1.0);
  scripts\sp\maps\highway\highway_utility.gsc::level_deletepreviousobjective();
  scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SURVIVE");
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_1, "");
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_0, "");
  setsaveddvar("NLPLNQSNNR", 0.05);
  var_2 = scripts\sp\hud_util::create_client_overlay("black", 1);
  var_3 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_4 = scripts\sp\hud_util::create_client_overlay("ui_black_circle_vignette", 1);
  thread drag_playerfovlogic();
  thread drag_playerblurlogic();
  thread drag_playerblackoverlaylogic(var_3);
  var_5 = scripts\engine\utility::getStruct("drag_animationStruct", "targetname");
  var_6 = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  level.player hidelegsandshadow();
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  var_7 = scripts\engine\sp\utility::spawn_anim_model("drag_playerGasMask");
  var_5 scripts\common\anim::anim_first_frame_solo(var_6, "bunker_sceneBEnter");
  thread scripts\sp\maps\highway\highway_utility.gsc::player_rigenter(var_6, 0, 0, 0, 0, 0);
  var_5 thread scripts\common\anim::anim_single([var_6, var_7, var_1], "drag_enter");
  thread drag_playergasmaskoverlaylogic(var_1);
  var_8 = 1.0;
  var_2 fadeovertime(var_8);
  var_2.alpha = 0.0;
  var_9 = var_6 scripts\engine\utility::getanim("drag_enter");
  var_10 = getanimlength(var_9);
  var_11 = 2.0;
  wait(var_10 - var_11);
  var_2 fadeovertime(var_11);
  var_2.alpha = 1.0;
  wait(var_11);
  level notify("drag_end");
  wait 1.5;
  var_2 destroy();
  var_3 destroy();
  var_4 destroy();
  level.player modifybasefov(65, 0.05);
  setblur(0, 0);
  scripts\sp\maps\highway\highway_utility.gsc::player_rigexit(var_6);
  var_7 scripts\engine\sp\utility::anim_stopanimScripted();
  var_7 linktoplayerview(level.player, "tag_camera", (0, 0, 0), (0, 0, 0), 1);
}

drag_playergasmaskoverlaylogic(var_0) {
  scripts\sp\maps\highway\highway_utility.gsc::animation_waittillnotetrack(var_0, "drag_overlay");
  level.player setsoundsubmix("sp_hwy_fade_outs", 9.0, 1.0);
  player_putgasmaskon();
}

drag_playerblurlogic() {
  level endon("drag_end");
  var_0 = 2.0;
  wait(var_0);
  var_1 = 2.0;
  var_2 = 3.0;
  var_3 = 2.0;
  var_4 = 2.5;
  var_5 = 0.55;
  var_6 = 0.65;
  var_7 = 1.1;
  var_8 = 1.25;

  for(;;) {
    var_9 = randomfloatrange(var_3, var_4);
    var_10 = randomfloatrange(var_5, var_6);
    setblur(var_9, var_10);
    wait(var_10);
    var_11 = randomfloatrange(var_7, var_8);
    setblur(0, var_11);
    wait(var_11);
    var_12 = randomfloatrange(var_1, var_2);
    wait(var_12);
  }
}

drag_playerfovlogic() {
  level endon("drag_end");
  var_0 = 60;
  level.player modifybasefov(var_0, 0.05);
  level.player lerpfovscalefactor(0, 0.05);
  var_1 = 1.4;
  wait(var_1);
  var_2 = 7.0;
  var_3 = 3.0;
  var_4 = 0;

  for(;;) {
    var_5 = sin(var_4);
    var_6 = var_5 * var_2;
    var_7 = var_0 + var_6;
    level.player modifybasefov(var_7, 0.05);
    var_4 = scripts\engine\math::wrap(0, 360, var_4 + var_3);
    waitframe();
  }
}

drag_playerblackoverlaylogic(var_0) {
  level endon("drag_end");
  var_1 = 2.0;
  wait(var_1);
  var_2 = 0.5;
  var_3 = 2.0;
  var_4 = 0.5;
  var_5 = 0.7;
  var_6 = 0.05;
  var_7 = 0.3;
  var_8 = 0.5;
  var_9 = 1.2;
  var_10 = 0.5;
  var_11 = 1.0;

  for(;;) {
    var_12 = randomfloatrange(var_2, var_3);
    wait(var_12);
    var_13 = randomfloatrange(var_4, var_5);
    var_0 fadeovertime(var_13);
    var_14 = randomfloatrange(var_10, var_11);
    var_0.alpha = var_14;
    wait(var_13);
    var_15 = randomfloatrange(var_6, var_7);
    wait(var_15);
    var_16 = randomfloatrange(var_8, var_9);
    var_0 fadeovertime(var_16);
    var_0.alpha = 0;
    wait(var_16);
  }
}

bunker_start() {
  var_0 = level_spawnfarah();
  var_0 scripts\engine\sp\utility::set_battlechatter(0);
  var_1 = level_spawnhadir();
  var_1 scripts\engine\sp\utility::set_battlechatter(0);
  scripts\engine\sp\utility::set_start_location("start_bunker", [level.player, var_0, var_1]);
  level_hadirattachgasmask();
  player_givefullloadout();
  scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SURVIVE");
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  thread audio_post_gas();
}

bunker_main() {
  level.player setclienttriggeraudiozone("highway_ending_05", 1.0);
  level.player clearsoundsubmix("sp_hwy_fade_outs", 3.0);
  visionsetnaked("highway_gas_bunker");
  thread scripts\sp\maps\highway\highway_lighting.gsc::lighting_bunker();
  thread bunker_blackoverlaylogic();
  scripts\engine\sp\utility::transient_unload("highway_main_tr");
  setsaveddvar("MMLNNQSTTL", 0);
  scripts\engine\utility::exploder("gas_bunker");
  scripts\engine\utility::delaythread(0.05, scripts\engine\sp\utility::nextmission_preload, "full", 1);
  level_closebunkerouterdoor();
  bunker_outrologic();

  while(!ispreloadzonescomplete())
    waitframe();

  scripts\engine\sp\utility::nextmission();
}

bunker_blackoverlaylogic() {
  var_0 = scripts\sp\hud_util::create_client_overlay("black", 1);
  var_1 = 1.0;
  wait(var_1);
  var_2 = 1.0;
  var_0 fadeovertime(var_2);
  var_0.alpha = 0.0;
}

bunker_outrologic() {
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  var_2 = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_1, "");
  scripts\sp\maps\highway\highway_utility.gsc::ai_setname(var_0, "");

  if(isDefined(var_0.hatmodel))
    var_0 detach(var_0.hatmodel);

  scripts\sp\maps\highway\highway_utility.gsc::ai_attachhead(var_0, "head_hero_farah_gasmask");
  var_0 scripts\common\ai::gun_remove();
  var_0.anim_playvo_func = scripts\engine\utility::playsoundontag;
  var_1.anim_playvo_func = scripts\engine\utility::playsoundontag;
  var_3 = gas_getanimationstruct();
  var_3 scripts\common\anim::anim_first_frame_solo(var_2, "bunker_sceneBEnter");
  thread scripts\sp\maps\highway\highway_lighting.gsc::lighting_dof_bunker();
  thread scripts\sp\maps\highway\highway_utility.gsc::player_rigenter(var_2, 0, 0, 0, 0, 0);
  var_4 = 2.0;
  level.player lerpviewangleclamp(var_4, 0, 0, 15, 15, 15, 0);
  level.player springcamenabled(var_4, 3, 1);
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_1);
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\highway\highway_utility.gsc::animation_stoploop(var_0);
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintolastframe(var_3, var_2, "bunker_sceneBEnter");
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintolastframe(var_3, var_0, "bunker_sceneBEnter");
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintolastframe(var_3, var_1, "bunker_sceneBEnter");
  level.player scripts\engine\utility::delaycall(30.0, ::setsoundsubmix, "sp_hwy_fade_out_mus", 17.0);
  var_2 waittillmatch("single anim", "bunker_fade_out");
  level.player clearpriorityclienttriggeraudiozone("deathsdoor");
  level.player clearsoundsubmix("deaths_door_sp", 2.5);
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 3.5);
  level.player clearsoundsubmix("sp_hwy_amb_scn_lpf", 5.0);
  var_5 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_5.sort = 5;
  var_5 fadeovertime(3.0);
  var_5.alpha = 1.0;
  level.player springcamdisabled(0);
  var_0.anim_playvo_func = undefined;
  var_1.anim_playvo_func = undefined;
  wait 3.0;
}

player_givefullloadout() {
  player_givesecondaryweapon();
  player_giveballisticsweapon();
  player_givesecondaryoffhandweapon();
}

player_isprone() {
  return level.player getstance() == "prone";
}

player_zoomedin() {
  return level.player.zoomedin;
}

player_zoomedout() {
  return !level.player.zoomedin;
}

player_throwingmolotov() {
  return level.player fragButtonPressed() && scripts\engine\utility::is_equal(level.player.offhandweapon, player_getoffhandsecondaryweaponobject());
}

player_giveballisticsweapon() {
  var_0 = player_getballisticsweaponobject();
  level.player giveweapon(var_0);
  level.player switchtoweapon(var_0);
  level.player setweaponammostock(var_0, weaponmaxammo(var_0));
}

player_givesecondaryweapon() {
  var_0 = player_getsecondaryweaponobject();
  level.player giveweapon(var_0);
  level.player switchtoweapon(var_0);
}

player_giveprimaryoffhandweapon() {
  level.player scripts\engine\sp\utility::give_offhand("frag");
  level.player setweaponammoclip("frag", 2);
}

player_givesecondaryoffhandweapon() {
  level.player scripts\engine\sp\utility::give_offhand("molotov");
  level.player givemaxammo("molotov");
}

player_getballisticsweaponobject() {
  return scripts\sp\utility::make_weapon_special("hadir_sniper");
}

player_holdingballisticsweapon() {
  return level.player.currentweapon == player_getballisticsweaponobject();
}

player_getdroppedsniper() {
  return getEnt("ballistics_weaponDropped", "targetname");
}

player_fullads() {
  return level.player playerads() == 1;
}

player_getprimaryweaponname() {
  return "iw8_sn_hdromeo_ballistics+back_hdromeo|1+bipod_hdromeo_ballistics+front_hdromeo|1+mag_hdromeo|1+rec_hdromeo|1+vzscope_hdromeo_ballistics";
}

player_getsecondaryweaponobject() {
  return scripts\sp\utility::make_weapon("iw8_ar_akilo47");
}

player_getoffhandsecondaryweaponobject() {
  return getcompleteweaponname("molotov");
}

player_ontownrooftop(var_0) {
  var_1 = player_gettouchingtownrooftoptrigger(var_0);
  return isDefined(var_1);
}

player_gettouchingtownrooftoptrigger(var_0) {
  var_1 = level_gettownrooftoptriggers(var_0);

  foreach(var_3 in var_1) {
    if(level.player istouching(var_3))
      return var_3;
  }

  return undefined;
}

player_putgasmaskon(var_0) {
  var_1 = scripts\sp\hud_util::create_client_overlay("gasmask_overlay_delta2", 1);
  var_1 fadeovertime(0.25);
  var_1.alpha = 1;
  var_1.lowresbackground = 1;
}

player_getflag(var_0) {
  return level.player.flags &var_0;
}

player_setflag(var_0, var_1) {
  if(var_1)
    level.player.flags = level.player.flags | var_0;
  else
    level.player.flags = level.player.flags &~var_0;
}

player_trackvariablezoom() {
  level.player endon("death");
  level.player.zoomedin = 0;
  thread player_trackadsfullout();
  thread player_setsunshadowsforzoom();

  for(;;) {
    var_0 = level.player scripts\engine\utility::waittill_any_return("sprint_pressed", "player_fullyReleasedADS");

    if(scripts\engine\utility::is_equal(var_0, "sprint_pressed") && player_fullads() && player_holdingballisticsweapon()) {
      level.player.zoomedin = !level.player.zoomedin;

      if(level.player.zoomedin)
        level.player notify("player_variableZoomedIn");

      continue;
    }

    if(scripts\engine\utility::is_equal(var_0, "player_fullyReleasedADS") && player_holdingballisticsweapon())
      level.player.zoomedin = 0;
  }
}

player_setsunshadowsforzoom() {
  var_0 = level.sunsamplesizenear;
  var_1 = level.suncascademult1;
  var_2 = level.suncascademult2;
  var_3 = level.sunsamplesizenear;
  var_4 = 0;

  for(;;) {
    var_5 = level.player playerads();
    var_6 = scripts\engine\utility::ter_op(level.player.zoomedin, 0.2, -0.2);
    var_4 = var_4 + var_6;
    var_4 = clamp(var_4, 0, 1);

    if(var_5 > 0.7 && player_holdingballisticsweapon()) {
      if(var_4 > 0.5) {
        var_0 = 1.7;
        var_1 = 2;
        var_2 = 2;
      } else {
        var_0 = 1.3;
        var_1 = 2;
        var_2 = 2;
      }
    } else {
      var_0 = level.sunsamplesizenear;
      var_1 = level.suncascademult1;
      var_2 = level.suncascademult2;
    }

    if(var_3 != var_0) {
      setsaveddvar("NPONLLLSPL", var_0);
      setsaveddvar("LSNRQTOKRR", var_1);
      setsaveddvar("NTLKNLNPLK", var_2);
      var_3 = var_0;
    }

    waitframe();
  }
}

player_trackadsfullout() {
  var_0 = level.player playerads();

  for(;;) {
    var_1 = level.player playerads();

    if(!var_1 && var_0)
      level.player notify("player_fullyReleasedADS");

    var_0 = var_1;
    waitframe();
  }
}

player_dropballisticsweaponlogic() {
  for(;;) {
    level.player waittill("pickup", var_0, var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = "weapon_";
    var_3 = getsubstr(var_1.classname, 0, var_2.size + "iw8_sn_hdromeo_ballistics".size) == var_2 + "iw8_sn_hdromeo_ballistics";

    if(!var_3) {
      continue;
    }
    var_4 = player_getballisticsweaponobject();
    var_5 = spawn("script_model", var_1.origin);
    var_5.angles = var_1.angles;
    var_5 setModel(getweaponmodel(var_4));
    var_6 = getweaponattachmentworldmodels(var_4);

    foreach(var_8 in var_6)
    var_5 attach(var_8);

    thread player_dropballisticsweaponinteractlogic(var_5, var_4);
    var_1 delete();
  }
}

player_dropballisticsweaponinteractlogic(var_0, var_1) {
  var_0 endon("entitydeleted");
  var_0.targetname = "ballistics_weaponDropped";
  var_2 = var_0 physics_getentitycenterofmass()["unscaled"] + (0, 0, 5);
  var_3 = spawnStruct();
  var_3.origin = var_2;
  var_3 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), undefined, undefined, undefined, 80, 1);
  var_3 waittill("trigger");
  var_4 = level.player.currentweapon;

  if(scripts\sp\maps\highway\highway_utility.gsc::weapon_empty(var_4))
    var_4 = level.player.primaryweapons[0];

  level.player takeweapon(var_4);
  var_5 = spawn("weapon_" + createheadicon(var_4), var_2);
  var_5.angles = var_0.angles;
  level.player giveweapon(var_1, 0, 0, 0, 1);
  level.player switchtoweapon(var_1);
  var_0 delete();
}

player_sniperzoomedin() {
  return player_holdingballisticsweapon() && player_fullads() && level.player.zoomedin;
}

vehicle_spawnsuicidetruck(var_0, var_1) {
  var_2 = scripts\common\utility::getvehiclespawner(var_0, "targetname");
  var_3 = var_2 scripts\common\utility::spawn_vehicle();
  var_3.targetname = var_1;
  var_3.dontunloadonend = 1;
  var_3 notsolid();
  var_3 scripts\common\vehicle::godon();
  var_3 vehicle_teleport(var_2.origin, var_2.angles);
  var_3.armorplates = [];
  var_3.driverwindow = undefined;
  var_4 = getEntArray(var_2.target, "targetname");

  foreach(var_6 in var_4) {
    if(isai(var_6)) {
      continue;
    }
    var_7 = var_6.origin - var_2.origin;
    var_6.origin = var_3.origin + var_7;

    if(scripts\engine\utility::is_equal(var_6.script_noteworthy, "vehicle_engineBlock")) {
      var_6.ballisticdontpenetrate = 1;
      var_6 linkTo(var_3);
      var_3.engineblock = var_6;
    }

    if(scripts\engine\utility::is_equal(var_6.script_noteworthy, "vehicle_suicideTruckArmor")) {
      var_6.ballisticdontpenetrate = 1;
      var_6 linkTo(var_3);
      var_8 = getEntArray(var_6.target, "targetname");

      foreach(var_10 in var_8) {
        var_10 linkTo(var_3, "tag_body_animate");
        level.ballistics.ignoreentities = scripts\engine\utility::array_add(level.ballistics.ignoreentities, var_10);
      }

      var_3.armorplates = scripts\engine\utility::array_add(var_3.armorplates, var_6);
    }

    if(scripts\engine\utility::is_equal(var_6.script_noteworthy, "vehicle_suicideTruckDriverWindow")) {
      var_6.ballisticdontpenetrate = 1;
      var_6 linkTo(var_3);
      var_3.driverwindow = var_6;
    }
  }

  return var_3;
}

vehicle_suicidetrucklogic(var_0) {
  var_0 endon("vehicle_disabled");

  foreach(var_2 in var_0.armorplates)
  thread vehicle_suicidetruckarmorlogic(var_2, var_0);

  thread vehicle_suicidetruckcrashlogic(var_0);
  thread vehicle_suicidetruckengineblocklogic(var_0);
  thread vehicle_suicidetruckriderslogic(var_0);
  thread vehicle_suicidetruckrunoverlogic(var_0);
  thread scripts\common\vehicle_paths::gopath(var_0);
  var_0 playSound("scn_highway_suicide_truck_ridge_01");
  var_0 waittill("reached_end_node");
  vehicle_suicidetruckexplode(var_0, 1);
}

suicide_musiclogic() {
  var_0 = 1.5;
  var_1 = level scripts\engine\utility::waittill_notify_or_timeout_return("vehicle_suicideTruckExplode", var_0);

  if(var_1 == "vehicle_suicideTruckExplode") {
    return;
  }
  setmusicstate("mx_highway_suicidetruck");
  level waittill("vehicle_suicideTruckExplode");
  setmusicstate("");
}

vehicle_suicidetruckcrashlogic(var_0) {
  var_0 endon("reached_end_node");
  level endon("vehicle_suicideTruckExplode");
  var_0 waittill("vehicle_disabled");
  var_0 setanim(%hod_vehicle_crash_truck);
  var_0 playLoopSound("veh_suicide_truck_highway_engine_high_crash");
  var_1 = var_0.currentnode;

  if(!isDefined(var_1.target)) {
    thread vehicle_suicidetruckexplode(var_0, 0);
    return;
  }

  var_2 = getvehiclenode(var_1.target, "targetname");
  var_3 = undefined;
  var_4 = scripts\engine\math::scalar_projection(anglesToForward(var_0.angles), var_1.origin - var_0.origin);
  var_5 = scripts\engine\math::scalar_projection(anglesToForward(var_0.angles), var_2.origin - var_0.origin);
  var_6 = max(var_4, var_5);

  if(var_6 == var_4)
    var_3 = var_1;
  else if(var_6 == var_5)
    var_3 = var_2;

  if(isDefined(var_3)) {
    var_7 = vehicle_findnextcrashpath(var_0, var_3);

    if(isDefined(var_7)) {
      var_8 = var_0 vehicle_getspeed();
      var_0 scripts\common\vehicle::vehicle_switch_paths(var_3, var_7);
      var_0 vehicle_setspeed(var_8 + 10, 1, 1);

      if(var_7.origin == (-3516, 5352, -337.664))
        var_0 thread scripts\engine\sp\utility::notify_delay("reached_end_node", 2);

      thread vehicle_suicidetruckexplodeoncrashpathend(var_0);
    } else
      thread vehicle_suicidetruckexplode(var_0, 0);
  }
}

vehicle_suicidetruckexplodeoncrashpathend(var_0) {
  var_0 waittill("reached_end_node");
  vehicle_suicidetruckexplode(var_0, 0);
}

vehicle_suicidetruckengineblocklogic(var_0) {
  var_0.engineblock waittill("ballistics_bulletDamage", var_1);

  if(var_0 scripts\engine\math::is_point_on_right(var_1))
    var_0 setanim(%hod_vehicle_hit_l_truck);
  else
    var_0 setanim(%hod_vehicle_hit_r_truck);

  var_2 = 15;
  var_3 = -15;
  var_4 = var_0 gettagorigin("TAG_HOOD");
  var_4 = var_4 + anglesToForward(var_0.angles) * var_2;
  var_4 = var_4 + anglestoup(var_0.angles) * var_3;
  var_5 = scripts\engine\utility::spawn_tag_origin(var_4);
  var_5 linkTo(var_0);
  var_0 hidepart("TAG_HOOD");
  playFXOnTag(level._effect["vfx_suicide_truck_disable"], var_5, "tag_origin");
  var_0 thread scripts\engine\sp\utility::play_sound_on_tag("scn_highway_truck_engine_block_destr", "tag_origin");

  foreach(var_7 in var_0.armorplates) {
    if(!scripts\engine\utility::is_equal(var_7.script_parameters, "vehicle_suicideTruckArmorDisabledLaunch")) {
      continue;
    }
    var_8 = getEntArray(var_7.target, "targetname");

    foreach(var_10 in var_8)
    vehicle_suicidetrucklaunchmesh(var_0, var_10);

    var_7 delete();
    var_0.armorplates = scripts\engine\utility::array_remove(var_0.armorplates, var_7);
  }

  var_13 = var_0 vehicle_getspeed();

  if(var_13)
    var_0 thread scripts\engine\sp\utility::play_sound_on_tag("scn_highway_truck_engine_block_die", "tag_origin");

  var_0 notify("vehicle_disabled", 0);
}

vehicle_suicidetruckarmorlogic(var_0, var_1) {
  var_1 endon("reached_end_node");
  var_0 endon("death");
  var_0 waittill("ballistics_bulletDamage", var_2);
  level notify("vehicle_suicideTruckArmorBreak");
  var_1 clearanim(%hod_vehicle_hit_l_truck, 0);
  var_1 clearanim(%hod_vehicle_hit_r_truck, 0);

  if(var_0 scripts\engine\math::is_point_on_right(var_2))
    var_1 setanim(%hod_vehicle_hit_l_truck);
  else
    var_1 setanim(%hod_vehicle_hit_r_truck);

  var_3 = var_0.origin + anglesToForward(var_1.angles) * var_1 vehicle_getspeed();
  playFX(level._effect["vfx_suicide_truck_armor_break"], var_3, anglesToForward(var_1.angles) * -1, anglestoup(var_1.angles));
  thread scripts\engine\utility::play_sound_in_space("scn_highway_suicide_truck_armor_destr", var_3);
  var_1.armorplates = scripts\engine\utility::array_remove(var_1.armorplates, var_0);
  var_4 = getEntArray(var_0.target, "targetname");

  foreach(var_6 in var_4)
  vehicle_suicidetrucklaunchmesh(var_1, var_6);

  var_0 delete();
}

vehicle_suicidetrucklaunchmesh(var_0, var_1) {
  var_1 unlink();
  var_2 = vectorNormalize(var_1.origin - var_0.origin);
  var_2 = scripts\engine\utility::flatten_vector(var_2);
  var_1 physicslaunchserver(var_1.origin, var_2 * 15000);
}

vehicle_suicidetruckriderslogic(var_0) {
  var_0 endon("reached_end_node");
  var_1 = var_0 scripts\engine\sp\utility::get_linked_spawners()[0];
  var_2 = var_1 scripts\engine\sp\utility::spawn_ai(1, 1);
  var_2 linkTo(var_0, "tag_driver", (0, 0, 0), (0, 0, 0));
  var_2.ridingvehicle = var_0;
  var_2.script_parameters = "ballistics_doNotDamage";
  var_0.riders = [var_2];
  var_2 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 scripts\engine\sp\utility::set_ignoreall(1);
  var_3 = "head_al_qatala_2_cqc";
  var_2 detach(var_2.headmodel);
  var_2.headmodel = var_3;
  var_2 attach(var_2.headmodel, "", 1);
  var_4 = 4.0;
  var_5 = 1.0;
  var_6 = var_0 gettagorigin("tag_driver");
  var_7 = var_0 gettagangles("tag_driver");
  var_6 = var_6 + anglesToForward(var_7) * var_4;
  var_6 = var_6 + anglestoup(var_7) * var_5;
  var_8 = scripts\engine\utility::spawn_script_origin(var_6, var_7);
  var_8 linkTo(var_0);
  var_2.animname = "suicide_driver";
  var_8 thread scripts\common\anim::anim_first_frame_solo(var_2, "suicide_driverIdle");
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_8, var_2, "suicide_driverIdle");
  thread vehicle_suicidetruckdriverandanimationcleanup(var_0, var_2, var_8);
  scripts\engine\utility::waittill_any_ents(var_0.driverwindow, "ballistics_bulletDamage", var_2, "ballistics_bulletDamage", var_2, "death");
  var_0 notify("vehicle_disabled", 1);
  var_9 = 4.0;
  var_10 = 10.0;
  var_11 = var_0 gettagorigin("tag_driver");
  var_12 = var_0 gettagangles("tag_driver");
  var_11 = var_11 + anglesToForward(var_12) * var_9;
  var_11 = var_11 + anglestoup(var_12) * var_10;
  var_8 = scripts\engine\utility::spawn_script_origin(var_11, var_12);
  var_8 linkTo(var_0);
  thread vehicle_suicidetruckdriverandanimationcleanup(var_0, var_2, var_8);
  playFX(level.g_effect["vfx_gib_explode"], var_2 gettagorigin("j_head"));
  var_8 thread scripts\common\anim::anim_first_frame_solo(var_2, "suicide_driverDeath");
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_singleintolastframe(var_8, var_2, "suicide_driverDeath");
  scripts\sp\utility::giveachievement_wrapper("driversed");
}

vehicle_suicidetruckdriverandanimationcleanup(var_0, var_1, var_2) {
  var_0 waittill("entitydeleted");

  if(isDefined(var_1) && isalive(var_1)) {
    var_1 scripts\common\ai::stop_magic_bullet_shield();
    var_1 delete();
  }

  if(isDefined(var_2))
    var_2 delete();
}

vehicle_suicidetruckrunoverlogic(var_0) {
  var_0 endon("reached_end_node");
  var_0 endon("vehicle_disabled");

  for(;;) {
    var_1 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
    var_1 = scripts\engine\utility::array_remove_array(var_1, var_0.riders);

    foreach(var_3 in var_1) {
      if(distancesquared(var_3.origin, var_0.origin) <= 12544)
        var_3 kill();
    }

    waitframe();
  }
}

vehicle_suicidetruckexplode(var_0, var_1) {
  var_2 = var_0.origin;
  level notify("vehicle_suicideTruckExplode");
  var_0 clearanim(%hod_vehicle_hit_r_truck, 0);
  var_0 setanim(%hod_vehicle_hit_r_truck);
  thread vehicle_suicidetrucksfxlogic(var_2);

  foreach(var_4 in var_0.armorplates) {
    var_5 = getEntArray(var_4.target, "targetname");

    foreach(var_7 in var_5)
    vehicle_suicidetrucklaunchmesh(var_0, var_7);

    var_4 delete();
    var_0.armorplates = scripts\engine\utility::array_remove(var_0.armorplates, var_4);
  }

  var_10 = vectorNormalize(level.player getEye() - var_2);
  playFX(level._effect["vfx_suicidetruck_explosion"], var_2, var_10);
  var_11 = distance(level.player.origin, var_2);
  var_12 = var_11 / 10000;
  var_13 = scripts\engine\math::normalize_value(0, 15000, var_11);
  var_14 = scripts\engine\math::factor_value(0.225, 0.325, var_13);
  var_15 = scripts\engine\math::factor_value(1.7, 3.2, var_13);
  var_16 = scripts\engine\math::factor_value(3.0, 4.0, var_13);

  if(isDefined(var_0.engineblock))
    var_0.engineblock delete();

  var_0 delete();
  wait(var_12);
  earthquake(var_14, var_15, var_2, 50000);
  playrumbleonposition("damage_heavy", var_2);
  level.player shellshock("explosion", var_16);

  if(var_1) {
    var_17 = level_getfarah();
    var_17 thread scripts\sp\maps\highway\highway_utility.gsc::dialogue("dx_vom_far_svbied_truck_110");
    level.player kill();
    wait 1.0;
    var_18 = scripts\sp\hud_util::create_client_overlay("black", 0, level.player);
    var_18 fadeovertime(0.3);
    var_18.alpha = 1;
  } else {
    wait(var_16);
    level notify("vehicle_suicideShellshockOver");
  }
}

vehicle_suicidetrucksfxlogic(var_0) {
  thread vehicle_suicidetruckfiresfxlogic(var_0);
  var_1 = spawn("script_origin", var_0 + (0, 0, 1));
  var_1 playexplosionsound("scn_highway_suicide_truck_expl", "exp");
  wait 10.0;
  var_1 delete();
}

vehicle_suicidetruckfiresfxlogic(var_0) {
  wait 2.0;
  var_1 = spawn("script_origin", var_0 + (0, 200, 15));
  var_1 playLoopSound("scn_highway_suicide_truck_fire_lp");
}

vehicle_spawnvindias(var_0, var_1) {
  var_2 = scripts\common\utility::getvehiclespawnerarray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_5 scripts\common\utility::spawn_vehicle();
    var_6.targetname = var_1;
    var_6.dontunloadonend = 1;
    var_6.donotunloadondriverdeath = 1;
    var_6 notsolid();
    var_6 scripts\common\vehicle::godon();
    var_6 vehicle_teleport(var_5.origin, var_5.angles);
    var_6 hide();
    var_6 scripts\engine\utility::ent_flag_set("no_riders_until_unload");
    scripts\engine\utility::array_delete(var_6.mgturret);
    var_6.mesh = spawn("script_model", var_6.origin);
    var_6.mesh.angles = var_6.angles;
    var_6.mesh setModel("veh8_mil_lnd_vindia_a2");
    var_6.mesh notsolid();
    var_6.mesh linkTo(var_6);
    var_7 = ["TAG_WHEEL_CENTER_FRONT_LEFT", "TAG_WHEEL_CENTER_MIDDLE_LEFT", "TAG_WHEEL_CENTER_BACK_LEFT", "TAG_WHEEL_CENTER_FRONT_RIGHT", "TAG_WHEEL_CENTER_MIDDLE_RIGHT", "TAG_WHEEL_CENTER_BACK_RIGHT"];

    foreach(var_9 in var_7)
    var_6.mesh hidepart(var_9);

    var_6.tireclips = [];
    var_11 = getEntArray(var_5.target, "targetname");

    foreach(var_13 in var_11) {
      if(isai(var_13)) {
        continue;
      }
      var_14 = var_13.origin - var_5.origin;
      var_15 = rotatevectorinverted(var_14, var_5.angles);
      var_16 = var_13.angles - var_5.angles;
      var_13 linkTo(var_6.mesh, "TAG_ORIGIN_ANIMATE", var_15, var_16);

      if(scripts\engine\utility::is_equal(var_13.script_noteworthy, "vehicle_vindiaTire")) {
        var_13.ballisticdontpenetrate = 1;
        var_6.tireclips = scripts\engine\utility::array_add(var_6.tireclips, var_13);
      }

      if(scripts\engine\utility::is_equal(var_13.script_noteworthy, "vehicle_vindiaBodyClip")) {
        var_13.ballisticdontpenetrate = 1;
        var_6.bodyclip = var_13;
      }
    }

    thread vehicle_vindiaspeeduplogic(var_6);
    thread vehicle_vindiadamagelogic(var_6);
    thread vehicle_vindiasmokegrenadelogic(var_6, 1);
    thread vehicle_vindiaunloadlogic(var_6);
    thread vehicle_vindiameshanimlogic(var_6);
    var_3 = scripts\engine\utility::array_add(var_3, var_6);
  }

  return var_3;
}

vehicle_vindiameshanimlogic(var_0) {
  thread vehicle_vindiameshanimdrivelogic(var_0);
  thread vehicle_vindiameshanimunloadlogic(var_0);
}

vehicle_vindiameshanimdrivelogic(var_0) {
  var_0 endon("reached_wait_speed");
  thread vehicle_vindiameshanimdrivecleanuplogic(var_0);
  var_0.mesh useanimtree(#animtree);

  for(;;) {
    var_1 = level.vehicle.templates.driveidle[var_0.model];

    if(var_0 vehicle_getspeed()) {
      var_0.mesh setanim(var_1);
      wait(getanimlength(var_1));
      continue;
    }

    var_0.mesh clearanim(var_1, 0);
    waitframe();
  }
}

vehicle_vindiameshanimdrivecleanuplogic(var_0) {
  var_0 waittill("reached_wait_speed");
  var_1 = level.vehicle.templates.driveidle[var_0.model];
  var_0.mesh clearanim(var_1, 0);
}

vehicle_vindiameshanimunloadlogic(var_0) {
  var_0 waittill("unloading");
  var_1 = level.vehicle.templates.driveidle[var_0.model];
  var_0.mesh clearanim(var_1, 0.25);
  var_0.mesh setanim(%vh_vindia_back_door_exit_combat_idle);
  var_0.mesh setanim(%vh_vindia_left_door_exit_combat_idle);
  var_0.mesh setanim(%vh_vindia_right_door_exit_combat_idle);
}

vehicle_vindiatirelogic(var_0, var_1) {
  var_2 = var_1.script_parameters;
  var_3 = getEnt(var_1.target, "targetname");
  var_3 notsolid();

  if(issubstr(tolower(var_2), "right")) {
    var_4 = (0, 0, 0);
    var_5 = (0, 180, 0);
  } else {
    var_4 = (0, 0, 0);
    var_5 = (0, 0, 0);
  }

  var_3 linkTo(var_0, var_2, var_4, var_5);
  var_1 solid();
  var_1 waittill("ballistics_bulletDamage", var_6);
  var_3 setModel("veh8_mil_lnd_vindia_wheel_01_dst");
  playFX(level._effect["vfx_vindia_tire_break"], var_1.origin, anglesToForward(var_1.angles));
  thread scripts\engine\utility::play_sound_in_space("scn_highway_apc_tires_expl", var_1.origin);
  var_0.mesh clearanim(%hod_vehicle_hit_l_apc, 0);
  var_0.mesh clearanim(%hod_vehicle_hit_r_apc, 0);

  if(var_0 scripts\engine\math::is_point_on_right(var_6))
    var_0.mesh setanim(%hod_vehicle_hit_l_apc);
  else
    var_0.mesh setanim(%hod_vehicle_hit_r_apc);

  playFXOnTag(level._effect["vfx_vindia_tire_sparks"], var_0.mesh, var_2);
  var_7 = 1.33333;
  var_8 = 1.33333;
  var_9 = 2.0;

  for(var_10 = 0; var_10 < 3; var_10++) {
    var_0.mesh unlink();
    var_11 = anglestoup(var_0.mesh.angles);
    var_0.mesh.origin = var_0.mesh.origin - var_11 * var_7;
    var_12 = anglesToForward(var_0.mesh.angles);
    var_13 = anglestoright(var_0.mesh.angles);
    var_14 = vectorNormalize(var_1.origin - var_0.origin);
    var_15 = scripts\engine\math::anglebetweenvectors(var_12, var_14);
    var_16 = scripts\engine\math::anglebetweenvectors(var_13, var_14);
    var_17 = cos(var_15);
    var_18 = cos(var_16);
    var_19 = var_17 * var_8;
    var_20 = var_18 * var_9;
    var_0.mesh.angles = var_0.mesh.angles + (var_19, 0, var_20);
    var_0.mesh linkTo(var_0);
    waitframe();
  }

  var_0 notify("vehicle_tireBreak", var_6);
  level notify("vehicle_tireBreak", var_0);
  var_1 delete();
  var_0 scripts\engine\utility::waittill_any("vehicle_disabled", "reached_end_node");
  stopFXOnTag(level._effect["vfx_vindia_tire_sparks"], var_0.mesh, var_2);
}

vehicle_vindiadamagelogic(var_0) {
  var_0 endon("reached_wait_speed");
  var_1 = level_getfarah();

  foreach(var_3 in var_0.tireclips)
  thread vehicle_vindiatirelogic(var_0, var_3);

  thread vehicle_vindiabodydamagelogic(var_0);
  var_5 = (0, 0, 0);

  for(var_6 = 0; var_6 < 3; var_6++) {
    var_0 waittill("vehicle_tireBreak", var_5);
    var_7 = var_0 vehicle_getspeed();
    var_8 = var_7 * 0.5;
    var_9 = var_6 + 1 == 3;

    if(!var_7 || !var_8 || var_9) {
      break;
    }

    var_0 vehicle_setspeed(var_8);
  }

  var_0 vehicle_setspeed(0, 30, 30);
  level notify("vehicle_vindiaDisable", var_0);
  var_0 notify("vehicle_disabled", var_5);
}

vehicle_vindiaspeeduplogic(var_0) {
  var_0 endon("reached_wait_speed");
  childthread vehicle_vindiaspeeduptimeoutlogic(var_0);
  level endon("level_vindiaSpeedUpTimeout");

  for(;;) {
    level waittill("vehicle_tireBreak", var_1);

    if(var_0 == var_1) {
      continue;
    }
    var_2 = var_0 vehicle_getspeed();

    if(var_2 < 12)
      var_2 = 12;

    var_0 vehicle_setspeed(var_2 * 1.15, 30);
  }
}

vehicle_vindiaspeeduptimeoutlogic(var_0) {
  wait 80;
  var_0 vehicle_setspeed(35, 30);
}

vehicle_vindiaunloadlogic(var_0) {
  var_0 waittill("reached_wait_speed");
  createnavobstaclebybounds(var_0.origin, (150, 60, 100), var_0.angles);
  wait 5.0;
  var_0 scripts\common\vehicle::vehicle_unload();
}

vehicle_vindiasmokegrenadelogic(var_0, var_1) {
  if(var_1) {
    var_0 waittill("reached_wait_speed");
    level notify("vehicle_vindiaSmokeGrenade");
  }

  var_2 = 1000;
  var_3 = 1500;
  var_4 = -60;
  var_5 = -50;
  var_6 = -120;
  var_7 = 120;
  vehicle_vindialaunchsmokegrenades(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

vehicle_vindialaunchsmokegrenades(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_6 - var_5;
  var_8 = var_7 / 6;
  wait 1.0;
  var_0 notify("vehicle_vindiaSmokeGrenadeDisperse");
  var_9 = scripts\engine\utility::spawn_tag_origin(var_0 gettagorigin("TAG_BODY") + (0, 0, -15), var_0.mesh.angles);
  var_10 = var_0.origin + anglesToForward(var_0.angles) * 300;
  playFX(level._effect["vfx_vindia_smk_gren_left"], var_10);
  thread scripts\engine\utility::play_sound_in_space("hod_smoke_grenade_smoke_tail", var_10);

  for(var_11 = var_5; var_11 < var_6; var_11 = var_11 + var_8) {
    var_12 = randomfloatrange(var_3, var_4);
    var_9.angles = var_0.mesh.angles + (var_12, var_11, 0);
    var_13 = anglesToForward(var_9.angles);
    var_14 = randomfloatrange(var_1, var_2);
    var_15 = var_14 * var_13;
    thread vehicle_vindiaspawnsmokegrenade(var_9.origin, var_15);
    thread vehicle_vindiasmokelaunchsfxlogic(var_9.origin);
    wait 0.3;
  }
}

vehicle_vindiasmokelaunchsfxlogic(var_0) {
  if(!isDefined(var_0))
    var_0 = level.player.origin;

  var_1 = spawn("script_origin", var_0 + (0, 0, 1));
  var_1 playSound("scn_highway_apc_smoke_launch_npc_med");
  wait 3.6;
  var_1 delete();
}

vehicle_vindiaspawnsmokegrenade(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("offhand_wm_grenade_smoke");
  var_2.targetname = "vehicle_vindiaSmokeGrenade";
  var_2 physicslaunchserver(var_2.origin, var_1);
  playFX(level._effect["vfx_vindia_smoke_grenade_fire"], var_0, vectorNormalize(var_1));
  playFXOnTag(level._effect["vfx_vindia_smoke_grenade_trail"], var_2, "tag_fx");
  wait(randomfloatrange(0.35, 0.55));

  if(isDefined(var_2))
    playFXOnTag(level._effect["vfx_vindia_smk_gren_left"], var_2, "tag_fx");
}

vehicle_getvindiasmokegrenades() {
  return getEntArray("vehicle_vindiaSmokeGrenade", "targetname");
}

vehicle_vindiabodydamagelogic(var_0) {
  var_0 endon("reached_end_node");
  var_0 endon("vehicle_disabled");

  for(;;) {
    var_0.bodyclip waittill("ballistics_bulletDamage");
    level notify("vehicle_vindiaBodyShot");
  }
}

vehicle_spawntechos(var_0, var_1) {
  var_2 = scripts\common\utility::getvehiclespawnerarray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_5 scripts\common\utility::spawn_vehicle();
    var_6.targetname = var_1;
    var_6.ballisticdontpenetrate = 1;
    var_6 scripts\common\vehicle::godon();
    var_6 hidepart("TAG_WINDSHIELD_FRONT");
    var_6 hidepart("TAG_WINDOW_FRONT_LEFT");
    var_6 hidepart("TAG_WINDOW_FRONT_RIGHT");
    var_6 hidepart("TAG_WINDOW_BACK_LEFT");
    var_6 hidepart("TAG_WINDOW_BACK_RIGHT");
    var_6 vehicle_teleport(var_5.origin, var_5.angles);
    var_7 = getEntArray(var_5.target, "targetname");

    foreach(var_9 in var_7) {
      if(isai(var_9)) {
        continue;
      }
      var_10 = var_9.origin - var_5.origin;
      var_9.origin = var_6.origin + var_10;

      if(scripts\engine\utility::is_equal(var_9.script_noteworthy, "vehicle_engineBlock")) {
        var_9.ballisticdontpenetrate = 1;
        var_9 linkTo(var_6);
        var_6.engineblock = var_9;
      }
    }

    var_3 = scripts\engine\utility::array_add(var_3, var_6);
  }

  return var_3;
}

vehicle_techodisablelogic(var_0) {
  var_0.engineblock waittill("ballistics_bulletDamage", var_1);
  var_2 = 15;
  var_3 = -15;
  var_4 = var_0 gettagorigin("TAG_HOOD");
  var_4 = var_4 + anglesToForward(var_0.angles) * var_2;
  var_4 = var_4 + anglestoup(var_0.angles) * var_3;
  var_5 = scripts\engine\utility::spawn_tag_origin(var_4);
  var_5 linkTo(var_0);
  var_0 hidepart("TAG_HOOD");
  playFXOnTag(level._effect["vfx_techo_disable"], var_5, "tag_origin");
  var_0 thread scripts\engine\sp\utility::play_sound_on_tag("scn_highway_truck_engine_block_destr", "tag_origin");

  if(var_0 scripts\engine\math::is_point_on_right(var_1))
    var_0 setanim(%hod_vehicle_hit_l_truck);
  else
    var_0 setanim(%hod_vehicle_hit_r_truck);

  if(var_0 vehicle_getspeed()) {
    var_0 notify("vehicle_disabled");
    level notify("vehicle_techoDisable");
    var_0 thread scripts\engine\sp\utility::play_sound_on_tag("scn_highway_truck_engine_block_die", "tag_origin");
    var_0 vehicle_setspeed(0, 30, 30);
    var_0 setwaitspeed(0);
    var_0.engineblock delete();
    var_0 waittill("reached_wait_speed");
    var_0 scripts\common\vehicle::vehicle_unload();
  }
}

vehicle_findnextcrashpath(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = var_1; isDefined(var_3); var_3 = getvehiclenode(var_3.target, "targetname")) {
    var_4 = vehicle_nodegetcrashpaths(var_3);

    foreach(var_6 in var_4) {
      if(distancesquared(var_0.origin, var_6.origin) < 250000) {
        continue;
      }
      var_2 = var_6;
    }

    if(isDefined(var_2)) {
      break;
    }

    if(!isDefined(var_3.target)) {
      break;
    }
  }

  return var_2;
}

vehicle_nodegetcrashpaths(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_linked_vehicle_nodes();

  foreach(var_3 in var_1) {
    if(istrue(var_3.crashpathused))
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
  }

  return var_1;
}

vehicle_suniform25effects(var_0) {
  var_1 = scripts\engine\sp\utility::get_rumble_ent();
  var_1.intensity = 0;

  while(isDefined(var_0)) {
    var_2 = distancesquared(var_0.origin, level.player.origin);
    var_1.intensity = 1 - scripts\engine\math::normalize_value(0, 25000000, var_2);

    if(var_2 <= 144000000) {
      var_3 = scripts\engine\math::normalize_value(0, 144000000, var_2);
      var_4 = 0.2 * var_3;
      var_5 = 4.0 * var_3;
      earthquake(var_4, var_5, var_0.origin, 12000);
    }

    waitframe();
  }

  var_1 delete();
}

vehicle_suniform25dropbomb(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = spawn("script_model", var_1);
  var_3 setModel("highway_suniform25_bomb");
  var_3.angles = var_2 + (0, 270, 0);
  playFXOnTag(level._effect["vfx_suniform25_bomb_trail"], var_3, "tag_origin");
  var_4 = anglesToForward(var_2) * 1500;
  var_5 = (0, 0, -3000);
  var_6 = 6.66667;
  var_7 = 0;
  var_8 = var_1;

  while(var_7 < var_6) {
    var_9 = var_8;
    var_8 = var_1 + var_4 * var_7 + 0.5 * var_5 * squared(var_7);
    var_3.origin = var_8;
    var_3.angles = var_3.angles + (0, 0, -2.9);
    var_10 = scripts\engine\trace::create_world_contents();
    var_11 = scripts\engine\trace::ray_trace_detail(var_9, var_8, [level.player], var_10, 0, 1);
    var_12 = var_11["fraction"];
    var_13 = var_11["position"];

    if(var_12 != 1) {
      var_3.origin = var_13;
      break;
    }

    var_7 = var_7 + 0.05;
    waitframe();
  }

  var_14 = var_3.origin;
  var_3 delete();
  playFX(level._effect["vfx_suniform25_bomb_explosion"], var_14);
  var_15 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");

  foreach(var_17 in var_15)
  level.player thread[[level.aigibfunction]](var_17, var_17 getEye(), "MOD_RIFLE_BULLET");

  physicsexplosionsphere(var_14, 2000, 0, 200);
  var_19 = distance(var_14, level.player.origin);
  var_20 = var_19 / 58346;
  level notify("vehicle_suniform25BombImpact", var_14);
  wait(var_20);
  var_21 = 1 - scripts\engine\math::normalize_value(0, 20000, var_19);
  var_22 = scripts\engine\math::factor_value(0.06, 0.12, var_21);
  var_23 = scripts\engine\math::factor_value(0.75, 1.8, var_21);
  earthquake(var_22, var_23, var_14, 20000);
  level.player playRumbleOnEntity("damage_heavy");
}

vehicle_spawncovernodes(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_4 = var_4 * -1;
  var_6 = var_6 * -1;
  var_9 = anglesToForward(var_1);
  var_10 = anglestoright(var_1);
  var_11 = (0, 0, 1);
  var_12 = vectortoangles(var_9);
  var_13 = vectortoangles(var_9 * -1);
  var_14 = vectortoangles(var_10);
  var_15 = vectortoangles(var_10 * -1);
  var_16 = [];
  vehicle_addcovernodetemplate(var_16, "Cover Left", var_2 - 16, var_6, var_14);
  vehicle_addcovernodetemplate(var_16, "Cover Right", var_2 + var_3, var_6 + 16, var_13);
  vehicle_addcovernodetemplate(var_16, "Cover Left", var_2 + var_3, var_7 - 16, var_13);
  vehicle_addcovernodetemplate(var_16, "Cover Right", var_2 - 16, var_7, var_15);
  vehicle_addcovernodetemplate(var_16, "Cover Left", var_4 + 16, var_7, var_15);
  vehicle_addcovernodetemplate(var_16, "Cover Right", var_4 - var_5, var_7 - 16, var_12);
  vehicle_addcovernodetemplate(var_16, "Cover Left", var_4 - var_5, var_6 + 16, var_12);
  vehicle_addcovernodetemplate(var_16, "Cover Right", var_4 + 16, var_6, var_14);
  var_17 = [];

  foreach(var_19 in var_16) {
    var_20 = var_0 + var_9 * var_19.forwarddistance + var_10 * var_19.rightdistance + var_11 * 32;
    var_20 = var_20 + anglesToForward(var_19.angles) * 16 * -1;
    var_21 = spawncovernode(var_20, var_19.angles, var_19.type, 4, var_8);

    if(isDefined(var_21))
      var_17 = scripts\engine\utility::array_add(var_17, var_21);
  }

  return var_17;
}

vehicle_addcovernodetemplate(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.type = var_1;
  var_5.forwarddistance = var_2;
  var_5.rightdistance = var_3;
  var_5.angles = var_4;
  return scripts\engine\utility::array_add(var_0, var_5);
}

vehicle_waittillarraymoving(var_0) {
  for(;;) {
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(var_3 vehicle_getspeed())
        var_1++;
    }

    if(scripts\engine\utility::is_equal(var_1, var_0.size)) {
      break;
    }

    waitframe();
  }
}

level_spawnfarah() {
  var_0 = getspawner("level_farahSpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 scripts\common\ai::magic_bullet_shield();
  var_1.targetname = "level_farah";
  var_1.name = "Farah";
  var_1.animname = "farah";
  var_1.disableplayeradsloscheck = 1;

  if(!scripts\common\ai::spawn_failed(var_1))
    var_1 scripts\engine\sp\utility::set_goalRadius(256);

  return var_1;
}

level_spawnhadir() {
  var_0 = getspawner("level_hadirSpawner", "targetname");
  var_1 = var_0 stalingradspawn();
  var_1 scripts\common\ai::magic_bullet_shield();
  var_1.targetname = "level_hadir";
  var_1.name = "Hadir";
  var_1.animname = "hadir";
  var_1.disableplayeradsloscheck = 1;

  if(!scripts\common\ai::spawn_failed(var_1))
    var_1 scripts\engine\sp\utility::set_goalRadius(256);

  return var_1;
}

level_spawnredshirts() {
  var_0 = level_getredshirtspawners();
  var_1 = 0;

  for(var_2 = 0; var_2 < level_getredshirtgoalamount(); var_2++) {
    var_3 = var_0[var_1];
    level_spawnredshirtfromspawner(var_3);
    var_1 = scripts\engine\math::wrap(0, var_0.size, var_1 + 1);
  }

  thread level_redshirtslogic();
}

level_getredshirtgoalamount() {
  return level.redshirtgoalamount;
}

level_setredshirtgoalamount(var_0) {
  level.redshirtgoalamount = var_0;
}

level_spawnredshirtfromspawner(var_0, var_1) {
  if(!scripts\sp\maps\highway\highway_utility.gsc::level_getflag(32)) {
    return;
  }
  var_0.count = 9999;
  var_2 = var_0 scripts\engine\sp\utility::spawn_ai();

  if(scripts\common\ai::spawn_failed(var_2)) {
    return;
  }
  level notify("level_redShirtSpawned", var_2);
  var_2.targetname = "level_redShirt";
  var_2.animname = "level_redShirt";
  var_2.script_pushable = 1;
  var_2 scripts\engine\sp\utility::set_goalRadius(256);
  thread level_redshirtmagicbulletshieldlogic(var_2);
}

level_redshirtmagicbulletshieldlogic(var_0) {
  var_0 endon("death");
  var_0 scripts\common\ai::magic_bullet_shield();
  var_0 waittill("goal");
  var_0 scripts\common\ai::stop_magic_bullet_shield();
}

level_redshirtslogic() {
  level.player endon("death");
  var_0 = 0;
  var_1 = level.player.origin;

  for(;;) {
    waitframe();
    var_2 = gettime();
    var_3 = var_2 >= var_0;
    var_4 = 0;

    if(var_3) {
      var_4 = distancesquared(var_1, level.player.origin) > 40000;
      var_0 = var_2 + 3000;
      var_1 = level.player.origin;
    }

    var_5 = level_getredshirts();

    if(scripts\sp\maps\highway\highway_utility.gsc::level_getflag(512))
      var_5 = scripts\engine\utility::array_add(var_5, level_gethadir());

    var_5 = scripts\sp\maps\highway\highway_utility.gsc::array_removedeaddyingorundefined(var_5);
    var_6 = max(0, level_getredshirtgoalamount() - var_5.size);

    if(var_6) {
      for(var_7 = 0; var_7 < var_6; var_7++) {
        var_8 = level_getredshirtspawners();
        var_9 = scripts\engine\utility::random(var_8);
        thread level_spawnredshirtfromspawner(var_9, 5.0);
      }
    }

    if(!scripts\sp\maps\highway\highway_utility.gsc::level_getflag(64)) {
      waitframe();
      continue;
    }

    if(var_4)
      var_10 = var_5;
    else {
      var_10 = [];

      foreach(var_12 in var_5) {
        if(level_redshirtshouldmove(var_12))
          var_10 = scripts\engine\utility::array_add(var_10, var_12);
      }
    }

    var_14 = level_redshirtgetpossiblegoalnodesinheight();

    foreach(var_16 in var_14) {
      if(isDefined(showcinematicletterboxing(var_16)))
        var_14 = scripts\engine\utility::array_remove(var_14, var_16);
    }

    if(var_14.size > var_10.size) {
      var_18 = level_redshirtgetpossiblegoalnodes();
      var_18 = scripts\engine\utility::array_remove_array(var_18, var_14);

      foreach(var_16 in var_18) {
        if(isDefined(showcinematicletterboxing(var_16)))
          var_18 = scripts\engine\utility::array_remove(var_18, var_16);
      }

      var_21 = var_10.size - var_14.size;

      for(var_7 = 0; var_7 < var_21; var_7++)
        var_14 = scripts\engine\utility::array_add(var_14, var_18[var_7]);
    }

    foreach(var_23 in var_10) {
      if(!var_14.size) {
        break;
      }

      var_24 = var_14[0];
      var_23 setgoalnode(var_24);
      var_14 = scripts\engine\utility::array_remove(var_14, var_24);
    }

    waitframe();
  }
}

level_redshirtshouldmove(var_0) {
  if(!isDefined(var_0.node))
    return 1;

  var_1 = distancesquared(level.player.origin, var_0.node.origin) < 4096;

  if(var_1)
    return 1;

  return 0;
}

level_redshirtgetclosestonscreen() {
  var_0 = level_getredshirts();
  var_1 = level.player getEye();
  var_2 = 50;
  var_3 = 150;
  var_0 = scripts\engine\utility::array_sort_with_func(var_0, ::level_redshirtcloseronscreen);
  var_4 = [];

  foreach(var_6 in var_0) {
    var_7 = var_6 getEye();
    var_8 = sighttracepassed(var_1, var_7, 0, level.player, 1);

    if(!var_8) {
      continue;
    }
    var_9 = vectorNormalize(var_7 - var_1);
    var_10 = anglesToForward(level.player getplayerangles());
    var_11 = vectordot(var_9, var_10);
    var_12 = var_11 > cos(65);

    if(!var_12) {
      continue;
    }
    var_13 = distance(var_1, var_7);
    var_14 = var_13 >= var_2 && var_13 <= var_3;

    if(!var_14) {
      continue;
    }
    var_4 = scripts\engine\utility::array_add(var_4, var_6);
  }

  if(var_4.size)
    var_16 = var_4[0];
  else
    var_16 = var_0[0];

  return var_16;
}

level_redshirtcloseronscreen(var_0, var_1) {
  var_2 = anglesToForward(level.player getplayerangles());
  var_3 = vectorNormalize(var_0 getEye() - level.player getEye());
  var_4 = vectordot(var_2, var_3);
  var_5 = vectorNormalize(var_1 getEye() - level.player getEye());
  var_6 = vectordot(var_2, var_5);
  return var_4 > var_6;
}

level_redshirtgetpossiblegoalnodes() {
  return getnodesinradiussorted(level.player.origin, 512, 64, 256, "cover");
}

level_redshirtgetpossiblegoalnodesinheight() {
  return getnodesinradiussorted(level.player.origin, 512, 64, 64, "cover");
}

level_getredshirts() {
  return getEntArray("level_redShirt", "targetname");
}

level_getredshirtspawners() {
  return getspawnerarray("level_redShirtSpawner");
}

level_getfarah() {
  return getEnt("level_farah", "targetname");
}

level_getfarahtownnode() {
  return getnode("level_farahTownNode", "targetname");
}

level_gethadir() {
  return getEnt("level_hadir", "targetname");
}

level_hadirattachgasmask() {
  var_0 = level_gethadir();
  var_0 attach("hat_gasmask", "J_HELMET", 1);
}

level_spawnhadirtruck() {
  var_0 = scripts\common\utility::getvehiclespawner("level_hadirTruckSpawner", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel(var_0.model);
  var_1 solid();
  var_2 = var_0 scripts\engine\utility::get_linked_ents();

  foreach(var_4 in var_2) {
    var_5 = var_4.origin - var_0.origin;
    var_6 = rotatevectorinverted(var_5, var_0.angles);
    var_7 = var_4.angles - var_0.angles;
    var_4 linkTo(var_1, "TAG_BODY_ANIMATE");
  }

  var_1 scripts\common\vehicle::godon();
  var_1.animname = "level_hadirTruck";
  var_1 scripts\common\anim::setanimtree();
  var_1.targetname = "level_hadirTruck";
  var_9 = crash_getanimationstruct();
  var_9 scripts\common\anim::anim_first_frame_solo(var_1, "crash_enter");
  var_10 = scripts\engine\sp\utility::spawn_anim_model("crash_board");
  var_10.targetname = "level_hadirTruckBoard";
  var_9 scripts\common\anim::anim_first_frame_solo(var_10, "crash_enter");
}

level_gethadirtruck() {
  return getEnt("level_hadirTruck", "targetname");
}

level_gethadirtruckboard() {
  return getEnt("level_hadirTruckBoard", "targetname");
}

level_getheroes() {
  return [level_getfarah(), level_gethadir()];
}

level_openbunkerouterdoor() {
  var_0 = level_getbunkerouterdoor();
  var_0 hide();
  var_0 notsolid();
  var_1 = getEnt(var_0.target, "targetname");
  var_1 connectpaths();
  var_1 notsolid();
}

level_getbunkerouterdoor() {
  return getEnt("level_bunkerOuterDoor", "targetname");
}

level_closebunkerouterdoor() {
  var_0 = level_getbunkerouterdoor();
  var_0 show();
  var_0 solid();
  var_1 = getEnt(var_0.target, "targetname");
  var_1 disconnectPaths();
  var_1 solid();
}

level_getbunkervolume() {
  return getEnt("level_bunkerVolume", "targetname");
}

level_addmissionnarrativeobjective() {
  return scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_AMBUSH_THE_WOLF");
}

level_cleanupieds() {
  var_0 = level_getieds();

  foreach(var_2 in var_0) {
    var_2.interact thread scripts\sp\player\cursor_hint::remove_cursor_hint();
    var_2 delete();
  }
}

level_getieds() {
  return getEntArray("offhand_ied", "targetname");
}

level_setupoilpump() {
  var_0 = level_getoilpump();
  var_0.animname = "level_oilPump";
  var_0 scripts\common\anim::setanimtree();
  thread scripts\sp\maps\highway\highway_utility.gsc::animation_loop(var_0, var_0, "level_oilPumpIdle");
}

level_getoilpump() {
  return getEnt("level_oilPump", "targetname");
}

level_ballisticsniperammopickuplogic() {
  var_0 = scripts\engine\utility::getStruct("level_ballisticSniperAmmoPickupStruct", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");
  thread level_ballisticsniperammowaypointlogic(var_0);

  for(;;) {
    var_2 = var_0 scripts\engine\utility::spawn_tag_origin();
    var_2 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HIGHWAY/CURSOR_SNIPER_AMMO", undefined, undefined, 80);
    thread level_ballisticsniperammointeractlogic(var_2);
    var_2 waittill("trigger");

    if(var_1.size) {
      var_3 = sortbydistance(var_1, level.player getEye())[0];
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
      var_3 delete();
    }

    thread scripts\engine\utility::play_sound_in_space("weap_pickup", var_0.origin);
    var_4 = player_getballisticsweaponobject();
    level.player givemaxammo(var_4);
    var_2 delete();
  }
}

level_ballisticsniperammointeractlogic(var_0) {
  var_0 endon("trigger");
  var_1 = player_getballisticsweaponobject();
  var_2 = weaponmaxammo(var_1);

  for(;;) {
    if(scripts\engine\sp\utility::player_has_weapon(var_1) && level.player getweaponammostock(var_1) < var_2)
      var_0.cursor_hint_ent makeusable();
    else
      var_0.cursor_hint_ent makeunusable();

    waitframe();
  }
}

level_ballisticsniperammowaypointlogic(var_0) {
  level endon("level_enemyAssaultPlayerSeek");
  var_1 = player_getballisticsweaponobject();
  var_2 = undefined;

  for(;;) {
    var_3 = scripts\engine\sp\utility::player_has_weapon(var_1) && level.player getweaponammostock(var_1) <= weaponclipsize(var_1);

    if(!isDefined(var_2) && var_3) {
      level.player scripts\sp\player::focus_display_hint();
      var_2 = scripts\sp\maps\highway\highway_utility.gsc::level_objectiveadd(&"HIGHWAY/OBJECTIVE_GET_SNIPER_AMMO", var_0.origin + (0, 0, 10), &"HIGHWAY/LABEL_AMMO", 1);
    }

    var_4 = scripts\engine\sp\utility::player_has_weapon(var_1) && level.player getweaponammostock(var_1) >= weaponmaxammo(var_1);

    if(isDefined(var_2) && var_4) {
      objective_delete(var_2);
      var_2 = undefined;
    }

    waitframe();
  }
}

level_enemyassaulttownlogic(var_0, var_1) {
  var_0 endon("death");
  level.player endon("death");
  level endon("level_enemyAssaultPlayerSeek");

  if(var_1) {
    var_0.vehiclerunexit = 1;
    var_0 scripts\engine\sp\utility::set_ignoreme(1);
    var_0 waittill("jumpedout");
    var_0 scripts\engine\sp\utility::set_ignoreme(0);
  }

  if(scripts\engine\utility::flag("level_enemyAssaultPlayerSeek")) {
    var_0 scripts\engine\sp\utility::set_grenadeammo(0);
    var_0 scripts\engine\sp\utility::set_goalRadius(600);
    var_0 setgoalentity(level.player);
    return;
  }

  var_0 scripts\common\utility::demeanor_override("sprint");
  var_2 = level_gettownouterenemygoalvolume();

  if(scripts\sp\maps\highway\highway_utility.gsc::math_getchance(30)) {
    var_0 setgoalvolumeauto(var_2);

    while(!var_0 istouching(var_2))
      waitframe();

    wait(randomfloatrange(6, 8));
  }

  var_3 = level_gettowninnerenemygoalvolume();
  var_0 setgoalvolumeauto(var_3);

  while(!var_0 istouching(var_3))
    waitframe();

  thread level_enemyassaulttownmolotovhintlogic();
  var_0 scripts\common\utility::clear_demeanor_override();

  for(;;) {
    if(level.player istouching(var_3))
      var_0 setgoalvolumeauto(var_3);
    else
      var_0 setgoalvolumeauto(var_2);

    waitframe();
  }
}

level_enemyassaulttownmolotovhintlogic() {
  level.player endon("death");
  var_0 = scripts\sp\maps\highway\highway_utility.gsc::level_getflag(16);
  var_1 = level.player getweaponammostock("molotov");
  var_2 = scripts\engine\sp\utility::player_has_equipment("molotov") && var_1;
  var_3 = scripts\engine\utility::is_equal(level.player.offhands.lastusedoffhandweapon, getcompleteweaponname("molotov")) && gettime() - level.player.offhands.lastusedoffhandtime <= 10000;
  var_4 = 30;
  var_5 = gettime() + var_4 * 0.001;

  if(!var_0 && var_2 && !var_3) {
    scripts\engine\sp\utility::display_hint_forced("throw_molotov", var_4);
    scripts\sp\maps\highway\highway_utility.gsc::level_setflag(16, 1);
    var_6 = level_gethadir();
    var_7 = level_getfarah();
    var_8 = ["dx_vom_had_convoy_bc_140", "dx_vom_had_convoy_bc_130", "dx_vom_far_convoy_bc_150"];
    var_9 = [var_6, var_6, var_7];
    var_10 = var_8;
    var_11 = var_9;
    var_12 = randomint(var_10.size);
    var_13 = 5;

    for(;;) {
      if(gettime() >= var_5) {
        break;
      }

      if(level.player getweaponammostock("molotov") < var_1) {
        break;
      }

      var_14 = var_10[var_12];
      var_15 = var_11[var_12];
      var_15 scripts\sp\maps\highway\highway_utility.gsc::dialogue(var_14);
      var_12 = scripts\engine\math::wrap(0, var_8.size - 1, var_12 + 1);
      wait(var_13);
    }
  }
}

level_gettownrooftoptriggers(var_0) {
  var_1 = getEntArray("level_townRooftopTrigger", "targetname");

  if(isDefined(var_0)) {
    foreach(var_3 in var_1) {
      if(!scripts\engine\utility::is_equal(var_3.script_noteworthy, var_0))
        var_1 = scripts\engine\utility::array_remove(var_1, var_3);
    }
  }

  return var_1;
}

level_gettowninnerenemygoalvolume() {
  return getEnt("level_townInnerEnemyVolume", "targetname");
}

level_gettownouterenemygoalvolume() {
  return getEnt("level_townOuterEnemyVolume", "targetname");
}

level_gettowncovernodes() {
  return getnodearray("level_townCoverNodes", "targetname");
}

level_gettownanimationstruct() {
  return scripts\engine\utility::getStruct("level_townAnimationStruct", "targetname");
}

level_notifylevelonenemycount(var_0, var_1) {
  scripts\sp\maps\highway\highway_utility.gsc::waittill_remainingenemycount(var_0);
  level notify(var_1);
}

level_notifylevelonenemydeathcount(var_0, var_1) {
  var_2 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
  var_3 = var_2.size - var_0;

  while(scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis").size > var_3)
    waitframe();

  level notify(var_1);
}

level_notifylevelonplayershotcount(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0; var_2++)
    level.player waittill("weapon_fired");

  level notify(var_1);
}

level_redbarreldistantlogic() {
  level.g_effect["barrel_explosion"] = loadfx("vfx/iw8/level/highway/vfx_red_barrel_exp_no_cull");
  var_0 = getEntArray("level_redBarrelDistant", "targetname");

  foreach(var_2 in var_0)
  thread level_redbarreldeathlogic(var_2);
}

level_redbarreldeathlogic(var_0) {
  var_0 waittill("ballistics_bulletDamage");
  var_1 = var_0.origin;
  var_0 delete();
  playFX(level.g_effect["barrel_explosion"], var_1);
  var_2 = 300;
  var_3 = 225;
  var_4 = 0.15;
  var_5 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("axis");
  var_6 = 0;

  foreach(var_8 in var_5) {
    if(distance(var_8.origin, var_1) > var_2) {
      continue;
    }
    var_8 notify("flashbang", (0, 0, 0), 1, 1, level.player, "allies");

    if(distance(var_8.origin, var_1) > var_3) {
      continue;
    }
    level.player scripts\engine\utility::delaythread(var_4, level.aigibfunction, var_8, var_8 getEye(), "MOD_EXPLOSIVE");
    var_6 = 1;
  }

  var_10 = 150;
  var_11 = scripts\sp\maps\highway\highway_utility.gsc::ai_getaliveaiarray("allies");

  foreach(var_13 in var_11) {
    if(distance(var_13.origin, var_1) > var_2) {
      continue;
    }
    var_13 notify("flashbang", (0, 0, 0), 1, 1, level.player, "axis");

    if(!var_6 || distance(var_13.origin, var_1) > var_10) {
      continue;
    }
    level.player scripts\engine\utility::delaythread(var_4, level.aigibfunction, var_13, var_13 getEye(), "MOD_EXPLOSIVE");
  }

  thread scripts\engine\utility::play_sound_in_space("scn_highway_barrel_expl", var_1);
  createnavbadplacebybounds(var_1, (50, 50, 50), (0, 0, 0));
  physicsexplosionsphere(var_1, 700, 0, 2.0);
  var_15 = distance(var_1, level.player.origin);
  var_16 = var_15 / 58346;
  wait(var_16);
  level.player playRumbleOnEntity("damage_light");
  earthquake(0.02, 0.5, var_1, 50000);
}

init_wind() {
  scripts\common\basic_wind::load_all_wind();
  level.ballistics.winddirections = [(-140, 0, 0), (140, 0, 0)];
  level.ballistics.winddirectionsextreme = [(-550, 0, 0), (550, 0, 0)];
  level.ballistics.winddirectionstrings = ["left", "right"];
  level.ballistics.winddirectionaimstrings = ["right", "left"];
  level.ballistics.winddirectionscardinal = ["west", "east"];
  level.ballistics.windobject = undefined;
  var_0 = wind_getrandomdirectionindex();
  wind_setdirection(var_0, 0, 0);
}

wind_setdirection(var_0, var_1, var_2) {
  var_3 = (0, 0, 1);
  var_4 = level.ballistics.winddirectionscardinal[var_0];

  if(var_2) {
    var_5 = level.ballistics.winddirectionsextreme[var_0];
    var_6 = 2;
  } else {
    var_5 = level.ballistics.winddirections[var_0];
    var_6 = 1;
  }

  if(isDefined(level.ballistics.windobject))
    scripts\common\basic_wind::stop_wind(level.ballistics.windobject);

  var_7 = scripts\common\basic_wind::init_wind(var_4, var_6, 0);

  if(var_1) {
    var_8 = level.ballistics.wind;
    var_9 = 0;
    var_10 = gettime();
    var_11 = var_10 + var_1;
    var_12 = var_1 * 0.001 * 20;
    var_13 = 1 / var_12;

    while(gettime() < var_11) {
      var_14 = var_8;
      var_15 = vectorcross(var_14, var_3);
      var_16 = axistoangles(var_14, var_15, var_3);
      var_17 = var_5;
      var_18 = vectorcross(var_17, var_3);
      var_19 = axistoangles(var_17, var_18, var_3);
      var_20 = scripts\engine\math::fake_slerp(var_16, var_19, var_9);
      level.ballistics.wind = anglesToForward(var_20);
      var_9 = var_9 + var_13;
      waitframe();
    }
  }

  level.ballistics.wind = var_5;
  level.ballistics.winddirectionstring = level.ballistics.winddirectionstrings[var_0];
  level.ballistics.winddirectionaimstring = level.ballistics.winddirectionaimstrings[var_0];
  level.ballistics.winddirectionindex = var_0;
  setsaveddvar("MQPQKNPQOK", 2);
  setsaveddvar("MRNRKKOPLN", 2);
  setsaveddvar("NQTLPTNSSO", 3);
  setsaveddvar("OLSKLTPPMR", 0.7);
  setsaveddvar("LQLSPQOPKM", 50);
  setsaveddvar("NTMMTOLQMQ", level.ballistics.wind);
}

wind_getrandomdirectionindex() {
  var_0 = scripts\engine\utility::array_remove(level.ballistics.winddirections, level.ballistics.wind);
  return randomint(var_0.size);
}