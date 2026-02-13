/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2390.gsc
*************************************************/

_id_C24B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level._id_3C65)) {
    level._id_3C65 = [];
  }

  if(!isDefined(level._id_3C66)) {
    level._id_3C66 = [];
  }

  if(istrue(var_7)) {
    if(!_func_03AD(var_1) && !_func_03AE(var_1)) {
      return;
    }
  } else if(!_func_03AC(var_1)) {
    return;
  }
  level._id_3C65[var_0] = spawnStruct();
  level._id_3C65[var_0]._id_56B3 = var_1;
  level._id_3C65[var_0]._id_252A = var_4;
  level._id_3C65[var_0]._id_2526 = var_5;
  level._id_3C65[var_0]._id_2527 = var_7;
  level._id_3C65[var_0]._id_25C0 = var_8;
  level._id_3C65[var_0]._id_F224 = var_2;
  level._id_3C65[var_0]._id_567D = var_3;
}

_id_CA2A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level._id_3C65[var_0])) {
    return;
  }
  var_9 = level._id_3C65[var_0]._id_56B3;
  var_10 = ::_id_566D;
  var_11 = 1;

  if(isDefined(var_8)) {
    var_11 = [[var_10]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(isDefined(var_7)) {
    var_11 = [[var_10]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    var_11 = [[var_10]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    var_11 = [[var_10]](var_0, var_1, var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    var_11 = [[var_10]](var_0, var_1, var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    var_11 = [[var_10]](var_0, var_1, var_2, var_3);
  } else if(isDefined(var_2)) {
    var_11 = [[var_10]](var_0, var_1, var_2);
  } else if(isDefined(var_1)) {
    var_11 = [[var_10]](var_0, var_1);
  } else {
    var_11 = [[var_10]](var_0);
  }

  if(var_11) {
    thread _id_9A17(var_0);

    if(istrue(level._id_3C65[var_0]._id_2527)) {
      if(istrue(level._id_3C65[var_0]._id_25C0)) {
        if(isDefined(var_8)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            call[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
          } else {
            [[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
          }

          return;
        }

        if(isDefined(var_7)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            call[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
          } else {
            [[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
          }

          return;
        }

        if(isDefined(var_6)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            call[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6);
          } else {
            [[var_9]](var_1, var_2, var_3, var_4, var_5, var_6);
          }

          return;
        }

        if(isDefined(var_5)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            call[[var_9]](var_1, var_2, var_3, var_4, var_5);
          } else {
            [[var_9]](var_1, var_2, var_3, var_4, var_5);
          }

          return;
        }

        if(isDefined(var_4)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            call[[var_9]](var_1, var_2, var_3, var_4);
          } else {
            [[var_9]](var_1, var_2, var_3, var_4);
          }

          return;
        }

        if(isDefined(var_3)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            call[[var_9]](var_1, var_2, var_3);
          } else {
            [[var_9]](var_1, var_2, var_3);
          }

          return;
        }

        if(isDefined(var_2)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            call[[var_9]](var_1, var_2);
          } else {
            [[var_9]](var_1, var_2);
          }

          return;
        }

        if(isDefined(var_1)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            call[[var_9]](var_1);
          } else {
            [[var_9]](var_1);
          }

          return;
        }

        if(_func_03AD(var_9) || _func_03AE(var_9)) {
          call[[var_9]]();
        } else {
          [[var_9]]();
        }

        return;
      } else {
        if(isDefined(var_8)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            self call[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
          } else {
            self[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
          }

          return;
        }

        if(isDefined(var_7)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            self call[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
          } else {
            self[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
          }

          return;
        }

        if(isDefined(var_6)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            self call[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6);
          } else {
            self[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6);
          }

          return;
        }

        if(isDefined(var_5)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            self call[[var_9]](var_1, var_2, var_3, var_4, var_5);
          } else {
            self[[var_9]](var_1, var_2, var_3, var_4, var_5);
          }

          return;
        }

        if(isDefined(var_4)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            self call[[var_9]](var_1, var_2, var_3, var_4);
          } else {
            self[[var_9]](var_1, var_2, var_3, var_4);
          }

          return;
        }

        if(isDefined(var_3)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            self call[[var_9]](var_1, var_2, var_3);
          } else {
            self[[var_9]](var_1, var_2, var_3);
          }

          return;
        }

        if(isDefined(var_2)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            self call[[var_9]](var_1, var_2);
          } else {
            self[[var_9]](var_1, var_2);
          }

          return;
        }

        if(isDefined(var_1)) {
          if(_func_03AD(var_9) || _func_03AE(var_9)) {
            self call[[var_9]](var_1);
          } else {
            self[[var_9]](var_1);
          }

          return;
        }

        if(_func_03AD(var_9) || _func_03AE(var_9)) {
          self call[[var_9]]();
        } else {
          self[[var_9]]();
        }

        return;
      }
    }

    if(istrue(level._id_3C65[var_0]._id_252A)) {
      if(isDefined(var_8)) {
        self thread[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
        return;
      }

      if(isDefined(var_7)) {
        self thread[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
        return;
      }

      if(isDefined(var_6)) {
        self thread[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6);
        return;
      }

      if(isDefined(var_5)) {
        self thread[[var_9]](var_1, var_2, var_3, var_4, var_5);
        return;
      }

      if(isDefined(var_4)) {
        self thread[[var_9]](var_1, var_2, var_3, var_4);
        return;
      }

      if(isDefined(var_3)) {
        self thread[[var_9]](var_1, var_2, var_3);
        return;
      }

      if(isDefined(var_2)) {
        self thread[[var_9]](var_1, var_2);
        return;
      }

      if(isDefined(var_1)) {
        self thread[[var_9]](var_1);
        return;
      }

      self thread[[var_9]]();
      return;
    }

    if(istrue(level._id_3C65[var_0]._id_2526)) {
      if(isDefined(var_8)) {
        self childthread[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
        return;
      }

      if(isDefined(var_7)) {
        self childthread[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
        return;
      }

      if(isDefined(var_6)) {
        self childthread[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6);
        return;
      }

      if(isDefined(var_5)) {
        self childthread[[var_9]](var_1, var_2, var_3, var_4, var_5);
        return;
      }

      if(isDefined(var_4)) {
        self childthread[[var_9]](var_1, var_2, var_3, var_4);
        return;
      }

      if(isDefined(var_3)) {
        self childthread[[var_9]](var_1, var_2, var_3);
        return;
      }

      if(isDefined(var_2)) {
        self childthread[[var_9]](var_1, var_2);
        return;
      }

      if(isDefined(var_1)) {
        self childthread[[var_9]](var_1);
        return;
      }

      self childthread[[var_9]]();
      return;
    }

    if(isDefined(var_8)) {
      self[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      return;
    }

    if(isDefined(var_7)) {
      self[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
      return;
    }

    if(isDefined(var_6)) {
      self[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6);
      return;
    }

    if(isDefined(var_5)) {
      self[[var_9]](var_1, var_2, var_3, var_4, var_5);
      return;
    }

    if(isDefined(var_4)) {
      self[[var_9]](var_1, var_2, var_3, var_4);
      return;
    }

    if(isDefined(var_3)) {
      self[[var_9]](var_1, var_2, var_3);
      return;
    }

    if(isDefined(var_2)) {
      self[[var_9]](var_1, var_2);
      return;
    }

    if(isDefined(var_1)) {
      self[[var_9]](var_1);
      return;
    }

    self[[var_9]]();
  } else {}
}

_id_566D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(scripts\engine\utility::array_contains(level._id_3C66, var_0)) {
    return 0;
  }

  if(isDefined(level._id_3C65[var_0]._id_567D)) {
    if(isDefined(var_8)) {
      return [[level._id_3C65[var_0]._id_567D]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }

    if(isDefined(var_7)) {
      return [[level._id_3C65[var_0]._id_567D]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    }

    if(isDefined(var_6)) {
      return [[level._id_3C65[var_0]._id_567D]](var_1, var_2, var_3, var_4, var_5, var_6);
    }

    if(isDefined(var_5)) {
      return [[level._id_3C65[var_0]._id_567D]](var_1, var_2, var_3, var_4, var_5);
    }

    if(isDefined(var_4)) {
      return [[level._id_3C65[var_0]._id_567D]](var_1, var_2, var_3, var_4);
    }

    if(isDefined(var_3)) {
      return [[level._id_3C65[var_0]._id_567D]](var_1, var_2, var_3);
    }

    if(isDefined(var_2)) {
      return [[level._id_3C65[var_0]._id_567D]](var_1, var_2);
    }

    if(isDefined(var_1)) {
      return [[level._id_3C65[var_0]._id_567D]](var_1);
    }

    return [[level._id_3C65[var_0]._id_567D]]();
  }

  return 1;
}

_id_9A17(var_0) {
  level endon("game_ended");
  var_1 = 0.05;
  level._id_3C66 = scripts\engine\utility::_id_1B8D(level._id_3C66, var_0);

  if(isDefined(level._id_3C65[var_0]._id_F224)) {
    var_1 = level._id_3C65[var_0]._id_F224;
  }

  wait(var_1);
  level._id_3C66 = scripts\engine\utility::array_remove(level._id_3C66, var_0);
}