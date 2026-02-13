/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2704.gsc
*************************************************/

_id_68F1(var_0) {
  var_1 = (0, 0, 0);

  if(!var_0.size) {
    return undefined;
  }

  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3.origin;
  }

  var_5 = int(var_1[0] / var_0.size);
  var_6 = int(var_1[1] / var_0.size);
  var_7 = int(var_1[2] / var_0.size);
  var_1 = (var_5, var_6, var_7);
  return var_1;
}

_id_F38F() {
  var_0 = getEntArray("trigger_hurt", "classname");

  foreach(var_2 in var_0) {
    if(self istouching(var_2)) {
      return 1;
    }
  }

  var_4 = getEntArray("radiation", "targetname");

  foreach(var_2 in var_4) {
    if(self istouching(var_2)) {
      return 1;
    }
  }

  return 0;
}

_id_F394() {
  if(istrue(self._id_15AE)) {
    return 0;
  }

  if(!isDefined(level._id_AD0F)) {
    return 0;
  }

  foreach(var_1 in level._id_AD0F) {
    if(self istouching(var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_F390() {
  if(!istrue(level._id_2192.size)) {
    return 0;
  }

  self._id_15AE = 0;

  foreach(var_1 in level._id_2192) {
    if(self istouching(var_1)) {
      self._id_15AE = 1;
      return 1;
    }
  }

  return 0;
}

_id_F395() {
  if(!istrue(level._id_B657.size)) {
    return 0;
  }

  self._id_15AE = 0;

  foreach(var_1 in level._id_B657) {
    if(self istouching(var_1)) {
      self._id_15AE = 1;
      return 1;
    }
  }

  return 0;
}

_id_5AF2(var_0, var_1, var_2) {
  var_3 = cos(var_2);
  var_4 = anglesToForward(var_0.angles);
  var_5 = var_1.origin - var_0.origin;
  var_4 = var_4 * (1, 1, 0);
  var_5 = var_5 * (1, 1, 0);
  var_5 = vectornormalize(var_5);
  var_4 = vectornormalize(var_4);
  var_6 = vectordot(var_5, var_4);

  if(var_6 >= var_3) {
    return 1;
  } else {
    return 0;
  }
}

_id_8744(var_0) {
  if(isagent(var_0) && var_0._id_120F == 1) {
    return 1;
  }

  if(isbot(var_0)) {
    return 1;
  }

  return 0;
}

_id_8A94(var_0) {
  if(_id_8744(var_0)) {
    return 1;
  }

  if(isPlayer(var_0)) {
    return 1;
  }

  return 0;
}

_id_8737(var_0) {
  if(isagent(var_0) && isDefined(var_0._id_11F0) && var_0._id_11F0 == 1) {
    return 1;
  }

  if(isbot(var_0)) {
    return 1;
  }

  return 0;
}

_id_8877(var_0) {
  if(_id_8737(var_0)) {
    return 1;
  }

  if(isPlayer(var_0)) {
    return 1;
  }

  return 0;
}

_id_6DD1(var_0) {
  var_1 = 0;

  if(level.teambased) {
    switch (var_0) {
      case "axis":
        var_1 = 1;
        break;
      case "allies":
        var_1 = 2;
        break;
    }
  }

  return var_1;
}

_id_8AEE(var_0, var_1, var_2) {
  return isDefined(var_2.team) && var_2.team == var_1;
}

_id_8AE5(var_0, var_1, var_2) {
  return 1;
}

_id_6B0F() {
  var_0 = [];

  if(isDefined(self._id_0399)) {
    var_1 = strtok(self._id_0399, " ");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = _func_00B2(var_1[var_2], "script_linkname");

      if(isDefined(var_3)) {
        var_0[var_0.size] = var_3;
      }
    }
  }

  return var_0;
}

_id_6C10(var_0, var_1, var_2, var_3) {
  return getentitiesinradius(var_0, var_1, var_2, var_3, scripts\engine\trace::_id_3EE0());
}

getentitiesinradius(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 <= 0) {
    return [];
  }

  var_5 = undefined;

  if(isDefined(var_3)) {
    if(_func_0107(var_3)) {
      var_5 = var_3;
    } else {
      var_5 = [var_3];
    }
  }

  var_6 = _func_02C5(var_0, var_1, var_4, var_5, "physicsquery_all");
  var_7 = [];

  if(!isDefined(var_2)) {
    foreach(var_9 in var_6) {
      var_10 = var_9["entity"];

      if(isDefined(var_10)) {
        var_7[var_7.size] = var_10;
      }
    }
  } else {
    foreach(var_9 in var_6) {
      var_10 = var_9["entity"];

      if(isDefined(var_10) && isDefined(var_10.team) && var_10.team == var_2) {
        var_7[var_7.size] = var_10;
      }
    }
  }

  return var_7;
}

_id_10ADB(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  self endon("end_entities_in_radius");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_5 = undefined;

    if(var_4) {
      var_5 = scripts\mp\utility\player::_id_6C5F(self.origin, var_0);
    } else {
      var_5 = getentitiesinradius(self.origin, var_0);
    }

    if(var_5.size > 0) {
      if(!var_3) {
        self notify(var_1, var_5);
      } else {
        var_6 = [];

        foreach(var_8 in var_5) {
          var_9 = self _meth_8169();
          var_10 = scripts\engine\utility::ter_op(var_4, var_8 getEye(), var_8.origin);
          var_11 = physics_createcontents(["physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot"]);
          var_12 = _func_02C1(var_9, var_10, var_11, undefined, 0, "physicsquery_closest");

          if(var_12.size <= 0) {
            var_6[var_6.size] = var_8;
          }
        }

        self notify(var_1, var_6);
      }
    }

    wait(var_2);
  }
}

_id_315A() {
  self notify("end_entities_in_radius");
}

_id_B164(var_0, var_1, var_2, var_3) {
  self playsoundtoplayer("scavenger_pack_pickup", self, self);

  if(istrue(var_1)) {
    var_4 = undefined;

    if(isDefined(var_3)) {
      var_4 = _func_020D(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2, self, anglesToForward(var_3), anglestoup(var_3));
    } else {
      var_4 = _func_020D(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2, self);
    }

    triggerfx(var_4);
    thread _id_B165(var_4);
  }

  switch (var_0) {
    case "trophy_mp":
    case "cryo_mine_mp":
    case "micro_turret_mp":
    case "trip_mine_mp":
    case "deployable_cover_mp":
      if(isPlayer(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
        self iprintlnbold("Placement Failed");
        return;
      }
  }
}

_id_B166() {
  level._effect["placeEquipmentFailed"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
}

_id_B165(var_0) {
  wait 2;
  var_0 delete();
}

_id_8A5A(var_0) {
  return istrue(var_0._id_8A5A);
}

_id_8A7C(var_0) {
  var_1 = var_0 getentitynumber();

  if(!isDefined(level._id_EB4E)) {
    return 0;
  }

  if(!isDefined(level._id_EB4E._id_F673)) {
    return 0;
  }

  if(!isDefined(level._id_EB4E._id_F673[var_1])) {
    return 0;
  }

  return level._id_EB4E._id_F673[var_1] == var_0;
}

_id_892F(var_0) {
  var_1 = var_0 getentitynumber();

  if(!isDefined(level._id_9E83)) {
    return 0;
  }

  if(!isDefined(level._id_9E83[var_1])) {
    return 0;
  }

  return level._id_9E83[var_1] == var_0;
}

_id_87AE(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "chopper_gunner";
  return var_1;
}

_id_8A80(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "chopper_support";
  return var_1;
}

_id_87B4(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "toma_strike";
  return var_1;
}

_id_8ABB(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  if(var_0.streakinfo.streakname == "uav" || var_0.streakinfo.streakname == "counter_uav" || var_0.streakinfo.streakname == "directional_uav") {
    return 1;
  }

  return 0;
}

_id_8889(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "ball_turret_gunner";
  return var_1;
}

_id_89D2(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "radar_drone_escort" || var_0.streakinfo.streakname == "radar_drone_recon";
  return var_1;
}

_id_8A1A(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "scrambler_drone_guard";
  return var_1;
}

_id_89D3(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "radar_drone_overwatch";
  return var_1;
}

_id_8AB6(var_0) {
  return isDefined(var_0.classname) && var_0.classname == "misc_turret";
}

_id_8811(var_0) {
  return isDefined(var_0.cratetype);
}

_id_0BD7() {
  if(!isDefined(self._id_5245)) {
    self._id_5245 = 0;
  }

  if(self._id_5245 == 0) {
    self _meth_80D6(1);
  }

  self._id_5245++;
}

_id_0BC1() {
  if(self._id_5245 == 1) {
    self _meth_80D6(0);
  }

  self._id_5245--;
}

register_physics_collisions() {
  self endon("death");
  self endon("stop_phys_sounds");

  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    level notify("physSnd", self, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

_id_703F() {
  level notify("physics_monitor");
  level endon("physics_monitor");

  for(;;) {
    level waittill("physSnd", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(var_0) && isDefined(var_0._id_B049)) {
      level thread[[var_0._id_B049]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  }
}

_id_C208(var_0, var_1) {
  var_0._id_B049 = var_1;
}

_id_8AA9(var_0) {
  return istrue(var_0._id_1646);
}

_id_8AA8(var_0) {
  var_1 = 0;

  if(isDefined(level._id_AD0E) && level._id_AD0E.size > 0) {
    foreach(var_3 in level._id_AD0E) {
      if(var_0 istouching(var_3)) {
        var_1 = 1;
        break;
      }
    }
  }

  return var_1;
}

_id_477D(var_0) {
  self endon("death");
  var_0 waittill("death_or_disconnect");
  self delete();
}

_id_475C() {
  self endon("death");
  waittillframeend;
  self delete();
}