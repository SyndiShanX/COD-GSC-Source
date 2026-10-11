/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5f3926616512ec0.gsc
************************************************/

#using scripts\common\callbacks;
#using scripts\engine\utility;
#using scripts\weapons\manglercannon_torpedo;
#namespace zombie_mangler_ranged_attack;

function function_303a0a4b0a91563() {
  callback::get_template(self.animsetname) callback::add("on_zombie_ai_damaged", &function_7d71101059243aa7);
}

function function_76b312fdb8a57ebb() {
  thread function_db02e333586efd39();
  thread function_81245ea5bddfa425();
  self.var_14f3052ce66da740 = &function_14f3052ce66da740;
  self function_3e89eb3d8e3f1811("can_ranged_attack", 1);
  self.var_809957baadce26cf = 0;
  self.var_a722c7954f95547b = self.zombieaisettings.var_e58a65b7a8f5973c.staggerdamagethreshold * self.health;
  self.var_48a12f8371457fbb = self.zombieaisettings.var_e58a65b7a8f5973c.var_845b3a14d1732111;
  self.torpedo_cooldown = self.zombieaisettings.var_e58a65b7a8f5973c.torpedocooldown;
  self.var_db7207afcf1c7e9a = self.zombieaisettings.var_e58a65b7a8f5973c.var_a74530f581b4ca46;
  self.var_6497f5e71895240a = self.zombieaisettings.var_e58a65b7a8f5973c.var_a2f258abcc02dfaf;
  self.var_13d2710c4cf6f34 = 0;
  self.var_f8828e76c1282d8d = self.zombieaisettings.var_e58a65b7a8f5973c.var_92fe00d1520b1c2;
  self function_3e89eb3d8e3f1811("torpedo_cooldown", int(self.torpedo_cooldown * 1000));
  self function_3e89eb3d8e3f1811("can_interrupt_cannon", 0);
  self.var_4d7c50ad1d6ba348 = 10;
  self.var_f719fcdc90b79bb8 = 0;
  self.var_48cc0eda594ebc61 = cos(self.zombieaisettings.var_e58a65b7a8f5973c.var_3dff7f6c62879948);
}

function private function_7d71101059243aa7(params) {
  if(istrue(self getaiblackboarddynamic("can_interrupt_cannon"))) {
    if(isDefined(params.metabonename) && params.metabonename == "j_weapon_spin") {
      self.var_809957baadce26cf += params.idamage;
      self setscriptablepartstate("cannon_weakpoint", "hit");

      if(self.var_809957baadce26cf >= self.var_a722c7954f95547b && !self.var_f719fcdc90b79bb8) {
        self setscriptablepartstate("cannon_charge", "interrupt");
        self function_3e89eb3d8e3f1811("torpedo_cooldown", int(self.var_f8828e76c1282d8d * 1000));
        self function_3e89eb3d8e3f1811("can_interrupt_cannon", 0);
        self function_3e89eb3d8e3f1811("torpedo_attack_interrupted", 1);
      }

      self setscriptablepartstate("cannon_weakpoint", "default");
    }
  }
}

function private function_81245ea5bddfa425() {
  self endon("death");

  while(true) {
    self waittill("enter_ranged_attack");
    self setbtgoalstationary(2);
    self clearpath();
    self setscriptablepartstate("cannon_charge", "charge");
    self setscriptablepartstate("cannon_glow", "cannon_glow_on");
    childthread function_f5f4ccf5cb94f03e();
    self waittill("exit_ranged_attack");
    self setscriptablepartstate("cannon_charge", "default");
    self setscriptablepartstate("cannon_glow", "cannon_glow_off");
    self clearbtgoal(2);
  }
}

function private function_f5f4ccf5cb94f03e() {
  self endon("enter_ranged_attack");
  self endon("exit_ranged_attack");
  self.var_809957baadce26cf = 0;
  self waittill("interrupt_window_start");
  self function_3e89eb3d8e3f1811("can_interrupt_cannon", 1);
}

function private function_14f3052ce66da740() {
  self setscriptablepartstate("cannon_charge", "shoot");
  self setscriptablepartstate("cannon_glow", "cannon_glow_off");

  if(self._blackboard.zombieattractoristarget) {
    target = undefined;
    target_pos = self._blackboard.var_7e11be2629950382;
  } else if(isDefined(self.enemy)) {
    target = self.enemy;
    target_pos = self.enemy.origin;
  } else {
    target = undefined;
    target_pos = function_e6b708f411a51705(self.zombieaisettings.var_e58a65b7a8f5973c.torpedomaxrange);
  }

  torpedo_pos = self gettagorigin("j_weapon_spin");
  self function_3e89eb3d8e3f1811("torpedo_cooldown", int(self.torpedo_cooldown * 1000));

  if(self.var_db7207afcf1c7e9a) {
    if(self.var_13d2710c4cf6f34 < gettime()) {
      self.var_13d2710c4cf6f34 = gettime() + int(self.var_6497f5e71895240a * 1000);
      self function_3e89eb3d8e3f1811("torpedo_cooldown", 0);
    }
  }

  self function_3e89eb3d8e3f1811("can_interrupt_cannon", 0);
  launch_direction = function_eb706844215e5c19(anglesToForward(self.angles), torpedo_pos, target_pos, self.var_48cc0eda594ebc61);
  projectilemodel = "tag_origin_mangler_torpedo";

  if(isDefined(self.zombieaisettings.var_e58a65b7a8f5973c.projectilemodel)) {
    if(!is_equal(self.zombieaisettings.var_e58a65b7a8f5973c.projectilemodel, "")) {
      projectilemodel = self.zombieaisettings.var_e58a65b7a8f5973c.projectilemodel;
    }
  }

  function_abdaf24ee06fa15(torpedo_pos, launch_direction, target, target_pos, self.zombieaisettings.var_e58a65b7a8f5973c.torpedodetonationdist, self.zombieaisettings.var_e58a65b7a8f5973c.torpedovelocity, self.zombieaisettings.var_e58a65b7a8f5973c.torpedomoveintervaltime, self.zombieaisettings.var_e58a65b7a8f5973c.torpedomaxrange, self.zombieaisettings.var_e58a65b7a8f5973c.var_9bc2d6464e5ea020, self.zombieaisettings.var_e58a65b7a8f5973c.torpedoblastradius, self.zombieaisettings.var_e58a65b7a8f5973c.var_2bc6a3b41127dc16, self.zombieaisettings.var_e58a65b7a8f5973c.var_1b436d3a05c23d, self.zombieaisettings.var_e58a65b7a8f5973c.var_a2e607d2b48ccbeb, self.zombieaisettings.var_e58a65b7a8f5973c.var_a2c21dd2b4648195, 0, 0, 0, 1, "none", projectilemodel);
}

function private function_eb706844215e5c19(forward_dir, torpedo_pos, torpedo_target_pos, max_angle) {
  if(torpedo_target_pos == torpedo_pos) {
    return (0, 0, 0);
  }

  vec_to_enemy = torpedo_target_pos - torpedo_pos;
  vec_to_enemy_normal = vectorNormalize(vec_to_enemy);
  angle_to_enemy = vectordot(forward_dir, vec_to_enemy_normal);

  if(angle_to_enemy >= max_angle) {
    return vec_to_enemy_normal;
  }

  plane_normal = vectorcross(forward_dir, vec_to_enemy_normal);
  perpendicular_normal = vectorcross(plane_normal, forward_dir);
  torpedo_dir = forward_dir * cos(max_angle) + perpendicular_normal * sin(max_angle);
  return torpedo_dir;
}

function private function_db02e333586efd39() {
  self endon("death");

  while(true) {
    self waittill("bshoottorpedostarted");
    thread function_8689ae83937de409();
    self waittill("bshoottorpedoended");
  }
}

function private function_8689ae83937de409() {
  self endon("death");
  self endon("bshoottorpedoended");
  self endon("bshoottorpedostarted");
  waitframe();
  self waittill("shoot_torpedo_projectile");

  if(isDefined(self.var_14f3052ce66da740)) {
    [[self.var_14f3052ce66da740]]();
  }
}

function private function_e6b708f411a51705(maxrange) {
  start = self getEye();
  dir = anglesToForward(self.angles);
  end = start + maxrange * dir;
  return end;
}