/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_enigma.gsc
************************************************/

func_430C() {
  return "salt_mine_opened";
}

func_00F9() {
  level.var_36B0 = 1;
  level.var_3592 = 1;
  level.var_3594 = 1;
  level.var_3593 = 0;
  level.var_3591 = 0;
  level.var_358E = [];
  level.var_358D = 0;
  lib_0557::func_7846("2 open salt mine", ::func_378A, ["explore village"], &"ZOMBIE_NEST_HINT_QUEST_ENIGMA", "ZOMBIE_NEST_HINT_QUEST_ENIGMA");
  lib_0557::func_781E("2 open salt mine", "explore bunker", ::func_7851, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_EXPLORE_BUNKER");
  lib_0557::func_781E("2 open salt mine", "use power machines", ::func_7867, ::func_7EFD, &"ZOMBIE_NEST_HINT_STEP_REROUTE_POWER");
  lib_0557::func_781E("2 open salt mine", "salt mine door open", ::func_785F, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_OPEN_SALT_MINE");
  lib_0557::func_7848("2 open salt mine");
  common_scripts\utility::func_3C87("flag_salt_mine_opened");
  common_scripts\utility::func_3C87("flag_salt_mine_main_ent_opened");
  common_scripts\utility::func_3C87("flag_med_enigma_set");
  common_scripts\utility::func_3C87("flag_rnd_enigma_set");
  common_scripts\utility::func_3C87("flag_both_enigmas_set");
  common_scripts\utility::func_3C87("flag_salt_mine_door_found");
  common_scripts\utility::func_3C87("salt_mine_opened");
  func_52B6();
  func_5348();
}

func_1389() {
  wait(1);
  var_00 = func_44F7();
  common_scripts\utility::func_3C8F(var_00.var_81A1);
}

func_784F() {
  var_00 = func_44F7();
  var_01 = var_00.var_81A1;
  var_02 = undefined;
  foreach(var_04 in level.var_7606) {
    if(lib_0547::func_5565(var_04.var_819A, var_01)) {
      var_02 = var_04;
    }
  }

  if(isDefined(var_02) && isDefined(var_02.var_6298)) {
    var_06 = lib_0557::func_782F(var_02.var_6298.var_0116 + (0, 0, 30), [var_02.var_6298]);
    lib_0557::func_781D("2 open salt mine", var_06);
  } else {}

  common_scripts\utility::func_3C9F(var_01);
  lib_0557::func_782D("2 open salt mine", "enable power");
}

func_7851() {
  var_00 = func_4587();
  thread func_A10A("med", "red");
  thread func_A10A("rnd", "red");
  common_scripts\utility::func_3CA2("flag_med_enigma_set", "flag_rnd_enigma_set", "flag_salt_mine_door_found");
  lib_0557::func_782D("2 open salt mine", "explore bunker");
}

func_7867() {
  if(1) {
    if(!1 || 1 && level.var_744A.size == 1) {
      level thread quest_step_reroute_power_helper();
    }
  }

  if(common_scripts\utility::func_3C77("flag_med_enigma_set") || common_scripts\utility::func_3C77("flag_rnd_enigma_set")) {
    lib_0557::func_7822("2 open salt mine", &"ZOMBIE_NEST_HINT_STEP_REROUTE_POWER_2");
  }

  if(0) {
    level.var_3590 = lib_0557::func_782F(undefined, level.var_358F);
    lib_0557::func_781D("2 open salt mine", level.var_3590);
  }
}

quest_step_reroute_power_helper() {
  level endon(lib_0557::func_7838("2 open salt mine", "use power machines"));
  if(!0) {
    var_00 = level.var_A980;
    var_01 = var_00 + 2;
    if(1) {
      wait(200);
    }

    if(1) {
      if(level.var_A980 <= var_01) {
        for(;;) {
          level waittill("zombie_wave_started");
          if(level.var_A980 > var_01) {
            break;
          }
        }
      }
    }

    if(0) {
      level.rotor_objective_helper_tripped = 1;
      foreach(var_03 in level.var_358F) {
        foreach(var_05 in level.var_744A) {
          var_03 hudoutlineenableforclient(var_05, 0, 0);
        }
      }

      return;
    }

    level.var_3590 = lib_0557::func_782F(undefined, level.var_358F);
    lib_0557::func_781D("2 open salt mine", level.var_3590);
  }
}

func_5348() {
  var_00 = getEntArray("reroute_power_01_model", "script_noteworthy");
  var_01 = getEntArray("reroute_power_02_model", "script_noteworthy");
  var_02 = var_00[0];
  var_03 = var_01[0];
  foreach(var_05 in var_00) {
    if(var_05.var_003A == "script_model" && var_05.var_0106 == "zmb_circuit_breaker_02") {
      var_02 = var_05;
    }
  }

  foreach(var_05 in var_01) {
    if(var_05.var_003A == "script_model" && var_05.var_0106 == "zmb_circuit_breaker_02") {
      var_03 = var_05;
    }
  }

  level.var_358F = [var_03, var_02];
}

func_785F() {
  var_00 = func_4470();
  if(0) {
    var_01 = lib_0557::func_782F(undefined, var_00.var_8301);
    lib_0557::func_781D("2 open salt mine", var_01);
  }

  if(1) {
    if(0) {
      if(common_scripts\utility::func_562E(level.rotor_objective_helper_tripped)) {
        foreach(var_03 in level.var_358F) {
          foreach(var_05 in level.var_744A) {
            var_03 hudoutlinedisableforclient(var_05);
          }
        }

        return;
      }
    }
  }
}

func_378A() {
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("shardroom");
    var_01 lib_0378::func_8D74("objective_complete", "shardroom");
  }
}

func_52B6() {
  level.var_358E = getEntArray("enigma_place", "targetname");
  lib_053F::func_7BEB(&"ZOMBIE_NEST_ROTORS_NOT_PLACED", "flag_both_enigmas_set", "rotor");
  lib_053F::func_7BEB(&"ZOMBIE_NEST_ROTORS_NOT_PLACED", "flag_salt_mine_main_ent_opened", "rotor");
  level.var_357D = level.var_358E.size;
  thread func_2EA6();
  thread func_3B98();
  foreach(var_01 in level.var_358E) {
    var_01 func_8A3F();
    var_01 thread func_7EFC();
  }
}

func_3B98() {
  var_00 = getent("enter_com_trig", "targetname");
  if(isDefined(var_00)) {
    for(;;) {
      var_00 waittill("trigger", var_01);
      if(isPlayer(var_01)) {
        break;
      }

      wait(0.25);
    }

    if(!lib_0557::func_783E("2 open salt mine", "explore bunker")) {
      lib_0557::func_7822("2 open salt mine", &"ZOMBIE_NEST_HINT_STEP_FIND_SM_DOOR");
    }
  }
}

func_8035() {
  level.var_3593 = 1;
  if(!maps\mp\mp_zombie_nest_ee_hc_tools_of_the_trade::func_8B98()) {
    var_00 = getEntArray("enigma_place", "targetname");
    foreach(var_02 in var_00) {
      var_02 delete();
    }
  }

  if(level.var_36B0) {
    var_04 = func_4470();
    var_05 = var_04.var_8301[0].var_0116;
    common_scripts\utility::func_3C9F("com_to_mine");
    common_scripts\utility::func_3C8F("flag_salt_mine_main_ent_opened");
    thread maps\mp\mp_zombie_nest_ee_util::func_7213("entermine", var_05, 200, 512);
  }

  var_06 = func_4587();
  var_06 notify("open", level.var_744A[0]);
  thread func_A10A("med", "green");
  thread func_A10A("rnd", "green");
  lib_0557::func_782D("2 open salt mine", "salt mine door open");
  lib_0557::func_AB88("salt_mine_opened");
}

func_7EFD() {
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("rotor");
    var_01 lib_0378::func_8D74("objective_complete", "rotor");
  }
}

func_7D6D(param_00) {
  for(var_01 = 0; var_01 < level.var_358E.size; var_01++) {
    level.var_358E[var_01] common_scripts\utility::func_9D9F();
  }

  func_7D6C();
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(param_00) {
    var_02 = func_4470();
    thread func_A0FF("lock");
    thread func_A10A("med", "red");
    thread func_A10A("rnd", "red");
  }

  wait(1);
  func_7AAC();
}

func_7D6C() {
  level.var_3591 = 0;
  common_scripts\utility::func_3C7B("flag_med_enigma_set");
  common_scripts\utility::func_3C7B("flag_rnd_enigma_set");
  thread lib_0378::func_8D74("aud_fuse_timer_stop", level.var_358E);
  for(var_00 = 0; var_00 < level.var_358E.size; var_00++) {
    level.var_358E[var_00].var_5F59 func_8718();
    level.var_358E[var_00] func_8713();
    level.var_358E[var_00].var_08A9 = 0;
  }
}

func_7AAC() {
  for(var_00 = 0; var_00 < level.var_358E.size; var_00++) {
    level.var_358E[var_00] common_scripts\utility::func_9DA3();
  }
}

func_8A3F() {
  self usetriggerrequirelookat();
  self.var_5F59 = getent(self.var_01A2, "targetname");
  if(isDefined(self.var_5F59.var_01A2)) {
    self.var_6643 = common_scripts\utility::func_44BD(self.var_5F59.var_01A2, "targetname");
  }

  if(isDefined(self.var_6643) && isDefined(self.var_6643.var_01A2)) {
    self.var_6646 = common_scripts\utility::func_44BD(self.var_6643.var_01A2, "targetname");
  }

  if(isDefined(self.var_6646) && isDefined(self.var_6646.var_01A2)) {
    self.var_6647 = common_scripts\utility::func_44BD(self.var_6646.var_01A2, "targetname");
  }
}

func_7EFC() {
  self.var_5F59 thread func_8718();
  thread func_8713();
  while(level.var_3591 < level.var_357D) {
    self waittill("trigger", var_00);
    lib_0378::func_8D74("aud_enigma_switch_activate");
    if(isDefined(self.var_8260)) {
      if(self.var_8260 == "rotor_machine_rnd") {
        common_scripts\utility::func_3C8F("flag_rnd_enigma_set");
        thread func_A10A("rnd", "green");
      } else if(self.var_8260 == "rotor_machine_med") {
        common_scripts\utility::func_3C8F("flag_med_enigma_set");
        thread func_A10A("med", "green");
      }
    }

    if(!isDefined(self.var_08A9)) {
      self.var_08A9 = 0;
    }

    self.var_5F59 thread func_8717();
    if(self.var_08A9 == 0) {
      common_scripts\utility::func_9D9F();
      self.var_08A9 = 1;
      level.var_3591++;
      var_00 thread func_2EB7();
      if(level.var_3591 == 1 && 1) {
        if(level.var_358D == 0 && !level.var_3593) {
          lib_0557::func_7822("2 open salt mine", &"ZOMBIE_NEST_HINT_STEP_REROUTE_POWER_2");
        }

        thread func_92C4();
        thread func_A0FF("unlock");
      }

      if(level.var_3591 >= level.var_357D) {
        thread lib_0378::func_8D74("aud_fuse_timer_stop", level.var_358E);
        level notify("nest_ee_both_machines_used");
        common_scripts\utility::func_3C8F("flag_both_enigmas_set");
        var_00 lib_0378::func_8D74("aud_saltmine_door_powered");
        if(isDefined(level.var_3590)) {
          lib_0557::func_7847("2 open salt mine", level.var_3590);
        }

        lib_0557::func_782D("2 open salt mine", "use power machines");
        foreach(var_02 in level.var_358E) {
          var_02.var_5F59 thread func_8715();
          var_02 thread func_8714();
        }

        func_8035();
      }
    }
  }
}

func_8718() {
  if(common_scripts\utility::func_562E(self.var_56B6)) {
    self scriptmodelplayanim("zmb_circuit_breaker_02_dial_standby");
    wait(getanimlength(%zmb_circuit_breaker_02_dial_standby));
  }

  var_00 = ["TAG_RED_ON", "TAG_GREEN_OFF", "TAG_GRAPH_ON"];
  var_01 = ["TAG_RED_OFF", "TAG_GREEN_ON", "TAG_GRAPH_OFF"];
  func_A10E(var_01, var_00);
  thread func_86BD();
  self.var_56B6 = 0;
  self scriptmodelplayanim("zmb_circuit_breaker_02_dial_standby_idle");
}

func_8717() {
  self scriptmodelplayanim("zmb_circuit_breaker_02_dial_ready");
  wait(getanimlength(%zmb_circuit_breaker_02_dial_ready));
  var_00 = ["TAG_RED_OFF", "TAG_GREEN_ON", "TAG_GRAPH_ON"];
  var_01 = ["TAG_RED_ON", "TAG_GREEN_OFF", "TAG_GRAPH_OFF"];
  func_A10E(var_01, var_00);
  self.var_56B6 = 1;
  thread func_86C1();
  self scriptmodelplayanim("zmb_circuit_breaker_02_dial_ready_idle");
}

func_8715() {
  self.var_56B6 = 1;
}

func_86C0() {
  if(common_scripts\utility::func_562E(self.var_568A)) {
    func_940A("off");
    return;
  }

  self hidepart("TAG_POWER_ON", self.var_0106);
  self showpart("TAG_POWER_OFF", self.var_0106);
}

func_86C1() {
  if(common_scripts\utility::func_562E(self.var_568A)) {
    func_940A("on");
    return;
  }

  self hidepart("TAG_POWER_OFF", self.var_0106);
  self showpart("TAG_POWER_ON", self.var_0106);
}

func_86BD() {
  self.var_568A = 1;
  while(common_scripts\utility::func_562E(self.var_568A)) {
    self hidepart("TAG_POWER_ON", self.var_0106);
    self showpart("TAG_POWER_OFF", self.var_0106);
    wait(0.5);
    self hidepart("TAG_POWER_OFF", self.var_0106);
    self showpart("TAG_POWER_ON", self.var_0106);
    if(common_scripts\utility::func_562E(self.var_56B6)) {
      self.var_568A = 0;
      return;
    }

    wait(0.5);
  }
}

func_940A(param_00) {
  if(param_00 == "on") {
    self.var_568A = 0;
    self.var_568B = 1;
    return;
  }

  self.var_568A = 0;
  self.var_568B = 1;
}

func_8716(param_00) {
  self scriptmodelplayanim("zmb_circuit_breaker_02_dial_idle");
}

func_A10E(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    self hidepart(param_00[var_02], self.var_0106);
  }

  for(var_02 = 0; var_02 < param_01.size; var_02++) {
    self showpart(param_01[var_02], self.var_0106);
  }
}

func_A0FF(param_00) {
  var_01 = func_4470();
  if(!isDefined(param_00)) {
    return;
  }

  var_02 = undefined;
  var_03 = undefined;
  var_04 = 0;
  switch (param_00) {
    case "unlock":
      var_02 = "unlocking";
      var_03 = "unlocked";
      var_04 = 1.833333;
      break;

    case "lock":
      var_02 = "relocking";
      var_03 = "closed";
      var_04 = 1.833333;
      break;

    default:
      break;
  }

  if(!isDefined(var_02)) {
    return;
  }

  if(common_scripts\utility::func_562E(var_01.var_5671)) {
    while(var_01.var_5671) {
      wait(0.1);
    }
  }

  var_01.var_5671 = 1;
  foreach(var_06 in var_01.var_8301) {
    var_06 setscriptablepartstate("gate", var_02);
  }

  wait(var_04);
  foreach(var_06 in var_01.var_8301) {
    var_06 setscriptablepartstate("gate", var_03);
  }

  var_01.var_5671 = 0;
}

func_A10A(param_00, param_01) {
  var_02 = func_4470();
  var_03 = undefined;
  var_04 = undefined;
  if(param_00 == "rnd") {
    var_03 = "light_r";
  } else if(param_00 == "med") {
    var_03 = "light_l";
  }

  if(param_01 == "green") {
    var_04 = "on";
  } else if(param_01 == "red") {
    var_04 = "off";
  }

  foreach(var_06 in var_02.var_8301) {
    var_06 setscriptablepartstate(var_03, var_04);
  }
}

func_92C4() {
  var_00 = 60;
  var_01 = 0;
  foreach(var_03 in level.var_358E) {
    var_03 thread func_9300(var_00);
  }

  thread lib_0378::func_8D74("aud_fuse_timer_start", level.var_358E);
  while(!level.var_3593 && !var_01) {
    if(var_00 < 10) {
      foreach(var_06 in level.var_744A) {
        if(var_06 maps\mp\mp_zombie_nest_ee_util::func_7402()) {
          thread lib_0378::func_8D74("aud_start_enigma_timer", var_00, var_01);
        }
      }
    }

    var_00--;
    wait(1 / level.var_3594);
    if(var_00 <= 0 && !level.var_3593) {
      foreach(var_06 in level.var_744A) {
        if(var_06 maps\mp\mp_zombie_nest_ee_util::func_7402()) {
          thread lib_0378::func_8D74("aud_start_enigma_timer", var_00, var_01);
          var_06 thread func_2EA7();
        }
      }

      if(level.var_358D == 0 && !level.var_3593) {
        lib_0557::func_7822("2 open salt mine", &"ZOMBIE_NEST_HINT_STEP_REROUTE_RESET");
      }

      level.var_358D++;
      thread func_7D6D();
      var_01 = 1;
    }
  }
}

func_9300(param_00) {
  level endon("flag_both_enigmas_set");
  if(!isDefined(self.var_6643) || !isDefined(self.var_6646) || !isDefined(self.var_6647)) {
    return;
  }

  self.var_6643 moveto(self.var_6647.var_0116, 0.1, 0, 0);
  wait(0.1);
  self.var_6643 moveto(self.var_6646.var_0116, param_00 - 0.1, 0, 0);
}

func_8714() {
  if(!isDefined(self.var_6643) || !isDefined(self.var_6647)) {
    return;
  }

  self.var_6643 moveto(self.var_6647.var_0116, 0.5, 0, 0);
}

func_8713() {
  if(!isDefined(self.var_6643) || !isDefined(self.var_6646)) {
    return;
  }

  self.var_6643 moveto(self.var_6646.var_0116, 0.5, 0, 0);
}

func_2EA6() {
  level endon("flag_both_enigmas_set");
  var_00 = getent("saltmine_ent_dialogue", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(!isPlayer(var_01)) {
      wait(0.5);
      continue;
    } else if(!isDefined(var_01.var_306B)) {
      common_scripts\utility::func_3C8F("flag_salt_mine_door_found");
      var_02 = var_01 lib_0367::func_8E3D("saltminedoorexamine");
      if(isDefined(var_02)) {
        var_01.var_306B = 1;
      }
    }
  }
}

func_2EB7() {
  if(isPlayer(self)) {
    if(level.var_3591 >= level.var_357D) {
      if(!isDefined(self.var_3064)) {
        wait(0.8);
        thread lib_0367::func_8E3C("saltminepower2");
        self.var_3064 = 1;
        return;
      }

      return;
    }

    if(!isDefined(self.var_3063)) {
      wait(0.8);
      thread lib_0367::func_8E3C("saltminepower1");
      self.var_3063 = 1;
      return;
    }
  }
}

func_2EA7() {
  if(!isDefined(self.var_3065) && isPlayer(self)) {
    var_00 = thread lib_0367::func_8E3D("saltminereset");
    if(isDefined(var_00)) {
      self.var_3065 = 1;
    }
  }
}

func_44F7() {
  return lib_053F::func_44A6("gallows_to_com");
}

func_4470() {
  return lib_053F::func_44A6("com_to_mine");
}

func_4587() {
  return lib_053F::func_44A6("rnd_to_mine");
}