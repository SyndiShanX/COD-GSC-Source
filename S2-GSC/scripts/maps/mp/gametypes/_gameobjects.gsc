/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_gameobjects.gsc
******************************************************/

main(var_0) {
  var_0[var_0.size] = "airdrop_pallet";
  var_1 = getEntArray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2].dropweapon)) {
      var_3 = 1;
      var_4 = strtok(var_1[var_2].dropweapon, " ");

      for(var_5 = 0; var_5 < var_0.size; var_5++) {
        for(var_6 = 0; var_6 < var_4.size; var_6++) {
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
        if(isDefined(var_1[var_2].setdepthoffield)) {
          common_scripts\_createfx::removefxentwithentity(var_1[var_2]);
        }

        var_1[var_2] delete();
      }
    }
  }
}

init() {
  level.numgametypereservedobjectives = 0;
  level.objidstart = 0;
  level thread onplayerconnect();
}

onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
    var_0 thread ondisconnect();
  }
}

onplayerspawned() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");

    if(isDefined(self.gameobject_fauxspawn)) {
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
  self._id_5A3E = undefined;
  self.initialized_gameobject_vars = 1;
}

ondeath() {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.carryobject)) {
    if(_func_367() || isDefined(self.carryobject._id_2D3F) && self.carryobject._id_2D3F) {
      self.carryobject deletecarryobject();
      return;
    }

    self.carryobject thread setdropped();

    if(level.gametype == "relic") {
      level maps\mp\gametypes\relic::attemptdropteslagun(self.origin);
    }
  }
}

ondisconnect() {
  level endon("game_ended");
  self waittill("disconnect");

  if(isDefined(self.carryobject)) {
    if(_func_367()) {
      self.carryobject deletecarryobject();
      return;
    }

    self.carryobject thread setdropped();
  }
}

createcarryobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.type = "carryObject";
  var_7.curorigin = var_1.origin;
  var_7.ownerteam = var_0;
  var_7.entnum = var_1 getentitynumber();

  if(issubstr(var_1.classname, "use")) {
    var_7.triggertype = "use";
  } else {
    var_7.triggertype = "proximity";
  }

  var_1.baseorigin = var_1.origin;
  var_7.trigger = var_1;
  var_7.useweapon = undefined;

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_7.offset3d = var_3;

  for(var_8 = 0; var_8 < var_2.size; var_8++) {
    var_2[var_8].baseorigin = var_2[var_8].origin;
    var_2[var_8].baseangles = var_2[var_8].angles;
  }

  var_7.visuals = var_2;

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!var_5) {
    if(!isDefined(var_6)) {
      var_6 = 0;
    }

    var_7.compassicons = [];
    var_7.objidallies = _id_45A9();
    var_7.objidaxis = _id_45A9();
    var_7.objidmlgspectator = _id_45A9();
    var_7.objidpingfriendly = 0;
    var_7.objidpingenemy = 0;
    var_7.objpingdelay = 5.0;
    level.objidstart = level.objidstart + 2;
    _objective_add(var_7.objidallies, "invisible", var_7.curorigin);
    _objective_add(var_7.objidaxis, "invisible", var_7.curorigin);
    _objective_add(var_7.objidmlgspectator, "invisible", var_7.curorigin);
    _objective_team(var_7.objidallies, "allies");
    _objective_team(var_7.objidaxis, "axis");
    _objective_mlgspectator(var_7.objidmlgspectator);

    if(var_6) {
      var_7.objpoints["allies"] = _id_04EC::createteamobjpoint("objpoint_allies_" + var_7.entnum, var_7.curorigin + var_3, "allies", undefined);
      var_7.objpoints["axis"] = _id_04EC::createteamobjpoint("objpoint_axis_" + var_7.entnum, var_7.curorigin + var_3, "axis", undefined);
      var_7.objpoints["broadcaster"] = _id_04EC::createteamobjpoint("objpoint_broadcaster_" + var_7.entnum, var_7.curorigin + var_3, "broadcaster", undefined);
      var_7.objpoints["broadcaster"].archived = 0;
      var_7.objpoints["allies"].alpha = 0;
      var_7.objpoints["axis"].alpha = 0;
    }
  }

  var_7.carrier = undefined;
  var_7.isresetting = 0;
  var_7.interactteam = "none";
  var_7._id_0C33 = 0;
  var_7.waterbadtrigger = 0;
  var_7.keepprogress = 0;
  var_7.worldicons = [];
  var_7._id_AA89 = [];
  var_7._id_356E = undefined;
  var_7._id_200B = 0;
  var_7.visibleteam = "none";
  var_7.carryicon = undefined;
  var_7._id_6AEF = undefined;
  var_7.onpickup = undefined;
  var_7.onreset = undefined;

  if(var_7.triggertype == "use") {
    var_7 thread carryobjectusethink();
  } else {
    var_7.curprogress = 0;
    var_7.usetime = 0;
    var_7.userate = 0;
    var_7.mustmaintainclaim = 0;
    var_7.cancontestclaim = 0;
    var_7._id_5107 = 0;
    var_7.teamusetimes = [];
    var_7.teamusetexts = [];
    var_7.numtouching["neutral"] = 0;
    var_7.numtouching["axis"] = 0;
    var_7.numtouching["allies"] = 0;
    var_7.numtouching["none"] = 0;
    var_7.touchlist["neutral"] = [];
    var_7.touchlist["axis"] = [];
    var_7.touchlist["allies"] = [];
    var_7.touchlist["none"] = [];
    var_7.claimteam = "none";
    var_7.claimplayer = undefined;
    var_7._id_5B81 = undefined;
    var_7.lastclaimteam = "none";
    var_7.lastclaimtime = 0;

    if(level.multiteambased) {
      foreach(var_10 in level.teamnamelist) {
        var_7.numtouching[var_10] = 0;
        var_7.touchlist[var_10] = [];
      }
    }

    var_7 thread _id_2018();
  }

  if(!var_5) {
    var_7 thread updatecarryobjectorigin(var_4);
  }

  return var_7;
}

deletecarryobject() {
  if(!isDefined(self.type) || self.type != "carryObject") {
    return;
  }
  var_0 = self;
  var_0.type = undefined;
  var_0.curorigin = undefined;
  var_0.ownerteam = undefined;
  var_0.entnum = undefined;
  var_0.triggertype = undefined;
  var_0.trigger unlink();
  var_0.trigger delete();
  var_0.trigger = undefined;
  var_0.useweapon = undefined;
  var_0.offset3d = undefined;

  foreach(var_2 in var_0.visuals) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }

  var_0.visuals = undefined;

  if(!_func_367()) {
    if(isDefined(var_0.objidallies)) {
      maps\mp\_utility::_objective_delete(var_0.objidallies);
    }

    if(isDefined(var_0.objidaxis)) {
      maps\mp\_utility::_objective_delete(var_0.objidaxis);
    }

    if(isDefined(var_0.objidmlgspectator)) {
      maps\mp\_utility::_objective_delete(var_0.objidmlgspectator);
    }
  }

  var_0.compassicons = undefined;
  var_0.objidallies = undefined;
  var_0.objidaxis = undefined;
  var_0.objidmlgspectator = undefined;
  var_0.objidpingfriendly = undefined;
  var_0.objidpingenemy = undefined;
  var_0.objpingdelay = undefined;

  if(isDefined(var_0.objpoints)) {
    _id_04EC::deleteobjpoint(var_0.objpoints["allies"]);
    _id_04EC::deleteobjpoint(var_0.objpoints["axis"]);
    _id_04EC::deleteobjpoint(var_0.objpoints["broadcaster"]);
  }

  var_0.objpoints = undefined;
  var_0.carrier = undefined;
  var_0.isresetting = undefined;
  var_0.interactteam = undefined;
  var_0._id_0C33 = undefined;
  var_0.waterbadtrigger = undefined;
  var_0.keepprogress = undefined;
  var_0.worldicons = undefined;
  var_0._id_AA89 = undefined;
  var_0._id_356E = undefined;
  var_0._id_200B = undefined;
  var_0.visibleteam = undefined;
  var_0.carryicon = undefined;
  var_0._id_6AEF = undefined;
  var_0.onpickup = undefined;
  var_0.onreset = undefined;
  var_0.curprogress = undefined;
  var_0.usetime = undefined;
  var_0.userate = undefined;
  var_0.mustmaintainclaim = undefined;
  var_0.cancontestclaim = undefined;
  var_0._id_5107 = undefined;
  var_0.teamusetimes = undefined;
  var_0.teamusetexts = undefined;
  var_0.numtouching = undefined;
  var_0.touchlist = undefined;
  var_0.claimteam = undefined;
  var_0.claimplayer = undefined;
  var_0._id_5B81 = undefined;
  var_0.lastclaimteam = undefined;
  var_0.lastclaimtime = undefined;
  var_0 notify("death");
  var_0 notify("deleted");
}

carryobjectusethink() {
  level endon("game_ended");

  for(;;) {
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
    if(!isDefined(var_0.initialized_gameobject_vars)) {
      continue;
    }
    if(isDefined(var_0.throwinggrenade)) {
      continue;
    }
    if(isDefined(self.carrier)) {
      continue;
    }
    if(var_0 maps\mp\_utility::isusingremote() || var_0 maps\mp\_utility::isinremotetransition()) {
      continue;
    }
    setpickedup(var_0);
  }
}

_id_2018() {
  thread carryobjectproxthinkdelayed();
}

carryobjectproxthinkdelayed() {
  if(_func_367()) {
    self endon("death");
    self endon("deleted");
  }

  if(isDefined(level._id_5677) && level._id_5677 || isDefined(level._id_579A) && level._id_579A) {
    self endon("death");
  }

  level endon("game_ended");
  thread proxtriggerthink();

  for(;;) {
    waittillframeend;

    if(self.usetime && self.curprogress >= self.usetime) {
      self.curprogress = 0;
      var_0 = getearliestclaimplayer();

      if(isDefined(self.onenduse)) {
        self[[self.onenduse]](getclaimteam(), var_0, isDefined(var_0));
      }

      if(isDefined(var_0)) {
        setpickedup(var_0);
      }

      setclaimteam("none");
      self.claimplayer = undefined;
    }

    if(self.claimteam != "none") {
      if(self.usetime) {
        if(!self.numtouching[self.claimteam] || _id_5108() || common_scripts\utility::_id_562E(self._id_A414) && isDefined(self.canuseobject) && ![[self.canuseobject]](self.claimplayer)) {
          if(isDefined(self.onenduse)) {
            self[[self.onenduse]](getclaimteam(), self.claimplayer, 0);
          }

          setclaimteam("none");
          self.claimplayer = undefined;
        } else {
          self.curprogress = self.curprogress + 50 * self.userate;

          if(isDefined(self.onuseupdate)) {
            self[[self.onuseupdate]](getclaimteam(), self.curprogress / self.usetime, 50 * self.userate / self.usetime);
          }
        }
      } else {
        if(maps\mp\_utility::isreallyalive(self.claimplayer)) {
          setpickedup(self.claimplayer);
        }

        setclaimteam("none");
        self.claimplayer = undefined;
      }
    }

    waitframe();
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }
}

pickupobjectdelay(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self.canpickupobject = 0;

  for(;;) {
    if(distancesquared(self.origin, var_0) > 4096) {
      break;
    }

    wait 0.2;
  }

  self.canpickupobject = 1;
}

setpickedup(var_0) {
  if(_isai(var_0) && isDefined(var_0._id_0117)) {
    return;
  }
  if(isDefined(var_0.carryobject)) {
    if(isDefined(self.onpickupfailed)) {
      self[[self.onpickupfailed]](var_0);
    }

    return;
  }

  var_0 giveobject(self);
  setcarrier(var_0);

  for(var_1 = 0; var_1 < self.visuals.size; var_1++) {
    self.visuals[var_1] hide();
  }

  self.trigger.origin = self.trigger.origin + (0, 0, 10000);
  self notify("pickup_object");

  if(isDefined(self.onpickup)) {
    self[[self.onpickup]](var_0);
  }

  updatecompassicons();
  updateworldicons();
}

updatecarryobjectorigin(var_0) {
  if(isDefined(level._id_5677) && level._id_5677 || isDefined(level._id_579A) && level._id_579A) {
    self endon("death");
  }

  level endon("game_ended");

  if(_func_367()) {
    self endon("death");
    self endon("deleted");
  }

  for(;;) {
    if(isDefined(self.carrier)) {
      self.curorigin = self.carrier.origin + (0, 0, 75);
      self.curcarrierorigin = self.carrier.origin;
      self.objpoints["allies"] _id_04EC::updateorigin(self.curorigin);
      self.objpoints["axis"] _id_04EC::updateorigin(self.curorigin);
      var_1 = self.objpingdelay + 1.0;

      if(common_scripts\utility::_id_562E(var_0)) {
        var_2 = var_1;
      } else {
        var_2 = 0;
      }

      if((self.visibleteam == "friendly" || self.visibleteam == "any") && isfriendlyteam("allies") && self.objidpingfriendly) {
        if(self.objpoints["allies"].isshown) {
          self.objpoints["allies"].alpha = self.objpoints["allies"].basealpha;
          self.objpoints["allies"] fadeovertime(var_1);
          self.objpoints["allies"].alpha = 0;
        }

        _objective_position(self.objidallies, self.curorigin, var_2);
      } else if((self.visibleteam == "friendly" || self.visibleteam == "any") && isfriendlyteam("axis") && self.objidpingfriendly) {
        if(self.objpoints["axis"].isshown) {
          self.objpoints["axis"].alpha = self.objpoints["axis"].basealpha;
          self.objpoints["axis"] fadeovertime(var_1);
          self.objpoints["axis"].alpha = 0;
        }

        _objective_position(self.objidaxis, self.curorigin, var_2);
      }

      if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam("allies") && self.objidpingenemy) {
        if(self.objpoints["allies"].isshown) {
          self.objpoints["allies"].alpha = self.objpoints["allies"].basealpha;
          self.objpoints["allies"] fadeovertime(var_1);
          self.objpoints["allies"].alpha = 0;
        }

        _objective_position(self.objidallies, self.curorigin, var_2);
      } else if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam("axis") && self.objidpingenemy) {
        if(self.objpoints["axis"].isshown) {
          self.objpoints["axis"].alpha = self.objpoints["axis"].basealpha;
          self.objpoints["axis"] fadeovertime(var_1);
          self.objpoints["axis"].alpha = 0;
        }

        _objective_position(self.objidaxis, self.curorigin, var_2);
      }

      common_scripts\utility::wait_endon(self.objpingdelay, "dropped", "reset");
      continue;
    }

    self.curcarrierorigin = undefined;
    self.objpoints["allies"] _id_04EC::updateorigin(self.curorigin + self.offset3d);
    self.objpoints["axis"] _id_04EC::updateorigin(self.curorigin + self.offset3d);
    waitframe();
  }
}

hidecarryiconongameend() {
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  level waittill("game_ended");

  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }
}

giveobject(var_0) {
  self.carryobject = var_0;
  thread trackcarrier();

  if(common_scripts\utility::_id_562E(var_0.carrythinkbypass)) {
    self thread[[var_0.carryweaponthink]]();
  }

  if(isDefined(var_0.carryweapon)) {
    showonclient(var_0);
    var_0.carrierhascarryweaponinloadout = self hasweapon(var_0.carryweapon);

    if(isDefined(var_0.carryweaponthink)) {
      self thread[[var_0.carryweaponthink]]();
    }

    maps\mp\_utility::_giveweapon(var_0.carryweapon);
    self switchtoweapon(var_0.carryweapon);
    self disableweaponpickup();
    common_scripts\utility::_id_0603();
  } else if(!var_0._id_0C33) {
    common_scripts\utility::_id_0602();

    if(isDefined(var_0.manualdropthink)) {
      self thread[[var_0.manualdropthink]]();
    } else {
      thread manualdropthink();
    }
  }

  if(isDefined(var_0.carryicon) && isPlayer(self)) {
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
}

returnhome() {
  self.isresetting = 1;
  self notify("reset");

  for(var_0 = 0; var_0 < self.visuals.size; var_0++) {
    self.visuals[var_0].origin = self.visuals[var_0].baseorigin;
    self.visuals[var_0].angles = self.visuals[var_0].baseangles;
    self.visuals[var_0] show();
  }

  self.trigger.origin = self.trigger.baseorigin;
  self.curorigin = self.trigger.origin;

  if(isDefined(self.onreset)) {
    self[[self.onreset]]();
  }

  clearcarrier();
  updateworldicons();
  updatecompassicons();
  self.isresetting = 0;
}

ishome() {
  if(isDefined(self.carrier)) {
    return 0;
  }

  if(self.curorigin != self.trigger.baseorigin) {
    return 0;
  }

  return 1;
}

setposition(var_0, var_1) {
  self.isresetting = 1;

  for(var_2 = 0; var_2 < self.visuals.size; var_2++) {
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
  if(isDefined(self.carryobject)) {
    self.carryobject thread setdropped();
  }
}

carryobject_overridemovingplatformdeath(var_0) {
  for(var_1 = 0; var_1 < var_0.carryobject.visuals.size; var_1++) {
    var_0.carryobject.visuals[var_1] unlink();
  }

  var_0.carryobject.trigger unlink();
  var_0.carryobject notify("stop_pickup_timeout");
  var_0.carryobject returnhome();
}

setdropped(var_0) {
  if(level.gametype == "sd") {
    waitframe();
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(isDefined(self.setdropped)) {
    if([[self.setdropped]]()) {
      return;
    }
  }

  self.isresetting = 1;
  self notify("dropped");

  if(isDefined(self.carrier) && self.carrier.team != "spectator") {
    if(isDefined(self.carrier.body)) {
      var_1 = _playerphysicstrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000), self.carrier.body);
      var_2 = bulletTrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000), 0, self.carrier.body);
    } else {
      var_1 = _playerphysicstrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000));
      var_2 = bulletTrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000), 0);
    }
  } else {
    var_1 = _playerphysicstrace(self.detachall + (0, 0, 20), self.detachall - (0, 0, 20));
    var_2 = bulletTrace(self.detachall + (0, 0, 20), self.detachall - (0, 0, 20), 0, undefined);
  }

  var_3 = self.carrier;

  if(isDefined(var_1)) {
    var_4 = _randomfloat(360);
    var_5 = var_1;

    if(isDefined(self.visualgroundoffset)) {
      var_5 = var_5 + self.visualgroundoffset;
    }

    if(var_2["fraction"] < 1 && distance(var_2["position"], var_1) < 10.0) {
      var_6 = (_cos(var_4), _sin(var_4), 0);
      var_6 = vectorNormalize(var_6 - var_2["normal"] * vectordot(var_6, var_2["normal"]));
      var_7 = vectortoangles(var_6);
    } else
      var_7 = (0, var_4, 0);

    for(var_8 = 0; var_8 < self.visuals.size; var_8++) {
      self.visuals[var_8].origin = var_5;
      self.visuals[var_8].angles = var_7;

      if(var_0 <= 0) {
        self.visuals[var_8] show();
        continue;
      }

      self.visuals[var_8] thread common_scripts\utility::_id_2CB7(var_0);
    }

    self.trigger.origin = var_5;
    self.curorigin = self.trigger.origin;
    var_9 = spawnStruct();
    var_9.carryobject = self;
    var_9.deathoverridecallback = ::carryobject_overridemovingplatformdeath;
    self.trigger thread _id_0488::handle_moving_platforms(var_9);
    thread pickuptimeout();
  }

  if(!isDefined(var_1)) {
    for(var_8 = 0; var_8 < self.visuals.size; var_8++) {
      self.visuals[var_8].origin = self.visuals[var_8].baseorigin;
      self.visuals[var_8].angles = self.visuals[var_8].baseangles;

      if(var_0 <= 0) {
        self.visuals[var_8] show();
        continue;
      }

      self.visuals[var_8] thread common_scripts\utility::_id_2CB7(var_0);
    }

    self.trigger.origin = self.trigger.baseorigin;
    self.curorigin = self.trigger.baseorigin;
  }

  if(isDefined(self._id_6AEF)) {
    self[[self._id_6AEF]](var_3);
  }

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
  if(!isDefined(self.carrier)) {
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
  waitframe();

  if(istouchingbadtrigger()) {
    returnhome();
    return;
  }

  if(isDefined(self.autoresettime)) {
    wait(self.autoresettime);

    if(!isDefined(self.carrier)) {
      returnhome();
    }
  }
}

istouchingbadtrigger() {
  var_0 = getEntArray("out_of_bounds", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!self.visuals[0] istouching(var_0[var_1])) {
      continue;
    }
    return 1;
  }

  if(!self.visuals[0] physicsisactive()) {
    var_0 = getEntArray("out_of_bounds_at_rest", "targetname");

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(!self.visuals[0] istouching(var_0[var_1])) {
        continue;
      }
      return 1;
    }
  }

  var_2 = getEntArray("trigger_hurt", "classname");

  for(var_1 = 0; var_1 < var_2.size; var_1++) {
    if(!self.visuals[0] istouching(var_2[var_1])) {
      continue;
    }
    return 1;
  }

  if(self.waterbadtrigger) {
    var_3 = getEntArray("trigger_underwater", "targetname");

    for(var_1 = 0; var_1 < var_3.size; var_1++) {
      if(!self.visuals[0] istouching(var_3[var_1])) {
        continue;
      }
      return 1;
    }
  }

  return 0;
}

_id_466F(var_0) {
  var_1 = issubstr(var_0, "zk383");

  if(isDefined(self.pers["altModeActive"]) && isDefined(self._id_0079) && self.pers["altModeActive"] && self._id_0079 != 5 && maps\mp\_utility::getweaponclass(var_0) == "weapon_smg" && issubstr(var_0, "suppressor") && !var_1) {
    var_2 = _id_04CA::_id_461C(1);

    if(var_2 == "suppressor_level1" || var_2 == "suppressor_level2" || var_2 == "suppressor_level3") {
      var_0 = "alt+" + var_0;
    }
  } else if(var_1 && common_scripts\utility::_id_562E(self.pers["altModeActive"]))
    var_0 = "alt+" + var_0;
  else if(isDefined(self.pers["dragonBreathActive"]) && self.pers["dragonBreathActive"] && isDefined(self._id_0079) && self._id_0079 != 5 && maps\mp\_utility::getweaponclass(var_0) == "weapon_shotgun" && issubstr(var_0, "dragon_breath")) {
    var_0 = "alt+" + var_0;
  } else if(isDefined(self.pers["rifleGrenadeActive"]) && self.pers["rifleGrenadeActive"] && isDefined(self._id_0079) && self._id_0079 != 5 && maps\mp\_utility::getweaponclass(var_0) == "weapon_assault" && issubstr(var_0, "grenade_launcher")) {
    var_0 = "alt+" + var_0;
  }

  return var_0;
}

showonclient(var_0) {
  if(self same_color_code_as_last_time() && isDefined(self.carryweapon) && self hasweapon(self.carryweapon)) {
    var_1 = self.carryweapon;
  } else {
    var_1 = _id_466F(self getcurrentprimaryweapon());
  }

  var_0.carrierweaponcurrent = var_1;
}

_id_466D(var_0) {
  if(isDefined(var_0.carrierweaponcurrent) && self hasweapon(var_0.carrierweaponcurrent)) {
    return var_0.carrierweaponcurrent;
  }

  var_1 = self getweaponlistprimaries();
  return var_1[0];
}

takeobject(var_0) {
  if(isDefined(self.carryicon)) {
    self.carryicon maps\mp\gametypes\_hud_util::destroyelem();
  }

  if(isDefined(self)) {
    self.carryobject = undefined;
  }

  self notify("drop_object");

  if(var_0.triggertype == "proximity") {
    thread pickupobjectdelay(var_0.trigger.origin);
  }

  if(maps\mp\_utility::isreallyalive(self)) {
    if(isDefined(var_0.carryweapon)) {
      var_1 = common_scripts\utility::_id_562E(var_0._id_59D8);

      if(!var_1 && isDefined(var_0.keepcarryweapon)) {
        var_1 = var_0[[var_0.keepcarryweapon]](self);
      }

      if(!var_0.carrierhascarryweaponinloadout && !var_1) {
        self takeweapon(var_0.carryweapon);
      }

      var_2 = !common_scripts\utility::_id_562E(var_0._id_0C2C) || !self isswitchingweapon();

      if(var_2) {
        var_3 = _id_466D(var_0);
        self switchtoweapon(var_3);
      }

      self enableweaponpickup();
      common_scripts\utility::_id_0617();
    } else if(!var_0._id_0C33)
      common_scripts\utility::_id_0616();
  }
}

trackcarrier() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  while(isDefined(self.carryobject) && maps\mp\_utility::isreallyalive(self)) {
    if(self isonground()) {
      var_0 = bulletTrace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);

      if(var_0["fraction"] < 1) {
        self.carryobject.detachall = var_0["position"];
      }
    }

    waitframe();
  }
}

manualdropthink() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  for(;;) {
    while(self attackButtonPressed() || self fragButtonPressed() || self secondaryoffhandbuttonPressed() || self meleeButtonPressed()) {
      waitframe();
    }

    while(!self attackButtonPressed() && !self fragButtonPressed() && !self secondaryoffhandbuttonPressed() && !self meleeButtonPressed()) {
      waitframe();
    }

    if(isDefined(self.carryobject) && !self useButtonPressed()) {
      self.carryobject thread setdropped();
    }
  }
}

deleteuseobjectobjectives() {
  if(isDefined(self.objidallies)) {
    maps\mp\_utility::_objective_delete(self.objidallies);
    self.objidallies = undefined;
  }

  if(isDefined(self.objidaxis)) {
    maps\mp\_utility::_objective_delete(self.objidaxis);
    self.objidaxis = undefined;
  }

  if(isDefined(self.objidmlgspectator)) {
    maps\mp\_utility::_objective_delete(self.objidmlgspectator);
    self.objidmlgspectator = undefined;
  }
}

deleteuseobject() {
  deleteuseobjectobjectives();

  if(isDefined(self.objpoints)) {
    _id_04EC::deleteobjpoint(self.objpoints["allies"]);
    _id_04EC::deleteobjpoint(self.objpoints["axis"]);
    _id_04EC::deleteobjpoint(self.objpoints["broadcaster"]);
  }

  self.trigger = undefined;
  self notify("deleted");
}

createuseobject(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.type = "useObject";
  var_6.curorigin = var_1.origin;
  var_6.ownerteam = var_0;
  var_6.entnum = var_1 getentitynumber();
  var_6.keyobject = undefined;

  if(issubstr(var_1.classname, "use")) {
    var_6.triggertype = "use";
  } else {
    var_6.triggertype = "proximity";
  }

  var_6.trigger = var_1;

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    var_2[var_7].baseorigin = var_2[var_7].origin;
    var_2[var_7].baseangles = var_2[var_7].angles;
  }

  var_6.visuals = var_2;

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_6.offset3d = var_3;

  if(!isDefined(var_4) || !var_4) {
    var_6.compassicons = [];
    var_6.objidallies = _id_45A9();
    var_6.objidaxis = _id_45A9();
    var_6.objidmlgspectator = _id_45A9();
    _objective_add(var_6.objidallies, "invisible", var_6.curorigin);
    _objective_add(var_6.objidaxis, "invisible", var_6.curorigin);
    _objective_add(var_6.objidmlgspectator, "invisible", var_6.curorigin);
    _objective_team(var_6.objidallies, "allies");
    _objective_team(var_6.objidaxis, "axis");
    _objective_mlgspectator(var_6.objidmlgspectator);

    if(!isDefined(var_5) || !var_5) {
      var_6.objpoints["allies"] = _id_04EC::createteamobjpoint("objpoint_allies_" + var_6.entnum, var_6.curorigin + var_3, "allies", undefined);
      var_6.objpoints["axis"] = _id_04EC::createteamobjpoint("objpoint_axis_" + var_6.entnum, var_6.curorigin + var_3, "axis", undefined);
      var_6.objpoints["broadcaster"] = _id_04EC::createteamobjpoint("objpoint_broadcaster_" + var_6.entnum, var_6.curorigin + var_3, "broadcaster", undefined);
      var_6.objpoints["broadcaster"].archived = 0;
      var_6.objpoints["allies"].alpha = 0;
      var_6.objpoints["axis"].alpha = 0;
      var_6.objpoints["broadcaster"].alpha = 0;
    }
  }

  var_6.interactteam = "none";
  var_6.keepprogress = 0;
  var_6.worldicons = [];
  var_6._id_AA89 = [];
  var_6._id_356E = undefined;
  var_6.visibleteam = "none";
  var_6.onuse = undefined;
  var_6.oncantuse = undefined;
  var_6.usetext = "default";
  var_6.usetime = 10000;
  var_6.curprogress = 0;

  if(var_6.triggertype == "proximity") {
    var_6.teamusetimes = [];
    var_6.teamusetexts = [];
    var_6.numtouching["neutral"] = 0;
    var_6.numtouching["axis"] = 0;
    var_6.numtouching["allies"] = 0;
    var_6.numtouching["none"] = 0;
    var_6.touchlist["neutral"] = [];
    var_6.touchlist["axis"] = [];
    var_6.touchlist["allies"] = [];
    var_6.touchlist["none"] = [];
    var_6.userate = 0;
    var_6.claimteam = "none";
    var_6.claimplayer = undefined;
    var_6._id_5B81 = undefined;
    var_6.lastclaimteam = "none";
    var_6.lastclaimtime = 0;
    var_6.mustmaintainclaim = 0;
    var_6.cancontestclaim = 0;
    var_6._id_5107 = 0;
    var_6._id_A414 = 0;

    if(level.multiteambased) {
      foreach(var_9 in level.teamnamelist) {
        var_6.numtouching[var_9] = 0;
        var_6.touchlist[var_9] = [];
      }
    }

    var_6 thread useobjectproxthink();
  } else {
    var_6._id_5F95 = 0;
    var_6.userate = 1;
    var_6._id_A23C = 1;
    var_6 thread useobjectusethink();
  }

  return var_6;
}

move_use_object(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(isDefined(self.trigger)) {
    self.trigger dontinterpolate();
    self.trigger.origin = var_0;
  }

  if(isDefined(self.trigger.baseorigin)) {
    self.trigger.baseorigin = var_0;
  }

  if(isDefined(self.levelflag)) {
    self.levelflag dontinterpolate();
    self.levelflag.origin = var_0;
  }

  if(isDefined(self.visuals)) {
    foreach(var_3 in self.visuals) {
      var_3 dontinterpolate();
      var_3.origin = var_0;
      var_3.baseorigin = var_0;
    }
  }

  if(isDefined(self.origin)) {
    self.origin = var_0;
  }

  if(isDefined(self.curorigin)) {
    self.curorigin = var_0;
  }

  if(isDefined(self.goal)) {
    if(isDefined(self.goal.laseron)) {
      foreach(var_6 in self.goal.laseron) {
        var_6.origin = var_0;
      }
    }

    if(isDefined(self.goal.origin)) {
      self.goal.origin = var_0;
    }
  }

  if(isDefined(self.objpoints)) {
    foreach(var_9 in self.objpoints) {
      var_9 _id_04EC::updateorigin(var_0 + var_1);
    }
  }

  if(isDefined(self.objidallies)) {
    _objective_position(self.objidallies, var_0);
  }

  if(isDefined(self.objidaxis)) {
    _objective_position(self.objidaxis, var_0);
  }

  if(isDefined(self.objidmlgspectator)) {
    _objective_position(self.objidmlgspectator, var_0);
  }

  if(isDefined(self.baseeffect)) {
    self.baseeffect delete();
    var_11 = self.visuals[0].origin + (0, 0, 32);
    var_12 = self.visuals[0].origin + (0, 0, -32);
    var_13 = bulletTrace(var_11, var_12, 0, undefined);
    var_14 = vectortoangles(var_13["normal"]);
    self.baseeffectforward = anglesToForward(var_14);
    self.baseeffectright = anglestoright(var_14);
    self.baseeffectpos = var_13["position"];

    if(level.gametype == "dom") {
      maps\mp\gametypes\dom::updatevisuals();
    }
  }
}

setkeyobject(var_0) {
  self.keyobject = var_0;
}

_id_2956() {
  var_0 = self getcurrentprimaryweapon();

  if(maps\mp\_utility::iskillstreakweapon(var_0) && !issubstr(var_0, "turrethead") && var_0 != "flamethrower_mp" && var_0 != "flamethrower_german_mp" && var_0 != "flamethrower_grenadier_mp" && var_0 != "flamethrower_german_grenadier_mp" && var_0 != "killstreak_molotov_cocktail_mp" && var_0 != "killstreak_molotov_cocktail_grenadier_mp" && var_0 != "teslagun_war_moon_mp") {
    return 1;
  }

  return 0;
}

useobjectusethink() {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
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
    if(var_0 _id_2956()) {
      continue;
    }
    if(!checkkeyobject(var_0)) {
      if(isDefined(self.oncantuse)) {
        self[[self.oncantuse]](var_0);
      }

      continue;
    }

    if(isDefined(self.canuseobject) && ![[self.canuseobject]](var_0)) {
      continue;
    }
    if(!var_0 common_scripts\utility::isweaponenabled()) {
      continue;
    }
    var_1 = 1;
    var_2 = self.usetime;

    if(isDefined(self._id_6E79)) {
      var_2 = self._id_6E79.usetime;
    }

    if(var_2 > 0) {
      if(isDefined(self.onbeginuse)) {
        self[[self.onbeginuse]](var_0);
      }

      if(isDefined(self._id_6E79) && isDefined(self._id_6E79.onbeginuse)) {
        self._id_6E79[[self._id_6E79.onbeginuse]](var_0);
      }

      if(!isDefined(self.keyobject)) {
        thread cantusehintthink();
      }

      var_3 = var_0.pers["team"];
      var_1 = useholdthink(var_0);
      self notify("finished_use");

      if(isDefined(self.onenduse)) {
        self[[self.onenduse]](var_3, var_0, var_1);
      }

      if(isDefined(self._id_6E79) && isDefined(self._id_6E79.onenduse)) {
        self._id_6E79[[self._id_6E79.onenduse]](var_3, var_0, var_1);
      }
    }

    if(!var_1) {
      continue;
    }
    if(isDefined(self.onuse)) {
      self[[self.onuse]](var_0);
    }

    if(isDefined(self._id_6E79) && isDefined(self._id_6E79.onuse)) {
      self._id_6E79[[self._id_6E79.onuse]](var_0);
    }
  }
}

checkkeyobject(var_0) {
  if(!isDefined(self.keyobject)) {
    return 1;
  }

  if(!isDefined(var_0.carryobject)) {
    return 0;
  }

  var_1 = self.keyobject;

  if(!_isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_3 in var_1) {
    if(var_3 == var_0.carryobject) {
      return 1;
    }
  }

  return 0;
}

cantusehintthink() {
  level endon("game_ended");
  self endon("deleted");
  self endon("finished_use");

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(!maps\mp\_utility::isreallyalive(var_0)) {
      continue;
    }
    if(!caninteractwith(var_0.pers["team"])) {
      continue;
    }
    if(isDefined(self.oncantuse)) {
      self[[self.oncantuse]](var_0);
    }
  }
}

getearliestclaimplayer() {
  var_0 = self.claimteam;

  if(maps\mp\_utility::isreallyalive(self.claimplayer)) {
    var_1 = self.claimplayer;
  } else {
    var_1 = undefined;
  }

  if(self.touchlist[var_0].size > 0) {
    var_2 = undefined;
    var_3 = getarraykeys(self.touchlist[var_0]);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = self.touchlist[var_0][var_3[var_4]];

      if(maps\mp\_utility::isreallyalive(var_5.player) && (!isDefined(var_2) || var_5.starttime < var_2)) {
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

  for(;;) {
    if(self.usetime && self.curprogress >= self.usetime) {
      if(!self.keepprogress) {
        self.curprogress = 0;
      }

      if(self._id_5107 || common_scripts\utility::_id_562E(self.cancapwithoutclaim)) {
        var_0 = self.claimplayer;
      } else {
        var_0 = getearliestclaimplayer();
      }

      if(isDefined(self.onenduse)) {
        self[[self.onenduse]](getclaimteam(), var_0, isDefined(var_0));
      }

      if(isDefined(var_0) && isDefined(self.onuse)) {
        self[[self.onuse]](var_0);
      }

      if(!self.mustmaintainclaim) {
        setclaimteam("none");
        self.claimplayer = undefined;
      }
    }

    if(self.claimteam != "none") {
      if(self.usetime && (!self.mustmaintainclaim || getownerteam() != getclaimteam())) {
        if(!self.numtouching[self.claimteam] || _id_5108() || common_scripts\utility::_id_562E(self._id_A414) && isDefined(self.canuseobject) && ![[self.canuseobject]](self.claimplayer)) {
          if(isDefined(self.onenduse)) {
            self[[self.onenduse]](getclaimteam(), self.claimplayer, 0);
          }

          setclaimteam("none");

          if(!common_scripts\utility::_id_562E(self.cancapwithoutclaim)) {
            self.claimplayer = undefined;
          }
        } else {
          self.curprogress = self.curprogress + 50 * self.userate;

          if(self.curprogress <= 0) {
            self.curprogress = self.curprogress * -1;
            self.lastclaimteam = self.claimteam;
            updateuserate();
          }

          if(isDefined(self.onuseupdate)) {
            self[[self.onuseupdate]](getclaimteam(), self.curprogress / self.usetime, 50 * self.userate / self.usetime);
          }
        }
      } else if(!self.mustmaintainclaim) {
        if(isDefined(self.onuse)) {
          self[[self.onuse]](self.claimplayer);
        }

        if(!self.mustmaintainclaim) {
          setclaimteam("none");

          if(!common_scripts\utility::_id_562E(self.cancapwithoutclaim)) {
            self.claimplayer = undefined;
          }
        }
      } else if(!self.numtouching[self.claimteam]) {
        if(isDefined(self.onunoccupied)) {
          self[[self.onunoccupied]]();
        }

        setclaimteam("none");

        if(!common_scripts\utility::_id_562E(self.cancapwithoutclaim)) {
          self.claimplayer = undefined;
        }
      } else if(self.cancontestclaim) {
        var_1 = getnumtouchingexceptteam(self.claimteam);

        if(var_1 > 0) {
          if(isDefined(self.oncontested)) {
            self[[self.oncontested]]();
          }

          setclaimteam("none");

          if(!common_scripts\utility::_id_562E(self.cancapwithoutclaim)) {
            self.claimplayer = undefined;
          }
        }
      }
    } else if(self.mustmaintainclaim && getownerteam() != "none") {
      if(!self.numtouching[getownerteam()]) {
        if(isDefined(self.onunoccupied)) {
          self[[self.onunoccupied]]();
        }
      } else if(self.cancontestclaim && self.lastclaimteam != "none" && self.numtouching[self.lastclaimteam]) {
        var_1 = getnumtouchingexceptteam(self.lastclaimteam);

        if(var_1 == 0) {
          if(isDefined(self.onuncontested)) {
            self[[self.onuncontested]](self.lastclaimteam);
          }
        }
      }
    }

    waitframe();
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }
}

canclaim(var_0) {
  if(isDefined(self.carrier)) {
    return 0;
  }

  if(self._id_5107 && !_id_5108()) {
    return 0;
  }

  if(self.cancontestclaim) {
    var_1 = getnumtouchingexceptteam(var_0.pers["team"]);

    if(var_1 != 0) {
      return 0;
    }
  }

  if(checkkeyobject(var_0)) {
    return 1;
  }

  return 0;
}

proxtriggerthink() {
  level endon("game_ended");
  self endon("deleted");
  var_0 = self.entnum;

  for(;;) {
    if(!isDefined(self) | !isDefined(self.trigger)) {
      return;
    }
    self.trigger waittill("trigger", var_1);

    if(!maps\mp\_utility::isreallyalive(var_1)) {
      continue;
    }
    if(!maps\mp\_utility::isgameparticipant(var_1)) {
      continue;
    }
    if(!self.trigger _meth_8691(var_1)) {
      continue;
    }
    if(isDefined(self.carrier)) {
      continue;
    }
    if(var_1 maps\mp\_utility::isusingremote() || isDefined(var_1.spawningafterremotedeath) || var_1 maps\mp\_utility::isinremotetransition()) {
      continue;
    }
    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }
    if(!isDefined(var_1.initialized_gameobject_vars)) {
      continue;
    }
    if(isDefined(self.nextusetime) && self.nextusetime > gettime()) {
      continue;
    }
    if(isDefined(self.canuseobject) && ![[self.canuseobject]](var_1)) {
      continue;
    }
    if(caninteractwith(var_1.pers["team"], var_1) && self.claimteam == "none") {
      if(canclaim(var_1)) {
        if(common_scripts\utility::_id_562E(self.requireslos)) {
          if(isDefined(self._id_1F6A)) {
            var_2 = self[[self._id_1F6A]](var_1, self.visuals);
          } else {
            var_2 = proxtriggerlos(var_1, self.visuals);
          }

          if(!var_2) {
            continue;
          }
        }

        if(common_scripts\utility::_id_562E(self.requirescontinuouslos) && isDefined(self._id_1F6A) && !self[[self._id_1F6A]](var_1, self.visuals)) {
          continue;
        }
        if(self._id_5107 && (!isDefined(self._id_5B81) || var_1 != self._id_5B81)) {
          self.curprogress = 0;
        }

        setclaimteam(var_1.pers["team"]);
        self.claimplayer = var_1;

        if(self._id_5107) {
          self._id_5B81 = var_1;
        }

        var_3 = getrelativeteam(var_1.pers["team"]);

        if(isDefined(self.teamusetimes[var_3])) {
          self.usetime = self.teamusetimes[var_3];
        }

        if(self.usetime && isDefined(self.onbeginuse)) {
          self[[self.onbeginuse]](self.claimplayer);
        }
      } else if(isDefined(self.oncantuse))
        self[[self.oncantuse]](var_1);
    }

    if(maps\mp\_utility::isreallyalive(var_1) && !isDefined(var_1.touchtriggers[var_0])) {
      var_1 thread triggertouchthink(self);
    }
  }
}

proxtriggerlos(var_0, var_1) {
  var_2 = [32, 16, 0];
  var_3 = undefined;

  if(isDefined(var_1) && var_1.size) {
    if(var_1.size > 1 && !issubstr(level.gametype, "ctf")) {}

    var_3 = var_1[0];
  }

  var_4 = var_0.origin - self.trigger.origin;
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = vectorNormalize(var_4);
  var_4 = var_4 * 5;

  foreach(var_6 in var_2) {
    var_7 = var_0 getEye();
    var_8 = self.trigger.origin + var_4 + (0, 0, var_6);
    var_9 = bulletTrace(var_7, var_8, 0, var_3, 0, 0, 0, 0, 1, 0, 0);

    if(var_9["fraction"] == 1) {
      return 1;
    }
  }

  return 0;
}

setclaimteam(var_0) {
  if(!common_scripts\utility::_id_562E(self.cancapwithoutclaim)) {}

  if(self.keepprogress) {
    if(self.lastclaimteam == "none") {
      self.lastclaimteam = var_0;
    }

    self.claimteam = var_0;
  } else {
    if(self.claimteam == "none" && gettime() - self.lastclaimtime > 1000) {
      self.curprogress = 0;
    } else if(var_0 != "none" && var_0 != self.lastclaimteam) {
      self.curprogress = 0;
    }

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
  var_0 endon("death");
  var_1 = self.pers["team"];
  var_0.numtouching[var_1]++;
  var_2 = self.guid;
  var_3 = spawnStruct();
  var_3.player = self;
  var_3.starttime = gettime();
  var_0.touchlist[var_1][var_2] = var_3;

  if(isDefined(var_0._id_6BB8)) {
    var_0[[var_0._id_6BB8]](self);
  }

  if(!isDefined(var_0.nousebar)) {
    var_0.nousebar = 0;
  }

  self.touchtriggers[var_0.entnum] = var_0.trigger;

  if(isDefined(level._id_3FCF)) {
    self[[level._id_3FCF]](var_0);
  }

  var_0 updateuserate();

  while(maps\mp\_utility::isreallyalive(self) && isDefined(var_0.trigger) && self istouching(var_0.trigger) && !level.gameended) {
    if(common_scripts\utility::_id_562E(var_0.requirescontinuouslos) && isDefined(var_0._id_1F6A) && !var_0[[var_0._id_1F6A]](self, var_0.visuals)) {
      break;
    }

    if(isPlayer(self) && var_0.usetime) {
      updateuiprogress(var_0, 1);

      if(isDefined(level._id_3FCE)) {
        self[[level._id_3FCE]](var_0, 0);
      } else {
        updateproxbar(var_0, 0);
      }
    }

    waitframe();
  }

  if(isDefined(self) && isDefined(self.touchtriggers)) {
    if(isPlayer(self) && var_0.usetime) {
      updateuiprogress(var_0, 0);

      if(isDefined(level._id_3FCE)) {
        self[[level._id_3FCE]](var_0, 1);
      } else {
        updateproxbar(var_0, 1);
      }
    }

    self.touchtriggers[var_0.entnum] = undefined;

    if(isDefined(var_0._id_6BB9)) {
      var_0[[var_0._id_6BB9]](self);
    }
  }

  if(level.gameended) {
    return;
  }
  var_0.touchlist[var_1][var_2] = undefined;
  var_0.numtouching[var_1]--;
  var_0 updateuserate();

  if(isDefined(level._id_3FD0)) {
    self[[level._id_3FD0]](var_0);
  }
}

updateproxbar(var_0, var_1) {
  var_2 = self.pers["team"];

  if(var_1 || !var_0 caninteractwith(var_2) || var_2 != var_0.claimteam || var_0.nousebar) {
    if(isDefined(self.proxbar)) {
      self.proxbar maps\mp\gametypes\_hud_util::hideelem();
    }

    if(isDefined(self.proxbartext)) {
      self.proxbartext maps\mp\gametypes\_hud_util::hideelem();
    }

    return;
  }

  if(!isDefined(self.proxbar)) {
    self.proxbar = maps\mp\gametypes\_hud_util::_id_2821();
    self.proxbar.lastuserate = undefined;
    self.proxbar.lasthostmigrationstate = 0;
  }

  if(self.proxbar.hidden) {
    self.proxbar maps\mp\gametypes\_hud_util::showelem();
    self.proxbar.lastuserate = undefined;
    self.proxbar.lasthostmigrationstate = 0;
  }

  if(!isDefined(self.proxbartext)) {
    self.proxbartext = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
    var_3 = var_0 getrelativeteam(var_2);

    if(isDefined(var_0.teamusetexts[var_3])) {
      self.proxbartext settext(var_0.teamusetexts[var_3]);
    } else {
      self.proxbartext settext(var_0.usetext);
    }
  }

  if(self.proxbartext.hidden) {
    self.proxbartext maps\mp\gametypes\_hud_util::showelem();
    var_3 = var_0 getrelativeteam(var_2);

    if(isDefined(var_0.teamusetexts[var_3])) {
      self.proxbartext settext(var_0.teamusetexts[var_3]);
    } else {
      self.proxbartext settext(var_0.usetext);
    }
  }

  if(!isDefined(self.proxbar.lastuserate) || self.proxbar.lastuserate != var_0.userate || self.proxbar.lasthostmigrationstate != isDefined(level.hostmigrationtimer)) {
    if(var_0.curprogress > var_0.usetime) {
      var_0.curprogress = var_0.usetime;
    }

    var_4 = var_0.curprogress / var_0.usetime;
    var_5 = 1000 / var_0.usetime * var_0.userate;

    if(isDefined(level.hostmigrationtimer)) {
      var_5 = 0;
    }

    if(var_0.keepprogress && !var_4 && var_5 < 0) {
      var_5 = 0;
    }

    self.proxbar maps\mp\gametypes\_hud_util::updatebar(var_4, var_5);
    self.proxbar.lastuserate = var_0.userate;
    self.proxbar.lasthostmigrationstate = isDefined(level.hostmigrationtimer);
  }
}

getnumtouchingexceptteam(var_0) {
  return self.numtouching[maps\mp\_utility::getotherteam(var_0)];
}

updateuiprogress(var_0, var_1) {
  var_2 = level.gametype;
  var_3 = var_0.id;

  if(!isDefined(level.hostmigrationtimer)) {
    if(var_0.curprogress > var_0.usetime) {
      var_0.curprogress = var_0.usetime;
    }

    var_4 = var_0.curprogress / var_0.usetime;

    if((var_2 == "dom" || var_2 == "assault" || var_2 == "control") && isDefined(var_3) && var_3 == "domFlag") {
      if(!var_1 || var_0.ownerteam == self.team || var_0.claimteam != self.team) {
        var_4 = 0.01;
      }

      if(var_4 != 0) {
        self setclientomnvar("ui_capture_progress", var_4);
      }
    }

    var_5 = var_2 == "sd";

    if((var_5 || var_2 == "assault" || var_2 == "control" || var_2 == "sr" || var_2 == "demo") && isDefined(var_3) && (var_3 == "bombZone" || var_3 == "defuseObject")) {
      if(!var_1) {
        var_4 = 0;
      }

      var_4 = max(0.01, var_4);

      if(var_4 != 0) {
        self setclientomnvar("ui_capture_progress", var_4);
      }

      if(var_5) {
        self setclientomnvar("ui_capture_progress_global", var_4);
      }
    }

    if(isDefined(var_3) && (var_2 == "twar" && var_3 == "twarZone")) {
      if(!var_1) {
        var_4 = 0;
      }

      var_4 = max(0.01, var_4);

      if(var_4 != 0) {
        self setclientomnvar("ui_capture_progress", var_4);
      }
    }

    if(isDefined(var_3) && var_2 == "raid") {
      if(var_3 == "raidZoneCaptureHP" || var_3 == "raidZoneCaptureDom" || var_3 == "raidZoneCaptureTwar" || var_3 == "raidConstruct" || var_3 == "raidRepair" || var_3 == "raidPlantExplosive" || var_3 == "raidDefuseExplosive") {
        if(!var_1) {
          var_4 = 0;
        }

        var_4 = max(0.01, var_4);

        if(var_4 != 0) {
          self setclientomnvar("ui_capture_progress", var_4);
        }
      }
    }

    if(var_2 == "zombies" && isDefined(var_3) && var_3 == "defuseObject") {
      if(!var_1) {
        var_4 = 0;
      }

      var_4 = max(0.01, var_4);

      if(var_4 != 0) {
        self setclientomnvar("ui_capture_progress", var_4);
      }
    }
  }

  if((var_2 == "dom" || var_2 == "assault" || var_2 == "control") && isDefined(var_3) && var_3 == "domFlag") {
    if(var_1 && isDefined(var_0.stalemate) && var_0.stalemate) {
      if(var_0.label == "_a") {
        self setclientomnvar("ui_capture_icon", 4);
      } else if(var_0.label == "_b") {
        self setclientomnvar("ui_capture_icon", 5);
      } else if(var_0.label == "_c") {
        self setclientomnvar("ui_capture_icon", 6);
      }

      self setclientomnvar("ui_capture_status_index", 2);
    } else if(var_1 && var_0.ownerteam == "neutral") {
      if(var_0.label == "_a") {
        self setclientomnvar("ui_capture_icon", 7);
      } else if(var_0.label == "_b") {
        self setclientomnvar("ui_capture_icon", 8);
      } else if(var_0.label == "_c") {
        self setclientomnvar("ui_capture_icon", 9);
      }

      self setclientomnvar("ui_capture_status_index", 1);
    } else if(var_1 && var_0.ownerteam != self.team) {
      if(var_0.label == "_a") {
        self setclientomnvar("ui_capture_icon", 1);
      } else if(var_0.label == "_b") {
        self setclientomnvar("ui_capture_icon", 2);
      } else if(var_0.label == "_c") {
        self setclientomnvar("ui_capture_icon", 3);
      }

      self setclientomnvar("ui_capture_status_index", 1);
    } else {
      self setclientomnvar("ui_capture_icon", 0);
      self setclientomnvar("ui_capture_status_index", 0);
    }
  }

  if((var_2 == "sd" || var_2 == "sr" || var_2 == "demo") && isDefined(var_3) && (var_3 == "bombZone" || var_3 == "defuseObject")) {
    if(!var_1) {
      self setclientomnvar("ui_capture_icon", 0);
    } else if(var_0 isfriendlyteam(self.pers["team"])) {
      self setclientomnvar("ui_capture_icon", 2);
    } else {
      self setclientomnvar("ui_capture_icon", 1);
    }
  }

  if(isDefined(var_3) && (var_2 == "twar" && var_3 == "twarZone")) {
    if(!var_1 || isDefined(var_0.stalemate) && var_0.stalemate) {
      self setclientomnvar("ui_capture_icon", 0);
    } else {
      self setclientomnvar("ui_capture_icon", 1);
    }
  }

  if(var_2 == "raid" && isDefined(var_3)) {
    if(var_1) {
      if(var_3 == "raidZoneCaptureHP") {
        if(common_scripts\utility::_id_562E(var_0._id_4D04)) {
          self setclientomnvar("ui_capture_icon", 0);
          self setclientomnvar("ui_capture_status_index", 0);
        } else if(common_scripts\utility::_id_562E(var_0.stalemate)) {
          self setclientomnvar("ui_capture_status_index", 2);
          self setclientomnvar("ui_capture_icon", 2);
        } else if(var_0 caninteractwith(self.pers["team"]) && self.pers["team"] == var_0.claimteam) {
          self setclientomnvar("ui_capture_status_index", 1);
          self setclientomnvar("ui_capture_icon", 1);
        } else {
          self setclientomnvar("ui_capture_icon", 0);
          self setclientomnvar("ui_capture_status_index", 0);
        }
      } else if(var_3 == "raidZoneCaptureDom") {
        if(common_scripts\utility::_id_562E(var_0.stalemate)) {
          self setclientomnvar("ui_capture_status_index", 2);
          self setclientomnvar("ui_capture_icon", 2);
        } else if(var_0.ownerteam == "neutral" || var_0.ownerteam != self.team) {
          self setclientomnvar("ui_capture_status_index", 1);
          self setclientomnvar("ui_capture_icon", 1);
        } else {
          self setclientomnvar("ui_capture_icon", 0);
          self setclientomnvar("ui_capture_status_index", 0);
        }
      } else if(var_3 == "raidZoneCaptureTwar") {
        if(var_0.curprogress < var_0.usetime || var_0.claimteam != "none") {
          if(!common_scripts\utility::_id_562E(var_0.stalemate)) {
            if(var_0.lastclaimteam == "neutral" || var_0.lastclaimteam == self.team) {
              self setclientomnvar("ui_capture_status_index", 1);
              self setclientomnvar("ui_capture_icon", 1);
            } else {
              self setclientomnvar("ui_capture_status_index", 3);
              self setclientomnvar("ui_capture_icon", 3);
            }
          } else {
            self setclientomnvar("ui_capture_status_index", 2);
            self setclientomnvar("ui_capture_icon", 2);
          }
        } else {
          self setclientomnvar("ui_capture_icon", 0);
          self setclientomnvar("ui_capture_status_index", 0);
        }
      } else if(var_3 == "raidConstruct") {
        self setclientomnvar("ui_capture_status_index", 4);
        self setclientomnvar("ui_capture_icon", 1);
      } else if(var_3 == "raidRepair") {
        self setclientomnvar("ui_capture_status_index", 5);
        self setclientomnvar("ui_capture_icon", 1);
      } else if(var_3 == "raidPlantExplosive") {
        self setclientomnvar("ui_capture_status_index", 6);
        self setclientomnvar("ui_capture_icon", 1);
      } else if(var_3 == "raidDefuseExplosive") {
        self setclientomnvar("ui_capture_status_index", 7);
        self setclientomnvar("ui_capture_icon", 1);
      }
    } else {
      self setclientomnvar("ui_capture_icon", 0);
      self setclientomnvar("ui_capture_status_index", 0);
    }
  }

  if(var_2 == "zombies" && isDefined(var_3) && var_3 == "defuseObject") {
    if(!var_1) {
      self setclientomnvar("ui_capture_icon", 0);
    } else {
      self setclientomnvar("ui_capture_icon", 1);
    }
  }
}

updateuserate() {
  if(isDefined(self.onupdateuserate)) {
    self[[self.onupdateuserate]]();
  } else {
    updateuserate_internal();
  }
}

updateuserate_internal() {
  var_0 = self.numtouching[self.claimteam];
  var_1 = 0;
  var_2 = 0;

  if(level.multiteambased) {
    foreach(var_4 in level.teamnamelist) {
      if(self.claimteam != var_4) {
        var_1 = var_1 + self.numtouching[var_4];
      }
    }
  } else {
    if(self.claimteam != "axis") {
      var_1 = var_1 + self.numtouching["axis"];
    }

    if(self.claimteam != "allies") {
      var_1 = var_1 + self.numtouching["allies"];
    }
  }

  foreach(var_7 in self.touchlist[self.claimteam]) {
    if(!isDefined(var_7.player)) {
      continue;
    }
    if(var_7.player.pers["team"] != self.claimteam) {
      continue;
    }
    if(var_7.player.objectivescaler == 1) {
      continue;
    }
    if(level.gametype == "hp") {
      continue;
    }
    if(isDefined(self.id) && self.id == "raidEscortTrigger") {
      continue;
    }
    var_0 = var_0 * var_7.player.objectivescaler;
    var_2 = var_7.player.objectivescaler;
  }

  self.userate = 0;
  self.stalemate = var_0 && var_1;

  if(var_0 && !var_1) {
    self.userate = _min(var_0, 4);
  }

  if(isDefined(self.isarena) && self.isarena && var_2 != 0) {
    self.userate = 1 * var_2;
  } else if(isDefined(self.isarena) && self.isarena) {
    self.userate = 1;
  }

  if(self.keepprogress && self.lastclaimteam != self.claimteam) {
    self.userate = self.userate * -1;
  }
}

attachusemodel() {
  self endon("death");
  self endon("disconnect");
  self endon("done_using");
  wait 0.7;
  self attach("npc_gen_s_and_d_bomb", "tag_inhand", 1);
  self.attachedusemodel = "npc_gen_s_and_d_bomb";
}

_id_9BA8() {
  thread _id_2383();
  level endon("game_ended");
  level endon("zone_moved");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self.trigger)) {
        var_1 _meth_8608(1);
        continue;
      }

      var_1 _meth_8608(0);
    }

    wait 0.5;
  }
}

_id_2383() {
  level common_scripts\utility::waittill_any("game_ended", "zone_moved");

  foreach(var_1 in level.players) {
    var_1 _meth_8608(0);
  }
}

useholdthink(var_0) {
  var_0 notify("use_hold");

  if(common_scripts\utility::_id_562E(self._id_2F90)) {
    var_0 _meth_8546(0);
    var_0 disableoffhandweapons();
  } else if(isPlayer(var_0))
    var_0 playerlinkTo(self.trigger);
  else {
    var_0 linkTo(self.trigger);
  }

  var_0 clientclaimtrigger(self.trigger);
  var_0.claimtrigger = self.trigger;
  var_1 = self.useweapon;
  var_2 = var_0 getcurrentweapon();

  if(isDefined(var_0.carryweapon) && _id_04CB::_id_574C(var_2)) {
    var_2 = var_0.carryweapon;
  }

  if(_id_051E::doeskillstreakweaponstowammo(var_2)) {
    var_3 = var_0 getweaponammoclip(var_2);
    var_4 = var_0 getweaponammostock(var_2);

    if(var_3 + var_4 <= 0) {
      var_2 = var_0.disconnectnode;
    }
  }

  if(isDefined(var_1)) {
    if(maps\mp\_utility::isuseweapon(var_2)) {
      var_2 = var_0.lastnonuseweapon;
    }

    var_0.lastnonuseweapon = var_2;
    var_0 maps\mp\_utility::_giveweapon(var_1);
    var_0 disableoffhandweapons();
    var_0 setweaponammostock(var_1, 0);
    var_0 setweaponammoclip(var_1, 0);
    var_0 switchtoweapon(var_1);
    var_0.hasuseweapon = 1;

    if(!isDefined(self.attachdefault3pmodel) || self.attachdefault3pmodel == 1) {
      var_0 thread attachusemodel();
    }
  } else
    var_0 common_scripts\utility::_id_0602();

  var_5 = var_0 getentitynumber();

  if(isDefined(self._id_6E79)) {
    if(!self._id_6E79._id_5F95 && self._id_6E79._id_54F6.size == 0) {
      self._id_6E79.curprogress = 0;
    }

    self.inuse = 1;
    self._id_6E79._id_54F6[var_5] = 1;
    self._id_6E79.userate[var_5] = 0;

    if(isPlayer(var_0)) {
      if(isDefined(level._id_3FD1)) {
        var_0 thread[[level._id_3FD1]](self._id_6E79);
      } else {
        var_0 thread personalusebar(self._id_6E79);
      }
    }
  } else {
    if(!self._id_5F95) {
      self.curprogress = 0;
    }

    self.inuse = 1;
    self.userate = 0;

    if(isPlayer(var_0)) {
      if(isDefined(level._id_3FD1)) {
        var_0 thread[[level._id_3FD1]](self);
      } else {
        var_0 thread personalusebar(self);
      }
    }
  }

  var_6 = useholdthinkloop(var_0, var_2);

  if(isDefined(var_0)) {
    var_0 detachusemodels();
    var_0 notify("done_using");
  }

  if(isDefined(var_1) && isDefined(var_0)) {
    var_0 thread takeuseweapon(var_1);
  }

  if(isDefined(var_6) && var_6) {
    return 1;
  }

  if(isDefined(var_0)) {
    var_0.claimtrigger = undefined;

    if(isDefined(var_1)) {
      var_0.hasuseweapon = undefined;

      if(var_2 != "none") {
        if(common_scripts\utility::_id_562E(self._id_7894)) {
          var_0 maps\mp\_utility::_id_955D(var_2);
        } else {
          var_0 maps\mp\_utility::switch_to_last_weapon(var_2);
        }
      } else
        var_0 takeweapon(var_1);
    } else
      var_0 common_scripts\utility::_id_0616();

    if(common_scripts\utility::_id_562E(self._id_2F90)) {
      var_0 _meth_8546(1);
    } else {
      var_0 unlink();
    }

    if(!maps\mp\_utility::isreallyalive(var_0)) {
      var_0._id_5A3E = 1;
    }
  }

  self.inuse = 0;

  if(isDefined(self._id_6E79)) {
    self._id_6E79._id_54F6[var_5] = undefined;
    self._id_6E79.userate[var_5] = 0;
  }

  self.trigger releaseclaimedtrigger();
  return 0;
}

detachusemodels() {
  if(isDefined(self.attachedusemodel)) {
    self detach(self.attachedusemodel, "tag_inhand");
    self.attachedusemodel = undefined;
  }
}

takeuseweapon(var_0) {
  self endon("use_hold");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(self getcurrentweapon() == var_0 && !isDefined(self.throwinggrenade)) {
    waitframe();
  }

  self enableoffhandweapons();
  self takeweapon(var_0);
}

usetest(var_0, var_1, var_2, var_3) {
  if(!maps\mp\_utility::isreallyalive(var_0)) {
    return 0;
  }

  if(!var_0 istouching(self.trigger)) {
    return 0;
  }

  if(!var_0 useButtonPressed()) {
    return 0;
  }

  if(isDefined(var_0.throwinggrenade)) {
    return 0;
  }

  if(isDefined(self._id_6E79)) {
    if(self._id_6E79._id_A23C && var_0 meleeButtonPressed()) {
      return 0;
    }

    if(self._id_6E79.curprogress >= self._id_6E79.usetime) {
      return 0;
    }

    if(!_id_45D4(self._id_6E79) && !var_1) {
      return 0;
    }
  } else {
    if(self._id_A23C && var_0 meleeButtonPressed()) {
      return 0;
    }

    if(self.curprogress >= self.usetime) {
      return 0;
    }

    if(!self.userate && !var_1) {
      return 0;
    }
  }

  if(var_1 && var_2 > var_3) {
    return 0;
  }

  return 1;
}

useholdthinkloop(var_0, var_1) {
  level endon("game_ended");
  self endon("disabled");
  var_0 endon("stop_useHoldThinkLoop");
  var_2 = self.useweapon;
  var_3 = 1;
  var_4 = 0;
  var_5 = 1.5;
  var_6 = var_0 getentitynumber();
  var_7 = var_0.objectivescaler;

  while(usetest(var_0, var_3, var_4, var_5)) {
    var_4 = var_4 + 0.05;

    if(!isDefined(var_2) || var_0 getcurrentweapon() == var_2) {
      if(isDefined(self._id_6E79)) {
        if(isDefined(self._id_6E79._id_695A) && issubstr(self._id_6E79._id_695A, "bridge_")) {
          var_7 = 1;
        }

        self._id_6E79.curprogress = self._id_6E79.curprogress + 50 * self._id_6E79.userate[var_6];
        self._id_6E79.userate[var_6] = 1 * var_7;

        if(isDefined(self._id_6E79._id_A22C)) {
          self._id_6E79.userate[var_6] = self._id_6E79.userate[var_6] * self[[self._id_6E79._id_A22C]](var_0);
        }

        if(var_3 && isDefined(self._id_6E79._id_A212)) {
          self._id_6E79[[self._id_6E79._id_A212]](var_0);
        }
      } else {
        if(isDefined(self.id)) {
          if(issubstr(self.id, "raidZoneCaptureTwar")) {
            var_7 = 1;
          }

          if(isDefined(self._id_695A) && (issubstr(self._id_695A, "gun_") || issubstr(self._id_695A, "bomb_") || issubstr(self._id_695A, "town_bombplant")) && (issubstr(self.id, "raidDefuseExplosive") || issubstr(self.id, "raidPlantExplosive"))) {
            var_7 = 1;
          }
        }

        if(isDefined(self.useweapon)) {
          if(self.useweapon == "war_generic_open_mp") {
            var_7 = 1;
          }
        }

        if(isDefined(self._id_695A)) {
          if(issubstr(self._id_695A, "hostage_")) {
            var_7 = 1;
          }
        }

        self.curprogress = self.curprogress + 50 * self.userate;
        self.userate = 1 * var_7;

        if(var_3 && isDefined(self._id_A212)) {
          self[[self._id_A212]](var_0);
        }
      }

      var_3 = 0;
    } else if(isDefined(self._id_6E79))
      self._id_6E79.userate[var_6] = 0;
    else {
      self.userate = 0;
    }

    if(isDefined(self._id_6E79)) {
      var_8 = self._id_6E79.curprogress >= self._id_6E79.usetime;
    } else {
      var_8 = self.curprogress >= self.usetime;
    }

    if(var_8) {
      if(isDefined(self._id_6E79)) {
        self._id_6E79._id_54F6 = [];
      }

      self.inuse = 0;
      var_0 clientreleasetrigger(self.trigger);
      var_0.claimtrigger = undefined;

      if(isDefined(var_2)) {
        var_0 setweaponammostock(var_2, 1);
        var_0 setweaponammoclip(var_2, 1);
        var_0.hasuseweapon = undefined;

        if(var_1 != "none") {
          var_0 maps\mp\_utility::switch_to_last_weapon(var_1);
        } else {
          var_0 takeweapon(var_2);
        }
      } else
        var_0 common_scripts\utility::_id_0616();

      if(common_scripts\utility::_id_562E(self._id_2F90)) {
        var_0 _meth_8546(1);
      } else {
        var_0 unlink();
      }

      return maps\mp\_utility::isreallyalive(var_0);
    }

    waitframe();
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }

  return 0;
}

_id_A226(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0) {
    var_3._id_6E79 = var_1;
    var_3.curprogress = undefined;
    var_3.usetime = undefined;
    var_3.userate = undefined;
    var_3._id_5F95 = undefined;
  }

  var_1._id_576E = 1;
  var_1.curprogress = 0;
  var_1.userate = [];
  var_1._id_5F95 = 0;
  var_1._id_21F7 = var_0;
  var_1._id_54F6 = [];
  var_1._id_A23C = 1;
  return var_1;
}

personalusebar(var_0) {
  self endon("disconnect");
  var_1 = undefined;

  if(!isDefined(var_0.nousebar) || !var_0.nousebar) {
    var_1 = maps\mp\gametypes\_hud_util::_id_2821();
  }

  var_2 = undefined;

  if(isDefined(var_1) && isDefined(var_0.usetext)) {
    var_2 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
    var_2 settext(var_0.usetext);
  }

  var_3 = -1;
  var_4 = isDefined(level.hostmigrationtimer);

  while(maps\mp\_utility::isreallyalive(self) && _id_A224(var_0) && !level.gameended) {
    if(var_3 != _id_45D4(var_0) || var_4 != isDefined(level.hostmigrationtimer)) {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }

      var_5 = var_0.curprogress / var_0.usetime;
      var_6 = 1000 / var_0.usetime * _id_45D4(var_0);

      if(isDefined(level.hostmigrationtimer)) {
        var_6 = 0;
      }

      if(isDefined(var_1)) {
        var_1 maps\mp\gametypes\_hud_util::updatebar(var_5, var_6);

        if(!_id_45D4(var_0)) {
          var_1 maps\mp\gametypes\_hud_util::hideelem();

          if(isDefined(var_2)) {
            var_2 maps\mp\gametypes\_hud_util::hideelem();
          }
        } else {
          var_1 maps\mp\gametypes\_hud_util::showelem();

          if(isDefined(var_2)) {
            var_2 maps\mp\gametypes\_hud_util::showelem();
          }
        }
      }
    }

    var_3 = _id_45D4(var_0);
    var_4 = isDefined(level.hostmigrationtimer);
    updateuiprogress(var_0, 1);
    waitframe();
  }

  updateuiprogress(var_0, 0);

  if(isDefined(var_1)) {
    var_1 maps\mp\gametypes\_hud_util::destroyelem();
  }

  if(isDefined(var_2)) {
    var_2 maps\mp\gametypes\_hud_util::destroyelem();
  }
}

_id_45D4(var_0) {
  if(common_scripts\utility::_id_562E(var_0._id_576E)) {
    var_1 = 0;

    foreach(var_3 in var_0.userate) {
      var_1 = var_1 + var_3;
    }

    return var_1;
  } else
    return var_0.userate;
}

_id_A224(var_0) {
  if(common_scripts\utility::_id_562E(var_0._id_576E)) {
    return isDefined(var_0._id_54F6[self getentitynumber()]);
  } else {
    return var_0.inuse;
  }
}

updatetrigger() {
  if(self.triggertype != "use") {
    return;
  }
  if(self.interactteam == "none") {
    self.trigger.origin = self.trigger.origin - (0, 0, 50000);
  } else if(self.interactteam == "any") {
    self.trigger.origin = self.curorigin;
    self.trigger setteamfortrigger("none");
  } else if(self.interactteam == "friendly") {
    self.trigger.origin = self.curorigin;

    if(self.ownerteam == "allies") {
      self.trigger setteamfortrigger("allies");
    } else if(self.ownerteam == "axis") {
      self.trigger setteamfortrigger("axis");
    } else {
      self.trigger.origin = self.trigger.origin - (0, 0, 50000);
    }
  } else if(self.interactteam == "enemy") {
    self.trigger.origin = self.curorigin;

    if(self.ownerteam == "allies") {
      self.trigger setteamfortrigger("axis");
    } else if(self.ownerteam == "axis") {
      self.trigger setteamfortrigger("allies");
    } else {
      self.trigger setteamfortrigger("none");
    }
  }
}

_id_86DF(var_0, var_1, var_2) {
  var_0.color = game["dvar_color_names"]["plaintext"];
  var_0._id_002A = game["dvar_color_names"][self.worldiconscolor[var_2]];
  var_3 = _id_471F(self.compassicons[var_2]);

  if(var_3 != "") {
    var_0._id_0175 = game["dvar_color_names"][var_3];
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

  updateworldicon("broadcaster", 1);
}

updateworldicon(var_0, var_1) {
  if(!isDefined(self.worldicons[var_0])) {
    var_1 = 0;
  }

  var_2 = getupdateteams(var_0);
  var_3 = _id_8BB2();

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = "objpoint_" + var_2[var_4] + "_" + self.entnum;
    var_6 = _id_04EC::getobjpointbyname(var_5);

    if(!isDefined(var_6)) {
      continue;
    }
    var_6 notify("stop_flashing_thread");
    var_6 thread _id_04EC::stopflashing();

    if(var_1) {
      if(var_3) {
        var_6 setshader(_id_471E(self.worldicons[var_0]), level.objpointsize, level.objpointsize);
      } else {
        var_6 setshader(self.worldicons[var_0], level.objpointsize, level.objpointsize, self._id_AA89[var_0]);
      }

      var_6 fadeovertime(0.05);
      var_6.alpha = var_6.basealpha;
      var_6.isshown = 1;

      if(isDefined(self.compassicons[var_0])) {
        var_6 setwaypoint(1, 1, 0, 0, 0, 0, 0, 0, 0, 0, isDefined(self._id_356E) && self._id_356E);
      } else {
        var_6 setwaypoint(1, 0);
      }

      if(var_3) {
        _id_86DF(var_6, var_2[var_4], var_0);
        var_6 setclaimteam(_id_471D(self.worldicons[var_0]), _id_4720(self.worldicons[var_0]));
      }

      if(self.type == "carryObject") {
        if(isDefined(self.carrier) && !shouldpingobject(var_0)) {
          var_6 settargetEnt(self.carrier);
        } else if(!isDefined(self.carrier) && isDefined(self.objectiveonvisuals) && self.objectiveonvisuals) {
          var_6 settargetEnt(self.visuals[0]);
        } else {
          var_6 cleartargetEnt();
        }
      }
    } else {
      var_6 fadeovertime(0.05);
      var_6.alpha = 0;
      var_6.isshown = 0;
      var_6 cleartargetEnt();
    }

    var_6 thread hideworldiconongameend();
  }
}

hideworldiconongameend() {
  self notify("hideWorldIconOnGameEnd");
  self endon("hideWorldIconOnGameEnd");
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self)) {
    self.alpha = 0;
  }
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

  updatecompassicon("broadcaster", 1);
}

_id_446B(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    if(var_0 == "friendly") {
      var_1 = 1;
    } else if(var_0 == "enemy") {
      var_1 = 2;
    } else if(var_0 == "contest") {
      var_1 = 3;
    }
  }

  return var_1;
}

_id_A142(var_0, var_1) {
  var_2 = self.worldiconscolor[var_1];
  var_3 = _id_446B(var_2);
  var_4 = _id_471F(self.compassicons[var_1]);
  var_5 = _id_446B(var_4);
  _func_370(var_0, var_3, var_5);
}

updatecompassicon(var_0, var_1) {
  if(!isDefined(self.compassicons)) {
    return;
  }
  var_2 = getupdateteams(var_0);
  var_3 = _id_8BB2();

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_1;

    if(!var_5 && shouldshowcompassduetoradar(var_2[var_4])) {
      var_5 = 1;
    }

    var_6 = self.objidallies;

    if(var_2[var_4] == "axis") {
      var_6 = self.objidaxis;
    }

    if(var_2[var_4] == "broadcaster") {
      var_6 = self.objidmlgspectator;
    }

    if(!isDefined(self.compassicons[var_0]) || !var_5) {
      _objective_state(var_6, "invisible");
      continue;
    }

    if(var_3) {
      var_7 = self.compassicons[var_0];
      _objective_icon(var_6, _id_471E(var_7));
      _func_36F(var_6, _id_471D(var_7), _id_4720(var_7));
      _id_A142(var_6, var_0);
    } else if(common_scripts\utility::_id_562E(self._id_A200))
      _objective_icon(var_6, self.compassicons[var_0], var_0);
    else {
      _objective_icon(var_6, self.compassicons[var_0]);
    }

    _objective_state(var_6, "active");

    if(self.type == "carryObject") {
      if(maps\mp\_utility::isreallyalive(self.carrier) && !shouldpingobject(var_0)) {
        _objective_onentity(var_6, self.carrier);
        continue;
      }

      if(isDefined(self.objectiveonvisuals) && self.objectiveonvisuals) {
        _objective_onentity(var_6, self.visuals[0]);
        continue;
      }

      _objective_position(var_6, self.curorigin);
    }
  }
}

shouldpingobject(var_0) {
  if(var_0 == "friendly" && self.objidpingfriendly) {
    return 1;
  } else if(var_0 == "enemy" && self.objidpingenemy) {
    return 1;
  }

  return 0;
}

getupdateteams(var_0) {
  var_1 = [];

  if(var_0 == "friendly") {
    if(isfriendlyteam("allies")) {
      var_1[var_1.size] = "allies";
    }

    if(isfriendlyteam("axis")) {
      var_1[var_1.size] = "axis";
    }
  } else if(var_0 == "enemy") {
    if(!isfriendlyteam("allies")) {
      var_1[var_1.size] = "allies";
    }

    if(!isfriendlyteam("axis")) {
      var_1[var_1.size] = "axis";
    }
  } else if(var_0 == "broadcaster")
    var_1[var_1.size] = "broadcaster";

  return var_1;
}

shouldshowcompassduetoradar(var_0) {
  if(var_0 == "broadcaster") {
    return 0;
  }

  if(!isDefined(self.carrier)) {
    return 0;
  }

  if(self.carrier maps\mp\_utility::_hasperk("specialty_radarimmune") || self.carrier maps\mp\_utility::_hasperk("specialty_uavhidden")) {
    return 0;
  }

  return _getteamradar(var_0);
}

updatevisibilityaccordingtoradar() {
  self endon("death");
  self endon("carrier_cleared");

  for(;;) {
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
  self.trigger setHintString(var_0);
}

_id_0C1D(var_0) {
  self.interactteam = var_0;
}

_id_0C30(var_0) {
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
    for(var_1 = 0; var_1 < self.visuals.size; var_1++) {
      self.visuals[var_1] show();

      if(self.visuals[var_1].classname == "script_brushmodel" || self.visuals[var_1].classname == "script_model") {
        foreach(var_3 in level.players) {
          if(var_3 istouching(self.visuals[var_1])) {
            var_3 maps\mp\_utility::_suicide();
          }
        }

        self.visuals[var_1] thread makesolid();
      }
    }
  } else {
    for(var_1 = 0; var_1 < self.visuals.size; var_1++) {
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

  for(;;) {
    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      if(level.players[var_0] istouching(self)) {
        break;
      }
    }

    if(var_0 == level.players.size) {
      self solid();
      break;
    }

    waitframe();
  }
}

setcarriervisible(var_0) {
  self._id_200B = var_0;
}

setcanuse(var_0) {
  self._id_A23A = var_0;
}

_id_446C(var_0) {
  if(var_0 == 1) {
    return "enemy";
  } else if(var_0 == 2) {
    return "friendly";
  } else if(var_0 == 3) {
    return "contest";
  } else {
    return "neutral";
  }
}

set2dicon(var_0, var_1, var_2, var_3) {
  self.compassicons[var_0] = var_1;
  self._id_A200 = var_2;

  if(_id_8BB2()) {
    if(isDefined(var_3)) {
      self.worldiconscolor[var_0] = _id_446C(var_3);
    } else if(!isDefined(var_1)) {
      self.worldiconscolor[var_0] = "neutral";
    } else {
      self.worldiconscolor[var_0] = getwaypointbackgroundcolor(var_1);
    }
  }

  updatecompassicons();
}

playsoundtoteam(var_0, var_1, var_2, var_3) {
  self.worldicons[var_0] = var_1;
  self._id_356E = var_3;

  if(!_id_8BB2()) {
    if(isDefined(var_2)) {
      self._id_AA89[var_0] = var_2;
    } else {
      self._id_AA89[var_0] = 0;
    }
  } else if(isDefined(var_2))
    self.worldiconscolor[var_0] = _id_446C(var_2);
  else if(!isDefined(var_1)) {
    self.worldiconscolor[var_0] = "neutral";
  } else {
    self.worldiconscolor[var_0] = getwaypointbackgroundcolor(var_1);
  }

  updateworldicons();
}

scalepitch(var_0, var_1) {
  self._id_AA8D[var_0] = var_1;
}

setcarryicon(var_0) {
  self.carryicon = var_0;
}

_id_471D(var_0) {
  if(!isDefined(level._id_A98F)) {
    maps\mp\gametypes\_gamelogic::_id_5367();
  }

  var_1 = level._id_A98F[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1;
}

_id_4720(var_0) {
  if(!isDefined(level._id_A994)) {
    maps\mp\gametypes\_gamelogic::_id_5367();
  }

  var_1 = level._id_A994[var_0];

  if(!isDefined(var_1)) {
    return "";
  }

  return var_1;
}

_id_471E(var_0) {
  if(!isDefined(level._id_A98F)) {
    maps\mp\gametypes\_gamelogic::_id_5367();
  }

  var_1 = level._id_A992[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1;
}

getwaypointbackgroundcolor(var_0) {
  if(!isDefined(level._id_A990)) {
    maps\mp\gametypes\_gamelogic::_id_5367();
  }

  var_1 = level._id_A990[var_0];

  if(!isDefined(var_1)) {
    return "neutral";
  }

  return var_1;
}

_id_471F(var_0) {
  if(!isDefined(level._id_A993)) {
    maps\mp\gametypes\_gamelogic::_id_5367();
  }

  var_1 = level._id_A993[var_0];

  if(!isDefined(var_1)) {
    return "";
  }

  return var_1;
}

disableobject() {
  self notify("disabled");

  if(self.type == "carryObject") {
    if(isDefined(self.carrier)) {
      self.carrier takeobject(self);
    }

    for(var_0 = 0; var_0 < self.visuals.size; var_0++) {
      self.visuals[var_0] hide();
    }
  }

  self.trigger common_scripts\utility::trigger_off();
  setvisibleteam("none");
}

enableobject() {
  if(self.type == "carryObject") {
    for(var_0 = 0; var_0 < self.visuals.size; var_0++) {
      self.visuals[var_0] show();
    }
  }

  self.trigger common_scripts\utility::trigger_on();
  setvisibleteam("any");
}

getrelativeteam(var_0) {
  if(var_0 == self.ownerteam) {
    return "friendly";
  } else {
    return "enemy";
  }
}

isfriendlyteam(var_0) {
  var_1 = getclaimteam();

  if(self.ownerteam == "neutral" && var_1 != "none" && var_1 != var_0) {
    return 1;
  }

  if(self.ownerteam == "any") {
    return 1;
  }

  if(self.ownerteam == var_0) {
    return 1;
  }

  return 0;
}

caninteractwith(var_0, var_1) {
  switch (self.interactteam) {
    case "none":
      return 0;
    case "any":
      return 1;
    case "friendly":
      if(var_0 == self.ownerteam) {
        return 1;
      } else {
        return 0;
      }
    case "enemy":
      if(var_0 != self.ownerteam) {
        return 1;
      } else {
        return 0;
      }
    default:
      return 0;
  }
}

isteam(var_0) {
  if(var_0 == "neutral") {
    return 1;
  }

  if(var_0 == "allies") {
    return 1;
  }

  if(var_0 == "axis") {
    return 1;
  }

  if(var_0 == "any") {
    return 1;
  }

  if(var_0 == "none") {
    return 1;
  }

  foreach(var_2 in level.teamnamelist) {
    if(var_0 == var_2) {
      return 1;
    }
  }

  return 0;
}

isrelativeteam(var_0) {
  if(var_0 == "friendly") {
    return 1;
  }

  if(var_0 == "enemy") {
    return 1;
  }

  if(var_0 == "any") {
    return 1;
  }

  if(var_0 == "none") {
    return 1;
  }

  return 0;
}

getenemyteam(var_0) {
  if(level.multiteambased) {}

  if(var_0 == "neutral" || var_0 == "none") {
    return "none";
  } else if(var_0 == "allies") {
    return "axis";
  } else {
    return "allies";
  }
}

_id_45A9() {
  if(!isDefined(level.reclaimedreservedobjectives) || level.reclaimedreservedobjectives.size < 1) {
    var_0 = level.numgametypereservedobjectives;
    level.numgametypereservedobjectives++;
  } else {
    var_0 = level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size - 1];
    level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size - 1] = undefined;
  }

  if(var_0 > 31) {
    if(maps\mp\_utility::_id_579B()) {}

    var_0 = 31;
  }

  return var_0;
}

getlabel() {
  var_0 = self.trigger.shootblank;

  if(!isDefined(var_0)) {
    var_0 = "";
    return var_0;
  }

  if(var_0[0] != "_") {
    return "_" + var_0;
  }

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

_id_6B52(var_0) {
  self._id_5107 = var_0;
}

_id_8BB2() {
  return !maps\mp\_utility::_id_579B();
}

fake_loot_dispensation_logic() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = 120;
  var_1 = _randomintrange(30, 90);
  var_0 = var_0 + var_1;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self waittill("show_loot_notification");
}

_id_5108() {
  if(!self._id_5107) {
    return 0;
  }

  if(!isDefined(self.claimplayer) || !isDefined(self.claimplayer.touchtriggers)) {
    return 1;
  }

  var_0 = self.claimplayer.touchtriggers[self.entnum];

  if(!isDefined(var_0) || var_0 != self.trigger) {
    return 1;
  }

  return 0;
}

cancapwithoutclaim(var_0) {
  self.cancapwithoutclaim = var_0;
}