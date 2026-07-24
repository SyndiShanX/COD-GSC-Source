/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3096.gsc
**************************************/

_id_1EDC() {
  if(!isDefined(self.anims)) {
    self.anims = spawnStruct();
  }
}

_id_A3B2(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.spaceship_mode;
  }

  self.anims.state = var_0;
}

#using_animtree("jackal");

_id_A3B5(var_0) {
  self endon("death");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.anims.state)) {
    if(self.anims.state == var_0) {
      return;
    }
    var_1 = self.anims.state;
  } else
    var_1 = "none";

  self.anims.state = var_0;
  self notify("notify_change_anim_state");
  self endon("notify_change_anim_state");
  var_2 = spawnStruct();
  var_2 _id_A1E5(var_0, var_1, self.script_team);

  if(!isDefined(var_2._id_92CC)) {
    return;
  }
  if(isDefined(var_2._id_11B54)) {
    self setanimknob(var_2._id_11B54, 1.0, 0.2);
    var_3 = getanimlength(var_2._id_11B54);
  } else
    var_3 = 0;

  self setanimknob(var_2._id_BBB5, 1.0, var_3);
  wait(var_3);
  self setanimknob(var_2._id_92CC, 1.0, 0.2);
  self _meth_82A2(%jackal_motion_idle_ai, 1, 0);
  wait 4;
}

_id_A1E5(var_0, var_1, var_2) {
  self._id_11B54 = undefined;
  self._id_92CC = undefined;
  self._id_BBB5 = undefined;

  if(var_0 == "fly_glide") {
    var_0 = "fly";
  }

  if(var_0 == "hover_glide") {
    var_0 = "hover";
  }

  if(level._id_241D) {
    var_3 = "";
  } else {
    var_3 = "_space";
  }

  switch (var_0) {
    case "hover":
      self._id_92CC = level._id_A065[var_2 + "_hover" + var_3];
      self._id_BBB5 = level._id_A065[var_2 + "_hover_motion" + var_3];

      switch (var_1) {
        case "fly":
          self._id_11B54 = level._id_A065[var_2 + "_fly_to_hover" + var_3];
          break;
        case "landed_mode":
          self._id_11B54 = level._id_A065[var_2 + "_landed_to_hover"];
          break;
      }

      break;
    case "reentry":
      self._id_92CC = level._id_A065[var_2 + "_reentry"];
      self._id_BBB5 = level._id_A065[var_2 + "_reentry_motion"];

      switch (var_1) {
        case "fly":
          self._id_11B54 = level._id_A065[var_2 + "_fly_to_reentry"];
          break;
      }

      break;
    case "fly":
      self._id_92CC = level._id_A065[var_2 + "_fly" + var_3];
      self._id_BBB5 = level._id_A065[var_2 + "_fly_motion" + var_3];

      switch (var_1) {
        case "hover":
          self._id_11B54 = level._id_A065[var_2 + "_hover_to_fly" + var_3];
          break;
        case "landed_mode":
          self._id_11B54 = level._id_A065[var_2 + "_landed_to_fly"];
          break;
      }

      break;
    case "landed_mode":
      self._id_92CC = level._id_A065[var_2 + "_landed"];
      self._id_BBB5 = level._id_A065[var_2 + "_landed_motion"];
    case "none":
      break;
  }
}