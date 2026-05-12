/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_carepackage.gsc
**************************************************/

func_00D5() {
  level.zombiekillstreaksenabled = 1;
  var_00 = getEntArray("care_package", "targetname");
  if(!isDefined(var_00) || var_00.size == 0) {
    return;
  }

  level.var_611["zmb_red_flare_idle"] = loadfx("vfx/map/mp_zombie_berlin/zmb_red_flare_idle");
  level thread lib_0526::func_52F6();
  level thread lib_0529::func_52F4();
  level.zombiecratecapturethink = ::zm_care_crate_capture_think;
  level.zombiecarepackageusefunc = ::zm_care_crate_capture;
  var_01 = common_scripts\utility::func_46B7("carepackage_dz", "targetname");
  var_02 = var_01;
  foreach(var_04 in var_01) {
    if(isDefined(var_04.var_165)) {
      var_02 = common_scripts\utility::func_F93(var_02, var_04);
    }
  }

  var_06 = common_scripts\utility::func_7A33(var_02);
  level.care_package_lz = var_06;
  level thread zm_care_flare_marker(level.care_package_lz);
}

zm_care_flare_marker(param_00) {
  lib_0547::func_A78B();
  var_01 = getgroundposition(param_00.var_116 + (0, 0, 50), 1);
  if(!isDefined(var_01)) {
    var_01 = param_00.var_116;
  }

  param_00.flare_model = spawn("script_model", var_01);
  param_00.flare_model setModel("npc_gen_fusee_flare");
  param_00.flare_model.var_1D = var_01 + (0, 0, 90);
}

zm_care_spawn_toggle_fx(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    var_03 = common_scripts\utility::func_46B7("carepackage_dz", "targetname");
    var_04 = [];
    foreach(var_06 in var_03) {
      if(distance2d(var_06.var_116, param_02.var_116) < 250) {
        var_04[var_04.size] = var_06;
      }
    }

    if(isDefined(param_02)) {
      param_01 = common_scripts\utility::func_4461(param_02.var_116, var_04);
    } else {
      param_01 = common_scripts\utility::func_7A33(var_03);
    }
  }

  if(!isDefined(param_01.flare_model)) {
    var_08 = getgroundposition(param_01.var_116 + (0, 0, 50), 1);
    if(!isDefined(var_08)) {
      var_08 = param_01.var_116;
    }

    param_01.flare_model = spawn("script_model", var_08);
    param_01.flare_model setModel("npc_gen_fusee_flare");
    param_01.flare_model.var_1D = var_08 + (0, 0, 90);
  }

  if(isDefined(param_01.flare_model)) {
    if(isDefined(param_01.var_3D34)) {
      param_01.var_3D34 delete();
    }

    if(common_scripts\utility::func_562E(param_00)) {
      param_01.var_3D34 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_red_flare_idle"), param_01.flare_model, "TAG_FX");
      triggerfx(param_01.var_3D34);
    }
  }
}

zm_care_spawn(param_00, param_01, param_02) {
  if(!common_scripts\utility::func_562E(param_02)) {
    zm_care_spawn_toggle_fx(1, param_01);
  }

  var_03 = lib_0527::func_4570();
  param_00 lib_0527::func_9302(param_00, [param_01.var_116], [var_03], "zm_carepackage", undefined, "zm");
  level thread zm_care_crush_listen();
  level notify("zombie_airdrop_inbound");
}

zm_care_crush_listen() {
  level notify("new_zm_care_crush_listen");
  level endon("new_zm_care_crush_listen");
  for(;;) {
    if(isDefined(level.all_drop_crates)) {
      foreach(var_01 in level.all_drop_crates) {
        if(isDefined(var_01) && isDefined(var_01.flag_wait) && !common_scripts\utility::func_562E(var_01.flag_wait.isonplayerwatch)) {
          var_01.flag_wait.isonplayerwatch = 1;
          var_01.flag_wait thread watch_for_player_damage(var_01);
        }

        var_01.var_A045 = ::unresolved_collision_nearest_node_carepackage;
      }
    }

    wait(0.5);
  }
}

watch_for_player_damage(param_00) {
  self waittill("damage");
  param_00 waittill("physics_impact");
  param_00 thread[[level.zombiecratecapturethink]](1);
  level.var_721C zm_care_crate_capture(param_00);
}

unresolved_collision_nearest_node_carepackage(param_00) {
  var_01 = 1;
  var_02 = 0;
  var_03 = 18;
  var_04 = self.var_116;
  for(;;) {
    var_05 = vectornormalize(anglesToForward((0, var_02, 0)));
    var_04 = self.var_116 + var_01 * var_03 * var_05;
    var_04 = getclosestpointonnavmesh(var_04);
    var_01++;
    var_02 = var_02 + 90;
    if(var_02 > 360) {
      var_02 = 0;
    }

    if(!canspawn(var_04)) {
      wait 0.05;
      continue;
    }

    if(positionwouldtelefrag(var_04)) {
      wait 0.05;
      continue;
    }

    break;
  }

  if(param_00 getstance() == "prone") {
    param_00 setstance("crouch");
  }

  param_00 setorigin(var_04);
}

zm_care_crate_capture(param_00) {
  var_01 = self;
  var_02 = param_00;
  level notify("zombies_crate_captured", var_01, var_02, param_00.var_116);
  param_00 lib_0529::func_2D30();
}

zm_care_crate_capture_think(param_00) {
  self endon("captured");
  level notify("zombie_airdrop_landed");
  zm_care_spawn_toggle_fx(0, undefined, self);
  if(common_scripts\utility::func_562E(param_00)) {
    return;
  }

  var_01 = common_scripts\utility::func_46B7("carepackage_dz", "targetname");
  var_02 = common_scripts\utility::func_4461(self.var_116, var_01, 250);
  self sethintstring(&"MP_CARE_PACKAGE_PICKUP");
  if(!self method_8562()) {
    self makeusable();
  } else if(isDefined(level.var_744A)) {
    foreach(var_04 in level.var_744A) {
      if(!self method_8691(var_04)) {
        self enableplayeruse(var_04);
      }
    }
  }

  if(isDefined(level.var_744A) && !common_scripts\utility::func_562E(var_02.no_crate_highlight)) {
    self hudoutlineenableforclients(level.var_744A, 2, 0);
  }

  while(isDefined(self)) {
    self waittill("trigger", var_06);
    thread zm_care_crate_attempt_capture(var_06);
  }
}

zm_care_crate_attempt_capture(param_00) {
  if(param_00 method_83B8()) {
    return;
  }

  if(!param_00 isonground() && !lib_0529::func_A7A0(param_00)) {
    return;
  }

  if(lib_0547::func_577E(param_00)) {
    return;
  }

  var_01 = 1000;
  param_00.var_56A1 = 1;
  var_02 = lib_0547::zmcreatesustainedholdent();
  var_03 = var_02 lib_0547::zmsustainedholdthink(param_00, var_01, ["captured"]);
  if(isDefined(var_02)) {
    var_02 delete();
  }

  if(isDefined(param_00)) {
    param_00.var_56A1 = 0;
  }

  if(!var_03) {
    param_00 notify("attemptCaptureEnd");
    return;
  }

  self notify("captured", param_00);
  wait(0.2);
  param_00 notify("attemptCaptureEnd");
}