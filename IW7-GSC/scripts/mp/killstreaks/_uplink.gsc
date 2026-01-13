/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_uplink.gsc
**********************************************/

init() {
  level.uplinks = [];
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("uplink", ::func_1290C);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("uplink_support", ::func_1290C);
  level.var_768F = 0;
  level.var_4418 = [];
  level.var_4418["giveComExpBenefits"] = ::setturretmodechangewait;
  level.var_4418["removeComExpBenefits"] = ::func_E0DF;
  level.var_4418["getRadarStrengthForTeam"] = ::disableusability;
  level.var_4418["getRadarStrengthForPlayer"] = ::_meth_80A7;
  level._effect["uav_beam"] = loadfx("vfx\old\_requests\mp_gameplay\vfx_energy_beam");
  unblockteamradar("axis");
  unblockteamradar("allies");
  level thread func_12F82();
  level thread func_12F83();
  if(level.var_768F) {
    level thread func_C799();
  }

  var_0 = spawnStruct();
  var_0.streakname = "uplink";
  var_0.var_39B = "ims_projectile_mp";
  var_0.modelbase = "mp_satcom";
  var_0.modelplacement = "mp_satcom_obj";
  var_0.modelplacementfailed = "mp_satcom_obj_red";
  var_0.modelbombsquad = "mp_satcom_bombsquad";
  var_0.pow = &"KILLSTREAKS_HINTS_UPLINK_PICKUP";
  var_0.placestring = &"KILLSTREAKS_HINTS_UPLINK_PLACE";
  var_0.cannotplacestring = &"KILLSTREAKS_HINTS_UPLINK_CANNOT_PLACE";
  var_0.var_8C79 = 42;
  var_0.var_10A38 = "used_uplink";
  var_0.lifespan = 30;
  var_0.maxhealth = 340;
  var_0.allowmeleedamage = 1;
  var_0.var_1C8F = 1;
  var_0.damagefeedback = "trophy";
  var_0.scorepopup = "destroyed_uplink";
  var_0.var_52DA = "satcom_destroyed";
  var_0.placementheighttolerance = 30;
  var_0.placementradius = 16;
  var_0.var_CC23 = 16;
  var_0.onplaceddelegate = ::onplaced;
  var_0.oncarrieddelegate = ::oncarried;
  var_0.var_CC15 = "mp_killstreak_satcom_deploy";
  var_0.var_1673 = "mp_killstreak_satcom_loop";
  var_0.var_C55B = ::func_12F80;
  var_0.ondeathdelegate = ::ondeath_clearscriptedanim;
  var_0.var_C4F3 = ::func_C4F2;
  var_0.deathvfx = loadfx("vfx\core\mp\killstreaks\vfx_ballistic_vest_death");
  level.placeableconfigs["uplink"] = var_0;
  level.placeableconfigs["uplink_support"] = var_0;
}

func_C799() {
  if(!level.teambased) {
    return;
  }

  for(;;) {
    level waittill("joined_team", var_0);
    var_0 thread func_1383D();
  }
}

func_1383D() {
  self waittill("spawned_player");
  foreach(var_1 in level.players) {
    if(var_1.team == "spectator") {
      continue;
    }

    var_2 = scripts\mp\utility::outlineenableforteam(var_1, "cyan", var_1.team, 0, 0, "killstreak");
  }
}

func_12F82() {
  level endon("game_ended");
  for(;;) {
    level waittill("update_uplink");
    level childthread func_12E5B();
  }
}

func_12E5B() {
  self notify("updateAllUplinkThreads");
  self endon("updateAllUplinkThreads");
  level childthread func_4419();
  if(level.teambased) {
    level childthread func_12F41("axis");
    level childthread func_12F41("allies");
  } else {
    level childthread func_12EF4();
  }

  level childthread func_12E79();
}

func_4419() {
  var_0 = [];
  if(!level.teambased) {
    level waittill("radar_status_change_players");
  } else {
    while(var_0.size < 2) {
      level waittill("radar_status_change", var_1);
      var_0[var_0.size] = var_1;
    }
  }

  level notify("start_com_exp");
}

func_12F41(var_0) {
  var_1 = disableusability(var_0);
  var_2 = var_1 == 1;
  var_3 = var_1 >= 2;
  var_4 = var_1 >= 3;
  var_5 = var_1 >= 4;
  if(var_3) {
    unblockteamradar(var_0);
  }

  if(var_4) {
    level.createprintchannel[var_0] = "fast_radar";
  } else {
    level.createprintchannel[var_0] = "normal_radar";
  }

  foreach(var_7 in level.participants) {
    if(!isDefined(var_7)) {
      continue;
    }

    if(var_7.team != var_0) {
      continue;
    }

    var_7.var_FFC7 = var_2;
    var_7 _meth_82DF(var_2);
    var_7.createprintchannel = level.createprintchannel[var_7.team];
    var_7.cylinder = var_5;
    var_7 func_12F09(var_0);
    wait(0.05);
  }

  setteamradar(var_0, var_3);
  level notify("radar_status_change", var_0);
}

func_12EF4() {
  foreach(var_1 in level.participants) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_2 = _meth_80A7(var_1);
    func_F7F7(var_1, var_2);
    var_1 func_12F09();
    wait(0.05);
  }

  level notify("radar_status_change_players");
}

func_12E79() {
  level waittill("start_com_exp");
  foreach(var_1 in level.participants) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 setturretmodechangewait();
    wait(0.05);
  }
}

setturretmodechangewait() {
  if(scripts\mp\utility::_hasperk("specialty_comexp")) {
    var_0 = _meth_80A6(self);
    func_F7F7(self, var_0);
    func_12F09();
  }
}

func_12F09(var_0) {
  var_1 = 0;
  if(isDefined(var_0)) {
    var_1 = disableusability(var_0);
  } else {
    var_1 = _meth_80A7(self);
  }

  if(scripts\mp\utility::_hasperk("specialty_comexp")) {
    var_1 = _meth_80A6(self);
  }

  if(var_1 > 0) {
    self setclientomnvar("ui_satcom_active", 1);
    return;
  }

  self setclientomnvar("ui_satcom_active", 0);
}

func_E0DF() {
  self.var_FFC7 = 0;
  self _meth_82DF(0);
  self.cylinder = 0;
  self.createprintchannel = "normal_radar";
  self.playcinematicforall = 0;
  self.randomint = 0;
}

func_F7F7(var_0, var_1) {
  var_2 = var_1 == 1;
  var_3 = var_1 >= 2;
  var_4 = var_1 >= 3;
  var_5 = var_1 >= 4;
  var_0.var_FFC7 = var_2;
  var_0 _meth_82DF(var_2);
  var_0.cylinder = var_5;
  var_0.createprintchannel = "normal_radar";
  var_0.playcinematicforall = var_3;
  var_0.randomint = 0;
  if(var_4) {
    var_0.createprintchannel = "fast_radar";
  }
}

func_1290C(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\_placeable::giveplaceable(var_1, 1);
  if(var_2) {
    scripts\mp\matchdata::logkillstreakevent("uplink", self.origin);
  }

  self.iscarrying = undefined;
  return var_2;
}

oncarried(var_0) {
  var_1 = self getentitynumber();
  if(isDefined(level.uplinks[var_1])) {
    func_11099();
  }
}

func_13A7B() {
  self waittill("satComTimedOut");
  foreach(var_1 in level.participants) {
    if(isDefined(var_1.var_2A3B)) {
      var_1.var_2A3B delete();
    }
  }
}

func_12AEF() {
  self endon("satComTimedOut");
  var_0 = 3;
  var_1 = 3;
  var_2 = 0.5;
  thread func_13A7B();
  for(;;) {
    foreach(var_4 in level.participants) {
      if(!isDefined(var_4)) {
        continue;
      }

      if(level.teambased && var_4.team == self.team) {
        continue;
      }

      if(var_4 scripts\mp\utility::_hasperk("specialty_gpsjammer")) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_4)) {
        if(isDefined(var_4.var_2A3B)) {
          var_4.var_2A3B delete();
        }

        continue;
      }

      if(isDefined(var_4.var_12AF1)) {
        if(isDefined(var_4.var_2A3B)) {
          var_4.var_2A3B delete();
        }

        var_4.var_12AF1.origin = var_4.origin;
        var_4.var_12AF2.origin = var_4.origin;
        var_4.var_12AF2.alpha = 0.95;
        var_4.var_12AF2 thread func_6AB8(var_1, var_2);
      } else {
        var_5 = spawn("script_model", var_4.origin);
        var_5 setModel("tag_origin");
        var_5.triggerportableradarping = var_4;
        var_4.var_12AF1 = var_5;
        var_4.var_12AF2 = var_5 scripts\mp\entityheadicons::setheadicon(self.team, "headicon_enemy", (0, 0, 32), 2, 2, 1, 0.01, 0, 1, 1, 0);
        var_4.var_12AF2.alpha = 0.95;
        var_4.var_12AF2 thread func_6AB8(var_1, var_2);
      }

      var_4.var_2A3B = playloopedfx(scripts\engine\utility::getfx("uav_beam"), var_0, var_4.origin);
    }

    wait(var_1);
  }
}

func_B37E() {
  var_0 = 3;
  var_1 = 3;
  var_2 = 0.5;
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_12AF1)) {
    if(isDefined(self.var_2A3B)) {
      self.var_2A3B delete();
    }

    self.var_12AF1.origin = self.origin;
    self.var_12AF2.origin = self.origin;
    self.var_12AF2.alpha = 0.95;
    self.var_12AF2 thread func_6AB8(var_1, var_2);
  } else {
    var_3 = spawn("script_model", self.origin);
    var_3 setModel("tag_origin");
    var_3.triggerportableradarping = self;
    self.var_12AF1 = var_3;
    self.var_12AF2 = var_3 scripts\mp\entityheadicons::setheadicon(scripts\mp\utility::getotherteam(self.team), "headicon_enemy", (0, 0, 32), 14, 14, 1, 0.01, 0, 1, 1, 0);
    self.var_12AF2.alpha = 0.95;
    self.var_12AF2 thread func_6AB8(var_1, var_2);
  }

  self.var_2A3B = playloopedfx(scripts\engine\utility::getfx("uav_beam"), var_0, self.origin);
  wait(var_1);
  if(isDefined(self.var_2A3B)) {
    self.var_2A3B delete();
  }
}

func_6AB8(var_0, var_1) {
  self notify("fadeOut");
  self endon("fadeOut");
  var_2 = var_0 - var_1;
  wait(0.05);
  if(!isDefined(self)) {
    return;
  }

  self fadeovertime(var_2);
  self.alpha = 0;
}

onplaced(var_0) {
  var_1 = level.placeableconfigs[var_0];
  self.triggerportableradarping notify("uplink_deployed");
  self setModel(var_1.modelbase);
  self.var_933C = 0;
  self setotherent(self.triggerportableradarping);
  scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.triggerportableradarping);
  self.config = var_1;
  if(level.var_768F) {
    thread func_12AEF();
  }

  func_10E04(1);
  thread watchempdamage();
}

func_10E04(var_0) {
  func_1868(self);
  self playLoopSound(self.config.var_1673);
}

func_11099() {
  scripts\mp\weapons::stopblinkinglight();
  self scriptmodelclearanim();
  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel scriptmodelclearanim();
  }

  func_E188(self);
  self stoploopsound();
}

func_C4F2(var_0, var_1, var_2, var_3) {
  var_1 notify("destroyed_equipment");
}

ondeath_clearscriptedanim(var_0, var_1, var_2, var_3) {
  scripts\mp\weapons::stopblinkinglight();
  scripts\mp\weapons::equipmentdeathvfx();
  func_E188(self);
  self scriptmodelclearanim();
  if(!self.var_933C) {
    wait(3);
  }

  scripts\mp\weapons::equipmentdeletevfx();
}

func_1868(var_0) {
  var_1 = var_0 getentitynumber();
  level.uplinks[var_1] = var_0;
  level notify("update_uplink");
}

func_E188(var_0) {
  var_0 notify("satComTimedOut");
  var_1 = var_0 getentitynumber();
  level.uplinks[var_1] = undefined;
  level notify("update_uplink");
}

disableusability(var_0) {
  var_1 = 0;
  foreach(var_3 in level.uplinks) {
    if(isDefined(var_3) && var_3.team == var_0) {
      var_1++;
    }
  }

  if(var_1 == 0 && isDefined(level.var_8DD7) && level.var_8DD7.team == var_0) {
    var_1++;
  }

  if(var_1 == 1) {
    var_1 = 2;
  }

  return clamp(var_1, 0, 4);
}

_meth_80A7(var_0) {
  var_1 = 0;
  foreach(var_3 in level.uplinks) {
    if(isDefined(var_3)) {
      if(isDefined(var_3.triggerportableradarping)) {
        if(var_3.triggerportableradarping.guid == var_0.guid) {
          var_1++;
        }

        continue;
      }

      var_4 = var_3 getentitynumber();
      level.uplinks[var_4] = undefined;
    }
  }

  if(!level.teambased && var_1 > 0) {
    var_1++;
  }

  return clamp(var_1, 0, 4);
}

_meth_80A6(var_0) {
  var_1 = 0;
  foreach(var_3 in level.uplinks) {
    if(isDefined(var_3)) {
      var_1++;
    }
  }

  if(!level.teambased && var_1 > 0) {
    var_1++;
  }

  return clamp(var_1, 0, 4);
}

func_12F80(var_0) {
  self.var_933C = 1;
  self notify("death");
}

watchempdamage() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    scripts\mp\weapons::equipmentempstunvfx();
    func_11099();
    wait(var_1);
    func_10E04(0);
  }
}

func_12F83() {
  level endon("game_ended");
  for(;;) {
    level waittill("player_spawned", var_0);
    var_1 = isDefined(var_0.var_FFC7) && var_0.var_FFC7;
    var_0 _meth_82DF(var_1);
  }
}