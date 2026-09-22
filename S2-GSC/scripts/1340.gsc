/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1340.gsc
**************************************/

_id_4F84() {
  if(self._id_00CA) {
    return 0;
  }

  if(common_scripts\utility::_id_562E(self._id_1723)) {
    return 0;
  }

  if(!isDefined(self._id_28D2)) {
    return 0;
  }

  if(self._id_0BA4 == "melee" || maps\mp\agents\_scripted_agent_anim_util::_id_57E2()) {
    return 0;
  }

  if(!_id_0547::_id_4B2C()) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid::_id_A7F8()) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid::_id_2EE6()) {
    return 0;
  }

  var_0 = common_scripts\utility::_id_562E(self._id_5F4C) && isDefined(self._id_5F48) && gettime() - self._id_5F48 <= self._id_5F46;

  if(maps\mp\agents\humanoid\_humanoid::_id_2EE5() || var_0) {
    if(!maps\mp\agents\humanoid\_humanoid::_id_7AC0("base")) {
      return 0;
    }
  } else if(!maps\mp\agents\humanoid\_humanoid::_id_7AC0("normal"))
    return 0;

  if(isDefined(self._id_60E4) && isDefined(self._id_5BC0)) {
    var_1 = gettime() - self._id_5BC0;

    if(var_1 < self._id_60E4 * 1000) {
      return 0;
    }
  }

  if(!isDefined(self._id_5BC1) || distancesquared(self._id_5BC1, self.origin) > 256) {
    self._id_60ED = self._id_0108;
  }

  if(isDefined(self.custom_on_melee_func)) {
    self thread[[self.custom_on_melee_func]]();
  }

  self scragentbeginmelee(self._id_28D2);
  return 1;
}

_id_0631() {
  if(isDefined(self._id_6618)) {
    return self._id_6618;
  }

  return self scragentgetgoalpos();
}

_id_06CE(var_0) {
  self._id_6618 = var_0;
  self notify("new_navigation_goal");
  var_1 = 1500;
  var_2 = gettime();
  var_3 = self._id_AAF3;
  var_4 = isDefined(var_3) && var_2 - var_3 < var_1;
  var_5 = !isDefined(self._id_A08E) || var_4;
  var_6 = undefined;

  if(!var_5) {
    var_7 = _func_32A(self.origin, self._id_6618, self);
    self._id_AAF3 = var_2;

    if(isDefined(var_7)) {
      foreach(var_9 in var_7) {
        if(_id_0549::_id_553A(var_9)) {
          var_6 = var_9;
          break;
        }
      }
    }
  }

  var_11 = isDefined(var_6) && isDefined(self._id_A08E) && isDefined(var_6._id_15CB) && var_6._id_15CB == self._id_A08E._id_15CB;

  if(!(var_4 || var_11)) {
    if(isDefined(self._id_A08E)) {
      self._id_6617 = 1;
    }

    self scragentsetgoalpos(self._id_6618);
  } else {}
}

_id_0778() {
  self endon("death");
  childthread _id_0779();
  childthread _id_077A();
  _id_8A62(0);

  for(;;) {
    self waittill("traverse_soon");
    var_0 = self getnegotiationstartnode();

    if(isDefined(var_0)) {
      thread _id_077B(var_0);
    }

    if(isDefined(var_0) && !isDefined(self._id_A08E)) {
      for(;;) {
        if(isDefined(var_0._id_54F5) && var_0._id_54F5) {
          if(isDefined(var_0._id_A228) && var_0._id_A228 != self) {
            if(!_id_584A()) {
              thread _id_21B5(var_0);
              common_scripts\utility::_id_A70A("traversal_unblocked");
              _id_8A62(0);
            }

            break;
          } else if(isDefined(var_0._id_A228) && var_0._id_A228 == self) {
            break;
          }
        }

        waitframe();
      }
    }
  }
}

_id_21B5(var_0) {
  self endon("death");

  for(;;) {
    var_1 = _func_32A(self.origin, self._id_6618, self);

    if(var_1.size > 0) {
      if((var_0 != var_1[0] || !var_0._id_54F5) && (!isDefined(var_1[0]._id_54F5) || !var_1[0]._id_54F5)) {
        self scragentsetgoalpos(self._id_6618);
        waitframe();
        self notify("traversal_unblocked");
        break;
      } else {
        _id_8A62(1);
        wait 0.5;
      }

      continue;
    }

    waitframe();
    self notify("traversal_unblocked");
    break;
  }
}

_id_8A62(var_0) {
  self._id_A6D2 = var_0;

  if(var_0) {
    self scragentsetscripted(1);
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "Waiting For Traversal");
    var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("idle_noncombat");
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
    var_3 = self getanimentry(var_1, var_2);
    maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_1, var_2);
  } else {
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "Waiting For Traversal");
    self scragentsetscripted(0);
  }
}

_id_584A() {
  return self._id_A6D2;
}

_id_077A() {
  for(;;) {
    self waittill("traverse_end");
    self._id_AAF3 = undefined;
  }
}

_id_0779() {
  for(;;) {
    self waittill("path_script_blocked", var_0);
    _id_0647();
  }
}

_id_077B(var_0) {
  self endon("death");
  self endon("new_navigation_goal");
  self endon("traverse_soon");
  self endon("traverse_complete");
  _id_0647();

  for(;;) {
    var_0 waittill("barricaded");
    _id_0647();
  }
}

_id_0647() {
  var_0 = self getnegotiationstartnode();

  if(!_id_5597()) {
    if(isDefined(var_0) && _id_0547::_id_562C(var_0)) {
      var_1 = 0;

      if(isDefined(self._id_A08E) && var_0._id_15CB != self._id_A08E._id_15CB) {
        _id_4F85();
        var_1 = 1;
      } else if(!isDefined(self._id_A08E))
        var_1 = 1;

      if(var_1) {
        self._id_A08E = var_0;
      }
    } else if(isDefined(self._id_A08E)) {
      if(!_id_0547::_id_562C(self._id_A08E)) {
        _id_4F85();
        self scragentsetgoalpos(self._id_6618);
        self._id_A08E = undefined;
        self notify("lost_barricaded_traversal");
      } else if(common_scripts\utility::_id_562E(self._id_6617)) {
        _id_4F85();
        self scragentsetgoalpos(self._id_6618);
        self._id_A08E = undefined;
        self notify("lost_barricaded_traversal");
      }
    } else {}
  }

  if(isDefined(self._id_A08E)) {
    _id_4F8D();
  } else if(isDefined(self._id_A08F)) {
    _id_4F8A(self._id_A08F);
  } else if(isDefined(self._id_AC08)) {
    _id_4F8B(self._id_AC08);
  }

  self._id_6617 = undefined;
}

_id_4F8A(var_0) {
  self scragentsetgoalpos(var_0);

  while(distance(self.origin, var_0) > 32) {
    wait 0.1;
  }

  self._id_A08F = undefined;
}

_id_4F8B(var_0) {
  var_0 endon("death");
  self endon("death");
  self endon("no_alt_paths");
  var_1 = 0.15;
  var_2 = 1;
  var_3 = 0;
  var_4 = [];
  thread _id_298D(var_0);

  while(!isDefined(self._id_AC17) || distance(self.origin, self._id_AC17) > 8) {
    wait(var_1);
    var_3 = var_3 + var_1;

    if(var_3 >= var_2) {
      thread _id_1436();
      break;
    }
  }

  thread _id_1436();
  self notify("out_of_zombie_range");
}

_id_298D(var_0) {
  var_1 = 3;
  self endon("out_of_zombie_range");
  var_2 = 45;
  var_3 = 15;
  var_4 = 96;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    if(_id_5724(var_0)) {
      if(_id_5769(var_0)) {
        var_6 = var_0.angles + (0, -1 * (var_2 + var_3 * var_5), 0);
      } else {
        var_6 = var_0.angles + (0, var_2 + var_3 * var_5, 0);
      }
    } else
      break;

    var_7 = anglesToForward(var_6);
    var_7 = common_scripts\utility::_id_3D5D(var_7);
    var_7 = vectorNormalize(var_7);
    var_8 = self.origin + var_7 * (var_4 / (var_5 + 1));

    if(var_5 < var_1 - 1) {
      var_9 = _func_2E1(var_8, self);
      var_10 = (var_8[0], var_8[1], var_9[2] + 8);
    } else
      var_10 = _func_2E1(self.origin, self);

    self._id_AC17 = var_10;
    self waittill("bad_path");
  }

  self notify("no_alt_paths");

  if(distance(self.origin, var_0.origin) < 32) {
    self dodamage(self.health + 666, self.origin);
  }
}

_id_1436() {
  wait 0.75;
  self._id_AC08 = undefined;
}

_id_5724(var_0) {
  var_1 = anglesToForward(var_0.angles + (0, 0, 0));
  var_1 = common_scripts\utility::_id_3D5D(var_1);
  var_1 = vectorNormalize(var_1);
  var_2 = var_0.origin + 64 * var_1;
  var_1 = anglesToForward(var_0.angles + (0, 180, 0));
  var_1 = common_scripts\utility::_id_3D5D(var_1);
  var_1 = vectorNormalize(var_1);
  var_3 = var_0.origin + 64 * var_1;
  return distance(self.origin, var_2) < distance(self.origin, var_3);
}

_id_5769(var_0) {
  var_1 = anglesToForward(var_0.angles + (0, -90, 0));
  var_1 = common_scripts\utility::_id_3D5D(var_1);
  var_1 = vectorNormalize(var_1);
  var_2 = var_0.origin + 64 * var_1;
  var_1 = anglesToForward(var_0.angles + (0, 90, 0));
  var_1 = common_scripts\utility::_id_3D5D(var_1);
  var_1 = vectorNormalize(var_1);
  var_3 = var_0.origin + 64 * var_1;
  return distance(self.origin, var_2) < distance(self.origin, var_3);
}

_id_4F9B(var_0) {
  if(self._id_00CA) {
    self._id_28D2 = undefined;
    return 0;
  }

  if(common_scripts\utility::_id_562E(level.gameended)) {
    return 0;
  }

  var_1 = undefined;

  if(isDefined(self._id_1928)) {
    var_1 = self._id_1928;
  } else if(isDefined(self._id_1924)) {
    var_1 = self._id_1924;
  } else if(isDefined(level._id_1CC4) && common_scripts\utility::_id_562E(self._id_56EB) && _id_0C35()) {
    var_1 = level._id_1CC4;
  } else if(_id_AB86() && !common_scripts\utility::_id_562E(self.has_lost_distractiondrone_interest)) {
    var_1 = self._id_3043;
  } else if(isDefined(self._id_9B61) && !_id_5686()) {
    if(isDefined(self._id_9B61.target) && !isDefined(self._id_9B61._id_76A3)) {
      self._id_9B61._id_76A3 = common_scripts\utility::_id_46B5(self._id_9B61.target, "targetname");
    }

    if(isDefined(self._id_9B61._id_76A3) && !common_scripts\utility::_id_562E(self._id_4B3B)) {
      var_1 = self._id_9B61._id_76A3;

      if(distance(self.origin, self._id_9B61._id_76A3.origin) < 48) {
        self._id_4B3B = 1;
        var_1 = self._id_9B61;
      }
    } else
      var_1 = self._id_9B61;
  } else if(isDefined(self._id_1927) && !_id_5686())
    var_1 = self._id_1927;
  else if(isDefined(self._id_0088) && !_id_0547::_id_8B95(self._id_0088)) {
    var_1 = self._id_0088;
  }

  if(isDefined(var_1)) {
    var_2 = self._id_11AB + self.radius * 2;
    var_3 = var_2 * var_2;
    var_4 = self._id_11AB;
    var_5 = var_4 * var_4;
    self._id_28D2 = var_1;
    var_6 = maps\mp\agents\humanoid\_humanoid::_id_457E(var_1);
    var_7 = var_6._id_3771;
    var_8 = distancesquared(var_6.origin, self.origin);
    var_9 = distancesquared(var_7, self.origin);
    var_10 = self._id_173E;

    if(var_9 < _squared(self.radius) && distancesquared(var_7, var_6.origin) > _squared(self.radius)) {
      var_10 = 1;
      self notify("attack_anim", "end");
    }

    if(isDefined(var_0) && var_0) {
      if(!var_10 && var_9 > var_3) {
        var_10 = 1;
      }
    } else if(!var_10 && var_9 > var_3 && var_8 > var_5)
      var_10 = 1;

    if(var_6._id_A266) {
      if(!var_10 && var_8 > _squared(self._id_2BCA)) {
        var_10 = 1;
      }

      self scragentsetgoalRadius(self._id_2BCA);
    } else if(!maps\mp\agents\humanoid\_humanoid_util::_id_4BA3(var_1, self._id_60F5)) {
      self scragentsetgoalRadius(self._id_2BCA);
      var_10 = 1;
    } else {
      self scragentsetgoalRadius(var_2);

      if(var_9 <= var_3) {
        var_6.origin = self.origin;
        var_10 = 1;
      }
    }

    if(var_10) {
      var_11 = _func_2E1(var_6.origin, self);

      if(distancesquared(var_11, var_1.origin) > distancesquared(var_6.origin, var_1.origin)) {
        var_11 = _func_2E1(var_1.origin, self);
      }

      if(isDefined(self.override_snapped_point_func) && isPlayer(var_1)) {
        var_11 = [[self.override_snapped_point_func]](var_1, var_11);
      }

      _id_06CE(var_11);
    }

    _id_0647();
    return 1;
  } else {
    if(isDefined(self._id_28D2)) {
      self._id_173E = 1;
    }

    self._id_28D2 = undefined;
  }

  return 0;
}

_id_AB86() {
  return isDefined(self._id_3043) && maps\mp\agents\humanoid\_humanoid_util::_id_8BAE();
}

_id_0C35() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(common_scripts\utility::_id_562E(var_2._id_7414) || var_2.inlaststand || !isalive(var_2)) {
      var_0++;
    }
  }

  return var_0 == level.players.size;
}

_id_5686() {
  return isDefined(self._id_983C) && self._id_983C.size > 0;
}

humanoid_has_valid_targets(var_0) {
  if(!common_scripts\utility::_id_562E(var_0) && (isDefined(self._id_3043) || isDefined(self._id_1928))) {
    return 1;
  }

  foreach(var_2 in _func_2D1()) {
    if(humanoid_is_valid_target(var_2)) {
      return 1;
    }
  }

  return 0;
}

humanoid_is_valid_target(var_0) {
  if(var_0._id_00CE || isDefined(var_0._id_0117) && var_0._id_0117._id_00CE) {
    return 0;
  }

  if(var_0 isnotarget() || isDefined(var_0._id_0117) && var_0._id_0117 isnotarget()) {
    return 0;
  }

  if(_isalliedsentient(self, var_0)) {
    return 0;
  }

  if(_id_0547::_id_8B95(var_0)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  return 1;
}

_id_4F88() {
  if(isDefined(self._id_3043)) {
    return [];
  }

  if(isDefined(self.forcedtargets) && _isarray(self.forcedtargets) && self.forcedtargets.size > 0) {
    var_0 = [];
    self.forcedtargets = common_scripts\utility::_id_0FA0(self.forcedtargets);

    foreach(var_2 in self.forcedtargets) {
      if(_isremovedentity(var_2)) {
        continue;
      }
      var_0 = common_scripts\utility::_id_0F6F(var_0, var_2);
    }

    self.forcedtargets = var_0;
    return _sortbydistance(var_0, self.origin);
  }

  var_4 = [];

  foreach(var_6 in _func_2D1()) {
    if(humanoid_is_valid_target(var_6)) {
      var_4[var_4.size] = var_6;
    }
  }

  if(0 == var_4.size) {
    return [];
  }

  return _sortbydistance(var_4, self.origin);
}

_id_4F9A() {
  if(self._id_00CA) {
    return 0;
  }

  var_0 = _id_4F88();

  if(isDefined(var_0) && var_0.size > 0) {
    var_1 = 300;
    var_2 = distancesquared(var_0[0].origin, self.origin);

    if(var_2 < var_1 * var_1) {
      var_1 = 16;
    }

    if(self._id_173E || distancesquared(self scragentgetgoalpos(), var_0[0].origin) > var_1 * var_1) {
      var_3 = _func_2E1(var_0[0].origin);
      _id_06CE(var_3);
      self._id_173E = 0;
    }

    _id_0647();
    return 1;
  }

  return 0;
}

_id_4F87(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(self._id_173E || distancesquared(_id_0631(), var_0.origin) > _squared(128)) {
    _id_06CE(var_0.origin);
    self._id_173E = 0;
  }

  _id_0647();
  return 1;
}

_id_4F7F(var_0, var_1) {
  var_2 = 234;

  if(!isDefined(self)) {
    return;
  }
  self endon("death");

  if(common_scripts\utility::_id_562E(self._id_9E1A) || common_scripts\utility::_id_562E(level.zmb_fog_passive_lock)) {
    return;
  }
  if(!common_scripts\utility::_id_3794("zombie_passive")) {
    return;
  }
  self._id_9E1A = 1;

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    foreach(var_4 in maps\mp\agents\_agent_utility::_id_43FD("all")) {
      if(self == var_4) {
        continue;
      }
      if(distance(self.origin, var_4.origin) < var_2) {
        var_4 thread _id_4F80();
      }
    }
  }

  if(isDefined(self._id_9024)) {
    var_6 = level._id_AC80._id_ACB3[self._id_9024];
    var_7 = 10;

    for(self.passive_activation_time_ms = gettime(); !common_scripts\utility::_id_3C77(var_6._id_AC8A); var_7 = var_7 - var_8) {
      if(var_7 <= 0 || !_id_054D::_id_0F0A(self)) {
        _id_056D::_id_5A86();
      }

      var_8 = _randomfloatrange(0.5, 1);
      wait(var_8);
    }

    waitframe();
  }

  self.passive_activation_time_ms = gettime();
  common_scripts\utility::_id_3796("zombie_passive");
  humanoid_reset_passive_data();

  if(isDefined(self.post_passive_func)) {
    self thread[[self.post_passive_func]]();
  }
}

_id_4F80() {
  self endon("death");
  var_0 = 0.25;
  var_1 = 1;
  wait(_randomfloatrange(var_0, var_1));
  _id_4F7F("wakeup chain", 1);
}

humanoid_passive_register_wakeup_func(var_0) {
  if(!isDefined(level.passive_check_wakeup_funcs)) {
    level.passive_check_wakeup_funcs = [];
  }

  level.passive_check_wakeup_funcs[level.passive_check_wakeup_funcs.size] = var_0;
}

humanoid_passive_check_wakeup_threads() {
  self endon("zombie_no_longer_passive");
  childthread _id_4F96();
  childthread _id_4F98();
  childthread _id_4F97();

  if(isDefined(level.passive_check_wakeup_funcs)) {
    foreach(var_1 in level.passive_check_wakeup_funcs) {
      self childthread[[var_1]]();
    }
  }
}

_id_4F95() {
  self endon("death");

  for(;;) {
    common_scripts\utility::_id_379C("zombie_passive");
    childthread humanoid_passive_check_wakeup_threads();
    common_scripts\utility::_id_37A1("zombie_passive");
    self notify("zombie_no_longer_passive");
  }
}

_id_4F96() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isPlayer(var_1)) {
      if(_id_0547::_id_8B95(var_1) || isDefined(var_9) && issubstr(var_9, "austen_pap_zm")) {
        continue;
      }
      self.woken_by_player_aggro = 1;
    }

    break;
  }

  _id_4F7F("damaged");
}

_id_4F98() {
  var_0 = 0.5;
  var_1 = int(var_0 * 20);
  var_2 = 0;

  while(!var_2) {
    wait(var_0);

    if(isDefined(level.passive_wakeup_range_func)) {
      var_2 = self[[level.passive_wakeup_range_func]]();
      continue;
    }

    var_2 = humanoid_passive_default_should_wakeup_range();
  }

  _id_4F7F("player close");
}

humanoid_passive_default_should_wakeup_range() {
  var_0 = 234;
  var_1 = var_0;

  if(isDefined(self._id_6EB0)) {
    var_1 = self._id_6EB0;
  }

  var_2 = 0.5;
  var_3 = int(var_2 * 20);
  var_4 = _id_4F88()[0];

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = distance(self.origin, var_4.origin);

  if(var_5 > var_1) {
    return 0;
  }

  return 1;
}

_id_4F97() {
  var_0 = self._id_66AC;

  if(isDefined(var_0)) {
    wait(var_0);

    while(!humanoid_has_valid_targets(1)) {
      wait 1;
    }

    _id_4F7F("passive time max: " + maps\mp\_utility::limitdecimalplaces(var_0));
    self._id_66AC = undefined;
  }
}

_id_2208() {
  var_0 = 390;
  var_1 = 78;
  var_2 = 64;
  var_3 = 0;
  var_4 = self._id_37BB;
  var_5 = maps\mp\agents\_agent_utility::_id_43FD("all");

  for(;;) {
    var_4 = _func_2DF(var_4, var_0);
    var_6 = 0;

    foreach(var_8 in var_5) {
      if(var_8 == self) {
        continue;
      }
      if(isDefined(var_8._id_6EAE) && distance(var_8._id_6EAE, var_4) < var_2) {
        var_6 = 1;
        break;
      }

      if(isDefined(var_8._id_37BB) && distance(var_8._id_37BB, var_4) < var_1) {
        var_6 = 1;
        break;
      }
    }

    if(!var_6) {
      break;
    }

    var_3++;

    if(var_3 > 10) {
      var_3 = 0;
      waitframe();
    }
  }

  return var_4;
}

_id_9C74() {
  self._id_6EAF = "idle";
  self scragentsetscripted(1);

  if(isDefined(self.custom_passive_action)) {
    [[self.custom_passive_action]]();
  } else {
    maps\mp\agents\_scripted_agent_anim_util::_id_8410("idle_noncombat");
  }

  self._id_6EAE = self.origin;
  self scragentclearpath();
}

_id_4F8C() {
  var_0 = 8;

  if(common_scripts\utility::_id_3794("zombie_passive")) {
    if(!isDefined(self._id_6EAF)) {
      self.woken_by_player_aggro = undefined;

      if(common_scripts\utility::_id_562E(self._id_47F1)) {
        self._id_47F1 = 0;
        _id_9C74();
      } else {
        self._id_6EAF = "leaving_spawn_closet";

        if(!_id_0547::_id_4B2C() && isDefined(self._id_9024)) {
          _id_06CE(level._id_AC80._id_ACB3[self._id_9024]._id_74DC);
        }
      }
    }

    if(self._id_6EAF == "leaving_spawn_closet" && _id_0547::_id_4B2C()) {
      self._id_6EAF = "searching_for_goal";
      self._id_6EAE = _id_2208();

      if(!common_scripts\utility::_id_3794("zombie_passive")) {
        return 1;
      }

      self._id_6EAF = "pathing_to_goal";
      _id_06CE(self._id_6EAE);
    }

    if(self._id_6EAF == "pathing_to_goal" && _id_0547::_id_2436(self._id_6EAE, self.origin, var_0, 32)) {
      _id_9C74();
    }

    _id_0647();
    return 1;
  } else {
    if(isDefined(self._id_6EAF)) {
      humanoid_reset_passive_data();
    }

    return 0;
  }
}

humanoid_reset_passive_data() {
  if(isDefined(self._id_6EAF)) {
    if(self._id_6EAF == "idle" && !maps\mp\agents\_scripted_agent_anim_util::_id_57E2()) {
      self scragentsetscripted(0);
    }

    self._id_6EAF = undefined;
  }

  self._id_9E1A = undefined;
  self._id_A7A8 = undefined;
}

_id_635C() {
  self endon("death");

  for(;;) {
    var_0 = _id_4F88();
    var_1 = var_0.size > 0;
    var_2 = isDefined(self._id_3043) || isDefined(self._id_1927) || isDefined(self._id_9B61) || _id_5686();

    if(common_scripts\utility::_id_3794("zombie_passive")) {
      if(common_scripts\utility::_id_562E(self._id_A7A8) && var_1 || var_2) {
        _id_4F7F("target point available");
      }
    } else if(!var_1 && !var_2 && !is_passive_exempt()) {
      common_scripts\utility::_id_379A("zombie_passive");
      self._id_A7A8 = 1;
    }

    wait 0.5;
  }
}

is_passive_exempt() {
  return isDefined(level.zmb_exempt_from_passive_list) && common_scripts\utility::_id_0F79(level.zmb_exempt_from_passive_list, self._id_0A4B) || common_scripts\utility::_id_562E(self.ispassiveexempt);
}

_id_4F8D() {
  if(!isDefined(self._id_9D04)) {
    if(self._id_0BA4 != "traverse" && _id_0547::_id_4B24()) {
      self._id_9D04 = 0;
    } else {
      self._id_9D04 = undefined;
      return 0;
    }
  }

  if(common_scripts\utility::_id_562E(self._id_6617)) {
    if(isDefined(self._id_2308)) {
      self scragentsetgoalpos(self._id_2308.origin);
    } else if(isDefined(self._id_A6E6)) {
      self scragentsetgoalpos(self._id_A6E6);
    }
  }

  switch (self._id_9D04) {
    case 0:
      if(!_id_0547::_id_4B24()) {
        _id_4F85();
        return 0;
      }

      var_0 = self._id_A08E._id_15CB;
      var_1 = var_0 _id_0549::_id_15DB(self);

      if(isDefined(var_1)) {
        self scragentsetgoalpos(var_1.origin);
        self._id_9D04 = 1;
        return 1;
      } else {
        if(isDefined(self._id_A6E6)) {
          return 1;
        }

        self._id_A6E6 = var_0 _id_0549::_id_15DE();
        self scragentsetgoalpos(self._id_A6E6);
        return 1;
      }
    case 1:
      if(!_id_0547::_id_4B24()) {
        _id_4F85();
        return 0;
      }

      var_2 = self scragentgetgoalpos();

      if(distancesquared(var_2, self._id_2308.origin) > 1024) {
        self scragentsetgoalpos(self._id_2308.origin);
      }

      var_3 = self.radius * self.radius;
      var_4 = _distance2dsquared(self.origin, self._id_2308.origin);

      if(var_4 > var_3) {
        return 1;
      }

      return _id_4F81();
    case 3:
      if(isDefined(self._id_15D2)) {
        return 1;
      }

      return _id_4F81();
    case 5:
      if(common_scripts\utility::_id_562E(self._id_983D)) {
        return 1;
      }

      return _id_4F81();
  }

  return 0;
}

_id_4F85() {
  if(isDefined(self._id_9D04)) {
    var_0 = self._id_A08E._id_15CB;

    switch (self._id_9D04) {
      case 0:
        self._id_A6E6 = undefined;
        break;
      case 3:
        if(isDefined(var_0._id_15D9)) {
          var_1 = level._id_AAEF[var_0._id_15D9];

          if(isDefined(var_1)) {
            self[[var_1]](var_0);
          }
        }

        var_0 _id_0549::_id_15DF(self);
        break;
      case 1:
        var_0 _id_0549::_id_15DF(self);
        break;
      case 5:
        var_0 _id_0549::_id_15DF(self);
        break;
    }

    self._id_9D04 = undefined;
  }
}

_id_4F81() {
  var_0 = self._id_A08E._id_15CB;

  if(!_id_0547::_id_4B24()) {
    _id_4F85();
    return 0;
  }

  if(isDefined(var_0._id_15D9)) {
    var_1 = level._id_AAF0[var_0._id_15D9];

    if(isDefined(var_1)) {
      var_2 = self[[var_1]](var_0);

      if(common_scripts\utility::_id_562E(var_2)) {
        return 1;
      }
    }
  }

  thread _id_4F9C();
  return 1;
}

_id_4F99(var_0, var_1) {
  self endon("board_pull_interrupted");
  self._id_9D04 = 3;
  self._id_15D2 = "pulling_board";
  self scragentsetscripted(1);
  self scragentsetphysicsmode("noclip");
  _id_1888("grab");
  _id_1888("hold");
  var_0 thread _id_0549::_id_15D3(var_1._id_1887);
  _id_1888("pull");
  self._id_15D2 = undefined;
  self scragentsetscripted(0);
  self scragentsetphysicsmode("gravity");
  var_0 _id_0549::_id_15E0(self);
}

_id_1888(var_0) {
  var_1 = "board_" + self._id_2308._id_0EA5 + "_" + var_0;
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_1);
  var_3 = self._id_2309._id_1887;
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self._id_2308.angles);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_3, 1, "board_pull");
}

_id_4F89() {
  var_0 = self._id_A08E._id_15CB;
  var_1 = var_0 _id_0549::_id_15DD(self);
  return var_1;
}

_id_4F83(var_0) {
  self endon("death");
  self._id_9D04 = 3;
  self._id_15D2 = "attacking_through_boards";
  var_1 = self._id_A08E._id_15CB;
  var_2 = var_1._id_38EB.angles;
  self scragentsetorientmode("face angle abs", var_2);
  var_3 = "attack_stand";
  var_4 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_3);
  var_5 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_4);
  self._id_117A = var_0;
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_4, var_5, 1.0, "attack_anim", undefined, ::_id_1179);
  self scragentsetscripted(0);
  self._id_15D2 = undefined;
}

_id_1179(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_117A) && isalive(self._id_117A)) {
    switch (var_0) {
      case "zombie_melee":
        var_4 = self._id_117A.health;

        if(isDefined(self._id_60E2)) {
          var_4 = self._id_60E2;
        }

        maps\mp\agents\humanoid\_humanoid_melee::_id_3210(self._id_117A, var_4, "MOD_IMPACT");
        self._id_117A = undefined;
        break;
    }
  }
}

_id_4F92(var_0) {
  self endon("drop_gate_interact_interrupt");
  var_1 = var_0._id_15CC;
  self._id_9D04 = 3;
  self._id_15D2 = "lifting_gj_gate";
  self scragentsetscripted(1);
  self scragentsetphysicsmode("noclip");
  _id_4F93(var_0);

  while(var_1._id_17E9) {
    if(common_scripts\utility::_id_562E(var_1._id_5CCB)) {
      _id_346C("lift", var_0, "gate_state_changed", var_1);
      continue;
    }

    thread _id_0549::_id_346E(var_1);
    _id_346C("idle", var_0, "pull_state_change", var_1);
    _id_0549::_id_346D(var_1);
    waittillframeend;
  }

  self scragentsetscripted(0);
  self scragentsetphysicsmode("gravity");
  self._id_15D2 = undefined;
}

_id_4F86(var_0) {
  self endon("drop_gate_interact_interrupt");
  var_1 = var_0._id_15CC;
  self._id_9D04 = 3;
  self._id_15D2 = "crawling_under_gj_gate";
  self scragentsetscripted(1);
  self scragentsetphysicsmode("noclip");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("gj_lift_gate_crawl_under");
  var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_2);
  var_4 = self getanimentry(var_2, var_3);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self._id_2308.angles);
  self scragentsetgoalpos(self._id_6618);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_3, 1, "gj_gate_drop");
  thread _id_4F85();
}

_id_4F93(var_0) {
  var_1 = var_0._id_15CC;

  if(var_1 _id_0549::_id_3463()) {
    _id_346C("mount", var_0, "pull_state_change", var_1);
  }
}

_id_346C(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    var_3 endon(var_2);
  }

  var_4 = var_1._id_15CC;
  var_0 = var_4 _id_0549::_id_345B(self, var_0);
  var_5 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0);
  var_6 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_5);
  var_7 = self getanimentry(var_5, var_6);
  var_8 = undefined;

  if(_animhasnotetrack(var_7, "end_start")) {
    var_9 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_7, "end_start");
    var_8 = (1 - var_9) * _getanimlength(var_7);
    var_8 = _randomfloatrange(0.0, var_8);
  }

  var_10 = _getstartorigin(var_1.getweaponlistall, var_1.getviewkickscale, var_7);
  var_11 = _getstartangles(var_1.getweaponlistall, var_1.getviewkickscale, var_7);
  self setOrigin(var_10, 0);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", var_11);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_5, var_6, 1, "gj_gate_drop", "end_start");

  if(isDefined(var_8)) {
    wait(var_8);
  }
}

_id_4F9C() {
  self endon("death");
  var_0 = "board_taunt";
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0);
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  self._id_9D04 = 5;
  self._id_983D = 1;
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self._id_2308.angles);
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1.0, "taunt_anim");
  self scragentsetscripted(0);
  self._id_983D = undefined;
}

_id_4F82() {
  self endon("death");
  var_0 = "attack_stand";
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0);
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self._id_2308.angles);
  self scragentsetscripted(1);
  self._id_567F = 1;
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1.0, "attack_anim");
  self._id_567F = 0;
  self scragentsetscripted(0);
}

_id_5597() {
  if(isDefined(self._id_9D04)) {
    switch (self._id_9D04) {
      case 1:
      case 0:
        return 0;
      case 5:
      case 3:
        return 1;
    }
  }

  return 0;
}

_id_4F94(var_0) {
  _id_4F85();
}

_id_6AA4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  _id_4F85();
}