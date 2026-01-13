/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3602.gsc
*********************************************/

_meth_8543() {
  level thread _meth_8545();
}

_meth_8545() {
  for(;;) {
    level waittill("player_spawned", var_0);
    if(isai(var_0)) {
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
    self waittill("gravWaveHit", var_0);
    var_0 shellshock("concussion_grenade_mp", 1.5);
    var_0 thread func_2025();
  }
}

func_2025(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  thread func_ABFD(var_1, var_0);
  wait(3);
  var_2 = self getplayerangles(1);
  self setworldupreference(undefined);
  self unlink();
  var_1 delete();
  self notify("dropGravWave");
}

func_ABFD(var_0, var_1) {
  self endon("dropGravWave");
  self endon("death");
  self endon("disconnect");
  var_2 = func_2A96(var_0);
  var_3 = getcenterfrac();
  var_4 = self.origin;
  var_5 = anglestoup(self.angles);
  self _meth_84DC(var_5, 160);
  self shellshock("concussion_grenade_mp", 3, 0, 1);
  self notify("flashbang", self.origin, 1, 30, var_1, 1);
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  if(var_0.var_10DD9[2] < var_4[2]) {
    var_0.var_10DD9 = self.origin + (0, 0, 12);
  }

  self playerlinkto(var_0);
  var_0 moveto(var_0.var_10DD9, 0.45, 0.1, 0.1);
  var_6 = 0;
  var_7 = int(var_2 / 2);
  var_8 = int(var_2 / 4);
  var_9 = int(var_8 * -1);
  wait(0.45);
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    var_0A = randomfloatrange(0.4, 0.7);
    if(self.origin[2] > var_0.var_10DD9[2] + var_7) {
      var_6 = randomintrange(var_9, 0);
    } else if(self.origin[2] < var_0.var_10DD9[2] - var_7) {
      var_6 = randomintrange(0, var_8);
    } else {
      var_6 = randomintrange(var_9, var_8);
    }

    var_0B = var_0A / 6;
    if(var_6 > 0) {
      var_0C = scripts\common\trace::player_trace_passed(self.origin, self.origin + (0, 0, var_6), self.angles, self, var_3, 12);
      if(var_0C) {
        var_0 movez(var_6, var_0A, var_0B, var_0B);
      }
    } else if(var_4[2] + 34 < self.origin[2] + var_6) {
      var_0 movez(var_6, var_0A, var_0B, var_0B);
    }

    wait(var_0A);
  }
}

func_2A96(var_0) {
  var_1 = getcenterfrac();
  var_2 = scripts\common\trace::player_trace(self.origin, self.origin + (0, 0, 256), self.angles, self, var_1, 0, 12);
  var_3 = var_2["position"] - (0, 0, 72);
  var_4 = var_2["position"] - (0, 0, 256);
  var_5 = scripts\common\trace::player_trace(var_3, var_4, self.angles, self, var_1, 0, 12);
  var_6 = var_2["position"][2] - var_5["position"][2];
  if(var_6 < 4) {
    var_6 = 4;
  }

  var_7 = var_6 / 2;
  var_7 = var_7 - 36;
  var_8 = self.origin + (0, 0, var_7);
  var_0.var_10DD9 = var_8;
  return var_6;
}

getcenterfrac() {
  var_0 = ["physicscontents_solid", "physicscontents_glass", "physicscontents_item", "physicscontents_clipshot", "physicscontents_actor", "physicscontents_playerclip", "physicscontents_fakeactor", "physicscontents_vehicle", "physicscontents_structural"];
  var_1 = physics_createcontents(var_0);
  return var_1;
}

func_20FE(var_0) {
  self endon("dropGravWave");
  self endon("death");
  var_1 = randomintrange(90, 270);
  self setorigin(var_0.origin);
  self setplayerangles(var_0.angles);
  self setworldupreference(var_0);
  var_2 = var_0.angles;
  var_2 = var_2 * (1, 1, 0);
  var_2 = var_2 + (0, 0, var_1);
  var_3 = 1.5;
  var_0 rotateto(var_2, var_3, 0.1, 0.1);
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