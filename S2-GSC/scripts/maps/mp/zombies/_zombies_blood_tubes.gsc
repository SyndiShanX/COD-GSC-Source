/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_blood_tubes.gsc
************************************************************/

init() {
  _precacherumble("damage_heavy");
  link_teleporters("bt_limbo_entrance_2", "zone_crash", "bt_archives_entrance_1", "zone_archives_closet");
  link_teleporters("bt_archives_entrance_1", "zone_archives_closet", "bt_alter_entrance_1", "zone_alter");
  link_teleporters("bt_alter_entrance_1", "zone_alter", "bt_limbo_entrance_2", "zone_crash");
  link_teleporters("bt_gallery_entrance_1", "zone_bridge", "bt_limbo_entrance_2", "zone_crash");
  link_teleporters("bt_gluttony_entrance_1", "zone_cave", "bt_citadel_entrance_1", "zone_citadel");
  link_teleporters("bt_citadel_entrance_1", "zone_citadel", "bt_gluttony_entrance_1", "zone_cave");
  level.bloodtubecost = 250;
  level.nextcorpseeaterpunishment = 2;
  level.totaltrips = 0;
  var_0 = getEntArray("struct_bt_main", "targetname");
  common_scripts\utility::_id_0FB2(var_0, ::run_my_teleporter);
  level thread handle_blood_tube_upgrade_overrides();
}

should_execute_corpse_eater_punishment() {
  return level.totaltrips >= level.nextcorpseeaterpunishment;
}

execute_next_corpse_eater_punishment(var_0) {
  set_next_corpse_eater_goal();

  if(_id_0547::_id_4090("zombie_dlc4").size == 0) {
    for(var_1 = 0; var_1 < 2; var_1++) {
      var_2 = _id_054D::_id_90BA("zombie_dlc4", undefined, "corpse_eater", 1, 1, 0);
    }
  }
}

set_next_corpse_eater_goal() {
  level.nextcorpseeaterpunishment = level.totaltrips + 2;
}

handle_blood_tube_upgrade_overrides() {
  var_0 = [];
  var_0[0] = init_pap_button("zmb_upgrade_stone_a");

  foreach(var_2 in var_0) {
    level thread handle_pap_button(var_2);
  }
}

handle_pap_button(var_0) {
  var_1 = var_0.stone.origin;
  var_2 = var_0.stone.origin - 2 * vectorNormalize(anglesToForward(var_0.stone.angles));

  for(;;) {
    var_0._id_9D65 waittill("trigger", var_3);
    var_0.stone moveTo(var_2, 0.5, 0, 0.1);
    _id_0378::_id_8D74("aud_deathraven_button", var_0.stone);
    level.papoverridden = 1;
    wait 0.5;
    var_0.stone setModel("zmf_blood_tube_brick_01_glow");
    var_0._id_9D65 waittill("trigger", var_3);
    var_0.stone moveTo(var_1, 0.5, 0, 0.1);
    _id_0378::_id_8D74("aud_deathraven_button", var_0.stone);
    level.papoverridden = 0;
    wait 0.5;
    var_0.stone setModel("zmf_blood_tube_brick_01");
  }
}

init_pap_button(var_0) {
  var_1 = common_scripts\utility::_id_44BE(var_0, "script_noteworthy");
  var_2 = spawnStruct();

  foreach(var_4 in var_1) {
    switch (var_4.targetname) {
      case "zmb_upgrade_stone_trig":
        var_2._id_9D65 = var_4;
        break;
      case "zmb_upgrade_stone":
        var_2.stone = var_4;
        break;
      case "zmb_upgrade_stone_dest":
        var_2.stone_dest = var_4;
        break;
    }
  }

  return var_2;
}

run_my_teleporter() {
  tube_setup();

  while(!level._id_AC80._id_ACB3[level.blood_tube_links[self.weaponlocktargettooclose][1]]._id_556E || !level._id_AC80._id_ACB3[level.blood_tube_links[self.weaponlocktargettooclose][3]]._id_556E) {
    waitframe();
  }

  if(isDefined(self.setlookatent) && self.setlookatent == "boss_tube_enter") {
    thread boss_tube_wait_for_interact();
  } else if(self.weaponlocktargettooclose == "bt_gallery_entrance_1") {
    thread bonus_tube_wait_for_interact();
  } else {
    thread tube_wait_for_interact();
  }

  if(self.weaponlocktargettooclose == "bt_gallery_entrance_1") {
    thread tube_transport_logic("flag_bonus_plates_filled");
  } else {
    thread tube_transport_logic();
  }

  thread toggle_tubes_for_boss_fight();
}

tube_setup() {
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    switch (var_2._id_0165) {
      case "bt_blood_fill":
        self.blood_fill = var_2;
        self.blood_fill._id_A796 = 3;
        self.blood_fill._id_9269 = var_2.origin;
        break;
      case "bt_water":
        self.blood_fill_water = var_2;
        self.blood_fill_water._id_9269 = self.origin;
        break;
      case "bt_waterlevel":
        self.blood_fill_waterlevel = var_2;
        self.blood_fill_waterlevel._id_9269 = self.origin;
        break;
      case "trig_bt_interact":
        self.use_trig = var_2;
        break;
      case "bt_door_l":
        self.door_l = var_2;
        break;
      case "bt_door_r":
        self.door_r = var_2;
        break;
      case "door_l_pivot":
        self.door_l_pivot = var_2;
        self.door_l_pivot.initialangles = self.door_l_pivot.angles;
        self.door_l._id_241F = _getEnt(self.door_l_pivot.target, "targetname");
        self.door_l._id_241F._id_A045 = ::transport_unresolved_collide;
        self.door_l._id_241F._id_206B = self;
        self.door_l._id_241F linktosynchronizedparent(self.door_l_pivot);
        break;
      case "door_r_pivot":
        self.door_r_pivot = var_2;
        self.door_r_pivot.initialangles = self.door_r_pivot.angles;
        self.door_r._id_241F = _getEnt(self.door_r_pivot.target, "targetname");
        self.door_r._id_241F._id_A045 = ::transport_unresolved_collide;
        self.door_r._id_241F._id_206B = self;
        self.door_r._id_241F linktosynchronizedparent(self.door_r_pivot);
        break;
      case "bt_navmesh_clip":
        self.navmesh_clip = var_2;
        break;
      case "bt_spawn":
        if(!isDefined(self.blood_spawns)) {
          self.blood_spawns = [];
        }

        self.blood_spawns[self.blood_spawns.size] = var_2;
        break;
      default:
        break;
    }
  }

  self.door_l linktosynchronizedparent(self.door_l_pivot);
  self.door_r linktosynchronizedparent(self.door_r_pivot);
  self.transport_inactive = 1;
}

transport_unresolved_collide(var_0) {
  self._id_A048 = [self._id_206B];
  _id_0488::_id_A047(var_0, 0);
}

tube_wait_for_interact() {
  var_0 = level.bloodtubecost;
  thread tube_cost_reset(var_0);

  if(!isDefined(level.zmb_blood_tubes)) {
    level.zmb_blood_tubes = [];
  }

  level.zmb_blood_tubes[level.zmb_blood_tubes.size] = self;

  for(;;) {
    self.use_trig waittill("trigger", var_1);

    if(common_scripts\utility::_id_562E(self._id_65DC.is_in_blood_tube_cooldown)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(self.transport_in_use)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(self.transport_inactive)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_1.ontransportcooldown)) {
      continue;
    }
    if(!common_scripts\utility::_id_562E(var_1.hitchingaride)) {
      if(!var_1 istouching(self.use_trig)) {
        continue;
      }
      if(!var_1 maps\mp\gametypes\zombies::_id_11C2(level.bloodtubecost, 0, 0, 1)) {
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

tube_transport_logic(var_0) {
  var_1 = self;
  var_2 = level.blood_tube_links[var_1.weaponlocktargettooclose][2];
  var_3 = var_1.blood_fill._id_A796;

  if(isDefined(var_0)) {
    common_scripts\utility::_id_3C9F(var_0);
  }

  var_1 transport_open();
  var_1 thread transport_activate();

  for(;;) {
    level waittill("blood_tube_valid_use");
    var_4 = level._id_A980;

    if(is_boss_tube_short_circut()) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_2.transport_inactive)) {
      var_2 thread transport_close();
    }

    var_1 transport_deactivate();
    var_1 transport_close();
    var_5 = [];
    var_6 = get_players_departing(var_1);
    var_7 = get_zombies_departing(var_1);

    foreach(var_9 in var_7) {
      if(var_6.size == 0 && var_7.size == 1 && _id_0547::_id_5565(var_9._id_0A4B, "zombie_heavy")) {
        level notify("wustlinground_trip");
      }

      common_scripts\utility::flag_set(var_9._id_0A4B + "_trophy_event_3");

      if(isDefined(var_9.ismooncontrolled)) {
        var_9.stall_mc_death = 1;
      }
    }

    foreach(var_12 in var_6) {
      var_12._id_480F = 1;
      var_12.isbloodtubemoonorbblocked = 1;
      var_12.lastdepartdoor = var_1;
    }

    var_5 = common_scripts\utility::_id_0F73(var_6, var_7);
    level thread play_blood_vision_for_players(var_6, var_1);

    foreach(var_12 in var_6) {
      var_12 thread handle_players_with_uber();
      var_12 childthread do_transport_rumble(2, 1);
      var_12 thread run_blood_intro(self.blood_fill_waterlevel._id_9269, var_1.origin);
    }

    wait 2;
    wait(var_3);

    if(isDefined(var_1.weaponlocktargettooclose) && var_1.weaponlocktargettooclose != "bt_gallery_entrance_1" && var_1.weaponlocktargettooclose != "bt_gluttony_entrance_1") {
      maps\mp\mp_zombie_descent_ee_side::dark_passenger_test(var_5);
    }

    send_players_to_destination_location(var_5, var_1);

    foreach(var_9 in var_7) {
      if(isDefined(var_9.ismooncontrolled) && var_9.ismooncontrolled == 1 && (!isDefined(var_9.isdarkhost) || var_9.isdarkhost != 1)) {
        var_9.stall_mc_death = 0;
      }
    }

    foreach(var_12 in get_players_departing(var_2)) {
      var_12 thread do_transport_rumble(2.5, 0);
    }

    wait 1;
    level notify("blood_tube_players_teleported");

    if(common_scripts\utility::_id_562E(var_2.transport_inactive)) {
      var_2 thread transport_open();
    }

    level thread remove_godmode_for_players(var_6);

    foreach(var_12 in get_players_departing(var_2)) {
      _id_0547::playfxclient("zmb_desc_screen_fx_exit_bloody", var_2.origin, var_12, 5);
    }

    var_1 transport_open();

    foreach(var_23 in var_5) {
      if(isPlayer(var_23)) {
        var_23 thread maps\mp\mp_zombie_descent_utils::vo_blood_tube_exit();
      }
    }

    level notify("blood_tube_transport_complete");

    if(common_scripts\utility::_id_562E(var_2.transport_inactive)) {
      var_2 thread inactive_tube_attempt_to_close();
    }

    var_1 transport_activate();
  }
}

is_boss_tube_short_circut() {
  if(isDefined(self.setlookatent) && self.setlookatent == "boss_tube_enter" && !common_scripts\utility::_id_3C77("flag_boss_arena_teleport_began")) {
    return 1;
  }

  if(_id_0547::_id_5565(self.weaponlocktargettooclose, "bt_citadel_entrance_1") && !common_scripts\utility::_id_3C77("flag_boss_arena_teleport_began")) {
    return 1;
  }

  return 0;
}

handle_players_with_uber() {
  if(common_scripts\utility::_id_562E(self._id_56A5)) {
    self notify("uber_lost", "uber_deposited");
    level waittill("blood_tube_players_teleported");
    thread _id_0585::_id_8555("stormraven_uber");
    level notify("player grabbed uber battery");
    thread _id_0585::_id_3481("stormraven_uber");
  }
}

remove_godmode_for_players(var_0) {
  wait 2;

  foreach(var_2 in var_0) {
    var_2._id_480F = 0;
    var_2.isbloodtubemoonorbblocked = undefined;
  }
}

run_blood_intro(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");
  _id_0547::playfxclient("zmb_desc_bloodtube_drip_01", var_0, var_2, 5);
  wait 2.0;
  _id_0547::playfxclient("zmb_desc_bloodtube_screen", var_1, var_2, 7);
  _id_0378::_id_8D74("aud_blood_tube_engulf", var_1);
  wait 5;
  playFX(level._effect["zmb_desc_bloodtube_drip_exit"], var_1);
}

do_transport_rumble(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");
  var_2 notify("new_transport_rumble");
  var_2 endon("new_transport_rumble");
  var_3 = gettime();
  var_2 disableweapons();

  while(gettime() - var_3 < var_0 * 1000) {
    wait(_randomfloat(0.4) + 0.7);
    var_2 playRumbleOnEntity("damage_heavy");
  }

  if(common_scripts\utility::_id_562E(var_2.isdarkpassenger)) {
    var_1 = 1;
  }

  if(_id_0547::_id_5565(var_2.isintrial, "zom_dlc4_scythe_zm")) {
    var_1 = 1;
  }

  if(!var_1) {
    var_2 enableweapons();
  }
}

delete_fxs_delay(var_0) {
  _id_0547::_id_A6F6();

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

tube_do_transport(var_0, var_1, var_2) {
  if(isPlayer(self)) {
    self endon("disconnect");
    self.ontransportcooldown = 1;
  }

  if(!isDefined(level.num_unique_destinations)) {
    level.num_unique_destinations = 0;
  }

  if(!has_objective_destination() && !common_scripts\utility::_id_562E(self.tryingtoleavepap) && is_passenger_pap_valid(var_1)) {
    try_to_reroute_to_upgrade_machine_room(var_0, var_1);
  }

  self.tryingtoleavepap = 0;
  var_1 = check_for_quest_detour(var_1);
  thread handle_blood_vision(var_1);

  if(!isDefined(var_1.blood_spawns)) {
    var_1.blood_spawns = common_scripts\utility::_id_46B7(var_1.target, "targetname");
  }

  if(var_2 >= var_1.blood_spawns.size) {
    var_2 = randomint(var_1.blood_spawns.size);
  }

  if(isPlayer(self)) {
    var_3 = 0;

    while(common_scripts\utility::_id_562E(self._id_57AB) || common_scripts\utility::_id_562E(self._id_172C)) {
      var_3 = 1;
      waitframe();
    }

    if(common_scripts\utility::_id_562E(var_3)) {
      do_transport_rumble(0, 0);
    }
  }

  self setOrigin(var_1.blood_spawns[var_2].origin);

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

  _id_0378::_id_8D74("aud_blood_tube_splash", var_1.blood_spawns[var_2].origin);

  if(isPlayer(self) && isDefined(var_1.blood_spawns[var_2].angles)) {
    self setplayerangles(var_1.blood_spawns[var_2].angles);
  }

  self.ontransportcooldown = 0;
}

is_passenger_pap_valid(var_0) {
  if(common_scripts\utility::_id_562E(self.isdarkpassenger) || common_scripts\utility::_id_562E(self.isdarkhost)) {
    return 0;
  }

  if(maps\mp\mp_zombie_descent_ee_side::playerinsewers()) {
    return 0;
  }

  if(_id_0547::_id_5565(var_0.weaponlocktargettooclose, "bt_citadel_entrance_1") && !common_scripts\utility::_id_3C77("flag_boss_fight_start")) {
    return 0;
  }

  return 1;
}

try_to_reroute_to_upgrade_machine_room(var_0, var_1) {
  if(common_scripts\utility::_id_562E(level.papoverridden)) {
    if(!isDefined(var_1.hasbeentraveledto)) {
      var_1.hasbeentraveledto = 1;
      set_next_pap_unlock_flag();
    }

    maps\mp\mp_zombie_descent_ee_main::set_weapon_upgrade_blood_tube_route("zom_pap_trial_destination");
  }
}

play_blood_vision_for_players(var_0, var_1) {
  var_2 = self;

  foreach(var_2 in var_0) {
    var_2 thread handle_blood_vision(var_1);
    var_2 _id_0378::_id_8D74("aud_blood_tube_filling_up");
    var_2 thread maps\mp\mp_zombie_descent_utils::vo_blood_tube_enter();
  }
}

get_players_departing(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3 player_is_in_pod(var_0)) {
      var_1[var_1.size] = var_3;
      continue;
    }

    if(common_scripts\utility::_id_562E(var_3.hitchingaride)) {
      if(common_scripts\utility::_id_562E(var_3.tryingtoleavepap) && !_id_0547::_id_5565(var_3.lastdepartdoor, var_0)) {
        continue;
      }
      var_3.hitchingaride = 0;
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

player_is_in_pod(var_0) {
  var_1 = self;
  return var_1 istouching(var_0.use_trig);
}

get_zombies_departing(var_0) {
  var_1 = [];
  var_2 = get_all_zombies_include_mooncontrolled();

  foreach(var_4 in var_2) {
    if(var_4 istouching(var_0.use_trig)) {
      var_1[var_1.size] = var_4;
    }
  }

  return var_1;
}

get_all_zombies_include_mooncontrolled() {
  var_0 = [];
  var_1 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_000A) && var_3._id_000A == level._id_746E && !common_scripts\utility::_id_562E(var_3.ismooncontrolled)) {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

tube_cost_reset(var_0) {
  for(;;) {
    level waittill("zombie_wave_ended");
    level.bloodtubecost = var_0;
    level notify("blood_tube_cost_updated");
    set_next_corpse_eater_goal();
  }
}

inactive_tube_attempt_to_close() {
  self endon("transport_became_active");

  while(common_scripts\utility::_id_562E(self.transport_inactive)) {
    while(players_occupying_inactive_tube()) {
      waitframe();
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
  return common_scripts\utility::_id_562E(self.transport_inactive) && players_occupy_this_tube();
}

players_occupy_this_tube() {
  return num_players_in_tube() > 0;
}

num_players_in_tube() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_2 istouching(self.use_trig)) {
      var_0++;
    }
  }

  return var_0;
}

doors_fully_open() {
  return _id_0547::_id_5565(self.door_r_pivot.angles, self.door_r_pivot.initialangles + (0, -60, 0));
}

set_next_pap_unlock_flag() {
  if(!isDefined(level.num_unique_destinations)) {
    level.num_unique_destinations = 0;
  }

  level.num_unique_destinations++;
  var_0 = "pap_raise_" + level.num_unique_destinations;

  if(common_scripts\utility::_id_3C83(var_0)) {
    common_scripts\utility::flag_set(var_0);
  }
}

handle_blood_vision(var_0) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  self notify("set_blood_vision");
  self endon("set_blood_vision");

  if(!isDefined(self.eyes_below_water)) {
    self.eyes_below_water = 0;
  }

  while(_id_0547::_id_5565(var_0.doing_transport, 1)) {
    if(test_eyes_below_water(var_0.blood_fill_waterlevel)) {
      if(_id_0547::_id_5565(self.eyes_below_water, 0)) {
        self.eyes_below_water = 1;
        enable_blood_vision();
      }
    } else if(_id_0547::_id_5565(self.eyes_below_water, 1)) {
      self.eyes_below_water = 0;
      disable_blood_vision();
    }

    waitframe();
  }

  while(_id_0547::_id_5565(self.isdarkpassenger, 1)) {
    waitframe();
  }

  if(!_id_0547::_id_5565(var_0.doing_transport, 1) && !_id_0547::_id_5565(self.isdarkpassenger, 1)) {
    self.eyes_below_water = 0;
    disable_blood_vision();
  }
}

test_eyes_below_water(var_0) {
  if(self getEye()[2] < var_0.origin[2]) {
    return 1;
  }

  return 0;
}

enable_blood_vision() {
  if(!common_scripts\utility::_id_562E(level._id_22F0)) {
    self setclienttriggervisionset("mp_zombie_descent_underwater", 0.05);
    self lightsetoverrideenableforplayer("mp_zombie_descent_underwater", 0.05);
    self.vision_blood_active = 1;
  }
}

disable_blood_vision() {
  self setclienttriggervisionset("", 0.05);
  self lightsetoverridedisableforplayer(0.05);
  self.vision_blood_active = undefined;
}

check_for_quest_detour(var_0) {
  if(has_objective_destination()) {
    var_1 = common_scripts\utility::_id_46B5("zmb_trials_router", "targetname");
    var_2 = common_scripts\utility::_id_46B7(var_1.target, "targetname");

    foreach(var_4 in var_2) {
      if(_id_0547::_id_5565(var_4._id_0165, self.forcedblooddest)) {
        thread maps\mp\mp_zombie_descent_ee_main::run_weapon_ritual(var_4._id_0165, var_0);
        self.old_destination = var_0;
        var_0 = var_4;
        self.forcedblooddest = undefined;
        break;
      }
    }
  }

  return var_0;
}

has_objective_destination() {
  return isDefined(self.forcedblooddest);
}

transport_deactivate() {
  self.transport_in_use = 1;

  if(isDefined(self._id_65DC)) {
    self._id_65DC._id_6642 = 1;
    self._id_65DC._id_2F74 = 1;
  }
}

transport_activate() {
  self.transport_inactive = 0;
  self.transport_in_use = 0;
  self notify("transport_became_active");

  if(isDefined(self.use_trig)) {
    if(!isDefined(self._id_65DC)) {
      self._id_65DC = _id_0552::_id_7BE1(undefined, self.use_trig);
      self._id_65DC._id_4028 = _id_0552::_id_44FF("dlc4_tube_interact");
    }

    waitframe();

    if(common_scripts\utility::_id_3C77("flag_boss_complete")) {
      thread update_transport_prompt_think();
    } else if(!_id_0547::_id_5565(self.setlookatent, "boss_tube_enter") && !_id_0547::_id_5565(self.setlookatent, "boss_tube_exit")) {
      if(isDefined(self._id_65DC.first_activation)) {
        self._id_65DC.is_in_blood_tube_cooldown = 1;
        self._id_65DC._id_2F74 = 0;
        self._id_65DC._id_6642 = 1;
        self._id_65DC._id_401E = 0;
        self._id_65DC._id_4028 = _id_0552::_id_44FF("dlc4_tube_cooldown");
        var_0 = gettime();
        var_1 = 20;

        while(!some_one_hitching_a_ride() && (gettime() - var_0) / 1000 < var_1) {
          waitframe();
        }

        self._id_65DC.is_in_blood_tube_cooldown = 0;
        self._id_65DC._id_4028 = _id_0552::_id_44FF("dlc4_tube_interact");
      } else
        self._id_65DC.first_activation = 1;

      thread update_transport_prompt_think();
    }

    self._id_65DC._id_6642 = 1;
    self._id_65DC._id_2F74 = 0;
  }
}

update_transport_prompt_think() {
  self notify("update_transport_cost_think");
  self endon("update_transport_cost_think");

  for(;;) {
    self._id_65DC._id_401E = level.bloodtubecost;
    common_scripts\utility::_id_A70C(self, "transport_became_active", level, "blood_tube_cost_updated");
    waittillframeend;
  }
}

some_one_hitching_a_ride() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::_id_562E(var_1.hitchingaride)) {
      return 1;
    }
  }

  return 0;
}

transport_close(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = 3;
  self.door_r_pivot rotateTo(self.door_r_pivot.initialangles, var_1);
  self.door_l_pivot rotateTo(self.door_l_pivot.initialangles, var_1);
  _id_0378::_id_8D74("aud_blood_tube_door_close");
  wait(var_1);
  self.doing_transport = 1;

  if(!common_scripts\utility::_id_562E(var_0)) {}

  self.door_l._id_241F disconnectPaths();
  self.door_r._id_241F disconnectPaths();
}

transport_open(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = 1;
  self.door_l._id_241F connectpaths();
  self.door_r._id_241F connectpaths();

  if(!common_scripts\utility::_id_562E(var_0)) {
    wait(self.blood_fill._id_A796);
  }

  playFX(level._effect["zmb_desc_bloodtube_drip_exit"], self.door_l_pivot.origin);
  var_2 = 3;
  self.door_r_pivot rotateTo(self.door_r_pivot.initialangles + (0, -60, 0), var_2);
  self.door_l_pivot rotateTo(self.door_l_pivot.initialangles + (0, 60, 0), var_2);
  _id_0378::_id_8D74("aud_blood_tube_door_open");
  wait(var_2);
  self.doing_transport = 0;
}

link_teleporters(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.blood_tube_links)) {
    level.blood_tube_links = [];
  }

  var_4 = getEntArray("struct_bt_main", "targetname");

  if(!isDefined(level.blood_tube_links[var_0])) {
    level.blood_tube_links[var_0] = [];
  }

  if(!isDefined(level.blood_tube_links["defaults"])) {
    level.blood_tube_links["defaults"] = [];

    foreach(var_6 in var_4) {
      if(_id_0547::_id_5565(var_6.weaponlocktargettooclose, "bt_limbo_entrance_1")) {
        level.blood_tube_links["defaults"] = common_scripts\utility::_id_0F6F(level.blood_tube_links["defaults"], var_6);
      }
    }
  }

  foreach(var_9 in var_4) {
    if(_id_0547::_id_5565(var_9.weaponlocktargettooclose, var_0)) {
      level.blood_tube_links[var_0] = common_scripts\utility::_id_0F6F(level.blood_tube_links[var_0], var_9);
      level.blood_tube_links[var_0] = common_scripts\utility::_id_0F6F(level.blood_tube_links[var_0], var_1);
      var_10 = undefined;

      foreach(var_10 in var_4) {
        if(_id_0547::_id_5565(var_10.weaponlocktargettooclose, var_2)) {
          level.blood_tube_links[var_0] = common_scripts\utility::_id_0F6F(level.blood_tube_links[var_0], var_10);
          level.blood_tube_links[var_0] = common_scripts\utility::_id_0F6F(level.blood_tube_links[var_0], var_3);
        }
      }
    }
  }
}

enter_boss_tube_activate() {
  level._id_AC80._id_ACB3[level.blood_tube_links["bt_gluttony_entrance_1"][1]]._id_556E = 1;
  level._id_AC80._id_ACB3[level.blood_tube_links["bt_gluttony_entrance_1"][3]]._id_556E = 1;
}

boss_tube_wait_for_interact() {
  level endon("god_king_defeated");
  childthread boss_tube_toggle_hint();

  for(;;) {
    self.use_trig waittill("trigger", var_0);

    if(common_scripts\utility::_id_562E(self._id_65DC._id_2F74)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(self.transport_inactive)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_0.ontransportcooldown)) {
      continue;
    }
    var_1 = 0;

    foreach(var_3 in level.ravenweaponmanager) {
      if(isDefined(var_3._id_0117)) {
        var_1++;
      }
    }

    if(var_1 < level.players.size) {
      continue;
    }
    var_5 = 1;

    foreach(var_0 in level.players) {
      if(!var_0 istouching(self.use_trig)) {
        var_5 = 0;
        break;
      }
    }

    if(!var_5) {
      continue;
    }
    self._id_65DC._id_6642 = 1;
    self._id_65DC._id_2F74 = 1;
    common_scripts\utility::flag_set("flag_boss_arena_teleport_began");
    waitframe();
    level notify("blood_tube_boss_valid_use");
    level notify("blood_tube_valid_use");
    level waittill("blood_tube_players_teleported");
    common_scripts\utility::flag_set("flag_entered_boss_arena");
  }
}

boss_tube_toggle_hint() {
  level endon("blood_tube_boss_valid_use");

  for(;;) {
    var_0 = boss_tube_check_for_activation();

    if(!isDefined(self._id_65DC)) {
      self._id_65DC = _id_0552::_id_7BE1(undefined, self.use_trig);
      self._id_65DC._id_4028 = _id_0552::_id_44FF("dlc4_tube_interact");
    }

    if(var_0) {
      self._id_65DC._id_6642 = 1;
      self._id_65DC._id_2F74 = 0;
    } else {
      self._id_65DC._id_6642 = 1;
      self._id_65DC._id_2F74 = 1;
    }

    waitframe();
  }
}

boss_tube_check_for_activation() {
  var_0 = 0;

  foreach(var_2 in level.ravenweaponmanager) {
    if(isDefined(var_2._id_0117)) {
      var_0++;
    }
  }

  if(var_0 < level.players.size) {
    return 0;
  }

  foreach(var_5 in level.players) {
    if(!var_5 istouching(self.use_trig)) {
      return 0;
    }
  }

  return 1;
}

toggle_tubes_for_boss_fight() {
  common_scripts\utility::_id_3C9F("flag_boss_fight_start");
  self.oldinactivestate = self.transport_inactive;
  transport_deactivate();
  common_scripts\utility::_id_3C9F("flag_boss_complete");

  if(isDefined(self.oldinactivestate) && !self.oldinactivestate) {
    thread transport_activate();
  }

  if(_id_0547::_id_5565(self.setlookatent, "boss_tube_enter")) {
    tube_wait_for_interact();
  }
}

send_players_to_destination_location(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_2;

    if(var_3 > var_1.blood_spawns.size) {
      var_3 = 0;
    }

    var_0[var_2] thread tube_do_transport(var_1, level.blood_tube_links[self.weaponlocktargettooclose][2], var_3);
  }
}

bonus_tube_wait_for_interact() {
  level.zmb_bonus_blood_tube_trig = self.use_trig;
  common_scripts\utility::_id_3C9F("flag_bonus_plates_filled");

  for(;;) {
    self.use_trig waittill("trigger", var_0);

    if(common_scripts\utility::_id_562E(self.transport_inactive)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_0.ontransportcooldown)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(self._id_65DC.is_in_blood_tube_cooldown)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(self.transport_in_use)) {
      continue;
    }
    if(!common_scripts\utility::_id_562E(var_0.hitchingaride)) {
      if(!var_0 istouching(self.use_trig)) {
        continue;
      }
      if(!var_0 maps\mp\gametypes\zombies::_id_11C2(level.bloodtubecost, 0, 0, 1)) {
        continue;
      }
    }

    if(!common_scripts\utility::_id_562E(var_0.hasenteredbonustrial) && !isDefined(var_0.forcedblooddest)) {
      if(!_id_055A::_id_5780("zone_sewers") && var_0 maps\mp\gametypes\zombies::_id_1F32(6666, 1)) {
        var_0.forcedblooddest = "zom_bonus_trial_destination";
        var_0.hasenteredbonustrial = 1;
        var_0.inasneakyplace = 1;
        var_0 thread bonus_tube_slow_cash_bleed();
      }
    }

    level notify("blood_tube_valid_use");
  }
}

bonus_tube_slow_cash_bleed() {
  self endon("disconnect");
  self endon("death");
  var_0 = self._id_62D6;
  var_1 = self._id_62D6 - 6666;

  while(self._id_62D6 > var_1) {
    var_2 = 100;

    if(self._id_62D6 - var_2 < var_1) {
      var_2 = self._id_62D6 - var_1;
    }

    if(self._id_62D6 - var_2 <= 0) {
      self._id_62D6 = var_2;
    }

    maps\mp\gametypes\zombies::_id_90F5(var_2, 0);

    if(self._id_62D6 <= 0) {
      break;
    }

    waitframe();
  }
}