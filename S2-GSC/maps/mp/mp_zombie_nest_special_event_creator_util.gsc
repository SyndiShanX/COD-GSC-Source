/*****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_special_event_creator_util.gsc
*****************************************************************/

func_2C2C(param_00, param_01) {
  var_02 = common_scripts\utility::func_46B7("zombie_spawner", "script_noteworthy");
  var_03 = [];
  foreach(var_05 in var_02) {
    if(isDefined(var_05.var_819A)) {
      var_05.var_68A2 = 0;
      var_03 = common_scripts\utility::func_0F6F(var_03, var_05);
    }
  }

  param_00 thread func_2D33(var_03);
  var_07 = maps\mp\agents\_agent_utility::func_43FD("all");
  var_07 = common_scripts\utility::func_0F92(var_07);
  foreach(var_09 in var_07) {
    if(!var_09 maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::func_A7F2()) {
      var_09 notify("lose_focus");
      var_09.var_1924 = undefined;
      var_09.var_8BA3 = 0;
      var_09.var_9966 = 0;
      continue;
    }

    var_09.var_8BA3 = 1;
    if(common_scripts\utility::func_562E(var_09.var_9966)) {
      continue;
    }

    if(isDefined(var_09.var_1924)) {
      continue;
    }

    if(!isDefined(var_09.var_0A4B)) {
      continue;
    }

    if(var_09.var_000A == level.var_746E) {
      continue;
    }

    if(var_09.var_0A4B != "zombie_generic" && var_09.var_0A4B != "zombie_berserker") {
      continue;
    }

    if(var_09 lib_0547::func_53DC()) {
      continue;
    }

    var_0A = distance(var_09.var_0116, param_00.var_ABEA.var_38B7);
    if(var_0A < param_01) {
      continue;
    }

    var_09 thread func_20C6(var_03, param_00.var_ABEA.var_38B7);
  }
}

func_4DED(param_00) {
  self endon("stop_sould_bucket_leak");
  for(;;) {
    var_01 = 0;
    while(!var_01) {
      var_02 = self.var_AC2C;
      wait(param_00);
      if(self.var_AC2C <= var_02) {
        var_01 = 1;
      }
    }

    func_35FC();
  }
}

func_35FC() {
  self endon("stop_sould_bucket_leak");
  level endon(self.var_695B);
  while(self.var_AC2C > 0) {
    self.var_AC2C--;
    wait(0.25);
  }

  self.var_AC2C = 0;
}

func_9408() {
  self notify("stop_sould_bucket_leak");
}

func_2B65(param_00, param_01) {}

func_2D33(param_00) {
  level waittill("tower battle reset despawners");
  var_01 = maps\mp\agents\_agent_utility::func_43FD("all");
  foreach(var_03 in var_01) {
    var_03.var_1924 = undefined;
    var_03.var_8BA3 = 0;
  }

  level notify("tower battle reset despawners done");
}

func_20C6(param_00, param_01) {
  self endon("death");
  self.var_9966 = 1;
  wait(randomint(4) + 1);
  if(!isDefined(self.var_0A4B) || !isalive(self)) {
    return;
  }

  if(lib_0547::func_4B2C() && !common_scripts\utility::func_562E(self.var_4B9F)) {
    func_ABE1();
  }

  var_02 = func_410B(param_00);
  self.var_1924 = var_02;
  var_02.var_68A2++;
  thread func_2B79(var_02);
  thread func_9E20();
  self.var_9966 = 0;
}

func_410B(param_00) {
  var_01 = common_scripts\utility::func_40B0(self.var_0116, param_00);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_01[var_02].var_68A2 <= 4 && abs(var_01[var_02].var_0116[2] - self.var_0116[2]) < 256) {
      return var_01[var_02];
    }
  }

  return var_01[0];
}

func_2B79(param_00) {
  level endon("tower battle reset despawners");
  self waittill("death");
  param_00.var_68A2--;
  param_00 notify("despawner used");
}

func_9E20() {
  self endon("death");
  self endon("lose_focus");
  var_00 = self.var_0A4B;
  while(isalive(self) && isDefined(self.var_1924) && distance(self.var_0116, self.var_1924.var_0116) > 48) {
    wait(0.1);
  }

  self suicide();
  self.var_1924 = undefined;
  if(lib_0547::func_0796()) {
    var_01 = lib_055A::func_4696(var_00, 0, 0, maps\mp\mp_zombie_nest_special_event_creator_interface::func_405B());
    var_02 = lib_054D::func_90BA(var_00, var_01, "tower_respawn");
  }
}

func_ABE1() {
  self endon("death");
  self.var_4B9F = 1;
  var_00 = "board_taunt";
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_00, undefined, 1);
  if(isDefined(var_01)) {
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", self.var_001D);
    self scragentsetscripted(1);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "taunt_anim");
    self scragentsetscripted(0);
  }
}

func_93F8(param_00) {
  param_00.var_7B8C notify(param_00.var_38C3);
}

func_27CE(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 + 1 < param_00.size; var_02 = var_02 + 2) {
    for(var_03 = 0; var_03 < param_00[var_02 + 1]; var_03++) {
      var_01 = common_scripts\utility::func_0F6F(var_01, param_00[var_02]);
    }
  }

  return common_scripts\utility::func_0F92(var_01);
}

func_11B2(param_00) {
  level notify("attack_spots_display_start");
  switch (param_00.size) {
    case 2:
      func_8A06(param_00[0], "a");
      func_8A06(param_00[1], "b");
      setomnvar("ui_zm_waypoint_ents_type", 2);
      break;

    case 1:
      func_8A06(param_00[0], "a");
      setomnvar("ui_zm_waypoint_ents_type", 1);
      break;

    default:
      break;
  }
}

func_8A06(param_00, param_01) {
  param_00.var_3012 = "ui_zm_waypoint_ent_" + param_01;
  param_00.var_3013 = "ui_zm_waypoint_float_" + param_01;
  param_00 setModel("tag_origin");
  param_00 method_805B();
  setomnvar(param_00.var_3012, param_00 getentitynumber());
  setomnvar(param_00.var_3013, 1);
}

func_11B4(param_00) {
  foreach(var_02 in param_00) {
    var_03 = clamp(var_02.var_28FF / var_02.var_6057, 0, 1);
    setomnvar(var_02.var_3013, var_03);
  }
}

func_11B1(param_00) {
  foreach(var_02 in param_00) {
    setomnvar(var_02.var_3013, -1);
  }
}

func_11B3(param_00) {
  foreach(var_02 in param_00) {
    setomnvar(var_02.var_3013, -1);
  }
}

func_11B0(param_00) {
  level endon("attack_spots_display_start");
  wait(1.5);
  setomnvar("ui_zm_waypoint_ents_type", 0);
}

func_11BE(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = 0;
  var_07 = self.var_1170 func_9E11(param_04.var_38C4["objectiveTime"], param_01, param_00);
  var_08 = isDefined(var_07);
  return var_08;
}

func_9E11(param_00, param_01, param_02) {
  var_03 = 0.5;
  var_04 = param_02;
  for(var_05 = 0; var_05 < var_04.size; var_05++) {
    var_04[var_05] endon(param_01.var_39D1);
  }

  func_A6AF(param_00, var_03);
  var_04 func_695C(param_01.var_94D4);
  return 1;
}

func_695C(param_00) {
  for(var_01 = 0; var_01 < self.size; var_01++) {
    self[var_01] notify(param_00);
  }
}

func_A6AF(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00; var_02 = var_02 + param_01) {
    wait(param_01);
  }
}

func_45BC() {
  var_00 = 0;
  var_01 = lib_0547::func_408F();
  foreach(var_03 in var_01) {
    if(isalive(var_03) && isDefined(var_03.var_9ACD) && var_03.var_9ACD == "attacking point" && distance2dsquared(var_03.var_0116, self.var_0116) < 4096) {
      var_00++;
    }
  }

  return var_00;
}

func_600B() {
  if(level.var_744A.size > 1) {
    var_00 = maps\mp\mp_zombie_nest_special_event_creator_interface::func_9959();
    var_01 = maps\mp\mp_zombie_nest_special_event_creator_interface::func_55C0();
    return var_00 && !var_01;
  }

  return !maps\mp\mp_zombie_nest_special_event_creator_interface::func_55C0();
}