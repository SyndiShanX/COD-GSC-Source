/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_scriptedagents.gsc
******************************************************/

_id_0114(var_0, var_1) {
  if(isDefined(self._id_6AFF)) {
    self[[self._id_6AFF]](var_0, var_1);
  }
}

_id_0113() {
  self notify("killanimscript");
}

_id_7201(var_0, var_1, var_2, var_3) {
  _id_71FC(var_0, 0, var_1, var_2, var_3);
}

_id_71FC(var_0, var_1, var_2, var_3, var_4) {
  self setanimstate(var_0, var_1);

  if(!isDefined(var_3)) {
    var_3 = "end";
  }

  _id_A79E(var_2, var_3, var_0, var_1, var_4);
}

_id_71F9(var_0, var_1, var_2, var_3, var_4, var_5) {
  self setanimstate(var_0, var_1, var_2);

  if(!isDefined(var_4)) {
    var_4 = "end";
  }

  _id_A79E(var_3, var_4, var_0, var_1, var_5);
}

_id_A79E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = gettime();
  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(var_2) && isDefined(var_3)) {
    var_7 = _getanimlength(self getanimentry(var_2, var_3));
  }

  for(;;) {
    self waittill(var_0, var_8);

    if(isDefined(var_7)) {
      var_6 = (gettime() - var_5) * 0.001 / var_7;
    }

    if(!isDefined(var_7) || var_6 > 0) {
      if(var_8 == var_1 || var_8 == "end" || var_8 == "anim_will_finish" || var_8 == "finish") {
        break;
      }
    }

    if(isDefined(var_4)) {
      [[var_4]](var_8, var_2, var_3, var_6);
    }
  }
}

_id_71F7(var_0, var_1) {
  _id_71FB(var_0, 0, var_1);
}

_id_71FB(var_0, var_1, var_2) {
  self setanimstate(var_0, var_1);
  wait(var_2);
}

_id_71F8(var_0, var_1, var_2, var_3) {
  self setanimstate(var_0, var_1, var_2);
  wait(var_3);
}

_id_441C(var_0, var_1, var_2) {
  var_3 = _length2d(var_0);
  var_4 = var_0[2];
  var_5 = _length2d(var_1);
  var_6 = var_1[2];
  var_7 = 1;
  var_8 = 1;

  if(isDefined(var_2) && var_2) {
    var_9 = (var_1[0], var_1[1], 0);
    var_10 = vectorNormalize(var_9);

    if(vectordot(var_10, var_0) < 0) {
      var_7 = 0;
    } else if(var_5 > 0) {
      var_7 = var_3 / var_5;
    }
  } else if(var_5 > 0)
    var_7 = var_3 / var_5;

  if(_abs(var_6) > 0.001 && var_6 * var_4 >= 0) {
    var_8 = var_4 / var_6;
  }

  var_11 = spawnStruct();
  var_11._id_AAE3 = var_7;
  var_11._id_01D9 = var_8;
  return var_11;
}

_id_4414(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 10;
  }

  if(var_0 < 0) {
    return int(_ceil((180 + var_0 - var_1) / 45));
  } else {
    return int(_floor((180 + var_0 + var_1) / 45));
  }
}

_id_34A6(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 18;
  }

  var_2 = var_0 + (0, 0, var_1);
  var_3 = var_0 + (0, 0, var_1 * -1);
  var_4 = self aiphysicstrace(var_2, var_3, self.radius, self._id_00BD, 1);

  if(_abs(var_4[2] - var_2[2]) < 0.1) {
    return undefined;
  }

  if(_abs(var_4[2] - var_3[2]) < 0.1) {
    return undefined;
  }

  return var_4;
}

_id_1F5B(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  if(!isDefined(var_3)) {
    var_3 = self.radius;
  }

  var_4 = (0, 0, 1) * var_2;
  var_5 = var_0 + var_4;
  var_6 = var_1 + var_4;
  return self aiphysicstracepassed(var_5, var_6, var_3, self._id_00BD - var_2, 1);
}

_id_470B(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return self aiphysicstrace(var_4, var_5, self.radius + 4, self._id_00BD - var_2, 1);
}

_id_466C(var_0) {
  var_1 = _getmovedelta(var_0);
  var_2 = self localtoworldcoords(var_1);
  var_3 = _id_470B(self.origin, var_2);
  var_4 = distance(self.origin, var_3);
  var_5 = distance(self.origin, var_2);
  return _min(1.0, var_4 / var_5);
}

detach(var_0, var_1, var_2, var_3) {
  var_4 = _id_464A(var_0);
  _id_802D(var_0, var_4, var_1, var_2, var_3);
}

logstring(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_464A(var_0);
  _id_802C(var_0, var_5, var_1, var_2, var_3, var_4);
}

_id_802C(var_0, var_1, var_2, var_3, var_4, var_5) {
  self setanimstate(var_0, var_1, var_2);
  _id_802D(var_0, var_1, var_3, var_4, var_5);
}

_id_802D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self getanimentry(var_0, var_1);
  var_6 = _id_466C(var_5);
  self scragentsetanimscale(var_6, 1.0);
  _id_71FC(var_0, var_1, var_2, var_3, var_4);
  self scragentsetanimscale(1.0, 1.0);
}

_id_464A(var_0) {
  var_1 = self getanimentrycount(var_0);
  return randomint(var_1);
}

_id_4415(var_0) {
  var_1 = vectortoangles(var_0);
  var_2 = _angleclamp180(var_1[1] - self.angles[1]);
  return _id_4414(var_2);
}