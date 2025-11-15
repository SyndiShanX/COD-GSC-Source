/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3560.gsc
************************/

init() {
  level._effect["sonicPulseImpact"] = loadfx("vfx\iw7\_requests\mp_effects\vfx_force_push_distortion");
}

func_72D3() {
  if(isDefined(self.var_72D2)) {
    self.var_72D2 notify("detonateExplosive");
  }
}

func_72D9(param_00) {
  level endon("game_ended");
  var_01 = param_00.triggerportableradarping.origin;
  param_00 waittill("missile_stuck", var_02);
  if(isDefined(var_02)) {
    if(func_9FE2(var_02)) {
      var_03 = var_02.origin - var_01;
      var_04 = vectornormalize(var_03);
      var_05 = length(var_03);
      if(var_05 < 500) {
        var_06 = spawn("script_model", param_00.origin);
        var_06 setModel("tag_origin");
        var_06.angles = vectortoangles(var_04);
        var_06.triggerportableradarping = self;
        var_06.team = self.team;
        self.var_72D2 = var_06;
        var_07 = 0.4;
        var_08 = 500 - var_05;
        var_09 = var_08 / 500;
        var_0A = var_07 * var_09;
        var_0B = var_06.origin + var_04 * var_08;
        var_06 func_10DE4(var_02, var_04, var_0A);
        var_06 endon("forcePushDetonate");
        var_06 thread func_5916(var_0B, var_0A);
        var_06 thread func_72D8();
        var_06 thread func_72D7();
        wait(var_0A);
        param_00 delete();
        var_06 func_72D5();
        return;
      }
    }
  }

  var_06 func_72D4();
}

func_72D5() {
  self notify("forcePushEnd");
  playFX(scripts\engine\utility::getfx("sonicPulseImpact"), self.origin, anglesToForward(self.angles));
  scripts\engine\utility::waitframe();
  self delete();
}

func_72D4(param_00) {
  self notify("forcePushDetonate");
  playFX(scripts\engine\utility::getfx("sonicPulseImpact"), self.origin, anglesToForward(self.angles));
  var_01 = self.var_AD30;
  if(isDefined(var_01)) {
    var_01 stopgestureviewmodel();
    var_01 unlink();
    if(isDefined(param_00)) {
      var_01 setorigin(param_00);
    } else {
      param_00 = self.origin;
    }

    if(isalive(var_01) && isDefined(var_01.var_DB17)) {
      var_01 setvelocity(var_01.var_DB17 * 100);
      var_01.var_DB17 = undefined;
    }

    radiusdamage(param_00, 100, 300, 100, self.triggerportableradarping, "MOD_EXPLOSIVE", "forcepush_mp");
    earthquake(0.75, 0.5, param_00, 100);
  }

  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.var_72D2 = undefined;
  }

  scripts\engine\utility::waitframe();
  self delete();
}

func_72D8() {
  level endon("game_ended");
  self endon("death");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  self notify("detonateExplosive");
}

func_72D7() {
  level endon("game_ended");
  self endon("death");
  self endon("forcePushEnd");
  var_00 = scripts\common\trace::create_character_contents() + physics_createcontents(["physicscontents_solid", "physicscontents_playerclip"]);
  var_01 = self.origin;
  var_02 = [self.triggerportableradarping, self.var_AD30];
  for(;;) {
    scripts\engine\utility::waitframe();
    var_03 = physics_spherecast(var_01, self.origin, 32, var_00, var_02, "physicsquery_closest");
    if(var_03.size > 0) {
      func_72D4(var_03[0]["shape_position"]);
      break;
    }

    var_01 = self.origin;
  }
}

func_72D6() {
  level endon("game_ended");
  self endon("death");
  var_00 = scripts\common\trace::create_character_contents() + physics_createcontents(["physicscontents_solid"]);
  var_01 = self.origin;
  for(;;) {
    scripts\engine\utility::waitframe();
    var_02 = [self.triggerportableradarping];
    if(isDefined(self.var_AD30)) {
      var_02[var_02.size] = self.var_AD30;
    }

    var_03 = physics_spherecast(var_01, self.origin, 32, var_00, var_02, "physicsquery_closest");
    if(var_03.size > 0) {
      var_04 = var_03[0]["entity"];
      if(func_9FE2(var_04)) {
        func_10DE4(var_04);
      } else {
        self notify("detonateExplosive");
        break;
      }
    }

    var_01 = self.origin;
  }
}

func_5916(param_00, param_01) {
  level endon("game_ended");
  self endon("death");
  self moveto(param_00, param_01);
  scripts\engine\utility::waitframe();
}

func_9FE2(param_00) {
  return !isDefined(self.var_AD30) && isDefined(param_00) && isplayer(param_00) && param_00 getstance() != "prone";
}

func_10DE4(param_00, param_01, param_02) {
  self.var_AD30 = param_00;
  param_00 playerlinkto(self, "tag_origin", 1);
  self rotateto(self.angles + (0, 180, 0), 0.1);
  param_00.var_DB17 = param_01;
  param_00 shellshock("concussion_grenade_mp", param_02);
  param_00 playgestureviewmodel("ges_hold");
}