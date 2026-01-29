/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_interactive.gsc
*******************************************/

init() {
  common_scripts\utility::array_thread(getEntArray("industrial_curtain", "targetname"), ::industrial_curtain);
}

industrial_curtain() {
  level endon("game_ended");
  industrial_curtain_precache();
  industrial_curtain_setupanimarray();
  var_0 = getent(self.target, "targetname");
  var_0 hide();
  var_0 thread industrial_curtain_hitbox_ondamage(self);
  thread industrial_curtain_ondamage();
}

industrial_curtain_precache() {
  if(!common_scripts\utility::issp()) {
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_idle1");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_idle2");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_b_large");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_b_large_lim18");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_b_large_rail");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_b_small");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_bl_large");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_bl_large_lim18");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_bl_large_rail");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_bl_small");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_br_large");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_br_large_lim18");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_br_large_rail");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_br_small");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_f_large");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_f_large_rail");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_f_small");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_fl_large");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_fl_large_rail");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_fl_small");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_fr_large");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_fr_large_rail");
    call[[level.func["precacheMpAnim"]]]("curtain_industrial_rubber_144x18_move_fr_small");
  }

  precachemodel("curtain_industrial_rubber_144x18");
}

#using_animtree("animated_props");

industrial_curtain_setupanimarray() {
  if(common_scripts\utility::issp()) {
    level._interactive_anims["curtain_industrial"]["idle1"] = % curtain_industrial_rubber_144x18_idle1;
    level._interactive_anims["curtain_industrial"]["idle2"] = % curtain_industrial_rubber_144x18_idle2;
    level._interactive_anims["curtain_industrial"]["move_b_large"] = % curtain_industrial_rubber_144x18_move_b_large;
    level._interactive_anims["curtain_industrial"]["move_b_large_lim18"] = % curtain_industrial_rubber_144x18_move_b_large_lim18;
    level._interactive_anims["curtain_industrial"]["move_b_large_rail"] = % curtain_industrial_rubber_144x18_move_b_large_rail;
    level._interactive_anims["curtain_industrial"]["move_b_small"] = % curtain_industrial_rubber_144x18_move_b_small;
    level._interactive_anims["curtain_industrial"]["move_bl_large"] = % curtain_industrial_rubber_144x18_move_bl_large;
    level._interactive_anims["curtain_industrial"]["move_bl_large_lim18"] = % curtain_industrial_rubber_144x18_move_bl_large_lim18;
    level._interactive_anims["curtain_industrial"]["move_bl_large_rail"] = % curtain_industrial_rubber_144x18_move_bl_large_rail;
    level._interactive_anims["curtain_industrial"]["move_bl_small"] = % curtain_industrial_rubber_144x18_move_bl_small;
    level._interactive_anims["curtain_industrial"]["move_br_large"] = % curtain_industrial_rubber_144x18_move_br_large;
    level._interactive_anims["curtain_industrial"]["move_br_large_lim18"] = % curtain_industrial_rubber_144x18_move_br_large_lim18;
    level._interactive_anims["curtain_industrial"]["move_br_large_rail"] = % curtain_industrial_rubber_144x18_move_br_large_rail;
    level._interactive_anims["curtain_industrial"]["move_br_small"] = % curtain_industrial_rubber_144x18_move_br_small;
    level._interactive_anims["curtain_industrial"]["move_f_large"] = % curtain_industrial_rubber_144x18_move_f_large;
    level._interactive_anims["curtain_industrial"]["move_f_large_rail"] = % curtain_industrial_rubber_144x18_move_f_large_rail;
    level._interactive_anims["curtain_industrial"]["move_f_small"] = % curtain_industrial_rubber_144x18_move_f_small;
    level._interactive_anims["curtain_industrial"]["move_fl_large"] = % curtain_industrial_rubber_144x18_move_fl_large;
    level._interactive_anims["curtain_industrial"]["move_fl_large_rail"] = % curtain_industrial_rubber_144x18_move_fl_large_rail;
    level._interactive_anims["curtain_industrial"]["move_fl_small"] = % curtain_industrial_rubber_144x18_move_fl_small;
    level._interactive_anims["curtain_industrial"]["move_fr_large"] = % curtain_industrial_rubber_144x18_move_fr_large;
    level._interactive_anims["curtain_industrial"]["move_fr_large_rail"] = % curtain_industrial_rubber_144x18_move_fr_large_rail;
    level._interactive_anims["curtain_industrial"]["move_fr_small"] = % curtain_industrial_rubber_144x18_move_fr_small;
  } else {
    level._interactive_anims["curtain_industrial"]["idle1"] = "curtain_industrial_rubber_144x18_idle1";
    level._interactive_anims["curtain_industrial"]["idle2"] = "curtain_industrial_rubber_144x18_idle2";
    level._interactive_anims["curtain_industrial"]["move_b_large"] = "curtain_industrial_rubber_144x18_move_b_large";
    level._interactive_anims["curtain_industrial"]["move_b_large_lim18"] = "curtain_industrial_rubber_144x18_move_b_large_lim18";
    level._interactive_anims["curtain_industrial"]["move_b_large_rail"] = "curtain_industrial_rubber_144x18_move_b_large_rail";
    level._interactive_anims["curtain_industrial"]["move_b_small"] = "curtain_industrial_rubber_144x18_move_b_small";
    level._interactive_anims["curtain_industrial"]["move_bl_large"] = "curtain_industrial_rubber_144x18_move_bl_large";
    level._interactive_anims["curtain_industrial"]["move_bl_large_lim18"] = "curtain_industrial_rubber_144x18_move_bl_large_lim18";
    level._interactive_anims["curtain_industrial"]["move_bl_large_rail"] = "curtain_industrial_rubber_144x18_move_bl_large_rail";
    level._interactive_anims["curtain_industrial"]["move_bl_small"] = "curtain_industrial_rubber_144x18_move_bl_small";
    level._interactive_anims["curtain_industrial"]["move_br_large"] = "curtain_industrial_rubber_144x18_move_br_large";
    level._interactive_anims["curtain_industrial"]["move_br_large_lim18"] = "curtain_industrial_rubber_144x18_move_br_large_lim18";
    level._interactive_anims["curtain_industrial"]["move_br_large_rail"] = "curtain_industrial_rubber_144x18_move_br_large_rail";
    level._interactive_anims["curtain_industrial"]["move_br_small"] = "curtain_industrial_rubber_144x18_move_br_small";
    level._interactive_anims["curtain_industrial"]["move_f_large"] = "curtain_industrial_rubber_144x18_move_f_large";
    level._interactive_anims["curtain_industrial"]["move_f_large_rail"] = "curtain_industrial_rubber_144x18_move_f_large_rail";
    level._interactive_anims["curtain_industrial"]["move_f_small"] = "curtain_industrial_rubber_144x18_move_f_small";
    level._interactive_anims["curtain_industrial"]["move_fl_large"] = "curtain_industrial_rubber_144x18_move_fl_large";
    level._interactive_anims["curtain_industrial"]["move_fl_large_rail"] = "curtain_industrial_rubber_144x18_move_fl_large_rail";
    level._interactive_anims["curtain_industrial"]["move_fl_small"] = "curtain_industrial_rubber_144x18_move_fl_small";
    level._interactive_anims["curtain_industrial"]["move_fr_large"] = "curtain_industrial_rubber_144x18_move_fr_large";
    level._interactive_anims["curtain_industrial"]["move_fr_large_rail"] = "curtain_industrial_rubber_144x18_move_fr_large_rail";
    level._interactive_anims["curtain_industrial"]["move_fr_small"] = "curtain_industrial_rubber_144x18_move_fr_small";
  }

  level._interactive_animlengths["curtain_industrial"]["idle1"] = 6.67;
  level._interactive_animlengths["curtain_industrial"]["idle2"] = 5.47;
  level._interactive_animlengths["curtain_industrial"]["move_b_large"] = 3.0;
  level._interactive_animlengths["curtain_industrial"]["move_b_large_lim18"] = 3.0;
  level._interactive_animlengths["curtain_industrial"]["move_b_large_rail"] = 3.0;
  level._interactive_animlengths["curtain_industrial"]["move_b_small"] = 1.0;
  level._interactive_animlengths["curtain_industrial"]["move_bl_large"] = 2.33;
  level._interactive_animlengths["curtain_industrial"]["move_bl_large_lim18"] = 2.33;
  level._interactive_animlengths["curtain_industrial"]["move_bl_large_rail"] = 2.33;
  level._interactive_animlengths["curtain_industrial"]["move_bl_small"] = 1.0;
  level._interactive_animlengths["curtain_industrial"]["move_br_large"] = 2.33;
  level._interactive_animlengths["curtain_industrial"]["move_br_large_lim18"] = 2.33;
  level._interactive_animlengths["curtain_industrial"]["move_br_large_rail"] = 2.33;
  level._interactive_animlengths["curtain_industrial"]["move_br_small"] = 1.0;
  level._interactive_animlengths["curtain_industrial"]["move_f_large"] = 3.0;
  level._interactive_animlengths["curtain_industrial"]["move_f_large_rail"] = 3.33;
  level._interactive_animlengths["curtain_industrial"]["move_f_small"] = 1.0;
  level._interactive_animlengths["curtain_industrial"]["move_fl_large"] = 2.33;
  level._interactive_animlengths["curtain_industrial"]["move_fl_large_rail"] = 3.33;
  level._interactive_animlengths["curtain_industrial"]["move_fl_small"] = 1.0;
  level._interactive_animlengths["curtain_industrial"]["move_fr_large"] = 2.33;
  level._interactive_animlengths["curtain_industrial"]["move_fr_large_rail"] = 3.33;
  level._interactive_animlengths["curtain_industrial"]["move_fr_small"] = 1.0;
}

industrial_curtain_ondamage() {
  level endon("game_ended");

  if(isDefined(level.func["useanimtree"])) {
    self call[[level.func["useanimtree"]]](#animtree);

  }
  var_0 = common_scripts\utility::ter_op(common_scripts\utility::issp(), level.func["clearanim"], level.func["scriptModelClearAnim"]);
  var_1 = common_scripts\utility::ter_op(common_scripts\utility::issp(), level.func["setanim"], level.func["scriptModelPlayAnim"]);

  for(;;) {
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    self waittill("damage", var_6, var_7, var_8, var_9, var_10);
    var_3 = "move_";
    var_11 = self.angles[1];
    var_12 = angleclamp(vectortoyaw(var_8));
    var_13 = 15;
    var_14 = common_scripts\utility::ter_op(var_12 - var_11 > 0, 1, -1);
    var_15 = var_12 - var_11;
    var_15 = common_scripts\utility::ter_op(abs(var_15) > 180, -1 * var_14 * (360 - abs(var_15)), var_14 * abs(var_15));

    if(abs(var_15) > 90) {
      if(var_15 > 0 && 180 - abs(var_15) > var_13) {
        var_3 = var_3 + "br";
      } else if(var_15 < 0 && 180 - abs(var_15) > var_13) {
        var_3 = var_3 + "bl";
      } else {
        var_3 = var_3 + "b";
      }
    } else if(abs(var_15) < 90) {
      if(var_15 < 0 && abs(var_15) > var_13) {
        var_3 = var_3 + "fl";
      } else if(var_15 > 0 && abs(var_15) > var_13) {
        var_3 = var_3 + "fr";
      } else {
        var_3 = var_3 + "f";
      }
    }

    var_2 = "small";
    var_4 = 0;

    if(isDefined(var_10)) {
      switch (var_10) {
        case "MOD_GRENADE_SPLASH":
        case "MOD_GRENADE":
        case "MOD_EXPLOSIVE_SPLASH":
        case "MOD_EXPLOSIVE":
          var_5 = length(var_8 - (0, 0, 100));
          var_4 = (var_5 - 50) / 400;
          var_4 = max(var_4, 0);

          if(var_4 > 1) {
            var_4 = 0;

          }
          if(var_6 > 85) {
            var_2 = "large";

          }
          break;
      }
    }

    var_3 = var_3 + ("_" + var_2);

    if(isDefined(self._id_164F)) {
      if(isDefined(level._interactive_anims["curtain_industrial"][var_3 + "_" + self._id_164F])) {
        var_3 = var_3 + ("_" + self._id_164F);
      }
    }

    wait(var_4);

    if(common_scripts\utility::issp()) {
      self call[[var_0]](level._interactive_anims["curtain_industrial"]["idle1"], 0);
      self call[[var_0]](level._interactive_anims["curtain_industrial"]["idle2"], 0);
    } else {
      self call[[var_0]]();

    }
    if(common_scripts\utility::issp()) {
      self call[[var_1]](level._interactive_anims["curtain_industrial"][var_3], 1, 0, 1);
    } else {
      self call[[var_1]](level._interactive_anims["curtain_industrial"][var_3]);

    }
    var_11 = undefined;
    var_12 = undefined;
    var_13 = undefined;
    var_14 = undefined;
    var_15 = undefined;
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
    var_10 = undefined;
    wait(level._interactive_animlengths["curtain_industrial"][var_3]);

    if(common_scripts\utility::issp()) {
      self call[[var_0]](level._interactive_anims["curtain_industrial"][var_3], 0);
    } else {
      self call[[var_0]]();

    }
    thread industrial_curtain_playidleanim();
  }
}

industrial_curtain_playidleanim() {
  level endon("game_ended");
  self endon("damage");
  var_0 = common_scripts\utility::ter_op(common_scripts\utility::issp(), level.func["clearanim"], level.func["scriptModelClearAnim"]);
  var_1 = common_scripts\utility::ter_op(common_scripts\utility::issp(), level.func["setanim"], level.func["scriptModelPlayAnim"]);
  var_2 = randomintrange(1, 3);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(common_scripts\utility::issp()) {
      self call[[var_1]](level._interactive_anims["curtain_industrial"]["idle1"], 1, 0, 1);
    } else {
      self call[[var_1]](level._interactive_anims["curtain_industrial"]["idle1"]);

    }
    wait(level._interactive_animlengths["curtain_industrial"]["idle1"]);

    if(common_scripts\utility::issp()) {
      self call[[var_0]](level._interactive_anims["curtain_industrial"]["idle1"], 0);
      continue;
    }

    self call[[var_0]]();
  }

  if(common_scripts\utility::issp()) {
    self call[[var_1]](level._interactive_anims["curtain_industrial"]["idle2"], 1, 0, 1);
  } else {
    self call[[var_1]](level._interactive_anims["curtain_industrial"]["idle2"]);

  }
  wait(level._interactive_animlengths["curtain_industrial"]["idle2"]);
  wait(randomfloat(3));

  if(common_scripts\utility::issp()) {
    self call[[var_0]](level._interactive_anims["curtain_industrial"]["idle2"], 0);
  } else {
    self call[[var_0]]();
  }
}

industrial_curtain_hitbox_ondamage(var_0) {
  level endon("game_ended");
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