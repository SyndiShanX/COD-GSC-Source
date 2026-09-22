/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_trigger.gsc
***************************************/

_id_4323() {
  var_0 = [];
  var_0["trigger_multiple_flag_set"] = ::_id_9D79;
  var_0["trigger_multiple_flag_set_touching"] = ::_id_9D7A;
  var_0["trigger_multiple_flag_clear"] = ::_id_9D75;
  var_0["trigger_multiple_flag_lookat"] = ::_id_9D76;
  var_0["trigger_multiple_flag_looking"] = ::_id_9D77;
  var_0["trigger_use_flag_set"] = ::_id_9D79;
  var_0["trigger_use_flag_clear"] = ::_id_9D75;
  return var_0;
}

_id_9D6F(var_0) {}

_id_9DAC(var_0) {
  var_1 = common_scripts\utility::_id_2798(var_0.setgoalnode);
  var_0 _id_097B(var_1);
  var_0 common_scripts\utility::_id_A0D3();
}

_id_9DAB(var_0) {
  var_1 = common_scripts\utility::_id_2798(var_0.pushplayer);
  var_0 _id_097B(var_1);
  var_0 common_scripts\utility::_id_A0D3();
}

_id_097B(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(level._id_9D7B[var_0[var_1]])) {
      level._id_9D7B[var_0[var_1]] = [];
    }

    level._id_9D7B[var_0[var_1]] = common_scripts\utility::_id_0F6F(level._id_9D7B[var_0[var_1]], self);
  }
}

_id_9D85() {
  thread _id_9D86();
  level endon("trigger_group_" + self.addroll);
  self waittill("trigger");
  level notify("trigger_group_" + self.addroll, self);
}

_id_9D86() {
  level waittill("trigger_group_" + self.addroll, var_0);

  if(isDefined(self) && self != var_0) {
    self delete();
  }
}

_id_4397(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {}

  var_1 = [];
  var_2 = getEntArray(self.target, "targetname");

  if(isDefined(var_2)) {
    var_1 = common_scripts\utility::_id_0F73(var_1, var_2);
  }

  var_3 = common_scripts\utility::_id_46B7(self.target, "targetname");

  if(isDefined(var_3)) {
    var_1 = common_scripts\utility::_id_0F73(var_1, var_3);
  }

  var_4 = _getnodearray(self.target, "targetname");

  if(isDefined(var_4)) {
    var_1 = common_scripts\utility::_id_0F73(var_1, var_4);
  }

  var_5 = _getvehiclenodearray(self.target, "targetname");

  if(isDefined(var_5)) {
    var_1 = common_scripts\utility::_id_0F73(var_1, var_5);
  }

  if(var_0) {}

  return var_1;
}

_id_9D79(var_0) {
  var_0 endon("death");
  var_1 = var_0 common_scripts\utility::_id_4395();

  if(!common_scripts\utility::_id_3C83(var_1)) {
    common_scripts\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 common_scripts\utility::script_delay();
    common_scripts\utility::flag_set(var_1, var_2);
  }
}

_id_9D75(var_0) {
  var_0 endon("death");
  var_1 = var_0 common_scripts\utility::_id_4395();

  if(!common_scripts\utility::_id_3C83(var_1)) {
    common_scripts\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 common_scripts\utility::script_delay();
    common_scripts\utility::_id_3C7B(var_1, var_2);
  }
}

_id_9D7A(var_0) {
  var_0 endon("death");
  var_1 = var_0 common_scripts\utility::_id_4395();

  if(!common_scripts\utility::_id_3C83(var_1)) {
    common_scripts\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 common_scripts\utility::script_delay();

    if(isalive(var_2) && var_2 istouching(var_0) && isDefined(var_0)) {
      common_scripts\utility::flag_set(var_1, var_2);
    }

    while(isalive(var_2) && var_2 istouching(var_0) && isDefined(var_0)) {
      wait 0.25;
    }

    common_scripts\utility::_id_3C7B(var_1, var_2);
  }
}

_id_9D76(var_0) {
  _id_9D8E(var_0, 0);
}

_id_9D77(var_0) {
  _id_9D8E(var_0, 1);
}

_id_9D8E(var_0, var_1) {
  var_2 = 0.78;

  if(isDefined(var_0.getclosestenemysqdist)) {
    var_2 = var_0.getclosestenemysqdist;
  }

  var_3 = var_0 _id_4397();
  var_4 = var_3[0];
  var_5 = var_4.origin;
  var_0 endon("death");
  var_4 endon("death");
  var_6 = var_0 common_scripts\utility::_id_4395();

  if(!common_scripts\utility::_id_3C83(var_6)) {
    common_scripts\utility::flag_init(var_6);
  }

  var_7 = 0;

  if(isDefined(var_0.setlookatent)) {
    var_7 = !issubstr("no_sight", var_0.setlookatent);
  }

  for(;;) {
    if(var_1) {
      common_scripts\utility::_id_3C7B(var_6, var_0);
    }

    for(;;) {
      var_0 waittill("trigger", var_8);

      if(isPlayer(var_8)) {
        break;
      }
    }

    while(var_8 istouching(var_0)) {
      if(var_7 && !_sighttracepassed(var_8 getEye(), var_5, 0, undefined)) {
        if(var_1) {
          common_scripts\utility::_id_3C7B(var_6, var_0);
        }

        wait 0.5;
        continue;
      }

      var_9 = vectorNormalize(var_5 - var_8.origin);
      var_10 = var_8 getplayerangles();
      var_11 = anglesToForward(var_10);
      var_12 = vectordot(var_11, var_9);

      if(var_12 >= var_2) {
        common_scripts\utility::flag_set(var_6, var_8);
      } else if(var_1) {
        common_scripts\utility::_id_3C7B(var_6, var_0);
      }

      if(var_7) {
        wait 0.5;
        continue;
      }

      waitframe();
    }
  }
}