/***********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_fast_travel.gsc
***********************************************************/

init_teleport_portals() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_00 = scripts\engine\utility::getstructarray("fast_travel_portal", "targetname");
  foreach(var_02 in var_00) {
    var_03 = getEntArray("chi_door_fast_travel_portal_trigger", "targetname");
    self.trigger = scripts\engine\utility::getclosest(self.origin, var_03, 500);
    self.start_point_name = self.script_noteworthy;
    self.end_point_name = self.script_parameters;
    self.end_point = scripts\engine\utility::getstruct(self.script_parameters, "script_noteworthy");
    self.teleport_door = scripts\engine\utility::getclosest(self.origin, getEntArray("chi_door_fast_travel", "targetname"));
    var_04 = getEntArray("chi_door_fast_travel_symbol", "targetname");
    if(isDefined(var_04)) {
      self.teleport_door_symbol = scripts\engine\utility::getclosest(self.origin, var_04);
    }

    self.recently_used = [];
    self.cooldown = 0;
    self.opened = 0;
    if(!isDefined(self.angles)) {
      self.angles = (0, 0, 0);
    }

    self.teleport_spots = scripts\engine\utility::getstructarray(self.end_point.target, "targetname");
    script_add_teleport_spots();
    foreach(var_06 in self.teleport_spots) {
      if(!isDefined(var_06.angles)) {
        var_06.angles = (0, 0, 0);
      }
    }
  }
}

script_add_teleport_spots() {
  var_00 = [];
  var_01 = (0, 0, 0);
  foreach(var_03 in var_00) {
    var_04 = spawnStruct();
    var_04.origin = var_03;
    var_04.angles = var_01;
    var_04.var_336 = self.teleport_spots[0].var_336;
    self.teleport_spots[self.teleport_spots.size] = var_04;
  }
}

move_player_through_portal_tube(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 scripts\cp\powers\coop_powers::power_disablepower();
  param_00.disable_consumables = 1;
  param_00.isfasttravelling = 1;
  param_00 getrigindexfromarchetyperef();
  param_00 notify("delete_equipment");
  param_00 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_02 = move_through_tube(param_00, "fast_travel_tube_start", "fast_travel_tube_end");
  if(isDefined(self.cooldown)) {
    self.cooldown = self.cooldown + 30;
  }

  teleport_to_portal_safe_spot(param_00, param_01);
  param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_02 delete();
  param_00 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  param_00.is_off_grid = undefined;
  param_00.kicked_out = undefined;
  param_00.isfasttravelling = undefined;
  param_00.disable_consumables = undefined;
  param_00 notify("fast_travel_complete");
  param_00 scripts\cp\powers\coop_powers::power_enablepower();
  param_00 thread update_personal_ents_after_delay();
  if(param_00.vo_prefix == "p5_") {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("fasttravel_exit", "town_comment_vo");
  }
}

move_through_tube(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("move_through_tube");
  param_00 earthquakeforplayer(0.3, 0.2, param_00.origin, 200);
  var_03 = getent(param_01, "targetname");
  var_04 = getent(param_02, "targetname");
  param_00 cancelmantle();
  param_00.no_outline = 1;
  param_00.no_team_outlines = 1;
  var_05 = var_03.origin + (0, 0, -45);
  var_06 = var_04.origin + (0, 0, -45);
  param_00.is_fast_traveling = 1;
  param_00 scripts\cp\utility::adddamagemodifier("fast_travel", 0, 0);
  param_00 scripts\cp\utility::allow_player_ignore_me(1);
  param_00 dontinterpolate();
  param_00 setorigin(var_05);
  param_00 setplayerangles(var_03.angles);
  param_00 playlocalsound("zmb_portal_travel_lr");
  var_07 = spawn("script_origin", var_05);
  param_00 playerlinkto(var_07);
  param_00 getweaponrankxpmultiplier();
  wait(0.1);
  param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  var_07 moveto(var_06, 1);
  wait(1);
  param_00.is_fast_traveling = undefined;
  param_00 scripts\cp\utility::removedamagemodifier("fast_travel", 0);
  if(param_00 scripts\cp\utility::isignoremeenabled()) {
    param_00 scripts\cp\utility::allow_player_ignore_me(0);
  }

  param_00.is_fast_traveling = undefined;
  param_00.no_outline = 0;
  param_00.no_team_outlines = 0;
  param_00 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  return var_07;
}

move_zombie_through_portal_tube(param_00) {
  param_00.isfasttravelling = 1;
  var_01 = move_through_tube(param_00, "fast_travel_tube_start", "fast_travel_tube_end", 1);
  teleport_to_portal_safe_spot(param_00);
  wait(0.1);
  var_01 delete();
  param_00.isfasttravelling = undefined;
}

update_personal_ents_after_delay() {
  self endon("disconnect");
  scripts\engine\utility::waitframe();
  scripts\cp\cp_interaction::refresh_interaction();
}

unlinkplayerafterduration() {
  while(scripts\engine\utility::istrue(self.isrewinding) || isDefined(self.rewindmover)) {
    scripts\engine\utility::waitframe();
  }

  self unlink();
}

teleport_to_portal_safe_spot(param_00, param_01) {
  if(isDefined(param_01)) {
    var_02 = param_01;
  } else {
    var_02 = self.teleport_spots;
  }

  var_03 = undefined;
  while(!isDefined(var_03)) {
    foreach(var_05 in var_02) {
      if(!positionwouldtelefrag(var_05.origin)) {
        var_03 = var_05;
      }
    }

    if(!isDefined(var_03)) {
      if(!isDefined(var_02[0].angles)) {
        var_02[0].angles = (0, 0, 0);
      }

      var_07 = scripts\cp\utility::vec_multiply(anglesToForward(var_02[0].angles), 64);
      var_03 = spawnStruct();
      var_03.origin = var_02[0].origin + var_07;
      var_03.angles = var_02[0].angles;
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
  param_00 setorigin(var_03.origin);
  param_00 setplayerangles(var_03.angles);
  param_00.disable_consumables = undefined;
  param_00 scripts\cp\powers\coop_powers::power_enablepower();
  param_00.portal_end_origin = var_03.origin;
}

delay_portal_trigger_on_player(param_00, param_01) {
  wait(param_01);
  param_00.recently_used_portal = undefined;
  wait(param_01 * 2);
  self.recently_used = scripts\engine\utility::array_remove(self.recently_used, param_00);
}