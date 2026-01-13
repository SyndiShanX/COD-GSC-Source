/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_fast_travel.gsc
***********************************************************/

init_teleport_portals() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = scripts\engine\utility::getstructarray("fast_travel_portal", "targetname");
  foreach(var_2 in var_0) {
    var_3 = getEntArray("chi_door_fast_travel_portal_trigger", "targetname");
    self.trigger = scripts\engine\utility::getclosest(self.origin, var_3, 500);
    self.start_point_name = self.script_noteworthy;
    self.end_point_name = self.script_parameters;
    self.end_point = scripts\engine\utility::getstruct(self.script_parameters, "script_noteworthy");
    self.teleport_door = scripts\engine\utility::getclosest(self.origin, getEntArray("chi_door_fast_travel", "targetname"));
    var_4 = getEntArray("chi_door_fast_travel_symbol", "targetname");
    if(isDefined(var_4)) {
      self.teleport_door_symbol = scripts\engine\utility::getclosest(self.origin, var_4);
    }

    self.recently_used = [];
    self.cooldown = 0;
    self.opened = 0;
    if(!isDefined(self.angles)) {
      self.angles = (0, 0, 0);
    }

    self.teleport_spots = scripts\engine\utility::getstructarray(self.end_point.target, "targetname");
    script_add_teleport_spots();
    foreach(var_6 in self.teleport_spots) {
      if(!isDefined(var_6.angles)) {
        var_6.angles = (0, 0, 0);
      }
    }
  }
}

script_add_teleport_spots() {
  var_0 = [];
  var_1 = (0, 0, 0);
  foreach(var_3 in var_0) {
    var_4 = spawnStruct();
    var_4.origin = var_3;
    var_4.angles = var_1;
    var_4.var_336 = self.teleport_spots[0].var_336;
    self.teleport_spots[self.teleport_spots.size] = var_4;
  }
}

move_player_through_portal_tube(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 scripts\cp\powers\coop_powers::power_disablepower();
  var_0.disable_consumables = 1;
  var_0.isfasttravelling = 1;
  var_0 getrigindexfromarchetyperef();
  var_0 notify("delete_equipment");
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_2 = move_through_tube(var_0, "fast_travel_tube_start", "fast_travel_tube_end");
  if(isDefined(self.cooldown)) {
    self.cooldown = self.cooldown + 30;
  }

  teleport_to_portal_safe_spot(var_0, var_1);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_2 delete();
  var_0 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  var_0.is_off_grid = undefined;
  var_0.kicked_out = undefined;
  var_0.isfasttravelling = undefined;
  var_0.disable_consumables = undefined;
  var_0 notify("fast_travel_complete");
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0 thread update_personal_ents_after_delay();
  if(var_0.vo_prefix == "p5_") {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("fasttravel_exit", "town_comment_vo");
  }
}

move_through_tube(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("move_through_tube");
  var_0 earthquakeforplayer(0.3, 0.2, var_0.origin, 200);
  var_3 = getent(var_1, "targetname");
  var_4 = getent(var_2, "targetname");
  var_0 cancelmantle();
  var_0.no_outline = 1;
  var_0.no_team_outlines = 1;
  var_5 = var_3.origin + (0, 0, -45);
  var_6 = var_4.origin + (0, 0, -45);
  var_0.is_fast_traveling = 1;
  var_0 scripts\cp\utility::adddamagemodifier("fast_travel", 0, 0);
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 dontinterpolate();
  var_0 setorigin(var_5);
  var_0 setplayerangles(var_3.angles);
  var_0 playlocalsound("zmb_portal_travel_lr");
  var_7 = spawn("script_origin", var_5);
  var_0 playerlinkto(var_7);
  var_0 getweaponrankxpmultiplier();
  wait(0.1);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  var_7 moveto(var_6, 1);
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
  return var_7;
}

move_zombie_through_portal_tube(var_0) {
  var_0.isfasttravelling = 1;
  var_1 = move_through_tube(var_0, "fast_travel_tube_start", "fast_travel_tube_end", 1);
  teleport_to_portal_safe_spot(var_0);
  wait(0.1);
  var_1 delete();
  var_0.isfasttravelling = undefined;
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

teleport_to_portal_safe_spot(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = self.teleport_spots;
  }

  var_3 = undefined;
  while(!isDefined(var_3)) {
    foreach(var_5 in var_2) {
      if(!positionwouldtelefrag(var_5.origin)) {
        var_3 = var_5;
      }
    }

    if(!isDefined(var_3)) {
      if(!isDefined(var_2[0].angles)) {
        var_2[0].angles = (0, 0, 0);
      }

      var_7 = scripts\cp\utility::vec_multiply(anglesToForward(var_2[0].angles), 64);
      var_3 = spawnStruct();
      var_3.origin = var_2[0].origin + var_7;
      var_3.angles = var_2[0].angles;
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
  var_0 setorigin(var_3.origin);
  var_0 setplayerangles(var_3.angles);
  var_0.disable_consumables = undefined;
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0.portal_end_origin = var_3.origin;
}

delay_portal_trigger_on_player(var_0, var_1) {
  wait(var_1);
  var_0.recently_used_portal = undefined;
  wait(var_1 * 2);
  self.recently_used = scripts\engine\utility::array_remove(self.recently_used, var_0);
}