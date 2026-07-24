/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3889.gsc
**************************************/

main() {
  setsaveddvar("spacejumpmintime", 0.5);
  setsaveddvar("spacejumpspeed", 1200);
  setsaveddvar("spacejumpGrappleAccelTime", 1.0);
  setsaveddvar("grapple_enemy_dist", 10000);
  setsaveddvar("grapple_enemy_radius", 10000);
  setsaveddvar("waypointTweakY", 0);
  setdvarifuninitialized("grapple_radial_blur", 1);
  setdvarifuninitialized("grapple_radial_strength", 0.02);
  setdvarifuninitialized("grapple_radial_radius", 0.1);
  setdvarifuninitialized("grapple_radial_distortion", 0.6);
  setdvarifuninitialized("grapple_radial_time_delay", 0.15);
  setdvarifuninitialized("grapple_radial_time_in", 0.4);
  setdvarifuninitialized("grapple_radial_time_out", 0.25);
  setdvarifuninitialized("grapple_gesture_delay", 0.25);
  setdvarifuninitialized("grapple_retract_delay_enemy", 0.6);
  setdvarifuninitialized("grapple_retract_delay_point", 0.4);
  setdvarifuninitialized("grapple_impact_delay", 0.1);
  setdvarifuninitialized("grapple_enemy_debounce", 2.0);
  setdvarifuninitialized("grapple_kill_idx", -1);
  _id_13DD();
  _id_13D9();
  _id_13DF();
  _id_13DA();
  precacheitem("grapplingdevice");
  precachemodel("frag_grenade_prop");
  precachemodel("tactical_knife_iw7_wm");
  precachestring(&"ZEROG_RETURN_TO_COMBAT");
  level._id_84B8 = [];
  level._effect["zerog_grapple_kill_knee"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_grapple_kill_knee.vfx");
  level._effect["zerog_grapple_kill_grenade_pull"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_grapple_kill_grenade_pull.vfx");
  level._effect["zerog_grapple_kill_knife_in"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_grapple_kill_knife_in.vfx");
  level._effect["zerog_grapple_kill_knife_out"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_grapple_kill_knife_out.vfx");
  level._effect["zerog_grapple_grenade_detonate"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_grapple_grenade_detonate.vfx");
}

#using_animtree("animated_props");

_id_13DD() {
  var_0 = "grapple_rope";
  level._id_EC87[var_0] = #animtree;
  level._id_EC8C[var_0] = "base_grapple_rope";
  precachemodel(level._id_EC8C[var_0]);
  level._id_EC85[var_0]["fire"] = % vm_grapple_fire_rope;
  level._id_EC85[var_0]["grapple_hip_fire"] = % vm_grapple_hip_fire_rope;
  var_0 = "grapple_rope_stretch";
  level._id_EC87[var_0] = #animtree;
  level._id_EC8C[var_0] = "base_grapple_scale_rope";
  precachemodel(level._id_EC8C[var_0]);
  level._id_EC85[var_0]["idle"] = % vm_grapple_idle_rope;
  var_0 = "grenade_pull";
  level._id_EC87[var_0] = #animtree;
  level._id_EC85[var_0]["grenade_pull"] = % wm_zg_meleekill_grenadepull_grenade;
  level._id_EC8C[var_0] = "frag_grenade_prop";
  precachemodel(level._id_EC8C[var_0]);
  var_0 = "grapple_bolt";
  level._id_EC87[var_0] = #animtree;
  level._id_EC8C[var_0] = "base_grapple_bolt";
  precachemodel(level._id_EC8C[var_0]);
}

#using_animtree("generic_human");

_id_13DE(var_0) {
  level._id_EC87[var_0] = #animtree;
  level._id_EC85[var_0]["hit_front"] = % hm_grapplegun_hit_front;
  level._id_EC85[var_0]["hit_back"] = % hm_grapplegun_hit_back;
  level._id_EC85[var_0]["hit_left"] = % hm_grapplegun_hit_left;
  level._id_EC85[var_0]["hit_right"] = % hm_grapplegun_hit_right;
  level._id_EC85[var_0]["hit_front_loop"][0] = % hm_grapplegun_hit_front_loop;
}

_id_13D9() {
  _id_13DE("grapple_kill_1");
  level._id_EC85["grapple_kill_1"]["kill_anim"] = % hm_zg_meleekill_helmetrip_victim;
  level._id_EC85["grapple_kill_1"]["kill_note"] = "start_ragdoll";
  level._id_EC85["grapple_kill_1"]["kill_rumble"] = "helmet_rip";
  _id_13DE("grapple_kill_2");
  level._id_EC85["grapple_kill_2"]["kill_anim"] = % hm_zg_meleekill_grenadepull_victim;
  level._id_EC85["grapple_kill_2"]["kill_thread"] = ::_id_1263;
  level._id_EC85["grapple_kill_2"]["kill_enemy_thread"] = ::_id_1264;
  level._id_EC85["grapple_kill_2"]["kill_note"] = "grenade_explode";
  level._id_EC85["grapple_kill_2"]["kill_rumble"] = "pull_grenade_pin";
  _id_13DE("grapple_kill_3");
  level._id_EC85["grapple_kill_3"]["kill_anim"] = % hm_zg_meleekill_kneetoface_victim;
  level._id_EC85["grapple_kill_3"]["kill_note"] = "helmet_shatter";
  level._id_EC85["grapple_kill_3"]["kill_rumble"] = "helmet_shatter";
  _id_13DE("grapple_kill_4");
  level._id_EC85["grapple_kill_4"]["kill_anim"] = % hm_zg_meleekill_knifetohead_victim;
  level._id_EC85["grapple_kill_4"]["kill_note"] = "knife_release";
  level._id_EC85["grapple_kill_4"]["kill_enemy_thread"] = ::_id_126A;
  level._id_EC85["grapple_kill_4"]["kill_rumble"] = "knife_impact";
}

#using_animtree("player");

_id_13DF() {
  level._id_EC87["grapple_kill_1_player"] = #animtree;
  level._id_EC85["grapple_kill_1_player"]["kill_arms"] = % vm_zg_meleekill_helmetrip_alignmentarms;
  level._id_EC85["grapple_kill_1_player"]["kill_gesture"] = "ges_zg_meleekill_helmetrip";
  level._id_EC87["grapple_kill_2_player"] = #animtree;
  level._id_EC85["grapple_kill_2_player"]["kill_arms"] = % vm_zg_meleekill_grenadepull_alignmentarms;
  level._id_EC85["grapple_kill_2_player"]["kill_gesture"] = "ges_zg_meleekill_grenadepull";
  level._id_EC87["grapple_kill_3_player"] = #animtree;
  level._id_EC85["grapple_kill_3_player"]["kill_arms"] = % vm_zg_meleekill_kneetoface_alignmentarms;
  level._id_EC85["grapple_kill_3_player"]["kill_gesture"] = "ges_zg_meleekill_kneetoface";
  level._id_EC87["grapple_kill_4_player"] = #animtree;
  level._id_EC85["grapple_kill_4_player"]["kill_arms"] = % vm_zg_meleekill_knifetohead_alignmentarms;
  level._id_EC85["grapple_kill_4_player"]["kill_gesture"] = "ges_zg_meleekill_knifetohead";
}

_id_F84E(var_0, var_1) {
  if(var_0 && scripts\engine\utility::is_true(var_1._id_84B1)) {
    return;
  }
  if(!var_0 && !scripts\engine\utility::is_true(var_1._id_84B1)) {
    return;
  }
  var_1._id_84B1 = var_0;

  if(var_0) {
    var_2 = _id_4A18();
    var_3 = _id_4A19();
    var_1 giveweapon("grapplingdevice");
    var_1 assignweaponoffhandsecondary("grapplingdevice");
    var_1 scripts\engine\utility::allow_offhand_secondary_weapons(0);
    var_1 _meth_84EC(1);
    var_1 _meth_8503("ges_grapple", "ges_grav_jump_combat_fail", var_2, var_3);
    var_1 thread _id_1391(var_2, var_3);
  } else {
    var_1 _meth_84EC(0);

    if(!scripts\engine\utility::is_true(level.player._id_13EE6))
      var_1 _meth_8507();

    var_1 _id_1390();
    var_1 scripts\sp\utility::_id_1145A("grapplingdevice");
    var_1 scripts\engine\utility::allow_offhand_secondary_weapons(1);
  }
}

_id_9E14() {
  return scripts\engine\utility::is_true(self._id_84B1) && self _meth_84F4() != "none";
}

_id_4A18() {
  if(isDefined(level._id_10533))
    return level._id_10533;

  level._id_10533 = spawn("script_model", (0, 0, 0));
  level._id_10533 setModel("tag_origin");
  return level._id_10533;
}

_id_4A19() {
  if(isDefined(level._id_10532))
    return level._id_10532;

  level._id_10532 = spawn("script_model", (0, 0, 0));
  level._id_10532 setModel("tag_origin");
  return level._id_10532;
}

_id_D370() {
  self _meth_8502();
}

_id_D35F(var_0) {
  self _meth_8521(var_0);
  self._id_1CA9 = var_0;
}

_id_17A0() {
  var_0 = getspawnerarray();

  if(var_0.size > 0)
    scripts\sp\utility::_id_22C7(var_0, ::_id_6570);

  var_1 = getaiarray("axis");

  if(var_1.size > 0)
    scripts\engine\utility::array_thread(var_1, ::_id_6570);
}

_id_E0C8() {
  var_0 = getspawnerarray();

  foreach(var_2 in var_0)
  var_2 scripts\sp\utility::_id_E08B(::_id_6570);

  var_4 = getaiarray("axis");

  foreach(var_6 in var_4)
  var_6 _id_6553();
}

_id_6570() {
  self notify("enemySpawnSetGrapple");
  self endon("enemySpawnSetGrapple");

  if(self.team != "axis") {
    return;
  }
  if(self._id_1FEC != "generic_human") {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  thread _id_6555();
  self waittill("death");
  _id_6553();
}

_id_6553() {
  if(isDefined(self)) {
    self _meth_850A(0);
    self notify("enemySpawnSetGrapple");
    self notify("enemyEnableGrappleThread");
  }
}

_id_6555() {
  self notify("enemyEnableGrappleThread");
  self endon("enemyEnableGrappleThread");
  self endon("death");
  var_0 = 0;

  while(isDefined(self) && isDefined(level.player) && isalive(level.player)) {
    var_0 = var_0 && level.player scripts\sp\utility::_id_65DF("zero_gravity") && level.player scripts\sp\utility::_id_65DB("zero_gravity");
    self _meth_850A(var_0);
    level.player scripts\sp\utility::_id_65E3("zero_gravity");
    var_0 = isalive(self) && !scripts\asm\asm_bb::bb_isanimScripted() && !self.ignoreme;
    wait 0.05;
  }
}

_id_7EE1(var_0) {
  if(!isDefined(var_0))
    var_0 = "objectVolume";

  var_1 = getEntArray(var_0, "targetname");
  return var_1;
}

_id_13545(var_0) {
  self _meth_8505(var_0);
  self _meth_8543(undefined);

  if(var_0 && isDefined(self.target)) {
    var_1 = scripts\engine\utility::getStruct(self.target, "targetname");

    if(!isDefined(var_1))
      var_1 = getEnt(self.target, "targetname");

    if(isDefined(var_1) && isDefined(var_1.angles))
      self _meth_8543(anglesToForward(var_1.angles));
  }

  if(var_0)
    _id_1451();
  else
    _id_1453();
}

_id_13544(var_0) {
  _id_13545(var_0);
}

_id_7EE0() {
  var_0 = getEntArray("objectRoundVolume", "targetname");
  return var_0;
}

_id_1353F(var_0) {
  self _meth_8506(var_0);

  if(var_0)
    _id_1451();
  else
    _id_1453();
}

_id_7EDE() {
  var_0 = getEntArray("objectBrush", "targetname");
  return var_0;
}

_id_310C(var_0) {
  var_1 = getEntArray(self.target, "targetname");

  if(!isDefined(self.volume)) {
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(var_4.classname == "info_volume" || var_4.classname == "info_volume_grapple") {
        self.volume = var_4;
        var_4 enablelinkTo();
        var_2 = 1;
      }

      var_4 linkTo(self);
    }
  }

  self.volume _id_13545(var_0);
}

_id_7EDF() {
  var_0 = getEntArray("objectRound", "targetname");
  return var_0;
}

_id_310B(var_0) {
  var_1 = getEntArray(self.target, "targetname");

  if(!isDefined(self.volume)) {
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(var_4.classname == "info_volume" || var_4.classname == "info_volume_grapple") {
        self.volume = var_4;
        var_4 enablelinkTo();
        var_2 = 1;
      }

      var_4 linkTo(self);
    }
  }

  self.volume _meth_8506(var_0);

  if(var_0)
    self.volume _id_1451();
  else
    self.volume _id_1453();
}

_id_17A5() {
  var_0 = _id_7EE1();

  foreach(var_2 in var_0)
  var_2 _id_13544(1);

  return var_0;
}

_id_E0CE() {
  var_0 = _id_7EE1();

  foreach(var_2 in var_0)
  var_2 _id_13544(0);
}

_id_17A4() {
  var_0 = _id_7EE0();

  foreach(var_2 in var_0)
  var_2 _id_1353F(1);

  return var_0;
}

_id_E0CD() {
  var_0 = _id_7EE0();

  foreach(var_2 in var_0)
  var_2 _id_1353F(0);
}

_id_17A1() {
  var_0 = _id_7EDE();

  foreach(var_2 in var_0)
  var_2 _id_310C(1);

  return var_0;
}

_id_E0C9() {
  var_0 = _id_7EDE();

  foreach(var_2 in var_0)
  var_2 _id_310C(0);

  return var_0;
}

_id_17A3() {
  var_0 = _id_7EDF();

  foreach(var_2 in var_0)
  var_2 _id_310B(1);

  return var_0;
}

_id_E0CC() {
  var_0 = _id_7EDF();

  foreach(var_2 in var_0)
  var_2 _id_310B(0);

  return var_0;
}

_id_E727(var_0) {
  var_1 = _id_7EDE();

  foreach(var_3 in var_1)
  var_3 thread _id_3109(var_0);

  var_1 = _id_7EDF();

  foreach(var_3 in var_1)
  var_3 thread _id_3109(var_0);
}

_id_3109(var_0) {
  self notify("stopRotating");
  self endon("stopRotating");

  if(!isDefined(var_0)) {
    if(isDefined(self.script_parameters) && float(self.script_parameters) > 0)
      var_0 = float(self.script_parameters);
    else
      var_0 = 5.0;
  }

  if(isDefined(self.script_parameters) && float(self.script_parameters) > 0)
    self._id_5F8A = float(self.script_parameters);

  if(isDefined(self.script_noteworthy) && tolower(self.script_noteworthy) == "start_idle") {
    return;
  }
  for(;;) {
    var_1 = 1.0;
    self rotateroll(var_0, var_1, 0, 0);
    wait(var_1);
  }
}

_id_310A(var_0, var_1, var_2) {
  self notify("stopRotating");
  self endon("stopRotating");
  var_3 = 1.0;

  if(!isDefined(var_2))
    var_2 = 5;

  var_4 = self getpointinbounds(1, 1, 1);
  var_5 = rotatevectorinverted(var_4 - self.origin, self.angles);
  var_6 = rotatevectorinverted(var_0 - self.origin, self.angles);
  var_7 = vectorNormalize(rotatevectorinverted(var_1, self.angles));
  var_8 = vectordot(var_7, (1, 0, 0));
  var_9 = vectordot(var_7, (0, 1, 0));
  var_10 = vectordot(var_7, (0, 0, 1));
  var_11 = var_6[0] / var_5[0] * var_2 * var_10 * -1.0;
  var_11 = var_11 + var_6[2] / var_5[2] * var_2 * var_8;
  var_12 = var_6[1] / var_5[1] * var_2 * var_10;
  var_12 = var_12 + var_6[2] / var_5[2] * var_2 * var_9 * -1.0;
  var_13 = var_6[1] / var_5[1] * var_2 * var_8 * -1.0;
  var_13 = var_13 + var_6[0] / var_5[0] * var_2 * var_9;
  self._id_1E92 = (clamp(var_11, var_2 * -1.0, var_2), clamp(var_13, var_2 * -1.0, var_2), clamp(var_12, var_2 * -1.0, var_2));

  for(;;) {
    var_14 = self.angles + self._id_1E92 * var_3;
    self rotateTo(var_14, var_3, 0, 0);
    wait(var_3);
  }
}

_id_11087() {
  var_0 = _id_7EDE();

  foreach(var_2 in var_0)
  var_2 thread _id_310E();

  var_0 = _id_7EDF();

  foreach(var_2 in var_0)
  var_2 thread _id_310E();
}

_id_310E() {
  self notify("stopRotating");
  self rotateroll(1, 0.1, 0, 0.1);
}

_id_1452(var_0) {
  if(!isDefined(self._id_EE78))
    return 0;

  if(scripts\engine\utility::is_true(self._id_EE78[var_0]))
    return 1;

  return 0;
}

_id_1451() {
  level._id_84B8[self getentitynumber()] = self;

  if(isDefined(self.script_parameters)) {
    var_0 = strtok(self.script_parameters, " ;,");
    self._id_EE78 = [];

    foreach(var_2 in var_0)
    self._id_EE78[var_2] = 1;
  }

  if(_id_1452("no_auto_orient"))
    self _meth_8538(0);
  else
    self _meth_8538(1);

  if(_id_1452("no_grapple"))
    self _meth_855D(1);
  else
    self _meth_855D(0);

  if(_id_1452("no_snap"))
    self _meth_857B(0);
  else
    self _meth_857B(1);
}

_id_1453() {
  level._id_84B8[self getentitynumber()] = undefined;
}

_id_1390() {
  self notify("grapple_off");
  self notify("spacegrapple_cancel");
  _id_1384();
  _id_139D();
  level _id_12C9();
  level _id_1166();
  thread _id_0F33::_id_25B6();
  self forceusehintoff();
  self._id_1CA9 = undefined;
}

_id_1391(var_0, var_1) {
  self endon("grapple_off");
  thread _id_1395(var_0, var_1);
  thread _id_137E(var_0, var_1);
  thread _id_1381(var_0, var_1);
  thread _id_1392(var_0, var_1);
  thread _id_138C(var_0, var_1);
  thread _id_137D(var_0, var_1);
  level thread _id_12CA();
  level _id_1167();
  thread _id_0F33::_id_25B5();
  self._id_1CA9 = 1;
  var_2 = "none";

  while(isDefined(var_1)) {
    self setweaponammoclip("grapplingdevice", 1);
    waittillframeend;

    if(!isDefined(var_1)) {
      continue;
    }
    var_3 = self _meth_8544();
    var_4 = isDefined(var_3) && (isai(var_3) || isDefined(var_3.classname) && issubstr(var_3.classname, "actor_"));
    var_5 = var_2;
    var_2 = self _meth_84F4();

    if(var_2 == "jumping" && scripts\engine\utility::is_true(self._id_1CA9))
      self forceusehinton(&"ZEROG_GRAPPLE_CANCEL_HINT");
    else if(var_5 == "jumping")
      self forceusehintoff();

    scripts\engine\utility::waitframe();
  }
}

_id_1378(var_0) {
  self notify("grapple_death_cancel");
  self endon("grapple_death_cancel");
  self endon("grapple_kill_anim_start");

  if(isDefined(var_0)) {
    var_0 waittill("death");
    self notify("spacegrapple_cancel");
  }
}

_playergrapple_cancelonlinked(var_0) {
  self notify("_playerGrapple_cancelOnDeathOf");
  self endon("_playerGrapple_cancelOnDeathOf");
  self endon("grapple_off");
  var_1 = gettime();

  for(;;) {
    if(float(gettime() - var_1) / 1000.0 > var_0) {
      return;
    }
    if(self islinked()) {
      self notify("spacegrapple_cancel");
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_1386(var_0) {
  if(isDefined(self._id_8498) && self._id_8498 == var_0) {
    return;
  }
  self allowads(var_0);
  self allowreload(var_0);
  self allowmelee(var_0);
  scripts\engine\utility::allow_autoreload(var_0);

  if(var_0) {
    self enableusability();
    self enableoffhandweapons();
  } else {
    self disableusability();
    self disableoffhandweapons();
  }

  self._id_8498 = var_0;
}

_id_138E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_139C(var_1, var_3);

  if(isDefined(var_3)) {
    if(isai(var_3)) {
      if(isDefined(var_1))
        var_1 linkTo(var_3, "j_neck", (0, 0, 0), (0, 0, 0));
    } else {
      var_6 = var_3 getlinkedparent();

      if(!isDefined(var_6))
        var_6 = var_4;

      if(isDefined(var_6)) {
        var_0 linkTo(var_6);

        if(isDefined(var_5))
          var_5 linkTo(var_6);

        if(isDefined(var_1))
          var_1 linkTo(var_6);
      }
    }
  }
}

_id_1392(var_0, var_1) {
  self endon("grapple_off");

  for(;;) {
    self waittill("spacejump_takeoff", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(issentient(var_6) && !isalive(var_6)) {
      self notify("spacegrapple_cancel");
      continue;
    }

    _id_138E(var_0, var_1, var_2, var_6, var_9);
    thread _id_1378(var_6);
    thread _playergrapple_cancelonlinked(getdvarfloat("grapple_gesture_delay"));
    thread _id_1379();
    thread _id_137A();
    _id_1386(0);
    var_10 = scripts\engine\utility::waittill_any_timeout(getdvarfloat("grapple_gesture_delay"), "spacegrapple_cancel");

    if(isDefined(var_10) && var_10 == "spacegrapple_cancel") {
      continue;
    }
    thread _id_0F33::_id_D0AF();
    thread _id_1372(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(var_6) && isai(var_6)) {
      thread _id_1383(var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      thread _id_11CF(getdvarfloat("grapple_retract_delay_enemy"));
      continue;
    }

    thread _id_11CF(getdvarfloat("grapple_retract_delay_point"));
  }
}

_id_1379() {
  self notify("_playerGrapple_inform_witnesses_track");
  self endon("_playerGrapple_inform_witnesses_track");
  self endon("grapple_off");
  self endon("spacejump_land");
  self endon("spacegrapple_cancel");
  self._id_84AE = [];

  for(;;) {
    var_0 = getaiarray("axis");

    foreach(var_2 in var_0) {
      if(!isalive(var_2)) {
        continue;
      }
      if(var_2 cansee(self))
        self._id_84AE[var_2 getentitynumber()] = var_2;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_137A() {
  self notify("_playerGrapple_inform_witnesses_wait");
  self endon("_playerGrapple_inform_witnesses_wait");
  self endon("grapple_off");
  scripts\engine\utility::waittill_any("spacejump_land", "spacegrapple_cancel");

  if(!isDefined(self._id_84AE)) {
    return;
  }
  foreach(var_1 in self._id_84AE) {
    if(!issentient(var_1) || !isalive(var_1)) {
      continue;
    }
    var_1 getenemyinfo(self);
  }
}

_id_138C(var_0, var_1) {
  self endon("grapple_off");

  for(;;) {
    self waittill("spacejump_land");

    if(!_id_12F7(self._id_84B4))
      thread _id_0F33::_id_D0AE();

    thread _id_1373(var_0, var_1);
    thread _id_1382();
  }
}

_id_137D(var_0, var_1) {
  self endon("grapple_off");

  for(;;) {
    self waittill("spacegrapple_cancel");
    self _meth_8563();
    self _meth_80A1();
    self.grapple_invulnerable = undefined;
    thread _id_1384();
    thread _id_1373(var_0, var_1);
    thread _id_1388();
    thread _id_137C();
    thread _id_0F33::_id_D0AB();
    self stopgestureviewmodel("ges_grapple");
    _id_1386(1);
    var_2 = getdvarfloat("player_zeroGravSpeed") * getdvarfloat("player_zeroGravBoostScalar");
    var_3 = var_2 * 2.0;

    if(lengthsquared(self getvelocity()) > squared(var_3))
      self setvelocity(vectorNormalize(self getvelocity()) * var_3);

    if(!scripts\engine\utility::is_true(self._id_849F)) {
      self stoprumble("subtle_tank_rumble");
      self playRumbleOnEntity("damage_light");
      self _meth_8291(1.0, 1.0, 1.0, 0.5, 0, 0.5, 0, 5, 5, 5);
    }
  }
}

_id_1167() {
  level._id_13EF2 = [];
  level._id_13EF2["aim_lockon_deflection"] = getDvar("aim_lockon_deflection");
  level._id_13EF2["aim_lockon_region_height"] = getDvar("aim_lockon_region_height");
  level._id_13EF2["aim_lockon_region_width"] = getDvar("aim_lockon_region_width");
  level._id_13EF2["aim_lockon_strength_mult"] = getDvar("aim_lockon_strength_mult");
  level._id_13EF2["aim_lockon_strength_pitch_mult"] = getDvar("aim_lockon_strength_pitch_mult");
  level._id_13EF2["aim_autoAimRangeScale"] = getDvar("aim_autoAimRangeScale");
  setsaveddvar("aim_lockon_deflection", 0);
  setsaveddvar("aim_lockon_region_height", 40);
  setsaveddvar("aim_lockon_region_width", 40);
  setsaveddvar("aim_lockon_strength_mult", 1.5);
  setsaveddvar("aim_lockon_strength_pitch_mult", 1.5);
  setsaveddvar("aim_autoAimRangeScale", 1.5);
}

_id_1166() {
  setsaveddvar("aim_lockon_deflection", level._id_13EF2["aim_lockon_deflection"]);
  setsaveddvar("aim_lockon_region_height", level._id_13EF2["aim_lockon_region_height"]);
  setsaveddvar("aim_lockon_region_width", level._id_13EF2["aim_lockon_region_width"]);
  setsaveddvar("aim_lockon_strength_mult", level._id_13EF2["aim_lockon_strength_mult"]);
  setsaveddvar("aim_lockon_strength_pitch_mult", level._id_13EF2["aim_lockon_strength_pitch_mult"]);
  setsaveddvar("aim_autoAimRangeScale", level._id_13EF2["aim_autoAimRangeScale"]);
  level._id_13EF2 = undefined;
}

_id_11E7() {
  if(!isDefined(level._id_584F)) {
    level._id_584F = ["nearStart", "nearEnd", "farStart", "farEnd", "nearBlur", "farBlur"];
    level._id_5850 = [0, 0, 1000, 2000, 4, 0];
    level._id_5851 = [0, 15, 100, 200, 4, 2];
  }

  for(var_0 = 0; var_0 < level._id_584F.size; var_0++) {
    if(!isDefined(level._id_13EF2[level._id_584F[var_0]]))
      level._id_13EF2[level._id_584F[var_0]] = getDvar(level._id_584F[var_0]);
  }
}

_id_11E5(var_0, var_1) {
  self notify("_dofGrappleKillLerp");
  self endon("_dofGrappleKillLerp");
  var_2 = 0.0;
  var_3 = 0.05;
  _id_11E7();
  level._id_ABE6 = 1;

  if(!var_0)
    self notify("_dofGrappleKillMonitor");

  var_4 = [];

  while(var_2 < var_1) {
    var_2 = clamp(var_2 + var_3, 0, var_1);
    var_5 = var_2 / var_1;

    if(!var_0)
      var_5 = 1.0 - var_5;

    for(var_6 = 0; var_6 < level._id_584F.size; var_6++) {
      var_7 = float(level._id_5850[var_6]);
      var_8 = float(level._id_5851[var_6]);
      var_4[var_6] = var_7 + (var_8 - var_7) * var_5;
    }

    foreach(var_10 in level.players)
    var_10 setdepthoffield(var_4[0], var_4[1], var_4[2], var_4[3], var_4[4], var_4[5]);

    wait(var_3);
  }

  if(!var_0) {
    for(var_6 = 0; var_6 < level._id_584F.size; var_6++)
      level._id_13EF2[level._id_584F[var_6]] = undefined;

    level._id_ABE6 = 0;
  }
}

_id_11E6(var_0, var_1) {
  self notify("_dofGrappleKillMonitor");
  self endon("_dofGrappleKillMonitor");
  var_2 = 70;
  var_3 = 50;
  var_4 = 99980001;

  while(var_4 > var_2 * var_2 && isDefined(var_1)) {
    var_4 = distancesquared(var_0 getEye(), var_1 getEye());
    wait 0.05;
  }

  level thread _id_11E5(1, 0.2);

  while(var_4 > var_3 * var_3 && isDefined(var_1)) {
    var_4 = distancesquared(var_0 getEye(), var_1 getEye());
    wait 0.05;
  }

  while(var_4 < var_3 * var_3 && isDefined(var_1)) {
    var_4 = distancesquared(var_0 getEye(), var_1 getEye());
    wait 0.05;
  }

  level thread _id_11E5(0, 0.2);
}

_id_12B7() {
  return scripts\common\trace::create_contents(1, 1, 1, 1, 0, 0, 1);
}

_id_137C() {
  self endon("grapple_off");
  var_0 = getdvarfloat("player_zeroGravFriction");
  setsaveddvar("player_zeroGravFriction", 500);
  scripts\engine\utility::waittill_notify_or_timeout("spacejump_takeoff", 2.0);

  if(getdvarfloat("player_zeroGravFriction") == 500)
    setsaveddvar("player_zeroGravFriction", var_0);
}

_id_13AD(var_0, var_1, var_2) {
  self notify("_radialBlurLerp");
  self endon("_radialBlurLerp");

  if(var_0 > 0 && getdvarint("grapple_radial_blur") == 0) {
    return;
  }
  var_3 = 0.05;
  var_0 = clamp(var_0, 0.0, 1.0);
  var_4 = var_3 / var_2;

  if(!isDefined(self._id_DBE5))
    self._id_DBE5 = 0.0;

  wait(var_1);

  while(self._id_DBE5 != var_0) {
    if(self._id_DBE5 < var_0)
      self._id_DBE5 = min(var_0, self._id_DBE5 + var_4);
    else
      self._id_DBE5 = max(var_0, self._id_DBE5 - var_4);

    setsaveddvar("r_mbRadialOverrideStrength", getdvarfloat("grapple_radial_strength") * self._id_DBE5);
    setsaveddvar("r_mbRadialOverrideRadius", 1.0 - getdvarfloat("grapple_radial_radius") * self._id_DBE5);
    setsaveddvar("r_mbRadialOverrideDistortion", getdvarfloat("grapple_radial_distortion") * self._id_DBE5);
    wait(var_3);
  }
}

_id_137E(var_0, var_1) {
  self endon("grapple_off");

  for(;;) {
    self waittill("spacejump_takeoff", var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    self._id_8496 = 1;
    wait(getdvarfloat("grapple_gesture_delay"));

    if(issentient(var_6) && !isalive(var_6)) {
      self notify("spacegrapple_cancel");
      continue;
    }

    if(scripts\engine\utility::is_true(self._id_8496)) {
      self playRumbleOnEntity("heavygun_fire");
      self _meth_8244("subtle_tank_rumble");
      self _meth_8291(2.0, 2.0, 2.0, 0.5, 0, 0.5, 0, 5, 5, 5);
      thread _id_138B(var_0, var_1, var_6);
      var_9 = var_2;
      var_10 = var_3;

      if(isDefined(var_1)) {
        var_9 = var_1.origin;
        var_10 = var_1.angles;
      }

      var_11 = anglestoaxis(var_10);
      var_12 = var_9;
      var_9 = var_9 + var_11["forward"] * -20.0;
      var_9 = var_9 + var_11["up"] * 20.0;
      var_13 = vectorNormalize(var_12 - var_9);

      if(!issentient(var_6))
        thread _id_1387(var_9, anglesToForward(var_3) * -1.0);
    }
  }
}

_id_1381(var_0, var_1) {
  self endon("grapple_off");

  for(;;) {
    self waittill("spacegrapple_begin_move");

    if(scripts\engine\utility::is_true(self._id_8496) && !isDefined(self._id_84B0)) {
      self._id_84B0 = spawnfx(scripts\engine\utility::getfx("grapple_cam"), self.origin);
      triggerfx(self._id_84B0);
      thread _id_1393();
      thread _id_13AD(1.0, getdvarfloat("grapple_radial_time_delay"), getdvarfloat("grapple_radial_time_in"));
    }

    self._id_8496 = undefined;
  }
}

_id_1387(var_0, var_1) {
  self endon("spacejump_land");
  self endon("spacegrapple_cancel");
  wait 0.2;
  playFX(scripts\engine\utility::getfx("zerog_grapple_impact"), var_0, var_1);
}

_id_1393() {
  self endon("spacejump_land");
  self endon("spacegrapple_cancel");
  var_0 = 0.3;

  for(;;) {
    self _meth_8291(0.1, 0.1, 0.1, var_0, 0, 0, 0, 20, 20, 20);
    wait(var_0);
  }
}

_id_1384() {
  if(isDefined(self._id_84B0))
    self._id_84B0 delete();

  self._id_84B0 = undefined;
  thread _id_13AD(0.0, 0.0, getdvarfloat("grapple_radial_time_out"));
  self._id_8496 = undefined;
}

_id_138B(var_0, var_1, var_2) {
  self endon("spacegrapple_cancel");
  self._id_849F = undefined;
  scripts\engine\utility::waittill_any("spacejump_gesture_stop", "spacejump_land");
  self._id_849F = 1;
  var_3 = self _meth_8577();

  if(isDefined(var_3) && isDefined(var_3._id_5F8A))
    var_3 thread _id_310A(var_1.origin, var_1.origin - self.origin, var_3._id_5F8A);

  if(!isDefined(self._id_84B4))
    thread _id_1373(var_0, var_1);

  thread _id_1384();
  self stoprumble("subtle_tank_rumble");
  wait 0.1;
  self playRumbleOnEntity("damage_heavy");
  self _meth_8291(2.0, 2.0, 2.0, 1, 0, 1, 0, 5, 5, 5);

  if(!isDefined(self._id_84B4))
    _id_1386(1);
}

_id_12B2() {
  var_0 = "grapple_kill_";

  if(!isDefined(level._id_849E)) {
    for(level._id_849E = 1; isDefined(level._id_EC87[var_0 + level._id_849E]); level._id_849E = level._id_849E + 1) {}

    level._id_849E = level._id_849E - 1;
  }

  var_1 = getdvarint("grapple_kill_idx");

  if(var_1 > 0) {
    var_2 = var_1;

    if(var_2 < 1)
      var_2 = 1;
    else if(var_2 > level._id_849E)
      var_2 = level._id_849E;

    return var_0 + var_2;
  }

  var_2 = 1;

  if(isDefined(self._id_A8C4))
    var_2 = self._id_A8C4 + 1;

  if(var_2 > level._id_849E)
    var_2 = 1;

  self._id_A8C4 = var_2;
  var_3 = var_0 + var_2;
  return var_3;
}

_id_1383(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self _meth_80D1();
  self.grapple_invulnerable = 1;
  self._id_A633 = _id_12B2();
  self._id_1FBB = self._id_A633 + "_player";

  if(isDefined(var_4._id_849C)) {
    var_7 = anglestoaxis(var_1);

    if(vectordot(var_7["forward"], anglesToForward(var_4._id_849C)) > cos(60))
      var_1 = var_4._id_849C;
    else
      var_4._id_849C = undefined;
  }

  self._id_84B3 = _id_13DC(self._id_A633, var_0, var_1);
  var_8 = self._id_84B3 gettagorigin("tag_player");
  var_9 = self._id_84B3 gettagangles("tag_player");
  var_10 = self._id_84B3 gettagorigin("tag_origin");
  self _meth_84E7(var_8, var_9);
  var_10 = var_10 + anglestoup(self._id_84B3.angles) * 50;
  var_10 = var_10 + anglesToForward(self._id_84B3.angles) * 50;
  self._id_84B4 = _id_13DB(self._id_A633, var_4, var_10, self._id_84B3._id_EF80.angles, self);
}

_id_13DB(var_0, var_1, var_2, var_3, var_4) {
  var_1._id_1FBB = var_0;
  var_5 = "hit_front";
  var_6 = vectorNormalize(var_4.origin - var_1.origin);
  var_7 = anglestoaxis(var_1.angles);
  var_8 = vectordot(var_6, var_7["forward"]);
  var_9 = vectordot(var_6, var_7["right"]);

  if(var_8 < -0.7)
    var_5 = "hit_back";
  else if(var_9 < -0.7)
    var_5 = "hit_left";
  else if(var_9 > 0.7)
    var_5 = "hit_right";

  var_1 thread _id_126D(var_5, "hit_front_loop", var_2, var_3, "grapple_loop_stop", var_4);

  if(soundexists("sa_ss1_grappledrag"))
    var_1 playSound("sa_ss1_grappledrag");

  if(isDefined(level._id_EC85[var_0]["kill_enemy_thread"]))
    var_1 thread[[level._id_EC85[var_0]["kill_enemy_thread"]]]();

  var_1 _id_6553();

  if(var_1.space)
    var_1[[var_1._id_11093]]();

  return var_1;
}

_id_13DC(var_0, var_1, var_2) {
  if(isDefined(self._id_84B3))
    var_3 = self._id_84B3;
  else {
    var_3 = spawn("script_model", var_1);
    var_3 setModel("viewmodel_base_viewhands_iw7");
  }

  var_3.angles = var_2;
  var_3._id_1FBB = var_0 + "_player";
  var_3 _meth_83D0(level._id_EC87[var_3._id_1FBB]);
  var_4 = spawnStruct();
  var_4.origin = var_1;
  var_4.angles = var_2;
  var_4 scripts\sp\anim::_id_1EC3(var_3, "kill_arms");
  var_3._id_EF80 = var_4;
  var_3 hide();
  return var_3;
}

_id_1265(var_0) {
  var_1 = var_0 gettagorigin("j_spine4");
  var_2 = spawn("script_origin", var_1);
  var_2 _meth_8278(0.3);

  if(soundexists("gib_fullbody"))
    var_2 playSound("gib_fullbody", "sounddone");

  var_2 waittill("sounddone");
  wait 0.1;
  var_2 delete();
}

_id_1264() {
  var_0 = scripts\engine\utility::waittill_any_return("grapple_impact", "death", "grapple_cancel");

  if(isDefined(var_0) && var_0 == "grapple_impact") {
    var_1 = scripts\sp\utility::_id_10639("grenade_pull", (0, 0, 0));
    var_1 notsolid();
    var_2 = undefined;

    if(isDefined(var_1)) {
      var_1 linkTo(self, "tag_weapon_chest", (0, 0, 0), (0, 0, 0));
      var_0 = scripts\engine\utility::waittill_any_return("grapple_kill_anim_start", "death", "grapple_cancel");

      if(isDefined(var_0) && var_0 == "grapple_kill_anim_start") {
        var_3 = var_1 scripts\sp\utility::_id_7DC1("grenade_pull");

        if(isDefined(var_3)) {
          var_1 _meth_82AB(var_3, 1, 0);
          self._id_828B = ::_id_1265;

          if(isalive(self)) {
            var_0 = scripts\engine\utility::waittillmatch_any_return("single anim", "pull_grenade_pin", "end");

            if(isDefined(var_0) && var_0 == "pull_grenade_pin") {
              var_4 = var_1 gettagorigin("tag_fx") + anglesToForward(level.player getplayerangles()) * 100;
              var_2 = self _meth_81EE(var_4, (0, 0, 0), 99999);

              if(isDefined(var_2)) {
                var_2._id_8589 = 1;
                var_2 setModel("tag_origin");
                var_2.origin = var_4;
              }
            }

            if(isalive(self))
              scripts\engine\utility::waittill_any_timeout(5, "death");
          }

          self stopsounds();
          thread scripts\engine\utility::play_sound_in_space("zero_g_grapple_kill_grenade_explo", var_1.origin);
        }
      }

      if(isDefined(var_2))
        var_2 delete();

      var_1 delete();
    }
  }
}

_id_126A() {
  var_0 = spawn("script_model", (0, 0, 0));

  if(isDefined(var_0)) {
    var_1 = scripts\engine\utility::waittill_any_return("grapple_kill_anim_start", "death", "grapple_cancel");

    if(var_1 == "grapple_kill_anim_start") {
      wait 0.2;
      var_0 setModel("tactical_knife_iw7_wm");
      var_0 _meth_81E2(level.player, "tag_accessory_right", (0, 0, 0), (0, 0, 0), 0);
      wait 2;
    }

    var_0 delete();
  }
}

_id_126D(var_0, var_1, var_2, var_3, var_4, var_5) {
  self._id_146D = var_0;
  self._id_147B = var_1;
  var_6 = anglestoaxis(var_3);
  self._id_146B = axistoangles(var_6["forward"] * -1.0, var_6["right"] * -1.0, var_6["up"]);
  self._id_146C = var_3;
  self._id_147C = var_2;
  self._id_147A = var_4;
  self._id_147D = var_5;
  _id_0A1E::_id_2307(::_id_1267);
}

_id_11CF(var_0) {
  self endon("spacegrapple_cancel");
  wait(var_0);
  thread _id_0F33::_id_D0AA();
  self notify("spacegrapple_begin_move");
  self _meth_8564();
}

_playerlerpangles(var_0, var_1) {
  var_2 = 0.05;
  var_3 = float(gettime()) / 1000.0;
  var_4 = var_3 + var_1;

  if(var_1 <= 0) {
    return;
  }
  var_5 = scripts\engine\utility::spawn_tag_origin();

  if(!isDefined(var_5)) {
    return;
  }
  var_6 = self getplayerangles();
  var_5.angles = var_6;
  self setworldupreference(var_5);
  self setplayerangles((0, 0, 0));
  self setworldupreferenceangles(var_6, 0);

  while(var_3 < var_4) {
    var_7 = cos((var_4 - var_3) / var_1 * 90);
    var_5.angles = anglelerpquatfrac(var_6, var_0, var_7);
    wait(var_2);
    var_3 = float(gettime()) / 1000.0;
  }

  var_5.angles = var_0;
  var_6 = self getplayerangles();
  self setworldupreference(undefined);
  self setplayerangles((0, 0, 0));
  self setworldupreferenceangles(var_6, 0);
  var_5 delete();
}

_id_1267() {
  self endon("death");
  self notify("killanimscript");
  self endon("killanimscript");
  self endon(self._id_147A);
  self notify("grapple_kill");
  var_0 = level._id_EC85[self._id_1FBB][self._id_146D];
  var_1 = getanimlength(var_0);
  var_2 = level._id_EC85[self._id_1FBB][self._id_147B][0];
  var_3 = getanimlength(var_2);
  var_4 = self._id_147C;
  var_5 = self._id_146B;
  var_6 = self._id_146C;
  var_7 = self._id_147D;
  var_8 = getdvarfloat("grapple_impact_delay");
  var_9 = getdvarfloat("grapple_retract_delay_enemy");
  var_10 = gettime();
  var_7 waittill("spacejump_jumping", var_11);
  var_8 = var_8 - float(gettime() - var_10) / 1000.0;
  var_9 = var_9 - float(gettime() - var_10) / 1000.0;

  if(var_8 > 0) {
    wait(var_8);
    var_9 = var_9 - var_8;
  }

  self notify("grapple_impact");

  if(getdvarint("ai_iw7") == 1)
    self clearanim(_id_0A1E::_id_2342(), 0.3);
  else
    self clearanim(self._id_E6E6, 0.3);

  if(self.space && self[[self._id_9E8E]]())
    self _meth_80F1(self gettagorigin("j_spinelower"));

  self animmode("nogravity");
  self setanimknob(var_0, 1, 0);

  if(isDefined(self._id_849C)) {
    var_12 = anglestoaxis(var_7 getplayerangles());
    var_12["forward"] = vectorNormalize(self.origin - var_7 getEye());
    var_12["right"] = vectorcross(var_12["forward"], var_12["up"]);
    var_12["up"] = vectorcross(var_12["forward"], var_12["right"]);
    var_6 = axistoangles(var_12["forward"], var_12["right"], var_12["up"]);
  }

  var_7 thread _playerlerpangles(var_6, var_9);

  if(var_9 > 0)
    wait(var_9);

  thread _id_126B(var_5, var_11, self._id_147A, var_7);
  thread _id_1269(var_4, var_11, self._id_147A, var_7);
  self._id_146D = undefined;
  self._id_147B = undefined;
  self._id_146B = undefined;
  self._id_146C = undefined;
  self._id_147C = undefined;
  self._id_147E = undefined;
  self._id_147D = undefined;

  for(;;) {
    self setanimknob(var_2);
    wait(max(var_3, 0.05));
  }
}

_id_126B(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_3 endon("spacegrapple_cancel");
  self notify("enemy_rotate_to");
  self endon("enemy_rotate_to");

  if(!isDefined(self._id_C407)) {
    self._id_C407 = self.turnrate;
    self._id_C401 = self.pushable;
  }

  var_4 = anglesdelta(self.angles, var_0) * 2;
  self.turnrate = var_4 / var_1;
  thread _id_1266(var_3, var_2);
  self orientmode("face angle 3d", var_0);
  scripts\engine\utility::waittill_any("killanimscript", "death", var_2);
  self.turnrate = self._id_C407;
  self.pushable = self._id_C401;
  self._id_C407 = undefined;
  self._id_C401 = undefined;
}

_id_1266(var_0, var_1) {
  self endon("death");
  self endon("killanimscript");
  self endon(var_1);
  self endon("enemy_rotate_to");
  var_0 waittill("spacegrapple_cancel");
  self.turnrate = self._id_C407;
  self.pushable = self._id_C401;
  self._id_C407 = undefined;
  self._id_C401 = undefined;
}

_id_1269(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon(var_2);
  var_3 endon("spacegrapple_cancel");
  var_4 = int(var_1 / 50.0);
  var_5 = 0;
  var_6 = vectorNormalize(var_0 - self.origin);
  var_7 = distance(var_0, self.origin);
  var_8 = var_7 / var_4;
  var_9 = var_6 * var_8;

  while(var_5 < var_4) {
    var_10 = self.origin + var_9;
    self _meth_80F1(var_10);
    var_5++;
    wait 0.05;
  }

  self _meth_80F1(var_0);
}

_id_12F7(var_0) {
  return isDefined(var_0) && isalive(var_0) && !scripts\engine\utility::is_true(var_0.delayeddeath);
}

_id_1382() {
  thread _id_1389(self._id_84B4);
}

_id_1388() {
  if(isDefined(self._id_84B4)) {
    var_0 = self._id_84B4;
    var_0 notify("stop_loop");
    var_0 notify("grapple_loop_stop");
    var_0 notify("grapple_cancel");

    if(isDefined(self._id_84B3))
      self._id_84B3 delete();

    if(isDefined(var_0._id_B14F))
      var_0 scripts\sp\utility::_id_1101B();

    var_0._id_84AF = undefined;
    var_0 thread _id_6570();

    if(var_0.space)
      var_0[[var_0._id_10DFE]]();
  }

  self._id_84B4 = undefined;
}

_id_138A(var_0, var_1) {
  self endon("disconnect");
  self endon(var_0);
  var_2 = var_1 scripts\engine\utility::waittillmatch_any_return("single anim", "interruptible", "end");
  self notify(var_0, var_2);
}

_id_1389(var_0) {
  if(_id_12F7(var_0)) {
    thread _id_0F33::_id_D0AD();

    if(isDefined(var_0) && isalive(var_0)) {
      var_0 scripts\sp\utility::_id_B14F(1);
      var_0._id_84AF = 1;
      var_0 notify("stop_loop");
      var_0 notify("grapple_loop_stop");
      self._id_849D = 1;
      self notify("grapple_kill_anim_start");
      self._id_84B3 notify("grapple_kill_anim_start");
      var_0 notify("grapple_kill_anim_start");
      self _meth_8563();
      level thread _id_11E6(self, var_0);
      var_1 = 0.1;
      var_2 = var_1 / 4;
      self _meth_823C(self._id_84B3, "tag_player", var_1, var_2, var_2);
      self _meth_80D1();
      self.grapple_invulnerable = 1;
      self freezecontrols(1);
      _id_1386(0);
      setsaveddvar("depthSortViewmodel", 1);
      var_0._id_1FBB = self._id_A633;
      var_0 thread _id_1262(self._id_84B3._id_EF80, "kill_anim", self);
      var_0 thread _id_126C(self);

      if(isDefined(level._id_EC85[self._id_1FBB]["kill_gesture"]))
        self forceplaygestureviewmodel(level._id_EC85[self._id_1FBB]["kill_gesture"], undefined, 0.2, 0.0, 1, 1);

      self._id_84B3._id_EF80 thread scripts\sp\anim::_id_1F35(self._id_84B3, "kill_arms");
      thread _id_138A("kill_release", self._id_84B3);
      self waittill("kill_release", var_3);
      self unlink();
      var_4 = playerphysicstrace(self._id_84B3.origin, self.origin, self, self getplayerangles());

      if(distancesquared(var_4, self.origin) > 0.0001) {
        var_5 = vectorNormalize(self._id_84B3.origin - self.origin);
        self setOrigin(var_4 + var_5);
      }

      setsaveddvar("depthSortViewmodel", 0);
      self _meth_80A1();
      self.grapple_invulnerable = undefined;
      self freezecontrols(0);
      _id_1386(1);
      self._id_849D = 0;
      self._id_84B4 = undefined;
      thread _id_1371(getdvarfloat("grapple_enemy_debounce"));
      _id_1394();
    }
  }

  if(isDefined(self._id_84B3)) {
    self._id_84B3 delete();
    self._id_84B3 = undefined;
  }
}

_id_1394() {
  var_0 = 15;
  var_1 = self _meth_8139("grappleKillCount");

  if(var_1 < var_0) {
    var_2 = var_1 + 1;
    self _meth_8302("grappleKillCount", var_2);

    if(var_2 == var_0)
      self giveachievement("15_ZERO_G");
  }
}

_id_1371(var_0) {
  self notify("_playerDebounceGrappleKills");
  self endon("_playerDebounceGrappleKills");

  if(!isDefined(self._id_84B6))
    self._id_84B6 = getdvarfloat("grapple_enemy_dist");

  setsaveddvar("grapple_enemy_dist", 0.0);
  wait(var_0);
  setsaveddvar("grapple_enemy_dist", self._id_84B6);
  self._id_84B6 = undefined;
}

_id_1268() {
  self endon("death");
  self waittillmatch("single anim", "helmet_rip");

  if(isDefined(self._id_8E19))
    self[[self._id_8E19]]();
}

_id_126C(var_0) {
  self notify("_enemyRumbleDeath");
  self endon("_enemyRumbleDeath");
  self endon("death");

  while(isDefined(level._id_EC85[self._id_1FBB]) && isDefined(level._id_EC85[self._id_1FBB]["kill_rumble"])) {
    self waittillmatch("single anim", level._id_EC85[self._id_1FBB]["kill_rumble"]);
    var_0 playRumbleOnEntity("heavygun_fire");
  }
}

_id_126E() {
  self endon("death");
  self waittillmatch("single anim", "remove_highlight");
  self notify("zero_g_remove_highlight");
  self._id_9320 = 1;
  self.team = "neutral";
}

_id_1262(var_0, var_1, var_2) {
  self endon("death");
  var_0 thread scripts\sp\anim::_id_1F35(self, var_1);
  self._id_C015 = 1;
  thread _id_1268();
  thread _id_126E();

  if(isDefined(level._id_EC85[self._id_1FBB]["kill_note"]))
    self waittillmatch("single anim", level._id_EC85[self._id_1FBB]["kill_note"]);
  else {
    var_3 = getanimlength(level._id_EC85[self._id_1FBB][var_1]);
    var_4 = var_3 * 0.5;
    wait(var_4);
  }

  while(isDefined(var_2) && scripts\engine\utility::is_true(var_2._id_849D))
    scripts\engine\utility::waitframe();

  if(isDefined(self) && isDefined(self._id_B14F))
    scripts\sp\utility::_id_1101B();

  self.hatmodel = undefined;
  self._id_8E1A = undefined;
  self._id_DC1D = vectorNormalize(self getEye() - var_2 getEye()) * 10;

  if(isDefined(level._id_EC85[self._id_1FBB]["kill_thread"]))
    self thread[[level._id_EC85[self._id_1FBB]["kill_thread"]]](var_1, var_2);
  else {
    self.forceragdollimmediate = 1;
    self dodamage(self.health, self.origin, var_2, var_2, "MOD_MELEE");
  }
}

_id_1263(var_0, var_1) {
  self endon("death");
  var_2 = 200;
  var_3 = 9999;
  var_4 = 50;
  self _meth_83A1();
  playFXOnTag(scripts\engine\utility::getfx("zerog_grapple_grenade_detonate"), self, "tag_weapon_chest");
  var_5 = self gettagorigin("j_spine4") + anglestoright(self gettagangles("j_spine4")) * 16;
  radiusdamage(var_5, var_2, var_3, var_4, var_1, "MOD_GRENADE");
}

_id_13DA() {
  var_0 = getEntArray("grapple_boundary", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_12CB);
}

_id_12CB() {
  if(isDefined(self.target)) {
    var_0 = scripts\engine\utility::getStruct(self.target, "targetname");

    if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "overrideDirection")
      self._id_C824 = vectorNormalize(self.origin - var_0.origin);
    else
      self._id_C823 = var_0.origin;
  }
}

_id_12C9() {
  level notify("grapple_boundaries_off");
  setsaveddvar("player_zeroGravForceDir", (0, 0, 0));
}

_id_12CA() {
  var_0 = getEntArray("grapple_boundary", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_12CC);

  if(scripts\engine\utility::is_true(level._id_2F0B)) {
    var_1 = getEntArray("grapple_warning", "targetname");

    if(isDefined(var_1) && var_1.size > 0)
      scripts\engine\utility::array_thread(var_1, ::_id_12CD);
  }
}

_id_12CD() {
  level endon("grapple_boundaries_off");
  self notify("_grappleBoundaryRun");
  self endon("_grappleBoundaryRun");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isDefined(var_0) || scripts\engine\utility::is_true(var_0._id_94C9) || var_0 islinked()) {
      continue;
    }
    var_0._id_1D44 = 1;
    var_1 = 5;
    setomnvar("ui_gettocover_text", "zerog_return_to_combat");
    scripts\sp\gameskill::_id_4766(1, 1);

    while(var_0 istouching(self)) {
      scripts\engine\utility::waitframe();
      var_1 = var_1 - 0.05;
    }

    scripts\sp\gameskill::_id_4766(0, 1);
    var_0._id_1D44 = undefined;
    var_0._id_94C9 = 0;
  }
}

_id_12CC() {
  level endon("grapple_boundaries_off");
  self notify("_grappleBoundaryRun");
  self endon("_grappleBoundaryRun");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isDefined(var_0) || scripts\engine\utility::is_true(var_0._id_94C9) || var_0 islinked() || var_0 _id_9E14()) {
      continue;
    }
    if(scripts\engine\utility::is_true(level._id_2F0B)) {
      scripts\sp\gameskill::_id_4766(0, 1);
      level.player _meth_81D0((0, 0, 0));
      continue;
    }

    var_0._id_94C9 = 1;
    var_0 forceusehinton(&"ZEROG_RETURN_TO_COMBAT");
    var_1 = vectorNormalize(var_0 getvelocity()) * -1.0;

    if(isDefined(self._id_C824))
      var_1 = self._id_C824 * -1.0;

    setsaveddvar("player_zeroGravForceDir", vectorNormalize(var_1));

    while(isDefined(self) && var_0 istouching(self)) {
      if(isDefined(self._id_C823)) {
        var_1 = vectorNormalize(self._id_C823 - var_0 getEye());
        setsaveddvar("player_zeroGravForceDir", var_1);
      }

      scripts\engine\utility::waitframe();
    }

    wait 0.5;
    setsaveddvar("player_zeroGravForceDir", (0, 0, 0));
    var_0 forceusehintoff();
    var_0._id_94C9 = 0;
  }
}

_id_1395(var_0, var_1) {
  var_2 = "J_grappleRope_50";
  self._id_848F = [];
  self._id_848F["model_rope_fire"] = _id_1410("grapple_rope");

  if(isDefined(self._id_848F["model_rope_fire"])) {
    self._id_848F["model_rope_fire"] _meth_81E4(self, "j_wrist_le", (0, 0, 0), (0, 0, 0), 1, 1, 1, 0, "none");

    if(isDefined(var_1))
      self._id_848F["model_rope_fire"] _meth_850D(var_1);
    else
      self._id_848F["model_rope_fire"] _meth_850D(var_0);
  }

  self._id_848F["model_rope_idle"] = _id_1410("grapple_rope_stretch");

  if(isDefined(self._id_848F["model_rope_fire"]) && isDefined(self._id_848F["model_rope_idle"])) {
    if(scripts\sp\utility::hastag(self._id_848F["model_rope_fire"].model, var_2))
      self._id_848F["model_rope_idle"] linkTo(self._id_848F["model_rope_fire"], var_2, (0, 0, 0), (0, 0, 0));
  }

  if(isDefined(self._id_848F["model_rope_fire"]))
    self._id_848F["model_rope_fire"] hide();

  if(isDefined(self._id_848F["model_rope_idle"]))
    self._id_848F["model_rope_idle"] hide();
}

_id_1410(var_0) {
  var_1 = scripts\sp\utility::_id_10639(var_0, (0, 0, 0));

  if(isDefined(var_1)) {
    var_1 notsolid();
    var_1 setcontents(0);
    var_1 castspotshadows(0);
  }

  return var_1;
}

_id_139D() {
  if(isDefined(self._id_848F)) {
    foreach(var_1 in self._id_848F) {
      if(isent(var_1))
        var_1 delete();
    }

    self._id_848F = undefined;
  }
}

_id_139C(var_0, var_1) {
  var_2 = 5;
  var_3 = undefined;

  if(!isai(var_1)) {
    var_4 = self getplayerangles();
    var_5 = anglestoaxis(var_4);
    var_6 = anglestoaxis(var_0.angles);
    var_7 = var_0.origin + var_6["forward"] * -1 + var_6["up"];
    var_8 = var_0.origin + var_6["forward"] * 30 + var_6["up"] * -30;
    var_9 = bulletTrace(var_7, var_8, 0, undefined);

    if(var_9["fraction"] < 1.0) {
      var_10 = [];
      var_10["forward"] = var_5["right"];
      var_10["right"] = var_5["up"] * -1.0;
      var_10["up"] = var_5["forward"] * -1.0;
      var_3 = _id_1410("grapple_bolt");

      if(isDefined(var_3)) {
        var_3.origin = var_9["position"] + var_5["forward"] * 2.0;
        var_3.angles = axistoangles(var_10["forward"], var_10["right"], var_10["up"]);
        var_0.origin = var_3.origin + var_10["up"] * 2;
        var_11 = var_3.origin + var_10["up"] * 50.0;
        var_12 = var_3.origin + var_10["up"] * -10.0;
        magicbullet("iw7_ar57", var_11, var_12);
        var_3._id_84AB = gettime();

        if(!isDefined(self._id_8493))
          self._id_8493 = [];

        self._id_8493[var_3 getentitynumber()] = var_3;

        if(self._id_8493.size > var_2) {
          var_13 = gettime();
          var_14 = undefined;

          foreach(var_16 in self._id_8493) {
            if(var_16._id_84AB < var_13) {
              var_13 = var_16._id_84AB;
              var_14 = var_16 getentitynumber();
            }
          }

          if(isDefined(var_14)) {
            self._id_8493[var_14] delete();
            self._id_8493[var_14] = undefined;
          }
        }
      }
    }
  }

  return var_3;
}

_id_1372(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  self endon("spacegrapple_cancel");
  self notify("grapple_fire_rope");
  var_9 = self._id_848F["model_rope_fire"];
  var_9 show();
  var_10 = var_9 scripts\sp\utility::_id_7DC1("fire");
  var_9 _meth_82AB(var_10, 1, 0);
  var_11 = self._id_848F["model_rope_idle"];
  var_11 show();

  if(isDefined(var_1))
    var_11 thread _id_13B8(var_1);
  else
    var_11 thread _id_13B8(var_0);

  thread _id_138D(var_9);
}

_id_138D(var_0) {
  playFXOnTag(scripts\engine\utility::getfx("zerog_grapple_launch"), var_0, "tag_origin");
}

_id_13B8(var_0) {
  self notify("grapple_rope_length_thread");
  self endon("grapple_rope_length_thread");
  self endon("death");
  var_1 = 2000.0;
  var_2 = scripts\sp\utility::_id_7DC1("idle");
  self _meth_82AB(var_2, 1, 0, 0);

  for(;;) {
    var_3 = distance(self.origin, var_0.origin) - 253.0;
    var_4 = clamp(var_3 / var_1, 0.00001, 0.99999);
    self _meth_82B0(var_2, var_4);
    scripts\engine\utility::waitframe();
  }
}

_id_1373(var_0, var_1) {
  var_0 unlink();

  if(isDefined(var_1))
    var_1 unlink();

  var_2 = self._id_848F["model_rope_fire"];
  var_2 hide();
  var_3 = self._id_848F["model_rope_idle"];
  var_3 hide();
  var_3 notify("grapple_rope_length_thread");
}