/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2726.gsc
*************************************************/

_id_F63B() {
  var_0 = getEntArray("trigger_multiple_mp_enterexit", "classname");

  foreach(var_2 in var_0) {
    _id_99E8(var_2);
  }
}

_id_99E8(var_0, var_1, var_2, var_3, var_4) {
  var_0 thread _id_F61F(var_1, var_2, var_3, var_4);
}

_id_F61F(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("death");
  self._id_F61E = [];
  self._id_F629 = [];
  thread _id_F620(var_1, var_3);

  for(;;) {
    self waittill("trigger", var_4);
    var_5 = var_4 getentitynumber();

    if(!isDefined(self._id_F61E[var_5])) {
      self notify("trigger_enter", var_4);

      if(isDefined(var_0)) {
        var_4 thread[[var_0]](var_4, self);
      }

      if(isDefined(var_2)) {
        var_4 notify(var_2, self);
      }

      self._id_F61E[var_5] = var_4;
      self._id_F629[var_5] = gettime();
      continue;
    }

    self._id_F629[var_5] = gettime();
  }
}

_id_F620(var_0, var_1) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    waittillframeend;
    var_2 = gettime();

    foreach(var_5, var_4 in self._id_F61E) {
      if(!isDefined(var_4)) {
        self._id_F61E[var_5] = undefined;
        self._id_F629[var_5] = undefined;
        continue;
      }

      if(self._id_F629[var_5] < var_2) {
        self notify("trigger_exit", var_4);

        if(isDefined(var_0)) {
          var_4 thread[[var_0]](var_4, self);
        }

        if(isDefined(var_1)) {
          var_4 notify(var_1, self);
        }

        self._id_F61E[var_5] = undefined;
        self._id_F629[var_5] = undefined;
      }
    }

    waitframe();
  }
}