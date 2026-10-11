/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4fa22bc28608e9bd.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_554830d27078277d;
#using script_5a4a5d9ba343ff8f;
#using script_686729055b66c6e4;
#using script_7edf952f8921aa6b;
#using script_9880b9dc28bc25e;
#using scripts\aitypes\zombie_disciple\zombie_disciple;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace namespace_4d4755f6eec0fa1b;

function function_352431dd86cd1c9f(params) {
  settings = function_cb7771bf461049eb(params);

  if(isDefined(settings)) {
    add_fx("disciple_binding_trail_fx", settings.var_11dc5994234c3df6);
  }
}

function function_7e95224caecd6944() {
  level.var_435b0b02f90918e6 = [];

  function_cf5eaf96bd01b79a();
}

function function_d956fa70427897a() {
  self.bound_zombies = [];
  self.bind_cooldown = 0;
  self.bind_counter = 0;
  self.bind_max = self.zombieaisettings.var_e58a65b7a8f5973c.var_80680f186a663a85;
  self.var_a4c14dc60d4dd398 = self.zombieaisettings.var_e58a65b7a8f5973c.var_119f8409b2099b1c;
  self.bind_disable = self.zombieaisettings.var_e58a65b7a8f5973c.disablebind;
  callback::add("on_ai_killed", &function_785d7295faee2a05);
  thread function_3a97865288f76c1();
  thread function_2ad1bac6e5661a3();
}

function function_2ad1bac6e5661a3() {
  self endon("death");

  while(true) {
    self waittill("bind_start");
    ent_flag_set("playing_binding_anim");
    childthread function_6f68035ca50bc6ea();
    self waittill("bind_stop");
    ent_flag_clear("playing_binding_anim");
    self function_3e89eb3d8e3f1811("in_bind", 0);
  }
}

function function_9bdbd82cc19b68a8() {
  return max(self.bind_max - self.bound_zombies.size, 0);
}

function can_bind_zombies() {
  if(function_9bdbd82cc19b68a8() <= 0 || self.bind_cooldown > gettime() || ent_flag("playing_binding_anim")) {
    return false;
  }

  closest_target = getclosest(self.origin, self.var_a45b8880623f6ceb);

  if(isDefined(closest_target)) {
    trigger_dist = 10000;

    if(lengthsquared(closest_target.velocity) > lengthsquared(self.velocity)) {
      trigger_dist = 20000;
    }

    if(distancesquared(closest_target.origin, self.origin) < trigger_dist) {
      if(!istrue(self.var_c124ffbc8c1883e7)) {
        return true;
      } else if(!closest_target function_3b7a43c0f32fc107()) {
        return true;
      }
    }
  }

  return false;
}

function function_2ff4b9df7de5dbb9() {
  return isDefined(self.binding_zombies) && self.binding_zombies.size > 0;
}

function function_785d7295faee2a05(params) {
  if(isPlayer(params.eattacker) && isDefined(self.bound_zombies) && self.bound_zombies.size >= 5) {
    params.eattacker doscoreeventsharedfunc(#"hash_e1c25b7c92a91404");
  }

  function_c98c0afcd608b815(self.var_a4c14dc60d4dd398);
  level.var_435b0b02f90918e6[self getentitynumber()] = undefined;
}

function function_6f68035ca50bc6ea() {
  var_7e23f88eb99b10f2 = function_9bdbd82cc19b68a8();
  binding_zombies = get_array_of_closest(self.origin, self.var_a45b8880623f6ceb, self.bound_zombies, var_7e23f88eb99b10f2, 200);
  self.binding_zombies = function_fdc9d5557c53078e(binding_zombies);

  if(self.binding_zombies.size <= 0) {
    self function_3e89eb3d8e3f1811("in_bind", 0);
    return;
  }

  bind_time = 2000;
  bind_time += max(0, self.binding_zombies.size - 1) * 2000;

  foreach(zombie in self.binding_zombies) {
    zombie stun_ai(bind_time / 1000 + 1);
    zombie ent_flag_set("disciple_binding");
  }

  var_8b660e984fb7ef71 = 2000;

  if(self.bound_zombies.size == 0) {
    var_8b660e984fb7ef71 *= 0.25;
  }

  var_f36ee2fbccdcd06d = gettime() + var_8b660e984fb7ef71;

  while(true) {
    waitframe();
    self.binding_zombies = function_fdc9d5557c53078e(self.binding_zombies);

    if(self.binding_zombies.size <= 0) {
      break;
    }

    if(!istrue(self getaiblackboarddynamic("in_bind"))) {
      break;
    }

    function_47d28404278627cd();

    if(gettime() > var_f36ee2fbccdcd06d) {
      var_27d0614247095f05 = array_get_first_item(self.binding_zombies);
      var_27d0614247095f05 clear_stun();
      var_27d0614247095f05 ent_flag_clear("disciple_binding");
      function_1fca749b9ae92b76(var_27d0614247095f05);
      var_9c17577ce7bea252 = 2000;

      if(self.bind_counter < 5) {
        var_9c17577ce7bea252 = 500;
      }

      var_f36ee2fbccdcd06d = gettime() + var_9c17577ce7bea252;
      self.binding_zombies = array_remove(self.binding_zombies, var_27d0614247095f05);
    }
  }

  self function_3e89eb3d8e3f1811("in_bind", 0);

  foreach(zombie in self.binding_zombies) {
    if(isDefined(zombie)) {
      zombie clear_stun();
      zombie ent_flag_clear("disciple_binding");
      zombie utility::function_3ab9164ef76940fd("bound", "bound_off");
    }
  }

  self.var_3d330f957ab773d5 = undefined;
  self.binding_zombies = undefined;

  if(self.bind_counter >= 5) {
    self.bind_cooldown = gettime() + 10000;
  }
}

function function_47d28404278627cd() {
  var_27d0614247095f05 = array_get_first_item(self.binding_zombies);

  if(isalive(var_27d0614247095f05)) {
    var_27d0614247095f05 utility::function_3ab9164ef76940fd("bound", "bound_in");
    var_fdfb39a07552c1c7 = vectortoyaw(var_27d0614247095f05.origin - self.origin);
    yaw_diff = absangleclamp180(var_fdfb39a07552c1c7 - self.angles[1]);
    self orientmode("face angle", var_fdfb39a07552c1c7);

    if(yaw_diff <= 30 && (!isDefined(self.var_bd10b456b983ed6b) || self.var_bd10b456b983ed6b != var_27d0614247095f05)) {
      palm_pos = self getcentroid() + (0, 0, 20);
      target_pos = var_27d0614247095f05.origin + (0, 0, 50);
      bolt_speed = getdvarfloat(@ "hash_7e729eb90dd89489", 400);
      assert(bolt_speed > 0);
      n_time = distance(palm_pos, target_pos) / bolt_speed;
      e_bolt = utility::spawn_model("tag_origin", palm_pos);

      if(isDefined(e_bolt)) {
        utility::function_3ab9164ef76940fd("sound_vo", "bind_vo");
        playFXOnTag(getfx("disciple_binding_trail_fx"), e_bolt, "tag_origin");
        e_bolt moveTo(target_pos, n_time);
        e_bolt thread function_4fd65777163a9be4(var_27d0614247095f05);
      }

      self.var_bd10b456b983ed6b = var_27d0614247095f05;
    }
  }
}

function function_4fd65777163a9be4(e_target) {
  self endon("death");
  n_timeout = gettime() + 15000;

  while(isDefined(e_target) && gettime() < n_timeout && e_target ent_flag("disciple_binding")) {
    dist_threshold = getdvarfloat(@ "hash_dbcf496cc1cc3580", 20);

    if(distancesquared(self.origin, e_target.origin + (0, 0, 50)) < squared(dist_threshold)) {
      self delete();
      return;
    }

    waitframe();
  }

  self delete();
}

function function_1fca749b9ae92b76(zombie) {
  if(zombie ent_flag("disciple_bound")) {
    return;
  }

  zombie function_dd21d67ede8ba22(int(zombie.maxhealth * 2));
  zombie.health = zombie.maxhealth;

  if(istrue(self.var_c124ffbc8c1883e7)) {
    zombie[[getsharedfunc("zombie_utils", "set_brainrot")]](self, self.var_66c1831357048c02);
    zombie.team = self.team;
  }

  zombie.commander = self;
  zombie clearenemy();
  zombie clearpath();
  zombie callback::add("on_ai_killed", &zombie_bound_killed);
  zombie ent_flag_set("disciple_bound");

  if(!istrue(self.var_c124ffbc8c1883e7)) {
    zombie utility::function_3ab9164ef76940fd("bound", "bound_on");
  } else {
    zombie utility::function_3ab9164ef76940fd("bound", "bound_disciple_pet");
  }

  zombie callback::callback("on_ai_bound");
  zombie thread function_52c89f7a18377d66();
  self.bound_zombies[self.bound_zombies.size] = zombie;
  self.bind_counter++;
}

function unbind_zombie() {
  assert(isalive(self));

  if(!isalive(self)) {
    return;
  }

  callback::callback("on_ai_unbound");
  function_dd21d67ede8ba22(int(self.maxhealth / 2));
  old_health = self.health;
  self.health = self.maxhealth;
  self.commander = undefined;

  if(old_health < self.maxhealth) {
    self dodamage(self.maxhealth - old_health, self.origin);
  }

  self clearenemy();
  self clearpath();
  callback::remove("on_ai_killed", &zombie_bound_killed);
  ent_flag_clear("disciple_bound");
  utility::function_3ab9164ef76940fd("bound", "bound_off");
}

function zombie_bound_killed(params) {
  if(isalive(self.commander) && isDefined(self.commander.bound_zombies)) {
    self.commander.bound_zombies = array_remove(self.commander.bound_zombies, self);

    if(self.commander.bound_zombies.size == 0 && istrue(self.commander.summon_invulnerability)) {
      self.commander.var_7878d9a79c788c74 = 0;
      self.commander playSound("vox_ai_aether_disciple_vulnerable");

      if(isDefined(level.var_718ee74a7cdbfee5) && isDefined(level.players)) {
        foreach(player in level.players) {
          player[[level.var_718ee74a7cdbfee5]](0);
        }
      }
    }

    if(self.commander._blackboard.var_8d19c6ba087e7a86 != 1) {
      self.commander utility::function_3ab9164ef76940fd("bound_audio", "bound_zombie_killed");
    }
  }
}

function function_c98c0afcd608b815(var_a4c14dc60d4dd398) {
  if(isDefined(self.binding_zombies)) {
    foreach(zombie in self.binding_zombies) {
      if(isDefined(zombie)) {
        zombie clear_stun();
        zombie ent_flag_clear("disciple_binding");
        zombie utility::function_3ab9164ef76940fd("bound", "bound_off");
      }
    }
  }

  if(isDefined(self.bound_zombies)) {
    foreach(zombie in self.bound_zombies) {
      if(isalive(zombie)) {
        if(istrue(var_a4c14dc60d4dd398)) {
          zombie kill();
          continue;
        }

        zombie stun_ai(0.5);
        zombie delaythread(0.5, &unbind_zombie);
      }
    }

    self.bound_zombies = [];
  }
}

function function_997cc9f014de985e() {
  level.var_435b0b02f90918e6[self getentitynumber()] = undefined;

  if(function_9bdbd82cc19b68a8() <= 0) {
    return undefined;
  }

  if(!isarray(self.var_a45b8880623f6ceb) || self.var_a45b8880623f6ceb.size == 0) {
    return undefined;
  }

  if(istrue(self.bind_disable)) {
    return undefined;
  }

  var_82f18a823f6574d = 200;

  foreach(target in self.var_a45b8880623f6ceb) {
    if(!isalive(target)) {
      continue;
    }

    if(distancesquared(self.origin, target.origin) > squared(1000)) {
      continue;
    }

    if(zombie_disciple::function_5bef17118b9a7984(target.origin)) {
      continue;
    }

    if(istrue(target.var_1011e5d6f6934ec0)) {
      continue;
    }

    closest_area = getclosest(target.origin, level.var_435b0b02f90918e6);

    if(!isDefined(closest_area) || distance2dsquared(closest_area.origin, target.origin) > squared(closest_area.radius)) {
      claim_area = spawnStruct();
      claim_area.origin = target.origin;
      claim_area.radius = 200;
      level.var_435b0b02f90918e6[self getentitynumber()] = claim_area;
      return target;
    }
  }

  return undefined;
}

function private function_17deb55afa7ba19e() {
  level endon("game_ended");

  if(isDefined(level.var_c627aeb66d53c60e)) {
    return;
  }

  while(true) {
    level.var_c627aeb66d53c60e = [];
    potential_targets = getaispeciesarray("all", "zombie");
    var_bbe94ce47e0dc921 = 0;

    foreach(target in potential_targets) {
      if(issubstr(target.subclass, "zombie_disciple")) {
        var_bbe94ce47e0dc921 = 1;
        continue;
      }

      if(target ent_flag("disciple_binding") || target ent_flag("disciple_bound")) {
        continue;
      }

      if(!target getscriptablehaspart("bound")) {
        continue;
      }

      if(istrue(target.var_1011e5d6f6934ec0)) {
        continue;
      }

      level.var_c627aeb66d53c60e[level.var_c627aeb66d53c60e.size] = target;
    }

    if(!var_bbe94ce47e0dc921) {
      break;
    }

    wait 1;
  }

  level.var_c627aeb66d53c60e = undefined;
}

function private function_3a97865288f76c1() {
  self endon("death");

  if(!isDefined(level.var_6871167d3305002a)) {
    level.var_6871167d3305002a = throttle_initialize("disciple_bind_seek", 1);
  }

  self.var_a45b8880623f6ceb = [];

  while(true) {
    wait 0.1;
    function_f632348cbb773537(level.var_6871167d3305002a, self);
    self.var_a45b8880623f6ceb = [];

    if(function_9bdbd82cc19b68a8() <= 0) {
      continue;
    }

    scan_dist = 1000;
    scan_dist -= self.bound_zombies.size * 170;
    scan_dist = max(scan_dist, 200);
    seek_targets = [];
    var_c627aeb66d53c60e = [];

    if(!istrue(self.var_c124ffbc8c1883e7)) {
      var_c627aeb66d53c60e = getaiarrayinradius(self.origin, scan_dist, self.team);
    } else {
      var_c627aeb66d53c60e = getaiarrayinradius(self.origin, scan_dist, "team_two_hundred");
    }

    foreach(bind_target in var_c627aeb66d53c60e) {
      if(!isalive(bind_target)) {
        continue;
      }

      if(isDefined(bind_target.aicategory) && (bind_target.aicategory == "special" || bind_target.aicategory == "elite" || bind_target.aicategory == "boss")) {
        continue;
      }

      if(bind_target ent_flag("disciple_binding") || bind_target ent_flag("disciple_bound")) {
        continue;
      }

      if(!bind_target isscriptable()) {
        continue;
      }

      if(!bind_target getscriptablehaspart("bound")) {
        continue;
      }

      if(istrue(bind_target.var_1011e5d6f6934ec0)) {
        continue;
      }

      seek_targets[seek_targets.size] = bind_target;

      if(seek_targets.size > self.bind_max * 2) {
        break;
      }
    }

    self.var_a45b8880623f6ceb = sortbydistance(seek_targets, self.origin);
  }
}

function private function_52c89f7a18377d66() {
  self endon("death");

  if(!isDefined(level.var_e15ecdfc97f7c5ac)) {
    level.var_e15ecdfc97f7c5ac = throttle_initialize("disciple_bound_wander", 1);
  }

  var_e63fb6fee4b75c78 = self._blackboard.var_563d0f6368b6e3f3;
  self._blackboard.var_563d0f6368b6e3f3 = -1;
  var_eb1ea8a3764779a4 = {
    #team: "neutral", #origin: self.origin
  };

  while(true) {
    wait 0.1;
    function_f632348cbb773537(level.var_e15ecdfc97f7c5ac, self);

    if(!isDefined(self.commander)) {
      break;
    }

    if(isDefined(self.enemy)) {
      continue;
    }

    if(distancesquared(self.commander.origin, self.origin) < 40000) {
      continue;
    }

    var_eb1ea8a3764779a4.origin = getclosestpointonnavmesh(self.commander.origin);
    zombie_attractor_manager::function_c0d3ba0eab1acba0(var_eb1ea8a3764779a4);

    while(true) {
      wait 0.1;
      function_f632348cbb773537(level.var_e15ecdfc97f7c5ac, self);

      if(!isDefined(self.commander)) {
        break;
      }

      if(isDefined(self.enemy)) {
        break;
      }

      if(distancesquared(var_eb1ea8a3764779a4.origin, self.origin) < 10000) {
        break;
      }
    }

    zombie_attractor_manager::function_6e660434fe00b495(var_eb1ea8a3764779a4);
    self._blackboard.zombiewanderorigin = self.origin;
  }

  self._blackboard.var_563d0f6368b6e3f3 = var_e63fb6fee4b75c78;
}

function private function_cf5eaf96bd01b79a() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_a9a864379a098ad6("<dev string:x39>", "<dev string:x47>", &force_bind);
  function_a9a864379a098ad6("<dev string:x55>", "<dev string:x63>", &function_db5535809b0dccc5);
  function_a9a864379a098ad6("<dev string:x71>", "<dev string:x8a>", &function_e318de3b93fddd0d);
  function_fe953f000498048f();
}

function private force_bind() {
  disciple = function_30dd4f3ef5f328ea(level.players[0].origin, undefined, undefined, "<dev string:xa1>");

  if(isDefined(disciple)) {
    disciple function_3e89eb3d8e3f1811("<dev string:xb4>", 1);
  }
}

function private function_db5535809b0dccc5() {
  function_2fb888667001fc39("<dev string:xbf>", @ "hash_bcd6dcf5babd2641");
}

function private function_e318de3b93fddd0d() {
  disciple = function_30dd4f3ef5f328ea(level.players[0].origin, undefined, undefined, "<dev string:xa1>");

  if(isDefined(disciple)) {
    disciple function_c98c0afcd608b815();
  }
}

function private function_701e81274adba94a(text, pos) {
  if(getdvarint(@ "hash_bcd6dcf5babd2641", 0)) {
    pos = default_to(pos, self.origin + (0, 0, 70));
    print3d(pos, "<dev string:xd6>" + text, (1, 0, 0));
  }
}

# /