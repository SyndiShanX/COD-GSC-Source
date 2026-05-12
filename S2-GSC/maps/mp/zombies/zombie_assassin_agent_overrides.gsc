/***************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_assassin_agent_overrides.gsc
***************************************************************/

onassassinzombiechooseturn() {
  var_00 = undefined;
  self.var_1E22 = undefined;
  var_01 = 0.1;
  var_02 = int(var_01 * 20);
  for(;;) {
    if(maps\mp\agents\humanoid\_humanoid_move::func_5810()) {
      self.var_1E22 = undefined;
    } else {
      var_03 = nocornerturnassassin();
      if(isDefined(var_03)) {
        return var_03;
      }

      var_04 = self method_85D6();
      if(!isDefined(var_04)) {
        self.var_1E22 = undefined;
      } else {
        var_05 = var_04["position"];
        var_06 = var_04["angle"];
        var_07 = distance2dsquared(self.var_116, var_05);
        if(var_07 > squared(150)) {} else {
          var_0A = !isDefined(self.var_1E22) || self.var_1E22.var_266C != var_05 || abs(angleclamp180(self.var_1E22.var_266F - var_06)) > 20;
          if(var_0A) {
            if(level.var_AC67 == level.var_AC37) {} else {
              if(var_0A) {
                level.var_AC67++;
                self.var_1E22 = spawnStruct();
                self.var_1E22.var_266C = var_05;
                self.var_1E22.var_266F = var_06;
                var_0B = self[[maps\mp\agents\_agent_utility::func_A59("get_action_params")]]();
                var_0C = "turn_" + self.var_108;
                self.var_1E22.var_6748 = lib_054D::func_9031(var_0C, var_0B, var_06);
                var_0C = var_0C + "_quick";
                self.var_1E22.var_789D = lib_054D::func_9031(var_0C, var_0B, var_06);
              }

              var_00 = self.var_1E22.var_6748;
              if(var_00.var_5811) {
                if(lib_054D::func_314F(var_05, var_06, var_00)) {
                  break;
                }
              }

              var_00 = self.var_1E22.var_789D;
              if(var_00.var_5811) {
                if(lib_054D::func_314F(var_05, var_06, var_00)) {
                  break;
                }
              }
            }
          }
        }
      }
    }

    wait(var_01);
  }

  var_03 = spawnStruct();
  var_03.var_EE8 = var_00.var_EE8;
  var_03.var_873 = var_00.var_873;
  var_03.var_EC1 = var_00.var_37E2;
  var_03.var_EC3 = "code_move";
  var_03.var_6C37 = "face motion";
  return var_03;
}

nocornerturnassassin() {
  var_00 = 113;
  var_01 = self method_83E6();
  if(var_01 == (0, 0, 0)) {
    return;
  }

  var_02 = self.var_1D[1];
  var_03 = vectortoyaw(var_01);
  var_04 = angleclamp180(var_03 - var_02);
  if(abs(var_04) < var_00) {
    return;
  }

  var_05 = self[[maps\mp\agents\_agent_utility::func_A59("get_action_params")]]();
  var_06 = "turn_" + self.var_108;
  var_07 = maps\mp\agents\_scripted_agent_anim_util::func_87C(var_06, var_05);
  if(!isDefined(var_07)) {
    return;
  }

  var_08 = self method_83DB(var_07);
  var_09 = maps\mp\agents\_scripted_agent_anim_util::func_4416(var_04, var_08);
  var_0A = var_09 == int(var_08 * 0.5);
  if(var_0A) {
    return;
  }

  var_0C = self method_83D9(var_07, var_09);
  var_0D = self method_83D8(var_07, var_09);
  var_0E = getmovedelta(var_0D);
  var_0F = length(var_0E);
  var_10 = self method_85D5(var_0F);
  var_11 = self localtoworldcoords(var_0E);
  if(vectordot(var_11 - self.var_116, var_10 - self.var_116) > 0) {
    var_12 = distance(self.var_116, var_10);
    var_13 = 50;
    if(var_0F + var_13 > var_12) {
      return;
    }
  }

  var_14 = function_02E6(var_11, self) && function_02DE(self.var_116, var_11, self);
  if(!var_14) {
    return;
  }

  var_16 = spawnStruct();
  var_16.var_EE8 = var_07;
  var_16.var_873 = var_06;
  var_16.var_EC1 = var_09;
  var_16.var_EC3 = "anim deltas";
  var_16.var_6C37 = "face angle abs";
  var_16.var_6C38 = (self.var_1D[0], self.var_1D[1] + var_04 - getangledelta(var_0D), self.var_1D[2]);
  return var_16;
}