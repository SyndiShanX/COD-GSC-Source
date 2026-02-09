/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\kung_fu_mode_tiger.gsc
***********************************************************/

tiger_kung_fu_init() {
  thread scripts\cp\powers\coop_groundpound::init();
  level._effect["blackhole_trap"] = loadfx("vfx\iw7\core\zombie\traps\vfx_zmb_blackhole_trap.vfx");
  level._effect["blackhole_trap_death"] = loadfx("vfx\iw7\_requests\coop\vfx_zmb_blackhole_death");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\powers\coop_powers::powersetupfunctions("power_shuriken_tiger", scripts\cp\maps\cp_disco\kung_fu_mode_dragon::set_dragon_shuriken_power, scripts\cp\maps\cp_disco\kung_fu_mode_dragon::unset_dragon_shuriken_power, scripts\cp\maps\cp_disco\kung_fu_mode_dragon::use_dragon_shuriken, undefined, undefined, undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_black_hole_tiger", ::tiger_black_hole_set, ::tiger_black_hole_unset, ::tiger_black_hole_use, undefined, "power_tiger_black_hole_used", undefined);
}

tiger_black_hole_set(var_0) {}

tiger_black_hole_unset(var_0) {}

tiger_black_hole_use(var_0) {
  scripts\cp\powers\coop_powers::power_disablepower();
  var_1 = 2.5;
  thread run_black_hole_logic();
  wait(var_1);
  self.kung_fu_exit_delay = 0;
  scripts\cp\powers\coop_powers::power_enablepower();
  self notify("power_tiger_black_hole_used", 1);
}

run_black_hole_logic() {
  wait(0.3);
  if(scripts\engine\utility::istrue(self.tiger_super_use)) {
    return;
  }

  var_0 = sortbydistance(level.spawned_enemies, self.origin);
  var_1 = undefined;
  var_2 = 3;
  var_3 = 2.5;
  var_4 = 256;
  var_5 = self getplayerangles();
  var_6 = anglesToForward(var_5);
  var_6 = vectornormalize(var_6);
  var_7 = self getEye();
  var_8 = var_7 + var_6 * var_4;
  var_9 = scripts\cp\cp_agent_utils::getaliveagents();
  var_9 = scripts\engine\utility::array_combine(var_9, level.players);
  var_10 = scripts\common\trace::ray_trace(var_7, var_8, var_9);
  var_11 = var_10["position"];
  var_1 = scripts\engine\utility::drop_to_ground(var_11, 20, -1000);
  var_1 = getclosestpointonnavmesh(var_1);
  var_12 = 250;
  if(self.chi_meter_amount - var_12 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  thread scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(var_12);
  var_13 = scripts\engine\utility::spawn_tag_origin(var_1 + (0, 0, 60));
  var_13.owner = self;
  var_13 setModel("tag_origin_tiger_black_hole");
  thread scripts\engine\utility::play_sound_in_space("chi_tiger_blackhole", var_13.origin);
  thread grabclosestzombies(var_13, 1);
  self playgestureviewmodel("ges_plyr_gesture042", undefined, 1);
  wait(var_3);
  var_13 notify("death");
  var_13 delete();
}

grabclosestzombies(var_0, var_1) {
  var_0 endon("death");
  var_0.grabbedents = [];
  var_2 = anglestoup(var_0.angles);
  var_3 = spawn("trigger_rotatable_radius", scripts\cp\powers\coop_blackholegrenade::getblackholecenter(var_0) - var_2 * 64 * 0.5, 0, 200, 64);
  var_3.angles = var_0.angles;
  var_3 enablelinkto();
  var_3 linkto(var_0);
  var_3 thread scripts\cp\powers\coop_blackholegrenade::cleanuponparentdeath(var_0);
  while(isDefined(var_3)) {
    var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.spawned_enemies, undefined, undefined, 200);
    foreach(var_6 in var_4) {
      if(!scripts\cp\utility::isreallyalive(var_6) || !isDefined(var_0.owner)) {
        continue;
      }

      if(isPlayer(var_6)) {
        continue;
      }

      if(isDefined(var_6.team) && var_6.team == "allies") {
        continue;
      }

      if(var_0.owner == var_6) {
        continue;
      }

      if(!scripts\cp\powers\coop_phaseshift::areentitiesinphase(var_0, var_6)) {
        continue;
      }

      if(!scripts\cp\utility::should_be_affected_by_trap(var_6, undefined, 1) || isDefined(var_6.flung)) {
        continue;
      }

      if(!isalive(var_6)) {
        continue;
      }

      if(isDefined(level.turned_zombies) && isDefined(scripts\engine\utility::array_find(level.turned_zombies, var_6))) {
        continue;
      }

      if(!var_6 scripts\cp\powers\coop_blackholegrenade::isgrabbedent(var_0)) {
        var_6 thread scripts\cp\powers\coop_blackholegrenade::grabent(var_0);
        var_6.flung = 1;
        var_6 thread scripts\cp\powers\coop_blackholegrenade::suck_zombie(var_6, var_0, var_1);
        wait(0.2);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

tiger_ground_pound_set(var_0) {}

tiger_ground_pound_unset(var_0) {}

tiger_ground_pound_use(var_0) {
  self.tiger_super_use = 1;
  self.kung_fu_shield = 1;
  self allowcrouch(0);
  scripts\engine\utility::allow_slide(0);
  scripts\engine\utility::allow_melee(0);
  thread tiger_pound_cowbell();
  thread play_tiger_hand_fx();
  wait(1.5);
  self setscriptablepartstate("tiger_style_fx", "active", 1);
  run_slam_wave();
  self allowcrouch(1);
  scripts\engine\utility::allow_melee(1);
  scripts\engine\utility::allow_slide(1);
  self.kung_fu_shield = undefined;
  scripts\cp\powers\coop_powers::power_enablepower();
}

tiger_pound_cowbell() {
  self playgestureviewmodel("ges_tiger_melee_super", undefined, 1);
  thread stay_in_kung_fu_till_gesture_done("ges_tiger_melee_super");
  var_0 = scripts\engine\utility::drop_to_ground(self.origin, 30, -100);
}

stay_in_kung_fu_till_gesture_done(var_0) {
  self endon("disconnect");
  var_1 = 500;
  if(self.chi_meter_amount - var_1 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  var_2 = self getgestureanimlength(var_0);
  wait(var_2);
  self.tiger_super_use = 0;
  self.kung_fu_exit_delay = 0;
}

play_tiger_hand_fx() {
  self setscriptablepartstate("kung_fu_super_fx", "tiger");
  wait(2.5);
  self setscriptablepartstate("kung_fu_super_fx", "off");
}

run_slam_wave() {
  var_0 = 150;
  var_1 = 3;
  var_2 = 0;
  while(var_2 < var_1) {
    var_3 = var_2 + 1 * var_0;
    var_4 = var_3 * var_3;
    foreach(var_6 in level.spawned_enemies) {
      if(distancesquared(var_6.origin, self.origin) < var_4) {
        var_7 = var_6.origin + (0, 0, 100);
        var_6 thread fling_enemy(var_6.maxhealth, var_7 - var_6.origin, self, 0, "kung_fu_super_zm_tiger");
      }
    }

    var_2++;
    wait(0.25);
  }
}

fling_enemy(var_0, var_1, var_2, var_3, var_4) {
  var_5 = isDefined(self.agent_type) && self.agent_type == "ratking";
  if(var_5) {
    if(isDefined(var_2)) {
      self dodamage(self.health + 1000, self.origin, var_2, var_2, "MOD_UNKNOWN", var_4);
      return;
    }

    self dodamage(self.health + 1000, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", var_4);
    return;
  }

  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  wait(0.05);
  if(scripts\engine\utility::istrue(var_3)) {
    self.nocorpse = 1;
    self.full_gib = 1;
    if(isDefined(var_2)) {
      self dodamage(self.health + 1000, self.origin, var_2, var_2, "MOD_UNKNOWN", var_4);
      return;
    }

    self dodamage(self.health + 1000, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", var_4);
    return;
  }

  self setvelocity(vectornormalize(var_1) * 500);
  wait(0.1);
  if(isDefined(var_2)) {
    self dodamage(self.health + 1000, self.origin, var_2, var_2, "MOD_UNKNOWN", var_4);
    return;
  }

  self dodamage(self.health + 1000, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", var_4);
}

slam_execute(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_3 = lengthsquared(var_0.origin - var_1);
    if(var_3 < 65536) {
      return;
    }

    if(var_3 > squared(600)) {
      return;
    }
  }

  var_4 = var_0 scripts\engine\utility::spawn_tag_origin();
  thread scripts\cp\powers\coop_groundpound::slam_delent(var_0, var_4);
  slam_executeinternal(var_0, var_1, var_4, var_2);
  var_0 notify("slam_finished");
}

slam_executeinternal(var_0, var_1, var_2, var_3) {
  var_4 = lengthsquared(var_0.origin - var_1);
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  if(var_4 >= 28224) {
    var_6 = 20736;
    var_5 = 1;
  } else if(var_4 >= 7056) {
    var_6 = 5184;
    var_7 = 20736;
  } else {
    var_7 = 11664;
  }

  var_0 playerlinkto(var_2, "tag_origin");
  wait(0.25);
  var_0 thread scripts\cp\cp_weapon::grenade_earthquake(0);
  if(!isDefined(var_3)) {
    var_0 playSound("detpack_explo_metal");
    var_8 = scripts\engine\utility::ter_op(var_5, scripts\engine\utility::getfx("slam_lrg"), scripts\engine\utility::getfx("slam_sml"));
    playFX(var_8, var_1);
  }

  thread scripts\cp\powers\coop_groundpound::slam_physicspulse(var_1);
  var_9 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_11 in var_9) {
    if(!isDefined(var_11) || var_11 == var_0 || !scripts\cp\utility::isreallyalive(var_11)) {
      continue;
    }

    var_12 = undefined;
    var_13 = distancesquared(var_1, var_11.origin);
    if(var_13 <= var_6) {
      var_12 = 1000000;
    } else if(var_13 <= var_7) {
      var_12 = 1000000;
    } else {
      continue;
    }

    var_11 scripts\cp\cp_weapon::shellshockondamage("MOD_EXPLOSIVE", var_12);
    if(var_12 >= var_11.health) {
      var_11.customdeath = 1;
    }

    var_11 dodamage(var_12, var_1, var_0, var_0, "MOD_CRUSH");
  }

  wait(0.5);
  var_0 unlink();
  var_0 setscriptablepartstate("tiger_style_fx", "inactive", 1);
}