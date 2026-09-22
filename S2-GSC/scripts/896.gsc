/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\896.gsc
**************************************/

_id_6840(var_0, var_1, var_2, var_3) {
  _id_0785("nsnd_play_2d", var_0);
  var_4 = _func_360(var_0, undefined, 0, var_2, var_3, undefined, undefined, var_1, undefined);
  _id_0787(isDefined(var_4), "Call to nsnd failed for alias: " + var_0);
  return var_4;
}

_id_6841(var_0, var_1, var_2, var_3, var_4) {
  _id_0785("nsnd_play_2d_untildeath", var_0);
  var_5 = undefined;

  if(isDefined(var_2)) {
    var_5 = _func_360(var_0, undefined, 0, var_3, var_4, undefined, undefined, var_1, undefined);

    if(isDefined(var_5)) {
      thread _id_0687(var_5, var_2, var_3);
    }
  }

  _id_0787(isDefined(var_5), "Call to nsnd failed for alias: " + var_0);
  return var_5;
}

_id_6850(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 _meth_863F(var_1);
  }
}

_id_6844(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isDefined(var_2)) {
    var_5 = _func_360(var_0, undefined, 0, var_3, var_4, var_2, undefined, var_1, undefined);
  }

  _id_0787(isDefined(var_5), "Call to nsnd failed for alias: " + var_0);
  return var_5;
}

_id_6848(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isDefined(var_2)) {
    var_6 = _func_360(var_0, undefined, 0, var_4, var_5, var_2, var_3, var_1, undefined);
  }

  _id_0787(isDefined(var_6), "Call to nsnd failed for alias: " + var_0);
  return var_6;
}

_id_6845(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isDefined(var_3)) {
    var_6 = _func_360(var_0, undefined, 0, var_4, var_5, var_3, undefined, var_1, var_2);
  }

  _id_0787(isDefined(var_6), "Call to nsnd failed for alias: " + var_0);
  return var_6;
}

_id_6849(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;

  if(isDefined(var_3)) {
    var_7 = _func_360(var_0, undefined, 0, var_5, var_6, var_3, var_4, var_1, var_2);
  }

  _id_0787(isDefined(var_7), "Call to nsnd failed for alias: " + var_0);
  return var_7;
}

_id_6846(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isDefined(var_2)) {
    var_6 = _func_360(var_0, undefined, 0, var_3, var_4, var_2, undefined, var_1, undefined);

    if(isDefined(var_6)) {
      thread _id_0687(var_6, var_2, var_5);
    }
  }

  _id_0787(isDefined(var_6), "Call to nsnd failed for alias: " + var_0);
  return var_6;
}

_id_684A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;

  if(isDefined(var_2)) {
    var_7 = _func_360(var_0, undefined, 0, var_4, var_5, var_2, var_3, var_1, undefined);

    if(isDefined(var_7)) {
      thread _id_0687(var_7, var_2, var_6);
    }
  }

  _id_0787(isDefined(var_7), "Call to nsnd failed for alias: " + var_0);
  return var_7;
}

_id_6847(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = _func_360(var_0, undefined, 0, var_3, var_4, var_2, undefined, var_1, undefined);

  if(isDefined(var_8)) {
    thread _id_0688(var_8, var_6, var_7, var_5);
  }

  _id_0787(isDefined(var_8), "Call to nsnd failed for alias: " + var_0);
  return var_8;
}

_id_684B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = _func_360(var_0, undefined, 0, var_4, var_5, var_2, var_3, var_1, undefined);

  if(isDefined(var_9)) {
    thread _id_0688(var_9, var_7, var_8, var_6);
  }

  _id_0787(isDefined(var_9), "Call to nsnd failed for alias: " + var_0);
  return var_9;
}

_id_6842(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _func_360(var_0, var_2, 0, var_3, var_4, undefined, undefined, var_1, undefined);
  _id_0787(isDefined(var_5), "Call to nsnd failed for alias: " + var_0);
  return var_5;
}

_id_6843(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = _func_360(var_0, var_2, 0, var_3, var_4, undefined, undefined, var_1, undefined);

  if(isDefined(var_8)) {
    thread _id_0688(var_8, var_6, var_7, var_5);
  }

  _id_0787(isDefined(var_8), "Call to nsnd failed for alias: " + var_0);
  return var_8;
}

_id_684C(var_0, var_1, var_2) {
  _id_077E(isDefined(var_0), "Call to nsnd_register_done_notify failed: snd_ent is undefined.");
  _id_077E(isDefined(var_1), "Call to nsnd_register_done_notify failed: entity is undefined.");
  return var_0 _meth_8640(var_1, var_2);
}

_id_0687(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 endon("death");
    var_1 waittill("death");
    var_0 _meth_863F(var_2);
  }
}

_id_0688(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    var_0 endon("death");
    var_1 waittill(var_2);
    var_0 _meth_863F(var_3);
  }
}

_id_0689(var_0, var_1, var_2) {
  var_0 endon("death");
  level waittill(var_2);
  var_0 _meth_863F(var_1);
}

_id_684F(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    thread _id_0689(var_0, var_1, var_2);
  }
}

_id_2888(var_0, var_1, var_2, var_3) {
  _id_0785("csnd_play_2d", var_0);
  var_4 = _func_351(var_0, undefined, undefined, undefined, undefined, undefined, var_2, undefined, var_3, undefined, var_1, undefined);
  _id_0787(isDefined(var_4), "Call to csnd failed for alias: " + var_0);
  return var_4;
}

_stoplocalsound(var_0, var_1) {
  if(isDefined(var_0)) {
    _func_352(var_0, var_1);
  }
}

_id_288B(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isDefined(var_2)) {
    var_5 = _func_351(var_0, var_2, undefined, undefined, undefined, "soft", var_3, undefined, var_4, undefined, var_1, undefined);
  }

  _id_0787(isDefined(var_5), "Call to csnd failed for alias: " + var_0);
  return var_5;
}

_id_288C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isDefined(var_3)) {
    var_6 = _func_351(var_0, var_3, undefined, undefined, undefined, "soft", var_4, undefined, var_5, undefined, var_1, var_2);
  }

  _id_0787(isDefined(var_6), "Call to csnd failed for alias: " + var_0);
  return var_6;
}

_id_288D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isDefined(var_2)) {
    var_6 = _func_351(var_0, var_2, undefined, undefined, undefined, "hard", var_3, undefined, var_4, undefined, var_1, undefined);
  }

  _id_0787(isDefined(var_6), "Call to csnd failed for alias: " + var_0);
  return var_6;
}

_id_288E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;

  if(isDefined(var_2)) {
    var_7 = _func_351(var_0, var_2, undefined, undefined, undefined, "soft", var_3, undefined, var_4, undefined, var_1, undefined);

    if(isDefined(var_7)) {
      thread _id_05F0(var_7, var_2, var_6, var_5);
    }
  }

  _id_0787(isDefined(var_7), "Call to csnd failed for alias: " + var_0);
  return var_7;
}

_id_2889(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_5 = _func_351(var_0, undefined, var_2, undefined, undefined, undefined, var_3, undefined, var_4, undefined, var_1, undefined);
  _id_0787(isDefined(var_5), "Call to csnd failed for alias: " + var_0);
  return var_5;
}

_id_288A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = _func_351(var_0, undefined, var_2, undefined, undefined, undefined, var_3, undefined, var_4, undefined, var_1, undefined);

  if(isDefined(var_8)) {
    thread _id_05F1(var_8, var_6, var_7, var_5);
  }

  _id_0787(isDefined(var_8), "Call to csnd failed for alias: " + var_0);
  return var_8;
}

_id_05F2(var_0, var_1, var_2) {
  level waittill(var_2);
  _func_352(var_0, var_1);
}

_id_2892(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    thread _id_05F2(var_0, var_1, var_2);
  }
}

_id_2890(var_0, var_1, var_2) {
  _func_355(var_0, var_1, var_2);
}

_id_2891(var_0, var_1, var_2) {
  _func_357(var_0, var_1, var_2);
}

_id_684D(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 _meth_8642(var_1, var_2);
  }
}

_id_684E(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 _meth_8641(var_1, var_2);
  }
}

_id_288F(var_0, var_1, var_2) {
  _id_077E(isDefined(var_0), "Call to nsnd_register_done_notify failed: handle is undefined.");
  _id_077E(isDefined(var_1), "Call to nsnd_register_done_notify failed: entity is undefined.");
  return _func_359(var_0, var_1, var_2);
}

_id_05F1(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    var_1 endon("death");
    var_1 waittill(var_2);
    _func_352(var_0, var_3);
  }
}

_id_05F0(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    var_1 common_scripts\utility::_id_A70A(var_2, "death");
    _func_352(var_0, var_3);
  }
}

_id_0787(var_0, var_1, var_2) {}

_id_077E(var_0, var_1, var_2) {}

_id_0785(var_0, var_1) {}

_id_0780(var_0, var_1) {
  var_2 = var_0;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  return var_2;
}

_id_0786(var_0, var_1) {
  var_0 endon("death");
  level waittill(var_1);
  return 1;
}

_id_077F(var_0, var_1) {
  level endon(var_1);

  if(isDefined(var_0)) {
    wait(var_0);
  }

  return 1;
}

_id_0781(var_0, var_1, var_2) {
  var_3 = _id_0786(var_0, var_1);

  if(isDefined(var_3) && isDefined(var_0)) {
    _id_6850(var_0, var_2);
  }
}

_id_AADF(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_AAD7(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_AAD6(var_0, var_1, var_2, var_3, var_4) {
  _id_0785("xsnd_play_2d", var_0);

  if(isDefined(var_1)) {
    var_5 = _id_6840(var_0, undefined, var_2, var_4);

    if(isDefined(var_5)) {
      thread _id_0781(var_5, var_1, var_3);
      return;
    }
  } else
    _id_2888(var_0, undefined, var_2, var_4);
}

_id_0782(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3)) {
    var_7 = _id_077F(var_1, var_3);
  } else {
    wait(var_1);
    var_7 = 1;
  }

  if(isDefined(var_7)) {
    _id_AAD6(var_0, var_3, var_4, var_5, var_6);
  }
}

_id_AAD9(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_0785("xsnd_play_delayed_2d", var_0);
  thread _id_0782(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_AADE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_1)) {
    var_7 = undefined;

    if(!isDefined(var_6)) {
      var_7 = _id_6844(var_0, undefined, self, var_2, var_4);
    } else {
      var_7 = _id_6848(var_0, undefined, self, var_6, var_2, var_4);
    }

    if(isDefined(var_7)) {
      thread _id_0781(var_7, var_1, var_3);
      return;
    }
  } else if(!isDefined(var_6))
    _id_288B(var_0, undefined, self, var_2, var_4);
  else {
    _id_6848(var_0, undefined, self, var_6, var_2, var_4);
  }
}

_id_AAE0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_AADE(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_0783(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_4)) {
    var_8 = _id_077F(var_2, var_4);
  } else {
    wait(var_2);
    var_8 = 1;
  }

  if(isDefined(var_8)) {
    _id_AAD7(var_0, var_1, var_4, var_5, var_6, var_7);
  }
}

_id_AADA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread _id_0783(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_AADD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  _id_AADA(var_0, var_3, var_1, var_2, var_4, var_5, var_6, var_7);
}

_id_AAD7(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_2)) {
    var_6 = _id_6842(var_0, undefined, var_1, var_3, var_5);

    if(isDefined(var_6)) {
      thread _id_0781(var_6, var_2, var_4);
      return;
    }
  } else
    _id_2889(var_0, undefined, var_1, var_3, var_5);
}

_id_0784(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3)) {
    var_7 = _id_077F(var_1, var_3);
  } else {
    if(isDefined(var_1)) {
      wait(var_1);
    }

    var_7 = 1;
  }

  if(isDefined(var_7)) {
    self._id_8E50 = _id_AADE(var_0, var_3, var_4, var_5, var_6);
  }
}

_id_AADB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawn("script_origin", var_1);

  if(isDefined(var_8)) {
    if(!isDefined(var_2) || var_2 == 0.0) {
      var_8._id_8E50 = var_8 _id_AADE(var_0, var_4, var_5, var_6, var_7);
    } else {
      var_8 thread _id_0784(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
    }
  }

  return var_8;
}

_id_AADC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1) || var_1 == 0.0) {
    _id_AADE(var_0, var_3, var_4, var_5, var_6);
  } else {
    thread _id_0784(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }
}

_id_AAD8(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawn("script_origin", var_1);

  if(isDefined(var_7)) {
    var_7._id_8E50 = var_7 _id_AADE(var_0, var_3, var_4, var_5, var_6);
  }

  return var_7;
}