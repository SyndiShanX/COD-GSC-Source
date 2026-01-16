/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: common_scripts\_pipes.gsc
********************************/

main() {
  waittillframeend;
  var_0 = getentarray("pipe_shootable", "targetname");

  if(!var_0.size) {
    return;
  }
  level.num_pipe_fx = 0;
  level.limit_pipe_fx = 32;
  var_0 thread precachefx();
  var_0 thread methodsinit();
  common_scripts\utility::array_thread(var_0, ::pipesetup);
  var_1 = var_0;
  var_2 = getentarray("pipe_break", "targetname");

  if(var_2.size) {
    var_2 pipebreakinit(var_1);
    pipemasterinit(var_2);
    common_scripts\utility::array_thread(var_2, ::pipebreakthink);
  }

  level.overlaymaskfxwastriggered = 0;
}

methodsinit() {
  level._pipe_methods = [];
  level._pipe_methods["MOD_UNKNOWN"] = ::pipe_calc_splash;
  level._pipe_methods["MOD_PISTOL_BULLET"] = ::pipe_calc_ballistic;
  level._pipe_methods["MOD_RIFLE_BULLET"] = ::pipe_calc_ballistic;
  level._pipe_methods["MOD_GRENADE"] = ::pipe_calc_splash;
  level._pipe_methods["MOD_GRENADE_SPLASH"] = ::pipe_calc_splash;
  level._pipe_methods["MOD_PROJECTILE"] = ::pipe_calc_splash;
  level._pipe_methods["MOD_PROJECTILE_SPLASH"] = ::pipe_calc_splash;
  level._pipe_methods["MOD_MELEE"] = ::pipe_calc_nofx;
  level._pipe_methods["MOD_HEAD_SHOT"] = ::pipe_calc_nofx;
  level._pipe_methods["MOD_CRUSH"] = ::pipe_calc_nofx;
  level._pipe_methods["MOD_TELEFRAG"] = ::pipe_calc_nofx;
  level._pipe_methods["MOD_FALLING"] = ::pipe_calc_nofx;
  level._pipe_methods["MOD_SUICIDE"] = ::pipe_calc_nofx;
  level._pipe_methods["MOD_TRIGGER_HURT"] = ::pipe_calc_splash;
  level._pipe_methods["MOD_EXPLOSIVE"] = ::pipe_calc_splash;
  level._pipe_methods["MOD_IMPACT"] = ::pipe_calc_nofx;
}

pipe_calc_ballistic(var_0, var_1) {
  return var_0;
}

pipe_calc_splash(var_0, var_1) {
  if(self.use_bullet_hitnormal)
    return undefined;

  var_2 = vectornormalize(vectorfromlinetopoint(self.a, self.b, var_0));
  var_0 = pointonsegmentnearesttopoint(self.a, self.b, var_0);
  return var_0 + common_scripts\utility::vectorscale(var_2, 4);
}

pipe_calc_nofx(var_0, var_1) {
  return undefined;
}

pipe_calc_assert(var_0, var_1) {}

pipemasterinit(var_0) {
  level.pipe_breaks = var_0;

  while (level.pipe_breaks.size) {
    var_1 = level.pipe_breaks[level.pipe_breaks.size - 1];
    var_2 = spawnstruct();
    var_2.name = "pipe master at (" + var_1.origin + ") position";
    var_1.master = var_2;
    level.pipe_breaks = common_scripts\utility::array_remove(level.pipe_breaks, var_1);
    var_2 pipemasteriterate(var_1);
  }
}

pipemasteriterate(var_0) {
  var_1 = get_pipes_in_range(var_0, level.pipe_breaks);

  if(!isdefined(var_1) || var_1.size == 0) {
    return;
  }
  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2].master = self;
    level.pipe_breaks = common_scripts\utility::array_remove(level.pipe_breaks, var_1[var_2]);
  }

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    pipemasteriterate(var_1[var_2]);
}

get_pipes_in_range(var_0, var_1) {
  var_2 = 34;

  if(var_1.size < 1) {
    return;
  }
  var_3 = [];
  var_4 = 0;

  for (var_5 = 0; var_5 < var_1.size; var_5++) {
    var_4 = 0;

    for (var_6 = 0; var_6 < var_1[var_5].ends.size; var_6++) {
      for (var_7 = 0; var_7 < var_0.ends.size; var_7++) {
        var_8 = distance(var_1[var_5].ends[var_6], var_0.ends[var_7]);

        if(var_8 > var_2) {
          continue;
        }
        var_4 = 1;
        var_3[var_3.size] = var_1[var_5];
        break;
      }

      if(var_4) {
        break;
      }
    }
  }

  return var_3;
}

pipebreakinit(var_0) {
  for (var_1 = 0; var_1 < self.size; var_1++) {
    self[var_1].whole = common_scripts\utility::getclosest(self[var_1] getorigin(), var_0);
    var_0 = common_scripts\utility::array_remove(var_0, self[var_1].whole);
    self[var_1].fxnode = spawnstruct();
    self[var_1].fxnode.origin = self[var_1].origin;
    self[var_1].fxnode.forward = common_scripts\utility::vectorscale(anglestoright(self[var_1].angles), -1);
    self[var_1].fxnode.up = anglestoforward(self[var_1].angles);

    if(self[var_1].script_noteworthy == "fueltanker") {
      var_2 = common_scripts\utility::getstruct(self[var_1].whole.target, "targetname");
      self[var_1].fxnode.origin = var_2.origin;
      self[var_1].fxnode.forward = anglestoup(var_2.angles);
      self[var_1].fxnode.up = anglestoforward(var_2.angles);
      self[var_1].fxnode.right = anglestoright(var_2.angles);
    }

    self[var_1].hurtnode = [];

    switch (self[var_1].script_noteworthy) {
      case "fire64":
        self[var_1].hurtnode[self[var_1].hurtnode.size] = self[var_1].fxnode.origin;
        break;
      case "fire96":
        var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, 16);
        self[var_1].hurtnode[self[var_1].hurtnode.size] = self[var_1].fxnode.origin + var_3;
        var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, -16);
        self[var_1].hurtnode[self[var_1].hurtnode.size] = self[var_1].fxnode.origin + var_3;
        break;
      case "fire128":
        var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, 32);
        self[var_1].hurtnode[self[var_1].hurtnode.size] = self[var_1].fxnode.origin + var_3;
        var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, -32);
        self[var_1].hurtnode[self[var_1].hurtnode.size] = self[var_1].fxnode.origin + var_3;
        break;
      case "fire256":
        self[var_1].fx_multinode = [];
        var_4 = spawnstruct();
        var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, 64);
        var_4.origin = self[var_1].fxnode.origin + var_3;
        var_4.forward = self[var_1].fxnode.forward;
        var_4.up = self[var_1].fxnode.up;
        self[var_1].fx_multinode[self[var_1].fx_multinode.size] = var_4;
        var_4 = spawnstruct();
        var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, -64);
        var_4.origin = self[var_1].fxnode.origin + var_3;
        var_4.forward = self[var_1].fxnode.forward;
        var_4.up = self[var_1].fxnode.up;
        self[var_1].fx_multinode[self[var_1].fx_multinode.size] = var_4;
        var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, 64);
        self[var_1].hurtnode[self[var_1].hurtnode.size] = self[var_1].fxnode.origin + var_3;
        var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, -64);
        self[var_1].hurtnode[self[var_1].hurtnode.size] = self[var_1].fxnode.origin + var_3;
        break;
      case "fueltanker":
        self[var_1].fx_multinode = [];
        self[var_1].fx_multinode[self[var_1].fx_multinode.size] = self[var_1].fxnode;
        var_5 = spawnstruct();
        var_5.origin = self[var_1].fxnode.origin;
        var_5.up = self[var_1].fxnode.up;
        var_5.forward = self[var_1].fxnode.forward + common_scripts\utility::vectorscale(self[var_1].fxnode.right, 1);
        self[var_1].fx_multinode[self[var_1].fx_multinode.size] = var_5;
        var_5 = spawnstruct();
        var_5.origin = self[var_1].fxnode.origin;
        var_5.up = self[var_1].fxnode.up;
        var_5.forward = self[var_1].fxnode.forward + common_scripts\utility::vectorscale(self[var_1].fxnode.right, -1);
        self[var_1].fx_multinode[self[var_1].fx_multinode.size] = var_5;
        var_4 = spawnstruct();
        var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, 112);
        var_4.origin = self[var_1].fxnode.origin + var_3;
        var_4.forward = self[var_1].fxnode.forward;
        var_4.up = self[var_1].fxnode.up;
        self[var_1].fx_multinode[self[var_1].fx_multinode.size] = var_4;
        var_5 = spawnstruct();
        var_5.origin = var_4.origin;
        var_5.up = var_4.up;
        var_5.forward = var_4.forward + common_scripts\utility::vectorscale(self[var_1].fxnode.right, 1);
        self[var_1].fx_multinode[self[var_1].fx_multinode.size] = var_5;
        var_5 = spawnstruct();
        var_5.origin = var_4.origin;
        var_5.up = var_4.up;
        var_5.forward = var_4.forward + common_scripts\utility::vectorscale(self[var_1].fxnode.right, -1);
        self[var_1].fx_multinode[self[var_1].fx_multinode.size] = var_5;
        var_4 = spawnstruct();
        var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, -112);
        var_4.origin = self[var_1].fxnode.origin + var_3;
        var_4.forward = self[var_1].fxnode.forward;
        var_4.up = self[var_1].fxnode.up;
        self[var_1].fx_multinode[self[var_1].fx_multinode.size] = var_4;
        var_5 = spawnstruct();
        var_5.origin = var_4.origin;
        var_5.up = var_4.up;
        var_5.forward = var_4.forward + common_scripts\utility::vectorscale(self[var_1].fxnode.right, 1);
        self[var_1].fx_multinode[self[var_1].fx_multinode.size] = var_5;
        var_5 = spawnstruct();
        var_5.origin = var_4.origin;
        var_5.up = var_4.up;
        var_5.forward = var_4.forward + common_scripts\utility::vectorscale(self[var_1].fxnode.right, -1);
        self[var_1].fx_multinode[self[var_1].fx_multinode.size] = var_5;
        self[var_1].hurtnode[self[var_1].hurtnode.size] = self[var_1].fxnode.origin;
        var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, 184);
        self[var_1].hurtnode[self[var_1].hurtnode.size] = self[var_1].fxnode.origin + var_3;
        var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, -184);
        self[var_1].hurtnode[self[var_1].hurtnode.size] = self[var_1].fxnode.origin + var_3;
        break;
    }

    self[var_1].ends = [];
    var_6 = 0;

    switch (self[var_1].script_noteworthy) {
      case "fire64":
        var_6 = 32;
        break;
      case "fire96":
        var_6 = 48;
        break;
      case "fire128":
        var_6 = 64;
        break;
      case "fire256":
        var_6 = 128;
        break;
      case "fueltanker":
        var_6 = 184;
        break;
    }

    self[var_1].ends[self[var_1].ends.size] = self[var_1].fxnode.origin;
    var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, var_6);
    self[var_1].ends[self[var_1].ends.size] = self[var_1].fxnode.origin + var_3;
    var_3 = common_scripts\utility::vectorscale(self[var_1].fxnode.up, var_6 * -1);
    self[var_1].ends[self[var_1].ends.size] = self[var_1].fxnode.origin + var_3;
  }
}

pipebreak_damage() {
  var_0 = 1;
  var_1 = 250;
  var_2 = 200;

  if(self.script_noteworthy == "fueltanker")
    var_2 = 350;

  for (var_3 = 0; var_3 < self.hurtnode.size; var_3++)
    radiusdamage(self.hurtnode[var_3], var_2, var_1, var_0);
}

pipebreakthink() {
  self.use_bullet_hitnormal = 0;
  self hide();
  self notsolid();
  thread pipebreakthink2();
  thread pipebreakthink3();
  thread pipebreakthink4();
  self.whole endon("pipe_breaking");

  for (;;) {
    self.whole waittill("pipe_ruptured");
    badplace_cylinder("", 2, self.whole.origin, 250, 250);
    self.master notify("pipe_ruptured");
    thread pipebreakthink2();
  }
}

pipebreakthink2() {
  self.whole endon("pipe_ruptured");
  self.whole endon("deleting");
  self.master waittill("pipe_ruptured");
  self.whole.numfx++;
  thread pipebreakthink2();
}

pipebreakthink3() {
  self.whole endon("pipe_breaking");
  self.master waittill("hurtme");
  wait(randomfloat(0.2));
  self.whole notify("pipe_breaking");
}

pipebreakthink4() {
  self.whole waittill("pipe_breaking");
  self.master notify("hurtme");

  switch (self.script_noteworthy) {
    case "fueltanker":
      thread common_scripts\utility::play_sound_in_space("explo_rock", self.fxnode.origin);
      break;
    default:
      if(isdefined(self.master.firstsnd))
        thread common_scripts\utility::play_sound_in_space("expl_gas_pipe_burst", self.fxnode.origin);
      else {
        self.master.firstsnd = 1;
        thread common_scripts\utility::play_sound_in_space("expl_gas_pipe_burst_decay", self.fxnode.origin);
      }

      break;
  }

  thread pipebreak_damage();
  self.a = self.whole.a;
  self.b = self.whole.b;
  self setcandamage(1);
  self.whole notify("deleting");
  self.whole delete();
  self show();
  self solid();

  if(isdefined(self.fx_multinode)) {
    for (var_0 = 0; var_0 < self.fx_multinode.size; var_0++)
      playfx(level._effect["pipe_interactive"][self.script_noteworthy], self.fx_multinode[var_0].origin, self.fx_multinode[var_0].forward, self.fx_multinode[var_0].up);
  } else
    playfx(level._effect["pipe_interactive"][self.script_noteworthy], self.fxnode.origin, self.fxnode.forward, self.fxnode.up);

  if(self.script_noteworthy == "fueltanker")
    earthquake(0.4, 1.5, self.fxnode.origin, 600);

  thread pipeimpact();
}

pipesetup() {
  self setcandamage(1);
  var_0 = undefined;
  self.use_bullet_hitnormal = 0;

  if(isdefined(self.script_parameters) && self.script_parameters == "use_bullet_hitnormal")
    self.use_bullet_hitnormal = 1;
  else if(isdefined(self.target)) {
    var_0 = common_scripts\utility::getstruct(self.target, "targetname");

    if(isdefined(var_0)) {
      self.a = var_0.origin;
      var_1 = anglestoforward(var_0.angles);
      var_1 = common_scripts\utility::vectorscale(var_1, 128);
      self.b = self.a + var_1;
    }
  } else {
    var_1 = anglestoforward(self.angles);
    var_2 = common_scripts\utility::vectorscale(var_1, 64);
    self.a = self.origin + var_2;
    var_2 = common_scripts\utility::vectorscale(var_1, -64);
    self.b = self.origin + var_2;
  }

  if(self.script_noteworthy == "fire")
    self.limit = 4;

  thread pipethink();
}

pipethink() {
  var_0 = (0, 0, 0);
  self.numfx = 0;
  self endon("deleting");

  if(isdefined(self.limit)) {
    for (;;) {
      self waittill("damage", var_1, var_2, var_3, var_0, var_4);

      if(var_4 == "MOD_MELEE" || var_4 == "MOD_IMPACT") {
        continue;
      }
      pipethink_logic(self.numfx, self.limit, var_3, var_0, var_4);
      self.numfx++;
    }
  } else {
    for (;;) {
      self waittill("damage", var_1, var_2, var_3, var_0, var_4);

      if(var_4 == "MOD_MELEE" || var_4 == "MOD_IMPACT") {
        continue;
      }
      pipethink_logic(level.num_pipe_fx, level.limit_pipe_fx, var_3, var_0, var_4);
      level.num_pipe_fx++;
      thread pipethink2();
    }
  }
}

pipethink_logic(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 < var_1) {
    var_3 = self[[level._pipe_methods[var_4]]](var_3, var_4);

    if(!isdefined(var_3)) {
      return;
    }
    if(self.use_bullet_hitnormal) {
      var_5 = var_3 - var_2;
      var_6 = var_3 + var_2;
      var_7 = bullettrace(var_5, var_6, 0);
      var_8 = var_7["normal"];
    } else
      var_8 = vectorfromlinetopoint(self.a, self.b, var_3);

    if(lengthsquared(var_8) == 0.0) {
      return;
    }
    thread pipefx(var_3, var_8);
    var_9 = pipeoverlaymaskfxduration(level.pipe_fx_time[self.script_noteworthy]);

    if(var_9)
      thread pipeoverlaymaskfx(var_9, var_3, var_8);

    self notify("pipe_ruptured");
  } else
    self notify("pipe_breaking");
}

pipeoverlaymaskfxduration(var_0) {
  var_1 = 0;

  if(getdvarint("ui_multiplayer"))
    return var_1;

  if(getomnvar("ui_gasmask") != 0 && (self.script_noteworthy == "steam" || self.script_noteworthy == "water") && isdefined(level._effect["screen_heavy_rain_cgoshp"]) && isdefined(level.pipe_fx_time[self.script_noteworthy]))
    return level.pipe_fx_time[self.script_noteworthy];

  return var_1;
}

pipeoverlaymaskfx(var_0, var_1, var_2) {
  var_3 = gettime();
  var_4 = undefined;

  for (;;) {
    wait 0.1;
    var_5 = gettime();

    if(var_5 - var_3 > var_0 * 1000 + 2000) {
      if(isdefined(var_4)) {
        var_4 delete();
        level.overlaymaskfxwastriggered = 0;
      }

      return;
    }

    var_6 = distancesquared(var_1, level.player geteye());
    var_7 = var_1 - level.player.origin;
    var_8 = vectordot(var_7, anglestoforward(level.player.angles));

    if(var_6 < 12000 && var_8 > 0) {
      if(!level.overlaymaskfxwastriggered) {
        level.overlaymaskfxwastriggered = 1;
        var_4 = spawnfx(level._effect["screen_heavy_rain_cgoshp"], level.player.origin);
        triggerfx(var_4);
      }

      continue;
    }

    if(level.overlaymaskfxwastriggered && isdefined(var_4)) {
      var_4 delete();
      level.overlaymaskfxwastriggered = 0;
    }
  }
}

pipethink2() {
  wait(level.pipe_fx_time[self.script_noteworthy]);
  level.num_pipe_fx--;
}

pipefx(var_0, var_1) {
  if(self.script_noteworthy != "fire") {
    playfx(level._effect["pipe_interactive"][self.script_noteworthy], var_0, var_1);
    thread common_scripts\utility::play_sound_in_space(level._sound["pipe_interactive"][self.script_noteworthy], var_0);
    return;
  }

  self endon("pipe_breaking");
  var_2 = 0.1;

  if(!isdefined(self.burnsec)) {
    self.burnsec = int(2 / var_2);
    self.burninterval = int(self.burnsec * 0.15);
  } else
    self.burnsec = self.burnsec - self.burninterval;

  thread common_scripts\utility::play_sound_in_space("mtl_gas_pipe_hit", var_0);
  thread pipesndloopfx("mtl_gas_pipe_flame_loop", var_0, "pipe_breaking");
  thread pipe_snd_end("mtl_gas_pipe_flame_end", var_0, "pipe_breaking");

  if(var_1 == (0, 0, 0))
    var_1 = (0, 360, 0);

  for (var_3 = 0; var_3 < self.burnsec; var_3++) {
    playfx(level._effect["pipe_interactive"][self.script_noteworthy], var_0, var_1);
    wait(var_2);
  }

  self notify("pipe_breaking");
}

pipeimpact() {
  var_0 = (0, 0, 0);
  self endon("deleting");

  for (;;) {
    self waittill("damage", var_1, var_2, var_3, var_0, var_4);

    if(var_4 == "MOD_MELEE" || var_4 == "MOD_IMPACT") {
      continue;
    }
    var_0 = self[[level._pipe_methods[var_4]]](var_0, var_4);
    var_3 = common_scripts\utility::vectorscale(var_3, -1);
    playfx(level._effect["pipe_interactive"]["impact"], var_0, var_3);
  }
}

pipesndloopfx(var_0, var_1, var_2, var_3) {
  self endon(var_2);

  if(!isdefined(var_0)) {
    return;
  }
  if(isdefined(var_3))
    wait(var_3);

  thread common_scripts\utility::play_loopsound_in_space_with_end(var_0, var_1, var_2);
}

pipe_snd_end(var_0, var_1, var_2) {
  if(!isdefined(var_0)) {
    return;
  }
  self waittill(var_2);
  thread common_scripts\utility::play_sound_in_space(var_0, var_1);
}

precachefx() {
  for (var_0 = 0; var_0 < self.size; var_0++) {
    if(self[var_0].script_noteworthy != "steam") {
      continue;
    }
    level._effect["pipe_interactive"][self[var_0].script_noteworthy] = loadfx("fx\impacts\pipe_steam");
    level._sound["pipe_interactive"][self[var_0].script_noteworthy] = "mtl_steam_pipe_hit";
    level.pipe_fx_time[self[var_0].script_noteworthy] = 5;
    break;
  }

  for (var_0 = 0; var_0 < self.size; var_0++) {
    if(self[var_0].script_noteworthy != "steam_canister") {
      continue;
    }
    level._effect["pipe_interactive"][self[var_0].script_noteworthy] = loadfx("vfx\props\canister_steam");
    level._sound["pipe_interactive"][self[var_0].script_noteworthy] = "mtl_steam_pipe_hit";
    level.pipe_fx_time[self[var_0].script_noteworthy] = 5;
    break;
  }

  for (var_0 = 0; var_0 < self.size; var_0++) {
    if(self[var_0].script_noteworthy != "water") {
      continue;
    }
    level._effect["pipe_interactive"][self[var_0].script_noteworthy] = loadfx("fx\impacts\pipe_water");
    level._sound["pipe_interactive"][self[var_0].script_noteworthy] = "mtl_water_pipe_hit";
    level.pipe_fx_time[self[var_0].script_noteworthy] = 2.6;
    break;
  }

  for (var_0 = 0; var_0 < self.size; var_0++) {
    if(self[var_0].script_noteworthy != "fire") {
      continue;
    }
    level._effect["pipe_interactive"][self[var_0].script_noteworthy] = loadfx("fx\impacts\pipe_fire");
    level._effect["pipe_interactive"]["fire64"] = loadfx("fx\explosions\pipe_explosion64");
    level._effect["pipe_interactive"]["fire96"] = loadfx("fx\explosions\pipe_explosion64");
    level._effect["pipe_interactive"]["fire128"] = loadfx("fx\explosions\pipe_explosion128");
    level._effect["pipe_interactive"]["fire256"] = loadfx("fx\explosions\pipe_explosion128");
    level._effect["pipe_interactive"]["fueltanker"] = loadfx("fx\explosions\pipe_explosion128");
    break;
  }

  level._effect["pipe_interactive"]["impact"] = loadfx("fx\impacts\small_metalhit_1");
  update_pipe_fx_with_overrides();
}

override_pipe_fx(var_0, var_1, var_2, var_3) {
  if(!isdefined(level.pipe_fx_override))
    level.pipe_fx_override = [];

  if(!isdefined(level.pipe_fx_override[var_0]))
    level.pipe_fx_override[var_0] = [];

  if(isdefined(var_1))
    level.pipe_fx_override[var_0]["fx"] = var_1;

  if(isdefined(var_2))
    level.pipe_fx_override[var_0]["sound"] = var_2;

  if(isdefined(var_3))
    level.pipe_fx_override[var_0]["time"] = var_3;
}

update_pipe_fx_with_overrides() {
  if(!isdefined(level.pipe_fx_override)) {
    return;
  }
  if(level.pipe_fx_override.size == 0) {
    return;
  }
  var_0 = getarraykeys(level.pipe_fx_override);

  foreach(var_2 in var_0) {
    if(isdefined(level.pipe_fx_override[var_2]["fx"]))
      level._effect["pipe_interactive"][var_2] = loadfx(level.pipe_fx_override[var_2]["fx"]);

    if(isdefined(level.pipe_fx_override[var_2]["sound"]))
      level._sound["pipe_interactive"][var_2] = level.pipe_fx_override[var_2]["sound"];

    if(isdefined(level.pipe_fx_override[var_2]["time"]))
      level.pipe_fx_time[var_2] = level.pipe_fx_override[var_2]["time"];
  }
}