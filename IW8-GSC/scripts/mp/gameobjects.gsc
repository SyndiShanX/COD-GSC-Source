/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gameobjects.gsc
***********************************************/

function main(var_0) {
  GscBinSkip0(0x2e, var_0.size, "airdrop_pallet");
}

function init() {
  level.numgametypereservedobjectives = 0;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  thread getleveltriggers();
}

function onplayerspawned() {
  if(isbot(self)) {
    level.botsenabled = 1;
  }

  var_0 = !istrue(level.disableinitplayergameobjects);

  if(scripts\mp\utility\game::getgametype() == "war") {
    var_0 = 0;
  }

  if(getdvarint("scr_forceGameObjectPlayerInit", 0) == 1) {
    var_0 = 1;
  }

  if(var_0) {
    if(isDefined(self.gameobject_fauxspawn)) {
      self.gameobject_fauxspawn = undefined;
      return;
    }

    init_player_gameobjects();
  }
}

function init_player_gameobjects() {
  thread ondeathordisconnect();
  self.touchtriggers = [];
  self.carryobject = undefined;
  self.canpickupobject = 1;
  self.initialized_gameobject_vars = 1;
}

function ondeathordisconnect() {
  level endon("game_ended");
  self waittill("death_or_disconnect");
  _ondeathordisconnectinternal();
}

function _ondeathordisconnectinternal() {
  if(isDefined(self.carryobject)) {
    thread setdropped();
    return;
  }
}

function onjuggernaut() {
  waittillframeend();

  if(isDefined(self.carryobject)) {
    thread setdropped();
    self switchtoweapon(scripts\mp\juggernaut::vehicle_damage_setweaponclassmoddamageforvehicle());
    return;
  }
}

function createtrackedobject(var_0, var_1) {
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("tag_origin");
  var_3 = spawnStruct();
  var_3.type = "carryObject";
  var_3.carrier = var_0;
  var_3.curorigin = var_0.origin;
  var_3.entnum = var_2 getentitynumber();
  var_3.ownerteam = var_0.team;
  var_3.offset3d = var_1;
  var_3.triggertype = "none";
  var_3.compassicons = [];
  var_3.objidpingfriendly = 0;
  var_3.objidpingenemy = 0;
  var_3.carriervisible = 0;
  var_3.visibleteam = "none";
  requestid(var_3, 1, 1);
  thread updatecarryobjectorigin();
  thread deletetrackedobjectoncarrierdisconnect();
  return var_3;
}

function deletetrackedobjectoncarrierdisconnect() {
  self.carrier waittill("disconnect");
  deletetrackedobject();
}

function deletetrackedobject() {
  if(self.type != "carryObject") {
    return;
  }

  var_0 = self;
  var_0.type = undefined;
  var_0.carrier = undefined;
  var_0.curorigin = undefined;
  var_0.entnum = undefined;
  var_0.ownerteam = undefined;
  var_0.compassicons = undefined;
  var_0.objidpingfriendly = undefined;
  var_0.objidpingenemy = undefined;
  var_0.carriervisible = undefined;
  var_0.visibleteam = undefined;
  releaseid();
  self notify("gameobject_deleted");
}

function createcarryobject(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.type = "carryObject";
  var_6.curorigin = var_1.origin;
  var_6.ownerteam = var_0;
  var_6.useifproximity = var_4;
  var_6.entnum = var_1 getentitynumber();

  if(issubstr(var_1.classname, "use")) {
    var_6.triggertype = "use";
  } else {
    var_6.triggertype = "proximity";
  }

  var_1.gameobject = var_6;
  var_1.baseorigin = var_1.origin;
  var_6.trigger = var_1;

  if(!isDefined(var_1.linktoenabledflag)) {
    var_1.linktoenabledflag = 1;
    var_1 enablelinkTo();
  }

  var_6.useweapon = undefined;

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_6.offset3d = var_3;

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    var_2[var_7].baseorigin = var_2[var_7].origin;
    var_2[var_7].baseangles = var_2[var_7].angles;
  }

  var_6.visuals = var_2;
  var_6.compassicons = [];
  var_6.objidpingfriendly = 0;
  var_6.objidpingenemy = 0;

  if(!isDefined(var_5)) {
    requestid(var_6, 1, 1);
  }

  var_6.carrier = undefined;
  var_6.isresetting = 0;
  var_6.interactteam = "none";
  var_6.allowweapons = 0;
  var_6.carriervisible = 0;
  var_6.visibleteam = "none";
  var_6.carryicon = undefined;
  var_6.ondrop = undefined;
  var_6.onpickup = undefined;
  var_6.onreset = undefined;
  var_6.ref_12355 = [];

  if(var_6.triggertype == "use") {
    thread carryobjectusethink();
  } else {
    var_6.curprogress = 0;
    var_6.teamprogress = [];
    var_6.teamprogress["none"] = 0;
    var_6.usetime = 0;
    var_6.userate = 0;
    var_6.useratemultiplier = 1;
    var_6.mustmaintainclaim = 0;
    var_6.cancontestclaim = 0;
    var_6.teamusetimes = [];
    var_6.teamusetexts = [];
    var_6.numtouching["neutral"] = 0;
    var_6.touchlist["neutral"] = [];
    var_6.numtouching["none"] = 0;
    var_6.touchlist["none"] = [];

    foreach(var_9 in level.teamnamelist) {
      var_6.teamprogress[var_9] = 0;
      var_6.numtouching[var_9] = 0;
      var_6.touchlist[var_9] = [];
    }

    var_6.claimteam = "none";
    var_6.claimplayer = undefined;
    var_6.lastclaimteam = "none";
    var_6.lastclaimtime = 0;
    thread carryobjectproxthink();
  }

  thread updatecarryobjectorigin();
  return var_6;
}

function ref_12b13(var_0) {
  self.ref_12355[self.ref_12355.size] = var_0;
}

function getfullweaponobjfromscriptablename(var_0) {
  var_1 = 1;

  foreach(var_3 in self.ref_12355) {
    var_1 &= [[var_3]](var_0);
  }

  return var_1;
}

function deletecarryobject() {
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

  foreach(var_2 in var_0.visuals) {
    var_2 delete();
  }

  var_0.visuals = undefined;
  var_0.compassicons = undefined;
  var_0.objidpingfriendly = undefined;
  var_0.objidpingenemy = undefined;
  var_0.objpingdelay = undefined;
  releaseid();
  var_0.carrier = undefined;
  var_0.isresetting = undefined;
  var_0.interactteam = undefined;
  var_0.allowweapons = undefined;
  var_0.keepprogress = undefined;
  var_0.carriervisible = undefined;
  var_0.visibleteam = undefined;
  var_0.carryicon = undefined;
  var_0.ondrop = undefined;
  var_0.onpickup = undefined;
  var_0.onreset = undefined;
  var_0.curprogress = undefined;
  var_0.usetime = undefined;
  var_0.userate = undefined;
  var_0.useratemultiplier = 1;
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

function carryobjectusethink() {
  level endon("game_ended");

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }

    if(var_0 ismeleeing()) {
      continue;
    }

    var_1 = var_0 getcurrentweapon();

    if(scripts\mp\utility\killstreak::isremotekillstreakweapon(var_1.basename)) {
      continue;
    }

    if(var_0 scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
      var_2 = var_0 scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();

      if(scripts\mp\utility\killstreak::isremotekillstreakweapon(var_2.basename)) {
        continue;
      }
    }

    if(istrue(var_0.inlaststand)) {
      continue;
    }

    if(self.isresetting) {
      continue;
    }

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }

    if(!caninteractwith(var_0.pers["team"], var_0)) {
      continue;
    }

    if(!var_0.canpickupobject) {
      continue;
    }

    if(isDefined(var_0.nopickuptime) && var_0.nopickuptime > gettime()) {
      continue;
    }

    if(!isDefined(var_0.initialized_gameobject_vars)) {
      continue;
    }

    if(!unset_relic_bang_and_boom() && var_0 scripts\mp\utility\weapon::grenadeinpullback()) {
      var_3 = var_0 getheldoffhand();

      if(!scripts\mp\utility\weapon::isgesture(var_3)) {
        continue;
      }
    }

    if(isDefined(self.carrier)) {
      continue;
    }

    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    if(!proxtriggerlos(var_0)) {
      continue;
    }

    setpickedup(var_0);
  }
}

function carryobjectproxthink() {
  if(scripts\mp\utility\game::getgametype() == "ball" || scripts\mp\utility\game::getgametype() == "tdef" || istrue(self.useifproximity)) {
    thread carryobjectusethink();
    return;
  }

  thread carryobjectproxthinkdelayed();
}

function carryobjectproxthinkdelayed() {
  level endon("game_ended");

  if(isDefined(self.trigger)) {
    self.trigger endon("move_gameobject");
  }

  thread proxtriggerthink();

  for(;;) {
    if(self.usetime && self.teamprogress[self.claimteam] >= self.usetime) {
      self.curprogress = 0;
      self.teamprogress[self.claimteam] = self.curprogress;
      var_0 = getearliestclaimplayer();
      setclaimteam("none");
      self.claimplayer = undefined;

      if(isDefined(self.onenduse)) {
        self[[self.onenduse]](getlastclaimteam(), var_0, isDefined(var_0));
      }

      if(isDefined(var_0)) {
        setpickedup(var_0);
      }
    }

    if(self.claimteam != "none") {
      if(self.usetime) {
        if(!self.numtouching[self.claimteam]) {
          setclaimteam("none");
          self.claimplayer = undefined;

          if(isDefined(self.onenduse)) {
            self[[self.onenduse]](getlastclaimteam(), self.claimplayer, 0);
          }
        } else {
          self.curprogress += level.frameduration * self.userate;
          self.teamprogress[self.claimteam] = self.curprogress;
          var_1 = scripts\mp\utility\teams::getenemyteams(self.claimteam);

          foreach(var_3 in var_1) {
            if(self.ownerteam != var_3) {
              self.teamprogress[var_3] = 0;
            }
          }

          if(isDefined(self.onuseupdate)) {
            self[[self.onuseupdate]](getclaimteam(), self.curprogress / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer);
          }
        }
      } else {
        if(scripts\mp\utility\player::isreallyalive(self.claimplayer)) {
          setpickedup(self.claimplayer);
        }

        setclaimteam("none");
        self.claimplayer = undefined;
      }
    }

    waitframe();
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

function pickupobjectdelay(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self.canpickupobject = 0;

  if(isDefined(var_0.ballindex)) {
    var_1 = 1024;
  } else {
    var_1 = 4096;
  }

  for(;;) {
    if(distancesquared(self.origin, var_1.trigger.origin) > var_1) {
      break;
    }

    wait 0.2;
  }

  self.canpickupobject = 1;
}

function setpickedup(var_0, var_1, var_2) {
  if(isai(var_0) && isDefined(var_0.owner)) {
    return;
  }

  if(isDefined(var_0.carryobject) || isDefined(self.carryweapon) && !var_0 scripts\common\utility::is_weapon_allowed() || !getfullweaponobjfromscriptablename(var_0)) {
    if(isDefined(self.onpickupfailed)) {
      self[[self.onpickupfailed]](var_0);
    }

    return;
  }

  giveobject(var_0, self);
  setcarrier(var_0);

  if(isDefined(self.trigger getlinkedparent())) {
    for(var_3 = 0; var_3 < self.visuals.size; var_3++) {
      self.visuals[var_3] unlink();
    }

    self.trigger unlink();
  }

  for(var_3 = 0; var_3 < self.visuals.size; var_3++) {
    self.visuals[var_3] hide();
  }

  self.trigger.origin += (0, 0, 10000);
  self.trigger scripts\mp\movers::stop_handling_moving_platforms();
  self notify("pickup_object");

  if(isDefined(self.onpickup)) {
    self[[self.onpickup]](var_0, var_1, var_2);
    return;
  }
}

function updatecurorigin() {
  self endon("gameobject_deleted");
  level endon("game_ended");

  if(isDefined(self.trigger)) {
    self.trigger endon("move_gameobject");
  }

  if(scripts\mp\utility\game::getgametype() == "front") {
    self.carrier endon("disconnect");
  }

  for(;;) {
    if(isDefined(self.carrier)) {
      self.curorigin = self.carrier.origin + (0, 0, 75);
      self.curcarrierorigin = self.carrier.origin;
    } else {
      self.curorigin = self.trigger.origin;
      self.curcarrierorigin = undefined;
    }

    waitframe();
  }
}

function updatecarryobjectorigin() {
  self endon("gameobject_deleted");
  level endon("game_ended");

  if(isDefined(self.trigger)) {
    self.trigger endon("move_gameobject");
  }

  thread updatecurorigin();

  if(!isDefined(self.objpingdelay)) {
    self.objpingdelay = 4;
  }

  for(;;) {
    if(self.objpingdelay == 0) {
      break;
    }

    if(isDefined(self.carrier)) {
      foreach(var_1 in level.teamnamelist) {
        if((self.visibleteam == "friendly" || self.visibleteam == "any") && !isfriendlyteam(var_1) && self.objidpingfriendly) {
          if(self.showworldicon) {
            if(isDefined(self.pingobjidnum)) {
              scripts\mp\objidpoolmanager::update_objective_position(self.pingobjidnum, self.curorigin);

              if(istrue(self.pingplayers)) {
                objective_setpings(self.pingobjidnum, 1);
              } else {
                objective_setpingsforteam(self.pingobjidnum, var_1);
              }

              objective_ping(self.pingobjidnum);
              continue;
            }

            if(istrue(self.pingplayers)) {
              objective_setpings(self.objidnum, 1);
            } else {
              objective_setpingsforteam(self.objidnum, var_1);
            }

            objective_ping(self.objidnum);
          }
        }
      }

      foreach(var_1 in level.teamnamelist) {
        if((self.visibleteam == "enemy" || self.visibleteam == "any") && isfriendlyteam(var_1) && self.objidpingenemy) {
          if(self.showworldicon) {
            if(isDefined(self.pingobjidnum)) {
              scripts\mp\objidpoolmanager::update_objective_position(self.pingobjidnum, self.curorigin);

              if(istrue(self.pingplayers)) {
                objective_setpings(self.pingobjidnum, 1);
              } else {
                objective_setpingsforteam(self.pingobjidnum, var_1);
              }

              objective_ping(self.pingobjidnum);
              continue;
            }

            if(istrue(self.pingplayers)) {
              objective_setpings(self.objidnum, 1);
            } else {
              objective_setpingsforteam(self.objidnum, var_1);
            }

            objective_ping(self.objidnum);
          }
        }
      }

      scripts\engine\utility::ref_143c0(self.objpingdelay, "dropped", "reset");
      continue;
    }

    waitframe();
  }
}

function hidecarryiconongameend() {
  self endon("death_or_disconnect");
  self endon("drop_object");
  level waittill("game_ended");

  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
    return;
  }
}

function gameobjects_getcurrentprimaryweapon() {
  var_0 = self getcurrentweapon();
  var_1 = self getcurrentprimaryweapon();
  var_2 = var_1 getaltweapon();

  if(var_2 == var_0) {
    return var_0;
  }

  return var_1;
}

function watchcarryobjectweaponswitch(var_0) {
  self endon("goal_scored");
  var_1 = gettime();
  var_2 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1);

  if(isDefined(var_2)) {
    if(var_2 == 0) {
      if(var_1 == gettime()) {
        waittillframeend();
      }

      if(isDefined(self.carryobject)) {
        thread setdropped();
        return;
      }

      return;
    }

    return;
  }
}

function giveobject(var_0) {
  self.carryobject = var_0;
  thread trackcarrier();

  if(isDefined(var_0.carryweapon)) {
    var_0.carrierweaponcurrent = gameobjects_getcurrentprimaryweapon();
    var_0.carrierhascarryweaponinloadout = self hasweapon(var_0.carryweapon);

    if(isDefined(var_0.carryweaponthink)) {
      self thread[[var_0.carryweaponthink]]();
    }

    self giveweapon(var_0.carryweapon);
    thread watchcarryobjectweaponswitch(var_0.carryweapon);
    self disableweaponpickup();
    scripts\common\utility::allow_weapon_switch(0);
  } else if(!var_0.allowweapons) {
    scripts\common\utility::allow_weapon(0);
    thread manualdropthink();
  }

  if(isDefined(var_0.carryicon)) {
    if(level.splitscreen) {
      self.carryicon = scripts\mp\hud_util::createicon(var_0.carryicon, 33, 33);
      self.carryicon scripts\mp\hud_util::setpoint("BOTTOM LEFT", "BOTTOM LEFT", -50, -78);
    } else {
      self.carryicon = scripts\mp\hud_util::createicon(var_0.carryicon, 50, 50);
      self.carryicon scripts\mp\hud_util::setpoint("BOTTOM LEFT", "BOTTOM LEFT", 175, -30);
    }

    self.carryicon.hidewheninmenu = 1;
    thread hidecarryiconongameend();
    return;
  }
}

function returnhome() {
  self.isresetting = 1;
  self notify("reset");

  for(var_0 = 0; var_0 < self.visuals.size; var_0++) {
    var_1 = self.visuals[var_0] getlinkedparent();

    if(isDefined(var_1)) {
      self.visuals[var_0] unlink();
    }

    if(isbombmode() && self.visuals[var_0].targetname == "sd_bomb") {
      self.visuals[var_0].origin = level.bombrespawnpoint;
      self.visuals[var_0].angles = level.bombrespawnangles;
    } else {
      self.visuals[var_0].origin = self.visuals[var_0].baseorigin;
      self.visuals[var_0].angles = self.visuals[var_0].baseangles;
    }

    self.visuals[var_0] show();
  }

  var_1 = self.trigger getlinkedparent();

  if(isDefined(var_1)) {
    self.trigger unlink();
  }

  self.trigger.origin = self.trigger.baseorigin;
  self.curorigin = self.trigger.origin;

  if(isDefined(self.onreset)) {
    self[[self.onreset]]();
  }

  clearcarrier();
  updatecompassicons();
  self.isresetting = 0;
  self notify("reset_done");
}

function ishome() {
  if(isDefined(self.carrier)) {
    return false;
  }

  if(self.curorigin != self.trigger.baseorigin) {
    return false;
  }

  return true;
}

function setposition(var_0, var_1) {
  self.isresetting = 1;

  for(var_2 = 0; var_2 < self.visuals.size; var_2++) {
    self.visuals[var_2].origin = var_0;
    self.visuals[var_2].angles = var_1;
    self.visuals[var_2] show();
  }

  self.trigger.origin = var_0;

  if(scripts\mp\utility\game::getgametype() == "ball" || scripts\mp\utility\game::getgametype() == "tdef") {
    self.trigger linkTo(self.visuals[0]);
  }

  self.curorigin = self.trigger.origin;
  clearcarrier();
  updatecompassicons();
  self.isresetting = 0;
}

function carryobject_overridemovingplatformdeath(var_0) {
  for(var_1 = 0; var_1 < var_0.carryobject.visuals.size; var_1++) {
    var_0.carryobject.visuals[var_1] unlink();
  }

  var_0.carryobject.trigger unlink();
  thread setdropped(var_0.carryobject);
}

function setdropped(var_0, var_1) {
  if(isDefined(self.setdropped)) {
    if([[self.setdropped]]()) {
      return;
    }
  }

  self.isresetting = 1;
  self.resetnow = undefined;
  self notify("dropped");

  foreach(var_3 in self.visuals) {
    var_3 notsolid();
  }

  if(isDefined(self.carrier)) {
    var_5 = self.carrier.origin;
  } else {
    var_5 = self.curorigin;
  }

  if(istrue(level.botsenabled) || touchingdroptonavmeshtrigger(var_5) || level.mapname == "mp_junk" && level.gametype == "ctf" && !touchingarbitraryuptrigger(self.carrier)) {
    var_5 = getclosestpointonnavmesh(var_5);
  }

  if(isDefined(level.bombdroploc)) {
    var_5 = level.bombdroploc;
    level.bombdroploc = undefined;
  }

  if(isDefined(var_2)) {
    var_6 = var_2;
  } else {
    var_6 = 20;
  }

  var_7 = 4000;
  var_8 = (0, 0, 0);
  var_9 = var_6 + (0, 0, var_6);
  var_10 = var_6 - (0, 0, var_7);
  var_11 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var_12 = [];
  GscBinSkip0(0x2e, var_12.size, self.visuals[0]);
}

function ref_143fb(var_0) {
  self endon("pickup_object");
  var_0 waittill("death");
  thread setdropped();
}

function setcarrier(var_0) {
  self.carrier = var_0;
  thread updatevisibilityaccordingtoradar();
}

function clearcarrier() {
  if(!isDefined(self.carrier)) {
    return;
  }

  thread takeobject(self.carrier);
  self.carrier = undefined;
  self.curcarrierorigin = undefined;
  self notify("carrier_cleared");
}

function pickuptimeout() {
  self endon("pickup_object");
  self endon("reset_done");
  waitframe();

  if(isDefined(self.resetnow)) {
    self.resetnow = undefined;
    returnhome();
    return;
  }

  for(var_0 = 0; var_0 < level.radtriggers.size; var_0++) {
    if(!self.visuals[0] istouching(level.radtriggers[var_0])) {
      continue;
    }

    returnhome();
    return;
  }

  for(var_0 = 0; var_0 < level.minetriggers.size; var_0++) {
    if(!self.visuals[0] istouching(level.minetriggers[var_0])) {
      continue;
    }

    returnhome();
    return;
  }

  for(var_0 = 0; var_0 < level.hurttriggers.size; var_0++) {
    if(!self.visuals[0] istouching(level.hurttriggers[var_0])) {
      continue;
    }

    returnhome();
    return;
  }

  if(istrue(level.ballallowedtriggers.size)) {
    self.allowedintrigger = 0;

    foreach(var_2 in level.ballallowedtriggers) {
      if(self.visuals[0] istouching(var_2)) {
        self.allowedintrigger = 1;
        break;
      }
    }
  }

  if(isDefined(level.outofboundstriggers)) {
    foreach(var_2 in level.outofboundstriggers) {
      if(istrue(self.allowedintrigger)) {
        break;
      }

      if(!self.visuals[0] istouching(var_2)) {
        continue;
      }

      returnhome();
      return;
    }
  }

  if(isDefined(self.autoresettime)) {
    wait self.autoresettime;

    if(!isDefined(self.carrier)) {
      returnhome();
      return;
    }

    return;
  }
}

function takeobject(var_0) {
  if(isDefined(self.carryicon)) {
    self.carryicon scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self)) {
    self.carryobject = undefined;
  }

  self notify("drop_object");

  if(var_0.triggertype == "proximity") {
    thread pickupobjectdelay(var_0);
  }

  if(scripts\mp\utility\player::isreallyalive(self) && !var_0.allowweapons) {
    if(isDefined(var_0.carryweapon)) {
      var_1 = isDefined(var_0.keepcarryweapon) && var_0.keepcarryweapon;

      if(!var_0.carrierhascarryweaponinloadout && !var_1) {
        if(isDefined(var_0.ballindex)) {
          wait 0.25;
        }

        self notify("clear_carrier");

        if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_0.carryweapon)) {
          scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0.carryweapon);
        } else {
          scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0.carryweapon);
        }

        thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(self.lastdroppableweaponobj);
      }

      self enableweaponpickup();
      scripts\common\utility::allow_weapon_switch(1);
      return;
    }

    if(!var_0.allowweapons) {
      scripts\common\utility::allow_weapon(1);
      return;
    }

    return;
  }
}

function trackcarrier() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  while(isDefined(self.carryobject) && scripts\mp\utility\player::isreallyalive(self)) {
    if(self isonground()) {
      var_0 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);

      if(var_0["fraction"] < 1) {
        self.carryobject.safeorigin = var_0["position"];
      }
    }

    wait 0.05;
  }
}

function manualdropthink() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  for(;;) {
    while(self attackButtonPressed() || self fragButtonPressed() || self secondaryoffhandbuttonPressed() || self meleeButtonPressed()) {
      wait 0.05;
    }

    while(!self attackButtonPressed() && !self fragButtonPressed() && !self secondaryoffhandbuttonPressed() || self meleeButtonPressed()) {
      wait 0.05;
    }

    if(isDefined(self.carryobject) && !self useButtonPressed()) {
      thread setdropped();
    }
  }
}

function deleteuseobject() {
  releaseid();
  self.trigger delete();
  self.trigger = undefined;
  self notify("deleted");
}

function createuseobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(istrue(var_1.vampirepoints)) {
    var_8 = var_1;
  } else {
    var_8 = spawnStruct();
  }

  var_8.type = "useObject";
  var_8.curorigin = var_2.origin;
  var_8.ownerteam = var_1;
  var_8.entnum = var_2 getentitynumber();
  var_8.keyobject = undefined;

  if(issubstr(var_2.classname, "use") || istrue(var_2.usetype)) {
    var_8.triggertype = "use";
  } else {
    var_8.triggertype = "proximity";
  }

  var_2.gameobject = var_8;
  var_8.trigger = var_2;

  for(var_9 = 0; var_9 < var_3.size; var_9++) {
    var_3[var_9].baseorigin = var_3[var_9].origin;
    var_3[var_9].baseangles = var_3[var_9].angles;
  }

  var_8.visuals = var_3;

  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  var_8.offset3d = var_4;
  var_8.compassicons = [];

  if(!istrue(var_6)) {
    requestid(var_8, 1, 1, var_5, var_7);
  }

  var_8.interactteam = "none";
  var_8.visibleteam = "none";
  var_8.onuse = undefined;
  var_8.oncantuse = undefined;
  var_8.usetext = "default";
  var_8.usetime = 10000;
  var_8.curprogress = 0;
  var_8.majoritycapprogress = 0;
  var_8.wasmajoritycapprogress = 0;
  var_8.stalemate = 0;
  var_8.wasstalemate = 0;
  var_8.exclusiveuse = 1;
  var_8.teamprogress = [];
  var_8.teamprogress["none"] = 0;

  if(var_8.triggertype == "proximity") {
    var_8.teamusetimes = [];
    var_8.teamusetexts = [];
    var_8.numtouching["neutral"] = 0;
    var_8.touchlist["neutral"] = [];
    var_8.numtouching["none"] = 0;
    var_8.touchlist["none"] = [];

    foreach(var_11 in level.teamnamelist) {
      var_8.teamprogress[var_11] = 0;
      var_8.numtouching[var_11] = 0;
      var_8.touchlist[var_11] = [];
      var_8.assisttouchlist[var_11] = [];
    }

    var_8.userate = 0;
    var_8.useratemultiplier = 1;
    var_8.claimteam = "none";
    var_8.claimplayer = undefined;
    var_8.lastclaimteam = "none";
    var_8.lastclaimtime = 0;
    var_8.mustmaintainclaim = 0;
    var_8.cancontestclaim = 0;

    if(isDefined(var_8)) {
      var_8.brking_givepoints = var_8;
    }

    thread useobjectproxthink();
  } else {
    foreach(var_14 in level.teamnamelist) {
      var_8.teamprogress[var_14] = 0;
    }

    var_8.userate = 1;
    var_8.useratemultiplier = 1;
    thread useobjectusethink();
  }

  return var_8;
}

function createholduseobject(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "useObject";
  var_4.curorigin = var_1.origin;
  var_4.ownerteam = var_0;
  var_4.entnum = var_1 getentitynumber();
  var_4.keyobject = undefined;
  var_4.triggertype = "use";
  var_1.gameobject = var_4;
  var_4.trigger = var_1;

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    var_2[var_5].baseorigin = var_2[var_5].origin;
    var_2[var_5].baseangles = var_2[var_5].angles;
  }

  var_4.visuals = var_2;

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_4.offset3d = var_3;
  var_4.compassicons = [];
  var_4.interactteam = "none";
  var_4.visibleteam = "none";
  var_4.onuse = undefined;
  var_4.oncantuse = undefined;
  var_4.usetext = "default";
  var_4.usetime = 10000;
  var_4.curprogress = 0;
  var_4.stalemate = 0;
  var_4.wasstalemate = 0;
  var_4.exclusiveuse = 1;
  var_4.teamprogress = [];
  var_4.teamprogress["none"] = 0;

  foreach(var_7 in level.teamnamelist) {
    var_4.teamprogress[var_7] = 0;
  }

  var_4.userate = 1;
  var_4.useratemultiplier = 1;
  thread useobjectusethink();
  return var_4;
}

function createdynamicholduseobject(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "useObject";
  var_4.curorigin = var_1;
  var_4.ownerteam = var_0;
  var_4.keyobject = undefined;
  var_4.triggertype = "use";

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    var_2[var_5].baseorigin = var_2[var_5].origin;
    var_2[var_5].baseangles = var_2[var_5].angles;
  }

  var_4.visuals = var_2;

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_4.offset3d = var_3;
  var_4.compassicons = [];
  var_4.interactteam = "none";
  var_4.visibleteam = "none";
  var_4.onuse = undefined;
  var_4.oncantuse = undefined;
  var_4.usetext = "default";
  var_4.usetime = 10000;
  var_4.curprogress = 0;
  var_4.stalemate = 0;
  var_4.wasstalemate = 0;
  var_4.exclusiveuse = 1;
  var_4.teamprogress = [];
  var_4.teamprogress["none"] = 0;

  foreach(var_7 in level.teamnamelist) {
    var_4.teamprogress[var_7] = 0;
  }

  var_4.userate = 1;
  var_4.useratemultiplier = 1;
  var_2[0] makeusable();
  thread usedynamicobjectusethink();
  return var_4;
}

function setkeyobject(var_0) {
  self.keyobject = var_0;
}

function usedynamicobjectusethink() {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
    self waittill("trigger", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }

    if(!caninteractwith(var_0.pers["team"], var_0)) {
      continue;
    }

    if(!var_0 isonground()) {
      continue;
    }

    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    if(scripts\mp\utility\weapon::iskillstreakweapon(var_0 getcurrentweapon())) {
      continue;
    }

    if(isDefined(self.usecondition)) {
      if(!self[[self.usecondition]](var_0)) {
        continue;
      }
    }

    if(isDefined(self.keyobject) && (!isDefined(var_0.carryobject) || var_0.carryobject != self.keyobject)) {
      if(isDefined(self.oncantuse)) {
        self[[self.oncantuse]](var_0);
      }

      continue;
    }

    if(isDefined(self.useweapon) && var_0 hasweapon(self.useweapon)) {
      continue;
    }

    if(!var_0 scripts\common\utility::is_weapon_allowed()) {
      continue;
    }

    if(!self.exclusiveuse && !isDefined(self.exclusiveclaim)) {
      thread useholdloop(var_0);
      continue;
    }

    useholdloop(var_0);
  }
}

function useobjectusethink() {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }

    if(!caninteractwith(var_0.pers["team"], var_0)) {
      continue;
    }

    if(!var_0 isonground()) {
      continue;
    }

    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    if(scripts\mp\utility\weapon::iskillstreakweapon(var_0 getcurrentweapon()) && !istrue(var_0.isjuggernaut)) {
      continue;
    }

    if(isDefined(level.ref_11c89)) {
      if(![[level.ref_11c89]](var_0)) {
        continue;
      }
    }

    if(isDefined(self.usecondition)) {
      if(!self[[self.usecondition]](var_0)) {
        continue;
      }
    }

    if(isDefined(self.keyobject) && (!isDefined(var_0.carryobject) || var_0.carryobject != self.keyobject)) {
      if(isDefined(self.oncantuse)) {
        self[[self.oncantuse]](var_0);
      }

      continue;
    }

    if(isDefined(self.useweapon) && var_0 hasweapon(self.useweapon)) {
      continue;
    }

    if(!var_0 scripts\common\utility::is_weapon_allowed()) {
      continue;
    }

    if(!self.exclusiveuse && !isDefined(self.exclusiveclaim)) {
      thread useholdloop(var_0);
      continue;
    }

    useholdloop(var_0);
  }
}

function useholdloop(var_0) {
  var_1 = 1;

  if(self.usetime > 0) {
    if(isDefined(self.onbeginuse)) {
      updateuiprogress(var_0, self, 0);
      self[[self.onbeginuse]](var_0);
    }

    if(!isDefined(self.keyobject)) {
      thread cantusehintthink();
    }

    var_2 = var_0.pers["team"];
    var_1 = useholdthink(var_0);
    self notify("finished_use");

    if(isDefined(self.onenduse)) {
      self[[self.onenduse]](var_2, var_0, var_1);
    }
  }

  if(var_1) {
    if(isDefined(self.onuse)) {
      self[[self.onuse]](var_0);
      return;
    }

    return;
  }
}

function checkobjectiskeyobject(var_0) {
  var_1 = self.keyobject;

  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_3 in var_1) {
    if(var_3 istouching(self.trigger)) {
      return true;
    }
  }

  return false;
}

function checkplayercarrykeyobject(var_0) {
  var_1 = self.keyobject;

  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_3 in var_1) {
    if(var_3 == var_0.carryobject) {
      return true;
    }
  }

  return false;
}

function cantusehintthink() {
  level endon("game_ended");
  self endon("deleted");
  self endon("finished_use");
  jumpiftrue(isDefined(self.trigger)) LOC_00000020;
  return;
}

function getearliestclaimplayer() {
  var_0 = self.claimteam;
  var_1 = self.claimplayer;

  if(isDefined(self.playerzombiedestroyhud) && istrue(self.getinventoryslotvo)) {
    if(self.playerzombiedestroyhud[var_0].size > 0) {
      var_2 = undefined;
      var_3 = getarraykeys(self.playerzombiedestroyhud[var_0]);

      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        var_5 = self.playerzombiedestroyhud[var_0][var_3[var_4]];

        if(scripts\mp\utility\player::isreallyalive(var_5.player) && (!isDefined(var_2) || var_5.starttime < var_2)) {
          var_1 = var_5.player;
          var_2 = var_5.starttime;
        }
      }
    }

    self.getinventoryslotvo = 0;
    level endon("stop_watching_trigger");
    return var_1;
  }

  if(isDefined(self.touchlist[var_0]) && self.touchlist[var_0].size > 0) {
    var_2 = undefined;
    var_3 = getarraykeys(self.touchlist[var_0]);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = self.touchlist[var_0][var_3[var_4]];

      if(scripts\mp\utility\player::isreallyalive(var_5.player) && (!isDefined(var_2) || var_5.starttime < var_2)) {
        var_1 = var_5.player;
        var_2 = var_5.starttime;
      }
    }
  }

  return var_1;
}

function isteamtouching() {
  var_0 = "none";

  foreach(var_2 in level.teamnamelist) {
    if(self.numtouching[var_2]) {
      var_0 = var_2;
      break;
    }
  }

  return var_0 != "none";
}

function useobjectproxthink() {
  level endon("game_ended");
  self endon("deleted");
  thread proxtriggerthink();
  jumpiftrue(isDefined(self.ignorestomp)) LOC_00000024;
  self.ignorestomp = 0;

  for(;;) {
    if(self.interactteam == "none") {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      continue;
    }

    self.wasuncontested = 0;

    if(self.cancontestclaim) {
      if(self.stalemate != self.wasstalemate) {
        if(self.stalemate) {
          if(isDefined(self.oncontested)) {
            self[[self.oncontested]]();
          }
        } else {
          var_0 = "none";

          foreach(var_2 in level.teamnamelist) {
            if(self.numtouching[var_2]) {
              var_0 = var_2;
              break;
            }
          }

          if(var_0 == "none" && self.ownerteam != "neutral") {
            var_0 = self.ownerteam;
          }

          setclaimteam("none");
          self.claimplayer = undefined;

          foreach(var_0 in level.teamnamelist) {
            if(self.touchlist[var_0].size) {
              var_5 = self.touchlist[var_0];
              var_6 = getarraykeys(var_5);

              for(var_7 = 0; var_7 < var_6.size; var_7++) {
                var_8 = var_5[var_6[var_7]].player;
                var_8 setclientomnvar("ui_objective_state", 0);
              }

              break;
            }
          }

          if(isDefined(self.onuncontested)) {
            self[[self.onuncontested]](var_0);
          }

          self.wasuncontested = 1;
        }

        self.wasstalemate = self.stalemate;
      }

      if(!self.stalemate && self.majoritycapprogress != self.wasmajoritycapprogress) {
        self.wasmajoritycapprogress = self.majoritycapprogress;
      }
    }

    if(!self.stalemate && !self.majoritycapprogress && !self.wasuncontested) {
      if(self.mustmaintainclaim && !istrue(self.isunoccupied)) {
        if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam]) {
          if(isDefined(self.onunoccupied)) {
            self[[self.onunoccupied]]();
          }

          self.isunoccupied = 1;
          setclaimteam("none");
          self.claimplayer = undefined;
        } else if(self.ownerteam == "neutral") {
          if(!isteamtouching()) {
            if(isDefined(self.onunoccupied)) {
              self[[self.onunoccupied]]();
            }

            self.isunoccupied = 1;
            setclaimteam("none");
            self.claimplayer = undefined;
          } else if(isDefined(self.numtouchrequireduse)) {
            self[[self.numtouchrequireduse]](self.claimplayer.team);
          }
        }
      } else if(!istrue(self.isunoccupied) && isDefined(self.onunoccupied)) {
        var_0 = "none";

        foreach(var_2 in level.teamnamelist) {
          if(self.numtouching[var_2]) {
            var_0 = var_2;
            break;
          }
        }

        if(var_0 == "none") {
          self.isunoccupied = 1;
          self[[self.onunoccupied]]();
        }
      }
    }

    var_12 = 1;

    if(isDefined(self.numtouchrequired) && self.numtouchrequired > self.numtouching[self.claimteam]) {
      var_12 = 0;
    }

    if(self.claimteam != "none" && var_12) {
      if(!self.usetime) {
        if(!self.stalemate) {
          var_13 = getearliestclaimplayer();
          setclaimteam("none");
          self.claimplayer = undefined;

          if(isDefined(self.onuse)) {
            self[[self.onuse]](var_13);
          }
        }
      } else if(self.usetime && self.teamprogress[self.claimteam] >= self.usetime) {
        self.curprogress = 0;
        self.teamprogress[self.claimteam] = self.curprogress;
        var_13 = getearliestclaimplayer();
        setclaimteam("none");
        self.claimplayer = undefined;

        if(isDefined(self.onenduse)) {
          self[[self.onenduse]](self.claimteam, var_13, isDefined(var_13));
        }

        if(isDefined(var_13) && isDefined(self.onuse)) {
          self[[self.onuse]](var_13);
        }
      } else if(!self.stalemate && self.usetime && (self.ownerteam != self.claimteam || istrue(self.majoritycapprogress))) {
        if(!self.numtouching[self.claimteam]) {
          setclaimteam("none");
          self.claimplayer = undefined;

          if(isDefined(self.onenduse)) {
            self[[self.onenduse]](self.claimteam, self.claimplayer, 0);
          }
        } else if(canstompprogresswithstalemate(self.claimteam) && self.ownerteam == "neutral") {
          if(self.lastclaimteam == self.claimteam && istrue(self.majoritycapprogress)) {
            if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.claimteam] == 0) {
              stompenemyteamprogress(self.claimteam);
            } else {
              self.lastprogressteam = self.claimteam;
              applycaptureprogressanduseupdate();
            }
          }
        } else if(canstompprogress(self.claimteam) && self.ownerteam == "neutral" && self.lastclaimteam != self.claimteam) {
          if(self.lastclaimteam != self.claimteam) {
            if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.claimteam] == 0) {
              stompenemyteamprogress(self.claimteam);
            } else if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.lastprogressteam] > 0) {
              stompenemyteamprogress(self.claimteam);
            } else {
              self.lastprogressteam = self.claimteam;
              applycaptureprogressanduseupdate();
            }
          }
        } else if(canstompprogress(self.claimteam) && self.ownerteam == self.claimteam) {
          if(isDefined(self.lastprogressteam) && self.lastprogressteam == self.claimteam && self.teamprogress[self.claimteam] == 0) {
            stompenemyteamprogress(self.claimteam);
          } else if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.lastprogressteam] > 0 && self.teamprogress[self.claimteam] == 0) {
            stompenemyteamprogress(self.claimteam);
          }
        } else if(self.ownerteam != self.claimteam) {
          self.setblocking = 0;
          self.setdefending = 0;
          applycaptureprogressanduseupdate();
        } else if(self.ownerteam == self.claimteam && istrue(self.majoritycapprogress)) {
          var_14 = getnumtouchingexceptteam(self.claimteam);

          if(var_14 && !istrue(self.setblocking)) {
            self.setblocking = 1;
            self.setdefending = 0;
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS");
            scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
          } else if(!var_14 && !istrue(self.setdefending)) {
            self.setblocking = 0;
            self.setdefending = 1;
            setobjectivestatusicons(level.icondefending, level.iconcapture);
          }
        }
      }
    } else if(canstompprogress(self.ownerteam) && self.ownerteam != "neutral") {
      stompenemyteamprogress(self.ownerteam);
    }

    waitframe();
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

function canstompprogress(var_0) {
  return !istrue(self.ignorestomp) && self.touchlist[var_0].size > 0 && !istrue(self.stalemate) && self.curprogress > 0;
}

function canstompprogresswithstalemate(var_0) {
  return !istrue(self.ignorestomp) && self.touchlist[var_0].size > 0 && self.majoritycapprogress && self.curprogress > 0;
}

function applycaptureprogressanduseupdate() {
  if(isDefined(self.ref_128b9)) {
    var_0 = self[[self.ref_128b9]](1);

    if(!var_0) {
      return;
    }
  }

  applycaptureprogress(self.claimteam, level.frameduration * self.userate);

  if(isDefined(self.onuseupdate)) {
    self[[self.onuseupdate]](self.claimteam, self.teamprogress[self.claimteam] / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer);
  }

  if(isDefined(self.ref_12079)) {
    self[[self.ref_12079]](1);
    return;
  }
}

function stompenemyteamprogress(var_0) {
  if(isDefined(self.ref_138b2)) {
    self[[self.ref_138b2]](var_0);
  }

  var_1 = level.frameduration * self.userate;
  var_2 = scripts\mp\utility\teams::getenemyteams(var_0);

  foreach(var_4 in var_2) {
    var_5 = self.teamprogress[var_4];

    if(var_5 > 0) {
      if(var_5 < var_1) {
        self.teamprogress[var_4] = 0;
        self.curprogress = self.teamprogress[var_4];
        scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
        scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
        var_1 -= var_5;
        continue;
      }

      self.isunoccupied = 0;
      self.teamprogress[var_4] -= var_1;
      var_1 = 0;
      self.curprogress = self.teamprogress[var_4];
      scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_4);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_CLEARING_CAPS");
    }
  }

  if(self.curprogress <= 0) {
    foreach(var_8 in self.touchlist[self.ownerteam]) {
      if(isDefined(self.stompprogressreward)) {
        [[self.stompprogressreward]](var_8.player);
      }
    }

    self.lastprogressteam = undefined;
    return;
  }
}

function useobjectdecay(var_0) {
  if(getcapturebehavior() != "normal" && scripts\mp\utility\game::getgametype() != "arm") {
    return;
  }

  level endon("game_ended");
  self endon("deleted");
  self notify("useObjectDecay");
  self endon("useObjectDecay");
  var_1 = 0;

  for(;;) {
    waitframe();
    var_2 = self.objidnum;

    if(self.stalemate) {
      var_1 = 0;
    }

    if(self.claimteam == "none" || istrue(self.playerkilled_washitbyvehicle)) {
      if(self.usetime) {
        if(!self.stalemate) {
          if(istrue(self.decaygraceperiod) && var_1 < self.decaygraceperiod) {
            var_1 += level.framedurationseconds;
            continue;
          }

          if(isDefined(self.permcapturethresholds)) {
            if(!isDefined(self.decaythreshold)) {
              self.decaythreshold = 0;
            }

            var_3 = self.curprogress / self.usetime;

            foreach(var_5 in self.permcapturethresholds) {
              if(var_3 >= var_5 && var_5 > self.decaythreshold) {
                self.decaythreshold = var_5;
              }
            }

            if(!isDefined(self.decayrate)) {
              self.decayrate = self.usetime * 0.025 * level.framedurationseconds;
            }

            if(var_3 > self.decaythreshold) {
              self.curprogress -= self.decayrate;
            }
          } else {
            var_7 = 1;

            if(isDefined(self.forest_barrels)) {
              var_7 = [[self.forest_barrels]]();
            }

            self.curprogress -= 0.1 * var_7 * level.frameduration;

            if(isDefined(self.ref_12079)) {
              self[[self.ref_12079]](0);
            }
          }
        }

        self.teamprogress[var_0] = self.curprogress;
      }

      if(self.teamprogress[var_0] <= 0) {
        self.curprogress = 0;
        self.teamprogress[var_0] = self.curprogress;
        scripts\mp\objidpoolmanager::objective_show_progress(var_2, 0);
        break;
      }

      scripts\mp\hostmigration::waittillhostmigrationdone();

      if(isDefined(self.objidnum)) {
        if(isDefined(self.overrideprogressteam)) {
          var_3 = self.teamprogress[self.overrideprogressteam] / self.usetime;
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, var_3);
        } else {
          var_3 = self.teamprogress[self.lastclaimteam] / self.usetime;
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, var_3);
        }
      }
    }
  }
}

function canclaim(var_0) {
  if(isDefined(self.carrier)) {
    return false;
  }

  if(self.cancontestclaim) {
    var_1 = getnumtouchingforteam(var_0.pers["team"]);
    var_2 = getnumtouchingexceptteam(var_0.pers["team"]);

    if(var_1 && !var_2 || var_1 && var_2 && var_1 != var_2 && !istrue(self.ref_133a5)) {
      self.majoritycapprogress = 1;
      self.wasmajoritycapprogress = 0;
      return true;
    }

    if(var_1 && var_2 && (var_1 == var_2 || istrue(self.ref_133a5))) {
      self.stalemate = 1;
      self.majoritycapprogress = 0;
      self.wasmajoritycapprogress = 1;
      return false;
    }
  }

  if(!isDefined(self.keyobject)) {
    return true;
  }

  if(isDefined(self.nocarryobject)) {
    if(checkobjectiskeyobject(var_0)) {
      return true;
    }
  }

  if(isDefined(var_0.carryobject)) {
    if(checkplayercarrykeyobject(var_0)) {
      return true;
    }
  }

  return false;
}

function proxtriggerthink() {
  level endon("game_ended");
  self endon("deleted");
  var_0 = self.entnum;

  for(;;) {
    self.trigger waittill("trigger", var_1);

    if(istrue(self.brking_givepoints)) {
      if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
        if(!istrue(var_1.isempty) && isDefined(var_1.occupants["driver"])) {
          var_1 = var_1.occupants["driver"];
        }
      }
    }

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }

    if(istrue(self.trigger.trigger_off)) {
      continue;
    }

    if(isagent(var_1)) {
      continue;
    }

    if(!scripts\mp\utility\entity::isgameparticipant(var_1)) {
      continue;
    }

    if(isDefined(self.carrier)) {
      continue;
    }

    if(istrue(self.tv_station_gas_rise) && (var_1 scripts\mp\utility\player::isusingremote() || isDefined(var_1.spawningafterremotedeath))) {
      continue;
    }

    if(istrue(var_1.inlaststand) && !istrue(self.trigger.brkillstreakbeginusefunc)) {
      continue;
    }

    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }

    if(!isDefined(var_1.initialized_gameobject_vars)) {
      continue;
    }

    if(isDefined(self.usecondition)) {
      if(!self[[self.usecondition]](var_1)) {
        continue;
      }
    }

    var_2 = getrelativeteam(var_1.pers["team"]);

    if(isDefined(self.teamusetimes[var_2]) && self.teamusetimes[var_2] < 0) {
      continue;
    }

    if(scripts\mp\utility\player::isreallyalive(var_1) && !isDefined(var_1.touchtriggers[var_0])) {
      var_3 = var_1.pers["team"];
      self.numtouching[var_3]++;
      var_4 = var_1.guid;
      var_5 = spawnStruct();
      var_5.player = var_1;
      var_5.starttime = gettime();
      self.touchlist[var_3][var_4] = var_5;

      if(isDefined(self.assisttouchlist)) {
        if(!isDefined(self.assisttouchlist[var_3][var_4])) {
          self.assisttouchlist[var_3][var_4] = var_5;
        }
      }
    }

    if(self.cancontestclaim) {
      var_6 = getnumtouchingforteam(var_1.pers["team"]);
      var_7 = getnumtouchingexceptteam(var_1.pers["team"]);

      if(var_6 && !var_7 || var_6 && var_7 && var_6 != var_7) {
        self.majoritycapprogress = 1;
        self.isunoccupied = 0;
      }
    }

    if(self.claimteam == "none" || !istrue(self.allowcapture) || istrue(self.majoritycapprogress)) {
      if(caninteractwith(var_1.pers["team"], var_1)) {
        if(canclaim(var_1)) {
          if(!proxtriggerlos(var_1)) {
            continue;
          }

          if(istrue(self.majoritycapprogress)) {
            if(isDefined(self.mostnumtouching) && isDefined(self.mostnumtouchingteam)) {
              setclaimteam(self.mostnumtouchingteam);
              var_8 = getearliestclaimplayer();
              self.claimplayer = var_8;
            }
          } else {
            setclaimteam(var_1.pers["team"]);
            self.claimplayer = var_1;
          }

          if(isDefined(self.teamusetimes[var_2])) {
            self.usetime = self.teamusetimes[var_2];
          }

          self.allowcapture = 1;

          if(isDefined(self.numtouchrequired) && self.numtouchrequired > self.numtouching[self.claimteam]) {
            self.allowcapture = 0;
          }

          if(self.usetime && isDefined(self.onbeginuse) && self.allowcapture && self.ownerteam != self.claimteam) {
            self.isunoccupied = 0;

            if(isDefined(self.didstatusnotify) && !self.didstatusnotify) {
              self[[self.onbeginuse]](self.claimplayer);
            } else if(!isDefined(self.didstatusnotify)) {
              self[[self.onbeginuse]](self.claimplayer);
            }
          }
        } else if(isDefined(self.oncantuse)) {
          self[[self.oncantuse]](var_1);
        }
      }
    }

    if(scripts\mp\utility\player::isreallyalive(var_1) && !isDefined(var_1.touchtriggers[var_0])) {
      thread triggertouchthink(var_1);
    }
  }
}

function proxtriggerlos(var_0) {
  if(!isDefined(self.requireslos)) {
    return true;
  }

  var_1 = var_0 getEye();
  var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  var_3 = [];

  if(scripts\mp\utility\game::getgametype() == "tdef" || istrue(level.devball)) {
    var_4 = self.trigger.origin + (0, 0, 16);
    var_5 = 0;
    var_3 = self.visuals[0];
  } else if(scripts\mp\utility\game::getgametype() == "ball" || istrue(level.debughostagegame)) {
    var_4 = self.trigger.origin + (0, 0, 8);
    var_5 = 0;
    var_5 = self.visuals[0];
  } else {
    var_4 = self.trigger.origin + (0, 0, 32);
    var_5 = 1;
    var_5 = self.visuals;
  }

  var_5 = self.carrier;
  var_6 = scripts\engine\trace::ray_trace(var_5, var_4, var_5, var_4, 0);

  if(var_6["fraction"] != 1 && var_5) {
    var_4 = self.trigger.origin + (0, 0, 16);
    var_6 = scripts\engine\trace::ray_trace(var_5, var_4, var_5, var_4, 0);
  }

  if(var_6["fraction"] != 1) {
    var_4 = self.trigger.origin + (0, 0, 0);
    var_6 = scripts\engine\trace::ray_trace(var_5, var_4, var_5, var_4, 0);
  }

  return var_6["fraction"] == 1;
}

function setclaimteam(var_0) {
  if(getcapturebehavior() == "normal") {
    if(!isDefined(self.claimgracetime)) {
      self.claimgracetime = 1000;
    }

    if(!istrue(self.ignorestomp) && scripts\mp\utility\teams::isgameplayteam(var_0)) {
      if(self.lastclaimteam != "none") {
        if(!isDefined(self.lastprogressteam)) {
          self.lastprogressteam = self.lastclaimteam;
        }
      }
    }
  }

  self.lastclaimteam = self.claimteam;
  self.lastclaimtime = gettime();
  self.claimteam = var_0;
  updateuserate();
}

function getclaimteam() {
  return self.claimteam;
}

function getlastclaimteam() {
  return self.lastclaimteam;
}

function triggertouchthink(var_0) {
  var_1 = self.pers["team"];

  if(istrue(var_0.pinobj)) {
    scripts\mp\objidpoolmanager::objective_pin_player(var_0.objidnum, self);
    self.pinnedobjid = var_0.objidnum;

    if(isDefined(var_0.onpinnedstate)) {
      var_0[[var_0.onpinnedstate]]();
    }
  }

  if(!isDefined(self.touchinggameobjects)) {
    self.touchinggameobjects = [];
  }

  var_2 = var_0.trigger getentitynumber();
  self.touchinggameobjects[var_2] = var_0;

  if(!isDefined(var_0.nousebar)) {
    var_0.nousebar = 0;
  }

  self.touchtriggers[var_0.entnum] = var_0.trigger;
  updateuserate(var_0);

  while(scripts\mp\utility\player::isreallyalive(self) && isDefined(var_0.trigger) && self istouching(var_0.trigger) && !level.gameended) {
    if(isDefined(var_0.checkinteractteam) && var_0.team != var_1) {
      break;
    }

    if(istrue(self.inlaststand) && !istrue(var_0.trigger.brkillstreakbeginusefunc)) {
      break;
    }

    if(isDefined(var_0.interactsquads) && !isDefined(var_0.interactsquads[self.team]) || isDefined(var_0.interactsquads) && !scripts\engine\utility::array_contains(var_0.interactsquads[self.team], self.squadindex)) {
      break;
    }

    if(istrue(var_0.trigger.trigger_off)) {
      break;
    }

    if(istrue(var_0.getrandompointincirclewithindistance) && isDefined(var_0.usecondition) && !var_0[[var_0.usecondition]](self)) {
      break;
    }

    if(!scripts\mp\utility\player::isusingremote() && istrue(self.remoteunpinned)) {
      scripts\mp\objidpoolmanager::objective_pin_player(var_0.objidnum, self);
      self.remoteunpinned = undefined;
    }

    if(isPlayer(self) && var_0.usetime > 50) {
      updateuiprogress(var_0, 1);
    }

    waitframe();
  }

  if(isDefined(self)) {
    if(var_0.usetime > 50) {
      if(isPlayer(self)) {
        updateuiprogress(var_0, 0);
      }

      self.touchtriggers[var_0.entnum] = undefined;
    } else {
      self.touchtriggers[var_0.entnum] = undefined;
    }

    self.touchinggameobjects[var_2] = undefined;
  }

  if(level.gameended) {
    return;
  }

  var_0.oldtouchlist = var_0.touchlist;

  if(isDefined(var_0.touchlist[var_1])) {
    if(isDefined(self)) {
      var_0.touchlist[var_1][self.guid] = undefined;
    } else {
      var_3 = [];

      foreach(var_6, var_5 in var_0.touchlist[var_1]) {
        if(!isDefined(var_5.player)) {
          var_3 = var_6;
        }
      }

      foreach(var_6 in var_3) {
        var_0.touchlist[var_1][var_6] = undefined;
      }
    }
  }

  if(isDefined(self) && isDefined(var_0.objidnum)) {
    scripts\mp\objidpoolmanager::objective_unpin_player(var_0.objidnum, self, var_0.showoncompass);
    self.pinnedobjid = undefined;

    if(var_0.lastclaimteam == "none") {
      if(isDefined(var_0.capturebehavior) && var_0.capturebehavior == "persistent") {
        scripts\mp\objidpoolmanager::objective_show_progress(var_0.objidnum, 0);
      }
    }
  }

  var_0.numtouching[var_1]--;
  updateuserate(var_0);

  if(isDefined(var_0.onunpinnedstate)) {
    var_0[[var_0.onunpinnedstate]]();
    return;
  }
}

function migrationcapturereset(var_0) {
  var_0.migrationcapturereset = 1;
  level waittill("host_migration_begin");

  if(!isDefined(var_0) || !isDefined(self)) {
    return;
  }

  var_0 setclientomnvar("ui_securing", 0);
  var_0 setclientomnvar("ui_securing_progress", 0);
  self.migrationcapturereset = undefined;
}

function getnumtouchingforteam(var_0) {
  return self.numtouching[var_0];
}

function getnumtouchingexceptteam(var_0) {
  var_1 = 0;
  var_2 = 0;
  self.mostnumtouching = 0;
  self.mostnumtouchingteam = "none";

  foreach(var_4 in level.teamnamelist) {
    if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_4)) {
      continue;
    }

    var_2 += self.numtouching[var_4];

    if(var_2 > 0 && var_2 > self.mostnumtouching) {
      self.mostnumtouching = var_2;
      self.mostnumtouchingteam = var_4;
      var_2 = 0;
    }

    if(var_4 != var_0) {
      var_1 += self.numtouching[var_4];
    }
  }

  return var_1;
}

function updateuiprogress(var_0, var_1, var_2) {
  if(!isDefined(level.hostmigrationtimer)) {
    if(isDefined(var_0.interactteam) && var_0.interactteam == "none") {
      self setclientomnvar("ui_objective_state", 0);
      return;
    }

    if(!isDefined(var_2)) {
      var_2 = var_0;
    }

    var_3 = undefined;

    if(isDefined(var_0.objidnum)) {
      var_3 = var_0.objidnum;
    }

    var_4 = 0;

    if(isDefined(var_0.teamprogress) && isDefined(var_0.claimteam)) {
      if(var_0.teamprogress[var_0.claimteam] > var_2.usetime) {
        var_0.teamprogress[var_0.claimteam] = var_2.usetime;
      }

      var_4 = var_0.teamprogress[var_0.claimteam] / var_2.usetime;
    } else {
      if(var_2.curprogress > var_2.usetime) {
        var_2.curprogress = var_2.usetime;
      }

      var_4 = var_2.curprogress / var_2.usetime;

      if(var_2.usetime <= 1000) {
        var_4 = min(var_4 + 0.05, 1);
      } else {
        var_4 = min(var_4 + 0.01, 1);
      }
    }

    if((scripts\mp\utility\game::getgametype() == "ctf" || scripts\mp\utility\game::getgametype() == "tdef" || scripts\mp\utility\game::getgametype() == "blitz") && !isDefined(var_0.id)) {
      if(var_1 && istrue(var_0.stalemate)) {
        if(!isDefined(self.ui_ctf_stalemate)) {
          if(!isDefined(self.ui_ctf_securing)) {
            self.ui_ctf_securing = 1;
          }

          self setclientomnvar("ui_objective_state", -1);
          self.ui_ctf_stalemate = 1;
        }

        var_4 = 0.01;
      } else if(var_1 && isDefined(self.ui_ctf_securing) && isDefined(var_0.stalemate) && !var_0.stalemate && var_0.ownerteam != self.team) {
        self setclientomnvar("ui_objective_state", 1);
        self.ui_ctf_securing = 1;
        self.ui_ctf_stalemate = undefined;
      } else if(var_1 && isDefined(self.ui_ctf_securing) && isDefined(var_0.stalemate) && !var_0.stalemate && var_0.ownerteam == self.team) {
        self setclientomnvar("ui_objective_state", 2);
        self.ui_ctf_securing = 1;
        self.ui_ctf_stalemate = undefined;
      } else {
        if(!var_1 && isDefined(self.ui_ctf_stalemate)) {
          self setclientomnvar("ui_objective_state", 0);
          self.ui_ctf_securing = undefined;
        }

        if(var_1 && !isDefined(self.ui_ctf_stalemate) && var_0.ownerteam == self.team) {
          self setclientomnvar("ui_objective_state", 0);
          self.ui_ctf_securing = undefined;
        }

        if(var_1 && !isDefined(self.ui_ctf_securing)) {
          if(var_0.ownerteam != self.team) {
            self setclientomnvar("ui_objective_state", 1);
            self.ui_ctf_securing = 1;
          } else if(var_0.interactteam == "any") {
            self setclientomnvar("ui_objective_state", 2);
            self.ui_ctf_securing = 1;
          }
        }

        self.ui_ctf_stalemate = undefined;
      }

      if(!var_1) {
        var_4 = 0.01;
        self setclientomnvar("ui_objective_state", 0);
        self.ui_ctf_securing = undefined;
      }

      if(var_4 != 0) {
        scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, self.team);
        scripts\mp\objidpoolmanager::objective_show_progress(var_3, 1);
        scripts\mp\objidpoolmanager::objective_set_progress(var_3, var_4);
      }
    }

    if(hasdomflags() && isDefined(var_0.id) && (var_0.id == "domFlag" || var_0.id == "hardpoint" || var_0.id == "bomb_site" || var_0.id == "rugby_jugg")) {
      if(var_1 && isDefined(var_0.stalemate) && var_0.stalemate && !istrue(var_0.majoritycapprogress)) {
        if(!isDefined(self.ui_dom_stalemate)) {
          if(!isDefined(self.ui_dom_securing)) {
            self.ui_dom_securing = 1;
          }

          self.ui_dom_stalemate = 1;
          self setclientomnvar("ui_objective_state", 3);
        }
      } else if(var_1 && isDefined(self.ui_dom_securing) && isDefined(var_0.stalemate) && !var_0.stalemate && !istrue(var_0.majoritycapprogress) && var_0.ownerteam != self.team) {
        self.ui_dom_securing = 1;
        self.ui_dom_stalemate = undefined;

        if(scripts\mp\utility\game::getgametype() == "hq") {
          if(var_0.ownerteam == "neutral") {
            self setclientomnvar("ui_objective_state", 1);
          } else {
            self setclientomnvar("ui_objective_state", 2);
          }
        } else if(istrue(var_0.neutralizing) && var_0.ownerteam != self.team && var_0.ownerteam != "neutral") {
          self setclientomnvar("ui_objective_state", var_0 scripts\mp\gametypes\obj_dom::relic_nuketimer_timerloop());
        } else {
          self setclientomnvar("ui_objective_state", 1);
        }
      } else {
        if(!var_1 && isDefined(self.ui_dom_stalemate)) {
          if(isDefined(var_0.overrideprogressteam)) {
            scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, var_0.overrideprogressteam);
          } else if(isDefined(var_0.lastprogressteam) && var_0.lastprogressteam != var_0.claimteam) {
            scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, var_0.lastprogressteam);
          } else if(var_0.claimteam != "none") {
            scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, var_0.claimteam);
          }

          self.ui_dom_securing = undefined;
          self setclientomnvar("ui_objective_state", 0);
        } else if(var_1 && istrue(var_0.majoritycapprogress) && isDefined(var_0.lastprogressteam) && var_0.lastprogressteam == var_0.claimteam) {
          if(isDefined(var_0.overrideprogressteam)) {
            scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, var_0.overrideprogressteam);
          } else if(var_0.ownerteam != "neutral" && var_0.claimteam == var_0.ownerteam) {
            self setclientomnvar("ui_objective_state", 0);
          } else if(var_0.claimteam != "none") {
            if(istrue(level.spawn_lot_paratroopers)) {} else if(scripts\mp\utility\game::getgametype() == "hq") {
              if(var_0.ownerteam == "neutral") {
                self setclientomnvar("ui_objective_state", 1);
              } else {
                self setclientomnvar("ui_objective_state", 2);
              }
            } else if(istrue(var_0.neutralizing) && var_0.ownerteam != self.team && var_0.ownerteam != "neutral") {
              self setclientomnvar("ui_objective_state", var_0 scripts\mp\gametypes\obj_dom::relic_nuketimer_timerloop());
            } else {
              self setclientomnvar("ui_objective_state", 1);
            }

            scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, var_0.claimteam);
          }
        } else if(scripts\mp\utility\game::getgametype() == "rugby") {
          if(!isDefined(var_0.claimteam) || var_0.claimteam == "none") {
            var_0.numtouching[self.team] = 1;

            if(!isDefined(var_0.lastclaimteam)) {
              var_0.lastclaimteam = "none";
            }

            setclaimteam(var_0, self.pers["team"]);
            setownerteam(var_0, self.pers["team"]);
          }

          if(var_1) {
            if(var_0.claimteam != "none") {
              self setclientomnvar("ui_objective_state", 1);
              scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, var_0.claimteam);
              scripts\mp\objidpoolmanager::objective_show_progress(var_3, 1);
              scripts\mp\objidpoolmanager::objective_set_progress(var_0.objidnum, var_4);
            }
          } else {
            var_0.claimteam = "none";
          }
        }

        if(var_1 && !isDefined(self.ui_dom_stalemate) && var_0.ownerteam == self.team) {
          self.ui_dom_securing = undefined;
          self setclientomnvar("ui_objective_state", 0);
        }

        if(var_1 && !isDefined(self.ui_dom_securing) && var_0.ownerteam != self.team) {
          self.ui_dom_securing = 1;
        }

        self.ui_dom_stalemate = undefined;
      }

      if(scripts\mp\utility\game::getgametype() != "rush") {
        if(!var_1 || !caninteractwith(var_0, self.team, self) && (!isDefined(var_0.stalemate) || isDefined(var_0.stalemate) && !var_0.stalemate)) {
          if(var_2.curprogress == 0) {
            scripts\mp\objidpoolmanager::objective_show_progress(var_3, 0);
          }

          self.ui_dom_securing = undefined;
          self setclientomnvar("ui_objective_state", 0);
        }
      }

      if(var_4 != 0) {
        if(showspecificteamprogress(var_0)) {
          scripts\mp\objidpoolmanager::objective_show_team_progress(var_3, var_0.claimteam);
        } else {
          scripts\mp\objidpoolmanager::objective_show_progress(var_3, 1);
        }

        if(level.teambased && isDefined(var_0.teamprogress) && isDefined(var_0.claimteam) && var_1) {
          if(!var_0.stalemate) {
            if(isDefined(var_0.overrideprogressteam)) {
              scripts\mp\objidpoolmanager::objective_set_progress_team(var_0.objidnum, var_0.overrideprogressteam);
              scripts\mp\objidpoolmanager::objective_set_progress(var_0.objidnum, var_0.teamprogress[var_0.overrideprogressteam] / var_2.usetime);
            } else {
              scripts\mp\objidpoolmanager::objective_set_progress_team(var_0.objidnum, var_0.claimteam);
              scripts\mp\objidpoolmanager::objective_set_progress(var_0.objidnum, var_4);
            }

            if(self.team == var_0.claimteam) {
              if(istrue(level.spawn_lot_paratroopers)) {
                return;
              }

              if(scripts\mp\utility\game::getgametype() == "hq") {
                if(var_0.ownerteam == "neutral") {
                  self setclientomnvar("ui_objective_state", 1);
                  return;
                }

                self setclientomnvar("ui_objective_state", 2);
                return;
              }

              if(istrue(var_0.neutralizing) && var_0.ownerteam != self.team && var_0.ownerteam != "neutral") {
                self setclientomnvar("ui_objective_state", var_0 scripts\mp\gametypes\obj_dom::relic_nuketimer_timerloop());
                return;
              }

              self setclientomnvar("ui_objective_state", 1);
              return;
            }

            self setclientomnvar("ui_objective_state", 5);
            return;
          }

          if(var_0.stalemate && istrue(var_0.majoritycapprogress)) {
            scripts\mp\objidpoolmanager::objective_set_progress_team(var_0.objidnum, var_0.claimteam);
            scripts\mp\objidpoolmanager::objective_set_progress(var_0.objidnum, var_4);

            if(self.team == var_0.claimteam) {
              if(scripts\mp\utility\game::getgametype() == "hq") {
                if(var_0.ownerteam == "neutral") {
                  self setclientomnvar("ui_objective_state", 1);
                  return;
                }

                self setclientomnvar("ui_objective_state", 2);
                return;
              }

              if(istrue(var_0.neutralizing) && var_0.ownerteam != self.team && var_0.ownerteam != "neutral") {
                self setclientomnvar("ui_objective_state", 6);
                return;
              }

              self setclientomnvar("ui_objective_state", 1);
              return;
            }

            self setclientomnvar("ui_objective_state", 5);
            return;
          }

          scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, undefined);
          return;
        }

        if(!level.teambased) {
          scripts\mp\objidpoolmanager::objective_set_progress_client(var_3, self);
          return;
        }

        return;
      }

      return;
    }

    if(isbombmode() && isDefined(var_0.id) && (var_0.id == "bomb_zone" || var_0.id == "defuse_object")) {
      if(isDefined(self)) {
        if(var_1 && isDefined(self)) {
          if(!isDefined(self.ui_bomb_planting_defusing)) {
            var_5 = 0;

            if(var_0.id == "bomb_zone") {
              var_5 = 1;
            } else if(var_0.id == "defuse_object") {
              var_5 = 2;
            }

            self.ui_bomb_planting_defusing = 1;
          }
        } else {
          self.ui_bomb_planting_defusing = undefined;

          if(!isDefined(var_0.resetprogress) || istrue(var_0.resetprogress)) {
            var_4 = 0.01;
          }
        }

        if(var_4 != 0) {
          if(!isDefined(var_0.showprogressforteam)) {
            scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, self.team);
            scripts\mp\objidpoolmanager::objective_show_team_progress(var_3, self.team);
            var_0.showprogressforteam = self.team;
          }

          scripts\mp\objidpoolmanager::objective_set_progress(var_3, var_4);
          setomnvar("ui_bomb_progress", var_4);
          return;
        }

        return;
      }

      return;
    }

    if(isDefined(var_0.id)) {
      var_5 = 0;

      switch (var_0.id) {
        case "care_package":
        case "bradley":
          var_5 = 1;
          break;
        case "intel":
          var_5 = 2;
          break;
        case "support_box":
          var_5 = 3;
          break;
        case "deployable_weapon_crate":
          var_5 = 4;
          break;
        case "laststand_reviver":
          var_5 = 5;
          break;
        case "laststand_revivee":
          var_5 = 6;
          break;
        case "breach":
          var_5 = 7;
          break;
        case "use":
          var_5 = 8;
          break;
        case "breach_defuse":
          var_5 = 9;
          break;
        case "bounty":
          var_5 = 10;
          break;
        case "hack":
          var_5 = 13;
          break;
        case "hvt_search":
          var_5 = 15;
          break;
        case "build":
          var_5 = 21;
          break;
        case "destroy":
          var_5 = 22;
          break;
        case "weapon_trade":
          var_5 = 23;
          break;
        case "planting_explosive":
          var_5 = 24;
          break;
      }

      updateuisecuring(var_4, var_1, var_5, var_0, var_2.usetime);
      return;
    }

    return;
  }
}

function showspecificteamprogress(var_0) {
  switch (scripts\mp\utility\game::getgametype()) {
    case "vip":
      if(var_0.claimteam == game["attackers"]) {
        return true;
      }

      break;
  }

  return false;
}

function hasdomflags() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "cmd":
    case "grnd":
    case "grind":
    case "koth":
    case "defcon":
    case "rugby":
    case "rush":
    case "btm":
    case "hq":
    case "pill":
    case "mtmc":
    case "siege":
    case "dom":
    case "arena":
    case "br":
    case "arm":
      return true;
    default:
      return false;
  }

  return false;
}

function updateuisecuring(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(var_1) {
    if(!isDefined(var_3.usedby)) {
      var_3.usedby = [];
    }

    if(!isDefined(self.migrationcapturereset)) {
      thread migrationcapturereset(var_3);
    }

    if(!existinarray(self, var_3.usedby)) {
      var_3.usedby[var_3.usedby.size] = self;
    }

    if(!isDefined(self.ui_securing)) {
      self setclientomnvar("ui_securing", var_2);
      self.ui_securing = 1;

      if(isDefined(var_3.trigger) && isrevivetrigger(var_3.trigger)) {
        if(isDefined(var_3.trigger.owner)) {
          var_3.trigger.owner setclientomnvar("ui_reviver_id", self getentitynumber());
          var_3.trigger.owner setclientomnvar("ui_securing", 6);
        }
      }
    }

    if(scripts\mp\utility\game::getgametype() == "br" && var_3.id == "laststand_reviver") {
      var_6 = undefined;

      if(isDefined(var_3.trigger) && isrevivetrigger(var_3.trigger)) {
        var_6 = var_3.trigger.owner;
      }

      if(isDefined(var_6) && self == var_6) {
        self setclientomnvar("ui_securing", 16);
      }

      scripts\mp\gametypes\br::ref_1401f(var_6, self, var_0);
    }
  } else {
    if(isDefined(var_3.usedby) && existinarray(self, var_3.usedby)) {
      var_3.usedby = scripts\engine\utility::array_remove(var_3.usedby, self);
    }

    self setclientomnvar("ui_securing", 0);
    self.ui_securing = undefined;

    if(isDefined(var_3.trigger) && isrevivetrigger(var_3.trigger)) {
      if(isDefined(var_3.trigger.owner)) {
        var_3.trigger.owner setclientomnvar("ui_reviver_id", -1);
        var_3.trigger.owner setclientomnvar("ui_securing", 0);
      }
    }

    var_0 = 0.01;

    if(isDefined(var_3.objidnum)) {
      var_5 = var_3.objidnum;
    }
  }

  if(var_4 == 500) {
    var_0 = min(var_0 + 0.15, 1);
  }

  if(var_0 != 0) {
    self setclientomnvar("ui_securing_progress", var_0);

    if(isDefined(var_3.trigger) && isrevivetrigger(var_3.trigger)) {
      if(isDefined(var_3.trigger.owner)) {
        var_3.trigger.owner setclientomnvar("ui_securing_progress", var_0);
      }
    }

    if(isDefined(var_3.objidnum) && !istrue(var_3.skipupdateobjectiveprogress)) {
      scripts\mp\objidpoolmanager::objective_set_progress(var_3.objidnum, var_0);
      return;
    }

    return;
  }
}

function existinarray(var_0, var_1) {
  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(var_3 == var_0) {
        return true;
      }
    }
  }

  return false;
}

function updateuserate() {
  if(self.claimteam == "none" && self.ownerteam != "neutral" && self.ownerteam != "any") {
    var_0 = self.ownerteam;
  } else {
    var_0 = self.claimteam;
  }

  var_1 = self.numtouching[var_0];
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in level.teamnamelist) {
    if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_5)) {
      continue;
    }

    if(var_0 != var_5) {
      var_2 += self.numtouching[var_5];
    }
  }

  if(isDefined(self.touchlist[var_0])) {
    foreach(var_8 in self.touchlist[var_0]) {
      if(!isDefined(var_8.player)) {
        continue;
      }

      if(var_8.player.pers["team"] != var_0) {
        continue;
      }

      if(var_8.player.objectivescaler == 1) {
        continue;
      }

      var_1 *= var_8.player.objectivescaler;
      var_3 = var_8.player.objectivescaler;
    }
  }

  if(!istrue(self.ref_133e5)) {
    self.stalemate = scripts\engine\utility::ter_op(istrue(self.alwaysstalemate), var_1 && var_2, var_1 && var_2 && var_1 == var_2);
  }

  if(!var_1 && !var_2) {
    self.majoritycapprogress = 0;
  }

  if(isDefined(self.triggertype) && self.triggertype == "use") {} else {
    self.userate = 0;
  }

  if(var_1) {
    if(var_1 > var_2) {
      self.userate = min(var_1 - var_2, scripts\engine\utility::ter_op(isDefined(level.objectivescaler), level.objectivescaler, 4));

      if(self.userate > 1) {
        self.userate *= self.useratemultiplier;
      }
    }
  }

  if(isDefined(self.isarena) && self.isarena && var_3 != 0) {
    self.userate = 1 * var_3;
    return;
  }

  if(isDefined(self.isarena) && self.isarena) {
    self.userate = 1;
    return;
  }
}

function useholdthink(var_0) {
  var_0 notify("use_hold");

  if(self.exclusiveuse) {
    var_0 clientclaimtrigger(self.trigger);
  }

  var_0 allowmovement(0);
  var_1 = isDefined(self.id) && (self.id == "traversalassist" || self.id == "breach" || self.id == "care_package");

  if(isbombmode()) {
    if(var_1 || level.gametype == "cyber") {} else if(scripts\mp\utility\game::isanymlgmatch() || istrue(level.silentplant)) {
      var_0 setentitysoundcontext("silent_plant", "on");

      if(istrue(var_0.isdefusing)) {
        self.useweapon = getcompleteweaponname("briefcase_defuse_silent_mp");
      } else {
        self.useweapon = getcompleteweaponname("briefcase_silent_mp");
      }
    }
  }

  var_2 = self.useweapon;
  var_3 = var_0 getcurrentweapon();

  if(isDefined(var_2)) {
    var_4 = 0;

    if(var_3.basename == "iw8_cyberemp_mp") {
      var_4 = 1;
    }

    if(var_3 == var_2) {
      var_3 = var_0.lastnonuseweapon;
    }

    var_0.lastnonuseweapon = var_3;
    var_5 = 0;
    var_6 = 0;

    if(scripts\mp\utility\game::getgametype() == "cyber") {
      var_5 = 1;
      var_6 = 0;
    }

    var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2, undefined, undefined, 0);
    var_0 setweaponammostock(var_2, var_5);
    var_0 setweaponammoclip(var_2, var_5);
    thread switchtouseweapon(var_0, var_2);
  } else if(!var_1) {
    if(isDefined(self.trigger) && isrevivetrigger(self.trigger) || isDefined(self.id) && self.id == "rugby_jugg") {
      if(!var_0 scripts\mp\utility\perk::_hasperk("specialty_revive_use_weapon")) {
        var_0.weaponsdisabledwhilereviving = 1;

        if(!level.allowreviveweapons) {
          thread playerplunderdepositcallback(var_0);
          var_0 scripts\common\utility::allow_sprint(0);
          var_0 scripts\common\utility::allow_fire(0);
          var_0 scripts\common\utility::allow_ads(0);
          var_0 scripts\common\utility::allow_offhand_weapons(0);
        } else {
          var_0 scripts\mp\playeractions::allowactionset("reviveShoot", 0);
        }
      }
    } else {
      var_0 scripts\common\utility::allow_weapon(0);
    }
  }

  if(!isDefined(var_0.usinggameobjects)) {
    var_0.usinggameobjects = [];
  }

  var_7 = self.trigger getentitynumber();
  var_0.usinggameobjects[var_7] = self;

  if(!isDefined(self.resetprogress) || istrue(self.resetprogress)) {
    self.curprogress = 0;
  }

  self.inuse = 1;
  self.userate = 0;
  var_8 = useholdthinkloop(var_0, var_3);

  if(isDefined(var_0)) {
    var_0.usinggameobjects[var_7] = undefined;
    detachusemodels(var_0);
    var_0 notify("done_using");
  }

  if(isDefined(var_2) && isDefined(var_0)) {
    if(scripts\mp\utility\game::getgametype() == "cyber" && !isrevivetrigger() && !istrue(var_8)) {
      var_0 setweaponammostock(var_2, 0);
      var_0 setweaponammoclip(var_2, 0);
    }

    var_0 scripts\mp\supers::unstowsuperweapon();

    if(var_0 scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_2)) {
      var_0 scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_2);
      var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_3);
    } else if(scripts\mp\utility\game::getgametype() == "sd") {
      if(!istrue(var_8)) {
        var_0 setweaponammostock(var_2, 1);
        var_0 setweaponammoclip(var_2, 1);
      }

      if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
        var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
        var_0 scripts\mp\utility\inventory::switchtolastweapon();
      } else {
        var_0 thread scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);
      }
    } else if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
      var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
      var_0 scripts\mp\utility\inventory::switchtolastweapon();
    } else {
      var_0 thread scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);
    }
  }

  if(istrue(var_8)) {
    var_0 allowmovement(1);
    return true;
  } else if(!istrue(var_8)) {
    if(!isDefined(self.resetprogress) || istrue(self.resetprogress)) {
      self.curprogress = 0;
    } else {
      managecurprogress(var_0);
    }
  }

  if(isDefined(var_0)) {
    if(!isDefined(var_2) && !var_1) {
      if(isDefined(self.trigger) && isrevivetrigger(self.trigger) || isDefined(self.id) && self.id == "rugby_jugg") {
        if(istrue(var_0.weaponsdisabledwhilereviving)) {
          var_0.weaponsdisabledwhilereviving = undefined;

          if(!level.allowreviveweapons) {
            thread playerplunderdepositcallback(var_0);
            var_0 scripts\common\utility::allow_sprint(1);
            var_0 scripts\common\utility::allow_fire(1);
            var_0 scripts\common\utility::allow_ads(1);
            var_0 scripts\common\utility::allow_offhand_weapons(1);
          } else {
            var_0 scripts\mp\playeractions::allowactionset("reviveShoot", 1);
          }
        }
      } else {
        var_0 scripts\common\utility::allow_weapon(1);
      }
    }

    var_0 allowmovement(1);
  }

  self.inuse = 0;

  if(self.exclusiveuse && isDefined(self.trigger)) {
    self.trigger releaseclaimedtrigger();
  }

  return false;
}

function playerplunderdepositcallback(var_0) {
  self endon("death");
  self notify("forceDemeanorSafe");
  self endon("forceDemeanorSafe");

  if(var_0) {
    while(self issprinting()) {
      wait 0.5;
    }

    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
    return;
  }

  var_1 = 0;

  while(!var_1) {
    var_1 = self setdemeanorviewmodel("normal");
    waitframe();
  }
}

function managecurprogress(var_0) {
  if(!isDefined(self.prevprogress)) {
    self.prevprogress = 0;
  }

  var_1 = self.curprogress - self.prevprogress;

  if(var_1 <= 1000) {
    self.curprogress = self.prevprogress;
  }

  var_2 = self.usetime - self.curprogress;

  if(var_2 < 1000) {
    if(self.usetime <= 1000) {
      self.curprogress = self.usetime;
    } else {
      self.curprogress = self.usetime - 1000;
    }
  }

  var_1 = 0;

  if(self.curprogress > 0) {
    if(isDefined(self.teamprogress) && isDefined(self.claimteam)) {
      if(self.teamprogress[self.claimteam] > self.usetime) {
        self.teamprogress[self.claimteam] = self.usetime;
      }

      var_1 = self.teamprogress[self.claimteam] / self.usetime;
    } else {
      if(self.curprogress > self.usetime) {
        self.curprogress = self.usetime;
      }

      var_1 = self.curprogress / self.usetime;

      if(self.usetime <= 1000) {
        var_1 = min(var_1 + 0.05, 1);
      } else {
        var_1 = min(var_1 + 0.01, 1);
      }
    }
  }

  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0.team);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, var_1);

  if(self.curprogress > 0) {
    scripts\mp\objidpoolmanager::objective_show_team_progress(self.objidnum, var_0.team);
  } else {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  self.prevprogress = self.curprogress;
}

function detachusemodels() {
  if(isDefined(self.attachedusemodel)) {
    self detach(self.attachedusemodel, "tag_inhand");
    self.attachedusemodel = undefined;
    return;
  }
}

function switchtouseweapon(var_0, var_1) {
  scripts\mp\supers::allowsuperweaponstow();
  var_2 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, var_1);

  if(!istrue(var_2)) {
    scripts\mp\supers::unstowsuperweapon();

    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_0)) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0);
      return;
    }

    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    return;
  }
}

function usetest(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    return false;
  }

  if(!var_0 scripts\common\utility::is_usability_allowed()) {
    return false;
  }

  if(!isDefined(self.skiptouching) && isDefined(self.trigger) && !var_0 istouching(self.trigger)) {
    return false;
  }

  if(!level.allowreviveweapons && !var_0 useButtonPressed(1)) {
    return false;
  }

  if(var_0 scripts\mp\utility\weapon::grenadeinpullback()) {
    return false;
  }

  if(var_0 meleeButtonPressed()) {
    return false;
  }

  if(var_0 isinexecutionattack()) {
    return false;
  }

  if(var_0 isinexecutionvictim()) {
    return false;
  }

  if(isDefined(self.trigger) && isDefined(self.trigger.ref_1408a) && distance2dsquared(self.trigger.origin, var_0.origin) >= self.trigger.ref_1408a) {
    return false;
  }

  if(self.curprogress >= self.usetime) {
    return false;
  }

  if(!self.userate && !var_1) {
    return false;
  }

  if(var_1 && var_2 > var_3) {
    return false;
  }

  if(istrue(self.getrandompointincirclewithindistance) && isDefined(self.usecondition) && !self[[self.usecondition]](var_0)) {
    return false;
  }

  if(isDefined(self.useweapon)) {
    if(var_0 getcurrentweapon() != self.useweapon && !var_0 scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(self.useweapon)) {
      return false;
    }
  }

  if(isrevivetrigger(self.trigger)) {
    if(!var_0 isonground()) {
      return false;
    }
  }

  return true;
}

function useholdthinkloop(var_0, var_1) {
  level endon("game_ended");
  self endon("disabled");
  var_2 = self.useweapon;
  var_3 = 1;

  if(isDefined(self.waitforweapononuse)) {
    var_3 = self.waitforweapononuse;
  }

  if(!var_3) {
    self.userate = 1 * var_0.objectivescaler;
  }

  var_4 = 0;
  var_5 = 1.5;
  var_6 = level.framedurationseconds;
  var_7 = var_6 * 1000;
  var_8 = undefined;

  while(usetest(var_0, var_3, var_4, var_5)) {
    if(isDefined(self.objidnum)) {
      scripts\mp\objidpoolmanager::objective_pin_player(self.objidnum, var_0);
    }

    var_4 += var_6;

    if(!var_3 || !isDefined(var_2) || var_0 getcurrentweapon() == var_2) {
      self.curprogress += var_7 * self.userate;
      self.userate = 1 * var_0.objectivescaler;
      var_3 = 0;
    } else {
      self.userate = 0;
    }

    updateuiprogress(var_0, self, 1);

    if(self.curprogress >= self.usetime) {
      self.inuse = 0;

      if(self.exclusiveuse) {
        var_0 clientreleasetrigger(self.trigger);
      }

      var_9 = isDefined(self.id) && (self.id == "traversalassist" || self.id == "breach" || self.id == "care_package");

      if(!isDefined(var_2) && !var_9) {
        if(isrevivetrigger(self.trigger) || isDefined(self.id) && self.id == "rugby_jugg") {
          if(istrue(var_0.weaponsdisabledwhilereviving)) {
            var_0.weaponsdisabledwhilereviving = undefined;

            if(!level.allowreviveweapons) {
              thread playerplunderdepositcallback(var_0);
              var_0 scripts\common\utility::allow_sprint(1);
              var_0 scripts\common\utility::allow_fire(1);
              var_0 scripts\common\utility::allow_ads(1);
              var_0 scripts\common\utility::allow_offhand_weapons(1);
            } else {
              var_0 scripts\mp\playeractions::allowactionset("reviveShoot", 1);
            }
          }
        } else {
          var_0 scripts\common\utility::allow_weapon(1);
        }
      }

      var_0 unlink();

      if(isDefined(self.objidnum)) {
        scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, var_0);
      }

      return scripts\mp\utility\player::isreallyalive(var_0);
    }

    wait var_7;
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }

  if(isDefined(self.objidnum)) {
    scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, var_1);
  }

  updateuiprogress(var_1, self, 0);
  return 0;
}

function updatetrigger() {
  if(self.triggertype != "use") {
    return;
  }

  if(self.trigger.classname != "trigger_use" && self.trigger.classname != "trigger_use_touch") {
    return;
  }

  if(self.interactteam == "none") {
    self.trigger.origin -= (0, 0, 10000);

    if(isDefined(self.trigger.classname) && self.trigger.classname != "script_model") {
      self.trigger setteamfortrigger("none");
      return;
    }

    return;
  }

  if(self.interactteam == "any") {
    self.trigger.origin = self.curorigin;
    self.trigger setteamfortrigger("none");
    return;
  }

  if(self.interactteam == "friendly") {
    self.trigger.origin = self.curorigin;

    if(scripts\engine\utility::array_contains(level.teamnamelist, self.ownerteam)) {
      self.trigger setteamfortrigger(self.ownerteam);
      return;
    }

    self.trigger.origin -= (0, 0, 50000);
    return;
  }

  if(self.interactteam == "enemy") {
    self.trigger.origin = self.curorigin;

    if(self.ownerteam == "allies") {
      self.trigger setteamfortrigger("axis");
      return;
    }

    if(self.ownerteam == "axis") {
      self.trigger setteamfortrigger("allies");
      return;
    }

    self.trigger setteamfortrigger("none");
    return;
  }
}

function getmlgteamcolor(var_0) {
  if(var_0 == "allies") {
    return game["colors"]["friendly"];
  } else if(var_0 == "axis") {
    return game["colors"]["enemy"];
  }

  return (1, 1, 1);
}

function setobjpointteamcolor(var_0, var_1, var_2) {
  if(var_1 == "mlg_allies") {
    var_0 setmlgdraw(1, 0);
    var_3 = self.objiconscolor[var_2];

    if(var_3 == "friendly") {
      var_0.color = getmlgteamcolor("allies");
      return;
    }

    if(var_3 == "enemy") {
      var_0.color = getmlgteamcolor("axis");
      return;
    }

    var_0.color = game["colors"][var_3];
    return;
  }

  if(var_1 == "mlg_axis") {
    var_0 setmlgdraw(1, 0);
    var_3 = self.objiconscolor[var_2];

    if(var_3 == "friendly") {
      var_0.color = getmlgteamcolor("axis");
      return;
    }

    if(var_3 == "enemy") {
      var_0.color = getmlgteamcolor("allies");
      return;
    }

    var_0.color = game["colors"][var_3];
    return;
  }

  var_0.color = game["colors"][self.objiconscolor[var_2]];
  var_0 setmlgdraw(0, 1);
}

function hideworldiconongameend() {
  self notify("hideWorldIconOnGameEnd");
  self endon("hideWorldIconOnGameEnd");
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self)) {
    self.alpha = 0;
    return;
  }
}

function updatetimer(var_0, var_1) {}

function ref_1317f(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(self.lockupdatingicons)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = var_1;
  }

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  if(!isDefined(self.iconname)) {
    self.iconname = "";
  }

  if(level.codcasterenabled) {
    if(!isDefined(var_2)) {
      self.compassicons["codcaster"] = undefined;
    } else {
      self.compassicons["codcaster"] = var_2 + self.iconname;
    }
  }

  self.compassicons["friendly"] = var_0 + self.iconname;
  self.compassicons["enemy"] = var_1 + self.iconname;
  updatecompassicons(var_3, var_4);
}

function setobjectivestatusicons(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(self.lockupdatingicons)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = var_1;
  }

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  if(!isDefined(self.iconname)) {
    self.iconname = "";
  }

  self.compassicons["friendly"] = var_0 + self.iconname;
  self.compassicons["enemy"] = var_1 + self.iconname;

  if(!istrue(var_4)) {
    updatecompassicons(var_2, var_3);
    return;
  }
}

function ref_13172(var_0, var_1, var_2) {
  if(!level.codcasterenabled) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(self.iconname)) {
    self.iconname = "";
  }

  self.compassicons["codcaster"] = var_0 + self.iconname;
  updatecompassicons(var_1, var_2);
}

function ref_12c75(var_0, var_1) {
  self.compassicons["codcaster"] = undefined;
  updatecompassicons(var_0, var_1);
}

function updatecompassicons(var_0, var_1) {
  var_2 = self.visibleteam;

  if(!isDefined(self.visibleteam)) {
    var_2 = "none";
  }

  updatecompassicon(var_2, var_0, var_1);
}

function updatecompassicon(var_0, var_1, var_2) {
  var_3 = var_0 == "any";
  var_4 = var_0 == "none";
  jumpiffalse(var_3 || var_4) LOC_0000002c;
  var_5 = level.teamnamelist;
  goto LOC_00000041;
}

function shouldpingobject(var_0) {
  if(var_0 == "friendly" && self.objidpingenemy) {
    return true;
  } else if(var_0 == "enemy" && self.objidpingfriendly) {
    return true;
  }

  return false;
}

function getupdateteams(var_0) {
  var_1 = spawnStruct();
  var_1.teams = [];

  foreach(var_3 in level.teamnamelist) {
    var_4 = var_1.teams.size;
    var_1.teams[var_4] = spawnStruct();

    if(var_0 == "any") {
      var_1.teams[var_4].team = var_3;
      var_1.teams[var_4].showtoteam = 1;
      continue;
    }

    if(var_0 == "friendly") {
      if(isfriendlyteam(var_3)) {
        var_1.teams[var_4].team = var_3;
        var_1.teams[var_4].showtoteam = 1;
      } else {
        var_1.teams[var_4].team = var_3;
        var_1.teams[var_4].showtoteam = 0;
      }

      continue;
    }

    if(var_0 == "enemy") {
      if(isfriendlyteam(var_3)) {
        var_1.teams[var_4].team = var_3;
        var_1.teams[var_4].showtoteam = 0;
      } else {
        var_1.teams[var_4].team = var_3;
        var_1.teams[var_4].showtoteam = 1;
      }

      continue;
    }

    if(var_0 == "none") {
      var_1.teams[var_4].team = var_3;
      var_1.teams[var_4].showtoteam = 0;
    }
  }

  return var_1;
}

function getobjectivestate(var_0, var_1) {
  if(var_0 == "contest" || var_1 == "contest") {
    return "contest";
  }

  if(var_0 == "neutral" || var_1 == "neutral") {
    return "neutral";
  }

  return "claimed";
}

function shouldshowcompassduetoradar(var_0) {
  if(!isDefined(self.carrier)) {
    return 0;
  }

  if(self.carrier scripts\mp\utility\perk::_hasperk("specialty_gpsjammer")) {
    return 0;
  }

  return getteamradar(var_0);
}

function updatevisibilityaccordingtoradar() {
  self endon("death");
  self endon("carrier_cleared");

  for(;;) {
    level waittill("radar_status_change");
    updatecompassicons();
  }
}

function setownerteam(var_0) {
  self.ownerteam = var_0;
  updatetrigger();
  updatecompassicons();

  if(var_0 != "neutral") {
    self.prevownerteam = var_0;
    return;
  }
}

function getownerteam() {
  return self.ownerteam;
}

function setusetime(var_0) {
  self.usetime = int(var_0 * 1000);
}

function pinobjiconontriggertouch() {
  self.pinobj = 1;
}

function setwaitweaponchangeonuse(var_0) {
  self.waitforweapononuse = var_0;
}

function setusetext(var_0) {
  self.usetext = var_0;
}

function setteamusetime(var_0, var_1) {
  self.teamusetimes[var_0] = int(var_1 * 1000);
}

function setteamusetext(var_0, var_1) {
  self.teamusetexts[var_0] = var_1;
}

function setusehinttext(var_0) {
  self.trigger setHintString(var_0);
}

function allowcarry(var_0) {
  self.interactteam = var_0;
}

function allowuse(var_0) {
  self.interactteam = var_0;
  updatetrigger();
}

function squadallowuse(var_0, var_1) {
  if(!isDefined(self.interactsquads)) {
    self.interactsquads = [];
  }

  if(!isDefined(self.interactsquads[var_0])) {
    self.interactsquads[var_0] = [];
  }

  if(!scripts\engine\utility::array_contains(self.interactsquads[var_0], var_1)) {
    self.interactsquads[var_0][self.interactsquads[var_0].size] = var_1;
    return;
  }
}

function squaddenyuse(var_0, var_1) {
  if(!isDefined(self.interactsquads)) {
    self.interactsquads = [];
  }

  if(!isDefined(self.interactsquads[var_0])) {
    self.interactsquads[var_0] = [];
  }

  if(scripts\engine\utility::array_contains(self.interactsquads[var_0], var_1)) {
    self.interactsquads[var_0] = scripts\engine\utility::array_remove(self.interactsquads[var_0], var_1);
    return;
  }
}

function setvisibleteam(var_0, var_1, var_2) {
  self.visibleteam = var_0;

  if(!istrue(var_2)) {
    updatecompassicons(var_1);
    return;
  }
}

function setmodelvisibility(var_0) {
  if(var_0) {
    for(var_1 = 0; var_1 < self.visuals.size; var_1++) {
      self.visuals[var_1] show();

      if(self.visuals[var_1].classname == "script_brushmodel" || self.visuals[var_1].classname == "script_model") {
        foreach(var_3 in level.players) {
          if(var_3 istouching(self.visuals[var_1])) {
            var_3 scripts\mp\utility\damage::_suicide();
          }
        }

        thread makesolid();
      }
    }

    return;
  }

  for(var_1 = 0; var_1 < self.visuals.size; var_1++) {
    self.visuals[var_1] hide();

    if(self.visuals[var_1].classname == "script_brushmodel" || self.visuals[var_1].classname == "script_model") {
      self.visuals[var_1] notify("changing_solidness");
      self.visuals[var_1] notsolid();
    }
  }
}

function makesolid() {
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

    wait 0.05;
  }
}

function setcarriervisible(var_0) {
  self.carriervisible = var_0;
}

function setcanuse(var_0) {
  self.useteam = var_0;
}

function getwaypointshader(var_0) {
  var_1 = level.waypointshader[var_0];

  if(!isDefined(var_1)) {
    return "icon_waypoint_dom_a";
  }

  return var_1;
}

function getwaypointbackgroundtype(var_0) {
  var_1 = level.waypointbgtype[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1;
}

function getwaypointbackgroundcolor(var_0) {
  var_1 = level.waypointcolors[var_0];

  if(!isDefined(var_1)) {
    return "neutral";
  }

  return var_1;
}

function getwaypointstring(var_0) {
  var_1 = level.waypointstring[var_0];

  if(!isDefined(var_1)) {
    return "MP_INGAME_ONLY/MISSING_STRING";
  }

  return var_1;
}

function getwaypointobjpulse(var_0) {
  var_1 = level.waypointpulses[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1;
}

function set3duseicon(var_0, var_1) {
  self.worlduseicons[var_0] = var_1;
}

function setcarryicon(var_0) {
  self.carryicon = var_0;
}

function disableobject() {
  self notify("disabled");

  if(self.type == "carryObject") {
    if(isDefined(self.carrier)) {
      takeobject(self.carrier, self);
    }

    for(var_0 = 0; var_0 < self.visuals.size; var_0++) {
      self.visuals[var_0] hide();
    }
  }

  self.trigger scripts\engine\utility::trigger_off();
  setvisibleteam("none");
}

function enableobject() {
  if(self.type == "carryObject") {
    for(var_0 = 0; var_0 < self.visuals.size; var_0++) {
      self.visuals[var_0] show();
    }
  }

  self.trigger scripts\engine\utility::trigger_on();
  setvisibleteam("any");
}

function getrelativeteam(var_0) {
  if(var_0 == self.ownerteam) {
    return "friendly";
  }

  return "enemy";
}

function isfriendlyteam(var_0) {
  if(self.ownerteam == "any") {
    return true;
  }

  if(self.ownerteam == var_0) {
    return true;
  }

  if(self.ownerteam == "neutral" && isDefined(self.prevownerteam) && self.prevownerteam == var_0) {
    return true;
  }

  return false;
}

function caninteractwith(var_0, var_1) {
  if(isDefined(var_1) && isDefined(self.interactsquads)) {
    return (isDefined(self.interactsquads[var_1.team]) && scripts\engine\utility::array_contains(self.interactsquads[var_1.team], var_1.squadindex));
  }

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

function isteam(var_0) {
  if(var_0 == "neutral") {
    return true;
  }

  if(var_0 == "any") {
    return true;
  }

  if(var_0 == "none") {
    return true;
  }

  foreach(var_2 in level.teamnamelist) {
    if(var_0 == var_2) {
      return true;
    }
  }

  return false;
}

function isrelativeteam(var_0) {
  if(var_0 == "friendly") {
    return true;
  }

  if(var_0 == "enemy") {
    return true;
  }

  if(var_0 == "any") {
    return true;
  }

  if(var_0 == "none") {
    return true;
  }

  return false;
}

function getlabel() {
  if(!isDefined(self.trigger.script_label)) {
    return "";
  }

  return self.trigger.script_label;
}

function initializetagpathvariables() {
  self.nearest_node = undefined;
  self.calculated_nearest_node = 0;
  self.on_path_grid = undefined;
}

function mustmaintainclaim(var_0) {
  self.mustmaintainclaim = var_0;
}

function cancontestclaim(var_0) {
  self.cancontestclaim = var_0;
}

function getleveltriggers() {
  level.minetriggers = getEntArray("minefield", "targetname");
  level.hurttriggers = getEntArray("trigger_hurt", "classname");
  level.radtriggers = getEntArray("radiation", "targetname");
  level.ballallowedtriggers = getEntArray("uplinkAllowedOOB", "targetname");
  level.nozonetriggers = getEntArray("uplink_nozone", "targetname");
  level.droptonavmeshtriggers = getEntArray("dropToNavMesh", "targetname");
  thread scripts\mp\arbitrary_up::initarbitraryuptriggers();
}

function isbombmode() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "to_dd":
    case "cmd":
    case "btm":
    case "dd":
    case "cyber":
    case "sr":
    case "sd":
      return 1;
    default:
      return 0;
  }
}

function unset_relic_bang_and_boom() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "tdef":
    case "ctf":
      return 1;
    default:
      return 0;
  }
}

function touchingdroptonavmeshtrigger(var_0) {
  if(level.droptonavmeshtriggers.size > 0) {
    if(isbombmode() || scripts\mp\utility\game::getgametype() == "ctf" || scripts\mp\utility\game::getgametype() == "tdef") {
      self.visuals[0].origin = var_0;
    }

    foreach(var_2 in level.droptonavmeshtriggers) {
      foreach(var_4 in self.visuals) {
        if(var_4 istouching(var_2)) {
          return true;
        }
      }
    }
  }

  return false;
}

function touchingarbitraryuptrigger() {
  if(level.arbitraryuptriggers.size > 0) {
    foreach(var_1 in level.arbitraryuptriggers) {
      if(self istouching(var_1)) {
        return true;
      }
    }
  }

  return false;
}

function resetcaptureprogress() {
  if(isDefined(self.teamprogress)) {
    foreach(var_1 in self.teamprogress) {
      self.teamprogress[var_2] = 0;
    }

    return;
  }
}

function getcaptureprogress() {
  if(isDefined(self.teamprogress) && isDefined(self.claimteam)) {
    if(self.claimteam != "none") {
      return (self.teamprogress[self.claimteam] / self.usetime);
    } else {
      return (self.teamprogress[self.lastclaimteam] / self.usetime);
    }
  }

  return 0;
}

function requestid(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2)) {
    self.objidnum = scripts\mp\objidpoolmanager::requestreservedid(var_2);
  } else {
    self.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  }

  if(self.objidnum != -1) {
    var_5 = "done";

    if(var_0 && var_1) {
      var_5 = "current";
    } else if(var_0) {
      var_5 = "active";
    } else if(var_1) {
      var_5 = "invisible";
    }

    scripts\mp\objidpoolmanager::objective_add_objective(self.objidnum, var_5, self.curorigin + self.offset3d);

    if(getdvarint("scr_game_objOnNavBar", 0) == 1) {
      if(isDefined(var_3) && var_3 == 0) {
        objective_setshowoncompass(self.objidnum, 0);
        self.showoncompass = 0;
      } else {
        objective_setshowoncompass(self.objidnum, 1);
      }
    }

    if(isDefined(var_4)) {
      scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, var_4);
      scripts\mp\objidpoolmanager::objective_set_play_outro(self.objidnum, var_4);
    }

    self.showworldicon = 0;
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.objidnum);

    if(var_1) {
      self.showworldicon = 1;
      return;
    }

    return;
  }
}

function releaseid(var_0, var_1) {
  if(istrue(var_0)) {
    scripts\mp\objidpoolmanager::returnreservedobjectiveid(self.objidnum, var_1);
  } else {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnum);
  }

  self.objidnum = -1;
}

function getcapturebehavior() {
  if(!isDefined(self.capturebehavior)) {
    setcapturebehavior("normal");
  }

  return self.capturebehavior;
}

function setcapturebehavior(var_0) {
  self.capturebehavior = var_0;
}

function applycaptureprogress(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getenemyteams(var_0);

  switch (getcapturebehavior()) {
    case "single_progress":
      self.teamprogress[var_0] += level.frameduration;
      self.curprogress = self.teamprogress[var_0];
      break;
    case "persistent":
      self.teamprogress[var_0] += var_1;
      self.curprogress = self.teamprogress[var_0];
      break;
    case "contest_only":
      if(!isDefined(self.ownerteam) || self.ownerteam == var_0) {
        return;
      }

      break;
    case "neutralize":
      foreach(var_4 in var_2) {
        var_5 = self.teamprogress[var_4];

        if(var_5 > 0) {
          if(var_5 < var_1) {
            self.teamprogress[var_4] = 0;
            var_1 -= var_5;
            continue;
          }

          self.teamprogress[var_4] -= var_1;
          var_1 = 0;
          self.curprogress = self.teamprogress[var_4];
          scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);
        }
      }

      if(var_1 > 0) {
        self.teamprogress[var_0] += var_1;
        self.curprogress = self.teamprogress[var_0];
      }

      break;
    case "only_associated_teams":
      if(!isDefined(self.associatedteams) || !scripts\engine\utility::array_contains(self.associatedteams, var_0)) {
        return;
      }

      foreach(var_4 in var_2) {
        var_5 = self.teamprogress[var_4];

        if(var_5 > 0) {
          if(var_5 < var_1) {
            self.teamprogress[var_4] = 0;
            var_1 -= var_5;
            continue;
          }

          self.teamprogress[var_4] -= var_1;
          var_1 = 0;
          self.curprogress = self.teamprogress[var_4];
          scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);
        }
      }

      if(var_1 > 0) {
        self.teamprogress[var_0] += var_1;
        self.curprogress = self.teamprogress[var_0];
      }

      break;
    case "one_way_contest_only":
      if(var_0 != self.team) {
        return;
      }

      if(var_0 == self.team) {
        foreach(var_10 in var_2) {
          if(self.numtouching[var_10] > 0) {
            return;
          }
        }
      }

      self.teamprogress[var_0] += var_1;
      self.curprogress = self.teamprogress[var_0];
      break;
    default:
      var_12 = self.teamprogress[var_0];
      var_12 += var_1;
      var_13 = 0;
      var_14 = getnumtouchingforteam(var_0);
      var_15 = getnumtouchingexceptteam(var_0);

      if(var_14 && var_15 && var_14 != var_15) {
        var_13 = 1;
      }

      if(istrue(self.majoritycapprogress) && var_12 >= self.usetime * 0.95 && istrue(var_13)) {
        if(self.ownerteam == "neutral") {
          foreach(var_0 in level.teamnamelist) {
            if(self.touchlist[var_0].size) {
              var_17 = self.touchlist[var_0];
              var_18 = getarraykeys(var_17);

              for(var_19 = 0; var_19 < var_18.size; var_19++) {
                var_20 = var_17[var_18[var_19]].player;
                var_20 setclientomnvar("ui_objective_state", 4);
              }

              break;
            }
          }

          scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 1);
          scripts\mp\objidpoolmanager::update_objective_setneutrallabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
        } else {
          foreach(var_0 in level.teamnamelist) {
            if(var_0 == self.ownerteam) {
              if(self.touchlist[var_0].size) {
                var_17 = self.touchlist[var_0];
                var_18 = getarraykeys(var_17);

                for(var_19 = 0; var_19 < var_18.size; var_19++) {
                  var_20 = var_17[var_18[var_19]].player;
                  var_20 setclientomnvar("ui_objective_state", 4);
                }

                break;
              }
            }
          }

          scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 1);
          scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS");
          scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
        }
      } else {
        if(self.ownerteam != "neutral") {
          if(self.ownerteam != var_0) {
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_LOSING_CAPS");
          }
        }

        self.teamprogress[var_0] += var_1;
        self.curprogress = self.teamprogress[var_0];
      }

      break;
  }
}

function createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawn("script_model", var_0);
  var_11 makeusable();

  if(isDefined(var_1)) {
    var_11 setCursorHint(var_1);
  } else {
    var_11 setCursorHint("HINT_NOICON");
  }

  if(isDefined(var_2)) {
    var_11 sethinticon(var_2);
  }

  if(isDefined(var_3)) {
    var_11 setHintString(var_3);
  }

  if(isDefined(var_4)) {
    var_11 setusepriority(var_4);
  } else {
    var_11 setusepriority(0);
  }

  if(isDefined(var_5)) {
    var_11 setuseholdduration(var_5);
  } else {
    var_11 setuseholdduration("duration_short");
  }

  if(isDefined(var_6)) {
    var_11 sethintonobstruction(var_6);
  } else {
    var_11 sethintonobstruction("hide");
  }

  if(isDefined(var_7)) {
    var_11 sethintdisplayrange(var_7);
  } else {
    var_11 sethintdisplayrange(200);
  }

  if(isDefined(var_8)) {
    var_11 sethintdisplayfov(var_8);
  } else {
    var_11 sethintdisplayfov(160);
  }

  if(isDefined(var_9)) {
    var_11 setuserange(var_9);
  } else {
    var_11 setuserange(50);
  }

  if(isDefined(var_10)) {
    var_11 setusefov(var_10);
  } else {
    var_11 setusefov(120);
  }

  return var_11;
}

function sethintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_3 = undefined;
  }

  self makeusable();

  if(isDefined(var_0)) {
    self sethinttag(var_0);
  }

  if(isDefined(var_1)) {
    self setCursorHint(var_1);
  } else {
    self setCursorHint("HINT_NOICON");
  }

  if(isDefined(var_2)) {
    self sethinticon(var_2);
  }

  if(isDefined(var_3)) {
    self setHintString(var_3);
  }

  if(isDefined(var_4)) {
    self setusepriority(var_4);
  } else {
    self setusepriority(0);
  }

  if(isDefined(var_5)) {
    self setuseholdduration(var_5);
  } else {
    self setuseholdduration("duration_short");
  }

  if(isDefined(var_6)) {
    self sethintonobstruction(var_6);
  } else {
    self sethintonobstruction("hide");
  }

  if(isDefined(var_7)) {
    self sethintdisplayrange(var_7);
  } else {
    self sethintdisplayrange(200);
  }

  if(isDefined(var_8)) {
    self sethintdisplayfov(var_8);
  } else {
    self sethintdisplayfov(160);
  }

  if(isDefined(var_9)) {
    self setuserange(var_9);
  } else {
    self setuserange(50);
  }

  if(isDefined(var_10)) {
    self setusefov(var_10);
    return;
  }

  self setusefov(120);
}

function createobjidobject(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.type = "useObject";
  var_6.curorigin = var_0;
  var_6.ownerteam = var_1;

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_6.offset3d = var_2;
  requestid(var_6, 1, 1, var_3, var_5);
  var_6.compassicons = [];
  var_6.interactteam = "none";

  if(isDefined(var_4)) {
    var_6.visibleteam = var_4;
  } else {
    var_6.visibleteam = "none";
  }

  return var_6;
}

function isrevivetrigger() {
  if(isDefined(self.id) && self.id == "laststand_reviver") {
    return true;
  }

  return false;
}