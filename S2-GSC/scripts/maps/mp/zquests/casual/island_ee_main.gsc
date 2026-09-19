/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zquests\casual\island_ee_main.gsc
*************************************************************/

init_difficulty_settings() {
  level.zmb_island_escorts_wave_penalty = 1;
  level.zmb_anointed_pest_dies_to_ripsaw_gun = 0;
  level.pommel_room_boss_peacetime = 10;
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_escort_bomber_health", 225, 100);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_escort_hc_pest_spawn_rate", 1, 0.4);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_escort_hc_pest_spawn_numbers", [6, 6, 10, 12]);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_escort_hc_pest_health_buddy", 10, 24, ::current_fodder_zombie_health, 20);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_escort_hc_pest_health_main", 15, 35, ::current_fodder_zombie_health, 20);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_escort_hc_follower_spawn_numbers", [2, 3, 3, 4]);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_escort_hc_follower_health_buddy", 30, 45, ::current_fodder_zombie_health, 20);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_escort_hc_follower_health_main", 45, 65, ::current_fodder_zombie_health, 20);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_escort_hc_assassin_health_main", 55, 70, ::current_fodder_zombie_health, 20);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_assassin_boss_health_1", 20, 40, ::current_fodder_zombie_health, 20);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_assassin_boss_health_2", 20, 40, ::current_fodder_zombie_health, 20);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_assassin_boss_health_3", 23, 50, ::current_fodder_zombie_health, 20);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_assassin_boss_health_4", 25, 55, ::current_fodder_zombie_health, 20);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_assassin_boss_fireman_health", 25, 30, ::current_fodder_zombie_health, 20);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_pommel_room_sacrifice_requirements", [50, 75, 75, 75]);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_assassin_boss_phase_1_zombie_count", 6, 8);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_assassin_boss_phase_2_zombie_count", 8, 12);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_assassin_boss_phase_3_zombie_count", 10, 14);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_assassin_boss_phase_4_zombie_count", 14, 14);
  maps\mp\zquests\casual\island_ee_util::add_difficulty_setting("zmb_assassin_boss_num_fire_panels", [5, 5, 6, 7]);
}

current_fodder_zombie_health(var_0) {
  if(level._id_A980 < var_0)
    var_1 = var_0;
  else
    var_1 = level._id_A980;

  return maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), var_1);
}

get_difficulty_setting(var_0, var_1) {
  var_2 = level.zmb_island_difficulty_settings[var_0];

  if(_func_0C0(var_2))
    var_3 = var_2[level.players.size - 1];
  else {
    var_4 = _func_2CA(var_2.minval, var_2.maxval, maps\mp\zquests\casual\island_ee_util::get_player_frac(level.players.size));
    var_3 = var_4 * [[var_2._id_3F02]](var_2._id_6E5C);
  }

  return var_3;
}

init() {
  common_scripts\utility::flag_init("dont_spawn_fireman");
  common_scripts\utility::flag_init("fireman_defeated");
  common_scripts\utility::flag_init("flag_map_collected");
  common_scripts\utility::flag_init("flag_corpse_door_found");
  common_scripts\utility::flag_init("flag_ranger_head_taken");
  common_scripts\utility::flag_init("flag_ranger_head_placed");
  common_scripts\utility::flag_init("flag_subpen_traps_completed");
  common_scripts\utility::flag_init("flag_freezer_combat_started");
  common_scripts\utility::flag_init("flag_crane_in_motion");
  common_scripts\utility::flag_init("flag_loader_complete");
  common_scripts\utility::flag_init("fuel_valve_1");
  common_scripts\utility::flag_init("fuel_valve_2");
  common_scripts\utility::flag_init("fuel_valve_3");
  common_scripts\utility::flag_init("flag_open_corpse_door");
  common_scripts\utility::flag_init("razergun_1_placed");
  common_scripts\utility::flag_init("razergun_2_placed");
  common_scripts\utility::flag_init("razergun_3_placed");
  common_scripts\utility::flag_init("players_have_razergun_1");
  common_scripts\utility::flag_init("players_have_razergun_2");
  common_scripts\utility::flag_init("players_have_razergun_3");
  common_scripts\utility::flag_init("razergun_charged");
  common_scripts\utility::flag_init("razergun_half_charged");
  common_scripts\utility::flag_init("razergun_infused");
  common_scripts\utility::flag_init("flag_straub_finishes_plane_talk");
  common_scripts\utility::flag_init("flag_ui_planes_ee_done");
  common_scripts\utility::flag_init("flag_used_island_turret");
  common_scripts\utility::flag_init("flag_players_have_won");
  common_scripts\utility::flag_init("flag_aa_guns_powered_on");
  common_scripts\utility::flag_init("flag_radio_part_1_collected");
  common_scripts\utility::flag_init("flag_radio_part_2_collected");
  common_scripts\utility::flag_init("flag_hc_bomb_escort_complete");
  common_scripts\utility::flag_init("flag_loader_zombie_unavailable");
  common_scripts\utility::flag_init("flag_bomber_wave_punished");
  common_scripts\utility::flag_init("flag_first_ship_spawned");
  common_scripts\utility::flag_init("flag_destroyers_quest_complete");
  common_scripts\utility::flag_init("flag_artillery_out_of_ammo_quest_started");
  common_scripts\utility::flag_init("all wustlings spawned");
  common_scripts\utility::flag_init("can_spawn_");
  common_scripts\utility::flag_init("bring_in_next_type");
  common_scripts\utility::flag_init("flag_first_plane_has_spawn");
  common_scripts\utility::flag_init("flag_vo_inside_subpen");
  common_scripts\utility::flag_init("flag_vo_subcrates");
  common_scripts\utility::flag_init("flag_lookat_radio_dude");
  common_scripts\utility::flag_init("frontline_zombies_spawned");
  common_scripts\utility::flag_init("spawn_ships_straub_monologue_complete");
  thread vo_inside_subpens();
  thread setup_aa_guns_power_switch();
  thread blood_trail_vo();
  level.intro_zombies_sprint = 0;
  level.zombies_killed_in_intro = 0;
  level.subpen_switches_on = 0;
  level.the_classic_donation = 0;
  level.show_spine_harvest_text = 0;
  level thread aa_gun_trap_init();
  level thread maps\mp\_utility::_id_6F74(::playerinwaterthink);
  level thread maps\mp\_utility::_id_6F74(::beachassaultfadein);
  level thread spawn_heavies_pommel_room();
  _id_0557::_id_7846("Explore the Beach", _id_0557::_id_30D8, [], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Explore the Beach", "Survive the Beach", ::quest_step_do_intro_assault, ::quest_step_intro_on_complete, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Explore the Beach", "Reach Sub Pens", ::quest_step_reach_pen, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("Explore the Beach");
  thread quest_init_intro();
  _id_0557::_id_7846("explore_the_island", _id_0557::_id_30D8, ["Explore the Beach"], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("explore_the_island", "Pen Power", ::_id_784F, ::quest_step_complete_enable_power, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("explore_the_island", "Explore Pen", ::quest_step_wait_for_corpsegate_found, ::quest_step_complete_wait_for_corpsegate_found, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("explore_the_island");
  _id_0557::_id_7846("CORPSE_GATE", _id_0557::_id_30D8, ["Aquire Wonder Weapon"], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("CORPSE_GATE", "Find way to open Gate", ::quest_step_wait_for_razor_gun_assembly, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("CORPSE_GATE", "Decapitate Ranger", ::quest_step_decap_ranger, ::quest_step_complete_decap_ranger, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("CORPSE_GATE", "Open Corpse Gate", ::quest_step_wait_for_first_corpsegate_opened, ::quest_step_complete_corpsegate_opened, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("CORPSE_GATE");
  thread quest_init_corpse_gate();
  common_scripts\utility::flag_init("Commence Weapon Assembly");
  _id_0557::_id_7846("Aquire Wonder Weapon", _id_0557::_id_30D8, ["explore_the_island"], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Aquire Wonder Weapon", "Melee Razor Gun Built", ::quest_step_build_razergun_1, ::razergun_build_melee_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Aquire Wonder Weapon", "Ranged Razor Gun Built", ::quest_step_build_razergun_2, ::razergun_build_ranged_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("Aquire Wonder Weapon");
  thread quest_init_razergun_assembly();
  _id_0557::_id_7846("Flak Tower", _id_0557::_id_30D8, ["flag_straub_finishes_plane_talk"], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Flak Tower", "Defend Flak Tower", ::quest_step_defend_the_flak_tower, ::flak_complete_xp_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Flak Tower", "Find crashed plane", ::quest_step_crashed_plane_find, ::flak_complete_xp_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("Flak Tower");
  level.active_planes = [];
  _id_0557::_id_7846("Interact with radio", _id_0557::_id_30D8, ["Flak Tower"], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Interact with radio", "Find Missing Part", ::quest_step_radio_find, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Interact with radio", "Place Radio", ::quest_step_radio_place, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("Interact with radio");
  thread quest_init_radio();
  _id_0557::_id_7846("Destroy 2nd Destroyer", _id_0557::_id_30D8, ["Interact with radio"], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Destroy 2nd Destroyer", "Find Artillery Ammo", ::quest_step_escort_loader, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Destroy 2nd Destroyer", "1st Ship Destroyed", ::quest_step_get_destroyer1_hits, ::destroyer_complete_xp_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("Destroy 2nd Destroyer");
  _id_0557::_id_7846("Artillery Ammo", _id_0557::_id_30D8, ["flag_artillery_out_of_ammo_quest_started"], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Artillery Ammo", "Charge Artillery Ammo", ::quest_step_charge_artillery_ammo, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("Artillery Ammo");
  thread quest_init_destroyers();
  _id_0557::_id_7846("Final Boss Island", _id_0557::_id_30D8, ["Destroy 2nd Destroyer"], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Final Boss Island", "Final Boss Island Part 1", ::quest_step_final_boss_island, ::bombers_init, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Final Boss Island", "Final Boss Island Part 2", ::quest_step_final_boss_persuit_1, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Final Boss Island", "Final Boss Island Part 3", ::quest_step_final_boss_persuit_2, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("Final Boss Island", "Defeat Wustlings", ::quest_step_final_boss_persuit_3, ::on_final_boss_defeated, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("Final Boss Island");
  thread quest_init_final_boss();
}

wait_on_hardcore_completed() {
  common_scripts\utility::_id_3C9F("flag_pommel_given");
  _id_0557::_id_782D("Epilogue Island", "Epilogue Island Continue Quest");
}

get_aa_turrets() {
  return getEntArray("tur_flak_gun", "script_noteworthy");
}

spawn_heavies_pommel_room() {
  var_0 = common_scripts\utility::_id_46B7("zombie_assassin_pagan_room_spawner", "targetname");
  level thread run_pommel_room_assassin_timer();

  for(;;) {
    wait 30;

    if(common_scripts\utility::_id_562E(level.disable_assassin_pushers)) {
      continue;
    }
    if(level.assassin_pommel_room_spawn_timer > 25 && pommel_room_assassin_player_pushes() < 3) {
      var_1 = maps\mp\zombies\zombie_assassin_spawner_logic::spawn_an_assassin(undefined, undefined, common_scripts\utility::random(var_0), undefined, "Phase 1: Entrance", 1, 1, undefined, undefined, undefined, undefined, ["isolated_room_zone"]);
      var_1.pommelroomplayerpusher = 1;
    }
  }
}

quest_step_final_boss_persuit_1() {}

quest_step_final_boss_persuit_2() {}

quest_step_final_boss_persuit_3() {}

run_pommel_room_assassin_timer() {
  level.assassin_pommel_room_spawn_timer = 0;

  for(;;) {
    wait 1;
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(_id_055A::_id_7413(var_2, "isolated_room_zone")) {
        var_0 = 1;
        break;
      }
    }

    if(var_0) {
      level.assassin_pommel_room_spawn_timer++;
      continue;
    }

    level.assassin_pommel_room_spawn_timer = 0;
  }
}

pommel_room_assassin_player_pushes() {
  var_0 = _id_0547::_id_408F();
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(common_scripts\utility::_id_562E(var_3.pommelroomplayerpusher))
      var_1++;
  }

  return var_1;
}

beachassaultfadein() {
  if(common_scripts\utility::_id_3C77("frontline_zombies_spawned")) {
    return;
  }
  self._id_6772 = _func_19B(self);
  self._id_6772 setshader("black", 640, 480);
  self._id_6772.sort = 999;
  self._id_6772._id_00C6 = "fullscreen";
  self._id_6772._id_01CA = "fullscreen";
  self._id_6772.foreground = 0;

  while(!level.gamehasstarted)
    waitframe();

  common_scripts\utility::_id_3C9F("frontline_zombies_spawned");
  thread animscripts\notetracks_common::do_fade_from_black(1.15);
}

_______globals__________() {}

aa_gun_trap_init() {
  var_0 = common_scripts\utility::_id_46B7("aa_gun_trap", "targetname");
  common_scripts\utility::flag_init("flak_cannons_ready");

  foreach(var_2 in var_0) {
    var_2 aa_gun_trap_prep();
    var_2 thread aa_gun_trap_buy_me();
  }

  foreach(var_5 in get_aa_turrets())
  var_5 thread plane_ee_manage_aa_swaps();
}

aa_gun_trap_prep() {
  var_0 = common_scripts\utility::_id_44BE(self.target, "targetname");
  self._id_1176 = [];

  foreach(var_2 in var_0) {
    switch (var_2._id_0165) {
      case "trig_use":
        self._id_9D65 = var_2;
        self._id_9D65.hint_string_available = &"ZOMBIE_ISLAND_BUY_FLAK";
        self._id_9D65.hint_string_unavailable = &"ZOMBIE_ISLAND_FLAK_DISABLED";
        self._id_9D65.hint_string_no_power = &"ZOMBIE_ISLAND_FLAK_NO_POWER";
        var_2 _meth_80CE(self._id_9D65.hint_string_unavailable);
        break;
      case "tur_flak_gun":
        self._id_9EDD = var_2;
        break;
      case "flak_cannon_attack_points":
        self._id_1176 = common_scripts\utility::_id_0F6F(self._id_1176, var_2);
        break;
      case "sbm_wall":
        self.wall_model = var_2;
        self.wall_model.health = 500;
        self.wall_model common_scripts\utility::_id_3799("this_turret_is_done");
        break;
    }
  }
}

quest_init_freezer_zombie_manager() {}

_______intro_assault__________() {}

quest_init_intro() {}

quest_step_do_intro_assault() {
  level _id_0378::_id_8D74("begin_intro_assault");
  level._id_1F4F["normal"] = ::dontdroppickups;
  level._id_ABDA = 1;
  var_0 = 50;
  level.eventpointmultiplier = 0.08;
  level.eventxpoverride = 5;
  var_1 = getEntArray("start_zone_spawners", "targetname");
  var_2 = common_scripts\utility::_id_46B5("intro_bunker_struct", "targetname");
  level.intro_bunker_struct = var_2;
  var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");
  var_2.rush_spawners = [];

  foreach(var_5 in var_3) {
    switch (var_5._id_0165) {
      case "zombie_spawner":
        switch (var_5._id_81A1) {
          case "zombie_beach_rush_spawner":
            var_2.rush_spawners = common_scripts\utility::_id_0F6F(var_2.rush_spawners, var_5);
            break;
        }

        break;
    }
  }

  var_7 = common_scripts\utility::_id_46B7("zmb_island_frontline_zombies", "targetname");

  while(!level.gamehasstarted)
    waitframe();

  while(!isDefined(level._id_6F43) || !_id_054D::_id_1F70("zombie_generic"))
    waitframe();

  for(var_8 = 0; var_8 < var_7.size; var_8++)
    try_spawn_intro_assault_zombie(1, var_7[var_8]);

  common_scripts\utility::flag_set("frontline_zombies_spawned");
  wait 1;
  var_9 = _id_0557::_id_782F(undefined, level.preplaced_turrets);
  _id_0557::_id_781D("Explore the Beach", var_9);

  foreach(var_11 in level.players)
  _id_0547::_id_ABC9(var_11, 3);

  foreach(var_14 in level._id_AC1D) {
    foreach(var_16 in var_14._id_9DC2)
    var_16 common_scripts\utility::_id_9D9F();
  }

  thread turret_outline_logic();
  thread vo_beach_turrets_nags_check();
  thread vo_beach_blood();
  var_19 = _id_0547::_id_408F();

  for(var_8 = 0; var_8 < 17; var_8++) {
    try_spawn_intro_assault_zombie(1);
    waitframe();
  }

  foreach(var_11 in level.players) {
    var_11 maps\mp\_utility::_id_2CED(3, _id_0367::_id_8E3D, "startbeach_both");
    var_11 maps\mp\_utility::_id_2CED(8, _id_0367::_id_8E3D, "mg42look_both");
  }

  var_22 = gettime();
  var_23 = 25;
  level thread start_intro_sprint();

  for(;;) {
    if((gettime() - var_22) / 1000 >= var_23) {
      break;
    }

    var_24 = (gettime() - var_22) / 1000;
    try_spawn_intro_assault_zombie(undefined, undefined, var_24);

    if(level.players.size == 1) {
      wait 1;
      continue;
    }

    wait 0.5;
  }

  _id_0547::_id_7BA9(::zombieskilledinintro);

  for(;;) {
    var_19 = _id_0547::_id_408F();

    if(var_19.size <= 0) {
      break;
    }

    wait 0.1;
  }

  _id_0557::_id_782D("Explore the Beach", "Survive the Beach");
  level.eventpointmultiplier = undefined;
  level.eventxpoverride = undefined;

  foreach(var_14 in level._id_AC1D) {
    foreach(var_16 in var_14._id_9DC2)
    var_16 common_scripts\utility::_id_9DA3();
  }

  foreach(var_11 in level.players) {
    if(var_11._id_62D6 % 10 != 0)
      var_11 maps\mp\gametypes\zombies::_id_4798(5);
  }

  _id_0547::_id_2D8C(::zombieskilledinintro);
  level _id_0378::_id_8D74("end_intro_assault");
  wait 5;

  foreach(var_11 in level.players)
  var_11 _id_0367::_id_8E3D("beachover_both");
}

start_intro_sprint() {
  level endon("zombies_manual_start");

  if(level.players.size == 1) {
    return;
  }
  var_0 = [];
  var_1 = 0.7;
  wait 2;

  while(var_0.size < 10) {
    var_2 = _id_0547::_id_408F();
    var_2 = common_scripts\utility::_id_0F7D(var_2, var_0);
    var_3 = common_scripts\utility::_id_4461(level.players[0].origin, var_2);

    if(isDefined(var_3)) {
      var_3._id_6941 = 1;
      var_0 = common_scripts\utility::_id_0F6F(var_0, var_3);
    }

    if(var_1 <= 0.1)
      var_1 = 0.1;

    wait(var_1);
    var_1 = var_1 - 0.1;
  }
}

vo_beach_turrets_nags_check() {
  level endon("flag Explore the Beach Survive the Beach");
  wait 15;
  var_0 = 0;
  var_1 = 0;

  if(level.players.size > 1)
    level.turrets_to_check = 2;
  else
    level.turrets_to_check = 1;

  for(var_2 = 0; var_2 < level.turrets_to_check; var_2++) {
    if(level.players[var_2] _meth_8347()) {
      level.players[var_2].using_turret = 1;
      continue;
    }

    level.players[var_2].using_turret = 0;
  }

  for(var_2 = 0; var_2 < level.turrets_to_check; var_2++) {
    if(level.players[var_2].using_turret == 0) {
      var_1 = 0;
      continue;
    }

    var_1 = 1;
  }

  if(var_1 == 0) {
    if(!common_scripts\utility::_id_3C77("flag Explore the Beach Survive the Beach"))
      _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("mg42nag__both");
  }
}

try_spawn_intro_assault_zombie(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::_id_46B7("zombie_spawner", "script_noteworthy");
  var_4 = _id_0547::_id_408F();

  if(var_4.size >= _id_056D::_id_4577()) {
    return;
  }
  var_5 = common_scripts\utility::random(level.intro_bunker_struct.rush_spawners);

  if(isDefined(var_1))
    var_5 = var_1;

  var_6 = _id_054D::_id_90BA("zombie_generic", var_5, "beach_rush_intro", 0, 1, 1);
  var_6 _id_0547::_id_84CB();
  var_6 endon("death");

  if(isDefined(var_0))
    var_6.health = int(var_6.health * var_0);

  if(isDefined(var_2) && var_2 >= 5) {
    if(level.players.size > 1)
      var_7 = randomint(2);
    else
      var_7 = 1;

    if(var_7 == 0)
      var_6._id_6941 = 1;
  }

  waitframe();
  var_8 = common_scripts\utility::_id_44F5("water_wake_stationary");
  waitframe();
  _func_147(var_8, var_6, "tag_origin");
}

turret_outline_logic() {
  level.turrets_used = 0;

  while(!common_scripts\utility::_id_3C77("flag Explore the Beach Survive the Beach")) {
    foreach(var_1 in level.players) {
      if(!isalive(var_1)) {
        continue;
      }
      if(!var_1 _meth_8347()) {
        continue;
      }
      var_2 = var_1 _meth_85E3();

      if(!isDefined(var_2)) {
        continue;
      }
      level.turrets_used = 1;
    }

    waitframe();
  }
}

quest_step_intro_on_complete() {
  level._id_1F4F["normal"] = ::droppickups;

  if(!maps\mp\zquests\casual\island_ee_util::has_anyone_used_preplaced_turrets())
    maps\mp\gametypes\zombies::_id_47A8("DLC1_ZM_GOTTHIS");

  level thread common_scripts\_exploder::_id_088E(222);

  foreach(var_1 in level.players) {
    _id_0547::_id_ABCA(var_1, 0);
    _id_0547::_id_ABCA(var_1, 3);
  }

  level._id_2F6C = 0;

  if(common_scripts\utility::_id_562E(level._id_ABDA))
    level notify("zombies_manual_start");
}

quest_step_reach_pen() {
  common_scripts\utility::_id_3CA2("right_climb_to_sub_pens_1", "vista_beach_to_sub_pens_1");
  _id_0557::_id_782D("Explore the Beach", "Reach Sub Pens");
}

wait_for_player() {
  while(isDefined(self)) {
    foreach(var_1 in level.players) {
      if(distance(var_1.origin, self.origin) < 64) {
        var_1 maps\mp\gametypes\zombies::_id_4798(250, 1);
        self delete();
        break;
      }
    }

    waitframe();
  }
}

zombieskilledinintro(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!_id_0547::_id_5565(self._id_0A4B, "zombie_generic")) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  var_9 = _id_0547::_id_408F();

  if(var_9.size > 1) {
    return;
  }
  var_10 = _func_18E("vol_player_beach_area", "targetname");
  var_11 = common_scripts\utility::_id_46B7("beach_attack_pickup_location", "targetname");
  var_12 = common_scripts\utility::random(var_11);
  var_13 = var_9[0];

  if(isDefined(var_13) && isDefined(var_10) && var_13 istouching(var_10)) {
    maps\mp\gametypes\zombies::_id_281C("ammo", var_13.origin, "random", 1, 0);
    return;
  } else
    maps\mp\gametypes\zombies::_id_281C("ammo", var_12.origin, "random", 1, 0);
}

_id_9D28() {
  return 3;
}

_id_9D2A() {
  return 1;
}

dontdroppickups(var_0) {
  return 0;
}

droppickups(var_0) {
  return 1;
}

playerinwaterthink() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = getEntArray("vol_player_in_water", "targetname");
  var_0 common_scripts\utility::_id_3799("flag_player_in_water");
  waitframe();

  for(;;) {
    var_2 = var_0 isplayerinwatercheck(var_1);

    if(var_2 != 1) {
      if(var_0 common_scripts\utility::_id_3794("flag_player_in_water")) {
        var_0 common_scripts\utility::_id_3796("flag_player_in_water");

        if(common_scripts\utility::_id_562E(var_0.oncartride)) {
          continue;
        }
        if(var_0 _meth_8317() == "stone_baby_zm") {
          continue;
        }
        var_0 _meth_8114(1);
      }

      waitframe();
      continue;
    }

    if(!var_0 common_scripts\utility::_id_3794("flag_player_in_water")) {
      var_0 common_scripts\utility::_id_379A("flag_player_in_water");

      if(common_scripts\utility::_id_562E(var_0.oncartride)) {
        continue;
      }
      if(var_0 _meth_8317() == "stone_baby_zm") {
        continue;
      }
      var_0 _meth_8114(0);
    }

    waitframe();
  }
}

isplayerinwatercheck(var_0) {
  foreach(var_2 in var_0) {
    if(self istouching(var_2))
      return 1;
  }

  return 0;
}

______sub_pens_and_corpse_gate__________() {}

quest_init_corpse_gate() {
  thread setup_subpen_switches();
  thread cgate_ranger_init();
  thread cgate_init();
  thread cgate_blocker_init();
  thread cgate_found_listener();
}

_id_784F() {
  common_scripts\utility::_id_3C9F("power_sz2");
  _id_0557::_id_782D("explore_the_island", "Pen Power");
}

quest_step_complete_enable_power() {
  if(!common_scripts\utility::_id_3C77("power_sz2"))
    common_scripts\utility::flag_set("power_sz2");
}

quest_step_wait_for_corpsegate_found() {
  common_scripts\utility::_id_3C9F("flag_corpse_door_found");
  _id_0557::_id_782D("explore_the_island", "Explore Pen");
}

quest_step_complete_wait_for_corpsegate_found() {
  if(!common_scripts\utility::_id_3C77("flag_corpse_door_found"))
    common_scripts\utility::flag_set("flag_corpse_door_found");
}

quest_step_wait_for_razor_gun_assembly() {
  common_scripts\utility::_id_3CA2(_id_0557::_id_7838("Aquire Wonder Weapon", "Ranged Razor Gun Built"), "flag_ranger_head_taken");
  _id_0557::_id_782D("CORPSE_GATE", "Find way to open Gate");
}

quest_step_decap_ranger() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = _func_18E("corpse_gate_sacrifice", "targetname");

  if(isDefined(var_2)) {
    var_1 = _func_18E(var_2.target, "targetname");

    if(isDefined(var_1) && isDefined(var_1.target))
      var_0 = _func_18E(var_1.target, "targetname");

    thread head_corpse_vo();
  }

  common_scripts\utility::_id_3C9F("flag_ranger_head_taken");
  _id_0557::_id_782D("CORPSE_GATE", "Decapitate Ranger");
}

head_corpse_vo() {
  common_scripts\utility::_id_3C9F("start_to_right_climb");
  var_0 = _func_18E("corpse_gate_sacrifice", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");

  while(!common_scripts\utility::_id_3C77("flag_ranger_head_taken")) {
    foreach(var_2 in level.players) {
      if(distance(var_2.origin, var_0.origin) > 250 || common_scripts\utility::_id_562E(var_2.saw_head)) {
        continue;
      }
      var_2 _id_0367::_id_8E3D("rippedapart_both");
      var_2.saw_head = 1;
      var_3 = var_2 _meth_82D5();

      if(issubstr(var_3, "razergun_zm") == 0)
        var_2 _id_0367::_id_8E3D("planecrashlook");
    }

    wait 1;
  }
}

head_corpse_razer_gun_vo() {
  common_scripts\utility::_id_3C9F("razergun_3_placed");
  var_0 = _func_18E("corpse_gate_sacrifice", "targetname");

  foreach(var_2 in level.players)
  var_2.got_head = 0;

  while(!common_scripts\utility::_id_3C77("flag_ranger_head_taken")) {
    foreach(var_2 in level.players) {
      if(distance(var_2.origin, var_0.origin) < 250) {
        if(var_2.got_head == 0) {
          var_5 = var_2 _meth_82D5();

          if(issubstr(var_5, "razergun_zm") == 0) {
            var_2 _id_0367::_id_8E3D("officercluetwo");
            var_2.got_head = 1;
          }
        }
      }
    }

    wait 1;
  }
}

quest_step_complete_decap_ranger() {
  if(!common_scripts\utility::_id_3C77("flag_ranger_head_taken"))
    common_scripts\utility::flag_set("flag_ranger_head_taken");
}

quest_step_wait_for_first_corpsegate_opened() {
  common_scripts\utility::_id_3C9F("flag_ranger_head_placed");
  var_0 = _func_18E("corpse_gate_wall", "targetname");

  foreach(var_2 in level.players) {
    if(distance(var_2.origin, var_0.origin) < 500)
      var_2 thread _id_0367::_id_8E3D("corpsegateheadplace");
  }

  _id_0557::_id_7822("CORPSE_GATE", _id_0557::removed_quest_hint());
  common_scripts\utility::_id_3C9F("sub_pens_corpse_gate");
  _id_0557::_id_7822("CORPSE_GATE", _id_0557::removed_quest_hint());
  level.zmb_locked_spawn_zones = ["sub_pens_1_zone"];
  maps\mp\zquests\casual\island_ee_util::clear_all_zombies();
  level thread monitor_player_attendance();
  run_freezer_combat();
  common_scripts\utility::_id_3C9F("flag_subpen_traps_completed");
  maps\mp\zquests\casual\island_ee_util::clear_all_zombies();
  level.zmb_locked_spawn_zones = undefined;
  _id_0557::_id_7822("CORPSE_GATE", _id_0557::removed_quest_hint());
  common_scripts\utility::_id_3C9F("flag_open_corpse_door");
  _id_0557::_id_782D("CORPSE_GATE", "Open Corpse Gate");
}

quest_step_complete_corpsegate_opened() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("corpsegate");
    var_1 _id_0378::_id_8D74("objective_complete", "corpsegate");
  }

  if(!common_scripts\utility::_id_3C77("flag_ranger_head_placed"))
    common_scripts\utility::flag_set("flag_ranger_head_placed");

  if(!common_scripts\utility::_id_3C77("sub_pens_corpse_gate"))
    common_scripts\utility::flag_set("sub_pens_corpse_gate");

  if(!common_scripts\utility::_id_3C77("flag_subpen_traps_completed"))
    common_scripts\utility::flag_set("flag_subpen_traps_completed");

  if(!common_scripts\utility::_id_3C77("flag_ranger_head_placed"))
    common_scripts\utility::flag_set("flag_ranger_head_placed");

  if(!common_scripts\utility::_id_3C77("flag_ranger_head_taken"))
    common_scripts\utility::flag_set("flag_ranger_head_taken");

  if(!common_scripts\utility::_id_3C77("flag_corpse_door_found"))
    common_scripts\utility::flag_set("flag_corpse_door_found");

  if(!common_scripts\utility::_id_3C77("flag_open_corpse_door"))
    common_scripts\utility::flag_set("flag_open_corpse_door");

  if(!common_scripts\utility::_id_3C77("sub_pens_corpse_gate"))
    common_scripts\utility::flag_set("sub_pens_corpse_gate");
}

cgate_ranger_init() {
  var_0 = _func_18E("corpse_gate_sacrifice", "targetname");
  var_0._id_00B9 = _func_18E(var_0.target, "targetname");
  var_0._id_18A8 = _func_18E(var_0._id_00B9.target, "targetname");
  var_0.head_trig = _func_18E(var_0._id_18A8.target, "targetname");
  var_0.pecking_crows = _func_2A8(level._effect["zmb_isl_corpse_crows_peck"], var_0._id_18A8, "TAG_ORIGIN");
  _func_14C(var_0.pecking_crows, -1);
  var_0 thread cgate_ranger_think();
  level thread maps\mp\_utility::_id_6F74(::scare_crows_when_looked_at, var_0);
  waitframe();
}

scare_crows_when_looked_at(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  wait 1;
  level endon("crows_gone");

  for(;;) {
    if(!isDefined(var_0) || !isDefined(var_0._id_00B9)) {
      return;
    }
    var_2 = var_0._id_00B9.origin;
    var_3 = self getEye();
    var_4 = vectorNormalize(var_2 - var_3);
    var_5 = vectorNormalize(anglesToForward(self _meth_8566()));
    var_6 = vectordot(var_4, var_5);
    waitframe();
    var_7 = _func_0AA(clamp(var_6, -1, 1));

    if(var_7 < 25 && distance(var_2, var_3) < 420) {
      var_0 thread scare_off_crows();
      level notify("crows_gone");
    }
  }
}

#using_animtree("animated_props_zombies_DLC1");

cgate_ranger_think() {
  self _meth_80CE(&"ZOMBIES_EMPTY_STRING");
  self.head_trig waittill("razer_blade_touched", var_0);
  level childthread common_scripts\_exploder::_id_088E(219);
  self.head_trig delete();
  var_1 = common_scripts\utility::_id_46B5("head_landing_scripted_node", "targetname");
  self._id_00B9 _meth_8495("s2_zom_island_corpse_head", var_1.origin, common_scripts\utility::_id_98E7(isDefined(var_1.angles), var_1.angles, (0, 0, 0)), "head_fall_anim");
  self._id_00B9 _id_0378::_id_8D74("nazi_head_roll");
  wait(_func_065(%s2_zom_island_corpse_head));
  self _meth_80CE(&"ZOMBIE_ISLAND_PICK_UP_HEAD");
  self waittill("trigger", var_2);
  self._id_00B9 delete();
  self delete();
  common_scripts\utility::flag_set("flag_ranger_head_taken");
}

scare_off_crows() {
  if(isDefined(self.pecking_crows))
    self.pecking_crows delete();

  _func_147(level._effect["zmb_isl_corpse_crows_scatter"], self._id_18A8, "TAG_ORIGIN");
  _id_0378::_id_8D74("aud_scare_off_crows");
}

sub_pen_blocker_listener() {
  level thread maps\mp\_utility::_id_6F74(::push_off_the_fence, self._id_241F);

  for(;;) {
    var_0 = level common_scripts\utility::_id_A715("sub_pen_blockers_open", "sub_pen_blockers_close");
    var_1 = self._id_3255 _meth_866B("gate");

    if(var_0 == "sub_pen_blockers_open") {
      if(var_1 == "opened") {
        continue;
      }
      common_scripts\utility::flag_set("dont_spawn_fireman");
      common_scripts\utility::flag_set("fireman_defeated");
      var_2 = _id_0547::_id_4090("zombie_fireman");

      foreach(var_4 in var_2) {
        var_4.nomaxammo = 1;
        var_4 suicide();
      }

      self._id_241F._id_565F = 0;
      self._id_241F _meth_8060();
      self._id_241F _meth_82C2();
      self._id_3255 _meth_83FA("gate", "opening");
      wait 0.7;
      self._id_3255 _meth_83FA("gate", "opened");
      continue;
    }

    if(var_0 == "sub_pen_blockers_close") {
      if(var_1 == "closed") {
        continue;
      }
      self._id_241F._id_565F = 1;
      self._id_241F _meth_805F();
      self._id_241F _meth_82C1();
      self._id_3255 _meth_83FA("gate", "closing");
      wait 0.7;
      self._id_3255 _meth_83FA("gate", "closed");
    }
  }
}

push_off_the_fence(var_0) {
  self endon("disconnect");
  var_1 = common_scripts\utility::_id_46B5("zmb_addon_fence_teleport_line", "targetname");
  var_2 = common_scripts\utility::_id_46B5(var_1.target, "targetname");
  var_3 = [var_1.origin, var_2.origin];

  for(;;) {
    waitframe();

    if(!common_scripts\utility::_id_562E(var_0._id_565F)) {
      continue;
    }
    if(distance(self.origin, var_0.origin) > 256) {
      continue;
    }
    if(_id_0547::_id_5565(self _meth_8551(), var_0)) {
      var_4 = _func_0DF(var_3[0], var_3[1], self.origin);
      self setOrigin((var_4[0], var_4[1], self.origin[2]), 0);
    }
  }
}

cgate_found_listener() {
  var_0 = 0;
  var_1 = common_scripts\utility::_id_46B7("corpse_gate", "targetname");
  var_2 = undefined;
  _id_0547::_id_A78B();

  foreach(var_4 in var_1) {
    if(var_4._id_819A == "sub_pens_corpse_gate")
      var_2 = var_4;
  }

  while(!var_0) {
    foreach(var_7 in level.players) {
      if(distance(var_7.origin, var_2.origin) < 128)
        var_0 = 1;
    }

    wait 0.125;
  }

  common_scripts\utility::flag_set("flag_corpse_door_found");
}

run_freezer_combat() {
  var_0 = common_scripts\utility::_id_46B5("corpse_freezer_combat_sequence", "targetname");
  var_1 = common_scripts\utility::_id_44BE(var_0.target, "targetname");
  thread start_combat();
}

cgate_blocker_init() {
  var_0 = common_scripts\utility::_id_46B7("subpen_battle_blocker", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");
    var_4 = _func_21F(var_2.target, "targetname");

    foreach(var_6 in var_3) {
      if(!isDefined(var_6._id_0165)) {
        continue;
      }
      switch (var_6._id_0165) {
        case "blocker_clip":
          var_2._id_241F = var_6;
          var_2._id_241F common_scripts\utility::_id_2CBE(3, ::_meth_8060);
          var_2._id_241F _meth_82C2();
          break;
      }
    }

    foreach(var_6 in var_4) {
      var_9 = var_6 _meth_85CE();

      if(var_9 == "animated_zmi_sub_bay_spike") {
        var_2._id_3255 = var_6;
        var_2._id_3255 _meth_83FA("gate", "opened");
      }
    }

    var_2 thread sub_pen_blocker_listener();
  }
}

run_corpse_door() {
  thread cgate_head_place_think();
  thread cgate_set_state("dead_idle");
  self.corpse_trig thread cgate_wait_for_deposit();
  common_scripts\utility::_id_3C9F("flag_ranger_head_placed");
  thread wait_for_objective_complete();
  common_scripts\utility::_id_3C9F("sub_pens_corpse_gate");
  level thread cgate_start_collar_fx(self._id_3255);
  cgate_set_state("intro");
  thread cgate_set_state("active_idle");
  _id_0378::_id_8D74("corpse_gate_talk", "alarm");
  common_scripts\utility::_id_3C9F("flag_subpen_traps_completed");
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  self.corpse_trig common_scripts\utility::_id_9DA3();
  self.corpse_trig _meth_80CE(&"ZOMBIE_ISLAND_CORPSE_GATE_OPEN");
  _id_0378::_id_8D74("corpse_gate_talk", "beg");
  self.corpse_trig thread wait_for_activate_after_fire_panel_battle();
  common_scripts\utility::_id_3C9F("flag_open_corpse_door");
  self.corpse_trig delete();
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_island_corpsegate_open");
  cgate_set_state("outro");
  setDvar("4712", 2);
  thread freezer_lights();
  setDvar("4712", 1);

  if(isDefined(self._id_819A))
    common_scripts\utility::flag_set(self._id_819A);
}

spawn_corpse_gate_fireman() {
  wait 2.5;
  level thread corpse_gate_open_vo();
  var_0 = common_scripts\utility::_id_46B5("zmb_fireman_spawnpoint_corpsegate", "targetname");

  if(!common_scripts\utility::_id_3C77("dont_spawn_fireman")) {
    var_1 = _id_0564::_id_3C11(0, var_0, 0);

    if(isDefined(var_1)) {
      var_1 _id_0547::_id_84CB();
      var_1 _id_0378::_id_8D74("aud_isla_fireman_intro");
    }

    _id_0547::_id_7BA9(::zombie_firemen_max_ammo);
  }

  for(;;) {
    var_2 = _id_0547::_id_4090("zombie_fireman");

    if(var_2.size <= 0) {
      level notify("sub_pen_blockers_open");
      maps\mp\mp_zombie_island_cart::make_a_transport_request(undefined, undefined, "unlock");
      break;
    }

    wait 1;
  }

  common_scripts\utility::flag_set("fireman_defeated");
  thread planes_enroute_vo();
}

zombie_firemen_max_ammo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(_id_0547::_id_5565(self._id_0A4B, "zombie_fireman")) {
    if(!common_scripts\utility::_id_562E(self.nomaxammo))
      maps\mp\gametypes\zombies::_id_281C("ammo", self.origin, "random", 0, 0);

    _id_0547::_id_2D8C(::zombie_firemen_max_ammo);
  }
}

freezer_lights() {
  wait 9;
  var_0 = _func_21F("on1", "targetname");

  foreach(var_2 in var_0) {
    wait 6;
    var_2 _meth_83FA("lightpart", "on");
  }

  wait 4;
  var_4 = _func_21F("on2", "targetname");

  foreach(var_6 in var_4) {
    wait 7;
    var_6 _meth_83FA("lightpart", "on");
  }

  wait 4;
  var_8 = _func_21F("on3", "targetname");

  foreach(var_10 in var_8) {
    wait 6;
    var_10 _meth_83FA("lightpart", "on");
  }
}

cgate_head_place_think() {
  level.corpse_gate._id_00B9 _meth_805C();
  level.corpse_gate.guts _meth_805C();
  common_scripts\utility::_id_3C9F("flag_ranger_head_placed");
  level.corpse_gate._id_00B9 _meth_805B();
}

cgate_set_state(var_0) {
  var_1 = level.corpse_gate;

  switch (var_0) {
    case "dead_idle":
      var_1._id_3255 _meth_8495("s2_zom_island_corpse_gate_dead_idle", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_1._id_00B9 _meth_8495("s2_zom_island_corpse_gate_dead_idle_head", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_5 = _func_065(%s2_zom_island_corpse_gate_dead_idle);
      wait(var_5);
      break;
    case "intro":
      level.corpse_gate.guts _meth_805B();
      var_1 _id_0378::_id_8D74("corpse_gate_talk", "awake");
      var_1._id_3255 _meth_8495("s2_zom_island_corpse_gate_intro", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_1.guts _meth_8495("s2_zom_island_corpse_gate_intro_guts", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_1._id_00B9 _meth_8495("s2_zom_island_corpse_gate_intro_head", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_5 = _func_065(%s2_zom_island_corpse_gate_intro);
      wait(var_5);
      break;
    case "active_idle":
      var_1._id_3255 _meth_8495("s2_zom_island_corpse_gate_idle", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_1.guts _meth_8495("s2_zom_island_corpse_gate_idle_guts", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_1._id_00B9 _meth_8495("s2_zom_island_corpse_gate_idle_head", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_5 = _func_065(%s2_zom_island_corpse_gate_idle);
      wait(var_5);
      break;
    case "outro":
      level thread corpse_gate_open_rumble(var_1._id_3255);
      level thread common_scripts\_exploder::_id_088E(211);
      var_1._id_3255 _id_0378::_id_8D74("aud_corpse_gate_open");
      level thread common_scripts\_exploder::_id_088E(230);
      var_1 _id_0378::_id_8D74("corpse_gate_talk", "beg");
      var_1._id_3255 _meth_8495("s2_zom_island_corpse_gate_outro", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_1.guts _meth_8495("s2_zom_island_corpse_gate_outro_guts", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_1._id_00B9 _meth_8495("s2_zom_island_corpse_gate_outro_head", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_5 = _func_065(%s2_zom_island_corpse_gate_outro);
      var_1._id_3255 _meth_80B1();
      wait 15.1667;

      foreach(var_3 in var_1.clip_blockers) {
        var_3 _meth_8060();
        var_3 delete();
      }

      level thread spawn_corpse_gate_fireman();
      wait 5.86667;
      var_1.is_opened = 1;
      break;
    case "tug":
      var_1._id_3255 _meth_8495("s2_zom_island_corpse_gate_tug", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_1.guts _meth_8495("s2_zom_island_corpse_gate_tug_guts", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_1._id_00B9 _meth_8495("s2_zom_island_corpse_gate_tug_head", var_1.anim_origin.origin, var_1.anim_origin.angles);
      var_5 = _func_065(%s2_zom_island_corpse_gate_tug);
      wait(var_5);
      break;
  }
}

corpse_gate_open_rumble(var_0) {
  wait 3.5;

  foreach(var_2 in level.players) {
    if(distance(var_2.origin, var_0.origin) < 500)
      _func_1BC("tank_rumble", var_2.origin);
  }

  wait 5;
  _func_1BD();
}

vo_corpse_gate_touch() {
  level endon("sub_pens_corpse_gate");
  common_scripts\utility::_id_3C9F("power_sz2");

  for(;;) {
    foreach(var_1 in level.players) {
      if(!isDefined(self.corpse_trig)) {
        break;
      }

      if(var_1 istouching(self.corpse_trig)) {
        if(!common_scripts\utility::_id_562E(var_1.dlg_flag_see_cgate)) {
          var_1 _id_0367::_id_8E3D("touchcorpsegate");
          var_1 _id_0367::_id_8E3D("emptycorpsegate");
          var_1.dlg_flag_see_cgate = 1;
        }
      }
    }

    waitframe();
  }
}

vo_beach_blood() {
  common_scripts\utility::_id_3C9F("start_to_right_climb");
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("followpath");
  common_scripts\utility::_id_3C9F("right_climb_to_sub_pens_1");
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("nagsubpen");
}

wait_for_objective_complete() {
  self.corpse_trig common_scripts\utility::_id_9D9F();

  if(!common_scripts\utility::_id_3C77("sub_pens_corpse_gate")) {
    var_0 = 15;

    switch (level.players.size) {
      case 1:
        var_0 = 10;
        break;
      case 2:
        var_0 = 15;
        break;
      case 3:
        var_0 = 15;
        break;
      case 4:
        var_0 = 15;
        break;
    }

    var_1 = spawn("script_model", self._id_00B9.origin);
    var_1 setModel("tag_origin");
    var_1.issoulcollecting = 1;
    var_1 thread cgate_toggle_soul_pos();
    var_1 thread cgate_tug();
    var_1 maps\mp\mp_zombies_soul_collection::_id_170B(var_0, 400, undefined, "corpse_door_soul_charged", undefined, "tag_origin");
    level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("geistcraft_device_powered");
    common_scripts\utility::flag_set("sub_pens_corpse_gate");
    var_1.issoulcollecting = 0;
  }
}

cgate_tug() {
  while(self.issoulcollecting == 1) {
    level waittill("corpse_door_soul_charged");
    cgate_set_state("tug");
  }
}

cgate_toggle_soul_pos() {
  var_0 = common_scripts\utility::_id_46B5("corspe_gate_lightning_point", "targetname");
  var_1 = common_scripts\utility::_id_46B5(var_0.target, "targetname");

  while(self.issoulcollecting) {
    self.origin = var_0.origin;
    wait 1;
    self.origin = var_1.origin;
    wait 1;
  }
}

cgate_start_collar_fx(var_0) {
  wait 0.2;
  var_1 = _func_2A8(level._effect["zmb_dlc1_corpse_gate_gk_collar_1"], var_0, "collar");
  _func_14C(var_1);
}

cgate_wait_for_deposit() {
  common_scripts\utility::_id_3C9F("flag_ranger_head_taken");
  self _meth_80CE(&"ZOMBIE_ISLAND_PLACE_RANGER_HEAD");

  for(;;) {
    self waittill("trigger", var_0);

    if(common_scripts\utility::_id_3C77("flag_ranger_head_taken")) {
      var_0 _id_0367::_id_8E3D("corpseheadplace");
      break;
    }
  }

  common_scripts\utility::flag_set("flag_ranger_head_placed");
}

wait_for_activate_after_fire_panel_battle() {
  for(;;) {
    self waittill("trigger", var_0);
    break;
  }

  common_scripts\utility::flag_set("flag_open_corpse_door");
}

cgate_init() {
  var_0 = common_scripts\utility::_id_46B5("corpse_gate", "targetname");

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_819A))
      common_scripts\utility::flag_init(var_0._id_819A);

    var_1 = common_scripts\utility::_id_44BE(var_0.target, "targetname");
    var_2 = [];
    var_3 = undefined;

    foreach(var_5 in var_1) {
      switch (var_5._id_0165) {
        case "corpse_gate_clip_blocker":
          var_2 = common_scripts\utility::_id_0F6F(var_2, var_5);
          break;
        case "zombies_corpse_trigger":
          var_3 = var_5;
          break;
      }
    }

    var_0.clip_blockers = var_2;
    var_0.corpse_trig = var_3;
    var_0._id_3255 = _func_18E("corpse_gate_wall", "targetname");
    var_0.guts = _func_18E("corpse_gate_guts_model", "script_noteworthy");
    var_0._id_00B9 = _func_18E("corpse_gate_head_model", "script_noteworthy");
    var_0.anim_origin = common_scripts\utility::_id_46B5("anim_origin_corpse_gate", "targetname");
    level.corpse_gate = var_0;
    level.corpse_gate thread run_corpse_door();
    level.corpse_gate thread vo_corpse_gate_touch();
  }
}

vo_inside_subpens() {
  common_scripts\utility::_id_3C9F("flag_vo_inside_subpen");

  foreach(var_1 in level.players)
  var_1 thread _id_0367::_id_8E3C("insidesubpen");

  common_scripts\utility::_id_3C9F("flag_vo_subcrates");

  foreach(var_1 in level.players)
  var_1 thread _id_0367::_id_8E3C("subcrates_both");
}

start_combat() {
  level notify("sub_pen_blockers_close");
  maps\mp\mp_zombie_island_cart::make_a_transport_request(undefined, undefined, "lockdown");
  wait 5;
  maps\mp\mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_achtungithascometomyatten", 0);
  maps\mp\mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_americansasusualyouhavear", 0);
  maps\mp\mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_wearealmostfinishedhereih");
  level.maxed_zombies_sprint = 1;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();
  level thread initial_rush();
  thread fire_panels_logic();
  maps\mp\_utility::_id_2CED(7, common_scripts\utility::flag_set, "flag_freezer_combat_started");
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("lockedingottafightthemoff");
  common_scripts\utility::_id_3C9F("flag_subpen_traps_completed");
  level notify("stop_stoves");
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  level.maxed_zombies_sprint = 0;
}

is_zone_a_locked_spawn_zone(var_0) {
  if(!isDefined(level.zmb_locked_spawn_zones))
    return 0;

  var_1 = common_scripts\utility::_id_0F79(level.zmb_locked_spawn_zones, var_0);
  return var_1;
}

monitor_player_attendance() {
  var_0 = _func_18E("sub_event_volume", "targetname");
  level.zmb_lockdown_event_active = 1;

  while(!common_scripts\utility::_id_3C77("fireman_defeated")) {
    var_1 = 0;
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(var_4 istouching(var_0)) {
        var_4.participatinginevent = 1;
        var_1++;
        continue;
      }

      var_4 notify("not_participating_in_subpen_event");
      var_4.participatinginevent = 0;
    }

    level.plr_event_attendance = var_1;
    var_6 = _id_0547::_id_408F();

    foreach(var_8 in var_6) {
      if(isDefined(var_8._id_9024))
        var_9 = var_8._id_9024;
      else
        var_9 = "";

      if(var_8 istouching(var_0) || is_zone_a_locked_spawn_zone(var_9)) {
        var_8.participatinginevent = 1;
        var_2++;
        continue;
      }

      var_8.participatinginevent = 0;
      var_8 _id_056D::_id_5A86();
    }

    level.zmb_event_attendance = var_2;

    if(level.plr_event_attendance == 0) {
      var_1 = 0;
      var_2 = 0;
      level notify("sub_pen_blockers_open");
      break;
    }

    waitframe();
  }

  level.zmb_lockdown_event_active = 0;
  level.zmb_locked_spawn_zones = undefined;
  level.plr_event_attendance = undefined;
  level.zmb_event_attendance = undefined;
}

initial_rush() {
  var_0 = common_scripts\utility::_id_46B5("corpse_freezer_combat_sequence", "targetname");
  var_1 = common_scripts\utility::_id_46B7("sub_pens_event_spawners", "targetname");

  foreach(var_3 in var_1)
  _id_054D::_id_90BA("zombie_generic", var_3, "beach_rush_intro", 0, 1, 1);

  _func_17F(0.25, 7.5, var_0.origin, 1000);
  var_5 = _id_0380::_id_6842("zmb_well_group_scream", undefined, var_0.origin);
  var_6 = _id_0380::_id_6842("zmb_tower_alarm", undefined, var_0.origin);
  wait 17.5;
  _id_0380::_id_6850(var_6, 0.25);
  _id_0380::_id_6850(var_5, 0.25);
}

fire_panels_logic() {
  var_0 = [];
  var_1 = getEntArray("stove_panel", "targetname");
  var_2 = [];
  var_2 = common_scripts\utility::_id_0F6F(var_2, 0);

  for(var_3 = 1; var_3 < 35; var_3++) {
    var_4 = _func_18E("fire_panel_" + var_3, "targetname");
    var_0 = common_scripts\utility::_id_0F6F(var_0, var_4);
  }

  foreach(var_4 in var_0) {
    var_6 = common_scripts\utility::_id_4461(var_4.origin, var_1);
    var_2 = common_scripts\utility::_id_0F6F(var_2, var_6);
  }

  foreach(var_9 in level.players)
  var_9.vo_fire_panel_warning_received = 0;

  level.burn_tags = [];
  level notify("flag_subpen_traps_started");
  fire_panels_intro(var_2);
  thread fire_panels_valve_panels_logic(var_2);
  _id_0378::_id_8D74("start_corpse_gate_alarm");

  for(;;) {
    wait 5;

    foreach(var_9 in level.players)
    var_9.vo_fire_panel_warning_received = 0;

    var_13 = _func_0A4(0, 6);

    switch (var_13) {
      case 0:
        fire_pattern_right_wave(var_2);
        break;
      case 1:
        fire_pattern_right_wave_reverse(var_2);
        break;
      case 2:
        fire_pattern_left_wave(var_2);
        break;
      case 3:
        fire_pattern_left_wave_reverse(var_2);
        break;
      case 4:
        fire_pattern_mid_upper(var_2);
        break;
      case 5:
        fire_pattern_mid_lower(var_2);
        break;
      default:
        break;
    }

    if(common_scripts\utility::_id_3C77("flag_subpen_traps_completed")) {
      _id_0378::_id_8D74("stop_corpse_gate_alarm");
      break;
    }
  }
}

fire_panels_valve_panels_logic(var_0) {
  level endon("flag_subpen_traps_completed");
  thread fire_panels_always_burn(var_0[2]);
  thread fire_panels_always_burn(var_0[14]);
  thread fire_panels_always_burn(var_0[27]);
  var_1 = [];
  var_1 = common_scripts\utility::_id_0F6F(var_1, var_0[2]);
  var_1 = common_scripts\utility::_id_0F6F(var_1, var_0[14]);
  var_1 = common_scripts\utility::_id_0F6F(var_1, var_0[27]);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  foreach(var_7 in level._id_A2A0) {
    if(_id_0547::_id_5565(var_7.targetname, "fuel_valve")) {
      if(isDefined(var_7._id_819A) && var_7._id_819A == "fuel_valve_1")
        var_2 = common_scripts\utility::_id_4461(var_7.origin, var_1);

      if(isDefined(var_7._id_819A) && var_7._id_819A == "fuel_valve_2")
        var_3 = common_scripts\utility::_id_4461(var_7.origin, var_1);

      if(isDefined(var_7._id_819A) && var_7._id_819A == "fuel_valve_3")
        var_4 = common_scripts\utility::_id_4461(var_7.origin, var_1);
    }
  }

  wait 30;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;

  for(;;) {
    if(var_9 == 0) {
      if(common_scripts\utility::_id_3C77("fuel_valve_1")) {
        var_1 = common_scripts\utility::_id_0F93(var_1, var_2);
        var_9 = 1;
      }
    }

    if(var_10 == 0) {
      if(common_scripts\utility::_id_3C77("fuel_valve_2")) {
        var_1 = common_scripts\utility::_id_0F93(var_1, var_3);
        var_10 = 1;
      }
    }

    if(var_11 == 0) {
      if(common_scripts\utility::_id_3C77("fuel_valve_3")) {
        var_1 = common_scripts\utility::_id_0F93(var_1, var_4);
        var_11 = 1;
      }
    }

    var_5 = common_scripts\utility::random(var_1);

    if(isDefined(var_5)) {
      var_5.temporarily_turn_off = 1;
      var_5 _id_0378::_id_8D74("fire_panel_turn_off");
    }

    wait 15;
    wait 20;
  }
}

fire_panels_intro(var_0) {
  level endon("flag_subpen_traps_completed");
  var_1 = 1;
  thread fire_panels(var_0[1]);
  thread fire_panels(var_0[2]);
  wait(var_1);
  thread fire_panels(var_0[3]);
  thread fire_panels(var_0[4]);
  wait(var_1);
  thread fire_panels(var_0[5]);
  thread fire_panels(var_0[6]);
  thread fire_panels(var_0[15]);
  thread fire_panels(var_0[16]);
  thread fire_panels(var_0[17]);
  wait(var_1);
  thread fire_panels(var_0[7]);
  thread fire_panels(var_0[8]);
  thread fire_panels(var_0[18]);
  thread fire_panels(var_0[19]);
  thread fire_panels(var_0[20]);
  wait(var_1);
  thread fire_panels(var_0[9]);
  thread fire_panels(var_0[10]);
  thread fire_panels(var_0[21]);
  thread fire_panels(var_0[22]);
  thread fire_panels(var_0[23]);
  wait(var_1);
  thread fire_panels(var_0[11]);
  thread fire_panels(var_0[12]);
  thread fire_panels(var_0[24]);
  thread fire_panels(var_0[25]);
  thread fire_panels(var_0[26]);
  wait(var_1);
  thread fire_panels(var_0[13]);
  thread fire_panels(var_0[14]);
  thread fire_panels(var_0[27]);
  thread fire_panels(var_0[28]);
  thread fire_panels(var_0[29]);
}

fire_pattern_right_wave(var_0) {
  level endon("flag_subpen_traps_completed");
  var_1 = 1.5;
  thread fire_panels_new(var_0[1]);
  wait(var_1);
  thread fire_panels_new(var_0[3]);
  thread fire_panels_new(var_0[4]);
  wait(var_1);
  thread fire_panels_new(var_0[5]);
  thread fire_panels_new(var_0[6]);
  wait(var_1);
  thread fire_panels_new(var_0[7]);
  thread fire_panels_new(var_0[8]);
  wait(var_1);
  thread fire_panels_new(var_0[9]);
  thread fire_panels_new(var_0[10]);
  wait(var_1);
  thread fire_panels_new(var_0[11]);
  thread fire_panels_new(var_0[12]);
  wait(var_1);
  thread fire_panels_new(var_0[13]);
  wait(var_1);
}

fire_pattern_right_wave_reverse(var_0) {
  level endon("flag_subpen_traps_completed");
  var_1 = 1.5;
  thread fire_panels_new(var_0[13]);
  wait(var_1);
  thread fire_panels_new(var_0[11]);
  thread fire_panels_new(var_0[12]);
  wait(var_1);
  thread fire_panels_new(var_0[9]);
  thread fire_panels_new(var_0[10]);
  wait(var_1);
  thread fire_panels_new(var_0[7]);
  thread fire_panels_new(var_0[8]);
  wait(var_1);
  thread fire_panels_new(var_0[5]);
  thread fire_panels_new(var_0[6]);
  wait(var_1);
  thread fire_panels_new(var_0[3]);
  thread fire_panels_new(var_0[4]);
  wait(var_1);
  thread fire_panels_new(var_0[1]);
  wait(var_1);
}

fire_pattern_left_wave(var_0) {
  level endon("flag_subpen_traps_completed");
  var_1 = 1.5;
  thread fire_panels_new(var_0[15]);
  thread fire_panels_new(var_0[16]);
  thread fire_panels_new(var_0[17]);
  wait(var_1);
  thread fire_panels_new(var_0[18]);
  thread fire_panels_new(var_0[19]);
  thread fire_panels_new(var_0[20]);
  wait(var_1);
  thread fire_panels_new(var_0[21]);
  thread fire_panels_new(var_0[22]);
  wait(var_1);
  thread fire_panels_new(var_0[23]);
  wait(var_1);
  thread fire_panels_new(var_0[24]);
  thread fire_panels_new(var_0[25]);
  wait(var_1);
  thread fire_panels_new(var_0[26]);
  thread fire_panels_new(var_0[28]);
  wait(var_1);
}

fire_pattern_left_wave_reverse(var_0) {
  level endon("flag_subpen_traps_completed");
  var_1 = 1.5;
  thread fire_panels_new(var_0[26]);
  thread fire_panels_new(var_0[28]);
  wait(var_1);
  thread fire_panels_new(var_0[24]);
  thread fire_panels_new(var_0[25]);
  wait(var_1);
  thread fire_panels_new(var_0[23]);
  wait(var_1);
  thread fire_panels_new(var_0[21]);
  thread fire_panels_new(var_0[22]);
  wait(var_1);
  thread fire_panels_new(var_0[18]);
  thread fire_panels_new(var_0[19]);
  thread fire_panels_new(var_0[20]);
  wait(var_1);
  thread fire_panels_new(var_0[15]);
  thread fire_panels_new(var_0[16]);
  thread fire_panels_new(var_0[17]);
  wait(var_1);
}

fire_pattern_mid_upper(var_0) {
  level endon("flag_subpen_traps_completed");
  thread fire_panels_new(var_0[29]);
  thread fire_panels_new(var_0[30]);
  thread fire_panels_new(var_0[31]);
}

fire_pattern_mid_lower(var_0) {
  level endon("flag_subpen_traps_completed");
  thread fire_panels_new(var_0[32]);
  thread fire_panels_new(var_0[33]);
  thread fire_panels_new(var_0[34]);
}

fire_panels(var_0) {
  playFX(common_scripts\utility::_id_44F5("zmb_isl_fire_pyro_rnr"), var_0.origin, anglesToForward(var_0.angles));
  var_0 _id_0378::_id_8D74("sub_pen_floor_trap_pyro_flame");
  var_0 _id_0378::_id_8D74("sub_pen_floor_trap_decaying_fire");
  var_1 = _func_18E(var_0.target, "targetname");
  var_2 = gettime();

  for(;;) {
    fire_panel_player_apply_damage(var_1);
    var_3 = _id_0547::_id_408F();

    foreach(var_5 in var_3) {
      if(var_5 istouching(var_1))
        var_5 thread feet_fire_vfx();
    }

    if((gettime() - var_2) / 1000 >= 1) {
      break;
    }

    waitframe();
  }
}

vo_fire_panels(var_0) {
  level endon("flag_subpen_traps_completed");
  var_1 = gettime();

  for(;;) {
    foreach(var_3 in level.players) {
      if(var_3 istouching(var_0) && !common_scripts\utility::_id_562E(var_3.vo_fire_panel_warning_received)) {
        var_3.vo_fire_panel_warning_received = 1;
        var_4 = randomint(5);

        switch (var_4) {
          case 0:
            var_3 thread _id_0367::_id_8E3D("valveson");
            break;
          case 1:
            var_3 thread _id_0367::_id_8E3D("watchthefloor");
            break;
          case 2:
            var_3 thread _id_0367::_id_8E3D("lookout");
            break;
          case 3:
            var_3 thread _id_0367::_id_8E3D("itsonfire");
            break;
          case 4:
            var_3 thread _id_0367::_id_8E3D("move");
            break;
          default:
            break;
        }

        break;
      }
    }

    if((gettime() - var_1) / 1000 >= 3.5) {
      break;
    }

    waitframe();
  }
}

fire_panels_new(var_0) {
  level endon("flag_subpen_traps_completed");
  var_1 = _func_18E(var_0.target, "targetname");
  thread vo_fire_panels(var_1);
  playFX(common_scripts\utility::_id_44F5("zmb_isl_fire_licks_rnr"), var_0.origin, anglesToForward(var_0.angles));
  var_0 _id_0378::_id_8D74("sub_pen_floor_trap_warning_fire");
  wait 3;
  wait(_func_0A5(0.2, 1.0));
  playFX(common_scripts\utility::_id_44F5("zmb_isl_fire_pyro_rnr"), var_0.origin, anglesToForward(var_0.angles));
  playFX(common_scripts\utility::_id_44F5("zmb_isl_fire_pyro_repeating_rnr"), var_0.origin, anglesToForward(var_0.angles));
  var_0 _id_0378::_id_8D74("sub_pen_floor_trap_pyro_flame");
  var_0 _id_0378::_id_8D74("sub_pen_floor_trap_decaying_fire");
  var_2 = gettime();

  for(;;) {
    fire_panel_player_apply_damage(var_1);
    var_3 = _id_0547::_id_408F();

    foreach(var_5 in var_3) {
      if(var_5 istouching(var_1))
        var_5 thread feet_fire_vfx();
    }

    if((gettime() - var_2) / 1000 >= 4.5) {
      break;
    }

    waitframe();
  }
}

fire_panel_player_apply_damage(var_0) {
  if(!isDefined(level.panelattacker)) {
    level.panelattacker = spawn("script_model", (0, 0, 0));
    level.panelattacker setModel("tag_origin");
    level.panelattacker._id_0A4B = "zombie_fireman";
  }

  foreach(var_2 in level.players) {
    if(var_2 istouching(var_0))
      var_2 thread attempt_apply_player_damage();
  }
}

attempt_apply_player_damage() {
  var_0 = self;

  if(!isDefined(var_0.lastburntime))
    var_0.lastburntime = 0;

  if((gettime() - var_0.lastburntime) / 1000 >= 0.65) {
    var_0.lastburntime = gettime();
    var_0 _meth_8059(15, var_0.origin, level.panelattacker, level.panelattacker, "MOD_ENERGY");
  }
}

fire_panels_always_burn(var_0) {
  level endon("flag_subpen_traps_completed");
  var_0.temporarily_turn_off = 0;
  var_1 = _func_14B(common_scripts\utility::_id_44F5("zmb_isl_fire_licks_m"), var_0.origin, anglesToForward(var_0.angles));
  var_0 _id_0378::_id_8D74("sub_pen_floor_trap_warning_fire");
  level.burn_tags = common_scripts\utility::_id_0F6F(level.burn_tags, var_1);
  _func_14C(var_1);
  wait 3;
  var_1 delete();
  level.burn_tags = common_scripts\utility::_id_0F93(level.burn_tags, var_1);
  var_1 = _func_14B(common_scripts\utility::_id_44F5("zmb_isl_fire_pyro_repeating"), var_0.origin, anglesToForward(var_0.angles));
  level.burn_tags = common_scripts\utility::_id_0F6F(level.burn_tags, var_1);
  _func_14C(var_1);
  playFX(common_scripts\utility::_id_44F5("zmb_isl_fire_pyro"), var_0.origin, anglesToForward(var_0.angles));
  var_0 _id_0378::_id_8D74("sub_pen_floor_trap_pyro_flame");
  var_0 _id_0378::_id_8D74("fire_panel_turn_on");
  var_2 = _func_18E(var_0.target, "targetname");
  var_3 = gettime();

  for(;;) {
    fire_panel_player_apply_damage(var_2);
    var_4 = _id_0547::_id_408F();

    foreach(var_6 in var_4) {
      if(var_6 istouching(var_2))
        var_6 thread feet_fire_vfx();
    }

    if(var_0.temporarily_turn_off) {
      break;
    }

    waitframe();
  }

  var_1 delete();
  level.burn_tags = common_scripts\utility::_id_0F93(level.burn_tags, var_1);
  wait 15;
  thread fire_panels_always_burn(var_0);
}

feet_fire_vfx() {
  if(!isDefined(level._effect["zmb_isl_zmb_feet_fire"])) {
    return;
  }
  _func_147(level._effect["zmb_isl_zmb_feet_fire"], self, "Tag_Origin");
}

setup_subpen_switches() {
  level._id_A2A0 = getEntArray("valve", "script_noteworthy");

  foreach(var_1 in level._id_A2A0) {
    var_1.valve_type = "custom";
    var_1._id_9ED7 = 8;
    var_1._id_A2A4 = 4;
    var_1._id_A2A5 = 0;
  }

  foreach(var_1 in level._id_A2A0) {
    if(_id_0547::_id_5565(var_1.targetname, "fuel_valve"))
      var_1 thread _id_A29E();
  }

  var_5 = getEntArray("valveTrigger", "script_noteworthy");

  foreach(var_7 in var_5)
  var_7 common_scripts\utility::_id_9D9F();

  common_scripts\utility::_id_3C9F("flag_freezer_combat_started");

  foreach(var_7 in var_5)
  var_7 common_scripts\utility::_id_9DA3();

  for(;;) {
    if(common_scripts\utility::_id_3C77("fuel_valve_1") && common_scripts\utility::_id_3C77("fuel_valve_2") && common_scripts\utility::_id_3C77("fuel_valve_3")) {
      level notify("subpen_switches_success");
      common_scripts\utility::flag_set("flag_subpen_traps_completed");

      if(isDefined(level.burn_tags)) {
        foreach(var_12 in level.burn_tags)
        var_12 delete();
      }

      break;
    }

    waitframe();
  }

  if(isDefined(level.panelattacker))
    level.panelattacker delete();
}

_id_A29E() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_46B7("gas_vfx", "script_noteworthy");
  var_2 = common_scripts\utility::_id_46B7("indicator_light_vfx", "script_noteworthy");
  var_3 = common_scripts\utility::_id_4461(self.origin, var_2);
  var_4 = common_scripts\utility::_id_46B7("indicator_light_vfx_top", "script_noteworthy");
  var_5 = common_scripts\utility::_id_4461(self.origin, var_4);
  var_6 = _func_14B(common_scripts\utility::_id_44F5("zmb_nest_generator_light_off"), var_3.origin, anglesToForward(var_3.angles), anglestoup(var_3.angles));
  var_7 = _func_14B(common_scripts\utility::_id_44F5("zmb_nest_generator_bulb_off"), var_5.origin, anglesToForward(var_5.angles), anglestoup(var_5.angles));
  _func_14C(var_6, 0.5);
  _func_14C(var_7, 0.5);
  common_scripts\utility::_id_3C9F("flag_freezer_combat_started");
  var_6 delete();
  var_7 delete();
  var_6 = _func_14B(common_scripts\utility::_id_44F5("zmb_nest_generator_light_red"), var_3.origin, anglesToForward(var_3.angles), anglestoup(var_3.angles));
  var_7 = _func_14B(common_scripts\utility::_id_44F5("zmb_nest_generator_bulb_red"), var_5.origin, anglesToForward(var_5.angles), anglestoup(var_5.angles));
  _func_14C(var_6);
  _func_14C(var_7);
  common_scripts\utility::_id_3C9F(self._id_819A);
  var_6 delete();
  var_7 delete();
  var_6 = _func_14B(common_scripts\utility::_id_44F5("zmb_nest_generator_light_green"), var_3.origin, anglesToForward(var_3.angles), anglestoup(var_3.angles));
  var_7 = _func_14B(common_scripts\utility::_id_44F5("zmb_nest_generator_bulb_green"), var_5.origin, anglesToForward(var_5.angles), anglestoup(var_5.angles));
  _func_14C(var_6);
  _func_14C(var_7);
}

setup_aa_guns_power_switch() {
  var_0 = common_scripts\utility::_id_46B7("aagun_switch", "targetname");

  foreach(var_2 in var_0) {
    var_2 initialize_aagun_switches();
    var_2 thread run_aagun_switches();
  }
}

initialize_aagun_switches() {
  var_0 = common_scripts\utility::_id_44BE(self.target, "targetname");
  var_1 = _func_21F("power_switch_island_aagun", "targetname");
  self.computer_panels = common_scripts\utility::_id_4461(self.origin, var_1);
  self.computer_panels _meth_83FA("cbreaker", "standby_idle");
  self.computer_panels _meth_83FA("light_red", "on");
  self.computer_panels _meth_83FA("light_green", "off");
  self.computer_panels _meth_83FA("light_power", "off");
  self.computer_panels _meth_83FA("light_graph", "off");

  foreach(var_3 in var_0) {
    switch (var_3._id_0165) {
      case "use_trigger":
        self._id_9D65 = var_3;
        self._id_9D65 _meth_80CE(&"ZOMBIES_POWER_ON");
        self._id_9D65 waittill("trigger", var_4);
        level.subpen_switches_on++;
        self._id_9D65 common_scripts\utility::_id_9D9F();
        self._id_9D65 _meth_80CE("");
        self.computer_panels _meth_83FA("cbreaker", "ready");
        self.computer_panels _meth_83FA("light_red", "off");
        self.computer_panels _meth_83FA("light_green", "on");
        self.computer_panels _meth_83FA("light_power", "on");
        self.computer_panels _meth_83FA("light_graph", "on");
        common_scripts\utility::flag_set("flag_aa_guns_powered_on");
        break;
    }
  }
}

run_aagun_switches() {
  level endon("subpen_switches_success");

  for(;;) {
    self._id_9D65 waittill("trigger", var_0);
    level.subpen_switches_on++;
    self._id_9D65 common_scripts\utility::_id_9D9F();
    self._id_9D65 _meth_80CE("");
    self.computer_panels _meth_83FA("cbreaker", "ready");
    self.computer_panels _meth_83FA("light_red", "off");
    self.computer_panels _meth_83FA("light_green", "on");
    self.computer_panels _meth_83FA("light_power", "on");
    self.computer_panels _meth_83FA("light_graph", "on");
    common_scripts\utility::flag_set("flag_aa_guns_powered_on");
  }
}

_______________planes_______________() {}

plane_ee_init() {
  level.current_score = 0;
  level.points_to_win = 9999;
  level.aagun_ee_difficulty = 0;
  level.current_score = 0;
  _id_0378::_id_8D74("aud_plane_mission_start");
  var_0 = _func_18E("zmb_island_plane_crash_strap", "targetname");
  var_0 _meth_805C();
  plane_ee_set_rules();
  level thread plane_ee_score_counter();
  level thread plane_ee_wave_handler();
  level thread plane_ee_cloud_handler();

  foreach(var_2 in level.players)
  var_2.plane_vo_reaction = 0;
}

aa_gun_trap_buy_me() {
  self._id_9D65._id_267B = 750;

  while(!_id_0557::_id_7831("CORPSE_GATE"))
    waitframe();

  level thread wait_for_objective_start();
  common_scripts\utility::_id_3C9F("flak_cannons_ready");
  self._id_9D65 _meth_80CE(self._id_9D65.hint_string_no_power);
  common_scripts\utility::_id_3C9F("flag_aa_guns_powered_on");
  common_scripts\utility::flag_set("flag_used_island_turret");
  self._id_9D65 _meth_80CE(self._id_9D65.hint_string_available);
  thread wait_for_aa_turret_trigger_interact();
  var_0 = undefined;

  for(;;) {
    level waittill("aa_gun_request", var_1, var_2);

    if(isDefined(var_2) && var_2 != self) {
      continue;
    }
    if(!isPlayer(var_1)) {
      if(common_scripts\utility::_id_562E(var_1))
        handle_turret_lockdown();

      self._id_9D65 _meth_80CE(self._id_9D65.hint_string_available);
      continue;
    } else
      var_0 = var_1;

    if(!var_0 maps\mp\gametypes\zombies::_id_11C2(self._id_9D65._id_267B)) {
      var_0 thread _id_054E::_id_0695("needmoney");
      continue;
    } else {
      self._id_9D65 common_scripts\utility::_id_9D9F();
      self.wall_model thread set_wall_up();
      self.wall_model set_player_using_turret(var_0, self._id_9EDD);
      var_0 _id_0367::_id_8E3D("flakon_both");
      var_3 = ["zombie_generic", "zombie_berserker"];
      self.wall_model thread maps\mp\mp_zombies_attack_object::create_inanimate_zombie_enemy(3, 400, "this_turret_is_done", 1024, 512, ::stunning_burst_zombies, [::player_left, ::player_died, ::player_disconnected], self._id_1176, var_3, ["zombie_is_passive", "zombie_is_crawler", "zombie_is_objective", "zombie_is_stunned"], var_0);
      self.wall_model common_scripts\utility::_id_379C("this_turret_is_done");
      self.wall_model unset_player_using_turret(var_0, self._id_9EDD);
      self.wall_model common_scripts\utility::_id_3796("this_turret_is_done");
      playFX(level._effect["zmb_isl_aa_gun_gk_energy"], self.wall_model.origin, anglesToForward(self.wall_model.angles));
      var_0 _id_0378::_id_8D74("aud_stunning_burst_use");
      self.wall_model thread set_wall_down();
      wait 1;
      self._id_9D65 common_scripts\utility::_id_9DA3();
      self._id_9D65 _meth_80CE(self._id_9D65.hint_string_unavailable);
      wait 12.5;
      handle_turret_lockdown();
      self._id_9D65 _meth_80CE(self._id_9D65.hint_string_available);
    }
  }
}

handle_turret_lockdown() {
  while(common_scripts\utility::_id_562E(level.aa_guns_locked)) {
    self._id_9D65 _meth_80CE(self._id_9D65.hint_string_unavailable);
    wait 0.125;
  }
}

wait_for_aa_turret_trigger_interact() {
  for(;;) {
    self._id_9D65 waittill("trigger", var_0);
    level notify("aa_gun_request", var_0, self);
  }
}

lock_island_aa_gun_turrets(var_0) {
  level.aa_guns_locked = var_0;
  level notify("aa_gun_request", var_0);
}

wait_for_objective_start() {
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("CORPSE_GATE", "Open Corpse Gate"));
  common_scripts\utility::flag_set("flak_cannons_ready");
}

set_wall_up() {
  self _meth_8276("s2_zom_flak_gun_gate_close");
  _id_0378::_id_8D74("flak_gun_gate_up");
  wait(_func_065(%s2_zom_flak_gun_gate_open));
  self _meth_8276("s2_zom_flak_gun_gate_close_idle");
}

set_wall_down() {
  self _meth_8276("s2_zom_flak_gun_gate_open");
  _id_0378::_id_8D74("flak_gun_gate_down");
  wait(_func_065(%s2_zom_flak_gun_gate_open));
  self _meth_8276("s2_zom_flak_gun_gate_open_idle");
}

stunning_burst_zombies() {
  var_0 = _id_0547::_id_408F();
  var_1 = 0;

  foreach(var_3 in common_scripts\utility::_id_40B0(self.origin, var_0, undefined, undefined, 200)) {
    if(_id_0547::_id_5565(var_3._id_0A4B, "zombie_generic") || _id_0547::_id_5565(var_3._id_0A4B, "zombie_berserker"))
      var_3 _id_056D::_id_5A86();
  }
}

set_player_using_turret(var_0, var_1) {
  self.turret_player = var_0;
  self._id_9EDD = var_1;
  var_0._id_00CE = 1;
  var_0.on_aa_gun = 1;
  var_1 _meth_8093(var_0);
  var_0._id_480F = 1;
  var_0 _meth_82FF("ui_zm_turret_health", 1);
  var_0 _meth_80EB();
  wait 1.5;
  var_0 _meth_80EC();
}

unset_player_using_turret(var_0, var_1) {
  var_0._id_00CE = 0;
  var_0.on_aa_gun = 0;
  var_0 _meth_85E9();
  var_0._id_480F = 0;
  var_0 _meth_82FF("ui_zm_turret_health", 0);
  var_0 notify("left_aa_gun");
}

turret_time_limit(var_0) {
  self endon(var_0);
  wait 15;
}

player_left(var_0) {
  self endon(var_0);
  self._id_9EDD waittill("turret_deactivate");
}

player_died(var_0) {
  self endon(var_0);

  while(isDefined(self.turret_player) && isalive(self.turret_player) && !common_scripts\utility::_id_562E(self.turret_player._id_5728))
    waitframe();
}

player_disconnected(var_0) {
  self endon(var_0);
  self.turret_player waittill("disconnect");
}

plane_ee_set_rules() {
  level.aagun_ee_difficulty = level.players.size;

  if(level.aagun_ee_difficulty == 1)
    level.points_to_win = 10;

  if(level.aagun_ee_difficulty == 2)
    level.points_to_win = 12;

  if(level.aagun_ee_difficulty >= 3)
    level.points_to_win = 13;
}

plane_ee_adjust_rules() {
  var_0 = level.aagun_ee_difficulty;
  var_1 = level.players.size;

  if(var_1 >= var_0) {
    if(var_1 == 2)
      level.points_to_win = 12;

    if(var_1 >= 3)
      level.points_to_win = 13;
  }
}

plane_ee_score_counter() {
  common_scripts\utility::flag_init("flag_planes_half_way_done");

  while(level.current_score <= level.points_to_win) {
    level waittill("plane_killed");
    level.current_score++;
  }

  if(level.current_score >= level.points_to_win / 2) {
    if(!common_scripts\utility::_id_3C77("flag_planes_half_way_done"))
      level thread vo_players_half_way_done();
  }

  if(level.current_score >= level.points_to_win) {
    level notify("island_plane_destroyed");
    common_scripts\utility::flag_set("flag_players_have_won");
    var_0 = _func_1DB("plane_start_node_radio", "targetname");
    var_0 plane_ee_spawn_radio_plane(1);
  } else
    thread plane_ee_score_counter();
}

plane_ee_cloud_handler() {
  var_0 = common_scripts\utility::_id_46B7("struct_cloud_fx_spawner_village", "targetname");
  var_1 = common_scripts\utility::_id_46B7("struct_cloud_fx_spawner_docks", "targetname");
  var_2 = common_scripts\utility::_id_46B7("struct_cloud_fx_spawner_ocean", "targetname");
  var_3 = common_scripts\utility::_id_46B7("struct_cloud_fx_spawner_beach", "targetname");
  var_4 = common_scripts\utility::_id_46B7("struct_cloud_fx_spawner_lighthouse", "targetname");

  foreach(var_6 in var_0)
  playFX(level._effect["zmb_clouds_puff_static"], var_6.origin, (1, 1, 0));

  foreach(var_6 in var_1)
  playFX(level._effect["zmb_clouds_puff_static"], var_6.origin, (1, -1, 0));

  foreach(var_6 in var_2)
  playFX(level._effect["zmb_clouds_puff_static"], var_6.origin, (0, -1, 0));

  foreach(var_6 in var_3)
  playFX(level._effect["zmb_clouds_puff_static"], var_6.origin, (-1, -1, 0));

  foreach(var_6 in var_4)
  playFX(level._effect["zmb_clouds_puff_static"], var_6.origin, (-1, 1, 0));
}

plane_ee_wave_handler() {
  var_0 = [1, 2, 3, 4];

  while(!common_scripts\utility::_id_3C77("flag_players_have_won")) {
    var_1 = common_scripts\utility::random(var_0);
    var_0 = common_scripts\utility::_id_0F93(var_0, var_1);

    if(var_0.size <= 0)
      var_0 = [1, 2, 3, 4];

    switch (var_1) {
      case 1:
        level.plane_wave_vo_played = 0;
        plane_ee_adjust_rules();
        level.wave_a = _func_1DC("plane_start_node_a", "targetname");
        var_2 = level.wave_a plane_ee_do_spawn_plane_wave();
        level thread vo_planes_by_village();
        break;
      case 2:
        level.plane_wave_vo_played = 0;
        plane_ee_adjust_rules();
        level.wave_b = _func_1DC("plane_start_node_b", "targetname");
        var_2 = level.wave_b plane_ee_do_spawn_plane_wave();
        level thread vo_planes_by_docks();
        break;
      case 3:
        level.plane_wave_vo_played = 0;
        plane_ee_adjust_rules();
        level.wave_c = _func_1DC("plane_start_node_c", "targetname");
        var_2 = level.wave_c plane_ee_do_spawn_plane_wave();
        level thread vo_planes_by_beach();
        break;
      case 4:
        level.plane_wave_vo_played = 0;
        plane_ee_adjust_rules();
        level.wave_d = _func_1DC("plane_start_node_d", "targetname");
        var_2 = level.wave_d plane_ee_do_spawn_plane_wave();
        level thread vo_planes_by_lighthouse();
        break;
      default:
        break;
    }

    wait 30;
  }
}

plane_ee_do_spawn_plane_wave() {
  var_0 = [];
  var_1 = 0;

  foreach(var_3 in self) {
    var_4 = var_3 plane_ee_do_spawn_planes();
    var_0 = common_scripts\utility::_id_0F6F(var_0, var_4);
  }

  var_6 = var_0[0].targetname;
  thread plane_ee_bonus_point_counter(var_0, var_6);
  return var_0;
}

plane_ee_bonus_point_counter(var_0, var_1) {
  var_2 = 0;
  thread plane_ee_plane_cleaner(var_0);

  while(var_0.size >= 0) {
    level waittill(var_1);
    var_2++;

    if(var_2 >= 6) {
      level.current_score = level.current_score + 1;
      break;
    }

    wait 1;
  }
}

plane_ee_plane_cleaner(var_0) {
  while(var_0.size >= 0) {
    var_0 = common_scripts\utility::_id_0FA0(var_0);
    wait 0.5;
  }
}

plane_ee_do_spawn_planes() {
  var_0 = "ger_bomber_stuka_hub";
  var_1 = "ger_bomber_stuka_vista";
  var_2 = _func_2CD(self.origin, self.angles, var_0, var_1);
  var_2.targetname = self.targetname;
  level.active_planes[level.active_planes.size] = var_2;
  var_2 _meth_80B1();
  var_2 notify("forward");
  var_2._id_01C7 = "forward";
  var_2._id_01C1 = "forward";
  var_2._id_17DC = 0;
  var_2._id_931A = "forward";
  var_2 _id_0378::_id_8D74("aud_plane_spawn");
  var_2 thread plane_ee_do_plane_turrets();
  var_2 _meth_827C(self);
  var_2 thread plane_ee_vehicle_paths_non_heli(self);
  var_2 thread maps\mp\gametypes\_damage::_id_8676(100);
  var_2.health = 60;
  var_2.damagecallback = ::_id_703F;
  var_2 thread plane_ee_handleflakprojectileproximity();
  var_2 thread plane_ee_do_plane_cleanup();
  return var_2;
}

plane_ee_spawn_radio_plane(var_0, var_1) {
  var_2 = "ger_bomber_stuka_hub";
  var_3 = "ger_bomber_stuka_vista";
  var_4 = _func_2CD(self.origin, self.angles, var_2, var_3);
  var_4.targetname = self.targetname;
  var_4.mustfindacrashpath = common_scripts\utility::_id_562E(var_0);
  var_5 = common_scripts\utility::random(level.players);
  var_5 thread _id_0367::_id_8E3C("planegone");
  var_4 common_scripts\utility::_id_3799("plane_crashed");
  var_4 common_scripts\utility::_id_3799("plane_got_away");
  var_4 notify("forward");
  var_4._id_01C7 = "forward";
  var_4._id_01C1 = "forward";
  var_4._id_17DC = 0;
  var_4._id_931A = "forward";
  var_4 thread plane_ee_do_plane_turrets();
  var_4 _meth_827C(self);
  var_4 _id_0378::_id_8D74("aud_last_plane_spawn");
  var_4 thread plane_ee_vehicle_paths_non_heli(self);
  var_4 thread maps\mp\gametypes\_damage::_id_8676(100);
  var_4.health = 60;
  var_4.damagecallback = ::_id_703F;
  var_4 thread plane_ee_handleflakprojectileproximity();

  if(common_scripts\utility::_id_3C77("flag_ui_planes_ee_done"))
    var_4 thread ensure_death_scene();

  var_4 common_scripts\utility::_id_379E("plane_crashed", "plane_got_away");

  if(var_4 common_scripts\utility::_id_3794("plane_got_away")) {
    var_4 delete();
    var_4 = _func_1DB("plane_start_node_radio", "targetname");
    var_4 plane_ee_spawn_radio_plane(1, 1);
  } else {
    level thread maps\mp\mp_zombie_island::ee_casual_plane_cliff_crash();
    _id_0378::_id_8D74("aud_last_plane_crash", var_4.origin);
    _id_0557::_id_782D("Flak Tower", "Defend Flak Tower");
    var_4 delete();
    wait 2;
    thread plane_wreckage_radio_vo();
  }
}

ensure_death_scene() {
  while(!common_scripts\utility::_id_3C83("aud_last_plane_spawned"))
    waitframe();

  plane_ee_plane_crashy();
}

plane_ee_do_plane_sound() {}

plane_damage_player() {
  self endon("death");
  var_0 = _func_18E("vol_plane_damage_area", "targetname");

  while(common_scripts\utility::_id_3794("turret_on")) {
    if(_id_0547::_id_5565(level.plane_wave_vo_played, 0))
      thread plane_wave_diving_vo();

    var_1 = self.origin;
    var_2 = anglesToForward(self _meth_8181("TAG_MUZZLE_FX_1"));
    var_3 = 10000;
    var_4 = 180;
    var_5 = bulletTrace(self gettagorigin("TAG_MUZZLE_FX_1"), var_1 + var_2 * var_3, 0, undefined, 1, 1, 0, 0, 0, 0, 0);

    if(isDefined(var_5["position"])) {
      var_6 = var_5["position"];
      var_7 = _id_0547::_id_408F();
      var_7 = _func_1AC(var_7, var_6, var_4, 1);

      foreach(var_9 in var_7) {
        if(_func_07E(var_6 + (0, 0, 25), var_9 getEye(), 0))
          var_9 _meth_8059(80, self.origin);
      }

      var_11 = _func_1AC(level.players, var_6, var_4, 1);

      foreach(var_13 in var_11) {
        if(_func_07E(var_6 + (0, 0, 25), var_13.origin, 0) || _func_07E(var_6 + (0, 0, 25), var_13 gettagorigin("j_spine4"), 0) || _func_07E(var_6 + (0, 0, 25), var_13 getEye(), 0)) {
          var_13 _meth_8059(23, self.origin);
          var_13 notify("aagun_damage");
        }
      }
    }

    wait 0.22;
  }
}

plane_wave_diving_vo() {
  level.plane_wave_vo_played = 1;
  wait 1;
  var_0 = randomint(4);

  switch (var_0) {
    case 0:
      _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("planewarn");
      break;
    case 1:
      _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("planewarn2");
      break;
    case 2:
      _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("planewarn3");
      break;
    case 3:
      _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("planewarn4");
      break;
  }
}

plane_ee_do_plane_turrets() {
  self endon("death");
  common_scripts\utility::_id_3799("turret_on");
  common_scripts\utility::_id_3799("turret_off");
  common_scripts\utility::_id_379C("turret_on");
  var_0 = self gettagorigin("TAG_MUZZLE_FX_1");
  var_1 = self gettagorigin("TAG_MUZZLE_FX_2");
  common_scripts\utility::_id_379C("turret_on");
  _id_0378::_id_8D74("aud_plane_firing");
  thread plane_damage_player();

  while(common_scripts\utility::_id_3794("turret_on")) {
    _func_147(level._effect["zmb_isl_enemy_plane_tracer"], self, "TAG_MUZZLE_FX_1");
    _func_147(level._effect["zmb_isl_enemy_plane_tracer"], self, "TAG_MUZZLE_FX_2");
    wait 0.2;
  }
}

plane_ee_do_plane_cleanup() {
  wait 4;

  for(;;) {
    if(isDefined(self) && self._id_01C4 <= 0) {
      level.active_planes = common_scripts\utility::_id_0F93(level.active_planes, self);
      self notify("death");
      self delete();
      break;
    }

    wait 3;
  }
}

_id_703F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self endon("plane_killed");

  if(common_scripts\utility::_id_562E(self.findingacrashpath)) {
    return;
  }
  if(isDefined(var_1._id_01D1) && !isPlayer(var_1))
    var_1 = var_1 _meth_80E2();

  if(isDefined(self._id_6E74))
    var_12 = self._id_6E74;
  else
    var_12 = self;

  if(var_5 != "turretweapon_ger_btry_flak38_mp_zombie" && var_5 != "bazooka_mp" && var_5 != "panzerschreck_mp" && var_5 != "fliegerfaust_zm" && var_5 != "fliegerfaust_pap_zm")
    var_2 = 1;

  var_12.health = var_12.health - var_2;

  if(var_12.health <= 0) {
    if(isDefined(var_1)) {
      var_1 _id_04C7::_id_A102("killshot");

      if(isDefined(level.zmb_events_player_destroyed_stuka))
        var_1 thread[[level.zmb_events_player_destroyed_stuka]]();

      var_13 = _func_0A4(0, 11);

      if(var_13 <= 4)
        var_1 thread vo_plane_killed();
    }

    if(isDefined(var_5) && isPlayer(var_1))
      var_1 notify("plane_crashy", var_5);

    var_12 plane_ee_plane_crashy();
  } else if(isDefined(var_1))
    var_1 _id_04C7::_id_A102("standard");
}

_id_7040(var_0, var_1, var_2, var_3) {
  self endon("death");
  self._id_1180 = var_0;
}

plane_ee_plane_crashy() {
  if(common_scripts\utility::_id_562E(self.findingacrashpath)) {
    return;
  }
  if(!isDefined(self._id_272B) || self._id_272B == 0) {
    self._id_272B = 1;
    self notify("crashing");
    _id_0378::_id_8D74("aud_plane_tailspin");

    if(common_scripts\utility::_id_562E(self.mustfindacrashpath)) {
      self.findingacrashpath = 1;
      common_scripts\utility::flag_set("flag_ui_planes_ee_done");
      wait_for_valid_crash_path();
    }

    var_0 = self._id_2944;

    if(isDefined(var_0) && isDefined(var_0.script_exploder)) {
      self.crashingspecial = 1;
      var_0 = self._id_2944;
      plane_ee_goto_linkto_path(var_0);
      waitframe();
      self waittill("reached_dynamic_path_end");
      common_scripts\utility::_id_379A("plane_crashed");
      return;
    } else {
      var_1 = _func_0A5(-90, 90);
      var_2 = (0, _func_0A7(var_1), _func_0A6(var_1));
      var_3 = (_func_0A5(-1000, 1000), _func_0A5(-1000, 1000), _func_0A5(-1000, 1000));
      var_4 = 1.2;
      self _meth_8224(level.player.origin + var_3, self _meth_8283() * var_4, var_2);
    }

    common_scripts\utility::waittill_notify_or_timeout("veh_collision", _func_0A5(0.5, 3.0));
  }

  if(!isDefined(self.crashingspecial) || self.crashingspecial == 0)
    plane_ee_plane_go_boom();
}

wait_for_valid_crash_path() {
  self endon("plane_got_away");

  for(;;) {
    if(isDefined(self._id_2944) && isDefined(self._id_2944.script_exploder)) {
      var_0 = _func_1DC(self._id_2944.script_exploder, "script_linkname");

      if(var_0.size > 0) {
        break;
      }
    }

    waitframe();
  }

  return 1;
}

plane_ee_plane_go_boom(var_0) {
  if(!isDefined(self)) {
    return;
  }
  var_1 = anglesToForward(self.angles);

  if(!common_scripts\utility::_id_562E(var_0)) {
    playFX(level._effect["plane_death"], self.origin, var_1);
    _id_0378::_id_8D74("aud_plane_explode", self.origin);
  }

  level notify(self.targetname);
  level notify("plane_killed");
  self notify("delete");
  waittillframeend;
  self delete();
  self notify("plane_killed");
}

plane_ee_manage_aa_swaps() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("turretownerchange");
    var_0 = self _meth_80E2();

    if(isDefined(var_0) && isPlayer(var_0))
      thread plane_ee_capture_turret_fire(var_0);
  }
}

plane_ee_capture_turret_fire(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("turretownerchange");

  for(;;) {
    self waittill("turret_fire", var_1);

    if(!isDefined(var_1[0])) {
      continue;
    }
    thread plane_ee_flakprojectilezombieproximitydetonate(var_1[0], var_0);
    level notify("flak_projectile_fired", var_1[0], var_0);
  }
}

plane_ee_handleflakprojectileproximity() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");

  for(;;) {
    level waittill("flak_projectile_fired", var_0, var_1);

    if(!isDefined(var_0)) {
      continue;
    }
    thread plane_ee_flakprojectileproximitydetonate(var_0, var_1);
  }
}

plane_ee_flakprojectilezombieproximitydetonate(var_0, var_1) {
  var_1 endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_2 = 64;
  var_3 = common_scripts\utility::_id_4461(var_0.origin, _id_0547::_id_408F());

  for(;;) {
    if(isDefined(var_3) && _func_0E1(var_3 getEye(), var_0.origin) < var_2 && _func_0AE(var_0.origin[2] - var_3.origin[2]) < 120) {
      var_1 _id_04C7::_id_A102("standard");
      var_0 _meth_8561("turretweapon_ger_btry_flak38_mp_zombie", var_1, var_0);
      break;
    }

    waitframe();
  }
}

plane_ee_flakprojectileproximitydetonate(var_0, var_1) {
  self endon("death");
  self endon("crashing");
  var_1 endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_2 = 250000;

  for(;;) {
    var_3 = self.origin;
    var_4 = distancesquared(var_0.origin, var_3);

    if(var_4 < var_2) {
      var_0 notify("plane_death");
      self _meth_8059(500, var_3, var_1, var_0, "MOD_PROJECTILE", var_0._id_A9E0);
      var_0 _meth_81D6();
    }

    waitframe();
  }
}

plane_ee_get_from_vehicle_node(var_0) {
  return _func_1DB(var_0, "targetname");
}

plane_ee_get_from_vehicle_node_reverse(var_0) {
  var_1 = _func_1DB(var_0, "targetname");
  var_2 = var_1 _meth_8650();
  return var_2 _meth_8650();
}

plane_ee_get_path_getfunc(var_0) {
  var_1 = ::plane_ee_get_from_vehicle_node;
  return var_1;
}

plane_ee_get_path_getfunc_reverse(var_0) {
  var_1 = ::plane_ee_get_from_vehicle_node_reverse;
  return var_1;
}

plane_ee_deathrollon() {
  if(self.health > 0)
    self._id_7ED6 = 1;
}

plane_ee_deathrolloff() {
  self._id_7ED6 = undefined;
  self notify("deathrolloff");
}

plane_ee_goto_linkto_path(var_0) {
  waittillframeend;

  if(isDefined(var_0) && isDefined(var_0.script_exploder)) {
    var_1 = _func_1DC(var_0.script_exploder, "script_linkname");

    if(isDefined(var_1) && isDefined(var_1[0])) {
      thread plane_ee_vehicle_paths_non_heli(var_1[0]);
      self _meth_827C(var_1[0]);
    }
  }
}

plane_ee_node_wait(var_0, var_1, var_2) {
  if(self._id_1146 == var_0 && !isDefined(var_1)) {
    self notify("node_wait_terminated");
    waittillframeend;
    return;
  }

  if(isDefined(self._id_A01E))
    var_3 = "node_wait_triggered" + self._id_A01E;
  else
    var_3 = "node_wait_triggered";

  if(!isDefined(var_0._id_9DBB) || var_0._id_9DBB != gettime()) {
    var_4 = spawnStruct();
    plane_ee_wait_til_node_wait_triggered(var_4, var_3, var_0, var_2);
    var_4 waittill(var_3);
  }

  var_0._id_9DBB = undefined;
}

plane_ee_wait_til_node_wait_triggered(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  for(var_5 = var_2; isDefined(var_2) && var_4 < 3; var_2 = [[var_3]](var_2.target)) {
    var_4++;
    thread plane_ee_node_wait_triggered(var_0, var_1, var_2);

    if(!isDefined(var_2.target))
      return;
  }
}

plane_ee_node_wait_triggered(var_0, var_1, var_2) {
  self endon("newpath");
  self endon("death");
  var_0 endon(var_1);
  var_2 waittill("trigger");
  var_2._id_9DBB = gettime();
  waittillframeend;
  var_0 notify(var_1);
}

plane_ee_vehicle_paths_non_heli(var_0) {
  self notify("newpath");

  if(isDefined(var_0))
    self._id_1146 = var_0;

  var_1 = self._id_1146;
  self._id_2944 = self._id_1146;

  if(!isDefined(var_1)) {
    return;
  }
  self endon("newpath");
  self endon("death");
  var_2 = var_1;
  var_3 = undefined;
  var_4 = var_1;
  var_5 = plane_ee_get_path_getfunc(var_1);
  var_6 = plane_ee_get_path_getfunc_reverse(var_1);

  if(self._id_01C1 == "reverse")
    var_7 = var_6;
  else
    var_7 = var_5;

  while(isDefined(var_4)) {
    plane_ee_node_wait(var_4, var_3, var_7);

    if(!isDefined(self)) {
      return;
    }
    self._id_2944 = var_4;

    if(isDefined(var_4._id_0165)) {
      self notify(var_4._id_0165);
      self notify("noteworthy", var_4._id_0165);
    }

    waittillframeend;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_4._id_8272)) {
      var_4._id_8186 = var_4._id_8272;
      var_4._id_8272 = undefined;
    }

    if(isDefined(var_4._id_8186)) {
      var_8 = var_4._id_8187;

      if(isDefined(var_8))
        level maps\mp\_utility::_id_2CED(var_8, common_scripts\_exploder::exploder, var_4._id_8186);
      else
        level common_scripts\_exploder::exploder(var_4._id_8186);
    }

    if(isDefined(var_4._id_81A0))
      common_scripts\utility::flag_set(var_4._id_81A0);

    if(isDefined(var_4._id_8183))
      common_scripts\utility::_id_379A(var_4._id_8183);

    if(isDefined(var_4._id_8182))
      common_scripts\utility::_id_3796(var_4._id_8182);

    if(isDefined(var_4._id_819B))
      common_scripts\utility::_id_3C7B(var_4._id_819B);

    if(isDefined(var_4._id_0165)) {
      if(var_4._id_0165 == "godon")
        self._id_480F = 1;

      if(var_4._id_0165 == "godoff")
        self._id_480F = 0;

      if(var_4._id_0165 == "engineoff")
        self _meth_828D();
    }

    if(isDefined(var_4._id_8145))
      self._id_8145 = var_4._id_8145;

    if(isDefined(var_4._id_8121))
      self._id_8121 = var_4._id_8121;

    if(isDefined(var_4._id_82B2))
      self._id_82B2 = var_4._id_82B2;

    if(isDefined(var_4._id_82C1))
      self notify("turning", var_4._id_82C1);

    if(isDefined(var_4._id_8150)) {
      if(var_4._id_8150 == 0)
        thread plane_ee_deathrolloff();
      else
        thread plane_ee_deathrollon();
    }

    if(isDefined(var_4._id_82D4)) {
      if(isDefined(var_4._id_8260) && var_4._id_8260 == "queue")
        self._id_7889 = 1;
    }

    if(isDefined(var_4._id_812B))
      self._id_01C0 = var_4._id_812B;

    if(isDefined(var_4._id_8265))
      self._id_01C3 = var_4._id_8265;

    if(isDefined(var_4._id_8262))
      self._id_01C1 = var_4._id_8262;

    if(isDefined(var_4._id_8184)) {
      var_9 = 35;

      if(isDefined(var_4._id_8151))
        var_9 = var_4._id_8151;

      self _meth_8280(0, var_9);
      common_scripts\utility::_id_379C(var_4._id_8184);

      if(!isDefined(self)) {
        return;
      }
      var_10 = 60;

      if(isDefined(var_4.script_accel))
        var_10 = var_4.script_accel;

      self _meth_8293(var_10);
    }

    var_3 = var_4;

    if(!isDefined(var_4.target)) {
      break;
    }

    if(self._id_01C1 == "reverse")
      var_7 = var_6;
    else
      var_7 = var_5;

    var_4 = [[var_7]](var_4.target);

    if(!isDefined(var_4)) {
      var_4 = var_3;
      break;
    } else if(!isDefined(var_4.target) || isDefined(var_4._id_82CA)) {
      var_11 = max(0.01, length(self _meth_8289()));
      var_12 = distance(self.origin, var_4.origin);
      var_13 = max(0.01, var_12 / var_11);
      self notify("about_to_stop", var_13);
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self._id_82D3)) {
    self notify("delete");
    waittillframeend;
    self delete();
  } else
    thread plane_ee_goto_linkto_path(var_4);
}

track_damage(var_0, var_1) {
  _id_A725("turretweapon_ger_btry_flak38_mp_zombie");
}

_id_A725(var_0) {
  self _meth_82C3(1);

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isDefined(var_10) || !issubstr(var_10, var_0)) {
      continue;
    }
    break;
  }
}

quest_step_defend_the_flak_tower() {
  level thread maps\mp\mp_zombie_island_ee_fog_manager::set_fog_locked_to_off();
  level thread plane_ee_init();
  var_0 = 1;

  for(var_1 = 0; var_1 < var_0; var_1++)
    level waittill("island_plane_destroyed");
}

flak_complete_xp_reward() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("flak");
    var_1 _id_0378::_id_8D74("objective_complete", "flak");
  }
}

vo_check_first_plane_spawn() {
  var_0 = 0;

  if(!common_scripts\utility::_id_3C77("flag_first_plane_has_spawn")) {
    common_scripts\utility::flag_set("flag_first_plane_has_spawn");
    var_0 = 1;
    return var_0;
  } else
    return var_0;
}

vo_planes_by_village() {
  var_0 = common_scripts\utility::random(level.players);
  var_0 thread _id_0367::_id_8E3C("planevillage");
}

vo_planes_by_docks() {
  var_0 = common_scripts\utility::random(level.players);
  var_0 thread _id_0367::_id_8E3C("planedocks");
}

vo_planes_by_beach() {
  var_0 = common_scripts\utility::random(level.players);
  var_0 thread _id_0367::_id_8E3C("planebeach");
}

vo_planes_by_lighthouse() {
  var_0 = common_scripts\utility::random(level.players);
  var_0 thread _id_0367::_id_8E3C("planelighthouse");
}

vo_plane_killed() {
  var_0 = _func_0A4(1, 4);
  var_1 = undefined;

  if(var_0 == 1)
    var_1 = "planehit";

  if(var_0 == 2)
    var_1 = "planehit2";

  if(var_0 == 3)
    var_1 = "planehit3";

  if(isDefined(self.plane_vo_reaction) && self.plane_vo_reaction == 0) {
    thread vo_plane_killed_reaction();
    thread _id_0367::_id_8E3C(var_1);
  }
}

vo_plane_killed_reaction() {
  self.plane_vo_reaction = 1;
  wait 2.5;
  self.plane_vo_reaction = 0;
}

vo_players_half_way_done() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2 _meth_8347())
      var_0 = common_scripts\utility::_id_0F6F(var_0, var_2);
  }

  var_2 = common_scripts\utility::random(var_0);

  if(isDefined(var_2))
    var_2 thread _id_0367::_id_8E3C("planemore");

  common_scripts\utility::flag_set("flag_planes_half_way_done");
}

______________razer_gun_assembly_____________() {}

quest_init_razergun_assembly() {
  razergun_bench_init();
  level thread maps\mp\_utility::_id_6F74(::comment_on_workbench_vo);
  level thread razergun_parts_collect();
  var_0 = common_scripts\utility::_id_46B7("weapon_assembly_bench", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread manage_bench_trigger();
    var_2 thread razergun_build_melee();
    var_2 thread razergun_build_ranged();
  }

  level thread activate_workbench_on_parts_placed();
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("explore_the_island", "Explore Pen"));
  common_scripts\utility::flag_set("Commence Weapon Assembly");
}

comment_on_workbench_vo() {
  self endon("death");
  self endon("disconnect");
  var_0 = common_scripts\utility::_id_46B5("weapon_assembly_bench", "targetname");

  while(distance(self.origin, var_0.origin) > var_0.radius || _func_0AE(var_0.origin[2] - self.origin[2]) > var_0._id_00BD)
    _id_0547::_id_A6F6();

  thread _id_0367::_id_8E3C("weaponbenchtouch");
}

manage_bench_trigger() {
  common_scripts\utility::_id_3CA2("players_have_razergun_1", "players_have_razergun_2");
  self.assembly_trig _meth_80CE(&"ZOMBIE_ISLAND_PART_PLACE");
  common_scripts\utility::_id_3CA2("razergun_1_placed", "razergun_2_placed");
  self.assembly_trig common_scripts\utility::_id_9D9F();
  common_scripts\utility::_id_3CA0("players_have_razergun_1", "players_have_razergun_2");
  self.assembly_trig common_scripts\utility::_id_9DA3();
  common_scripts\utility::_id_3CA0("razergun_1_placed", "razergun_2_placed");
  self.assembly_trig _meth_80CE(&"ZOMBIES_EMPTY_STRING");
  self.assembly_trig _meth_80B3();

  foreach(var_1 in self.assembly_ranged_trigs) {
    if(isDefined(var_1)) {
      var_1 makeusable();

      if(_id_0547::_id_5819(var_1))
        _id_0547::_id_8A4F(var_1, ::razergun_bench_assign_trig);

      var_1 thread razergun_bench_assemble_think();
    }
  }

  common_scripts\utility::_id_3C9F("razergun_3_placed");

  foreach(var_1 in self.assembly_ranged_trigs)
  var_1 _meth_80B3();

  common_scripts\utility::_id_3C9F("razergun_charged");
  self.assembly_trig makeusable();
  common_scripts\utility::_id_3C9F("razergun_infused");
  self.assembly_trig _meth_80B3();

  foreach(var_1 in self.assembly_ranged_trigs)
  var_1 makeusable();
}

activate_workbench_on_parts_placed() {
  common_scripts\utility::_id_3CA0("razergun_1_placed", "razergun_2_placed");
  common_scripts\utility::flag_set("Commence Weapon Assembly");
}

quest_step_build_razergun_1() {
  common_scripts\utility::_id_3CA0("players_have_razergun_1", "players_have_razergun_2");
  _id_0557::_id_7822("Aquire Wonder Weapon", _id_0557::removed_quest_hint());
  common_scripts\utility::_id_3CA0("razergun_1_placed", "razergun_2_placed");
  _id_0557::_id_782D("Aquire Wonder Weapon", "Melee Razor Gun Built");
}

quest_step_build_razergun_2() {
  common_scripts\utility::_id_3C9F("players_have_razergun_3");
  _id_0557::_id_7822("Aquire Wonder Weapon", _id_0557::removed_quest_hint());
  common_scripts\utility::_id_3C9F("razergun_3_placed");
  _id_0557::_id_7822("Aquire Wonder Weapon", _id_0557::removed_quest_hint());
  common_scripts\utility::_id_3C9F("razergun_infused");
  _id_0557::_id_782D("Aquire Wonder Weapon", "Ranged Razor Gun Built");
}

razergun_build_melee() {
  var_0 = 0;
  var_1 = 1;
  thread razergun_build_part(self.assembly_model_2, "razergun_1_placed", "players_have_razergun_1");
  thread razergun_build_part(self.assembly_model_1, "razergun_2_placed", "players_have_razergun_2");
  common_scripts\utility::_id_3CA0("razergun_1_placed", "razergun_2_placed");
  var_2 = [self.assembly_model_1, self.assembly_model_2];
  var_3 = _func_18E("ripsaw_bench", "targetname");
  playFX(level._effect["zmb_isl_sawrack_charge_pnt"], var_3.origin, anglesToForward(var_3.angles));
  _id_0378::_id_8D74("ripsaw_weapon_build_infusion", var_3.origin);
}

razergun_build_melee_reward() {
  if(!common_scripts\utility::_id_3C77("razergun_1_placed"))
    common_scripts\utility::flag_set("razergun_1_placed");

  if(!common_scripts\utility::_id_3C77("razergun_2_placed"))
    common_scripts\utility::flag_set("razergun_2_placed");

  if(!common_scripts\utility::_id_3C77("players_have_razergun_1"))
    common_scripts\utility::flag_set("players_have_razergun_1");

  if(!common_scripts\utility::_id_3C77("players_have_razergun_2"))
    common_scripts\utility::flag_set("players_have_razergun_2");

  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("razergunmelee");
    var_1 _id_0378::_id_8D74("objective_complete", "razergunmelee");
  }
}

razergun_build_ranged() {
  _id_0557::_id_7870("Aquire Wonder Weapon", "Melee Razor Gun Built");
  var_0 = 0;
  var_1 = 1;
  common_scripts\utility::_id_3C9F("razergun_3_placed");
  self.assembly_model_3 _meth_805B();
  self.assembly_model_3 _id_0378::_id_8D74("ripsaw_insert_charged_spine");

  if(!common_scripts\utility::_id_3C77("razergun_charged")) {
    thread razergun_bench_charge();
    common_scripts\utility::_id_3C9F("razergun_charged");
  }

  if(!common_scripts\utility::_id_3C77("razergun_infused")) {
    thread razergun_bench_infuse();
    common_scripts\utility::_id_3C9F("razergun_infused");
  }

  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("geistcraft_device_powered");
  var_2 = [self.assembly_model_1, self.assembly_model_2, self.assembly_model_3];
  var_3 = _func_18E("ripsaw_bench", "targetname");
  playFX(level._effect["zmb_isl_sawrack_charge_pnt"], var_3.origin, anglesToForward(var_3.angles));
  _id_0378::_id_8D74("ripsaw_weapon_build_infusion", var_3.origin);
}

razergun_build_ranged_reward() {
  if(!common_scripts\utility::_id_3C77("razergun_3_placed"))
    common_scripts\utility::flag_set("razergun_3_placed");

  if(!common_scripts\utility::_id_3C77("razergun_charged"))
    common_scripts\utility::flag_set("razergun_charged");

  if(!common_scripts\utility::_id_3C77("razergun_infused"))
    common_scripts\utility::flag_set("razergun_infused");

  if(!common_scripts\utility::_id_3C77("players_have_razergun_3"))
    common_scripts\utility::flag_set("players_have_razergun_3");

  if(!common_scripts\utility::_id_3C77("razergun_half_charged"))
    common_scripts\utility::flag_set("razergun_half_charged");

  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("razergunranged");
    var_1 _id_0378::_id_8D74("objective_complete", "razergunranged");
  }

  thread head_corpse_razer_gun_vo();
}

razergun_bench_init() {
  var_0 = common_scripts\utility::_id_46B7("weapon_assembly_bench", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "assembly_bench_trig":
          var_2.assembly_trig = var_5;
          break;
        case "assembly_bench_ranged_trig":
          if(!isDefined(var_2.assembly_ranged_trigs))
            var_2.assembly_ranged_trigs = [];

          var_2.assembly_ranged_trigs[var_2.assembly_ranged_trigs.size] = var_5;
          var_5 _meth_80B3();
          break;
        case "assembly_bench_weap_model_1":
          var_2.assembly_model_1 = var_5;
          var_2.assembly_model_1 _meth_805C();
          break;
        case "assembly_bench_weap_model_2":
          var_2.assembly_model_2 = var_5;
          var_2.assembly_model_2 _meth_805C();
          break;
        case "assembly_bench_weap_model_3":
          var_2.assembly_model_3 = var_5;
          var_2.assembly_model_3 _meth_805C();
          break;
        case "assembly_bench_weap_model_4":
          var_2.assembly_model_4 = var_5;
          var_2.assembly_model_4 _meth_805C();
          break;
        case "assembly_bench_weap_power_transfer":
          var_2.soul_collection_ent = var_5;
          break;
      }
    }

    var_7 = _func_21F(var_2.target, "targetname");

    foreach(var_9 in var_7) {
      var_10 = var_9 _meth_85CE();

      switch (var_10) {
        case "animated_zmi_workbench_gauge":
          var_2.soul_meter = var_9;
          var_2.soul_meter thread razergun_bench_display_voltage();
          break;
      }
    }
  }
}

razergun_bench_assign_trig(var_0) {
  thread razergun_bench_update_hint(var_0);
}

razergun_bench_update_hint(var_0) {
  var_0 endon("disconnect");
  var_1 = 1;
  var_2 = 0;
  wait 1;
  var_3 = _id_0552::_id_7BE1(var_0, self, 0);
  var_3._id_2F74 = 1;
  var_3._id_6642 = 1;
  var_4 = 0;

  for(;;) {
    waittillframeend;
    var_5 = var_0 wait_for_workbench_message();

    if(common_scripts\utility::_id_3C77("razergun_infused")) {
      var_3 update_workbench_prompt_for(var_0, "razergun_zm", "razergun_saw_gun_buy_state");
      continue;
    }

    if(common_scripts\utility::_id_3C77("razergun_charged")) {
      var_3._id_2F74 = 0;
      var_3._id_6642 = 1;
      var_3._id_4028 = _id_0552::_id_44FF("razergun_saw_gun_infuse_state");
      continue;
    }

    if(common_scripts\utility::_id_3C77("razergun_3_placed")) {
      var_4 = 0;
      var_3._id_2F74 = 1;
      var_3._id_6642 = 1;
      continue;
    }

    if(common_scripts\utility::_id_3C77("razergun_2_placed")) {
      var_6 = var_0 getcurrentweapon();

      if(issubstr(var_6, "spine_inspect") && !issubstr(var_6, "depleted")) {
        var_3._id_4028 = _id_0552::_id_44FF("razergun_saw_part_place");
        var_3._id_2F74 = 0;
        var_3._id_401E = 0;
        var_4 = 1;
        var_3._id_6642 = 1;
      }

      if(isDefined(var_5) && var_5 == "spine_destroyed" || var_4 && issubstr(var_6, "spine_inspect") && issubstr(var_6, "depleted"))
        var_4 = 0;

      if(!var_4)
        var_3 update_workbench_prompt_for(var_0, "razergun_melee_zm", "razergun_saw_buy_state");

      continue;
    }

    wait 0.1;
  }
}

update_workbench_prompt_for(var_0, var_1, var_2) {
  if(common_scripts\utility::_id_0F79(var_0 getweaponlistall(), var_1))
    self._id_2F74 = 1;
  else {
    self._id_2F74 = 0;
    self._id_4028 = _id_0552::_id_44FF(var_2);
    self._id_401E = var_0 get_razergun_cost_for_player(var_1);
  }

  self._id_6642 = 1;
}

get_razergun_cost_for_player(var_0) {
  var_1 = self;

  if(var_0 == "razergun_melee_zm")
    return 2500;

  var_2 = var_1 getweaponlistall();

  if(common_scripts\utility::_id_0F79(var_2, "razergun_melee_zm"))
    return 500;

  return 3000;
}

wait_for_workbench_message() {
  self endon("disconnect");

  if(!common_scripts\utility::_id_562E(self.inited_state)) {
    self.inited_state = 1;
    return "init";
  }

  var_0 = spawnStruct();
  childthread wait_for_player_message(var_0);
  level childthread wait_for_level_message(var_0);
  var_0 waittill("message", var_1);
  return var_1;
}

wait_for_player_message(var_0) {
  var_0 endon("message");
  var_1 = common_scripts\utility::_id_A716("spine_collected", "spine_destroyed", "weapon_change", "new_equipment");
  var_0 notify("message", var_1);
}

wait_for_level_message(var_0) {
  var_0 endon("message");
  level common_scripts\utility::_id_A70A("razergun_1_placed", "razergun_2_placed", "razergun_3_placed", "razergun_charged", "razergun_infused");
  var_0 notify("message", "objective_update");
}

wait_for_ranged_weapon_reveal() {
  level endon("razergun_infused");
  common_scripts\utility::_id_A70A("weapon_change", "new_equipment");
}

razergun_bench_infuse() {
  self.assembly_trig waittill("trigger", var_0);
  common_scripts\utility::flag_set("razergun_infused");
}

razergun_bench_charge() {
  self.soul_collection_ent maps\mp\mp_zombies_soul_collection::_id_170B(10, 400, 64, "razergun_soul_collection", undefined, "tag_origin", undefined, "tag_origin", undefined, self.soul_collection_ent, (0, 0, 64));
  common_scripts\utility::flag_set("razergun_half_charged");
  self.soul_collection_ent maps\mp\mp_zombies_soul_collection::_id_170B(15, 400, 64, "razergun_soul_collection", undefined, "tag_origin", undefined, "tag_origin", undefined, self.soul_collection_ent, (0, 0, 64));
  common_scripts\utility::flag_set("razergun_charged");
}

razergun_bench_display_voltage() {
  self _meth_83FA("main", "off");
  common_scripts\utility::_id_3C9F("razergun_half_charged");
  self _meth_83FA("main", "mid_on");
  wait 2.86667;
  self _meth_83FA("main", "mid_on_idle");
  common_scripts\utility::_id_3C9F("razergun_charged");
  self _meth_83FA("main", "full_on");
  wait 3.03333;
  self _meth_83FA("main", "full_on_idle");
  common_scripts\utility::_id_3C9F("razergun_infused");
  self _meth_83FA("main", "discharge");
  wait 0.533333;
  self _meth_83FA("main", "off");
}

razergun_bench_assemble_think(var_0) {
  level endon("game_ended");

  for(;;) {
    [var_2, var_3] = _id_0547::_id_A795();

    if(!isalive(var_2)) {
      continue;
    }
    if(!common_scripts\utility::_id_3C77("razergun_3_placed")) {
      if(!isDefined(var_2.spine_curret)) {
        if(!var_2 attempt_to_buy_razergun("razergun_melee_zm")) {
          continue;
        }
        var_2 _id_0586::_id_078C("razergun_melee_zm");
        var_2 _id_0586::_id_078E("razergun_melee_zm");
        var_2 thread show_razergun_instructions();
        var_2 thread nag_razergun_could_be_better();
      } else {
        var_2 maps\mp\zquests\casual\island_ee_util::spine_player_clear_data();
        common_scripts\utility::flag_set("players_have_razergun_3");
        common_scripts\utility::flag_set("razergun_3_placed");
        var_2 thread _id_0367::_id_8E3C("workbenchuber");
      }

      continue;
    }

    if(!var_2 attempt_to_buy_razergun("razergun_zm")) {
      continue;
    }
    var_2 notify("acquired ripsaw ranged");
    var_2.isupgradingrazergunmodel = 1;
    var_2 _id_0586::_id_078C("razergun_zm");
    var_2 _id_0586::_id_078E("razergun_zm");
    waitframe();
    var_2.isupgradingrazergunmodel = 0;
    var_2 thread show_razergun_instructions();
  }
}

attempt_to_buy_razergun(var_0) {
  return !common_scripts\utility::_id_0F79(self getweaponlistall(), var_0) && maps\mp\gametypes\zombies::_id_11C2(get_razergun_cost_for_player(var_0));
}

show_razergun_instructions() {
  var_0 = maps\mp\gametypes\_hud_util::createfontstring("default", 1);
  var_0 maps\mp\gametypes\_hud_util::setpoint("CENTER", undefined, 0, -30);
  var_0.label = &"ZOMBIE_ISLAND_RAZERGUN_HINT";
  wait 2.45;
  var_0 destroy();
}

nag_razergun_could_be_better() {
  self endon("death");
  self endon("disconnect");
  self endon("acquired ripsaw ranged");
  self notify("new ripsaw nag");
  self endon("new ripsaw nag");
  wait 4.1;
  thread _id_0367::_id_8E3C("build_ripsawbase");
  wait 9;
  thread _id_0367::_id_8E3C("harvestfog");

  for(;;) {
    wait(180 + randomint(300));
    thread _id_0367::_id_8E3C("harvestfog");
    wait(420 + randomint(180));
    thread _id_0367::_id_8E3C("build_ripsawbase");
  }
}

razergun_part_1_collected(var_0, var_1) {
  level thread common_scripts\_exploder::_id_2A6D(222, undefined, 0);
  common_scripts\utility::flag_set("players_have_razergun_2");
  _id_0378::_id_8D74("ripsaw_collect_gun_chassis", var_1);

  if(isDefined(var_0))
    var_0 thread play_razergun_part_vo(1);
}

razergun_part_2_collected(var_0, var_1) {
  level thread common_scripts\_exploder::_id_2A6D(221, undefined, 0);
  common_scripts\utility::flag_set("players_have_razergun_1");
  _id_0378::_id_8D74("ripsaw_collect_saw_blade", var_1);

  if(isDefined(var_0))
    var_0 thread play_razergun_part_vo();
}

play_razergun_part_vo(var_0) {
  self endon("disconnect");
  self endon("death");

  if(common_scripts\utility::_id_562E(var_0))
    _id_0367::_id_8E3C("ripsawpart");

  wait 1.75;

  if(common_scripts\utility::_id_3C77("players_have_razergun_1") && common_scripts\utility::_id_3C77("players_have_razergun_2"))
    thread _id_0367::_id_8E3C("ripsaw_both");
}

razergun_build_part(var_0, var_1, var_2) {
  common_scripts\utility::_id_3C9F(var_2);
  self.assembly_trig thread razergun_wait_for_interact(var_1);
  common_scripts\utility::_id_3C9F(var_1);
  var_0 _meth_805B();

  if(var_0 == self.assembly_model_1)
    var_0 _id_0378::_id_8D74("ripsaw_insert_chassis");
  else if(var_0 == self.assembly_model_2)
    var_0 _id_0378::_id_8D74("ripsaw_insert_sawblade");
}

razergun_wait_for_interact(var_0) {
  self waittill("trigger", var_1);
  common_scripts\utility::flag_set(var_0);
}

razergun_bench_all_parts_shown() {
  var_0 = 0;

  if(common_scripts\utility::_id_562E(self.assembly_model_1._id_08BE))
    var_0++;

  if(common_scripts\utility::_id_562E(self.assembly_model_2._id_08BE))
    var_0++;

  if(common_scripts\utility::_id_562E(self.assembly_model_3._id_08BE))
    var_0++;

  return var_0 == 3;
}

razergun_parts_collect() {
  razergun_blade_handle_pickup();
  razergun_stock_handle_pickup();
  common_scripts\utility::_id_3CA0("players_have_razergun_1", "players_have_razergun_2");
  _id_0557::_id_782D("explore_the_island", "Explore Pen");
}

add_zombie_part_glint(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_3F74 = var_0;
  var_3._id_378F = var_1;
  var_3._id_95AA = var_2;
  level thread maps\mp\_utility::_id_6F74(::handleplayerglintlookat, var_3);
  return var_3;
}

remove_zombie_part_glint(var_0) {
  var_0 notify("glint_removed");
}

handleplayerglintlookat(var_0) {
  self endon("death");
  self endon("disconnect");
  toggle_glint_visiblity(var_0);
  var_0._id_378F _meth_8511();
  _func_294(common_scripts\utility::_id_44F5(var_0._id_3F74), var_0._id_378F, var_0._id_95AA, self);
}

toggle_glint_visiblity(var_0) {
  self endon("death");
  self endon("disconnect");
  _func_14D(common_scripts\utility::_id_44F5(var_0._id_3F74), var_0._id_378F, var_0._id_95AA, self);
  var_0 waittill("glint_removed");
}

wait_for_player_facing(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    waitframe();
    var_3 = maps\mp\_utility::_id_3B8E(self, var_0, var_2);

    if(!var_1)
      var_3 = !var_3;

    if(var_3)
      return;
  }
}

razergun_blade_handle_pickup() {
  var_0 = getEntArray("grab_razergun_blade", "targetname");

  foreach(var_2 in var_0)
  var_2 thread razergun_part_give_on_pickup(::razergun_part_1_collected, undefined, "pickup_saw_blade");

  thread sawblade_corpse_vo();
}

sawblade_corpse_vo() {
  common_scripts\utility::_id_3C9F("start_to_right_climb");
  var_0 = _func_18E("grab_razergun_blade", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");

  while(!common_scripts\utility::_id_3C77("players_have_razergun_2")) {
    foreach(var_2 in level.players) {
      if(distance(var_2.origin, var_0.origin) > 250 || common_scripts\utility::_id_562E(var_2._id_806F)) {
        continue;
      }
      var_2 _id_0367::_id_8E3D("bloodtrailtwo_both");
      var_2._id_806F = 1;
    }

    wait 1;
  }
}

razergun_stock_handle_pickup() {
  var_0 = _func_18E("grab_razergun_stock", "targetname");
  var_1 = common_scripts\utility::_id_46B7("ripsaw_frame_position", "script_noteworthy");
  var_2 = common_scripts\utility::random(var_1);
  var_0.origin = var_2.origin;
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("zmi_ripsaw_parts_01");
  var_3.angles = var_2.angles;
  waitframe();
  var_0 thread razergun_part_give_on_pickup(::razergun_part_2_collected, var_3, "pickup_saw_stock");
}

razergun_part_give_on_pickup(var_0, var_1, var_2) {
  while(!isDefined(level._id_47DD))
    waitframe();

  _id_0559::_id_7BE3(self, var_2);

  if(!isDefined(var_1) && isDefined(self.target))
    var_1 = _func_18E(self.target, "targetname");

  var_3 = add_zombie_part_glint("zmb_isl_rzgun_pickup_glint2", var_1, "tag_origin");
  self _meth_80CE(&"ZOMBIE_ISLAND_PART_PICKUP");
  self _meth_8660(1, var_1.origin);
  self waittill("trigger", var_4);
  [[var_0]](var_4, var_1.origin);
  remove_zombie_part_glint(var_3);
  common_scripts\utility::_id_9D9F();
}

______________radio_____________() {}

quest_init_radio() {
  hide_radio();
  thread radio_part_corpse_listener();
}

quest_step_radio_find() {
  var_0 = undefined;
  var_1 = [];

  foreach(var_3 in level.cuttable_ropes)
  var_1[var_1.size] = var_3.my_box;

  var_5 = _func_18E("radio_corpse_trig", "targetname");

  if(isDefined(var_5) && isDefined(var_5.target))
    var_1[var_1.size] = _func_18E(var_5.target, "targetname");

  if(var_1.size > 0) {
    var_6 = _id_0557::_id_782F(undefined, var_1);
    _id_0557::_id_781D("Interact with radio", var_6);
  }

  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("airstrike_both");
  common_scripts\utility::_id_3CA0("flag_radio_part_1_collected", "flag_radio_part_2_collected");
  _id_0557::_id_782D("Interact with radio", "Find Missing Part");
}

quest_step_crashed_plane_find() {
  var_0 = undefined;
  var_1 = [];

  foreach(var_3 in level.cuttable_ropes)
  var_1[var_1.size] = var_3.my_box;

  var_5 = _func_18E("radio_corpse_trig", "targetname");

  if(isDefined(var_5) && isDefined(var_5.target))
    var_1[var_1.size] = _func_18E(var_5.target, "targetname");

  common_scripts\utility::_id_3C9F("flag_radio_part_2_collected");
  maps\mp\mp_zombie_island_ee_fog_manager::unlock_fog_from_lock();
}

quest_step_radio_place() {
  var_0 = _func_18E("radio_placement_trigger", "targetname");
  var_0 _meth_80CE(&"ZOMBIE_ISLAND_RADIO_ASSEMBLE");
  var_1 = getEntArray("radio_table_equipment", "script_noteworthy");
  var_2 = _id_0557::_id_782F(undefined, var_1);
  _id_0557::_id_781D("Interact with radio", var_2);
  var_3 = common_scripts\utility::random(level.players);

  if(isDefined(var_3))
    var_3 thread _id_0367::_id_8E3C("radiopartsall");

  var_0 waittill("trigger", var_4);
  var_0 _id_0378::_id_8D74("radio_parts_assemble");
  var_0 _meth_80CE(&"ZOMBIES_EMPTY_STRING");
  show_radio();
  level thread radio_dialogue_tower(var_4);
  _id_0557::_id_782D("Interact with radio", "Place Radio");
}

set_radio_part_2_found() {
  common_scripts\utility::flag_set("flag_radio_part_2_collected");
}

radio_part_corpse_listener() {
  var_0 = _func_18E("radio_corpse_trig", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _func_18E(var_0.target, "targetname");
  var_0 _meth_80CE(&"ZOMBIE_ISLAND_RADIO_PART_PICKUP");
  var_0 thread radio_corpse_vo();
  var_0 waittill("trigger", var_2);
  var_2 thread _id_0367::_id_8E3C("radioparts", level.players);
  var_1 delete();
  var_0 delete();
  common_scripts\utility::flag_set("flag_radio_part_1_collected");
}

radio_corpse_vo() {
  var_0 = self;

  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  common_scripts\utility::_id_3C9F("start_to_right_climb");

  for(;;) {
    foreach(var_2 in level.players) {
      if(distance(var_2.origin, var_0.origin) > 250 || common_scripts\utility::_id_562E(var_2.saw_radio)) {
        continue;
      }
      var_2 _id_0367::_id_8E3D("deadreangerfind");
      var_2.saw_radio = 1;
    }

    wait 1;
  }
}

blood_trail_vo() {
  common_scripts\utility::_id_3C9F("start_to_right_climb");
  var_0 = common_scripts\utility::_id_46B5("vo_blood_trail_point", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  while(!common_scripts\utility::_id_3C77("players_have_razergun_2")) {
    foreach(var_2 in level.players) {
      if(distance(var_2.origin, var_0.origin) > 1000 || !var_2 zombies_look_at(var_0) || common_scripts\utility::_id_562E(var_2.saw_blood_trail)) {
        continue;
      }
      var_2 _id_0367::_id_8E3D("bloodtrailfollow_both");
      var_2.saw_blood_trail = 1;
    }

    wait 2;
  }
}

plane_wreckage_radio_vo() {
  common_scripts\utility::_id_3C9F("flag_players_have_won");
  var_0 = _func_18E("rope_box", "script_noteworthy");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");

  while(!common_scripts\utility::_id_3C77("flag_radio_part_2_collected")) {
    foreach(var_2 in level.players) {
      if(!var_2 zombies_look_at(var_0) || common_scripts\utility::_id_562E(var_2.saw_wreckage_radio)) {
        continue;
      }
      var_2 _id_0367::_id_8E3D("planeclue");
      var_3 = var_2 _meth_82D5();

      if(issubstr(var_3, "razergun_zm") == 0)
        var_2 _id_0367::_id_8E3D("planecrashlook");

      var_2.saw_wreckage_radio = 1;
    }

    wait 2;
  }
}

zombies_look_at(var_0) {
  var_1 = var_0.origin;
  var_2 = self getEye();
  var_3 = vectorNormalize(var_1 - var_2);
  var_4 = vectorNormalize(anglesToForward(self _meth_8566()));
  var_5 = vectordot(var_3, var_4);
  waitframe();
  var_6 = _func_0AA(clamp(var_5, -1, 1));

  if(var_6 < 25 && distance(var_1, var_2) < 420)
    return 1;
  else
    return 0;
}

hide_radio() {
  var_0 = _func_18E("radio_placement_trigger", "targetname");
  var_1 = _func_18E(var_0.target, "targetname");
  var_1 _meth_805C();
}

show_radio() {
  var_0 = _func_18E("radio_placement_trigger", "targetname");
  var_1 = _func_18E(var_0.target, "targetname");
  var_1 _meth_805B();
}

radio_dialogue_tower(var_0) {
  var_0 _id_0367::_id_8E3C("radiotransmission", level.players);
  var_1 = common_scripts\utility::_id_46B5("struct_radio_dialogue", "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  var_2.radio_talk_snd = _id_0380::_id_288B("zmb_isla_comd_altyourmessagehasbeenrece", undefined, var_2);
  _id_0380::_id_288F(var_2.radio_talk_snd, var_2, "radio_line_done");
  var_2 waittill("radio_line_done");
  wait 0.85;
  maps\mp\mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_10secondsofangrygermanswe", 0);
  maps\mp\mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_soyousurvivedthehellofmit", 0);
  maps\mp\mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_youandyouralliedcomradesa", 0);
  common_scripts\utility::flag_set("spawn_ships_ee_destroyer_attacker");
  maps\mp\mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_welljustlikeinbavariayoua", 0);
  maps\mp\mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_thebrittishplanesaredoome");
  common_scripts\utility::flag_set("spawn_ships_straub_monologue_complete");
  var_2 delete();
}

______________destroyers_____________() {}

quest_init_destroyers() {
  _id_0547::_id_7BA9(::artillery_zombie_listener);
  level thread spawn_ships();
  level thread ambient_straub_pa_dialog();
  level thread spawn_bomber_escort_setup();
}

artillery_zombie_listener(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(_id_0547::_id_5565(level.escort_bomber, self)) {
    level.escort_bomber = undefined;

    if(common_scripts\utility::_id_3C77("flag_hc_bomb_escort_complete"))
      _id_0547::_id_2D8C(::artillery_zombie_listener);
  }
}

quest_step_escort_loader() {
  while(!isDefined(level.artillery_power_source_model))
    waitframe();

  _id_0557::_id_782D("Destroy 2nd Destroyer", "Find Artillery Ammo");
}

quest_step_get_destroyer1_hits() {
  for(var_0 = 0; var_0 < 3; var_0++) {
    level waittill("destoyer_2_hit");
    waitframe();

    if(level.artillery_ee_ships.size < 1) {
      break;
    }
  }

  _id_0557::_id_782D("Destroy 2nd Destroyer", "1st Ship Destroyed");
  common_scripts\utility::flag_set("flag_destroyers_quest_complete");
}

quest_step_charge_artillery_ammo() {
  common_scripts\utility::_id_3C9F("flag_destroyers_quest_complete");
  _id_0557::_id_782D("Artillery Ammo", "Charge Artillery Ammo");
}

destoyer_add_hit() {
  level notify("destoyer_2_hit");
}

summon_artillery_loader_control_think() {
  var_0 = self;
  var_0 _meth_80CE(&"ZOMBIE_ISLAND_SUMMON_ARTILLERY_LOADER");
  var_1 = _func_21F("zombie_loader_control", "targetname");

  for(;;) {
    common_scripts\utility::_id_3C9F("flag_crane_in_motion");
    var_0 _meth_80CE(&"ZOMBIE_ISLAND_SUMMON_ARTILLERY_LOADER_UNAVAILABLE");
    self._id_82EF thread activate_machine();

    while(common_scripts\utility::_id_3C77("flag_crane_in_motion")) {
      self._id_82EF _meth_83FA("light", "off");
      wait 0.5;
      self._id_82EF _meth_83FA("light", "green");
      wait 0.5;
    }

    if(isDefined(level.escort_bomber) && common_scripts\utility::_id_562E(level.zmb_island_escorts_wave_penalty)) {
      self._id_82EF _meth_83FA("light", "red");
      maps\mp\zquests\casual\island_ee_util::wait_one_round_bomber();

      while(level.freezer_crane._id_931A == "request_retrieve")
        waitframe();

      common_scripts\utility::flag_waitopen("flag_crane_in_motion");
    }

    if(common_scripts\utility::_id_3C77("flag_loader_zombie_unavailable"))
      common_scripts\utility::flag_waitopen("flag_loader_zombie_unavailable");

    var_2 = self._id_82EF _meth_866B("light");
    var_0 _meth_80CE(&"ZOMBIE_ISLAND_SUMMON_ARTILLERY_LOADER");

    if(var_2 != "green")
      self._id_82EF _meth_83FA("light", "green");
  }
}

activate_machine() {
  self _meth_83FA("machine_main", "activate");
  wait 3.86667;
  self _meth_83FA("machine_main", "idle");
}

ambient_straub_pa_dialog() {
  level endon("flag_destroyers_quest_complete");
  common_scripts\utility::_id_3C9F("spawn_ships_straub_monologue_complete");
  thread maps\mp\mp_zombie_island_straub_pa_events::ambient_straub_pa_dialog_cleanup();
  wait 100;
  maps\mp\mp_zombie_island_straub_pa_events::play_straub_story_5();
  wait 20;
  maps\mp\mp_zombie_island_straub_pa_events::play_straub_story_6();
  wait 20;
  maps\mp\mp_zombie_island_straub_pa_events::play_straub_story_7();
}

spawn_bomber_escort_setup() {
  var_0 = collect_bomber_waypoints_1();
  var_1 = collect_bomber_waypoints_oberland();
  var_2 = 1;
  var_3 = _func_18E("trig_control_interact_call_bomber", "script_noteworthy");

  if(isDefined(var_3.target)) {
    var_3.face_targ = common_scripts\utility::_id_46B5(var_3.target, "targetname");

    if(isDefined(var_3.face_targ))
      var_3 _meth_8660(1, var_3.face_targ.origin);

    var_4 = _func_21F(var_3.target, "targetname");

    if(isDefined(var_4) && var_4.size > 0) {
      var_3._id_82EF = var_4[0];
      var_3._id_82EF _meth_83FA("light", "green");
    }

    var_3 common_scripts\utility::_id_3799("freezer_machine_working");
    var_3 thread summon_artillery_loader_control_think();
  }

  while(!isDefined(level._id_A980) || level._id_A980 < 1)
    wait 0.125;

  var_5 = 0;

  while(!common_scripts\utility::_id_3C77("flag_loader_complete")) {
    var_3 common_scripts\utility::_id_9DA3();
    var_3 waittill("trigger", var_6);
    var_3 common_scripts\utility::_id_9D9F();

    if(!_id_0547::is_power_on(var_6)) {
      continue;
    }
    if(common_scripts\utility::_id_3C77("flag_crane_in_motion") || level.freezer_crane._id_931A == "request_retrieve" || common_scripts\utility::_id_3C77("flag_loader_zombie_unavailable") || common_scripts\utility::_id_3C77("flag_bomber_wave_punished")) {
      continue;
    }
    var_7 = level._id_A980;
    level notify("freezeer_summon_zombie", "escort_bomber");

    if(var_5 == 0) {
      _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("freezer");
      maps\mp\_utility::_id_2CED(5, _id_0367::snd_zmb_plr_dlg_play_line_on_each_player, "subpencrates2");
      var_5 = 1;
    }

    if(common_scripts\utility::_id_3C77("flag_hc_bomb_escort_complete")) {
      level waittill("freezer_zombie_placed", var_8);
      waittill_ent_death_timeout(var_8, "death", 120);
      continue;
    }

    common_scripts\utility::flag_set("flag_loader_zombie_unavailable");
    var_3 common_scripts\utility::_id_379A("freezer_machine_working");
    level waittill("freezer_zombie_placed", var_8);
    maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();
    var_8 thread set_zone_locked_on_me();
    level.maxed_zombies_sprint = 1;
    var_8 thread make_noise();
    var_3 common_scripts\utility::_id_3796("freezer_machine_working");

    if(common_scripts\utility::_id_562E(var_2))
      var_6 maps\mp\_utility::_id_2CED(1.25, _id_0367::_id_8E3D, "shipbomber");

    var_2 = 0;
    setup_escort_bomber_post_drop(var_8);
    var_9 = level.escort_bomber escort_begin(var_0, var_1);
    maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
    level unset_zone_locked_on_zombie();
    level.maxed_zombies_sprint = 0;

    if(isDefined(var_9) && var_9 == 1) {
      level.escort_bomber on_reached_dest();
      var_3 _meth_80CE("");
      common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
      common_scripts\utility::flag_set("flag_loader_complete");
      continue;
    }

    if(isDefined(level.escort_bomber)) {
      level.escort_bomber suicide();
      level.escort_bomber = undefined;
    }

    common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
    continue;
  }
}

make_noise() {
  self endon("death");

  for(;;) {
    maps\mp\mp_zombie_island_fog_behavior::alarm_fog_zombies(650, self.origin);
    wait 1;
  }
}

planes_enroute_vo() {
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  wait 5;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("nagplanes");
  common_scripts\utility::flag_set("flag_straub_finishes_plane_talk");
}

corpse_gate_open_vo() {
  maps\mp\mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_didyounoticetheairstripon", 0);
  maps\mp\mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_theplanesihaveorderedthem", 0);
  maps\mp\mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_thatisoneoftheadvantagest");
}

do_artillery_bomber_hitreaction(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isPlayer(var_6)) {
    return;
  }
  thread maps\mp\agents\humanoid\_humanoid::_id_32B0(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

set_zone_locked_on_me() {
  self.lockzoneonme = 1;
  wait_for_termination();
  self.lockzoneonme = undefined;
  level.zmb_locked_spawn_zones = undefined;
}

wait_for_termination() {
  self endon("death");
  level endon("cancel_zone_lock");

  while(self.lockzoneonme) {
    level.zmb_locked_spawn_zones = [get_escort_pressure_zone(_id_055A::_id_4562(self.origin))];
    wait 0.125;
  }
}

get_escort_pressure_zone(var_0) {
  var_1 = ["sub_pens_1_zone", "corner_bluffs_zone", "vista_zone_3", "vista_middle_zone", "high_canon"];
  var_2 = var_0;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(_id_0547::_id_5565(var_0, var_1[var_3]))
      return common_scripts\utility::_id_98E7(var_3 == var_1.size - 1, var_1[var_1.size - 1], var_1[var_3 + 1]);
  }

  return var_2;
}

unset_zone_locked_on_zombie() {
  level notify("cancel_zone_lock");
  waitframe();
  level.zmb_locked_spawn_zones = undefined;
}

setup_escort_bomber() {
  level.escort_bomber = self;
  level.escort_bomber.escort_zombie = 1;
  level.escort_bomber.isobjectiveexemptfromfog = 1;
  level.escort_bomber._id_6816 = 1;
  level.escort_bomber._id_0C29 = 0;
  level.escort_bomber._id_297D = maps\mp\zquests\casual\island_ee_util::escort_custom_movemode;
  level.escort_bomber.shouldnotpreventlaststand = 1;
  level.escort_bomber.ispassiveexempt = 1;
  level.escort_bomber._id_55AB = 1;
  level.escort_bomber.shouldnotpreventlaststand = 1;
  level.escort_bomber maps\mp\agents\_agent_utility::_id_83FE(level._id_746E);
  level.escort_bomber._id_00CE = 1;
  level.escort_bomber _id_0547::_id_8A6D(1);
  level.escort_bomber._id_6734 = 1;
  waitframe();
  level.escort_bomber exploder_swap_bomb_for_uber();
  var_0 = int(get_difficulty_setting("zmb_escort_bomber_health"));
  self._id_3937._id_3F22 = 1;
  level.escort_bomber maps\mp\agents\_agent_common::_id_83FD(int(var_0));
  level.escort_bomber thread setup_escort_bomber_failsafe();
  level.escort_bomber thread the_classic_ee();
}

the_classic_ee() {
  self endon("death");
  common_scripts\utility::_id_092C("moneyCloud", "vfx/gameplay/mp/zombie/gj_pickup_zombies_01_money");

  while(!isDefined(level._id_8AD2))
    waitframe();

  while(isalive(self)) {
    level waittill("spawned_money_share");

    foreach(var_1 in level._id_8AD2) {
      if(level.the_classic_donation < 1000)
        childthread tip_bomber_watch(var_1, self);
    }
  }
}

tip_bomber_watch(var_0, var_1) {
  level endon("spawned_money_share");

  while(isalive(var_1)) {
    level endon("the_classic_full_donation");

    if(distance(var_1.origin, var_0.origin) < 50 && !isDefined(var_0.donated_to_bomber)) {
      var_2 = var_0._id_0117;

      if(!isPlayer(var_2) || !isDefined(var_0._id_8AD3) || var_0._id_8AD3.size == 0) {
        waitframe();
        continue;
      }

      var_3 = var_2 getentitynumber();
      var_4 = var_0._id_62D3;
      var_0.donated_to_bomber = 1;
      var_0 _id_0544::_id_8ADD(var_3, 0);
      thread _id_62D8(self.origin);
      var_0._id_6FD4 = 0;
      var_0._id_6FCB = 0;
      level.the_classic_donation = level.the_classic_donation + int(var_4);

      if(level.the_classic_donation >= 1000) {
        _id_0548::_id_09C8("ppsh41_classic_zm", "extended_mag", "none", "none");
        waitframe();
        level notify("the_classic_full_donation");
        return;
      }

      waitframe();
      continue;
    }

    wait 0.35;
  }
}

_id_62D8(var_0) {
  var_1 = _func_14B(common_scripts\utility::_id_44F5("moneyCloud"), var_0);
  _func_14C(var_1);
  wait 3;
  var_1 delete();
}

setup_escort_bomber_post_drop(var_0) {
  var_0._id_0009 = &"ZOMBIE_ISLAND_LOADER_ZOMBIE_NAME";
  var_0._id_00CE = 0;
  var_0 _id_0547::_id_8A6D(0);
  thread maps\mp\zquests\casual\island_ee_util::escort_health_display_start(var_0, -40);
  var_0 thread maps\mp\zquests\casual\island_ee_util::escort_health_display_death_listener();
  var_0 thread maps\mp\zquests\casual\island_ee_util::escort_health_display_damage_listener();
  var_0 thread maps\mp\zquests\casual\island_ee_util::escort_health_display_heal_listener();
  var_0 thread escort_plane_death_think();
}

exploder_swap_bomb_for_uber() {
  self detach(self._id_3391, self._id_A99D);
  self._id_3391 = "tag_origin";
  self attach(self._id_3391, self._id_A99D);
}

setup_escort_bomber_failsafe() {
  self endon("death");
  wait 600;

  if(isDefined(self))
    self suicide();
}

escort_plane_death_think() {
  var_0 = self;
  var_0 endon("death");
  var_1 = _func_18E("vol_escort_bomber_death_setup", "targetname");
  var_2 = _func_18E("vol_escort_bomber_death_now", "targetname");
  var_3 = common_scripts\utility::_id_46B5("struct_escort_killer", "targetname");

  while(!common_scripts\utility::_id_3C77("flag_players_have_won")) {
    if(!isDefined(var_1)) {
      break;
    }

    if(var_0 istouching(var_1)) {
      level.wave_a = _func_1DC("plane_start_node_escort_killer", "targetname");
      var_4 = level.wave_a plane_ee_do_spawn_plane_wave();
      var_0 maps\mp\zquests\casual\island_ee_util::waittill_touching(var_2, 1);
      var_5 = spawn("script_model", var_3.origin);
      var_5 setModel("tag_origin");
      var_5 common_scripts\utility::_id_3799("turret_on");
      var_5 common_scripts\utility::_id_379A("turret_on");
      var_5 _id_0378::_id_8D74("aud_plane_firing");

      for(var_6 = 0; var_6 < 12; var_6++) {
        var_5.angles = vectortoangles(var_0.origin - var_5.origin);
        _func_147(level._effect["zmb_isl_enemy_plane_tracer"], var_5, "TAG_ORIGIN");
        _func_147(level._effect["zmb_isl_enemy_plane_tracer"], var_5, "TAG_ORIGIN");
        wait 0.2;
      }

      var_5 common_scripts\utility::_id_3796("turret_on");
      waitframe();
      var_5 delete();
      var_0 suicide();
    }

    wait 1;
  }
}

collect_bomber_waypoints_1() {
  var_0 = common_scripts\utility::_id_46B5("artillery_bomber_waypoint_set1_1", "script_noteworthy");
  var_1 = var_0 maps\mp\zquests\casual\island_ee_util::make_array_from_struct_chain();
  return var_1;
}

collect_bomber_waypoints_oberland() {
  var_0 = common_scripts\utility::_id_46B5("artillery_bomber_goal", "script_noteworthy");
  var_1 = common_scripts\utility::_id_46B5("artillery_bomber_waypoint_1a", "script_noteworthy");
  var_2 = common_scripts\utility::_id_46B5("artillery_bomber_waypoint_1b", "script_noteworthy");
  var_3 = common_scripts\utility::_id_46B5("artillery_bomber_waypoint_2a", "script_noteworthy");
  var_4 = common_scripts\utility::_id_46B5("artillery_bomber_waypoint_2b", "script_noteworthy");
  var_5 = common_scripts\utility::_id_46B5("artillery_bomber_waypoint_2c", "script_noteworthy");
  var_6 = common_scripts\utility::_id_46B5("artillery_bomber_waypoint_3", "script_noteworthy");
  var_7 = common_scripts\utility::_id_46B5("artillery_bomber_waypoint_4a", "script_noteworthy");
  var_8 = common_scripts\utility::_id_46B5("artillery_bomber_waypoint_4b", "script_noteworthy");
  var_9 = [var_0, var_8, var_7, var_6, var_5, var_4, var_3, var_2, var_1];
  return var_9;
}

on_reached_dest() {
  self endon("death");
  var_0 = common_scripts\utility::_id_46B7("artillery_struct", "targetname");

  foreach(var_2 in var_0)
  var_2 maps\mp\zquests\casual\island_ee_util::add_ammo(1);

  common_scripts\utility::flag_set("flag_hc_bomb_escort_complete");
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  _id_0378::_id_8D74("artillery_battery_placed");

  foreach(var_2 in var_0)
  var_2 thread artillery_ammo_soul_collection();

  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_nest_01_tower_battle", int(100 * (self.health / self.maxhealth)));
  self suicide();
}

escort_begin(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  self._id_3937 endon("detonate");
  var_2 maps\mp\zquests\casual\island_ee_util::escort_waypoints_linear(var_0);
  var_3 = var_2 maps\mp\zquests\casual\island_ee_util::escort_waypoints_dynamic(var_1);
  return var_3;
}

spawn_ships() {
  common_scripts\utility::_id_3C9F("spawn_ships_ee_destroyer_attacker");
  level.artillery_ee_ships = ships_setup();
  thread ships_nag();
  var_0 = common_scripts\utility::_id_46B7("org_boat_spawner_set1", "targetname");
  var_1 = common_scripts\utility::_id_46B7("org_boat_spawner_set2", "targetname");
  var_2 = common_scripts\utility::_id_46B7("org_boat_spawner_set3", "targetname");
  spawn_ship_and_move(common_scripts\utility::random(var_0), level.artillery_ee_ships[0], _func_0A5(35, 45));

  if(level.players.size > 2)
    thread spawn_ship_and_move(common_scripts\utility::random(var_1), level.artillery_ee_ships[1], _func_0A5(35, 45));
  else
    level.artillery_ee_ships = common_scripts\utility::_id_0F9A(level.artillery_ee_ships, 1);

  foreach(var_4 in level.players)
  var_4 maps\mp\_utility::_id_2CED(3, _id_0367::_id_8E3D, "shipnew");

  spawn_ship_and_move(common_scripts\utility::random(var_2), level.artillery_ee_ships[0], _func_0A5(35, 45));
}

ships_setup() {
  var_0 = getEntArray("obj_artillery_boats", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");
    var_2.cannons = [];
    var_2._id_241F = [];
    var_2.hit_points = [];

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "org_hit_point":
          var_2.hit_points[var_2.hit_points.size] = var_5;
          var_5 linktosynchronizedparent(var_2);
          break;
        case "obj_artillery_boat":
          var_2.boat_model = var_5;
          var_2.boat_model linktosynchronizedparent(var_2);
          break;
        case "clip_boat":
          var_2._id_241F[var_2._id_241F.size] = var_5;
          var_5 linktosynchronizedparent(var_2);
          break;
        case "org_cannon_1":
          var_2.cannons[0] = var_5;
          var_5 linktosynchronizedparent(var_2);
          break;
        case "org_cannon_2":
          var_2.cannons[1] = var_5;
          var_5 linktosynchronizedparent(var_2);
          break;
        case "org_cannon_3":
          var_2.cannons[2] = var_5;
          var_5 linktosynchronizedparent(var_2);
          break;
      }
    }
  }

  return var_0;
}

spawn_ship_and_move(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = common_scripts\utility::_id_46B5(var_0.target, "targetname");
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.in_motion = 1;
  var_1 _meth_82B1(var_4.origin, var_2, 0, var_3);

  if(!common_scripts\utility::_id_3C77("flag_first_ship_spawned")) {
    common_scripts\utility::flag_set("flag_first_ship_spawned");
    var_5 = common_scripts\utility::random(var_1.cannons);
    var_1 ship_fire_at_radio_tower(var_5);

    foreach(var_7 in level.players)
    var_7 maps\mp\_utility::_id_2CED(0.75, _id_0367::_id_8E3D, "shipwarn");
  }

  var_1 thread ship_fire_at_player_wait(var_2);
  var_1 ship_clean_up();
}

ship_fire_at_radio_tower(var_0) {
  var_1 = common_scripts\utility::_id_46B5("struct_tower_boom_spot", "targetname").origin;

  if(isDefined(level.current_fog_flag) && maps\mp\mp_zombie_island_ee_fog_manager::get_is_fog_active())
    playFX(common_scripts\utility::_id_44F5("zmb_battleship_cannon_muzzle_rnr"), var_0.origin);
  else
    playFX(common_scripts\utility::_id_44F5("zmb_battleship_cannon_muz_fog_rnr"), var_0.origin);

  var_0 _id_0378::_id_8D74("radio_tower_artillery_shot");
  var_2 = _func_1B6("zmi_airstrike_bomb", var_0.origin, var_1, 3, var_1[2] + 2000);
  var_2 _id_0378::_id_8D74("radio_tower_incoming_mortar");
  var_2 waittill("explode", var_3);
  var_2 _id_0378::_id_8D74("radio_tower_mortar_impact");
  wait 0.01;
  playFX(common_scripts\utility::_id_44F5("zmb_radio_tower_explosion_rnr"), var_1, (-1, 0, 0));
  _id_0378::_id_8D74("radio_tower_explosion", var_1);
  wait 0.7;
  var_4 = _func_18E("sm_radio_tower", "targetname");
  var_4 _meth_8276("s2_zom_damaged_radio_tower", "tower_destroyed");
  _func_1BB("artillery_rumble", var_3);
}

ship_fire_at_player_wait(var_0) {
  self endon("hit_by_cannon");
  wait(var_0);
  self notify("at_end");
  self.in_motion = undefined;
  thread ship_fire_at_player();
}

ship_clean_up() {
  self waittill("hit_by_cannon");
  level.artillery_ee_ships = common_scripts\utility::_id_0F93(level.artillery_ee_ships, self);
  level.artillery_ee_ships = common_scripts\utility::_id_0FA0(level.artillery_ee_ships);
  thread sink_ship();
}

sink_ship() {
  self _meth_82B1(self.origin - (0, 0, 400), 6);
  var_0 = common_scripts\utility::_id_8FFC();
  var_0.origin = common_scripts\utility::random(self.cannons).origin;
  _func_147(level._effect["zmb_isl_ship_explosion_set"], var_0, "tag_origin");
  var_0 delete();
  wait 6;
  level notify("ship_sank");
  _id_0F7B(self.hit_points);
  _id_0F7B(self._id_241F);
  _id_0F7B(self.cannons);
  self.boat_model delete();
  self delete();
}

_id_0F7B(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] delete();
}

ship_fire_at_player() {
  self endon("hit_by_cannon");

  if(level.players.size == 1) {
    var_0 = 9;
    var_1 = 18;
  } else {
    var_0 = 6;
    var_1 = 12;
  }

  var_2 = [var_0, var_1];

  while(isDefined(self) &isDefined(level.players)) {
    var_3 = common_scripts\utility::random(level.players);
    var_3 thread fire_shell_at_player(common_scripts\utility::random(self.cannons));
    wait(_func_0A5(var_2[0], var_2[1]));
  }
}

play_watchout_dialogue(var_0) {
  var_1 = 800;

  foreach(var_3 in level.players) {
    if(isDefined(var_3.heard_watchout) && (gettime() - var_3.heard_watchout) / 1000 < 20) {
      continue;
    }
    if(distance(var_3.origin, var_0) > var_1) {
      continue;
    }
    var_3 thread _id_0367::_id_8E3C("watchout");
    var_3.heard_watchout = gettime();
  }
}

fire_shell_at_player(var_0) {
  var_1 = 350;
  var_2 = 800;
  var_3 = 0;

  if(randomint(100) > 35)
    var_3 = 1;

  if(common_scripts\utility::_id_562E(var_3)) {
    var_1 = 150;
    var_2 = 300;
  }

  var_4 = maps\mp\zquests\casual\island_ee_util::random_2d_vector_safe_zone(self, var_1, var_2);

  if(isDefined(level.current_fog_flag) && maps\mp\mp_zombie_island_ee_fog_manager::get_is_fog_active())
    playFX(common_scripts\utility::_id_44F5("zmb_battleship_cannon_muzzle_rnr"), var_0.origin);
  else
    playFX(common_scripts\utility::_id_44F5("zmb_battleship_cannon_muz_fog_rnr"), var_0.origin);

  var_0 _id_0378::_id_8D74("dist_artillery_shot");
  var_5 = _func_1B6("zmi_airstrike_bomb", var_0.origin, var_4, 3, level.player.origin[2] + 2000);
  var_5 _id_0378::_id_8D74("dist_ship_artillery_inc");
  var_5 waittill("explode", var_6);
  var_5 _id_0378::_id_8D74("dist_ship_artillery_impact");
  _func_1BB("artillery_rumble", var_6);
  radiusdamage(var_6, 750, 50, 15, undefined, "MOD_PROJECTILE", "zmi_airstrike_bomb", 1);
  thread play_watchout_dialogue(var_6);
}

destroyer_complete_xp_reward() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("destroyers");
    var_1 _id_0378::_id_8D74("objective_complete", "destroyers");
  }
}

ships_nag() {
  var_0 = 0;
  var_1 = ["shipnag", "shipnagtwo"];
  var_2 = _func_18E("vol_artillery_nag_deadzone", "targetname");
  level endon(_id_0557::_id_7838("Destroy 2nd Destroyer", "1st Ship Destroyed"));

  while(common_scripts\utility::_id_3C77(_id_0557::_id_7838("Destroy 2nd Destroyer", "1st Ship Destroyed"))) {
    wait(_func_0A4(128, 256));

    if(var_0 < 2)
      var_3 = var_1[var_0];
    else
      var_3 = common_scripts\utility::random(var_1);

    foreach(var_5 in level.players) {
      if(var_5 istouching(var_2)) {
        continue;
      }
      var_5 thread _id_0367::_id_8E3C(var_3);
    }

    var_0++;
  }
}

waittill_ent_death_timeout(var_0, var_1, var_2) {
  var_0 endon("wait_timeout");

  if(isDefined(var_0))
    var_0 thread waittill_ent_death_timeout_end(var_1);

  wait(var_2);
}

waittill_ent_death_timeout_end(var_0) {
  self waittill(var_0);
  self notify("wait_timeout");
}

artillery_ammo_soul_collection() {
  var_0 = common_scripts\utility::_id_46B5("zmb_island_artillery_soul_collection", "targetname");
  self.soul_collection_ent = spawn("script_model", var_0.origin);
  self.soul_collection_ent setModel("tag_origin");

  for(;;) {
    if(self.controller.ammo_count >= 7) {
      waitframe();
      continue;
    }

    self.soul_collection_ent maps\mp\mp_zombies_soul_collection::_id_170B(4, 400, 128, "artillery_ammo_soul_collection", undefined, "tag_origin", undefined, "tag_origin", undefined, self.soul_collection_ent, (0, 0, 64));
    maps\mp\zquests\casual\island_ee_util::add_ammo(1);
  }
}

______________final_boss_____________() {}

quest_init_final_boss() {
  common_scripts\utility::flag_init("final boss wrapped up");
  maps\mp\zquests\casual\island_ee_final_boss::init();
}

get_respawn_flag(var_0) {
  return "can_spawn_" + var_0;
}

watch_assassin_bounty(var_0) {
  foreach(var_2 in var_0) {
    var_3 = get_bounty_flag(var_2);
    common_scripts\utility::_id_3C9F(var_3);
  }

  common_scripts\utility::flag_set("bring_in_next_type");
}

get_bounty_flag(var_0) {
  return var_0 + "_was_player_killed";
}

watch_for_despawn() {
  self waittill("death");
  playFX(level._effect["zmi_assassin_critical_hit"], self.origin);
  common_scripts\utility::flag_set("can_spawn_");
}

quest_final_boss_island_outro() {
  run_outro();
  maps\mp\gametypes\zombies::_id_47A8("DLC1_ZM_HISTORY");
  maps\mp\mp_zombie_island_cart::make_a_transport_request(undefined, undefined, "unlock");
}

on_final_boss_defeated() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::_id_562E(var_1._id_596A))
      var_1.besttimetrialtimes[4] = int(gettime() / 1000);
  }

  lock_island_aa_gun_turrets(0);
  preload_outro_cinematic();
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  maps\mp\gametypes\zombies::_id_7E57();
  maps\mp\mp_zombie_island_cart::waitforplayersrevived();
  quest_final_boss_island_outro();
  final_boss_island_complete_xp_reward();
  level.zmb_locked_spawn_zones = undefined;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_island_final_boss");
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_boss_completed");
  level._id_400E[level._id_400E.size] = ["wicht_set 1 1", "all"];

  if(_id_744B()) {
    foreach(var_1 in level.players)
    var_1 _id_056A::_id_4772(1);
  }

  common_scripts\utility::flag_set("final boss wrapped up");
  level.zmb_boss_fight_in_progress = 0;
}

_id_744B() {
  return common_scripts\utility::_id_3C77("flag_pommel_given");
}

final_boss_island_complete_xp_reward() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("islandboss");
    var_1 _id_0378::_id_8D74("objective_complete", "islandboss");
  }
}

bombers_init() {
  var_0 = _func_1DC("plane_start_node_escort", "targetname");
  var_1 = _func_1DC("plane_start_node_bomber", "targetname");

  foreach(var_3 in var_1)
  var_3 spawn_aircraft("usa_bomber_b25_doorsopen", 1);

  foreach(var_6 in var_0)
  var_6 spawn_aircraft("usa_fighter_thunderbolt", 0);

  maps\mp\mp_zombie_island_ee_fog_manager::unlock_fog_from_lock();
}

spawn_aircraft(var_0, var_1) {
  var_2 = "ger_bomber_stuka_hub";

  if(!isDefined(var_0))
    var_0 = "usa_fighter_thunderbolt";

  if(!isDefined(var_1))
    var_1 = 0;

  var_3 = 9999;
  var_4 = _func_2CD(self.origin, self.angles, var_2, var_0);
  var_4 notify("forward");
  var_4._id_01C7 = "forward";
  var_4._id_01C1 = "forward";
  var_4._id_17DC = 0;
  var_4._id_931A = "forward";
  var_4 _meth_827C(self);

  if(var_1)
    var_4 thread drop_bomb_handler();

  var_4 thread plane_cleanup();
}

drop_bomb_handler() {
  self endon("death");

  for(;;) {
    var_0 = _func_0A4(1, 25);
    var_1 = _func_0A4(1, 25);
    var_2 = _func_071("frag_grenade_zm", self.origin, (0, 0, -1), 10);
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("zom_bomb");
    var_3 _meth_8055(var_2);
    var_3 thread delete_self(10);
    wait 2;
  }
}

plane_cleanup() {
  wait 4;

  for(;;) {
    if(isDefined(self) && self._id_01C4 <= 0) {
      self notify("death");
      self delete();
      break;
    }

    wait 3;
  }
}

delete_self(var_0) {
  wait(var_0);

  if(isDefined(self))
    self delete();
}

run_outro_for_player() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 _meth_8003();
  var_0 _meth_8322();
  var_0 _meth_82FF("ui_hide_hud", 1);
  var_0 _meth_8626("isl_outro_movie");
  var_0._id_324E = 1;
  var_0 _id_0547::_id_8A6D(1);
  var_1 = 72.5;
  var_2 = 1;
  var_3 = 0;
  var_4 = 0.5;
  var_5 = "black";
  var_6 = common_scripts\utility::_id_46B7("zmb_beach_test_spawns", "targetname");
  var_7 = var_6[0].origin;

  if(!isDefined(var_0._id_1781))
    var_0._id_1781 = maps\mp\zquests\casual\island_ee_util::_id_2787(var_5, 0, var_0, undefined);

  var_8 = var_0._id_1781;
  var_8 setshader(var_5, 640, 480);
  var_8 thread maps\mp\zquests\casual\island_ee_util::overlayfade(0, var_4, 1);
  wait(var_4);
  var_8 thread maps\mp\zquests\casual\island_ee_util::overlayfade(0, var_4, 0);
  var_8 thread maps\mp\zquests\casual\island_ee_util::overlayfade(var_1 - var_4, var_4, 1);
  _func_290(var_0, "mp/mp_zombie_island_outro", var_2, var_3);
  wait(var_1);
  _func_292(var_0);
  var_8 thread maps\mp\zquests\casual\island_ee_util::overlayfade(0, var_4, 0);
  var_0 _meth_8057();
  var_0 _meth_8004();
  var_0 _meth_8323();
  var_0 _meth_82FF("ui_hide_hud", 0);
  var_0._id_324E = 0;
  var_0 _id_0547::_id_8A6D(0);
  var_0 _meth_8627("isl_outro_movie");
  level notify("zombie_outro_finished");
}

run_outro() {
  maps\mp\zombies\_zombies_audio_dlc1::try_run_conversation(level.on_boss_finished_story, 1, 25, 1);
  level._id_AC21 = 1;

  foreach(var_1 in _id_0547::_id_408F())
  var_1 _id_056D::_id_5A86();

  foreach(var_4 in level.players)
  var_4 thread run_outro_for_player();

  level waittill("zombie_outro_finished");

  for(var_6 = 0; var_6 < level.players.size; var_6++) {
    level.players[var_6] setOrigin(level.zmb_island_final_boss_phases_spawns[var_6].origin);

    if(isDefined(level.zmb_island_final_boss_phases_spawns[var_6].angles))
      level.players[var_6] _meth_833E(level.zmb_island_final_boss_phases_spawns[var_6].angles);
  }

  level._id_AC21 = 0;
}

preload_outro_cinematic() {
  _func_28E("mp/mp_zombie_island_outro");
}

quest_step_final_boss_island() {
  common_scripts\utility::flag_init("players_boss_spawn_done");
  maps\mp\_events_z::start_boss_battle_tracking();
  wait_for_players_at_beach();
  maps\mp\mp_zombie_island_ee_fog_manager::set_fog_locked_to_off(1);
  level.zmb_fog_passive_lock = 1;
  lock_island_aa_gun_turrets(1);
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  level.block_normal_assassin_spawns = 1;
  _id_0557::_id_7822("Final Boss Island", _id_0557::removed_quest_hint());
  maps\mp\zquests\casual\island_ee_final_boss::init_final_boss_event();
  level thread maps\mp\zquests\casual\island_ee_final_boss::move_players_to_boss_start();
  maps\mp\mp_zombie_island_ee_fog_manager::set_fog_rolling_in();
  level thread maps\mp\mp_zombie_island_ee_fog_manager::set_fog_locked_to_on();
  var_0 = maps\mp\mp_zombie_island_aud::get_random_alive_player();
  var_0 thread _id_0367::_id_8E3C("bossability");
  level.ignore_cart_touching_check = 1;
  close_boss_battle_doors();
  level.maxed_zombies_sprint = 1;
  level.free_cart_rides = 1;
  level.zmb_island_pommel_detor_blocked = 1;
  level.zmb_boss_fight_in_progress = 1;
  common_scripts\utility::_id_3C9F("players_boss_spawn_done");
  wait_for_island_boss_defeated();
  level.zmb_island_pommel_detor_blocked = 0;
  level.free_cart_rides = 0;
  level.maxed_zombies_sprint = 0;
  level.zmb_fog_passive_lock = 0;
  open_boss_battle_doors();
  level.ignore_cart_touching_check = 0;
  level.block_normal_assassin_spawns = 0;
  maps\mp\_events_z::end_boss_battle_tracking();
  _id_0557::_id_782D("Final Boss Island", "Defeat Wustlings");
}

wait_for_players_at_beach() {
  var_0 = _func_18E("radio_placement_trigger", "targetname");
  var_1 = undefined;

  if(!common_scripts\utility::_id_562E(var_1) && _id_0547::_id_5565(level.zmb_uses_hint_notebook, 0)) {
    maps\mp\zombies\weapons\_zombie_aoe_grenade::register_as_pommel_grenade_target(var_0);
    var_0 waittill("pommel_damage");
  }

  var_0 _meth_80CE(&"ZOMBIE_ISLAND_ACTIVATE_BOSS_RADIO");

  if(_id_0547::_id_5565(level.zmb_uses_hint_notebook, 1)) {
    foreach(var_3 in level.players)
    maps\mp\_utility::_id_2CED(2, _id_0555::_id_83DD, "generic_no_return", var_3);
  }

  for(;;) {
    var_0 waittill("trigger", var_5);

    if(var_0 all_players_ready()) {
      break;
    } else {
      var_0 common_scripts\utility::_id_9D9F();
      wait 0.2;
      var_0 common_scripts\utility::_id_9DA3();
    }
  }

  var_0 common_scripts\utility::_id_9D9F();
}

all_players_ready() {
  foreach(var_1 in level.players) {
    if(var_1.sessionstate == "spectator")
      return 0;

    if(common_scripts\utility::_id_562E(var_1._id_5728))
      return 0;

    if(distance(self.origin, var_1.origin) > 152)
      return 0;
  }

  return 1;
}

close_boss_battle_doors() {
  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1._id_3280) && var_1._id_3280 == "closeable")
      var_1 notify("close");
    else
      var_1 notify("open");

    foreach(var_3 in var_1._id_9DC2)
    var_3 common_scripts\utility::_id_9D9F();
  }
}

open_boss_battle_doors() {
  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1._id_3280) && var_1._id_3280 == "closeable")
      var_1 notify("open");

    foreach(var_3 in var_1._id_9DC2)
    var_3 common_scripts\utility::_id_9DA3();
  }
}

wait_for_island_boss_defeated() {
  common_scripts\utility::flag_init("intro_boss_done");
  var_0 = common_scripts\utility::_id_46B5("zmb_island_boss_ammo", "targetname");
  var_1 = common_scripts\utility::_id_46B7(var_0.target, "targetname");

  foreach(var_3 in var_1)
  maps\mp\gametypes\zombies::_id_281C("ammo", var_3.origin, "random", 0, 0);

  if(level.zmi_final_boss_settings["phase_2_mercy"]) {
    var_5 = common_scripts\utility::_id_46B5("zmb_final_boss_overcharge_giveaway", "targetname");
    maps\mp\gametypes\zombies::_id_281C("ability_fill", var_5.origin, "random", 0, 0);
  }

  var_6 = common_scripts\utility::_id_46B7("zmb_island_boss_intro_zombies", "targetname");
  var_7 = common_scripts\utility::_id_46B5("zmb_island_boss_intro_zombies_freefire_target", "targetname");
  var_6 = common_scripts\utility::_id_0F6F(var_6, var_7);

  foreach(var_9 in var_6) {
    var_10 = common_scripts\utility::random(level.zmi_final_boss_settings["intro_zombies"]);
    var_11 = _id_054D::_id_90BA(var_10, var_9, "boss_intro_spawn", 0, 1, 1, undefined, 1);
    var_11 _id_0547::_id_84CB();
    var_11.bossintrozombiespawn = 1;
    var_11 thread _id_053C::_id_9C74();
  }

  var_13 = spawnStruct();
  var_13._id_3F11 = [::wait_for_shellshock_ready];
  var_14 = common_scripts\utility::_id_46B5("zmb_assassin_spawnpoint_boss_intro_shellshock", "targetname");
  var_15 = maps\mp\zombies\zombie_assassin_spawner_logic::spawn_an_assassin("zombie_assassin_shellshock", 99999, var_14, 1, "Phase 3: ATTACK", 1, undefined, undefined, var_13, 1, undefined, ["start_zone"]);
  var_15.nochill = 1;
  var_15.custom_on_shellshock_func = maps\mp\zombies\zombie_assassin_shellshock::throw_debris;
  var_15 thread set_attack_in(0, 4, "zmb_final_boss_intro_goal_shellshock");
  var_16 = common_scripts\utility::_id_46B5("zmb_assassin_spawnpoint_boss_intro_freefire", "targetname");
  var_15 = maps\mp\zombies\zombie_assassin_spawner_logic::spawn_an_assassin("zombie_assassin_freefire", 99999, var_16, 1, "Phase 3: ATTACK", 1, undefined, undefined, var_13, 1, undefined, ["start_zone"]);
  var_15.nochill = 1;
  var_15.forcedtarget = var_7;
  var_15 thread set_attack_in(0, 1.8, "zmb_final_boss_intro_goal_freefire");
  common_scripts\utility::flag_init("asn_players_are_blinded");
  var_17 = common_scripts\utility::_id_46B5("zmb_assassin_spawnpoint_boss_intro_camo", "targetname");
  var_15 = maps\mp\zombies\zombie_assassin_spawner_logic::spawn_an_assassin("zombie_assassin_camoflauge", 99999, var_17, 1, "Phase 3: ATTACK", 1, undefined, undefined, var_13, 1, undefined, ["start_zone"]);
  var_15.nochill = 1;
  var_15 thread set_attack_in(6.1, 0, "zmb_final_boss_intro_goal_camo");
  level thread set_intro_done();
  common_scripts\utility::_id_3C9F("asn_players_are_blinded");

  foreach(var_9 in level.zmb_isl_conditional_boss_spawns)
  var_9.is_zombies_spawner_script_disabled = 1;

  foreach(var_21 in level.zmb_island_final_boss_phases) {
    level thread maps\mp\zquests\casual\island_ee_final_boss::start_zombie_island_boss_phase(var_21);
    common_scripts\utility::_id_3C9F(var_21.phase_flag);
  }

  foreach(var_9 in level.zmb_isl_conditional_boss_spawns)
  var_9.is_zombies_spawner_script_disabled = 0;
}

set_intro_done() {
  wait 10.1;
  common_scripts\utility::flag_set("intro_boss_done");
}

wait_for_shellshock_ready() {
  while(!common_scripts\utility::_id_562E(self.readytoshowoff))
    waitframe();
}

set_attack_in(var_0, var_1, var_2) {
  self endon("death");
  self.leaveafterspecial = 1;
  self.noflurry = 1;
  self _meth_83A2(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "idle_noncombat");
  maps\mp\agents\_scripted_agent_anim_util::_id_8415("idle_asn", 1, 1.0);
  self.bossintroassassin = 1;
  self.preformingbossintro = 1;
  self._id_1928 = common_scripts\utility::_id_46B5(var_2, "targetname");
  wait(var_0);
  self _meth_83A2(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "idle_noncombat");
  wait(var_1);
  self.bossintroassassin = 0;
  self.preformingbossintro = 0;
  self.dontwaitonfirstattack = 1;
  self.readytoshowoff = 1;

  while(!common_scripts\utility::_id_562E(self.hasassassinspecialed))
    waitframe();

  wait 0.15;
  self._id_1928 = undefined;
  common_scripts\utility::_id_3C9F("asn_players_are_blinded");
  self setOrigin((0, 0, 0));
  maps\mp\zombies\zombie_assassin_spawner_logic::set_assassin_removed_from_game();
}

boss_ammo_pickup(var_0) {
  var_1 = undefined;

  for(;;) {
    foreach(var_3 in level.players) {
      if(distance(var_3.origin, self.origin) < 64) {
        var_1 = var_3;
        break;
      }
    }

    if(isDefined(var_1)) {
      break;
    }

    waitframe();
  }

  self delete();

  if(!common_scripts\utility::_id_562E(var_0))
    maps\mp\gametypes\zombies::_id_0DB9(var_1, 1);
  else
    maps\mp\gametypes\zombies::_id_0840(var_1, 1);
}

initialize_intro_struct() {
  var_0 = common_scripts\utility::_id_46B5("final_boss_intro_struct", "targetname");
  var_1 = common_scripts\utility::_id_44BE(var_0.target, "targetname");
  var_0.assassin_spawners = [];

  foreach(var_3 in var_1) {
    switch (var_3._id_0165) {
      case "zmb_assassin_spawner":
        var_0.assassin_spawners = common_scripts\utility::_id_0F6F(var_0.assassin_spawners, var_3);
        break;
      case "intro_cam_temp":
        var_0.intro_cam = var_3;
        var_0.intro_dest = common_scripts\utility::_id_46B5(var_3.target, "targetname");
        break;
    }
  }

  return var_0;
}

wait_for_wustling_extinction() {
  var_0 = 0;

  while(!var_0) {
    var_1 = _id_0547::_id_408F();
    var_0 = 1;

    foreach(var_3 in var_1) {
      if(common_scripts\utility::_id_562E(var_3.iswustlingzombie))
        var_0 = 0;
    }

    wait 0.125;
  }
}

unset_cinematic() {
  foreach(var_1 in level.players) {
    var_1 _meth_8057();
    var_1 _meth_8004();
    var_1 _meth_848C();
    var_1 _meth_8323();
    var_1 maps\mp\_utility::freezecontrolswrapper(0);
    var_1 _meth_82FF("ui_hide_hud", 0);
  }

  level._id_7317 delete();
}

in_game_cinematic(var_0, var_1, var_2) {
  level childthread[[var_0]]();

  if(!isDefined(level._id_7317)) {
    level._id_7317 = spawn("script_model", (0, 0, 0));
    level._id_7317 setModel("player_generic_world_body");
    level._id_7317 _meth_8511();
  }

  foreach(var_4 in level.players) {
    var_4 _meth_82FF("ui_hide_hud", 1);
    var_4 _meth_848D();
    var_4 _meth_8003();
    var_4 _meth_8322();
    var_4 maps\mp\_utility::freezecontrolswrapper(1);
    var_4 setOrigin(level._id_7317 gettagorigin("tag_player"));
    var_4 _meth_833E(level._id_7317 _meth_8181("tag_player"));
    var_4 _meth_807A(level._id_7317, "tag_player");
  }

  var_6 = common_scripts\utility::_id_46B5(var_1, "targetname");
  var_7 = common_scripts\utility::_id_46B5(var_6.target, "targetname");
  level._id_7317.origin = var_6.origin;
  level._id_7317.angles = var_6.angles;
  level._id_7317 _meth_82B1(var_7.origin, var_2);
  wait_for_intermission(var_2);
}

flourish_assassins() {}

destroyer_sink() {
  var_0 = _func_18E("last_destroyer", "targetname");
  var_1 = common_scripts\utility::_id_46B5(var_0.target, "targetname");
  var_0 _meth_82B1(var_1.origin, 10);
  var_0 _meth_82B8(var_1.angles, 10);
}

spawn_the_bosses() {}

spawn_boss_assassin(var_0) {}

wait_for_spawner_intro() {
  wait 5;
}

wait_for_intermission(var_0) {
  wait(var_0);
}

attach_armor(var_0) {
  foreach(var_2 in var_0) {
    var_3 = var_2._id_0165;
    var_2.origin = self gettagorigin(var_3);
    var_2 _meth_8055(self, var_3, get_pos_offset_for_armor(var_3), get_angle_offset_for_armor(var_3));
  }
}

get_pos_offset_for_armor(var_0) {
  var_1 = (0, 0, 0);

  switch (var_0) {
    case "J_SpineUpper":
      var_1 = var_1 + (8, 10, 0);
      break;
    case "J_Knee_LE":
      var_1 = var_1 + (0, 0, 0);
      break;
    case "J_Knee_RI":
      var_1 = var_1 + (0, 0, 0);
      break;
    case "J_Elbow_LE":
      var_1 = var_1 + (0, 0, 0);
      break;
    case "J_Elbow_RI":
      var_1 = var_1 + (0, 0, 0);
      break;
    default:
      break;
  }

  return var_1;
}

get_angle_offset_for_armor(var_0) {
  var_1 = self _meth_8181(var_0);

  switch (var_0) {
    case "J_SpineUpper":
      var_1 = var_1 + (0, 180, 0);
      break;
    case "J_Knee_LE":
      var_1 = (180, 0, 90);
      break;
    case "J_Knee_RI":
      var_1 = (-180, 180, 90);
      break;
    case "J_Elbow_LE":
      var_1 = var_1 + (0, 0, 180);
      break;
    case "J_Elbow_RI":
      var_1 = var_1 + (270, 90, 180);
      break;
    default:
      break;
  }

  return var_1;
}

show_parts() {
  foreach(var_1 in self)
  var_1 _meth_805B();
}

assassin_part_collected() {
  return common_scripts\utility::_id_3C77("players_have_razergun_3");
}