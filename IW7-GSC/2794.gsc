/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2794.gsc
***************************************/

func_FC58() {
  level._effect["shard_ball_rocket_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_shard_ball_launch_trail.vfx");
  level._effect["shard_ball_explosion_shards"] = loadfx("vfx\iw7\_requests\mp\vfx_shard_ball_proj_exp.vfx");
  level._effect["shard_ball_explosion_rocket"] = loadfx("vfx\iw7\_requests\mp\vfx_shard_ball_launch_exp.vfx");
  scripts\mp\powerloot::func_DF06("power_shardBall", ["passive_increased_radius", "passive_increased_entities", "passive_grenade_to_mine"]);
}

func_FC5A() {
  scripts\mp\weapons::makeexplosiveunusable();
  self.owner func_FC5B(self, 1);
  self notify("detonateExplosive", self.owner);
}

func_FC59() {}

func_FC5B(var_00, var_01) {
  self notify("powers_shardBall_used", 1);

  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  var_00 endon("death");

  if(!isalive(self)) {
    var_00 delete();
    return;
  }

  if(!isDefined(var_00)) {
    return;
  }
  if(!var_01) {
    var_00 waittill("missile_stuck", var_02);

    if(isplayer(var_02) || isagent(var_02)) {
      scripts\mp\weapons::grenadestuckto(var_00, var_02);
    }
  }

  var_00 thread scripts\mp\shellshock::grenade_earthquake();
  var_00 scripts\mp\weapons::explosivehandlemovers(undefined);
  var_00 thread func_13B39();
}

func_13B39() {
  var_00 = self.stuckenemyentity;
  var_01 = self.owner;
  var_02 = self.owner.team;
  var_03 = self.weapon_name;
  var_04 = func_7EA7();
  self waittill("explode", var_05);

  if(!isDefined(var_01)) {
    return;
  }
  playLoopSound(var_05, "frag_grenade_explode");
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

func_7EA8(var_00, var_01, var_02, var_03) {
  var_04 = 150;
  var_05 = 200;
  var_06 = anglestoup(var_00);

  if(isDefined(var_02)) {
    var_04 = var_02;
  }

  var_07 = var_05 * var_06;
  var_08 = var_01 + var_07;
  var_06 = var_04 * var_06;
  var_09 = var_01 + var_06;

  if(!isDefined(var_03) || !var_03) {
    var_10 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var_11 = physics_raycast(var_01, var_08, var_10, undefined, 0, "physicsquery_closest");

    if(var_11.size > 0) {
      var_12 = var_11[0]["position"];
      var_09 = (var_01 + var_12) / 2;
    }
  }

  return var_09;
}

func_13AEA(var_00) {
  var_00 waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

func_13A0A(var_00) {
  self waittill("death");

  if(isDefined(var_00)) {
    var_00 delete();
  }
}

func_13B1F(var_00) {
  self endon("death");

  while(self.origin != var_00) {
    wait 0.05;
  }

  self notify("start_secondary_explosion", var_00);
}

func_13B34(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_01 endon("disconnect");
  var_01 endon("joined_team");
  var_01 endon("joined_spectators");
  var_06 = "start_secondary_explosion";

  if(isDefined(var_03)) {
    var_06 = var_03;
  }

  self waittill(var_06, var_07);
  playLoopSound(var_07, "shard_ball_explode_default");
  var_08 = [];

  foreach(var_10 in level.players) {
    if(!isDefined(var_10)) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_10)) {
      continue;
    }
    if(var_10 != var_01 && level.teambased && var_1.team != var_10.team) {
      continue;
    }
    var_08 = scripts\engine\utility::add_to_array(var_08, var_10);
  }

  var_12 = var_01 scripts\mp\powerloot::func_7FC4("power_shardBall", 30);
  var_13 = var_01 scripts\mp\powerloot::func_7FC4("power_shardBall", 300);
  var_14 = scripts\engine\utility::get_array_of_closest(var_07, var_08, undefined, undefined, var_13, var_12);
  var_15 = 15;

  if(isDefined(var_04)) {
    var_15 = var_04;
  }

  var_16 = var_01 scripts\mp\powerloot::func_7FC2("power_shardBall", var_15);

  for(var_17 = 0; var_17 < var_16; var_17++) {
    var_18 = dropscavengerbag(var_07, var_00);
    var_19 = undefined;

    if(isDefined(var_14) && var_14.size > 0) {
      var_20 = scripts\engine\utility::random(var_14);
      var_19 = var_20 gettagorigin("j_mainroot");
      var_14 = scripts\engine\utility::array_remove(var_14, var_20);
    }

    var_01 thread func_6D81(var_07, var_18, var_02, var_19, var_05);
    scripts\engine\utility::waitframe();
  }
}

dropscavengerbag(var_00, var_01) {
  var_02 = anglestoup(var_01);
  var_03 = anglestoright(var_01);
  var_04 = anglesToForward(var_01);
  var_05 = randomint(360);
  var_06 = randomint(360);
  var_07 = cos(var_06) * sin(var_05);
  var_08 = sin(var_06) * sin(var_05);
  var_09 = cos(var_05);
  var_10 = (var_07 * var_03 + var_08 * var_04 + var_09 * var_02) / 0.33;
  return var_10;
}

func_6D81(var_00, var_01, var_02, var_03, var_04) {
  self endon("disconnect");
  var_05 = var_00 + var_01;

  if(isDefined(var_03)) {
    var_05 = var_03;
  }

  var_06 = scripts\mp\utility\game::_magicbullet("iw6_semtexshards_mp", var_00, var_05, self);
  var_6.func_1653 = var_04;

  if(isDefined(var_02)) {
    var_06 setentityowner(var_02);
  }

  var_06 waittill("explode", var_07);
  playLoopSound(var_07, "mp_shard_grenade_impacts");
}

placementfailed(var_00) {
  self notify("powers_shardBall_used", 0);
  scripts\mp\utility\game::placeequipmentfailed(var_0.weapon_name, 1, var_0.origin);
}