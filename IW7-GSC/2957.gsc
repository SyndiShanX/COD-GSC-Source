/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2957.gsc
***************************************/

init() {
  level.player func_41BB();
  level.player thread func_10FA0();
  level.player thread stringemissilefired();
  level.player thread func_10FAC();
  level.player thread func_10F9E();
}

func_41BB() {
  if(!isDefined(self.func_10F9D)) {
    self.func_10F9D = spawnStruct();
  }

  self.func_10F9D.func_10FA6 = 0;
  self.func_10F9D.func_10FA5 = 0;
  self.func_10F9D.func_10FA3 = 0;

  if(isDefined(self.func_10F9D.func_10FAA)) {
    func_41E3(iprintln(self.func_10F9D.func_10FAA));
  }

  self.func_10F9D.func_10FAA = undefined;
  self notify("stinger_irt_cleartarget");
  self notify("stop_lockon_sound");
  self notify("stop_locked_sound");
  self.func_10F9D.func_10FA4 = undefined;
  self _meth_8403();
  self _meth_8406(0);
  self _meth_8404(0);
}

func_10FA0() {
  for(;;) {
    self waittill("weapon_fired");
    var_00 = getweaponbasename(self getcurrentweapon());

    if(!isDefined(var_00) || var_00 != "iw7_lockon") {
      continue;
    }
    self notify("stinger_fired");
  }
}

stringemissilefired() {
  for(;;) {
    self waittill("missile_fire", var_00, var_01);

    if(isDefined(var_00)) {
      var_02 = self.func_10F9D.func_10FAA;

      if(func_9F7A(var_02)) {
        if(isDefined(var_2.unittype) && !scripts\engine\utility::is_true(var_2.space)) {
          if(var_2.unittype == "soldier" || var_2.unittype == "c6") {
            var_00 missile_settargetent(self.func_10F9D.func_10FAA, (0, 0, 38));
          } else if(var_2.unittype == "c8") {
            var_00 missile_settargetent(self.func_10F9D.func_10FAA, (0, 0, 60));
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
    self.func_10F9D.func_AF2F = [];
    self.func_10F9D.func_11565 = ["0", "1", "2", "3"];
    thread func_10FA2();

    while(func_D42E()) {
      wait 0.05;
    }

    setomnvar("ui_lockon_ads", 0);
    self notify("stinger_IRT_off");
    func_41BB();

    foreach(var_01 in self.func_10F9D.func_AF2F) {
      func_41E3(var_01);
    }

    self.func_10F9D.func_AF2F = undefined;
    self.func_10F9D.func_11565 = undefined;
  }
}

func_10F9E() {
  self waittill("death");

  if(isDefined(self.func_10F9D.func_AF2F)) {
    setomnvar("ui_lockon_ads", 0);

    foreach(var_01 in self.func_10F9D.func_AF2F) {
      func_41E3(var_01);
    }
  }
}

func_10FA2() {
  self endon("death");
  self endon("stinger_IRT_off");

  for(;;) {
    wait 0.05;

    if(self.func_10F9D.func_10FA3) {
      if(!func_9F7A(self.func_10F9D.func_10FAA)) {
        func_41BB();
        continue;
      }

      var_00 = iprintln(self.func_10F9D.func_10FAA);

      if(isDefined(var_0.ent.func_3508)) {
        setomnvar("ui_lockon_target_health_" + var_0.id, var_0.ent.func_8CB0);
      }

      func_F875(self.func_10F9D.func_10FAA);
      continue;
    }

    if(self.func_10F9D.func_10FA5) {
      if(!func_9F7A(self.func_10F9D.func_10FAA)) {
        func_41BB();
        continue;
      }

      var_00 = iprintln(self.func_10F9D.func_10FAA);

      if(isDefined(var_0.ent.func_3508)) {
        setomnvar("ui_lockon_target_health_" + var_0.id, var_0.ent.func_8CB0);
      }

      var_01 = gettime() - self.func_10F9D.func_10FA6;

      if(var_01 < 500) {
        continue;
      }
      self notify("stop_lockon_sound");
      self.func_10F9D.func_10FA3 = 1;
      self _meth_8402(self.func_10F9D.func_10FAA);
      func_F875(self.func_10F9D.func_10FAA);
      setomnvar("ui_lockon_target_state_" + var_0.id, 2);
      continue;
    }

    var_02 = func_7E04();

    if(!isDefined(var_02)) {
      continue;
    }
    setomnvar("ui_lockon_target_state_" + var_2.id, 1);
    self.func_10F9D.func_10FAA = var_2.ent;
    self.func_10F9D.func_10FA6 = gettime();
    self.func_10F9D.func_10FA5 = 1;
  }
}

stinger_get_closest_to_player_view(var_00, var_01, var_02, var_03) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_01)) {
    var_01 = level.player;
  }

  if(!isDefined(var_03)) {
    var_03 = -1;
  }

  var_04 = var_1.origin;

  if(isDefined(var_02) && var_02) {
    var_04 = var_01 getEye();
  }

  var_05 = undefined;
  var_06 = var_01 getplayerangles();
  var_07 = anglesToForward(var_06);
  var_08 = -1;

  foreach(var_10 in var_00) {
    var_11 = vectortoangles(var_10.origin - var_04);
    var_12 = anglesToForward(var_11);
    var_13 = vectordot(var_07, var_12);
    var_14 = distancesquared(var_04, var_10.origin);
    var_15 = 1 - scripts\sp\math::func_C097(squared(250), squared(5000), var_14);
    var_13 = var_13 * var_15;

    if(var_13 < var_08) {
      continue;
    }
    if(var_13 < var_03) {
      continue;
    }
    var_08 = var_13;
    var_05 = var_10;
  }

  return var_05;
}

func_7E04() {
  var_00 = func_7E4B();
  var_01 = self.func_10F9D.func_AF2F;

  if(isDefined(self.func_10F9D.func_10FAA)) {
    var_00 = scripts\engine\utility::array_remove(var_00, self.func_10F9D.func_10FAA);
    var_01 = scripts\engine\utility::array_remove(var_01, iprintln(self.func_10F9D.func_10FAA));
  }

  var_02 = [];

  for(var_03 = 0; var_03 < var_0.size; var_3++) {
    var_04 = var_0[var_03];

    if(func_8C0A(var_04)) {
      var_2[var_2.size] = var_04;
      continue;
    }

    var_05 = iprintln(var_04);

    if(isDefined(var_05)) {
      func_41E3(var_05);
    }
  }

  if(var_2.size == 0) {
    return undefined;
  }

  var_06 = [];
  var_07 = 4;

  if(isDefined(self.func_10F9D.func_10FAA)) {
    var_7--;
  }

  for(var_08 = 0; var_08 < var_07; var_8++) {
    var_04 = stinger_get_closest_to_player_view(var_02, level.player, 1);
    var_6[var_08] = var_04;
    var_02 = scripts\engine\utility::array_remove(var_02, var_04);

    if(var_2.size == 0) {
      break;
    }
  }

  var_09 = var_06;

  foreach(var_05 in var_01) {
    if(!scripts\engine\utility::array_contains(var_09, var_5.ent)) {
      func_41E3(var_05);
      continue;
    }

    var_09 = scripts\engine\utility::array_remove(var_09, var_5.ent);
  }

  foreach(var_04 in var_09) {
    func_1833(var_04);
  }

  foreach(var_15 in var_06) {
    if(func_9922(var_15)) {
      return iprintln(var_15);
    }
  }

  return undefined;
}

func_7E4B() {
  var_00 = _getaiarray("axis");

  foreach(var_02 in var_00) {
    if(isDefined(var_2.unittype) && var_2.unittype == "c12") {
      var_00 = scripts\engine\utility::array_remove(var_00, var_02);
      var_03 = var_2.func_C925;

      if(isDefined(var_3["right_leg"]) && !isDefined(var_3["left_leg"])) {
        var_03 = scripts\sp\utility::func_22B2(var_03, "right_leg");
      } else if(isDefined(var_3["left_leg"]) && !isDefined(var_3["right_leg"])) {
        var_03 = scripts\sp\utility::func_22B2(var_03, "left_leg");
      }

      var_00 = scripts\engine\utility::array_combine(var_00, var_03);
    }
  }

  return var_00;
}

iprintln(var_00) {
  foreach(var_02 in self.func_10F9D.func_AF2F) {
    if(var_2.ent == var_00) {
      return var_02;
    }
  }

  return undefined;
}

func_1833(var_00) {
  var_01 = spawnStruct();
  var_1.ent = var_00;
  var_1.id = self.func_10F9D.func_11565[0];
  setomnvar("ui_lockon_target_ent_" + var_1.id, var_00);
  setomnvar("ui_lockon_target_state_" + var_1.id, 0);

  if(isDefined(var_0.func_3508)) {
    setomnvar("ui_lockon_target_name_" + var_1.id, var_0.name);
    setomnvar("ui_lockon_target_health_" + var_1.id, var_1.ent.func_8CB0);
  }

  self.func_10F9D.func_11565 = scripts\engine\utility::array_remove(self.func_10F9D.func_11565, var_1.id);
  self.func_10F9D.func_AF2F[self.func_10F9D.func_AF2F.size] = var_01;
}

func_41E3(var_00) {
  self.func_10F9D.func_AF2F = scripts\engine\utility::array_remove(self.func_10F9D.func_AF2F, var_00);
  self.func_10F9D.func_11565[self.func_10F9D.func_11565.size] = var_0.id;
  setomnvar("ui_lockon_target_ent_" + var_0.id, undefined);
  setomnvar("ui_lockon_target_state_" + var_0.id, 0);
  setomnvar("ui_lockon_target_name_" + var_0.id, "none");
  setomnvar("ui_lockon_target_health_" + var_0.id, 0);
}

func_9922(var_00) {
  return level.player worldpointinreticle_circle(func_7E9A(var_00), 65, 45);
}

func_9920(var_00) {
  return level.player worldpointinreticle_circle(func_7E9A(var_00), 65, 75);
}

func_9921(var_00) {
  return level.player worldpointinreticle_circle(func_7E9A(var_00), 65, 35);
}

func_8C0A(var_00) {
  var_01 = self getEye();
  var_02 = [self, var_00];
  var_03 = func_7E9A(var_00);

  if(isDefined(var_0.func_3508)) {
    var_2[var_2.size] = var_0.func_3508;

    if(isDefined(var_0.func_3508.func_E601)) {
      var_2[var_2.size] = var_0.func_3508.func_E601;
    }
  }

  var_04 = scripts\engine\trace::ray_trace(var_01, var_03, var_02);
  return distancesquared(var_4["position"], var_03) <= 1;
}

func_7E9A(var_00) {
  var_01 = var_0.origin;

  if(!isDefined(var_0.func_3508)) {
    if(isDefined(var_0.unittype) && tolower(var_0.unittype) == "c8") {
      var_02 = 60;
    } else {
      var_02 = 38;
    }

    var_01 = var_01 + var_02 * anglestoup(var_0.angles);
  }

  return var_01;
}

func_9F7A(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  if(!isDefined(var_0.func_3508) && !isalive(var_00) || isDefined(var_0.func_3508) && !isalive(var_0.func_3508)) {
    return 0;
  }

  if(!func_9920(var_00)) {
    return 0;
  }

  if(!func_8C0A(var_00)) {
    return 0;
  }

  if(func_9921(self.func_10F9D.func_10FAA) || self.func_10F9D.func_10FA5 && !self.func_10F9D.func_10FA3) {
    return 1;
  }

  var_01 = func_7E04();

  if(isDefined(var_01) && func_9921(var_1.ent)) {
    return 0;
  }

  return 1;
}

func_D42E() {
  var_00 = self getcurrentweapon();
  var_01 = getweaponbasename(var_00);

  if(!isDefined(var_01) || var_01 != "iw7_lockon") {
    return 0;
  }

  if(self getweaponammoclip(var_00) == 0) {
    return 0;
  }

  if(self playerads() == 1.0) {
    return 1;
  }

  return 0;
}

func_F875(var_00) {
  var_01 = 250;

  if(!isDefined(var_00)) {
    return 0;
  }

  var_02 = distance2d(self.origin, var_0.origin);

  if(var_02 < var_01) {
    self.func_10F9D.func_11588 = 1;
    self _meth_8406(1);
  } else {
    self.func_10F9D.func_11588 = 0;
    self _meth_8406(0);
  }
}

func_B061(var_00, var_01) {
  self endon("stop_lockon_sound");
  self endon("death");

  for(;;) {
    self playlocalsound(var_00);
    wait(var_01);
  }
}

func_B060(var_00, var_01) {
  self endon("stop_locked_sound");
  self endon("death");

  if(isDefined(self.func_10F9D.func_10FA4)) {
    return;
  }
  self.func_10F9D.func_10FA4 = 1;

  for(;;) {
    self playlocalsound(var_00);
    wait(var_01 / 3);
    wait(var_01 / 3);
    wait(var_01 / 3);
  }

  self.func_10F9D.func_10FA4 = undefined;
}