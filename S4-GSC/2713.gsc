/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2713.gsc
*************************************************/

_id_D5EA(var_0, var_1, var_2) {
  var_3 = getDvar("#x3a30c33efc8281eb1");

  if(var_3 != "cp_survival" && var_3 != "cp_wave_sv" && var_3 != "cp_specops") {
    self setclientomnvar("ui_lower_message", var_0);

    if(isDefined(var_1)) {
      self setclientomnvar("ui_lower_message_time", var_1);
    }

    if(isDefined(var_2)) {
      thread _id_3961(var_2);
    }
  }
}

_id_3961(var_0) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("death_or_disconnect");
  wait(var_0);
  var_1 = getDvar("#x3a30c33efc8281eb1");

  if(var_1 != "cp_survival" && var_1 != "cp_wave_sv" && var_1 != "cp_specops") {
    self setclientomnvar("ui_lower_message", 0);
  }
}

_id_D5EB(var_0, var_1, var_2) {
  _id_D5EA(_id_6B28(var_0), var_1, var_2);
}

_id_6B28(var_0) {
  var_1 = _func_0222("mp/hints.csv", 1, var_0, 0);
  return int(var_1);
}

_id_D5E9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 0.85;
  }

  if(!isDefined(var_7)) {
    var_7 = 3.0;
  }

  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  if(!isDefined(var_9)) {
    var_9 = 1;
  }

  _id_10E7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  _id_FCB7();
}

_id_3958(var_0) {
  _id_C4E2(var_0);
  _id_FCB7();
}

_id_3959() {
  for(var_0 = 0; var_0 < self._id_98C6.size; var_0++) {
    self._id_98C6[var_0] = undefined;
  }

  if(!isDefined(self._id_98C4)) {
    return;
  }
  _id_FCB7();
}

_id_E037() {
  for(var_0 = 1; var_0 < self._id_98C6.size; var_0++) {
    var_1 = self._id_98C6[var_0];
    var_2 = var_1._id_BD27;

    for(var_3 = var_0 - 1; var_3 >= 0 && var_2 > self._id_98C6[var_3]._id_BD27; var_3--) {
      self._id_98C6[var_3 + 1] = self._id_98C6[var_3];
    }

    self._id_98C6[var_3 + 1] = var_1;
  }
}

_id_10E7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = undefined;

  foreach(var_12 in self._id_98C6) {
    if(var_12.name == var_0) {
      if(var_12._id_F0E8 == var_1 && var_12._id_BD27 == var_3) {
        return;
      }
      var_10 = var_12;
      break;
    }
  }

  if(!isDefined(var_10)) {
    var_10 = spawnStruct();
    self._id_98C6[self._id_98C6.size] = var_10;
  }

  var_10.name = var_0;
  var_10._id_F0E8 = var_1;
  var_10._id_F1E8 = var_2;
  var_10._id_1154 = gettime();
  var_10._id_BD27 = var_3;
  var_10._id_DCF2 = var_4;
  var_10._id_DB58 = var_5;
  var_10._id_58C4 = var_6;
  var_10._id_58C5 = var_7;
  var_10._id_021E = var_8;
  var_10.hidewheninmenu = var_9;
  _id_E037();
}

_id_C4E2(var_0) {
  if(isDefined(self._id_98C6)) {
    for(var_1 = self._id_98C6.size; var_1 > 0; var_1--) {
      if(self._id_98C6[var_1 - 1].name != var_0) {
        continue;
      }
      var_2 = self._id_98C6[var_1 - 1];

      for(var_3 = var_1; var_3 < self._id_98C6.size; var_3++) {
        if(isDefined(self._id_98C6[var_3])) {
          self._id_98C6[var_3 - 1] = self._id_98C6[var_3];
        }
      }

      self._id_98C6[self._id_98C6.size - 1] = undefined;
    }

    _id_E037();
  }
}

_id_6B27() {
  if(!isDefined(self._id_98C6)) {
    return undefined;
  }

  return self._id_98C6[0];
}

_id_FCB7() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = _id_6B27();

  if(!isDefined(var_0)) {
    if(isDefined(self._id_98C4) && isDefined(self._id_98CB)) {
      self._id_98C4.alpha = 0;
      self._id_98CB.alpha = 0;
    }
  } else {
    self._id_98C4 settext(var_0._id_F0E8);
    self._id_98C4.alpha = 0.85;
    self._id_98CB.alpha = 1;
    self._id_98C4._id_021E = var_0._id_021E;
    self._id_98C4.hidewheninmenu = var_0.hidewheninmenu;

    if(var_0._id_DB58) {
      self._id_98C4 fadeovertime(min(var_0._id_58C5, 60));
      self._id_98C4.alpha = var_0._id_58C4;
    }

    if(var_0._id_F1E8 > 0 && var_0._id_DCF2) {
      self._id_98CB _meth_8391(max(var_0._id_F1E8 - (gettime() - var_0._id_1154) / 1000, 0.1));
    } else {
      if(var_0._id_F1E8 > 0 && !var_0._id_DCF2) {
        self._id_98CB settext("");
        self._id_98C4 fadeovertime(min(var_0._id_F1E8, 60));
        self._id_98C4.alpha = 0;
        thread _id_3962(var_0);
        thread _id_391B(var_0);
        return;
      }

      self._id_98CB settext("");
    }
  }
}

_id_3962(var_0) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  _id_3958(var_0.name);
}

_id_391B(var_0) {
  wait(var_0._id_F1E8);
  _id_3958(var_0.name);
  self notify("message_cleared");
}