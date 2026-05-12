/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_berlin.gsc
*********************************************/

func_00F9() {
  precacherumble("viewmodel_small");
  precacherumble("damage_light");
  precacherumble("damage_heavy");
  level.var_783F = 0;
  level.door_data_out_of_date = 0;
  level.zmb_uses_hint_notebook = 0;
  level.berlin_melee_weapons = ["shovel_zm", "baseballbat_aoe_zm", "baseballbat_hc_aoe_zm", "axe_aoe_zm", "blade_aoe_zm", "zom_dlc2_1hc_zm", "zom_dlc2_3hc_zm", "zom_dlc2_2hc_zm", "zom_dlc2_4_zm", "zom_dlc2_1_zm", "zom_dlc2_3_zm", "zom_dlc2_2_zm"];
  level.var_scaling_reach_min_wave = 15;
  level.var_scaling_reach_max_wave = 28;
  level.var_8AF = ::lib_0547::razergunmaxammo;
  maps\mp\mp_zombie_berlin_precache::func_F9();
  maps\createart\mp_zombie_berlin_art::func_F9();
  maps\mp\mp_zombie_berlin_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_zombie_berlin_lighting::func_F9();
  maps\mp\mp_zombie_berlin_aud::func_F9();
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_F9();
  maps\mp\mp_zombie_berlin_anim::func_F9();
  maps\mp\mp_zombie_berlin_traps::func_F9();
  maps\mp\mp_zombie_berlin_vo::func_F9();
  thread maps\mp\zombies\vignettes::vignette_init();
  maps\mp\_compass::func_8A2F("compass_map_mp_zombie_berlin");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setDvar("4341", "0");
  setDvar("1520", "-1 -1 -1 100");
  setDvar("2494", ".5, 0, 0");
  level.var_6C5F = "mp_zombie_berlin_osp";
  level.var_6C5E = "mp_zombie_berlin_osp";
  level.var_3445 = "mp_zombie_berlin_drone";
  level.var_343A = "mp_zombie_berlin_drone";
  level.var_A853 = "mp_zombie_berlin_warbird";
  level.var_A852 = "mp_zombie_berlin_warbird";
  level.upgrade_machine_reveal_func = ::maps\mp\mp_zombie_berlin_ee::wait_for_upgrade_machine_arrived;
  level.showels_beautiful_wallbuys = 1;
  level.use_zombie_unresolved_collision = 1;
  thread paired_door_handler();
  thread tether_fakery();
  level.var_ABD3 = -3500;
  level.var_AC2E = 4;
  common_scripts\utility::func_3C87("power_sz2");
  common_scripts\utility::func_3C87("airship_tethers_out");
  init_quests();
  init_zones();
  init_berlin_traps();
  level.var_AC71 = ::init_weapons;
  level.initnewzombietypes = ::init_new_zombie_types;
  thread init_sizzler_arrival();
  thread setup_objective_flags();
  thread init_casual_melee_pickups();
  thread airship_wunderbuss_picker();
  thread maps\mp\zombies\_zombies_money::func_D5();
  level thread maps\mp\zquests\zmb_secret_challenges_util::init_challenges_utility();
  level thread maps\mp\zquests\dlc2_trophies_mp_zombie_berlin::func_D5();
  level thread maps\mp\zombies\_zombies_audio_dlc2::initdlc2audio();
  level thread maps\mp\_utility::func_6F74(::mute_audio_on_intro);
  level thread maps\mp\zquests\dlc2_secrets_mp_zombie_berlin::init_dlc2_secrets_mp_zombie_berlin();
  level thread lib_0557::manage_mtx5_event();
  performance_stuff();
}

init_zones() {
  lib_055A::func_D5();
  lib_055A::func_530A("zone_underbelly_start", 1);
  lib_055A::func_530A("zone_underbelly_rubble", 0);
  lib_055A::func_530A("zone_underbelly_intact", 0);
  lib_055A::func_530A("zone_street", 0);
  lib_055A::func_530A("zone_museum_hall", 0);
  lib_055A::func_530A("zone_club_interior", 0);
  lib_055A::func_530A("zone_church_garden", 0);
  lib_055A::func_530A("zone_church_interior", 0);
  lib_055A::func_530A("zone_airship", 0);
  lib_055A::func_530A("zone_airship_middle_front", 0);
  lib_055A::func_530A("zone_airship_left", 0);
  lib_055A::func_530A("zone_airship_right", 0);
  lib_055A::func_530A("zone_finale", 0);
  lib_055A::func_993("zone_underbelly_start", "zone_underbelly_rubble", "underbelly_to_underbelly_rubble");
  lib_055A::func_993("zone_underbelly_start", "zone_underbelly_intact", "underbelly_to_underbelly_intact");
  lib_055A::func_993("zone_underbelly_intact", "zone_underbelly_rubble", "underbelly_intact_to_underbelly_rubble");
  lib_055A::func_993("zone_underbelly_rubble", "zone_street", "underbelly_rubble_to_street");
  lib_055A::func_993("zone_underbelly_intact", "zone_street", "underbelly_intact_to_street");
  lib_055A::func_993("zone_street", "zone_museum_hall", "street_to_museum");
  lib_055A::func_993("zone_club_interior", "zone_street", "street_to_club");
  lib_055A::func_993("zone_museum_hall", "zone_church_garden", "museum_to_garden");
  lib_055A::func_993("zone_club_interior", "zone_church_garden", "club_to_garden");
  lib_055A::func_993("zone_church_garden", "zone_church_interior", "garden_to_church");
  lib_055A::func_993("zone_church_garden", "zone_finale", "flag_hc_quest_finale_door_open");
  lib_055A::func_993("zone_airship", "zone_street", "flag_drop_pod_reached_airship");
  lib_055A::func_993("zone_airship", "zone_airship_middle_front", "flag_open_cargobay_complete");
  lib_055A::func_993("zone_airship_middle_front", "zone_airship_right", "flag_open_cargobay_right_complete");
  lib_055A::func_993("zone_airship_middle_front", "zone_airship_left", "flag_open_cargobay_left_complete");
  level.zmb_registered_quest_zones = [];
  foreach(var_02, var_01 in level.var_AC80.var_ACB3) {
    if(issubstr(var_02, "airship")) {
      level.zmb_registered_quest_zones = common_scripts\utility::func_F6F(level.zmb_registered_quest_zones, var_02);
    }
  }

  level.zmb_registered_quest_zones = common_scripts\utility::func_F6F(level.zmb_registered_quest_zones, "zone_finale");
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_START", "underbelly_to_underbelly_intact", 0);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_INTACT", "underbelly_to_underbelly_intact", 1);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_START", "underbelly_to_underbelly_rubble", 0);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_RUBBLE", "underbelly_to_underbelly_rubble", 1);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_RUBBLE", "underbelly_rubble_to_street", 0);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_STREET", "underbelly_rubble_to_street", 1);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_INTACT", "underbelly_intact_to_underbelly_rubble", 0);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_RUBBLE", "underbelly_intact_to_underbelly_rubble", 1);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_INTACT", "underbelly_intact_to_street", 0);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_STREET", "underbelly_intact_to_street", 1);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_MUSEUM_HALL", "street_to_museum", 0);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_STREET", "street_to_museum", 1);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_CLUB_INTERIOR", "street_to_club", 0);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_STREET", "street_to_club", 1);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_CHURCH_GARDEN", "club_to_garden", 0);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_CLUB_INTERIOR", "club_to_garden", 1);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_CHURCH_GARDEN", "museum_to_garden", 0);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_MUSEUM_HALL", "museum_to_garden", 1);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_CHURCH_GARDEN", "garden_to_church", 0);
  lib_053F::func_7BE6(&"ZOMBIE_BERLIN_AREA_CHURCH_INTERIOR", "garden_to_church", 1);
  lib_055A::func_88A();
  level.var_6BB0 = ::maps\mp\mp_zombie_berlin_utils::onberlinstartgame;
}

init_drop_pod_doors() {
  wait 0.05;
  wait 0.05;
  wait 0.05;
  var_00 = common_scripts\utility::func_46B7("door", "targetname");
  foreach(var_02 in var_00) {
    foreach(var_04 in var_02.var_8301) {
      if(var_04 method_85CE() == "animated_zbr_drop_pod") {
        var_04 setscriptablepartstate("light", "red", 0);
      }
    }
  }
}

init_quests() {
  common_scripts\utility::func_3C87("berlin_cinematic_done");
  lib_0557::func_786C();
  thread maps\mp\mp_zombie_berlin_ee::func_D5();
  thread maps\mp\mp_zombie_berlin_ee_hc::func_D5();
  thread init_berlin_quest_notebook();
}

all_flags_exist(param_00) {
  foreach(var_02 in param_00) {
    if(!common_scripts\utility::func_3C83(var_02)) {
      return 0;
    }
  }

  return 1;
}

init_berlin_quest_notebook() {
  var_00 = "flag_hc_projector_notebook";
  var_01 = ["flag_quest_wunderbuss_battery_collected", "flag_quest_wunderbuss_geistbolt_collected", maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("wunderbuss_zm"), "pap_ww_blasted_2", "flag_hc_quest_bat_step01_contact_survivor_complete", "flag_hc_quest_bat_step02_give_weapon_complete", "flag_hc_quest_bat_step02_give_jolts_complete", maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("bat"), lib_0557::func_7838("quest_contact_hq", "step_use_radio"), "quest_contact_soviets", lib_0557::func_7838("quest_draw_airship", "step_ignite_flare"), lib_0557::func_7838("quest_bring_down_airship", "step_reel_anchors"), "apartment_dagger_painting_found", var_00, maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("dagger"), "flag_hc_quest_finale_door_open", "statue_puzzle_success", maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("sword"), "flag_hc_quest_axe_step02_obtained_scale_cup", "flag_hc_quest_axe_step03_placed_sizzler_armored_head", maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("pickaxe"), "quest_bring_down_airship", "quest_defeat_straub", "berlin_cinematic_done"];
  foreach(var_03 in [maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("bat"), maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("sword"), maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("pickaxe"), maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("dagger"), maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("wunderbuss_zm"), var_00]) {
    common_scripts\utility::func_3C87(var_03);
  }

  for(var_05 = 0; !all_flags_exist(var_01); var_05++) {
    wait 0.05;
  }

  var_06 = ["flag_hc_quest_dagger_step01_painting_complete", "flag_hc_quest_dagger_step01_projector_on_complete"];
  lib_0547::func_3C8A(var_06, var_00);
  foreach(var_03 in var_01) {
    lib_0557::func_AB8C(var_03);
  }
}

init_berlin_traps() {
  thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_tank", "active", ::maps\mp\mp_zombie_berlin_trap_tank::trap_tank);
  thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_bomber_prop", "active", ::maps\mp\mp_zombie_berlin_trap_bomber_prop::trap_bomber_prop);
  thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_cage_blitz", "active", ::maps\mp\mp_zombie_berlin_trap_cage_blitz::trap_cage_blitz);
}

init_weapons() {
  maps\mp\zombies\weapons\_zombie_wunderbuss::func_D5();
  level thread maps\mp\zombies\weapons\_zombie_dlc2_melee::func_D5();
  level thread lib_057D::func_5162();
  level thread maps\mp\zombies\weapons\_zombie_razer_gun::func_D5();
  level thread lib_0580::func_D5();
}

setup_objective_flags() {}

paired_door_handler() {
  thread church_door_listener();
  thread cabaret_door_listener();
  thread museum_door_listener();
}

init_new_zombie_types() {
  maps\mp\zombies\zombie_sizzler::func_D5();
  maps\mp\zombies\zombie_bob::func_D5();
}

init_sizzler_arrival() {
  common_scripts\utility::func_3C87("flag_sizzlers_active");
  common_scripts\utility::func_3C9F("flag_sizzlers_active");
  if(isDefined(level.straub_airship)) {
    level.straub_airship.canmakesizzlers = 1;
  }

  make_fodders_sizzler_airship();
}

make_fodders_sizzler_airship() {
  level endon("entered_airship_sizzler_pause");
  while(!isDefined(level.maxactivesizzlers)) {
    wait 0.05;
  }

  while(common_scripts\utility::func_3C77("flag_sizzlers_active")) {
    if(common_scripts\utility::func_562E(level.straub_airship.canmakesizzlers)) {
      maps\mp\mp_zombie_berlin_utils::airship_turret_update_valid_targets();
    }

    wait(5);
  }
}

sizzler_max_count_manager() {
  level endon("entered_airship_sizzler_pause");
  common_scripts\utility::func_3C9F("flag_airship_summoned");
  level.next_sizzler_inc_round = level.var_A980 + randomintrange(3, 5);
  for(;;) {
    while(level.var_A980 < level.next_sizzler_inc_round) {
      level waittill("zombie_wave_started");
    }

    if(level.maxactivesizzlers < 6) {
      level.maxactivesizzlers++;
      level.next_sizzler_inc_round = level.var_A980 + randomintrange(3, 5);
    } else {
      return;
    }

    level waittill("zombie_wave_ended");
  }
}

mute_audio_on_intro() {
  self method_8626("berl_intro_movie");
  while(!level.var_3FA6) {
    self freezecontrols(1);
    self method_812B(0);
    self method_8324();
    self method_84CB();
    wait 0.05;
  }

  self freezecontrols(0);
  self method_812B(1);
  self method_8325();
  self method_84CC();
  self method_8627("berl_intro_movie");
}

init_casual_melee_pickups() {
  var_00 = getent("casual_knife_pickup_trig", "targetname");
  var_01 = getent("casual_bat_pickup_trig", "targetname");
  var_02 = getent("casual_axe_pickup_trig", "targetname");
  var_03 = getent("shovel_pickup_trig", "targetname");
  var_00 sethintstring(&"ZOMBIE_BERLIN_HINT_ITEM_CASUAL_KNIFE");
  var_01 sethintstring(&"ZOMBIE_BERLIN_HINT_ITEM_CASUAL_BAT");
  var_02 sethintstring(&"ZOMBIE_BERLIN_HINT_ITEM_CASUAL_AXE");
  var_03 sethintstring(&"ZOMBIE_BERLIN_HINT_ITEM_CASUAL_SHOVEL");
  level thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_01, "bat_casual");
  level thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_00, "dagger_casual");
  level thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_02, "pickaxe_casual");
  level thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_03, "shovel_casual");
}

performance_stuff() {
  if(level.var_149 && getDvar("3957") == "true") {
    var_00 = 1;
  }
}

church_door_listener() {
  common_scripts\utility::func_3C87("garden_to_church");
  common_scripts\utility::func_3C9F("garden_to_church");
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_819A) && var_01.var_819A == "garden_to_church" && !isDefined(var_01.var_6BE1) || !var_01.var_6BE1) {
      var_01 notify("open", undefined);
    }
  }
}

cabaret_door_listener() {
  common_scripts\utility::func_3C87("club_to_garden");
  common_scripts\utility::func_3C9F("club_to_garden");
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_819A) && var_01.var_819A == "club_to_garden" && !isDefined(var_01.var_6BE1) || !var_01.var_6BE1) {
      var_01 notify("open", undefined);
    }
  }
}

museum_door_listener() {
  common_scripts\utility::func_3C87("museum_to_garden");
  common_scripts\utility::func_3C9F("museum_to_garden");
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_819A) && var_01.var_819A == "museum_to_garden" && !isDefined(var_01.var_6BE1) || !var_01.var_6BE1) {
      var_01 notify("open", undefined);
    }
  }
}

tether_fakery() {
  level waittill("airship_anchor_courtyard_impact");
  level.tether_fakery_vol = getent("tether_fakery_vol", "targetname");
  var_00 = 225;
  for(;;) {
    foreach(var_02 in level.var_744A) {
      var_02 tether_fakery_update(var_00);
    }

    wait(0.25);
  }
}

tether_fakery_update(param_00) {
  level endon("flag_hc_quest_finale_door_open");
  if(!isDefined(self.fake_tether_visible)) {
    self.fake_tether_visible = 0;
  }

  if(self istouching(level.tether_fakery_vol) && !self.fake_tether_visible && !common_scripts\utility::func_3C77("flag_hc_quest_finale_door_open")) {
    self.fake_tether_visible = 1;
    common_scripts\_exploder::func_88E(param_00, self);
  }

  if(!self istouching(level.tether_fakery_vol) && self.fake_tether_visible) {
    self.fake_tether_visible = 0;
    common_scripts\_exploder::func_2A6D(param_00, self, 1);
  }
}

airship_wunderbuss_picker() {
  var_00 = getent("airship_wunderbuss_pickup_trig", "targetname");
  var_00 sethintstring(&"ZOMBIE_BERLIN_WEAPON_PICKUP");
  for(;;) {
    var_00 waittill("trigger", var_01);
    var_02 = 0;
    var_03 = var_01 getweaponslistprimaries();
    foreach(var_05 in var_03) {
      if(var_05 == "wunderbuss_zm") {
        var_02 = 1;
      }
    }

    if(!var_02) {
      maps\mp\zombies\_zombies_magicbox::func_A7D6(var_01, "wunderbuss_zm");
      var_01 lib_0586::func_78E("wunderbuss_zm");
    }
  }
}