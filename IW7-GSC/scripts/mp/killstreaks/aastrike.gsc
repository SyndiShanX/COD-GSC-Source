/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\aastrike.gsc
***********************************************/

init() {
  precacheitem("aamissile_projectile_mp");
  precachemodel("vehicle_av8b_harrier_jet_mp");
  level.teamairdenied["axis"] = 0;
  level.teamairdenied["allies"] = 0;
  level.rockets = [];
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("aastrike", ::tryuseaastrike);
}

tryuseaastrike(var_0, var_1) {
  scripts\mp\matchdata::logkillstreakevent("aastrike", self.origin);
  thread finishaastrike(var_0);
  thread scripts\mp\utility::teamplayercardsplash("used_aastrike", self, self.team);
  return 1;
}

cycletargets() {
  self endon("stopFindingTargets");
  self endon("disconnect");
  self endon("owner_gone");
  self endon("game_ended");
  for(;;) {
    wait(0.05);
    findtargets();
    wait(randomintrange(4, 5));
  }
}

findtargets() {
  self endon("disconnect");
  self endon("owner_gone");
  self endon("game_ended");
  var_0 = [];
  var_1 = [];
  var_2 = [];
  if(isDefined(level.littlebirds) && level.littlebirds.size) {
    foreach(var_4 in level.littlebirds) {
      if(isDefined(var_4.team) && var_4.team != self.team) {
        var_0[var_0.size] = var_4;
      }
    }
  }

  if(isDefined(level.helis) && level.helis.size) {
    foreach(var_7 in level.helis) {
      if(var_7.team != self.team) {
        var_1[var_1.size] = var_7;
      }
    }
  }

  var_9 = scripts\mp\utility::getotherteam(self.team);
  if(isDefined(level.activeuavs[var_9])) {
    foreach(var_0B in level.uavmodels[var_9]) {
      var_2[var_2.size] = var_0B;
    }
  }

  var_0D = 0;
  foreach(var_4 in var_0) {
    wait(3);
    if(var_0D % 2) {
      thread fireattarget(var_4, self.team, 1);
    } else {
      thread fireattarget(var_4, self.team, 0);
    }

    var_0D++;
  }

  foreach(var_7 in var_1) {
    wait(3);
    thread fireattarget(var_7, self.team, 1);
  }

  foreach(var_0B in var_2) {
    wait(0.5);
    thread fireattarget(var_0B, self.team, 0);
  }
}

earlyabortwatcher() {
  self endon("stopFindingTargets");
  var_0 = self.team;
  if(scripts\mp\utility::bot_is_fireteam_mode()) {
    self waittill("killstreak_disowned");
  } else {
    scripts\engine\utility::waittill_either("killstreak_disowned", "game_ended");
  }

  self notify("owner_gone");
  level.teamairdenied[scripts\mp\utility::getotherteam(var_0)] = 0;
  level.airdeniedplayer = undefined;
}

finishaastrike(var_0) {
  self endon("disconnect");
  self endon("owner_gone");
  self endon("game_ended");
  level.teamairdenied[scripts\mp\utility::getotherteam(self.team)] = 1;
  level.airdeniedplayer = self;
  thread earlyabortwatcher();
  thread cycletargets();
  for(var_1 = 0; var_1 < 4; var_1++) {
    wait(6);
    if(var_1 == 1 || var_1 == 3) {
      thread doflyby(1);
      continue;
    }

    thread doflyby(0);
  }

  wait(3);
  self notify("stopFindingTargets");
  level.teamairdenied[scripts\mp\utility::getotherteam(self.team)] = 0;
  level.airdeniedplayer = undefined;
}

fireattarget(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  var_3 = (0, 0, 14000);
  var_4 = (0, 0, 1500);
  var_5 = 15000;
  var_6 = 20000;
  var_7 = var_0.origin;
  var_3 = (0, 0, 1) * var_7 + (0, 0, 1000);
  var_8 = var_0.angles * (0, 1, 0);
  var_9 = anglesToForward(var_8);
  var_0A = var_0.origin + var_4 + var_9 * var_5 * -1;
  var_0B = var_0.origin + var_4 + var_9 * var_6;
  var_0C = scripts\mp\utility::_magicbullet("aamissile_projectile_mp", var_0A + (0, 0, -75), var_0.origin, self);
  var_0C missile_settargetent(var_0);
  var_0C missile_setflightmodedirect();
  var_0D = scripts\mp\utility::_magicbullet("aamissile_projectile_mp", var_0A + (randomint(500), randomint(500), -75), var_0.origin, self);
  var_0D missile_settargetent(var_0);
  var_0D missile_setflightmodedirect();
  if(var_2) {
    var_0E = spawnplane(self, "script_model", var_0A, "compass_objpoint_airstrike_friendly", "compass_objpoint_airstrike_friendly");
  } else {
    var_0E = spawnplane(self, "script_model", var_0B);
  }

  if(self.team == "allies") {
    var_0E setModel("vehicle_av8b_harrier_jet_mp");
  } else {
    var_0E setModel("vehicle_av8b_harrier_jet_opfor_mp");
  }

  var_0F = distance(var_0A, var_0B);
  var_0E.angles = vectortoangles(var_0B - var_0A);
  var_0E thread aasoundmanager(var_0F);
  var_0E thread playplanefx();
  var_0F = distance(var_0A, var_0B);
  var_0E moveto(var_0B * 2, var_0F / 2000, 0, 0);
  wait(var_0F / 3000);
  var_0E delete();
}

aasoundmanager(var_0) {
  self playLoopSound("veh_aastrike_flyover_loop");
  wait(var_0 / 2 / 2000);
  self stoploopsound();
  self playLoopSound("veh_aastrike_flyover_outgoing_loop");
}

doflyby(var_0) {
  self endon("disconnect");
  var_1 = randomint(level.spawnpoints.size - 1);
  var_2 = level.spawnpoints[var_1].origin * (1, 1, 0);
  var_3 = 20000;
  var_4 = 20000;
  var_5 = getent("airstrikeheight", "targetname");
  var_6 = (0, 0, var_5.origin[2] + randomintrange(-100, 600));
  var_7 = anglesToForward((0, randomint(45), 0));
  var_8 = var_2 + var_6 + var_7 * var_3 * -1;
  var_9 = var_2 + var_6 + var_7 * var_4;
  var_0A = var_8 + (randomintrange(400, 500), randomintrange(400, 500), randomintrange(200, 300));
  var_0B = var_9 + (randomintrange(400, 500), randomintrange(400, 500), randomintrange(200, 300));
  if(var_0) {
    var_0C = spawnplane(self, "script_model", var_8, "hud_minimap_harrier_green", "hud_minimap_harrier_red");
  } else {
    var_0C = spawnplane(self, "script_model", var_9);
  }

  var_0D = spawnplane(self, "script_model", var_0A);
  if(self.team == "allies") {
    var_0C setModel("vehicle_av8b_harrier_jet_mp");
    var_0D setModel("vehicle_av8b_harrier_jet_mp");
  } else {
    var_0C setModel("vehicle_av8b_harrier_jet_opfor_mp");
    var_0D setModel("vehicle_av8b_harrier_jet_opfor_mp");
  }

  var_0C.angles = vectortoangles(var_9 - var_8);
  var_0C playLoopSound("veh_aastrike_flyover_loop");
  var_0C thread playplanefx();
  var_0D.angles = vectortoangles(var_9 - var_0A);
  var_0D thread playplanefx();
  var_0E = distance(var_8, var_9);
  var_0C moveto(var_9 * 2, var_0E / 1800, 0, 0);
  wait(randomfloatrange(0.25, 0.5));
  var_0D moveto(var_0B * 2, var_0E / 1800, 0, 0);
  wait(var_0E / 1600);
  var_0C delete();
  var_0D delete();
}

playplanefx() {
  self endon("death");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}