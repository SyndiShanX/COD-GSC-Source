/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\highway\highway.gsc
***********************************************/

function main() {
  init_precache();
  scripts\sp\maps\highway\highway_lighting::init_lighting();
  scripts\engine\sp\utility::add_hint_string("prone", &"HIGHWAY/PRONE", &player_isprone);
  scripts\engine\sp\utility::add_hint_string("prone_toggle", &"HIGHWAY/PRONE_TOGGLE", &player_isprone);
  scripts\engine\sp\utility::add_hint_string("ads", &"HIGHWAY/ADS");
  scripts\engine\sp\utility::add_hint_string("ads_toggle", &"HIGHWAY/ADS_TOGGLE");
  scripts\engine\sp\utility::add_hint_string("zoom_in", &"HIGHWAY/ZOOM_IN", &player_zoomedin);
  scripts\engine\sp\utility::add_hint_string("zoom_out", &"HIGHWAY/ZOOM_OUT", &player_zoomedout);
  scripts\engine\sp\utility::add_hint_string("throw_molotov", &"HIGHWAY/THROW_MOLOTOV", &player_throwingmolotov);
  scripts\sp\maps\highway\gen\highway_art::main();
  scripts\sp\maps\highway\highway_fx::main();
  scripts\sp\maps\highway\highway_precache::main();
  scripts\sp\maps\highway\highway_anim::init_anims();
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rebel", "truck_suicide", "script_vehicle_iw8_truck_techo_rebel");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty", "truck_highway", "script_vehicle_iw8_truck_techo_whitedirty");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_black", "truck_highway", "script_vehicle_iw8_truck_techo_blackdirty");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_red", "truck_highway", "script_vehicle_iw8_truck_techo_reddirty");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_tan", "truck_highway", "script_vehicle_iw8_truck_techo_tandirty");
  scripts\vehicle\vindia::main("veh8_mil_lnd_vindia_a2", "apc_highway", "script_vehicle_iw8_vindia_a2");
  scripts\engine\sp\utility::transient_init("highway_bunker_tr");
  scripts\engine\sp\utility::transient_init("highway_main_tr");
  scripts\engine\sp\utility::set_default_start("ride");
  scripts\engine\sp\utility::add_start("ride", &ride_start, "Ride", &ride_main, "highway_all");
  scripts\engine\sp\utility::add_start("intro", &intro_start, "Intro", &intro_main, "highway_all");
  scripts\engine\sp\utility::add_start("roof", &roof_start, "Roof", &roof_main, "highway_all", &roof_catchup);
  scripts\engine\sp\utility::add_start("tutorial", &tutorial_start, "Tutorial", &tutorial_main, "highway_all", &tutorial_catchup);
  scripts\engine\sp\utility::add_start("scouting", &scouting_start, "Scouting", &scouting_main, "highway_all");
  scripts\engine\sp\utility::add_start("dogs", &dogs_start, "Dogs", &dogs_main, "highway_all");
  scripts\engine\sp\utility::add_start("assassinate", &assassinate_start, "Assassinate", &assassinate_main, "highway_all");
  scripts\engine\sp\utility::add_start("trap", &trap_start, "Trap", &trap_main, "highway_all");
  scripts\engine\sp\utility::add_start("convoy", &convoy_start, "Convoy", &convoy_main, "highway_all");
  scripts\engine\sp\utility::add_start("ambush", &ambush_start, "Ambush", &ambush_main, "highway_all");
  scripts\engine\sp\utility::add_start("fallback", &fallback_start, "Fallback", &fallback_main, "highway_all");
  scripts\engine\sp\utility::add_start("reinforcements", &reinforcements_start, "Reinforcements", &reinforcements_main, "highway_all");
  scripts\engine\sp\utility::add_start("assault", &assault_start, "Assault", &assault_main, "highway_all");
  scripts\engine\sp\utility::add_start("mortars", &mortars_start, "Mortars", &mortars_main, "highway_all");
  scripts\engine\sp\utility::add_start("suicide", &suicide_start, "Suicide", &suicide_main, "highway_all");
  scripts\engine\sp\utility::add_start("restock", &restock_start, "Restock", &restock_main, "highway_all");
  scripts\engine\sp\utility::add_start("radio", &radio_start, "Radio", &radio_main, "highway_all");
  scripts\engine\sp\utility::add_start("sniper", &sniper_start, "Sniper", &sniper_main, "highway_all");
  scripts\engine\sp\utility::add_start("squad", &squad_start, "Squad", &squad_main, "highway_all");
  scripts\engine\sp\utility::add_start("jets", &jets_start, "Jets", &jets_main, "highway_all");
  scripts\engine\sp\utility::add_start("armor", &armor_start, "Armor", &armor_main, "highway_all");
  scripts\engine\sp\utility::add_start("russians", &russians_start, "Russians", &russians_main, "highway_all");
  scripts\engine\sp\utility::add_start("cover", &cover_start, "Cover", &cover_main, "highway_all");
  scripts\engine\sp\utility::add_start("crash", &crash_start, "Crash", &crash_main, "highway_all");
  scripts\engine\sp\utility::add_start("gas", &gas_start, "Gas", &gas_main, "highway_all");
  scripts\engine\sp\utility::add_start("drag", &drag_start, "Drag", &drag_main, "highway_all");
  scripts\engine\sp\utility::add_start("bunker", &bunker_start, "Bunker", &bunker_main, "highway_bunker_only");
  scripts\engine\sp\utility::intro_screen_custom_func(&intro_fadeup);
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  init_level();
  init_player();
  scripts\sp\player\ballistics::init_ballistics();
  init_vfx();
  init_wind();
}

function intro_fadeup() {
  thread scripts\sp\hud_util::fade_out(0);
  wait 0.2;
  thread scripts\sp\hud_util::fade_in(0);
}

function init_precache() {
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

function init_vfx() {
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

function init_level() {
  var0 = ["frag", "flash", "molotov", "ied"];
  scripts\engine\sp\utility::offhandprecache(var0);
  level.aigibfunction = &scripts\sp\gibbing::gibbing_gibai;
  level.autosave.enemydistcheck = 0;
  scripts\sp\utility::context_melee_enable(0);
  level.flags = 0;
  level_setredshirtgoalamount(3);
  scripts\sp\maps\highway\highway_utility::level_objectiveinit();
  scripts\sp\maps\highway\highway_utility::level_setflag(32, 1);
  scripts\sp\maps\highway\highway_utility::level_setflag(64, 0);
  scripts\sp\maps\highway\highway_utility::level_setflag(512, 1);
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
  var1 = scripts\engine\utility::getStructArray("level_allyStairStruct", "targetname");

  foreach(var3 in var1) {
    createnavbadplacebybounds(var3.origin, (var3.radius, var3.radius, var3.radius), (0, 0, 0), "allies");
  }

  var5 = getnodearray("traverse", "targetname");

  foreach(var7 in var5) {
    if(scripts\engine\utility::is_equal(var7.script_parameters, "level_townLadderNodeBegin")) {
      createnavbadplacebybounds(var7.origin, (16, 16, 16), (0, 0, 0), "axis");
    }
  }

  level_spawnhadirtruck();
  level_redbarreldistantlogic();
  level_setupoilpump();
  thread level_ballisticsniperammopickuplogic();
  restock_connectiedpaths();
  var9 = getEnt("weapon_iw8_sn_sbeta+rec_sbeta+reargrip_sbeta+ironsdefault_sbeta+xmags+stockl_sbeta+barlong_sbeta+strap_sbeta", "code_classname");
  var9.origin = (834.469, -2059.13, 896.75);
  var10 = getEnt("weapon_iw8_sm_beta+rec_beta+front_beta+reflex_east02+xmags_beta+stockl_beta", "code_classname");
  var11 = spawn("weapon_iw8_sm_beta+rec_beta+front_beta+reflex_east02+xmagslrg_beta+stockl_beta", var10.origin, var10.spawnflags);
  var11.angles = var10.angles;
  var11.targetname = var10.targetname;
  var11 scripts\anim\shared::setscriptammo("weapon_iw8_sm_beta", var10, undefined);
  var10 delete();
  scripts\engine\sp\utility::add_global_spawn_function("axis", &scripts\sp\player\ballistics::ballistics_aiignoreballisticsweaponpain);
}

function init_player() {
  level.player.flags = 0;
  player_giveprimaryoffhandweapon();
  player_givesecondaryoffhandweapon();
  level.player setviewmodel("viewmodel_arms_alex_desert");
  level.player setshadowmodel("default_character_shadow");
  level.player scripts\sp\utility::allow_weapon_first_raise_anims(0);
  thread player_trackvariablezoom();
  thread player_dropballisticsweaponlogic();
}

function ride_start() {
  if(getdvarint("introMovie")) {
    level.player setclienttriggeraudiozone("bink_fadeout_amb", 0.5);
    return;
  }
}

function ride_main() {
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 0.05);
  level.player scripts\engine\utility::delaycall(0.3, &setclienttriggeraudiozone, "highway_intro_ride", 1);
  level.player lerpfovscalefactor(0, 0);
  scripts\sp\maps\highway\highway_utility::level_setfailonfriendlyfire(1);
  var0 = level_addmissionnarrativeobjective();
  var1 = level_gettownanimationstruct();
  var2 = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  var3 = ride_spawnVehicle();
  var4 = level_spawnfarah();
  var4.anim_playvo_func = &scripts\engine\utility::playsoundontag;
  thread scripts\sp\maps\highway\highway_lighting::ride_lighting(var3);
  thread scripts\sp\maps\highway\highway_lighting::ride_dof(var4);
  var5 = ride_spawnanimateddriverally();
  var6 = ride_spawnanimatedalexally();
  var7 = ride_spawnanimatedgateallies();
  var8 = scripts\sp\maps\highway\highway_anim::ride_getgatetypes();
  var9 = [];

  foreach(var11 in var8) {
    var12 = scripts\engine\sp\utility::spawn_anim_model("HOD_intro_truck_gate_" + var11);
    var9 = scripts\engine\utility::array_add(var9, var12);
  }

  scripts\sp\maps\highway\highway_utility::ai_setname(var5, "");
  scripts\sp\maps\highway\highway_utility::ai_setname(var4, "");
  var4 scripts\common\utility::demeanor_override("casual_gun");
  var1 scripts\common\anim::anim_first_frame_solo(var3, "ride");
  var3 thread scripts\common\anim::anim_first_frame_solo(var4, "ride", "tag_body_animate");
  var3 thread scripts\common\anim::anim_first_frame_solo(var6, "ride", "tag_body_animate");
  var3 thread scripts\common\anim::anim_first_frame_solo(var5, "ride", "tag_body_animate");
  var3 thread scripts\common\anim::anim_first_frame_solo(var2, "ride_camera", "tag_body_animate");
  var3 thread scripts\common\anim::anim_first_frame(var7, "ride", "tag_body_animate");
  var4 linkTo(var3, "tag_body_animate");
  var5 linkTo(var3, "tag_body_animate");
  var6 linkTo(var3, "tag_body_animate");
  var2 linkTo(var3, "tag_body_animate");
  scripts\sp\maps\highway\highway_utility::player_rigenterabsolute(var2);
  var2 hide();
  thread ride_farahmodellogic(var2, var4);
  thread ride_audiologic();
  thread ride_cinematiccamerasettings();
  var1 thread scripts\common\anim::anim_single_solo(var3, "ride");
  var3 thread scripts\common\anim::anim_single_solo(var4, "ride", "tag_body_animate");
  var3 thread scripts\common\anim::anim_single_solo(var6, "ride", "tag_body_animate");
  var3 thread scripts\common\anim::anim_single_solo(var5, "ride", "tag_body_animate");
  var1 thread scripts\common\anim::anim_single(var9, "ride");
  var1 thread scripts\common\anim::anim_single(var7, "ride");
  var3 scripts\common\anim::anim_single_solo(var2, "ride_camera", "tag_body_animate");
  var6 delete();
  level.player freezecontrols(0);
  scripts\sp\maps\highway\highway_utility::player_rigexit(var2, 1);
  scripts\sp\maps\highway\highway_utility::player_rigenter(var2, 0, 0, 0, 0, 0);
  var14 = 0.5;
  level.player lerpviewangleclamp(var14, 0, 0, 30, 30, 20, 20);
  var3 thread scripts\common\anim::anim_single_solo(var2, "ride", "tag_body_animate");
  var15 = var2 scripts\engine\utility::getanim("ride");
  var16 = getanimlength(var15);
  var17 = var16 - var14;
  thread ride_screenshakelogic(var17);
  wait var17;
  level.player lerpviewangleclamp(var14, 0, 0, 0, 0, 0, 0);
  wait var14;
  var4 unlink();
  var5 unlink();
  var2 unlink();
  scripts\engine\utility::array_delete(var7);
  objective_delete(var0);
  scripts\sp\maps\highway\highway_utility::player_rigexit(var2);
  thread scripts\sp\maps\highway\highway_lighting::ride_end();
}

function ride_screenshakelogic(var0) {
  var1 = gettime() + var0 * 1000;
  var2 = 0.2;
  var3 = 0.4;
  var4 = 0.5;
  var5 = 0.2;
  var6 = 0.5;
  var7 = 0.4;
  var8 = 0.2;
  var9 = 0.5;
  var10 = 4;
  var11 = 0.5;

  for(;;) {
    if(gettime() + var11 * 1000 >= var1) {
      break;
    }

    var12 = randomfloatrange(var2, var3);
    var13 = randomfloatrange(var8, var9);
    var14 = randomfloatrange(var2, var3);
    level.player screenshakeonentity(var12, var13, var14, 1, 0, 0, 1000, var4, var7, var10);
    wait var11;
  }
}

function ride_farahmodellogic(var0, var1) {
  var2 = var1.model;
  var1 setModel("body_hero_farah_nobraids");
  scripts\sp\maps\highway\highway_utility::animation_waittillnotetrack(var0, "swap_farah_model");
  var1 setModel(var2);
}

function ride_audiologic() {
  setmusicstate("mx_highway_walkntalk");
  thread ride_gatesfxlogic();
  wait 0.1;
  level.player playSound("scn_highway_intro_whoosh");
  wait 0.4;
  level.player playSound("scn_highway_intro_drive_lr");
}

function ride_gatesfxlogic() {
  wait 10;
  thread scripts\engine\utility::play_sound_in_space("scn_highway_intro_gate_open", (-2446, -1732, 1080));
  wait 8;
  thread scripts\engine\utility::play_sound_in_space("scn_highway_intro_gate_close", (-2446, -1732, 1080));
  level.player clearclienttriggeraudiozone(6);
}

function ride_cinematiccamerasettings() {
  hidecinematicletterboxing(0, 0);
  wait 5;
  getrandomnodedestination(2, 0);
}

function ride_spawnVehicle() {
  var0 = scripts\engine\sp\utility::spawn_anim_model("ride_vehicle");
  var0.targetname = "ride_vehicle";
  return var0;
}

function ride_getvehicle() {
  return getEnt("ride_vehicle", "targetname");
}

function ride_spawnanimateddriverally() {
  var0 = getspawner("ride_animatedDriverAllySpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "ride_animatedDriverAlly";
  var1.targetname = "ride_animatedAlly";
  var1 scripts\engine\sp\utility::set_goalRadius(32);
  var1 scripts\common\utility::demeanor_override("casual_gun");
  return var1;
}

function ride_spawnanimatedalexally() {
  var0 = getspawner("ride_alexAllySpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "ride_animatedAlexAlly";
  var2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  var1 scripts\anim\shared::forceuseweapon(var2, "primary");
  return var1;
}

function ride_spawnanimatedgateallies() {
  var0 = getspawnerarray("ride_animatedGateAllySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.animname = "ride_animatedGateAlly" + var3.script_index;
    var3 scripts\common\ai::gun_remove();
    scripts\sp\maps\highway\highway_utility::ai_setname(var3, "");
  }

  return var1;
}

function ride_getanimatedallies() {
  return getEntArray("ride_animatedAlly", "targetname");
}

function intro_start() {
  scripts\sp\maps\highway\highway_utility::level_setfailonfriendlyfire(1);
  var0 = level_spawnfarah();
  var0 scripts\common\utility::demeanor_override("casual_gun");
  scripts\sp\maps\highway\highway_utility::ai_setname(var0, "");
  var1 = ride_spawnVehicle();
  var2 = level_gettownanimationstruct();
  var2 scripts\common\anim::anim_last_frame_solo(var1, "ride");
  var3 = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  var4 = getanimlength(var3 scripts\engine\utility::getanim("ride"));
  var5 = getanimlength(var3 scripts\engine\utility::getanim("ride_camera"));
  var6 = var4 + var5;
  var7 = getanimlength(var0 scripts\engine\utility::getanim("ride"));
  var8 = var6 / (var7 - 0.05);
  var1 thread scripts\common\anim::anim_single_solo(var0, "ride", "tag_body_animate");
  scripts\engine\utility::delaythread(0.05, &scripts\common\anim::anim_set_time_solo, var0, "ride", var8);
  var9 = scripts\sp\maps\highway\highway_utility::ai_getanimationfinalorigin(var3, "ride", var1);
  var10 = scripts\sp\maps\highway\highway_utility::ai_getanimationfinalangles(var3, "ride", var1);
  var3 delete();
  level.player setOrigin(var9);
  level.player setplayerangles(var10);
}

function intro_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("intro");
  player_givesecondaryweapon();
  thread intro_playerspeedscalinglogic();
  var0 = level_getfarah();
  scripts\sp\maps\highway\highway_utility::level_objectivecreatefollowai(var0, undefined, &"HIGHWAY/OBJECTIVE_FOLLOW_FARAH");
  thread intro_plankanimationscenelogic();
  var0.anim_playvo_func = undefined;
  var1 = level_gettownanimationstruct();
  intro_hadirscenelogic(var1);
  intro_setupanimatedfarahscope(var1);
  var2 = intro_spawnanimatedphoneally();
  var3 = scripts\engine\sp\utility::spawn_anim_model("intro_animatedPhone");
  var4 = [var2, var3];
  scripts\sp\maps\highway\highway_utility::animation_loop(var1, var4, "intro_phoneIdleA");
  var5 = intro_spawnanimatedcinderblockallies();
  var6 = scripts\sp\maps\highway\highway_anim::intro_getcinderblockanimations();
  var7 = [];

  for(var8 = 0; var8 < var6.size; var8++) {
    var7 = scripts\engine\sp\utility::spawn_anim_model("intro_animatedCinderblock" + var8);
    var1 scripts\common\anim::anim_first_frame_solo(var7[var8], "intro_cinderblockEnter");
  }

  var9 = scripts\engine\sp\utility::spawn_anim_model("intro_animatedCinderblockSledgehammer");
  scripts\sp\maps\highway\highway_utility::animation_loop(var1, var5, "intro_cinderblockIdleA");
  scripts\sp\maps\highway\highway_utility::animation_loop(var1, var9, "intro_cinderblockIdleA");
  var10 = intro_spawnanimatedstairsally();
  var11 = scripts\sp\maps\highway\highway_anim::intro_getstairscrateanimations();
  var12 = [];
  var8 = 0;

  if(var8 < var11.size) {
    GscBinSkip0(0x2e, var8, scripts\engine\sp\utility::spawn_anim_model("intro_animatedStairsCrate" + var8));
  }

  var13 = scripts\engine\utility::array_add(var12, var10);
  var1 scripts\common\anim::anim_first_frame(var13, "intro_stairsEnter");
  intro_scenealogic(var1, var0, var10, var12);
  intro_sceneblogic(var1, var0);
  intro_sceneclogic(var1, var0, var4, var5, var7, var9);
  var14 = scripts\engine\utility::array_combine(var7, [var9], [var3]);
  thread intro_animatedpropscleanuplogic(var14);
}

function intro_playerspeedscalinglogic() {
  var0 = level_getfarah();
  var0 endon("death");
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  scripts\sp\player::player_movement_state("creep");
  level endon("intro_levelHasSniper");
  var1 = 70;
  var2 = 120;
  var3 = 30;
  var4 = 130;

  for(;;) {
    var5 = distance(var0.origin, level.player.origin);
    var6 = scripts\engine\math::normalize_value(var3, var4, var5);
    var7 = scripts\engine\math::factor_value(var1, var2, var6);
    scripts\engine\sp\utility::player_speed_set(var7);
    waitframe();
  }
}

function intro_scenealogic(var0, var1, var2, var3) {
  var4 = "intro_animatedStairsAlly";
  thread intro_stairsanimationscenelogic(var0, var2, var3, var4);
  thread intro_dialoguejokesectionalogic(var1);
  scripts\sp\maps\highway\highway_utility::animation_waittillend(var1);
  scripts\engine\utility::exploder("release_birds_1");
  scripts\sp\maps\highway\highway_utility::animation_single(var0, var1, "intro_farahSceneA");
  var5 = ["dx_vom_far_intro_village_65", "dx_vom_far_intro_village_80"];
  var1 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var5, 10, level, "player_nearAI", 9);
  var6 = scripts\sp\maps\highway\highway_utility::ai_getanimationfinalorigin(var1, "intro_farahSceneB", var0);
  scripts\sp\maps\highway\highway_utility::player_waittillnearai(var1, 200, var6, undefined, undefined, 10, undefined, undefined);
  level notify(var4);
}

function intro_sceneblogic(var0, var1) {
  thread intro_dialoguejokesectionblogic(var1);
  var2 = var1.anglelerprate;
  var1.anglelerprate = 20;
  scripts\sp\maps\highway\highway_utility::animation_reachtosingleintoloop(var0, var1, "intro_farahSceneB", "intro_farahSceneBIdle");
  var1.anglelerprate = var2;
  var3 = ["dx_vom_far_intro_village_220", "dx_vom_far_intro_village_230", "dx_vom_far_intro_rooftop_110"];
  var1 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var3, 8, level, "player_nearAI", 8, undefined, undefined, "intro_farahSceneBNag", "intro_farahSceneBIdle", var0);
  var4 = scripts\sp\maps\highway\highway_utility::ai_getanimationfinalorigin(var1, "intro_farahSceneC", var0);
  scripts\sp\maps\highway\highway_utility::player_waittillnearai(var1, 250, var4, undefined, undefined, 10, undefined, undefined, 128);
}

function intro_sceneclogic(var0, var1, var2, var3, var4, var5) {
  scripts\engine\utility::exploder("release_birds_2");
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var2);
  thread scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var2, "intro_phoneEnter", "intro_phoneIdleB");
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var3);
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var5);
  thread scripts\sp\maps\highway\highway_utility::animation_singleintolastframe(var0, var4, "intro_cinderblockEnter");
  thread scripts\sp\maps\highway\highway_utility::animation_singleintolastframe(var0, var5, "intro_cinderblockEnter");
  thread scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var3, "intro_cinderblockEnter", "intro_cinderblockIdleB");
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var1);
  scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var1, "intro_farahSceneC", "intro_farahSceneCIdle");
  var6 = ["dx_vom_far_intro_rooftop_100"];
  var1 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var6, 5, level, "player_nearAI", 3, undefined, undefined, "intro_farahSceneCNag", "intro_farahSceneCIdle", var0);
  var7 = scripts\sp\maps\highway\highway_utility::ai_getanimationfinalorigin(var1, "roof_sceneAEnter", var0);
  scripts\sp\maps\highway\highway_utility::player_waittillnearai(var1, 300, var7, undefined, undefined, 10, undefined, undefined, 128);
}

function intro_hadirscenelogic(var0) {
  var1 = level_spawnhadir();
  scripts\sp\maps\highway\highway_utility::ai_setname(var1, "");
  var2 = scripts\engine\sp\utility::spawn_anim_weapon("intro_animatedHadirSniper", undefined, undefined, 0);
  var2.targetname = "intro_hadirSniper";
  scripts\sp\maps\highway\highway_utility::animation_loop(var0, [var1, var2], "intro_hadirIdle");
}

function intro_getanimatedhadirsniper() {
  return getEnt("intro_hadirSniper", "targetname");
}

function intro_setupanimatedfarahscope(var0) {
  var1 = scripts\engine\sp\utility::spawn_anim_model("intro_animatedFarahScope");
  var1.targetname = "intro_farahScope";
  var0 = level_gettownanimationstruct();
  var0 scripts\common\anim::anim_first_frame_solo(var1, "roof_sceneCEnter");
}

function intro_getanimatedfarahscope() {
  return getEnt("intro_farahScope", "targetname");
}

function intro_plankanimationscenelogic() {
  level endon("intro_levelHasSniper");
  var0 = getspawnerarray("intro_animatedPlankAllySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.targetname = "intro_animatedAlly";
    var3.animname = "intro_animatedPlankAlly" + var3.script_index;
    var3 scripts\engine\sp\utility::disable_surprise();
    var3 scripts\engine\sp\utility::disable_bulletwhizbyreaction();
    var3 scripts\engine\utility::disable_pain();
    var3 pushplayer(1);
    var3.script_pushable = 0;

    if(scripts\engine\utility::is_equal(var3.demeanoroverride, "casual")) {
      var3 scripts\common\ai::gun_remove();
      var3.gunremoved = 1;
    }
  }

  var5 = scripts\engine\sp\utility::spawn_anim_model("intro_animatedPlankCrate");
  var6 = scripts\engine\utility::array_add(var1, var5);
  var7 = scripts\engine\utility::getStruct("intro_plankAnimationStruct", "targetname");
  thread scripts\sp\maps\highway\highway_utility::animation_single(var7, var6, "intro_plankEnter");
  thread intro_plankanimationscenecratelogic(var5);
  var8 = getEnt("intro_nearPlankAlliesTrigger", "targetname");
  var8 waittill("trigger");

  foreach(var10 in var6) {
    if(!isDefined(var10)) {
      continue;
    }

    var10 delete();
  }
}

function intro_plankanimationscenecratelogic(var0) {
  level.player endon("death");
  var0 endon("entitydeleted");
  scripts\sp\maps\highway\highway_utility::animation_waittillend(var0);

  for(;;) {
    var1 = sighttracepassed(var0.origin, level.player getEye(), 0, level.player, 1);

    if(!var1) {
      break;
    }

    waitframe();
  }

  var0 delete();
}

function intro_spawnanimatedphoneally() {
  var0 = getspawner("intro_animatedPhoneAllySpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.targetname = "intro_animatedAlly";
  var1.animname = "intro_animatedPhoneAlly";
  scripts\sp\maps\highway\highway_utility::ai_setname(var1, "");
  var1 scripts\common\ai::gun_remove();
  var1.gunremoved = 1;
  return var1;
}

function intro_spawnanimatedcinderblockallies() {
  var0 = getspawnerarray("intro_animatedCinderblockAllySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.targetname = "intro_animatedAlly";
    var3.animname = "intro_animatedCinderblockAlly" + var3.script_index;
    scripts\sp\maps\highway\highway_utility::ai_setname(var3, "");
    var4 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
    var3 scripts\anim\shared::forceuseweapon(var4, "primary");
  }

  return var1;
}

function intro_spawnanimatedstairsally() {
  var0 = getspawner("intro_animatedStairsAllySpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.targetname = "intro_animatedAlly";
  var1.animname = "intro_animatedStairsAlly";
  scripts\sp\maps\highway\highway_utility::ai_setname(var1, "");
  return var1;
}

function intro_stairsanimationscenelogic(var0, var1, var2, var3) {
  intro_stairsanimationwaittillscene(var1, var3);
  thread scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var1, "intro_stairsEnter", "intro_stairsIdle");
  thread scripts\sp\maps\highway\highway_utility::animation_singleintolastframe(var0, var2, "intro_stairsEnter");
}

function intro_stairsanimationwaittillscene(var0, var1) {
  level endon(var1);

  for(;;) {
    var2 = sighttracepassed(var0 getEye(), level.player getEye(), 0, var0, 1);

    if(var2) {
      break;
    }

    waitframe();
  }
}

function intro_dialoguejokesectionalogic(var0) {
  level.player endon("death");
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_intro_joke_10", 1);
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_intro_joke_20", 0.25);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_intro_joke_30", 0.4);
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_intro_joke_40", 0.25);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_intro_joke_50");
}

function intro_dialoguejokesectionblogic(var0) {
  level.player endon("death");
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_intro_joke_60");
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_intro_joke_70");
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_intro_joke_80");
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_intro_joke_90");
}

function intro_animatedpropscleanuplogic(var0) {
  level.player waittill("tutorial_playerFoundAllies");

  foreach(var2 in var0) {
    var2 delete();
  }

  var4 = ride_getvehicle();
  var4 delete();
}

function intro_getanimatedallies() {
  return getEntArray("intro_animatedAlly", "targetname");
}

function roof_start() {
  scripts\sp\maps\highway\highway_utility::level_setfailonfriendlyfire(1);
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  scripts\sp\maps\highway\highway_utility::ai_setname(var0, "");
  var1 = level_gettownanimationstruct();
  intro_hadirscenelogic(var1);
  intro_setupanimatedfarahscope(var1);
  var2 = level_gethadir();
  var2 scripts\engine\sp\utility::set_ignoreme(1);
  var2 scripts\engine\sp\utility::set_ignoreall(1);
  scripts\sp\maps\highway\highway_utility::ai_setname(var2, "");
  player_givesecondaryweapon();
  thread intro_playerspeedscalinglogic();
  scripts\engine\sp\utility::set_start_location("start_roof", [level.player]);
}

function roof_main() {
  roof_setuptutorialallies();
  var0 = level_getfarah();
  var1 = level_gethadir();
  var2 = intro_getanimatedhadirsniper();
  var3 = level_gettownanimationstruct();
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_intro_village_104", 2);
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_intro_village_105", 4);
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var0);
  scripts\sp\maps\highway\highway_utility::animation_single(var3, var0, "roof_farahEnter");
  roof_scenealogic(var3, var0, var1, var2);
  roof_sceneblogic(var3, var0, var1, var2);
  roof_scenesniperlogic(var3, var0, var1, var2);
  roof_sceneclogic(var3, var0, var1);

  if(true) {
    wait 5;
    return;
  }
}

function roof_scenealogic(var0, var1, var2, var3) {
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var2);
  var4 = roof_gethadirclip();
  var4 delete();
  thread scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var3, "roof_sceneAEnter", "roof_sceneAIdle");
  thread scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var1, "roof_sceneAEnter", "roof_sceneAIdle");
  scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var2, "roof_sceneAEnter", "roof_sceneAIdle");
  thread roof_sceneanaglogic(var0, var2, var3);
  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();
  var5 = scripts\sp\maps\highway\highway_utility::level_objectivegetindex();
  scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_MEET_HADIR", var2.origin);
  objective_onentity(var5, var2);
  objective_setzoffset(var5, 72);
  scripts\sp\maps\highway\highway_utility::player_waittillnearai(var2, 150, undefined, undefined, undefined, 10);
  objective_delete(var5);
}

function roof_sceneanaglogic(var0, var1, var2) {
  level endon("player_nearAI");

  for(;;) {
    scripts\sp\maps\highway\highway_utility::animation_stoploop([var1, var2]);
    childthread scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var2, "roof_sceneANag", "roof_sceneAIdle");
    var0 scripts\common\anim::anim_single_solo(var1, "roof_sceneANag");
    scripts\sp\maps\highway\highway_utility::animation_loop(var0, var1, "roof_sceneAIdle");
    var3 = var1 scripts\engine\utility::getanim("roof_sceneAIdle")[0];
    var4 = getanimlength(var3);
    wait var4;
  }
}

function roof_sceneblogic(var0, var1, var2, var3) {
  scripts\sp\maps\highway\highway_utility::animation_stoploop([var1, var2, var3]);
  thread scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var1, "roof_sceneBEnter", "roof_sceneBIdle");
  thread scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var2, "roof_sceneBEnter", "roof_sceneBIdle");
  var0 scripts\common\anim::anim_single_solo(var3, "roof_sceneBEnter");
}

function roof_scenesniperlogic(var0, var1, var2, var3) {
  level.player scripts\sp\utility::allow_weapon_first_raise_anims(1);
  var4 = roof_spawnsniperweapon(var3.origin, var3.angles);
  var3 delete();
  var5 = ["dx_vom_had_intro_gun_80"];
  var2 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var5, 10, var4, "trigger", 10, undefined, undefined, "roof_sceneBNag", "roof_sceneBIdle", var0);
  var6 = ["dx_vom_far_intro_gun_90"];
  var1 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var6, 10, var4, "trigger", 17);
  var7 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_GRAB_SNIPER", var4.origin + (0, 0, 12));
  level.player scripts\sp\player::focus_display_hint(11, undefined, var4, "trigger");
  var4 waittill("trigger");
  level notify("intro_levelHasSniper");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  scripts\sp\player::player_movement_state("default");
  thread roof_sniperpickupplayerdisablelogic();
  var8 = player_getballisticsweaponobject();
  level.player setweaponammoclip(var8, weaponclipsize(var8));
  level.player setweaponammostock(var8, weaponmaxammo(var8));
  objective_delete(var7);
  level_addmissionnarrativeobjective();
  level.player thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_intro_gun_95", 3.2);
  level.player thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_intro_gun_110", 8);
}

function roof_sniperpickupplayerdisablelogic() {
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_sprint(0);
  level.player scripts\common\utility::allow_jump(0);
  level.player scripts\common\utility::allow_ads(0);
  level.player scripts\common\utility::allow_fire(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\common\utility::allow_weapon_switch(0);
  wait 8;
  level.player scripts\common\utility::allow_prone(1);
  level.player scripts\common\utility::allow_sprint(1);
  level.player scripts\common\utility::allow_jump(1);
  level.player scripts\common\utility::allow_ads(1);
  level.player scripts\common\utility::allow_fire(1);
  level.player scripts\common\utility::allow_offhand_weapons(1);
  level.player scripts\common\utility::allow_weapon_switch(1);
}

function roof_sceneclogic(var0, var1, var2) {
  var3 = 2;
  wait var3;
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var2);
  scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var2, "roof_sceneCEnter", "roof_sceneCIdle");
  var2 pushplayer(1);
  var2.script_pushable = 0;
  var2 scripts\common\utility::demeanor_override("casual_gun");
  thread roof_scenefarahspotlogic(var0, var1, var2);
}

function roof_scenefarahspotlogic(var0, var1, var2) {
  var3 = 1.8;
  wait var3;
  thread roof_scenefarahanimationlogic(var0, var1, var2);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_intro_gun_70");

  if(!player_isprone()) {
    var2 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_intro_gun_120", 0.75, level, "tutorial_goProneComplete");
    return;
  }
}

function roof_scenefarahanimationlogic(var0, var1, var2) {
  setmusicstate("");
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var1);
  var3 = intro_getanimatedfarahscope();
  thread scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var3, "roof_sceneCEnter", "roof_sceneCIdle");
  scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var1, "roof_sceneCEnter", "roof_sceneCIdle");
  var4 = roof_getfarahclip();
  var4 delete();
}

function roof_spawnsniperweapon(var0, var1) {
  var2 = "weapon_" + player_getprimaryweaponname();
  var3 = spawn(var2, var0, 1);
  var3.angles = var1;
  var3.script_ammo_max = 1;
  return var3;
}

function roof_setuptutorialallies() {
  var0 = tutorial_spawnallies();
  var1 = tutorial_getsignalally();
  var2 = scripts\engine\utility::array_remove(var0, var1);
  var3 = tutorial_getallynodes();
  scripts\sp\maps\highway\highway_utility::ai_takecoveratnodes(var2, var3);
}

function roof_gethadirclip() {
  return getEnt("roof_hadirClip", "targetname");
}

function roof_getfarahclip() {
  return getEnt("tutorial_farahClip", "targetname");
}

function roof_catchup() {
  var0 = roof_gethadirclip();
  var0 delete();
  var1 = roof_getfarahclip();
  var1 delete();
}

function tutorial_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  scripts\sp\maps\highway\highway_utility::ai_setname(var0, "");
  var1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var1);
  scripts\sp\maps\highway\highway_utility::animation_loop(var1, var0, "intro_farahSceneCIdle");
  var2 = level_spawnhadir();
  var2 scripts\engine\sp\utility::set_ignoreme(1);
  var2 scripts\engine\sp\utility::set_ignoreall(1);
  scripts\sp\maps\highway\highway_utility::ai_setname(var2, "");
  player_givefullloadout();
  roof_setuptutorialallies();
  level_spawnredshirts();
}

function tutorial_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("tutorial");
  scripts\sp\maps\highway\highway_utility::level_setfailonfriendlyfire(0);
  var0 = level_getfarah();
  var1 = level_gethadir();
  thread tutorial_allieslogic();
  setsaveddvar("LKKMQRSKTS", 0);
  setsaveddvar("MMLNNQSTTL", 30);
  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();

  if(!player_isprone()) {
    tutorial_goprone(var0);
  }

  if(!level.player playerads()) {
    tutorial_ads(var0);
  }

  tutorial_signalallylogic(var0, var1);

  if(!player_sniperzoomedin()) {
    tutorial_zoomin(var0);
  }

  scripts\sp\maps\highway\highway_utility::ai_setname(var0, "Farah");
  scripts\sp\maps\highway\highway_utility::ai_setname(var1, "Hadir");
  tutorial_alliessearch(var0);
  thread tutorial_primarytargetlogic();
  thread tutorial_secondarytargetlogic();
  level.player scripts\engine\utility::waittill_multiple("tutorial_primary_target_shot", "tutorial_secondary_target_shot");
  level_addmissionnarrativeobjective();
  setsaveddvar("LKKMQRSKTS", 1);
}

function tutorial_allieslogic() {
  level.player waittill("tutorial_playerFoundAllies");
  var0 = ride_getanimatedallies();

  foreach(var2 in var0) {
    scripts\sp\maps\highway\highway_utility::animation_stoploop(var2);
    var2 delete();
  }

  var4 = intro_getanimatedallies();

  foreach(var2 in var4) {
    var2 scripts\engine\sp\utility::anim_stopanimScripted();
    scripts\sp\maps\highway\highway_utility::animation_stoploop(var2);
    var2.targetname = "level_redShirt";
    var2.animname = "level_redShirt";
    var2 scripts\common\utility::clear_demeanor_override();
    var2 pushplayer(0);
    var2.script_pushable = 1;

    if(istrue(var2.gunremoved)) {
      var2 scripts\common\ai::gun_recall();
    }

    if(isDefined(var2.script_friendname)) {
      scripts\sp\maps\highway\highway_utility::ai_setname(var2, var2.script_friendname);
    }
  }

  thread level_redshirtslogic();
}

function tutorial_spawnallies() {
  var0 = getspawnerarray("tutorial_allySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3 scripts\engine\sp\utility::set_ignoreall(1);
    var3.targetname = "intro_highwayAlly";
    var3.animname = "tutorial_ally";
    var3.name = "";
    var3 scripts\engine\sp\utility::set_baseaccuracy(0.1);
    var3 scripts\common\ai::magic_bullet_shield();
    var3 scripts\engine\sp\utility::set_grenadeweapon("molotov");
    var3 scripts\engine\sp\utility::set_grenadeammo(3);
  }

  foreach(var3 in var1) {
    var1 = var3;
  }

  return var1;
}

function tutorial_getallies() {
  return getEntArray("intro_highwayAlly", "targetname");
}

function tutorial_getallynodes() {
  return getnodearray("tutorial_allyNode", "targetname");
}

function tutorial_goprone(var0) {
  var1 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_GO_PRONE", (-547, -1740, 1204));
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_intro_prone_10", 5, level, "tutorial_goProneComplete");
  var2 = ["dx_vom_far_intro_prone_20", "dx_vom_far_intro_prone_30"];
  var0 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var2, 8, level, "tutorial_goProneComplete", 15);
  var3 = getkeybinding("+stance");

  if(level.player usinggamepad() || var3["count"] || level.player getlocalplayerprofiledata("proneType") == 2) {
    scripts\engine\sp\utility::display_hint("prone", undefined, 7);
  } else {
    scripts\engine\sp\utility::display_hint("prone_toggle", undefined, 7);
  }

  while(!player_isprone()) {
    waitframe();
  }

  objective_delete(var1);
  level notify("tutorial_goProneComplete");
}

function tutorial_ads(var0) {
  var1 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_AIM_DOWN_SIGHTS");
  scripts\sp\maps\highway\highway_utility::waittill_nodialogueplaying();
  var2 = ["dx_vom_far_intro_tut_12", "dx_vom_far_intro_tut_14", "dx_vom_far_intro_tut_13"];
  var0 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var2, 4, level.player, "ads_pressed", 1);

  if(level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledGamepad") || !level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledKeyboard")) {
    scripts\engine\sp\utility::display_hint("ads_toggle", undefined, 6, level.player, "ads_pressed");
  } else {
    scripts\engine\sp\utility::display_hint("ads", undefined, 6, level.player, "ads_pressed");
  }

  for(;;) {
    level.player waittill("ads_pressed");

    if(player_holdingballisticsweapon()) {
      break;
    }

    var0 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var2, 4, level.player, "ads_pressed", 1.5);
  }

  while(!player_fullads()) {
    waitframe();
  }

  objective_delete(var1);
}

function tutorial_signalallylogic(var0, var1) {
  var2 = tutorial_getsignalally();
  var2 endon("death");
  var2 attach("com_flashlight_on_xforward", "tag_accessory_left");
  scripts\sp\maps\highway\highway_utility::animation_loop(var2, var2, "tutorial_idle");
  GscBinSkip4(0x35, var2);
}

function tutorial_allysignaleffectslogic(var0) {
  var0 endon("tutorial_allyStopSignal");
  var1 = 1;
  var2 = 1.5;
  var3 = 1;
  var4 = 3;
  var5 = 0.2;
  var6 = 0.3;

  for(;;) {
    var7 = randomintrange(var3, var4);

    for(var8 = 0; var8 < var7; var8++) {
      var9 = var0 gettagorigin("tag_light");
      var10 = anglesToForward(var0 gettagangles("tag_light"));
      playFX(level._effect["vfx_highway_mirror_glint"], var9, var10);
      var11 = randomfloatrange(var5, var6);
      wait var11;
    }

    var12 = randomfloatrange(var1, var2);
    wait var12;
  }
}

function tutorial_deletesniperbench() {
  var0 = tutorial_getsniperbench();
  scripts\engine\utility::array_delete(var0);
}

function tutorial_getsniperbench() {
  return getEntArray("tutorial_sniperBench", "targetname");
}

function tutorial_zoomin(var0) {
  var1 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_ZOOM_IN");
  var2 = 1;
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_zoom_10", var2, level.player, "player_variableZoomedIn");
  var3 = gettime() + var2 * 1000;
  var4 = lookupsoundlength("dx_vom_far_tutorial_zoom_10");
  var5 = var3 + var4;
  scripts\engine\sp\utility::display_hint_forced("zoom_in", undefined, 1.5, level.player, "player_variableZoomedIn");
  var6 = 4;
  var6 += var2 + var4 * 0.001;
  var7 = ["dx_vom_far_tutorial_zoom_40", "dx_vom_far_tutorial_zoom_30", "dx_vom_far_tutorial_zoom_50"];
  var0 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var7, 8, level.player, "player_variableZoomedIn", var6);
  level.player waittill("player_variableZoomedIn");

  if(gettime() < var5) {
    objective_delete(var1);
    return;
  }

  scripts\sp\maps\highway\highway_utility::waittill_nodialogueplaying();
  scripts\sp\maps\highway\highway_utility::waittill_time(var5);
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_tutorial_zoom_20", 1);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_zoom_21", 0.5);
  objective_delete(var1);
}

function tutorial_alliessearch(var0) {
  var1 = tutorial_getanimationorigin();
  var2 = tutorial_spawnprimarytarget();
  var1 scripts\common\anim::anim_first_frame_solo(var2, "tutorial_targetEnter");
  tutorial_setalliesnames();
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_zoom_110");
  var3 = tutorial_getallies();
  var4 = tutorial_getsignalally();
  var5 = scripts\engine\utility::array_remove(var3, var4);
  var4 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_fsa1_tutorial_zoom_120", 1.5);
  var6 = (0, 0, 0);

  foreach(var8 in var5) {
    var6 += var8.origin;
  }

  var6 += (0, 0, 300);
  var6 /= var5.size;
  var10 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_FIND_ALLIES", var6);
  var4 notify("tutorial_allyStopSignal");
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_fsa_10", 3.5, level.player, "tutorial_playerFoundAllies");
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var4);
  scripts\sp\maps\highway\highway_utility::animation_single(var4, var4, "tutorial_enter");
  var11 = getnode("tutorial_signalAllyNode", "script_noteworthy");
  var4 scripts\engine\sp\utility::set_goalRadius(4);
  var4 setgoalnode(var11);
  var4 detach("com_flashlight_on_xforward", "tag_accessory_left");
  var4 scripts\sp\maps\highway\highway_utility::ai_resetstances();
  var12 = ["dx_vom_far_tutorial_fsa_20", "dx_vom_far_tutorial_fsa_30", "dx_vom_far_tutorial_fsa_40"];
  var13 = ["dx_vom_far_tutorial_fsa_42", "dx_vom_far_tutorial_fsa_43", "dx_vom_far_tutorial_fsa_41"];
  var0 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var12, 10, level.player, "tutorial_playerFoundAllies", 20, var13, &player_sniperzoomedin);
  level.player scripts\sp\player::focus_display_hint(15, undefined, level.player, "tutorial_playerFoundAllies");
  var14 = 750;
  var15 = 0;

  for(;;) {
    var16 = undefined;
    var17 = level.player getEye();
    var18 = anglesToForward(level.player getplayerangles());
    var19 = -2147483647;
    var18 = anglesToForward(level.player getgunangles());

    foreach(var8 in var5) {
      var21 = vectorNormalize(var8 getEye() - level.player getEye());
      var22 = vectordot(var18, var21);

      if(var22 > var19) {
        var19 = var22;
        var16 = var8;
      }
    }

    var24 = isDefined(var16) && var19 > 0.999981 && sighttracepassed(var17, var16 getEye(), 0, var16, 1);

    if(var24 && player_sniperzoomedin()) {
      if(!var15) {
        var15 = gettime();
      }

      if(gettime() >= var15 + var14) {
        break;
      }
    } else {
      var15 = 0;
    }

    waitframe();
  }

  level.player notify("tutorial_playerFoundAllies");
  scripts\sp\maps\highway\highway_utility::waittill_nodialogueplaying();
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_tutorial_fsa_60");
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_fsa_70", 0.5);
  var17 = level.player getEye();
  var18 = anglesToForward(level.player getplayerangles());
  var19 = -2147483647;
  var18 = anglesToForward(level.player getgunangles());
  var25 = undefined;

  foreach(var8 in var5) {
    var21 = vectorNormalize(var8 getEye() - level.player getEye());
    var22 = vectordot(var18, var21);

    if(var22 > var19) {
      var19 = var22;
      var25 = var8;
    }
  }

  var25.script_noteworthy = "intro_chosenHighwayAlly";
  objective_delete(var10);
  tutorial_placetargetlogic(var2, var1, var25);
}

function tutorial_placetargetlogic(var0, var1, var2) {
  var3 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_KEEP_SIGHTS", var2.origin);
  objective_onentity(var3, var2);
  objective_setzoffset(var3, 72);
  thread tutorial_placetargetdialoguelogic(var2);
  var2 waittill("tutorial_chosenAllyPlaceTarget");
  var4 = 1;
  wait var4;
  var5 = var2.node;
  var1 scripts\sp\anim::anim_reach_solo(var2, "tutorial_targetEnter");
  var1 thread scripts\common\anim::anim_single_solo(var0, "tutorial_targetEnter");
  var1 scripts\common\anim::anim_single_solo(var2, "tutorial_targetEnter");
  var2 scripts\engine\sp\utility::set_goalRadius(64);

  if(isDefined(var5)) {
    var2 setgoalnode(var5);
  }

  objective_delete(var3);
}

function tutorial_placetargetdialoguelogic(var0) {
  var1 = level_getfarah();
  var2 = tutorial_getfarahcommandallylines();
  var1 scripts\sp\maps\highway\highway_utility::dialogue(var2[var0.script_index], 1);
  var3 = tutorial_getallyreplylines();
  var0 notify("tutorial_chosenAllyPlaceTarget");
  var0 scripts\sp\maps\highway\highway_utility::dialogue(var3[var0.script_index], undefined, undefined, undefined, 1);
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_target_140", 0.75);
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_30", 5);
  var0 waittill("goal");
  wait 4.25;
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_" + var0.aliasname + "_tutorial_target_190", undefined, undefined, undefined, 1);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_target_210");
}

function tutorial_getsignalally() {
  return getEnt("tutorial_signalAlly", "script_noteworthy");
}

function tutorial_getanimationorigin() {
  return getEnt("tutorial_animationOrigin", "targetname");
}

function tutorial_primarytargetlogic() {
  var0 = tutorial_getprimarytarget();
  thread tutorial_primarytargetaim(var0);
  thread tutorial_primarytargetmiss(var0);
  level.player scripts\sp\player::focus_display_hint(25, undefined, var0, "ballistics_bulletDamage");
  var1 = var0.origin + (0, 0, 50);
  var2 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SHOOT_JUG", var1, &"HIGHWAY/LABEL_SHOOT");
  var0 waittill("ballistics_bulletDamage");
  objective_delete(var2);
  playFX(level._effect["vfx_tutorial_target_explosion"], var0.origin);
  var0 delete();
  level.player notify("aimed_for_gravity_primary");
  level.player notify("aimed_for_wind_primary");
  level.player notify("tutorial_primary_target_shot");
}

function tutorial_primarytargetaim(var0) {
  level endon("ballistics_impact");
  tutorial_primarytargetaimgravity(var0);
  tutorial_primarytargetaimwind(var0);
}

function tutorial_primarytargetaimgravity(var0) {
  var1 = level_getfarah();
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_40", 0.5, level, "ballistics_impact");
  var2 = ["dx_vom_far_tutorial_adjust_50", "dx_vom_far_tutorial_adjust_60", "dx_vom_far_tutorial_adjust_70"];
  var3 = ["dx_vom_far_tutorial_zoom_40", "dx_vom_far_tutorial_zoom_30", "dx_vom_far_tutorial_zoom_50"];
  var1 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var2, 7, level.player, "aimed_for_gravity_primary", 6, var3, &player_sniperzoomedin);
  var4 = 300;
  var5 = 0;

  for(;;) {
    var6 = scripts\sp\player\ballistics::ballistics_doesbullettrajectoryhitentity(level.player getEye(), level.player getplayerangles(), var0, 0);

    if(var6 && player_sniperzoomedin()) {
      if(!var5) {
        var5 = gettime();
      }

      if(gettime() >= var5 + var4) {
        break;
      }
    } else {
      var5 = 0;
    }

    waitframe();
  }

  level.player notify("aimed_for_gravity_primary");
  scripts\sp\maps\highway\highway_utility::waittill_nodialogueplaying();
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_tutorial_adjust_80");
}

function tutorial_primarytargetaimwind(var0) {
  var1 = level_getfarah();
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_target_160");

  if(level.ballistics.winddirectionaimstring == "left") {
    var2 = ["dx_vom_far_tutorial_adjust_100", "dx_vom_far_tutorial_adjust_130", "dx_vom_far_tutorial_adjust_145"];
  } else {
    var2 = ["dx_vom_far_tutorial_adjust_110", "dx_vom_far_tutorial_adjust_160", "dx_vom_far_tutorial_adjust_175"];
  }

  var2 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var2, 8, level.player, "aimed_for_wind_primary", 2.5);
  var3 = 300;
  var4 = 0;

  for(;;) {
    var5 = scripts\sp\player\ballistics::ballistics_doesbullettrajectoryhitentity(level.player getEye(), level.player getplayerangles(), var1, 1);

    if(var5 && player_sniperzoomedin()) {
      if(!var4) {
        var4 = gettime();
      }

      if(gettime() >= var4 + var3) {
        break;
      }
    } else {
      var4 = 0;
    }

    waitframe();
  }

  level.player notify("aimed_for_wind_primary");
  scripts\sp\maps\highway\highway_utility::waittill_nodialogueplaying();
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_tutorial_zoom_100", 0.5);
  var2 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_210", 0.5, level, "ballistics_impact");
  var6 = ["dx_vom_far_tutorial_adjust_211", "dx_vom_far_tutorial_adjust_212", "dx_vom_far_tutorial_adjust_213"];
  var2 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var6, 7, level, "ballistics_impact", 6);
}

function tutorial_primarytargetmiss(var0) {
  var0 endon("ballistics_bulletDamage");
  var1 = level_getfarah();
  var2 = level_gethadir();
  level waittill("ballistics_impact", var3);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_10", 0.5);
  var2 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_tutorial_adjust_20", 1.5);

  if(level.ballistics.winddirectionaimstring == "left") {
    var4 = "dx_vom_far_tutorial_adjust_145";
  } else {
    var4 = "dx_vom_far_tutorial_adjust_175";
  }

  var2 scripts\sp\maps\highway\highway_utility::dialogue(var4, 3.5);
}

function tutorial_secondarytargetlogic() {
  var0 = level_getfarah();
  var1 = tutorial_getsecondarytarget();
  thread tutorial_secondaryaim(var1);
  var1 waittill("ballistics_bulletDamage");
  var2 = getEnt(var1.target, "targetname");
  playFX(level._effect["vfx_watermelon_explosion"], var2.origin);
  var2 delete();
  var1 delete();
  level.player notify("tutorial_secondary_target_shot");
}

function tutorial_secondaryaim(var0) {
  level.player waittill("tutorial_primary_target_shot");

  if(!isDefined(var0)) {
    return;
  }

  level.player scripts\sp\player::focus_display_hint(35, undefined, var0, "ballistics_bulletDamage");
  var1 = var0.origin + (0, 0, 50);
  var2 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SHOOT_WATERMELON", var1, &"HIGHWAY/LABEL_SHOOT");
  var0 thread scripts\sp\maps\highway\highway_utility::call_on_notify_no_self("ballistics_bulletDamage", &objective_delete, var2);
  thread tutorial_secondarytargetlookat(var0);
}

function tutorial_secondarytargetlookat(var0) {
  var0 endon("ballistics_bulletDamage");
  var1 = level_getfarah();
  var2 = level_gethadir();
  var1 scripts\sp\maps\highway\highway_utility::dialogue_stop();
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_350", 0.5);
  var2 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_tutorial_jug_100", 1);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_230", 0.5);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_melon_10", 1);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_melon_20", 1);
  tutorial_secondarylookatbuilding(var0);
  scripts\sp\maps\highway\highway_utility::waittill_nodialogueplaying();
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_tutorial_melon_60", 0.5, var0, "ballistics_bulletDamage");

  if(!player_sniperzoomedin()) {
    scripts\engine\sp\utility::display_hint("zoom_in");
    var3 = 0.5;
    var4 = 4;
    var5 = ["dx_vom_far_tutorial_zoom_40", "dx_vom_far_tutorial_zoom_30", "dx_vom_far_tutorial_zoom_50"];
    var1 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var5, var4, level.player, "sprint_pressed", var3);

    for(;;) {
      level.player waittill("sprint_pressed");

      if(player_fullads() && player_holdingballisticsweapon()) {
        break;
      }

      var1 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var5, 3, level.player, "sprint_pressed", 0.25);
    }
  }

  scripts\sp\maps\highway\highway_utility::waittill_nodialogueplaying();
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_melon_70", 0.5, var0, "ballistics_bulletDamage");
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_melon_90", 1, level, "ballistics_impact");
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_melon_91", 11, level, "ballistics_impact");
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_melon_92", 17, level, "ballistics_impact");
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_melon_93", 24, level, "ballistics_impact");
  GscBinSkip4(0x35, var0);
}

function tutorial_secondarylookatbuilding(var0) {
  var1 = level_getfarah();

  if(player_sniperzoomedin()) {
    scripts\engine\sp\utility::display_hint("zoom_out", undefined, undefined, level, "tutorial_secondaryTargetLookedAt");
  }

  var2 = scripts\engine\utility::getStruct("tutorial_secondaryLookAtStruct", "targetname");
  var3 = ["dx_vom_far_tutorial_melon_30", "dx_vom_far_tutorial_melon_50"];
  var1 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var3, 8, level, "tutorial_secondaryTargetLookedAt", 6);

  for(;;) {
    var4 = vectorNormalize(var2.origin - level.player getEye());
    var5 = anglesToForward(level.player getplayerangles());
    var6 = vectordot(var4, var5);
    var7 = sighttracepassed(var2.origin, level.player getEye(), 0, level.player, 1);

    if(player_fullads() && player_holdingballisticsweapon() && var6 > 0.999949 && var7) {
      break;
    }

    waitframe();
  }

  level notify("tutorial_secondaryTargetLookedAt");
}

function tutorial_secondarytargetmisslogic(var0) {
  var1 = level_getfarah();

  for(;;) {
    level waittill("ballistics_impact", var2);
    var3 = var2 - var0.origin;
    var4 = vectorNormalize(level.player.origin - var0.origin);
    var5 = anglestoup(level.player getplayerangles());
    var6 = anglestoright(level.player getplayerangles());
    var7 = vectordot(var3, var6);
    var8 = vectordot(var3, var5);
    var9 = 10;
    var10 = 12;
    var11 = 4;
    var12 = abs(var7) > var9;
    var13 = var8 > var10 + var11 || var8 < var11 * -1;

    if(var12) {
      var14 = var7 > 0;
      var15 = !var14;
    } else {
      var14 = 0;
      var15 = 0;
    }

    if(var13) {
      var16 = var8 > 0;
      var17 = !var16;
    } else {
      var16 = 0;
      var17 = 0;
    }

    if(var14) {
      if(var13) {
        if(var16) {
          var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_250", 1);
        } else {
          var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_260", 1);
        }
      } else {
        var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_310", 1);
      }

      continue;
    }

    if(var15) {
      if(var13) {
        if(var16) {
          var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_280", 1);
        } else {
          var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_290", 1);
        }
      } else {
        var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_320", 1);
      }

      continue;
    }

    if(var16) {
      var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_330", 1);
      continue;
    }

    if(var17) {
      var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_340", 1);
    }
  }
}

function tutorial_spawnprimarytarget() {
  var0 = scripts\engine\sp\utility::spawn_anim_model("tutorial_primaryTarget");
  var0.targetname = "tutorial_primary_target";
  return var0;
}

function tutorial_getprimarytarget() {
  return getEnt("tutorial_primary_target", "targetname");
}

function tutorial_getsecondarytarget() {
  return getEnt("tutorial_secondary_target", "targetname");
}

function tutorial_getfarahcommandallylines() {
  return ["dx_vom_far_tutorial_target_60", "dx_vom_far_tutorial_target_30", "dx_vom_far_tutorial_target_40", "dx_vom_far_tutorial_target_50", "dx_vom_far_tutorial_target_20"];
}

function tutorial_getallyreplylines() {
  return ["dx_vom_fsf2_tutorial_target_80", "dx_vom_fsa2_tutorial_target_80", "dx_vom_fsa3_tutorial_target_80", "dx_vom_fsf1_tutorial_target_80", "dx_vom_fsa1_tutorial_target_80"];
}

function tutorial_getallyreadylines() {
  return ["dx_vom_fsf2_tutorial_target_190", "dx_vom_fsa1_tutorial_target_190", "dx_vom_fsa2_tutorial_target_190", "dx_vom_fsa3_tutorial_target_190", "dx_vom_fsf1_tutorial_target_190"];
}

function tutorial_setalliesnames() {
  var0 = tutorial_getallies();
  var0 = scripts\sp\maps\highway\highway_utility::array_sortbyscriptindex(var0);
  var1 = tutorial_getallynames();
  var2 = tutorial_getallyaliasnames();

  foreach(var4 in var0) {
    var4.name = var1[var4.script_index];
    var4.aliasname = var2[var4.script_index];
  }
}

function tutorial_getallynames() {
  return ["Nida", "Imaad", "Raza", "Ayah", "Ali"];
}

function tutorial_getallyaliasnames() {
  return ["fsf2", "fsa2", "fsa3", "fsf1", "fsa1"];
}

function tutorial_catchup() {
  var0 = tutorial_getsecondarytarget();
  var0 delete();
  tutorial_deletesniperbench();
}

function scouting_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var1);
  scripts\sp\maps\highway\highway_utility::animation_loop(var1, var0, "intro_farahSceneCIdle");
  var2 = level_spawnhadir();
  var2 scripts\engine\sp\utility::set_ignoreme(1);
  var2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var3 = tutorial_spawnallies();
  var4 = tutorial_getallynodes();

  for(var5 = 0; var5 < var3.size; var5++) {
    var3[var5] scripts\engine\sp\utility::teleport_ai(var4[var5]);
  }

  tutorial_setalliesnames();
  level_addmissionnarrativeobjective();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility::player_startpronehack();
}

function scouting_main() {
  var0 = level_getfarah();
  var1 = level_gethadir();
  var0 scripts\sp\maps\highway\highway_utility::dialogue_stop();
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_220", 0.5);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_tutorial_melon_100", 1);
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_tutorial_melon_110", 0.5);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_melon_150", 0.5);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_dogs_10");
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_dogs_12", 0.5);
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_tutorial_dogs_14", 0.5);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_dogs_16", 0.5);
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_tutorial_dogs_18", 9);
}

function dogs_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var1);
  scripts\sp\maps\highway\highway_utility::animation_loop(var1, var0, "intro_farahSceneCIdle");
  var2 = level_spawnhadir();
  var2 scripts\engine\sp\utility::set_ignoreme(1);
  var2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var3 = tutorial_spawnallies();
  var4 = tutorial_getallynodes();

  for(var5 = 0; var5 < var3.size; var5++) {
    var3[var5] scripts\engine\sp\utility::teleport_ai(var4[var5]);
  }

  tutorial_setalliesnames();
  level_addmissionnarrativeobjective();
  level_spawnredshirts();
}

function dogs_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("dogs");
  var0 = dogs_spawndogs();
  thread dogs_pathlogic(var0);
  thread dogs_runlogic(var0);
  dogs_dialoguelogic(var0);

  if(istrue(10)) {
    wait 10;
    return;
  }
}

function dogs_pathlogic(var0) {
  level endon("ballistics_impact");
  level endon("dogs_forceRun");
  scripts\engine\utility::array_wait(var0, "reached_path_end");
  level notify("dogs_pathReachedEnd");
}

function dogs_runlogic(var0) {
  level endon("dogs_pathReachedEnd");
  level scripts\engine\utility::waittill_any("ballistics_impact", "dogs_forceRun");
  var1 = scripts\engine\utility::getStructArray("dogs_runPositionStruct", "targetname");

  foreach(var3 in var0) {
    var3 scripts\common\utility::demeanor_override("sprint");
    var3 notify("stop_going_to_node");
    var4 = sortbydistance(var1, var3.origin)[0];
    var3 scripts\engine\sp\utility::set_goal_radius(64);
    var3 thread scripts\sp\spawner::go_to_node(var4);
    var1 = scripts\engine\utility::array_remove(var1, var4);
  }

  scripts\engine\utility::array_wait(var0, "goal");
  level notify("dogs_pathReachedEnd");
}

function dogs_dialoguelogic(var0) {
  level endon("ballistics_impact");
  level endon("dogs_forceRun");
  thread dogs_dialogueplayermisslogic(var0);
  thread dogs_dialoguedeathlogic(var0);
  var1 = level_getfarah();
  var2 = 6;
  var3 = 2;
  var4 = 13;
  var5 = 3;
  var6 = 7.5;
  wait var2;
  thread dogs_playerspotteddogslogic(var0);
  var7 = level scripts\engine\utility::waittill_notify_or_timeout_return("dogs_playerSpottedDogs", var3);

  if(scripts\engine\utility::is_equal(var7, "dogs_playerSpottedDogs")) {
    level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_tutorial_dogs_30");
    thread dogs_playerspotteddogslogic(var0, var5);
    var7 = level scripts\engine\utility::waittill_notify_or_timeout_return("dogs_playerSpottedDogs", var4);

    if(scripts\engine\utility::is_equal(var7, "dogs_playerSpottedDogs")) {
      level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_tutorial_dogs_50");
    } else {
      var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_dogs_60");
    }
  } else {
    var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_dogs_40");
    level notify("dogs_playerSpottedDogs");
    thread dogs_playerspotteddogslogic(var0, var5);
    var7 = level scripts\engine\utility::waittill_notify_or_timeout_return("dogs_playerSpottedDogs", var4);

    if(scripts\engine\utility::is_equal(var7, "dogs_playerSpottedDogs")) {
      level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_tutorial_dogs_50");
    } else {
      var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_dogs_60");
    }
  }

  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_dogs_20", 3.5);
}

function dogs_playerspotteddogslogic(var0, var1) {
  level endon("ballistics_impact");
  level endon("dogs_playerSpottedDogs");
  level endon("dogs_pathReachedEnd");

  foreach(var3 in var0) {
    var3 endon("death");
  }

  if(istrue(var1)) {
    wait var1;
  }

  var5 = 500;

  for(var6 = 0;; var6 = 0) {
    waitframe();
    var7 = (0, 0, 0);

    foreach(var3 in var0) {
      var7 += var3.origin;
    }

    var7 /= var0.size;
    var10 = anglesToForward(level.player getplayerangles());
    var11 = vectorNormalize(var7 - level.player getEye());
    var12 = vectordot(var10, var11);
    var13 = var12 >= 0.999848;
    var14 = sighttracepassed(var7, level.player getEye(), 0, level.player, 1);
    var15 = length(level.player getnormalizedcameramovement());
    var16 = var15 <= 0.65;

    if(player_sniperzoomedin() && var13 && var16 && var14) {
      if(!var6) {
        var6 = gettime();
      }

      if(gettime() >= var6 + var5) {
        break;
      }

      continue;
    }
  }

  level notify("dogs_playerSpottedDogs");
}

function dogs_dialoguedeathlogic(var0) {
  foreach(var2 in var0) {
    var2 endon("entitydeleted");
  }

  var4 = level_getfarah();
  scripts\engine\utility::array_any_wait(var0, "death");
  level notify("dogs_playerShotDog");
  var4 scripts\sp\maps\highway\highway_utility::dialogue_stop();
  var4 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_dogs_80", 1);
  var4 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_dogs_20", 2);
}

function dogs_dialogueplayermisslogic(var0) {
  foreach(var2 in var0) {
    var2 endon("entitydeleted");
  }

  level endon("dogs_playerShotDog");
  var4 = level_getfarah();
  level waittill("ballistics_impact");
  var4 scripts\sp\maps\highway\highway_utility::dialogue_stop();
  var4 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_dogs_90", 1);
  var4 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_dogs_20", 2);
}

function dogs_spawndogs() {
  var0 = getspawnerarray("dogs_dogSpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3 scripts\engine\sp\utility::set_goalRadius(64);
    var3 scripts\engine\sp\utility::set_ignoreall(1);
  }

  return var1;
}

function assassinate_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var1);
  scripts\sp\maps\highway\highway_utility::animation_loop(var1, var0, "intro_farahSceneCIdle");
  var2 = level_spawnhadir();
  var2 scripts\engine\sp\utility::set_ignoreme(1);
  var2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var3 = tutorial_spawnallies();
  var4 = tutorial_getallynodes();

  for(var5 = 0; var5 < var3.size; var5++) {
    var3[var5] scripts\engine\sp\utility::teleport_ai(var4[var5]);
  }

  tutorial_setalliesnames();
  var6 = dogs_spawndogs();
  thread dogs_pathlogic(var6);
  thread dogs_runlogic(var6);
  level_spawnredshirts();
}

function assassinate_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("assassinate");
  var0 = assassinate_spawnVehicle();
  var1 = assassinate_spawnenemiesinvehicle(var0);
  thread scripts\common\vehicle_paths::gopath(var0);
  var2 = level_getfarah();
  thread assassinate_dogslogic();
  thread assassinate_dialoguelogic(var0, var1, var2);
  thread assassinate_sfxlogic(var0);
  thread assassinate_enemieslogic(var0, var1);
  scripts\engine\sp\utility::waittill_dead_or_dying(var1);
  var2 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_combat_90", 1);
}

function assassinate_dogslogic() {
  var0 = 3;
  wait var0;
  level notify("dogs_forceRun");
}

function assassinate_dialoguetruck(var0) {
  wait 4;
  var1 = level_getfarah();
  var2 = tutorial_getsignalally();
  var2 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_fsa1_scout_reveal_10", undefined, undefined, undefined, 1);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_reveal_30", 0.5);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_reveal_50", 0.5);
  var3 = gettime() + 6000;
  var4 = 0;

  for(;;) {
    if(gettime() >= var3) {
      break;
    }

    var5 = anglesToForward(level.player getplayerangles());
    var6 = vectorNormalize(var0.origin - level.player getEye());
    var7 = vectordot(var5, var6);
    var8 = sighttracepassed(var0.origin, level.player getEye(), 0, var0, 1);

    if(var7 >= 0.999848 && var8) {
      var4 = 1;
      break;
    }

    waitframe();
  }

  if(var4) {
    level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_scout_reveal_60", 1);
  } else {
    var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_reveal_70", 1);
  }

  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_reveal_80", 0.5);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_reveal_90");
}

function assassinate_sfxlogic(var0) {
  var0 playSound("scn_highway_truck_incoming_dist_01");
  wait 4;
  setmusicstate("mx_highway_singlecar");
}

function assassinate_dialoguelogic(var0, var1, var2) {
  level endon("assassinate_enemiesAlerted");
  GscBinSkip4(0x35, var0);
}

function assassinate_dialogueinstructionslogic(var0) {
  level endon("ballistics_impact");
  level.player endon("weapon_fired");
  thread assassinate_dialoguemisslogic(var0);
  level waittill("assassinate_enemiesClimbing");
  var1 = level_getfarah();
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_watch_80", 8);
  var2 = "assassinate_playerSpottedEnemies";
  var3 = ["dx_vom_far_scout_watch_120", "dx_vom_far_scout_watch_130", "dx_vom_far_scout_watch_140"];
  var1 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var3, 8, level, var2, 6);
  var4 = 250;
  var5 = 0;

  for(;;) {
    var6 = level.player getEye();
    var7 = anglesToForward(level.player getplayerangles());
    var8 = scripts\engine\sp\utility::get_average_origin(var0);
    var9 = vectorNormalize(var8 - var6);
    var10 = vectordot(var7, var9);
    var11 = sighttracepassed(var8, var6, 0, level.player, 1);

    if(player_sniperzoomedin() && var10 >= 0.999848 && var11) {
      if(!var5) {
        var5 = gettime();
      }

      if(gettime() >= var5 + var4) {
        break;
      }
    } else {
      var5 = 0;
    }

    waitframe();
  }

  level notify(var2);
  scripts\sp\maps\highway\highway_utility::waittill_nodialogueplaying();
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_tutorial_fsa_60", 0.2);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_watch_82", 2);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_melon_90", 2);
  var12 = ["dx_vom_far_convoy_watch_60", "dx_vom_far_scout_watch_83", "dx_vom_far_scout_watch_100"];
  var1 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var12, 8, level.player, "weapon_fired", 6);
}

function assassinate_dialoguemisslogic(var0) {
  foreach(var2 in var0) {
    var2 endon("death");
  }

  var4 = level_gethadir();
  var5 = level_getfarah();

  for(var6 = 1;; var6 = 0) {
    level waittill("ballistics_impact", var7);
    var8 = undefined;
    var9 = level.player getEye();
    var10 = anglesToForward(level.player getplayerangles());
    var11 = -2147483647;
    var10 = anglesToForward(level.player getgunangles());

    foreach(var2 in var0) {
      var13 = vectorNormalize(var2 getEye() - level.player getEye());
      var14 = vectordot(var10, var13);

      if(var14 > var11) {
        var11 = var14;
        var8 = var2;
      }
    }

    var16 = var7 - var8.origin;
    var10 = vectorNormalize(level.player.origin - var8.origin);
    var17 = anglestoup(level.player getplayerangles());
    var18 = anglestoright(level.player getplayerangles());
    var19 = vectordot(var16, var18);
    var20 = vectordot(var16, var17);
    var21 = 10;
    var22 = 12;
    var23 = 4;
    var24 = abs(var19) > var21;
    var25 = var20 > var22 + var23 || var20 < var23 * -1;

    if(var24) {
      var26 = var19 > 0;
      var27 = !var26;
    } else {
      var26 = 0;
      var27 = 0;
    }

    if(var25) {
      var28 = var20 > 0;
      var29 = !var28;
    } else {
      var28 = 0;
      var29 = 0;
    }

    if(var26) {
      if(var25) {
        if(var28) {
          var5 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_250", 1.5);
        } else {
          var5 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_260", 1.5);
        }
      } else {
        var5 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_310", 1.5);
      }
    } else if(var27) {
      if(var25) {
        if(var28) {
          var5 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_280", 1.5);
        } else {
          var5 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_290", 1.5);
        }
      } else {
        var5 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_320", 1.5);
      }
    } else if(var28 || var29) {
      var5 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_60", 1.5);
    }

    if(var6) {
      var4 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_convoy_bc_160", 0.5);
    }
  }
}

function assassinate_dialogueenemydeathslogic() {
  var0 = level_getfarah();

  for(;;) {
    var1 = assassinate_getenemies();
    level waittill("ballistics_impact");

    foreach(var3 in var1) {
      waitframe();
    }

    var5 = assassinate_getenemies();
    var5 = scripts\sp\maps\highway\highway_utility::array_removedeaddyingorundefined(var5);

    if(var5.size && var5.size < var1.size) {
      var6 = var5.size == 1;

      if(var6) {
        var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_combat_50", 1, level, "ballistics_impact");
      } else {
        var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_backup_110", 1, level, "ballistics_impact");
      }
    } else if(!var5.size) {
      break;
    }

    waitframe();
  }
}

function assassinate_enemieslogic(var0, var1) {
  level endon("assassinate_enemiesDead");
  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();
  var2 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SCOUT_ENEMY_VEHICLE");
  objective_onentity(var2, var0);
  objective_setzoffset(var2, 72);
  level thread scripts\sp\maps\highway\highway_utility::call_on_notify_no_self("assassinate_enemiesAlerted", &objective_delete, var2);
  var3 = level_getfarah();

  foreach(var5 in var1) {
    var5 scripts\engine\sp\utility::set_ignoreall(1);
  }

  thread assassinate_driverdeathlogic(var0, var1);
  thread assassinate_enemiesdeathlogic(var1);
  thread assassinate_playeralertsenemies(var0, var1);
  level endon("assassinate_enemiesAlerted");
  var0 waittill("stopped_path");
  level notify("assassinate_enemiesClimbing");
  objective_delete(var2);
  var2 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SHOOT_ENEMIES");
  objective_setzoffset(var2, 72);
  var1 = scripts\sp\maps\highway\highway_utility::array_removedeaddyingorundefined(var1);
  var7 = assassinate_getcrawlcovernodes();
  var8 = assassinate_getanimationstruct();

  foreach(var5 in var1) {
    objective_setlocation(var2, var11, var5);
    var5 thread scripts\sp\maps\highway\highway_utility::call_on_notify_no_self("death", &objective_unsetlocation, var2, var11);
    var8 scripts\common\anim::anim_first_frame_solo(var5, "assassinate_enter");
    var5 allowedstances("prone");
    scripts\sp\maps\highway\highway_utility::ai_instantlyremovefromvehicle(var5);
    var5 attach("equipment_binoculars_01", "tag_accessory_left", 1);
    thread assassinate_enemybinocularslogic(var5);
    thread scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var8, var5, "assassinate_enter", "assassinate_idle");
    var10 = sortbydistance(var7, var5.origin)[0];
    thread assassinate_enemyreactlogic(var5, var10);
    var7 = scripts\engine\utility::array_remove(var7, var10);
  }
}

function assassinate_enemybinocularslogic(var0) {
  scripts\engine\utility::waittill_any_ents(var0, "death", level, "ballistics_impact");

  if(!isDefined(var0)) {
    return;
  }

  var0 detach("equipment_binoculars_01", "tag_accessory_left");
}

function assassinate_driverdeathlogic(var0, var1) {
  var2 = undefined;

  foreach(var4 in var1) {
    if(!scripts\engine\utility::is_equal(var4.vehicle_position, 0)) {
      continue;
    }

    var2 = var4;
  }

  if(!isDefined(var2)) {
    return;
  }

  var2 endon("entitydeleted");
  var2 waittill("death");

  if(!isDefined(var2.ridingvehicle)) {
    return;
  }

  playFX(level.g_effect["human_gib_fullbody"], var2 gettagorigin("j_spine4"));
  var2 delete();
}

function assassinate_getanimationstruct() {
  return scripts\engine\utility::getStruct("assassinate_animationStruct", "targetname");
}

function assassinate_enemyreactlogic(var0, var1) {
  var0 endon("death");
  var2 = assassinate_getanimationstruct();
  var3 = "assassinate_entered";
  thread scripts\sp\maps\highway\highway_utility::animation_notifyonnotetrack(var0, var3);
  var4 = scripts\engine\utility::waittill_any_ents_return(level, "ballistics_impact", var0, var3);

  if(var4 == var3) {
    level waittill("ballistics_impact");
    scripts\sp\maps\highway\highway_utility::animation_stoploop(var0);
    var2 scripts\common\anim::anim_single_solo(var0, "assassinate_react");
  } else {
    scripts\sp\maps\highway\highway_utility::animation_stoploop(var0);
    var0 scripts\engine\sp\utility::anim_stopanimScripted();
  }

  var0 setgoalnode(var1);
}

function assassinate_enemiesdeathlogic(var0) {
  var1 = var0.size;

  for(var2 = 0; var2 < var1; var2++) {
    scripts\engine\utility::array_any_wait(var0, "death");
    var0 = scripts\sp\maps\highway\highway_utility::array_removedeaddyingorundefined(var0);
    level notify("assassinate_enemyDeath");
  }

  level notify("assassinate_enemiesDead");
}

function assassinate_playeralertsenemies(var0, var1) {
  level endon("assassinate_enemiesClimbing");

  for(;;) {
    level waittill("ballistics_impact", var2);
    var1 = scripts\sp\maps\highway\highway_utility::array_removedeaddyingorundefined(var1);

    if(!var1.size) {
      level notify("assassinate_enemiesAlerted");
      break;
    }

    var3 = scripts\engine\sp\utility::get_average_origin(var1);
    var4 = distance(var2, var3);

    if(var4 > 2500) {
      continue;
    }

    level notify("assassinate_enemiesAlerted");
    break;
  }

  waitframe();
  var1 = scripts\sp\maps\highway\highway_utility::array_removedeaddyingorundefined(var1);

  foreach(var6 in var1) {
    var6 scripts\engine\sp\utility::set_ignoreall(0);
    var6 scripts\engine\sp\utility::set_ignoreme(0);
    var6 scripts\common\utility::clear_demeanor_override();
  }

  if(var1.size) {
    var8 = level_getfarah();
    var8 scripts\sp\maps\highway\highway_utility::dialogue_stop();
    var8 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_alert_10", 0.2);
    var8 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_alert_10", 1.5);
  }

  var9 = ambush_getallynodes();
  var10 = tutorial_getallies();

  foreach(var12 in var10) {
    var12 scripts\engine\sp\utility::set_ignoreall(0);
    var12 scripts\engine\sp\utility::set_ignoreme(0);
  }

  scripts\sp\maps\highway\highway_utility::ai_takecoveratnodes(var10, var9);
  var14 = isDefined(var0.driver) && isalive(var0.driver);
  var15 = isDefined(var0.currentnode) && scripts\engine\utility::is_equal(var0.currentnode.script_ent_flag_wait, "trap_setupTruck");

  if(!var14) {
    var0 vehicle_setspeed(0, 15, 15);
    var0 setwaitspeed(0);
    var0 waittill("reached_wait_speed");
  } else if(!var15) {
    var0 vehicle_setspeed(40, 15, 15);
    var16 = scripts\engine\utility::waittill_any_ents_return(var0.driver, "death", var0, "stopped_path");

    if(var16 == "death") {
      var0 vehicle_setspeed(0, 15, 15);
      var0 setwaitspeed(0);
      var0 waittill("reached_wait_speed");
    }
  } else if(var15) {
    var0 waittill("stopped_path");
  }

  var0 scripts\common\vehicle::vehicle_unload();
  var1 = scripts\sp\maps\highway\highway_utility::array_removedeaddyingorundefined(var1);

  foreach(var6 in var1) {
    var6 scripts\engine\sp\utility::set_goalRadius(256);
    var18 = tutorial_getsignalally();
    var6 setgoalentity(var18);
    var6 scripts\common\utility::demeanor_override("sprint");
  }
}

#using_animtree("vehicles");

function assassinate_spawnVehicle() {
  var0 = scripts\common\utility::getvehiclespawner("assassinate_vehicle", "targetname");
  var1 = var0 scripts\common\utility::spawn_vehicle();
  var1.targetname = "assassinate_vehicle";
  var1.dontunloadonend = 1;
  var1 scripts\common\vehicle::godon();
  var1 scripts\engine\utility::ent_flag_init("trap_setupTruck");
  var1 useanimtree(#animtree);
  return var1;
}

function assassinate_getvehicle() {
  var0 = vehicle_getarray();

  foreach(var2 in var0) {
    if(!scripts\engine\utility::is_equal(var2.targetname, "assassinate_vehicle")) {
      var0 = scripts\engine\utility::array_remove(var0, var2);
    }
  }

  return var0[0];
}

function assassinate_spawnenemiesinvehicle(var0) {
  var1 = assassinate_getspawners();

  foreach(var3 in var1) {
    var3.script_forcespawn = 1;
  }

  var5 = var0 scripts\common\vehicle_code::spawn_group(var1);

  foreach(var7 in var5) {
    var7.targetname = "assassinate_enemy";
    var7 scripts\engine\sp\utility::set_goalRadius(64);
    var7.script_parameters = "gib_force";
    var7.animname = "assassinate_enemy" + var7.script_index;
    var7.skipdeathanim = 1;
    var7.noragdoll = undefined;
  }

  return var5;
}

function assassinate_getspawners() {
  return getspawnerarray("assassinate_enemySpawner");
}

function assassinate_getenemies() {
  return getEntArray("assassinate_enemy", "targetname");
}

function assassinate_getcrawlcovernodes() {
  return getnodearray("assassinate_crawlCoverNode", "targetname");
}

function trap_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var1);
  scripts\sp\maps\highway\highway_utility::animation_loop(var1, var0, "intro_farahSceneCIdle");
  var2 = level_spawnhadir();
  var2 scripts\engine\sp\utility::set_ignoreme(1);
  var2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var3 = assassinate_spawnVehicle();
  scripts\common\vehicle_paths::gopath(var3);
  var3 vehicle_setspeed(9999, 8000, 8000);
  var4 = tutorial_spawnallies();
  var5 = tutorial_getallynodes();

  for(var6 = 0; var6 < var4.size; var6++) {
    var4[var6] scripts\engine\sp\utility::teleport_ai(var5[var6]);
  }

  tutorial_setalliesnames();
  level_spawnredshirts();
}

function trap_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("trap");
  var0 = tutorial_getsignalally();
  var1 = level_getfarah();
  var2 = level_gethadir();
  thread trap_converationdialoguelogic(var1, var2);
  var3 = 2;
  wait var3;
  var4 = tutorial_getallies();
  var5 = [var0];

  for(var6 = var5.size; var6 < 2; var6++) {
    var7 = scripts\engine\utility::array_remove_array(var4, var5);
    var8 = scripts\engine\utility::random(var7);
    var5 = scripts\engine\utility::array_add(var5, var8);
  }

  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();
  var9 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_COVER_ALLIES");
  objective_setzoffset(var9, 72);

  foreach(var6, var11 in var5) {
    var11.script_startingposition = var6;
    var11.animname = "trap_IEDAlly" + var6;
    objective_setlocation(var9, var6, var11);
  }

  var12 = assassinate_getvehicle();
  var12 scripts\common\vehicle::vehicle_load_ai(var5, 0);
  var12 scripts\engine\utility::ent_flag_wait("loaded");
  var12 playSound("scn_highway_truck_trap_drive_01");
  var12 scripts\engine\utility::delaycall(1.4, &playsound, "scn_highway_truck_trap_drive_02");
  var12 scripts\engine\utility::ent_flag_set("trap_setupTruck");
  var12 vehicle_setspeed(15, 15, 15);

  while(!var12 vehicle_getspeed()) {
    waitframe();
  }

  var12 setwaitspeed(0);
  var12 waittill("reached_wait_speed");
  var12 notify("kill_treads_forever");
  var12 scripts\engine\utility::delaycall(6.5, &playsound, "scn_highway_truck_trap_hood_up");
  var12 scripts\engine\utility::delaycall(10.5, &playsound, "scn_highway_truck_trap_hood_down_01");
  var13 = scripts\engine\sp\utility::spawn_anim_model("trap_IED");
  var12.animname = "trap_vehicle";
  var12 thread scripts\common\anim::anim_single_solo(var13, "trap_placeIED");
  var12 thread scripts\common\anim::anim_single_solo(var12, "trap_placeIED");

  foreach(var11 in var5) {
    scripts\sp\maps\highway\highway_utility::ai_instantlyremovefromvehicle(var11);
  }

  var12 scripts\common\anim::anim_single(var5, "trap_placeIED");
  var16 = tutorial_getallynodes();
  scripts\sp\maps\highway\highway_utility::ai_takecoveratnodes(var4, var16);
  var17 = trap_getallyexplosivesreadylines();
  objective_delete(var9);
  var9 = level_addmissionnarrativeobjective();
  var0 scripts\sp\maps\highway\highway_utility::dialogue(var17[var0.script_index]);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_trap_set_10", 1);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_trap_set_20", 1);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_trap_set_30");
  var13 delete();

  if(true) {
    wait 8.5;
  }

  objective_delete(var9);
}

function trap_converationdialoguelogic(var0, var1) {
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_trap_prep_ali_10", 1.5);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_trap_prep_10", 2.5);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_trap_prep_11", 1);
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_scout_convo_10", 2.5);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_convo_20", 1);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_convo_30");
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_scout_convo_40", 1);
}

function trap_getallyexplosivesreadylines() {
  return ["dx_vom_fsa1_trap_prep_ali_20", "dx_vom_fsa3_trap_prep_imaad_20", "dx_vom_fsa2_trap_prep_ayah_20", "dx_vom_fsf2_trap_prep_raza_20", "dx_vom_fsf1_trap_prep_nida_20"];
}

function convoy_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var1);
  scripts\sp\maps\highway\highway_utility::animation_loop(var1, var0, "intro_farahSceneCIdle");
  var2 = level_spawnhadir();
  var2 scripts\engine\sp\utility::set_ignoreme(1);
  var2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var3 = assassinate_spawnVehicle();
  var4 = var3 scripts\sp\maps\highway\highway_utility::get_lastentinspline(var3.currentnode, &getvehiclenode);
  var3 vehicle_teleport(var4.origin, var4.angles);
  var5 = tutorial_spawnallies();
  var6 = tutorial_getallynodes();

  for(var7 = 0; var7 < var5.size; var7++) {
    var5[var7] scripts\engine\sp\utility::teleport_ai(var6[var7]);
  }

  tutorial_setalliesnames();
  level_spawnredshirts();
}

function convoy_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("convoy");
  var0 = tutorial_getallies();

  foreach(var2 in var0) {
    var2 scripts\engine\sp\utility::set_ignoreall(1);
    var2 scripts\engine\sp\utility::set_ignoreme(1);
  }

  var4 = convoy_spawnvehicles();
  var5 = convoy_spawnenemiesinvehicles(var4);
  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();
  var6 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SCOUT_ENEMY_CONVOY");
  objective_setzoffset(var6, 72);

  foreach(var8 in var4) {
    objective_setlocation(var6, var9, var8);
  }

  thread ambush_iedlogic();
  thread convoy_dialoguelogic();
  thread convoy_earlyambushstealthbrokenlogic();
  thread convoy_vehicleslogic(var4);
  thread convoy_sfxlogic(var4);
}

function convoy_earlyambushstealthbrokenlogic() {
  level waittill("ballistics_impact");
  scripts\sp\maps\highway\highway_utility::level_setflag(1, 1);
}

function convoy_dialoguelogic() {
  level endon("ballistics_impact");
  var0 = level_getfarah();
  var1 = tutorial_getsignalally();
  var2 = level_gethadir();
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_fsa1_convoy_reveal_10");
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_reveal_20");
  level.player endon("weapon_fired");
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_reveal_30");
  var2 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_convoy_reveal_40", 0.15);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_reveal_50", 0.25);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_" + var1.aliasname + "_convoy_watch_10", 1);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_watch_10", 0.5);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_watch_21", 4.5);
}

function convoy_spawnvehicles() {
  var0 = scripts\common\utility::getvehiclespawnerarray("convoy_vehicle", "targetname");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\common\utility::spawn_vehicle();
    var4.targetname = "convoy_vehicle";
    var4 scripts\common\vehicle::godon();
    var4.donotunloadondriverdeath = 1;
    var4.dontunloadonend = 1;
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function convoy_getvehicles() {
  var0 = vehicle_getarray();

  foreach(var2 in var0) {
    if(!scripts\engine\utility::is_equal(var2.targetname, "convoy_vehicle")) {
      var0 = scripts\engine\utility::array_remove(var0, var2);
    }
  }

  return var0;
}

function convoy_spawnenemiesinvehicles(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::get_linked_spawners();

    foreach(var6 in var4) {
      var6.script_forcespawn = 1;
    }

    var8 = var3 scripts\common\vehicle_code::spawn_group(var4);
    var1 = scripts\engine\sp\utility::array_merge(var1, var8);
  }

  foreach(var11 in var1) {
    var11 scripts\engine\sp\utility::set_ignoreall(1);
    var11 scripts\common\utility::demeanor_override("patrol");
    var11 scripts\engine\sp\utility::set_grenadeammo(3);
  }

  return var1;
}

function convoy_getspawners() {
  return getspawnerarray("convoy_enemySpawner");
}

function convoy_getenemies() {
  return getEntArray("convoy_enemy", "targetname");
}

function convoy_getvehiclescovernodes() {
  return getnodearray("vehicle_techoCoverNode", "targetname");
}

function convoy_vehicleslogic(var0) {
  foreach(var2 in var0) {
    thread convoy_vehiclepathlogic(var2);
  }

  thread convoy_vehiclesunloadlogic(var0);
}

function convoy_vehiclesunloadlogic(var0) {
  level endon("ballistics_impact");
  level endon("level_iedDetonated");
  var1 = [];

  foreach(var3 in var0) {
    var1 = scripts\engine\sp\utility::array_merge(var1, var3.riders);
  }

  foreach(var6 in var1) {
    if(!scripts\engine\utility::is_equal(var6.script_noteworthy, "convoy_enemyUnload")) {
      continue;
    }

    thread convoy_unloadenemylogic(var6, 1);
  }

  var8 = [];
  var9 = getEntArray("convoy_animatedEnemy", "script_noteworthy");
  var9 = scripts\sp\maps\highway\highway_utility::array_sortbyscriptindex(var9);

  foreach(var11 in var9) {
    if(scripts\engine\utility::array_contains(var8, var11.ridingvehicle)) {
      continue;
    }

    var8 = scripts\engine\utility::array_add(var8, var11.ridingvehicle);
  }

  while(var8.size) {
    var13 = scripts\engine\utility::array_any_wait_return(var8, "reached_wait_speed");

    foreach(var11 in var9) {
      if(!scripts\engine\utility::is_equal(var11.ridingvehicle, var13)) {
        continue;
      }

      thread convoy_unloadanimatedenemylogic(var11);
    }

    var8 = scripts\engine\utility::array_remove(var8, var13);
  }

  var16 = scripts\engine\utility::array_remove_array(var0, var8);

  foreach(var18 in var16) {
    if(var18 vehicle_getspeed()) {
      continue;
    }

    var16 = scripts\engine\utility::array_remove(var16, var18);
  }

  if(var16.size) {
    scripts\engine\utility::array_wait(var0, "reached_wait_speed");
  }

  scripts\engine\utility::flag_set("convoy_vehiclesStopped");
}

function convoy_unloadanimatedenemylogic(var0) {
  level endon("ballistics_impact");
  level endon("level_iedDetonated");
  var0.ridingvehicle thread scripts\common\vehicle_aianim::guy_unload(var0, var0.vehicle_position);
  var0 waittill("jumpedout");
  var1 = assassinate_getvehicle();
  var0.animname = "convoy_enemy" + var0.script_index;

  if(var0.script_index == 0) {
    scripts\sp\maps\highway\highway_utility::animation_reachtosingle(var1, var0, "convoy_enter");
    ambush_triggeried();
    return;
  }

  if(var0.script_index == 1) {
    var1 scripts\sp\anim::anim_reach_solo(var0, "convoy_enter");
    level notify("convoy_enemiesAtTruck");
    scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var1, var0, "convoy_enter", "convoy_idle");
    scripts\engine\utility::flag_wait("convoy_enemyCommanderReached");
    scripts\sp\maps\highway\highway_utility::animation_stoploop(var0);
    scripts\sp\maps\highway\highway_utility::animation_singleintolastframe(var1, var0, "convoy_exit");
    return;
  }

  var1 scripts\sp\anim::anim_reach_solo(var0, "convoy_enter");
  scripts\engine\utility::flag_set("convoy_enemyCommanderReached");
  scripts\sp\maps\highway\highway_utility::animation_singleintolastframe(var1, var0, "convoy_enter");
}

function convoy_unloadenemylogic(var0, var1) {
  level endon("ballistics_impact");
  level endon("level_iedDetonated");

  if(var1) {
    var0.ridingvehicle waittill("reached_wait_speed");
  }

  var0.ridingvehicle thread scripts\common\vehicle_aianim::guy_unload(var0, var0.vehicle_position);
  var0 waittill("jumpedout");
  var0 setgoalpos(var0.origin);
}

function convoy_vehiclepathlogic(var0) {
  scripts\common\vehicle_paths::gopath(var0);
  thread convoy_vehiclealertedspeeduplogic(var0);
  thread convoy_vehicledriverdeathlogic(var0);

  while(!var0 vehicle_getspeed()) {
    waitframe();
  }

  var0 setwaitspeed(0);
}

function convoy_vehiclealertedspeeduplogic(var0) {
  var0 endon("reached_wait_speed");
  level waittill("ballistics_impact");
  waitframe();

  if(!var0 vehicle_getspeed()) {
    return;
  }

  if(!isDefined(var0.driver)) {
    return;
  }

  if(!isalive(var0.driver)) {
    return;
  }

  var0 vehicle_setspeed(30, 15, 15);
}

function convoy_vehicledriverdeathlogic(var0) {
  var0 endon("reached_wait_speed");
  var0 scripts\engine\utility::ent_flag_wait("loaded");
  var0.driver waittill("death");

  if(!var0 vehicle_getspeed()) {
    return;
  }

  var0 vehicle_setspeed(0, 15, 15);
}

function convoy_sfxlogic(var0) {
  setmusicstate("mx_highway_multicar");
  var0[0] playSound("scn_highway_convoy_incoming_dist_01");
  level scripts\engine\utility::waittill_any("ballistics_impact", "level_iedDetonated");
  setmusicstate("");
}

function ambush_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var1);
  scripts\sp\maps\highway\highway_utility::animation_loop(var1, var0, "intro_farahSceneCIdle");
  var2 = level_spawnhadir();
  var2 scripts\engine\sp\utility::set_ignoreme(1);
  var2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var3 = convoy_spawnvehicles();
  convoy_spawnenemiesinvehicles(var3);
  var4 = scripts\engine\utility::array_add(var3, assassinate_spawnVehicle());

  foreach(var6 in var4) {
    var7 = var6 scripts\sp\maps\highway\highway_utility::get_lastentinspline(var6.currentnode, &getvehiclenode);
    var6 vehicle_teleport(var7.origin, var7.angles);
    var6 attachpath(var7);
  }

  var9 = [];

  foreach(var6 in var3) {
    var9 = scripts\engine\sp\utility::array_merge(var9, var6.riders);
  }

  foreach(var13 in var9) {
    if(!scripts\engine\utility::is_equal(var13.script_noteworthy, "convoy_enemyUnload")) {
      continue;
    }

    thread convoy_unloadenemylogic(var13, 0);
  }

  var15 = [];
  var16 = getEntArray("convoy_animatedEnemy", "script_noteworthy");
  var16 = scripts\sp\maps\highway\highway_utility::array_sortbyscriptindex(var16);

  foreach(var18 in var16) {
    if(scripts\engine\utility::array_contains(var15, var18.ridingvehicle)) {
      continue;
    }

    var15 = scripts\engine\utility::array_add(var15, var18.ridingvehicle);
  }

  while(var15.size) {
    var20 = var15[0];

    foreach(var18 in var16) {
      if(!scripts\engine\utility::is_equal(var18.ridingvehicle, var20)) {
        continue;
      }

      thread convoy_unloadanimatedenemylogic(var18);
    }

    var15 = scripts\engine\utility::array_remove(var15, var20);
  }

  level_spawnredshirts();
  var23 = tutorial_spawnallies();
  var24 = tutorial_getallynodes();

  for(var25 = 0; var25 < var23.size; var25++) {
    var23[var25] scripts\engine\sp\utility::teleport_ai(var24[var25]);
  }

  tutorial_setalliesnames();
  thread ambush_iedlogic();
  scripts\engine\utility::flag_set("convoy_vehiclesStopped");
}

function ambush_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("ambush");
  thread ambush_dialoguelogic();
  thread ambush_allieslogic();
  thread ambush_enemieslogic();
  scripts\sp\maps\highway\highway_utility::waittill_remainingenemycount(7);
  level notify("fallback_enemiesFallback");

  if(true) {
    wait 2;
    return;
  }
}

function ambush_iedlogic() {
  level scripts\engine\utility::waittill_any("convoy_enemiesAtTruck", "ballistics_impact");
  var0 = ambush_getied();
  var0 thread scripts\sp\equipment\ied::ieddetonationlogic(level.player, 0.8, 75);
  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();
  var1 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_AMBUSH_ENEMY_CONVOY", var0.origin);
  var2 = var0.origin;
  var0 waittill("detonated");
  thread scripts\engine\utility::play_sound_in_space("scn_highway_rigged_truck_expl", var2);
  var3 = assassinate_getvehicle();
  var3 kill();
}

function ambush_getied() {
  return getEnt("ambush_iedOrigin", "targetname");
}

function ambush_triggeried() {
  var0 = ambush_getied();
  var0.interact delete();
  var0 thread scripts\sp\equipment\ied::ieddetonate(var0.origin, level.player);
}

function ambush_dialoguelogic() {
  thread ambush_instructionsdialoguelogic();
  var0 = level scripts\engine\utility::waittill_any_return("ballistics_impact", "level_iedDetonated");
  var1 = convoy_getvehicles();
  var2 = 0;

  foreach(var4 in var1) {
    var2 += var4 vehicle_getspeed();
  }

  var6 = level_getfarah();

  if(var0 == "level_iedDetonated") {
    var6 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_alert_10", 1.5);
    var6 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_attack_10", 0.5);
  } else {
    if(var2) {
      var6 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_alert_10", 1);
      var6 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_scout_alert_20", 1.5);
    }

    var6 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_alert_10", 1.5);
  }

  level endon("reinforcements_vehiclesSpawned");
  GscBinSkip4(0x35);
}

function ambush_instructionsdialoguelogic() {
  level endon("ballistics_impact");
  level endon("level_iedDetonated");
  var0 = level_getfarah();
  var1 = level_gethadir();
  scripts\engine\utility::flag_wait("convoy_vehiclesStopped");
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_watch_30", 5, level, "convoy_enemiesAtTruck");
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_watch_31", 8, level, "convoy_enemiesAtTruck");
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_convoy_watch_32", 9, level, "convoy_enemiesAtTruck");
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_watch_40", 11);
  level waittill("convoy_enemiesAtTruck");
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_watch_70", 4);
  var2 = ambush_getied();
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_watch_50", 0.75, var2, "detonated");
  var3 = 0.5;
  var4 = lookupsoundlength("dx_vom_far_convoy_watch_50") * 0.001;
  var5 = var3 + var4 + 5;
  var6 = ["dx_vom_far_convoy_watch_60", "dx_vom_far_convoy_watch_80"];
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var6, 6, var2, "detonated", var5);
}

function ambush_locationcalloutlogic() {
  var0 = level_getfarah();
  var1 = [];

  for(;;) {
    var2 = ambush_getlocationvolumes();
    var3 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");

    foreach(var5 in var2) {
      var6 = 0;
      var7 = ambush_getvolumelines(var5);
      var7 = scripts\engine\utility::array_remove_array(var7, var1);

      if(var7.size) {
        foreach(var9 in var3) {
          if(length(var9.velocity)) {
            continue;
          }

          if(var9 istouching(var5)) {
            var10 = scripts\engine\utility::random(var7);
            var0 scripts\sp\maps\highway\highway_utility::dialogue(var10);
            var1 = scripts\engine\utility::array_add(var1, var10);
            var6 = 1;
            break;
          }
        }
      }

      if(var6) {
        wait 8;
        break;
      }
    }

    waitframe();
  }
}

function ambush_enemyballistickillcalloutlogic() {
  var0 = level_getfarah();
  var1 = ["dx_vom_far_convoy_backup_110", "dx_vom_far_sniper_kill_10", "dx_vom_far_tutorial_adjust_220"];
  var2 = [var0, var0, var0];
  var3 = var1;
  var4 = var2;
  var5 = 8;

  for(;;) {
    var6 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
    var7 = scripts\sp\maps\highway\highway_utility::array_waittill_ballisticdeath(var6);

    if(!var3.size) {
      var3 = var1;
      var4 = var2;
    }

    var8 = randomint(var3.size);
    var9 = var3[var8];
    var10 = var4[var8];
    var10 scripts\sp\maps\highway\highway_utility::dialogue(var9, 0.5);
    var3 = scripts\engine\utility::array_remove_index(var3, var8);
    var4 = scripts\engine\utility::array_remove_index(var4, var8);
    wait var5;
  }
}

function ambush_enemybarrelkillcalloutlogic() {
  var0 = level_getfarah();
  var1 = ["dx_vom_far_convoy_multikill_10", "dx_vom_far_convoy_multikill_30", "dx_vom_far_convoy_multikill_20"];
  var2 = [var0, var0, var0];

  for(var3 = 0;; var3 = scripts\engine\math::wrap(0, var1.size - 1, var3 + 1)) {
    level waittill("red_barrel_explosion", var4, var5);

    if(var5 < 2) {
      continue;
    }

    var6 = var1[var3];
    var7 = var2[var3];
    var7 thread scripts\sp\maps\highway\highway_utility::dialogue(var1[var3], 2);
  }
}

function ambush_getvolumelines(var0) {
  return strtok(var0.script_parameters, " ");
}

function ambush_getlocationvolumes() {
  return getEntArray("ambush_locationVolume", "targetname");
}

function ambush_allieslogic() {
  level scripts\engine\utility::waittill_any("ballistics_impact", "level_iedDetonated");
  var0 = tutorial_getallies();

  foreach(var2 in var0) {
    var2 scripts\engine\sp\utility::set_ignoreall(0);
    var2 scripts\engine\sp\utility::set_ignoreme(0);
  }

  var4 = ambush_getallynodes();
  scripts\sp\maps\highway\highway_utility::ai_takecoveratnodes(var0, var4);
}

function ambush_getallynodes() {
  return getnodearray("ambush_allyNode", "targetname");
}

function ambush_enemieslogic() {
  level scripts\engine\utility::waittill_any("ballistics_impact", "level_iedDetonated");
  scripts\engine\sp\utility::autosave_by_name_silent("ambush_alerted");
  var0 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
  var1 = ambush_getenemycovernodes();

  foreach(var3 in var0) {
    var3 scripts\engine\sp\utility::set_goalRadius(128);
    var4 = scripts\engine\utility::random(var1);
    var5 = isDefined(var3.ridingvehicle);
    var6 = scripts\sp\maps\highway\highway_utility::math_getchance(85) && !isDefined(var3.ridingvehicle);

    if(var6 && !var5) {
      var7 = "prone";
    } else {
      var7 = undefined;
    }

    thread ambush_enemylogic(var3, var5, var4, var7);
    var1 = scripts\engine\utility::array_remove(var1, var4);
  }

  scripts\sp\maps\highway\highway_utility::level_setflag(1, 1);
  wait 5;
  var9 = ambush_spawnenemies();

  foreach(var3 in var9) {
    thread ambush_enemylogic(var3, 0);
  }
}

function ambush_spawnenemies() {
  var0 = getspawnerarray("ambush_enemySpawner");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);

    if(!scripts\common\ai::spawn_failed(var4)) {
      var1 = scripts\engine\utility::array_add(var1, var4);
    }
  }

  return var1;
}

function ambush_getenemycovernodes() {
  return getnodearray("ambush_enemyCoverNode", "targetname");
}

function ambush_getenemiesgoalvolume() {
  return getEnt("ambush_enemyVolume", "targetname");
}

function ambush_enemylogic(var0, var1, var2, var3) {
  level endon("fallback_enemiesFallback");
  var0 endon("death");
  var0 scripts\common\utility::clear_demeanor_override();
  var0 scripts\engine\sp\utility::set_ignoreall(0);
  var0.vehiclerunexit = 1;

  if(var1) {
    if(var0.ridingvehicle vehicle_getspeed()) {
      var0.ridingvehicle waittill("reached_wait_speed");
    } else {
      waitframe();
    }

    var0.ridingvehicle thread scripts\common\vehicle_aianim::guy_unload(var0, var0.vehicle_position);
  }

  if(isDefined(var3)) {
    var0 allowedstances(var3);
    var0 scripts\sp\maps\highway\highway_utility::ai_waittillinstance(var3);
  }

  if(isDefined(var2)) {
    var0 setgoalnode(var2);
    var0 waittill("goal");
  }

  var4 = ambush_getenemiesgoalvolume();
  var0 setgoalvolumeauto(var4);
}

function fallback_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var1);
  scripts\sp\maps\highway\highway_utility::animation_loop(var1, var0, "intro_farahSceneCIdle");
  var2 = level_spawnhadir();
  var2 scripts\engine\sp\utility::set_ignoreme(1);
  var2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var3 = convoy_spawnvehicles();
  var3 = scripts\engine\utility::array_add(var3, assassinate_spawnVehicle());

  foreach(var5 in var3) {
    var6 = var5 scripts\sp\maps\highway\highway_utility::get_lastentinspline(var5.currentnode, &getvehiclenode);
    var5 vehicle_teleport(var6.origin, var6.angles);
    var5 attachpath(var6);
  }

  var8 = convoy_getspawners();
  var9 = fallback_getenemygoalvolume();
  var10 = ambush_getenemycovernodes();

  for(var11 = 0; var11 < 7; var11++) {
    var12 = var8[var11] scripts\engine\sp\utility::spawn_ai(1);
    var6 = scripts\engine\utility::random(var10);
    var10 = scripts\engine\utility::array_remove(var10, var6);
    var12 forceteleport(var6.origin, var6.angles);
    var12 setgoalvolumeauto(var9);
  }

  var13 = tutorial_spawnallies();
  var14 = tutorial_getallynodes();

  for(var15 = 0; var15 < var13.size; var15++) {
    var13[var15] scripts\engine\sp\utility::teleport_ai(var14[var15]);
  }

  tutorial_setalliesnames();
  scripts\engine\utility::array_thread(var13, &scripts\engine\sp\utility::set_ignoreall, 0);
  level_spawnredshirts();
}

function fallback_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("fallback");
  fallback_enemieslogic();
  scripts\sp\maps\highway\highway_utility::waittill_remainingenemycount(5);
}

function fallback_enemieslogic() {
  fallback_spawnenemies();
  var0 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
  var1 = fallback_getenemygoalvolume();

  foreach(var3 in var0) {
    wait randomfloatrange(0.25, 2);

    if(!scripts\sp\maps\highway\highway_utility::ai_isalive(var3)) {
      continue;
    }

    var3 scripts\sp\maps\highway\highway_utility::ai_resetstances();
    var3 setgoalvolumeauto(var1);
  }
}

function fallback_spawnenemies() {
  var0 = fallback_getspawners();

  foreach(var2 in var0) {
    var3 = var2 scripts\engine\sp\utility::spawn_ai();
  }
}

function fallback_getenemygoalvolume() {
  return getEnt("fallback_enemyVolume", "targetname");
}

function fallback_getspawners() {
  return getspawnerarray("fallback_enemySpawners");
}

function fallback_getenemies() {
  return getEntArray("fallback_enemy", "targetname");
}

function reinforcements_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var1 = level_gettownanimationstruct();
  intro_setupanimatedfarahscope(var1);
  scripts\sp\maps\highway\highway_utility::animation_loop(var1, var0, "intro_farahSceneCIdle");
  var2 = level_spawnhadir();
  var2 scripts\engine\sp\utility::set_ignoreme(1);
  var2 scripts\engine\sp\utility::set_ignoreall(1);
  player_givefullloadout();
  var3 = convoy_getspawners();
  var4 = fallback_getenemygoalvolume();
  var5 = getnodearray("fallback_enemyCoverNode", "targetname");

  for(var6 = 0; var6 < 5; var6++) {
    var7 = var3[var6] scripts\engine\sp\utility::spawn_ai();
    var8 = scripts\engine\utility::random(var5);
    var5 = scripts\engine\utility::array_remove(var5, var8);
    var7 forceteleport(var8.origin, var8.angles);
    var7 setgoalvolumeauto(var4);
  }

  var9 = tutorial_spawnallies();
  scripts\engine\utility::array_thread(var9, &scripts\engine\sp\utility::set_ignoreall, 0);
  var10 = convoy_spawnvehicles();
  var10 = scripts\engine\utility::array_add(var10, assassinate_spawnVehicle());

  foreach(var12 in var10) {
    var8 = var12 scripts\sp\maps\highway\highway_utility::get_lastentinspline(var12.currentnode, &getvehiclenode);
    var12 vehicle_teleport(var8.origin, var8.angles);
    var12 attachpath(var8);
  }

  level_spawnredshirts();
}

function reinforcements_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("reinforcements");
  var0 = convoy_getvehicles();

  foreach(var2 in var0) {
    if(var2.model != "veh8_mil_lnd_pindia_cream" && var2.model != "veh8_mil_lnd_pindia_red") {
      continue;
    }

    earthquake(0.15, 0.7, level.player.origin, 9999);
    playrumbleonposition("damage_heavy", level.player.origin);
    playFX(level._effect["vfx_mortar_impact"], var2.origin);
    var2.vehicle_skipdeathmodel = 1;
    var2 kill();
  }

  var4 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");

  foreach(var6 in var4) {
    var6 cleargoalvolume();
    var6 setgoalpos(var6.origin);
  }

  var8 = reinforcements_spawnvehicles();
  thread reinforcements_allieslogic(var8);
  thread reinforcements_vehicleslogic(var8, 0);
  thread reinforcements_vehiclessfxlogic(var8);
  thread reinforcements_vehiclesstoppedautosave(var8);
  thread reinforcements_dialoguelogic(var8);
}

function reinforcements_dialoguelogic(var0) {
  thread reinforcements_vehiclesdisableddialoguelogic();
  thread reinforcements_vehiclesunloadedlogic(var0);
  var1 = level_getfarah();
  var2 = level_gethadir();
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_backup_21", 3);
  scripts\engine\utility::array_wait(var0, "stopped_path");
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_backup_23", 3);
  var3 = tutorial_getsignalally();
  var2 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_convoy_backup_24");
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_backup_25");
  var2 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_convoy_backup_ali_10", 2);
  level endon("vehicle_techoDisable");
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_backup_90", 2);
  var2 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_convoy_backup_70", 2);
}

function reinforcements_vehiclesdisableddialoguelogic() {
  var0 = level_getfarah();
  var1 = ["dx_vom_far_convoy_backup_100", "dx_vom_far_convoy_backup_110", "dx_vom_far_convoy_backup_120"];

  for(var2 = 0;; var2 = scripts\engine\math::wrap(0, var1.size - 1, var2 + 1)) {
    level waittill("vehicle_techoDisable");
    var0 thread scripts\sp\maps\highway\highway_utility::dialogue(var1[var2], 1);
  }
}

function reinforcements_vehiclesunloadedlogic(var0) {
  scripts\engine\utility::array_wait(var0, "unloading");
  var1 = level_gethadir();
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_convoy_backup_140", 3);
}

function reinforcements_allieslogic(var0) {
  level waittill("reinforcements_loaded");
  var1 = tutorial_getallies();
  var2 = reinforcements_getallypaths();

  foreach(var4 in var1) {
    var4 scripts\engine\sp\utility::set_goalRadius(48);
    var4 scripts\engine\sp\utility::set_ignoreall(1);
    var4 scripts\engine\sp\utility::set_ignoreme(1);
    var4.disablearrivals = 1;
    var4.disableexits = 1;
    var4.noragdoll = 1;
    var5 = sortbydistance(var2, var4.origin)[0];
    var4 thread scripts\sp\spawner::go_to_node(var5);

    if(istrue(var4.magic_bullet_shield)) {
      var4 scripts\common\ai::stop_magic_bullet_shield();
    }
  }

  var7 = level_getfarah();
  var7 scripts\common\utility::clear_demeanor_override();
  var7 scripts\engine\sp\utility::set_ignoreall(0);
  var7 scripts\engine\sp\utility::set_ignoreme(0);
  var8 = level_getfarahtownnode();
  var7 scripts\engine\sp\utility::set_goalRadius(32);
  var7 setgoalnode(var8);
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var7);
  var9 = intro_getanimatedfarahscope();
  var9 delete();
  var10 = level_gethadir();
  var10 scripts\common\utility::clear_demeanor_override();
  var10 scripts\engine\sp\utility::set_ignoreall(0);
  var10 scripts\engine\sp\utility::set_ignoreme(0);
  scripts\sp\maps\highway\highway_utility::level_setflag(64, 1);
  scripts\engine\utility::array_any_wait(var1, "death");
  level notify("reinforcements_allyDeath");
}

function reinforcements_spawnvehicles() {
  var0 = vehicle_spawntechos("reinforcements_vehicleSpawner", "reinforcements_vehicle");

  foreach(var2 in var0) {
    var2 scripts\engine\utility::ent_flag_init("reinforcements_pickupEnemiesLoaded");
  }

  level notify("reinforcements_vehiclesSpawned");
  return var0;
}

function reinforcements_getvehicles() {
  var0 = vehicle_getarray();

  foreach(var2 in var0) {
    if(!scripts\engine\utility::is_equal(var2.targetname, "reinforcements_vehicle")) {
      var0 = scripts\engine\utility::array_remove(var0, var2);
    }
  }

  return var0;
}

function reinforcements_vehicleslogic(var0, var1) {
  scripts\engine\utility::array_wait(var0, "spawnedRiders");
  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();
  var2 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_DISABLE_VEHICLES");
  objective_setzoffset(var2, 100);
  var3 = [];

  foreach(var5 in var0) {
    objective_setlocation(var2, var6, var5);
    var5 thread scripts\sp\maps\highway\highway_utility::call_on_notify_no_self("vehicle_disabled", &objective_unsetlocation, var2, var6);
    var3 = scripts\engine\sp\utility::array_merge(var3, var5.riders);
  }

  foreach(var8 in var3) {
    var8.targetname = "reinforcements_enemy";

    if(scripts\engine\utility::is_equal(var8.vehicle_position, 0) && !var1) {
      level.ballistics.ignoreentities = scripts\engine\utility::array_add(level.ballistics.ignoreentities, var8);
    }
  }

  var10 = [];

  foreach(var5 in var0) {
    if(var1) {
      var5 scripts\engine\utility::ent_flag_set("reinforcements_pickupEnemiesLoaded");
      var12 = var5 scripts\sp\maps\highway\highway_utility::get_lastentinspline(var5.currentnode, &getvehiclenode);
      var5 attachpath(var12);
      var5 scripts\common\vehicle::vehicle_unload();
      continue;
    }

    if(scripts\engine\utility::is_equal(var5.script_noteworthy, "reinforcements_pickupEnemies")) {
      var10 = scripts\engine\utility::array_add(var10, var5);
    }

    var5 scripts\common\vehicle_paths::gopath();
  }

  if(!var1) {
    scripts\engine\utility::array_wait(var10, "stopped_path");
    var14 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
    var15 = scripts\engine\utility::array_remove_array(var14, var3);
    scripts\engine\utility::array_thread(var14, &scripts\common\utility::demeanor_override, "sprint");
    var16 = floor(var15.size / var10.size);

    for(var17 = 0; var17 < var10.size; var17++) {
      var15 = sortbydistance(var15, var10[var17].origin);
      var18 = var17 == var10.size - 1;

      if(var18) {
        var19 = var15;
      } else {
        var19 = [];

        for(var20 = 0; var20 < var16; var20++) {
          var19 = scripts\engine\utility::array_add(var19, var15[var20]);
          var15 = scripts\engine\utility::array_remove(var15, var15[var20]);
        }
      }

      var10[var17] thread scripts\common\vehicle::vehicle_load_ai(var19, 0);
    }

    thread reinforcements_cleanupenemieslogic();
    scripts\engine\utility::array_ent_flag_wait(var10, "loaded");
    scripts\engine\sp\utility::autosave_by_name_silent("reinforcements_loaded");
  }

  level notify("reinforcements_loaded");
  var14 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");

  foreach(var8 in var14) {
    thread level_enemyassaulttownlogic(var8, 1);
  }

  if(!var1) {
    foreach(var5 in var0) {
      var5 scripts\engine\utility::ent_flag_set("reinforcements_pickupEnemiesLoaded");
      thread vehicle_techodisablelogic(var5);

      foreach(var8 in var5.riders) {
        if(scripts\engine\utility::array_contains(level.ballistics.ignoreentities, var8)) {
          level.ballistics.ignoreentities = scripts\engine\utility::array_remove(level.ballistics.ignoreentities, var8);
        }

        if(istrue(var8.drivingvehicle)) {
          thread reinforcements_driverdeathlogic(var8, var5);
        }
      }
    }

    vehicle_waittillarraymoving(var0);
    level notify("sfx_reinforcements_moving");

    foreach(var5 in var0) {
      var5 setwaitspeed(0);
    }

    return;
  }
}

function reinforcements_vehiclessfxlogic(var0) {
  var0[1] playSound("scn_highway_reinforcements_ridge_01");
  setmusicstate("mx_highway_reinforcements");
  level waittill("sfx_reinforcements_moving");
  wait 0.1;
  var0[0] playSound("scn_highway_reinforcements_incoming_01");
  var0[2] playSound("scn_highway_reinforcements_incoming_02");

  foreach(var2 in var0) {
    thread reinforcements_vehicledoorsfxlogic(var2);
  }

  scripts\engine\utility::array_wait(var0, "reached_wait_speed");
}

function reinforcements_vehicledoorsfxlogic(var0) {
  var0 waittill("reached_wait_speed");
  var0 playSound("scn_highway_truck_doors_open");
}

function reinforcements_driverdeathlogic(var0, var1) {
  var1 endon("vehicle_disabled");
  var1 endon("reached_end_node");
  var0 endon("jumpedout");
  var0 waittill("death");
  var2 = var1 gettagorigin("tag_driver");
  var1 notify("vehicle_disabled", var2);

  if(var1 vehicle_getspeed()) {
    var1 vehicle_setspeed(0, 30, 30);
    var1 setwaitspeed(0);
    var1 waittill("reached_wait_speed");
    var1 thread scripts\common\vehicle::vehicle_unload();
  }

  var3 = level_getfarah();
  var3 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_convoy_backup_64", 1);
}

function reinforcements_vehiclesstoppedautosave(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(scripts\engine\utility::is_equal(var3.script_noteworthy, "reinforcements_pickupEnemies")) {
      var1 = scripts\engine\utility::array_add(var1, var3);
    }
  }

  level waittill("reinforcements_loaded");
  vehicle_waittillarraymoving(var0);
  scripts\engine\utility::array_wait(var0, "reached_wait_speed");
  scripts\engine\sp\utility::autosave_by_name_silent("reinforcements_vehiclesStopped");
}

function reinforcements_cleanupenemieslogic(var0) {
  level endon("reinforcements_loaded");
  wait 5;
  var1 = 0.2;
  var2 = 0.4;
  var3 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");

  foreach(var5 in var3) {
    if(isDefined(var5.ridingvehicle)) {
      continue;
    }

    var6 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("allies");
    var7 = sortbydistance(var6, var5.origin)[0];
    magicbullet(var7.weapon, var7 gettagorigin("tag_flash"), var5 getEye());
    playFX(level.g_effect["vfx_gib_explode"], var5 getEye());
    var5 kill();
    var8 = randomfloatrange(var1, var2);
    wait var8;
  }
}

function reinforcements_getenemies() {
  return getEntArray("reinforcements_enemy", "targetname");
}

function reinforcements_getallypaths() {
  return scripts\engine\utility::getStructArray("reinforcements_allyPath", "targetname");
}

function assault_start() {
  var0 = level_spawnfarah();
  var1 = level_spawnhadir();
  player_givefullloadout();
  var2 = reinforcements_spawnvehicles();
  thread reinforcements_vehicleslogic(var2, 1);
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility::level_setflag(64, 1);
}

function assault_main() {
  thread assault_enemieslogic();
  scripts\sp\maps\highway\highway_utility::waittill_remainingenemycount(6);
}

function assault_enemieslogic() {
  var0 = reinforcements_getvehicles();
  var1 = 0;

  foreach(var3 in var0) {
    if(var3 scripts\engine\utility::ent_flag("reinforcements_pickupEnemiesLoaded")) {
      var1++;
    }
  }

  var5 = var1 == var0.size;

  if(!var5) {
    scripts\engine\utility::array_ent_flag_wait(var0, "reinforcements_pickupEnemiesLoaded");
    vehicle_waittillarraymoving(var0);
  }

  scripts\engine\utility::array_wait(var0, "unloaded");
  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();
  scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SURVIVE");
  var6 = assault_getextraenemyspawners();
  var7 = scripts\engine\sp\utility::array_spawn(var6, 0, 1);
  thread assault_enemymagicmolotovgrenadelogic();

  foreach(var9 in var7) {
    thread level_enemyassaulttownlogic(var9, 0);
  }
}

function assault_enemymagicmolotovgrenadelogic() {
  level.player endon("death");
  level endon("mortars_fire");
  level.player endon("damage_fire");
  var0 = 25;
  var1 = 2;
  wait var0 - var1;
  scripts\sp\maps\highway\highway_utility::player_waittillmaxhealth();
  var2 = scripts\engine\utility::random(scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis"));

  if(!isDefined(var2)) {
    return;
  }

  var3 = level_gethadir();
  var3 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_cbc_had_inform_incoming_molotov");
  var3 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_cbc_had_order_move_combat", 0.5);
  wait var1;
  var4 = anglestoup(level.player.angles);
  var5 = anglesToForward(level.player.angles);
  var6 = level.player scripts\engine\utility::spawn_script_origin();
  var6 thread scripts\sp\equipment\molotov::molotovexplode(level.player.origin, var4, var5, level.player, var2);
}

function assault_getextraenemyspawners() {
  return getspawnerarray("assault_enemySpawner");
}

function mortars_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility::level_setflag(64, 1);
}

function mortars_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("mortars");
  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();
  var0 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_ELIMINATE_MORTARS");
  thread mortars_farahdialoguehints();
  thread mortars_dialoguefeedbacklogic();
  thread mortars_mortarspawninglogic();
  setmusicstate("");
  level waittill("mortars_allCrewsDead");
  objective_delete(var0);
}

function mortars_mortarspawninglogic() {
  var0 = mortars_getmodels();
  var1 = 1;
  var2 = 3;

  for(var3 = 0; var3 < 3; var3++) {
    var4 = var0;

    foreach(var6 in var4) {
      if(!scripts\engine\utility::is_equal(var6.script_index, var3)) {
        var4 = scripts\engine\utility::array_remove(var4, var6);
      }
    }

    if(var4.size) {
      var8 = scripts\engine\utility::random(var4);
    } else {
      var8 = scripts\engine\utility::random(var0);
    }

    thread mortars_modellogic(var1, var8, var2);
    var0 = scripts\engine\utility::array_remove(var0, var8);

    if(var1) {
      var1 = 0;
    }

    level waittill("mortars_crewDisabled");
    thread scripts\engine\sp\utility::autosave_now();
  }

  level notify("mortars_allCrewsDead");
}

function mortars_farahdialoguehints() {
  level endon("mortars_crewDisabled");
  level waittill("mortars_impact");
  var0 = level_getfarah();
  var1 = level_gethadir();
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_mortar_reveal_10", 2);
  var2 = player_getballisticsweaponobject();

  if(!level.player hasweapon(var2)) {
    var3 = ["dx_vom_far_mortar_reveal_60", "dx_vom_far_mortar_reveal_70", "dx_vom_far_mortar_reveal_80"];
    var4 = 0;
    var5 = 2;
    var6 = 4;
    var7 = scripts\sp\maps\highway\highway_utility::level_objectivegetindex();
    var8 = player_getdroppedsniper();
    scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_GRAB_SNIPER", var8.origin, &"HIGHWAY/LABEL_GRAB_SNIPER");
    objective_onentity(var7, var8);
    objective_setzoffset(var7, 10);
    wait var5;

    while(!level.player hasweapon(var2)) {
      var0 scripts\sp\maps\highway\highway_utility::dialogue(var3[var4]);
      var4 = scripts\engine\math::wrap(0, var3.size - 1, var4 + 1);
      wait var6;
    }

    objective_delete(var7);
  }

  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_mortar_reveal_41", 0.5);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_mortar_reveal_90", 2);
  mortars_dialoguewarningslogic();
}

function mortars_dialoguewarningslogic() {
  level endon("mortars_allCrewsDead");
  var0 = level_getfarah();
  var1 = level_gethadir();

  for(;;) {
    var2 = scripts\engine\utility::waittill_any_ents_return(level, "mortars_zeroedInOnPlayer", level, "mortars_goingToKillPlayer");

    if(var2 == "mortars_zeroedInOnPlayer") {
      var3 = ["dx_vom_far_mortar_reveal_100", "dx_vom_far_mortar_reveal_110", "dx_vom_far_mortar_reveal_120"];
      var4 = [var0, var0, var1];
    } else {
      var3 = ["dx_vom_had_mortar_reveal_130", "dx_vom_had_mortar_reveal_140"];
      var4 = [var1, var0];
    }

    var5 = randomint(var3.size);
    var6 = var3[var5];
    var7 = var4[var5];
    var7 scripts\sp\maps\highway\highway_utility::dialogue(var6);
  }
}

function mortars_dialoguefeedbacklogic() {
  var0 = level_getfarah();
  var1 = level_gethadir();
  var2 = ["dx_vom_alx_mortar_team1_90", "dx_vom_alx_mortar_team2_110", "dx_vom_alx_mortar_team3_110"];
  var3 = [level.player, level.player, level.player];
  var4 = ["dx_vom_alx_mortar_team1_50", "dx_vom_alx_mortar_team2_70", "dx_vom_alx_mortar_team3_70"];
  var5 = ["dx_vom_had_mortar_team2_20", "dx_vom_had_mortar_team3_10"];
  var6 = [var1, var1];
  var7 = 0;
  var8 = 0;

  for(var9 = 0; var9 < 3; var9++) {
    var10 = var9 == 2;

    if(!var7) {
      if(var10) {
        level.player thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_mortar_team3_30", 10, level, "mortars_crewSpotted");
        var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_tutorial_adjust_342", 12, level, "mortars_crewSpotted");
        var11 = ["dx_vom_far_mortar_team3_40", "dx_vom_far_mortar_team3_50", "dx_vom_far_mortar_team3_60"];
        var0 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var11, 8, level, "mortars_crewSpotted", 13);
      }

      level waittill("mortars_crewSpotted");
    }

    var7 = 0;
    level.player thread scripts\sp\maps\highway\highway_utility::dialogue(var4[var8], 1);
    var11 = ["dx_vom_far_mortar_team2_80", "dx_vom_far_mortar_team2_90", "dx_vom_far_mortar_team2_100"];
    var0 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var11, 8, level, "mortars_crewDisabled", 6);
    level waittill("mortars_crewDisabled");
    var12 = var3[var8];
    var13 = var2[var8];
    var12 thread scripts\sp\maps\highway\highway_utility::dialogue(var13, 1.5);
    var14 = level scripts\engine\utility::waittill_any_return("mortars_fire", "mortars_crewSpotted");

    if(var14 == "mortars_crewSpotted") {
      var7 = 1;
      var8 = scripts\engine\math::wrap(0, var2.size - 1, var8 + 1);
      continue;
    }

    if(var10) {
      break;
    }

    var15 = var6[var8];
    var16 = var5[var8];
    var15 thread scripts\sp\maps\highway\highway_utility::dialogue(var16, 2);
    var8 = scripts\engine\math::wrap(0, var2.size - 1, var8 + 1);
  }
}

function mortars_modellogic(var0, var1, var2) {
  var1 endon("mortars_stop");
  var1 show();
  var1.animname = "mortars_mortar";
  var1 scripts\common\anim::setanimtree();
  var3 = getspawnerarray(var1.target);
  var4 = [];

  foreach(var6 in var3) {
    var7 = var6 scripts\engine\sp\utility::spawn_ai(1);
    var8 = var7 scripts\engine\utility::get_linked_nodes();
    var7.crawlnode = scripts\engine\utility::random(var8);
    var7 scripts\engine\sp\utility::set_ignoreall(1);
    var7.animname = "mortar_ai" + var7.script_index;
    var7.targetname = "mortars_enemy";
    var7 allowedstances("prone");
    var4 = scripts\engine\utility::array_add(var4, var7);
  }

  thread mortars_enemieslogic(var4, var1, var2);
  GscBinSkip4(0x35, var1);
}

function mortars_playerspottedlogic(var0) {
  for(;;) {
    var1 = anglesToForward(level.player getplayerangles());
    var2 = vectorNormalize(var0.origin - level.player getEye());
    var3 = vectordot(var1, var2);

    if(player_sniperzoomedin() && var3 >= 0.999962) {
      level notify("mortars_crewSpotted");
      break;
    }

    waitframe();
  }
}

function mortars_enemieslogic(var0, var1, var2) {
  var3 = scripts\engine\sp\utility::spawn_anim_model("mortars_backpack");
  thread mortars_enemiesanimationlogic(var1, var0, var3, var2);
  mortars_enemieswaittillalerted(var1, var0);
  var1 notify("mortars_stop");
  level notify("mortars_crewDisabled");
  var4 = [var1, var3];

  foreach(var6 in var4) {
    scripts\sp\maps\highway\highway_utility::animation_stoploop(var6);
    var6 scripts\engine\sp\utility::anim_stopanimScripted();
  }

  var0 = scripts\sp\maps\highway\highway_utility::array_removedeaddyingorundefined(var0);

  foreach(var9 in var0) {
    thread mortars_enemyreactlogic(var1, var9);
  }
}

function mortars_enemyreactlogic(var0, var1) {
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var1);
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  var1 scripts\common\utility::clear_demeanor_override();
  var1 allowedstances("prone");
  var0 scripts\common\anim::anim_single_solo(var1, "mortars_react");
  var1 scripts\engine\sp\utility::set_goal_radius(512);
  var1 setgoalnode(var1.crawlnode);
}

function mortars_enemiesanimationlogic(var0, var1, var2, var3) {
  var0 endon("mortars_stop");
  var4 = scripts\engine\utility::array_combine(var1, [var2], [var0]);
  childthread scripts\sp\maps\highway\highway_utility::animation_loop(var0, var4, "mortars_idle");

  if(isDefined(var3)) {
    wait var3;
  }

  var4 = scripts\engine\utility::array_combine(var1, [var0], [var2]);
  var5 = 7;
  var6 = 9;

  for(;;) {
    scripts\sp\maps\highway\highway_utility::animation_stoploop(var4);

    foreach(var8 in var1) {
      level.scr_goaltime["mortar_ai" + var8.script_index]["mortars_idle"] = 0;
    }

    childthread scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var0, var4, "mortars_fire", "mortars_idle");
    scripts\engine\sp\utility::array_wait_match(var1, "single anim", "mortars_fire");
    var0 notify("mortars_fire");
    scripts\engine\sp\utility::array_wait_match(var1, "single anim", "end");
    var0 waittill("mortars_impact");
    var10 = randomfloatrange(var5, var6);
    wait var10;
  }
}

function mortars_enemieswaittillalerted(var0, var1) {
  var0 endon("mortars_stop");

  foreach(var3 in var1) {
    var3 endon("death");
    var3 endon("entitydeleted");
  }

  for(;;) {
    level waittill("ballistics_impact");

    if(!player_sniperzoomedin()) {
      continue;
    }

    var5 = anglesToForward(level.player getgunangles());
    var6 = vectorNormalize(var0.origin - level.player getEye());
    var7 = vectordot(var5, var6);

    if(var7 < 0.999962) {
      continue;
    }

    break;
  }
}

function mortars_getenemies() {
  return getEntArray("mortars_enemy", "targetname");
}

function mortars_firemortarprojectile(var0, var1) {
  level notify("mortars_fire");
  thread mortars_mortarinairflaglogic(var1);
  var2 = scripts\engine\trace::create_world_contents();
  var3 = (0, 0, -1);
  var4 = level.player.origin + anglesToForward(level.player.angles) * var0;
  var4 += scripts\engine\utility::randomvector(300);
  var4 += (0, 0, 512);
  var5 = var4 + var3 * var4 * 2;
  var6 = var1.origin;
  var7 = scripts\engine\trace::ray_trace(var4, var5, undefined, var2)["position"];
  thread scripts\engine\utility::play_sound_in_space("weap_mortar_fire_dist", var6);
  physicsexplosionsphere(var6, 350, 350, 200);
  var8 = spawn("script_model", var6);
  var8 setModel("equipment_mortar_shell_improvised_01");
  playFX(level._effect["vfx_mortar_fire"], var6, anglesToForward(var1.angles));
  playFXOnTag(level._effect["vfx_mortar_trail"], var8, "tag_origin");
  var9 = lookupsoundlength("weap_mortar_incoming") * 0.001 * 0.8;
  var10 = max(0.05, 7 - var9 - 0.5);
  var8 scripts\engine\utility::delaythread(var10, &scripts\engine\utility::playsoundontag, "weap_mortar_incoming", "tag_origin");
  var8 playLoopSound("weap_mortar_fly_lp");
  var11 = 0.00714286;
  var12 = 0;

  while(var12 < 1) {
    var13 = var8.origin;
    var8.origin = scripts\engine\math::get_point_on_parabola(var6, var7, 3000, var12);
    var14 = var12 * 2 - 1;
    var15 = (var14 * var14 * -1 + 1) * 600;
    var16 = vectorNormalize(level.ballistics.wind);
    var8.origin += var16 * var15;
    var8.angles = vectortoangles(var8.origin - var13);
    var12 += var11;
    waitframe();
  }

  var8 stoploopsound("weap_mortar_fly_lp");
  mortars_explodemortarprojectile(var8, 1, var1);
}

function mortars_explodemortarprojectile(var0, var1, var2) {
  var3 = var0.origin;
  var0 delete();

  if(var1) {
    if(level.player playerads()) {
      var4 = 0.09;
    } else {
      var4 = 0.4;
    }

    physicsexplosionsphere(var4, 512, 256, 150);
    earthquake(var4, 1.25, var4, 50000);
    playrumbleonposition("damage_heavy", var4);
    thread mortars_explodemortarsfx(var4);
  }

  playFX(level._effect["vfx_mortar_impact"], var4);
  scripts\engine\utility::exploder("vfx_dust_interior");
  var3 notify("mortars_impact", var4);
  level notify("mortars_impact", var4);
}

function mortars_mortarinairflaglogic(var0) {
  level endon("mortars_fire");
  scripts\sp\maps\highway\highway_utility::level_setflag(2, 1);
  var0 waittill("mortars_impact");
  scripts\sp\maps\highway\highway_utility::level_setflag(2, 0);
}

function mortars_explodemortarsfx(var0) {
  var1 = spawn("script_origin", var0 + (0, 0, 1));
  var1 playexplosionsound("weap_mortar_expl_trans", "exp");
  wait 8;
  var1 delete();
}

function mortars_getmodels() {
  return getEntArray("mortars_model", "targetname");
}

function suicide_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility::level_setflag(64, 1);
}

function suicide_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("suicide");
  scripts\sp\maps\highway\highway_utility::level_setflag(64, 0);
  var0 = suicide_spawnVehicle();
  thread vehicle_suicidetrucklogic(var0);
  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();
  var1 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_STOP_SUICIDE_TRUCK");
  objective_onentity(var1, var0);
  objective_setzoffset(var1, 100);
  thread suicide_playersawvehiclelogic(var0);
  thread suicide_dialoguelogic(var0);
  var0 waittill("vehicle_disabled");
  level_openbunkerouterdoor();
  var2 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("allies");

  foreach(var4 in var2) {
    var4 scripts\asm\asm_bb::bb_setcovernode(undefined);
    var4 scripts\engine\sp\utility::set_goal_pos(var4.origin);
    var4 scripts\sp\maps\highway\highway_utility::ai_resetstances();
    var4 scripts\common\utility::demeanor_override("casual_gun");
  }

  var6 = level_gethadir();
  var7 = getnode("suicide_hadirNode", "targetname");
  var6 scripts\engine\sp\utility::set_goal_node(var7);
  var8 = level_getfarah();
  var9 = getnode("suicide_farahNode", "targetname");
  var8 scripts\engine\sp\utility::set_goal_node(var9);
  level waittill("vehicle_suicideShellshockOver");
  objective_delete(var1);
  var1 = level_addmissionnarrativeobjective();
  var8 = level_getfarah();
  var8 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_svbied_truck_120", 2);

  if(true) {
    wait 0.5;
  }

  objective_delete(var1);
}

function suicide_playersawvehiclelogic(var0) {
  level.player endon("death");
  var1 = gettime() + 5000;

  for(;;) {
    if(gettime() >= var1) {
      break;
    }

    var2 = level.player getEye();
    var3 = var0.origin;
    var4 = player_fullads();
    var5 = scripts\engine\utility::within_fov(var2, level.player getgunangles(), var3, 0.999391);
    var6 = sighttracepassed(var2, var3, 0, var0, 1);

    if(var4 && var5 && var6) {
      break;
    }

    waitframe();
  }

  level notify("suicide_playerSawVehicle");
}

function suicide_dialoguelogic(var0) {
  level.player endon("death");
  thread suicide_dialoguehintslogic(var0);
  var1 = level_getfarah();
  var2 = level_gethadir();
  level waittill("suicide_playerSawVehicle");
  thread suicide_musiclogic();
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_svbied_truck_10", 1, var0, "vehicle_disabled");
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_svbied_truck_30", 7, var0, "vehicle_disabled");
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_svbied_truck_40", 12, var0, "vehicle_disabled");
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_svbied_truck_90", 18, var0, "vehicle_disabled");
  var2 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_svbied_truck_60", 22, var0, "vehicle_disabled");
  var2 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_svbied_truck_100", 27, var0, "vehicle_disabled");
}

function suicide_dialoguehintslogic(var0) {
  var0 endon("vehicle_disabled");
  var1 = level_getfarah();
  level waittill("vehicle_suicideTruckArmorBreak");
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_svbied_truck_70", 0.5);
}

function suicide_spawnVehicle() {
  return vehicle_spawnsuicidetruck("suicide_vehicleSpawner", "suicide_vehicle");
}

function suicide_getvehicles() {
  var0 = vehicle_getarray();

  foreach(var2 in var0) {
    if(!scripts\engine\utility::is_equal(var2.targetname, "suicide_vehicle")) {
      var0 = scripts\engine\utility::array_remove(var0, var2);
    }
  }

  return var0;
}

function restock_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_openbunkerouterdoor();
  level_spawnredshirts();
  var0 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("allies");
  scripts\engine\utility::array_thread(var0, &scripts\common\utility::demeanor_override, "casual_gun");
}

function restock_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("restock");
  thread restock_dialoguelogic();
  thread restock_allieslogic();
  thread restock_playerlogic();
  level waittill("restock_playerAtBunker");
  thread restock_setupradioally();
  scripts\engine\utility::flag_wait("restock_playerLeftBunker");
  var0 = level_addmissionnarrativeobjective();

  if(true) {
    wait 12;
  }

  objective_delete(var0);
}

function restock_dialoguelogic() {
  var0 = level_getfarah();
  var1 = level_gethadir();
  thread restock_dialoguesectionalogic(var0, var1);
  var2 = ["dx_vom_far_mines_setup_40", "dx_vom_far_mines_setup_50", "dx_vom_far_mines_setup_60"];
  var0 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var2, 10, level, "restock_playerAtBunker", 30);
  level waittill("restock_playerLeftBunker");
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_resupply_ieds_00", 1);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_resupply_ieds_10");
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_resupply_ieds_20");
}

function restock_dialoguesectionalogic(var0, var1) {
  level endon("restock_playerLeftBunker");
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_mines_setup_10");
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_mines_setup_20", 0.5);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_mines_setup_30", 0.5);
}

function restock_allieslogic() {
  level_setredshirtgoalamount(4);
  var0 = 5;
  wait var0;
  var1 = level_gethadir();
  var2 = scripts\engine\utility::getStruct("restock_hadirAnimationStruct", "targetname");
  var3 = getnode("restock_hadirNode", "targetname");
  var1 scripts\engine\utility::set_movement_speed(56);
  thread restock_plantingallylogic(var1, var2, var3, 7, "restock_hadirIED");
  var0 = 3;
  wait var0;
  var4 = level_getfarah();
  var5 = scripts\engine\utility::getStruct("restock_farahAnimationStruct", "targetname");
  var6 = getnode("restock_farahNode", "targetname");
  var4 scripts\engine\utility::set_movement_speed(56);
  thread restock_plantingallylogic(var4, var5, var6, 0, "restock_farahIED");
}

function restock_plantingallylogic(var0, var1, var2, var3, var4) {
  var0 scripts\engine\sp\utility::set_goalRadius(4);

  if(!scripts\engine\utility::flag("restock_playerLeftBunker")) {
    thread restock_allyplace(var0, var1, var4);
    scripts\engine\utility::flag_wait("restock_playerLeftBunker");
  }

  if(istrue(var3)) {
    scripts\sp\maps\highway\highway_utility::animation_stoploop(var0);
    scripts\sp\maps\highway\highway_utility::animation_loop(var1, var0, "restock_idle");
    wait var3;
  }

  scripts\sp\maps\highway\highway_utility::animation_stoploop(var0);
  var1 scripts\common\anim::anim_single_solo(var0, "restock_exit");
  var0 setgoalnode(var2);
}

function restock_allyplace(var0, var1, var2) {
  var0 endon("death");
  var0 endon("entitydeleted");
  level endon("restock_playerLeftBunker");
  thread scripts\sp\maps\highway\highway_utility::animation_reach(var1, var0, "restock_enter");
  var3 = scripts\engine\utility::waittill_any_ents_return(var0, "goal", level, "restock_playerAtBunker");
  var4 = scripts\engine\sp\utility::spawn_anim_model(var2);
  scripts\sp\maps\highway\highway_utility::animation_single(var1, [var0, var4], "restock_enter");
  level.player thread scripts\sp\equipment\ied::iedfiremain(var4);

  if(!scripts\engine\utility::flag("restock_playerLeftBunker")) {
    scripts\sp\maps\highway\highway_utility::animation_loop(var1, var0, "restock_idle");
    return;
  }
}

function restock_playerlogic() {
  var0 = scripts\sp\maps\highway\highway_utility::level_objectivegetindex();
  scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_RESUPPLY", (825.25, -2040.5, 928), &"HIGHWAY/LABEL_RESUPPLY");
  thread scripts\sp\player::focus_display_hint(11, undefined, level, "restock_playerAtBunker");
  var1 = level_getbunkervolume();

  while(!level.player istouching(var1)) {
    waitframe();
  }

  level notify("restock_playerAtBunker");
  restock_preplaceieds();

  while(level.player istouching(var1)) {
    waitframe();
  }

  objective_delete(var0);
  var2 = player_getballisticsweaponobject();

  if(!level.player hasweapon(var2)) {
    var3 = ["dx_vom_far_intro_gun_160", "dx_vom_far_intro_gun_165", "dx_vom_far_intro_gun_170"];
    var4 = level_getfarah();
    var4 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var3, 8, level, "restock_playerLeftBunker", 2);
    var0 = scripts\sp\maps\highway\highway_utility::level_objectivegetindex();
    var5 = player_getdroppedsniper();
    scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_GRAB_SNIPER", var5.origin, &"HIGHWAY/LABEL_GRAB_SNIPER");
    objective_onentity(var0, var5);
    thread scripts\sp\player::focus_display_hint(8, undefined, level, "restock_playerLeftBunker");

    for(;;) {
      if(!level.player istouching(var1) && level.player hasweapon(var2)) {
        break;
      }

      waitframe();
    }

    objective_delete(var0);
  }

  scripts\engine\utility::flag_set("restock_playerLeftBunker");
}

function restock_connectiedpaths() {
  var0 = scripts\engine\utility::getStructArray("restock_preplacedIED", "targetname");

  foreach(var2 in var0) {
    if(!isDefined(var2.target)) {
      continue;
    }

    var3 = getEntArray(var2.target, "targetname");

    foreach(var5 in var3) {
      var6 = var5.spawnflags & 1;

      if(!var6) {
        continue;
      }

      var5 connectpaths();
    }
  }
}

function restock_preplaceieds() {
  var0 = scripts\engine\utility::getStructArray("restock_preplacedIED", "targetname");

  foreach(var2 in var0) {
    var3 = restock_preplaceied(var2.origin, var2.angles);

    if(!isDefined(var2.target)) {
      continue;
    }

    var4 = getEntArray(var2.target, "targetname");
    var5 = getscriptablearray(var2.target, "targetname");
    var4 = scripts\engine\utility::array_remove_array(var4, var5);
    thread restock_replacediedlogic(var3, var4, var5, var2.radius);
  }
}

function restock_preplaceied(var0, var1) {
  var2 = spawn("script_model", var0);
  var2.angles = var1;
  var2 setModel("weapon_wm_bomb_ied_bomb");
  level.player thread scripts\sp\equipment\ied::iedfiremain(var2);
  return var2;
}

function restock_replacediedlogic(var0, var1, var2, var3) {
  var4 = var0.origin;
  var0 waittill("detonated");

  foreach(var6 in var1) {
    var7 = var6.spawnflags & 1;

    if(var7) {
      var6 disconnectPaths();
    }

    if(istrue(var6.script_delete)) {
      var6 delete();
      continue;
    }

    var6 physicslaunchserver(var6.origin - (0, 0, 10), (0, 0, 9500));
  }

  foreach(var10 in var2) {
    if(istrue(var10.script_delete)) {
      var10 delete();
      continue;
    }

    var10 setscriptablepartstate("base", "explosion");
  }

  if(isDefined(var3)) {
    createnavbadplacebybounds(var4, (var3, var3, var3), (0, 0, 0));
    return;
  }
}

function restock_getiedpathentities() {
  return getEntArray("restock_IEDPaths", "script_noteworthy");
}

function restock_getfarahnode() {
  return getnode("restock_farahNode", "targetname");
}

function restock_gethadirnode() {
  return getnode("restock_hadirNode", "targetname");
}

function restock_getredshirtnodes() {
  return getnodearray("restock_redShirtNode", "targetname");
}

function restock_setupradioally() {
  var0 = radio_spawnradioally();
  var1 = level_gettownanimationstruct();
  thread scripts\sp\maps\highway\highway_utility::animation_reachtoidle(var1, var0, "radio_allyEnterIdle");
}

function radio_start() {
  level_spawnhadir();
  var0 = level_spawnfarah();
  var1 = restock_getfarahnode();
  var0 forceteleport(var1.origin, var1.angles);
  var0 scripts\engine\sp\utility::set_goalRadius(4);
  var0 setgoalnode(var1);
  player_givefullloadout();
  level_setredshirtgoalamount(4);
  level_spawnredshirts();
  var2 = level_getredshirts();
  var3 = restock_getredshirtnodes();

  foreach(var5 in var2) {
    var6 = sortbydistance(var3, var5.origin)[0];

    if(!isDefined(var6)) {
      break;
    }

    var5 scripts\engine\sp\utility::teleport_ai(var6);
    var5 scripts\engine\sp\utility::set_goalRadius(64);
    var3 = scripts\engine\utility::array_remove(var3, var6);
  }

  thread restock_setupradioally();
  restock_preplaceieds();
  scripts\engine\sp\utility::set_start_location("start_sniper", [level.player]);
}

function radio_main() {
  level.player endon("death");
  scripts\engine\sp\utility::autosave_by_name_silent("radio");
  var0 = radio_getinteractstruct();
  var1 = level_getfarah();
  var2 = radio_getradioally();
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_sniper_radio_10");
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_sniper_radio_20");
  thread scripts\sp\player::focus_display_hint(1);
  var3 = ["dx_vom_far_sniper_radio_30", "dx_vom_far_sniper_radio_40", "dx_vom_far_sniper_radio_50"];
  var1 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var3, 13, level, "radio_playerNearAI", 13);
  var4 = level_getredshirts();
  scripts\engine\utility::array_thread(var4, &scripts\common\utility::clear_demeanor_override);
  var2 scripts\common\utility::clear_demeanor_override();
  var5 = var0.origin + (0, 0, 10);
  var6 = scripts\sp\maps\highway\highway_utility::level_objectivegetindex();
  scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_CONTACT_CAPTAIN_PRICE", var5, &"HIGHWAY/LABEL_RADIO");
  thread scripts\sp\player::focus_display_hint(10, undefined, level, "radio_playerNearAI");
  thread radio_waittillplayernearradio(var0, 200, 0.939693);
  level waittill("radio_playerNearAI");
  var7 = level_gettownanimationstruct();
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var2);
  thread scripts\sp\maps\highway\highway_utility::animation_singleintoloop(var7, var2, "radio_allyEnter", "radio_allyIdle");
  var2 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_fsa1_sniper_radio_55");
  var8 = scripts\engine\utility::spawn_tag_origin(var0.origin);
  var8 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HIGHWAY/CURSOR_CONTACT_CAPTAIN_PRICE", undefined, undefined, 55);
  var8 waittill("trigger");
  objective_delete(var6);
  var6 = level_addmissionnarrativeobjective();
  level.player scripts\engine\sp\utility::set_player_demeanor("safe");
  var9 = scripts\engine\utility::spawn_script_origin(var8.origin, var8.angles);
  var9.name = "Cpt. Price";
  var9.animname = "price";
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_sniper_radio_60", 0.25);
  var9 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_pri_sniper_radio_70", 0.2);
  level.player thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_sniper_combat_15", 6);
  var9 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_pri_sniper_combat_20", 8.5);

  if(true) {
    wait 1;
  }

  var2.targetname = "level_redShirt";
  var10 = level_redshirtgetclosestonscreen();
  var11 = var10 getEye();
  var12 = sniper_getenemynodes();
  var13 = scripts\engine\utility::random(var12);
  sniper_fireshot(var13, var11);
  var11 = var10 getEye();

  if(getdvarint("NTMLLPTNLT")) {
    playFX(level.g_effect["vfx_gib_explode"], var11);
  }

  thread scripts\engine\utility::play_sound_in_space("gib_fullbody", var11);
  thread sniper_playerscreenbloodeffectlogic(var11);
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var2);
  var2 scripts\engine\sp\utility::anim_stopanimScripted();
  var2 scripts\common\ai::stop_magic_bullet_shield();
  setmusicstate("mx_highway_sniper_death");

  if(var2 == var10) {
    var2.diequietly = 1;
    var2.skipdeathanim = 1;
    var2 thread[[level.aigibfunction]](var2, var11, "MOD_RIFLE_BULLET");
  } else {
    var2 thread[[level.aigibfunction]](var10, var11, "MOD_RIFLE_BULLET");
  }

  var14 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("allies");

  foreach(var16 in var14) {
    var16 allowedstances("prone");
  }

  var18 = radio_getallypronenodes();
  scripts\sp\maps\highway\highway_utility::ai_takecoveratnodes(var14, var18);
  wait 0.15;
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.player scripts\engine\sp\utility::player_gesture_force("ges_frag_block");
  var19 = level_getheroes();
  scripts\engine\utility::array_thread(var19, &scripts\common\utility::clear_demeanor_override);
  objective_delete(var6);
}

function radio_getallypronenodes() {
  return getnodearray("radio_allyProneNode", "targetname");
}

function radio_radioallysurvivedlogic(var0) {
  var0 endon("death");
  var0 scripts\engine\sp\utility::set_goalRadius(4);
  var1 = radio_getradioallynode();
  var0 setgoalnode(var1);
  var0 waittill("goal");
  var0 scripts\sp\maps\highway\highway_utility::ai_resetstances();
}

function radio_spawnradioally() {
  var0 = getspawner("radio_allySpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.targetname = "radio_ally";
  var1.animname = "radio_ally";
  var1 scripts\common\ai::magic_bullet_shield();
  var1 setModel("body_sla_rebels_lmg_2_1");
  scripts\sp\maps\highway\highway_utility::ai_attachhead(var1, "head_sc_m_ahmadzai_civ");

  if(isDefined(var1.hatmodel)) {
    var1 detach(var1.hatmodel);
  }

  var1.hatmodel = undefined;
  return var1;
}

function radio_getradioally() {
  return getEnt("radio_ally", "targetname");
}

function radio_getradioallynode() {
  return getnode("radio_radioAllyNode", "targetname");
}

function radio_waittillplayernearradio(var0, var1, var2) {
  var3 = var1 * var1;

  for(;;) {
    waitframe();
    var4 = distancesquared(level.player.origin, var0.origin);

    if(var4 > var3) {
      continue;
    }

    var5 = sighttracepassed(level.player getEye(), var0.origin, 0, level.player, 1);

    if(!var5) {
      continue;
    }

    var6 = anglesToForward(level.player getplayerangles());
    var7 = vectorNormalize(var0.origin - level.player getEye());
    var8 = vectordot(var6, var7);
    var9 = var8 >= var2;

    if(!var9) {
      continue;
    }

    break;
  }

  level notify("radio_playerNearAI");
}

function radio_getinteractstruct() {
  return scripts\engine\utility::getStruct("radio_interactStruct", "targetname");
}

function sniper_start() {
  var0 = level_spawnfarah();
  var1 = level_spawnhadir();
  player_givefullloadout();
  level_setredshirtgoalamount(4);
  level_spawnredshirts();
  var2 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("allies");
  var3 = radio_getallypronenodes();

  foreach(var5 in var2) {
    if(scripts\common\ai::spawn_failed(var5)) {
      continue;
    }

    var5 allowedstances("prone");
    var6 = sortbydistance(var3, var5.origin)[0];

    if(!isDefined(var6)) {
      break;
    }

    var5 scripts\engine\sp\utility::teleport_ai(var6);
    var5 scripts\engine\sp\utility::set_goalRadius(64);
    var3 = scripts\engine\utility::array_remove(var3, var6);
  }

  restock_preplaceieds();
  scripts\engine\sp\utility::set_start_location("start_sniper", [level.player]);
}

function sniper_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("sniper");
  var0 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_ELIMINATE_ENEMY_SNIPER");
  thread sniper_windshiftlogic();
  thread sniper_allieslogic();
  var1 = sniper_spawnenemy();
  thread sniper_enemylogic(var1);
  thread sniper_dialoguelogic(var1);
  var1 waittill("death");
  thread sniper_postdeathlogic(var0);
}

function sniper_postdeathlogic(var0) {
  setmusicstate("");
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_sniper_relocate_60", 1);
  var1 = level_getfarah();
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_sniper_kill_10", 1);
  objective_delete(var0);
}

function sniper_allieslogic() {
  scripts\sp\maps\highway\highway_utility::level_setflag(32, 0);
}

function sniper_windshiftlogic(var0) {
  if(istrue(var0)) {
    wait var0;
  }

  var1 = wind_getrandomdirectionindex();
  wind_setdirection(var1, 2000, 1);
}

function sniper_dialoguelogic(var0) {
  var0 endon("death");
  level.player endon("death");
  var1 = level_getfarah();
  var2 = level_gethadir();
  GscBinSkip4(0x35, var0);
}

function sniper_dialoguesightedlogic(var0) {
  var1 = 0;
  var2 = 500;

  for(;;) {
    var3 = anglesToForward(level.player getplayerangles());
    var4 = vectorNormalize(var0.origin - level.player getEye());
    var5 = vectordot(var3, var4);

    if(player_sniperzoomedin() && var5 >= 0.999962) {
      if(!var1) {
        var1 = gettime();
      }

      if(gettime() >= var1 + var2) {
        break;
      }
    } else {
      var1 = 0;
    }

    waitframe();
  }

  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_sniper_combat_120");
}

function sniper_dialogueintrologic() {
  var0 = level_getfarah();
  var1 = level_gethadir();
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_sniper_combat_10", 1.5);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_sniper_combat_40", 0.75);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_sniper_combat_42", 1);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_sniper_combat_50", 4);
}

function sniper_dialoguerelocatelogic() {
  level waittill("sniper_enemyRelocating");
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_sniper_wind_10", 1);
  var0 = level_getfarah();
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_sniper_wind_40", 1);

  if(level.ballistics.winddirectionaimstring == "left") {
    var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_sniper_wind_80");
  } else {
    var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_sniper_wind_60");
  }

  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_sniper_relocate_34", 1);

  for(;;) {
    level waittill("sniper_enemyRelocating");
    level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_sniper_relocate_10", 1);
  }
}

function sniper_enemylogic(var0) {
  var0 allowedstances("crouch");
  thread sniper_enemyglinton(var0);
  var1 = sniper_getenemynodes();
  var2 = scripts\engine\utility::random(var1);
  var0 scripts\engine\sp\utility::teleport_ai(var2);
  var0 scripts\engine\sp\utility::set_goalRadius(4);
  thread sniper_combatlogic(var0, var2);
}

function sniper_enemyglinton(var0) {
  playFXOnTag(level._effect["vfx_sniper_glint"], var0, "tag_flash");
  scripts\engine\utility::waittill_any_ents(var0, "death", level, "sniper_enemyRelocating");

  if(!isDefined(var0)) {
    return;
  }

  if(!var0 tagexists("tag_flash")) {
    return;
  }

  stopFXOnTag(level._effect["vfx_sniper_glint"], var0, "tag_flash");
}

function sniper_combatlogic(var0, var1) {
  var0 endon("death");
  level.player endon("death");
  GscBinSkip4(0x35, var0);
}

function sniper_playerscreenbloodeffectlogic(var0) {
  var1 = 130;

  if(distance(var0, level.player getEye()) > var1) {
    return;
  }

  level.player thread scripts\sp\player::bloodoverlay(1, 3, 4);
  level.player thread scripts\sp\player::damagebloodoverlaydirectional(var0, "MOD_RIFLE_BULLET", 8);
}

function sniper_playerlookingatenemy(var0) {
  var1 = anglesToForward(level.player getplayerangles());
  var2 = vectorNormalize(var0 getEye() - level.player getEye());
  var3 = vectordot(var1, var2);
  return var3 >= 0.999889;
}

function sniper_enemyrelocate(var0, var1, var2) {
  var3 = var2.origin - var1.origin;
  scripts\engine\utility::flag_set("sniper_enemyRelocating", var3);
  var0 allowedstances("prone");
  var0 scripts\sp\maps\highway\highway_utility::ai_waittillinstance("prone");
  var0 scripts\engine\sp\utility::set_goalRadius(4);
  scripts\sp\maps\highway\highway_utility::ai_movealongpath(var0, var2);
  var4 = 0.5;
  wait var4;

  if(isDefined(var2.script_stance)) {
    var0 allowedstances(var2.script_stance);
  } else {
    var0 allowedstances("crouch");
  }

  var5 = 2;
  wait var5;
  scripts\engine\utility::flag_clear("sniper_enemyRelocating");
  level notify("sniper_enemyRelocated");
  thread sniper_enemyglinton(var0);
}

function sniper_enemyspottedlogic(var0) {
  var1 = 2000;
  var2 = squared(var1);

  for(;;) {
    level waittill("ballistics_impact", var3);

    if(distancesquared(var3, var0.origin) > var2) {
      continue;
    }

    level notify("sniper_enemySpotted");
  }
}

function sniper_enemytargetentitylogic(var0) {
  var1 = scripts\engine\utility::spawn_script_origin();
  var2 = 100;
  var0 setentitytarget(var1);

  while(isalive(var0)) {
    var3 = vectorNormalize(level.player getEye() - var0 getEye());
    var1.origin = var0 getEye() + var3 * var2;
    waitframe();
  }

  var1 delete();
}

function sniper_killplayerlogic(var0) {
  var1 = 20;
  var2 = 28;
  var3 = -9;
  var4 = -13;
  var5 = -6;
  var6 = -1;
  var7 = 0;
  var8 = 100;
  var9 = -50;

  for(;;) {
    var10 = 0;
    var11 = sighttracepassed(level.player getEye(), var0 getEye(), 0, level.player, 1);

    if(scripts\engine\utility::flag("sniper_enemyRelocating")) {
      var10 += var6;
    } else if(var11) {
      var12 = level.player getstance();

      if(var12 == "crouch") {
        var10 += var1;
      } else if(var12 == "stand") {
        var10 += var2;
      }

      if(level.player issprinting()) {
        var10 += var4;
      } else if(length(level.player getvelocity())) {
        var10 += var3;
      }
    } else {
      var10 += var5;
    }

    var10 /= 20;
    var7 = clamp(var7 + var10, 0, var8);

    if(var7 >= var8) {
      thread sniper_fireshot(var0, level.player getEye());
      level waittill("sniper_bulletImpact");
      var11 = sighttracepassed(level.player getEye(), var0 getEye(), 0, level.player, 1);

      if(var11 && !scripts\engine\utility::flag("sniper_enemyRelocating")) {
        playFX(level.g_effect["vfx_gib_explode"], level.player getEye());
        thread scripts\engine\utility::play_sound_in_space("gib_fullbody", level.player getEye());
        wait 0.1;
        level.player kill();
      } else {
        var7 += var9;
      }
    }

    waitframe();
  }
}

function sniper_fireshot(var0, var1) {
  if(isai(var0)) {
    var2 = var0 gettagorigin("tag_flash");
    var3 = var0 gettagangles("tag_flash");
    var0 shoot();
  } else {
    var2 = var2.origin;
    var3 = var2.angles;
  }

  playFX(level._effect["vfx_sniper_dust_kickup"], var2.origin);
  playFX(level._effect["vfx_sniper_muzzle_flash"], var2, var3);
  scripts\engine\utility::delaythread(1.25, &scripts\engine\utility::play_sound_in_space, "sniper_fireDistant", var2);
  var4 = scripts\engine\utility::spawn_tag_origin(var2);
  var4 notsolid();
  playFXOnTag(level._effect["vfx_sniper_bullet_trail"], var4, "tag_origin");
  var5 = 0.0333333;
  var6 = 0;
  var7 = (0, 0, 0);

  while(var6 < 1) {
    var8 = var4.origin;
    var4.origin = scripts\engine\math::get_point_on_parabola(var2, var3, 50, var6);
    var7 = vectorNormalize(var4.origin - var8);
    var6 += var5;
    waitframe();
  }

  var4.origin = var3;
  scripts\engine\utility::delaythread(0.25, &scripts\engine\utility::play_sound_in_space, "sniper_impact_crack_highway", var3);
  level notify("sniper_bulletImpact");
  physicsexplosionsphere(var3, 90, 90, 150);
  earthquake(0.15, 0.7, level.player.origin, 9999);
  playrumbleonposition("damage_heavy", level.player.origin);
  var9 = distance(var2, var3);
  var10 = var9 / 1.5;
  var11 = var3 + var7 * var10 * 2;
  var4 moveTo(var11, 2);
  var4 scripts\engine\utility::delaycall(2, &delete);
}

function sniper_getimpactstructs() {
  return scripts\engine\utility::getStructArray("sniper_impactStruct", "targetname");
}

function sniper_spawnenemy() {
  var0 = sniper_getenemyspawner();
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.targetname = "sniper_enemy";
  var1.dontevershoot = 1;
  var1 scripts\engine\utility::disable_pain();
  var1 scripts\engine\sp\utility::set_moveplaybackrate(1.5);
  var1.disablepistol = 1;
  var1.script_parameters = "gib_force";
  return var1;
}

function sniper_getenemy() {
  return getEnt("sniper_enemy", "targetname");
}

function sniper_getenemyspawner() {
  return getspawner("sniper_enemySpawner", "targetname");
}

function sniper_getenemynodes() {
  return getnodearray("sniper_enemyNode", "targetname");
}

function squad_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  thread sniper_windshiftlogic();
  restock_preplaceieds();
}

function squad_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("squad");
  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();
  var0 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_ELIMINATE_MORTARS");
  thread squad_allieslogic();
  thread squad_dialoguelogic();
  thread squad_enemieslogic();
  level waittill("mortars_crewDisabled");
  var1 = squad_getmortarmodels();

  foreach(var3 in var1) {
    var3 notify("mortars_stop");
  }

  objective_delete(var0);
  var0 = level_addmissionnarrativeobjective();

  while(scripts\sp\maps\highway\highway_utility::level_getflag(2)) {
    waitframe();
  }

  if(true) {
    wait 2;
  }

  objective_delete(var0);
}

function squad_enemieslogic() {
  level endon("mortars_crewDisabled");
  var0 = 1.25;
  var1 = 4;
  var2 = squad_getmortarmodels();

  foreach(var4 in var2) {
    var5 = var1 + var0 * var6;
    thread mortars_modellogic(0, var4, var5);
  }
}

function squad_allieslogic() {
  scripts\sp\maps\highway\highway_utility::level_setflag(32, 1);
  scripts\sp\maps\highway\highway_utility::level_setflag(64, 1);
  var0 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("allies");

  foreach(var2 in var0) {
    var2 scripts\sp\maps\highway\highway_utility::ai_resetstances();
  }
}

function squad_dialoguelogic() {
  level endon("mortars_crewDisabled");
  var0 = level_getfarah();
  var1 = level_gethadir();
  var1 childthread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_russian_jets_10", 4, level, "mortars_impact");
  var0 childthread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_russian_jets_30", 7);
  level waittill("mortars_impact");
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_mortar_team3_20", 4);
}

function squad_getmortarmodels() {
  return getEntArray("squad_mortarModel", "targetname");
}

function squad_getvehiclespawners() {
  return scripts\common\utility::getvehiclespawnerarray("squad_vehicleSpawner", "targetname");
}

function squad_spawnvehicles() {
  var0 = squad_getvehiclespawners();
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\common\utility::spawn_vehicle();
    var4.targetname = "squad_vehicle";
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function squad_getvehicles() {
  var0 = vehicle_getarray();

  foreach(var2 in var0) {
    if(!scripts\engine\utility::is_equal(var2.targetname, "squad_vehicle")) {
      var0 = scripts\engine\utility::array_remove(var0, var2);
    }
  }

  return var0;
}

function jets_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility::level_setflag(64, 1);
  restock_preplaceieds();
  var0 = level_addmissionnarrativeobjective();
  scripts\engine\utility::exploder("jets_explo");
}

function jets_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("jets");
  var0 = level_addmissionnarrativeobjective();
  var1 = jets_getvehiclespawners();
  var2 = [];
  var3 = ["scn_highway_bombrun_jet1_by", "scn_highway_bombrun_jet2_by", undefined, "scn_highway_bombrun_jet3and4_by"];
  var4 = [0, 6.2, undefined, 9.2];

  foreach(var8, var6 in var1) {
    var7 = jets_spawnVehicle(var6);
    var7.spawnnumber = var8;
    thread jets_vehiclelogic(var7);
    thread jets_sfxlogic(var7, var3[var8], var4[var8]);
  }

  thread jets_dialoguelogic();
  thread sfx_jets_bomb_expl();
  level waittill("vehicle_suniform25BombImpact");
  var9 = wind_getrandomdirectionindex();
  wind_setdirection(var9, 2000, 0);
  scripts\engine\utility::exploder("explo");

  if(true) {
    wait 12;
  }

  objective_delete(var0);
}

function sfx_jets_bomb_expl() {
  level waittill("vehicle_suniform25BombImpact", var0);
  thread scripts\engine\utility::play_sound_in_space("scn_highway_bombrun_jet1_bomb_expl", var0);
  wait 2;
  level waittill("vehicle_suniform25BombImpact", var0);
  thread scripts\engine\utility::play_sound_in_space("scn_highway_bombrun_jet2_bomb_expl", var0);
  wait 2;
  level waittill("vehicle_suniform25BombImpact", var0);
  thread scripts\engine\utility::play_sound_in_space("scn_highway_bombrun_jet3and4_bomb_expl", var0);
}

function jets_sfxlogic(var0, var1, var2) {
  if(!isDefined(var1)) {
    return;
  }

  if(istrue(var2)) {
    wait var2;
  }

  var0 playSound(var1);
}

function jets_dialoguelogic() {
  var0 = level_getfarah();
  var1 = level_gethadir();
  level waittill("vehicle_suniform25BombImpact", var2);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_russian_jets_40", 5);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_russian_jets_41");
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_russian_jets_45", 1);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_russian_jets_50", 6.5);
}

function jets_getvehiclespawners() {
  return scripts\common\utility::getvehiclespawnerarray("jets_vehicleSpawner", "targetname");
}

function jets_spawnVehicle(var0) {
  var1 = var0 scripts\common\utility::spawn_vehicle();
  var1 scripts\common\vehicle::godon();
  return var1;
}

function jets_vehiclelogic(var0) {
  thread scripts\common\vehicle_paths::gopath(var0);
  thread vehicle_suniform25effects(var0);
  playFXOnTag(level._effect["vfx_jet_engine"], var0, "TAG_ENGINE_LEFT");
  playFXOnTag(level._effect["vfx_jet_engine"], var0, "TAG_ENGINE_RIGHT");
  playFXOnTag(level._effect["vfx_jet_wing_trail"], var0, "TAG_WINGTIP_LEFT");
  playFXOnTag(level._effect["vfx_jet_wing_trail"], var0, "TAG_WINGTIP_RIGHT");
  playFXOnTag(level._effect["vfx_suniform25_jet_swirl"], var0, "TAG_ORIGIN");
  var0 endon("death");
  var1 = var0.currentnode;

  for(;;) {
    if(!scripts\engine\utility::is_equal(var0.currentnode, var1)) {
      if(scripts\engine\utility::is_equal(var0.currentnode.script_noteworthy, "jets_vehicleNodeDropBomb")) {
        thread vehicle_suniform25dropbomb(var0);
      }
    }

    var1 = var0.currentnode;
    waitframe();
  }
}

function armor_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility::level_setflag(64, 1);
  restock_preplaceieds();
}

function armor_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("armor");
  scripts\sp\maps\highway\highway_utility::level_setflag(16, 0);
  var0 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
  scripts\engine\utility::array_delete(var0);
  var1 = armor_spawnvehicles();

  foreach(var3 in var1) {
    thread armor_vehiclelogic(var3, 0);
  }

  thread armor_audiologic(var1);
  thread armor_dialoguelogic(var1);
  thread armor_vehicleenemieslogic(var1);
  thread armor_objectivelogic(var1);
  thread armor_vehiclesstoppedautosave(var1);
  thread armor_notifylevelonvehicleendpath(var1);
  thread armor_clearvehiclessmokegrenades(var1);
  thread armor_achievementlogic();
  var5 = level_getfarah();
  var5 scripts\sp\maps\highway\highway_utility::ai_resetstances();
  var6 = getnode("restock_hadirNode", "targetname");
  var5 scripts\engine\sp\utility::set_goal_node(var6);
  scripts\sp\maps\highway\highway_utility::waittill_remainingenemycountortimeout(12, 90);
  level notify("armor_playerSpottedVehicle");

  if(false) {
    wait 0;
    return;
  }
}

function armor_objectivelogic(var0) {
  var1 = [level];
  var2 = ["armor_allVehiclesStopped", "vehicle_tireBreak"];
  level.player scripts\sp\player::focus_display_hint(30, undefined, var1, var2);
  var3 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_STOP_RUSSIAN_ASSAULT");

  foreach(var5 in var0) {
    objective_setlocation(var3, var6, var5);
    objective_setzoffset(var3, 125);
    var5 thread scripts\sp\maps\highway\highway_utility::call_on_notify_no_self("vehicle_tireBreak", &objective_unsetlocation, var3, var6);
  }
}

function armor_vehiclesstoppedautosave(var0) {
  scripts\engine\utility::array_wait(var0, "reached_wait_speed");
  scripts\engine\sp\utility::autosave_by_name_silent("armor_vehiclesStopped");
}

function armor_vehicleenemieslogic(var0) {
  scripts\engine\utility::array_wait(var0, "reached_wait_speed");
  var1 = [];

  foreach(var3 in var0) {
    var1 = scripts\engine\utility::array_combine(var1, var3.riders);
  }

  foreach(var6 in var1) {
    thread level_enemyassaulttownlogic(var6, 1);
  }
}

function armor_audiologic(var0) {
  wait 8;
  var0[1] playSound("scn_highway_apc_drive_in_01");
  wait 3;
  setmusicstate("mx_highway_apc");
  var0[0] playLoopSound("veh_apc_highway_engine_lp_01");
  var0[1] playLoopSound("veh_apc_highway_engine_lp_02");
  var0[2] playLoopSound("veh_apc_highway_engine_lp_03");
  var0[3] playLoopSound("veh_apc_highway_engine_lp_04");

  foreach(var2 in var0) {
    thread armor_vehicletireaudiologic(var2);
  }

  wait 21;
  var0[1] playSound("scn_highway_apc_drive_in_02");
  wait 25;
  thread mus_ethnic_battle();
}

function armor_vehicletireaudiologic(var0) {
  var1 = spawn("script_origin", var0.origin);
  var1 linkTo(var0);
  var1 playLoopSound("veh_apc_highway_tires_lp");
  var0 waittill("reached_wait_speed");
  var0 stoploopsound();
  var1 scripts\engine\sp\utility::sound_fade_and_delete(2, 1);
}

function armor_vehiclelogic(var0, var1) {
  if(var1) {
    var2 = var0 scripts\sp\maps\highway\highway_utility::get_lastentinspline(var0.currentnode, &getvehiclenode);
    var0 attachpath(var2);
    var0 thread scripts\common\vehicle::vehicle_unload();
    goto LOC_00000064;
  }

  scripts\engine\utility::exploder("armor_smoke");
  thread armor_vehiclespottedlogic(var0);
  wait 2;
  thread scripts\common\vehicle_paths::gopath(var0);
  var0 vehicle_setspeed(10, 15);

  while(!var0 vehicle_getspeed()) {
    waitframe();
  }

  var0 setwaitspeed(0);
  var0 waittill("spawnedRiders", var3);
  var0 vehicle_turnengineoff();
  var0 stopsounds();
  var0 stoploopsound();

  foreach(var5 in var3) {
    thread level_enemyassaulttownlogic(var5, 1);
  }
}

function armor_vehiclespottedlogic(var0) {
  var0 endon("reached_end_node");
  var0 endon("vehicle_disabled");
  level endon("armor_playerSpottedVehicle");
  thread armor_vehiclespottedspeedlogic(var0);
  var1 = gettime() + 35000;

  for(;;) {
    if(gettime() >= var1) {
      break;
    }

    var2 = vectorNormalize(var0.origin - level.player getEye());
    var3 = anglesToForward(level.player getplayerangles());
    var4 = vectordot(var2, var3);

    if(player_fullads() && var4 >= 0.999848) {
      break;
    }

    waitframe();
  }

  level notify("armor_playerSpottedVehicle");
}

function armor_vehiclespottedspeedlogic(var0) {
  var0 endon("reached_end_node");
  var0 endon("vehicle_disabled");
  level waittill("armor_playerSpottedVehicle");
  var0 vehicle_setspeed(12, 10);
}

function armor_clearvehiclessmokegrenades(var0) {
  scripts\engine\utility::array_wait(var0, "vehicle_vindiaSmokeGrenadeDisperse");
  scripts\engine\utility::array_wait(var0, "vehicle_vindiaSmokeGrenadeDisperse");
  var1 = vehicle_getvindiasmokegrenades();
  var1 = scripts\engine\utility::array_removeundefined(var1);
  var1 = sortbydistance(var1, level.player.origin);

  for(var2 = 6; var2 < var1.size; var2++) {
    stopFXOnTag(level._effect["vfx_vindia_smk_gren_left"], var1[var2], "tag_fx");
    var1[var2] delete();
  }
}

function armor_achievementlogic() {
  var0 = 3;

  for(var1 = 0; var1 < var0; var1++) {
    level waittill("vehicle_vindiaDisable");
  }

  scripts\sp\utility::giveachievement_wrapper("pitstop");
}

function armor_spawnvehicles() {
  return vehicle_spawnvindias("armor_vehicleVindiaSpawner", "armor_vehicleVindia");
}

function armor_getvehicles() {
  var0 = vehicle_getarray();

  foreach(var2 in var0) {
    if(!scripts\engine\utility::is_equal(var2.targetname, "armor_vehicleVindia")) {
      var0 = scripts\engine\utility::array_remove(var0, var2);
    }
  }

  return var0;
}

function armor_dialoguelogic(var0) {
  level endon("vehicle_tireBreak");
  level endon("vehicle_vindiaReachedEndNode");
  var1 = level_getfarah();
  var2 = level_gethadir();
  thread armor_dialogicfeedbacklogic();
  var2 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_russian_apcs_90", 10, level, "armor_playerSpottedVehicle");
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_russian_apcs_10", 21, level, "armor_playerSpottedVehicle");
  var1 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_russian_apcs_45", 33, level, "armor_playerSpottedVehicle");
  level waittill("armor_playerSpottedVehicle");
  var2 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_russian_apcs_22", 1, level, "ballistics_impact");
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_russian_apcs_50", 10);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_russian_apcs_70", 4);
}

function armor_dialogicfeedbacklogic() {
  level endon("vehicle_vindiaReachedEndNode");
  var0 = level_gethadir();
  var1 = level_getfarah();
  var2 = ["dx_vom_had_russian_apcs_20", "dx_vom_had_russian_apcs_47", "dx_vom_far_russian_apcs_40"];
  var3 = [var0, var0, var1];
  var4 = 0.25;
  var5 = 0;
  var6 = ["dx_vom_had_russian_apcs_80", "dx_vom_far_convoy_backup_110"];
  var7 = [var0, var1];
  var8 = 0.25;
  var9 = 0;
  [var11] = [2, 3];
  var12 = ["dx_vom_far_russian_apcs_100"];
  var13 = [var1];
  var14 = 0.25;
  var15 = 0;
  var16 = 0;

  for(;;) {
    var17 = level scripts\engine\utility::waittill_any_return("vehicle_vindiaBodyShot", "vehicle_tireBreak", "vehicle_vindiaSmokeGrenade");

    if(var17 == "vehicle_vindiaBodyShot" && !var15) {
      var3[var5] thread scripts\sp\maps\highway\highway_utility::dialogue(var2[var5], var4);
      var5 = scripts\engine\math::wrap(0, var2.size - 1, var5 + 1);
      continue;
    }

    if(var17 == "vehicle_tireBreak") {
      var15 = 1;
      var18 = var10[var9];

      if(var11 == var18) {
        var7[var9] thread scripts\sp\maps\highway\highway_utility::dialogue(var6[var9], var8);
        var9 = scripts\engine\math::wrap(0, var6.size - 1, var9 + 1);
        var11 = 0;
      } else {
        var11++;
      }

      continue;
    }

    if(var17 == "vehicle_vindiaSmokeGrenade" && var12.size) {
      var19 = var12[0];
      var1 thread scripts\sp\maps\highway\highway_utility::dialogue(var19, 4);
      var12 = scripts\engine\utility::array_remove(var12, var19);
    }
  }
}

function armor_notifylevelonvehicleendpath(var0) {
  scripts\engine\utility::array_any_wait(var0, "reached_end_node");
  level notify("vehicle_vindiaReachedEndNode");
}

function mus_ethnic_battle() {}

function russians_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility::level_setflag(64, 1);
  restock_preplaceieds();
  var0 = armor_spawnvehicles();

  foreach(var2 in var0) {
    thread armor_vehiclelogic(var2, 1);
  }

  var0 = sortbydistance(var0, level.player.origin);
  thread vehicle_vindiasmokegrenadelogic(var0[0], 0);
  thread mus_ethnic_battle();
  scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_STOP_RUSSIAN_ASSAULT");
}

function russians_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("russians");
  setsaveddvar("NLRRTORQPN", 3);
  var0 = armor_getvehicles();
  russians_setenemygoalcount(22);
  thread russians_enemyinfinitespawninglogic(var0);
  level scripts\engine\utility::waittill_multiple("russians_playerKillCountReached", "russians_playerSurvivalTimeReached");

  if(true) {
    wait 1.5;
    return;
  }
}

function russians_enemyinfinitespawninglogic(var0) {
  level endon("russians_stopSpawning");

  foreach(var2 in var0) {
    if(var2 vehicle_getspeed()) {
      var0 = scripts\engine\utility::array_remove(var0, var2);
    }
  }

  GscBinSkip4(0x35);
}

function russians_setenemygoalcount(var0) {
  level.russiansenemygoalcount = var0;
}

function russians_getenemygoalcount() {
  return level.russiansenemygoalcount;
}

function russians_infiniteenemylogic(var0, var1) {
  var0 endon("death");
  var0 scripts\common\utility::demeanor_override("sprint");
  var0 setgoalvolumeauto(var1);

  while(!var0 istouching(var1)) {
    waitframe();
  }

  var0 scripts\common\utility::clear_demeanor_override();
}

function russians_playerkillcounterlogic() {
  level.player endon("death");
  var0 = 0;
  var1 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
  var2 = 0;

  for(;;) {
    var3 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
    var4 = scripts\engine\utility::array_remove_array(var1, var3);

    foreach(var6 in var4) {
      if(!russians_playerkillcounterworthy(var6)) {
        continue;
      }

      var0++;
    }

    if(var0 >= 7.5 && !var2) {
      scripts\engine\sp\utility::autosave_by_name("russians_halfway_kills");
      var2 = 1;
    }

    if(var0 >= 15) {
      break;
    }

    var1 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
    waitframe();
  }

  level notify("russians_playerKillCountReached");
}

function russians_playerkillcounterworthy(var0) {
  if(!scripts\engine\utility::is_equal(var0.lastattacker, level.player)) {
    return false;
  }

  if(!isDefined(var0.damagemod)) {
    return false;
  }

  if(var0.damagemod == "MOD_EXPLOSIVE") {
    return false;
  }

  if(var0.damagemod == "MOD_GRENADE") {
    return false;
  }

  if(var0.damagemod == "MOD_GRENADE_SPLASH") {
    return false;
  }

  if(var0.damagemod == "MOD_PROJECTILE") {
    return false;
  }

  if(var0.damagemod == "MOD_PROJECTILE_SPLASH") {
    return false;
  }

  var1 = level_gettowninnerenemygoalvolume();
  var2 = level_gettownouterenemygoalvolume();

  if(!var0 istouching(var1) && !var0 istouching(var2)) {
    return false;
  }

  return true;
}

function russians_playerinfiniteenemiessurvivaltimelogic() {
  level.player endon("death");
  wait 20;
  scripts\engine\sp\utility::autosave_by_name("russians_halfway_time");
  wait 20;
  level notify("russians_playerSurvivalTimeReached");
}

function russians_getenemyinfinitespawners() {
  return getspawnerarray("russians_enemyInfiniteSpawner");
}

function cover_start() {
  level_spawnfarah();
  level_spawnhadir();
  player_givefullloadout();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility::level_setflag(64, 1);
  russians_setenemygoalcount(22);
  var0 = armor_spawnvehicles();

  foreach(var2 in var0) {
    armor_vehiclelogic(var2, 1);
  }

  thread russians_enemyinfinitespawninglogic(var0);
  var0 = sortbydistance(var0, level.player.origin);
  thread vehicle_vindiasmokegrenadelogic(var0[0], 0);
  thread mus_ethnic_battle();
  scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_STOP_RUSSIAN_ASSAULT");
  setmusicstate("mx_highway_apc");
}

function cover_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("cover");
  var0 = level_gethadir();
  var1 = level_getfarah();
  var0 scripts\engine\sp\utility::set_battlechatter(0);
  var1 scripts\engine\sp\utility::set_battlechatter(0);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_russian_combat_10");
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_russian_combat_20", 0.5);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_cbc_had_inform_incoming_flashbang", 0.5);
  scripts\sp\maps\highway\highway_utility::player_waittillmaxhealth();
  scripts\engine\sp\utility::autosave_by_name_silent("cover_healthy");
  scripts\sp\maps\highway\highway_utility::level_deletereservedobjectives();
  thread cover_playerflashbanglogic();
  scripts\engine\utility::flag_set("level_enemyAssaultPlayerSeek");
  var2 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
  var2 = sortbydistance(var2, level.player.origin);

  foreach(var4 in var2) {
    var4 scripts\engine\sp\utility::set_goalRadius(600);
    var4 setgoalentity(level.player);
    var4 scripts\engine\sp\utility::set_grenadeammo(0);
  }

  russians_setenemygoalcount(7);

  for(var6 = 6; var6 < var2.size; var6++) {
    var2[var6].diequietly = 1;
    var2[var6] kill();
  }

  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var0 scripts\engine\sp\utility::set_attackeraccuracy(0);
  scripts\sp\maps\highway\highway_utility::level_setflag(512, 0);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_russian_combat_41", 1, undefined, undefined, 0);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_gas_truck_20", 0.5);
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_gas_truck_140", 0.25);
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_gas_truck_150", 0.2);
  wait 2;
  scripts\engine\sp\utility::autosave_by_name_silent("cover_getToTruck");
  level.player scripts\sp\player::set_focus_objectives_update_display(1);
  level.player scripts\sp\player::set_focus_infinite_hold(0);
  var7 = cover_getplayerinteract();
  var7 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"HIGHWAY/CURSOR_HELP", 65, 800, 60);
  thread scripts\sp\player::focus_display_hint(14, undefined, level, "russians_stopSpawning");
  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();
  var8 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_HELP_HADIR", var7.origin + (0, 0, 5), &"HIGHWAY/LABEL_HELP");
  var9 = getnode("cover_hadirNode", "targetname");
  var0 setgoalnode(var9);
  var0 scripts\common\utility::demeanor_override("sprint");
  var10 = ["dx_vom_had_gas_truck_180", "dx_vom_had_gas_truck_190", "dx_vom_had_gas_truck_30", "dx_vom_had_gas_truck_40"];
  var0 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var10, 10, level, "russians_stopSpawning", 9);
  var11 = 40000;
  var12 = gettime() + var11;
  var13 = 600;

  for(;;) {
    if(distance(level.player.origin, var7.origin) <= var13) {
      break;
    }

    if(gettime() >= var12) {
      break;
    }

    waitframe();
  }

  level notify("russians_stopSpawning");
  level_cleanupieds();
  var14 = scripts\engine\utility::getStructArray("cover_hadirIEDStruct", "targetname");

  foreach(var16 in var14) {
    scripts\sp\equipment\ied::iedplaydetonateeffects(var16.origin);
  }

  scripts\sp\equipment\ied::iedplaydetonateeffects(level.player.origin);
  earthquake(0.35, 1.5, level.player.origin, 9999);
  level.player playRumbleOnEntity("damage_heavy");
  level.player shellshock("default", 3);
  var2 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
  scripts\engine\sp\utility::array_kill(var2);
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_gas_tailgate_10", 1.5, var7, "trigger");
  var0 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_gas_tailgate_20", 5.5, var7, "trigger");
  var10 = ["dx_vom_had_gas_tailgate_30", "dx_vom_had_gas_tailgate_40", "dx_vom_had_gas_tailgate_50"];
  var0 scripts\sp\maps\highway\highway_utility::dialogue_naglogic(var10, 10, var7, "trigger", 9);
  thread scripts\sp\player::focus_display_hint(2, undefined, var7, "trigger");
  var7 waittill("trigger");
  objective_delete(var8);
  var18 = getEnt("cover_playerInteractModel", "targetname");

  if(isDefined(var18)) {
    var18 delete();
    return;
  }
}

function sfx_hadir_truck() {
  var0 = level_gethadirtruck();
  var0 playSound("scn_highway_gas_truck_start");
  wait 0.1;
  var0 playSound("scn_highway_gas_truck_grenade_bounce");
}

function cover_playerflashbanglogic() {
  var0 = 0.25;
  var1 = 0.5;
  var2 = 7;
  var3 = 6;
  var4 = level.player.attackeraccuracy;
  level.player scripts\sp\utility::set_player_attacker_accuracy(0);
  level.player enableinvulnerability();
  thread scripts\engine\utility::play_sound_in_space("cover_flashbang", level.player.origin);
  level.player shellshock("highway_cover_flashbang", var2);
  var5 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var5 fadeovertime(var0);
  var5.alpha = 1;
  wait var0;
  cover_spawnenemies();
  var5 fadeovertime(var1);
  var5.alpha = 0;
  wait var1;
  var5 destroy();
  wait var3;
  level.player scripts\sp\utility::set_player_attacker_accuracy(var4);
  level.player disableinvulnerability();
}

function cover_spawnenemies() {
  var0 = getspawnerarray("cover_enemySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.fixednode = 1;
  }
}

function cover_getplayerinteract() {
  return getEnt("cover_playerInteract", "targetname");
}

function crash_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_battlechatter(0);
  var1 = level_spawnhadir();
  var1 scripts\common\utility::demeanor_override("sprint");
  var1 scripts\engine\sp\utility::set_battlechatter(0);
  player_givefullloadout();
  scripts\engine\sp\utility::set_start_location("start_crash", [level.player, var1]);
}

function crash_main() {
  level.player scripts\sp\utility::set_player_attacker_accuracy(0);
  var0 = level_addmissionnarrativeobjective();
  thread crash_dialoguelogic();
  var1 = level_gethadirtruck();
  var2 = level_gethadirtruckboard();
  var3 = crash_getanimationstruct();
  setmusicstate("");
  thread sfx_hadir_truck();
  thread crash_playeranimationlogic(var3);
  var3 thread scripts\common\anim::anim_single_solo(var2, "crash_enter");
  var3 scripts\common\anim::anim_single_solo(var1, "crash_enter");
  thread crash_hadiranimationlogic(var3);
  var3 thread scripts\common\anim::anim_single_solo(var2, "crash_exit");
  var3 scripts\common\anim::anim_single_solo(var1, "crash_exit");
  thread audio_post_gas();
  physicsexplosionsphere(var1.origin, 400, 200, 100);
  earthquake(0.3, 1, level.player.origin, 9999);
  level.player playRumbleOnEntity("damage_heavy");
  objective_delete(var0);
}

function audio_post_gas() {
  level.player setclienttriggeraudiozone("highway_ending_01");
}

function crash_dialoguelogic() {
  var0 = level_gethadir();
  level.player scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_alx_gas_tailgate_60", 4);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_gas_tailgate_80");
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_gas_tailgate_100", 0.5);
}

function crash_playeranimationlogic(var0) {
  gas_playerpistolweaponlogic();
  var1 = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  var1 hide();
  var0 scripts\common\anim::anim_first_frame_solo(var1, "crash_enter");
  var2 = 0.4;

  if(level.player ispcplayer()) {
    setsaveddvar("OMNONNMOTP", "0.1 500 2.8 10000");
  }

  thread scripts\sp\maps\highway\highway_utility::player_rigenter(var1, var2, 10, 10, 10, 10);
  var1 scripts\engine\utility::delaycall(var2, &show);
  var0 scripts\common\anim::anim_single_solo(var1, "crash_enter");
  scripts\sp\maps\highway\highway_utility::player_rigexit(var1);

  if(level.player ispcplayer()) {
    setsaveddvar("OMNONNMOTP", "0.1 500 4 10000");
    return;
  }
}

function crash_hadiranimationlogic(var0) {
  var1 = level_gethadir();
  var0 thread scripts\common\anim::anim_single_solo(var1, "crash_exit");
  var2 = scripts\engine\sp\utility::spawn_anim_model("level_hadirGasMask");
  var1 attach("offhand_wm_grenade_mike67", "tag_accessory_right");
  var0 scripts\common\anim::anim_single_solo(var2, "crash_exit");
  level_hadirattachgasmask();
  var2 delete();
  var1 detach("offhand_wm_grenade_mike67", "tag_accessory_right");
}

function crash_getanimationstruct() {
  return scripts\engine\utility::getStruct("crash_animationStruct", "targetname");
}

function gas_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_battlechatter(0);
  var1 = level_spawnhadir();
  var1 scripts\common\utility::demeanor_override("sprint");
  var1 scripts\engine\sp\utility::set_battlechatter(0);
  level_hadirattachgasmask();
  gas_playerpistolweaponlogic();
  level_spawnredshirts();
  scripts\sp\maps\highway\highway_utility::level_setflag(512, 0);
  var2 = level_gethadirtruck();
  var2.origin = (-2046.09, -1181.6, 915.984);
  var2.angles = (15.4519, 85.4758, 1.78625);
  scripts\engine\sp\utility::set_start_location("start_crash", [level.player, var1]);
}

function gas_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("gas");
  var0 = getspawnerarray("gas_aiSpawner");

  foreach(var2 in var0) {
    thread gas_dyingailogic(var2);
  }

  thread gas_allieslogic();
  thread gas_explosionlogic();
  thread gas_playerexposedlogic();
  thread gas_dialoguelogic();
  thread gas_objectivelogic();
  level waittill("gas_playerPassedOutEnd");
  wait 4;
}

function gas_allieslogic() {
  var0 = level_gethadir();
  var1 = level_getfarah();
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var2 = getnode("gas_hadirPath", "targetname");
  var0 thread scripts\sp\spawner::go_to_node(var2);
  var0 scripts\common\utility::clear_demeanor_override();
  var3 = getnode("gas_farahNode", "targetname");
  var1 setgoalnode(var3);
  var1 scripts\common\utility::clear_demeanor_override();
}

function gas_dyingailogic(var0) {
  var1 = getEntArray(var0.target, "targetname");

  foreach(var3 in var1) {
    if(isDefined(var3.target)) {
      var4 = getEntArray(var3.target, "targetname");

      foreach(var6 in var4) {
        var6 endon("trigger");
      }
    }
  }

  scripts\engine\utility::array_any_wait(var1, "trigger");
  var9 = spawnStruct();
  var9.origin = var0.origin;
  var9.angles = var0.angles;
  var10 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var10.animname = "gas_dyingAI" + var10.script_index;
  thread audio_play_bodyfalls_for_htf_anims();
  var10 scripts\common\ai::gun_remove();
  var10 scripts\engine\sp\utility::set_ignoreall(1);
  var10 scripts\engine\sp\utility::set_ignoreme(1);
  var10 endon("damage");
  thread gas_dyingaidamagelogic(var10);
  thread scripts\sp\maps\highway\highway_utility::animation_singleintolastframe(var9, var10, "gas_dying");

  if(!isDefined(var0.script_threshold)) {
    return;
  }

  waitframe();
  var9 scripts\common\anim::anim_set_time_solo(var10, "gas_dying", var0.script_threshold);
}

function audio_play_bodyfalls_for_htf_anims() {
  var0 = self.animname;

  if(var0 == "gas_dyingAI3") {
    scripts\engine\utility::delaycall(1.8, &playsound, "hwy_generic_cough_1_enemy_3");
    scripts\engine\utility::delaycall(3.5, &playsound, "hod_yard_010_death_enemy_02_05");
    scripts\engine\utility::delaycall(5.3, &playsound, "hwy_generic_cough_1_enemy_3");
  }

  if(var0 == "gas_dyingAI1") {
    scripts\engine\utility::delaycall(3, &playsound, "hod_yard_010_death_enemy_02_03");
    scripts\engine\utility::delaycall(1.8, &playsound, "hwy_generic_cough_1_enemy_1");
    return;
  }
}

function gas_dyingaidamagelogic(var0) {
  var0 waittill("damage");
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var0 scripts\engine\sp\utility::ai_ragdoll_immediate();
}

function gas_explosionlogic() {
  var0 = level_gethadirtruck();
  var0 setModel("veh8_civ_lnd_zuniform_static_dst");
  thread gas_explosionsfxlogic(var0.origin);
  var1 = gas_getbarrels();
  var1 = sortbydistance(var1, var0.origin);
  playFX(level._effect["vfx_tear_gas_explosion"], var0.origin);
  earthquake(0.15, 0.5, var0.origin, 50000);
  thread gas_killai();
  var2 = scripts\engine\sp\utility::getallweapons();
  scripts\engine\utility::array_delete(var2);
  var3 = scripts\sp\destructibles\red_barrel::getallredbarrels();

  foreach(var5 in var3) {
    var5 notify("death");
  }
}

function gas_explosionsfxlogic(var0) {
  var1 = spawn("script_origin", var0 + (0, 0, 1));
  var1 playexplosionsound("scn_highway_gas_truck_exp", "exp");
  scripts\engine\utility::delaythread(2, &scripts\engine\utility::play_sound_in_space, "scn_highway_gas_truck_gas_leak", var0);
  wait 10;
  var1 delete();
}

function gas_getbarrels() {
  return getEntArray("gas_barrel", "targetname");
}

function gas_playerpistolweaponlogic() {
  var0 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
  level.player giveweapon(var0, 0, 0, 0, 1);
  level.player switchtoweapon(var0);
  level.player setweaponammostock(var0, 0);
  level.player scripts\common\utility::allow_reload(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\common\utility::allow_weapon_pickup(0);
  level.player scripts\common\utility::allow_weapon_switch(0);
  level.player disableemptyclipweaponswitch(1);
}

function gas_killai() {
  scripts\sp\maps\highway\highway_utility::level_setflag(32, 0);
  scripts\sp\maps\highway\highway_utility::level_setflag(64, 0);
  var0 = getaiarray();
  var1 = level_getheroes();
  var2 = scripts\engine\utility::array_remove_array(var0, var1);

  foreach(var4 in var2) {
    if(istrue(var4.magic_bullet_shield)) {
      var4 scripts\common\ai::stop_magic_bullet_shield();
    }

    if(isDefined(var4.weapon) && !scripts\sp\maps\highway\highway_utility::weapon_empty(var4.weapon)) {
      var4 scripts\common\ai::gun_remove();
    }

    var4 scripts\sp\utility::do_damage(var4.health + 9999, var4.origin, undefined, undefined, "MOD_GRENADE", "molotov");
  }
}

function gas_playerexposedlogic() {
  level.player endon("death");
  visionsetnaked("highway_gas_close", 1.5);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  level.player scripts\common\utility::allow_mount_side(0);
  level.player scripts\common\utility::allow_mount_top(0);
  var0 = "ges_frag_block";

  if(!scripts\sp\maps\highway\highway_utility::weapon_empty(level.player.currentweapon)) {
    level.player scripts\engine\sp\utility::player_gesture_force(var0);
  }

  wait level.player getgestureanimlength(var0);
  thread gas_playerexposedproneimpactlogic();
  thread gas_playerexposedblurlogic();
  thread gas_playerexposedfovlogic();
  thread gas_playerexposedspeedlogic();
  var1 = 0.15;
  var2 = 22 * var1;
  var3 = 1;
  var4 = scripts\sp\hud_util::create_client_overlay("ui_black_circle_vignette", 0);
  var4 fadeovertime(var2);
  var4.alpha = var3;
  var5 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var6 = level.player scripts\engine\utility::spawn_script_origin();
  var6 linkTo(level.player);
  thread gas_playerexposedblackoverlaylogic(var5, var6);
  var7 = gettime();
  var8 = var7 + 22000;
  var9 = getEnt("gas_playerPassOutTrigger", "targetname");
  var10 = ["ges_ph_cough_a", "ges_ph_cough_c", "ges_ph_cough_a", "ges_ph_cough_b", "ges_ph_cough_c"];
  var11 = ["gas_player_cough_1", "gas_player_cough_1", "gas_player_cough_3", "gas_player_cough_3", "gas_player_cough"];
  var12 = var10[0];
  var13 = var10;
  var14 = var11;
  var15 = 0;
  var16 = 500;
  var17 = 200;
  var18 = 1000;
  var19 = 400;
  var20 = 1100;
  var21 = scripts\engine\math::normalize_value(var7, var7 + 22000, gettime());
  var22 = scripts\engine\math::factor_value(var17, var19, var21);
  var23 = scripts\engine\math::factor_value(var18, var20, var21);
  var24 = randomfloatrange(var22, var23);
  var25 = gettime() + var24;

  for(;;) {
    if(level.player istouching(var9)) {
      break;
    }

    var26 = gettime();

    if(var26 >= var8) {
      break;
    }

    var21 = scripts\engine\math::normalize_value(var7, var8, var26);

    if(!var15 && var26 >= var7 + var16) {
      playFXOnTag(level._effect["vfx_tear_gas_screen"], level.player, "tag_origin");
      var15 = 1;
    }

    if(var26 >= var25) {
      if(var13.size) {
        var27 = var13[0];
        level.player thread scripts\sp\player\gestures::player_gestures_input_disable(var27, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1);
        level.player playgestureviewmodel(var27);
        var28 = level.player getgestureanimlength(var27) * 1000;
        var13 = scripts\engine\utility::array_remove(var13, var27);
      } else {
        var28 = 0;
      }

      if(!var15.size) {
        var15 = var12;
      }

      var29 = var15[0];
      level.player playSound(var29);
      level.player playRumbleOnEntity("damage_light");
      var15 = scripts\engine\utility::array_remove(var15, var29);
      var23 = scripts\engine\math::factor_value(var18, var20, var22);
      var24 = scripts\engine\math::factor_value(var19, var21, var22);
      var25 = randomfloatrange(var23, var24);
      var30 = lookupsoundlength(var29);
      var25 += max(var28, var30);
      var26 = gettime() + var25;
    }

    waitframe();
  }

  level notify("gas_playerPassedOutStart");
  thread gas_playerpassoutlogic();
  level waittill("gas_playerPassedOutEnd");
  var5 destroy();
  var6 destroy();
  var7 delete();
  setblur(0, 0);
}

function gas_playerexposedproneimpactlogic() {
  level.player endon("death");
  level endon("gas_playerPassedOutEnd");
  var0 = player_isprone();
  var1 = 0.15;

  for(;;) {
    if(player_isprone() && !var0) {
      wait var1;
      level.player playRumbleOnEntity("damage_heavy");
      earthquake(0.3, 0.5, level.player.origin - (0, 0, 20), 99999);
    }

    var0 = player_isprone();
    waitframe();
  }
}

function gas_playerexposedblurlogic() {
  level.player endon("death");
  level endon("gas_playerPassedOutEnd");
  var0 = 3.5;
  var1 = 5;
  var2 = 2;
  var3 = 2.5;
  var4 = 0.55;
  var5 = 0.65;
  var6 = 1.1;
  var7 = 1.25;

  for(;;) {
    var8 = randomfloatrange(var2, var3);
    var9 = randomfloatrange(var4, var5);
    setblur(var8, var9);
    wait var9;
    var10 = randomfloatrange(var6, var7);
    setblur(0, var10);
    wait var10;
    var11 = randomfloatrange(var0, var1);
    wait var11;
  }
}

function gas_playerexposedfovlogic() {
  level.player endon("death");
  level endon("gas_playerPassedOutEnd");
  var0 = gettime();
  var1 = var0 + 22000;
  var2 = 55;
  var3 = 65;
  var4 = 4;
  var5 = 6;
  var6 = 5;
  var7 = 7;
  var8 = 0;

  for(;;) {
    var9 = gettime();
    var10 = scripts\engine\math::normalize_value(var0, var1, var9);
    var11 = 1 - var10;
    var12 = sin(var8);
    var13 = scripts\engine\math::factor_value(var4, var5, var10);
    var14 = var12 * var13;
    var15 = scripts\engine\math::factor_value(var2, var3, var11);
    var16 = var15 + var14;
    level.player modifybasefov(var16, 0.05);
    var17 = scripts\engine\math::factor_value(var6, var7, var10);
    var8 = scripts\engine\math::wrap(0, 360, var8 + var17);
    waitframe();
  }
}

function gas_playerexposedspeedlogic() {
  level.player endon("death");
  level endon("gas_playerPassedOutEnd");
  var0 = 85;
  var1 = 0.3;
  var2 = 22 * var1;
  scripts\engine\sp\utility::player_speed_set(var0, var2);
}

function gas_playerexposedblackoverlaylogic(var0, var1) {
  level.player endon("death");
  level endon("gas_playerPassedOutEnd");
  var2 = gettime();
  var3 = var2 + 22000;
  var4 = 0.5;
  var5 = 6;
  var6 = 0.5;
  var7 = 0.7;
  var8 = 0.05;
  var9 = 0.3;
  var10 = 0.5;
  var11 = 1.2;
  var12 = 0.5;
  var13 = 1;

  for(;;) {
    var14 = gettime();
    var15 = scripts\engine\math::normalize_value(var2, var3, var14);
    var16 = 1 - var15;
    var17 = scripts\engine\math::factor_value(var4, var5, var16);
    var18 = scripts\engine\math::factor_value(var6, var7, var15);
    var19 = scripts\engine\math::factor_value(var8, var9, var15);
    wait var17;
    var0 fadeovertime(var18);
    var20 = scripts\engine\math::factor_value(var12, var13, var15);
    var0.alpha = var20;
    wait var18;
    var1 playSound("gas_heartbeat");
    level.player playRumbleOnEntity("damage_heavy");
    wait var19;
    var21 = scripts\engine\math::factor_value(var10, var11, var15);
    var0 fadeovertime(var21);
    var0.alpha = 0;
    wait var21;
  }
}

function gas_playerpassoutlogic() {
  var0 = "ges_stumble_2";
  var1 = 1.5;
  level.player scripts\common\utility::allow_mantle(0);
  level.player scripts\common\utility::allow_sprint(0);
  level.player scripts\common\utility::allow_fire(0);
  level.player scripts\common\utility::allow_reload(0);
  level.player scripts\common\utility::allow_weapon_switch(0);
  level.player scripts\common\utility::allow_ads(0);
  level.player scripts\common\utility::allow_melee(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  wait var1 - 0.5;
  level.player playSound("player_death_generic");
  level.player setsoundsubmix("sp_hwy_fade_outs", 7, 1);
  wait 0.5;
  level.player giveweapon("iw8_gunless");
  level.player switchtoweapon("iw8_gunless");
  level.player allowcrouch(0);
  level.player allowstand(0);
  var2 = 1;
  wait var2;
  var3 = 2;
  var4 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var4 fadeovertime(var3);
  var4.alpha = 1;
  wait var3;
  level notify("gas_playerPassedOutEnd");
  level.player allowstand(1);
  level.player allowprone(0);
  wait 4;
  var4 destroy();
}

function gas_getplayermask() {
  return getEnt("gas_playerGasMask", "targetname");
}

function gas_dialoguelogic() {
  var0 = level_getfarah();
  var1 = level_gethadir();
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_gas_truck_60", 6.5);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_gas_truck_65", 0.5);
  var0 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_gas_truck_70", 0.5);
  var1 scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_had_gas_truck_72", 0.5);
}

function gas_objectivelogic() {
  level.player scripts\sp\player::set_focus_objectives_update_display(0);
  level.player scripts\sp\player::set_focus_infinite_hold(0);
  scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_GET_GAS_MASK", (784, -2088, 928), &"HIGHWAY/LABEL_GAS_MASK");
}

function gas_getanimationstruct() {
  return scripts\engine\utility::getStruct("gas_animationStruct", "targetname");
}

function drag_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_battlechatter(0);
  var1 = level_spawnhadir();
  var1 scripts\engine\sp\utility::set_battlechatter(0);
  level_hadirattachgasmask();
  visionsetnaked("highway_gas_close", 0);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  level.player giveweapon("iw8_gunless");
  level.player switchtoweapon("iw8_gunless");
  thread audio_post_gas();
}

function drag_main() {
  level.player clearsoundsubmix("sp_hwy_fade_outs", 7);
  level.player setsoundsubmix("sp_hwy_amb_scn_lpf", 1, 1);
  scripts\sp\maps\highway\highway_utility::level_deletepreviousobjective();
  scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SURVIVE");
  var0 = level_getfarah();
  var1 = level_gethadir();
  scripts\sp\maps\highway\highway_utility::ai_setname(var1, "");
  scripts\sp\maps\highway\highway_utility::ai_setname(var0, "");
  setsaveddvar("NLPLNQSNNR", 0.05);
  var2 = scripts\sp\hud_util::create_client_overlay("black", 1);
  var3 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var4 = scripts\sp\hud_util::create_client_overlay("ui_black_circle_vignette", 1);
  thread drag_playerfovlogic();
  thread drag_playerblurlogic();
  thread drag_playerblackoverlaylogic(var3);
  var5 = scripts\engine\utility::getStruct("drag_animationStruct", "targetname");
  var6 = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  level.player hidelegsandshadow();
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  var7 = scripts\engine\sp\utility::spawn_anim_model("drag_playerGasMask");
  var5 scripts\common\anim::anim_first_frame_solo(var6, "bunker_sceneBEnter");
  thread scripts\sp\maps\highway\highway_utility::player_rigenter(var6, 0, 0, 0, 0, 0);
  var5 thread scripts\common\anim::anim_single([var6, var7, var1], "drag_enter");
  thread drag_playergasmaskoverlaylogic(var1);
  var8 = 1;
  var2 fadeovertime(var8);
  var2.alpha = 0;
  var9 = var6 scripts\engine\utility::getanim("drag_enter");
  var10 = getanimlength(var9);
  var11 = 2;
  wait var10 - var11;
  var2 fadeovertime(var11);
  var2.alpha = 1;
  wait var11;
  level notify("drag_end");
  wait 1.5;
  var2 destroy();
  var3 destroy();
  var4 destroy();
  level.player modifybasefov(65, 0.05);
  setblur(0, 0);
  scripts\sp\maps\highway\highway_utility::player_rigexit(var6);
  var7 scripts\engine\sp\utility::anim_stopanimScripted();
  var7 linktoplayerview(level.player, "tag_camera", (0, 0, 0), (0, 0, 0), 1);
}

function drag_playergasmaskoverlaylogic(var0) {
  scripts\sp\maps\highway\highway_utility::animation_waittillnotetrack(var0, "drag_overlay");
  level.player setsoundsubmix("sp_hwy_fade_outs", 9, 1);
  player_putgasmaskon();
}

function drag_playerblurlogic() {
  level endon("drag_end");
  var0 = 2;
  wait var0;
  var1 = 2;
  var2 = 3;
  var3 = 2;
  var4 = 2.5;
  var5 = 0.55;
  var6 = 0.65;
  var7 = 1.1;
  var8 = 1.25;

  for(;;) {
    var9 = randomfloatrange(var3, var4);
    var10 = randomfloatrange(var5, var6);
    setblur(var9, var10);
    wait var10;
    var11 = randomfloatrange(var7, var8);
    setblur(0, var11);
    wait var11;
    var12 = randomfloatrange(var1, var2);
    wait var12;
  }
}

function drag_playerfovlogic() {
  level endon("drag_end");
  var0 = 60;
  level.player modifybasefov(var0, 0.05);
  level.player lerpfovscalefactor(0, 0.05);
  var1 = 1.4;
  wait var1;
  var2 = 7;
  var3 = 3;
  var4 = 0;

  for(;;) {
    var5 = sin(var4);
    var6 = var5 * var2;
    var7 = var0 + var6;
    level.player modifybasefov(var7, 0.05);
    var4 = scripts\engine\math::wrap(0, 360, var4 + var3);
    waitframe();
  }
}

function drag_playerblackoverlaylogic(var0) {
  level endon("drag_end");
  var1 = 2;
  wait var1;
  var2 = 0.5;
  var3 = 2;
  var4 = 0.5;
  var5 = 0.7;
  var6 = 0.05;
  var7 = 0.3;
  var8 = 0.5;
  var9 = 1.2;
  var10 = 0.5;
  var11 = 1;

  for(;;) {
    var12 = randomfloatrange(var2, var3);
    wait var12;
    var13 = randomfloatrange(var4, var5);
    var0 fadeovertime(var13);
    var14 = randomfloatrange(var10, var11);
    var0.alpha = var14;
    wait var13;
    var15 = randomfloatrange(var6, var7);
    wait var15;
    var16 = randomfloatrange(var8, var9);
    var0 fadeovertime(var16);
    var0.alpha = 0;
    wait var16;
  }
}

function bunker_start() {
  var0 = level_spawnfarah();
  var0 scripts\engine\sp\utility::set_battlechatter(0);
  var1 = level_spawnhadir();
  var1 scripts\engine\sp\utility::set_battlechatter(0);
  scripts\engine\sp\utility::set_start_location("start_bunker", [level.player, var0, var1]);
  level_hadirattachgasmask();
  player_givefullloadout();
  scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_SURVIVE");
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  thread audio_post_gas();
}

function bunker_main() {
  level.player setclienttriggeraudiozone("highway_ending_05", 1);
  level.player clearsoundsubmix("sp_hwy_fade_outs", 3);
  visionsetnaked("highway_gas_bunker");
  thread scripts\sp\maps\highway\highway_lighting::lighting_bunker();
  thread bunker_blackoverlaylogic();
  scripts\engine\sp\utility::transient_unload("highway_main_tr");
  setsaveddvar("MMLNNQSTTL", 0);
  scripts\engine\utility::exploder("gas_bunker");
  scripts\engine\utility::delaythread(0.05, &scripts\engine\sp\utility::nextmission_preload, "full", 1);
  level_closebunkerouterdoor();
  bunker_outrologic();

  while(!ispreloadzonescomplete()) {
    waitframe();
  }

  scripts\engine\sp\utility::nextmission();
}

function bunker_blackoverlaylogic() {
  var0 = scripts\sp\hud_util::create_client_overlay("black", 1);
  var1 = 1;
  wait var1;
  var2 = 1;
  var0 fadeovertime(var2);
  var0.alpha = 0;
}

function bunker_outrologic() {
  var0 = level_getfarah();
  var1 = level_gethadir();
  var2 = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  scripts\sp\maps\highway\highway_utility::ai_setname(var1, "");
  scripts\sp\maps\highway\highway_utility::ai_setname(var0, "");

  if(isDefined(var0.hatmodel)) {
    var0 detach(var0.hatmodel);
  }

  scripts\sp\maps\highway\highway_utility::ai_attachhead(var0, "head_hero_farah_gasmask");
  var0 scripts\common\ai::gun_remove();
  var0.anim_playvo_func = &scripts\engine\utility::playsoundontag;
  var1.anim_playvo_func = &scripts\engine\utility::playsoundontag;
  var3 = gas_getanimationstruct();
  var3 scripts\common\anim::anim_first_frame_solo(var2, "bunker_sceneBEnter");
  thread scripts\sp\maps\highway\highway_lighting::lighting_dof_bunker();
  thread scripts\sp\maps\highway\highway_utility::player_rigenter(var2, 0, 0, 0, 0, 0);
  var4 = 2;
  level.player lerpviewangleclamp(var4, 0, 0, 15, 15, 15, 0);
  level.player springcamenabled(var4, 3, 1);
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var1);
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\highway\highway_utility::animation_stoploop(var0);
  thread scripts\sp\maps\highway\highway_utility::animation_singleintolastframe(var3, var2, "bunker_sceneBEnter");
  thread scripts\sp\maps\highway\highway_utility::animation_singleintolastframe(var3, var0, "bunker_sceneBEnter");
  thread scripts\sp\maps\highway\highway_utility::animation_singleintolastframe(var3, var1, "bunker_sceneBEnter");
  level.player scripts\engine\utility::delaycall(30, &setsoundsubmix, "sp_hwy_fade_out_mus", 17);
  var2 waittillmatch("single anim", "bunker_fade_out");
  level.player clearpriorityclienttriggeraudiozone("deathsdoor");
  level.player clearsoundsubmix("deaths_door_sp", 2.5);
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 3.5);
  level.player clearsoundsubmix("sp_hwy_amb_scn_lpf", 5);
  var5 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var5.sort = 5;
  var5 fadeovertime(3);
  var5.alpha = 1;
  level.player springcamdisabled(0);
  var0.anim_playvo_func = undefined;
  var1.anim_playvo_func = undefined;
  wait 3;
}

function player_givefullloadout() {
  player_givesecondaryweapon();
  player_giveballisticsweapon();
  player_givesecondaryoffhandweapon();
}

function player_isprone() {
  return level.player getstance() == "prone";
}

function player_zoomedin() {
  return level.player.zoomedin;
}

function player_zoomedout() {
  return !level.player.zoomedin;
}

function player_throwingmolotov() {
  return level.player fragButtonPressed() && scripts\engine\utility::is_equal(level.player.offhandweapon, player_getoffhandsecondaryweaponobject());
}

function player_giveballisticsweapon() {
  var0 = player_getballisticsweaponobject();
  level.player giveweapon(var0);
  level.player switchtoweapon(var0);
  level.player setweaponammostock(var0, weaponmaxammo(var0));
}

function player_givesecondaryweapon() {
  var0 = player_getsecondaryweaponobject();
  level.player giveweapon(var0);
  level.player switchtoweapon(var0);
}

function player_giveprimaryoffhandweapon() {
  level.player scripts\engine\sp\utility::give_offhand("frag");
  level.player setweaponammoclip("frag", 2);
}

function player_givesecondaryoffhandweapon() {
  level.player scripts\engine\sp\utility::give_offhand("molotov");
  level.player givemaxammo("molotov");
}

function player_getballisticsweaponobject() {
  return scripts\sp\utility::make_weapon_special("hadir_sniper");
}

function player_holdingballisticsweapon() {
  return level.player.currentweapon == player_getballisticsweaponobject();
}

function player_getdroppedsniper() {
  return getEnt("ballistics_weaponDropped", "targetname");
}

function player_fullads() {
  return level.player playerads() == 1;
}

function player_getprimaryweaponname() {
  return "iw8_sn_hdromeo_ballistics+back_hdromeo|1+bipod_hdromeo_ballistics+front_hdromeo|1+mag_hdromeo|1+rec_hdromeo|1+vzscope_hdromeo_ballistics";
}

function player_getsecondaryweaponobject() {
  return scripts\sp\utility::make_weapon("iw8_ar_akilo47");
}

function player_getoffhandsecondaryweaponobject() {
  return getcompleteweaponname("molotov");
}

function player_ontownrooftop(var0) {
  var1 = player_gettouchingtownrooftoptrigger(var0);
  return isDefined(var1);
}

function player_gettouchingtownrooftoptrigger(var0) {
  var1 = level_gettownrooftoptriggers(var0);

  foreach(var3 in var1) {
    if(level.player istouching(var3)) {
      return var3;
    }
  }

  return undefined;
}

function player_putgasmaskon(var0) {
  var1 = scripts\sp\hud_util::create_client_overlay("gasmask_overlay_delta2", 1);
  var1 fadeovertime(0.25);
  var1.alpha = 1;
  var1.lowresbackground = 1;
}

function player_getflag(var0) {
  return level.player.flags &var0;
}

function player_setflag(var0, var1) {
  if(var1) {
    level.player.flags |= var0;
    return;
  }

  level.player.flags &= ~var0;
}

function player_trackvariablezoom() {
  level.player endon("death");
  level.player.zoomedin = 0;
  thread player_trackadsfullout();
  thread player_setsunshadowsforzoom();

  for(;;) {
    var0 = level.player scripts\engine\utility::waittill_any_return("sprint_pressed", "player_fullyReleasedADS");

    if(scripts\engine\utility::is_equal(var0, "sprint_pressed") && player_fullads() && player_holdingballisticsweapon()) {
      level.player.zoomedin = !level.player.zoomedin;

      if(level.player.zoomedin) {
        level.player notify("player_variableZoomedIn");
      }

      continue;
    }

    if(scripts\engine\utility::is_equal(var0, "player_fullyReleasedADS") && player_holdingballisticsweapon()) {
      level.player.zoomedin = 0;
    }
  }
}

function player_setsunshadowsforzoom() {
  var0 = level.sunsamplesizenear;
  var1 = level.suncascademult1;
  var2 = level.suncascademult2;
  var3 = level.sunsamplesizenear;
  var4 = 0;

  for(;;) {
    var5 = level.player playerads();
    var6 = scripts\engine\utility::ter_op(level.player.zoomedin, 0.2, -0.2);
    var4 += var6;
    var4 = clamp(var4, 0, 1);

    if(var5 > 0.7 && player_holdingballisticsweapon()) {
      if(var4 > 0.5) {
        var0 = 1.7;
        var1 = 2;
        var2 = 2;
      } else {
        var0 = 1.3;
        var1 = 2;
        var2 = 2;
      }
    } else {
      var0 = level.sunsamplesizenear;
      var1 = level.suncascademult1;
      var2 = level.suncascademult2;
    }

    if(var3 != var0) {
      setsaveddvar("NPONLLLSPL", var0);
      setsaveddvar("LSNRQTOKRR", var1);
      setsaveddvar("NTLKNLNPLK", var2);
      var3 = var0;
    }

    waitframe();
  }
}

function player_trackadsfullout() {
  var0 = level.player playerads();

  for(;;) {
    var1 = level.player playerads();

    if(!var1 && var0) {
      level.player notify("player_fullyReleasedADS");
    }

    var0 = var1;
    waitframe();
  }
}

function player_dropballisticsweaponlogic() {
  for(;;) {
    level.player waittill("pickup", var0, var1);

    if(!isDefined(var1)) {
      continue;
    }

    var2 = "weapon_";
    var3 = getsubstr(var1.classname, 0, var2.size + "iw8_sn_hdromeo_ballistics".size) == var2 + "iw8_sn_hdromeo_ballistics";

    if(!var3) {
      continue;
    }

    var4 = player_getballisticsweaponobject();
    var5 = spawn("script_model", var1.origin);
    var5.angles = var1.angles;
    var5 setModel(getweaponmodel(var4));
    var6 = getweaponattachmentworldmodels(var4);

    foreach(var8 in var6) {
      var5 attach(var8);
    }

    thread player_dropballisticsweaponinteractlogic(var5, var4);
    var1 delete();
  }
}

function player_dropballisticsweaponinteractlogic(var0, var1) {
  var0 endon("entitydeleted");
  var0.targetname = "ballistics_weaponDropped";
  var2 = var0 physics_getentitycenterofmass()["unscaled"] + (0, 0, 5);
  var3 = spawnStruct();
  var3.origin = var2;
  var3 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), undefined, undefined, undefined, 80, 1);
  var3 waittill("trigger");
  var4 = level.player.currentweapon;

  if(scripts\sp\maps\highway\highway_utility::weapon_empty(var4)) {
    var4 = level.player.primaryweapons[0];
  }

  level.player takeweapon(var4);
  var5 = spawn("weapon_" + createheadicon(var4), var2);
  var5.angles = var0.angles;
  level.player giveweapon(var1, 0, 0, 0, 1);
  level.player switchtoweapon(var1);
  var0 delete();
}

function player_sniperzoomedin() {
  return player_holdingballisticsweapon() && player_fullads() && level.player.zoomedin;
}

function vehicle_spawnsuicidetruck(var0, var1) {
  var2 = scripts\common\utility::getvehiclespawner(var0, "targetname");
  var3 = var2 scripts\common\utility::spawn_vehicle();
  var3.targetname = var1;
  var3.dontunloadonend = 1;
  var3 notsolid();
  var3 scripts\common\vehicle::godon();
  var3 vehicle_teleport(var2.origin, var2.angles);
  var3.armorplates = [];
  var3.driverwindow = undefined;
  var4 = getEntArray(var2.target, "targetname");

  foreach(var6 in var4) {
    if(isai(var6)) {
      continue;
    }

    var7 = var6.origin - var2.origin;
    var6.origin = var3.origin + var7;

    if(scripts\engine\utility::is_equal(var6.script_noteworthy, "vehicle_engineBlock")) {
      var6.ballisticdontpenetrate = 1;
      var6 linkTo(var3);
      var3.engineblock = var6;
    }

    if(scripts\engine\utility::is_equal(var6.script_noteworthy, "vehicle_suicideTruckArmor")) {
      var6.ballisticdontpenetrate = 1;
      var6 linkTo(var3);
      var8 = getEntArray(var6.target, "targetname");

      foreach(var10 in var8) {
        var10 linkTo(var3, "tag_body_animate");
        level.ballistics.ignoreentities = scripts\engine\utility::array_add(level.ballistics.ignoreentities, var10);
      }

      var3.armorplates = scripts\engine\utility::array_add(var3.armorplates, var6);
    }

    if(scripts\engine\utility::is_equal(var6.script_noteworthy, "vehicle_suicideTruckDriverWindow")) {
      var6.ballisticdontpenetrate = 1;
      var6 linkTo(var3);
      var3.driverwindow = var6;
    }
  }

  return var3;
}

function vehicle_suicidetrucklogic(var0) {
  var0 endon("vehicle_disabled");

  foreach(var2 in var0.armorplates) {
    thread vehicle_suicidetruckarmorlogic(var2, var0);
  }

  thread vehicle_suicidetruckcrashlogic(var0);
  thread vehicle_suicidetruckengineblocklogic(var0);
  thread vehicle_suicidetruckriderslogic(var0);
  thread vehicle_suicidetruckrunoverlogic(var0);
  thread scripts\common\vehicle_paths::gopath(var0);
  var0 playSound("scn_highway_suicide_truck_ridge_01");
  var0 waittill("reached_end_node");
  vehicle_suicidetruckexplode(var0, 1);
}

function suicide_musiclogic() {
  var0 = 1.5;
  var1 = level scripts\engine\utility::waittill_notify_or_timeout_return("vehicle_suicideTruckExplode", var0);

  if(var1 == "vehicle_suicideTruckExplode") {
    return;
  }

  setmusicstate("mx_highway_suicidetruck");
  level waittill("vehicle_suicideTruckExplode");
  setmusicstate("");
}

#using_animtree("");

function vehicle_suicidetruckcrashlogic(var0) {
  var0 endon("reached_end_node");
  level endon("vehicle_suicideTruckExplode");
  var0 waittill("vehicle_disabled");
  var0 setanim(%hod_vehicle_crash_truck);
  var0 playLoopSound("veh_suicide_truck_highway_engine_high_crash");
  var1 = var0.currentnode;

  if(!isDefined(var1.target)) {
    thread vehicle_suicidetruckexplode(var0, 0);
    return;
  }

  var2 = getvehiclenode(var1.target, "targetname");
  var3 = undefined;
  var4 = scripts\engine\math::scalar_projection(anglesToForward(var0.angles), var1.origin - var0.origin);
  var5 = scripts\engine\math::scalar_projection(anglesToForward(var0.angles), var2.origin - var0.origin);
  var6 = max(var4, var5);

  if(var6 == var4) {
    var3 = var1;
  } else if(var6 == var5) {
    var3 = var2;
  }

  if(isDefined(var3)) {
    var7 = vehicle_findnextcrashpath(var0, var3);

    if(isDefined(var7)) {
      var8 = var0 vehicle_getspeed();
      var0 scripts\common\vehicle::vehicle_switch_paths(var3, var7);
      var0 vehicle_setspeed(var8 + 10, 1, 1);

      if(var7.origin == (-3516, 5352, -337.664)) {
        var0 thread scripts\engine\sp\utility::notify_delay("reached_end_node", 2);
      }

      thread vehicle_suicidetruckexplodeoncrashpathend(var0);
      return;
    }

    thread vehicle_suicidetruckexplode(var0, 0);
    return;
  }
}

function vehicle_suicidetruckexplodeoncrashpathend(var0) {
  var0 waittill("reached_end_node");
  vehicle_suicidetruckexplode(var0, 0);
}

function vehicle_suicidetruckengineblocklogic(var0) {
  var0.engineblock waittill("ballistics_bulletDamage", var1);

  if(var0 scripts\engine\math::is_point_on_right(var1)) {
    var0 setanim(%hod_vehicle_hit_l_truck);
  } else {
    var0 setanim(%hod_vehicle_hit_r_truck);
  }

  var2 = 15;
  var3 = -15;
  var4 = var0 gettagorigin("TAG_HOOD");
  var4 += anglesToForward(var0.angles) * var2;
  var4 += anglestoup(var0.angles) * var3;
  var5 = scripts\engine\utility::spawn_tag_origin(var4);
  var5 linkTo(var0);
  var0 hidepart("TAG_HOOD");
  playFXOnTag(level._effect["vfx_suicide_truck_disable"], var5, "tag_origin");
  var0 thread scripts\engine\sp\utility::play_sound_on_tag("scn_highway_truck_engine_block_destr", "tag_origin");

  foreach(var7 in var0.armorplates) {
    if(!scripts\engine\utility::is_equal(var7.script_parameters, "vehicle_suicideTruckArmorDisabledLaunch")) {
      continue;
    }

    var8 = getEntArray(var7.target, "targetname");

    foreach(var10 in var8) {
      vehicle_suicidetrucklaunchmesh(var0, var10);
    }

    var7 delete();
    var0.armorplates = scripts\engine\utility::array_remove(var0.armorplates, var7);
  }

  var13 = var0 vehicle_getspeed();

  if(var13) {
    var0 thread scripts\engine\sp\utility::play_sound_on_tag("scn_highway_truck_engine_block_die", "tag_origin");
  }

  var0 notify("vehicle_disabled", 0);
}

function vehicle_suicidetruckarmorlogic(var0, var1) {
  var1 endon("reached_end_node");
  var0 endon("death");
  var0 waittill("ballistics_bulletDamage", var2);
  level notify("vehicle_suicideTruckArmorBreak");
  var1 clearanim(%hod_vehicle_hit_l_truck, 0);
  var1 clearanim(%hod_vehicle_hit_r_truck, 0);

  if(var0 scripts\engine\math::is_point_on_right(var2)) {
    var1 setanim(%hod_vehicle_hit_l_truck);
  } else {
    var1 setanim(%hod_vehicle_hit_r_truck);
  }

  var3 = var0.origin + anglesToForward(var1.angles) * var1 vehicle_getspeed();
  playFX(level._effect["vfx_suicide_truck_armor_break"], var3, anglesToForward(var1.angles) * -1, anglestoup(var1.angles));
  thread scripts\engine\utility::play_sound_in_space("scn_highway_suicide_truck_armor_destr", var3);
  var1.armorplates = scripts\engine\utility::array_remove(var1.armorplates, var0);
  var4 = getEntArray(var0.target, "targetname");

  foreach(var6 in var4) {
    vehicle_suicidetrucklaunchmesh(var1, var6);
  }

  var0 delete();
}

function vehicle_suicidetrucklaunchmesh(var0, var1) {
  var1 unlink();
  var2 = vectorNormalize(var1.origin - var0.origin);
  var2 = scripts\engine\utility::flatten_vector(var2);
  var1 physicslaunchserver(var1.origin, var2 * 15000);
}

function vehicle_suicidetruckriderslogic(var0) {
  var0 endon("reached_end_node");
  var1 = var0 scripts\engine\sp\utility::get_linked_spawners()[0];
  var2 = var1 scripts\engine\sp\utility::spawn_ai(1, 1);
  var2 linkTo(var0, "tag_driver", (0, 0, 0), (0, 0, 0));
  var2.ridingvehicle = var0;
  var2.script_parameters = "ballistics_doNotDamage";
  var0.riders = [var2];
  var2 scripts\engine\sp\utility::set_ignoreme(1);
  var2 scripts\engine\sp\utility::set_ignoreall(1);
  var3 = "head_al_qatala_2_cqc";
  var2 detach(var2.headmodel);
  var2.headmodel = var3;
  var2 attach(var2.headmodel, "", 1);
  var4 = 4;
  var5 = 1;
  var6 = var0 gettagorigin("tag_driver");
  var7 = var0 gettagangles("tag_driver");
  var6 += anglesToForward(var7) * var4;
  var6 += anglestoup(var7) * var5;
  var8 = scripts\engine\utility::spawn_script_origin(var6, var7);
  var8 linkTo(var0);
  var2.animname = "suicide_driver";
  var8 thread scripts\common\anim::anim_first_frame_solo(var2, "suicide_driverIdle");
  thread scripts\sp\maps\highway\highway_utility::animation_loop(var8, var2, "suicide_driverIdle");
  thread vehicle_suicidetruckdriverandanimationcleanup(var0, var2, var8);
  scripts\engine\utility::waittill_any_ents(var0.driverwindow, "ballistics_bulletDamage", var2, "ballistics_bulletDamage", var2, "death");
  var0 notify("vehicle_disabled", 1);
  var9 = 4;
  var10 = 10;
  var11 = var0 gettagorigin("tag_driver");
  var12 = var0 gettagangles("tag_driver");
  var11 += anglesToForward(var12) * var9;
  var11 += anglestoup(var12) * var10;
  var8 = scripts\engine\utility::spawn_script_origin(var11, var12);
  var8 linkTo(var0);
  thread vehicle_suicidetruckdriverandanimationcleanup(var0, var2, var8);
  playFX(level.g_effect["vfx_gib_explode"], var2 gettagorigin("j_head"));
  var8 thread scripts\common\anim::anim_first_frame_solo(var2, "suicide_driverDeath");
  thread scripts\sp\maps\highway\highway_utility::animation_singleintolastframe(var8, var2, "suicide_driverDeath");
  scripts\sp\utility::giveachievement_wrapper("driversed");
}

function vehicle_suicidetruckdriverandanimationcleanup(var0, var1, var2) {
  var0 waittill("entitydeleted");

  if(isDefined(var1) && isalive(var1)) {
    var1 scripts\common\ai::stop_magic_bullet_shield();
    var1 delete();
  }

  if(isDefined(var2)) {
    var2 delete();
    return;
  }
}

function vehicle_suicidetruckrunoverlogic(var0) {
  var0 endon("reached_end_node");
  var0 endon("vehicle_disabled");

  for(;;) {
    var1 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
    var1 = scripts\engine\utility::array_remove_array(var1, var0.riders);

    foreach(var3 in var1) {
      if(distancesquared(var3.origin, var0.origin) <= 12544) {
        var3 kill();
      }
    }

    waitframe();
  }
}

function vehicle_suicidetruckexplode(var0, var1) {
  var2 = var0.origin;
  level notify("vehicle_suicideTruckExplode");
  var0 clearanim(%hod_vehicle_hit_r_truck, 0);
  var0 setanim(%hod_vehicle_hit_r_truck);
  thread vehicle_suicidetrucksfxlogic(var2);

  foreach(var4 in var0.armorplates) {
    var5 = getEntArray(var4.target, "targetname");

    foreach(var7 in var5) {
      vehicle_suicidetrucklaunchmesh(var0, var7);
    }

    var4 delete();
    var0.armorplates = scripts\engine\utility::array_remove(var0.armorplates, var4);
  }

  var10 = vectorNormalize(level.player getEye() - var2);
  playFX(level._effect["vfx_suicidetruck_explosion"], var2, var10);
  var11 = distance(level.player.origin, var2);
  var12 = var11 / 10000;
  var13 = scripts\engine\math::normalize_value(0, 15000, var11);
  var14 = scripts\engine\math::factor_value(0.225, 0.325, var13);
  var15 = scripts\engine\math::factor_value(1.7, 3.2, var13);
  var16 = scripts\engine\math::factor_value(3, 4, var13);

  if(isDefined(var0.engineblock)) {
    var0.engineblock delete();
  }

  var0 delete();
  wait var12;
  earthquake(var14, var15, var2, 50000);
  playrumbleonposition("damage_heavy", var2);
  level.player shellshock("explosion", var16);

  if(var1) {
    var17 = level_getfarah();
    var17 thread scripts\sp\maps\highway\highway_utility::dialogue("dx_vom_far_svbied_truck_110");
    level.player kill();
    wait 1;
    var18 = scripts\sp\hud_util::create_client_overlay("black", 0, level.player);
    var18 fadeovertime(0.3);
    var18.alpha = 1;
    return;
  }

  wait var16;
  level notify("vehicle_suicideShellshockOver");
}

function vehicle_suicidetrucksfxlogic(var0) {
  thread vehicle_suicidetruckfiresfxlogic(var0);
  var1 = spawn("script_origin", var0 + (0, 0, 1));
  var1 playexplosionsound("scn_highway_suicide_truck_expl", "exp");
  wait 10;
  var1 delete();
}

function vehicle_suicidetruckfiresfxlogic(var0) {
  wait 2;
  var1 = spawn("script_origin", var0 + (0, 200, 15));
  var1 playLoopSound("scn_highway_suicide_truck_fire_lp");
}

function vehicle_spawnvindias(var0, var1) {
  var2 = scripts\common\utility::getvehiclespawnerarray(var0, "targetname");
  var3 = [];

  foreach(var5 in var2) {
    var6 = var5 scripts\common\utility::spawn_vehicle();
    var6.targetname = var1;
    var6.dontunloadonend = 1;
    var6.donotunloadondriverdeath = 1;
    var6 notsolid();
    var6 scripts\common\vehicle::godon();
    var6 vehicle_teleport(var5.origin, var5.angles);
    var6 hide();
    var6 scripts\engine\utility::ent_flag_set("no_riders_until_unload");
    scripts\engine\utility::array_delete(var6.mgturret);
    var6.mesh = spawn("script_model", var6.origin);
    var6.mesh.angles = var6.angles;
    var6.mesh setModel("veh8_mil_lnd_vindia_a2");
    var6.mesh notsolid();
    var6.mesh linkTo(var6);
    var7 = ["TAG_WHEEL_CENTER_FRONT_LEFT", "TAG_WHEEL_CENTER_MIDDLE_LEFT", "TAG_WHEEL_CENTER_BACK_LEFT", "TAG_WHEEL_CENTER_FRONT_RIGHT", "TAG_WHEEL_CENTER_MIDDLE_RIGHT", "TAG_WHEEL_CENTER_BACK_RIGHT"];

    foreach(var9 in var7) {
      var6.mesh hidepart(var9);
    }

    var6.tireclips = [];
    var11 = getEntArray(var5.target, "targetname");

    foreach(var13 in var11) {
      if(isai(var13)) {
        continue;
      }

      var14 = var13.origin - var5.origin;
      var15 = rotatevectorinverted(var14, var5.angles);
      var16 = var13.angles - var5.angles;
      var13 linkTo(var6.mesh, "TAG_ORIGIN_ANIMATE", var15, var16);

      if(scripts\engine\utility::is_equal(var13.script_noteworthy, "vehicle_vindiaTire")) {
        var13.ballisticdontpenetrate = 1;
        var6.tireclips = scripts\engine\utility::array_add(var6.tireclips, var13);
      }

      if(scripts\engine\utility::is_equal(var13.script_noteworthy, "vehicle_vindiaBodyClip")) {
        var13.ballisticdontpenetrate = 1;
        var6.bodyclip = var13;
      }
    }

    thread vehicle_vindiaspeeduplogic(var6);
    thread vehicle_vindiadamagelogic(var6);
    thread vehicle_vindiasmokegrenadelogic(var6, 1);
    thread vehicle_vindiaunloadlogic(var6);
    thread vehicle_vindiameshanimlogic(var6);
    var3 = scripts\engine\utility::array_add(var3, var6);
  }

  return var3;
}

function vehicle_vindiameshanimlogic(var0) {
  thread vehicle_vindiameshanimdrivelogic(var0);
  thread vehicle_vindiameshanimunloadlogic(var0);
}

function vehicle_vindiameshanimdrivelogic(var0) {
  var0 endon("reached_wait_speed");
  thread vehicle_vindiameshanimdrivecleanuplogic(var0);
  var0.mesh useanimtree(#animtree);

  for(;;) {
    var1 = level.vehicle.templates.driveidle[var0.model];

    if(var0 vehicle_getspeed()) {
      var0.mesh setanim(var1);
      wait getanimlength(var1);
      continue;
    }

    var0.mesh clearanim(var1, 0);
    waitframe();
  }
}

function vehicle_vindiameshanimdrivecleanuplogic(var0) {
  var0 waittill("reached_wait_speed");
  var1 = level.vehicle.templates.driveidle[var0.model];
  var0.mesh clearanim(var1, 0);
}

function vehicle_vindiameshanimunloadlogic(var0) {
  var0 waittill("unloading");
  var1 = level.vehicle.templates.driveidle[var0.model];
  var0.mesh clearanim(var1, 0.25);
  var0.mesh setanim(%vh_vindia_back_door_exit_combat_idle);
  var0.mesh setanim(%vh_vindia_left_door_exit_combat_idle);
  var0.mesh setanim(%vh_vindia_right_door_exit_combat_idle);
}

function vehicle_vindiatirelogic(var0, var1) {
  var2 = var1.script_parameters;
  var3 = getEnt(var1.target, "targetname");
  var3 notsolid();

  if(issubstr(tolower(var2), "right")) {
    var4 = (0, 0, 0);
    var5 = (0, 180, 0);
  } else {
    var4 = (0, 0, 0);
    var5 = (0, 0, 0);
  }

  var5 linkTo(var2, var4, var4, var5);
  var3 solid();
  var3 waittill("ballistics_bulletDamage", var6);
  var5 setModel("veh8_mil_lnd_vindia_wheel_01_dst");
  playFX(level._effect["vfx_vindia_tire_break"], var3.origin, anglesToForward(var3.angles));
  thread scripts\engine\utility::play_sound_in_space("scn_highway_apc_tires_expl", var3.origin);
  var2.mesh clearanim(%hod_vehicle_hit_l_apc, 0);
  var2.mesh clearanim(%hod_vehicle_hit_r_apc, 0);

  if(var2 scripts\engine\math::is_point_on_right(var6)) {
    var2.mesh setanim(%hod_vehicle_hit_l_apc);
  } else {
    var2.mesh setanim(%hod_vehicle_hit_r_apc);
  }

  playFXOnTag(level._effect["vfx_vindia_tire_sparks"], var2.mesh, var4);
  var7 = 1.33333;
  var8 = 1.33333;
  var9 = 2;

  for(var10 = 0; var10 < 3; var10++) {
    var2.mesh unlink();
    var11 = anglestoup(var2.mesh.angles);
    var2.mesh.origin -= var11 * var7;
    var12 = anglesToForward(var2.mesh.angles);
    var13 = anglestoright(var2.mesh.angles);
    var14 = vectorNormalize(var3.origin - var2.origin);
    var15 = scripts\engine\math::anglebetweenvectors(var12, var14);
    var16 = scripts\engine\math::anglebetweenvectors(var13, var14);
    var17 = cos(var15);
    var18 = cos(var16);
    var19 = var17 * var8;
    var20 = var18 * var9;
    var2.mesh.angles += (var19, 0, var20);
    var2.mesh linkTo(var2);
    waitframe();
  }

  var2 notify("vehicle_tireBreak", var6);
  level notify("vehicle_tireBreak", var2);
  var3 delete();
  var2 scripts\engine\utility::waittill_any("vehicle_disabled", "reached_end_node");
  stopFXOnTag(level._effect["vfx_vindia_tire_sparks"], var2.mesh, var4);
}

function vehicle_vindiadamagelogic(var0) {
  var0 endon("reached_wait_speed");
  var1 = level_getfarah();

  foreach(var3 in var0.tireclips) {
    thread vehicle_vindiatirelogic(var0, var3);
  }

  thread vehicle_vindiabodydamagelogic(var0);
  var5 = (0, 0, 0);

  for(var6 = 0; var6 < 3; var6++) {
    var0 waittill("vehicle_tireBreak", var5);
    var7 = var0 vehicle_getspeed();
    var8 = var7 * 0.5;
    var9 = var6 + 1 == 3;

    if(!var7 || !var8 || var9) {
      break;
    }

    var0 vehicle_setspeed(var8);
  }

  var0 vehicle_setspeed(0, 30, 30);
  level notify("vehicle_vindiaDisable", var0);
  var0 notify("vehicle_disabled", var5);
}

function vehicle_vindiaspeeduplogic(var0) {
  var0 endon("reached_wait_speed");
  GscBinSkip4(0x35, var0);
}

function vehicle_vindiaspeeduptimeoutlogic(var0) {
  wait 80;
  var0 vehicle_setspeed(35, 30);
}

function vehicle_vindiaunloadlogic(var0) {
  var0 waittill("reached_wait_speed");
  createnavobstaclebybounds(var0.origin, (150, 60, 100), var0.angles);
  wait 5;
  var0 scripts\common\vehicle::vehicle_unload();
}

function vehicle_vindiasmokegrenadelogic(var0, var1) {
  if(var1) {
    var0 waittill("reached_wait_speed");
    level notify("vehicle_vindiaSmokeGrenade");
  }

  var2 = 1000;
  var3 = 1500;
  var4 = -60;
  var5 = -50;
  var6 = -120;
  var7 = 120;
  vehicle_vindialaunchsmokegrenades(var0, var2, var3, var4, var5, var6, var7);
}

function vehicle_vindialaunchsmokegrenades(var0, var1, var2, var3, var4, var5, var6) {
  var7 = var6 - var5;
  var8 = var7 / 6;
  wait 1;
  var0 notify("vehicle_vindiaSmokeGrenadeDisperse");
  var9 = scripts\engine\utility::spawn_tag_origin(var0 gettagorigin("TAG_BODY") + (0, 0, -15), var0.mesh.angles);
  var10 = var0.origin + anglesToForward(var0.angles) * 300;
  playFX(level._effect["vfx_vindia_smk_gren_left"], var10);
  thread scripts\engine\utility::play_sound_in_space("hod_smoke_grenade_smoke_tail", var10);
  var11 = var5;

  while(var11 < var6) {
    var12 = randomfloatrange(var3, var4);
    var9.angles = var0.mesh.angles + (var12, var11, 0);
    var13 = anglesToForward(var9.angles);
    var14 = randomfloatrange(var1, var2);
    var15 = var14 * var13;
    thread vehicle_vindiaspawnsmokegrenade(var9.origin, var15);
    thread vehicle_vindiasmokelaunchsfxlogic(var9.origin);
    wait 0.3;
    var11 += var8;
  }
}

function vehicle_vindiasmokelaunchsfxlogic(var0) {
  if(!isDefined(var0)) {
    var0 = level.player.origin;
  }

  var1 = spawn("script_origin", var0 + (0, 0, 1));
  var1 playSound("scn_highway_apc_smoke_launch_npc_med");
  wait 3.6;
  var1 delete();
}

function vehicle_vindiaspawnsmokegrenade(var0, var1) {
  var2 = spawn("script_model", var0);
  var2 setModel("offhand_wm_grenade_smoke");
  var2.targetname = "vehicle_vindiaSmokeGrenade";
  var2 physicslaunchserver(var2.origin, var1);
  playFX(level._effect["vfx_vindia_smoke_grenade_fire"], var0, vectorNormalize(var1));
  playFXOnTag(level._effect["vfx_vindia_smoke_grenade_trail"], var2, "tag_fx");
  wait randomfloatrange(0.35, 0.55);

  if(isDefined(var2)) {
    playFXOnTag(level._effect["vfx_vindia_smk_gren_left"], var2, "tag_fx");
    return;
  }
}

function vehicle_getvindiasmokegrenades() {
  return getEntArray("vehicle_vindiaSmokeGrenade", "targetname");
}

function vehicle_vindiabodydamagelogic(var0) {
  var0 endon("reached_end_node");
  var0 endon("vehicle_disabled");

  for(;;) {
    var0.bodyclip waittill("ballistics_bulletDamage");
    level notify("vehicle_vindiaBodyShot");
  }
}

function vehicle_spawntechos(var0, var1) {
  var2 = scripts\common\utility::getvehiclespawnerarray(var0, "targetname");
  var3 = [];

  foreach(var5 in var2) {
    var6 = var5 scripts\common\utility::spawn_vehicle();
    var6.targetname = var1;
    var6.ballisticdontpenetrate = 1;
    var6 scripts\common\vehicle::godon();
    var6 hidepart("TAG_WINDSHIELD_FRONT");
    var6 hidepart("TAG_WINDOW_FRONT_LEFT");
    var6 hidepart("TAG_WINDOW_FRONT_RIGHT");
    var6 hidepart("TAG_WINDOW_BACK_LEFT");
    var6 hidepart("TAG_WINDOW_BACK_RIGHT");
    var6 vehicle_teleport(var5.origin, var5.angles);
    var7 = getEntArray(var5.target, "targetname");

    foreach(var9 in var7) {
      if(isai(var9)) {
        continue;
      }

      var10 = var9.origin - var5.origin;
      var9.origin = var6.origin + var10;

      if(scripts\engine\utility::is_equal(var9.script_noteworthy, "vehicle_engineBlock")) {
        var9.ballisticdontpenetrate = 1;
        var9 linkTo(var6);
        var6.engineblock = var9;
      }
    }

    var3 = scripts\engine\utility::array_add(var3, var6);
  }

  return var3;
}

function vehicle_techodisablelogic(var0) {
  var0.engineblock waittill("ballistics_bulletDamage", var1);
  var2 = 15;
  var3 = -15;
  var4 = var0 gettagorigin("TAG_HOOD");
  var4 += anglesToForward(var0.angles) * var2;
  var4 += anglestoup(var0.angles) * var3;
  var5 = scripts\engine\utility::spawn_tag_origin(var4);
  var5 linkTo(var0);
  var0 hidepart("TAG_HOOD");
  playFXOnTag(level._effect["vfx_techo_disable"], var5, "tag_origin");
  var0 thread scripts\engine\sp\utility::play_sound_on_tag("scn_highway_truck_engine_block_destr", "tag_origin");

  if(var0 scripts\engine\math::is_point_on_right(var1)) {
    var0 setanim(%hod_vehicle_hit_l_truck);
  } else {
    var0 setanim(%hod_vehicle_hit_r_truck);
  }

  if(var0 vehicle_getspeed()) {
    var0 notify("vehicle_disabled");
    level notify("vehicle_techoDisable");
    var0 thread scripts\engine\sp\utility::play_sound_on_tag("scn_highway_truck_engine_block_die", "tag_origin");
    var0 vehicle_setspeed(0, 30, 30);
    var0 setwaitspeed(0);
    var0.engineblock delete();
    var0 waittill("reached_wait_speed");
    var0 scripts\common\vehicle::vehicle_unload();
    return;
  }
}

function vehicle_findnextcrashpath(var0, var1) {
  var2 = undefined;

  for(var3 = var1; isDefined(var3); var3 = getvehiclenode(var3.target, "targetname")) {
    var4 = vehicle_nodegetcrashpaths(var3);

    foreach(var6 in var4) {
      if(distancesquared(var0.origin, var6.origin) < 250000) {
        continue;
      }

      var2 = var6;
    }

    if(isDefined(var2)) {
      break;
    }

    if(!isDefined(var3.target)) {
      break;
    }
  }

  return var2;
}

function vehicle_nodegetcrashpaths(var0) {
  var1 = var0 scripts\engine\sp\utility::get_linked_vehicle_nodes();

  foreach(var3 in var1) {
    if(istrue(var3.crashpathused)) {
      var1 = scripts\engine\utility::array_remove(var1, var3);
    }
  }

  return var1;
}

function vehicle_suniform25effects(var0) {
  var1 = scripts\engine\sp\utility::get_rumble_ent();
  var1.intensity = 0;

  while(isDefined(var0)) {
    var2 = distancesquared(var0.origin, level.player.origin);
    var1.intensity = 1 - scripts\engine\math::normalize_value(0, 25000000, var2);

    if(var2 <= 144000000) {
      var3 = scripts\engine\math::normalize_value(0, 144000000, var2);
      var4 = 0.2 * var3;
      var5 = 4 * var3;
      earthquake(var4, var5, var0.origin, 12000);
    }

    waitframe();
  }

  var1 delete();
}

function vehicle_suniform25dropbomb(var0) {
  var1 = var0.origin;
  var2 = var0.angles;
  var3 = spawn("script_model", var1);
  var3 setModel("highway_suniform25_bomb");
  var3.angles = var2 + (0, 270, 0);
  playFXOnTag(level._effect["vfx_suniform25_bomb_trail"], var3, "tag_origin");
  var4 = anglesToForward(var2) * 1500;
  var5 = (0, 0, -3000);
  var6 = 6.66667;
  var7 = 0;
  var8 = var1;

  while(var7 < var6) {
    var9 = var8;
    var8 = var1 + var4 * var7 + 0.5 * var5 * squared(var7);
    var3.origin = var8;
    var3.angles += (0, 0, -2.9);
    var10 = scripts\engine\trace::create_world_contents();
    var11 = scripts\engine\trace::ray_trace_detail(var9, var8, [level.player], var10, 0, 1);
    var12 = var11["fraction"];
    var13 = var11["position"];

    if(var12 != 1) {
      var3.origin = var13;
      break;
    }

    var7 += 0.05;
    waitframe();
  }

  var14 = var3.origin;
  var3 delete();
  playFX(level._effect["vfx_suniform25_bomb_explosion"], var14);
  var15 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");

  foreach(var17 in var15) {
    level.player thread[[level.aigibfunction]](var17, var17 getEye(), "MOD_RIFLE_BULLET");
  }

  physicsexplosionsphere(var14, 2000, 0, 200);
  var19 = distance(var14, level.player.origin);
  var20 = var19 / 58346;
  level notify("vehicle_suniform25BombImpact", var14);
  wait var20;
  var21 = 1 - scripts\engine\math::normalize_value(0, 20000, var19);
  var22 = scripts\engine\math::factor_value(0.06, 0.12, var21);
  var23 = scripts\engine\math::factor_value(0.75, 1.8, var21);
  earthquake(var22, var23, var14, 20000);
  level.player playRumbleOnEntity("damage_heavy");
}

function vehicle_spawncovernodes(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var4 *= -1;
  var6 *= -1;
  var9 = anglesToForward(var1);
  var10 = anglestoright(var1);
  var11 = (0, 0, 1);
  var12 = vectortoangles(var9);
  var13 = vectortoangles(var9 * -1);
  var14 = vectortoangles(var10);
  var15 = vectortoangles(var10 * -1);
  var16 = [];
  vehicle_addcovernodetemplate(var16, "Cover Left", var2 - 16, var6, var14);
  vehicle_addcovernodetemplate(var16, "Cover Right", var2 + var3, var6 + 16, var13);
  vehicle_addcovernodetemplate(var16, "Cover Left", var2 + var3, var7 - 16, var13);
  vehicle_addcovernodetemplate(var16, "Cover Right", var2 - 16, var7, var15);
  vehicle_addcovernodetemplate(var16, "Cover Left", var4 + 16, var7, var15);
  vehicle_addcovernodetemplate(var16, "Cover Right", var4 - var5, var7 - 16, var12);
  vehicle_addcovernodetemplate(var16, "Cover Left", var4 - var5, var6 + 16, var12);
  vehicle_addcovernodetemplate(var16, "Cover Right", var4 + 16, var6, var14);
  var17 = [];

  foreach(var19 in var16) {
    var20 = var0 + var9 * var19.forwarddistance + var10 * var19.rightdistance + var11 * 32;
    var20 += anglesToForward(var19.angles) * 16 * -1;
    var21 = spawncovernode(var20, var19.angles, var19.type, 4, var8);

    if(isDefined(var21)) {
      var17 = scripts\engine\utility::array_add(var17, var21);
    }
  }

  return var17;
}

function vehicle_addcovernodetemplate(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var5.type = var1;
  var5.forwarddistance = var2;
  var5.rightdistance = var3;
  var5.angles = var4;
  return scripts\engine\utility::array_add(var0, var5);
}

function vehicle_waittillarraymoving(var0) {
  for(;;) {
    var1 = 0;

    foreach(var3 in var0) {
      if(var3 vehicle_getspeed()) {
        var1++;
      }
    }

    if(scripts\engine\utility::is_equal(var1, var0.size)) {
      break;
    }

    waitframe();
  }
}

function level_spawnfarah() {
  var0 = getspawner("level_farahSpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1 scripts\common\ai::magic_bullet_shield();
  var1.targetname = "level_farah";
  var1.name = "Farah";
  var1.animname = "farah";
  var1.disableplayeradsloscheck = 1;

  if(!scripts\common\ai::spawn_failed(var1)) {
    var1 scripts\engine\sp\utility::set_goalRadius(256);
  }

  return var1;
}

function level_spawnhadir() {
  var0 = getspawner("level_hadirSpawner", "targetname");
  var1 = var0 stalingradspawn();
  var1 scripts\common\ai::magic_bullet_shield();
  var1.targetname = "level_hadir";
  var1.name = "Hadir";
  var1.animname = "hadir";
  var1.disableplayeradsloscheck = 1;

  if(!scripts\common\ai::spawn_failed(var1)) {
    var1 scripts\engine\sp\utility::set_goalRadius(256);
  }

  return var1;
}

function level_spawnredshirts() {
  var0 = level_getredshirtspawners();
  var1 = 0;

  for(var2 = 0; var2 < level_getredshirtgoalamount(); var2++) {
    var3 = var0[var1];
    level_spawnredshirtfromspawner(var3);
    var1 = scripts\engine\math::wrap(0, var0.size, var1 + 1);
  }

  thread level_redshirtslogic();
}

function level_getredshirtgoalamount() {
  return level.redshirtgoalamount;
}

function level_setredshirtgoalamount(var0) {
  level.redshirtgoalamount = var0;
}

function level_spawnredshirtfromspawner(var0, var1) {
  if(!scripts\sp\maps\highway\highway_utility::level_getflag(32)) {
    return;
  }

  var0.count = 9999;
  var2 = var0 scripts\engine\sp\utility::spawn_ai();

  if(scripts\common\ai::spawn_failed(var2)) {
    return;
  }

  level notify("level_redShirtSpawned", var2);
  var2.targetname = "level_redShirt";
  var2.animname = "level_redShirt";
  var2.script_pushable = 1;
  var2 scripts\engine\sp\utility::set_goalRadius(256);
  thread level_redshirtmagicbulletshieldlogic(var2);
}

function level_redshirtmagicbulletshieldlogic(var0) {
  var0 endon("death");
  var0 scripts\common\ai::magic_bullet_shield();
  var0 waittill("goal");
  var0 scripts\common\ai::stop_magic_bullet_shield();
}

function level_redshirtslogic() {
  level.player endon("death");
  var0 = 0;
  var1 = level.player.origin;

  for(;;) {
    waitframe();
    var2 = gettime();
    var3 = var2 >= var0;
    var4 = 0;

    if(var3) {
      var4 = distancesquared(var1, level.player.origin) > 40000;
      var0 = var2 + 3000;
      var1 = level.player.origin;
    }

    var5 = level_getredshirts();

    if(scripts\sp\maps\highway\highway_utility::level_getflag(512)) {
      var5 = scripts\engine\utility::array_add(var5, level_gethadir());
    }

    var5 = scripts\sp\maps\highway\highway_utility::array_removedeaddyingorundefined(var5);
    var6 = max(0, level_getredshirtgoalamount() - var5.size);

    if(var6) {
      for(var7 = 0; var7 < var6; var7++) {
        var8 = level_getredshirtspawners();
        var9 = scripts\engine\utility::random(var8);
        thread level_spawnredshirtfromspawner(var9, 5);
      }
    }

    if(!scripts\sp\maps\highway\highway_utility::level_getflag(64)) {
      waitframe();
      continue;
    }

    if(var4) {
      var10 = var5;
    } else {
      var10 = [];

      foreach(var12 in var5) {
        if(level_redshirtshouldmove(var12)) {
          var10 = scripts\engine\utility::array_add(var10, var12);
        }
      }
    }

    var14 = level_redshirtgetpossiblegoalnodesinheight();

    foreach(var16 in var14) {
      if(isDefined(showcinematicletterboxing(var16))) {
        var14 = scripts\engine\utility::array_remove(var14, var16);
      }
    }

    if(var14.size > var10.size) {
      var18 = level_redshirtgetpossiblegoalnodes();
      var18 = scripts\engine\utility::array_remove_array(var18, var14);

      foreach(var16 in var18) {
        if(isDefined(showcinematicletterboxing(var16))) {
          var18 = scripts\engine\utility::array_remove(var18, var16);
        }
      }

      var21 = var10.size - var14.size;

      for(var7 = 0; var7 < var21; var7++) {
        var14 = scripts\engine\utility::array_add(var14, var18[var7]);
      }
    }

    foreach(var23 in var10) {
      if(!var14.size) {
        break;
      }

      var24 = var14[0];
      var23 setgoalnode(var24);
      var14 = scripts\engine\utility::array_remove(var14, var24);
    }

    waitframe();
  }
}

function level_redshirtshouldmove(var0) {
  if(!isDefined(var0.node)) {
    return true;
  }

  var1 = distancesquared(level.player.origin, var0.node.origin) < 4096;

  if(var1) {
    return true;
  }

  return false;
}

function level_redshirtgetclosestonscreen() {
  var0 = level_getredshirts();
  var1 = level.player getEye();
  var2 = 50;
  var3 = 150;
  var0 = scripts\engine\utility::array_sort_with_func(var0, &level_redshirtcloseronscreen);
  var4 = [];

  foreach(var6 in var0) {
    var7 = var6 getEye();
    var8 = sighttracepassed(var1, var7, 0, level.player, 1);

    if(!var8) {
      continue;
    }

    var9 = vectorNormalize(var7 - var1);
    var10 = anglesToForward(level.player getplayerangles());
    var11 = vectordot(var9, var10);
    var12 = var11 > cos(65);

    if(!var12) {
      continue;
    }

    var13 = distance(var1, var7);
    var14 = var13 >= var2 && var13 <= var3;

    if(!var14) {
      continue;
    }

    var4 = scripts\engine\utility::array_add(var4, var6);
  }

  if(var4.size) {
    var16 = var4[0];
  } else {
    var16 = var1[0];
  }

  return var16;
}

function level_redshirtcloseronscreen(var0, var1) {
  var2 = anglesToForward(level.player getplayerangles());
  var3 = vectorNormalize(var0 getEye() - level.player getEye());
  var4 = vectordot(var2, var3);
  var5 = vectorNormalize(var1 getEye() - level.player getEye());
  var6 = vectordot(var2, var5);
  return var4 > var6;
}

function level_redshirtgetpossiblegoalnodes() {
  return getnodesinradiussorted(level.player.origin, 512, 64, 256, "cover");
}

function level_redshirtgetpossiblegoalnodesinheight() {
  return getnodesinradiussorted(level.player.origin, 512, 64, 64, "cover");
}

function level_getredshirts() {
  return getEntArray("level_redShirt", "targetname");
}

function level_getredshirtspawners() {
  return getspawnerarray("level_redShirtSpawner");
}

function level_getfarah() {
  return getEnt("level_farah", "targetname");
}

function level_getfarahtownnode() {
  return getnode("level_farahTownNode", "targetname");
}

function level_gethadir() {
  return getEnt("level_hadir", "targetname");
}

function level_hadirattachgasmask() {
  var0 = level_gethadir();
  var0 attach("hat_gasmask", "J_HELMET", 1);
}

function level_spawnhadirtruck() {
  var0 = scripts\common\utility::getvehiclespawner("level_hadirTruckSpawner", "targetname");
  var1 = spawn("script_model", var0.origin);
  var1.angles = var0.angles;
  var1 setModel(var0.model);
  var1 solid();
  var2 = var0 scripts\engine\utility::get_linked_ents();

  foreach(var4 in var2) {
    var5 = var4.origin - var0.origin;
    var6 = rotatevectorinverted(var5, var0.angles);
    var7 = var4.angles - var0.angles;
    var4 linkTo(var1, "TAG_BODY_ANIMATE");
  }

  var1 scripts\common\vehicle::godon();
  var1.animname = "level_hadirTruck";
  var1 scripts\common\anim::setanimtree();
  var1.targetname = "level_hadirTruck";
  var9 = crash_getanimationstruct();
  var9 scripts\common\anim::anim_first_frame_solo(var1, "crash_enter");
  var10 = scripts\engine\sp\utility::spawn_anim_model("crash_board");
  var10.targetname = "level_hadirTruckBoard";
  var9 scripts\common\anim::anim_first_frame_solo(var10, "crash_enter");
}

function level_gethadirtruck() {
  return getEnt("level_hadirTruck", "targetname");
}

function level_gethadirtruckboard() {
  return getEnt("level_hadirTruckBoard", "targetname");
}

function level_getheroes() {
  return [level_getfarah(), level_gethadir()];
}

function level_openbunkerouterdoor() {
  var0 = level_getbunkerouterdoor();
  var0 hide();
  var0 notsolid();
  var1 = getEnt(var0.target, "targetname");
  var1 connectpaths();
  var1 notsolid();
}

function level_getbunkerouterdoor() {
  return getEnt("level_bunkerOuterDoor", "targetname");
}

function level_closebunkerouterdoor() {
  var0 = level_getbunkerouterdoor();
  var0 show();
  var0 solid();
  var1 = getEnt(var0.target, "targetname");
  var1 disconnectPaths();
  var1 solid();
}

function level_getbunkervolume() {
  return getEnt("level_bunkerVolume", "targetname");
}

function level_addmissionnarrativeobjective() {
  return scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_AMBUSH_THE_WOLF");
}

function level_cleanupieds() {
  var0 = level_getieds();

  foreach(var2 in var0) {
    var2.interact thread scripts\sp\player\cursor_hint::remove_cursor_hint();
    var2 delete();
  }
}

function level_getieds() {
  return getEntArray("offhand_ied", "targetname");
}

function level_setupoilpump() {
  var0 = level_getoilpump();
  var0.animname = "level_oilPump";
  var0 scripts\common\anim::setanimtree();
  thread scripts\sp\maps\highway\highway_utility::animation_loop(var0, var0, "level_oilPumpIdle");
}

function level_getoilpump() {
  return getEnt("level_oilPump", "targetname");
}

function level_ballisticsniperammopickuplogic() {
  var0 = scripts\engine\utility::getStruct("level_ballisticSniperAmmoPickupStruct", "targetname");
  var1 = getEntArray(var0.target, "targetname");
  thread level_ballisticsniperammowaypointlogic(var0);

  for(;;) {
    var2 = var0 scripts\engine\utility::spawn_tag_origin();
    var2 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HIGHWAY/CURSOR_SNIPER_AMMO", undefined, undefined, 80);
    thread level_ballisticsniperammointeractlogic(var2);
    var2 waittill("trigger");

    if(var1.size) {
      var3 = sortbydistance(var1, level.player getEye())[0];
      var1 = scripts\engine\utility::array_remove(var1, var3);
      var3 delete();
    }

    thread scripts\engine\utility::play_sound_in_space("weap_pickup", var0.origin);
    var4 = player_getballisticsweaponobject();
    level.player givemaxammo(var4);
    var2 delete();
  }
}

function level_ballisticsniperammointeractlogic(var0) {
  var0 endon("trigger");
  var1 = player_getballisticsweaponobject();
  var2 = weaponmaxammo(var1);

  for(;;) {
    if(scripts\engine\sp\utility::player_has_weapon(var1) && level.player getweaponammostock(var1) < var2) {
      var0.cursor_hint_ent makeusable();
    } else {
      var0.cursor_hint_ent makeunusable();
    }

    waitframe();
  }
}

function level_ballisticsniperammowaypointlogic(var0) {
  level endon("level_enemyAssaultPlayerSeek");
  var1 = player_getballisticsweaponobject();
  var2 = undefined;

  for(;;) {
    var3 = scripts\engine\sp\utility::player_has_weapon(var1) && level.player getweaponammostock(var1) <= weaponclipsize(var1);

    if(!isDefined(var2) && var3) {
      level.player scripts\sp\player::focus_display_hint();
      var2 = scripts\sp\maps\highway\highway_utility::level_objectiveadd(&"HIGHWAY/OBJECTIVE_GET_SNIPER_AMMO", var0.origin + (0, 0, 10), &"HIGHWAY/LABEL_AMMO", 1);
    }

    var4 = scripts\engine\sp\utility::player_has_weapon(var1) && level.player getweaponammostock(var1) >= weaponmaxammo(var1);

    if(isDefined(var2) && var4) {
      objective_delete(var2);
      var2 = undefined;
    }

    waitframe();
  }
}

function level_enemyassaulttownlogic(var0, var1) {
  var0 endon("death");
  level.player endon("death");
  level endon("level_enemyAssaultPlayerSeek");

  if(var1) {
    var0.vehiclerunexit = 1;
    var0 scripts\engine\sp\utility::set_ignoreme(1);
    var0 waittill("jumpedout");
    var0 scripts\engine\sp\utility::set_ignoreme(0);
  }

  if(scripts\engine\utility::flag("level_enemyAssaultPlayerSeek")) {
    var0 scripts\engine\sp\utility::set_grenadeammo(0);
    var0 scripts\engine\sp\utility::set_goalRadius(600);
    var0 setgoalentity(level.player);
    return;
  }

  var0 scripts\common\utility::demeanor_override("sprint");
  var2 = level_gettownouterenemygoalvolume();

  if(scripts\sp\maps\highway\highway_utility::math_getchance(30)) {
    var0 setgoalvolumeauto(var2);

    while(!var0 istouching(var2)) {
      waitframe();
    }

    wait randomfloatrange(6, 8);
  }

  var3 = level_gettowninnerenemygoalvolume();
  var0 setgoalvolumeauto(var3);

  while(!var0 istouching(var3)) {
    waitframe();
  }

  thread level_enemyassaulttownmolotovhintlogic();
  var0 scripts\common\utility::clear_demeanor_override();

  for(;;) {
    if(level.player istouching(var3)) {
      var0 setgoalvolumeauto(var3);
    } else {
      var0 setgoalvolumeauto(var2);
    }

    waitframe();
  }
}

function level_enemyassaulttownmolotovhintlogic() {
  level.player endon("death");
  var0 = scripts\sp\maps\highway\highway_utility::level_getflag(16);
  var1 = level.player getweaponammostock("molotov");
  var2 = scripts\engine\sp\utility::player_has_equipment("molotov") && var1;
  var3 = scripts\engine\utility::is_equal(level.player.offhands.lastusedoffhandweapon, getcompleteweaponname("molotov")) && gettime() - level.player.offhands.lastusedoffhandtime <= 10000;
  var4 = 30;
  var5 = gettime() + var4 * 0.001;

  if(!var0 && var2 && !var3) {
    scripts\engine\sp\utility::display_hint_forced("throw_molotov", var4);
    scripts\sp\maps\highway\highway_utility::level_setflag(16, 1);
    var6 = level_gethadir();
    var7 = level_getfarah();
    var8 = ["dx_vom_had_convoy_bc_140", "dx_vom_had_convoy_bc_130", "dx_vom_far_convoy_bc_150"];
    var9 = [var6, var6, var7];
    var10 = var8;
    var11 = var9;
    var12 = randomint(var10.size);
    var13 = 5;

    for(;;) {
      if(gettime() >= var5) {
        break;
      }

      if(level.player getweaponammostock("molotov") < var1) {
        break;
      }

      var14 = var10[var12];
      var15 = var11[var12];
      var15 scripts\sp\maps\highway\highway_utility::dialogue(var14);
      var12 = scripts\engine\math::wrap(0, var8.size - 1, var12 + 1);
      wait var13;
    }

    return;
  }
}

function level_gettownrooftoptriggers(var0) {
  var1 = getEntArray("level_townRooftopTrigger", "targetname");

  if(isDefined(var0)) {
    foreach(var3 in var1) {
      if(!scripts\engine\utility::is_equal(var3.script_noteworthy, var0)) {
        var1 = scripts\engine\utility::array_remove(var1, var3);
      }
    }
  }

  return var1;
}

function level_gettowninnerenemygoalvolume() {
  return getEnt("level_townInnerEnemyVolume", "targetname");
}

function level_gettownouterenemygoalvolume() {
  return getEnt("level_townOuterEnemyVolume", "targetname");
}

function level_gettowncovernodes() {
  return getnodearray("level_townCoverNodes", "targetname");
}

function level_gettownanimationstruct() {
  return scripts\engine\utility::getStruct("level_townAnimationStruct", "targetname");
}

function level_notifylevelonenemycount(var0, var1) {
  scripts\sp\maps\highway\highway_utility::waittill_remainingenemycount(var0);
  level notify(var1);
}

function level_notifylevelonenemydeathcount(var0, var1) {
  var2 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
  var3 = var2.size - var0;

  while(scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis").size > var3) {
    waitframe();
  }

  level notify(var1);
}

function level_notifylevelonplayershotcount(var0, var1) {
  for(var2 = 0; var2 < var0; var2++) {
    level.player waittill("weapon_fired");
  }

  level notify(var1);
}

function level_redbarreldistantlogic() {
  level.g_effect["barrel_explosion"] = loadfx("vfx/iw8/level/highway/vfx_red_barrel_exp_no_cull");
  var0 = getEntArray("level_redBarrelDistant", "targetname");

  foreach(var2 in var0) {
    thread level_redbarreldeathlogic(var2);
  }
}

function level_redbarreldeathlogic(var0) {
  var0 waittill("ballistics_bulletDamage");
  var1 = var0.origin;
  var0 delete();
  playFX(level.g_effect["barrel_explosion"], var1);
  var2 = 300;
  var3 = 225;
  var4 = 0.15;
  var5 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("axis");
  var6 = 0;

  foreach(var8 in var5) {
    if(distance(var8.origin, var1) > var2) {
      continue;
    }

    var8 notify("flashbang", (0, 0, 0), 1, 1, level.player, "allies");

    if(distance(var8.origin, var1) > var3) {
      continue;
    }

    level.player scripts\engine\utility::delaythread(var4, level.aigibfunction, var8, var8 getEye(), "MOD_EXPLOSIVE");
    var6 = 1;
  }

  var10 = 150;
  var11 = scripts\sp\maps\highway\highway_utility::ai_getaliveaiarray("allies");

  foreach(var13 in var11) {
    if(distance(var13.origin, var1) > var2) {
      continue;
    }

    var13 notify("flashbang", (0, 0, 0), 1, 1, level.player, "axis");

    if(!var6 || distance(var13.origin, var1) > var10) {
      continue;
    }

    level.player scripts\engine\utility::delaythread(var4, level.aigibfunction, var13, var13 getEye(), "MOD_EXPLOSIVE");
  }

  thread scripts\engine\utility::play_sound_in_space("scn_highway_barrel_expl", var1);
  createnavbadplacebybounds(var1, (50, 50, 50), (0, 0, 0));
  physicsexplosionsphere(var1, 700, 0, 2);
  var15 = distance(var1, level.player.origin);
  var16 = var15 / 58346;
  wait var16;
  level.player playRumbleOnEntity("damage_light");
  earthquake(0.02, 0.5, var1, 50000);
}

function init_wind() {
  scripts\common\basic_wind::load_all_wind();
  level.ballistics.winddirections = [(-140, 0, 0), (140, 0, 0)];
  level.ballistics.winddirectionsextreme = [(-550, 0, 0), (550, 0, 0)];
  level.ballistics.winddirectionstrings = ["left", "right"];
  level.ballistics.winddirectionaimstrings = ["right", "left"];
  level.ballistics.winddirectionscardinal = ["west", "east"];
  level.ballistics.windobject = undefined;
  var0 = wind_getrandomdirectionindex();
  wind_setdirection(var0, 0, 0);
}

function wind_setdirection(var0, var1, var2) {
  var3 = (0, 0, 1);
  var4 = level.ballistics.winddirectionscardinal[var0];

  if(var2) {
    var5 = level.ballistics.winddirectionsextreme[var0];
    var6 = 2;
  } else {
    var5 = level.ballistics.winddirections[var2];
    var6 = 1;
  }

  if(isDefined(level.ballistics.windobject)) {
    scripts\common\basic_wind::stop_wind(level.ballistics.windobject);
  }

  var7 = scripts\common\basic_wind::init_wind(var6, var6, 0);

  if(var3) {
    var8 = level.ballistics.wind;
    var9 = 0;
    var10 = gettime();
    var11 = var10 + var3;
    var12 = var3 * 0.001 * 20;
    var13 = 1 / var12;

    while(gettime() < var11) {
      var14 = var8;
      var15 = vectorcross(var14, var5);
      var16 = axistoangles(var14, var15, var5);
      var17 = var5;
      var18 = vectorcross(var17, var5);
      var19 = axistoangles(var17, var18, var5);
      var20 = scripts\engine\math::fake_slerp(var16, var19, var9);
      level.ballistics.wind = anglesToForward(var20);
      var9 += var13;
      waitframe();
    }
  }

  level.ballistics.wind = var5;
  level.ballistics.winddirectionstring = level.ballistics.winddirectionstrings[var2];
  level.ballistics.winddirectionaimstring = level.ballistics.winddirectionaimstrings[var2];
  level.ballistics.winddirectionindex = var2;
  setsaveddvar("MQPQKNPQOK", 2);
  setsaveddvar("MRNRKKOPLN", 2);
  setsaveddvar("NQTLPTNSSO", 3);
  setsaveddvar("OLSKLTPPMR", 0.7);
  setsaveddvar("LQLSPQOPKM", 50);
  setsaveddvar("NTMMTOLQMQ", level.ballistics.wind);
}

function wind_getrandomdirectionindex() {
  var0 = scripts\engine\utility::array_remove(level.ballistics.winddirections, level.ballistics.wind);
  return randomint(var0.size);
}