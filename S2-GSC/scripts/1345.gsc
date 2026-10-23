/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1345.gsc
**************************************/

main() {
  _id_531A();
  _id_52A9();
  initdismembermentweaponmodifiers();
  level._id_08D9 = [];
}

_id_09C9(var_0, var_1, var_2, var_3, var_4) {
  level.mutators[var_0] = [];
  level.mutators[var_0][0] = var_1;
  level.mutators[var_0][2] = var_2;
  level.mutators[var_0][3] = var_3;
  level.mutators[var_0][4] = var_4;
}

disablemutatorfortypes(var_0, var_1) {
  if(!_isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_3 in var_1) {
    level.mutators_disabled[var_3][var_0] = 1;
  }
}

_id_531A() {
  level.mutators = [];
  _id_09C9("crawl", ::mutatorcrawl);
  disablemutatorfortypes("crawl", ["zombie_heavy", "zombie_fireman", "zombie_exploder", "zombie_berserker"]);
}

_id_52A9() {
  _id_0547::_id_7BD0("dismemberment_transition", ::_id_0EAF, ::_id_0EB0, 3);
  level._id_3EFD = 0;
  level._id_2FDE[1]["modelToSpawn"] = "zom_shared_r_arm_slice";
  level._id_2FDE[2]["modelToSpawn"] = "zom_shared_l_arm_slice";
  level._id_2FDE[4]["modelToSpawn"] = "zom_shared_r_leg_slice";
  level._id_2FDE[8]["modelToSpawn"] = "zom_shared_l_leg_slice";
  level._id_2FDE[1]["tagName"] = "J_Shoulder_RI";
  level._id_2FDE[2]["tagName"] = "J_Shoulder_LE";
  level._id_2FDE[4]["tagName"] = "J_Hip_RI";
  level._id_2FDE[8]["tagName"] = "J_Hip_LE";
  level._id_2FDE[16]["tagName"] = "J_Head";
  level._id_2FDE[1]["fxTagName"] = "J_Shoulder_RI";
  level._id_2FDE[2]["fxTagName"] = "J_Shoulder_LE";
  level._id_2FDE[4]["fxTagName"] = "J_Hip_RI";
  level._id_2FDE[8]["fxTagName"] = "J_Hip_LE";
  level._id_2FDE[16]["fxTagName"] = "J_Head";
  level._id_2FDE["full"]["fxTagName"] = "J_MainRoot";
  level._id_2FDE[1]["torsoFX"] = "torso_arm_loss_right";
  level._id_2FDE[2]["torsoFX"] = "torso_arm_loss_left";
  level._id_2FDE[4]["torsoFX"] = "torso_loss_right";
  level._id_2FDE[8]["torsoFX"] = "torso_loss_left";
  level._id_2FDE[16]["torsoFX"] = "torso_head_loss";
  level._id_2FDE[1]["limbFX"] = "arm_loss_right";
  level._id_2FDE[2]["limbFX"] = "arm_loss_left";
  level._id_2FDE[4]["limbFX"] = "limb_loss_right";
  level._id_2FDE[8]["limbFX"] = "limb_loss_left";
  level._id_2FDE[16]["gibFX"] = "head_gibs";
  level._id_2FDE[1]["dismemberSound"] = "zmb_dism_arm";
  level._id_2FDE[2]["dismemberSound"] = "zmb_dism_arm";
  level._id_2FDE[4]["dismemberSound"] = "zmb_dism_leg";
  level._id_2FDE[8]["dismemberSound"] = "zmb_dism_leg";
  level._id_2FDE[16]["dismemberSound"] = "zmb_dism_head";
  level._id_2FDE["full"]["dismemberSound"] = "zmb_dism_instakill_explosion";
}

initdismembermentweaponmodifiers() {
  var_0 = "mp/zombieDismembermentModifiers.csv";
  var_1 = 0;
  var_2 = 2;
  var_3 = 3;
  var_4 = 4;
  var_5 = 5;
  var_6 = _tablegetrowcount(var_0);

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_8 = _tablelookupbyrow(var_0, var_7, var_1);
    var_9 = _tablelookupbyrow(var_0, var_7, var_2);
    var_10 = _tablelookupbyrow(var_0, var_7, var_3);
    var_11 = _tablelookupbyrow(var_0, var_7, var_4);
    var_12 = _tablelookupbyrow(var_0, var_7, var_5);
    level.dismembermentmodifiers[var_8] = _float(var_9);
    level.dismembermentupgrademodifiers[var_8] = _float(var_10);
    level.highdamageweapons[var_8] = var_11 == "true";
    level.dismembermentignorelocation[var_8] = var_12 == "true";
  }
}

mutator_apply(var_0) {
  if(!isDefined(level._id_08D9[var_0])) {
    level._id_08D9[var_0] = 0;
  }

  if(!isDefined(self._id_08D9)) {
    self._id_08D9 = [];
  }

  if(isDefined(self._id_08D9[var_0])) {
    return;
  }
  if(isDefined(level.mutators_disabled[self._id_0A4B])) {
    if(isDefined(level.mutators_disabled[self._id_0A4B][var_0]) && level.mutators_disabled[self._id_0A4B][var_0]) {
      return;
    }
  }

  level._id_08D9[var_0]++;
  self._id_08D9[var_0] = 1;
  self[[level.mutators[var_0][0]]]();

  if(isDefined(self._id_08D9)) {
    self._id_08D9[var_0] = undefined;
  }

  level._id_08D9[var_0]--;
}

torso_effects_apply(var_0, var_1) {
  if(isDefined(level._effect[var_0 + "_head"])) {
    _id_0547::playfxontagnetwork(level._effect[var_0 + "_head"], self, "j_head");
  }

  if(isDefined(level._effect[var_0 + "_arm_r"])) {
    _id_0547::playfxontagnetwork(level._effect[var_0 + "_arm_r"], self, "j_shoulder_ri");
  }

  if(isDefined(level._effect[var_0 + "_arm_l"])) {
    _id_0547::playfxontagnetwork(level._effect[var_0 + "_arm_l"], self, "j_shoulder_le");
  }

  if(isDefined(level._effect[var_0 + "_back"])) {
    _id_0547::playfxontagnetwork(level._effect[var_0 + "_back"], self, "j_spineupper");
  }

  if(isDefined(level._effect[var_0 + "_spine"])) {
    _id_0547::playfxontagnetwork(level._effect[var_0 + "_spine"], self, "j_spine4");
  }

  self._id_9AA6 = var_0;

  if(isDefined(var_1)) {
    thread torso_effects_remove(var_0, var_1);
  }
}

torso_effects_remove(var_0, var_1) {
  self notify("removeTorsoEffectsDelayed");
  self endon("removeTorsoEffectsDelayed");
  self endon("death");

  if(isDefined(var_1)) {
    wait(var_1);
  }

  if(isDefined(self)) {
    if(isDefined(level._effect[var_0 + "_head"])) {
      _id_0547::stopfxontagnetwork(level._effect[var_0 + "_head"], self, "j_head");
    }

    if(isDefined(level._effect[var_0 + "_arm_r"])) {
      _id_0547::stopfxontagnetwork(level._effect[var_0 + "_arm_r"], self, "j_shoulder_ri");
    }

    if(isDefined(level._effect[var_0 + "_arm_l"])) {
      _id_0547::stopfxontagnetwork(level._effect[var_0 + "_arm_l"], self, "j_shoulder_le");
    }

    if(isDefined(level._effect[var_0 + "_back"])) {
      _id_0547::stopfxontagnetwork(level._effect[var_0 + "_back"], self, "j_spineupper");
    }

    if(isDefined(level._effect[var_0 + "_spine"])) {
      _id_0547::stopfxontagnetwork(level._effect[var_0 + "_spine"], self, "j_spine4");
    }
  }
}

mutatorcrawl() {
  mutilate(12, 0);
}

startcrawl() {
  self.dismember_crawl = 1;
  maps\mp\agents\humanoid\_humanoid_util::dodgedisable();

  if(isDefined(self.lungemeleeenabled)) {
    maps\mp\agents\humanoid\_humanoid_util::lungemeleeupdate(10.0, 240, 120, "attack_lunge_boost", level._effect["boost_lunge"], 1, 255);
  }

  maps\mp\agents\humanoid\_humanoid_util::leapdisable();
  self scragentallowboost(0);
  self scragentsetorienttoground(1);
  self scragentsetviewheight(15);
  level.crawlingzombies++;
  thread _id_0547::_id_AB18(60);
  self waittill("death");
  level.crawlingzombies--;
}

getdismembermentmodifier(var_0, var_1, var_2) {
  if(_id_0547::isinstakill()) {
    return 0;
  }

  var_3 = undefined;

  if(isDefined(var_1)) {
    var_1 = _getweaponbasename(var_1);
    var_3 = var_1;
  } else if(isDefined(var_2))
    var_3 = var_2;

  if(!isDefined(var_3)) {
    return 1;
  }

  var_4 = level.dismembermentmodifiers[var_3];

  if(isDefined(var_0) && isPlayer(var_0) && isDefined(var_1) && isDefined(var_4) && !maps\mp\_utility::iskillstreakweapon(var_1)) {
    var_4 = checkweaponupgrademodifier(var_0, var_1, var_4);
    return var_4;
  } else if(isDefined(var_4))
    return var_4;
  else {
    return 1;
  }
}

checkweaponupgrademodifier(var_0, var_1, var_2) {
  var_3 = level.dismembermentupgrademodifiers[var_1];

  if(!isDefined(var_3)) {
    return var_2;
  }

  var_4 = _id_0547::getzombieweaponlevel(var_0, var_1);

  if(var_4 <= 1) {
    return var_2;
  }

  var_5 = var_2 - var_3;
  var_6 = var_2 - var_4 / 3 * var_5;
  return clamp(var_6, var_3, var_2);
}

getmutilationmask(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_3 >= 1) {
    if(_id_0547::_id_21AA("exploder")) {
      return self._id_2FDB;
    }
  }

  var_6 = common_scripts\utility::_id_562E(level.dismembermentignorelocation[var_1]) || common_scripts\utility::_id_562E(level.dismembermentignorelocation[var_2]) || _id_0547::isinstakill() || issubstr(var_1, "m1911_pap_zm") || issubstr(var_1, "teslagun") || issubstr(var_1, "fliegerfaust_zm") || common_scripts\utility::_id_562E(var_1 == "panzerschreck_zm") || issubstr(var_1, "razergun") || common_scripts\utility::_id_562E(var_1 == "bazooka_zm") || common_scripts\utility::_id_562E(self.luckycrit) || common_scripts\utility::_id_562E(var_1 == "island_grenade_hc_zm") || common_scripts\utility::_id_562E(var_1 == "jack_in_box_decoy_zm");

  if(var_3 < 1 && _id_0547::_id_5565(var_1, "turretweapon_ger_btry_flak38_mp_zombie")) {
    var_6 = 0;
  }

  if(var_6) {
    var_7 = 31;
  } else {
    var_7 = locationtobodypart(var_0);
  }

  var_8 = 1;

  if(var_7 == 0) {
    return 0;
  }

  if(!isDefined(var_2) || var_2 != "MOD_GRENADE" && var_2 != "MOD_GRENADE_SPLASH" && var_2 != "MOD_EXPLOSIVE") {
    var_7 = var_7 &~12;
  } else if(_randomfloat(1) > 0.5) {
    var_7 = 8;
  } else {
    var_7 = 4;
  }

  if(isDefined(level._id_324B) && [[level._id_324B]](self)) {
    var_7 = var_7 &~12;
  }

  var_7 = var_7 &self._id_2FDB;
  var_8 = var_8 * (getdismembermentmodifier(var_4, var_1, undefined) * getdismembermentmodifier(var_4, undefined, var_2));
  var_8 = var_8 * (-0.7 * var_3 + 1);
  return getmutilationmaskinternal(var_7, var_5, var_3, var_8);
}

getmutilationmaskinternal(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if((var_0 &var_0 - 1) > 0) {
    if(var_2 < 1) {
      var_5 = randomint(24);
      var_6 = 228;

      for(var_7 = 4; var_7 > 0; var_7--) {
        var_8 = 1 << var_5 % var_7 * 2;
        var_5 = int(var_5 / var_7);
        var_9 = var_6 % var_8;
        var_10 = int(var_6 / var_8);
        var_6 = var_9 + (var_10 >> 2) * var_8;
        var_11 = 1 << (var_10 & 3);

        if((var_0 &var_11) != 0 && isDefined(bodypartmasktoanimclass(var_1 | var_4 | var_11))) {
          if(_randomfloat(1.0) > chancetokeepbodypart(var_11) * var_3) {
            var_4 = var_4 | var_11;
          }
        }
      }
    } else {
      while(var_0 > 0) {
        var_11 = var_0 & 0 - var_0;

        if(_randomfloat(1.0) > chancetokeepbodypart(var_11) * var_3) {
          var_4 = var_4 | var_11;
        }

        var_0 = var_0 - var_11;
      }
    }
  } else if(var_2 >= 1 || isDefined(bodypartmasktoanimclass(var_1 | var_0))) {
    if(_randomfloat(1.0) > chancetokeepbodypart(var_0) * var_3) {
      var_4 = var_0;
    }
  }

  return var_4;
}

trymutilate(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;

  if(isalive(self) && (!maps\mp\agents\_scripted_agent_anim_util::isstatelocked() || var_3 >= 1) && self._id_0BA4 != "traverse" && _id_0547::has_entered_game()) {
    var_7 = getmutilationmask(var_0, var_1, var_2, var_3, var_4, self.missingbodyparts);

    if(var_7 != 0) {
      var_8 = !common_scripts\utility::_id_562E(self.dismember_crawl);
      var_9 = isDefined(self.missingbodyparts) && self.missingbodyparts == 0;

      if(level.crawlingzombies < 9999 || self.dismember_crawl || (var_7 & 12) == 0 || (var_7 & 16) != 0 || (self.missingbodyparts & 3) != 0) {
        if(mutilate(self.missingbodyparts | var_7, common_scripts\utility::_id_562E(level.highdamageweapons[var_1]), var_3, var_5, undefined, 1)) {
          if(_id_0547::isinstakill()) {
            _earthquake(_randomfloatrange(0.15, 0.35), 1, self.origin, 200);
          }

          var_6 = 1;
        }

        if(isalive(self) && isPlayer(var_4)) {
          if(var_8 && common_scripts\utility::_id_562E(self.dismember_crawl)) {
            var_4 thread _id_054E::player_hurt_zombie_vox("crawl_spawn");
          } else if(var_9 && isDefined(self.missingbodyparts) && self.missingbodyparts != 0) {
            var_4 thread _id_054E::player_hurt_zombie_vox("shoot_arm");
          }
        }
      }
    }
  }

  return var_6;
}

isfullbodymutilation() {
  if(!isDefined(self.recentlylostlimbs)) {
    return 0;
  }

  return _id_0547::countlimbs(self.recentlylostlimbs) >= 3;
}

_id_A0DF(var_0, var_1) {
  var_2 = bodypartmasktoanimclass(self.missingbodyparts);

  if(var_2 != self _meth_85A5()) {
    if(!self.dismember_crawl && (self.missingbodyparts & 12) != 0) {
      thread startcrawl();
    }

    if(var_0) {
      var_3 = var_2;

      if(!isDefined(self._id_788C) || self._id_788C != var_2) {
        self._id_788C = var_2;
        self notify("queuedDismembermentTransition");

        switch (self._id_0108) {
          case "walk":
            var_3 = var_3 + "_walk";
            break;
          case "run":
          case "sprint":
            var_3 = var_3 + "_run";
            break;
        }

        if(var_1) {
          var_3 = var_3 + "_highdamage";
        }

        var_4 = [self, "queuedDismembermentTransition"];
        thread _id_0547::_id_7D1A("dismemberment_transition", [var_2, var_3], undefined, var_4);
        return;
      }
    } else {
      self setanimclass(var_2);
      maps\mp\agents\humanoid\_humanoid_util::_id_A18C();

      if(self._id_0BA4 == "idle") {
        var_5 = "idle_noncombat";
        var_6 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_5);
        maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_6);
      }
    }
  }
}

_id_0EAF(var_0, var_1) {
  maps\mp\agents\humanoid\_humanoid_util::changeanimclass(var_0, var_1);
}

_id_0EB0(var_0, var_1) {
  maps\mp\agents\humanoid\_humanoid_util::_id_20C4(var_0);
}

mutilate(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_0 = var_0 &self._id_2FDB;

  if(var_0 == self.missingbodyparts) {
    return 0;
  }

  var_6 = !isDefined(bodypartmasktoanimclass(var_0)) || var_2 >= 1;

  if(!_id_0547::candie()) {
    if(var_0 & 16) {
      var_0 = var_0 &~16;
    }

    if(var_6) {
      var_6 = 0;
      var_0 = 0;
    }
  }

  var_7 = self._id_90AB < gettime();

  if(_id_0547::countlimbs(var_0) - _id_0547::countlimbs(self.missingbodyparts) >= 3) {
    var_7 = 0;
  }

  if(var_6 && common_scripts\utility::_id_562E(self.must_gib_head)) {
    var_0 = 16;
  }

  _id_2E44(var_0, var_6, var_3, var_7, var_4, var_5);

  if(!var_6) {
    _id_A0DF(var_7, var_1);
  }

  return var_6;
}

delayeddeleteeyesfx() {
  self endon("death");
  waitframe();

  if(isDefined(self.linked_fx["tag_eye"])) {
    self.linked_fx["tag_eye"] delete();
    self.linked_fx["tag_eye"] = undefined;
  }
}

bodypartmasktoanimclass(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 1:
      var_1 = "zombie_missing_right_arm_animclass";
      break;
    case 2:
      var_1 = "zombie_missing_left_arm_animclass";
      break;
    case 4:
      var_1 = "zombie_missing_right_leg_animclass";
      break;
    case 8:
      var_1 = "zombie_missing_left_leg_animclass";
      break;
    case 12:
      var_1 = "zombie_crawl_animclass";
      break;
    case 0:
      var_1 = "zombie_animclass";
      break;
    default:
      return undefined;
  }

  if(!maps\mp\_utility::_id_585F()) {
    var_1 = "mp_" + var_1;
  }

  return var_1;
}

locationtobodypart(var_0) {
  switch (var_0) {
    case "right_arm_lower":
    case "right_hand":
    case "right_arm_upper":
      return 1;
    case "left_hand":
    case "left_arm_lower":
    case "left_arm_upper":
      return 2;
    case "right_foot":
    case "right_leg_lower":
    case "right_leg_upper":
      return 4;
    case "left_foot":
    case "left_leg_lower":
    case "left_leg_upper":
      return 8;
    case "neck":
    case "helmet":
    case "head":
      return 16;
    default:
      return 0;
  }
}

chancetokeepbodypart(var_0) {
  if(isDefined(self.hasarmor) && var_0 != 16) {
    return 1;
  }

  switch (var_0) {
    case 1:
      return 0.45;
    case 2:
      return 0.45;
    case 4:
      return 0.5;
    case 8:
      return 0.5;
    case 16:
      if(common_scripts\utility::_id_562E(self.hashelmet) || common_scripts\utility::_id_562E(self._id_4B5A)) {
        return 1;
      }

      return 0.65;
    default:
      return 1;
  }
}

getlimbproperty(var_0, var_1, var_2) {
  if(isDefined(self._id_2FE3) && isDefined(self._id_2FE3[var_0])) {
    var_3 = self._id_2FE3[var_0][var_2];

    if(isDefined(var_3)) {
      return var_3;
    }
  }

  if(isDefined(var_1) && isDefined(level._id_2FDE[var_1])) {
    var_4 = level._id_2FDE[var_1][var_2];

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  var_4 = level._id_2FDE[var_0][var_2];
  return var_4;
}

getlimborigin(var_0, var_1) {
  var_2 = 40;

  switch (var_0) {
    case 2:
    case 1:
      return self.origin + (0, 0, var_2);
    case 8:
    case 4:
      var_3 = self gettagorigin(var_1);
      return (self.origin[0], self.origin[1], var_3[2]);
    case 16:
      return self gettagorigin(var_1);
  }
}

detachlimbsupdatemodelqueue(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.mutilate_detach_limb_queue)) {
    level.mutilate_detach_limb_queue = 0;
  }

  var_6 = _floor(level.mutilate_detach_limb_queue / 2) * 0.05;
  level.mutilate_detach_limb_queue++;
  var_7 = "entitydeleted";

  if(_isagent(self)) {
    var_7 = "death";
  }

  self endon(var_7);
  thread decrementlimbqueueondelete(var_7);

  if(var_6 > 0) {
    wait(var_6);
  }

  detachlimbsupdatemodel(var_0, var_1, var_2, var_3, var_4, var_5);
  thread decrementlimbqueue();
  self notify("mutilate_queue_processed");
}

decrementlimbqueueondelete(var_0) {
  self endon("mutilate_queue_processed");
  self waittill(var_0);
  thread decrementlimbqueue();
}

decrementlimbqueue() {
  waitframe();
  level.mutilate_detach_limb_queue--;
  level.mutilate_detach_limb_queue = int(max(level.mutilate_detach_limb_queue, 0));
}

_id_2E44(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 = var_0 &self._id_2FDB;
  var_6 = ~self.missingbodyparts &var_0;
  self.missingbodyparts = self.missingbodyparts | var_0;
  self.recentlylostlimbs = var_6;

  if(_isagent(self)) {
    self[[maps\mp\agents\_agent_utility::_id_0A59("on_mutilate")]](var_6);
  }

  if(common_scripts\utility::_id_562E(var_5)) {
    thread detachlimbsupdatemodelqueue(var_0, var_1, var_2, var_3, var_4, var_6);
  } else {
    detachlimbsupdatemodel(var_0, var_1, var_2, var_3, var_4, var_6);
  }
}

detachlimbsupdatemodel(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_3) {
    if((var_5 & 1) != 0) {
      _id_903D(1, var_2, var_4);
    }

    if((var_5 & 2) != 0) {
      _id_903D(2, var_2, var_4);
    }

    if((var_5 & 4) != 0) {
      _id_903D(4, var_2, var_4);
    }

    if((var_5 & 8) != 0) {
      _id_903D(8, var_2, var_4);
    }
  }

  if((var_5 & 16) != 0) {
    _id_AC26(var_2);
    _id_903D(16, var_2, var_4);

    if(isDefined(self.linked_fx) && isDefined(self.linked_fx["tag_eye"])) {
      setfxkillondelete(self.linked_fx["tag_eye"], 1);
      thread delayeddeleteeyesfx();
    }
  }

  if(!var_1 && var_3) {
    _id_054D::_id_90B0(self, var_5, self._id_08D9);
  }

  _id_0547::_id_A19E();
}

_id_903D(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = _id_0547::_id_4744(var_0);
  var_4 = getlimbproperty(var_0, var_3, "tagName");
  var_5 = getlimborigin(var_0, var_4);
  var_6 = self gettagangles(var_4);
  var_7 = undefined;

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_8 = getlimbproperty(var_0, var_3, "modelToSpawn");

  if(var_2 && isDefined(var_8)) {
    var_7 = spawn("script_model", var_5);
    var_7 setModel(var_8);
    var_7.angles = var_6;
    var_9 = (0, 0, _randomfloatrange(1000, 2000));
    var_10 = var_1 * _randomfloatrange(500, 1000);
    var_11 = (_randomfloatrange(-2000, 2000), _randomfloatrange(-2000, 2000), _randomfloatrange(-2000, 2000));
    var_12 = anglestoright(self.angles);

    switch (var_0) {
      case 1:
        var_10 = var_10 + var_12 * 750;
        break;
      case 4:
        var_10 = var_10 + var_12 * 500;
        break;
      case 2:
        var_10 = var_10 - var_12 * 750;
        break;
      case 8:
        var_10 = var_10 - var_12 * 500;
        break;
    }

    var_13 = var_9 + var_10;
    var_14 = length(var_13);
    var_15 = var_13 / var_14;
    var_14 = _min(var_14, 1750);
    var_7 physicslaunchclientwithimpulse(var_15 * var_14, var_11);
    var_7 deleteonhostmigration();

    if(level.nextdismemberedbodypartindex < level.dismemberedbodyparts.size) {
      level.dismemberedbodyparts[level.nextdismemberedbodypartindex] delete();
    }

    level.dismemberedbodyparts[level.nextdismemberedbodypartindex] = var_7;
    level.nextdismemberedbodypartindex = (level.nextdismemberedbodypartindex + 1) % 20;
  }

  var_16 = getlimbproperty(var_0, var_3, "fxTagName");
  var_17 = getlimbproperty(var_0, var_3, "limbFX");
  var_18 = getlimbproperty(var_0, var_3, "gibFX");

  if(common_scripts\utility::_id_562E(getlimbproperty(var_0, var_3, "noGib"))) {
    var_18 = undefined;
  }

  if(isDefined(var_18)) {
    var_19 = self gettagangles(var_16);
    var_20 = anglesToForward(var_19);
    var_21 = anglestoup(var_19);
    var_22 = vectorNormalize(var_20 + 4 * var_1);
    var_23 = vectorNormalize(_vectorcross(var_22, var_21));

    if(_lengthsquared(var_23) < 0.5) {
      var_23 = anglestoright(var_19);
    }

    var_24 = _vectorcross(var_23, var_22);
    playFX(common_scripts\utility::getfx(var_18), self gettagorigin(var_16), var_22, var_24);
  }

  if(isDefined(var_17)) {
    _id_0547::playfxontagnetwork(common_scripts\utility::getfx(var_17), var_7, var_16, 1);
  }

  var_25 = _id_0547::_id_4495();
  var_26 = getlimbproperty(var_0, var_3, var_25);
  thread play_dismember_sound(var_26);
}

play_dismember_sound(var_0) {
  waitframe();

  if(self.health > 0) {
    self playsoundonmovingent(var_0);
  } else {
    maps/taken_tent_fx(var_0, undefined, self.origin);
  }
}

mutatorspawnsound(var_0) {
  self notify("mutatorSpawnSound");
  self endon("mutatorSpawnSound");

  if(common_scripts\utility::_id_562E(self.nomutatorspawnsound)) {
    return;
  }
  if(isDefined(level.mutators[var_0][2])) {
    wait(_randomfloatrange(0.2, 0.8));
    var_1 = level.mutators[var_0][2];
    self playsoundonmovingent(var_1);
  }
}

ondamagefinishedmutators(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  foreach(var_11 in level.mutators) {
    if(isDefined(var_11[4])) {
      self[[var_11[4]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }
  }
}

onkilledmutators(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  foreach(var_10 in level.mutators) {
    if(isDefined(var_10[3])) {
      self[[var_10[3]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  }
}

_id_9E19(var_0, var_1, var_2) {
  if(!(var_2 == "BULLET" || var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_RIFLE_BULLET")) {
    return;
  }
  if(!(var_1 == "helmet" || var_1 == "head" || var_1 == "neck")) {
    return;
  }
  var_3 = 0.25;

  if(_randomfloat(1) > var_3) {
    return;
  }
  _id_AC26(var_0);
}

_id_2CD9() {
  self endon("death");
  self waittill("helmet_pop", var_0);
  _id_AC26(anglestoright(self.angles) + anglestoup(self.angles), var_0);
}

_id_AC26(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");

  if(self.hashelmet || self._id_4B5A) {
    var_2 = self._id_4CAA;
    var_3 = self gettagorigin("j_head") + (0, 0, 20);
    var_4 = self gettagangles("j_head");
    self.hashelmet = 0;
    self._id_4B5A = 0;

    if(isDefined(var_1)) {
      wait(var_1);
    }

    _id_0547::_id_A19E();
    var_5 = spawn("script_model", var_3);
    var_5 setModel(var_2);
    var_5.angles = var_4;
    var_6 = spawn("script_model", var_5.origin);
    var_6 setModel("helmet_collision");
    var_6.angles = var_5.angles;
    var_5 linkTo(var_6);
    var_6._id_6292 = var_5;

    if(!isDefined(var_0)) {
      var_0 = anglesToForward(var_6.angles);
    }

    var_7 = var_0;
    var_8 = var_7[0] * 10000 * _randomfloat(1);
    var_9 = var_7[1] * 10000 * _randomfloat(1);
    var_10 = var_7[2] * 6000 * _randomfloat(1);
    var_11 = var_6.origin + var_0 * -5;
    var_6 physicslaunchclient(var_11, (var_8, var_9, var_10));
    var_6 deleteonhostmigration();
    var_5 deleteonhostmigration();
    var_6 thread _id_2395();
    var_6 hideallparts();
  }
}

_id_2395() {
  level endon("game_ended");
  wait 15;

  if(isDefined(self)) {
    if(isDefined(self._id_6292)) {
      self._id_6292 delete();
    }

    self delete();
  }
}