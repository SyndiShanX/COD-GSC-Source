/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3622.gsc
************************/

func_972B() {
  setdvarifuninitialized("debug_seeker", 0);
  level.var_F10A = spawnStruct();
  level.var_F10A.targets = [];
  level.var_F10A.var_1633 = [];
  level.var_F10A.var_162D = [];
  level.var_F10A.var_A8C6 = undefined;
  level.player.var_F179 = spawnStruct();
  level.player.var_F179.var_45BF = 0;
  level.player.var_F179.var_9076 = 0;
  level.var_F10A.var_4D19 = 128;
  level.var_F10A.var_4D0C = 200;
  level.var_F10A.var_4D02 = 550;
  level.var_F10A.var_B41A = 4;
  scripts\engine\utility::flag_init("seeker_force_delete");
  scripts\sp\utility::func_9189("default_seeker", 3, "default");
}

func_F135(param_00) {
  if(level.var_F10A.var_1633.size >= level.var_F10A.var_B41A) {
    func_A5FB();
  }

  var_01 = undefined;
  if(self == level.player && isDefined(level.player.var_AF29)) {
    var_01 = level.player.var_AF29;
    level.player.var_AF29 = undefined;
  }

  var_02 = scripts\engine\utility::spawn_tag_origin();
  var_02.origin = param_00.origin;
  var_02 linkto(param_00);
  var_02.objective_position = param_00;
  level.var_F10A.var_162D[level.var_F10A.var_162D.size] = var_02;
  param_00 thread func_F136();
  var_03 = var_02.objective_position scripts\engine\utility::waittill_any_return("missile_stuck", "death", "entitydeleted");
  if(!isDefined(var_02.objective_position)) {
    var_02 thread func_E085();
    return;
  }

  if(var_03 == "missile_stuck") {
    func_107D1(var_02, undefined, undefined, var_01);
  }

  if(level.player.var_F179.var_45BF) {
    level thread func_B9CD();
  }

  var_02 thread func_E085();
}

func_F136() {
  self endon("death");
  wait(5);
  self delete();
}

func_E085() {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.objective_position)) {
    level.var_F10A.var_A8C6 = self.objective_position.origin;
    self.objective_position unlink();
    self.objective_position delete();
  }

  if(scripts\engine\utility::flag("seeker_force_delete")) {
    scripts\engine\utility::waitframe();
  }

  if(isDefined(self)) {
    level.var_F10A.var_162D = scripts\engine\utility::array_remove(level.var_F10A.var_162D, self);
    self delete();
  }
}

func_A5FB() {
  var_00 = undefined;
  var_01 = 0;
  foreach(var_03 in level.var_F10A.var_1633) {
    if(var_01 == 0 || var_03.starttime < var_01) {
      var_01 = var_03.starttime;
      var_00 = var_03;
    }
  }

  if(isDefined(var_00)) {
    var_00.var_EA0E = 1;
    if(isDefined(var_00.var_F166)) {
      stopFXOnTag(level.var_7649[var_00.var_F166], var_00, "tag_fx");
    }

    if(isDefined(var_00.var_B14F)) {
      var_00 scripts\sp\utility::func_1101B();
    }

    playFXOnTag(level.var_7649["seeker_sparks"], var_00, "tag_fx");
    playworldsound("seeker_expire", var_00.origin);
    var_00 hudoutlinedisable();
    var_00 _meth_81D0();
  }
}

func_DFC1() {
  level notify("removing_all_seekers_instantly");
  level endon("removing_all_seekers_instantly");
  scripts\engine\utility::flag_set("seeker_force_delete");
  foreach(var_01 in level.var_F10A.var_162D) {
    var_01 thread func_E085();
  }

  foreach(var_04 in level.var_F10A.var_1633) {
    var_04 thread func_E084();
  }

  for(;;) {
    if(level.var_F10A.var_162D.size > 0 || level.var_F10A.var_1633.size > 0) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_clear("seeker_force_delete");
}

func_107D1(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00)) {
    param_00 = self;
  }

  var_04 = getclosestpointonnavmesh(param_00.origin, undefined, 1);
  var_05 = distancesquared(var_04, param_00.origin);
  if(var_05 > squared(250)) {
    return;
  }

  var_06 = getspawner("actor_ally_equipment_seeker", "classname");
  var_06.origin = param_00.origin;
  if(isDefined(param_02)) {
    var_06.origin = var_06.origin + param_02;
  }

  var_06.angles = self.angles;
  var_06.var_C1 = var_06.var_C1 + 1;
  var_07 = var_06 func_F15A();
  if(!isDefined(var_07)) {
    return;
  }

  var_07.triggerportableradarping = self;
  if(isDefined(param_01) && param_01 == 1) {
    var_07.var_C93D = 1;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "no_expire") {
    self.var_595E = 1;
  }

  if(!isDefined(var_07.var_C93D)) {
    var_07.team = var_07.triggerportableradarping.team;
  }

  self.var_F10A = var_07;
  if(isDefined(param_03)) {
    var_07.loadstartpointtransients = param_03;
  }

  var_07 thread func_F159();
  if(isDefined(level.var_F10A.var_4C74)) {
    var_07 thread[[level.var_F10A.var_4C74]]();
  }

  level.var_F10A.var_1633[level.var_F10A.var_1633.size] = var_07;
  return var_07;
}

func_107D2(param_00, param_01, param_02, param_03, param_04) {
  var_05 = getspawner("actor_ally_equipment_seeker", "classname");
  var_05.origin = param_00;
  var_05.angles = param_01;
  var_05.var_C1 = var_05.var_C1 + 1;
  var_06 = var_05 func_F15A();
  if(!isDefined(var_06)) {
    return;
  }

  var_06.triggerportableradarping = var_06;
  var_06.team = param_02;
  if(isDefined(param_03)) {
    var_06.var_728A = param_03;
  }

  if(isDefined(param_04)) {
    var_06.var_5967 = param_04;
  }

  var_06 thread func_F159();
  level.var_F10A.var_1633[level.var_F10A.var_1633.size] = var_06;
  return var_06;
}

func_F12A() {
  self endon("death");
  var_00 = 0;
  var_01 = 5;
  for(;;) {
    if(!self islinked()) {
      var_02 = self _meth_812B();
      if(var_02 == "none") {
        var_00++;
        if(var_00 > 4 * var_01) {
          self delete();
        }
      } else {
        var_00 = 0;
      }
    } else {
      var_00 = 0;
    }

    wait(0.25);
  }
}

func_F15A() {
  level endon("seeker_force_delete");
  if(scripts\engine\utility::flag("seeker_force_delete")) {
    return undefined;
  }

  var_00 = 0;
  while(isDefined(self.var_9C20)) {
    wait(0.05);
    var_00++;
    if(var_00 > 5) {
      return undefined;
    }
  }

  var_01 = undefined;
  self.var_9C20 = 1;
  self.var_C1 = self.var_C1 + 1;
  for(var_02 = 0; var_02 < 5; var_02++) {
    var_01 = self _meth_8393();
    if(!isDefined(var_01)) {
      wait(0.05);
      continue;
    }

    break;
  }

  self.var_9C20 = undefined;
  return var_01;
}

func_10679(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = self.origin;
  }

  if(!isDefined(param_02)) {
    param_02 = self.angles;
  }

  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  wait(param_00);
  if(self.team == "allies" || self.team == "neutral") {
    var_03 = "axis";
  } else {
    var_03 = "allies";
  }

  return func_107D2(param_01, param_02, var_03, self);
}

func_F162() {
  self endon("death");
  self endon("seeker_unequipped");
  if(!level.player.var_F179.var_9076) {
    return;
  }

  thread func_F165();
  for(;;) {
    self waittill("grenade_pullback", var_00);
    if(var_00 != "seeker") {
      continue;
    }

    self.var_AF29 = undefined;
    childthread func_F161();
    self waittill("offhand_end");
    scripts\engine\utility::waitframe();
  }
}

func_F165() {
  self endon("death");
  self endon("stop_seeker_unequipped_think");
  self notify("seeker_unequipped_think");
  self endon("seeker_unequipped_think");
  self waittill("primary_equipment_change");
  if(!scripts\sp\utility::func_93A6()) {
    self enableoffhandsecondaryweapons();
  }

  self notify("seeker_unequipped");
}

func_F160() {
  scripts\engine\utility::waittill_either("offhand_end", "offhand_ammo");
  wait(0.05);
  if(isDefined(self.var_AF29)) {
    self.var_AF29 scripts\sp\utility::func_9193("default_seeker");
    self.var_AF29 = undefined;
  }
}

func_F161() {
  self endon("offhand_end");
  self endon("offhand_ammo");
  thread func_F160();
  wait(1.5);
  for(;;) {
    var_00 = func_F07D();
    if(isDefined(var_00)) {
      if(isDefined(self.var_AF29) && var_00 != self.var_AF29) {
        self.var_AF29 scripts\sp\utility::func_9193("default_seeker");
      }

      var_00 scripts\sp\utility::func_9196(1, 0, 0, "default_seeker");
      self.var_AF29 = var_00;
      wait(0.5);
    } else if(isDefined(self.var_AF29)) {
      self.var_AF29 scripts\sp\utility::func_9193("default_seeker");
    }

    scripts\engine\utility::waitframe();
  }
}

func_10793() {
  var_00 = func_F15A();
  var_00.var_C93D = 1;
  var_00 thread func_F159();
}

func_F159() {
  if(isDefined(self.var_C93D)) {
    self.team = "team3";
    if(isDefined(self.target)) {
      thread lib_0B77::worldpointinreticle_circle();
    }
  }

  self.var_F166 = "seeker_" + self.team;
  playFXOnTag(level.var_7649[self.var_F166], self, "tag_fx");
  self.var_BC = "no_cover";
  self.name = "";
  self.objective_state_nomessage = 0;
  self.a.var_5605 = 1;
  self.allowpain = 0;
  self.var_10264 = 1;
  self.var_28CF = 0;
  self.var_B5DD = 1;
  self.precacherumble = 1;
  self.var_5963 = 1;
  self.vectortoyaw = 8;
  self.vehicle_getarray = 8;
  self.maxsightdistsqrd = 0;
  self.target_alloc = 0;
  self.logstring = 0;
  self.disablebulletwhizbyreaction = 1;
  self.var_55EF = 1;
  self.var_F7 = 0;
  self.var_C012 = 1;
  self.var_2745 = [];
  self.var_2A4B = 1;
  self.var_733D = 0;
  self _meth_84E5(0);
  if(isDefined(self.var_C93D)) {
    self.ignoreme = 1;
  }

  if(self.triggerportableradarping == level.player) {
    self.health = 3000;
    thread scripts\sp\utility::func_B14F(1);
  } else {
    self.health = 50;
  }

  if(level.var_7683 == 0 && self.triggerportableradarping != level.player) {
    thread func_F169();
  }

  func_F13A();
  thread scripts\sp\utility::play_sound_on_entity("seeker_init");
  thread scripts\engine\utility::play_loop_sound_on_entity("seeker_seek_lp");
  thread func_BC0A();
  thread func_F137();
  thread func_F114();
  thread func_F12A();
  thread func_F115();
  thread func_6C95();
  if(self.triggerportableradarping == level.player) {
    thread func_F14C();
  }
}

func_F115() {
  scripts\engine\utility::waittill_either("death", "entitydeleted");
  if(isDefined(self.var_A481)) {
    self.var_A481 delete();
  }
}

func_F13A() {
  if(self.triggerportableradarping == level.player) {
    self.moveplaybackrate = 1;
    return;
  }

  if(level.var_7683 <= 1) {
    self.moveplaybackrate = 0.65;
    return;
  }

  self.moveplaybackrate = 0.75;
}

func_F114() {
  self endon("death");
  for(;;) {
    glassradiusdamage(self.origin, 25, 1000, 1000);
    scripts\engine\utility::waitframe();
  }
}

func_8BA7() {
  if(level.player hasweapon("seeker")) {
    return "current";
  }

  var_00 = scripts\sp\utility::func_7CAF();
  if(!isDefined(var_00)) {
    return "no";
  }

  if(var_00 == "seeker") {
    return "stored";
  }

  return "no";
}

func_F16B() {
  self endon("death");
  for(;;) {
    scripts\engine\utility::waitframe();
    var_00 = func_8BA7();
    if(var_00 == "no") {
      self notify("no_inventory");
      continue;
    }

    var_01 = 0;
    if(var_00 == "current") {
      var_01 = scripts\sp\utility::func_7BD7();
    } else if(var_00 == "stored") {
      var_01 = scripts\sp\utility::func_7CB0();
    }

    if(var_01 == 4) {
      self notify("max_ammo");
      continue;
    }
  }
}

func_F14C() {
  self endon("death");
  if(isDefined(self.var_C93D)) {
    return;
  }

  var_00 = 0;
  childthread func_F16B();
  for(;;) {
    scripts\engine\utility::waitframe();
    if(isDefined(self.var_3135.var_F15D) && self.var_3135.var_F15D != self.triggerportableradarping) {
      continue;
    }

    var_01 = func_8BA7();
    if(var_01 == "no") {
      continue;
    }

    var_02 = 0;
    if(var_01 == "current") {
      var_02 = scripts\sp\utility::func_7BD7();
    } else if(var_01 == "stored") {
      var_02 = scripts\sp\utility::func_7CB0();
    }

    if(var_02 == 4) {
      continue;
    }

    thread lib_0E46::func_48C4("tag_origin", (0, 0, 25), & "EQUIPMENT_SEEKER_RETRIEVE", undefined, 60, 50, undefined, undefined, undefined, & "hud_interaction_prompt_center_equipment", undefined, undefined, undefined, undefined, 90);
    var_00 = 1;
    var_03 = scripts\engine\utility::waittill_any_return("trigger", "max_ammo", "no_inventory", "set_bt_target");
    if(var_03 == "trigger") {
      break;
    } else {
      if(var_00) {
        lib_0E46::func_DFE3();
      }

      continue;
    }
  }

  playworldsound("player_refill_all_ammo", level.player.origin);
  var_01 = func_8BA7();
  var_02 = 0;
  if(var_01 == "current") {
    var_02 = scripts\sp\utility::func_7BD7();
    level.player setweaponammoclip("seeker", var_02 + 1);
  } else if(var_01 == "stored") {
    var_02 = scripts\sp\utility::func_7CB0();
    level.player.var_110BE++;
  }

  func_E084();
}

func_E084() {
  self.var_EA0E = 1;
  if(isDefined(self.var_F166)) {
    stopFXOnTag(level.var_7649[self.var_F166], self, "tag_fx");
    self.var_F166 = undefined;
  }

  if(isDefined(self.melee)) {
    self _meth_8484();
    if(isDefined(self.melee)) {
      if(isDefined(self.melee.target)) {
        self.melee.target.melee = undefined;
      }

      self.melee = undefined;
    }
  }

  self notify("stop soundseeker_target_acquire_lp");
  self notify("stop soundseeker_move_lp");
  self notify("stop soundseeker_move_servo_lp");
  level.var_F10A.var_1633 = scripts\engine\utility::array_remove(level.var_F10A.var_1633, self);
  if(isplayer(self.triggerportableradarping)) {
    var_00 = level.player func_7B02();
    if(!var_00.size) {
      level.var_F10A.var_5AE6 = undefined;
      level.player notify("stop_monitoring_doubletap");
    }
  }

  self delete();
}

func_F169() {
  level.player endon("death");
  for(;;) {
    if(!isalive(self)) {
      return;
    }

    if(isDefined(self.bt) && isDefined(self.var_3135.var_F15D)) {
      if(self.var_3135.var_F15D == level.player) {
        if(distance2dsquared(self.origin, level.player getorigin()) < squared(800)) {
          self.var_138F2 = newhudelem();
          var_00 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 30));
          var_00 linkto(self);
          self.var_138F2 setshader("hud_icon_grenade_incoming_seeker", 32, 32);
          self.var_138F2.color = (1, 1, 1);
          self.var_138F2.alpha = 1;
          self.var_138F2 setwaypoint(1, 1, 0);
          self.var_138F2 settargetent(var_00);
          scripts\engine\utility::waittill_either("jumped_on_player", "death");
          self.var_138F2 destroy();
          var_00 delete();
          return;
        }
      }
    }

    wait(0.05);
  }
}

func_F137() {
  if(isDefined(self.var_C93D) || isDefined(self.var_5967) && self.var_5967) {
    return;
  }

  if(self.team == "allies") {
    scripts\sp\utility::func_9196(3, 0, 0, "default_seeker");
    return;
  }

  if(self.team == "axis") {
    scripts\sp\utility::func_9196(1, 1, 1, "default_seeker");
  }
}

func_BC0A() {
  self endon("death");
  for(;;) {
    func_BC73();
    while(self.var_164D["seeker"].var_4BC0 != "run_loop") {
      wait(0.05);
    }

    func_BC72();
    while(self.var_164D["seeker"].var_4BC0 == "run_loop") {
      wait(0.05);
    }
  }
}

func_BC72() {
  self playSound("seeker_move_start", "sound_done");
  self waittill("sound_done");
  thread scripts\engine\utility::play_loop_sound_on_entity("seeker_move_lp");
  thread scripts\engine\utility::play_loop_sound_on_entity("seeker_move_servo_lp");
}

func_BC73() {
  self notify("stop soundseeker_move_lp");
  self notify("stop soundseeker_move_servo_lp");
  self playSound("seeker_move_end", "sound_done");
  self waittill("sound_done");
}

func_B9CD() {
  if(isDefined(self.var_C93D)) {
    return;
  }

  if(isDefined(level.var_F10A.var_5AE6)) {
    return;
  }

  level.var_F10A.var_5AE6 = 1;
  level.player endon("stop_monitoring_doubletap");
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

      func_2BCF(level.player);
      level.var_F10A.var_5AE6 = undefined;
      level.player notify("stop_monitoring_doubletap");
      return;
    }

    wait(0.05);
  }
}

func_2BCF(param_00) {
  foreach(var_02 in level.var_F10A.var_1633) {
    if(var_02.triggerportableradarping == param_00) {
      if(isDefined(var_02.var_9BB9)) {
        continue;
      }

      var_02.var_9BB9 = 1;
      var_02 thread func_F11E(1);
    }
  }
}

func_7B02() {
  var_00 = [];
  foreach(var_02 in level.var_F10A.var_1633) {
    if(var_02.triggerportableradarping == self) {
      if(isDefined(var_02.var_9BB9)) {
        continue;
      }

      var_00[var_00.size] = var_02;
    }
  }

  return var_00;
}

func_F11C() {
  self endon("seeker_detonate_finish");
  self.var_50EB = 1;
  wait(0.4);
  if(!isDefined(self) || isDefined(self.var_9BB9)) {
    return;
  }

  playworldsound("seeker_expl_beep", self.origin);
  wait(0.6);
  if(!isDefined(self) || isDefined(self.var_9BB9)) {
    return;
  }

  self.var_9BB9 = 1;
  thread func_F11E();
}

func_F11E(param_00, param_01, param_02) {
  if(isDefined(self)) {
    destroynavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor");
    if(isDefined(self.var_F166)) {
      stopFXOnTag(level.var_7649[self.var_F166], self, "tag_fx");
      self.var_F166 = undefined;
    }

    if(isDefined(self.var_EA0E)) {
      return;
    }

    if(!isDefined(param_00)) {
      thread func_F11D();
    }

    var_03 = self gettagorigin("j_body") + (0, 0, 2);
    if(isDefined(param_01)) {
      var_03 = param_01;
    }

    if(isDefined(self.triggerportableradarping) && level.player == self.triggerportableradarping) {
      var_04 = self.triggerportableradarping scripts\sp\detonategrenades::func_734E();
      self.triggerportableradarping scripts\engine\utility::delaythread(0.1, ::scripts\sp\detonategrenades::func_734D, var_03, var_04, level.var_F10A.var_4D19);
    }

    self notify("seeker_detonate_finish", var_03);
    self notify("stop soundseeker_target_acquire_lp");
    if(self.health > 0 || isDefined(param_02)) {
      if(isalive(self) && isDefined(self)) {
        self.objective_team = "seeker_expl";
        self getuniqueobjectid(var_03, (0, 0, 0), 0);
      } else {
        magicgrenademanual("seeker_expl", var_03, (0, 0, 0), 0);
      }

      if(isalive(self)) {
        self hide();
      }

      wait(0.1);
      physicsexplosionsphere(var_03, 1000, 100, 2);
      thread scripts\sp\detonategrenades::func_DBDB(var_03 + (0, 0, 5), 0.2);
      earthquake(0.5, 0.8, var_03, 250);
      thread scripts\sp\utility::func_54EF(var_03);
      thread func_F110(250, var_03);
      wait(0.5);
      if(!isDefined(self)) {
        return;
      }

      if(isDefined(self.var_B14F)) {
        scripts\sp\utility::func_1101B();
      }

      if(isalive(self)) {
        self _meth_81D0();
      }

      self delete();
    }

    wait(0.75);
  }
}

func_F129(param_00) {
  var_01 = getaiarray("axis", "allies");
  var_01[var_01.size] = level.player;
  var_02 = [];
  foreach(var_04 in var_01) {
    if(distance(param_00, var_04.origin) <= level.var_F10A.var_4D19) {
      var_02[var_02.size] = var_04;
    }
  }

  foreach(var_04 in var_02) {
    if(isplayer(var_04) && scripts\sp\detonategrenades::func_385D(param_00)) {
      func_57BB(param_00, var_04);
    }

    if(scripts\sp\detonategrenades::func_385C(param_00, var_04)) {
      func_57BB(param_00, var_04);
    }
  }
}

func_57BB(param_00, param_01) {
  var_02 = distance2d(param_01.origin, param_00);
  var_03 = scripts\sp\math::func_C097(0, level.var_F10A.var_4D19, var_02);
  var_04 = scripts\sp\math::func_6A8E(level.var_F10A.var_4D0C, level.var_F10A.var_4D02, var_03);
  if(isDefined(param_01.unittype)) {
    var_05 = tolower(param_01.unittype);
    if(var_05 == "c6") {
      var_04 = var_04 * 3;
    } else if(var_05 == "c8") {
      var_04 = var_04 * 3;
    } else if(var_05 == "c12") {
      var_04 = var_04 * 3;
    }
  }

  param_01 dodamage(var_04, self.origin, self, self, "MOD_EXPLOSIVE", "seeker");
}

func_F11D() {
  scripts\engine\utility::play_sound_in_space("seeker_expl_beep", self.origin);
}

func_F110(param_00, param_01) {
  if(level.player scripts\sp\utility::func_65DB("no_grenade_block_gesture") || level.player isthrowinggrenade() || level.player func_8448()) {
    return;
  }

  var_02 = distance2dsquared(level.player.origin, param_01);
  if(var_02 > squared(param_00)) {
    return;
  }

  if(var_02 > squared(param_00 * 0.25)) {
    var_03 = vectordot(scripts\engine\utility::flatten_vector(vectornormalize(param_01 - level.player.origin)), anglesToForward(level.player.angles));
    if(var_03 < 0) {
      return;
    }
  }

  if(!scripts\common\trace::ray_trace_passed(param_01 + (0, 0, 12), level.player getEye(), undefined, scripts\common\trace::create_world_contents())) {
    return;
  }

  level.player thread func_F155(param_01);
}

func_F155(param_00) {
  self endon("death");
  var_01 = scripts\engine\utility::spawn_tag_origin(param_00, (0, 0, 0));
  thread scripts\engine\utility::delete_on_death(var_01);
  var_02 = "ges_frag_block";
  var_03 = self playgestureviewmodel(var_02, var_01, 1, 0.1);
  if(var_03) {
    childthread lib_0E49::func_D092(var_02, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4);
    for(;;) {
      self waittill("gesture_stopped", var_02);
      if(var_02 == "ges_frag_block") {
        break;
      }
    }
  }

  var_01 delete();
}

func_F14D(param_00) {
  if(param_00) {
    if(isDefined(self.triggerportableradarping) && !isplayer(self.triggerportableradarping)) {
      return;
    }

    if(isDefined(self.var_C93D)) {
      return;
    }

    if(isDefined(self.var_9BB9)) {
      return;
    }

    if(isDefined(level.var_F14D)) {
      return;
    }

    level.var_F14D = 1;
    self.var_CBA0 = scripts\engine\utility::spawn_tag_origin();
    thread scripts\engine\utility::delete_on_death(self.var_CBA0);
    thread func_CBA1();
    thread func_F14E();
    var_01 = (0, 0, 0);
    var_02 = (0, 0, 0);
    scripts\sp\pip::func_CBB5(self.var_CBA0, "tag_origin", 40, var_01, var_02);
    return;
  }

  scripts\sp\pip::func_CBA3();
  level.var_F14D = undefined;
}

func_F14E() {
  self endon("death");
  for(;;) {
    if(isDefined(self.var_9BB9)) {
      setomnvar("ui_pip_message_text_top", "equipment_seeker_top");
      setomnvar("ui_pip_message_text_bottom", "equipment_seeker_blownup");
      setomnvar("ui_pip_message_type", 3);
    } else if(self.var_3135.var_1152B) {
      setomnvar("ui_pip_message_text_top", "equipment_seeker_top");
      setomnvar("ui_pip_message_text_bottom", "equipment_seeker_locked");
      setomnvar("ui_pip_message_type", 3);
    } else if(isDefined(self.var_3135.var_F15D) && self.var_3135.var_F15D == self.triggerportableradarping) {
      setomnvar("ui_pip_message_text_top", "equipment_seeker_top");
      setomnvar("ui_pip_message_text_bottom", "equipment_seeker_idle");
      setomnvar("ui_pip_message_type", 1);
    } else {
      setomnvar("ui_pip_message_text_top", "equipment_seeker_top");
      setomnvar("ui_pip_message_text_bottom", "equipment_seeker_searching");
      setomnvar("ui_pip_message_type", 2);
    }

    scripts\engine\utility::waitframe();
  }
}

func_CBA1() {
  scripts\engine\utility::waitframe();
  var_00 = spawnturret("misc_turret", self.origin, "seeker_camera");
  var_00 setModel("tag_turret");
  var_00 setdefaultdroppitch(0);
  var_00 give_player_session_tokens("manual");
  var_00 makeunusable();
  var_00.var_9FF0 = 1;
  var_00 _meth_82C9(0, "yaw");
  var_00 _meth_82C9(0, "pitch");
  var_01 = (2, 0, 7);
  if(isDefined(self.var_37B3)) {
    var_01 = var_01 + self.var_37B3;
  }

  var_00 linkto(self, "j_spine4", var_01, (0, 0, 0));
  var_02 = scripts\engine\utility::spawn_tag_origin();
  var_03 = scripts\engine\utility::spawn_tag_origin();
  var_00 settargetentity(var_03);
  self.var_CBA0 linkto(var_00, "tag_flash", (0, 0, 0), (0, 0, 0));
  while(isalive(self)) {
    if(isDefined(self.var_7260)) {
      var_03 linkto(self.var_7260, "tag_origin", (0, 0, 0), (0, 0, 0));
      continue;
    }

    if(isDefined(self.melee) && isDefined(self.melee.var_312F) && self.melee.var_312F && isalive(self.melee.target)) {
      if(isDefined(self.var_2479)) {
        var_03 linkto(self.melee.target, "tag_eye", (0, 0, 0), (0, 0, 0));
      } else {
        var_03 linkto(self.melee.target, "j_neck", (0, 0, 0), (0, 0, 0));
      }

      continue;
    }

    if(isalive(self.var_3135.var_F15D) && self getpersstat(self.var_3135.var_F15D) || self.var_3135.var_1152B) {
      var_03 linkto(self.var_3135.var_F15D, "tag_eye", (0, 0, 0), (0, 0, 0));
      continue;
    }

    var_03 linkto(self, "tag_eye", (50, 0, 2), (0, 0, 0));
    wait(0.05);
  }

  var_02 delete();
  var_03 delete();
  var_00 delete();
}

func_CBA2(param_00, param_01) {
  var_02 = scripts\sp\math::func_10AAE(10, param_00.origin, (0, 0, 0));
  while(isalive(self) && isDefined(param_01)) {
    var_03 = scripts\sp\math::func_10AB4(var_02, param_01.origin, param_00.origin);
    param_00.origin = var_03;
    scripts\engine\utility::waitframe();
  }

  scripts\sp\math::func_10AAA(var_02);
}

func_F11B(param_00) {}

func_6C95() {
  self endon("death");
  self.var_733D = 0;
  for(;;) {
    var_00 = getclosestpointonnavmesh(self.origin, self);
    var_01 = distancesquared(var_00, self.origin);
    if(var_01 <= squared(15)) {
      self.var_733D = 1;
      return;
    }

    wait(0.05);
  }
}

func_7C41(param_00) {
  if(!isDefined(self.var_728A) && !self.var_733D) {
    return undefined;
  }

  var_01 = gettime();
  if(self.var_3135.var_1152B || self.var_3135.var_1154B > 0 && self.var_3135.var_1154B + 700 > var_01) {
    return self.var_3135.var_F15D;
  }

  if(isDefined(self.var_EA0E) || isDefined(self.var_C93D) || isDefined(self.var_50EB) || isDefined(self.var_9BB9) || !isDefined(self.var_3135.var_652A)) {
    return undefined;
  }

  if(!isDefined(self.var_3135.var_9882)) {
    return undefined;
  }

  if(scripts\engine\utility::flag_exist("stealth_enabled") && scripts\engine\utility::flag("stealth_enabled")) {
    if(isalive(self.triggerportableradarping) && self.triggerportableradarping scripts\sp\utility::func_65DF("stealth_attack") && !self.triggerportableradarping scripts\sp\utility::func_65DB("stealth_attack")) {
      return undefined;
    }
  }

  if(isDefined(self.loadstartpointtransients)) {
    return self.loadstartpointtransients;
  }

  if(isDefined(self.var_728A)) {
    return self.var_728A;
  }

  var_02 = getaiunittypearray(self.var_3135.var_652A, "all");
  if(self.var_3135.var_652A == "allies") {
    if(lib_0F3D::func_B575(self.unittype)) {
      var_02 = scripts\engine\utility::array_add(var_02, level.player);
    }
  }

  var_03 = 1200;
  var_04 = 100;
  var_05 = [];
  foreach(var_07 in var_02) {
    if(var_07.ignoreme || !isalive(var_07) || isDefined(var_07.var_C012)) {
      continue;
    }

    if(isDefined(var_07.var_2023)) {
      continue;
    }

    if(scripts\engine\utility::array_contains(self.var_2745, var_07)) {
      continue;
    }

    if(isalive(self.triggerportableradarping)) {
      var_08 = distancesquared(self.triggerportableradarping.origin, var_07.origin);
      if(var_08 < squared(var_04) || var_08 > squared(var_03)) {
        continue;
      }
    }

    var_05 = scripts\engine\utility::array_add(var_05, var_07);
  }

  if(!var_05.size) {
    if(isalive(self.triggerportableradarping)) {
      return self.triggerportableradarping;
    } else {
      return undefined;
    }
  }

  if(var_05.size == 1) {
    if(isDefined(var_05[0]) && isalive(var_05[0])) {
      return var_05[0];
    }
  }

  var_0A = undefined;
  if(self.triggerportableradarping == level.player) {
    var_0A = level.player func_797E();
  }

  var_0B = cos(45);
  var_0C = 400;
  var_0D = 0;
  var_0E = undefined;
  var_0F = 1;
  foreach(var_11 in var_05) {
    var_12 = var_0F;
    if(isDefined(var_11.unittype)) {
      if(var_11.unittype == "c6" || var_11.unittype == "c6i") {
        var_12 = var_12 * 0.99;
      } else if(var_11.unittype == "c8") {
        var_12 = var_12 * 0.98;
      } else if(var_11.unittype == "c12") {
        var_12 = var_12 * 0.2;
      }
    }

    if(isplayer(var_11)) {
      var_12 = var_12 * 0.99;
    }

    if(isDefined(var_11.var_F126) && var_11.var_F126 != self) {
      var_12 = var_12 * 0.5;
    }

    if(param_00) {
      var_08 = distancesquared(self.origin, var_11.origin);
      if(isDefined(self.var_3135.var_F15D) && self.var_3135.var_F15D == var_11) {
        var_12 = var_12 * 2;
        var_13 = 1 - scripts\sp\math::func_C097(0, squared(var_0C), var_08);
        var_12 = var_12 * var_13 + 0.5;
      } else if(var_08 > squared(var_0C)) {
        var_12 = 0;
      } else {
        var_13 = 1 - scripts\sp\math::func_C097(0, squared(var_0C), var_08);
        var_12 = var_12 * var_13 + 0.5;
      }
    } else {
      if(self.triggerportableradarping == level.player) {
        if(isDefined(var_0A) && var_0A == var_11) {
          var_12 = var_12 * 3;
        }

        var_14 = scripts\sp\utility::func_7951(level.player getEye(), level.player getplayerangles(), var_11.origin);
        var_15 = scripts\sp\math::func_DF68(var_14, var_0B, 1, 0, 1);
        var_12 = var_12 * var_15;
      } else if(self.var_3135.var_652A == "axis") {
        if(isDefined(level.player.damageattacker) && issentient(level.player.damageattacker) && isalive(level.player.damageattacker)) {
          var_12 = var_12 * 2;
        }
      } else if(isDefined(self.triggerportableradarping.sethalfresparticles) && issentient(self.triggerportableradarping.sethalfresparticles) && isalive(self.triggerportableradarping.sethalfresparticles)) {
        var_12 = var_12 * 2;
      }

      var_08 = distancesquared(self.origin, var_11.origin);
      var_13 = 1 - scripts\sp\math::func_C097(squared(var_04), squared(var_03), var_08);
      var_12 = var_12 * var_13 + 0.5;
    }

    if(!isDefined(var_0E) || var_12 > var_0D) {
      var_0E = var_11;
      var_0D = var_12;
    }
  }

  return var_0E;
}

func_F07D() {
  var_00 = getaiunittypearray("axis", "all");
  var_01 = 100;
  var_02 = [];
  foreach(var_04 in var_00) {
    if(var_04.ignoreme || !isalive(var_04)) {
      continue;
    }

    var_05 = distancesquared(self.origin, var_04.origin);
    if(var_05 < squared(var_01)) {
      continue;
    }

    var_02 = scripts\engine\utility::array_add(var_02, var_04);
  }

  if(!var_02.size) {
    return undefined;
  }

  if(var_02.size == 1) {
    if(isDefined(var_02[0]) && isalive(var_02[0])) {
      return var_02[0];
    }
  }

  var_07 = func_797E();
  if(isDefined(var_07)) {
    return var_07;
  }

  var_08 = cos(45);
  var_09 = 800;
  var_0A = 400;
  var_0B = 0;
  var_0C = undefined;
  var_0D = 1;
  foreach(var_0F in var_02) {
    var_10 = var_0D;
    if(isDefined(var_0F.var_F126) && var_0F.var_F126 != self) {
      var_10 = var_10 * 0.5;
    }

    var_11 = scripts\sp\utility::func_7951(level.player getEye(), level.player getplayerangles(), var_0F.origin);
    var_12 = scripts\sp\math::func_DF68(var_11, var_08, 1, 0, 1);
    var_10 = var_10 * var_12;
    var_05 = distancesquared(self.origin, var_0F.origin);
    var_13 = 1 - scripts\sp\math::func_C097(squared(var_01), squared(var_09), var_05);
    var_10 = var_10 * var_13 + 0.5;
    if(!isDefined(var_0C) || var_10 > var_0B) {
      var_0C = var_0F;
      var_0B = var_10;
    }
  }

  return var_0C;
}

func_797E() {
  var_00 = vectornormalize(anglesToForward(self.angles));
  var_01 = self.origin + var_00 * 10000;
  var_02 = scripts\common\trace::ray_trace(self getEye(), var_01, self);
  if(isDefined(var_02["entity"])) {
    if(issentient(var_02["entity"])) {
      if(isenemyteam(self.team, var_02["entity"].team)) {
        var_03 = var_02["entity"];
        return var_03;
      }

      return;
    }

    return undefined;
  }
}

func_7981(param_00, param_01) {
  if(isalive(self.triggerportableradarping)) {
    return undefined;
  }

  param_01 = scripts\engine\utility::ter_op(isDefined(param_01), param_01, 2000);
  param_00 = sortbydistance(param_00, self.origin);
  foreach(var_03 in param_00) {
    var_04 = distancesquared(self.triggerportableradarping.origin, var_03.origin);
    if(func_56EF(var_04, param_01)) {
      if(isalive(var_03)) {
        return var_03;
      }
    }
  }

  return undefined;
}

func_56EF(param_00, param_01) {
  param_01 = scripts\engine\utility::ter_op(isDefined(param_01), param_01, 800);
  if(param_00 <= param_01 * param_01 && param_00 >= level.var_F10A.var_4D19 * level.var_F10A.var_4D19) {
    return 1;
  }

  return 0;
}