/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_blood_tubes.gsc
****************************************************/

func_00D5() {
  precacherumble("damage_heavy");
  link_teleporters("bt_limbo_entrance_2", "zone_crash", "bt_archives_entrance_1", "zone_archives_closet");
  link_teleporters("bt_archives_entrance_1", "zone_archives_closet", "bt_alter_entrance_1", "zone_alter");
  link_teleporters("bt_alter_entrance_1", "zone_alter", "bt_limbo_entrance_2", "zone_crash");
  link_teleporters("bt_gallery_entrance_1", "zone_bridge", "bt_limbo_entrance_2", "zone_crash");
  link_teleporters("bt_gluttony_entrance_1", "zone_cave", "bt_citadel_entrance_1", "zone_citadel");
  link_teleporters("bt_citadel_entrance_1", "zone_citadel", "bt_gluttony_entrance_1", "zone_cave");
  level.bloodtubecost = 250;
  level.nextcorpseeaterpunishment = 2;
  level.totaltrips = 0;
  var_00 = getEntArray("struct_bt_main", "targetname");
  common_scripts\utility::func_FB2(var_00, ::run_my_teleporter);
  level thread handle_blood_tube_upgrade_overrides();
}

should_execute_corpse_eater_punishment() {
  return level.totaltrips >= level.nextcorpseeaterpunishment;
}

execute_next_corpse_eater_punishment(param_00) {
  set_next_corpse_eater_goal();
  if(lib_0547::func_4090("zombie_dlc4").size == 0) {
    for(var_01 = 0; var_01 < 2; var_01++) {
      var_02 = lib_054D::func_90BA("zombie_dlc4", undefined, "corpse_eater", 1, 1, 0);
    }
  }
}

set_next_corpse_eater_goal() {
  level.nextcorpseeaterpunishment = level.totaltrips + 2;
}

handle_blood_tube_upgrade_overrides() {
  var_00 = [];
  var_00[0] = init_pap_button("zmb_upgrade_stone_a");
  foreach(var_02 in var_00) {
    level thread handle_pap_button(var_02);
  }
}

handle_pap_button(param_00) {
  var_01 = param_00.stone.var_116;
  var_02 = param_00.stone.var_116 - 2 * vectornormalize(anglesToForward(param_00.stone.var_1D));
  for(;;) {
    param_00.var_9D65 waittill("trigger", var_03);
    param_00.stone moveto(var_02, 0.5, 0, 0.1);
    lib_0378::func_8D74("aud_deathraven_button", param_00.stone);
    level.papoverridden = 1;
    wait(0.5);
    param_00.stone setModel("zmf_blood_tube_brick_01_glow");
    param_00.var_9D65 waittill("trigger", var_03);
    param_00.stone moveto(var_01, 0.5, 0, 0.1);
    lib_0378::func_8D74("aud_deathraven_button", param_00.stone);
    level.papoverridden = 0;
    wait(0.5);
    param_00.stone setModel("zmf_blood_tube_brick_01");
  }
}

init_pap_button(param_00) {
  var_01 = common_scripts\utility::func_44BE(param_00, "script_noteworthy");
  var_02 = spawnStruct();
  foreach(var_04 in var_01) {
    switch (var_04.var_1A5) {
      case "zmb_upgrade_stone_trig":
        var_02.var_9D65 = var_04;
        break;

      case "zmb_upgrade_stone":
        var_02.stone = var_04;
        break;

      case "zmb_upgrade_stone_dest":
        var_02.stone_dest = var_04;
        break;
    }
  }

  return var_02;
}

run_my_teleporter() {
  tube_setup();
  while(!level.var_AC80.var_ACB3[level.blood_tube_links[self.var_82EC][1]].var_556E || !level.var_AC80.var_ACB3[level.blood_tube_links[self.var_82EC][3]].var_556E) {
    wait 0.05;
  }

  if(isDefined(self.var_8260) && self.var_8260 == "boss_tube_enter") {
    thread boss_tube_wait_for_interact();
  } else if(self.var_82EC == "bt_gallery_entrance_1") {
    thread bonus_tube_wait_for_interact();
  } else {
    thread tube_wait_for_interact();
  }

  if(self.var_82EC == "bt_gallery_entrance_1") {
    thread tube_transport_logic("flag_bonus_plates_filled");
  } else {
    thread tube_transport_logic();
  }

  thread toggle_tubes_for_boss_fight();
}

tube_setup() {
  var_00 = getEntArray(self.var_1A2, "targetname");
  foreach(var_02 in var_00) {
    switch (var_02.var_165) {
      case "bt_blood_fill":
        self.blood_fill = var_02;
        self.blood_fill.var_A796 = 3;
        self.blood_fill.var_9269 = var_02.var_116;
        break;

      case "bt_water":
        self.blood_fill_water = var_02;
        self.blood_fill_water.var_9269 = self.var_116;
        break;

      case "bt_waterlevel":
        self.blood_fill_waterlevel = var_02;
        self.blood_fill_waterlevel.var_9269 = self.var_116;
        break;

      case "trig_bt_interact":
        self.use_trig = var_02;
        break;

      case "bt_door_l":
        self.door_l = var_02;
        break;

      case "bt_door_r":
        self.door_r = var_02;
        break;

      case "door_l_pivot":
        self.door_l_pivot = var_02;
        self.door_l_pivot.initialangles = self.door_l_pivot.var_1D;
        self.door_l.var_241F = getent(self.door_l_pivot.var_1A2, "targetname");
        self.door_l.var_241F.var_A045 = ::transport_unresolved_collide;
        self.door_l.var_241F.var_206B = self;
        self.door_l.var_241F method_8449(self.door_l_pivot);
        break;

      case "door_r_pivot":
        self.door_r_pivot = var_02;
        self.door_r_pivot.initialangles = self.door_r_pivot.var_1D;
        self.door_r.var_241F = getent(self.door_r_pivot.var_1A2, "targetname");
        self.door_r.var_241F.var_A045 = ::transport_unresolved_collide;
        self.door_r.var_241F.var_206B = self;
        self.door_r.var_241F method_8449(self.door_r_pivot);
        break;

      case "bt_navmesh_clip":
        self.navmesh_clip = var_02;
        break;

      case "bt_spawn":
        if(!isDefined(self.blood_spawns)) {
          self.blood_spawns = [];
        }

        self.blood_spawns[self.blood_spawns.size] = var_02;
        break;

      default:
        break;
    }
  }

  self.door_l method_8449(self.door_l_pivot);
  self.door_r method_8449(self.door_r_pivot);
  self.transport_inactive = 1;
}

transport_unresolved_collide(param_00) {
  self.var_A048 = [self.var_206B];
  maps\mp\_movers::func_A047(param_00, 0);
}

tube_wait_for_interact() {
  var_00 = level.bloodtubecost;
  thread tube_cost_reset(var_00);
  if(!isDefined(level.zmb_blood_tubes)) {
    level.zmb_blood_tubes = [];
  }

  level.zmb_blood_tubes[level.zmb_blood_tubes.size] = self;
  for(;;) {
    self.use_trig waittill("trigger", var_01);
    if(common_scripts\utility::func_562E(self.var_65DC.is_in_blood_tube_cooldown)) {
      continue;
    }

    if(common_scripts\utility::func_562E(self.transport_in_use)) {
      continue;
    }

    if(common_scripts\utility::func_562E(self.transport_inactive)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_01.ontransportcooldown)) {
      continue;
    }

    if(!common_scripts\utility::func_562E(var_01.hitchingaride)) {
      if(!var_01 istouching(self.use_trig)) {
        continue;
      }

      if(!var_01 maps\mp\gametypes\zombies::func_11C2(level.bloodtubecost, 0, 0, 1)) {
        continue;
      }
    }

    level.totaltrips++;
    level.bloodtubecost = level.bloodtubecost + 250;
    if(level.bloodtubecost > 1500) {
      level.bloodtubecost = 1500;
    }

    level notify("blood_tube_cost_updated");
    level notify("blood_tube_valid_use");
    level waittill("blood_tube_transport_complete");
    if(should_execute_corpse_eater_punishment()) {
      execute_next_corpse_eater_punishment();
    }
  }
}

tube_transport_logic(param_00) {
  var_01 = self;
  var_02 = level.blood_tube_links[var_01.var_82EC][2];
  var_03 = var_01.blood_fill.var_A796;
  if(isDefined(param_00)) {
    common_scripts\utility::func_3C9F(param_00);
  }

  var_01 transport_open();
  var_01 thread transport_activate();
  for(;;) {
    level waittill("blood_tube_valid_use");
    var_04 = level.var_A980;
    if(is_boss_tube_short_circut()) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_02.transport_inactive)) {
      var_02 thread transport_close();
    }

    var_01 transport_deactivate();
    var_01 transport_close();
    var_05 = [];
    var_06 = get_players_departing(var_01);
    var_07 = get_zombies_departing(var_01);
    foreach(var_09 in var_07) {
      if(var_06.size == 0 && var_07.size == 1 && lib_0547::func_5565(var_09.var_A4B, "zombie_heavy")) {
        level notify("wustlinground_trip");
      }

      common_scripts\utility::func_3C8F(var_09.var_A4B + "_trophy_event_3");
      if(isDefined(var_09.ismooncontrolled)) {
        var_09.stall_mc_death = 1;
      }
    }

    foreach(var_0C in var_06) {
      var_0C.var_480F = 1;
      var_0C.isbloodtubemoonorbblocked = 1;
      var_0C.lastdepartdoor = var_01;
    }

    var_05 = common_scripts\utility::func_F73(var_06, var_07);
    level thread play_blood_vision_for_players(var_06, var_01);
    foreach(var_0C in var_06) {
      var_0C thread handle_players_with_uber();
      var_0C childthread do_transport_rumble(2, 1);
      var_0C thread run_blood_intro(self.blood_fill_waterlevel.var_9269, var_01.var_116);
    }

    wait(2);
    wait(var_03);
    if(isDefined(var_01.var_82EC) && var_01.var_82EC != "bt_gallery_entrance_1" && var_01.var_82EC != "bt_gluttony_entrance_1") {
      maps\mp\mp_zombie_descent_ee_side::dark_passenger_test(var_05);
    }

    send_players_to_destination_location(var_05, var_01);
    foreach(var_09 in var_07) {
      if(isDefined(var_09.ismooncontrolled) && var_09.ismooncontrolled == 1 && !isDefined(var_09.isdarkhost) || var_09.isdarkhost != 1) {
        var_09.stall_mc_death = 0;
      }
    }

    foreach(var_0C in get_players_departing(var_02)) {
      var_0C thread do_transport_rumble(2.5, 0);
    }

    wait(1);
    level notify("blood_tube_players_teleported");
    if(common_scripts\utility::func_562E(var_02.transport_inactive)) {
      var_02 thread transport_open();
    }

    level thread remove_godmode_for_players(var_06);
    foreach(var_0C in get_players_departing(var_02)) {
      lib_0547::playfxclient("zmb_desc_screen_fx_exit_bloody", var_02.var_116, var_0C, 5);
    }

    var_01 transport_open();
    foreach(var_17 in var_05) {
      if(isPlayer(var_17)) {
        var_17 thread maps\mp\mp_zombie_descent_utils::vo_blood_tube_exit();
      }
    }

    level notify("blood_tube_transport_complete");
    if(common_scripts\utility::func_562E(var_02.transport_inactive)) {
      var_02 thread inactive_tube_attempt_to_close();
    }

    var_01 transport_activate();
  }
}

is_boss_tube_short_circut() {
  if(isDefined(self.var_8260) && self.var_8260 == "boss_tube_enter" && !common_scripts\utility::func_3C77("flag_boss_arena_teleport_began")) {
    return 1;
  }

  if(lib_0547::func_5565(self.var_82EC, "bt_citadel_entrance_1") && !common_scripts\utility::func_3C77("flag_boss_arena_teleport_began")) {
    return 1;
  }

  return 0;
}

handle_players_with_uber() {
  if(common_scripts\utility::func_562E(self.var_56A5)) {
    self notify("uber_lost", "uber_deposited");
    level waittill("blood_tube_players_teleported");
    thread lib_0585::func_8555("stormraven_uber");
    level notify("player grabbed uber battery");
    thread lib_0585::func_3481("stormraven_uber");
  }
}

remove_godmode_for_players(param_00) {
  wait(2);
  foreach(var_02 in param_00) {
    var_02.var_480F = 0;
    var_02.isbloodtubemoonorbblocked = undefined;
  }
}

run_blood_intro(param_00, param_01) {
  var_02 = self;
  var_02 endon("disconnect");
  lib_0547::playfxclient("zmb_desc_bloodtube_drip_01", param_00, var_02, 5);
  wait(2);
  lib_0547::playfxclient("zmb_desc_bloodtube_screen", param_01, var_02, 7);
  lib_0378::func_8D74("aud_blood_tube_engulf", param_01);
  wait(5);
  playFX(level.var_611["zmb_desc_bloodtube_drip_exit"], param_01);
}

do_transport_rumble(param_00, param_01) {
  var_02 = self;
  var_02 endon("disconnect");
  var_02 notify("new_transport_rumble");
  var_02 endon("new_transport_rumble");
  var_03 = gettime();
  var_02 method_8322();
  while(gettime() - var_03 < param_00 * 1000) {
    wait(randomfloat(0.4) + 0.7);
    var_02 playrumbleonentity("damage_heavy");
  }

  if(common_scripts\utility::func_562E(var_02.isdarkpassenger)) {
    param_01 = 1;
  }

  if(lib_0547::func_5565(var_02.isintrial, "zom_dlc4_scythe_zm")) {
    param_01 = 1;
  }

  if(!param_01) {
    var_02 method_8323();
  }
}

delete_fxs_delay(param_00) {
  lib_0547::func_A6F6();
  foreach(var_02 in param_00) {
    var_02 delete();
  }
}

tube_do_transport(param_00, param_01, param_02) {
  if(isPlayer(self)) {
    self endon("disconnect");
    self.ontransportcooldown = 1;
  }

  if(!isDefined(level.num_unique_destinations)) {
    level.num_unique_destinations = 0;
  }

  if(!has_objective_destination() && !common_scripts\utility::func_562E(self.tryingtoleavepap) && is_passenger_pap_valid(param_01)) {
    try_to_reroute_to_upgrade_machine_room(param_00, param_01);
  }

  self.tryingtoleavepap = 0;
  param_01 = check_for_quest_detour(param_01);
  thread handle_blood_vision(param_01);
  if(!isDefined(param_01.blood_spawns)) {
    param_01.blood_spawns = common_scripts\utility::func_46B7(param_01.var_1A2, "targetname");
  }

  if(param_02 >= param_01.blood_spawns.size) {
    param_02 = randomint(param_01.blood_spawns.size);
  }

  if(isPlayer(self)) {
    var_03 = 0;
    while(common_scripts\utility::func_562E(self.var_57AB) || common_scripts\utility::func_562E(self.var_172C)) {
      var_03 = 1;
      wait 0.05;
    }

    if(common_scripts\utility::func_562E(var_03)) {
      do_transport_rumble(0, 0);
    }
  }

  self setorigin(param_01.blood_spawns[param_02].var_116);
  if(isDefined(self.wing_fx)) {
    thread maps\mp\zombies\zombie_king::spawn_wings();
  }

  if(isDefined(self.mooncontrolledfx)) {
    thread maps\mp\zombies\weapons\_zombie_dlc4_melee::moonorb_mind_control_fx(1);
  }

  if(isDefined(self.darkhostfx)) {
    thread maps\mp\mp_zombie_descent_ee_side::dark_host_control_fx();
  }

  if(isDefined(self.poweredupfx)) {
    thread maps\mp\zombies\zombie_corpse_eater::zombie_corpse_eater_vfx(1);
  }

  lib_0378::func_8D74("aud_blood_tube_splash", param_01.blood_spawns[param_02].var_116);
  if(isPlayer(self) && isDefined(param_01.blood_spawns[param_02].var_1D)) {
    self setangles(param_01.blood_spawns[param_02].var_1D);
  }

  self.ontransportcooldown = 0;
}

is_passenger_pap_valid(param_00) {
  if(common_scripts\utility::func_562E(self.isdarkpassenger) || common_scripts\utility::func_562E(self.isdarkhost)) {
    return 0;
  }

  if(maps\mp\mp_zombie_descent_ee_side::playerinsewers()) {
    return 0;
  }

  if(lib_0547::func_5565(param_00.var_82EC, "bt_citadel_entrance_1") && !common_scripts\utility::func_3C77("flag_boss_fight_start")) {
    return 0;
  }

  return 1;
}

try_to_reroute_to_upgrade_machine_room(param_00, param_01) {
  if(common_scripts\utility::func_562E(level.papoverridden)) {
    if(!isDefined(param_01.hasbeentraveledto)) {
      param_01.hasbeentraveledto = 1;
      set_next_pap_unlock_flag();
    }

    maps\mp\mp_zombie_descent_ee_main::set_weapon_upgrade_blood_tube_route("zom_pap_trial_destination");
  }
}

play_blood_vision_for_players(param_00, param_01) {
  var_02 = self;
  foreach(var_02 in param_00) {
    var_02 thread handle_blood_vision(param_01);
    var_02 lib_0378::func_8D74("aud_blood_tube_filling_up");
    var_02 thread maps\mp\mp_zombie_descent_utils::vo_blood_tube_enter();
  }
}

get_players_departing(param_00) {
  var_01 = [];
  foreach(var_03 in level.var_744A) {
    if(var_03 player_is_in_pod(param_00)) {
      var_01[var_01.size] = var_03;
      continue;
    }

    if(common_scripts\utility::func_562E(var_03.hitchingaride)) {
      if(common_scripts\utility::func_562E(var_03.tryingtoleavepap) && !lib_0547::func_5565(var_03.lastdepartdoor, param_00)) {
        continue;
      }

      var_03.hitchingaride = 0;
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

player_is_in_pod(param_00) {
  var_01 = self;
  return var_01 istouching(param_00.use_trig);
}

get_zombies_departing(param_00) {
  var_01 = [];
  var_02 = get_all_zombies_include_mooncontrolled();
  foreach(var_04 in var_02) {
    if(var_04 istouching(param_00.use_trig)) {
      var_01[var_01.size] = var_04;
    }
  }

  return var_01;
}

get_all_zombies_include_mooncontrolled() {
  var_00 = [];
  var_01 = maps\mp\agents\_agent_utility::func_43FD("all");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_A) && var_03.var_A == level.var_746E && !common_scripts\utility::func_562E(var_03.ismooncontrolled)) {
      continue;
    }

    var_00[var_00.size] = var_03;
  }

  return var_00;
}

tube_cost_reset(param_00) {
  for(;;) {
    level waittill("zombie_wave_ended");
    level.bloodtubecost = param_00;
    level notify("blood_tube_cost_updated");
    set_next_corpse_eater_goal();
  }
}

inactive_tube_attempt_to_close() {
  self endon("transport_became_active");
  while(common_scripts\utility::func_562E(self.transport_inactive)) {
    while(players_occupying_inactive_tube()) {
      wait 0.05;
    }

    transport_close(1);
    if(players_occupy_this_tube()) {
      transport_open(1);
      continue;
    }

    return;
  }
}

players_occupying_inactive_tube() {
  return common_scripts\utility::func_562E(self.transport_inactive) && players_occupy_this_tube();
}

players_occupy_this_tube() {
  return num_players_in_tube() > 0;
}

num_players_in_tube() {
  var_00 = 0;
  foreach(var_02 in level.var_744A) {
    if(var_02 istouching(self.use_trig)) {
      var_00++;
    }
  }

  return var_00;
}

doors_fully_open() {
  return lib_0547::func_5565(self.door_r_pivot.var_1D, self.door_r_pivot.initialangles + (0, -60, 0));
}

set_next_pap_unlock_flag() {
  if(!isDefined(level.num_unique_destinations)) {
    level.num_unique_destinations = 0;
  }

  level.num_unique_destinations++;
  var_00 = "pap_raise_" + level.num_unique_destinations;
  if(common_scripts\utility::func_3C83(var_00)) {
    common_scripts\utility::func_3C8F(var_00);
  }
}

handle_blood_vision(param_00) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  self notify("set_blood_vision");
  self endon("set_blood_vision");
  if(!isDefined(self.eyes_below_water)) {
    self.eyes_below_water = 0;
  }

  while(lib_0547::func_5565(param_00.doing_transport, 1)) {
    if(test_eyes_below_water(param_00.blood_fill_waterlevel)) {
      if(lib_0547::func_5565(self.eyes_below_water, 0)) {
        self.eyes_below_water = 1;
        enable_blood_vision();
      }

      continue;
    }

    if(lib_0547::func_5565(self.eyes_below_water, 1)) {
      self.eyes_below_water = 0;
      disable_blood_vision();
    }

    wait 0.05;
  }

  while(lib_0547::func_5565(self.isdarkpassenger, 1)) {
    wait 0.05;
  }

  if(!lib_0547::func_5565(param_00.doing_transport, 1) && !lib_0547::func_5565(self.isdarkpassenger, 1)) {
    self.eyes_below_water = 0;
    disable_blood_vision();
  }
}

test_eyes_below_water(param_00) {
  if(self getEye()[2] < param_00.var_116[2]) {
    return 1;
  }

  return 0;
}

enable_blood_vision() {
  if(!common_scripts\utility::func_562E(level.var_22F0)) {
    self method_8483("mp_zombie_descent_underwater", 0.05);
    self lightsetoverrideenableforplayer("mp_zombie_descent_underwater", 0.05);
    self.vision_blood_active = 1;
  }
}

disable_blood_vision() {
  self method_8483("", 0.05);
  self method_83C8(0.05);
  self.vision_blood_active = undefined;
}

check_for_quest_detour(param_00) {
  if(has_objective_destination()) {
    var_01 = common_scripts\utility::func_46B5("zmb_trials_router", "targetname");
    var_02 = common_scripts\utility::func_46B7(var_01.var_1A2, "targetname");
    foreach(var_04 in var_02) {
      if(lib_0547::func_5565(var_04.var_165, self.forcedblooddest)) {
        thread maps\mp\mp_zombie_descent_ee_main::run_weapon_ritual(var_04.var_165, param_00);
        self.old_destination = param_00;
        param_00 = var_04;
        self.forcedblooddest = undefined;
        break;
      }
    }
  }

  return param_00;
}

has_objective_destination() {
  return isDefined(self.forcedblooddest);
}

transport_deactivate() {
  self.transport_in_use = 1;
  if(isDefined(self.var_65DC)) {
    self.var_65DC.var_6642 = 1;
    self.var_65DC.var_2F74 = 1;
  }
}

transport_activate() {
  self.transport_inactive = 0;
  self.transport_in_use = 0;
  self notify("transport_became_active");
  if(isDefined(self.use_trig)) {
    if(!isDefined(self.var_65DC)) {
      self.var_65DC = lib_0552::func_7BE1(undefined, self.use_trig);
      self.var_65DC.var_4028 = lib_0552::func_44FF("dlc4_tube_interact");
    }

    wait 0.05;
    if(common_scripts\utility::func_3C77("flag_boss_complete")) {
      thread update_transport_prompt_think();
    } else if(!lib_0547::func_5565(self.var_8260, "boss_tube_enter") && !lib_0547::func_5565(self.var_8260, "boss_tube_exit")) {
      if(isDefined(self.var_65DC.first_activation)) {
        self.var_65DC.is_in_blood_tube_cooldown = 1;
        self.var_65DC.var_2F74 = 0;
        self.var_65DC.var_6642 = 1;
        self.var_65DC.var_401E = 0;
        self.var_65DC.var_4028 = lib_0552::func_44FF("dlc4_tube_cooldown");
        var_00 = gettime();
        var_01 = 20;
        while(!some_one_hitching_a_ride() && gettime() - var_00 / 1000 < var_01) {
          wait 0.05;
        }

        self.var_65DC.is_in_blood_tube_cooldown = 0;
        self.var_65DC.var_4028 = lib_0552::func_44FF("dlc4_tube_interact");
      } else {
        self.var_65DC.first_activation = 1;
      }

      thread update_transport_prompt_think();
    }

    self.var_65DC.var_6642 = 1;
    self.var_65DC.var_2F74 = 0;
  }
}

update_transport_prompt_think() {
  self notify("update_transport_cost_think");
  self endon("update_transport_cost_think");
  for(;;) {
    self.var_65DC.var_401E = level.bloodtubecost;
    common_scripts\utility::func_A70C(self, "transport_became_active", level, "blood_tube_cost_updated");
    waittillframeend;
  }
}

some_one_hitching_a_ride() {
  foreach(var_01 in level.var_744A) {
    if(common_scripts\utility::func_562E(var_01.hitchingaride)) {
      return 1;
    }
  }

  return 0;
}

transport_close(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = 3;
  self.door_r_pivot rotateto(self.door_r_pivot.initialangles, var_01);
  self.door_l_pivot rotateto(self.door_l_pivot.initialangles, var_01);
  lib_0378::func_8D74("aud_blood_tube_door_close");
  wait(var_01);
  self.doing_transport = 1;
  if(!common_scripts\utility::func_562E(param_00)) {}

  self.door_l.var_241F method_805F();
  self.door_r.var_241F method_805F();
}

transport_open(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = 1;
  self.door_l.var_241F method_8060();
  self.door_r.var_241F method_8060();
  if(!common_scripts\utility::func_562E(param_00)) {
    wait(self.blood_fill.var_A796);
  }

  playFX(level.var_611["zmb_desc_bloodtube_drip_exit"], self.door_l_pivot.var_116);
  var_02 = 3;
  self.door_r_pivot rotateto(self.door_r_pivot.initialangles + (0, -60, 0), var_02);
  self.door_l_pivot rotateto(self.door_l_pivot.initialangles + (0, 60, 0), var_02);
  lib_0378::func_8D74("aud_blood_tube_door_open");
  wait(var_02);
  self.doing_transport = 0;
}

link_teleporters(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.blood_tube_links)) {
    level.blood_tube_links = [];
  }

  var_04 = getEntArray("struct_bt_main", "targetname");
  if(!isDefined(level.blood_tube_links[param_00])) {
    level.blood_tube_links[param_00] = [];
  }

  if(!isDefined(level.blood_tube_links["defaults"])) {
    level.blood_tube_links["defaults"] = [];
    foreach(var_06 in var_04) {
      if(lib_0547::func_5565(var_06.var_82EC, "bt_limbo_entrance_1")) {
        level.blood_tube_links["defaults"] = common_scripts\utility::func_F6F(level.blood_tube_links["defaults"], var_06);
      }
    }
  }

  foreach(var_09 in var_04) {
    if(lib_0547::func_5565(var_09.var_82EC, param_00)) {
      level.blood_tube_links[param_00] = common_scripts\utility::func_F6F(level.blood_tube_links[param_00], var_09);
      level.blood_tube_links[param_00] = common_scripts\utility::func_F6F(level.blood_tube_links[param_00], param_01);
      var_0A = undefined;
      foreach(var_0A in var_04) {
        if(lib_0547::func_5565(var_0A.var_82EC, param_02)) {
          level.blood_tube_links[param_00] = common_scripts\utility::func_F6F(level.blood_tube_links[param_00], var_0A);
          level.blood_tube_links[param_00] = common_scripts\utility::func_F6F(level.blood_tube_links[param_00], param_03);
        }
      }
    }
  }
}

enter_boss_tube_activate() {
  level.var_AC80.var_ACB3[level.blood_tube_links["bt_gluttony_entrance_1"][1]].var_556E = 1;
  level.var_AC80.var_ACB3[level.blood_tube_links["bt_gluttony_entrance_1"][3]].var_556E = 1;
}

boss_tube_wait_for_interact() {
  level endon("god_king_defeated");
  childthread boss_tube_toggle_hint();
  for(;;) {
    self.use_trig waittill("trigger", var_00);
    if(common_scripts\utility::func_562E(self.var_65DC.var_2F74)) {
      continue;
    }

    if(common_scripts\utility::func_562E(self.transport_inactive)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_00.ontransportcooldown)) {
      continue;
    }

    var_01 = 0;
    foreach(var_03 in level.ravenweaponmanager) {
      if(isDefined(var_03.var_117)) {
        var_01++;
      }
    }

    if(var_01 < level.var_744A.size) {
      continue;
    }

    var_05 = 1;
    foreach(var_00 in level.var_744A) {
      if(!var_00 istouching(self.use_trig)) {
        var_05 = 0;
        break;
      }
    }

    if(!var_05) {
      continue;
    }

    self.var_65DC.var_6642 = 1;
    self.var_65DC.var_2F74 = 1;
    common_scripts\utility::func_3C8F("flag_boss_arena_teleport_began");
    wait 0.05;
    level notify("blood_tube_boss_valid_use");
    level notify("blood_tube_valid_use");
    level waittill("blood_tube_players_teleported");
    common_scripts\utility::func_3C8F("flag_entered_boss_arena");
  }
}

boss_tube_toggle_hint() {
  level endon("blood_tube_boss_valid_use");
  for(;;) {
    var_00 = boss_tube_check_for_activation();
    if(!isDefined(self.var_65DC)) {
      self.var_65DC = lib_0552::func_7BE1(undefined, self.use_trig);
      self.var_65DC.var_4028 = lib_0552::func_44FF("dlc4_tube_interact");
    }

    if(var_00) {
      self.var_65DC.var_6642 = 1;
      self.var_65DC.var_2F74 = 0;
    } else {
      self.var_65DC.var_6642 = 1;
      self.var_65DC.var_2F74 = 1;
    }

    wait 0.05;
  }
}

boss_tube_check_for_activation() {
  var_00 = 0;
  foreach(var_02 in level.ravenweaponmanager) {
    if(isDefined(var_02.var_117)) {
      var_00++;
    }
  }

  if(var_00 < level.var_744A.size) {
    return 0;
  }

  foreach(var_05 in level.var_744A) {
    if(!var_05 istouching(self.use_trig)) {
      return 0;
    }
  }

  return 1;
}

toggle_tubes_for_boss_fight() {
  common_scripts\utility::func_3C9F("flag_boss_fight_start");
  self.oldinactivestate = self.transport_inactive;
  transport_deactivate();
  common_scripts\utility::func_3C9F("flag_boss_complete");
  if(isDefined(self.oldinactivestate) && !self.oldinactivestate) {
    thread transport_activate();
  }

  if(lib_0547::func_5565(self.var_8260, "boss_tube_enter")) {
    tube_wait_for_interact();
  }
}

send_players_to_destination_location(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_03 = var_02;
    if(var_03 > param_01.blood_spawns.size) {
      var_03 = 0;
    }

    param_00[var_02] thread tube_do_transport(param_01, level.blood_tube_links[self.var_82EC][2], var_03);
  }
}

bonus_tube_wait_for_interact() {
  level.zmb_bonus_blood_tube_trig = self.use_trig;
  common_scripts\utility::func_3C9F("flag_bonus_plates_filled");
  for(;;) {
    self.use_trig waittill("trigger", var_00);
    if(common_scripts\utility::func_562E(self.transport_inactive)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_00.ontransportcooldown)) {
      continue;
    }

    if(common_scripts\utility::func_562E(self.var_65DC.is_in_blood_tube_cooldown)) {
      continue;
    }

    if(common_scripts\utility::func_562E(self.transport_in_use)) {
      continue;
    }

    if(!common_scripts\utility::func_562E(var_00.hitchingaride)) {
      if(!var_00 istouching(self.use_trig)) {
        continue;
      }

      if(!var_00 maps\mp\gametypes\zombies::func_11C2(level.bloodtubecost, 0, 0, 1)) {
        continue;
      }
    }

    if(!common_scripts\utility::func_562E(var_00.hasenteredbonustrial) && !isDefined(var_00.forcedblooddest)) {
      if(!lib_055A::func_5780("zone_sewers") && var_00 maps\mp\gametypes\zombies::func_1F32(6666, 1)) {
        var_00.forcedblooddest = "zom_bonus_trial_destination";
        var_00.hasenteredbonustrial = 1;
        var_00.inasneakyplace = 1;
        var_00 thread bonus_tube_slow_cash_bleed();
      }
    }

    level notify("blood_tube_valid_use");
  }
}

bonus_tube_slow_cash_bleed() {
  self endon("disconnect");
  self endon("death");
  var_00 = self.var_62D6;
  var_01 = self.var_62D6 - 6666;
  while(self.var_62D6 > var_01) {
    var_02 = 100;
    if(self.var_62D6 - var_02 < var_01) {
      var_02 = self.var_62D6 - var_01;
    }

    if(self.var_62D6 - var_02 <= 0) {
      self.var_62D6 = var_02;
    }

    maps\mp\gametypes\zombies::func_90F5(var_02, 0);
    if(self.var_62D6 <= 0) {
      break;
    }

    wait 0.05;
  }
}