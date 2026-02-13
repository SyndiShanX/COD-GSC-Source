/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2027.gsc
*************************************************/

init() {}

_id_1044(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(var_4 == 0) {
    var_4 = undefined;
  }

  if(!isDefined(self._id_945D) || self._id_945D.size == 0) {
    var_6 = [];
    var_6[0] = spawnStruct();
    self._id_945D = var_6;
  } else {
    var_7 = scripts\engine\utility::_id_1BD1(self._id_945D);
    self._id_945D = var_7;
    self._id_945D[self._id_945D.size] = spawnStruct();
  }

  self._id_945D[self._id_945D.size - 1]._id_9120 = var_0;
  self._id_945D[self._id_945D.size - 1]._id_BE29 = var_1;
  self._id_945D[self._id_945D.size - 1]._id_BD27 = var_2;
  self._id_945D[self._id_945D.size - 1]._id_5334 = var_3;
  self._id_945D[self._id_945D.size - 1]._id_F241 = gettime();
  self._id_945D[self._id_945D.size - 1]._id_56F1 = 0;
  self._id_945D[self._id_945D.size - 1]._id_5335 = var_5;

  if(isDefined(var_4)) {
    self._id_945D[self._id_945D.size - 1]._id_F1E8 = var_4 * 1000;
  } else {
    self._id_945D[self._id_945D.size - 1]._id_F1E8 = undefined;
  }

  if(isDefined(var_3) && var_3) {
    thread _id_5308(self._id_945D[self._id_945D.size - 1]);
  }

  if(isDefined(var_5)) {
    thread _id_5322(var_5, self._id_945D[self._id_945D.size - 1]);
  }

  thread _id_9A21();
}

_id_9A21() {
  self notify("manageLightBarStack");
  self endon("manageLightBarStack");
  self endon("disconnect");

  for(;;) {
    wait 0.05;

    if(self._id_945D.size > 1) {
      var_0 = _id_C535(self._id_945D);
      var_1 = scripts\engine\utility::_id_1BD6(var_0, ::_id_85F2);
    } else
      var_1 = self._id_945D;

    if(var_1.size == 0) {
      return;
    }
    self._id_945D = var_1;
    var_2 = var_1[0];

    if(var_2._id_56F1) {
      continue;
    }
    var_3 = !isDefined(self._id_945D[self._id_945D.size - 1]._id_F1E8);
    var_4 = 0;

    if(!var_3) {
      var_5 = gettime() - var_2._id_F241;
      var_4 = var_2._id_F1E8 - var_5;
      var_4 = var_4 / 1000;

      if(var_4 <= 0) {
        self._id_945D[0] notify("removed");
        self._id_945D[0] = undefined;
        _id_3840();
        _id_9A21();
      }
    }

    if(var_3) {
      if(var_2._id_5334) {
        var_2 notify("executing");
        var_2._id_56F1 = 1;
        thread _id_D27A(var_2._id_9120, var_2._id_BE29);
      } else
        thread _id_D279(var_2._id_9120, var_2._id_BE29);

      continue;
    }

    if(var_2._id_5334) {
      var_2 notify("executing");
      var_2._id_56F1 = 1;
      thread _id_D276(var_2._id_9120, var_2._id_BE29, var_4);
      continue;
    }

    thread _id_D275(var_2._id_9120, var_2._id_BE29, var_4);
  }
}

_id_3840() {
  var_0 = scripts\engine\utility::_id_1BD1(self._id_945D);
  self._id_945D = var_0;
}

_id_C535(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3._id_F1E8)) {
      var_1[var_1.size] = var_3;
      continue;
    }

    var_4 = gettime() - var_3._id_F241;
    var_5 = var_3._id_F1E8 - var_4;
    var_5 = var_5 / 1000;

    if(var_5 > 0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_85F2(var_0, var_1) {
  return var_0._id_BD27 > var_1._id_BD27;
}

_id_D272(var_0, var_1) {
  _id_D27B(var_1);
  _id_D273(var_0);
  _id_D278();
}

_id_D275(var_0, var_1, var_2) {
  self notify("set_lightbar_for_time");
  self endon("set_lightbar_for_time");
  _id_D27B(var_1);
  _id_D273(var_0);
  _id_D278();
  wait(var_2);

  if(!isDefined(self)) {
    return;
  }
  _id_D277();
  self._id_945D = undefined;
  _id_3840();
}

_id_D279(var_0, var_1) {
  self notify("set_lightbar");
  self endon("set_lightbar");
  _id_D27B(var_1);
  _id_D273(var_0);
  _id_D278();
}

_id_D274(var_0, var_1) {
  _id_D27B(var_1);
  _id_D273(var_0);
  _id_D278();
  thread _id_F7F3();
}

_id_D276(var_0, var_1, var_2) {
  self notify("set_lightbar_for_time_endon_death");
  self endon("set_lightbar_for_time_endon_death");
  _id_D27B(var_1);
  _id_D273(var_0);
  _id_D278();
  thread _id_F7F3();
  wait(var_2);

  if(!isDefined(self)) {
    return;
  }
  _id_D277();
  self._id_945D[0] notify("removed");
  self._id_945D[0] = undefined;
  _id_3840();
}

_id_D27A(var_0, var_1) {
  self notify("set_lightbar_endon_death");
  self endon("set_lightbar_endon_death");
  _id_D27B(var_1);
  _id_D273(var_0);
  _id_D278();
  thread _id_F7F3();
}

_id_5308(var_0) {
  self notify("endInactiveInstructionOnDeath");
  self endon("endInactiveInstructionOnDeath");
  var_0 endon("executing");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(self._id_945D.size == 0) {
    return;
  }
  self._id_945D[0] notify("removed");
  self._id_945D[0] = undefined;
  _id_3840();
}

_id_5322(var_0, var_1) {
  var_1 endon("removed");

  if(_func_0107(var_0)) {
    var_2 = scripts\engine\utility::_id_10892(var_0);
  } else {
    self waittill(var_0);
  }

  if(!isDefined(self)) {
    return;
  }
  for(var_3 = 0; var_3 < self._id_945D.size; var_3++) {
    if(var_1 == self._id_945D[var_3]) {
      if(var_1._id_56F1) {
        _id_D277();
      }

      self._id_945D[var_3] = undefined;
      _id_3840();
      return;
    }
  }
}

_id_F7F3() {
  self notify("turn_Off_Light_Bar_On_Death");
  self endon("turn_Off_Light_Bar_On_Death");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(self._id_945D.size == 0) {
    return;
  }
  _id_D277();
  self._id_945D[0] notify("removed");
  self._id_945D[0] = undefined;
  _id_3840();
}

_id_D273(var_0) {
  self setclientomnvar("lb_color", var_0);
}

_id_D278() {
  self setclientomnvar("lb_gsc_controlled", 1);
}

_id_D277() {
  self setclientomnvar("lb_gsc_controlled", 0);
}

_id_D27B(var_0) {
  self setclientomnvar("lb_pulse_time", var_0);
}