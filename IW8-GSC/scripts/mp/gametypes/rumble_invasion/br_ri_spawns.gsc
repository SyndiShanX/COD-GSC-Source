/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_spawns.gsc
*****************************************************************/

function ref_126F1(var_0) {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  self waittill("player_incursion_spawn_complete");
  wait 1;
  scripts\mp\hud_message::showsplash("br_ri_welcome");
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gametype", self, 0);
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("primary_objective", self, 0);
}

function tank_x1_capacity() {
  level.start_reach_exhaust_waste.ref_12E2C.passes_final_capsule_check = level.start_reach_exhaust_waste.ref_12E2C.ref_1354F;
  level.pilot_tag = &propsetchangesleft;
  level.start_reach_exhaust_waste.ref_12E2C.ref_136A8["allies"] = anglesToForward((0, level.start_reach_exhaust_waste.ref_12E2C.ref_134FF, 0));
  level.start_reach_exhaust_waste.ref_12E2C.ref_136A8["axis"] = anglesToForward((0, level.start_reach_exhaust_waste.ref_12E2C.ref_13500, 0));
  level.start_reach_exhaust_waste.ref_12E2C.ref_13608 = level.start_reach_exhaust_waste.ref_12E2C.ref_13502;
  level.start_reach_exhaust_waste.ref_12E2C.ref_13607 = level.start_reach_exhaust_waste.ref_12E2C.ref_13501;
  level.start_reach_exhaust_waste.ref_12E2C.ref_13631 = level.start_reach_exhaust_waste.ref_12E2C.ref_13532;
  level.start_reach_exhaust_waste.ref_12E2C.ref_13630 = level.start_reach_exhaust_waste.ref_12E2C.ref_13531;
  level.start_reach_exhaust_waste.ref_12E2C.ref_1365E["allies"] = level.start_reach_exhaust_waste.ref_12E2C.ref_13564;
  level.start_reach_exhaust_waste.ref_12E2C.ref_1365E["axis"] = level.start_reach_exhaust_waste.ref_12E2C.ref_13565;
  level.start_reach_exhaust_waste.ref_12E2C.ref_13677 = level.start_reach_exhaust_waste.ref_12E2C.ref_135AA;
  level.start_reach_exhaust_waste.ref_12E2C.ref_13676 = level.start_reach_exhaust_waste.ref_12E2C.ref_135A9;
  var_0 = level.start_reach_exhaust_waste.ref_12E2C.ground_detection_think + level.start_reach_exhaust_waste.ref_12E2C.ref_136A8["allies"] * level.start_reach_exhaust_waste.ref_12E2C.circle_radius * level.start_reach_exhaust_waste.ref_12E2C.ref_13631;
  var_1 = level.start_reach_exhaust_waste.ref_12E2C.ground_detection_think + level.start_reach_exhaust_waste.ref_12E2C.ref_136A8["axis"] * level.start_reach_exhaust_waste.ref_12E2C.circle_radius * level.start_reach_exhaust_waste.ref_12E2C.ref_13631;
  level.start_reach_exhaust_waste.ref_12E2C.spawnorigin["allies"] = var_0;
  level.start_reach_exhaust_waste.ref_12E2C.spawnorigin["axis"] = var_1;
  var_2 = getdvarint("scr_ri_team_spawn_ground", 0);
  var_3 = getdvarint("scr_br_teamsize", 76);
  var_4 = int((var_3 + 3) / 4);

  if(var_2 == 1) {
    if(!isDefined(level.struct_class_names) || !isDefined(level.struct_class_names["targetname"]) || !isDefined(level.struct_class_names["targetname"]["brRumbleInv_team_spawns_axis"]) || !isDefined(level.struct_class_names["targetname"]["brRumbleInv_team_spawns_allies"])) {
      var_2 = 0;
    } else if(level.struct_class_names["targetname"]["brRumbleInv_team_spawns_axis"].size < var_4 || level.struct_class_names["targetname"]["brRumbleInv_team_spawns_allies"].size < var_4) {
      var_2 = 0;
    }
  }

  if(var_2) {
    if(!isDefined(level.start_reach_exhaust_waste.spawnpoints)) {
      level.start_reach_exhaust_waste.spawnpoints = [];
      level.start_reach_exhaust_waste.spawnpoints["allies"] = scripts\engine\utility::getStructArray("brRumbleInv_team_spawns_allies", "targetname");
      level.start_reach_exhaust_waste.spawnpoints["axis"] = scripts\engine\utility::getStructArray("brRumbleInv_team_spawns_axis", "targetname");
    }

    level.start_reach_exhaust_waste.ref_12E2C.spawnorigin["allies"] = level.start_reach_exhaust_waste.spawnpoints["allies"][0].origin;
    level.start_reach_exhaust_waste.ref_12E2C.spawnorigin["axis"] = level.start_reach_exhaust_waste.spawnpoints["axis"][0].origin;
    level.ref_13678 = 1;
    thread ref_1283E(level);
    return;
  }

  thread ref_1283F();
}

function ref_1283F() {
  level.ref_12AB4 = [];
  level.ref_12AB4["allies"] = [];
  level.ref_12AB4["axis"] = [];
  var_0 = getdvarint("scr_br_teamsize", 76);
  var_1 = getdvarint("scr_ri_spawn_trace_count", 5);

  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  var_2 = 0;
  var_3 = scripts\mp\teams::ref_132E6();

  foreach(var_5 in level.teamnamelist) {
    if(var_3 && var_5 == "team_two_hundred") {
      continue;
    }

    for(var_6 = 0; var_6 < var_0; var_6++) {
      var_7 = spawnStruct();
      var_8 = vectortoangles(level.start_reach_exhaust_waste.ref_12E2C.ref_136A8[var_5]);
      var_9 = randomfloatrange(level.start_reach_exhaust_waste.ref_12E2C.ref_13608, level.start_reach_exhaust_waste.ref_12E2C.ref_13607);
      var_10 = anglesToForward((0, var_8[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_9, var_9 * -1), 0));
      var_11 = randomfloatrange(level.start_reach_exhaust_waste.ref_12E2C.ref_13631, level.start_reach_exhaust_waste.ref_12E2C.ref_13630);
      var_14 = level.start_reach_exhaust_waste.ref_12E2C.ground_detection_think + var_10 * level.start_reach_exhaust_waste.ref_12E2C.circle_radius * var_11;

      if(istrue(level.start_reach_exhaust_waste.ref_12E2C.passes_final_capsule_check)) {
        var_15 = level.start_reach_exhaust_waste.ref_12E2C.spawnorigin[scripts\mp\utility\game::getotherteam(var_5)[0]] - var_14;
        var_8 = vectortoangles(var_15);
      } else {
        var_8 = vectortoangles(var_10 * -1);
      }

      var_16 = scripts\engine\trace::create_default_contents(1);
      var_17 = 0;
      var_18 = 0;
      var_19 = 10;
      var_20 = [];

      for(var_21 = 0; var_21 < var_1; var_21++) {
        var_22 = scripts\engine\trace::ray_trace(var_14 + (0, 0, 10000), var_14 - (0, 0, 20000) + anglesToForward(var_8) * var_21 * 2000, undefined, var_16)["position"];
        var_20 = var_22;

        if(var_22[2] > var_17) {
          var_17 = var_22[2];
          var_18 = var_21;
        }

        var_2++;

        if(var_2 == 5) {
          waitframe();
          var_2 = 0;
        }
      }

      var_14 = (var_14[0], var_14[1], var_17 + level.start_reach_exhaust_waste.ref_12E2C.ref_1365E[var_5]);
      var_7.origin = var_14;
      var_7.ref_13C33 = var_20;
      var_7.spawn_exfil_heli = var_18;
      var_7.angles = var_8;
      var_7.team = var_5;
      var_7.lastspawntime = 0;
      level.ref_12AB4[var_5][level.ref_12AB4[var_5].size] = var_7;
    }
  }

  foreach(var_25 in level.players) {
    var_25.updateindangercirclestate = 1;
  }
}

function ref_1283E(var_0) {
  level.ref_12AB4 = [];
  level.ref_12AB4["allies"] = [];
  level.ref_12AB4["axis"] = [];
  var_1 = getdvarint("scr_ri_spawn_trace_count", 5);

  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  var_2 = 0;
  var_3 = scripts\mp\teams::ref_132E6();

  foreach(var_5 in level.teamnamelist) {
    if(var_3 && var_5 == "team_two_hundred") {
      continue;
    }

    for(var_6 = 0; var_6 < var_0; var_6++) {
      var_7 = level.start_reach_exhaust_waste.spawnpoints[var_5][var_6];
      var_8 = rear_minigun_origin_offset(var_7.origin, var_7.angles);

      for(var_9 = 0; var_9 < var_8.size; var_9++) {
        var_10 = spawnStruct();
        var_11 = var_8[var_9];
        var_12 = randomfloatrange(level.start_reach_exhaust_waste.ref_12E2C.ref_13608, level.start_reach_exhaust_waste.ref_12E2C.ref_13607);
        var_13 = anglesToForward((0, var_11.angles[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_12, var_12 * -1), 0));

        if(istrue(level.start_reach_exhaust_waste.ref_12E2C.passes_final_capsule_check)) {
          var_14 = level.start_reach_exhaust_waste.ref_12E2C.spawnorigin[scripts\mp\utility\game::getotherteam(var_5)[0]] - var_11.origin;
          var_15 = vectortoangles(var_14);
        } else {
          var_15 = vectortoangles(var_13 * -1);
        }

        var_16 = scripts\engine\trace::create_default_contents(1);
        var_17 = 0;
        var_18 = 0;
        var_19 = 10;
        var_20 = [];

        for(var_21 = 0; var_21 < var_1; var_21++) {
          var_22 = scripts\engine\trace::ray_trace(var_11.origin + (0, 0, 10000), var_11.origin - (0, 0, 20000) + anglesToForward(var_15) * var_21 * 2000, undefined, var_16)["position"];
          var_20 = var_22;

          if(var_22[2] > var_17) {
            var_17 = var_22[2];
            var_18 = var_21;
          }

          var_2++;

          if(var_2 == 5) {
            waitframe();
            var_2 = 0;
          }
        }

        var_23 = (var_11.origin[0], var_11.origin[1], var_17);
        var_10.origin = var_23;
        var_10.ref_13C33 = var_20;
        var_10.spawn_exfil_heli = var_18;
        var_10.angles = var_15;
        var_10.team = var_5;
        var_10.lastspawntime = 0;
        level.ref_12AB4[var_5][level.ref_12AB4[var_5].size] = var_10;
      }
    }
  }

  foreach(var_26 in level.players) {
    var_26.updateindangercirclestate = 1;
  }
}

function rear_minigun_origin_offset(var_0, var_1) {
  var_2 = getdvarint("scr_squad_max", 4);
  var_3 = [(120, 0, 0), (0, 120, 0), (0, -120, 0), (-120, 0, 0)];
  var_4 = [];
  var_5 = anglesToForward(var_1);
  var_6 = anglestoleft(var_1);

  for(var_7 = 0; var_7 < var_3.size; var_7++) {
    var_8 = spawnStruct();
    var_9 = var_5[0] * var_3[var_7][0] + var_5[1] * var_3[var_7][1];
    var_10 = var_6[0] * var_3[var_7][0] + var_6[1] * var_3[var_7][1];
    var_8.origin = var_0 + (var_9, var_10, 0);
    var_8.angles = var_1;
    var_4 = var_8;
  }

  return var_4;
}

function rear_door_collision(var_0) {
  if(isDefined(self.intel_spawn)) {
    self.ref_12AB3 = self.intel_spawn;
    return self.intel_spawn;
  }

  if(!isDefined(self.ref_12AB3)) {
    self.ref_12AB3 = spawnStruct();
  }

  return print_punchcard(var_0);
}

function quest_assdistmin() {
  if(!isDefined(self.ref_12AB3)) {
    self.ref_12AB3 = spawnStruct();
    return print_punchcard();
  }

  self.ti_spawn = 0;

  if(isDefined(self.warroomtvs)) {
    if(isPlayer(self.warroomtvs)) {
      self.intel_spawn = recentassaultcount(self.warroomtvs);
      return self.intel_spawn;
    }

    if(isstruct(self.warroomtvs)) {
      if(isDefined(self.warroomtvs.trigger)) {
        self.intel_spawn = prophasclonesleft(self.warroomtvs.trigger.origin);
        return self.intel_spawn;
      }
    } else if(self.warroomtvs == "base") {
      self.intel_spawn = print_punchcard(1);
      return self.intel_spawn;
    } else if(self.warroomtvs == "plane") {
      self.ref_145BF = 1;
      self.ref_14066 = 0;
      self.ref_12C9F = "veh_a10fd";
      self.ref_12AB3.origin = (self.ref_12AB3.origin[0], self.ref_12AB3.origin[1], self.ref_12AB3.origin[2] + level.start_reach_exhaust_waste.ref_12E2C.ref_1365E[self.team]);
    } else if(self.warroomtvs == "bomber") {
      self.ref_145BF = 1;
      self.ref_14066 = 1;
      self.ref_12C9F = "veh_bt";
      self.ref_12AB3.origin = (self.ref_12AB3.origin[0], self.ref_12AB3.origin[1], self.ref_12AB3.origin[2] + level.start_reach_exhaust_waste.ref_12E2C.ref_1365E[self.team]);
    } else if(self.warroomtvs == "TI") {
      if(isDefined(self.setspawnpoint)) {
        var_0 = self.setspawnpoint;

        if(!istrue(self.setspawnpoint.notti)) {
          self.ti_spawn = 1;
          self playlocalsound("tactical_spawn");

          foreach(var_2 in level.teamnamelist) {
            if(var_2 != self.team) {
              self playsoundtoteam("tactical_spawn", var_2);
            }
          }
        }

        var_4 = self.setspawnpoint.playerspawnpos;
        self.ref_12AB3.origin = var_4;
        self.ref_12AB3.angles = self.setspawnpoint.playerspawnangles;
        self.ref_12AB3.lifeid = self.lifeid;
        self.ref_12AB3.time = gettime();
        self.intel_spawn = self.ref_12AB3;
        scripts\mp\equipment\tac_insert::ref_13681(0, 1);
        return self.intel_spawn;
      }
    }
  } else if(self.ref_12AB3.team != self.team || self.ref_12AB3.lifeid != self.lifeid) {
    return print_punchcard(1);
  }

  return self.ref_12AB3;
}

function print_punchcard(var_0) {
  var_1 = randomint(level.ref_12AB4[self.team].size);

  if(istrue(level.ref_13678) && !istrue(var_0)) {
    var_3 = getdvarint("scr_squad_max", 4);
    var_1 = self.squadindex * var_3;
    var_4 = 0;

    for(var_2 = 0; var_2 < var_3; var_2++) {
      if(level.ref_12AB4[self.team][var_1].lastspawntime == 0) {
        var_4 = 1;
        break;
      }

      var_1++;
    }

    if(var_4) {}
  }

  var_5 = level.ref_12AB4[self.team][var_1];

  if(istrue(var_0)) {
    for(;;) {
      if(!isDefined(var_5.lastspawntime)) {
        break;
      }

      if(gettime() - var_5.lastspawntime > 3000) {
        break;
      }

      var_1 = randomint(level.ref_12AB4[self.team].size);
      var_5 = level.ref_12AB4[self.team][var_1];
    }
  }

  level.ref_12AB4[self.team][var_1].lastspawntime = gettime();
  self.ref_12AB3.origin = var_5.origin;
  self.ref_12AB3.angles = var_5.angles;
  self.ref_12AB3.time = gettime();
  self.ref_12AB3.team = self.team;
  self.ref_12AB3.index = -1;
  self.ref_12AB3.lifeid = self.lifeid;
  return self.ref_12AB3;
}

function ref_12496() {
  self endon("disconnect");
  scripts\mp\gametypes\br_public::ref_1264C();
  self.ref_133E7 = 1;
  self.ref_12CA8 = 1;
  self.plotarmor = 1;

  if(!isalive(self)) {
    scripts\mp\playerlogic::spawnplayer(0);
  }

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13F21(self);
  }

  waitframe();
  thread patch_far_wait();
  scripts\mp\gametypes\br_public::ref_126ED();
  self.plotarmor = undefined;
  self.ref_12CA8 = undefined;
  self freezecontrols(1);
  self playerhide();
  thread ref_12495();
}

function ref_12495() {
  self endon("disconnect");
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();
  var_0 = quest_assdistmin();
  var_1 = scripts\mp\gametypes\br_gulag::ref_1263E(var_0);
  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var_0, 1, var_1, 1, undefined, undefined, undefined, 1);

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13F21(self);
  }

  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  scripts\mp\damage::resetplayervariables();
  thread script_gameobject();

  if(scripts\mp\flags::gameflag("prematch_fade_done")) {
    thread ref_1246E();
  }

  waittillframeend();
  self clearsoundsubmix("mp_br_lobby_fade", 1.5);
  self clearsoundsubmix("deaths_door_mp", 1);
  self.ref_133E7 = 0;
  thread scripts\mp\gametypes\rumble_invasion\br_ri_ui::ref_13EE7();
}

function ref_1246E() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("incursion_remove_spawn_protection");
  self.ref_12D36 = 1;
  thread ref_124CD();
}

function ref_124CD() {
  thread ref_124E2();
  level endon("game_ended");
  self endon("disconnect");
  self endon("incursion_remove_spawn_protection");
  scripts\engine\utility::ref_143BB(10, "vehicle_enter", "weapon_fired", "incursion_remove_spawn_protection_early");
  thread ref_124E1();
}

function ref_124E1() {
  self.ref_12D36 = 0;
  self notify("incursion_remove_spawn_protection");
}

function ref_124E2() {
  self endon("death_or_disconnect");

  while(!self isonground()) {
    waitframe();
  }

  self notify("incursion_remove_spawn_protection_early");
}

function ref_1264F(var_0) {
  var_0 notify("player_incursion_spawn_complete");
  thread script_gameobject();
  ref_125C8(var_0);
}

function ref_125C8(var_0) {
  var_1 = var_0.ref_1358E;

  if(isDefined(var_1)) {
    var_2 = scripts\common\utility::groundpos(var_1.origin);
    var_3 = var_1.origin[2] - var_2[2];

    if(isDefined(var_1.vehicle)) {
      var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var_1.vehicle, 1);

      if(var_4.size > 0 && istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var_1.vehicle))) {
        var_5 = spawnStruct();
        var_5.useonspawn = 1;
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_1.vehicle, var_4[0], self, var_5);
        return;
      }

      return;
    }

    if(var_2 isonground() || var_4 < 300) {
      var_1 scripts\mp\gametypes\rumble_invasion\br_ri_utils::assignclientmatchdataid();
      var_2 scripts\mp\gametypes\rumble_invasion\br_ri_utils::assignclientmatchdataid();
      return;
    }

    return;
  }
}

function playerrespawn(var_0, var_1) {
  thread ref_126A4(var_0);
}

function ref_126A4(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    thread patch_mansion_holes();
    scripts\mp\gametypes\br::emp_drone_proximity_explode();
    return;
  }

  wait 3;

  while(istrue(self.killcam)) {
    waitframe();
  }

  var_1 = level.checkpoint_objective_id;
  var_2 = getdvarfloat("scr_ri_respawn_predict_hint_time", 5);

  if(var_1 < var_2) {
    var_1 = var_2;
  }

  if(level.ref_12CB4 != 0) {
    var_1 = 0;
  }

  thread ref_1333F(var_1);
  wait var_1;
  self.waitingtospawn = 1;
  emp_drone_proximity_explode(0, var_1);
  self.waitingtospawn = 0;
  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  thread patchfix();
  thread ref_1400C();
  self notify("stop_updatePrestreamRespawn");
  var_3 = self.ref_12AB3;
  var_4 = scripts\mp\gametypes\br_gulag::ref_1263E(var_3);
  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  if(!isalive(self)) {
    scripts\mp\playerlogic::spawnplayer(undefined, 0);
  }

  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();
  scripts\mp\gametypes\br_gulag::ref_126F3(1);
  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var_3, 1, var_4, 1);
  scripts\mp\gametypes\br::ref_13F21(self);
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  scripts\mp\damage::resetplayervariables();

  if(isDefined(self.trophy_get_best_tag)) {
    self.trophy_get_best_tag = undefined;
  }

  if(scripts\mp\flags::gameflag("prematch_fade_done")) {
    thread ref_1246E();
    return;
  }
}

function emp_drone_should_take_damage() {
  self endon("disconnect");
  self waittill("brWaitAndSpawnClientComplete");
  self clearpredictedstreampos();
  self setclientomnvar("ui_br_transition_type", 0);

  if(scripts\mp\flags::gameflag("infil_complete")) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }
}

function emp_drone_proximity_explode(var_0, var_1) {
  var_2 = 4;
  var_3 = 3;
  var_4 = var_2 + var_3;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\gametypes\br::emp_drone_proximity_explode(var_0);
    return;
  }

  if(isbot(self) || self calloutmarkerping_getEnt()) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }

  ref_12529();
  self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 1);

  if(istrue(level.gameended)) {
    level waittill("forever");
  }

  thread emp_drone_should_take_damage();
  self.ref_1358E = undefined;
  self.intel_spawn = undefined;

  if(!isDefined(self.thrust_fx_model)) {
    if(!isDefined(var_1)) {
      var_1 = 0;
    }

    scripts\mp\gametypes\br_spectate::ref_1252A();
    scripts\mp\gametypes\br::spawnintermission(self.origin + (0, 0, 100), self.angles);
    scripts\mp\spectating::setdisabled();
    self.getterminalhint = gettime();
    var_5 = ref_12695();

    if(isPlayer(var_5)) {
      var_5 thread scripts\mp\rank::giverankxp("br_payload_squadmate_redeploy", 20);
      var_5 thread scripts\mp\rank::scoreeventpopup("br_payload_squadmate_redeploy");
    }

    self.warroomtvs = var_5;
    self.getthermalscopeperweaponclass = (gettime() - self.getterminalhint) / 1000;
    var_6 = quest_assdistmin();
    scripts\mp\gametypes\br_gulag::ref_1263E(var_6);
  } else {
    self.thrust_fx_model = undefined;
    scripts\mp\gametypes\br_public::ref_126ED();
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self freezecontrols(0);
}

function ref_1333F(var_0) {
  self endon("disconnect");
  ref_12529();
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_0 * 1000));
  scripts\mp\gametypes\br_gulag::ref_131A2(1);

  if(isDefined(var_0)) {
    wait var_0;
  }

  thread spawn_boss_wave_3();
}

function spawn_boss_wave_3() {
  scripts\mp\gametypes\br_gulag::ref_131A2(0);
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

function script_gameobject() {
  waitframe();
  self.br_armorhealth = self.br_maxarmorhealth;
  scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
}

function patchfix(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  thread patch_mansion_holes();
  var_1 = 1;
  wait var_1 - 0.25;
  thread scripts\mp\gametypes\rumble_invasion\br_ri_ui::ref_13EE7();
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 2);
  wait 0.25;

  if(getdvarint("scr_ri_use_spawn_intermission_fix", 1) == 1) {
    scripts\mp\gametypes\br_public::ref_1252B();
    var_2 = rear_door_collision(1);
    scripts\mp\gametypes\br_spectate::ref_1252A();
    scripts\mp\gametypes\br::spawnintermission(var_2.origin, var_2.angles);
    scripts\mp\spectating::setdisabled();
    self.trial_moving_target_think = var_2.origin;
    self.trial_other_team = gettime();
    scripts\engine\utility::ent_flag_set("playerRespawn_intermission_spawned");
    return;
  }
}

function patch_mansion_holes() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  self waittill("spawned_player");

  if(isDefined(self.warroomtvs)) {
    if(isstring(self.warroomtvs) && (self.warroomtvs == "plane" || self.warroomtvs == "bomber")) {
      self waittill("vehicle_enter");
      var_0 = undefined;
      var_1 = undefined;

      if(self.warroomtvs == "plane") {
        var_0 = "a10_warthog_fd";
        var_1 = 3;
      } else if(self.warroomtvs == "bomber") {
        var_0 = "bt_mp";
        var_1 = 6;
      }

      if(isDefined(var_0) && isDefined(var_1)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::allowfultondropondeath(var_0, var_1);
        thread scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates(1);
      }

      return;
    } else if(isPlayer(self.warroomtvs) && self.warroomtvs scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
      var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("vehicle_enter", 2);

      if(var_2 == "vehicle_enter") {
        scripts\mp\gametypes\br_gulag::gulagfadefromblack(1);
      }

      return;
    }
  }

  scripts\mp\gametypes\br_gulag::gulagfadefromblack(1);
}

function patch_far_wait() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
}

function ref_1400C() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      var_0 = rear_door_collision(1);
      var_1 = gettime();

      if(var_1 - self.trial_other_team >= getdvarfloat("scr_ri_spawn_fallback_hint_delay", 2) * 1000) {
        var_0 = rear_door_collision(1);
        var_2 = scripts\mp\gametypes\br_gulag::ref_1263E(var_0);
      }
    } else {
      var_0 = rear_door_collision(1);
      var_2 = scripts\mp\gametypes\br_gulag::ref_1263E(var_0);
    }

    wait 1;
  }
}

function ref_1365D(var_0) {
  return scripts\mp\flags::gameflag("prematch_done");
}

function modifyplayerdamage(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.attacker;

  if(istrue(self.ref_12D36)) {
    if(isDefined(var_2) && (isPlayer(var_2) || isbot(var_2))) {
      var_1 = 0;
      var_2 scripts\mp\damagefeedback::updatedamagefeedback("hitspawnprotect");
    }
  }

  return var_1;
}

function onplayerkilled(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  var_1 = var_0.victim;
  var_2 = var_0.attacker;
  _ispointinbadarea::ref_11FF1(var_0);
  _initignoredtabspergamemode::ref_11FF1(var_0);
  scripts\mp\gametypes\rumble_invasion\br_ri_pe_kill_leader::ref_11FF1(var_2, var_1, var_0.meansofdeath);
  scripts\mp\gametypes\rumble_invasion\br_ri_dom::mantlekill(var_2, var_1);

  if(!isDefined(var_2) || !isPlayer(var_2) || !isDefined(var_1)) {
    return;
  }

  foreach(var_4 in var_1 getweaponslist("primary", "exclusive")) {
    var_5 = undefined;

    switch (var_4.basename) {
      case "iw8_lm_dblmg_mp":
        var_5 = "brloot_weapon_lm_dblmg_lege";
        break;
      case "iw8_la_mike32_mp":
        var_5 = "brloot_weapon_la_mike32_lege";
        break;
    }

    if(isDefined(var_5)) {
      scripts\mp\gametypes\br_pickups::ml_p1_func(var_5, scripts\mp\gametypes\br_gametype_rumble_invasion::ref_119F1(var_1.origin));
    }
  }

  if(var_1 == var_2) {
    return;
  }

  scripts\mp\gametypes\rumble_invasion\br_ri_pe_dom::ref_122A7(var_2, var_1);
  scripts\mp\gametypes\rumble_invasion\br_ri_pe_kill_leader::onriskplayerdisconnect(var_2, var_1);

  if(isDefined(var_2.team)) {
    var_7 = level.start_reach_exhaust_waste.spin_fan_blades;

    if(istrue(var_2.ref_12827)) {
      var_7 *= 2;
    }

    level scripts\mp\gamescore::giveteamscoreforobjective(var_2.pers["team"], var_7, 0);
    var_8 = var_1 getownedvehicle();

    if(isDefined(var_8) && var_8 scripts\mp\gametypes\rumble_invasion\br_ri_vehicles::ref_141B6()) {
      var_9 = scripts\engine\utility::ter_op(var_8 scripts\mp\gametypes\rumble_invasion\br_ri_vehicles::ref_141B5(), 1, 2);
      level scripts\mp\gamescore::giveteamscoreforobjective(var_2.pers["team"], var_9, 0);
    }
  }

  if(istrue(level.start_reach_exhaust_waste.inovertime) && isalive(var_2)) {
    var_2 scripts\mp\gametypes\br_gametype_rumble_invasion::ref_124FA();
    return;
  }
}

function battle_tracks_hidetogglewidget(var_0, var_1) {
  if(self == var_1 || !isDefined(var_1)) {
    return;
  }

  var_2 = getdvarint("scr_ri_powerup_drop_chance_on_death", 33);
  _keypadscriptableused_bunkeralt::modify_juggernaut_damage(var_0, var_2);
}

function onplayerconnect(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");

  if(istrue(level.start_reach_exhaust_waste.ref_13376)) {
    var_0 scripts\mp\gametypes\br_gametype_rumble_invasion::ref_13E4B();
  }

  thread script_gameobject();
  thread ref_11FF2();
}

function ref_11FF2() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    thread script_gameobject();
  }
}

function playerdropplunderondeath(var_0, var_1) {
  if(scripts\mp\utility\game::updatehistoryhud(self)) {
    return 1;
  }

  if(istrue(level.gameended)) {
    return 1;
  }

  if(isDefined(self.plundercount) && self.plundercount > 0) {
    var_2 = self.plundercount;
  } else {
    var_2 = 0;
  }

  if(istrue(self.unicornpoints)) {
    var_3 = 0;
    var_4 = level.start_reach_exhaust_waste.ref_127B5;
  } else {
    var_3 = int(var_4 * level.start_reach_exhaust_waste.ref_127BE + 0.5);
    var_4 = int(level.start_reach_exhaust_waste.ref_127B5 + var_4 * level.start_reach_exhaust_waste.ref_127B6 + 0.5);
  }

  self.plundercountondeath = var_3;
  scripts\mp\gametypes\br_plunder::playersetplundercount(var_3);

  if(var_4 <= 0) {
    return;
  }

  scripts\mp\gametypes\br_plunder::ml_p3_func(var_4, var_2);
  return 1;
}

function get_bombzone_node_to_defuse_on(var_0) {
  var_1 = self.plundercount * 2;
  var_2 = 0;

  if(istrue(var_0)) {
    var_1 = getdvarint("scr_bomber_spawn_cost", 20);

    if(isDefined(level.vehicle.instances["veh_bt"])) {
      var_2 = level.vehicle.instances["veh_a10fd"].size;
    }
  } else {
    var_1 = getdvarint("scr_plane_spawn_cost", 10);

    if(isDefined(level.vehicle.instances["veh_a10fd"])) {
      var_2 = level.vehicle.instances["veh_a10fd"].size;
    }
  }

  var_3 = self.plundercount >= var_1 || istrue(level.start_reach_exhaust_waste.inovertime);
  var_4 = var_2 < level.pickup_truck_initdamage;
  return var_4 && var_3;
}

function ref_1269B(var_0) {
  return istrue(self.triggerrespawnoverlay);
}

function ref_125C4() {
  var_0 = "ui_br_open_purchase_killstreak";
  var_1 = 0;
  var_2 = "ui_br_purchase_killstreak_response";
  var_3 = 1;
  self setclientomnvar(var_2, var_3);
  self setclientomnvar(var_0, var_1);
  self setclientomnvarbit("ui_br_ri_respawnstate", 0, 0);

  if(isDefined(self)) {
    thread ref_126CF();
    return 1;
  }

  return 0;
}

function ref_126CF() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "kiosk");

  if(isDefined(level.ref_12838) && isDefined(level.ref_12838.area1_targets)) {
    foreach(var_1 in level.ref_12838.area1_targets) {
      var_2 = _keypadscriptableused_bunkeralt::ref_1249C(var_1.ref_138FD);

      if(isDefined(var_2)) {
        var_2 thread _keypadscriptableused_bunkeralt::isempdamage();
      }
    }
  }

  thread scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  self.triggerrespawnoverlay = 1;
  self.getterminalhint = gettime();
  self playerhide();
  wait 1;
  scripts\mp\gametypes\br_gulag::gulagfadefromblack(1);
  var_4 = ref_12695(1);
  self.warroomtvs = var_4;
  self.getthermalscopeperweaponclass = (gettime() - self.getterminalhint) / 1000;
  var_5 = quest_assdistmin();

  if(isPlayer(var_4)) {
    var_4 thread scripts\mp\rank::giverankxp("br_payload_squadmate_redeploy", 20);
    var_4 thread scripts\mp\rank::scoreeventpopup("br_payload_squadmate_redeploy");
  }

  ref_12648(var_5);
  self.triggerrespawnoverlay = undefined;
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "kiosk");
}

function ref_12648(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("disconnect");
  thread scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 2);
  var_2 = respawntokenclosewithgulag(var_1);

  if(isDefined(var_2)) {
    var_1 cameraunlink(var_2);
    var_1 scripts\mp\utility\player::restorebasevisionset(0);
    var_1 clearclienttriggeraudiozone(0.5);
    var_1 thermalvisionoff();
  }

  var_3 = 1;
  scripts\mp\gametypes\br::ending_fade_in(var_0.origin[0], var_0.origin[1], level.juggheli_spawner_jammer5_3);
  self setclientomnvar("ui_br_transition_type", 2);
  var_4 = var_1 scripts\mp\gametypes\br_gulag::ref_1263E(var_0);
  var_1 scripts\mp\gametypes\br_public::ref_126ED();
  var_1 scripts\mp\gametypes\br_public::ref_1252B();
  wait var_3;
  scripts\mp\gametypes\br_public::ref_1264C();

  if(isstring(self.warroomtvs) && (self.warroomtvs == "plane" || self.warroomtvs == "bomber")) {
    scripts\mp\gametypes\br_gulag::ref_126F3();
    scripts\mp\gametypes\br_gulag::ref_1268C();
  } else {
    var_1 scripts\mp\gametypes\br_gulag::ref_126C3(var_0.origin, var_0.angles);

    if(isPlayer(self.warroomtvs)) {
      ref_125C8(var_1);
    }

    scripts\mp\gametypes\br_gulag::gulagfadefromblack(1);
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "redeploy");
  waitframe();
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "redeploy");
  var_1 playershow();
  var_1 setclientomnvar("ui_br_transition_type", 0);
  var_1 setclientomnvar("ui_show_spectateHud", -1);
  var_1 scripts\mp\gametypes\br_armor::searchcirclesize(1);
  var_1.health = var_1.maxhealth;
  thread ref_1246E();
  var_1 thread scripts\mp\gametypes\br::ref_1195B();
}

function ref_12529() {
  self setclientomnvarbit("ui_br_ri_respawnstate", 0, 1);
  self setclientomnvar("ui_br_ri_respawnstate", 0);
}

function ref_1266B(var_0) {
  self setclientomnvar("ui_br_ri_respawnstate", 1);
  self setclientomnvar("ui_br_ri_respawnid", var_0 + 1);
}

function ref_12695(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = undefined;

  if(isbot(self) || self calloutmarkerping_getEnt()) {
    if(!isDefined(var_1)) {
      var_1 = "base";
    }

    return var_1;
  }

  thread startspectatorview(var_0);
  var_2 = 0;
  var_3 = 0;
  var_4 = 5;
  var_5 = 8;
  var_6 = 9;
  var_7 = 10;
  var_8 = 11;
  self setclientomnvarbit("ui_br_ri_respawnstate", 0, 1);
  self setclientomnvar("ui_br_ri_respawnid", var_5 + 1);
  var_9 = scripts\mp\hud_util::createicon("progress_bar_fill", 400, 35);
  var_9.sort = 0;
  var_9.color = (0.25, 0.5, 1);
  var_9.archived = 0;
  var_9.alpha = 0.5;

  if(var_2 == 0) {
    var_9.alpha = 0;
  }

  var_10 = [];

  if(isDefined(level.start_reach_exhaust_waste.maphint_cheese2scriptableused)) {
    var_11 = [ &"BR_RUMBLE_INVASION/SPAWN_A", &"BR_RUMBLE_INVASION/SPAWN_B", &"BR_RUMBLE_INVASION/SPAWN_C", &"BR_RUMBLE_INVASION/SPAWN_D", &"BR_RUMBLE_INVASION/SPAWN_E"];
    var_12 = [ &"BR_RUMBLE_INVASION/SPAWN_A_HOLD", &"BR_RUMBLE_INVASION/SPAWN_B_HOLD", &"BR_RUMBLE_INVASION/SPAWN_C_HOLD", &"BR_RUMBLE_INVASION/SPAWN_D_HOLD", &"BR_RUMBLE_INVASION/SPAWN_E_HOLD"];

    for(var_13 = 0; var_13 < level.start_reach_exhaust_waste.maphint_cheese2scriptableused.size; var_13++) {
      var_14 = level.start_reach_exhaust_waste.maphint_cheese2scriptableused[var_13];

      if(isDefined(var_14)) {
        var_15 = scripts\mp\hud_util::createfontstring("default", 2);
        var_15.archived = 0;
        var_15.juggernaut_kill_assists_included = var_11[var_13];
        var_15.spawn_lmg_soldiers_03 = var_12[var_13];
        var_15.label = var_15.juggernaut_kill_assists_included;
        var_15.manned_turret_operator_validation_func = var_14;
        var_15.spawntype = "dom_flag";
        var_15.id = var_13 + var_3;
        var_10 = var_15;
      }
    }
  }

  var_16 = scripts\mp\hud_util::createfontstring("default", 2);
  var_16.archived = 0;
  var_16.juggernaut_kill_assists_included = &"BR_RUMBLE_INVASION/SPAWN_BASE";
  var_16.spawn_lmg_soldiers_03 = &"BR_RUMBLE_INVASION/SPAWN_BASE_HOLD";
  var_16.label = var_16.juggernaut_kill_assists_included;
  var_16.spawntype = "base";
  var_16.id = var_5;
  var_9.getteamtokenshud = var_16;
  var_10 = var_16;
  var_17 = [];
  var_18 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var_20 in var_18) {
    if(var_20 == self) {
      continue;
    }

    var_21 = scripts\mp\hud_util::createfontstring("default", 1.5);
    var_21.archived = 0;
    var_21 setplayernamestring(var_20);
    var_21.player = var_20;
    var_21.spawntype = "teammate";
    var_21.ref_1284F = scripts\mp\hud_util::createfontstring("default", 1.5);
    var_21.ref_1284F.archived = 0;
    var_21.id = var_4 + var_17.size;
    var_17 = var_21;
  }

  var_23 = scripts\mp\hud_util::createfontstring("default", 2);
  var_23.archived = 0;
  var_23.juggernaut_kill_assists_included = &"BR_RUMBLE_INVASION/SPAWN_PLANE";
  var_23.spawn_lmg_soldiers_03 = &"BR_RUMBLE_INVASION/SPAWN_PLANE_HOLD";
  var_23.ref_12156 = &"BR_RUMBLE_INVASION/SPAWN_PLANE_OT";
  var_23.label = var_23.juggernaut_kill_assists_included;
  var_23.spawntype = "plane";
  var_23.id = var_6;
  var_24 = scripts\mp\hud_util::createfontstring("default", 2);
  var_24.archived = 0;
  var_24.juggernaut_kill_assists_included = &"BR_RUMBLE_INVASION/SPAWN_BOMBER";
  var_24.spawn_lmg_soldiers_03 = &"BR_RUMBLE_INVASION/SPAWN_BOMBER_HOLD";
  var_24.ref_12156 = &"BR_RUMBLE_INVASION/SPAWN_BOMBER_OT";
  var_24.label = var_24.juggernaut_kill_assists_included;
  var_24.spawntype = "bomber";
  var_24.id = var_7;
  var_25 = scripts\mp\hud_util::createfontstring("default", 2);
  var_25.archived = 0;
  var_25.juggernaut_kill_assists_included = &"BR_RUMBLE_INVASION/SPAWN_TI";
  var_25.spawn_lmg_soldiers_03 = &"BR_RUMBLE_INVASION/SPAWN_TI_HOLD";
  var_25.label = var_25.juggernaut_kill_assists_included;
  var_25.spawntype = "TI";
  var_25.id = var_8;

  if(!isDefined(var_9.getteamtokenshud)) {
    var_9.getteamtokenshud = var_10[0];
  }

  var_26 = undefined;
  scripts\mp\utility\player::_freezecontrols(0, 1, "spawn_choice");
  var_27 = 250;
  var_28 = 300;
  var_29 = undefined;
  var_30 = undefined;
  var_31 = undefined;
  var_32 = 5;
  var_33 = 0;
  var_34 = ref_134D7(var_10, var_17, var_23, var_24, var_25);
  var_35 = gettime();

  while(!isDefined(var_26)) {
    var_36 = var_33 > var_32;

    if(var_36) {
      var_34 = ref_134D7(var_10, var_17, var_23, var_24, var_25);
    }

    var_37 = self getnormalizedmovement();
    var_38 = var_37[0] > 0;
    var_39 = var_37[0] < 0;

    if(isDefined(var_30)) {
      if(gettime() >= var_30 || !var_38 && !var_39) {
        var_30 = undefined;
      }
    } else {
      if(var_38) {
        var_31 = -1;
      } else if(var_39) {
        var_31 = 1;
      }

      var_36 = 1;
    }

    for(var_13 = 0; var_13 < var_34.size; var_13++) {
      var_40 = var_34[var_13];

      if(var_9.getteamtokenshud == var_40) {
        if(var_40.spawntype == "teammate " && !isDefined(var_40.player)) {
          var_9.getteamtokenshud = var_10[0];
          var_41 = undefined;
          var_42 = undefined;
          var_29 = undefined;
          var_31 = undefined;
        } else if(isDefined(var_31)) {
          var_43 = var_13 + var_31;

          if(var_43 < 0) {
            var_43 = var_34.size - 1;
          } else if(var_43 >= var_34.size) {
            var_43 = 0;
          }

          var_44 = var_34[var_43];
          var_9.getteamtokenshud = var_44;
          var_9 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_44.yoffset);
          var_31 = undefined;
          var_41 = undefined;
          var_42 = undefined;
          ref_1266B(var_44.id);
          var_30 = gettime() + var_28;
        } else {
          var_9 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_40.yoffset);
        }

        break;
      }
    }

    if(var_36) {
      ref_13FE1(var_10, var_17, var_23, var_24, var_25, var_9);
    }

    ref_139D8(var_9.getteamtokenshud);
    var_31 = undefined;

    if(self useButtonPressed()) {
      if(isDefined(var_29) && gettime() >= var_29) {
        var_45 = var_9.getteamtokenshud;

        if(isDefined(var_45.manned_turret_operator_validation_func) && (istrue(level.start_reach_exhaust_waste.inovertime) || isDefined(var_45.manned_turret_operator_validation_func.get_current_station_signage_structs) && var_45.manned_turret_operator_validation_func.get_current_station_signage_structs == self.team)) {
          var_26 = var_45.manned_turret_operator_validation_func;
        } else if(isDefined(var_45.player) && isalive(var_45.player) && (!issquadmateindanger(var_45.player) || istrue(level.start_reach_exhaust_waste.inovertime))) {
          var_26 = var_45.player;
        } else if(var_45.spawntype == "base") {
          var_26 = var_45.spawntype;
        } else if(var_45.spawntype == "plane" || var_45.spawntype == "bomber") {
          var_46 = var_45.spawntype == "bomber";

          if(get_bombzone_node_to_defuse_on(var_46)) {
            if(var_46) {
              var_47 = getdvarint("scr_bomber_spawn_cost", 20);
            } else {
              var_47 = getdvarint("scr_plane_spawn_cost", 10);
            }

            var_27 = var_46.spawntype;
            var_48 = spawnStruct();
            var_48.ref_133E4 = 1;

            if(!istrue(level.start_reach_exhaust_waste.inovertime)) {
              scripts\mp\gametypes\br_plunder::playersetplundercount(self.plundercount - var_47, var_48);
            }
          }
        } else if(var_46.spawntype == "TI" && isDefined(self.setspawnpoint)) {
          var_27 = var_46.spawntype;
        }
      } else if(!isDefined(var_30)) {
        var_30 = gettime() + var_28;
      }
    } else {
      var_30 = undefined;
    }

    if(gettime() >= var_36 + getdvarint("scr_br_ri_spawn_max_time", 30000)) {
      var_27 = "base";
    }

    var_34++;
    waitframe();
  }

  self notify("spawnChoice");
  var_10 destroy();

  foreach(var_50 in var_16) {
    var_50 destroy();
  }

  foreach(var_50 in var_18) {
    var_50.ref_1284F destroy();
    var_50 destroy();
  }

  var_24 destroy();
  var_25 destroy();
  var_26 destroy();
  ref_12529();
  return var_27;
}

function ref_134D7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 30;
  var_6 = -1 * (var_0.size + var_1.size) * var_5 / 2;
  var_7 = [];

  foreach(var_9 in var_0) {
    var_9 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_6);
    var_7 = var_9;
    var_6 += var_5;
  }

  foreach(var_12 in var_1) {
    if(!isDefined(var_12.player)) {
      continue;
    }

    var_12 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 50);
    var_12.ref_1284F scripts\mp\hud_util::setpoint("RIGHT", "CENTER", 0, 10);
    var_7 = var_12;
    var_6 += var_5;
  }

  var_2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_6);
  var_7 = var_2;
  var_6 += var_5;
  var_3 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_6);
  var_7 = var_3;
  var_6 += var_5;
  var_4 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_6);
  var_7 = var_4;
  return var_7;
}

function processscrapassist(var_0, var_1, var_2) {
  var_3 = scripts\mp\gametypes\br_gulag::rocket_fuel_stability(var_0, var_1);

  if(isDefined(var_3)) {
    var_3 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_3);
    var_3 = scripts\mp\gametypes\br::resetcircuitbreakers(var_3, (0, 0, var_2));
    var_4 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var_3, var_0);
    return powershud(var_3, var_4);
  }

  return print_punchcard(1);
}

function prophasclonesleft(var_0) {
  var_1 = getdvarint("scr_ri_dom_spawnRadiusMax", 10000);
  var_2 = scripts\cp_mp\parachute::getc130height();

  if(isDefined(level.ref_12CA7)) {
    var_2 = level.ref_12CA7;
  }

  return processscrapassist(var_0, var_1, var_2);
}

function recentassaultcount(var_0) {
  self.ref_1358E = var_0;
  var_1 = getdvarint("scr_ri_squad_spawnRadiusMax", 700);
  var_2 = undefined;
  var_3 = scripts\common\utility::groundpos(var_0.origin);
  var_4 = var_0.origin[2] - var_3[2];

  if(var_0 isonground() || var_4 < 300) {
    var_2 = 0;
  } else {
    var_2 = scripts\cp_mp\parachute::getc130height();

    if(isDefined(level.ref_12CA7)) {
      var_2 = level.ref_12CA7;
    }
  }

  return processscrapassist(var_0.origin, var_1, var_2);
}

function powershud(var_0, var_1) {
  self.ref_12AB3.origin = var_0;
  self.ref_12AB3.angles = var_1;
  self.ref_12AB3.time = gettime();
  self.ref_12AB3.team = self.team;
  self.ref_12AB3.index = -1;
  self.ref_12AB3.lifeid = self.lifeid;
  return self.ref_12AB3;
}

function ref_13FE1(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 1;
  var_7 = (1, 0, 0);
  var_8 = (1, 1, 1);
  var_9 = (0, 1, 1);
  var_10 = 0;

  foreach(var_12 in var_1) {
    var_13 = 1;

    if(!isDefined(var_12.player)) {
      var_12.alpha = 0;
      var_12.ref_1284F.alpha = 0;
      continue;
    }

    if(!isalive(var_12.player)) {
      var_12.color = var_7;
      var_12.ref_1284F.color = var_7;
      var_12.ref_1284F.label = &"BR_PAYLOAD/SPAWN_DEAD";
      var_13 = 0;
      self setclientomnvarbit("ui_br_ri_respawnstate", 7, 1);
    } else if(issquadmateindanger(var_12.player)) {
      if(istrue(level.start_reach_exhaust_waste.inovertime)) {
        var_12.color = var_9;
        var_12.ref_1284F.color = var_8;
      } else {
        var_12.color = var_7;
        var_12.ref_1284F.color = var_7;
        var_13 = 0;
      }

      if(var_5.getteamtokenshud == var_12) {
        var_12.ref_1284F.label = &"BR_RUMBLE_INVASION/SPAWN_COMBAT_HOLD";
        var_10 = 1;
        self setclientomnvarbit("ui_br_ri_respawnstate", 6, 1);
      } else {
        var_12.ref_1284F.label = &"BR_PAYLOAD/SPAWN_COMBAT";
      }
    } else {
      var_12.color = var_9;
      var_12.ref_1284F.color = var_8;

      if(var_5.getteamtokenshud == var_12) {
        var_10 = 1;
      }
    }

    if(var_6) {
      var_12.ref_1284F.alpha = 0;

      if(var_5.getteamtokenshud == var_12) {
        var_12.alpha = 1;
        self setclientomnvarbit("ui_br_ri_respawnstate", 1, var_13);
        continue;
      }

      var_12.alpha = 0;
    }
  }

  foreach(var_16 in var_0) {
    if(var_6) {
      var_16.alpha = 0;
    }

    var_17 = var_16.spawntype == "base" || isDefined(var_16.manned_turret_operator_validation_func.get_current_station_signage_structs) && var_16.manned_turret_operator_validation_func.get_current_station_signage_structs == self.team || istrue(level.start_reach_exhaust_waste.inovertime);
    var_16.color = scripts\engine\utility::ter_op(var_17, var_8, var_7);

    if(var_5.getteamtokenshud == var_16 && var_17) {
      var_16.label = var_16.spawn_lmg_soldiers_03;
    } else {
      var_16.label = var_16.juggernaut_kill_assists_included;
    }

    if(var_5.getteamtokenshud == var_16) {
      self setclientomnvarbit("ui_br_ri_respawnstate", 1, var_17);
      self setclientomnvarbit("ui_br_ri_respawnstate", 2, !var_17);
    }
  }

  if(var_6) {
    var_2.alpha = 0;
  }

  var_17 = get_bombzone_node_to_defuse_on(0);
  var_2.color = scripts\engine\utility::ter_op(var_17, var_8, var_7);

  if(var_5.getteamtokenshud == var_2) {
    self setclientomnvarbit("ui_br_ri_respawnstate", 1, var_17);
    self setclientomnvarbit("ui_br_ri_respawnstate", 3, !var_17);
    self setclientomnvarbit("ui_br_ri_respawnstate", 4, 1);
  }

  if(var_5.getteamtokenshud == var_2 && var_17) {
    var_2.label = var_2.spawn_lmg_soldiers_03;
  } else if(istrue(level.start_reach_exhaust_waste.inovertime)) {
    var_2.label = var_2.ref_12156;
  } else {
    var_2.label = var_2.juggernaut_kill_assists_included;
  }

  if(var_6) {
    var_3.alpha = 0;
  }

  var_17 = get_bombzone_node_to_defuse_on(1);
  var_3.color = scripts\engine\utility::ter_op(var_17, var_8, var_7);

  if(var_5.getteamtokenshud == var_3) {
    self setclientomnvarbit("ui_br_ri_respawnstate", 1, var_17);
    self setclientomnvarbit("ui_br_ri_respawnstate", 3, !var_17);
    self setclientomnvarbit("ui_br_ri_respawnstate", 5, 1);
  }

  if(var_5.getteamtokenshud == var_3 && var_17) {
    var_3.label = var_3.spawn_lmg_soldiers_03;
  } else if(istrue(level.start_reach_exhaust_waste.inovertime)) {
    var_3.label = var_3.ref_12156;
  } else {
    var_3.label = var_3.juggernaut_kill_assists_included;
  }

  if(var_6) {
    var_4.alpha = 0;
  }

  var_17 = isDefined(self.setspawnpoint);
  var_4.color = scripts\engine\utility::ter_op(var_17, var_8, var_7);

  if(var_5.getteamtokenshud == var_4) {
    self setclientomnvarbit("ui_br_ri_respawnstate", 1, var_17);
  }

  if(var_5.getteamtokenshud == var_4 && var_17) {
    var_4.label = var_4.spawn_lmg_soldiers_03;
    return;
  }

  var_4.label = var_4.juggernaut_kill_assists_included;
}

function issquadmateindanger(var_0) {
  var_1 = 5000;
  var_2 = 3000;
  var_3 = 450;
  var_4 = 200;
  var_5 = gettime();

  if(isDefined(var_0) && isDefined(var_0.lastdamagetime) && var_0.lastdamagetime + var_1 > var_5 || isDefined(var_0.lasttimedamaged) && var_0.lasttimedamaged + var_1 > var_5) {
    return true;
  }

  if(var_0 isonladder()) {
    return true;
  }

  var_0 scripts\mp\battlechatter_mp::validaterecentattackers();

  if(isDefined(var_0.recentattackers) && var_0.recentattackers.size > 0) {
    return true;
  }

  if(isDefined(var_0.watch_for_players_touching_ground) && var_0.watch_for_players_touching_ground + var_2 > var_5) {
    return true;
  }

  if(isDefined(var_0.watch_for_players_touching_ground) && isDefined(var_0.watch_for_players_regrouping_to_plane) && var_0.watch_for_players_touching_ground > var_0.watch_for_players_regrouping_to_plane || isDefined(var_0.watch_for_players_touching_ground) && !isDefined(var_0.watch_for_players_regrouping_to_plane)) {
    return true;
  }

  var_6 = var_0 getspawnbucketforplayer(var_3, var_4, 1);

  if(isDefined(var_6)) {
    return true;
  }

  if(var_0 scripts\mp\outofbounds::istouchingoobtrigger()) {
    return true;
  }

  if(!var_0 isonground()) {
    var_7 = scripts\mp\gametypes\br_public::modifytriggerlocation(var_0.origin, 0, -200);

    if(var_7["fraction"] == 1) {
      return true;
    }
  }

  return false;
}

function startspectatorview(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  scripts\mp\gametypes\br_spectate::ref_1252A();

  if(isbot(self)) {
    return;
  }

  if(!istrue(var_0)) {
    scripts\mp\utility\player::updatesessionstate("spectator");
    scripts\mp\spectating::setdisabled();

    if(isDefined(self.lastdeathangles)) {
      self setplayerangles(self.lastdeathangles);
    }

    waitframe();
  }

  var_1 = respawntokenclosewithgulag();

  if(!isDefined(var_1)) {
    return;
  }

  self cameralinkTo(var_1, "tag_origin", 1);
  self visionsetthermalforplayer("ac130_color");
  self thermalvisionon();
  self playlocalsound("mp_cmd_camera_zoom_out");
  self setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
}

function respawntokenclosewithgulag() {
  if(isDefined(self.play_nuclear_core_vo)) {
    return self.play_nuclear_core_vo;
  }

  var_0 = spawn("script_model", (10781, -44968, 35152));
  var_0.angles = (41, scripts\engine\utility::ter_op(self.team == "axis", 268, 88), 0);
  var_0 setModel("tag_origin");
  var_0 hide();
  var_0 unmarkkeyframedmover(1);
  var_0 showtoplayer(self);
  self.play_nuclear_core_vo = var_0;
  return self.play_nuclear_core_vo;
}

function ref_139D8(var_0) {
  if(isDefined(self.play_nuclear_core_vo) && !isbot(self)) {
    var_1 = ref_12574(var_0);
    var_2 = var_1[0];
    var_3 = var_1[1];
    var_4 = var_1[2];
    var_1 = undefined;
    ref_13FD8(self.play_nuclear_core_vo, self, var_2, var_3);
    return;
  }
}

function ref_12574(var_0) {
  var_1 = level.start_reach_exhaust_waste.ref_12E2C.spawnorigin[self.team];

  if(isDefined(var_0)) {
    switch (var_0.spawntype) {
      case "dom_flag":
        if(isDefined(var_0.manned_turret_operator_validation_func)) {
          var_1 = var_0.manned_turret_operator_validation_func.curorigin;
        }

        break;
      case "teammate":
        if(isDefined(var_0.player)) {
          var_1 = var_0.player.origin;
        }

        break;
      case "TI":
        if(isDefined(self.setspawnpoint)) {
          var_1 = self.setspawnpoint.playerspawnpos;
        } else {
          var_1 = level.start_reach_exhaust_waste.ref_12E2C.spawnorigin[self.team];
        }

        break;
      case "plane":
      case "bomber":
      case "base":
      default:
        var_1 = level.start_reach_exhaust_waste.ref_12E2C.spawnorigin[self.team];
        break;
    }
  }

  var_2 = 41;
  var_3 = scripts\engine\utility::ter_op(self.team == "axis", 268, 88);
  var_4 = anglesToForward((0, var_3, 0));
  var_5 = -40000;
  var_6 = 30000;
  var_7 = (var_1[0] + var_4[0] * var_5, var_1[1] + var_4[1] * var_5, var_6);
  var_8 = (var_2, var_3, 0);
  return [var_7, var_8];
}

function ref_13FD8(var_0, var_1, var_2) {
  self unlink();
  var_3 = self.origin;
  var_4 = self.angles;
  var_5 = 0;

  if(var_1[0] != var_3[0]) {
    self moveTo(var_1, 0.1);
    var_5 = 1;
  }

  if(istrue(var_5)) {
    var_6 = anglesToForward(var_2) * 300;
    var_6 *= (1, 1, 0);
    var_0 earthquakeforplayer(0.03, 15, var_1 + var_6, 1000);
    return;
  }
}

function propsetchangesleft() {
  var_0 = print_punchcard(1);
  return var_0.origin;
}