/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_wave_manipulation.gsc
***********************************************************/

func_00F9() {
  level.var_294B = "wave_mod_normal";
}

func_8606() {
  if(level.var_294B != "wave_mod_maxed") {
    level.var_294B = "wave_mod_maxed";
  } else {
    return;
  }

  lib_056D::func_8A6E(0);
  level thread func_3DF2("cancel_max_zombie_count");
}

func_8607() {
  if(level.var_294B != "wave_mod_normal") {
    level.var_294B = "wave_mod_normal";
  } else {
    return;
  }

  level notify("cancel_max_zombie_count");
  lib_056D::func_8A6E(0);
}

func_8608() {
  if(level.var_294B != "wave_mod_paused") {
    level.var_294B = "wave_mod_paused";
  } else {
    return;
  }

  level notify("cancel_max_zombie_count");
  lib_056D::func_8A6E(1);
}

func_3DF2(param_00) {
  level endon(param_00);
  if(!isDefined(level.means_of_skipping_rounds_func)) {
    level thread func_8C8E(param_00);
  } else {
    level thread[[level.means_of_skipping_rounds_func]](param_00);
  }

  for(;;) {
    var_01 = lib_0547::func_408F();
    foreach(var_03 in var_01) {
      var_03.var_6816 = 1;
      if(common_scripts\utility::func_562E(level.maxed_zombies_sprint) && lib_0547::func_5565(var_03.var_0A4B, "zombie_generic")) {
        var_03.var_6941 = 1;
      }
    }

    wait(0.5);
  }
}

is_zombie_wave_maxed() {
  return lib_0547::func_5565(level.var_294B, "wave_mod_maxed");
}

func_8C8E(param_00) {
  self endon(param_00);
  level notify("zombies_skip_round_intermission");
  for(;;) {
    level waittill("round complete");
    wait 0.05;
    level notify("zombies_skip_round_intermission");
  }
}

skiproundwait2(param_00) {
  self endon(param_00);
  level notify("zombies_skip_round_intermission");
  level childthread disable_round_intermission();
}

disable_round_intermission() {
  for(;;) {
    wait 0.05;
    level notify("zombies_skip_round_intermission");
  }
}

enforce_zombie_limit(param_00, param_01) {
  self endon(param_00);
  wait 0.05;
  for(;;) {
    var_02 = lib_0547::func_408F();
    if(var_02.size >= self.zombie_count) {
      func_8608();
    } else {
      func_8606();
    }

    if(isDefined(param_01)) {
      if(self.zombie_count > param_01) {
        foreach(var_04 in var_02) {
          var_04.var_6941 = 1;
        }
      }
    }

    wait 0.05;
  }
}

restore_normal_rounds(param_00) {
  self waittill(param_00);
  func_8607();
}

func_4DA1(param_00) {
  if(level.var_258F) {
    self.var_35D5.var_009B = 1;
  } else {
    self.var_35D5.var_009B = 0.08;
  }

  self.var_35D5.var_01D3 = 0;
  self.var_35D5.var_01D7 = -40;
  self.var_35D5.var_0010 = "left";
  self.var_35D5.var_0011 = "bottom";
  self.var_35D5.var_00C6 = "left";
  self.var_35D5.var_01CA = "middle";
  self.var_35D5.var_0184 = 1;
  self.var_35D5.var_0018 = 0.8;
  if(!isDefined(self.var_1739)) {
    return;
  }

  self.var_1739.var_01D3 = 0;
  self.var_1739.var_01D7 = -40;
  self.var_1739.var_0010 = "center";
  self.var_1739.var_0011 = "middle";
  self.var_1739.var_00C6 = "center";
  self.var_1739.var_01CA = "middle";
  self.var_1739.var_0184 = -1;
  if(level.var_258F) {
    self.var_1739 setshader("popmenu_bg", 650, 52);
  } else {
    self.var_1739 setshader("popmenu_bg", 650, 42);
  }

  if(!isDefined(param_00)) {
    param_00 = 0.5;
  }

  self.var_1739.var_0018 = param_00;
}