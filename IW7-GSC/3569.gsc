/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3569.gsc
************************/

func_BB80() {
  level._effect["mortarMount_path_fr"] = loadfx("vfx\iw7\_requests\mp\power\vfx_mortar_mount_trail_fr");
  level._effect["mortarMount_target_fr"] = loadfx("vfx\iw7\_requests\mp\power\vfx_mortar_mount_target_fr");
  level._effect["mortarMount_target_en"] = loadfx("vfx\iw7\_requests\mp\power\vfx_mortar_mount_target_en");
}

func_BB90() {
  self notify("mortarMount_set");
}

func_BB93() {
  self notify("mortarMount_unset");
  self unlink();
  self _meth_845E(0);
  self allowads(1);
  func_BB77();
  func_BB78();
  func_BB7A();
  func_BB79();
}

func_BB94() {
  if(!func_BB6F()) {
    waittillframeend;
    func_BB95(0);
    return;
  }

  self notify("mortarMount_activated");
  thread func_BB8C();
}

func_BB8C() {
  self endon("death");
  self endon("disconnect");
  self endon("mortarMount_unset");
  self notify("mortarMount_popIn");
  self.var_BB6E = spawnStruct();
  self.var_BB6E.isactive = 1;
  var_00 = rotatepointaroundvector(anglestoright(self.angles), anglesToForward(self.angles), 0);
  var_01 = vectortoangles(var_00);
  self _meth_845E(1);
  self allowads(0);
  self setplayerangles(var_01);
  var_02 = scripts\engine\utility::spawn_tag_origin(self.origin, var_01);
  thread func_BB82(var_02);
  var_03 = self getEye() - self.origin;
  self playerlinkto(var_02, "tag_origin", 0, 0, 0, 0, 0);
  func_BB71();
  func_BB72();
  func_BB74();
  func_BB73();
  thread func_BB70();
  thread func_BB8D();
  wait(0.25);
  self iprintlnbold("Fire at Will!");
  self playerlinkto(var_02, "tag_origin", 0, 90, 90, 20, 20);
  thread func_BB87();
  thread func_BB76();
  thread func_BB8A(var_02);
  thread func_BB89(var_02);
}

func_BB8E(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("mortarMount_unset");
  self notify("mortarMount_popOut");
  wait(0.1);
  self unlink();
  if(isDefined(param_00)) {
    param_00 delete();
  }

  self _meth_845E(0);
  self allowads(1);
  func_BB77();
  func_BB78();
  func_BB7A();
  func_BB79();
  self.var_BB6E = undefined;
  self notify("mortarMount_deactivated");
}

func_BB7B() {
  var_00 = func_BB7E();
  var_01 = func_BB7D(var_00);
  var_02 = -1089;
  var_03 = var_01[2] - var_00[2] - var_02 / 1.65;
  var_04 = (0, 0, 1);
  var_05 = var_03 * var_04;
  var_06 = distance2d(var_00, var_01) / 1.65;
  var_07 = vectornormalize((var_01[0] - var_00[0], var_01[1] - var_00[1], 0));
  var_08 = var_06 * var_07;
  var_09 = var_08 + var_05;
  var_0A = self launchgrenade("mortarmount_mp", var_00, var_09, 5);
  thread func_BB7C();
  thread func_BB88(var_0A);
  thread func_BB86(var_0A);
}

func_BB88(param_00) {
  self endon("disconnect");
  self endon("mortarMount_unset");
  param_00 waittill("missile_stuck");
  param_00 radiusdamage(param_00.origin, 64, 64, 300, self, "MOD_EXPLOSIVE", "mortarmount_mp");
  param_00 radiusdamage(param_00.origin, 128, 128, 300, self, "MOD_EXPLOSIVE", "mortarmount_mp");
  param_00 radiusdamage(param_00.origin, 256, 256, 135, self, "MOD_EXPLOSIVE", "mortarmount_mp");
  var_01 = undefined;
  if(level.teambased) {
    var_01 = scripts\mp\utility::getteamarray(scripts\mp\utility::getotherteam(self.team));
  } else {
    var_01 = level.characters;
  }

  var_01[var_01.size] = self;
  foreach(var_03 in var_01) {
    if(!isDefined(var_03) || !scripts\mp\utility::isreallyalive(var_03)) {
      continue;
    }

    var_04 = distancesquared(param_00.origin, var_03.origin);
    if(var_04 < 4096) {
      var_03 scripts\mp\shellshock::shellshockondamage("MOD_EXPLOSIVE", 300);
      continue;
    }

    if(var_04 < 300) {
      var_03 scripts\mp\shellshock::shellshockondamage("MOD_EXPLOSIVE", 300);
      continue;
    }

    if(var_04 < 135) {
      var_03 scripts\mp\shellshock::shellshockondamage("MOD_EXPLOSIVE", 300);
    }
  }

  param_00 detonate();
}

func_BB7E() {
  var_00 = self gettagorigin("j_shoulder_ri");
  var_00 = var_00 + anglesToForward(self.angles) * (0, 8, 20)[1];
  var_00 = var_00 + anglestoup(self.angles) * (0, 8, 20)[2];
  return var_00;
}

func_BB8A(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("mortarMount_unset");
  self endon("mortarMount_popOut");
  self endon("mortarMount_fireButtonPressed");
  var_01 = scripts\mp\powers::func_D735("power_mortarMount");
  self notifyonplayercommand("mortarMount_powerButtonPressed", var_01);
  self waittill("mortarMount_powerButtonPressed");
  func_BB95(0);
  thread func_BB8E(param_00);
}

func_BB89(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("mortarMount_unset");
  self endon("mortarMount_popOut");
  self notifyonplayercommand("mortarMount_fireButtonPressed", "+attack");
  self notifyonplayercommand("mortarMount_fireButtonPressed", "+attack_akimbo_accessible");
  self waittill("mortarMount_fireButtonPressed");
  func_BB7B();
  wait(0.1);
  func_BB95(1);
  thread func_BB8E(param_00);
}

func_BB6F() {
  return self isonground() && !self iswallrunning();
}

func_BB95(param_00) {
  self notify("powers_mortarMount_used", param_00);
}

func_BB72() {
  if(!isDefined(self.var_BB6E)) {
    return;
  }

  if(!isDefined(self.var_BB6E.var_10B5D)) {
    self setstance("crouch");
    scripts\engine\utility::allow_stances(0);
    scripts\engine\utility::allow_sprint(0);
    scripts\engine\utility::allow_prone(0);
    self.var_BB6E.var_10B5D = 1;
  }
}

func_BB78() {
  if(!isDefined(self.var_BB6E)) {
    return;
  }

  if(isDefined(self.var_BB6E.var_10B5D)) {
    self setstance("stand");
    scripts\engine\utility::allow_stances(1);
    scripts\engine\utility::allow_sprint(1);
    scripts\engine\utility::allow_prone(1);
    self.var_BB6E.var_10B5D = undefined;
  }
}

func_BB74() {
  if(!isDefined(self.var_BB6E)) {
    return;
  }

  if(!isDefined(self.var_BB6E.var_13C80)) {
    self allowfire(0);
    scripts\engine\utility::allow_weapon_switch(0);
    self allowmelee(0);
    self.var_BB6E.var_13C80 = 1;
  }
}

func_BB7A() {
  if(!isDefined(self.var_BB6E)) {
    return;
  }

  if(isDefined(self.var_BB6E.var_13C80)) {
    self allowfire(1);
    scripts\engine\utility::allow_weapon_switch(1);
    self allowmelee(1);
    self.var_BB6E.var_13C80 = undefined;
  }
}

func_BB71() {
  if(!isDefined(self.var_BB6E)) {
    return;
  }

  if(!isDefined(self.var_BB6E.var_D771)) {
    scripts\mp\powers::func_D729();
    self.var_BB6E.var_D771 = 1;
  }
}

func_BB77() {
  if(!isDefined(self.var_BB6E)) {
    return;
  }

  if(isDefined(self.var_BB6E.var_D771)) {
    scripts\mp\powers::func_D72F();
    self.var_BB6E.var_D771 = undefined;
  }
}

func_BB73() {
  if(!isDefined(self.var_BB6E)) {
    return;
  }

  if(!isDefined(self.var_BB6E.var_12F95)) {
    scripts\engine\utility::allow_usability(0);
    self.var_BB6E.var_12F95 = 1;
  }
}

func_BB79() {
  if(!isDefined(self.var_BB6E)) {
    return;
  }

  if(isDefined(self.var_BB6E.var_12F95)) {
    scripts\engine\utility::allow_usability(1);
    self.var_BB6E.var_12F95 = undefined;
  }
}

func_BB70() {
  self endon("disconnect");
  self endon("mortarMount_unset");
  self endon("mortarMount_deactivated");
  self waittill("death");
  func_BB78();
  func_BB7A();
  func_BB79();
  self.var_BB6E = undefined;
}

func_BB86(param_00) {
  param_00 endon("death");
  self waittill("disconnect");
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_BB82(param_00) {
  scripts\engine\utility::waittill_any_3("death", "disconnect", "mortarMount_unset", "mortarMount_deactivated");
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_BB81(param_00) {
  return isDefined(param_00.var_BB6E) && isDefined(param_00.var_BB6E.isactive);
}

func_BB87() {
  self endon("death");
  self endon("disconnect");
  self endon("mortarMount_unset");
  self endon("mortarMount_popOut");
  self endon("mortarMount_fireButtonPressed");
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  for(;;) {
    self.var_BB8B = func_BB7F(5, 0.1);
    var_00 = var_00 - 0.1;
    if(var_01 >= 0.05) {
      thread func_BB75();
      var_01 = var_01 - 0.05;
    }

    if(var_03 >= 0.1) {
      var_03 = var_03 - 0.1;
    }

    scripts\engine\utility::waitframe();
    var_00 = var_00 + 0.05;
    var_01 = var_01 + 0.05;
    var_03 = var_03 + 0.05;
  }
}

func_BB7D(param_00) {
  var_01 = anglesToForward(self getplayerangles(1));
  var_02 = param_00 + var_01 * 900;
  var_03 = angleclamp180(self getplayerangles()[0]);
  var_04 = 0 - var_03;
  if(var_04 > 0) {
    var_02 = var_02 + clamp(abs(var_04) / 20, 0, 1) * 2100 * var_01;
  } else if(var_04 < 0) {
    var_02 = var_02 - clamp(abs(var_04) / 20, 0, 1) * 640 * var_01;
  }

  return var_02;
}

func_BB7F(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_D648 = [];
  var_02.var_437E = 0;
  var_02.var_438B = (0, 0, 1);
  var_02.var_97CD = (0, 0, 1);
  var_03 = func_BB7E();
  var_04 = func_BB7D(var_03);
  var_05 = -1089;
  var_06 = var_04[2] - var_03[2] - var_05 / 1.65;
  var_07 = (0, 0, 1);
  var_08 = distance2d(var_03, var_04) / 1.65;
  var_09 = vectornormalize((var_04[0] - var_03[0], var_04[1] - var_03[1], 0));
  var_0A = 0;
  var_0B = var_03;
  var_0C = undefined;
  var_0D = physics_createcontents(["physicscontents_solid", "physicscontents_structural", "physicscontents_canshootclip", "physicscontents_missileclip"]);
  while(var_0A <= param_00 + param_01 && !var_02.var_437E) {
    var_0C = var_0B;
    var_05 = var_0A * var_0A * -800 / 2;
    var_0E = (0, 0, var_03[2]) + var_07 * var_06 * var_0A + var_05;
    var_0F = (var_03[0], var_03[1], 0) + var_09 * var_08 * var_0A;
    var_0B = var_0E + var_0F;
    var_10 = physics_raycast(var_0C, var_0B, var_0D, self, 0, "physicsquery_closest");
    if(isDefined(var_10) && var_10.size > 0) {
      var_0B = var_10[0]["position"];
      var_02.var_437E = 1;
      var_02.var_438B = var_10[0]["normal"];
    }

    var_02.var_D648[var_02.var_D648.size] = var_0B;
    var_0A = var_0A + param_01;
  }

  if(var_02.var_D648.size > 1) {
    var_11 = vectornormalize(var_02.var_D648[0] - var_02.var_D648[0]);
    var_02.var_97CD = vectortoangles(var_11);
  }

  return var_02;
}

func_BB8D() {
  self playlocalsound("heavy_siege_on_plr");
  self playsoundtoteam("heavy_siege_on_npc", "allies", self);
  self playsoundtoteam("heavy_siege_on_npc", "axis", self);
}

func_BB8F() {
  self playlocalsound("");
  self playsoundtoteam("", "allies", self);
  self playsoundtoteam("", "axis", self);
}

func_BB7C(param_00, param_01, param_02) {
  self playlocalsound("heavy_mortar_fire_plr");
  self playsoundtoteam("heavy_mortar_fire_npc", "axis", self);
  self playsoundtoteam("heavy_mortar_fire_npc", "allies", self);
  var_03 = self.var_BB8B.var_97CD;
}

func_BB75() {
  self endon("death");
  self endon("disconnect");
  self endon("mortarMount_unset");
  self endon("mortarMount_popOut");
  self endon("mortarMount_fireButtonPressed");
  var_00 = self.var_BB8B.var_D648;
  if(var_00.size < 2) {
    return;
  }

  var_01 = spawn("script_model", var_00[0]);
  var_01 setModel("tag_origin");
  thread func_BB92(var_01);
  scripts\engine\utility::waitframe();
  playfxontagforclients(scripts\engine\utility::getfx("mortarMount_path_fr"), var_01, "tag_origin", self);
  var_02 = 0;
  for(var_03 = var_02 + 1; var_03 < var_00.size; var_03++) {
    var_04 = length(var_00[var_03] - var_00[var_02]);
    var_05 = var_04 / 1000;
    var_01 moveto(var_00[var_03], max(var_05, 0.05));
    wait(var_05);
    var_02++;
  }

  if(isDefined(var_01)) {
    killfxontag(scripts\engine\utility::getfx("mortarMount_path_fr"), var_01, "tag_origin");
    var_01 delete();
  }
}

func_BB76() {
  self endon("death");
  self endon("disconnect");
  self endon("mortarMount_unset");
  self endon("mortarMount_popOut");
  self endon("mortarMount_fireButtonPressed");
  var_00 = spawn("script_model", (0, 0, 0));
  var_00 setModel("tag_origin");
  thread func_BB91(var_00);
  scripts\engine\utility::waitframe();
  var_01 = 1;
  for(;;) {
    var_02 = self.var_BB8B;
    if(isDefined(var_02)) {
      if(var_02.var_437E) {
        if(var_01) {
          var_00 show();
          var_01 = 0;
          playfxontagforteam(scripts\engine\utility::getfx("mortarMount_target_fr"), var_00, "tag_origin", self.team);
          playfxontagforteam(scripts\engine\utility::getfx("mortarMount_target_en"), var_00, "tag_origin", scripts\mp\utility::getotherteam(self.team));
        }

        var_00.origin = var_02.var_D648[var_02.var_D648.size - 1];
        var_00.angles = vectortoangles(var_02.var_438B);
      } else if(!var_01) {
        var_00 hide();
        var_01 = 1;
        killfxontag(scripts\engine\utility::getfx("mortarMount_target_fr"), var_00, "tag_origin");
        killfxontag(scripts\engine\utility::getfx("mortarMount_target_en"), var_00, "tag_origin");
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_BB92(param_00) {
  param_00 endon("death");
  scripts\engine\utility::waittill_any_3("death", "disconnect", "mortarMount_unset", "mortarMount_popOut", "mortarMount_fireButtonPressed");
  if(isDefined(param_00)) {
    killfxontag(scripts\engine\utility::getfx("mortarMount_path_fr"), param_00, "tag_origin");
    param_00 delete();
  }
}

func_BB91(param_00) {
  param_00 endon("death");
  scripts\engine\utility::waittill_any_3("death", "disconnect", "mortarMount_unset", "mortarMount_popOut", "mortarMount_fireButtonPressed");
  if(isDefined(param_00)) {
    killfxontag(scripts\engine\utility::getfx("mortarMount_target_fr"), param_00, "tag_origin");
    killfxontag(scripts\engine\utility::getfx("mortarMount_target_en"), param_00, "tag_origin");
    param_00 delete();
  }
}