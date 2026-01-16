/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\coverwall.gsc
*********************************************/

func_4761() {
  precachemodel("barrier_cover_foam_128");
  precachemodel("barrier_cover_foam_128_d1");
  precachemodel("barrier_cover_foam_128_d2");
  precachemodel("barrier_cover_foam_128_d3");
  precachemodel("barrier_cover_foam_128_d4");
  precachemodel("barrier_cover_foam_128_d5");
  level.player.var_4759 = spawnStruct();
  level.player.var_4759.var_19 = [];
  level.player.var_4759.var_11168 = [];
  level.player.var_4759.var_389C = 0;
  level.player.var_4759.var_A8C6 = undefined;
  level.var_7649["coverwall_expand"] = loadfx("vfx\iw7\core\equipment\coverwall\vfx_coverwall_foam_expand.vfx");
  level.var_7649["coverwall_collapse"] = loadfx("vfx\iw7\core\equipment\coverwall\vfx_coverwall_foam_collapse.vfx");
  level.var_7649["coverwall_explosion"] = loadfx("vfx\iw7\_requests\mp\power\vfx_trip_mine_explode.vfx");
  level.var_7649["coverwall_dud"] = loadfx("vfx\code\foam\vfx_code_foamblock_death.vfx");
  precacheitem("coverwall");
  setdvarifuninitialized("portable_cover_lifetime", 35);
  setdvarifuninitialized("debug_coverwall", 0);
  scripts\engine\utility::flag_init("coverwall_force_delete");
}

func_475F(var_0) {
  var_1 = spawnStruct();
  var_1.objective_position = var_0;
  level.player.var_4759.var_11168[level.player.var_4759.var_11168.size] = var_1;
  var_1 func_85AE(var_0);
  if(!isDefined(var_1.objective_position)) {
    var_1 func_DFDF(1);
    return;
  }

  var_1 notify("coverwall_initiated");
  var_2 = var_0.origin;
  var_1 func_DFDF();
  if(isDefined(var_1.var_152B)) {
    level.player.var_4759.var_11168 = scripts\engine\utility::array_remove(level.player.var_4759.var_11168, var_1);
    return;
  }

  if(isDefined(level.var_93A9) && level.player.var_4759.var_19.size > 3) {
    var_3 = level.player.var_4759.var_19.size - 3;
    for(var_4 = 0; var_4 < var_3; var_4++) {
      level.player.var_4759.var_19[var_4] notify("expired");
    }
  }

  var_5 = (0, level.player.angles[1] - 90, 0);
  func_4763(var_2, var_5, undefined, var_1);
}

func_85AE(var_0) {
  thread func_85E8(var_0);
  func_85AD(var_0);
}

func_85E8(var_0) {
  self endon("coverwall_initiated");
  var_0 waittill("entitydeleted");
  self.var_6643 = 1;
}

func_85AD(var_0) {
  var_0 waittill("missile_stuck", var_1);
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  self.soundsettimescalefactor = var_1;
  if(isDefined(self.var_6643)) {
    return;
  }

  if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "script_coverwall") {
    self.var_152B = 1;
    playFX(level.var_7649["coverwall_dud"], var_0.origin);
  }
}

func_DFDF(var_0) {
  if(!scripts\engine\utility::array_contains(level.player.var_4759.var_11168, self)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(isDefined(self.objective_position)) {
    self.origin = self.objective_position.origin;
    self.angles = self.objective_position.angles;
    level.player.var_4759.var_A8C6 = self.objective_position.origin;
    self.objective_position delete();
  }

  if(var_0) {
    level.player.var_4759.var_11168 = scripts\engine\utility::array_remove(level.player.var_4759.var_11168, self);
  }
}

func_DFBD() {
  level notify("removing_all_coverwalls_instantly");
  level endon("removing_all_coverwalls_instantly");
  scripts\engine\utility::flag_set("coverwall_force_delete");
  var_0 = level.player.var_4759.var_11168;
  foreach(var_2 in var_0) {
    var_2 func_DFDF(1);
    if(isDefined(var_2.var_BE07)) {
      var_2.var_BE07 notify("death");
    }
  }

  for(;;) {
    if(level.player.var_4759.var_11168.size > 0) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_clear("coverwall_force_delete");
  level.player notify("stop_coverwall_doubletap");
}

func_4763(var_0, var_1, var_2, var_3) {
  var_3 notify("spawning_coverwall");
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 200);
  var_4 = spawncoverwall(var_0, var_1, var_2);
  if(!isDefined(var_4)) {
    if(isDefined(var_3.origin)) {
      playFX(level.var_7649["coverwall_dud"], var_3.origin);
    }

    level.player.var_4759.var_11168 = scripts\engine\utility::array_remove(level.player.var_4759.var_11168, var_3);
    return;
  }

  playworldsound("deployable_cover_expand", var_0);
  var_4.var_132AA = [];
  var_3.var_BE07 = var_4;
  playworldsound("deployable_cover_expand", var_0);
  if(isDefined(level.var_93A9)) {
    var_5 = spawnfx(level.var_7649["coverwall_expand_vr"], var_0, anglesToForward(var_1), anglestoup(var_1));
    triggerfx(var_5);
    var_4.var_132AA[var_4.var_132AA.size] = var_5;
  } else {
    playFX(level.var_7649["coverwall_expand"], var_0, anglesToForward(var_1), anglestoup(var_1));
  }

  var_4.triggerportableradarping = self;
  var_3 thread func_475E(35);
  var_4 thread func_475A();
  if(1) {
    var_4 thread func_475D();
  }

  if(isDefined(level.player.var_4759) && level.player.var_4759.var_389C) {
    thread func_B9C4();
  }

  if(getdvarint("debug_coverwall")) {
    var_4 thread draw_cool_circle_til_notify();
  }

  thread func_10696(var_4);
  lib_0F18::func_10E8A("broadcast", "attack", var_0, 1000);
  var_4 func_4765();
  level.player.var_4759.var_19[level.player.var_4759.var_19.size] = var_4;
}

func_4765() {
  self endon("coverwall_expand_finish");
  scripts\engine\utility::flag_wait("coverwall_force_delete");
}

func_475A() {
  self endon("death");
  self endon("coverwall_expand_finish");
  for(;;) {
    self waittill("coverwall_expand_hit_actor", var_0);
    if(var_0.team == "axis") {
      if(var_0 func_3870()) {
        var_0 func_81D0();
      }
    }
  }
}

func_3870() {
  var_0["c8"] = 1;
  var_0["c12"] = 1;
  if(isDefined(self.unittype) && isDefined(var_0[self.unittype])) {
    return 0;
  }

  return 1;
}

draw_cool_circle_til_notify() {
  self endon("death");
  for(;;) {
    var_0 = self.origin;
    var_1 = var_0 + anglesToForward(self.angles) * 100;
    scripts\sp\debug::func_5B5D(var_0, var_1, (0, 1, 0), 1, 0);
    wait(0.05);
  }
}

func_10696(var_0) {
  var_0 endon("death");
  var_0 waittill("coverwall_expand_finish");
  var_1 = var_0.origin;
  var_2 = (1, 0, 0);
  var_3 = (0, 1, 0);
  var_4 = 30;
  var_5 = 26;
  var_6 = (0, 90, 0);
  var_7 = "right";
  var_8 = "a";
  var_0.var_473D = [];
  for(var_9 = 1; var_9 < 5; var_9++) {
    var_0A = scripts\engine\utility::ter_op(var_8 == "a", var_5, var_5 * -1);
    var_0B = scripts\engine\utility::ter_op(var_7 == "right", var_4, var_4 * -1);
    var_0C = scripts\engine\utility::ter_op(var_7 == "right", var_0.angles + (0, 90, 0), var_0.angles - (0, 90, 0));
    var_0D = var_3;
    var_0E = "coverwall_" + var_0 getentitynumber() + "_" + var_7 + "_" + var_8;
    var_0A = anglesToForward(var_0.angles) * var_0A;
    var_0F = anglestoright(var_0.angles) * var_0B;
    var_10 = var_1 + var_0A + var_0F;
    if(var_0 func_3913(var_10, var_0C)) {
      var_0.var_473D[var_7 + "_" + var_8] = spawncovernode(var_10, var_0C, "cover stand", 512, var_0E);
    } else {
      var_0D = var_2;
    }

    var_8 = scripts\engine\utility::ter_op(var_8 == "a", "b", "a");
    var_7 = scripts\engine\utility::ter_op(var_9 >= 2, "left", "right");
    if(var_9 == 2) {
      wait(0.05);
    }
  }

  var_0 thread func_B9FB();
}

func_3913(var_0, var_1) {
  var_2 = getclosestpointonnavmesh(var_0);
  var_3 = distance(var_0, var_2);
  if(var_3 > 17) {
    if(getdvarint("debug_coverwall")) {}

    return 0;
  }

  if(getdvarint("debug_coverwall")) {}

  var_4 = scripts\common\trace::capsule_trace(var_0 + (0, 0, 20), var_0, 18, 72, var_1, self, scripts\common\trace::create_solid_ai_contents(1));
  if(isDefined(var_4["fraction"]) && var_4["fraction"] < 0.5) {
    if(getdvarint("debug_coverwall")) {
      scripts\common\trace::draw_trace(var_4, (1, 0, 0), 0, 200);
    }

    return 0;
  }

  var_5 = getgroundposition(var_0, 16) + (0, 0, 50);
  var_6 = var_5 + anglesToForward(var_1) * 100;
  var_4 = scripts\common\trace::ray_trace(var_5, var_6);
  if(isDefined(var_4["fraction"]) && var_4["fraction"] < 1) {
    if(getdvarint("debug_coverwall")) {
      scripts\common\trace::draw_trace(var_4, (1, 0, 0), 1, 200);
    }

    return 0;
  }

  if(getdvarint("debug_coverwall")) {
    scripts\common\trace::draw_trace(var_4, (0, 1, 0), 1, 200);
  }

  return 1;
}

func_B9FB() {
  self endon("death");
  wait(1.5);
  if(isDefined(self.var_473D) && !self.var_473D.size) {
    return;
  }

  self endon("death");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = [];
  if(isDefined(self.var_473D["right_a"])) {
    var_0 = self.var_473D["right_a"];
  } else if(isDefined(self.var_473D["left_a"])) {
    var_0 = self.var_473D["left_a"];
  }

  if(isDefined(self.var_473D["right_b"])) {
    var_1 = self.var_473D["right_b"];
  } else if(isDefined(self.var_473D["left_b"])) {
    var_1 = self.var_473D["left_b"];
  }

  if(isDefined(var_0)) {
    var_2[var_2.size] = var_0;
  }

  if(isDefined(var_1)) {
    var_2[var_2.size] = var_1;
  }

  for(;;) {
    var_2 = scripts\engine\utility::array_removeundefined(var_2);
    if(!var_2.size) {
      return;
    }

    foreach(var_4 in var_2) {
      if(!var_4 func_C049()) {
        func_E16A(var_4);
        func_E0E1(var_4);
        break;
      }
    }

    wait(1.5);
  }
}

func_E16A(var_0) {
  var_1 = undefined;
  var_2 = strtok(var_0.var_336, "_");
  var_3 = var_2[2] + "_" + var_2[3];
  switch (var_3) {
    case "right_a":
      var_1 = self.var_473D["left_a"];
      break;

    case "left_a":
      var_1 = self.var_473D["right_a"];
      break;

    case "left_b":
      var_1 = self.var_473D["right_b"];
      break;

    case "right_b":
      var_1 = self.var_473D["left_b"];
      break;
  }

  if(isDefined(var_1)) {
    var_1.var_9CA1 = 1;
    func_E0E1(var_1);
  }
}

func_E0E1(var_0) {
  foreach(var_4, var_2 in self.var_473D) {
    if(var_0 == self.var_473D[var_4]) {
      if(getdvarint("debug_coverwall")) {
        var_3 = var_0.origin;
      }

      despawncovernode(var_0);
      self.var_473D = scripts\sp\utility::func_22B2(self.var_473D, var_4);
      return;
    }
  }
}

func_C049() {
  var_0 = spawnStruct();
  var_0.start = self.origin + (0, 0, 15);
  var_0.end = var_0.start + anglesToForward(self.angles) * 40;
  var_1 = spawnStruct();
  var_1.start = self.origin + (0, 0, 40);
  var_1.end = var_1.start + anglesToForward(self.angles) * 40;
  var_2 = 0;
  var_3 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_4 = [var_0, var_1];
  foreach(var_6 in var_4) {
    var_7 = scripts\common\trace::ray_trace(var_6.start, var_6.end, self.triggerportableradarping, var_3);
    if(isDefined(var_7["fraction"])) {
      if(var_7["fraction"] == 1) {
        if(getdvarint("debug_coverwall")) {}

        var_2++;
        continue;
      }

      if(getdvarint("debug_coverwall")) {
        scripts\common\trace::draw_trace(var_7, (0, 1, 0), 0, 20);
      }
    }
  }

  return var_2 != 2;
}

func_5B54(var_0, var_1, var_2) {
  self endon("death");
  for(;;) {
    scripts\sp\debug::func_5B54(var_0, var_1, var_2, 32, 1);
    wait(0.05);
  }
}

func_475E(var_0) {
  self.var_BE07 thread scripts\sp\utility::func_C12D("expired", var_0);
  var_1 = self.var_BE07 scripts\engine\utility::waittill_any_return("expired", "death");
  var_2 = var_1 == "death";
  var_3 = self.var_BE07.origin;
  var_4 = self.var_BE07.triggerportableradarping;
  if(scripts\engine\utility::flag("coverwall_force_delete")) {
    scripts\engine\utility::waitframe();
  }

  if(isDefined(self.var_BE07) && isDefined(self.var_BE07.var_473D)) {
    foreach(var_6 in self.var_BE07.var_473D) {
      if(isDefined(var_6)) {
        despawncovernode(var_6);
      }
    }
  }

  if(isDefined(self.var_BE07.var_BE64)) {
    destroynavobstacle(self.var_BE07.var_BE64);
  }

  if(isDefined(self.var_BE07)) {
    self.var_BE07 func_8514(var_2);
  }

  if(isDefined(self.var_BE07.var_132AA)) {
    foreach(var_9 in self.var_BE07.var_132AA) {
      var_9 delete();
    }
  }

  if(!var_2) {
    var_0B = self.var_BE07.angles;
    playFX(level.var_7649["coverwall_collapse"], var_3, anglesToForward(var_0B), anglestoup(var_0B));
    playworldsound("deployable_cover_contract", var_3);
  }

  var_4.var_4759.var_19 = scripts\engine\utility::array_remove(var_4.var_4759.var_19, self.var_BE07);
  scripts\engine\utility::flag_wait_or_timeout("coverwall_force_delete", 1.5);
  if(!var_4.var_4759.var_19.size) {
    if(isDefined(var_4.var_4759.var_5AE6)) {
      var_4 notify("stop_coverwall_doubletap");
      var_4.var_4759.var_5AE6 = undefined;
    }
  }

  level.player.var_4759.var_11168 = scripts\engine\utility::array_remove(level.player.var_4759.var_11168, self);
}

func_475D() {
  self endon("death");
  self endon("entitydeleted");
  self waittill("coverwall_expand_finish");
  self.var_BE64 = func_316(self);
}

func_B9C4() {
  if(isDefined(self.var_4759.var_5AE6)) {
    return;
  }

  self.var_4759.var_5AE6 = 1;
  self endon("stop_coverwall_doubletap");
  var_0 = 0;
  var_1 = 0.3;
  for(;;) {
    if(level.player usebuttonpressed()) {
      var_0 = 0;
      while(level.player usebuttonpressed()) {
        var_0 = var_0 + 0.05;
        wait(0.05);
      }

      if(var_0 >= var_1) {
        continue;
      }

      var_0 = 0;
      while(!level.player usebuttonpressed() && var_0 < var_1) {
        var_0 = var_0 + 0.05;
        wait(0.05);
      }

      if(var_0 >= var_1) {
        continue;
      }

      thread scripts\sp\utility::play_sound_on_entity("deployable_cover_det_trig");
      wait(0.3);
      func_2BCE();
      self.var_4759.var_5AE6 = undefined;
      self notify("stop_coverwall_doubletap");
      return;
    }

    wait(0.05);
  }
}

func_2BCE() {
  foreach(var_1 in self.var_4759.var_19) {
    func_475C(var_1);
    scripts\engine\utility::flag_wait_or_timeout("coverwall_force_delete", 0.2);
  }
}

func_475C(var_0, var_1) {
  var_2 = var_0.origin;
  var_3 = var_2 + (0, 0, 32);
  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    playFX(level.var_7649["coverwall_explosion_vr"], var_2);
  } else {
    playFX(level.var_7649["coverwall_explosion"], var_2);
  }

  playworldsound("deployable_cover_explode", var_2);
  earthquake(0.4, 0.6, var_0.triggerportableradarping.origin, 450);
  level.player playrumbleonentity("damage_heavy");
  var_0 notify("death");
  scripts\engine\utility::flag_wait_or_timeout("coverwall_force_delete", 0.1);
  if(!isDefined(var_1)) {
    radiusdamage(var_3, 150, 250, 120, var_0.triggerportableradarping, "MOD_EXPLOSIVE", "coverwall");
  }
}

func_596D() {
  if(isDefined(self.var_596D)) {
    return;
  }

  self.var_596D = 1;
  self endon("death");
  self endon("stop_for_coverwalls");
  for(;;) {
    var_0 = getEntArray("script_coverwall", "classname");
    foreach(var_2 in var_0) {
      if(isDefined(var_2.var_BE64)) {
        destroynavobstacle(var_2.var_BE64);
      }

      var_3 = distancesquared(self.origin, var_2.origin);
      if(var_3 < squared(200)) {
        var_2 notify("expired");
      }
    }

    wait(0.75);
  }
}

func_551C() {
  self notify("stop_for_coverwalls");
  self.var_596D = undefined;
}