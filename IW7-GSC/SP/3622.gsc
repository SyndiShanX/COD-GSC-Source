/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3622.gsc
*********************************************/

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

func_F135(var_0) {
  if(level.var_F10A.var_1633.size >= level.var_F10A.var_B41A) {
    func_A5FB();
  }

  var_1 = undefined;
  if(self == level.player && isDefined(level.player.var_AF29)) {
    var_1 = level.player.var_AF29;
    level.player.var_AF29 = undefined;
  }

  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_0.origin;
  var_2 linkto(var_0);
  var_2.objective_position = var_0;
  level.var_F10A.var_162D[level.var_F10A.var_162D.size] = var_2;
  var_0 thread func_F136();
  var_3 = var_2.objective_position scripts\engine\utility::waittill_any_return("missile_stuck", "death", "entitydeleted");
  if(!isDefined(var_2.objective_position)) {
    var_2 thread func_E085();
    return;
  }

  if(var_3 == "missile_stuck") {
    func_107D1(var_2, undefined, undefined, var_1);
  }

  if(level.player.var_F179.var_45BF) {
    level thread func_B9CD();
  }

  var_2 thread func_E085();
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
  var_0 = undefined;
  var_1 = 0;
  foreach(var_3 in level.var_F10A.var_1633) {
    if(var_1 == 0 || var_3.starttime < var_1) {
      var_1 = var_3.starttime;
      var_0 = var_3;
    }
  }

  if(isDefined(var_0)) {
    var_0.var_EA0E = 1;
    if(isDefined(var_0.var_F166)) {
      stopFXOnTag(level.var_7649[var_0.var_F166], var_0, "tag_fx");
    }

    if(isDefined(var_0.var_B14F)) {
      var_0 scripts\sp\utility::func_1101B();
    }

    playFXOnTag(level.var_7649["seeker_sparks"], var_0, "tag_fx");
    playworldsound("seeker_expire", var_0.origin);
    var_0 hudoutlinedisable();
    var_0 func_81D0();
  }
}

func_DFC1() {
  level notify("removing_all_seekers_instantly");
  level endon("removing_all_seekers_instantly");
  scripts\engine\utility::flag_set("seeker_force_delete");
  foreach(var_1 in level.var_F10A.var_162D) {
    var_1 thread func_E085();
  }

  foreach(var_4 in level.var_F10A.var_1633) {
    var_4 thread func_E084();
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

func_107D1(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_4 = getclosestpointonnavmesh(var_0.origin, undefined, 1);
  var_5 = distancesquared(var_4, var_0.origin);
  if(var_5 > squared(250)) {
    return;
  }

  var_6 = getspawner("actor_ally_equipment_seeker", "classname");
  var_6.origin = var_0.origin;
  if(isDefined(var_2)) {
    var_6.origin = var_6.origin + var_2;
  }

  var_6.angles = self.angles;
  var_6.var_C1 = var_6.var_C1 + 1;
  var_7 = var_6 func_F15A();
  if(!isDefined(var_7)) {
    return;
  }

  var_7.owner = self;
  if(isDefined(var_1) && var_1 == 1) {
    var_7.var_C93D = 1;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "no_expire") {
    self.var_595E = 1;
  }

  if(!isDefined(var_7.var_C93D)) {
    var_7.team = var_7.owner.team;
  }

  self.var_F10A = var_7;
  if(isDefined(var_3)) {
    var_7.loadstartpointtransients = var_3;
  }

  var_7 thread func_F159();
  if(isDefined(level.var_F10A.var_4C74)) {
    var_7 thread[[level.var_F10A.var_4C74]]();
  }

  level.var_F10A.var_1633[level.var_F10A.var_1633.size] = var_7;
  return var_7;
}

func_107D2(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getspawner("actor_ally_equipment_seeker", "classname");
  var_5.origin = var_0;
  var_5.angles = var_1;
  var_5.var_C1 = var_5.var_C1 + 1;
  var_6 = var_5 func_F15A();
  if(!isDefined(var_6)) {
    return;
  }

  var_6.owner = var_6;
  var_6.team = var_2;
  if(isDefined(var_3)) {
    var_6.var_728A = var_3;
  }

  if(isDefined(var_4)) {
    var_6.var_5967 = var_4;
  }

  var_6 thread func_F159();
  level.var_F10A.var_1633[level.var_F10A.var_1633.size] = var_6;
  return var_6;
}

func_F12A() {
  self endon("death");
  var_0 = 0;
  var_1 = 5;
  for(;;) {
    if(!self islinked()) {
      var_2 = self func_812B();
      if(var_2 == "none") {
        var_0++;
        if(var_0 > 4 * var_1) {
          self delete();
        }
      } else {
        var_0 = 0;
      }
    } else {
      var_0 = 0;
    }

    wait(0.25);
  }
}

func_F15A() {
  level endon("seeker_force_delete");
  if(scripts\engine\utility::flag("seeker_force_delete")) {
    return undefined;
  }

  var_0 = 0;
  while(isDefined(self.var_9C20)) {
    wait(0.05);
    var_0++;
    if(var_0 > 5) {
      return undefined;
    }
  }

  var_1 = undefined;
  self.var_9C20 = 1;
  self.var_C1 = self.var_C1 + 1;
  for(var_2 = 0; var_2 < 5; var_2++) {
    var_1 = self func_8393();
    if(!isDefined(var_1)) {
      wait(0.05);
      continue;
    }

    break;
  }

  self.var_9C20 = undefined;
  return var_1;
}

func_10679(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  wait(var_0);
  if(self.team == "allies" || self.team == "neutral") {
    var_3 = "axis";
  } else {
    var_3 = "allies";
  }

  return func_107D2(var_1, var_2, var_3, self);
}

func_F162() {
  self endon("death");
  self endon("seeker_unequipped");
  if(!level.player.var_F179.var_9076) {
    return;
  }

  thread func_F165();
  for(;;) {
    self waittill("grenade_pullback", var_0);
    if(var_0 != "seeker") {
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
    var_0 = func_F07D();
    if(isDefined(var_0)) {
      if(isDefined(self.var_AF29) && var_0 != self.var_AF29) {
        self.var_AF29 scripts\sp\utility::func_9193("default_seeker");
      }

      var_0 scripts\sp\utility::func_9196(1, 0, 0, "default_seeker");
      self.var_AF29 = var_0;
      wait(0.5);
    } else if(isDefined(self.var_AF29)) {
      self.var_AF29 scripts\sp\utility::func_9193("default_seeker");
    }

    scripts\engine\utility::waitframe();
  }
}

func_10793() {
  var_0 = func_F15A();
  var_0.var_C93D = 1;
  var_0 thread func_F159();
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
  self func_84E5(0);
  if(isDefined(self.var_C93D)) {
    self.ignoreme = 1;
  }

  if(self.owner == level.player) {
    self.health = 3000;
    thread scripts\sp\utility::func_B14F(1);
  } else {
    self.health = 50;
  }

  if(level.var_7683 == 0 && self.owner != level.player) {
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
  if(self.owner == level.player) {
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
  if(self.owner == level.player) {
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

  var_0 = scripts\sp\utility::func_7CAF();
  if(!isDefined(var_0)) {
    return "no";
  }

  if(var_0 == "seeker") {
    return "stored";
  }

  return "no";
}

func_F16B() {
  self endon("death");
  for(;;) {
    scripts\engine\utility::waitframe();
    var_0 = func_8BA7();
    if(var_0 == "no") {
      self notify("no_inventory");
      continue;
    }

    var_1 = 0;
    if(var_0 == "current") {
      var_1 = scripts\sp\utility::func_7BD7();
    } else if(var_0 == "stored") {
      var_1 = scripts\sp\utility::func_7CB0();
    }

    if(var_1 == 4) {
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

  var_0 = 0;
  childthread func_F16B();
  for(;;) {
    scripts\engine\utility::waitframe();
    if(isDefined(self.bt.var_F15D) && self.bt.var_F15D != self.owner) {
      continue;
    }

    var_1 = func_8BA7();
    if(var_1 == "no") {
      continue;
    }

    var_2 = 0;
    if(var_1 == "current") {
      var_2 = scripts\sp\utility::func_7BD7();
    } else if(var_1 == "stored") {
      var_2 = scripts\sp\utility::func_7CB0();
    }

    if(var_2 == 4) {
      continue;
    }

    thread lib_0E46::func_48C4("tag_origin", (0, 0, 25), &"EQUIPMENT_SEEKER_RETRIEVE", undefined, 60, 50, undefined, undefined, undefined, &"hud_interaction_prompt_center_equipment", undefined, undefined, undefined, undefined, 90);
    var_0 = 1;
    var_3 = scripts\engine\utility::waittill_any_return("trigger", "max_ammo", "no_inventory", "set_bt_target");
    if(var_3 == "trigger") {
      break;
    } else {
      if(var_0) {
        lib_0E46::func_DFE3();
      }

      continue;
    }
  }

  playworldsound("player_refill_all_ammo", level.player.origin);
  var_1 = func_8BA7();
  var_2 = 0;
  if(var_1 == "current") {
    var_2 = scripts\sp\utility::func_7BD7();
    level.player setweaponammoclip("seeker", var_2 + 1);
  } else if(var_1 == "stored") {
    var_2 = scripts\sp\utility::func_7CB0();
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
    self func_8484();
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
  if(isPlayer(self.owner)) {
    var_0 = level.player func_7B02();
    if(!var_0.size) {
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

    if(isDefined(self.bt) && isDefined(self.bt.var_F15D)) {
      if(self.bt.var_F15D == level.player) {
        if(distance2dsquared(self.origin, level.player getorigin()) < squared(800)) {
          self.var_138F2 = newhudelem();
          var_0 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 30));
          var_0 linkto(self);
          self.var_138F2 setshader("hud_icon_grenade_incoming_seeker", 32, 32);
          self.var_138F2.color = (1, 1, 1);
          self.var_138F2.alpha = 1;
          self.var_138F2 setwaypoint(1, 1, 0);
          self.var_138F2 settargetent(var_0);
          scripts\engine\utility::waittill_either("jumped_on_player", "death");
          self.var_138F2 destroy();
          var_0 delete();
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

      func_2BCF(level.player);
      level.var_F10A.var_5AE6 = undefined;
      level.player notify("stop_monitoring_doubletap");
      return;
    }

    wait(0.05);
  }
}

func_2BCF(var_0) {
  foreach(var_2 in level.var_F10A.var_1633) {
    if(var_2.owner == var_0) {
      if(isDefined(var_2.var_9BB9)) {
        continue;
      }

      var_2.var_9BB9 = 1;
      var_2 thread func_F11E(1);
    }
  }
}

func_7B02() {
  var_0 = [];
  foreach(var_2 in level.var_F10A.var_1633) {
    if(var_2.owner == self) {
      if(isDefined(var_2.var_9BB9)) {
        continue;
      }

      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
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

func_F11E(var_0, var_1, var_2) {
  if(isDefined(self)) {
    destroynavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor");
    if(isDefined(self.var_F166)) {
      stopFXOnTag(level.var_7649[self.var_F166], self, "tag_fx");
      self.var_F166 = undefined;
    }

    if(isDefined(self.var_EA0E)) {
      return;
    }

    if(!isDefined(var_0)) {
      thread func_F11D();
    }

    var_3 = self gettagorigin("j_body") + (0, 0, 2);
    if(isDefined(var_1)) {
      var_3 = var_1;
    }

    if(isDefined(self.owner) && level.player == self.owner) {
      var_4 = self.owner scripts\sp\detonategrenades::func_734E();
      self.owner scripts\engine\utility::delaythread(0.1, scripts\sp\detonategrenades::func_734D, var_3, var_4, level.var_F10A.var_4D19);
    }

    self notify("seeker_detonate_finish", var_3);
    self notify("stop soundseeker_target_acquire_lp");
    if(self.health > 0 || isDefined(var_2)) {
      if(isalive(self) && isDefined(self)) {
        self.grenadeweapon = "seeker_expl";
        self getuniqueobjectid(var_3, (0, 0, 0), 0);
      } else {
        magicgrenademanual("seeker_expl", var_3, (0, 0, 0), 0);
      }

      if(isalive(self)) {
        self hide();
      }

      wait(0.1);
      physicsexplosionsphere(var_3, 1000, 100, 2);
      thread scripts\sp\detonategrenades::func_DBDB(var_3 + (0, 0, 5), 0.2);
      earthquake(0.5, 0.8, var_3, 250);
      thread scripts\sp\utility::func_54EF(var_3);
      thread func_F110(250, var_3);
      wait(0.5);
      if(!isDefined(self)) {
        return;
      }

      if(isDefined(self.var_B14F)) {
        scripts\sp\utility::func_1101B();
      }

      if(isalive(self)) {
        self func_81D0();
      }

      self delete();
    }

    wait(0.75);
  }
}

func_F129(var_0) {
  var_1 = getaiarray("axis", "allies");
  var_1[var_1.size] = level.player;
  var_2 = [];
  foreach(var_4 in var_1) {
    if(distance(var_0, var_4.origin) <= level.var_F10A.var_4D19) {
      var_2[var_2.size] = var_4;
    }
  }

  foreach(var_4 in var_2) {
    if(isPlayer(var_4) && scripts\sp\detonategrenades::func_385D(var_0)) {
      func_57BB(var_0, var_4);
    }

    if(scripts\sp\detonategrenades::func_385C(var_0, var_4)) {
      func_57BB(var_0, var_4);
    }
  }
}

func_57BB(var_0, var_1) {
  var_2 = distance2d(var_1.origin, var_0);
  var_3 = scripts\sp\math::func_C097(0, level.var_F10A.var_4D19, var_2);
  var_4 = scripts\sp\math::func_6A8E(level.var_F10A.var_4D0C, level.var_F10A.var_4D02, var_3);
  if(isDefined(var_1.unittype)) {
    var_5 = tolower(var_1.unittype);
    if(var_5 == "c6") {
      var_4 = var_4 * 3;
    } else if(var_5 == "c8") {
      var_4 = var_4 * 3;
    } else if(var_5 == "c12") {
      var_4 = var_4 * 3;
    }
  }

  var_1 dodamage(var_4, self.origin, self, self, "MOD_EXPLOSIVE", "seeker");
}

func_F11D() {
  scripts\engine\utility::play_sound_in_space("seeker_expl_beep", self.origin);
}

func_F110(var_0, var_1) {
  if(level.player scripts\sp\utility::func_65DB("no_grenade_block_gesture") || level.player isthrowinggrenade() || level.player func_8448()) {
    return;
  }

  var_2 = distance2dsquared(level.player.origin, var_1);
  if(var_2 > squared(var_0)) {
    return;
  }

  if(var_2 > squared(var_0 * 0.25)) {
    var_3 = vectordot(scripts\engine\utility::flatten_vector(vectornormalize(var_1 - level.player.origin)), anglesToForward(level.player.angles));
    if(var_3 < 0) {
      return;
    }
  }

  if(!scripts\common\trace::ray_trace_passed(var_1 + (0, 0, 12), level.player getEye(), undefined, scripts\common\trace::create_world_contents())) {
    return;
  }

  level.player thread func_F155(var_1);
}

func_F155(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0, (0, 0, 0));
  thread scripts\engine\utility::delete_on_death(var_1);
  var_2 = "ges_frag_block";
  var_3 = self playgestureviewmodel(var_2, var_1, 1, 0.1);
  if(var_3) {
    childthread lib_0E49::func_D092(var_2, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4);
    for(;;) {
      self waittill("gesture_stopped", var_2);
      if(var_2 == "ges_frag_block") {
        break;
      }
    }
  }

  var_1 delete();
}

func_F14D(var_0) {
  if(var_0) {
    if(isDefined(self.owner) && !isPlayer(self.owner)) {
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
    var_1 = (0, 0, 0);
    var_2 = (0, 0, 0);
    scripts\sp\pip::func_CBB5(self.var_CBA0, "tag_origin", 40, var_1, var_2);
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
    } else if(self.bt.var_1152B) {
      setomnvar("ui_pip_message_text_top", "equipment_seeker_top");
      setomnvar("ui_pip_message_text_bottom", "equipment_seeker_locked");
      setomnvar("ui_pip_message_type", 3);
    } else if(isDefined(self.bt.var_F15D) && self.bt.var_F15D == self.owner) {
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
  var_0 = spawnturret("misc_turret", self.origin, "seeker_camera");
  var_0 setModel("tag_turret");
  var_0 setdefaultdroppitch(0);
  var_0 give_player_session_tokens("manual");
  var_0 makeunusable();
  var_0.var_9FF0 = 1;
  var_0 func_82C9(0, "yaw");
  var_0 func_82C9(0, "pitch");
  var_1 = (2, 0, 7);
  if(isDefined(self.var_37B3)) {
    var_1 = var_1 + self.var_37B3;
  }

  var_0 linkto(self, "j_spine4", var_1, (0, 0, 0));
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_0 settargetentity(var_3);
  self.var_CBA0 linkto(var_0, "tag_flash", (0, 0, 0), (0, 0, 0));
  while(isalive(self)) {
    if(isDefined(self.var_7260)) {
      var_3 linkto(self.var_7260, "tag_origin", (0, 0, 0), (0, 0, 0));
      continue;
    }

    if(isDefined(self.melee) && isDefined(self.melee.var_312F) && self.melee.var_312F && isalive(self.melee.target)) {
      if(isDefined(self.var_2479)) {
        var_3 linkto(self.melee.target, "tag_eye", (0, 0, 0), (0, 0, 0));
      } else {
        var_3 linkto(self.melee.target, "j_neck", (0, 0, 0), (0, 0, 0));
      }

      continue;
    }

    if(isalive(self.bt.var_F15D) && self cansee(self.bt.var_F15D) || self.bt.var_1152B) {
      var_3 linkto(self.bt.var_F15D, "tag_eye", (0, 0, 0), (0, 0, 0));
      continue;
    }

    var_3 linkto(self, "tag_eye", (50, 0, 2), (0, 0, 0));
    wait(0.05);
  }

  var_2 delete();
  var_3 delete();
  var_0 delete();
}

func_CBA2(var_0, var_1) {
  var_2 = scripts\sp\math::func_10AAE(10, var_0.origin, (0, 0, 0));
  while(isalive(self) && isDefined(var_1)) {
    var_3 = scripts\sp\math::func_10AB4(var_2, var_1.origin, var_0.origin);
    var_0.origin = var_3;
    scripts\engine\utility::waitframe();
  }

  scripts\sp\math::func_10AAA(var_2);
}

func_F11B(var_0) {}

func_6C95() {
  self endon("death");
  self.var_733D = 0;
  for(;;) {
    var_0 = getclosestpointonnavmesh(self.origin, self);
    var_1 = distancesquared(var_0, self.origin);
    if(var_1 <= squared(15)) {
      self.var_733D = 1;
      return;
    }

    wait(0.05);
  }
}

func_7C41(var_0) {
  if(!isDefined(self.var_728A) && !self.var_733D) {
    return undefined;
  }

  var_1 = gettime();
  if(self.bt.var_1152B || self.bt.var_1154B > 0 && self.bt.var_1154B + 700 > var_1) {
    return self.bt.var_F15D;
  }

  if(isDefined(self.var_EA0E) || isDefined(self.var_C93D) || isDefined(self.var_50EB) || isDefined(self.var_9BB9) || !isDefined(self.bt.var_652A)) {
    return undefined;
  }

  if(!isDefined(self.bt.var_9882)) {
    return undefined;
  }

  if(scripts\engine\utility::flag_exist("stealth_enabled") && scripts\engine\utility::flag("stealth_enabled")) {
    if(isalive(self.owner) && self.owner scripts\sp\utility::func_65DF("stealth_attack") && !self.owner scripts\sp\utility::func_65DB("stealth_attack")) {
      return undefined;
    }
  }

  if(isDefined(self.loadstartpointtransients)) {
    return self.loadstartpointtransients;
  }

  if(isDefined(self.var_728A)) {
    return self.var_728A;
  }

  var_2 = getaiunittypearray(self.bt.var_652A, "all");
  if(self.bt.var_652A == "allies") {
    if(lib_0F3D::func_B575(self.unittype)) {
      var_2 = scripts\engine\utility::array_add(var_2, level.player);
    }
  }

  var_3 = 1200;
  var_4 = 100;
  var_5 = [];
  foreach(var_7 in var_2) {
    if(var_7.ignoreme || !isalive(var_7) || isDefined(var_7.var_C012)) {
      continue;
    }

    if(isDefined(var_7.var_2023)) {
      continue;
    }

    if(scripts\engine\utility::array_contains(self.var_2745, var_7)) {
      continue;
    }

    if(isalive(self.owner)) {
      var_8 = distancesquared(self.owner.origin, var_7.origin);
      if(var_8 < squared(var_4) || var_8 > squared(var_3)) {
        continue;
      }
    }

    var_5 = scripts\engine\utility::array_add(var_5, var_7);
  }

  if(!var_5.size) {
    if(isalive(self.owner)) {
      return self.owner;
    } else {
      return undefined;
    }
  }

  if(var_5.size == 1) {
    if(isDefined(var_5[0]) && isalive(var_5[0])) {
      return var_5[0];
    }
  }

  var_10 = undefined;
  if(self.owner == level.player) {
    var_10 = level.player func_797E();
  }

  var_11 = cos(45);
  var_12 = 400;
  var_13 = 0;
  var_14 = undefined;
  var_15 = 1;
  foreach(var_11 in var_5) {
    var_12 = var_15;
    if(isDefined(var_11.unittype)) {
      if(var_11.unittype == "c6" || var_11.unittype == "c6i") {
        var_12 = var_12 * 0.99;
      } else if(var_11.unittype == "c8") {
        var_12 = var_12 * 0.98;
      } else if(var_11.unittype == "c12") {
        var_12 = var_12 * 0.2;
      }
    }

    if(isPlayer(var_11)) {
      var_12 = var_12 * 0.99;
    }

    if(isDefined(var_11.var_F126) && var_11.var_F126 != self) {
      var_12 = var_12 * 0.5;
    }

    if(var_0) {
      var_8 = distancesquared(self.origin, var_11.origin);
      if(isDefined(self.bt.var_F15D) && self.bt.var_F15D == var_11) {
        var_12 = var_12 * 2;
        var_13 = 1 - scripts\sp\math::func_C097(0, squared(var_12), var_8);
        var_12 = var_12 * var_13 + 0.5;
      } else if(var_8 > squared(var_12)) {
        var_12 = 0;
      } else {
        var_13 = 1 - scripts\sp\math::func_C097(0, squared(var_12), var_8);
        var_12 = var_12 * var_13 + 0.5;
      }
    } else {
      if(self.owner == level.player) {
        if(isDefined(var_10) && var_10 == var_11) {
          var_12 = var_12 * 3;
        }

        var_14 = scripts\sp\utility::func_7951(level.player getEye(), level.player getplayerangles(), var_11.origin);
        var_15 = scripts\sp\math::func_DF68(var_14, var_11, 1, 0, 1);
        var_12 = var_12 * var_15;
      } else if(self.bt.var_652A == "axis") {
        if(isDefined(level.player.damageattacker) && issentient(level.player.damageattacker) && isalive(level.player.damageattacker)) {
          var_12 = var_12 * 2;
        }
      } else if(isDefined(self.owner.sethalfresparticles) && issentient(self.owner.sethalfresparticles) && isalive(self.owner.sethalfresparticles)) {
        var_12 = var_12 * 2;
      }

      var_8 = distancesquared(self.origin, var_11.origin);
      var_13 = 1 - scripts\sp\math::func_C097(squared(var_4), squared(var_3), var_8);
      var_12 = var_12 * var_13 + 0.5;
    }

    if(!isDefined(var_14) || var_12 > var_13) {
      var_14 = var_11;
      var_13 = var_12;
    }
  }

  return var_14;
}

func_F07D() {
  var_0 = getaiunittypearray("axis", "all");
  var_1 = 100;
  var_2 = [];
  foreach(var_4 in var_0) {
    if(var_4.ignoreme || !isalive(var_4)) {
      continue;
    }

    var_5 = distancesquared(self.origin, var_4.origin);
    if(var_5 < squared(var_1)) {
      continue;
    }

    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  if(!var_2.size) {
    return undefined;
  }

  if(var_2.size == 1) {
    if(isDefined(var_2[0]) && isalive(var_2[0])) {
      return var_2[0];
    }
  }

  var_7 = func_797E();
  if(isDefined(var_7)) {
    return var_7;
  }

  var_8 = cos(45);
  var_9 = 800;
  var_10 = 400;
  var_11 = 0;
  var_12 = undefined;
  var_13 = 1;
  foreach(var_15 in var_2) {
    var_10 = var_13;
    if(isDefined(var_15.var_F126) && var_15.var_F126 != self) {
      var_10 = var_10 * 0.5;
    }

    var_11 = scripts\sp\utility::func_7951(level.player getEye(), level.player getplayerangles(), var_15.origin);
    var_12 = scripts\sp\math::func_DF68(var_11, var_8, 1, 0, 1);
    var_10 = var_10 * var_12;
    var_5 = distancesquared(self.origin, var_15.origin);
    var_13 = 1 - scripts\sp\math::func_C097(squared(var_1), squared(var_9), var_5);
    var_10 = var_10 * var_13 + 0.5;
    if(!isDefined(var_12) || var_10 > var_11) {
      var_12 = var_15;
      var_11 = var_10;
    }
  }

  return var_12;
}

func_797E() {
  var_0 = vectornormalize(anglesToForward(self.angles));
  var_1 = self.origin + var_0 * 10000;
  var_2 = scripts\common\trace::ray_trace(self getEye(), var_1, self);
  if(isDefined(var_2["entity"])) {
    if(issentient(var_2["entity"])) {
      if(isenemyteam(self.team, var_2["entity"].team)) {
        var_3 = var_2["entity"];
        return var_3;
      }

      return;
    }

    return undefined;
  }
}

func_7981(var_0, var_1) {
  if(isalive(self.owner)) {
    return undefined;
  }

  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 2000);
  var_0 = sortbydistance(var_0, self.origin);
  foreach(var_3 in var_0) {
    var_4 = distancesquared(self.owner.origin, var_3.origin);
    if(func_56EF(var_4, var_1)) {
      if(isalive(var_3)) {
        return var_3;
      }
    }
  }

  return undefined;
}

func_56EF(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 800);
  if(var_0 <= var_1 * var_1 && var_0 >= level.var_F10A.var_4D19 * level.var_F10A.var_4D19) {
    return 1;
  }

  return 0;
}