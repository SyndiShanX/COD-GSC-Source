/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\cp_disco_fast_travel.gsc
*************************************************************/

init_teleport_portals() {
  wait(5);
  var_0 = scripts\engine\utility::getstructarray("fast_travel_portal", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread trigger_when_player_close_by();
    wait(0.1);
  }
}

trigger_when_player_close_by() {
  var_0 = getEntArray("chi_door_fast_travel_portal_trigger", "targetname");
  self.trigger = scripts\engine\utility::getclosest(self.origin, var_0, 500);
  self.start_point_name = self.script_noteworthy;
  self.end_point_name = self.script_parameters;
  self.end_point = scripts\engine\utility::getstruct(self.script_parameters, "script_noteworthy");
  self.teleport_door = scripts\engine\utility::getclosest(self.origin, getEntArray("chi_door_fast_travel", "targetname"));
  var_1 = getEntArray("chi_door_fast_travel_symbol", "targetname");
  if(isDefined(var_1)) {
    self.teleport_door_symbol = scripts\engine\utility::getclosest(self.origin, var_1);
  }

  self.recently_used = [];
  self.cooldown = 0;
  self.opened = 0;
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.teleport_spots = scripts\engine\utility::getstructarray(self.end_point.target, "targetname");
  script_add_teleport_spots();
  foreach(var_3 in self.teleport_spots) {
    if(!isDefined(var_3.angles)) {
      var_3.angles = (0, 0, 0);
    }
  }

  self.teleport_door setCanDamage(1);
  self.teleport_door setCanRadiusDamage(1);
  self.teleport_door.health = 10000000;
  for(;;) {
    self.teleport_door waittill("damage", var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    if(is_shuriken(var_14)) {
      break;
    }

    if(isplayer(var_6) && scripts\engine\utility::istrue(var_6.kung_fu_mode)) {
      break;
    }

    wait(0.1);
  }

  self.opened = 1;
  self.teleport_door hide();
  if(isDefined(self.teleport_door_symbol)) {
    self.teleport_door_symbol hide();
  }

  var_15 = scripts\engine\utility::getstructarray("chi_door_fast_travel_portal_spot", "targetname");
  self.portal_spot = scripts\engine\utility::getclosest(self.origin, var_15, 500);
  self.portal_scriptable = spawn("script_model", self.portal_spot.origin + (0, 0, 53));
  self.portal_scriptable setModel("tag_origin_chi_portal");
  self.portal_scriptable.angles = self.angles;
  playsoundatpos(self.portal_spot.origin, "cp_disco_doorbuy_wood_break");
  self.portal_scriptable setscriptablepartstate("portal", "door_break");
  var_6 thread scripts\cp\cp_vo::try_to_play_vo("door_wooden_sucess", "disco_comment_vo");
  thread portal_cooldown_monitor();
  wait(1);
  for(;;) {
    self.trigger waittill("trigger", var_10);
    if(scripts\engine\utility::istrue(var_10.isrewinding)) {
      scripts\engine\utility::waitframe();
      var_10 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_10);
      continue;
    }

    if(scripts\engine\utility::istrue(var_10.inlaststand)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isplayer(var_10)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(self.end_point.opened && self.cooldown <= 0) {
      if(isDefined(level.clock_interaction_q2)) {
        if(scripts\engine\utility::istrue(level.clock_interaction_q2.clock_active)) {
          self.end_point.cooldown = 0;
          var_10.travelled_thru_portal = 1;
          var_10.portal_start_origin = var_10.origin;
        } else {
          self.end_point.cooldown = self.end_point.cooldown + 30;
        }
      } else if(isDefined(level.clock_interaction_q3)) {
        if(scripts\engine\utility::istrue(level.clock_interaction_q3.clock_active)) {
          self.end_point.cooldown = 0;
          var_10.travelled_thru_portal = 1;
          var_10.portal_start_origin = var_10.origin;
        } else {
          self.end_point.cooldown = self.end_point.cooldown + 30;
        }
      } else {
        self.end_point.cooldown = self.end_point.cooldown + 30;
      }

      move_player_through_portal_tube(var_10);
    }

    wait(0.1);
  }
}

is_shuriken(var_0) {
  if(isDefined(var_0)) {
    if(issubstr(var_0, "shuriken")) {
      return 1;
    }
  }

  return 0;
}

script_add_teleport_spots() {
  var_0 = [];
  if(self.teleport_spots[0].origin == (-758, 1902, 800)) {
    var_0 = [(-758, 1928, 800), (-730, 1902, 800), (-758, 1878, 800)];
  } else if(self.teleport_spots[0].origin == (-2332, 3146, 266)) {
    var_0 = [(-2308, 3146, 266), (-2332, 3122, 266), (-2356, 3146, 266)];
  } else if(self.teleport_spots[0].origin == (-970, 514, 944)) {
    var_0 = [(-1004, 514, 944), (-970, 542, 944), (-938, 514, 944)];
  } else if(self.teleport_spots[0].origin == (-2288, 4728, 784)) {
    var_0 = [(-2314, 4728, 784), (-2288, 4700, 784), (-2264, 4728, 784)];
  }

  var_1 = self.teleport_spots[0].angles;
  foreach(var_3 in var_0) {
    var_4 = spawnStruct();
    var_4.origin = var_3;
    var_4.angles = var_1;
    var_4.var_336 = self.teleport_spots[0].var_336;
    self.teleport_spots[self.teleport_spots.size] = var_4;
  }
}

turn_on_portal() {
  self.portal_scriptable setscriptablepartstate("portal", "active");
}

watch_for_rewind_quest() {
  self endon("disconnect");
  for(;;) {
    if(!scripts\engine\utility::istrue(self.isrewinding)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(self.rewindmover)) {
      if(isDefined(self.quest_num)) {
        self.quest_num = int(self.quest_num);
        scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
        thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.05);
        thread scripts\cp\maps\cp_disco\cp_disco_interactions::play_fx_rewind(0.05);
        var_0 = level.clock[self.quest_num - 1].origin;
        var_1 = level.clock[self.quest_num - 1].angles;
        var_2 = getclosestpointonnavmesh(var_0);
        self setorigin(var_2, 0);
        self setvelocity((0, 0, 0));
        self setstance("stand");
      }

      break;
    }

    scripts\engine\utility::waitframe();
  }
}

move_player_through_portal_tube(var_0) {
  var_0 endon("disconnect");
  var_0 thread watch_for_rewind_quest();
  var_0 scripts\cp\powers\coop_powers::power_disablepower();
  var_0.disable_consumables = 1;
  var_0.isfasttravelling = 1;
  var_0 getrigindexfromarchetyperef();
  var_0 notify("delete_equipment");
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_1 = scripts\cp\maps\cp_disco\cp_disco::move_through_tube(var_0, "fast_travel_tube_start", "fast_travel_tube_end", 1);
  self.cooldown = self.cooldown + 30;
  teleport_to_portal_safe_spot(var_0);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_1 delete();
  if(scripts\engine\utility::istrue(var_0.travelled_thru_portal)) {
    if(isDefined(level.clock_interaction_q2)) {
      if(!scripts\engine\utility::istrue(level.clock_interaction_q2.clock_active)) {
        var_0.travelled_thru_portal = undefined;
      }
    }
  } else if(scripts\engine\utility::istrue(var_0.travelled_thru_portal)) {
    if(isDefined(level.clock_interaction_q3)) {
      if(!scripts\engine\utility::istrue(level.clock_interaction_q3.clock_active)) {
        var_0.travelled_thru_portal = undefined;
      }
    }
  }

  if(scripts\engine\utility::istrue(var_0.wor_phase_shift)) {
    var_0 scripts\cp\powers\coop_phaseshift::exitphaseshift(1);
    var_0.wor_phase_shift = 0;
  }

  var_0 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  var_0.is_off_grid = undefined;
  var_0.kicked_out = undefined;
  var_0.isfasttravelling = undefined;
  var_0 notify("fast_travel_complete");
  var_0.disable_consumables = undefined;
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0 thread update_personal_ents_after_delay();
  if(var_0.vo_prefix == "p5_") {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("fasttravel_exit", "disco_comment_vo");
  }
}

move_zombie_through_portal_tube(var_0) {
  var_0.isfasttravelling = 1;
  var_1 = scripts\cp\maps\cp_disco\cp_disco::move_through_tube(var_0, "fast_travel_tube_start", "fast_travel_tube_end", 1);
  teleport_to_portal_safe_spot(var_0);
  wait(0.1);
  var_1 delete();
  var_0.isfasttravelling = undefined;
}

update_personal_ents_after_delay() {
  self endon("disconnect");
  scripts\engine\utility::waitframe();
  scripts\cp\cp_interaction::refresh_interaction();
  thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(self);
}

unlinkplayerafterduration() {
  while(scripts\engine\utility::istrue(self.isrewinding) || isDefined(self.rewindmover)) {
    wait(0.1);
  }

  self unlink();
}

teleport_to_portal_safe_spot(var_0) {
  var_1 = self.teleport_spots;
  var_2 = undefined;
  while(!isDefined(var_2)) {
    foreach(var_4 in var_1) {
      if(!positionwouldtelefrag(var_4.origin)) {
        var_2 = var_4;
      }
    }

    if(!isDefined(var_2)) {
      if(!isDefined(var_1[0].angles)) {
        var_1[0].angles = (0, 0, 0);
      }

      var_6 = scripts\cp\utility::vec_multiply(anglesToForward(var_1[0].angles), 64);
      var_2 = spawnStruct();
      var_2.origin = var_1[0].origin + var_6;
      var_2.angles = var_1[0].angles;
    }

    wait(0.1);
  }

  var_0 playershow();
  if(scripts\engine\utility::istrue(var_0.isrewinding) || isDefined(self.rewindmover)) {
    var_0 thread unlinkplayerafterduration();
  } else {
    var_0 unlink();
  }

  var_0 dontinterpolate();
  var_0 setorigin(var_2.origin);
  var_0 setplayerangles(var_2.angles);
  var_0.disable_consumables = undefined;
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0.portal_end_origin = var_2.origin;
}

delay_portal_trigger_on_player(var_0, var_1) {
  wait(var_1);
  var_0.recently_used_portal = undefined;
  wait(var_1 * 2);
  self.recently_used = scripts\engine\utility::array_remove(self.recently_used, var_0);
}

portal_cooldown_monitor() {
  self.portal_scriptable setscriptablepartstate("portal", "cooldown");
  while(!self.end_point.opened) {
    wait(0.1);
  }

  var_0 = 0.1;
  for(;;) {
    if(self.cooldown > 0) {
      self.cooldown = self.cooldown - var_0;
      if(self.portal_scriptable getscriptablepartstate("portal") != "cooldown") {
        self.portal_scriptable setscriptablepartstate("portal", "cooldown");
      }
    } else {
      self.portal_scriptable setscriptablepartstate("portal", self.end_point_name);
    }

    if(self.cooldown < 0) {
      self.cooldown = 0;
    }

    wait(var_0);
  }
}