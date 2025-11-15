/***********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\kung_fu_mode_tiger.gsc
***********************************************************/

tiger_kung_fu_init() {
  thread scripts\cp\powers\coop_groundpound::init();
  level._effect["blackhole_trap"] = loadfx("vfx\iw7\core\zombie\traps\vfx_zmb_blackhole_trap.vfx");
  level._effect["blackhole_trap_death"] = loadfx("vfx\iw7\_requests\coop\vfx_zmb_blackhole_death");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\powers\coop_powers::powersetupfunctions("power_shuriken_tiger", ::scripts\cp\maps\cp_disco\kung_fu_mode_dragon::set_dragon_shuriken_power, ::scripts\cp\maps\cp_disco\kung_fu_mode_dragon::unset_dragon_shuriken_power, ::scripts\cp\maps\cp_disco\kung_fu_mode_dragon::use_dragon_shuriken, undefined, undefined, undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_black_hole_tiger", ::tiger_black_hole_set, ::tiger_black_hole_unset, ::tiger_black_hole_use, undefined, "power_tiger_black_hole_used", undefined);
}

tiger_black_hole_set(param_00) {}

tiger_black_hole_unset(param_00) {}

tiger_black_hole_use(param_00) {
  scripts\cp\powers\coop_powers::power_disablepower();
  var_01 = 2.5;
  thread run_black_hole_logic();
  wait(var_01);
  self.kung_fu_exit_delay = 0;
  scripts\cp\powers\coop_powers::power_enablepower();
  self notify("power_tiger_black_hole_used", 1);
}

run_black_hole_logic() {
  wait(0.3);
  if(scripts\engine\utility::istrue(self.tiger_super_use)) {
    return;
  }

  var_00 = sortbydistance(level.spawned_enemies, self.origin);
  var_01 = undefined;
  var_02 = 3;
  var_03 = 2.5;
  var_04 = 256;
  var_05 = self getplayerangles();
  var_06 = anglesToForward(var_05);
  var_06 = vectornormalize(var_06);
  var_07 = self getEye();
  var_08 = var_07 + var_06 * var_04;
  var_09 = scripts\cp\cp_agent_utils::getaliveagents();
  var_09 = scripts\engine\utility::array_combine(var_09, level.players);
  var_0A = scripts\common\trace::ray_trace(var_07, var_08, var_09);
  var_0B = var_0A["position"];
  var_01 = scripts\engine\utility::drop_to_ground(var_0B, 20, -1000);
  var_01 = getclosestpointonnavmesh(var_01);
  var_0C = 250;
  if(self.chi_meter_amount - var_0C <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  thread scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(var_0C);
  var_0D = scripts\engine\utility::spawn_tag_origin(var_01 + (0, 0, 60));
  var_0D.triggerportableradarping = self;
  var_0D setModel("tag_origin_tiger_black_hole");
  thread scripts\engine\utility::play_sound_in_space("chi_tiger_blackhole", var_0D.origin);
  thread grabclosestzombies(var_0D, 1);
  self playgestureviewmodel("ges_plyr_gesture042", undefined, 1);
  wait(var_03);
  var_0D notify("death");
  var_0D delete();
}

grabclosestzombies(param_00, param_01) {
  param_00 endon("death");
  param_00.grabbedents = [];
  var_02 = anglestoup(param_00.angles);
  var_03 = spawn("trigger_rotatable_radius", scripts\cp\powers\coop_blackholegrenade::getblackholecenter(param_00) - var_02 * 64 * 0.5, 0, 200, 64);
  var_03.angles = param_00.angles;
  var_03 enablelinkto();
  var_03 linkto(param_00);
  var_03 thread scripts\cp\powers\coop_blackholegrenade::cleanuponparentdeath(param_00);
  while(isDefined(var_03)) {
    var_04 = scripts\engine\utility::get_array_of_closest(param_00.origin, level.spawned_enemies, undefined, undefined, 200);
    foreach(var_06 in var_04) {
      if(!scripts\cp\utility::isreallyalive(var_06) || !isDefined(param_00.triggerportableradarping)) {
        continue;
      }

      if(isplayer(var_06)) {
        continue;
      }

      if(isDefined(var_06.team) && var_06.team == "allies") {
        continue;
      }

      if(param_00.triggerportableradarping == var_06) {
        continue;
      }

      if(!scripts\cp\powers\coop_phaseshift::areentitiesinphase(param_00, var_06)) {
        continue;
      }

      if(!scripts\cp\utility::should_be_affected_by_trap(var_06, undefined, 1) || isDefined(var_06.flung)) {
        continue;
      }

      if(!isalive(var_06)) {
        continue;
      }

      if(isDefined(level.turned_zombies) && isDefined(scripts\engine\utility::array_find(level.turned_zombies, var_06))) {
        continue;
      }

      if(!var_06 scripts\cp\powers\coop_blackholegrenade::isgrabbedent(param_00)) {
        var_06 thread scripts\cp\powers\coop_blackholegrenade::grabent(param_00);
        var_06.flung = 1;
        var_06 thread scripts\cp\powers\coop_blackholegrenade::suck_zombie(var_06, param_00, param_01);
        wait(0.2);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

tiger_ground_pound_set(param_00) {}

tiger_ground_pound_unset(param_00) {}

tiger_ground_pound_use(param_00) {
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
  var_00 = scripts\engine\utility::drop_to_ground(self.origin, 30, -100);
}

stay_in_kung_fu_till_gesture_done(param_00) {
  self endon("disconnect");
  var_01 = 500;
  if(self.chi_meter_amount - var_01 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  var_02 = self getgestureanimlength(param_00);
  wait(var_02);
  self.tiger_super_use = 0;
  self.kung_fu_exit_delay = 0;
}

play_tiger_hand_fx() {
  self setscriptablepartstate("kung_fu_super_fx", "tiger");
  wait(2.5);
  self setscriptablepartstate("kung_fu_super_fx", "off");
}

run_slam_wave() {
  var_00 = 150;
  var_01 = 3;
  var_02 = 0;
  while(var_02 < var_01) {
    var_03 = var_02 + 1 * var_00;
    var_04 = var_03 * var_03;
    foreach(var_06 in level.spawned_enemies) {
      if(distancesquared(var_06.origin, self.origin) < var_04) {
        var_07 = var_06.origin + (0, 0, 100);
        var_06 thread fling_enemy(var_06.maxhealth, var_07 - var_06.origin, self, 0, "kung_fu_super_zm_tiger");
      }
    }

    var_02++;
    wait(0.25);
  }
}

fling_enemy(param_00, param_01, param_02, param_03, param_04) {
  var_05 = isDefined(self.agent_type) && self.agent_type == "ratking";
  if(var_05) {
    if(isDefined(param_02)) {
      self dodamage(self.health + 1000, self.origin, param_02, param_02, "MOD_UNKNOWN", param_04);
      return;
    }

    self dodamage(self.health + 1000, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", param_04);
    return;
  }

  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  wait(0.05);
  if(scripts\engine\utility::istrue(param_03)) {
    self.nocorpse = 1;
    self.full_gib = 1;
    if(isDefined(param_02)) {
      self dodamage(self.health + 1000, self.origin, param_02, param_02, "MOD_UNKNOWN", param_04);
      return;
    }

    self dodamage(self.health + 1000, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", param_04);
    return;
  }

  self setvelocity(vectornormalize(param_01) * 500);
  wait(0.1);
  if(isDefined(param_02)) {
    self dodamage(self.health + 1000, self.origin, param_02, param_02, "MOD_UNKNOWN", param_04);
    return;
  }

  self dodamage(self.health + 1000, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", param_04);
}

slam_execute(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    var_03 = lengthsquared(param_00.origin - param_01);
    if(var_03 < 65536) {
      return;
    }

    if(var_03 > squared(600)) {
      return;
    }
  }

  var_04 = param_00 scripts\engine\utility::spawn_tag_origin();
  thread scripts\cp\powers\coop_groundpound::slam_delent(param_00, var_04);
  slam_executeinternal(param_00, param_01, var_04, param_02);
  param_00 notify("slam_finished");
}

slam_executeinternal(param_00, param_01, param_02, param_03) {
  var_04 = lengthsquared(param_00.origin - param_01);
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  if(var_04 >= 28224) {
    var_06 = 20736;
    var_05 = 1;
  } else if(var_04 >= 7056) {
    var_06 = 5184;
    var_07 = 20736;
  } else {
    var_07 = 11664;
  }

  param_00 playerlinkto(param_02, "tag_origin");
  wait(0.25);
  param_00 thread scripts\cp\cp_weapon::grenade_earthquake(0);
  if(!isDefined(param_03)) {
    param_00 playSound("detpack_explo_metal");
    var_08 = scripts\engine\utility::ter_op(var_05, scripts\engine\utility::getfx("slam_lrg"), scripts\engine\utility::getfx("slam_sml"));
    playFX(var_08, param_01);
  } else {}

  thread scripts\cp\powers\coop_groundpound::slam_physicspulse(param_01);
  var_09 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_0B in var_09) {
    if(!isDefined(var_0B) || var_0B == param_00 || !scripts\cp\utility::isreallyalive(var_0B)) {
      continue;
    }

    var_0C = undefined;
    var_0D = distancesquared(param_01, var_0B.origin);
    if(var_0D <= var_06) {
      var_0C = 1000000;
    } else if(var_0D <= var_07) {
      var_0C = 1000000;
    } else {
      continue;
    }

    var_0B scripts\cp\cp_weapon::shellshockondamage("MOD_EXPLOSIVE", var_0C);
    if(var_0C >= var_0B.health) {
      var_0B.customdeath = 1;
    }

    var_0B dodamage(var_0C, param_01, param_00, param_00, "MOD_CRUSH");
  }

  wait(0.5);
  param_00 unlink();
  param_00 setscriptablepartstate("tiger_style_fx", "inactive", 1);
}