/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\gametypes\_gameobjects.gsc
*******************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;
#include maps\gametypes\_objpoints;

main(allowed) {
  vehicles_enabled = 0;

  if(level.script == "mp_ca_vehicle_test" || level.script == "mp_vehicle_test")
    vehicles_enabled = 1;

  if(getdvar(#"_id_2070E289") != "") {
    if(getdvarint(#"_id_2070E289") != 0)
      vehicles_enabled = 1;
    else
      vehicles_enabled = 0;
  }

  if(vehicles_enabled) {
    allowed[allowed.size] = "vehicle";
    filter_script_vehicles_from_vehicle_descriptors(allowed);
  }

  entities = getentarray();

  for(entity_index = entities.size - 1; entity_index >= 0; entity_index--) {
    entity = entities[entity_index];

    if(!entity_is_allowed(entity, allowed))
      entity delete();
  }
}

entity_is_allowed(entity, allowed_game_modes) {
  if(level.createfx_enabled)
    return 1;

  allowed = 1;

  if(isDefined(entity.script_gameobjectname) && entity.script_gameobjectname != "[all_modes]") {
    allowed = 0;
    gameobjectnames = strtok(entity.script_gameobjectname, " ");

    for(i = 0; i < allowed_game_modes.size && !allowed; i++) {
      for(j = 0; j < gameobjectnames.size && !allowed; j++)
        allowed = gameobjectnames[j] == allowed_game_modes[i];
    }
  }

  return allowed;
}

filter_script_vehicles_from_vehicle_descriptors(allowed_game_modes) {
  vehicle_descriptors = getentarray("vehicle_descriptor", "targetname");
  script_vehicles = getentarray("script_vehicle", "classname");
  vehicles_to_remove = [];

  for(descriptor_index = 0; descriptor_index < vehicle_descriptors.size; descriptor_index++) {
    descriptor = vehicle_descriptors[descriptor_index];
    closest_distance_sq = 1000000000000.0;
    closest_vehicle = undefined;

    for(vehicle_index = 0; vehicle_index < script_vehicles.size; vehicle_index++) {
      vehicle = script_vehicles[vehicle_index];
      dsquared = distancesquared(vehicle getorigin(), descriptor getorigin());

      if(dsquared < closest_distance_sq) {
        closest_distance_sq = dsquared;
        closest_vehicle = vehicle;
      }
    }

    if(isDefined(closest_vehicle)) {
      if(!entity_is_allowed(descriptor, allowed_game_modes))
        vehicles_to_remove[vehicles_to_remove.size] = closest_vehicle;
    }
  }

  for(vehicle_index = 0; vehicle_index < vehicles_to_remove.size; vehicle_index++)
    vehicles_to_remove[vehicle_index] delete();
}

init() {
  level.numgametypereservedobjectives = 0;
  level thread onplayerconnect();
}

onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connecting", player);
    player thread onplayerspawned();
    player thread ondisconnect();
  }
}

onplayerspawned() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");
    self thread ondeath();
    self.touchtriggers = [];
    self.carryobject = undefined;
    self.claimtrigger = undefined;
    self.canpickupobject = 1;
    self.disabledweapon = 0;
    self.killedinuse = undefined;
  }
}

ondeath() {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.carryobject))
    self.carryobject thread setdropped();
}

ondisconnect() {
  level endon("game_ended");
  self waittill("disconnect");

  if(isDefined(self.carryobject))
    self.carryobject thread setdropped();
}

createcarryobject(ownerteam, trigger, visuals, offset) {
  carryobject = spawnstruct();
  carryobject.type = "carryObject";
  carryobject.curorigin = trigger.origin;
  carryobject.ownerteam = ownerteam;
  carryobject.entnum = trigger getentitynumber();

  if(issubstr(trigger.classname, "use"))
    carryobject.triggertype = "use";
  else
    carryobject.triggertype = "proximity";

  trigger.baseorigin = trigger.origin;
  carryobject.trigger = trigger;
  carryobject.useweapon = undefined;

  if(!isDefined(offset))
    offset = (0, 0, 0);

  carryobject.offset3d = offset;

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseorigin = visuals[index].origin;
    visuals[index].baseangles = visuals[index].angles;
  }

  carryobject.visuals = visuals;
  carryobject.compassicons = [];
  carryobject.objidallies = getnextobjid();
  carryobject.objidaxis = getnextobjid();
  carryobject.objidpingfriendly = 0;
  carryobject.objidpingenemy = 0;
  level.objidstart = level.objidstart + 2;
  objective_add_team("allies", carryobject.objidallies, "invisible", "", carryobject.curorigin);
  objective_add_team("axis", carryobject.objidaxis, "invisible", "", carryobject.curorigin);
  carryobject.objpoints["allies"] = maps\gametypes\_objpoints::createteamobjpoint("objpoint_allies_" + carryobject.entnum, carryobject.curorigin + offset, "allies", undefined);
  carryobject.objpoints["axis"] = maps\gametypes\_objpoints::createteamobjpoint("objpoint_axis_" + carryobject.entnum, carryobject.curorigin + offset, "axis", undefined);
  carryobject.objpoints["allies"].alpha = 0;
  carryobject.objpoints["axis"].alpha = 0;
  carryobject.carrier = undefined;
  carryobject.isresetting = 0;
  carryobject.interactteam = "none";
  carryobject.allowweapons = 0;
  carryobject.visiblecarriermodel = undefined;
  carryobject.worldicons = [];
  carryobject.carriervisible = 0;
  carryobject.visibleteam = "none";
  carryobject.worldiswaypoint = [];
  carryobject.carryicon = undefined;
  carryobject.ondrop = undefined;
  carryobject.onpickup = undefined;
  carryobject.onreset = undefined;

  if(carryobject.triggertype == "use")
    carryobject thread carryobjectusethink();
  else
    carryobject thread carryobjectproxthink();

  carryobject thread updatecarryobjectorigin();
  return carryobject;
}

carryobjectusethink() {
  level endon("game_ended");

  while(true) {
    self.trigger waittill("trigger", player);

    if(self.isresetting) {
      continue;
    }
    if(!isalive(player)) {
      continue;
    }
    if(isDefined(player.laststand) && player.laststand) {
      continue;
    }
    if(!self caninteractwith(player.pers["team"])) {
      continue;
    }
    if(!player.canpickupobject) {
      continue;
    }
    if(player.throwinggrenade) {
      continue;
    }
    if(isDefined(self.carrier)) {
      continue;
    }
    if(!player istouching(self.trigger)) {
      continue;
    }
    self setpickedup(player);
  }
}

carryobjectproxthink() {
  level endon("game_ended");

  while(true) {
    self.trigger waittill("trigger", player);

    if(self.isresetting) {
      continue;
    }
    if(!isalive(player)) {
      continue;
    }
    if(isDefined(player.laststand) && player.laststand) {
      continue;
    }
    if(!self caninteractwith(player.pers["team"])) {
      continue;
    }
    if(!player.canpickupobject) {
      continue;
    }
    if(player.throwinggrenade) {
      continue;
    }
    if(isDefined(self.carrier)) {
      continue;
    }
    if(!player istouching(self.trigger)) {
      continue;
    }
    self setpickedup(player);
  }
}

pickupobjectdelay(origin) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self.canpickupobject = 0;

  for(;;) {
    if(distancesquared(self.origin, origin) > 4096) {
      break;
    }

    wait 0.2;
  }

  self.canpickupobject = 1;
}

setpickedup(player) {
  if(isDefined(player.carryobject)) {
    if(isDefined(self.onpickupfailed))
      self[[self.onpickupfailed]](player);

    return;
  }

  player giveobject(self);
  self setcarrier(player);

  for(index = 0; index < self.visuals.size; index++)
    self.visuals[index] hide();

  self.trigger.origin = self.trigger.origin + vectorscale((0, 0, 1), 10000.0);
  self notify("pickup_object");

  if(isDefined(self.onpickup))
    self[[self.onpickup]](player);

  self updatecompassicons();
  self updateworldicons();
}

updatecarryobjectorigin() {
  level endon("game_ended");

  for(;;) {
    if(isDefined(self.carrier)) {
      self.curorigin = self.carrier.origin + vectorscale((0, 0, 1), 75.0);
      self.objpoints["allies"] maps\gametypes\_objpoints::updateorigin(self.curorigin);
      self.objpoints["axis"] maps\gametypes\_objpoints::updateorigin(self.curorigin);

      if((self.visibleteam == "friendly" || self.visibleteam == "any") && self isfriendlyteam("allies") && self.objidpingfriendly) {
        if(self.objpoints["allies"].isshown) {
          self.objpoints["allies"].alpha = self.objpoints["allies"].basealpha;
          self.objpoints["allies"] fadeovertime(5.0 + 1.0);
          self.objpoints["allies"].alpha = 0;
        }

        objective_position(self.objidallies, self.curorigin);
      } else if((self.visibleteam == "friendly" || self.visibleteam == "any") && self isfriendlyteam("axis") && self.objidpingfriendly) {
        if(self.objpoints["axis"].isshown) {
          self.objpoints["axis"].alpha = self.objpoints["axis"].basealpha;
          self.objpoints["axis"] fadeovertime(5.0 + 1.0);
          self.objpoints["axis"].alpha = 0;
        }

        objective_position(self.objidaxis, self.curorigin);
      }

      if((self.visibleteam == "enemy" || self.visibleteam == "any") && !self isfriendlyteam("allies") && self.objidpingenemy) {
        if(self.objpoints["allies"].isshown) {
          self.objpoints["allies"].alpha = self.objpoints["allies"].basealpha;
          self.objpoints["allies"] fadeovertime(5.0 + 1.0);
          self.objpoints["allies"].alpha = 0;
        }

        objective_position(self.objidallies, self.curorigin);
      } else if((self.visibleteam == "enemy" || self.visibleteam == "any") && !self isfriendlyteam("axis") && self.objidpingenemy) {
        if(self.objpoints["axis"].isshown) {
          self.objpoints["axis"].alpha = self.objpoints["axis"].basealpha;
          self.objpoints["axis"] fadeovertime(5.0 + 1.0);
          self.objpoints["axis"].alpha = 0;
        }

        objective_position(self.objidaxis, self.curorigin);
      }

      self wait_endon(5.0, "dropped", "reset");
      continue;
    }

    self.objpoints["allies"] maps\gametypes\_objpoints::updateorigin(self.curorigin + self.offset3d);
    self.objpoints["axis"] maps\gametypes\_objpoints::updateorigin(self.curorigin + self.offset3d);
    wait 0.05;
  }
}

giveobject(object) {
  assert(!isDefined(self.carryobject));
  self.carryobject = object;
  self thread trackcarrier();

  if(!object.allowweapons) {
    self _disableweapon();
    self thread manualdropthink();
  }

  self.disallowvehicleusage = 1;

  if(isDefined(object.carryicon)) {
    if(level.splitscreen) {
      self.carryicon = createicon(object.carryicon, 35, 35);
      self.carryicon.x = -130;
      self.carryicon.y = -90;
      self.carryicon.horzalign = "right";
      self.carryicon.vertalign = "bottom";
    } else {
      self.carryicon = createicon(object.carryicon, 50, 50);

      if(!object.allowweapons)
        self.carryicon setpoint("CENTER", "CENTER", 0, 60);
      else {
        self.carryicon.x = -135;
        self.carryicon.y = -103;
        self.carryicon.horzalign = "user_right";
        self.carryicon.vertalign = "user_bottom";
      }
    }
  }
}

returnhome() {
  self.isresetting = 1;
  self notify("reset");

  for(index = 0; index < self.visuals.size; index++) {
    self.visuals[index].origin = self.visuals[index].baseorigin;
    self.visuals[index].angles = self.visuals[index].baseangles;
    self.visuals[index] show();
  }

  self.trigger.origin = self.trigger.baseorigin;
  self.curorigin = self.trigger.origin;

  if(isDefined(self.onreset))
    self[[self.onreset]]();

  self clearcarrier();
  updateworldicons();
  updatecompassicons();
  self.isresetting = 0;
}

isobjectawayfromhome() {
  if(isDefined(self.carrier))
    return true;

  if(distancesquared(self.trigger.origin, self.trigger.baseorigin) > 4)
    return true;

  return false;
}

onplayerlaststand() {
  if(isDefined(self.carryobject))
    self.carryobject thread setdropped();
}

setdropped() {
  self.isresetting = 1;
  self notify("dropped");
  trace = undefined;

  if(isDefined(self.carrier))
    angletrace = bullettrace(self.carrier.origin + vectorscale((0, 0, 1), 20.0), self.carrier.origin - vectorscale((0, 0, 1), 2000.0), 0, self.carrier.body);
  else
    angletrace = bullettrace(self.safeorigin + vectorscale((0, 0, 1), 20.0), self.safeorigin - vectorscale((0, 0, 1), 20.0), 0, undefined);

  droppingplayer = self.carrier;

  if(isDefined(trace)) {
    tempangle = randomfloat(360);
    droporigin = trace;

    if(angletrace["fraction"] < 1 && distance(angletrace["position"], trace) < 10.0) {
      forward = (cos(tempangle), sin(tempangle), 0);
      forward = vectornormalize(forward - vectorscale(angletrace["normal"], vectordot(forward, angletrace["normal"])));
      dropangles = vectortoangles(forward);
    } else
      dropangles = (0, tempangle, 0);

    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index].origin = droporigin;
      self.visuals[index].angles = dropangles;
      self.visuals[index] show();
    }

    self.trigger.origin = droporigin;
    self.curorigin = self.trigger.origin;
    self thread pickuptimeout();
  } else {
    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index].origin = self.visuals[index].baseorigin;
      self.visuals[index].angles = self.visuals[index].baseangles;
      self.visuals[index] show();
    }

    self.trigger.origin = self.trigger.baseorigin;
    self.curorigin = self.trigger.baseorigin;
  }

  if(isDefined(self.ondrop))
    self[[self.ondrop]](droppingplayer);

  self clearcarrier();
  self updatecompassicons();
  self updateworldicons();
  self.isresetting = 0;
}

setcarrier(carrier) {
  self.carrier = carrier;
  self thread updatevisibilityaccordingtoradar();
}

clearcarrier() {
  if(!isDefined(self.carrier)) {
    return;
  }
  self.carrier takeobject(self);
  self.carrier = undefined;
  self notify("carrier_cleared");
}

pickuptimeout() {
  self endon("pickup_object");
  self endon("stop_pickup_timeout");
  wait 0.05;
  minetriggers = getentarray("minefield", "targetname");
  hurttriggers = getentarray("trigger_hurt", "classname");

  for(index = 0; index < minetriggers.size; index++) {
    if(!self.visuals[0] istouching(minetriggers[index])) {
      continue;
    }
    self returnhome();
    return;
  }

  for(index = 0; index < hurttriggers.size; index++) {
    if(!self.visuals[0] istouching(hurttriggers[index])) {
      continue;
    }
    self returnhome();
    return;
  }

  if(isDefined(self.autoresettime)) {
    wait(self.autoresettime);

    if(!isDefined(self.carrier))
      self returnhome();
  }
}

takeobject(object) {
  if(isDefined(self.carryicon))
    self.carryicon destroyelem();

  self.carryobject = undefined;

  if(!isalive(self)) {
    return;
  }
  self notify("drop_object");
  self.disallowvehicleusage = 0;

  if(object.triggertype == "proximity")
    self thread pickupobjectdelay(object.trigger.origin);

  if(!object.allowweapons)
    self _enableweapon();
}

trackcarrier() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  while(isDefined(self.carryobject) && isalive(self)) {
    if(self isonground()) {
      trace = bullettrace(self.origin + vectorscale((0, 0, 1), 20.0), self.origin - vectorscale((0, 0, 1), 20.0), 0, undefined);

      if(trace["fraction"] < 1)
        self.carryobject.safeorigin = trace["position"];
    }

    wait 0.05;
  }
}

manualdropthink() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  for(;;) {
    while(self attackbuttonpressed() || self fragbuttonpressed() || self meleebuttonpressed())
      wait 0.05;

    while(!self attackbuttonpressed() && !self fragbuttonpressed() && !self meleebuttonpressed())
      wait 0.05;

    if(isDefined(self.carryobject) && !self usebuttonpressed())
      self.carryobject thread setdropped();
  }
}

createuseobject(ownerteam, trigger, visuals, offset, descriptionallies, descriptionaxis) {
  useobject = spawnstruct();
  useobject.type = "useObject";
  useobject.curorigin = trigger.origin;
  useobject.ownerteam = ownerteam;
  useobject.entnum = trigger getentitynumber();
  useobject.keyobject = undefined;

  if(issubstr(trigger.classname, "use"))
    useobject.triggertype = "use";
  else
    useobject.triggertype = "proximity";

  useobject.trigger = trigger;

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseorigin = visuals[index].origin;
    visuals[index].baseangles = visuals[index].angles;
  }

  useobject.visuals = visuals;

  if(!isDefined(offset))
    offset = (0, 0, 0);

  useobject.offset3d = offset;
  useobject.compassicons = [];
  useobject.objidallies = getnextobjid();
  useobject.objidaxis = getnextobjid();
  descriptiontextforallies = "";

  if(isDefined(descriptionallies))
    descriptiontextforallies = descriptionallies;

  descriptiontextforaxis = "";

  if(isDefined(descriptionaxis))
    descriptiontextforaxis = descriptionaxis;

  objective_add_team("allies", useobject.objidallies, "invisible", descriptiontextforallies, useobject.curorigin);
  objective_add_team("axis", useobject.objidaxis, "invisible", descriptiontextforaxis, useobject.curorigin);
  useobject.objpoints["allies"] = maps\gametypes\_objpoints::createteamobjpoint("objpoint_allies_" + useobject.entnum, useobject.curorigin + offset, "allies", undefined);
  useobject.objpoints["axis"] = maps\gametypes\_objpoints::createteamobjpoint("objpoint_axis_" + useobject.entnum, useobject.curorigin + offset, "axis", undefined);
  useobject.objpoints["allies"].alpha = 0;
  useobject.objpoints["axis"].alpha = 0;
  useobject.interactteam = "none";
  useobject.worldicons = [];
  useobject.visibleteam = "none";
  useobject.worldiswaypoint = [];
  useobject.onuse = undefined;
  useobject.oncantuse = undefined;
  useobject.usetext = "default";
  useobject.usetime = 10000;
  useobject.curprogress = 0;
  useobject.decayprogress = 0;

  if(useobject.triggertype == "proximity") {
    useobject.numtouching["neutral"] = 0;
    useobject.numtouching["axis"] = 0;
    useobject.numtouching["allies"] = 0;
    useobject.numtouching["none"] = 0;
    useobject.touchlist["neutral"] = [];
    useobject.touchlist["axis"] = [];
    useobject.touchlist["allies"] = [];
    useobject.touchlist["none"] = [];
    useobject.userate = 0;
    useobject.claimteam = "none";
    useobject.claimplayer = undefined;
    useobject.lastclaimteam = "none";
    useobject.lastclaimtime = 0;
    useobject thread useobjectproxthink();
  } else {
    useobject.userate = 1;
    useobject thread useobjectusethink();
  }

  return useobject;
}

setkeyobject(object) {
  self.keyobject = object;
}

useobjectusethink() {
  level endon("game_ended");

  while(true) {
    self.trigger waittill("trigger", player);

    if(!isalive(player)) {
      continue;
    }
    if(!self caninteractwith(player.pers["team"])) {
      continue;
    }
    if(!player isonground()) {
      continue;
    }
    if(isDefined(self.keyobject) && (!isDefined(player.carryobject) || player.carryobject != self.keyobject)) {
      if(isDefined(self.oncantuse))
        self[[self.oncantuse]](player);

      continue;
    }

    result = 1;

    if(self.usetime > 0) {
      if(isDefined(self.onbeginuse))
        self[[self.onbeginuse]](player);

      team = player.pers["team"];
      result = self useholdthink(player);

      if(isDefined(self.onenduse))
        self[[self.onenduse]](team, player, result);
    }

    if(!result) {
      continue;
    }
    if(isDefined(self.onuse))
      self[[self.onuse]](player);
  }
}

getearliestclaimplayer() {
  assert(self.claimteam != "none");
  team = self.claimteam;
  earliestplayer = self.claimplayer;

  if(self.touchlist[team].size > 0) {
    earliesttime = undefined;
    players = getarraykeys(self.touchlist[team]);

    for(index = 0; index < players.size; index++) {
      touchdata = self.touchlist[team][players[index]];

      if(!isDefined(earliesttime) || touchdata.starttime < earliesttime) {
        earliestplayer = touchdata.player;
        earliesttime = touchdata.starttime;
      }
    }
  }

  return earliestplayer;
}

useobjectproxthink() {
  level endon("game_ended");
  self thread proxtriggerthink();

  while(true) {
    if(self.usetime && self.curprogress >= self.usetime) {
      self.curprogress = 0;
      creditplayer = getearliestclaimplayer();

      if(isDefined(self.onenduse))
        self[[self.onenduse]](self getclaimteam(), creditplayer, isDefined(creditplayer));

      if(isDefined(creditplayer) && isDefined(self.onuse))
        self[[self.onuse]](creditplayer);

      self setclaimteam("none");
      self.claimplayer = undefined;
    }

    if(self.claimteam != "none") {
      if(self useobjectlockedforteam(self.claimteam)) {
        if(isDefined(self.onenduse))
          self[[self.onenduse]](self getclaimteam(), self.claimplayer, 0);

        self setclaimteam("none");
        self.claimplayer = undefined;
        self.curprogress = 0;
      } else if(self.usetime) {
        if(self.decayprogress && !self.numtouching[self.claimteam]) {
          if(isDefined(self.claimplayer)) {
            if(isDefined(self.onenduse))
              self[[self.onenduse]](self getclaimteam(), self.claimplayer, 0);

            self.claimplayer = undefined;
          }

          self.curprogress = self.curprogress - 50 * self.userate;

          if(self.curprogress <= 0)
            self.curprogress = 0;

          if(isDefined(self.onuseupdate))
            self[[self.onuseupdate]](self getclaimteam(), self.curprogress / self.usetime, 50 * self.userate / self.usetime);

          if(self.curprogress == 0)
            self setclaimteam("none");
        } else if(!self.numtouching[self.claimteam]) {
          if(isDefined(self.onenduse))
            self[[self.onenduse]](self getclaimteam(), self.claimplayer, 0);

          self setclaimteam("none");
          self.claimplayer = undefined;
        } else {
          self.curprogress = self.curprogress + 50 * self.userate;

          if(isDefined(self.onuseupdate))
            self[[self.onuseupdate]](self getclaimteam(), self.curprogress / self.usetime, 50 * self.userate / self.usetime);
        }
      } else {
        if(isDefined(self.onuse))
          self[[self.onuse]](self.claimplayer);

        self setclaimteam("none");
        self.claimplayer = undefined;
      }
    }

    wait 0.05;
  }
}

useobjectlockedforteam(team) {
  if(isDefined(self.teamlock) && (team == "axis" || team == "allies"))
    return self.teamlock[team];

  return 0;
}

proxtriggerthink() {
  level endon("game_ended");
  entitynumber = self.entnum;

  while(true) {
    self.trigger waittill("trigger", player);

    if(!isalive(player) || self useobjectlockedforteam(player.pers["team"])) {
      continue;
    }
    if(self caninteractwith(player.pers["team"]) && self.claimteam == "none") {
      if(!isDefined(self.keyobject) || isDefined(player.carryobject) && player.carryobject == self.keyobject) {
        setclaimteam(player.pers["team"]);
        self.claimplayer = player;

        if(self.usetime && isDefined(self.onbeginuse))
          self[[self.onbeginuse]](self.claimplayer);
      } else if(isDefined(self.oncantuse))
        self[[self.oncantuse]](player);
    }

    if(self.usetime && isalive(player) && !isDefined(player.touchtriggers[entitynumber]))
      player thread triggertouchthink(self);
  }
}

setclaimteam(newteam) {
  assert(newteam != self.claimteam);

  if(self.claimteam == "none" && gettime() - self.lastclaimtime > 1000)
    self.curprogress = 0;
  else if(newteam != "none" && newteam != self.lastclaimteam)
    self.curprogress = 0;

  self.lastclaimteam = self.claimteam;
  self.lastclaimtime = gettime();
  self.claimteam = newteam;
  self updateuserate();
}

getclaimteam() {
  return self.claimteam;
}

triggertouchthink(object) {
  team = self.pers["team"];
  object.numtouching[team]++;
  object updateuserate();
  touchname = "player" + self.clientid;
  struct = spawnstruct();
  struct.player = self;
  struct.starttime = gettime();
  object.touchlist[team][touchname] = struct;
  self.touchtriggers[object.entnum] = object.trigger;

  if(isDefined(object.ontouchuse))
    object[[object.ontouchuse]](self);

  while(isalive(self) && self istouching(object.trigger) && self useobjectlockedforteam(team) == 0) {
    self updateproxbar(object, 0);
    wait 0.05;
  }

  if(isDefined(self)) {
    self updateproxbar(object, 1);
    self.touchtriggers[object.entnum] = undefined;
  }

  if(level.gameended) {
    return;
  }
  object.touchlist[team][touchname] = undefined;
  object.numtouching[team]--;

  if(isDefined(self)) {
    if(isDefined(object.onendtouchuse))
      object[[object.onendtouchuse]](self);
  }

  object updateuserate();
}

updateproxbar(object, forceremove) {
  if(!forceremove && object.decayprogress) {
    if(!object caninteractwith(self.pers["team"])) {
      if(isDefined(self.proxbar))
        self.proxbar hideelem();

      if(isDefined(self.proxbartext))
        self.proxbartext hideelem();

      return;
    } else {
      if(!isDefined(self.proxbar)) {
        self.proxbar = createprimaryprogressbar();
        self.proxbar.lastuserate = -1;
      }

      if(self.pers["team"] == object.claimteam) {
        if(self.proxbar.bar.color != (1, 1, 1)) {
          self.proxbar.bar.color = (1, 1, 1);
          self.proxbar.lastuserate = -1;
        }
      } else if(self.proxbar.bar.color != (1, 0, 0)) {
        self.proxbar.bar.color = (1, 0, 0);
        self.proxbar.lastuserate = -1;
      }
    }
  } else if(forceremove || !object caninteractwith(self.pers["team"]) || self.pers["team"] != object.claimteam) {
    if(isDefined(self.proxbar))
      self.proxbar hideelem();

    if(isDefined(self.proxbartext))
      self.proxbartext hideelem();

    return;
  }

  if(!isDefined(self.proxbar)) {
    self.proxbar = createprimaryprogressbar();
    self.proxbar.lastuserate = -1;
  }

  if(self.proxbar.hidden) {
    self.proxbar showelem();
    self.proxbar.lastuserate = -1;
  }

  if(!isDefined(self.proxbartext)) {
    self.proxbartext = createprimaryprogressbartext();
    self.proxbartext settext(object.usetext);
  }

  if(self.proxbartext.hidden) {
    self.proxbartext showelem();
    self.proxbartext settext(object.usetext);
  }

  if(self.proxbar.lastuserate != object.userate) {
    if(object.curprogress > object.usetime)
      object.curprogress = object.usetime;

    if(object.decayprogress && self.pers["team"] != object.claimteam) {
      if(object.curprogress > 0)
        self.proxbar updatebar(object.curprogress / object.usetime, 1000 / object.usetime * (object.userate * -1));
    } else
      self.proxbar updatebar(object.curprogress / object.usetime, 1000 / object.usetime * object.userate);

    self.proxbar.lastuserate = object.userate;
  }
}

updateuserate() {
  numclaimants = self.numtouching[self.claimteam];
  numother = 0;

  if(self.claimteam != "axis")
    numother = numother + self.numtouching["axis"];

  if(self.claimteam != "allies")
    numother = numother + self.numtouching["allies"];

  self.userate = 0;

  if(self.decayprogress) {
    if(numclaimants && !numother)
      self.userate = numclaimants;
    else if(!numclaimants && numother)
      self.userate = numother;
    else if(!numclaimants && !numother)
      self.userate = 1;
  } else if(numclaimants && !numother)
    self.userate = numclaimants;

  if(isDefined(self.onupdateuserate))
    self[[self.onupdateuserate]]();
}

attachusemodel() {
  self endon("death");
  self endon("disconnect");
  self endon("done_using");
  wait 1.3;
  self attach("weapon_explosives", "tag_inhand", 1);
  self.attachedusemodel = "weapon_explosives";
}

useholdthink(player) {
  player notify("use_hold");
  player freezecontrols(1);
  player clientclaimtrigger(self.trigger);
  player.claimtrigger = self.trigger;
  useweapon = self.useweapon;
  lastweapon = player getcurrentweapon();

  if(isDefined(useweapon)) {
    assert(isDefined(lastweapon));

    if(lastweapon == useweapon) {
      assert(isDefined(player.lastnonuseweapon));
      lastweapon = player.lastnonuseweapon;
    }

    assert(lastweapon != useweapon);
    player.lastnonuseweapon = lastweapon;
    player giveweapon(useweapon);
    player setweaponammostock(useweapon, 0);
    player setweaponammoclip(useweapon, 0);
    player switchtoweapon(useweapon);
    player thread attachusemodel();
  } else
    player _disableweapon();

  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  player thread personalusebar(self);
  result = useholdthinkloop(player, lastweapon);

  if(isDefined(player)) {
    if(isDefined(player.attachedusemodel)) {
      player detach(player.attachedusemodel, "tag_inhand");
      player.attachedusemodel = undefined;
    }

    player notify("done_using");
  }

  if(isDefined(useweapon) && isDefined(player))
    player thread takeuseweapon(useweapon);

  if(isDefined(result) && result)
    return true;

  if(isDefined(player)) {
    player.claimtrigger = undefined;

    if(isDefined(useweapon)) {
      if(lastweapon != "none")
        player switchtoweapon(lastweapon);
      else
        player takeweapon(useweapon);
    } else
      player _enableweapon();

    player freezecontrols(0);

    if(!isalive(player))
      player.killedinuse = 1;
  }

  self.inuse = 0;
  self.trigger releaseclaimedtrigger();
  return false;
}

takeuseweapon(useweapon) {
  self endon("use_hold");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(self getcurrentweapon() == useweapon && !self.throwinggrenade)
    wait 0.05;

  self takeweapon(useweapon);
}

useholdthinkloop(player, lastweapon) {
  level endon("game_ended");
  self endon("disabled");
  useweapon = self.useweapon;
  waitforweapon = 1;
  timedout = 0;

  while(isalive(player) && player istouching(self.trigger) && player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed() && self.curprogress < self.usetime && (self.userate || waitforweapon) && !(waitforweapon && timedout > 1.5)) {
    timedout = timedout + 0.05;

    if(!isDefined(useweapon) || player getcurrentweapon() == useweapon) {
      self.curprogress = self.curprogress + 50 * self.userate;
      self.userate = 1;
      waitforweapon = 0;
    } else
      self.userate = 0;

    if(self.curprogress >= self.usetime) {
      self.inuse = 0;
      player clientreleasetrigger(self.trigger);
      player.claimtrigger = undefined;

      if(isDefined(useweapon)) {
        player setweaponammostock(useweapon, 1);
        player setweaponammoclip(useweapon, 1);

        if(lastweapon != "none")
          player switchtoweapon(lastweapon);
        else
          player takeweapon(useweapon);
      } else
        player _enableweapon();

      player freezecontrols(0);
      wait 0.05;
      return isalive(player);
    }

    wait 0.05;
  }

  return 0;
}

personalusebar(object) {
  self endon("disconnect");

  if(isDefined(self.usebar)) {
    return;
  }
  self.usebar = createprimaryprogressbar();
  self.usebartext = createprimaryprogressbartext();
  self.usebartext settext(object.usetext);
  lastrate = -1;

  while(isalive(self) && object.inuse && !level.gameended) {
    if(lastrate != object.userate) {
      if(object.curprogress > object.usetime)
        object.curprogress = object.usetime;

      if(object.decayprogress && self.pers["team"] != object.claimteam) {
        if(object.curprogress > 0)
          self.proxbar updatebar(object.curprogress / object.usetime, 1000 / object.usetime * (object.userate * -1));
      } else
        self.usebar updatebar(object.curprogress / object.usetime, 1000 / object.usetime * object.userate);

      if(!object.userate) {
        self.usebar hideelem();
        self.usebartext hideelem();
      } else {
        self.usebar showelem();
        self.usebartext showelem();
      }
    }

    lastrate = object.userate;
    wait 0.05;
  }

  self.usebar destroyelem();
  self.usebartext destroyelem();
}

updatetrigger() {
  if(self.triggertype != "use") {
    return;
  }
  if(self.interactteam == "none")
    self.trigger.origin = self.trigger.origin - vectorscale((0, 0, 1), 50000.0);
  else if(self.interactteam == "any") {
    self.trigger.origin = self.curorigin;
    self.trigger setteamfortrigger("none");
  } else if(self.interactteam == "friendly") {
    self.trigger.origin = self.curorigin;

    if(self.ownerteam == "allies")
      self.trigger setteamfortrigger("allies");
    else if(self.ownerteam == "axis")
      self.trigger setteamfortrigger("axis");
    else
      self.trigger.origin = self.trigger.origin - vectorscale((0, 0, 1), 50000.0);
  } else if(self.interactteam == "enemy") {
    self.trigger.origin = self.curorigin;

    if(self.ownerteam == "allies")
      self.trigger setteamfortrigger("axis");
    else if(self.ownerteam == "axis")
      self.trigger setteamfortrigger("allies");
    else
      self.trigger setteamfortrigger("none");
  }
}

updateworldicons() {
  if(self.visibleteam == "any") {
    updateworldicon("friendly", 1);
    updateworldicon("enemy", 1);
  } else if(self.visibleteam == "friendly") {
    updateworldicon("friendly", 1);
    updateworldicon("enemy", 0);
  } else if(self.visibleteam == "enemy") {
    updateworldicon("friendly", 0);
    updateworldicon("enemy", 1);
  } else {
    updateworldicon("friendly", 0);
    updateworldicon("enemy", 0);
  }
}

updateworldicon(relativeteam, showicon) {
  if(!isDefined(self.worldicons[relativeteam]))
    showicon = 0;

  updateteams = getupdateteams(relativeteam);

  for(index = 0; index < updateteams.size; index++) {
    opname = "objpoint_" + updateteams[index] + "_" + self.entnum;
    objpoint = maps\gametypes\_objpoints::getobjpointbyname(opname);
    objpoint notify("stop_flashing_thread");
    objpoint thread maps\gametypes\_objpoints::stopflashing();

    if(showicon) {
      objpoint setshader(self.worldicons[relativeteam], level.objpointsize, level.objpointsize);
      objpoint fadeovertime(0.05);
      objpoint.alpha = objpoint.basealpha;
      objpoint.isshown = 1;
      iswaypoint = 1;

      if(isDefined(self.worldiswaypoint[relativeteam]))
        iswaypoint = self.worldiswaypoint[relativeteam];

      if(isDefined(self.compassicons[relativeteam]))
        objpoint setwaypoint(iswaypoint, self.worldicons[relativeteam], objpoint.isdistanceshown);
      else
        objpoint setwaypoint(iswaypoint, "", objpoint.isdistanceshown);

      if(self.type == "carryObject") {
        if(isDefined(self.carrier) && !shouldpingobject(relativeteam))
          objpoint settargetent(self.carrier);
        else
          objpoint cleartargetent();
      }

      continue;
    }

    objpoint fadeovertime(0.05);
    objpoint.alpha = 0;
    objpoint.isshown = 0;
    objpoint cleartargetent();
  }
}

updatecompassicons() {
  if(self.visibleteam == "any") {
    updatecompassicon("friendly", 1);
    updatecompassicon("enemy", 1);
  } else if(self.visibleteam == "friendly") {
    updatecompassicon("friendly", 1);
    updatecompassicon("enemy", 0);
  } else if(self.visibleteam == "enemy") {
    updatecompassicon("friendly", 0);
    updatecompassicon("enemy", 1);
  } else {
    updatecompassicon("friendly", 0);
    updatecompassicon("enemy", 0);
  }
}

updatecompassicon(relativeteam, showicon) {
  updateteams = getupdateteams(relativeteam);

  for(index = 0; index < updateteams.size; index++) {
    showiconthisteam = showicon;

    if(!showiconthisteam && shouldshowcompassduetoradar(updateteams[index]))
      showiconthisteam = 1;

    objid = self.objidallies;

    if(updateteams[index] == "axis")
      objid = self.objidaxis;

    if(!isDefined(self.compassicons[relativeteam]) || !showiconthisteam) {
      objective_state(objid, "invisible");
      continue;
    }

    objective_icon(objid, self.compassicons[relativeteam]);
    objective_state(objid, "active");

    if(self.type == "carryObject") {
      if(isalive(self.carrier) && !shouldpingobject(relativeteam)) {
        objective_onentity(objid, self.carrier);
        continue;
      }

      objective_position(objid, self.curorigin);
    }
  }
}

shouldpingobject(relativeteam) {
  if(relativeteam == "friendly" && self.objidpingfriendly)
    return true;
  else if(relativeteam == "enemy" && self.objidpingenemy)
    return true;

  return false;
}

getupdateteams(relativeteam) {
  updateteams = [];

  if(relativeteam == "friendly") {
    if(self isfriendlyteam("allies"))
      updateteams[0] = "allies";
    else if(self isfriendlyteam("axis"))
      updateteams[0] = "axis";
  } else if(relativeteam == "enemy") {
    if(!self isfriendlyteam("allies"))
      updateteams[updateteams.size] = "allies";

    if(!self isfriendlyteam("axis"))
      updateteams[updateteams.size] = "axis";
  }

  return updateteams;
}

shouldshowcompassduetoradar(team) {
  if(!isDefined(self.carrier))
    return false;

  if(self.carrier hasperk("specialty_gpsjammer"))
    return false;

  return true;
}

updatevisibilityaccordingtoradar() {
  self endon("death");
  self endon("carrier_cleared");

  while(true) {
    level waittill("radar_status_change");
    self updatecompassicons();
  }
}

setownerteam(team) {
  self.ownerteam = team;
  self updatetrigger();
  self updatecompassicons();
  self updateworldicons();
}

getownerteam() {
  return self.ownerteam;
}

setusetime(time) {
  self.usetime = int(time * 1000);
}

setusetext(text) {
  self.usetext = text;
}

setusehinttext(text) {
  self.trigger sethintstring(text);
}

allowcarry(relativeteam) {
  self.interactteam = relativeteam;
}

allowuse(relativeteam) {
  self.interactteam = relativeteam;
  updatetrigger();
}

setvisibleteam(relativeteam) {
  self.visibleteam = relativeteam;
  updatecompassicons();
  updateworldicons();
}

setmodelvisibility(visibility) {
  if(visibility) {
    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index] show();

      if(self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model")
        self.visuals[index] thread makesolid();
    }
  } else {
    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index] hide();

      if(self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model") {
        self.visuals[index] notify("changing_solidness");
        self.visuals[index] notsolid();
      }
    }
  }
}

makesolid() {
  self endon("death");
  self notify("changing_solidness");
  self endon("changing_solidness");

  while(true) {
    for(i = 0; i < level.players.size; i++) {
      if(level.players[i] istouching(self)) {
        break;
      }
    }

    if(i == level.players.size) {
      self solid();
      break;
    }

    wait 0.05;
  }
}

setcarriervisible(relativeteam) {
  self.carriervisible = relativeteam;
}

setcanuse(relativeteam) {
  self.useteam = relativeteam;
}

set2dicon(relativeteam, shader) {
  self.compassicons[relativeteam] = shader;
  updatecompassicons();
}

set3dicon(relativeteam, shader) {
  self.worldicons[relativeteam] = shader;
  updateworldicons();
}

set3duseicon(relativeteam, shader) {
  self.worlduseicons[relativeteam] = shader;
}

set3diswaypoint(relativeteam, waypoint) {
  self.worldiswaypoint[relativeteam] = waypoint;
}

setcarryicon(shader) {
  self.carryicon = shader;
}

setvisiblecarriermodel(visiblemodel) {
  self.visiblecarriermodel = visiblemodel;
}

getvisiblecarriermodel() {
  return self.visiblecarriermodel;
}

disableobject() {
  self notify("disabled");

  if(self.type == "carryObject") {
    if(isDefined(self.carrier))
      self.carrier takeobject(self);

    for(index = 0; index < self.visuals.size; index++)
      self.visuals[index] hide();
  }

  self.trigger triggeroff();
  self setvisibleteam("none");
}

enableobject() {
  if(self.type == "carryObject") {
    for(index = 0; index < self.visuals.size; index++)
      self.visuals[index] show();
  }

  self.trigger triggeron();
  self setvisibleteam("any");
}

destroyobject() {
  disableobject();
  objective_delete(self.objidallies);
  objective_delete(self.objidaxis);
  maps\gametypes\_objpoints::deleteobjpoint(self.objpoints["allies"]);
  maps\gametypes\_objpoints::deleteobjpoint(self.objpoints["axis"]);
}

getrelativeteam(team) {
  if(self.ownerteam == "any")
    return "friendly";

  enemyteam = getenemyteam(team);

  if(team == self.ownerteam)
    return "friendly";
  else if(team == enemyteam)
    return "enemy";
  else
    return "neutral";
}

isfriendlyteam(team) {
  if(self.ownerteam == "any")
    return true;

  if(self.ownerteam == team)
    return true;

  return false;
}

caninteractwith(team) {
  switch (self.interactteam) {
    case "none":
      return false;
    case "any":
      return true;
    case "friendly":
      if(team == self.ownerteam)
        return true;
      else
        return false;
    case "enemy":
      if(team != self.ownerteam)
        return true;
      else
        return false;
    default:
      assert(0, "invalid interactTeam");
      return false;
  }
}

isteam(team) {
  if(team == "neutral")
    return true;

  if(team == "allies")
    return true;

  if(team == "axis")
    return true;

  if(team == "any")
    return true;

  if(team == "none")
    return true;

  return false;
}

isrelativeteam(relativeteam) {
  if(relativeteam == "friendly")
    return true;

  if(relativeteam == "enemy")
    return true;

  if(relativeteam == "any")
    return true;

  if(relativeteam == "none")
    return true;

  return false;
}

_disableweapon() {
  if(!isDefined(self.disabledweapon))
    self.disabledweapon = 0;

  self.disabledweapon++;
  self disableweapons();
}

_enableweapon() {
  self.disabledweapon--;

  if(!self.disabledweapon)
    self enableweapons();
}

getenemyteam(team) {
  if(team == "neutral")
    return "none";
  else if(team == "allies")
    return "axis";
  else
    return "allies";
}

getnextobjid() {
  nextid = level.numgametypereservedobjectives;
  level.numgametypereservedobjectives++;
  return nextid;
}

getlabel() {
  label = self.trigger.script_label;

  if(!isDefined(label)) {
    label = "";
    return label;
  }

  if(label[0] != "_")
    return "_" + label;

  return label;
}

createdistanceobject(ownerteam, trigger, offset, wholeteamhastoreach, descriptionallies, descriptionaxis) {
  distanceobject = spawnstruct();
  distanceobject.type = "distanceObject";
  distanceobject.curorigin = trigger.origin;
  distanceobject.ownerteam = ownerteam;
  distanceobject.entnum = trigger getentitynumber();
  distanceobject.keyobject = undefined;
  distanceobject.triggertype = "distance";
  distanceobject.trigger = trigger;

  if(!isDefined(offset))
    offset = (0, 0, 0);

  distanceobject.offset3d = offset;
  distanceobject.compassicons = [];
  distanceobject.objidallies = getnextobjid();
  distanceobject.objidaxis = getnextobjid();
  descriptiontextforallies = "";

  if(isDefined(descriptionallies))
    descriptiontextforallies = descriptionallies;

  descriptiontextforaxis = "";

  if(isDefined(descriptionaxis))
    descriptiontextforaxis = descriptionaxis;

  objective_add_team("allies", distanceobject.objidallies, "invisible", descriptiontextforallies, distanceobject.curorigin);
  objective_add_team("axis", distanceobject.objidaxis, "invisible", descriptiontextforaxis, distanceobject.curorigin);
  distanceobject.objpoints["allies"] = maps\gametypes\_objpoints::createteamobjpoint("objpoint_allies_" + distanceobject.entnum, distanceobject.curorigin + offset, "allies", undefined, undefined, undefined, 1);
  distanceobject.objpoints["axis"] = maps\gametypes\_objpoints::createteamobjpoint("objpoint_axis_" + distanceobject.entnum, distanceobject.curorigin + offset, "axis", undefined, undefined, undefined, 1);
  distanceobject.objpoints["allies"].alpha = 0;
  distanceobject.objpoints["axis"].alpha = 0;
  distanceobject.interactteam = "none";
  distanceobject.worldicons = [];
  distanceobject.visibleteam = "none";
  distanceobject.worldiswaypoint = [];
  distanceobject.onreach = undefined;
  distanceobject.oncantreach = undefined;

  if(isDefined(wholeteamhastoreach) && wholeteamhastoreach)
    distanceobject thread distanceobjectforwholeteamthink();
  else
    distanceobject thread distanceobjectthink();

  return distanceobject;
}

distanceobjectthink() {
  level endon("game_ended");

  while(true) {
    self.trigger waittill("trigger", player);

    if(!isalive(player)) {
      continue;
    }
    if(!self caninteractwith(player.pers["team"])) {
      continue;
    }
    wasreached = 1;

    if(isDefined(self.keyobject)) {
      if(!isDefined(player.carryobject) || player.carryobject != self.keyobject) {
        wasreached = 0;

        if(isDefined(self.oncantreach))
          self[[self.oncantreach]](player);
      }
    }

    if(wasreached) {
      if(isDefined(self.onreach))
        self[[self.onreach]](player);

      break;
    }
  }
}

distanceobjectforwholeteamthink() {
  level endon("game_ended");
  self endon("whole_team_reached");
  self.numtouching = 0;
  self thread checkforallplayersreachingdistance();

  while(true) {
    self.trigger waittill("trigger", player);

    if(!isalive(player)) {
      continue;
    }
    if(player.sessionstate != "playing") {
      continue;
    }
    if(!self caninteractwith(player.pers["team"])) {
      continue;
    }
    if(isDefined(player.excludefromobjective) && player.excludefromobjective) {
      continue;
    }
    if(isDefined(player.touchtriggers[self.entnum])) {
      continue;
    }
    player.touchtriggers[self.entnum] = self.trigger;
    self thread distanceobjectplayertouchthink(player);
  }
}

distanceobjectplayertouchthink(player) {
  level endon("game_ended");
  self endon("whole_team_reached");
  self.numtouching++;
  totalplayersneeded = gettotalplayersneededtoreachdistance();

  if(self.numtouching < totalplayersneeded) {
    if(isDefined(self.oncantreach))
      self[[self.oncantreach]](player);
  }

  while(isDefined(player) && isalive(player) && player istouching(self.trigger) && player.sessionstate == "playing")
    wait 0.05;

  if(isDefined(player))
    player.touchtriggers[self.entnum] = undefined;

  self.numtouching--;
}

gettotalplayersneededtoreachdistance() {
  totalplayersneeded = 0;
  players = get_players("all");

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isalive(player)) {
      continue;
    }
    if(player.sessionstate != "playing") {
      continue;
    }
    if(!self caninteractwith(player.pers["team"])) {
      continue;
    }
    if(isDefined(player.excludefromobjective) && player.excludefromobjective) {
      continue;
    }
    totalplayersneeded++;
  }

  return totalplayersneeded;
}

checkforallplayersreachingdistance() {
  flag_wait_on("all_players_spawned");
  wait 0.1;

  while(true) {
    totalplayersneeded = gettotalplayersneededtoreachdistance();

    if(totalplayersneeded == 0) {
      return;
    }
    if(self.numtouching >= totalplayersneeded) {
      if(isDefined(self.onreach))
        self[[self.onreach]]();

      self notify("whole_team_reached");
      return;
    }

    wait 0.05;
  }
}