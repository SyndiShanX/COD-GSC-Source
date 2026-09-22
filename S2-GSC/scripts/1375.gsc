/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1375.gsc
**************************************/

#using_animtree("zombie_boss");

init() {
  level._id_0A41["zombie_boss_village"] = level._id_0A41["zombie"];
  level._id_0A41["zombie_boss_village"]["spawn"] = ::_id_AB7D;
  level._id_0A41["zombie_boss_village"]["think"] = ::_id_AB7E;
  level._id_0A41["zombie_boss_village"]["move_mode"] = ::_id_AB6C;
  level._id_0A41["zombie_boss_village"]["post_model"] = ::_id_AB6F;
  level._id_0A41["zombie_boss_village"]["on_damaged"] = ::_id_AB6D;
  level._id_0A41["zombie_boss_village"]["on_killed"] = ::_id_AB6E;
  level._id_0A41["zombie_boss_village"]["tesla_delayed_dmg"] = ::zombie_boss_village_tesla_delayed_dmg;
  var_0 = spawnStruct();
  var_0._id_0A4B = "zombie_boss_village";
  var_0._id_0EAE = "zombie_boss_animclass";
  var_0._id_0879 = "zombie_boss";
  var_0._id_5ED2["default look"]["whole_body"] = "zom_brute_b_base";
  var_0._id_1144["whole_body"] = "zom_klaus_wholebody";
  var_0._id_4C12 = 1.0;
  var_0._id_60E2 = 30;
  var_0._id_8302 = 200;
  var_0._id_8303 = 60;
  var_0.parenttype = "zombie_generic";

  if(isDefined(level._id_62AB)) {
    var_0 = [[level._id_62AB]](var_0);
  }

  _id_0547::_id_0A52(var_0, "zombie_boss_village");
  level.animtree_lookup["zombie_boss"] = #animtree;
  level._id_5A8A = [];
  var_1 = _tablegetrowcount("mp/zombieKlausActionTable.csv");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = _tablelookupbyrow("mp/zombieKlausActionTable.csv", var_2, 1);
    var_4 = strtok(_tablelookupbyrow("mp/zombieKlausActionTable.csv", var_2, 2), " ");

    if(isDefined(var_3) && var_3 != "") {
      level._id_5A8A[var_3] = var_4;
    }
  }

  level._effect["zmb_brute_drool"] = loadfx("vfx/zombie/zmb_brute_drool");
}

_id_AB6D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_1) || var_5 == "turretweapon_zeppelin_gun_zm" && common_scripts\utility::_id_562E(self._id_A87C)) {
    return;
  }
  var_1 thread _id_04C7::_id_A102("standard");
  self notify("brute_boss_damage", var_2, var_5);
}

_id_AB6E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  _id_054D::_id_6BD4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_AB6C() {
  if(self._id_8BA4 && !isDefined(self._id_1928) && !common_scripts\utility::_id_562E(self._id_9E1B)) {
    return "run";
  } else {
    return "walk";
  }
}

zombie_boss_village_tesla_delayed_dmg(var_0, var_1, var_2) {
  return var_0;
}

_id_AB65(var_0, var_1) {
  _id_7678(var_0, 0, var_1);
}

_id_AB66(var_0, var_1) {
  _id_7678(var_0, 0, var_1, 0, undefined, undefined, ::_id_1CC3, "attack");
}

_id_1CC3(var_0) {
  self notify("brute_smash_starting");
  self endon("brute_smash_starting");
  var_1 = "";

  while(var_1 != var_0) {
    self waittill("scripted_anim", var_1);
  }

  var_2 = self gettagorigin("J_Wrist_RI");
  playFX(level._effect["zmb_brute_slam"], var_2, anglesToForward(self.angles), anglestoup(self.angles));

  foreach(var_4 in level.players) {
    var_5 = distance(self.origin, var_4.origin);

    if(var_5 < 1) {
      var_5 = 1;
    }

    if(var_5 <= 192) {
      var_4 shellshock("frag_grenade_mp", 1.25);
      var_4 dodamage(150 / var_5 + 30, self.origin, self, self, "MOD_GRENADE");
    }
  }
}

_id_AB67(var_0, var_1) {
  _id_7678(var_0, 0, var_1, 0, undefined, undefined, ::_id_1CC3, "attack");
}

_id_AB63(var_0, var_1) {
  _id_7678(var_0, 0, var_1);
}

_id_AB62(var_0, var_1) {
  _id_7678(var_0, 0, var_1);
}

_id_AB68(var_0, var_1, var_2) {
  _id_7678(var_0, 0, undefined, 1, var_1, var_2);
}

_id_AB69(var_0) {
  self notify("show an uber battery");
  self endon("returning to arena");
  var_1 = common_scripts\utility::_id_46B7("brute_exit_destination", "targetname");
  var_2 = common_scripts\utility::_id_4461(self.origin, var_1);
  self._id_1928 = var_2;
  var_3 = common_scripts\utility::_id_46B7("brute_roar_point", "targetname");
  var_4 = 1;

  while(var_4) {
    foreach(var_6 in var_3) {
      if(distance(self.origin, var_6.origin) < 128) {
        var_4 = 0;
        break;
      }
    }

    wait 0.15;
  }

  _id_7678("brute_roar_leaving");
}

_id_AB64(var_0) {
  self notify("returning to arena");
  var_1 = common_scripts\utility::_id_46B7("brute_exit_destination", "targetname");
  var_2 = _id_44C9(var_1, 256);

  if(var_2.size > 0) {
    var_3 = common_scripts\utility::random(var_2);
  } else {
    var_3 = common_scripts\utility::random(var_1);
  }

  self setOrigin(var_3.origin + (0, 0, 8));
  self.angles = var_3.angles;
  var_4 = common_scripts\utility::_id_46B5("final_brute_boss", "targetname");
  self._id_1928 = var_4;
  self._id_9E1B = 1;
  self waittill("traverse_end");
  self._id_9E1B = 0;
  self._id_1928 = undefined;
  _id_AB75();
}

_id_AB7B() {
  _id_AB7A();
  self waittill("brute_unstunned", var_0, var_1);
  return [var_0, var_1];
}

_id_AB6A(var_0, var_1) {
  thread _id_A6B5(var_1);
  _id_7678(var_0, 0, undefined, 1, "brute_stunned", var_1);
  self._id_3ACE setHintString(&"ZOMBIES_EMPTY_STRING");
}

_id_AB79() {
  self notify("set brute behavior", "scripted_brute_exit_traversal");
}

_id_AB72() {
  self notify("set brute behavior", "scripted_brute_entrance_traversal");
}

_id_AB74() {
  self notify("set brute behavior", "brute_standing_attack");
}

_id_AB76() {
  self notify("set brute behavior", "brute_hulk_smash");
}

_id_AB77() {
  self notify("set brute behavior", "brute_hulk_smash_180");
}

_id_AB71() {
  self notify("set brute behavior", "brute_standing_attack_180");
}

_id_AB73() {
  self notify("set brute behavior", "brute_walking_attack");
}

_id_AB78() {
  self notify("set brute behavior", "brute_idle");
}

_id_AB7A() {
  self notify("set brute behavior", "brute_stun_start");
}

_id_AB75() {
  self notify("set brute behavior", "brute_unlock_state");
}

_id_A6AD() {
  self waittill("set brute behavior", var_0);
  return var_0;
}

_id_27A2(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_95AA = var_0;
  var_3._id_73D7 = var_1;
  var_3._id_AC1A = var_2;
  return var_3;
}

_id_AB70() {
  self endon("death");
  thread _id_115A();
  var_0 = 200;
  var_1 = var_0;
  var_2 = var_0;
  var_3 = 10000;
  var_4 = 150;
  var_5 = _id_27A2("J_Mid_LE_3", var_1, var_2);
  var_6 = _id_27A2("J_Mid_RI_3", var_1, var_2);
  var_7 = _id_27A2("tag_origin", var_3, var_4);
  var_8 = [var_5, var_6];
  var_9 = common_scripts\utility::_id_0F73(var_8, [var_7]);
  var_10 = ["brute_unlock_state", "scripted_brute_exit_traversal", "scripted_brute_entrance_traversal", "brute_idle", "brute_stun_start"];
  var_11 = 0;
  var_12 = "";
  waitframe();
  _id_7678("brute_roar_recovering", 0, undefined);

  for(;;) {
    var_13 = _id_A6AD();
    self._id_AB5C = var_13;

    if(var_11 && common_scripts\utility::_id_0F79(var_10, var_13)) {
      self notify("brute behavior was unlocked");
      var_11 = 0;
    }

    if(!var_11) {
      switch (var_13) {
        case "brute_walking_attack":
          var_14 = spawnStruct();
          var_14._id_596D = var_9;
          var_14._id_67E9 = "stop charge damage";

          if(common_scripts\utility::_id_562E(self._id_8BA4)) {
            var_13 = "brute_running_attack";
          }

          childthread _id_AB62(var_13, var_14);
          break;
        case "brute_stun_start":
          var_11 = 1;
          var_12 = "stunned";
          childthread _id_AB6A(var_13, "brute_unstunned");
          break;
        case "brute_idle":
          var_11 = 1;
          var_12 = "waiting";
          childthread _id_AB68(var_13, "brute_idle", "scripted_brute_entrance_traversal");
          break;
        case "scripted_brute_exit_traversal":
          var_11 = 1;
          var_12 = "leaving";
          childthread _id_AB69(var_13);
          break;
        case "scripted_brute_entrance_traversal":
          var_11 = 1;
          var_12 = "returning";
          childthread _id_AB64(var_13);
          break;
        case "brute_standing_attack":
          var_14 = spawnStruct();
          var_14._id_596D = var_8;
          var_14._id_67E9 = "stop forward swing";
          childthread _id_AB65(var_13, var_14);
          break;
        case "brute_hulk_smash":
          var_14 = spawnStruct();
          var_14._id_596D = var_8;
          var_14._id_67E9 = "stop ground pound";
          childthread _id_AB66(var_13, var_14);
          break;
        case "brute_hulk_smash_180":
          var_14 = spawnStruct();
          var_14._id_596D = var_8;
          var_14._id_67E9 = "stop ground pound_180";
          childthread _id_AB67(var_13, var_14);
          break;
        case "brute_standing_attack_180":
          var_14 = spawnStruct();
          var_14._id_596D = var_9;
          var_14._id_67E9 = "stop backhand swing";
          childthread _id_AB63(var_13, var_14);
          break;
      }

      continue;
    }
  }
}

_id_7678(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("brute_change_actions");
  self endon("brute_change_actions");
  self endon("death");

  if(self._id_0A4B != "zombie_boss_village") {
    return;
  }
  var_8 = var_0;
  var_9 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_8);
  var_10 = self getanimentrycount(var_9);
  var_11 = randomint(var_10);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  self scragentsetscripted(1);
  self._id_01BB = 1;

  if(common_scripts\utility::_id_562E(var_1)) {
    self scragentsetphysicsmode("noclip");
  } else {
    self scragentsetphysicsmode("gravity");
  }

  if(isDefined(var_2)) {
    foreach(var_13 in var_2._id_596D) {
      childthread _id_3203(var_13, var_2._id_67E9);
    }
  }

  if(isDefined(var_6)) {
    self childthread[[var_6]](var_7);
  }

  if(!common_scripts\utility::_id_562E(var_3)) {
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_9, var_11, 1.0, "scripted_anim");
  } else {
    _id_309A(var_0, var_4, var_5);
  }

  if(common_scripts\utility::_id_562E(var_1)) {
    self scragentsetphysicsmode("gravity");
  }

  if(isDefined(var_2)) {
    self notify(var_2._id_67E9);
  }

  self scragentsetscripted(0);
  self notify("brute finished scripted state");
}

_id_309A(var_0, var_1, var_2) {
  self endon("death");
  var_3 = _id_43FA(var_0);
  var_4 = spawnStruct();
  var_4._id_8B58 = 0;
  childthread _id_49E8(var_4, var_2);
  self._id_55A6 = 1;

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
    var_7 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_6);
    var_8 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_7);

    if(var_3[var_5] == var_1) {
      childthread maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_7, var_8, 1.0, "scripted_anim");

      while(!var_4._id_8B58) {
        _id_0547::_id_A6F6();
      }

      continue;
    }

    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_7, var_8, 1.0, "scripted_anim");
  }

  self._id_55A6 = 0;
}

_id_49E8(var_0, var_1) {
  self waittill(var_1);
  var_0._id_8B58 = 1;
}

_id_1CB8() {
  self endon("death");
  var_0 = 0;

  if(common_scripts\utility::_id_562E(self._id_55A6) || maps\mp\agents\_scripted_agent_anim_util::_id_57E2()) {
    return 0;
  }

  var_1 = _id_40E4();

  if(var_1._id_8F15 || var_1._id_6895 > 0) {
    if(var_1._id_6891 > var_1._id_687E) {
      if(common_scripts\utility::_id_24A6()) {
        _id_AB74();
      } else {
        _id_AB76();
      }
    } else
      _id_AB77();

    var_0 = 1;
  } else if(var_1._id_6895 > 0 && var_1._id_6891 < var_1._id_687E) {
    _id_AB71();
    var_0 = 1;
  } else if(var_1._id_688D > 0 && var_1._id_6891 > 0) {
    if(_id_1CC7()) {
      _id_AB73();
      var_0 = 1;
    } else
      var_0 = 0;
  }

  return var_0;
}

_id_1CC5() {
  wait 4;

  for(;;) {
    wait 0.1;
    var_0 = _id_40E4();

    if(var_0._id_688D + var_0._id_6897 == _id_6873() && !common_scripts\utility::_id_562E(self._id_8BA4)) {
      if(!common_scripts\utility::_id_562E(self._id_203F)) {
        thread _id_93BF(5);
      }

      continue;
    }

    if(self._id_8BA4 && var_0._id_6895 > 0) {
      thread _id_1F35();
    }
  }
}

_id_93BF(var_0) {
  self endon("cancel_brute_run");
  self._id_8BA4 = 1;
  wait(var_0);
  self._id_8BA4 = 0;
  self._id_203F = 1;
  wait 4;
  self._id_203F = 0;
}

_id_1F35() {
  self notify("cancel_brute_run");
  self._id_8BA4 = 0;
}

_id_40E4() {
  var_0 = spawnStruct();
  var_0._id_8F15 = 0;
  var_0._id_6897 = 0;
  var_0._id_6895 = 0;
  var_0._id_688D = 0;
  var_0._id_6891 = 0;
  var_0._id_687E = 0;

  foreach(var_2 in level.players) {
    if(distance(var_2.origin, self.origin) < 50) {
      var_0._id_8F15 = 1;
    } else if(distance(var_2.origin, self.origin) < 256) {
      var_0._id_6895++;
    } else if(distance(var_2.origin, self.origin) < 768) {
      var_0._id_688D++;
    } else {
      var_0._id_6897++;
    }

    if(var_2 _id_053C::_id_5724(self)) {
      var_0._id_6891++;
      continue;
    }

    var_0._id_687E++;
  }

  var_0._id_6873 = _id_6873();
  return var_0;
}

_id_6873() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(isalive(var_2) && !var_2.inlaststand) {
      var_0++;
    }
  }

  return var_0;
}

_id_115A() {
  var_0 = getEntArray("nest_brute_uber_inserts", "targetname");

  while(self.model == "tag_origin") {
    waitframe();
  }

  foreach(var_2 in var_0) {
    var_2 show();
    var_2.origin = self gettagorigin(var_2._id_0165) + _id_425D(var_2._id_0165);
    var_2 linktoblendtotag(self, var_2._id_0165);
  }

  var_0 thread _id_1CCD(self);
}

_id_425D(var_0) {
  var_1 = (0, 0, 0);

  switch (var_0) {
    case "J_Knee_LE":
      var_1 = (8, 8, -8);
      break;
    case "J_Knee_RI":
      var_1 = (-8, -8, -8);
      break;
    case "J_SpineLower":
      var_1 = (0, 16, 0);
      break;
  }

  return var_1;
}

_id_1CCD(var_0) {
  var_1 = [undefined, undefined, undefined];

  foreach(var_3 in self) {
    var_1[var_3.setanimknobrestart - 1] = var_3;
    var_3 ghost();
  }

  var_0._id_1CCF = var_1;

  foreach(var_3 in var_1) {
    var_0 waittill("show an uber battery");
    var_3 show();
    _playFXOnTag(level._effect["gk_raven_hc_ee_uber_attached"], var_3, "tag_origin");
    var_3 _id_0378::_id_8D74("uber_battery_spawn");
  }
}

_id_44C9(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    foreach(var_6 in level.players) {
      if(distance(var_4.origin, var_6.origin) < var_1) {
        var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
      }
    }
  }

  return var_2;
}

_id_43FA(var_0) {
  var_1 = [];

  switch (var_0) {
    case "brute_stun_start":
      var_1 = ["brute_stun_start", "brute_stunned", "brute_stun_end", "brute_roar_leaving"];
      break;
    case "brute_idle":
      var_1 = ["brute_idle"];
      break;
    default:
      break;
  }

  return var_1;
}

_id_A6B5(var_0) {
  wait 2.25;
  thread _id_94BF(2, var_0);
  self endon(var_0);
  var_1 = undefined;

  for(var_2 = 0; !var_2; var_2 = var_1 _id_0585::_id_9E12("Blimp Battery Hunt")) {
    self._id_3ACE setHintString(&"ZOMBIE_NEST_PLACE_UBER");
    self._id_3ACE waittill("trigger", var_1);
  }

  self notify(var_0, 1, var_1);
}

_id_1CC6() {
  level thread maps\mp\_utility::_id_6F74(::_id_A0EB, self);
}

_id_A0EB(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  iswaitingonsound(var_0._id_3ACE, self, 0);

  for(;;) {
    var_1 = common_scripts\utility::waittill_any_return("uber_gained", "uber_lost");

    if(!isalive(self)) {
      continue;
    }
    if(var_1 == "uber_gained") {
      if(_id_0586::_id_72C3()) {
        iswaitingonsound(var_0._id_3ACE, self, 1);
      }

      continue;
    }

    if(var_1 == "uber_lost") {
      iswaitingonsound(var_0._id_3ACE, self, 0);
    }
  }
}

iswaitingonsound(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 call[[common_scripts\utility::_id_98E7(var_2, ::enableplayeruse, ::disableplayeruse)]](var_1);
  }
}

_id_94BF(var_0, var_1) {
  self endon(var_1);

  if(level.players.size == 1) {
    var_0 = var_0 + 3;
  }

  _id_0555::issprinting("brute_stun");

  while(var_0 > 0) {
    var_0--;
    wait 1;
  }

  _id_0555::issprinting("brute_awake");
  self notify(var_1, 0);
}

_id_1CC7(var_0) {
  if(_id_A271(self)) {
    return 1;
  }

  return 0;
}

_id_3203(var_0, var_1) {
  self endon("brute_change_actions");
  self endon(var_1);
  self endon("death");
  var_2 = [];
  var_3 = var_0._id_95AA;
  var_4 = var_0._id_73D7;
  var_5 = var_0._id_AC1A;

  for(;;) {
    var_6 = [];

    if(var_5 > 0) {
      var_7 = _id_0547::_id_408F();
      var_7 = common_scripts\utility::_id_0F93(var_7, self);
      var_6 = common_scripts\utility::_id_0F73(var_6, var_7);
    }

    if(var_4 > 0) {
      var_6 = common_scripts\utility::_id_0F73(var_6, level.players);
    }

    foreach(var_9 in var_6) {
      var_10 = common_scripts\utility::_id_98E7(isPlayer(var_9), var_4, var_5);
      var_11 = self gettagorigin(var_3);

      if(!common_scripts\utility::_id_0F79(var_2, var_9) && distance(var_11, var_9.origin) < 64) {
        var_9 dodamage(var_10, var_11, self, self, "MOD_IMPACT");
        var_2 = common_scripts\utility::_id_0F6F(var_2, var_9);
      }
    }

    waitframe();
  }
}

_id_AB6B(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_2 = var_1 gettagindex(var_0);

  if(var_2 == -1) {
    return;
  }
  var_3 = spawnStruct();
  var_3.origin = var_1 gettagorigin(var_0);
  var_3.angles = var_1.angles;
  var_3._id_2F74 = 1;
  var_4 = spawnStruct();
  var_4._id_2434 = 30;
  var_4._id_60C1 = 60;
  var_4._id_3A20 = 90;
  var_4._id_1B70 = 82;
  var_1 childthread _id_0547::tackle_thread(var_3, var_4);

  for(;;) {
    wait 0.1;

    if(!isDefined(var_1._id_AB5C)) {
      continue;
    }
    var_3.origin = var_1 gettagorigin(var_0);
    var_3.angles = var_1.angles;
    var_3._id_2F74 = !common_scripts\utility::_id_0F79(["scripted_brute_exit_traversal", "scripted_brute_entrance_traversal", "brute_standing_attack", "brute_standing_attack_180", "brute_walking_attack", "brute_up_stairs", "brute_down_stairs"], var_1._id_AB5C);
  }
}

_id_AB6F() {
  foreach(var_1 in ["j_ball_le", "j_ball_ri"]) {
    thread _id_AB6B(var_1);
  }
}

_id_AB7D(var_0, var_1, var_2) {
  _id_054D::_id_6BD7(var_0, var_1, var_2);
  self._id_90DC = "zombie_boss_village";
}

_id_AB7C() {
  var_0 = 48;
  var_1 = 200;
  self _meth_856C(var_0, var_1);
  self._id_00BD = var_1;
  self.radius = var_0;
  self _meth_85A1("zombie_boss_village");
  self _meth_84D4();
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self._id_6816 = 1;
  self._id_56EB = 1;

  if(!common_scripts\utility::_id_562E(level._id_AC14)) {
    thread _id_AB70();
  }

  self._id_5D5F = 1;
  self._id_57E8 = 1;
  self._id_8BA4 = 0;
  self._id_1DEB = 1;
  self scragentsetmaxturnspeed(_id_4399());
  thread _id_AB5B();
  thread _id_1CBE();
}

_id_1CBE() {
  waitframe();
  _playFXOnTag(level._effect["zmb_brute_drool"], self, "J_Head");
}

_id_AB5B() {
  var_0 = "tag_origin";
  var_1 = _id_0547::_id_0A51("zombie_boss_village");
  var_2 = spawn("script_model", self.origin);
  var_2 setModel(var_1._id_1144["whole_body"]);
  var_2.angles = self gettagangles(var_0);
  var_2 linkTo(self, var_0);
  self._id_5A9C = var_2;
  self._id_1142 = ::_id_84F1;
}

_id_84F1(var_0, var_1, var_2, var_3) {
  if(!isDefined(self) || !isDefined(self._id_5A9C)) {
    return;
  }
  self notify("set_klaus_state");
  self endon("set_klaus_state");
  var_4 = var_0;

  if(!isDefined(var_1)) {
    var_5 = self getanimentryname();
    var_6 = self getanimentrycount(var_0);

    for(var_7 = 0; var_7 < var_6; var_7++) {
      var_8 = self getanimentryname(var_0, var_7);

      if(var_8 == var_5) {
        var_1 = var_7;
        break;
      }
    }
  }

  if(isDefined(self._id_5A9C._id_0EE8) && self._id_5A9C._id_0EE8 == var_4 && isDefined(self._id_5A9C._id_0EC1) && self._id_5A9C._id_0EC1 == var_1) {
    return;
  }
  var_9 = undefined;
  var_10 = level._id_5A8A[var_4][var_1];
  waitframe();
  self._id_5A9C scriptmodelclearanim();
  self._id_5A9C scriptmodelplayanim(var_10);
  self._id_5A9C._id_0EE8 = var_4;
  self._id_5A9C._id_0EC4 = var_10;
  self._id_5A9C._id_0EC1 = var_1;
}

_id_AB7E() {
  _id_AB7C();
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  _id_0566::_id_ABB5();
  var_0 = 0.2;
  childthread _id_1CC5();
  self._id_117D = 4;
  self._id_1F0F = 1;

  for(;;) {
    wait(var_0);
    var_1 = isDefined(self._id_92EA) && gettime() * 0.001 < self._id_92EA;
    self._id_50C5 = common_scripts\utility::_id_562E(self._id_54F4) || var_1;

    if(self._id_1F0F && !self._id_50C5) {
      if(self._id_117D < 0 && _id_1CB8()) {
        thread _id_1160(2);
        continue;
      } else if(self._id_117D > 0)
        self._id_117D = self._id_117D - var_0;
    }

    if(_id_053C::_id_4F9B()) {
      continue;
    }
    if(_id_053C::_id_4F9A()) {
      continue;
    }
    _id_053C::_id_0647();
  }
}

_id_1160(var_0) {
  self._id_1F0F = 0;
  self._id_117D = var_0;
  common_scripts\utility::_id_A70A("brute finished scripted state", "brute behavior was unlocked");
  self._id_1F0F = 1;
}

_id_5725(var_0) {
  var_1 = 65536;
  var_2 = 65536;
  var_3 = self.angles;
  var_4 = self gettagorigin("tag_origin");
  var_5 = var_4 + var_3 * 1000;

  if(!isDefined(var_0) || !isalive(var_0)) {
    return 0;
  }

  var_6 = var_0.origin + (0, 0, 64);
  var_7 = distancesquared(var_4, var_6);

  if(var_7 > var_1) {
    return 0;
  }

  var_8 = vectorNormalize(var_6 - var_4);
  var_9 = vectordot(var_3, var_8);

  if(0 > var_9) {
    return 0;
  }

  var_10 = _pointonsegmentnearesttopoint(var_4, var_5, var_6);

  if(distancesquared(var_6, var_10) > var_2) {
    return 0;
  }

  if(0 == var_0 damageconetrace(var_4, self)) {
    return 0;
  }

  if(var_7 < var_1) {
    return 1;
  }

  return 0;
}

_id_A271(var_0) {
  var_1 = (0, 0, 16);
  var_2 = 650;
  var_3 = 5;
  var_4 = [];
  var_5 = [];
  var_6 = _id_A01F(var_0.angles);
  var_7 = 0;
  var_8 = var_2 / var_3;
  var_9 = 0;
  var_10 = [];

  for(var_11 = 0; var_11 < var_3; var_11++) {
    if(var_11 > 0) {
      var_12 = var_4[var_11 - 1] + var_1;
    } else {
      var_12 = var_0.origin + var_1;
    }

    var_13 = var_12 + var_6 * var_8;
    var_14 = _func_2E1(var_13, var_0) + var_1;
    var_15 = _id_6CC9(var_13, var_14);
    var_16 = bulletTrace(var_12, var_15, 0);
    var_4 = common_scripts\utility::_id_0F6F(var_4, var_15);

    if(var_16["fraction"] != 1) {
      var_7 = 1;
      break;
    }
  }

  return !var_7;
}

_id_A01F(var_0) {
  var_1 = anglesToForward(var_0);
  var_1 = common_scripts\utility::_id_3D5D(var_1);
  var_1 = vectorNormalize(var_1);
  return var_1;
}

_id_6CC9(var_0, var_1) {
  return (var_0[0], var_0[1], var_1[2]);
}

_id_4399() {
  var_0 = 0.15;
  var_1 = var_0 * 3.14 * 2 * 0.05;
  return var_1;
}