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

func_FC5B(var_0, var_1) {
  self notify("powers_shardBall_used", 1);
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_0 endon("death");
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(!var_1) {
    var_0 waittill("missile_stuck", var_2);
    if(isplayer(var_2) || isagent(var_2)) {
      scripts\mp\weapons::grenadestuckto(var_0, var_2);
    }
  }

  var_0 thread scripts\mp\shellshock::grenade_earthquake();
  var_0 scripts\mp\weapons::explosivehandlemovers(undefined);
  var_0 thread func_13B39();
}

func_13B39() {
  var_0 = self.stuckenemyentity;
  var_1 = self.triggerportableradarping;
  var_2 = self.triggerportableradarping.team;
  var_3 = self.weapon_name;
  var_4 = func_7EA7();
  self waittill("explode", var_5);
  if(!isDefined(var_1)) {
    return;
  }

  playsoundatpos(var_5, "frag_grenade_explode");
  thread func_13B34(var_4, var_1);
  self notify("start_secondary_explosion", var_5);
}

func_7EA7() {
  var_0 = self.angles;
  if(isDefined(self.stuckenemyentity)) {
    var_0 = self.stuckenemyentity.angles;
  }

  return var_0;
}

func_7EA8(var_0, var_1, var_2, var_3) {
  var_4 = 150;
  var_5 = 200;
  var_6 = anglestoup(var_0);
  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  var_7 = var_5 * var_6;
  var_8 = var_1 + var_7;
  var_6 = var_4 * var_6;
  var_9 = var_1 + var_6;
  if(!isDefined(var_3) || !var_3) {
    var_0A = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var_0B = physics_raycast(var_1, var_8, var_0A, undefined, 0, "physicsquery_closest");
    if(var_0B.size > 0) {
      var_0C = var_0B[0]["position"];
      var_9 = var_1 + var_0C / 2;
    }
  }

  return var_9;
}

func_13AEA(var_0) {
  var_0 waittill("death");
  if(isDefined(self)) {
    self delete();
  }
}

func_13A0A(var_0) {
  self waittill("death");
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_13B1F(var_0) {
  self endon("death");
  while(self.origin != var_0) {
    wait(0.05);
  }

  self notify("start_secondary_explosion", var_0);
}

func_13B34(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 endon("disconnect");
  var_1 endon("joined_team");
  var_1 endon("joined_spectators");
  var_6 = "start_secondary_explosion";
  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  self waittill(var_6, var_7);
  playsoundatpos(var_7, "shard_ball_explode_default");
  var_8 = [];
  foreach(var_0A in level.players) {
    if(!isDefined(var_0A)) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_0A)) {
      continue;
    }

    if(var_0A != var_1 && level.teambased && var_1.team != var_0A.team) {
      continue;
    }

    var_8 = scripts\engine\utility::array_add_safe(var_8, var_0A);
  }

  var_0C = var_1 scripts\mp\powerloot::func_7FC4("power_shardBall", 30);
  var_0D = var_1 scripts\mp\powerloot::func_7FC4("power_shardBall", 300);
  var_0E = scripts\engine\utility::get_array_of_closest(var_7, var_8, undefined, undefined, var_0D, var_0C);
  var_0F = 15;
  if(isDefined(var_4)) {
    var_0F = var_4;
  }

  var_10 = var_1 scripts\mp\powerloot::func_7FC2("power_shardBall", var_0F);
  for(var_11 = 0; var_11 < var_10; var_11++) {
    var_12 = dropscavengerbag(var_7, var_0);
    var_13 = undefined;
    if(isDefined(var_0E) && var_0E.size > 0) {
      var_14 = scripts\engine\utility::random(var_0E);
      var_13 = var_14 gettagorigin("j_mainroot");
      var_0E = scripts\engine\utility::array_remove(var_0E, var_14);
    }

    var_1 thread func_6D81(var_7, var_12, var_2, var_13, var_5);
    scripts\engine\utility::waitframe();
  }
}

dropscavengerbag(var_0, var_1) {
  var_2 = anglestoup(var_1);
  var_3 = anglestoright(var_1);
  var_4 = anglesToForward(var_1);
  var_5 = randomint(360);
  var_6 = randomint(360);
  var_7 = cos(var_6) * sin(var_5);
  var_8 = sin(var_6) * sin(var_5);
  var_9 = cos(var_5);
  var_0A = var_7 * var_3 + var_8 * var_4 + var_9 * var_2 / 0.33;
  return var_0A;
}

func_6D81(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  var_5 = var_0 + var_1;
  if(isDefined(var_3)) {
    var_5 = var_3;
  }

  var_6 = scripts\mp\utility::_magicbullet("iw6_semtexshards_mp", var_0, var_5, self);
  var_6.var_1653 = var_4;
  if(isDefined(var_2)) {
    var_6 setentityowner(var_2);
  }

  var_6 waittill("explode", var_7);
  playsoundatpos(var_7, "mp_shard_grenade_impacts");
}

placementfailed(var_0) {
  self notify("powers_shardBall_used", 0);
  scripts\mp\utility::placeequipmentfailed(var_0.weapon_name, 1, var_0.origin);
}