/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2813.gsc
**************************************/

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
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self.var_1468 = [];

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
  var_0 = gettime();

  for(;;) {
    self waittill("bulletwhizby", var_1, var_2);

    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_1)) {
      continue;
    }
    if(gettime() - var_0 > 190 && !scripts\mp\utility\game::isusingremote() && getDvar("scr_whizby_off") == "") {
      thread func_13D17(var_1);
      var_0 = gettime();
    }
  }
}

func_13D11() {
  scripts\engine\utility::waittill_any("death", "disconnect");

  foreach(var_1 in self.var_1468) {
    if(isalive(var_1)) {
      var_1 delete();
    }
  }
}

func_13D17(var_0) {
  var_1 = distance(var_0 getEye(), self getEye()) * 0.9;
  var_2 = var_0 getEye();
  var_3 = anglesToForward(var_0 func_857C());
  var_4 = var_2 + var_3 * var_1;
  var_5 = self getEye();
  var_6 = 2;
  var_7 = var_5[2] - var_4[2];

  if(abs(var_7) > 10) {
    var_6 = var_7 <= 0;
  }

  var_8 = 2;
  var_9 = anglesToForward(self.angles);
  var_10 = var_9;
  var_11 = var_4 - self getEye();
  var_10 = (var_10[0], var_10[1], 0);
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = scripts\engine\utility::anglebetweenvectorssigned(var_10, var_11, (0, 0, 1));

  if(abs(var_12) > 21 || 180.0 - abs(var_12) < 21) {
    var_8 = var_12 > 0;
  }

  var_13 = func_13D15(var_6, var_8);

  if(!isDefined(self.var_1468[var_13])) {
    if(isDefined(level._effect[var_13])) {
      self.var_1468[var_13] = spawnfxforclient(level._effect[var_13], self getEye(), self);
    }
  }

  triggerfx(self.var_1468[var_13]);
  self.var_1468[var_13] notify("reset");
  self.var_1468[var_13] thread func_13D19();
}

func_13D15(var_0, var_1) {
  var_2 = "whizzby";

  if(var_0 == 0) {
    var_2 = var_2 + "_bottom";
  } else if(var_0 == 1) {
    var_2 = var_2 + "_top";
  }

  if(var_1 == 0) {
    var_2 = var_2 + "_right";
  } else if(var_1 == 1) {
    var_2 = var_2 + "_left";
  }

  if(var_0 == 2 && var_1 == 2) {
    var_2 = var_2 + "_top";
  }

  return var_2;
}

func_13D12(var_0, var_1) {
  var_2 = var_0;

  if(var_1 == "left") {
    var_2 = var_2 + 90;
  }

  return var_2;
}

func_13D16(var_0) {
  return level.var_1467[var_0];
}

func_13D19() {
  self endon("reset");
  wait 0.75;
  self delete();
}