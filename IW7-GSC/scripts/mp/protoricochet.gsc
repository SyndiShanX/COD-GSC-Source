/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\protoricochet.gsc
*********************************************/

func_E4E3() {
  level.var_E4DF = [];
  level._effect["proto_ricochet_temp"] = loadfx("vfx\old\misc\proto_ricochet_temp");
  level._effect["proto_ricochet_shot_temp"] = loadfx("vfx\old\misc\proto_ricochet_shot_temp");
  level.var_E4DF["proto_ricochet_device_mp"] = spawnStruct();
  level.var_E4DF["proto_ricochet_device_mp"].var_C739 = 60;
  level.var_E4DF["proto_ricochet_device_mp"].var_B9DC = ::func_E4E5;
  level.var_E4DF["proto_ricochet_device_mp"].model = "prop_mp_ricochet_temp";
  level.var_E4DF["proto_ricochet_device_mp"].fx = "proto_ricochet_temp";
}

func_E4E9(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  var_0 waittill("missile_stuck", var_1);
  var_2 = (var_0.origin[0], var_0.origin[1], var_0.origin[2] + level.var_E4DF[var_0.weapon_name].var_C739);
  var_3 = spawn("script_model", var_2);
  var_3 setModel(level.var_E4DF[var_0.weapon_name].model);
  var_3.angles = var_0.angles;
  var_3.team = self.team;
  var_3.owner = self;
  var_3.objective_position = var_0;
  var_4 = (var_2[0], var_2[1], var_2[2] + 12);
  var_3.fx = spawnfx(scripts\engine\utility::getfx(level.var_E4DF[var_0.weapon_name].fx), var_4);
  triggerfx(var_3.fx);
  var_5 = 16;
  var_6 = anglestoup(var_3.angles);
  var_6 = var_5 * var_6;
  var_7 = var_3.origin + var_6;
  var_3.trigger = spawn("script_origin", var_7);
  var_3.trigger linkto(var_3);
  var_3 setCanDamage(1);
  var_3 thread func_E4E0(self);
  var_3 thread[[level.var_E4DF[var_0.weapon_name].var_B9DC]](self);
  var_3 setotherent(self);
}

func_E4E8() {
  if(isDefined(self.objective_position)) {
    self.objective_position delete();
  }

  if(isDefined(self.fx)) {
    self.fx delete();
  }

  self delete();
  self notify("death");
}

func_E4E7() {
  self endon("death");
  while(getdvarint("scr_ric_debug", 0) == 1) {
    wait(1);
  }

  wait(6);
  func_E4E8();
}

func_E4E0(var_0) {
  scripts\mp\damage::monitordamage(100, "trophy", ::func_E4E2, ::func_E4E4, 0);
}

func_E4E4(var_0, var_1, var_2, var_3, var_4) {
  return 0;
}

func_E4E2(var_0, var_1, var_2, var_3) {
  if(isDefined(self.owner) && var_0 != self.owner) {
    var_0 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_E4E5(var_0) {
  var_0 endon("disconnect");
  self endon("death");
  thread func_E4E7();
  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_11 = func_E4E1(var_4, var_3);
    if(isDefined(var_11)) {
      var_12 = var_4 + var_11 * 5000;
      if(getdvarint("scr_ric_debug", 0) == 1) {}

      if(getdvarint("scr_ric_debug", 0) != 1) {
        scripts\mp\utility::_magicbullet(var_10, var_4, var_12, var_0);
      }

      var_13 = scripts\engine\utility::getfx("proto_ricochet_shot_temp");
      playFX(var_13, var_4, var_11 * -1, (0, 0, 1));
    }
  }
}

func_E4E1(var_0, var_1) {
  var_2 = (var_1[0], var_1[1], 0);
  var_3 = getdvarfloat("scr_ric_spread", 7);
  var_4 = undefined;
  var_5 = -15536;
  foreach(var_7 in level.players) {
    if(!scripts\mp\utility::isreallyalive(var_7)) {
      continue;
    }

    if(var_7.team == self.team) {
      continue;
    }

    var_8 = (var_7.origin[0], var_7.origin[1], var_7.origin[2] + 36);
    var_9 = var_8 - var_0;
    var_10 = distance(var_7.origin, var_0);
    var_9 = var_9 * 1 / var_10;
    var_11 = vectordot(var_9, var_1);
    if(abs(var_11) < 0.707) {
      if(var_10 < 500) {
        if(var_10 < var_5) {
          var_4 = var_8;
          var_5 = var_10;
        }
      }
    }
  }

  if(isDefined(var_4)) {
    var_9 = var_4 - var_0;
    var_9 = var_9 * 1 / var_5;
    var_13 = randomfloatrange(-180, 180);
    var_14 = vectorcross((0, 0, 1), var_9);
    var_15 = vectorcross(var_9, var_14);
    var_10 = sin(var_13);
    var_11 = cos(var_13);
    var_12 = randomfloatrange(var_3 * -1, var_3);
    var_12 = tan(var_12);
    var_13 = var_14 * var_11 + var_15 * var_10 * var_12 + var_9;
    return var_13;
  }
}