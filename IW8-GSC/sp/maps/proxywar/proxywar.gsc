/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\proxywar\proxywar.gsc
***********************************************/

main() {
  scripts\sp\maps\proxywar\gen\proxywar_art.gsc::main();
  scripts\sp\maps\proxywar\proxywar_fx.gsc::main();
  scripts\sp\maps\proxywar\proxywar_lighting.gsc::main();
  scripts\sp\maps\proxywar\proxywar_precache.gsc::main();
  scripts\sp\maps\proxywar\proxywar_anim.gsc::main();
  scripts\engine\sp\utility::transient_init("pw_storage_room_interior_tr");
  scripts\engine\sp\utility::transient_init("pw_control_room_interior_tr");
  scripts\engine\sp\utility::transient_init("pw_warehouse_interior_tr");
  scripts\engine\sp\utility::transient_init("pw_shack_interior_tr");
  scripts\engine\sp\utility::transient_init("pw_courtyard_detail_tr");
  scripts\engine\sp\utility::transient_init("pw_rearyard_detail_tr");
  scripts\engine\sp\utility::transient_init("pw_courtyard_top_detail_tr");
  scripts\engine\sp\utility::transient_init("pw_railyard_rear_detail_tr");
  scripts\engine\sp\utility::transient_init("pw_trainyard_front_detail_tr");
  scripts\engine\sp\utility::transient_init("pw_trainyard_main_detail_tr");
  scripts\engine\sp\utility::transient_init("pw_trainyard_track_detail_tr");
  setsaveddvar("MKNNNONLSK", 4);
  setsaveddvar("MMLNNQSTTL", 5);
  setsaveddvar("TLMMOPMSK", 1);
  proxywar_precache();
  proxywar_flags();
  proxywar_starts();
  proxywar_hints();
  level.door_hint_dist_scale = 0.8;
  scripts\sp\load::main();
  proxywar_init();
  proxywar_spawn_funcs();
  proxywar_loadout();

  if(scripts\sp\starts::is_first_start())
    proxywar_intro_screen();

  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::track_player_combat_time();
  thread proxywar_threat_bias();

  if(!scripts\sp\starts::is_after_start("railyard_breach") || scripts\sp\starts::is_after_start("alleyway_phosphorus"))
    scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::battlechatter_off);

  precachenightvisioncodeassets();
  setsaveddvar("TMNTMTQRM", 0);
  thread proxywar_tutorials();
  setsaveddvar("LTMPKRLLNM", 256);
  setsaveddvar("OLPNKQKKTT", 128);
}

proxywar_starts() {
  var_0 = ["pw_storage_room_interior_tr", "pw_trainyard_front_detail_tr", "pw_shack_interior_tr", "pw_trainyard_main_detail_tr"];
  var_1 = ["pw_storage_room_interior_tr", "pw_trainyard_front_detail_tr", "pw_shack_interior_tr", "pw_trainyard_main_detail_tr", "pw_trainyard_track_detail_tr", "pw_control_room_interior_tr", "pw_railyard_rear_detail_tr"];
  var_2 = ["pw_storage_room_interior_tr", "pw_control_room_interior_tr", "pw_shack_interior_tr", "pw_trainyard_main_detail_tr", "pw_trainyard_track_detail_tr", "pw_railyard_rear_detail_tr", "pw_courtyard_top_detail_tr", "pw_courtyard_detail_tr", "pw_warehouse_interior_tr", "pw_rearyard_detail_tr"];
  var_3 = ["pw_courtyard_detail_tr", "pw_warehouse_interior_tr", "pw_rearyard_detail_tr"];
  scripts\engine\sp\utility::add_start("heli_approach", scripts\sp\maps\proxywar\proxywar_heli.gsc::heli_approach_start, "Heli Approach", scripts\sp\maps\proxywar\proxywar_heli.gsc::heli_approach_main, [], scripts\sp\maps\proxywar\proxywar_heli.gsc::heli_approach_catchup);
  scripts\engine\sp\utility::add_start("forest_trees", scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_trees_start, "Forest Trees", scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_trees_main, [], scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_trees_catchup);
  scripts\engine\sp\utility::add_start("forest_overlook", scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_overlook_start, "Forest Overlook", scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_overlook_main, [], scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_overlook_catchup);
  scripts\engine\sp\utility::add_start("forest_phosphorus", scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_phosphorus_start, "Forest Phosphorus", scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_phosphorus_main, [], scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_phosphorus_catchup);
  scripts\engine\sp\utility::add_start("forest_patrol", scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_patrol_start, "Forest Patrol", scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_patrol_main, var_0, scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_patrol_catchup);
  scripts\engine\sp\utility::add_start("forest_exit", scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_exit_start, "Forest Exit", scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_exit_main, var_0, scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_exit_catchup);
  scripts\engine\sp\utility::add_start("railyard_entrance", scripts\sp\maps\proxywar\proxywar_railyard.gsc::railyard_entrance_start, "Railyard Entrance", scripts\sp\maps\proxywar\proxywar_railyard.gsc::railyard_entrance_main, var_0, scripts\sp\maps\proxywar\proxywar_railyard.gsc::railyard_entrance_catchup);
  scripts\engine\sp\utility::add_start("railyard_breach", scripts\sp\maps\proxywar\proxywar_railyard.gsc::railyard_breach_start, "Railyard Breach", scripts\sp\maps\proxywar\proxywar_railyard.gsc::railyard_breach_main, var_1, scripts\sp\maps\proxywar\proxywar_railyard.gsc::railyard_breach_catchup);
  scripts\engine\sp\utility::add_start("railyard_combat_intro", scripts\sp\maps\proxywar\proxywar_railyard.gsc::railyard_combat_intro_start, "Railyard Combat Intro", scripts\sp\maps\proxywar\proxywar_railyard.gsc::railyard_combat_intro_main, var_1, scripts\sp\maps\proxywar\proxywar_railyard.gsc::railyard_combat_intro_catchup);
  scripts\engine\sp\utility::add_start("railyard_combat", scripts\sp\maps\proxywar\proxywar_railyard.gsc::railyard_combat_start, "Railyard Combat", scripts\sp\maps\proxywar\proxywar_railyard.gsc::railyard_combat_main, var_1, scripts\sp\maps\proxywar\proxywar_railyard.gsc::railyard_combat_catchup);
  scripts\engine\sp\utility::add_start("courtyard_retreat", scripts\sp\maps\proxywar\proxywar_courtyard.gsc::courtyard_retreat_start, "Courtyard Retreat", scripts\sp\maps\proxywar\proxywar_courtyard.gsc::courtyard_retreat_main, var_2, scripts\sp\maps\proxywar\proxywar_courtyard.gsc::courtyard_retreat_catchup);
  scripts\engine\sp\utility::add_start("warehouse_enter", scripts\sp\maps\proxywar\proxywar_warehouse.gsc::warehouse_enter_start, "Warehouse Enter", scripts\sp\maps\proxywar\proxywar_warehouse.gsc::warehouse_enter_main, var_2, scripts\sp\maps\proxywar\proxywar_warehouse.gsc::warehouse_enter_catchup);
  scripts\engine\sp\utility::add_start("warehouse_discover_gas", scripts\sp\maps\proxywar\proxywar_warehouse.gsc::warehouse_discover_gas_start, "Warehouse Discover Gas", scripts\sp\maps\proxywar\proxywar_warehouse.gsc::warehouse_discover_gas_main, var_3, scripts\sp\maps\proxywar\proxywar_warehouse.gsc::warehouse_discover_gas_catchup);
  scripts\engine\sp\utility::add_start("trucks_convoy", scripts\sp\maps\proxywar\proxywar_trucks.gsc::trucks_convoy_start, "Trucks Convoy", scripts\sp\maps\proxywar\proxywar_trucks.gsc::trucks_convoy_main, var_3, scripts\sp\maps\proxywar\proxywar_trucks.gsc::trucks_convoy_catchup);
  scripts\engine\sp\utility::add_start("trucks_stolen", scripts\sp\maps\proxywar\proxywar_trucks.gsc::trucks_stolen_start, "Trucks Stolen", scripts\sp\maps\proxywar\proxywar_trucks.gsc::trucks_stolen_main, var_3, scripts\sp\maps\proxywar\proxywar_trucks.gsc::trucks_stolen_catchup);
}

proxywar_precache() {
  precacheshader("hud_icon_equipment_spotter_scope");
  precacheshader("hud_icon_equipment_spotter_scope");
  thread scripts\sp\player\offhand_box::offhand_box_setup();
  scripts\sp\maps\proxywar\proxywar_heli.gsc::proxywar_heli_precache();
  scripts\sp\maps\proxywar\proxywar_forest.gsc::proxywar_forest_precache();
  scripts\sp\maps\proxywar\proxywar_railyard.gsc::proxywar_railyard_precache();
  scripts\sp\maps\proxywar\proxywar_courtyard.gsc::proxywar_courtyard_precache();
  scripts\sp\maps\proxywar\proxywar_warehouse.gsc::proxywar_warehouse_precache();
  scripts\sp\maps\proxywar\proxywar_trucks.gsc::proxywar_trucks_precache();
}

proxywar_flags() {
  scripts\engine\utility::flag_init("nvg_on");
  scripts\sp\maps\proxywar\proxywar_vo.gsc::proxywar_vo_flags();
  scripts\sp\maps\proxywar\proxywar_heli.gsc::proxywar_heli_flags();
  scripts\sp\maps\proxywar\proxywar_forest.gsc::proxywar_forest_flags();
  scripts\sp\maps\proxywar\proxywar_railyard.gsc::proxywar_railyard_flags();
  scripts\sp\maps\proxywar\proxywar_courtyard.gsc::proxywar_courtyard_flags();
  scripts\sp\maps\proxywar\proxywar_warehouse.gsc::proxywar_warehouse_flags();
  scripts\sp\maps\proxywar\proxywar_trucks.gsc::proxywar_trucks_flags();
}

proxywar_hints() {
  scripts\sp\maps\proxywar\proxywar_heli.gsc::proxywar_heli_hints();
  scripts\sp\maps\proxywar\proxywar_forest.gsc::proxywar_forest_hints();
  scripts\sp\maps\proxywar\proxywar_railyard.gsc::proxywar_railyard_hints();
  scripts\sp\maps\proxywar\proxywar_courtyard.gsc::proxywar_courtyard_hints();
  scripts\sp\maps\proxywar\proxywar_warehouse.gsc::proxywar_warehouse_hints();
  scripts\sp\maps\proxywar\proxywar_trucks.gsc::proxywar_trucks_hints();
}

proxywar_spawn_funcs() {
  scripts\sp\maps\proxywar\proxywar_forest.gsc::proxywar_forest_spawn_funcs();
  scripts\sp\maps\proxywar\proxywar_railyard.gsc::proxywar_railyard_spawn_funcs();
  scripts\sp\maps\proxywar\proxywar_courtyard.gsc::proxywar_courtyard_spawn_func();
  scripts\sp\maps\proxywar\proxywar_warehouse.gsc::proxywar_warehouse_spawn_func();
  scripts\sp\maps\proxywar\proxywar_trucks.gsc::proxywar_trucks_spawnfuncs();
}

proxywar_init() {
  scripts\sp\maps\proxywar\proxywar_heli.gsc::proxywar_heli_init();
  scripts\sp\maps\proxywar\proxywar_forest.gsc::proxywar_forest_init();
  scripts\sp\maps\proxywar\proxywar_warehouse.gsc::proxywar_warehouse_init();
  scripts\sp\maps\proxywar\proxywar_trucks.gsc::proxywar_trucks_init();
}

proxywar_loadout() {
  var_0 = ["frag", "flash", "smoke", "molotov"];
  level.player.offhands_list = var_0;
  scripts\engine\sp\utility::offhandprecache(var_0);
  var_1[0] = scripts\sp\utility::make_weapon("iw8_pi_golf21", ["laserirpstl", "silencerpstl_west01"]);
  var_1[1] = scripts\sp\utility::make_weapon("iw8_ar_mike4", ["laserir", "acog_west01_irons", "selectsemi", "silencer04"], undefined, undefined, undefined, !scripts\sp\starts::is_after_start("railyard_combat_intro"));

  foreach(var_3 in var_1) {
    level.player giveweapon(var_3);
    level.player givemaxammo(var_3);
  }

  level.player switchtoweapon(var_1[1]);
  level.player scripts\engine\sp\utility::give_offhand("flash");
  level.player scripts\engine\sp\utility::give_offhand("frag");
  level.player setviewmodel("viewmodel_arms_alex_desert");
  scripts\sp\utility::context_melee_set_arms("viewmodel_arms_alex_desert");
  level.player setshadowmodel("default_character_shadow");
  scripts\sp\maps\proxywar\proxywar_util.gsc::give_spotter_scope();
  scripts\sp\maps\proxywar\proxywar_util.gsc::give_flashlight();
}

proxywar_intro_screen() {
  scripts\engine\sp\utility::intro_screen_create(&"PROXYWAR/INTRO_TITLE", &"PROXYWAR/INTRO_DATE", &"PROXYWAR/INTRO_WHO", &"PROXYWAR/INTRO_SQUAD", &"PROXYWAR/INTRO_LOCATION");
  scripts\engine\sp\utility::intro_screen_custom_func(scripts\engine\sp\utility::empty_func);
}

proxywar_threat_bias() {
  createthreatbiasgroup("player");
  createthreatbiasgroup("axis");
  createthreatbiasgroup("allies");
  level.player setthreatbiasgroup("player");
}

proxywar_tutorials() {
  thread proxywar_check_crouch();
  thread proxywar_check_grenade_throw();
  thread proxywar_check_swap_weapon();
  thread proxywar_check_offhand_throw();
}

proxywar_check_crouch() {
  level.player_crouched = 0;

  while(level.player getstance() != "crouch")
    waitframe();

  level.player_crouched = 1;
}

proxywar_check_grenade_throw() {
  for(level.player_threw_grenade = 0; !level.player_threw_grenade; level.player_threw_grenade = var_1.basename == "frag")
    level.player waittill("grenade_fire", var_0, var_1);
}

proxywar_check_swap_weapon() {
  level.player_swapped_weapon = 0;
  level.player waittill("weapon_switch_pressed");
  level.player_swapped_weapon = 1;
}

proxywar_check_offhand_throw() {
  for(level.player_threw_offhand = 0; !level.player_threw_offhand; level.player_threw_offhand = var_1.basename == "flash" || var_1.basename == "smoke")
    level.player waittill("grenade_fire", var_0, var_1);
}