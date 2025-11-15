/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3373.gsc
************************/

score_multiplier_init(param_00) {
  level.combo_multiplier = 1;
  level.var_66D0 = "cp\zombies\cp_zmb_escape_combos.csv";
  param_00 thread func_11AB4(param_00);
  param_00 thread func_135FF(param_00);
  param_00 thread func_135FC(param_00);
  param_00 thread func_13629(param_00);
}

func_11AB4(param_00) {
  param_00 endon("disconnect");
  setomnvar("zom_escape_combo_multiplier", level.combo_multiplier);
  for(;;) {
    param_00 waittill("adjust_combo_multiplier", var_01, var_02);
    if(!isalive(param_00) || scripts\engine\utility::istrue(param_00.inlaststand)) {
      level.combo_multiplier = 1;
      continue;
    }

    param_00 thread func_1875(param_00, var_01, var_02);
  }
}

func_1875(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("disconnect");
  level.combo_multiplier = level.combo_multiplier + param_01;
  setomnvar("zom_escape_combo_multiplier", level.combo_multiplier);
  wait(param_02);
  level.combo_multiplier = level.combo_multiplier - param_01;
  setomnvar("zom_escape_combo_multiplier", level.combo_multiplier);
}

func_10A31(param_00) {
  var_01 = tablelookup(level.var_66D0, 1, param_00, 0);
  self setclientomnvar("zom_escape_combo_splash", int(var_01));
  thread func_4183();
}

func_4183() {
  wait(2);
  self setclientomnvar("zom_escape_combo_splash", 0);
}

func_135FF(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  var_01 = 0;
  var_02 = 0;
  var_03 = 0.25;
  var_04 = 2;
  var_05 = 2;
  var_06 = "escape_multikill";
  for(;;) {
    param_00 waittill("zombie_killed");
    var_01++;
    var_07 = gettime();
    if(var_07 < var_02) {
      if(var_01 >= var_05) {
        param_00 notify("adjust_combo_multiplier", var_03, var_04);
        param_00 func_10A31(var_06);
      }
    } else if(var_01 > 1) {
      var_01 = 1;
    }

    var_02 = var_07 + 1000;
  }
}

func_135FC(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  var_01 = 0.25;
  var_02 = 2;
  var_03 = "escape_headshot";
  for(;;) {
    param_00 waittill("zombie_killed", var_04, var_05, var_06, var_07, var_08);
    if(scripts\cp\utility::isheadshot(var_06, var_08, var_07, param_00)) {
      param_00 notify("adjust_combo_multiplier", var_01, var_02);
      param_00 func_10A31(var_03);
    }
  }
}

func_13629(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  var_01 = 0.25;
  var_02 = 2;
  var_03 = "escape_sliding";
  for(;;) {
    param_00 waittill("zombie_killed", var_04, var_05, var_06, var_07, var_08);
    if(func_D3B6()) {
      param_00 notify("adjust_combo_multiplier", var_01, var_02);
      param_00 func_10A31(var_03);
    }
  }
}

func_D3B6() {
  return isDefined(self.var_9F59) || isDefined(self.var_9F5A) && gettime() <= self.var_9F5A;
}