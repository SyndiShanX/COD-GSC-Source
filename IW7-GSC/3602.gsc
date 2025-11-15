/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3602.gsc
************************/

_meth_8543() {
  level thread _meth_8545();
}

_meth_8545() {
  for(;;) {
    level waittill("player_spawned", var_00);
    if(isai(var_00)) {
      continue;
    }
  }
}

_meth_8544() {}

_meth_8541() {
  self._meth_853E = 1;
  self iprintlnbold("gravWave");
  self radiusdamage(self.origin, 256, 50, 33, self, "MOD_EXPLOSIVE", "distortionfield_grenade_mp");
  thread codemoverequested();
  thread _meth_8540();
  return 1;
}

_meth_8546() {
  self endon("gravWave_end");
  self endon("death");
  for(;;) {
    self waittill("gravWaveHit", var_00);
    var_00 shellshock("concussion_grenade_mp", 1.5);
    var_00 thread func_2025();
  }
}

func_2025(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_01 = spawn("script_model", self.origin);
  var_01 setModel("tag_origin");
  thread func_ABFD(var_01, param_00);
  wait(3);
  var_02 = self getplayerangles(1);
  self setworldupreference(undefined);
  self unlink();
  var_01 delete();
  self notify("dropGravWave");
}

func_ABFD(param_00, param_01) {
  self endon("dropGravWave");
  self endon("death");
  self endon("disconnect");
  var_02 = func_2A96(param_00);
  var_03 = getcenterfrac();
  var_04 = self.origin;
  var_05 = anglestoup(self.angles);
  self _meth_84DC(var_05, 160);
  self shellshock("concussion_grenade_mp", 3, 0, 1);
  self notify("flashbang", self.origin, 1, 30, param_01, 1);
  param_00.origin = self.origin;
  param_00.angles = self.angles;
  if(param_00.var_10DD9[2] < var_04[2]) {
    param_00.var_10DD9 = self.origin + (0, 0, 12);
  }

  self playerlinkto(param_00);
  param_00 moveto(param_00.var_10DD9, 0.45, 0.1, 0.1);
  var_06 = 0;
  var_07 = int(var_02 / 2);
  var_08 = int(var_02 / 4);
  var_09 = int(var_08 * -1);
  wait(0.45);
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    var_0A = randomfloatrange(0.4, 0.7);
    if(self.origin[2] > param_00.var_10DD9[2] + var_07) {
      var_06 = randomintrange(var_09, 0);
    } else if(self.origin[2] < param_00.var_10DD9[2] - var_07) {
      var_06 = randomintrange(0, var_08);
    } else {
      var_06 = randomintrange(var_09, var_08);
    }

    var_0B = var_0A / 6;
    if(var_06 > 0) {
      var_0C = scripts\common\trace::player_trace_passed(self.origin, self.origin + (0, 0, var_06), self.angles, self, var_03, 12);
      if(var_0C) {
        param_00 movez(var_06, var_0A, var_0B, var_0B);
      }
    } else if(var_04[2] + 34 < self.origin[2] + var_06) {
      param_00 movez(var_06, var_0A, var_0B, var_0B);
    }

    wait(var_0A);
  }
}

func_2A96(param_00) {
  var_01 = getcenterfrac();
  var_02 = scripts\common\trace::player_trace(self.origin, self.origin + (0, 0, 256), self.angles, self, var_01, 0, 12);
  var_03 = var_02["position"] - (0, 0, 72);
  var_04 = var_02["position"] - (0, 0, 256);
  var_05 = scripts\common\trace::player_trace(var_03, var_04, self.angles, self, var_01, 0, 12);
  var_06 = var_02["position"][2] - var_05["position"][2];
  if(var_06 < 4) {
    var_06 = 4;
  }

  var_07 = var_06 / 2;
  var_07 = var_07 - 36;
  var_08 = self.origin + (0, 0, var_07);
  param_00.var_10DD9 = var_08;
  return var_06;
}

getcenterfrac() {
  var_00 = ["physicscontents_solid", "physicscontents_glass", "physicscontents_item", "physicscontents_clipshot", "physicscontents_actor", "physicscontents_playerclip", "physicscontents_fakeactor", "physicscontents_vehicle", "physicscontents_structural"];
  var_01 = physics_createcontents(var_00);
  return var_01;
}

func_20FE(param_00) {
  self endon("dropGravWave");
  self endon("death");
  var_01 = randomintrange(90, 270);
  self setorigin(param_00.origin);
  self setplayerangles(param_00.angles);
  self setworldupreference(param_00);
  var_02 = param_00.angles;
  var_02 = var_02 * (1, 1, 0);
  var_02 = var_02 + (0, 0, var_01);
  var_03 = 1.5;
  param_00 rotateto(var_02, var_03, 0.1, 0.1);
}

_meth_853F() {
  if(!isDefined(self)) {
    return;
  }

  self._meth_853E = 0;
  self setscriptablepartstate("gravWave", "gravwaveOff", 0);
  self notify("gravWave_end");
}

codemoverequested() {
  self endon("gravWave_end");
  scripts\engine\utility::waittill_any_3("death", "disconnect", "game_ended");
  thread _meth_853F();
}

func_9E17() {
  if(!isDefined(self._meth_853E)) {
    return 0;
  }

  return self._meth_853E;
}

_meth_8540() {
  self endon("disconnect");
  self endon("gravWave_end");
  self forceplaygestureviewmodel("ges_hold");
  self setscriptablepartstate("gravWave", "gravwaveOn", 0);
}