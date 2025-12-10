/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_coaster.gsc
*****************************************************/

init_coaster() {
  scripts\engine\utility::flag_init("coaster_active");
  var_00 = scripts\engine\utility::getstructarray("coaster", "script_noteworthy");
  level.coasterplayers = [];
  foreach(var_02 in var_00) {
    var_02 thread coaster_wait_for_power();
  }

  wait(5);
  var_04 = scripts\engine\utility::getstruct("ice_frost", "targetname");
  var_05 = getent(var_04.target, "targetname");
  var_05 thread freeze_players();
}

coaster_wait_for_power() {
  level.roller_coasters = [];
  level.coaster_start_path = getvehiclenode("coaster_start_node", "targetname");
  level.coaster_ondeck_path = getvehiclenode("coaster_transition_node", "targetname");
  level.roller_coasters[0] = spawnvehicle("park_roller_coaster_cart", "coaster", "cp_roller_coaster", level.coaster_start_path.origin, level.coaster_start_path.angles);
  level.roller_coasters[1] = spawnvehicle("park_roller_coaster_cart", "coaster", "cp_roller_coaster", level.coaster_ondeck_path.origin, level.coaster_ondeck_path.angles);
  var_00 = getEntArray("coaster_dmg_trig", "targetname");
  level.roller_coasters[0].dmg_trig = scripts\engine\utility::getclosest(level.roller_coasters[0].origin, var_00);
  level.roller_coasters[0].dmg_trig enablelinkto();
  level.roller_coasters[0].dmg_trig linkto(level.roller_coasters[0]);
  level.roller_coasters[1].dmg_trig = scripts\engine\utility::getclosest(level.roller_coasters[1].origin, var_00);
  level.roller_coasters[1].dmg_trig enablelinkto();
  level.roller_coasters[1].dmg_trig linkto(level.roller_coasters[1]);
  level thread coaster_dmg_trig_monitor(level.roller_coasters[1].dmg_trig);
  level thread coaster_dmg_trig_monitor(level.roller_coasters[0].dmg_trig);
  level.roller_coasters[0] attachpath(level.coaster_start_path);
  level.roller_coasters[1] attachpath(level.coaster_ondeck_path);
  var_01 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  level thread coaster_flow_manager();
  self.gates = getEntArray(self.target, "targetname");
  level thread coaster_usage_monitor(self);
  for(;;) {
    var_02 = "power_on";
    if(var_01) {
      var_02 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_02 != "power_off") {
      setomnvar("zm_coaster1_ent", level.roller_coasters[0]);
      setomnvar("zm_coaster2_ent", level.roller_coasters[1]);
      scripts\cp\cp_interaction::remove_from_current_interaction_list(self);
      self.powered_on = 1;
      open_gates();
      scripts\cp\cp_interaction::add_to_current_interaction_list(self);
      setomnvar("zombie_coasterInfo", 0);
      var_03 = ["announcer_polarpeaks_description", "announcer_polarpeaks_start"];
      level thread scripts\cp\cp_music_and_dialog::add_to_ambient_sound_queue(var_03, (-224, -2160, 720), 120, 120, 2250000, 100);
    } else {
      setomnvar("zombie_coasterInfo", -1);
      self.powered_on = 0;
      close_gates();
    }

    if(!var_01) {
      break;
    }
  }
}

turn_on_coaster_anims() {
  var_00 = getEntArray("coaster_ice_monster", "targetname");
  foreach(var_02 in var_00) {
    if(var_02.script_noteworthy == "idle") {
      var_02 setscriptablepartstate("main", scripts\engine\utility::random(["idle1", "idle2"]));
      continue;
    }

    if(var_02.script_noteworthy == "stoke") {
      var_02 setscriptablepartstate("main", "stoke");
      continue;
    }

    if(var_02.script_noteworthy == "scare") {
      var_02 setscriptablepartstate("main", "scare1");
      continue;
    }

    if(var_02.script_noteworthy == "sit") {
      var_02 setscriptablepartstate("main", "sit");
    }
  }

  foreach(var_06, var_05 in level.players) {
    setomnvar("zm_coaster_hiscore_p" + var_06 + 1, 0);
    var_05.coaster_hi_score = 0;
    setomnvar("zm_coaster_pic_p" + int(var_05 getentitynumber() + 1), var_05.var_CFC4);
  }
}

open_gates() {
  foreach(var_01 in self.gates) {
    var_01 rotateto(var_01.script_angles, 1);
  }
}

close_gates() {
  foreach(var_01 in self.gates) {
    var_01 rotateto((0, 270, 0), 1);
  }
}

coaster_usage_monitor(param_00) {
  level.times_coaster_ridden = 0;
  while(!param_00.powered_on) {
    wait(0.05);
  }

  for(;;) {
    var_01 = level scripts\engine\utility::waittill_any_return("coaster_started", "regular_wave_starting", "event_wave_starting");
    if(var_01 == "coaster_started") {
      level.times_coaster_ridden++;
      if(level.times_coaster_ridden >= 2 || level.players.size == 1) {
        param_00.out_of_order = 1;
        param_00 close_gates();
        setomnvar("zombie_coasterInfo", -1);
      }

      continue;
    }

    level.times_coaster_ridden = 0;
    if(scripts\engine\utility::istrue(param_00.out_of_order)) {
      param_00.out_of_order = 0;
      param_00 open_gates();
      foreach(var_03 in level.players) {
        if(isDefined(var_03.last_interaction_point) && var_03.last_interaction_point == param_00) {
          var_03 thread scripts\cp\cp_interaction::refresh_interaction();
        }
      }
    }

    var_05 = getomnvar("zombie_coasterInfo");
    if(var_05 <= 0) {
      setomnvar("zombie_coasterInfo", 0);
    }
  }
}

coaster_flow_manager() {
  for(;;) {
    level waittill("coaster_started", var_00);
    var_00.riding = 1;
    wait(5);
    var_01 = undefined;
    foreach(var_03 in level.roller_coasters) {
      if(var_03 == var_00) {
        continue;
      } else {
        var_01 = var_03;
      }
    }

    if(isDefined(var_01.riding)) {
      var_01 waittill("ride_finished");
    }

    wait(1);
    var_01 attachpath(level.coaster_ondeck_path);
    var_01 startpath();
  }
}

start_coaster(param_00, param_01) {
  var_02 = 8;
  if(isDefined(param_01.linked_players)) {
    var_02 = 4 * param_01.linked_players;
  }

  level notify("coaster_started", param_01);
  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(var_02);
  param_01 attachpath(level.coaster_start_path);
  param_01 startpath();
  if(isDefined(param_01.linked_players)) {
    param_01 thread coaster_rumble_and_shake();
  }

  param_01 waittill("reached_end_node");
  if(isDefined(param_01.linked_players)) {
    param_01 unlink_players_from_coaster(param_01);
  }

  param_01 notify("ride_finished");
  param_01.riding = undefined;
  if(isDefined(param_01.linked_players)) {
    var_02 = 4 * param_01.linked_players;
  }

  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(var_02);
}

use_coaster(param_00, param_01) {
  if(!param_01 scripts\cp\utility::isteleportenabled()) {
    param_01 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(scripts\engine\utility::istrue(param_01.coaster_ridden_this_round)) {
    param_01 scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"CP_ZMB_INTERACTIONS_ALREADY_RIDDEN");
    wait(0.1);
    return;
  }

  if(param_01 secondaryoffhandbuttonpressed() || param_01 fragbuttonpressed()) {
    param_01 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(scripts\engine\utility::istrue(param_01.isusingsupercard)) {
    param_01 notify("coaster_ride_beginning");
    wait(0.5);
  }

  param_01 scripts\cp\cp_damage::updatehitmarker("standard_cp");
  param_01 scripts\cp\powers\coop_powers::power_disablepower();
  param_01 scripts\cp\utility::allow_player_teleport(0);
  param_01.coaster_ridden_this_round = 1;
  level.wave_num_at_start_of_game = level.wave_num;
  var_02 = scripts\engine\utility::getclosest(param_00.origin, level.roller_coasters);
  if(!isDefined(var_02.linked_players)) {
    var_02.linked_players = 0;
  }

  var_02.linked_players++;
  if(var_02.linked_players >= 2) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  }

  scripts\cp\zombies\zombie_analytics::log_times_per_wave("coaster", param_01);
  if(!isDefined(param_00.ride_starting)) {
    param_00.ride_starting = 1;
    level thread ride_countdown(param_00, var_02);
  }

  param_01 thread coaster_ride_sfx();
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("coaster_ride", "zmb_comment_vo");
  level thread link_player_to_coaster(param_01, var_02);
}

coaster_ride_sfx() {
  self endon("ride_over");
  self endon("disconnect");
  self endon("last_stand");
  scripts\engine\utility::delaycall(3.76, ::playlocalsound, "scn_rollercoaster_plr_lr_01", self);
  var_00 = getvehiclenode(level.coaster_start_path.target, "targetname");
  for(;;) {
    var_00 waittill("trigger");
    if(isDefined(var_00.name)) {
      switch (var_00.name) {
        case "coaster_sound_2":
          self playlocalsound("scn_rollercoaster_plr_lr_02", self);
          break;

        case "coaster_sound_3":
          self playlocalsound("scn_rollercoaster_plr_lr_03", self);
          break;

        default:
          break;
      }
    }

    if(!isDefined(var_00.target)) {
      break;
    }

    var_00 = getvehiclenode(var_00.target, "targetname");
  }
}

ride_countdown(param_00, param_01) {
  wait(5);
  level thread track_ride_time(param_01);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  level thread coaster_begin_ride(param_00, param_01);
  param_01 thread coaster_path_logic();
}

track_ride_time(param_00) {
  param_00.elapsed_time = 0;
  param_00 endon("ride_finished");
  for(;;) {
    wait(1);
    param_00.elapsed_time++;
  }
}

coaster_begin_ride(param_00, param_01) {
  level thread start_coaster(param_00, param_01);
  param_00 close_gates();
  var_02 = undefined;
  foreach(var_04 in level.roller_coasters) {
    if(var_04 == param_01) {
      continue;
    } else {
      var_02 = var_04;
    }
  }

  if(isDefined(var_02.riding)) {
    for(var_06 = 25 + 86 - var_02.elapsed_time; var_06 > 0; var_06--) {
      if(!scripts\engine\utility::istrue(param_00.out_of_order)) {
        setomnvar("zombie_coasterInfo", var_06);
      } else {
        setomnvar("zombie_coasterInfo", -1);
      }

      wait(1);
    }
  } else {
    for(var_07 = 25; var_07 >= 0; var_07--) {
      if(!scripts\engine\utility::istrue(param_00.out_of_order)) {
        setomnvar("zombie_coasterInfo", var_07);
      } else {
        setomnvar("zombie_coasterInfo", -1);
      }

      wait(1);
    }
  }

  param_00.ride_starting = undefined;
  if(!scripts\engine\utility::istrue(param_00.out_of_order)) {
    param_00 open_gates();
    setomnvar("zombie_coasterInfo", 0);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

link_player_to_coaster(param_00, param_01) {
  var_02 = "tag_guy0" + param_01.linked_players;
  param_00 setplayerangles((0, 0, 0));
  param_00 playerlinktodelta(param_01, var_02, 0, 60, 60, 60, 15, 0);
  param_00 allowstand(0);
  param_00 allowprone(0);
  param_00 getnumownedagentsonteambytype(0);
  param_00 setclientomnvar("zombie_arcade_game_time", 1);
  param_00.linked_to_coaster = 1;
  param_00.disable_consumables = 1;
  param_00 scripts\cp\utility::allow_player_interactions(0);
  param_00.linked_coaster = param_01;
  param_00.seat = param_01.linked_players;
  param_00 scripts\cp\utility::allow_player_ignore_me(1);
  param_00.pre_arcade_game_weapon = param_00 scripts\cp\zombies\arcade_game_utility::saveplayerpregameweapon(param_00);
  param_00 giveweapon("iw7_zm1coaster_zm");
  param_00 switchtoweapon("iw7_zm1coaster_zm");
  param_00 scripts\engine\utility::allow_weapon_switch(0);
  param_00 scripts\engine\utility::allow_usability(0);
  param_00 thread coaster_last_stand_monitor(param_00);
  param_00 thread coaster_infinite_ammo(param_00);
  if(param_01 == level.roller_coasters[0]) {
    setomnvar("zm_coaster_score_p" + param_00.seat + "_c1", 0);
  } else {
    setomnvar("zm_coaster_score_p" + param_00.seat + "_c2", 0);
  }

  scripts\engine\utility::waitframe();
  param_00 setclientomnvar("zombie_coaster_ticket_earned", -1);
  scripts\engine\utility::waitframe();
  param_00.targets_hit = 0;
  param_00.tickets_earned = 0;
  wait(5);
  param_00 scripts\cp\utility::setlowermessage("coaster", &"CP_ZMB_INTERACTIONS_COASTER_HINT", 4);
}

coaster_laststand_vos(param_00) {
  param_00 endon("disconnect");
  param_00 endon("game_ended");
  param_00 thread scripts\cp\cp_vo::try_to_play_vo("laststand_coaster", "zmb_comment_vo");
}

coaster_last_stand_monitor(param_00) {
  param_00 endon("ride_over");
  param_00 endon("disconnect");
  param_00 waittill("last_stand");
  param_00 stoplocalsound("scn_rollercoaster_plr_lr_01");
  param_00 stoplocalsound("scn_rollercoaster_plr_lsrs_01");
  param_00 stoplocalsound("scn_rollercoaster_plr_lr_02");
  param_00 stoplocalsound("scn_rollercoaster_plr_lsrs_02");
  param_00 stoplocalsound("scn_rollercoaster_plr_lr_03");
  param_00 stoplocalsound("scn_rollercoaster_plr_lsrs_03");
  level thread coaster_laststand_vos(param_00);
  param_00 unlink();
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(4);
  var_01 = "coaster_exit" + param_00 getentitynumber();
  var_02 = scripts\engine\utility::getstruct(var_01, "targetname");
  param_00 setorigin(var_02.origin);
  param_00 setplayerangles(var_02.angles);
  param_00 allowstand(1);
  param_00 allowprone(1);
  param_00 getnumownedagentsonteambytype(1);
  param_00.linked_to_coaster = undefined;
  param_00.disable_consumables = undefined;
  if(!param_00 scripts\cp\utility::areinteractionsenabled()) {
    param_00 scripts\cp\utility::allow_player_interactions(1);
  }

  param_00.linked_coaster.linked_players--;
  if(param_00.linked_coaster.linked_players <= 0) {
    param_00.linked_coaster.linked_players = undefined;
  }

  param_00.linked_coaster = undefined;
  param_00 scripts\cp\powers\coop_powers::power_enablepower();
  param_00 scripts\engine\utility::allow_weapon_switch(1);
  if(!param_00 scripts\engine\utility::isusabilityallowed()) {
    param_00 scripts\engine\utility::allow_usability(1);
  }

  param_00 setclientomnvar("zombie_coaster_ticket_earned", -1);
  param_00 setclientomnvar("zombie_arcade_game_time", -1);
  if(param_00 scripts\cp\utility::isignoremeenabled()) {
    param_00 scripts\cp\utility::allow_player_ignore_me(0);
  }

  if(!param_00 scripts\cp\utility::isteleportenabled()) {
    param_00 scripts\cp\utility::allow_player_teleport(1);
  }

  param_00 thread show_score_tally();
  param_00 notify("ride_over");
}

coaster_infinite_ammo(param_00) {
  param_00 endon("last_stand");
  param_00 endon("ride_over");
  for(;;) {
    param_00 waittill("weapon_fired");
    param_00 givemaxammo("iw7_zm1coaster_zm");
    param_00 setweaponammoclip("iw7_zm1coaster_zm", weaponclipsize("iw7_zm1coaster_zm"));
  }
}

unlink_players_from_coaster(param_00) {
  foreach(var_02 in level.players) {
    if(!isDefined(var_02.linked_to_coaster)) {
      continue;
    }

    if(!isDefined(var_02.linked_coaster) || var_02.linked_coaster != param_00) {
      continue;
    }

    var_03 = "coaster_exit" + var_02 getentitynumber();
    var_04 = scripts\engine\utility::getstruct(var_03, "targetname");
    var_02 setorigin(var_04.origin);
    var_02 setplayerangles(var_04.angles);
    var_02 unlink();
    var_02 allowstand(1);
    var_02 allowprone(1);
    var_02 getnumownedagentsonteambytype(1);
    var_02.linked_to_coaster = undefined;
    var_02.disable_consumables = undefined;
    if(!var_02 scripts\cp\utility::areinteractionsenabled()) {
      var_02 scripts\cp\utility::allow_player_interactions(1);
    }

    var_02.linked_coaster = undefined;
    var_02 setstance("stand");
    var_02 scripts\cp\powers\coop_powers::power_enablepower();
    var_02 scripts\engine\utility::allow_weapon_switch(1);
    if(!var_02 scripts\engine\utility::isusabilityallowed()) {
      var_02 scripts\engine\utility::allow_usability(1);
    }

    var_02 takeweapon("iw7_zm1coaster_zm");
    var_02 scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(var_02);
    var_02 setclientomnvar("zombie_coaster_ticket_earned", -1);
    var_02 setclientomnvar("zombie_arcade_game_time", -1);
    if(var_02 scripts\cp\utility::isignoremeenabled()) {
      var_02 scripts\cp\utility::allow_player_ignore_me(0);
    }

    if(!var_02 scripts\cp\utility::isteleportenabled()) {
      var_02 scripts\cp\utility::allow_player_teleport(1);
    }

    var_02 notify("ride_over");
  }

  param_00.linked_players = undefined;
}

coaster_rumble_and_shake() {
  self endon("ride_finished");
  level endon("game_ended");
  self.intro_drop_pod_quake_min = 0.1;
  self.intro_drop_pod_quake_max = 0.12;
  wait(15);
  for(;;) {
    var_00 = self.origin;
    earthquake(randomfloatrange(self.intro_drop_pod_quake_min, self.intro_drop_pod_quake_max), 2, var_00, 200);
    wait(randomfloatrange(0.25, 0.75));
  }
}

coaster_path_logic() {
  var_00 = getvehiclenode(level.coaster_start_path.target, "targetname");
  for(;;) {
    var_00 waittill("trigger");
    if(isDefined(var_00.script_noteworthy)) {
      switch (var_00.script_noteworthy) {
        case "open_door":
          level thread open_coaster_door(var_00);
          break;

        case "close_door":
          level thread close_coaster_door(var_00);
          break;

        case "score_tally":
          level thread show_player_score_tally(self);
          break;

        case "activate_targets":
          level notify("activate_" + var_00.script_label);
          break;

        case "spawn_coaster_group3":
        case "spawn_coaster_group2":
        case "spawn_coaster_group1":
        case "spawn_coaster_group0":
          level thread spawn_coaster_zombies(var_00.script_noteworthy, ::coaster_zombies_group, self);
          break;

        case "delete_laser":
          break;

        default:
          level thread spawn_targets(var_00.script_noteworthy, self);
          break;
      }
    }

    if(!isDefined(var_00.target)) {
      break;
    }

    var_00 = getvehiclenode(var_00.target, "targetname");
  }
}

spawn_coaster_zombies(param_00, param_01, param_02) {
  if(!isDefined(param_02.linked_players) || param_02.linked_players == 0) {
    return;
  }

  var_03 = scripts\engine\utility::getstructarray(param_00, "targetname");
  var_04 = 0;
  if(param_02.linked_players == 1) {
    var_04 = 1;
  }

  foreach(var_0A, var_06 in var_03) {
    var_06.is_coaster_spawner = 1;
    for(;;) {
      var_07 = var_06 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("generic_zombie", 1);
      if(isDefined(var_07)) {
        break;
      }

      wait(0.05);
    }

    var_07.entered_playspace = 1;
    var_07.nocorpse = 1;
    var_07.health = 100;
    var_07.is_suicide_bomber = 1;
    var_07.should_play_transformation_anim = 0;
    var_07.is_reserved = 1;
    var_07.is_coaster_zombie = 1;
    var_07 setscriptablepartstate("eyes", "eye_glow_off");
    var_07 detachall();
    var_08 = ["park_clown_zombie", "park_clown_zombie_blue", "park_clown_zombie_green", "park_clown_zombie_orange", "park_clown_zombie_yellow"];
    var_09 = scripts\engine\utility::random(var_08);
    var_07 setModel(var_09);
    var_07 thread[[param_01]](param_02);
    var_07 thread delayed_death(15);
    if(var_04 && var_03.size > 2 && var_0A >= scripts\cp\utility::roundup(var_03.size * 0.65)) {
      return;
    }
  }
}

delayed_death(param_00) {
  self endon("death");
  wait(param_00);
  self dodamage(150, self.origin);
}

coaster_zombies_group(param_00) {
  self endon("death");
  thread explode_when_near_coaster(param_00);
  self.synctransients = "walk";
  self.moveratescale = 1;
  self.traverseratescale = 1;
  self.generalspeedratescale = 1;
  for(;;) {
    self setgoalentity(param_00);
    wait(0.1);
  }
}

explode_when_near_coaster(param_00) {
  self endon("death");
  var_01 = 0;
  var_02 = 21904;
  while(!var_01) {
    foreach(var_04 in level.players) {
      if(distancesquared(self.origin, var_04.origin) <= var_02) {
        var_01 = 1;
      }
    }

    if(var_01) {
      break;
    }

    wait(0.05);
  }

  foreach(var_04 in level.players) {
    if(!isDefined(var_04.linked_coaster) || var_04.linked_coaster != param_00) {
      continue;
    }

    if(var_04 scripts\cp\utility::has_zombie_perk("perk_machine_tough")) {
      var_04 dodamage(90, var_04.origin, self, self, "MOD_EXPLOSIVE");
      continue;
    }

    var_04 dodamage(45, var_04.origin, self, self, "MOD_EXPLOSIVE");
  }

  self dodamage(150, self.origin);
}

open_coaster_door(param_00) {
  switch (param_00.script_parameters) {
    case "coaster_door_1":
      level thread open_coaster_doors(param_00);
      break;

    case "coaster_door_2":
      level thread open_coaster_doors(param_00);
      break;

    case "coaster_door_3":
      level thread open_coaster_doors(param_00);
      level thread coaster_danger_zone(param_00);
      break;

    case "coaster_door_4":
      level thread open_coaster_doors(param_00);
      level thread open_coaster_arm_gates();
      level thread ice_frost();
      break;
  }
}

ice_frost() {
  var_00 = scripts\engine\utility::getstruct("ice_frost", "targetname");
  var_01 = spawnfx(level._effect["coaster_ice_frost"], var_00.origin, anglesToForward(var_00.angles), anglestoup(var_00.angles));
  wait(0.1);
  triggerfx(var_01);
  wait(5);
  var_01 delete();
}

freeze_players() {
  var_00 = scripts\engine\utility::getstruct("ice_frost", "targetname");
  var_01 = spawnfx(level._effect["coaster_ice_frost"], var_00.origin, anglesToForward(var_00.angles), anglestoup(var_00.angles));
  wait(1);
  triggerfx(var_01);
  for(;;) {
    self waittill("trigger", var_02);
    if(!scripts\cp\utility::should_be_affected_by_trap(var_02) && isDefined(var_02.scrnfx)) {
      continue;
    } else {
      var_02 thread chill_scrnfx();
    }
  }
}

chill_scrnfx() {
  self endon("disconnect");
  self.scrnfx = spawnfxforclient(level._effect["coaster_full_screen"], self getEye(), self);
  wait(0.1);
  triggerfx(self.scrnfx);
  scripts\engine\utility::waittill_any_timeout_1(5, "last_stand");
  self.scrnfx delete();
  self.scrnfx = undefined;
}

close_coaster_door(param_00) {
  switch (param_00.script_parameters) {
    case "coaster_door_1":
      level thread close_coaster_doors(param_00);
      break;

    case "coaster_door_2":
      level thread close_coaster_doors(param_00);
      break;

    case "coaster_door_3":
      level thread close_coaster_doors(param_00);
      break;

    case "coaster_door_4":
      level thread close_coaster_doors(param_00);
      break;
  }
}

open_coaster_doors(param_00) {
  var_01 = getEntArray(param_00.script_parameters, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.model == "zmb_triton_ice_door_r_01") {
      var_03 rotateyaw(-80, 1);
      continue;
    }

    var_03 rotateyaw(80, 1);
  }
}

close_coaster_doors(param_00) {
  var_01 = getEntArray(param_00.script_parameters, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.model == "zmb_triton_ice_door_r_01") {
      var_03 rotateyaw(80, 1);
      continue;
    }

    var_03 rotateyaw(-80, 1);
  }
}

coaster_danger_zone(param_00) {
  var_01 = getEntArray(param_00.script_parameters, "targetname");
  earthquake(0.34, 5, var_01[0].origin, 500);
  var_02 = scripts\engine\utility::getstruct("coaster_rocks", "targetname");
  playFX(level._effect["coaster_rocks"], var_02.origin);
  for(;;) {
    wait(1.65);
    if(!isDefined(var_02.target)) {
      return;
    }

    var_02 = scripts\engine\utility::getstruct(var_02.target, "targetname");
    earthquake(0.34, 3, var_02.origin + (0, 0, -200), 700);
    playFX(level._effect["coaster_rocks"], var_02.origin);
  }
}

open_coaster_arm_gates(param_00) {
  wait(2.5);
  var_01 = getent("coaster_door_4a", "targetname");
  var_02 = getent("coaster_door_4b", "targetname");
  var_01 rotateyaw(110, 0.5);
  wait(3.75);
  var_02 rotateyaw(-110, 0.5);
  wait(5);
  var_01 rotateyaw(-110, 0.5);
  wait(1);
  var_02 rotateyaw(110, 0.5);
}

spawn_targets(param_00, param_01) {
  var_02 = scripts\engine\utility::getstructarray(param_00, "targetname");
  var_03 = [];
  foreach(var_06, var_05 in var_02) {
    var_03[var_06] = spawn("script_model", var_05.origin);
    var_03[var_06].angles = var_05.angles;
    var_03[var_06].struct = var_05;
    var_03[var_06] setModel(var_05.script_parameters);
    wait(0.1);
  }

  level waittill("activate_" + param_00);
  foreach(var_08 in var_03) {
    var_08 thread target_wait_for_damage();
    wait(0.15);
  }

  if(param_00 == "targets_group6") {
    level thread spawn_lasers(var_03, param_01);
  }

  level thread group_target_timeout(var_03);
}

spawn_lasers(param_00, param_01) {
  var_02 = scripts\engine\utility::getstructarray("coaster_laser_fx_spot", "targetname");
  var_03 = getEntArray("coaster_laser_trigger", "targetname");
  foreach(var_05 in var_02) {
    var_06 = spawnfx(level._effect["coaster_laser"], var_05.origin, anglesToForward(var_05.angles), anglestoup(var_05.angles));
    scripts\engine\utility::waitframe();
    triggerfx(var_06);
    var_05.fx = var_06;
    var_05.trigger = scripts\engine\utility::getclosest(var_05.origin, var_03);
    level thread laser_timeout(var_05);
    level thread laser_damage_trigger_logic(var_05, param_01);
  }

  level thread laser_target_handler(var_02, param_00);
}

laser_timeout(param_00) {
  param_00.trigger endon("target_shot");
  wait(15);
  param_00.fx delete();
  param_00.trigger notify("target_shot");
}

laser_target_handler(param_00, param_01) {
  foreach(var_03 in param_01) {
    if(isDefined(var_03.struct.script_noteworthy) && isDefined(var_03.struct.script_noteworthy == "laser_target")) {
      var_03 thread watch_laser_target_damage(param_00);
    }
  }
}

laser_damage_trigger_logic(param_00, param_01) {
  param_00.trigger endon("target_shot");
  for(;;) {
    param_00.trigger waittill("trigger", var_02);
    if(isplayer(var_02)) {
      break;
    }
  }

  foreach(var_04 in level.players) {
    if(!isDefined(var_04.linked_coaster) || var_04.linked_coaster != param_01) {
      continue;
    }

    if(var_04 scripts\cp\utility::has_zombie_perk("perk_machine_tough")) {
      var_04 dodamage(90, var_04.origin, param_00.trigger, param_00.trigger, "MOD_EXPLOSIVE");
    } else {
      var_04 dodamage(50, var_04.origin, param_00.trigger, param_00.trigger, "MOD_EXPLOSIVE");
    }

    var_04 shellshock("default", 1.25);
  }

  earthquake(0.3, 1, param_00.origin, 500);
  param_00.fx delete();
  param_00.trigger notify("target_shot");
}

watch_laser_target_damage(param_00) {
  var_01 = scripts\engine\utility::getclosest(self.origin, param_00);
  var_01.trigger endon("target_shot");
  for(;;) {
    self waittill("damage", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    if(!isDefined(var_03) || !isDefined(var_0B) || !isDefined(var_03.linked_to_coaster)) {
      continue;
    }

    playFX(level._effect["coaster_laser_exp"], self.origin);
    var_01.fx delete();
    var_01.trigger notify("target_shot");
  }
}

target_wait_for_damage() {
  self endon("death");
  if(isDefined(self.struct.script_delay)) {
    wait(self.struct.script_delay);
  }

  self playSound("rollercoaster_sign_up");
  self.og_angles = self.angles;
  var_00 = scripts\engine\utility::getstruct(self.struct.target, "targetname");
  self rotateto(var_00.angles, 0.25);
  self.health = 999999;
  self setCanDamage(1);
  var_01 = 5;
  for(;;) {
    self waittill("damage", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    if(!isDefined(var_03) || !isDefined(var_0B) || !isDefined(var_03.linked_to_coaster)) {
      continue;
    }

    self.health = 999999;
    if(var_0B == "iw7_zm1coaster_zm") {
      var_03 setclientomnvar("damage_feedback_kill", 1);
      var_03 setclientomnvar("damage_feedback_notify", gettime());
      var_03.targets_hit++;
      var_03.tickets_earned = var_03.targets_hit * var_01;
      scripts\engine\utility::waitframe();
      var_03 thread scripts\cp\cp_vo::try_to_play_vo("coaster_ride_shot", "zmb_comment_vo", "low", 10, 0, 0, 1, 10);
      var_0C = var_03.linked_coaster;
      if(var_0C == level.roller_coasters[0]) {
        setomnvar("zm_coaster_score_p" + var_03.seat + "_c1", var_03.targets_hit);
      } else {
        setomnvar("zm_coaster_score_p" + var_03.seat + "_c2", var_03.targets_hit);
      }

      if(!isDefined(var_03.coaster_hi_score)) {
        var_03.coaster_hi_score = 0;
      }

      if(var_03.targets_hit > var_03.coaster_hi_score) {
        setomnvar("zm_coaster_hiscore_p" + int(var_03 getentitynumber() + 1), var_03.targets_hit);
        var_03.coaster_hi_score = var_03.targets_hit;
      }

      var_03 notify("coaster_target_hit_notify");
      self playSound("rollercoaster_target_pings");
      self rotateto(self.og_angles, 0.25);
      return;
    }
  }
}

group_target_timeout(param_00) {
  wait(20);
  foreach(var_02 in param_00) {
    var_02 delete();
    scripts\engine\utility::waitframe();
  }
}

show_player_score_tally(param_00) {
  foreach(var_02 in level.players) {
    if(isDefined(var_02.linked_coaster) && var_02.linked_coaster == param_00) {
      var_02 thread scripts\cp\cp_vo::try_to_play_vo("coaster_ride_sucess", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
      var_02 thread show_score_tally();
      var_02 thread coaster_end_announcer_vo();
    }
  }
}

show_score_tally() {
  var_00 = 0;
  for(var_01 = 0; var_01 < self.targets_hit; var_01++) {
    self playlocalsound("zmb_wheel_spin_tick");
    self setclientomnvar("zombie_coaster_ticket_earned", var_01 + 1 * 10);
    var_00++;
    wait(0.1);
  }

  self playlocalsound("zmb_ui_earn_tickets");
  wait(0.25);
  if(var_00 > 0 && !scripts\engine\utility::istrue(self.inlaststand)) {
    thread scripts\cp\cp_vo::try_to_play_vo("arcade_complete", "zmb_comment_vo", "low", 10, 0, 0, 0, 45);
    scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, self, level.wave_num_at_start_of_game, "coaster", 0, var_00, self.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["coaster"]);
  }

  scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(self);
  self setclientomnvar("zombie_coaster_ticket_earned", -1);
}

coaster_end_announcer_vo() {
  wait(2);
  self playlocalsound("announcer_polarpeaks_finish");
}

coaster_dmg_trig_monitor(param_00) {
  level endon("game_ended");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(!scripts\cp\utility::should_be_affected_by_trap(var_01)) {
      continue;
    }

    var_01.marked_for_death = 1;
    var_01 dodamage(var_01.health + 50, param_00.origin);
  }
}