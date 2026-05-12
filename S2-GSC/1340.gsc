/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1340.gsc
*********************************************/

lib_053C::func_4F84() {
  if(self.var_00CA) {
    return 0;
  }

  if(common_scripts\utility::func_562E(self.var_1723)) {
    return 0;
  }

  if(!isDefined(self.var_28D2)) {
    return 0;
  }

  if(self.var_0BA4 == "melee" || maps\mp\agents\_scripted_agent_anim_util::func_57E2()) {
    return 0;
  }

  if(!lib_0547::func_4B2C()) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid::func_A7F8()) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid::func_2EE6()) {
    return 0;
  }

  var_00 = common_scripts\utility::func_562E(self.var_5F4C) && isDefined(self.var_5F48) && gettime() - self.var_5F48 <= self.var_5F46;
  if(maps\mp\agents\humanoid\_humanoid::func_2EE5() || var_00) {
    if(!maps\mp\agents\humanoid\_humanoid::func_7AC0("base")) {
      return 0;
    }
  } else if(!maps\mp\agents\humanoid\_humanoid::func_7AC0("normal")) {
    return 0;
  }

  if(isDefined(self.var_60E4) && isDefined(self.var_5BC0)) {
    var_01 = gettime() - self.var_5BC0;
    if(var_01 < self.var_60E4 * 1000) {
      return 0;
    }
  }

  if(!isDefined(self.var_5BC1) || distancesquared(self.var_5BC1, self.var_0116) > 256) {
    self.var_60ED = self.var_0108;
  }

  if(isDefined(self.custom_on_melee_func)) {
    self thread[[self.custom_on_melee_func]]();
  }

  self method_83A1(self.var_28D2);
  return 1;
}

lib_053C::func_0631() {
  if(isDefined(self.var_6618)) {
    return self.var_6618;
  }

  return self method_8396();
}

lib_053C::func_06CE(param_00) {
  self.var_6618 = param_00;
  self notify("new_navigation_goal");
  var_01 = 1500;
  var_02 = gettime();
  var_03 = self.var_AAF3;
  var_04 = isDefined(var_03) && var_02 - var_03 < var_01;
  var_05 = !isDefined(self.var_A08E) || var_04;
  var_06 = undefined;
  if(!var_05) {
    var_07 = gettraversalsonpath(self.var_0116, self.var_6618, self);
    self.var_AAF3 = var_02;
    if(isDefined(var_07)) {
      foreach(var_09 in var_07) {
        if(lib_0549::func_553A(var_09)) {
          var_06 = var_09;
          break;
        }
      }
    }
  }

  var_0B = isDefined(var_06) && isDefined(self.var_A08E) && isDefined(var_06.var_15CB) && var_06.var_15CB == self.var_A08E.var_15CB;
  if(!var_04 || var_0B) {
    if(isDefined(self.var_A08E)) {
      self.var_6617 = 1;
    }

    self method_8395(self.var_6618);
  }
}

lib_053C::func_0778() {
  self endon("death");
  childthread lib_053C::func_0779();
  childthread lib_053C::func_077A();
  lib_053C::func_8A62(0);
  for(;;) {
    self waittill("traverse_soon");
    var_00 = self method_8198();
    if(isDefined(var_00)) {
      thread lib_053C::func_077B(var_00);
    }

    if(isDefined(var_00) && !isDefined(self.var_A08E)) {
      for(;;) {
        if(isDefined(var_00.var_54F5) && var_00.var_54F5) {
          if(isDefined(var_00.var_A228) && var_00.var_A228 != self) {
            if(!lib_053C::func_584A()) {
              thread lib_053C::func_21B5(var_00);
              common_scripts\utility::func_A70A("traversal_unblocked");
              lib_053C::func_8A62(0);
            }

            break;
          } else if(isDefined(var_00.var_A228) && var_00.var_A228 == self) {
            break;
          }
        }

        wait 0.05;
      }
    }
  }
}

lib_053C::func_21B5(param_00) {
  self endon("death");
  for(;;) {
    var_01 = gettraversalsonpath(self.var_0116, self.var_6618, self);
    if(var_01.size > 0) {
      if((param_00 != var_01[0] || !param_00.var_54F5) && !isDefined(var_01[0].var_54F5) || !var_01[0].var_54F5) {
        self method_8395(self.var_6618);
        wait 0.05;
        self notify("traversal_unblocked");
        break;
      } else {
        lib_053C::func_8A62(1);
        wait(0.5);
      }

      continue;
    }

    wait 0.05;
    self notify("traversal_unblocked");
    break;
  }
}

lib_053C::func_8A62(param_00) {
  self.var_A6D2 = param_00;
  if(param_00) {
    self scragentsetscripted(1);
    maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "Waiting For Traversal");
    var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("idle_noncombat");
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
    var_03 = self method_83D8(var_01, var_02);
    maps\mp\agents\_scripted_agent_anim_util::func_8415(var_01, var_02);
    return;
  }

  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "Waiting For Traversal");
  self scragentsetscripted(0);
}

lib_053C::func_584A() {
  return self.var_A6D2;
}

lib_053C::func_077A() {
  for(;;) {
    self waittill("traverse_end");
    self.var_AAF3 = undefined;
  }
}

lib_053C::func_0779() {
  for(;;) {
    self waittill("path_script_blocked", var_00);
    lib_053C::func_0647();
  }
}

lib_053C::func_077B(param_00) {
  self endon("death");
  self endon("new_navigation_goal");
  self endon("traverse_soon");
  self endon("traverse_complete");
  lib_053C::func_0647();
  for(;;) {
    param_00 waittill("barricaded");
    lib_053C::func_0647();
  }
}

lib_053C::func_0647() {
  var_00 = self method_8198();
  if(!lib_053C::func_5597()) {
    if(isDefined(var_00) && lib_0547::func_562C(var_00)) {
      var_01 = 0;
      if(isDefined(self.var_A08E) && var_00.var_15CB != self.var_A08E.var_15CB) {
        lib_053C::func_4F85();
        var_01 = 1;
      } else if(!isDefined(self.var_A08E)) {
        var_01 = 1;
      }

      if(var_01) {
        self.var_A08E = var_00;
      }
    } else if(isDefined(self.var_A08E)) {
      if(!lib_0547::func_562C(self.var_A08E)) {
        lib_053C::func_4F85();
        self method_8395(self.var_6618);
        self.var_A08E = undefined;
        self notify("lost_barricaded_traversal");
      } else if(common_scripts\utility::func_562E(self.var_6617)) {
        lib_053C::func_4F85();
        self method_8395(self.var_6618);
        self.var_A08E = undefined;
        self notify("lost_barricaded_traversal");
      }
    } else {}
  }

  if(isDefined(self.var_A08E)) {
    lib_053C::func_4F8D();
  } else if(isDefined(self.var_A08F)) {
    lib_053C::func_4F8A(self.var_A08F);
  } else if(isDefined(self.var_AC08)) {
    lib_053C::func_4F8B(self.var_AC08);
  }

  self.var_6617 = undefined;
}

lib_053C::func_4F8A(param_00) {
  self method_8395(param_00);
  while(distance(self.var_0116, param_00) > 32) {
    wait(0.1);
  }

  self.var_A08F = undefined;
}

lib_053C::func_4F8B(param_00) {
  param_00 endon("death");
  self endon("death");
  self endon("no_alt_paths");
  var_01 = 0.15;
  var_02 = 1;
  var_03 = 0;
  var_04 = [];
  thread lib_053C::func_298D(param_00);
  while(!isDefined(self.var_AC17) || distance(self.var_0116, self.var_AC17) > 8) {
    wait(var_01);
    var_03 = var_03 + var_01;
    if(var_03 >= var_02) {
      thread lib_053C::func_1436();
      break;
    }
  }

  thread lib_053C::func_1436();
  self notify("out_of_zombie_range");
}

lib_053C::func_298D(param_00) {
  var_01 = 3;
  self endon("out_of_zombie_range");
  var_02 = 45;
  var_03 = 15;
  var_04 = 96;
  for(var_05 = 0; var_05 < var_01; var_05++) {
    if(lib_053C::func_5724(param_00)) {
      if(lib_053C::func_5769(param_00)) {
        var_06 = param_00.var_001D + (0, -1 * var_02 + var_03 * var_05, 0);
      } else {
        var_06 = param_00.var_001D + (0, var_02 + var_03 * var_05, 0);
      }
    } else {
      break;
    }

    var_07 = anglesToForward(var_06);
    var_07 = common_scripts\utility::func_3D5D(var_07);
    var_07 = vectornormalize(var_07);
    var_08 = self.var_0116 + var_07 * var_04 / var_05 + 1;
    if(var_05 < var_01 - 1) {
      var_09 = getclosestpointonnavmesh(var_08, self);
      var_0A = (var_08[0], var_08[1], var_09[2] + 8);
    } else {
      var_0A = getclosestpointonnavmesh(self.var_0116, self);
    }

    self.var_AC17 = var_0A;
    self waittill("bad_path");
  }

  self notify("no_alt_paths");
  if(distance(self.var_0116, param_00.var_0116) < 32) {
    self dodamage(self.var_00BC + 666, self.var_0116);
  }
}

lib_053C::func_1436() {
  wait(0.75);
  self.var_AC08 = undefined;
}

lib_053C::func_5724(param_00) {
  var_01 = anglesToForward(param_00.var_001D + (0, 0, 0));
  var_01 = common_scripts\utility::func_3D5D(var_01);
  var_01 = vectornormalize(var_01);
  var_02 = param_00.var_0116 + 64 * var_01;
  var_01 = anglesToForward(param_00.var_001D + (0, 180, 0));
  var_01 = common_scripts\utility::func_3D5D(var_01);
  var_01 = vectornormalize(var_01);
  var_03 = param_00.var_0116 + 64 * var_01;
  return distance(self.var_0116, var_02) < distance(self.var_0116, var_03);
}

lib_053C::func_5769(param_00) {
  var_01 = anglesToForward(param_00.var_001D + (0, -90, 0));
  var_01 = common_scripts\utility::func_3D5D(var_01);
  var_01 = vectornormalize(var_01);
  var_02 = param_00.var_0116 + 64 * var_01;
  var_01 = anglesToForward(param_00.var_001D + (0, 90, 0));
  var_01 = common_scripts\utility::func_3D5D(var_01);
  var_01 = vectornormalize(var_01);
  var_03 = param_00.var_0116 + 64 * var_01;
  return distance(self.var_0116, var_02) < distance(self.var_0116, var_03);
}

lib_053C::func_4F9B(param_00) {
  if(self.var_00CA) {
    self.var_28D2 = undefined;
    return 0;
  }

  if(common_scripts\utility::func_562E(level.var_3F9D)) {
    return 0;
  }

  var_01 = undefined;
  if(isDefined(self.var_1928)) {
    var_01 = self.var_1928;
  } else if(isDefined(self.var_1924)) {
    var_01 = self.var_1924;
  } else if(isDefined(level.var_1CC4) && common_scripts\utility::func_562E(self.var_56EB) && lib_053C::func_0C35()) {
    var_01 = level.var_1CC4;
  } else if(lib_053C::func_AB86() && !common_scripts\utility::func_562E(self.has_lost_distractiondrone_interest)) {
    var_01 = self.var_3043;
  } else if(isDefined(self.var_9B61) && !lib_053C::func_5686()) {
    if(isDefined(self.var_9B61.var_01A2) && !isDefined(self.var_9B61.var_76A3)) {
      self.var_9B61.var_76A3 = common_scripts\utility::func_46B5(self.var_9B61.var_01A2, "targetname");
    }

    if(isDefined(self.var_9B61.var_76A3) && !common_scripts\utility::func_562E(self.var_4B3B)) {
      var_01 = self.var_9B61.var_76A3;
      if(distance(self.var_0116, self.var_9B61.var_76A3.var_0116) < 48) {
        self.var_4B3B = 1;
        var_01 = self.var_9B61;
      }
    } else {
      var_01 = self.var_9B61;
    }
  } else if(isDefined(self.var_1927) && !lib_053C::func_5686()) {
    var_01 = self.var_1927;
  } else if(isDefined(self.var_0088) && !lib_0547::func_8B95(self.var_0088)) {
    var_01 = self.var_0088;
  }

  if(isDefined(var_01)) {
    var_02 = self.var_11AB + self.var_014F * 2;
    var_03 = var_02 * var_02;
    var_04 = self.var_11AB;
    var_05 = var_04 * var_04;
    self.var_28D2 = var_01;
    var_06 = maps\mp\agents\humanoid\_humanoid::func_457E(var_01);
    var_07 = var_06.var_3771;
    var_08 = distancesquared(var_06.var_0116, self.var_0116);
    var_09 = distancesquared(var_07, self.var_0116);
    var_0A = self.var_173E;
    if(var_09 < squared(self.var_014F) && distancesquared(var_07, var_06.var_0116) > squared(self.var_014F)) {
      var_0A = 1;
      self notify("attack_anim", "end");
    }

    if(isDefined(param_00) && param_00) {
      if(!var_0A && var_09 > var_03) {
        var_0A = 1;
      }
    } else if(!var_0A && var_09 > var_03 && var_08 > var_05) {
      var_0A = 1;
    }

    if(var_06.var_A266) {
      if(!var_0A && var_08 > squared(self.var_2BCA)) {
        var_0A = 1;
      }

      self method_8399(self.var_2BCA);
    } else if(!maps\mp\agents\humanoid\_humanoid_util::func_4BA3(var_01, self.var_60F5)) {
      self method_8399(self.var_2BCA);
      var_0A = 1;
    } else {
      self method_8399(var_02);
      if(var_09 <= var_03) {
        var_06.var_0116 = self.var_0116;
        var_0A = 1;
      }
    }

    if(var_0A) {
      var_0B = getclosestpointonnavmesh(var_06.var_0116, self);
      if(distancesquared(var_0B, var_01.var_0116) > distancesquared(var_06.var_0116, var_01.var_0116)) {
        var_0B = getclosestpointonnavmesh(var_01.var_0116, self);
      }

      if(isDefined(self.override_snapped_point_func) && isPlayer(var_01)) {
        var_0B = [[self.override_snapped_point_func]](var_01, var_0B);
      }

      lib_053C::func_06CE(var_0B);
    }

    lib_053C::func_0647();
    return 1;
  } else {
    if(isDefined(self.var_28D2)) {
      self.var_173E = 1;
    }

    self.var_28D2 = undefined;
  }

  return 0;
}

lib_053C::func_AB86() {
  return isDefined(self.var_3043) && maps\mp\agents\humanoid\_humanoid_util::func_8BAE();
}

lib_053C::func_0C35() {
  var_00 = 0;
  foreach(var_02 in level.var_744A) {
    if(common_scripts\utility::func_562E(var_02.var_7414) || var_02.var_5378 || !isalive(var_02)) {
      var_00++;
    }
  }

  return var_00 == level.var_744A.size;
}

lib_053C::func_5686() {
  return isDefined(self.var_983C) && self.var_983C.size > 0;
}

humanoid_has_valid_targets(param_00) {
  if(!common_scripts\utility::func_562E(param_00) && isDefined(self.var_3043) || isDefined(self.var_1928)) {
    return 1;
  }

  foreach(var_02 in function_02D1()) {
    if(humanoid_is_valid_target(var_02)) {
      return 1;
    }
  }

  return 0;
}

humanoid_is_valid_target(param_00) {
  if(param_00.var_00CE || isDefined(param_00.var_0117) && param_00.var_0117.var_00CE) {
    return 0;
  }

  if(param_00 method_8541() || isDefined(param_00.var_0117) && param_00.var_0117 method_8541()) {
    return 0;
  }

  if(isalliedsentient(self, param_00)) {
    return 0;
  }

  if(lib_0547::func_8B95(param_00)) {
    return 0;
  }

  if(!isalive(param_00)) {
    return 0;
  }

  return 1;
}

lib_053C::func_4F88() {
  if(isDefined(self.var_3043)) {
    return [];
  }

  if(isDefined(self.forcedtargets) && isarray(self.forcedtargets) && self.forcedtargets.size > 0) {
    var_00 = [];
    self.forcedtargets = common_scripts\utility::func_0FA0(self.forcedtargets);
    foreach(var_02 in self.forcedtargets) {
      if(function_0279(var_02)) {
        continue;
      }

      var_00 = common_scripts\utility::func_0F6F(var_00, var_02);
    }

    self.forcedtargets = var_00;
    return function_01AC(var_00, self.var_0116);
  }

  var_04 = [];
  foreach(var_06 in function_02D1()) {
    if(humanoid_is_valid_target(var_06)) {
      var_04[var_04.size] = var_06;
    }
  }

  if(0 == var_04.size) {
    return [];
  }

  return function_01AC(var_04, self.var_0116);
}

lib_053C::func_4F9A() {
  if(self.var_00CA) {
    return 0;
  }

  var_00 = lib_053C::func_4F88();
  if(isDefined(var_00) && var_00.size > 0) {
    var_01 = 300;
    var_02 = distancesquared(var_00[0].var_0116, self.var_0116);
    if(var_02 < var_01 * var_01) {
      var_01 = 16;
    }

    if(self.var_173E || distancesquared(self method_8396(), var_00[0].var_0116) > var_01 * var_01) {
      var_03 = getclosestpointonnavmesh(var_00[0].var_0116);
      lib_053C::func_06CE(var_03);
      self.var_173E = 0;
    }

    lib_053C::func_0647();
    return 1;
  }

  return 0;
}

lib_053C::func_4F87(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(self.var_173E || distancesquared(lib_053C::func_0631(), param_00.var_0116) > squared(128)) {
    lib_053C::func_06CE(param_00.var_0116);
    self.var_173E = 0;
  }

  lib_053C::func_0647();
  return 1;
}

lib_053C::func_4F7F(param_00, param_01) {
  var_02 = 234;
  if(!isDefined(self)) {
    return;
  }

  self endon("death");
  if(common_scripts\utility::func_562E(self.var_9E1A) || common_scripts\utility::func_562E(level.zmb_fog_passive_lock)) {
    return;
  }

  if(!common_scripts\utility::func_3794("zombie_passive")) {
    return;
  }

  self.var_9E1A = 1;
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(param_01) {
    foreach(var_04 in maps\mp\agents\_agent_utility::func_43FD("all")) {
      if(self == var_04) {
        continue;
      }

      if(distance(self.var_0116, var_04.var_0116) < var_02) {
        var_04 thread lib_053C::func_4F80();
      }
    }
  }

  if(isDefined(self.var_9024)) {
    var_06 = level.var_AC80.var_ACB3[self.var_9024];
    var_07 = 10;
    self.passive_activation_time_ms = gettime();
    while(!common_scripts\utility::func_3C77(var_06.var_AC8A)) {
      if(var_07 <= 0 || !lib_054D::func_0F0A(self)) {
        lib_056D::func_5A86();
      }

      var_08 = randomfloatrange(0.5, 1);
      wait(var_08);
      var_07 = var_07 - var_08;
    }

    wait 0.05;
  }

  self.passive_activation_time_ms = gettime();
  common_scripts\utility::func_3796("zombie_passive");
  humanoid_reset_passive_data();
  if(isDefined(self.post_passive_func)) {
    self thread[[self.post_passive_func]]();
  }
}

lib_053C::func_4F80() {
  self endon("death");
  var_00 = 0.25;
  var_01 = 1;
  wait(randomfloatrange(var_00, var_01));
  lib_053C::func_4F7F("wakeup chain", 1);
}

humanoid_passive_register_wakeup_func(param_00) {
  if(!isDefined(level.passive_check_wakeup_funcs)) {
    level.passive_check_wakeup_funcs = [];
  }

  level.passive_check_wakeup_funcs[level.passive_check_wakeup_funcs.size] = param_00;
}

humanoid_passive_check_wakeup_threads() {
  self endon("zombie_no_longer_passive");
  childthread lib_053C::func_4F96();
  childthread lib_053C::func_4F98();
  childthread lib_053C::func_4F97();
  if(isDefined(level.passive_check_wakeup_funcs)) {
    foreach(var_01 in level.passive_check_wakeup_funcs) {
      self childthread[[var_01]]();
    }
  }
}

lib_053C::func_4F95() {
  self endon("death");
  for(;;) {
    common_scripts\utility::func_379C("zombie_passive");
    childthread humanoid_passive_check_wakeup_threads();
    common_scripts\utility::func_37A1("zombie_passive");
    self notify("zombie_no_longer_passive");
  }
}

lib_053C::func_4F96() {
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(isPlayer(var_01)) {
      if(lib_0547::func_8B95(var_01) || isDefined(var_09) && issubstr(var_09, "austen_pap_zm")) {
        continue;
      }

      self.woken_by_player_aggro = 1;
    }

    break;
  }

  lib_053C::func_4F7F("damaged");
}

lib_053C::func_4F98() {
  var_00 = 0.5;
  var_01 = int(var_00 * 20);
  for(var_02 = 0; !var_02; var_02 = humanoid_passive_default_should_wakeup_range()) {
    wait(var_00);
    if(isDefined(level.passive_wakeup_range_func)) {
      var_02 = self[[level.passive_wakeup_range_func]]();
      continue;
    }
  }

  lib_053C::func_4F7F("player close");
}

humanoid_passive_default_should_wakeup_range() {
  var_00 = 234;
  var_01 = var_00;
  if(isDefined(self.var_6EB0)) {
    var_01 = self.var_6EB0;
  }

  var_02 = 0.5;
  var_03 = int(var_02 * 20);
  var_04 = lib_053C::func_4F88()[0];
  if(!isDefined(var_04)) {
    return 0;
  }

  var_05 = distance(self.var_0116, var_04.var_0116);
  if(var_05 > var_01) {
    return 0;
  }

  return 1;
}

lib_053C::func_4F97() {
  var_00 = self.var_66AC;
  if(isDefined(var_00)) {
    wait(var_00);
    while(!humanoid_has_valid_targets(1)) {
      wait(1);
    }

    lib_053C::func_4F7F("passive time max: " + maps\mp\_utility::func_5D7F(var_00));
    self.var_66AC = undefined;
  }
}

lib_053C::func_2208() {
  var_00 = 390;
  var_01 = 78;
  var_02 = 64;
  var_03 = 0;
  var_04 = self.var_37BB;
  var_05 = maps\mp\agents\_agent_utility::func_43FD("all");
  for(;;) {
    var_04 = getrandomnavpoint(var_04, var_00);
    var_06 = 0;
    foreach(var_08 in var_05) {
      if(var_08 == self) {
        continue;
      }

      if(isDefined(var_08.var_6EAE) && distance(var_08.var_6EAE, var_04) < var_02) {
        var_06 = 1;
        break;
      }

      if(isDefined(var_08.var_37BB) && distance(var_08.var_37BB, var_04) < var_01) {
        var_06 = 1;
        break;
      }
    }

    if(!var_06) {
      break;
    }

    var_03++;
    if(var_03 > 10) {
      var_03 = 0;
      wait 0.05;
    }
  }

  return var_04;
}

lib_053C::func_9C74() {
  self.var_6EAF = "idle";
  self scragentsetscripted(1);
  if(isDefined(self.custom_passive_action)) {
    [[self.custom_passive_action]]();
  } else {
    maps\mp\agents\_scripted_agent_anim_util::func_8410("idle_noncombat");
  }

  self.var_6EAE = self.var_0116;
  self method_855C();
}

lib_053C::func_4F8C() {
  var_00 = 8;
  if(common_scripts\utility::func_3794("zombie_passive")) {
    if(!isDefined(self.var_6EAF)) {
      self.woken_by_player_aggro = undefined;
      if(common_scripts\utility::func_562E(self.var_47F1)) {
        self.var_47F1 = 0;
        lib_053C::func_9C74();
      } else {
        self.var_6EAF = "leaving_spawn_closet";
        if(!lib_0547::func_4B2C() && isDefined(self.var_9024)) {
          lib_053C::func_06CE(level.var_AC80.var_ACB3[self.var_9024].var_74DC);
        }
      }
    }

    if(self.var_6EAF == "leaving_spawn_closet" && lib_0547::func_4B2C()) {
      self.var_6EAF = "searching_for_goal";
      self.var_6EAE = lib_053C::func_2208();
      if(!common_scripts\utility::func_3794("zombie_passive")) {
        return 1;
      }

      self.var_6EAF = "pathing_to_goal";
      lib_053C::func_06CE(self.var_6EAE);
    }

    if(self.var_6EAF == "pathing_to_goal" && lib_0547::func_2436(self.var_6EAE, self.var_0116, var_00, 32)) {
      lib_053C::func_9C74();
    }

    lib_053C::func_0647();
    return 1;
  }

  if(isDefined(self.var_6EAF)) {
    humanoid_reset_passive_data();
  }

  return 0;
}

humanoid_reset_passive_data() {
  if(isDefined(self.var_6EAF)) {
    if(self.var_6EAF == "idle" && !maps\mp\agents\_scripted_agent_anim_util::func_57E2()) {
      self scragentsetscripted(0);
    }

    self.var_6EAF = undefined;
  }

  self.var_9E1A = undefined;
  self.var_A7A8 = undefined;
}

lib_053C::func_635C() {
  self endon("death");
  for(;;) {
    var_00 = lib_053C::func_4F88();
    var_01 = var_00.size > 0;
    var_02 = isDefined(self.var_3043) || isDefined(self.var_1927) || isDefined(self.var_9B61) || lib_053C::func_5686();
    if(common_scripts\utility::func_3794("zombie_passive")) {
      if((common_scripts\utility::func_562E(self.var_A7A8) && var_01) || var_02) {
        lib_053C::func_4F7F("target point available");
      }
    } else if(!var_01 && !var_02 && !is_passive_exempt()) {
      common_scripts\utility::func_379A("zombie_passive");
      self.var_A7A8 = 1;
    }

    wait(0.5);
  }
}

is_passive_exempt() {
  return (isDefined(level.zmb_exempt_from_passive_list) && common_scripts\utility::func_0F79(level.zmb_exempt_from_passive_list, self.var_0A4B)) || common_scripts\utility::func_562E(self.ispassiveexempt);
}

lib_053C::func_4F8D() {
  if(!isDefined(self.var_9D04)) {
    if(self.var_0BA4 != "traverse" && lib_0547::func_4B24()) {
      self.var_9D04 = 0;
    } else {
      self.var_9D04 = undefined;
      return 0;
    }
  }

  if(common_scripts\utility::func_562E(self.var_6617)) {
    if(isDefined(self.var_2308)) {
      self method_8395(self.var_2308.var_0116);
    } else if(isDefined(self.var_A6E6)) {
      self method_8395(self.var_A6E6);
    }
  }

  switch (self.var_9D04) {
    case 0:
      if(!lib_0547::func_4B24()) {
        lib_053C::func_4F85();
        return 0;
      }

      var_00 = self.var_A08E.var_15CB;
      var_01 = var_00 lib_0549::func_15DB(self);
      if(isDefined(var_01)) {
        self method_8395(var_01.var_0116);
        self.var_9D04 = 1;
        return 1;
      } else {
        if(isDefined(self.var_A6E6)) {
          return 1;
        }

        self.var_A6E6 = var_00 lib_0549::func_15DE();
        self method_8395(self.var_A6E6);
        return 1;
      }

      break;

    case 1:
      if(!lib_0547::func_4B24()) {
        lib_053C::func_4F85();
        return 0;
      }

      var_02 = self method_8396();
      if(distancesquared(var_02, self.var_2308.var_0116) > 1024) {
        self method_8395(self.var_2308.var_0116);
      }

      var_03 = self.var_014F * self.var_014F;
      var_04 = distance2dsquared(self.var_0116, self.var_2308.var_0116);
      if(var_04 > var_03) {
        return 1;
      }
      return lib_053C::func_4F81();

    case 3:
      if(isDefined(self.var_15D2)) {
        return 1;
      }
      return lib_053C::func_4F81();

    case 5:
      if(common_scripts\utility::func_562E(self.var_983D)) {
        return 1;
      }
      return lib_053C::func_4F81();
  }

  return 0;
}

lib_053C::func_4F85() {
  if(isDefined(self.var_9D04)) {
    var_00 = self.var_A08E.var_15CB;
    switch (self.var_9D04) {
      case 0:
        self.var_A6E6 = undefined;
        break;

      case 3:
        if(isDefined(var_00.var_15D9)) {
          var_01 = level.var_AAEF[var_00.var_15D9];
          if(isDefined(var_01)) {
            self[[var_01]](var_00);
          }
        }

        var_00 lib_0549::func_15DF(self);
        break;

      case 1:
        var_00 lib_0549::func_15DF(self);
        break;

      case 5:
        var_00 lib_0549::func_15DF(self);
        break;
    }

    self.var_9D04 = undefined;
  }
}

lib_053C::func_4F81() {
  var_00 = self.var_A08E.var_15CB;
  if(!lib_0547::func_4B24()) {
    lib_053C::func_4F85();
    return 0;
  }

  if(isDefined(var_00.var_15D9)) {
    var_01 = level.var_AAF0[var_00.var_15D9];
    if(isDefined(var_01)) {
      var_02 = self[[var_01]](var_00);
      if(common_scripts\utility::func_562E(var_02)) {
        return 1;
      }
    }
  }

  thread lib_053C::func_4F9C();
  return 1;
}

lib_053C::func_4F99(param_00, param_01) {
  self endon("board_pull_interrupted");
  self.var_9D04 = 3;
  self.var_15D2 = "pulling_board";
  self scragentsetscripted(1);
  self method_839D("noclip");
  lib_053C::func_1888("grab");
  lib_053C::func_1888("hold");
  param_00 thread lib_0549::func_15D3(param_01.var_1887);
  lib_053C::func_1888("pull");
  self.var_15D2 = undefined;
  self scragentsetscripted(0);
  self method_839D("gravity");
  param_00 lib_0549::func_15E0(self);
}

lib_053C::func_1888(param_00) {
  var_01 = "board_" + self.var_2308.var_0EA5 + "_" + param_00;
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_01);
  var_03 = self.var_2309.var_1887;
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", self.var_2308.var_001D);
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, var_03, 1, "board_pull");
}

lib_053C::func_4F89() {
  var_00 = self.var_A08E.var_15CB;
  var_01 = var_00 lib_0549::func_15DD(self);
  return var_01;
}

lib_053C::func_4F83(param_00) {
  self endon("death");
  self.var_9D04 = 3;
  self.var_15D2 = "attacking_through_boards";
  var_01 = self.var_A08E.var_15CB;
  var_02 = var_01.var_38EB.var_001D;
  self scragentsetorientmode("face angle abs", var_02);
  var_03 = "attack_stand";
  var_04 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_03);
  var_05 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_04);
  self.var_117A = param_00;
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_04, var_05, 1, "attack_anim", undefined, ::lib_053C::func_1179);
  self scragentsetscripted(0);
  self.var_15D2 = undefined;
}

lib_053C::func_1179(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_117A) && isalive(self.var_117A)) {
    switch (param_00) {
      case "zombie_melee":
        var_04 = self.var_117A.var_00BC;
        if(isDefined(self.var_60E2)) {
          var_04 = self.var_60E2;
        }

        maps\mp\agents\humanoid\_humanoid_melee::func_3210(self.var_117A, var_04, "MOD_IMPACT");
        self.var_117A = undefined;
        break;
    }
  }
}

lib_053C::func_4F92(param_00) {
  self endon("drop_gate_interact_interrupt");
  var_01 = param_00.var_15CC;
  self.var_9D04 = 3;
  self.var_15D2 = "lifting_gj_gate";
  self scragentsetscripted(1);
  self method_839D("noclip");
  lib_053C::func_4F93(param_00);
  while(var_01.var_17E9) {
    if(common_scripts\utility::func_562E(var_01.var_5CCB)) {
      lib_053C::func_346C("lift", param_00, "gate_state_changed", var_01);
      continue;
    }

    thread lib_0549::func_346E(var_01);
    lib_053C::func_346C("idle", param_00, "pull_state_change", var_01);
    lib_0549::func_346D(var_01);
    waittillframeend;
  }

  self scragentsetscripted(0);
  self method_839D("gravity");
  self.var_15D2 = undefined;
}

lib_053C::func_4F86(param_00) {
  self endon("drop_gate_interact_interrupt");
  var_01 = param_00.var_15CC;
  self.var_9D04 = 3;
  self.var_15D2 = "crawling_under_gj_gate";
  self scragentsetscripted(1);
  self method_839D("noclip");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D("gj_lift_gate_crawl_under");
  var_03 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_02);
  var_04 = self method_83D8(var_02, var_03);
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", self.var_2308.var_001D);
  self method_8395(self.var_6618);
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, var_03, 1, "gj_gate_drop");
  thread lib_053C::func_4F85();
}

lib_053C::func_4F93(param_00) {
  var_01 = param_00.var_15CC;
  if(var_01 lib_0549::func_3463()) {
    lib_053C::func_346C("mount", param_00, "pull_state_change", var_01);
  }
}

lib_053C::func_346C(param_00, param_01, param_02, param_03) {
  if(isDefined(param_02)) {
    param_03 endon(param_02);
  }

  var_04 = param_01.var_15CC;
  param_00 = var_04 lib_0549::func_345B(self, param_00);
  var_05 = maps\mp\agents\_scripted_agent_anim_util::func_434D(param_00);
  var_06 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_05);
  var_07 = self method_83D8(var_05, var_06);
  var_08 = undefined;
  if(animhasnotetrack(var_07, "end_start")) {
    var_09 = maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_07, "end_start");
    var_08 = 1 - var_09 * getanimlength(var_07);
    var_08 = randomfloatrange(0, var_08);
  }

  var_0A = getstartorigin(param_01.var_8310, param_01.var_830F, var_07);
  var_0B = getstartangles(param_01.var_8310, param_01.var_830F, var_07);
  self setorigin(var_0A, 0);
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", var_0B);
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_05, var_06, 1, "gj_gate_drop", "end_start");
  if(isDefined(var_08)) {
    wait(var_08);
  }
}

lib_053C::func_4F9C() {
  self endon("death");
  var_00 = "board_taunt";
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_00);
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  self.var_9D04 = 5;
  self.var_983D = 1;
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", self.var_2308.var_001D);
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "taunt_anim");
  self scragentsetscripted(0);
  self.var_983D = undefined;
}

lib_053C::func_4F82() {
  self endon("death");
  var_00 = "attack_stand";
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_00);
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", self.var_2308.var_001D);
  self scragentsetscripted(1);
  self.var_567F = 1;
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "attack_anim");
  self.var_567F = 0;
  self scragentsetscripted(0);
}

lib_053C::func_5597() {
  if(isDefined(self.var_9D04)) {
    switch (self.var_9D04) {
      case 1:
      case 0:
        return 0;

      case 5:
      case 3:
        return 1;
    }
  }

  return 0;
}

lib_053C::func_4F94(param_00) {
  lib_053C::func_4F85();
}

lib_053C::func_6AA4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  lib_053C::func_4F85();
}