/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3621.gsc
**************************************/

_id_7977() {
  var_0 = level._id_612D._id_A925;
  var_1 = 0;
  var_2 = undefined;

  if(isDefined(var_0) && isPlayer(var_0)) {
    var_1 = 1;
  }

  if(isPlayer(self)) {
    var_2 = scripts\engine\utility::ter_op(var_1, level.player._id_612D._id_4A6E, 0.2);
  } else {
    switch (tolower(self.unittype)) {
      case "soldier":
        var_2 = scripts\engine\utility::ter_op(var_1, level.player._id_612D._id_4A6D, 0.35);
        break;
      default:
        var_2 = scripts\engine\utility::ter_op(var_1, level.player._id_612D._id_4A6C, 0.6);
        break;
    }
  }

  if(self.team == "allies") {
    return level.player._id_612D.radius * 0.25;
  } else {
    return level.player._id_612D.radius * var_2;
  }
}

_id_95C4() {
  precacheitem("emp");
  precachemodel("anti_grav_border_wm");
  setdvarifuninitialized("debug_emp", 0);
  level.player._id_9DD2 = 0;
  level._id_612D = spawnStruct();
  level._id_612D._id_B422 = 10;
  level._id_612D._id_B73C = 6;
  level.player._id_612D = spawnStruct();
  level.player._id_612D.radius = 350;
  level.player._id_612D._id_4A6D = 0.35;
  level.player._id_612D._id_4A6C = 0.6;
  level.player._id_612D._id_4A6E = 0.2;
  level.player._id_612D._id_12F6D = 0;
  level._id_612D._id_B44E = 3;
  level._id_612D._id_B74B = 1.5;
  level._id_612D._id_D02E = level.player._id_612D.radius;
  level._id_612D._id_4BCA = [];
  level._id_612D._id_4BCD = [];
  level._id_612D._id_AC75 = 4;
  level._id_612D._id_9927 = 0;
  level._id_612D._id_522C = [];
  level._id_612D._id_A8C6 = undefined;
  scripts\engine\utility::flag_init("emp_force_delete");
  scripts\engine\utility::flag_init("emp_dof_enabled");
  level._id_7649["c12_impact"] = loadfx("vfx/core/equipment/emp_grenade/vfx_iw7_equip_emp_gren_mini_exp.vfx");
  level._id_7649["player_shock"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_inplayerface.vfx");
  level._id_7649["emp_energy_strand_ptp"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_pointbeam.vfx");
  level._id_7649["c12_shock"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_c12_peeloff.vfx");
  level._id_7649["c12_death"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_c12_kill.vfx");
  level._id_7649["c8_shock"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_c6_peeloff.vfx");
  level._id_7649["c8_death"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_c12_kill.vfx");
  level._id_7649["seeker_shock"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_c6_peeloff.vfx");
  level._id_7649["seeker_death"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_c6_kill.vfx");
  level._id_7649["c6_shock"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_c6_peeloff.vfx");
  level._id_7649["c6_death"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_c6_kill.vfx");
  level._id_7649["c6i_shock"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_c6_peeloff.vfx");
  level._id_7649["c6i_death"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_c6_kill.vfx");
  level._id_7649["soldier_shock"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_human.vfx");
  level._id_7649["soldier_death"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_human_kill.vfx");
  level._id_7649["vfx_equip_emp_a2_thegreatzapper"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_a2_thegreatzapper.vfx");
  level._id_7649["vfx_equip_emp_a2_satellite"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_a2_satellite.vfx");
  level._id_7649["vfx_equip_emp_a2_hitbyzapper"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_a2_hitbyzapper.vfx");
  level._id_7649["vfx_equip_emp_a2_groundcov"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_a2_groundcov.vfx");
  level._id_7649["vfx_equip_emp_a2_dud"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_a2_dud.vfx");
  level._id_7649["vfx_equip_emp_a2_centerblast"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_a2_centerblast.vfx");
  level._id_7649["vfx_equip_emp_a2_centerblast_cheap"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_a2_centerblast_cheap.vfx");
}

_id_618D() {
  self endon("primary_equipment_change");

  for(;;) {
    self waittill("grenade_pullback");
    self setscriptablepartstate("emp", "emp_light_on");
    self waittill("offhand_end");
    self setscriptablepartstate("emp", "emp_light_off");
  }
}

_id_6133(var_0) {
  level._id_612D._id_4BF1 = var_0.origin;
  level._id_612D._id_A925 = level.player;
  var_1 = scripts\engine\utility::spawn_tag_origin(level._id_612D._id_4BF1, (0, 0, 0));
  var_1._id_132AA = [];
  var_1.soundevents = [];
  level._id_612D._id_522C[level._id_612D._id_522C.size] = var_1;
  var_1._id_378E = _id_36EB(level._id_612D._id_4BF1);
  var_1 _id_106C3();
  var_1 thread _id_6172();
  var_1 thread _id_613B();
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 0);
  var_1 thread _id_6142();
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 4);
  var_1 thread _id_DFFE();
}

_id_615B(var_0) {
  level.player thread scripts\anim\battlechatter_ai::_id_67CF("emp");
  var_1 = spawnStruct();
  var_1._id_132AA = [];
  var_1.soundevents = [];
  var_1.grenade = var_0;
  var_1.origin = var_0.origin;
  var_1.owner = self;
  level._id_612D._id_522C[level._id_612D._id_522C.size] = var_1;
  var_2 = var_0 scripts\engine\utility::waittill_any_return("explode", "missile_stuck", "death", "entitydeleted");

  if(!isDefined(var_0)) {
    var_1 thread _id_DFFE();
    return;
  }

  if(!isDefined(var_0.origin)) {
    return;
  }
  var_1.origin = var_1.grenade.origin;
  level._id_612D._id_4BF1 = var_1.grenade.origin;
  level._id_612D._id_A925 = self;
  var_1 _id_512A(0.5, ::_id_E000);
  var_3 = level._id_612D._id_522C.size < 2;

  if(var_3) {
    var_1._id_378E = _id_36EB(level._id_612D._id_4BF1);
  }

  var_1.origin = level._id_612D._id_4BF1;
  var_1.angles = (0, 0, 0);

  if(var_3) {
    var_1 _id_106C3();
  }

  var_1 thread _id_6172();
  var_1 thread _id_613B();
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 0);
  var_1 thread _id_6142();
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 4);
  var_1 thread _id_DFFE();
}

_id_DFFE() {
  if(!isDefined(self)) {
    return;
  }
  _id_E000();

  if(scripts\engine\utility::flag("emp_force_delete")) {
    scripts\engine\utility::waitframe();
  }

  if(isDefined(self.soundevents)) {
    self.soundevents = scripts\engine\utility::array_removeundefined(self.soundevents);

    foreach(var_1 in self.soundevents) {
      if(isDefined(var_1._id_B04F)) {
        var_1 stoploopsound(var_1._id_B04F);
      }

      var_1 notify("sounddone");
      var_1 delete();
    }
  }

  if(isDefined(self._id_132AA)) {
    self._id_132AA = scripts\engine\utility::array_removeundefined(self._id_132AA);

    foreach(var_4 in self._id_132AA) {
      var_4 delete();
    }
  }

  if(isDefined(self._id_378D)) {
    self._id_378D = scripts\engine\utility::array_removeundefined(self._id_378D);
    var_6 = self._id_378D;

    foreach(var_8 in var_6) {
      _id_DFFF(var_8);
    }
  }

  if(isDefined(self._id_E1A8)) {
    destroynavrepulsor(self._id_E1A8);
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  level._id_612D._id_522C = scripts\engine\utility::array_remove(level._id_612D._id_522C, self);
}

_id_E000() {
  if(isDefined(self)) {
    if(isDefined(self.grenade)) {
      self.origin = self.grenade.origin;
      level._id_612D._id_A8C6 = self.grenade.origin;
      self.grenade delete();
    }
  }
}

_id_DFFF(var_0) {
  if(isDefined(var_0._id_132AA)) {
    foreach(var_2 in var_0._id_132AA) {
      var_2 delete();
    }
  }

  killfxontag(level._effect["antigrav_caltrop_trail"], var_0, "tag_origin");
  self._id_378D = scripts\engine\utility::array_remove(self._id_378D, var_0);
  var_0 delete();
}

_id_DFBE() {
  level notify("removing_all_emps_instantly");
  level endon("removing_all_emps_instantly");
  scripts\engine\utility::flag_set("emp_force_delete");

  foreach(var_1 in level._id_612D._id_522C) {
    var_1 thread _id_E000();
  }

  for(;;) {
    if(level._id_612D._id_522C.size > 0) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_clear("emp_force_delete");
  level.player._id_9DD2 = 0;
  level._id_612D._id_4BCA = [];
  level._id_612D._id_4BCD = [];
  _id_D291(0.05, 1);
  level.player notify("stop soundemp_nade_plr_lp");
}

_id_613B() {
  var_0 = scripts\engine\utility::ter_op(level._id_612D._id_522C.size < 2, "vfx_equip_emp_a2_centerblast", "vfx_equip_emp_a2_centerblast_cheap");

  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    var_1 = spawnfx(level._id_7649[var_0], level._id_612D._id_4BF1);
    triggerfx(var_1);
    self._id_132AA[self._id_132AA.size] = var_1;
  } else
    playFX(level._id_7649[var_0], level._id_612D._id_4BF1);
}

_id_6142() {
  self.targets = [];
  level._id_612D._id_9927++;
  earthquake(0.7, 0.5, level._id_612D._id_4BF1, 450);
  thread _id_6132();
  thread _id_106C1(level._id_612D._id_4BF1);

  if(isDefined(level._id_CAF7)) {
    var_0 = 0.3;
    var_1 = sortbydistance(level._id_CAF7, self.origin);

    foreach(var_3 in var_1) {
      if(var_3 == self) {
        continue;
      }
      var_4 = distance(self.origin, var_3.origin);

      if(var_4 > level.player._id_612D.radius) {
        continue;
      }
      var_5 = level.player._id_612D.radius - var_4;
      var_6 = var_5 / level.player._id_612D.radius;
      var_7 = var_0 * var_6;

      if(var_4 <= level.player._id_612D.radius) {
        var_3 thread _id_0E1F::_id_6136(self.origin, var_4, var_7);
      }
    }
  }
}

_id_6132() {
  self._id_E1A8 = "emp" + level._id_612D._id_9927;
  createnavrepulsor(self._id_E1A8, -1, level._id_612D._id_4BF1, level.player._id_612D.radius * 2, 1);
}

_id_106C1(var_0) {
  self.trigger = spawn("trigger_radius", var_0, 7, level.player._id_612D.radius, 40);

  if(isDefined(self.owner) && level.player == self.owner) {
    var_1 = self.owner _id_0B1D::_id_734E();
    self.owner scripts\engine\utility::delaythread(1.25, _id_0B1D::_id_734D, var_0, var_1, level.player._id_612D.radius);
  }

  for(;;) {
    self.trigger waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      if(_id_0B1D::_id_385D(level._id_612D._id_4BF1 + (0, 0, 40))) {
        var_2 thread _id_5781(self);
      } else if(getdvarint("debug_emp")) {
        iprintln("^1 EMP can't trace to player");
      }

      continue;
    }

    if(_id_0B1D::_id_385C(level._id_612D._id_4BF1 + (0, 0, 40), var_2)) {
      var_2 _id_5781(self);
    }
  }
}

_id_5781(var_0) {
  if(isDefined(self.unittype) && self.unittype == "civilian") {
    return;
  }
  if(isDefined(self._id_9DD2) && self._id_9DD2) {
    return;
  }
  if(isDefined(self.team) && self.team == "allies") {
    var_1 = 0;

    if(isDefined(self._id_A979)) {
      if(gettime() - self._id_A979 < 15000) {
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

  self._id_A979 = gettime();

  if(isPlayer(self)) {
    thread _id_D044(var_0);
    return;
  }

  self._id_9DD2 = 1;

  if(!isDefined(self._id_61A8)) {
    self._id_61A8 = 1;
  } else {
    self._id_61A8++;
  }

  if(isDefined(self.a._id_58DA)) {
    var_2 = self.health;
  }

  if(_id_9B56()) {
    thread _id_6140(var_0);
    return;
  }

  _id_F388();
  var_2 = _id_36EA();

  if(isalive(level._id_612D._id_A925)) {
    var_3 = level._id_612D._id_A925;
  } else {
    var_3 = undefined;
  }

  level._id_612D._id_4BCA[level._id_612D._id_4BCA.size] = self;

  if(isDefined(self.team) && self.team == "allies") {
    thread _id_89A6(var_0);
  }

  self dodamage(var_2, self.origin, var_3, var_3, "MOD_GRENADE_SPLASH", "emp");
  thread _id_613C(self.empstartcallback, var_0);
  thread _id_193F(self.empstartcallback, var_0);

  if(!isalive(self)) {
    return;
  }
  if(scripts\asm\asm_bb::bb_isanimScripted() || self _meth_81A6() || isDefined(self.script) && self.script == "pain" || scripts\sp\utility::isactorwallrunning()) {
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
      thread _id_3453(level._id_612D._id_4BF1);
      break;
    case "c12":
      thread _id_354C(level._id_612D._id_4BF1);
      break;
    default:
      break;
  }
}

_id_36E9(var_0, var_1) {
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
  var_5 = scripts\sp\math::_id_C097(0, var_1, var_4);
  var_6 = scripts\sp\math::_id_6A8E(var_3, var_2, var_5) * 0.5;
  return var_6;
}

_id_5772(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_0.owner.team) || !isDefined(self.team)) {
    return;
  }
  if(var_0.owner.team == self.team) {
    return;
  }
  if(isDefined(self._id_9DD2) && self._id_9DD2) {
    return;
  }
  self._id_9DD2 = 1;
  self.empstartcallback = randomfloatrange(0.9, 1.6);
  var_2 = _id_36E9(var_0.origin, var_1);

  if(isDefined(self.a._id_58DA)) {
    var_2 = self.health;
  }

  self dodamage(var_2, self.origin, var_0, var_0.owner, "MOD_GRENADE_SPLASH", "emp");
  thread _id_3D25(self.empstartcallback);
  thread _id_3D26(var_0, ["j_spineupper", "j_spinelower", "j_knee_le", "j_ankle_ri", "j_elbow_le", "j_wrist_ri", "j_neck", "j_head"]);

  switch (tolower(self.unittype)) {
    case "c8":
      break;
    case "c12":
      break;
  }

  wait(self.empstartcallback);
  self._id_9DD2 = undefined;
}

_id_3D25(var_0) {
  playworldsound("emp_shock_short", self.origin);
  playworldsound("generic_death_falling_scream", self.origin);
  thread _id_B06D(level._id_7649["soldier_shock"], "j_spine4", var_0);
  var_1 = "emp_electrocute_lp";
  thread scripts\engine\utility::play_loop_sound_on_entity(var_1);
  var_2 = self.origin;
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_178D(scripts\sp\utility::timeout, var_0);
  scripts\sp\utility::_id_57D6();
  self notify("stop sound" + var_1);
  playworldsound("emp_nade_lp_end", var_2);
  self notify("stop_looped_vfx");

  if(isalive(self)) {
    scripts\anim\face::saygenericdialogue("pain");
  }
}

_id_3D26(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  var_2 = var_0.origin;

  for(var_3 = 0; var_3 < 2; var_3++) {
    var_4 = scripts\engine\utility::random(var_1);
    var_5 = self gettagorigin(var_4);
    var_6 = vectorNormalize(var_5 - var_2);
    var_7 = vectortoangles(var_6);
    playfxbetweenpoints(level._id_7649["emp_energy_strand_ptp"], var_2, var_7, var_5, level.player);
  }
}

_id_89A6(var_0) {
  self endon("death");

  if(isDefined(self.health) && self.health < 0 || isDefined(self.forceempfriendlyfail)) {
    return;
  }
  self._id_BFED = 1;
  wait 0.1;
  self._id_BFED = undefined;
}

_id_F388() {
  var_0 = level._id_612D._id_4BF1;
  var_1 = distance2d(self.origin, var_0);
  var_2 = _id_7977();
  var_3 = scripts\engine\utility::ter_op(isDefined(self.team) && self.team == "allies", 2, 4);
  var_4 = scripts\sp\math::_id_C097(var_2, level.player._id_612D.radius, var_1);
  self.empstartcallback = scripts\sp\math::_id_6A8E(var_3, 1.5, var_4);
}

_id_36EA() {
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
    case "c8":
      var_0 = 900;
      var_1 = 1000;
      break;
    case "c12":
      var_0 = 1200;
      var_1 = 1800;
      break;
  }

  var_2 = distance2d(self.origin, level._id_612D._id_4BF1);
  var_3 = scripts\sp\math::_id_C097(0, level.player._id_612D.radius, var_2);
  var_4 = scripts\sp\math::_id_6A8E(var_1, var_0, var_3);
  return var_4;
}

_id_613C(var_0, var_1) {
  self endon("death");
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", var_0);
  level._id_612D._id_4BCA = scripts\engine\utility::array_remove(level._id_612D._id_4BCA, self);
  self._id_9DD2 = undefined;
}

_id_D044(var_0) {
  self endon("death");

  if(scripts\sp\utility::_id_65DB("player_retract_shield_active")) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, level._id_612D._id_4BF1, cos(65))) {
      return;
    }
  }

  if(isDefined(self._id_9DD2) && self._id_9DD2) {
    return;
  }
  var_1 = level._id_612D._id_4BF1;
  var_2 = distance2d(self.origin, var_1);

  if(getdvarint("debug_emp")) {}

  var_3 = _id_7977();
  scripts\sp\utility::_id_54EF(var_1);
  self._id_9DD2 = 1;
  var_3 = _id_7977();
  var_4 = scripts\sp\math::_id_C097(var_3, level.player._id_612D.radius, var_2);
  var_5 = scripts\sp\math::_id_6A8E(level._id_612D._id_B44E, level._id_612D._id_B74B, var_4);

  if(var_2 < var_3) {
    if(!scripts\engine\utility::flag_exist("in_vr_mode") || scripts\engine\utility::flag_exist("in_vr_mode") && !scripts\engine\utility::flag("in_vr_mode")) {
      playworldsound("gravity_explode_default", self.origin);
      playFX(level._id_7649["c12_impact"], self getEye());
      scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_54C6);
    }
  } else {
    self dodamage(self.health * 0.3, self.origin, level._id_612D._id_A925, level._id_612D._id_A925, "MOD_GRENADE_SPLASH", "emp");
    thread _id_613C(var_5, var_0);
  }

  level._id_612D._id_CF96 = scripts\sp\math::_id_6A8E(50, 10, var_4);
  var_6 = isDefined(self._id_764D) && self._id_764D != 1;

  if(var_6) {
    var_7 = self._id_764D;
  }

  if(getdvarint("debug_emp")) {
    iprintln("^5Player Dist: ^3" + int(var_2) + "^5 Struntime: ^3" + var_5);
  }

  _id_D293(1, var_5, level._id_612D._id_CF96, var_0);
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", var_5);
  _id_D293(0, undefined, undefined, var_0);
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 0.45);
  scripts\sp\utility::play_sound_on_entity("emp_plr_strain");
}

_id_D293(var_0, var_1, var_2, var_3) {
  if(var_0) {
    if(isDefined(var_3)) {
      if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
        var_4 = spawnfx(level._id_7649["player_shock"], (0, 0, 0));
        triggerfx(var_4);
        var_3._id_132AA[var_3._id_132AA.size] = var_4;
      }
    } else
      playFX(level._id_7649["player_shock"], (0, 0, 0));

    thread scripts\sp\utility::_id_D2CD(30, 1);

    if(scripts\engine\utility::cointoss()) {
      level._id_612D._id_D292 = "ges_shocknade_loop";
    } else {
      level._id_612D._id_D292 = "ges_shocknade_loop2";
    }

    var_5 = level._id_612D._id_D292;
    var_6 = self forceplaygestureviewmodel(var_5);

    if(var_6) {
      childthread _id_0E49::_id_D092(var_5, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1);
    }

    self _meth_80D8(0.3, 0.3);
    self _meth_8244("damage_heavy");
    _id_0B0A::_id_583F(1, 1, 0, 0, 40, var_2, 0.05);
    scripts\engine\utility::flag_set("emp_dof_enabled");

    if(isDefined(var_3)) {
      var_3 _id_512A(1, ::_id_D291, var_1 - 1);
    } else {
      level scripts\engine\utility::delaythread(1, ::_id_D291, var_1 - 1);
    }

    thread _id_D045(var_3);
    thread _id_CFA6(var_3);
    thread scripts\engine\utility::play_loop_sound_on_entity("emp_nade_plr_lp");
    scripts\sp\utility::_id_1C49(0);
  } else {
    thread scripts\sp\utility::_id_D2CD(100, 2);
    self stopgestureviewmodel(level._id_612D._id_D292);
    self notify("stop soundemp_nade_plr_lp");

    if(isDefined(var_3)) {
      var_3 thread _id_CE2D("emp_nade_plr_lp_end", self.origin);
    } else {
      playworldsound("emp_nade_plr_lp_end", self.origin);
    }

    self _meth_80A6();
    self stoprumble("damage_heavy");
    self notify("done_shocked");
    scripts\sp\utility::_id_1C49(1);
  }
}

_id_D291(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    _id_0B0A::_id_583D(var_0);
    scripts\engine\utility::flag_clear("emp_dof_enabled");
  } else if(scripts\engine\utility::flag("emp_dof_enabled")) {
    _id_0B0A::_id_583D(var_0);
    scripts\engine\utility::flag_clear("emp_dof_enabled");
  }
}

_id_D045(var_0) {
  self endon("done_shocked");

  for(;;) {
    thread _id_10209(level.player.origin + (0, 0, randomintrange(20, 45)), level._id_612D._id_4BF1);
    scripts\sp\utility::play_sound_on_entity("emp_plr_strain");
    wait(randomfloatrange(0.4, 0.8));
  }
}

_id_CFA6(var_0) {
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
    var_10 = 0;
    var_11 = 1;
    level.player _meth_8291(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    wait(var_4);
  }
}

_id_3453(var_0) {
  self endon("death");
  var_1 = level._id_612D._id_4BF1;
  var_2 = distance2d(self.origin, var_0);
  var_3 = _id_7977();
  var_4 = isDefined(self.dontevershoot);
  scripts\asm\asm::asm_setstate("pain_shock");

  if(!var_4) {
    childthread _id_FEC5(self.empstartcallback);
  }

  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", self.empstartcallback);

  if(!var_4) {
    self.dontevershoot = undefined;
  }
}

_id_354C(var_0) {
  self endon("death");
  var_1 = level._id_612D._id_4BF1;
  var_2 = distance2d(self.origin, var_0);
  var_3 = _id_7977();
  self._id_9DD2 = 1;
  scripts\engine\utility::delaythread(1.2, scripts\engine\utility::play_sound_in_space, "c12_selfdestruct_beep", self.origin);

  if(vectordot(anglestoright(self.angles), var_0 - self.origin) > 0) {
    var_4 = "right";
  } else {
    var_4 = "left";
  }

  scripts\asm\asm::asm_setstate("pain_emp_" + var_4);
  var_5 = isDefined(self.dontevershoot);

  if(!var_5) {
    childthread _id_FEC5(self.empstartcallback);
  }

  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", self.empstartcallback);
  playworldsound("c12_selfdestruct_beep", self.origin);

  if(!var_5) {
    self.dontevershoot = undefined;
  }
}

_id_FEC5(var_0) {
  self endon("stop_messing_with_shooting");
  thread scripts\sp\utility::_id_C12D("stop_messing_with_shooting", var_0);
  self.dontevershoot = 1;
  wait 2;

  for(;;) {
    self.dontevershoot = undefined;
    wait 2;
    self.dontevershoot = 1;
    wait(randomfloatrange(1.6, 2.2));
  }
}

_id_335F(var_0) {
  self endon("death");
  self endon("done_shocked");

  for(var_1 = 0; var_1 < 5; var_1++) {
    wait(randomfloatrange(1, 1.5));
    _id_529D();
  }
}

_id_529D(var_0, var_1) {
  if(!isDefined(self._id_9DD2)) {
    return;
  }
  if(!isDefined(self._id_4D5D)) {
    return;
  }
  var_2 = [];

  if(!isDefined(self._id_217E)) {
    self._id_217E = "none";
  }

  foreach(var_9, var_4 in self._id_4D5D) {
    if(var_9 != "head" && self _meth_850C(var_9) > 0) {
      var_2[var_9] = [];
    } else {
      continue;
    }

    foreach(var_8, var_6 in self._id_4D5D[var_9].partnerheli) {
      var_7 = self _meth_850C(var_9, var_8);

      if(var_7 > 0) {
        var_2[var_9][var_8] = spawnStruct();
        var_2[var_9][var_8].health = var_7;
        var_2[var_9][var_8].maxhealth = self._id_4D5D[var_9].partnerheli[var_8].maxhealth;
        var_2[var_9][var_8]._id_4D6F = self._id_4D5D[var_9].partnerheli[var_8]._id_4D6F;
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
  thread _id_10209(self gettagorigin(var_2[var_9][var_8]._id_4D6F), level._id_612D._id_4BF1);
  var_10 = var_2[var_9][var_8].maxhealth;
  self _meth_850B(var_10, var_9, var_8);
  self._id_217E = var_2[var_9][var_8]._id_4D6F;
}

_id_10209(var_0, var_1) {
  if(level._id_612D._id_522C.size > 1) {
    return;
  }
  if(!isDefined(self._id_9DD2)) {
    return;
  }
  var_1 = var_1 + (0, 0, 25);
  var_2 = vectorNormalize(var_1 - var_0);
  var_3 = vectortoangles(var_2);

  if(getdvarint("debug_emp")) {}

  if(randomint(100) < 25) {
    playworldsound("emp_shock_short", self.origin);
  }

  playfxbetweenpoints(level._id_7649["emp_energy_strand_ptp"], var_0, var_3, var_1, level.player);
}

_id_6172() {
  playworldsound("emp_grenade_explode_default", level._id_612D._id_4BF1);
  var_0 = scripts\engine\utility::play_loopsound_in_space("emp_nade_lp", level._id_612D._id_4BF1);
  var_0 endon("death");
  var_0._id_B04F = "emp_nade_lp";
  self.soundevents[self.soundevents.size] = var_0;
  level scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", 4);
  playworldsound("emp_nade_lp_end", level._id_612D._id_4BF1);
  var_0 stoploopsound(var_0._id_B04F);
  self.soundevents = scripts\engine\utility::array_remove(self.soundevents, var_0);
  var_0 delete();
}

_id_9B56() {
  if(self.unittype == tolower("c8")) {
    var_0 = scripts\engine\utility::ter_op(level.player._id_612D._id_12F6D == 2, 2, 4);

    if(self._id_61A8 < var_0) {
      return 0;
    }
  } else if(self.unittype == tolower("c12"))
    return 0;

  var_1 = level._id_612D._id_4BF1;

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = distance2d(self.origin, var_1);
  var_3 = _id_7977();

  if(var_2 < var_3) {
    return 1;
  }

  return 0;
}

_id_6140(var_0) {
  self._id_FE4A = 1;
  self endon("death");

  if(self.unittype == "soldier ") {
    var_0 thread _id_CE2D("generic_death_falling_scream", self.origin);
  }

  var_0 thread _id_CE2D("gravity_explode_default", self.origin);
  playFXOnTag(level._id_7649[self.unittype + "_death"], self, "j_spine4");
  thread _id_10209(self getEye(), level._id_612D._id_4BF1);

  if(self.unittype == "c6") {
    var_1 = int(self.health * 0.3);

    if(isalive(level._id_612D._id_A925)) {
      var_2 = level._id_612D._id_A925;
    } else {
      var_2 = undefined;
    }

    self dodamage(var_1, self.origin, var_2, var_2, "MOD_GRENADE_SPLASH", "emp");
    _id_6152(var_0);
  }

  self dodamage(self.health * 10, self.origin, level._id_612D._id_A925, undefined, "MOD_GRENADE_SPLASH", "emp");
}

_id_6152(var_0) {
  self endon("death");

  if(!isDefined(self._id_4D5D)) {
    return;
  }
  var_1 = scripts\engine\utility::array_randomize(self._id_4D5D);

  foreach(var_8, var_3 in var_1) {
    if(var_8 == "head") {
      var_4 = self _meth_850C(var_8);
      self _meth_850B(var_4, var_8);
      continue;
    }

    foreach(var_7, var_6 in var_1[var_8].partnerheli) {
      var_4 = self _meth_850C(var_8, var_7);
      self _meth_850B(var_4, var_8, var_7);
      wait 0.1;
    }
  }
}

_id_193F(var_0, var_1) {
  switch (tolower(self.unittype)) {
    case "soldier":
      thread _id_6156(var_0, var_1);
      break;
    case "c6":
      thread _id_335F(var_1);
      break;
    case "c8":
      thread _id_6154(var_0);
      break;
    case "c12":
      thread _id_6155(var_0);
      break;
    default:
      break;
  }
}

_id_6154(var_0) {
  self endon("death");
  self endon("emp_finished");
  var_1 = "emp_electrocute_lp";
  thread scripts\engine\utility::play_loop_sound_on_entity(var_1);
  var_2 = "stop sound" + var_1;
  thread scripts\sp\utility::_id_C12D(var_2, var_0);
  thread scripts\sp\utility::_id_C12D("emp_finished", var_0);
  scripts\engine\utility::delaythread(var_0, scripts\sp\utility::play_sound_on_entity, "emp_nade_lp_end");
  var_3 = scripts\sp\utility::_id_7CCC(self.model);
  playFXOnTag(level._id_7649["c8_death"], self, "tag_torso");
  wait 0.15;

  for(;;) {
    var_3 = scripts\engine\utility::array_randomize(var_3);

    foreach(var_5 in var_3) {
      _id_10209(self gettagorigin(var_5), level._id_612D._id_4BF1);
      playFXOnTag(level._id_7649["c8_shock"], self, var_5);
      wait(randomfloatrange(0.15, 0.35));
    }

    wait 0.05;
  }
}

_id_6155(var_0) {
  self endon("death");
  self endon("emp_finished");
  var_1 = "emp_electrocute_lp";
  thread scripts\engine\utility::play_loop_sound_on_entity(var_1);
  var_2 = "stop sound" + var_1;
  thread scripts\sp\utility::_id_C12D(var_2, var_0);
  thread scripts\sp\utility::_id_C12D("emp_finished", var_0);
  scripts\engine\utility::delaythread(var_0, scripts\sp\utility::play_sound_on_entity, "emp_nade_lp_end");
  var_3 = scripts\sp\utility::_id_7CCC(self.model);
  var_3 = scripts\engine\utility::array_randomize(var_3);
  playFXOnTag(level._id_7649["c12_death"], self, "tag_torso");
  wait 0.15;

  for(;;) {
    foreach(var_5 in var_3) {
      thread _id_10209(self gettagorigin(var_5), level._id_612D._id_4BF1);
      playFXOnTag(level._id_7649["c12_shock"], self, var_5);
      var_6 = self gettagorigin(var_5);
      wait(randomfloatrange(0.5, 1.7));
    }

    wait 0.05;
  }
}

_id_6156(var_0, var_1) {
  thread _id_6157(var_1);
  thread _id_B06D(level._id_7649["soldier_shock"], "j_spine4", var_0, var_1);
  var_2 = "emp_electrocute_lp";
  thread scripts\engine\utility::play_loop_sound_on_entity(var_2);
  var_3 = self.origin;
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_178D(scripts\sp\utility::timeout, var_0);
  scripts\sp\utility::_id_57D6();
  self notify("stop sound" + var_2);
  playworldsound("emp_nade_lp_end", var_3);
  self notify("stop_looped_vfx");

  if(isalive(self)) {
    scripts\anim\face::saygenericdialogue("pain");
  }
}

_id_6157(var_0) {
  self endon("death");
  self endon("stop_looped_vfx");
  var_0 thread _id_CE2D("generic_death_falling_scream", self.origin);
  var_1 = scripts\sp\utility::_id_7CCC(self.model);
  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_2 = 0;

  for(var_3 = 0; var_3 < 5; var_3++) {
    var_4 = randomfloatrange(1.8, 2.3);
    thread _id_10209(self gettagorigin(var_1[var_3]), level._id_612D._id_4BF1);
    wait(var_4);
    playFXOnTag(level._id_7649["soldier_shock"], self, var_1[var_3]);

    if(var_3 == randomintrange(5, 9) && !var_2) {
      var_2 = 1;
      var_0 thread _id_CE2D("generic_death_falling_scream", self.origin);
    }
  }
}

_id_B06D(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("stop_looped_vfx");

  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    for(;;) {
      var_4 = spawnfx(var_0, self gettagorigin(var_1));
      var_3._id_132AA[var_3._id_132AA.size] = var_4;
      triggerfx(var_4);
      wait(var_2);
      var_3._id_132AA = scripts\engine\utility::array_remove(var_3._id_132AA, var_4);
      var_4 delete();
    }
  } else {
    for(;;) {
      playFX(var_0, self gettagorigin(var_1));
      wait(var_2);
    }
  }
}

_id_36EB(var_0) {
  var_1 = var_0;
  var_2 = [];

  for(var_3 = 0; var_3 < 12; var_3++) {
    var_4 = 30.0 * var_3;
    var_5 = level.player._id_612D.radius;
    var_6 = _id_6198(var_1, var_4, var_5);

    if(isDefined(var_6)) {
      var_7 = spawnStruct();
      var_7.origin = var_6;
      var_7._id_5F15 = 0;

      if(var_6[2] + 256 < var_1[2]) {
        var_7._id_5F15 = 1;
      }

      var_2[var_2.size] = var_7;
    }
  }

  return var_2;
}

_id_106C3(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = self.origin;
  var_2 = [];
  self._id_378D = [];

  for(var_3 = 0; var_3 < self._id_378E.size; var_3++) {
    var_4 = 0;
    var_5 = 0;

    if(var_3 > 0) {
      var_5 = var_3 - 1;
    } else {
      var_5 = self._id_378E.size - 1;
    }

    if(var_3 < self._id_378E.size - 1) {
      var_4 = var_3 + 1;
    } else {
      var_4 = 0;
    }

    var_6 = self._id_378E[var_4].origin;
    var_7 = self._id_378E[var_5].origin;
    var_8 = scripts\engine\utility::flatten_vector(vectorNormalize(var_7 - var_6));
    var_9 = rotatevector(var_8, (0, -90, 0));

    if(var_0) {
      self._id_378E[var_3]._id_5F15 = 1;
    }

    self._id_378D[self._id_378D.size] = _id_106C2(var_1, self._id_378E[var_3].origin, var_9, self._id_378E[var_3]._id_5F15);
  }

  if(!var_0) {
    var_10 = level.player._id_612D.radius / 4;
    var_11 = 0;

    for(var_3 = 0; var_3 < self._id_378E.size; var_3++) {
      if(self._id_378E[var_3]._id_5F15) {
        continue;
      }
      var_12 = distance(self._id_378E[var_3].origin, var_1);
      var_13 = vectorNormalize(self._id_378E[var_3].origin - var_1);

      if(self._id_378E[var_3].origin[2] < var_1[2]) {
        var_13 = scripts\engine\utility::flatten_vector(var_13);
      }

      var_14 = anglestoright(vectortoangles(var_13));
      var_15 = var_10;
      var_16 = [];

      for(var_17 = 0; var_15 < var_12; var_15 = var_15 + var_10) {
        if(var_17 == 0 && !var_11) {
          var_18 = 0;
          var_16[var_16.size] = ::scripts\engine\utility::drop_to_ground(var_1 + rotatevector(var_13, (0, var_18, 0)) * var_15, 12, -1000);
        } else if(var_17 == 1) {
          var_18 = 0;
          var_16[var_16.size] = ::scripts\engine\utility::drop_to_ground(var_1 + rotatevector(var_13, (0, var_18, 0)) * var_15, 12, -1000);
        } else if(var_17 == 2) {
          var_18 = 7.5;
          var_16[var_16.size] = ::scripts\engine\utility::drop_to_ground(var_1 + rotatevector(var_13, (0, var_18, 0)) * var_15, 12, -1000);
          var_16[var_16.size] = ::scripts\engine\utility::drop_to_ground(var_1 + rotatevector(var_13, (0, 0 - var_18, 0)) * var_15, 12, -1000);
        }

        var_17++;
      }

      foreach(var_20 in var_16) {
        var_21 = [0.0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4];
        var_22 = randomint(8);
        var_23 = -0.2 + var_21[var_22];
        var_24 = rotatevector((1, 0, 0), (0, randomfloat(360), 0));

        if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
          var_25 = spawnfx(_id_79E7("vfx_equip_emp_a2_groundcov"), var_20 + (0, 0, 6), var_24, (0, 0, 1));
          _id_C0A9(var_23, ::triggerfx, var_25);
          self._id_132AA[self._id_132AA.size] = var_25;
          continue;
        }

        _id_C0A9(var_23, ::playfx, _id_79E7("vfx_equip_emp_a2_groundcov"), var_20 + (0, 0, 6), var_24, (0, 0, 1));
      }

      var_11 = !var_11;
    }
  }

  return self._id_378E;
}

_id_6196(var_0, var_1, var_2) {
  var_3 = anglesToForward((0, var_1, 0));
  var_4 = scripts\common\trace::ray_trace_passed(var_0 + (0, 0, 48), var_0 + (0, 0, 48) + var_3 * var_2, undefined, scripts\common\trace::create_world_contents());
  return var_4;
}

_id_6198(var_0, var_1, var_2) {
  var_3 = anglesToForward((0, var_1, 0));
  var_4 = scripts\common\trace::ray_trace(var_0 + (0, 0, 48), var_0 + (0, 0, 48) + var_3 * var_2, undefined, scripts\common\trace::create_world_contents());

  if(var_4["fraction"] > 0.5) {
    var_5 = var_2 * var_4["fraction"] - 12.0;
    var_6 = var_0 + var_3 * var_5;
    var_7 = scripts\engine\utility::drop_to_ground(var_6, 50, -1000);
    return var_7;
  }

  return undefined;
}

#using_animtree("script_model");

_id_106C2(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = var_1;
  var_6 = var_0 + (0, 0, 2);
  var_7 = spawn("script_model", var_6);
  var_7.angles = (0, 0, 0);
  var_7._id_132AA = [];
  var_7 setModel("anti_grav_border_wm");
  var_7 _meth_83D0(#animtree);
  var_8 = randomfloatrange(0.3, 0.65);
  thread _id_6195(var_7, var_6, var_5, var_8);

  if(var_2 == (0, 0, 0)) {
    var_2 = (1, 0, 0);
  }

  if(!var_3) {
    if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
      var_9 = spawnfx(_id_79E7("vfx_equip_emp_a2_satellite"), var_1, var_2, (0, 0, 1));
      _id_C0A9(var_8, ::triggerfx, var_9);
      var_7._id_132AA[var_7._id_132AA.size] = var_9;
    } else
      _id_C0A9(var_8, ::playfx, _id_79E7("vfx_equip_emp_a2_satellite"), var_1, var_2, (0, 0, 1));
  } else
    _id_512A(var_8, ::_id_6197, var_7, var_1, var_2);

  return var_7;
}

_id_6197(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    var_3 = spawnfx(_id_79E7("vfx_equip_emp_a2_dud"), var_1, var_2, (0, 0, 1));
    triggerfx(var_3);
    var_0._id_132AA[var_0._id_132AA.size] = var_3;
  } else
    playFX(_id_79E7("vfx_equip_emp_a2_dud"), var_1, var_2, (0, 0, 1));
}

_id_6195(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_4 = vectorNormalize(var_2 - var_1);
  var_5 = distance(var_2, var_1);
  var_6 = var_1 + var_4 * var_5;
  var_7 = randomfloatrange(30, 70);
  var_8 = var_1 + var_4 * var_5 * 0.15 + (0, 0, var_7 * 0.75);
  var_9 = var_1 + var_4 * var_5 * 0.5 + (0, 0, var_7);
  var_10 = var_1 + var_4 * var_5 * 0.85 + (0, 0, var_7 * 0.75);
  var_11 = var_2;
  var_12 = 0;

  if(var_2[2] < var_1[2] - 50) {
    var_12 = 1;
  }

  var_0 rotateby((randomfloatrange(360, 900), 0, randomfloatrange(360, 900)), var_3 - 0.05);
  var_0 moveTo(var_8, var_3 / 4.0, 0.0, 0.0);
  wait(var_3 / 4.0);
  var_0 moveTo(var_9, var_3 / 4.0, 0.0, 0.0);
  wait(var_3 / 4.0);
  var_0 moveTo(var_10, var_3 / 4.0, 0.0, 0.0);
  wait(var_3 / 4.0);
  var_0 moveTo(var_11, var_3 / 4.0, 0.0, 0.0);
  wait(var_3 / 4.0);
  var_13 = 0.2;
  var_14 = randomfloat(5.0);
  var_0 rotateby((randomfloatrange(-40, 40), 0, randomfloatrange(-40, 40)), var_13 - 0.05);
  var_0 moveTo(var_11 + var_4 * var_14 / 2 + (0, 0, var_14), var_13 / 2, 0.0, var_13 / 2);
  wait(var_13 / 2);
  var_0 moveTo(var_11 + var_4 * var_14, var_13 / 2, var_13 / 2, 0.0);
  wait(var_13 / 2);
  _id_DFFF(var_0);
}

_id_79E7(var_0) {
  return level._id_7649[var_0];
}

_id_C0A9(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_C0AA(var_1, var_0, var_2, var_3, var_4, var_5);
}

_id_C0AA(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", var_1);

  if(isDefined(var_5)) {
    call[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    call[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    call[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    call[[var_0]](var_2);
  } else {
    call[[var_0]]();
  }
}

_id_512A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread _id_512B(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_512B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_delay_thread");
  scripts\engine\utility::flag_wait_or_timeout("emp_force_delete", var_1);

  if(isDefined(var_7)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    thread[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    thread[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    thread[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    thread[[var_0]](var_2);
  } else {
    thread[[var_0]]();
  }
}

_id_CE2D(var_0, var_1, var_2) {
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
  var_3 scripts\engine\utility::waittill_any("sounddone", "emp_force_delete");
  var_3 delete();
}