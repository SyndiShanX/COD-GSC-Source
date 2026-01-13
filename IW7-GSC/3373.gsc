/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3373.gsc
*********************************************/

score_multiplier_init(var_0) {
  level.combo_multiplier = 1;
  level.var_66D0 = "cp\zombies\cp_zmb_escape_combos.csv";
  var_0 thread func_11AB4(var_0);
  var_0 thread func_135FF(var_0);
  var_0 thread func_135FC(var_0);
  var_0 thread func_13629(var_0);
}

func_11AB4(var_0) {
  var_0 endon("disconnect");
  setomnvar("zom_escape_combo_multiplier", level.combo_multiplier);
  for(;;) {
    var_0 waittill("adjust_combo_multiplier", var_1, var_2);
    if(!isalive(var_0) || scripts\engine\utility::istrue(var_0.inlaststand)) {
      level.combo_multiplier = 1;
      continue;
    }

    var_0 thread func_1875(var_0, var_1, var_2);
  }
}

func_1875(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("disconnect");
  level.combo_multiplier = level.combo_multiplier + var_1;
  setomnvar("zom_escape_combo_multiplier", level.combo_multiplier);
  wait(var_2);
  level.combo_multiplier = level.combo_multiplier - var_1;
  setomnvar("zom_escape_combo_multiplier", level.combo_multiplier);
}

func_10A31(var_0) {
  var_1 = tablelookup(level.var_66D0, 1, var_0, 0);
  self setclientomnvar("zom_escape_combo_splash", int(var_1));
  thread func_4183();
}

func_4183() {
  wait(2);
  self setclientomnvar("zom_escape_combo_splash", 0);
}

func_135FF(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = 0;
  var_2 = 0;
  var_3 = 0.25;
  var_4 = 2;
  var_5 = 2;
  var_6 = "escape_multikill";
  for(;;) {
    var_0 waittill("zombie_killed");
    var_1++;
    var_7 = gettime();
    if(var_7 < var_2) {
      if(var_1 >= var_5) {
        var_0 notify("adjust_combo_multiplier", var_3, var_4);
        var_0 func_10A31(var_6);
      }
    } else if(var_1 > 1) {
      var_1 = 1;
    }

    var_2 = var_7 + 1000;
  }
}

func_135FC(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = 0.25;
  var_2 = 2;
  var_3 = "escape_headshot";
  for(;;) {
    var_0 waittill("zombie_killed", var_4, var_5, var_6, var_7, var_8);
    if(scripts\cp\utility::isheadshot(var_6, var_8, var_7, var_0)) {
      var_0 notify("adjust_combo_multiplier", var_1, var_2);
      var_0 func_10A31(var_3);
    }
  }
}

func_13629(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = 0.25;
  var_2 = 2;
  var_3 = "escape_sliding";
  for(;;) {
    var_0 waittill("zombie_killed", var_4, var_5, var_6, var_7, var_8);
    if(func_D3B6()) {
      var_0 notify("adjust_combo_multiplier", var_1, var_2);
      var_0 func_10A31(var_3);
    }
  }
}

func_D3B6() {
  return isDefined(self.var_9F59) || isDefined(self.var_9F5A) && gettime() <= self.var_9F5A;
}