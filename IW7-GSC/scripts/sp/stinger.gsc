/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\stinger.gsc
**********************************/

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
  self weaponlockfree();
  self weaponlocktargettooclose(0);
  self weaponlocknoclearance(0);
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
      var_02 = self.var_10F9D.var_10FAA;
      if(func_9F7A(var_02)) {
        if(isDefined(var_02.unittype) && !scripts\engine\utility::istrue(var_02.isent)) {
          if(var_02.unittype == "soldier" || var_02.unittype == "c6") {
            var_00 missile_settargetent(self.var_10F9D.var_10FAA, (0, 0, 38));
          } else if(var_02.unittype == "c8") {
            var_00 missile_settargetent(self.var_10F9D.var_10FAA, (0, 0, 60));
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
      wait(0.05);
    }

    setomnvar("ui_lockon_ads", 1);
    self.var_10F9D.var_AF2F = [];
    self.var_10F9D.var_11565 = ["0", "1", "2", "3"];
    thread func_10FA2();
    while(func_D42E()) {
      wait(0.05);
    }

    setomnvar("ui_lockon_ads", 0);
    self notify("stinger_IRT_off");
    func_41BB();
    foreach(var_01 in self.var_10F9D.var_AF2F) {
      func_41E3(var_01);
    }

    self.var_10F9D.var_AF2F = undefined;
    self.var_10F9D.var_11565 = undefined;
  }
}

func_10F9E() {
  self waittill("death");
  if(isDefined(self.var_10F9D.var_AF2F)) {
    setomnvar("ui_lockon_ads", 0);
    foreach(var_01 in self.var_10F9D.var_AF2F) {
      func_41E3(var_01);
    }
  }
}

func_10FA2() {
  self endon("death");
  self endon("stinger_IRT_off");
  for(;;) {
    wait(0.05);
    if(self.var_10F9D.var_10FA3) {
      if(!func_9F7A(self.var_10F9D.var_10FAA)) {
        func_41BB();
        continue;
      }

      var_00 = iprintln(self.var_10F9D.var_10FAA);
      if(isDefined(var_00.ent.var_3508)) {
        setomnvar("ui_lockon_target_health_" + var_00.id, var_00.ent.var_8CB0);
      }

      func_F875(self.var_10F9D.var_10FAA);
      continue;
    }

    if(self.var_10F9D.var_10FA5) {
      if(!func_9F7A(self.var_10F9D.var_10FAA)) {
        func_41BB();
        continue;
      }

      var_00 = iprintln(self.var_10F9D.var_10FAA);
      if(isDefined(var_00.ent.var_3508)) {
        setomnvar("ui_lockon_target_health_" + var_00.id, var_00.ent.var_8CB0);
      }

      var_01 = gettime() - self.var_10F9D.var_10FA6;
      if(var_01 < 500) {
        continue;
      }

      self notify("stop_lockon_sound");
      self.var_10F9D.var_10FA3 = 1;
      self _meth_8402(self.var_10F9D.var_10FAA);
      func_F875(self.var_10F9D.var_10FAA);
      setomnvar("ui_lockon_target_state_" + var_00.id, 2);
      continue;
    }

    var_02 = func_7E04();
    if(!isDefined(var_02)) {
      continue;
    }

    setomnvar("ui_lockon_target_state_" + var_02.id, 1);
    self.var_10F9D.var_10FAA = var_02.ent;
    self.var_10F9D.var_10FA6 = gettime();
    self.var_10F9D.var_10FA5 = 1;
  }
}

stinger_get_closest_to_player_view(param_00, param_01, param_02, param_03) {
  if(!param_00.size) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = level.player;
  }

  if(!isDefined(param_03)) {
    param_03 = -1;
  }

  var_04 = param_01.origin;
  if(isDefined(param_02) && param_02) {
    var_04 = param_01 getEye();
  }

  var_05 = undefined;
  var_06 = param_01 getplayerangles();
  var_07 = anglesToForward(var_06);
  var_08 = -1;
  foreach(var_0A in param_00) {
    var_0B = vectortoangles(var_0A.origin - var_04);
    var_0C = anglesToForward(var_0B);
    var_0D = vectordot(var_07, var_0C);
    var_0E = distancesquared(var_04, var_0A.origin);
    var_0F = 1 - scripts\sp\math::func_C097(squared(250), squared(5000), var_0E);
    var_0D = var_0D * var_0F;
    if(var_0D < var_08) {
      continue;
    }

    if(var_0D < param_03) {
      continue;
    }

    var_08 = var_0D;
    var_05 = var_0A;
  }

  return var_05;
}

func_7E04() {
  var_00 = func_7E4B();
  var_01 = self.var_10F9D.var_AF2F;
  if(isDefined(self.var_10F9D.var_10FAA)) {
    var_00 = scripts\engine\utility::array_remove(var_00, self.var_10F9D.var_10FAA);
    var_01 = scripts\engine\utility::array_remove(var_01, iprintln(self.var_10F9D.var_10FAA));
  }

  var_02 = [];
  for(var_03 = 0; var_03 < var_00.size; var_03++) {
    var_04 = var_00[var_03];
    if(func_8C0A(var_04)) {
      var_02[var_02.size] = var_04;
      continue;
    }

    var_05 = iprintln(var_04);
    if(isDefined(var_05)) {
      func_41E3(var_05);
    }
  }

  if(var_02.size == 0) {
    return undefined;
  }

  var_06 = [];
  var_07 = 4;
  if(isDefined(self.var_10F9D.var_10FAA)) {
    var_07--;
  }

  for(var_08 = 0; var_08 < var_07; var_08++) {
    var_04 = stinger_get_closest_to_player_view(var_02, level.player, 1);
    var_06[var_08] = var_04;
    var_02 = scripts\engine\utility::array_remove(var_02, var_04);
    if(var_02.size == 0) {
      break;
    }
  }

  var_09 = var_06;
  foreach(var_05 in var_01) {
    if(!scripts\engine\utility::array_contains(var_09, var_05.ent)) {
      func_41E3(var_05);
      continue;
    }

    var_09 = scripts\engine\utility::array_remove(var_09, var_05.ent);
  }

  foreach(var_04 in var_09) {
    func_1833(var_04);
  }

  foreach(var_0F in var_06) {
    if(func_9922(var_0F)) {
      return iprintln(var_0F);
    }
  }

  return undefined;
}

func_7E4B() {
  var_00 = getaiarray("axis");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.unittype) && var_02.unittype == "c12") {
      var_00 = scripts\engine\utility::array_remove(var_00, var_02);
      var_03 = var_02.var_C925;
      if(isDefined(var_03["right_leg"]) && !isDefined(var_03["left_leg"])) {
        var_03 = scripts\sp\utility::func_22B2(var_03, "right_leg");
      } else if(isDefined(var_03["left_leg"]) && !isDefined(var_03["right_leg"])) {
        var_03 = scripts\sp\utility::func_22B2(var_03, "left_leg");
      }

      var_00 = scripts\engine\utility::array_combine(var_00, var_03);
    }
  }

  return var_00;
}

iprintln(param_00) {
  foreach(var_02 in self.var_10F9D.var_AF2F) {
    if(var_02.ent == param_00) {
      return var_02;
    }
  }

  return undefined;
}

func_1833(param_00) {
  var_01 = spawnStruct();
  var_01.ent = param_00;
  var_01.id = self.var_10F9D.var_11565[0];
  setomnvar("ui_lockon_target_ent_" + var_01.id, param_00);
  setomnvar("ui_lockon_target_state_" + var_01.id, 0);
  if(isDefined(param_00.var_3508)) {
    setomnvar("ui_lockon_target_name_" + var_01.id, param_00.name);
    setomnvar("ui_lockon_target_health_" + var_01.id, var_01.ent.var_8CB0);
  }

  self.var_10F9D.var_11565 = scripts\engine\utility::array_remove(self.var_10F9D.var_11565, var_01.id);
  self.var_10F9D.var_AF2F[self.var_10F9D.var_AF2F.size] = var_01;
}

func_41E3(param_00) {
  self.var_10F9D.var_AF2F = scripts\engine\utility::array_remove(self.var_10F9D.var_AF2F, param_00);
  self.var_10F9D.var_11565[self.var_10F9D.var_11565.size] = param_00.id;
  setomnvar("ui_lockon_target_ent_" + param_00.id, undefined);
  setomnvar("ui_lockon_target_state_" + param_00.id, 0);
  setomnvar("ui_lockon_target_name_" + param_00.id, "none");
  setomnvar("ui_lockon_target_health_" + param_00.id, 0);
}

func_9922(param_00) {
  return level.player worldpointinreticle_circle(func_7E9A(param_00), 65, 45);
}

func_9920(param_00) {
  return level.player worldpointinreticle_circle(func_7E9A(param_00), 65, 75);
}

func_9921(param_00) {
  return level.player worldpointinreticle_circle(func_7E9A(param_00), 65, 35);
}

func_8C0A(param_00) {
  var_01 = self getEye();
  var_02 = [self, param_00];
  var_03 = func_7E9A(param_00);
  if(isDefined(param_00.var_3508)) {
    var_02[var_02.size] = param_00.var_3508;
    if(isDefined(param_00.var_3508.var_E601)) {
      var_02[var_02.size] = param_00.var_3508.var_E601;
    }
  }

  var_04 = scripts\common\trace::ray_trace(var_01, var_03, var_02);
  return distancesquared(var_04["position"], var_03) <= 1;
}

func_7E9A(param_00) {
  var_01 = param_00.origin;
  if(!isDefined(param_00.var_3508)) {
    if(isDefined(param_00.unittype) && tolower(param_00.unittype) == "c8") {
      var_02 = 60;
    } else {
      var_02 = 38;
    }

    var_01 = var_01 + var_02 * anglestoup(param_00.angles);
  }

  return var_01;
}

func_9F7A(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if((!isDefined(param_00.var_3508) && !isalive(param_00)) || isDefined(param_00.var_3508) && !isalive(param_00.var_3508)) {
    return 0;
  }

  if(!func_9920(param_00)) {
    return 0;
  }

  if(!func_8C0A(param_00)) {
    return 0;
  }

  if(func_9921(self.var_10F9D.var_10FAA) || self.var_10F9D.var_10FA5 && !self.var_10F9D.var_10FA3) {
    return 1;
  }

  var_01 = func_7E04();
  if(isDefined(var_01) && func_9921(var_01.ent)) {
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

  if(self getweaponrankinfominxp() == 1) {
    return 1;
  }

  return 0;
}

func_F875(param_00) {
  var_01 = 250;
  if(!isDefined(param_00)) {
    return 0;
  }

  var_02 = distance2d(self.origin, param_00.origin);
  if(var_02 < var_01) {
    self.var_10F9D.var_11588 = 1;
    self weaponlocktargettooclose(1);
    return;
  }

  self.var_10F9D.var_11588 = 0;
  self weaponlocktargettooclose(0);
}

func_B061(param_00, param_01) {
  self endon("stop_lockon_sound");
  self endon("death");
  for(;;) {
    self playlocalsound(param_00);
    wait(param_01);
  }
}

func_B060(param_00, param_01) {
  self endon("stop_locked_sound");
  self endon("death");
  if(isDefined(self.var_10F9D.var_10FA4)) {
    return;
  }

  self.var_10F9D.var_10FA4 = 1;
  for(;;) {
    self playlocalsound(param_00);
    wait(param_01 / 3);
    wait(param_01 / 3);
    wait(param_01 / 3);
  }

  self.var_10F9D.var_10FA4 = undefined;
}