/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_boat.gsc
****************************************************/

init_pap_boat() {
  level.meleevignetteanimfunc = ::zombie_boat_melee_func;
  level.boat_start_node = getvehiclenode("boat_start_struct", "targetname");
  level.boat_vehicle = spawnvehicle("cp_rave_pap_boat_animated", "boat", "cp_rave_boat", level.boat_start_node.origin, level.boat_start_node.angles);
  level.boat_vehicle attachpath(level.boat_start_node);
  level.boat_vehicle.linked_players = [];
  scripts\engine\utility::flag_init("packboat_started");
  scripts\engine\utility::flag_init("pap_fixed");
  scripts\engine\utility::flag_init("disable_portals");
  scripts\engine\utility::flag_init("fuses_inserted");
  scripts\engine\utility::flag_init("pap_portal_used");
  level.boat_vehicle setnonstick(0);
  level.boat_vehicle.attach_points = getEntArray(level.boat_start_node.target, "targetname");
  foreach(var_1 in level.boat_vehicle.attach_points) {
    var_1 linkto(level.boat_vehicle);
  }

  level.boat_vehicle hidepart("tag_motor");
  wait(1);
  level.boat_water_spawners = scripts\engine\utility::getstructarray("boat_water_spawners", "targetname");
}

activate_pap(var_0) {
  var_1 = level._effect["vfx_rave_pap_room_portal"];
  var_2 = scripts\engine\utility::getstruct("porta_effect_location", "targetname");
  var_2.script_noteworthy = "pap_portal";
  var_2.portal_can_be_started = 1;
  var_2.requires_power = 0;
  var_2.powered_on = 1;
  var_2.script_parameters = "default";
  var_2.custom_search_dist = 96;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
  level thread turn_on_room_exit_portal();
  var_3 = scripts\engine\utility::getstruct("projector_fx_struct", "targetname");
  var_4 = spawnfx(level._effect["projector_light"], var_3.origin, anglesToForward(var_3.angles), anglestoup(var_3.angles));
  var_5 = spawnfx(var_1, var_2.origin, anglesToForward(var_2.angles), anglestoup(var_2.angles));
  wait(0.5);
  triggerfx(var_4);
  scripts\engine\utility::delaythread(0.05, scripts\engine\utility::play_loopsound_in_space, "zmb_packapunch_machine_idle_lp", var_3.origin);
  wait(0.5);
  triggerfx(var_5);
  playsoundatpos(var_2.origin, "zmb_portal_powered_on_activate");
  scripts\engine\utility::delaythread(0.5, scripts\engine\utility::play_loopsound_in_space, "zmb_portal_powered_on_activate_lp", var_2.origin);
}

turn_on_room_exit_portal() {
  var_0 = getent("hidden_room_portal", "targetname");
  var_1 = anglesToForward(var_0.angles);
  var_2 = spawnfx(level._effect["vfx_slasher_cabin"], var_0.origin, var_1);
  thread scripts\engine\utility::play_loopsound_in_space("zmb_portal_powered_on_activate_lp", var_0.origin);
  triggerfx(var_2);
  teleport_from_hidden_room_before_time_up(var_0);
}

teleport_from_hidden_room_before_time_up(var_0) {
  var_0 makeusable();
  var_0 sethintstring(&"CP_RAVE_HIDDEN_LEAVE");
  var_0.portal_is_open = 1;
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isDefined(var_1.kicked_out)) {
      var_1 notify("left_hidden_room_early");
      var_1.disable_consumables = 1;
      hidden_room_exit_tube(var_1);
    }

    wait(0.1);
  }
}

pap_portal_hint_logic(var_0, var_1) {
  if(scripts\engine\utility::flag("disable_portals")) {
    return "";
  }

  if(isDefined(var_0.cooling_down)) {
    return &"COOP_INTERACTIONS_COOLDOWN";
  }

  return &"CP_RAVE_HIDDEN_TELEPORT";
}

pap_portal_use_func(var_0, var_1) {
  if(scripts\engine\utility::flag("disable_portals")) {
    return;
  }

  if(!var_1 scripts\cp\utility::isteleportenabled()) {
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  var_1 thread disable_teleportation(var_1, 0.5, "fast_travel_complete");
  var_0 thread travel_through_hidden_tube(var_1);
  var_0 thread pap_portal_cooldown(var_0);
}

pap_portal_cooldown(var_0) {
  if(scripts\engine\utility::istrue(var_0.in_cool_down)) {
    return;
  }

  var_0.in_cool_down = 1;
  wait(31);
  var_0.cooling_down = 1;
  wait(60);
  var_0.in_cool_down = undefined;
  var_0.cooling_down = undefined;
}

travel_through_hidden_tube(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 scripts\cp\powers\coop_powers::power_disablepower();
  var_0 notify("delete_equipment");
  var_0.disable_consumables = 1;
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_1 = move_through_tube(var_0, "hidden_travel_tube_start", "hidden_travel_tube_end");
  var_0 teleport_to_hidden_room();
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_1 delete();
}

teleport_to_hidden_room() {
  self endon("left_hidden_room_early");
  set_in_pap_room(self, 1);
  scripts\cp\utility::adddamagemodifier("papRoom", 0, 0);
  self.is_off_grid = 1;
  self.disable_consumables = undefined;
  var_0 = scripts\engine\utility::getstruct("hidden_room_spot", "targetname");
  self unlink();
  self dontinterpolate();
  scripts\cp\powers\coop_powers::power_enablepower();
  self setorigin(var_0.origin);
  self setplayerangles(var_0.angles);
  self playershow();
  thread hidden_room_timer();
  level notify("hidden_room_portal_used");
  scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(self);
}

pap_timer_start() {
  self endon("disconnect");
  if(!isDefined(self.pap_timer_running)) {
    self.pap_timer_running = 1;
    var_0 = 30;
    self setclientomnvar("zombie_papTimer", var_0);
    wait(1);
    for(;;) {
      var_0--;
      if(var_0 < 0) {
        var_0 = 30;
        wait(1);
        break;
      }

      self setclientomnvar("zombie_papTimer", var_0);
      wait(1);
    }

    self setclientomnvar("zombie_papTimer", -1);
    self notify("kicked_out");
    wait(30);
    self.pap_timer_running = undefined;
  }
}

hidden_room_exit_tube(var_0) {
  var_0 endon("disconnect");
  var_0 getrigindexfromarchetyperef();
  var_0 notify("delete_equipment");
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_1 = move_through_tube(var_0, "hidden_travel_tube_end", "hidden_travel_tube_start", 1);
  teleport_to_safe_spot(var_0);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_1 delete();
  if(scripts\engine\utility::istrue(var_0.wor_phase_shift)) {
    var_0 scripts\cp\powers\coop_phaseshift::exitphaseshift(1);
    var_0.wor_phase_shift = 0;
  }

  var_0 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  var_0.is_off_grid = undefined;
  var_0.kicked_out = undefined;
  var_0 set_in_pap_room(var_0, 0);
  var_0 notify("fast_travel_complete");
  scripts\cp\cp_vo::remove_from_nag_vo("ww_pap_nag");
  scripts\cp\cp_vo::remove_from_nag_vo("nag_find_pap");
}

set_in_pap_room(var_0, var_1) {
  var_0.is_in_pap = var_1;
}

teleport_to_safe_spot(var_0) {
  var_1 = scripts\engine\utility::getstructarray(scripts\engine\utility::getstruct("porta_effect_location", "targetname").target, "targetname");
  var_2 = undefined;
  while(!isDefined(var_2)) {
    foreach(var_4 in var_1) {
      if(!positionwouldtelefrag(var_4.origin)) {
        var_2 = var_4;
      }
    }

    if(!isDefined(var_2)) {
      var_6 = scripts\cp\utility::vec_multiply(anglesToForward(var_1[0].angles, 64));
      var_2 = var_1[0].origin + var_6;
    }

    wait(0.1);
  }

  var_0 playershow();
  var_0 unlink();
  var_0 dontinterpolate();
  var_0 setorigin(var_2.origin);
  var_0 setplayerangles(var_2.angles);
  var_0.disable_consumables = undefined;
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
}

hidden_room_timer() {
  self endon("left_hidden_room_early");
  self endon("disconnect");
  self endon("last_stand");
  self.kicked_out = undefined;
  if(!scripts\engine\utility::flag("pap_portal_used")) {
    scripts\engine\utility::flag_set("pap_portal_used");
  }

  thread pap_timer_start();
  level thread pap_vo(self);
  self waittill("kicked_out");
  self.kicked_out = 1;
  level thread hidden_room_exit_tube(self);
}

pap_vo(var_0) {
  if(level.pap_firsttime != 1) {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("pap_room_first", "rave_pap_vo");
  }

  level.pap_firsttime = 1;
  wait(4);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("ww_pap_nag", "rave_pap_vo", "high", undefined, undefined, undefined, 1);
}

move_through_tube(var_0, var_1, var_2, var_3) {
  var_0 earthquakeforplayer(0.3, 0.2, var_0.origin, 200);
  var_4 = getent(var_1, "targetname");
  var_5 = getent(var_2, "targetname");
  var_0 cancelmantle();
  var_0.no_outline = 1;
  var_0.no_team_outlines = 1;
  var_6 = var_4.origin + (0, 0, -45);
  var_7 = var_5.origin + (0, 0, -45);
  var_0.is_fast_traveling = 1;
  var_0 scripts\cp\utility::adddamagemodifier("fast_travel", 0, 0);
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 dontinterpolate();
  var_0 setorigin(var_6);
  var_0 setplayerangles(var_4.angles);
  var_0 playlocalsound("zmb_portal_travel_lr");
  var_8 = spawn("script_origin", var_6);
  var_0 playerlinkto(var_8);
  var_0 getweaponrankxpmultiplier();
  wait(0.1);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  var_8 moveto(var_7, 1);
  wait(1);
  var_0.is_fast_traveling = undefined;
  var_0 scripts\cp\utility::removedamagemodifier("fast_travel", 0);
  if(var_0 scripts\cp\utility::isignoremeenabled()) {
    var_0 scripts\cp\utility::allow_player_ignore_me(0);
  }

  var_0.is_fast_traveling = undefined;
  var_0.no_outline = 0;
  var_0.no_team_outlines = 0;
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  return var_8;
}

disable_teleportation(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 scripts\cp\utility::allow_player_teleport(0);
  var_0 waittill(var_2);
  wait(var_1);
  if(!var_0 scripts\cp\utility::isteleportenabled()) {
    var_0 scripts\cp\utility::allow_player_teleport(1);
  }

  var_0 notify("can_teleport");
}

packboat_hint_func(var_0, var_1) {
  if(level.boat_pieces_found < 3) {
    return "";
  }

  return &"CP_RAVE_USEBOAT";
}

use_packboat(var_0, var_1) {
  if(level.boat_pieces_found < 3) {
    return;
  }

  level scripts\cp\utility::set_completed_quest_mark(1);
  level.boat_interaction_struct = var_0;
  level.boat_vehicle giveperk("tag_motor");
  if(scripts\engine\utility::flag("survivor_released")) {
    if(!all_players_near_boat(var_0)) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
      level.boat_survivor playSound("ks_nag_needallplayers");
      wait(5);
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
      return;
    } else {
      level.boat_survivor notify("stop_boat_nag");
      foreach(var_3 in level.players) {
        link_player_to_boat(var_3, var_0);
      }
    }
  } else {
    if(isDefined(level.start_boat_ride_func)) {
      var_0 thread[[level.start_boat_ride_func]]();
    }

    var_1 playlocalsound("scn_boatride_board");
    level.boat_vehicle thread setup_boat_sounds();
    link_player_to_boat(var_1, var_0);
  }

  if(isDefined(level.boat_countdown_started)) {
    return;
  }

  if(!scripts\engine\utility::flag("survivor_released")) {
    level thread packboat_countdown();
    scripts\engine\utility::flag_wait("packboat_started");
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  reset_player_spots(var_0);
  if(!isDefined(level.packboat_logic_started)) {
    if(!scripts\engine\utility::flag("survivor_released")) {
      level.boat_vehicle thread packboat_path(var_0);
    } else {
      level thread survivor_boat_ride();
    }

    level.boat_vehicle startpath();
    level.packboat_logic_started = 1;
    return;
  }

  if(scripts\engine\utility::flag("survivor_released")) {
    level thread survivor_boat_ride();
    return;
  }

  level notify("boat_used");
}

setup_boat_sounds() {
  if(!isDefined(level.boat_vehicle.sfx_front)) {
    level.boat_vehicle.sfx_front = spawn("script_model", level.boat_vehicle.origin);
  }

  if(!isDefined(level.boat_vehicle.sfx_rear)) {
    level.boat_vehicle.sfx_rear = spawn("script_model", level.boat_vehicle.origin);
  }

  wait(0.05);
  level.boat_vehicle.sfx_front linkto(level.boat_vehicle, "tag_body");
  level.boat_vehicle.sfx_rear linkto(level.boat_vehicle, "tag_motor");
  wait(0.05);
  level.boat_vehicle.sfx_front playSound("scn_boatride_startup");
  level.boat_vehicle.sfx_rear playSound("scn_boatride_startup_lsrs");
  wait(5.15);
  level.boat_vehicle thread boatride_sfx();
}

all_players_near_boat(var_0) {
  var_1 = 19600;
  foreach(var_3 in level.players) {
    if(!var_3 scripts\cp\utility::is_valid_player()) {
      return 0;
    }

    if(distance2dsquared(var_3.origin, var_0.origin) > var_1) {
      return 0;
    }
  }

  return 1;
}

reset_player_spots(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    var_3.linked_player = undefined;
  }
}

link_player_to_boat(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getstruct("boat_player_" + level.boat_vehicle.linked_players.size, "script_noteworthy");
  var_3.linked_player = var_0;
  if(isDefined(var_2)) {
    var_3 = spawnStruct();
    var_3.origin = level.boat_vehicle gettagorigin(var_2);
    var_3.angles = level.boat_vehicle gettagangles(var_2);
  }

  level.boat_vehicle.linked_players[level.boat_vehicle.linked_players.size] = var_0;
  var_0 setorigin(var_3.origin);
  var_0 setplayerangles(var_3.angles);
  var_0 playerlinkto(level.boat_vehicle, undefined, 1, 45, 45, 30, 30, 0);
  var_0 playerlinkedoffsetenable();
  var_0.ignoreme = 1;
  if(!isDefined(level.boat_vehicle.first_player)) {
    level.boat_vehicle.first_player = var_0;
  }

  var_0 setseatedanimconditional("seat", 1);
  var_0 allowcrouch(1);
  var_0 allowstand(0);
  var_0 allowprone(0);
  var_0 getnumownedagentsonteambytype(0);
  var_0.linked_to_boat = 1;
  var_0.disable_consumables = 1;
  var_0.interactions_disabled = 1;
  var_0.can_teleport = 0;
  var_0 thread boat_last_stand_monitor(var_0);
}

packboat_path(var_0) {
  var_1 = getvehiclenode(level.boat_start_node.target, "targetname");
  for(;;) {
    var_1 waittill("trigger");
    if(isDefined(var_1.script_noteworthy)) {
      switch (var_1.script_noteworthy) {
        case "island_stop":
          stop_and_drop_players("island_dropoff_player");
          break;

        case "pier_stop":
          stop_and_wait_for_boat_use(var_0);
          break;

        default:
          break;
      }
    }

    if(!isDefined(var_1.target)) {
      break;
    }

    var_1 = getvehiclenode(var_1.target, "targetname");
  }
}

boatride_sfx() {
  level endon("boatride_over");
  level endon("gamed_ended");
  if(isDefined(level.boat_vehicle.sfx_front)) {
    level.boat_vehicle.sfx_front playsoundonmovingent("scn_boatride_01");
    level.boat_vehicle.sfx_rear playsoundonmovingent("scn_boatride_01_lsrs");
  }

  var_0 = getvehiclenode(level.boat_start_node.target, "targetname");
  for(;;) {
    var_0 waittill("trigger");
    if(isDefined(var_0.name)) {
      switch (var_0.name) {
        case "rave_boat_sound_2":
          if(isDefined(level.boat_vehicle.sfx_front)) {
            level.boat_vehicle.sfx_front playsoundonmovingent("scn_boatride_02");
            level.boat_vehicle.sfx_rear playsoundonmovingent("scn_boatride_02_lsrs");
          }
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

stop_and_wait_for_boat_use(var_0) {
  level.boat_vehicle vehicle_setspeedimmediate(0, 1, 1);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  if(isDefined(level.boat_vehicle.sfx_front)) {
    level.boat_vehicle.sfx_front delete();
  }

  if(isDefined(level.boat_vehicle.sfx_rear)) {
    level.boat_vehicle.sfx_rear delete();
  }

  level.boat_vehicle.docked = 1;
  level waittill("boat_used");
  level.boat_vehicle.docked = 0;
  level.boat_vehicle resumespeed(3);
}

stop_and_drop_players(var_0) {
  level.boat_vehicle vehicle_setspeedimmediate(0, 1, 1);
  wait(1);
  foreach(var_2 in level.boat_vehicle.linked_players) {
    level drop_off_player(var_2, var_0);
  }

  if(var_0 == "island_dropoff_player") {
    if(isDefined(level.boat_vehicle.sfx_front)) {
      level.boat_vehicle.sfx_front playsoundonmovingent("scn_boatride_03");
      level.boat_vehicle.sfx_rear playsoundonmovingent("scn_boatride_03_lsrs");
    }

    level.boat_vehicle resumespeed(3);
  }

  level.boat_vehicle.first_player = undefined;
}

drop_off_player(var_0, var_1) {
  var_0 unlink();
  var_2 = var_0 getentitynumber();
  var_3 = scripts\engine\utility::getstructarray(var_1, "targetname");
  var_4 = undefined;
  foreach(var_6 in var_3) {
    if(var_6.script_count == var_2) {
      var_4 = var_6;
    }
  }

  var_8 = getgroundposition(var_4.origin, 8, 32, 32);
  if(!isDefined(var_8)) {
    var_8 = var_4.origin;
  }

  var_0 setorigin(var_8 + (0, 0, 1));
  var_0 setplayerangles(var_4.angles);
  var_0 allowstand(1);
  var_0 allowprone(1);
  var_0 allowcrouch(1);
  var_0 getnumownedagentsonteambytype(1);
  var_0.ignoreme = 0;
  var_0.linked_to_boat = undefined;
  var_0.disable_consumables = undefined;
  var_0.interactions_disabled = undefined;
  var_0 setseatedanimconditional("seat", 0);
  level.boat_vehicle.linked_players = scripts\engine\utility::array_remove(level.boat_vehicle.linked_players, var_0);
  var_0.can_teleport = 1;
  var_0 notify("ride_over");
  level notify("boatride_over");
}

boat_last_stand_monitor(var_0) {
  var_0 endon("ride_over");
  var_0 endon("disconnect");
  var_0 waittill("last_stand");
  var_0 unlink();
  var_1 = var_0 getentitynumber();
  var_2 = scripts\engine\utility::getstructarray("packboat_player_exit", "targetname");
  var_3 = undefined;
  foreach(var_5 in var_2) {
    if(var_5.script_count == var_1) {
      var_3 = var_5;
    }
  }

  var_0 setorigin(var_3.origin);
  var_0 setplayerangles(var_3.angles);
  var_0 allowstand(1);
  var_0 getnumownedagentsonteambytype(1);
  var_0.ignoreme = 0;
  var_0.linked_to_boat = undefined;
  var_0.disable_consumables = undefined;
  var_0.interactions_disabled = undefined;
  level.boat_vehicle.linked_players = scripts\engine\utility::array_remove(level.boat_vehicle.linked_players, var_0);
  var_0.ignoreme = 0;
  var_0.can_teleport = 1;
  var_0 notify("ride_over");
}

packboat_countdown() {
  level.boat_countdown_started = 1;
  wait(5);
  scripts\engine\utility::flag_set("packboat_started");
  wait(1);
  scripts\engine\utility::flag_clear("packboat_started");
  level.boat_countdown_started = undefined;
}

pap_repair_hint_func(var_0, var_1) {
  if(level.pap_pieces_found < 2) {
    return "";
  }

  if(!scripts\engine\utility::flag("pap_fixed")) {
    return &"CP_RAVE_FIX_PAP";
  }

  return &"CP_RAVE_USE_PAP";
}

fix_pap(var_0, var_1) {
  if(level.pap_pieces_found < 2) {
    return;
  }

  if(!scripts\engine\utility::flag("pap_fixed")) {
    scripts\engine\utility::flag_set("pap_fixed");
    var_2 = scripts\engine\utility::getstructarray(var_0.script_noteworthy, "script_noteworthy");
    foreach(var_4 in var_2) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_4);
    }

    level scripts\cp\utility::set_completed_quest_mark(3);
    level.projector_struct setModel("cp_rave_projector_with_reels");
    level thread play_pap_vo(var_1);
    level thread activate_pap(var_0);
    foreach(var_7 in level.players) {
      var_7 scripts\cp\cp_interaction::refresh_interaction();
    }
  }
}

play_pap_vo(var_0) {
  level endon("gamed_ended");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("ks_pap_restored", "rave_ks_vo");
  wait(4.5);
  switch (var_0.vo_prefix) {
    case "p1_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("pap_chola_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["pap_chola_1"] = 1;
      break;

    case "p4_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("pap_hiphop_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["pap_hiphop_1"] = 1;
      break;

    case "p3_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("pap_rocker_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["pap_rocker_1"] = 1;
      break;

    case "p2_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("pap_raver_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["pap_raver_1"] = 1;
      break;

    default:
      break;
  }
}

zombie_boat_melee_func(var_0) {}

spawn_survivor_on_boat() {
  level endon("stop_boat_idle_anims");
  if(isDefined(level.boat_survivor)) {
    return;
  }

  if(isDefined(level.boat_survivor_spawned)) {
    return;
  }

  level.boat_survivor_spawned = 1;
  while(!scripts\engine\utility::istrue(level.boat_vehicle.docked)) {
    wait(0.25);
  }

  var_0 = spawnStruct();
  var_0.origin = (-3803.9, 1589.5, -159);
  var_0.angles = (0, 292, 0);
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("zmb_world_k_smith");
  var_1 linkto(level.boat_vehicle);
  level.boat_survivor = var_1;
  level.boat_survivor thread survivor_boat_nag();
  for(;;) {
    var_2 = getanimlength( % iw7_cp_survivor_boat_idle);
    level.boat_survivor scriptmodelplayanim("IW7_cp_survivor_boat_idle", 1);
    wait(var_2);
  }
}

survivor_boat_nag() {
  self endon("stop_boat_nag");
  for(;;) {
    level.boat_survivor playSound("ks_nag_getonboat");
    wait(randomintrange(12, 20));
  }
}

survivor_boat_filler() {
  self endon("stop_boat_filler");
  wait(4);
  var_0 = ["ks_examine_memento", "ks_examine_memento_2", "ks_examine_memento_3", "ks_examine_memento_4", "ks_examine_memento_5", "ks_examine_memento_6"];
  var_1 = var_0;
  for(;;) {
    var_2 = scripts\engine\utility::random(var_1);
    var_1 = scripts\engine\utility::array_remove(var_1, var_2);
    if(var_1.size < 1) {
      var_1 = var_0;
    }

    level.boat_survivor playsoundonmovingent(var_2);
    wait(randomintrange(5, 9));
  }
}

survivor_boat_ride() {
  level thread scripts\cp\maps\cp_rave\cp_rave::hotjoin_on_boat();
  level.pause_nag_vo = 1;
  level.boat_vehicle resumespeed(3);
  foreach(var_1 in level.players) {
    var_1 scripts\cp\utility::allow_player_teleport(0);
  }

  level.no_slasher = 1;
  if(isDefined(level.slasher)) {
    level.slasher suicide();
  }

  level.boat_vehicle thread survivor_boat_ride_sfx();
  wait(1);
  level.boat_vehicle.first_player scripts\cp\cp_vo::try_to_play_vo("memento_6", "rave_comment_vo", "highest");
  level.boat_survivor thread survivor_boat_filler();
  wait(15);
  level notify("stop_boat_idle_anims");
  var_3 = getanimlength( % iw7_cp_survivor_boat_idle);
  level.boat_survivor scriptmodelplayanim("IW7_cp_survivor_boat_idle", 1);
  wait(var_3 - 4.5);
  level.boat_vehicle vehicle_setspeed(0, 5);
  level.boat_survivor notify("stop_boat_filler");
  wait(4.25);
  level.boat_survivor unlink();
  level thread ksmith_boat_vo();
  level.boat_survivor scriptmodelplayanimdeltamotionfrompos("IW7_cp_survivor_boat_fall", level.boat_survivor.origin, level.boat_survivor.angles, 1);
  level.boat_survivor playSound("scn_slashride_survivor_fall");
  var_3 = getanimlength( % iw7_cp_survivor_boat_fall);
  wait(var_3 - 3.25);
  level.boat_survivor playSound("scn_slashride_survivor_splash");
  playFX(level._effect["boat_fall_splash"], level.boat_survivor.origin);
  foreach(var_1 in level.players) {
    var_1 playlocalsound("scn_slashride_03");
  }

  wait(1.25);
  foreach(var_1 in level.players) {
    var_1 playlocalsound("scn_slashride_slasher_water");
  }

  wait(1);
  level thread super_slasher_intro();
  level waittill("start_fadeout");
  wait(1);
  level.boat_survivor delete();
}

survivor_boat_ride_music_01() {
  foreach(var_1 in level.players) {
    var_1 playlocalsound("mus_zmb_rave_slasher_boat_01");
  }
}

survivor_boat_ride_music_02() {
  foreach(var_1 in level.players) {
    var_1 playlocalsound("mus_zmb_rave_slasher_boat_02");
  }
}

survivor_boat_ride_sfx() {
  level endon("boatride_over");
  level endon("gamed_ended");
  foreach(var_1 in level.players) {
    var_1 playlocalsound("scn_slashride_01");
  }

  var_3 = getvehiclenode(level.boat_start_node.target, "targetname");
  for(;;) {
    var_3 waittill("trigger");
    if(isDefined(var_3.name)) {
      switch (var_3.name) {
        case "slasher_boat_sound_2":
          foreach(var_1 in level.players) {
            var_1 playlocalsound("scn_slashride_02");
          }
          break;

        default:
          break;
      }
    }

    if(!isDefined(var_3.target)) {
      break;
    }

    var_3 = getvehiclenode(var_3.target, "targetname");
  }
}

ksmith_boat_vo() {
  level thread survivor_boat_ride_music_01();
  level.boat_survivor playSound("ks_memento_quest_3");
  var_0 = lookupsoundlength("ks_memento_quest_3");
  wait(var_0 / 1000 + 1.25);
  level thread survivor_boat_ride_music_02();
  level.boat_survivor playSound("ks_mement_boat_effort");
}

super_slasher_intro() {
  playFX(level._effect["vfx_ss_reveal_buildup"], (-3161, 3791, -244));
  earthquake(0.3, 5, level.boat_vehicle.origin, 350);
  wait(2);
  earthquake(0.45, 10, level.boat_vehicle.origin, 350);
  var_0 = spawn("script_model", (-3201, 3811, -328));
  var_0.angles = (0, 0, 0);
  var_0 setModel("fullbody_zmb_superslasher");
  var_0 scriptmodelplayanimdeltamotionfrompos("IW7_cp_super_taunt_intro", (-3201, 3811, -328), (0, 0, 0), 1);
  var_0 playSound("zmb_vo_supslasher_water_emerge_lr");
  var_0 thread slasher_intro_fx();
  level thread shellshock_players(6);
  level scripts\cp\utility::set_completed_quest_mark(4);
  wait(6.25);
  level notify("start_fadeout");
  scripts\engine\utility::flag_set("survivor_got_to_island");
  wait(0.25);
  earthquake(0.9, 3, level.boat_vehicle.origin, 350);
  var_0 playSound("zmb_vo_supslasher_attack_ground_pound");
  level thread shellshock_players(4);
  wait(1);
  var_0 delete();
}

shellshock_players(var_0) {
  foreach(var_2 in level.players) {
    var_2 shellshock("default_nosound", var_0);
    var_2 thread water_fx();
  }
}

slasher_intro_fx() {
  wait(0.2);
  playFX(level._effect["vfx_ss_reveal"], (self.origin[0] + 40, self.origin[1] - 20, -244));
  wait(0.5);
  playFXOnTag(level._effect["vfx_ss_reveal_arms"], self, "j_elbow_le");
  wait(0.05);
  playFXOnTag(level._effect["vfx_ss_reveal_arms"], self, "j_elbow_ri");
}

water_fx() {
  self endon("disconnect");
  playFXOnTag(level._effect["geyser_fullscreen_fx"], self, "tag_eye");
  scripts\engine\utility::waitframe();
  playFXOnTag(level._effect["geyser_fullscreen_fx"], self, "tag_eye");
  scripts\engine\utility::waitframe();
  playFXOnTag(level._effect["geyser_fullscreen_fx"], self, "tag_eye");
}

fade_screen_after_ss_intro() {
  foreach(var_1 in level.players) {
    var_1 thread ss_intro_black_screen();
  }

  wait(1);
}

move_players_to_shore() {
  foreach(var_1 in level.players) {
    var_1 thread move_player_to_shore(var_1, "island_dropoff_player");
  }
}

fade_in_for_ss_fight() {
  scripts\engine\utility::flag_set("survivor_got_to_island");
}

move_player_to_shore(var_0, var_1) {
  var_0 unlink();
  var_2 = var_0 getentitynumber();
  var_3 = scripts\engine\utility::getstructarray(var_1, "targetname");
  var_4 = undefined;
  foreach(var_6 in var_3) {
    if(var_6.script_count == var_2) {
      var_4 = var_6;
    }
  }

  var_0 setorigin(var_4.origin);
  var_0 setplayerangles(var_4.angles);
  var_0 allowstand(1);
  var_0 allowprone(1);
  var_0 getnumownedagentsonteambytype(1);
  var_0.linked_to_boat = undefined;
  var_0.disable_consumables = undefined;
  var_0.interactions_disabled = undefined;
  var_0 setseatedanimconditional("seat", 0);
  level.boat_vehicle.linked_players = scripts\engine\utility::array_remove(level.boat_vehicle.linked_players, var_0);
  var_0.can_teleport = 1;
  var_0.ignoreme = 0;
  var_0 notify("ride_over");
}

ss_intro_black_screen() {
  self endon("disconnect");
  self setclientomnvar("ui_hide_hud", 1);
  self getradiuspathsighttestnodes();
  self.ss_intro_overlay = newclienthudelem(self);
  self.ss_intro_overlay.x = 0;
  self.ss_intro_overlay.y = 0;
  self.ss_intro_overlay setshader("black", 640, 480);
  self.ss_intro_overlay.alignx = "left";
  self.ss_intro_overlay.aligny = "top";
  self.ss_intro_overlay.sort = 1;
  self.ss_intro_overlay.horzalign = "fullscreen";
  self.ss_intro_overlay.vertalign = "fullscreen";
  self.ss_intro_overlay.foreground = 1;
  self.ss_intro_overlay.alpha = 0;
  self.ss_intro_overlay fadeovertime(1);
  self.ss_intro_overlay.alpha = 1;
  level waittill("ss_intro_finished");
  self.ss_intro_overlay fadeovertime(5);
  self.ss_intro_overlay.alpha = 0;
  self setclientomnvar("ui_hide_hud", 0);
  wait(5);
  self.ss_intro_overlay destroy();
  wait(1.5);
  self enableweapons();
  wait(3);
  level notify("ww_slasher_intro");
}