/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_24c32478acf44108.gsc
***********************************************/

#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_9ff9f642;

function private autoexec __init__system__() {
  system::register(#"hash_308dff40d53a7287", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "" + # "hash_419c1c8da4dc53a9", 1, 1, "int");
}

function register_burn(str_type, n_dps, n_duration, var_f472bfc, var_5713c703) {
  if(!isDefined(level.var_981dd9cf)) {
    level.var_981dd9cf = [];
  } else if(!isarray(level.var_981dd9cf)) {
    level.var_981dd9cf = array(level.var_981dd9cf);
  }

  if(!isDefined(level.var_981dd9cf[# "burn"])) {
    level.var_981dd9cf[# "burn"] = [];
  } else if(!isarray(level.var_981dd9cf[# "burn"])) {
    level.var_981dd9cf[# "burn"] = array(level.var_981dd9cf[# "burn"]);
  }

  level.var_981dd9cf[# "burn"][str_type] = {
    #n_dps: n_dps, #n_duration: n_duration, #var_f472bfc: var_f472bfc, #var_5713c703: var_5713c703
  };
}

function burn(str_type, e_attacker, weapon, var_477abb8f) {
  if(is_true(self.var_38255de6)) {
    return;
  }

  if(!isDefined(level.var_981dd9cf) || !isDefined(level.var_981dd9cf[# "burn"]) || !isDefined(level.var_981dd9cf[# "burn"][str_type])) {
    assertmsg("<dev string:x38>" + str_type + "<dev string:x42>");
    return;
  }

  if(!isDefined(self.var_88421cc2)) {
    self.var_88421cc2 = [];
  } else if(!isarray(self.var_88421cc2)) {
    self.var_88421cc2 = array(self.var_88421cc2);
  }

  var_cfb3f538 = 0;

  if(!self.var_88421cc2.size) {
    var_cfb3f538 = 1;
  }

  s_burn = level.var_981dd9cf[# "burn"][str_type];

  if(!isDefined(self.var_88421cc2[str_type])) {
    self.var_88421cc2[str_type] = {
      #n_time_remaining: s_burn.n_duration, #e_owner: e_attacker, #weapon: weapon, #var_477abb8f: var_477abb8f
    };
  } else {
    if(self.var_88421cc2[str_type].n_time_remaining < s_burn.n_duration) {
      self.var_88421cc2[str_type].n_time_remaining = s_burn.n_duration;
    }

    if(isDefined(var_477abb8f)) {
      if(!isDefined(self.var_88421cc2[str_type].var_477abb8f) || self.var_88421cc2[str_type].var_477abb8f != var_477abb8f) {
        self.var_88421cc2[str_type].var_477abb8f = var_477abb8f;
      }
    } else if(isDefined(self.var_88421cc2[str_type].var_477abb8f)) {
      self.var_88421cc2[str_type].var_477abb8f = undefined;
    }
  }

  if(var_cfb3f538) {
    self thread function_8aefaae3(s_burn);
  }
}

function private function_8aefaae3(s_burn) {
  level endon(#"end_game");
  self endoncallback(&function_fc2a294, #"death");

  if(isDefined(self.archetype)) {
    if(isDefined(s_burn.var_f472bfc)) {
      str_clientfield = s_burn.var_f472bfc;
    } else {
      str_clientfield = "" + # "hash_419c1c8da4dc53a9";
    }

    self clientfield::set(str_clientfield, 1);
    self.var_a2bceb12 = str_clientfield;

    if(isDefined(s_burn.var_5713c703)) {
      self.var_fa03f342 = s_burn.var_5713c703;
    }
  }

  while(true) {
    wait 1;
    n_total_damage = 0;
    var_25c61d06 = 0;
    var_2af3b934 = undefined;
    weapon = undefined;

    foreach(str_type, var_39d0f0a8 in self.var_88421cc2) {
      if(!isDefined(var_2af3b934)) {
        var_2af3b934 = var_39d0f0a8.e_owner;
      }

      if(!isDefined(weapon)) {
        weapon = var_39d0f0a8.weapon;
      }

      n_damage = 0;
      n_time_remaining = var_39d0f0a8.n_time_remaining;

      if(isDefined(var_39d0f0a8.var_477abb8f)) {
        n_dps = var_39d0f0a8.var_477abb8f;
      } else {
        n_dps = level.var_981dd9cf[# "burn"][str_type].n_dps;
      }

      if(n_time_remaining > 1) {
        var_39d0f0a8.n_time_remaining -= 1;
        n_damage = n_dps * 1;
      } else if(n_time_remaining > 0) {
        var_39d0f0a8.n_time_remaining = 0;
        n_damage = n_dps * n_time_remaining;
      }

      if(n_damage > var_25c61d06) {
        var_25c61d06 = n_damage;
        var_2af3b934 = var_39d0f0a8.e_owner;
        weapon = var_39d0f0a8.weapon;
      }

      n_total_damage += n_damage;

      if(var_39d0f0a8.n_time_remaining <= 0) {
        self.var_88421cc2[str_type] = undefined;
      }
    }

    arrayremovevalue(self.var_88421cc2, undefined, 1);

    if(n_total_damage) {
      self dodamage(n_total_damage, self.origin, var_2af3b934, undefined, "none", "MOD_BURNED", 0, weapon);
    }

    if(!self.var_88421cc2.size) {
      self function_fc2a294();
      return;
    }
  }
}

function function_5e9ef773() {
  self.var_38255de6 = 1;
}

function private function_fc2a294(var_c34665fc) {
  if(isDefined(self.archetype)) {
    if(isDefined(self.var_a2bceb12)) {
      self clientfield::set(self.var_a2bceb12, 0);
      self.var_a2bceb12 = undefined;
    }

    if(isDefined(self.var_fa03f342) && !isDefined(var_c34665fc)) {
      self.var_fa03f342 = undefined;
    }
  }
}

function freeze() {
  if(!isactor(self)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  if(isDefined(self.var_b030dabb)) {
    self.var_b030dabb.n_count++;
  } else {
    self.var_b030dabb = {
      #n_count: 1, #b_ignore_cleanup: self.b_ignore_cleanup, #var_dbcf9b4b: self.is_inert
    };
  }

  self thread function_bf97ba95();
  self setentitypaused(1);
  self.b_ignore_cleanup = 1;
  self.is_inert = 1;
}

function unfreeze() {
  if(!isactor(self)) {
    return;
  }

  self notify(#"hash_55e2fa9139b08b3e");
  var_b030dabb = self.var_b030dabb;
  var_b030dabb.n_count--;

  if(var_b030dabb.n_count == 0) {
    self setentitypaused(0);
    self.is_inert = var_b030dabb.var_dbcf9b4b;
    self.b_ignore_cleanup = var_b030dabb.b_ignore_cleanup;
    self.var_b030dabb = undefined;
  }
}

function private function_bf97ba95() {
  self notify(#"hash_55e2fa9139b08b3e");
  self endon(#"hash_55e2fa9139b08b3e");
  self waittill(#"death");

  if(isDefined(self) && self ispaused()) {
    self setentitypaused(0);

    if(!self isragdoll()) {
      self zm_utility::start_ragdoll();
    }
  }
}

function function_865a83f8(zombie, target, predictedpos, var_95342913) {
  if(is_true(zombie.knockdown) || is_true(zombie.pushed)) {
    return false;
  }

  if(gibserverutils::isgibbed(zombie, 384)) {
    return false;
  }

  checkpos = zombie.origin;

  if(!isactor(target)) {
    checkpos = zombie getcentroid();
    var_95342913 = 64;
  }

  var_caa95837 = var_95342913 * var_95342913;
  distsq = distancesquared(predictedpos, checkpos);

  if(distsq > var_caa95837) {
    return false;
  }

  origin = target.origin;
  facingvec = anglesToForward(target.angles);
  enemyvec = zombie.origin - origin;
  var_3e3c8075 = (enemyvec[0], enemyvec[1], 0);
  var_c2ee8451 = (facingvec[0], facingvec[1], 0);
  var_3e3c8075 = vectornormalize(var_3e3c8075);
  var_c2ee8451 = vectornormalize(var_c2ee8451);
  enemydot = vectordot(var_c2ee8451, var_3e3c8075);

  if(enemydot < 0) {
    return false;
  }

  return true;
}

function register_slowdown(str_type, n_rate, n_duration = -1) {
  if(!isDefined(level.var_981dd9cf)) {
    level.var_981dd9cf = [];
  } else if(!isarray(level.var_981dd9cf)) {
    level.var_981dd9cf = array(level.var_981dd9cf);
  }

  if(!isDefined(level.var_981dd9cf[# "slow"])) {
    level.var_981dd9cf[# "slow"] = [];
  } else if(!isarray(level.var_981dd9cf[# "slow"])) {
    level.var_981dd9cf[# "slow"] = array(level.var_981dd9cf[# "slow"]);
  }

  level.var_981dd9cf[# "slow"][str_type] = {
    #n_rate: n_rate, #n_duration: n_duration
  };
}

function slowdown(str_type, var_a47cf2b2, callback) {
  if(is_true(self.var_b736fc8b)) {
    return;
  }

  if(is_true(self.var_7b0667d9)) {
    return;
  }

  self notify(#"starting_slowdown_ai");
  level endon(#"end_game");
  self endoncallback(&function_fe7a7d5b, #"starting_slowdown_ai", #"death");

  if(!isDefined(level.var_981dd9cf) || !isDefined(level.var_981dd9cf[# "slow"]) || !isDefined(level.var_981dd9cf[# "slow"][str_type])) {
    assertmsg("<dev string:x76>" + str_type + "<dev string:x84>");
    return;
  }

  if(!isDefined(self.a_n_slowdown_timeouts)) {
    self.a_n_slowdown_timeouts = [];
  } else if(!isarray(self.a_n_slowdown_timeouts)) {
    self.a_n_slowdown_timeouts = array(self.a_n_slowdown_timeouts);
  }

  s_slowdown = level.var_981dd9cf[# "slow"][str_type];
  n_time = gettime();
  n_timeout = n_time + int(s_slowdown.n_duration * 1000);

  if(!isDefined(self.a_n_slowdown_timeouts[str_type]) || self.a_n_slowdown_timeouts[str_type].timeout < n_timeout) {
    self.a_n_slowdown_timeouts[str_type] = {
      #timeout: n_timeout, #callback: callback
    };
  }

  for(n_slowdowns = self.a_n_slowdown_timeouts.size; n_slowdowns; n_slowdowns = self.a_n_slowdown_timeouts.size) {
    str_lowest_type = undefined;
    n_lowest_rate = 10;
    self function_e01e1ea1();

    foreach(str_index, var_94aa4140 in self.a_n_slowdown_timeouts) {
      if(str_index == str_type && isDefined(var_a47cf2b2)) {
        n_rate = var_a47cf2b2;
      } else {
        n_rate = level.var_981dd9cf[# "slow"][str_index].n_rate;
      }

      if(n_rate < n_lowest_rate) {
        str_lowest_type = str_index;
        n_lowest_rate = n_rate;
      }
    }

    if(isDefined(str_lowest_type)) {
      var_dc1625a7 = level.var_981dd9cf[# "slow"][str_lowest_type];
      var_e489fea = self.a_n_slowdown_timeouts[str_lowest_type].timeout;
      self asmsetanimationrate(n_lowest_rate);

      if(var_dc1625a7.n_duration == -1) {
        self waittill(#"hash_62a477d53a6bbad");
      } else {
        n_duration = var_e489fea - n_time;
        self waittilltimeout(float(n_duration) / 1000, #"hash_62a477d53a6bbad");
      }

      if(var_e489fea < gettime() && var_dc1625a7.n_duration != -1) {
        callback = self.a_n_slowdown_timeouts[str_lowest_type].callback;
        self.a_n_slowdown_timeouts[str_lowest_type] = undefined;

        if(isDefined(callback)) {
          self thread[[callback]]();
        }
      }
    }

    self function_e01e1ea1();
  }

  self asmsetanimationrate(1);
}

function private function_e01e1ea1() {
  n_time = gettime();

  foreach(str_index, var_94aa4140 in self.a_n_slowdown_timeouts) {
    if(level.var_981dd9cf[# "slow"][str_index].n_duration != -1 && var_94aa4140.timeout <= n_time || var_94aa4140.timeout == -1) {
      callback = self.a_n_slowdown_timeouts[str_index].callback;
      self.a_n_slowdown_timeouts[str_index] = undefined;

      if(isDefined(callback)) {
        self thread[[callback]]();
      }
    }
  }

  arrayremovevalue(self.a_n_slowdown_timeouts, undefined, 1);
}

function function_5d2b8af2() {
  self.var_7b0667d9 = 1;
}

function function_520f4da5(str_type) {
  if(isDefined(str_type) && isDefined(self.a_n_slowdown_timeouts) && isDefined(self.a_n_slowdown_timeouts[str_type])) {
    self.a_n_slowdown_timeouts[str_type].timeout = -1;
  }

  self notify(#"hash_62a477d53a6bbad");
}

function private function_fe7a7d5b(str_notify) {
  if(isalive(self) && hasasm(self)) {
    self asmsetanimationrate(1);
    self.var_2e874959 = undefined;
  }
}