/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1883.gsc
*************************************************/

_id_19F5(var_0, var_1) {
  var_0 notify("applyZombieScriptableState");
  var_0 endon("applyZombieScriptableState");
  var_0 endon("death");

  if(isDefined(var_0._id_A531)) {
    return;
  }
  var_2 = 1;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  while(var_2) {
    var_10 = istrue(var_0._id_8545);
    var_11 = istrue(var_0._id_8569);
    var_12 = istrue(var_0._id_EAAB);
    var_13 = istrue(var_0._id_8873);
    var_14 = istrue(var_0._id_856F);
    var_15 = istrue(var_0._id_85AF);
    var_16 = isDefined(var_0._id_5FE7);

    if(var_13) {
      if(!var_5) {
        var_5 = 1;
        var_3 = 0;
        var_4 = 0;
        var_6 = 0;
        var_7 = 0;
        var_8 = 0;
        var_9 = 0;
        var_0._id_CF2C = 1;
        _id_4A1F(var_0, "frozen");
      }
    } else if(var_16) {
      if(!var_9) {
        var_9 = 1;
        var_5 = 0;
        var_3 = 0;
        var_4 = 0;
        var_6 = 0;
        var_7 = 0;
        var_8 = 0;
        var_0._id_CF2C = 1;

        if(isalive(var_0)) {
          var_0 setscriptablepartstate("cold", "active", 1);
          _id_4A1F(var_0, "cold");
          var_0 thread _id_11A6(var_0, var_1);
        }
      }
    } else if(var_10) {
      if(!var_8) {
        var_8 = 1;
        var_3 = 0;
        var_4 = 0;
        var_5 = 0;
        var_6 = 0;
        var_7 = 0;
        var_9 = 0;
        var_0._id_CF2C = 1;

        if(isalive(var_0)) {
          var_0 setscriptablepartstate("arcane_white", "active", 1);
          _id_4A1F(var_0, "arcane_white");
        }
      }
    } else if(var_14) {
      if(!var_6) {
        var_6 = 1;
        var_3 = 0;
        var_4 = 0;
        var_5 = 0;
        var_7 = 0;
        var_8 = 0;
        var_9 = 0;
        var_0._id_CF2C = 1;

        if(isalive(var_0)) {
          var_0 setscriptablepartstate("chemburn", "active", 1);
          _id_4A1F(var_0, "chemburn");
        }
      }
    } else if(var_11) {
      if(!var_3) {
        var_3 = 1;
        var_4 = 0;
        var_5 = 0;
        var_6 = 0;
        var_7 = 0;
        var_8 = 0;
        var_9 = 0;
        var_0._id_CF2C = 1;

        if(isalive(var_0)) {
          var_0 setscriptablepartstate("burning", "active", 1);
          _id_4A1F(var_0, "burning");
        }
      }
    } else if(var_15) {
      if(!var_7) {
        var_7 = 1;
        var_3 = 0;
        var_4 = 0;
        var_5 = 0;
        var_6 = 0;
        var_8 = 0;
        var_9 = 0;
        var_0._id_CF2C = 1;

        if(isalive(var_0)) {
          var_0 setscriptablepartstate("shocked", "active", 1);
          _id_4A1F(var_0, "electrified");
        }
      }
    } else if(var_12) {
      if(!var_4) {
        var_4 = 1;
        var_3 = 0;
        var_5 = 0;
        var_6 = 0;
        var_7 = 0;
        var_8 = 0;
        var_9 = 0;
        var_0._id_CF2C = 1;

        if(isalive(var_0)) {
          var_0 setscriptablepartstate("shocked", "active", 1);
          _id_4A1F(var_0, "shocked");
        }
      }
    } else {
      var_0._id_CF2C = undefined;
      var_0 _id_F7FC(var_0, var_5);
      var_2 = 0;
    }

    wait 0.1;
  }
}

_id_11A6(var_0, var_1) {
  var_0 endon("death");

  if(istrue(var_0._id_0043)) {
    var_0 dodamage(1, var_0.origin);
    var_0._id_0043 = 0;
  }

  if(istrue(var_0._id_DDFE)) {
    var_0._id_DDFE = undefined;
  } else {
    return;
  }

  if(!isDefined(var_0._id_1C30._id_4130)) {
    var_2 = self._id_91A3._id_02D6;
  } else {
    var_2 = var_0._id_1C30._id_4130;
  }

  var_2 = var_0._id_1C30._id_4130;

  switch (var_2) {
    case "slow_walk":
      break;
    case "walk":
      var_0 _id_06BD::_id_23F3("slow_walk");
      break;
    case "run":
      var_0 _id_06BD::_id_23F3("walk");
      break;
    case "sprint":
      var_0 _id_06BD::_id_23F3("run");
      break;
  }

  var_0 waittill("defrosted");
  var_0 _id_06BD::_id_23F3(var_2);
}

_id_C4C4(var_0) {
  var_0 notify("frozen_tick_updated");
  var_0 endon("frozen_tick_updated");
  var_0 endon("death");
  wait 1;

  if(isDefined(var_0._id_5FE7)) {
    var_0._id_5FE7 = undefined;
  }

  var_0 notify("defrosted");
  var_0 thread _id_19F5(var_0);
}

_id_5F60(var_0) {
  var_0 endon("death");
  var_0._id_8873 = 1;
  var_0._id_0229 = 1;
  var_0._id_A546 = 1;
  var_0._id_5FF5 = 1;
  var_0._id_A6C1 = 1;

  if(isDefined(var_0._id_5F65) && issubstr(var_0._id_5F65, "window")) {
    var_0 setscriptablepartstate("frozen", "frozen_traverse");
  } else if(istrue(var_0._id_4B40)) {
    var_0 setscriptablepartstate("frozen", "frozen_crawl");
  } else {
    var_0 setscriptablepartstate("frozen", "frozen");
  }

  wait 10.1;
  var_0._id_8873 = undefined;
}

_id_F943(var_0) {
  var_0 endon("death");
  var_0 setscriptablepartstate("frozen", "unfrozen");

  if(!isalive(var_0)) {
    return;
  }
  var_0 playSound("forge_freeze_shatter");
  var_0._id_0229 = 0;
  var_0._id_A546 = undefined;
  var_0._id_5FF5 = undefined;
  var_0._id_A6C1 = undefined;
}

_id_4A1F(var_0, var_1) {
  switch (var_1) {
    case "frozen":
      var_0 setscriptablepartstate("cold", "inactive", 1);
      var_0 setscriptablepartstate("burning", "inactive", 1);
      var_0 setscriptablepartstate("shocked", "inactive", 1);
      var_0 setscriptablepartstate("chemburn", "inactive", 1);
      var_0 setscriptablepartstate("arcane_white", "inactive", 1);
      var_0 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "cold":
      var_0 setscriptablepartstate("burning", "inactive", 1);
      var_0 setscriptablepartstate("shocked", "inactive", 1);
      var_0 setscriptablepartstate("chemburn", "inactive", 1);
      var_0 setscriptablepartstate("arcane_white", "inactive", 1);
      var_0 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "arcane_white":
      var_0 setscriptablepartstate("cold", "inactive", 1);
      var_0 setscriptablepartstate("burning", "inactive", 1);
      var_0 setscriptablepartstate("shocked", "inactive", 1);
      var_0 setscriptablepartstate("chemburn", "inactive", 1);
      var_0 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "chemburn":
      var_0 setscriptablepartstate("cold", "inactive", 1);
      var_0 setscriptablepartstate("burning", "inactive", 1);
      var_0 setscriptablepartstate("shocked", "inactive", 1);
      var_0 setscriptablepartstate("arcane_white", "inactive", 1);
      var_0 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "burning":
      var_0 setscriptablepartstate("cold", "inactive", 1);
      var_0 setscriptablepartstate("shocked", "inactive", 1);
      var_0 setscriptablepartstate("chemburn", "inactive", 1);
      var_0 setscriptablepartstate("arcane_white", "inactive", 1);
      var_0 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "shocked":
    case "electrified":
      var_0 setscriptablepartstate("cold", "inactive", 1);
      var_0 setscriptablepartstate("burning", "inactive", 1);
      var_0 setscriptablepartstate("chemburn", "inactive", 1);
      var_0 setscriptablepartstate("arcane_white", "inactive", 1);
      var_0 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    default:
      break;
  }
}

_id_F7FC(var_0, var_1) {
  if(isDefined(var_0._id_1210) && var_0._id_1210 == "c6") {
    return;
  }
  if(!_id_DAE9(var_0)) {
    return;
  }
  if(isalive(var_0)) {
    var_0 setscriptablepartstate("burning", "inactive", 1);
    var_0 setscriptablepartstate("shocked", "inactive", 1);
    var_0 setscriptablepartstate("chemburn", "inactive", 1);
    var_0 setscriptablepartstate("arcane_white", "inactive", 1);
    var_0 setscriptablepartstate("cold", "inactive", 1);
  }

  if(istrue(var_1)) {
    var_0._id_8873 = undefined;
  }
}

_id_F7FA(var_0) {
  if(isDefined(var_0._id_1210) && (var_0._id_1210 == "soldier_agent" || var_0._id_1210 == "c6" || var_0._id_1210 == "zombie_brute" || var_0._id_1210 == "zombie_grey" || var_0._id_1210 == "zombie_ghost")) {
    return;
  }
  if(!_id_DAE9(var_0)) {
    return;
  }
  var_0 setscriptablepartstate("burning", "inactive", 1);
  var_0 setscriptablepartstate("pet", "inactive", 1);
  var_0 setscriptablepartstate("shocked", "inactive", 1);
  var_0 setscriptablepartstate("corrosive", "inactive", 1);
  var_0 setscriptablepartstate("chemburn", "inactive", 1);
  var_0 setscriptablepartstate("arcane_white", "inactive", 1);
  var_0 setscriptablepartstate("cold", "inactive", 1);

  if(isDefined(var_0._id_74D9)) {
    var_0 setscriptablepartstate("backpack", "hide", 1);
  }

  var_0 _meth_80C6(2, 0);
}

_id_DAE9(var_0) {
  if(!isDefined(var_0._id_E3D8)) {
    return 0;
  }

  if(isDefined(level._id_F0EE) && var_0 == level._id_F0EE) {
    return 0;
  }

  if(isDefined(var_0._id_5120)) {
    return 0;
  }

  if(isDefined(var_0._id_A531)) {
    return 0;
  }

  switch (var_0._id_E3D8) {
    case "zombie_grey":
    case "zombie_brute":
      return 0;
    default:
      return 1;
  }
}