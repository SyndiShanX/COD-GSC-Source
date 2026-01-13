/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_coaster.gsc
*****************************************************/

init_coaster() {
  scripts\engine\utility::flag_init("coaster_active");
  var_0 = scripts\engine\utility::getstructarray("coaster", "script_noteworthy");
  level.coasterplayers = [];
  foreach(var_2 in var_0) {
    var_2 thread coaster_wait_for_power();
  }

  wait(5);
  var_4 = scripts\engine\utility::getstruct("ice_frost", "targetname");
  var_5 = getent(var_4.target, "targetname");
  var_5 thread freeze_players();
}

coaster_wait_for_power() {
  level.roller_coasters = [];
  level.coaster_start_path = getvehiclenode("coaster_start_node", "targetname");
  level.coaster_ondeck_path = getvehiclenode("coaster_transition_node", "targetname");
  level.roller_coasters[0] = spawnvehicle("park_roller_coaster_cart", "coaster", "cp_roller_coaster", level.coaster_start_path.origin, level.coaster_start_path.angles);
  level.roller_coasters[1] = spawnvehicle("park_roller_coaster_cart", "coaster", "cp_roller_coaster", level.coaster_ondeck_path.origin, level.coaster_ondeck_path.angles);
  var_0 = getEntArray("coaster_dmg_trig", "targetname");
  level.roller_coasters[0].dmg_trig = scripts\engine\utility::getclosest(level.roller_coasters[0].origin, var_0);
  level.roller_coasters[0].dmg_trig enablelinkto();
  level.roller_coasters[0].dmg_trig linkto(level.roller_coasters[0]);
  level.roller_coasters[1].dmg_trig = scripts\engine\utility::getclosest(level.roller_coasters[1].origin, var_0);
  level.roller_coasters[1].dmg_trig enablelinkto();
  level.roller_coasters[1].dmg_trig linkto(level.roller_coasters[1]);
  level thread coaster_dmg_trig_monitor(level.roller_coasters[1].dmg_trig);
  level thread coaster_dmg_trig_monitor(level.roller_coasters[0].dmg_trig);
  level.roller_coasters[0] attachpath(level.coaster_start_path);
  level.roller_coasters[1] attachpath(level.coaster_ondeck_path);
  var_1 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  level thread coaster_flow_manager();
  self.gates = getEntArray(self.target, "targetname");
  level thread coaster_usage_monitor(self);
  for(;;) {
    var_2 = "power_on";
    if(var_1) {
      var_2 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_2 != "power_off") {
      setomnvar("zm_coaster1_ent", level.roller_coasters[0]);
      setomnvar("zm_coaster2_ent", level.roller_coasters[1]);
      scripts\cp\cp_interaction::remove_from_current_interaction_list(self);
      self.powered_on = 1;
      open_gates();
      scripts\cp\cp_interaction::add_to_current_interaction_list(self);
      setomnvar("zombie_coasterInfo", 0);
      var_3 = ["announcer_polarpeaks_description", "announcer_polarpeaks_start"];
      level thread scripts\cp\cp_music_and_dialog::add_to_ambient_sound_queue(var_3, (-224, -2160, 720), 120, 120, 2250000, 100);
    } else {
      setomnvar("zombie_coasterInfo", -1);
      self.powered_on = 0;
      close_gates();
    }

    if(!var_1) {
      break;
    }
  }
}

turn_on_coaster_anims() {
  var_0 = getEntArray("coaster_ice_monster", "targetname");
  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "idle") {
      var_2 setscriptablepartstate("main", scripts\engine\utility::random(["idle1", "idle2"]));
      continue;
    }

    if(var_2.script_noteworthy == "stoke") {
      var_2 setscriptablepartstate("main", "stoke");
      continue;
    }

    if(var_2.script_noteworthy == "scare") {
      var_2 setscriptablepartstate("main", "scare1");
      continue;
    }

    if(var_2.script_noteworthy == "sit") {
      var_2 setscriptablepartstate("main", "sit");
    }
  }

  foreach(var_6, var_5 in level.players) {
    setomnvar("zm_coaster_hiscore_p" + var_6 + 1, 0);
    var_5.coaster_hi_score = 0;
    setomnvar("zm_coaster_pic_p" + int(var_5 getentitynumber() + 1), var_5.var_CFC4);
  }
}

open_gates() {
  foreach(var_1 in self.gates) {
    var_1 rotateto(var_1.script_angles, 1);
  }
}

close_gates() {
  foreach(var_1 in self.gates) {
    var_1 rotateto((0, 270, 0), 1);
  }
}

coaster_usage_monitor(var_0) {
  level.times_coaster_ridden = 0;
  while(!var_0.powered_on) {
    wait(0.05);
  }

  for(;;) {
    var_1 = level scripts\engine\utility::waittill_any_return("coaster_started", "regular_wave_starting", "event_wave_starting");
    if(var_1 == "coaster_started") {
      level.times_coaster_ridden++;
      if(level.times_coaster_ridden >= 2 || level.players.size == 1) {
        var_0.out_of_order = 1;
        var_0 close_gates();
        setomnvar("zombie_coasterInfo", -1);
      }

      continue;
    }

    level.times_coaster_ridden = 0;
    if(scripts\engine\utility::istrue(var_0.out_of_order)) {
      var_0.out_of_order = 0;
      var_0 open_gates();
      foreach(var_3 in level.players) {
        if(isDefined(var_3.last_interaction_point) && var_3.last_interaction_point == var_0) {
          var_3 thread scripts\cp\cp_interaction::refresh_interaction();
        }
      }
    }

    var_5 = getomnvar("zombie_coasterInfo");
    if(var_5 <= 0) {
      setomnvar("zombie_coasterInfo", 0);
    }
  }
}

coaster_flow_manager() {
  for(;;) {
    level waittill("coaster_started", var_0);
    var_0.riding = 1;
    wait(5);
    var_1 = undefined;
    foreach(var_3 in level.roller_coasters) {
      if(var_3 == var_0) {
        continue;
      } else {
        var_1 = var_3;
      }
    }

    if(isDefined(var_1.riding)) {
      var_1 waittill("ride_finished");
    }

    wait(1);
    var_1 attachpath(level.coaster_ondeck_path);
    var_1 startpath();
  }
}

start_coaster(var_0, var_1) {
  var_2 = 8;
  if(isDefined(var_1.linked_players)) {
    var_2 = 4 * var_1.linked_players;
  }

  level notify("coaster_started", var_1);
  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(var_2);
  var_1 attachpath(level.coaster_start_path);
  var_1 startpath();
  if(isDefined(var_1.linked_players)) {
    var_1 thread coaster_rumble_and_shake();
  }

  var_1 waittill("reached_end_node");
  if(isDefined(var_1.linked_players)) {
    var_1 unlink_players_from_coaster(var_1);
  }

  var_1 notify("ride_finished");
  var_1.riding = undefined;
  if(isDefined(var_1.linked_players)) {
    var_2 = 4 * var_1.linked_players;
  }

  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(var_2);
}

use_coaster(var_0, var_1) {
  if(!var_1 scripts\cp\utility::isteleportenabled()) {
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(scripts\engine\utility::istrue(var_1.coaster_ridden_this_round)) {
    var_1 scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_ZMB_INTERACTIONS_ALREADY_RIDDEN");
    wait(0.1);
    return;
  }

  if(var_1 secondaryoffhandbuttonpressed() || var_1 fragbuttonpressed()) {
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(scripts\engine\utility::istrue(var_1.isusingsupercard)) {
    var_1 notify("coaster_ride_beginning");
    wait(0.5);
  }

  var_1 scripts\cp\cp_damage::updatehitmarker("standard_cp");
  var_1 scripts\cp\powers\coop_powers::power_disablepower();
  var_1 scripts\cp\utility::allow_player_teleport(0);
  var_1.coaster_ridden_this_round = 1;
  level.wave_num_at_start_of_game = level.wave_num;
  var_2 = scripts\engine\utility::getclosest(var_0.origin, level.roller_coasters);
  if(!isDefined(var_2.linked_players)) {
    var_2.linked_players = 0;
  }

  var_2.linked_players++;
  if(var_2.linked_players >= 2) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  }

  scripts\cp\zombies\zombie_analytics::log_times_per_wave("coaster", var_1);
  if(!isDefined(var_0.ride_starting)) {
    var_0.ride_starting = 1;
    level thread ride_countdown(var_0, var_2);
  }

  var_1 thread coaster_ride_sfx();
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("coaster_ride", "zmb_comment_vo");
  level thread link_player_to_coaster(var_1, var_2);
}

coaster_ride_sfx() {
  self endon("ride_over");
  self endon("disconnect");
  self endon("last_stand");
  scripts\engine\utility::delaycall(3.76, ::playlocalsound, "scn_rollercoaster_plr_lr_01", self);
  var_0 = getvehiclenode(level.coaster_start_path.target, "targetname");
  for(;;) {
    var_0 waittill("trigger");
    if(isDefined(var_0.name)) {
      switch (var_0.name) {
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

    if(!isDefined(var_0.target)) {
      break;
    }

    var_0 = getvehiclenode(var_0.target, "targetname");
  }
}

ride_countdown(var_0, var_1) {
  wait(5);
  level thread track_ride_time(var_1);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  level thread coaster_begin_ride(var_0, var_1);
  var_1 thread coaster_path_logic();
}

track_ride_time(var_0) {
  var_0.elapsed_time = 0;
  var_0 endon("ride_finished");
  for(;;) {
    wait(1);
    var_0.elapsed_time++;
  }
}

coaster_begin_ride(var_0, var_1) {
  level thread start_coaster(var_0, var_1);
  var_0 close_gates();
  var_2 = undefined;
  foreach(var_4 in level.roller_coasters) {
    if(var_4 == var_1) {
      continue;
    } else {
      var_2 = var_4;
    }
  }

  if(isDefined(var_2.riding)) {
    for(var_6 = 25 + 86 - var_2.elapsed_time; var_6 > 0; var_6--) {
      if(!scripts\engine\utility::istrue(var_0.out_of_order)) {
        setomnvar("zombie_coasterInfo", var_6);
      } else {
        setomnvar("zombie_coasterInfo", -1);
      }

      wait(1);
    }
  } else {
    for(var_7 = 25; var_7 >= 0; var_7--) {
      if(!scripts\engine\utility::istrue(var_0.out_of_order)) {
        setomnvar("zombie_coasterInfo", var_7);
      } else {
        setomnvar("zombie_coasterInfo", -1);
      }

      wait(1);
    }
  }

  var_0.ride_starting = undefined;
  if(!scripts\engine\utility::istrue(var_0.out_of_order)) {
    var_0 open_gates();
    setomnvar("zombie_coasterInfo", 0);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

link_player_to_coaster(var_0, var_1) {
  var_2 = "tag_guy0" + var_1.linked_players;
  var_0 setplayerangles((0, 0, 0));
  var_0 playerlinktodelta(var_1, var_2, 0, 60, 60, 60, 15, 0);
  var_0 allowstand(0);
  var_0 allowprone(0);
  var_0 getnumownedagentsonteambytype(0);
  var_0 setclientomnvar("zombie_arcade_game_time", 1);
  var_0.linked_to_coaster = 1;
  var_0.disable_consumables = 1;
  var_0 scripts\cp\utility::allow_player_interactions(0);
  var_0.linked_coaster = var_1;
  var_0.seat = var_1.linked_players;
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0.pre_arcade_game_weapon = var_0 scripts\cp\zombies\arcade_game_utility::saveplayerpregameweapon(var_0);
  var_0 giveweapon("iw7_zm1coaster_zm");
  var_0 switchtoweapon("iw7_zm1coaster_zm");
  var_0 scripts\engine\utility::allow_weapon_switch(0);
  var_0 scripts\engine\utility::allow_usability(0);
  var_0 thread coaster_last_stand_monitor(var_0);
  var_0 thread coaster_infinite_ammo(var_0);
  if(var_1 == level.roller_coasters[0]) {
    setomnvar("zm_coaster_score_p" + var_0.seat + "_c1", 0);
  } else {
    setomnvar("zm_coaster_score_p" + var_0.seat + "_c2", 0);
  }

  scripts\engine\utility::waitframe();
  var_0 setclientomnvar("zombie_coaster_ticket_earned", -1);
  scripts\engine\utility::waitframe();
  var_0.targets_hit = 0;
  var_0.tickets_earned = 0;
  wait(5);
  var_0 scripts\cp\utility::setlowermessage("coaster", &"CP_ZMB_INTERACTIONS_COASTER_HINT", 4);
}

coaster_laststand_vos(var_0) {
  var_0 endon("disconnect");
  var_0 endon("game_ended");
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("laststand_coaster", "zmb_comment_vo");
}

coaster_last_stand_monitor(var_0) {
  var_0 endon("ride_over");
  var_0 endon("disconnect");
  var_0 waittill("last_stand");
  var_0 stoplocalsound("scn_rollercoaster_plr_lr_01");
  var_0 stoplocalsound("scn_rollercoaster_plr_lsrs_01");
  var_0 stoplocalsound("scn_rollercoaster_plr_lr_02");
  var_0 stoplocalsound("scn_rollercoaster_plr_lsrs_02");
  var_0 stoplocalsound("scn_rollercoaster_plr_lr_03");
  var_0 stoplocalsound("scn_rollercoaster_plr_lsrs_03");
  level thread coaster_laststand_vos(var_0);
  var_0 unlink();
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(4);
  var_1 = "coaster_exit" + var_0 getentitynumber();
  var_2 = scripts\engine\utility::getstruct(var_1, "targetname");
  var_0 setorigin(var_2.origin);
  var_0 setplayerangles(var_2.angles);
  var_0 allowstand(1);
  var_0 allowprone(1);
  var_0 getnumownedagentsonteambytype(1);
  var_0.linked_to_coaster = undefined;
  var_0.disable_consumables = undefined;
  if(!var_0 scripts\cp\utility::areinteractionsenabled()) {
    var_0 scripts\cp\utility::allow_player_interactions(1);
  }

  var_0.linked_coaster.linked_players--;
  if(var_0.linked_coaster.linked_players <= 0) {
    var_0.linked_coaster.linked_players = undefined;
  }

  var_0.linked_coaster = undefined;
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0 scripts\engine\utility::allow_weapon_switch(1);
  if(!var_0 scripts\engine\utility::isusabilityallowed()) {
    var_0 scripts\engine\utility::allow_usability(1);
  }

  var_0 setclientomnvar("zombie_coaster_ticket_earned", -1);
  var_0 setclientomnvar("zombie_arcade_game_time", -1);
  if(var_0 scripts\cp\utility::isignoremeenabled()) {
    var_0 scripts\cp\utility::allow_player_ignore_me(0);
  }

  if(!var_0 scripts\cp\utility::isteleportenabled()) {
    var_0 scripts\cp\utility::allow_player_teleport(1);
  }

  var_0 thread show_score_tally();
  var_0 notify("ride_over");
}

coaster_infinite_ammo(var_0) {
  var_0 endon("last_stand");
  var_0 endon("ride_over");
  for(;;) {
    var_0 waittill("weapon_fired");
    var_0 givemaxammo("iw7_zm1coaster_zm");
    var_0 setweaponammoclip("iw7_zm1coaster_zm", weaponclipsize("iw7_zm1coaster_zm"));
  }
}

unlink_players_from_coaster(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2.linked_to_coaster)) {
      continue;
    }

    if(!isDefined(var_2.linked_coaster) || var_2.linked_coaster != var_0) {
      continue;
    }

    var_3 = "coaster_exit" + var_2 getentitynumber();
    var_4 = scripts\engine\utility::getstruct(var_3, "targetname");
    var_2 setorigin(var_4.origin);
    var_2 setplayerangles(var_4.angles);
    var_2 unlink();
    var_2 allowstand(1);
    var_2 allowprone(1);
    var_2 getnumownedagentsonteambytype(1);
    var_2.linked_to_coaster = undefined;
    var_2.disable_consumables = undefined;
    if(!var_2 scripts\cp\utility::areinteractionsenabled()) {
      var_2 scripts\cp\utility::allow_player_interactions(1);
    }

    var_2.linked_coaster = undefined;
    var_2 setstance("stand");
    var_2 scripts\cp\powers\coop_powers::power_enablepower();
    var_2 scripts\engine\utility::allow_weapon_switch(1);
    if(!var_2 scripts\engine\utility::isusabilityallowed()) {
      var_2 scripts\engine\utility::allow_usability(1);
    }

    var_2 takeweapon("iw7_zm1coaster_zm");
    var_2 scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(var_2);
    var_2 setclientomnvar("zombie_coaster_ticket_earned", -1);
    var_2 setclientomnvar("zombie_arcade_game_time", -1);
    if(var_2 scripts\cp\utility::isignoremeenabled()) {
      var_2 scripts\cp\utility::allow_player_ignore_me(0);
    }

    if(!var_2 scripts\cp\utility::isteleportenabled()) {
      var_2 scripts\cp\utility::allow_player_teleport(1);
    }

    var_2 notify("ride_over");
  }

  var_0.linked_players = undefined;
}

coaster_rumble_and_shake() {
  self endon("ride_finished");
  level endon("game_ended");
  self.intro_drop_pod_quake_min = 0.1;
  self.intro_drop_pod_quake_max = 0.12;
  wait(15);
  for(;;) {
    var_0 = self.origin;
    earthquake(randomfloatrange(self.intro_drop_pod_quake_min, self.intro_drop_pod_quake_max), 2, var_0, 200);
    wait(randomfloatrange(0.25, 0.75));
  }
}

coaster_path_logic() {
  var_0 = getvehiclenode(level.coaster_start_path.target, "targetname");
  for(;;) {
    var_0 waittill("trigger");
    if(isDefined(var_0.script_noteworthy)) {
      switch (var_0.script_noteworthy) {
        case "open_door":
          level thread open_coaster_door(var_0);
          break;

        case "close_door":
          level thread close_coaster_door(var_0);
          break;

        case "score_tally":
          level thread show_player_score_tally(self);
          break;

        case "activate_targets":
          level notify("activate_" + var_0.script_label);
          break;

        case "spawn_coaster_group3":
        case "spawn_coaster_group2":
        case "spawn_coaster_group1":
        case "spawn_coaster_group0":
          level thread spawn_coaster_zombies(var_0.script_noteworthy, ::coaster_zombies_group, self);
          break;

        case "delete_laser":
          break;

        default:
          level thread spawn_targets(var_0.script_noteworthy, self);
          break;
      }
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_0 = getvehiclenode(var_0.target, "targetname");
  }
}

spawn_coaster_zombies(var_0, var_1, var_2) {
  if(!isDefined(var_2.linked_players) || var_2.linked_players == 0) {
    return;
  }

  var_3 = scripts\engine\utility::getstructarray(var_0, "targetname");
  var_4 = 0;
  if(var_2.linked_players == 1) {
    var_4 = 1;
  }

  foreach(var_0A, var_6 in var_3) {
    var_6.is_coaster_spawner = 1;
    for(;;) {
      var_7 = var_6 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("generic_zombie", 1);
      if(isDefined(var_7)) {
        break;
      }

      wait(0.05);
    }

    var_7.entered_playspace = 1;
    var_7.nocorpse = 1;
    var_7.health = 100;
    var_7.is_suicide_bomber = 1;
    var_7.should_play_transformation_anim = 0;
    var_7.is_reserved = 1;
    var_7.is_coaster_zombie = 1;
    var_7 setscriptablepartstate("eyes", "eye_glow_off");
    var_7 detachall();
    var_8 = ["park_clown_zombie", "park_clown_zombie_blue", "park_clown_zombie_green", "park_clown_zombie_orange", "park_clown_zombie_yellow"];
    var_9 = scripts\engine\utility::random(var_8);
    var_7 setModel(var_9);
    var_7 thread[[var_1]](var_2);
    var_7 thread delayed_death(15);
    if(var_4 && var_3.size > 2 && var_0A >= scripts\cp\utility::roundup(var_3.size * 0.65)) {
      return;
    }
  }
}

delayed_death(var_0) {
  self endon("death");
  wait(var_0);
  self dodamage(150, self.origin);
}

coaster_zombies_group(var_0) {
  self endon("death");
  thread explode_when_near_coaster(var_0);
  self.synctransients = "walk";
  self.moveratescale = 1;
  self.traverseratescale = 1;
  self.generalspeedratescale = 1;
  for(;;) {
    self setgoalentity(var_0);
    wait(0.1);
  }
}

explode_when_near_coaster(var_0) {
  self endon("death");
  var_1 = 0;
  var_2 = 21904;
  while(!var_1) {
    foreach(var_4 in level.players) {
      if(distancesquared(self.origin, var_4.origin) <= var_2) {
        var_1 = 1;
      }
    }

    if(var_1) {
      break;
    }

    wait(0.05);
  }

  foreach(var_4 in level.players) {
    if(!isDefined(var_4.linked_coaster) || var_4.linked_coaster != var_0) {
      continue;
    }

    if(var_4 scripts\cp\utility::has_zombie_perk("perk_machine_tough")) {
      var_4 dodamage(90, var_4.origin, self, self, "MOD_EXPLOSIVE");
      continue;
    }

    var_4 dodamage(45, var_4.origin, self, self, "MOD_EXPLOSIVE");
  }

  self dodamage(150, self.origin);
}

open_coaster_door(var_0) {
  switch (var_0.script_parameters) {
    case "coaster_door_1":
      level thread open_coaster_doors(var_0);
      break;

    case "coaster_door_2":
      level thread open_coaster_doors(var_0);
      break;

    case "coaster_door_3":
      level thread open_coaster_doors(var_0);
      level thread coaster_danger_zone(var_0);
      break;

    case "coaster_door_4":
      level thread open_coaster_doors(var_0);
      level thread open_coaster_arm_gates();
      level thread ice_frost();
      break;
  }
}

ice_frost() {
  var_0 = scripts\engine\utility::getstruct("ice_frost", "targetname");
  var_1 = spawnfx(level._effect["coaster_ice_frost"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  wait(0.1);
  triggerfx(var_1);
  wait(5);
  var_1 delete();
}

freeze_players() {
  var_0 = scripts\engine\utility::getstruct("ice_frost", "targetname");
  var_1 = spawnfx(level._effect["coaster_ice_frost"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  wait(1);
  triggerfx(var_1);
  for(;;) {
    self waittill("trigger", var_2);
    if(!scripts\cp\utility::should_be_affected_by_trap(var_2) && isDefined(var_2.scrnfx)) {
      continue;
    } else {
      var_2 thread chill_scrnfx();
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

close_coaster_door(var_0) {
  switch (var_0.script_parameters) {
    case "coaster_door_1":
      level thread close_coaster_doors(var_0);
      break;

    case "coaster_door_2":
      level thread close_coaster_doors(var_0);
      break;

    case "coaster_door_3":
      level thread close_coaster_doors(var_0);
      break;

    case "coaster_door_4":
      level thread close_coaster_doors(var_0);
      break;
  }
}

open_coaster_doors(var_0) {
  var_1 = getEntArray(var_0.script_parameters, "targetname");
  foreach(var_3 in var_1) {
    if(var_3.model == "zmb_triton_ice_door_r_01") {
      var_3 rotateyaw(-80, 1);
      continue;
    }

    var_3 rotateyaw(80, 1);
  }
}

close_coaster_doors(var_0) {
  var_1 = getEntArray(var_0.script_parameters, "targetname");
  foreach(var_3 in var_1) {
    if(var_3.model == "zmb_triton_ice_door_r_01") {
      var_3 rotateyaw(80, 1);
      continue;
    }

    var_3 rotateyaw(-80, 1);
  }
}

coaster_danger_zone(var_0) {
  var_1 = getEntArray(var_0.script_parameters, "targetname");
  earthquake(0.34, 5, var_1[0].origin, 500);
  var_2 = scripts\engine\utility::getstruct("coaster_rocks", "targetname");
  playFX(level._effect["coaster_rocks"], var_2.origin);
  for(;;) {
    wait(1.65);
    if(!isDefined(var_2.target)) {
      return;
    }

    var_2 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    earthquake(0.34, 3, var_2.origin + (0, 0, -200), 700);
    playFX(level._effect["coaster_rocks"], var_2.origin);
  }
}

open_coaster_arm_gates(var_0) {
  wait(2.5);
  var_1 = getent("coaster_door_4a", "targetname");
  var_2 = getent("coaster_door_4b", "targetname");
  var_1 rotateyaw(110, 0.5);
  wait(3.75);
  var_2 rotateyaw(-110, 0.5);
  wait(5);
  var_1 rotateyaw(-110, 0.5);
  wait(1);
  var_2 rotateyaw(110, 0.5);
}

spawn_targets(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray(var_0, "targetname");
  var_3 = [];
  foreach(var_6, var_5 in var_2) {
    var_3[var_6] = spawn("script_model", var_5.origin);
    var_3[var_6].angles = var_5.angles;
    var_3[var_6].struct = var_5;
    var_3[var_6] setModel(var_5.script_parameters);
    wait(0.1);
  }

  level waittill("activate_" + var_0);
  foreach(var_8 in var_3) {
    var_8 thread target_wait_for_damage();
    wait(0.15);
  }

  if(var_0 == "targets_group6") {
    level thread spawn_lasers(var_3, var_1);
  }

  level thread group_target_timeout(var_3);
}

spawn_lasers(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray("coaster_laser_fx_spot", "targetname");
  var_3 = getEntArray("coaster_laser_trigger", "targetname");
  foreach(var_5 in var_2) {
    var_6 = spawnfx(level._effect["coaster_laser"], var_5.origin, anglesToForward(var_5.angles), anglestoup(var_5.angles));
    scripts\engine\utility::waitframe();
    triggerfx(var_6);
    var_5.fx = var_6;
    var_5.trigger = scripts\engine\utility::getclosest(var_5.origin, var_3);
    level thread laser_timeout(var_5);
    level thread laser_damage_trigger_logic(var_5, var_1);
  }

  level thread laser_target_handler(var_2, var_0);
}

laser_timeout(var_0) {
  var_0.trigger endon("target_shot");
  wait(15);
  var_0.fx delete();
  var_0.trigger notify("target_shot");
}

laser_target_handler(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(isDefined(var_3.struct.script_noteworthy) && isDefined(var_3.struct.script_noteworthy == "laser_target")) {
      var_3 thread watch_laser_target_damage(var_0);
    }
  }
}

laser_damage_trigger_logic(var_0, var_1) {
  var_0.trigger endon("target_shot");
  for(;;) {
    var_0.trigger waittill("trigger", var_2);
    if(isplayer(var_2)) {
      break;
    }
  }

  foreach(var_4 in level.players) {
    if(!isDefined(var_4.linked_coaster) || var_4.linked_coaster != var_1) {
      continue;
    }

    if(var_4 scripts\cp\utility::has_zombie_perk("perk_machine_tough")) {
      var_4 dodamage(90, var_4.origin, var_0.trigger, var_0.trigger, "MOD_EXPLOSIVE");
    } else {
      var_4 dodamage(50, var_4.origin, var_0.trigger, var_0.trigger, "MOD_EXPLOSIVE");
    }

    var_4 shellshock("default", 1.25);
  }

  earthquake(0.3, 1, var_0.origin, 500);
  var_0.fx delete();
  var_0.trigger notify("target_shot");
}

watch_laser_target_damage(var_0) {
  var_1 = scripts\engine\utility::getclosest(self.origin, var_0);
  var_1.trigger endon("target_shot");
  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
    if(!isDefined(var_3) || !isDefined(var_0B) || !isDefined(var_3.linked_to_coaster)) {
      continue;
    }

    playFX(level._effect["coaster_laser_exp"], self.origin);
    var_1.fx delete();
    var_1.trigger notify("target_shot");
  }
}

target_wait_for_damage() {
  self endon("death");
  if(isDefined(self.struct.script_delay)) {
    wait(self.struct.script_delay);
  }

  self playSound("rollercoaster_sign_up");
  self.og_angles = self.angles;
  var_0 = scripts\engine\utility::getstruct(self.struct.target, "targetname");
  self rotateto(var_0.angles, 0.25);
  self.health = 999999;
  self setCanDamage(1);
  var_1 = 5;
  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
    if(!isDefined(var_3) || !isDefined(var_0B) || !isDefined(var_3.linked_to_coaster)) {
      continue;
    }

    self.health = 999999;
    if(var_0B == "iw7_zm1coaster_zm") {
      var_3 setclientomnvar("damage_feedback_kill", 1);
      var_3 setclientomnvar("damage_feedback_notify", gettime());
      var_3.targets_hit++;
      var_3.tickets_earned = var_3.targets_hit * var_1;
      scripts\engine\utility::waitframe();
      var_3 thread scripts\cp\cp_vo::try_to_play_vo("coaster_ride_shot", "zmb_comment_vo", "low", 10, 0, 0, 1, 10);
      var_0C = var_3.linked_coaster;
      if(var_0C == level.roller_coasters[0]) {
        setomnvar("zm_coaster_score_p" + var_3.seat + "_c1", var_3.targets_hit);
      } else {
        setomnvar("zm_coaster_score_p" + var_3.seat + "_c2", var_3.targets_hit);
      }

      if(!isDefined(var_3.coaster_hi_score)) {
        var_3.coaster_hi_score = 0;
      }

      if(var_3.targets_hit > var_3.coaster_hi_score) {
        setomnvar("zm_coaster_hiscore_p" + int(var_3 getentitynumber() + 1), var_3.targets_hit);
        var_3.coaster_hi_score = var_3.targets_hit;
      }

      var_3 notify("coaster_target_hit_notify");
      self playSound("rollercoaster_target_pings");
      self rotateto(self.og_angles, 0.25);
      return;
    }
  }
}

group_target_timeout(var_0) {
  wait(20);
  foreach(var_2 in var_0) {
    var_2 delete();
    scripts\engine\utility::waitframe();
  }
}

show_player_score_tally(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2.linked_coaster) && var_2.linked_coaster == var_0) {
      var_2 thread scripts\cp\cp_vo::try_to_play_vo("coaster_ride_sucess", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
      var_2 thread show_score_tally();
      var_2 thread coaster_end_announcer_vo();
    }
  }
}

show_score_tally() {
  var_0 = 0;
  for(var_1 = 0; var_1 < self.targets_hit; var_1++) {
    self playlocalsound("zmb_wheel_spin_tick");
    self setclientomnvar("zombie_coaster_ticket_earned", var_1 + 1 * 10);
    var_0++;
    wait(0.1);
  }

  self playlocalsound("zmb_ui_earn_tickets");
  wait(0.25);
  if(var_0 > 0 && !scripts\engine\utility::istrue(self.inlaststand)) {
    thread scripts\cp\cp_vo::try_to_play_vo("arcade_complete", "zmb_comment_vo", "low", 10, 0, 0, 0, 45);
    scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, self, level.wave_num_at_start_of_game, "coaster", 0, var_0, self.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["coaster"]);
  }

  scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(self);
  self setclientomnvar("zombie_coaster_ticket_earned", -1);
}

coaster_end_announcer_vo() {
  wait(2);
  self playlocalsound("announcer_polarpeaks_finish");
}

coaster_dmg_trig_monitor(var_0) {
  level endon("game_ended");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!scripts\cp\utility::should_be_affected_by_trap(var_1)) {
      continue;
    }

    var_1.marked_for_death = 1;
    var_1 dodamage(var_1.health + 50, var_0.origin);
  }
}