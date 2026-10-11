/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4c688cf7f824cb29.gsc
*************************************************/

#using script_686729055b66c6e4;
#using script_6bffae1b97f70547;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace deadwire;

function init_deadwire() {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return;
  }

  level endon("game_ended");
  level._effect["vfx_perk_dw_aoe_exp"] = loadfx("vfx/jup/ob/gameplay/zm_weapons/vfx_perk_dw_aoe_exp.vfx");
  flag_wait("ammo_mods_ready");
  flag_init("deadwire_ready");
  var_746d800f9d085b2a = default_to(level.var_f1240a9ac4f65616.deadwirepercentage, 0.2);
  var_ad5528a4132dc97d = default_to(level.var_f1240a9ac4f65616.var_d582785a41a462cd, 0.04);
  cooldownentity = default_to(level.var_f1240a9ac4f65616.var_508bf57826aa4710, 0);
  cooldownattacker = default_to(level.var_f1240a9ac4f65616.var_f5d90e6daa6bbab4, 15);
  cooldownglobal = default_to(level.var_f1240a9ac4f65616.var_f2f97526966640ac, 15);
  var_f27a8d5708fd9c4d = default_to(level.var_f1240a9ac4f65616.var_724408de2e09faac, 1);
  damagefeedbackicon = default_to(level.var_f1240a9ac4f65616.var_1212283d4ed9b1a1, "");
  damagefeedbacksound = default_to(level.var_f1240a9ac4f65616.var_628a8a44395b472f, "");
  element = default_to(level.var_f1240a9ac4f65616.deadwireelement, "electrical");
  level.deadwire_throttle = throttle_initialize("deadwire", 2, 1);
  level.var_347f02218c1bdfaa = [];
  level.var_474baa8191a671a8 = [];
  function_7f759db5de1b44b0("deadwire", 3, var_746d800f9d085b2a, var_ad5528a4132dc97d, cooldownentity, cooldownattacker, cooldownglobal, var_f27a8d5708fd9c4d, &function_9f332972d199fdda, damagefeedbackicon, damagefeedbacksound, &function_34506c532bfbda54, element, &function_dc3f0e5b8db53339);
  flag_set("deadwire_ready");

  level thread function_6c46532ee1ae7b03();
}

function function_ca3453d66c7654b5(func) {
  level.var_347f02218c1bdfaa[level.var_347f02218c1bdfaa.size] = func;
}

function function_48c02397f0acdf83(func) {
  level.var_474baa8191a671a8[level.var_474baa8191a671a8.size] = func;
}

function function_9f332972d199fdda(death, attacker, mod, sweapon, vpoint, shitloc, modelindex) {
  if(level.var_347f02218c1bdfaa.size > 0) {
    foreach(result_func in level.var_347f02218c1bdfaa) {
      [[result_func]](death, attacker, mod, sweapon, vpoint, shitloc, modelindex);
    }

    return;
  }

  if(isDefined(self.aicategory) && (self.aicategory == "normal" || self.aicategory == "special")) {
    if(!istrue(ent_flag("deadwire_stunned"))) {
      deadwiretime = default_to(level.var_f1240a9ac4f65616.deadwiretime, 5);
      self.var_521c8f60b6e7acc = gettime() + function_a5b14435e3229bed(deadwiretime);
      params = spawnStruct();
      params.attacker = attacker;
      callback::callback("shocked", params);
      val::set("deadwire_stunned", "ignoreme", 1);
      ent_flag_set("deadwire_stunned");
      stun_ai(1000);
      thread deadwire_timer(death, attacker, mod, sweapon, vpoint, shitloc, modelindex);
    }
  }
}

function function_34506c532bfbda54() {
  if(istrue(level.ammo_mods["deadwire"].immune_result_direct[self.basearchetype])) {
    return false;
  }

  if(isDefined(self.var_b5117f0fdd28774a)) {
    faildeadwire = [[self.var_b5117f0fdd28774a]]();

    if(!istrue(faildeadwire)) {
      return false;
    }
  }

  foreach(result_func in level.var_474baa8191a671a8) {
    if(!istrue([[result_func]]())) {
      return false;
    }
  }

  return true;
}

function function_dc3f0e5b8db53339(damage, attacker, weapon) {
  if(isDefined(self.aicategory) && self.aicategory == "normal" && istrue(ent_flag("deadwire_stunned"))) {
    self.health = int(damage + 1);
    self notify("deadwire_stun_wait");
    thread wait_till_stun_end(attacker, weapon);
  }
}

function wait_till_stun_end(attacker, weapon) {
  self endon("deadwire_stun_wait");
  self endon("death");
  ent_flag_waitopen("deadwire_stunned");

  if(self.aicategory == "normal" && isalive(self)) {
    if(isPlayer(attacker)) {
      scoreeventparams = spawnStruct();
      scoreeventparams.scoreevent = #"deadwire_aoe_kill";
      scoreeventparams.reason = #"kill";
      attacker callback::callback("zombie_score_event", scoreeventparams);
    }

    self kill(self.origin, attacker);
  }
}

function deadwire_timer(death, attacker, mod, sweapon, vpoint, shitloc, modelindex) {
  self endon("death");
  deadwirerange = default_to(level.var_f1240a9ac4f65616.deadwirerange, 128);
  var_9caa2b16b233e48a = getdvarfloat(@ "hash_14168b7136c44e57", 0);
  var_a1ca9749343cd1a2 = default_to(level.var_f1240a9ac4f65616.var_a1ca9749343cd1a2, 0.01);
  var_9d54da6a6ef1372e = default_to(level.var_f1240a9ac4f65616.var_9d54da6a6ef1372e, 0.005);
  var_2862ef8c5aa5adbb = default_to(level.var_f1240a9ac4f65616.var_2862ef8c5aa5adbb, 0.05);
  var_853affe15cd4a849 = default_to(level.var_f1240a9ac4f65616.var_853affe15cd4a849, 0.2);
  var_afc4af44f507da0c = default_to(level.var_f1240a9ac4f65616.var_afc4af44f507da0c, 0.025);

  if(self.aicategory == "normal") {
    val::set("deadwire", "show_healthbar", 0);
    self setperk("specialty_no_target", 1);
    self function_e8971dd45d6d700c(0);

    if(self.health < 1) {
      self.health = 1;
    }
  }

  while(istrue(is_stunned()) && gettime() < self.var_521c8f60b6e7acc) {
    playFXOnTag(getfx("vfx_perk_dw_aoe_exp"), self, "j_spine4");
    closezombies = getaiarrayinradius(self.origin, deadwirerange);

    if(isDefined(self getexecutionpartner()) || self isinexecutionvictim()) {
      ent_flag_set("executed_during_deadwire_stun");
      self.var_5ede61272f442abd = undefined;
      params = spawnStruct();
      params.attacker = attacker;
      callback::callback("shocked_end", params);
      ent_flag_clear("deadwire_stunned");
      val::reset("deadwire_stunned", "ignoreme");
      clear_stun();
      return;
    }

    foreach(zombie in closezombies) {
      if(isalive(zombie) && zombie != self) {
        if(isDefined(zombie.aicategory) && zombie.aicategory == "boss") {
          thedamage = int(zombie.maxhealth * var_9caa2b16b233e48a);
        } else if(isDefined(zombie.aicategory) && zombie.aicategory == "special") {
          thedamage = int(zombie.maxhealth * var_a1ca9749343cd1a2);
        } else if(isDefined(zombie.aicategory) && zombie.aicategory == "elite") {
          thedamage = int(zombie.maxhealth * var_9d54da6a6ef1372e);
        } else if(isDefined(zombie.subclass) && issubstr(zombie.subclass, "warlord")) {
          thedamage = int(zombie.maxhealth * var_9d54da6a6ef1372e);
        } else {
          thedamage = int(zombie.maxhealth * var_2862ef8c5aa5adbb);
        }

        if(zombie.health - thedamage < 1 && zombie != self) {
          if(isPlayer(attacker)) {
            scoreeventparams = spawnStruct();
            scoreeventparams.scoreevent = #"deadwire_aoe_kill";
            attacker callback::callback("zombie_score_event", scoreeventparams);
          }
        }

        zombie val::set("deadwire", "pain", 0);
        zombie dodamage(thedamage, zombie.origin, attacker, attacker, "MOD_ELEMENTAL_ELEC", sweapon, "none", undefined, 65536);
        zombie val::reset("deadwire", "pain");
      }
    }

    if(isalive(self)) {
      if(self.aicategory == "normal") {
        if(self.health < 1) {
          self.health = 1;
        }
      } else if(self.aicategory == "special") {
        thedamage = int(self.maxhealth * var_afc4af44f507da0c);

        if(self.health - thedamage < 0) {
          self.health = 1;
        } else {
          self dodamage(thedamage, self.origin, attacker, attacker, "MOD_ELEMENTAL_ELEC", sweapon, "none", undefined, 65536);
        }
      }
    }

    function_f632348cbb773537(level.deadwire_throttle, self);
    time = gettime();
  }

  params = spawnStruct();
  params.attacker = attacker;
  callback::callback("shocked_end", params);
  ent_flag_clear("deadwire_stunned");
  val::reset("deadwire_stunned", "ignoreme");

  if(isalive(self)) {
    if(self.aicategory == "normal") {
      if(isPlayer(attacker)) {
        scoreeventparams = spawnStruct();
        scoreeventparams.scoreevent = #"deadwire_aoe_kill";
        attacker callback::callback("zombie_score_event", scoreeventparams);
      }

      self kill(self.origin, attacker);
      return;
    }

    clear_stun();
  }
}

function function_9a617a4a862078ca() {
  foreach(player in level.players) {
    currentweapon = player getcurrentweapon();
    player add_ammo_mod_to_weapon(currentweapon, "<dev string:x1c>");
    player iprintlnbold("<dev string:x28>");
  }
}

function function_6c46532ee1ae7b03() {
  function_6e7290c8ee4f558b("<dev string:x42>");
  function_a9a864379a098ad6("<dev string:x53>", "<dev string:x65>", &function_9a617a4a862078ca, 0);
  function_fe953f000498048f();
}

# /