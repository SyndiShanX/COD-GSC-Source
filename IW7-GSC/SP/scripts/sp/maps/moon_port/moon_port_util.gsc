/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moon_port\moon_port_util.gsc
********************************************************/

_id_BC53(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1)) {} else
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  level.player setOrigin(var_1.origin);

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  var_2 = undefined;

  if(isDefined(var_1.target)) {
    var_2 = getEnt(var_1.target, "targetname");
  }

  if(isDefined(var_2)) {
    level.player setplayerangles(vectortoangles(var_2.origin - var_1.origin));
  } else {
    level.player setplayerangles(var_1.angles);
  }

  if(!scripts\engine\utility::array_contains(level.struct, var_1)) {
    var_1 delete();
  }
}

_id_1683(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_3 = scripts\engine\utility::getStruct(var_1, "targetname");

  if(!isDefined(var_3)) {
    var_1 = tolower(var_1);
    var_3 = scripts\engine\utility::getStruct(var_1, "targetname");
  }

  if(!isDefined(var_3)) {
    var_1 = tolower(var_1);
    var_3 = getnode(var_1, "targetname");
  }

  if(!isDefined(var_3)) {}

  if(!isDefined(var_3.angles)) {
    var_3.angles = (0, 0, 0);
  }

  if(isPlayer(var_0)) {
    var_0 setplayerangles(var_3.angles);
    var_0 setOrigin(var_3.origin);
  } else if(isai(var_0)) {
    var_0 _meth_80F1(var_3.origin, var_3.angles);
    var_4 = var_0._id_164D[var_0.asmname]._id_4BC0;
    var_5 = anim.asm[var_0.asmname];
    var_6 = var_5.states[var_4];

    if(isDefined(var_6._id_C704)) {
      var_0 _id_0A1E::_id_237F(var_6._id_C704);
    }

    if(isDefined(var_2) && var_2) {
      var_0 setgoalpos(var_3.origin);
    }
  }
}

_id_3DD4(var_0, var_1) {
  foreach(var_5, var_3 in level.allies) {
    if(isalive(var_3) && distance(level.player.origin, var_3.origin) > 1024 && !scripts\engine\utility::flag(var_1)) {
      while(level.player scripts\sp\utility::_id_3849(var_3.origin) && !scripts\engine\utility::flag(var_1)) {
        scripts\engine\utility::waitframe();
      }

      if(distance(level.player.origin, var_3.origin) > 1024 && !scripts\engine\utility::flag(var_1)) {
        var_4 = "";

        switch (var_5) {
          case "marineCO":
            var_4 = "_CO";
          case "salter":
            var_4 = "_salter";
          case "eth3n":
            var_4 = "_eth3n";
          case "marine1":
            var_4 = "_1";
          case "marine2":
            var_4 = "_2";
          case "kashima":
            var_4 = "_kashima";
          case "brooks":
            var_4 = "_brooks";
        }

        _id_1683(level.allies[var_5], var_0 + var_4, 1);
      }
    }
  }
}

_id_2170(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_2 = level.player getweaponslistall();
    var_3 = scripts\sp\utility::_id_7AD7();

    if(isDefined(var_3)) {
      var_2 = scripts\engine\utility::array_remove(var_2, var_3);
    }

    foreach(var_5 in var_2) {
      level.player takeweapon(var_5);
    }
  }

  foreach(var_8 in var_0) {
    level.player giveweapon(var_8);
    level.player givemaxammo(var_8);
  }

  if(!isDefined(var_1)) {
    var_10 = level.player scripts\sp\utility::_id_7D74();
    level.player switchtoweapon(var_10[0]);
  }
}

_id_48BF(var_0) {
  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  if(!isDefined(var_0)) {
    var_0 = ["marineCO", "salter", "eth3n", "marine1", "marine2"];
  }

  foreach(var_2 in var_0) {
    if(isDefined(level.allies[var_2]) && isalive(level.allies[var_2])) {
      continue;
    }
    level.allies[var_2] = ::scripts\sp\utility::_id_107EA(var_2, 1);
    level.allies[var_2] scripts\sp\utility::_id_B14F();
    level.allies[var_2] _meth_8250(0);
    level.allies[var_2]._id_C065 = 1;
    level.allies[var_2]._id_1FBB = var_2;

    if(var_2 == "marineCO") {
      level.allies["marineCO"].name = "Omar";
      level.allies["marineCO"] scripts\sp\utility::_id_72EC("iw7_crb+crblscope", "primary");
      continue;
    }

    if(var_2 == "salter") {
      level.allies["salter"].name = "Salter";
      level.allies["salter"] thread scripts\sp\utility::_id_19FA("iw7_m4", "iw7_m8+m8scope_sp", 1024, 1);
      continue;
    }

    if(var_2 == "eth3n") {
      level.allies["eth3n"].name = "Ethan";
      level.allies["eth3n"] scripts\sp\utility::_id_72EC("iw7_ake+acogake", "primary");
      continue;
    }

    if(var_2 == "marine1") {
      level.allies["marine1"].name = "PO3 Goodwin";
      level.allies["marine1"] scripts\sp\utility::_id_72EC("iw7_fhr+reflexsmg", "primary");
      continue;
    }

    if(var_2 == "marine2") {
      level.allies["marine2"].name = "SN Baker";
      level.allies["marine2"] scripts\sp\utility::_id_72EC("iw7_ar57+ar57scope", "primary");
      continue;
    }

    if(var_2 == "mdf1") {
      level.allies["mdf1"].name = "SN Uhrig";
      continue;
    }

    if(var_2 == "kashima") {
      level.allies["kashima"].name = "Kashima";
      continue;
    }

    if(var_2 == "brooks") {
      level.allies["brooks"].name = "Brooks";
    }
  }
}

_id_BC05(var_0, var_1) {
  _id_48BF(var_1);

  if(!isDefined(var_1)) {
    var_1 = ["marineCO", "salter", "eth3n", "marine1", "marine2"];
  }

  if(scripts\engine\utility::array_contains(var_1, "marineCO")) {
    _id_1683(level.allies["marineCO"], var_0 + "_CO", 1);
  }

  if(scripts\engine\utility::array_contains(var_1, "salter")) {
    _id_1683(level.allies["salter"], var_0 + "_salter", 1);
  }

  if(scripts\engine\utility::array_contains(var_1, "eth3n")) {
    _id_1683(level.allies["eth3n"], var_0 + "_eth3n", 1);
  }

  if(scripts\engine\utility::array_contains(var_1, "marine1")) {
    _id_1683(level.allies["marine1"], var_0 + "_1", 1);
  }

  if(scripts\engine\utility::array_contains(var_1, "marine2")) {
    _id_1683(level.allies["marine2"], var_0 + "_2", 1);
  }

  if(scripts\engine\utility::array_contains(var_1, "marine3")) {
    _id_1683(level.allies["marine3"], var_0 + "_3", 1);
  }

  if(scripts\engine\utility::array_contains(var_1, "mdf1")) {
    _id_1683(level.allies["mdf1"], var_0 + "_mdf1", 1);
  }

  if(scripts\engine\utility::array_contains(var_1, "mdf2")) {
    _id_1683(level.allies["mdf2"], var_0 + "_mdf2", 1);
  }

  if(scripts\engine\utility::array_contains(var_1, "mdf3")) {
    _id_1683(level.allies["mdf3"], var_0 + "_mdf3", 1);
  }

  if(scripts\engine\utility::array_contains(var_1, "kashima")) {
    _id_1683(level.allies["kashima"], var_0 + "_kashima", 1);
  }

  if(scripts\engine\utility::array_contains(var_1, "brooks")) {
    _id_1683(level.allies["brooks"], var_0 + "_brooks", 1);
  }
}

_id_1163D(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_1, "targetname");

  if(var_2.size != 2) {}

  var_3 = scripts\engine\utility::getclosest(level.player.origin, var_2, 50000);
  var_2 = scripts\engine\utility::array_remove(var_2, var_3);
  var_4 = var_2[0];
  var_5 = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_4.origin, var_4.angles);
  _id_0B1E::_id_11620("airlock_bodies_peek", var_5, var_6);

  foreach(var_8 in var_0) {
    var_8 _meth_83BA(var_5, var_6);
  }

  teleportscene();
  var_5 delete();
  var_6 delete();
}

_id_22AB(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 != var_1) {
      var_2[var_4._id_1FBB] = var_4;
    }
  }

  return var_2;
}

_id_F293(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\sp\utility::_id_77DA(var_0);

  if(var_6.size == 0) {
    return;
  }
  var_6 = sortbydistance(var_6, level.player.origin);
  var_6 = scripts\engine\utility::array_reverse(var_6);
  var_7 = getEnt(var_1, "targetname");

  foreach(var_9 in var_6) {
    if(isDefined(var_2) && isDefined(var_3)) {
      wait(randomfloatrange(var_2, var_3));
    }

    if(isalive(var_9)) {
      var_9 _meth_82F1(var_7);
    }

    if(isDefined(var_9.unittype)) {
      if(var_9.unittype == "soldier") {
        if(isDefined(var_5) && isalive(var_9)) {
          if(randomint(100) >= 100 * var_5) {
            var_9 scripts\sp\utility::_id_51E1(var_4);
          }

          continue;
        }

        if(isDefined(var_4)) {
          var_9 scripts\sp\utility::_id_51E1(var_4);
        }
      }
    }
  }
}

_id_F2D4(var_0) {
  var_1 = getaiarray("axis");
  var_2 = getEnt(var_0, "targetname");

  foreach(var_4 in var_1) {
    var_4 setgoalpos(var_4.origin);
    var_4 _meth_82F1(var_2);
  }
}

_id_137F8(var_0) {
  for(;;) {
    var_1 = getaiarray("axis");

    if(var_1.size <= var_0) {
      break;
    }

    wait 0.5;
  }
}

_id_EA00(var_0, var_1) {
  var_2 = 262144;
  var_3 = [];

  if(isDefined(var_0)) {
    var_3 = scripts\sp\utility::_id_77DA(var_0);
  } else {
    var_3 = getaiarray("axis");
  }

  foreach(var_5 in var_3) {
    var_6 = distance2dsquared(level.player.origin, var_5.origin);

    if((!isDefined(var_1) || isDefined(var_1) && !var_1) && var_6 >= var_2 && !scripts\common\trace::ray_trace_passed(level.player getEye(), var_5 getEye())) {
      var_5 scripts\engine\utility::delaythread(randomfloatrange(0, 0.5), ::_id_A5E4);
    }
  }
}

_id_A5E4() {
  wait 1;
  self _meth_81D0();
}

_id_5364() {
  var_0 = getEntArray("destructible_screens", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_5365);
}

_id_5365() {
  self endon("death");
  var_0 = getglass(self.target);

  if(!isDefined(var_0)) {
    return;
  }
  while(!isglassdestroyed(var_0)) {
    wait 0.05;
  }

  if(!isDefined(self._id_ED83)) {
    if(!isDefined(self.script_noteworthy) || self.script_noteworthy != "nofx") {
      playFX(scripts\engine\utility::getfx("vfx_moon_adscreen_sparks_runner"), self.origin);
    }

    playworldsound("dst_cover_cube", self.origin);
  }

  self delete();
}

_id_B8F3() {
  level._id_111D0 = scripts\engine\utility::spawn_tag_origin();
  playFXOnTag(scripts\engine\utility::getfx("vfx_moon_sunfx"), level._id_111D0, "tag_origin");
  level._id_111D0._id_1120D = getmapsunangles();
  level._id_111D0.suncolor = getmapsuncolorandintensity();
  level._id_111D0._id_99E5 = level._id_111D0.suncolor[3];
  level._id_111D0.suncolor = (level._id_111D0.suncolor[0], level._id_111D0.suncolor[1], level._id_111D0.suncolor[2]);
  level._id_111D0._id_75AC = (0, 0, 0);
  scripts\engine\utility::flag_init("flag_pause_sun_fx_updates");

  for(;;) {
    if(scripts\engine\utility::flag("flag_pause_sun_fx_updates")) {
      wait 0.05;
      continue;
    }

    if(isDefined(level._id_D127) && level._id_D127 _id_0BDC::_id_A2A7()) {
      var_0 = level._id_D127.origin;
    } else {
      var_0 = level.player.origin;
    }

    var_1 = (200000, 0, 0);
    var_1 = rotatevector(var_1, level._id_111D0._id_1120D + level._id_111D0._id_75AC);
    level._id_111D0.origin = var_0 + var_1;
    wait 0.05;
  }
}

_id_3C44(var_0, var_1) {
  level notify("new_map_sunangles");
  level endon("new_map_sunangles");

  if(var_1 <= 0.05) {
    _id_3C45(var_0);
    return;
  }

  var_2 = level._id_111D0._id_1120D;
  var_3 = anglesToForward(level._id_111D0._id_1120D);
  var_4 = anglestoright(level._id_111D0._id_1120D);
  var_5 = anglestoup(level._id_111D0._id_1120D);
  var_6 = anglesToForward(var_0);
  var_7 = anglestoright(var_0);
  var_8 = anglestoup(var_0);
  var_9 = var_6 - var_3;
  var_10 = var_7 - var_4;
  var_11 = var_8 - var_5;
  var_12 = var_9 * (1 / (var_1 + 0.05) * 0.05);
  var_13 = var_10 * (1 / (var_1 + 0.05) * 0.05);
  var_14 = var_11 * (1 / (var_1 + 0.05) * 0.05);

  while(var_1 > 0) {
    var_1 = var_1 - 0.05;
    var_3 = var_3 + var_12;
    var_4 = var_4 + var_13;
    var_5 = var_5 + var_14;
    var_2 = axistoangles(vectorNormalize(var_3), vectorNormalize(var_4), vectorNormalize(var_5));
    _id_3C45(var_2);
    wait 0.05;
  }

  _id_3C45(var_0);
}

_id_3C45(var_0) {
  lerpsunangles(level._id_111D0._id_1120D, var_0, 0.05);
  level._id_111D0._id_1120D = var_0;
}

_id_16BD(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level._id_4EC3)) {
    level._id_4EC3 = [];
  }

  var_3 = "^3";

  if(isDefined(var_2)) {
    switch (var_2) {
      case "red":
      case "r":
        var_3 = "^1";
        break;
      case "green":
      case "g":
        var_3 = "^2";
        break;
      case "yellow":
      case "y":
        var_3 = "^3";
        break;
      case "blue":
      case "b":
        var_3 = "^4";
        break;
      case "cyan":
      case "c":
        var_3 = "^5";
        break;
      case "purple":
      case "p":
        var_3 = "^6";
        break;
      case "white":
      case "w":
        var_3 = "^7";
        break;
      case "black":
      case "bl":
        var_3 = "^8";
        break;
    }
  }

  var_4 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_4.location = 0;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.foreground = 1;
  var_4.sort = 20;
  var_4.alpha = 0;
  var_4 fadeovertime(0.5);
  var_4.alpha = 1;
  var_4.x = 40;
  var_4.y = 325;
  var_4.label = " " + var_3 + "< " + var_0 + " > ^7" + var_1;
  var_4.color = (1, 1, 1);
  level._id_4EC3 = scripts\engine\utility::array_insert(level._id_4EC3, var_4, 0);

  foreach(var_7, var_6 in level._id_4EC3) {
    if(var_7 == 0) {
      continue;
    }
    if(isDefined(var_6)) {
      var_6.y = 325 - var_7 * 18;
    }
  }

  wait 2;
  var_8 = 40;
  var_4 fadeovertime(3);
  var_4.alpha = 0;

  for(var_7 = 0; var_7 < var_8; var_7++) {
    var_4.color = (1, 1, 0 / (var_8 - var_7));
    wait 0.05;
  }

  wait 4;
  var_4 destroy();
  scripts\engine\utility::array_removeundefined(level._id_4EC3);
}

_id_D1E7(var_0, var_1, var_2) {
  scripts\engine\utility::flag_set("low_g_on");
  level.player setsuit(var_1);

  if(!isDefined(var_2)) {
    var_2 = [];
    var_2["bg_gravity"] = 120;
    var_2["g_speed"] = 85;
    var_2["friction"] = 0.75;
    var_2["bg_fallDamageMinHeight"] = 1000;
    var_2["bg_fallDamageMaxHeight"] = 1500;
    var_2["bg_sprintLoopTimeScale"] = 2.5;
    var_2["jump_slowdownEnable"] = 0;
    var_2["bg_weaponBobAmplitudeStanding"] = "0.5 0.5";
    var_2["bg_weaponBobAmplitudeSprinting"] = "0.5 0.5";
    var_2["mantle_enable"] = 0;
    var_2["doublejump"] = 0;
    var_2["wallrun"] = 0;
    var_2["bobrate"] = 2.75;
  }

  thread _id_D1E9(var_2, var_0);

  if(scripts\engine\utility::flag("flag_infil_airlock_complete")) {
    var_3 = 11;
    var_4 = 2;
    var_5 = 1.4;
    var_6 = 300;
  } else {
    var_3 = 7;
    var_4 = 1.2;
    var_5 = 1;
    var_6 = 300;
  }

  thread _id_D1E5(var_3, var_4, var_5, var_6);
}

_id_D322() {
  while(scripts\engine\utility::flag("low_g_on")) {
    level.player playSound("cracked_helmet_inhale_slow");
    wait(randomfloatrange(0.8, 1.8));
    level.player playSound("cracked_helmet_exhale_slow");
    wait(randomfloatrange(0.8, 1.8));
  }
}

_id_D1E5(var_0, var_1, var_2, var_3) {
  while(scripts\engine\utility::flag("low_g_on")) {
    wait 0.05;
    var_4 = level.player getvelocity();
    var_5 = length(var_4);

    if(var_5 > var_3) {
      if(level.player isonground()) {
        level.player setOrigin(level.player.origin + (0, 0, var_1));
        wait 0.05;
        level.player playSound("mvmt_cloth_npc_mantle");
        level.player playSound("breath_npc_run");

        for(var_6 = 0; var_6 < var_0; var_6++) {
          level.player _meth_8251((0, 0, var_6), 1);
          wait 0.05;
        }

        level.player _meth_8251((0, 0, 0), 0);

        if(scripts\engine\utility::cointoss()) {
          wait 0.15;
        }

        wait 0.1;
      }

      wait(var_2);
    }
  }
}

_id_D1E3(var_0) {
  if(scripts\engine\utility::flag("low_g_on")) {
    level.player setsuit("moon_low_g_interior");
    var_1 = [];
    var_1["g_speed"] = 75;
    var_1["friction"] = 1;
    thread _id_D1E9(var_1, var_0);
  }
}

_id_D1E8(var_0) {
  if(scripts\engine\utility::flag("low_g_on")) {
    level.player setsuit("moon_low_g_superjump");
  }
}

_id_D1E6(var_0) {
  scripts\engine\utility::flag_clear("low_g_on");
  level notify("gravity_restored");
  level.player setsuit("normal_sp");
  var_1 = level._id_C388;
  thread _id_D1E9(var_1, var_0);
}

_id_D1E2() {
  var_0 = [];
  var_0["bg_gravity"] = getdvarfloat("bg_gravity");
  var_0["g_speed"] = getdvarfloat("g_speed");
  var_0["friction"] = getdvarfloat("friction");
  var_0["bg_fallDamageMinHeight"] = getdvarfloat("bg_fallDamageMinHeight");
  var_0["bg_fallDamageMaxHeight"] = getdvarfloat("bg_fallDamageMaxHeight");
  var_0["bg_sprintLoopTimeScale"] = getdvarfloat("bg_sprintLoopTimeScale");
  var_0["jump_slowdownEnable"] = getdvarfloat("jump_slowdownEnable");
  var_0["bg_weaponBobAmplitudeStanding"] = getDvar("bg_weaponBobAmplitudeStanding");
  var_0["bg_weaponBobAmplitudeSprinting"] = getDvar("bg_weaponBobAmplitudeSprinting");
  var_0["mantle_enable"] = getdvarfloat("mantle_enable");
  var_0["doublejump"] = 1;
  var_0["wallrun"] = 1;
  var_0["bobrate"] = 1;
  level._id_C388 = var_0;
}

_id_D1E9(var_0, var_1) {
  var_0 _id_B0EC("bg_gravity", var_1);
  var_0 _id_B0EC("g_speed", var_1);
  var_0 _id_B0EC("friction", var_1);
  var_0 _id_B0EC("bg_fallDamageMinHeight", var_1);
  var_0 _id_B0EC("bg_fallDamageMaxHeight", var_1);
  var_0 _id_B0EC("bg_sprintLoopTimeScale", var_1);

  if(isDefined(var_1)) {
    wait(var_1);
  }

  var_0 _id_B0EC("mantle_enable");
  var_0 _id_B0EC("jump_slowdownEnable");
  var_0 _id_B0EC("bg_weaponBobAmplitudeStanding");
  var_0 _id_B0EC("bg_weaponBobAmplitudeSprinting");

  if(isDefined(var_0["doublejump"])) {
    level.player scripts\engine\utility::allow_doublejump(var_0["doublejump"]);
  }

  if(isDefined(var_0["wallrun"])) {
    level.player scripts\engine\utility::allow_wallrun(var_0["wallrun"]);
  }

  if(isDefined(var_0["bobrate"])) {
    level.player _meth_82B5(var_0["bobrate"]);
  }
}

_id_B0EC(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_1)) {
    if(isDefined(var_2[var_0])) {
      setsaveddvar(var_0, var_2[var_0]);
    }
  } else if(isDefined(var_2[var_0]))
    thread scripts\sp\utility::_id_AB9A(var_0, var_2[var_0], var_1);
}

_id_D1E4() {
  level endon("stop_moon_grav");
  var_0 = 0;
  var_1 = 0.1;
  var_2 = 0.05;
  var_3 = 0;
  var_4 = 1;
  var_5 = 50;
  var_6 = 80;
  var_7 = 0.085;
  var_8 = 1;

  for(;;) {
    if(level.player isjumping()) {
      var_8 = var_8 - var_7;

      if(var_8 < 0) {
        var_8 = 0;
      }
    } else {
      var_8 = 1;
      var_0 = 0;
    }

    if(level.player buttonPressed("BUTTON_A") && level.player isjumping()) {
      var_0 = var_0 + var_1;
    }

    if(var_0 > 1) {
      var_0 = 1;
    } else if(var_0 < 0) {
      var_0 = 0;
    }

    var_9 = scripts\sp\math::_id_6A8E(var_5, var_6, var_0);
    setsaveddvar("bg_gravity", var_9);
    var_10 = scripts\sp\math::_id_6A8E(0, 7, var_0 * var_8);
    level.player _meth_8251((0, 0, var_10), 1);
    wait 0.05;
  }
}

_id_8DED() {
  scripts\engine\utility::flag_set("flag_turning_flashlight_on");
  wait(randomfloatrange(1.0, 1.5));
  scripts\engine\utility::flag_clear("flag_turning_flashlight_on");
}

_id_6248(var_0) {
  _id_95A5();
  self._id_ACDF = 1.0;
  self._id_8632 = spawn("script_model", (0, 0, 0));
  self _meth_823F(self._id_8632);
  thread _id_11945();
}

_id_95A5() {
  level._id_D2FF = [];
  level._id_D2FF["pitch"]["min"] = -3;
  level._id_D2FF["pitch"]["max"] = 4;
  level._id_D2FF["yaw"]["min"] = -8;
  level._id_D2FF["yaw"]["max"] = 5;
  level._id_D2FF["roll"]["min"] = 3;
  level._id_D2FF["roll"]["max"] = 5;
}

_id_5594(var_0, var_1) {
  self notify("stop_limp");
  self notify("stop_random_blur");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0)) {
    self _meth_823F(undefined);
    setsaveddvar("player_sprintUnlimited", "0");
    self notify("stop_limp_forgood");
  } else {
    var_2 = randomfloatrange(2, 4);
    var_3 = _id_186F((0, 0, 0));
    self._id_8632 rotateTo(var_3, var_2, 0, var_2 / 2);
    self._id_8632 waittill("rotatedone");
  }

  setblur(0, randomfloatrange(0.5, 0.75));
}

_id_11945(var_0) {
  self endon("stop_limp");
  thread _id_D252();

  for(;;) {
    if(self playerads() > 0.3) {
      wait 0.05;
      continue;
    }

    var_1 = self getvelocity();
    var_2 = abs(var_1[0]) + abs(var_1[1]);

    if(var_2 < 10) {
      wait 0.05;
      continue;
    }

    var_3 = var_2 / self.player_speed;
    var_4 = randomfloatrange(level._id_D2FF["pitch"]["min"], level._id_D2FF["pitch"]["max"]);

    if(randomint(100) < 20) {
      var_4 = var_4 * 1.5;
    }

    var_5 = randomfloatrange(level._id_D2FF["roll"]["min"], level._id_D2FF["roll"]["max"]);
    var_6 = randomfloatrange(level._id_D2FF["yaw"]["min"], level._id_D2FF["yaw"]["max"]);
    var_7 = (var_4, var_6, var_5);
    var_7 = var_7 * var_3;
    var_7 = var_7 * self._id_ACDF;
    var_8 = randomfloatrange(2, 4);
    var_9 = randomfloatrange(2, 4);
    thread _id_11182(var_7, var_8, var_9);
    wait(var_8);
    self waittill("recovered");
  }
}

_id_11182(var_0, var_1, var_2, var_3) {
  self endon("stop_stumble");
  self endon("stop_limp");
  var_0 = _id_186F(var_0);
  self notify("stumble");
  self._id_8632 rotateTo(var_0, var_1, var_1 / 4 * 3, var_1 / 4);
  self._id_8632 waittill("rotatedone");
  var_4 = (randomfloat(4) - 4, randomfloat(5), 0);
  var_4 = _id_186F(var_4);
  self._id_8632 rotateTo(var_4, var_2, 0, var_2 / 2);
  self._id_8632 waittill("rotatedone");

  if(!isDefined(var_3)) {
    self notify("recovered");
  }
}

_id_D252() {
  self endon("dying");
  self endon("stop_random_blur");
  thread _id_D254();

  for(;;) {
    wait 0.05;

    if(randomint(100) > 10) {
      continue;
    }
    var_0 = randomint(3) + 4;
    var_1 = randomfloatrange(0.1, 0.5);
    var_2 = randomfloatrange(0.3, 1.5);
    setblur(var_0 * 1.2, var_1);
    wait(var_1);
    setblur(0, var_2);
    wait(var_2);
    wait(randomfloatrange(0, 1.5));
    scripts\engine\utility::waittill_notify_or_timeout("blur", 5);
  }
}

_id_D254() {
  self endon("dying");
  self waittill("stop_random_blur");
  wait 0.5;
  setblur(0, 0.5);
}

_id_BC14(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = self getlinkedparent();
  }

  if(!isDefined(var_3)) {
    if(var_2.model != "") {
      var_3 = getpartname(var_2.model, 0);
    }
  }

  thread _id_BC15(var_0, var_1, var_2, var_3);
}

_id_BC15(var_0, var_1, var_2, var_3) {
  self notify("stop_linkedmove");
  self endon("stop_linkedmove");
  var_4 = var_1;

  if(!isDefined(self._id_AD2F) || !isDefined(self._id_AD2F[0])) {
    self._id_AD2F = [];
    self._id_AD2F[0] = ::scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
    self._id_AD2F[1] = ::scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);

    if(isDefined(var_3)) {
      self._id_AD2F[0] linkTo(var_2, var_3);
      self._id_AD2F[1] linkTo(var_2, var_3);
    } else {
      self._id_AD2F[0] linkTo(var_2);
      self._id_AD2F[1] linkTo(var_2);
    }
  }

  self._id_AD2F[1] unlink();
  var_5 = anglesToForward(self.angles) * var_0[0];
  var_6 = anglestoright(self.angles) * var_0[1];
  var_7 = anglestoup(self.angles) * var_0[2];
  self._id_AD2F[1].origin = self._id_AD2F[1].origin + (var_5 + var_6 + var_7);

  if(isDefined(var_3)) {
    self._id_AD2F[1] linkTo(var_2, var_3);
  } else {
    self._id_AD2F[1] linkTo(var_2);
  }

  while(var_4 > 0) {
    self unlink();
    var_8 = scripts\sp\math::_id_C097(0, var_1, var_4);
    self.origin = self._id_AD2F[0].origin * var_8 + self._id_AD2F[1].origin * (1 - var_8);
    self.angles = self._id_AD2F[0].angles;

    if(isDefined(var_3)) {
      self linkTo(var_2, var_3);
    } else {
      self linkTo(var_2);
    }

    var_4 = var_4 - 0.05;
    wait 0.05;
  }

  self unlink();
  self.origin = self._id_AD2F[1].origin;
  self.angles = self._id_AD2F[1].angles;

  if(isDefined(var_3)) {
    self linkTo(var_2, var_3);
  } else {
    self linkTo(var_2);
  }

  self._id_AD2F[0] delete();
  self._id_AD2F[1] delete();
}

_id_186F(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[2];
  var_3 = anglestoright(self.angles);
  var_4 = anglesToForward(self.angles);
  var_5 = (var_3[0], 0, var_3[1] * -1);
  var_6 = (var_4[0], 0, var_4[1] * -1);
  var_7 = var_5 * var_1;
  var_7 = var_7 + var_6 * var_2;
  return var_7 + (0, var_0[1], 0);
}

_id_EA04(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(!_id_EA01(var_1)) {
    return;
  }
}

_id_EA03(var_0) {
  var_1 = getEnt(var_0, "script_noteworthy");

  if(!_id_EA01(var_1)) {
    return;
  }
}

_id_EA01(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
    return 1;
  }

  return 0;
}

_id_15F6(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1)) {
    scripts\sp\utility::_id_15F5(var_0);
  }
}

_id_15F4(var_0) {
  var_1 = getEnt(var_0, "script_noteworthy");

  if(isDefined(var_1)) {
    scripts\sp\utility::_id_15F3(var_0);
  }
}

_id_2723(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_3 = getEnt(var_0, "targetname");
    var_3 connectpaths();
    var_3 movez(var_2, 0.1);
    scripts\engine\utility::flag_wait(var_1);
    var_3 movez(var_2 * -1, 0.5);
    var_3 disconnectPaths();
    wait 0.5;
  }
}

_id_10198() {
  level._id_4D80 = undefined;
  level._id_10185 = 1;
  level._id_10199 = 1;
  level._id_1019B = (0, 0, 0);
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getscriptablearray("moon_shutters", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_1019D();
  }
}

_id_1019D() {
  var_0 = 0;
  var_1 = self.angles;
  var_2 = anglestoleft(var_1) * 410;
  var_3 = self.origin + var_2;
  var_4 = anglestoright(var_1) * 1035.0;
  var_5 = self.origin + var_4;
  var_6 = anglestoright(var_1) * 1000;
  var_7 = anglestoup(var_1) * 650.0;
  var_8 = var_6 + var_7;
  var_9 = self.origin + var_8;
  self._id_7258 = randomintrange(300, 310);
  var_10 = physics_volumecreate(var_5, 900, 900);
  var_10 _meth_852A(1, 0.2);
  var_11 = physics_volumecreate(var_3, 450, 450);
  var_11 physics_volumesetasfocalforce(1, var_9, self._id_7258);
  var_11 physics_volumesetactivator(1);
  var_12 = spawn("trigger_radius", var_3, 0, 450, 450);
  self waittill("scriptableNotification");
  level._id_4D80 = var_12;
  thread _id_1018C();

  if(level._id_10185 == 1) {
    thread _id_10185();
  }

  if(isDefined(self.script_noteworthy)) {
    var_13 = strtok(self.script_noteworthy, " ");

    foreach(var_15 in var_13) {
      switch (var_15) {
        case "tut_decomp":
          scripts\engine\utility::flag_set("blow_out_windows");
          break;
        case "dontavoid":
          break;
        case "shoot_at":
          var_0 = _func_313(var_3, (450, 450, 450), (0, 0, 0), "axis", "allies");
          createnavrepulsor("shutter_danger", -1, var_3, 300, 1, "allies", "axis");
          level._id_10199 = 0;
          break;
        default:
          var_0 = _func_313(var_3, (450, 450, 450), (0, 0, 0), "axis", "allies");
          createnavrepulsor("shutter_danger", -1, var_3, 300, 1, "allies", "axis");
          level notify(var_15);
          break;
      }
    }
  } else {
    var_0 = _func_313(var_3, (450, 450, 450), (0, 0, 0), "axis", "allies");
    createnavrepulsor("shutter_danger", -1, var_3, 300, 1, "allies", "axis");
  }

  self playSound("emergency_shutters_alarm");
  thread scripts\engine\utility::play_sound_in_space("moon_pa_warningdecompr", self.origin);
  level notify("window_broken");
  thread _id_FB67();
  wait 0.4;
  self waittill("scriptableNotification");
  thread _id_BB45(1.75, 0.75);
  setsaveddvar("r_reactiveMotionWindFrequencyScale", 7);
  setsaveddvar("r_reactiveMotionWindDir", anglestoright(var_1));
  var_17 = getaiunittypearray("axis", "soldier");
  var_18 = getaiunittypearray("allies", "soldier");
  var_19 = scripts\sp\utility::_id_7D80(var_3, var_17, 450);
  var_20 = scripts\sp\utility::_id_7D80(var_3, var_18, 450);
  thread _id_10191();
  radiusdamage(self.origin, 225.0, 90, 50);

  if(var_19.size > 0) {
    foreach(var_22 in var_19) {
      var_22 thread _id_1019A(self);
    }
  }

  if(var_20.size > 0) {
    foreach(var_22 in var_20) {
      var_22 thread _id_10194(self);
    }
  }

  var_11 physics_volumeenable(1);
  scripts\sp\utility::_id_65E0("shutter_closed");
  thread _id_10187();
  scripts\engine\utility::waitframe();
  var_10 physics_volumeenable(1);

  for(var_26 = 0; var_26 < 3.2; var_26 = var_26 + 0.05) {
    if(self._id_7258 < 5000) {
      self._id_7258 = self._id_7258 + self._id_7258 * 0.2;
    }

    var_11 physics_volumesetasfocalforce(1, var_9, self._id_7258);
    scripts\engine\utility::waitframe();
  }

  for(var_26 = 0; var_26 < 1.7; var_26 = var_26 + 0.05) {
    self._id_7258 = self._id_7258 - self._id_7258 * 0.2;
    var_11 physics_volumesetasfocalforce(1, var_9, self._id_7258);
    scripts\engine\utility::waitframe();
  }

  thread _id_BB45(1, 4);
  setsaveddvar("r_reactiveMotionWindFrequencyScale", 6);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "dontavoid") {
    level notify("dont_avoid_done");
  } else {
    destroynavobstacle(var_0);
    destroynavrepulsor("shutter_danger");
  }

  var_11 physics_volumeenable(0);
  level._id_1019B = level._id_1019B * 0.75;
  level.player _meth_8251(level._id_1019B);
  wait 0.2;
  setsaveddvar("r_reactiveMotionWindFrequencyScale", 5);
  level._id_1019B = level._id_1019B * 0.75;
  level.player _meth_8251(level._id_1019B);
  wait 0.2;
  setsaveddvar("r_reactiveMotionWindFrequencyScale", 4);
  level._id_1019B = level._id_1019B * 0.5;
  level.player _meth_8251(level._id_1019B);
  wait 0.2;
  setsaveddvar("r_reactiveMotionWindFrequencyScale", 3);
  level._id_1019B = level._id_1019B * 0.5;
  level.player _meth_8251(level._id_1019B);
  wait 0.2;
  setsaveddvar("r_reactiveMotionWindFrequencyScale", 1);
  level.player _meth_8251((0, 0, 0));
  wait 5;
  var_10 physics_volumeenable(0);
}

_id_1018C() {
  if(distance2d(level.player.origin, self.origin) < 787.5) {
    var_0 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 125), (0, 0, 0));
    var_1 = newhudelem();
    var_1.x = 32;
    var_1.y = 32;
    var_1.color = (0.7, 0, 0);
    var_1 setshader("hud_icon_window_shatter", 5, 5);
    var_1 setwaypoint(0, 1, 0);
    var_1 settargetEnt(var_0);
    var_1.alpha = 0;
    scripts\engine\utility::waitframe();
    var_1 fadeovertime(0.2);
    var_1.alpha = 1;
    self waittill("scriptableNotification");
    var_1 fadeovertime(0.2);
    var_1.alpha = 0;
    wait 0.2;
    var_0 delete();
    var_1 destroy();
  }
}

_id_FB67() {
  wait 2.7;
  self playSound("emergency_shutter_expl");
  var_0 = spawn("script_origin", self.origin);
  wait 0.3;
  var_0 playSound("emergency_shutter_wind_start");
  wait 0.5;
  var_0 scripts\sp\utility::_id_10461("emergency_shutter_wind_lp_lr", 1, 1.0, 1);
  self waittill("sfx_closing");
  self playSound("emergency_shutter_wind_stop");
  var_0 scripts\sp\utility::_id_10460(1.0, 1);
}

_id_BB45(var_0, var_1) {
  level notify("wind changed");
  level endon("wind changed");
  _id_BB46(var_0, var_1);
}

_id_BB46(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = var_1 / 0.05;
  }

  if(!isDefined(var_3)) {
    var_3 = var_0 * 5;
  }

  if(isDefined(var_4)) {
    var_5 = var_2 * var_4 / var_1;
  } else {
    var_5 = var_2 * 0.5;
  }

  var_6 = getdvarfloat("r_reactiveMotionWindStrength");
  var_7 = getdvarfloat("r_reactiveMotionWindAmplitudeScale");
  var_8 = (var_0 - var_7) / var_2;
  var_9 = (var_3 - var_6) / var_5;

  for(var_10 = 0; var_10 < var_2; var_10 = var_10 + 1) {
    var_7 = var_7 + var_8;
    var_6 = var_6 + var_9;
    setsaveddvar("r_reactiveMotionWindAmplitudeScale", var_7);

    if(var_10 < var_5) {
      setsaveddvar("r_reactiveMotionWindStrength", var_6);
    }

    wait(var_1 / var_2);
  }

  setsaveddvar("r_reactiveMotionWindAmplitudeScale", var_0);
  setsaveddvar("r_reactiveMotionWindStrength", var_3);
}

_id_10185() {
  level._id_10185 = 0;
  var_0 = [];
  var_0[0] = level.allies["salter"];
  var_0[1] = level.allies["marineCO"];
  var_1 = [];
  var_1[var_1.size] = "moon_omr_windowsblown";
  var_1[var_1.size] = "moon_omr_stayclearofthe";
  var_1[var_1.size] = "moon_omr_getawayfromthe";
  var_1[var_1.size] = "moon_omr_stayclearoftheglass";
  var_2 = [];
  var_2[var_2.size] = "moon_slt_windowsbroken";
  var_2[var_2.size] = "moon_slt_watchoutfordecompression";
  var_2[var_2.size] = "moon_slt_getaway";
  var_2[var_2.size] = "moon_slt_theglassisbreaking";
  wait 1;
  var_0 = sortbydistance(var_0, level.player.origin);

  if(var_0[0] == level.allies["salter"]) {
    var_3 = scripts\engine\utility::random(var_2);
    level.allies["salter"] scripts\sp\utility::_id_10346(var_3);
  } else if(var_0[0] == level.allies["marineCO"]) {
    var_4 = scripts\engine\utility::random(var_1);
    level.allies["marineCO"] scripts\sp\utility::_id_10346(var_4);
  }

  wait 3.5;
  var_0 = sortbydistance(var_0, level.player.origin);

  if(var_0[0] == level.allies["salter"]) {
    wait 1.25;
    level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_shuttersclosed");
  } else if(var_0[0] == level.allies["marineCO"])
    level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_shuttersclosing");

  wait 5;
  level._id_10185 = 1;
}

_id_10187() {
  self waittill("scriptableNotification");
  scripts\sp\utility::_id_65E1("shutter_closed");
  self notify("sfx_closing");
  self playSound("emergency_shutter_start");
  wait 0.4;
  self playSound("emergency_shutter_slat");
  wait 0.3;
  self playSound("emergency_shutter_slat");
  wait 0.4;
  self playSound("emergency_shutter_end");
  wait 0.4;
  thread scripts\engine\utility::play_sound_in_space("moon_pa_emergencyshutters", self.origin);
}

_id_1019A(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1 linkTo(self);
  var_2 = distance2d(self.origin, var_0.origin);
  var_3 = var_2 / 450;
  var_3 = min(var_3, 1);
  var_4 = 1 - var_3;
  wait(var_4);

  if(isDefined(self)) {
    var_1 playSound("generic_death_falling_scream");
    var_5 = _id_7C6A(var_0);
    self._id_4E2A = var_5;
    self _meth_81D0();
  }

  wait 1;
  var_1 delete();
}

_id_10195(var_0) {
  var_1 = scripts\sp\utility::_id_7C23();
  var_1._id_99E5 = 0;
  var_1.origin = var_0.origin;
  return var_1;
}

_id_10194(var_0) {
  if(isDefined(self)) {
    var_1 = _id_780C(var_0);
    self _meth_82A2(var_1);
  }
}

#using_animtree("generic_human");

_id_7C6A(var_0) {
  var_1 = vectortoangles(var_0.origin - self.origin);
  var_2 = self.angles[1] - var_1[1];
  var_2 = var_2 + 360;
  var_2 = int(var_2) % 360;

  if(var_2 > 350 || var_2 < 10) {
    return % moon_window_death_8;
  } else if(var_2 < 60) {
    return % moon_window_death_9;
  } else if(var_2 < 120) {
    return % moon_window_death_6;
  } else if(var_2 < 150) {
    return % moon_window_death_3;
  } else if(var_2 < 210) {
    return % moon_window_death_2;
  } else if(var_2 < 240) {
    return % moon_window_death_1;
  } else if(var_2 < 300) {
    return % moon_window_death_4;
  } else {
    return % moon_window_death_7;
  }
}

_id_780C(var_0) {
  var_1 = vectortoangles(var_0.origin - self.origin);
  var_2 = self.angles[1] - var_1[1];
  var_2 = var_2 + 360;
  var_2 = int(var_2) % 360;

  if(var_2 > 350 || var_2 < 10) {
    return % moon_window_suckout_ally_react_8;
  } else if(var_2 < 60) {
    return % moon_window_suckout_ally_react_9;
  } else if(var_2 < 120) {
    return % moon_window_suckout_ally_react_6;
  } else if(var_2 < 150) {
    return % moon_window_suckout_ally_react_3;
  } else if(var_2 < 210) {
    return % moon_window_suckout_ally_react_2;
  } else if(var_2 < 240) {
    return % moon_window_suckout_ally_react_1;
  } else if(var_2 < 300) {
    return % moon_window_suckout_ally_react_4;
  } else {
    return % moon_window_suckout_ally_react_7;
  }
}

_id_10191() {
  level.player endon("death");

  if(!level.player is_player_in_robot()) {
    if(distance2d(level.player.origin, self.origin) < 787.5) {
      level.player scripts\sp\utility::_id_D08C("ges_window_break_far");
      thread _id_10190();
    }
  }

  var_0 = _id_10195(self);
  var_1 = 0;

  while(var_1 < 1.7) {
    if(!level.player is_player_in_robot()) {
      if(distance2d(level.player.origin, self.origin) < 193.5) {
        _id_1018D();
      } else if(distance2d(level.player.origin, self.origin) < 787.5) {
        _id_10193(var_0);
      }

      var_1 = var_1 + 0.05;
    } else {
      var_1 = var_1 + 0.15;
      wait 0.1;
    }

    scripts\engine\utility::waitframe();
  }

  wait 2;
  var_0 delete();
}

is_player_in_robot() {
  if(_id_0E29::_id_87A7() == "controllingrobot") {
    return 1;
  }

  if(_id_0E29::_id_87A7() == "transitiontorobot") {
    return 1;
  }

  if(_id_0E29::_id_87A7() == "selfdestruct") {
    return 1;
  }

  if(_id_0E29::_id_87A7() == "end") {
    return 1;
  }

  return 0;
}

_id_10190() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_moon_camcentr_particulates"), level.player, "tag_origin");
  wait 3;
  killfxontag(scripts\engine\utility::getfx("vfx_moon_camcentr_particulates"), level.player, "tag_origin");
}

_id_1018D() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_1 = self.angles;
  var_2 = anglestoright(var_1) * 1000 * 3;
  var_3 = anglestoup(var_1) * 600.0;
  var_4 = var_2 + var_3;
  var_5 = self.origin + var_4;
  var_0.origin = self.origin + var_4;
  var_0.angles = self.angles - (0, 90, 0);
  _id_0B60::_id_DED1("moon_shutter_death", "ges_moon_suckout_death", "player_death_moon_suckout", undefined, 1);
  var_6 = _id_0B60::_id_792A("ges_moon_suckout_death");
  var_6._id_5965 = 1;
  level._id_BFF4 = 1;
  _id_0B60::_id_F55B(var_6);
  level.player _meth_823C(var_0, "tag_origin", 6, 2, 4);
  _id_0B60::_id_F322("MOON_PORT_WINDOW_DEATH");
  wait 0.05;
  level.player _meth_81D0();
}

_id_10193(var_0) {
  var_1 = _id_1018A(var_0);
  var_2 = self.origin - level.player.origin;
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectorNormalize(var_2);
  level._id_1019B = var_2 * var_1;
  level.player _meth_8251(level._id_1019B);
}

_id_1018A(var_0) {
  var_1 = distance2d(self.origin, level.player.origin);
  var_2 = var_1 / 900;
  var_2 = min(var_2, 1);
  var_3 = 1 - var_2;
  var_4 = var_3 * 50;
  var_0._id_99E5 = var_3;
  return var_4;
}

_id_CB28(var_0, var_1) {
  if(!isDefined(level._id_134F6)) {
    level._id_134F6 = [];
  }

  if(!isDefined(level._id_134F6[var_0])) {
    level._id_134F6[var_0] = [];

    foreach(var_4, var_3 in var_1) {
      level._id_134F6[var_0][var_4] = [var_3, 0];
    }
  }

  level._id_134F6[var_0] = ::scripts\engine\utility::array_randomize(level._id_134F6[var_0]);

  foreach(var_4, var_3 in level._id_134F6[var_0]) {
    if(var_3[1] == 0) {
      level._id_134F6[var_0][var_4][1] = level._id_134F6[var_0][var_4][1] + 1;
      return level._id_134F6[var_0][var_4][0];
    }
  }

  level._id_134F6[var_0][0][1] = level._id_134F6[var_0][0][1] + 1;
  return level._id_134F6[var_0][0][0];
}

_id_FA58() {
  var_0 = getEntArray("teleport_service_trig", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_1163E();
  }
}

_id_1163E() {
  var_0 = scripts\engine\utility::get_target_ent();
  var_0._id_57A5 = [];
  var_1 = scripts\engine\utility::getStructArray("teleport_service_node", "targetname");
  var_2 = [];
  var_3 = scripts\engine\utility::spawn_tag_origin();

  foreach(var_5 in var_1) {
    var_3.origin = var_5.origin;

    if(var_3 istouching(var_0)) {
      var_2[var_2.size] = var_5;
    }
  }

  var_3 delete();

  foreach(var_8 in level.allies) {
    var_8 thread _id_1163F(var_0);
  }

  self waittill("trigger");
  var_0 notify("teleporting");
  level notify("tp_service_used");
  var_10 = [];

  foreach(var_8 in level.allies) {
    if(scripts\engine\utility::array_contains(var_0._id_57A5, var_8) == 0 && _id_11A79(var_8)) {
      var_10[var_10.size] = var_8;
    }
  }

  foreach(var_8 in var_10) {
    foreach(var_5 in var_2) {
      if(!isDefined(var_5.claimed)) {
        var_5.claimed = 1;
        var_8 _meth_80F1(var_5.origin, var_5.angles);

        if(isDefined(self.script_noteworthy)) {
          var_8 scripts\sp\utility::_id_65E0(self.script_noteworthy);
          var_8 scripts\sp\utility::_id_65E1(self.script_noteworthy);
        }

        var_8 notify("goal");
        var_8 notify("teleported");
        break;
      }

      wait 0.2;
    }
  }

  var_0 delete();
  self delete();
}

_id_11A79(var_0) {
  var_1 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, var_0.origin);

  if(var_1 <= 0.2) {
    return 1;
  } else {
    return 0;
  }
}

_id_1163F(var_0) {
  self endon("death");
  var_0 endon("teleporting");

  while(self istouching(var_0) == 0) {
    wait 0.1;
  }

  var_0._id_57A5[var_0._id_57A5.size] = self;
}

_id_E45E(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_3)) {
    var_5 = var_3 / var_1;
    var_4 = var_1 - var_1 * randomfloat(var_5);
  } else
    var_4 = var_1 * randomfloat(1.0);

  var_6 = randomfloat(360.0);
  var_7 = sin(var_6);
  var_8 = cos(var_6);
  var_9 = var_4 * var_8;
  var_10 = var_4 * var_7;
  var_11 = 0;

  if(isDefined(var_2)) {
    var_11 = randomfloatrange(0, var_2);
  }

  var_9 = var_9 + var_0[0];
  var_10 = var_10 + var_0[1];
  var_11 = var_11 + var_0[2];
  return (var_9, var_10, var_11);
}

_id_B693() {
  var_0 = getEntArray("global_scanner_alarm_trig", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_53B7();
  }
}

_id_53B7() {
  for(;;) {
    self waittill("trigger");
    var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");

    foreach(var_2 in var_0) {
      playworldsound("moon_detector_beep", var_2.origin);
      playFX(level._effect["security_scan"], var_2.origin, anglesToForward(var_2.angles), anglestoup(var_2.angles));
    }

    wait 2;
  }
}

_id_2AE7() {
  if(scripts\engine\utility::flag("play_ambient_bink_mp")) {
    var_0 = 1;
    setsaveddvar("bg_cinematicFullScreen", "0");
    cinematicingameloopresident("moon_screen_destinations", 1);
  } else if(scripts\engine\utility::flag("play_ambient_bink_mp")) {
    var_0 = 2;
    setsaveddvar("bg_cinematicFullScreen", "0");
    cinematicingameloopresident("moon_newscast_quad", 1);
  } else
    var_0 = 0;

  for(;;) {
    var_1 = level scripts\engine\utility::waittill_any_return("play_ambient_bink_mp", "play_news_bink_mp", "stop_binks_mp");

    switch (var_1) {
      case "play_ambient_bink_mp":
        if(var_0 != 1) {
          var_0 = 1;
          setsaveddvar("bg_cinematicFullScreen", "0");
          cinematicingameloopresident("moon_screen_destinations", 1);
        }

        break;
      case "play_news_bink_mp":
        if(var_0 != 2) {
          var_0 = 2;
          setsaveddvar("bg_cinematicFullScreen", "0");
          cinematicingameloopresident("moon_newscast_quad", 1);
        }

        break;
      case "stop_binks_mp":
        if(var_0 != 0) {
          stopcinematicingame();
        }

        break;
      default:
        break;
    }

    _id_4132();
  }
}

_id_4132() {
  scripts\engine\utility::flag_clear("play_ambient_bink_mp");
  scripts\engine\utility::flag_clear("play_news_bink_mp");
}

_id_890B() {
  level.player endon("death");

  if(!isDefined(level.player.helmet)) {
    return;
  }
  level.player.helmet hide();

  while(isDefined(level.player.helmet)) {
    level.player scripts\sp\utility::_id_65E3("visor_active");
    level.player.helmet show();
    level.player scripts\sp\utility::_id_65E8("visor_active");
    scripts\engine\utility::flag_waitopen("pause_helmet_hiding");
    level.player.helmet hide();
  }
}

_id_D219() {
  for(;;) {
    var_0 = level scripts\engine\utility::waittill_any_return("player_indoor_p1", "player_indoor_p2", "player_indoor_p1_noblur", "player_indoor_p2_noblur", "player_outdoor_noblur");

    switch (var_0) {
      case "player_indoor_p1":
        setsaveddvar("sm_sunSampleSizeNear", 0.4);
        setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
        setsaveddvar("r_mbenable", 0);
        setsaveddvar("r_mbvelocityscale", 0.1);
        setsaveddvar("r_mbradialoverridechromaticaberration", 0.8);
        setsaveddvar("r_mbradialoverridedistortion", 0);
        setsaveddvar("r_dof_hq", 1);
        setsaveddvar("r_mbradialoverrideradius", 0.88);
        setsaveddvar("r_mbradialoverridestrength", 0.0015);
        break;
      case "player_indoor_p2":
        setsaveddvar("sm_sunSampleSizeNear", 0.6);
        setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
        setsaveddvar("r_mbenable", 0);
        setsaveddvar("r_mbvelocityscale", 0.1);
        setsaveddvar("r_mbradialoverridechromaticaberration", 0.8);
        setsaveddvar("r_mbradialoverridedistortion", 0);
        setsaveddvar("r_dof_hq", 1);
        setsaveddvar("r_mbradialoverrideradius", 0.88);
        setsaveddvar("r_mbradialoverridestrength", 0.0015);
        break;
      case "player_indoor_p1_noblur":
        setsaveddvar("sm_sunSampleSizeNear", 0.4);
        setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
        setsaveddvar("r_mbenable", 0);
        setsaveddvar("r_mbvelocityscale", 0);
        setsaveddvar("r_mbradialoverridechromaticaberration", 0);
        setsaveddvar("r_mbradialoverridedistortion", 0);
        setsaveddvar("r_dof_hq", 0);
        setsaveddvar("r_mbradialoverrideradius", 0);
        setsaveddvar("r_mbradialoverridestrength", 0);
        break;
      case "player_indoor_p2_noblur":
        setsaveddvar("sm_sunSampleSizeNear", 0.6);
        setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
        setsaveddvar("r_mbenable", 0);
        setsaveddvar("r_mbvelocityscale", 0);
        setsaveddvar("r_mbradialoverridechromaticaberration", 0);
        setsaveddvar("r_mbradialoverridedistortion", 0);
        setsaveddvar("r_dof_hq", 0);
        setsaveddvar("r_mbradialoverrideradius", 0);
        setsaveddvar("r_mbradialoverridestrength", 0);
        break;
      case "player_outdoor_noblur":
        setsaveddvar("sm_sunSampleSizeNear", 1.875);
        setsaveddvar("sm_sunCascadeSizeMultiplier1", 4);
        setsaveddvar("r_mbenable", 0);
        setsaveddvar("r_mbvelocityscale", 0);
        setsaveddvar("r_mbradialoverridechromaticaberration", 0);
        setsaveddvar("r_mbradialoverridedistortion", 0);
        setsaveddvar("r_dof_hq", 0);
        setsaveddvar("r_mbradialoverrideradius", 0);
        setsaveddvar("r_mbradialoverridestrength", 0);
        break;
      default:
        break;
    }

    _id_416E();
  }
}

_id_416E() {
  scripts\engine\utility::flag_clear("player_indoor_p1");
  scripts\engine\utility::flag_clear("player_indoor_p2");
  scripts\engine\utility::flag_clear("player_indoor_p1_noblur");
  scripts\engine\utility::flag_clear("player_indoor_p2_noblur");
  scripts\engine\utility::flag_clear("player_outdoor_noblur");
}

_id_7991(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_EE52)) {
      if(var_5._id_EE52 != var_2) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
      }

      continue;
    }

    var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

_id_968A() {
  level._id_4019["on"] = _id_7991("mn_hangar_terminal_claxon_geo", "script_noteworthy", "model_on");
  level._id_4019["off"] = _id_7991("mn_hangar_terminal_claxon_geo", "script_noteworthy", "model_off");
}

_id_BB2C(var_0) {
  scripts\engine\utility::waitframe();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = [];
  var_5 = [];
  var_6 = [];

  switch (var_0) {
    case "hangar":
      var_3 = level._id_4019;
      var_1 = "mn_hangar_terminal_claxon_light";
      var_2 = "capture_mount";
      var_6 = _id_7991("mn_hangar_terminal_claxon_geo", "script_noteworthy", "flare_struct");
      break;
  }

  wait 1;
  scripts\engine\utility::array_thread(var_6, ::_id_6E8F, var_2);
  var_7 = getEntArray(var_1, "targetname");

  while(!scripts\engine\utility::flag(var_2)) {
    foreach(var_9 in var_7) {
      _id_BA6E(var_3);
      var_9 setlightintensity(1.0);
      var_9 _meth_82FC((1, 0, 0));
    }

    wait 0.5;

    foreach(var_9 in var_7) {
      _id_BA6D(var_3);
      var_9 setlightintensity(0.0);
      var_9 _meth_82FC((1, 0, 0));
    }

    wait 0.5;
  }

  foreach(var_9 in var_7) {
    var_9 setlightintensity(0.0);
    var_9 _meth_82FC((1, 0, 0));
  }
}

_id_BA6E(var_0) {
  scripts\engine\utility::array_call(var_0["on"], ::show);
  scripts\engine\utility::array_call(var_0["off"], ::hide);
}

_id_BA6D(var_0) {
  scripts\engine\utility::array_call(var_0["on"], ::hide);
  scripts\engine\utility::array_call(var_0["off"], ::show);
}

_id_6E8F(var_0) {
  if(isDefined(self)) {
    var_1 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);

    while(!scripts\engine\utility::flag(var_0)) {
      playFXOnTag(scripts\engine\utility::getfx("vfx_moon_red_light_flare"), var_1, "tag_origin");
      wait 1;
      stopFXOnTag(scripts\engine\utility::getfx("vfx_moon_red_light_flare"), var_1, "tag_origin");
    }

    self delete();
  }
}

_id_1AC5(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "unknown";
  }

  if(var_0 == "red") {
    var_1 = getEntArray("airlock_beacon_light_green", "targetname");
    scripts\engine\utility::array_call(var_1, ::hide);
    var_1 = getEntArray("airlock_beacon_light_red", "targetname");
    scripts\engine\utility::array_call(var_1, ::show);
    var_2 = getEntArray("rogue_lights_airlock_green", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC86);
    var_2 = getEntArray("rogue_lights_airlock_green_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC86);
    var_2 = getEntArray("rogue_lights_airlock_red", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 15);
    var_2 = getEntArray("rogue_lights_airlock_red_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 1.5);
  } else if(var_0 == "instant_green") {
    var_1 = getEntArray("airlock_beacon_light_red", "targetname");
    scripts\engine\utility::array_call(var_1, ::hide);
    var_1 = getEntArray("airlock_beacon_light_green", "targetname");
    scripts\engine\utility::array_call(var_1, ::show);
    var_2 = getEntArray("rogue_lights_airlock_red", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC86);
    var_2 = getEntArray("rogue_lights_airlock_red_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC86);
    var_2 = getEntArray("rogue_lights_airlock_green", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 30);
    var_2 = getEntArray("rogue_lights_airlock_green_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 1.5);
  } else {
    var_1 = getEntArray("airlock_beacon_light_green", "targetname");
    scripts\engine\utility::array_call(var_1, ::hide);
    var_1 = getEntArray("airlock_beacon_light_red", "targetname");
    scripts\engine\utility::array_call(var_1, ::show);
    var_2 = getEntArray("rogue_lights_airlock_red", "targetname");
    var_3 = getEntArray("rogue_lights_airlock_red_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 15);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 1.5);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 13.5);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 1.3);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 11.5);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 1.15);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 9.5);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 1);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 7.5);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 0.8);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 5.5);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 0.7);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 3);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 0.6);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 0.5);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 0.5);
    wait 0.5;
    var_1 = getEntArray("airlock_beacon_light_red", "targetname");
    scripts\engine\utility::array_call(var_1, ::hide);
    var_1 = getEntArray("airlock_beacon_light_green", "targetname");
    scripts\engine\utility::array_call(var_1, ::show);
    var_2 = getEntArray("rogue_lights_airlock_red", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC86);
    var_2 = getEntArray("rogue_lights_airlock_red_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC86);
    var_2 = getEntArray("rogue_lights_airlock_green", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 30);
    var_2 = getEntArray("rogue_lights_airlock_green_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 1.5);
  }
}

_id_AC87(var_0) {
  _id_AC90(var_0, 0.5);
}

_id_AC86() {
  _id_AC90(0.0, 0.5);
}

_id_AC90(var_0, var_1) {
  var_2 = int(var_1 * 20);
  var_3 = self _meth_8134();
  var_4 = (var_0 - var_3) / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    thread _id_AC91(var_0);
    self setlightintensity(var_3 + var_5 * var_4);
    wait 0.05;
  }

  var_6[0] = self;

  if(isDefined(self._id_AD22)) {
    var_6 = scripts\engine\utility::array_combine(var_6, self._id_AD22);
  }

  foreach(var_8 in var_6) {
    var_8 thread _id_AC91(var_0);
    var_8 setlightintensity(var_0);
  }
}

_id_AC91(var_0) {
  if(!isDefined(self.script_threshold)) {
    return;
  }
  var_1 = var_0 > self.script_threshold;

  foreach(var_3 in self._id_AD83) {
    if(var_1 && !var_3._id_13438) {
      var_3._id_13438 = var_1;
      var_3 show();

      if(isDefined(var_3.effect)) {
        var_3.effect thread scripts\sp\utility::_id_E2B0();
      }

      continue;
    }

    if(!var_1 && var_3._id_13438) {
      var_3._id_13438 = var_1;
      var_3 hide();

      if(isDefined(var_3.effect)) {
        var_3.effect thread scripts\engine\utility::pauseeffect();
      }
    }
  }

  foreach(var_3 in self._id_12BB6) {
    if(!var_1 && !var_3._id_13438) {
      var_3._id_13438 = 1;
      var_3 show();
      continue;
    }

    if(var_1 && var_3._id_13438) {
      var_3._id_13438 = 0;
      var_3 hide();
    }
  }
}