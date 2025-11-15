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

  var_00 = spawnStruct();
  var_00.streakname = "uplink";
  var_00.var_39B = "ims_projectile_mp";
  var_00.modelbase = "mp_satcom";
  var_00.modelplacement = "mp_satcom_obj";
  var_00.modelplacementfailed = "mp_satcom_obj_red";
  var_00.modelbombsquad = "mp_satcom_bombsquad";
  var_00.pow = & "KILLSTREAKS_HINTS_UPLINK_PICKUP";
  var_00.placestring = & "KILLSTREAKS_HINTS_UPLINK_PLACE";
  var_00.cannotplacestring = & "KILLSTREAKS_HINTS_UPLINK_CANNOT_PLACE";
  var_00.var_8C79 = 42;
  var_00.var_10A38 = "used_uplink";
  var_00.lifespan = 30;
  var_00.maxhealth = 340;
  var_00.allowmeleedamage = 1;
  var_00.var_1C8F = 1;
  var_00.damagefeedback = "trophy";
  var_00.scorepopup = "destroyed_uplink";
  var_00.var_52DA = "satcom_destroyed";
  var_00.placementheighttolerance = 30;
  var_00.placementradius = 16;
  var_00.var_CC23 = 16;
  var_00.onplaceddelegate = ::onplaced;
  var_00.oncarrieddelegate = ::oncarried;
  var_00.var_CC15 = "mp_killstreak_satcom_deploy";
  var_00.var_1673 = "mp_killstreak_satcom_loop";
  var_00.var_C55B = ::func_12F80;
  var_00.ondeathdelegate = ::ondeath_clearscriptedanim;
  var_00.var_C4F3 = ::func_C4F2;
  var_00.deathvfx = loadfx("vfx\core\mp\killstreaks\vfx_ballistic_vest_death");
  level.placeableconfigs["uplink"] = var_00;
  level.placeableconfigs["uplink_support"] = var_00;
}

func_C799() {
  if(!level.teambased) {
    return;
  }

  for(;;) {
    level waittill("joined_team", var_00);
    var_00 thread func_1383D();
  }
}

func_1383D() {
  self waittill("spawned_player");
  foreach(var_01 in level.players) {
    if(var_01.team == "spectator") {
      continue;
    }

    var_02 = scripts\mp\utility::outlineenableforteam(var_01, "cyan", var_01.team, 0, 0, "killstreak");
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
  var_00 = [];
  if(!level.teambased) {
    level waittill("radar_status_change_players");
  } else {
    while(var_00.size < 2) {
      level waittill("radar_status_change", var_01);
      var_00[var_00.size] = var_01;
    }
  }

  level notify("start_com_exp");
}

func_12F41(param_00) {
  var_01 = disableusability(param_00);
  var_02 = var_01 == 1;
  var_03 = var_01 >= 2;
  var_04 = var_01 >= 3;
  var_05 = var_01 >= 4;
  if(var_03) {
    unblockteamradar(param_00);
  }

  if(var_04) {
    level.createprintchannel[param_00] = "fast_radar";
  } else {
    level.createprintchannel[param_00] = "normal_radar";
  }

  foreach(var_07 in level.participants) {
    if(!isDefined(var_07)) {
      continue;
    }

    if(var_07.team != param_00) {
      continue;
    }

    var_07.var_FFC7 = var_02;
    var_07 _meth_82DF(var_02);
    var_07.createprintchannel = level.createprintchannel[var_07.team];
    var_07.cylinder = var_05;
    var_07 func_12F09(param_00);
    wait(0.05);
  }

  setteamradar(param_00, var_03);
  level notify("radar_status_change", param_00);
}

func_12EF4() {
  foreach(var_01 in level.participants) {
    if(!isDefined(var_01)) {
      continue;
    }

    var_02 = _meth_80A7(var_01);
    func_F7F7(var_01, var_02);
    var_01 func_12F09();
    wait(0.05);
  }

  level notify("radar_status_change_players");
}

func_12E79() {
  level waittill("start_com_exp");
  foreach(var_01 in level.participants) {
    if(!isDefined(var_01)) {
      continue;
    }

    var_01 setturretmodechangewait();
    wait(0.05);
  }
}

setturretmodechangewait() {
  if(scripts\mp\utility::_hasperk("specialty_comexp")) {
    var_00 = _meth_80A6(self);
    func_F7F7(self, var_00);
    func_12F09();
  }
}

func_12F09(param_00) {
  var_01 = 0;
  if(isDefined(param_00)) {
    var_01 = disableusability(param_00);
  } else {
    var_01 = _meth_80A7(self);
  }

  if(scripts\mp\utility::_hasperk("specialty_comexp")) {
    var_01 = _meth_80A6(self);
  }

  if(var_01 > 0) {
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

func_F7F7(param_00, param_01) {
  var_02 = param_01 == 1;
  var_03 = param_01 >= 2;
  var_04 = param_01 >= 3;
  var_05 = param_01 >= 4;
  param_00.var_FFC7 = var_02;
  param_00 _meth_82DF(var_02);
  param_00.cylinder = var_05;
  param_00.createprintchannel = "normal_radar";
  param_00.playcinematicforall = var_03;
  param_00.randomint = 0;
  if(var_04) {
    param_00.createprintchannel = "fast_radar";
  }
}

func_1290C(param_00, param_01) {
  var_02 = scripts\mp\killstreaks\_placeable::giveplaceable(param_01, 1);
  if(var_02) {
    scripts\mp\matchdata::logkillstreakevent("uplink", self.origin);
  }

  self.iscarrying = undefined;
  return var_02;
}

oncarried(param_00) {
  var_01 = self getentitynumber();
  if(isDefined(level.uplinks[var_01])) {
    func_11099();
  }
}

func_13A7B() {
  self waittill("satComTimedOut");
  foreach(var_01 in level.participants) {
    if(isDefined(var_01.var_2A3B)) {
      var_01.var_2A3B delete();
    }
  }
}

func_12AEF() {
  self endon("satComTimedOut");
  var_00 = 3;
  var_01 = 3;
  var_02 = 0.5;
  thread func_13A7B();
  for(;;) {
    foreach(var_04 in level.participants) {
      if(!isDefined(var_04)) {
        continue;
      }

      if(level.teambased && var_04.team == self.team) {
        continue;
      }

      if(var_04 scripts\mp\utility::_hasperk("specialty_gpsjammer")) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_04)) {
        if(isDefined(var_04.var_2A3B)) {
          var_04.var_2A3B delete();
        }

        continue;
      }

      if(isDefined(var_04.var_12AF1)) {
        if(isDefined(var_04.var_2A3B)) {
          var_04.var_2A3B delete();
        }

        var_04.var_12AF1.origin = var_04.origin;
        var_04.var_12AF2.origin = var_04.origin;
        var_04.var_12AF2.alpha = 0.95;
        var_04.var_12AF2 thread func_6AB8(var_01, var_02);
      } else {
        var_05 = spawn("script_model", var_04.origin);
        var_05 setModel("tag_origin");
        var_05.triggerportableradarping = var_04;
        var_04.var_12AF1 = var_05;
        var_04.var_12AF2 = var_05 scripts\mp\entityheadicons::setheadicon(self.team, "headicon_enemy", (0, 0, 32), 2, 2, 1, 0.01, 0, 1, 1, 0);
        var_04.var_12AF2.alpha = 0.95;
        var_04.var_12AF2 thread func_6AB8(var_01, var_02);
      }

      var_04.var_2A3B = playloopedfx(scripts\engine\utility::getfx("uav_beam"), var_00, var_04.origin);
    }

    wait(var_01);
  }
}

func_B37E() {
  var_00 = 3;
  var_01 = 3;
  var_02 = 0.5;
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
    self.var_12AF2 thread func_6AB8(var_01, var_02);
  } else {
    var_03 = spawn("script_model", self.origin);
    var_03 setModel("tag_origin");
    var_03.triggerportableradarping = self;
    self.var_12AF1 = var_03;
    self.var_12AF2 = var_03 scripts\mp\entityheadicons::setheadicon(scripts\mp\utility::getotherteam(self.team), "headicon_enemy", (0, 0, 32), 14, 14, 1, 0.01, 0, 1, 1, 0);
    self.var_12AF2.alpha = 0.95;
    self.var_12AF2 thread func_6AB8(var_01, var_02);
  }

  self.var_2A3B = playloopedfx(scripts\engine\utility::getfx("uav_beam"), var_00, self.origin);
  wait(var_01);
  if(isDefined(self.var_2A3B)) {
    self.var_2A3B delete();
  }
}

func_6AB8(param_00, param_01) {
  self notify("fadeOut");
  self endon("fadeOut");
  var_02 = param_00 - param_01;
  wait(0.05);
  if(!isDefined(self)) {
    return;
  }

  self fadeovertime(var_02);
  self.alpha = 0;
}

onplaced(param_00) {
  var_01 = level.placeableconfigs[param_00];
  self.triggerportableradarping notify("uplink_deployed");
  self setModel(var_01.modelbase);
  self.var_933C = 0;
  self setotherent(self.triggerportableradarping);
  scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.triggerportableradarping);
  self.config = var_01;
  if(level.var_768F) {
    thread func_12AEF();
  }

  func_10E04(1);
  thread watchempdamage();
}

func_10E04(param_00) {
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

func_C4F2(param_00, param_01, param_02, param_03) {
  param_01 notify("destroyed_equipment");
}

ondeath_clearscriptedanim(param_00, param_01, param_02, param_03) {
  scripts\mp\weapons::stopblinkinglight();
  scripts\mp\weapons::equipmentdeathvfx();
  func_E188(self);
  self scriptmodelclearanim();
  if(!self.var_933C) {
    wait(3);
  }

  scripts\mp\weapons::equipmentdeletevfx();
}

func_1868(param_00) {
  var_01 = param_00 getentitynumber();
  level.uplinks[var_01] = param_00;
  level notify("update_uplink");
}

func_E188(param_00) {
  param_00 notify("satComTimedOut");
  var_01 = param_00 getentitynumber();
  level.uplinks[var_01] = undefined;
  level notify("update_uplink");
}

disableusability(param_00) {
  var_01 = 0;
  foreach(var_03 in level.uplinks) {
    if(isDefined(var_03) && var_03.team == param_00) {
      var_01++;
    }
  }

  if(var_01 == 0 && isDefined(level.var_8DD7) && level.var_8DD7.team == param_00) {
    var_01++;
  }

  if(var_01 == 1) {
    var_01 = 2;
  }

  return clamp(var_01, 0, 4);
}

_meth_80A7(param_00) {
  var_01 = 0;
  foreach(var_03 in level.uplinks) {
    if(isDefined(var_03)) {
      if(isDefined(var_03.triggerportableradarping)) {
        if(var_03.triggerportableradarping.guid == param_00.guid) {
          var_01++;
        }

        continue;
      }

      var_04 = var_03 getentitynumber();
      level.uplinks[var_04] = undefined;
    }
  }

  if(!level.teambased && var_01 > 0) {
    var_01++;
  }

  return clamp(var_01, 0, 4);
}

_meth_80A6(param_00) {
  var_01 = 0;
  foreach(var_03 in level.uplinks) {
    if(isDefined(var_03)) {
      var_01++;
    }
  }

  if(!level.teambased && var_01 > 0) {
    var_01++;
  }

  return clamp(var_01, 0, 4);
}

func_12F80(param_00) {
  self.var_933C = 1;
  self notify("death");
}

watchempdamage() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_00, var_01);
    scripts\mp\weapons::equipmentempstunvfx();
    func_11099();
    wait(var_01);
    func_10E04(0);
  }
}

func_12F83() {
  level endon("game_ended");
  for(;;) {
    level waittill("player_spawned", var_00);
    var_01 = isDefined(var_00.var_FFC7) && var_00.var_FFC7;
    var_00 _meth_82DF(var_01);
  }
}