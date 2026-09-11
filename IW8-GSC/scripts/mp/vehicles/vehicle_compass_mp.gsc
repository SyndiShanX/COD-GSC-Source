/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_compass_mp.gsc
******************************************************/

function ref_12b16(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(!isDefined(level.hover_radius)) {
    level.hover_radius = [];
  }

  if(!isDefined(level.hover_speed)) {
    level.hover_speed = [];
  }

  if(istrue(var7)) {
    if(!isbuiltinmethod(var1) && !isanimation(var1)) {
      return;
    }
  } else if(!isbuiltinfunction(var1)) {
    return;
  }

  level.hover_radius[var0] = spawnStruct();
  level.hover_radius[var0].offerloc = var1;
  level.hover_radius[var0].comparescore = var4;
  level.hover_radius[var0].commandwatcher = var5;
  level.hover_radius[var0].comms_crates = var7;
  level.hover_radius[var0].convoy_pos = var8;
  level.hover_radius[var0].timeout = var2;
  level.hover_radius[var0].obj_room_fire_04 = var3;
}

function ref_12e0b(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(!isDefined(level.hover_radius[var0])) {
    return;
  }

  var9 = level.hover_radius[var0].offerloc;
  var10 = &obj_room_fire_02;
  var11 = 1;

  if(isDefined(var8)) {
    var11 = [[var10]](var0, var1, var2, var3, var4, var5, var6, var7, var8);
  } else if(isDefined(var7)) {
    var11 = [[var10]](var0, var1, var2, var3, var4, var5, var6, var7);
  } else if(isDefined(var6)) {
    var11 = [[var10]](var0, var1, var2, var3, var4, var5, var6);
  } else if(isDefined(var5)) {
    var11 = [[var10]](var0, var1, var2, var3, var4, var5);
  } else if(isDefined(var4)) {
    var11 = [[var10]](var0, var1, var2, var3, var4);
  } else if(isDefined(var3)) {
    var11 = [[var10]](var0, var1, var2, var3);
  } else if(isDefined(var2)) {
    var11 = [[var10]](var0, var1, var2);
  } else if(isDefined(var1)) {
    var11 = [[var10]](var0, var1);
  } else {
    var11 = [[var10]](var0);
  }

  if(var11) {
    thread ref_11aa9(var0);

    if(istrue(level.hover_radius[var0].comms_crates)) {
      if(istrue(level.hover_radius[var0].convoy_pos)) {
        if(isDefined(var8)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            builtin[[var9]](var1, var2, var3, var4, var5, var6, var7, var8);
            return;
          }

          [[var9]](var1, var2, var3, var4, var5, var6, var7, var8);
          return;
        }

        if(isDefined(var7)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            builtin[[var9]](var1, var2, var3, var4, var5, var6, var7);
            return;
          }

          [[var9]](var1, var2, var3, var4, var5, var6, var7);
          return;
        }

        if(isDefined(var6)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            builtin[[var9]](var1, var2, var3, var4, var5, var6);
            return;
          }

          [[var9]](var1, var2, var3, var4, var5, var6);
          return;
        }

        if(isDefined(var5)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            builtin[[var9]](var1, var2, var3, var4, var5);
            return;
          }

          [[var9]](var1, var2, var3, var4, var5);
          return;
        }

        if(isDefined(var4)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            builtin[[var9]](var1, var2, var3, var4);
            return;
          }

          [[var9]](var1, var2, var3, var4);
          return;
        }

        if(isDefined(var3)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            builtin[[var9]](var1, var2, var3);
            return;
          }

          [[var9]](var1, var2, var3);
          return;
        }

        if(isDefined(var2)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            builtin[[var9]](var1, var2);
            return;
          }

          [[var9]](var1, var2);
          return;
        }

        if(isDefined(var1)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            builtin[[var9]](var1);
            return;
          }

          [[var9]](var1);
          return;
        }

        if(isbuiltinmethod(var9) || isanimation(var9)) {
          builtin[[var9]]();
          return;
        }

        [[var9]]();
        return;
      } else {
        if(isDefined(var8)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            self builtin[[var9]](var1, var2, var3, var4, var5, var6, var7, var8);
            return;
          }

          self[[var9]](var1, var2, var3, var4, var5, var6, var7, var8);
          return;
        }

        if(isDefined(var7)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            self builtin[[var9]](var1, var2, var3, var4, var5, var6, var7);
            return;
          }

          self[[var9]](var1, var2, var3, var4, var5, var6, var7);
          return;
        }

        if(isDefined(var6)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            self builtin[[var9]](var1, var2, var3, var4, var5, var6);
            return;
          }

          self[[var9]](var1, var2, var3, var4, var5, var6);
          return;
        }

        if(isDefined(var5)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            self builtin[[var9]](var1, var2, var3, var4, var5);
            return;
          }

          self[[var9]](var1, var2, var3, var4, var5);
          return;
        }

        if(isDefined(var4)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            self builtin[[var9]](var1, var2, var3, var4);
            return;
          }

          self[[var9]](var1, var2, var3, var4);
          return;
        }

        if(isDefined(var3)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            self builtin[[var9]](var1, var2, var3);
            return;
          }

          self[[var9]](var1, var2, var3);
          return;
        }

        if(isDefined(var2)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            self builtin[[var9]](var1, var2);
            return;
          }

          self[[var9]](var1, var2);
          return;
        }

        if(isDefined(var1)) {
          if(isbuiltinmethod(var9) || isanimation(var9)) {
            self builtin[[var9]](var1);
            return;
          }

          self[[var9]](var1);
          return;
        }

        if(isbuiltinmethod(var9) || isanimation(var9)) {
          self builtin[[var9]]();
          return;
        }

        self[[var9]]();
        return;
      }
    }

    if(istrue(level.hover_radius[var0].comparescore)) {
      if(isDefined(var8)) {
        self thread[[var9]](var1, var2, var3, var4, var5, var6, var7, var8);
        return;
      }

      if(isDefined(var7)) {
        self thread[[var9]](var1, var2, var3, var4, var5, var6, var7);
        return;
      }

      if(isDefined(var6)) {
        self thread[[var9]](var1, var2, var3, var4, var5, var6);
        return;
      }

      if(isDefined(var5)) {
        self thread[[var9]](var1, var2, var3, var4, var5);
        return;
      }

      if(isDefined(var4)) {
        self thread[[var9]](var1, var2, var3, var4);
        return;
      }

      if(isDefined(var3)) {
        self thread[[var9]](var1, var2, var3);
        return;
      }

      if(isDefined(var2)) {
        self thread[[var9]](var1, var2);
        return;
      }

      if(isDefined(var1)) {
        self thread[[var9]](var1);
        return;
      }

      self thread[[var9]]();
      return;
    }

    if(istrue(level.hover_radius[var0].commandwatcher)) {
      if(isDefined(var8)) {
        self childthread[[var9]](var1, var2, var3, var4, var5, var6, var7, var8);
        return;
      }

      if(isDefined(var7)) {
        self childthread[[var9]](var1, var2, var3, var4, var5, var6, var7);
        return;
      }

      if(isDefined(var6)) {
        self childthread[[var9]](var1, var2, var3, var4, var5, var6);
        return;
      }

      if(isDefined(var5)) {
        self childthread[[var9]](var1, var2, var3, var4, var5);
        return;
      }

      if(isDefined(var4)) {
        self childthread[[var9]](var1, var2, var3, var4);
        return;
      }

      if(isDefined(var3)) {
        self childthread[[var9]](var1, var2, var3);
        return;
      }

      if(isDefined(var2)) {
        self childthread[[var9]](var1, var2);
        return;
      }

      if(isDefined(var1)) {
        self childthread[[var9]](var1);
        return;
      }

      self childthread[[var9]]();
      return;
    }

    if(isDefined(var8)) {
      self[[var9]](var1, var2, var3, var4, var5, var6, var7, var8);
      return;
    }

    if(isDefined(var7)) {
      self[[var9]](var1, var2, var3, var4, var5, var6, var7);
      return;
    }

    if(isDefined(var6)) {
      self[[var9]](var1, var2, var3, var4, var5, var6);
      return;
    }

    if(isDefined(var5)) {
      self[[var9]](var1, var2, var3, var4, var5);
      return;
    }

    if(isDefined(var4)) {
      self[[var9]](var1, var2, var3, var4);
      return;
    }

    if(isDefined(var3)) {
      self[[var9]](var1, var2, var3);
      return;
    }

    if(isDefined(var2)) {
      self[[var9]](var1, var2);
      return;
    }

    if(isDefined(var1)) {
      self[[var9]](var1);
      return;
    }

    self[[var9]]();
    return;
  }
}

function obj_room_fire_02(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(scripts\engine\utility::array_contains(level.hover_speed, var0)) {
    return 0;
  }

  if(isDefined(level.hover_radius[var0].obj_room_fire_04)) {
    if(isDefined(var8)) {
      return [[level.hover_radius[var0].obj_room_fire_04]](var1, var2, var3, var4, var5, var6, var7, var8);
    }

    if(isDefined(var7)) {
      return [[level.hover_radius[var0].obj_room_fire_04]](var1, var2, var3, var4, var5, var6, var7);
    }

    if(isDefined(var6)) {
      return [[level.hover_radius[var0].obj_room_fire_04]](var1, var2, var3, var4, var5, var6);
    }

    if(isDefined(var5)) {
      return [[level.hover_radius[var0].obj_room_fire_04]](var1, var2, var3, var4, var5);
    }

    if(isDefined(var4)) {
      return [[level.hover_radius[var0].obj_room_fire_04]](var1, var2, var3, var4);
    }

    if(isDefined(var3)) {
      return [[level.hover_radius[var0].obj_room_fire_04]](var1, var2, var3);
    }

    if(isDefined(var2)) {
      return [[level.hover_radius[var0].obj_room_fire_04]](var1, var2);
    }

    if(isDefined(var1)) {
      return [[level.hover_radius[var0].obj_room_fire_04]](var1);
    }

    return [[level.hover_radius[var0].obj_room_fire_04]]();
  }

  return 1;
}

function ref_11aa9(var0) {
  level endon("game_ended");
  var1 = 0.05;
  level.hover_speed = scripts\engine\utility::array_add_safe(level.hover_speed, var0);

  if(isDefined(level.hover_radius[var0].timeout)) {
    var1 = level.hover_radius[var0].timeout;
  }

  wait var1;
  level.hover_speed = scripts\engine\utility::array_remove(level.hover_speed, var0);
}