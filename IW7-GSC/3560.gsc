/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3560.gsc
*********************************************/

init() {
  level._effect["sonicPulseImpact"] = loadfx("vfx\iw7\_requests\mp_effects\vfx_force_push_distortion");
}

func_72D3() {
  if(isDefined(self.var_72D2)) {
    self.var_72D2 notify("detonateExplosive");
  }
}

func_72D9(var_0) {
  level endon("game_ended");
  var_1 = var_0.owner.origin;
  var_0 waittill("missile_stuck", var_2);
  if(isDefined(var_2)) {
    if(func_9FE2(var_2)) {
      var_3 = var_2.origin - var_1;
      var_4 = vectornormalize(var_3);
      var_5 = length(var_3);
      if(var_5 < 500) {
        var_6 = spawn("script_model", var_0.origin);
        var_6 setModel("tag_origin");
        var_6.angles = vectortoangles(var_4);
        var_6.owner = self;
        var_6.team = self.team;
        self.var_72D2 = var_6;
        var_7 = 0.4;
        var_8 = 500 - var_5;
        var_9 = var_8 / 500;
        var_10 = var_7 * var_9;
        var_11 = var_6.origin + var_4 * var_8;
        var_6 func_10DE4(var_2, var_4, var_10);
        var_6 endon("forcePushDetonate");
        var_6 thread func_5916(var_11, var_10);
        var_6 thread func_72D8();
        var_6 thread func_72D7();
        wait(var_10);
        var_0 delete();
        var_6 func_72D5();
        return;
      }
    }
  }

  var_6 func_72D4();
}

func_72D5() {
  self notify("forcePushEnd");
  playFX(scripts\engine\utility::getfx("sonicPulseImpact"), self.origin, anglesToForward(self.angles));
  scripts\engine\utility::waitframe();
  self delete();
}

func_72D4(var_0) {
  self notify("forcePushDetonate");
  playFX(scripts\engine\utility::getfx("sonicPulseImpact"), self.origin, anglesToForward(self.angles));
  var_1 = self.var_AD30;
  if(isDefined(var_1)) {
    var_1 stopgestureviewmodel();
    var_1 unlink();
    if(isDefined(var_0)) {
      var_1 setorigin(var_0);
    } else {
      var_0 = self.origin;
    }

    if(isalive(var_1) && isDefined(var_1.var_DB17)) {
      var_1 setvelocity(var_1.var_DB17 * 100);
      var_1.var_DB17 = undefined;
    }

    radiusdamage(var_0, 100, 300, 100, self.owner, "MOD_EXPLOSIVE", "forcepush_mp");
    earthquake(0.75, 0.5, var_0, 100);
  }

  if(isDefined(self.owner)) {
    self.owner.var_72D2 = undefined;
  }

  scripts\engine\utility::waitframe();
  self delete();
}

func_72D8() {
  level endon("game_ended");
  self endon("death");
  self.owner scripts\engine\utility::waittill_any("joined_team", "joined_spectators", "disconnect");
  self notify("detonateExplosive");
}

func_72D7() {
  level endon("game_ended");
  self endon("death");
  self endon("forcePushEnd");
  var_0 = scripts\common\trace::create_character_contents() + physics_createcontents(["physicscontents_solid", "physicscontents_playerclip"]);
  var_1 = self.origin;
  var_2 = [self.owner, self.var_AD30];
  for(;;) {
    scripts\engine\utility::waitframe();
    var_3 = physics_spherecast(var_1, self.origin, 32, var_0, var_2, "physicsquery_closest");
    if(var_3.size > 0) {
      func_72D4(var_3[0]["shape_position"]);
      break;
    }

    var_1 = self.origin;
  }
}

func_72D6() {
  level endon("game_ended");
  self endon("death");
  var_0 = scripts\common\trace::create_character_contents() + physics_createcontents(["physicscontents_solid"]);
  var_1 = self.origin;
  for(;;) {
    scripts\engine\utility::waitframe();
    var_2 = [self.owner];
    if(isDefined(self.var_AD30)) {
      var_2[var_2.size] = self.var_AD30;
    }

    var_3 = physics_spherecast(var_1, self.origin, 32, var_0, var_2, "physicsquery_closest");
    if(var_3.size > 0) {
      var_4 = var_3[0]["entity"];
      if(func_9FE2(var_4)) {
        func_10DE4(var_4);
      } else {
        self notify("detonateExplosive");
        break;
      }
    }

    var_1 = self.origin;
  }
}

func_5916(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self moveto(var_0, var_1);
  scripts\engine\utility::waitframe();
}

func_9FE2(var_0) {
  return !isDefined(self.var_AD30) && isDefined(var_0) && isPlayer(var_0) && var_0 getstance() != "prone";
}

func_10DE4(var_0, var_1, var_2) {
  self.var_AD30 = var_0;
  var_0 playerlinkto(self, "tag_origin", 1);
  self rotateto(self.angles + (0, 180, 0), 0.1);
  var_0.var_DB17 = var_1;
  var_0 shellshock("concussion_grenade_mp", var_2);
  var_0 playgestureviewmodel("ges_hold");
}