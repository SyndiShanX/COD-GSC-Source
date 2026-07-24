/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3659.gsc
**************************************/

#using_animtree("script_model");

_id_10730(var_0, var_1, var_2) {
  var_3 = spawn("script_model", level.player.origin);

  if(isDefined(var_0))
    var_3 setModel(var_0);
  else if(isDefined(level._id_8E10) && level._id_8E10 == "none")
    return undefined;
  else if(isDefined(level._id_8E10))
    var_3 setModel(level._id_8E10);
  else
    var_3 setModel("hero_jackal_helmet_a");

  var_3 _meth_83D0(#animtree);

  if(isDefined(var_1))
    var_3 linkTo(var_1, var_2, (0, 0, 0), (0, 0, 0));
  else if(self != level && self != level.player && isDefined(self.model))
    var_3 linkTo(self, "tag_playerhelmet", (0, 0, 0), (0, 0, 0));

  if(!isDefined(level.player.helmet))
    level.player.helmet = var_3;

  return var_3;
}

_id_1072F(var_0) {
  var_1 = spawn("script_model", level.player.origin);

  if(isDefined(var_0))
    var_1 setModel(var_0);
  else if(isDefined(level._id_8E0E))
    var_1 setModel(level._id_8E0E);
  else
    var_1 setModel("vm_hero_protagonist_helmet");

  var_1 _meth_83D0(#animtree);
  level.player.helmet = var_1;
  return var_1;
}

_id_8E06(var_0) {
  if(scripts\sp\utility::_id_93A6() && level._id_10964.ignorehelmetfuncs) {
    return;
  }
  if(!isDefined(level.player.helmet))
    level.player.helmet = _id_1072F();

  level.player.helmet _meth_81E2(level.player, "tag_playerhelmet", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
  level.player.helmet._id_13487 = "down";

  if(isDefined(var_0) && var_0)
    thread _id_1348D(1);
  else
    scripts\engine\utility::delaythread(0, ::helmethud_on);
}

_id_8E04(var_0) {
  if(scripts\sp\utility::_id_93A6() && level._id_10964.ignorehelmetfuncs) {
    return;
  }
  level.player.helmet _meth_83CB(level.player);

  if(!isDefined(var_0) || !var_0)
    level.player.helmet delete();
}

_id_1348D(var_0, var_1) {
  if(scripts\sp\utility::_id_93A6() && level._id_10964.ignorehelmetfuncs) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = 0;

  if(level.player.helmet._id_13487 == "up") {
    return;
  }
  if(level.player scripts\sp\utility::_id_65DB("visor_active")) {
    return;
  }
  level.player scripts\sp\utility::_id_65E1("visor_active");
  level.player notify("putting_visor_up");

  if(!var_0) {
    _id_D5DF(0);
    scripts\engine\utility::delaythread(0.2, ::helmethud_off);
    thread _id_8DE2();
  } else
    scripts\engine\utility::delaythread(0, ::helmethud_off);

  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.player.helmet clearanim(%vm_gesture_visor_down_visor, 0);
  level.player.helmet _meth_82A2(%vm_gesture_visor_up_visor);

  if(!var_0) {
    if(self == level.player)
      level.player playSound("plr_helmet_visor_pull_up_w_air_lr");

    var_2 = "ges_visor_up";

    if(isDefined(var_1))
      var_2 = var_1;

    level.player forceplaygestureviewmodel(var_2, undefined, undefined, undefined, 1);
    wait(getanimlength(%vm_gesture_visor_up_visor));
  } else
    level.player.helmet _meth_82B0(%vm_gesture_visor_up_visor, 1);

  if(!var_0)
    _id_D5DF(1);

  level.player blendlinktoplayerviewmotion(0.25, 1);
  level.player.helmet._id_13487 = "up";
  level.player notify("visor_up_end");
  level.player scripts\sp\utility::_id_65DD("visor_active");
}

_id_8DE2(var_0) {
  if(!isDefined(var_0))
    var_0 = 0.2;

  if(_id_0B0A::is_dof_script_enabled()) {
    return;
  }
  _id_0B0A::_id_583F(0, 1000, 6, 0, 100, 3, 0.2);
  wait(var_0);
  _id_0B0A::_id_583D(1.5);
}

_id_13485(var_0, var_1, var_2) {
  if(scripts\sp\utility::_id_93A6() && level._id_10964.ignorehelmetfuncs) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = 0;

  if(level.player.helmet._id_13487 == "down") {
    return;
  }
  if(level.player scripts\sp\utility::_id_65DB("visor_active")) {
    return;
  }
  level.player scripts\sp\utility::_id_65E1("visor_active");
  level.player notify("putting_visor_down");

  if(!var_0) {
    _id_D5DF(0);
    thread _id_8DE2();

    if(!isDefined(var_2) || !var_2)
      scripts\engine\utility::delaythread(0.5, ::helmethud_on);
  } else if(!isDefined(var_2) || !var_2)
    scripts\engine\utility::delaythread(0, ::helmethud_on);

  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.player.helmet clearanim(%vm_gesture_visor_up_visor, 0);
  level.player.helmet _meth_82A2(%vm_gesture_visor_down_visor);

  if(!var_0) {
    var_3 = "ges_visor_down";

    if(isDefined(var_1))
      var_3 = var_1;

    if(self == level.player) {}

    level.player forceplaygestureviewmodel(var_3, undefined, undefined, undefined, 1);
    wait(getanimlength(%vm_gesture_visor_down_visor));
  } else {
    if(self == level.player) {}

    level.player.helmet _meth_82B0(%vm_gesture_visor_down_visor, 1);
  }

  if(!var_0)
    _id_D5DF(1);

  level.player blendlinktoplayerviewmotion(0.25, 1);
  level.player.helmet._id_13487 = "down";
  level.player notify("visor_down_end");
  level.player scripts\sp\utility::_id_65DD("visor_active");
}

_id_8E05(var_0, var_1, var_2) {
  if(scripts\sp\utility::_id_93A6() && level._id_10964.ignorehelmetfuncs) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 0;

  if(level.player scripts\sp\utility::_id_65DB("helmet_active")) {
    return;
  }
  level.player scripts\sp\utility::_id_65E1("helmet_active");
  var_3 = undefined;

  if(isDefined(var_1))
    var_3 = var_1;
  else if(isDefined(level._id_CF58))
    var_3 = level._id_CF58;
  else
    var_3 = % shipcrib_dropship_plr_getin_helmetvm;

  if(isDefined(level.player.helmet))
    level.player.helmet delete();

  level.player.helmet = _id_1072F();
  level.player.helmet _meth_81E2(level.player, "tag_playerhelmet", (0, 0, 0), (0, 0, 0), 1, "view_jostle");

  if(isDefined(var_0) && var_0) {
    level.player.helmet._id_13487 = "none";
    level.player thread _id_1348D(1);
  } else {
    level.player.helmet._id_13487 = "none";
    level.player thread _id_13485(1, undefined, 1);
    scripts\engine\utility::delaythread(0.8, ::helmethud_on);
  }

  _id_D5DF(0);
  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.player.helmet _meth_82A2(var_3);
  wait(getanimlength(var_3));
  level.player.helmet clearanim(var_3, 0);
  level.player blendlinktoplayerviewmotion(0.25, 1);
  _id_D5DF(1);
  level.player notify("helmet_on_end");
  level.player scripts\sp\utility::_id_65DD("helmet_active");
}

_id_8E02(var_0) {
  if(scripts\sp\utility::_id_93A6() && level._id_10964.ignorehelmetfuncs) {
    return;
  }
  if(level.player scripts\sp\utility::_id_65DB("helmet_active")) {
    return;
  }
  level.player scripts\sp\utility::_id_65E1("helmet_active");
  var_1 = undefined;

  if(isDefined(var_0))
    var_1 = var_0;
  else if(isDefined(level._id_CF57))
    var_1 = level._id_CF57;
  else
    var_1 = % vm_default_helmet_off;

  _id_D5DF(0);
  scripts\engine\utility::delaythread(0.2, ::helmethud_off);
  thread _id_0B0B::_id_25BE();
  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.player.helmet _meth_82A2(var_1);
  wait(getanimlength(var_1));
  level.player.helmet clearanim(var_1, 0);
  level.player blendlinktoplayerviewmotion(0.25, 1);
  level.player.helmet _meth_83CB(level.player);
  level.player.helmet delete();

  if(self != level && self != level.player && isDefined(self.model)) {
    level.player.helmet = _id_10730();

    if(isDefined(level.player.helmet))
      level.player.helmet linkTo(self, "tag_playerhelmet", (0, 0, 0), (0, 0, 0));
  }

  _id_D5DF(1);
  level.player notify("helmet_off_end");
  level.player scripts\sp\utility::_id_65DD("helmet_active");
}

_id_8DEA(var_0) {
  if(!isDefined(var_0))
    scripts\engine\utility::flag_clear("helmet_script_visible");

  if(scripts\sp\utility::_id_93A6())
    scripts\sp\specialist_MAYBE::_id_F52F(0);
  else if(isDefined(level.player.helmet))
    level.player.helmet hide();
}

_id_8E0A(var_0) {
  if(!isDefined(var_0))
    scripts\engine\utility::flag_set("helmet_script_visible");

  if(!scripts\engine\utility::flag("helmet_FOV_disallow")) {
    if(scripts\sp\utility::_id_93A6())
      scripts\sp\specialist_MAYBE::_id_F52F(1);
    else if(isDefined(level.player.helmet))
      level.player.helmet show();
  }
}

_id_D5E3() {
  scripts\engine\utility::flag_init("helmet_FOV_disallow");
  scripts\engine\utility::flag_init("helmet_script_visible");
  scripts\engine\utility::flag_set("helmet_script_visible");
  scripts\sp\utility::_id_F305();

  if(!level.console)
    thread _id_D5E2();

  level.player scripts\sp\utility::_id_65E0("helmet_active");
  level.player scripts\sp\utility::_id_65E0("visor_active");
  level.player scripts\sp\utility::_id_65E0("!allow_offhand_weapons");
  level.player scripts\sp\utility::_id_65E0("!allow_offhand_primary_weapons");
  level.player scripts\sp\utility::_id_65E0("!allow_offhand_secondary_weapons");
}

_id_CFD4() {
  var_0 = [];
  var_0["offhandWeapons"] = _id_3BE8("offhandWeapons", scripts\engine\utility::allow_offhand_weapons, scripts\engine\utility::isoffhandweaponsallowed, "!allow_offhand_weapons");
  var_0["offhandPrimaryWeapons"] = _id_3BE8("offhandPrimaryWeapons", scripts\engine\utility::allow_offhand_primary_weapons, scripts\engine\utility::isoffhandprimaryweaponsallowed, "!allow_offhand_primary_weapons");
  var_0["offhandSecondaryWeapons"] = _id_3BE8("offhandSecondaryWeapons", scripts\engine\utility::allow_offhand_secondary_weapons, scripts\engine\utility::isoffhandsecondaryweaponsallowed, "!allow_offhand_secondary_weapons");
  var_0["reload"] = _id_3BE8("reload", scripts\engine\utility::allow_reload);
  level.player._id_1C69 = var_0;
}

_id_D5DF(var_0) {
  if(!isDefined(level.player._id_1C69))
    _id_CFD4();

  if(isDefined(level.player.helmet.disabled) && var_0 || !level.player islinked() && !var_0) {
    foreach(var_3, var_2 in level.player._id_1C69) {
      if(!isDefined(var_2._id_C025) || !level.player scripts\sp\utility::_id_65DB(var_2._id_C025))
        level.player[[var_2._id_F3C3]](var_0);
    }

    if(var_0)
      level.player.helmet.disabled = undefined;
    else
      level.player.helmet.disabled = 1;

    scripts\engine\utility::flag_waitopen("secondary_equipment_in_use");
  }

  return 1;
}

_id_3BE8(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.name = var_0;
  var_4._id_F3C3 = var_1;
  var_4._id_3DA0 = var_2;
  var_4._id_C025 = var_3;
  return var_4;
}

_id_D5E2() {
  if(level.console) {
    return;
  }
  while(!isDefined(level.player.helmet))
    wait 0.05;

  var_0 = 70;
  var_1 = var_0 / 65;

  for(;;) {
    while(!scripts\engine\utility::flag("helmet_FOV_disallow")) {
      var_2 = getdvarfloat("com_fovUserScale");

      if(var_2 > var_1) {
        scripts\engine\utility::flag_set("helmet_FOV_disallow");

        if(scripts\engine\utility::flag("helmet_script_visible"))
          thread _id_8DEA(1);
      }

      wait 1;
    }

    while(scripts\engine\utility::flag("helmet_FOV_disallow")) {
      var_2 = getdvarfloat("com_fovUserScale");

      if(var_2 < var_1) {
        scripts\engine\utility::flag_clear("helmet_FOV_disallow");

        if(scripts\engine\utility::flag("helmet_script_visible"))
          thread _id_8E0A(1);
      }

      wait 1;
    }

    wait 0.1;
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