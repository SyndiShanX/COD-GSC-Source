/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2789.gsc
***************************************/

func_E4E3() {
  level.func_E4DF = [];
  level._effect["proto_ricochet_temp"] = loadfx("vfx\old\misc\proto_ricochet_temp");
  level._effect["proto_ricochet_shot_temp"] = loadfx("vfx\old\misc\proto_ricochet_shot_temp");
  level.func_E4DF["proto_ricochet_device_mp"] = spawnStruct();
  level.func_E4DF["proto_ricochet_device_mp"].func_C739 = 60;
  level.func_E4DF["proto_ricochet_device_mp"].func_B9DC = ::func_E4E5;
  level.func_E4DF["proto_ricochet_device_mp"].model = "prop_mp_ricochet_temp";
  level.func_E4DF["proto_ricochet_device_mp"].fx = "proto_ricochet_temp";
}

func_E4E9(var_00) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isalive(self)) {
    var_00 delete();
    return;
  }

  var_00 waittill("missile_stuck", var_01);
  var_02 = (var_0.origin[0], var_0.origin[1], var_0.origin[2] + level.func_E4DF[var_0.weapon_name].func_C739);
  var_03 = spawn("script_model", var_02);
  var_03 setModel(level.func_E4DF[var_0.weapon_name].model);
  var_3.angles = var_0.angles;
  var_3.team = self.team;
  var_3.owner = self;
  var_3.grenade = var_00;
  var_04 = (var_2[0], var_2[1], var_2[2] + 12);
  var_3.fx = spawnfx(scripts\engine\utility::getfx(level.func_E4DF[var_0.weapon_name].fx), var_04);
  triggerfx(var_3.fx);
  var_05 = 16;
  var_06 = anglestoup(var_3.angles);
  var_06 = var_05 * var_06;
  var_07 = var_3.origin + var_06;
  var_3.trigger = spawn("script_origin", var_07);
  var_3.trigger linkto(var_03);
  var_03 setCanDamage(1);
  var_03 thread func_E4E0(self);
  var_03 thread[[level.func_E4DF[var_0.weapon_name].func_B9DC]](self);
  var_03 setotherent(self);
}

func_E4E8() {
  if(isDefined(self.grenade)) {
    self.grenade delete();
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
    wait 1;
  }

  wait 6.0;
  func_E4E8();
}

func_E4E0(var_00) {
  scripts\mp\damage::monitordamage(100, "trophy", ::func_E4E2, ::func_E4E4, 0);
}

func_E4E4(var_00, var_01, var_02, var_03, var_04) {
  return 0;
}

func_E4E2(var_00, var_01, var_02, var_03) {
  if(isDefined(self.owner) && var_00 != self.owner) {
    var_00 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_E4E5(var_00) {
  var_00 endon("disconnect");
  self endon("death");
  thread func_E4E7();

  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
    var_11 = func_E4E1(var_04, var_03);

    if(isDefined(var_11)) {
      var_12 = var_04 + var_11 * 5000;

      if(getdvarint("scr_ric_debug", 0) == 1) {}

      if(getdvarint("scr_ric_debug", 0) != 1) {
        scripts\mp\utility\game::_magicbullet(var_10, var_04, var_12, var_00);
      }

      var_13 = scripts\engine\utility::getfx("proto_ricochet_shot_temp");
      playFX(var_13, var_04, var_11 * -1, (0, 0, 1));
    }
  }
}

func_E4E1(var_00, var_01) {
  var_02 = (var_1[0], var_1[1], 0);
  var_03 = getdvarfloat("scr_ric_spread", 7);
  var_04 = undefined;
  var_05 = 50000;

  foreach(var_07 in level.players) {
    if(!scripts\mp\utility\game::isreallyalive(var_07)) {
      continue;
    }
    if(var_7.team == self.team) {
      continue;
    }
    var_08 = (var_7.origin[0], var_7.origin[1], var_7.origin[2] + 36);
    var_09 = var_08 - var_00;
    var_10 = distance(var_7.origin, var_00);
    var_09 = var_09 * (1.0 / var_10);
    var_11 = vectordot(var_09, var_01);

    if(abs(var_11) < 0.707) {
      if(var_10 < 500) {
        if(var_10 < var_05) {
          var_04 = var_08;
          var_05 = var_10;
        }
      }
    }
  }

  if(isDefined(var_04)) {
    var_09 = var_04 - var_00;
    var_09 = var_09 * (1.0 / var_05);
    var_13 = randomfloatrange(-180, 180);
    var_14 = vectorcross((0, 0, 1), var_09);
    var_15 = vectorcross(var_09, var_14);
    var_16 = sin(var_13);
    var_17 = cos(var_13);
    var_18 = randomfloatrange(var_03 * -1, var_03);
    var_18 = _tan(var_18);
    var_19 = (var_14 * var_17 + var_15 * var_16) * var_18 + var_09;
    return var_19;
  }
}