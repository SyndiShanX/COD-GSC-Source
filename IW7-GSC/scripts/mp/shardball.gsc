/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\shardball.gsc
************************************/

func_FC58() {
  level._effect["shard_ball_rocket_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_shard_ball_launch_trail.vfx");
  level._effect["shard_ball_explosion_shards"] = loadfx("vfx\iw7\_requests\mp\vfx_shard_ball_proj_exp.vfx");
  level._effect["shard_ball_explosion_rocket"] = loadfx("vfx\iw7\_requests\mp\vfx_shard_ball_launch_exp.vfx");
  scripts\mp\powerloot::func_DF06("power_shardBall", ["passive_increased_radius", "passive_increased_entities", "passive_grenade_to_mine"]);
}

func_FC5A() {
  scripts\mp\weapons::makeexplosiveunusable();
  self.triggerportableradarping func_FC5B(self, 1);
  self notify("detonateExplosive", self.triggerportableradarping);
}

func_FC59() {}

func_FC5B(param_00, param_01) {
  self notify("powers_shardBall_used", 1);
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  param_00 endon("death");
  if(!isalive(self)) {
    param_00 delete();
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  if(!param_01) {
    param_00 waittill("missile_stuck", var_02);
    if(isplayer(var_02) || isagent(var_02)) {
      scripts\mp\weapons::grenadestuckto(param_00, var_02);
    }
  }

  param_00 thread scripts\mp\shellshock::grenade_earthquake();
  param_00 scripts\mp\weapons::explosivehandlemovers(undefined);
  param_00 thread func_13B39();
}

func_13B39() {
  var_00 = self.stuckenemyentity;
  var_01 = self.triggerportableradarping;
  var_02 = self.triggerportableradarping.team;
  var_03 = self.weapon_name;
  var_04 = func_7EA7();
  self waittill("explode", var_05);
  if(!isDefined(var_01)) {
    return;
  }

  playsoundatpos(var_05, "frag_grenade_explode");
  thread func_13B34(var_04, var_01);
  self notify("start_secondary_explosion", var_05);
}

func_7EA7() {
  var_00 = self.angles;
  if(isDefined(self.stuckenemyentity)) {
    var_00 = self.stuckenemyentity.angles;
  }

  return var_00;
}

func_7EA8(param_00, param_01, param_02, param_03) {
  var_04 = 150;
  var_05 = 200;
  var_06 = anglestoup(param_00);
  if(isDefined(param_02)) {
    var_04 = param_02;
  }

  var_07 = var_05 * var_06;
  var_08 = param_01 + var_07;
  var_06 = var_04 * var_06;
  var_09 = param_01 + var_06;
  if(!isDefined(param_03) || !param_03) {
    var_0A = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var_0B = physics_raycast(param_01, var_08, var_0A, undefined, 0, "physicsquery_closest");
    if(var_0B.size > 0) {
      var_0C = var_0B[0]["position"];
      var_09 = param_01 + var_0C / 2;
    }
  }

  return var_09;
}

func_13AEA(param_00) {
  param_00 waittill("death");
  if(isDefined(self)) {
    self delete();
  }
}

func_13A0A(param_00) {
  self waittill("death");
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_13B1F(param_00) {
  self endon("death");
  while(self.origin != param_00) {
    wait(0.05);
  }

  self notify("start_secondary_explosion", param_00);
}

func_13B34(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_01 endon("disconnect");
  param_01 endon("joined_team");
  param_01 endon("joined_spectators");
  var_06 = "start_secondary_explosion";
  if(isDefined(param_03)) {
    var_06 = param_03;
  }

  self waittill(var_06, var_07);
  playsoundatpos(var_07, "shard_ball_explode_default");
  var_08 = [];
  foreach(var_0A in level.players) {
    if(!isDefined(var_0A)) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_0A)) {
      continue;
    }

    if(var_0A != param_01 && level.teambased && param_01.team != var_0A.team) {
      continue;
    }

    var_08 = scripts\engine\utility::array_add_safe(var_08, var_0A);
  }

  var_0C = param_01 scripts\mp\powerloot::func_7FC4("power_shardBall", 30);
  var_0D = param_01 scripts\mp\powerloot::func_7FC4("power_shardBall", 300);
  var_0E = scripts\engine\utility::get_array_of_closest(var_07, var_08, undefined, undefined, var_0D, var_0C);
  var_0F = 15;
  if(isDefined(param_04)) {
    var_0F = param_04;
  }

  var_10 = param_01 scripts\mp\powerloot::func_7FC2("power_shardBall", var_0F);
  for(var_11 = 0; var_11 < var_10; var_11++) {
    var_12 = dropscavengerbag(var_07, param_00);
    var_13 = undefined;
    if(isDefined(var_0E) && var_0E.size > 0) {
      var_14 = scripts\engine\utility::random(var_0E);
      var_13 = var_14 gettagorigin("j_mainroot");
      var_0E = scripts\engine\utility::array_remove(var_0E, var_14);
    }

    param_01 thread func_6D81(var_07, var_12, param_02, var_13, param_05);
    scripts\engine\utility::waitframe();
  }
}

dropscavengerbag(param_00, param_01) {
  var_02 = anglestoup(param_01);
  var_03 = anglestoright(param_01);
  var_04 = anglesToForward(param_01);
  var_05 = randomint(360);
  var_06 = randomint(360);
  var_07 = cos(var_06) * sin(var_05);
  var_08 = sin(var_06) * sin(var_05);
  var_09 = cos(var_05);
  var_0A = var_07 * var_03 + var_08 * var_04 + var_09 * var_02 / 0.33;
  return var_0A;
}

func_6D81(param_00, param_01, param_02, param_03, param_04) {
  self endon("disconnect");
  var_05 = param_00 + param_01;
  if(isDefined(param_03)) {
    var_05 = param_03;
  }

  var_06 = scripts\mp\utility::_magicbullet("iw6_semtexshards_mp", param_00, var_05, self);
  var_06.var_1653 = param_04;
  if(isDefined(param_02)) {
    var_06 setentityowner(param_02);
  }

  var_06 waittill("explode", var_07);
  playsoundatpos(var_07, "mp_shard_grenade_impacts");
}

placementfailed(param_00) {
  self notify("powers_shardBall_used", 0);
  scripts\mp\utility::placeequipmentfailed(param_00.weapon_name, 1, param_00.origin);
}