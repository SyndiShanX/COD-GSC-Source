/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1347.gsc
**************************************/

main() {
  level._effect["_breach_doorbreach_detpack"] = loadfx("explosions/exp_pack_doorbreach");
  level._effect["_breach_doorbreach_kick"] = loadfx("dust/door_kick");
  level.scr_sound["breach_wooden_door"] = "detpack_explo_main";
  level.scr_sound["breach_wood_door_kick"] = "wood_door_kick";
  common_scripts\utility::flag_init("begin_the_breach");
}

_id_4010(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("breach_abort");

  if(isDefined(var_5) && var_5 == 0) {
    anim._id_20D6["scripted"] = ::_id_4032;

  }
  self._id_4011 = 0;
  self._id_4012 = undefined;
  self._id_4013 = undefined;
  self._id_4014 = 0;
  self._id_4015 = 0;
  self._id_4016 = 0;
  self._id_4017 = 0;
  self._id_4018 = 0;
  self._id_4019 = 0;
  self._id_401A = 0;
  self._id_401B = 0;
  self._id_401C = 1;
  self._id_401D = 0;
  self._id_401E = 0;
  var_6 = getEntArray(self.targetname, "targetname");
  var_7 = self.targetname;
  self._id_401F = "badplace_" + var_7;
  self._id_4020 = getent("badplace_" + var_7, "targetname");

  if(isDefined(self._id_4020)) {}

  self._id_4021 = getent("trigger_" + var_7, "targetname");

  if(!isDefined(var_4)) {
    var_4 = 1;

  }
  if(isDefined(self._id_4021)) {
    switch (self._id_4021.classname) {
      case "trigger_use":
        self._id_4022 = var_2;
        break;
      case "trigger_use_touch":
        self._id_4022 = var_2;
        break;
      case "trigger_radius":
        break;
      case "trigger_multiple":
        break;
      default:
        break;
    }
  }

  switch (var_1) {
    case "explosive_breach_left":
      break;
    case "shotgunhinges_breach_left":
      break;
    case "flash_breach_no_door_right":
      self._id_401C = 0;
      self._id_401D = 1;
      break;
    default:
      break;
  }

  if(self._id_401C == 1) {
    self._id_4023 = getent(self.script_linkto, "script_linkname");

    if(self._id_4023.classname == "script_model") {
      self._id_4013 = spawn("script_origin", self._id_4023.origin);
      self._id_4013.angles = self._id_4023.angles;
    } else if(self._id_4023.classname == "script_brushmodel") {
      self._id_4013 = getent(self._id_4023.target, "targetname");
      self._id_4023._id_4024 = anglesToForward(self._id_4013.angles);
    }

    self._id_4013.type = "Cover Right";
    self._id_4025 = getent(self._id_4023.script_linkto, "script_linkname");
    self._id_4026 = self._id_4025.script_exploder;
  } else if(self._id_401C == 0) {
    self._id_4013 = getent(self.script_linkto, "script_linkname");

  }
  if(self._id_401D == 1) {
    self._id_4027 = getent("flashthrow_" + var_7, "targetname");
    self._id_4028 = getent(self._id_4027.target, "targetname");
  }

  thread _id_403B(var_0);
  thread _id_403C(var_0);
  thread _id_403E(var_1, var_4);
  var_8 = 0;

  for(var_9 = 0; var_9 < var_0.size; var_9++) {
    if(isDefined(var_0[var_9]._id_4029)) {
      var_8++;
      self._id_4012 = var_0[var_9];
    }
  }

  if(var_8 > 0) {} else {
    self._id_4012 = maps\_utility::_id_0AE9(self._id_4013.origin, var_0);

  }
  if(var_0.size == 1) {
    self._id_4017 = 1;

  }
  for(var_9 = 0; var_9 < var_0.size; var_9++) {
    var_0[var_9] thread _id_402C(self, var_1, var_5);

  }
  while(self._id_4015 < var_0.size) {
    wait 0.05;

  }
  self notify("ready_to_breach");
  self._id_4018 = 1;

  if(isDefined(self._id_4021)) {
    self._id_4021 thread _id_4038(self);
    self waittill("execute_the_breach");
  } else {
    self notify("execute_the_breach");

  }
  common_scripts\utility::flag_set("begin_the_breach");
  self._id_401A = 1;

  if(isDefined(var_3) && var_3 == 1) {
    var_10 = getEntArray("hostiles_" + var_7, "targetname");
    self waittill("spawn_hostiles");
    _id_4040(var_10);
    self._id_401E = 1;
  }

  if(isDefined(self._id_4020)) {
    badplace_cylinder(self._id_401F, -1, self._id_4020.origin, self._id_4020.radius, 200, "bad_guys");

  }
  var_11 = getaiarray("bad_guys");
  var_12 = [];

  for(var_9 = 0; var_9 < var_11.size; var_9++) {
    if(var_11[var_9] istouching(self)) {
      var_12[var_12.size] = var_11[var_9];
    }
  }

  if(var_12.size > 0) {
    common_scripts\utility::array_thread(var_12, ::_id_4035, self);

  }
  while(!self._id_4019) {
    wait 0.05;

  }
  self notify("breach_complete");

  if(!var_12.size) {
    return;
  }
  while(!self._id_401B) {
    wait 0.05;

    for(var_9 = 0; var_9 < var_12.size; var_9++) {
      if(!isalive(var_12[var_9])) {
        var_12 = common_scripts\utility::array_remove(var_12, var_12[var_9]);

      }
      if(var_12.size == 0) {
        self._id_401B = 1;
      }
    }
  }
}

_id_402A() {
  while(self._id_402B == 1) {
    self waittillmatch("single anim", "fire");
    self.a._id_0AA7 = gettime();
  }
}

_id_402C(var_0, var_1, var_2) {
  self._id_402B = 1;
  self._id_402D = undefined;

  if(!isDefined(var_2)) {
    var_2 = 1;

  }
  self pushplayer(1);
  thread _id_4041();
  var_0 endon("breach_abort");
  self._id_13F8 = "stop_idle_" + self getentitynumber();
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;

  if(self == var_0._id_4012) {
    var_3 = "01";
  } else {
    var_3 = "02";

  }
  if(var_0._id_4017 == 1 && var_1 == "explosive_breach_left") {
    var_3 = "02";

  }
  switch (var_1) {
    case "explosive_breach_left":
      if(isDefined(self._id_402E) && self._id_402E == 0) {
        var_4 = "detcord_stack_left_start_no_approach_" + var_3;
      } else {
        var_4 = "detcord_stack_left_start_" + var_3;

      }
      var_5 = "detcord_stack_leftidle_" + var_3;
      var_6 = "detcord_stack_leftbreach_" + var_3;
      break;
    case "shotgunhinges_breach_left":
      var_4 = "shotgunhinges_breach_left_stack_start_" + var_3;
      var_5 = "shotgunhinges_breach_left_stack_idle_" + var_3;
      var_6 = "shotgunhinges_breach_left_stack_breach_" + var_3;
      break;
    case "flash_breach_no_door_right":
      if(var_0._id_4017 == 1) {
        var_4 = "flash_stack_right_start_single";
        var_5 = "flash_stack_right_idle_single";
        var_6 = "flash_stack_right_breach_single";
        var_7 = "flash_stack_right_flash_single";
      } else {
        var_4 = "flash_stack_right_start_" + var_3;
        var_5 = "flash_stack_right_idle_" + var_3;
        var_6 = "flash_stack_right_breach_" + var_3;
        var_7 = "flash_stack_right_flash_" + var_3;
      }

      break;
    default:
      break;
  }

  _id_4047(64);

  if(!isDefined(self._id_402E) || self._id_402E) {
    var_0._id_4013 maps\_anim::_id_11C4(self, var_4);
  } else {
    self.scriptedarrivalent = var_0._id_4013;
    var_0._id_4013 maps\_anim::_id_11C5(self, var_4);
  }

  var_0._id_4013 maps\_anim::_id_11C1(self, var_4);
  var_0._id_4013 thread maps\_anim::_id_11C8(self, var_5, self._id_13F8);
  self._id_402F = self.origin;
  var_0._id_4015++;
  self.scriptedarrivalent = undefined;
  var_0 waittill("execute_the_breach");

  if(!var_0._id_4011 && isDefined(var_7)) {
    var_0._id_4013 notify(self._id_13F8);
    var_0._id_4013 thread maps\_anim::_id_11C1(self, var_7);
    wait 1;

    if(var_3 == "02" || var_0._id_4017 == 1) {
      var_8 = "J_Mid_LE_1";
      self attach("projectile_m84_flashbang_grenade", var_8);
      var_9 = self.grenadeweapon;
      self.grenadeweapon = "flash_grenade";
      self.grenadeammo++;

      if(var_3 == "02") {
        self waittillmatch("single anim", "grenade_throw");

      }
      if(var_0._id_4017 == 1 && var_3 == "01") {
        self waittillmatch("single anim", "fire");

      }
      self magicgrenade(var_0._id_4027.origin, var_0._id_4028.origin, level._id_4030);
      self detach("projectile_m84_flashbang_grenade", var_8);
      self.grenadeweapon = var_9;
      self.grenadeammo = 0;
    }

    self waittillmatch("single anim", "end");
    var_0._id_4013 thread maps\_anim::_id_11C8(self, var_5, self._id_13F8);
    wait 0.1;
  }

  var_0._id_4013 notify(self._id_13F8);

  if(var_2 == 0) {
    self._id_402D = 1;

  }
  var_0._id_4013 thread maps\_anim::_id_11C1(self, var_6);

  if(var_1 == "explosive_breach_left") {
    if(var_3 == "02") {
      thread _id_4033(var_0);
      self waittillmatch("single anim", "pull fuse");
      wait 1;
      var_0 notify("spawn_hostiles");
      var_0 notify("detpack_about_to_blow");
      self waittillmatch("single anim", "explosion");
      var_0 notify("detpack_detonated");
      var_0._id_4014 = 1;
      var_0._id_4023 thread _id_4042("explosive", var_0);
      var_0 notify("play_breach_fx");
    }
  } else if(var_1 == "shotgunhinges_breach_left") {
    if(var_3 == "01") {
      var_0 notify("spawn_hostiles");
      self waittillmatch("single anim", "kick");
      var_0._id_4023 thread _id_4042("shotgun", var_0);
      var_0 notify("play_breach_fx");
    }
  } else if(var_1 == "flash_breach_no_door_right") {}

  self waittillmatch("single anim", "end");
  self notify("breach_complete");

  if(var_2 == 0) {
    self._id_402D = undefined;

  }
  if(isDefined(level._id_4031)) {
    self thread[[level._id_4031]](var_0);

  }
  var_0._id_4019 = 1;
  self pushplayer(0);
  _id_404C();

  while(!var_0._id_401B) {
    wait 0.05;

  }
  self._id_402B = 0;
}

_id_4032() {
  if(isDefined(self._id_402D)) {
    return;
  }
  animscripts\notetracks::_id_20D5();
}

_id_4033(var_0) {
  thread _id_4034(var_0);
  self waittillmatch("single anim", "attach prop right");
  var_1 = "TAG_INHAND";
  self attach("weapon_detcord", var_1);
  self waittillmatch("single anim", "detach prop right");
  var_2 = self gettagorigin(var_1);
  var_3 = self gettagangles(var_1);
  self detach("weapon_detcord", var_1);
  var_4 = spawn("script_model", var_2);
  var_4 setModel("weapon_detcord");
  var_4.angles = var_3;
  var_0 waittill("detpack_detonated");
  radiusdamage(var_4.origin, 64, 50, 25);
  var_4 delete();
}

_id_4034(var_0) {
  self waittillmatch("single anim", "sound effect");
  thread common_scripts\utility::play_sound_in_space("detpack_plant_arming", var_0._id_4013.origin);
}

_id_4035(var_0) {
  self endon("death");
  var_0 endon("breach_aborted");
  var_0 waittill("detpack_detonated");

  if(distance(self.origin, var_0._id_4013.origin) <= level._id_4036) {
    level._id_4037++;

    if(level._id_4037 > 2) {
      level._id_4037 = 1;

    }
    var_1 = "exposed_flashbang_v" + level._id_4037;
    self.allowdeath = 1;
    maps\_anim::_id_11CC(self, "gravity", var_1);
    _id_404C();
  }
}

_id_4038(var_0) {
  var_0 endon("execute_the_breach");
  var_0 endon("breach_aborted");
  thread _id_4039(var_0);
  self waittill("trigger");
  var_0 notify("execute_the_breach");
}

_id_4039(var_0) {
  var_0 waittill("execute_the_breach");
  common_scripts\utility::trigger_off();

  if(isDefined(var_0._id_403A)) {
    var_0._id_403A delete();
  }
}

_id_403B(var_0) {
  self endon("breach_complete");
  self waittill("breach_abort");
  self._id_401B = 1;
  thread _id_403C(var_0);
}

_id_403C(var_0) {
  while(!self._id_401B) {
    wait 0.05;

  }
  if(isDefined(self._id_4020)) {
    badplace_delete(self._id_401F);

  }
  while(!self._id_401B) {
    wait 0.05;

  }
  common_scripts\utility::array_thread(var_0, ::_id_403D, self);
}

_id_403D(var_0) {
  self endon("death");
  _id_404C();
  _id_4049();
  var_0._id_4013 notify(self._id_13F8);
  self notify("stop_infinite_ammo");
  self pushplayer(0);
}

_id_403E(var_0, var_1) {
  self endon("breach_aborted");
  self endon("breach_complete");

  switch (var_0) {
    case "explosive_breach_left":
      self waittill("play_breach_fx");
      common_scripts\utility::exploder(self._id_4026);
      thread common_scripts\utility::play_sound_in_space(level.scr_sound["breach_wooden_door"], self._id_4025.origin);

      if(var_1) {
        playFX(level._effect["_breach_doorbreach_detpack"], self._id_4025.origin, anglesToForward(self._id_4025.angles));

      }
      break;
    case "shotgunhinges_breach_left":
      self waittill("play_breach_fx");
      common_scripts\utility::exploder(self._id_4026);

      if(var_1) {
        playFX(level._effect["_breach_doorbreach_kick"], self._id_4025.origin, anglesToForward(self._id_4025.angles));

      }
      break;
    case "flash_breach_no_door_right":
      break;
    default:
      break;
  }
}

_id_403F(var_0) {
  var_1 = var_0 dospawn();
  maps\_utility::_id_13AF(var_1);
  return var_1;
}

_id_4040(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = _id_403F(var_0[var_2]);
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_4041() {
  self endon("death");
  self endon("stop_infinite_ammo");

  while(isDefined(self.weapon)) {
    if(isDefined(self.weapon) && self.weapon == "none") {
      break;
    }

    self._id_0CD1 = weaponclipsize(self.weapon);
    wait 0.5;
  }
}

_id_4042(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;

  }
  if(var_2 == 1) {
    self playSound(level.scr_sound["breach_wood_door_kick"]);

  }
  switch (var_0) {
    case "explosive":
      thread _id_4046(var_1._id_4013);
      _id_4045();
      self playSound(level.scr_sound["breach_wooden_door"]);
      earthquake(0.4, 1, self.origin, 1000);
      radiusdamage(self.origin, 56, level._id_4044, level._id_4043);
      break;
    case "shotgun":
      thread _id_4046(var_1._id_4013);
      _id_4045();
      self playSound(level.scr_sound["breach_wooden_door"]);
      break;
  }
}

_id_4045() {
  if(self.classname == "script_brushmodel") {
    self connectpaths();
  } else {
    var_0 = getent(self.target, "targetname");
    var_0 hide();
    var_0 notsolid();
    var_0 connectpaths();
  }
}

_id_4046(var_0) {
  var_1 = undefined;

  if(self.classname == "script_model") {
    var_1 = anglesToForward(self.angles);
  } else if(self.classname == "script_brushmodel") {
    var_1 = self._id_4024;
  } else {}

  var_2 = (var_1[0] * 20, var_1[1] * 20, var_1[2] * 20);
  self moveto(self.origin + var_2, 0.5, 0, 0.5);
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3.angles = var_0.angles;
  var_3.origin = (self.origin[0], self.origin[1], var_0.origin[2]);
  self linkto(var_3);
  var_3 rotatepitch(90, 0.45, 0.4);
  wait 0.45;
  var_3 rotatepitch(-4, 0.2, 0, 0.2);
  wait 0.2;
  var_3 rotatepitch(4, 0.15, 0.15);
  wait 0.15;
  self unlink();
  var_3 delete();
}

_id_4047(var_0) {
  if(!isDefined(self._id_4048)) {
    self._id_4048 = self.goalradius;

  }
  self.goalradius = var_0;
}

_id_4049() {
  if(isDefined(self._id_4048)) {
    self.goalradius = self._id_4048;

  }
  self._id_4048 = undefined;
}

_id_404A(var_0) {
  if(!isDefined(self._id_404B)) {
    self._id_404B = self._id_1032;

  }
  self._id_1032 = var_0;
}

_id_404C() {
  if(isDefined(self._id_404B)) {
    self._id_1032 = self._id_404B;

  }
  self._id_404B = undefined;
}