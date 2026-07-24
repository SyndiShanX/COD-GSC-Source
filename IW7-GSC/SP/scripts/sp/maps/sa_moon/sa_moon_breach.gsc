/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_breach.gsc
******************************************************/

_id_E90A() {
  _id_0F16::_id_3E3F("breach_start");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_2F5A();
  scripts\sp\maps\sa_moon\sa_moon_util::_id_10628();
  _id_0F16::_id_3E3B("breach_start");
  thread _id_0F36::_id_12AB4("zero_g_end");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(0);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_8E92(1);
  thread _id_0F35::_id_FAFD();
  var_0 = getEnt("carrier_damage_model", "targetname");
  var_0 hide();
  scripts\engine\utility::flag_set("hull_combat_wave1a");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_A127();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_3970();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF9(1, 1);
  thread scripts\sp\maps\sa_moon\sa_moon_hull::_id_91B6();
  thread scripts\sp\maps\sa_moon\sa_moon_hull::_id_8918();
  thread scripts\sp\maps\sa_moon\sa_moon_hull::_id_91C3();
  thread scripts\sp\maps\sa_moon\sa_moon_hull::_id_91C4();
}

_id_E904() {
  thread _id_E8F8();
  scripts\engine\utility::flag_wait("breach_end");
}

_id_E8F8() {
  scripts\engine\utility::flag_set("breach_begin");
  level notify("end_enemy_highlighting");
  scripts\engine\utility::trigger_off("player_in_gravity_trigger", "targetname");
  setsaveddvar("antilagAllowHighDetailBroadphaseArchive", 1);
  level thread _id_E965();
  level thread _id_E90C();
  level thread _id_E8FA();
  level thread _id_E902();
  level thread _id_E8FE();
  level thread _id_E907();
  level thread _id_E90D();
  level thread _id_E90B();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_2F59();
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132C4(1);
  scripts\sp\utility::_id_F3E4(0, 0);
  scripts\sp\utility::_id_2679();
  level.player thread _id_0F35::_id_D385(undefined);
  var_0 = [];
  level._id_2F78 = scripts\sp\utility::_id_10639("breach_hotwire_box");
  level._id_2F78 hide();
  var_0[var_0.size] = level._id_2F78;
  level._id_2FD7 = scripts\engine\utility::getStruct("bridge_breach_anim_struct", "targetname");
  var_1 = scripts\sp\utility::_id_10639("player_arms");
  var_0[var_0.size] = var_1;
  var_1 hide();
  level._id_2FD7 scripts\sp\anim::_id_1EC1(var_0, "plant_breach_custom");
  level thread _id_E906();
  var_2 = level._id_2F78 scripts\engine\utility::spawn_tag_origin();
  var_2 _id_0E46::_id_48C4(undefined, undefined, &"SHIP_ASSAULT_OBJ_BREACH", undefined, 500, 100, 1);
  var_2 waittill("trigger");

  foreach(var_4 in level._id_84B8)
  var_4 delete();

  level._id_84B8 = [];
  level notify("handle_zero_g_highlighting");
  level.player notify("_radialBlurLerp");
  scripts\engine\utility::flag_set("bridge_breach_started");
  scripts\engine\utility::flag_set("zero_g_end");
  scripts\engine\utility::array_call(getcorpsearray(), ::delete);
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_2F58();
  level.player _meth_84FE();
  level.player disableweapons();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player allowfire(0);
  level.player _meth_80D1();
  var_6 = distance(level.player.origin, var_1 gettagorigin("tag_player"));
  var_7 = 64;
  var_8 = var_6 / var_7;
  level.player _meth_823C(var_1, "tag_player", var_8, var_8 * 0.5, 0.0);
  wait(var_8);
  level notify("breach_anim_started");
  scripts\engine\utility::flag_set("bridge_breach_anim_started");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_2F57();
  var_1 show();
  level._id_2F78 show();
  level._id_2FD7 thread scripts\sp\anim::_id_1F2C(var_0, "plant_breach_custom");
  level._id_2F78 thread _id_E900();
  level thread _id_E8FF();
  scripts\engine\utility::delaythread(2.4, scripts\engine\utility::flag_set, "raising_the_shields");
  level._id_2F78 waittillmatch("single anim", "device_activate");
  scripts\engine\utility::flag_set("breach_detonation");
  level thread _id_E962();
  level thread _id_E8F7();
  var_1 waittillmatch("single anim", "raise_weapon");
  level.player enableweapons();
  scripts\engine\utility::flag_set("breach_end");
  var_1 waittillmatch("single anim", "end");
  var_1 hide();
  level.player allowsprint(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
  level.player freezecontrols(0);
  level.player allowfire(1);
  level.player _meth_84FD();
  level.player dontinterpolate();
  level.player unlink();
  var_1 delete();
  wait 2.0;
  scripts\engine\utility::flag_set("enable_player_breach_enter");
  scripts\engine\utility::flag_wait("player_breach_enter");
  scripts\engine\utility::flag_set("player_finished_breach_enter");
  _id_0F31::_id_E0C8();
  _id_0F31::_id_E0CE();
  _id_0F31::_id_E0CD();
  _id_0F35::_id_FB26(0, 1);
  level.player thread _id_0F35::_id_D385();
  scripts\engine\utility::trigger_off("player_in_gravity_trigger", "targetname");
}

_id_E8FA() {
  level._id_679E thread _id_E8F9("ethan_breach_node");
  level._id_C49F thread _id_E8F9("omar_breach_node");
  level._id_EAFE thread _id_E8F9("salter_breach_node");
  thread _id_88B4();
}

_id_E8F9(var_0) {
  level endon("moon_breach_ender");
  self endon("death");
  scripts\sp\utility::_id_54F7();
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F39F();
  self._id_B3E9 = 1;
  var_1 = getnode(var_0, "targetname");
  self _meth_82EE(var_1);
}

_id_88B4() {
  scripts\engine\utility::flag_wait("bridge_breach_started");
  wait 1.0;

  foreach(var_1 in level._id_1C24) {
    var_1 scripts\sp\utility::_id_1101B();
    var_1 delete();
  }

  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_10626();
  scripts\engine\utility::flag_wait("allies_spawned");
  scripts\engine\utility::array_thread(level.allies, ::_id_C08D);
  var_3 = scripts\engine\utility::getStruct("bridge_breach_anim_struct", "targetname");
  var_3 thread scripts\sp\anim::_id_1F35(level._id_6754, "pre_breach_loop");
  var_3 thread scripts\sp\anim::_id_1EC3(level._id_EA2C, "breach_enter_new");
  var_3 thread scripts\sp\anim::_id_1EC3(level._id_C47F, "breach_enter_new");
}

_id_C08D() {
  self endon("death");
  scripts\sp\utility::_id_54F7();
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F39F();
  scripts\engine\utility::flag_wait("interior_zg_end");
  scripts\sp\utility::_id_F415(0);
  scripts\sp\utility::_id_F416(0);
}

_id_E902() {
  scripts\sp\utility::_id_22CA("bridge_breach_enemies", ::_id_2FD8);
  scripts\sp\utility::_id_22CA("bridge_breach_enemies", ::_id_2F66);
  level._id_2F65 = scripts\sp\utility::_id_22CD("bridge_breach_enemies", 1);
  level._id_2FD7 thread scripts\sp\anim::_id_1EC1(level._id_2F65, "breach_react");
  level waittill("breach_anim_started");
  level._id_2FD7 thread scripts\sp\anim::_id_1F2C(level._id_2F65, "breach_react");
}

_id_2FD8() {
  self endon("death");
  self.dontmelee = 1;
  self.bt.cannotmelee = 1;
  scripts\sp\utility::_id_B14F(1);
  self.health = 10;
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F2A8(1);
  scripts\sp\utility::_id_86E4();
  self.noragdoll = 1;
  self.a.nodeath = 1;
  self._id_1FBB = self.script_noteworthy;
  scripts\sp\utility::_id_F416(1);
  self.team = "neutral";
  self.diequietly = 1;

  switch (self.script_noteworthy) {
    case "breach_captain":
      self._id_2F5F = 1;
      level._id_2F5C = self;
      self._id_193D = 1;
      break;
    case "breach_enemy_05":
      self._id_2F5F = 1;
      break;
    case "breach_enemy_07":
      self._id_2F5F = 1;
      break;
    default:
      self._id_51BE = 1;
      break;
  }

  scripts\engine\utility::flag_wait("player_started_elevator_scene");

  if(isDefined(self) && isalive(self)) {
    if(isDefined(self._id_438A))
      self._id_438A delete();

    self delete();
  }
}

_id_2F66() {
  level endon("moon_breach_ender");
  self endon("death");
  scripts\engine\utility::flag_wait("breach_detonation");
  wait 1.75;
  self _meth_847C();
  var_0 = getEnt("bridge_enemy_sphere_clip", "targetname");
  self._id_438A = spawn("script_model", (0, 0, 0));
  self._id_438A linkTo(self, "j_spinelower", (0, 0, 0), (0, 0, 0));
  self._id_438A clonebrushmodeltoscriptmodel(var_0);
  self._id_438A thread scripts\sp\maps\sa_moon\sa_moon_util::_id_51A1();
  var_1 = level._id_2FD7;

  if(self.script_noteworthy == "breach_enemy_05") {
    var_1 scripts\sp\anim::_id_1EC3(self, "breach_enter_new");
    scripts\engine\utility::flag_wait("interior_zg_begin");
    var_1 scripts\sp\anim::_id_1F35(self, "breach_enter_new");
  }

  if(self.script_noteworthy == "breach_captain") {
    var_1 scripts\sp\anim::_id_1EC3(self, "breach_enter_new");
    level._id_3A1E = scripts\sp\utility::_id_10639("keycard");
    var_1 scripts\sp\anim::_id_1EC3(level._id_3A1E, "breach_enter_new");
    scripts\engine\utility::flag_wait("interior_zg_begin");
    var_1 thread scripts\sp\anim::_id_1F35(level._id_3A1E, "breach_enter_new");
    var_1 scripts\sp\anim::_id_1F35(self, "breach_enter_new");
  }

  if(isDefined(self._id_2F5F)) {
    if(!scripts\engine\utility::flag("bridge_gravity_restoring") || !scripts\engine\utility::flag("bridge_gravity_restored")) {
      var_1 thread scripts\sp\anim::_id_1EEA(self, "breach_death_loop_new", self._id_1FBB + "stop_breach_death_loop");

      if(self.script_noteworthy == "breach_captain")
        var_1 thread scripts\sp\anim::_id_1EEA(level._id_3A1E, "breach_enter_loop", "keycard_stop_breach_loop");
    }
  } else {
    if(isDefined(self._id_B14F) && self._id_B14F)
      scripts\sp\utility::_id_1101B();

    if(isDefined(self._id_438A))
      self._id_438A delete();

    scripts\engine\utility::waitframe();
    self delete();
    return;
  }
}

_id_E8FF() {
  scripts\sp\utility::_id_22CA("bridge_breach_window_enemies", ::_id_4FB2);
  var_0 = scripts\sp\utility::_id_22CD("bridge_breach_window_enemies", 1);
}

_id_4FB2() {
  self.dontmelee = 1;
  self.bt.cannotmelee = 1;
  scripts\sp\utility::_id_B14F(1);
  self.health = 10;
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F2A8(1);
  scripts\sp\utility::_id_86E4();
  self.a.nodeath = 1;
  self._id_1FBB = self.script_noteworthy;
  scripts\sp\utility::_id_F416(1);
  self.team = "neutral";
  self.diequietly = 1;
  var_0 = scripts\engine\utility::getStruct("bridge_breach_anim_struct", "targetname");
  var_0 scripts\sp\anim::_id_1F35(self, "plant_breach_custom");

  if(isDefined(self._id_B14F) && self._id_B14F)
    scripts\sp\utility::_id_1101B();

  self delete();
}

_id_E965() {
  level endon("bridge_breach_anim_started");
  wait 0.5;
  level._id_EAFE scripts\sp\utility::_id_10346("mn_slt_our_infil");
  wait 0.5;
  level._id_C49F scripts\sp\utility::_id_10346("mn_omr_shields_up1");
  level.player scripts\sp\utility::_id_1034D("mn_plr_bridge_exterior");
  wait 1.0;
  scripts\sp\utility::_id_10350("mn_fer_copy_standing_by");

  if(!scripts\engine\utility::flag("bridge_breach_started"))
    level thread _id_E905();
}

_id_E90C() {
  scripts\engine\utility::flag_wait("bridge_breach_anim_started");

  while(!isDefined(level._id_6754))
    scripts\engine\utility::waitframe();

  level._id_6754 scripts\sp\utility::_id_10346("sa_moon_eth_illshortcircuitem");
}

_id_E905() {
  level endon("bridge_breach_started");
  wait 8.0;
  level._id_679E scripts\sp\utility::_id_10346("mn_eth_breachonyousir");
  wait 8.0;
  level._id_EAFE scripts\sp\utility::_id_10346("mn_slt_needtobreachbridge");
  wait 8.0;
  level._id_C49F scripts\sp\utility::_id_10346("mn_omr_opentincan");
}

_id_E906() {
  level endon("moon_breach_ender");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("obj_shutdown_primary_defenses", "current", &"SA_MOON_OBJ_SHUTDOWN_PRIMARY_DEFENSES", 1);
  level notify("objective_center_fade_obj_shutdown_primary_defenses");
  wait 0.05;
  var_0 = level._id_2F78 scripts\engine\utility::spawn_tag_origin();
  objective_position(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"), var_0.origin);
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"), &"SHIP_ASSAULT_OBJ_BREACH");
  _func_2E9(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"), 1);
  _func_2F7(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"), 0);
  level thread scripts\sp\maps\sa_moon\sa_moon_util::_id_119C1(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"), var_0.origin, 286225, "bridge_breach_started");
  scripts\engine\utility::flag_wait("bridge_breach_started");
  objective_state_nomessage(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"), "current");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_12DFB("obj_shutdown_primary_defenses", (0, 0, 0));
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"), "");
}

_id_E900() {
  self endon("death");
  self waittillmatch("single anim", "plant");
  playFXOnTag(scripts\engine\utility::getfx("vfx_sa_moon_breach_hack_plant"), self, "j_gun");
  self waittillmatch("single anim", "activate");
  playFXOnTag(scripts\engine\utility::getfx("vfx_sa_moon_breach_hack_warn"), self, "j_gun");
  self waittillmatch("single anim", "detonate");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_sa_moon_breach_hack_warn"), self, "j_gun");
  screenshake(level.player.origin, 0.75, 0.75, 0.75, 3.0, 0.0, 1.0, 800, 14, 14, 14);
  level._id_2F78 hide();
  scripts\engine\utility::exploder("vfx_bridge_breach");
  scripts\engine\utility::exploder("vfx_bridge_halon");
  scripts\engine\utility::exploder("vfx_amb_bridge");
  scripts\engine\utility::exploder("vfx_zg_bridge");
  scripts\engine\utility::flag_wait("player_breach_enter");
  level._id_2F78 delete();
}

_id_E966() {
  var_0 = getEntArray("bridge_window_cracks", "script_noteworthy");
  scripts\engine\utility::array_call(var_0, ::hide);
  var_1 = getEnt("bridge_console_cracks", "targetname");
  var_1 hide();
  level._id_30CB = scripts\sp\utility::_id_10639("bridge_window_shields");
  var_2 = scripts\engine\utility::getStruct("bridge_breach_anim_struct", "targetname");
  var_2 scripts\sp\anim::_id_1EC3(level._id_30CB, "breach_react");
}

_id_E90D() {
  scripts\engine\utility::flag_wait("raising_the_shields");
  wait 0.9;
  var_0 = getEnt("bridge_glass_shot_block", "targetname");
  var_0 delete();
  level._id_2FD7 thread scripts\sp\anim::_id_1F35(level._id_30CB, "breach_react");
  level thread _id_E974();
  scripts\engine\utility::flag_wait("breach_detonation");
  wait 1.85;
  var_1 = getEntArray("bridge_window_cracks", "script_noteworthy");
  scripts\engine\utility::array_call(var_1, ::show);
  level.player playRumbleOnEntity("mig_rumble");
}

_id_E974() {
  var_0 = "steady_rumble";
  var_1 = scripts\engine\utility::spawn_tag_origin(level._id_2F78.origin, level._id_2F78.angles);
  var_1 _meth_8244(var_0);
  wait 1.0;
  var_1 stoprumble(var_0);
  var_1 delete();
}

_id_E962() {
  var_0 = getEnt("bridge_window_player", "targetname");
  wait 1.75;
  var_0 setModel("sdf_bridge_window_break_01_static");
  wait 0.35;
  var_1 = getEnt("bridge_window_player_clip", "targetname");

  if(isDefined(var_1))
    var_1 notsolid();

  scripts\engine\utility::flag_wait("bridge_gravity_restoring");

  if(isDefined(var_1))
    var_1 solid();
}

_id_E8F7() {
  var_0 = getEnt("bridge_window_allies", "targetname");
  wait 1.75;
  var_0 setModel("sdf_bridge_window_break_02_static");
  var_1 = getEnt("bridge_window_allies_clip", "targetname");

  if(isDefined(var_1))
    var_1 notsolid();

  scripts\engine\utility::flag_wait("bridge_gravity_restoring");

  if(isDefined(var_1))
    var_1 solid();
}

_id_E90B() {
  setsaveddvar("bg_cinematicFullScreen", "0");
  wait 1;
  cinematicingameloop("moon_screen_working_v1");
  scripts\engine\utility::flag_wait("breach_detonation");
  wait 1.85;
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_30A9();
  cinematicingameloop("moon_screen_damaged_v1");
  var_0 = getEnt("bridge_console_cracks", "targetname");
  var_0 show();
  scripts\engine\utility::flag_wait_either("interior_zg_end", "moon_breach_ender");
  stopcinematicingame();
}

_id_E8FE() {
  var_0 = scripts\sp\utility::_id_10639("generic_prop_x3");
  var_0 hide();

  if(!isDefined(level._id_2FD7))
    level._id_2FD7 = scripts\engine\utility::getStruct("bridge_breach_anim_struct", "targetname");

  level._id_2FD7 scripts\sp\anim::_id_1EC3(var_0, "breach_debris");
  var_1 = spawn("script_model", var_0 gettagorigin("j_prop_1"));
  var_2 = spawn("script_model", var_0 gettagorigin("j_prop_2"));
  var_3 = spawn("script_model", var_0 gettagorigin("j_prop_3"));
  var_1.angles = var_0 gettagangles("j_prop_1");
  var_2.angles = var_0 gettagangles("j_prop_2");
  var_3.angles = var_0 gettagangles("j_prop_3");
  var_1 setModel("oxygen_tank_gascanister_01_zerog_to_gravity");
  var_2 setModel("captains_quarters_cabinet_03_sa_moon");
  var_3 setModel("weapon_ar57_wm");
  var_1 linkTo(var_0, "j_prop_1");
  var_2 linkTo(var_0, "j_prop_2");
  var_3 linkTo(var_0, "j_prop_3");
  var_1 hide();
  var_2 hide();
  var_3 hide();
  level waittill("breach_anim_started");
  var_1 show();
  var_2 show();
  var_3 show();
  level._id_2FD7 scripts\sp\anim::_id_1F35(var_0, "breach_debris");
  scripts\engine\utility::flag_wait("bridge_gravity_restored");
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_F423();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_0 delete();
}

_id_E907() {
  scripts\engine\utility::flag_wait("breach_detonation");
  wait 1.75;
  thread _id_CF9F();
  var_0 = getEntArray("bridge_dyn_models", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_linkto)) {
      var_3 = getEnt(var_2.script_linkto, "script_linkname");
      var_4 = var_3 scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
      var_4 thread _id_E908();
      wait 0.15;
      var_4 linkTo(var_2);
      var_3 delete();
    }

    if(isDefined(var_2.target)) {
      var_5 = scripts\engine\utility::getStruct(var_2.target, "targetname");
      var_2 moveTo(var_5.origin, 0.05);
      var_2 rotateTo(var_5.angles, 0.05);

      if(isDefined(var_5.script_noteworthy))
        var_2._id_BF0C = var_5.script_noteworthy;

      if(isDefined(var_5.script_angles))
        var_2._id_5CE1 = var_5.script_angles;

      wait 0.05;
    }

    var_2 thread _id_AA8A();
  }

  scripts\engine\utility::flag_wait("bridge_gravity_restored");
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  level._id_BF0D = [];

  foreach(var_2 in var_0)
  var_2 thread _id_4929();

  scripts\engine\utility::flag_wait("player_inside_maintenance_tunnel");
  level._id_BF0D = scripts\engine\utility::array_removeundefined(level._id_BF0D);
  scripts\sp\utility::_id_228A(level._id_BF0D);
}

_id_CF9F() {
  while(!scripts\engine\utility::flag("bridge_gravity_restored")) {
    physicsexplosionsphere(level.player getEye(), 34, 33, 8);
    wait 0.25;
  }
}

_id_E908() {
  wait 0.2;
  playFXOnTag(scripts\engine\utility::getfx("vfx_sa_moon_bridge_breach_extinguisher"), self, "tag_origin");
  scripts\engine\utility::flag_wait("bridge_gravity_restored");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_sa_moon_bridge_breach_extinguisher"), self, "tag_origin");
  scripts\engine\utility::flag_wait("player_inside_maintenance_tunnel");
  self delete();
}

_id_AA8A() {
  wait 0.05;
  var_0 = 1;

  if(isDefined(self.script_index))
    var_0 = self.script_index;

  var_1 = self.origin;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(self.script_angles)) {
    if(self.script_angles[0] != 0)
      var_2 = anglestoup(self.angles) * self.script_angles[0];

    if(self.script_angles[1] != 0)
      var_3 = anglesToForward(self.angles) * self.script_angles[1];

    if(self.script_angles[2] != 0)
      var_4 = anglestoright(self.angles) * self.script_angles[2];
  }

  if(isDefined(var_2))
    var_1 = var_1 + var_2;

  if(isDefined(var_3))
    var_1 = var_1 + var_3;

  if(isDefined(var_4))
    var_1 = var_1 + var_4;

  var_5 = var_1 + (0, 0, -24);

  if(isDefined(self.script_parameters)) {
    var_6 = strtok(self.script_parameters, " ");
    var_7 = float(var_6[0]);
    var_8 = float(var_6[1]);
    var_9 = float(var_6[2]);
    var_5 = self.origin + anglestoup(self.angles) * var_7 + anglesToForward(self.angles) * var_8 + anglestoright(self.angles) * var_9;
  }

  var_10 = vectorNormalize(var_5 - var_1);
  var_11 = (randomfloatrange(1.75, 3.25), 0, 0) * var_0;

  if(isDefined(self.script_noteworthy)) {
    var_12 = strtok(self.script_noteworthy, " ");
    var_13 = float(var_12[0]);
    var_14 = float(var_12[1]);
    var_15 = float(var_12[2]);
    var_11 = var_0 * var_10 * (var_13, var_14, var_15);
  }

  if(isDefined(self._id_EF20)) {
    if(self._id_EF20 == "wait_for_flag")
      scripts\engine\utility::flag_wait("breach_end");
  }

  if(isDefined(self._id_EF15))
    wait(self._id_EF15);

  self physicslaunchserver(var_1, var_11);
}

_id_4929() {
  self notsolid();
  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 setModel(self._id_BF0C);
  level._id_BF0D = scripts\engine\utility::add_to_array(level._id_BF0D, var_0);
  var_1 = 0;

  if(isDefined(self.script_delay))
    var_1 = self.script_delay;

  if(isDefined(self._id_EF20) && self._id_EF20 == "delete_me") {
    if(!level.player worldpointinreticle_circle(var_0.origin, 65, 650)) {
      self delete();
      var_0 delete();
      return;
    }
  }

  wait(var_1);
  var_2 = var_0 getpointinbounds(0, 0, 0);
  var_3 = var_2 + (0, 0, 24);
  var_4 = (0, 0, -50);

  if(isDefined(self._id_5CE1))
    var_4 = self._id_5CE1;

  self delete();
  var_0 _meth_841C(1, var_3, var_4);
}

#using_animtree("generic_human");

_id_E8FC() {
  level._id_EC85["breach_captain"]["breach_react"] = % sa_moon_bridge_breach_react_captain;
  level._id_EC85["breach_captain"]["grab_keycard"] = % sa_moon_bridge_breach_grab_keycard_captain;
  level._id_EC85["breach_captain"]["grab_keycard_loop"][0] = % sa_moon_bridge_breach_grab_keycard_captain_loop;
  level._id_EC85["breach_captain"]["breach_enter_new"] = % sa_moon_bridge_breach_enter_v2_captain;
  level._id_EC85["breach_captain"]["breach_death_loop_new"][0] = % sa_moon_bridge_gravity_captain_loop;
  level._id_EC85["breach_captain"]["gravity_restored"] = % sa_moon_bridge_gravity_captain;
  level._id_EC85["breach_captain"]["grab_captain_loop"][0] = % sa_moon_bridge_grab_captain_loop;
  level._id_EC85["breach_enemy_01"]["breach_react"] = % sa_moon_bridge_breach_react_enemy_01;
  level._id_EC85["breach_enemy_02"]["breach_react"] = % sa_moon_bridge_breach_react_enemy_02;
  level._id_EC85["breach_enemy_04"]["breach_react"] = % sa_moon_bridge_breach_react_enemy_04;
  level._id_EC85["breach_enemy_05"]["breach_react"] = % sa_moon_bridge_breach_react_enemy_05;
  level._id_EC85["breach_enemy_05"]["breach_enter_new"] = % sa_moon_bridge_breach_enter_v2_enemy5;
  level._id_EC85["breach_enemy_05"]["breach_death_loop_new"][0] = % sa_moon_bridge_gravity_enemy5_loop;
  level._id_EC85["breach_enemy_05"]["gravity_restored"] = % sa_moon_bridge_gravity_enemy5;
  level._id_EC85["breach_enemy_07"]["breach_react"] = % sa_moon_bridge_breach_react_enemy_07;
  level._id_EC85["breach_enemy_07"]["breach_death_loop_new"][0] = % sa_moon_bridge_gravity_enemy7_loop;
  level._id_EC85["breach_enemy_07"]["gravity_restored"] = % sa_moon_bridge_gravity_enemy7;
  level._id_EC85["breach_enemy_08"]["plant_breach_custom"] = % sa_moon_bridge_charge_plant_enemy1;
  level._id_EC85["breach_enemy_09"]["plant_breach_custom"] = % sa_moon_bridge_charge_plant_enemy2;
  level._id_EC85["breach_enemy_10"]["plant_breach_custom"] = % sa_moon_bridge_charge_plant_enemy3;
  level._id_EC85["omar"]["breach_enter_new"] = % sa_moon_bridge_breach_enter_v2_mco;
  level._id_EC85["omar"]["breach_enter_loop"][0] = % sa_moon_bridge_breach_enter_mco_loop;
  level._id_EC85["omar"]["gravity_restored"] = % sa_moon_bridge_gravity_mco;
  level._id_EC85["omar"]["elevator_down"] = % sa_moon_bridge_elevator_down_mco;
  level._id_EC85["salter"]["breach_enter_new"] = % sa_moon_bridge_breach_enter_v2_xo;
  level._id_EC85["salter"]["breach_enter_loop"][0] = % sa_moon_bridge_breach_enter_xo_loop;
  level._id_EC85["salter"]["gravity_restored"] = % sa_moon_bridge_gravity_xo;
  level._id_EC85["salter"]["elevator_down"] = % sa_moon_bridge_elevator_down_xo;
  level._id_EC85["ethan"]["pre_breach_loop"] = % sa_moon_bridge_breach_enter_v2_ethan_loop;
  level._id_EC85["ethan"]["breach_enter_new"] = % sa_moon_bridge_breach_enter_v2_ethan;
  level._id_EC85["ethan"]["breach_enter_loop"][0] = % sa_moon_bridge_breach_enter_ethan_loop;
  level._id_EC85["ethan"]["gravity_restored"] = % sa_moon_bridge_gravity_ethan;
  level._id_EC85["ethan"]["elevator_down"] = % sa_moon_bridge_elevator_down_ethan;
  scripts\sp\anim::_id_17FA("ethan", "gravity_on", "bridge_gravity_restored", "gravity_restored");
}

#using_animtree("player");

_id_E8FD() {
  level._id_EC87["player_arms"] = #animtree;
  level._id_EC8C["player_arms"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_arms"]["plant_breach_custom"] = % sa_moon_bridge_charge_plant_plr;
  level._id_EC85["player_arms"]["grab_keycard"] = % sa_moon_bridge_breach_grab_keycard_plr;
  level._id_EC85["player_arms"]["elevator_down"] = % sa_moon_bridge_elevator_down_plr;
}

#using_animtree("script_model");

_id_E8FB() {
  level._id_EC87["generic_prop_x3"] = #animtree;
  level._id_EC8C["generic_prop_x3"] = "generic_prop_x3";
  level._id_EC85["generic_prop_x3"]["elevator_down"] = % sa_moon_bridge_elevator_down_door_1;
  level._id_EC85["generic_prop_x3"]["breach_debris"] = % sa_moon_bridge_charge_plant_debris;
  level._id_EC87["bridge_window_shields"] = #animtree;
  level._id_EC8C["bridge_window_shields"] = "sdf_bridge_windows_rig";
  level._id_EC85["bridge_window_shields"]["breach_react"] = % sa_moon_bridge_breach_react_shades;
  level._id_EC85["bridge_window_shields"]["gravity_restored"] = % sa_moon_bridge_gravity_shades;
  level._id_EC87["breach_hotwire_box"] = #animtree;
  level._id_EC8C["breach_hotwire_box"] = "weapon_handheld_hacking_device_vm";
  level._id_EC85["breach_hotwire_box"]["plant_breach_custom"] = % sa_moon_bridge_charge_plant_charge;
  level._id_EC87["keycard"] = #animtree;
  level._id_EC8C["keycard"] = "sdf_captain_keycard_01";
  level._id_EC85["keycard"]["breach_enter_new"] = % sa_moon_bridge_breach_enter_v2_keycard;
  level._id_EC85["keycard"]["breach_enter_loop"][0] = % sa_moon_bridge_gravity_keycard_loop;
  level._id_EC85["keycard"]["gravity_restored"] = % sa_moon_bridge_gravity_keycard;
  level._id_EC85["keycard"]["gravity_restored_loop"][0] = % sa_moon_bridge_grab_keycard_loop;
  level._id_EC85["keycard"]["grab_keycard"] = % sa_moon_bridge_breach_grab_keycard_prop;
}