/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_util.gsc
************************************************************/

func_36FF(var_00, var_01) {
  if(!isDefined(var_01) && isDefined(self.angles))
    var_01 = self.angles;

  var_02 = anglesToForward(var_01) * var_0[0];
  var_03 = anglestoright(var_01) * var_0[1];
  var_04 = anglestoup(var_01) * var_0[2];
  var_05 = self.origin + var_02 + var_03 + var_04;
  return var_05;
}

func_BC53(var_00) {
  var_01 = getent(var_00, "targetname");

  if(isDefined(var_01)) {} else
    var_01 = scripts\engine\utility::getstruct(var_00, "targetname");

  level.player setorigin(var_1.origin);

  if(!isDefined(var_1.angles))
    var_1.angles = (0, 0, 0);

  var_02 = undefined;

  if(isDefined(var_1.target))
    var_02 = getent(var_1.target, "targetname");

  if(isDefined(var_02))
    level.player setplayerangles(vectortoangles(var_2.origin - var_1.origin));
  else
    level.player setplayerangles(var_1.angles);

  if(!scripts\engine\utility::array_contains(level.struct, var_01))
    var_01 delete();
}

func_F5A4() {
  _physics_setgravity((0, 0, 0));
  thread scripts\sp\utility::func_241F(0);
}

func_3C46(var_00, var_01, var_02) {
  level notify("new_map_sunlight");
  level endon("new_map_sunlight");

  if(var_02 <= 0.05) {
    func_3C48(var_00, var_01);
    return;
  }

  var_03 = level.func_111D0.suncolor;
  var_04 = var_3[0];
  var_05 = var_3[1];
  var_06 = var_3[2];
  var_07 = level.func_111D0.func_99E5;
  var_08 = var_0[0];
  var_09 = var_0[1];
  var_10 = var_0[2];
  var_11 = var_08 - var_04;
  var_12 = var_09 - var_05;
  var_13 = var_10 - var_06;
  var_14 = var_01 - var_07;
  var_15 = var_11 * (1 / (var_02 + 0.05) * 0.05);
  var_16 = var_12 * (1 / (var_02 + 0.05) * 0.05);
  var_17 = var_13 * (1 / (var_02 + 0.05) * 0.05);
  var_18 = var_14 * (1 / (var_02 + 0.05) * 0.05);

  while(var_02 > 0) {
    var_02 = var_02 - 0.05;
    var_04 = var_04 + var_15;
    var_05 = var_05 + var_16;
    var_06 = var_06 + var_17;
    var_07 = var_07 + var_18;
    var_03 = (var_04, var_05, var_06);
    func_3C48(var_03, var_07);
    wait 0.05;
  }

  func_3C48(var_00, var_01);
}

func_3C44(var_00, var_01) {
  level notify("new_map_sunangles");
  level endon("new_map_sunangles");

  if(var_01 <= 0.05) {
    func_3C45(var_00);
    return;
  }

  var_02 = level.func_111D0.func_1120D;
  var_03 = anglesToForward(level.func_111D0.func_1120D);
  var_04 = anglestoright(level.func_111D0.func_1120D);
  var_05 = anglestoup(level.func_111D0.func_1120D);
  var_06 = anglesToForward(var_00);
  var_07 = anglestoright(var_00);
  var_08 = anglestoup(var_00);
  var_09 = var_06 - var_03;
  var_10 = var_07 - var_04;
  var_11 = var_08 - var_05;
  var_12 = var_09 * (1 / (var_01 + 0.05) * 0.05);
  var_13 = var_10 * (1 / (var_01 + 0.05) * 0.05);
  var_14 = var_11 * (1 / (var_01 + 0.05) * 0.05);

  while(var_01 > 0) {
    var_01 = var_01 - 0.05;
    var_03 = var_03 + var_12;
    var_04 = var_04 + var_13;
    var_05 = var_05 + var_14;
    var_02 = _axistoangles(vectornormalize(var_03), vectornormalize(var_04), vectornormalize(var_05));
    func_3C45(var_02);
    wait 0.05;
  }

  func_3C45(var_00);
}

func_3C47(var_00, var_01) {
  level notify("new_map_sunfx_offset");
  level endon("new_map_sunfx_offset");

  if(var_01 <= 0.05) {
    level.func_111D0.func_75AC = var_00;
    return;
  }

  var_02 = level.func_111D0.func_75AC;
  var_03 = anglesToForward(level.func_111D0.func_75AC);
  var_04 = anglestoright(level.func_111D0.func_75AC);
  var_05 = anglestoup(level.func_111D0.func_75AC);
  var_06 = anglesToForward(var_00);
  var_07 = anglestoright(var_00);
  var_08 = anglestoup(var_00);
  var_09 = var_06 - var_03;
  var_10 = var_07 - var_04;
  var_11 = var_08 - var_05;
  var_12 = var_09 * (1 / (var_01 + 0.05) * 0.05);
  var_13 = var_10 * (1 / (var_01 + 0.05) * 0.05);
  var_14 = var_11 * (1 / (var_01 + 0.05) * 0.05);

  while(var_01 > 0) {
    var_01 = var_01 - 0.05;
    var_03 = var_03 + var_12;
    var_04 = var_04 + var_13;
    var_05 = var_05 + var_14;
    var_02 = _axistoangles(vectornormalize(var_03), vectornormalize(var_04), vectornormalize(var_05));
    level.func_111D0.func_75AC = var_02;
    wait 0.05;
  }

  level.func_111D0.func_75AC = var_00;
}

func_3C45(var_00) {
  _lerpsunangles(level.func_111D0.func_1120D, var_00, 0.05);
  level.func_111D0.func_1120D = var_00;
  func_0B0A::func_1121E("default", 0);
}

func_3C48(var_00, var_01) {
  level.func_111D0.suncolor = var_00;
  level.func_111D0.func_99E5 = var_01;
  _setsuncolorandintensity(level.func_111D0.suncolor[0], level.func_111D0.suncolor[1], level.func_111D0.suncolor[2], level.func_111D0.func_99E5);
}

func_48BF(var_00) {
  if(!isDefined(level.allies))
    level.allies = [];

  if(!isDefined(var_00))
    var_00 = ["admiral", "salter", "eth3n"];

  foreach(var_02 in var_00) {
    if(isDefined(level.allies[var_02]) && isalive(level.allies[var_02])) {
      continue;
    }
    level.allies[var_02] = scripts\sp\utility::func_107EA(var_02, 1);
    level.allies[var_02].grenadeammo = 0;
    level.allies[var_02] scripts\sp\utility::func_B14F();
    level.allies[var_02] _meth_8250(0);
    level.allies[var_02] scripts\sp\utility::func_F3B5("b");
    level.allies[var_02] _meth_8504(1, "soldier");
    level.allies[var_02].func_1FBB = var_02;

    if(var_02 == "admiral")
      level.allies["admiral"].name = "Raines";
    else if(var_02 == "salter")
      level.allies["salter"].name = "Salter";
    else if(var_02 == "eth3n")
      level.allies["eth3n"].name = "Ethan";

    var_03 = func_7EFB(var_02);

    if(isDefined(var_03))
      level.allies[var_02] scripts\sp\utility::func_72EC(var_03, "primary");
  }
}

func_7EFB(var_00) {
  var_1["admiral"] = "iw7_ake";
  var_1["salter"] = "iw7_m4+reflex";
  var_1["eth3n"] = "iw7_fhr";

  if(isDefined(var_1[var_00]))
    return var_1[var_00];
}

func_BC05(var_00, var_01) {
  func_48BF(var_01);

  if(!isDefined(var_01))
    var_01 = ["admiral", "salter", "eth3n"];

  if(scripts\engine\utility::array_contains(var_01, "admiral"))
    func_1683(level.allies["admiral"], var_00 + "_admiral", 1);

  if(scripts\engine\utility::array_contains(var_01, "salter"))
    func_1683(level.allies["salter"], var_00 + "_salter", 1);

  if(scripts\engine\utility::array_contains(var_01, "eth3n"))
    func_1683(level.allies["eth3n"], var_00 + "_eth3n", 1);
}

func_1683(var_00, var_01, var_02) {
  if(!isDefined(var_00)) {
    return;
  }
  var_03 = scripts\engine\utility::getstruct(var_01, "targetname");

  if(!isDefined(var_03)) {
    var_01 = tolower(var_01);
    var_03 = scripts\engine\utility::getstruct(var_01, "targetname");
  }

  if(!isDefined(var_03)) {
    var_01 = tolower(var_01);
    var_03 = getnode(var_01, "targetname");
  }

  if(!isDefined(var_03)) {}

  if(!isDefined(var_3.angles))
    var_3.angles = (0, 0, 0);

  if(isplayer(var_00)) {
    var_00 setplayerangles(var_3.angles);
    var_00 setorigin(var_3.origin);
  } else if(isai(var_00)) {
    var_00 _meth_80F1(var_3.origin, var_3.angles);
    var_04 = var_0.func_164D[var_0.asmname].func_4BC0;
    var_05 = anim.asm[var_0.asmname];
    var_06 = var_5.states[var_04];

    if(isDefined(var_6.func_C704))
      var_00 func_0A1E::func_237F(var_6.func_C704);

    if(isDefined(var_02) && var_02)
      var_00 give_mp_super_weapon(var_3.origin);
  }
}

func_C120(var_00, var_01) {
  if(!isDefined(self.script_noteworthy))
    return 0;

  var_00 = tolower(var_00);
  var_02 = tolower(self.script_noteworthy);

  if(!isDefined(var_01)) {
    if(var_02 == var_00)
      return 1;

    return 0;
  }

  var_03 = strtok(var_02, var_01);

  foreach(var_05 in var_03) {
    if(var_05 == var_00)
      return 1;
  }

  return 0;
}

func_C8ED(var_00, var_01) {
  if(!isDefined(self.script_parameters))
    return 0;

  var_00 = tolower(var_00);
  var_02 = tolower(self.script_parameters);

  if(!isDefined(var_01)) {
    if(var_02 == var_00)
      return 1;

    return 0;
  }

  var_03 = strtok(var_02, var_01);

  foreach(var_05 in var_03) {
    if(var_05 == var_00)
      return 1;
  }

  return 0;
}

func_518F() {
  if(isDefined(self.func_B14F))
    scripts\sp\utility::func_1101B();

  self delete();
}

func_CA95(var_00, var_01) {
  self _meth_84E5(0.0);
  scripts\sp\utility::func_F492(1);
  var_02 = func_0E26::func_10679(var_00);
  var_02 scripts\sp\utility::func_B14F(1);

  if(!isDefined(var_02)) {
    return;
  }
  var_02 scripts\sp\utility::func_F492(1);
  var_02 endon("death");

  if(isDefined(var_01)) {
    var_2.func_55B1 = 1;
    wait(var_01);
    var_2.func_55B1 = undefined;
  }

  return var_02;
}

func_EF24(var_00) {
  scripts\engine\utility::waitframe();
  var_01 = getentitylessscriptablearrayinradius(var_00, "targetname");
  var_02 = getEntArray("generic_civilian_bodyonly", "targetname");

  foreach(var_04 in var_01) {
    if(!isDefined(var_4.script_noteworthy)) {
      continue;
    }
    if(var_4.model == "veh_civ_lnd_un_hatchback_static_black") {
      continue;
    }
    if(var_4.model == "veh_civ_lnd_un_hatchback_static_blue") {
      continue;
    }
    var_05 = [];
    var_06 = [];
    var_07 = strtok(var_4.script_noteworthy, " ");

    foreach(var_09 in var_07) {
      var_10 = strtok(var_09, "_");

      if(var_10[0] == "car") {
        var_5[var_5.size] = var_10[1];
        continue;
      }

      if(var_10[0] == "body") {
        var_6[var_6.size] = var_10[1];
        continue;
      }

      if(var_10[0] == "c") {
        var_5[var_5.size] = var_10[1];
        continue;
      }

      if(var_10[0] == "b")
        var_6[var_6.size] = var_10[1];
    }

    if(var_5.size)
      radiusdamage(var_4.origin + (0, 0, 15), 24, 1, 1);

    foreach(var_13 in var_05) {
      var_14 = "ph_veh_hatchback_opendoor_" + var_13;
      var_04 give_attacker_kill_rewards(scripts\sp\utility::func_7DC3(var_14));
    }

    foreach(var_13 in var_06) {
      var_17 = scripts\engine\utility::random(var_02);
      var_18 = var_17 scripts\sp\utility::func_10619(1);
      var_18.origin = var_04 gettagorigin("tag_origin");
      var_18.angles = var_04 gettagangles("tag_origin");
      var_19 = "dead_car_civi_" + var_13;

      if(!isDefined(var_4.func_4DED))
        var_4.func_4DEE = [];

      var_4.func_4DEE[var_4.func_4DEE.size] = var_18;

      if(var_13 == "driverwindow" || var_13 == "passengerwindow" || var_13 == "driverdoor" || var_13 == "driver") {
        radiusdamage(var_4.origin + (0, 0, 15), 24, 1, 1);
        var_04 hidepart("TAG_WINDSHIELD_FRONT", var_4.model);
        var_04 hidepart("TAG_WINDOW_FRONT_LEFT", var_4.model);
        var_18 thread func_DC18();
      }

      if(isDefined(var_18.voice) && var_18.voice == "unitednationsfemale")
        var_18.origin = var_18.origin + (0, 0, -2);

      var_18 scripts\engine\utility::delaycall(0.05, ::linkto, var_04, "tag_body");
      var_18 thread scripts\sp\anim::func_1ECA(var_18, var_19);
    }
  }
}

func_DC18() {
  self endon("death");
  self setCanDamage(1);
  self solid();
  self.health = 500;
  wait 2;

  for(;;) {
    self waittill("damage", var_00, var_00, var_00, var_00, var_01);

    if(isDefined(var_01) && isexplosivedamagemod(var_01)) {
      func_0C60::func_58B8();
      self delete();
      return;
    }
  }
}

func_EF26(var_00) {
  scripts\engine\utility::waitframe();
  var_01 = getentitylessscriptablearrayinradius(var_00, "targetname");

  foreach(var_03 in var_01) {
    if(isDefined(var_3.func_4DEE))
      scripts\sp\utility::func_228A(var_3.func_4DEE);
  }
}

func_EF25() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_00, var_01);

    if(!isDefined(var_01)) {
      continue;
    }
    if(var_01 == level.player) {
      break;
    }
  }

  thread scripts\engine\utility::play_loop_sound_on_entity("ph_hill_streets_car_alarm");
}

func_D20D() {
  self endon("entitydeleted");
  var_00 = getent("ocean_clip", "targetname");

  if(isDefined(var_00))
    var_00 delete();

  for(;;) {
    self waittill("trigger");
    level.player thread scripts\sp\utility::func_D2CD(25, 0.05);
    level.player setstance("stand");
    level.player allowjump(0);
    level.player getnumberoffrozenticksfromwave(0);
    level.player getnumownedactiveagents(0);
    level.player getnumownedagentsonteambytype(0);
    level.player setwatersheeting(1, 2);
    level.player thread func_D20C();

    while(level.player istouching(self)) {
      if(length(level.player getvelocity()) < 1)
        wait 0.1;
      else
        wait 0.05;

      var_01 = level.player.origin;
      var_01 = var_01 + (0, 0, 46);
    }

    level.player notify("left_ocean");
    level.player thread scripts\sp\utility::func_D2CD(100, 0.05);
    level.player allowjump(1);
    level.player getnumberoffrozenticksfromwave(1);
    level.player getnumownedactiveagents(1);
    level.player getnumownedagentsonteambytype(1);
  }
}

func_D20B(var_00) {
  var_01 = var_0.origin;
  var_00 movez(-100, 0.75);
  level.player waittill("left_ocean");
  var_0.origin = var_01;
}

func_D20C() {
  self endon("left_ocean");
  self playSound("ph_water_splash_plr");
  var_00 = 45;
  var_01 = 1;

  for(;;) {
    var_02 = length(level.player getvelocity());

    if(var_02 < 15) {
      wait 0.05;
      continue;
    }

    if(var_02 > var_00)
      var_02 = var_00;

    var_03 = var_00 / var_02;
    var_04 = var_01 * var_03;
    level.player playSound("ph_step_water_plr");
    wait(var_04);
  }
}

func_39BC(var_00, var_01) {
  self endon("reached_end_node");
  self endon("death");
  func_0B0F::func_1D84();
  var_02 = undefined;

  for(;;) {
    self waittill("noteworthy", var_03);
    var_04 = strtok(var_03, " ");

    foreach(var_06 in var_04) {
      switch (var_06) {
        case "start_entry":
          var_02 = scripts\engine\utility::spawn_tag_origin();
          var_02 linkto(self, "fx_entryburn_1", (0, 0, 0), (0, 0, 0));
          playFXOnTag(scripts\engine\utility::getfx("enemy_entry_fireball_base_a"), var_02, "tag_origin");
          break;
        case "stop_entry":
          stopFXOnTag(scripts\engine\utility::getfx("enemy_entry_fireball_base_a"), var_02, "tag_origin");
          var_02 delete();
          break;
        case "fire_missiles":
          self notify("stop_fire_missiles");
          var_07 = self.func_4BF7;
          var_08 = var_07 scripts\sp\utility::func_7A97();
          var_09 = func_0B0F::func_39D3(var_08);

          foreach(var_11 in var_09)
          thread func_0B0F::func_3987(var_11, [1, 3], [0.25, 0.5], undefined, undefined, var_00, var_01);

          break;
        case "stop_fire_missiles":
          self notify("stop_fire_missiles");
          break;
      }
    }
  }
}

func_13D54() {
  var_00 = getEntArray("window_decals", "targetname");
  scripts\engine\utility::array_thread(var_00, ::func_13D51);
}

func_13D51() {
  self endon("death");
  var_00 = getglass(self.target);

  if(!isDefined(var_00)) {
    return;
  }
  while(!isglassdestroyed(var_00))
    wait 0.05;

  self delete();
}

func_13D53() {
  var_00 = getEntArray("window_decals", "targetname");
  scripts\sp\utility::func_228A(var_00);
}

func_1CC5() {
  self endon("death");
  setdvarifuninitialized("ally_advance_debug", 0);

  if(!isDefined(level.func_A881))
    level.func_A881 = undefined;

  var_00 = getent(self.target, "targetname");
  var_01 = getent(var_0.target, "targetname");
  var_01 endon("trigger");
  var_01 endon("entitydeleted");
  self waittill("trigger");
  var_02 = undefined;

  if(func_C8ED("retriggerable", " "))
    var_02 = 1;

  if(!func_C8ED("skip_global_endon", " ") && !isDefined(var_02)) {
    level notify("new_ally_advance_trigger");
    level endon("new_ally_advance_trigger");
  }

  var_03 = [];
  var_04 = var_00 scripts\sp\utility::func_7A8F();

  foreach(var_06 in var_04) {
    if(var_06 func_C8ED("advance_reinforcement", " ")) {
      var_3[var_3.size] = var_06;
      continue;
    }

    if(var_06 func_C8ED("advance_ender", " "))
      var_06 endon("trigger");
  }

  if(isDefined(self.func_EDA0))
    scripts\engine\utility::flag_wait(self.func_EDA0);

  scripts\sp\utility::script_delay();
  func_1CC6(var_01, var_00, var_03, var_02);

  foreach(var_06 in var_04) {
    if(var_06 func_C8ED("advance_activate", " ") || isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "advance_activate")
      var_06 scripts\sp\utility::func_15F1();

    if(var_06 func_C8ED("advance_disable", " "))
      var_06 scripts\engine\utility::trigger_off();

    if(var_06 func_C8ED("advance_delete", " "))
      var_06 delete();
  }

  if(isDefined(var_1.spawnflags) && var_1.spawnflags == 64)
    var_01 scripts\engine\utility::trigger_off();

  var_01 notify("trigger");
}

func_1CC6(var_00, var_01, var_02, var_03) {
  var_00 endon("entitydeleted");
  var_00 endon("trigger");
  var_04 = 0;

  if(isDefined(var_1.script_count))
    var_04 = var_1.script_count;

  for(;;) {
    wait 0.25;

    if(isDefined(var_03)) {
      if(isDefined(level.func_A881) && level.func_A881 == self) {} else if(!level.player istouching(self))
        continue;
    }

    level.func_A881 = self;
    var_05 = _getaispeciesarray("axis", "all");
    var_05 = scripts\sp\utility::array_removedeadvehicles(var_05);
    var_06 = [];

    foreach(var_08 in var_05) {
      if(var_08 istouching(var_01))
        var_6[var_6.size] = var_08;
    }

    foreach(var_11 in var_02) {
      if(!isDefined(var_11)) {
        var_06 = scripts\engine\utility::array_remove(var_06, var_11);
        continue;
      }

      if(var_6.size <= var_11.script_count) {
        var_11 scripts\sp\utility::func_15F1();
        var_06 = scripts\engine\utility::array_remove(var_06, var_11);
      }
    }

    if(var_6.size <= var_04) {
      break;
    }
  }
}

func_1CC2(var_00, var_01) {
  setdvarifuninitialized("ally_advance_debug", 0);

  if(!getdvarint("ally_advance_debug")) {
    if(isDefined(level.func_1CC2)) {
      foreach(var_03 in level.func_1CC2)
      var_03 destroy();

      level.func_1CC2 = undefined;
      level.func_1CC3 = undefined;
    }

    return;
  }

  var_05 = 5;

  foreach(var_07 in var_00)
  thread scripts\sp\utility::draw_circle(var_7.origin, var_05, (1, 0, 0), 1, 0, var_05);

  if(!isDefined(level.func_1CC2)) {
    level.func_1CC3 = 165;
    level.func_1CC2["aiAmount"] = func_1CC4();
    level.func_1CC2["goalAmount"] = func_1CC4();
  }

  level.func_1CC2["aiAmount"] give_zap_perk("AI AMOUNT : " + var_0.size);
  level.func_1CC2["goalAmount"] give_zap_perk("GOAL AMOUNT : " + var_01);
}

func_1CC4() {
  var_00 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_0.x = 0;
  var_0.y = level.func_1CC3;
  level.func_1CC3 = level.func_1CC3 + 15;
  return var_00;
}

func_117BC() {
  self endon("death");

  for(;;) {
    self waittill("trigger");
    var_00 = func_7D1C();

    foreach(var_02 in var_00) {
      if(!isDefined(var_02) || !isalive(var_02)) {
        continue;
      }
      var_03 = var_02 getthreatbiasgroup();

      if(var_03 == self.func_EEE2) {
        continue;
      }
      thread func_117BD(var_02, var_03);
    }

    wait 0.15;
  }
}

func_7D1C() {
  var_00 = undefined;

  switch (self.spawnflags) {
    case 1:
      var_00 = _getaiunittypearray("axis", "all");
      var_0[var_0.size] = level.player;
      break;
    case 2:
      var_00 = _getaiunittypearray("allies", "all");
      var_0[var_0.size] = level.player;
      break;
    case 3:
      var_01 = _getaiunittypearray("allies", "all");
      var_02 = _getaiunittypearray("axis", "all");
      var_00 = scripts\engine\utility::array_combine(var_01, var_02);
      var_0[var_0.size] = level.player;
      break;
    case 9:
      var_00 = _getaiunittypearray("axis", "all");
      break;
    case 10:
      var_00 = _getaiunittypearray("allies", "all");
      break;
    case 11:
      var_01 = _getaiunittypearray("allies", "all");
      var_02 = _getaiunittypearray("axis", "all");
      var_00 = scripts\engine\utility::array_combine(var_01, var_02);
      break;
  }

  var_03 = [];

  foreach(var_05 in var_00) {
    if(!isDefined(var_05) || !isalive(var_05)) {
      continue;
    }
    if(var_05 istouching(self))
      var_3[var_3.size] = var_05;

    wait 0.05;
  }

  return var_03;
}

func_117BD(var_00, var_01) {
  var_00 notify("new_threat_biasgroup");
  var_00 endon("new_threat_biasgroup");
  var_00 endon("death");
  var_00 setthreatbiasgroup(self.func_EEE2);

  while(isDefined(self) && var_00 istouching(self))
    wait 0.15;

  if(var_01 == "")
    var_00 setthreatbiasgroup();
  else
    var_00 setthreatbiasgroup(var_01);
}

func_323A() {
  self endon("death");

  if(isDefined(self.script_ender))
    self endon(self.script_ender);

  var_00 = scripts\engine\utility::getstruct(self.target, "targetname");
  var_01 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_02 = 1;
  var_03 = 5;
  var_04 = 0.5;
  var_05 = 1.5;

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var_06 = undefined;

      if(isDefined(var_0.height))
        var_06 = var_0.height;

      var_07 = undefined;

      if(isDefined(var_1.height))
        var_07 = var_1.height;

      var_08 = func_E45E(var_0.origin, var_0.radius, var_06);
      var_09 = func_E45E(var_1.origin, var_1.radius, var_07);
      var_10 = randomintrange(1, 5);

      for(var_11 = 0; var_11 < var_10; var_11++) {
        magicbullet("generic_mg_turret_nosound", var_08, var_09);
        wait 0.1;
      }

      wait(randomfloatrange(0.5, 1.5));
    }
  }
}

func_3FAC(var_00) {
  if(isDefined(self.team) && self.team == "neutral") {
    self endon("death");
    self endon("stop_screaming");
    var_00 = scripts\engine\utility::ter_op(isDefined(var_00), var_00, 8);
    thread scripts\sp\utility::func_C12D("stop_screaming", var_00);

    if(distance2dsquared(self.origin, level.player.origin) > squared(400))
      childthread func_3FAB();

    wait(randomfloatrange(0.25, 1));
    var_01 = issubstr(self.model, "female");

    for(;;) {
      self playSound(func_78A4(var_01));
      wait(randomfloatrange(1.5, 2.5));
    }
  }
}

func_78A4(var_00) {
  if(!var_00) {
    var_01 = [];
    var_1[var_1.size] = "phstreets_fcv3_cryscream" + randomintrange(1, 7);
    var_1[var_1.size] = "phstreets_fcv2_cryscream" + randomintrange(1, 2);
    var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
    var_1[var_1.size] = "phstreets_fcv4_cryscream1";
    var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
    var_1[var_1.size] = "phstreets_fc1_allezvite";
    var_1[var_1.size] = "phstreets_fcv1_screamsatguns";
    var_1[var_1.size] = "phstreets_fc1_pourquoifontils";
    var_1[var_1.size] = "phstreets_fcv1_cryingjeneveux";
    var_1[var_1.size] = "phstreets_fc2_rungetoutofhere";
    var_1[var_1.size] = "phstreets_fc1_getoutoftheway";
    var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
    var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
    var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
    var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
    var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
    return scripts\engine\utility::random_weight_sorted(var_01);
  }

  var_02 = [];
  var_2[var_2.size] = "phstreets_mcv5_cryscream" + randomintrange(1, 3);
  var_2[var_2.size] = "phstreets_mcv1_cryscream1";
  var_2[var_2.size] = "phstreets_mcv2_cryscream1";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_mcv3_cryscream1";
  var_2[var_2.size] = "phstreets_mcv4_cryscream1";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_cv2_screamsofpain";
  var_2[var_2.size] = "phstreets_cv2_questcequecest";
  var_2[var_2.size] = "phstreets_cv1_couriraller";
  var_2[var_2.size] = "phstreets_cv3_degagez";
  var_2[var_2.size] = "phstreets_cv1_nono";
  var_2[var_2.size] = "phstreets_unm2_watchhhoutt";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  return scripts\engine\utility::random_weight_sorted(var_02);
}

func_3FAB() {
  if(!isDefined(level.func_A896)) {
    level.func_A896 = gettime();
    _playworldsound("civi_screams", self.origin);
  } else if(gettime() - level.func_A896 > 4000) {
    _playworldsound("civi_screams", self.origin);
    level.func_A896 = gettime();
  }
}

func_19C5(var_00) {
  self notify("new_run_path");
  self endon("new_run_path");
  self endon("cancel_path");
  self endon("death");

  if(!isDefined(var_00))
    var_00 = scripts\sp\utility::func_7A96();

  thread func_3FAC();
  var_01 = var_00;

  for(;;) {
    self.func_4BEF = var_01;

    if(isDefined(var_1.target) && !isDefined(var_1.script_delay) && !isDefined(var_1.func_EDA0)) {
      if(isDefined(var_1.func_EDA0) && scripts\engine\utility::flag(var_1.func_EDA0)) {
        continue;
      }
      scripts\sp\utility::func_5504();
    }

    if(isDefined(var_1.animation))
      energy_getmax(var_01);
    else {
      self.goalradius = 64;

      if(isDefined(var_1.radius))
        self.goalradius = var_1.radius;

      if(isDefined(var_1.height))
        self.goalheight = var_1.height;

      if(isnode(var_01))
        self give_more_perk(var_01);
      else
        self give_mp_super_weapon(var_1.origin);

      self waittill("goal");
    }

    if(scripts\sp\utility::func_65DF("ai_move_think_animation"))
      scripts\sp\utility::func_65E8("ai_move_think_animation");

    scripts\sp\utility::func_61DB();

    if(isDefined(var_1.animation) && isDefined(var_1.func_EE06))
      thread hidefromplayer(var_01);

    if(isDefined(var_1.script_fxid))
      playFX(scripts\engine\utility::getfx(var_1.script_fxid), var_1.origin);

    if(isDefined(var_1.script_damage) && var_1.script_damage) {
      var_02 = 9999;
      var_03 = 9999;

      if(isDefined(var_1.func_EE99)) {
        var_02 = var_1.func_EE99;
        var_03 = var_1.func_EE98;
      }

      var_04 = var_1.script_radius;
      radiusdamage(var_1.origin, var_04, var_02, var_03);
    }

    if(isDefined(var_1.script_sound)) {
      if(var_01 func_C8ED("sound_on_ent", " "))
        thread scripts\sp\utility::play_sound_on_entity(var_1.script_sound);
      else
        _playworldsound(var_1.script_sound, var_1.origin);
    }

    if(isDefined(var_1.script_earthquake))
      thread scripts\engine\utility::do_earthquake(var_1.script_earthquake, var_1.origin);

    if(isDefined(var_1.func_EDE3))
      self.ignoreall = var_1.func_EDE3;

    if(isDefined(var_1.func_EDE4))
      self.ignoreme = var_1.func_EDE4;

    if(isDefined(var_1.script_linkto))
      thread func_19EF(var_01);

    if(isDefined(var_1.func_ED9E))
      scripts\engine\utility::flag_set(var_1.func_ED9E);

    if(isDefined(var_1.func_EDA0))
      scripts\engine\utility::flag_wait(var_1.func_EDA0);

    var_01 scripts\sp\utility::script_delay();

    if(isDefined(var_1.script_noteworthy) && isDefined(level.func_19C4[var_1.script_noteworthy]))
      self thread[[level.func_19C4[var_1.script_noteworthy]]](var_01);

    if(isDefined(var_1.func_ED56))
      scripts\sp\utility::func_51E1(var_1.func_ED56);

    if(isDefined(var_1.func_ED22)) {
      if(var_1.func_ED22)
        scripts\sp\utility::func_B14F();
      else
        scripts\sp\utility::func_1101B();
    }

    if(isDefined(var_1.animation)) {
      if(isDefined(var_1.func_EE06)) {
        var_05 = func_7822(var_01);
        var_05 notify("ai_move_think_stop_loop");
        self givescorefortrophyblocks();
      } else
        _meth_8426(var_01);
    }

    if(!isDefined(var_1.target)) {
      break;
    }
    var_01 = func_7E98(var_1.target, "targetname");
    self notify("new_path_goal");
  }

  self notify("completed_run_path");

  if(isDefined(var_1.func_ED43)) {
    if(isDefined(self.func_B14F))
      scripts\sp\utility::func_1101B();

    if(var_01 func_C8ED("bullet_impact", " "))
      func_19C3(var_01);

    scripts\sp\utility::func_54C6();
  }

  if(isDefined(var_1.func_ED54)) {
    if(isDefined(self.func_B14F))
      scripts\sp\utility::func_1101B();

    self delete();
  }
}

energy_getmax(var_00) {
  if(var_00 func_C8ED("no_reach")) {
    return;
  }
  var_01 = var_00;
  var_02 = var_00 scripts\sp\utility::func_7A97();

  foreach(var_04 in var_02) {
    if(var_04 func_C8ED("animnode"))
      var_01 = var_04;
  }

  var_01 scripts\sp\anim::func_1ECE(self, var_0.animation);
}

_meth_8426(var_00) {
  var_01 = func_7822(var_00);

  if(!isDefined(var_0.script_physics))
    var_01 thread scripts\sp\anim::func_1ECB(self, var_0.animation);
  else
    var_01 thread scripts\sp\anim::func_1EC7(self, var_0.animation);

  if(isDefined(var_0.func_ECED) && var_0.func_ECED) {
    self setCanDamage(1);
    scripts\sp\utility::func_F2A8(1);
  }

  if(isDefined(var_0.func_EE2C)) {
    thread energy_setmax(var_00);
    return;
  }

  var_02 = getanimlength(scripts\sp\utility::func_7DC3(var_0.animation));

  if(!scripts\sp\utility::func_65DF("ai_move_think_animation"))
    scripts\sp\utility::func_65E0("ai_move_think_animation");

  scripts\sp\utility::func_65E1("ai_move_think_animation");
  thread scripts\sp\utility::func_65DE("ai_move_think_animation", var_02);

  if(!isDefined(var_0.target))
    wait(var_02);
}

hidefromplayer(var_00) {
  var_01 = func_7822(var_00);
  var_01 thread scripts\sp\anim::func_1ECC(self, var_1.animation, "ai_move_think_stop_loop");
}

func_7822(var_00) {
  var_01 = var_00;
  var_02 = var_00 scripts\sp\utility::func_7A97();

  foreach(var_04 in var_02) {
    if(var_04 func_C8ED("animnode"))
      var_01 = var_04;
  }

  return var_01;
}

energy_setmax(var_00) {
  scripts\engine\utility::waitframe();
  self _meth_82B1(scripts\sp\utility::func_7DC3(var_0.animation), var_0.func_EE2C);
}

func_19EF(var_00) {
  var_01 = undefined;
  var_02 = var_00 scripts\sp\utility::func_7A97();

  foreach(var_04 in var_02) {
    if(isDefined(var_4.script_parameters) && var_4.script_parameters == "target") {
      var_01 = var_04;
      break;
    }
  }

  if(!isDefined(var_01)) {
    return;
  }
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  var_06 = var_01 scripts\engine\utility::spawn_tag_origin();
  var_07 = self.ignoreall;
  self.ignoreall = 0;
  self _meth_82DE(var_06);
  scripts\engine\utility::waittill_any("clear_targeting", "cancel_path", "new_path_goal", "death");

  if(isDefined(self) && isalive(self)) {
    self.ignoreall = var_07;
    self getplayerfromclientnum();
  }

  var_06 delete();
}

findpath() {
  var_00 = scripts\sp\utility::func_7A97();
  var_00 = scripts\engine\utility::array_add(var_00, self);

  foreach(var_02 in var_00) {
    if(!isDefined(var_2.script_fxid)) {
      continue;
    }
    var_03 = 0;

    if(isDefined(var_2.func_ED96))
      var_03 = var_2.func_ED96;

    scripts\engine\utility::noself_delaycall(var_03, ::playfx, scripts\engine\utility::getfx(var_2.script_fxid), var_2.origin);
  }
}

func_19C3(var_00) {
  var_01 = undefined;

  if(isDefined(var_00) && isDefined(var_0.func_EED9))
    var_01 = var_0.func_EED9;
  else
    var_01 = scripts\engine\utility::random(["j_head", "j_shoulder_le", "j_shoulder_ri", "tag_weapon_chest"]);

  playFXOnTag(scripts\engine\utility::getfx("vfx_ph_flesh_hit_body_large"), self, var_01);
  _playworldsound("phstreets_hill_npc_bullet_death", self gettagorigin(var_01));
}

func_7E98(var_00, var_01) {
  var_02 = getent(var_00, var_01);

  if(isDefined(var_02))
    return var_02;

  var_03 = getnode(var_00, var_01);

  if(isDefined(var_03))
    return var_03;

  return scripts\engine\utility::getstruct(var_00, var_01);
}

func_754C(var_00, var_01) {
  var_02 = spawn("script_origin", level.player.origin);
  wait 0.1;
  var_02 playSound("phstreets_bink3d_conceptofevil");
  _setsaveddvar("bg_cinematicFullScreen", "0");
  _cinematicingameloopresident(var_00);
  scripts\engine\utility::flag_wait(var_01);
  var_02 stopsounds();
  _stopcinematicingame();
  var_02 delete();
}

func_DD5A(var_00, var_01, var_02) {
  if(!isDefined(level.func_DD58))
    level.func_DD58 = [];

  level.func_DD58["limit"] = getdvarint("r_reactiveMotionHelicopterLimit");
  level.func_DD58["radius"] = getdvarint("r_reactiveMotionHelicopterRadius");
  level.func_DD58["strength"] = getdvarint("r_reactiveMotionHelicopterStrength");
  _setsaveddvar("r_reactiveMotionHelicopterLimit", var_00);
  _setsaveddvar("r_reactiveMotionHelicopterRadius", var_01);
  _setsaveddvar("r_reactiveMotionHelicopterStrength", var_02);
}

func_DD59() {
  _setsaveddvar("r_reactiveMotionHelicopterLimit", level.func_DD58["limit"]);
  _setsaveddvar("r_reactiveMotionHelicopterRadius", level.func_DD58["radius"]);
  _setsaveddvar("r_reactiveMotionHelicopterStrength", level.func_DD58["strength"]);
  level.func_DD58 = undefined;
}

func_1510(var_00) {
  level endon(var_00 + "_disable");
  var_01 = getEntArray(var_00, "script_noteworthy");
  scripts\engine\utility::array_thread(var_01, ::func_1511);

  for(;;) {
    wait(randomfloatrange(4, 8));
    var_01 = scripts\engine\utility::array_removeundefined(var_01);
    var_02 = func_7BFB(var_01);

    if(!var_2.size) {
      continue;
    }
    var_03 = scripts\engine\utility::random(var_02);
    var_02 = scripts\engine\utility::array_remove(var_02, var_03);
    var_03 thread func_150E();
    var_03 scripts\engine\utility::waittill_either("turret_on_target", "entitydeleted");

    if(!isDefined(var_03)) {
      continue;
    }
    var_03 scripts\engine\utility::delaythread(1, ::func_150C);
    var_04 = gettime();

    if(scripts\engine\utility::cointoss() && var_2.size) {
      var_02 = scripts\engine\utility::array_removeundefined(var_02);

      if(!var_2.size) {
        continue;
      }
      var_03 = scripts\engine\utility::random(var_02);
      var_03 thread func_150E();
      var_03 scripts\engine\utility::waittill_either("turret_on_target", "entitydeleted");

      if(!isDefined(var_03)) {
        continue;
      }
      if(gettime() - var_04 < 1000)
        wait 1;

      var_03 scripts\engine\utility::delaythread(1, ::func_150C);
    }
  }
}

#using_animtree("script_model");

func_150B() {
  self.disabled = 1;
  self notify("aatis_turret_disabled");
  self clearanim( % ph_aatis_gun_fire, 0.05);
  self cleartargetentity();
}

func_150F(var_00) {
  level notify(var_00 + "_disable");
  var_01 = getEntArray(var_00, "script_noteworthy");

  foreach(var_03 in var_01) {
    if(!isDefined(var_03)) {
      continue;
    }
    var_3.func_11583 delete();
    var_03 delete();
  }

  func_EA02(var_01);
}

func_150E() {
  self notify("stop_idle_rotation");
  var_00 = self.func_11583;
  var_01 = scripts\engine\utility::flat_angle(self gettagangles("j_anim_barrel_rot"));
  var_02 = anglesToForward(var_01);
  var_0.origin = self.origin + var_02 * 5000;
  var_03 = anglestoup(self.angles);
  var_0.origin = var_0.origin + var_03 * randomintrange(2500, 4500);
}

func_1511() {
  self notsolid();
  self setdefaultdroppitch(-30);
  self give_player_session_tokens("manual");
  self glinton(#animtree);
  self.func_DD7B = 1;
  var_00 = spawn("script_origin", self.origin);
  self settargetentity(var_00);
  self.func_11583 = var_00;
  thread func_14FE();
}

func_14FE() {
  self endon("death");
  self endon("stop_idle_rotation");
  self endon("aatis_turret_disabled");
  var_00 = self.func_11583;
  var_01 = anglesToForward(self.angles);
  var_0.origin = self.origin + var_01 * 5000;
  var_02 = anglestoup(self.angles);
  var_0.origin = var_0.origin + var_02 * 2500;
  var_03 = scripts\engine\utility::flat_angle(self.angles);

  for(;;) {
    var_04 = var_03 + (0, 90, 0);
    var_01 = anglesToForward(var_04);
    var_05 = self.origin + var_01 * 5000;
    var_0.origin = (var_5[0], var_5[1], var_0.origin[2]);
    self waittill("turret_on_target");
    var_03 = var_04;
  }
}

func_7BFB(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(!isDefined(var_03)) {
      continue;
    }
    if(isDefined(var_3.disabled))
      continue;
    else if(isDefined(var_3.func_DD7B))
      var_1[var_1.size] = var_03;
  }

  var_05 = cos(45);
  var_06 = [];
  var_07 = [];

  foreach(var_03 in var_01) {
    if(var_03 scripts\sp\utility::func_13D91(level.player getEye(), level.player getplayerangles(), var_3.origin, var_05)) {
      var_6[var_6.size] = var_03;
      continue;
    }

    var_7[var_7.size] = var_03;
  }

  var_10 = scripts\engine\utility::array_combine(var_06, var_07);
  return var_10;
}

func_150C(var_00) {
  self endon("death");
  self endon("aatis_turret_disabled");
  self.func_DD7B = undefined;
  self clearanim( % ph_aatis_gun_fire, 0.05);
  wait 0.05;
  self shootturret();
  self give_attacker_kill_rewards( % ph_aatis_gun_fire);
  self playSound("weap_aatis_fire");

  if(distance2dsquared(level.player.origin, self.origin) <= squared(20000)) {
    level.player playrumbleonentity("artillery_rumble");
    earthquake(0.2, 0.75, level.player.origin, 200);
  }

  if(!isDefined(var_00))
    childthread func_150D();
}

func_150D() {
  wait 5;
  thread func_14FE();
  wait 2;
  self.func_DD7B = 1;
}

func_035A(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self endon("stop_fire");
  self endon("death");
  var_05 = scripts\engine\utility::ter_op(isDefined(var_05), var_05, 0.15);
  var_07 = 0.6;
  var_08 = 1.2;

  if(isDefined(var_00)) {
    var_07 = var_0[0];
    var_08 = var_0[1];
  }

  for(;;) {
    wait(randomfloatrange(var_07, var_08));
    var_09 = randomintrange(8, 18);

    for(var_10 = 0; var_10 < var_09; var_10++) {
      if(isDefined(var_01)) {
        if(isDefined(var_06))
          self playSound(var_06);

        var_11 = undefined;

        if(isDefined(var_03))
          var_11 = var_03;

        var_12 = func_E45E(var_01, var_02, var_11);
        var_13 = undefined;

        if(_isent(self)) {
          var_13 = self gettagorigin("tag_flash");
          playFXOnTag(scripts\engine\utility::getfx("hill_mg_turret_muzflash"), self, "tag_flash");
        } else {
          var_13 = self.origin;
          var_14 = vectornormalize(var_12 - var_13);
          playFX(scripts\engine\utility::getfx("hill_mg_turret_muzflash"), var_13, var_14);
        }

        _bullettracer(var_13, var_12, self.weaponinfo);
      } else
        self shootturret("tag_flash");

      wait(var_05);
    }
  }
}

func_6B06(var_00) {
  var_01 = scripts\engine\utility::getstruct(self.target, "targetname");

  if(isDefined(self.script_ender))
    var_00 = self.script_ender;

  var_02 = _getspawner(self.target, "targetname");
  var_03 = undefined;

  if(isDefined(var_02)) {
    var_03 = scripts\sp\utility::func_2C17(var_02);
    var_3.func_1FBB = "generic";
    var_02 scripts\sp\anim::func_1EC3(var_03, var_2.animation);
    var_03 thread scripts\sp\utility::func_7748();
    var_03 scripts\sp\utility::func_16B7(scripts\sp\damagefeedback::func_4D4C);
    var_03 setCanDamage(1);
    var_03 scripts\sp\utility::func_F2A8(1);
    var_3.health = 100;
  }

  if(isDefined(var_03))
    self.origin = var_03 gettagorigin("tag_flash");

  self.weaponinfo = "generic_mg_turret_nosound";
  thread func_035A(undefined, var_1.origin, var_1.radius, undefined, 1);
  level scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, var_00);

  if(isDefined(var_03))
    var_03 scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "death");

  scripts\sp\utility::func_57D6();
  self notify("stop_fire");

  if(isDefined(var_03)) {
    if(!isalive(var_03))
      var_03 startragdoll();
    else {
      var_03 delete();

      if(isDefined(self.script_linkto))
        var_02 = _getspawner(self.script_linkto, "script_linkname") scripts\sp\utility::func_10619();
    }
  }
}

func_F293(var_00, var_01) {
  var_02 = scripts\sp\utility::func_77DA(var_00);
  var_03 = getent(var_01, "targetname");

  foreach(var_05 in var_02)
  var_05 _meth_82F1(var_03);
}

func_F2D4(var_00) {
  var_01 = _getaiarray("axis");
  var_02 = getent(var_00, "targetname");

  foreach(var_04 in var_01)
  var_04 _meth_82F1(var_02);
}

func_137F8(var_00) {
  for(;;) {
    var_01 = _getaiarray("axis");

    if(var_1.size <= var_00) {
      break;
    }
    wait 0.5;
  }
}

func_EA00(var_00, var_01) {
  var_02 = 262144;
  var_03 = [];

  if(isDefined(var_00))
    var_03 = scripts\sp\utility::func_77DA(var_00);
  else
    var_03 = _getaiarray("axis");

  foreach(var_05 in var_03) {
    var_06 = distance2dsquared(level.player.origin, var_5.origin);

    if((!isDefined(var_01) || !var_01) && var_06 >= var_02 && !sighttracepassed(level.player getEye(), var_5.origin + (0, 0, 60)))
      var_05 scripts\engine\utility::delaythread(randomfloatrange(0, 0.5), ::func_A5E4);
  }
}

func_A5E4() {
  scripts\engine\utility::waitframe();
  self _meth_81D0();
}

func_2C16() {
  scripts\sp\names::func_7B05();
  self _meth_8307(self.name, &"");
}

func_2C15() {
  self setCanDamage(1);
  self.team = "allies";
  thread scripts\sp\friendlyfire::func_73B1(self);
}

func_E45E(var_00, var_01, var_02, var_03) {
  var_04 = undefined;

  if(isDefined(var_03)) {
    var_05 = var_03 / var_01;
    var_04 = var_01 - var_01 * randomfloat(var_05);
  } else
    var_04 = var_01 * randomfloat(1.0);

  var_06 = randomfloat(360.0);
  var_07 = sin(var_06);
  var_08 = cos(var_06);
  var_09 = var_04 * var_08;
  var_10 = var_04 * var_07;
  var_11 = 0;

  if(isDefined(var_02))
    var_11 = randomfloatrange(0, var_02);

  var_09 = var_09 + var_0[0];
  var_10 = var_10 + var_0[1];
  var_11 = var_11 + var_0[2];
  return (var_09, var_10, var_11);
}

func_16BD(var_00, var_01, var_02) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level.func_4EC3))
    level.func_4EC3 = [];

  var_03 = "^3";

  if(isDefined(var_02)) {
    switch (var_02) {
      case "red":
      case "r":
        var_03 = "^1";
        break;
      case "green":
      case "g":
        var_03 = "^2";
        break;
      case "yellow":
      case "y":
        var_03 = "^3";
        break;
      case "blue":
      case "b":
        var_03 = "^4";
        break;
      case "cyan":
      case "c":
        var_03 = "^5";
        break;
      case "purple":
      case "p":
        var_03 = "^6";
        break;
      case "white":
      case "w":
        var_03 = "^7";
        break;
      case "bl":
      case "black":
        var_03 = "^8";
        break;
    }
  }

  var_04 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_4.location = 0;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.foreground = 1;
  var_4.sort = 20;
  var_4.alpha = 0;
  var_04 fadeovertime(0.5);
  var_4.alpha = 1;
  var_4.x = 40;
  var_4.y = 325;
  var_4.label = " " + var_03 + "< " + var_00 + " > ^7" + var_01;
  var_4.color = (1, 1, 1);
  level.func_4EC3 = scripts\engine\utility::array_insert(level.func_4EC3, var_04, 0);

  foreach(var_07, var_06 in level.func_4EC3) {
    if(var_07 == 0) {
      continue;
    }
    if(isDefined(var_06))
      var_6.y = 325 - var_07 * 18;
  }

  wait 2;
  var_08 = 40;
  var_04 fadeovertime(3);
  var_4.alpha = 0;

  for(var_07 = 0; var_07 < var_08; var_7++) {
    var_4.color = (1, 1, 0 / (var_08 - var_07));
    wait 0.05;
  }

  wait 4;
  var_04 destroy();
  scripts\engine\utility::array_removeundefined(level.func_4EC3);
}

func_EA01(var_00) {
  if(!isDefined(var_00)) {
    if(isDefined(self) && _isent(self))
      var_00 = self;
  }

  if(isDefined(var_00)) {
    if(isDefined(var_0.func_B14F) && var_0.func_B14F)
      var_00 scripts\sp\utility::func_1101B();

    var_00 delete();
    return 1;
  }

  return 0;
}

func_EA02(var_00) {
  foreach(var_02 in var_00) {
    if(!isDefined(var_02)) {
      continue;
    }
    func_EA01(var_02);
  }
}

func_15F6(var_00) {
  var_01 = getent(var_00, "targetname");

  if(isDefined(var_01))
    scripts\sp\utility::func_15F5(var_00);
}

func_15F4(var_00) {
  var_01 = getent(var_00, "script_noteworthy");

  if(isDefined(var_01))
    scripts\sp\utility::func_15F3(var_00);
}

func_61E6() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_00);
    var_00 scripts\sp\utility::func_61E7();
  }
}

func_5513() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_00);
    var_00 scripts\sp\utility::func_5514();
  }
}

func_39DB(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self endon("death");
  var_00 endon("death");
  self endon("stop_fire_missiles");

  if(isDefined(var_05))
    self endon(var_05);

  if(!isDefined(var_03))
    var_03 = 1;

  if(!isDefined(self.func_B8B2))
    self.func_B8B2 = func_0B0F::func_39D2();

  if(!isDefined(var_0.func_B8B2))
    var_0.func_B8B2 = func_0B0F::func_39D2();

  for(;;) {
    if(isarray(var_03))
      var_07 = randomintrange(var_3[0], var_3[1]);
    else
      var_07 = var_03;

    for(var_08 = 0; var_08 <= var_07; var_8++) {
      var_09 = scripts\engine\utility::random(self.func_B8B2[var_01]);
      var_10 = scripts\engine\utility::random(var_0.func_B8B2[var_02]);
      var_11 = spawnStruct();
      var_11.origin = var_00 gettagorigin(var_10);
      var_11.func_FF3E = 1;
      var_11.func_FF23 = 0;
      thread func_0B0F::func_3986(var_11, undefined);
      wait(randomfloatrange(0.25, 0.75));
    }

    wait(randomfloatrange(var_4[0], var_4[1]));
  }
}

func_39A7() {
  var_00 = getent("capitalship_heli", "targetname");

  while(isDefined(var_0.func_108DA))
    wait 0.05;

  var_0.func_108DA = 1;
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  scripts\engine\utility::waitframe();
  var_01 = var_00 scripts\sp\utility::func_10808();
  self.func_90DF = var_01;
  self linkto(var_01);
  var_01 sethoverparams(2000, 50, 50);
  var_01 setmaxpitchroll(0, 5);
  var_01 giveloadout("slow");
  var_01 setvehgoalpos(var_1.origin + (0, 0, 1), 1);
  scripts\engine\utility::waitframe();
  var_0.func_108DA = undefined;
}

func_39A8(var_00) {
  self.func_90DF sethoverparams(0, 0, 0);

  if(isDefined(var_00)) {
    self.func_90DF setvehgoalpos(var_00, 1);
    scripts\engine\utility::waittill_any("near_goal", "goal");
  }

  self unlink();
  self.func_90DF delete();
}

func_11679() {
  level.func_4C50 = ::func_3FC1;
  var_00 = getEntArray("temp_civs", "targetname");

  foreach(var_02 in var_00)
  var_02 thread func_3FAF();
}

func_3FAF() {
  var_00 = self.script_parameters;
  scripts\engine\utility::flag_wait(var_00);
  var_01 = scripts\sp\utility::func_10619();
  var_1.func_1FBB = "generic";
  var_1.moveplaybackrate = self.func_EE2C;
  var_1.goalradius = 128;
  var_01 scripts\sp\utility::func_13876();
  var_01 scripts\sp\utility::func_5528();
  var_01 scripts\sp\utility::func_5504();
  var_01 _meth_8250(1);
  var_02 = var_01 scripts\engine\utility::get_target_ent();
  var_01 scripts\sp\utility::func_7227(var_02, 0);
  wait 1;

  while(isDefined(var_01) && isalive(var_01) && scripts\sp\utility::func_D1DF(var_01 getEye(), 0.6, 1))
    wait 0.1;

  if(isDefined(var_01) && isalive(var_01))
    var_01 delete();
}

func_3FC1(var_00, var_01) {
  self endon("death");

  if(var_00 == "kill") {
    var_02 = getnodearray("civilian_cower", "script_noteworthy");
    sortbydistance(var_02, self.origin);
    var_03 = func_78B1();
    scripts\sp\utility::func_F3D9(var_03);

    for(;;) {
      if(!scripts\sp\utility::func_CFAC(self) && distance2d(level.player.origin, self.origin) > 1200)
        self _meth_81D0();

      wait 15;
    }
  }
}

func_78B1() {
  var_00 = getnodearray("civilian_cower", "script_noteworthy");
  var_01 = sortbydistance(var_00, self.origin);

  foreach(var_03 in var_00) {
    if(!isDefined(var_3.func_10439)) {
      var_3.occupied = 1;
      return var_03;
    }
  }
}

func_B7C2() {
  for(;;) {
    self waittill("trigger");
    var_00 = getdvarint("r_umbraminobjectcontribution");
    _setsaveddvar("r_umbraminobjectcontribution", self.script_index);

    while(level.player istouching(self))
      wait 0.15;

    _setsaveddvar("r_umbraminobjectcontribution", var_00);
  }
}

func_1F8A() {
  var_00 = self.animation;

  if(isDefined(self.func_EDA0))
    scripts\engine\utility::flag_wait(self.func_EDA0);

  scripts\sp\utility::script_delay();
  self glinton(#animtree);
  thread scripts\sp\anim::func_1ECC(self, var_00);

  if(isDefined(self.func_EE2C)) {
    scripts\engine\utility::waitframe();
    self _meth_82B1(scripts\sp\utility::func_7DC3(var_00)[0], self.func_EE2C);
  }

  if(isDefined(self.func_ED48)) {
    scripts\engine\utility::flag_wait(self.func_ED48);
    self delete();
  }
}

func_126C4() {
  self endon("entitydeleted");
  self waittill("trigger");
  glassradiusdamage(self.origin, 6, 9999, 9999);
}

func_D024() {
  self endon("entitydeleted");
  var_00 = strtok(self.script_parameters, " ");

  for(;;) {
    self waittill("trigger", var_01);

    foreach(var_03 in var_00) {
      if(var_03 == "stand") {
        level.player scripts\engine\utility::allow_stances(0);
        continue;
      }

      if(var_03 == "crouch") {
        level.player scripts\engine\utility::allow_crouch(0);
        continue;
      }

      if(var_03 == "prone")
        level.player scripts\engine\utility::allow_prone(0);
    }

    while(var_01 istouching(self))
      wait 0.1;

    foreach(var_03 in var_00) {
      if(var_03 == "stand") {
        level.player scripts\engine\utility::allow_stances(1);
        continue;
      }

      if(var_03 == "crouch") {
        level.player scripts\engine\utility::allow_crouch(1);
        continue;
      }

      if(var_03 == "prone")
        level.player scripts\engine\utility::allow_prone(1);
    }
  }
}

func_D290() {
  self endon("death");

  for(;;) {
    self waittill("trigger");
    level.player _meth_84FE();

    while(level.player istouching(self))
      wait 0.05;

    level.player _meth_84FD();
  }
}

func_1028F() {
  if(!isDefined(level.func_1028D)) {
    level.func_1028D = getent("skybox_blend_default_to_blue", "targetname");
    level.func_1028B = getent("skybox_blend_blue_to_space", "targetname");
  }
}

func_1028E() {
  func_1028F();
  level.func_1028D hide();
  level.func_1028B hide();
}

func_1028C() {
  if(isDefined(level.func_1028D))
    level.func_1028D delete();

  if(isDefined(level.func_1028B))
    level.func_1028B delete();
}

func_10D14() {
  level notify("stop_sequence_timer");
  level endon("stop_sequence_timer");
  var_00 = gettime();
  level.func_D907 = 0;

  if(getdvarint("E3", 0) && !isDefined(level.func_5FA8) && !getdvarint("e3_negus", 0)) {
    var_00 = -6000;
    level.func_5FA8 = 1;
  }

  if(isDefined(level.func_D906))
    level.func_D906 destroy();

  var_01 = newhudelem();
  var_1.x = -50;
  var_1.y = 375;
  var_1.fontscale = 1.2;
  level.func_D906 = var_01;

  for(;;) {
    wait 0.1;
    var_02 = (gettime() - var_00) * 0.001;
    level.func_D907 = var_02;
  }
}

func_13801(var_00) {
  if(!isDefined(level.func_D907)) {
    return;
  }
  while(level.func_D907 < var_00)
    wait 0.1;
}

func_1103B() {
  level notify("stop_sequence_timer");
  level endon("stop_sequence_timer");
  wait 2.5;

  if(isDefined(level.func_D906))
    level.func_D906 destroy();
}

func_13248() {
  self endon("death");

  if(!isDefined(level.func_118DC))
    level.func_118DC = gettime() / 1000;

  for(var_00 = self.func_4BF7; isDefined(self) && isDefined(self.func_4BF7); var_07 = abs(var_02 - func_13247())) {
    if(!isDefined(var_0.target)) {
      return;
    }
    if(isDefined(var_0.script_parameters) && var_0.script_parameters == "end_vehicle_time_sync") {
      self vehicle_setspeedimmediate(0, 50, 50);
      return;
    }

    var_01 = getvehiclenode(var_0.target, "targetname");

    if(!isDefined(var_01)) {
      return;
    }
    var_02 = var_1.func_EEBF;

    if(!isDefined(var_02)) {
      return;
    }
    var_03 = func_13247();
    var_04 = var_02 - var_03;
    var_05 = distance(self.origin, var_1.origin);
    var_06 = var_05 / var_04 / 17.6;

    if(var_06 < 0)
      var_06 = 10;

    self vehicle_setspeed(var_06, var_06 / 4, var_06 / 4);

    while(self.func_4BF7 == var_00)
      wait 0.05;

    var_05 = distance(self.origin, self.func_4BF7.origin);
    var_00 = self.func_4BF7;
  }
}

func_13247() {
  return gettime() / 1000 - level.func_118DC;
}

func_13249(var_00) {
  while(func_13247() < var_00)
    wait 0.05;
}

func_65D6() {
  level.func_65D4 = [];
  var_00 = getEntArray("ent_cleanup_trigger", "script_noteworthy");
  var_01 = getEntArray();
  var_02 = _getspawnerarray();

  foreach(var_04 in var_00) {
    level.func_65D4[var_4.script_label] = [];
    var_04 thread func_65D7(var_4.script_label);
  }

  foreach(var_07 in var_01) {
    if(!isDefined(var_7.script_label)) {
      continue;
    }
    level.func_65D4[var_7.script_label][level.func_65D4[var_7.script_label].size] = var_07;
  }

  foreach(var_10 in var_02) {
    if(!isDefined(var_10.script_label)) {
      continue;
    }
    level.func_65D4[var_10.script_label][level.func_65D4[var_10.script_label].size] = var_10;
  }
}

func_65D7(var_00) {
  level endon("ent_cleanup_" + var_00);
  self waittill("trigger");
  thread func_65D5(var_00);
}

func_65D5(var_00) {
  level notify("ent_cleanup_" + var_00);
  var_01 = 0;

  foreach(var_03 in level.func_65D4[var_00]) {
    if(!isDefined(var_03)) {
      continue;
    }
    var_03 delete();
    var_1++;
  }

  level.func_65D4[var_00] = undefined;

  if(!level.func_65D4.size)
    level.func_65D4 = undefined;
}

#using_animtree("generic_human");

func_13435() {
  setdvarifuninitialized("visibility_cover_debug", 0);
  precachemodel("fullbody_sdf_army");
  notifyoncommand("cover_debug_trace", "+sprint_zoom");
  var_00 = [];
  var_01 = 15;
  var_02 = 0;
  var_03 = 500;

  for(;;) {
    wait 0.05;

    if(!level.player _meth_8439()) {
      continue;
    }
    if(!getdvarint("visibility_cover_debug")) {
      continue;
    }
    if(length(level.player getnormalizedmovement()) > 0.15) {
      continue;
    }
    var_04 = 99999;
    var_05 = anglesToForward(level.player getplayerangles());
    var_06 = level.player getEye() + var_05 * var_04;
    var_07 = scripts\engine\trace::ray_trace(level.player getEye(), var_06, level.player);
    var_08 = var_7["position"];
    var_09 = getnodesinradius(var_08, var_03, 0, 24, "Cover");
    scripts\sp\utility::func_228A(var_00);
    var_00 = [];

    foreach(var_11 in var_09) {
      if(isDefined(var_11.func_4703)) {
        continue;
      }
      if(var_02 >= var_01) {
        break;
      }
      var_1++;
      var_12 = spawn("script_model", var_11.origin);
      var_12 glinton(#animtree);

      if(isDefined(var_11.angles))
        var_12.angles = var_11.angles;

      var_12 setModel("fullbody_sdf_army");
      var_12 _meth_839E();
      var_0[var_0.size] = var_12;
      var_13 = var_11 func_4702();

      if(!isDefined(var_13["animation"])) {
        continue;
      }
      var_12 thread func_1EDF(var_13, var_11);
    }

    while(level.player _meth_8439())
      wait 0.05;
  }
}

func_4702() {
  var_00 = [];
  var_0["animation"] = undefined;
  var_0["angles"] = undefined;

  switch (self.classname) {
    case "node_exposed":
      var_0["animation"] = % hm_grnd_red_exposed_aim_5_ar;
      break;
    case "node_cover_left":
      var_0["animation"] = % hm_grnd_org_cover_left_crouch_hide_to_fullexp_ar;
      var_0["angles"] = vectortoangles(anglestoleft(self.angles));
      break;
    case "node_cover_right":
      var_0["animation"] = % hm_grnd_org_cover_right_crouch_hide_to_fullexp_ar;
      var_0["angles"] = vectortoangles(anglestoright(self.angles));
      break;
    case "node_cover_crouch":
      var_0["animation"] = % hm_grnd_red_exposed_crouch_aim_5_ar;
      break;
    case "node_cover_stand":
      var_0["animation"] = % hm_grnd_red_exposed_aim_5_ar;
      break;
    case "node_cover_prone":
      var_0["animation"] = % prone_aim_5;
      break;
  }

  return var_00;
}

func_1EDF(var_00, var_01) {
  var_02 = var_0["animation"];
  var_03 = self.angles;

  if(isDefined(var_0["angles"]))
    var_03 = var_0["angles"];

  self give_attacker_kill_rewards(var_02);
  scripts\engine\utility::waitframe();
  var_04 = getmovedelta(var_02);
  var_05 = _getangledelta3d(var_02);
  var_06 = rotatevector(var_04, self.angles);
  var_07 = self.origin + var_06;
  self.origin = var_07;
  self.angles = var_03;
  self dontinterpolate();
}

func_103BE() {
  self setthreatbiasgroup("snipers");
}

func_37A9() {
  precachemodel("fx_org_view");
}

func_CCBE() {
  var_00 = spawn("script_model", (0, 0, 0));
  var_00 setModel("fx_org_view");
  var_00 linkto(level.player, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0.func_C04F = 1;
  var_01 = scripts\engine\utility::getstructarray("fxchain_start", "script_noteworthy");
  level.func_AD40 = [];
  level.func_C1E0 = var_1.size;

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    var_1[var_02].func_3C0A = var_02;
    var_1[var_02] func_6C76();
  }

  var_01 = undefined;
  level.func_C1E0 = undefined;
  level.func_AD40 = scripts\engine\utility::array_sort_with_func(level.func_AD40, ::func_445A);
  level.func_37CF = level.func_AD40[0]["start_struct"];
  level.func_37CE = 0;
  playFXOnTag(scripts\engine\utility::getfx(level.func_37CF.script_parameters), var_00, "tag_origin");
  level.func_AD40 = undefined;
  var_03 = scripts\engine\utility::getstructarray("fxchain_transition", "targetname");
  thread func_68A8(var_00);

  for(;;) {
    wait 0.25;

    if(level.func_37CE) {
      continue;
    }
    var_04 = sortbydistance(var_03, level.player.origin)[0];

    if(distance2dsquared(level.player.origin, var_4.origin) <= squared(var_4.radius)) {
      var_05 = scripts\engine\utility::getstruct(var_4.script_noteworthy, "targetname");
      var_06 = scripts\engine\utility::getstruct(var_4.script_parameters, "targetname");
      var_07 = vectordot(anglesToForward(var_4.angles), level.player.origin - var_4.origin);
      var_08 = undefined;

      if(var_07 > 0 && level.func_37CF.func_3C0A == var_6.func_3C0A)
        var_08 = var_05;

      if(var_07 < 0 && level.func_37CF.func_3C0A == var_5.func_3C0A)
        var_08 = var_06;

      if(isDefined(var_08))
        func_12660(var_08, var_00);
    }

    var_09 = [];

    foreach(var_11 in scripts\engine\utility::getstructarray(level.func_37CF.targetname, "target"))
    var_9[var_9.size] = func_7A8D(var_11, level.func_37CF);

    if(isDefined(level.func_37CF.target)) {
      var_13 = scripts\engine\utility::getstructarray(level.func_37CF.target, "targetname");

      foreach(var_15 in var_13) {
        var_9[var_9.size] = func_7A8D(level.func_37CF, var_15);

        if(isDefined(var_15.target)) {
          var_16 = scripts\engine\utility::getstructarray(var_15.target, "targetname");

          foreach(var_18 in var_16)
          var_9[var_9.size] = func_7A8D(var_15, var_18);
        }
      }
    }

    var_09 = scripts\engine\utility::array_sort_with_func(var_09, ::func_445A);
    var_08 = var_9[0]["start_struct"];

    if(var_8.origin != level.func_37CF.origin) {
      if(var_8.script_parameters != level.func_37CF.script_parameters) {
        func_12660(var_08, var_00);
        continue;
      }

      level.func_37CF = var_08;
    }
  }
}

func_6C76() {
  if(isDefined(self.target)) {
    var_00 = scripts\engine\utility::getstructarray(self.target, "targetname");

    foreach(var_02 in var_00) {
      if(!isDefined(var_2.func_3C0A)) {
        var_2.func_3C0A = self.func_3C0A;
        level.func_AD40[level.func_AD40.size] = func_7A8D(self, var_02);
        level.func_C1E0++;
        var_02 func_6C76();
      }
    }
  }
}

func_7A8D(var_00, var_01) {
  var_02 = [];
  var_2["start_struct"] = var_00;
  var_2["closest_point"] = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, level.player.origin);
  return var_02;
}

func_445A(var_00, var_01) {
  return distancesquared(var_0["closest_point"], level.player.origin) < distancesquared(var_1["closest_point"], level.player.origin);
}

func_68A8(var_00) {
  scripts\engine\utility::flag_wait("dust_cloud_hit");
  stopFXOnTag(scripts\engine\utility::getfx(level.func_37CF.script_parameters), var_00, "tag_origin");
  level.func_37CE = 1;
  scripts\engine\utility::flag_wait("c6_reveal_started");
  level.func_37CF = scripts\engine\utility::getstruct("droppod_camfx_start", "targetname");
  playFXOnTag(scripts\engine\utility::getfx(level.func_37CF.script_parameters), var_00, "tag_origin");
  level.func_37CE = 0;

  if(!getdvarint("e3", 0) == 1) {
    scripts\engine\utility::flag_wait("pod_door_landed");
    stopFXOnTag(scripts\engine\utility::getfx(level.func_37CF.script_parameters), var_00, "tag_origin");
    level.func_37CF.script_parameters = "indoor_ash";
    playFXOnTag(scripts\engine\utility::getfx(level.func_37CF.script_parameters), var_00, "tag_origin");
  }

  scripts\engine\utility::flag_wait("breach_started");
  func_12660(scripts\engine\utility::getstruct("slowmo_camfx_start", "targetname"), var_00);
}

func_12660(var_00, var_01) {
  stopFXOnTag(scripts\engine\utility::getfx(level.func_37CF.script_parameters), var_01, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx(var_0.script_parameters), var_01, "tag_origin");
  level.func_37CF = var_00;
}

func_1283D(var_00) {
  var_01 = [];
  var_02 = "";

  for(;;) {
    var_03 = "";

    foreach(var_05 in var_00) {
      if(_istransientloaded(var_05)) {
        if(var_03 == "") {
          var_03 = var_03 + var_05;
          continue;
        }

        var_03 = var_03 + "," + var_05;
      }
    }

    if(var_03 != var_02 && !scripts\engine\utility::array_contains(var_01, var_02)) {
      var_01 = scripts\engine\utility::array_add(var_01, var_02);
      var_02 = var_03;
    }

    wait 0.5;
  }
}

func_311B(var_00) {
  if(getdvarint("bruteforce_removal") == 0) {
    return;
  }
  var_01 = scripts\engine\utility::getstruct(var_00, "targetname");
  wait 2;
  func_311C(var_01, "script_model");
  func_311C(var_01, "script_brushmodel");
  func_311C(var_01, "script_origin");
}

func_311C(var_00, var_01) {
  var_02 = getEntArray(var_01, "code_classname");
  var_03 = anglesToForward(var_0.angles);

  foreach(var_05 in var_02) {
    if(vectordot(var_03, vectornormalize(var_0.origin - var_5.origin)) > 0)
      var_05 thread func_D8F6();
  }
}

func_D8F6() {
  var_00 = squared(2000);

  for(;;) {
    wait 0.05;
    var_01 = distancesquared(level.player.origin, self.origin);

    if(var_01 > var_00) {
      continue;
    }
    var_02 = 0.8 - scripts\sp\math::func_C097(var_00 * 0.5, var_00, var_01);
  }
}

func_8FC9() {
  var_00 = _getspawnerarray("hill_street_idle_civis");

  foreach(var_02 in var_00) {
    var_03 = var_02 scripts\sp\utility::func_10619(1);

    if(isDefined(var_2.script_sound))
      var_03 thread func_11118(var_2.script_sound);
  }
}

func_11118(var_00) {
  while(isDefined(self)) {
    self playSound(var_00);
    wait(lookupsoundlength(var_00) / 1000 + randomintrange(1, 4));
  }
}

func_B284(var_00) {
  var_01 = scripts\sp\utility::func_7C23();
  var_1.func_99E5 = 0;
  var_1.origin = var_0.origin;
  return var_01;
}