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
  var_0 = rotatepointaroundvector(anglestoright(self.angles), anglesToForward(self.angles), 0);
  var_1 = vectortoangles(var_0);
  self _meth_845E(1);
  self allowads(0);
  self setplayerangles(var_1);
  var_2 = scripts\engine\utility::spawn_tag_origin(self.origin, var_1);
  thread func_BB82(var_2);
  var_3 = self getEye() - self.origin;
  self playerlinkto(var_2, "tag_origin", 0, 0, 0, 0, 0);
  func_BB71();
  func_BB72();
  func_BB74();
  func_BB73();
  thread func_BB70();
  thread func_BB8D();
  wait(0.25);
  self iprintlnbold("Fire at Will!");
  self playerlinkto(var_2, "tag_origin", 0, 90, 90, 20, 20);
  thread func_BB87();
  thread func_BB76();
  thread func_BB8A(var_2);
  thread func_BB89(var_2);
}

func_BB8E(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("mortarMount_unset");
  self notify("mortarMount_popOut");
  wait(0.1);
  self unlink();
  if(isDefined(var_0)) {
    var_0 delete();
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
  var_0 = func_BB7E();
  var_1 = func_BB7D(var_0);
  var_2 = -1089;
  var_3 = var_1[2] - var_0[2] - var_2 / 1.65;
  var_4 = (0, 0, 1);
  var_5 = var_3 * var_4;
  var_6 = distance2d(var_0, var_1) / 1.65;
  var_7 = vectornormalize((var_1[0] - var_0[0], var_1[1] - var_0[1], 0));
  var_8 = var_6 * var_7;
  var_9 = var_8 + var_5;
  var_0A = self launchgrenade("mortarmount_mp", var_0, var_9, 5);
  thread func_BB7C();
  thread func_BB88(var_0A);
  thread func_BB86(var_0A);
}

func_BB88(var_0) {
  self endon("disconnect");
  self endon("mortarMount_unset");
  var_0 waittill("missile_stuck");
  var_0 radiusdamage(var_0.origin, 64, 64, 300, self, "MOD_EXPLOSIVE", "mortarmount_mp");
  var_0 radiusdamage(var_0.origin, 128, 128, 300, self, "MOD_EXPLOSIVE", "mortarmount_mp");
  var_0 radiusdamage(var_0.origin, 256, 256, 135, self, "MOD_EXPLOSIVE", "mortarmount_mp");
  var_1 = undefined;
  if(level.teambased) {
    var_1 = scripts\mp\utility::getteamarray(scripts\mp\utility::getotherteam(self.team));
  } else {
    var_1 = level.characters;
  }

  var_1[var_1.size] = self;
  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !scripts\mp\utility::isreallyalive(var_3)) {
      continue;
    }

    var_4 = distancesquared(var_0.origin, var_3.origin);
    if(var_4 < 4096) {
      var_3 scripts\mp\shellshock::shellshockondamage("MOD_EXPLOSIVE", 300);
      continue;
    }

    if(var_4 < 300) {
      var_3 scripts\mp\shellshock::shellshockondamage("MOD_EXPLOSIVE", 300);
      continue;
    }

    if(var_4 < 135) {
      var_3 scripts\mp\shellshock::shellshockondamage("MOD_EXPLOSIVE", 300);
    }
  }

  var_0 detonate();
}

func_BB7E() {
  var_0 = self gettagorigin("j_shoulder_ri");
  var_0 = var_0 + anglesToForward(self.angles) * (0, 8, 20)[1];
  var_0 = var_0 + anglestoup(self.angles) * (0, 8, 20)[2];
  return var_0;
}

func_BB8A(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("mortarMount_unset");
  self endon("mortarMount_popOut");
  self endon("mortarMount_fireButtonPressed");
  var_1 = scripts\mp\powers::func_D735("power_mortarMount");
  self notifyonplayercommand("mortarMount_powerButtonPressed", var_1);
  self waittill("mortarMount_powerButtonPressed");
  func_BB95(0);
  thread func_BB8E(var_0);
}

func_BB89(var_0) {
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
  thread func_BB8E(var_0);
}

func_BB6F() {
  return self isonground() && !self iswallrunning();
}

func_BB95(var_0) {
  self notify("powers_mortarMount_used", var_0);
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

func_BB86(var_0) {
  var_0 endon("death");
  self waittill("disconnect");
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_BB82(var_0) {
  scripts\engine\utility::waittill_any_3("death", "disconnect", "mortarMount_unset", "mortarMount_deactivated");
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_BB81(var_0) {
  return isDefined(var_0.var_BB6E) && isDefined(var_0.var_BB6E.isactive);
}

func_BB87() {
  self endon("death");
  self endon("disconnect");
  self endon("mortarMount_unset");
  self endon("mortarMount_popOut");
  self endon("mortarMount_fireButtonPressed");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  for(;;) {
    self.var_BB8B = func_BB7F(5, 0.1);
    var_0 = var_0 - 0.1;
    if(var_1 >= 0.05) {
      thread func_BB75();
      var_1 = var_1 - 0.05;
    }

    if(var_3 >= 0.1) {
      var_3 = var_3 - 0.1;
    }

    scripts\engine\utility::waitframe();
    var_0 = var_0 + 0.05;
    var_1 = var_1 + 0.05;
    var_3 = var_3 + 0.05;
  }
}

func_BB7D(var_0) {
  var_1 = anglesToForward(self getplayerangles(1));
  var_2 = var_0 + var_1 * 900;
  var_3 = angleclamp180(self getplayerangles()[0]);
  var_4 = 0 - var_3;
  if(var_4 > 0) {
    var_2 = var_2 + clamp(abs(var_4) / 20, 0, 1) * 2100 * var_1;
  } else if(var_4 < 0) {
    var_2 = var_2 - clamp(abs(var_4) / 20, 0, 1) * 640 * var_1;
  }

  return var_2;
}

func_BB7F(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.var_D648 = [];
  var_2.var_437E = 0;
  var_2.var_438B = (0, 0, 1);
  var_2.var_97CD = (0, 0, 1);
  var_3 = func_BB7E();
  var_4 = func_BB7D(var_3);
  var_5 = -1089;
  var_6 = var_4[2] - var_3[2] - var_5 / 1.65;
  var_7 = (0, 0, 1);
  var_8 = distance2d(var_3, var_4) / 1.65;
  var_9 = vectornormalize((var_4[0] - var_3[0], var_4[1] - var_3[1], 0));
  var_0A = 0;
  var_0B = var_3;
  var_0C = undefined;
  var_0D = physics_createcontents(["physicscontents_solid", "physicscontents_structural", "physicscontents_canshootclip", "physicscontents_missileclip"]);
  while(var_0A <= var_0 + var_1 && !var_2.var_437E) {
    var_0C = var_0B;
    var_5 = var_0A * var_0A * -800 / 2;
    var_0E = (0, 0, var_3[2]) + var_7 * var_6 * var_0A + var_5;
    var_0F = (var_3[0], var_3[1], 0) + var_9 * var_8 * var_0A;
    var_0B = var_0E + var_0F;
    var_10 = physics_raycast(var_0C, var_0B, var_0D, self, 0, "physicsquery_closest");
    if(isDefined(var_10) && var_10.size > 0) {
      var_0B = var_10[0]["position"];
      var_2.var_437E = 1;
      var_2.var_438B = var_10[0]["normal"];
    }

    var_2.var_D648[var_2.var_D648.size] = var_0B;
    var_0A = var_0A + var_1;
  }

  if(var_2.var_D648.size > 1) {
    var_11 = vectornormalize(var_2.var_D648[0] - var_2.var_D648[0]);
    var_2.var_97CD = vectortoangles(var_11);
  }

  return var_2;
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

func_BB7C(var_0, var_1, var_2) {
  self playlocalsound("heavy_mortar_fire_plr");
  self playsoundtoteam("heavy_mortar_fire_npc", "axis", self);
  self playsoundtoteam("heavy_mortar_fire_npc", "allies", self);
  var_3 = self.var_BB8B.var_97CD;
}

func_BB75() {
  self endon("death");
  self endon("disconnect");
  self endon("mortarMount_unset");
  self endon("mortarMount_popOut");
  self endon("mortarMount_fireButtonPressed");
  var_0 = self.var_BB8B.var_D648;
  if(var_0.size < 2) {
    return;
  }

  var_1 = spawn("script_model", var_0[0]);
  var_1 setModel("tag_origin");
  thread func_BB92(var_1);
  scripts\engine\utility::waitframe();
  playfxontagforclients(scripts\engine\utility::getfx("mortarMount_path_fr"), var_1, "tag_origin", self);
  var_2 = 0;
  for(var_3 = var_2 + 1; var_3 < var_0.size; var_3++) {
    var_4 = length(var_0[var_3] - var_0[var_2]);
    var_5 = var_4 / 1000;
    var_1 moveto(var_0[var_3], max(var_5, 0.05));
    wait(var_5);
    var_2++;
  }

  if(isDefined(var_1)) {
    killfxontag(scripts\engine\utility::getfx("mortarMount_path_fr"), var_1, "tag_origin");
    var_1 delete();
  }
}

func_BB76() {
  self endon("death");
  self endon("disconnect");
  self endon("mortarMount_unset");
  self endon("mortarMount_popOut");
  self endon("mortarMount_fireButtonPressed");
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  thread func_BB91(var_0);
  scripts\engine\utility::waitframe();
  var_1 = 1;
  for(;;) {
    var_2 = self.var_BB8B;
    if(isDefined(var_2)) {
      if(var_2.var_437E) {
        if(var_1) {
          var_0 show();
          var_1 = 0;
          playfxontagforteam(scripts\engine\utility::getfx("mortarMount_target_fr"), var_0, "tag_origin", self.team);
          playfxontagforteam(scripts\engine\utility::getfx("mortarMount_target_en"), var_0, "tag_origin", scripts\mp\utility::getotherteam(self.team));
        }

        var_0.origin = var_2.var_D648[var_2.var_D648.size - 1];
        var_0.angles = vectortoangles(var_2.var_438B);
      } else if(!var_1) {
        var_0 hide();
        var_1 = 1;
        killfxontag(scripts\engine\utility::getfx("mortarMount_target_fr"), var_0, "tag_origin");
        killfxontag(scripts\engine\utility::getfx("mortarMount_target_en"), var_0, "tag_origin");
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_BB92(var_0) {
  var_0 endon("death");
  scripts\engine\utility::waittill_any_3("death", "disconnect", "mortarMount_unset", "mortarMount_popOut", "mortarMount_fireButtonPressed");
  if(isDefined(var_0)) {
    killfxontag(scripts\engine\utility::getfx("mortarMount_path_fr"), var_0, "tag_origin");
    var_0 delete();
  }
}

func_BB91(var_0) {
  var_0 endon("death");
  scripts\engine\utility::waittill_any_3("death", "disconnect", "mortarMount_unset", "mortarMount_popOut", "mortarMount_fireButtonPressed");
  if(isDefined(var_0)) {
    killfxontag(scripts\engine\utility::getfx("mortarMount_target_fr"), var_0, "tag_origin");
    killfxontag(scripts\engine\utility::getfx("mortarMount_target_en"), var_0, "tag_origin");
    var_0 delete();
  }
}