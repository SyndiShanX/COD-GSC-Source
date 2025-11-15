/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\coverwall.gsc
************************************/

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

func_475F(param_00) {
  var_01 = spawnStruct();
  var_01.objective_position = param_00;
  level.player.var_4759.var_11168[level.player.var_4759.var_11168.size] = var_01;
  var_01 _meth_85AE(param_00);
  if(!isDefined(var_01.objective_position)) {
    var_01 func_DFDF(1);
    return;
  }

  var_01 notify("coverwall_initiated");
  var_02 = param_00.origin;
  var_01 func_DFDF();
  if(isDefined(var_01.var_152B)) {
    level.player.var_4759.var_11168 = scripts\engine\utility::array_remove(level.player.var_4759.var_11168, var_01);
    return;
  }

  if(isDefined(level.var_93A9) && level.player.var_4759.var_19.size > 3) {
    var_03 = level.player.var_4759.var_19.size - 3;
    for(var_04 = 0; var_04 < var_03; var_04++) {
      level.player.var_4759.var_19[var_04] notify("expired");
    }
  }

  var_05 = (0, level.player.angles[1] - 90, 0);
  func_4763(var_02, var_05, undefined, var_01);
}

_meth_85AE(param_00) {
  thread func_85E8(param_00);
  _meth_85AD(param_00);
}

func_85E8(param_00) {
  self endon("coverwall_initiated");
  param_00 waittill("entitydeleted");
  self.var_6643 = 1;
}

_meth_85AD(param_00) {
  param_00 waittill("missile_stuck", var_01);
  self.origin = param_00.origin;
  self.angles = param_00.angles;
  self.soundsettimescalefactor = var_01;
  if(isDefined(self.var_6643)) {
    return;
  }

  if(isDefined(var_01) && isDefined(var_01.classname) && var_01.classname == "script_coverwall") {
    self.var_152B = 1;
    playFX(level.var_7649["coverwall_dud"], param_00.origin);
  }
}

func_DFDF(param_00) {
  if(!scripts\engine\utility::array_contains(level.player.var_4759.var_11168, self)) {
    return;
  }

  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(isDefined(self.objective_position)) {
    self.origin = self.objective_position.origin;
    self.angles = self.objective_position.angles;
    level.player.var_4759.var_A8C6 = self.objective_position.origin;
    self.objective_position delete();
  }

  if(param_00) {
    level.player.var_4759.var_11168 = scripts\engine\utility::array_remove(level.player.var_4759.var_11168, self);
  }
}

func_DFBD() {
  level notify("removing_all_coverwalls_instantly");
  level endon("removing_all_coverwalls_instantly");
  scripts\engine\utility::flag_set("coverwall_force_delete");
  var_00 = level.player.var_4759.var_11168;
  foreach(var_02 in var_00) {
    var_02 func_DFDF(1);
    if(isDefined(var_02.var_BE07)) {
      var_02.var_BE07 notify("death");
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

func_4763(param_00, param_01, param_02, param_03) {
  param_03 notify("spawning_coverwall");
  param_02 = scripts\engine\utility::ter_op(isDefined(param_02), param_02, 200);
  var_04 = spawncoverwall(param_00, param_01, param_02);
  if(!isDefined(var_04)) {
    if(isDefined(param_03.origin)) {
      playFX(level.var_7649["coverwall_dud"], param_03.origin);
    }

    level.player.var_4759.var_11168 = scripts\engine\utility::array_remove(level.player.var_4759.var_11168, param_03);
    return;
  }

  playworldsound("deployable_cover_expand", param_00);
  var_04.var_132AA = [];
  param_03.var_BE07 = var_04;
  playworldsound("deployable_cover_expand", param_00);
  if(isDefined(level.var_93A9)) {
    var_05 = spawnfx(level.var_7649["coverwall_expand_vr"], param_00, anglesToForward(param_01), anglestoup(param_01));
    triggerfx(var_05);
    var_04.var_132AA[var_04.var_132AA.size] = var_05;
  } else {
    playFX(level.var_7649["coverwall_expand"], param_00, anglesToForward(param_01), anglestoup(param_01));
  }

  var_04.triggerportableradarping = self;
  param_03 thread func_475E(35);
  var_04 thread func_475A();
  if(1) {
    var_04 thread func_475D();
  }

  if(isDefined(level.player.var_4759) && level.player.var_4759.var_389C) {
    thread func_B9C4();
  }

  if(getdvarint("debug_coverwall")) {
    var_04 thread draw_cool_circle_til_notify();
  }

  thread func_10696(var_04);
  lib_0F18::func_10E8A("broadcast", "attack", param_00, 1000);
  var_04 func_4765();
  level.player.var_4759.var_19[level.player.var_4759.var_19.size] = var_04;
}

func_4765() {
  self endon("coverwall_expand_finish");
  scripts\engine\utility::flag_wait("coverwall_force_delete");
}

func_475A() {
  self endon("death");
  self endon("coverwall_expand_finish");
  for(;;) {
    self waittill("coverwall_expand_hit_actor", var_00);
    if(var_00.team == "axis") {
      if(var_00 func_3870()) {
        var_00 _meth_81D0();
      }
    }
  }
}

func_3870() {
  var_00["c8"] = 1;
  var_00["c12"] = 1;
  if(isDefined(self.unittype) && isDefined(var_00[self.unittype])) {
    return 0;
  }

  return 1;
}

draw_cool_circle_til_notify() {
  self endon("death");
  for(;;) {
    var_00 = self.origin;
    var_01 = var_00 + anglesToForward(self.angles) * 100;
    scripts\sp\debug::func_5B5D(var_00, var_01, (0, 1, 0), 1, 0);
    wait(0.05);
  }
}

func_10696(param_00) {
  param_00 endon("death");
  param_00 waittill("coverwall_expand_finish");
  var_01 = param_00.origin;
  var_02 = (1, 0, 0);
  var_03 = (0, 1, 0);
  var_04 = 30;
  var_05 = 26;
  var_06 = (0, 90, 0);
  var_07 = "right";
  var_08 = "a";
  param_00.var_473D = [];
  for(var_09 = 1; var_09 < 5; var_09++) {
    var_0A = scripts\engine\utility::ter_op(var_08 == "a", var_05, var_05 * -1);
    var_0B = scripts\engine\utility::ter_op(var_07 == "right", var_04, var_04 * -1);
    var_0C = scripts\engine\utility::ter_op(var_07 == "right", param_00.angles + (0, 90, 0), param_00.angles - (0, 90, 0));
    var_0D = var_03;
    var_0E = "coverwall_" + param_00 getentitynumber() + "_" + var_07 + "_" + var_08;
    var_0A = anglesToForward(param_00.angles) * var_0A;
    var_0F = anglestoright(param_00.angles) * var_0B;
    var_10 = var_01 + var_0A + var_0F;
    if(param_00 func_3913(var_10, var_0C)) {
      param_00.var_473D[var_07 + "_" + var_08] = spawncovernode(var_10, var_0C, "cover stand", 512, var_0E);
    } else {
      var_0D = var_02;
    }

    var_08 = scripts\engine\utility::ter_op(var_08 == "a", "b", "a");
    var_07 = scripts\engine\utility::ter_op(var_09 >= 2, "left", "right");
    if(var_09 == 2) {
      wait(0.05);
    }
  }

  param_00 thread func_B9FB();
}

func_3913(param_00, param_01) {
  var_02 = getclosestpointonnavmesh(param_00);
  var_03 = distance(param_00, var_02);
  if(var_03 > 17) {
    if(getdvarint("debug_coverwall")) {}

    return 0;
  }

  if(getdvarint("debug_coverwall")) {}

  var_04 = scripts\common\trace::capsule_trace(param_00 + (0, 0, 20), param_00, 18, 72, param_01, self, scripts\common\trace::create_solid_ai_contents(1));
  if(isDefined(var_04["fraction"]) && var_04["fraction"] < 0.5) {
    if(getdvarint("debug_coverwall")) {
      scripts\common\trace::draw_trace(var_04, (1, 0, 0), 0, 200);
    }

    return 0;
  }

  var_05 = getgroundposition(param_00, 16) + (0, 0, 50);
  var_06 = var_05 + anglesToForward(param_01) * 100;
  var_04 = scripts\common\trace::ray_trace(var_05, var_06);
  if(isDefined(var_04["fraction"]) && var_04["fraction"] < 1) {
    if(getdvarint("debug_coverwall")) {
      scripts\common\trace::draw_trace(var_04, (1, 0, 0), 1, 200);
    }

    return 0;
  }

  if(getdvarint("debug_coverwall")) {
    scripts\common\trace::draw_trace(var_04, (0, 1, 0), 1, 200);
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
  var_00 = undefined;
  var_01 = undefined;
  var_02 = [];
  if(isDefined(self.var_473D["right_a"])) {
    var_00 = self.var_473D["right_a"];
  } else if(isDefined(self.var_473D["left_a"])) {
    var_00 = self.var_473D["left_a"];
  }

  if(isDefined(self.var_473D["right_b"])) {
    var_01 = self.var_473D["right_b"];
  } else if(isDefined(self.var_473D["left_b"])) {
    var_01 = self.var_473D["left_b"];
  }

  if(isDefined(var_00)) {
    var_02[var_02.size] = var_00;
  }

  if(isDefined(var_01)) {
    var_02[var_02.size] = var_01;
  }

  for(;;) {
    var_02 = scripts\engine\utility::array_removeundefined(var_02);
    if(!var_02.size) {
      return;
    }

    foreach(var_04 in var_02) {
      if(!var_04 func_C049()) {
        func_E16A(var_04);
        func_E0E1(var_04);
        break;
      }
    }

    wait(1.5);
  }
}

func_E16A(param_00) {
  var_01 = undefined;
  var_02 = strtok(param_00.var_336, "_");
  var_03 = var_02[2] + "_" + var_02[3];
  switch (var_03) {
    case "right_a":
      var_01 = self.var_473D["left_a"];
      break;

    case "left_a":
      var_01 = self.var_473D["right_a"];
      break;

    case "left_b":
      var_01 = self.var_473D["right_b"];
      break;

    case "right_b":
      var_01 = self.var_473D["left_b"];
      break;
  }

  if(isDefined(var_01)) {
    var_01.var_9CA1 = 1;
    func_E0E1(var_01);
  }
}

func_E0E1(param_00) {
  foreach(var_04, var_02 in self.var_473D) {
    if(param_00 == self.var_473D[var_04]) {
      if(getdvarint("debug_coverwall")) {
        var_03 = param_00.origin;
      }

      despawncovernode(param_00);
      self.var_473D = scripts\sp\utility::func_22B2(self.var_473D, var_04);
      return;
    }
  }
}

func_C049() {
  var_00 = spawnStruct();
  var_00.start = self.origin + (0, 0, 15);
  var_00.end = var_00.start + anglesToForward(self.angles) * 40;
  var_01 = spawnStruct();
  var_01.start = self.origin + (0, 0, 40);
  var_01.end = var_01.start + anglesToForward(self.angles) * 40;
  var_02 = 0;
  var_03 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_04 = [var_00, var_01];
  foreach(var_06 in var_04) {
    var_07 = scripts\common\trace::ray_trace(var_06.start, var_06.end, self.triggerportableradarping, var_03);
    if(isDefined(var_07["fraction"])) {
      if(var_07["fraction"] == 1) {
        if(getdvarint("debug_coverwall")) {}

        var_02++;
        continue;
      }

      if(getdvarint("debug_coverwall")) {
        scripts\common\trace::draw_trace(var_07, (0, 1, 0), 0, 20);
      }
    }
  }

  return var_02 != 2;
}

func_5B54(param_00, param_01, param_02) {
  self endon("death");
  for(;;) {
    scripts\sp\debug::func_5B54(param_00, param_01, param_02, 32, 1);
    wait(0.05);
  }
}

func_475E(param_00) {
  self.var_BE07 thread scripts\sp\utility::func_C12D("expired", param_00);
  var_01 = self.var_BE07 scripts\engine\utility::waittill_any_return("expired", "death");
  var_02 = var_01 == "death";
  var_03 = self.var_BE07.origin;
  var_04 = self.var_BE07.triggerportableradarping;
  if(scripts\engine\utility::flag("coverwall_force_delete")) {
    scripts\engine\utility::waitframe();
  }

  if(isDefined(self.var_BE07) && isDefined(self.var_BE07.var_473D)) {
    foreach(var_06 in self.var_BE07.var_473D) {
      if(isDefined(var_06)) {
        despawncovernode(var_06);
      }
    }
  }

  if(isDefined(self.var_BE07.var_BE64)) {
    destroynavobstacle(self.var_BE07.var_BE64);
  }

  if(isDefined(self.var_BE07)) {
    self.var_BE07 _meth_8514(var_02);
  }

  if(isDefined(self.var_BE07.var_132AA)) {
    foreach(var_09 in self.var_BE07.var_132AA) {
      var_09 delete();
    }
  }

  if(!var_02) {
    var_0B = self.var_BE07.angles;
    playFX(level.var_7649["coverwall_collapse"], var_03, anglesToForward(var_0B), anglestoup(var_0B));
    playworldsound("deployable_cover_contract", var_03);
  }

  var_04.var_4759.var_19 = scripts\engine\utility::array_remove(var_04.var_4759.var_19, self.var_BE07);
  scripts\engine\utility::flag_wait_or_timeout("coverwall_force_delete", 1.5);
  if(!var_04.var_4759.var_19.size) {
    if(isDefined(var_04.var_4759.var_5AE6)) {
      var_04 notify("stop_coverwall_doubletap");
      var_04.var_4759.var_5AE6 = undefined;
    }
  }

  level.player.var_4759.var_11168 = scripts\engine\utility::array_remove(level.player.var_4759.var_11168, self);
}

func_475D() {
  self endon("death");
  self endon("entitydeleted");
  self waittill("coverwall_expand_finish");
  self.var_BE64 = _func_316(self);
}

func_B9C4() {
  if(isDefined(self.var_4759.var_5AE6)) {
    return;
  }

  self.var_4759.var_5AE6 = 1;
  self endon("stop_coverwall_doubletap");
  var_00 = 0;
  var_01 = 0.3;
  for(;;) {
    if(level.player usebuttonpressed()) {
      var_00 = 0;
      while(level.player usebuttonpressed()) {
        var_00 = var_00 + 0.05;
        wait(0.05);
      }

      if(var_00 >= var_01) {
        continue;
      }

      var_00 = 0;
      while(!level.player usebuttonpressed() && var_00 < var_01) {
        var_00 = var_00 + 0.05;
        wait(0.05);
      }

      if(var_00 >= var_01) {
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
  foreach(var_01 in self.var_4759.var_19) {
    func_475C(var_01);
    scripts\engine\utility::flag_wait_or_timeout("coverwall_force_delete", 0.2);
  }
}

func_475C(param_00, param_01) {
  var_02 = param_00.origin;
  var_03 = var_02 + (0, 0, 32);
  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    playFX(level.var_7649["coverwall_explosion_vr"], var_02);
  } else {
    playFX(level.var_7649["coverwall_explosion"], var_02);
  }

  playworldsound("deployable_cover_explode", var_02);
  earthquake(0.4, 0.6, param_00.triggerportableradarping.origin, 450);
  level.player playrumbleonentity("damage_heavy");
  param_00 notify("death");
  scripts\engine\utility::flag_wait_or_timeout("coverwall_force_delete", 0.1);
  if(!isDefined(param_01)) {
    radiusdamage(var_03, 150, 250, 120, param_00.triggerportableradarping, "MOD_EXPLOSIVE", "coverwall");
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
    var_00 = getEntArray("script_coverwall", "classname");
    foreach(var_02 in var_00) {
      if(isDefined(var_02.var_BE64)) {
        destroynavobstacle(var_02.var_BE64);
      }

      var_03 = distancesquared(self.origin, var_02.origin);
      if(var_03 < squared(200)) {
        var_02 notify("expired");
      }
    }

    wait(0.75);
  }
}

func_551C() {
  self notify("stop_for_coverwalls");
  self.var_596D = undefined;
}