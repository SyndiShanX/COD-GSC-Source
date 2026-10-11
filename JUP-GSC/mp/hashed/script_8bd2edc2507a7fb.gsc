/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_8bd2edc2507a7fb.gsc
************************************************/

#using script_6bffae1b97f70547;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace shatterblast;

function init_shatterblast() {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return;
  }

  level._effect["shatterblast_explosion_effect"] = loadfx("vfx/jup/ob/gameplay/zm_weapons/vfx_perk_shatterblast_lvl0_exp.vfx");
  level endon("game_ended");
  flag_wait("ammo_mods_ready");
  flag_init("shatterblast_ready");
  var_746d800f9d085b2a = default_to(level.var_f1240a9ac4f65616.var_f5387c043922f4f8, 0.3);
  var_ad5528a4132dc97d = default_to(level.var_f1240a9ac4f65616.var_af198a8967836363, 0.1);
  cooldownentity = default_to(level.var_f1240a9ac4f65616.var_b65eda3e32b8f22e, 0);
  cooldownattacker = default_to(level.var_f1240a9ac4f65616.var_f745464cd01e695a, 25);
  cooldownglobal = default_to(level.var_f1240a9ac4f65616.var_1046b942dfff8dd2, 3);
  var_f27a8d5708fd9c4d = default_to(level.var_f1240a9ac4f65616.var_f2b6efc00a3c8036, 1);
  damagefeedbackicon = default_to(level.var_f1240a9ac4f65616.var_d4f5c6e6b4cec483, "");
  damagefeedbacksound = default_to(level.var_f1240a9ac4f65616.var_4cae49a31cc4eca5, "");
  element = default_to(level.var_f1240a9ac4f65616.var_5976d1457ae822c0, "none");
  level.var_1efb9d8964ce6df8 = [];
  level.var_8a2e0c6154011aea = [];
  level.shatterblastthrottle = throttle_initialize("shatterblast_throttle", 1, level.framedurationseconds);
  function_7f759db5de1b44b0("shatterblast", 5, var_746d800f9d085b2a, var_ad5528a4132dc97d, cooldownentity, cooldownattacker, cooldownglobal, var_f27a8d5708fd9c4d, &function_74dd9dad02bab584, damagefeedbackicon, damagefeedbacksound, &function_d68ef8ba212c85a, element, &function_3f5765f3394eadbb);
  flag_set("shatterblast_ready");

  level thread function_d2a179c33526b945();
}

function function_956b04989248cd43(func) {
  level.var_1efb9d8964ce6df8[level.var_1efb9d8964ce6df8.size] = func;
}

function function_52640c8abb792f05(func) {
  level.var_8a2e0c6154011aea[level.var_8a2e0c6154011aea.size] = func;
}

function function_74dd9dad02bab584(death, attacker, mod, sweapon, vpoint, shitloc, modelindex) {
  if(level.var_1efb9d8964ce6df8.size > 0) {
    foreach(result_func in level.var_1efb9d8964ce6df8) {
      [[result_func]](death, attacker, mod, sweapon, vpoint, shitloc, modelindex);
    }

    return;
  }

  if(!isPlayer(attacker)) {
    return;
  }

  if(!function_49feef49bfff113d(attacker)) {
    return;
  }

  function_aecd8c6088cdda0c(death, attacker, mod, sweapon, vpoint, shitloc, modelindex);
}

function function_3f5765f3394eadbb(damage, attacker, sweapon) {
  if(istrue(ent_flag("is_shatterblast_target"))) {
    function_ee31e03f2ae0100(damage, attacker);
  }
}

function function_aecd8c6088cdda0c(death, attacker, mod, sweapon, vpoint, shitloc, modelindex) {
  playFX(getfx("shatterblast_explosion_effect"), vpoint);
  thread function_2ac5028ab35e92e0(death, attacker, mod, sweapon, vpoint, shitloc, modelindex);
}

function function_2ac5028ab35e92e0(death, attacker, mod, sweapon, vpoint, shitloc, modelindex) {
  level endon("game_ended");
  attacker endon("disconnect");
  ent_flag_set("is_shatterblast_target");
  origin = self.origin;
  waitframe();
  var_59d8a38b844d1e11 = getaiarrayinradius(origin, 128);

  foreach(ai in var_59d8a38b844d1e11) {
    if(istrue(level.var_f1240a9ac4f65616.var_d24c25da0a5f1a52)) {
      ai thread function_1646cc331f11526d(death, attacker, mod, sweapon, vpoint, shitloc, modelindex, origin, level.shatterblastthrottle);
      continue;
    }

    ai function_caccc3fb671291a0(death, attacker, mod, sweapon, vpoint, shitloc, modelindex, origin);
  }
}

function function_1646cc331f11526d(death, attacker, mod, sweapon, vpoint, shitloc, modelindex, damageorigin, throttle) {
  ai = self;
  level endon("game_ended");
  attacker endon("disconnect");
  ai endon("death_or_disconnect");
  function_f632348cbb773537(throttle, ai);
  ai function_caccc3fb671291a0(death, attacker, mod, sweapon, vpoint, shitloc, modelindex, damageorigin);
}

function function_caccc3fb671291a0(death, attacker, mod, sweapon, vpoint, shitloc, modelindex, damageorigin) {
  damagepercent = 0;

  if(function_49feef49bfff113d(attacker)) {
    thread function_69f37932abc632da(attacker);

    if(isDefined(self.aicategory)) {
      if(self.aicategory == "normal") {
        killrange = default_to(level.var_f1240a9ac4f65616.var_53039572c4fb54ed, 64);
        killrange *= killrange;

        if(distancesquared(self.origin, damageorigin) <= killrange) {
          damagepercent = 1;
        } else {
          damagepercent = float(default_to(level.var_f1240a9ac4f65616.var_5c9306fb80b47ad9, 0.5));
        }
      } else if(self.aicategory == "special") {
        damagepercent = float(default_to(level.var_f1240a9ac4f65616.var_5ec47ece9ca37503, 0.5));
      } else if(self.aicategory == "elite") {
        damagepercent = float(default_to(level.var_f1240a9ac4f65616.var_fdd6e43418e8b123, 0.5));
      }
    } else if(isDefined(self.unittype) && self.unittype == "soldier") {
      if(isDefined(self.subclass) && issubstr(self.subclass, "warlord")) {
        damagepercent = float(default_to(level.var_f1240a9ac4f65616.var_fdd6e43418e8b123, 0.5));
      } else {
        damagepercent = float(default_to(level.var_f1240a9ac4f65616.var_5c9306fb80b47ad9, 0.5));
      }
    }

    if(damagepercent > 0) {
      damage = self.maxhealth * damagepercent;
      function_ee31e03f2ae0100(damage, attacker);
      self dodamage(damage, self.origin, attacker, attacker, "MOD_EXPLOSIVE", sweapon, shitloc, undefined, 65536);
    }
  }
}

function function_ee31e03f2ae0100(damage, attacker) {
  var_847a9efe63da40a5 = ent_flag("shatterblast_kill_scoreevent_awarded");
  var_e6713b85dde818e2 = self.health - damage < 1;

  if(!var_847a9efe63da40a5 && var_e6713b85dde818e2) {
    ent_flag_set("shatterblast_kill_scoreevent_awarded");

    if(isPlayer(attacker)) {
      scoreeventparams = spawnStruct();
      scoreeventparams.scoreevent = #"hash_555e88a4685955b5";
      scoreeventparams.reason = #"kill";
      attacker callback::callback("zombie_score_event", scoreeventparams);
    }
  }
}

function function_49feef49bfff113d(attacker) {
  if(!isalive(self)) {
    return false;
  }

  if(isDefined(self.team) && self.team == attacker.team) {
    return false;
  }

  return true;
}

function function_d68ef8ba212c85a() {
  if(istrue(level.ammo_mods["shatterblast"].immune_result_direct[self.basearchetype])) {
    return false;
  }

  if(isDefined(self.var_1b74dbfbf5e984dc)) {
    fail = [[self.var_1b74dbfbf5e984dc]]();

    if(!istrue(fail)) {
      return false;
    }
  }

  foreach(result_func in level.var_8a2e0c6154011aea) {
    if(!istrue([[result_func]]())) {
      return false;
    }
  }

  return true;
}

function function_1e0fc29da12fb06d(shitloc, vpoint) {
  if(!isalive(self)) {
    return;
  }

  metabone_name = function_ae12b32b13b42c5e(shitloc);

  if(!isDefined(metabone_name)) {
    metabone_name = function_b8f2b0917b1d3c98(vpoint);
  }

  if(function_adb7b3f940cde3b5(metabone_name)) {
    destroy_metabone(metabone_name);
  }
}

function function_69f37932abc632da(eattacker) {
  self endon("death");

  if(self.unittype == "soldier") {
    return;
  }

  if(!isDefined(self.metabones)) {
    return;
  }

  if(isDefined(self.aicategory) && (self.aicategory == "elite" || self.aicategory == "boss")) {
    return;
  }

  ent_flag_init("shatterblast_damaged_armor");
  ent_flag_set("shatterblast_damaged_armor");

  foreach(var_e7c68f035d44458c, metabone in self.metabones.info) {
    if(!metabone.is_active) {
      continue;
    }

    if(function_cec565632b7fc419(var_e7c68f035d44458c)) {
      continue;
    }

    if(!function_adb7b3f940cde3b5(var_e7c68f035d44458c)) {
      continue;
    }

    destroy_metabone(var_e7c68f035d44458c, eattacker, eattacker);
  }

  waitframe();
  waitframe();
  ent_flag_clear("shatterblast_damaged_armor");
}

function function_3b2ca0163dee88a4() {
  foreach(player in level.players) {
    currentweapon = player getcurrentweapon();
    player add_ammo_mod_to_weapon(currentweapon, "<dev string:x1c>");
    player iprintlnbold("<dev string:x2c>");
  }
}

function function_d2a179c33526b945() {
  function_6e7290c8ee4f558b("<dev string:x4a>");
  function_a9a864379a098ad6("<dev string:x5b>", "<dev string:x71>", &function_3b2ca0163dee88a4, 0);
  function_fe953f000498048f();
}

# /