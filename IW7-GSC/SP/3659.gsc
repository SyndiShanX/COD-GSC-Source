/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3659.gsc
************************/

func_10730(var_0, var_1, var_2) {
  var_3 = spawn("script_model", level.player.origin);
  if(isDefined(var_0)) {
    var_3 setModel(var_0);
  } else if(isDefined(level.var_8E10) && level.var_8E10 == "none") {
    return undefined;
  } else if(isDefined(level.var_8E10)) {
    var_3 setModel(level.var_8E10);
  } else {
    var_3 setModel("hero_jackal_helmet_a");
  }

  var_3 glinton(#animtree);
  if(isDefined(var_1)) {
    var_3 linkto(var_1, var_2, (0, 0, 0), (0, 0, 0));
  } else if(self != level && self != level.player && isDefined(self.model)) {
    var_3 linkto(self, "tag_playerhelmet", (0, 0, 0), (0, 0, 0));
  }

  if(!isDefined(level.player.helmet)) {
    level.player.helmet = var_3;
  }

  return var_3;
}

func_1072F(var_0) {
  var_1 = spawn("script_model", level.player.origin);
  if(isDefined(var_0)) {
    var_1 setModel(var_0);
  } else if(isDefined(level.var_8E0E)) {
    var_1 setModel(level.var_8E0E);
  } else {
    var_1 setModel("vm_hero_protagonist_helmet");
  }

  var_1 glinton(#animtree);
  level.player.helmet = var_1;
  return var_1;
}

func_8E06(var_0) {
  if(scripts\sp\utility::func_93A6() && level.var_10964.ignorehelmetfuncs) {
    return;
  }

  if(!isDefined(level.player.helmet)) {
    level.player.helmet = func_1072F();
  }

  level.player.helmet _meth_81E2(level.player, "tag_playerhelmet", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
  level.player.helmet.var_13487 = "down";
  if(isDefined(var_0) && var_0) {
    thread func_1348D(1);
    return;
  }

  scripts\engine\utility::delaythread(0, ::helmethud_on);
}

func_8E04(var_0) {
  if(scripts\sp\utility::func_93A6() && level.var_10964.ignorehelmetfuncs) {
    return;
  }

  level.player.helmet _meth_83CB(level.player);
  if(!isDefined(var_0) || !var_0) {
    level.player.helmet delete();
  }
}

func_1348D(var_0, var_1) {
  if(scripts\sp\utility::func_93A6() && level.var_10964.ignorehelmetfuncs) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(level.player.helmet.var_13487 == "up") {
    return;
  }

  if(level.player scripts\sp\utility::func_65DB("visor_active")) {
    return;
  }

  level.player scripts\sp\utility::func_65E1("visor_active");
  level.player notify("putting_visor_up");
  if(!var_0) {
    func_D5DF(0);
    scripts\engine\utility::delaythread(0.2, ::helmethud_off);
    thread func_8DE2();
  } else {
    scripts\engine\utility::delaythread(0, ::helmethud_off);
  }

  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.player.helmet clearanim( % vm_gesture_visor_down_visor, 0);
  level.player.helmet give_attacker_kill_rewards( % vm_gesture_visor_up_visor);
  if(!var_0) {
    if(self == level.player) {
      level.player playSound("plr_helmet_visor_pull_up_w_air_lr");
    }

    var_2 = "ges_visor_up";
    if(isDefined(var_1)) {
      var_2 = var_1;
    }

    level.player forceplaygestureviewmodel(var_2, undefined, undefined, undefined, 1);
    wait(getanimlength( % vm_gesture_visor_up_visor));
  } else {
    level.player.helmet _meth_82B0( % vm_gesture_visor_up_visor, 1);
  }

  if(!var_0) {
    func_D5DF(1);
  }

  level.player blendlinktoplayerviewmotion(0.25, 1);
  level.player.helmet.var_13487 = "up";
  level.player notify("visor_up_end");
  level.player scripts\sp\utility::func_65DD("visor_active");
}

func_8DE2(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.2;
  }

  if(scripts\sp\art::is_dof_script_enabled()) {
    return;
  }

  scripts\sp\art::func_583F(0, 1000, 6, 0, 100, 3, 0.2);
  wait(var_0);
  scripts\sp\art::func_583D(1.5);
}

func_13485(var_0, var_1, var_2) {
  if(scripts\sp\utility::func_93A6() && level.var_10964.ignorehelmetfuncs) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(level.player.helmet.var_13487 == "down") {
    return;
  }

  if(level.player scripts\sp\utility::func_65DB("visor_active")) {
    return;
  }

  level.player scripts\sp\utility::func_65E1("visor_active");
  level.player notify("putting_visor_down");
  if(!var_0) {
    func_D5DF(0);
    thread func_8DE2();
    if(!isDefined(var_2) || !var_2) {
      scripts\engine\utility::delaythread(0.5, ::helmethud_on);
    }
  } else if(!isDefined(var_2) || !var_2) {
    scripts\engine\utility::delaythread(0, ::helmethud_on);
  }

  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.player.helmet clearanim( % vm_gesture_visor_up_visor, 0);
  level.player.helmet give_attacker_kill_rewards( % vm_gesture_visor_down_visor);
  if(!var_0) {
    var_3 = "ges_visor_down";
    if(isDefined(var_1)) {
      var_3 = var_1;
    }

    if(self == level.player) {}

    level.player forceplaygestureviewmodel(var_3, undefined, undefined, undefined, 1);
    wait(getanimlength( % vm_gesture_visor_down_visor));
  } else {
    if(self == level.player) {}

    level.player.helmet _meth_82B0( % vm_gesture_visor_down_visor, 1);
  }

  if(!var_0) {
    func_D5DF(1);
  }

  level.player blendlinktoplayerviewmotion(0.25, 1);
  level.player.helmet.var_13487 = "down";
  level.player notify("visor_down_end");
  level.player scripts\sp\utility::func_65DD("visor_active");
}

func_8E05(var_0, var_1, var_2) {
  if(scripts\sp\utility::func_93A6() && level.var_10964.ignorehelmetfuncs) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(level.player scripts\sp\utility::func_65DB("helmet_active")) {
    return;
  }

  level.player scripts\sp\utility::func_65E1("helmet_active");
  var_3 = undefined;
  if(isDefined(var_1)) {
    var_3 = var_1;
  } else if(isDefined(level.var_CF58)) {
    var_3 = level.var_CF58;
  } else {
    var_3 = % shipcrib_dropship_plr_getin_helmetvm;
  }

  if(isDefined(level.player.helmet)) {
    level.player.helmet delete();
  }

  level.player.helmet = func_1072F();
  level.player.helmet _meth_81E2(level.player, "tag_playerhelmet", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
  if(isDefined(var_0) && var_0) {
    level.player.helmet.var_13487 = "none";
    level.player thread func_1348D(1);
  } else {
    level.player.helmet.var_13487 = "none";
    level.player thread func_13485(1, undefined, 1);
    scripts\engine\utility::delaythread(0.8, ::helmethud_on);
  }

  func_D5DF(0);
  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.player.helmet give_attacker_kill_rewards(var_3);
  wait(getanimlength(var_3));
  level.player.helmet clearanim(var_3, 0);
  level.player blendlinktoplayerviewmotion(0.25, 1);
  func_D5DF(1);
  level.player notify("helmet_on_end");
  level.player scripts\sp\utility::func_65DD("helmet_active");
}

func_8E02(var_0) {
  if(scripts\sp\utility::func_93A6() && level.var_10964.ignorehelmetfuncs) {
    return;
  }

  if(level.player scripts\sp\utility::func_65DB("helmet_active")) {
    return;
  }

  level.player scripts\sp\utility::func_65E1("helmet_active");
  var_1 = undefined;
  if(isDefined(var_0)) {
    var_1 = var_0;
  } else if(isDefined(level.var_CF57)) {
    var_1 = level.var_CF57;
  } else {
    var_1 = % vm_default_helmet_off;
  }

  func_D5DF(0);
  scripts\engine\utility::delaythread(0.2, ::helmethud_off);
  thread scripts\sp\audio::func_25BE();
  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.player.helmet give_attacker_kill_rewards(var_1);
  wait(getanimlength(var_1));
  level.player.helmet clearanim(var_1, 0);
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

func_8DEA(var_0) {
  if(!isDefined(var_0)) {
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

func_8E0A(var_0) {
  if(!isDefined(var_0)) {
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
  var_0 = [];
  var_0["offhandWeapons"] = func_3BE8("offhandWeapons", ::scripts\engine\utility::allow_offhand_weapons, ::scripts\engine\utility::isoffhandweaponsallowed, "!allow_offhand_weapons");
  var_0["offhandPrimaryWeapons"] = func_3BE8("offhandPrimaryWeapons", ::scripts\engine\utility::allow_offhand_primary_weapons, ::scripts\engine\utility::isoffhandprimaryweaponsallowed, "!allow_offhand_primary_weapons");
  var_0["offhandSecondaryWeapons"] = func_3BE8("offhandSecondaryWeapons", ::scripts\engine\utility::allow_offhand_secondary_weapons, ::scripts\engine\utility::isoffhandsecondaryweaponsallowed, "!allow_offhand_secondary_weapons");
  var_0["reload"] = func_3BE8("reload", ::scripts\engine\utility::allow_reload);
  level.player.var_1C69 = var_0;
}

func_D5DF(var_0) {
  if(!isDefined(level.player.var_1C69)) {
    func_CFD4();
  }

  if((isDefined(level.player.helmet.disabled) && var_0) || !level.player islinked() && !var_0) {
    foreach(var_2 in level.player.var_1C69) {
      if(!isDefined(var_2.var_C025) || !level.player scripts\sp\utility::func_65DB(var_2.var_C025)) {
        level.player[[var_2.var_F3C3]](var_0);
      }
    }

    if(var_0) {
      level.player.helmet.disabled = undefined;
    } else {
      level.player.helmet.disabled = 1;
    }

    scripts\engine\utility::flag_waitopen("secondary_equipment_in_use");
  }

  return 1;
}

func_3BE8(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.name = var_0;
  var_4.var_F3C3 = var_1;
  var_4.var_3DA0 = var_2;
  var_4.var_C025 = var_3;
  return var_4;
}

func_D5E2() {
  if(level.console) {
    return;
  }

  while(!isDefined(level.player.helmet)) {
    wait(0.05);
  }

  var_0 = 70;
  var_1 = var_0 / 65;
  for(;;) {
    while(!scripts\engine\utility::flag("helmet_FOV_disallow")) {
      var_2 = getdvarfloat("com_fovUserScale");
      if(var_2 > var_1) {
        scripts\engine\utility::flag_set("helmet_FOV_disallow");
        if(scripts\engine\utility::flag("helmet_script_visible")) {
          thread func_8DEA(1);
        }
      }

      wait(1);
    }

    while(scripts\engine\utility::flag("helmet_FOV_disallow")) {
      var_2 = getdvarfloat("com_fovUserScale");
      if(var_2 < var_1) {
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