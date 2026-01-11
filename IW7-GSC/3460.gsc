/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3460.gsc
***************************************/

init() {
  var_00 = spawnStruct();
  var_0.func_B923 = [];
  var_0.func_B923["allies"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_0.func_B923["axis"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_0.inboundsfx = "veh_mig29_dist_loop";
  var_0.compassiconfriendly = "compass_objpoint_airstrike_friendly";
  var_0.compassiconenemy = "compass_objpoint_airstrike_busy";
  var_0.speed = 4000;
  var_0.halfdistance = 20000;
  var_0.func_5715 = 4000;
  var_0.heightrange = 250;
  var_0.func_C23A = 3;
  var_0.outboundflightanim = "airstrike_mp_roll";
  var_0.sonicboomsfx = "veh_mig29_sonic_boom";
  var_0.onattackdelegate = ::func_24D8;
  var_0.onflybycompletedelegate = ::cleanupgamemodes;
  var_0.scorepopup = "destroyed_air_superiority";
  var_0.callout = "callout_destroyed_air_superiority";
  var_0.vodestroyed = undefined;
  var_0.killcamoffset = (-800, 0, 200);
  level.planeconfigs["air_superiority"] = var_00;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("air_superiority", ::onuse);
  level.teamairdenied["axis"] = 0;
  level.teamairdenied["allies"] = 0;
}

onuse(var_00) {
  var_01 = scripts\mp\utility\game::getotherteam(self.team);

  if(level.teambased && level.teamairdenied[var_01] || !level.teambased && isDefined(level.airdeniedplayer) && level.airdeniedplayer == self) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else {
    thread dostrike(var_0.lifeid, "air_superiority");
    scripts\mp\matchdata::logkillstreakevent("air_superiority", self.origin);
    thread scripts\mp\utility\game::teamplayercardsplash("used_air_superiority", self);
    return 1;
  }
}

dostrike(var_00, var_01) {
  var_02 = level.planeconfigs[var_01];
  var_03 = scripts\mp\killstreaks\plane::_meth_8069(var_2.func_5715);
  wait 1;
  var_04 = scripts\mp\utility\game::getotherteam(self.team);
  level.teamairdenied[var_04] = 1;
  level.airdeniedplayer = self;
  dooneflyby(var_01, var_00, var_3.targetpos, var_3.func_6F25, var_3.height);
  self waittill("aa_flyby_complete");
  wait 2;
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(isDefined(self)) {
    dooneflyby(var_01, var_00, var_3.targetpos, -1 * var_3.func_6F25, var_3.height);
    self waittill("aa_flyby_complete");
  }

  level.teamairdenied[var_04] = 0;
  level.airdeniedplayer = undefined;
}

dooneflyby(var_00, var_01, var_02, var_03, var_04) {
  var_05 = level.planeconfigs[var_00];
  var_06 = scripts\mp\killstreaks\plane::getflightpath(var_02, var_03, var_5.halfdistance, 1, var_04, var_5.speed, -0.5 * var_5.halfdistance, var_00);
  level thread scripts\mp\killstreaks\plane::doflyby(var_01, self, var_01, var_6["startPoint"] + (0, 0, randomint(var_5.heightrange)), var_6["endPoint"] + (0, 0, randomint(var_5.heightrange)), var_6["attackTime"], var_6["flyTime"], var_03, var_00);
}

func_24D8(var_00, var_01, var_02, var_03, var_04) {
  self endon("death");
  self.owner endon("killstreak_disowned");
  level endon("game_ended");
  wait(var_02);
  var_05 = func_6CAA(self.owner, self.team);
  var_06 = level.planeconfigs[var_04];
  var_07 = var_6.func_C23A;

  for(var_08 = var_5.size - 1; var_08 >= 0 && var_07 > 0; var_8--) {
    var_09 = var_5[var_08];

    if(isDefined(var_09) && isalive(var_09)) {
      fireattarget(var_09);
      var_7--;
      wait 1;
    }
  }
}

cleanupgamemodes(var_00, var_01, var_02) {
  var_00 notify("aa_flyby_complete");
}

func_6CC8(var_00, var_01, var_02, var_03, var_04) {
  if(isDefined(var_03)) {
    foreach(var_06 in var_03) {
      if([[var_02]](var_00, var_01, var_06))
        var_4.targets[var_4.targets.size] = var_06;
    }
  }

  return var_04;
}

func_6CAA(var_00, var_01) {
  var_02 = spawnStruct();
  var_2.targets = [];
  var_03 = undefined;

  if(level.teambased) {
    var_03 = scripts\mp\utility\game::func_9FE7;
  } else {
    var_03 = scripts\mp\utility\game::func_9FD8;
  }

  var_04 = undefined;

  if(isDefined(var_01)) {
    var_04 = scripts\mp\utility\game::getotherteam(var_01);
  }

  func_6CC8(var_00, var_04, var_03, level.heli_pilot, var_02);

  if(isDefined(level.lbsniper)) {
    if([
        [var_03]
      ](var_00, var_04, level.lbsniper))
      var_2.targets[var_2.targets.size] = level.lbsniper;
  }

  func_6CC8(var_00, var_04, var_03, level.planes, var_02);
  func_6CC8(var_00, var_04, var_03, level.littlebirds, var_02);
  func_6CC8(var_00, var_04, var_03, level.helis, var_02);
  return var_2.targets;
}

fireattarget(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  var_01 = undefined;

  if(isDefined(self.owner)) {
    var_01 = self.owner;
  }

  var_02 = 384 * anglesToForward(self.angles);
  var_03 = self gettagorigin("tag_missile_1") + var_02;
  var_04 = scripts\mp\utility\game::_magicbullet("aamissile_projectile_mp", var_03, var_03 + var_02, var_01);
  var_4.vehicle_fired_from = self;
  var_03 = self gettagorigin("tag_missile_2") + var_02;
  var_05 = scripts\mp\utility\game::_magicbullet("aamissile_projectile_mp", var_03, var_03 + var_02, var_01);
  var_5.vehicle_fired_from = self;
  var_06 = [var_04, var_05];
  var_00 notify("targeted_by_incoming_missile", var_06);
  thread func_10DC4(var_00, 0.25, var_06);
}

func_10DC4(var_00, var_01, var_02) {
  wait(var_01);

  if(isDefined(var_00)) {
    var_03 = undefined;

    if(var_0.model != "vehicle_av8b_harrier_jet_mp") {
      var_03 = var_00 gettagorigin("tag_missile_target");
    }

    if(!isDefined(var_03)) {
      var_03 = var_00 gettagorigin("tag_body");
    }

    var_04 = var_03 - var_0.origin;

    foreach(var_06 in var_02) {
      if(isvalidmissile(var_06)) {
        var_06 missile_settargetent(var_00, var_04);
        var_06 missile_setflightmodedirect();
      }
    }
  }
}

func_52CA(var_00, var_01) {
  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, "aamissile_projectile_mp", level.helis);
  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, "aamissile_projectile_mp", level.littlebirds);
  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, "aamissile_projectile_mp", level.heli_pilot);

  if(isDefined(level.lbsniper)) {
    var_02 = [];
    var_2[0] = level.lbsniper;
    scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, "aamissile_projectile_mp", var_02);
  }

  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, "aamissile_projectile_mp", level.remote_uav);
  scripts\mp\killstreaks\killstreaks::func_532A(var_00, var_01, "aamissile_projectile_mp", level.planes);
}