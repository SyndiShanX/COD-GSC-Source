/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_64f7df26b62826a1.gsc
*************************************************/

#using script_6bffae1b97f70547;
#using script_73926eaf280b0b75;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace napalmburst;

function init_napalmburst() {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return;
  }

  level endon("game_ended");
  flag_wait("ammo_mods_ready");
  flag_init("napalmburst_ready");
  var_746d800f9d085b2a = default_to(level.var_f1240a9ac4f65616.var_4fb51392aae1ecd2, 0.2);
  var_ad5528a4132dc97d = default_to(level.var_f1240a9ac4f65616.var_4bf233f673b39379, 0.05);
  cooldownentity = default_to(level.var_f1240a9ac4f65616.var_55707674312df73c, 0);
  var_bcbfc6de4213b6af = default_to(level.var_f1240a9ac4f65616.var_24269ee9413f1198, 3);
  cooldownglobal = default_to(level.var_f1240a9ac4f65616.var_13e6d0008e908b78, 3);
  var_f27a8d5708fd9c4d = default_to(level.var_f1240a9ac4f65616.var_c36a27ee3aa677b0, 1);
  damagefeedbackicon = default_to(level.var_f1240a9ac4f65616.var_d3b2954397f84855, "");
  damagefeedbacksound = default_to(level.var_f1240a9ac4f65616.var_bd6ba7b9f57a662b, "");
  element = default_to(level.var_f1240a9ac4f65616.var_667e3a3f69aae5ba, "fire");
  level.var_f6b318184143b63e = [];
  level.var_c5af74f2886aa77c = [];
  function_7f759db5de1b44b0("napalmburst", 4, var_746d800f9d085b2a, var_ad5528a4132dc97d, cooldownentity, var_bcbfc6de4213b6af, cooldownglobal, var_f27a8d5708fd9c4d, &function_a428cc7d938fa416, damagefeedbackicon, damagefeedbacksound, &function_af75491a8a4c3790, element);
  flag_set("napalmburst_ready");

  level thread function_439421327ad70eb();
}

function function_8d25decb6d23f001(func) {
  level.var_f6b318184143b63e[level.var_f6b318184143b63e.size] = func;
}

function function_7d46ac68b0d2524f(func) {
  level.var_c5af74f2886aa77c[level.var_c5af74f2886aa77c.size] = func;
}

function function_a428cc7d938fa416(death, attacker, mod, sweapon, vpoint, shitloc, modelindex) {
  if(level.var_f6b318184143b63e.size > 0) {
    foreach(result_func in level.var_f6b318184143b63e) {
      [[result_func]](death, attacker, mod, sweapon, vpoint, shitloc, modelindex);
    }

    return;
  }

  thread function_9f7e53b0c8a95ee(death, attacker, mod, sweapon, vpoint, shitloc, modelindex);
}

function function_9f7e53b0c8a95ee(death, attacker, mod, sweapon, vpoint, shitloc, modelindex) {
  level endon("game_ended");
  self endon("death");
  waitframe();

  if(!isalive(self)) {
    return;
  }

  if(isDefined(self.aicategory) && (self.aicategory == "normal" || self.aicategory == "special")) {
    var_ec7b6ae5eb2558c3 = default_to(level.var_f1240a9ac4f65616.var_ec7b6ae5eb2558c3, 10);

    if(self.aicategory == "special") {
      var_fc4c702fcaf972e4 = default_to(level.var_f1240a9ac4f65616.var_8cb2c6bb805dfe97, 0.025);
    } else {
      var_fc4c702fcaf972e4 = default_to(level.var_f1240a9ac4f65616.var_fc4c702fcaf972e4, 0.1);
    }

    success = burn(var_ec7b6ae5eb2558c3, var_fc4c702fcaf972e4, 1, attacker, "napalmburst", "napalmburst_kill");
  }
}

function function_af75491a8a4c3790() {
  if(istrue(level.ammo_mods["napalmburst"].immune_result_direct[self.basearchetype])) {
    return false;
  }

  if(isDefined(self.var_69fad82b1297b14)) {
    var_9c4fca37dfaf816a = [[self.var_69fad82b1297b14]]();

    if(!istrue(var_9c4fca37dfaf816a)) {
      return false;
    }
  }

  foreach(result_func in level.var_c5af74f2886aa77c) {
    if(!istrue([[result_func]]())) {
      return false;
    }
  }

  return true;
}

function function_746dda921942d946() {
  foreach(player in level.players) {
    currentweapon = player getcurrentweapon();
    player function_6c40f58b29a952a9(currentweapon, "<dev string:x1c>");
    player iprintlnbold("<dev string:x2b>");
  }
}

function function_439421327ad70eb() {
  function_6e7290c8ee4f558b("<dev string:x48>");
  function_a9a864379a098ad6("<dev string:x59>", "<dev string:x6e>", &function_746dda921942d946, 0);
  function_fe953f000498048f();
}

# /