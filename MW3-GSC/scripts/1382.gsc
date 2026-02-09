/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1382.gsc
**************************************/

_id_42D4() {
  _id_4232();
  thread _id_42D5();
}

_id_42D5() {
  self endon("death");
  self endon("pain_death");
  self._id_42D6 = self.fixednode;
  self._id_42D7 = self.fixednodesaferadius;

  for(;;) {
    maps\_utility::_id_1654("_stealth_stance_handler");
    common_scripts\utility::flag_waitopen("_stealth_spotted");
    self.fixednode = 1;
    self.fixednodesaferadius = 10;

    while(maps\_utility::_id_1008("_stealth_stance_handler") && !common_scripts\utility::flag("_stealth_spotted")) {
      _id_42D9();
      var_0 = [];
      var_0 = _id_42DA(var_0);

      if(var_0[self._id_0B6E._id_41ED.stance]) {
        thread _id_42DD();
      } else if(maps\_utility::_id_1008("_stealth_stay_still")) {
        thread _id_42E1();
      } else if(!var_0[self._id_0B6E._id_41D0._id_42D8] && self._id_0B6E._id_41D0._id_42D8 != self._id_0B6E._id_41ED.stance) {
        thread _id_42DF();
      } else if(maps\_utility::_id_1008("_stealth_stance_change")) {
        self notify("_stealth_stance_dont_change");
      }
      wait 0.05;
    }

    self.fixednode = self._id_42D6;
    self.fixednodesaferadius = self._id_42D7;
    self._id_0FC6 = 1;
    self allowedstances("stand", "crouch", "prone");

    if(maps\_utility::_id_1008("_stealth_stay_still")) {
      thread _id_42E1(0);
    }
  }
}

_id_42D9() {
  switch (self._id_0B6E._id_41ED.stance) {
    case "prone":
      self._id_0B6E._id_41D0._id_42D8 = "crouch";
      break;
    case "crouch":
      self._id_0B6E._id_41D0._id_42D8 = "stand";
      break;
    case "stand":
      self._id_0B6E._id_41D0._id_42D8 = "stand";
      break;
  }
}

_id_42DA(var_0) {
  var_1 = getaispeciesarray("bad_guys", "all");
  var_0[self._id_0B6E._id_41ED.stance] = 0;
  var_0[self._id_0B6E._id_41D0._id_42D8] = 0;

  foreach(var_9, var_3 in var_1) {
    var_4 = _id_42DB(var_3, self._id_0B6E._id_41ED.stance);
    var_5 = _id_42DB(var_3, self._id_0B6E._id_41D0._id_42D8);
    var_6 = _id_055E::_id_421F() + var_4;
    var_7 = _id_055E::_id_421F(self._id_0B6E._id_41D0._id_42D8) + var_5;
    var_8 = distance(var_3.origin, self.origin);

    if(var_8 < var_6) {
      var_0[self._id_0B6E._id_41ED.stance] = var_6;
      break;
    }

    if(var_8 < var_7) {
      var_0[self._id_0B6E._id_41D0._id_42D8] = var_7;
    }
  }

  return var_0;
}

_id_42DB(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = vectornormalize(self.origin - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0.3) {
    return self._id_0B6E._id_41D0._id_42DC["looking_towards"][var_1];
  } else if(var_4 < -0.7) {
    return self._id_0B6E._id_41D0._id_42DC["looking_away"][var_1];
  } else {
    return self._id_0B6E._id_41D0._id_42DC["neutral"][var_1];
  }
}

_id_42DD() {
  self._id_0FC6 = 1;
  self notify("_stealth_stance_down");

  switch (self._id_0B6E._id_41ED.stance) {
    case "stand":
      self._id_0FC6 = 0.7;
      self allowedstances("crouch");
      break;
    case "crouch":
      if(self._id_0B6E._id_41D0._id_42DE) {
        _id_42E0();
      } else {
        self allowedstances("prone");
      }
      break;
    case "prone":
      _id_42E0();
      break;
  }
}

_id_42DF() {
  self endon("_stealth_stance_down");
  self endon("_stealth_stance_dont_change");
  self endon("_stealth_stance_handler");

  if(maps\_utility::_id_1008("_stealth_stance_change")) {
    return;
  }
  var_0 = 4;
  maps\_utility::_id_13DC("_stealth_stance_change");
  maps\_utility::_id_09C9(maps\_utility::_id_09E7, var_0);
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "_stealth_stance_down");
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "_stealth_stance_dont_change");
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "_stealth_stance_handler");
  maps\_utility::_id_1DB1(maps\_utility::_id_13DE, "_stealth_stance_change");
  thread maps\_utility::_id_09CB();
  wait(var_0);
  self._id_0FC6 = 1;

  switch (self._id_0B6E._id_41ED.stance) {
    case "prone":
      self allowedstances("crouch");
      break;
    case "crouch":
      self allowedstances("stand");
      break;
    case "stand":
      break;
  }
}

_id_42E0() {
  self notify("friendly_stance_handler_stay_still");

  if(maps\_utility::_id_1008("_stealth_stay_still")) {
    return;
  }
  maps\_utility::_id_13DC("_stealth_stay_still");
  badplace_cylinder("_stealth_" + self.unique_id + "_prone", 0, self.origin, 30, 90, "bad_guys");
  self.fixednodesaferadius = 5000;
}

_id_42E1(var_0) {
  self endon("friendly_stance_handler_stay_still");

  if(!isDefined(var_0)) {
    var_0 = self._id_0B6E._id_41D0._id_42E2;
  }
  wait(var_0);

  if(!maps\_utility::_id_1008("_stealth_stay_still")) {
    return;
  }
  maps\_utility::_id_13DE("_stealth_stay_still");
  badplace_delete("_stealth_" + self.unique_id + "_prone");
  self.fixednodesaferadius = 10;
}

_id_4232() {
  maps\_utility::_id_1402("_stealth_stance_handler");
  maps\_utility::_id_1402("_stealth_stay_still");
  maps\_utility::_id_1402("_stealth_stance_change");
  self._id_0B6E._id_41D0._id_42D8 = undefined;
  self._id_0B6E._id_41D0._id_42DC = [];
  _id_42E4();
  self._id_0B6E._id_41D0._id_42DE = 0;
  self._id_0B6E._id_41D0._id_42E2 = 2;
  self._id_0B6E._id_423A._id_42E3 = 1;
}

_id_42E4() {
  var_0 = [];
  var_0["stand"] = 500;
  var_0["crouch"] = -400;
  var_0["prone"] = 0;
  var_1 = [];
  var_1["stand"] = 500;
  var_1["crouch"] = 200;
  var_1["prone"] = 50;
  var_2 = [];
  var_2["stand"] = 800;
  var_2["crouch"] = 400;
  var_2["prone"] = 100;
  _id_42E5(var_0, var_1, var_2);
}

_id_42E5(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    foreach(var_5, var_4 in var_0) {}
    self._id_0B6E._id_41D0._id_42DC["looking_away"][var_5] = var_4;
  }

  if(isDefined(var_1)) {
    foreach(var_5, var_4 in var_1) {}
    self._id_0B6E._id_41D0._id_42DC["neutral"][var_5] = var_4;
  }

  if(isDefined(var_2)) {
    foreach(var_5, var_4 in var_2) {}
    self._id_0B6E._id_41D0._id_42DC["looking_towards"][var_5] = var_4;
  }
}