/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\humanoid\_humanoid_traverse.gsc
**********************************************************/

main() {
  if(!isDefined(level.zombietraverseanims) || !isDefined(level.zombietraverseanims["humanoid"])) {
    inithumanoidtraverseanims();
  }

  dotraverse();
}

dotraverse() {
  self endon("killanimscript");
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "DoTraverse");
  var_0 = self getnegotiationstartnode();
  var_1 = self getnegotiationendnode();
  self.traversalvector = vectornormalize(var_1.origin - var_0.origin);

  if(var_0.animscript == "bot_walk_forward") {
    var_2 = var_1.origin - var_0.origin;
    var_3 = length(var_2) / 64;
    var_4 = (var_2[0], var_2[1], 0);
    var_5 = vectortoangles(var_4);
    self scragentsetorientmode("face angle abs", var_5);
    self scragentdoanimlerp(var_0.origin, var_1.origin, var_3);
    self scragentsetphysicsmode("noclip");
    maps\mp\agents\_scripted_agent_anim_util::playanimnatratefortime(self.movemode, randomint(self getanimentrycount(self.movemode)), self.moveratescale, var_3);
  } else {
    var_6 = undefined;
    var_6 = level.zombietraverseanims[self.species][var_0.animscript];

    if(!isDefined(var_6)) {
      return;
    }
    var_7 = -1;

    if(isDefined(level.zombietraverseanimchance[self.species][var_6])) {
      var_8 = randomfloat(1.0);

      for(var_9 = 0; var_9 < level.zombietraverseanimchance[self.species][var_6].size; var_9++) {
        var_10 = level.zombietraverseanimchance[self.species][var_6][var_9];

        if(var_8 < var_10) {
          var_7 = var_9;
          break;
        } else {
          var_8 = var_8 - var_10;
        }
      }
    } else {
      var_7 = randomint(self getanimentrycount(var_6));
    }

    var_2 = var_1.origin - var_0.origin;
    var_4 = (var_2[0], var_2[1], 0);
    var_5 = vectortoangles(var_4);
    var_11 = issubstr(var_0.animscript, "jump_across");
    var_12 = (var_6 == "traverse_boost" || issubstr(var_0.animscript, "boost_jump_across")) && self.species == "humanoid";

    if(var_12) {
      maps\mp\agents\humanoid\_humanoid_util::play_boost_fx(level._effect["boost_jump"]);
    }

    self scragentsetorientmode("face angle abs", var_5);
    self scragentsetanimmode("anim deltas");

    if(maps\mp\zombies\_util::getzombieslevelnum() >= 4) {
      self setvelocity((0, 0, 0));
    }

    var_13 = self getanimentry(var_6, var_7);
    var_14 = getnotetracktimes(var_13, "code_move");

    if(var_14.size > 0) {
      var_15 = getmovedelta(var_13, 0, var_14[0]);
    } else {
      var_15 = getmovedelta(var_13, 0, 1);
    }

    var_16 = maps\mp\agents\_scripted_agent_anim_util::getanimscalefactors(var_2, var_15);
    var_17 = animhasnotetrack(var_13, "ignoreanimscaling");

    if(var_17) {
      var_16.xy = 1.0;
    }

    self scragentsetphysicsmode("noclip");

    if(maps\mp\zombies\_util::getzombieslevelnum() >= 3 && var_11 && abs(var_2[2]) < 48) {
      var_18 = getnotetracktimes(var_13, "traverse_jump_start");
      var_19 = getnotetracktimes(var_13, "traverse_jump_end");
      var_20 = getanimlength(var_13);
      var_21 = var_18[0] * var_20;
      var_22 = var_19[0] * var_20;
      self scragentsetanimscale(var_16.xy, 1);
      maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, self.traverseratescale, "traverse", "traverse_jump_start");
      self scragentsetanimscale(var_16.xy, 0);
      childthread traverse_lerp_z_over_time(var_0.origin[2], var_1.origin[2], (var_22 - var_21) / self.traverseratescale);
      maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6 + "_norestart", var_7, self.traverseratescale, "traverse", "traverse_jump_end");
      self scragentsetanimscale(var_16.xy, 1);
      maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6 + "_norestart", var_7, self.traverseratescale, "traverse");
    } else if(var_2[2] > 16) {
      if(var_15[2] > 0) {
        if(var_12) {
          self scragentsetanimscale(var_16.xy, var_16.z);
          var_23 = clamp(2 / var_16.z, 0.5, 1);

          if(animhasnotetrack(var_13, "traverse_jump_end")) {
            maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, var_23 * self.traverseratescale, "traverse", "traverse_jump_end");
            maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoTraverse");
            var_24 = var_6 + "_norestart";
            maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_24, var_7, self.traverseratescale);
            maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("traverse", "code_move");
          } else if(maps\mp\zombies\_util::getzombieslevelnum() >= 4) {
            maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, self.traverseratescale, "traverse", "code_move");
          } else {
            maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, self.traverseratescale, "traverse");
          }

          self scragentsetanimscale(1, 1);
        } else {
          var_18 = getnotetracktimes(var_13, "traverse_jump_start");

          if(var_18.size > 0) {
            var_16.xy = 1;
            var_16.z = 1;

            if(!var_17 && length2dsquared(var_4) < 0.64 * length2dsquared(var_15)) {
              var_16.xy = 0.4;
            }

            self scragentsetanimscale(var_16.xy, var_16.z);
            maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, self.traverseratescale, "traverse", "traverse_jump_start");
            var_19 = getnotetracktimes(var_13, "traverse_jump_end");
            var_25 = getmovedelta(var_13, 0, var_18[0]);
            var_26 = getmovedelta(var_13, 0, var_19[0]);
            var_16.xy = 1;
            var_16.z = 1;
            var_27 = var_1.origin - self.origin;
            var_28 = var_15 - var_25;

            if(!var_17 && length2dsquared(var_27) < 0.5625 * length2dsquared(var_28)) {
              var_16.xy = 0.75;
            }

            var_29 = var_15 - var_26;
            var_30 = (var_29[0] * var_16.xy, var_29[1] * var_16.xy, var_29[2] * var_16.z);
            var_31 = rotatevector(var_30, var_5);
            var_32 = var_1.origin - var_31;
            var_33 = var_26 - var_25;
            var_34 = rotatevector(var_33, var_5);
            var_35 = var_32 - self.origin;
            var_36 = var_16;
            var_16 = maps\mp\agents\_scripted_agent_anim_util::getanimscalefactors(var_35, var_34, 1);

            if(var_17) {
              var_16.xy = 1.0;
            }

            if(var_35[2] <= 0) {
              var_16.z = 0.0;
            }

            self scragentsetanimscale(var_16.xy, var_16.z);
            maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("traverse", "traverse_jump_end");
            maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoTraverse");
            var_16 = var_36;
            self scragentsetanimscale(var_16.xy, var_16.z);
            maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("traverse", "code_move");
          } else {
            self scragentsetanimscale(var_16.xy, var_16.z);

            if(maps\mp\zombies\_util::getzombieslevelnum() >= 4) {
              maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, self.traverseratescale, "traverse", "code_move");
            } else {
              maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, self.traverseratescale, "traverse");
            }
          }
        }
      } else {}
    } else if(abs(var_2[2]) < 16 || var_15[2] == 0) {
      self scragentsetanimscale(var_16.xy, var_16.z);
      var_23 = clamp(2 / var_16.z, 0.5, 1);

      if(animhasnotetrack(var_13, "traverse_jump_end")) {
        maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, var_23 * self.traverseratescale, "traverse", "traverse_jump_end");
        maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoTraverse");
        var_24 = var_6 + "_norestart";
        maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_24, var_7, self.traverseratescale);
        maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("traverse", "code_move");
      } else if(maps\mp\zombies\_util::getzombieslevelnum() >= 4) {
        maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, self.traverseratescale, "traverse", "code_move");
      } else {
        maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, self.traverseratescale, "traverse");
      }

      self scragentsetanimscale(1, 1);
    } else if(var_15[2] < 0) {
      self scragentsetanimscale(var_16.xy, var_16.z);
      var_23 = clamp(2 / var_16.z, 0.5, 1);
      var_38 = var_6 + "_norestart";

      if(animhasnotetrack(var_13, "traverse_jump_start")) {
        maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, self.traverseratescale, "traverse", "traverse_jump_start");
        var_6 = var_38;
      }

      if(animhasnotetrack(var_13, "traverse_jump_end")) {
        maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, var_23 * 1.0, "traverse", "traverse_jump_end");
        maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_38, var_7, self.traverseratescale);

        if(animhasnotetrack(var_13, "removestatelock")) {
          maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("traverse", "removestatelock");
        }

        maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoTraverse");
        maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("traverse", "code_move");
      } else if(maps\mp\zombies\_util::getzombieslevelnum() >= 4) {
        maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, self.traverseratescale, "traverse", "code_move");
      } else {
        maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_6, var_7, 1.0, "traverse");
      }

      self scragentsetanimscale(1, 1);
    }
  }
}

traverse_lerp_z_over_time(var_0, var_1, var_2) {
  var_3 = gettime();

  for(;;) {
    var_4 = (gettime() - var_3) / 1000.0;
    var_5 = var_4 / var_2;

    if(var_5 > 1.0) {
      break;
    }

    var_6 = maps\mp\zombies\_util::lerp(var_5, var_0, var_1);
    self setorigin((self.origin[0], self.origin[1], var_6), 0);
    wait 0.05;
  }
}

end_script() {
  self scragentsetanimscale(1, 1);
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "Traverse end_script");
  self.hastraversed = 1;
  self.traversalvector = undefined;
}

inithumanoidtraverseanims() {
  if(!isDefined(level.zombietraverseanims)) {
    level.zombietraverseanims = [];
  }

  if(!isDefined(level.zombietraverseanims["humanoid"])) {
    level.zombietraverseanims["humanoid"] = [];
  }

  level.zombietraverseanims["humanoid"]["jump_across_100"] = "traverse_jump_across_100";
  level.zombietraverseanims["humanoid"]["jump_across_196"] = "traverse_jump_across_196";
  level.zombietraverseanims["humanoid"]["boost_jump_across_100"] = level.zombietraverseanims["humanoid"]["jump_across_100"];
  level.zombietraverseanims["humanoid"]["boost_jump_across_196"] = level.zombietraverseanims["humanoid"]["jump_across_196"];
  level.zombietraverseanims["humanoid"]["jump_down_40"] = "traverse_jump_down_40";
  level.zombietraverseanims["humanoid"]["jump_down_slow"] = "traverse_jump_down_slow";
  level.zombietraverseanims["humanoid"]["jump_down_fast"] = "traverse_jump_down_fast";
  level.zombietraverseanims["humanoid"]["step_over_40"] = "traverse_step_over_40";
  level.zombietraverseanims["humanoid"]["window_over_36"] = "traverse_window_over_36";
  level.zombietraverseanims["humanoid"]["step_up_40"] = "traverse_step_up_40";
  level.zombietraverseanims["humanoid"]["wall_over_40"] = "traverse_mantle_over_40";
  level.zombietraverseanims["humanoid"]["nonboost_jump_up_120"] = "traverse_jump_up_120";
  level.zombietraverseanims["humanoid"]["boost_jump_up"] = "traverse_boost";
  level.zombietraverseanims["humanoid"]["climbup_shaft"] = "traverse_climbup_shaft";
  level.zombietraverseanims["humanoid"]["spawn_closet_door"] = "traverse_spawn_closet_door";
  level.zombietraverseanims["humanoid"]["spawn_closet_vault"] = "traverse_spawn_closet_vault";
  level.zombietraverseanims["humanoid"]["spawn_closet_window"] = "traverse_spawn_closet_window";
  level.zombietraverseanims["humanoid"]["spawn_closet_high_window"] = "traverse_spawn_closet_high_window";

  if(!isDefined(level.zombietraverseanimchance)) {
    level.zombietraverseanimchance = [];
  }

  if(!isDefined(level.zombietraverseanimchance["humanoid"])) {
    level.zombietraverseanimchance["humanoid"] = [];
  }

  foreach(var_1 in level.zombietraverseanimchance["humanoid"]) {
    var_2 = 0.0;

    foreach(var_4 in var_1) {
      var_2 = var_2 + var_4;
    }
  }
}