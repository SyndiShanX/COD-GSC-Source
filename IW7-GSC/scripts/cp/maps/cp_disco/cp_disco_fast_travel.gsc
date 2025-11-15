/*************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\cp_disco_fast_travel.gsc
*************************************************************/

init_teleport_portals() {
  wait(5);
  var_00 = scripts\engine\utility::getstructarray("fast_travel_portal", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread trigger_when_player_close_by();
    wait(0.1);
  }
}

trigger_when_player_close_by() {
  var_00 = getEntArray("chi_door_fast_travel_portal_trigger", "targetname");
  self.trigger = scripts\engine\utility::getclosest(self.origin, var_00, 500);
  self.start_point_name = self.script_noteworthy;
  self.end_point_name = self.script_parameters;
  self.end_point = scripts\engine\utility::getstruct(self.script_parameters, "script_noteworthy");
  self.teleport_door = scripts\engine\utility::getclosest(self.origin, getEntArray("chi_door_fast_travel", "targetname"));
  var_01 = getEntArray("chi_door_fast_travel_symbol", "targetname");
  if(isDefined(var_01)) {
    self.teleport_door_symbol = scripts\engine\utility::getclosest(self.origin, var_01);
  }

  self.recently_used = [];
  self.cooldown = 0;
  self.opened = 0;
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.teleport_spots = scripts\engine\utility::getstructarray(self.end_point.target, "targetname");
  script_add_teleport_spots();
  foreach(var_03 in self.teleport_spots) {
    if(!isDefined(var_03.angles)) {
      var_03.angles = (0, 0, 0);
    }
  }

  self.teleport_door setCanDamage(1);
  self.teleport_door setCanRadiusDamage(1);
  self.teleport_door.health = 10000000;
  for(;;) {
    self.teleport_door waittill("damage", var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E);
    if(is_shuriken(var_0E)) {
      break;
    }

    if(isplayer(var_06) && scripts\engine\utility::istrue(var_06.kung_fu_mode)) {
      break;
    }

    wait(0.1);
  }

  self.opened = 1;
  self.teleport_door hide();
  if(isDefined(self.teleport_door_symbol)) {
    self.teleport_door_symbol hide();
  }

  var_0F = scripts\engine\utility::getstructarray("chi_door_fast_travel_portal_spot", "targetname");
  self.portal_spot = scripts\engine\utility::getclosest(self.origin, var_0F, 500);
  self.portal_scriptable = spawn("script_model", self.portal_spot.origin + (0, 0, 53));
  self.portal_scriptable setModel("tag_origin_chi_portal");
  self.portal_scriptable.angles = self.angles;
  playsoundatpos(self.portal_spot.origin, "cp_disco_doorbuy_wood_break");
  self.portal_scriptable setscriptablepartstate("portal", "door_break");
  var_06 thread scripts\cp\cp_vo::try_to_play_vo("door_wooden_sucess", "disco_comment_vo");
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

is_shuriken(param_00) {
  if(isDefined(param_00)) {
    if(issubstr(param_00, "shuriken")) {
      return 1;
    }
  }

  return 0;
}

script_add_teleport_spots() {
  var_00 = [];
  if(self.teleport_spots[0].origin == (-758, 1902, 800)) {
    var_00 = [(-758, 1928, 800), (-730, 1902, 800), (-758, 1878, 800)];
  } else if(self.teleport_spots[0].origin == (-2332, 3146, 266)) {
    var_00 = [(-2308, 3146, 266), (-2332, 3122, 266), (-2356, 3146, 266)];
  } else if(self.teleport_spots[0].origin == (-970, 514, 944)) {
    var_00 = [(-1004, 514, 944), (-970, 542, 944), (-938, 514, 944)];
  } else if(self.teleport_spots[0].origin == (-2288, 4728, 784)) {
    var_00 = [(-2314, 4728, 784), (-2288, 4700, 784), (-2264, 4728, 784)];
  }

  var_01 = self.teleport_spots[0].angles;
  foreach(var_03 in var_00) {
    var_04 = spawnStruct();
    var_04.origin = var_03;
    var_04.angles = var_01;
    var_04.var_336 = self.teleport_spots[0].var_336;
    self.teleport_spots[self.teleport_spots.size] = var_04;
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
        var_00 = level.clock[self.quest_num - 1].origin;
        var_01 = level.clock[self.quest_num - 1].angles;
        var_02 = getclosestpointonnavmesh(var_00);
        self setorigin(var_02, 0);
        self setvelocity((0, 0, 0));
        self setstance("stand");
      }

      break;
    }

    scripts\engine\utility::waitframe();
  }
}

move_player_through_portal_tube(param_00) {
  param_00 endon("disconnect");
  param_00 thread watch_for_rewind_quest();
  param_00 scripts\cp\powers\coop_powers::power_disablepower();
  param_00.disable_consumables = 1;
  param_00.isfasttravelling = 1;
  param_00 getrigindexfromarchetyperef();
  param_00 notify("delete_equipment");
  param_00 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_01 = scripts\cp\maps\cp_disco\cp_disco::move_through_tube(param_00, "fast_travel_tube_start", "fast_travel_tube_end", 1);
  self.cooldown = self.cooldown + 30;
  teleport_to_portal_safe_spot(param_00);
  param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_01 delete();
  if(scripts\engine\utility::istrue(param_00.travelled_thru_portal)) {
    if(isDefined(level.clock_interaction_q2)) {
      if(!scripts\engine\utility::istrue(level.clock_interaction_q2.clock_active)) {
        param_00.travelled_thru_portal = undefined;
      }
    }
  } else if(scripts\engine\utility::istrue(param_00.travelled_thru_portal)) {
    if(isDefined(level.clock_interaction_q3)) {
      if(!scripts\engine\utility::istrue(level.clock_interaction_q3.clock_active)) {
        param_00.travelled_thru_portal = undefined;
      }
    }
  }

  if(scripts\engine\utility::istrue(param_00.wor_phase_shift)) {
    param_00 scripts\cp\powers\coop_phaseshift::exitphaseshift(1);
    param_00.wor_phase_shift = 0;
  }

  param_00 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  param_00.is_off_grid = undefined;
  param_00.kicked_out = undefined;
  param_00.isfasttravelling = undefined;
  param_00 notify("fast_travel_complete");
  param_00.disable_consumables = undefined;
  param_00 scripts\cp\powers\coop_powers::power_enablepower();
  param_00 thread update_personal_ents_after_delay();
  if(param_00.vo_prefix == "p5_") {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("fasttravel_exit", "disco_comment_vo");
  }
}

move_zombie_through_portal_tube(param_00) {
  param_00.isfasttravelling = 1;
  var_01 = scripts\cp\maps\cp_disco\cp_disco::move_through_tube(param_00, "fast_travel_tube_start", "fast_travel_tube_end", 1);
  teleport_to_portal_safe_spot(param_00);
  wait(0.1);
  var_01 delete();
  param_00.isfasttravelling = undefined;
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

teleport_to_portal_safe_spot(param_00) {
  var_01 = self.teleport_spots;
  var_02 = undefined;
  while(!isDefined(var_02)) {
    foreach(var_04 in var_01) {
      if(!positionwouldtelefrag(var_04.origin)) {
        var_02 = var_04;
      }
    }

    if(!isDefined(var_02)) {
      if(!isDefined(var_01[0].angles)) {
        var_01[0].angles = (0, 0, 0);
      }

      var_06 = scripts\cp\utility::vec_multiply(anglesToForward(var_01[0].angles), 64);
      var_02 = spawnStruct();
      var_02.origin = var_01[0].origin + var_06;
      var_02.angles = var_01[0].angles;
    }

    wait(0.1);
  }

  param_00 playershow();
  if(scripts\engine\utility::istrue(param_00.isrewinding) || isDefined(self.rewindmover)) {
    param_00 thread unlinkplayerafterduration();
  } else {
    param_00 unlink();
  }

  param_00 dontinterpolate();
  param_00 setorigin(var_02.origin);
  param_00 setplayerangles(var_02.angles);
  param_00.disable_consumables = undefined;
  param_00 scripts\cp\powers\coop_powers::power_enablepower();
  param_00.portal_end_origin = var_02.origin;
}

delay_portal_trigger_on_player(param_00, param_01) {
  wait(param_01);
  param_00.recently_used_portal = undefined;
  wait(param_01 * 2);
  self.recently_used = scripts\engine\utility::array_remove(self.recently_used, param_00);
}

portal_cooldown_monitor() {
  self.portal_scriptable setscriptablepartstate("portal", "cooldown");
  while(!self.end_point.opened) {
    wait(0.1);
  }

  var_00 = 0.1;
  for(;;) {
    if(self.cooldown > 0) {
      self.cooldown = self.cooldown - var_00;
      if(self.portal_scriptable getscriptablepartstate("portal") != "cooldown") {
        self.portal_scriptable setscriptablepartstate("portal", "cooldown");
      }
    } else {
      self.portal_scriptable setscriptablepartstate("portal", self.end_point_name);
    }

    if(self.cooldown < 0) {
      self.cooldown = 0;
    }

    wait(var_00);
  }
}