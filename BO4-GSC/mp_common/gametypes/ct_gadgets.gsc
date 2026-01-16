/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ct_gadgets.gsc
***********************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\mp_common\gametypes\ct_bots;
#include scripts\mp_common\gametypes\ct_utils;

#namespace ct_gadgets;

function_f2f3407(gadget_name) {
  if(isDefined(level.var_43ac3b33) && level.var_43ac3b33) {
    return false;
  }

  if(!isDefined(gadget_name)) {
    return false;
  }

  if(isDefined(level.var_e72728b8)) {
    if(isinarray(level.var_e72728b8, gadget_name)) {
      return false;
    }
  }

  return true;
}

function_761e1977() {
  if(isDefined(self._gadgets_player)) {
    for(i = 0; i < 3; i++) {
      gadget = self._gadgets_player[i];

      if(isDefined(gadget)) {
        var_bf05e9db = 1;

        if(isDefined(var_bf05e9db) && var_bf05e9db) {
          if(!self util::gadget_is_in_use(i) && self gadgetcharging(i)) {
            self thread function_be6376db(i);
          }
        }
      }
    }
  }
}

function_be6376db(n_slot) {
  self.var_bb7ec6ae[n_slot] = 1;
  gadget = self._gadgets_player[n_slot];
  self gadgetpowerset(n_slot, gadget.gadget_powermax);
  waitframe(1);
  self.var_bb7ec6ae[n_slot] = 0;
}

function_c33e69b9() {
  player = self;

  if(!isDefined(player.var_bb7ec6ae)) {
    player.var_bb7ec6ae = [];
  }

  for(i = 0; i < 3; i++) {
    player.var_bb7ec6ae[i] = 1;
  }
}

function_b81240c1() {
  player = self;

  if(!isDefined(player.var_bb7ec6ae)) {
    player.var_bb7ec6ae = [];
  }

  for(i = 0; i < 3; i++) {
    player.var_bb7ec6ae[i] = 0;
  }
}

function_ac7d2bdd(n_time = 0.5) {
  level endon(#"hash_699329b4df616aed");

  for(i = 0; i < 3; i++) {
    if(isDefined(self._gadgets_player[i])) {
      self thread function_4d6c7d92(i, n_time);
    }
  }

  wait n_time;
}

function_4d6c7d92(var_e8ee1cd1, n_time = 0) {
  level endon(#"combattraining_logic_finished");
  self endoncallback(&function_649b67d, #"death");

  if(!isDefined(self.var_5c519f98)) {
    self.var_5c519f98 = [];
  }

  gadget = self._gadgets_player[var_e8ee1cd1];

  if(isDefined(gadget) && !function_f2f3407(gadget.name)) {
    self gadgetpowerset(var_e8ee1cd1, 0);
    return;
  }

  if(!(isDefined(self.var_5c519f98[var_e8ee1cd1]) && self.var_5c519f98[var_e8ee1cd1])) {
    self.var_5c519f98[var_e8ee1cd1] = 1;
    var_d5b8c6cf = self._gadgets_player[var_e8ee1cd1].gadget_powermax;
    n_steps = 10;
    var_128b4383 = 0.1;
    var_589ea782 = n_time ? var_d5b8c6cf * var_128b4383 / n_time : var_d5b8c6cf;
    n_power = 0;

    while(n_power < var_d5b8c6cf && function_f2f3407(gadget.name)) {
      n_power = self gadgetpowerget(var_e8ee1cd1) + var_589ea782;

      if(!isDefined(self.var_bb7ec6ae) || !(isDefined(self.var_bb7ec6ae[var_e8ee1cd1]) && self.var_bb7ec6ae[var_e8ee1cd1])) {
        self gadgetpowerset(var_e8ee1cd1, n_power);
      }

      wait var_128b4383;
    }

    self.var_5c519f98[var_e8ee1cd1] = 0;

    if(!function_f2f3407(gadget.name)) {
      self gadgetpowerset(var_e8ee1cd1, 0);
    }
  }
}

function_649b67d(_hash) {
  e_player = ct_utils::get_player();

  if(isDefined(e_player.var_5c519f98)) {
    for(i = 0; i < e_player.var_5c519f98.size; i++) {
      e_player.var_5c519f98[i] = 0;
    }
  }
}

function_d77271ae() {
  level endon(#"hash_699329b4df616aed");

  for(i = 0; i < 3; i++) {
    if(isDefined(self._gadgets_player[i])) {
      self gadgetpowerset(i, 0);
    }
  }
}

function_b0762fa0(n_slot) {
  var_b4079089 = "gadget_autofill_power_think_end_" + n_slot;
  level endon(#"combattraining_logic_finished", var_b4079089);

  if(!isDefined(self.var_bb7ec6ae)) {
    self.var_bb7ec6ae = [];
  }

  while(true) {
    if(isDefined(self._gadgets_player)) {
      gadget = self._gadgets_player[n_slot];

      if(isDefined(gadget)) {
        var_bf05e9db = 1;
        n_power = self gadgetpowerget(n_slot);

        if(isDefined(self.var_bb7ec6ae[n_slot]) && self.var_bb7ec6ae[n_slot] || n_power >= gadget.gadget_powermax) {
          var_bf05e9db = 0;
        }

        if(!function_f2f3407(gadget.name)) {
          var_bf05e9db = 0;
        }

        if(isDefined(var_bf05e9db) && var_bf05e9db) {
          var_90a2bef0 = self util::gadget_is_in_use(n_slot);

          if(isDefined(level.var_d4668c34) && level.var_d4668c34) {
            var_d1fbed1e = 1;

            if(isDefined(self.var_bb7ec6ae[n_slot]) && self.var_bb7ec6ae[n_slot]) {
              var_d1fbed1e = 0;
            } else if(isDefined(level.var_fa24d775)) {
              foreach(test_gadget in level.var_fa24d775) {
                if(test_gadget == gadget.name) {
                  var_d1fbed1e = 0;
                  break;
                }
              }
            }

            if(isDefined(var_d1fbed1e) && var_d1fbed1e) {
              self gadgetpowerset(n_slot, 100);
            }
          } else if(!var_90a2bef0) {
            filltime = isDefined(self.var_f3d589a1[n_slot]) ? self.var_f3d589a1[n_slot] : level.var_c8f47cbe;
            self function_4d6c7d92(n_slot, filltime);
          }
        } else if(isDefined(level.var_e72728b8) && isinarray(level.var_e72728b8, gadget.name)) {
          self gadgetpowerset(n_slot, 0);
        }
      }
    }

    waitframe(1);
  }
}

function_19181566() {
  level endon(#"hash_699329b4df616aed");
  level flag::wait_till("desc_fillup_gadgets");
  self thread ct_utils::function_d836c124();

  if(!isDefined(self.var_f3d589a1)) {
    self.var_f3d589a1 = [];
  }

  self thread function_b0762fa0(0);
  self thread function_b0762fa0(1);
  self thread function_b0762fa0(2);
}

function_4db6654a(n_slot, var_56cf67a9) {
  level endon(#"hash_699329b4df616aed");
  self endon(#"death");

  while(true) {
    if(isDefined(self._gadgets_player)) {
      gadget = self._gadgets_player[n_slot];

      if(isDefined(gadget) && function_f2f3407(gadget.name)) {
        var_9877bd4c = self gadgetpowerget(n_slot);

        if(var_9877bd4c < var_56cf67a9) {
          self gadgetpowerset(n_slot, var_56cf67a9);
        }
      }
    }

    waitframe(1);
  }
}

function_144e61da(n_slot, str_endon) {
  level endon(str_endon);

  while(true) {
    e_player = getplayers()[0];
    gadget = e_player._gadgets_player[n_slot];

    if(isalive(e_player) && isDefined(gadget) && function_f2f3407(gadget.name)) {
      e_player gadgetpowerset(n_slot, 100);
    }

    wait 1;
  }
}

function_c3e3d15() {
  level endon(#"combattraining_logic_finished");

  while(true) {
    waitresult = level waittill(#"hero_gadget_activated");
    waitresult.player.var_657a47ca = waitresult.weapon.name;
  }
}

function_aedf2680() {
  e_player = getplayers()[0];
  e_player endon(#"death");
  e_player waittill(#"gadget_forced_off");
  e_player.var_c70a4cbc = 1;
}

function_9dc27b4f(str_weapon, var_11665320, var_c8518532) {
  self endon(#"death");
  level.var_e72728b8 = var_11665320;
  function_952b1db2();
  waitframe(1);
  level.var_e72728b8 = var_c8518532;
  self switchtoweapon(getweapon(str_weapon), 1);
}

function_952b1db2() {
  self endon(#"death");
  waitframe(1);
  self ct_bots::function_26d45f32(1);
}

function_1be7e4f(str_weapon) {
  self endon(#"death", #"hash_46d18c1394319d75");
  weapon = getweapon(str_weapon);
  var_333fa936 = self getweaponammoclipsize(weapon);

  while(true) {
    wpn_current = self getcurrentweapon();

    if(wpn_current == weapon) {
      n_ammo = self getweaponammoclip(wpn_current);

      if(n_ammo < var_333fa936) {
        self setweaponammoclip(wpn_current, var_333fa936);
      }
    }

    waitframe(1);
  }
}

function_350dd8ec(str_weapon) {
  level endon(#"combattraining_logic_finished");

  while(true) {
    e_player = getplayers()[0];

    if(isalive(e_player)) {
      wpn = e_player getcurrentweapon();

      if(wpn.name == str_weapon) {
        break;
      }
    }

    waitframe(1);
  }
}

get_slot(str_weapon_name) {
  if(isDefined(self._gadgets_player)) {
    for(i = 0; i < 3; i++) {
      gadget = self._gadgets_player[i];

      if(isDefined(gadget) && gadget.name == str_weapon_name) {
        return i;
      }
    }
  }

  return 0;
}

function_fb68ca34(n_delay) {
  e_player = getplayers()[0];
  wait n_delay;
  e_player val::reset(#"spawn_player", "disablegadgets");
}