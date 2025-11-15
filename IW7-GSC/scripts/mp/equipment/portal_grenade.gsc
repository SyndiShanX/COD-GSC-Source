/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\portal_grenade.gsc
***************************************************/

init() {
  level.var_D690 = loadfx("vfx\iw7\_requests\mp\vfx_impulse_grenade_start");
  level.var_D68D = loadfx("vfx\iw7\_requests\mp\vfx_impulse_gren_exp");
}

func_D691(param_00) {
  param_00 endon("death");
  if(!isDefined(param_00)) {
    return;
  }

  param_00 waittill("missile_stuck");
  playFX(level.var_D690, param_00.origin + (0, 0, 2));
  wait(1.25);
  playFX(level.var_D68D, param_00.origin + (0, 0, 2));
  radiusdamage(param_00.origin, 180, 1, 1, self, "MOD_EXPLOSIVE", param_00.weapon_name);
  param_00 delete();
}

func_D68E(param_00, param_01) {
  self endon("disconnect");
  if(scripts\mp\utility::func_9EF0(self) || !isplayer(self)) {
    return;
  }

  var_02 = self.origin + (0, 0, 2000);
  var_03 = self.angles * (0, 1, 1);
  var_03 = var_03 + (85, 0, 0);
  var_04 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_05 = scripts\common\trace::player_trace(self.origin, var_02, self.angles, self, var_04);
  var_06 = self.origin;
  self.var_115FC = 1;
  if(var_05["fraction"] < 1) {
    var_02 = var_05["position"] - (0, 0, 65);
    func_11663(var_02);
    wait(0.05);
    self.var_115FC = 0;
    radiusdamage(var_02 + (0, 0, 32), 128, 400, 400, param_01, "MOD_EXPLOSIVE", "portal_grenade_mp");
    func_468B(self, self.origin + (0, 0, 32));
    return;
  }

  thread func_4E75();
  self shellshock("flashbang_mp", 0.8, 1, 1);
  func_11663(var_02);
  var_07 = (0, 0, 1500);
  self setplayerangles(var_03);
  self setvelocity(var_07);
  scripts\engine\utility::allow_doublejump(0);
  scripts\mp\utility::_enablecollisionnotifies(1);
  self setmovespeedscale(0);
  thread func_13EF3();
  thread func_13B31();
  thread func_13AF8(param_01);
  self.var_115FE = var_06;
  self.var_115FD = param_01;
}

func_13AF8(param_00) {
  self endon("portalGrenadeSave");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self waittill("collided", var_01, var_02, var_03, var_04, var_05);
  if(var_05 == "hittype_entity") {
    radiusdamage(self.origin + (0, 0, 32), 128, 400, 400, param_00, "MOD_EXPLOSIVE", "portal_grenade_mp");
    func_468B(self, self.origin + (0, 0, 32));
  }
}

func_4E75() {
  self endon("portalGrenadeSave");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  scripts\mp\utility::_enablecollisionnotifies(0);
  scripts\engine\utility::allow_doublejump(1);
  self.var_115FC = 0;
  self.var_115FD = undefined;
  self.var_115FE = undefined;
}

func_13B31() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("phase_shift_power_activated", "rewind_power_finished", "powers_teleport_used", "orbital_deployment_complete", "phase_slash_entered", "transponder_teleportPlayer");
  while(!self isonground()) {
    wait(0.05);
  }

  self notify("portalGrenadeSave");
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility::_enablecollisionnotifies(0);
  scripts\engine\utility::allow_doublejump(1);
  self.var_115FC = 0;
  self.var_115FD = undefined;
  self.var_115FE = undefined;
}

func_13EF3() {
  level endon("game_ended");
  self endon("death");
  self endon("portalGrenadeSave");
  self endon("disconnect");
  for(;;) {
    var_00 = self getvelocity();
    var_00 = var_00 * (0, 0, 1);
    self setvelocity(var_00);
    wait(0.05);
  }
}

func_468B(param_00, param_01) {
  level endon("game_ended");
  self endon("disconnect");
  param_00 endon("diconnect");
  wait(0.05);
  var_02 = param_00 _meth_8113();
  if(!isDefined(var_02)) {
    return;
  }

  var_03 = var_02.origin;
  earthquake(0.5, 1.5, var_03, 120);
  thread scripts\mp\utility::func_13AF(var_03, 64, 400, 400, self, "MOD_EXPLOSIVE", "portal_grenade_mp", 0);
  param_00 thread scripts\mp\utility::func_13AF(var_03, 64, 400, 400, param_00, "MOD_EXPLOSIVE", "portal_grenade_mp", 0);
  wait(0.1);
  playFX(level._effect["corpse_pop"], var_03 + (0, 0, 12));
  if(isDefined(var_02)) {
    var_02 hide();
    var_02.permanentcustommovetransition = 1;
  }
}

func_11663(param_00) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(param_00)) {
    return 0;
  }

  self playlocalsound("ftl_teleport");
  self playSound("ftl_teleport_npc_out");
  if(self ismantling()) {
    self cancelmantle();
  }

  var_01 = length2dsquared(self getentityvelocity());
  var_02 = (0, 0, 0);
  var_03 = param_00 - self.origin;
  if(var_01 > 0) {
    var_02 = var_03 * sqrt(var_01) / length(var_03);
  }

  thread func_E852(self.origin, var_03);
  scripts\engine\utility::waitframe();
  if(!isDefined(self)) {
    return 0;
  }

  var_04 = self.origin;
  var_05 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  self playerlinkto(var_05);
  self setclientdvar("cg_fovScale", 1.7);
  var_05 moveto(param_00, 0.15, 0, 0);
  self playanimscriptevent("power_active", "teleport");
  scripts\mp\utility::adddamagemodifier("teleport", 0, 0);
  self motionblurhqenable();
  self setblurforplayer(3, 0);
  wait(0.15);
  self setblurforplayer(0, 0.25);
  self motionblurhqdisable();
  scripts\mp\utility::removedamagemodifier("teleport", 0);
  self unlink();
  self setorigin(param_00, 1);
  self setclientdvar("cg_fovScale", 1);
  scripts\engine\utility::waitframe();
  self playanimscriptevent("power_exit", "teleport");
  if(!isDefined(self)) {
    return 0;
  }

  self playSound("ftl_teleport_npc_in");
  self setvelocity(var_02);
  return 1;
}

func_E852(param_00, param_01) {
  param_00 = param_00 + (0, 0, 50);
  var_02 = param_00 + param_01;
  var_03 = spawn("script_model", param_00);
  var_03 setModel("tag_origin");
  wait(0.1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_tele_trail"), var_03, "tag_origin");
  var_03 moveto(var_02, 0.1, 0.05, 0);
  wait(0.2);
  stopFXOnTag(scripts\engine\utility::getfx("vfx_tele_trail"), var_03, "tag_origin");
  var_03 delete();
}