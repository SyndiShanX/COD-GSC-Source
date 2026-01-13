/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2957.gsc
**************************************/

init() {
  level.player func_41BB();
  level.player thread func_10FA0();
  level.player thread stringemissilefired();
  level.player thread func_10FAC();
  level.player thread func_10F9E();
}

func_41BB() {
  if(!isDefined(self.var_10F9D)) {
    self.var_10F9D = spawnStruct();
  }

  self.var_10F9D.var_10FA6 = 0;
  self.var_10F9D.var_10FA5 = 0;
  self.var_10F9D.var_10FA3 = 0;

  if(isDefined(self.var_10F9D.var_10FAA)) {
    func_41E3(iprintln(self.var_10F9D.var_10FAA));
  }

  self.var_10F9D.var_10FAA = undefined;
  self notify("stinger_irt_cleartarget");
  self notify("stop_lockon_sound");
  self notify("stop_locked_sound");
  self.var_10F9D.var_10FA4 = undefined;
  self _meth_8403();
  self _meth_8406(0);
  self _meth_8404(0);
}

func_10FA0() {
  for(;;) {
    self waittill("weapon_fired");
    var_0 = getweaponbasename(self getcurrentweapon());

    if(!isDefined(var_0) || var_0 != "iw7_lockon") {
      continue;
    }
    self notify("stinger_fired");
  }
}

stringemissilefired() {
  for(;;) {
    self waittill("missile_fire", var_0, var_1);

    if(isDefined(var_0)) {
      var_2 = self.var_10F9D.var_10FAA;

      if(func_9F7A(var_2)) {
        if(isDefined(var_2.unittype) && !scripts\engine\utility::is_true(var_2.space)) {
          if(var_2.unittype == "soldier" || var_2.unittype == "c6") {
            var_0 missile_settargetent(self.var_10F9D.var_10FAA, (0, 0, 38));
          } else if(var_2.unittype == "c8") {
            var_0 missile_settargetent(self.var_10F9D.var_10FAA, (0, 0, 60));
          }
        }
      }
    }
  }
}

func_10FAC() {
  self endon("death");

  for(;;) {
    while(!func_D42E()) {
      wait 0.05;
    }

    setomnvar("ui_lockon_ads", 1);
    self.var_10F9D.var_AF2F = [];
    self.var_10F9D.var_11565 = ["0", "1", "2", "3"];
    thread func_10FA2();

    while(func_D42E()) {
      wait 0.05;
    }

    setomnvar("ui_lockon_ads", 0);
    self notify("stinger_IRT_off");
    func_41BB();

    foreach(var_1 in self.var_10F9D.var_AF2F) {
      func_41E3(var_1);
    }

    self.var_10F9D.var_AF2F = undefined;
    self.var_10F9D.var_11565 = undefined;
  }
}

func_10F9E() {
  self waittill("death");

  if(isDefined(self.var_10F9D.var_AF2F)) {
    setomnvar("ui_lockon_ads", 0);

    foreach(var_1 in self.var_10F9D.var_AF2F) {
      func_41E3(var_1);
    }
  }
}

func_10FA2() {
  self endon("death");
  self endon("stinger_IRT_off");

  for(;;) {
    wait 0.05;

    if(self.var_10F9D.var_10FA3) {
      if(!func_9F7A(self.var_10F9D.var_10FAA)) {
        func_41BB();
        continue;
      }

      var_0 = iprintln(self.var_10F9D.var_10FAA);

      if(isDefined(var_0.ent.var_3508)) {
        setomnvar("ui_lockon_target_health_" + var_0.id, var_0.ent.var_8CB0);
      }

      func_F875(self.var_10F9D.var_10FAA);
      continue;
    }

    if(self.var_10F9D.var_10FA5) {
      if(!func_9F7A(self.var_10F9D.var_10FAA)) {
        func_41BB();
        continue;
      }

      var_0 = iprintln(self.var_10F9D.var_10FAA);

      if(isDefined(var_0.ent.var_3508)) {
        setomnvar("ui_lockon_target_health_" + var_0.id, var_0.ent.var_8CB0);
      }

      var_1 = gettime() - self.var_10F9D.var_10FA6;

      if(var_1 < 500) {
        continue;
      }
      self notify("stop_lockon_sound");
      self.var_10F9D.var_10FA3 = 1;
      self _meth_8402(self.var_10F9D.var_10FAA);
      func_F875(self.var_10F9D.var_10FAA);
      setomnvar("ui_lockon_target_state_" + var_0.id, 2);
      continue;
    }

    var_2 = func_7E04();

    if(!isDefined(var_2)) {
      continue;
    }
    setomnvar("ui_lockon_target_state_" + var_2.id, 1);
    self.var_10F9D.var_10FAA = var_2.ent;
    self.var_10F9D.var_10FA6 = gettime();
    self.var_10F9D.var_10FA5 = 1;
  }
}

stinger_get_closest_to_player_view(var_0, var_1, var_2, var_3) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = level.player;
  }

  if(!isDefined(var_3)) {
    var_3 = -1;
  }

  var_4 = var_1.origin;

  if(isDefined(var_2) && var_2) {
    var_4 = var_1 getEye();
  }

  var_5 = undefined;
  var_6 = var_1 getplayerangles();
  var_7 = anglesToForward(var_6);
  var_8 = -1;

  foreach(var_10 in var_0) {
    var_11 = vectortoangles(var_10.origin - var_4);
    var_12 = anglesToForward(var_11);
    var_13 = vectordot(var_7, var_12);
    var_14 = distancesquared(var_4, var_10.origin);
    var_15 = 1 - scripts\sp\math::func_C097(squared(250), squared(5000), var_14);
    var_13 = var_13 * var_15;

    if(var_13 < var_8) {
      continue;
    }
    if(var_13 < var_3) {
      continue;
    }
    var_8 = var_13;
    var_5 = var_10;
  }

  return var_5;
}

func_7E04() {
  var_0 = func_7E4B();
  var_1 = self.var_10F9D.var_AF2F;

  if(isDefined(self.var_10F9D.var_10FAA)) {
    var_0 = scripts\engine\utility::array_remove(var_0, self.var_10F9D.var_10FAA);
    var_1 = scripts\engine\utility::array_remove(var_1, iprintln(self.var_10F9D.var_10FAA));
  }

  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(func_8C0A(var_4)) {
      var_2[var_2.size] = var_4;
      continue;
    }

    var_5 = iprintln(var_4);

    if(isDefined(var_5)) {
      func_41E3(var_5);
    }
  }

  if(var_2.size == 0) {
    return undefined;
  }

  var_6 = [];
  var_7 = 4;

  if(isDefined(self.var_10F9D.var_10FAA)) {
    var_7--;
  }

  for(var_8 = 0; var_8 < var_7; var_8++) {
    var_4 = stinger_get_closest_to_player_view(var_2, level.player, 1);
    var_6[var_8] = var_4;
    var_2 = scripts\engine\utility::array_remove(var_2, var_4);

    if(var_2.size == 0) {
      break;
    }
  }

  var_9 = var_6;

  foreach(var_5 in var_1) {
    if(!scripts\engine\utility::array_contains(var_9, var_5.ent)) {
      func_41E3(var_5);
      continue;
    }

    var_9 = scripts\engine\utility::array_remove(var_9, var_5.ent);
  }

  foreach(var_4 in var_9) {
    func_1833(var_4);
  }

  foreach(var_15 in var_6) {
    if(func_9922(var_15)) {
      return iprintln(var_15);
    }
  }

  return undefined;
}

func_7E4B() {
  var_0 = _getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.unittype) && var_2.unittype == "c12") {
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
      var_3 = var_2.var_C925;

      if(isDefined(var_3["right_leg"]) && !isDefined(var_3["left_leg"])) {
        var_3 = scripts\sp\utility::func_22B2(var_3, "right_leg");
      } else if(isDefined(var_3["left_leg"]) && !isDefined(var_3["right_leg"])) {
        var_3 = scripts\sp\utility::func_22B2(var_3, "left_leg");
      }

      var_0 = scripts\engine\utility::array_combine(var_0, var_3);
    }
  }

  return var_0;
}

iprintln(var_0) {
  foreach(var_2 in self.var_10F9D.var_AF2F) {
    if(var_2.ent == var_0) {
      return var_2;
    }
  }

  return undefined;
}

func_1833(var_0) {
  var_1 = spawnStruct();
  var_1.ent = var_0;
  var_1.id = self.var_10F9D.var_11565[0];
  setomnvar("ui_lockon_target_ent_" + var_1.id, var_0);
  setomnvar("ui_lockon_target_state_" + var_1.id, 0);

  if(isDefined(var_0.var_3508)) {
    setomnvar("ui_lockon_target_name_" + var_1.id, var_0.name);
    setomnvar("ui_lockon_target_health_" + var_1.id, var_1.ent.var_8CB0);
  }

  self.var_10F9D.var_11565 = scripts\engine\utility::array_remove(self.var_10F9D.var_11565, var_1.id);
  self.var_10F9D.var_AF2F[self.var_10F9D.var_AF2F.size] = var_1;
}

func_41E3(var_0) {
  self.var_10F9D.var_AF2F = scripts\engine\utility::array_remove(self.var_10F9D.var_AF2F, var_0);
  self.var_10F9D.var_11565[self.var_10F9D.var_11565.size] = var_0.id;
  setomnvar("ui_lockon_target_ent_" + var_0.id, undefined);
  setomnvar("ui_lockon_target_state_" + var_0.id, 0);
  setomnvar("ui_lockon_target_name_" + var_0.id, "none");
  setomnvar("ui_lockon_target_health_" + var_0.id, 0);
}

func_9922(var_0) {
  return level.player worldpointinreticle_circle(func_7E9A(var_0), 65, 45);
}

func_9920(var_0) {
  return level.player worldpointinreticle_circle(func_7E9A(var_0), 65, 75);
}

func_9921(var_0) {
  return level.player worldpointinreticle_circle(func_7E9A(var_0), 65, 35);
}

func_8C0A(var_0) {
  var_1 = self getEye();
  var_2 = [self, var_0];
  var_3 = func_7E9A(var_0);

  if(isDefined(var_0.var_3508)) {
    var_2[var_2.size] = var_0.var_3508;

    if(isDefined(var_0.var_3508.var_E601)) {
      var_2[var_2.size] = var_0.var_3508.var_E601;
    }
  }

  var_4 = scripts\engine\trace::ray_trace(var_1, var_3, var_2);
  return distancesquared(var_4["position"], var_3) <= 1;
}

func_7E9A(var_0) {
  var_1 = var_0.origin;

  if(!isDefined(var_0.var_3508)) {
    if(isDefined(var_0.unittype) && tolower(var_0.unittype) == "c8") {
      var_2 = 60;
    } else {
      var_2 = 38;
    }

    var_1 = var_1 + var_2 * anglestoup(var_0.angles);
  }

  return var_1;
}

func_9F7A(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.var_3508) && !isalive(var_0) || isDefined(var_0.var_3508) && !isalive(var_0.var_3508)) {
    return 0;
  }

  if(!func_9920(var_0)) {
    return 0;
  }

  if(!func_8C0A(var_0)) {
    return 0;
  }

  if(func_9921(self.var_10F9D.var_10FAA) || self.var_10F9D.var_10FA5 && !self.var_10F9D.var_10FA3) {
    return 1;
  }

  var_1 = func_7E04();

  if(isDefined(var_1) && func_9921(var_1.ent)) {
    return 0;
  }

  return 1;
}

func_D42E() {
  var_0 = self getcurrentweapon();
  var_1 = getweaponbasename(var_0);

  if(!isDefined(var_1) || var_1 != "iw7_lockon") {
    return 0;
  }

  if(self getweaponammoclip(var_0) == 0) {
    return 0;
  }

  if(self playerads() == 1.0) {
    return 1;
  }

  return 0;
}

func_F875(var_0) {
  var_1 = 250;

  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = distance2d(self.origin, var_0.origin);

  if(var_2 < var_1) {
    self.var_10F9D.var_11588 = 1;
    self _meth_8406(1);
  } else {
    self.var_10F9D.var_11588 = 0;
    self _meth_8406(0);
  }
}

func_B061(var_0, var_1) {
  self endon("stop_lockon_sound");
  self endon("death");

  for(;;) {
    self playlocalsound(var_0);
    wait(var_1);
  }
}

func_B060(var_0, var_1) {
  self endon("stop_locked_sound");
  self endon("death");

  if(isDefined(self.var_10F9D.var_10FA4)) {
    return;
  }
  self.var_10F9D.var_10FA4 = 1;

  for(;;) {
    self playlocalsound(var_0);
    wait(var_1 / 3);
    wait(var_1 / 3);
    wait(var_1 / 3);
  }

  self.var_10F9D.var_10FA4 = undefined;
}