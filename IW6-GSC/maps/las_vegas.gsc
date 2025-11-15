/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\las_vegas.gsc
*****************************************************/

main() {
  precachestuff();
  maps\_utility::template_level("las_vegas");
  setdvarifuninitialized("debug_choppers", "0");
  maps\createart\las_vegas_art::main();
  maps\las_vegas_fx::main();
  maps\_utility::set_default_start("ambush");
  maps\_utility::add_start("ambush", maps\las_vegas_casino::start_ambush, undefined, maps\las_vegas_casino::ambush, "las_vegas_transient_hotel_tr");
  maps\_utility::add_start("drag1", maps\las_vegas_casino::start_drag1, undefined, maps\las_vegas_casino::drag1, "las_vegas_transient_hotel_tr");
  maps\_utility::add_start("drag2", maps\las_vegas_casino::start_drag2, undefined, maps\las_vegas_casino::drag2, "las_vegas_transient_hotel_tr");
  maps\_utility::add_start("elias_death", maps\las_vegas_casino::start_elias_death, undefined, maps\las_vegas_casino::elias_death, "las_vegas_transient_hotel_tr");
  maps\_utility::add_start("rescue", maps\las_vegas_casino::start_rescue, undefined, maps\las_vegas_casino::rescue, "las_vegas_transient_hotel_tr");
  maps\_utility::add_start("bar", maps\las_vegas_casino::start_bar, undefined, maps\las_vegas_casino::bar, "las_vegas_transient_hotel_tr");
  maps\_utility::add_start("kitchen", maps\las_vegas_casino::start_kitchen, undefined, maps\las_vegas_casino::kitchen, "las_vegas_transient_hotel_tr");
  maps\_utility::add_start("atrium", maps\las_vegas_casino::start_atrium, undefined, maps\las_vegas_casino::atrium, "las_vegas_transient_hotel_tr");
  maps\_utility::add_start("floor", maps\las_vegas_casino::start_casino_floor, undefined, maps\las_vegas_casino::casino_floor, "las_vegas_transient_hotel_tr");
  maps\_utility::add_start("hotel", maps\las_vegas_casino::start_hotel, undefined, maps\las_vegas_casino::hotel, "las_vegas_transient_hotel_tr");
  maps\_utility::add_start("chase", maps\las_vegas_casino::start_hotel_chase, undefined, maps\las_vegas_casino::hotel_chase, "las_vegas_transient_hotel_tr");
  maps\_utility::add_start("slide", maps\las_vegas_casino::start_slide, undefined, maps\las_vegas_casino::slide);
  maps\_utility::add_start("entrance", maps\las_vegas_entrance::start_entrance, undefined, maps\las_vegas_entrance::entrance);
  maps\_utility::add_start("entrance_combat", maps\las_vegas_entrance::start_entrance_combat, undefined, maps\las_vegas_entrance::entrance_combat, "las_vegas_transient_crasharea_tr");
  maps\_utility::add_start("exfil", maps\las_vegas_entrance::start_exfil, undefined, maps\las_vegas_entrance::exfil, "las_vegas_transient_crasharea_tr");
  init_level_flags();
  maps\_utility::transient_init("las_vegas_transient_hotel_tr");
  maps\_utility::transient_init("las_vegas_transient_crasharea_tr");
  maps\_utility::intro_screen_create(&"LAS_VEGAS_INTROSCREEN_TITLE", & "LAS_VEGAS_INTROSCREEN_DATE", & "LAS_VEGAS_INTROSCREEN_LOCATION");
  maps\_utility::intro_screen_custom_func(::chryon);
  common_scripts\utility::add_destructible_type_transient("toy_lv_slot_machine", "las_vegas_transient_hotel_tr");
  common_scripts\utility::add_destructible_type_transient("toy_lv_slot_machine_flicker", "las_vegas_transient_hotel_tr");
  maps\las_vegas_precache::main();
  maps\las_vegas_code::build_aianims_override("script_vehicle_silenthawk_open_lite", vehicle_scripts\silenthawk::setanims, vehicle_scripts\silenthawk::set_vehicle_anims);
  maps\las_vegas_fx::wildlife();
  maps\_load::main();
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 7);

  if(level.xenon)
    setsaveddvar("r_texFilterProbeBilinear", 1);

  maps\las_vegas_audio::main();
  maps\las_vegas_anim::main();
  maps\las_vegas_fx::footstepeffects();
  maps\_patrol_anims_creepwalk::main();
  maps\_patrol_anims_creepwalk::init_creepwalk_archetype();
  soundsettimescalefactor("music", 0);
  maps\_utility::battlechatter_off("axis");
  thread init_player();
  init_spawn_functions();
  init_threatbias_groups();
  maps\las_vegas_code::spawn_heroes();
  maps\_utility::battlechatter_off();
  thread maps\las_vegas_code::objectives();
  thread achievement();
}

precachestuff() {
  precacheitem("l115a3");
  precacheitem("l115a3_nosound");
  precacheitem("rpg");
  precacheitem("rpg_straight");
  precacheitem("missile_attackheli");
  precacheitem("flash_grenade");
  precacheitem("noweapon_deer_hunt");
  precachemodel("projectile_us_smoke_grenade");
  precachemodel("weapon_ak47_clip");
  precachemodel("com_flashlight_on");
  precachemodel("com_flashlight_off");
  precachemodel("weapon_commando_knife_bloody");
  precachemodel("com_cardboardbox_dusty_01");
  precachemodel("com_hand_radio");
  precachemodel("oilrig_rappelrope_50ft");
  precachemodel("viewhands_player_gs_hostage");
  precachemodel("viewlegs_generic");
  precachemodel("lv_windowshatter");
  precachemodel("lv_drapery_03_animated");
  precachemodel("vehicle_metro_bus_tire_vegas");
  precachemodel("com_cafe_chair");
  precachemodel("viewmodel_mp443");
  precachemodel("fullbody_dog_b_cam_obj_hurt");
  precachemodel("fullbody_dog_b_hurt");
  maps\_utility_dogs::init_dog_pc("a");
  maps\_utility_dogs::init_dog_pc("b");
  maps\_utility_dogs::init_dog_pc("b_cam_obj_hurt");
  maps\_utility_dogs::init_dog_pc("b_hurt");
  precachemodel("lv_palmtree_straight");
  precachemodel("foliage_tree_palm_bushy_1");
  precachemodel("foliage_pacific_tropic_shrub01_animated");
  precachemodel("payback_foliage_tree_palm_bushy_3");
  precachemodel("payback_sstorm_dwarf_palm");
  precachemodel("lv_palmtree_dead_1");
  precachemodel("foliage_desertbrush_1_animated");
  precachemodel("foliage_pacific_fern02_animated");
  precacheshader("buried_sand_screen");
  precacheshader("hint_usable");
  precacheshader("dogcam_edge");
  precacheshader("vfx_blood_screen_overlay");
  precacheshellshock("vegas_chair_shot");
  precacheshellshock("vegas_chair");
  precacheshellshock("vegas_gas");
  precacheshellshock("vegas_drag");
  precacheshellshock("westminster_truck_crash");
  precacheshellshock("las_vegas_getup");
  precacherumble("subtle_tank_rumble");
  precacherumble("heavy_1s");
  precacherumble("slide_loop");
  precacherumble("vegas_drag");
  precacherumble("vegas_brash");
  precacherumble("vegas_struggle");
  precachemodel("foliage_tree_palm_bushy_1");
  precachemodel("tag_flash");
}

init_level_flags() {
  common_scripts\utility::flag_init("ambush_done");
  common_scripts\utility::flag_init("ambush_riley_getout");
  common_scripts\utility::flag_init("ambush_started");
  common_scripts\utility::flag_init("show_chyron");
  common_scripts\utility::flag_init("intro_lines");
  common_scripts\utility::flag_init("drag2_start_fadeout");
  common_scripts\utility::flag_init("elias_death_start");
  common_scripts\utility::flag_init("elias_death_struggle");
  common_scripts\utility::flag_init("elias_death_end");
  common_scripts\utility::flag_init("elias_death_player_win");
  common_scripts\utility::flag_init("elias_death_player_failed");
  common_scripts\utility::flag_init("elias_death_struggle_done");
  common_scripts\utility::flag_init("elias_death_done");
  common_scripts\utility::flag_init("player_grabbed_gun");
  common_scripts\utility::flag_init("rescue_sniper_done");
  common_scripts\utility::flag_init("rescue_sniper_start");
  common_scripts\utility::flag_init("rescue_unlink_player");
  common_scripts\utility::flag_init("rescue_merrick_end");
  common_scripts\utility::flag_init("humanshield_start");
  common_scripts\utility::flag_init("human_shield_done");
  common_scripts\utility::flag_init("human_shield_ready_for_end");
  common_scripts\utility::flag_init("kitchen_doors_open");
  common_scripts\utility::flag_init("kitchen_hide_start");
  common_scripts\utility::flag_init("kitchen_hide_started");
  common_scripts\utility::flag_init("kitchen_hide_ready");
  common_scripts\utility::flag_init("ready_for_flashlight_enemy");
  common_scripts\utility::flag_init("kitchen_hide_enemies");
  common_scripts\utility::flag_init("kitchen_hide_everyone_up");
  common_scripts\utility::flag_init("kitchen_hide_done");
  common_scripts\utility::flag_init("kitchen_stealth_alert");
  common_scripts\utility::flag_init("kitchen_enemy_doors_open");
  common_scripts\utility::flag_init("kitchen_enemies_gone");
  common_scripts\utility::flag_init("atrium_stealth_alert");
  common_scripts\utility::flag_init("shops_move_in");
  common_scripts\utility::flag_init("shops_area_clear");
  common_scripts\utility::flag_init("cleared_atrium_no_fight");
  common_scripts\utility::flag_init("shops_combat_start");
  common_scripts\utility::flag_init("FLAG_gt_at_the_gate");
  common_scripts\utility::flag_init("FLAG_normal_cas_ambush");
  common_scripts\utility::flag_init("casino_door_opened");
  common_scripts\utility::flag_init("casino_floor_done");
  common_scripts\utility::flag_init("floor_battle_start");
  common_scripts\utility::flag_init("ai_halter_alive");
  common_scripts\utility::flag_init("FLAG_ai_do_halt");
  common_scripts\utility::flag_init("door_react_count");
  maps\_utility::flag_count_set("door_react_count", 3);
  common_scripts\utility::flag_init("door_react_player_close");
  common_scripts\utility::flag_init("door_react_done");
  common_scripts\utility::flag_init("stay_above_last_fight_cas");
  common_scripts\utility::flag_init("keegan_can_shoot_ai_halter");
  common_scripts\utility::flag_init("merrick_under_gate");
  common_scripts\utility::flag_init("hesh_under_gate");
  common_scripts\utility::flag_init("floor_open_gate");
  common_scripts\utility::flag_init("floor_gate_lifed");
  common_scripts\utility::flag_init("floor_close_gate");
  common_scripts\utility::flag_init("chase_started");
  common_scripts\utility::flag_init("player_under_gate");
  common_scripts\utility::flag_init("player_under_gate_ready");
  common_scripts\utility::flag_init("floor_gate_done");
  common_scripts\utility::flag_init("FLAG_player_ambush_agro");
  common_scripts\utility::flag_init("FLAG_floor_gate_lifed");
  common_scripts\utility::flag_init("FLAG_end_hallway_anims_done");
  common_scripts\utility::flag_init("FLAG_everyone_in_raid_room");
  common_scripts\utility::flag_init("FLAG_player_start_slide");
  common_scripts\utility::flag_init("FLAG_player_slide_complete");
  common_scripts\utility::flag_init("raid_exit_complete");
  common_scripts\utility::flag_init("FLAG_start_slide_birds");
  common_scripts\utility::flag_init("FLAG_stop_feet_slide_fx");
  common_scripts\utility::flag_init("FLAG_player_attacked_cas_ambush");
  common_scripts\utility::flag_init("FLAG_01_ai_sniped");
  common_scripts\utility::flag_init("chopper_shooter_is_needed");
  common_scripts\utility::flag_init("entrance_chopper_reinforcement");
  common_scripts\utility::flag_init("courtyard_battle_done");
  common_scripts\utility::flag_init("start_outside_animated_props");
  common_scripts\utility::flag_init("incoming_chopper");
  common_scripts\utility::flag_init("dog_down");
  common_scripts\utility::flag_init("dog_pickup_ready");
  common_scripts\utility::flag_init("dog_first_pickup");
  common_scripts\utility::flag_init("getup_done");
  common_scripts\utility::flag_init("casino_entrance_convoy_passed");
  common_scripts\utility::flag_init("player_attacked_convoy");
  common_scripts\utility::flag_init("FLAG_traincrash_start");
  common_scripts\utility::flag_init("flag_player_on_chopper");
  common_scripts\utility::flag_init("vegas_strip_convoy_passed");
  common_scripts\utility::flag_init("entrance_combat_start");
  common_scripts\utility::flag_init("bus_defend_done");
  common_scripts\utility::flag_init("exfil_f18");
  common_scripts\utility::flag_init("exfil_silenthawk");
  common_scripts\utility::flag_init("exfil_reached");
  common_scripts\utility::flag_init("exfil_fade");
  common_scripts\utility::flag_init("bus_go");
  common_scripts\utility::flag_init("ride_chopper_wait");
  common_scripts\utility::flag_init("barricade1");
  common_scripts\utility::flag_init("barricade1_mid");
  common_scripts\utility::flag_init("almost_barricade2");
  common_scripts\utility::flag_init("barricade2");
  common_scripts\utility::flag_init("alley");
  common_scripts\utility::flag_init("off_street");
  common_scripts\utility::flag_init("tunnel_defend_stop");
  common_scripts\utility::flag_init("tunnel_defend_start");
  common_scripts\utility::flag_init("tunnel_defend_done");
  common_scripts\utility::flag_init("tunnel_smoke_enabled");
  common_scripts\utility::flag_init("allow_pickup_dog");
  common_scripts\utility::flag_init("dog_picked_up");
  common_scripts\utility::flag_init("start_long_walk");
  common_scripts\utility::flag_init("ending1_done");
  common_scripts\utility::flag_init("ending2_done");
  common_scripts\utility::flag_init("ending3_done");
  common_scripts\utility::flag_init("ending4_done");
  common_scripts\utility::flag_init("dream_start");
  common_scripts\utility::flag_init("dream_fade_out");
  common_scripts\utility::flag_init("dream_done");
}

init_spawn_functions() {
  maps\las_vegas_casino::casino_spawn_functions();
  maps\las_vegas_entrance::spawn_functions();
}

init_threatbias_groups() {
  createthreatbiasgroup("heroes");
  level.player setthreatbiasgroup("heroes");
  maps\las_vegas_casino::casino_threatbias_groups();
}

init_player() {
  level.player maps\_utility::player_speed_default(0.05);
  level.player giveweapon("flash_grenade");
  level.player setweaponammostock("flash_grenade", 0);
  level.player giveweapon("fraggrenade");
  level.player setweaponammostock("fraggrenade", 0);
}

chryon() {
  common_scripts\utility::flag_wait("show_chyron");
  maps\_introscreen::introscreen(1);
}

achievement() {
  level.slot_machine_count = 0;
  level.slot_machine_total = 21;
  var_0 = "toy_lv_slot_machine";
  var_1 = getEntArray("destructible_toy", "targetname");

  foreach(var_3 in var_1) {
    if(var_3.destructible_type == var_0) {
      level.slot_machine_count++;
      var_3 thread achievement_thread();
    }
  }

  level.slot_machine_total = level.slot_machine_count - level.slot_machine_total;
}

achievement_thread() {
  thread draw_slot_machine();

  if(!common_scripts\utility::flag("las_vegas_transient_hotel_tr_loaded"))
    common_scripts\utility::flag_wait("las_vegas_transient_hotel_tr_loaded");

  if(!maps\las_vegas_code::is_start_point_before("entrance")) {
    return;
  }
  while(self.destructible_parts[2].v["currentState"] < 1 && self.destructible_parts[3].v["currentState"] < 1) {
    self waittill("damage");
    wait 0.05;
  }

  self notify("__destroyed");
  level.slot_machine_count--;

  if(level.slot_machine_count == level.slot_machine_total)
    level.player maps\_utility::player_giveachievement_wrapper("LEVEL_14A");
}

draw_slot_machine() {
  if(!getdvarint("debug_achievement")) {
    return;
  }
  self endon("__destroyed");

  for(;;)
    wait 0.05;
}