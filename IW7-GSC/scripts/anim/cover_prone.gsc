/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\cover_prone.gsc
****************************************/

func_9509() {}

main() {
  self endon("killanimscript");
  scripts\anim\utility::func_9832("cover_prone");
  if(weaponclass(self.var_394) == "rocketlauncher") {
    scripts\anim\combat::main();
    return;
  }

  if(isDefined(self.target_getindexoftarget.turret)) {
    scripts\anim\cover_wall::func_130DF();
  }

  if(isDefined(self.isnodeoccupied) && lengthsquared(self.origin - self.isnodeoccupied.origin) < squared(512)) {
    thread scripts\anim\combat::main();
    return;
  }

  func_F924();
  self.covernode = self.target_getindexoftarget;
  self orientmode("face angle", self.covernode.angles[1]);
  self.a._meth_8445 = 1;
  self give_run_perk(-45, 45, % prone_legs_down, % exposed_modern, % prone_legs_up);
  if(self.a.pose != "prone") {
    prone_transitionto("prone");
  } else {
    scripts\anim\utility::enterpronewrapper(0);
  }

  thread scripts\anim\combat_utility::func_1A3E();
  func_FADE(0.2);
  self give_attacker_kill_rewards( % prone_aim_5, 1, 0.1);
  self orientmode("face angle", self.covernode.angles[1]);
  self animmode("zonly_physics");
  func_DA7E();
  self notify("stop_deciding_how_to_shoot");
}

end_script() {
  self.a._meth_8445 = undefined;
}

func_92FF() {
  self endon("killanimscript");
  self endon("kill_idle_thread");
  for(;;) {
    var_0 = scripts\anim\utility::func_1F67("prone_idle");
    self _meth_82E8("idle", var_0);
    self waittillmatch("end", "idle");
    self clearanim(var_0, 0.2);
  }
}

func_12EF6(var_0) {
  self _meth_83CF(scripts\anim\utility::func_B027("cover_prone", "legs_up"), scripts\anim\utility::func_B027("cover_prone", "legs_down"), 1, var_0, 1);
  self give_attacker_kill_rewards( % exposed_aiming, 1, 0.2);
}

func_DA7E() {
  self endon("killanimscript");
  thread scripts\anim\track::func_11B07();
  thread scripts\anim\shoot_behavior::func_4F69("normal");
  var_0 = gettime() > 2500;
  for(;;) {
    scripts\anim\utility::func_12EB9();
    func_12EF6(0.05);
    if(!var_0) {
      wait(0.05 + randomfloat(1.5));
      var_0 = 1;
      continue;
    }

    if(!isDefined(self.var_FECF)) {
      if(func_453F()) {
        continue;
      }

      wait(0.05);
      continue;
    }

    var_1 = lengthsquared(self.origin - self.var_FECF);
    if(self.a.pose != "crouch" && self getteleportlonertargetplayer("crouch") && var_1 < squared(400)) {
      if(var_1 < squared(285)) {
        prone_transitionto("crouch");
        thread scripts\anim\combat::main();
        return;
      }
    }

    if(func_453F()) {
      continue;
    }

    if(func_DA83(0)) {
      continue;
    }

    if(scripts\anim\combat_utility::func_1A3B()) {
      scripts\anim\combat_utility::func_FEDF();
      self clearanim( % add_fire, 0.2);
      continue;
    }

    wait(0.05);
  }
}

func_DA83(var_0) {
  return scripts\anim\combat_utility::openfile(var_0, scripts\anim\utility::func_1F64("reload"));
}

func_F924() {
  self _meth_82D0(self.target_getindexoftarget);
  self.a.var_2274 = scripts\anim\utility::func_B028("cover_prone");
}

func_128AF(var_0, var_1) {
  var_2 = undefined;
  if(isDefined(var_1) && var_1) {
    var_2 = scripts\anim\utility::func_1F67("grenade_safe");
  } else {
    var_2 = scripts\anim\utility::func_1F67("grenade_exposed");
  }

  self animmode("zonly_physics");
  self.sendmatchdata = 1;
  var_3 = (32, 20, 64);
  var_4 = scripts\anim\combat_utility::func_128A0(var_0, var_2);
  self.sendmatchdata = 0;
  return var_4;
}

func_453F() {
  if(isDefined(level.var_11813) && isalive(level.player)) {
    if(func_128AF(level.player, 200)) {
      return 1;
    }
  }

  if(isDefined(self.isnodeoccupied)) {
    return func_128AF(self.isnodeoccupied, 850);
  }

  return 0;
}

func_10012() {
  if(!isDefined(self.var_394) || !weaponisauto(self.var_394) || !weaponisbeam(self.var_394)) {
    return 0;
  }

  if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < 256) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied) && self getpersstat(self.isnodeoccupied) && !isDefined(self.objective_position) && scripts\anim\shared::getaimyawtoshootentorpos() < 20) {
    return scripts\anim\move::func_B4EC();
  }

  return 0;
}

prone_transitionto(var_0) {
  if(var_0 == self.a.pose) {
    return;
  }

  self clearanim( % root, 0.3);
  scripts\anim\combat_utility::func_631A();
  if(func_10012()) {
    var_1 = scripts\anim\utility::func_1F64(self.a.pose + "_2_" + var_0 + "_firing");
  } else {
    var_1 = scripts\anim\utility::func_1F64(self.a.pose + "_2_" + var_1);
  }

  if(var_0 == "prone") {}

  self _meth_82E4("trans", var_1, % body, 1, 0.2, 1);
  scripts\anim\shared::donotetracks("trans");
  self give_boombox(scripts\anim\utility::func_1F64("straight_level"), % body, 1, 0.25);
  func_FADE(0.25);
}

func_6CDE(var_0) {
  self endon("killanimscript");
  scripts\anim\shared::donotetracks(var_0);
}

func_FADE(var_0) {
  self _meth_82A5( % prone_aim_5, % body, 1, var_0);
  self _meth_82AC( % prone_aim_2_add, 1, var_0);
  self _meth_82AC( % prone_aim_4_add, 1, var_0);
  self _meth_82AC( % prone_aim_6_add, 1, var_0);
  self _meth_82AC( % prone_aim_8_add, 1, var_0);
}

func_DA87(var_0, var_1) {
  self clearanim( % root, 0.3);
  var_2 = undefined;
  if(isDefined(self.var_DA78)) {
    var_2 = self.var_DA78;
  }

  if(isDefined(self.prone_rate_override)) {
    var_1 = self.prone_rate_override;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  scripts\anim\utility::exitpronewrapper(getanimlength(var_2) / 2);
  self _meth_82E4("trans", var_2, % body, 1, 0.2, var_1);
  scripts\anim\shared::donotetracks("trans");
  self clearanim(var_2, 0.1);
}