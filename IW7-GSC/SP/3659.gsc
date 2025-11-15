/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3659.gsc
************************/

func_10730(param_00, param_01, param_02) {
  var_03 = spawn("script_model", level.player.origin);
  if(isDefined(param_00)) {
    var_03 setModel(param_00);
  } else if(isDefined(level.var_8E10) && level.var_8E10 == "none") {
    return undefined;
  } else if(isDefined(level.var_8E10)) {
    var_03 setModel(level.var_8E10);
  } else {
    var_03 setModel("hero_jackal_helmet_a");
  }

  var_03 glinton(#animtree);
  if(isDefined(param_01)) {
    var_03 linkto(param_01, param_02, (0, 0, 0), (0, 0, 0));
  } else if(self != level && self != level.player && isDefined(self.model)) {
    var_03 linkto(self, "tag_playerhelmet", (0, 0, 0), (0, 0, 0));
  }

  if(!isDefined(level.player.helmet)) {
    level.player.helmet = var_03;
  }

  return var_03;
}

func_1072F(param_00) {
  var_01 = spawn("script_model", level.player.origin);
  if(isDefined(param_00)) {
    var_01 setModel(param_00);
  } else if(isDefined(level.var_8E0E)) {
    var_01 setModel(level.var_8E0E);
  } else {
    var_01 setModel("vm_hero_protagonist_helmet");
  }

  var_01 glinton(#animtree);
  level.player.helmet = var_01;
  return var_01;
}

func_8E06(param_00) {
  if(scripts\sp\utility::func_93A6() && level.var_10964.ignorehelmetfuncs) {
    return;
  }

  if(!isDefined(level.player.helmet)) {
    level.player.helmet = func_1072F();
  }

  level.player.helmet _meth_81E2(level.player, "tag_playerhelmet", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
  level.player.helmet.var_13487 = "down";
  if(isDefined(param_00) && param_00) {
    thread func_1348D(1);
    return;
  }

  scripts\engine\utility::delaythread(0, ::helmethud_on);
}

func_8E04(param_00) {
  if(scripts\sp\utility::func_93A6() && level.var_10964.ignorehelmetfuncs) {
    return;
  }

  level.player.helmet _meth_83CB(level.player);
  if(!isDefined(param_00) || !param_00) {
    level.player.helmet delete();
  }
}

func_1348D(param_00, param_01) {
  if(scripts\sp\utility::func_93A6() && level.var_10964.ignorehelmetfuncs) {
    return;
  }

  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(level.player.helmet.var_13487 == "up") {
    return;
  }

  if(level.player scripts\sp\utility::func_65DB("visor_active")) {
    return;
  }

  level.player scripts\sp\utility::func_65E1("visor_active");
  level.player notify("putting_visor_up");
  if(!param_00) {
    func_D5DF(0);
    scripts\engine\utility::delaythread(0.2, ::helmethud_off);
    thread func_8DE2();
  } else {
    scripts\engine\utility::delaythread(0, ::helmethud_off);
  }

  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.player.helmet clearanim( % vm_gesture_visor_down_visor, 0);
  level.player.helmet give_attacker_kill_rewards( % vm_gesture_visor_up_visor);
  if(!param_00) {
    if(self == level.player) {
      level.player playSound("plr_helmet_visor_pull_up_w_air_lr");
    }

    var_02 = "ges_visor_up";
    if(isDefined(param_01)) {
      var_02 = param_01;
    }

    level.player forceplaygestureviewmodel(var_02, undefined, undefined, undefined, 1);
    wait(getanimlength( % vm_gesture_visor_up_visor));
  } else {
    level.player.helmet _meth_82B0( % vm_gesture_visor_up_visor, 1);
  }

  if(!param_00) {
    func_D5DF(1);
  }

  level.player blendlinktoplayerviewmotion(0.25, 1);
  level.player.helmet.var_13487 = "up";
  level.player notify("visor_up_end");
  level.player scripts\sp\utility::func_65DD("visor_active");
}

func_8DE2(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0.2;
  }

  if(scripts\sp\art::is_dof_script_enabled()) {
    return;
  }

  scripts\sp\art::func_583F(0, 1000, 6, 0, 100, 3, 0.2);
  wait(param_00);
  scripts\sp\art::func_583D(1.5);
}

func_13485(param_00, param_01, param_02) {
  if(scripts\sp\utility::func_93A6() && level.var_10964.ignorehelmetfuncs) {
    return;
  }

  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(level.player.helmet.var_13487 == "down") {
    return;
  }

  if(level.player scripts\sp\utility::func_65DB("visor_active")) {
    return;
  }

  level.player scripts\sp\utility::func_65E1("visor_active");
  level.player notify("putting_visor_down");
  if(!param_00) {
    func_D5DF(0);
    thread func_8DE2();
    if(!isDefined(param_02) || !param_02) {
      scripts\engine\utility::delaythread(0.5, ::helmethud_on);
    }
  } else if(!isDefined(param_02) || !param_02) {
    scripts\engine\utility::delaythread(0, ::helmethud_on);
  }

  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.player.helmet clearanim( % vm_gesture_visor_up_visor, 0);
  level.player.helmet give_attacker_kill_rewards( % vm_gesture_visor_down_visor);
  if(!param_00) {
    var_03 = "ges_visor_down";
    if(isDefined(param_01)) {
      var_03 = param_01;
    }

    if(self == level.player) {}

    level.player forceplaygestureviewmodel(var_03, undefined, undefined, undefined, 1);
    wait(getanimlength( % vm_gesture_visor_down_visor));
  } else {
    if(self == level.player) {}

    level.player.helmet _meth_82B0( % vm_gesture_visor_down_visor, 1);
  }

  if(!param_00) {
    func_D5DF(1);
  }

  level.player blendlinktoplayerviewmotion(0.25, 1);
  level.player.helmet.var_13487 = "down";
  level.player notify("visor_down_end");
  level.player scripts\sp\utility::func_65DD("visor_active");
}

func_8E05(param_00, param_01, param_02) {
  if(scripts\sp\utility::func_93A6() && level.var_10964.ignorehelmetfuncs) {
    return;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(level.player scripts\sp\utility::func_65DB("helmet_active")) {
    return;
  }

  level.player scripts\sp\utility::func_65E1("helmet_active");
  var_03 = undefined;
  if(isDefined(param_01)) {
    var_03 = param_01;
  } else if(isDefined(level.var_CF58)) {
    var_03 = level.var_CF58;
  } else {
    var_03 = % shipcrib_dropship_plr_getin_helmetvm;
  }

  if(isDefined(level.player.helmet)) {
    level.player.helmet delete();
  }

  level.player.helmet = func_1072F();
  level.player.helmet _meth_81E2(level.player, "tag_playerhelmet", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
  if(isDefined(param_00) && param_00) {
    level.player.helmet.var_13487 = "none";
    level.player thread func_1348D(1);
  } else {
    level.player.helmet.var_13487 = "none";
    level.player thread func_13485(1, undefined, 1);
    scripts\engine\utility::delaythread(0.8, ::helmethud_on);
  }

  func_D5DF(0);
  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.player.helmet give_attacker_kill_rewards(var_03);
  wait(getanimlength(var_03));
  level.player.helmet clearanim(var_03, 0);
  level.player blendlinktoplayerviewmotion(0.25, 1);
  func_D5DF(1);
  level.player notify("helmet_on_end");
  level.player scripts\sp\utility::func_65DD("helmet_active");
}

func_8E02(param_00) {
  if(scripts\sp\utility::func_93A6() && level.var_10964.ignorehelmetfuncs) {
    return;
  }

  if(level.player scripts\sp\utility::func_65DB("helmet_active")) {
    return;
  }

  level.player scripts\sp\utility::func_65E1("helmet_active");
  var_01 = undefined;
  if(isDefined(param_00)) {
    var_01 = param_00;
  } else if(isDefined(level.var_CF57)) {
    var_01 = level.var_CF57;
  } else {
    var_01 = % vm_default_helmet_off;
  }

  func_D5DF(0);
  scripts\engine\utility::delaythread(0.2, ::helmethud_off);
  thread scripts\sp\audio::func_25BE();
  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.player.helmet give_attacker_kill_rewards(var_01);
  wait(getanimlength(var_01));
  level.player.helmet clearanim(var_01, 0);
  level.player blendlinktoplayerviewmotion(0.25, 1);
  level.player.helmet _meth_83CB(level.player);
  level.player.helmet delete();
  if(self != level && self != level.player && isDefined(self.model)) {
    level.player.helmet = func_10730();
    if(isDefined(level.player.helmet)) {
      level.player.helmet linkto(self, "tag_playerhelmet", (0, 0, 0), (0, 0, 0));
    }
  }

  func_D5DF(1);
  level.player notify("helmet_off_end");
  level.player scripts\sp\utility::func_65DD("helmet_active");
}

func_8DEA(param_00) {
  if(!isDefined(param_00)) {
    scripts\engine\utility::flag_clear("helmet_script_visible");
  }

  if(scripts\sp\utility::func_93A6()) {
    scripts\sp\specialist_MAYBE::func_F52F(0);
    return;
  }

  if(isDefined(level.player.helmet)) {
    level.player.helmet hide();
  }
}

func_8E0A(param_00) {
  if(!isDefined(param_00)) {
    scripts\engine\utility::flag_set("helmet_script_visible");
  }

  if(!scripts\engine\utility::flag("helmet_FOV_disallow")) {
    if(scripts\sp\utility::func_93A6()) {
      scripts\sp\specialist_MAYBE::func_F52F(1);
      return;
    }

    if(isDefined(level.player.helmet)) {
      level.player.helmet show();
      return;
    }
  }
}

func_D5E3() {
  scripts\engine\utility::flag_init("helmet_FOV_disallow");
  scripts\engine\utility::flag_init("helmet_script_visible");
  scripts\engine\utility::flag_set("helmet_script_visible");
  scripts\sp\utility::func_F305();
  if(!level.console) {
    thread func_D5E2();
  }

  level.player scripts\sp\utility::func_65E0("helmet_active");
  level.player scripts\sp\utility::func_65E0("visor_active");
  level.player scripts\sp\utility::func_65E0("!allow_offhand_weapons");
  level.player scripts\sp\utility::func_65E0("!allow_offhand_primary_weapons");
  level.player scripts\sp\utility::func_65E0("!allow_offhand_secondary_weapons");
}

func_CFD4() {
  var_00 = [];
  var_00["offhandWeapons"] = func_3BE8("offhandWeapons", ::scripts\engine\utility::allow_offhand_weapons, ::scripts\engine\utility::isoffhandweaponsallowed, "!allow_offhand_weapons");
  var_00["offhandPrimaryWeapons"] = func_3BE8("offhandPrimaryWeapons", ::scripts\engine\utility::allow_offhand_primary_weapons, ::scripts\engine\utility::isoffhandprimaryweaponsallowed, "!allow_offhand_primary_weapons");
  var_00["offhandSecondaryWeapons"] = func_3BE8("offhandSecondaryWeapons", ::scripts\engine\utility::allow_offhand_secondary_weapons, ::scripts\engine\utility::isoffhandsecondaryweaponsallowed, "!allow_offhand_secondary_weapons");
  var_00["reload"] = func_3BE8("reload", ::scripts\engine\utility::allow_reload);
  level.player.var_1C69 = var_00;
}

func_D5DF(param_00) {
  if(!isDefined(level.player.var_1C69)) {
    func_CFD4();
  }

  if((isDefined(level.player.helmet.disabled) && param_00) || !level.player islinked() && !param_00) {
    foreach(var_02 in level.player.var_1C69) {
      if(!isDefined(var_02.var_C025) || !level.player scripts\sp\utility::func_65DB(var_02.var_C025)) {
        level.player[[var_02.var_F3C3]](param_00);
      }
    }

    if(param_00) {
      level.player.helmet.disabled = undefined;
    } else {
      level.player.helmet.disabled = 1;
    }

    scripts\engine\utility::flag_waitopen("secondary_equipment_in_use");
  }

  return 1;
}

func_3BE8(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.name = param_00;
  var_04.var_F3C3 = param_01;
  var_04.var_3DA0 = param_02;
  var_04.var_C025 = param_03;
  return var_04;
}

func_D5E2() {
  if(level.console) {
    return;
  }

  while(!isDefined(level.player.helmet)) {
    wait(0.05);
  }

  var_00 = 70;
  var_01 = var_00 / 65;
  for(;;) {
    while(!scripts\engine\utility::flag("helmet_FOV_disallow")) {
      var_02 = getdvarfloat("com_fovUserScale");
      if(var_02 > var_01) {
        scripts\engine\utility::flag_set("helmet_FOV_disallow");
        if(scripts\engine\utility::flag("helmet_script_visible")) {
          thread func_8DEA(1);
        }
      }

      wait(1);
    }

    while(scripts\engine\utility::flag("helmet_FOV_disallow")) {
      var_02 = getdvarfloat("com_fovUserScale");
      if(var_02 < var_01) {
        scripts\engine\utility::flag_clear("helmet_FOV_disallow");
        if(scripts\engine\utility::flag("helmet_script_visible")) {
          thread func_8E0A(1);
        }
      }

      wait(1);
    }

    wait(0.1);
  }
}

helmethud_on() {
  if(getomnvar("ui_helmet_state") == 1) {
    return;
  }

  setomnvar("ui_helmet_state", 1);
}

helmethud_off() {
  if(getomnvar("ui_helmet_state") == 0) {
    return;
  }

  level.player setclientomnvar("ui_helmet_state", 0);
}