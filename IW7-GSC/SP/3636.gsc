/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3636.gsc
************************/

func_2A2D() {
  func_2A30();
  level.player.var_2A23 = 100;
  level.player.var_2A2E = 0;
  level.player.var_4BDD = 0;
  var_00 = getspawnerteamarray("axis");
  scripts\sp\utility::func_22C7(var_00, ::func_2A32);
  level.player thread func_2A35();
}

func_2A30() {
  level._effect["beam_rifle_beam"] = loadfx("vfx\iw7\_requests\europa\vfx_beam_rifle_beam");
  level._effect["beam_rifle_decal"] = loadfx("vfx\old\_requests\future_weapons\vfx_beam_rifle_impact_decal");
  level._effect["beam_rifle_fire"] = loadfx("vfx\old\_requests\future_weapons\vfx_beam_rifle_fire");
  level._effect["beam_rifle_smoke"] = loadfx("vfx\old\_requests\future_weapons\vfx_beam_rifle_smoke");
  level._effect["beam_rifle_ammo"] = loadfx("vfx\iw7\_requests\europa\vfx_beam_rifle_ammo");
  level._effect["beam_rifle_robot_explosion"] = loadfx("vfx\iw7\_requests\europa\vfx_beam_rifle_robot_explode.vfx");
  precacheshader("alien_icon_craft_battery");
  precacheitem("iw7_steeldragon");
}

func_2A35() {
  self endon("death");
  var_00 = 0.35;
  for(;;) {
    scripts\engine\utility::waittill_any_3("weapon_change", "weapon_dropped");
    if(issubstr(level.player getcurrentweapon(), "iw7_steeldragon")) {
      scripts\engine\utility::waitframe();
      self allowfire(0);
      var_01 = func_2A2B();
      var_02 = gettime();
      var_03 = 0;
      while(gettime() - var_02 < var_00 * 1000) {
        if(!issubstr(level.player getcurrentweapon(), "iw7_steeldragon")) {
          var_03 = 1;
          break;
        }

        wait(0.05);
      }

      var_00 = 1.4;
      if(!var_03) {
        func_2A33(var_01);
      }

      func_2A2C(var_01);
      self allowfire(1);
    }
  }
}

func_2A2B() {
  setdvar("hideHudFast", 1);
  setomnvar("ui_hide_weapon_info", 1);
  var_00 = [];
  var_01 = scripts\sp\hud_util::func_499B("alien_icon_craft_battery", 15, 15);
  var_01 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 290, 194);
  var_00["battery"] = var_01;
  var_02 = scripts\sp\hud_util::createfontstring("objective", 1);
  var_02 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 310, 194);
  var_00["ammo"] = var_02;
  var_03 = scripts\sp\hud_util::func_4997("white", "black", 104, 6);
  var_03 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 305, 203);
  var_03.bar.alpha = 1;
  var_03.bar.color = (1, 0, 0);
  var_00["energyBar"] = var_03;
  self.var_2A2B = var_00;
  func_2A34(self.var_2A23);
  return var_00;
}

func_2A2C(param_00) {
  setdvar("hideHudFast", 0);
  setsaveddvar("hud_showStance", 1);
  setomnvar("ui_hide_weapon_info", 0);
  foreach(var_02 in param_00) {
    if(isDefined(var_02.bar)) {
      var_02.bar destroy();
    }

    var_02 destroy();
  }

  self.var_2A2B = undefined;
}

func_2A33(param_00) {
  self endon("weapon_change");
  self endon("weapon_dropped");
  self.var_2A29 = 6000;
  self.var_2A2F = 0;
  thread func_2A27(param_00);
  for(;;) {
    self allowfire(0);
    if(!self attackbuttonpressed()) {} else if(self issprinting()) {} else if(self issprintsliding()) {} else if(self ismeleeing()) {} else if(self isthrowinggrenade()) {} else if(self.var_9F47) {} else if(self.var_2A2F) {} else {
      self playSound("weap_steeldragon_fire");
      wait(0.2);
      self notify("beam_rifle_fire");
      self.var_2A2A = 1;
      if(!self.var_2A2E) {
        thread func_FC1E();
        self getrawbaseweaponname(0.18, 0.18);
        thread scripts\sp\utility::func_D2CD(25, 0.05);
      } else {
        wait(0.3);
      }

      while(self attackbuttonpressed()) {
        self allowfire(0);
        if(self issprinting()) {
          break;
        }

        if(self.var_9F47) {
          break;
        }

        if(self.var_2A2E) {
          break;
        }

        if(self.var_2A2F) {
          break;
        }

        func_28C6();
        earthquake(0.12, 0.1, self getEye(), 5000);
        self playrumbleonentity("heavygun_fire");
        wait(0.05);
      }

      self notify("beam_rifle_off");
      self.var_2A2A = 0;
      self _meth_80A6();
      thread scripts\sp\utility::func_D2CA(0.05);
      scripts\engine\utility::delaythread(0.1, ::scripts\engine\utility::stop_loop_sound_on_entity, "weap_steeldragon_lp");
      if(self.var_2A2E) {
        scripts\sp\utility::play_sound_on_entity("weap_steeldragon_powerdown");
        var_01 = undefined;
        if(!isDefined(var_01)) {
          var_02 = undefined;
          var_03 = undefined;
          var_04 = self getweaponslistall();
          foreach(var_06 in var_04) {
            if(!scripts\sp\utility::isprimaryweapon(var_06)) {
              continue;
            }

            if(var_06 == "iw7_steeldragon") {
              continue;
            }

            var_07 = self getweaponammoclip(var_06) + self getweaponammostock(var_06);
            if(var_07 <= 0) {
              continue;
            }

            if(!isDefined(var_03)) {
              var_03 = var_06;
              var_02 = var_07;
              continue;
            }

            if(var_07 > var_02) {
              var_03 = var_06;
              var_02 = var_07;
            }
          }

          var_01 = var_03;
        }

        if(isDefined(var_01)) {
          self switchtoweapon(var_01);
        }
      } else {
        thread scripts\sp\utility::play_sound_on_entity("weap_steeldragon_off");
      }

      while(self attackbuttonpressed()) {
        wait(0.05);
      }
    }

    wait(0.05);
  }
}

func_FC1E() {
  self endon("beam_rifle_off");
  wait(0.35);
  if(self attackbuttonpressed()) {
    thread scripts\engine\utility::play_loop_sound_on_entity("weap_steeldragon_lp");
  }
}

func_2A22() {
  var_00 = 45;
  var_01 = 0.5;
  for(;;) {
    while(!self adsbuttonpressed()) {
      wait(0.05);
    }

    self _meth_81DE(var_00, var_01);
    while(self adsbuttonpressed()) {
      wait(0.05);
    }

    self _meth_81DE(65, var_01);
    wait(0.05);
  }
}

func_28C6(param_00, param_01, param_02, param_03, param_04) {
  var_05 = anglesToForward(level.player getplayerangles());
  var_06 = anglestoright(level.player getplayerangles());
  var_07 = anglestoup(level.player getplayerangles());
  var_08 = undefined;
  if(isDefined(param_00)) {
    var_08 = param_00;
  } else {
    var_08 = level.player getEye();
    var_08 = var_08 + var_06 * 5;
    var_08 = var_08 + var_07 * -5;
  }

  var_09 = undefined;
  if(isDefined(param_01)) {
    var_09 = param_01;
  } else {
    var_09 = level.player getEye();
    var_09 = var_09 + var_07 * -1;
  }

  var_0A = undefined;
  if(isDefined(param_02)) {
    var_0A = param_02;
  } else {
    var_0A = var_09 + var_05 * 99999;
  }

  var_0B = scripts\common\trace::ray_trace(var_09, var_0A, level.player);
  var_0C = var_0B;
  var_0A = var_0B["position"];
  var_0D = 20;
  var_0E = distance2d(var_09, var_0A);
  var_0F = int(var_0E / var_0D);
  if(var_0F > 100) {
    var_0F = 100;
  }

  var_10 = var_08;
  for(var_11 = 0; var_11 < var_0F; var_11++) {
    var_0B = bulletTrace(var_09, var_0A, 1, level.player);
    if(distance2d(var_10, var_0B["position"]) < var_0D) {
      break;
    }

    var_0A = var_0B["position"];
    var_12 = vectornormalize(var_0A - var_09);
    var_10 = var_10 + var_12 * var_0D;
    if(level.player.var_4BDD >= 500) {
      continue;
    }

    thread func_2A26();
    playFX(scripts\engine\utility::getfx("beam_rifle_beam"), var_10);
  }

  if(distance2d(var_0A, level.player.origin) > 56) {
    if(isDefined(var_0B["entity"]) && isDefined(var_0B["entity"].var_9D77)) {
      var_0B["entity"] notify("damage", 96, level.player, undefined, undefined, undefined, undefined, undefined, "j_head", undefined, "iw7_steeldragon");
    }

    var_13 = 75;
    if(isDefined(param_04)) {
      var_13 = param_04;
    }

    radiusdamage(var_0B["position"], 56, var_13, var_13, level.player, "MOD_EXPLOSIVE", "iw7_steeldragon");
  }

  if(isDefined(var_0B["surfacetype"]) && level.player.var_4BDD < 500) {
    var_14 = vectortoangles(var_0C["normal"]);
    playFX(scripts\engine\utility::getfx("beam_rifle_decal"), var_0C["position"], anglesToForward(var_14), anglestoup(var_14));
    if(isDefined(var_0B["entity"]) || var_0B["surfacetype"] == "surftype_default") {
      if(!isDefined(param_03)) {
        level.var_EFFE = 0.75;
      }

      if(isDefined(var_0B["entity"])) {
        return;
      }

      playFX(scripts\engine\utility::getfx("beam_rifle_smoke"), var_0C["position"]);
      return;
    }

    if(!isDefined(param_03)) {
      level.var_EFFE = 0.5625;
    }

    if(scripts\engine\utility::cointoss()) {
      playFX(scripts\engine\utility::getfx("beam_rifle_smoke"), var_0C["position"]);
      return;
    }

    return;
  }

  if(!isDefined(param_03)) {
    level.var_EFFE = 0.5625;
  }
}

func_2A26() {
  level.player.var_4BDD++;
  wait(0.25);
  level.player.var_4BDD--;
}

func_2A27(param_00) {
  self endon("weapon_change");
  self endon("weapon_dropped");
  level.var_EFFE = 0.75;
  for(;;) {
    self waittill("beam_rifle_fire");
    while(self.var_2A2A) {
      var_01 = self.var_2A23 - level.var_EFFE;
      func_2A34(var_01);
      wait(0.05);
    }

    thread func_2A31(param_00);
  }
}

func_2A31(param_00) {
  self endon("beam_rifle_fire");
  wait(1);
  for(;;) {
    var_01 = self.var_2A23 + 0.08;
    func_2A34(var_01);
    if(var_01 >= 100) {
      break;
    }

    wait(0.05);
  }

  thread scripts\sp\utility::play_sound_on_entity("weap_steeldragon_charged");
}

func_2A24() {
  var_00 = scripts\engine\utility::getstructarray("steel_dragon_ammo", "targetname");
  foreach(var_02 in var_00) {
    var_03 = var_02 scripts\engine\utility::spawn_tag_origin();
    thread func_2A25(var_03);
  }
}

func_2A25(param_00) {
  playFXOnTag(scripts\engine\utility::getfx("beam_rifle_ammo"), param_00, "tag_origin");
  var_01 = spawn("trigger_radius", param_00.origin, 0, 56, 56);
  for(;;) {
    var_01 waittill("trigger");
    if(!scripts\engine\utility::array_contains(level.player getweaponslistprimaries(), "steel_dragon")) {
      continue;
    }

    if(self.var_2A23 >= 100) {
      continue;
    }

    break;
  }

  var_02 = self.var_2A23 + 15;
  func_2A34(var_02);
  playworldsound("weap_ammo_pickup", param_00.origin);
  var_01 delete();
  param_00 delete();
}

func_2A34(param_00) {
  if(param_00 > 100) {
    param_00 = 100;
  } else if(param_00 <= 0) {
    param_00 = 0;
  }

  if(param_00 == 0) {
    self.var_2A2E = 1;
  } else {
    self.var_2A2E = 0;
  }

  self.var_2A23 = param_00;
  var_01 = self.var_2A23 / 100;
  if(isDefined(self.var_2A2B)) {
    self.var_2A2B["energyBar"] scripts\sp\hud_util::updatebar(var_01);
    self.var_2A2B["ammo"] settext(int(self.var_2A23));
  }
}

func_2A32() {
  if(!isDefined(self.subclass)) {
    return;
  }

  if(self.subclass != "C6") {
    return;
  }

  self waittill("death", var_00, var_01, var_02);
  if(!isDefined(var_02) || var_02 != "iw7_steeldragon") {
    return;
  }

  playworldsound("frag_grenade_explode", self.origin);
  playFX(scripts\engine\utility::getfx("beam_rifle_robot_explosion"), self gettagorigin("j_SpineUpper"));
}