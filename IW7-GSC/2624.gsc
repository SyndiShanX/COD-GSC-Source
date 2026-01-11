/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2624.gsc
***************************************/

main() {
  if(isDefined(level.pipes_init)) {
    return;
  }
  level.pipes_init = 1;
  var_00 = getEntArray("pipe_shootable", "targetname");

  if(!var_0.size) {
    return;
  }
  level._pipes = spawnStruct();
  level._pipes.num_pipe_fx = 0;
  var_00 thread precachefx();
  var_00 thread methodsinit();
  thread post_load(var_00);
}

post_load(var_00) {
  waittillframeend;

  if(level.createfx_enabled) {
    return;
  }
  scripts\engine\utility::array_thread(var_00, ::pipesetup);
}

pipesetup() {
  self setCanDamage(1);
  self give_crafted_medusa(0);
  self.pipe_fx_array = [];
  var_00 = undefined;

  if(isDefined(self.target)) {
    var_00 = scripts\engine\utility::getstruct(self.target, "targetname");
    self.a = var_0.origin;
    var_01 = anglesToForward(var_0.angles);
    var_01 = var_01 * 128;
    self.b = self.a + var_01;
  } else {
    var_01 = anglesToForward(self.angles);
    var_02 = var_01 * 64;
    self.a = self.origin + var_02;
    var_02 = var_01 * -64;
    self.b = self.origin + var_02;
  }

  thread pipe_wait_loop();
}

pipe_wait_loop() {
  var_00 = (0, 0, 0);
  var_01 = 0;
  var_02 = 4;

  for(;;) {
    self waittill("damage", var_03, var_04, var_05, var_00, var_06);

    if(var_01) {
      if(randomint(100) <= 33) {
        continue;
      }
    }

    var_01 = 1;
    var_07 = pipe_logic(var_05, var_00, var_06, var_04);

    if(var_07) {
      var_2--;
    }

    if(var_02 <= 0) {
      break;
    }
  }

  self setCanDamage(0);
}

pipe_logic(var_00, var_01, var_02, var_03) {
  if(level._pipes.num_pipe_fx > 12) {
    return 0;
  }

  if(!isDefined(level._pipes._pipe_methods[var_02])) {
    var_01 = pipe_calc_nofx(var_01, var_02);
  } else {
    var_01 = self[[level._pipes._pipe_methods[var_02]]](var_01, var_02);
  }

  if(!isDefined(var_01)) {
    return 0;
  }

  if(isDefined(var_3.classname) && var_3.classname == "worldspawn") {
    return 0;
  }

  foreach(var_05 in self.pipe_fx_array) {
    if(distancesquared(var_01, var_5.origin) < 25) {
      return 0;
    }
  }

  var_07 = undefined;

  if(isai(var_03)) {
    var_07 = var_03 getEye();
  } else {
    var_07 = var_3.origin;
  }

  var_08 = var_01 - var_07;
  var_09 = bulletTrace(var_07, var_07 + 1.5 * var_08, 0, var_03, 0);

  if(isDefined(var_9["normal"]) && isDefined(var_9["entity"]) && var_9["entity"] == self) {
    var_10 = var_9["normal"];
    thread pipefx(var_01, var_10, var_03);
    return 1;
  }

  return 0;
}

pipefx(var_00, var_01, var_02) {
  var_03 = level._pipes.fx_time[self.script_noteworthy];
  var_04 = level._pipes._pipe_fx_time[self.script_noteworthy];
  var_05 = int(var_04 / var_03);
  var_06 = 30;
  var_07 = "mtl_steam_pipe_hit";
  var_08 = "mtl_steam_pipe_hiss_loop";
  var_09 = "mtl_steam_pipe_hiss_loop_end";
  var_10 = spawn("script_origin", var_00);
  var_10 hide();
  var_10 playSound(var_07);
  var_10 playLoopSound(var_08);
  self.pipe_fx_array[self.pipe_fx_array.size] = var_10;

  if(scripts\engine\utility::issp() || self.script_noteworthy != "steam") {
    thread pipe_damage(var_00, var_01, var_02, var_10);
  }

  if(self.script_noteworthy == "oil_leak") {
    var_11 = spawn("script_model", var_00);
    var_11 setModel("tag_origin");
    var_11.angles = vectortoangles(var_01);
    playFXOnTag(level._pipes._effect[self.script_noteworthy], var_11, "tag_origin");
    level._pipes.num_pipe_fx++;
    var_11 ghost_nav_mode(90, var_03, 1, 1);
    wait(var_03);
    stopFXOnTag(level._pipes._effect[self.script_noteworthy], var_11, "tag_origin");
    var_5--;
  } else {
    playFX(level._pipes._effect[self.script_noteworthy], var_00, var_01);
    level._pipes.num_pipe_fx++;
    wait(var_03);
    var_5--;
  }

  while(level._pipes.num_pipe_fx <= 12 && var_05 > 0) {
    if(self.script_noteworthy == "oil_leak") {
      var_11 = spawn("script_model", var_00);
      var_11 setModel("tag_origin");
      var_11.angles = vectortoangles(var_01);
      playFXOnTag(level._pipes._effect[self.script_noteworthy], var_11, "tag_origin");
      level._pipes.num_pipe_fx++;
      var_11 ghost_nav_mode(90, var_03, 1, 1);
      wait(var_03);
      stopFXOnTag(level._pipes._effect[self.script_noteworthy], var_11, "tag_origin");
      continue;
    }

    playFX(level._pipes._effect[self.script_noteworthy], var_00, var_01);
    wait(var_03);
    var_5--;
  }

  var_10 playSound(var_09);
  wait 0.5;
  var_10 stoploopsound(var_08);
  var_10 delete();
  self.pipe_fx_array = scripts\engine\utility::array_removeundefined(self.pipe_fx_array);
  level._pipes.num_pipe_fx--;
}

pipe_damage(var_00, var_01, var_02, var_03) {
  if(!allow_pipe_damage()) {
    return;
  }
  var_03 endon("death");
  var_04 = var_3.origin + vectornormalize(var_01) * 40;
  var_05 = level._pipes._dmg[self.script_noteworthy];

  for(;;) {
    if(!isDefined(self.damageowner)) {
      self radiusdamage(var_04, 36, var_05, var_05 * 0.75, undefined, "MOD_TRIGGER_HURT");
    } else {
      self radiusdamage(var_04, 36, var_05, var_05 * 0.75, var_02, "MOD_TRIGGER_HURT");
    }

    wait 0.4;
  }
}

allow_pipe_damage() {
  if(!scripts\engine\utility::issp()) {
    return 0;
  }

  if(!isDefined(level.pipesdamage)) {
    return 1;
  }

  return level.pipesdamage;
}

methodsinit() {
  level._pipes._pipe_methods = [];
  level._pipes._pipe_methods["MOD_UNKNOWN"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_PISTOL_BULLET"] = ::pipe_calc_ballistic;
  level._pipes._pipe_methods["MOD_RIFLE_BULLET"] = ::pipe_calc_ballistic;
  level._pipes._pipe_methods["MOD_GRENADE"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_GRENADE_SPLASH"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_PROJECTILE"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_PROJECTILE_SPLASH"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_TRIGGER_HURT"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_EXPLOSIVE"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_EXPLOSIVE_BULLET"] = ::pipe_calc_splash;
}

pipe_calc_ballistic(var_00, var_01) {
  return var_00;
}

pipe_calc_splash(var_00, var_01) {
  var_02 = vectornormalize(vectorfromlinetopoint(self.a, self.b, var_00));
  var_00 = pointonsegmentnearesttopoint(self.a, self.b, var_00);
  return var_00 + var_02 * 4;
}

pipe_calc_nofx(var_00, var_01) {
  return undefined;
}

precachefx() {
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;

  foreach(var_06 in self) {
    if(var_6.script_noteworthy == "water") {
      var_6.script_noteworthy = "steam";
    }

    if(var_6.script_noteworthy == "steam") {
      var_06 willneverchange();
      var_00 = 1;
      continue;
    }

    if(var_6.script_noteworthy == "fire") {
      var_06 willneverchange();
      var_01 = 1;
      continue;
    }

    if(var_6.script_noteworthy == "steam_small") {
      var_06 willneverchange();
      var_02 = 1;
      continue;
    }

    if(var_6.script_noteworthy == "oil_leak") {
      var_06 willneverchange();
      var_03 = 1;
      continue;
    }

    if(var_6.script_noteworthy == "oil_cap") {
      var_06 willneverchange();
      var_04 = 1;
      continue;
    }
  }

  if(var_00) {
    level._pipes._effect["steam"] = loadfx("vfx\core\impacts\pipe_steam");
    level._pipes._sound["steam_hit"] = "mtl_steam_pipe_hit";
    level._pipes._sound["steam_loop"] = "mtl_steam_pipe_hiss_loop";
    level._pipes._sound["steam_end"] = "mtl_steam_pipe_hiss_loop_end";
    level._pipes.fx_time["steam"] = 3;
    level._pipes._dmg["steam"] = 5;
    level._pipes._pipe_fx_time["steam"] = 25;
  }

  if(var_02) {
    level._pipes._effect["steam_small"] = loadfx("vfx\core\impacts\pipe_steam_small");
    level._pipes._sound["steam_small_hit"] = "mtl_steam_pipe_hit";
    level._pipes._sound["steam_small_loop"] = "mtl_steam_pipe_hiss_loop";
    level._pipes._sound["steam_small_end"] = "mtl_steam_pipe_hiss_loop_end";
    level._pipes.fx_time["steam_small"] = 3;
    level._pipes._dmg["steam_small"] = 5;
    level._pipes._pipe_fx_time["steam_small"] = 25;
  }

  if(var_01) {
    level._pipes._effect["fire"] = loadfx("vfx\core\impacts\pipe_fire");
    level._pipes._sound["fire_hit"] = "mtl_gas_pipe_hit";
    level._pipes._sound["fire_loop"] = "mtl_gas_pipe_flame_loop";
    level._pipes._sound["fire_end"] = "mtl_gas_pipe_flame_end";
    level._pipes.fx_time["fire"] = 3;
    level._pipes._dmg["fire"] = 5;
    level._pipes._pipe_fx_time["fire"] = 25;
  }

  if(var_03) {
    level._pipes._effect["oil_leak"] = loadfx("vfx\core\impacts\pipe_oil_barrel_spill");
    level._pipes._sound["oil_leak_hit"] = "mtl_oil_barrel_hit";
    level._pipes._sound["oil_leak_loop"] = "mtl_oil_barrel_hiss_loop";
    level._pipes._sound["oil_leak_end"] = "mtl_oil_barrel_hiss_loop_end";
    level._pipes.fx_time["oil_leak"] = 6;
    level._pipes._pipe_fx_time["oil_leak"] = 6;
    level._pipes._dmg["oil_leak"] = 5;
  }

  if(var_04) {
    level._pipes._effect["oil_cap"] = loadfx("vfx\core\impacts\pipe_oil_barrel_squirt");
    level._pipes._sound["oil_cap_hit"] = "mtl_steam_pipe_hit";
    level._pipes._sound["oil_cap_loop"] = "mtl_steam_pipe_hiss_loop";
    level._pipes._sound["oil_cap_end"] = "mtl_steam_pipe_hiss_loop_end";
    level._pipes.fx_time["oil_cap"] = 3;
    level._pipes._dmg["oil_cap"] = 5;
    level._pipes._pipe_fx_time["oil_cap"] = 5;
  }
}