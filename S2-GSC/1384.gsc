/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1384.gsc
*********************************************/

lib_0568::func_00D5() {
  level.var_0A41["zombie_klaus"] = level.var_0A41["zombie"];
  level.var_0A41["zombie_klaus"]["think"] = ::lib_0568::func_5A9A;
  level.var_0A41["zombie_klaus"]["move_mode"] = ::lib_0568::func_5A8F;
  level.var_0A41["zombie_klaus"]["on_damaged"] = ::lib_0568::func_5A92;
  level.var_0A41["zombie_klaus"]["on_damaged_finished"] = ::lib_0568::func_5A91;
  level.var_0A41["zombie_klaus"]["is_hit_weak_point"] = ::lib_0568::func_5A8E;
  var_00 = spawnStruct();
  var_00.var_0A4B = "zombie_klaus";
  var_00.var_0EAE = "zombie_animclass";
  var_00.var_0879 = "zombie_generic";
  var_00.var_4C12 = 1;
  var_00.var_60E2 = 0;
  var_00.var_2F9B = 1;
  var_00.parenttype = "zombie_generic";
  var_00.var_5ED2["revived klaus"]["whole_body"] = "zom_klaus_wholebody";
  lib_0547::func_0A52(var_00, "zombie_klaus");
  lib_0547::func_7BD0("klauspossum", ::lib_0568::func_5A93, ::lib_0568::func_5A95, 8);
}

lib_0568::func_5A9A() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  maps\mp\agents\humanoid\_humanoid::func_8A27();
  thread lib_0547::func_A692();
  self method_85A1("zombie");
  self.var_480F = 1;
  self.var_6816 = 1;
  self.var_00CE = 1;
  self.shouldnotpreventlaststand = 1;
  self.failsafe_exempt = 1;
  self.var_55AB = 1;
  self.var_562B = 1;
  self.var_00CF = 1;
  self.var_0C29 = 0;
  self.ispassiveexempt = 1;
  self.var_2FA4 = 1;
  self method_8539(0);
  self method_8540(1);
  self method_853E(1);
  self method_85E0(1);
  for(;;) {
    if(lib_053C::func_4F9B()) {} else {
      lib_053C::func_0647();
    }

    wait(0.2);
  }
}

lib_0568::func_5A92(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {}

lib_0568::func_5A91(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {}

lib_0568::func_5A8E() {
  return 0;
}

lib_0568::func_5A8F() {
  return "walk";
}

lib_0568::func_5A97(param_00, param_01) {
  var_02 = lib_054D::func_90BA("zombie_klaus", param_00, "klaus", 0, 1, 0);
  var_02.var_0116 = param_00.var_0116;
  var_02.var_001D = param_00.var_001D;
  var_02.var_509A = 1;
  self.var_00CE = 1;
  self.shouldnotpreventlaststand = 1;
  self.failsafe_exempt = 1;
  self.var_55AB = 1;
  self.var_562B = 1;
  self.var_00CF = 1;
  self.var_0C29 = 0;
  self.ispassiveexempt = 1;
  var_02 maps\mp\agents\_agent_utility::func_83FE(level.var_746E);
  var_02.var_6701 = 1;
  if(common_scripts\utility::func_562E(param_01)) {
    var_02 lib_0547::func_84CB();
  } else {
    var_02 thread lib_0547::func_7D1A("klauspossum");
  }

  return var_02;
}

lib_0568::func_5A93() {
  lib_0366::func_8E48(0);
  var_00 = "s2_klaus_revive";
  maps\mp\agents\humanoid\_humanoid_util::func_8318(self.var_0116, self.var_001D, var_00, 0, 0, undefined, 1, 1, "klaus_getup");
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "ScriptedAnimation");
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", self.var_001D);
  self method_839D("noclip");
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_00, 1, 1, "scripted_anim", "end", undefined);
  lib_0568::func_5A94();
}

lib_0568::func_5A94() {
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "ScriptedAnimation");
  self scragentsetscripted(0);
  self method_839D("gravity");
  lib_0547::func_84CB();
  self notify("klaus_getup_finished");
}

lib_0568::func_5A95() {
  lib_0568::func_5A94();
}

lib_0568::func_5A90(param_00) {
  self.var_1928 = param_00;
  lib_0568::func_5A9B(param_00);
}

lib_0568::func_5A9B(param_00) {
  var_01 = 75;
  for(;;) {
    if(distance(self.var_0116, param_00.var_0116) < var_01) {
      break;
    }

    wait(0.1);
  }
}

lib_0568::func_5A98() {
  self.var_5A8B = 1;
  self.var_78C5 = spawnlinkedfx(common_scripts\utility::func_44F5("temp_klaus_radius"), self, "J_MainRoot");
  triggerfx(self.var_78C5);
  self.var_78C5 thread lib_0547::func_2D19(self);
  thread lib_0568::func_5A8C();
}

lib_0568::func_5A99() {
  self.var_5A8B = 0;
  self.var_78C5 delete();
  self notify("stop_aura");
  foreach(var_01 in level.var_744A) {
    var_01 lib_0547::func_7458(0, "klaus_aura");
    var_01.var_5377 = 0;
  }
}

lib_0568::func_5A8C() {
  self endon("stop_aura");
  self endon("death");
  thread klaus_knockback_effect_think();
  for(;;) {
    if(common_scripts\utility::func_562E(self.var_5A8B)) {
      foreach(var_01 in level.var_744A) {
        var_02 = distance2d(var_01.var_0116, self.var_0116) < 256 && abs(var_01.var_0116[2] - self.var_0116[2]) < 64 && !lib_0547::func_577E(var_01);
        if(var_02) {
          var_01 lib_0547::func_7454(3);
          var_03 = lib_0547::func_408F();
          foreach(var_05 in var_03) {
            if(distance(var_05.var_0116, var_01.var_0116) > 128) {
              continue;
            }

            var_05 dodamage(500, var_01.var_0116, var_01);
          }
        }

        if(common_scripts\utility::func_562E(var_01.var_5377) == var_02) {
          continue;
        }

        var_01.var_5377 = var_02;
        var_01 lib_0547::func_7458(var_02, "klaus_aura");
      }
    }

    wait(1);
  }
}

klaus_knockback_effect_think() {
  self endon("stop_aura");
  self endon("death");
  for(;;) {
    if(common_scripts\utility::func_562E(self.var_5A8B)) {
      foreach(var_01 in level.var_744A) {
        if(!isalive(var_01)) {
          continue;
        }

        if(lib_0547::func_577E(var_01)) {
          continue;
        }

        if(var_01 istouching(self)) {
          var_02 = 200;
          var_03 = 1 - distance(self.var_0116 + (0, 0, 42), var_01.var_0116) / var_02;
          if(var_03 < 0) {
            var_03 = 0;
          }

          var_01 klaus_knockback(self.var_0116 + (0, 0, 42), var_03 * var_02 + 100);
        }
      }
    }

    wait 0.05;
  }
}

klaus_knockback(param_00, param_01) {
  var_02 = self.var_0116 - param_00;
  var_03 = param_01 * vectornormalize(var_02);
  var_03 = (var_03[0], var_03[1], 150);
  if(param_01 > 0) {
    self setvelocity(var_03);
  }
}

lib_0568::func_5A96() {
  thread lib_0568::func_5A99();
  var_00 = "s2_klaus_death";
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "ScriptedAnimation");
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", self.var_001D);
  self method_839D("noclip");
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_00, 0, 1, "scripted_anim", "disapear", undefined);
  self.var_1DEB = 1;
  self suicide();
}