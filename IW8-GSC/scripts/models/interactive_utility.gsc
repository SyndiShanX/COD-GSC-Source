/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\models\interactive_utility.gsc
**************************************************/

function array_sortbyarray(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, 0, var0[0]);
}

function array_sortbysorter(var0) {
  var1 = [];
  GscBinSkip0(0x2e, 0, var0[0]);
}

function wait_then_fn(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");

  if(isDefined(var1)) {
    if(isarray(var1)) {
      foreach(var8 in var1) {
        self endon(var8);
      }
    } else {
      self endon(var1);
    }
  }

  if(isstring(var0)) {
    self waittill(var0);
  } else {
    wait var0;
  }

  if(isDefined(var6)) {
    self[[var2]](var3, var4, var5, var6);
    return;
  }

  if(isDefined(var5)) {
    self[[var2]](var3, var4, var5);
    return;
  }

  if(isDefined(var4)) {
    self[[var2]](var3, var4);
    return;
  }

  if(isDefined(var3)) {
    self[[var2]](var3);
    return;
  }

  self[[var2]]();
}

function waittill_notify(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = 0;
  }

  for(var5 = 1; var5; var5 = var4) {
    self endon("death");

    if(isDefined(var3)) {
      self endon(var3);
    }

    self waittill(var0);
    var1 notify(var2);
  }
}

function loop_anim(var0, var1, var2, var3) {
  self endon("death");
  jumpiffalse(isDefined(var2)) LOC_00000015;
  self endon(var2);

  for(;;) {
    var4 = single_anim(var0, var1, "loop_anim", 0, var3);

    if(scripts\common\utility::issp()) {
      self waittillmatch("loop_anim", "end");
      continue;
    }

    wait getanimlength(var4);
  }
}

function single_anim(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = "single_anim";
  }

  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(isarray(var0[var1])) {
    jumpiftrue(isDefined(var0[var1 + "weight"])) LOC_00000076;
    var0 = [];
    var5 = getarraykeys(var0[var1]);

    foreach(var7 in var5) {
      var0[var7] = 1;
    }

    var9 = var0[var1].size;
    var10 = 0;

    for(var11 = 0; var11 < var9; var11++) {
      var10 += var0[var1 + "weight"][var11];
    }

    var12 = randomfloat(var10);
    var13 = 0;
    var14 = -1;

    while(var13 <= var12) {
      var14++;
      var13 += var0[var1 + "weight"][var14];
    }

    var15 = var0[var1][var14];

    if(isDefined(var0[var1 + "mp"])) {
      var16 = var0[var1 + "mp"][var14];
    } else {
      var16 = undefined;
    }
  } else {
    var15 = var2[var3];
    var16 = var2[var3 + "mp"];
  }

  if(scripts\common\utility::issp()) {
    if(isDefined(var15) && var15) {
      self builtin[[level.func["setflaggedanimknobrestart"]]](var4, var15, 1, 0.1, var16);
    } else {
      self builtin[[level.func["setflaggedanimknob"]]](var4, var15, 1, 0.1, var16);
    }
  } else {
    self builtin[[level.func["scriptModelPlayAnim"]]](var16);
  }

  return var15;
}

function blendanimsbyspeed(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = 0.1;
  }

  var0 = clamp(var0, var2[0], var2[var2.size - 1]);

  for(var5 = 0; var0 > var2[var5 + 1]; var5++) {}

  var6 = var0 - var2[var5];
  var6 /= var2[var5 + 1] - var2[var5];

  if(scripts\common\utility::issp()) {
    var6 = clamp(var6, 0.01, 0.99);
    var7 = var3[var5 + 1] / var3[var5];
    var8 = var6 + (1 - var6) * var7;
    self builtin[[level.func["setanimlimited"]]](var1[var5], 1 - var6, var4, var8 / var7);
    self builtin[[level.func["setanimlimited"]]](var1[var5 + 1], var6, var4, var8);

    for(var9 = 0; var9 < var5; var9++) {
      var7 = var3[var5 + 1] / var3[var9];
      self builtin[[level.func["setanimlimited"]]](var1[var9], 0.01, var4, var8 / var7);
    }

    for(var9 = var5 + 2; var9 < var2.size; var9++) {
      var7 = var3[var5 + 1] / var3[var9];
      self builtin[[level.func["setanimlimited"]]](var1[var9], 0.01, var4, var8 / var7);
    }

    return;
  }

  if(var6 > 0.5) {
    self builtin[[level.func["scriptModelPlayAnim"]]](var1[var5 + 1]);
    return;
  }

  self builtin[[level.func["scriptModelPlayAnim"]]](var1[var5]);
}

function detect_events(var0) {
  if(scripts\common\utility::issp()) {
    self endon("death");
    self endon("damage");
    self builtin[[level.func["makeEntitySentient"]]]("neutral");
    self builtin[[level.addaieventlistener_func]]("projectile_impact");
    self builtin[[level.addaieventlistener_func]]("bulletwhizby");
    self builtin[[level.addaieventlistener_func]]("gunshot");
    self builtin[[level.addaieventlistener_func]]("explode");

    for(;;) {
      self waittill("ai_events");
      self notify(var0);
      self.interrupted = 1;
      waittillframeend();
      self.interrupted = 0;
    }

    return;
  }
}

function detect_people(var0, var1, var2) {
  if(!isarray(var2)) {
    var3 = var2;
    var2 = [];
    var2 = var3;
  }

  foreach(var5 in var2) {
    self endon(var5);
  }

  self.detect_people_trigger[var1] = spawn("trigger_radius", self.origin, 23, var0, var0);

  for(var7 = var2.size; var7 < 3; var7++) {
    var2[var7] = undefined;
  }

  thread scripts\engine\utility::delete_on_notify(self.detect_people_trigger[var1], var2[0], var2[1], var2[2]);

  for(;;) {
    self.detect_people_trigger[var1] waittill("trigger", var8);
    self.interruptedent = var8;
    self notify(var1);
    self.interrupted = 1;
    waittillframeend();
    self.interrupted = 0;
  }
}

function detect_player_event(var0, var1, var2, var3) {
  if(!isarray(var2)) {
    var4 = var2;
    var2 = [];
    var2 = var4;
  }

  foreach(var6 in var2) {
    self endon(var6);
  }

  for(;;) {
    level.player waittill(var3);

    if(distancesquared(level.player.origin, self.origin) < var0 * var0) {
      self notify(var1);
      self.interruptedent = level.player;
      self notify(var1);
      self.interrupted = 1;
      waittillframeend();
      self.interrupted = 0;
    }
  }
}

function wrap(var0, var1) {
  var2 = int(var0 / var1);
  var3 = var0 - var1 * var2;

  if(var0 < 0) {
    var3 += var1;
  }

  if(var3 == var1) {
    var3 = 0;
  }

  return var3;
}

function interactives_drawdebuglinefortime(var0, var1, var2, var3, var4, var5) {}

function drawcross(var0, var1, var2, var3) {
  thread scripts\engine\utility::draw_line_for_time(var0 - (var1, 0, 0), var0 + (var1, 0, 0), var2[0], var2[1], var2[2], var3);
  thread scripts\engine\utility::draw_line_for_time(var0 - (0, var1, 0), var0 + (0, var1, 0), var2[0], var2[1], var2[2], var3);
  thread scripts\engine\utility::draw_line_for_time(var0 - (0, 0, var1), var0 + (0, 0, var1), var2[0], var2[1], var2[2], var3);
}

function drawcircle(var0, var1, var2, var3) {
  var4 = 16;
  var5 = 0;

  while(var5 < 360) {
    var6 = var5 + 360 / var4;
    thread scripts\engine\utility::draw_line_for_time(var0 + (var1 * cos(var5), var1 * sin(var5), 0), var0 + (var1 * cos(var6), var1 * sin(var6), 0), var2[0], var2[1], var2[2], var3);
    var5 += 360 / var4;
  }
}

function drawcirculararrow(var0, var1, var2, var3, var4) {
  if(var4 == 0) {
    return;
  }

  var5 = 16;
  var6 = int(1 + var5 * abs(var4) / 360);

  for(var7 = 0; var7 < var6; var7++) {
    var8 = var7 * var4 / var6;
    var9 = var8 + var4 / var6;
    thread scripts\engine\utility::draw_line_for_time(var0 + (var1 * cos(var8), var1 * sin(var8), 0), var0 + (var1 * cos(var9), var1 * sin(var9), 0), var2[0], var2[1], var2[2], var3);
  }

  var8 = var4;
  var9 = var4 - scripts\engine\utility::sign(var4) * 20;
  thread scripts\engine\utility::draw_line_for_time(var0 + (var1 * cos(var8), var1 * sin(var8), 0), var0 + (var1 * 0.8 * cos(var9), var1 * 0.8 * sin(var9), 0), var2[0], var2[1], var2[2], var3);
  thread scripts\engine\utility::draw_line_for_time(var0 + (var1 * cos(var8), var1 * sin(var8), 0), var0 + (var1 * 1.2 * cos(var9), var1 * 1.2 * sin(var9), 0), var2[0], var2[1], var2[2], var3);
}

function isinarray(var0, var1) {
  foreach(var3 in var1) {
    if(var0 == var3) {
      return true;
    }
  }

  return false;
}

function newtonsmethod(var0, var1, var2, var3, var4, var5, var6) {
  var7 = 5;
  var8 = (var0 + var1) / 2;
  var9 = var6 + 1;

  while(abs(var9) > var6 && var7 > 0) {
    var10 = var2 * var8 * var8 * var8 + var3 * var8 * var8 + var4 * var8 + var5;
    var11 = 3 * var2 * var8 * var8 + 2 * var3 * var8 + var4;
    var9 = -1 * var10 / var11;
    var12 = var8;
    var8 += var9;

    if(var8 > var1) {
      var8 = (var12 + 3 * var1) / 4;
    } else if(var8 < var0) {
      var8 = (var12 + 3 * var0) / 4;
    }

    var7--;
  }

  return var8;
}

function rootsofcubic(var0, var1, var2, var3) {
  if(var0 == 0) {
    return rootsofquadratic(var1, var2, var3);
  }

  var4 = 2 * var1 * var1 * var1 - 9 * var0 * var1 * var2 + 27 * var0 * var0 * var3;
  var5 = var1 * var1 - 3 * var0 * var2;

  if(var5 == 0) {}

  if(var4 == 0 && var5 == 0) {
    GscBinSkip1(0x45, 0, -1 * var1 / 3 * var0);
  }

  if(var4 == 0 && var5 != 0) {
    GscBinSkip1(0x45, 0, (9 * var0 * var0 * var3 - 4 * var0 * var1 * var2 + var1 * var1 * var1) / var0 * (3 * var0 * var2 - var1 * var1));
  }
}

function rootsofquadratic(var0, var1, var2) {
  while(abs(var0) > 65536 || abs(var1) > 65536 || abs(var2) > 65536) {
    var0 /= 10;
    var1 /= 10;
    var2 /= 10;
  }

  var3 = [];

  if(var0 == 0) {
    if(var1 != 0) {
      GscBinSkip0(0x2e, 0, -1 * var2 / var1);
    }
  } else {
    var4 = var1 * var1 - 4 * var0 * var2;

    if(var4 > 0) {
      var3 = (-1 * var1 - sqrt(var4)) / 2 * var0;
      var3 = (-1 * var1 + sqrt(var4)) / 2 * var0;
    } else if(var4 == 0) {
      var3 = -1 * var1 / 2 * var0;
    }
  }

  return var3;
}

function nonvectorlength(var0, var1) {
  var2 = 0;

  for(var3 = 0; var3 < var0.size; var3++) {
    var4 = var0[var3];

    if(isDefined(var1)) {
      var4 -= var1[var3];
    }

    var2 += var4 * var4;
  }

  return sqrt(var2);
}

function clampandnormalize(var0, var1, var2) {
  if(var1 < var2) {
    var0 = clamp(var0, var1, var2);
  } else {
    var0 = clamp(var0, var2, var1);
  }

  return (var0 - var1) / (var2 - var1);
}

function pointoncircle(var0, var1, var2) {
  var3 = cos(var2);
  var3 *= var1;
  var3 += var0[0];
  var4 = sin(var2);
  var4 *= var1;
  var4 += var0[1];
  var5 = var0[2];
  return (var3, var4, var5);
}

function zerocomponent(var0, var1) {
  return (var0[0] * (var1 != 0), var0[1] * (var1 != 1), var0[2] * (var1 != 2));
}

function rotate90aroundaxis(var0, var1) {
  if(var1 == 0) {
    return (var0[0], var0[2], -1 * var0[1]);
  }

  if(var1 == 1) {
    return (-1 * var0[2], var0[1], var0[0]);
  }

  return (var0[1], -1 * var0[0], var0[2]);
}