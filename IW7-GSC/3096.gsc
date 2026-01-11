/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3096.gsc
***************************************/

func_1EDC() {
  if(!isDefined(self.anims)) {
    self.anims = spawnStruct();
  }
}

func_A3B2(var_00) {
  if(!isDefined(var_00)) {
    var_00 = self.spaceship_mode;
  }

  self.anims.state = var_00;
}

#using_animtree("jackal");

func_A3B5(var_00) {
  self endon("death");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.anims.state)) {
    if(self.anims.state == var_00) {
      return;
    }
    var_01 = self.anims.state;
  } else
    var_01 = "none";

  self.anims.state = var_00;
  self notify("notify_change_anim_state");
  self endon("notify_change_anim_state");
  var_02 = spawnStruct();
  var_02 func_A1E5(var_00, var_01, self.script_team);

  if(!isDefined(var_2.func_92CC)) {
    return;
  }
  if(isDefined(var_2.func_11B54)) {
    self setanimknob(var_2.func_11B54, 1.0, 0.2);
    var_03 = getanimlength(var_2.func_11B54);
  } else
    var_03 = 0;

  self setanimknob(var_2.func_BBB5, 1.0, var_03);
  wait(var_03);
  self setanimknob(var_2.func_92CC, 1.0, 0.2);
  self give_attacker_kill_rewards( % jackal_motion_idle_ai, 1, 0);
  wait 4;
}

func_A1E5(var_00, var_01, var_02) {
  self.func_11B54 = undefined;
  self.func_92CC = undefined;
  self.func_BBB5 = undefined;

  if(var_00 == "fly_glide") {
    var_00 = "fly";
  }

  if(var_00 == "hover_glide") {
    var_00 = "hover";
  }

  if(level.func_241D) {
    var_03 = "";
  }
  else {
    var_03 = "_space";
  }

  switch (var_00) {
    case "hover":
      self.func_92CC = level.func_A065[var_02 + "_hover" + var_03];
      self.func_BBB5 = level.func_A065[var_02 + "_hover_motion" + var_03];

      switch (var_01) {
        case "fly":
          self.func_11B54 = level.func_A065[var_02 + "_fly_to_hover" + var_03];
          break;
        case "landed_mode":
          self.func_11B54 = level.func_A065[var_02 + "_landed_to_hover"];
          break;
      }

      break;
    case "reentry":
      self.func_92CC = level.func_A065[var_02 + "_reentry"];
      self.func_BBB5 = level.func_A065[var_02 + "_reentry_motion"];

      switch (var_01) {
        case "fly":
          self.func_11B54 = level.func_A065[var_02 + "_fly_to_reentry"];
          break;
      }

      break;
    case "fly":
      self.func_92CC = level.func_A065[var_02 + "_fly" + var_03];
      self.func_BBB5 = level.func_A065[var_02 + "_fly_motion" + var_03];

      switch (var_01) {
        case "hover":
          self.func_11B54 = level.func_A065[var_02 + "_hover_to_fly" + var_03];
          break;
        case "landed_mode":
          self.func_11B54 = level.func_A065[var_02 + "_landed_to_fly"];
          break;
      }

      break;
    case "landed_mode":
      self.func_92CC = level.func_A065[var_02 + "_landed"];
      self.func_BBB5 = level.func_A065[var_02 + "_landed_motion"];
    case "none":
      break;
  }
}