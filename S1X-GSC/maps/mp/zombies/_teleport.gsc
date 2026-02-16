/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_teleport.gsc
*****************************************/

init() {
  level._effect["trash_chute_burst"] = loadfx("vfx/props/dlc_prop_trash_chute_burst");
  precachempanim("incinerator_hatch_open");
  precachempanim("incinerator_hatch_close");

  if(!isDefined(level.zmteleportreadyhint)) {
    level.zmteleportreadyhint = &"ZOMBIES_TELEPORT_USE";
  }

  if(!isDefined(level.zmteleportlookarcs)) {
    level.zmteleportlookarcs = [20, 20, 0, 30];
  }

  level.teleportrooms = common_scripts\utility::getStructArray("teleport_room", "targetname");

  if(level.teleportrooms.size) {
    level.teleportroomindex = 0;
  }

  level.zombieteleporters = common_scripts\utility::getStructArray("zombie_teleport", "targetname");
  common_scripts\utility::array_thread(level.zombieteleporters, ::teleporter_init);
  level thread teleporter_cost();
}

teleporter_init() {
  self.disabled = 0;
  var_0 = getEntArray(self.target, "targetname");
  var_1 = common_scripts\utility::getStructArray(self.target, "targetname");
  var_2 = common_scripts\utility::array_combine(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = var_4.script_noteworthy;

    if(!isDefined(var_5)) {
      var_5 = "<undefined>";
    }

    if(isDefined(level.zmteleporterinit) && [[level.zmteleporterinit]](var_4, var_5)) {
      continue;
    }
    switch (var_5) {
      case "start":
        self.start = var_4;
        break;
      case "end":
        thread teleport_add_location(var_4);
        break;
      case "hatch":
        self.hatch = var_4;
        break;
      default:
        teleport_error("Target Ent @ " + var_4.origin + " had script_noteworthy: '" + var_5 + "'.");
        break;
    }
  }

  if(!isDefined(self.start)) {
    teleport_error("Teleporter at" + self.origin + " has no start trigger.");
    return;
  }

  thread teleporter_run();
}

teleporter_disable_all() {
  common_scripts\utility::array_thread(level.zombieteleporters, ::teleporter_disable);
}

teleporter_disable() {
  self notify("teleporter_disable");
  self endon("teleporter_disable");

  if(self.disabled) {
    return;
  }
  if(self.inuse) {
    self waittill("teleportReady");
  }

  self.disabled = 1;
  self.start sethintstring(&"ZOMBIES_EMPTY_STRING");
  self.start setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
  self.start maps\mp\zombies\_util::tokenhintstring(0);
}

teleporter_enable_all() {
  common_scripts\utility::array_thread(level.zombieteleporters, ::teleporter_enable);
}

teleporter_enable() {
  if(!self.disabled) {
    return;
  }
  self.disabled = 0;
  self.start sethintstring(level.zmteleportreadyhint);
  var_0 = teleporter_get_cost();
  self.start setsecondaryhintstring(maps\mp\zombies\_util::getcoststring(var_0));
  self.start maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_0));
  self.start maps\mp\zombies\_util::tokenhintstring(1);
}

teleporter_run() {
  self.inuse = 0;
  waitframe();

  if(isDefined(self.script_flag_true)) {
    self.start sethintstring(&"ZOMBIES_REQUIRES_POWER");
    self.start maps\mp\zombies\_util::tokenhintstring(0);
    common_scripts\utility::flag_wait(self.script_flag_true);
  }

  if(!self.locations.size) {
    self waittill("location_added");
  }

  thread teleporter_update_cost();
  var_0 = 1;

  for(;;) {
    self.start setcursorhint("HINT_NOICON");
    self.start sethintstring(level.zmteleportreadyhint);
    self.start maps\mp\zombies\_util::tokenhintstring(1);
    self.inuse = 0;
    self notify("teleportReady");

    for(;;) {
      [var_2, var_3] = self.start maps\mp\zombies\_util::waittilltriggerortokenuse();

      if(self.disabled) {
        continue;
      }
      if(var_3 == "token") {
        var_2 maps\mp\gametypes\zombies::spendtoken(self.start.tokencost);
      } else {
        var_4 = teleporter_get_cost();

        if(isDefined(level.penaltycostincrease)) {
          for(var_5 = 0; var_5 < level.penaltycostincrease; var_5++) {
            var_6 = maps\mp\zombies\_util::getincreasedcost(var_4);
            var_4 = var_6;
          }
        }

        if(isDefined(var_2) && var_4 > 0 && !var_2 maps\mp\gametypes\zombies::attempttobuy(var_4)) {
          continue;
        }
      }

      break;
    }

    self.inuse = 1;
    level notify("teleportUse", self, var_2);
    self.start sethintstring(&"ZOMBIES_EMPTY_STRING");
    self.start maps\mp\zombies\_util::tokenhintstring(0);

    if(isDefined(level.zmteleporterused)) {
      [[level.zmteleporterused]](var_2);
    }

    if(isDefined(self.hatch)) {
      playFX(common_scripts\utility::getfx("trash_chute_burst"), self.hatch.origin, anglestoup(self.hatch.angles), -1 * anglesToForward(self.hatch.angles));
      playsoundatpos(self.hatch.origin, "trash_chute_teleport_open");
      self.hatch scriptmodelplayanim("incinerator_hatch_open", "hatch");
      self.hatch waittillmatch("hatch", "teleport");
    }

    thread teleport_players_loop();
    wait(var_0);
    self notify("end_teleport_players_loop");

    if(isDefined(self.hatch)) {
      self.hatch scriptmodelplayanim("incinerator_hatch_close", "hatch");
      self.hatch waittillmatch("hatch", "end");
    }
  }
}

teleport_players_loop() {
  self endon("end_teleport_players_loop");

  for(;;) {
    var_0 = [];

    foreach(var_2 in level.players) {
      if(var_2 istouching(self.start)) {
        var_0[var_0.size] = var_2;
      }
    }

    level notify("teleportPlayers", var_0);
    self notify("teleportPlayers", var_0);
    thread teleport_players(var_0);
    waitframe();
  }
}

teleporter_cost() {
  thread teleporter_update_cost_on_teleport();
  thread teleporter_update_cost_on_round_end();
}

teleporter_update_cost() {
  foreach(var_1 in level.zombieteleporters) {
    var_2 = var_1 teleporter_get_cost();
    var_1.start setsecondaryhintstring(maps\mp\zombies\_util::getcoststring(var_2));
    var_1.start maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_2));
    var_1.start maps\mp\zombies\_util::tokenhintstring(1);
  }
}

teleporter_get_cost() {
  var_0 = [100, 500, 2000];

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "incinerator") {
    return 0;
  }

  var_1 = level.teleport_cost_index;

  if(var_1 >= var_0.size) {
    var_1 = var_0.size - 1;
  }

  if(var_1 < 0) {
    var_1 = 0;
  }

  return var_0[var_1];
}

teleporter_update_cost_on_teleport() {
  level.teleport_cost_index = 0;

  for(;;) {
    teleporter_update_cost();
    level waittill("teleportUse", var_0, var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    level.teleport_cost_index++;
  }
}

teleporter_update_cost_on_round_end(var_0) {
  for(;;) {
    level waittill("zombie_wave_ended");
    level.teleport_cost_index = 0;
    teleporter_update_cost();
  }
}

player_teleport_unlink(var_0) {
  self endon("disconnect");
  wait(var_0);
  self unlink();
}

teleport_players_through_chute(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_3 = 2;
  var_4 = (0, 0, -40);

  foreach(var_6 in var_0) {
    if(!isDefined(var_6) || !isalive(var_6)) {
      continue;
    }
    var_7 = var_6 getstance();

    if(var_7 == "prone") {
      var_6 setstance("crouch");
    }

    var_6 playsoundtoplayer("trash_chute_teleport", var_6);
    var_8 = level.teleportrooms[level.teleportroomindex];
    var_9 = var_8.origin;
    var_10 = var_8.angles;
    var_6 player_teleport(var_9, var_10);
    var_6.inteleport = 1;

    if(var_1) {
      var_6 thread maps\mp\zombies\_zombies_audio::playertrashchute();
    }

    if(isDefined(var_8.target)) {
      var_11 = common_scripts\utility::getstruct(var_8.target, "targetname");

      if(!isDefined(var_8.playerlinkent)) {
        var_8.playerlinkent = spawn("script_model", var_8.origin);
        var_8.playerlinkent setModel("tag_origin");
        var_8.playerlinkent.angles = var_8.angles;
      }

      var_8.playerlinkent.origin = var_8.origin + var_4;
      var_12 = level.zmteleportlookarcs[0];
      var_13 = level.zmteleportlookarcs[1];
      var_14 = level.zmteleportlookarcs[2];
      var_15 = level.zmteleportlookarcs[3];
      var_6 playerlinktodelta(var_8.playerlinkent, "tag_origin", 1, var_12, var_13, var_14, var_15);
      var_8.playerlinkent moveto(var_11.origin + var_4, var_3, var_3, 0);
      var_6 thread player_teleport_unlink(var_3);
    }

    if(isDefined(level.zmteleporterroomenter)) {
      [[level.zmteleporterroomenter]](var_0, var_2);
    }

    level.teleportroomindex++;
    level.teleportroomindex = level.teleportroomindex % level.teleportrooms.size;
  }

  wait(var_3);
}

teleport_players(var_0) {
  if(!var_0.size) {
    return;
  }
  if(isDefined(level.teleportroomindex)) {
    teleport_players_through_chute(var_0);
  } else if(isDefined(level.zmteleporterplayers)) {
    [[level.zmteleporterplayers]](var_0);
  }

  var_1 = self.locations;

  if(isDefined(self.overridelocations)) {
    var_1 = self.overridelocations;
    self.overridelocations = undefined;
  }

  while(isDefined(var_1) && var_1.size) {
    var_2 = common_scripts\utility::random(var_1);

    foreach(var_7, var_4 in var_0) {
      var_5 = var_2.origin;
      var_6 = var_2.angles;

      if(var_2.playerlocations.size) {
        var_5 = var_2.playerlocations[var_2.nextplayloc].origin;
        var_6 = var_2.playerlocations[var_2.nextplayloc].angles;
        var_2.nextplayloc++;
        var_2.nextplayloc = var_2.nextplayloc % var_2.playerlocations.size;
      }

      if(isDefined(var_4)) {
        var_4 player_teleport(var_5, var_6);
      }
    }

    if(isDefined(var_2.fxloc)) {
      playFX(common_scripts\utility::getfx("trash_chute_burst"), var_2.fxloc.origin, anglesToForward(var_2.fxloc.angles));
    }

    if(isDefined(var_2.script_wait)) {
      wait(var_2.script_wait);
    }

    var_1 = var_2.locations;
  }

  if(isDefined(level.zmteleporterplayers)) {
    self thread[[level.zmteleporterplayers]](var_0);
  }

  thread reset_teleport_flag_after_time(var_0, 0.75);
}

reset_teleport_flag_after_time(var_0, var_1) {
  wait(var_1);

  foreach(var_3 in var_0) {
    if(isDefined(var_3)) {
      var_3.inteleport = 0;
    }
  }
}

player_teleport(var_0, var_1) {
  self setorigin(var_0, 1);
  self setangles(var_1);
}

set_default_angles() {
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }
}

teleport_error(var_0) {}

teleport_add_location(var_0) {
  if(!isDefined(self.locations)) {
    self.locations = [];
  }

  var_0 set_default_angles();

  if(!isDefined(var_0.playerlocations)) {
    var_0.nextplayloc = 0;
    var_0.playerlocations = [];
  }

  if(isDefined(var_0.script_flag)) {
    common_scripts\utility::flag_wait(var_0.script_flag);
  }

  if(isDefined(var_0.target)) {
    var_1 = common_scripts\utility::getStructArray(var_0.target, "targetname");
    var_2 = [];

    foreach(var_4 in var_1) {
      var_5 = var_4.script_noteworthy;

      if(!isDefined(var_5)) {
        var_5 = "end";
      }

      switch (var_5) {
        case "player":
          var_4 set_default_angles();
          var_0.playerlocations[var_0.playerlocations.size] = var_4;
          break;
        case "end":
          var_2[var_2.size] = var_4;
          break;
        case "fx":
          var_4 set_default_angles();
          var_0.fxloc = var_4;
          break;
        default:
          break;
      }
    }

    if(var_2.size) {
      foreach(var_8 in var_2) {
        var_0 thread teleport_add_location(var_8);
      }

      if(!self.locations.size) {
        var_0 waittill("location_added");
      }
    }
  }

  self notify("location_added");
  self.locations[self.locations.size] = var_0;
}