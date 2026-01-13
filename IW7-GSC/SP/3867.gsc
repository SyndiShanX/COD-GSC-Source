/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3867.gsc
*********************************************/

main() {
  func_9732();
  scripts\sp\utility::func_65E0("stealth_enabled");
  scripts\sp\utility::func_65E1("stealth_enabled");
  scripts\sp\utility::func_65E0("stealth_override_goal");
  scripts\sp\utility::func_65E0("stealth_hold_position");
  scripts\sp\utility::func_65E0("stealth_attack");
  scripts\sp\utility::func_65E0("stealth_cover_blown");
  lib_0F27::func_868B("stealth_spotted");
  lib_0F27::func_868B("stealth_cover_blown");
  lib_0F27::func_8682();
  self.var_10E6D.beginusegas = "patrol";
  self.var_527B = "patrol";
  scripts\asm\asm_bb::func_2980("patrol", "unaware");
  lib_0F27::func_F557(::func_D7DD);
  lib_0F1C::func_6854();
  thread func_B960(128, 600);
  thread func_10A9E();
  thread func_4DFE();
  thread func_3D64();
  thread func_7346();
  if(isDefined(self.target)) {
    self.objective_playermask_showto = 32;
    thread lib_0B77::worldpointinreticle_circle(undefined, undefined, undefined, undefined, undefined);
  }

  func_F299("reset");
  self.var_10E6D.var_13529 = scripts\engine\utility::array_randomize(["sf1", "sf2", "sf3", "sf4"])[0];
}

func_9732() {
  self.var_10E6D = spawnStruct();
  self.var_10E6D.var_74D5 = [];
  self.var_10E6D.var_B470 = 2;
  self.combatmemorytimerand = self.var_BC;
  self.var_10E6D.var_DD1D = 0;
  scripts\sp\utility::func_F292("setdef");
  self.target_alloc = squared(level.var_10E6D.var_21["ai_eventDistFootstepSprint"]["hidden"]);
  lib_0F19::func_4682();
}

func_10A9E() {
  self endon("death");
  for(;;) {
    scripts\sp\utility::func_65E3("stealth_enabled");
    if(lib_0F27::func_8689("stealth_spotted")) {
      thread func_10E20();
    }

    lib_0F27::func_868E("stealth_spotted");
    scripts\sp\utility::func_65E3("stealth_enabled");
    thread func_10E1B();
    scripts\sp\utility::func_65E3("stealth_enabled");
    lib_0F27::func_868D("stealth_spotted");
  }
}

func_3D64() {
  self endon("death");
  while(!isDefined(self.var_10E6D.var_C9A8)) {
    wait(0.05);
  }

  if(lib_0F27::func_8689("stealth_cover_blown")) {
    thread func_1272D();
  }
}

func_4DFE() {
  self waittill("death");
  if(isDefined(self)) {
    lib_0F26::func_117D4("death");
    if(isDefined(self.stealth_vo_ent)) {
      self.stealth_vo_ent stopsounds();
      scripts\engine\utility::waitframe();
      self.stealth_vo_ent delete();
      self.stealth_vo_ent = undefined;
    }
  }
}

func_1645() {
  self notify("active_sense_thread");
  self endon("active_sense_thread");
  self endon("death");
  self endon("pain_death");
  for(;;) {
    scripts\sp\utility::func_65E3("stealth_enabled");
    if(!lib_0F27::func_869D()) {
      if(!scripts\sp\utility::func_65DB("stealth_attack")) {
        lib_0F19::func_468A();
        func_DAB0();
      }
    }

    wait(0.1);
  }
}

func_DAB0() {
  if(self.precacheleaderboards) {
    return;
  }

  if(!isDefined(level.var_10E6D)) {
    return;
  }

  var_0 = self.origin;
  var_1 = (0, 0, 0);
  if(scripts\sp\utility::hastag(self.model, "j_spine4")) {
    var_0 = self gettagorigin("j_spine4");
    var_1 = (0, 0, 35);
  }

  foreach(var_3 in level.players) {
    var_4 = 0;
    if(!isalive(var_3)) {
      continue;
    }

    if(issentient(var_3) && var_3.ignoreme || var_3.target_gettargetatindex) {
      continue;
    }

    var_5 = distancesquared(var_0, var_3.origin + var_1);
    if(isDefined(level.var_10E6D.var_DAB2) && level.var_10E6D.var_DAB2 > 0) {
      var_6 = squared(level.var_10E6D.var_DAB2);
      if(var_5 < var_6) {
        var_4 = 1;
      }
    }

    if(!var_4 && isDefined(level.var_10E6D.var_DAB3) && level.var_10E6D.var_DAB3 > 0) {
      var_7 = squared(level.var_10E6D.var_DAB3);
      if(var_5 < var_7 && self getpersstat(var_3, 0)) {
        var_4 = 1;
      }
    }

    if(var_4) {
      self _meth_84F7("proximity", var_3, var_3.origin);
      return;
    }
  }
}

func_F2E0(var_0) {
  if(!isDefined(self.var_10E6D)) {
    return;
  }

  if(var_0 && self.var_29 <= 2) {
    self.var_10E6D.var_2B96 = 1;
    func_F59D("blind");
    return;
  }

  self.var_10E6D.var_2B96 = undefined;
  if(self.var_29 > 2) {
    func_F59D("spotted");
    return;
  }

  func_F59D("hidden");
}

func_F59D(var_0) {
  switch (var_0) {
    case "blind":
      lib_0F26::func_117D4("hidden");
      self.musicplay = 1;
      self.musicstop = 1;
      self.newclienthudelem = 0;
      self.stopfxontagforclients = 0;
      break;

    case "hidden":
      if(lib_0F22::func_9B2C()) {
        lib_0F26::func_117D4("investigate");
      } else {
        lib_0F26::func_117D4("hidden");
      }

      self.musicplay = 0.7;
      self.musicstop = 0.86;
      self.newclienthudelem = 0.97;
      self.stopfxontagforclients = 1;
      break;

    case "spotted":
      lib_0F26::func_117D4("spotted");
      self.musicplay = 0.01;
      self.newclienthudelem = 0;
      self.stopfxontagforclients = 0;
      break;
  }
}

func_10E1B() {
  if(scripts\engine\utility::istrue(self.var_10E6D.var_2B96)) {
    func_F59D("blind");
  } else {
    func_F59D("hidden");
  }

  self.loadstartpointtransients = undefined;
  self.var_5951 = 1;
  self.dontevershoot = 1;
  thread scripts\sp\utility::func_F2DA(0);
  self.var_FED1 = undefined;
  self.var_BC = self.combatmemorytimerand;
  self.var_10E6D.var_DD1D = 0;
  thread lib_0F19::func_467C();
  lib_0F27::func_F4C9();
  if(!isDefined(self.var_10E6D.var_C3B5)) {
    self.var_10E6D.var_C3B5 = self.var_BC;
    self.var_BC = "no_cover";
  }

  foreach(var_1 in level.players) {
    if(!isDefined(var_1.var_10E6D)) {
      continue;
    }

    if(!isDefined(var_1.var_10E6D.var_10A9D)) {
      continue;
    }

    var_1.var_10E6D.var_10A9D[self.unique_id] = undefined;
  }

  lib_0F22::func_9B25();
  thread func_1645();
  self.var_10E6D.beginusegas = "patrol";
  self.var_EF = 1;
  self getplayerforguid();
  func_F299("reset");
  lib_0F1C::func_6839();
}

func_10E20() {
  func_F59D("spotted");
  self.var_5951 = undefined;
  self.dontevershoot = undefined;
  self.var_BC = self.combatmemorytimerand;
  self.var_EF = 0;
  thread scripts\sp\utility::func_F2DA(1);
  lib_0F22::func_9B25();
  if(isDefined(self.var_10E6D.var_C3B5)) {
    self.var_BC = self.var_10E6D.var_C3B5;
    self.var_10E6D.var_C3B5 = undefined;
  }

  self notify("active_sense_thread");
  var_0 = undefined;
  var_1 = self.origin;
  if(isDefined(level.var_10E6D.group.var_10A9B)) {
    var_0 = level.var_10E6D.group.var_10A9B[self.var_EED1];
  }

  if(isDefined(var_0)) {
    var_1 = var_0.origin;
    self getenemyinfo(var_0);
  } else {
    var_0 = undefined;
  }

  self _meth_84F7("combat", var_0, var_1);
}

func_7346() {
  self endon("death");
  for(;;) {
    self.getislosdatafileloaded = 0;
    scripts\sp\utility::func_65E3("stealth_enabled");
    if(self.var_29 <= 2 && scripts\asm\asm::asm_isinstate("patrol_move")) {
      self.getislosdatafileloaded = 1;
    }

    wait(0.05);
  }
}

func_1B3D(var_0) {
  thread lib_0F27::func_1284A("hmph");
  func_F299("reset");
  thread func_10E1B();
  lib_0F27::_meth_8468();
}

func_F5C9() {
  self endon("death");
  self endon("pain_death");
  self.dontevershoot = undefined;
  self[[self.var_10E6D.var_D7DE]]();
  if(self.ignoreme) {
    return;
  }

  lib_0F22::func_9B25();
  var_0 = self.isnodeoccupied;
  if(isDefined(var_0)) {
    level.var_10E6D.group.var_10A9B[self.var_EED1] = var_0;
    if(isDefined(var_0.var_10E6D)) {
      var_0 lib_0F27::func_868C("stealth_spotted");
    }
  }

  lib_0F27::func_868C("stealth_spotted");
}

func_D7DD() {
  wait(2);
}

func_F299(var_0) {
  if(!scripts\sp\utility::func_65DB("stealth_enabled")) {
    return;
  }

  if(isDefined(self.var_1B44) && self.var_1B44 == var_0) {
    return;
  }

  self notify("set_alert_level");
  self endon("set_alert_level");
  self endon("death");
  if(var_0 == "attack" || var_0 == "combat") {
    thread func_F5C9();
  }

  self.var_1B44 = var_0;
  while(isDefined(self.physics_setgravityragdollscalar)) {
    wait(0.05);
  }

  lib_0F27::func_F5B7(var_0);
  self notify("stealth_alertlevel_change", var_0);
  self.var_28 = lib_0F27::func_1B40(var_0);
  var_1 = self.var_29 > 2;
  lib_0F1C::func_6837(!var_1);
  self._func_182 = !var_1;
}

func_F345() {
  level lib_0F27::func_F5B4("go_to_node_wait", ::isjumping);
  level lib_0F27::func_F5B4("go_to_node_arrive", ::_meth_840C);
  level lib_0F27::func_F5B4("reset", ::func_1B3D);
  level lib_0F27::func_F5B4("set_patrol_style", ::lib_0F27::func_F4C8);
  level lib_0F27::func_F5B4("trigger_cover_blown", ::func_1272D);
  level lib_0F27::func_F5B4("set_blind", ::func_F2E0);
  level lib_0F27::func_F5B4("investigate", ::func_6847);
  level lib_0F27::func_F5B4("cover_blown", ::func_6847);
  level lib_0F27::func_F5B4("combat", ::func_6847);
}

func_B960(var_0, var_1) {
  var_2 = undefined;
  var_3 = self.team;
  for(;;) {
    if(!isalive(self)) {
      return;
    }

    self waittill("damage", var_4, var_5, var_6, var_7);
    func_3DAF(var_4, var_5, var_7);
    var_8 = self.origin;
    if(isalive(self) && !scripts\sp\utility::func_65DB("stealth_enabled")) {
      continue;
    }

    if(isalive(var_5)) {
      var_2 = var_5;
    }

    if(!isDefined(var_2)) {
      continue;
    }

    if(isplayer(var_2) || isDefined(var_2.team) && var_2.team != var_3) {
      break;
    }

    if(isDefined(var_2.classname) && var_2.classname == "script_model") {
      if(var_2.var_9D62) {
        break;
      }
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var_2) && var_2 == level.player && lib_0E29::func_87A7() == "controllingrobot") {
    var_2 give_zombies_perk();
  }

  if(isDefined(self.var_10E6D.var_C813)) {
    var_0 = self.var_10E6D.var_C813;
  } else if(isDefined(level.var_10E6D.var_C813)) {
    var_0 = level.var_10E6D.var_C813;
  }

  if(isDefined(self.var_10E6D.var_C814)) {
    var_1 = self.var_10E6D.var_C814;
  } else if(isDefined(level.var_10E6D.var_C814)) {
    var_1 = level.var_10E6D.var_C814;
  }

  lib_0F1C::func_67FF("attack", var_2, var_0, var_1);
}

func_3DAF(var_0, var_1, var_2) {
  if(var_0 > 0 && self.var_DE != "MOD_MELEE" && self.var_1B44 != "attack" && self.var_1B44 != "combat") {
    var_3 = self getEye();
    if(distancesquared(var_2, var_3) < squared(20)) {
      self dodamage(self.health, var_2, var_1, var_1, "MOD_HEAD_SHOT");
    }
  }
}

func_6847(var_0) {
  var_0.var_9B22 = var_0.origin;
  if(isDefined(self.isnodeoccupied) && isDefined(var_0.issplitscreen) && var_0.issplitscreen == self.isnodeoccupied) {
    var_0.var_9B22 = self lastknownpos(self.isnodeoccupied);
  } else if(isDefined(var_0.issplitscreen) && var_0.var_12AE9 == "bulletwhizby") {
    var_0.var_9B22 = var_0.issplitscreen.origin;
  }

  func_6849(var_0);
  if(func_6848(var_0)) {
    return;
  }

  self.var_10E6D.var_A908 = gettime();
  if(!func_DD2D(var_0)) {
    func_DD2C(var_0);
  }

  switch (var_0.type) {
    case "investigate":
      thread func_6859(var_0);
      break;

    case "cover_blown":
      thread func_6810(var_0);
      break;

    case "combat":
      thread func_6808(var_0);
      break;
  }

  var_1 = lib_0F18::func_10EBB(var_0.var_12AE9);
  if(isDefined(var_1) && var_1 != ::func_6847) {
    self thread[[var_1]](var_0);
  }
}

func_6848(var_0) {
  var_1 = self.var_10E6D.var_6896;
  if(!isDefined(var_1)) {
    var_1 = level.var_10E6D.var_6896;
  }

  if(isDefined(var_1)) {
    var_2 = lib_0F1C::func_6894(var_1, var_0.type);
    if(var_2 > 0) {
      return 1;
    }
  }

  if(scripts\engine\utility::istrue(level.var_10E6D.var_5659) && func_6872(var_0)) {
    return 1;
  }

  if(isDefined(var_0.issplitscreen) && var_0.issplitscreen == level.player && lib_0E29::func_87A7() == "controllingrobot" && func_6871(var_0)) {
    self.var_10E6D.var_683A[var_0.var_12AE9] = 0;
    self.var_10E6D.var_683A[var_0.type] = 0;
    return 1;
  }

  var_3 = lib_0F18::func_10EBB("event_" + var_0.type);
  if(isDefined(var_3)) {
    return lib_0F18::func_10E8A("event_" + var_0.type, var_0);
  }

  return 0;
}

func_6872(var_0) {
  if(issentient(var_0.issplitscreen)) {
    switch (var_0.var_12AE9) {
      case "proximity":
      case "footstep_walk":
      case "footstep_sprint":
      case "footstep":
        thread lib_0F26::func_117C5(var_0.issplitscreen, 1);
        return 1;
    }
  }

  return 0;
}

func_6871(var_0) {
  if(issentient(var_0.issplitscreen)) {
    switch (var_0.var_12AE9) {
      case "proximity":
        return 1;

      case "silenced_shot":
      case "projectile_impact":
      case "gunshot":
      case "bulletwhizby":
      case "grenade danger":
      case "explode":
        var_0.type = "combat";
        return 0;
    }
  }

  if(var_0.type != "combat") {
    return 1;
  }

  return 0;
}

func_6849(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.var_12AE9)) {
    return;
  }

  switch (var_0.var_12AE9) {
    case "sight":
      if(isDefined(self.var_10E6D.var_117CA) && self.var_10E6D.var_117CA == 0) {
        var_0.type = "combat";
      }
      break;
  }
}

func_6859(var_0) {
  func_F299("warning1");
  thread lib_0F22::func_9B23(var_0);
}

func_6810(var_0) {
  func_F299("warning2");
  if(scripts\engine\utility::istrue(level.var_10E6D.var_5659)) {
    switch (var_0.var_12AE9) {
      case "silenced_shot":
      case "gunshot":
      case "explode":
        lib_0F27::func_F357(0);
        level scripts\engine\utility::delaythread(20, ::lib_0F27::func_F357, 1);
        break;
    }
  }

  thread lib_0F22::func_9B23(var_0);
  if(!lib_0F27::func_8693()) {
    var_1 = lib_0F27::func_1284A("backup_call", 4);
    if(isDefined(var_1) && var_1) {
      lib_0F27::func_4F6C("seek_backup", var_0.var_9B22, randomintrange(1, 2), 800);
    }
  }
}

func_6808(var_0) {
  self notify("investigate_behavior");
  self notify("stop_going_to_node");
  self notify("investigate_forget");
  if(isDefined(self.var_10E6D.var_92CC) && isDefined(self.var_4E2A)) {
    self.var_4E2A = undefined;
  }

  self.var_10E6D.beginusegas = "combat";
  func_F299("attack");
  if(issentient(var_0.issplitscreen) && !isDefined(self.isnodeoccupied)) {
    self getenemyinfo(var_0.issplitscreen);
    lib_0F26::func_117D4("spotted");
  }

  scripts\sp\utility::func_65E1("stealth_attack");
  lib_0F27::func_10EE4(1);
  lib_0F27::func_F4C8("combat", 1, var_0.var_9B22);
}

func_1272D(var_0) {
  self endon("death");
  var_1 = undefined;
  if(isDefined(var_0)) {
    var_1 = var_0.origin;
  }

  if(!isDefined(self.var_10E6D)) {
    return;
  }

  if(scripts\sp\utility::func_65DB("stealth_cover_blown")) {
    return;
  }

  scripts\sp\utility::func_65E1("stealth_cover_blown");
  lib_0F27::func_868C("stealth_cover_blown");
  var_2 = lib_0F27::func_7B72();
  if(!isDefined(var_2) || var_2 == "unaware") {
    if(!isDefined(self.var_10E6D.var_C9A8) || self.var_10E6D.var_C9A8 == "unaware") {
      lib_0F27::func_F4C8("alert", isDefined(self.var_10E6D.beginusegas) && self.var_10E6D.beginusegas != "investigate", var_1);
    }

    self.var_10E6D.var_500C = "alert";
  }
}

func_DD2C(var_0) {
  self endon("death");
  var_1 = 0.1;
  switch (var_0.type) {
    case "investigate":
      thread lib_0F27::func_1284A("warning1", var_1);
      return 1;

    case "cover_blown":
      thread lib_0F27::func_1284A("warning2", var_1);
      return 1;

    case "combat":
      thread lib_0F27::func_1284A("spotted", var_1);
      return 1;
  }

  return 0;
}

func_DD2D(var_0) {
  self endon("death");
  if(isDefined(var_0.var_12AE9)) {
    var_1 = randomfloatrange(0.5, 1);
    switch (var_0.var_12AE9) {
      case "explode":
        thread lib_0F27::func_1284A("explosion", var_1);
        return 1;

      case "seek_backup":
        thread lib_0F27::func_1284A("acknowledgement", var_1);
        return 1;

      case "found_corpse":
      case "saw_corpse":
        thread lib_0F27::func_1284A(var_0.var_12AE9, var_1);
        thread lib_0F27::func_1698(["saw_corpse", "found_corpse"], var_1 + 0.05);
        return 1;
    }
  }

  return 0;
}

setworldupreference(var_0, var_1, var_2) {
  self endon("death");
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = !var_2;
  while(lib_0F27::func_10E82() || !var_3) {
    lib_0F27::func_10E87();
    self[[var_0]](var_1);
    var_3 = 1;
    self waittill("goal");
  }
}

isjumping(var_0, var_1) {
  self endon("death");
  setworldupreference(var_0, var_1);
  if(isDefined(self.var_10E6D.var_92CC)) {
    lib_0F27::func_413E();
    if(isDefined(self.var_10E6D.var_4C4F)) {
      lib_0F27::func_CCD4(var_1, "gravity");
    }
  }
}

_meth_840C(var_0, var_1) {
  setworldupreference(var_0, var_1, 0);
  if(isDefined(var_1.var_EE2C)) {
    self.moveplaybackrate = var_1.var_EE2C;
  }

  if(isDefined(var_1.script_animation)) {
    if(scripts\engine\utility::istrue(var_1.var_ED88) && isDefined(var_1.angles)) {
      self orientmode("face angle", var_1.angles[1]);
    }

    var_2 = var_1.script_animation;
    scripts\sp\anim::func_1EC8(self, "gravity", var_2);
  } else if(isDefined(var_1.var_EDDE)) {
    self[[level.var_92DE[var_1.var_EDDE]]](var_1);
  }

  if(isDefined(var_1.script_animation_exit)) {
    scripts\sp\anim::func_1EC8(self, "gravity", var_1.script_animation_exit);
  }
}