/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\vehicle_compass_mp.gsc
***********************************************/

_id_12B16(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.hover_radius))
    level.hover_radius = [];

  if(!isDefined(level.hover_speed))
    level.hover_speed = [];

  if(istrue(var_7)) {
    if(!isbuiltinmethod(var_1) && !isanimation(var_1))
      return;
  } else if(!isbuiltinfunction(var_1)) {
    return;
  }
  level.hover_radius[var_0] = spawnStruct();
  level.hover_radius[var_0].offerloc = var_1;
  level.hover_radius[var_0].comparescore = var_4;
  level.hover_radius[var_0].commandwatcher = var_5;
  level.hover_radius[var_0].comms_crates = var_7;
  level.hover_radius[var_0].convoy_pos = var_8;
  level.hover_radius[var_0].timeout = var_2;
  level.hover_radius[var_0].obj_room_fire_04 = var_3;
}

_id_12E0B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.hover_radius[var_0])) {
    return;
  }
  var_9 = level.hover_radius[var_0].offerloc;
  var_10 = ::obj_room_fire_02;
  var_11 = 1;

  if(isDefined(var_8))
    var_11 = [[var_10]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isDefined(var_7))
    var_11 = [[var_10]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  else if(isDefined(var_6))
    var_11 = [[var_10]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  else if(isDefined(var_5))
    var_11 = [[var_10]](var_0, var_1, var_2, var_3, var_4, var_5);
  else if(isDefined(var_4))
    var_11 = [[var_10]](var_0, var_1, var_2, var_3, var_4);
  else if(isDefined(var_3))
    var_11 = [[var_10]](var_0, var_1, var_2, var_3);
  else if(isDefined(var_2))
    var_11 = [[var_10]](var_0, var_1, var_2);
  else if(isDefined(var_1))
    var_11 = [[var_10]](var_0, var_1);
  else
    var_11 = [[var_10]](var_0);

  if(var_11) {
    thread _id_11AA9(var_0);

    if(istrue(level.hover_radius[var_0].comms_crates)) {
      if(istrue(level.hover_radius[var_0].convoy_pos)) {
        if(isDefined(var_8)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            call[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
          else
            [[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

          return;
        }

        if(isDefined(var_7)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            call[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
          else
            [[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);

          return;
        }

        if(isDefined(var_6)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            call[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6);
          else
            [[var_9]](var_1, var_2, var_3, var_4, var_5, var_6);

          return;
        }

        if(isDefined(var_5)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            call[[var_9]](var_1, var_2, var_3, var_4, var_5);
          else
            [[var_9]](var_1, var_2, var_3, var_4, var_5);

          return;
        }

        if(isDefined(var_4)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            call[[var_9]](var_1, var_2, var_3, var_4);
          else
            [[var_9]](var_1, var_2, var_3, var_4);

          return;
        }

        if(isDefined(var_3)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            call[[var_9]](var_1, var_2, var_3);
          else
            [[var_9]](var_1, var_2, var_3);

          return;
        }

        if(isDefined(var_2)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            call[[var_9]](var_1, var_2);
          else
            [[var_9]](var_1, var_2);

          return;
        }

        if(isDefined(var_1)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            call[[var_9]](var_1);
          else
            [[var_9]](var_1);

          return;
        }

        if(isbuiltinmethod(var_9) || isanimation(var_9))
          call[[var_9]]();
        else
          [[var_9]]();

        return;
      } else {
        if(isDefined(var_8)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            self call[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
          else
            self[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

          return;
        }

        if(isDefined(var_7)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            self call[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
          else
            self[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);

          return;
        }

        if(isDefined(var_6)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            self call[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6);
          else
            self[[var_9]](var_1, var_2, var_3, var_4, var_5, var_6);

          return;
        }

        if(isDefined(var_5)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            self call[[var_9]](var_1, var_2, var_3, var_4, var_5);
          else
            self[[var_9]](var_1, var_2, var_3, var_4, var_5);

          return;
        }

        if(isDefined(var_4)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            self call[[var_9]](var_1, var_2, var_3, var_4);
          else
            self[[var_9]](var_1, var_2, var_3, var_4);

          return;
        }

        if(isDefined(var_3)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            self call[[var_9]](var_1, var_2, var_3);
          else
            self[[var_9]](var_1, var_2, var_3);

          return;
        }

        if(isDefined(var_2)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            self call[[var_9]](var_1, var_2);
          else
            self[[var_9]](var_1, var_2);

          return;
        }

        if(isDefined(var_1)) {
          if(isbuiltinmethod(var_9) || isanimation(var_9))
            self call[[var_9]](var_1);
          else
            self[[var_9]](var_1);

          return;
        }

        if(isbuiltinmethod(var_9) || isanimation(var_9))
          self call[[var_9]]();
        else
          self[[var_9]]();

        return;
      }
    }

    if(istrue(level.hover_radius[var_0].comparescore)) {
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

    if(istrue(level.hover_radius[var_0].commandwatcher)) {
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

obj_room_fire_02(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(scripts\engine\utility::array_contains(level.hover_speed, var_0))
    return 0;

  if(isDefined(level.hover_radius[var_0].obj_room_fire_04)) {
    if(isDefined(var_8))
      return [[level.hover_radius[var_0].obj_room_fire_04]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(var_7))
      return [[level.hover_radius[var_0].obj_room_fire_04]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_6))
      return [[level.hover_radius[var_0].obj_room_fire_04]](var_1, var_2, var_3, var_4, var_5, var_6);

    if(isDefined(var_5))
      return [[level.hover_radius[var_0].obj_room_fire_04]](var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_4))
      return [[level.hover_radius[var_0].obj_room_fire_04]](var_1, var_2, var_3, var_4);

    if(isDefined(var_3))
      return [[level.hover_radius[var_0].obj_room_fire_04]](var_1, var_2, var_3);

    if(isDefined(var_2))
      return [[level.hover_radius[var_0].obj_room_fire_04]](var_1, var_2);

    if(isDefined(var_1))
      return [[level.hover_radius[var_0].obj_room_fire_04]](var_1);

    return [[level.hover_radius[var_0].obj_room_fire_04]]();
  }

  return 1;
}

_id_11AA9(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 0.05;
  level.hover_speed = scripts\engine\utility::array_add_safe(level.hover_speed, var_0);

  if(isDefined(level.hover_radius[var_0].timeout))
    var_1 = level.hover_radius[var_0].timeout;

  wait(var_1);
  level.hover_speed = scripts\engine\utility::array_remove(level.hover_speed, var_0);
}