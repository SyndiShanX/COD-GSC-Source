/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_air_superiority.gsc
*******************************************************/

init() {
  var_00 = spawnStruct();
  var_00.var_B923 = [];
  var_00.var_B923["allies"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_00.var_B923["axis"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_00.inboundsfx = "veh_mig29_dist_loop";
  var_00.compassiconfriendly = "compass_objpoint_airstrike_friendly";
  var_00.compassiconenemy = "compass_objpoint_airstrike_busy";
  var_00.getclosestpointonnavmesh3d = 4000;
  var_00.halfdistance = 20000;
  var_00.var_5715 = 4000;
  var_00.heightrange = 250;
  var_00.var_C23A = 3;
  var_00.outboundflightanim = "airstrike_mp_roll";
  var_00.sonicboomsfx = "veh_mig29_sonic_boom";
  var_00.onattackdelegate = ::func_24D8;
  var_00.onflybycompletedelegate = ::cleanupgamemodes;
  var_00.scorepopup = "destroyed_air_superiority";
  var_00.callout = "callout_destroyed_air_superiority";
  var_00.vodestroyed = undefined;
  var_00.killcamoffset = (-800, 0, 200);
  level.planeconfigs["air_superiority"] = var_00;
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("air_superiority", ::onuse);
  level.teamairdenied["axis"] = 0;
  level.teamairdenied["allies"] = 0;
}

onuse(param_00) {
  var_01 = scripts\mp\utility::getotherteam(self.team);
  if((level.teambased && level.teamairdenied[var_01]) || !level.teambased && isDefined(level.airdeniedplayer) && level.airdeniedplayer == self) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  thread dostrike(param_00.lifeid, "air_superiority");
  scripts\mp\matchdata::logkillstreakevent("air_superiority", self.origin);
  thread scripts\mp\utility::teamplayercardsplash("used_air_superiority", self);
  return 1;
}

dostrike(param_00, param_01) {
  var_02 = level.planeconfigs[param_01];
  var_03 = scripts\mp\killstreaks\_plane::_meth_8069(var_02.var_5715);
  wait(1);
  var_04 = scripts\mp\utility::getotherteam(self.team);
  level.teamairdenied[var_04] = 1;
  level.airdeniedplayer = self;
  dooneflyby(param_01, param_00, var_03.targetpos, var_03.var_6F25, var_03.height);
  self waittill("aa_flyby_complete");
  wait(2);
  scripts\mp\hostmigration::waittillhostmigrationdone();
  if(isDefined(self)) {
    dooneflyby(param_01, param_00, var_03.targetpos, -1 * var_03.var_6F25, var_03.height);
    self waittill("aa_flyby_complete");
  }

  level.teamairdenied[var_04] = 0;
  level.airdeniedplayer = undefined;
}

dooneflyby(param_00, param_01, param_02, param_03, param_04) {
  var_05 = level.planeconfigs[param_00];
  var_06 = scripts\mp\killstreaks\_plane::getflightpath(param_02, param_03, var_05.halfdistance, 1, param_04, var_05.getclosestpointonnavmesh3d, -0.5 * var_05.halfdistance, param_00);
  level thread scripts\mp\killstreaks\_plane::doflyby(param_01, self, param_01, var_06["startPoint"] + (0, 0, randomint(var_05.heightrange)), var_06["endPoint"] + (0, 0, randomint(var_05.heightrange)), var_06["attackTime"], var_06["flyTime"], param_03, param_00);
}

func_24D8(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  self.triggerportableradarping endon("killstreak_disowned");
  level endon("game_ended");
  wait(param_02);
  var_05 = func_6CAA(self.triggerportableradarping, self.team);
  var_06 = level.planeconfigs[param_04];
  var_07 = var_06.var_C23A;
  for(var_08 = var_05.size - 1; var_08 >= 0 && var_07 > 0; var_08--) {
    var_09 = var_05[var_08];
    if(isDefined(var_09) && isalive(var_09)) {
      fireattarget(var_09);
      var_07--;
      wait(1);
    }
  }
}

cleanupgamemodes(param_00, param_01, param_02) {
  param_00 notify("aa_flyby_complete");
}

func_6CC8(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_03)) {
    foreach(var_06 in param_03) {
      if([
          [param_02]
        ](param_00, param_01, var_06)) {
        param_04.targets[param_04.targets.size] = var_06;
      }
    }
  }

  return param_04;
}

func_6CAA(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.targets = [];
  var_03 = undefined;
  if(level.teambased) {
    var_03 = ::scripts\mp\utility::func_9FE7;
  } else {
    var_03 = ::scripts\mp\utility::func_9FD8;
  }

  var_04 = undefined;
  if(isDefined(param_01)) {
    var_04 = scripts\mp\utility::getotherteam(param_01);
  }

  func_6CC8(param_00, var_04, var_03, level.heli_pilot, var_02);
  if(isDefined(level.lbsniper)) {
    if([
        [var_03]
      ](param_00, var_04, level.lbsniper)) {
      var_02.targets[var_02.targets.size] = level.lbsniper;
    }
  }

  func_6CC8(param_00, var_04, var_03, level.planes, var_02);
  func_6CC8(param_00, var_04, var_03, level.littlebirds, var_02);
  func_6CC8(param_00, var_04, var_03, level.helis, var_02);
  return var_02.targets;
}

fireattarget(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = undefined;
  if(isDefined(self.triggerportableradarping)) {
    var_01 = self.triggerportableradarping;
  }

  var_02 = 384 * anglesToForward(self.angles);
  var_03 = self gettagorigin("tag_missile_1") + var_02;
  var_04 = scripts\mp\utility::_magicbullet("aamissile_projectile_mp", var_03, var_03 + var_02, var_01);
  var_04.vehicle_fired_from = self;
  var_03 = self gettagorigin("tag_missile_2") + var_02;
  var_05 = scripts\mp\utility::_magicbullet("aamissile_projectile_mp", var_03, var_03 + var_02, var_01);
  var_05.vehicle_fired_from = self;
  var_06 = [var_04, var_05];
  param_00 notify("targeted_by_incoming_missile", var_06);
  thread func_10DC4(param_00, 0.25, var_06);
}

func_10DC4(param_00, param_01, param_02) {
  wait(param_01);
  if(isDefined(param_00)) {
    var_03 = undefined;
    if(param_00.model != "vehicle_av8b_harrier_jet_mp") {
      var_03 = param_00 gettagorigin("tag_missile_target");
    }

    if(!isDefined(var_03)) {
      var_03 = param_00 gettagorigin("tag_body");
    }

    var_04 = var_03 - param_00.origin;
    foreach(var_06 in param_02) {
      if(isvalidmissile(var_06)) {
        var_06 missile_settargetent(param_00, var_04);
        var_06 missile_setflightmodedirect();
      }
    }
  }
}

func_52CA(param_00, param_01) {
  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, "aamissile_projectile_mp", level.helis);
  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, "aamissile_projectile_mp", level.littlebirds);
  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, "aamissile_projectile_mp", level.heli_pilot);
  if(isDefined(level.lbsniper)) {
    var_02 = [];
    var_02[0] = level.lbsniper;
    scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, "aamissile_projectile_mp", var_02);
  }

  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, "aamissile_projectile_mp", level.remote_uav);
  scripts\mp\killstreaks\_killstreaks::func_532A(param_00, param_01, "aamissile_projectile_mp", level.planes);
}