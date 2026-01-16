/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\equipment\fear_grenade.gsc
*************************************************/

init() {
  level.var_6BBA = spawnStruct();
  level.var_6BBA.var_451D = [];
  level._effect["vfx_haywire_scrn"] = loadfx("vfx\iw7\_requests\mp\vfx_haywire_scrn.vfx");
  level._effect["haywire_smoke_friendly"] = loadfx("vfx\old\_requests\mp_weapons\vfx_haywire_gas_friendly");
  level._effect["haywire_smoke_enemy"] = loadfx("vfx\old\_requests\mp_weapons\vfx_haywire_gas_enemy");
  level._effect["vfx_fear_grenade_explode_frag"] = loadfx("vfx\core\expl\grenadeexp_default");
  level._effect["vfx_fear_grenade_explode_plasma"] = loadfx("vfx\iw7\_requests\mp\vfx_plasma_large_explosion_enemy");
  level._effect["vfx_fear_grenade_explode_blackhole"] = loadfx("vfx\iw7\_requests\mp\vfx_blackhole_grenade_enemy");
  level._effect["fear_mine_vanish"] = loadfx("vfx\core\mp\equipment\vfx_motionsensor_exp");
  func_49CF("projectile_m67fraggrenade", "vfx_fear_grenade_explode_frag", "grenade_explode_scr", undefined, 2);
  func_49CF("projectile_m67fraggrenade", "vfx_fear_grenade_explode_plasma", "grenade_explode_scr", undefined, 2);
  func_49CF("projectile_m67fraggrenade", "vfx_fear_grenade_explode_blackhole", "blackhole_grenade_explode_default", 75, 0.5);
  level.var_6BBA.func_8283 = ["mp_fullbody_synaptic_1"];
  level.var_6BBA.var_3251 = ["drone_ak12_fire_npc"];
  scripts\mp\powerloot::func_DF06("power_fearGrenade", ["passive_increased_duration", "passive_increased_damage", "passive_increased_radius"]);
}

func_49CF(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.model = var_0;
  var_5.var_1336D = scripts\engine\utility::getfx(var_1);
  var_5.var_FC43 = var_2;
  var_5.var_763E = var_3;
  var_5.var_AC75 = var_4;
  level.var_6BBA.var_451D[level.var_6BBA.var_451D.size] = var_5;
}

dropweapon() {
  return level.var_6BBA.var_451D[randomint(level.var_6BBA.var_451D.size)];
}

func_6BBC() {
  self notify("detonateExplosive");
}

func_6BBB() {
  var_0 = self.owner;
  var_1 = self.origin;
  playFX(scripts\engine\utility::getfx("fear_mine_vanish"), var_1);
  if(isDefined(self.var_76CF)) {
    self.var_76CF moveto(var_1 + (0, 0, 72), 0.5);
  }

  var_2 = var_0 scripts\mp\powerloot::func_7FC4("power_fearGrenade", 160);
  var_3 = spawn("trigger_radius", var_1, 0, var_2, 160);
  var_3.owner = var_0;
  var_4 = scripts\mp\utility::func_108CB(var_0, var_1, "haywire_smoke_friendly", "haywire_smoke_enemy", 0);
  var_0 thread func_13A3E(var_3, self.var_76CF);
  wait(5);
  foreach(var_6 in var_4) {
    var_6 delete();
  }

  wait(2);
  var_3 delete();
}

func_13A3E(var_0, var_1) {
  var_0.owner endon("disconnect");
  self endon("disconnect");
  for(;;) {
    var_0 waittill("trigger", var_2);
    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_0, var_2)) {
      continue;
    }

    var_3 = func_370F(var_0.owner, var_2);
    if(var_3.var_13378 > 0) {
      var_2 thread func_127C3(var_3.var_13378, var_0.owner, var_1);
    }

    if(var_3.attackerendzone > 0) {
      var_0.owner thread func_127C3(var_3.attackerendzone, var_0.owner, var_1);
    }
  }
}

func_370F(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.attackerendzone = 0;
  var_2.var_13378 = 0;
  var_3 = scripts\mp\powerloot::func_7FC1("power_fearGrenade", 2.5);
  if(level.teambased && var_0.team == var_1.team && var_0 != var_1) {
    if(level.friendlyfire == 0) {} else if(level.friendlyfire == 1) {
      var_2.var_13378 = var_3;
    } else if(level.friendlyfire == 2) {
      var_2.attackerendzone = var_3;
    } else if(level.friendlyfire == 3) {
      var_2.var_13378 = var_3 * 0.5;
      var_2.attackerendzone = var_3 * 0.5;
    }
  } else {
    var_2.var_13378 = var_3;
  }

  return var_2;
}

func_127C3(var_0, var_1, var_2) {
  if(func_9EEA(self)) {
    func_F703(var_0);
    return;
  }

  thread func_2A67(var_0, var_1, var_2);
}

func_2A67(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self.var_6BB9 = spawnStruct();
  func_F703(var_0);
  thread func_E84C();
  var_3 = scripts\mp\powerloot::func_7FC0("power_fearGrenade", 8);
  self dodamage(var_3, self.origin, var_1, var_2, "MOD_EXPLOSIVE", "fear_grenade_mp");
  for(;;) {
    var_4 = self.var_6BB9.var_6393 - gettime() / 1000;
    var_5 = scripts\engine\utility::waittill_any_timeout(var_4, "fear_update_duration");
    if(var_5 == "timeout") {
      func_6319();
      break;
    } else {
      continue;
    }
  }
}

func_E84C() {
  self endon("stop_fear_effects");
  self endon("death");
  self endon("disconnect");
  var_0 = spawnfxforclient(scripts\engine\utility::getfx("vfx_haywire_scrn"), (0, 0, 0), self);
  triggerfx(var_0);
  thread func_4115(var_0);
  thread watchfordeath();
  childthread func_E85A();
  wait(0.5);
  childthread func_E853();
  childthread func_E854();
}

func_6319() {
  self notify("stop_fear_effects");
  scripts\engine\utility::waitframe();
  func_40F9();
  self.var_6BB9 = undefined;
  self notify("finished_stop_fear_effects");
}

func_4115(var_0) {
  scripts\engine\utility::waittill_any("death", "disconnect", "stop_fear_effects");
  var_0 delete();
}

watchfordeath() {
  self endon("finished_stop_fear_effects");
  self waittill("death");
  func_6319();
}

func_F703(var_0) {
  var_1 = gettime() + int(var_0 * 1000);
  if(isDefined(self.var_6BB9.var_6393)) {
    if(self.var_6BB9.var_6393 > var_1) {
      return;
    }
  }

  self.var_6BB9.var_6393 = var_1;
  self notify("fear_update_duration");
}

func_9EEA(var_0) {
  return isDefined(var_0.var_6BB9);
}

func_E853() {
  for(;;) {
    var_0 = self getEye();
    var_1 = self getplayerangles();
    var_2 = anglesToForward(var_1);
    var_3 = anglestoright(var_1);
    var_4 = var_0 + (0, 0, 60) + var_3 * randomfloatrange(-300, 300);
    var_5 = self.origin + var_2 * 500 + (randomfloatrange(-150, 150), randomfloatrange(-150, 150), 0);
    var_6 = vectornormalize(var_5 - var_4) * randomfloatrange(500, 900);
    var_6 = (var_6[0], var_6[1], 0) + self getvelocity();
    thread func_108CE(self, var_4, var_6);
    wait(randomfloatrange(0.1, 0.5));
  }
}

func_E8D9() {
  for(;;) {
    var_0 = setgametypevip();
    var_1 = randomfloat(50);
    wait(randomfloatrange(0.05, 0.15));
  }
}

func_E842() {
  for(;;) {
    var_0 = setgametypevip();
    var_1 = self.health;
    self dodamage(1, var_0, undefined, undefined, "MOD_FALLING");
    self.health = var_1;
    wait(randomfloatrange(0.35, 1.5));
  }
}

func_E85A() {
  self setclientomnvar("ui_hud_shake", 1);
}

func_E854() {
  var_0 = spawn("script_model", self.origin);
  var_0 hide();
  self.var_6BB9.scragentsetanimscale = var_0;
  var_1 = 0;
  for(;;) {
    var_2 = undefined;
    if(!var_1 && randomint(10) == 0) {
      var_3 = anglesToForward(self.angles);
      var_2 = self.origin + var_3 * 25 + (0, 0, -5);
      var_4 = (self.angles[0], 180 + self.angles[1], self.angles[2]);
      var_0.origin = var_2;
      var_0.angles = var_4;
      var_0 setModel("mp_fullbody_synaptic_1");
      var_1 = 1;
    } else {
      var_2 = setgametypevip(200, 300);
      var_2 = getclosestpointonnavmesh(var_2);
      var_4 = (self.angles[0], 180 + self.angles[1], self.angles[2]);
      var_0.origin = var_2;
      var_0.angles = var_4;
      var_5 = level.var_6BBA.func_8283[randomint(level.var_6BBA.func_8283.size)];
      var_0 setModel(var_5);
    }

    scripts\engine\utility::waitframe();
    var_0 showtoplayer(self);
    wait(randomfloatrange(0.3, 0.65));
    var_0 hide();
    var_0 unlink();
    wait(randomfloatrange(0.3, 0.65));
  }
}

func_E83D() {
  var_0 = spawn("script_model", self.origin);
  var_0 thread func_4119();
  for(;;) {
    var_1 = level.var_6BBA.var_3251[randomint(level.var_6BBA.var_3251.size)];
    var_0.origin = setgametypevip();
    var_0 playsoundtoplayer(var_1, self);
    wait(randomfloatrange(0.15, 0.3));
  }
}

func_4119(var_0) {
  scripts\engine\utility::waittill_any("stop_fear_effects", "death", "disconnect");
  var_0 delete();
}

func_40F9() {
  if(isDefined(self.var_6BB9.scragentsetanimscale)) {
    self.var_6BB9.scragentsetanimscale delete();
  }
}

func_108CE(var_0, var_1, var_2) {
  var_3 = randomfloatrange(0.4, 1.25);
  var_4 = var_0 scripts\mp\utility::_launchgrenade("fear_ghost_grenade_mp", var_1, var_2, var_3);
  var_4 hide();
  var_4 showtoplayer(var_0);
  var_4 thread func_13A3D();
  var_5 = spawn("script_model", var_1);
  var_5.owner = var_0;
  var_5.projectile = var_4;
  var_5.config = dropweapon();
  var_5 hide();
  var_5 showtoplayer(var_0);
  var_5 setModel(var_5.config.model);
  var_5 linkto(var_4, "tag_origin");
  var_4.var_6B4A = var_5;
  var_5 thread func_13A41();
}

func_13A3D() {
  var_0 = scripts\engine\utility::waittill_any_return("explode", "death");
  self.var_6B4A notify("detonate_ghost_grenade");
}

func_13A41() {
  self endon("death");
  var_0 = scripts\engine\utility::waittill_any_timeout(4, "detonate_ghost_grenade");
  thread func_108CF();
  self delete();
}

func_108CF() {
  var_0 = self.config;
  var_1 = undefined;
  if(isDefined(var_0.var_1336D)) {
    var_2 = (0, 0, 0);
    if(isDefined(var_0.var_763E)) {
      var_3 = anglestoup(self.angles);
      var_2 = var_3 * var_0.var_763E;
    }

    var_1 = spawnfxforclient(var_0.var_1336D, self.origin + var_2, self.owner);
    triggerfx(var_1);
  }

  if(isDefined(var_0.var_FC43)) {
    self playsoundtoplayer(var_0.var_FC43, self.owner);
  }

  wait(var_0.var_AC75);
  if(isDefined(var_1)) {
    var_1 delete();
  }
}

setgametypevip(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    var_0 = -100;
  }

  if(!isDefined(var_1)) {
    var_1 = 100;
  }

  if(!isDefined(var_2)) {
    var_2 = -100;
  }

  if(!isDefined(var_3)) {
    var_3 = 100;
  }

  if(!isDefined(var_4)) {
    var_4 = -100;
  }

  if(!isDefined(var_5)) {
    var_5 = 100;
  }

  var_6 = randomfloatrange(var_0, var_1);
  var_7 = randomfloatrange(var_2, var_3);
  var_8 = randomfloatrange(var_4, var_5);
  var_9 = anglesToForward(self.angles);
  var_10 = anglestoright(self.angles);
  var_11 = anglestoup(self.angles);
  return self.origin + var_9 * var_6 + var_10 * var_7 + var_11 * var_8;
}