/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_raid_tripwire.gsc
********************************************************/

runtripwirelogic() {
  setdvarifuninitialized("wall_test_debug", "0");
  level.tripwireplantedmodels = [];
  runtripwirefx();
  level._id_5A61["tripwire"] = ::tripwire_killstreak_helper;
  level._id_5A7D["war_tripwire_mp"] = "tripwire";
  setdvarifuninitialized("scorestreak_enabled_tripwire", 1);
  thread tripwire_preget_animation_distance();
}

runtripwirefx() {
  level._effect["trip_wire_exposion"] = loadfx("vfx/explosion/frag_grenade_concrete");
  level._effect["trip_wire_dust_on_bomb_plant"] = loadfx("vfx/weaponimpact/large_dirt_1");
}

watch_allow_fire() {
  self endon("placed_tripwire");
  common_scripts\utility::_id_A70C(level, "runBomberObjective", self, "kill_player_reticle_think", self, "death", self, "disconnect", self, "weapon_change");
  thread enable_fire();
}

disable_fire() {
  self allowfire(0);
}

enable_fire() {
  self allowfire(1);
}

tripwire_preget_animation_distance() {
  var_0 = (0, 0, 0);
  var_1 = spawn("script_model", var_0);
  var_1 setModel("prop_hus_tripwire_01_sheen_blue");
  var_1 hide();
  var_1 notsolid();
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tripwire_standing");
  var_2 hide();
  var_2 notsolid();
  var_3 = spawn("script_model", var_0);
  var_3 setModel("tripwire_standing");
  var_3 hide();
  var_3 notsolid();
  var_2 scriptmodelplayanim("tripwire_standin_anim", "wire", 0.0, 0.01);
  var_2 setshadowrendering(1);
  var_3 scriptmodelplayanim("tripwire_standin_anim", "wire", 1.0, 1.0);
  var_4 = 3.33333;
  wait(var_4);
  var_5 = var_2 gettagorigin("spike");
  var_6 = var_3 gettagorigin("spike");
  var_1 delete();
  var_2 delete();
  var_3 delete();
  level.raydistance = distance(var_6, var_5);
}

check_wall_under_player_reticle_think(var_0, var_1) {
  var_2 = undefined;
  var_3 = level.raydistance;
  level endon("runBomberObjective");
  level endon("game_ended");
  self endon("kill_player_reticle_think");
  self endon("death");
  self endon("disconnect");
  self endon("weapon_change");
  var_4 = (10.9, 0, 0);
  var_1 hide();
  thread watch_allow_fire();
  thread watch_tripwire_preview_cleanup(var_0, var_1);
  var_5 = (0, 0, 0);
  var_6 = (0, 0, 0);
  var_7 = (0, 0, 0);
  var_8 = (0, 0, 0);
  var_9 = (0, 0, 0);
  var_10 = (0, 0, 0);
  var_11 = 0;

  for(;;) {
    [var_13, var_14] = get_average_surface_normal_under_player_reticle(192);

    if(!self issprinting() && !self isjumping()) {
      if(is_normal_a_wall(var_13, var_14, 20)) {
        var_0 showtoplayer(self);

        if(var_0.model != "prop_hus_tripwire_01_sheen_blue")
          var_0 setModel("prop_hus_tripwire_01_sheen_blue");

        var_1 showtoplayer(self);
        var_0.angles = _combineangles(vectortoangles(var_13), (0, 0, 0));
        var_0.origin = var_14;
        var_15 = _rotatevector(var_4, var_0.angles);
        var_2 = var_0.origin + var_15;
        var_1.angles = (0, var_0.angles[1], var_0.angles[2]);

        if(0)
          var_1.origin = var_2;
        else if(var_0.angles[0] != 0.0) {
          var_16 = (0, var_0.angles[1], 0);
          var_17 = _rotatevector(var_4, var_16);
          var_18 = var_2 - var_17;
          var_1.origin = var_18;
        } else
          var_1.origin = var_0.origin;

        var_19 = undefined;
        var_20 = undefined;
        var_21 = 0;

        if(1) {
          var_22 = var_2 + (0, 0, -5);
          var_23 = bulletTrace(var_2, var_22, 0, self);

          if(var_23["fraction"] < 1.0)
            var_21 = 1;
        }

        if(!var_21) {
          var_24 = var_2 + var_13 * var_3;
          var_24 = (var_24[0], var_24[1], var_2[2]);
          var_19 = bulletTrace(var_2, var_24, 0, self);
          var_20 = var_19["position"] - var_2;
          var_20 = _sqrt(_squared(var_20[0]) + _squared(var_20[1]));
        }

        if(!var_21 && isDefined(var_19["surfacetype"]) && var_19["surfacetype"] != "none" && var_20 > 30) {
          thread enable_fire();
          var_20 = var_20 - 4.0;
          var_25 = var_20 / var_3;
          var_26 = 3.33333;
          var_27 = var_25 * var_26;
          var_1 scriptmodelplayanim("tripwire_standin_anim", "wire", var_27, 0.01);
          var_1 setshadowrendering(1);
          var_5 = var_0.origin;
          var_6 = var_0.angles;
          var_7 = var_1.origin;
          var_8 = var_1.angles;
          var_9 = var_19["position"];
          var_10 = var_2;
          var_11 = var_27;
        } else {
          thread disable_fire();

          if(var_0.model != "prop_hus_tripwire_01_sheen_red")
            var_0 setModel("prop_hus_tripwire_01_sheen_red");

          var_1 scriptmodelplayanim("tripwire_standin_anim", "wire", 0, 0.01);
          var_1 setshadowrendering(1);
          var_1 _meth_8006(self);
        }
      } else {
        thread disable_fire();
        var_0 _meth_8006(self);
        var_1 _meth_8006(self);
      }
    } else {
      thread disable_fire();
      var_0 _meth_8006(self);
      var_1 _meth_8006(self);
    }

    if(self isfiring() && !self ismeleeing()) {
      thread enable_fire();
      self notify("placed_tripwire");
      var_0 showtoplayer(self);

      if(var_0.model != "prop_hus_tripwire_01_sheen_blue")
        var_0 setModel("prop_hus_tripwire_01_sheen_blue");

      var_1 showtoplayer(self);
      var_1 scriptmodelplayanim("tripwire_standin_anim", "wire", var_11, 0.01);
      var_1 setshadowrendering(1);
      var_0.origin = var_5;
      var_0.angles = var_6;
      var_1.origin = var_7;
      var_1.angles = var_8;
      return [var_10, var_9, var_11];
    }

    waitframe();
  }
}

watch_tripwire_preview_cleanup(var_0, var_1) {
  self endon("placed_tripwire");
  common_scripts\utility::_id_A70C(level, "runBomberObjective", self, "death", self, "disconnect", self, "weapon_change");
  self.has_tripwire = 0;
  tripwire_cleanup(var_0, var_1, undefined);
}

watch_tripwire_placing_cleanup(var_0, var_1) {
  self endon("placed_tripwire_complete");
  common_scripts\utility::_id_A70C(level, "runBomberObjective", self, "death", self, "disconnect");
  self.has_tripwire = 0;
  tripwire_cleanup(var_0, var_1, undefined);
}

is_normal_a_wall(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    return 0;

  var_3 = 0;
  var_4 = _asin(vectorNormalize(var_0)[2]);

  if(var_4 > var_2 || var_4 < -1 * var_2)
    var_3 = 0;
  else
    var_3 = 1;

  return var_3;
}

get_average_surface_normal_under_player_reticle(var_0) {
  var_1 = self getEye();
  var_2 = anglesToForward(self _meth_8566());
  var_3 = var_1 + var_2 * var_0;
  var_4 = bullet_trace_for_wall_test(var_1, var_3, self);

  if(var_4["fraction"] < 1.0) {
    var_5 = get_average_surface_normal_at_point(var_4["position"], var_2, var_4["normal"]);
    return [var_5, var_4["position"]];
  }

  return [undefined, var_4["position"]];
}

get_average_surface_normal_from_direction(var_0, var_1, var_2) {
  var_1 = anglesToForward(var_1);
  var_1 = var_1 + (0, -90, 0);
  var_3 = var_0 + var_1 * var_2;
  var_4 = bullet_trace_for_wall_test(var_0, var_3, self);

  if(var_4["fraction"] < 1.0) {
    var_5 = get_average_surface_normal_at_point(var_4["position"], var_1, var_4["normal"]);
    return [var_5, var_4["position"]];
  }

  return [undefined, var_4["position"]];
}

bullet_trace_for_wall_test(var_0, var_1, var_2) {
  return bulletTrace(var_0, var_1, 0, var_2, 0, 0, 0, 0, 1, 0, 0);
}

bullet_trace_for_wall_test_passed(var_0, var_1, var_2) {
  var_3 = bullet_trace_for_wall_test(var_0, var_1, var_2);

  if(var_3["fraction"] < 1.0)
    return 0;

  return 1;
}

get_average_surface_normal_at_point(var_0, var_1, var_2) {
  if(getdvarint("wall_test_debug") > 0) {}

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_5 = var_2 * -1;
  var_3 = (0, 0, 1);
  var_4 = _vectorcross(var_3, var_2);
  var_9 = var_0 + (var_4 + var_3) * 5.0;
  var_10 = 10.0;
  var_11 = 10.0;

  for(var_12 = 0; var_12 <= var_10; var_12++) {
    var_13 = var_12 * 1.0;

    for(var_14 = 0; var_14 <= var_11; var_14++) {
      var_15 = var_14 * 1.0;
      var_16 = var_4 * var_13 + var_3 * var_15;
      var_17 = var_9 - var_16;
      var_6[var_12][var_14] = var_17 - var_5 * 15;
      var_7[var_12][var_14] = var_17 + var_5 * 10;
    }
  }

  for(var_12 = 0; var_12 <= var_10; var_12++) {
    var_8[var_12] = [];

    for(var_14 = 0; var_14 <= var_11; var_14++) {
      var_18 = undefined;
      var_19 = undefined;
      var_20 = var_6[var_12][var_14];
      var_21 = var_7[var_12][var_14];
      var_22 = bullet_trace_for_wall_test(var_20, var_21, self);

      if(var_22["fraction"] < 1.0) {
        var_18 = var_22["position"];
        var_19 = var_22["normal"];
      }

      if(isDefined(var_18))
        var_8[var_12][var_14] = var_19;
    }
  }

  var_25 = 0;
  var_26 = (0, 0, 0);

  for(var_12 = 0; var_12 <= var_10; var_12++) {
    for(var_14 = 0; var_14 <= var_11; var_14++) {
      if(isDefined(var_8[var_12][var_14])) {
        var_26 = var_26 + var_8[var_12][var_14];
        var_25++;
      }
    }
  }

  var_27 = undefined;

  if(var_25 > 0)
    var_27 = var_26 / var_25;

  return var_27;
}

tripwire_killstreak_helper(var_0) {
  var_1 = tripwire_place_anywhere_handler(var_0);

  if(!isDefined(var_1))
    return 0;

  return var_1;
}

tripwire_place_anywhere_handler(var_0) {
  level endon("runBomberObjective");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("weapon_change");

  if(common_scripts\utility::_id_562E(self.has_tripwire))
    return 0;

  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("prop_hus_tripwire_01_sheen_blue");
  var_1 hide();
  var_1 showtoplayer(self);
  var_1 notsolid();
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("tripwire_standing_sheen_blue");
  var_2 notsolid();
  var_2 hide();
  var_3 = check_wall_under_player_reticle_think(var_1, var_2);
  var_4 = var_3[2];
  var_5 = var_3[1] - var_3[0];
  var_6 = vectorNormalize(var_5);
  var_1.hitdir = var_5;
  var_1.startpoint = var_3[0];
  self notify("kill_player_reticle_think");
  thread watch_tripwire_placing_cleanup(var_1, var_2);
  wait 0.3;

  if(1) {
    var_2 scriptmodelclearanim();
    waitframe();
  }

  var_1 solid();
  var_1 setModel("prop_hus_tripwire_01_no_wire");
  var_2 setModel("tripwire_standing");
  var_1 show();
  var_2 show();
  wait 0.03;
  _playfxontag(level._effect["trip_wire_dust_on_bomb_plant"], var_1, "TAG_ORIGIN");
  var_7 = _id_0380::_id_6842("mp_war_tripwire_impact", undefined, var_1.origin);

  if(1) {
    var_2 scriptmodelplayanim("tripwire_plant_anim", "wire", 0, 1);
    var_8 = 0.7;
    wait(var_8 * 0.5);
    var_9 = 0.05;
    var_10 = var_4 - var_9;
    var_2 scriptmodelplayanim("tripwire_idle_anim", "wire", var_10, 0.01, 0);
    wait(var_9);
  }

  var_11 = var_3[1];
  var_11 = var_11 + (0, 0, -3);
  var_12 = 2;
  var_2.spikestart = var_11 - var_12 * var_6;
  var_2.spikeend = var_11 + var_12 * var_6;
  _magicbullet("war_tripwire_impact_fx_mp", var_2.spikestart, var_2.spikeend, self);

  if(1) {
    var_2 scriptmodelclearanim();
    waitframe();
    var_2 scriptmodelplayanim("tripwire_idle_anim", "wire", var_4, 0.01, 0);
    var_2 setshadowrendering(1);
  }

  var_13 = _id_0380::_id_6842("mp_war_tripwire_plant", undefined, var_2.origin);
  thread tripwire_place_anywhere_placed_handler(var_3, var_1, var_2);
  return 1;
}

tripwire_place_anywhere_placed_handler(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("runBomberObjective");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  var_1 endon("tripwire_defused");
  self notify("kill_player_reticle_think");
  self notify("placed_tripwire_complete");
  var_3 = var_0[0] - var_0[1];
  var_4 = vectorNormalize(var_3);
  var_5 = length(var_3);
  var_6 = spawn("trigger_box", var_0[0], 0, (2, 2, var_5));
  var_7 = var_4 * -1;
  var_8 = (0, 0, 1);
  var_9 = _vectorcross(var_8, var_7);
  var_10 = _axistoangles(var_8, var_9, var_7);
  var_6.angles = var_10;
  var_1._id_9D65 = var_6;
  level.tripwireplantedmodels = common_scripts\utility::_id_0F6F(level.tripwireplantedmodels, var_1);
  var_1 thread setuptripwirekillcament(var_1);
  thread tripwire_spawn_damage_trigger(var_1);
  thread tripwire_trigger_wire(var_1, var_6);
  thread tripwire_watch_delete(var_1, var_2, var_6);
  thread tripwire_disarm(var_1);
  thread tripwire_monitor_placed_location(var_1, var_2);

  if(isDefined(self.has_tripwire))
    self.has_tripwire = 0;

  var_1 waittill("tripwire_triggered", var_11);

  if(var_11 == "player") {
    _id_0380::_id_6842("mp_wpn_betty_triggered", undefined, var_1.origin);
    wait 0.1;
    tripwire_detonate(var_1);
  } else
    tripwire_detonate(var_1);
}

tripwire_trigger_wire(var_0, var_1) {
  level endon("game_ended");
  level endon("runBomberObjective");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  var_0 endon("tripwire_defused");
  var_0 endon("tripwire_triggered");
  var_2 = self;
  var_3 = var_2.team;

  if(!isDefined(var_3))
    var_3 = "none";

  while(!isDefined(var_2) && !isDefined(var_2.team) || isDefined(var_2) && !_isstring(var_2) && isDefined(var_2.team) && var_2.team == var_3 || _isstring(var_2) && var_2 != "explode")
    var_1 waittill("trigger", var_2);

  var_0 notify("tripwire_triggered", "player");
}

tripwire_monitor_placed_location(var_0, var_1) {
  level endon("game_ended");
  level endon("runBomberObjective");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  var_0 endon("tripwire_defused");
  var_0 endon("tripwire_triggered");
  waittillframeend;
  var_2 = anglesToForward(var_0.angles);
  var_3 = vectorNormalize(var_2);
  var_4 = var_0.origin + 2 * var_3;
  var_5 = var_0.origin - 2 * var_3;

  while(isDefined(var_0)) {
    if(bullet_trace_for_wall_test_passed(var_4, var_5, var_0) || bullet_trace_for_wall_test_passed(var_1.spikestart, var_1.spikeend, var_1)) {
      var_0 notify("tripwire_triggered", "wall_destroyed");
      return;
    }

    waitframe();
  }
}

disarm_enable_use_watcher(var_0) {
  level endon("game_ended");
  level endon("runBomberObjective");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  var_0 endon("tripwire_triggered");
  var_0 endon("tripwire_defused");
  var_0 endon("tripwire_delete");
  var_1 = self.team;

  foreach(var_3 in level.players) {
    if(isDefined(level.gametype) && level.gametype == "infect") {
      var_0 disableplayeruse(var_3);
      continue;
    }

    if(var_3.team == var_1 || var_3.team == "spectator") {
      var_0 disableplayeruse(var_3);
      continue;
    }

    if(var_3.team != var_1)
      var_0 enableplayeruse(var_3);
  }

  for(;;) {
    level waittill("joined_team", var_3);

    if(isDefined(level.gametype) && level.gametype == "infect") {
      var_0 disableplayeruse(var_3);
      continue;
    }

    if(var_3.team == var_1 || var_3.team == "spectator") {
      var_0 disableplayeruse(var_3);
      continue;
    }

    if(var_3.team != var_1)
      var_0 enableplayeruse(var_3);
  }
}

tripwire_disarm(var_0) {
  level endon("game_ended");
  level endon("runBomberObjective");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  var_0 endon("tripwire_triggered");
  var_0 makeusable();
  var_0 sethintstring(&"RAIDS_TRIPWIRE_DISARM");
  thread disarm_enable_use_watcher(var_0);

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1.team == self.team && var_1.team != "spectator") {
      continue;
    }
    var_0 notify("tripwire_defused");
    var_0 notify("tripwire_delete");
    return;
  }
}

tripwire_detonate(var_0) {
  var_0 radiusdamage(var_0.origin, 200, 200, 50, self, "MOD_EXPLOSIVE", "war_tripwire_mp");
  playFX(common_scripts\utility::_id_44F5("trip_wire_exposion"), var_0.origin);
  _id_0380::_id_6842("mp_war_bomb_explo", undefined, var_0.origin);
  var_0 notify("tripwire_delete");
}

tripwire_cleanup(var_0, var_1, var_2) {
  waittillframeend;

  if(isDefined(var_0))
    var_0 delete();

  if(isDefined(var_1))
    var_1 delete();

  if(isDefined(var_2))
    var_2 delete();

  level.tripwireplantedmodels = common_scripts\utility::_id_0FA0(level.tripwireplantedmodels);
}

tripwire_watch_delete(var_0, var_1, var_2) {
  common_scripts\utility::_id_A70C(level, "game_ended", level, "runBomberObjective", self, "disconnect", self, "joined_team", self, "joined_spectators", var_0, "tripwire_delete");
  tripwire_cleanup(var_0, var_1, var_2);
}

tripwire_spawn_damage_trigger(var_0) {
  level endon("game_ended");
  level endon("runBomberObjective");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  var_0 endon("tripwire_defused");
  var_0 endon("tripwire_triggered");
  var_0 setcandamage(1);
  var_0.maxhealth = 100000;
  var_0 setnormalhealth(self.maxhealth);
  var_0 waittill("damage");
  var_0 notify("tripwire_triggered", "damage");
}

setuptripwirekillcament(var_0) {
  var_1 = var_0.origin + (0, 0, 5);
  var_2 = var_0.origin + anglestoright(var_0.angles + (0, 90, 0)) * 2 + (0, 0, 15);
  var_3 = bulletTrace(var_1, var_2, 0, var_0);
  var_4 = spawn("script_model", var_3["position"]);
  var_4 setModel("tag_origin");
  var_5 = var_0.origin - var_3["position"];
  var_4.angles = vectortoangles(var_5);
  var_4 setscriptmoverkillcam("explosive");
  self._id_5A2C = var_4;
}