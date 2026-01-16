/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_gameobjects.gsc
**********************************************/

main(var_0) {
  var_0[var_0.size] = "airdrop_pallet";

  if(maps\mp\_utility::isaugmentedgamemode())
    var_0[var_0.size] = "boost_add";
  else
    var_0[var_0.size] = "boost_remove";

  var_1 = getentarray();

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isdefined(var_1[var_2].script_gameobjectname)) {
      var_3 = 1;
      var_4 = strtok(var_1[var_2].script_gameobjectname, " ");

      for (var_5 = 0; var_5 < var_0.size; var_5++) {
        for (var_6 = 0; var_6 < var_4.size; var_6++) {
          if(var_4[var_6] == var_0[var_5]) {
            var_3 = 0;
            break;
          }
        }

        if(!var_3) {
          break;
        }
      }

      if(var_3) {
        if(isdefined(var_1[var_2].script_exploder))
          common_scripts\_createfx::removefxentwithentity(var_1[var_2]);

        var_1[var_2] delete();
      }
    }
  }

  var_7 = getentarray("boost_jump_border", "targetname");

  if(isdefined(var_7)) {
    foreach(var_9 in var_7)
    var_9 delete();
  }
}

init() {
  level.numgametypereservedobjectives = 0;
  level.objidstart = 0;
  level thread onplayerconnect();
}

onplayerconnect() {
  level endon("game_ended");

  for (;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
    var_0 thread ondisconnect();
  }
}

onplayerspawned() {
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    self waittill("spawned_player");

    if(isdefined(self.gameobject_fauxspawn)) {
      self.gameobject_fauxspawn = undefined;
      continue;
    }

    init_player_gameobjects();
  }
}

init_player_gameobjects() {
  thread ondeath();
  self.touchtriggers = [];
  self.carryobject = undefined;
  self.claimtrigger = undefined;
  self.canpickupobject = 1;
  self.killedinuse = undefined;
  self.initialized_gameobject_vars = 1;
}

ondeath() {
  level endon("game_ended");
  self waittill("death");

  if(isdefined(self.carryobject))
    self.carryobject thread setdropped();
}

ondisconnect() {
  level endon("game_ended");
  self waittill("disconnect");

  if(isdefined(self.carryobject))
    self.carryobject thread setdropped();
}

createcarryobject(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  var_4.type = "carryObject";
  var_4.curorigin = var_1.origin;
  var_4.ownerteam = var_0;
  var_4.entnum = var_1 getentitynumber();

  if(issubstr(var_1.classname, "use"))
    var_4.triggertype = "use";
  else
    var_4.triggertype = "proximity";

  var_1.baseorigin = var_1.origin;
  var_4.trigger = var_1;
  var_4.useweapon = undefined;

  if(!isdefined(var_3))
    var_3 = (0, 0, 0);

  var_4.offset3d = var_3;

  for (var_5 = 0; var_5 < var_2.size; var_5++) {
    var_2[var_5].baseorigin = var_2[var_5].origin;
    var_2[var_5].baseangles = var_2[var_5].angles;
  }

  var_4.visuals = var_2;
  var_4.compassicons = [];
  var_4.objidallies = getnextobjid();
  var_4.objidaxis = getnextobjid();
  var_4.objidmlgspectator = getnextobjid();
  var_4.objidpingfriendly = 0;
  var_4.objidpingenemy = 0;
  var_4.objpingdelay = 5.0;
  level.objidstart = level.objidstart + 2;
  objective_add(var_4.objidallies, "invisible", var_4.curorigin);
  objective_add(var_4.objidaxis, "invisible", var_4.curorigin);
  objective_add(var_4.objidmlgspectator, "invisible", var_4.curorigin);
  objective_team(var_4.objidallies, "allies");
  objective_team(var_4.objidaxis, "axis");
  objective_mlgspectator(var_4.objidmlgspectator);
  var_4.objpoints["allies"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_allies_" + var_4.entnum, var_4.curorigin + var_3, "allies", undefined);
  var_4.objpoints["axis"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_axis_" + var_4.entnum, var_4.curorigin + var_3, "axis", undefined);
  var_4.objpoints["mlg"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_mlg_" + var_4.entnum, var_4.curorigin + var_3, "mlg", undefined);
  var_4.objpoints["mlg"].archived = 0;
  var_4.objpoints["allies"].alpha = 0;
  var_4.objpoints["axis"].alpha = 0;
  var_4.carrier = undefined;
  var_4.isresetting = 0;
  var_4.interactteam = "none";
  var_4.allowweapons = 0;
  var_4.waterbadtrigger = 0;
  var_4.keepprogress = 0;
  var_4.contesteduiprogress = 0;
  var_4.worldicons = [];
  var_4.carriervisible = 0;
  var_4.visibleteam = "none";
  var_4.carryicon = undefined;
  var_4.ondrop = undefined;
  var_4.onpickup = undefined;
  var_4.onreset = undefined;

  if(var_4.triggertype == "use")
    var_4 thread carryobjectusethink();
  else {
    var_4.curprogress = 0;
    var_4.usetime = 0;
    var_4.userate = 0;
    var_4.mustmaintainclaim = 0;
    var_4.cancontestclaim = 0;
    var_4.teamusetimes = [];
    var_4.teamusetexts = [];
    var_4.numtouching["neutral"] = 0;
    var_4.numtouching["axis"] = 0;
    var_4.numtouching["allies"] = 0;
    var_4.numtouching["none"] = 0;
    var_4.touchlist["neutral"] = [];
    var_4.touchlist["axis"] = [];
    var_4.touchlist["allies"] = [];
    var_4.touchlist["none"] = [];
    var_4.claimteam = "none";
    var_4.claimplayer = undefined;
    var_4.lastclaimteam = "none";
    var_4.lastclaimtime = 0;

    if(level.multiteambased) {
      foreach(var_7 in level.teamnamelist) {
        var_4.numtouching[var_7] = 0;
        var_4.touchlist[var_7] = [];
      }
    }

    var_4 thread carryobjectproxthink();
  }

  var_4 thread updatecarryobjectorigin();
  return var_4;
}

deletecarryobject() {
  if(self.type != "carryObject") {
    return;
  }
  var_0 = self;
  var_0.type = undefined;
  var_0.curorigin = undefined;
  var_0.ownerteam = undefined;
  var_0.entnum = undefined;
  var_0.triggertype = undefined;
  var_0.trigger unlink();
  var_0.trigger = undefined;
  var_0.useweapon = undefined;
  var_0.offset3d = undefined;

  foreach(var_2 in var_0.visuals)
  var_2 delete();

  var_0.visuals = undefined;
  maps\mp\_utility::_objective_delete(var_0.objidallies);
  maps\mp\_utility::_objective_delete(var_0.objidaxis);
  maps\mp\_utility::_objective_delete(var_0.objidmlgspectator);
  var_0.compassicons = undefined;
  var_0.objidallies = undefined;
  var_0.objidaxis = undefined;
  var_0.objidmlgspectator = undefined;
  var_0.objidpingfriendly = undefined;
  var_0.objidpingenemy = undefined;
  var_0.objpingdelay = undefined;
  maps\mp\gametypes\_objpoints::deleteobjpoint(var_0.objpoints["allies"]);
  maps\mp\gametypes\_objpoints::deleteobjpoint(var_0.objpoints["axis"]);
  maps\mp\gametypes\_objpoints::deleteobjpoint(var_0.objpoints["mlg"]);
  var_0.objpoints = undefined;
  var_0.carrier = undefined;
  var_0.isresetting = undefined;
  var_0.interactteam = undefined;
  var_0.allowweapons = undefined;
  var_0.waterbadtrigger = undefined;
  var_0.keepprogress = undefined;
  var_0.worldicons = undefined;
  var_0.carriervisible = undefined;
  var_0.visibleteam = undefined;
  var_0.carryicon = undefined;
  var_0.ondrop = undefined;
  var_0.onpickup = undefined;
  var_0.onreset = undefined;
  var_0.curprogress = undefined;
  var_0.usetime = undefined;
  var_0.userate = undefined;
  var_0.mustmaintainclaim = undefined;
  var_0.cancontestclaim = undefined;
  var_0.teamusetimes = undefined;
  var_0.teamusetexts = undefined;
  var_0.numtouching = undefined;
  var_0.touchlist = undefined;
  var_0.claimteam = undefined;
  var_0.claimplayer = undefined;
  var_0.lastclaimteam = undefined;
  var_0.lastclaimtime = undefined;
  var_0 notify("death");
  var_0 notify("deleted");
}

carryobjectusethink() {
  if(isdefined(level.ishorde) && level.ishorde)
    self endon("death");

  level endon("game_ended");

  for (;;) {
    self.trigger waittill("trigger", var_0);

    if(self.isresetting) {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_0)) {
      continue;
    }
    if(!caninteractwith(var_0.pers["team"])) {
      continue;
    }
    if(!var_0.canpickupobject) {
      continue;
    }
    if(!isdefined(var_0.initialized_gameobject_vars)) {
      continue;
    }
    if(isdefined(var_0.throwinggrenade)) {
      continue;
    }
    if(isdefined(self.carrier)) {
      continue;
    }
    if(var_0 maps\mp\_utility::isusingremote() || var_0 maps\mp\_utility::isinremotetransition()) {
      continue;
    }
    setpickedup(var_0);
  }
}

carryobjectproxthink() {
  if(isdefined(level.ishorde) && level.ishorde)
    self endon("death");

  thread carryobjectproxthinkdelayed();
}

carryobjectproxthinkdelayed() {
  if(isdefined(level.ishorde) && level.ishorde)
    self endon("death");

  level endon("game_ended");
  thread proxtriggerthink();

  for (;;) {
    waittillframeend;

    if(self.usetime && self.curprogress >= self.usetime) {
      self.curprogress = 0;
      var_0 = getearliestclaimplayer();

      if(isdefined(self.onenduse))
        self[[self.onenduse]](getclaimteam(), var_0, isdefined(var_0));

      if(isdefined(var_0))
        setpickedup(var_0);

      setclaimteam("none");
      self.claimplayer = undefined;
    }

    if(self.claimteam != "none") {
      if(self.usetime) {
        if(!self.numtouching[self.claimteam]) {
          if(isdefined(self.onenduse))
            self[[self.onenduse]](getclaimteam(), self.claimplayer, 0);

          setclaimteam("none");
          self.claimplayer = undefined;
        } else {
          self.curprogress = self.curprogress + 50 * self.userate;

          if(isdefined(self.onuseupdate))
            self[[self.onuseupdate]](getclaimteam(), self.curprogress / self.usetime, 50 * self.userate / self.usetime);
        }
      } else {
        if(maps\mp\_utility::isreallyalive(self.claimplayer))
          setpickedup(self.claimplayer);

        setclaimteam("none");
        self.claimplayer = undefined;
      }
    }

    wait 0.05;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }
}

pickupobjectdelay(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self.canpickupobject = 0;

  for (;;) {
    if(distancesquared(self.origin, var_0) > 4096) {
      break;
    }

    wait 0.2;
  }

  self.canpickupobject = 1;
}

setpickedup(var_0) {
  if(isai(var_0) && isdefined(var_0.owner)) {
    return;
  }
  if(isdefined(var_0.carryobject)) {
    if(isdefined(self.onpickupfailed))
      self[[self.onpickupfailed]](var_0);

    return;
  }

  var_0 giveobject(self);
  setcarrier(var_0);

  for (var_1 = 0; var_1 < self.visuals.size; var_1++)
    self.visuals[var_1] hide();

  self.trigger.origin = self.trigger.origin + (0, 0, 10000);
  self notify("pickup_object");

  if(isdefined(self.onpickup))
    self[[self.onpickup]](var_0);

  updatecompassicons();
  updateworldicons();
}

updatecarryobjectorigin() {
  if(isdefined(level.ishorde) && level.ishorde)
    self endon("death");

  level endon("game_ended");

  for (;;) {
    if(isdefined(self.carrier)) {
      self.curorigin = self.carrier.origin + (0, 0, 75);
      self.curcarrierorigin = self.carrier.origin;
      self.objpoints["allies"] maps\mp\gametypes\_objpoints::updateorigin(self.curorigin);
      self.objpoints["axis"] maps\mp\gametypes\_objpoints::updateorigin(self.curorigin);

      if((self.visibleteam == "friendly" || self.visibleteam == "any") && isfriendlyteam("allies") && self.objidpingfriendly) {
        if(self.objpoints["allies"].isshown) {
          self.objpoints["allies"].alpha = self.objpoints["allies"].basealpha;
          self.objpoints["allies"] fadeovertime(self.objpingdelay + 1.0);
          self.objpoints["allies"].alpha = 0;
        }

        objective_position(self.objidallies, self.curorigin);
      } else if((self.visibleteam == "friendly" || self.visibleteam == "any") && isfriendlyteam("axis") && self.objidpingfriendly) {
        if(self.objpoints["axis"].isshown) {
          self.objpoints["axis"].alpha = self.objpoints["axis"].basealpha;
          self.objpoints["axis"] fadeovertime(self.objpingdelay + 1.0);
          self.objpoints["axis"].alpha = 0;
        }

        objective_position(self.objidaxis, self.curorigin);
      }

      if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam("allies") && self.objidpingenemy) {
        if(self.objpoints["allies"].isshown) {
          self.objpoints["allies"].alpha = self.objpoints["allies"].basealpha;
          self.objpoints["allies"] fadeovertime(self.objpingdelay + 1.0);
          self.objpoints["allies"].alpha = 0;
        }

        objective_position(self.objidallies, self.curorigin);
      } else if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam("axis") && self.objidpingenemy) {
        if(self.objpoints["axis"].isshown) {
          self.objpoints["axis"].alpha = self.objpoints["axis"].basealpha;
          self.objpoints["axis"] fadeovertime(self.objpingdelay + 1.0);
          self.objpoints["axis"].alpha = 0;
        }

        objective_position(self.objidaxis, self.curorigin);
      }

      maps\mp\_utility::wait_endon(self.objpingdelay, "dropped", "reset");
      continue;
    }

    self.curcarrierorigin = undefined;
    self.objpoints["allies"] maps\mp\gametypes\_objpoints::updateorigin(self.curorigin + self.offset3d);
    self.objpoints["axis"] maps\mp\gametypes\_objpoints::updateorigin(self.curorigin + self.offset3d);
    wait 0.05;
  }
}

hidecarryiconongameend() {
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  level waittill("game_ended");

  if(isdefined(self.carryicon))
    self.carryicon.alpha = 0;
}

giveobject(var_0) {
  self.carryobject = var_0;
  thread trackcarrier();

  if(isdefined(var_0.carryweapon)) {
    var_0.carrierweaponcurrent = self getcurrentprimaryweapon();
    var_0.carrierhascarryweaponinloadout = self hasweapon(var_0.carryweapon);

    if(isdefined(var_0.carryweaponthink))
      self thread[[var_0.carryweaponthink]]();

    self giveweapon(var_0.carryweapon);
    self switchtoweaponimmediate(var_0.carryweapon);
    self disableweaponpickup();
    common_scripts\utility::_disableweaponswitch();
  } else if(!var_0.allowweapons) {
    common_scripts\utility::_disableweapon();

    if(isdefined(var_0.manualdropthink))
      self thread[[var_0.manualdropthink]]();
    else
      thread manualdropthink();
  }

  if(isdefined(var_0.carryicon) && isplayer(self)) {
    if(level.splitscreen) {
      self.carryicon = maps\mp\gametypes\_hud_util::createicon(var_0.carryicon, 33, 33);
      self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", -50, -78);
    } else {
      self.carryicon = maps\mp\gametypes\_hud_util::createicon(var_0.carryicon, 50, 50);
      self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", -90, -110);
    }

    self.carryicon.hidewheninmenu = 1;
    thread hidecarryiconongameend();
  }

  if(isdefined(var_0.goliaththink))
    self thread[[var_0.goliaththink]]();
}

returnhome() {
  self.isresetting = 1;
  self notify("reset");

  for (var_0 = 0; var_0 < self.visuals.size; var_0++) {
    self.visuals[var_0].origin = self.visuals[var_0].baseorigin;
    self.visuals[var_0].angles = self.visuals[var_0].baseangles;
    self.visuals[var_0] show();
  }

  self.trigger.origin = self.trigger.baseorigin;
  self.curorigin = self.trigger.origin;

  if(isdefined(self.onreset))
    self[[self.onreset]]();

  clearcarrier();
  updateworldicons();
  updatecompassicons();
  self.isresetting = 0;
}

ishome() {
  if(isdefined(self.carrier))
    return 0;

  if(self.curorigin != self.trigger.baseorigin)
    return 0;

  return 1;
}

setposition(var_0, var_1) {
  self.isresetting = 1;

  for (var_2 = 0; var_2 < self.visuals.size; var_2++) {
    self.visuals[var_2].origin = var_0;
    self.visuals[var_2].angles = var_1;
    self.visuals[var_2] show();
  }

  self.trigger.origin = var_0;
  self.curorigin = self.trigger.origin;
  clearcarrier();
  updateworldicons();
  updatecompassicons();
  self.isresetting = 0;
}

onplayerlaststand() {
  if(isdefined(self.carryobject))
    self.carryobject thread setdropped();
}

carryobject_overridemovingplatformdeath(var_0) {
  for (var_1 = 0; var_1 < var_0.carryobject.visuals.size; var_1++)
    var_0.carryobject.visuals[var_1] unlink();

  var_0.carryobject.trigger unlink();
  var_0.carryobject notify("stop_pickup_timeout");
  var_0.carryobject returnhome();
}

setdropped() {
  if(isdefined(self.setdropped)) {
    if([
        [self.setdropped]
      ]())
      return;
  }

  self.isresetting = 1;
  self notify("dropped");

  if(isdefined(self.carrier) && self.carrier.team != "spectator") {
    if(isdefined(self.carrier.body)) {
      var_0 = playerphysicstrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000), self.carrier.body);
      var_1 = bullettrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000), 0, self.carrier.body);
    } else {
      var_0 = playerphysicstrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000));
      var_1 = bullettrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000), 0);
    }
  } else {
    var_0 = playerphysicstrace(self.safeorigin + (0, 0, 20), self.safeorigin - (0, 0, 20));
    var_1 = bullettrace(self.safeorigin + (0, 0, 20), self.safeorigin - (0, 0, 20), 0, undefined);
  }

  var_2 = self.carrier;

  if(isdefined(var_0)) {
    var_3 = randomfloat(360);
    var_4 = var_0;

    if(isdefined(self.visualgroundoffset))
      var_4 = var_4 + self.visualgroundoffset;

    if(var_1["fraction"] < 1 && distance(var_1["position"], var_0) < 10.0) {
      var_5 = (cos(var_3), sin(var_3), 0);
      var_5 = vectornormalize(var_5 - var_1["normal"] * vectordot(var_5, var_1["normal"]));
      var_6 = vectortoangles(var_5);
    } else
      var_6 = (0, var_3, 0);

    for (var_7 = 0; var_7 < self.visuals.size; var_7++) {
      self.visuals[var_7].origin = var_4;
      self.visuals[var_7].angles = var_6;
      self.visuals[var_7] show();
    }

    self.trigger.origin = var_4;
    self.curorigin = self.trigger.origin;
    var_8 = spawnstruct();
    var_8.carryobject = self;
    var_8.deathoverridecallback = ::carryobject_overridemovingplatformdeath;
    self.trigger thread maps\mp\_movers::handle_moving_platforms(var_8);
    thread pickuptimeout();
  }

  if(!isdefined(var_0)) {
    for (var_7 = 0; var_7 < self.visuals.size; var_7++) {
      self.visuals[var_7].origin = self.visuals[var_7].baseorigin;
      self.visuals[var_7].angles = self.visuals[var_7].baseangles;
      self.visuals[var_7] show();
    }

    self.trigger.origin = self.trigger.baseorigin;
    self.curorigin = self.trigger.baseorigin;
  }

  if(isdefined(self.ondrop))
    self[[self.ondrop]](var_2);

  clearcarrier();
  updatecompassicons();
  updateworldicons();
  self.isresetting = 0;
}

setcarrier(var_0) {
  self.carrier = var_0;
  thread updatevisibilityaccordingtoradar();
}

clearcarrier() {
  if(!isdefined(self.carrier)) {
    return;
  }
  self.carrier takeobject(self);
  self.carrier = undefined;
  self.curcarrierorigin = undefined;
  self notify("carrier_cleared");
}

pickuptimeout() {
  self endon("pickup_object");
  self endon("stop_pickup_timeout");
  wait 0.05;

  if(istouchingbadtrigger()) {
    returnhome();
    return;
  }

  if(isdefined(self.autoresettime)) {
    wait(self.autoresettime);

    if(!isdefined(self.carrier))
      returnhome();
  }
}

istouchingbadtrigger() {
  var_0 = getentarray("out_of_bounds", "targetname");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!self.visuals[0] istouching(var_0[var_1])) {
      continue;
    }
    return 1;
  }

  if(!self.visuals[0] physicsisactive()) {
    var_0 = getentarray("out_of_bounds_at_rest", "targetname");

    for (var_1 = 0; var_1 < var_0.size; var_1++) {
      if(!self.visuals[0] istouching(var_0[var_1])) {
        continue;
      }
      return 1;
    }
  }

  var_2 = getentarray("trigger_hurt", "classname");

  for (var_1 = 0; var_1 < var_2.size; var_1++) {
    if(!self.visuals[0] istouching(var_2[var_1])) {
      continue;
    }
    return 1;
  }

  if(self.waterbadtrigger) {
    var_3 = getentarray("trigger_underwater", "targetname");

    for (var_1 = 0; var_1 < var_3.size; var_1++) {
      if(!self.visuals[0] istouching(var_3[var_1])) {
        continue;
      }
      return 1;
    }
  }

  return 0;
}

getcarrierweaponcurrent(var_0) {
  if(isdefined(var_0.carrierweaponcurrent) && self hasweapon(var_0.carrierweaponcurrent))
    return var_0.carrierweaponcurrent;

  var_1 = self getweaponslistprimaries();
  return var_1[0];
}

takeobject(var_0) {
  if(isdefined(self.carryicon))
    self.carryicon maps\mp\gametypes\_hud_util::destroyelem();

  if(isdefined(self))
    self.carryobject = undefined;

  self notify("drop_object");

  if(var_0.triggertype == "proximity")
    thread pickupobjectdelay(var_0.trigger.origin);

  if(maps\mp\_utility::isreallyalive(self)) {
    if(isdefined(var_0.carryweapon)) {
      var_1 = isdefined(var_0.keepcarryweapon) && var_0.keepcarryweapon;

      if(!var_0.carrierhascarryweaponinloadout && !var_1)
        self takeweapon(var_0.carryweapon);

      var_2 = getcarrierweaponcurrent(var_0);
      self switchtoweapon(var_2);
      self enableweaponpickup();
      common_scripts\utility::_enableweaponswitch();
    } else if(!var_0.allowweapons)
      common_scripts\utility::_enableweapon();
  }
}

trackcarrier() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  while (isdefined(self.carryobject) && maps\mp\_utility::isreallyalive(self)) {
    if(self isonground()) {
      var_0 = bullettrace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);

      if(var_0["fraction"] < 1)
        self.carryobject.safeorigin = var_0["position"];
    }

    wait 0.05;
  }
}

manualdropthink() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  for (;;) {
    while (self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed())
      wait 0.05;

    while (!self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() && !self meleebuttonpressed())
      wait 0.05;

    if(isdefined(self.carryobject) && !self usebuttonpressed())
      self.carryobject thread setdropped();
  }
}

deleteuseobject() {
  if(isdefined(self.objidallies) && isdefined(self.objidaxis)) {
    maps\mp\_utility::_objective_delete(self.objidallies);
    maps\mp\_utility::_objective_delete(self.objidaxis);
    maps\mp\_utility::_objective_delete(self.objidmlgspectator);
  }

  if(isdefined(self.objpoints)) {
    maps\mp\gametypes\_objpoints::deleteobjpoint(self.objpoints["allies"]);
    maps\mp\gametypes\_objpoints::deleteobjpoint(self.objpoints["axis"]);
    maps\mp\gametypes\_objpoints::deleteobjpoint(self.objpoints["mlg"]);
  }

  self.trigger = undefined;
  self notify("deleted");
}

createuseobject(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnstruct();
  var_5.type = "useObject";
  var_5.curorigin = var_1.origin;
  var_5.ownerteam = var_0;
  var_5.entnum = var_1 getentitynumber();
  var_5.keyobject = undefined;

  if(issubstr(var_1.classname, "use"))
    var_5.triggertype = "use";
  else
    var_5.triggertype = "proximity";

  var_5.trigger = var_1;

  for (var_6 = 0; var_6 < var_2.size; var_6++) {
    var_2[var_6].baseorigin = var_2[var_6].origin;
    var_2[var_6].baseangles = var_2[var_6].angles;
  }

  var_5.visuals = var_2;

  if(!isdefined(var_3))
    var_3 = (0, 0, 0);

  var_5.offset3d = var_3;

  if(!isdefined(var_4) || !var_4) {
    var_5.compassicons = [];
    var_5.objidallies = getnextobjid();
    var_5.objidaxis = getnextobjid();
    var_5.objidmlgspectator = getnextobjid();
    objective_add(var_5.objidallies, "invisible", var_5.curorigin);
    objective_add(var_5.objidaxis, "invisible", var_5.curorigin);
    objective_add(var_5.objidmlgspectator, "invisible", var_5.curorigin);
    objective_team(var_5.objidallies, "allies");
    objective_team(var_5.objidaxis, "axis");
    objective_mlgspectator(var_5.objidmlgspectator);
    var_5.objpoints["allies"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_allies_" + var_5.entnum, var_5.curorigin + var_3, "allies", undefined);
    var_5.objpoints["axis"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_axis_" + var_5.entnum, var_5.curorigin + var_3, "axis", undefined);
    var_5.objpoints["mlg"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_mlg_" + var_5.entnum, var_5.curorigin + var_3, "mlg", undefined);
    var_5.objpoints["mlg"].archived = 0;
    var_5.objpoints["allies"].alpha = 0;
    var_5.objpoints["axis"].alpha = 0;
    var_5.objpoints["mlg"].alpha = 0;
  }

  var_5.interactteam = "none";
  var_5.keepprogress = 0;
  var_5.contesteduiprogress = 0;
  var_5.worldicons = [];
  var_5.visibleteam = "none";
  var_5.onuse = undefined;
  var_5.oncantuse = undefined;
  var_5.usetext = "default";
  var_5.usetime = 10000;
  var_5.curprogress = 0;

  if(var_5.triggertype == "proximity") {
    var_5.teamusetimes = [];
    var_5.teamusetexts = [];
    var_5.numtouching["neutral"] = 0;
    var_5.numtouching["axis"] = 0;
    var_5.numtouching["allies"] = 0;
    var_5.numtouching["none"] = 0;
    var_5.touchlist["neutral"] = [];
    var_5.touchlist["axis"] = [];
    var_5.touchlist["allies"] = [];
    var_5.touchlist["none"] = [];
    var_5.userate = 0;
    var_5.claimteam = "none";
    var_5.claimplayer = undefined;
    var_5.lastclaimteam = "none";
    var_5.lastclaimtime = 0;
    var_5.mustmaintainclaim = 0;
    var_5.cancontestclaim = 0;

    if(level.multiteambased) {
      foreach(var_8 in level.teamnamelist) {
        var_5.numtouching[var_8] = 0;
        var_5.touchlist[var_8] = [];
      }
    }

    var_5 thread useobjectproxthink();
  } else {
    var_5.userate = 1;
    var_5 thread useobjectusethink();
  }

  return var_5;
}

move_use_object(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = (0, 0, 0);

  if(isdefined(self.trigger)) {
    self.trigger dontinterpolate();
    self.trigger.origin = var_0;
  }

  if(isdefined(self.trigger.baseorigin))
    self.trigger.baseorigin = var_0;

  if(isdefined(self.levelflag)) {
    self.levelflag dontinterpolate();
    self.levelflag.origin = var_0;
  }

  if(isdefined(self.visuals)) {
    foreach(var_3 in self.visuals) {
      var_3 dontinterpolate();
      var_3.origin = var_0;
      var_3.baseorigin = var_0;
    }
  }

  if(isdefined(self.origin))
    self.origin = var_0;

  if(isdefined(self.curorigin))
    self.curorigin = var_0;

  if(isdefined(self.goal)) {
    if(isdefined(self.goal.score_fx)) {
      foreach(var_6 in self.goal.score_fx)
      var_6.origin = var_0;
    }

    if(isdefined(self.goal.origin))
      self.goal.origin = var_0;
  }

  if(isdefined(self.objpoints)) {
    foreach(var_9 in self.objpoints)
    var_9 maps\mp\gametypes\_objpoints::updateorigin(var_0 + var_1);
  }

  if(isdefined(self.objidallies))
    objective_position(self.objidallies, var_0);

  if(isdefined(self.objidaxis))
    objective_position(self.objidaxis, var_0);

  if(isdefined(self.objidmlgspectator))
    objective_position(self.objidmlgspectator, var_0);

  if(isdefined(self.baseeffect)) {
    self.baseeffect delete();
    var_11 = self.visuals[0].origin + (0, 0, 32);
    var_12 = self.visuals[0].origin + (0, 0, -32);
    var_13 = bullettrace(var_11, var_12, 0, undefined);
    var_14 = vectortoangles(var_13["normal"]);
    self.baseeffectforward = anglestoforward(var_14);
    self.baseeffectright = anglestoright(var_14);
    self.baseeffectpos = var_13["position"];

    if(level.gametype == "dom")
      maps\mp\gametypes\dom::updatevisuals();
  }
}

setkeyobject(var_0) {
  self.keyobject = var_0;
}

useobjectusethink() {
  level endon("game_ended");
  self endon("deleted");

  for (;;) {
    self.trigger waittill("trigger", var_0);

    if(!maps\mp\_utility::isreallyalive(var_0)) {
      continue;
    }
    if(!caninteractwith(var_0.pers["team"])) {
      continue;
    }
    if(!var_0 isonground()) {
      continue;
    }
    if(var_0 isdodging()) {
      continue;
    }
    var_1 = var_0 getcurrentprimaryweapon();

    if(!var_0 maps\mp\_utility::isjuggernaut() && maps\mp\_utility::iskillstreakweapon(var_1)) {
      continue;
    }
    if(isdefined(self.cantuseweapon) && self.cantuseweapon == var_1) {
      continue;
    }
    if(!checkkeyobject(var_0)) {
      if(isdefined(self.oncantuse))
        self[[self.oncantuse]](var_0);

      continue;
    }

    if(isdefined(var_0.weaponusagename) && var_0.weaponusagename == "h1_claymore_mp") {
      continue;
    }
    if(!var_0 common_scripts\utility::isweaponenabled()) {
      continue;
    }
    var_2 = 1;

    if(self.usetime > 0) {
      if(isdefined(self.onbeginuse))
        self[[self.onbeginuse]](var_0);

      if(!isdefined(self.keyobject))
        thread cantusehintthink();

      var_3 = var_0.pers["team"];
      var_2 = useholdthink(var_0);
      self notify("finished_use");

      if(isdefined(self.onenduse))
        self[[self.onenduse]](var_3, var_0, var_2);
    }

    if(!var_2) {
      continue;
    }
    if(isdefined(self.onuse))
      self[[self.onuse]](var_0);
  }
}

checkkeyobject(var_0) {
  if(!isdefined(self.keyobject))
    return 1;

  if(!isdefined(var_0.carryobject))
    return 0;

  var_1 = self.keyobject;

  if(!isarray(var_1))
    var_1 = [var_1];

  foreach(var_3 in var_1) {
    if(var_3 == var_0.carryobject)
      return 1;
  }

  return 0;
}

cantusehintthink() {
  level endon("game_ended");
  self endon("deleted");
  self endon("finished_use");

  for (;;) {
    self.trigger waittill("trigger", var_0);

    if(!maps\mp\_utility::isreallyalive(var_0)) {
      continue;
    }
    if(!caninteractwith(var_0.pers["team"])) {
      continue;
    }
    if(isdefined(self.oncantuse))
      self[[self.oncantuse]](var_0);
  }
}

getearliestclaimplayer() {
  var_0 = self.claimteam;

  if(maps\mp\_utility::isreallyalive(self.claimplayer))
    var_1 = self.claimplayer;
  else
    var_1 = undefined;

  if(self.touchlist[var_0].size > 0) {
    var_2 = undefined;
    var_3 = getarraykeys(self.touchlist[var_0]);

    for (var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = self.touchlist[var_0][var_3[var_4]];

      if(maps\mp\_utility::isreallyalive(var_5.player) && (!isdefined(var_2) || var_5.starttime < var_2)) {
        var_1 = var_5.player;
        var_2 = var_5.starttime;
      }
    }
  }

  return var_1;
}

useobjectproxthink() {
  level endon("game_ended");
  self endon("deleted");
  thread proxtriggerthink();

  for (;;) {
    waittillframeend;

    if(self.usetime && self.curprogress >= self.usetime) {
      self.curprogress = 0;
      var_0 = getearliestclaimplayer();

      if(isdefined(self.onenduse))
        self[[self.onenduse]](getclaimteam(), var_0, isdefined(var_0));

      if(isdefined(var_0) && isdefined(self.onuse))
        self[[self.onuse]](var_0);

      if(!self.mustmaintainclaim) {
        setclaimteam("none");
        self.claimplayer = undefined;
      }
    }

    if(self.claimteam != "none") {
      if(self.usetime && (!self.mustmaintainclaim || getownerteam() != getclaimteam())) {
        if(!self.numtouching[self.claimteam]) {
          if(isdefined(self.onenduse))
            self[[self.onenduse]](getclaimteam(), self.claimplayer, 0);

          setclaimteam("none");
          self.claimplayer = undefined;
        } else {
          self.curprogress = self.curprogress + 50 * self.userate;

          if(self.curprogress <= 0) {
            self.curprogress = self.curprogress * -1;
            self.lastclaimteam = self.claimteam;
            updateuserate();
          }

          if(isdefined(self.onuseupdate))
            self[[self.onuseupdate]](getclaimteam(), self.curprogress / self.usetime, 50 * self.userate / self.usetime);
        }
      } else if(!self.mustmaintainclaim) {
        if(isdefined(self.onuse))
          self[[self.onuse]](self.claimplayer);

        if(!self.mustmaintainclaim) {
          setclaimteam("none");
          self.claimplayer = undefined;
        }
      } else if(!self.numtouching[self.claimteam]) {
        if(isdefined(self.onunoccupied))
          self[[self.onunoccupied]]();

        setclaimteam("none");
        self.claimplayer = undefined;
      } else if(self.cancontestclaim) {
        var_1 = getnumtouchingexceptteam(self.claimteam);

        if(var_1 > 0) {
          if(isdefined(self.oncontested))
            self[[self.oncontested]]();

          setclaimteam("none");
          self.claimplayer = undefined;
        }
      }
    } else if(self.mustmaintainclaim && getownerteam() != "none") {
      if(!self.numtouching[getownerteam()]) {
        if(isdefined(self.onunoccupied))
          self[[self.onunoccupied]]();
      } else if(self.cancontestclaim && self.lastclaimteam != "none" && self.numtouching[self.lastclaimteam]) {
        var_1 = getnumtouchingexceptteam(self.lastclaimteam);

        if(var_1 == 0) {
          if(isdefined(self.onuncontested))
            self[[self.onuncontested]](self.lastclaimteam);
        }
      }
    }

    wait 0.05;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }
}

canclaim(var_0) {
  if(isdefined(self.carrier))
    return 0;

  if(self.cancontestclaim) {
    var_1 = getnumtouchingexceptteam(var_0.pers["team"]);

    if(var_1 != 0)
      return 0;
  }

  if(checkkeyobject(var_0))
    return 1;

  return 0;
}

proxtriggerthink() {
  level endon("game_ended");
  self endon("deleted");
  var_0 = self.entnum;

  for (;;) {
    self.trigger waittill("trigger", var_1);

    if(!maps\mp\_utility::isreallyalive(var_1)) {
      continue;
    }
    if(!maps\mp\_utility::isgameparticipant(var_1)) {
      continue;
    }
    if(isdefined(self.carrier)) {
      continue;
    }
    if(var_1 maps\mp\_utility::isusingremote() || isdefined(var_1.spawningafterremotedeath) || var_1 maps\mp\_utility::isinremotetransition()) {
      continue;
    }
    if(isdefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }
    if(!isdefined(var_1.initialized_gameobject_vars)) {
      continue;
    }
    if(isdefined(self.nextusetime) && self.nextusetime > gettime()) {
      continue;
    }
    if(isdefined(self.canuseobject) && ![
        [self.canuseobject]
      ](var_1)) {
      continue;
    }
    if(caninteractwith(var_1.pers["team"], var_1) && self.claimteam == "none") {
      if(canclaim(var_1)) {
        if(!proxtriggerlos(var_1, self.visuals)) {
          continue;
        }
        setclaimteam(var_1.pers["team"]);
        self.claimplayer = var_1;
        var_2 = getrelativeteam(var_1.pers["team"]);

        if(isdefined(self.teamusetimes[var_2]))
          self.usetime = self.teamusetimes[var_2];

        if(self.usetime && isdefined(self.onbeginuse))
          self[[self.onbeginuse]](self.claimplayer);
      } else if(isdefined(self.oncantuse))
        self[[self.oncantuse]](var_1);
    }

    if(maps\mp\_utility::isreallyalive(var_1) && !isdefined(var_1.touchtriggers[var_0]))
      var_1 thread triggertouchthink(self);
  }
}

proxtriggerlos(var_0, var_1) {
  if(!isdefined(self.requireslos) || !self.requireslos)
    return 1;

  var_2 = [32, 16, 0];
  var_3 = undefined;

  if(isdefined(var_1) && var_1.size) {
    if(var_1.size > 1) {

    }

    var_3 = var_1[0];
  }

  var_4 = var_0.origin - self.trigger.origin;
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = vectornormalize(var_4);
  var_4 = var_4 * 5;

  foreach(var_6 in var_2) {
    var_7 = var_0 geteye();
    var_8 = self.trigger.origin + var_4 + (0, 0, var_6);
    var_9 = bullettrace(var_7, var_8, 0, var_3, 0, 0, 0, 0, 1, 0, 0);

    if(var_9["fraction"] == 1)
      return 1;
  }

  return 0;
}

setclaimteam(var_0) {
  if(self.keepprogress) {
    if(self.lastclaimteam == "none")
      self.lastclaimteam = var_0;

    self.claimteam = var_0;
  } else {
    if(self.claimteam == "none" && gettime() - self.lastclaimtime > 1000)
      self.curprogress = 0;
    else if(var_0 != "none" && var_0 != self.lastclaimteam)
      self.curprogress = 0;

    self.lastclaimteam = self.claimteam;
  }

  self.lastclaimtime = gettime();
  self.claimteam = var_0;
  updateuserate();
}

getclaimteam() {
  return self.claimteam;
}

triggertouchthink(var_0) {
  if(isdefined(level.ishorde) && level.ishorde) {
    level endon("game_ended");
    var_0 endon("deleted");
  }

  var_1 = self.pers["team"];
  var_0 _setnumtouching(var_1, var_0.numtouching[var_1] + 1);
  var_2 = self.guid;
  var_3 = spawnstruct();
  var_3.player = self;
  var_3.starttime = gettime();
  var_0.touchlist[var_1][var_2] = var_3;

  if(!isdefined(var_0.nousebar))
    var_0.nousebar = 0;

  self.touchtriggers[var_0.entnum] = var_0.trigger;
  var_0 updateuserate();

  while (maps\mp\_utility::isreallyalive(self) && isdefined(var_0.trigger) && (self istouching(var_0.trigger) || isboostingabovetriggerradius(var_0.trigger)) && !level.gameended) {
    if(isplayer(self) && var_0.usetime) {
      updateuiprogress(var_0, 1);
      updateproxbar(var_0, 0);
    }

    wait 0.05;
  }

  if(isdefined(self) && isdefined(self.touchtriggers)) {
    if(isplayer(self) && var_0.usetime) {
      updateuiprogress(var_0, 0);
      updateproxbar(var_0, 1);
    }

    self.touchtriggers[var_0.entnum] = undefined;
  }

  if(level.gameended) {
    return;
  }
  var_0.touchlist[var_1][var_2] = undefined;
  var_0 _setnumtouching(var_1, var_0.numtouching[var_1] - 1);
  var_0 updateuserate();
}

_setnumtouching(var_0, var_1) {
  var_2 = self.numtouching[var_0];
  self.numtouching[var_0] = var_1;

  if(isdefined(self.onnumtouchingchanged))
    [[self.onnumtouchingchanged]](var_0, var_2, var_1);
}

isboostingabovetriggerradius(var_0) {
  if(!isdefined(level.allowboostingabovetriggerradius) || !level.allowboostingabovetriggerradius)
    return 0;

  if(!maps\mp\_utility::isaugmentedgamemode())
    return 0;

  if(!self ishighjumping())
    return 0;

  var_1 = distance2dsquared(self.origin, var_0.origin);

  if(var_1 < var_0.radius * var_0.radius)
    return 1;

  return 0;
}

updateproxbar(var_0, var_1) {
  var_2 = self.pers["team"];

  if(var_1 || !var_0 caninteractwith(var_2) || var_2 != var_0.claimteam || var_0.nousebar) {
    if(isdefined(self.proxbar))
      self.proxbar maps\mp\gametypes\_hud_util::hideelem();

    if(isdefined(self.proxbartext))
      self.proxbartext maps\mp\gametypes\_hud_util::hideelem();

    return;
  }

  if(!isdefined(self.proxbar)) {
    self.proxbar = maps\mp\gametypes\_hud_util::createprimaryprogressbar();
    self.proxbar.lastuserate = undefined;
    self.proxbar.lasthostmigrationstate = 0;
  }

  if(self.proxbar.hidden) {
    self.proxbar maps\mp\gametypes\_hud_util::showelem();
    self.proxbar.lastuserate = undefined;
    self.proxbar.lasthostmigrationstate = 0;
  }

  if(!isdefined(self.proxbartext)) {
    self.proxbartext = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
    var_3 = var_0 getrelativeteam(var_2);

    if(isdefined(var_0.teamusetexts[var_3]))
      self.proxbartext settext(var_0.teamusetexts[var_3]);
    else
      self.proxbartext settext(var_0.usetext);
  }

  if(self.proxbartext.hidden) {
    self.proxbartext maps\mp\gametypes\_hud_util::showelem();
    var_3 = var_0 getrelativeteam(var_2);

    if(isdefined(var_0.teamusetexts[var_3]))
      self.proxbartext settext(var_0.teamusetexts[var_3]);
    else
      self.proxbartext settext(var_0.usetext);
  }

  if(!isdefined(self.proxbar.lastuserate) || self.proxbar.lastuserate != var_0.userate || self.proxbar.lasthostmigrationstate != isdefined(level.hostmigrationtimer)) {
    if(var_0.curprogress > var_0.usetime)
      var_0.curprogress = var_0.usetime;

    var_4 = var_0.curprogress / var_0.usetime;
    var_5 = 1000 / var_0.usetime * var_0.userate;

    if(isdefined(level.hostmigrationtimer))
      var_5 = 0;

    if(var_0.keepprogress && !var_4 && var_5 < 0)
      var_5 = 0;

    self.proxbar maps\mp\gametypes\_hud_util::updatebar(var_4, var_5);
    self.proxbar.lastuserate = var_0.userate;
    self.proxbar.lasthostmigrationstate = isdefined(level.hostmigrationtimer);
  }
}

getnumtouchingexceptteam(var_0) {
  return self.numtouching[maps\mp\_utility::getotherteam(var_0)];
}

updateuiprogress(var_0, var_1) {
  var_2 = level.gametype;
  var_3 = var_0.id;
  var_4 = 0;

  if(!isdefined(level.hostmigrationtimer)) {
    if(var_0.curprogress > var_0.usetime)
      var_0.curprogress = var_0.usetime;

    var_5 = var_0.curprogress / var_0.usetime;

    if(var_0.contesteduiprogress) {
      if(var_1 && isdefined(var_0.stalemate) && var_0.stalemate) {
        var_6 = var_0 getearliestclaimplayer();
        var_4 = 1;

        if(isdefined(var_6) && var_6.team != self.team)
          var_5 = 0.01;
      }

      if(!var_1 || var_0.claimteam != self.team)
        var_5 = 0.01;

      if(var_5 != 0)
        self setclientomnvar("ui_capture_progress", var_5);
    }

    if((var_2 == "sd" || var_2 == "sr" || var_2 == "sab" || var_2 == "dd") && isdefined(var_3) && (var_3 == "bombZone" || var_3 == "defuseObject")) {
      if(!var_1)
        var_5 = 0;

      var_5 = max(0.01, var_5);

      if(var_5 != 0)
        self setclientomnvar("ui_capture_progress", var_5);
    }
  }

  if(var_0.contesteduiprogress) {
    if(var_1 && var_0.ownerteam == self.team)
      var_1 = 0;

    if(!var_1)
      self setclientomnvar("ui_capture_icon", 0);
    else if(!var_4) {
      if(var_2 == "dom")
        self setclientomnvar("ui_capture_icon", 1);
      else if(var_0.ownerteam == "neutral" || maps\mp\_utility::is_true(level.captureinsteadofdestroy))
        self setclientomnvar("ui_capture_icon", 2);
      else
        self setclientomnvar("ui_capture_icon", 3);
    } else
      self setclientomnvar("ui_capture_icon", 4);
  }

  if((var_2 == "sd" || var_2 == "sr" || var_2 == "sab" || var_2 == "dd") && isdefined(var_3) && (var_3 == "bombZone" || var_3 == "defuseObject")) {
    if(!var_1)
      self setclientomnvar("ui_capture_icon", 0);
    else if(var_0 isfriendlyteam(self.pers["team"]))
      self setclientomnvar("ui_capture_icon", 6);
    else
      self setclientomnvar("ui_capture_icon", 5);
  }
}

updateuserate() {
  if(isdefined(self.onupdateuserate))
    self[[self.onupdateuserate]]();
  else
    updateuserate_internal();
}

updateuserate_internal() {
  var_0 = self.numtouching[self.claimteam];
  var_1 = 0;
  var_2 = 0;

  if(level.multiteambased) {
    foreach(var_4 in level.teamnamelist) {
      if(self.claimteam != var_4)
        var_1 = var_1 + self.numtouching[var_4];
    }
  } else {
    if(self.claimteam != "axis")
      var_1 = var_1 + self.numtouching["axis"];

    if(self.claimteam != "allies")
      var_1 = var_1 + self.numtouching["allies"];
  }

  foreach(var_7 in self.touchlist[self.claimteam]) {
    if(!isdefined(var_7.player)) {
      continue;
    }
    if(var_7.player.pers["team"] != self.claimteam) {
      continue;
    }
    if(var_7.player.objectivescaler == 1) {
      continue;
    }
    var_0 = var_0 * var_7.player.objectivescaler;
    var_2 = var_7.player.objectivescaler;
  }

  self.userate = 0;
  self.stalemate = var_0 && var_1;

  if(var_0 && !var_1)
    self.userate = min(var_0, 4);

  if(isdefined(self.isarena) && self.isarena && var_2 != 0)
    self.userate = 1 * var_2;
  else if(isdefined(self.isarena) && self.isarena)
    self.userate = 1;

  if(self.keepprogress && self.lastclaimteam != self.claimteam)
    self.userate = self.userate * -1;
}

attachusemodel() {
  self endon("death");
  self endon("disconnect");
  self endon("done_using");
  wait 0.7;
  self attach("wpn_h1_briefcase_bomb_npc", "tag_inhand", 1);
  self.attachedusemodel = "wpn_h1_briefcase_bomb_npc";
}

useholdthink(var_0) {
  var_0 notify("use_hold");

  if(isplayer(var_0))
    var_0 playerlinkto(self.trigger);
  else
    var_0 linkto(self.trigger);

  var_0 playerlinkedoffsetenable();
  var_0 clientclaimtrigger(self.trigger);
  var_0.claimtrigger = self.trigger;
  var_1 = self.useweapon;
  var_2 = var_0 getcurrentweapon();

  if(isdefined(var_1)) {
    if(var_2 == var_1)
      var_2 = var_0.lastnonuseweapon;

    var_0.lastnonuseweapon = var_2;
    var_0 maps\mp\_utility::_giveweapon(var_1);
    var_0 setweaponammostock(var_1, 0);
    var_0 setweaponammoclip(var_1, 0);
    var_0 switchtoweapon(var_1);

    if(!isdefined(self.attachdefault3pmodel) || self.attachdefault3pmodel == 1)
      var_0 thread attachusemodel();
  } else
    var_0 common_scripts\utility::_disableweapon();

  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;

  if(isplayer(var_0))
    var_0 thread personalusebar(self);

  var_3 = useholdthinkloop(var_0, var_2);

  if(isdefined(var_0)) {
    var_0 detachusemodels();
    var_0 notify("done_using");
  }

  if(isdefined(var_1) && isdefined(var_0))
    var_0 thread takeuseweapon(var_1);

  if(isdefined(var_3) && var_3)
    return 1;

  if(isdefined(var_0)) {
    var_0.claimtrigger = undefined;

    if(isdefined(var_1)) {
      if(var_2 != "none")
        var_0 maps\mp\_utility::switch_to_last_weapon(var_2);
      else
        var_0 takeweapon(var_1);
    } else
      var_0 common_scripts\utility::_enableweapon();

    var_0 unlink();

    if(!maps\mp\_utility::isreallyalive(var_0))
      var_0.killedinuse = 1;
  }

  self.inuse = 0;
  self.trigger releaseclaimedtrigger();
  return 0;
}

detachusemodels() {
  if(isdefined(self.attachedusemodel)) {
    self detach(self.attachedusemodel, "tag_inhand");
    self.attachedusemodel = undefined;
  }
}

takeuseweapon(var_0) {
  self endon("use_hold");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while (self getcurrentweapon() == var_0 && !isdefined(self.throwinggrenade))
    wait 0.05;

  self takeweapon(var_0);
}

usetest(var_0, var_1, var_2, var_3) {
  if(!maps\mp\_utility::isreallyalive(var_0))
    return 0;

  if(!var_0 istouching(self.trigger))
    return 0;

  if(!var_0 usebuttonpressed())
    return 0;

  if(isdefined(var_0.throwinggrenade))
    return 0;

  if(var_0 meleebuttonpressed())
    return 0;

  if(self.curprogress >= self.usetime)
    return 0;

  if(!self.userate && !var_1)
    return 0;

  if(var_1 && var_2 > var_3)
    return 0;

  return 1;
}

useholdthinkloop(var_0, var_1) {
  level endon("game_ended");
  self endon("disabled");
  var_2 = self.useweapon;
  var_3 = 1;
  var_4 = 0;
  var_5 = 1.5;

  while (usetest(var_0, var_3, var_4, var_5)) {
    var_4 = var_4 + 0.05;

    if(!isdefined(var_2) || var_0 getcurrentweapon() == var_2) {
      self.curprogress = self.curprogress + 50 * self.userate;
      self.userate = 1 * var_0.objectivescaler;
      var_3 = 0;
    } else
      self.userate = 0;

    if(self.curprogress >= self.usetime) {
      self.inuse = 0;
      var_0 clientreleasetrigger(self.trigger);
      var_0.claimtrigger = undefined;

      if(isdefined(var_2)) {
        var_0 setweaponammostock(var_2, 1);
        var_0 setweaponammoclip(var_2, 1);

        if(var_1 != "none")
          var_0 maps\mp\_utility::switch_to_last_weapon(var_1);
        else
          var_0 takeweapon(var_2);
      } else
        var_0 common_scripts\utility::_enableweapon();

      var_0 unlink();
      return maps\mp\_utility::isreallyalive(var_0);
    }

    wait 0.05;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }

  return 0;
}

personalusebar(var_0) {
  self endon("disconnect");
  var_1 = undefined;

  if(!isdefined(var_0.nousebar) || !var_0.nousebar)
    var_1 = maps\mp\gametypes\_hud_util::createprimaryprogressbar();

  var_2 = undefined;

  if(isdefined(var_1) && isdefined(var_0.usetext)) {
    var_2 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
    var_2 settext(var_0.usetext);
  }

  var_3 = -1;
  var_4 = isdefined(level.hostmigrationtimer);

  while (maps\mp\_utility::isreallyalive(self) && var_0.inuse && !level.gameended) {
    if(var_3 != var_0.userate || var_4 != isdefined(level.hostmigrationtimer)) {
      if(var_0.curprogress > var_0.usetime)
        var_0.curprogress = var_0.usetime;

      var_5 = var_0.curprogress / var_0.usetime;
      var_6 = 1000 / var_0.usetime * var_0.userate;

      if(isdefined(level.hostmigrationtimer))
        var_6 = 0;

      if(isdefined(var_1)) {
        var_1 maps\mp\gametypes\_hud_util::updatebar(var_5, var_6);

        if(!var_0.userate) {
          var_1 maps\mp\gametypes\_hud_util::hideelem();

          if(isdefined(var_2))
            var_2 maps\mp\gametypes\_hud_util::hideelem();
        } else {
          var_1 maps\mp\gametypes\_hud_util::showelem();

          if(isdefined(var_2))
            var_2 maps\mp\gametypes\_hud_util::showelem();
        }
      }
    }

    var_3 = var_0.userate;
    var_4 = isdefined(level.hostmigrationtimer);
    updateuiprogress(var_0, 1);
    wait 0.05;
  }

  updateuiprogress(var_0, 0);

  if(isdefined(var_1))
    var_1 maps\mp\gametypes\_hud_util::destroyelem();

  if(isdefined(var_2))
    var_2 maps\mp\gametypes\_hud_util::destroyelem();
}

updatetrigger() {
  if(self.triggertype != "use") {
    return;
  }
  if(self.interactteam == "none")
    self.trigger.origin = self.trigger.origin - (0, 0, 50000);
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
      self.trigger.origin = self.trigger.origin - (0, 0, 50000);
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

  updateworldicon("mlg", 1);
}

updateworldicon(var_0, var_1) {
  if(!isdefined(self.worldicons[var_0]))
    var_1 = 0;

  var_2 = getupdateteams(var_0);

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = "objpoint_" + var_2[var_3] + "_" + self.entnum;
    var_5 = maps\mp\gametypes\_objpoints::getobjpointbyname(var_4);

    if(!isdefined(var_5)) {
      continue;
    }
    var_5 notify("stop_flashing_thread");
    var_5 thread maps\mp\gametypes\_objpoints::stopflashing();

    if(var_1) {
      var_5 setshader(self.worldicons[var_0], level.objpointsize, level.objpointsize);
      var_5 fadeovertime(0.05);
      var_5.alpha = var_5.basealpha;
      var_5.isshown = 1;

      if(isdefined(self.compassicons[var_0]))
        var_5 setwaypoint(1, 1);
      else
        var_5 setwaypoint(1, 0);

      if(self.type == "carryObject") {
        if(isdefined(self.carrier) && !shouldpingobject(var_0))
          var_5 settargetent(self.carrier);
        else if(!isdefined(self.carrier) && isdefined(self.objectiveonvisuals) && self.objectiveonvisuals)
          var_5 settargetent(self.visuals[0]);
        else
          var_5 cleartargetent();
      }
    } else {
      var_5 fadeovertime(0.05);
      var_5.alpha = 0;
      var_5.isshown = 0;
      var_5 cleartargetent();
    }

    var_5 thread hideworldiconongameend();
  }
}

hideworldiconongameend() {
  self notify("hideWorldIconOnGameEnd");
  self endon("hideWorldIconOnGameEnd");
  self endon("death");
  level waittill("game_ended");

  if(isdefined(self))
    self.alpha = 0;
}

updatetimer(var_0, var_1) {}

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

  updatecompassicon("mlg", 1);
}

updatecompassicon(var_0, var_1) {
  if(!isdefined(self.compassicons)) {
    return;
  }
  var_2 = getupdateteams(var_0);

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_1;

    if(!var_4 && shouldshowcompassduetoradar(var_2[var_3]))
      var_4 = 1;

    var_5 = self.objidallies;

    if(var_2[var_3] == "axis")
      var_5 = self.objidaxis;

    if(var_2[var_3] == "mlg")
      var_5 = self.objidmlgspectator;

    if(!isdefined(self.compassicons[var_0]) || !var_4) {
      objective_state(var_5, "invisible");
      continue;
    }

    objective_icon(var_5, self.compassicons[var_0]);
    objective_state(var_5, "active");

    if(self.type == "carryObject") {
      if(maps\mp\_utility::isreallyalive(self.carrier) && !shouldpingobject(var_0)) {
        objective_onentity(var_5, self.carrier);
        continue;
      }

      if(isdefined(self.objectiveonvisuals) && self.objectiveonvisuals) {
        objective_onentity(var_5, self.visuals[0]);
        continue;
      }

      objective_position(var_5, self.curorigin);
    }
  }
}

shouldpingobject(var_0) {
  if(var_0 == "friendly" && self.objidpingfriendly)
    return 1;
  else if(var_0 == "enemy" && self.objidpingenemy)
    return 1;

  return 0;
}

getupdateteams(var_0) {
  var_1 = [];

  if(var_0 == "friendly") {
    if(isfriendlyteam("allies"))
      var_1[var_1.size] = "allies";

    if(isfriendlyteam("axis"))
      var_1[var_1.size] = "axis";
  } else if(var_0 == "enemy") {
    if(!isfriendlyteam("allies"))
      var_1[var_1.size] = "allies";

    if(!isfriendlyteam("axis"))
      var_1[var_1.size] = "axis";
  } else if(var_0 == "mlg")
    var_1[var_1.size] = "mlg";

  return var_1;
}

shouldshowcompassduetoradar(var_0) {
  if(var_0 == "mlg")
    return 0;

  if(!isdefined(self.carrier))
    return 0;

  if(self.carrier maps\mp\_utility::_hasperk("specialty_radarimmune"))
    return 0;

  return getteamradar(var_0);
}

updatevisibilityaccordingtoradar() {
  self endon("death");
  self endon("carrier_cleared");

  for (;;) {
    level waittill("radar_status_change");
    updatecompassicons();
  }
}

setownerteam(var_0) {
  self.ownerteam = var_0;
  updatetrigger();
  updatecompassicons();
  updateworldicons();
}

getownerteam() {
  return self.ownerteam;
}

setusetime(var_0) {
  self.usetime = int(var_0 * 1000);
}

setusetext(var_0) {
  self.usetext = var_0;
}

setteamusetime(var_0, var_1) {
  self.teamusetimes[var_0] = int(var_1 * 1000);
}

setteamusetext(var_0, var_1) {
  self.teamusetexts[var_0] = var_1;
}

setusehinttext(var_0) {
  self.trigger sethintstring(var_0);
}

allowcarry(var_0) {
  self.interactteam = var_0;
}

allowuse(var_0) {
  self.interactteam = var_0;
  updatetrigger();
}

setvisibleteam(var_0) {
  self.visibleteam = var_0;
  updatecompassicons();
  updateworldicons();
}

setmodelvisibility(var_0) {
  if(var_0) {
    for (var_1 = 0; var_1 < self.visuals.size; var_1++) {
      self.visuals[var_1] show();

      if(self.visuals[var_1].classname == "script_brushmodel" || self.visuals[var_1].classname == "script_model") {
        foreach(var_3 in level.players) {
          if(var_3 istouching(self.visuals[var_1]))
            var_3 maps\mp\_utility::_suicide();
        }

        self.visuals[var_1] thread makesolid();
      }
    }
  } else {
    for (var_1 = 0; var_1 < self.visuals.size; var_1++) {
      self.visuals[var_1] hide();

      if(self.visuals[var_1].classname == "script_brushmodel" || self.visuals[var_1].classname == "script_model") {
        self.visuals[var_1] notify("changing_solidness");
        self.visuals[var_1] notsolid();
      }
    }
  }
}

makesolid() {
  self endon("death");
  self notify("changing_solidness");
  self endon("changing_solidness");

  for (;;) {
    for (var_0 = 0; var_0 < level.players.size; var_0++) {
      if(level.players[var_0] istouching(self)) {
        break;
      }
    }

    if(var_0 == level.players.size) {
      self solid();
      break;
    }

    wait 0.05;
  }
}

setcarriervisible(var_0) {
  self.carriervisible = var_0;
}

setcanuse(var_0) {
  self.useteam = var_0;
}

set2dicon(var_0, var_1) {
  self.compassicons[var_0] = var_1;
  updatecompassicons();
}

set3dicon(var_0, var_1) {
  self.worldicons[var_0] = var_1;
  updateworldicons();
}

set3duseicon(var_0, var_1) {
  self.worlduseicons[var_0] = var_1;
}

setcarryicon(var_0) {
  self.carryicon = var_0;
}

disableobject() {
  self notify("disabled");

  if(self.type == "carryObject") {
    if(isdefined(self.carrier))
      self.carrier takeobject(self);

    for (var_0 = 0; var_0 < self.visuals.size; var_0++)
      self.visuals[var_0] hide();
  }

  self.trigger common_scripts\utility::trigger_off();
  setvisibleteam("none");
}

enableobject() {
  if(self.type == "carryObject") {
    for (var_0 = 0; var_0 < self.visuals.size; var_0++)
      self.visuals[var_0] show();
  }

  self.trigger common_scripts\utility::trigger_on();
  setvisibleteam("any");
}

getrelativeteam(var_0) {
  if(var_0 == self.ownerteam)
    return "friendly";
  else
    return "enemy";
}

isfriendlyteam(var_0) {
  var_1 = getclaimteam();

  if(isdefined(var_1) && self.ownerteam == "neutral" && var_1 != "none" && var_1 != var_0)
    return 1;

  if(self.ownerteam == "any")
    return 1;

  if(self.ownerteam == var_0)
    return 1;

  return 0;
}

caninteractwith(var_0, var_1) {
  switch (self.interactteam) {
    case "none":
      return 0;
    case "any":
      return 1;
    case "friendly":
      if(var_0 == self.ownerteam)
        return 1;
      else
        return 0;
    case "enemy":
      if(var_0 != self.ownerteam)
        return 1;
      else
        return 0;
    default:
      return 0;
  }
}

isteam(var_0) {
  if(var_0 == "neutral")
    return 1;

  if(var_0 == "allies")
    return 1;

  if(var_0 == "axis")
    return 1;

  if(var_0 == "any")
    return 1;

  if(var_0 == "none")
    return 1;

  foreach(var_2 in level.teamnamelist) {
    if(var_0 == var_2)
      return 1;
  }

  return 0;
}

isrelativeteam(var_0) {
  if(var_0 == "friendly")
    return 1;

  if(var_0 == "enemy")
    return 1;

  if(var_0 == "any")
    return 1;

  if(var_0 == "none")
    return 1;

  return 0;
}

getenemyteam(var_0) {
  if(level.multiteambased) {}

  if(var_0 == "neutral")
    return "none";
  else if(var_0 == "allies")
    return "axis";
  else
    return "allies";
}

getnextobjid() {
  if(!isdefined(level.reclaimedreservedobjectives) || level.reclaimedreservedobjectives.size < 1) {
    var_0 = level.numgametypereservedobjectives;
    level.numgametypereservedobjectives++;
  } else {
    var_0 = level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size - 1];
    level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size - 1] = undefined;
  }

  if(var_0 > 35) {
    if(isdefined(level.ishorde) && level.ishorde) {

    }

    var_0 = 35;
  }

  return var_0;
}

getlabel() {
  var_0 = self.trigger.script_label;

  if(!isdefined(var_0)) {
    var_0 = "";
    return var_0;
  }

  if(var_0[0] != "_")
    return "_" + var_0;

  return var_0;
}

initializetagpathvariables() {
  self.nearest_node = undefined;
  self.calculated_nearest_node = 0;
  self.on_path_grid = undefined;
}

mustmaintainclaim(var_0) {
  self.mustmaintainclaim = var_0;
}

cancontestclaim(var_0) {
  self.cancontestclaim = var_0;
}

fake_loot_dispensation_logic() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = 120;
  var_1 = randomintrange(30, 90);
  var_0 = var_0 + var_1;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self waittill("show_loot_notification");
}