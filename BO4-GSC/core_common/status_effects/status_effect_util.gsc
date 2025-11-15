/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_util.gsc
*************************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\player\player_role;
#include scripts\core_common\util_shared;

#namespace status_effect;

private register_status_effect(status_effect_type) {
  if(!isDefined(level._status_effects)) {
    level._status_effects = [];
  }

  if(!isDefined(level._status_effects[status_effect_type])) {
    level._status_effects[status_effect_type] = spawnStruct();
  }
}

function_6f4eaf88(var_756fda07) {
  if(!isDefined(var_756fda07)) {
    println("<dev string:x38>");
    return;
  }

  if(!isDefined(var_756fda07.setype)) {
    var_756fda07.setype = 0;
  }

  register_status_effect(var_756fda07.setype);
  level.var_233471d2[var_756fda07.setype] = var_756fda07;
}

register_status_effect_callback_apply(status_effect, apply_func) {
  register_status_effect(status_effect);

  if(isDefined(apply_func)) {
    level._status_effects[status_effect].apply = apply_func;
  }
}

private function_b24f18a1() {
  if(isDefined(self.owner)) {
    if(function_7d17822(self.setype)) {
      self.owner function_89ae38c1(self.namehash);
    }

    if(isDefined(self.var_36c77790)) {
      if(isplayer(self.owner)) {
        self.owner playlocalsound(self.var_36c77790);
      }
    }

    if(isDefined(self.var_801118b0)) {
      if(isplayer(self.owner)) {
        self.owner stoploopsound(0.5);
      }
    }

    self.owner function_14fdd7e2(self.var_4f6b79a4);
    self[[level._status_effects[self.setype].var_a4c649a2]]();
    self.owner.var_121392a1[self.var_18d16a6b] = undefined;
    self notify(#"endstatuseffect");
  }
}

function_5bae5120(status_effect, end_func) {
  register_status_effect(status_effect);

  if(isDefined(end_func)) {
    level._status_effects[status_effect].end = &function_b24f18a1;
    level._status_effects[status_effect].var_a4c649a2 = end_func;
    level._status_effects[status_effect].death = level._status_effects[status_effect].end;
  }
}

function_6d888241(status_effect, death_func) {
  register_status_effect(status_effect);

  if(isDefined(death_func)) {
    level._status_effects[status_effect].death = death_func;
  }
}

function_e2bff3ce(status_effect_type, weapon, applicant) {
  if(isDefined(level.var_233471d2[status_effect_type])) {
    self status_effect_apply(level.var_233471d2[status_effect_type], weapon, applicant);
  }
}

private function_91a9db75(sourcetype, setype, namehash) {
  if(!isDefined(self.var_121392a1)) {
    self.var_121392a1 = [];
  }

  if(!isDefined(self.var_121392a1[sourcetype])) {
    self.var_121392a1[sourcetype] = spawnStruct();
  }

  if(!isDefined(self.var_121392a1[sourcetype].duration)) {
    self.var_121392a1[sourcetype].duration = 0;
  }

  if(!isDefined(self.var_121392a1[sourcetype].endtime)) {
    self.var_121392a1[sourcetype].endtime = 0;
  }

  if(!isDefined(self.var_121392a1[sourcetype].owner)) {
    self.var_121392a1[sourcetype].owner = self;
  }

  self.var_121392a1[sourcetype].setype = setype;
  self.var_121392a1[sourcetype].namehash = namehash;
  self.var_121392a1[sourcetype].var_18d16a6b = sourcetype;
}

status_effect_apply(var_756fda07, weapon, applicant, isadditive, durationoverride, var_894859a2, location) {
  assert(isDefined(var_756fda07.setype));
  assert(isDefined(var_756fda07.var_18d16a6b));

  if(isDefined(self.registerpreparing_time_) && self.registerpreparing_time_) {
    return;
  }

  if(isDefined(var_894859a2)) {
    var_756fda07.seduration *= var_894859a2;

    if(isDefined(durationoverride)) {
      durationoverride *= var_894859a2;
    }
  }

  register_status_effect(var_756fda07.setype);
  var_f8f8abaa = 0;

  if(isDefined(applicant) && applicant != self && !self function_4aac137f(applicant, var_756fda07.var_18d16a6b)) {
    var_b7a9b136 = 1;

    if(isDefined(var_756fda07.var_2e4a8800)) {
      var_8725a10d = globallogic_score::function_3cbc4c6c(var_756fda07.var_2e4a8800);
    }

    if(isDefined(var_8725a10d) && isDefined(var_8725a10d.var_3e3b11a9)) {
      resistance = function_3c54ae98(var_756fda07.setype);

      if(var_8725a10d.var_3e3b11a9 < resistance) {
        var_b7a9b136 = 0;
      }
    }

    if(var_b7a9b136 && util::function_fbce7263(self.team, applicant.team)) {
      applicant thread globallogic_score::function_969ea48d(var_756fda07, weapon);
    }

    var_f8f8abaa = 1;
  }

  self function_91a9db75(var_756fda07.var_18d16a6b, var_756fda07.setype, var_756fda07.namehash);
  self function_52969ffe(var_756fda07);
  self callback::callback(#"on_status_effect", var_756fda07);
  var_275b5e13 = function_2ba2756c(var_756fda07.var_18d16a6b) > level.time;
  var_b0144580 = applicant === self;

  if(!isDefined(isadditive)) {
    isadditive = getdvarint(#"hash_6ce4aefbba354e2d", 0);
  }

  effect = self.var_121392a1[var_756fda07.var_18d16a6b];
  effect.var_4f6b79a4 = var_756fda07;

  if(isDefined(location)) {
    effect.location = location;
  } else if(isDefined(applicant)) {
    effect.location = applicant.origin;
  }

  effect handle_sounds(var_756fda07);
  var_4df0ea83 = 1;

  if(isDefined(var_756fda07.var_4df0ea83)) {
    var_4df0ea83 = var_756fda07.var_4df0ea83;
  }

  if(var_4df0ea83) {
    if(isadditive && var_756fda07.setype != 4) {
      effect function_57f33b96(var_756fda07, var_b0144580, durationoverride, applicant, var_f8f8abaa, weapon);
    } else {
      effect update_duration(var_756fda07, var_b0144580, durationoverride, applicant, var_f8f8abaa, weapon);
    }
  }

  maxduration = effect function_f9ca1b6a(var_756fda07);

  if(maxduration > 0 && self.var_121392a1[var_756fda07.var_18d16a6b].duration > maxduration) {
    self.var_121392a1[var_756fda07.var_18d16a6b].duration = maxduration;
  } else if(self.var_121392a1[var_756fda07.var_18d16a6b].duration > 65536 - 1) {
    self.var_121392a1[var_756fda07.var_18d16a6b].duration = 65536 - 1;
  }

  if(isDefined(weapon) && weapon.doesfiredamage) {
    if(isplayer(self)) {
      self clientfield::set("burn", 1);
    }
  }

  if(!var_275b5e13) {
    effect function_5d973c5f();
  }

  if(isDefined(level._status_effects[var_756fda07.setype].apply)) {
    effect.var_4b22e697 = applicant;
    effect.var_3d1ed4bd = weapon;
    effect thread[[level._status_effects[var_756fda07.setype].apply]](var_756fda07, weapon, applicant);
    thread function_86c0eb67(effect, "begin");
  }

  var_1d673e46 = !isplayer(self) || self hastalent(#"talent_resistance") && !(isDefined(var_756fda07.var_857e12ae) && var_756fda07.var_857e12ae);

  if(!var_1d673e46 && !isDefined(effect.var_b5207a36)) {
    if(isDefined(var_756fda07.var_208fb7da)) {
      effect.var_b5207a36 = self gestures::function_c77349d4(var_756fda07.var_208fb7da);
    }

    if(!isDefined(effect.var_b5207a36)) {
      if(isDefined(var_756fda07.var_b5207a36)) {
        effect.var_b5207a36 = var_756fda07.var_b5207a36;
      }
    }

    if(isDefined(effect.var_b5207a36)) {
      self thread function_35d7925d(effect);
    }
  }

  if(function_7d17822(var_756fda07.setype)) {
    self thread function_47cad1aa(var_756fda07, isadditive);
  }

  if(isDefined(weapon) && isDefined(applicant) && applicant != self && isDefined(var_756fda07.var_3469b797) && var_756fda07.var_3469b797) {
    var_594a2d34 = isDefined(weapon) && isDefined(weapon.var_965cc0b3) && weapon.var_965cc0b3;
    applicant util::show_hit_marker(0, var_594a2d34);
  }

  if(isDefined(level._status_effects[var_756fda07.setype].end)) {
    effect thread wait_for_end();
  }
}

private function_35d7925d(effect) {
  effect endon(#"endstatuseffect");
  self endon(#"death");

  while(isDefined(effect.var_b5207a36) && isalive(self)) {
    if(isDefined(level.var_d0ad09c5)) {
      self[[level.var_d0ad09c5]](effect);
    }

    if(self gestures::play_gesture(effect.var_b5207a36, undefined, 0)) {
      return;
    }

    wait 0.5;
  }
}

private function_47cad1aa(var_756fda07, isadditive) {
  var_18d16a6b = var_756fda07.var_18d16a6b;
  setype = var_756fda07.setype;

  if(isDefined(self.var_121392a1[var_18d16a6b]) && isDefined(self.var_121392a1[var_18d16a6b].duration)) {
    if(setype != 4) {
      if(isplayer(self)) {
        assert(!isfloat(self.var_121392a1[var_18d16a6b].duration), "<dev string:x94>");
        self applystatuseffect(var_756fda07.namehash, self.var_121392a1[var_18d16a6b].duration, isadditive);
      }
    }
  }
}

private function_89ae38c1(sename) {
  if(isplayer(self)) {
    self endstatuseffect(sename);
  }
}

private function_52969ffe(var_756fda07) {
  player = self;

  if(isDefined(var_756fda07.var_3edb6e25) && var_756fda07.var_3edb6e25 && isplayer(player)) {
    player disableoffhandspecial();
    player disableoffhandweapons();
  }
}

private function_14fdd7e2(var_756fda07) {
  player = self;

  if(isDefined(var_756fda07.var_3edb6e25) && var_756fda07.var_3edb6e25 && isplayer(player)) {
    player enableoffhandspecial();
    player enableoffhandweapons();
  }
}

private function_6bf7c434(status_effect_type) {
  if(isDefined(self.var_b5207a36)) {
    self.owner stopgestureviewmodel(self.var_b5207a36, 1, 0);
    self.var_b5207a36 = undefined;
  }

  if(isDefined(self.var_4b22e697)) {
    self.var_4b22e697 globallogic_score::allow_old_indexs(self.var_4f6b79a4);
  }

  if(isDefined(level._status_effects) && isDefined(level._status_effects[status_effect_type]) && isDefined(level._status_effects[status_effect_type].end)) {
    self thread[[level._status_effects[status_effect_type].end]]();
  }

  thread function_86c0eb67(self, "end");

  if(isDefined(self.var_3d1ed4bd) && isDefined(self.owner) && self.var_3d1ed4bd.doesfiredamage) {
    if(isplayer(self.owner)) {
      self.owner clientfield::set("burn", 0);
    }
  }

  self.var_4b22e697 = undefined;
  self notify(#"endstatuseffect");
}

private wait_for_end() {
  if(0 && self.setype == 6) {
    return;
  }

  self notify(#"endwaiter");
  self endon(#"endwaiter", #"endstatuseffect");
  self.owner endon(#"disconnect");

  while(self.endtime > level.time) {
    waitframe(1);
  }

  if(isDefined(self)) {
    self thread function_6bf7c434(self.setype);
  }
}

function_408158ef(setype, var_18d16a6b) {
  if(isDefined(self.var_121392a1)) {
    if(isDefined(level._status_effects[setype].end)) {
      effect = self.var_121392a1[var_18d16a6b];

      if(isDefined(effect)) {
        effect function_6bf7c434(setype);
      }
    }
  }
}

function_6519f95f() {
  if(isDefined(self.var_121392a1)) {
    foreach(effect in self.var_121392a1) {
      if(isDefined(level._status_effects[effect.setype].end)) {
        effect function_6bf7c434(effect.setype);
      }
    }
  }
}

private handle_sounds(var_756fda07) {
  endtime = self.endtime;

  if(isDefined(var_756fda07.var_b86e9a5e)) {
    if(level.time > endtime && isplayer(self.owner)) {
      self.owner playlocalsound(var_756fda07.var_b86e9a5e);
    }
  }

  if(isDefined(var_756fda07.var_801118b0)) {
    if(level.time > endtime && isplayer(self.owner)) {
      self.owner playLoopSound(var_756fda07.var_801118b0);
    }

    self.var_801118b0 = var_756fda07.var_801118b0;
  }

  if(isDefined(var_756fda07.var_36c77790)) {
    self.var_36c77790 = var_756fda07.var_36c77790;
  }
}

status_effect_get_duration(var_eeb47fb8) {
  if(!isDefined(self.var_121392a1)) {
    self.var_121392a1 = [];
  }

  return isDefined(self.var_121392a1[var_eeb47fb8]) ? self.var_121392a1[var_eeb47fb8].duration : 0;
}

function_2ba2756c(var_eeb47fb8) {
  if(!isDefined(self.var_121392a1)) {
    self.var_121392a1 = [];
  }

  return isDefined(self.var_121392a1[var_eeb47fb8]) ? self.var_121392a1[var_eeb47fb8].endtime : 0;
}

function_7f14a56f(status_effect_type) {
  if(!isDefined(self.var_121392a1)) {
    self.var_121392a1 = [];
  }

  var_e2997f02 = 0;

  foreach(effect in self.var_121392a1) {
    if(effect.setype == 7) {
      var_e2997f02 += effect.var_adb1692a * effect.var_5cf129b8 / 1000;
    }
  }

  return var_e2997f02;
}

function_4617032e(status_effect_type) {
  if(!isDefined(self.var_121392a1)) {
    self.var_121392a1 = [];
  }

  foreach(effect in self.var_121392a1) {
    if(effect.setype == status_effect_type) {
      return true;
    }
  }

  return false;
}

private function_40293e80(status_effect_type) {
  if(status_effect_type == 3) {
    return "flakjacket";
  }

  return "resistance";
}

private update_duration(var_756fda07, var_b0144580, durationoverride, applicant, var_f8f8abaa, weapon) {
  setype = var_756fda07.setype;
  resistance = self function_a6613b51(var_756fda07);
  var_fb887b00 = var_b0144580 ? self.owner function_37683813() : 1;

  if(var_b0144580 && isDefined(weapon) && isDefined(weapon.var_83b1dc1) && weapon.var_83b1dc1) {
    var_fb887b00 = 1;
  }

  if(getgametypesetting(#"competitivesettings") !== 1 || weapon !== getweapon("eq_concertina_wire")) {
    if(resistance > 0 && isDefined(applicant) && var_f8f8abaa && var_756fda07.var_42c00474 === 1 && !var_b0144580 && setype !== 0) {
      applicant damagefeedback::update(undefined, undefined, function_40293e80(setype));
    }
  }

  newduration = 0;

  if(isDefined(durationoverride)) {
    newduration = durationoverride;
  } else {
    newduration = var_756fda07.seduration;
  }

  newduration = int(newduration * (1 - resistance) * var_fb887b00);
  var_2226e3f0 = self.endtime;
  time = level.time;
  maxduration = self function_f9ca1b6a(var_756fda07);

  if(isDefined(var_2226e3f0)) {
    var_b5051685 = var_2226e3f0 - time;

    if(var_b5051685 < newduration) {
      self.duration = newduration;

      if(maxduration && self.duration > maxduration) {
        self.duration = maxduration;
      }

      self.endtime = time + self.duration;
    }

    return;
  }

  self.duration = newduration;

  if(maxduration && self.duration > maxduration) {
    self.duration = maxduration;
  }

  self.endtime = time + self.duration;
}

private function_57f33b96(var_756fda07, var_b0144580, durationoverride, applicant, var_f8f8abaa, weapon) {
  setype = var_756fda07.setype;
  resistance = self function_a6613b51(var_756fda07);

  if(isDefined(var_756fda07.var_857e12ae) && var_756fda07.var_857e12ae) {
    resistance = 0;
  }

  var_fb887b00 = var_b0144580 ? self.owner function_37683813() : 1;

  if(var_b0144580 && isDefined(weapon) && isDefined(weapon.var_83b1dc1) && weapon.var_83b1dc1) {
    var_fb887b00 = 1;
  }

  if(getgametypesetting(#"competitivesettings") !== 1 || weapon !== getweapon("eq_concertina_wire")) {
    if(resistance > 0 && setype != 0 && setype != 3 && isDefined(applicant) && var_f8f8abaa && var_756fda07.var_42c00474 === 1 && !var_b0144580) {
      applicant damagefeedback::update(undefined, undefined, function_40293e80(setype), weapon, self.owner);
    }
  }

  newduration = 0;

  if(isDefined(durationoverride)) {
    newduration = durationoverride;
  } else {
    newduration = var_756fda07.seduration;
  }

  newduration = int(newduration * (1 - resistance) * var_fb887b00);
  time = level.time;
  maxduration = self function_f9ca1b6a(var_756fda07);

  if(isDefined(self.duration)) {
    if(isDefined(self.endtime) && self.endtime > time) {
      if(maxduration && newduration > maxduration) {
        newduration = maxduration;
      }

      self.duration += newduration;
      self.endtime = gettime() + newduration;
    } else {
      self.duration = newduration;

      if(maxduration && self.duration > maxduration) {
        self.duration = maxduration;
      }

      self.endtime = time + newduration;
    }

    return;
  }

  self.duration = newduration;

  if(maxduration && self.duration > maxduration) {
    self.duration = maxduration;
  }

  self.endtime = time + newduration;
}

private function_5d973c5f() {
  self thread function_72886b31();
  self thread function_150a8541();
}

function_150a8541() {
  self notify(#"loadoutwatcher");
  self endon(#"loadoutwatcher", #"endstatuseffect");
  self.owner endon(#"death", #"disconnect");
  var_eff9d37f = self.owner function_3c54ae98(self.setype);

  while(true) {
    self.owner waittill(#"loadout_given");
    newres = self.owner function_3c54ae98(self.setype);
    currtime = level.time;

    if(newres != var_eff9d37f) {
      timeremaining = self.endtime - currtime;
      timeremaining *= newres;
      self.endtime = int(currtime + timeremaining);
      self.duration = int(timeremaining);
    }
  }
}

function_72886b31() {
  self notify(#"deathwatcher");
  self endon(#"deathwatcher", #"endstatuseffect");
  self.owner waittill(#"death");

  if(isDefined(self.var_4b22e697)) {
    self.var_4b22e697 thread globallogic_score::function_fc47f2ff(self.var_4f6b79a4);
  }

  if(isDefined(self) && isDefined(level._status_effects[self.setype].death)) {
    self[[level._status_effects[self.setype].death]]();
  }
}

function_3c54ae98(status_effect_type) {
  if(!isplayer(self)) {
    return 0;
  }

  if(sessionmodeiszombiesgame()) {
    if(!player_role::is_valid(self player_role::get())) {
      return 0;
    }
  }

  resistance = self getplayerresistance(status_effect_type);
  return resistance;
}

function_37683813() {
  if(!isplayer(self)) {
    return 1;
  }

  scalar = self function_9049b079();
  return scalar;
}

private function_a6613b51(var_756fda07) {
  effect = self;
  setype = var_756fda07.setype;
  resistance = effect.owner function_3c54ae98(setype);

  if(isDefined(var_756fda07.var_857e12ae) && var_756fda07.var_857e12ae) {
    resistance = 0;
  }

  if(setype == 7) {
    resistance = 0;
  }

  return resistance;
}

private function_f9ca1b6a(var_756fda07) {
  effect = self;
  resistance = effect function_a6613b51(var_756fda07);
  maxduration = int(var_756fda07.var_ca171ecc * (1 - resistance));
  return maxduration;
}

private function_7d17822(status_effect_type) {
  return status_effect_type < 9;
}

function_7505baeb(callback_function) {
  level.var_90391bcc = callback_function;
}

function_86c0eb67(status_effect, var_3bc85d80) {
  if(!isDefined(level.var_90391bcc)) {
    return;
  }

  [[level.var_90391bcc]](status_effect, var_3bc85d80);
}

private function_4aac137f(var_19201a97, sourcetype) {
  gametime = level.time;
  endtime = function_2ba2756c(sourcetype);
  isactive = function_2ba2756c(sourcetype) > gametime;

  if(!isactive) {
    return false;
  }

  if(!isDefined(self.var_121392a1[sourcetype]) || !isDefined(self.var_121392a1[sourcetype].var_4b22e697) || !isDefined(var_19201a97)) {
    return false;
  }

  return self.var_121392a1[sourcetype].var_4b22e697 == var_19201a97;
}