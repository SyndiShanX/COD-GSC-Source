/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gameobjects.gsc
**************************************/

main(param_00) {
  param_00[param_00.size] = "airdrop_pallet";
  var_01 = getEntArray();
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(isDefined(var_01[var_02].script_gameobjectname)) {
      var_03 = 1;
      var_04 = strtok(var_01[var_02].script_gameobjectname, " ");
      for(var_05 = 0; var_05 < param_00.size; var_05++) {
        for(var_06 = 0; var_06 < var_04.size; var_06++) {
          if(var_04[var_06] == param_00[var_05]) {
            var_03 = 0;
            break;
          }
        }

        if(!var_03) {
          break;
        }
      }

      if(var_03) {
        var_01[var_02] delete();
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
    level waittill("connected", var_00);
    if(isbot(var_00)) {
      level.botsenabled = 1;
    }

    var_00 thread onplayerspawned();
    var_00 thread ondisconnect();
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

func_4A29(param_00, param_01) {
  var_02 = spawn("script_model", self.origin);
  var_02 setModel("tag_origin");
  var_03 = spawnStruct();
  var_03.type = "carryObject";
  var_03.carrier = param_00;
  var_03.curorigin = param_00.origin;
  var_03.entnum = var_02 getentitynumber();
  var_03.ownerteam = param_00.team;
  var_03.var_4465 = [];
  var_03.objidpingenemy = 0;
  var_03.objidpingfriendly = 0;
  var_03.var_13DCA = [];
  var_03.carriervisible = 0;
  var_03.visibleteam = "none";
  foreach(var_05 in level.teamnamelist) {
    var_03.teamobjids[var_05] = ::scripts\mp\objidpoolmanager::requestminimapid(99);
    if(var_03.teamobjids[var_05] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_03.teamobjids[var_05], "invisible", var_03.curorigin);
      scripts\mp\objidpoolmanager::minimap_objective_team(var_03.teamobjids[var_05], var_05);
    }

    var_03.objpoints[var_05] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_05 + "_" + var_03.entnum, var_03.curorigin + param_01, var_05, undefined);
    var_03.objpoints[var_05].alpha = 0;
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_06 = "mlg_" + var_05;
      var_03.objpoints[var_06] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_06 + "_" + var_03.entnum, var_03.curorigin + param_01, var_05, undefined);
      var_03.objpoints[var_06].alpha = 0;
    }
  }

  var_03 thread func_12E6F();
  var_03 thread func_51D8();
  return var_03;
}

func_51D8() {
  self.carrier waittill("disconnect");
  if(self.type != "carryObject") {
    return;
  }

  var_00 = self;
  var_00.type = undefined;
  var_00.carrier = undefined;
  var_00.curorigin = undefined;
  var_00.entnum = undefined;
  var_00.ownerteam = undefined;
  var_00.var_4465 = undefined;
  var_00.objidpingenemy = undefined;
  var_00.objidpingfriendly = undefined;
  var_00.var_13DCA = undefined;
  var_00.carriervisible = undefined;
  var_00.visibleteam = undefined;
  foreach(var_02 in level.teamnamelist) {
    scripts\mp\objidpoolmanager::returnminimapid(var_00.teamobjids[var_02]);
    scripts\mp\objpoints::deleteobjpoint(var_00.objpoints[var_02]);
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_03 = "mlg_" + var_02;
      scripts\mp\objpoints::deleteobjpoint(var_00.objpoints[var_03]);
    }
  }
}

createcarryobject(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.type = "carryObject";
  var_04.curorigin = param_01.origin;
  var_04.ownerteam = param_00;
  var_04.entnum = param_01 getentitynumber();
  if(issubstr(param_01.classname, "use")) {
    var_04.triggertype = "use";
  } else {
    var_04.triggertype = "proximity";
  }

  param_01.baseorigin = param_01.origin;
  var_04.trigger = param_01;
  if(!isDefined(param_01.linktoenabledflag)) {
    param_01.linktoenabledflag = 1;
    param_01 enablelinkto();
  }

  var_04.useweapon = undefined;
  if(!isDefined(param_03)) {
    param_03 = (0, 0, 0);
  }

  var_04.offset3d = param_03;
  for(var_05 = 0; var_05 < param_02.size; var_05++) {
    param_02[var_05].baseorigin = param_02[var_05].origin;
    param_02[var_05].baseangle = param_02[var_05].angles;
  }

  var_04.visuals = param_02;
  var_04.var_4465 = [];
  var_04.objidpingenemy = 0;
  var_04.objidpingfriendly = 0;
  foreach(var_07 in level.teamnamelist) {
    var_04.teamobjids[var_07] = ::scripts\mp\objidpoolmanager::requestminimapid(99);
    if(var_04.teamobjids[var_07] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_04.teamobjids[var_07], "invisible", var_04.curorigin);
      scripts\mp\objidpoolmanager::minimap_objective_team(var_04.teamobjids[var_07], var_07);
    }

    var_04.objpoints[var_07] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_07 + "_" + var_04.entnum, var_04.curorigin + param_03, var_07, undefined);
    var_04.objpoints[var_07].alpha = 0;
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_08 = "mlg_" + var_07;
      var_04.objpoints[var_08] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_08 + "_" + var_04.entnum, var_04.curorigin + param_03, var_07, undefined);
      var_04.objpoints[var_08].alpha = 0;
    }
  }

  var_04.carrier = undefined;
  var_04.isresetting = 0;
  var_04.interactteam = "none";
  var_04.allowweapons = 0;
  var_04.var_13DCA = [];
  var_04.carriervisible = 0;
  var_04.visibleteam = "none";
  var_04.carryicon = undefined;
  var_04.ondrop = undefined;
  var_04.onpickup = undefined;
  var_04.onreset = undefined;
  if(var_04.triggertype == "use") {
    var_04 thread carryobjectusethink();
  } else {
    var_04.curprogress = 0;
    var_04.var_115DF = [];
    var_04.var_115DF["none"] = 0;
    var_04.var_115DF["allies"] = 0;
    var_04.var_115DF["axis"] = 0;
    var_04.usetime = 0;
    var_04.userate = 0;
    var_04.mustmaintainclaim = 0;
    var_04.cancontestclaim = 0;
    var_04.teamusetimes = [];
    var_04.teamusetexts = [];
    var_04.numtouching["neutral"] = 0;
    var_04.touchlist["neutral"] = [];
    var_04.numtouching["none"] = 0;
    var_04.touchlist["none"] = [];
    foreach(var_0B in level.teamnamelist) {
      var_04.numtouching[var_0B] = 0;
      var_04.touchlist[var_0B] = [];
    }

    var_04.claimteam = "none";
    var_04.claimplayer = undefined;
    var_04.lastclaimteam = "none";
    var_04.lastclaimtime = 0;
    var_04 thread carryobjectasset();
  }

  var_04 thread func_12E6F();
  return var_04;
}

func_51A9() {
  if(self.type != "carryObject") {
    return;
  }

  var_00 = self;
  var_00.type = undefined;
  var_00.curorigin = undefined;
  var_00.ownerteam = undefined;
  var_00.entnum = undefined;
  var_00.triggertype = undefined;
  var_00.trigger unlink();
  var_00.trigger = undefined;
  var_00.useweapon = undefined;
  var_00.offset3d = undefined;
  foreach(var_02 in var_00.visuals) {
    var_02 delete();
  }

  var_00.visuals = undefined;
  var_00.var_4465 = undefined;
  var_00.objidpingenemy = undefined;
  var_00.objidpingfriendly = undefined;
  var_00.objpingdelay = undefined;
  scripts\mp\objpoints::deleteobjpoint(var_00.objpoints["allies"]);
  scripts\mp\objpoints::deleteobjpoint(var_00.objpoints["axis"]);
  foreach(var_05 in level.teamnamelist) {
    scripts\mp\objidpoolmanager::returnminimapid(var_00.teamobjids[var_05]);
    scripts\mp\objpoints::deleteobjpoint(var_00.objpoints[var_05]);
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_06 = "mlg_" + var_05;
      scripts\mp\objpoints::deleteobjpoint(var_00.objpoints[var_06]);
    }
  }

  var_00.objpoints = undefined;
  var_00.carrier = undefined;
  var_00.isresetting = undefined;
  var_00.interactteam = undefined;
  var_00.allowweapons = undefined;
  var_00.var_A57D = undefined;
  var_00.var_13DCA = undefined;
  var_00.carriervisible = undefined;
  var_00.visibleteam = undefined;
  var_00.carryicon = undefined;
  var_00.ondrop = undefined;
  var_00.onpickup = undefined;
  var_00.onreset = undefined;
  var_00.curprogress = undefined;
  var_00.usetime = undefined;
  var_00.userate = undefined;
  var_00.mustmaintainclaim = undefined;
  var_00.cancontestclaim = undefined;
  var_00.teamusetimes = undefined;
  var_00.teamusetexts = undefined;
  var_00.numtouching = undefined;
  var_00.touchlist = undefined;
  var_00.claimteam = undefined;
  var_00.claimplayer = undefined;
  var_00.lastclaimteam = undefined;
  var_00.lastclaimtime = undefined;
  var_00 notify("death");
  var_00 notify("deleted");
}

carryobjectusethink() {
  level endon("game_ended");
  for(;;) {
    self.trigger waittill("trigger", var_00);
    if(scripts\mp\utility::func_9F22(var_00)) {
      continue;
    }

    if(!isplayer(var_00)) {
      continue;
    }

    if(var_00 _meth_84CA()) {
      continue;
    }

    if(var_00 getcurrentweapon() == "ks_remote_map_mp") {
      continue;
    }

    if(var_00 getcurrentweapon() == "ks_remote_device_mp") {
      continue;
    }

    if(var_00 scripts\mp\utility::isanymonitoredweaponswitchinprogress()) {
      var_01 = var_00 scripts\mp\utility::getcurrentmonitoredweaponswitchweapon();
      if(var_01 == "ks_remote_map_mp" || var_01 == "ks_remote_device_mp") {
        continue;
      }
    }

    if(scripts\mp\utility::istrue(var_00.using_remote_turret)) {
      continue;
    }

    if(!func_DAD1(var_00)) {
      continue;
    }

    if(self.isresetting) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_00)) {
      continue;
    }

    if(!caninteractwith(var_00.pers["team"])) {
      continue;
    }

    if(!var_00.var_38ED) {
      continue;
    }

    if(isDefined(var_00.nopickuptime) && var_00.nopickuptime > gettime()) {
      continue;
    }

    if(!isDefined(var_00.var_987A)) {
      continue;
    }

    if(var_00 scripts\mp\utility::_meth_85C7()) {
      var_02 = var_00 _meth_854D();
      if(!scripts\mp\utility::isgesture(var_02)) {
        continue;
      }
    }

    if(isDefined(self.carrier)) {
      continue;
    }

    if(var_00 scripts\mp\utility::isusingremote()) {
      continue;
    }

    setpickedup(var_00);
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
      var_00 = getearliestclaimplayer();
      if(isDefined(self.onenduse)) {
        self[[self.onenduse]](func_7E29(), var_00, isDefined(var_00));
      }

      if(isDefined(var_00)) {
        setpickedup(var_00);
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

func_CB44(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self.var_38ED = 0;
  if(isDefined(param_00.ballindex)) {
    var_01 = 1024;
  } else {
    var_01 = 4096;
  }

  for(;;) {
    if(distancesquared(self.origin, param_00.trigger.origin) > var_01) {
      break;
    }

    wait(0.2);
  }

  if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
    self.var_38ED = 1;
  }
}

setpickedup(param_00) {
  if(isai(param_00) && isDefined(param_00.triggerportableradarping)) {
    return;
  }

  if(isDefined(param_00.carryobject) || isDefined(self.carryweapon) && !param_00 scripts\engine\utility::isweaponallowed()) {
    if(isDefined(self.onpickupfailed)) {
      self[[self.onpickupfailed]](param_00);
    }

    return;
  }

  param_00 giveobject(self);
  setcarrier(param_00);
  if(isDefined(self.trigger getlinkedparent())) {
    for(var_01 = 0; var_01 < self.visuals.size; var_01++) {
      self.visuals[var_01] unlink();
    }

    self.trigger unlink();
  }

  for(var_01 = 0; var_01 < self.visuals.size; var_01++) {
    self.visuals[var_01] hide();
  }

  self.trigger.origin = self.trigger.origin + (0, 0, 10000);
  self.trigger scripts\mp\movers::stop_handling_moving_platforms();
  self notify("pickup_object");
  if(isDefined(self.onpickup)) {
    self[[self.onpickup]](param_00);
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

      foreach(var_01 in level.teamnamelist) {
        self.objpoints[var_01] scripts\mp\objpoints::updateorigin(self.curorigin);
      }

      foreach(var_01 in level.teamnamelist) {
        if((self.visibleteam == "friendly" || self.visibleteam == "any") && isfriendlyteam(var_01) && self.objidpingenemy) {
          if(self.objpoints[var_01].var_9F51) {
            self.objpoints[var_01].alpha = self.objpoints[var_01].basealpha;
            self.objpoints[var_01] fadeovertime(self.objpingdelay);
            self.objpoints[var_01].alpha = 0;
          }

          if(self.teamobjids[var_01] != -1) {
            scripts\mp\objidpoolmanager::minimap_objective_position(self.teamobjids[var_01], self.curorigin);
          }
        }
      }

      foreach(var_01 in level.teamnamelist) {
        if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam(var_01) && self.objidpingfriendly) {
          if(self.objpoints[var_01].var_9F51) {
            self.objpoints[var_01].alpha = self.objpoints[var_01].basealpha;
            self.objpoints[var_01] fadeovertime(self.objpingdelay);
            self.objpoints[var_01].alpha = 0;
          }

          if(self.teamobjids[var_01] != -1) {
            scripts\mp\objidpoolmanager::minimap_objective_position(self.teamobjids[var_01], self.curorigin);
          }
        }
      }

      scripts\mp\utility::wait_endon(self.objpingdelay, "dropped", "reset");
      continue;
    }

    foreach(var_01 in level.teamnamelist) {
      self.objpoints[var_01] scripts\mp\objpoints::updateorigin(self.curorigin + self.offset3d);
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
  var_00 = self getcurrentweapon();
  var_01 = self getcurrentprimaryweapon();
  if("alt_" + var_01 == var_00) {
    return var_00;
  }

  return var_01;
}

watchcarryobjectweaponswitch(param_00) {
  self endon("goal_scored");
  var_01 = gettime();
  var_02 = scripts\mp\utility::func_11383(param_00, 1);
  if(isDefined(var_02)) {
    if(var_02 == 0) {
      if(var_01 == gettime()) {
        waittillframeend;
      }

      if(isDefined(self.carryobject)) {
        self.carryobject thread setdropped();
        return;
      }
    }
  }
}

giveobject(param_00) {
  self.carryobject = param_00;
  thread trackcarrier();
  if(isDefined(param_00.carryweapon)) {
    param_00.carrierweaponcurrent = gameobjects_getcurrentprimaryweapon();
    param_00.carrierhascarryweaponinloadout = self hasweapon(param_00.carryweapon);
    if(isDefined(param_00.carryweaponthink)) {
      self thread[[param_00.carryweaponthink]]();
    }

    self giveweapon(param_00.carryweapon);
    thread watchcarryobjectweaponswitch(param_00.carryweapon);
    self disableweaponpickup();
    scripts\engine\utility::allow_weapon_switch(0);
  } else if(!param_00.allowweapons) {
    scripts\engine\utility::allow_weapon(0);
    thread manualdropthink();
  }

  if(isDefined(param_00.carryicon)) {
    if(level.splitscreen) {
      self.carryicon = scripts\mp\hud_util::createicon(param_00.carryicon, 33, 33);
      self.carryicon scripts\mp\hud_util::setpoint("BOTTOM LEFT", "BOTTOM LEFT", -50, -78);
    } else {
      self.carryicon = scripts\mp\hud_util::createicon(param_00.carryicon, 50, 50);
      self.carryicon scripts\mp\hud_util::setpoint("BOTTOM LEFT", "BOTTOM LEFT", 175, -30);
    }

    self.carryicon.hidewheninmenu = 1;
    thread hidecarryiconongameend();
  }
}

returnobjectiveid() {
  self.isresetting = 1;
  self notify("reset");
  for(var_00 = 0; var_00 < self.visuals.size; var_00++) {
    var_01 = self.visuals[var_00] getlinkedparent();
    if(isDefined(var_01)) {
      self.visuals[var_00] unlink();
    }

    if(isbombmode() && self.visuals[var_00].var_336 == "sd_bomb") {
      self.visuals[var_00].origin = level.bombrespawnpoint;
      self.visuals[var_00].angles = level.bombrespawnangles;
    } else {
      self.visuals[var_00].origin = self.visuals[var_00].baseorigin;
      self.visuals[var_00].angles = self.visuals[var_00].baseangle;
    }

    self.visuals[var_00] show();
  }

  var_01 = self.trigger getlinkedparent();
  if(isDefined(var_01)) {
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

setposition(param_00, param_01) {
  self.isresetting = 1;
  for(var_02 = 0; var_02 < self.visuals.size; var_02++) {
    self.visuals[var_02].origin = param_00;
    self.visuals[var_02].angles = param_01;
    self.visuals[var_02] show();
  }

  self.trigger.origin = param_00;
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

carryobject_overridemovingplatformdeath(param_00) {
  for(var_01 = 0; var_01 < param_00.carryobject.visuals.size; var_01++) {
    param_00.carryobject.visuals[var_01] unlink();
  }

  param_00.carryobject.trigger unlink();
  param_00.carryobject thread setdropped(1);
}

setdropped(param_00) {
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
  foreach(var_02 in self.visuals) {
    var_02.var_D887 = var_02 setcontents(0);
  }

  if(isDefined(self.carrier)) {
    var_04 = self.carrier.origin;
  } else {
    var_04 = self.curorigin;
  }

  if(scripts\mp\utility::istrue(level.botsenabled) || isDefined(self.ftldrop) || touchingdroptonavmeshtrigger(var_04) || level.mapname == "mp_junk" && level.gametype == "ctf" && !self.carrier touchingarbitraryuptrigger()) {
    var_04 = getclosestpointonnavmesh(var_04);
    if(isDefined(self.ftldrop)) {
      self.ftldrop = undefined;
    }
  }

  var_05 = 20;
  var_06 = 4000;
  var_07 = (0, 0, 0);
  if(self.carrier touchingarbitraryuptrigger()) {
    var_08 = self.carrier getworldupreferenceangles();
    var_07 = anglestoup(var_08);
    if(var_07[2] < 0) {
      var_05 = -20;
      var_06 = -4000;
    }
  }

  var_09 = var_04 + (0, 0, var_05);
  var_0A = var_04 - (0, 0, var_06);
  var_0B = scripts\common\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
  var_0C = [];
  var_0C[0] = self.visuals[0];
  var_0C[1] = self.carrier;
  if(isDefined(self.carrier) && self.carrier.team != "spectator") {
    if(level.gametype != "ctf") {
      var_0D = scripts\common\trace::capsule_trace(var_09, var_0A, 8, 16, (0, 0, 0), var_0C, var_0B, 0);
    } else {
      var_0D = scripts\common\trace::capsule_trace(var_0A, var_0B, 2, 4, (0, 0, 0), var_0D, var_0C, 0);
    }
  } else {
    var_0D = scripts\common\trace::ray_trace(self.safeorigin + (0, 0, 20), self.safeorigin - (0, 0, 20), var_0D, var_0C, 0);
    if(isplayer(var_0D["entity"])) {
      var_0D["entity"] = undefined;
    }
  }

  foreach(var_02 in self.visuals) {
    var_02 setcontents(var_02.var_D887);
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
      if(self.carrier touchingarbitraryuptrigger() && var_07[2] < 0) {
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

    if(!isDefined(param_00)) {
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

  if(isDefined(self.ondrop) && !isDefined(param_00)) {
    self[[self.ondrop]](var_10);
  }

  clearcarrier();
  updatecompassicons();
  updateworldicons();
  self.isresetting = 0;
}

setcarrier(param_00) {
  self.carrier = param_00;
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

  for(var_00 = 0; var_00 < level.radtriggers.size; var_00++) {
    if(!self.visuals[0] istouching(level.radtriggers[var_00])) {
      continue;
    }

    returnobjectiveid();
    return;
  }

  for(var_00 = 0; var_00 < level.minetriggers.size; var_00++) {
    if(!self.visuals[0] istouching(level.minetriggers[var_00])) {
      continue;
    }

    returnobjectiveid();
    return;
  }

  for(var_00 = 0; var_00 < level.hurttriggers.size; var_00++) {
    if(!self.visuals[0] istouching(level.hurttriggers[var_00])) {
      continue;
    }

    returnobjectiveid();
    return;
  }

  if(scripts\mp\utility::istrue(level.ballallowedtriggers.size)) {
    self.allowedintrigger = 0;
    foreach(var_02 in level.ballallowedtriggers) {
      if(self.visuals[0] istouching(var_02)) {
        self.allowedintrigger = 1;
        break;
      }
    }
  }

  foreach(var_02 in level.var_C7B3) {
    if(scripts\mp\utility::istrue(self.allowedintrigger)) {
      break;
    }

    if(!self.visuals[0] istouching(var_02)) {
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

takeobject(param_00) {
  if(isDefined(self.carryicon)) {
    self.carryicon scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self)) {
    self.carryobject = undefined;
  }

  self notify("drop_object");
  if(param_00.triggertype == "proximity") {
    thread func_CB44(param_00);
  }

  if(scripts\mp\utility::isreallyalive(self) && !param_00.allowweapons) {
    if(isDefined(param_00.carryweapon)) {
      var_01 = isDefined(param_00.keepcarryweapon) && param_00.keepcarryweapon;
      if(!param_00.carrierhascarryweaponinloadout && !var_01) {
        if(isDefined(param_00.ballindex)) {
          wait(0.25);
        }

        self notify("clear_carrier");
        if(scripts\mp\utility::isreliablyswitchingtoweapon(param_00.carryweapon)) {
          scripts\mp\utility::func_1529(param_00.carryweapon);
        } else {
          scripts\mp\utility::_takeweapon(param_00.carryweapon);
        }

        var_02 = param_00.lastdroppableweaponobj;
        thread scripts\mp\utility::func_72ED(var_02);
      } else {}

      self enableweaponpickup();
      scripts\engine\utility::allow_weapon_switch(1);
      return;
    }

    if(!param_00.allowweapons) {
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
      var_00 = bulletTrace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);
      if(var_00["fraction"] < 1) {
        self.carryobject.safeorigin = var_00["position"];
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
  foreach(var_01 in level.teamnamelist) {
    scripts\mp\objidpoolmanager::returnminimapid(self.teamobjids[var_01]);
    scripts\mp\objpoints::deleteobjpoint(self.objpoints[var_01]);
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_02 = "mlg_" + var_01;
      scripts\mp\objpoints::deleteobjpoint(self.objpoints[var_02]);
    }
  }

  self.trigger delete();
  self.trigger = undefined;
  self notify("deleted");
}

createuseobject(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.type = "useObject";
  var_04.curorigin = param_01.origin;
  var_04.ownerteam = param_00;
  var_04.entnum = param_01 getentitynumber();
  var_04.keyobject = undefined;
  if(issubstr(param_01.classname, "use")) {
    var_04.triggertype = "use";
  } else {
    var_04.triggertype = "proximity";
  }

  var_04.trigger = param_01;
  for(var_05 = 0; var_05 < param_02.size; var_05++) {
    param_02[var_05].baseorigin = param_02[var_05].origin;
    param_02[var_05].baseangle = param_02[var_05].angles;
  }

  var_04.visuals = param_02;
  if(!isDefined(param_03)) {
    param_03 = (0, 0, 0);
  }

  var_04.offset3d = param_03;
  var_04.var_4465 = [];
  foreach(var_07 in level.teamnamelist) {
    var_04.teamobjids[var_07] = ::scripts\mp\objidpoolmanager::requestminimapid(99);
    if(var_04.teamobjids[var_07] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_04.teamobjids[var_07], "invisible", var_04.curorigin);
      scripts\mp\objidpoolmanager::minimap_objective_team(var_04.teamobjids[var_07], var_07);
    }

    var_04.objpoints[var_07] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_07 + "_" + var_04.entnum, var_04.curorigin + param_03, var_07, undefined);
    var_04.objpoints[var_07].alpha = 0;
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_08 = "mlg_" + var_07;
      var_04.objpoints[var_08] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_08 + "_" + var_04.entnum, var_04.curorigin + param_03, var_07, undefined);
      var_04.objpoints[var_08].alpha = 0;
    }
  }

  var_04.interactteam = "none";
  var_04.var_13DCA = [];
  var_04.visibleteam = "none";
  var_04.onuse = undefined;
  var_04.oncantuse = undefined;
  var_04.var_130EB = "default";
  var_04.usetime = 10000;
  var_04.curprogress = 0;
  var_04.stalemate = 0;
  var_04.wasstalemate = 0;
  var_04.var_115DF = [];
  var_04.var_115DF["none"] = 0;
  var_04.var_115DF["allies"] = 0;
  var_04.var_115DF["axis"] = 0;
  if(var_04.triggertype == "proximity") {
    var_04.teamusetimes = [];
    var_04.teamusetexts = [];
    var_04.numtouching["neutral"] = 0;
    var_04.touchlist["neutral"] = [];
    var_04.numtouching["none"] = 0;
    var_04.touchlist["none"] = [];
    foreach(var_0B in level.teamnamelist) {
      var_04.numtouching[var_0B] = 0;
      var_04.touchlist[var_0B] = [];
    }

    var_04.userate = 0;
    var_04.claimteam = "none";
    var_04.claimplayer = undefined;
    var_04.lastclaimteam = "none";
    var_04.lastclaimtime = 0;
    var_04.mustmaintainclaim = 0;
    var_04.cancontestclaim = 0;
    var_04 thread func_130B0();
  } else {
    var_04.userate = 1;
    var_04 thread useobjectusethink();
  }

  return var_04;
}

setkeyobject(param_00) {
  self.keyobject = param_00;
}

useobjectusethink() {
  level endon("game_ended");
  self endon("deleted");
  for(;;) {
    self.trigger waittill("trigger", var_00);
    if(!scripts\mp\utility::isreallyalive(var_00)) {
      continue;
    }

    if(!caninteractwith(var_00.pers["team"])) {
      continue;
    }

    if(!var_00 isonground()) {
      continue;
    }

    if(!var_00 scripts\mp\utility::isjuggernaut() && scripts\mp\utility::iskillstreakweapon(var_00 getcurrentweapon())) {
      continue;
    }

    if(isDefined(self.var_13056)) {
      if(!self[[self.var_13056]](var_00)) {
        continue;
      }
    }

    if(isDefined(self.keyobject) && !isDefined(var_00.carryobject) || var_00.carryobject != self.keyobject) {
      if(isDefined(self.oncantuse)) {
        self[[self.oncantuse]](var_00);
      }

      continue;
    }

    if(var_00 hasweapon(self.useweapon)) {
      continue;
    }

    if(!var_00 scripts\engine\utility::isweaponallowed()) {
      continue;
    }

    var_01 = 1;
    if(self.usetime > 0) {
      if(isDefined(self.onbeginuse)) {
        var_00 updateuiprogress(self, 0);
        self[[self.onbeginuse]](var_00);
      }

      if(!isDefined(self.keyobject)) {
        thread func_3930();
      }

      var_02 = var_00.pers["team"];
      var_01 = useholdthink(var_00);
      self notify("finished_use");
      if(isDefined(self.onenduse)) {
        self[[self.onenduse]](var_02, var_00, var_01);
      }
    }

    if(!var_01) {
      continue;
    }

    if(isDefined(self.onuse)) {
      self[[self.onuse]](var_00);
    }
  }
}

func_3E22(param_00) {
  if(!isDefined(self.keyobject)) {
    return 1;
  }

  if(!isDefined(param_00.carryobject)) {
    return 0;
  }

  var_01 = self.keyobject;
  if(!isarray(var_01)) {
    var_01 = [var_01];
  }

  foreach(var_03 in var_01) {
    if(var_03 == param_00.carryobject) {
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
    self.trigger waittill("trigger", var_00);
    if(!scripts\mp\utility::isreallyalive(var_00)) {
      continue;
    }

    if(!caninteractwith(var_00.pers["team"])) {
      continue;
    }

    if(isDefined(self.oncantuse)) {
      self[[self.oncantuse]](var_00);
    }
  }
}

getearliestclaimplayer() {
  var_00 = self.claimteam;
  if(scripts\mp\utility::isreallyalive(self.claimplayer)) {
    var_01 = self.claimplayer;
  } else {
    var_01 = undefined;
  }

  if(self.touchlist[var_00].size > 0) {
    var_02 = undefined;
    var_03 = getarraykeys(self.touchlist[var_00]);
    for(var_04 = 0; var_04 < var_03.size; var_04++) {
      var_05 = self.touchlist[var_00][var_03[var_04]];
      if(scripts\mp\utility::isreallyalive(var_05.player) && !isDefined(var_02) || var_05.starttime < var_02) {
        var_01 = var_05.player;
        var_02 = var_05.starttime;
      }
    }
  }

  return var_01;
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
        var_00 = "none";
        if(self.numtouching["allies"]) {
          var_00 = "allies";
        } else if(self.numtouching["axis"]) {
          var_00 = "axis";
        }

        if(var_00 == "none" && self.ownerteam != "neutral") {
          var_00 = self.ownerteam;
        }

        if(isDefined(self.onuncontested)) {
          self[[self.onuncontested]](var_00);
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
          var_01 = getearliestclaimplayer();
          if(isDefined(self.onuse)) {
            self[[self.onuse]](self.claimplayer);
          }

          setclaimteam("none");
          self.claimplayer = undefined;
        }
      } else if(self.usetime && self.var_115DF[self.claimteam] >= self.usetime) {
        self.curprogress = 0;
        self.var_115DF[self.claimteam] = self.curprogress;
        var_01 = getearliestclaimplayer();
        if(isDefined(self.onenduse)) {
          self[[self.onenduse]](self.claimteam, var_01, isDefined(var_01));
        }

        if(isDefined(var_01) && isDefined(self.onuse)) {
          self[[self.onuse]](var_01);
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

useobjectdecay(param_00) {
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

func_3895(param_00) {
  if(isDefined(self.carrier)) {
    return 0;
  }

  if(self.cancontestclaim) {
    var_01 = animscriptedthirdperson(param_00.pers["team"]);
    if(var_01 != 0) {
      return 0;
    }
  }

  if(func_3E22(param_00)) {
    return 1;
  }

  return 0;
}

func_DAD2() {
  level endon("game_ended");
  self endon("deleted");
  var_00 = self.entnum;
  for(;;) {
    self.trigger waittill("trigger", var_01);
    if(!scripts\mp\utility::isreallyalive(var_01)) {
      continue;
    }

    if(isagent(var_01)) {
      continue;
    }

    if(!scripts\mp\utility::isgameparticipant(var_01)) {
      continue;
    }

    if(isDefined(self.carrier)) {
      continue;
    }

    if(isDefined(var_01.spawningafterremotedeath)) {
      continue;
    }

    if(var_01 _meth_8568()) {
      continue;
    }

    if(isDefined(var_01.classname) && var_01.classname == "script_vehicle") {
      continue;
    }

    if(!isDefined(var_01.var_987A)) {
      continue;
    }

    var_02 = getrelativeteam(var_01.pers["team"]);
    if(isDefined(self.teamusetimes[var_02]) && self.teamusetimes[var_02] < 0) {
      continue;
    }

    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_01)) {
      continue;
    }

    if(self.claimteam == "none" && caninteractwith(var_01.pers["team"], var_01)) {
      if(func_3895(var_01)) {
        if(!func_DAD1(var_01)) {
          continue;
        }

        setclaimteam(var_01.pers["team"]);
        self.claimplayer = var_01;
        if(isDefined(self.teamusetimes[var_02])) {
          self.usetime = self.teamusetimes[var_02];
        }

        if(self.usetime && isDefined(self.onbeginuse)) {
          self[[self.onbeginuse]](self.claimplayer);
        }
      } else if(isDefined(self.oncantuse)) {
        self[[self.oncantuse]](var_01);
      }
    }

    if(scripts\mp\utility::isreallyalive(var_01) && !isDefined(var_01.touchtriggers[var_00])) {
      var_01 thread func_127CA(self);
    }
  }
}

func_DAD1(param_00) {
  if(!isDefined(self.requireslos)) {
    return 1;
  }

  var_01 = param_00 getEye();
  var_02 = scripts\common\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  var_03 = [];
  if(level.gametype == "tdef" || scripts\mp\utility::istrue(level.devball)) {
    var_04 = self.trigger.origin + (0, 0, 16);
    var_05 = 0;
    var_03[0] = self.visuals[0];
  } else if(level.gametype == "ball") {
    var_04 = self.trigger.origin + (0, 0, 8);
    var_05 = 0;
    var_03[0] = self.visuals[0];
  } else {
    var_04 = self.trigger.origin + (0, 0, 32);
    var_05 = 1;
    var_03[0] = self.visuals;
  }

  var_03[1] = self.carrier;
  var_06 = scripts\common\trace::ray_trace(var_01, var_04, var_03, var_02, 0);
  if(var_06["fraction"] != 1 && var_05) {
    var_04 = self.trigger.origin + (0, 0, 16);
    var_06 = scripts\common\trace::ray_trace(var_01, var_04, var_03, var_02, 0);
  }

  if(var_06["fraction"] != 1) {
    var_04 = self.trigger.origin + (0, 0, 0);
    var_06 = scripts\common\trace::ray_trace(var_01, var_04, var_03, var_02, 0);
  }

  return var_06["fraction"] == 1;
}

setclaimteam(param_00) {
  if(!isDefined(self.claimgracetime)) {
    self.claimgracetime = 1000;
  }

  if(self.claimteam == "none" && gettime() - self.lastclaimtime > self.claimgracetime) {
    self.curprogress = 0;
    self.var_115DF[param_00] = self.curprogress;
  } else if(param_00 != "none" && param_00 != self.lastclaimteam) {
    self.curprogress = 0;
    self.var_115DF[param_00] = self.curprogress;
  }

  self.lastclaimteam = self.claimteam;
  self.lastclaimtime = gettime();
  self.claimteam = param_00;
  func_12F57();
}

func_7E29() {
  return self.claimteam;
}

func_127CA(param_00) {
  var_01 = self.pers["team"];
  param_00.numtouching[var_01]++;
  var_02 = self.guid;
  var_03 = spawnStruct();
  var_03.player = self;
  var_03.starttime = gettime();
  param_00.touchlist[var_01][var_02] = var_03;
  if(!isDefined(param_00.nousebar)) {
    param_00.nousebar = 0;
  }

  self.touchtriggers[param_00.entnum] = param_00.trigger;
  param_00 func_12F57();
  while(scripts\mp\utility::isreallyalive(self) && isDefined(param_00.trigger) && self istouching(param_00.trigger) && !level.gameended) {
    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, param_00)) {
      break;
    }

    if(isplayer(self) && param_00.usetime > 50) {
      updateuiprogress(param_00, 1);
    }

    wait(0.05);
  }

  if(isDefined(self)) {
    if(param_00.usetime > 50) {
      if(isplayer(self)) {
        updateuiprogress(param_00, 0);
      }

      self.touchtriggers[param_00.entnum] = undefined;
    } else {
      self.touchtriggers[param_00.entnum] = undefined;
    }
  }

  if(level.gameended) {
    return;
  }

  param_00.var_C405 = param_00.touchlist;
  param_00.touchlist[var_01][var_02] = undefined;
  param_00.numtouching[var_01]--;
  param_00 func_12F57();
}

migrationcapturereset(param_00) {
  param_00.migrationcapturereset = 1;
  level waittill("host_migration_begin");
  if(!isDefined(param_00) || !isDefined(self)) {
    return;
  }

  param_00 setclientomnvar("ui_securing", 0);
  param_00 setclientomnvar("ui_securing_progress", 0);
  self.migrationcapturereset = undefined;
}

animscriptedthirdperson(param_00) {
  return self.numtouching[scripts\mp\utility::getotherteam(param_00)];
}

updateuiprogress(param_00, param_01) {
  if(!isDefined(level.hostmigrationtimer)) {
    var_02 = 0;
    if(isDefined(param_00.var_115DF) && isDefined(param_00.claimteam)) {
      if(param_00.var_115DF[param_00.claimteam] > param_00.usetime) {
        param_00.var_115DF[param_00.claimteam] = param_00.usetime;
      }

      var_02 = param_00.var_115DF[param_00.claimteam] / param_00.usetime;
    } else {
      if(param_00.curprogress > param_00.usetime) {
        param_00.curprogress = param_00.usetime;
      }

      var_02 = param_00.curprogress / param_00.usetime;
    }

    if(level.gametype == "ctf" && !isDefined(param_00.id)) {
      if(param_01 && scripts\mp\utility::istrue(param_00.stalemate)) {
        if(!isDefined(self.var_12B1C)) {
          if(!isDefined(self.var_12B1B)) {
            self.var_12B1B = 1;
          }

          self setclientomnvar("ui_objective_state", -1);
          self.var_12B1C = 1;
        }

        var_02 = 0.01;
      } else if(param_01 && isDefined(self.var_12B1B) && isDefined(param_00.stalemate) && !param_00.stalemate && param_00.ownerteam != self.team) {
        self setclientomnvar("ui_objective_state", 1);
        self.var_12B1B = 1;
        self.var_12B1C = undefined;
      } else if(param_01 && isDefined(self.var_12B1B) && isDefined(param_00.stalemate) && !param_00.stalemate && param_00.ownerteam == self.team) {
        self setclientomnvar("ui_objective_state", 2);
        self.var_12B1B = 1;
        self.var_12B1C = undefined;
      } else {
        if(!param_01 && isDefined(self.var_12B1C)) {
          self setclientomnvar("ui_objective_state", 0);
          self.var_12B1B = undefined;
        }

        if(param_01 && !isDefined(self.var_12B1C) && param_00.ownerteam == self.team) {
          self setclientomnvar("ui_objective_state", 0);
          self.var_12B1B = undefined;
        }

        if(param_01 && !isDefined(self.var_12B1B)) {
          if(param_00.ownerteam != self.team) {
            self setclientomnvar("ui_objective_state", 1);
            self.var_12B1B = 1;
          } else if(param_00.interactteam == "any") {
            self setclientomnvar("ui_objective_state", 2);
            self.var_12B1B = 1;
          }
        }

        self.var_12B1C = undefined;
      }

      if(!param_01) {
        var_02 = 0.01;
        self setclientomnvar("ui_objective_state", 0);
        self.var_12B1B = undefined;
      }

      if(var_02 != 0) {
        if(isDefined(param_00.var_115DF) && isDefined(param_00.claimteam) && param_01) {
          self setclientomnvar("ui_objective_progress", param_00.var_115DF[self.team] / param_00.usetime);
        } else {
          self setclientomnvar("ui_objective_progress", var_02);
        }
      }
    }

    if(func_8BE7() && isDefined(param_00.id) && param_00.id == "domFlag" || param_00.id == "hardpoint") {
      var_03 = 0;
      if(level.gametype == "koth" || level.gametype == "grnd") {
        var_03 = 7;
        if(scripts\mp\utility::istrue(level.usehqrules) && isDefined(param_00.ownerteam) && param_00.ownerteam != "neutral") {
          var_03 = 8;
        }
      } else {
        if(param_00.label == "_a") {
          var_03 = 1;
        } else if(param_00.label == "_b") {
          var_03 = 2;
        } else if(param_00.label == "_c") {
          var_03 = 3;
        }

        if(scripts\mp\utility::istrue(param_00.neutralizing)) {
          var_03 = var_03 + 3;
        }
      }

      if(param_01 && isDefined(param_00.stalemate) && param_00.stalemate) {
        if(!isDefined(self.ui_dom_stalemate)) {
          if(!isDefined(self.ui_dom_securing)) {
            self.ui_dom_securing = 1;
          }

          self setclientomnvar("ui_objective_state", -1);
          self.ui_dom_stalemate = 1;
        }

        var_02 = 0.01;
      } else if(param_01 && isDefined(self.ui_dom_securing) && isDefined(param_00.stalemate) && !param_00.stalemate && param_00.ownerteam != self.team) {
        self setclientomnvar("ui_objective_state", var_03);
        self.ui_dom_securing = 1;
        self.ui_dom_stalemate = undefined;
      } else {
        if(!param_01 && isDefined(self.ui_dom_stalemate)) {
          self setclientomnvar("ui_objective_state", 0);
          self.ui_dom_securing = undefined;
        }

        if(param_01 && !isDefined(self.ui_dom_stalemate) && param_00.ownerteam == self.team) {
          self setclientomnvar("ui_objective_state", 0);
          self.ui_dom_securing = undefined;
        }

        if(param_01 && !isDefined(self.ui_dom_securing) && param_00.ownerteam != self.team) {
          self setclientomnvar("ui_objective_state", var_03);
          self.ui_dom_securing = 1;
        }

        self.ui_dom_stalemate = undefined;
      }

      if(!param_01 || !param_00 caninteractwith(self.team) && !isDefined(param_00.stalemate) || isDefined(param_00.stalemate) && !param_00.stalemate) {
        var_02 = 0.01;
        self setclientomnvar("ui_objective_state", 0);
        self.ui_dom_securing = undefined;
      }

      if(var_02 != 0) {
        if(isDefined(param_00.var_115DF) && isDefined(param_00.claimteam) && param_01) {
          self setclientomnvar("ui_objective_progress", param_00.var_115DF[self.team] / param_00.usetime);
          return;
        }

        self setclientomnvar("ui_objective_progress", var_02);
        return;
      }

      return;
    }

    if(isbombmode() && isDefined(param_00.id) && param_00.id == "bomb_zone" || param_00.id == "defuse_object") {
      if(isDefined(self)) {
        if(param_01 && isDefined(self)) {
          if(!isDefined(self.ui_bomb_planting_defusing)) {
            var_04 = 0;
            if(param_00.id == "bomb_zone") {
              var_04 = 1;
            } else if(param_00.id == "defuse_object") {
              var_04 = 2;
            }

            self setclientomnvar("ui_objective_state", var_04);
            self.ui_bomb_planting_defusing = 1;
          }
        } else {
          self setclientomnvar("ui_objective_state", 0);
          self.ui_bomb_planting_defusing = undefined;
          var_02 = 0.01;
        }

        if(var_02 != 0) {
          if(isDefined(param_00.var_115DF) && isDefined(param_00.claimteam) && param_01) {
            self setclientomnvar("ui_objective_progress", param_00.var_115DF[self.team] / param_00.usetime);
            return;
          }

          self setclientomnvar("ui_objective_progress", var_02);
          return;
        }

        return;
      }

      return;
    }

    if(isDefined(param_00.id)) {
      var_04 = 0;
      switch (param_00.id) {
        case "care_package":
          var_04 = 1;
          break;

        case "intel":
          var_04 = 2;
          break;

        case "deployable_vest":
          var_04 = 3;
          break;

        case "deployable_weapon_crate":
          var_04 = 4;
          break;

        case "last_stand":
          var_04 = 5;
          if(isDefined(self.inlaststand) && self.inlaststand) {
            var_04 = 6;
          }
          break;

        case "breach":
          var_04 = 7;
          break;

        case "use":
          var_04 = 8;
          break;
      }

      func_12F55(var_02, param_01, var_04, param_00, param_00.usetime);
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

func_12F55(param_00, param_01, param_02, param_03, param_04) {
  if(param_01) {
    if(!isDefined(param_03.usedby)) {
      param_03.usedby = [];
    }

    if(!isDefined(self.migrationcapturereset)) {
      param_03 thread migrationcapturereset(self);
    }

    if(!existinarray(self, param_03.usedby)) {
      param_03.usedby[param_03.usedby.size] = self;
    }

    if(!isDefined(self.ui_securing)) {
      self setclientomnvar("ui_securing", param_02);
      self.ui_securing = 1;
    }
  } else {
    if(isDefined(param_03.usedby) && existinarray(self, param_03.usedby)) {
      param_03.usedby = scripts\engine\utility::array_remove(param_03.usedby, self);
    }

    self setclientomnvar("ui_securing", 0);
    self.ui_securing = undefined;
    param_00 = 0.01;
  }

  if(param_04 == 500) {
    param_00 = min(param_00 + 0.15, 1);
  }

  if(param_00 != 0) {
    self setclientomnvar("ui_securing_progress", param_00);
  }
}

existinarray(param_00, param_01) {
  if(param_01.size > 0) {
    foreach(var_03 in param_01) {
      if(var_03 == param_00) {
        return 1;
      }
    }
  }

  return 0;
}

func_12F57() {
  if(self.claimteam == "none" && self.ownerteam != "neutral" && self.ownerteam != "any") {
    var_00 = self.ownerteam;
  } else {
    var_00 = self.claimteam;
  }

  var_01 = self.numtouching[var_00];
  var_02 = 0;
  var_03 = 0;
  if(level.multiteambased) {
    foreach(var_05 in level.teamnamelist) {
      if(var_00 != var_05) {
        var_02 = var_02 + self.numtouching[var_05];
      }
    }
  } else {
    if(var_00 != "axis") {
      var_02 = var_02 + self.numtouching["axis"];
    }

    if(var_00 != "allies") {
      var_02 = var_02 + self.numtouching["allies"];
    }
  }

  foreach(var_08 in self.touchlist[var_00]) {
    if(!isDefined(var_08.player)) {
      continue;
    }

    if(var_08.player.pers["team"] != var_00) {
      continue;
    }

    if(var_08.player.objectivescaler == 1) {
      continue;
    }

    var_01 = var_01 * var_08.player.objectivescaler;
    var_03 = var_08.player.objectivescaler;
  }

  self.stalemate = var_01 && var_02;
  self.userate = 0;
  if(var_01 && !var_02) {
    self.userate = min(var_01, 4);
  }

  if(isDefined(self.var_9D49) && self.var_9D49 && var_03 != 0) {
    self.userate = 1 * var_03;
    return;
  }

  if(isDefined(self.var_9D49) && self.var_9D49) {
    self.userate = 1;
  }
}

useholdthink(param_00) {
  param_00 notify("use_hold");
  if(isplayer(param_00)) {
    param_00 playerlinkto(self.trigger);
  } else {
    param_00 linkto(self.trigger);
  }

  param_00 playerlinkedoffsetenable();
  param_00 clientclaimtrigger(self.trigger);
  param_00.var_3FFA = self.trigger;
  param_00 allowmovement(0);
  param_00 unlink();
  if(isbombmode()) {
    if(scripts\mp\utility::isanymlgmatch() || scripts\mp\utility::istrue(level.silentplant) || param_00 scripts\mp\utility::_hasperk("specialty_engineer")) {
      self.useweapon = "briefcase_bomb_defuse_mp";
    } else {
      self.useweapon = "briefcase_bomb_mp";
    }
  }

  var_01 = self.useweapon;
  var_02 = param_00 getcurrentweapon();
  if(isDefined(var_01)) {
    if(var_02 == var_01) {
      var_02 = param_00.var_A9C6;
    }

    param_00.var_A9C6 = var_02;
    param_00 scripts\mp\utility::_giveweapon(var_01);
    param_00 setweaponammostock(var_01, 0);
    param_00 setweaponammoclip(var_01, 0);
    param_00 thread func_11382(var_01);
  } else {
    param_00 scripts\engine\utility::allow_weapon(0);
  }

  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  var_03 = useholdthinkloop(param_00, var_02);
  if(isDefined(param_00)) {
    param_00 detachusemodels();
    param_00 notify("done_using");
  }

  if(isDefined(var_01) && isDefined(param_00)) {
    param_00 scripts\mp\supers::unstowsuperweapon();
    if(param_00 scripts\mp\utility::isreliablyswitchingtoweapon(var_01)) {
      param_00 scripts\mp\utility::func_1529(var_01);
    } else {
      param_00 thread scripts\mp\utility::forcethirdpersonwhenfollowing(var_01);
    }
  }

  if(isDefined(var_03) && var_03) {
    param_00 allowmovement(1);
    return 1;
  }

  if(isDefined(param_00)) {
    param_00.var_3FFA = undefined;
    if(!isDefined(var_01)) {
      param_00 scripts\engine\utility::allow_weapon(1);
    }

    if(!scripts\mp\utility::isreallyalive(param_00)) {
      param_00.var_A64F = 1;
    }

    param_00 allowmovement(1);
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

func_11382(param_00) {
  scripts\mp\supers::allowsuperweaponstow();
  var_01 = scripts\mp\utility::func_11383(param_00, 1);
  if(!scripts\engine\utility::istrue(var_01)) {
    scripts\mp\supers::unstowsuperweapon();
    if(scripts\mp\utility::isreliablyswitchingtoweapon(param_00)) {
      scripts\mp\utility::func_1529(param_00);
      return;
    }

    scripts\mp\utility::_takeweapon(param_00);
  }
}

func_130E9(param_00, param_01, param_02, param_03) {
  if(!scripts\mp\utility::isreallyalive(param_00)) {
    return 0;
  }

  if(!param_00 istouching(self.trigger)) {
    return 0;
  }

  if(!param_00 usebuttonpressed()) {
    return 0;
  }

  if(param_00 scripts\mp\utility::_meth_85C7()) {
    return 0;
  }

  if(param_00 meleebuttonpressed()) {
    return 0;
  }

  if(self.curprogress >= self.usetime) {
    return 0;
  }

  if(!self.userate && !param_01) {
    return 0;
  }

  if(param_01 && param_02 > param_03) {
    return 0;
  }

  if(isDefined(self.useweapon)) {
    if(param_00 getcurrentweapon() != self.useweapon && !param_00 scripts\mp\utility::isreliablyswitchingtoweapon(self.useweapon)) {
      return 0;
    }
  }

  return 1;
}

useholdthinkloop(param_00, param_01) {
  level endon("game_ended");
  self endon("disabled");
  var_02 = self.useweapon;
  var_03 = 1;
  if(isDefined(self.var_136F6)) {
    var_03 = self.var_136F6;
  }

  if(!var_03) {
    self.userate = 1 * param_00.objectivescaler;
  }

  var_04 = 0;
  var_05 = 1.5;
  while(func_130E9(param_00, var_03, var_04, var_05)) {
    var_04 = var_04 + 0.05;
    if(!var_03 || !isDefined(var_02) || param_00 getcurrentweapon() == var_02) {
      self.curprogress = self.curprogress + 50 * self.userate;
      self.userate = 1 * param_00.objectivescaler;
      var_03 = 0;
    } else {
      self.userate = 0;
    }

    param_00 updateuiprogress(self, 1);
    if(self.curprogress >= self.usetime) {
      self.inuse = 0;
      param_00 clientreleasetrigger(self.trigger);
      param_00.var_3FFA = undefined;
      if(!isDefined(var_02)) {
        param_00 scripts\engine\utility::allow_weapon(1);
      }

      param_00 unlink();
      return scripts\mp\utility::isreallyalive(param_00);
    }

    wait(0.05);
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }

  param_00 updateuiprogress(self, 0);
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

getmlgteamcolor(param_00) {
  if(param_00 == "allies") {
    return game["colors"]["friendly"];
  } else if(param_00 == "axis") {
    return game["colors"]["enemy"];
  }

  return (1, 1, 1);
}

setobjpointteamcolor(param_00, param_01, param_02) {
  if(param_01 == "mlg_allies") {
    param_00 setmlgdraw(1, 0);
    var_03 = self.worldiconscolor[param_02];
    if(var_03 == "friendly") {
      param_00.color = getmlgteamcolor("allies");
      return;
    }

    if(var_03 == "enemy") {
      param_00.color = getmlgteamcolor("axis");
      return;
    }

    param_00.color = game["colors"][var_03];
    return;
  }

  if(param_01 == "mlg_axis") {
    param_00 setmlgdraw(1, 0);
    var_03 = self.worldiconscolor[param_02];
    if(var_03 == "friendly") {
      param_00.color = getmlgteamcolor("axis");
      return;
    }

    if(var_03 == "enemy") {
      param_00.color = getmlgteamcolor("allies");
      return;
    }

    param_00.color = game["colors"][var_03];
    return;
  }

  param_00.color = game["colors"][self.worldiconscolor[param_02]];
  param_00 setmlgdraw(0, 1);
}

updateworldicon(param_00, param_01) {
  if(!isDefined(self.var_13DCA[param_00])) {
    param_01 = 0;
  }

  var_02 = getupdateteams(param_00);
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    var_03 = var_02.size;
    for(var_04 = 0; var_04 < var_03; var_04++) {
      if(var_02[var_04] == "allies") {
        var_02[var_02.size] = "mlg_allies";
        continue;
      }

      if(var_02[var_04] == "axis") {
        var_02[var_02.size] = "mlg_axis";
      }
    }
  }

  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    var_05 = "objpoint_" + var_02[var_04] + "_" + self.entnum;
    var_06 = scripts\mp\objpoints::getobjpointbyname(var_05);
    if(!isDefined(var_06)) {
      continue;
    }

    var_06 notify("stop_flashing_thread");
    var_06 thread scripts\mp\objpoints::stopflashing();
    if(param_01) {
      var_06 setshader(self.var_13DCA[param_00], level.objpointsize, level.objpointsize);
      var_06 fadeovertime(0.05);
      var_06.alpha = var_06.basealpha;
      var_06.var_9F51 = 1;
      if(level.gametype == "dom") {
        var_06 setwaypoint(0, 1);
      } else if(isDefined(self.var_4465[param_00])) {
        var_06 setwaypoint(1, 1);
      } else {
        var_06 setwaypoint(1, 0);
      }

      setobjpointteamcolor(var_06, var_02[var_04], param_00);
      var_06 setwaypointbackground(getwaypointbackgroundtype(self.var_13DCA[param_00]));
      if(self.type == "carryObject") {
        var_07 = var_02[var_04] == "mlg_allies" || var_02[var_04] == "mlg_axis";
        if(isDefined(self.carrier) && !shouldpingobject(param_00) || var_07) {
          var_06 settargetent(self.carrier);
        } else if(!isDefined(self.carrier) && isDefined(self.objectiveonvisuals) && self.objectiveonvisuals) {
          var_06 settargetent(self.visuals[0]);
        } else {
          var_06 cleartargetent();
        }
      } else if(isDefined(self.var_C2B4)) {
        var_06 settargetent(self.var_C2B4);
      }
    } else {
      var_06 fadeovertime(0.05);
      var_06.alpha = 0;
      var_06.var_9F51 = 0;
      var_06 cleartargetent();
    }

    var_06 thread hideworldiconongameend();
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

func_12F43(param_00, param_01) {}

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

updateobjectiveiconcolortype(param_00, param_01) {
  var_02 = self.worldiconscolor[param_01];
  if(!isDefined(var_02)) {
    scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(param_00, 0);
    return;
  }

  if(var_02 == "friendly") {
    scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(param_00, 1);
    return;
  }

  if(var_02 == "enemy") {
    scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(param_00, 2);
    return;
  }

  if(var_02 == "contest") {
    scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(param_00, 3);
    return;
  }

  scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(param_00, 0);
}

updatecompassicon(param_00, param_01) {
  var_02 = getupdateteams(param_00);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = var_02[var_03];
    var_05 = param_01;
    if(!var_05 && shouldshowcompassduetoradar(var_04)) {
      var_05 = 1;
    }

    var_06 = self.teamobjids[var_04];
    if(var_06 != -1) {
      if(!isDefined(self.var_4465[param_00]) || !var_05) {
        scripts\mp\objidpoolmanager::minimap_objective_state(var_06, "invisible");
        continue;
      }

      scripts\mp\objidpoolmanager::minimap_objective_icon(var_06, self.var_4465[param_00]);
      scripts\mp\objidpoolmanager::minimap_objective_state(var_06, "active");
      scripts\mp\objidpoolmanager::minimap_objective_icon_backgroundtype(var_06, getwaypointbackgroundtype(self.var_4465[param_00]));
      updateobjectiveiconcolortype(var_06, param_00);
      if(self.type == "carryObject") {
        if(scripts\mp\utility::isreallyalive(self.carrier) && !shouldpingobject(param_00)) {
          scripts\mp\objidpoolmanager::minimap_objective_onentity(var_06, self.carrier);
        } else if(isDefined(self.visuals) && isDefined(self.visuals[0]) && isDefined(self.visuals[0] getlinkedparent())) {
          scripts\mp\objidpoolmanager::minimap_objective_onentity(var_06, self.visuals[0]);
        } else if(isDefined(self.objectiveonvisuals) && self.objectiveonvisuals && !shouldpingobject(param_00)) {
          scripts\mp\objidpoolmanager::minimap_objective_onentity(var_06, self.visuals[0]);
        } else {
          scripts\mp\objidpoolmanager::minimap_objective_position(var_06, self.curorigin);
        }

        continue;
      }

      if(isDefined(self.var_C2B4)) {
        scripts\mp\objidpoolmanager::minimap_objective_onentity(var_06, self.var_C2B4);
      }
    }
  }
}

shouldpingobject(param_00) {
  if(param_00 == "friendly" && self.objidpingenemy) {
    return 1;
  } else if(param_00 == "enemy" && self.objidpingfriendly) {
    return 1;
  }

  return 0;
}

getupdateteams(param_00) {
  var_01 = [];
  foreach(var_03 in level.teamnamelist) {
    if(param_00 == "friendly") {
      if(isfriendlyteam(var_03)) {
        var_01[var_01.size] = var_03;
      }

      continue;
    }

    if(param_00 == "enemy") {
      if(!isfriendlyteam(var_03)) {
        var_01[var_01.size] = var_03;
      }
    }
  }

  return var_01;
}

shouldshowcompassduetoradar(param_00) {
  if(!isDefined(self.carrier)) {
    return 0;
  }

  if(self.carrier scripts\mp\utility::_hasperk("specialty_gpsjammer")) {
    return 0;
  }

  return getteamradar(param_00);
}

updatevisibilityaccordingtoradar() {
  self endon("death");
  self endon("carrier_cleared");
  for(;;) {
    level waittill("radar_status_change");
    updatecompassicons();
  }
}

setownerteam(param_00) {
  self.ownerteam = param_00;
  updatetrigger();
  updatecompassicons();
  updateworldicons();
  if(param_00 != "neutral") {
    self.prevownerteam = param_00;
  }
}

getownerteam() {
  return self.ownerteam;
}

setusetime(param_00) {
  self.usetime = int(param_00 * 1000);
}

setwaitweaponchangeonuse(param_00) {
  self.var_136F6 = param_00;
}

setusetext(param_00) {
  self.var_130EB = param_00;
}

setteamusetime(param_00, param_01) {
  self.teamusetimes[param_00] = int(param_01 * 1000);
}

setteamusetext(param_00, param_01) {
  self.teamusetexts[param_00] = param_01;
}

setusehinttext(param_00) {
  self.trigger sethintstring(param_00);
}

allowcarry(param_00) {
  self.interactteam = param_00;
}

allowuse(param_00) {
  self.interactteam = param_00;
  updatetrigger();
}

setvisibleteam(param_00) {
  self.visibleteam = param_00;
  updatecompassicons();
  updateworldicons();
}

setmodelvisibility(param_00) {
  if(param_00) {
    for(var_01 = 0; var_01 < self.visuals.size; var_01++) {
      self.visuals[var_01] show();
      if(self.visuals[var_01].classname == "script_brushmodel" || self.visuals[var_01].classname == "script_model") {
        foreach(var_03 in level.players) {
          if(var_03 istouching(self.visuals[var_01])) {
            var_03 scripts\mp\utility::_suicide();
          }
        }

        self.visuals[var_01] thread makesolid();
      }
    }

    return;
  }

  for(var_01 = 0; var_01 < self.visuals.size; var_01++) {
    self.visuals[var_01] hide();
    if(self.visuals[var_01].classname == "script_brushmodel" || self.visuals[var_01].classname == "script_model") {
      self.visuals[var_01] notify("changing_solidness");
      self.visuals[var_01] notsolid();
    }
  }
}

makesolid() {
  self endon("death");
  self notify("changing_solidness");
  self endon("changing_solidness");
  for(;;) {
    for(var_00 = 0; var_00 < level.players.size; var_00++) {
      if(level.players[var_00] istouching(self)) {
        break;
      }
    }

    if(var_00 == level.players.size) {
      self solid();
      break;
    }

    wait(0.05);
  }
}

func_F680(param_00) {
  self.carriervisible = param_00;
}

func_F67D(param_00) {
  self.var_130E5 = param_00;
}

set2dicon(param_00, param_01) {
  self.var_4465[param_00] = param_01;
  if(!isDefined(param_01)) {
    self.worldiconscolor[param_00] = "neutral";
  } else {
    self.worldiconscolor[param_00] = getwaypointbackgroundcolor(param_01);
  }

  updatecompassicons();
}

getwaypointbackgroundtype(param_00) {
  if(!isDefined(level.waypointbgtype)) {
    scripts\mp\gamelogic::initwaypointbackgrounds();
  }

  var_01 = level.waypointbgtype[param_00];
  if(!isDefined(var_01)) {
    return 0;
  }

  return var_01;
}

getwaypointbackgroundcolor(param_00) {
  if(!isDefined(level.waypointcolors)) {
    scripts\mp\gamelogic::initwaypointbackgrounds();
  }

  var_01 = level.waypointcolors[param_00];
  if(!isDefined(var_01)) {
    return "neutral";
  }

  return var_01;
}

set3dicon(param_00, param_01) {
  self.var_13DCA[param_00] = param_01;
  if(!isDefined(param_01)) {
    self.worldiconscolor[param_00] = "neutral";
  } else {
    self.worldiconscolor[param_00] = getwaypointbackgroundcolor(param_01);
  }

  updateworldicons();
}

set3duseicon(param_00, param_01) {
  self.var_13DCD[param_00] = param_01;
}

setcarryicon(param_00) {
  self.carryicon = param_00;
}

disableobject() {
  self notify("disabled");
  if(self.type == "carryObject") {
    if(isDefined(self.carrier)) {
      self.carrier takeobject(self);
    }

    for(var_00 = 0; var_00 < self.visuals.size; var_00++) {
      self.visuals[var_00] hide();
    }
  }

  self.trigger scripts\engine\utility::trigger_off();
  setvisibleteam("none");
}

enableobject() {
  if(self.type == "carryObject") {
    for(var_00 = 0; var_00 < self.visuals.size; var_00++) {
      self.visuals[var_00] show();
    }
  }

  self.trigger scripts\engine\utility::trigger_on();
  setvisibleteam("any");
}

getrelativeteam(param_00) {
  if(param_00 == self.ownerteam) {
    return "friendly";
  }

  return "enemy";
}

isfriendlyteam(param_00) {
  if(self.ownerteam == "any") {
    return 1;
  }

  if(self.ownerteam == param_00) {
    return 1;
  }

  if(self.ownerteam == "neutral" && isDefined(self.prevownerteam) && self.prevownerteam == param_00) {
    return 1;
  }

  return 0;
}

caninteractwith(param_00, param_01) {
  switch (self.interactteam) {
    case "none":
      return 0;

    case "any":
      return 1;

    case "friendly":
      if(param_00 == self.ownerteam) {
        return 1;
      } else {
        return 0;
      }

      break;

    case "enemy":
      if(param_00 != self.ownerteam) {
        return 1;
      } else {
        return 0;
      }

      break;

    default:
      return 0;
  }
}

isteam(param_00) {
  if(param_00 == "neutral") {
    return 1;
  }

  if(param_00 == "allies") {
    return 1;
  }

  if(param_00 == "axis") {
    return 1;
  }

  if(param_00 == "any") {
    return 1;
  }

  if(param_00 == "none") {
    return 1;
  }

  foreach(var_02 in level.teamnamelist) {
    if(param_00 == var_02) {
      return 1;
    }
  }

  return 0;
}

isrelativeteam(param_00) {
  if(param_00 == "friendly") {
    return 1;
  }

  if(param_00 == "enemy") {
    return 1;
  }

  if(param_00 == "any") {
    return 1;
  }

  if(param_00 == "none") {
    return 1;
  }

  return 0;
}

getenemyteam(param_00) {
  if(level.multiteambased) {}

  if(!level.teambased) {}

  if(param_00 == "neutral") {
    return "none";
  }

  if(param_00 == "allies") {
    return "axis";
  }

  return "allies";
}

getlabel() {
  var_00 = self.trigger.script_label;
  if(!isDefined(var_00)) {
    var_00 = "";
    return var_00;
  }

  if(var_00[0] != "_") {
    return "_" + var_00;
  }

  return var_00;
}

initializetagpathvariables() {
  self.nearest_node = undefined;
  self.calculated_nearest_node = 0;
  self.on_path_grid = undefined;
}

mustmaintainclaim(param_00) {
  self.mustmaintainclaim = param_00;
}

cancontestclaim(param_00) {
  self.cancontestclaim = param_00;
}

setzonestatusicons(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = param_00;
  }

  set2dicon("friendly", param_00);
  set3dicon("friendly", param_00);
  set2dicon("enemy", param_01);
  set3dicon("enemy", param_01);
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

touchingdroptonavmeshtrigger(param_00) {
  if(level.droptonavmeshtriggers.size > 0) {
    if(isbombmode() || level.gametype == "ctf") {
      self.visuals[0].origin = param_00;
    }

    foreach(var_02 in level.droptonavmeshtriggers) {
      foreach(var_04 in self.visuals) {
        if(var_04 istouching(var_02)) {
          return 1;
        }
      }
    }
  }

  return 0;
}

touchingarbitraryuptrigger() {
  if(level.arbitraryuptriggers.size > 0) {
    foreach(var_01 in level.arbitraryuptriggers) {
      if(self istouching(var_01)) {
        return 1;
      }
    }
  }

  return 0;
}