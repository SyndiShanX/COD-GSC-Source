/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3636.gsc
*********************************************/

func_2A2D() {
  func_2A30();
  level.player.var_2A23 = 100;
  level.player.var_2A2E = 0;
  level.player.var_4BDD = 0;
  var_0 = getspawnerteamarray("axis");
  scripts\sp\utility::func_22C7(var_0, ::func_2A32);
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
  var_0 = 0.35;
  for(;;) {
    scripts\engine\utility::waittill_any("weapon_change", "weapon_dropped");
    if(issubstr(level.player getcurrentweapon(), "iw7_steeldragon")) {
      scripts\engine\utility::waitframe();
      self allowfire(0);
      var_1 = func_2A2B();
      var_2 = gettime();
      var_3 = 0;
      while(gettime() - var_2 < var_0 * 1000) {
        if(!issubstr(level.player getcurrentweapon(), "iw7_steeldragon")) {
          var_3 = 1;
          break;
        }

        wait(0.05);
      }

      var_0 = 1.4;
      if(!var_3) {
        func_2A33(var_1);
      }

      func_2A2C(var_1);
      self allowfire(1);
    }
  }
}

func_2A2B() {
  setDvar("hideHudFast", 1);
  setomnvar("ui_hide_weapon_info", 1);
  var_0 = [];
  var_1 = scripts\sp\hud_util::func_499B("alien_icon_craft_battery", 15, 15);
  var_1 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 290, 194);
  var_0["battery"] = var_1;
  var_2 = scripts\sp\hud_util::createfontstring("objective", 1);
  var_2 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 310, 194);
  var_0["ammo"] = var_2;
  var_3 = scripts\sp\hud_util::func_4997("white", "black", 104, 6);
  var_3 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 305, 203);
  var_3.bar.alpha = 1;
  var_3.bar.color = (1, 0, 0);
  var_0["energyBar"] = var_3;
  self.var_2A2B = var_0;
  func_2A34(self.var_2A23);
  return var_0;
}

func_2A2C(var_0) {
  setDvar("hideHudFast", 0);
  setsaveddvar("hud_showStance", 1);
  setomnvar("ui_hide_weapon_info", 0);
  foreach(var_2 in var_0) {
    if(isDefined(var_2.bar)) {
      var_2.bar destroy();
    }

    var_2 destroy();
  }

  self.var_2A2B = undefined;
}

func_2A33(var_0) {
  self endon("weapon_change");
  self endon("weapon_dropped");
  self.var_2A29 = 6000;
  self.var_2A2F = 0;
  thread func_2A27(var_0);
  for(;;) {
    self allowfire(0);
    if(!self attackButtonPressed()) {} else if(self issprinting()) {} else if(self issprintsliding()) {} else if(self ismeleeing()) {} else if(self isthrowinggrenade()) {} else if(self.var_9F47) {} else if(self.var_2A2F) {} else {
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

      while(self attackButtonPressed()) {
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
      self func_80A6();
      thread scripts\sp\utility::func_D2CA(0.05);
      scripts\engine\utility::delaythread(0.1, scripts\engine\utility::stop_loop_sound_on_entity, "weap_steeldragon_lp");
      if(self.var_2A2E) {
        scripts\sp\utility::play_sound_on_entity("weap_steeldragon_powerdown");
        var_1 = undefined;
        if(!isDefined(var_1)) {
          var_2 = undefined;
          var_3 = undefined;
          var_4 = self getweaponslistall();
          foreach(var_6 in var_4) {
            if(!scripts\sp\utility::isprimaryweapon(var_6)) {
              continue;
            }

            if(var_6 == "iw7_steeldragon") {
              continue;
            }

            var_7 = self getweaponammoclip(var_6) + self getweaponammostock(var_6);
            if(var_7 <= 0) {
              continue;
            }

            if(!isDefined(var_3)) {
              var_3 = var_6;
              var_2 = var_7;
              continue;
            }

            if(var_7 > var_2) {
              var_3 = var_6;
              var_2 = var_7;
            }
          }

          var_1 = var_3;
        }

        if(isDefined(var_1)) {
          self switchtoweapon(var_1);
        }
      } else {
        thread scripts\sp\utility::play_sound_on_entity("weap_steeldragon_off");
      }

      while(self attackButtonPressed()) {
        wait(0.05);
      }
    }

    wait(0.05);
  }
}

func_FC1E() {
  self endon("beam_rifle_off");
  wait(0.35);
  if(self attackButtonPressed()) {
    thread scripts\engine\utility::play_loop_sound_on_entity("weap_steeldragon_lp");
  }
}

func_2A22() {
  var_0 = 45;
  var_1 = 0.5;
  for(;;) {
    while(!self adsButtonPressed()) {
      wait(0.05);
    }

    self func_81DE(var_0, var_1);
    while(self adsButtonPressed()) {
      wait(0.05);
    }

    self func_81DE(65, var_1);
    wait(0.05);
  }
}

func_28C6(var_0, var_1, var_2, var_3, var_4) {
  var_5 = anglesToForward(level.player getplayerangles());
  var_6 = anglestoright(level.player getplayerangles());
  var_7 = anglestoup(level.player getplayerangles());
  var_8 = undefined;
  if(isDefined(var_0)) {
    var_8 = var_0;
  } else {
    var_8 = level.player getEye();
    var_8 = var_8 + var_6 * 5;
    var_8 = var_8 + var_7 * -5;
  }

  var_9 = undefined;
  if(isDefined(var_1)) {
    var_9 = var_1;
  } else {
    var_9 = level.player getEye();
    var_9 = var_9 + var_7 * -1;
  }

  var_10 = undefined;
  if(isDefined(var_2)) {
    var_10 = var_2;
  } else {
    var_10 = var_9 + var_5 * 99999;
  }

  var_11 = scripts\common\trace::ray_trace(var_9, var_10, level.player);
  var_12 = var_11;
  var_10 = var_11["position"];
  var_13 = 20;
  var_14 = distance2d(var_9, var_10);
  var_15 = int(var_14 / var_13);
  if(var_15 > 100) {
    var_15 = 100;
  }

  var_10 = var_8;
  for(var_11 = 0; var_11 < var_15; var_11++) {
    var_11 = bulletTrace(var_9, var_10, 1, level.player);
    if(distance2d(var_10, var_11["position"]) < var_13) {
      break;
    }

    var_10 = var_11["position"];
    var_12 = vectornormalize(var_10 - var_9);
    var_10 = var_10 + var_12 * var_13;
    if(level.player.var_4BDD >= 500) {
      continue;
    }

    thread func_2A26();
    playFX(scripts\engine\utility::getfx("beam_rifle_beam"), var_10);
  }

  if(distance2d(var_10, level.player.origin) > 56) {
    if(isDefined(var_11["entity"]) && isDefined(var_11["entity"].var_9D77)) {
      var_11["entity"] notify("damage", 96, level.player, undefined, undefined, undefined, undefined, undefined, "j_head", undefined, "iw7_steeldragon");
    }

    var_13 = 75;
    if(isDefined(var_4)) {
      var_13 = var_4;
    }

    radiusdamage(var_11["position"], 56, var_13, var_13, level.player, "MOD_EXPLOSIVE", "iw7_steeldragon");
  }

  if(isDefined(var_11["surfacetype"]) && level.player.var_4BDD < 500) {
    var_14 = vectortoangles(var_12["normal"]);
    playFX(scripts\engine\utility::getfx("beam_rifle_decal"), var_12["position"], anglesToForward(var_14), anglestoup(var_14));
    if(isDefined(var_11["entity"]) || var_11["surfacetype"] == "surftype_default") {
      if(!isDefined(var_3)) {
        level.var_EFFE = 0.75;
      }

      if(isDefined(var_11["entity"])) {
        return;
      }

      playFX(scripts\engine\utility::getfx("beam_rifle_smoke"), var_12["position"]);
      return;
    }

    if(!isDefined(var_3)) {
      level.var_EFFE = 0.5625;
    }

    if(scripts\engine\utility::cointoss()) {
      playFX(scripts\engine\utility::getfx("beam_rifle_smoke"), var_12["position"]);
      return;
    }

    return;
  }

  if(!isDefined(var_3)) {
    level.var_EFFE = 0.5625;
  }
}

func_2A26() {
  level.player.var_4BDD++;
  wait(0.25);
  level.player.var_4BDD--;
}

func_2A27(var_0) {
  self endon("weapon_change");
  self endon("weapon_dropped");
  level.var_EFFE = 0.75;
  for(;;) {
    self waittill("beam_rifle_fire");
    while(self.var_2A2A) {
      var_1 = self.var_2A23 - level.var_EFFE;
      func_2A34(var_1);
      wait(0.05);
    }

    thread func_2A31(var_0);
  }
}

func_2A31(var_0) {
  self endon("beam_rifle_fire");
  wait(1);
  for(;;) {
    var_1 = self.var_2A23 + 0.08;
    func_2A34(var_1);
    if(var_1 >= 100) {
      break;
    }

    wait(0.05);
  }

  thread scripts\sp\utility::play_sound_on_entity("weap_steeldragon_charged");
}

func_2A24() {
  var_0 = scripts\engine\utility::getStructArray("steel_dragon_ammo", "targetname");
  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
    thread func_2A25(var_3);
  }
}

func_2A25(var_0) {
  playFXOnTag(scripts\engine\utility::getfx("beam_rifle_ammo"), var_0, "tag_origin");
  var_1 = spawn("trigger_radius", var_0.origin, 0, 56, 56);
  for(;;) {
    var_1 waittill("trigger");
    if(!scripts\engine\utility::array_contains(level.player getweaponslistprimaries(), "steel_dragon")) {
      continue;
    }

    if(self.var_2A23 >= 100) {
      continue;
    }

    break;
  }

  var_2 = self.var_2A23 + 15;
  func_2A34(var_2);
  playworldsound("weap_ammo_pickup", var_0.origin);
  var_1 delete();
  var_0 delete();
}

func_2A34(var_0) {
  if(var_0 > 100) {
    var_0 = 100;
  } else if(var_0 <= 0) {
    var_0 = 0;
  }

  if(var_0 == 0) {
    self.var_2A2E = 1;
  } else {
    self.var_2A2E = 0;
  }

  self.var_2A23 = var_0;
  var_1 = self.var_2A23 / 100;
  if(isDefined(self.var_2A2B)) {
    self.var_2A2B["energyBar"] scripts\sp\hud_util::updatebar(var_1);
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

  self waittill("death", var_0, var_1, var_2);
  if(!isDefined(var_2) || var_2 != "iw7_steeldragon") {
    return;
  }

  playworldsound("frag_grenade_explode", self.origin);
  playFX(scripts\engine\utility::getfx("beam_rifle_robot_explosion"), self gettagorigin("j_SpineUpper"));
}