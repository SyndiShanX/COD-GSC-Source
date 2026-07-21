/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: models\interactive_utility.gsc
***********************************************/

array_sortbyarray(var_0, var_1) {
  var_2 = [];
  var_2[0] = var_0[0];
  var_3 = [];
  var_3[0] = var_1[0];

  for(var_4 = 1; var_4 < var_0.size; var_4++) {
    var_5 = 0;

    for(var_6 = 0; var_6 < var_2.size; var_6++) {
      if(var_1[var_4] < var_3[var_6]) {
        for(var_7 = var_2.size - 1; var_7 >= var_6; var_7--) {
          var_2[var_7 + 1] = var_2[var_7];
          var_3[var_7 + 1] = var_3[var_7];
        }

        var_2[var_6] = var_0[var_4];
        var_3[var_6] = var_1[var_4];
        var_5 = 1;
        break;
      }
    }

    if(!var_5) {
      var_2[var_4] = var_0[var_4];
      var_3[var_4] = var_1[var_4];
    }
  }

  return var_2;
}

array_sortbysorter(var_0) {
  var_1 = [];
  var_1[0] = var_0[0];

  for(var_2 = 1; var_2 < var_0.size; var_2++) {
    var_3 = 0;

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      if(var_0[var_2].sorter < var_1[var_4].sorter) {
        for(var_5 = var_1.size - 1; var_5 >= var_4; var_5--)
          var_1[var_5 + 1] = var_1[var_5];

        var_1[var_4] = var_0[var_2];
        var_3 = 1;
        break;
      }
    }

    if(!var_3)
      var_1[var_2] = var_0[var_2];
  }

  return var_1;
}

wait_then_fn(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_8 in var_1)
      self endon(var_8);
    } else
      self endon(var_1);
  }

  if(isstring(var_0))
    self waittill(var_0);
  else
    wait(var_0);

  if(isDefined(var_6))
    self[[var_2]](var_3, var_4, var_5, var_6);
  else if(isDefined(var_5))
    self[[var_2]](var_3, var_4, var_5);
  else if(isDefined(var_4))
    self[[var_2]](var_3, var_4);
  else if(isDefined(var_3))
    self[[var_2]](var_3);
  else
    self[[var_2]]();
}

waittill_notify(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = 0;

  for(var_5 = 1; var_5; var_5 = var_4) {
    self endon("_encstr_AD75063D571AE108");

    if(isDefined(var_3))
      self endon(var_3);

    self waittill(var_0);
    var_1 notify(var_2);
  }
}

loop_anim(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_2))
    self endon(var_2);

  for(;;) {
    var_4 = single_anim(var_0, var_1, "_encstr_A7930AB1DE7BE0F52CDC966B", 0, var_3);

    if(scripts\common\utility::issp()) {
      self waittillmatch("_encstr_A7930AB1DE7BE0F52CDC966B", "_encstr_961804BD954A");
      continue;
    }

    wait(getanimlength(var_4));
  }
}

single_anim(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = "_encstr_ABBF0CB9A5E6ECC659F52C9B4BD6";

  if(!isDefined(var_4))
    var_4 = 1;

  if(isarray(var_0[var_1])) {
    if(!isDefined(var_0[var_1 + "_encstr_8FDE0783D823374B6B"])) {
      var_0[var_1 + "_encstr_8FDE0783D823374B6B"] = [];
      var_5 = getarraykeys(var_0[var_1]);

      foreach(var_7 in var_5)
      var_0[var_1 + "_encstr_8FDE0783D823374B6B"][var_7] = 1;
    }

    var_9 = var_0[var_1].size;
    var_10 = 0;

    for(var_11 = 0; var_11 < var_9; var_11++)
      var_10 = var_10 + var_0[var_1 + "_encstr_8FDE0783D823374B6B"][var_11];

    var_12 = randomfloat(var_10);
    var_13 = 0;

    for(var_14 = -1; var_13 <= var_12; var_13 = var_13 + var_0[var_1 + "_encstr_8FDE0783D823374B6B"][var_14])
      var_14++;

    var_15 = var_0[var_1][var_14];

    if(isDefined(var_0[var_1 + "_encstr_8C07031599"]))
      var_16 = var_0[var_1 + "_encstr_8C07031599"][var_14];
    else
      var_16 = undefined;
  } else {
    var_15 = var_0[var_1];
    var_16 = var_0[var_1 + "_encstr_8C07031599"];
  }

  if(scripts\common\utility::issp()) {
    if(isDefined(var_3) && var_3)
      self call[[level.func["_encstr_B14D1ACD563A99362CD99DB223C29BA56BAD73B7984EACCD8E169C47"]]](var_2, var_15, 1, 0.1, var_4);
    else
      self call[[level.func["_encstr_8FCB13B995E866C6C2CE762B8C0B9BD2ADB637F6C4"]]](var_2, var_15, 1, 0.1, var_4);
  } else
    self call[[level.func["_encstr_848A141BAFF834B34DD472CA39A9EBADC823A19ED378"]]](var_16);

  return var_15;
}

blendanimsbyspeed(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = 0.1;

  var_0 = clamp(var_0, var_2[0], var_2[var_2.size - 1]);

  for(var_5 = 0; var_0 > var_2[var_5 + 1]; var_5++) {}

  var_6 = var_0 - var_2[var_5];
  var_6 = var_6 / (var_2[var_5 + 1] - var_2[var_5]);

  if(scripts\common\utility::issp()) {
    var_6 = clamp(var_6, 0.01, 0.99);
    var_7 = var_3[var_5 + 1] / var_3[var_5];
    var_8 = var_6 + (1 - var_6) * var_7;
    self call[[level.func["_encstr_8E400F37CA1D0B9BB4DAD8B4DAA58E9546"]]](var_1[var_5], 1 - var_6, var_4, var_8 / var_7);
    self call[[level.func["_encstr_8E400F37CA1D0B9BB4DAD8B4DAA58E9546"]]](var_1[var_5 + 1], var_6, var_4, var_8);

    for(var_9 = 0; var_9 < var_5; var_9++) {
      var_7 = var_3[var_5 + 1] / var_3[var_9];
      self call[[level.func["_encstr_8E400F37CA1D0B9BB4DAD8B4DAA58E9546"]]](var_1[var_9], 0.01, var_4, var_8 / var_7);
    }

    for(var_9 = var_5 + 2; var_9 < var_2.size; var_9++) {
      var_7 = var_3[var_5 + 1] / var_3[var_9];
      self call[[level.func["_encstr_8E400F37CA1D0B9BB4DAD8B4DAA58E9546"]]](var_1[var_9], 0.01, var_4, var_8 / var_7);
    }
  } else if(var_6 > 0.5)
    self call[[level.func["_encstr_848A141BAFF834B34DD472CA39A9EBADC823A19ED378"]]](var_1[var_5 + 1]);
  else
    self call[[level.func["_encstr_848A141BAFF834B34DD472CA39A9EBADC823A19ED378"]]](var_1[var_5]);
}

detect_events(var_0) {
  if(scripts\common\utility::issp()) {
    self endon("_encstr_AD75063D571AE108");
    self endon("_encstr_B2BE0788BAF573592F");
    self call[[level.func["_encstr_9542137802CCD3B59B5C9B0D3907F9BD73EAA0E8EB"]]]("_encstr_A7A408B9CA5D1D4E2C63");
    self call[[level.addaieventlistener_func]]("_encstr_8A21128393F64D2BB13A4B1BB2F55AD60E85C61D");
    self call[[level.addaieventlistener_func]]("_encstr_A5490D5E05C3F8B363F3C8D83B3E43");
    self call[[level.addaieventlistener_func]]("_encstr_92FD082A30066B713094");
    self call[[level.addaieventlistener_func]]("_encstr_860808CB78E2984063BA");

    for(;;) {
      self waittill("_encstr_B4580A0740984DFBF2C57BEB");
      self notify(var_0);
      self.interrupted = 1;
      waittillframeend;
      self.interrupted = 0;
    }
  }
}

detect_people(var_0, var_1, var_2) {
  if(!isarray(var_2)) {
    var_3 = var_2;
    var_2 = [];
    var_2[0] = var_3;
  }

  foreach(var_5 in var_2)
  self endon(var_5);

  self.detect_people_trigger[var_1] = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin, 23, var_0, var_0);

  for(var_7 = var_2.size; var_7 < 3; var_7++)
    var_2[var_7] = undefined;

  thread scripts\engine\utility::delete_on_notify(self.detect_people_trigger[var_1], var_2[0], var_2[1], var_2[2]);

  for(;;) {
    self.detect_people_trigger[var_1] waittill("_encstr_8F5C086405E70FBA4B4A", var_8);
    self.interruptedent = var_8;
    self notify(var_1);
    self.interrupted = 1;
    waittillframeend;
    self.interrupted = 0;
  }
}

detect_player_event(var_0, var_1, var_2, var_3) {
  if(!isarray(var_2)) {
    var_4 = var_2;
    var_2 = [];
    var_2[0] = var_4;
  }

  foreach(var_6 in var_2)
  self endon(var_6);

  for(;;) {
    level.player waittill(var_3);

    if(distancesquared(level.player.origin, self.origin) < var_0 * var_0) {
      self notify(var_1);
      self.interruptedent = level.player;
      self notify(var_1);
      self.interrupted = 1;
      waittillframeend;
      self.interrupted = 0;
    }
  }
}

wrap(var_0, var_1) {
  var_2 = int(var_0 / var_1);
  var_3 = var_0 - var_1 * var_2;

  if(var_0 < 0)
    var_3 = var_3 + var_1;

  if(var_3 == var_1)
    var_3 = 0;

  return var_3;
}

interactives_drawdebuglinefortime(var_0, var_1, var_2, var_3, var_4, var_5) {}

drawcross(var_0, var_1, var_2, var_3) {
  thread scripts\engine\utility::draw_line_for_time(var_0 - (var_1, 0, 0), var_0 + (var_1, 0, 0), var_2[0], var_2[1], var_2[2], var_3);
  thread scripts\engine\utility::draw_line_for_time(var_0 - (0, var_1, 0), var_0 + (0, var_1, 0), var_2[0], var_2[1], var_2[2], var_3);
  thread scripts\engine\utility::draw_line_for_time(var_0 - (0, 0, var_1), var_0 + (0, 0, var_1), var_2[0], var_2[1], var_2[2], var_3);
}

drawcircle(var_0, var_1, var_2, var_3) {
  var_4 = 16;

  for(var_5 = 0; var_5 < 360; var_5 = var_5 + 360 / var_4) {
    var_6 = var_5 + 360 / var_4;
    thread scripts\engine\utility::draw_line_for_time(var_0 + (var_1 * cos(var_5), var_1 * sin(var_5), 0), var_0 + (var_1 * cos(var_6), var_1 * sin(var_6), 0), var_2[0], var_2[1], var_2[2], var_3);
  }
}

drawcirculararrow(var_0, var_1, var_2, var_3, var_4) {
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

isinarray(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_0 == var_3)
      return 1;
  }

  return 0;
}

newtonsmethod(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 5;
  var_8 = (var_0 + var_1) / 2;

  for(var_9 = var_6 + 1; abs(var_9) > var_6 && var_7 > 0; var_7--) {
    var_10 = var_2 * var_8 * var_8 * var_8 + var_3 * var_8 * var_8 + var_4 * var_8 + var_5;
    var_11 = 3 * var_2 * var_8 * var_8 + 2 * var_3 * var_8 + var_4;
    var_9 = -1 * var_10 / var_11;
    var_12 = var_8;
    var_8 = var_8 + var_9;

    if(var_8 > var_1) {
      var_8 = (var_12 + 3 * var_1) / 4;
      continue;
    }

    if(var_8 < var_0)
      var_8 = (var_12 + 3 * var_0) / 4;
  }

  return var_8;
}

rootsofcubic(var_0, var_1, var_2, var_3) {
  if(var_0 == 0)
    return rootsofquadratic(var_1, var_2, var_3);

  var_4 = 2 * var_1 * var_1 * var_1 - 9 * var_0 * var_1 * var_2 + 27 * var_0 * var_0 * var_3;
  var_5 = var_1 * var_1 - 3 * var_0 * var_2;

  if(var_5 == 0) {}

  if(var_4 == 0 && var_5 == 0)
    var_6[0] = -1 * var_1 / (3 * var_0);
  else if(var_4 == 0 && var_5 != 0)
    var_6[0] = (9 * var_0 * var_0 * var_3 - 4 * var_0 * var_1 * var_2 + var_1 * var_1 * var_1) / (var_0 * (3 * var_0 * var_2 - var_1 * var_1));
  else {}
}

rootsofquadratic(var_0, var_1, var_2) {
  while(abs(var_0) > 65536 || abs(var_1) > 65536 || abs(var_2) > 65536) {
    var_0 = var_0 / 10;
    var_1 = var_1 / 10;
    var_2 = var_2 / 10;
  }

  var_3 = [];

  if(var_0 == 0) {
    if(var_1 != 0)
      var_3[0] = -1 * var_2 / var_1;
  } else {
    var_4 = var_1 * var_1 - 4 * var_0 * var_2;

    if(var_4 > 0) {
      var_3[0] = (-1 * var_1 - sqrt(var_4)) / (2 * var_0);
      var_3[1] = (-1 * var_1 + sqrt(var_4)) / (2 * var_0);
    } else if(var_4 == 0)
      var_3[0] = -1 * var_1 / (2 * var_0);
  }

  return var_3;
}

nonvectorlength(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(isDefined(var_1))
      var_4 = var_4 - var_1[var_3];

    var_2 = var_2 + var_4 * var_4;
  }

  return sqrt(var_2);
}

clampandnormalize(var_0, var_1, var_2) {
  if(var_1 < var_2)
    var_0 = clamp(var_0, var_1, var_2);
  else
    var_0 = clamp(var_0, var_2, var_1);

  return (var_0 - var_1) / (var_2 - var_1);
}

pointoncircle(var_0, var_1, var_2) {
  var_3 = cos(var_2);
  var_3 = var_3 * var_1;
  var_3 = var_3 + var_0[0];
  var_4 = sin(var_2);
  var_4 = var_4 * var_1;
  var_4 = var_4 + var_0[1];
  var_5 = var_0[2];
  return (var_3, var_4, var_5);
}

zerocomponent(var_0, var_1) {
  return (var_0[0] * (var_1 != 0), var_0[1] * (var_1 != 1), var_0[2] * (var_1 != 2));
}

rotate90aroundaxis(var_0, var_1) {
  if(var_1 == 0)
    return (var_0[0], var_0[2], -1 * var_0[1]);
  else if(var_1 == 1)
    return (-1 * var_0[2], var_0[1], var_0[0]);
  else
    return (var_0[1], -1 * var_0[0], var_0[2]);
}