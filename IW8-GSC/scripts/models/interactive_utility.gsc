/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\models\interactive_utility.gsc
**************************************************/

function array_sortbyarray(var_0, var_1) {
  var_2 = [];
  GscBinSkip0(0x2e, 0, var_0[0]);
}

function array_sortbysorter(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, 0, var_0[0]);
}

function wait_then_fn(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_8 in var_1) {
        self endon(var_8);
      }
    } else {
      self endon(var_1);
    }
  }

  if(isstring(var_0)) {
    self waittill(var_0);
  } else {
    wait var_0;
  }

  if(isDefined(var_6)) {
    self[[var_2]](var_3, var_4, var_5, var_6);
    return;
  }

  if(isDefined(var_5)) {
    self[[var_2]](var_3, var_4, var_5);
    return;
  }

  if(isDefined(var_4)) {
    self[[var_2]](var_3, var_4);
    return;
  }

  if(isDefined(var_3)) {
    self[[var_2]](var_3);
    return;
  }

  self[[var_2]]();
}

function waittill_notify(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  for(var_5 = 1; var_5; var_5 = var_4) {
    self endon("death");

    if(isDefined(var_3)) {
      self endon(var_3);
    }

    self waittill(var_0);
    var_1 notify(var_2);
  }
}

function loop_anim(var_0, var_1, var_2, var_3) {
  self endon("death");
  jumpiffalse(isDefined(var_2)) LOC_00000015;
  self endon(var_2);

  for(;;) {
    var_4 = single_anim(var_0, var_1, "loop_anim", 0, var_3);

    if(scripts\common\utility::issp()) {
      self waittillmatch("loop_anim", "end");
      continue;
    }

    wait getanimlength(var_4);
  }
}

function single_anim(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = "single_anim";
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(isarray(var_0[var_1])) {
    jumpiftrue(isDefined(var_0[var_1 + "weight"])) LOC_00000076;
    var_0 = [];
    var_5 = getarraykeys(var_0[var_1]);

    foreach(var_7 in var_5) {
      var_0[var_7] = 1;
    }

    var_9 = var_0[var_1].size;
    var_10 = 0;

    for(var_11 = 0; var_11 < var_9; var_11++) {
      var_10 += var_0[var_1 + "weight"][var_11];
    }

    var_12 = randomfloat(var_10);
    var_13 = 0;
    var_14 = -1;

    while(var_13 <= var_12) {
      var_14++;
      var_13 += var_0[var_1 + "weight"][var_14];
    }

    var_15 = var_0[var_1][var_14];

    if(isDefined(var_0[var_1 + "mp"])) {
      var_16 = var_0[var_1 + "mp"][var_14];
    } else {
      var_16 = undefined;
    }
  } else {
    var_15 = var_2[var_3];
    var_16 = var_2[var_3 + "mp"];
  }

  if(scripts\common\utility::issp()) {
    if(isDefined(var_15) && var_15) {
      self builtin[[level.func["setflaggedanimknobrestart"]]](var_4, var_15, 1, 0.1, var_16);
    } else {
      self builtin[[level.func["setflaggedanimknob"]]](var_4, var_15, 1, 0.1, var_16);
    }
  } else {
    self builtin[[level.func["scriptModelPlayAnim"]]](var_16);
  }

  return var_15;
}

function blendanimsbyspeed(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0.1;
  }

  var_0 = clamp(var_0, var_2[0], var_2[var_2.size - 1]);

  for(var_5 = 0; var_0 > var_2[var_5 + 1]; var_5++) {}

  var_6 = var_0 - var_2[var_5];
  var_6 /= var_2[var_5 + 1] - var_2[var_5];

  if(scripts\common\utility::issp()) {
    var_6 = clamp(var_6, 0.01, 0.99);
    var_7 = var_3[var_5 + 1] / var_3[var_5];
    var_8 = var_6 + (1 - var_6) * var_7;
    self builtin[[level.func["setanimlimited"]]](var_1[var_5], 1 - var_6, var_4, var_8 / var_7);
    self builtin[[level.func["setanimlimited"]]](var_1[var_5 + 1], var_6, var_4, var_8);

    for(var_9 = 0; var_9 < var_5; var_9++) {
      var_7 = var_3[var_5 + 1] / var_3[var_9];
      self builtin[[level.func["setanimlimited"]]](var_1[var_9], 0.01, var_4, var_8 / var_7);
    }

    for(var_9 = var_5 + 2; var_9 < var_2.size; var_9++) {
      var_7 = var_3[var_5 + 1] / var_3[var_9];
      self builtin[[level.func["setanimlimited"]]](var_1[var_9], 0.01, var_4, var_8 / var_7);
    }

    return;
  }

  if(var_6 > 0.5) {
    self builtin[[level.func["scriptModelPlayAnim"]]](var_1[var_5 + 1]);
    return;
  }

  self builtin[[level.func["scriptModelPlayAnim"]]](var_1[var_5]);
}

function detect_events(var_0) {
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
      self notify(var_0);
      self.interrupted = 1;
      waittillframeend();
      self.interrupted = 0;
    }

    return;
  }
}

function detect_people(var_0, var_1, var_2) {
  if(!isarray(var_2)) {
    var_3 = var_2;
    var_2 = [];
    var_2 = var_3;
  }

  foreach(var_5 in var_2) {
    self endon(var_5);
  }

  self.detect_people_trigger[var_1] = spawn("trigger_radius", self.origin, 23, var_0, var_0);

  for(var_7 = var_2.size; var_7 < 3; var_7++) {
    var_2[var_7] = undefined;
  }

  thread scripts\engine\utility::delete_on_notify(self.detect_people_trigger[var_1], var_2[0], var_2[1], var_2[2]);

  for(;;) {
    self.detect_people_trigger[var_1] waittill("trigger", var_8);
    self.interruptedent = var_8;
    self notify(var_1);
    self.interrupted = 1;
    waittillframeend();
    self.interrupted = 0;
  }
}

function detect_player_event(var_0, var_1, var_2, var_3) {
  if(!isarray(var_2)) {
    var_4 = var_2;
    var_2 = [];
    var_2 = var_4;
  }

  foreach(var_6 in var_2) {
    self endon(var_6);
  }

  for(;;) {
    level.player waittill(var_3);

    if(distancesquared(level.player.origin, self.origin) < var_0 * var_0) {
      self notify(var_1);
      self.interruptedent = level.player;
      self notify(var_1);
      self.interrupted = 1;
      waittillframeend();
      self.interrupted = 0;
    }
  }
}

function wrap(var_0, var_1) {
  var_2 = int(var_0 / var_1);
  var_3 = var_0 - var_1 * var_2;

  if(var_0 < 0) {
    var_3 += var_1;
  }

  if(var_3 == var_1) {
    var_3 = 0;
  }

  return var_3;
}

function interactives_drawdebuglinefortime(var_0, var_1, var_2, var_3, var_4, var_5) {}

function drawcross(var_0, var_1, var_2, var_3) {
  thread scripts\engine\utility::draw_line_for_time(var_0 - (var_1, 0, 0), var_0 + (var_1, 0, 0), var_2[0], var_2[1], var_2[2], var_3);
  thread scripts\engine\utility::draw_line_for_time(var_0 - (0, var_1, 0), var_0 + (0, var_1, 0), var_2[0], var_2[1], var_2[2], var_3);
  thread scripts\engine\utility::draw_line_for_time(var_0 - (0, 0, var_1), var_0 + (0, 0, var_1), var_2[0], var_2[1], var_2[2], var_3);
}

function drawcircle(var_0, var_1, var_2, var_3) {
  var_4 = 16;
  var_5 = 0;

  while(var_5 < 360) {
    var_6 = var_5 + 360 / var_4;
    thread scripts\engine\utility::draw_line_for_time(var_0 + (var_1 * cos(var_5), var_1 * sin(var_5), 0), var_0 + (var_1 * cos(var_6), var_1 * sin(var_6), 0), var_2[0], var_2[1], var_2[2], var_3);
    var_5 += 360 / var_4;
  }
}

function drawcirculararrow(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 == 0) {
    return;
  }

  var_5 = 16;
  var_6 = int(1 + var_5 * abs(var_4) / 360);

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_8 = var_7 * var_4 / var_6;
    var_9 = var_8 + var_4 / var_6;
    thread scripts\engine\utility::draw_line_for_time(var_0 + (var_1 * cos(var_8), var_1 * sin(var_8), 0), var_0 + (var_1 * cos(var_9), var_1 * sin(var_9), 0), var_2[0], var_2[1], var_2[2], var_3);
  }

  var_8 = var_4;
  var_9 = var_4 - scripts\engine\utility::sign(var_4) * 20;
  thread scripts\engine\utility::draw_line_for_time(var_0 + (var_1 * cos(var_8), var_1 * sin(var_8), 0), var_0 + (var_1 * 0.8 * cos(var_9), var_1 * 0.8 * sin(var_9), 0), var_2[0], var_2[1], var_2[2], var_3);
  thread scripts\engine\utility::draw_line_for_time(var_0 + (var_1 * cos(var_8), var_1 * sin(var_8), 0), var_0 + (var_1 * 1.2 * cos(var_9), var_1 * 1.2 * sin(var_9), 0), var_2[0], var_2[1], var_2[2], var_3);
}

function isinarray(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_0 == var_3) {
      return true;
    }
  }

  return false;
}

function newtonsmethod(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 5;
  var_8 = (var_0 + var_1) / 2;
  var_9 = var_6 + 1;

  while(abs(var_9) > var_6 && var_7 > 0) {
    var_10 = var_2 * var_8 * var_8 * var_8 + var_3 * var_8 * var_8 + var_4 * var_8 + var_5;
    var_11 = 3 * var_2 * var_8 * var_8 + 2 * var_3 * var_8 + var_4;
    var_9 = -1 * var_10 / var_11;
    var_12 = var_8;
    var_8 += var_9;

    if(var_8 > var_1) {
      var_8 = (var_12 + 3 * var_1) / 4;
    } else if(var_8 < var_0) {
      var_8 = (var_12 + 3 * var_0) / 4;
    }

    var_7--;
  }

  return var_8;
}

function rootsofcubic(var_0, var_1, var_2, var_3) {
  if(var_0 == 0) {
    return rootsofquadratic(var_1, var_2, var_3);
  }

  var_4 = 2 * var_1 * var_1 * var_1 - 9 * var_0 * var_1 * var_2 + 27 * var_0 * var_0 * var_3;
  var_5 = var_1 * var_1 - 3 * var_0 * var_2;

  if(var_5 == 0) {}

  if(var_4 == 0 && var_5 == 0) {
    GscBinSkip1(0x45, 0, -1 * var_1 / 3 * var_0);
  }

  if(var_4 == 0 && var_5 != 0) {
    GscBinSkip1(0x45, 0, (9 * var_0 * var_0 * var_3 - 4 * var_0 * var_1 * var_2 + var_1 * var_1 * var_1) / var_0 * (3 * var_0 * var_2 - var_1 * var_1));
  }
}

function rootsofquadratic(var_0, var_1, var_2) {
  while(abs(var_0) > 65536 || abs(var_1) > 65536 || abs(var_2) > 65536) {
    var_0 /= 10;
    var_1 /= 10;
    var_2 /= 10;
  }

  var_3 = [];

  if(var_0 == 0) {
    if(var_1 != 0) {
      GscBinSkip0(0x2e, 0, -1 * var_2 / var_1);
    }
  } else {
    var_4 = var_1 * var_1 - 4 * var_0 * var_2;

    if(var_4 > 0) {
      var_3 = (-1 * var_1 - sqrt(var_4)) / 2 * var_0;
      var_3 = (-1 * var_1 + sqrt(var_4)) / 2 * var_0;
    } else if(var_4 == 0) {
      var_3 = -1 * var_1 / 2 * var_0;
    }
  }

  return var_3;
}

function nonvectorlength(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(isDefined(var_1)) {
      var_4 -= var_1[var_3];
    }

    var_2 += var_4 * var_4;
  }

  return sqrt(var_2);
}

function clampandnormalize(var_0, var_1, var_2) {
  if(var_1 < var_2) {
    var_0 = clamp(var_0, var_1, var_2);
  } else {
    var_0 = clamp(var_0, var_2, var_1);
  }

  return (var_0 - var_1) / (var_2 - var_1);
}

function pointoncircle(var_0, var_1, var_2) {
  var_3 = cos(var_2);
  var_3 *= var_1;
  var_3 += var_0[0];
  var_4 = sin(var_2);
  var_4 *= var_1;
  var_4 += var_0[1];
  var_5 = var_0[2];
  return (var_3, var_4, var_5);
}

function zerocomponent(var_0, var_1) {
  return (var_0[0] * (var_1 != 0), var_0[1] * (var_1 != 1), var_0[2] * (var_1 != 2));
}

function rotate90aroundaxis(var_0, var_1) {
  if(var_1 == 0) {
    return (var_0[0], var_0[2], -1 * var_0[1]);
  }

  if(var_1 == 1) {
    return (-1 * var_0[2], var_0[1], var_0[0]);
  }

  return (var_0[1], -1 * var_0[0], var_0[2]);
}