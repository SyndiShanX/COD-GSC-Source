/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3621.gsc
************************/

func_7977() {
  var_00 = level.var_612D.var_A925;
  var_01 = 0;
  var_02 = undefined;
  if(isDefined(var_00) && isplayer(var_00)) {
    var_01 = 1;
  }

  if(isplayer(self)) {
    var_02 = scripts\engine\utility::ter_op(var_01, level.player.var_612D.var_4A6E, 0.2);
  } else {
    switch (tolower(self.unittype)) {
      case "soldier":
        var_02 = scripts\engine\utility::ter_op(var_01, level.player.var_612D.var_4A6D, 0.35);
        break;

      default:
        var_02 = scripts\engine\utility::ter_op(var_01, level.player.var_612D.var_4A6C, 0.6);
        break;
    }
  }

  if(self.team == "allies") {
    return level.player.var_612D.fgetarg * 0.25;
  }

  return level.player.var_612D.fgetarg * var_02;
}

func_95C4() {
  precacheitem("emp");
  precachemodel("anti_grav_border_wm");
  setdvarifuninitialized("debug_emp", 0);
  level.player.var_9DD2 = 0;
  level.var_612D = spawnStruct();
  level.var_612D.var_B422 = 10;
  level.var_612D.var_B73C = 6;
  level.player.var_612D = spawnStruct();
  level.player.var_612D.fgetarg = 350;
  level.player.var_612D.var_4A6D = 0.35;
  level.player.var_612D.var_4A6C = 0.6;
  level.player.var_612D.var_4A6E = 0.2;
  level.player.var_612D.var_12F6D = 0;
  level.var_612D.var_B44E = 3;
  level.var_612D.var_B74B = 1.5;
  level.var_612D.var_D02E = level.player.var_612D.fgetarg;
  level.var_612D.var_4BCA = [];
  level.var_612D.var_4BCD = [];
  level.var_612D.var_AC75 = 4;
  level.var_612D.var_9927 = 0;
  level.var_612D.var_522C = [];
  level.var_612D.var_A8C6 = undefined;
  scripts\engine\utility::flag_init("emp_force_delete");
  scripts\engine\utility::flag_init("emp_dof_enabled");
  level.var_7649["c12_impact"] = loadfx("vfx\core\equipment\emp_grenade\vfx_iw7_equip_emp_gren_mini_exp.vfx");
  level.var_7649["player_shock"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_inplayerface.vfx");
  level.var_7649["emp_energy_strand_ptp"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_pointbeam.vfx");
  level.var_7649["c12_shock"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_c12_peeloff.vfx");
  level.var_7649["c12_death"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_c12_kill.vfx");
  level.var_7649["c8_shock"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_c6_peeloff.vfx");
  level.var_7649["c8_death"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_c12_kill.vfx");
  level.var_7649["seeker_shock"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_c6_peeloff.vfx");
  level.var_7649["seeker_death"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_c6_kill.vfx");
  level.var_7649["c6_shock"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_c6_peeloff.vfx");
  level.var_7649["c6_death"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_c6_kill.vfx");
  level.var_7649["c6i_shock"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_c6_peeloff.vfx");
  level.var_7649["c6i_death"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_c6_kill.vfx");
  level.var_7649["soldier_shock"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_human.vfx");
  level.var_7649["soldier_death"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_human_kill.vfx");
  level.var_7649["vfx_equip_emp_a2_thegreatzapper"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_a2_thegreatzapper.vfx");
  level.var_7649["vfx_equip_emp_a2_satellite"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_a2_satellite.vfx");
  level.var_7649["vfx_equip_emp_a2_hitbyzapper"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_a2_hitbyzapper.vfx");
  level.var_7649["vfx_equip_emp_a2_groundcov"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_a2_groundcov.vfx");
  level.var_7649["vfx_equip_emp_a2_dud"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_a2_dud.vfx");
  level.var_7649["vfx_equip_emp_a2_centerblast"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_a2_centerblast.vfx");
  level.var_7649["vfx_equip_emp_a2_centerblast_cheap"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_a2_centerblast_cheap.vfx");
}

func_618D() {
  self endon("primary_equipment_change");
  for(;;) {
    self waittill("grenade_pullback");
    self setscriptablepartstate("emp", "emp_light_on");
    self waittill("offhand_end");
    self setscriptablepartstate("emp", "emp_light_off");
  }
}

func_6133(param_00) {
  level.var_612D.var_4BF1 = param_00.origin;
  level.var_612D.var_A925 = level.player;
  var_01 = scripts\engine\utility::spawn_tag_origin(level.var_612D.var_4BF1, (0, 0, 0));
  var_01.var_132AA = [];
  var_01.soundevents = [];
  level.var_612D.var_522C[level.var_612D.var_522C.size] = var_01;
  var_01.var_378E = func_36EB(level.var_612D.var_4BF1);
  var_01 func_106C3();
  var_01 thread func_6172();
  var_01 thread func_613B();
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 0);
  var_01 thread func_6142();
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 4);
  var_01 thread func_DFFE();
}

func_615B(param_00) {
  level.player thread scripts\anim\battlechatter_ai::func_67CF("emp");
  var_01 = spawnStruct();
  var_01.var_132AA = [];
  var_01.soundevents = [];
  var_01.objective_position = param_00;
  var_01.origin = param_00.origin;
  var_01.triggerportableradarping = self;
  level.var_612D.var_522C[level.var_612D.var_522C.size] = var_01;
  var_02 = param_00 scripts\engine\utility::waittill_any_return("explode", "missile_stuck", "death", "entitydeleted");
  if(!isDefined(param_00)) {
    var_01 thread func_DFFE();
    return;
  }

  if(!isDefined(param_00.origin)) {
    return;
  }

  var_01.origin = var_01.objective_position.origin;
  level.var_612D.var_4BF1 = var_01.objective_position.origin;
  level.var_612D.var_A925 = self;
  var_01 func_512A(0.5, ::func_E000);
  var_03 = level.var_612D.var_522C.size < 2;
  if(var_03) {
    var_01.var_378E = func_36EB(level.var_612D.var_4BF1);
  }

  var_01.origin = level.var_612D.var_4BF1;
  var_01.angles = (0, 0, 0);
  if(var_03) {
    var_01 func_106C3();
  }

  var_01 thread func_6172();
  var_01 thread func_613B();
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 0);
  var_01 thread func_6142();
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 4);
  var_01 thread func_DFFE();
}

func_DFFE() {
  if(!isDefined(self)) {
    return;
  }

  func_E000();
  if(scripts\engine\utility::flag("emp_force_delete")) {
    scripts\engine\utility::waitframe();
  }

  if(isDefined(self.soundevents)) {
    self.soundevents = scripts\engine\utility::array_removeundefined(self.soundevents);
    foreach(var_01 in self.soundevents) {
      if(isDefined(var_01.var_B04F)) {
        var_01 stoploopsound(var_01.var_B04F);
      }

      var_01 notify("sounddone");
      var_01 delete();
    }
  }

  if(isDefined(self.var_132AA)) {
    self.var_132AA = scripts\engine\utility::array_removeundefined(self.var_132AA);
    foreach(var_04 in self.var_132AA) {
      var_04 delete();
    }
  }

  if(isDefined(self.var_378D)) {
    self.var_378D = scripts\engine\utility::array_removeundefined(self.var_378D);
    var_06 = self.var_378D;
    foreach(var_08 in var_06) {
      func_DFFF(var_08);
    }
  }

  if(isDefined(self.var_E1A8)) {
    destroynavrepulsor(self.var_E1A8);
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  level.var_612D.var_522C = scripts\engine\utility::array_remove(level.var_612D.var_522C, self);
}

func_E000() {
  if(isDefined(self)) {
    if(isDefined(self.objective_position)) {
      self.origin = self.objective_position.origin;
      level.var_612D.var_A8C6 = self.objective_position.origin;
      self.objective_position delete();
    }
  }
}

func_DFFF(param_00) {
  if(isDefined(param_00.var_132AA)) {
    foreach(var_02 in param_00.var_132AA) {
      var_02 delete();
    }
  }

  killfxontag(level._effect["antigrav_caltrop_trail"], param_00, "tag_origin");
  self.var_378D = scripts\engine\utility::array_remove(self.var_378D, param_00);
  param_00 delete();
}

func_DFBE() {
  level notify("removing_all_emps_instantly");
  level endon("removing_all_emps_instantly");
  scripts\engine\utility::flag_set("emp_force_delete");
  foreach(var_01 in level.var_612D.var_522C) {
    var_01 thread func_E000();
  }

  for(;;) {
    if(level.var_612D.var_522C.size > 0) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_clear("emp_force_delete");
  level.player.var_9DD2 = 0;
  level.var_612D.var_4BCA = [];
  level.var_612D.var_4BCD = [];
  func_D291(0.05, 1);
  level.player notify("stop soundemp_nade_plr_lp");
}

func_613B() {
  var_00 = scripts\engine\utility::ter_op(level.var_612D.var_522C.size < 2, "vfx_equip_emp_a2_centerblast", "vfx_equip_emp_a2_centerblast_cheap");
  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    var_01 = spawnfx(level.var_7649[var_00], level.var_612D.var_4BF1);
    triggerfx(var_01);
    self.var_132AA[self.var_132AA.size] = var_01;
    return;
  }

  playFX(level.var_7649[var_00], level.var_612D.var_4BF1);
}

func_6142() {
  self.targets = [];
  level.var_612D.var_9927++;
  earthquake(0.7, 0.5, level.var_612D.var_4BF1, 450);
  thread func_6132();
  thread func_106C1(level.var_612D.var_4BF1);
  if(isDefined(level.var_CAF7)) {
    var_00 = 0.3;
    var_01 = sortbydistance(level.var_CAF7, self.origin);
    foreach(var_03 in var_01) {
      if(var_03 == self) {
        continue;
      }

      var_04 = distance(self.origin, var_03.origin);
      if(var_04 > level.player.var_612D.fgetarg) {
        continue;
      }

      var_05 = level.player.var_612D.fgetarg - var_04;
      var_06 = var_05 / level.player.var_612D.fgetarg;
      var_07 = var_00 * var_06;
      if(var_04 <= level.player.var_612D.fgetarg) {
        var_03 thread lib_0E1F::func_6136(self.origin, var_04, var_07);
      }
    }
  }
}

func_6132() {
  self.var_E1A8 = "emp" + level.var_612D.var_9927;
  createnavrepulsor(self.var_E1A8, -1, level.var_612D.var_4BF1, level.player.var_612D.fgetarg * 2, 1);
}

func_106C1(param_00) {
  self.trigger = spawn("trigger_radius", param_00, 7, level.player.var_612D.fgetarg, 40);
  if(isDefined(self.triggerportableradarping) && level.player == self.triggerportableradarping) {
    var_01 = self.triggerportableradarping scripts\sp\detonategrenades::func_734E();
    self.triggerportableradarping scripts\engine\utility::delaythread(1.25, ::scripts\sp\detonategrenades::func_734D, param_00, var_01, level.player.var_612D.fgetarg);
  }

  for(;;) {
    self.trigger waittill("trigger", var_02);
    if(isplayer(var_02)) {
      if(scripts\sp\detonategrenades::func_385D(level.var_612D.var_4BF1 + (0, 0, 40))) {
        var_02 thread func_5781(self);
      } else if(getdvarint("debug_emp")) {
        iprintln("^1 EMP can\'t trace to player");
      }

      continue;
    }

    if(scripts\sp\detonategrenades::func_385C(level.var_612D.var_4BF1 + (0, 0, 40), var_02)) {
      var_02 func_5781(self);
    }
  }
}

func_5781(param_00) {
  if(isDefined(self.unittype) && self.unittype == "civilian") {
    return;
  }

  if(isDefined(self.var_9DD2) && self.var_9DD2) {
    return;
  }

  if(isDefined(self.team) && self.team == "allies") {
    var_01 = 0;
    if(isDefined(self.var_A979)) {
      if(gettime() - self.var_A979 < 15000) {
        if(getdvarint("debug_emp")) {
          iprintln(self.classname + "^5 was EMPd within the last 15 secs - aborting");
        }

        var_01 = 1;
      }
    }

    if(var_01) {
      return;
    }
  }

  self.var_A979 = gettime();
  if(isplayer(self)) {
    thread func_D044(param_00);
    return;
  }

  self.var_9DD2 = 1;
  if(!isDefined(self.var_61A8)) {
    self.var_61A8 = 1;
  } else {
    self.var_61A8++;
  }

  if(isDefined(self.a.var_58DA)) {
    var_02 = self.health;
  }

  if(func_9B56()) {
    thread func_6140(param_00);
    return;
  }

  func_F388();
  var_02 = func_36EA();
  if(isalive(level.var_612D.var_A925)) {
    var_03 = level.var_612D.var_A925;
  } else {
    var_03 = undefined;
  }

  level.var_612D.var_4BCA[level.var_612D.var_4BCA.size] = self;
  if(isDefined(self.team) && self.team == "allies") {
    thread func_89A6(param_00);
  }

  self dodamage(var_02, self.origin, var_03, var_03, "MOD_GRENADE_SPLASH", "emp");
  thread func_613C(self.empstartcallback, param_00);
  thread func_193F(self.empstartcallback, param_00);
  if(!isalive(self)) {
    return;
  }

  if(scripts\asm\asm_bb::bb_isanimscripted() || self _meth_81A6() || isDefined(self.script) && self.script == "pain" || scripts\sp\utility::isactorwallrunning()) {
    return;
  }

  if(self.asmname == "soldier") {
    if(self.allowpain) {
      scripts\asm\asm::asm_setstate("shocked");
    }

    return;
  }

  switch (tolower(self.unittype)) {
    case "c8":
      thread func_3453(level.var_612D.var_4BF1);
      break;

    case "c12":
      thread func_354C(level.var_612D.var_4BF1);
      break;

    default:
      break;
  }
}

func_36E9(param_00, param_01) {
  var_02 = undefined;
  var_03 = undefined;
  switch (tolower(self.unittype)) {
    case "soldier":
      var_02 = 50;
      var_03 = 90;
      break;

    case "c6i":
    case "c6":
      var_02 = 250;
      var_03 = 325;
      break;

    case "seeker":
      var_02 = 500;
      var_03 = 500;
      break;

    case "c8":
      var_02 = 900;
      var_03 = 1000;
      break;

    case "c12":
      var_02 = 1200;
      var_03 = 1800;
      break;
  }

  var_04 = distance2d(self.origin, param_00);
  var_05 = scripts\sp\math::func_C097(0, param_01, var_04);
  var_06 = scripts\sp\math::func_6A8E(var_03, var_02, var_05) * 0.5;
  return var_06;
}

func_5772(param_00, param_01) {
  self endon("death");
  if(!isDefined(param_00.triggerportableradarping.team) || !isDefined(self.team)) {
    return;
  }

  if(param_00.triggerportableradarping.team == self.team) {
    return;
  }

  if(isDefined(self.var_9DD2) && self.var_9DD2) {
    return;
  }

  self.var_9DD2 = 1;
  self.empstartcallback = randomfloatrange(0.9, 1.6);
  var_02 = func_36E9(param_00.origin, param_01);
  if(isDefined(self.a.var_58DA)) {
    var_02 = self.health;
  }

  self dodamage(var_02, self.origin, param_00, param_00.triggerportableradarping, "MOD_GRENADE_SPLASH", "emp");
  thread func_3D25(self.empstartcallback);
  thread func_3D26(param_00, ["j_spineupper", "j_spinelower", "j_knee_le", "j_ankle_ri", "j_elbow_le", "j_wrist_ri", "j_neck", "j_head"]);
  switch (tolower(self.unittype)) {
    case "c8":
      break;

    case "c12":
      break;
  }

  wait(self.empstartcallback);
  self.var_9DD2 = undefined;
}

func_3D25(param_00) {
  playworldsound("emp_shock_short", self.origin);
  playworldsound("generic_death_falling_scream", self.origin);
  thread func_B06D(level.var_7649["soldier_shock"], "j_spine4", param_00);
  var_01 = "emp_electrocute_lp";
  thread scripts\engine\utility::play_loop_sound_on_entity(var_01);
  var_02 = self.origin;
  scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "death");
  scripts\sp\utility::func_178D(::scripts\sp\utility::timeout, param_00);
  scripts\sp\utility::func_57D6();
  self notify("stop sound" + var_01);
  playworldsound("emp_nade_lp_end", var_02);
  self notify("stop_looped_vfx");
  if(isalive(self)) {
    scripts\anim\face::saygenericdialogue("pain");
  }
}

func_3D26(param_00, param_01) {
  self endon("death");
  param_00 endon("death");
  var_02 = param_00.origin;
  for(var_03 = 0; var_03 < 2; var_03++) {
    var_04 = scripts\engine\utility::random(param_01);
    var_05 = self gettagorigin(var_04);
    var_06 = vectornormalize(var_05 - var_02);
    var_07 = vectortoangles(var_06);
    playfxbetweenpoints(level.var_7649["emp_energy_strand_ptp"], var_02, var_07, var_05, level.player);
  }
}

func_89A6(param_00) {
  self endon("death");
  if((isDefined(self.health) && self.health < 0) || isDefined(self.forceempfriendlyfail)) {
    return;
  }

  self.var_BFED = 1;
  wait(0.1);
  self.var_BFED = undefined;
}

func_F388() {
  var_00 = level.var_612D.var_4BF1;
  var_01 = distance2d(self.origin, var_00);
  var_02 = func_7977();
  var_03 = scripts\engine\utility::ter_op(isDefined(self.team) && self.team == "allies", 2, 4);
  var_04 = scripts\sp\math::func_C097(var_02, level.player.var_612D.fgetarg, var_01);
  self.empstartcallback = scripts\sp\math::func_6A8E(var_03, 1.5, var_04);
}

func_36EA() {
  var_00 = undefined;
  var_01 = undefined;
  switch (tolower(self.unittype)) {
    case "soldier":
      var_00 = 50;
      var_01 = 90;
      break;

    case "c6i":
    case "c6":
      var_00 = 250;
      var_01 = 325;
      break;

    case "seeker":
      var_00 = 500;
      var_01 = 500;
      break;

    case "c8":
      var_00 = 900;
      var_01 = 1000;
      break;

    case "c12":
      var_00 = 1200;
      var_01 = 1800;
      break;
  }

  var_02 = distance2d(self.origin, level.var_612D.var_4BF1);
  var_03 = scripts\sp\math::func_C097(0, level.player.var_612D.fgetarg, var_02);
  var_04 = scripts\sp\math::func_6A8E(var_01, var_00, var_03);
  return var_04;
}

func_613C(param_00, param_01) {
  self endon("death");
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", param_00);
  level.var_612D.var_4BCA = scripts\engine\utility::array_remove(level.var_612D.var_4BCA, self);
  self.var_9DD2 = undefined;
}

func_D044(param_00) {
  self endon("death");
  if(scripts\sp\utility::func_65DB("player_retract_shield_active")) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, level.var_612D.var_4BF1, cos(65))) {
      return;
    }
  }

  if(isDefined(self.var_9DD2) && self.var_9DD2) {
    return;
  }

  var_01 = level.var_612D.var_4BF1;
  var_02 = distance2d(self.origin, var_01);
  if(getdvarint("debug_emp")) {}

  var_03 = func_7977();
  scripts\sp\utility::func_54EF(var_01);
  self.var_9DD2 = 1;
  var_03 = func_7977();
  var_04 = scripts\sp\math::func_C097(var_03, level.player.var_612D.fgetarg, var_02);
  var_05 = scripts\sp\math::func_6A8E(level.var_612D.var_B44E, level.var_612D.var_B74B, var_04);
  if(var_02 < var_03) {
    if(!scripts\engine\utility::flag_exist("in_vr_mode") || scripts\engine\utility::flag_exist("in_vr_mode") && !scripts\engine\utility::flag("in_vr_mode")) {
      playworldsound("gravity_explode_default", self.origin);
      playFX(level.var_7649["c12_impact"], self getEye());
      scripts\engine\utility::delaythread(0.5, ::scripts\sp\utility::func_54C6);
    }
  } else {
    self dodamage(self.health * 0.3, self.origin, level.var_612D.var_A925, level.var_612D.var_A925, "MOD_GRENADE_SPLASH", "emp");
    thread func_613C(var_05, param_00);
  }

  level.var_612D.var_CF96 = scripts\sp\math::func_6A8E(50, 10, var_04);
  var_06 = isDefined(self.var_764D) && self.var_764D != 1;
  if(var_06) {
    var_07 = self.var_764D;
  }

  if(getdvarint("debug_emp")) {
    iprintln("^5Player Dist: ^3" + int(var_02) + "^5 Struntime: ^3" + var_05);
  }

  func_D293(1, var_05, level.var_612D.var_CF96, param_00);
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", var_05);
  func_D293(0, undefined, undefined, param_00);
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 0.45);
  scripts\sp\utility::play_sound_on_entity("emp_plr_strain");
}

func_D293(param_00, param_01, param_02, param_03) {
  if(param_00) {
    if(isDefined(param_03)) {
      if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
        var_04 = spawnfx(level.var_7649["player_shock"], (0, 0, 0));
        triggerfx(var_04);
        param_03.var_132AA[param_03.var_132AA.size] = var_04;
      }
    } else {
      playFX(level.var_7649["player_shock"], (0, 0, 0));
    }

    thread scripts\sp\utility::func_D2CD(30, 1);
    if(scripts\engine\utility::cointoss()) {
      level.var_612D.var_D292 = "ges_shocknade_loop";
    } else {
      level.var_612D.var_D292 = "ges_shocknade_loop2";
    }

    var_05 = level.var_612D.var_D292;
    var_06 = self forceplaygestureviewmodel(var_05);
    if(var_06) {
      childthread lib_0E49::func_D092(var_05, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1);
    }

    self getrawbaseweaponname(0.3, 0.3);
    self _meth_8244("damage_heavy");
    scripts\sp\art::func_583F(1, 1, 0, 0, 40, param_02, 0.05);
    scripts\engine\utility::flag_set("emp_dof_enabled");
    if(isDefined(param_03)) {
      param_03 func_512A(1, ::func_D291, param_01 - 1);
    } else {
      level scripts\engine\utility::delaythread(1, ::func_D291, param_01 - 1);
    }

    thread func_D045(param_03);
    thread func_CFA6(param_03);
    thread scripts\engine\utility::play_loop_sound_on_entity("emp_nade_plr_lp");
    scripts\sp\utility::func_1C49(0);
    return;
  }

  thread scripts\sp\utility::func_D2CD(100, 2);
  self stopgestureviewmodel(level.var_612D.var_D292);
  self notify("stop soundemp_nade_plr_lp");
  if(isDefined(param_03)) {
    param_03 thread func_CE2D("emp_nade_plr_lp_end", self.origin);
  } else {
    playworldsound("emp_nade_plr_lp_end", self.origin);
  }

  self _meth_80A6();
  self stoprumble("damage_heavy");
  self notify("done_shocked");
  scripts\sp\utility::func_1C49(1);
}

func_D291(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(param_01) {
    scripts\sp\art::func_583D(param_00);
    scripts\engine\utility::flag_clear("emp_dof_enabled");
    return;
  }

  if(scripts\engine\utility::flag("emp_dof_enabled")) {
    scripts\sp\art::func_583D(param_00);
    scripts\engine\utility::flag_clear("emp_dof_enabled");
  }
}

func_D045(param_00) {
  self endon("done_shocked");
  for(;;) {
    thread func_10209(level.player.origin + (0, 0, randomintrange(20, 45)), level.var_612D.var_4BF1);
    scripts\sp\utility::play_sound_on_entity("emp_plr_strain");
    wait(randomfloatrange(0.4, 0.8));
  }
}

func_CFA6(param_00) {
  level.player endon("death");
  level.player endon("done_shocked");
  for(;;) {
    var_01 = randomfloatrange(0.8, 1);
    var_02 = randomfloatrange(0.8, 1);
    var_03 = randomfloatrange(0.8, 1);
    var_04 = 0.05;
    var_05 = -1;
    var_06 = -1;
    var_07 = 0;
    var_08 = 0;
    var_09 = 0;
    var_0A = 0;
    var_0B = 1;
    level.player _meth_8291(var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    wait(var_04);
  }
}

func_3453(param_00) {
  self endon("death");
  var_01 = level.var_612D.var_4BF1;
  var_02 = distance2d(self.origin, param_00);
  var_03 = func_7977();
  var_04 = isDefined(self.dontevershoot);
  scripts\asm\asm::asm_setstate("pain_shock");
  if(!var_04) {
    childthread func_FEC5(self.empstartcallback);
  }

  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", self.empstartcallback);
  if(!var_04) {
    self.dontevershoot = undefined;
  }
}

func_354C(param_00) {
  self endon("death");
  var_01 = level.var_612D.var_4BF1;
  var_02 = distance2d(self.origin, param_00);
  var_03 = func_7977();
  self.var_9DD2 = 1;
  scripts\engine\utility::delaythread(1.2, ::scripts\engine\utility::play_sound_in_space, "c12_selfdestruct_beep", self.origin);
  if(vectordot(anglestoright(self.angles), param_00 - self.origin) > 0) {
    var_04 = "right";
  } else {
    var_04 = "left";
  }

  scripts\asm\asm::asm_setstate("pain_emp_" + var_04);
  var_05 = isDefined(self.dontevershoot);
  if(!var_05) {
    childthread func_FEC5(self.empstartcallback);
  }

  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", self.empstartcallback);
  playworldsound("c12_selfdestruct_beep", self.origin);
  if(!var_05) {
    self.dontevershoot = undefined;
  }
}

func_FEC5(param_00) {
  self endon("stop_messing_with_shooting");
  thread scripts\sp\utility::func_C12D("stop_messing_with_shooting", param_00);
  self.dontevershoot = 1;
  wait(2);
  for(;;) {
    self.dontevershoot = undefined;
    wait(2);
    self.dontevershoot = 1;
    wait(randomfloatrange(1.6, 2.2));
  }
}

func_335F(param_00) {
  self endon("death");
  self endon("done_shocked");
  for(var_01 = 0; var_01 < 5; var_01++) {
    wait(randomfloatrange(1, 1.5));
    func_529D();
  }
}

func_529D(param_00, param_01) {
  if(!isDefined(self.var_9DD2)) {
    return;
  }

  if(!isDefined(self.var_4D5D)) {
    return;
  }

  var_02 = [];
  if(!isDefined(self.var_217E)) {
    self.var_217E = "none";
  }

  foreach(var_09, var_04 in self.var_4D5D) {
    if(var_09 != "head" && self _meth_850C(var_09) > 0) {
      var_02[var_09] = [];
    } else {
      continue;
    }

    foreach(var_08, var_06 in self.var_4D5D[var_09].partnerheli) {
      var_07 = self _meth_850C(var_09, var_08);
      if(var_07 > 0) {
        var_02[var_09][var_08] = spawnStruct();
        var_02[var_09][var_08].health = var_07;
        var_02[var_09][var_08].maxhealth = self.var_4D5D[var_09].partnerheli[var_08].maxhealth;
        var_02[var_09][var_08].var_4D6F = self.var_4D5D[var_09].partnerheli[var_08].var_4D6F;
      }
    }
  }

  var_09 = undefined;
  var_08 = undefined;
  if(var_02.size == 0) {
    return;
  }

  if(isDefined(param_00)) {
    var_09 = param_00;
  } else {
    var_09 = scripts\engine\utility::random(getarraykeys(var_02));
  }

  if(var_02[var_09].size == 0) {
    return;
  }

  if(isDefined(param_01)) {
    var_08 = param_01;
  } else {
    var_08 = scripts\engine\utility::random(getarraykeys(var_02[var_09]));
  }

  if(!isDefined(var_02[var_09][var_08])) {
    return;
  }

  thread func_10209(self gettagorigin(var_02[var_09][var_08].var_4D6F), level.var_612D.var_4BF1);
  var_0A = var_02[var_09][var_08].maxhealth;
  self _meth_850B(var_0A, var_09, var_08);
  self.var_217E = var_02[var_09][var_08].var_4D6F;
}

func_10209(param_00, param_01) {
  if(level.var_612D.var_522C.size > 1) {
    return;
  }

  if(!isDefined(self.var_9DD2)) {
    return;
  }

  param_01 = param_01 + (0, 0, 25);
  var_02 = vectornormalize(param_01 - param_00);
  var_03 = vectortoangles(var_02);
  if(getdvarint("debug_emp")) {}

  if(randomint(100) < 25) {
    playworldsound("emp_shock_short", self.origin);
  }

  playfxbetweenpoints(level.var_7649["emp_energy_strand_ptp"], param_00, var_03, param_01, level.player);
}

func_6172() {
  playworldsound("emp_grenade_explode_default", level.var_612D.var_4BF1);
  var_00 = scripts\engine\utility::play_loopsound_in_space("emp_nade_lp", level.var_612D.var_4BF1);
  var_00 endon("death");
  var_00.var_B04F = "emp_nade_lp";
  self.soundevents[self.soundevents.size] = var_00;
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 4);
  playworldsound("emp_nade_lp_end", level.var_612D.var_4BF1);
  var_00 stoploopsound(var_00.var_B04F);
  self.soundevents = scripts\engine\utility::array_remove(self.soundevents, var_00);
  var_00 delete();
}

func_9B56() {
  if(self.unittype == tolower("c8")) {
    var_00 = scripts\engine\utility::ter_op(level.player.var_612D.var_12F6D == 2, 2, 4);
    if(self.var_61A8 < var_00) {
      return 0;
    }
  } else if(self.unittype == tolower("c12")) {
    return 0;
  }

  var_01 = level.var_612D.var_4BF1;
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = distance2d(self.origin, var_01);
  var_03 = func_7977();
  if(var_02 < var_03) {
    return 1;
  }

  return 0;
}

func_6140(param_00) {
  self.var_FE4A = 1;
  self endon("death");
  if(self.unittype == "soldier ") {
    param_00 thread func_CE2D("generic_death_falling_scream", self.origin);
  }

  param_00 thread func_CE2D("gravity_explode_default", self.origin);
  playFXOnTag(level.var_7649[self.unittype + "_death"], self, "j_spine4");
  thread func_10209(self getEye(), level.var_612D.var_4BF1);
  if(self.unittype == "c6") {
    var_01 = int(self.health * 0.3);
    if(isalive(level.var_612D.var_A925)) {
      var_02 = level.var_612D.var_A925;
    } else {
      var_02 = undefined;
    }

    self dodamage(var_01, self.origin, var_02, var_02, "MOD_GRENADE_SPLASH", "emp");
    func_6152(param_00);
  }

  self dodamage(self.health * 10, self.origin, level.var_612D.var_A925, undefined, "MOD_GRENADE_SPLASH", "emp");
}

func_6152(param_00) {
  self endon("death");
  if(!isDefined(self.var_4D5D)) {
    return;
  }

  var_01 = scripts\engine\utility::array_randomize(self.var_4D5D);
  foreach(var_08, var_03 in var_01) {
    if(var_08 == "head") {
      var_04 = self _meth_850C(var_08);
      self _meth_850B(var_04, var_08);
      continue;
    }

    foreach(var_07, var_06 in var_01[var_08].partnerheli) {
      var_04 = self _meth_850C(var_08, var_07);
      self _meth_850B(var_04, var_08, var_07);
      wait(0.1);
    }
  }
}

func_193F(param_00, param_01) {
  switch (tolower(self.unittype)) {
    case "soldier":
      thread func_6156(param_00, param_01);
      break;

    case "c6":
      thread func_335F(param_01);
      break;

    case "c8":
      thread func_6154(param_00);
      break;

    case "c12":
      thread func_6155(param_00);
      break;

    default:
      break;
  }
}

func_6154(param_00) {
  self endon("death");
  self endon("emp_finished");
  var_01 = "emp_electrocute_lp";
  thread scripts\engine\utility::play_loop_sound_on_entity(var_01);
  var_02 = "stop sound" + var_01;
  thread scripts\sp\utility::func_C12D(var_02, param_00);
  thread scripts\sp\utility::func_C12D("emp_finished", param_00);
  scripts\engine\utility::delaythread(param_00, ::scripts\sp\utility::play_sound_on_entity, "emp_nade_lp_end");
  var_03 = scripts\sp\utility::func_7CCC(self.model);
  playFXOnTag(level.var_7649["c8_death"], self, "tag_torso");
  wait(0.15);
  for(;;) {
    var_03 = scripts\engine\utility::array_randomize(var_03);
    foreach(var_05 in var_03) {
      func_10209(self gettagorigin(var_05), level.var_612D.var_4BF1);
      playFXOnTag(level.var_7649["c8_shock"], self, var_05);
      wait(randomfloatrange(0.15, 0.35));
    }

    wait(0.05);
  }
}

func_6155(param_00) {
  self endon("death");
  self endon("emp_finished");
  var_01 = "emp_electrocute_lp";
  thread scripts\engine\utility::play_loop_sound_on_entity(var_01);
  var_02 = "stop sound" + var_01;
  thread scripts\sp\utility::func_C12D(var_02, param_00);
  thread scripts\sp\utility::func_C12D("emp_finished", param_00);
  scripts\engine\utility::delaythread(param_00, ::scripts\sp\utility::play_sound_on_entity, "emp_nade_lp_end");
  var_03 = scripts\sp\utility::func_7CCC(self.model);
  var_03 = scripts\engine\utility::array_randomize(var_03);
  playFXOnTag(level.var_7649["c12_death"], self, "tag_torso");
  wait(0.15);
  for(;;) {
    foreach(var_05 in var_03) {
      thread func_10209(self gettagorigin(var_05), level.var_612D.var_4BF1);
      playFXOnTag(level.var_7649["c12_shock"], self, var_05);
      var_06 = self gettagorigin(var_05);
      wait(randomfloatrange(0.5, 1.7));
    }

    wait(0.05);
  }
}

func_6156(param_00, param_01) {
  thread func_6157(param_01);
  thread func_B06D(level.var_7649["soldier_shock"], "j_spine4", param_00, param_01);
  var_02 = "emp_electrocute_lp";
  thread scripts\engine\utility::play_loop_sound_on_entity(var_02);
  var_03 = self.origin;
  scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "death");
  scripts\sp\utility::func_178D(::scripts\sp\utility::timeout, param_00);
  scripts\sp\utility::func_57D6();
  self notify("stop sound" + var_02);
  playworldsound("emp_nade_lp_end", var_03);
  self notify("stop_looped_vfx");
  if(isalive(self)) {
    scripts\anim\face::saygenericdialogue("pain");
  }
}

func_6157(param_00) {
  self endon("death");
  self endon("stop_looped_vfx");
  param_00 thread func_CE2D("generic_death_falling_scream", self.origin);
  var_01 = scripts\sp\utility::func_7CCC(self.model);
  var_01 = scripts\engine\utility::array_randomize(var_01);
  var_02 = 0;
  for(var_03 = 0; var_03 < 5; var_03++) {
    var_04 = randomfloatrange(1.8, 2.3);
    thread func_10209(self gettagorigin(var_01[var_03]), level.var_612D.var_4BF1);
    wait(var_04);
    playFXOnTag(level.var_7649["soldier_shock"], self, var_01[var_03]);
    if(var_03 == randomintrange(5, 9) && !var_02) {
      var_02 = 1;
      param_00 thread func_CE2D("generic_death_falling_scream", self.origin);
    }
  }
}

func_B06D(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("stop_looped_vfx");
  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    for(;;) {
      var_04 = spawnfx(param_00, self gettagorigin(param_01));
      param_03.var_132AA[param_03.var_132AA.size] = var_04;
      triggerfx(var_04);
      wait(param_02);
      param_03.var_132AA = scripts\engine\utility::array_remove(param_03.var_132AA, var_04);
      var_04 delete();
    }

    return;
  }

  for(;;) {
    playFX(param_00, self gettagorigin(param_01));
    wait(param_02);
  }
}

func_36EB(param_00) {
  var_01 = param_00;
  var_02 = [];
  for(var_03 = 0; var_03 < 12; var_03++) {
    var_04 = 30 * var_03;
    var_05 = level.player.var_612D.fgetarg;
    var_06 = func_6198(var_01, var_04, var_05);
    if(isDefined(var_06)) {
      var_07 = spawnStruct();
      var_07.origin = var_06;
      var_07.var_5F15 = 0;
      if(var_06[2] + 256 < var_01[2]) {
        var_07.var_5F15 = 1;
      }

      var_02[var_02.size] = var_07;
    }
  }

  return var_02;
}

func_106C3(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = self.origin;
  var_02 = [];
  self.var_378D = [];
  for(var_03 = 0; var_03 < self.var_378E.size; var_03++) {
    var_04 = 0;
    var_05 = 0;
    if(var_03 > 0) {
      var_05 = var_03 - 1;
    } else {
      var_05 = self.var_378E.size - 1;
    }

    if(var_03 < self.var_378E.size - 1) {
      var_04 = var_03 + 1;
    } else {
      var_04 = 0;
    }

    var_06 = self.var_378E[var_04].origin;
    var_07 = self.var_378E[var_05].origin;
    var_08 = scripts\engine\utility::flatten_vector(vectornormalize(var_07 - var_06));
    var_09 = rotatevector(var_08, (0, -90, 0));
    if(param_00) {
      self.var_378E[var_03].var_5F15 = 1;
    }

    self.var_378D[self.var_378D.size] = func_106C2(var_01, self.var_378E[var_03].origin, var_09, self.var_378E[var_03].var_5F15);
  }

  if(!param_00) {
    var_0A = level.player.var_612D.fgetarg / 4;
    var_0B = 0;
    for(var_03 = 0; var_03 < self.var_378E.size; var_03++) {
      if(self.var_378E[var_03].var_5F15) {
        continue;
      }

      var_0C = distance(self.var_378E[var_03].origin, var_01);
      var_0D = vectornormalize(self.var_378E[var_03].origin - var_01);
      if(self.var_378E[var_03].origin[2] < var_01[2]) {
        var_0D = scripts\engine\utility::flatten_vector(var_0D);
      }

      var_0E = anglestoright(vectortoangles(var_0D));
      var_0F = var_0A;
      var_10 = [];
      var_11 = 0;
      while(var_0F < var_0C) {
        if(var_11 == 0 && !var_0B) {
          var_12 = 0;
          var_10[var_10.size] = scripts\engine\utility::drop_to_ground(var_01 + rotatevector(var_0D, (0, var_12, 0)) * var_0F, 12, -1000);
        } else if(var_11 == 1) {
          var_12 = 0;
          var_10[var_10.size] = scripts\engine\utility::drop_to_ground(var_01 + rotatevector(var_0D, (0, var_12, 0)) * var_0F, 12, -1000);
        } else if(var_11 == 2) {
          var_12 = 7.5;
          var_10[var_10.size] = scripts\engine\utility::drop_to_ground(var_01 + rotatevector(var_0D, (0, var_12, 0)) * var_0F, 12, -1000);
          var_10[var_10.size] = scripts\engine\utility::drop_to_ground(var_01 + rotatevector(var_0D, (0, 0 - var_12, 0)) * var_0F, 12, -1000);
        }

        var_11++;
        var_0F = var_0F + var_0A;
      }

      foreach(var_14 in var_10) {
        var_15 = [0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4];
        var_16 = randomint(8);
        var_17 = -0.2 + var_15[var_16];
        var_18 = rotatevector((1, 0, 0), (0, randomfloat(360), 0));
        if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
          var_19 = spawnfx(func_79E7("vfx_equip_emp_a2_groundcov"), var_14 + (0, 0, 6), var_18, (0, 0, 1));
          func_C0A9(var_17, ::triggerfx, var_19);
          self.var_132AA[self.var_132AA.size] = var_19;
          continue;
        }

        func_C0A9(var_17, ::playfx, func_79E7("vfx_equip_emp_a2_groundcov"), var_14 + (0, 0, 6), var_18, (0, 0, 1));
      }

      var_0B = !var_0B;
    }
  }

  return self.var_378E;
}

func_6196(param_00, param_01, param_02) {
  var_03 = anglesToForward((0, param_01, 0));
  var_04 = scripts\common\trace::ray_trace_passed(param_00 + (0, 0, 48), param_00 + (0, 0, 48) + var_03 * param_02, undefined, scripts\common\trace::create_world_contents());
  return var_04;
}

func_6198(param_00, param_01, param_02) {
  var_03 = anglesToForward((0, param_01, 0));
  var_04 = scripts\common\trace::ray_trace(param_00 + (0, 0, 48), param_00 + (0, 0, 48) + var_03 * param_02, undefined, scripts\common\trace::create_world_contents());
  if(var_04["fraction"] > 0.5) {
    var_05 = param_02 * var_04["fraction"] - 12;
    var_06 = param_00 + var_03 * var_05;
    var_07 = scripts\engine\utility::drop_to_ground(var_06, 50, -1000);
    return var_07;
  }

  return undefined;
}

func_106C2(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_04 = vectornormalize(param_01 - param_00);
  var_05 = param_01;
  var_06 = param_00 + (0, 0, 2);
  var_07 = spawn("script_model", var_06);
  var_07.angles = (0, 0, 0);
  var_07.var_132AA = [];
  var_07 setModel("anti_grav_border_wm");
  var_07 glinton(#animtree);
  var_08 = randomfloatrange(0.3, 0.65);
  thread func_6195(var_07, var_06, var_05, var_08);
  if(param_02 == (0, 0, 0)) {
    param_02 = (1, 0, 0);
  }

  if(!param_03) {
    if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
      var_09 = spawnfx(func_79E7("vfx_equip_emp_a2_satellite"), param_01, param_02, (0, 0, 1));
      func_C0A9(var_08, ::triggerfx, var_09);
      var_07.var_132AA[var_07.var_132AA.size] = var_09;
    } else {
      func_C0A9(var_08, ::playfx, func_79E7("vfx_equip_emp_a2_satellite"), param_01, param_02, (0, 0, 1));
    }
  } else {
    func_512A(var_08, ::func_6197, var_07, param_01, param_02);
  }

  return var_07;
}

func_6197(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    return;
  }

  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    var_03 = spawnfx(func_79E7("vfx_equip_emp_a2_dud"), param_01, param_02, (0, 0, 1));
    triggerfx(var_03);
    param_00.var_132AA[param_00.var_132AA.size] = var_03;
    return;
  }

  playFX(func_79E7("vfx_equip_emp_a2_dud"), param_01, param_02, (0, 0, 1));
}

func_6195(param_00, param_01, param_02, param_03) {
  param_00 endon("death");
  var_04 = vectornormalize(param_02 - param_01);
  var_05 = distance(param_02, param_01);
  var_06 = param_01 + var_04 * var_05;
  var_07 = randomfloatrange(30, 70);
  var_08 = param_01 + var_04 * var_05 * 0.15 + (0, 0, var_07 * 0.75);
  var_09 = param_01 + var_04 * var_05 * 0.5 + (0, 0, var_07);
  var_0A = param_01 + var_04 * var_05 * 0.85 + (0, 0, var_07 * 0.75);
  var_0B = param_02;
  var_0C = 0;
  if(param_02[2] < param_01[2] - 50) {
    var_0C = 1;
  }

  param_00 ghost_killed_update_func((randomfloatrange(360, 900), 0, randomfloatrange(360, 900)), param_03 - 0.05);
  param_00 moveto(var_08, param_03 / 4, 0, 0);
  wait(param_03 / 4);
  param_00 moveto(var_09, param_03 / 4, 0, 0);
  wait(param_03 / 4);
  param_00 moveto(var_0A, param_03 / 4, 0, 0);
  wait(param_03 / 4);
  param_00 moveto(var_0B, param_03 / 4, 0, 0);
  wait(param_03 / 4);
  var_0D = 0.2;
  var_0E = randomfloat(5);
  param_00 ghost_killed_update_func((randomfloatrange(-40, 40), 0, randomfloatrange(-40, 40)), var_0D - 0.05);
  param_00 moveto(var_0B + var_04 * var_0E / 2 + (0, 0, var_0E), var_0D / 2, 0, var_0D / 2);
  wait(var_0D / 2);
  param_00 moveto(var_0B + var_04 * var_0E, var_0D / 2, var_0D / 2, 0);
  wait(var_0D / 2);
  func_DFFF(param_00);
}

func_79E7(param_00) {
  return level.var_7649[param_00];
}

func_C0A9(param_00, param_01, param_02, param_03, param_04, param_05) {
  thread func_C0AA(param_01, param_00, param_02, param_03, param_04, param_05);
}

func_C0AA(param_00, param_01, param_02, param_03, param_04, param_05) {
  scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", param_01);
  if(isDefined(param_05)) {
    [[param_00]](param_02, param_03, param_04, param_05);
    return;
  }

  if(isDefined(param_04)) {
    [[param_00]](param_02, param_03, param_04);
    return;
  }

  if(isDefined(param_03)) {
    [[param_00]](param_02, param_03);
    return;
  }

  if(isDefined(param_02)) {
    [[param_00]](param_02);
    return;
  }

  [
    [param_00]
  ]();
}

func_512A(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  thread func_512B(param_01, param_00, param_02, param_03, param_04, param_05, param_06, param_07);
}

func_512B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("death");
  self endon("stop_delay_thread");
  scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", param_01);
  if(isDefined(param_07)) {
    thread[[param_00]](param_02, param_03, param_04, param_05, param_06, param_07);
    return;
  }

  if(isDefined(param_06)) {
    thread[[param_00]](param_02, param_03, param_04, param_05, param_06);
    return;
  }

  if(isDefined(param_05)) {
    thread[[param_00]](param_02, param_03, param_04, param_05);
    return;
  }

  if(isDefined(param_04)) {
    thread[[param_00]](param_02, param_03, param_04);
    return;
  }

  if(isDefined(param_03)) {
    thread[[param_00]](param_02, param_03);
    return;
  }

  if(isDefined(param_02)) {
    thread[[param_00]](param_02);
    return;
  }

  thread[[param_00]]();
}

func_CE2D(param_00, param_01, param_02) {
  if(!isDefined(self)) {
    return;
  }

  var_03 = spawn("script_origin", (0, 0, 1));
  if(!isDefined(param_01)) {
    param_01 = self.origin;
  }

  var_03.origin = param_01;
  if(!isDefined(param_02)) {
    param_02 = (0, 0, 0);
  }

  var_03.angles = param_02;
  var_03 playSound(param_00, "sounddone");
  var_03 scripts\engine\utility::waittill_any_3("sounddone", "emp_force_delete");
  var_03 delete();
}