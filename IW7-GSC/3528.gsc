/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3528.gsc
***************************************/

init() {
  level.uplinks = [];
  scripts\mp\killstreaks\killstreaks::registerkillstreak("uplink", ::func_1290C);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("uplink_support", ::func_1290C);
  level.func_768F = 0;
  level.func_4418 = [];
  level.func_4418["giveComExpBenefits"] = ::setturretmodechangewait;
  level.func_4418["removeComExpBenefits"] = ::func_E0DF;
  level.func_4418["getRadarStrengthForTeam"] = ::disableusability;
  level.func_4418["getRadarStrengthForPlayer"] = ::_meth_80A7;
  level._effect["uav_beam"] = loadfx("vfx\old\_requests\mp_gameplay\vfx_energy_beam");
  unblockteamradar("axis");
  unblockteamradar("allies");
  level thread func_12F82();
  level thread func_12F83();

  if(level.func_768F) {
    level thread func_C799();
  }

  var_00 = spawnStruct();
  var_0.streakname = "uplink";
  var_0.weaponinfo = "ims_projectile_mp";
  var_0.modelbase = "mp_satcom";
  var_0.modelplacement = "mp_satcom_obj";
  var_0.modelplacementfailed = "mp_satcom_obj_red";
  var_0.modelbombsquad = "mp_satcom_bombsquad";
  var_0.hintstring = &"KILLSTREAKS_HINTS_UPLINK_PICKUP";
  var_0.placestring = &"KILLSTREAKS_HINTS_UPLINK_PLACE";
  var_0.cannotplacestring = &"KILLSTREAKS_HINTS_UPLINK_CANNOT_PLACE";
  var_0.func_8C79 = 42;
  var_0.func_10A38 = "used_uplink";
  var_0.lifespan = 30;
  var_0.maxhealth = 340;
  var_0.allowmeleedamage = 1;
  var_0.func_1C8F = 1;
  var_0.damagefeedback = "trophy";
  var_0.scorepopup = "destroyed_uplink";
  var_0.func_52DA = "satcom_destroyed";
  var_0.placementheighttolerance = 30.0;
  var_0.placementradius = 16.0;
  var_0.func_CC23 = 16;
  var_0.onplaceddelegate = ::onplaced;
  var_0.oncarrieddelegate = ::oncarried;
  var_0.func_CC15 = "mp_killstreak_satcom_deploy";
  var_0.func_1673 = "mp_killstreak_satcom_loop";
  var_0.func_C55B = ::func_12F80;
  var_0.ondeathdelegate = ::ondeath_clearscriptedanim;
  var_0.func_C4F3 = ::func_C4F2;
  var_0.deathvfx = loadfx("vfx\core\mp\killstreaks\vfx_ballistic_vest_death");
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
    if(var_1.team == "spectator") {
      continue;
    }
    var_02 = scripts\mp\utility\game::outlineenableforteam(var_01, "cyan", var_1.team, 0, 0, "killstreak");
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
  } else
    level childthread func_12EF4();

  level childthread func_12E79();
}

func_4419() {
  var_00 = [];

  if(!level.teambased) {
    level waittill("radar_status_change_players");
  }
  else {
    while(var_0.size < 2) {
      level waittill("radar_status_change", var_01);
      var_0[var_0.size] = var_01;
    }
  }

  level notify("start_com_exp");
}

func_12F41(var_00) {
  var_01 = disableusability(var_00);
  var_02 = var_01 == 1;
  var_03 = var_01 >= 2;
  var_04 = var_01 >= 3;
  var_05 = var_01 >= 4;

  if(var_03) {
    unblockteamradar(var_00);
  }

  if(var_04) {
    level.radarmode[var_00] = "fast_radar";
  }
  else {
    level.radarmode[var_00] = "normal_radar";
  }

  foreach(var_07 in level.participants) {
    if(!isDefined(var_07)) {
      continue;
    }
    if(var_7.team != var_00) {
      continue;
    }
    var_7.func_FFC7 = var_02;
    var_07 _meth_82DF(var_02);
    var_7.radarmode = level.radarmode[var_7.team];
    var_7.radarshowenemydirection = var_05;
    var_07 func_12F09(var_00);
    wait 0.05;
  }

  setteamradar(var_00, var_03);
  level notify("radar_status_change", var_00);
}

func_12EF4() {
  foreach(var_01 in level.participants) {
    if(!isDefined(var_01)) {
      continue;
    }
    var_02 = _meth_80A7(var_01);
    func_F7F7(var_01, var_02);
    var_01 func_12F09();
    wait 0.05;
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
    wait 0.05;
  }
}

setturretmodechangewait() {
  if(scripts\mp\utility\game::_hasperk("specialty_comexp")) {
    var_00 = _meth_80A6(self);
    func_F7F7(self, var_00);
    func_12F09();
  }
}

func_12F09(var_00) {
  var_01 = 0;

  if(isDefined(var_00)) {
    var_01 = disableusability(var_00);
  }
  else {
    var_01 = _meth_80A7(self);
  }

  if(scripts\mp\utility\game::_hasperk("specialty_comexp")) {
    var_01 = _meth_80A6(self);
  }

  if(var_01 > 0) {
    self setclientomnvar("ui_satcom_active", 1);
  }
  else {
    self setclientomnvar("ui_satcom_active", 0);
  }
}

func_E0DF() {
  self.func_FFC7 = 0;
  self _meth_82DF(0);
  self.radarshowenemydirection = 0;
  self.radarmode = "normal_radar";
  self.hasradar = 0;
  self.isradarblocked = 0;
}

func_F7F7(var_00, var_01) {
  var_02 = var_01 == 1;
  var_03 = var_01 >= 2;
  var_04 = var_01 >= 3;
  var_05 = var_01 >= 4;
  var_0.func_FFC7 = var_02;
  var_00 _meth_82DF(var_02);
  var_0.radarshowenemydirection = var_05;
  var_0.radarmode = "normal_radar";
  var_0.hasradar = var_03;
  var_0.isradarblocked = 0;

  if(var_04) {
    var_0.radarmode = "fast_radar";
  }
}

func_1290C(var_00, var_01) {
  var_02 = scripts\mp\killstreaks\placeable::giveplaceable(var_01, 1);

  if(var_02) {
    scripts\mp\matchdata::logkillstreakevent("uplink", self.origin);
  }

  self.iscarrying = undefined;
  return var_02;
}

oncarried(var_00) {
  var_01 = self getentitynumber();

  if(isDefined(level.uplinks[var_01])) {
    func_11099();
  }
}

func_13A7B() {
  self waittill("satComTimedOut");

  foreach(var_01 in level.participants) {
    if(isDefined(var_1.func_2A3B)) {
      var_1.func_2A3B delete();
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
      if(level.teambased && var_4.team == self.team) {
        continue;
      }
      if(var_04 scripts\mp\utility\game::_hasperk("specialty_gpsjammer")) {
        continue;
      }
      if(!scripts\mp\utility\game::isreallyalive(var_04)) {
        if(isDefined(var_4.func_2A3B)) {
          var_4.func_2A3B delete();
        }

        continue;
      }

      if(isDefined(var_4.func_12AF1)) {
        if(isDefined(var_4.func_2A3B)) {
          var_4.func_2A3B delete();
        }

        var_4.func_12AF1.origin = var_4.origin;
        var_4.func_12AF2.origin = var_4.origin;
        var_4.func_12AF2.alpha = 0.95;
        var_4.func_12AF2 thread func_6AB8(var_01, var_02);
      } else {
        var_05 = spawn("script_model", var_4.origin);
        var_05 setModel("tag_origin");
        var_5.owner = var_04;
        var_4.func_12AF1 = var_05;
        var_4.func_12AF2 = var_05 scripts\mp\entityheadicons::setheadicon(self.team, "headicon_enemy", (0, 0, 32), 2, 2, 1, 0.01, 0, 1, 1, 0);
        var_4.func_12AF2.alpha = 0.95;
        var_4.func_12AF2 thread func_6AB8(var_01, var_02);
      }

      var_4.func_2A3B = playloopedfx(scripts\engine\utility::getfx("uav_beam"), var_00, var_4.origin);
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
  if(isDefined(self.func_12AF1)) {
    if(isDefined(self.func_2A3B)) {
      self.func_2A3B delete();
    }

    self.func_12AF1.origin = self.origin;
    self.func_12AF2.origin = self.origin;
    self.func_12AF2.alpha = 0.95;
    self.func_12AF2 thread func_6AB8(var_01, var_02);
  } else {
    var_03 = spawn("script_model", self.origin);
    var_03 setModel("tag_origin");
    var_3.owner = self;
    self.func_12AF1 = var_03;
    self.func_12AF2 = var_03 scripts\mp\entityheadicons::setheadicon(scripts\mp\utility\game::getotherteam(self.team), "headicon_enemy", (0, 0, 32), 14, 14, 1, 0.01, 0, 1, 1, 0);
    self.func_12AF2.alpha = 0.95;
    self.func_12AF2 thread func_6AB8(var_01, var_02);
  }

  self.func_2A3B = playloopedfx(scripts\engine\utility::getfx("uav_beam"), var_00, self.origin);
  wait(var_01);

  if(isDefined(self.func_2A3B)) {
    self.func_2A3B delete();
  }
}

func_6AB8(var_00, var_01) {
  self notify("fadeOut");
  self endon("fadeOut");
  var_02 = var_00 - var_01;
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self fadeovertime(var_02);
  self.alpha = 0.0;
}

onplaced(var_00) {
  var_01 = level.placeableconfigs[var_00];
  self.owner notify("uplink_deployed");
  self setModel(var_1.modelbase);
  self.func_933C = 0;
  self setotherent(self.owner);
  scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.owner);
  self.config = var_01;

  if(level.func_768F) {
    thread func_12AEF();
  }

  func_10E04(1);
  thread watchempdamage();
}

func_10E04(var_00) {
  func_1868(self);
  self playLoopSound(self.config.func_1673);
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

func_C4F2(var_00, var_01, var_02, var_03) {
  var_01 notify("destroyed_equipment");
}

ondeath_clearscriptedanim(var_00, var_01, var_02, var_03) {
  scripts\mp\weapons::stopblinkinglight();
  scripts\mp\weapons::equipmentdeathvfx();
  func_E188(self);
  self scriptmodelclearanim();

  if(!self.func_933C) {
    wait 3.0;
  }

  scripts\mp\weapons::equipmentdeletevfx();
}

func_1868(var_00) {
  var_01 = var_00 getentitynumber();
  level.uplinks[var_01] = var_00;
  level notify("update_uplink");
}

func_E188(var_00) {
  var_00 notify("satComTimedOut");
  var_01 = var_00 getentitynumber();
  level.uplinks[var_01] = undefined;
  level notify("update_uplink");
}

disableusability(var_00) {
  var_01 = 0;

  foreach(var_03 in level.uplinks) {
    if(isDefined(var_03) && var_3.team == var_00) {
      var_1++;
    }
  }

  if(var_01 == 0 && isDefined(level.func_8DD7) && level.func_8DD7.team == var_00) {
    var_1++;
  }

  if(var_01 == 1) {
    var_01 = 2;
  }

  return clamp(var_01, 0, 4);
}

_meth_80A7(var_00) {
  var_01 = 0;

  foreach(var_03 in level.uplinks) {
    if(isDefined(var_03)) {
      if(isDefined(var_3.owner)) {
        if(var_3.owner.guid == var_0.guid) {
          var_1++;
        }

        continue;
      }

      var_04 = var_03 getentitynumber();
      level.uplinks[var_04] = undefined;
    }
  }

  if(!level.teambased && var_01 > 0) {
    var_1++;
  }

  return clamp(var_01, 0, 4);
}

_meth_80A6(var_00) {
  var_01 = 0;

  foreach(var_03 in level.uplinks) {
    if(isDefined(var_03)) {
      var_1++;
    }
  }

  if(!level.teambased && var_01 > 0) {
    var_1++;
  }

  return clamp(var_01, 0, 4);
}

func_12F80(var_00) {
  self.func_933C = 1;
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
    var_01 = isDefined(var_0.func_FFC7) && var_0.func_FFC7;
    var_00 _meth_82DF(var_01);
  }
}