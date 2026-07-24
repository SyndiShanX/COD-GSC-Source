/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_assassination\sa_assassination_infil.gsc
***********************************************************************/

_id_E7FF() {
  var_0 = scripts\engine\utility::getStruct("infil_anim_point", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_2 = scripts\sp\utility::_id_10639("roid_rig");
  var_1 scripts\sp\anim::_id_1EC3(var_2, "roid_intro", "tag_origin");
  var_3 = getEnt("intro_roid_02", "targetname");
  var_3._id_4348 = getEnt(var_3.target, "targetname");
  var_3._id_4348 linkTo(var_3);
  var_4 = getEnt("intro_roid_01", "targetname");
  var_4._id_4348 = getEnt(var_4.target, "targetname");
  var_4._id_4348 linkTo(var_4);
  var_3 linkTo(var_2, "j_prop_1", (0, 0, 0), (0, 0, 0));
  var_4 linkTo(var_2, "j_prop_2", (0, 0, 0), (0, 0, 0));
  scripts\engine\utility::waitframe();
  var_5 = scripts\sp\utility::_id_10639("player_rig");
  var_1 scripts\sp\anim::_id_1EC3(var_5, "intro_plr", "tag_origin");
  level.player _meth_823B(var_5, "tag_player");
  level._id_13EF6._id_1FBB = "salter";
  var_1 thread scripts\sp\anim::_id_1EC3(level._id_13EF6, "intro_xo", "tag_origin");
  var_1 thread scripts\sp\anim::_id_1EC3(var_5, "intro_plr", "tag_origin");
  var_1 thread scripts\sp\anim::_id_1EC3(var_2, "roid_intro", "tag_origin");
  wait 4;
  var_1 thread scripts\sp\anim::_id_1F35(level._id_13EF6, "intro_xo", "tag_origin");
  var_1 thread scripts\sp\anim::_id_1F35(var_5, "intro_plr", "tag_origin");
  var_1 thread scripts\sp\anim::_id_1F35(var_2, "roid_intro", "tag_origin");
  var_5 waittillmatch("single anim", "end");
  level._id_13EF6 unlink();
  level.player unlink();
  level.player freezecontrols(0);
  level.player enableweapons();
  scripts\engine\utility::waitframe();
  level.player switchtoweapon(level.player scripts\sp\utility::_id_7D74()[0]);
  var_5 delete();
  var_1 thread _id_C9B7(var_2);
  level._id_13EF6 thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_3C0C("salter_intro_path");

  if(!level.player scripts\sp\utility::_id_65DF("player_inside_ship"))
    level.player scripts\sp\utility::_id_65E0("player_inside_ship");

  while(!level.player scripts\sp\utility::_id_65DB("player_inside_ship"))
    wait 1;

  var_3 delete();
  var_4 delete();
  var_2 delete();
}

_id_C9B7(var_0) {
  var_0 waittillmatch("single anim", "end");
  scripts\sp\anim::_id_1EE0(var_0, "roid_intro", "tag_origin");
}

_id_EA4A() {
  var_0 = getnode("salter_bop_start", "targetname");
  var_1 = getnode(var_0.target, "targetname");
  level._id_13EF6 scripts\sp\utility::_id_F3D9(var_0);
  wait 3;
  level._id_13EF6 scripts\sp\utility::_id_F3D9(var_1);
}

_id_10668() {
  var_0 = scripts\sp\utility::_id_8200("cadre_destroyer", "targetname");
  level._id_A359 = scripts\sp\utility::_id_8200("jackal_swarm_spawner", "targetname");
  level._id_A35A = scripts\engine\utility::getStructArray("space_intro_sweep", "targetname");

  if(!isDefined(level._id_7477))
    level._id_7477 = [];

  var_1 = var_0 scripts\sp\utility::_id_7A97();

  foreach(var_3 in var_1) {
    while(isDefined(var_0._id_1323B))
      scripts\engine\utility::waitframe();

    var_0.origin = var_3.origin;
    var_0.angles = var_3.angles;
    var_4 = var_0 scripts\sp\utility::_id_10808();
    level._id_7477[level._id_7477.size] = var_4;
    var_5 = [];

    if(isDefined(var_3.target))
      var_5 = getcsplineidarray(var_3.target);

    if(var_5.size > 0)
      var_4 thread _id_5207(var_5);
  }
}

_id_7477() {
  var_0["destroyer"] = scripts\sp\utility::_id_8200("cadre_destroyer", "targetname");
  level._id_A35A = scripts\engine\utility::getStructArray("space_intro_sweep", "targetname");
  level._id_7477 = [];
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_395B();

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\sp\utility::_id_7A97();

    foreach(var_5 in var_3) {
      while(isDefined(var_2._id_1323B))
        scripts\engine\utility::waitframe();

      if(isDefined(var_5.script_delay)) {
        var_2 scripts\engine\utility::delaythread(var_5.script_delay, ::_id_749B, var_5, 0);
        continue;
      }

      var_2 _id_749B(var_5, 0);
    }
  }
}

_id_62CC() {
  if(isDefined(level._id_7477)) {
    foreach(var_1 in level._id_7477) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(var_1.classname == "script_vehicle_jackal_enemy") {
        var_1 delete();
        continue;
      }

      var_1 _id_0BA9::_id_397B();
    }
  }
}

_id_749B(var_0, var_1) {
  if(!var_1) {
    self dontinterpolate();
    self.origin = var_0.origin;

    if(isDefined(var_0.angles))
      self.angles = var_0.angles;
  }

  while(isDefined(self._id_1323B))
    scripts\engine\utility::waitframe();

  scripts\sp\utility::_id_1747(scripts\sp\maps\sa_assassination\sa_assassination_util::_id_F3C2, ::_id_74A3);
  self._id_ED7C = "off off";
  var_2 = _id_0BB8::_id_3990("idle", "idle", "high");
  level._id_7477[level._id_7477.size] = var_2;

  if(!var_1) {
    var_3 = [];

    if(isDefined(var_0.target))
      var_3 = getcsplineidarray(var_0.target);

    if(var_3.size > 0)
      var_2 thread _id_5207(var_3);

    if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "carrier")
      _id_5200();

    var_4 = spawn("script_origin", var_2.origin);
    var_4.angles = var_2.angles;
    var_2 linkTo(var_4);

    if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "frigate")
      var_4 moveTo(var_2.origin + anglesToForward(var_2.angles) * 32000, 120, 0, 30);
    else
      var_4 moveTo(var_2.origin + anglesToForward(var_2.angles) * 19000, 120, 0, 30);
  }

  return var_2;
}

_id_74A3() {
  visionsetnaked("sa_assassination_ftl", 0.1);
  wait 0.4;
  visionsetnaked("", 0.4);
}

_id_748E() {
  self._id_ED7C = "off off";
  var_0 = self.origin;
  self dontinterpolate();
  self.origin = self.origin + (-3000, 0, 0);
  scripts\sp\utility::_id_1747(scripts\sp\maps\sa_assassination\sa_assassination_util::_id_F3C2, ::_id_74A4);
  var_1 = _id_0BB8::_id_3990("idle", "idle", "high");
  level._id_2391 = var_1;
  level._id_7477[level._id_7477.size] = var_1;
  var_2 = getEntArray("ftl_destroyer_hatch", "targetname");

  foreach(var_4 in var_2) {
    var_4 dontinterpolate();
    var_4.origin = var_4.origin + (-3000, 0, 0);
    var_4 linkTo(var_1);
  }

  level._id_9ABA = getEntArray("sdf_ftl_light_01", "targetname");
  level._id_9ABA = scripts\engine\utility::array_combine(level._id_9ABA, getEntArray("sdf_ftl_light_02", "targetname"));
  level._id_9ABA = scripts\engine\utility::array_combine(level._id_9ABA, getEntArray("sdf_ftl_light_03", "targetname"));
  scripts\engine\utility::array_call(level._id_9ABA, ::setlightintensity, 0.001);
  var_1 thread _id_10738();
  var_6 = getEntArray("infil_thruster_hurt_trig", "targetname");

  foreach(var_4 in var_6) {
    var_4 enablelinkTo();
    var_4 linkTo(var_1);
  }

  var_9 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_1 linkTo(var_9, "tag_origin");
  var_9 moveTo(var_0, 8, 0, 8);
  var_9 waittill("movedone");
  scripts\engine\utility::array_thread(getEntArray("sdf_ftl_light_01", "targetname"), scripts\sp\maps\sa_assassination\sa_assassination_util::_id_AB84, 3.5, 40, 10);
  scripts\engine\utility::array_thread(getEntArray("sdf_ftl_light_02", "targetname"), scripts\sp\maps\sa_assassination\sa_assassination_util::_id_AB84, 3.5, 40, 5);
  scripts\engine\utility::array_thread(getEntArray("sdf_ftl_light_03", "targetname"), scripts\sp\maps\sa_assassination\sa_assassination_util::_id_AB84, 3.5, 40, 20);
  var_1 notsolid();
  level._id_91C1 = getEnt("intro_hull_grap_vol", "targetname");
  level._id_91C1 _id_0F31::_id_13544(1);
  scripts\engine\utility::flag_set("hatch_ready");
}

_id_10738() {
  var_0 = scripts\engine\utility::getStructArray("intro_hull_light_pts", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3.origin = var_3.origin + (-3000, 0, 0);
    var_4 = var_3 scripts\engine\utility::spawn_tag_origin();
    var_1[var_1.size] = var_4;
    var_4 linkTo(self);
    playFXOnTag(scripts\engine\utility::getfx("destroyer_hull_omni"), var_4, "tag_origin");
  }

  level.player waittill("player_inside_ship");

  foreach(var_4 in var_1) {
    stopFXOnTag(scripts\engine\utility::getfx("destroyer_hull_omni"), var_4, "tag_origin");
    var_4 delete();
  }
}

_id_74A4() {
  visionsetnaked("sa_assassination_ftl", 0.2);
  wait 0.5;
  visionsetnaked("", 0.4);
}

_id_5207(var_0) {
  foreach(var_2 in var_0) {
    while(isDefined(level._id_A359._id_1323B))
      scripts\engine\utility::waitframe();

    level._id_A359.origin = getcsplinepointposition(var_2, 0);
    var_3 = level._id_A359 scripts\sp\utility::_id_10808();
    var_3 thread _id_0BDC::_id_A1EF(var_2, undefined, 32);
    var_3 _id_0BDC::_id_19A2();
    level._id_7477[level._id_7477.size] = var_3;
  }
}

_id_5200() {
  var_0 = scripts\sp\utility::_id_8200("enemy_infil_dropship", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_7A97();

  foreach(var_3 in var_1) {
    var_4 = 0;
    wait 0.05;
    var_0 dontinterpolate();
    var_0.origin = var_3.origin;
    var_0.angles = var_3.angles;
    var_5 = var_0 scripts\sp\utility::_id_10808();

    while(isDefined(var_0._id_1323B))
      scripts\engine\utility::waitframe();

    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "raise")
      var_4 = 1;

    var_5 thread _id_AA70(var_3.target, var_4);
    level._id_7477[level._id_7477.size] = var_5;
  }
}

_id_AA70(var_0, var_1) {
  self endon("death");

  if(var_1) {
    var_2 = self.origin;
    self vehicle_teleport(self.origin - anglestoup(self.angles) * 300, self.angles);
    var_3 = scripts\engine\utility::spawn_tag_origin();
    self linkTo(var_3);
    var_3 moveTo(var_2, 1);
    var_3 waittill("movedone");
    self unlink();
    var_3 delete();
  }

  var_4 = getvehiclenode(var_0, "targetname");
  var_5 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(isDefined(var_5))
    thread scripts\sp\vehicle::_id_1321A(var_5, 1);
  else if(isDefined(var_4))
    thread scripts\sp\vehicle::_id_1321A(var_4);

  scripts\sp\vehicle_paths::_id_845A(self);
  self waittill("reached_dynamic_path_end");
  self notify("delete");
  self delete();
}

_id_5201() {
  var_0 = getcsplineidarray("jackal_spotlight_spline");

  foreach(var_2 in var_0) {
    while(isDefined(level._id_A359._id_1323B))
      scripts\engine\utility::waitframe();

    level._id_A359.origin = getcsplinepointposition(var_2, 0);
    var_3 = level._id_A359 scripts\sp\utility::_id_10808();
    var_3 thread _id_0BDC::_id_A1EF(var_2, undefined, 32);
    var_3 thread _id_0F0F::_id_E801(level._id_A35A);
    var_3 thread _id_5162();
  }
}

_id_5162() {
  self waittill("end_spline");
  self delete();
}

_id_6AE4() {
  level endon("kill_fake_destroyer_velocity");
  var_0 = scripts\engine\utility::getStruct("hatch_panel_before", "targetname");

  for(;;) {
    var_1 = level.player getvelocity();
    var_2 = distance(level.player.origin, var_0.origin);

    if(var_1[0] > -100 && var_2 > 512)
      level.player setvelocity(var_1 + (-10, 0, 0));

    scripts\engine\utility::waitframe();
  }
}

_id_949D() {
  var_0 = scripts\engine\utility::getStruct("infiltrate_destroyer_objective", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, (0, 0, 0));
  objective_add(scripts\sp\utility::_id_C264("infil_destroyer"), "current", &"SA_ASSASSINATION_ENTER_SDF_GALAXIUS", var_1.origin);
  _id_0F16::_id_C278(scripts\sp\utility::_id_C264("infil_destroyer"));

  while(!scripts\engine\utility::flag("hatch_used"))
    wait 0.2;

  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("infil_destroyer"));
}

_id_944C() {
  level endon("kill_infil_door_nag");

  for(;;) {
    wait 13;
    level._id_13EF6 scripts\sp\utility::_id_10346("asn_slt_openitreyes");
  }
}

_id_1F77() {
  var_0 = scripts\engine\utility::getStruct("hatch_panel_before", "targetname");
  var_1 = scripts\engine\utility::getStruct("hatch_panel_after", "targetname");
  var_2 = scripts\sp\utility::_id_10639("keel_doors", var_1.origin, var_1.angles);
  var_2._id_1FBB = "keel_doors";
  var_3 = getEnt("keel_door_left_2", "targetname");
  var_4 = getEnt("keel_door_right_2", "targetname");
  var_3 linkTo(var_2, "j_prop_1", (0, 0, 0), (0, 0, 0));
  var_4 linkTo(var_2, "j_prop_2", (0, 0, 0), (0, 0, 0));
  var_5 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_6 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_7 = getspawner("salter_interior_start", "targetname");
  level._id_EA2C = var_7 scripts\sp\utility::_id_10619(1, 1);
  level._id_EA2C._id_1FBB = "salter";
  level._id_EA2C _id_0F16::isfirstarmageddonmeteorhit("iw7_crb", "primary");
  var_6 thread scripts\sp\anim::_id_1EC3(level._id_EA2C, "keel_walk_xo_start");
  level._id_EA2C hide();
  level.player _meth_84FE();
  level.player freezecontrols(1);
  var_8 = scripts\sp\utility::_id_10639("player_rig");
  var_9 = scripts\sp\utility::_id_10639("hacking_device");
  var_9._id_1FBB = "hacking_device";
  var_8 hide();
  var_9 hide();
  var_8 linkTo(var_5, "tag_origin");
  var_9 linkTo(var_5, "tag_origin");
  var_5 thread scripts\sp\anim::_id_1EC3(var_8, "keel_enter_plr_start");
  var_5 thread scripts\sp\anim::_id_1EC3(var_9, "keel_enter_device_start");
  var_10 = 1;
  level.player _meth_823C(var_8, "tag_player", var_10, 0.3, 0.3);
  var_8 scripts\engine\utility::delaycall(var_10, ::show);
  var_9 scripts\engine\utility::delaycall(var_10, ::show);
  level scripts\engine\utility::delaythread(var_10, _id_0F35::_id_FB24, 0, level.player);
  thread salter_start_keel_anim(var_10, var_5, var_0);
  scripts\engine\utility::trigger_off("player_in_gravity_trigger", "targetname");
  level.player scripts\sp\utility::_id_D090("ges_sa_assassin_keel_enter_start");
  var_5 thread scripts\sp\anim::_id_1F35(var_8, "keel_enter_plr_start");
  var_6 thread scripts\sp\anim::_id_1F35(var_2, "keel_open");
  var_5 thread scripts\sp\anim::_id_1F35(var_9, "keel_enter_device_start");
  var_2 thread _id_6AA0();
  level._id_13EF6 thread scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_759F();
  thread _id_8798(1.5);
  wait(var_10);
  var_5 _meth_83BA(var_5, var_6);
  teleportscene();
  wait 9;
  level.player _meth_84FD();
  level notify("close_keel_doors");
  var_8 waittillmatch("single anim", "end");
  level._id_13EF6 scripts\sp\utility::_id_1101B();
  level._id_13EF6 delete();
  level._id_EA2C show();
  thread _id_EAF6();
  level._id_3965 notsolid();
  level.player dontinterpolate();
  level.player unlink();
  level.player freezecontrols(0);
  var_9 delete();
  var_8 delete();
  var_3 unlink();
  var_4 unlink();
  var_2 delete();
  level._id_EA2C dontinterpolate();
  scripts\engine\utility::waitframe();
  thread _id_D872();
  level._id_EA2C scripts\sp\utility::_id_DC45("raise");
  level.player scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_DC45, "raise");
  thread sfx_context_visor_up();
  scripts\engine\utility::flag_set("player_in_gravity");
}

sfx_context_visor_up() {
  wait 3;
  setglobalsoundcontext("atmosphere", "", 0.5);
}

salter_start_keel_anim(var_0, var_1, var_2) {
  wait(var_0);
  level._id_13EF6._id_1FBB = "salter";
  level._id_13EF6 dontinterpolate();
  level._id_13EF6 linkTo(var_1, "tag_origin");
  var_1 scripts\sp\anim::_id_1F35(level._id_13EF6, "keel_enter_xo_start");
}

_id_6AA0() {
  self waittillmatch("single anim", "lights_out");
  scripts\engine\utility::array_thread(level._id_9ABA, scripts\sp\maps\sa_assassination\sa_assassination_util::_id_AB84, 3.5, 40, 0.001);
}

_id_16BE() {
  self waittillmatch("single anim", "look_start");
  level.player dontinterpolate();
}

_id_8798(var_0) {
  wait(var_0);
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("Hacking_Device_v1");
}

_id_A5ED() {
  var_0 = [];
  var_0[var_0.size] = "tag_fx_back";
  var_0[var_0.size] = "tag_fx_left";
  var_0[var_0.size] = "tag_fx_right";
  var_0[var_0.size] = "tag_fx_bottom";
  var_0[var_0.size] = "tag_fx_top";

  foreach(var_2 in var_0) {
    stopFXOnTag(scripts\engine\utility::getfx("zerog_jetpack_thruster_large_allies"), self, var_2);
    stopFXOnTag(scripts\engine\utility::getfx("zerog_jetpack_thruster_small_allies"), self, var_2);
    stopFXOnTag(scripts\engine\utility::getfx("zerog_jetpack_thruster_idle_allies"), self, var_2);
    stopFXOnTag(scripts\engine\utility::getfx("zerog_jetpack_thruster_idle_light_allies"), self, var_2);
  }

  level._id_13EEA = ::_id_C1D2;
  level._id_13EEB = ::_id_C1D2;
}

_id_C1D2() {}

_id_E2C6() {}

_id_D853() {
  level._id_A569 = undefined;
}

_id_EAF6() {
  scripts\engine\utility::trigger_off("trig_gas_handoff", "targetname");
  var_0 = scripts\engine\utility::getStruct("hatch_panel_after", "targetname");
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "keel_walk_xo_start");
  var_1 = scripts\sp\utility::_id_10639("keel_bomb");
  var_1._id_1FBB = "keel_bomb";
  var_1 hide();

  if(!scripts\engine\utility::flag("flag_keel_salter_cont")) {
    var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "keel_walk_xo_loop_wait", "end_loop");
    scripts\engine\utility::flag_wait("flag_keel_salter_cont");
    var_0 notify("end_loop");
  }

  var_2 = [];
  var_2[var_2.size] = level._id_EA2C;
  var_2[var_2.size] = var_1;
  thread _id_100DE(var_1);
  var_0 scripts\sp\anim::_id_1F2C(var_2, "keel_walk_xo_cont");
  var_0 thread scripts\sp\anim::_id_1EE7(var_2, "keel_walk_xo_loop_gas", "end_loop");
  thread _id_76B6();
  thread _id_88F8(var_1);
  scripts\engine\utility::flag_wait("flag_gas_cursor_triggered");
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_8479();
  level notify("player_getting_gas");
  thread _id_8898();
  _id_76B5(var_1);
}

_id_88F8(var_0) {
  level endon("destroy_gas_cursor_hint_thread");
  var_1 = 0;

  for(;;) {
    if(scripts\engine\utility::flag("flag_gas_cursor_hint") && !var_1) {
      var_0 _id_0E46::_id_48C4(undefined, undefined, undefined, 15, 200, 75, 0, 0, 0, undefined, 0, 0, undefined, 1);
      var_1 = 1;
      setsaveddvar("cursorHintControlLockSnapVelocity", 1);
      thread _id_76AB(var_0);
    }

    if(!scripts\engine\utility::flag("flag_gas_cursor_hint") && var_1) {
      var_0 _id_0E46::_id_DFE3();
      level notify("destroy_gas_cursor_hint");
      setsaveddvar("cursorHintControlLockSnapVelocity", 0);
      var_1 = 0;
    }

    wait 0.25;
  }
}

_id_76AB(var_0) {
  level endon("destroy_gas_cursor_hint");
  var_0 _id_0E46::_id_9016();
  scripts\engine\utility::flag_set("flag_gas_cursor_triggered");
  setsaveddvar("cursorHintControlLockSnapVelocity", 0);
  level notify("destroy_gas_cursor_hint_thread");
}

_id_100DE(var_0) {
  scripts\engine\utility::flag_wait("flag_bomb_grab");
  var_0 show();
  var_0 hidepart("tag_enabled", "weapon_gas_bomb_vm");
  var_0 hidepart("tag_armed", "weapon_gas_bomb_vm");
}

_id_A562(var_0, var_1) {
  level._id_EA2C _meth_82B1(var_0, var_1);
}

_id_8898() {
  wait 0.5;
  wait 3;
  wait 0.5;
  level._id_EA2C scripts\sp\utility::_id_10346("asn_slt_thisisit");
  wait 0.25;
  level._id_EA2C scripts\sp\utility::_id_10346("asn_slt_illpatchinandget");
  wait 0.2;
  level.player scripts\sp\utility::_id_1034D("asn_plr_rogillcheckin");
  scripts\engine\utility::flag_set("flag_being_barracks_objectives");
  waitforalltransients();
  scripts\engine\utility::flag_wait_all("sa_assassination_destroyer_int_tr_loaded", "sa_assassination_base_tr_loaded", "flag_spawn_doorpeek_enemy");
  thread scripts\sp\utility::_id_10350("asn_slt_hudtrackingdata");
  getEnt("peek_door_grenade_blocker", "targetname") delete();
  thread _id_0B1E::_id_59BE("bulkheadsdf_left");
}

_id_76B5(var_0) {
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_D85C();
  var_1 = spawnStruct();
  var_1.pos = scripts\engine\utility::getStruct("hatch_panel_after", "targetname");
  var_1._id_D267 = scripts\sp\utility::_id_10639("player_rig", var_1.pos.origin, var_1.pos.angles);
  var_1._id_D267 hide();
  var_1._id_D267._id_1FBB = "player_rig";
  var_1._id_EA2C = level._id_EA2C;
  var_1._id_EA2C._id_1FBB = "salter";
  var_1._id_1684 = [];
  var_1._id_1684[var_1._id_1684.size] = var_1._id_D267;
  var_1._id_1684[var_1._id_1684.size] = var_1._id_EA2C;
  var_1._id_1684[var_1._id_1684.size] = var_0;
  var_1.pos scripts\sp\anim::_id_1EC3(var_1._id_D267, "keel_handoff");
  level.player playerlinkTo(var_1._id_D267, "tag_player");
  level.player _meth_823C(var_1._id_D267, "tag_player", 0.5, 0.25);
  wait 0.5;
  level.player playerlinktodelta(var_1._id_D267, "tag_player", 1, 25, 20, 15, 0, 1);
  var_1._id_D267 show();
  var_1.pos notify("end_loop");
  var_1.pos scripts\sp\anim::_id_1F2C(var_1._id_1684, "keel_handoff");
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_DF3E();
  var_0 scripts\sp\maps\sa_assassination\sa_assassination_int::_id_12956();
  var_1._id_D267 delete();
  var_0 delete();
  thread _id_1296A();
  scripts\engine\utility::flag_set("flag_got_gas_device");
  var_1._id_EA2C waittillmatch("single anim", "end");
  var_1.pos thread scripts\sp\anim::_id_1EEA(var_1._id_EA2C, "keel_walk_xo_hack_loop");
}

_id_1296A() {
  var_0 = getEntArray("salt_light", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

_id_76B6() {
  level endon("player_getting_gas");
  wait 7;
  level._id_EA2C thread scripts\sp\utility::_id_10346("asn_slt_takethegasreyes");
  wait 12;
  level._id_EA2C thread scripts\sp\utility::_id_10346("asn_slt_takethegasreyes");
  wait 17;
  level._id_EA2C thread scripts\sp\utility::_id_10346("asn_slt_takethegasreyes");
}

_id_5569() {
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player scripts\engine\utility::allow_ads(0);
  level.player allowfire(0);
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
}

_id_6229() {
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level.player scripts\engine\utility::allow_ads(1);
  level.player allowfire(1);
  level.player allowsprint(1);
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
}

_id_EA63() {
  var_0 = scripts\engine\utility::getStruct("salter_keel_entry", "targetname");
  var_1 = level._id_EA2C scripts\engine\utility::spawn_tag_origin();
  level._id_EA2C linkTo(var_1);
  var_1 moveTo(var_0.origin, 1.5, 0.5, 0.5);
  var_1 rotateTo(var_0.angles, 1.5, 0.5, 0.5);
  var_1 waittill("movedone");
  var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_1 moveTo(var_0.origin, 1.5, 0.5, 0.5);
  var_1 rotateTo(var_0.angles, 1.5, 0.5, 0.5);
  var_1 waittill("movedone");
  wait 2;
  level._id_EA2C unlink();
  level._id_EA2C setgoalpos(level._id_EA2C.origin);
}

_id_8E88() {
  level._id_8C40 = getEntArray("ftl_destroyer_hatch", "targetname");

  foreach(var_1 in level._id_8C40) {
    var_1 hide();
    var_1 notsolid();
  }
}

_id_100E2() {
  foreach(var_1 in level._id_8C40) {
    var_1 show();
    var_1 solid();
    var_1 thread asteroid_cleanup();
  }
}

_id_15B2() {
  var_0 = undefined;
  var_0 = scripts\engine\utility::getStruct("ftl_destroyer_panel", "script_noteworthy");

  while(!scripts\engine\utility::flag("hatch_ready"))
    wait 0.5;

  var_0 _id_0E46::_id_48C4(undefined, (0, 0, 0), &"sa_assassination_open_hatch", undefined, 650, 156, 1);
  var_0 thread _id_8C41();
}

_id_8C41() {
  self waittill("trigger");
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_949E();
  scripts\engine\utility::flag_set("hatch_used");
  _id_0E46::_id_DFE3();
}

_id_C604() {
  level._id_A563 = getEnt("door_left", "targetname");
  level._id_A564 = getEnt("door_right", "targetname");
  level._id_A563 rotateby((0, 0, -45), 1, 0, 0.3);
  level._id_A564 rotateby((0, 0, 45), 1, 0, 0.3);
  level waittill("close_keel_doors");
  level._id_A563 rotateby((0, 0, 45), 1, 0, 0.3);
  level._id_A564 rotateby((0, 0, -45), 1, 0, 0.3);
}

_id_4270() {}

_id_C605() {
  var_0 = getEnt("door_left", "targetname");
  var_1 = getEnt("door_right", "targetname");
  var_0 movey(-68, 1);
  var_1 movey(68, 1);
}

_id_4271() {
  var_0 = getEnt("door_left", "targetname");
  var_1 = getEnt("door_right", "targetname");
  var_0 movey(68, 1);
  var_1 movey(-68, 1);
  var_0 waittill("movedone");
}

_id_4F6D() {
  if(!level.player scripts\sp\utility::_id_65DF("player_inside_ship"))
    level.player scripts\sp\utility::_id_65E0("player_inside_ship");

  level.player scripts\sp\utility::_id_65E1("player_inside_ship");

  if(isDefined(level._id_3965) && !level._id_3965 scripts\sp\utility::_id_65DF("player_inside_ship"))
    level._id_3965 scripts\sp\utility::_id_65E0("player_inside_ship");

  level._id_3965 scripts\sp\utility::_id_65E1("player_inside_ship");
}

_id_9648() {
  var_0 = scripts\engine\utility::getStruct("keel_strobe", "targetname");
  level._id_A56A = var_0 scripts\engine\utility::spawn_tag_origin();
  level._id_A56A.lights = getEntArray(var_0.target, "targetname");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy)) {
      if(var_3.script_noteworthy == "start")
        level._id_A56A.start = var_3;

      if(var_3.script_noteworthy == "end")
        level._id_A56A.end = var_3;
    }
  }

  scripts\engine\utility::array_call(level._id_A56A.lights, ::linkto, level._id_A56A);
  level._id_A56A.start linkTo(level._id_A56A);
  level._id_A56A.end linkTo(level._id_A56A);
  scripts\engine\utility::array_call(level._id_A56A.lights, ::setlightintensity, 0);
}

_id_E803() {
  foreach(var_1 in self)
  var_1.origin = var_1._id_C73A + self.start - self.origin;
}

_id_DC97() {
  self endon("death");
  var_0 = (randomint(10), randomint(10), randomint(10));

  for(;;) {
    self rotateby(var_0, 2, 0, 0);
    self waittill("movedone");
  }
}

_id_23F2() {
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var_1 = undefined;
  var_2 = [];
  var_3 = undefined;
  var_4 = 9;

  foreach(var_6 in var_0) {
    if(isDefined(var_6.script_noteworthy)) {
      if(var_6.script_noteworthy == "shock_fx") {
        var_1 = var_6 scripts\engine\utility::spawn_tag_origin();
        var_1 linkTo(self);
      }

      if(var_6.script_noteworthy == "blowoff_fx")
        var_2[var_2.size] = var_6 scripts\engine\utility::spawn_tag_origin();

      if(var_6.script_noteworthy == "move_dest")
        var_3 = var_6;
    }
  }

  level waittill("asteroid_shock");

  if(isDefined(var_1)) {
    playFXOnTag(scripts\engine\utility::getfx("ftl_shockwave_dust"), var_1, "tag_origin");
    var_1 thread _id_50B2(3);
  }

  foreach(var_9 in var_2) {
    playFXOnTag(scripts\engine\utility::getfx("ftl_dust_blowoff"), var_9, "tag_origin");

    if(isDefined(var_3))
      var_9 moveTo(var_3.origin, var_4, 0, var_4);

    var_9 thread _id_50B2(4);
  }

  if(isDefined(var_3)) {
    self moveTo(var_3.origin, var_4, 0, var_4);
    self rotateTo(var_3.angles, var_4, 0, var_4);
  }
}

asteroid_cleanup() {
  level.player waittill("player_inside_ship");
  self delete();
}

_id_E7DB() {
  level._id_20EA = getEntArray("approach_asteroid", "targetname");
  scripts\engine\utility::array_thread(level._id_20EA, ::_id_B038);
  level waittill("close_keel_doors");
  scripts\sp\utility::_id_228A(level._id_20EA);
}

_id_B038() {
  self endon("death");
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_1 = self.origin;
  var_2 = var_0.origin;
  wait(randomfloat(9));

  for(;;) {
    self.origin = var_1 + scripts\engine\utility::randomvector(2000);
    self moveTo(var_2 + scripts\engine\utility::randomvector(2000), 9 + randomfloat(2), 0, 0);
    self waittill("movedone");
  }
}

_id_7485() {
  var_0 = scripts\engine\utility::spawn_tag_origin(level.player.origin - (300, 0, 0), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("ftl_player_gust"), var_0, "tag_origin");
  wait 3;
  var_0 delete();
}

_id_74A2() {
  level.player setvelocity(level.player getvelocity() + (200, 0, -35));
}

_id_50B2(var_0) {
  wait(var_0);
  self delete();
}

_id_95ED() {
  level._id_748A = getEnt("intro_ftl_spotlight", "targetname");
  level._id_748A setlightintensity(0);
}

_id_74A0() {
  level._id_748A setlightintensity(3000);
  wait 0.1;
  level._id_748A setlightintensity(10000);
  wait 0.3;
  level._id_748A setlightintensity(3000);
  wait 0.1;
  level._id_748A setlightintensity(0);
  level._id_748A delete();
}

_id_E02D() {
  var_0 = getEnt("intro_ftl_spotlight", "targetname");
  var_0 delete();
}

_id_D872() {
  var_0 = scripts\engine\utility::getStructArray("keel_pressure_fx", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\utility::spawn_tag_origin();
    playFXOnTag(scripts\engine\utility::getfx("breach_wind"), var_4, "tag_origin");
    var_1[var_1.size] = var_4;
  }

  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_D871();
  scripts\sp\utility::_id_228A(var_1);
}

_id_737A(var_0) {
  self freezecontrols(var_0);
}

_id_50F0() {
  wait 1;
  loadtransient("sa_assassination_destroyer_ext_tr");
  loadtransient("sa_assassination_destroyer_keel_tr");
}

_id_91C2() {}