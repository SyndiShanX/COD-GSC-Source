/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2838.gsc
***************************************/

func_4761() {
  precachemodel("barrier_cover_foam_128");
  precachemodel("barrier_cover_foam_128_d1");
  precachemodel("barrier_cover_foam_128_d2");
  precachemodel("barrier_cover_foam_128_d3");
  precachemodel("barrier_cover_foam_128_d4");
  precachemodel("barrier_cover_foam_128_d5");
  level.player.func_4759 = spawnStruct();
  level.player.func_4759.active = [];
  level.player.func_4759.func_11168 = [];
  level.player.func_4759.func_389C = 0;
  level.player.func_4759.func_A8C6 = undefined;
  level.func_7649["coverwall_expand"] = loadfx("vfx\iw7\core\equipment\coverwall\vfx_coverwall_foam_expand.vfx");
  level.func_7649["coverwall_collapse"] = loadfx("vfx\iw7\core\equipment\coverwall\vfx_coverwall_foam_collapse.vfx");
  level.func_7649["coverwall_explosion"] = loadfx("vfx\iw7\_requests\mp\power\vfx_trip_mine_explode.vfx");
  level.func_7649["coverwall_dud"] = loadfx("vfx\code\foam\vfx_code_foamblock_death.vfx");
  precacheitem("coverwall");
  setdvarifuninitialized("portable_cover_lifetime", 35);
  setdvarifuninitialized("debug_coverwall", 0);
  scripts\engine\utility::flag_init("coverwall_force_delete");
}

func_475F(var_00) {
  var_01 = spawnStruct();
  var_1.grenade = var_00;
  level.player.func_4759.func_11168[level.player.func_4759.func_11168.size] = var_01;
  var_01 _meth_85AE(var_00);

  if(!isDefined(var_1.grenade)) {
    var_01 func_DFDF(1);
    return;
  }

  var_01 notify("coverwall_initiated");
  var_02 = var_0.origin;
  var_01 func_DFDF();

  if(isDefined(var_1.func_152B)) {
    level.player.func_4759.func_11168 = scripts\engine\utility::array_remove(level.player.func_4759.func_11168, var_01);
    return;
  }

  if(isDefined(level.func_93A9) && level.player.func_4759.active.size > 3) {
    var_03 = level.player.func_4759.active.size - 3;

    for(var_04 = 0; var_04 < var_03; var_4++)
      level.player.func_4759.active[var_04] notify("expired");
  }

  var_05 = (0, level.player.angles[1] - 90, 0);
  func_4763(var_02, var_05, undefined, var_01);
}

_meth_85AE(var_00) {
  thread func_85E8(var_00);
  _meth_85AD(var_00);
}

func_85E8(var_00) {
  self endon("coverwall_initiated");
  var_00 waittill("entitydeleted");
  self.func_6643 = 1;
}

_meth_85AD(var_00) {
  var_00 waittill("missile_stuck", var_01);
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  self.func_01DE = var_01;

  if(isDefined(self.func_6643)) {
    return;
  }
  if(isDefined(var_01) && isDefined(var_1.classname) && var_1.classname == "script_coverwall") {
    self.func_152B = 1;
    playFX(level.func_7649["coverwall_dud"], var_0.origin);
  }
}

func_DFDF(var_00) {
  if(!scripts\engine\utility::array_contains(level.player.func_4759.func_11168, self)) {
    return;
  }
  if(!isDefined(var_00))
    var_00 = 0;

  if(isDefined(self.grenade)) {
    self.origin = self.grenade.origin;
    self.angles = self.grenade.angles;
    level.player.func_4759.func_A8C6 = self.grenade.origin;
    self.grenade delete();
  }

  if(var_00)
    level.player.func_4759.func_11168 = scripts\engine\utility::array_remove(level.player.func_4759.func_11168, self);
}

func_DFBD() {
  level notify("removing_all_coverwalls_instantly");
  level endon("removing_all_coverwalls_instantly");
  scripts\engine\utility::flag_set("coverwall_force_delete");
  var_00 = level.player.func_4759.func_11168;

  foreach(var_02 in var_00) {
    var_02 func_DFDF(1);

    if(isDefined(var_2.func_BE07))
      var_2.func_BE07 notify("death");
  }

  for(;;) {
    if(level.player.func_4759.func_11168.size > 0) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_clear("coverwall_force_delete");
  level.player notify("stop_coverwall_doubletap");
}

func_4763(var_00, var_01, var_02, var_03) {
  var_03 notify("spawning_coverwall");
  var_02 = scripts\engine\utility::ter_op(isDefined(var_02), var_02, 200);
  var_04 = _spawncoverwall(var_00, var_01, var_02);

  if(!isDefined(var_04)) {
    if(isDefined(var_3.origin))
      playFX(level.func_7649["coverwall_dud"], var_3.origin);

    level.player.func_4759.func_11168 = scripts\engine\utility::array_remove(level.player.func_4759.func_11168, var_03);
    return;
  }

  _playworldsound("deployable_cover_expand", var_00);
  var_4.func_132AA = [];
  var_3.func_BE07 = var_04;
  _playworldsound("deployable_cover_expand", var_00);

  if(isDefined(level.func_93A9)) {
    var_05 = spawnfx(level.func_7649["coverwall_expand_vr"], var_00, anglesToForward(var_01), anglestoup(var_01));
    triggerfx(var_05);
    var_4.func_132AA[var_4.func_132AA.size] = var_05;
  } else
    playFX(level.func_7649["coverwall_expand"], var_00, anglesToForward(var_01), anglestoup(var_01));

  var_4.owner = self;
  var_03 thread func_475E(35);
  var_04 thread func_475A();

  if(1)
    var_04 thread func_475D();

  if(isDefined(level.player.func_4759) && level.player.func_4759.func_389C)
    thread func_B9C4();

  if(getdvarint("debug_coverwall"))
    var_04 thread draw_cool_circle_til_notify();

  thread func_10696(var_04);
  func_0F18::func_10E8A("broadcast", "attack", var_00, 1000);
  var_04 func_4765();
  level.player.func_4759.active[level.player.func_4759.active.size] = var_04;
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

    if(var_0.team == "axis") {
      if(var_00 func_3870())
        var_00 _meth_81D0();
    }
  }
}

func_3870() {
  var_0["c8"] = 1;
  var_0["c12"] = 1;

  if(isDefined(self.unittype) && isDefined(var_0[self.unittype]))
    return 0;

  return 1;
}

draw_cool_circle_til_notify() {
  self endon("death");

  for(;;) {
    var_00 = self.origin;
    var_01 = var_00 + anglesToForward(self.angles) * 100;
    scripts\sp\debug::func_5B5D(var_00, var_01, (0, 1, 0), 1, 0);
    wait 0.05;
  }
}

func_10696(var_00) {
  var_00 endon("death");
  var_00 waittill("coverwall_expand_finish");
  var_01 = var_0.origin;
  var_02 = (1, 0, 0);
  var_03 = (0, 1, 0);
  var_04 = 30;
  var_05 = 26;
  var_06 = (0, 90, 0);
  var_07 = "right";
  var_08 = "a";
  var_0.func_473D = [];

  for(var_09 = 1; var_09 < 5; var_9++) {
    var_10 = scripts\engine\utility::ter_op(var_08 == "a", var_05, var_05 * -1);
    var_11 = scripts\engine\utility::ter_op(var_07 == "right", var_04, var_04 * -1);
    var_12 = scripts\engine\utility::ter_op(var_07 == "right", var_0.angles + (0, 90, 0), var_0.angles - (0, 90, 0));
    var_13 = var_03;
    var_14 = "coverwall_" + var_00 getentitynumber() + "_" + var_07 + "_" + var_08;
    var_10 = anglesToForward(var_0.angles) * var_10;
    var_15 = anglestoright(var_0.angles) * var_11;
    var_16 = var_01 + var_10 + var_15;

    if(var_00 func_3913(var_16, var_12))
      var_0.func_473D[var_07 + "_" + var_08] = _spawncovernode(var_16, var_12, "cover stand", 512, var_14);
    else
      var_13 = var_02;

    var_08 = scripts\engine\utility::ter_op(var_08 == "a", "b", "a");
    var_07 = scripts\engine\utility::ter_op(var_09 >= 2, "left", "right");

    if(var_09 == 2)
      wait 0.05;
  }

  var_00 thread func_B9FB();
}

func_3913(var_00, var_01) {
  var_02 = getclosestpointonnavmesh(var_00);
  var_03 = distance(var_00, var_02);

  if(var_03 > 17) {
    if(getdvarint("debug_coverwall")) {}

    return 0;
  }

  if(getdvarint("debug_coverwall")) {}

  var_04 = scripts\engine\trace::capsule_trace(var_00 + (0, 0, 20), var_00, 18, 72, var_01, self, scripts\engine\trace::create_solid_ai_contents(1));

  if(isDefined(var_4["fraction"]) && var_4["fraction"] < 0.5) {
    if(getdvarint("debug_coverwall"))
      scripts\engine\trace::draw_trace(var_04, (1, 0, 0), 0, 200);

    return 0;
  }

  var_05 = getgroundposition(var_00, 16) + (0, 0, 50);
  var_06 = var_05 + anglesToForward(var_01) * 100;
  var_04 = scripts\engine\trace::ray_trace(var_05, var_06);

  if(isDefined(var_4["fraction"]) && var_4["fraction"] < 1) {
    if(getdvarint("debug_coverwall"))
      scripts\engine\trace::draw_trace(var_04, (1, 0, 0), 1, 200);

    return 0;
  }

  if(getdvarint("debug_coverwall"))
    scripts\engine\trace::draw_trace(var_04, (0, 1, 0), 1, 200);

  return 1;
}

func_B9FB() {
  self endon("death");
  wait 1.5;

  if(isDefined(self.func_473D) && !self.func_473D.size) {
    return;
  }
  self endon("death");
  var_00 = undefined;
  var_01 = undefined;
  var_02 = [];

  if(isDefined(self.func_473D["right_a"]))
    var_00 = self.func_473D["right_a"];
  else if(isDefined(self.func_473D["left_a"]))
    var_00 = self.func_473D["left_a"];

  if(isDefined(self.func_473D["right_b"]))
    var_01 = self.func_473D["right_b"];
  else if(isDefined(self.func_473D["left_b"]))
    var_01 = self.func_473D["left_b"];

  if(isDefined(var_00))
    var_2[var_2.size] = var_00;

  if(isDefined(var_01))
    var_2[var_2.size] = var_01;

  for(;;) {
    var_02 = scripts\engine\utility::array_removeundefined(var_02);

    if(!var_2.size) {
      return;
    }
    foreach(var_04 in var_02) {
      if(!var_04 func_C049()) {
        func_E16A(var_04);
        func_E0E1(var_04);
        break;
      }
    }

    wait 1.5;
  }
}

func_E16A(var_00) {
  var_01 = undefined;
  var_02 = strtok(var_0.targetname, "_");
  var_03 = var_2[2] + "_" + var_2[3];

  switch (var_03) {
    case "right_a":
      var_01 = self.func_473D["left_a"];
      break;
    case "left_a":
      var_01 = self.func_473D["right_a"];
      break;
    case "left_b":
      var_01 = self.func_473D["right_b"];
      break;
    case "right_b":
      var_01 = self.func_473D["left_b"];
      break;
  }

  if(isDefined(var_01)) {
    var_1.func_9CA1 = 1;
    func_E0E1(var_01);
  }
}

func_E0E1(var_00) {
  foreach(var_04, var_02 in self.func_473D) {
    if(var_00 == self.func_473D[var_04]) {
      if(getdvarint("debug_coverwall"))
        var_03 = var_0.origin;

      _despawncovernode(var_00);
      self.func_473D = scripts\sp\utility::func_22B2(self.func_473D, var_04);
      return;
    }
  }
}

func_C049() {
  var_00 = spawnStruct();
  var_0.start = self.origin + (0, 0, 15);
  var_0.end = var_0.start + anglesToForward(self.angles) * 40;
  var_01 = spawnStruct();
  var_1.start = self.origin + (0, 0, 40);
  var_1.end = var_1.start + anglesToForward(self.angles) * 40;
  var_02 = 0;
  var_03 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_04 = [var_00, var_01];

  foreach(var_06 in var_04) {
    var_07 = scripts\engine\trace::ray_trace(var_6.start, var_6.end, self.owner, var_03);

    if(isDefined(var_7["fraction"])) {
      if(var_7["fraction"] == 1) {
        if(getdvarint("debug_coverwall")) {}

        var_2++;
        continue;
      }

      if(getdvarint("debug_coverwall"))
        scripts\engine\trace::draw_trace(var_07, (0, 1, 0), 0, 20);
    }
  }

  return var_02 != 2;
}

func_5B54(var_00, var_01, var_02) {
  self endon("death");

  for(;;) {
    scripts\sp\debug::func_5B54(var_00, var_01, var_02, 32, 1);
    wait 0.05;
  }
}

func_475E(var_00) {
  self.func_BE07 thread scripts\sp\utility::func_C12D("expired", var_00);
  var_01 = self.func_BE07 scripts\engine\utility::waittill_any_return("expired", "death");
  var_02 = var_01 == "death";
  var_03 = self.func_BE07.origin;
  var_04 = self.func_BE07.owner;

  if(scripts\engine\utility::flag("coverwall_force_delete"))
    scripts\engine\utility::waitframe();

  if(isDefined(self.func_BE07) && isDefined(self.func_BE07.func_473D)) {
    foreach(var_06 in self.func_BE07.func_473D) {
      if(isDefined(var_06))
        _despawncovernode(var_06);
    }
  }

  if(isDefined(self.func_BE07.func_BE64))
    _destroynavobstacle(self.func_BE07.func_BE64);

  if(isDefined(self.func_BE07))
    self.func_BE07 _meth_8514(var_02);

  if(isDefined(self.func_BE07.func_132AA)) {
    foreach(var_09 in self.func_BE07.func_132AA)
    var_09 delete();
  }

  if(!var_02) {
    var_11 = self.func_BE07.angles;
    playFX(level.func_7649["coverwall_collapse"], var_03, anglesToForward(var_11), anglestoup(var_11));
    _playworldsound("deployable_cover_contract", var_03);
  }

  var_4.func_4759.active = scripts\engine\utility::array_remove(var_4.func_4759.active, self.func_BE07);
  scripts\engine\utility::flag_wait_or_timeout("coverwall_force_delete", 1.5);

  if(!var_4.func_4759.active.size) {
    if(isDefined(var_4.func_4759.func_5AE6)) {
      var_04 notify("stop_coverwall_doubletap");
      var_4.func_4759.func_5AE6 = undefined;
    }
  }

  level.player.func_4759.func_11168 = scripts\engine\utility::array_remove(level.player.func_4759.func_11168, self);
}

func_475D() {
  self endon("death");
  self endon("entitydeleted");
  self waittill("coverwall_expand_finish");
  self.func_BE64 = _func_316(self);
}

func_B9C4() {
  if(isDefined(self.func_4759.func_5AE6)) {
    return;
  }
  self.func_4759.func_5AE6 = 1;
  self endon("stop_coverwall_doubletap");
  var_00 = 0;
  var_01 = 0.3;

  for(;;) {
    if(level.player usebuttonpressed()) {
      var_00 = 0;

      while(level.player usebuttonpressed()) {
        var_00 = var_00 + 0.05;
        wait 0.05;
      }

      if(var_00 >= var_01) {
        continue;
      }
      var_00 = 0;

      while(!level.player usebuttonpressed() && var_00 < var_01) {
        var_00 = var_00 + 0.05;
        wait 0.05;
      }

      if(var_00 >= var_01) {
        continue;
      }
      thread scripts\sp\utility::play_sound_on_entity("deployable_cover_det_trig");
      wait 0.3;
      func_2BCE();
      self.func_4759.func_5AE6 = undefined;
      self notify("stop_coverwall_doubletap");
      return;
    }

    wait 0.05;
  }
}

func_2BCE() {
  foreach(var_01 in self.func_4759.active) {
    func_475C(var_01);
    scripts\engine\utility::flag_wait_or_timeout("coverwall_force_delete", 0.2);
  }
}

func_475C(var_00, var_01) {
  var_02 = var_0.origin;
  var_03 = var_02 + (0, 0, 32);

  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode"))
    playFX(level.func_7649["coverwall_explosion_vr"], var_02);
  else
    playFX(level.func_7649["coverwall_explosion"], var_02);

  _playworldsound("deployable_cover_explode", var_02);
  earthquake(0.4, 0.6, var_0.owner.origin, 450);
  level.player playrumbleonentity("damage_heavy");
  var_00 notify("death");
  scripts\engine\utility::flag_wait_or_timeout("coverwall_force_delete", 0.1);

  if(!isDefined(var_01))
    radiusdamage(var_03, 150, 250, 120, var_0.owner, "MOD_EXPLOSIVE", "coverwall");
}

func_596D() {
  if(isDefined(self.func_596D)) {
    return;
  }
  self.func_596D = 1;
  self endon("death");
  self endon("stop_for_coverwalls");

  for(;;) {
    var_00 = getEntArray("script_coverwall", "classname");

    foreach(var_02 in var_00) {
      if(isDefined(var_2.func_BE64))
        _destroynavobstacle(var_2.func_BE64);

      var_03 = distancesquared(self.origin, var_2.origin);

      if(var_03 < squared(200))
        var_02 notify("expired");
    }

    wait 0.75;
  }
}

func_551C() {
  self notify("stop_for_coverwalls");
  self.func_596D = undefined;
}