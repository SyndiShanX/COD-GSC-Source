/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2813.gsc
***************************************/

init() {
  level._effect["whizzby_left"] = loadfx("vfx\old\_requests\mp_gameplay\vfx_near_miss_edge_left.vfx");
  level._effect["whizzby_right"] = loadfx("vfx\old\_requests\mp_gameplay\vfx_near_miss_edge_right.vfx");
  level._effect["whizzby_top"] = loadfx("vfx\old\_requests\mp_gameplay\vfx_near_miss_edge_top.vfx");
  level._effect["whizzby_top_left"] = loadfx("vfx\old\_requests\mp_gameplay\vfx_near_miss_edge_top_left.vfx");
  level._effect["whizzby_top_right"] = loadfx("vfx\old\_requests\mp_gameplay\vfx_near_miss_edge_top_right.vfx");
  level._effect["whizzby_bottom"] = loadfx("vfx\old\_requests\mp_gameplay\vfx_near_miss_edge_bottom.vfx");
  level._effect["whizzby_bottom_left"] = loadfx("vfx\old\_requests\mp_gameplay\vfx_near_miss_edge_bottom_left.vfx");
  level._effect["whizzby_bottom_right"] = loadfx("vfx\old\_requests\mp_gameplay\vfx_near_miss_edge_bottom_right.vfx");
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread onplayerspawned();
  }
}

onplayerspawned() {
  self.func_1468 = [];

  for(;;) {
    self waittill("spawned_player");
    thread func_13D18();
    thread func_13D11();
  }
}

func_13D18() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  var_00 = gettime();

  for(;;) {
    self waittill("bulletwhizby", var_01, var_02);

    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_01)) {
      continue;
    }
    if(gettime() - var_00 > 190 && !scripts\mp\utility\game::isusingremote() && getdvar("scr_whizby_off") == "") {
      thread func_13D17(var_01);
      var_00 = gettime();
    }
  }
}

func_13D11() {
  scripts\engine\utility::waittill_any("death", "disconnect");

  foreach(var_01 in self.func_1468) {
    if(isalive(var_01)) {
      var_01 delete();
    }
  }
}

func_13D17(var_00) {
  var_01 = distance(var_00 getEye(), self getEye()) * 0.9;
  var_02 = var_00 getEye();
  var_03 = anglesToForward(var_00 _meth_857C());
  var_04 = var_02 + var_03 * var_01;
  var_05 = self getEye();
  var_06 = 2;
  var_07 = var_5[2] - var_4[2];

  if(abs(var_07) > 10) {
    var_06 = var_07 <= 0;
  }

  var_08 = 2;
  var_09 = anglesToForward(self.angles);
  var_10 = var_09;
  var_11 = var_04 - self getEye();
  var_10 = (var_10[0], var_10[1], 0);
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = scripts\engine\utility::anglebetweenvectorssigned(var_10, var_11, (0, 0, 1));

  if(abs(var_12) > 21 || 180.0 - abs(var_12) < 21) {
    var_08 = var_12 > 0;
  }

  var_13 = func_13D15(var_06, var_08);

  if(!isDefined(self.func_1468[var_13])) {
    if(isDefined(level._effect[var_13])) {
      self.func_1468[var_13] = spawnfxforclient(level._effect[var_13], self getEye(), self);
    } else {}
  }

  triggerfx(self.func_1468[var_13]);
  self.func_1468[var_13] notify("reset");
  self.func_1468[var_13] thread func_13D19();
}

func_13D15(var_00, var_01) {
  var_02 = "whizzby";

  if(var_00 == 0) {
    var_02 = var_02 + "_bottom";
  } else if(var_00 == 1) {
    var_02 = var_02 + "_top";
  }

  if(var_01 == 0) {
    var_02 = var_02 + "_right";
  } else if(var_01 == 1) {
    var_02 = var_02 + "_left";
  }

  if(var_00 == 2 && var_01 == 2) {
    var_02 = var_02 + "_top";
  }

  return var_02;
}

func_13D12(var_00, var_01) {
  var_02 = var_00;

  if(var_01 == "left") {
    var_02 = var_02 + 90;
  }

  return var_02;
}

func_13D16(var_00) {
  return level.func_1467[var_00];
}

func_13D19() {
  self endon("reset");
  wait 0.75;
  self delete();
}