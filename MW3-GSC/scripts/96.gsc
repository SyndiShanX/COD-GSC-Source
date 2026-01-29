/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\96.gsc
**************************************/

_id_0A47(var_0) {
  self endon("death");
  self notify("end_mg_behavior");
  self endon("end_mg_behavior");
  self._id_0A48 = 1;
  self._id_0A49 = 0;

  if(!maps\_mgturret::_id_0A4A(var_0)) {
    self notify("continue_cover_script");
    return;
  }

  self._id_0A4B = undefined;
  thread _id_0A5C();
  var_1 = anglesToForward(var_0.angles);
  var_2 = spawn("script_origin", (0, 0, 0));
  thread _id_0A4D(var_2);
  var_2.origin = var_0.origin + var_1 * 500;

  if(isDefined(self._id_0A4B)) {
    var_2.origin = self._id_0A4B;

  }
  var_0 settargetentity(var_2);
  var_3 = undefined;

  for(;;) {
    if(!isalive(self._id_0A4C)) {
      _id_0A51();
      self waittill("new_enemy");
    }

    _id_0A52();
    _id_0A4E(var_2);

    if(!isalive(self._id_0A4C)) {
      continue;
    }
    if(self cansee(self._id_0A4C)) {
      continue;
    }
    self waittill("saw_enemy");
  }
}

_id_0A4D(var_0) {
  common_scripts\utility::waittill_either("death", "end_mg_behavior");
  var_0 delete();
}

_id_0A4E(var_0) {
  self endon("death");
  self endon("new_enemy");
  self._id_0A4C endon("death");
  var_1 = self._id_0A4C;

  while(self cansee(var_1)) {
    var_2 = vectortoangles(var_1 getEye() - var_0.origin);
    var_2 = anglesToForward(var_2);
    var_0 moveto(var_0.origin + var_2 * 12, 0.1);
    wait 0.1;
  }

  if(isplayer(var_1)) {
    self endon("saw_enemy");
    var_3 = var_1 getEye();
    var_2 = vectortoangles(var_3 - var_0.origin);
    var_2 = anglesToForward(var_2);
    var_4 = 150;
    var_5 = distance(var_0.origin, self._id_0A4B) / var_4;

    if(var_5 > 0) {
      var_0 moveto(self._id_0A4B, var_5);
      wait(var_5);
    }

    var_6 = var_0.origin + var_2 * 180;
    var_7 = _id_0A5B(self getEye(), var_0.origin, var_6);

    if(!isDefined(var_7)) {
      var_7 = var_0.origin;

    }
    var_0 moveto(var_0.origin + var_2 * 80 + (0, 0, randomfloatrange(15, 50) * -1), 3, 1, 1);
    wait 3.5;
    var_0 moveto(var_7 + var_2 * -20, 3, 1, 1);
  }

  wait(randomfloatrange(2.5, 4));
  _id_0A51();
}

_id_0A4F(var_0) {
  if(var_0) {
    self._id_0A48 = 1;

    if(self._id_0A49) {
      self._id_0A50 notify("startfiring");
    }
  } else {
    self._id_0A48 = 0;
    self._id_0A50 notify("stopfiring");
  }
}

_id_0A51() {
  self._id_0A49 = 0;
  self._id_0A50 notify("stopfiring");
}

_id_0A52() {
  self._id_0A49 = 1;

  if(self._id_0A48) {
    self._id_0A50 notify("startfiring");
  }
}

_id_0A53() {
  if(isDefined(level._id_0A54)) {
    level._id_0A54[level._id_0A54.size] = self;
    return;
  }

  level._id_0A54 = [];
  level._id_0A54[level._id_0A54.size] = self;
  waittillframeend;
  var_0 = spawnStruct();
  common_scripts\utility::array_thread(level._id_0A54, ::_id_0A55, var_0);
  var_1 = level._id_0A54;
  level._id_0A54 = undefined;
  var_0 waittill("gunner_died");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isalive(var_1[var_2])) {
      continue;
    }
    var_1[var_2] notify("stop_using_built_in_burst_fire");
    var_1[var_2] thread _id_0A58();
  }
}

_id_0A55(var_0) {
  self waittill("death");
  var_0 notify("gunner_died");
}

_id_0A56(var_0) {
  wait 1;
  level notify("new_mg_firing_team" + var_0[0].script_noteworthy);
  level endon("new_mg_firing_team" + var_0[0].script_noteworthy);

  for(;;) {
    _id_0A59(var_0);
    _id_0A57(var_0);
  }
}

_id_0A57(var_0) {
  var_1 = undefined;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isalive(var_0[var_2])) {
      continue;
    }
    var_1 = var_0[var_2];
    break;
  }

  if(!isDefined(var_1)) {
    return;
  }
}

_id_0A58() {
  self endon("death");

  for(;;) {
    self._id_0A50 startfiring();
    wait(randomfloatrange(0.3, 0.7));
    self._id_0A50 stopfiring();
    wait(randomfloatrange(0.1, 1.1));
  }
}

_id_0A59(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] endon("death");

  }
  var_2 = 0;
  var_3 = 1;

  for(;;) {
    if(isalive(var_0[var_2])) {
      var_0[var_2] _id_0A4F(1);

    }
    if(isalive(var_0[var_3])) {
      var_0[var_3] _id_0A4F(0);

    }
    var_4 = var_2;
    var_2 = var_3;
    var_3 = var_4;
    wait(randomfloatrange(2.3, 3.5));
  }
}

_id_0A5A(var_0, var_1) {
  _id_0A52();
  self endon("death");
  self endon("new_enemy");
  var_1 endon("death");

  while(self cansee(var_1)) {
    var_2 = vectortoangles(var_1 getEye() - var_0.origin);
    var_2 = anglesToForward(var_2);
    var_0 moveto(var_0.origin + var_2 * 10, 0.2);
    wait 0.2;
  }

  var_2 = vectortoangles(var_1 getEye() - var_0.origin);
  var_2 = anglesToForward(var_2);
  var_3 = 150;
  var_4 = distance(var_0.origin, self._id_0A4B) / var_3;
  var_0 moveto(self._id_0A4B, var_4);
  wait(var_4);
  var_5 = var_0.origin;
  var_0 moveto(var_0.origin + var_2 * 80 + (0, 0, -25), 3, 1, 1);
  wait 3.5;
  var_0 moveto(var_5 + var_2 * -20, 3, 1, 1);
  wait 1;
  _id_0A51();
}

_id_0A5B(var_0, var_1, var_2) {
  var_3 = distance(var_1, var_2) * 0.05;

  if(var_3 < 5) {
    var_3 = 5;

  }
  if(var_3 > 20) {
    var_3 = 20;

  }
  var_4 = var_2 - var_1;
  var_4 = (var_4[0] / var_3, var_4[1] / var_3, var_4[2] / var_3);
  var_5 = (0, 0, 0);
  var_6 = undefined;

  for(var_7 = 0; var_7 < var_3 + 2; var_7++) {
    var_8 = bulletTrace(var_0, var_1 + var_5, 0, undefined);

    if(var_8["fraction"] < 1) {
      var_6 = var_8["position"];
      break;
    }

    var_5 = var_5 + var_4;
  }

  return var_6;
}

_id_0A5C() {
  self endon("death");
  self endon("end_mg_behavior");
  self._id_0A4C = undefined;

  for(;;) {
    _id_0A5D();
    wait 0.05;
  }
}

_id_0A5D() {
  if(!isalive(self.enemy)) {
    return;
  }
  if(!self cansee(self.enemy)) {
    return;
  }
  self._id_0A4B = self.enemy getEye();
  self notify("saw_enemy");

  if(!isalive(self._id_0A4C) || self._id_0A4C != self.enemy) {
    self._id_0A4C = self.enemy;
    self notify("new_enemy");
  }
}