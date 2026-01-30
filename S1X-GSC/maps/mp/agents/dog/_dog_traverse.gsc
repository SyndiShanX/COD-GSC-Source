/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_dog_traverse.gsc
************************************************/

main() {
  self endon("killanimscript");

  if(!isDefined(level.dogtraverseanims)) {
    initdogtraverseanims();
  }

  var_0 = self getnegotiationstartnode();
  var_1 = self getnegotiationendnode();

  if(var_0.animscript == "bot_walk_forward") {
    var_2 = var_1.origin - var_0.origin;
    var_3 = length(var_2) / 256;
    var_4 = (var_2[0], var_2[1], 0);
    var_5 = vectortoangles(var_4);
    self scragentsetorientmode("face angle abs", var_5);
    self scragentdoanimlerp(var_0.origin, var_1.origin, var_3);
    self scragentsetphysicsmode("noclip");
    maps\mp\agents\_scriptedagents::playanimfortime("run", var_3);
  } else {
    var_6 = undefined;
    var_6 = level.dogtraverseanims[var_0.animscript];

    if(!isDefined(var_6)) {
      return;
    }
    self.blockgoalpos = 1;
    var_2 = var_1.origin - var_0.origin;
    var_4 = (var_2[0], var_2[1], 0);
    var_5 = vectortoangles(var_4);
    self scragentsetorientmode("face angle abs", var_5);
    self scragentsetanimmode("anim deltas");
    var_7 = self getanimentry(var_6, 0);
    var_8 = getnotetracktimes(var_7, "code_move");

    if(var_8.size > 0) {
      var_9 = getmovedelta(var_7, 0, var_8[0]);
    } else {
      var_9 = getmovedelta(var_7, 0, 1);
    }

    var_10 = maps\mp\agents\_scriptedagents::getanimscalefactors(var_2, var_9);
    self scragentsetphysicsmode("noclip");

    if(var_2[2] > 0) {
      if(var_9[2] > 0) {
        var_11 = getnotetracktimes(var_7, "traverse_jump_start");

        if(var_11.size > 0) {
          var_12 = 1;
          var_13 = 1;

          if(length2dsquared(var_4) < 0.64 * length2dsquared(var_9)) {
            var_12 = 0.4;
          }

          if(var_2[2] < 0.75 * var_9[2]) {
            var_13 = 0.5;
          }

          self scragentsetanimscale(var_12, var_13);
          maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_6, 0, "traverse", "traverse_jump_start");
          var_14 = getnotetracktimes(var_7, "traverse_jump_end");
          var_15 = getmovedelta(var_7, 0, var_11[0]);
          var_16 = getmovedelta(var_7, 0, var_14[0]);
          var_12 = 1;
          var_13 = 1;
          var_17 = var_1.origin - self.origin;
          var_18 = var_9 - var_15;

          if(length2dsquared(var_17) < 0.5625 * length2dsquared(var_18)) {
            var_12 = 0.75;
          }

          if(var_17[2] < 0.75 * var_18[2]) {
            var_13 = 0.75;
          }

          var_19 = var_9 - var_16;
          var_20 = (var_19[0] * var_12, var_19[1] * var_12, var_19[2] * var_13);
          var_21 = rotatevector(var_20, var_5);
          var_22 = var_1.origin - var_21;
          var_23 = var_16 - var_15;
          var_24 = rotatevector(var_23, var_5);
          var_25 = var_22 - self.origin;
          var_10 = maps\mp\agents\_scriptedagents::getanimscalefactors(var_25, var_24, 1);
          self scragentsetanimscale(var_10.xy, var_10.z);
          maps\mp\agents\_scriptedagents::waituntilnotetrack("traverse", "traverse_jump_end");
          self scragentsetanimscale(var_12, var_13);
          maps\mp\agents\_scriptedagents::waituntilnotetrack("traverse", "code_move");
          return;
        }

        self scragentsetanimscale(var_10.xy, var_10.z);
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_6, 0, "traverse");
        return;
        return;
      }

      var_26 = getnotetracktimes(var_7, "gravity on");

      if(var_26.size > 0) {
        var_27 = var_0 gettargetentpos();

        if(isDefined(var_27)) {
          var_28 = var_27 - self.origin;
          var_29 = var_1.origin - var_27;
          var_30 = getmovedelta(var_7, 0, var_26[0]);
          var_10 = maps\mp\agents\_scriptedagents::getanimscalefactors(var_28, var_30);
          self scragentsetanimscale(var_10.xy, var_10.z);
          maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_6, 0, "traverse", "gravity on");
          var_31 = getmovedelta(var_7, var_26[0], 1);
          var_10 = maps\mp\agents\_scriptedagents::getanimscalefactors(var_29, var_31);
          self scragentsetanimscale(var_10.xy, var_10.z);
          maps\mp\agents\_scriptedagents::waituntilnotetrack("traverse", "code_move");
          return;
        }
      }

      var_32 = getanimlength(var_7);
      self scragentdoanimlerp(var_0.origin, var_1.origin, var_32);
      maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_6, 0, "traverse");
      return;
      return;
    }

    var_26 = getnotetracktimes(var_7, "gravity on");

    if(var_26.size > 0) {
      self scragentsetanimscale(var_10.xy, 1);
      maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_6, 0, "traverse", "gravity on");
      var_33 = getmovedelta(var_7, 0, var_26[0]);
      var_34 = var_33[2] - var_9[2];

      if(abs(var_34) > 0) {
        var_35 = self.origin[2] - var_1.origin[2];
        var_13 = var_35 / var_34;
        self scragentsetanimscale(var_10.xy, var_13);
        var_36 = clamp(2 / var_13, 0.5, 1);
        var_37 = var_6 + "_norestart";
        self setanimstate(var_37, 0, var_36);
      }

      maps\mp\agents\_scriptedagents::waituntilnotetrack("traverse", "code_move");
    } else {
      self scragentsetanimscale(var_10.xy, var_10.z);
      var_36 = clamp(2 / var_10.z, 0.5, 1);
      var_14 = getnotetracktimes(var_7, "traverse_jump_end");

      if(var_14.size > 0) {
        maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack(var_6, 0, var_36, "traverse", "traverse_jump_end");
        var_37 = var_6 + "_norestart";
        self setanimstate(var_37, 0, 1);
        maps\mp\agents\_scriptedagents::waituntilnotetrack("traverse", "code_move");
      } else {
        maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_6, 0, "traverse");
      }
    }

    self scragentsetanimscale(1, 1);
  }
}

end_script() {
  self scragentsetanimscale(1, 1);
  self.blockgoalpos = 0;
}

gettargetentpos() {
  if(isDefined(self.targetentpos)) {
    return self.targetentpos;
  }

  var_0 = getent(self.target, "targetname");

  if(!isDefined(var_0)) {
    return undefined;
  }

  self.targetentpos = var_0.origin;
  var_0 delete();
  return self.targetentpos;
}

initdogtraverseanims() {
  level.dogtraverseanims = [];
  level.dogtraverseanims["hjk_tree_hop"] = "traverse_jump_over_24";
  level.dogtraverseanims["jump_across_72"] = "traverse_jump_over_24";
  level.dogtraverseanims["wall_hop"] = "traverse_jump_over_36";
  level.dogtraverseanims["window_2"] = "traverse_jump_over_36";
  level.dogtraverseanims["wall_over_40"] = "traverse_jump_over_36";
  level.dogtraverseanims["wall_over"] = "traverse_jump_over_36";
  level.dogtraverseanims["window_divethrough_36"] = "traverse_jump_over_36";
  level.dogtraverseanims["window_over_40"] = "traverse_jump_over_36";
  level.dogtraverseanims["window_over_quick"] = "traverse_jump_over_36";
  level.dogtraverseanims["jump_up_80"] = "traverse_jump_up_70";
  level.dogtraverseanims["jump_standing_80"] = "traverse_jump_up_70";
  level.dogtraverseanims["jump_down_80"] = "traverse_jump_down_70";
  level.dogtraverseanims["jumpdown_96"] = "traverse_jump_down_70";
  level.dogtraverseanims["jump_up_40"] = "traverse_jump_up_40";
  level.dogtraverseanims["jump_down_40"] = "traverse_jump_down_40";
  level.dogtraverseanims["step_up"] = "traverse_jump_up_24";
  level.dogtraverseanims["step_up_24"] = "traverse_jump_up_24";
  level.dogtraverseanims["step_down"] = "traverse_jump_down_24";
  level.dogtraverseanims["jump_down"] = "traverse_jump_down_24";
  level.dogtraverseanims["jump_across"] = "traverse_jump_over_36";
  level.dogtraverseanims["jump_across_100"] = "traverse_jump_over_36";
}