/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_berlin.gsc
************************************************/

main() {
  _precacherumble("viewmodel_small");
  _precacherumble("damage_light");
  _precacherumble("damage_heavy");
  level._id_783F = 0;
  level.door_data_out_of_date = 0;
  level.zmb_uses_hint_notebook = 0;
  level.berlin_melee_weapons = ["shovel_zm", "baseballbat_aoe_zm", "baseballbat_hc_aoe_zm", "axe_aoe_zm", "blade_aoe_zm", "zom_dlc2_1hc_zm", "zom_dlc2_3hc_zm", "zom_dlc2_2hc_zm", "zom_dlc2_4_zm", "zom_dlc2_1_zm", "zom_dlc2_3_zm", "zom_dlc2_2_zm"];
  level.var_scaling_reach_min_wave = 15;
  level.var_scaling_reach_max_wave = 28;
  level._id_08AF = _id_0547::razergunmaxammo;
  maps\mp\mp_zombie_berlin_precache::main();
  maps\createart\mp_zombie_berlin_art::main();
  maps\mp\mp_zombie_berlin_fx::main();
  _id_0483::main();
  maps\mp\mp_zombie_berlin_lighting::main();
  maps\mp\mp_zombie_berlin_aud::main();
  maps\mp\mp_zombie_nest_ee_wave_manipulation::main();
  maps\mp\mp_zombie_berlin_anim::main();
  maps\mp\mp_zombie_berlin_traps::main();
  maps\mp\mp_zombie_berlin_vo::main();
  thread maps\mp\zombies\vignettes::vignette_init();
  _id_0472::_id_8A2F("compass_map_mp_zombie_berlin");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setDvar("4341", "0");
  setDvar("1520", "-1 -1 -1 100");
  setDvar("2494", ".5, 0, 0");
  level._id_6C5F = "mp_zombie_berlin_osp";
  level._id_6C5E = "mp_zombie_berlin_osp";
  level._id_3445 = "mp_zombie_berlin_drone";
  level._id_343A = "mp_zombie_berlin_drone";
  level._id_A853 = "mp_zombie_berlin_warbird";
  level._id_A852 = "mp_zombie_berlin_warbird";
  level.upgrade_machine_reveal_func = maps\mp\mp_zombie_berlin_ee::wait_for_upgrade_machine_arrived;
  level.showels_beautiful_wallbuys = 1;
  level.use_zombie_unresolved_collision = 1;
  thread paired_door_handler();
  thread tether_fakery();
  level._id_ABD3 = -3500;
  level._id_AC2E = 4;
  common_scripts\utility::flag_init("power_sz2");
  common_scripts\utility::flag_init("airship_tethers_out");
  init_quests();
  init_zones();
  init_berlin_traps();
  level._id_AC71 = ::init_weapons;
  level.initnewzombietypes = ::init_new_zombie_types;
  thread init_sizzler_arrival();
  thread setup_objective_flags();
  thread init_casual_melee_pickups();
  thread airship_wunderbuss_picker();
  thread _id_0544::init();
  level thread maps\mp\zquests\zmb_secret_challenges_util::init_challenges_utility();
  level thread maps\mp\zquests\dlc2_trophies_mp_zombie_berlin::init();
  level thread maps\mp\zombies\_zombies_audio_dlc2::initdlc2audio();
  level thread maps\mp\_utility::_id_6F74(::mute_audio_on_intro);
  level thread maps\mp\zquests\dlc2_secrets_mp_zombie_berlin::init_dlc2_secrets_mp_zombie_berlin();
  level thread _id_0557::manage_mtx5_event();
  performance_stuff();
}

init_zones() {
  _id_055A::init();
  _id_055A::_id_530A("zone_underbelly_start", 1);
  _id_055A::_id_530A("zone_underbelly_rubble", 0);
  _id_055A::_id_530A("zone_underbelly_intact", 0);
  _id_055A::_id_530A("zone_street", 0);
  _id_055A::_id_530A("zone_museum_hall", 0);
  _id_055A::_id_530A("zone_club_interior", 0);
  _id_055A::_id_530A("zone_church_garden", 0);
  _id_055A::_id_530A("zone_church_interior", 0);
  _id_055A::_id_530A("zone_airship", 0);
  _id_055A::_id_530A("zone_airship_middle_front", 0);
  _id_055A::_id_530A("zone_airship_left", 0);
  _id_055A::_id_530A("zone_airship_right", 0);
  _id_055A::_id_530A("zone_finale", 0);
  _id_055A::_id_0993("zone_underbelly_start", "zone_underbelly_rubble", "underbelly_to_underbelly_rubble");
  _id_055A::_id_0993("zone_underbelly_start", "zone_underbelly_intact", "underbelly_to_underbelly_intact");
  _id_055A::_id_0993("zone_underbelly_intact", "zone_underbelly_rubble", "underbelly_intact_to_underbelly_rubble");
  _id_055A::_id_0993("zone_underbelly_rubble", "zone_street", "underbelly_rubble_to_street");
  _id_055A::_id_0993("zone_underbelly_intact", "zone_street", "underbelly_intact_to_street");
  _id_055A::_id_0993("zone_street", "zone_museum_hall", "street_to_museum");
  _id_055A::_id_0993("zone_club_interior", "zone_street", "street_to_club");
  _id_055A::_id_0993("zone_museum_hall", "zone_church_garden", "museum_to_garden");
  _id_055A::_id_0993("zone_club_interior", "zone_church_garden", "club_to_garden");
  _id_055A::_id_0993("zone_church_garden", "zone_church_interior", "garden_to_church");
  _id_055A::_id_0993("zone_church_garden", "zone_finale", "flag_hc_quest_finale_door_open");
  _id_055A::_id_0993("zone_airship", "zone_street", "flag_drop_pod_reached_airship");
  _id_055A::_id_0993("zone_airship", "zone_airship_middle_front", "flag_open_cargobay_complete");
  _id_055A::_id_0993("zone_airship_middle_front", "zone_airship_right", "flag_open_cargobay_right_complete");
  _id_055A::_id_0993("zone_airship_middle_front", "zone_airship_left", "flag_open_cargobay_left_complete");
  level.zmb_registered_quest_zones = [];

  foreach(var_2, var_1 in level._id_AC80._id_ACB3) {
    if(issubstr(var_2, "airship"))
      level.zmb_registered_quest_zones = common_scripts\utility::_id_0F6F(level.zmb_registered_quest_zones, var_2);
  }

  level.zmb_registered_quest_zones = common_scripts\utility::_id_0F6F(level.zmb_registered_quest_zones, "zone_finale");
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_START", "underbelly_to_underbelly_intact", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_INTACT", "underbelly_to_underbelly_intact", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_START", "underbelly_to_underbelly_rubble", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_RUBBLE", "underbelly_to_underbelly_rubble", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_RUBBLE", "underbelly_rubble_to_street", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_STREET", "underbelly_rubble_to_street", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_INTACT", "underbelly_intact_to_underbelly_rubble", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_RUBBLE", "underbelly_intact_to_underbelly_rubble", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_UNDERBELLY_INTACT", "underbelly_intact_to_street", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_STREET", "underbelly_intact_to_street", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_MUSEUM_HALL", "street_to_museum", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_STREET", "street_to_museum", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_CLUB_INTERIOR", "street_to_club", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_STREET", "street_to_club", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_CHURCH_GARDEN", "club_to_garden", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_CLUB_INTERIOR", "club_to_garden", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_CHURCH_GARDEN", "museum_to_garden", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_MUSEUM_HALL", "museum_to_garden", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_CHURCH_GARDEN", "garden_to_church", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_BERLIN_AREA_CHURCH_INTERIOR", "garden_to_church", 1);
  _id_055A::_id_088A();
  level._id_6BB0 = maps\mp\mp_zombie_berlin_utils::onberlinstartgame;
}

init_drop_pod_doors() {
  waitframe();
  waitframe();
  waitframe();
  var_0 = common_scripts\utility::_id_46B7("door", "targetname");

  foreach(var_2 in var_0) {
    foreach(var_4 in var_2.setclientdvars) {
      if(var_4 _meth_85CE() == "animated_zbr_drop_pod")
        var_4 setscriptablepartstate("light", "red", 0);
    }
  }
}

init_quests() {
  common_scripts\utility::flag_init("berlin_cinematic_done");
  _id_0557::_id_786C();
  thread maps\mp\mp_zombie_berlin_ee::init();
  thread maps\mp\mp_zombie_berlin_ee_hc::init();
  thread init_berlin_quest_notebook();
}

all_flags_exist(var_0) {
  foreach(var_2 in var_0) {
    if(!common_scripts\utility::_id_3C83(var_2))
      return 0;
  }

  return 1;
}

init_berlin_quest_notebook() {
  var_0 = "flag_hc_projector_notebook";
  var_1 = ["flag_quest_wunderbuss_battery_collected", "flag_quest_wunderbuss_geistbolt_collected", maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("wunderbuss_zm"), "pap_ww_blasted_2", "flag_hc_quest_bat_step01_contact_survivor_complete", "flag_hc_quest_bat_step02_give_weapon_complete", "flag_hc_quest_bat_step02_give_jolts_complete", maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("bat"), _id_0557::_id_7838("quest_contact_hq", "step_use_radio"), "quest_contact_soviets", _id_0557::_id_7838("quest_draw_airship", "step_ignite_flare"), _id_0557::_id_7838("quest_bring_down_airship", "step_reel_anchors"), "apartment_dagger_painting_found", var_0, maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("dagger"), "flag_hc_quest_finale_door_open", "statue_puzzle_success", maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("sword"), "flag_hc_quest_axe_step02_obtained_scale_cup", "flag_hc_quest_axe_step03_placed_sizzler_armored_head", maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("pickaxe"), "quest_bring_down_airship", "quest_defeat_straub", "berlin_cinematic_done"];

  foreach(var_3 in [maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("bat"), maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("sword"), maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("pickaxe"), maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("dagger"), maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("wunderbuss_zm"), var_0])
  common_scripts\utility::flag_init(var_3);

  for(var_5 = 0; !all_flags_exist(var_1); var_5++)
    waitframe();

  var_6 = ["flag_hc_quest_dagger_step01_painting_complete", "flag_hc_quest_dagger_step01_projector_on_complete"];
  _id_0547::_id_3C8A(var_6, var_0);

  foreach(var_3 in var_1)
  _id_0557::_id_AB8C(var_3);
}

init_berlin_traps() {
  thread _id_0546::_id_9CC6("trap_tank", "active", maps\mp\mp_zombie_berlin_trap_tank::trap_tank);
  thread _id_0546::_id_9CC6("trap_bomber_prop", "active", maps\mp\mp_zombie_berlin_trap_bomber_prop::trap_bomber_prop);
  thread _id_0546::_id_9CC6("trap_cage_blitz", "active", maps\mp\mp_zombie_berlin_trap_cage_blitz::trap_cage_blitz);
}

init_weapons() {
  maps\mp\zombies\weapons\_zombie_wunderbuss::init();
  level thread maps\mp\zombies\weapons\_zombie_dlc2_melee::init();
  level thread _id_057D::_id_5162();
  level thread maps\mp\zombies\weapons\_zombie_razer_gun::init();
  level thread _id_0580::init();
}

setup_objective_flags() {}

paired_door_handler() {
  thread church_door_listener();
  thread cabaret_door_listener();
  thread museum_door_listener();
}

init_new_zombie_types() {
  maps\mp\zombies\zombie_sizzler::init();
  maps\mp\zombies\zombie_bob::init();
}

init_sizzler_arrival() {
  common_scripts\utility::flag_init("flag_sizzlers_active");
  common_scripts\utility::_id_3C9F("flag_sizzlers_active");

  if(isDefined(level.straub_airship))
    level.straub_airship.canmakesizzlers = 1;

  make_fodders_sizzler_airship();
}

make_fodders_sizzler_airship() {
  level endon("entered_airship_sizzler_pause");

  while(!isDefined(level.maxactivesizzlers))
    waitframe();

  while(common_scripts\utility::_id_3C77("flag_sizzlers_active")) {
    if(common_scripts\utility::_id_562E(level.straub_airship.canmakesizzlers))
      maps\mp\mp_zombie_berlin_utils::airship_turret_update_valid_targets();

    wait 5;
  }
}

sizzler_max_count_manager() {
  level endon("entered_airship_sizzler_pause");
  common_scripts\utility::_id_3C9F("flag_airship_summoned");
  level.next_sizzler_inc_round = level._id_A980 + _randomintrange(3, 5);

  for(;;) {
    while(level._id_A980 < level.next_sizzler_inc_round)
      level waittill("zombie_wave_started");

    if(level.maxactivesizzlers < 6) {
      level.maxactivesizzlers++;
      level.next_sizzler_inc_round = level._id_A980 + _randomintrange(3, 5);
    } else
      return;

    level waittill("zombie_wave_ended");
  }
}

mute_audio_on_intro() {
  self clientaddsoundsubmix("berl_intro_movie");

  while(!level.gamehasstarted) {
    self freezecontrols(1);
    self allowfire(0);
    self disableoffhandweapons();
    self disableoffhandsecondaryweapons();
    waitframe();
  }

  self freezecontrols(0);
  self allowfire(1);
  self enableoffhandweapons();
  self enableoffhandsecondaryweapons();
  self clientclearsoundsubmix("berl_intro_movie");
}

init_casual_melee_pickups() {
  var_0 = _getent("casual_knife_pickup_trig", "targetname");
  var_1 = _getent("casual_bat_pickup_trig", "targetname");
  var_2 = _getent("casual_axe_pickup_trig", "targetname");
  var_3 = _getent("shovel_pickup_trig", "targetname");
  var_0 sethintstring(&"ZOMBIE_BERLIN_HINT_ITEM_CASUAL_KNIFE");
  var_1 sethintstring(&"ZOMBIE_BERLIN_HINT_ITEM_CASUAL_BAT");
  var_2 sethintstring(&"ZOMBIE_BERLIN_HINT_ITEM_CASUAL_AXE");
  var_3 sethintstring(&"ZOMBIE_BERLIN_HINT_ITEM_CASUAL_SHOVEL");
  level thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_1, "bat_casual");
  level thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_0, "dagger_casual");
  level thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_2, "pickaxe_casual");
  level thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_3, "shovel_casual");
}

performance_stuff() {
  if(level._id_0149 && getDvar("3957") == "true")
    var_0 = 1;
}

church_door_listener() {
  common_scripts\utility::flag_init("garden_to_church");
  common_scripts\utility::_id_3C9F("garden_to_church");

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1.getnegotiationnextnode) && var_1.getnegotiationnextnode == "garden_to_church" && (!isDefined(var_1._id_6BE1) || !var_1._id_6BE1))
      var_1 notify("open", undefined);
  }
}

cabaret_door_listener() {
  common_scripts\utility::flag_init("club_to_garden");
  common_scripts\utility::_id_3C9F("club_to_garden");

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1.getnegotiationnextnode) && var_1.getnegotiationnextnode == "club_to_garden" && (!isDefined(var_1._id_6BE1) || !var_1._id_6BE1))
      var_1 notify("open", undefined);
  }
}

museum_door_listener() {
  common_scripts\utility::flag_init("museum_to_garden");
  common_scripts\utility::_id_3C9F("museum_to_garden");

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1.getnegotiationnextnode) && var_1.getnegotiationnextnode == "museum_to_garden" && (!isDefined(var_1._id_6BE1) || !var_1._id_6BE1))
      var_1 notify("open", undefined);
  }
}

tether_fakery() {
  level waittill("airship_anchor_courtyard_impact");
  level.tether_fakery_vol = _getent("tether_fakery_vol", "targetname");
  var_0 = 225;

  for(;;) {
    foreach(var_2 in level.players)
    var_2 tether_fakery_update(var_0);

    wait 0.25;
  }
}

tether_fakery_update(var_0) {
  level endon("flag_hc_quest_finale_door_open");

  if(!isDefined(self.fake_tether_visible))
    self.fake_tether_visible = 0;

  if(self istouching(level.tether_fakery_vol) && !self.fake_tether_visible && !common_scripts\utility::_id_3C77("flag_hc_quest_finale_door_open")) {
    self.fake_tether_visible = 1;
    common_scripts\_exploder::_id_088E(var_0, self);
  }

  if(!self istouching(level.tether_fakery_vol) && self.fake_tether_visible) {
    self.fake_tether_visible = 0;
    common_scripts\_exploder::_id_2A6D(var_0, self, 1);
  }
}

airship_wunderbuss_picker() {
  var_0 = _getent("airship_wunderbuss_pickup_trig", "targetname");
  var_0 sethintstring(&"ZOMBIE_BERLIN_WEAPON_PICKUP");

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_2 = 0;
    var_3 = var_1 getweaponlistprimaries();

    foreach(var_5 in var_3) {
      if(var_5 == "wunderbuss_zm")
        var_2 = 1;
    }

    if(!var_2) {
      _id_0548::_id_A7D6(var_1, "wunderbuss_zm");
      var_1 _id_0586::_id_078E("wunderbuss_zm");
    }
  }
}