/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2037.gsc
*************************************************/

init() {
  precachemodel("uk_electrical_box_medium_02_animated");
  precachemodel("uk_storage_wall_light_01");
  precachemodel("uk_storage_wall_light_01_on");
  precachemodel("uk_industrial_light_01");
  precachemodel("uk_industrial_light_01_on");
  precachemodel("p7_lights_cagelight02");
  precachemodel("p7_lights_cagelight02_on");
  precachemodel("uk_lighting_interior_office_ceiling_tile_01");
  precachemodel("uk_lighting_interior_office_ceiling_tile_01_on");
  precachemodel("uk_industrial_light_01_runner_pm");
  precachemodel("uk_industrial_light_01_runner_pm_on");
  precachemodel("ind_flood_light_standing_tall");
  precachemodel("ind_flood_light_standing_tall_on");
  precachemodel("rogue_dormitory_lobby_ceiling_light_01");
  precachemodel("rogue_dormitory_lobby_ceiling_light_01_on");
  precachemodel("light_ceiling_bulb_02_spear_pm");
  precachemodel("light_ceiling_bulb_02_spear_pm_on");
  precachemodel("me_light_ceiling_fluorescent_tube_strong_runner_pm");
  precachemodel("me_light_ceiling_fluorescent_tube_strong_runner_pm_on");
  precachemodel("me_light_ceiling_fluorescent_tube_spear_pm");
  precachemodel("me_light_ceiling_fluorescent_tube_spear_pm_on");
  precachemodel("lighting_fixtures_security_lamp_withcage_01_spear_pm");
  precachemodel("lighting_fixtures_security_lamp_withcage_01_spear_pm_on");
  precachemodel("ee_light_mounted_exterior_industrial_caged_02_spear_pm");
  precachemodel("ee_light_mounted_exterior_industrial_caged_02_spear_pm_on");
  precachemodel("ee_light_mounted_exterior_industrial_caged_02_on_green_rnr_pm");
  precachemodel("building_cable_post_light_pole_off_spear_pm");
  precachemodel("building_cable_post_light_pole_on_spear_pm");
  precachemodel("ee_electronics_television_wall_mounted_large_runner_pm");
  precachemodel("ee_electronics_television_wall_mounted_large_runner_pm_on");
  level._effect["vfx_nvg_flare"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_nvg_flare.vfx");
  level._effect["vfx_nvg_flare_light_250"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_nvg_flare_light_250.vfx");
  thread _id_A1B9();
  _id_CDBE();
}

#using_animtree("script_model");

_id_CDBE() {
  level._id_CC34["lightswitch"] = #animtree;
  level._id_CC31["lightswitch"]["interact"] = % wm_eq_fusebox_plr;
  level._id_CC32["lightswitch"]["interact"] = "wm_eq_fusebox_plr";
  level._id_CC3B["lightswitch"]["interact"] = "eq_fusebox_plr";
  level._id_CC31["lightswitch"]["interact_on"] = % wm_eq_fusebox_turn_on_plr;
  level._id_CC32["lightswitch"]["interact_on"] = "wm_eq_fusebox_turn_on_plr";
  level._id_CC3B["lightswitch"]["interact_on"] = "eq_fusebox_turn_on_plr";
  level._id_CC34["switch"] = #animtree;
  level._id_CC31["switch"]["interact"] = % wm_eq_fusebox_prop;
  level._id_CC32["switch"]["interact"] = "wm_eq_fusebox_prop";
  level._id_CC31["switch"]["interact_on"] = % wm_eq_fusebox_turn_on_prop;
  level._id_CC32["switch"]["interact_on"] = "wm_eq_fusebox_turn_on_prop";
  level._id_838F = _func_0079(level._id_CC31["lightswitch"]["interact"]);
}

_id_A1B9() {
  wait 5;
  var_0 = getEntArray("md_volume", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\engine\utility::_id_67A9();
    var_2 thread _id_A1B7(var_3);
  }
}

_id_9496(var_0, var_1) {
  wait(var_0);

  if(self._id_00EC == "light") {
    if(!isDefined(self._id_CB4B)) {
      var_2 = 50;
    } else {
      var_2 = self._id_CB4B;
    }

    self _meth_8338(var_2 * 0.7);
    thread scripts\engine\utility::_id_B2DA("mp_lights_int_on", self.origin);
    wait 0.1;
    thread scripts\engine\utility::_id_B278("mp_lights_int_on_loop");
    self _meth_8338(var_2 * 0.1);
    wait 0.05;
    self _meth_8338(var_2 * 0.4);
    wait 0.1;
    self _meth_8338(var_2 * 0.2);
    wait 0.15;
    self _meth_8338(var_2);
  } else if(self._id_00EC == "scriptable")
    self setscriptablepartstate("light", "light_on");
}

_id_9495(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3._id_00EC == "light") {
      var_3 _meth_8338(0);
      var_3 thread scripts\engine\utility::_id_B2DA("mp_lights_int_off", var_3.origin);
      var_3 notify("stop soundmp_lights_int_on_loop");
      continue;
    }

    if(var_3._id_00EC == "scriptable") {
      var_3 setscriptablepartstate("light", "power_off");
    }
  }
}

_id_A1B7(var_0) {
  level endon("game_ended");
  var_1 = spawnStruct();
  var_1._id_0026 = undefined;
  var_1._id_9BA3 = [];
  var_1._id_949B = [];
  var_1._id_9FDF = [];
  var_1._id_A7BD = [];
  var_1._id_EC36 = "motion";
  var_1._id_94AE = 0;
  var_1._id_489E = 0;
  var_1._id_F60E = undefined;

  foreach(var_3 in var_0) {
    if(var_3._id_00EC == "light") {
      var_1._id_949B[var_1._id_949B.size] = var_3;
      continue;
    }

    if(isDefined(var_3._id_039B) && var_3._id_039B == "masterSwitch") {
      var_1._id_9BA3[var_1._id_9BA3.size] = var_3;
      continue;
    }

    if(var_3._id_00EC == "script_model" && !isDefined(var_3._id_CE18)) {
      var_1._id_9FDF[var_1._id_9FDF.size] = var_3;
      continue;
    }

    if(var_3._id_00EC == "script_origin") {
      var_1._id_A7BD[var_1._id_A7BD.size] = var_3;
      continue;
    }

    if(isDefined(var_3._id_CD99) && var_3._id_CD99 == "blinding_volume") {
      var_1._id_F60E = var_3;
    }
  }

  var_5 = getscriptablearray(self.target, "targetname");
  var_1._id_949B = scripts\engine\utility::array_combine(var_1._id_949B, var_5);

  foreach(var_7 in var_1._id_949B) {
    if(var_7._id_00EC == "light") {
      var_7._id_CB4B = var_7 _meth_8146();
      var_7 _meth_8338(0);
      continue;
    }

    if(var_7._id_00EC == "scriptable") {
      var_7 setscriptablepartstate("light", "power_off");
    }
  }

  foreach(var_10 in var_1._id_9BA3) {
    var_10 thread _id_CA4C(self, var_1);
  }

  foreach(var_13 in var_1._id_9FDF) {
    var_13.modelname = var_13.model;
  }

  if(scripts\mp\utility\game::getgametype() == "cyber") {
    if(!isDefined(level._id_51B5)) {
      level._id_51B5 = [];
    }

    level._id_51B5 = scripts\engine\utility::array_add(level._id_51B5, var_1);
    thread scripts\mp\gametypes\cyber::_id_51B6();
  }

  thread _id_AB46(var_1._id_9FDF, "off");
  thread _id_A1B8(var_1);

  for(;;) {
    if(var_1._id_EC36 == "on") {
      self notify("masterSwitch_on");

      if(!var_1._id_94AE) {
        thread _id_2578(var_1);

        foreach(var_7 in var_1._id_949B) {
          var_7 thread _id_9496(randomfloat(0.2), var_1._id_A7BD);
        }

        thread _id_AB46(var_1._id_9FDF, "on");
        var_1._id_94AE = 1;
      }
    } else if(var_1._id_EC36 == "motion") {
      if(var_1._id_489E && !var_1._id_94AE) {
        thread _id_2578(var_1);

        foreach(var_7 in var_1._id_949B) {
          var_7 thread _id_9496(randomfloat(0.2), var_1._id_A7BD);
          var_1._id_94AE = 1;
        }

        thread _id_AB46(var_1._id_9FDF, "on");
        thread _id_A1B6(var_1);
      }
    } else if(var_1._id_EC36 == "off") {
      if(var_1._id_94AE) {
        level _id_9495(var_1._id_949B, var_1._id_A7BD);
        thread _id_AB46(var_1._id_9FDF, "off");
        var_1._id_94AE = 0;
      }

      if(isDefined(self._id_CE18) && self._id_CE18 == "motion") {
        var_1._id_EC36 = "motion";
      }

      self notify("lights_off");
    }

    wait 0.05;
  }
}

_id_2578(var_0) {
  if(isDefined(var_0._id_F60E)) {
    wait 0.4;

    foreach(var_2 in level.players) {
      if(!isDefined(var_2) || !scripts\mp\utility\player::isreallyalive(var_2)) {
        continue;
      }
      if(var_2 istouching(var_0._id_F60E)) {
        var_2 _meth_8247();
        continue;
      }

      foreach(var_4 in var_0._id_949B) {
        if(distancesquared(var_4.origin, var_2.origin) > 230400) {
          continue;
        }
        if(!scripts\engine\utility::_id_10E76(var_2 getEye(), var_2 getplayerangles(), var_4.origin, 0.707106)) {
          continue;
        }
        var_5 = scripts\engine\trace::ray_trace(var_2 getEye(), var_4.origin, undefined, scripts\engine\trace::_id_3EF6(1));

        if(distancesquared(var_5["position"], var_4.origin) <= 324) {
          var_2 _meth_8247();
          break;
        }
      }
    }
  }
}

_id_A3D0(var_0) {
  level endon("game_ended");

  for(;;) {
    if(var_0._id_94AE == 0) {
      foreach(var_2 in level.players) {
        if(var_2 istouching(self)) {
          var_2 thread _id_9A28(self, var_0);
        }
      }
    }

    wait 0.1;
  }
}

_id_9A28(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(isDefined(self._id_7DF9)) {
    return;
  }
  scripts\mp\utility\perk::_id_6FC2("specialty_spygame");
  self._id_7DF9 = 1;

  while(self istouching(var_0) && var_1._id_94AE == 0) {
    wait 0.1;
  }

  scripts\mp\utility\perk::removeperk("specialty_spygame");
  self._id_7DF9 = undefined;
}

_id_A1B8(var_0) {
  level endon("game_ended");

  for(;;) {
    var_0._id_489E = 0;

    foreach(var_2 in level.players) {
      if(var_2 istouching(self)) {
        if(var_2 getstance() == "stand" && _func_0133(var_2 getvelocity()) > 40) {
          var_0._id_489E = 1;
          var_0._id_3D06 = 4;
        }

        if(var_0._id_94AE) {
          var_2._id_82CC = 1;
        }
      }
    }

    wait 0.05;
  }
}

_id_A1B6(var_0) {
  level endon("game_ended");
  self endon("lights_off");
  self endon("masterSwitch_on");

  if(isDefined(self._id_CE18) && self._id_CE18 == "motion") {
    while(var_0._id_3D06 > 0) {
      wait 0.1;
      var_0._id_3D06 = var_0._id_3D06 - 0.1;
    }
  }

  var_0._id_EC36 = "off";
}

_id_CA4C(var_0, var_1) {
  level endon("game_ended");
  var_2 = _id_400A(var_0, var_1);

  if(isDefined(var_2)) {
    var_2 thread _id_10BA5(var_1);
  }
}

_id_400A(var_0, var_1) {
  var_2 = spawn("script_model", self.origin, 40, 0, 60);
  var_2 setModel("uk_electrical_box_medium_02_animated");
  var_2.angles = self.angles;

  if(self._id_CE18 == "motion") {
    return;
  }
  var_3 = scripts\engine\utility::_id_67A9();

  foreach(var_5 in var_3) {
    if(var_5._id_00EC == "script_origin") {
      if(isDefined(var_5._id_039B) && var_5._id_039B == "sceneNode") {
        var_2._id_CBD0 = var_5;
      } else {
        var_2._id_798E = spawn("script_model", var_5.origin);
        var_2._id_798E.angles = var_5.angles;
        var_2._id_798E setModel(var_5._id_039B);
        var_2._id_798E.modelname = var_5._id_039B;
      }

      continue;
    }

    if(var_5._id_00EC == "light") {
      var_2._id_798C = var_5;
      continue;
    }
  }

  var_2 setuserange(80);
  var_2 _meth_84D4(200);
  var_2 setusefov(120);
  var_2 sethintdisplayfov(120);
  var_2 setcursorhint("HINT_BUTTON");

  if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
    var_2 sethintstring(&"MP/LIGHT_SWITCH");
    var_2 _meth_84DA("icon_electrical_box");
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_2 _meth_83A1(0);
    var_2 makeuseable();
  }

  if(isDefined(var_0._id_CE18) && var_0._id_CE18 == "motion") {
    var_1._id_EC36 = "motion";
  } else {
    var_1._id_EC36 = "off";
  }

  foreach(var_8 in level.players) {
    var_2 _meth_80E0(var_8);
  }

  if(isDefined(var_2._id_798E) && isDefined(var_2._id_798C)) {
    var_2._id_798D = var_2._id_798C _meth_8146();
    var_2 thread _id_9A32(var_1);
  }

  return var_2;
}

_id_10BA5(var_0) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(isDefined(var_0._id_EC36) && var_0._id_EC36 == "on") {
      playsoundatpos(self.origin, "mp_fusebox_lever_off_npc");
    } else {
      playsoundatpos(self.origin, "mp_fusebox_lever_on_npc");
    }

    thread _id_EC0B(_func_0079(level._id_CC31["lightswitch"]["interact"]) - 0.15, var_0);
    var_2 = _id_94C2(var_1, var_0);

    if(!var_2) {
      self notify("interactionCancelled");
    }
  }
}

_id_EC0B(var_0, var_1) {
  self endon("interactionCancelled");
  wait(var_0);

  if(var_1._id_EC36 == "motion" || var_1._id_EC36 == "off") {
    var_1._id_EC36 = "on";
    self notify("masterSwitch_on");
  } else
    var_1._id_EC36 = "off";
}

_id_9A32(var_0) {
  level endon("game_ended");

  for(;;) {
    if(var_0._id_EC36 == "on") {
      self._id_798C _meth_8338(0);
      self._id_798E setModel(self._id_798E.modelname);
    } else {
      self._id_798C _meth_8338(self._id_798D);
      self._id_798E setModel(self._id_798E.modelname + "_on");
    }

    waitframe();
  }
}

_id_6B0B(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_EC36) && var_2._id_EC36 == "on") {
      return "on";
    }
  }

  return "motion";
}

_id_AB46(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_1 == "on") {
      var_3 setModel(var_3.modelname + "_on");
      continue;
    }

    var_3 setModel(var_3.modelname);

    if(isDefined(var_3._id_5C52)) {
      var_3._id_5C52 delete();
    }
  }
}

_id_94C2(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1._id_EC36 == "on", "interact", "interact_on");
  var_3 = scripts\engine\utility::ter_op(var_1._id_EC36 == "on", "lights_on", "lights_off");
  level thread scripts\mp\battlechatter_mp::_id_F759(var_0, var_3);
  self._id_18AF = "switch";
  self useanimtree(#animtree);
  self._id_CBD0 thread _id_06C6::_id_1845(self, var_2);
  var_4 = _func_0079(level._id_CC31["lightswitch"][var_2]);
  wait(var_4);
  setDvar("#x3a581704564ef6d45", 0);
  self notify("interaction_complete");
  return 1;
}

_id_10BD6(var_0) {
  self endon("interaction_complete");
  self._id_315C = 0;

  for(;;) {
    if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      self._id_315C = 1;
      break;
    }

    waitframe();
  }
}

_id_3F5D(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0._id_18AF = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0._id_B5A4 = spawn("script_model", var_0.origin);
  var_0._id_B5A4 setModel(var_2);
  var_0._id_B5A4 hide();
  var_0._id_B5A4._id_18AF = var_1;
  var_0._id_B5A4 useanimtree(#animtree);
  var_0 playerlinktodelta(var_0._id_B5A4, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  var_0 _id_10A7E();
  _id_C436(var_0);
}

_id_C436(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0 unlink();
  var_1 = var_0 _meth_812D(var_0.origin);

  if(isDefined(var_1)) {
    var_0 setorigin(var_1);
  } else {
    var_0 setorigin(var_0.origin + (0, 0, 100));
  }

  var_0._id_B5A4 delete();
  var_0._id_B5A4 = undefined;
}

_id_10A7E(var_0) {
  scripts\engine\utility::waittill_any_2("remove_rig", "death_or_disconnect");
}