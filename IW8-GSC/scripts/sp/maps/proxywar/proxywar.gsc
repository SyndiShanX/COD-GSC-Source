/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\proxywar\proxywar.gsc
*************************************************/

function main() {
  scripts\sp\maps\proxywar\gen\proxywar_art::main();
  scripts\sp\maps\proxywar\proxywar_fx::main();
  scripts\sp\maps\proxywar\proxywar_lighting::main();
  scripts\sp\maps\proxywar\proxywar_precache::main();
  scripts\sp\maps\proxywar\proxywar_anim::main();
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

  if(scripts\sp\starts::is_first_start()) {
    proxywar_intro_screen();
  }

  thread scripts\sp\maps\proxywar\proxywar_vo::track_player_combat_time();
  thread proxywar_threat_bias();

  if(!scripts\sp\starts::is_after_start("railyard_breach") || scripts\sp\starts::is_after_start("alleyway_phosphorus")) {
    scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::battlechatter_off);
  }

  precachenightvisioncodeassets();
  setsaveddvar("TMNTMTQRM", 0);
  thread proxywar_tutorials();
  setsaveddvar("LTMPKRLLNM", 256);
  setsaveddvar("OLPNKQKKTT", 128);
}

function proxywar_starts() {
  var0 = ["pw_storage_room_interior_tr", "pw_trainyard_front_detail_tr", "pw_shack_interior_tr", "pw_trainyard_main_detail_tr"];
  var1 = ["pw_storage_room_interior_tr", "pw_trainyard_front_detail_tr", "pw_shack_interior_tr", "pw_trainyard_main_detail_tr", "pw_trainyard_track_detail_tr", "pw_control_room_interior_tr", "pw_railyard_rear_detail_tr"];
  var2 = ["pw_storage_room_interior_tr", "pw_control_room_interior_tr", "pw_shack_interior_tr", "pw_trainyard_main_detail_tr", "pw_trainyard_track_detail_tr", "pw_railyard_rear_detail_tr", "pw_courtyard_top_detail_tr", "pw_courtyard_detail_tr", "pw_warehouse_interior_tr", "pw_rearyard_detail_tr"];
  var3 = ["pw_courtyard_detail_tr", "pw_warehouse_interior_tr", "pw_rearyard_detail_tr"];
  scripts\engine\sp\utility::add_start("heli_approach", &scripts\sp\maps\proxywar\proxywar_heli::heli_approach_start, "Heli Approach", &scripts\sp\maps\proxywar\proxywar_heli::heli_approach_main, [], &scripts\sp\maps\proxywar\proxywar_heli::heli_approach_catchup);
  scripts\engine\sp\utility::add_start("forest_trees", &scripts\sp\maps\proxywar\proxywar_forest::forest_trees_start, "Forest Trees", &scripts\sp\maps\proxywar\proxywar_forest::forest_trees_main, [], &scripts\sp\maps\proxywar\proxywar_forest::forest_trees_catchup);
  scripts\engine\sp\utility::add_start("forest_overlook", &scripts\sp\maps\proxywar\proxywar_forest::forest_overlook_start, "Forest Overlook", &scripts\sp\maps\proxywar\proxywar_forest::forest_overlook_main, [], &scripts\sp\maps\proxywar\proxywar_forest::forest_overlook_catchup);
  scripts\engine\sp\utility::add_start("forest_phosphorus", &scripts\sp\maps\proxywar\proxywar_forest::forest_phosphorus_start, "Forest Phosphorus", &scripts\sp\maps\proxywar\proxywar_forest::forest_phosphorus_main, [], &scripts\sp\maps\proxywar\proxywar_forest::forest_phosphorus_catchup);
  scripts\engine\sp\utility::add_start("forest_patrol", &scripts\sp\maps\proxywar\proxywar_forest::forest_patrol_start, "Forest Patrol", &scripts\sp\maps\proxywar\proxywar_forest::forest_patrol_main, var0, &scripts\sp\maps\proxywar\proxywar_forest::forest_patrol_catchup);
  scripts\engine\sp\utility::add_start("forest_exit", &scripts\sp\maps\proxywar\proxywar_forest::forest_exit_start, "Forest Exit", &scripts\sp\maps\proxywar\proxywar_forest::forest_exit_main, var0, &scripts\sp\maps\proxywar\proxywar_forest::forest_exit_catchup);
  scripts\engine\sp\utility::add_start("railyard_entrance", &scripts\sp\maps\proxywar\proxywar_railyard::railyard_entrance_start, "Railyard Entrance", &scripts\sp\maps\proxywar\proxywar_railyard::railyard_entrance_main, var0, &scripts\sp\maps\proxywar\proxywar_railyard::railyard_entrance_catchup);
  scripts\engine\sp\utility::add_start("railyard_breach", &scripts\sp\maps\proxywar\proxywar_railyard::railyard_breach_start, "Railyard Breach", &scripts\sp\maps\proxywar\proxywar_railyard::railyard_breach_main, var1, &scripts\sp\maps\proxywar\proxywar_railyard::railyard_breach_catchup);
  scripts\engine\sp\utility::add_start("railyard_combat_intro", &scripts\sp\maps\proxywar\proxywar_railyard::railyard_combat_intro_start, "Railyard Combat Intro", &scripts\sp\maps\proxywar\proxywar_railyard::railyard_combat_intro_main, var1, &scripts\sp\maps\proxywar\proxywar_railyard::railyard_combat_intro_catchup);
  scripts\engine\sp\utility::add_start("railyard_combat", &scripts\sp\maps\proxywar\proxywar_railyard::railyard_combat_start, "Railyard Combat", &scripts\sp\maps\proxywar\proxywar_railyard::railyard_combat_main, var1, &scripts\sp\maps\proxywar\proxywar_railyard::railyard_combat_catchup);
  scripts\engine\sp\utility::add_start("courtyard_retreat", &scripts\sp\maps\proxywar\proxywar_courtyard::courtyard_retreat_start, "Courtyard Retreat", &scripts\sp\maps\proxywar\proxywar_courtyard::courtyard_retreat_main, var2, &scripts\sp\maps\proxywar\proxywar_courtyard::courtyard_retreat_catchup);
  scripts\engine\sp\utility::add_start("warehouse_enter", &scripts\sp\maps\proxywar\proxywar_warehouse::warehouse_enter_start, "Warehouse Enter", &scripts\sp\maps\proxywar\proxywar_warehouse::warehouse_enter_main, var2, &scripts\sp\maps\proxywar\proxywar_warehouse::warehouse_enter_catchup);
  scripts\engine\sp\utility::add_start("warehouse_discover_gas", &scripts\sp\maps\proxywar\proxywar_warehouse::warehouse_discover_gas_start, "Warehouse Discover Gas", &scripts\sp\maps\proxywar\proxywar_warehouse::warehouse_discover_gas_main, var3, &scripts\sp\maps\proxywar\proxywar_warehouse::warehouse_discover_gas_catchup);
  scripts\engine\sp\utility::add_start("trucks_convoy", &scripts\sp\maps\proxywar\proxywar_trucks::trucks_convoy_start, "Trucks Convoy", &scripts\sp\maps\proxywar\proxywar_trucks::trucks_convoy_main, var3, &scripts\sp\maps\proxywar\proxywar_trucks::trucks_convoy_catchup);
  scripts\engine\sp\utility::add_start("trucks_stolen", &scripts\sp\maps\proxywar\proxywar_trucks::trucks_stolen_start, "Trucks Stolen", &scripts\sp\maps\proxywar\proxywar_trucks::trucks_stolen_main, var3, &scripts\sp\maps\proxywar\proxywar_trucks::trucks_stolen_catchup);
}

function proxywar_precache() {
  precacheshader("hud_icon_equipment_spotter_scope");
  precacheshader("hud_icon_equipment_spotter_scope");
  thread scripts\sp\player\offhand_box::offhand_box_setup();
  scripts\sp\maps\proxywar\proxywar_heli::proxywar_heli_precache();
  scripts\sp\maps\proxywar\proxywar_forest::proxywar_forest_precache();
  scripts\sp\maps\proxywar\proxywar_railyard::proxywar_railyard_precache();
  scripts\sp\maps\proxywar\proxywar_courtyard::proxywar_courtyard_precache();
  scripts\sp\maps\proxywar\proxywar_warehouse::proxywar_warehouse_precache();
  scripts\sp\maps\proxywar\proxywar_trucks::proxywar_trucks_precache();
}

function proxywar_flags() {
  scripts\engine\utility::flag_init("nvg_on");
  scripts\sp\maps\proxywar\proxywar_vo::proxywar_vo_flags();
  scripts\sp\maps\proxywar\proxywar_heli::proxywar_heli_flags();
  scripts\sp\maps\proxywar\proxywar_forest::proxywar_forest_flags();
  scripts\sp\maps\proxywar\proxywar_railyard::proxywar_railyard_flags();
  scripts\sp\maps\proxywar\proxywar_courtyard::proxywar_courtyard_flags();
  scripts\sp\maps\proxywar\proxywar_warehouse::proxywar_warehouse_flags();
  scripts\sp\maps\proxywar\proxywar_trucks::proxywar_trucks_flags();
}

function proxywar_hints() {
  scripts\sp\maps\proxywar\proxywar_heli::proxywar_heli_hints();
  scripts\sp\maps\proxywar\proxywar_forest::proxywar_forest_hints();
  scripts\sp\maps\proxywar\proxywar_railyard::proxywar_railyard_hints();
  scripts\sp\maps\proxywar\proxywar_courtyard::proxywar_courtyard_hints();
  scripts\sp\maps\proxywar\proxywar_warehouse::proxywar_warehouse_hints();
  scripts\sp\maps\proxywar\proxywar_trucks::proxywar_trucks_hints();
}

function proxywar_spawn_funcs() {
  scripts\sp\maps\proxywar\proxywar_forest::proxywar_forest_spawn_funcs();
  scripts\sp\maps\proxywar\proxywar_railyard::proxywar_railyard_spawn_funcs();
  scripts\sp\maps\proxywar\proxywar_courtyard::proxywar_courtyard_spawn_func();
  scripts\sp\maps\proxywar\proxywar_warehouse::proxywar_warehouse_spawn_func();
  scripts\sp\maps\proxywar\proxywar_trucks::proxywar_trucks_spawnfuncs();
}

function proxywar_init() {
  scripts\sp\maps\proxywar\proxywar_heli::proxywar_heli_init();
  scripts\sp\maps\proxywar\proxywar_forest::proxywar_forest_init();
  scripts\sp\maps\proxywar\proxywar_warehouse::proxywar_warehouse_init();
  scripts\sp\maps\proxywar\proxywar_trucks::proxywar_trucks_init();
}

function proxywar_loadout() {
  var0 = ["frag", "flash", "smoke", "molotov"];
  level.player.offhands_list = var0;
  scripts\engine\sp\utility::offhandprecache(var0);
  GscBinSkip1(0x45, 0, scripts\sp\utility::make_weapon("iw8_pi_golf21", ["laserirpstl", "silencerpstl_west01"]));
}

function proxywar_intro_screen() {
  scripts\engine\sp\utility::intro_screen_create(&"PROXYWAR/INTRO_TITLE", &"PROXYWAR/INTRO_DATE", &"PROXYWAR/INTRO_WHO", &"PROXYWAR/INTRO_SQUAD", &"PROXYWAR/INTRO_LOCATION");
  scripts\engine\sp\utility::intro_screen_custom_func(&scripts\engine\sp\utility::empty_func);
}

function proxywar_threat_bias() {
  createthreatbiasgroup("player");
  createthreatbiasgroup("axis");
  createthreatbiasgroup("allies");
  level.player setthreatbiasgroup("player");
}

function proxywar_tutorials() {
  thread proxywar_check_crouch();
  thread proxywar_check_grenade_throw();
  thread proxywar_check_swap_weapon();
  thread proxywar_check_offhand_throw();
}

function proxywar_check_crouch() {
  level.player_crouched = 0;

  while(level.player getstance() != "crouch") {
    waitframe();
  }

  level.player_crouched = 1;
}

function proxywar_check_grenade_throw() {
  level.player_threw_grenade = 0;

  while(!level.player_threw_grenade) {
    level.player waittill("grenade_fire", var0, var1);
    level.player_threw_grenade = var1.basename == "frag";
  }
}

function proxywar_check_swap_weapon() {
  level.player_swapped_weapon = 0;
  level.player waittill("weapon_switch_pressed");
  level.player_swapped_weapon = 1;
}

function proxywar_check_offhand_throw() {
  level.player_threw_offhand = 0;

  while(!level.player_threw_offhand) {
    level.player waittill("grenade_fire", var0, var1);
    level.player_threw_offhand = var1.basename == "flash" || var1.basename == "smoke";
  }
}