/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3621.gsc
*********************************************/

func_7977() {
  var_0 = level.var_612D.var_A925;
  var_1 = 0;
  var_2 = undefined;
  if(isDefined(var_0) && isplayer(var_0)) {
    var_1 = 1;
  }

  if(isplayer(self)) {
    var_2 = scripts\engine\utility::ter_op(var_1, level.player.var_612D.var_4A6E, 0.2);
  } else {
    switch (tolower(self.unittype)) {
      case "soldier":
        var_2 = scripts\engine\utility::ter_op(var_1, level.player.var_612D.var_4A6D, 0.35);
        break;

      default:
        var_2 = scripts\engine\utility::ter_op(var_1, level.player.var_612D.var_4A6C, 0.6);
        break;
    }
  }

  if(self.team == "allies") {
    return level.player.var_612D.fgetarg * 0.25;
  }

  return level.player.var_612D.fgetarg * var_2;
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

func_6133(var_0) {
  level.var_612D.var_4BF1 = var_0.origin;
  level.var_612D.var_A925 = level.player;
  var_1 = scripts\engine\utility::spawn_tag_origin(level.var_612D.var_4BF1, (0, 0, 0));
  var_1.var_132AA = [];
  var_1.soundevents = [];
  level.var_612D.var_522C[level.var_612D.var_522C.size] = var_1;
  var_1.var_378E = func_36EB(level.var_612D.var_4BF1);
  var_1 func_106C3();
  var_1 thread func_6172();
  var_1 thread func_613B();
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 0);
  var_1 thread func_6142();
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 4);
  var_1 thread func_DFFE();
}

func_615B(var_0) {
  level.player thread scripts\anim\battlechatter_ai::func_67CF("emp");
  var_1 = spawnStruct();
  var_1.var_132AA = [];
  var_1.soundevents = [];
  var_1.objective_position = var_0;
  var_1.origin = var_0.origin;
  var_1.triggerportableradarping = self;
  level.var_612D.var_522C[level.var_612D.var_522C.size] = var_1;
  var_2 = var_0 scripts\engine\utility::waittill_any_return("explode", "missile_stuck", "death", "entitydeleted");
  if(!isDefined(var_0)) {
    var_1 thread func_DFFE();
    return;
  }

  if(!isDefined(var_0.origin)) {
    return;
  }

  var_1.origin = var_1.objective_position.origin;
  level.var_612D.var_4BF1 = var_1.objective_position.origin;
  level.var_612D.var_A925 = self;
  var_1 func_512A(0.5, ::func_E000);
  var_3 = level.var_612D.var_522C.size < 2;
  if(var_3) {
    var_1.var_378E = func_36EB(level.var_612D.var_4BF1);
  }

  var_1.origin = level.var_612D.var_4BF1;
  var_1.angles = (0, 0, 0);
  if(var_3) {
    var_1 func_106C3();
  }

  var_1 thread func_6172();
  var_1 thread func_613B();
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 0);
  var_1 thread func_6142();
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 4);
  var_1 thread func_DFFE();
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
    foreach(var_1 in self.soundevents) {
      if(isDefined(var_1.var_B04F)) {
        var_1 stoploopsound(var_1.var_B04F);
      }

      var_1 notify("sounddone");
      var_1 delete();
    }
  }

  if(isDefined(self.var_132AA)) {
    self.var_132AA = scripts\engine\utility::array_removeundefined(self.var_132AA);
    foreach(var_4 in self.var_132AA) {
      var_4 delete();
    }
  }

  if(isDefined(self.var_378D)) {
    self.var_378D = scripts\engine\utility::array_removeundefined(self.var_378D);
    var_6 = self.var_378D;
    foreach(var_8 in var_6) {
      func_DFFF(var_8);
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

func_DFFF(var_0) {
  if(isDefined(var_0.var_132AA)) {
    foreach(var_2 in var_0.var_132AA) {
      var_2 delete();
    }
  }

  killfxontag(level._effect["antigrav_caltrop_trail"], var_0, "tag_origin");
  self.var_378D = scripts\engine\utility::array_remove(self.var_378D, var_0);
  var_0 delete();
}

func_DFBE() {
  level notify("removing_all_emps_instantly");
  level endon("removing_all_emps_instantly");
  scripts\engine\utility::flag_set("emp_force_delete");
  foreach(var_1 in level.var_612D.var_522C) {
    var_1 thread func_E000();
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
  var_0 = scripts\engine\utility::ter_op(level.var_612D.var_522C.size < 2, "vfx_equip_emp_a2_centerblast", "vfx_equip_emp_a2_centerblast_cheap");
  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    var_1 = spawnfx(level.var_7649[var_0], level.var_612D.var_4BF1);
    triggerfx(var_1);
    self.var_132AA[self.var_132AA.size] = var_1;
    return;
  }

  playFX(level.var_7649[var_0], level.var_612D.var_4BF1);
}

func_6142() {
  self.targets = [];
  level.var_612D.var_9927++;
  earthquake(0.7, 0.5, level.var_612D.var_4BF1, 450);
  thread func_6132();
  thread func_106C1(level.var_612D.var_4BF1);
  if(isDefined(level.var_CAF7)) {
    var_0 = 0.3;
    var_1 = sortbydistance(level.var_CAF7, self.origin);
    foreach(var_3 in var_1) {
      if(var_3 == self) {
        continue;
      }

      var_4 = distance(self.origin, var_3.origin);
      if(var_4 > level.player.var_612D.fgetarg) {
        continue;
      }

      var_5 = level.player.var_612D.fgetarg - var_4;
      var_6 = var_5 / level.player.var_612D.fgetarg;
      var_7 = var_0 * var_6;
      if(var_4 <= level.player.var_612D.fgetarg) {
        var_3 thread lib_0E1F::func_6136(self.origin, var_4, var_7);
      }
    }
  }
}

func_6132() {
  self.var_E1A8 = "emp" + level.var_612D.var_9927;
  createnavrepulsor(self.var_E1A8, -1, level.var_612D.var_4BF1, level.player.var_612D.fgetarg * 2, 1);
}

func_106C1(var_0) {
  self.trigger = spawn("trigger_radius", var_0, 7, level.player.var_612D.fgetarg, 40);
  if(isDefined(self.triggerportableradarping) && level.player == self.triggerportableradarping) {
    var_1 = self.triggerportableradarping scripts\sp\detonategrenades::func_734E();
    self.triggerportableradarping scripts\engine\utility::delaythread(1.25, scripts\sp\detonategrenades::func_734D, var_0, var_1, level.player.var_612D.fgetarg);
  }

  for(;;) {
    self.trigger waittill("trigger", var_2);
    if(isplayer(var_2)) {
      if(scripts\sp\detonategrenades::func_385D(level.var_612D.var_4BF1 + (0, 0, 40))) {
        var_2 thread func_5781(self);
      } else if(getdvarint("debug_emp")) {
        iprintln("^1 EMP can\'t trace to player");
      }

      continue;
    }

    if(scripts\sp\detonategrenades::func_385C(level.var_612D.var_4BF1 + (0, 0, 40), var_2)) {
      var_2 func_5781(self);
    }
  }
}

func_5781(var_0) {
  if(isDefined(self.unittype) && self.unittype == "civilian") {
    return;
  }

  if(isDefined(self.var_9DD2) && self.var_9DD2) {
    return;
  }

  if(isDefined(self.team) && self.team == "allies") {
    var_1 = 0;
    if(isDefined(self.var_A979)) {
      if(gettime() - self.var_A979 < 15000) {
        if(getdvarint("debug_emp")) {
          iprintln(self.classname + "^5 was EMPd within the last 15 secs - aborting");
        }

        var_1 = 1;
      }
    }

    if(var_1) {
      return;
    }
  }

  self.var_A979 = gettime();
  if(isplayer(self)) {
    thread func_D044(var_0);
    return;
  }

  self.var_9DD2 = 1;
  if(!isDefined(self.var_61A8)) {
    self.var_61A8 = 1;
  } else {
    self.var_61A8++;
  }

  if(isDefined(self.a.var_58DA)) {
    var_2 = self.health;
  }

  if(func_9B56()) {
    thread func_6140(var_0);
    return;
  }

  func_F388();
  var_2 = func_36EA();
  if(isalive(level.var_612D.var_A925)) {
    var_3 = level.var_612D.var_A925;
  } else {
    var_3 = undefined;
  }

  level.var_612D.var_4BCA[level.var_612D.var_4BCA.size] = self;
  if(isDefined(self.team) && self.team == "allies") {
    thread func_89A6(var_0);
  }

  self dodamage(var_2, self.origin, var_3, var_3, "MOD_GRENADE_SPLASH", "emp");
  thread func_613C(self.empstartcallback, var_0);
  thread func_193F(self.empstartcallback, var_0);
  if(!isalive(self)) {
    return;
  }

  if(scripts\asm\asm_bb::bb_isanimscripted() || self func_81A6() || isDefined(self.script) && self.script == "pain" || scripts\sp\utility::isactorwallrunning()) {
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

func_36E9(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  switch (tolower(self.unittype)) {
    case "soldier":
      var_2 = 50;
      var_3 = 90;
      break;

    case "c6i":
    case "c6":
      var_2 = 250;
      var_3 = 325;
      break;

    case "seeker":
      var_2 = 500;
      var_3 = 500;
      break;

    case "c8":
      var_2 = 900;
      var_3 = 1000;
      break;

    case "c12":
      var_2 = 1200;
      var_3 = 1800;
      break;
  }

  var_4 = distance2d(self.origin, var_0);
  var_5 = scripts\sp\math::func_C097(0, var_1, var_4);
  var_6 = scripts\sp\math::func_6A8E(var_3, var_2, var_5) * 0.5;
  return var_6;
}

func_5772(var_0, var_1) {
  self endon("death");
  if(!isDefined(var_0.triggerportableradarping.team) || !isDefined(self.team)) {
    return;
  }

  if(var_0.triggerportableradarping.team == self.team) {
    return;
  }

  if(isDefined(self.var_9DD2) && self.var_9DD2) {
    return;
  }

  self.var_9DD2 = 1;
  self.empstartcallback = randomfloatrange(0.9, 1.6);
  var_2 = func_36E9(var_0.origin, var_1);
  if(isDefined(self.a.var_58DA)) {
    var_2 = self.health;
  }

  self dodamage(var_2, self.origin, var_0, var_0.triggerportableradarping, "MOD_GRENADE_SPLASH", "emp");
  thread func_3D25(self.empstartcallback);
  thread func_3D26(var_0, ["j_spineupper", "j_spinelower", "j_knee_le", "j_ankle_ri", "j_elbow_le", "j_wrist_ri", "j_neck", "j_head"]);
  switch (tolower(self.unittype)) {
    case "c8":
      break;

    case "c12":
      break;
  }

  wait(self.empstartcallback);
  self.var_9DD2 = undefined;
}

func_3D25(var_0) {
  playworldsound("emp_shock_short", self.origin);
  playworldsound("generic_death_falling_scream", self.origin);
  thread func_B06D(level.var_7649["soldier_shock"], "j_spine4", var_0);
  var_1 = "emp_electrocute_lp";
  thread scripts\engine\utility::play_loop_sound_on_entity(var_1);
  var_2 = self.origin;
  scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "death");
  scripts\sp\utility::func_178D(scripts\sp\utility::timeout, var_0);
  scripts\sp\utility::func_57D6();
  self notify("stop sound" + var_1);
  playworldsound("emp_nade_lp_end", var_2);
  self notify("stop_looped_vfx");
  if(isalive(self)) {
    scripts\anim\face::saygenericdialogue("pain");
  }
}

func_3D26(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  var_2 = var_0.origin;
  for(var_3 = 0; var_3 < 2; var_3++) {
    var_4 = scripts\engine\utility::random(var_1);
    var_5 = self gettagorigin(var_4);
    var_6 = vectornormalize(var_5 - var_2);
    var_7 = vectortoangles(var_6);
    playfxbetweenpoints(level.var_7649["emp_energy_strand_ptp"], var_2, var_7, var_5, level.player);
  }
}

func_89A6(var_0) {
  self endon("death");
  if((isDefined(self.health) && self.health < 0) || isDefined(self.forceempfriendlyfail)) {
    return;
  }

  self.var_BFED = 1;
  wait(0.1);
  self.var_BFED = undefined;
}

func_F388() {
  var_0 = level.var_612D.var_4BF1;
  var_1 = distance2d(self.origin, var_0);
  var_2 = func_7977();
  var_3 = scripts\engine\utility::ter_op(isDefined(self.team) && self.team == "allies", 2, 4);
  var_4 = scripts\sp\math::func_C097(var_2, level.player.var_612D.fgetarg, var_1);
  self.empstartcallback = scripts\sp\math::func_6A8E(var_3, 1.5, var_4);
}

func_36EA() {
  var_0 = undefined;
  var_1 = undefined;
  switch (tolower(self.unittype)) {
    case "soldier":
      var_0 = 50;
      var_1 = 90;
      break;

    case "c6i":
    case "c6":
      var_0 = 250;
      var_1 = 325;
      break;

    case "seeker":
      var_0 = 500;
      var_1 = 500;
      break;

    case "c8":
      var_0 = 900;
      var_1 = 1000;
      break;

    case "c12":
      var_0 = 1200;
      var_1 = 1800;
      break;
  }

  var_2 = distance2d(self.origin, level.var_612D.var_4BF1);
  var_3 = scripts\sp\math::func_C097(0, level.player.var_612D.fgetarg, var_2);
  var_4 = scripts\sp\math::func_6A8E(var_1, var_0, var_3);
  return var_4;
}

func_613C(var_0, var_1) {
  self endon("death");
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", var_0);
  level.var_612D.var_4BCA = scripts\engine\utility::array_remove(level.var_612D.var_4BCA, self);
  self.var_9DD2 = undefined;
}

func_D044(var_0) {
  self endon("death");
  if(scripts\sp\utility::func_65DB("player_retract_shield_active")) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, level.var_612D.var_4BF1, cos(65))) {
      return;
    }
  }

  if(isDefined(self.var_9DD2) && self.var_9DD2) {
    return;
  }

  var_1 = level.var_612D.var_4BF1;
  var_2 = distance2d(self.origin, var_1);
  if(getdvarint("debug_emp")) {}

  var_3 = func_7977();
  scripts\sp\utility::func_54EF(var_1);
  self.var_9DD2 = 1;
  var_3 = func_7977();
  var_4 = scripts\sp\math::func_C097(var_3, level.player.var_612D.fgetarg, var_2);
  var_5 = scripts\sp\math::func_6A8E(level.var_612D.var_B44E, level.var_612D.var_B74B, var_4);
  if(var_2 < var_3) {
    if(!scripts\engine\utility::flag_exist("in_vr_mode") || scripts\engine\utility::flag_exist("in_vr_mode") && !scripts\engine\utility::flag("in_vr_mode")) {
      playworldsound("gravity_explode_default", self.origin);
      playFX(level.var_7649["c12_impact"], self getEye());
      scripts\engine\utility::delaythread(0.5, scripts\sp\utility::func_54C6);
    }
  } else {
    self dodamage(self.health * 0.3, self.origin, level.var_612D.var_A925, level.var_612D.var_A925, "MOD_GRENADE_SPLASH", "emp");
    thread func_613C(var_5, var_0);
  }

  level.var_612D.var_CF96 = scripts\sp\math::func_6A8E(50, 10, var_4);
  var_6 = isDefined(self.var_764D) && self.var_764D != 1;
  if(var_6) {
    var_7 = self.var_764D;
  }

  if(getdvarint("debug_emp")) {
    iprintln("^5Player Dist: ^3" + int(var_2) + "^5 Struntime: ^3" + var_5);
  }

  func_D293(1, var_5, level.var_612D.var_CF96, var_0);
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", var_5);
  func_D293(0, undefined, undefined, var_0);
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 0.45);
  scripts\sp\utility::play_sound_on_entity("emp_plr_strain");
}

func_D293(var_0, var_1, var_2, var_3) {
  if(var_0) {
    if(isDefined(var_3)) {
      if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
        var_4 = spawnfx(level.var_7649["player_shock"], (0, 0, 0));
        triggerfx(var_4);
        var_3.var_132AA[var_3.var_132AA.size] = var_4;
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

    var_5 = level.var_612D.var_D292;
    var_6 = self forceplaygestureviewmodel(var_5);
    if(var_6) {
      childthread lib_0E49::func_D092(var_5, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1);
    }

    self getrawbaseweaponname(0.3, 0.3);
    self func_8244("damage_heavy");
    scripts\sp\art::func_583F(1, 1, 0, 0, 40, var_2, 0.05);
    scripts\engine\utility::flag_set("emp_dof_enabled");
    if(isDefined(var_3)) {
      var_3 func_512A(1, ::func_D291, var_1 - 1);
    } else {
      level scripts\engine\utility::delaythread(1, ::func_D291, var_1 - 1);
    }

    thread func_D045(var_3);
    thread func_CFA6(var_3);
    thread scripts\engine\utility::play_loop_sound_on_entity("emp_nade_plr_lp");
    scripts\sp\utility::func_1C49(0);
    return;
  }

  thread scripts\sp\utility::func_D2CD(100, 2);
  self stopgestureviewmodel(level.var_612D.var_D292);
  self notify("stop soundemp_nade_plr_lp");
  if(isDefined(var_3)) {
    var_3 thread func_CE2D("emp_nade_plr_lp_end", self.origin);
  } else {
    playworldsound("emp_nade_plr_lp_end", self.origin);
  }

  self func_80A6();
  self stoprumble("damage_heavy");
  self notify("done_shocked");
  scripts\sp\utility::func_1C49(1);
}

func_D291(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    scripts\sp\art::func_583D(var_0);
    scripts\engine\utility::flag_clear("emp_dof_enabled");
    return;
  }

  if(scripts\engine\utility::flag("emp_dof_enabled")) {
    scripts\sp\art::func_583D(var_0);
    scripts\engine\utility::flag_clear("emp_dof_enabled");
  }
}

func_D045(var_0) {
  self endon("done_shocked");
  for(;;) {
    thread func_10209(level.player.origin + (0, 0, randomintrange(20, 45)), level.var_612D.var_4BF1);
    scripts\sp\utility::play_sound_on_entity("emp_plr_strain");
    wait(randomfloatrange(0.4, 0.8));
  }
}

func_CFA6(var_0) {
  level.player endon("death");
  level.player endon("done_shocked");
  for(;;) {
    var_1 = randomfloatrange(0.8, 1);
    var_2 = randomfloatrange(0.8, 1);
    var_3 = randomfloatrange(0.8, 1);
    var_4 = 0.05;
    var_5 = -1;
    var_6 = -1;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_0A = 0;
    var_0B = 1;
    level.player func_8291(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    wait(var_4);
  }
}

func_3453(var_0) {
  self endon("death");
  var_1 = level.var_612D.var_4BF1;
  var_2 = distance2d(self.origin, var_0);
  var_3 = func_7977();
  var_4 = isDefined(self.dontevershoot);
  scripts\asm\asm::asm_setstate("pain_shock");
  if(!var_4) {
    childthread func_FEC5(self.empstartcallback);
  }

  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", self.empstartcallback);
  if(!var_4) {
    self.dontevershoot = undefined;
  }
}

func_354C(var_0) {
  self endon("death");
  var_1 = level.var_612D.var_4BF1;
  var_2 = distance2d(self.origin, var_0);
  var_3 = func_7977();
  self.var_9DD2 = 1;
  scripts\engine\utility::delaythread(1.2, scripts\engine\utility::play_sound_in_space, "c12_selfdestruct_beep", self.origin);
  if(vectordot(anglestoright(self.angles), var_0 - self.origin) > 0) {
    var_4 = "right";
  } else {
    var_4 = "left";
  }

  scripts\asm\asm::asm_setstate("pain_emp_" + var_4);
  var_5 = isDefined(self.dontevershoot);
  if(!var_5) {
    childthread func_FEC5(self.empstartcallback);
  }

  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", self.empstartcallback);
  playworldsound("c12_selfdestruct_beep", self.origin);
  if(!var_5) {
    self.dontevershoot = undefined;
  }
}

func_FEC5(var_0) {
  self endon("stop_messing_with_shooting");
  thread scripts\sp\utility::func_C12D("stop_messing_with_shooting", var_0);
  self.dontevershoot = 1;
  wait(2);
  for(;;) {
    self.dontevershoot = undefined;
    wait(2);
    self.dontevershoot = 1;
    wait(randomfloatrange(1.6, 2.2));
  }
}

func_335F(var_0) {
  self endon("death");
  self endon("done_shocked");
  for(var_1 = 0; var_1 < 5; var_1++) {
    wait(randomfloatrange(1, 1.5));
    func_529D();
  }
}

func_529D(var_0, var_1) {
  if(!isDefined(self.var_9DD2)) {
    return;
  }

  if(!isDefined(self.var_4D5D)) {
    return;
  }

  var_2 = [];
  if(!isDefined(self.var_217E)) {
    self.var_217E = "none";
  }

  foreach(var_9, var_4 in self.var_4D5D) {
    if(var_9 != "head" && self func_850C(var_9) > 0) {
      var_2[var_9] = [];
    } else {
      continue;
    }

    foreach(var_8, var_6 in self.var_4D5D[var_9].partnerheli) {
      var_7 = self func_850C(var_9, var_8);
      if(var_7 > 0) {
        var_2[var_9][var_8] = spawnStruct();
        var_2[var_9][var_8].health = var_7;
        var_2[var_9][var_8].maxhealth = self.var_4D5D[var_9].partnerheli[var_8].maxhealth;
        var_2[var_9][var_8].var_4D6F = self.var_4D5D[var_9].partnerheli[var_8].var_4D6F;
      }
    }
  }

  var_9 = undefined;
  var_8 = undefined;
  if(var_2.size == 0) {
    return;
  }

  if(isDefined(var_0)) {
    var_9 = var_0;
  } else {
    var_9 = scripts\engine\utility::random(getarraykeys(var_2));
  }

  if(var_2[var_9].size == 0) {
    return;
  }

  if(isDefined(var_1)) {
    var_8 = var_1;
  } else {
    var_8 = scripts\engine\utility::random(getarraykeys(var_2[var_9]));
  }

  if(!isDefined(var_2[var_9][var_8])) {
    return;
  }

  thread func_10209(self gettagorigin(var_2[var_9][var_8].var_4D6F), level.var_612D.var_4BF1);
  var_0A = var_2[var_9][var_8].maxhealth;
  self func_850B(var_0A, var_9, var_8);
  self.var_217E = var_2[var_9][var_8].var_4D6F;
}

func_10209(var_0, var_1) {
  if(level.var_612D.var_522C.size > 1) {
    return;
  }

  if(!isDefined(self.var_9DD2)) {
    return;
  }

  var_1 = var_1 + (0, 0, 25);
  var_2 = vectornormalize(var_1 - var_0);
  var_3 = vectortoangles(var_2);
  if(getdvarint("debug_emp")) {}

  if(randomint(100) < 25) {
    playworldsound("emp_shock_short", self.origin);
  }

  playfxbetweenpoints(level.var_7649["emp_energy_strand_ptp"], var_0, var_3, var_1, level.player);
}

func_6172() {
  playworldsound("emp_grenade_explode_default", level.var_612D.var_4BF1);
  var_0 = scripts\engine\utility::play_loopsound_in_space("emp_nade_lp", level.var_612D.var_4BF1);
  var_0 endon("death");
  var_0.var_B04F = "emp_nade_lp";
  self.soundevents[self.soundevents.size] = var_0;
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 4);
  playworldsound("emp_nade_lp_end", level.var_612D.var_4BF1);
  var_0 stoploopsound(var_0.var_B04F);
  self.soundevents = scripts\engine\utility::array_remove(self.soundevents, var_0);
  var_0 delete();
}

func_9B56() {
  if(self.unittype == tolower("c8")) {
    var_0 = scripts\engine\utility::ter_op(level.player.var_612D.var_12F6D == 2, 2, 4);
    if(self.var_61A8 < var_0) {
      return 0;
    }
  } else if(self.unittype == tolower("c12")) {
    return 0;
  }

  var_1 = level.var_612D.var_4BF1;
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = distance2d(self.origin, var_1);
  var_3 = func_7977();
  if(var_2 < var_3) {
    return 1;
  }

  return 0;
}

func_6140(var_0) {
  self.var_FE4A = 1;
  self endon("death");
  if(self.unittype == "soldier ") {
    var_0 thread func_CE2D("generic_death_falling_scream", self.origin);
  }

  var_0 thread func_CE2D("gravity_explode_default", self.origin);
  playFXOnTag(level.var_7649[self.unittype + "_death"], self, "j_spine4");
  thread func_10209(self getEye(), level.var_612D.var_4BF1);
  if(self.unittype == "c6") {
    var_1 = int(self.health * 0.3);
    if(isalive(level.var_612D.var_A925)) {
      var_2 = level.var_612D.var_A925;
    } else {
      var_2 = undefined;
    }

    self dodamage(var_1, self.origin, var_2, var_2, "MOD_GRENADE_SPLASH", "emp");
    func_6152(var_0);
  }

  self dodamage(self.health * 10, self.origin, level.var_612D.var_A925, undefined, "MOD_GRENADE_SPLASH", "emp");
}

func_6152(var_0) {
  self endon("death");
  if(!isDefined(self.var_4D5D)) {
    return;
  }

  var_1 = scripts\engine\utility::array_randomize(self.var_4D5D);
  foreach(var_8, var_3 in var_1) {
    if(var_8 == "head") {
      var_4 = self func_850C(var_8);
      self func_850B(var_4, var_8);
      continue;
    }

    foreach(var_7, var_6 in var_1[var_8].partnerheli) {
      var_4 = self func_850C(var_8, var_7);
      self func_850B(var_4, var_8, var_7);
      wait(0.1);
    }
  }
}

func_193F(var_0, var_1) {
  switch (tolower(self.unittype)) {
    case "soldier":
      thread func_6156(var_0, var_1);
      break;

    case "c6":
      thread func_335F(var_1);
      break;

    case "c8":
      thread func_6154(var_0);
      break;

    case "c12":
      thread func_6155(var_0);
      break;

    default:
      break;
  }
}

func_6154(var_0) {
  self endon("death");
  self endon("emp_finished");
  var_1 = "emp_electrocute_lp";
  thread scripts\engine\utility::play_loop_sound_on_entity(var_1);
  var_2 = "stop sound" + var_1;
  thread scripts\sp\utility::func_C12D(var_2, var_0);
  thread scripts\sp\utility::func_C12D("emp_finished", var_0);
  scripts\engine\utility::delaythread(var_0, scripts\sp\utility::play_sound_on_entity, "emp_nade_lp_end");
  var_3 = scripts\sp\utility::func_7CCC(self.model);
  playFXOnTag(level.var_7649["c8_death"], self, "tag_torso");
  wait(0.15);
  for(;;) {
    var_3 = scripts\engine\utility::array_randomize(var_3);
    foreach(var_5 in var_3) {
      func_10209(self gettagorigin(var_5), level.var_612D.var_4BF1);
      playFXOnTag(level.var_7649["c8_shock"], self, var_5);
      wait(randomfloatrange(0.15, 0.35));
    }

    wait(0.05);
  }
}

func_6155(var_0) {
  self endon("death");
  self endon("emp_finished");
  var_1 = "emp_electrocute_lp";
  thread scripts\engine\utility::play_loop_sound_on_entity(var_1);
  var_2 = "stop sound" + var_1;
  thread scripts\sp\utility::func_C12D(var_2, var_0);
  thread scripts\sp\utility::func_C12D("emp_finished", var_0);
  scripts\engine\utility::delaythread(var_0, scripts\sp\utility::play_sound_on_entity, "emp_nade_lp_end");
  var_3 = scripts\sp\utility::func_7CCC(self.model);
  var_3 = scripts\engine\utility::array_randomize(var_3);
  playFXOnTag(level.var_7649["c12_death"], self, "tag_torso");
  wait(0.15);
  for(;;) {
    foreach(var_5 in var_3) {
      thread func_10209(self gettagorigin(var_5), level.var_612D.var_4BF1);
      playFXOnTag(level.var_7649["c12_shock"], self, var_5);
      var_6 = self gettagorigin(var_5);
      wait(randomfloatrange(0.5, 1.7));
    }

    wait(0.05);
  }
}

func_6156(var_0, var_1) {
  thread func_6157(var_1);
  thread func_B06D(level.var_7649["soldier_shock"], "j_spine4", var_0, var_1);
  var_2 = "emp_electrocute_lp";
  thread scripts\engine\utility::play_loop_sound_on_entity(var_2);
  var_3 = self.origin;
  scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "death");
  scripts\sp\utility::func_178D(scripts\sp\utility::timeout, var_0);
  scripts\sp\utility::func_57D6();
  self notify("stop sound" + var_2);
  playworldsound("emp_nade_lp_end", var_3);
  self notify("stop_looped_vfx");
  if(isalive(self)) {
    scripts\anim\face::saygenericdialogue("pain");
  }
}

func_6157(var_0) {
  self endon("death");
  self endon("stop_looped_vfx");
  var_0 thread func_CE2D("generic_death_falling_scream", self.origin);
  var_1 = scripts\sp\utility::func_7CCC(self.model);
  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_2 = 0;
  for(var_3 = 0; var_3 < 5; var_3++) {
    var_4 = randomfloatrange(1.8, 2.3);
    thread func_10209(self gettagorigin(var_1[var_3]), level.var_612D.var_4BF1);
    wait(var_4);
    playFXOnTag(level.var_7649["soldier_shock"], self, var_1[var_3]);
    if(var_3 == randomintrange(5, 9) && !var_2) {
      var_2 = 1;
      var_0 thread func_CE2D("generic_death_falling_scream", self.origin);
    }
  }
}

func_B06D(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("stop_looped_vfx");
  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    for(;;) {
      var_4 = spawnfx(var_0, self gettagorigin(var_1));
      var_3.var_132AA[var_3.var_132AA.size] = var_4;
      triggerfx(var_4);
      wait(var_2);
      var_3.var_132AA = scripts\engine\utility::array_remove(var_3.var_132AA, var_4);
      var_4 delete();
    }

    return;
  }

  for(;;) {
    playFX(var_0, self gettagorigin(var_1));
    wait(var_2);
  }
}

func_36EB(var_0) {
  var_1 = var_0;
  var_2 = [];
  for(var_3 = 0; var_3 < 12; var_3++) {
    var_4 = 30 * var_3;
    var_5 = level.player.var_612D.fgetarg;
    var_6 = func_6198(var_1, var_4, var_5);
    if(isDefined(var_6)) {
      var_7 = spawnStruct();
      var_7.origin = var_6;
      var_7.var_5F15 = 0;
      if(var_6[2] + 256 < var_1[2]) {
        var_7.var_5F15 = 1;
      }

      var_2[var_2.size] = var_7;
    }
  }

  return var_2;
}

func_106C3(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = self.origin;
  var_2 = [];
  self.var_378D = [];
  for(var_3 = 0; var_3 < self.var_378E.size; var_3++) {
    var_4 = 0;
    var_5 = 0;
    if(var_3 > 0) {
      var_5 = var_3 - 1;
    } else {
      var_5 = self.var_378E.size - 1;
    }

    if(var_3 < self.var_378E.size - 1) {
      var_4 = var_3 + 1;
    } else {
      var_4 = 0;
    }

    var_6 = self.var_378E[var_4].origin;
    var_7 = self.var_378E[var_5].origin;
    var_8 = scripts\engine\utility::flatten_vector(vectornormalize(var_7 - var_6));
    var_9 = rotatevector(var_8, (0, -90, 0));
    if(var_0) {
      self.var_378E[var_3].var_5F15 = 1;
    }

    self.var_378D[self.var_378D.size] = func_106C2(var_1, self.var_378E[var_3].origin, var_9, self.var_378E[var_3].var_5F15);
  }

  if(!var_0) {
    var_0A = level.player.var_612D.fgetarg / 4;
    var_0B = 0;
    for(var_3 = 0; var_3 < self.var_378E.size; var_3++) {
      if(self.var_378E[var_3].var_5F15) {
        continue;
      }

      var_0C = distance(self.var_378E[var_3].origin, var_1);
      var_0D = vectornormalize(self.var_378E[var_3].origin - var_1);
      if(self.var_378E[var_3].origin[2] < var_1[2]) {
        var_0D = scripts\engine\utility::flatten_vector(var_0D);
      }

      var_0E = anglestoright(vectortoangles(var_0D));
      var_0F = var_0A;
      var_10 = [];
      var_11 = 0;
      while(var_0F < var_0C) {
        if(var_11 == 0 && !var_0B) {
          var_12 = 0;
          var_10[var_10.size] = scripts\engine\utility::drop_to_ground(var_1 + rotatevector(var_0D, (0, var_12, 0)) * var_0F, 12, -1000);
        } else if(var_11 == 1) {
          var_12 = 0;
          var_10[var_10.size] = scripts\engine\utility::drop_to_ground(var_1 + rotatevector(var_0D, (0, var_12, 0)) * var_0F, 12, -1000);
        } else if(var_11 == 2) {
          var_12 = 7.5;
          var_10[var_10.size] = scripts\engine\utility::drop_to_ground(var_1 + rotatevector(var_0D, (0, var_12, 0)) * var_0F, 12, -1000);
          var_10[var_10.size] = scripts\engine\utility::drop_to_ground(var_1 + rotatevector(var_0D, (0, 0 - var_12, 0)) * var_0F, 12, -1000);
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

func_6196(var_0, var_1, var_2) {
  var_3 = anglesToForward((0, var_1, 0));
  var_4 = scripts\common\trace::ray_trace_passed(var_0 + (0, 0, 48), var_0 + (0, 0, 48) + var_3 * var_2, undefined, scripts\common\trace::create_world_contents());
  return var_4;
}

func_6198(var_0, var_1, var_2) {
  var_3 = anglesToForward((0, var_1, 0));
  var_4 = scripts\common\trace::ray_trace(var_0 + (0, 0, 48), var_0 + (0, 0, 48) + var_3 * var_2, undefined, scripts\common\trace::create_world_contents());
  if(var_4["fraction"] > 0.5) {
    var_5 = var_2 * var_4["fraction"] - 12;
    var_6 = var_0 + var_3 * var_5;
    var_7 = scripts\engine\utility::drop_to_ground(var_6, 50, -1000);
    return var_7;
  }

  return undefined;
}

func_106C2(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = vectornormalize(var_1 - var_0);
  var_5 = var_1;
  var_6 = var_0 + (0, 0, 2);
  var_7 = spawn("script_model", var_6);
  var_7.angles = (0, 0, 0);
  var_7.var_132AA = [];
  var_7 setModel("anti_grav_border_wm");
  var_7 glinton(#animtree);
  var_8 = randomfloatrange(0.3, 0.65);
  thread func_6195(var_7, var_6, var_5, var_8);
  if(var_2 == (0, 0, 0)) {
    var_2 = (1, 0, 0);
  }

  if(!var_3) {
    if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
      var_9 = spawnfx(func_79E7("vfx_equip_emp_a2_satellite"), var_1, var_2, (0, 0, 1));
      func_C0A9(var_8, ::triggerfx, var_9);
      var_7.var_132AA[var_7.var_132AA.size] = var_9;
    } else {
      func_C0A9(var_8, ::playfx, func_79E7("vfx_equip_emp_a2_satellite"), var_1, var_2, (0, 0, 1));
    }
  } else {
    func_512A(var_8, ::func_6197, var_7, var_1, var_2);
  }

  return var_7;
}

func_6197(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    var_3 = spawnfx(func_79E7("vfx_equip_emp_a2_dud"), var_1, var_2, (0, 0, 1));
    triggerfx(var_3);
    var_0.var_132AA[var_0.var_132AA.size] = var_3;
    return;
  }

  playFX(func_79E7("vfx_equip_emp_a2_dud"), var_1, var_2, (0, 0, 1));
}

func_6195(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_4 = vectornormalize(var_2 - var_1);
  var_5 = distance(var_2, var_1);
  var_6 = var_1 + var_4 * var_5;
  var_7 = randomfloatrange(30, 70);
  var_8 = var_1 + var_4 * var_5 * 0.15 + (0, 0, var_7 * 0.75);
  var_9 = var_1 + var_4 * var_5 * 0.5 + (0, 0, var_7);
  var_0A = var_1 + var_4 * var_5 * 0.85 + (0, 0, var_7 * 0.75);
  var_0B = var_2;
  var_0C = 0;
  if(var_2[2] < var_1[2] - 50) {
    var_0C = 1;
  }

  var_0 ghost_killed_update_func((randomfloatrange(360, 900), 0, randomfloatrange(360, 900)), var_3 - 0.05);
  var_0 moveto(var_8, var_3 / 4, 0, 0);
  wait(var_3 / 4);
  var_0 moveto(var_9, var_3 / 4, 0, 0);
  wait(var_3 / 4);
  var_0 moveto(var_0A, var_3 / 4, 0, 0);
  wait(var_3 / 4);
  var_0 moveto(var_0B, var_3 / 4, 0, 0);
  wait(var_3 / 4);
  var_0D = 0.2;
  var_0E = randomfloat(5);
  var_0 ghost_killed_update_func((randomfloatrange(-40, 40), 0, randomfloatrange(-40, 40)), var_0D - 0.05);
  var_0 moveto(var_0B + var_4 * var_0E / 2 + (0, 0, var_0E), var_0D / 2, 0, var_0D / 2);
  wait(var_0D / 2);
  var_0 moveto(var_0B + var_4 * var_0E, var_0D / 2, var_0D / 2, 0);
  wait(var_0D / 2);
  func_DFFF(var_0);
}

func_79E7(var_0) {
  return level.var_7649[var_0];
}

func_C0A9(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread func_C0AA(var_1, var_0, var_2, var_3, var_4, var_5);
}

func_C0AA(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", var_1);
  if(isDefined(var_5)) {
    [[var_0]](var_2, var_3, var_4, var_5);
    return;
  }

  if(isDefined(var_4)) {
    [[var_0]](var_2, var_3, var_4);
    return;
  }

  if(isDefined(var_3)) {
    [[var_0]](var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    [[var_0]](var_2);
    return;
  }

  [[var_0]]();
}

func_512A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread func_512B(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

func_512B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_delay_thread");
  scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", var_1);
  if(isDefined(var_7)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
    return;
  }

  if(isDefined(var_6)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6);
    return;
  }

  if(isDefined(var_5)) {
    thread[[var_0]](var_2, var_3, var_4, var_5);
    return;
  }

  if(isDefined(var_4)) {
    thread[[var_0]](var_2, var_3, var_4);
    return;
  }

  if(isDefined(var_3)) {
    thread[[var_0]](var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    thread[[var_0]](var_2);
    return;
  }

  thread[[var_0]]();
}

func_CE2D(var_0, var_1, var_2) {
  if(!isDefined(self)) {
    return;
  }

  var_3 = spawn("script_origin", (0, 0, 1));
  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  var_3.origin = var_1;
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_3.angles = var_2;
  var_3 playSound(var_0, "sounddone");
  var_3 scripts\engine\utility::waittill_any_3("sounddone", "emp_force_delete");
  var_3 delete();
}