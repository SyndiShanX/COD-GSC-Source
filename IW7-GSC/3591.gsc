/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3591.gsc
*********************************************/

init() {
  level._effect["telereap_trail"] = loadfx("vfx\old\_requests\mp_weapons\vfx_knife_tele_start_blue");
  level._effect["telereap_smoke"] = loadfx("vfx\core\smktrail\teleport_smoke_bomb_mp");
  level._effect["dash_dust"] = loadfx("vfx\core\screen\vfx_scrnfx_tocam_slidedust_m");
}

func_83B2() {}

removethinker() {
  self notify("removeTeleReap");
  if(isDefined(self.var_11669)) {
    scripts\mp\utility::outlinedisable(self.var_11669, self.var_11667);
    self.var_11669 = undefined;
    self.var_11667 = undefined;
  }
}

func_130E8() {
  self endon("death");
  self endon("disconnect");
  self endon("removeTeleReap");
  self.powers["power_teleReap"].var_19 = 1;
  if(self ismantling()) {
    self playlocalsound("mp_reap_fail");
    self.powers["power_teleReap"].var_19 = 0;
    return 0;
  }

  var_0 = func_11666();
  if(!var_0) {
    self playlocalsound("mp_reap_fail");
  }

  self.powers["power_teleReap"].var_19 = 0;
  return var_0;
}

func_11666() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = 384;
  var_1 = (0, 0, 32);
  var_2 = self.origin + var_1;
  var_3 = anglesToForward(self.angles);
  var_4 = var_2 + var_3 * var_0;
  var_5 = getclosestpointonnavmesh(var_4);
  if(var_5[2] > self.origin[2] || !self isonground()) {
    if(var_5[2] > self.origin[2] + 64) {
      var_1 = (0, 0, 64);
    }

    var_5 = var_5 + var_1;
    var_2 = self.origin + var_1;
    var_4 = var_5;
  }

  var_6 = [];
  var_6[0] = self;
  var_6[1] = self.var_FC9F;
  var_7 = 0.35;
  var_8 = scripts\common\trace::create_contents(1, 1, 1, 0, 0, 1);
  var_9 = scripts\common\trace::capsule_trace(var_2, var_4, 16, 32, (0, 0, 0), var_6, var_8);
  var_0A = 1;
  if(var_9["fraction"] != 1) {
    var_0A = var_9["fraction"] - 0.05;
    if(var_0A < 0.05) {
      return 0;
    }

    var_4 = var_2 + var_3 * var_0 * var_0A;
    var_7 = var_9["fraction"] * 0.35;
  }

  if(!canspawn(var_4)) {
    for(var_0B = 0; var_0B < 10; var_0B++) {
      var_0A = var_0A / 1.15;
      var_4 = var_2 + var_3 * var_0 * var_0A;
      if(canspawn(var_4)) {
        break;
      }
    }
  }

  self playlocalsound("reaper_dash");
  self playSound("reaper_dash_npc");
  thread func_D504();
  scripts\mp\utility::_magicbullet("iw7_erad_mp", self.origin + (0, 0, 1000), self.origin + (0, 0, 2000), self);
  self playrumbleonentity("damage_heavy");
  earthquake(0.25, 0.25, self.origin, 32);
  self.isreaping++;
  thread func_11668();
  thread func_139E6();
  func_DD92(var_4, var_1, var_7);
  return 1;
}

func_139E6() {
  self endon("death");
  self endon("disconnect");
  self endon("stop_reap");
  level endon("game_ended");
  var_0 = [];
  for(;;) {
    var_1 = func_808B(384);
    foreach(var_3 in var_1) {
      var_4 = 0;
      if(distancesquared(self.origin, var_3.origin) > 2048) {
        continue;
      }

      if(scripts\engine\utility::isprotectedbyriotshield(var_3)) {
        continue;
      }

      if(var_3 scripts\mp\utility::func_9D48("archetype_heavy")) {
        var_5 = self getvelocity();
        var_6 = var_5 * -1;
        var_3 setvelocity(var_6);
      }

      foreach(var_8 in var_0) {
        if(var_8 == var_3) {
          var_4 = 1;
        }
      }

      if(var_4) {
        continue;
      }

      var_3 playrumbleonentity("artillery_rumble");
      self playrumbleonentity("artillery_rumble");
      var_3 dodamage(150, self.origin, self, self, "MOD_MELEE");
      playrumbleonposition("artillery_rumble", self.origin);
      earthquake(0.5, 0.5, self.origin, 256);
      playsoundatpos(self.origin, "slide_impact");
      var_0[var_0.size] = var_3;
      wait(0.05);
    }

    wait(0.05);
  }
}

func_627D() {
  self.var_FCA5 = 1;
  self.var_FC9F.angles = self.angles + (0, 90, 0);
  self.var_FC9F.origin = scripts\mp\archetypes\archreaper::func_36DB(64);
  self.var_FC9F show();
  self.var_FC9F setCanDamage(1);
  thread scripts\mp\archetypes\archreaper::func_BCEE(64);
  thread scripts\mp\archetypes\archreaper::func_FC9C();
  self getradiuspathsighttestnodes();
  self allowjump(0);
  self allowprone(0);
}

func_DD92(var_0, var_1, var_2) {
  var_3 = self.origin + var_1;
  var_4 = scripts\engine\utility::spawn_tag_origin();
  thread func_DD91(self, var_4);
  func_DD93(var_0, var_4, var_1, var_2);
  wait(0.25);
  self.isreaping--;
  self notify("stop_reap");
}

func_DD93(var_0, var_1, var_2, var_3) {
  var_4 = self.origin + var_2;
  var_5 = var_4 - var_0;
  var_6 = lengthsquared(var_5);
  var_7 = self getentityvelocity();
  var_8 = lengthsquared(var_4 - var_0);
  self playerlinkto(var_1, "tag_origin");
  self playlocalsound("synaptic_dash");
  self playSound("synaptic_dash_npc");
  if(var_3 < 0.1) {
    var_9 = 0;
  } else {
    var_9 = 0.1;
  }

  if(var_3 <= 0) {
    var_3 = 0.1;
  }

  if(!isDefined(self.var_11667)) {
    var_1 moveto(var_0, var_3, var_9, 0);
    wait(var_3);
  } else {
    var_0A = func_8089(var_4);
    var_1 moveto(var_0A + var_2, var_3, var_9, 0);
    wait(var_3 / 4);
    var_0A = func_8089(var_4);
    var_1 moveto(var_0A + var_2, var_3, 0, 0);
    wait(var_3 / 4);
    var_0A = func_8089(var_4);
    var_1 moveto(var_0A + var_2, var_3, 0, 0);
    wait(var_3 / 2);
  }

  wait(0.1);
  self unlink();
  self setvelocity(var_7 * 1.3);
  self setstance("stand");
}

func_8089(var_0) {
  var_1 = self.var_11667.origin - var_0;
  var_2 = distance(var_0, self.var_11667.origin);
  var_3 = vectortoangles(var_1);
  var_4 = anglesToForward(var_3);
  var_5 = var_0 + var_4 * var_2 + 100;
  if(capsuletracepassed(var_5, 24, 48, self, 0, 0)) {
    return var_5;
  }

  return self.var_11667.origin;
}

func_D504() {
  self endon("disconnect");
  level endon("game_ended");
  playFXOnTag(scripts\engine\utility::getfx("telereap_trail"), self, "TAG_EYE");
  wait(0.5);
  stopFXOnTag(scripts\engine\utility::getfx("telereap_trail"), self, "TAG_EYE");
}

func_DD91(var_0, var_1) {
  var_0 scripts\engine\utility::waittill_any_3("death", "disconnect", "stop_reap");
  scripts\engine\utility::waitframe();
  if(isDefined(var_1)) {
    var_1 delete();
  }
}

func_808B(var_0) {
  var_1 = [];
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  foreach(var_3 in level.players) {
    if(var_3 == self) {
      continue;
    }

    if(!isDefined(var_3.team)) {
      continue;
    }

    if(var_3.team != scripts\mp\utility::getotherteam(self.team)) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_3)) {
      continue;
    }

    if(var_0 != 0) {
      var_4 = scripts\engine\utility::distance_2d_squared(self.origin, var_3.origin);
      var_5 = var_0 * var_0;
      if(var_4 > var_5) {
        continue;
      }
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

closestenemies(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_1 = 100;
  var_2 = [];
  foreach(var_4 in var_0) {
    var_5 = var_4.origin - self.origin;
    var_6 = anglesToForward(self getplayerangles());
    var_7 = vectordot(var_5, var_6);
    if(var_7 <= 0) {
      continue;
    }

    var_8 = vectornormalize(var_5);
    var_9 = vectornormalize(var_6);
    var_7 = vectordot(var_8, var_9);
    var_4.var_5AC7 = var_7;
    var_2[var_2.size] = var_7;
  }

  var_0B = scripts\mp\utility::quicksort(var_2);
  var_0C = [];
  for(var_0D = 0; var_0D < var_0B.size; var_0D++) {
    foreach(var_0F in var_0) {
      if(isDefined(var_0F.var_5AC7) && var_0F.var_5AC7 == var_0B[var_0D]) {
        var_0C[var_0C.size] = var_0F;
      }
    }
  }

  return var_0C;
}

func_11668() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = [];
  var_1 = [];
  self.var_11667 = undefined;
  var_0 = func_808B(384);
  var_2 = 0;
  if(isDefined(var_0) && var_0.size > 0) {
    if(var_0.size > 1) {
      var_1 = closestenemies(var_0);
    } else {
      var_1 = var_0;
    }
  }

  foreach(var_4 in var_1) {
    var_5 = var_4.origin - self.origin;
    var_6 = anglesToForward(self getplayerangles());
    var_7 = vectordot(var_5, var_6);
    if(var_7 <= 0) {
      continue;
    }

    var_8 = vectornormalize(var_5);
    var_9 = vectornormalize(var_6);
    var_7 = vectordot(var_8, var_9);
    if(var_7 < 0.9) {
      continue;
    }

    var_0A = self getEye();
    var_0B = var_4 getEye();
    var_0C = [];
    var_0C[0] = self;
    var_0C[1] = var_4;
    var_0D = scripts\common\trace::ray_trace_passed(var_0A, var_0B, var_0C);
    if(!var_0D) {
      continue;
    }

    self.var_11667 = var_4;
    var_2 = 1;
    break;
  }

  if(!var_2) {
    self.var_11667 = undefined;
  }
}