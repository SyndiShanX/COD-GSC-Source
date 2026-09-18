/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1375.gsc
*********************************************/

init() {
  level.var_A41["zombie_boss_village"] = level.var_A41["zombie"];
  level.var_A41["zombie_boss_village"]["spawn"] = ::func_AB7D;
  level.var_A41["zombie_boss_village"]["think"] = ::func_AB7E;
  level.var_A41["zombie_boss_village"]["move_mode"] = ::func_AB6C;
  level.var_A41["zombie_boss_village"]["post_model"] = ::func_AB6F;
  level.var_A41["zombie_boss_village"]["on_damaged"] = ::func_AB6D;
  level.var_A41["zombie_boss_village"]["on_killed"] = ::func_AB6E;
  level.var_A41["zombie_boss_village"]["tesla_delayed_dmg"] = ::zombie_boss_village_tesla_delayed_dmg;
  var_00 = spawnStruct();
  var_00.var_A4B = "zombie_boss_village";
  var_00.var_EAE = "zombie_boss_animclass";
  var_00.var_879 = "zombie_boss";
  var_00.var_5ED2["default look"]["whole_body"] = "zom_brute_b_base";
  var_00.var_1144["whole_body"] = "zom_klaus_wholebody";
  var_00.var_4C12 = 1;
  var_00.var_60E2 = 30;
  var_00.var_8302 = 200;
  var_00.var_8303 = 60;
  var_00.parenttype = "zombie_generic";
  if(isDefined(level.var_62AB)) {
    var_00 = [[level.var_62AB]](var_00);
  }

  lib_0547::func_A52(var_00, "zombie_boss_village");
  level.animtree_lookup["zombie_boss"] = #animtree;
  level.var_5A8A = [];
  var_01 = function_027A("mp/zombieKlausActionTable.csv");
  for(var_02 = 0; var_02 < var_01; var_02++) {
    var_03 = tablelookupbyrow("mp/zombieKlausActionTable.csv", var_02, 1);
    var_04 = strtok(tablelookupbyrow("mp/zombieKlausActionTable.csv", var_02, 2), " ");
    if(isDefined(var_03) && var_03 != "") {
      level.var_5A8A[var_03] = var_04;
    }
  }

  level._effect["zmb_brute_drool"] = loadfx("vfx/zombie/zmb_brute_drool");
}

func_AB6D(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(param_01) || param_05 == "turretweapon_zeppelin_gun_zm" && common_scripts\utility::func_562E(self.var_A87C)) {
    return;
  }

  param_01 thread maps\mp\gametypes\_damagefeedback::func_A102("standard");
  self notify("brute_boss_damage", param_02, param_05);
}

func_AB6E(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  lib_054D::func_6BD4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}

func_AB6C() {
  if(self.var_8BA4 && !isDefined(self.var_1928) && !common_scripts\utility::func_562E(self.var_9E1B)) {
    return "run";
  }

  return "walk";
}

zombie_boss_village_tesla_delayed_dmg(param_00, param_01, param_02) {
  return param_00;
}

func_AB65(param_00, param_01) {
  func_7678(param_00, 0, param_01);
}

func_AB66(param_00, param_01) {
  func_7678(param_00, 0, param_01, 0, undefined, undefined, ::func_1CC3, "attack");
}

func_1CC3(param_00) {
  self notify("brute_smash_starting");
  self endon("brute_smash_starting");
  var_01 = "";
  while(var_01 != param_00) {
    self waittill("scripted_anim", var_01);
  }

  var_02 = self gettagorigin("J_Wrist_RI");
  playFX(level._effect["zmb_brute_slam"], var_02, anglesToForward(self.angles), anglestoup(self.angles));
  foreach(var_04 in level.players) {
    var_05 = distance(self.origin, var_04.origin);
    if(var_05 < 1) {
      var_05 = 1;
    }

    if(var_05 <= 192) {
      var_04 shellshock("frag_grenade_mp", 1.25);
      var_04 dodamage(150 / var_05 + 30, self.origin, self, self, "MOD_GRENADE");
    }
  }
}

func_AB67(param_00, param_01) {
  func_7678(param_00, 0, param_01, 0, undefined, undefined, ::func_1CC3, "attack");
}

func_AB63(param_00, param_01) {
  func_7678(param_00, 0, param_01);
}

func_AB62(param_00, param_01) {
  func_7678(param_00, 0, param_01);
}

func_AB68(param_00, param_01, param_02) {
  func_7678(param_00, 0, undefined, 1, param_01, param_02);
}

func_AB69(param_00) {
  self notify("show an uber battery");
  self endon("returning to arena");
  var_01 = common_scripts\utility::func_46B7("brute_exit_destination", "targetname");
  var_02 = common_scripts\utility::func_4461(self.origin, var_01);
  self.var_1928 = var_02;
  var_03 = common_scripts\utility::func_46B7("brute_roar_point", "targetname");
  var_04 = 1;
  while(var_04) {
    foreach(var_06 in var_03) {
      if(distance(self.origin, var_06.origin) < 128) {
        var_04 = 0;
        break;
      }
    }

    wait(0.15);
  }

  func_7678("brute_roar_leaving");
}

func_AB64(param_00) {
  self notify("returning to arena");
  var_01 = common_scripts\utility::func_46B7("brute_exit_destination", "targetname");
  var_02 = func_44C9(var_01, 256);
  if(var_02.size > 0) {
    var_03 = common_scripts\utility::random(var_02);
  } else {
    var_03 = common_scripts\utility::random(var_02);
  }

  self setOrigin(var_03.origin + (0, 0, 8));
  self.angles = var_03.angles;
  var_04 = common_scripts\utility::func_46B5("final_brute_boss", "targetname");
  self.var_1928 = var_04;
  self.var_9E1B = 1;
  self waittill("traverse_end");
  self.var_9E1B = 0;
  self.var_1928 = undefined;
  func_AB75();
}

func_AB7B() {
  func_AB7A();
  self waittill("brute_unstunned", var_00, var_01);
  return [var_00, var_01];
}

func_AB6A(param_00, param_01) {
  thread func_A6B5(param_01);
  func_7678(param_00, 0, undefined, 1, "brute_stunned", param_01);
  self.var_3ACE setHintString(&"ZOMBIES_EMPTY_STRING");
}

func_AB79() {
  self notify("set brute behavior", "scripted_brute_exit_traversal");
}

func_AB72() {
  self notify("set brute behavior", "scripted_brute_entrance_traversal");
}

func_AB74() {
  self notify("set brute behavior", "brute_standing_attack");
}

func_AB76() {
  self notify("set brute behavior", "brute_hulk_smash");
}

func_AB77() {
  self notify("set brute behavior", "brute_hulk_smash_180");
}

func_AB71() {
  self notify("set brute behavior", "brute_standing_attack_180");
}

func_AB73() {
  self notify("set brute behavior", "brute_walking_attack");
}

func_AB78() {
  self notify("set brute behavior", "brute_idle");
}

func_AB7A() {
  self notify("set brute behavior", "brute_stun_start");
}

func_AB75() {
  self notify("set brute behavior", "brute_unlock_state");
}

func_A6AD() {
  self waittill("set brute behavior", var_00);
  return var_00;
}

func_27A2(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.var_95AA = param_00;
  var_03.var_73D7 = param_01;
  var_03.var_AC1A = param_02;
  return var_03;
}

func_AB70() {
  self endon("death");
  thread func_115A();
  var_00 = 200;
  var_01 = var_00;
  var_02 = var_00;
  var_03 = 10000;
  var_04 = 150;
  var_05 = func_27A2("J_Mid_LE_3", var_01, var_02);
  var_06 = func_27A2("J_Mid_RI_3", var_01, var_02);
  var_07 = func_27A2("tag_origin", var_03, var_04);
  var_08 = [var_05, var_06];
  var_09 = common_scripts\utility::func_F73(var_08, [var_07]);
  var_0A = ["brute_unlock_state", "scripted_brute_exit_traversal", "scripted_brute_entrance_traversal", "brute_idle", "brute_stun_start"];
  var_0B = 0;
  var_0C = "";
  wait 0.05;
  func_7678("brute_roar_recovering", 0, undefined);
  for(;;) {
    var_0D = func_A6AD();
    self.var_AB5C = var_0D;
    if(var_0B && common_scripts\utility::func_F79(var_0A, var_0D)) {
      self notify("brute behavior was unlocked");
      var_0B = 0;
    }

    if(!var_0B) {
      switch (var_0D) {
        case "brute_walking_attack":
          var_0E = spawnStruct();
          var_0E.var_596D = var_09;
          var_0E.var_67E9 = "stop charge damage";
          if(common_scripts\utility::func_562E(self.var_8BA4)) {
            var_0D = "brute_running_attack";
          }

          childthread func_AB62(var_0D, var_0E);
          break;

        case "brute_stun_start":
          var_0B = 1;
          var_0C = "stunned";
          childthread func_AB6A(var_0D, "brute_unstunned");
          break;

        case "brute_idle":
          var_0B = 1;
          var_0C = "waiting";
          childthread func_AB68(var_0D, "brute_idle", "scripted_brute_entrance_traversal");
          break;

        case "scripted_brute_exit_traversal":
          var_0B = 1;
          var_0C = "leaving";
          childthread func_AB69(var_0D);
          break;

        case "scripted_brute_entrance_traversal":
          var_0B = 1;
          var_0C = "returning";
          childthread func_AB64(var_0D);
          break;

        case "brute_standing_attack":
          var_0E = spawnStruct();
          var_0E.var_596D = var_08;
          var_0E.var_67E9 = "stop forward swing";
          childthread func_AB65(var_0D, var_0E);
          break;

        case "brute_hulk_smash":
          var_0E = spawnStruct();
          var_0E.var_596D = var_08;
          var_0E.var_67E9 = "stop ground pound";
          childthread func_AB66(var_0D, var_0E);
          break;

        case "brute_hulk_smash_180":
          var_0E = spawnStruct();
          var_0E.var_596D = var_08;
          var_0E.var_67E9 = "stop ground pound_180";
          childthread func_AB67(var_0D, var_0E);
          break;

        case "brute_standing_attack_180":
          var_0E = spawnStruct();
          var_0E.var_596D = var_09;
          var_0E.var_67E9 = "stop backhand swing";
          childthread func_AB63(var_0D, var_0E);
          break;
      }

      continue;
    }
  }
}

func_7678(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self notify("brute_change_actions");
  self endon("brute_change_actions");
  self endon("death");
  if(self.var_A4B != "zombie_boss_village") {
    return;
  }

  var_08 = param_00;
  var_09 = maps / mp / agents / _scripted_agent_anim_util::func_434D(var_08);
  var_0A = self method_83DB(var_09);
  var_0B = randomint(var_0A);
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  self scragentsetscripted(1);
  self.updatepathwhenscripted = 1;
  if(common_scripts\utility::func_562E(param_01)) {
    self method_839D("noclip");
  } else {
    self method_839D("gravity");
  }

  if(isDefined(param_02)) {
    foreach(var_0D in param_02.var_596D) {
      childthread func_3203(var_0D, param_02.var_67E9);
    }
  }

  if(isDefined(param_06)) {
    self childthread[[param_06]](param_07);
  }

  if(!common_scripts\utility::func_562E(param_03)) {
    maps / mp / agents / _scripted_agent_anim_util::func_71FA(var_09, var_0B, 1, "scripted_anim");
  } else {
    func_309A(param_00, param_04, param_05);
  }

  if(common_scripts\utility::func_562E(param_01)) {
    self method_839D("gravity");
  }

  if(isDefined(param_02)) {
    self notify(param_02.var_67E9);
  }

  self scragentsetscripted(0);
  self notify("brute finished scripted state");
}

func_309A(param_00, param_01, param_02) {
  self endon("death");
  var_03 = func_43FA(param_00);
  var_04 = spawnStruct();
  var_04.var_8B58 = 0;
  childthread func_49E8(var_04, param_02);
  self.var_55A6 = 1;
  for(var_05 = 0; var_05 < var_03.size; var_05++) {
    var_06 = var_03[var_05];
    var_07 = maps / mp / agents / _scripted_agent_anim_util::func_434D(var_06);
    var_08 = maps / mp / agents / _scripted_agent_anim_util::func_7A35(var_07);
    if(var_03[var_05] == param_01) {
      childthread maps / mp / agents / _scripted_agent_anim_util::func_71FA(var_07, var_08, 1, "scripted_anim");
      while(!var_04.var_8B58) {
        lib_0547::func_A6F6();
      }

      continue;
    }

    maps / mp / agents / _scripted_agent_anim_util::func_71FA(var_07, var_08, 1, "scripted_anim");
  }

  self.var_55A6 = 0;
}

func_49E8(param_00, param_01) {
  self waittill(param_01);
  param_00.var_8B58 = 1;
}

func_1CB8() {
  self endon("death");
  var_00 = 0;
  if(common_scripts\utility::func_562E(self.var_55A6) || maps / mp / agents / _scripted_agent_anim_util::func_57E2()) {
    return 0;
  }

  var_01 = func_40E4();
  if(var_01.var_8F15 || var_01.var_6895 > 0) {
    if(var_01.var_6891 > var_01.var_687E) {
      if(common_scripts\utility::func_24A6()) {
        func_AB74();
      } else {
        func_AB76();
      }
    } else {
      func_AB77();
    }

    var_00 = 1;
  } else if(var_01.var_6895 > 0 && var_01.var_6891 < var_01.var_687E) {
    func_AB71();
    var_00 = 1;
  } else if(var_01.var_688D > 0 && var_01.var_6891 > 0) {
    if(func_1CC7()) {
      func_AB73();
      var_00 = 1;
    } else {
      var_00 = 0;
    }
  }

  return var_00;
}

func_1CC5() {
  wait(4);
  for(;;) {
    wait(0.1);
    var_00 = func_40E4();
    if(var_00.var_688D + var_00.var_6897 == func_6873() && !common_scripts\utility::func_562E(self.var_8BA4)) {
      if(!common_scripts\utility::func_562E(self.var_203F)) {
        thread func_93BF(5);
      }

      continue;
    }

    if(self.var_8BA4 && var_00.var_6895 > 0) {
      thread func_1F35();
    }
  }
}

func_93BF(param_00) {
  self endon("cancel_brute_run");
  self.var_8BA4 = 1;
  wait(param_00);
  self.var_8BA4 = 0;
  self.var_203F = 1;
  wait(4);
  self.var_203F = 0;
}

func_1F35() {
  self notify("cancel_brute_run");
  self.var_8BA4 = 0;
}

func_40E4() {
  var_00 = spawnStruct();
  var_00.var_8F15 = 0;
  var_00.var_6897 = 0;
  var_00.var_6895 = 0;
  var_00.var_688D = 0;
  var_00.var_6891 = 0;
  var_00.var_687E = 0;
  foreach(var_02 in level.players) {
    if(distance(var_02.origin, self.origin) < 50) {
      var_00.var_8F15 = 1;
    } else if(distance(var_02.origin, self.origin) < 256) {
      var_00.var_6895++;
    } else if(distance(var_02.origin, self.origin) < 768) {
      var_00.var_688D++;
    } else {
      var_00.var_6897++;
    }

    if(var_02 lib_053C::func_5724(self)) {
      var_00.var_6891++;
      continue;
    }

    var_00.var_687E++;
  }

  var_00.var_6873 = func_6873();
  return var_00;
}

func_6873() {
  var_00 = 0;
  foreach(var_02 in level.players) {
    if(isalive(var_02) && !var_02.var_5378) {
      var_00++;
    }
  }

  return var_00;
}

func_115A() {
  var_00 = getEntArray("nest_brute_uber_inserts", "targetname");
  while(self.model == "tag_origin") {
    wait 0.05;
  }

  foreach(var_02 in var_00) {
    var_02 show();
    var_02.origin = self gettagorigin(var_02.script_noteworthy) + func_425D(var_02.script_noteworthy);
    var_02 linktoblendtotag(self, var_02.script_noteworthy);
  }

  var_00 thread func_1CCD(self);
}

func_425D(param_00) {
  var_01 = (0, 0, 0);
  switch (param_00) {
    case "J_Knee_LE":
      var_01 = (8, 8, -8);
      break;

    case "J_Knee_RI":
      var_01 = (-8, -8, -8);
      break;

    case "J_SpineLower":
      var_01 = (0, 16, 0);
      break;
  }

  return var_01;
}

func_1CCD(param_00) {
  var_01 = [undefined, undefined, undefined];
  foreach(var_03 in self) {
    var_01[var_03.var_8140 - 1] = var_03;
    var_03 method_8511();
  }

  param_00.var_1CCF = var_01;
  foreach(var_03 in var_01) {
    param_00 waittill("show an uber battery");
    var_03 show();
    playFXOnTag(level._effect["gk_raven_hc_ee_uber_attached"], var_03, "tag_origin");
    var_03 lib_0378::func_8D74("uber_battery_spawn");
  }
}

func_44C9(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_00) {
    foreach(var_06 in level.players) {
      if(distance(var_04.origin, var_06.origin) < param_01) {
        var_02 = common_scripts\utility::func_F6F(var_02, var_04);
      }
    }
  }

  return var_02;
}

func_43FA(param_00) {
  var_01 = [];
  switch (param_00) {
    case "brute_stun_start":
      var_01 = ["brute_stun_start", "brute_stunned", "brute_stun_end", "brute_roar_leaving"];
      break;

    case "brute_idle":
      var_01 = ["brute_idle"];
      break;

    default:
      break;
  }

  return var_01;
}

func_A6B5(param_00) {
  wait(2.25);
  thread func_94BF(2, param_00);
  self endon(param_00);
  var_01 = undefined;
  for(var_02 = 0; !var_02; var_02 = var_01 lib_0585::func_9E12("Blimp Battery Hunt")) {
    self.var_3ACE setHintString(&"ZOMBIE_NEST_PLACE_UBER");
    self.var_3ACE waittill("trigger", var_01);
  }

  self notify(param_00, 1, var_01);
}

func_1CC6() {
  level thread maps\mp\_utility::func_6F74(::func_A0EB, self);
}

func_A0EB(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  param_00 endon("death");
  func_863C(param_00.var_3ACE, self, 0);
  for(;;) {
    var_01 = common_scripts\utility::waittill_any_return("uber_gained", "uber_lost");
    if(!isalive(self)) {
      continue;
    }

    if(var_01 == "uber_gained") {
      if(lib_0586::func_72C3()) {
        func_863C(param_00.var_3ACE, self, 1);
      }

      continue;
    }

    if(var_01 == "uber_lost") {
      func_863C(param_00.var_3ACE, self, 0);
    }
  }
}

func_863C(param_00, param_01, param_02) {
  if(isDefined(param_00)) {
    param_00[[common_scripts\utility::func_98E7(param_02, ::enableplayeruse, ::disableplayeruse)]](param_01);
  }
}

func_94BF(param_00, param_01) {
  self endon(param_01);
  if(level.players.size == 1) {
    param_00 = param_00 + 3;
  }

  lib_0555::func_83DD("brute_stun");
  while(param_00 > 0) {
    param_00--;
    wait(1);
  }

  lib_0555::func_83DD("brute_awake");
  self notify(param_01, 0);
}

func_1CC7(param_00) {
  if(func_A271(self)) {
    return 1;
  }

  return 0;
}

func_3203(param_00, param_01) {
  self endon("brute_change_actions");
  self endon(param_01);
  self endon("death");
  var_02 = [];
  var_03 = param_00.var_95AA;
  var_04 = param_00.var_73D7;
  var_05 = param_00.var_AC1A;
  for(;;) {
    var_06 = [];
    if(var_05 > 0) {
      var_07 = lib_0547::func_408F();
      var_07 = common_scripts\utility::func_F93(var_07, self);
      var_06 = common_scripts\utility::func_F73(var_06, var_07);
    }

    if(var_04 > 0) {
      var_06 = common_scripts\utility::func_F73(var_06, level.players);
    }

    foreach(var_09 in var_06) {
      var_0A = common_scripts\utility::func_98E7(isPlayer(var_09), var_04, var_05);
      var_0B = self gettagorigin(var_03);
      if(!common_scripts\utility::func_F79(var_02, var_09) && distance(var_0B, var_09.origin) < 64) {
        var_09 dodamage(var_0A, var_0B, self, self, "MOD_IMPACT");
        var_02 = common_scripts\utility::func_F6F(var_02, var_09);
      }
    }

    wait 0.05;
  }
}

func_AB6B(param_00) {
  var_01 = self;
  var_01 endon("death");
  var_02 = var_01 method_8445(param_00);
  if(var_02 == -1) {
    return;
  }

  var_03 = spawnStruct();
  var_03.origin = var_01 gettagorigin(param_00);
  var_03.angles = var_01.angles;
  var_03.var_2F74 = 1;
  var_04 = spawnStruct();
  var_04.var_2434 = 30;
  var_04.var_60C1 = 60;
  var_04.var_3A20 = 90;
  var_04.var_1B70 = 82;
  var_01 childthread lib_0547::tackle_thread(var_03, var_04);
  for(;;) {
    wait(0.1);
    if(!isDefined(var_01.var_AB5C)) {
      continue;
    }

    var_03.origin = var_01 gettagorigin(param_00);
    var_03.angles = var_01.angles;
    var_03.var_2F74 = !common_scripts\utility::func_F79(["scripted_brute_exit_traversal", "scripted_brute_entrance_traversal", "brute_standing_attack", "brute_standing_attack_180", "brute_walking_attack", "brute_up_stairs", "brute_down_stairs"], var_01.var_AB5C);
  }
}

func_AB6F() {
  foreach(var_01 in ["j_ball_le", "j_ball_ri"]) {
    thread func_AB6B(var_01);
  }
}

func_AB7D(param_00, param_01, param_02) {
  lib_054D::func_6BD7(param_00, param_01, param_02);
  self.var_90DC = "zombie_boss_village";
}

func_AB7C() {
  var_00 = 48;
  var_01 = 200;
  self method_856C(var_00, var_01);
  self.height = var_01;
  self.radius = var_00;
  self method_85A1("zombie_boss_village");
  self method_84D4();
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self.var_6816 = 1;
  self.var_56EB = 1;
  if(!common_scripts\utility::func_562E(level.var_AC14)) {
    thread func_AB70();
  }

  self.var_5D5F = 1;
  self.var_57E8 = 1;
  self.var_8BA4 = 0;
  self.var_1DEB = 1;
  self method_839F(func_4399());
  thread func_AB5B();
  thread func_1CBE();
}

func_1CBE() {
  wait 0.05;
  playFXOnTag(level._effect["zmb_brute_drool"], self, "J_Head");
}

func_AB5B() {
  var_00 = "tag_origin";
  var_01 = lib_0547::func_A51("zombie_boss_village");
  var_02 = spawn("script_model", self.origin);
  var_02 setModel(var_01.var_1144["whole_body"]);
  var_02.angles = self gettagangles(var_00);
  var_02 linkTo(self, var_00);
  self.var_5A9C = var_02;
  self.var_1142 = ::func_84F1;
}

func_84F1(param_00, param_01, param_02, param_03) {
  if(!isDefined(self) || !isDefined(self.var_5A9C)) {
    return;
  }

  self notify("set_klaus_state");
  self endon("set_klaus_state");
  var_04 = param_00;
  if(!isDefined(param_01)) {
    var_05 = self method_83D9();
    var_06 = self method_83DB(param_00);
    for(var_07 = 0; var_07 < var_06; var_07++) {
      var_08 = self method_83D9(param_00, var_07);
      if(var_08 == var_05) {
        param_01 = var_07;
        break;
      }
    }
  }

  if(isDefined(self.var_5A9C.var_EE8) && self.var_5A9C.var_EE8 == var_04 && isDefined(self.var_5A9C.var_EC1) && self.var_5A9C.var_EC1 == param_01) {
    return;
  }

  var_09 = undefined;
  var_0A = level.var_5A8A[var_04][param_01];
  wait 0.05;
  self.var_5A9C scriptmodelclearanim();
  self.var_5A9C scriptmodelplayanim(var_0A);
  self.var_5A9C.var_EE8 = var_04;
  self.var_5A9C.var_EC4 = var_0A;
  self.var_5A9C.var_EC1 = param_01;
}

func_AB7E() {
  func_AB7C();
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  lib_0566::func_ABB5();
  var_00 = 0.2;
  childthread func_1CC5();
  self.var_117D = 4;
  self.var_1F0F = 1;
  for(;;) {
    wait(var_00);
    var_01 = isDefined(self.var_92EA) && gettime() * 0.001 < self.var_92EA;
    self.var_50C5 = common_scripts\utility::func_562E(self.var_54F4) || var_01;
    if(self.var_1F0F && !self.var_50C5) {
      if(self.var_117D < 0 && func_1CB8()) {
        thread func_1160(2);
        continue;
      } else if(self.var_117D > 0) {
        self.var_117D = self.var_117D - var_00;
      }
    }

    if(lib_053C::func_4F9B()) {
      continue;
    }

    if(lib_053C::func_4F9A()) {
      continue;
    }

    lib_053C::func_647();
  }
}

func_1160(param_00) {
  self.var_1F0F = 0;
  self.var_117D = param_00;
  common_scripts\utility::waittill_any("brute finished scripted state", "brute behavior was unlocked");
  self.var_1F0F = 1;
}

func_5725(param_00) {
  var_01 = 65536;
  var_02 = 65536;
  var_03 = self.angles;
  var_04 = self gettagorigin("tag_origin");
  var_05 = var_04 + var_03 * 1000;
  if(!isDefined(param_00) || !isalive(param_00)) {
    return 0;
  }

  var_06 = param_00.origin + (0, 0, 64);
  var_07 = distancesquared(var_04, var_06);
  if(var_07 > var_01) {
    return 0;
  }

  var_08 = vectorNormalize(var_06 - var_04);
  var_09 = vectordot(var_03, var_08);
  if(0 > var_09) {
    return 0;
  }

  var_0A = pointonsegmentnearesttopoint(var_04, var_05, var_06);
  if(distancesquared(var_06, var_0A) > var_02) {
    return 0;
  }

  if(0 == param_00 method_81D7(var_04, self)) {
    return 0;
  }

  if(var_07 < var_01) {
    return 1;
  }

  return 0;
}

func_A271(param_00) {
  var_01 = (0, 0, 16);
  var_02 = 650;
  var_03 = 5;
  var_04 = [];
  var_05 = [];
  var_06 = func_A01F(param_00.angles);
  var_07 = 0;
  var_08 = var_02 / var_03;
  var_09 = 0;
  var_0A = [];
  for(var_0B = 0; var_0B < var_03; var_0B++) {
    if(var_0B > 0) {
      var_0C = var_04[var_0B - 1] + var_01;
    } else {
      var_0C = param_00.origin + var_01;
    }

    var_0D = var_0C + var_06 * var_08;
    var_0E = getclosestpointonnavmesh(var_0D, param_00) + var_01;
    var_0F = func_6CC9(var_0D, var_0E);
    var_10 = bulletTrace(var_0C, var_0F, 0);
    var_04 = common_scripts\utility::func_F6F(var_04, var_0F);
    if(var_10["fraction"] != 1) {
      var_07 = 1;
      break;
    }
  }

  return !var_07;
}

func_A01F(param_00) {
  var_01 = anglesToForward(param_00);
  var_01 = common_scripts\utility::func_3D5D(var_01);
  var_01 = vectorNormalize(var_01);
  return var_01;
}

func_6CC9(param_00, param_01) {
  return (param_00[0], param_00[1], param_01[2]);
}

func_4399() {
  var_00 = 0.15;
  var_01 = var_00 * 3.14 * 2 * 0.05;
  return var_01;
}