/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\equipment\portal_grenade.gsc
***************************************************/

init() {
  level.var_D690 = loadfx("vfx\iw7\_requests\mp\vfx_impulse_grenade_start");
  level.var_D68D = loadfx("vfx\iw7\_requests\mp\vfx_impulse_gren_exp");
}

func_D691(var_0) {
  var_0 endon("death");
  if(!isDefined(var_0)) {
    return;
  }

  var_0 waittill("missile_stuck");
  playFX(level.var_D690, var_0.origin + (0, 0, 2));
  wait(1.25);
  playFX(level.var_D68D, var_0.origin + (0, 0, 2));
  radiusdamage(var_0.origin, 180, 1, 1, self, "MOD_EXPLOSIVE", var_0.weapon_name);
  var_0 delete();
}

func_D68E(var_0, var_1) {
  self endon("disconnect");
  if(scripts\mp\utility::func_9EF0(self) || !isplayer(self)) {
    return;
  }

  var_2 = self.origin + (0, 0, 2000);
  var_3 = self.angles * (0, 1, 1);
  var_3 = var_3 + (85, 0, 0);
  var_4 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_5 = scripts\common\trace::player_trace(self.origin, var_2, self.angles, self, var_4);
  var_6 = self.origin;
  self.var_115FC = 1;
  if(var_5["fraction"] < 1) {
    var_2 = var_5["position"] - (0, 0, 65);
    func_11663(var_2);
    wait(0.05);
    self.var_115FC = 0;
    radiusdamage(var_2 + (0, 0, 32), 128, 400, 400, var_1, "MOD_EXPLOSIVE", "portal_grenade_mp");
    func_468B(self, self.origin + (0, 0, 32));
    return;
  }

  thread func_4E75();
  self shellshock("flashbang_mp", 0.8, 1, 1);
  func_11663(var_2);
  var_7 = (0, 0, 1500);
  self setplayerangles(var_3);
  self setvelocity(var_7);
  scripts\engine\utility::allow_doublejump(0);
  scripts\mp\utility::_enablecollisionnotifies(1);
  self setmovespeedscale(0);
  thread func_13EF3();
  thread func_13B31();
  thread func_13AF8(var_1);
  self.var_115FE = var_6;
  self.var_115FD = var_1;
}

func_13AF8(var_0) {
  self endon("portalGrenadeSave");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self waittill("collided", var_1, var_2, var_3, var_4, var_5);
  if(var_5 == "hittype_entity") {
    radiusdamage(self.origin + (0, 0, 32), 128, 400, 400, var_0, "MOD_EXPLOSIVE", "portal_grenade_mp");
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
    var_0 = self getvelocity();
    var_0 = var_0 * (0, 0, 1);
    self setvelocity(var_0);
    wait(0.05);
  }
}

func_468B(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("diconnect");
  wait(0.05);
  var_2 = var_0 _meth_8113();
  if(!isDefined(var_2)) {
    return;
  }

  var_3 = var_2.origin;
  earthquake(0.5, 1.5, var_3, 120);
  thread scripts\mp\utility::func_13AF(var_3, 64, 400, 400, self, "MOD_EXPLOSIVE", "portal_grenade_mp", 0);
  var_0 thread scripts\mp\utility::func_13AF(var_3, 64, 400, 400, var_0, "MOD_EXPLOSIVE", "portal_grenade_mp", 0);
  wait(0.1);
  playFX(level._effect["corpse_pop"], var_3 + (0, 0, 12));
  if(isDefined(var_2)) {
    var_2 hide();
    var_2.permanentcustommovetransition = 1;
  }
}

func_11663(var_0) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(var_0)) {
    return 0;
  }

  self playlocalsound("ftl_teleport");
  self playSound("ftl_teleport_npc_out");
  if(self ismantling()) {
    self cancelmantle();
  }

  var_1 = length2dsquared(self getentityvelocity());
  var_2 = (0, 0, 0);
  var_3 = var_0 - self.origin;
  if(var_1 > 0) {
    var_2 = var_3 * sqrt(var_1) / length(var_3);
  }

  thread func_E852(self.origin, var_3);
  scripts\engine\utility::waitframe();
  if(!isDefined(self)) {
    return 0;
  }

  var_4 = self.origin;
  var_5 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  self playerlinkto(var_5);
  self setclientdvar("cg_fovScale", 1.7);
  var_5 moveto(var_0, 0.15, 0, 0);
  self playanimscriptevent("power_active", "teleport");
  scripts\mp\utility::adddamagemodifier("teleport", 0, 0);
  self motionblurhqenable();
  self setblurforplayer(3, 0);
  wait(0.15);
  self setblurforplayer(0, 0.25);
  self motionblurhqdisable();
  scripts\mp\utility::removedamagemodifier("teleport", 0);
  self unlink();
  self setorigin(var_0, 1);
  self setclientdvar("cg_fovScale", 1);
  scripts\engine\utility::waitframe();
  self playanimscriptevent("power_exit", "teleport");
  if(!isDefined(self)) {
    return 0;
  }

  self playSound("ftl_teleport_npc_in");
  self setvelocity(var_2);
  return 1;
}

func_E852(var_0, var_1) {
  var_0 = var_0 + (0, 0, 50);
  var_2 = var_0 + var_1;
  var_3 = spawn("script_model", var_0);
  var_3 setModel("tag_origin");
  wait(0.1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_tele_trail"), var_3, "tag_origin");
  var_3 moveto(var_2, 0.1, 0.05, 0);
  wait(0.2);
  stopFXOnTag(scripts\engine\utility::getfx("vfx_tele_trail"), var_3, "tag_origin");
  var_3 delete();
}