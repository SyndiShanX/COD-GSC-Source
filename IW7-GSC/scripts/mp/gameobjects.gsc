/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gameobjects.gsc
*********************************************/

main(var_0) {
  var_0[var_0.size] = "airdrop_pallet";
  var_1 = getEntArray();
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2].script_gameobjectname)) {
      var_3 = 1;
      var_4 = strtok(var_1[var_2].script_gameobjectname, " ");
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
        var_1[var_2] delete();
      }
    }
  }
}

init() {
  level.var_C22E = 0;
  level thread onplayerconnect();
  level thread getleveltriggers();
}

onplayerconnect() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_0);
    if(isbot(var_0)) {
      level.botsenabled = 1;
    }

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
  thread ondeath_clearscriptedanim();
  self.touchtriggers = [];
  self.carryobject = undefined;
  self.var_3FFA = undefined;
  self.var_38ED = 1;
  self.var_A64F = undefined;
  self.var_987A = 1;
}

ondeath_clearscriptedanim() {
  level endon("game_ended");
  self waittill("death");
  if(isDefined(self.carryobject)) {
    self.carryobject thread setdropped();
  }
}

ondisconnect() {
  level endon("game_ended");
  self waittill("disconnect");
  if(isDefined(self.carryobject)) {
    self.carryobject thread setdropped();
  }
}

func_4A29(var_0, var_1) {
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("tag_origin");
  var_3 = spawnStruct();
  var_3.type = "carryObject";
  var_3.carrier = var_0;
  var_3.curorigin = var_0.origin;
  var_3.entnum = var_2 getentitynumber();
  var_3.ownerteam = var_0.team;
  var_3.var_4465 = [];
  var_3.objidpingenemy = 0;
  var_3.objidpingfriendly = 0;
  var_3.var_13DCA = [];
  var_3.carriervisible = 0;
  var_3.visibleteam = "none";
  foreach(var_5 in level.teamnamelist) {
    var_3.teamobjids[var_5] = ::scripts\mp\objidpoolmanager::requestminimapid(99);
    if(var_3.teamobjids[var_5] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_3.teamobjids[var_5], "invisible", var_3.curorigin);
      scripts\mp\objidpoolmanager::minimap_objective_team(var_3.teamobjids[var_5], var_5);
    }

    var_3.objpoints[var_5] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_5 + "_" + var_3.entnum, var_3.curorigin + var_1, var_5, undefined);
    var_3.objpoints[var_5].alpha = 0;
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_6 = "mlg_" + var_5;
      var_3.objpoints[var_6] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_6 + "_" + var_3.entnum, var_3.curorigin + var_1, var_5, undefined);
      var_3.objpoints[var_6].alpha = 0;
    }
  }

  var_3 thread func_12E6F();
  var_3 thread func_51D8();
  return var_3;
}

func_51D8() {
  self.carrier waittill("disconnect");
  if(self.type != "carryObject") {
    return;
  }

  var_0 = self;
  var_0.type = undefined;
  var_0.carrier = undefined;
  var_0.curorigin = undefined;
  var_0.entnum = undefined;
  var_0.ownerteam = undefined;
  var_0.var_4465 = undefined;
  var_0.objidpingenemy = undefined;
  var_0.objidpingfriendly = undefined;
  var_0.var_13DCA = undefined;
  var_0.carriervisible = undefined;
  var_0.visibleteam = undefined;
  foreach(var_2 in level.teamnamelist) {
    scripts\mp\objidpoolmanager::returnminimapid(var_0.teamobjids[var_2]);
    scripts\mp\objpoints::deleteobjpoint(var_0.objpoints[var_2]);
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_3 = "mlg_" + var_2;
      scripts\mp\objpoints::deleteobjpoint(var_0.objpoints[var_3]);
    }
  }
}

createcarryobject(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "carryObject";
  var_4.curorigin = var_1.origin;
  var_4.ownerteam = var_0;
  var_4.entnum = var_1 getentitynumber();
  if(issubstr(var_1.classname, "use")) {
    var_4.triggertype = "use";
  } else {
    var_4.triggertype = "proximity";
  }

  var_1.baseorigin = var_1.origin;
  var_4.trigger = var_1;
  if(!isDefined(var_1.linktoenabledflag)) {
    var_1.linktoenabledflag = 1;
    var_1 enablelinkto();
  }

  var_4.useweapon = undefined;
  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_4.offset3d = var_3;
  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    var_2[var_5].baseorigin = var_2[var_5].origin;
    var_2[var_5].baseangle = var_2[var_5].angles;
  }

  var_4.visuals = var_2;
  var_4.var_4465 = [];
  var_4.objidpingenemy = 0;
  var_4.objidpingfriendly = 0;
  foreach(var_7 in level.teamnamelist) {
    var_4.teamobjids[var_7] = ::scripts\mp\objidpoolmanager::requestminimapid(99);
    if(var_4.teamobjids[var_7] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_4.teamobjids[var_7], "invisible", var_4.curorigin);
      scripts\mp\objidpoolmanager::minimap_objective_team(var_4.teamobjids[var_7], var_7);
    }

    var_4.objpoints[var_7] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_7 + "_" + var_4.entnum, var_4.curorigin + var_3, var_7, undefined);
    var_4.objpoints[var_7].alpha = 0;
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_8 = "mlg_" + var_7;
      var_4.objpoints[var_8] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_8 + "_" + var_4.entnum, var_4.curorigin + var_3, var_7, undefined);
      var_4.objpoints[var_8].alpha = 0;
    }
  }

  var_4.carrier = undefined;
  var_4.isresetting = 0;
  var_4.interactteam = "none";
  var_4.allowweapons = 0;
  var_4.var_13DCA = [];
  var_4.carriervisible = 0;
  var_4.visibleteam = "none";
  var_4.carryicon = undefined;
  var_4.ondrop = undefined;
  var_4.onpickup = undefined;
  var_4.onreset = undefined;
  if(var_4.triggertype == "use") {
    var_4 thread carryobjectusethink();
  } else {
    var_4.curprogress = 0;
    var_4.var_115DF = [];
    var_4.var_115DF["none"] = 0;
    var_4.var_115DF["allies"] = 0;
    var_4.var_115DF["axis"] = 0;
    var_4.usetime = 0;
    var_4.userate = 0;
    var_4.mustmaintainclaim = 0;
    var_4.cancontestclaim = 0;
    var_4.teamusetimes = [];
    var_4.teamusetexts = [];
    var_4.numtouching["neutral"] = 0;
    var_4.touchlist["neutral"] = [];
    var_4.numtouching["none"] = 0;
    var_4.touchlist["none"] = [];
    foreach(var_0B in level.teamnamelist) {
      var_4.numtouching[var_0B] = 0;
      var_4.touchlist[var_0B] = [];
    }

    var_4.claimteam = "none";
    var_4.claimplayer = undefined;
    var_4.lastclaimteam = "none";
    var_4.lastclaimtime = 0;
    var_4 thread carryobjectasset();
  }

  var_4 thread func_12E6F();
  return var_4;
}

func_51A9() {
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
  var_0.var_4465 = undefined;
  var_0.objidpingenemy = undefined;
  var_0.objidpingfriendly = undefined;
  var_0.objpingdelay = undefined;
  scripts\mp\objpoints::deleteobjpoint(var_0.objpoints["allies"]);
  scripts\mp\objpoints::deleteobjpoint(var_0.objpoints["axis"]);
  foreach(var_5 in level.teamnamelist) {
    scripts\mp\objidpoolmanager::returnminimapid(var_0.teamobjids[var_5]);
    scripts\mp\objpoints::deleteobjpoint(var_0.objpoints[var_5]);
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_6 = "mlg_" + var_5;
      scripts\mp\objpoints::deleteobjpoint(var_0.objpoints[var_6]);
    }
  }

  var_0.objpoints = undefined;
  var_0.carrier = undefined;
  var_0.isresetting = undefined;
  var_0.interactteam = undefined;
  var_0.allowweapons = undefined;
  var_0.var_A57D = undefined;
  var_0.var_13DCA = undefined;
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
  level endon("game_ended");
  for(;;) {
    self.trigger waittill("trigger", var_0);
    if(scripts\mp\utility::func_9F22(var_0)) {
      continue;
    }

    if(!isplayer(var_0)) {
      continue;
    }

    if(var_0 _meth_84CA()) {
      continue;
    }

    if(var_0 getcurrentweapon() == "ks_remote_map_mp") {
      continue;
    }

    if(var_0 getcurrentweapon() == "ks_remote_device_mp") {
      continue;
    }

    if(var_0 scripts\mp\utility::isanymonitoredweaponswitchinprogress()) {
      var_1 = var_0 scripts\mp\utility::getcurrentmonitoredweaponswitchweapon();
      if(var_1 == "ks_remote_map_mp" || var_1 == "ks_remote_device_mp") {
        continue;
      }
    }

    if(scripts\mp\utility::istrue(var_0.using_remote_turret)) {
      continue;
    }

    if(!func_DAD1(var_0)) {
      continue;
    }

    if(self.isresetting) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_0)) {
      continue;
    }

    if(!caninteractwith(var_0.pers["team"])) {
      continue;
    }

    if(!var_0.var_38ED) {
      continue;
    }

    if(isDefined(var_0.nopickuptime) && var_0.nopickuptime > gettime()) {
      continue;
    }

    if(!isDefined(var_0.var_987A)) {
      continue;
    }

    if(var_0 scripts\mp\utility::_meth_85C7()) {
      var_2 = var_0 _meth_854D();
      if(!scripts\mp\utility::isgesture(var_2)) {
        continue;
      }
    }

    if(isDefined(self.carrier)) {
      continue;
    }

    if(var_0 scripts\mp\utility::isusingremote()) {
      continue;
    }

    setpickedup(var_0);
  }
}

carryobjectasset() {
  if(level.gametype == "ball" || level.gametype == "tdef") {
    thread carryobjectusethink();
    return;
  }

  thread carryobjectproxthink();
}

carryobjectproxthink() {
  level endon("game_ended");
  if(isDefined(self.trigger)) {
    self.trigger endon("move_gameobject");
  }

  thread func_DAD2();
  for(;;) {
    if(self.usetime && self.var_115DF[self.claimteam] >= self.usetime) {
      self.curprogress = 0;
      self.var_115DF[self.claimteam] = self.curprogress;
      var_0 = getearliestclaimplayer();
      if(isDefined(self.onenduse)) {
        self[[self.onenduse]](func_7E29(), var_0, isDefined(var_0));
      }

      if(isDefined(var_0)) {
        setpickedup(var_0);
      }

      setclaimteam("none");
      self.claimplayer = undefined;
    }

    if(self.claimteam != "none") {
      if(self.usetime) {
        if(!self.numtouching[self.claimteam]) {
          if(isDefined(self.onenduse)) {
            self[[self.onenduse]](func_7E29(), self.claimplayer, 0);
          }

          setclaimteam("none");
          self.claimplayer = undefined;
        } else {
          self.curprogress = self.curprogress + 50 * self.userate;
          self.var_115DF[self.claimteam] = self.curprogress;
          if(self.ownerteam != level.otherteam[self.claimteam]) {
            self.var_115DF[level.otherteam[self.claimteam]] = 0;
          }

          if(isDefined(self.onuseupdate)) {
            self[[self.onuseupdate]](func_7E29(), self.curprogress / self.usetime, 50 * self.userate / self.usetime, self.claimplayer);
          }
        }
      } else {
        if(scripts\mp\utility::isreallyalive(self.claimplayer)) {
          setpickedup(self.claimplayer);
        }

        setclaimteam("none");
        self.claimplayer = undefined;
      }
    }

    wait(0.05);
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

func_CB44(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self.var_38ED = 0;
  if(isDefined(var_0.ballindex)) {
    var_1 = 1024;
  } else {
    var_1 = 4096;
  }

  for(;;) {
    if(distancesquared(self.origin, var_0.trigger.origin) > var_1) {
      break;
    }

    wait(0.2);
  }

  if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
    self.var_38ED = 1;
  }
}

setpickedup(var_0) {
  if(isai(var_0) && isDefined(var_0.triggerportableradarping)) {
    return;
  }

  if(isDefined(var_0.carryobject) || isDefined(self.carryweapon) && !var_0 scripts\engine\utility::isweaponallowed()) {
    if(isDefined(self.onpickupfailed)) {
      self[[self.onpickupfailed]](var_0);
    }

    return;
  }

  var_0 giveobject(self);
  setcarrier(var_0);
  if(isDefined(self.trigger getlinkedparent())) {
    for(var_1 = 0; var_1 < self.visuals.size; var_1++) {
      self.visuals[var_1] unlink();
    }

    self.trigger unlink();
  }

  for(var_1 = 0; var_1 < self.visuals.size; var_1++) {
    self.visuals[var_1] hide();
  }

  self.trigger.origin = self.trigger.origin + (0, 0, 10000);
  self.trigger scripts\mp\movers::stop_handling_moving_platforms();
  self notify("pickup_object");
  if(isDefined(self.onpickup)) {
    self[[self.onpickup]](var_0);
  }

  updatecompassicons();
  updateworldicons();
}

updatecurrentoutput() {
  level endon("game_ended");
  if(isDefined(self.trigger)) {
    self.trigger endon("move_gameobject");
  }

  if(level.gametype == "front") {
    self.carrier endon("disconnect");
  }

  for(;;) {
    if(isDefined(self.carrier)) {
      self.curorigin = self.carrier.origin + (0, 0, 75);
    } else {
      self.curorigin = self.trigger.origin;
    }

    wait(0.05);
  }
}

func_12E6F() {
  level endon("game_ended");
  if(isDefined(self.trigger)) {
    self.trigger endon("move_gameobject");
  }

  if(level.gametype == "front") {
    self.carrier endon("disconnect");
  }

  thread updatecurrentoutput();
  if(!isDefined(self.objpingdelay)) {
    self.objpingdelay = 4;
  }

  for(;;) {
    if(isDefined(self.carrier)) {
      if(getdvarint("com_codcasterEnabled", 0) == 1) {
        if(isDefined(self.objpoints["mlg_allies"])) {
          self.objpoints["mlg_allies"] scripts\mp\objpoints::updateorigin(self.curorigin);
        }

        if(isDefined(self.objpoints["mlg_axis"])) {
          self.objpoints["mlg_axis"] scripts\mp\objpoints::updateorigin(self.curorigin);
        }
      }

      foreach(var_1 in level.teamnamelist) {
        self.objpoints[var_1] scripts\mp\objpoints::updateorigin(self.curorigin);
      }

      foreach(var_1 in level.teamnamelist) {
        if((self.visibleteam == "friendly" || self.visibleteam == "any") && isfriendlyteam(var_1) && self.objidpingenemy) {
          if(self.objpoints[var_1].var_9F51) {
            self.objpoints[var_1].alpha = self.objpoints[var_1].basealpha;
            self.objpoints[var_1] fadeovertime(self.objpingdelay);
            self.objpoints[var_1].alpha = 0;
          }

          if(self.teamobjids[var_1] != -1) {
            scripts\mp\objidpoolmanager::minimap_objective_position(self.teamobjids[var_1], self.curorigin);
          }
        }
      }

      foreach(var_1 in level.teamnamelist) {
        if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam(var_1) && self.objidpingfriendly) {
          if(self.objpoints[var_1].var_9F51) {
            self.objpoints[var_1].alpha = self.objpoints[var_1].basealpha;
            self.objpoints[var_1] fadeovertime(self.objpingdelay);
            self.objpoints[var_1].alpha = 0;
          }

          if(self.teamobjids[var_1] != -1) {
            scripts\mp\objidpoolmanager::minimap_objective_position(self.teamobjids[var_1], self.curorigin);
          }
        }
      }

      scripts\mp\utility::wait_endon(self.objpingdelay, "dropped", "reset");
      continue;
    }

    foreach(var_1 in level.teamnamelist) {
      self.objpoints[var_1] scripts\mp\objpoints::updateorigin(self.curorigin + self.offset3d);
    }

    wait(0.05);
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

gameobjects_getcurrentprimaryweapon() {
  var_0 = self getcurrentweapon();
  var_1 = self getcurrentprimaryweapon();
  if("alt_" + var_1 == var_0) {
    return var_0;
  }

  return var_1;
}

watchcarryobjectweaponswitch(var_0) {
  self endon("goal_scored");
  var_1 = gettime();
  var_2 = scripts\mp\utility::func_11383(var_0, 1);
  if(isDefined(var_2)) {
    if(var_2 == 0) {
      if(var_1 == gettime()) {
        waittillframeend;
      }

      if(isDefined(self.carryobject)) {
        self.carryobject thread setdropped();
        return;
      }
    }
  }
}

giveobject(var_0) {
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
    scripts\engine\utility::allow_weapon_switch(0);
  } else if(!var_0.allowweapons) {
    scripts\engine\utility::allow_weapon(0);
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
  }
}

returnobjectiveid() {
  self.isresetting = 1;
  self notify("reset");
  for(var_0 = 0; var_0 < self.visuals.size; var_0++) {
    var_1 = self.visuals[var_0] getlinkedparent();
    if(isDefined(var_1)) {
      self.visuals[var_0] unlink();
    }

    if(isbombmode() && self.visuals[var_0].var_336 == "sd_bomb") {
      self.visuals[var_0].origin = level.bombrespawnpoint;
      self.visuals[var_0].angles = level.bombrespawnangles;
    } else {
      self.visuals[var_0].origin = self.visuals[var_0].baseorigin;
      self.visuals[var_0].angles = self.visuals[var_0].baseangle;
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
  updateworldicons();
  updatecompassicons();
  self.isresetting = 0;
  self notify("reset_done");
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
  if(level.gametype == "ball" || level.gametype == "tdef") {
    self.trigger linkto(self.visuals[0]);
  }

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
  var_0.carryobject thread setdropped(1);
}

setdropped(var_0) {
  if(isDefined(self.setdropped)) {
    if([
        [self.setdropped]
      ]()) {
      return;
    }
  }

  self.isresetting = 1;
  self.var_E25D = undefined;
  self notify("dropped");
  foreach(var_2 in self.visuals) {
    var_2.var_D887 = var_2 setcontents(0);
  }

  if(isDefined(self.carrier)) {
    var_4 = self.carrier.origin;
  } else {
    var_4 = self.curorigin;
  }

  if(scripts\mp\utility::istrue(level.botsenabled) || isDefined(self.ftldrop) || touchingdroptonavmeshtrigger(var_4) || level.mapname == "mp_junk" && level.gametype == "ctf" && !self.carrier touchingarbitraryuptrigger()) {
    var_4 = getclosestpointonnavmesh(var_4);
    if(isDefined(self.ftldrop)) {
      self.ftldrop = undefined;
    }
  }

  var_5 = 20;
  var_6 = 4000;
  var_7 = (0, 0, 0);
  if(self.carrier touchingarbitraryuptrigger()) {
    var_8 = self.carrier getworldupreferenceangles();
    var_7 = anglestoup(var_8);
    if(var_7[2] < 0) {
      var_5 = -20;
      var_6 = -4000;
    }
  }

  var_9 = var_4 + (0, 0, var_5);
  var_0A = var_4 - (0, 0, var_6);
  var_0B = scripts\common\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
  var_0C = [];
  var_0C[0] = self.visuals[0];
  var_0C[1] = self.carrier;
  if(isDefined(self.carrier) && self.carrier.team != "spectator") {
    if(level.gametype != "ctf") {
      var_0D = scripts\common\trace::capsule_trace(var_9, var_0A, 8, 16, (0, 0, 0), var_0C, var_0B, 0);
    } else {
      var_0D = scripts\common\trace::capsule_trace(var_0A, var_0B, 2, 4, (0, 0, 0), var_0D, var_0C, 0);
    }
  } else {
    var_0D = scripts\common\trace::ray_trace(self.safeorigin + (0, 0, 20), self.safeorigin - (0, 0, 20), var_0D, var_0C, 0);
    if(isplayer(var_0D["entity"])) {
      var_0D["entity"] = undefined;
    }
  }

  foreach(var_2 in self.visuals) {
    var_2 setcontents(var_2.var_D887);
  }

  var_10 = self.carrier;
  var_11 = 0;
  if(isDefined(var_0D)) {
    var_12 = randomfloat(360);
    var_13 = var_0D["position"];
    if(isDefined(self.visualgroundoffset)) {
      var_13 = var_13 + self.visualgroundoffset;
    }

    var_14 = (cos(var_12), sin(var_12), 0);
    var_14 = vectornormalize(var_14 - var_0D["normal"] * vectordot(var_14, var_0D["normal"]));
    var_15 = 0;
    if(level.gametype == "ctf" || isbombmode()) {
      if(self.carrier touchingarbitraryuptrigger() && var_7[2] < 0) {
        var_16 = (0, 0, -180);
        if(isDefined(self.visualgroundoffset)) {
          var_13 = var_13 - self.visualgroundoffset * 2;
        }

        if(level.gametype == "ctf") {
          var_15 = -80;
        }

        if(isbombmode()) {
          var_15 = -30;
        }
      } else {
        var_16 = (0, 0, 0);
      }
    } else {
      var_16 = vectortoangles(var_15);
    }

    for(var_17 = 0; var_17 < self.visuals.size; var_17++) {
      self.visuals[var_17].origin = var_13;
      self.visuals[var_17].angles = var_16;
      self.visuals[var_17] show();
    }

    self.trigger.origin = var_13 + (0, 0, var_15);
    self.curorigin = self.trigger.origin;
    var_18 = undefined;
    if(!isplayer(var_0D["entity"]) || !isbot(var_0D["entity"]) || !isagent(var_0D["entity"])) {
      var_18 = var_0D["entity"];
    }

    if(isDefined(var_18) && isDefined(var_18.triggerportableradarping)) {
      var_19 = var_18 getlinkedparent();
      if(isDefined(var_19)) {
        var_18 = var_19;
      }
    }

    if(isDefined(var_18)) {
      if(isDefined(var_18.var_9B09) && var_18.var_9B09 == 1) {
        self.var_E25D = 1;
      } else {
        for(var_17 = 0; var_17 < self.visuals.size; var_17++) {
          self.visuals[var_17] linkto(var_18);
        }

        self.trigger linkto(var_18);
        var_1A = spawnStruct();
        var_1A.carryobject = self;
        var_1A.deathoverridecallback = ::carryobject_overridemovingplatformdeath;
        self.trigger thread scripts\mp\movers::handle_moving_platforms(var_1A);
      }
    }

    if(!isDefined(var_0)) {
      thread func_CB49();
    }
  } else {
    for(var_17 = 0; var_17 < self.visuals.size; var_17++) {
      self.visuals[var_17].origin = self.visuals[var_17].baseorigin;
      self.visuals[var_17].angles = self.visuals[var_17].baseangle;
      self.visuals[var_17] show();
    }

    self.trigger.origin = self.trigger.baseorigin;
    self.curorigin = self.trigger.baseorigin;
  }

  if(isDefined(self.ondrop) && !isDefined(var_0)) {
    self[[self.ondrop]](var_10);
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

  self.carrier thread takeobject(self);
  self.carrier = undefined;
  self notify("carrier_cleared");
}

func_CB49() {
  self endon("pickup_object");
  self endon("reset_done");
  wait(0.05);
  if(isDefined(self.var_E25D)) {
    self.var_E25D = undefined;
    returnobjectiveid();
    return;
  }

  for(var_0 = 0; var_0 < level.radtriggers.size; var_0++) {
    if(!self.visuals[0] istouching(level.radtriggers[var_0])) {
      continue;
    }

    returnobjectiveid();
    return;
  }

  for(var_0 = 0; var_0 < level.minetriggers.size; var_0++) {
    if(!self.visuals[0] istouching(level.minetriggers[var_0])) {
      continue;
    }

    returnobjectiveid();
    return;
  }

  for(var_0 = 0; var_0 < level.hurttriggers.size; var_0++) {
    if(!self.visuals[0] istouching(level.hurttriggers[var_0])) {
      continue;
    }

    returnobjectiveid();
    return;
  }

  if(scripts\mp\utility::istrue(level.ballallowedtriggers.size)) {
    self.allowedintrigger = 0;
    foreach(var_2 in level.ballallowedtriggers) {
      if(self.visuals[0] istouching(var_2)) {
        self.allowedintrigger = 1;
        break;
      }
    }
  }

  foreach(var_2 in level.var_C7B3) {
    if(scripts\mp\utility::istrue(self.allowedintrigger)) {
      break;
    }

    if(!self.visuals[0] istouching(var_2)) {
      continue;
    }

    returnobjectiveid();
    return;
  }

  if(isDefined(self.var_2667)) {
    wait(self.var_2667);
    if(!isDefined(self.carrier)) {
      returnobjectiveid();
    }
  }
}

takeobject(var_0) {
  if(isDefined(self.carryicon)) {
    self.carryicon scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self)) {
    self.carryobject = undefined;
  }

  self notify("drop_object");
  if(var_0.triggertype == "proximity") {
    thread func_CB44(var_0);
  }

  if(scripts\mp\utility::isreallyalive(self) && !var_0.allowweapons) {
    if(isDefined(var_0.carryweapon)) {
      var_1 = isDefined(var_0.keepcarryweapon) && var_0.keepcarryweapon;
      if(!var_0.carrierhascarryweaponinloadout && !var_1) {
        if(isDefined(var_0.ballindex)) {
          wait(0.25);
        }

        self notify("clear_carrier");
        if(scripts\mp\utility::isreliablyswitchingtoweapon(var_0.carryweapon)) {
          scripts\mp\utility::func_1529(var_0.carryweapon);
        } else {
          scripts\mp\utility::_takeweapon(var_0.carryweapon);
        }

        var_2 = var_0.lastdroppableweaponobj;
        thread scripts\mp\utility::func_72ED(var_2);
      }

      self enableweaponpickup();
      scripts\engine\utility::allow_weapon_switch(1);
      return;
    }

    if(!var_0.allowweapons) {
      scripts\engine\utility::allow_weapon(1);
      return;
    }
  }
}

trackcarrier() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  while(isDefined(self.carryobject) && scripts\mp\utility::isreallyalive(self)) {
    if(self isonground()) {
      var_0 = bulletTrace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);
      if(var_0["fraction"] < 1) {
        self.carryobject.safeorigin = var_0["position"];
      }
    }

    wait(0.05);
  }
}

manualdropthink() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  for(;;) {
    while(self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed()) {
      wait(0.05);
    }

    while((!self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed()) || self meleebuttonpressed()) {
      wait(0.05);
    }

    if(isDefined(self.carryobject) && !self usebuttonpressed()) {
      self.carryobject thread setdropped();
    }
  }
}

deleteuseobject() {
  foreach(var_1 in level.teamnamelist) {
    scripts\mp\objidpoolmanager::returnminimapid(self.teamobjids[var_1]);
    scripts\mp\objpoints::deleteobjpoint(self.objpoints[var_1]);
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_2 = "mlg_" + var_1;
      scripts\mp\objpoints::deleteobjpoint(self.objpoints[var_2]);
    }
  }

  self.trigger delete();
  self.trigger = undefined;
  self notify("deleted");
}

createuseobject(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "useObject";
  var_4.curorigin = var_1.origin;
  var_4.ownerteam = var_0;
  var_4.entnum = var_1 getentitynumber();
  var_4.keyobject = undefined;
  if(issubstr(var_1.classname, "use")) {
    var_4.triggertype = "use";
  } else {
    var_4.triggertype = "proximity";
  }

  var_4.trigger = var_1;
  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    var_2[var_5].baseorigin = var_2[var_5].origin;
    var_2[var_5].baseangle = var_2[var_5].angles;
  }

  var_4.visuals = var_2;
  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_4.offset3d = var_3;
  var_4.var_4465 = [];
  foreach(var_7 in level.teamnamelist) {
    var_4.teamobjids[var_7] = ::scripts\mp\objidpoolmanager::requestminimapid(99);
    if(var_4.teamobjids[var_7] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_4.teamobjids[var_7], "invisible", var_4.curorigin);
      scripts\mp\objidpoolmanager::minimap_objective_team(var_4.teamobjids[var_7], var_7);
    }

    var_4.objpoints[var_7] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_7 + "_" + var_4.entnum, var_4.curorigin + var_3, var_7, undefined);
    var_4.objpoints[var_7].alpha = 0;
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_8 = "mlg_" + var_7;
      var_4.objpoints[var_8] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_8 + "_" + var_4.entnum, var_4.curorigin + var_3, var_7, undefined);
      var_4.objpoints[var_8].alpha = 0;
    }
  }

  var_4.interactteam = "none";
  var_4.var_13DCA = [];
  var_4.visibleteam = "none";
  var_4.onuse = undefined;
  var_4.oncantuse = undefined;
  var_4.var_130EB = "default";
  var_4.usetime = 10000;
  var_4.curprogress = 0;
  var_4.stalemate = 0;
  var_4.wasstalemate = 0;
  var_4.var_115DF = [];
  var_4.var_115DF["none"] = 0;
  var_4.var_115DF["allies"] = 0;
  var_4.var_115DF["axis"] = 0;
  if(var_4.triggertype == "proximity") {
    var_4.teamusetimes = [];
    var_4.teamusetexts = [];
    var_4.numtouching["neutral"] = 0;
    var_4.touchlist["neutral"] = [];
    var_4.numtouching["none"] = 0;
    var_4.touchlist["none"] = [];
    foreach(var_0B in level.teamnamelist) {
      var_4.numtouching[var_0B] = 0;
      var_4.touchlist[var_0B] = [];
    }

    var_4.userate = 0;
    var_4.claimteam = "none";
    var_4.claimplayer = undefined;
    var_4.lastclaimteam = "none";
    var_4.lastclaimtime = 0;
    var_4.mustmaintainclaim = 0;
    var_4.cancontestclaim = 0;
    var_4 thread func_130B0();
  } else {
    var_4.userate = 1;
    var_4 thread useobjectusethink();
  }

  return var_4;
}

setkeyobject(var_0) {
  self.keyobject = var_0;
}

useobjectusethink() {
  level endon("game_ended");
  self endon("deleted");
  for(;;) {
    self.trigger waittill("trigger", var_0);
    if(!scripts\mp\utility::isreallyalive(var_0)) {
      continue;
    }

    if(!caninteractwith(var_0.pers["team"])) {
      continue;
    }

    if(!var_0 isonground()) {
      continue;
    }

    if(!var_0 scripts\mp\utility::isjuggernaut() && scripts\mp\utility::iskillstreakweapon(var_0 getcurrentweapon())) {
      continue;
    }

    if(isDefined(self.var_13056)) {
      if(!self[[self.var_13056]](var_0)) {
        continue;
      }
    }

    if(isDefined(self.keyobject) && !isDefined(var_0.carryobject) || var_0.carryobject != self.keyobject) {
      if(isDefined(self.oncantuse)) {
        self[[self.oncantuse]](var_0);
      }

      continue;
    }

    if(var_0 hasweapon(self.useweapon)) {
      continue;
    }

    if(!var_0 scripts\engine\utility::isweaponallowed()) {
      continue;
    }

    var_1 = 1;
    if(self.usetime > 0) {
      if(isDefined(self.onbeginuse)) {
        var_0 updateuiprogress(self, 0);
        self[[self.onbeginuse]](var_0);
      }

      if(!isDefined(self.keyobject)) {
        thread func_3930();
      }

      var_2 = var_0.pers["team"];
      var_1 = useholdthink(var_0);
      self notify("finished_use");
      if(isDefined(self.onenduse)) {
        self[[self.onenduse]](var_2, var_0, var_1);
      }
    }

    if(!var_1) {
      continue;
    }

    if(isDefined(self.onuse)) {
      self[[self.onuse]](var_0);
    }
  }
}

func_3E22(var_0) {
  if(!isDefined(self.keyobject)) {
    return 1;
  }

  if(!isDefined(var_0.carryobject)) {
    return 0;
  }

  var_1 = self.keyobject;
  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_3 in var_1) {
    if(var_3 == var_0.carryobject) {
      return 1;
    }
  }

  return 0;
}

func_3930() {
  level endon("game_ended");
  self endon("deleted");
  self endon("finished_use");
  for(;;) {
    self.trigger waittill("trigger", var_0);
    if(!scripts\mp\utility::isreallyalive(var_0)) {
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
  if(scripts\mp\utility::isreallyalive(self.claimplayer)) {
    var_1 = self.claimplayer;
  } else {
    var_1 = undefined;
  }

  if(self.touchlist[var_0].size > 0) {
    var_2 = undefined;
    var_3 = getarraykeys(self.touchlist[var_0]);
    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = self.touchlist[var_0][var_3[var_4]];
      if(scripts\mp\utility::isreallyalive(var_5.player) && !isDefined(var_2) || var_5.starttime < var_2) {
        var_1 = var_5.player;
        var_2 = var_5.starttime;
      }
    }
  }

  return var_1;
}

func_130B0() {
  level endon("game_ended");
  self endon("deleted");
  thread func_DAD2();
  for(;;) {
    if(self.cancontestclaim && self.stalemate != self.wasstalemate) {
      if(self.stalemate) {
        if(isDefined(self.oncontested)) {
          self[[self.oncontested]]();
        }
      } else {
        var_0 = "none";
        if(self.numtouching["allies"]) {
          var_0 = "allies";
        } else if(self.numtouching["axis"]) {
          var_0 = "axis";
        }

        if(var_0 == "none" && self.ownerteam != "neutral") {
          var_0 = self.ownerteam;
        }

        if(isDefined(self.onuncontested)) {
          self[[self.onuncontested]](var_0);
        }

        setclaimteam("none");
        self.claimplayer = undefined;
      }

      self.wasstalemate = self.stalemate;
    } else if(self.mustmaintainclaim && self.ownerteam != "neutral" && !self.numtouching[self.ownerteam]) {
      if(isDefined(self.onunoccupied)) {
        self[[self.onunoccupied]]();
      }

      setclaimteam("none");
      self.claimplayer = undefined;
    }

    if(self.claimteam != "none") {
      if(!self.usetime) {
        if(!self.stalemate) {
          var_1 = getearliestclaimplayer();
          if(isDefined(self.onuse)) {
            self[[self.onuse]](self.claimplayer);
          }

          setclaimteam("none");
          self.claimplayer = undefined;
        }
      } else if(self.usetime && self.var_115DF[self.claimteam] >= self.usetime) {
        self.curprogress = 0;
        self.var_115DF[self.claimteam] = self.curprogress;
        var_1 = getearliestclaimplayer();
        if(isDefined(self.onenduse)) {
          self[[self.onenduse]](self.claimteam, var_1, isDefined(var_1));
        }

        if(isDefined(var_1) && isDefined(self.onuse)) {
          self[[self.onuse]](var_1);
        }

        setclaimteam("none");
        self.claimplayer = undefined;
      } else if(!self.stalemate && self.usetime && self.ownerteam != self.claimteam) {
        if(!self.numtouching[self.claimteam]) {
          if(isDefined(self.onenduse)) {
            self[[self.onenduse]](self.claimteam, self.claimplayer, 0);
          }

          setclaimteam("none");
          self.claimplayer = undefined;
        } else {
          self.curprogress = self.curprogress + 50 * self.userate;
          self.var_115DF[self.claimteam] = self.curprogress;
          if(self.ownerteam != level.otherteam[self.claimteam]) {
            self.var_115DF[level.otherteam[self.claimteam]] = 0;
          }

          if(isDefined(self.onuseupdate)) {
            self[[self.onuseupdate]](self.claimteam, self.var_115DF[self.claimteam] / self.usetime, 50 * self.userate / self.usetime, self.claimplayer);
          }
        }
      }
    }

    wait(0.05);
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

useobjectdecay(var_0) {
  level endon("game_ended");
  self endon("deleted");
  for(;;) {
    wait(0.1);
    if(self.ownerteam != "neutral") {
      if(self.numtouching[self.ownerteam] >= 1 && !self.stalemate) {
        self.curprogress = 0;
        self.var_115DF[self.claimteam] = self.curprogress;
        break;
      }
    }

    if(self.claimteam == "none") {
      if(self.usetime) {
        wait(0.1);
        if(self.claimteam == "none" && !self.stalemate) {
          self.curprogress = self.curprogress - 50;
        }

        self.var_115DF[self.lastclaimteam] = self.curprogress;
      }

      if(self.var_115DF[self.lastclaimteam] <= 0) {
        self.curprogress = 0;
        self.var_115DF[self.lastclaimteam] = self.curprogress;
        break;
      }
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

func_3895(var_0) {
  if(isDefined(self.carrier)) {
    return 0;
  }

  if(self.cancontestclaim) {
    var_1 = animscriptedthirdperson(var_0.pers["team"]);
    if(var_1 != 0) {
      return 0;
    }
  }

  if(func_3E22(var_0)) {
    return 1;
  }

  return 0;
}

func_DAD2() {
  level endon("game_ended");
  self endon("deleted");
  var_0 = self.entnum;
  for(;;) {
    self.trigger waittill("trigger", var_1);
    if(!scripts\mp\utility::isreallyalive(var_1)) {
      continue;
    }

    if(isagent(var_1)) {
      continue;
    }

    if(!scripts\mp\utility::isgameparticipant(var_1)) {
      continue;
    }

    if(isDefined(self.carrier)) {
      continue;
    }

    if(isDefined(var_1.spawningafterremotedeath)) {
      continue;
    }

    if(var_1 _meth_8568()) {
      continue;
    }

    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }

    if(!isDefined(var_1.var_987A)) {
      continue;
    }

    var_2 = getrelativeteam(var_1.pers["team"]);
    if(isDefined(self.teamusetimes[var_2]) && self.teamusetimes[var_2] < 0) {
      continue;
    }

    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_1)) {
      continue;
    }

    if(self.claimteam == "none" && caninteractwith(var_1.pers["team"], var_1)) {
      if(func_3895(var_1)) {
        if(!func_DAD1(var_1)) {
          continue;
        }

        setclaimteam(var_1.pers["team"]);
        self.claimplayer = var_1;
        if(isDefined(self.teamusetimes[var_2])) {
          self.usetime = self.teamusetimes[var_2];
        }

        if(self.usetime && isDefined(self.onbeginuse)) {
          self[[self.onbeginuse]](self.claimplayer);
        }
      } else if(isDefined(self.oncantuse)) {
        self[[self.oncantuse]](var_1);
      }
    }

    if(scripts\mp\utility::isreallyalive(var_1) && !isDefined(var_1.touchtriggers[var_0])) {
      var_1 thread func_127CA(self);
    }
  }
}

func_DAD1(var_0) {
  if(!isDefined(self.requireslos)) {
    return 1;
  }

  var_1 = var_0 getEye();
  var_2 = scripts\common\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  var_3 = [];
  if(level.gametype == "tdef" || scripts\mp\utility::istrue(level.devball)) {
    var_4 = self.trigger.origin + (0, 0, 16);
    var_5 = 0;
    var_3[0] = self.visuals[0];
  } else if(level.gametype == "ball") {
    var_4 = self.trigger.origin + (0, 0, 8);
    var_5 = 0;
    var_3[0] = self.visuals[0];
  } else {
    var_4 = self.trigger.origin + (0, 0, 32);
    var_5 = 1;
    var_3[0] = self.visuals;
  }

  var_3[1] = self.carrier;
  var_6 = scripts\common\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  if(var_6["fraction"] != 1 && var_5) {
    var_4 = self.trigger.origin + (0, 0, 16);
    var_6 = scripts\common\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  }

  if(var_6["fraction"] != 1) {
    var_4 = self.trigger.origin + (0, 0, 0);
    var_6 = scripts\common\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  }

  return var_6["fraction"] == 1;
}

setclaimteam(var_0) {
  if(!isDefined(self.claimgracetime)) {
    self.claimgracetime = 1000;
  }

  if(self.claimteam == "none" && gettime() - self.lastclaimtime > self.claimgracetime) {
    self.curprogress = 0;
    self.var_115DF[var_0] = self.curprogress;
  } else if(var_0 != "none" && var_0 != self.lastclaimteam) {
    self.curprogress = 0;
    self.var_115DF[var_0] = self.curprogress;
  }

  self.lastclaimteam = self.claimteam;
  self.lastclaimtime = gettime();
  self.claimteam = var_0;
  func_12F57();
}

func_7E29() {
  return self.claimteam;
}

func_127CA(var_0) {
  var_1 = self.pers["team"];
  var_0.numtouching[var_1]++;
  var_2 = self.guid;
  var_3 = spawnStruct();
  var_3.player = self;
  var_3.starttime = gettime();
  var_0.touchlist[var_1][var_2] = var_3;
  if(!isDefined(var_0.nousebar)) {
    var_0.nousebar = 0;
  }

  self.touchtriggers[var_0.entnum] = var_0.trigger;
  var_0 func_12F57();
  while(scripts\mp\utility::isreallyalive(self) && isDefined(var_0.trigger) && self istouching(var_0.trigger) && !level.gameended) {
    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_0)) {
      break;
    }

    if(isplayer(self) && var_0.usetime > 50) {
      updateuiprogress(var_0, 1);
    }

    wait(0.05);
  }

  if(isDefined(self)) {
    if(var_0.usetime > 50) {
      if(isplayer(self)) {
        updateuiprogress(var_0, 0);
      }

      self.touchtriggers[var_0.entnum] = undefined;
    } else {
      self.touchtriggers[var_0.entnum] = undefined;
    }
  }

  if(level.gameended) {
    return;
  }

  var_0.var_C405 = var_0.touchlist;
  var_0.touchlist[var_1][var_2] = undefined;
  var_0.numtouching[var_1]--;
  var_0 func_12F57();
}

migrationcapturereset(var_0) {
  var_0.migrationcapturereset = 1;
  level waittill("host_migration_begin");
  if(!isDefined(var_0) || !isDefined(self)) {
    return;
  }

  var_0 setclientomnvar("ui_securing", 0);
  var_0 setclientomnvar("ui_securing_progress", 0);
  self.migrationcapturereset = undefined;
}

animscriptedthirdperson(var_0) {
  return self.numtouching[scripts\mp\utility::getotherteam(var_0)];
}

updateuiprogress(var_0, var_1) {
  if(!isDefined(level.hostmigrationtimer)) {
    var_2 = 0;
    if(isDefined(var_0.var_115DF) && isDefined(var_0.claimteam)) {
      if(var_0.var_115DF[var_0.claimteam] > var_0.usetime) {
        var_0.var_115DF[var_0.claimteam] = var_0.usetime;
      }

      var_2 = var_0.var_115DF[var_0.claimteam] / var_0.usetime;
    } else {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }

      var_2 = var_0.curprogress / var_0.usetime;
    }

    if(level.gametype == "ctf" && !isDefined(var_0.id)) {
      if(var_1 && scripts\mp\utility::istrue(var_0.stalemate)) {
        if(!isDefined(self.var_12B1C)) {
          if(!isDefined(self.var_12B1B)) {
            self.var_12B1B = 1;
          }

          self setclientomnvar("ui_objective_state", -1);
          self.var_12B1C = 1;
        }

        var_2 = 0.01;
      } else if(var_1 && isDefined(self.var_12B1B) && isDefined(var_0.stalemate) && !var_0.stalemate && var_0.ownerteam != self.team) {
        self setclientomnvar("ui_objective_state", 1);
        self.var_12B1B = 1;
        self.var_12B1C = undefined;
      } else if(var_1 && isDefined(self.var_12B1B) && isDefined(var_0.stalemate) && !var_0.stalemate && var_0.ownerteam == self.team) {
        self setclientomnvar("ui_objective_state", 2);
        self.var_12B1B = 1;
        self.var_12B1C = undefined;
      } else {
        if(!var_1 && isDefined(self.var_12B1C)) {
          self setclientomnvar("ui_objective_state", 0);
          self.var_12B1B = undefined;
        }

        if(var_1 && !isDefined(self.var_12B1C) && var_0.ownerteam == self.team) {
          self setclientomnvar("ui_objective_state", 0);
          self.var_12B1B = undefined;
        }

        if(var_1 && !isDefined(self.var_12B1B)) {
          if(var_0.ownerteam != self.team) {
            self setclientomnvar("ui_objective_state", 1);
            self.var_12B1B = 1;
          } else if(var_0.interactteam == "any") {
            self setclientomnvar("ui_objective_state", 2);
            self.var_12B1B = 1;
          }
        }

        self.var_12B1C = undefined;
      }

      if(!var_1) {
        var_2 = 0.01;
        self setclientomnvar("ui_objective_state", 0);
        self.var_12B1B = undefined;
      }

      if(var_2 != 0) {
        if(isDefined(var_0.var_115DF) && isDefined(var_0.claimteam) && var_1) {
          self setclientomnvar("ui_objective_progress", var_0.var_115DF[self.team] / var_0.usetime);
        } else {
          self setclientomnvar("ui_objective_progress", var_2);
        }
      }
    }

    if(func_8BE7() && isDefined(var_0.id) && var_0.id == "domFlag" || var_0.id == "hardpoint") {
      var_3 = 0;
      if(level.gametype == "koth" || level.gametype == "grnd") {
        var_3 = 7;
        if(scripts\mp\utility::istrue(level.usehqrules) && isDefined(var_0.ownerteam) && var_0.ownerteam != "neutral") {
          var_3 = 8;
        }
      } else {
        if(var_0.label == "_a") {
          var_3 = 1;
        } else if(var_0.label == "_b") {
          var_3 = 2;
        } else if(var_0.label == "_c") {
          var_3 = 3;
        }

        if(scripts\mp\utility::istrue(var_0.neutralizing)) {
          var_3 = var_3 + 3;
        }
      }

      if(var_1 && isDefined(var_0.stalemate) && var_0.stalemate) {
        if(!isDefined(self.ui_dom_stalemate)) {
          if(!isDefined(self.ui_dom_securing)) {
            self.ui_dom_securing = 1;
          }

          self setclientomnvar("ui_objective_state", -1);
          self.ui_dom_stalemate = 1;
        }

        var_2 = 0.01;
      } else if(var_1 && isDefined(self.ui_dom_securing) && isDefined(var_0.stalemate) && !var_0.stalemate && var_0.ownerteam != self.team) {
        self setclientomnvar("ui_objective_state", var_3);
        self.ui_dom_securing = 1;
        self.ui_dom_stalemate = undefined;
      } else {
        if(!var_1 && isDefined(self.ui_dom_stalemate)) {
          self setclientomnvar("ui_objective_state", 0);
          self.ui_dom_securing = undefined;
        }

        if(var_1 && !isDefined(self.ui_dom_stalemate) && var_0.ownerteam == self.team) {
          self setclientomnvar("ui_objective_state", 0);
          self.ui_dom_securing = undefined;
        }

        if(var_1 && !isDefined(self.ui_dom_securing) && var_0.ownerteam != self.team) {
          self setclientomnvar("ui_objective_state", var_3);
          self.ui_dom_securing = 1;
        }

        self.ui_dom_stalemate = undefined;
      }

      if(!var_1 || !var_0 caninteractwith(self.team) && !isDefined(var_0.stalemate) || isDefined(var_0.stalemate) && !var_0.stalemate) {
        var_2 = 0.01;
        self setclientomnvar("ui_objective_state", 0);
        self.ui_dom_securing = undefined;
      }

      if(var_2 != 0) {
        if(isDefined(var_0.var_115DF) && isDefined(var_0.claimteam) && var_1) {
          self setclientomnvar("ui_objective_progress", var_0.var_115DF[self.team] / var_0.usetime);
          return;
        }

        self setclientomnvar("ui_objective_progress", var_2);
        return;
      }

      return;
    }

    if(isbombmode() && isDefined(var_0.id) && var_0.id == "bomb_zone" || var_0.id == "defuse_object") {
      if(isDefined(self)) {
        if(var_1 && isDefined(self)) {
          if(!isDefined(self.ui_bomb_planting_defusing)) {
            var_4 = 0;
            if(var_0.id == "bomb_zone") {
              var_4 = 1;
            } else if(var_0.id == "defuse_object") {
              var_4 = 2;
            }

            self setclientomnvar("ui_objective_state", var_4);
            self.ui_bomb_planting_defusing = 1;
          }
        } else {
          self setclientomnvar("ui_objective_state", 0);
          self.ui_bomb_planting_defusing = undefined;
          var_2 = 0.01;
        }

        if(var_2 != 0) {
          if(isDefined(var_0.var_115DF) && isDefined(var_0.claimteam) && var_1) {
            self setclientomnvar("ui_objective_progress", var_0.var_115DF[self.team] / var_0.usetime);
            return;
          }

          self setclientomnvar("ui_objective_progress", var_2);
          return;
        }

        return;
      }

      return;
    }

    if(isDefined(var_0.id)) {
      var_4 = 0;
      switch (var_0.id) {
        case "care_package":
          var_4 = 1;
          break;

        case "intel":
          var_4 = 2;
          break;

        case "deployable_vest":
          var_4 = 3;
          break;

        case "deployable_weapon_crate":
          var_4 = 4;
          break;

        case "last_stand":
          var_4 = 5;
          if(isDefined(self.inlaststand) && self.inlaststand) {
            var_4 = 6;
          }
          break;

        case "breach":
          var_4 = 7;
          break;

        case "use":
          var_4 = 8;
          break;
      }

      func_12F55(var_2, var_1, var_4, var_0, var_0.usetime);
      return;
    }

    return;
  }
}

func_8BE7() {
  if(level.gametype == "dom" || level.gametype == "grind" || level.gametype == "koth" || level.gametype == "grnd" || level.gametype == "siege") {
    return 1;
  }

  return 0;
}

func_12F55(var_0, var_1, var_2, var_3, var_4) {
  if(var_1) {
    if(!isDefined(var_3.usedby)) {
      var_3.usedby = [];
    }

    if(!isDefined(self.migrationcapturereset)) {
      var_3 thread migrationcapturereset(self);
    }

    if(!existinarray(self, var_3.usedby)) {
      var_3.usedby[var_3.usedby.size] = self;
    }

    if(!isDefined(self.ui_securing)) {
      self setclientomnvar("ui_securing", var_2);
      self.ui_securing = 1;
    }
  } else {
    if(isDefined(var_3.usedby) && existinarray(self, var_3.usedby)) {
      var_3.usedby = scripts\engine\utility::array_remove(var_3.usedby, self);
    }

    self setclientomnvar("ui_securing", 0);
    self.ui_securing = undefined;
    var_0 = 0.01;
  }

  if(var_4 == 500) {
    var_0 = min(var_0 + 0.15, 1);
  }

  if(var_0 != 0) {
    self setclientomnvar("ui_securing_progress", var_0);
  }
}

existinarray(var_0, var_1) {
  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(var_3 == var_0) {
        return 1;
      }
    }
  }

  return 0;
}

func_12F57() {
  if(self.claimteam == "none" && self.ownerteam != "neutral" && self.ownerteam != "any") {
    var_0 = self.ownerteam;
  } else {
    var_0 = self.claimteam;
  }

  var_1 = self.numtouching[var_0];
  var_2 = 0;
  var_3 = 0;
  if(level.multiteambased) {
    foreach(var_5 in level.teamnamelist) {
      if(var_0 != var_5) {
        var_2 = var_2 + self.numtouching[var_5];
      }
    }
  } else {
    if(var_0 != "axis") {
      var_2 = var_2 + self.numtouching["axis"];
    }

    if(var_0 != "allies") {
      var_2 = var_2 + self.numtouching["allies"];
    }
  }

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

    var_1 = var_1 * var_8.player.objectivescaler;
    var_3 = var_8.player.objectivescaler;
  }

  self.stalemate = var_1 && var_2;
  self.userate = 0;
  if(var_1 && !var_2) {
    self.userate = min(var_1, 4);
  }

  if(isDefined(self.var_9D49) && self.var_9D49 && var_3 != 0) {
    self.userate = 1 * var_3;
    return;
  }

  if(isDefined(self.var_9D49) && self.var_9D49) {
    self.userate = 1;
  }
}

useholdthink(var_0) {
  var_0 notify("use_hold");
  if(isplayer(var_0)) {
    var_0 playerlinkto(self.trigger);
  } else {
    var_0 linkto(self.trigger);
  }

  var_0 playerlinkedoffsetenable();
  var_0 clientclaimtrigger(self.trigger);
  var_0.var_3FFA = self.trigger;
  var_0 allowmovement(0);
  var_0 unlink();
  if(isbombmode()) {
    if(scripts\mp\utility::isanymlgmatch() || scripts\mp\utility::istrue(level.silentplant) || var_0 scripts\mp\utility::_hasperk("specialty_engineer")) {
      self.useweapon = "briefcase_bomb_defuse_mp";
    } else {
      self.useweapon = "briefcase_bomb_mp";
    }
  }

  var_1 = self.useweapon;
  var_2 = var_0 getcurrentweapon();
  if(isDefined(var_1)) {
    if(var_2 == var_1) {
      var_2 = var_0.var_A9C6;
    }

    var_0.var_A9C6 = var_2;
    var_0 scripts\mp\utility::_giveweapon(var_1);
    var_0 setweaponammostock(var_1, 0);
    var_0 setweaponammoclip(var_1, 0);
    var_0 thread func_11382(var_1);
  } else {
    var_0 scripts\engine\utility::allow_weapon(0);
  }

  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  var_3 = useholdthinkloop(var_0, var_2);
  if(isDefined(var_0)) {
    var_0 detachusemodels();
    var_0 notify("done_using");
  }

  if(isDefined(var_1) && isDefined(var_0)) {
    var_0 scripts\mp\supers::unstowsuperweapon();
    if(var_0 scripts\mp\utility::isreliablyswitchingtoweapon(var_1)) {
      var_0 scripts\mp\utility::func_1529(var_1);
    } else {
      var_0 thread scripts\mp\utility::forcethirdpersonwhenfollowing(var_1);
    }
  }

  if(isDefined(var_3) && var_3) {
    var_0 allowmovement(1);
    return 1;
  }

  if(isDefined(var_0)) {
    var_0.var_3FFA = undefined;
    if(!isDefined(var_1)) {
      var_0 scripts\engine\utility::allow_weapon(1);
    }

    if(!scripts\mp\utility::isreallyalive(var_0)) {
      var_0.var_A64F = 1;
    }

    var_0 allowmovement(1);
  }

  self.inuse = 0;
  self.trigger releaseclaimedtrigger();
  return 0;
}

detachusemodels() {
  if(isDefined(self.attachedusemodel)) {
    self detach(self.attachedusemodel, "tag_inhand");
    self.attachedusemodel = undefined;
  }
}

func_11382(var_0) {
  scripts\mp\supers::allowsuperweaponstow();
  var_1 = scripts\mp\utility::func_11383(var_0, 1);
  if(!scripts\engine\utility::istrue(var_1)) {
    scripts\mp\supers::unstowsuperweapon();
    if(scripts\mp\utility::isreliablyswitchingtoweapon(var_0)) {
      scripts\mp\utility::func_1529(var_0);
      return;
    }

    scripts\mp\utility::_takeweapon(var_0);
  }
}

func_130E9(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility::isreallyalive(var_0)) {
    return 0;
  }

  if(!var_0 istouching(self.trigger)) {
    return 0;
  }

  if(!var_0 usebuttonpressed()) {
    return 0;
  }

  if(var_0 scripts\mp\utility::_meth_85C7()) {
    return 0;
  }

  if(var_0 meleebuttonpressed()) {
    return 0;
  }

  if(self.curprogress >= self.usetime) {
    return 0;
  }

  if(!self.userate && !var_1) {
    return 0;
  }

  if(var_1 && var_2 > var_3) {
    return 0;
  }

  if(isDefined(self.useweapon)) {
    if(var_0 getcurrentweapon() != self.useweapon && !var_0 scripts\mp\utility::isreliablyswitchingtoweapon(self.useweapon)) {
      return 0;
    }
  }

  return 1;
}

useholdthinkloop(var_0, var_1) {
  level endon("game_ended");
  self endon("disabled");
  var_2 = self.useweapon;
  var_3 = 1;
  if(isDefined(self.var_136F6)) {
    var_3 = self.var_136F6;
  }

  if(!var_3) {
    self.userate = 1 * var_0.objectivescaler;
  }

  var_4 = 0;
  var_5 = 1.5;
  while(func_130E9(var_0, var_3, var_4, var_5)) {
    var_4 = var_4 + 0.05;
    if(!var_3 || !isDefined(var_2) || var_0 getcurrentweapon() == var_2) {
      self.curprogress = self.curprogress + 50 * self.userate;
      self.userate = 1 * var_0.objectivescaler;
      var_3 = 0;
    } else {
      self.userate = 0;
    }

    var_0 updateuiprogress(self, 1);
    if(self.curprogress >= self.usetime) {
      self.inuse = 0;
      var_0 clientreleasetrigger(self.trigger);
      var_0.var_3FFA = undefined;
      if(!isDefined(var_2)) {
        var_0 scripts\engine\utility::allow_weapon(1);
      }

      var_0 unlink();
      return scripts\mp\utility::isreallyalive(var_0);
    }

    wait(0.05);
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }

  var_0 updateuiprogress(self, 0);
  return 0;
}

updatetrigger() {
  if(self.triggertype != "use") {
    return;
  }

  if(self.interactteam == "none") {
    self.trigger.origin = self.trigger.origin - (0, 0, 50000);
    return;
  }

  if(self.interactteam == "any") {
    self.trigger.origin = self.curorigin;
    self.trigger setteamfortrigger("none");
    return;
  }

  if(self.interactteam == "friendly") {
    self.trigger.origin = self.curorigin;
    if(self.ownerteam == "allies") {
      self.trigger setteamfortrigger("allies");
      return;
    }

    if(self.ownerteam == "axis") {
      self.trigger setteamfortrigger("axis");
      return;
    }

    self.trigger.origin = self.trigger.origin - (0, 0, 50000);
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

updateworldicons() {
  if(self.visibleteam == "any") {
    updateworldicon("friendly", 1);
    updateworldicon("enemy", 1);
    return;
  }

  if(self.visibleteam == "friendly") {
    updateworldicon("friendly", 1);
    updateworldicon("enemy", 0);
    return;
  }

  if(self.visibleteam == "enemy") {
    updateworldicon("friendly", 0);
    updateworldicon("enemy", 1);
    return;
  }

  updateworldicon("friendly", 0);
  updateworldicon("enemy", 0);
}

getmlgteamcolor(var_0) {
  if(var_0 == "allies") {
    return game["colors"]["friendly"];
  } else if(var_0 == "axis") {
    return game["colors"]["enemy"];
  }

  return (1, 1, 1);
}

setobjpointteamcolor(var_0, var_1, var_2) {
  if(var_1 == "mlg_allies") {
    var_0 setmlgdraw(1, 0);
    var_3 = self.worldiconscolor[var_2];
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
    var_3 = self.worldiconscolor[var_2];
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

  var_0.color = game["colors"][self.worldiconscolor[var_2]];
  var_0 setmlgdraw(0, 1);
}

updateworldicon(var_0, var_1) {
  if(!isDefined(self.var_13DCA[var_0])) {
    var_1 = 0;
  }

  var_2 = getupdateteams(var_0);
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    var_3 = var_2.size;
    for(var_4 = 0; var_4 < var_3; var_4++) {
      if(var_2[var_4] == "allies") {
        var_2[var_2.size] = "mlg_allies";
        continue;
      }

      if(var_2[var_4] == "axis") {
        var_2[var_2.size] = "mlg_axis";
      }
    }
  }

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = "objpoint_" + var_2[var_4] + "_" + self.entnum;
    var_6 = scripts\mp\objpoints::getobjpointbyname(var_5);
    if(!isDefined(var_6)) {
      continue;
    }

    var_6 notify("stop_flashing_thread");
    var_6 thread scripts\mp\objpoints::stopflashing();
    if(var_1) {
      var_6 setshader(self.var_13DCA[var_0], level.objpointsize, level.objpointsize);
      var_6 fadeovertime(0.05);
      var_6.alpha = var_6.basealpha;
      var_6.var_9F51 = 1;
      if(level.gametype == "dom") {
        var_6 setwaypoint(0, 1);
      } else if(isDefined(self.var_4465[var_0])) {
        var_6 setwaypoint(1, 1);
      } else {
        var_6 setwaypoint(1, 0);
      }

      setobjpointteamcolor(var_6, var_2[var_4], var_0);
      var_6 setwaypointbackground(getwaypointbackgroundtype(self.var_13DCA[var_0]));
      if(self.type == "carryObject") {
        var_7 = var_2[var_4] == "mlg_allies" || var_2[var_4] == "mlg_axis";
        if(isDefined(self.carrier) && !shouldpingobject(var_0) || var_7) {
          var_6 settargetent(self.carrier);
        } else if(!isDefined(self.carrier) && isDefined(self.objectiveonvisuals) && self.objectiveonvisuals) {
          var_6 settargetent(self.visuals[0]);
        } else {
          var_6 cleartargetent();
        }
      } else if(isDefined(self.var_C2B4)) {
        var_6 settargetent(self.var_C2B4);
      }
    } else {
      var_6 fadeovertime(0.05);
      var_6.alpha = 0;
      var_6.var_9F51 = 0;
      var_6 cleartargetent();
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

func_12F43(var_0, var_1) {}

updatecompassicons() {
  if(self.visibleteam == "any") {
    updatecompassicon("friendly", 1);
    updatecompassicon("enemy", 1);
    return;
  }

  if(self.visibleteam == "friendly") {
    updatecompassicon("friendly", 1);
    updatecompassicon("enemy", 0);
    return;
  }

  if(self.visibleteam == "enemy") {
    updatecompassicon("friendly", 0);
    updatecompassicon("enemy", 1);
    return;
  }

  updatecompassicon("friendly", 0);
  updatecompassicon("enemy", 0);
}

updateobjectiveiconcolortype(var_0, var_1) {
  var_2 = self.worldiconscolor[var_1];
  if(!isDefined(var_2)) {
    scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(var_0, 0);
    return;
  }

  if(var_2 == "friendly") {
    scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(var_0, 1);
    return;
  }

  if(var_2 == "enemy") {
    scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(var_0, 2);
    return;
  }

  if(var_2 == "contest") {
    scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(var_0, 3);
    return;
  }

  scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(var_0, 0);
}

updatecompassicon(var_0, var_1) {
  var_2 = getupdateteams(var_0);
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    var_5 = var_1;
    if(!var_5 && shouldshowcompassduetoradar(var_4)) {
      var_5 = 1;
    }

    var_6 = self.teamobjids[var_4];
    if(var_6 != -1) {
      if(!isDefined(self.var_4465[var_0]) || !var_5) {
        scripts\mp\objidpoolmanager::minimap_objective_state(var_6, "invisible");
        continue;
      }

      scripts\mp\objidpoolmanager::minimap_objective_icon(var_6, self.var_4465[var_0]);
      scripts\mp\objidpoolmanager::minimap_objective_state(var_6, "active");
      scripts\mp\objidpoolmanager::minimap_objective_icon_backgroundtype(var_6, getwaypointbackgroundtype(self.var_4465[var_0]));
      updateobjectiveiconcolortype(var_6, var_0);
      if(self.type == "carryObject") {
        if(scripts\mp\utility::isreallyalive(self.carrier) && !shouldpingobject(var_0)) {
          scripts\mp\objidpoolmanager::minimap_objective_onentity(var_6, self.carrier);
        } else if(isDefined(self.visuals) && isDefined(self.visuals[0]) && isDefined(self.visuals[0] getlinkedparent())) {
          scripts\mp\objidpoolmanager::minimap_objective_onentity(var_6, self.visuals[0]);
        } else if(isDefined(self.objectiveonvisuals) && self.objectiveonvisuals && !shouldpingobject(var_0)) {
          scripts\mp\objidpoolmanager::minimap_objective_onentity(var_6, self.visuals[0]);
        } else {
          scripts\mp\objidpoolmanager::minimap_objective_position(var_6, self.curorigin);
        }

        continue;
      }

      if(isDefined(self.var_C2B4)) {
        scripts\mp\objidpoolmanager::minimap_objective_onentity(var_6, self.var_C2B4);
      }
    }
  }
}

shouldpingobject(var_0) {
  if(var_0 == "friendly" && self.objidpingenemy) {
    return 1;
  } else if(var_0 == "enemy" && self.objidpingfriendly) {
    return 1;
  }

  return 0;
}

getupdateteams(var_0) {
  var_1 = [];
  foreach(var_3 in level.teamnamelist) {
    if(var_0 == "friendly") {
      if(isfriendlyteam(var_3)) {
        var_1[var_1.size] = var_3;
      }

      continue;
    }

    if(var_0 == "enemy") {
      if(!isfriendlyteam(var_3)) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

shouldshowcompassduetoradar(var_0) {
  if(!isDefined(self.carrier)) {
    return 0;
  }

  if(self.carrier scripts\mp\utility::_hasperk("specialty_gpsjammer")) {
    return 0;
  }

  return getteamradar(var_0);
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
  if(var_0 != "neutral") {
    self.prevownerteam = var_0;
  }
}

getownerteam() {
  return self.ownerteam;
}

setusetime(var_0) {
  self.usetime = int(var_0 * 1000);
}

setwaitweaponchangeonuse(var_0) {
  self.var_136F6 = var_0;
}

setusetext(var_0) {
  self.var_130EB = var_0;
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
    for(var_1 = 0; var_1 < self.visuals.size; var_1++) {
      self.visuals[var_1] show();
      if(self.visuals[var_1].classname == "script_brushmodel" || self.visuals[var_1].classname == "script_model") {
        foreach(var_3 in level.players) {
          if(var_3 istouching(self.visuals[var_1])) {
            var_3 scripts\mp\utility::_suicide();
          }
        }

        self.visuals[var_1] thread makesolid();
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

    wait(0.05);
  }
}

func_F680(var_0) {
  self.carriervisible = var_0;
}

func_F67D(var_0) {
  self.var_130E5 = var_0;
}

set2dicon(var_0, var_1) {
  self.var_4465[var_0] = var_1;
  if(!isDefined(var_1)) {
    self.worldiconscolor[var_0] = "neutral";
  } else {
    self.worldiconscolor[var_0] = getwaypointbackgroundcolor(var_1);
  }

  updatecompassicons();
}

getwaypointbackgroundtype(var_0) {
  if(!isDefined(level.waypointbgtype)) {
    scripts\mp\gamelogic::initwaypointbackgrounds();
  }

  var_1 = level.waypointbgtype[var_0];
  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1;
}

getwaypointbackgroundcolor(var_0) {
  if(!isDefined(level.waypointcolors)) {
    scripts\mp\gamelogic::initwaypointbackgrounds();
  }

  var_1 = level.waypointcolors[var_0];
  if(!isDefined(var_1)) {
    return "neutral";
  }

  return var_1;
}

set3dicon(var_0, var_1) {
  self.var_13DCA[var_0] = var_1;
  if(!isDefined(var_1)) {
    self.worldiconscolor[var_0] = "neutral";
  } else {
    self.worldiconscolor[var_0] = getwaypointbackgroundcolor(var_1);
  }

  updateworldicons();
}

set3duseicon(var_0, var_1) {
  self.var_13DCD[var_0] = var_1;
}

setcarryicon(var_0) {
  self.carryicon = var_0;
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

  self.trigger scripts\engine\utility::trigger_off();
  setvisibleteam("none");
}

enableobject() {
  if(self.type == "carryObject") {
    for(var_0 = 0; var_0 < self.visuals.size; var_0++) {
      self.visuals[var_0] show();
    }
  }

  self.trigger scripts\engine\utility::trigger_on();
  setvisibleteam("any");
}

getrelativeteam(var_0) {
  if(var_0 == self.ownerteam) {
    return "friendly";
  }

  return "enemy";
}

isfriendlyteam(var_0) {
  if(self.ownerteam == "any") {
    return 1;
  }

  if(self.ownerteam == var_0) {
    return 1;
  }

  if(self.ownerteam == "neutral" && isDefined(self.prevownerteam) && self.prevownerteam == var_0) {
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

      break;

    case "enemy":
      if(var_0 != self.ownerteam) {
        return 1;
      } else {
        return 0;
      }

      break;

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

  if(!level.teambased) {}

  if(var_0 == "neutral") {
    return "none";
  }

  if(var_0 == "allies") {
    return "axis";
  }

  return "allies";
}

getlabel() {
  var_0 = self.trigger.script_label;
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

setzonestatusicons(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  set2dicon("friendly", var_0);
  set3dicon("friendly", var_0);
  set2dicon("enemy", var_1);
  set3dicon("enemy", var_1);
}

getleveltriggers() {
  level.minetriggers = getEntArray("minefield", "targetname");
  level.hurttriggers = getEntArray("trigger_hurt", "classname");
  level.radtriggers = getEntArray("radiation", "targetname");
  level.ballallowedtriggers = getEntArray("uplinkAllowedOOB", "targetname");
  level.nozonetriggers = getEntArray("uplink_nozone", "targetname");
  level.droptonavmeshtriggers = getEntArray("dropToNavMesh", "targetname");
  thread scripts\mp\utility::initarbitraryuptriggers();
}

isbombmode() {
  if(level.gametype == "sd" || level.gametype == "sr" || level.gametype == "dd") {
    return 1;
  }

  return 0;
}

touchingdroptonavmeshtrigger(var_0) {
  if(level.droptonavmeshtriggers.size > 0) {
    if(isbombmode() || level.gametype == "ctf") {
      self.visuals[0].origin = var_0;
    }

    foreach(var_2 in level.droptonavmeshtriggers) {
      foreach(var_4 in self.visuals) {
        if(var_4 istouching(var_2)) {
          return 1;
        }
      }
    }
  }

  return 0;
}

touchingarbitraryuptrigger() {
  if(level.arbitraryuptriggers.size > 0) {
    foreach(var_1 in level.arbitraryuptriggers) {
      if(self istouching(var_1)) {
        return 1;
      }
    }
  }

  return 0;
}