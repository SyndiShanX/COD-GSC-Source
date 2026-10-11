/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_62030af0ae9e7af7.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_41387eecc35b88bf;
#using script_4fdefae8b7bcdf73;
#using script_7956d56c4922bd1;
#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_fdbfca209b31f6bc;

function autoexec init() {
  level.var_96a00a6fce3851c3 = &function_fd025b68ea2ab09b;
}

function function_fd025b68ea2ab09b() {
  if(istrue(level.var_9171353caa234820)) {
    return;
  }

  scripts\engine\utility::registersharedfunc("team_mortars", "area_think", &function_1cedfbacbd1bddeb);
  scripts\engine\utility::registersharedfunc("team_mortars", "mortar_stop", &function_a128e22c4e9eb9d1);
  scripts\engine\utility::registersharedfunc("team_mortars", "assign_operator", &function_bdeacfac8ee989b9);
  scripts\engine\utility::registersharedfunc("team_mortars", "clear_operator_data", &clear_operator_data);

  if(!isDefined(level.var_7b72ab0f386ab374)) {
    level.var_7b72ab0f386ab374 = [];
  }

  load_fx();
  level.var_9171353caa234820 = 1;
}

function private load_fx() {
  level._effect["vfx_mortar_fire"] = loadfx("vfx/jup/ob_warlords/gameplay/rainmaker_mortar/vfx_mortar_fire.vfx");
  level._effect["vfx_mortar_trail"] = loadfx("vfx/iw9/core/weapons/trails/vfx_mortar_trail_1.vfx");
}

function function_1cedfbacbd1bddeb(activityinstance) {
  level endon("game_ended");
  var_c718c3fcabaa752f = scripts\engine\utility::drop_to_ground(self.origin);
  mortar = spawnscriptable("ob_team_mortar", var_c718c3fcabaa752f, self.angles);
  mortar setscriptablepartstate("main", "idle");

  if(isDefined(activityinstance)) {
    mortar.activityinstance = activityinstance;
    activityinstance.mortar_instances[activityinstance.mortar_instances.size] = mortar;
  }

  level.var_7b72ab0f386ab374[level.var_7b72ab0f386ab374.size] = mortar;
  mortar ent_flag_init("original_mortar_operator_assigned");
  mortar thread function_c8aec5f18ecb0fd1();
  mortar waittill("original_mortar_operator_assigned");
  mortar.operator.var_20b7d0a68a84fc75 = 1;
  thread function_eebda6f2e2be18ff(mortar);

  if(getdvarint(@ "hash_95fb4e534f704832", 0)) {
    mortar.operator waittill("death", killer);
    var_4d4da496a28748ce = isDefined(mortar.operator);
    function_a128e22c4e9eb9d1(mortar);
    wait 3;

    if(var_4d4da496a28748ce) {
      mortar playSound("sentry_explode");
    }
  }
}

function function_a128e22c4e9eb9d1(mortar_launcher) {
  mortar_launcher.dead = 1;

  if(isDefined(mortar_launcher.operator)) {
    mortar_launcher.operator clear_operator_data();
    mortar_launcher.operator = undefined;
  }

  mortar_launcher notify("stop_mortar_think");
  mortar_launcher notify("stop_attracting");
}

function private function_eebda6f2e2be18ff(mortar_launcher) {
  mortar_launcher endon("stop_mortar_think");
  mortar_launcher endon("stop_attracting");
  mortar_launcher.get_mortar_impact_pos = &function_46aa4fcdd94bff71;
  var_fefc8f2e6fdb990b = getdvarfloat(@ "hash_b54b5f2e0734064f", 1);
  var_aec232bd9fb82e6a = getdvarint(@ "hash_a292a66bed2b23bb", 1);
  var_11b5c041ab4ceeb8 = getdvarint(@ "hash_59af251c7c9bdf35", 2);
  mortar_launcher.disable_distance = getdvarfloat(@ "hash_c657f0e805ffc01", 400);
  mortar_launcher.targeting_radius = isDefined(self.radius) ? float(self.radius) : 1000;
  mortar_launcher.targeting_angle = isDefined(self.targeting_angle) ? float(self.targeting_angle) : 60;
  mortar_launcher.var_1115d9ebad86e77 = getdvarint(@ "hash_28d9cfba843939d9", 3);
  mortar_launcher.var_1957e63417a88722 = getdvarint(@ "hash_2b38f7c9167ce130", 0);
  mortar_launcher.current_wait = 1;
  level notify("on_mortar_setup", mortar_launcher);

  while(true) {
    var_a193984f2b0fff84 = getdvarfloat(@ "hash_6b1fca9ec135556e");

    if(var_a193984f2b0fff84 > 0) {
      mortar_launcher.targeting_angle = var_a193984f2b0fff84;
    }

    var_23271a4be2eb8f2e = getdvarfloat(@ "hash_5b711f3e70d1ac28");

    if(var_23271a4be2eb8f2e > 0) {
      mortar_launcher.targeting_radius = var_23271a4be2eb8f2e;
    }

    if(!mortar_launcher function_a07d239817137b11()) {
      wait var_fefc8f2e6fdb990b;
    }

    if(!isDefined(mortar_launcher.operator)) {
      mortar_launcher notify("force_mortar_operator_replacement");
      wait 1;
      continue;
    }

    mortar_launcher function_1958787ecae41e95();

    if(isDefined(mortar_launcher.current_target)) {
      mortar_launcher.current_wait = randomintrange(var_aec232bd9fb82e6a, var_11b5c041ab4ceeb8);
      function_9724312ee56d42ad(mortar_launcher, 1);
      mortar_launcher.potentialtargets = undefined;
      mortar_launcher.current_target = undefined;
      wait mortar_launcher.current_wait;
      continue;
    }

    if(isDefined(mortar_launcher.operator) && isanimScripted(mortar_launcher.operator)) {
      mortar_launcher.operator function_46ee349c6b8f6741();
    }

    mortar_launcher.potentialtargets = undefined;
    mortar_launcher.current_target = undefined;
    wait var_fefc8f2e6fdb990b;
  }
}

function private function_1958787ecae41e95() {
  self.current_target = undefined;

  if(!(isDefined(self.potentialtargets) && self.potentialtargets.size > 0) && !(isDefined(self.var_566ba4e203174585) && self.var_566ba4e203174585.size > 0)) {
    return;
  }

  if(!(isDefined(self.potentialtargets) && self.potentialtargets.size > 0)) {
    self.potentialtargets = self.var_566ba4e203174585;
  }

  if(self.potentialtargets.size == 0) {
    if(getdvarint(@ "hash_5596ff0bf7ea7af6", 0)) {
      thread scripts\cp_mp\utility\debug_utility::drawangles(self.origin, self.angles, self.current_wait + 2);
    }

    return;
  }

  var_d26386496b793f40 = self.targeting_angle * 0.5;

  if(getdvarint(@ "hash_5596ff0bf7ea7af6", 0)) {
    thread scripts\cp_mp\utility\debug_utility::drawangles(self.origin, self.angles, self.current_wait + 2);
    var_4b9d53c8991cec02 = anglesToForward(self.angles);
    leftside = rotatevector(var_4b9d53c8991cec02, (0, var_d26386496b793f40 * -1, 0));
    rightside = rotatevector(var_4b9d53c8991cec02, (0, var_d26386496b793f40, 0));
    thread draw_line_for_time(self.origin, self.origin + leftside * self.targeting_radius, 1, 0, 0, self.current_wait + 2);
    thread draw_line_for_time(self.origin, self.origin + rightside * self.targeting_radius, 0, 0, 1, self.current_wait + 2);
  }

  if(istrue(self.var_1957e63417a88722)) {
    self.current_target = random(self.potentialtargets);
  } else {
    self.current_target = self.potentialtargets[0];
  }

  if(getdvarint(@ "hash_5596ff0bf7ea7af6", 0)) {
    if(isDefined(self.current_target)) {
      var_d3e70436ec53d0d1 = self.current_target.origin - self.origin;
      thread draw_line_for_time(self.origin, self.origin + var_d3e70436ec53d0d1, 0, 1, 0, self.current_wait + 2);
    }
  }

}

function private function_643c81ad5e753613() {
  excludelist = undefined;

  if(isDefined(self.activityinstance.mortar_instances)) {
    foreach(var_ebb3ef01eac3fb40 in self.activityinstance.mortar_instances) {
      if(var_ebb3ef01eac3fb40 != self && isDefined(var_ebb3ef01eac3fb40.current_target)) {
        if(!isDefined(excludelist)) {
          excludelist = [];
        }

        excludelist[excludelist.size] = var_ebb3ef01eac3fb40.current_target;
      }
    }
  }

  return excludelist;
}

function private function_a07d239817137b11() {
  self.potentialtargets = [];
  self.var_566ba4e203174585 = [];
  closetargets = function_8bdfc9247fd9402f(self.disable_distance, []);
  var_c4100aeeaedf6daa = 1;

  if(isDefined(closetargets) && closetargets.size > 0) {
    var_c4100aeeaedf6daa = 0;
  } else {
    self.var_566ba4e203174585 = function_643c81ad5e753613();
    self.potentialtargets = function_8bdfc9247fd9402f(self.targeting_radius, self.var_566ba4e203174585, 1);

    if(!isDefined(self.potentialtargets) || self.potentialtargets.size <= 0) {
      var_c4100aeeaedf6daa = 0;
    }
  }

  if(var_c4100aeeaedf6daa) {
    if(istrue(self.var_a4cf3e4a10a4e803)) {
      self.var_a4cf3e4a10a4e803 = 0;
      self notify("resume_mortar_operator_replacement");
    }
  } else {
    self.var_a4cf3e4a10a4e803 = 1;
    self notify("pause_mortar_operator_replacement");
  }

  return var_c4100aeeaedf6daa;
}

function function_3d5e2b560f11caeb() {
  if(!isDefined(self) || !isagent(self) || !isalive(self) || !isagent(self) || self.unittype != "soldier" || isDefined(self getinteractionid())) {
    return false;
  }

  if(istrue(self.var_20b7d0a68a84fc75)) {
    return false;
  }

  if(self.subclass == "ob_sniper" || self.subclass == "ob_rocketeer" || self.subclass == "ob_tactician" || self.subclass == "ob_shielded" || self.subclass == "ob_rusher") {
    return false;
  }

  return true;
}

function function_c8aec5f18ecb0fd1() {
  level endon("game_ended");
  self endon("stop_mortar_think");

  while(true) {
    if(isDefined(self.operator)) {
      waittill_any_ents(self, "force_mortar_operator_replacement", self, "pause_mortar_operator_replacement", self.operator, "death");
    }

    if(isDefined(self.operator)) {
      self.operator clear_operator_data();
      self.operator = undefined;
    }

    if(!istrue(self.var_a4cf3e4a10a4e803)) {
      agent = function_16ab2219925a2f43();

      if(isDefined(agent)) {
        if(function_bdeacfac8ee989b9(agent)) {
          if(ent_flag_exist("original_mortar_operator_assigned") && !ent_flag("original_mortar_operator_assigned")) {
            ent_flag_set("original_mortar_operator_assigned");
          }

          continue;
        }
      }
    }

    waittill_any_timeout_1(getdvarint(@ "hash_dec005ccb997b1dc", 3), "resume_mortar_operator_replacement");
  }
}

function function_16ab2219925a2f43() {
  radiussquared = getdvarint(@ "hash_bfc9963224070271", 2000);

  if(function_a794fcf9545f2062()) {
    nearbyai = getentitiesinradiusfrompartitiongrid(self.origin, radiussquared, createentitytypemask(["etype_ai"]), [], "team_hundred_ninety");
  } else {
    nearbyai = getaiarrayinradius(self.origin, radiussquared, "team_hundred_ninety");
  }

  var_b3d2c590b879f78d = sortbydistance(nearbyai, self.origin);

  if(!isDefined(var_b3d2c590b879f78d) || var_b3d2c590b879f78d.size == 0) {
    return undefined;
  }

  foreach(agent in var_b3d2c590b879f78d) {
    if(!agent function_3d5e2b560f11caeb()) {
      continue;
    }

    return agent;
  }
}

function function_8bdfc9247fd9402f(radius, excludelist, var_f1850a701d655011) {
  if(function_a794fcf9545f2062()) {
    nearbytargets = getentitiesinradiusfrompartitiongrid(self.origin, radius, createentitytypemask(["etype_player"]), excludelist);
  } else {
    nearbytargets = scripts\mp\utility\player::getplayersinradius(self.origin, radius, undefined, excludelist);
  }

  if(istrue(var_f1850a701d655011)) {
    for(targetindex = 0; targetindex < nearbytargets.size; targetindex++) {
      target = nearbytargets[targetindex];

      if(!function_673a8676a69f557a(target)) {
        nearbytargets[targetindex] = nearbytargets[nearbytargets.size - 1];
        nearbytargets[nearbytargets.size - 1] = undefined;
        continue;
      }
    }
  }

  sortedtargets = sortbydistance(nearbytargets, self.origin);

  if(!isDefined(sortedtargets) || sortedtargets.size == 0) {
    return undefined;
  }

  return sortedtargets;
}

function function_673a8676a69f557a(target) {
  var_d26386496b793f40 = self.targeting_angle * 0.5;
  var_21a4d4abf6d829bd = cos(var_d26386496b793f40);

  if(istrue(target.inlaststand) || istrue(target.notarget) || istrue(target.ignoreme) || istrue(target.disguised) || !isalive(target) || !scripts\engine\math::point_in_fov(target.origin, var_21a4d4abf6d829bd)) {
    return false;
  }

  return true;
}

function function_bdeacfac8ee989b9(operator) {
  if(!isDefined(operator) || !operator function_3d5e2b560f11caeb()) {
    return false;
  }

  if(!isDefined(operator.ob)) {
    operator.ob = spawnStruct();
  }

  operator.ob.var_9fba290ca0c3f1c9 = operator.script_stealthgroup;
  operator.ob.var_f1b80818f8c6a187 = operator.goalvolume;
  operator.script_stealthgroup = undefined;
  operator cleargoalvolume();
  operator setgoalpos(self.origin, 100);
  operator.customarrivalangles = self.angles;
  operator.var_20b7d0a68a84fc75 = 1;
  operator.var_eb504fc7e1cfeb4c = 1;
  self.operator = operator;
  return true;
}

function clear_operator_data() {
  self notify("ending_mortar_launch");
  self.var_20b7d0a68a84fc75 = undefined;

  if(!isalive(self)) {
    return;
  }

  self allowedstances("stand", "prone", "crouch");

  if(isDefined(self._blackboard)) {
    scripts\asm\shared\mp\utility::cancelanimscriptmp();
  }

  if(isDefined(self.never_kill_off_old)) {
    self.never_kill_off = self.never_kill_off_old;
    self.never_kill_off_old = undefined;
  }

  if(isDefined(self.var_4a016db32ec2e4c1)) {
    self.dontkilloff = self.var_4a016db32ec2e4c1;
    self.var_4a016db32ec2e4c1 = undefined;
  }

  if(!istrue(self.dont_enter_combat)) {
    self.ignoreall = 0;
  }

  self.scripted_mode = 0;
  self.playing_skit = undefined;

  if(isDefined(self.anchor)) {
    self unlink();
    self.anchor delete();
  }

  self cleargoalentity();
  self.customarrivalangles = undefined;
  self.var_eb504fc7e1cfeb4c = 0;

  if(isDefined(self.ob)) {
    if(isDefined(self.ob.var_9fba290ca0c3f1c9)) {
      self.script_stealthgroup = self.ob.var_9fba290ca0c3f1c9;
    }

    if(isDefined(self.ob.var_f1b80818f8c6a187)) {
      self setgoalvolumeauto(self.ob.var_f1b80818f8c6a187);
    }
  } else if(isDefined(self.goal_volumes) && self.goal_volumes.size > 0) {
    self setgoalvolumeauto(self.goal_volumes[0]);
  }

  if(isDefined(self.old_weapon)) {
    self giveweapon(self.old_weapon);
    self takeweapon(self.anim_weapon);
    self setspawnweapon(self.old_weapon);
  }

  utility::clear_demeanor_override();
}

function private function_9724312ee56d42ad(mortar_launcher, var_68ee057779a106c1) {
  mortar_launcher endon("stop_attracting");
  runner = undefined;

  if(isDefined(mortar_launcher.operator) && isalive(mortar_launcher.operator)) {
    mortar_launcher.operator function_b341b363d683c952(mortar_launcher, var_68ee057779a106c1);

    if(istrue(mortar_launcher.fired)) {
      level notify("flare_launched");
      mortar_launcher.attracting = 0;
    } else {
      var_6635d9b698a10da = getdvarint(@ "hash_b61eecb228bbcf5d", 3);
      wait var_6635d9b698a10da;
    }

    return;
  }

  mortar_launcher notify("force_mortar_operator_replacement");
}

function private function_b341b363d683c952(launcher, var_68ee057779a106c1) {
  self endon("death");
  self endon("teleport_to_nearby_spawner");
  self endon("ending_mortar_launch");
  launcher.fired = 0;
  thread handle_ai_launcher_death(launcher);

  while(isDefined(self getinteractionid()) || !self asmhasstate(self.asmname, "animscripted")) {
    wait 1;
  }

  self.going_to_object = launcher;
  old_radius = self.goalradius;
  utility::demeanor_override("sprint");
  self.never_kill_off_old = self.never_kill_off;
  self.never_kill_off = 1;
  self.var_4a016db32ec2e4c1 = self.dontkilloff;
  self.dontkilloff = 1;

  if(run_to_launcher(launcher)) {
    enter_launcher(launcher);
    fire_launcher(launcher);
    exit_launcher(launcher);
    self.goalradius = old_radius;
    self.going_to_object = undefined;

    if(isDefined(var_68ee057779a106c1)) {
      self.goalradius = 128;
      launcher.operator = self;
      launcher.operator.var_20b7d0a68a84fc75 = 1;
      thread mortar_cooldown(launcher);
    }
  }

  function_46ee349c6b8f6741();
}

function private function_46ee349c6b8f6741() {
  clear_custom_anim();
  utility::clear_demeanor_override();

  if(isDefined(self.never_kill_off_old)) {
    self.never_kill_off = self.never_kill_off_old;
    self.never_kill_off_old = undefined;
  }

  if(isDefined(self.var_4a016db32ec2e4c1)) {
    self.dontkilloff = self.var_4a016db32ec2e4c1;
    self.var_4a016db32ec2e4c1 = undefined;
  }
}

function private mortar_cooldown(launcher) {
  waittill_any_2("death", "teleport_to_nearby_spawner");

  if(isDefined(launcher) && isent(launcher)) {
    cooldownduration = getdvarint(@ "hash_9f9ad08ef36acbf7", 1000);

    if(isDefined(launcher.operator)) {
      launcher.operator clear_operator_data();
    }

    launcher.operator = undefined;
    launcher.oncooldown = gettime() + cooldownduration;
  }
}

function private ai_anim(animalias, early_return) {
  take_ai_weapon();

  if(isDefined(early_return)) {
    scripts\asm\shared\mp\utility::animscripted_single_earlyend(animalias, early_return);
  } else {
    scripts\asm\shared\mp\utility::animscripted_single(animalias);
  }

  restore_ai_weapon();
}

function private take_ai_weapon() {
  self.old_weapon = self.weapon;
  self.anim_weapon = scripts\cp_mp\weapon::buildweapon("iw9_me_fists_mp", [], "none", "none", -1);
  self giveweapon(self.anim_weapon);
  self takeweapon(self.old_weapon);
  self setspawnweapon(self.anim_weapon);
}

function private restore_ai_weapon() {
  self giveweapon(self.old_weapon);
  self takeweapon(self.anim_weapon);
  self setspawnweapon(self.old_weapon);
}

function private ai_anim_relative(animalias, ent) {
  take_ai_weapon();
  scripts\asm\shared\mp\utility::animscripted_single_relative(animalias, ent);
  restore_ai_weapon();
}

function private enter_launcher(launcher) {
  ai_anim("sdr_mortar_enter", 0.7);
  launcher setscriptablepartstate("main", "start_shell_launch");
}

function private fire_launcher(launcher) {
  ai_anim("sdr_mortar_launch", 0.4);
  launcher thread launch_mortar(undefined, undefined, self);
  self notify("mortar_shell_launch_started");
  launcher setscriptablepartstate("main", "idle");
  wait 0.4;
}

function private launch_mortar(start, end, agent, optional_height) {
  if(!isDefined(start)) {
    start = coordtransform((30, 0, 20), self.origin, self.angles);
  }

  if(isDefined(self.get_mortar_impact_pos)) {
    end = agent[[self.get_mortar_impact_pos]](self);
  }

  if(!isDefined(end)) {
    if(getdvarint(@ "hash_f8b2681de5f8273c", 1) == 1) {
      return;
    } else {
      end = getgroundposition(self.origin + anglesToForward(self.angles) * 2000, 8, 1000);
    }
  }

  mortarshell = spawn_tag_origin(start, (0, 0, 0));
  mortarshell setModel("equipment_mortar_shell_improvised_01");
  playFX(getfx("vfx_mortar_fire"), self.origin, anglesToForward(self.angles));
  playsoundatpos(start, "weap_mortar_fire_dist");
  mortarshell show();
  time = self.var_1115d9ebad86e77;
  apex_height = 1200;

  if(isDefined(optional_height)) {
    apex_height = optional_height;
  }

  if(getdvarint(@ "hash_5596ff0bf7ea7af6", 0)) {
    level thread scripts\mp\utility\debug::drawsphere(start, 5, self.current_wait + 2, (1, 1, 0));
    level thread scripts\mp\utility\debug::drawsphere(end, 5, self.current_wait + 2, (1, 0, 0));
  }

  self.fired = 1;
  thread function_330f2cf2ca649a29(mortarshell, start, end, time, apex_height);
  self.current_target = undefined;
  wait_until_impact(mortarshell, time);

  if(isDefined(mortarshell)) {
    stopFXOnTag(getfx("vfx_mortar_trail"), mortarshell, "tag_origin");
    mortarshell stoploopsound();
    end = mortarshell.origin;
    z_offset = (0, 0, 40);
    attacker = isalive(agent) ? agent : mortarshell;
    damageradius = getdvarfloat(@ "hash_101ff87dc41f06f9", 256);
    var_1e0b46f8a186c68 = getdvarfloat(@ "hash_14b3e4a59a909146", 200);
    var_9c95151112f60200 = getdvarfloat(@ "hash_78477d931c1e8ace", 150);
    radiusdamage(end + z_offset, damageradius, var_1e0b46f8a186c68, var_9c95151112f60200, attacker, "MOD_EXPLOSIVE", "c4_mp");
    earthquake(0.25, 3, end, 2048);
    playrumbleonposition("cp_chopper_rumble", end);
    playsoundatpos(end, "weap_mortar_expl_trans");
    magicgrenademanual("jup_mortar_mp", end + (0, 0, 2), (0, 0, -1), 0.1);
    mortarshell delete();
  }
}

function private function_330f2cf2ca649a29(model, start, end, time, height) {
  model endon("death");
  apex = 1200;

  if(isDefined(height)) {
    apex = height;
  }

  framefrac = 1 / time / 0.05;
  frac = 0;
  impact_point = undefined;

  while(frac < 1) {
    if(isDefined(impact_point)) {
      if(frac + framefrac < 1) {
        model.origin = impact_point;
        model notify("early_impact");
        return;
      }
    }

    model.origin = scripts\engine\math::get_point_on_parabola(start, end, apex, frac);
    next_frac = frac + framefrac;
    next_point = scripts\engine\math::get_point_on_parabola(start, end, apex, next_frac);
    impact_point = check_for_early_impact(model, next_point);
    model function_41f143bd962f9dfd();

    if(getdvarint(@ "hash_5596ff0bf7ea7af6", 0)) {
      thread draw_line_for_time(model.origin, model.origin + (0, 0, 128), 1, 1, 1, 0.05);
    }

    frac += framefrac;
    wait 0.05;
  }

  model.origin = end;

  if(getdvarint(@ "hash_5596ff0bf7ea7af6", 0)) {
    thread draw_line_for_time(model.origin, model.origin + (0, 0, 128), 1, 1, 1, self.current_wait + 2);
  }
}

function private function_41f143bd962f9dfd() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

function private check_for_early_impact(mortar, next_loc) {
  collisioncontents = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  raytrace = scripts\engine\trace::ray_trace(mortar.origin, next_loc, mortar, collisioncontents);

  if(raytrace["hittype"] != "hittype_none") {
    return next_loc;
  }
}

function private wait_until_impact(mortarshell, time) {
  mortarshell endon("early_impact");
  mortarshell endon("death");
  wait 0.1;
  playFXOnTag(getfx("vfx_mortar_trail"), mortarshell, "tag_origin");
  mortarshell playLoopSound("weap_mortar_fly_lp");
  wait time - 1.7;
  mortarshell playSound("weap_mortar_incoming");
  wait 1.7;
}

function private exit_launcher(launcher) {
  ai_anim("sdr_mortar_exit");
}

function private reload_launcher(launcher) {
  launcher scriptmodelplayanimdeltamotion("emb_wm_mortar_reload_mortar");
  ai_anim("sdr_mortar_reload");
}

function private run_to_launcher(launcher) {
  goal = function_f24808559b936671(self, launcher);

  if(isDefined(goal)) {
    goto_anim_pos(goal, 0);
    return true;
  }

  return false;
}

function private goto_anim_pos(goal, link) {
  self.scripted_mode = 1;
  self.playing_skit = 1;
  self.goalradius = 8;
  self.script_radius = 8;
  self.ignoreall = 1;
  self setgoalpos(self getclosestreachablepointonnavmesh(goal.origin));

  if(getdvarint(@ "hash_5596ff0bf7ea7af6", 0)) {
    level thread scripts\mp\utility\debug::drawsphere(self.origin, self.goalradius, 45, (1, 0, 1));
    level thread scripts\mp\utility\debug::drawsphere(goal.origin, 5, 40, (0, 0, 1));
  }

  waittill_near_goal(goal.origin, squared(384));
  self.goalradius = 8;
  self.script_radius = 8;
  self.allowpain = 0;
  self waittill("goal");

  if(!isDefined(goal.angles)) {
    goal.angles = (0, 0, 0);
  }

  self setplayerangles(goal.angles);
  self forceteleport(goal.origin, goal.angles);

  if(istrue(link)) {
    self.anchor = spawn("script_origin", goal.origin);
    self.anchor.angles = goal.angles;
    self linkTo(self.anchor);
  }
}

function private waittill_near_goal(origin, radius) {
  if(!isDefined(origin)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  while(distancesquared(self.origin, origin) > radius) {
    wait 0.1;
  }
}

function private function_f24808559b936671(agent, launcher) {
  animindex = agent scripts\asm\asm::asm_lookupanimfromalias("animscripted", "sdr_mortar_enter");
  xanim = agent scripts\asm\asm::asm_getxanim("animscripted", animindex);

  if(isDefined(xanim)) {
    org = launcher.origin;
    ang = launcher.angles;
    pos = spawnStruct();
    pos.origin = getstartorigin(org, ang, xanim) + anglesToForward(launcher.angles) * 5;
    pos.angles = getstartangles(org, ang, xanim);
    pos.animindex = animindex;
    pos.xanim = xanim;
    return pos;
  }

  return undefined;
}

function private clear_custom_anim() {
  self allowedstances("stand", "prone", "crouch");

  if(isanimScripted(self)) {
    scripts\asm\shared\mp\utility::animscripted_clear();
  }

  if(!istrue(self.dont_enter_combat)) {
    self.ignoreall = 0;
  }

  self.scripted_mode = 0;
  self.playing_skit = undefined;

  if(isDefined(self.anchor)) {
    self unlink();
    self.anchor delete();
  }
}

function private handle_ai_launcher_death(launcher) {
  self waittill("death");
  self endon("mortar_shell_launch_started");

  if(isDefined(launcher)) {
    launcher setscriptablepartstate("main", "idle");
  }
}

function private function_46aa4fcdd94bff71(mortar) {
  if(!isDefined(mortar.current_target)) {
    return undefined;
  }

  point = (0, 0, 0);
  targetplayer = mortar.current_target;

  if(!isDefined(targetplayer.var_4b4e9c1b27d7f65e)) {
    targetplayer.var_4b4e9c1b27d7f65e = 0;
  }

  modifier = 1;

  switch (targetplayer.var_4b4e9c1b27d7f65e) {
    case 0:
      modifier = 40;
      break;
    case 1:
      modifier = 10;
      break;
    case 2:
      modifier = 1;
      break;
  }

  if(targetplayer.var_4b4e9c1b27d7f65e >= 2) {
    targetplayer.var_4b4e9c1b27d7f65e = undefined;
  } else {
    targetplayer.var_4b4e9c1b27d7f65e++;
  }

  point = targetplayer.origin + (randomintrange(-10 * modifier, 10 * modifier), randomintrange(-10 * modifier, 10 * modifier), 0);
  ignorearray = [];
  ignorearray[ignorearray.size] = targetplayer;
  trace = scripts\engine\trace::ray_trace(point + (0, 0, 500), point, ignorearray);
  return trace["position"];
}