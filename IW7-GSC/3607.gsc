/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3607.gsc
************************/

func_DD9E() {
  level._effect["reaper_kill"] = loadfx("vfx\iw7\_requests\mp\vfx_meatbag_large.vfx");
  level._effect["reaper_kill_robot"] = loadfx("vfx\iw7\core\impact\robot\vfx_mp_c6_melee.vfx");
  level._effect["screen_blood"] = loadfx("vfx\iw7\core\zombie\weapon\axe\vfx_zmb_axe_screen_blood.vfx");
}

func_DD9D() {
  self _meth_845E(1);
  self give_crafted_sentry(1);
  self setclientomnvar("ui_odin", 5);
  self give_explosive_touch_on_revived("c6reaperservo");
  thread func_13B7A();
  self playsoundonmovingent("reaper_startup");
  self.health = self.maxhealth;
  self setsuit("reaper_mp");
  func_DD94();
  func_DD99();
  func_DD9B();
  self.var_B62A = spawn("script_model", self.origin);
  self.var_B62A setModel("tag_origin");
  thread func_13ACC();
  thread func_13A9F();
  thread scripts\mp\supers::watchobjuse(125);
  return 1;
}

func_DD97() {
  self endon("death");
  self endon("disconnect");
  self notify("reaper_removed");
  self notify("obj_drain_end");
  self _meth_845E(0);
  self give_crafted_sentry(0);
  self setclientomnvar("ui_odin", -1);
  self thermalvisionoff();
  self give_explosive_touch_on_revived(self.var_42B0);
  self playlocalsound("reaper_shutdown");
  if(scripts\mp\utility::istrue(level.tactical)) {
    self setsuit("scout_mp_tactical");
  } else {
    self setsuit("scout_mp");
  }

  func_DD98();
  reaper_restorerigperks();
  func_DD9A();
  self.var_B62A delete();
}

func_13A9F() {
  self endon("death");
  self endon("disconnect");
  self endon("reaper_removed");
  level endon("game_ended");
  for(;;) {
    self waittill("got_a_kill");
    self.health = self.maxhealth;
    var_0 = self getvieworigin();
    playFX(level._effect["screen_blood"], var_0);
  }
}

func_13B7A() {
  self endon("death");
  self endon("disconnect");
  self endon("reaper_removed");
  level endon("game_ended");
  var_0 = 0;
  self thermalvisionoff();
  self notifyonplayercommand("switch_reaper_thermal", "+usereload");
  self notifyonplayercommand("switch_reaper_thermal", "+activate");
  for(;;) {
    self waittill("switch_reaper_thermal");
    if(!var_0) {
      self thermalvisionon();
    } else {
      self thermalvisionoff();
    }

    self playlocalsound("reaper_thermal_toggle");
    var_0 = !var_0;
  }
}

func_13ACC() {
  self endon("death");
  self endon("disconnect");
  self endon("reaper_removed");
  level endon("game_ended");
  var_0 = (0, 0, 32);
  for(;;) {
    self waittill("melee_fired");
    self setscriptablepartstate("reaper_claws", "claws_on_fire", 0);
  }
}

func_DD99() {
  if(scripts\mp\utility::_hasperk("specialty_dodge")) {
    self.restoredodge = "specialty_dodge";
    self setclientomnvar("ui_dodge_charges", 0);
    self notify("setDodge");
    scripts\mp\utility::removeperk("specialty_dodge");
  }

  if(scripts\mp\utility::_hasperk("specialty_afterburner")) {
    self.restoreafterburner = "specialty_afterburner";
    scripts\mp\utility::removeperk("specialty_afterburner");
  }

  if(scripts\mp\utility::_hasperk("specialty_rush")) {
    self.restorerush = "specialty_rush";
    scripts\mp\utility::removeperk("specialty_rush");
  }

  self goal_radius(0, 400);
}

reaper_restorerigperks() {
  if(isDefined(self.restoredodge)) {
    scripts\mp\utility::giveperk(self.restoredodge);
    self.restoredodge = undefined;
  }

  if(isDefined(self.restoreafterburner)) {
    scripts\mp\utility::giveperk(self.restoreafterburner);
    self.restoreafterburner = undefined;
  }

  if(isDefined(self.restorerush)) {
    scripts\mp\utility::giveperk(self.restorerush);
    self.restorerush = undefined;
  }

  self goal_radius(0, 50);
}

func_DD94() {
  scripts\mp\utility::giveperk("specialty_extendedmelee");
  scripts\mp\utility::giveperk("specialty_fastermelee");
  scripts\mp\utility::giveperk("specialty_sprintmelee");
  scripts\mp\utility::giveperk("specialty_commando");
  scripts\mp\utility::giveperk("specialty_selectivehearing");
  scripts\mp\utility::giveperk("specialty_heartbreaker");
  scripts\mp\utility::giveperk("specialty_stun_resistance");
  scripts\mp\utility::giveperk("specialty_ghost");
}

func_DD98() {
  scripts\mp\utility::removeperk("specialty_extendedmelee");
  scripts\mp\utility::removeperk("specialty_fastermelee");
  scripts\mp\utility::removeperk("specialty_sprintmelee");
  scripts\mp\utility::removeperk("specialty_commando");
  scripts\mp\utility::removeperk("specialty_selectivehearing");
  scripts\mp\utility::removeperk("specialty_heartbreaker");
  scripts\mp\utility::removeperk("specialty_stun_resistance");
  scripts\mp\utility::removeperk("specialty_ghost");
}

func_DD9B() {
  self disableweaponpickup();
  scripts\engine\utility::allow_slide(0);
  scripts\engine\utility::allow_prone(0);
  scripts\engine\utility::allow_usability(0);
  scripts\mp\utility::func_1C47(0);
  scripts\mp\powers::func_D729();
}

func_DD9A() {
  self enableweaponpickup();
  scripts\engine\utility::allow_slide(1);
  scripts\engine\utility::allow_prone(1);
  scripts\engine\utility::allow_usability(1);
  scripts\mp\utility::func_1C47(1);
  scripts\mp\powers::func_D72F();
}

func_93D9() {
  return scripts\engine\utility::ter_op(scripts\mp\utility::istrue(level.hardcoremode), 19, 50);
}

func_A668() {
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  var_0 = self _meth_8113();
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0.origin;
  if(self.loadoutarchetype == "archetype_scout") {
    playFX(level._effect["reaper_kill_robot"], var_1 + (0, 0, 12));
  } else {
    playFX(level._effect["reaper_kill"], var_1 + (0, 0, 12));
  }

  if(isDefined(var_0)) {
    var_0 hide(1);
    var_0.permanentcustommovetransition = 1;
  }
}

isusingreaper() {
  if(!isplayer(self)) {
    return 0;
  }

  if(!scripts\mp\utility::isreallyalive(self)) {
    return 0;
  }

  var_0 = scripts\mp\supers::getcurrentsuperref();
  if(!isDefined(var_0) || var_0 != "super_reaper") {
    return 0;
  }

  return scripts\mp\supers::issuperinuse();
}