/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2736.gsc
***************************************/

main(var_00) {
  var_0[var_0.size] = "airdrop_pallet";
  var_01 = getEntArray();

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    if(isDefined(var_1[var_02].script_gameobjectname)) {
      var_03 = 1;
      var_04 = strtok(var_1[var_02].script_gameobjectname, " ");

      for(var_05 = 0; var_05 < var_0.size; var_5++) {
        for(var_06 = 0; var_06 < var_4.size; var_6++) {
          if(var_4[var_06] == var_0[var_05]) {
            var_03 = 0;
            break;
          }
        }

        if(!var_03) {
          break;
        }
      }

      if(var_03) {
        var_1[var_02] delete();
      }
    }
  }
}

init() {
  level.func_C22E = 0;
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
  self.func_3FFA = undefined;
  self.func_38ED = 1;
  self.func_A64F = undefined;
  self.func_987A = 1;
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

func_4A29(var_00, var_01) {
  var_02 = spawn("script_model", self.origin);
  var_02 setModel("tag_origin");
  var_03 = spawnStruct();
  var_3.type = "carryObject";
  var_3.carrier = var_00;
  var_3.curorigin = var_0.origin;
  var_3.entnum = var_02 getentitynumber();
  var_3.ownerteam = var_0.team;
  var_3.func_4465 = [];
  var_3.objidpingenemy = 0;
  var_3.objidpingfriendly = 0;
  var_3.func_13DCA = [];
  var_3.carriervisible = 0;
  var_3.visibleteam = "none";

  foreach(var_05 in level.teamnamelist) {
    var_3.teamobjids[var_05] = ::scripts\mp\objidpoolmanager::requestminimapid(99);

    if(var_3.teamobjids[var_05] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_3.teamobjids[var_05], "invisible", var_3.curorigin);
      scripts\mp\objidpoolmanager::minimap_objective_team(var_3.teamobjids[var_05], var_05);
    }

    var_3.objpoints[var_05] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_05 + "_" + var_3.entnum, var_3.curorigin + var_01, var_05, undefined);
    var_3.objpoints[var_05].alpha = 0;

    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_06 = "mlg_" + var_05;
      var_3.objpoints[var_06] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_06 + "_" + var_3.entnum, var_3.curorigin + var_01, var_05, undefined);
      var_3.objpoints[var_06].alpha = 0;
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
  var_0.type = undefined;
  var_0.carrier = undefined;
  var_0.curorigin = undefined;
  var_0.entnum = undefined;
  var_0.ownerteam = undefined;
  var_0.func_4465 = undefined;
  var_0.objidpingenemy = undefined;
  var_0.objidpingfriendly = undefined;
  var_0.func_13DCA = undefined;
  var_0.carriervisible = undefined;
  var_0.visibleteam = undefined;

  foreach(var_02 in level.teamnamelist) {
    scripts\mp\objidpoolmanager::returnminimapid(var_0.teamobjids[var_02]);
    scripts\mp\objpoints::deleteobjpoint(var_0.objpoints[var_02]);

    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_03 = "mlg_" + var_02;
      scripts\mp\objpoints::deleteobjpoint(var_0.objpoints[var_03]);
    }
  }
}

createcarryobject(var_00, var_01, var_02, var_03) {
  var_04 = spawnStruct();
  var_4.type = "carryObject";
  var_4.curorigin = var_1.origin;
  var_4.ownerteam = var_00;
  var_4.entnum = var_01 getentitynumber();

  if(issubstr(var_1.classname, "use")) {
    var_4.triggertype = "use";
  } else {
    var_4.triggertype = "proximity";
  }

  var_1.baseorigin = var_1.origin;
  var_4.trigger = var_01;

  if(!isDefined(var_1.linktoenabledflag)) {
    var_1.linktoenabledflag = 1;
    var_01 getrankxp();
  }

  var_4.useweapon = undefined;

  if(!isDefined(var_03)) {
    var_03 = (0, 0, 0);
  }

  var_4.offset3d = var_03;

  for(var_05 = 0; var_05 < var_2.size; var_5++) {
    var_2[var_05].baseorigin = var_2[var_05].origin;
    var_2[var_05].baseangle = var_2[var_05].angles;
  }

  var_4.visuals = var_02;
  var_4.func_4465 = [];
  var_4.objidpingenemy = 0;
  var_4.objidpingfriendly = 0;

  foreach(var_07 in level.teamnamelist) {
    var_4.teamobjids[var_07] = ::scripts\mp\objidpoolmanager::requestminimapid(99);

    if(var_4.teamobjids[var_07] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_4.teamobjids[var_07], "invisible", var_4.curorigin);
      scripts\mp\objidpoolmanager::minimap_objective_team(var_4.teamobjids[var_07], var_07);
    }

    var_4.objpoints[var_07] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_07 + "_" + var_4.entnum, var_4.curorigin + var_03, var_07, undefined);
    var_4.objpoints[var_07].alpha = 0;

    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_08 = "mlg_" + var_07;
      var_4.objpoints[var_08] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_08 + "_" + var_4.entnum, var_4.curorigin + var_03, var_07, undefined);
      var_4.objpoints[var_08].alpha = 0;
    }
  }

  var_4.carrier = undefined;
  var_4.isresetting = 0;
  var_4.interactteam = "none";
  var_4.allowweapons = 0;
  var_4.func_13DCA = [];
  var_4.carriervisible = 0;
  var_4.visibleteam = "none";
  var_4.carryicon = undefined;
  var_4.ondrop = undefined;
  var_4.onpickup = undefined;
  var_4.onreset = undefined;

  if(var_4.triggertype == "use") {
    var_04 thread carryobjectusethink();
  } else {
    var_4.curprogress = 0;
    var_4.func_115DF = [];
    var_4.func_115DF["none"] = 0;
    var_4.func_115DF["allies"] = 0;
    var_4.func_115DF["axis"] = 0;
    var_4.usetime = 0;
    var_4.userate = 0;
    var_4.mustmaintainclaim = 0;
    var_4.cancontestclaim = 0;
    var_4.teamusetimes = [];
    var_4.teamusetexts = [];
    var_4.func_C248["neutral"] = 0;
    var_4.touchlist["neutral"] = [];
    var_4.func_C248["none"] = 0;
    var_4.touchlist["none"] = [];

    foreach(var_11 in level.teamnamelist) {
      var_4.func_C248[var_11] = 0;
      var_4.touchlist[var_11] = [];
    }

    var_4.claimteam = "none";
    var_4.func_3FF8 = undefined;
    var_4.func_A95A = "none";
    var_4.func_A95B = 0;
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
  var_0.type = undefined;
  var_0.curorigin = undefined;
  var_0.ownerteam = undefined;
  var_0.entnum = undefined;
  var_0.triggertype = undefined;
  var_0.trigger unlink();
  var_0.trigger = undefined;
  var_0.useweapon = undefined;
  var_0.offset3d = undefined;

  foreach(var_02 in var_0.visuals) {
    var_02 delete();
  }

  var_0.visuals = undefined;
  var_0.func_4465 = undefined;
  var_0.objidpingenemy = undefined;
  var_0.objidpingfriendly = undefined;
  var_0.objpingdelay = undefined;
  scripts\mp\objpoints::deleteobjpoint(var_0.objpoints["allies"]);
  scripts\mp\objpoints::deleteobjpoint(var_0.objpoints["axis"]);

  foreach(var_05 in level.teamnamelist) {
    scripts\mp\objidpoolmanager::returnminimapid(var_0.teamobjids[var_05]);
    scripts\mp\objpoints::deleteobjpoint(var_0.objpoints[var_05]);

    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_06 = "mlg_" + var_05;
      scripts\mp\objpoints::deleteobjpoint(var_0.objpoints[var_06]);
    }
  }

  var_0.objpoints = undefined;
  var_0.carrier = undefined;
  var_0.isresetting = undefined;
  var_0.interactteam = undefined;
  var_0.allowweapons = undefined;
  var_0.func_A57D = undefined;
  var_0.func_13DCA = undefined;
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
  var_0.func_C248 = undefined;
  var_0.touchlist = undefined;
  var_0.claimteam = undefined;
  var_0.func_3FF8 = undefined;
  var_0.func_A95A = undefined;
  var_0.func_A95B = undefined;
  var_00 notify("death");
  var_00 notify("deleted");
}

carryobjectusethink() {
  level endon("game_ended");

  for(;;) {
    self.trigger waittill("trigger", var_00);

    if(scripts\mp\utility\game::func_9F22(var_00)) {
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
    if(var_00 scripts\mp\utility\game::isanymonitoredweaponswitchinprogress()) {
      var_01 = var_00 scripts\mp\utility\game::getcurrentmonitoredweaponswitchweapon();

      if(var_01 == "ks_remote_map_mp" || var_01 == "ks_remote_device_mp") {
        continue;
      }
    }

    if(scripts\mp\utility\game::istrue(var_0.using_remote_turret)) {
      continue;
    }
    if(!func_DAD1(var_00)) {
      continue;
    }
    if(self.isresetting) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_00)) {
      continue;
    }
    if(!caninteractwith(var_0.pers["team"])) {
      continue;
    }
    if(!var_0.func_38ED) {
      continue;
    }
    if(isDefined(var_0.nopickuptime) && var_0.nopickuptime > gettime()) {
      continue;
    }
    if(!isDefined(var_0.func_987A)) {
      continue;
    }
    if(var_00 scripts\mp\utility\game::_meth_85C7()) {
      var_02 = var_00 _meth_854D();

      if(!scripts\mp\utility\game::isgesture(var_02)) {
        continue;
      }
    }

    if(isDefined(self.carrier)) {
      continue;
    }
    if(var_00 scripts\mp\utility\game::isusingremote()) {
      continue;
    }
    setpickedup(var_00);
  }
}

carryobjectasset() {
  if(level.gametype == "ball" || level.gametype == "tdef") {
    thread carryobjectusethink();
  } else {
    thread carryobjectproxthink();
  }
}

carryobjectproxthink() {
  level endon("game_ended");

  if(isDefined(self.trigger)) {
    self.trigger endon("move_gameobject");
  }

  thread func_DAD2();

  for(;;) {
    if(self.usetime && self.func_115DF[self.claimteam] >= self.usetime) {
      self.curprogress = 0.0;
      self.func_115DF[self.claimteam] = self.curprogress;
      var_00 = getearliestclaimplayer();

      if(isDefined(self.onenduse)) {
        self[[self.onenduse]](func_7E29(), var_00, isDefined(var_00));
      }

      if(isDefined(var_00)) {
        setpickedup(var_00);
      }

      setclaimteam("none");
      self.func_3FF8 = undefined;
    }

    if(self.claimteam != "none") {
      if(self.usetime) {
        if(!self.func_C248[self.claimteam]) {
          if(isDefined(self.onenduse)) {
            self[[self.onenduse]](func_7E29(), self.func_3FF8, 0);
          }

          setclaimteam("none");
          self.func_3FF8 = undefined;
        } else {
          self.curprogress = self.curprogress + 50 * self.userate;
          self.func_115DF[self.claimteam] = self.curprogress;

          if(self.ownerteam != level.otherteam[self.claimteam]) {
            self.func_115DF[level.otherteam[self.claimteam]] = 0;
          }

          if(isDefined(self.onuseupdate)) {
            self[[self.onuseupdate]](func_7E29(), self.curprogress / self.usetime, 50 * self.userate / self.usetime, self.func_3FF8);
          }
        }
      } else {
        if(scripts\mp\utility\game::isreallyalive(self.func_3FF8)) {
          setpickedup(self.func_3FF8);
        }

        setclaimteam("none");
        self.func_3FF8 = undefined;
      }
    }

    wait 0.05;
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

func_CB44(var_00) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self.func_38ED = 0;

  if(isDefined(var_0.ballindex)) {
    var_01 = 1024;
  } else {
    var_01 = 4096;
  }

  for(;;) {
    if(distancesquared(self.origin, var_0.trigger.origin) > var_01) {
      break;
    }
    wait 0.2;
  }

  if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
    self.func_38ED = 1;
  }
}

setpickedup(var_00) {
  if(isai(var_00) && isDefined(var_0.owner)) {
    return;
  }
  if(isDefined(var_0.carryobject) || isDefined(self.carryweapon) && !var_00 scripts\engine\utility::isweaponallowed()) {
    if(isDefined(self.onpickupfailed)) {
      self[[self.onpickupfailed]](var_00);
    }

    return;
  }

  var_00 giveobject(self);
  setcarrier(var_00);

  if(isDefined(self.trigger getlinkedparent())) {
    for(var_01 = 0; var_01 < self.visuals.size; var_1++) {
      self.visuals[var_01] unlink();
    }

    self.trigger unlink();
  }

  for(var_01 = 0; var_01 < self.visuals.size; var_1++) {
    self.visuals[var_01] hide();
  }

  self.trigger.origin = self.trigger.origin + (0, 0, 10000);
  self.trigger scripts\mp\movers::stop_handling_moving_platforms();
  self notify("pickup_object");

  if(isDefined(self.onpickup)) {
    self[[self.onpickup]](var_00);
  }

  updatecompassicons();
  func_12F68();
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

    wait 0.05;
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
    self.objpingdelay = 4.0;
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
          if(self.objpoints[var_01].func_9F51) {
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
          if(self.objpoints[var_01].func_9F51) {
            self.objpoints[var_01].alpha = self.objpoints[var_01].basealpha;
            self.objpoints[var_01] fadeovertime(self.objpingdelay);
            self.objpoints[var_01].alpha = 0;
          }

          if(self.teamobjids[var_01] != -1) {
            scripts\mp\objidpoolmanager::minimap_objective_position(self.teamobjids[var_01], self.curorigin);
          }
        }
      }

      scripts\mp\utility\game::func_1359E(self.objpingdelay, "dropped", "reset");
      continue;
    }

    foreach(var_01 in level.teamnamelist) {
      self.objpoints[var_01] scripts\mp\objpoints::updateorigin(self.curorigin + self.offset3d);
    }

    wait 0.05;
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

watchcarryobjectweaponswitch(var_00) {
  self endon("goal_scored");
  var_01 = gettime();
  var_02 = scripts\mp\utility\game::func_11383(var_00, 1);

  if(isDefined(var_02)) {
    if(var_02 == 0) {
      if(var_01 == gettime()) {
        waittillframeend;
      }

      if(isDefined(self.carryobject)) {
        self.carryobject thread setdropped();
      }
    }
  }
}

giveobject(var_00) {
  self.carryobject = var_00;
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

  for(var_00 = 0; var_00 < self.visuals.size; var_0++) {
    var_01 = self.visuals[var_00] getlinkedparent();

    if(isDefined(var_01)) {
      self.visuals[var_00] unlink();
    }

    if(isbombmode() && self.visuals[var_00].targetname == "sd_bomb") {
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
  func_12F68();
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

setposition(var_00, var_01) {
  self.isresetting = 1;

  for(var_02 = 0; var_02 < self.visuals.size; var_2++) {
    self.visuals[var_02].origin = var_00;
    self.visuals[var_02].angles = var_01;
    self.visuals[var_02] show();
  }

  self.trigger.origin = var_00;

  if(level.gametype == "ball" || level.gametype == "tdef") {
    self.trigger linkto(self.visuals[0]);
  }

  self.curorigin = self.trigger.origin;
  clearcarrier();
  func_12F68();
  updatecompassicons();
  self.isresetting = 0;
}

onplayerlaststand() {
  if(isDefined(self.carryobject)) {
    self.carryobject thread setdropped();
  }
}

carryobject_overridemovingplatformdeath(var_00) {
  for(var_01 = 0; var_01 < var_0.carryobject.visuals.size; var_1++) {
    var_0.carryobject.visuals[var_01] unlink();
  }

  var_0.carryobject.trigger unlink();
  var_0.carryobject thread setdropped(1);
}

setdropped(var_00) {
  if(isDefined(self.setdropped)) {
    if([
        [self.setdropped]
      ]())
      return;
  }

  self.isresetting = 1;
  self.func_E25D = undefined;
  self notify("dropped");

  foreach(var_02 in self.visuals) {
    var_2.func_D887 = var_02 setcontents(0);
  }

  if(isDefined(self.carrier)) {
    var_04 = self.carrier.origin;
  } else {
    var_04 = self.curorigin;
  }

  if(scripts\mp\utility\game::istrue(level.botsenabled) || isDefined(self.ftldrop) || touchingdroptonavmeshtrigger(var_04) || level.mapname == "mp_junk" && level.gametype == "ctf" && !self.carrier touchingarbitraryuptrigger()) {
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

    if(var_7[2] < 0) {
      var_05 = -20;
      var_06 = -4000;
    }
  }

  var_09 = var_04 + (0, 0, var_05);
  var_10 = var_04 - (0, 0, var_06);
  var_11 = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
  var_12 = [];
  var_12[0] = self.visuals[0];
  var_12[1] = self.carrier;

  if(isDefined(self.carrier) && self.carrier.team != "spectator") {
    if(level.gametype != "ctf") {
      var_13 = scripts\engine\trace::capsule_trace(var_09, var_10, 8, 16, (0, 0, 0), var_12, var_11, 0);
    } else {
      var_13 = scripts\engine\trace::capsule_trace(var_09, var_10, 2, 4, (0, 0, 0), var_12, var_11, 0);
    }
  } else {
    var_13 = scripts\engine\trace::ray_trace(self.safeorigin + (0, 0, 20), self.safeorigin - (0, 0, 20), var_12, var_11, 0);

    if(isplayer(var_13["entity"])) {
      var_13["entity"] = undefined;
    }
  }

  foreach(var_02 in self.visuals) {
    var_02 setcontents(var_2.func_D887);
  }

  var_16 = self.carrier;
  var_17 = 0;

  if(isDefined(var_13)) {
    var_18 = randomfloat(360);
    var_19 = var_13["position"];

    if(isDefined(self.visualgroundoffset)) {
      var_19 = var_19 + self.visualgroundoffset;
    }

    var_20 = (cos(var_18), sin(var_18), 0);
    var_20 = vectornormalize(var_20 - var_13["normal"] * vectordot(var_20, var_13["normal"]));
    var_21 = 0;

    if(level.gametype == "ctf" || isbombmode()) {
      if(self.carrier touchingarbitraryuptrigger() && var_7[2] < 0) {
        var_22 = (0, 0, -180);

        if(isDefined(self.visualgroundoffset)) {
          var_19 = var_19 - self.visualgroundoffset * 2;
        }

        if(level.gametype == "ctf") {
          var_21 = -80;
        }

        if(isbombmode()) {
          var_21 = -30;
        }
      } else
        var_22 = (0, 0, 0);
    } else
      var_22 = vectortoangles(var_20);

    for(var_23 = 0; var_23 < self.visuals.size; var_23++) {
      self.visuals[var_23].origin = var_19;
      self.visuals[var_23].angles = var_22;
      self.visuals[var_23] show();
    }

    self.trigger.origin = var_19 + (0, 0, var_21);
    self.curorigin = self.trigger.origin;
    var_24 = undefined;

    if(!isplayer(var_13["entity"]) || !isbot(var_13["entity"]) || !isagent(var_13["entity"])) {
      var_24 = var_13["entity"];
    }

    if(isDefined(var_24) && isDefined(var_24.owner)) {
      var_25 = var_24 getlinkedparent();

      if(isDefined(var_25)) {
        var_24 = var_25;
      }
    }

    if(isDefined(var_24)) {
      if(isDefined(var_24.func_9B09) && var_24.func_9B09 == 1) {
        self.func_E25D = 1;
      } else {
        for(var_23 = 0; var_23 < self.visuals.size; var_23++) {
          self.visuals[var_23] linkto(var_24);
        }

        self.trigger linkto(var_24);
        var_26 = spawnStruct();
        var_26.carryobject = self;
        var_26.deathoverridecallback = ::carryobject_overridemovingplatformdeath;
        self.trigger thread scripts\mp\movers::handle_moving_platforms(var_26);
      }
    }

    if(!isDefined(var_00)) {
      thread func_CB49();
    }
  } else {
    for(var_23 = 0; var_23 < self.visuals.size; var_23++) {
      self.visuals[var_23].origin = self.visuals[var_23].baseorigin;
      self.visuals[var_23].angles = self.visuals[var_23].baseangle;
      self.visuals[var_23] show();
    }

    self.trigger.origin = self.trigger.baseorigin;
    self.curorigin = self.trigger.baseorigin;
  }

  if(isDefined(self.ondrop) && !isDefined(var_00)) {
    self[[self.ondrop]](var_16);
  }

  clearcarrier();
  updatecompassicons();
  func_12F68();
  self.isresetting = 0;
}

setcarrier(var_00) {
  self.carrier = var_00;
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
  wait 0.05;

  if(isDefined(self.func_E25D)) {
    self.func_E25D = undefined;
    returnobjectiveid();
    return;
  }

  for(var_00 = 0; var_00 < level.radtriggers.size; var_0++) {
    if(!self.visuals[0] istouching(level.radtriggers[var_00])) {
      continue;
    }
    returnobjectiveid();
    return;
  }

  for(var_00 = 0; var_00 < level.minetriggers.size; var_0++) {
    if(!self.visuals[0] istouching(level.minetriggers[var_00])) {
      continue;
    }
    returnobjectiveid();
    return;
  }

  for(var_00 = 0; var_00 < level.hurttriggers.size; var_0++) {
    if(!self.visuals[0] istouching(level.hurttriggers[var_00])) {
      continue;
    }
    returnobjectiveid();
    return;
  }

  if(scripts\mp\utility\game::istrue(level.ballallowedtriggers.size)) {
    self.allowedintrigger = 0;

    foreach(var_02 in level.ballallowedtriggers) {
      if(self.visuals[0] istouching(var_02)) {
        self.allowedintrigger = 1;
        break;
      }
    }
  }

  foreach(var_02 in level.func_C7B3) {
    if(scripts\mp\utility\game::istrue(self.allowedintrigger)) {
      break;
    }
    if(!self.visuals[0] istouching(var_02)) {
      continue;
    }
    returnobjectiveid();
    return;
  }

  if(isDefined(self.func_2667)) {
    wait(self.func_2667);

    if(!isDefined(self.carrier)) {
      returnobjectiveid();
    }
  }
}

takeobject(var_00) {
  if(isDefined(self.carryicon)) {
    self.carryicon scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self)) {
    self.carryobject = undefined;
  }

  self notify("drop_object");

  if(var_0.triggertype == "proximity") {
    thread func_CB44(var_00);
  }

  if(scripts\mp\utility\game::isreallyalive(self) && !var_0.allowweapons) {
    if(isDefined(var_0.carryweapon)) {
      var_01 = isDefined(var_0.keepcarryweapon) && var_0.keepcarryweapon;

      if(!var_0.carrierhascarryweaponinloadout && !var_01) {
        if(isDefined(var_0.ballindex)) {
          wait 0.25;
        }

        self notify("clear_carrier");

        if(scripts\mp\utility\game::isreliablyswitchingtoweapon(var_0.carryweapon)) {
          scripts\mp\utility\game::func_1529(var_0.carryweapon);
        } else {
          scripts\mp\utility\game::_takeweapon(var_0.carryweapon);
        }

        var_02 = var_0.lastdroppableweaponobj;
        thread scripts\mp\utility\game::func_72ED(var_02);
      } else {}

      self _meth_80DB();
      scripts\engine\utility::allow_weapon_switch(1);
    } else if(!var_0.allowweapons)
      scripts\engine\utility::allow_weapon(1);
  }
}

trackcarrier() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  while(isDefined(self.carryobject) && scripts\mp\utility\game::isreallyalive(self)) {
    if(self isonground()) {
      var_00 = bulletTrace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);

      if(var_0["fraction"] < 1) {
        self.carryobject.safeorigin = var_0["position"];
      }
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
    while(self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed()) {
      wait 0.05;
    }

    while(!self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() || self meleebuttonpressed()) {
      wait 0.05;
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

createuseobject(var_00, var_01, var_02, var_03) {
  var_04 = spawnStruct();
  var_4.type = "useObject";
  var_4.curorigin = var_1.origin;
  var_4.ownerteam = var_00;
  var_4.entnum = var_01 getentitynumber();
  var_4.keyobject = undefined;

  if(issubstr(var_1.classname, "use")) {
    var_4.triggertype = "use";
  } else {
    var_4.triggertype = "proximity";
  }

  var_4.trigger = var_01;

  for(var_05 = 0; var_05 < var_2.size; var_5++) {
    var_2[var_05].baseorigin = var_2[var_05].origin;
    var_2[var_05].baseangle = var_2[var_05].angles;
  }

  var_4.visuals = var_02;

  if(!isDefined(var_03)) {
    var_03 = (0, 0, 0);
  }

  var_4.offset3d = var_03;
  var_4.func_4465 = [];

  foreach(var_07 in level.teamnamelist) {
    var_4.teamobjids[var_07] = ::scripts\mp\objidpoolmanager::requestminimapid(99);

    if(var_4.teamobjids[var_07] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_4.teamobjids[var_07], "invisible", var_4.curorigin);
      scripts\mp\objidpoolmanager::minimap_objective_team(var_4.teamobjids[var_07], var_07);
    }

    var_4.objpoints[var_07] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_07 + "_" + var_4.entnum, var_4.curorigin + var_03, var_07, undefined);
    var_4.objpoints[var_07].alpha = 0;

    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_08 = "mlg_" + var_07;
      var_4.objpoints[var_08] = ::scripts\mp\objpoints::func_4A23("objpoint_" + var_08 + "_" + var_4.entnum, var_4.curorigin + var_03, var_07, undefined);
      var_4.objpoints[var_08].alpha = 0;
    }
  }

  var_4.interactteam = "none";
  var_4.func_13DCA = [];
  var_4.visibleteam = "none";
  var_4.onuse = undefined;
  var_4.oncantuse = undefined;
  var_4.func_130EB = "default";
  var_4.usetime = 10000;
  var_4.curprogress = 0;
  var_4.stalemate = 0;
  var_4.wasstalemate = 0;
  var_4.func_115DF = [];
  var_4.func_115DF["none"] = 0;
  var_4.func_115DF["allies"] = 0;
  var_4.func_115DF["axis"] = 0;

  if(var_4.triggertype == "proximity") {
    var_4.teamusetimes = [];
    var_4.teamusetexts = [];
    var_4.func_C248["neutral"] = 0;
    var_4.touchlist["neutral"] = [];
    var_4.func_C248["none"] = 0;
    var_4.touchlist["none"] = [];

    foreach(var_11 in level.teamnamelist) {
      var_4.func_C248[var_11] = 0;
      var_4.touchlist[var_11] = [];
    }

    var_4.userate = 0;
    var_4.claimteam = "none";
    var_4.func_3FF8 = undefined;
    var_4.func_A95A = "none";
    var_4.func_A95B = 0;
    var_4.mustmaintainclaim = 0;
    var_4.cancontestclaim = 0;
    var_04 thread func_130B0();
  } else {
    var_4.userate = 1;
    var_04 thread func_130B1();
  }

  return var_04;
}

setkeyobject(var_00) {
  self.keyobject = var_00;
}

func_130B1() {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
    self.trigger waittill("trigger", var_00);

    if(!scripts\mp\utility\game::isreallyalive(var_00)) {
      continue;
    }
    if(!caninteractwith(var_0.pers["team"])) {
      continue;
    }
    if(!var_00 isonground()) {
      continue;
    }
    if(!var_00 scripts\mp\utility\game::isjuggernaut() && scripts\mp\utility\game::iskillstreakweapon(var_00 getcurrentweapon())) {
      continue;
    }
    if(isDefined(self.func_13056)) {
      if(!self[[self.func_13056]](var_00)) {
        continue;
      }
    }

    if(isDefined(self.keyobject) && (!isDefined(var_0.carryobject) || var_0.carryobject != self.keyobject)) {
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

      var_02 = var_0.pers["team"];
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

func_3E22(var_00) {
  if(!isDefined(self.keyobject)) {
    return 1;
  }

  if(!isDefined(var_0.carryobject)) {
    return 0;
  }

  var_01 = self.keyobject;

  if(!isarray(var_01)) {
    var_01 = [var_01];
  }

  foreach(var_03 in var_01) {
    if(var_03 == var_0.carryobject) {
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

    if(!scripts\mp\utility\game::isreallyalive(var_00)) {
      continue;
    }
    if(!caninteractwith(var_0.pers["team"])) {
      continue;
    }
    if(isDefined(self.oncantuse)) {
      self[[self.oncantuse]](var_00);
    }
  }
}

getearliestclaimplayer() {
  var_00 = self.claimteam;

  if(scripts\mp\utility\game::isreallyalive(self.func_3FF8)) {
    var_01 = self.func_3FF8;
  } else {
    var_01 = undefined;
  }

  if(self.touchlist[var_00].size > 0) {
    var_02 = undefined;
    var_03 = getarraykeys(self.touchlist[var_00]);

    for(var_04 = 0; var_04 < var_3.size; var_4++) {
      var_05 = self.touchlist[var_00][var_3[var_04]];

      if(scripts\mp\utility\game::isreallyalive(var_5.player) && (!isDefined(var_02) || var_5.starttime < var_02)) {
        var_01 = var_5.player;
        var_02 = var_5.starttime;
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

        if(self.func_C248["allies"]) {
          var_00 = "allies";
        } else if(self.func_C248["axis"]) {
          var_00 = "axis";
        }

        if(var_00 == "none" && self.ownerteam != "neutral") {
          var_00 = self.ownerteam;
        }

        if(isDefined(self.onuncontested)) {
          self[[self.onuncontested]](var_00);
        }

        setclaimteam("none");
        self.func_3FF8 = undefined;
      }

      self.wasstalemate = self.stalemate;
    } else if(self.mustmaintainclaim && self.ownerteam != "neutral" && !self.func_C248[self.ownerteam]) {
      if(isDefined(self.onunoccupied)) {
        self[[self.onunoccupied]]();
      }

      setclaimteam("none");
      self.func_3FF8 = undefined;
    }

    if(self.claimteam != "none") {
      if(!self.usetime) {
        if(!self.stalemate) {
          var_01 = getearliestclaimplayer();

          if(isDefined(self.onuse)) {
            self[[self.onuse]](self.func_3FF8);
          }

          setclaimteam("none");
          self.func_3FF8 = undefined;
        }
      } else if(self.usetime && self.func_115DF[self.claimteam] >= self.usetime) {
        self.curprogress = 0.0;
        self.func_115DF[self.claimteam] = self.curprogress;
        var_01 = getearliestclaimplayer();

        if(isDefined(self.onenduse)) {
          self[[self.onenduse]](self.claimteam, var_01, isDefined(var_01));
        }

        if(isDefined(var_01) && isDefined(self.onuse)) {
          self[[self.onuse]](var_01);
        }

        setclaimteam("none");
        self.func_3FF8 = undefined;
      } else if(!self.stalemate && self.usetime && self.ownerteam != self.claimteam) {
        if(!self.func_C248[self.claimteam]) {
          if(isDefined(self.onenduse)) {
            self[[self.onenduse]](self.claimteam, self.func_3FF8, 0);
          }

          setclaimteam("none");
          self.func_3FF8 = undefined;
        } else {
          self.curprogress = self.curprogress + 50 * self.userate;
          self.func_115DF[self.claimteam] = self.curprogress;

          if(self.ownerteam != level.otherteam[self.claimteam]) {
            self.func_115DF[level.otherteam[self.claimteam]] = 0;
          }

          if(isDefined(self.onuseupdate)) {
            self[[self.onuseupdate]](self.claimteam, self.func_115DF[self.claimteam] / self.usetime, 50 * self.userate / self.usetime, self.func_3FF8);
          }
        }
      }
    }

    wait 0.05;
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

useobjectdecay(var_00) {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
    wait 0.1;

    if(self.ownerteam != "neutral") {
      if(self.func_C248[self.ownerteam] >= 1 && !self.stalemate) {
        self.curprogress = 0;
        self.func_115DF[self.claimteam] = self.curprogress;
        break;
      }
    }

    if(self.claimteam == "none") {
      if(self.usetime) {
        wait 0.1;

        if(self.claimteam == "none" && !self.stalemate) {
          self.curprogress = self.curprogress - 50;
        }

        self.func_115DF[self.func_A95A] = self.curprogress;
      }

      if(self.func_115DF[self.func_A95A] <= 0) {
        self.curprogress = 0;
        self.func_115DF[self.func_A95A] = self.curprogress;
        break;
      }
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

func_3895(var_00) {
  if(isDefined(self.carrier)) {
    return 0;
  }

  if(self.cancontestclaim) {
    var_01 = animscriptedthirdperson(var_0.pers["team"]);

    if(var_01 != 0) {
      return 0;
    }
  }

  if(func_3E22(var_00)) {
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

    if(!scripts\mp\utility\game::isreallyalive(var_01)) {
      continue;
    }
    if(isagent(var_01)) {
      continue;
    }
    if(!scripts\mp\utility\game::isgameparticipant(var_01)) {
      continue;
    }
    if(isDefined(self.carrier)) {
      continue;
    }
    if(isDefined(var_1.spawningafterremotedeath)) {
      continue;
    }
    if(var_01 _meth_8568()) {
      continue;
    }
    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }
    if(!isDefined(var_1.func_987A)) {
      continue;
    }
    var_02 = getrelativeteam(var_1.pers["team"]);

    if(isDefined(self.teamusetimes[var_02]) && self.teamusetimes[var_02] < 0) {
      continue;
    }
    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_01)) {
      continue;
    }
    if(self.claimteam == "none" && caninteractwith(var_1.pers["team"], var_01)) {
      if(func_3895(var_01)) {
        if(!func_DAD1(var_01)) {
          continue;
        }
        setclaimteam(var_1.pers["team"]);
        self.func_3FF8 = var_01;

        if(isDefined(self.teamusetimes[var_02])) {
          self.usetime = self.teamusetimes[var_02];
        }

        if(self.usetime && isDefined(self.onbeginuse)) {
          self[[self.onbeginuse]](self.func_3FF8);
        }
      } else if(isDefined(self.oncantuse))
        self[[self.oncantuse]](var_01);
    }

    if(scripts\mp\utility\game::isreallyalive(var_01) && !isDefined(var_1.touchtriggers[var_00])) {
      var_01 thread func_127CA(self);
    }
  }
}

func_DAD1(var_00) {
  if(!isDefined(self.requireslos)) {
    return 1;
  }

  var_01 = var_00 getEye();
  var_02 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  var_03 = [];

  if(level.gametype == "tdef" || scripts\mp\utility\game::istrue(level.devball)) {
    var_04 = self.trigger.origin + (0, 0, 16);
    var_05 = 0;
    var_3[0] = self.visuals[0];
  } else if(level.gametype == "ball") {
    var_04 = self.trigger.origin + (0, 0, 8);
    var_05 = 0;
    var_3[0] = self.visuals[0];
  } else {
    var_04 = self.trigger.origin + (0, 0, 32);
    var_05 = 1;
    var_3[0] = self.visuals;
  }

  var_3[1] = self.carrier;
  var_06 = scripts\engine\trace::ray_trace(var_01, var_04, var_03, var_02, 0);

  if(var_6["fraction"] != 1 && var_05) {
    var_04 = self.trigger.origin + (0, 0, 16);
    var_06 = scripts\engine\trace::ray_trace(var_01, var_04, var_03, var_02, 0);
  }

  if(var_6["fraction"] != 1) {
    var_04 = self.trigger.origin + (0, 0, 0);
    var_06 = scripts\engine\trace::ray_trace(var_01, var_04, var_03, var_02, 0);
  }

  return var_6["fraction"] == 1;
}

setclaimteam(var_00) {
  if(!isDefined(self.claimgracetime)) {
    self.claimgracetime = 1000;
  }

  if(self.claimteam == "none" && gettime() - self.func_A95B > self.claimgracetime) {
    self.curprogress = 0;
    self.func_115DF[var_00] = self.curprogress;
  } else if(var_00 != "none" && var_00 != self.func_A95A) {
    self.curprogress = 0;
    self.func_115DF[var_00] = self.curprogress;
  }

  self.func_A95A = self.claimteam;
  self.func_A95B = gettime();
  self.claimteam = var_00;
  func_12F57();
}

func_7E29() {
  return self.claimteam;
}

func_127CA(var_00) {
  var_01 = self.pers["team"];
  var_0.func_C248[var_01]++;
  var_02 = self.guid;
  var_03 = spawnStruct();
  var_3.player = self;
  var_3.starttime = gettime();
  var_0.touchlist[var_01][var_02] = var_03;

  if(!isDefined(var_0.nousebar)) {
    var_0.nousebar = 0;
  }

  self.touchtriggers[var_0.entnum] = var_0.trigger;
  var_00 func_12F57();

  while(scripts\mp\utility\game::isreallyalive(self) && isDefined(var_0.trigger) && self istouching(var_0.trigger) && !level.gameended) {
    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_00)) {
      break;
    }
    if(isplayer(self) && var_0.usetime > 50) {
      updateuiprogress(var_00, 1);
    }

    wait 0.05;
  }

  if(isDefined(self)) {
    if(var_0.usetime > 50) {
      if(isplayer(self)) {
        updateuiprogress(var_00, 0);
      }

      self.touchtriggers[var_0.entnum] = undefined;
    } else
      self.touchtriggers[var_0.entnum] = undefined;
  }

  if(level.gameended) {
    return;
  }
  var_0.func_C405 = var_0.touchlist;
  var_0.touchlist[var_01][var_02] = undefined;
  var_0.func_C248[var_01]--;
  var_00 func_12F57();
}

migrationcapturereset(var_00) {
  var_0.migrationcapturereset = 1;
  level waittill("host_migration_begin");

  if(!isDefined(var_00) || !isDefined(self)) {
    return;
  }
  var_00 setclientomnvar("ui_securing", 0);
  var_00 setclientomnvar("ui_securing_progress", 0);
  self.migrationcapturereset = undefined;
}

animscriptedthirdperson(var_00) {
  return self.func_C248[scripts\mp\utility\game::getotherteam(var_00)];
}

updateuiprogress(var_00, var_01) {
  if(!isDefined(level.hostmigrationtimer)) {
    var_02 = 0;

    if(isDefined(var_0.func_115DF) && isDefined(var_0.claimteam)) {
      if(var_0.func_115DF[var_0.claimteam] > var_0.usetime) {
        var_0.func_115DF[var_0.claimteam] = var_0.usetime;
      }

      var_02 = var_0.func_115DF[var_0.claimteam] / var_0.usetime;
    } else {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }

      var_02 = var_0.curprogress / var_0.usetime;
    }

    if(level.gametype == "ctf" && !isDefined(var_0.id)) {
      if(var_01 && scripts\mp\utility\game::istrue(var_0.stalemate)) {
        if(!isDefined(self.func_12B1C)) {
          if(!isDefined(self.func_12B1B)) {
            self.func_12B1B = 1;
          }

          self setclientomnvar("ui_objective_state", -1);
          self.func_12B1C = 1;
        }

        var_02 = 0.01;
      } else if(var_01 && isDefined(self.func_12B1B) && isDefined(var_0.stalemate) && !var_0.stalemate && var_0.ownerteam != self.team) {
        self setclientomnvar("ui_objective_state", 1);
        self.func_12B1B = 1;
        self.func_12B1C = undefined;
      } else if(var_01 && isDefined(self.func_12B1B) && isDefined(var_0.stalemate) && !var_0.stalemate && var_0.ownerteam == self.team) {
        self setclientomnvar("ui_objective_state", 2);
        self.func_12B1B = 1;
        self.func_12B1C = undefined;
      } else {
        if(!var_01 && isDefined(self.func_12B1C)) {
          self setclientomnvar("ui_objective_state", 0);
          self.func_12B1B = undefined;
        }

        if(var_01 && !isDefined(self.func_12B1C) && var_0.ownerteam == self.team) {
          self setclientomnvar("ui_objective_state", 0);
          self.func_12B1B = undefined;
        }

        if(var_01 && !isDefined(self.func_12B1B)) {
          if(var_0.ownerteam != self.team) {
            self setclientomnvar("ui_objective_state", 1);
            self.func_12B1B = 1;
          } else if(var_0.interactteam == "any") {
            self setclientomnvar("ui_objective_state", 2);
            self.func_12B1B = 1;
          }
        }

        self.func_12B1C = undefined;
      }

      if(!var_01) {
        var_02 = 0.01;
        self setclientomnvar("ui_objective_state", 0);
        self.func_12B1B = undefined;
      }

      if(var_02 != 0) {
        if(isDefined(var_0.func_115DF) && isDefined(var_0.claimteam) && var_01) {
          self setclientomnvar("ui_objective_progress", var_0.func_115DF[self.team] / var_0.usetime);
        } else {
          self setclientomnvar("ui_objective_progress", var_02);
        }
      }
    }

    if(func_8BE7() && isDefined(var_0.id) && (var_0.id == "domFlag" || var_0.id == "hardpoint")) {
      var_03 = 0;

      if(level.gametype == "koth" || level.gametype == "grnd") {
        var_03 = 7;

        if(scripts\mp\utility\game::istrue(level.usehqrules) && isDefined(var_0.ownerteam) && var_0.ownerteam != "neutral") {
          var_03 = 8;
        }
      } else {
        if(var_0.label == "_a") {
          var_03 = 1;
        } else if(var_0.label == "_b") {
          var_03 = 2;
        } else if(var_0.label == "_c") {
          var_03 = 3;
        }

        if(scripts\mp\utility\game::istrue(var_0.neutralizing)) {
          var_03 = var_03 + 3;
        }
      }

      if(var_01 && isDefined(var_0.stalemate) && var_0.stalemate) {
        if(!isDefined(self.ui_dom_stalemate)) {
          if(!isDefined(self.ui_dom_securing)) {
            self.ui_dom_securing = 1;
          }

          self setclientomnvar("ui_objective_state", -1);
          self.ui_dom_stalemate = 1;
        }

        var_02 = 0.01;
      } else if(var_01 && isDefined(self.ui_dom_securing) && isDefined(var_0.stalemate) && !var_0.stalemate && var_0.ownerteam != self.team) {
        self setclientomnvar("ui_objective_state", var_03);
        self.ui_dom_securing = 1;
        self.ui_dom_stalemate = undefined;
      } else {
        if(!var_01 && isDefined(self.ui_dom_stalemate)) {
          self setclientomnvar("ui_objective_state", 0);
          self.ui_dom_securing = undefined;
        }

        if(var_01 && !isDefined(self.ui_dom_stalemate) && var_0.ownerteam == self.team) {
          self setclientomnvar("ui_objective_state", 0);
          self.ui_dom_securing = undefined;
        }

        if(var_01 && !isDefined(self.ui_dom_securing) && var_0.ownerteam != self.team) {
          self setclientomnvar("ui_objective_state", var_03);
          self.ui_dom_securing = 1;
        }

        self.ui_dom_stalemate = undefined;
      }

      if(!var_01 || !var_00 caninteractwith(self.team) && (!isDefined(var_0.stalemate) || isDefined(var_0.stalemate) && !var_0.stalemate)) {
        var_02 = 0.01;
        self setclientomnvar("ui_objective_state", 0);
        self.ui_dom_securing = undefined;
      }

      if(var_02 != 0) {
        if(isDefined(var_0.func_115DF) && isDefined(var_0.claimteam) && var_01) {
          self setclientomnvar("ui_objective_progress", var_0.func_115DF[self.team] / var_0.usetime);
          return;
        }

        self setclientomnvar("ui_objective_progress", var_02);
        return;
        return;
      }
    } else if(isbombmode() && isDefined(var_0.id) && (var_0.id == "bomb_zone" || var_0.id == "defuse_object")) {
      if(isDefined(self)) {
        if(var_01 && isDefined(self)) {
          if(!isDefined(self.ui_bomb_planting_defusing)) {
            var_04 = 0;

            if(var_0.id == "bomb_zone") {
              var_04 = 1;
            } else if(var_0.id == "defuse_object") {
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
          if(isDefined(var_0.func_115DF) && isDefined(var_0.claimteam) && var_01) {
            self setclientomnvar("ui_objective_progress", var_0.func_115DF[self.team] / var_0.usetime);
          } else {
            self setclientomnvar("ui_objective_progress", var_02);
          }
        }
      }
    } else if(isDefined(var_0.id)) {
      var_04 = 0;

      switch (var_0.id) {
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

      func_12F55(var_02, var_01, var_04, var_00, var_0.usetime);
    }
  }
}

func_8BE7() {
  if(level.gametype == "dom" || level.gametype == "grind" || level.gametype == "koth" || level.gametype == "grnd" || level.gametype == "siege") {
    return 1;
  }

  return 0;
}

func_12F55(var_00, var_01, var_02, var_03, var_04) {
  if(var_01) {
    if(!isDefined(var_3.usedby)) {
      var_3.usedby = [];
    }

    if(!isDefined(self.migrationcapturereset)) {
      var_03 thread migrationcapturereset(self);
    }

    if(!existinarray(self, var_3.usedby)) {
      var_3.usedby[var_3.usedby.size] = self;
    }

    if(!isDefined(self.ui_securing)) {
      self setclientomnvar("ui_securing", var_02);
      self.ui_securing = 1;
    }
  } else {
    if(isDefined(var_3.usedby) && existinarray(self, var_3.usedby)) {
      var_3.usedby = scripts\engine\utility::array_remove(var_3.usedby, self);
    }

    self setclientomnvar("ui_securing", 0);
    self.ui_securing = undefined;
    var_00 = 0.01;
  }

  if(var_04 == 500) {
    var_00 = min(var_00 + 0.15, 1);
  }

  if(var_00 != 0) {
    self setclientomnvar("ui_securing_progress", var_00);
  }
}

existinarray(var_00, var_01) {
  if(var_1.size > 0) {
    foreach(var_03 in var_01) {
      if(var_03 == var_00) {
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

  var_01 = self.func_C248[var_00];
  var_02 = 0;
  var_03 = 0;

  if(level.multiteambased) {
    foreach(var_05 in level.teamnamelist) {
      if(var_00 != var_05) {
        var_02 = var_02 + self.func_C248[var_05];
      }
    }
  } else {
    if(var_00 != "axis") {
      var_02 = var_02 + self.func_C248["axis"];
    }

    if(var_00 != "allies") {
      var_02 = var_02 + self.func_C248["allies"];
    }
  }

  foreach(var_08 in self.touchlist[var_00]) {
    if(!isDefined(var_8.player)) {
      continue;
    }
    if(var_8.player.pers["team"] != var_00) {
      continue;
    }
    if(var_8.player.objectivescaler == 1) {
      continue;
    }
    var_01 = var_01 * var_8.player.objectivescaler;
    var_03 = var_8.player.objectivescaler;
  }

  self.stalemate = var_01 && var_02;
  self.userate = 0;

  if(var_01 && !var_02) {
    self.userate = min(var_01, 4);
  }

  if(isDefined(self.func_9D49) && self.func_9D49 && var_03 != 0) {
    self.userate = 1 * var_03;
  } else if(isDefined(self.func_9D49) && self.func_9D49) {
    self.userate = 1;
  }
}

useholdthink(var_00) {
  var_00 notify("use_hold");

  if(isplayer(var_00)) {
    var_00 getweaponvariantattachments(self.trigger);
  } else {
    var_00 linkto(self.trigger);
  }

  var_00 getweaponrootname();
  var_00 _meth_8082(self.trigger);
  var_0.func_3FFA = self.trigger;
  var_00 goal_head_icon(0);
  var_00 unlink();

  if(isbombmode()) {
    if(scripts\mp\utility\game::isanymlgmatch() || scripts\mp\utility\game::istrue(level.silentplant) || var_00 scripts\mp\utility\game::_hasperk("specialty_engineer")) {
      self.useweapon = "briefcase_bomb_defuse_mp";
    } else {
      self.useweapon = "briefcase_bomb_mp";
    }
  }

  var_01 = self.useweapon;
  var_02 = var_00 getcurrentweapon();

  if(isDefined(var_01)) {
    if(var_02 == var_01) {
      var_02 = var_0.func_A9C6;
    }

    var_0.func_A9C6 = var_02;
    var_00 scripts\mp\utility\game::_giveweapon(var_01);
    var_00 setweaponammostock(var_01, 0);
    var_00 setweaponammoclip(var_01, 0);
    var_00 thread func_11382(var_01);
  } else
    var_00 scripts\engine\utility::allow_weapon(0);

  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  var_03 = useholdthinkloop(var_00, var_02);

  if(isDefined(var_00)) {
    var_00 detachusemodels();
    var_00 notify("done_using");
  }

  if(isDefined(var_01) && isDefined(var_00)) {
    var_00 scripts\mp\supers::unstowsuperweapon();

    if(var_00 scripts\mp\utility\game::isreliablyswitchingtoweapon(var_01)) {
      var_00 scripts\mp\utility\game::func_1529(var_01);
    } else {
      var_00 thread scripts\mp\utility\game::forcethirdpersonwhenfollowing(var_01);
    }
  }

  if(isDefined(var_03) && var_03) {
    var_00 goal_head_icon(1);
    return 1;
  }

  if(isDefined(var_00)) {
    var_0.func_3FFA = undefined;

    if(!isDefined(var_01)) {
      var_00 scripts\engine\utility::allow_weapon(1);
    }

    if(!scripts\mp\utility\game::isreallyalive(var_00)) {
      var_0.func_A64F = 1;
    }

    var_00 goal_head_icon(1);
  }

  self.inuse = 0;
  self.trigger geyser_sequence();
  return 0;
}

detachusemodels() {
  if(isDefined(self.attachedusemodel)) {
    self detach(self.attachedusemodel, "tag_inhand");
    self.attachedusemodel = undefined;
  }
}

func_11382(var_00) {
  scripts\mp\supers::allowsuperweaponstow();
  var_01 = scripts\mp\utility\game::func_11383(var_00, 1);

  if(!scripts\engine\utility::is_true(var_01)) {
    scripts\mp\supers::unstowsuperweapon();

    if(scripts\mp\utility\game::isreliablyswitchingtoweapon(var_00)) {
      scripts\mp\utility\game::func_1529(var_00);
    } else {
      scripts\mp\utility\game::_takeweapon(var_00);
    }
  }
}

func_130E9(var_00, var_01, var_02, var_03) {
  if(!scripts\mp\utility\game::isreallyalive(var_00)) {
    return 0;
  }

  if(!var_00 istouching(self.trigger)) {
    return 0;
  }

  if(!var_00 usebuttonpressed()) {
    return 0;
  }

  if(var_00 scripts\mp\utility\game::_meth_85C7()) {
    return 0;
  }

  if(var_00 meleebuttonpressed()) {
    return 0;
  }

  if(self.curprogress >= self.usetime) {
    return 0;
  }

  if(!self.userate && !var_01) {
    return 0;
  }

  if(var_01 && var_02 > var_03) {
    return 0;
  }

  if(isDefined(self.useweapon)) {
    if(var_00 getcurrentweapon() != self.useweapon && !var_00 scripts\mp\utility\game::isreliablyswitchingtoweapon(self.useweapon)) {
      return 0;
    }
  }

  return 1;
}

useholdthinkloop(var_00, var_01) {
  level endon("game_ended");
  self endon("disabled");
  var_02 = self.useweapon;
  var_03 = 1;

  if(isDefined(self.func_136F6)) {
    var_03 = self.func_136F6;
  }

  if(!var_03) {
    self.userate = 1 * var_0.objectivescaler;
  }

  var_04 = 0;
  var_05 = 1.5;

  while(func_130E9(var_00, var_03, var_04, var_05)) {
    var_04 = var_04 + 0.05;

    if(!var_03 || !isDefined(var_02) || var_00 getcurrentweapon() == var_02) {
      self.curprogress = self.curprogress + 50 * self.userate;
      self.userate = 1 * var_0.objectivescaler;
      var_03 = 0;
    } else
      self.userate = 0;

    var_00 updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      self.inuse = 0;
      var_00 getplayertraceheight(self.trigger);
      var_0.func_3FFA = undefined;

      if(!isDefined(var_02)) {
        var_00 scripts\engine\utility::allow_weapon(1);
      }

      var_00 unlink();
      return scripts\mp\utility\game::isreallyalive(var_00);
    }

    wait 0.05;
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }

  var_00 updateuiprogress(self, 0);
  return 0;
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

func_12F68() {
  if(self.visibleteam == "any") {
    func_12F67("friendly", 1);
    func_12F67("enemy", 1);
  } else if(self.visibleteam == "friendly") {
    func_12F67("friendly", 1);
    func_12F67("enemy", 0);
  } else if(self.visibleteam == "enemy") {
    func_12F67("friendly", 0);
    func_12F67("enemy", 1);
  } else {
    func_12F67("friendly", 0);
    func_12F67("enemy", 0);
  }
}

getmlgteamcolor(var_00) {
  if(var_00 == "allies") {
    return game["colors"]["friendly"];
  } else if(var_00 == "axis") {
    return game["colors"]["enemy"];
  }

  return (1, 1, 1);
}

setobjpointteamcolor(var_00, var_01, var_02) {
  if(var_01 == "mlg_allies") {
    var_00 setmlgdraw(1, 0);
    var_03 = self.worldiconscolor[var_02];

    if(var_03 == "friendly") {
      var_0.color = getmlgteamcolor("allies");
      return;
    }

    if(var_03 == "enemy") {
      var_0.color = getmlgteamcolor("axis");
      return;
    }

    var_0.color = game["colors"][var_03];
    return;
    return;
  } else if(var_01 == "mlg_axis") {
    var_00 setmlgdraw(1, 0);
    var_03 = self.worldiconscolor[var_02];

    if(var_03 == "friendly") {
      var_0.color = getmlgteamcolor("axis");
      return;
    }

    if(var_03 == "enemy") {
      var_0.color = getmlgteamcolor("allies");
      return;
    }

    var_0.color = game["colors"][var_03];
    return;
    return;
  } else {
    var_0.color = game["colors"][self.worldiconscolor[var_02]];
    var_00 setmlgdraw(0, 1);
  }
}

func_12F67(var_00, var_01) {
  if(!isDefined(self.func_13DCA[var_00])) {
    var_01 = 0;
  }

  var_02 = makefakeai(var_00);

  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    var_03 = var_2.size;

    for(var_04 = 0; var_04 < var_03; var_4++) {
      if(var_2[var_04] == "allies") {
        var_2[var_2.size] = "mlg_allies";
        continue;
      }

      if(var_2[var_04] == "axis") {
        var_2[var_2.size] = "mlg_axis";
      }
    }
  }

  for(var_04 = 0; var_04 < var_2.size; var_4++) {
    var_05 = "objpoint_" + var_2[var_04] + "_" + self.entnum;
    var_06 = scripts\mp\objpoints::getobjpointbyname(var_05);

    if(!isDefined(var_06)) {
      continue;
    }
    var_06 notify("stop_flashing_thread");
    var_06 thread scripts\mp\objpoints::stopflashing();

    if(var_01) {
      var_06 setshader(self.func_13DCA[var_00], level.objpointsize, level.objpointsize);
      var_06 fadeovertime(0.05);
      var_6.alpha = var_6.basealpha;
      var_6.func_9F51 = 1;

      if(level.gametype == "dom") {
        var_06 setwaypoint(0, 1);
      } else if(isDefined(self.func_4465[var_00])) {
        var_06 setwaypoint(1, 1);
      } else {
        var_06 setwaypoint(1, 0);
      }

      setobjpointteamcolor(var_06, var_2[var_04], var_00);
      var_06 _meth_85A8(getwaypointbackgroundtype(self.func_13DCA[var_00]));

      if(self.type == "carryObject") {
        var_07 = var_2[var_04] == "mlg_allies" || var_2[var_04] == "mlg_axis";

        if(isDefined(self.carrier) && (!shouldpingobject(var_00) || var_07)) {
          var_06 settargetent(self.carrier);
        } else if(!isDefined(self.carrier) && isDefined(self.objectiveonvisuals) && self.objectiveonvisuals) {
          var_06 settargetent(self.visuals[0]);
        } else {
          var_06 getplayersinradiusview();
        }
      } else if(isDefined(self.func_C2B4))
        var_06 settargetent(self.func_C2B4);
    } else {
      var_06 fadeovertime(0.05);
      var_6.alpha = 0;
      var_6.func_9F51 = 0;
      var_06 getplayersinradiusview();
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

func_12F43(var_00, var_01) {}

updatecompassicons() {
  if(self.visibleteam == "any") {
    func_12E7A("friendly", 1);
    func_12E7A("enemy", 1);
  } else if(self.visibleteam == "friendly") {
    func_12E7A("friendly", 1);
    func_12E7A("enemy", 0);
  } else if(self.visibleteam == "enemy") {
    func_12E7A("friendly", 0);
    func_12E7A("enemy", 1);
  } else {
    func_12E7A("friendly", 0);
    func_12E7A("enemy", 0);
  }
}

updateobjectiveiconcolortype(var_00, var_01) {
  var_02 = self.worldiconscolor[var_01];

  if(!isDefined(var_02)) {
    scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(var_00, 0);
  } else if(var_02 == "friendly") {
    scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(var_00, 1);
  } else if(var_02 == "enemy") {
    scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(var_00, 2);
  } else {
    if(var_02 == "contest") {
      scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(var_00, 3);
      return;
    }

    scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(var_00, 0);
  }
}

func_12E7A(var_00, var_01) {
  var_02 = makefakeai(var_00);

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    var_04 = var_2[var_03];
    var_05 = var_01;

    if(!var_05 && shouldshowcompassduetoradar(var_04)) {
      var_05 = 1;
    }

    var_06 = self.teamobjids[var_04];

    if(var_06 != -1) {
      if(!isDefined(self.func_4465[var_00]) || !var_05) {
        scripts\mp\objidpoolmanager::minimap_objective_state(var_06, "invisible");
        continue;
      }

      scripts\mp\objidpoolmanager::minimap_objective_icon(var_06, self.func_4465[var_00]);
      scripts\mp\objidpoolmanager::minimap_objective_state(var_06, "active");
      scripts\mp\objidpoolmanager::minimap_objective_icon_backgroundtype(var_06, getwaypointbackgroundtype(self.func_4465[var_00]));
      updateobjectiveiconcolortype(var_06, var_00);

      if(self.type == "carryObject") {
        if(scripts\mp\utility\game::isreallyalive(self.carrier) && !shouldpingobject(var_00)) {
          scripts\mp\objidpoolmanager::minimap_objective_onentity(var_06, self.carrier);
        } else if(isDefined(self.visuals) && isDefined(self.visuals[0]) && isDefined(self.visuals[0] getlinkedparent())) {
          scripts\mp\objidpoolmanager::minimap_objective_onentity(var_06, self.visuals[0]);
        } else if(isDefined(self.objectiveonvisuals) && self.objectiveonvisuals && !shouldpingobject(var_00)) {
          scripts\mp\objidpoolmanager::minimap_objective_onentity(var_06, self.visuals[0]);
        } else {
          scripts\mp\objidpoolmanager::minimap_objective_position(var_06, self.curorigin);
        }

        continue;
      }

      if(isDefined(self.func_C2B4)) {
        scripts\mp\objidpoolmanager::minimap_objective_onentity(var_06, self.func_C2B4);
      }
    }
  }
}

shouldpingobject(var_00) {
  if(var_00 == "friendly" && self.objidpingenemy) {
    return 1;
  } else if(var_00 == "enemy" && self.objidpingfriendly) {
    return 1;
  }

  return 0;
}

makefakeai(var_00) {
  var_01 = [];

  foreach(var_03 in level.teamnamelist) {
    if(var_00 == "friendly") {
      if(isfriendlyteam(var_03)) {
        var_1[var_1.size] = var_03;
      }

      continue;
    }

    if(var_00 == "enemy") {
      if(!isfriendlyteam(var_03)) {
        var_1[var_1.size] = var_03;
      }
    }
  }

  return var_01;
}

shouldshowcompassduetoradar(var_00) {
  if(!isDefined(self.carrier)) {
    return 0;
  }

  if(self.carrier scripts\mp\utility\game::_hasperk("specialty_gpsjammer")) {
    return 0;
  }

  return getteamradar(var_00);
}

updatevisibilityaccordingtoradar() {
  self endon("death");
  self endon("carrier_cleared");

  for(;;) {
    level waittill("radar_status_change");
    updatecompassicons();
  }
}

setownerteam(var_00) {
  self.ownerteam = var_00;
  updatetrigger();
  updatecompassicons();
  func_12F68();

  if(var_00 != "neutral") {
    self.prevownerteam = var_00;
  }
}

getownerteam() {
  return self.ownerteam;
}

setusetime(var_00) {
  self.usetime = int(var_00 * 1000);
}

setwaitweaponchangeonuse(var_00) {
  self.func_136F6 = var_00;
}

setusetext(var_00) {
  self.func_130EB = var_00;
}

setteamusetime(var_00, var_01) {
  self.teamusetimes[var_00] = int(var_01 * 1000);
}

setteamusetext(var_00, var_01) {
  self.teamusetexts[var_00] = var_01;
}

setusehinttext(var_00) {
  self.trigger sethintstring(var_00);
}

allowcarry(var_00) {
  self.interactteam = var_00;
}

allowuse(var_00) {
  self.interactteam = var_00;
  updatetrigger();
}

setvisibleteam(var_00) {
  self.visibleteam = var_00;
  updatecompassicons();
  func_12F68();
}

setmodelvisibility(var_00) {
  if(var_00) {
    for(var_01 = 0; var_01 < self.visuals.size; var_1++) {
      self.visuals[var_01] show();

      if(self.visuals[var_01].classname == "script_brushmodel" || self.visuals[var_01].classname == "script_model") {
        foreach(var_03 in level.players) {
          if(var_03 istouching(self.visuals[var_01])) {
            var_03 scripts\mp\utility\game::_suicide();
          }
        }

        self.visuals[var_01] thread makesolid();
      }
    }
  } else {
    for(var_01 = 0; var_01 < self.visuals.size; var_1++) {
      self.visuals[var_01] hide();

      if(self.visuals[var_01].classname == "script_brushmodel" || self.visuals[var_01].classname == "script_model") {
        self.visuals[var_01] notify("changing_solidness");
        self.visuals[var_01] notsolid();
      }
    }
  }
}

makesolid() {
  self endon("death");
  self notify("changing_solidness");
  self endon("changing_solidness");

  for(;;) {
    for(var_00 = 0; var_00 < level.players.size; var_0++) {
      if(level.players[var_00] istouching(self)) {
        break;
      }
    }

    if(var_00 == level.players.size) {
      self solid();
      break;
    }

    wait 0.05;
  }
}

func_F680(var_00) {
  self.carriervisible = var_00;
}

func_F67D(var_00) {
  self.func_130E5 = var_00;
}

set2dicon(var_00, var_01) {
  self.func_4465[var_00] = var_01;

  if(!isDefined(var_01)) {
    self.worldiconscolor[var_00] = "neutral";
  } else {
    self.worldiconscolor[var_00] = getwaypointbackgroundcolor(var_01);
  }

  updatecompassicons();
}

getwaypointbackgroundtype(var_00) {
  if(!isDefined(level.waypointbgtype)) {
    scripts\mp\gamelogic::initwaypointbackgrounds();
  }

  var_01 = level.waypointbgtype[var_00];

  if(!isDefined(var_01)) {
    return 0;
  }

  return var_01;
}

getwaypointbackgroundcolor(var_00) {
  if(!isDefined(level.waypointcolors)) {
    scripts\mp\gamelogic::initwaypointbackgrounds();
  }

  var_01 = level.waypointcolors[var_00];

  if(!isDefined(var_01)) {
    return "neutral";
  }

  return var_01;
}

set3dicon(var_00, var_01) {
  self.func_13DCA[var_00] = var_01;

  if(!isDefined(var_01)) {
    self.worldiconscolor[var_00] = "neutral";
  } else {
    self.worldiconscolor[var_00] = getwaypointbackgroundcolor(var_01);
  }

  func_12F68();
}

func_F285(var_00, var_01) {
  self.func_13DCD[var_00] = var_01;
}

func_F681(var_00) {
  self.carryicon = var_00;
}

disableobject() {
  self notify("disabled");

  if(self.type == "carryObject") {
    if(isDefined(self.carrier)) {
      self.carrier takeobject(self);
    }

    for(var_00 = 0; var_00 < self.visuals.size; var_0++) {
      self.visuals[var_00] hide();
    }
  }

  self.trigger scripts\engine\utility::trigger_off();
  setvisibleteam("none");
}

enableobject() {
  if(self.type == "carryObject") {
    for(var_00 = 0; var_00 < self.visuals.size; var_0++) {
      self.visuals[var_00] show();
    }
  }

  self.trigger scripts\engine\utility::trigger_on();
  setvisibleteam("any");
}

getrelativeteam(var_00) {
  if(var_00 == self.ownerteam) {
    return "friendly";
  } else {
    return "enemy";
  }
}

isfriendlyteam(var_00) {
  if(self.ownerteam == "any") {
    return 1;
  }

  if(self.ownerteam == var_00) {
    return 1;
  }

  if(self.ownerteam == "neutral" && isDefined(self.prevownerteam) && self.prevownerteam == var_00) {
    return 1;
  }

  return 0;
}

caninteractwith(var_00, var_01) {
  switch (self.interactteam) {
    case "none":
      return 0;
    case "any":
      return 1;
    case "friendly":
      if(var_00 == self.ownerteam) {
        return 1;
      } else {
        return 0;
      }
    case "enemy":
      if(var_00 != self.ownerteam) {
        return 1;
      } else {
        return 0;
      }
    default:
      return 0;
  }
}

isteam(var_00) {
  if(var_00 == "neutral") {
    return 1;
  }

  if(var_00 == "allies") {
    return 1;
  }

  if(var_00 == "axis") {
    return 1;
  }

  if(var_00 == "any") {
    return 1;
  }

  if(var_00 == "none") {
    return 1;
  }

  foreach(var_02 in level.teamnamelist) {
    if(var_00 == var_02) {
      return 1;
    }
  }

  return 0;
}

isrelativeteam(var_00) {
  if(var_00 == "friendly") {
    return 1;
  }

  if(var_00 == "enemy") {
    return 1;
  }

  if(var_00 == "any") {
    return 1;
  }

  if(var_00 == "none") {
    return 1;
  }

  return 0;
}

func_7E93(var_00) {
  if(level.multiteambased) {}

  if(!level.teambased) {}

  if(var_00 == "neutral") {
    return "none";
  } else if(var_00 == "allies") {
    return "axis";
  } else {
    return "allies";
  }
}

getlaserangles() {
  var_00 = self.trigger.script_label;

  if(!isDefined(var_00)) {
    var_00 = "";
    return var_00;
  }

  if(var_0[0] != "_") {
    return "_" + var_00;
  }

  return var_00;
}

initializetagpathvariables() {
  self.nearest_node = undefined;
  self.calculated_nearest_node = 0;
  self.on_path_grid = undefined;
}

mustmaintainclaim(var_00) {
  self.mustmaintainclaim = var_00;
}

cancontestclaim(var_00) {
  self.cancontestclaim = var_00;
}

setzonestatusicons(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_01 = var_00;
  }

  set2dicon("friendly", var_00);
  set3dicon("friendly", var_00);
  set2dicon("enemy", var_01);
  set3dicon("enemy", var_01);
}

getleveltriggers() {
  level.minetriggers = getEntArray("minefield", "targetname");
  level.hurttriggers = getEntArray("trigger_hurt", "classname");
  level.radtriggers = getEntArray("radiation", "targetname");
  level.ballallowedtriggers = getEntArray("uplinkAllowedOOB", "targetname");
  level.nozonetriggers = getEntArray("uplink_nozone", "targetname");
  level.droptonavmeshtriggers = getEntArray("dropToNavMesh", "targetname");
  thread scripts\mp\utility\game::initarbitraryuptriggers();
}

isbombmode() {
  if(level.gametype == "sd" || level.gametype == "sr" || level.gametype == "dd") {
    return 1;
  }

  return 0;
}

touchingdroptonavmeshtrigger(var_00) {
  if(level.droptonavmeshtriggers.size > 0) {
    if(isbombmode() || level.gametype == "ctf") {
      self.visuals[0].origin = var_00;
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