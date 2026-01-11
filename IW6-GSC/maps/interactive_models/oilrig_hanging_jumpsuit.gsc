/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\oilrig_hanging_jumpsuit.gsc
***************************************************************/

#using_animtree("animated_props");

main() {
  var_0 = spawnStruct();
  var_0.targetname = "interactive_oilrig_jumpsuit";
  var_0.name = "oilrig_jumpsuit";
  var_0.animtree = #animtree;

  if(common_scripts\utility::issp()) {
    var_0.anims["idle1"] = % oilrig_jumpsuit_idle1;
    var_0.anims["idle2"] = % oilrig_jumpsuit_idle2;
    var_0.anims["move_b_large"] = % oilrig_jumpsuit_move_b_large;
    var_0.anims["move_b_small"] = % oilrig_jumpsuit_move_b_small;
    var_0.anims["move_bl_large"] = % oilrig_jumpsuit_move_bl_large;
    var_0.anims["move_bl_small"] = % oilrig_jumpsuit_move_bl_small;
    var_0.anims["move_br_large"] = % oilrig_jumpsuit_move_br_large;
    var_0.anims["move_br_small"] = % oilrig_jumpsuit_move_br_small;
    var_0.anims["move_f_large"] = % oilrig_jumpsuit_move_f_large;
    var_0.anims["move_f_small"] = % oilrig_jumpsuit_move_f_small;
    var_0.anims["move_fl_large"] = % oilrig_jumpsuit_move_fl_large;
    var_0.anims["move_fl_small"] = % oilrig_jumpsuit_move_fl_small;
    var_0.anims["move_fr_large"] = % oilrig_jumpsuit_move_fr_large;
    var_0.anims["move_fr_small"] = % oilrig_jumpsuit_move_fr_small;
  } else {
    var_0.anims["idle1"] = "oilrig_jumpsuit_idle1";
    var_0.anims["idle2"] = "oilrig_jumpsuit_idle2";
    var_0.anims["move_b_large"] = "oilrig_jumpsuit_move_b_large";
    var_0.anims["move_b_small"] = "oilrig_jumpsuit_move_b_small";
    var_0.anims["move_bl_large"] = "oilrig_jumpsuit_move_bl_large";
    var_0.anims["move_bl_small"] = "oilrig_jumpsuit_move_bl_small";
    var_0.anims["move_br_large"] = "oilrig_jumpsuit_move_br_large";
    var_0.anims["move_br_small"] = "oilrig_jumpsuit_move_br_small";
    var_0.anims["move_f_large"] = "oilrig_jumpsuit_move_f_large";
    var_0.anims["move_f_small"] = "oilrig_jumpsuit_move_f_small";
    var_0.anims["move_fl_large"] = "oilrig_jumpsuit_move_fl_large";
    var_0.anims["move_fl_small"] = "oilrig_jumpsuit_move_fl_small";
    var_0.anims["move_fr_large"] = "oilrig_jumpsuit_move_fr_large";
    var_0.anims["move_fr_small"] = "oilrig_jumpsuit_move_fr_small";
  }

  var_1 = getarraykeys(var_0.anims);

  foreach(var_3 in var_1) {
  var_0.animlengths[var_3] = getanimlength(var_0.anims[var_3]);
  }

  if(!isDefined(level._interactive)) {
    level._interactive = [];
  }

  level._interactive[var_0.name] = var_0;
  thread oilrig_jumpsuits(var_0);
}

oilrig_jumpsuits(var_0) {
  level waittill("load_finished");

  if(!isDefined(level._interactive[var_0.name + "_setup"])) {
    level._interactive[var_0.name + "_setup"] = 1;
    var_1 = getEntArray(var_0.targetname, "targetname");

    foreach(var_3 in var_1) {
    var_3 thread oilrig_jumpsuit(var_0);
    }
  }
}

oilrig_jumpsuit(var_0) {
  level endon("game_ended");
  oilrig_jumpsuit_precache();

  if(isDefined(self.target)) {
    var_1 = getEntArray(self.target, "targetname");
    var_2 = common_scripts\utility::getclosest(self.origin, var_1);
    var_2 hide();
    var_2 thread oilrig_jumpsuit_hitbox_ondamage(self);
  }

  thread oilrig_jumpsuit_ondamage(var_0.anims, var_0.animlengths);
}

oilrig_jumpsuit_precache(var_0) {
  if(!common_scripts\utility::issp()) {
    foreach(var_2 in var_0) {
    call[[level.func["precacheMpAnim"]]](var_2);
    }
  }
}

oilrig_jumpsuit_ondamage(var_0, var_1) {
  level endon("game_ended");
  self endon("stop_scripts");

  if(isDefined(level.func["useanimtree"])) {
    self call[[level.func["useanimtree"]]](#animtree);
  }

  var_2 = common_scripts\utility::ter_op(common_scripts\utility::issp(), level.func["clearanim"], level.func["scriptModelClearAnim"]);
  var_3 = common_scripts\utility::ter_op(common_scripts\utility::issp(), level.func["setanim"], level.func["scriptModelPlayAnim"]);

  for(;;) {
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
    self waittill("damage", var_8, var_9, var_10, var_11, var_12);
    var_5 = "move_";
    var_13 = self.angles[1];
    var_14 = angleclamp(vectortoyaw(var_10));
    var_15 = 15;
    var_16 = common_scripts\utility::ter_op(var_14 - var_13 > 0, 1, -1);
    var_17 = var_14 - var_13;
    var_17 = common_scripts\utility::ter_op(abs(var_17) > 180, -1 * var_16 * (360 - abs(var_17)), var_16 * abs(var_17));

    if(abs(var_17) > 90) {
      if(var_17 > 0 && 180 - abs(var_17) > var_15) {
        var_5 = var_5 + "br";
      }
      else if(var_17 < 0 && 180 - abs(var_17) > var_15) {
        var_5 = var_5 + "bl";
      }
      else {
        var_5 = var_5 + "b";
      }
    } else if(abs(var_17) < 90) {
      if(var_17 < 0 && abs(var_17) > var_15) {
        var_5 = var_5 + "fl";
      }
      else if(var_17 > 0 && abs(var_17) > var_15) {
        var_5 = var_5 + "fr";
      }
      else {
        var_5 = var_5 + "f";
      }
    }

    var_4 = "small";
    var_6 = 0;

    if(isDefined(var_12)) {
      switch (var_12) {
        case "MOD_EXPLOSIVE_SPLASH":
        case "MOD_GRENADE_SPLASH":
        case "MOD_GRENADE":
        case "MOD_EXPLOSIVE":
          var_7 = length(var_10 - (0, 0, 100));
          var_6 = (var_7 - 50) / 400;
          var_6 = max(var_6, 0);

          if(var_6 > 1) {
            var_6 = 0;
          }

          if(var_8 > 85) {
            var_4 = "large";
          }

          break;
      }
    }

    var_5 = var_5 + ("_" + var_4);

    if(isDefined(self.script_parameters)) {
      if(isDefined(var_0[var_5 + "_" + self.script_parameters])) {
        var_5 = var_5 + ("_" + self.script_parameters);
      }
    }

    wait(var_6);

    if(common_scripts\utility::issp()) {
      self call[[var_2]](var_0["idle1"], 0);
      self call[[var_2]](var_0["idle2"], 0);
    } else
      self call[[var_2]]();

    if(common_scripts\utility::issp()) {
      self call[[var_3]](var_0[var_5], 1, 0, 1);
    }
    else {
      self call[[var_3]](var_0[var_5]);
    }

    var_13 = undefined;
    var_14 = undefined;
    var_15 = undefined;
    var_16 = undefined;
    var_17 = undefined;
    var_8 = undefined;
    var_9 = undefined;
    var_10 = undefined;
    var_11 = undefined;
    var_12 = undefined;
    wait(var_1[var_5]);

    if(common_scripts\utility::issp()) {
      self call[[var_2]](var_0[var_5], 0);
    }
    else {
      self call[[var_2]]();
    }

    thread oilrig_jumpsuit_playidleanim(var_0, var_1);
  }
}

oilrig_jumpsuit_playidleanim(var_0, var_1) {
  level endon("game_ended");
  self endon("damage");
  self endon("stop_scripts");
  var_2 = common_scripts\utility::ter_op(common_scripts\utility::issp(), level.func["clearanim"], level.func["scriptModelClearAnim"]);
  var_3 = common_scripts\utility::ter_op(common_scripts\utility::issp(), level.func["setanim"], level.func["scriptModelPlayAnim"]);
  var_4 = randomintrange(1, 3);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    if(common_scripts\utility::issp()) {
      self call[[var_3]](var_0["idle1"], 1, 0, 1);
    }
    else {
      self call[[var_3]](var_0["idle1"]);
    }

    wait(var_1["idle1"]);

    if(common_scripts\utility::issp()) {
      self call[[var_2]](var_0["idle1"], 0);
      continue;
    }

    self call[[var_2]]();
  }

  if(common_scripts\utility::issp()) {
    self call[[var_3]](var_0["idle2"], 1, 0, 1);
  }
  else {
    self call[[var_3]](var_0["idle2"]);
  }

  wait(var_1["idle2"]);
  wait(randomfloat(3));

  if(common_scripts\utility::issp()) {
    self call[[var_2]](var_0["idle2"], 0);
  }
  else {
    self call[[var_2]]();
  }
}

oilrig_jumpsuit_hitbox_ondamage(var_0) {
  level endon("game_ended");
  self endon("stop_scripts");
  self setCanDamage(1);

  for(;;) {
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);
    var_0 notify("damage", var_1, var_2, var_3, var_4, var_5);
  }
}