/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1928.gsc
*************************************************/

#using_animtree("script_model");

_id_182C(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5._id_019B = var_0;
  var_5._id_18AF = var_1;
  var_5._id_8419 = 0;
  var_5._id_841D = 0;
  var_5._id_5345 = 0;
  var_5._id_5EA1 = 0;

  if(isDefined(var_2) && var_2) {
    var_5._id_8665 = var_2;

    if(isDefined(var_3)) {
      var_5._id_B5AA = var_3;
    } else {
      var_5._id_B5AA = 1;
    }

    if(isDefined(var_4)) {
      var_5._id_4A72 = var_4;
    } else {
      var_5._id_4A72 = 1;
    }
  } else {
    var_5._id_8665 = 0;
    var_5._id_019B._id_18AF = var_5._id_18AF;
    var_5._id_019B useanimtree(#animtree);
  }

  return var_5;
}

_id_182E(var_0, var_1, var_2) {
  self._id_8419 = var_0;

  if(isDefined(var_1)) {
    self._id_8413 = var_1;

    if(isDefined(var_2)) {
      self._id_8415 = var_2;
    } else {
      self._id_8415 = 0;
    }
  }
}

_id_182B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  foreach(var_9 in var_0) {
    var_9._id_841D = 0;
    var_9._id_5345 = 0;
  }

  var_11 = _id_0B30(var_0, var_1, 0, var_4, var_2, var_3, var_5, var_6, var_7);

  if(isDefined(var_11) && var_11) {
    return 1;
  } else {
    return 0;
  }
}

_id_182D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  foreach(var_9 in var_0) {
    var_9._id_841D = 0;
    var_9._id_5345 = 0;
  }

  _id_0B30(var_0, var_1, 1, var_4, var_2, var_3, var_5, var_6, var_7);
  var_11 = 1;

  foreach(var_9 in var_0) {
    if(!var_9._id_5345) {
      var_11 = 0;
      break;
    }
  }

  return var_11;
}

_id_1830(var_0) {
  if(isDefined(var_0) && var_0) {
    self notify("anim_scene_force_end");
  } else {
    self notify("stop_scene");
  }
}

_id_1831(var_0) {
  var_0._id_5345 = 1;
}

_id_0B30(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("anim_scene_interrupted");

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  thread _id_0B2E(var_0);
  thread _id_0B2F(var_0);
  var_12 = 0.0;
  thread _id_0B36(var_0, var_3, var_5);

  if(var_4) {
    if(!isDefined(var_6)) {
      var_6 = 0.4;
    }

    if(!isDefined(var_7)) {
      var_7 = 0.8;
    }

    _id_0B31(var_0, var_1, var_3, var_6, var_8);
    _id_0B33(var_0, var_6, var_7);
  }

  _id_0B35(var_0, var_1, var_2, var_3);

  if(!var_2) {
    foreach(var_10 in var_0) {
      var_10._id_18A2 = _id_0B34(var_10, var_1);

      if(var_10._id_18A2 > var_12) {
        var_12 = var_10._id_18A2;
      }
    }

    foreach(var_10 in var_0) {
      if(var_10._id_18A2 < var_12) {
        thread _id_0B2D(var_10);
      }
    }
  }

  if(var_2) {
    self waittill("never");
  } else {
    wait(var_12);
  }

  waittillframeend;
  self notify("anim_scene_success");

  if(var_5) {
    _id_0B32(var_0);
  }

  return 1;
}

_id_0B31(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_6 in var_0) {
    if(var_6._id_8665) {
      if(istrue(var_4)) {
        var_7 = "viewhands_base_iw8";
        var_6._id_B5A4 = spawn("script_model", var_6._id_019B.origin);
        var_6._id_B5A4 setModel(var_7);
        var_6._id_B5A4._id_18AF = var_6._id_18AF;
        var_6._id_B5A4 useanimtree(#animtree);
        var_6._id_B5A4 hide();
      } else {
        var_6._id_B5A4 = spawn("script_arms", var_6._id_019B.origin, 0, 0, var_6._id_019B);
        var_6._id_B5A4._id_18AF = var_6._id_18AF;
        var_6._id_B5A4 useanimtree(#animtree);
        var_6._id_B5A4 hide();
        var_6._id_B5A4._id_019B = var_6._id_019B;
      }

      _id_06C6::_id_17C2(var_6._id_B5A4, var_1, var_2);
      var_6._id_019B setstance(_id_62FA(var_6));
      var_6._id_019B playerlinktoblend(var_6._id_B5A4, "tag_player", var_3);

      if(var_6._id_4A72) {
        var_6._id_019B scripts\common\utility::_id_158D(0);
      }
    }
  }
}

_id_62FA(var_0) {
  if(isDefined(var_0._id_019B._id_182F)) {
    return var_0._id_019B._id_182F;
  }

  return "stand";
}

_id_0B33(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;

  if(var_3 > 0.0) {
    wait(var_1);

    foreach(var_5 in var_0) {
      if(var_5._id_841D) {
        continue;
      }
      if(var_5._id_8665) {
        var_5._id_019B playerlinktodelta(var_5._id_B5A4, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1);
      }
    }

    wait(var_3);

    foreach(var_5 in var_0) {
      if(var_5._id_841D) {
        continue;
      }
      if(var_5._id_8665) {}
    }
  } else {
    wait(var_1);

    foreach(var_5 in var_0) {
      if(var_5._id_841D) {
        continue;
      }
      if(var_5._id_8665) {
        var_5._id_019B playerlinktodelta(var_5._id_B5A4, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1);
      }
    }
  }
}

_id_0B34(var_0, var_1) {
  var_2 = 0.0;

  if(var_0._id_8665) {
    var_3 = _func_0079(level._id_CC31[var_0._id_B5A4._id_18AF][var_1]);

    if(var_3 > var_2) {
      var_2 = var_3;
    }
  } else {
    var_3 = _func_0079(level._id_CC31[var_0._id_18AF][var_1]);

    if(var_3 > var_2) {
      var_2 = var_3;
    }
  }

  return var_2;
}

_id_0B35(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    if(var_5._id_841D) {
      continue;
    }
    if(var_5._id_8665) {
      if(var_2) {
        var_5._id_019B _meth_84FF("scripted_scene", level._id_CC3B[var_5._id_18AF][var_1][0]);
      } else {
        var_5._id_019B _meth_84FF("scripted_scene", level._id_CC3B[var_5._id_18AF][var_1]);
      }

      if(isDefined(level._id_CC49[var_5._id_18AF]) && isDefined(level._id_CC49[var_5._id_18AF][var_1]) && !istrue(var_5._id_019B._id_25A7)) {
        if(var_2) {
          var_5._id_019B _meth_861F(level._id_CC49[var_5._id_18AF][var_1][0]);
        } else {
          var_5._id_019B _meth_861F(level._id_CC49[var_5._id_18AF][var_1]);
        }
      }

      if(var_5._id_B5AA) {
        var_5._id_B5A4 _meth_83CA(var_5._id_019B);
      }

      if(var_2) {
        thread _id_06C6::_id_17F3(var_5._id_B5A4, var_1, "stop_scene", var_3);
      } else {
        thread _id_06C6::_id_1845(var_5._id_B5A4, var_1, var_3);
      }

      continue;
    }

    if(var_2) {
      thread _id_06C6::_id_17F3(var_5._id_019B, var_1, "stop_scene", var_3);
      continue;
    }

    thread _id_06C6::_id_1845(var_5._id_019B, var_1, var_3);
  }
}

_id_0B32(var_0) {
  foreach(var_2 in var_0) {
    if(var_2._id_841D) {
      continue;
    }
    if(var_2._id_8665) {
      if(var_2._id_4A72) {
        var_2._id_019B scripts\common\utility::_id_158D(1);
      }

      var_2._id_019B unlink();
      var_2._id_019B setorigin(var_2._id_019B.origin + (0, 0, 1));
      var_2._id_B5A4 delete();
      var_2._id_B5A4 = undefined;
    }
  }
}

_id_0B2E(var_0) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");
  self waittill("stop_scene");

  foreach(var_2 in var_0) {
    var_2._id_5345 = 1;
  }
}

_id_0B2F(var_0) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");
  self waittill("anim_scene_force_end");

  foreach(var_2 in var_0) {
    var_2._id_5EA1 = 1;
  }
}

_id_0B2D(var_0) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");
  wait(var_0._id_18A2);

  if(!var_0._id_841D) {
    var_0._id_5345 = 1;
  }
}

_id_0B36(var_0, var_1, var_2) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");

  for(;;) {
    var_3 = 0;

    for(;;) {
      wait 0.05;

      foreach(var_5 in var_0) {
        if(var_5._id_5345 || var_5._id_5EA1 || !isDefined(var_5._id_019B) || var_5._id_8665 && !isalive(var_5._id_019B) || var_5._id_8665 && isDefined(var_5._id_019B._id_59E0)) {
          if(!var_5._id_841D) {
            var_3 = 1;
            break;
          }
        }
      }

      if(var_3) {
        break;
      }
    }

    var_7 = 1;

    foreach(var_5 in var_0) {
      var_9 = 0;

      if(!isDefined(var_5._id_019B) || var_5._id_8665 && !isalive(var_5._id_019B) || var_5._id_8665 && isDefined(var_5._id_019B._id_59E0)) {
        var_9 = 1;
      }

      if(!var_9 && !var_5._id_5345 && !var_5._id_5EA1 && !var_5._id_8419) {
        var_7 = 0;
        continue;
      }

      var_5._id_841D = 1;

      if(var_9 && !var_5._id_8665) {
        continue;
      }
      if(var_5._id_8665) {
        if((var_2 || var_5._id_5EA1) && !var_9) {
          if(var_5._id_4A72) {
            if(!var_5._id_019B scripts\common\input_allow::_id_860C("weapon")) {
              var_5._id_019B scripts\common\utility::_id_158D(1);
            }
          }

          var_5._id_019B _meth_8655();
          var_5._id_019B unlink();
          var_5._id_019B setorigin(var_5._id_019B.origin + (0, 0, 1));
        }

        if(var_2 || var_5._id_5EA1 || var_9) {
          if(isent(var_5._id_B5A4)) {
            var_5._id_B5A4 delete();
            var_5._id_B5A4 = undefined;
          }
        }

        continue;
      }

      if(isDefined(var_5._id_8413)) {
        if(var_5._id_8415) {
          thread _id_06C6::_id_17C2(var_5._id_019B, var_5._id_8413, var_1);
        } else {
          var_5._id_019B _meth_83EC();
          thread _id_06C6::_id_1845(var_5._id_019B, var_5._id_8413, var_1);
        }

        continue;
      }

      var_5._id_019B _meth_83EC();
    }

    if(var_7) {
      self notify("anim_scene_interrupted");
      return;
    }
  }
}