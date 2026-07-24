/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2995.gsc
**************************************/

_id_31CA() {
  var_0 = spawnStruct();
  var_0._id_101AD = "L";
  var_1 = spawnStruct();
  var_1._id_101AD = "R";
  self._id_12A33 = [var_0, var_1];
  self._id_EEF9 = "cannon_missileboat_small";
}

_id_31CB(var_0) {
  self._id_12A33 = [];

  if(self._id_101AD == "L") {
    var_1 = ["amb_missile_l_1", "amb_missile_l_2", "amb_missile_l_3", "amb_missile_l_4", "amb_missile_l_5", "amb_missile_l_6", "amb_missile_l_7", "amb_missile_l_8", "amb_missile_l_9", "amb_missile_l_10", "amb_missile_l_11", "amb_missile_l_12"];
  } else {
    var_1 = ["amb_missile_r_1", "amb_missile_r_2", "amb_missile_r_3", "amb_missile_r_4", "amb_missile_r_5", "amb_missile_r_6", "amb_missile_r_7", "amb_missile_r_8", "amb_missile_r_9", "amb_missile_r_10", "amb_missile_r_11", "amb_missile_r_12"];
  }
}

_id_129E5(var_0) {
  thread _id_129D2(var_0);
  self waittill("death");
  self._id_5978 delete();
}

_id_129D2(var_0) {
  var_0 scripts\engine\utility::delete_on_death(self);
  var_0 scripts\engine\utility::delete_on_death(self._id_5978);
}

_id_129E7() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = 8;
  var_1 = 8;

  for(;;) {
    self waittill("emp", var_2, var_3, var_4);
    self._id_4B43 = var_4;
    var_5 = scripts\sp\math::_id_6A8E(var_0, var_1, var_2);
    self._id_615D._id_619D = 1;

    if(isDefined(self.script_team) && isDefined(var_4.script_team) && self.script_team == var_4.script_team) {} else {
      thread _id_12A19();
      wait(var_5);
      thread _id_129D5();
    }

    self._id_615D._id_619D = 0;
    self notify("emp_complete");
  }
}

_id_129DF() {
  self._id_C8F3.turrets = scripts\engine\utility::array_remove(self._id_C8F3.turrets, self);
  self delete();
}

_id_12A85(var_0) {
  foreach(var_2 in self._id_12A33) {
    foreach(var_4 in var_2.turrets) {
      var_4 thread _id_12A19(var_0);
    }
  }
}

#using_animtree("vehicles");

_id_12A19(var_0) {
  self endon("death");
  _id_129C1(%vh_missile_boat_turret_open, %vh_missile_boat_turret_door_open, var_0);
  wait 0.5;
  self notify("turret_open");
  self._id_5978.state = "open";
}

_id_12A84(var_0) {
  foreach(var_2 in self._id_12A33) {
    foreach(var_4 in var_2.turrets) {
      if(isDefined(var_4)) {
        var_4 thread _id_129D5(var_0);
      }
    }
  }

  wait 0.5;
  self notify("turrets_closed");
}

_id_129D5(var_0) {
  _id_129C1(%vh_missile_boat_turret_close, %vh_missile_boat_turret_door_close, var_0);
  self._id_5978.state = "closed";
}

_id_129C1(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(isDefined(self)) {
    self setanimknob(var_0, 1, 0.2);

    if(var_2) {
      self _meth_82B0(var_0, 1);
    }

    if(self._id_5978._id_1BE4) {
      self._id_5978 setanimknob(var_1, 1, 0.2);

      if(var_2) {
        self._id_5978 _meth_82B0(var_1, 1);
      }
    }
  }
}