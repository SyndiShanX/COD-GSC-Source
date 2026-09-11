/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_spawns.gsc
*****************************************************************/

function ref_126f1(var0) {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  self waittill("player_incursion_spawn_complete");
  wait 1;
  scripts\mp\hud_message::showsplash("br_ri_welcome");
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gametype", self, 0);
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("primary_objective", self, 0);
}

function tank_x1_capacity() {
  level.start_reach_exhaust_waste.ref_12e2c.passes_final_capsule_check = level.start_reach_exhaust_waste.ref_12e2c.ref_1354f;
  level.pilot_tag = &propsetchangesleft;
  level.start_reach_exhaust_waste.ref_12e2c.ref_136a8["allies"] = anglesToForward((0, level.start_reach_exhaust_waste.ref_12e2c.ref_134ff, 0));
  level.start_reach_exhaust_waste.ref_12e2c.ref_136a8["axis"] = anglesToForward((0, level.start_reach_exhaust_waste.ref_12e2c.ref_13500, 0));
  level.start_reach_exhaust_waste.ref_12e2c.ref_13608 = level.start_reach_exhaust_waste.ref_12e2c.ref_13502;
  level.start_reach_exhaust_waste.ref_12e2c.ref_13607 = level.start_reach_exhaust_waste.ref_12e2c.ref_13501;
  level.start_reach_exhaust_waste.ref_12e2c.ref_13631 = level.start_reach_exhaust_waste.ref_12e2c.ref_13532;
  level.start_reach_exhaust_waste.ref_12e2c.ref_13630 = level.start_reach_exhaust_waste.ref_12e2c.ref_13531;
  level.start_reach_exhaust_waste.ref_12e2c.ref_1365e["allies"] = level.start_reach_exhaust_waste.ref_12e2c.ref_13564;
  level.start_reach_exhaust_waste.ref_12e2c.ref_1365e["axis"] = level.start_reach_exhaust_waste.ref_12e2c.ref_13565;
  level.start_reach_exhaust_waste.ref_12e2c.ref_13677 = level.start_reach_exhaust_waste.ref_12e2c.ref_135aa;
  level.start_reach_exhaust_waste.ref_12e2c.ref_13676 = level.start_reach_exhaust_waste.ref_12e2c.ref_135a9;
  var0 = level.start_reach_exhaust_waste.ref_12e2c.ground_detection_think + level.start_reach_exhaust_waste.ref_12e2c.ref_136a8["allies"] * level.start_reach_exhaust_waste.ref_12e2c.circle_radius * level.start_reach_exhaust_waste.ref_12e2c.ref_13631;
  var1 = level.start_reach_exhaust_waste.ref_12e2c.ground_detection_think + level.start_reach_exhaust_waste.ref_12e2c.ref_136a8["axis"] * level.start_reach_exhaust_waste.ref_12e2c.circle_radius * level.start_reach_exhaust_waste.ref_12e2c.ref_13631;
  level.start_reach_exhaust_waste.ref_12e2c.spawnorigin["allies"] = var0;
  level.start_reach_exhaust_waste.ref_12e2c.spawnorigin["axis"] = var1;
  var2 = getdvarint("scr_ri_team_spawn_ground", 0);
  var3 = getdvarint("scr_br_teamsize", 76);
  var4 = int((var3 + 3) / 4);

  if(var2 == 1) {
    if(!isDefined(level.struct_class_names) || !isDefined(level.struct_class_names["targetname"]) || !isDefined(level.struct_class_names["targetname"]["brRumbleInv_team_spawns_axis"]) || !isDefined(level.struct_class_names["targetname"]["brRumbleInv_team_spawns_allies"])) {
      var2 = 0;
    } else if(level.struct_class_names["targetname"]["brRumbleInv_team_spawns_axis"].size < var4 || level.struct_class_names["targetname"]["brRumbleInv_team_spawns_allies"].size < var4) {
      var2 = 0;
    }
  }

  if(var2) {
    if(!isDefined(level.start_reach_exhaust_waste.spawnpoints)) {
      level.start_reach_exhaust_waste.spawnpoints = [];
      level.start_reach_exhaust_waste.spawnpoints["allies"] = scripts\engine\utility::getStructArray("brRumbleInv_team_spawns_allies", "targetname");
      level.start_reach_exhaust_waste.spawnpoints["axis"] = scripts\engine\utility::getStructArray("brRumbleInv_team_spawns_axis", "targetname");
    }

    level.start_reach_exhaust_waste.ref_12e2c.spawnorigin["allies"] = level.start_reach_exhaust_waste.spawnpoints["allies"][0].origin;
    level.start_reach_exhaust_waste.ref_12e2c.spawnorigin["axis"] = level.start_reach_exhaust_waste.spawnpoints["axis"][0].origin;
    level.ref_13678 = 1;
    thread ref_1283e(level);
    return;
  }

  thread ref_1283f();
}

function ref_1283f() {
  level.ref_12ab4 = [];
  level.ref_12ab4["allies"] = [];
  level.ref_12ab4["axis"] = [];
  var0 = getdvarint("scr_br_teamsize", 76);
  var1 = getdvarint("scr_ri_spawn_trace_count", 5);

  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  var2 = 0;
  var3 = scripts\mp\teams::ref_132e6();

  foreach(var5 in level.teamnamelist) {
    if(var3 && var5 == "team_two_hundred") {
      continue;
    }

    for(var6 = 0; var6 < var0; var6++) {
      var7 = spawnStruct();
      var8 = vectortoangles(level.start_reach_exhaust_waste.ref_12e2c.ref_136a8[var5]);
      var9 = randomfloatrange(level.start_reach_exhaust_waste.ref_12e2c.ref_13608, level.start_reach_exhaust_waste.ref_12e2c.ref_13607);
      var10 = anglesToForward((0, var8[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var9, var9 * -1), 0));
      var11 = randomfloatrange(level.start_reach_exhaust_waste.ref_12e2c.ref_13631, level.start_reach_exhaust_waste.ref_12e2c.ref_13630);
      var14 = level.start_reach_exhaust_waste.ref_12e2c.ground_detection_think + var10 * level.start_reach_exhaust_waste.ref_12e2c.circle_radius * var11;

      if(istrue(level.start_reach_exhaust_waste.ref_12e2c.passes_final_capsule_check)) {
        var15 = level.start_reach_exhaust_waste.ref_12e2c.spawnorigin[scripts\mp\utility\game::getotherteam(var5)[0]] - var14;
        var8 = vectortoangles(var15);
      } else {
        var8 = vectortoangles(var10 * -1);
      }

      var16 = scripts\engine\trace::create_default_contents(1);
      var17 = 0;
      var18 = 0;
      var19 = 10;
      var20 = [];

      for(var21 = 0; var21 < var1; var21++) {
        var22 = scripts\engine\trace::ray_trace(var14 + (0, 0, 10000), var14 - (0, 0, 20000) + anglesToForward(var8) * var21 * 2000, undefined, var16)["position"];
        var20 = var22;

        if(var22[2] > var17) {
          var17 = var22[2];
          var18 = var21;
        }

        var2++;

        if(var2 == 5) {
          waitframe();
          var2 = 0;
        }
      }

      var14 = (var14[0], var14[1], var17 + level.start_reach_exhaust_waste.ref_12e2c.ref_1365e[var5]);
      var7.origin = var14;
      var7.ref_13c33 = var20;
      var7.spawn_exfil_heli = var18;
      var7.angles = var8;
      var7.team = var5;
      var7.lastspawntime = 0;
      level.ref_12ab4[var5][level.ref_12ab4[var5].size] = var7;
    }
  }

  foreach(var25 in level.players) {
    var25.updateindangercirclestate = 1;
  }
}

function ref_1283e(var0) {
  level.ref_12ab4 = [];
  level.ref_12ab4["allies"] = [];
  level.ref_12ab4["axis"] = [];
  var1 = getdvarint("scr_ri_spawn_trace_count", 5);

  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  var2 = 0;
  var3 = scripts\mp\teams::ref_132e6();

  foreach(var5 in level.teamnamelist) {
    if(var3 && var5 == "team_two_hundred") {
      continue;
    }

    for(var6 = 0; var6 < var0; var6++) {
      var7 = level.start_reach_exhaust_waste.spawnpoints[var5][var6];
      var8 = rear_minigun_origin_offset(var7.origin, var7.angles);

      for(var9 = 0; var9 < var8.size; var9++) {
        var10 = spawnStruct();
        var11 = var8[var9];
        var12 = randomfloatrange(level.start_reach_exhaust_waste.ref_12e2c.ref_13608, level.start_reach_exhaust_waste.ref_12e2c.ref_13607);
        var13 = anglesToForward((0, var11.angles[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var12, var12 * -1), 0));

        if(istrue(level.start_reach_exhaust_waste.ref_12e2c.passes_final_capsule_check)) {
          var14 = level.start_reach_exhaust_waste.ref_12e2c.spawnorigin[scripts\mp\utility\game::getotherteam(var5)[0]] - var11.origin;
          var15 = vectortoangles(var14);
        } else {
          var15 = vectortoangles(var13 * -1);
        }

        var16 = scripts\engine\trace::create_default_contents(1);
        var17 = 0;
        var18 = 0;
        var19 = 10;
        var20 = [];

        for(var21 = 0; var21 < var1; var21++) {
          var22 = scripts\engine\trace::ray_trace(var11.origin + (0, 0, 10000), var11.origin - (0, 0, 20000) + anglesToForward(var15) * var21 * 2000, undefined, var16)["position"];
          var20 = var22;

          if(var22[2] > var17) {
            var17 = var22[2];
            var18 = var21;
          }

          var2++;

          if(var2 == 5) {
            waitframe();
            var2 = 0;
          }
        }

        var23 = (var11.origin[0], var11.origin[1], var17);
        var10.origin = var23;
        var10.ref_13c33 = var20;
        var10.spawn_exfil_heli = var18;
        var10.angles = var15;
        var10.team = var5;
        var10.lastspawntime = 0;
        level.ref_12ab4[var5][level.ref_12ab4[var5].size] = var10;
      }
    }
  }

  foreach(var26 in level.players) {
    var26.updateindangercirclestate = 1;
  }
}

function rear_minigun_origin_offset(var0, var1) {
  var2 = getdvarint("scr_squad_max", 4);
  var3 = [(120, 0, 0), (0, 120, 0), (0, -120, 0), (-120, 0, 0)];
  var4 = [];
  var5 = anglesToForward(var1);
  var6 = anglestoleft(var1);

  for(var7 = 0; var7 < var3.size; var7++) {
    var8 = spawnStruct();
    var9 = var5[0] * var3[var7][0] + var5[1] * var3[var7][1];
    var10 = var6[0] * var3[var7][0] + var6[1] * var3[var7][1];
    var8.origin = var0 + (var9, var10, 0);
    var8.angles = var1;
    var4 = var8;
  }

  return var4;
}

function rear_door_collision(var0) {
  if(isDefined(self.intel_spawn)) {
    self.ref_12ab3 = self.intel_spawn;
    return self.intel_spawn;
  }

  if(!isDefined(self.ref_12ab3)) {
    self.ref_12ab3 = spawnStruct();
  }

  return print_punchcard(var0);
}

function quest_assdistmin() {
  if(!isDefined(self.ref_12ab3)) {
    self.ref_12ab3 = spawnStruct();
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
      self.ref_145bf = 1;
      self.ref_14066 = 0;
      self.ref_12c9f = "veh_a10fd";
      self.ref_12ab3.origin = (self.ref_12ab3.origin[0], self.ref_12ab3.origin[1], self.ref_12ab3.origin[2] + level.start_reach_exhaust_waste.ref_12e2c.ref_1365e[self.team]);
    } else if(self.warroomtvs == "bomber") {
      self.ref_145bf = 1;
      self.ref_14066 = 1;
      self.ref_12c9f = "veh_bt";
      self.ref_12ab3.origin = (self.ref_12ab3.origin[0], self.ref_12ab3.origin[1], self.ref_12ab3.origin[2] + level.start_reach_exhaust_waste.ref_12e2c.ref_1365e[self.team]);
    } else if(self.warroomtvs == "TI") {
      if(isDefined(self.setspawnpoint)) {
        var0 = self.setspawnpoint;

        if(!istrue(self.setspawnpoint.notti)) {
          self.ti_spawn = 1;
          self playlocalsound("tactical_spawn");

          foreach(var2 in level.teamnamelist) {
            if(var2 != self.team) {
              self playsoundtoteam("tactical_spawn", var2);
            }
          }
        }

        var4 = self.setspawnpoint.playerspawnpos;
        self.ref_12ab3.origin = var4;
        self.ref_12ab3.angles = self.setspawnpoint.playerspawnangles;
        self.ref_12ab3.lifeid = self.lifeid;
        self.ref_12ab3.time = gettime();
        self.intel_spawn = self.ref_12ab3;
        scripts\mp\equipment\tac_insert::ref_13681(0, 1);
        return self.intel_spawn;
      }
    }
  } else if(self.ref_12ab3.team != self.team || self.ref_12ab3.lifeid != self.lifeid) {
    return print_punchcard(1);
  }

  return self.ref_12ab3;
}

function print_punchcard(var0) {
  var1 = randomint(level.ref_12ab4[self.team].size);

  if(istrue(level.ref_13678) && !istrue(var0)) {
    var3 = getdvarint("scr_squad_max", 4);
    var1 = self.squadindex * var3;
    var4 = 0;

    for(var2 = 0; var2 < var3; var2++) {
      if(level.ref_12ab4[self.team][var1].lastspawntime == 0) {
        var4 = 1;
        break;
      }

      var1++;
    }

    if(var4) {}
  }

  var5 = level.ref_12ab4[self.team][var1];

  if(istrue(var0)) {
    for(;;) {
      if(!isDefined(var5.lastspawntime)) {
        break;
      }

      if(gettime() - var5.lastspawntime > 3000) {
        break;
      }

      var1 = randomint(level.ref_12ab4[self.team].size);
      var5 = level.ref_12ab4[self.team][var1];
    }
  }

  level.ref_12ab4[self.team][var1].lastspawntime = gettime();
  self.ref_12ab3.origin = var5.origin;
  self.ref_12ab3.angles = var5.angles;
  self.ref_12ab3.time = gettime();
  self.ref_12ab3.team = self.team;
  self.ref_12ab3.index = -1;
  self.ref_12ab3.lifeid = self.lifeid;
  return self.ref_12ab3;
}

function ref_12496() {
  self endon("disconnect");
  scripts\mp\gametypes\br_public::ref_1264c();
  self.ref_133e7 = 1;
  self.ref_12ca8 = 1;
  self.plotarmor = 1;

  if(!isalive(self)) {
    scripts\mp\playerlogic::spawnplayer(0);
  }

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13f21(self);
  }

  waitframe();
  thread patch_far_wait();
  scripts\mp\gametypes\br_public::ref_126ed();
  self.plotarmor = undefined;
  self.ref_12ca8 = undefined;
  self freezecontrols(1);
  self playerhide();
  thread ref_12495();
}

function ref_12495() {
  self endon("disconnect");
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();
  var0 = quest_assdistmin();
  var1 = scripts\mp\gametypes\br_gulag::ref_1263e(var0);
  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var0, 1, var1, 1, undefined, undefined, undefined, 1);

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13f21(self);
  }

  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  scripts\mp\damage::resetplayervariables();
  thread script_gameobject();

  if(scripts\mp\flags::gameflag("prematch_fade_done")) {
    thread ref_1246e();
  }

  waittillframeend();
  self clearsoundsubmix("mp_br_lobby_fade", 1.5);
  self clearsoundsubmix("deaths_door_mp", 1);
  self.ref_133e7 = 0;
  thread scripts\mp\gametypes\rumble_invasion\br_ri_ui::ref_13ee7();
}

function ref_1246e() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("incursion_remove_spawn_protection");
  self.ref_12d36 = 1;
  thread ref_124cd();
}

function ref_124cd() {
  thread ref_124e2();
  level endon("game_ended");
  self endon("disconnect");
  self endon("incursion_remove_spawn_protection");
  scripts\engine\utility::ref_143bb(10, "vehicle_enter", "weapon_fired", "incursion_remove_spawn_protection_early");
  thread ref_124e1();
}

function ref_124e1() {
  self.ref_12d36 = 0;
  self notify("incursion_remove_spawn_protection");
}

function ref_124e2() {
  self endon("death_or_disconnect");

  while(!self isonground()) {
    waitframe();
  }

  self notify("incursion_remove_spawn_protection_early");
}

function ref_1264f(var0) {
  var0 notify("player_incursion_spawn_complete");
  thread script_gameobject();
  ref_125c8(var0);
}

function ref_125c8(var0) {
  var1 = var0.ref_1358e;

  if(isDefined(var1)) {
    var2 = scripts\common\utility::groundpos(var1.origin);
    var3 = var1.origin[2] - var2[2];

    if(isDefined(var1.vehicle)) {
      var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var1.vehicle, 1);

      if(var4.size > 0 && istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var1.vehicle))) {
        var5 = spawnStruct();
        var5.useonspawn = 1;
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var1.vehicle, var4[0], self, var5);
        return;
      }

      return;
    }

    if(var2 isonground() || var4 < 300) {
      var1 scripts\mp\gametypes\rumble_invasion\br_ri_utils::assignclientmatchdataid();
      var2 scripts\mp\gametypes\rumble_invasion\br_ri_utils::assignclientmatchdataid();
      return;
    }

    return;
  }
}

function playerrespawn(var0, var1) {
  thread ref_126a4(var0);
}

function ref_126a4(var0) {
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

  var1 = level.checkpoint_objective_id;
  var2 = getdvarfloat("scr_ri_respawn_predict_hint_time", 5);

  if(var1 < var2) {
    var1 = var2;
  }

  if(level.ref_12cb4 != 0) {
    var1 = 0;
  }

  thread ref_1333f(var1);
  wait var1;
  self.waitingtospawn = 1;
  emp_drone_proximity_explode(0, var1);
  self.waitingtospawn = 0;
  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  thread patchfix();
  thread ref_1400c();
  self notify("stop_updatePrestreamRespawn");
  var3 = self.ref_12ab3;
  var4 = scripts\mp\gametypes\br_gulag::ref_1263e(var3);
  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  if(!isalive(self)) {
    scripts\mp\playerlogic::spawnplayer(undefined, 0);
  }

  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();
  scripts\mp\gametypes\br_gulag::ref_126f3(1);
  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var3, 1, var4, 1);
  scripts\mp\gametypes\br::ref_13f21(self);
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  scripts\mp\damage::resetplayervariables();

  if(isDefined(self.trophy_get_best_tag)) {
    self.trophy_get_best_tag = undefined;
  }

  if(scripts\mp\flags::gameflag("prematch_fade_done")) {
    thread ref_1246e();
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

function emp_drone_proximity_explode(var0, var1) {
  var2 = 4;
  var3 = 3;
  var4 = var2 + var3;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\gametypes\br::emp_drone_proximity_explode(var0);
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
  self.ref_1358e = undefined;
  self.intel_spawn = undefined;

  if(!isDefined(self.thrust_fx_model)) {
    if(!isDefined(var1)) {
      var1 = 0;
    }

    scripts\mp\gametypes\br_spectate::ref_1252a();
    scripts\mp\gametypes\br::spawnintermission(self.origin + (0, 0, 100), self.angles);
    scripts\mp\spectating::setdisabled();
    self.getterminalhint = gettime();
    var5 = ref_12695();

    if(isPlayer(var5)) {
      var5 thread scripts\mp\rank::giverankxp("br_payload_squadmate_redeploy", 20);
      var5 thread scripts\mp\rank::scoreeventpopup("br_payload_squadmate_redeploy");
    }

    self.warroomtvs = var5;
    self.getthermalscopeperweaponclass = (gettime() - self.getterminalhint) / 1000;
    var6 = quest_assdistmin();
    scripts\mp\gametypes\br_gulag::ref_1263e(var6);
  } else {
    self.thrust_fx_model = undefined;
    scripts\mp\gametypes\br_public::ref_126ed();
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self freezecontrols(0);
}

function ref_1333f(var0) {
  self endon("disconnect");
  ref_12529();
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var0 * 1000));
  scripts\mp\gametypes\br_gulag::ref_131a2(1);

  if(isDefined(var0)) {
    wait var0;
  }

  thread spawn_boss_wave_3();
}

function spawn_boss_wave_3() {
  scripts\mp\gametypes\br_gulag::ref_131a2(0);
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

function script_gameobject() {
  waitframe();
  self.br_armorhealth = self.br_maxarmorhealth;
  scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
}

function patchfix(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(var0) && var0 > 0) {
    wait var0;
  }

  thread patch_mansion_holes();
  var1 = 1;
  wait var1 - 0.25;
  thread scripts\mp\gametypes\rumble_invasion\br_ri_ui::ref_13ee7();
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 2);
  wait 0.25;

  if(getdvarint("scr_ri_use_spawn_intermission_fix", 1) == 1) {
    scripts\mp\gametypes\br_public::ref_1252b();
    var2 = rear_door_collision(1);
    scripts\mp\gametypes\br_spectate::ref_1252a();
    scripts\mp\gametypes\br::spawnintermission(var2.origin, var2.angles);
    scripts\mp\spectating::setdisabled();
    self.trial_moving_target_think = var2.origin;
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
      var0 = undefined;
      var1 = undefined;

      if(self.warroomtvs == "plane") {
        var0 = "a10_warthog_fd";
        var1 = 3;
      } else if(self.warroomtvs == "bomber") {
        var0 = "bt_mp";
        var1 = 6;
      }

      if(isDefined(var0) && isDefined(var1)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::allowfultondropondeath(var0, var1);
        thread scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates(1);
      }

      return;
    } else if(isPlayer(self.warroomtvs) && self.warroomtvs scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
      var2 = scripts\engine\utility::waittill_notify_or_timeout_return("vehicle_enter", 2);

      if(var2 == "vehicle_enter") {
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

function ref_1400c() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      var0 = rear_door_collision(1);
      var1 = gettime();

      if(var1 - self.trial_other_team >= getdvarfloat("scr_ri_spawn_fallback_hint_delay", 2) * 1000) {
        var0 = rear_door_collision(1);
        var2 = scripts\mp\gametypes\br_gulag::ref_1263e(var0);
      }
    } else {
      var0 = rear_door_collision(1);
      var2 = scripts\mp\gametypes\br_gulag::ref_1263e(var0);
    }

    wait 1;
  }
}

function ref_1365d(var0) {
  return scripts\mp\flags::gameflag("prematch_done");
}

function modifyplayerdamage(var0) {
  var1 = var0.damage;
  var2 = var0.attacker;

  if(istrue(self.ref_12d36)) {
    if(isDefined(var2) && (isPlayer(var2) || isbot(var2))) {
      var1 = 0;
      var2 scripts\mp\damagefeedback::updatedamagefeedback("hitspawnprotect");
    }
  }

  return var1;
}

function onplayerkilled(var0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  var1 = var0.victim;
  var2 = var0.attacker;
  _ispointinbadarea::ref_11ff1(var0);
  _initignoredtabspergamemode::ref_11ff1(var0);
  scripts\mp\gametypes\rumble_invasion\br_ri_pe_kill_leader::ref_11ff1(var2, var1, var0.meansofdeath);
  scripts\mp\gametypes\rumble_invasion\br_ri_dom::mantlekill(var2, var1);

  if(!isDefined(var2) || !isPlayer(var2) || !isDefined(var1)) {
    return;
  }

  foreach(var4 in var1 getweaponslist("primary", "exclusive")) {
    var5 = undefined;

    switch (var4.basename) {
      case "iw8_lm_dblmg_mp":
        var5 = "brloot_weapon_lm_dblmg_lege";
        break;
      case "iw8_la_mike32_mp":
        var5 = "brloot_weapon_la_mike32_lege";
        break;
    }

    if(isDefined(var5)) {
      scripts\mp\gametypes\br_pickups::ml_p1_func(var5, scripts\mp\gametypes\br_gametype_rumble_invasion::ref_119f1(var1.origin));
    }
  }

  if(var1 == var2) {
    return;
  }

  scripts\mp\gametypes\rumble_invasion\br_ri_pe_dom::ref_122a7(var2, var1);
  scripts\mp\gametypes\rumble_invasion\br_ri_pe_kill_leader::onriskplayerdisconnect(var2, var1);

  if(isDefined(var2.team)) {
    var7 = level.start_reach_exhaust_waste.spin_fan_blades;

    if(istrue(var2.ref_12827)) {
      var7 *= 2;
    }

    level scripts\mp\gamescore::giveteamscoreforobjective(var2.pers["team"], var7, 0);
    var8 = var1 getownedvehicle();

    if(isDefined(var8) && var8 scripts\mp\gametypes\rumble_invasion\br_ri_vehicles::ref_141b6()) {
      var9 = scripts\engine\utility::ter_op(var8 scripts\mp\gametypes\rumble_invasion\br_ri_vehicles::ref_141b5(), 1, 2);
      level scripts\mp\gamescore::giveteamscoreforobjective(var2.pers["team"], var9, 0);
    }
  }

  if(istrue(level.start_reach_exhaust_waste.inovertime) && isalive(var2)) {
    var2 scripts\mp\gametypes\br_gametype_rumble_invasion::ref_124fa();
    return;
  }
}

function battle_tracks_hidetogglewidget(var0, var1) {
  if(self == var1 || !isDefined(var1)) {
    return;
  }

  var2 = getdvarint("scr_ri_powerup_drop_chance_on_death", 33);
  _keypadscriptableused_bunkeralt::modify_juggernaut_damage(var0, var2);
}

function onplayerconnect(var0) {
  var0 endon("disconnect");
  var0 waittill("spawned_player");

  if(istrue(level.start_reach_exhaust_waste.ref_13376)) {
    var0 scripts\mp\gametypes\br_gametype_rumble_invasion::ref_13e4b();
  }

  thread script_gameobject();
  thread ref_11ff2();
}

function ref_11ff2() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    thread script_gameobject();
  }
}

function playerdropplunderondeath(var0, var1) {
  if(scripts\mp\utility\game::updatehistoryhud(self)) {
    return 1;
  }

  if(istrue(level.gameended)) {
    return 1;
  }

  if(isDefined(self.plundercount) && self.plundercount > 0) {
    var2 = self.plundercount;
  } else {
    var2 = 0;
  }

  if(istrue(self.unicornpoints)) {
    var3 = 0;
    var4 = level.start_reach_exhaust_waste.ref_127b5;
  } else {
    var3 = int(var4 * level.start_reach_exhaust_waste.ref_127be + 0.5);
    var4 = int(level.start_reach_exhaust_waste.ref_127b5 + var4 * level.start_reach_exhaust_waste.ref_127b6 + 0.5);
  }

  self.plundercountondeath = var3;
  scripts\mp\gametypes\br_plunder::playersetplundercount(var3);

  if(var4 <= 0) {
    return;
  }

  scripts\mp\gametypes\br_plunder::ml_p3_func(var4, var2);
  return 1;
}

function get_bombzone_node_to_defuse_on(var0) {
  var1 = self.plundercount * 2;
  var2 = 0;

  if(istrue(var0)) {
    var1 = getdvarint("scr_bomber_spawn_cost", 20);

    if(isDefined(level.vehicle.instances["veh_bt"])) {
      var2 = level.vehicle.instances["veh_a10fd"].size;
    }
  } else {
    var1 = getdvarint("scr_plane_spawn_cost", 10);

    if(isDefined(level.vehicle.instances["veh_a10fd"])) {
      var2 = level.vehicle.instances["veh_a10fd"].size;
    }
  }

  var3 = self.plundercount >= var1 || istrue(level.start_reach_exhaust_waste.inovertime);
  var4 = var2 < level.pickup_truck_initdamage;
  return var4 && var3;
}

function ref_1269b(var0) {
  return istrue(self.triggerrespawnoverlay);
}

function ref_125c4() {
  var0 = "ui_br_open_purchase_killstreak";
  var1 = 0;
  var2 = "ui_br_purchase_killstreak_response";
  var3 = 1;
  self setclientomnvar(var2, var3);
  self setclientomnvar(var0, var1);
  self setclientomnvarbit("ui_br_ri_respawnstate", 0, 0);

  if(isDefined(self)) {
    thread ref_126cf();
    return 1;
  }

  return 0;
}

function ref_126cf() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "kiosk");

  if(isDefined(level.ref_12838) && isDefined(level.ref_12838.area1_targets)) {
    foreach(var1 in level.ref_12838.area1_targets) {
      var2 = _keypadscriptableused_bunkeralt::ref_1249c(var1.ref_138fd);

      if(isDefined(var2)) {
        var2 thread _keypadscriptableused_bunkeralt::isempdamage();
      }
    }
  }

  thread scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  self.triggerrespawnoverlay = 1;
  self.getterminalhint = gettime();
  self playerhide();
  wait 1;
  scripts\mp\gametypes\br_gulag::gulagfadefromblack(1);
  var4 = ref_12695(1);
  self.warroomtvs = var4;
  self.getthermalscopeperweaponclass = (gettime() - self.getterminalhint) / 1000;
  var5 = quest_assdistmin();

  if(isPlayer(var4)) {
    var4 thread scripts\mp\rank::giverankxp("br_payload_squadmate_redeploy", 20);
    var4 thread scripts\mp\rank::scoreeventpopup("br_payload_squadmate_redeploy");
  }

  ref_12648(var5);
  self.triggerrespawnoverlay = undefined;
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "kiosk");
}

function ref_12648(var0) {
  var1 = self;
  level endon("game_ended");
  var1 endon("disconnect");
  thread scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 2);
  var2 = respawntokenclosewithgulag(var1);

  if(isDefined(var2)) {
    var1 cameraunlink(var2);
    var1 scripts\mp\utility\player::restorebasevisionset(0);
    var1 clearclienttriggeraudiozone(0.5);
    var1 thermalvisionoff();
  }

  var3 = 1;
  scripts\mp\gametypes\br::ending_fade_in(var0.origin[0], var0.origin[1], level.juggheli_spawner_jammer5_3);
  self setclientomnvar("ui_br_transition_type", 2);
  var4 = var1 scripts\mp\gametypes\br_gulag::ref_1263e(var0);
  var1 scripts\mp\gametypes\br_public::ref_126ed();
  var1 scripts\mp\gametypes\br_public::ref_1252b();
  wait var3;
  scripts\mp\gametypes\br_public::ref_1264c();

  if(isstring(self.warroomtvs) && (self.warroomtvs == "plane" || self.warroomtvs == "bomber")) {
    scripts\mp\gametypes\br_gulag::ref_126f3();
    scripts\mp\gametypes\br_gulag::ref_1268c();
  } else {
    var1 scripts\mp\gametypes\br_gulag::ref_126c3(var0.origin, var0.angles);

    if(isPlayer(self.warroomtvs)) {
      ref_125c8(var1);
    }

    scripts\mp\gametypes\br_gulag::gulagfadefromblack(1);
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "redeploy");
  waitframe();
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "redeploy");
  var1 playershow();
  var1 setclientomnvar("ui_br_transition_type", 0);
  var1 setclientomnvar("ui_show_spectateHud", -1);
  var1 scripts\mp\gametypes\br_armor::searchcirclesize(1);
  var1.health = var1.maxhealth;
  thread ref_1246e();
  var1 thread scripts\mp\gametypes\br::ref_1195b();
}

function ref_12529() {
  self setclientomnvarbit("ui_br_ri_respawnstate", 0, 1);
  self setclientomnvar("ui_br_ri_respawnstate", 0);
}

function ref_1266b(var0) {
  self setclientomnvar("ui_br_ri_respawnstate", 1);
  self setclientomnvar("ui_br_ri_respawnid", var0 + 1);
}

function ref_12695(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var1 = undefined;

  if(isbot(self) || self calloutmarkerping_getEnt()) {
    if(!isDefined(var1)) {
      var1 = "base";
    }

    return var1;
  }

  thread startspectatorview(var0);
  var2 = 0;
  var3 = 0;
  var4 = 5;
  var5 = 8;
  var6 = 9;
  var7 = 10;
  var8 = 11;
  self setclientomnvarbit("ui_br_ri_respawnstate", 0, 1);
  self setclientomnvar("ui_br_ri_respawnid", var5 + 1);
  var9 = scripts\mp\hud_util::createicon("progress_bar_fill", 400, 35);
  var9.sort = 0;
  var9.color = (0.25, 0.5, 1);
  var9.archived = 0;
  var9.alpha = 0.5;

  if(var2 == 0) {
    var9.alpha = 0;
  }

  var10 = [];

  if(isDefined(level.start_reach_exhaust_waste.maphint_cheese2scriptableused)) {
    var11 = [ &"BR_RUMBLE_INVASION/SPAWN_A", &"BR_RUMBLE_INVASION/SPAWN_B", &"BR_RUMBLE_INVASION/SPAWN_C", &"BR_RUMBLE_INVASION/SPAWN_D", &"BR_RUMBLE_INVASION/SPAWN_E"];
    var12 = [ &"BR_RUMBLE_INVASION/SPAWN_A_HOLD", &"BR_RUMBLE_INVASION/SPAWN_B_HOLD", &"BR_RUMBLE_INVASION/SPAWN_C_HOLD", &"BR_RUMBLE_INVASION/SPAWN_D_HOLD", &"BR_RUMBLE_INVASION/SPAWN_E_HOLD"];

    for(var13 = 0; var13 < level.start_reach_exhaust_waste.maphint_cheese2scriptableused.size; var13++) {
      var14 = level.start_reach_exhaust_waste.maphint_cheese2scriptableused[var13];

      if(isDefined(var14)) {
        var15 = scripts\mp\hud_util::createfontstring("default", 2);
        var15.archived = 0;
        var15.juggernaut_kill_assists_included = var11[var13];
        var15.spawn_lmg_soldiers_03 = var12[var13];
        var15.label = var15.juggernaut_kill_assists_included;
        var15.manned_turret_operator_validation_func = var14;
        var15.spawntype = "dom_flag";
        var15.id = var13 + var3;
        var10 = var15;
      }
    }
  }

  var16 = scripts\mp\hud_util::createfontstring("default", 2);
  var16.archived = 0;
  var16.juggernaut_kill_assists_included = &"BR_RUMBLE_INVASION/SPAWN_BASE";
  var16.spawn_lmg_soldiers_03 = &"BR_RUMBLE_INVASION/SPAWN_BASE_HOLD";
  var16.label = var16.juggernaut_kill_assists_included;
  var16.spawntype = "base";
  var16.id = var5;
  var9.getteamtokenshud = var16;
  var10 = var16;
  var17 = [];
  var18 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var20 in var18) {
    if(var20 == self) {
      continue;
    }

    var21 = scripts\mp\hud_util::createfontstring("default", 1.5);
    var21.archived = 0;
    var21 setplayernamestring(var20);
    var21.player = var20;
    var21.spawntype = "teammate";
    var21.ref_1284f = scripts\mp\hud_util::createfontstring("default", 1.5);
    var21.ref_1284f.archived = 0;
    var21.id = var4 + var17.size;
    var17 = var21;
  }

  var23 = scripts\mp\hud_util::createfontstring("default", 2);
  var23.archived = 0;
  var23.juggernaut_kill_assists_included = &"BR_RUMBLE_INVASION/SPAWN_PLANE";
  var23.spawn_lmg_soldiers_03 = &"BR_RUMBLE_INVASION/SPAWN_PLANE_HOLD";
  var23.ref_12156 = &"BR_RUMBLE_INVASION/SPAWN_PLANE_OT";
  var23.label = var23.juggernaut_kill_assists_included;
  var23.spawntype = "plane";
  var23.id = var6;
  var24 = scripts\mp\hud_util::createfontstring("default", 2);
  var24.archived = 0;
  var24.juggernaut_kill_assists_included = &"BR_RUMBLE_INVASION/SPAWN_BOMBER";
  var24.spawn_lmg_soldiers_03 = &"BR_RUMBLE_INVASION/SPAWN_BOMBER_HOLD";
  var24.ref_12156 = &"BR_RUMBLE_INVASION/SPAWN_BOMBER_OT";
  var24.label = var24.juggernaut_kill_assists_included;
  var24.spawntype = "bomber";
  var24.id = var7;
  var25 = scripts\mp\hud_util::createfontstring("default", 2);
  var25.archived = 0;
  var25.juggernaut_kill_assists_included = &"BR_RUMBLE_INVASION/SPAWN_TI";
  var25.spawn_lmg_soldiers_03 = &"BR_RUMBLE_INVASION/SPAWN_TI_HOLD";
  var25.label = var25.juggernaut_kill_assists_included;
  var25.spawntype = "TI";
  var25.id = var8;

  if(!isDefined(var9.getteamtokenshud)) {
    var9.getteamtokenshud = var10[0];
  }

  var26 = undefined;
  scripts\mp\utility\player::_freezecontrols(0, 1, "spawn_choice");
  var27 = 250;
  var28 = 300;
  var29 = undefined;
  var30 = undefined;
  var31 = undefined;
  var32 = 5;
  var33 = 0;
  var34 = ref_134d7(var10, var17, var23, var24, var25);
  var35 = gettime();

  while(!isDefined(var26)) {
    var36 = var33 > var32;

    if(var36) {
      var34 = ref_134d7(var10, var17, var23, var24, var25);
    }

    var37 = self getnormalizedmovement();
    var38 = var37[0] > 0;
    var39 = var37[0] < 0;

    if(isDefined(var30)) {
      if(gettime() >= var30 || !var38 && !var39) {
        var30 = undefined;
      }
    } else {
      if(var38) {
        var31 = -1;
      } else if(var39) {
        var31 = 1;
      }

      var36 = 1;
    }

    for(var13 = 0; var13 < var34.size; var13++) {
      var40 = var34[var13];

      if(var9.getteamtokenshud == var40) {
        if(var40.spawntype == "teammate " && !isDefined(var40.player)) {
          var9.getteamtokenshud = var10[0];
          var41 = undefined;
          var42 = undefined;
          var29 = undefined;
          var31 = undefined;
        } else if(isDefined(var31)) {
          var43 = var13 + var31;

          if(var43 < 0) {
            var43 = var34.size - 1;
          } else if(var43 >= var34.size) {
            var43 = 0;
          }

          var44 = var34[var43];
          var9.getteamtokenshud = var44;
          var9 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var44.yoffset);
          var31 = undefined;
          var41 = undefined;
          var42 = undefined;
          ref_1266b(var44.id);
          var30 = gettime() + var28;
        } else {
          var9 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var40.yoffset);
        }

        break;
      }
    }

    if(var36) {
      ref_13fe1(var10, var17, var23, var24, var25, var9);
    }

    ref_139d8(var9.getteamtokenshud);
    var31 = undefined;

    if(self useButtonPressed()) {
      if(isDefined(var29) && gettime() >= var29) {
        var45 = var9.getteamtokenshud;

        if(isDefined(var45.manned_turret_operator_validation_func) && (istrue(level.start_reach_exhaust_waste.inovertime) || isDefined(var45.manned_turret_operator_validation_func.get_current_station_signage_structs) && var45.manned_turret_operator_validation_func.get_current_station_signage_structs == self.team)) {
          var26 = var45.manned_turret_operator_validation_func;
        } else if(isDefined(var45.player) && isalive(var45.player) && (!issquadmateindanger(var45.player) || istrue(level.start_reach_exhaust_waste.inovertime))) {
          var26 = var45.player;
        } else if(var45.spawntype == "base") {
          var26 = var45.spawntype;
        } else if(var45.spawntype == "plane" || var45.spawntype == "bomber") {
          var46 = var45.spawntype == "bomber";

          if(get_bombzone_node_to_defuse_on(var46)) {
            if(var46) {
              var47 = getdvarint("scr_bomber_spawn_cost", 20);
            } else {
              var47 = getdvarint("scr_plane_spawn_cost", 10);
            }

            var27 = var46.spawntype;
            var48 = spawnStruct();
            var48.ref_133e4 = 1;

            if(!istrue(level.start_reach_exhaust_waste.inovertime)) {
              scripts\mp\gametypes\br_plunder::playersetplundercount(self.plundercount - var47, var48);
            }
          }
        } else if(var46.spawntype == "TI" && isDefined(self.setspawnpoint)) {
          var27 = var46.spawntype;
        }
      } else if(!isDefined(var30)) {
        var30 = gettime() + var28;
      }
    } else {
      var30 = undefined;
    }

    if(gettime() >= var36 + getdvarint("scr_br_ri_spawn_max_time", 30000)) {
      var27 = "base";
    }

    var34++;
    waitframe();
  }

  self notify("spawnChoice");
  var10 destroy();

  foreach(var50 in var16) {
    var50 destroy();
  }

  foreach(var50 in var18) {
    var50.ref_1284f destroy();
    var50 destroy();
  }

  var24 destroy();
  var25 destroy();
  var26 destroy();
  ref_12529();
  return var27;
}

function ref_134d7(var0, var1, var2, var3, var4) {
  var5 = 30;
  var6 = -1 * (var0.size + var1.size) * var5 / 2;
  var7 = [];

  foreach(var9 in var0) {
    var9 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var6);
    var7 = var9;
    var6 += var5;
  }

  foreach(var12 in var1) {
    if(!isDefined(var12.player)) {
      continue;
    }

    var12 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 50);
    var12.ref_1284f scripts\mp\hud_util::setpoint("RIGHT", "CENTER", 0, 10);
    var7 = var12;
    var6 += var5;
  }

  var2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var6);
  var7 = var2;
  var6 += var5;
  var3 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var6);
  var7 = var3;
  var6 += var5;
  var4 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var6);
  var7 = var4;
  return var7;
}

function processscrapassist(var0, var1, var2) {
  var3 = scripts\mp\gametypes\br_gulag::rocket_fuel_stability(var0, var1);

  if(isDefined(var3)) {
    var3 = scripts\mp\gametypes\br_public::modifyplayer_damage(var3);
    var3 = scripts\mp\gametypes\br::resetcircuitbreakers(var3, (0, 0, var2));
    var4 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var3, var0);
    return powershud(var3, var4);
  }

  return print_punchcard(1);
}

function prophasclonesleft(var0) {
  var1 = getdvarint("scr_ri_dom_spawnRadiusMax", 10000);
  var2 = scripts\cp_mp\parachute::getc130height();

  if(isDefined(level.ref_12ca7)) {
    var2 = level.ref_12ca7;
  }

  return processscrapassist(var0, var1, var2);
}

function recentassaultcount(var0) {
  self.ref_1358e = var0;
  var1 = getdvarint("scr_ri_squad_spawnRadiusMax", 700);
  var2 = undefined;
  var3 = scripts\common\utility::groundpos(var0.origin);
  var4 = var0.origin[2] - var3[2];

  if(var0 isonground() || var4 < 300) {
    var2 = 0;
  } else {
    var2 = scripts\cp_mp\parachute::getc130height();

    if(isDefined(level.ref_12ca7)) {
      var2 = level.ref_12ca7;
    }
  }

  return processscrapassist(var0.origin, var1, var2);
}

function powershud(var0, var1) {
  self.ref_12ab3.origin = var0;
  self.ref_12ab3.angles = var1;
  self.ref_12ab3.time = gettime();
  self.ref_12ab3.team = self.team;
  self.ref_12ab3.index = -1;
  self.ref_12ab3.lifeid = self.lifeid;
  return self.ref_12ab3;
}

function ref_13fe1(var0, var1, var2, var3, var4, var5) {
  var6 = 1;
  var7 = (1, 0, 0);
  var8 = (1, 1, 1);
  var9 = (0, 1, 1);
  var10 = 0;

  foreach(var12 in var1) {
    var13 = 1;

    if(!isDefined(var12.player)) {
      var12.alpha = 0;
      var12.ref_1284f.alpha = 0;
      continue;
    }

    if(!isalive(var12.player)) {
      var12.color = var7;
      var12.ref_1284f.color = var7;
      var12.ref_1284f.label = &"BR_PAYLOAD/SPAWN_DEAD";
      var13 = 0;
      self setclientomnvarbit("ui_br_ri_respawnstate", 7, 1);
    } else if(issquadmateindanger(var12.player)) {
      if(istrue(level.start_reach_exhaust_waste.inovertime)) {
        var12.color = var9;
        var12.ref_1284f.color = var8;
      } else {
        var12.color = var7;
        var12.ref_1284f.color = var7;
        var13 = 0;
      }

      if(var5.getteamtokenshud == var12) {
        var12.ref_1284f.label = &"BR_RUMBLE_INVASION/SPAWN_COMBAT_HOLD";
        var10 = 1;
        self setclientomnvarbit("ui_br_ri_respawnstate", 6, 1);
      } else {
        var12.ref_1284f.label = &"BR_PAYLOAD/SPAWN_COMBAT";
      }
    } else {
      var12.color = var9;
      var12.ref_1284f.color = var8;

      if(var5.getteamtokenshud == var12) {
        var10 = 1;
      }
    }

    if(var6) {
      var12.ref_1284f.alpha = 0;

      if(var5.getteamtokenshud == var12) {
        var12.alpha = 1;
        self setclientomnvarbit("ui_br_ri_respawnstate", 1, var13);
        continue;
      }

      var12.alpha = 0;
    }
  }

  foreach(var16 in var0) {
    if(var6) {
      var16.alpha = 0;
    }

    var17 = var16.spawntype == "base" || isDefined(var16.manned_turret_operator_validation_func.get_current_station_signage_structs) && var16.manned_turret_operator_validation_func.get_current_station_signage_structs == self.team || istrue(level.start_reach_exhaust_waste.inovertime);
    var16.color = scripts\engine\utility::ter_op(var17, var8, var7);

    if(var5.getteamtokenshud == var16 && var17) {
      var16.label = var16.spawn_lmg_soldiers_03;
    } else {
      var16.label = var16.juggernaut_kill_assists_included;
    }

    if(var5.getteamtokenshud == var16) {
      self setclientomnvarbit("ui_br_ri_respawnstate", 1, var17);
      self setclientomnvarbit("ui_br_ri_respawnstate", 2, !var17);
    }
  }

  if(var6) {
    var2.alpha = 0;
  }

  var17 = get_bombzone_node_to_defuse_on(0);
  var2.color = scripts\engine\utility::ter_op(var17, var8, var7);

  if(var5.getteamtokenshud == var2) {
    self setclientomnvarbit("ui_br_ri_respawnstate", 1, var17);
    self setclientomnvarbit("ui_br_ri_respawnstate", 3, !var17);
    self setclientomnvarbit("ui_br_ri_respawnstate", 4, 1);
  }

  if(var5.getteamtokenshud == var2 && var17) {
    var2.label = var2.spawn_lmg_soldiers_03;
  } else if(istrue(level.start_reach_exhaust_waste.inovertime)) {
    var2.label = var2.ref_12156;
  } else {
    var2.label = var2.juggernaut_kill_assists_included;
  }

  if(var6) {
    var3.alpha = 0;
  }

  var17 = get_bombzone_node_to_defuse_on(1);
  var3.color = scripts\engine\utility::ter_op(var17, var8, var7);

  if(var5.getteamtokenshud == var3) {
    self setclientomnvarbit("ui_br_ri_respawnstate", 1, var17);
    self setclientomnvarbit("ui_br_ri_respawnstate", 3, !var17);
    self setclientomnvarbit("ui_br_ri_respawnstate", 5, 1);
  }

  if(var5.getteamtokenshud == var3 && var17) {
    var3.label = var3.spawn_lmg_soldiers_03;
  } else if(istrue(level.start_reach_exhaust_waste.inovertime)) {
    var3.label = var3.ref_12156;
  } else {
    var3.label = var3.juggernaut_kill_assists_included;
  }

  if(var6) {
    var4.alpha = 0;
  }

  var17 = isDefined(self.setspawnpoint);
  var4.color = scripts\engine\utility::ter_op(var17, var8, var7);

  if(var5.getteamtokenshud == var4) {
    self setclientomnvarbit("ui_br_ri_respawnstate", 1, var17);
  }

  if(var5.getteamtokenshud == var4 && var17) {
    var4.label = var4.spawn_lmg_soldiers_03;
    return;
  }

  var4.label = var4.juggernaut_kill_assists_included;
}

function issquadmateindanger(var0) {
  var1 = 5000;
  var2 = 3000;
  var3 = 450;
  var4 = 200;
  var5 = gettime();

  if(isDefined(var0) && isDefined(var0.lastdamagetime) && var0.lastdamagetime + var1 > var5 || isDefined(var0.lasttimedamaged) && var0.lasttimedamaged + var1 > var5) {
    return true;
  }

  if(var0 isonladder()) {
    return true;
  }

  var0 scripts\mp\battlechatter_mp::validaterecentattackers();

  if(isDefined(var0.recentattackers) && var0.recentattackers.size > 0) {
    return true;
  }

  if(isDefined(var0.watch_for_players_touching_ground) && var0.watch_for_players_touching_ground + var2 > var5) {
    return true;
  }

  if(isDefined(var0.watch_for_players_touching_ground) && isDefined(var0.watch_for_players_regrouping_to_plane) && var0.watch_for_players_touching_ground > var0.watch_for_players_regrouping_to_plane || isDefined(var0.watch_for_players_touching_ground) && !isDefined(var0.watch_for_players_regrouping_to_plane)) {
    return true;
  }

  var6 = var0 getspawnbucketforplayer(var3, var4, 1);

  if(isDefined(var6)) {
    return true;
  }

  if(var0 scripts\mp\outofbounds::istouchingoobtrigger()) {
    return true;
  }

  if(!var0 isonground()) {
    var7 = scripts\mp\gametypes\br_public::modifytriggerlocation(var0.origin, 0, -200);

    if(var7["fraction"] == 1) {
      return true;
    }
  }

  return false;
}

function startspectatorview(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  scripts\mp\gametypes\br_spectate::ref_1252a();

  if(isbot(self)) {
    return;
  }

  if(!istrue(var0)) {
    scripts\mp\utility\player::updatesessionstate("spectator");
    scripts\mp\spectating::setdisabled();

    if(isDefined(self.lastdeathangles)) {
      self setplayerangles(self.lastdeathangles);
    }

    waitframe();
  }

  var1 = respawntokenclosewithgulag();

  if(!isDefined(var1)) {
    return;
  }

  self cameralinkTo(var1, "tag_origin", 1);
  self visionsetthermalforplayer("ac130_color");
  self thermalvisionon();
  self playlocalsound("mp_cmd_camera_zoom_out");
  self setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
}

function respawntokenclosewithgulag() {
  if(isDefined(self.play_nuclear_core_vo)) {
    return self.play_nuclear_core_vo;
  }

  var0 = spawn("script_model", (10781, -44968, 35152));
  var0.angles = (41, scripts\engine\utility::ter_op(self.team == "axis", 268, 88), 0);
  var0 setModel("tag_origin");
  var0 hide();
  var0 unmarkkeyframedmover(1);
  var0 showtoplayer(self);
  self.play_nuclear_core_vo = var0;
  return self.play_nuclear_core_vo;
}

function ref_139d8(var0) {
  if(isDefined(self.play_nuclear_core_vo) && !isbot(self)) {
    var1 = ref_12574(var0);
    var2 = var1[0];
    var3 = var1[1];
    var4 = var1[2];
    var1 = undefined;
    ref_13fd8(self.play_nuclear_core_vo, self, var2, var3);
    return;
  }
}

function ref_12574(var0) {
  var1 = level.start_reach_exhaust_waste.ref_12e2c.spawnorigin[self.team];

  if(isDefined(var0)) {
    switch (var0.spawntype) {
      case "dom_flag":
        if(isDefined(var0.manned_turret_operator_validation_func)) {
          var1 = var0.manned_turret_operator_validation_func.curorigin;
        }

        break;
      case "teammate":
        if(isDefined(var0.player)) {
          var1 = var0.player.origin;
        }

        break;
      case "TI":
        if(isDefined(self.setspawnpoint)) {
          var1 = self.setspawnpoint.playerspawnpos;
        } else {
          var1 = level.start_reach_exhaust_waste.ref_12e2c.spawnorigin[self.team];
        }

        break;
      case "plane":
      case "bomber":
      case "base":
      default:
        var1 = level.start_reach_exhaust_waste.ref_12e2c.spawnorigin[self.team];
        break;
    }
  }

  var2 = 41;
  var3 = scripts\engine\utility::ter_op(self.team == "axis", 268, 88);
  var4 = anglesToForward((0, var3, 0));
  var5 = -40000;
  var6 = 30000;
  var7 = (var1[0] + var4[0] * var5, var1[1] + var4[1] * var5, var6);
  var8 = (var2, var3, 0);
  return [var7, var8];
}

function ref_13fd8(var0, var1, var2) {
  self unlink();
  var3 = self.origin;
  var4 = self.angles;
  var5 = 0;

  if(var1[0] != var3[0]) {
    self moveTo(var1, 0.1);
    var5 = 1;
  }

  if(istrue(var5)) {
    var6 = anglesToForward(var2) * 300;
    var6 *= (1, 1, 0);
    var0 earthquakeforplayer(0.03, 15, var1 + var6, 1000);
    return;
  }
}

function propsetchangesleft() {
  var0 = print_punchcard(1);
  return var0.origin;
}