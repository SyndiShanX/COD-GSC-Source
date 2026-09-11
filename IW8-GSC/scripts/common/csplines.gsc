/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\csplines.gsc
***********************************************/

function cspline_calctangent(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = [];

  for(var_7 = 0; var_7 < 3; var_7++) {
    var_5 = (1 - var_4) * (var_1[var_7] - var_0[var_7]);
    var_6 = var_5[var_7];
    var_5 = var_5[var_7] * 2 * var_2 / (var_2 + var_3);
    var_6 = var_6[var_7] * 2 * var_3 / (var_2 + var_3);
  }

  var_8 = [];
  GscBinSkip0(0x2e, "incoming", (var_5[0], var_5[1], var_5[2]));
}

function cspline_calctangenttcb(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = [];
  var_9 = [];

  for(var_10 = 0; var_10 < 3; var_10++) {
    var_8 = (1 - var_5) * (1 - var_6) * (1 + var_7) * 0.5 * (var_1[var_10] - var_0[var_10]);
    var_8 = var_8[var_10] + (1 - var_5) * (1 + var_6) * (1 - var_7) * 0.5 * (var_2[var_10] - var_1[var_10]);
    var_8 = var_8[var_10] * 2 * var_3 / (var_3 + var_4);
    var_9 = (1 - var_5) * (1 + var_6) * (1 + var_7) * 0.5 * (var_1[var_10] - var_0[var_10]);
    var_9 = var_9[var_10] + (1 - var_5) * (1 - var_6) * (1 - var_7) * 0.5 * (var_2[var_10] - var_1[var_10]);
    var_9 = var_9[var_10] * 2 * var_4 / (var_3 + var_4);
  }

  var_11 = [];
  GscBinSkip0(0x2e, "incoming", (var_8[0], var_8[1], var_8[2]));
}

function cspline_calctangentnatural(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = [];
  var_5 = [];

  if(isDefined(var_2)) {
    for(var_6 = 0; var_6 < var_3; var_6++) {
      var_4 = (-3 * var_0[var_6] + 3 * var_1[var_6] - var_2[var_6]) / 2;
      var_5 = var_4[var_6];
    }
  } else {
    for(var_6 = 0; var_6 < var_4; var_6++) {
      var_5 = var_2[var_6] - var_1[var_6];
      var_6 = var_2[var_6] - var_1[var_6];
    }
  }

  var_7 = [];
  GscBinSkip0(0x2e, "incoming", (var_5[0], var_5[1], var_5[2]));
}

function csplineseg_calccoeffs(var_0, var_1, var_2, var_3) {
  var_4 = 3;
  var_5 = spawnStruct();
  var_5.n3 = [];
  var_5.n2 = [];
  var_5.n = [];
  var_5.c = [];

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_5.n3[var_6] = 2 * var_0[var_6] - 2 * var_1[var_6] + var_2[var_6] + var_3[var_6];
    var_5.n2[var_6] = -3 * var_0[var_6] + 3 * var_1[var_6] - 2 * var_2[var_6] - var_3[var_6];
    var_5.n[var_6] = var_2[var_6];
    var_5.c[var_6] = var_0[var_6];
  }

  return var_5;
}

function csplineseg_calccoeffscapspeed(var_0, var_1, var_2, var_3, var_4) {
  var_5 = csplineseg_calccoeffs(var_0, var_1, var_2, var_3);
  var_6 = csplineseg_calctopspeed(var_5, var_4);

  if(var_6 > 1) {
    var_4 *= var_6;
    var_2 /= var_6;
    var_3 /= var_6;
    var_5 = csplineseg_calccoeffs(var_0, var_1, var_2, var_3);
  }

  var_5.endat = var_4;
  return var_5;
}

function cspline_getnodes(var_0) {
  var_1 = [];
  var_2 = var_0.segments[0].endat;
  var_1 = csplineseg_getpoint(var_0.segments[0], 0, var_2, var_0.segments[0].speedstart);
  var_1["time"] = 0;
  var_3 = 0;

  for(var_4 = 0; var_4 < var_0.segments.size; var_4++) {
    var_2 = var_0.segments[var_4].endat - var_3;
    var_1 = csplineseg_getpoint(var_0.segments[var_4], 1, var_2, var_0.segments[var_4].speedend);
    var_5 = csplineseg_getpoint(var_0.segments[var_4], 0, var_2, var_0.segments[var_4].speedstart);
    var_1["acc_out"] = var_5["acc"];
    var_1["time"] = var_0.segments[var_4].endtime;
    var_3 = var_0.segments[var_4].endat;
  }

  var_1["acc_out"] = var_1[var_0.segments.size]["acc"];
  return var_1;
}

function csplineseg_getpoint(var_0, var_1, var_2, var_3) {
  var_4 = 3;
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];

  for(var_9 = 0; var_9 < var_4; var_9++) {
    var_5 = var_0.n3[var_9] * var_1 * var_1 * var_1 + var_0.n2[var_9] * var_1 * var_1 + var_0.n[var_9] * var_1 + var_0.c[var_9];
    var_6 = 3 * var_0.n3[var_9] * var_1 * var_1 + 2 * var_0.n2[var_9] * var_1 + var_0.n[var_9];
    var_7 = 6 * var_0.n3[var_9] * var_1 + 2 * var_0.n2[var_9];
  }

  var_8 = (var_5[0], var_5[1], var_5[2]);
  var_8 = (var_6[0], var_6[1], var_6[2]);
  var_8 = (var_7[0], var_7[1], var_7[2]);

  if(isDefined(var_2)) {
    var_8 = var_8["vel"] / var_2;
    var_8 = var_8["acc"] / var_2 * var_2;
  }

  if(isDefined(var_3)) {
    var_8 = var_8["vel"] * var_3;
    var_8 = var_8["acc"] * var_3 * var_3;
  }

  var_8 = var_3;
  return var_8;
}

function csplineseg_calctopspeed(var_0, var_1) {
  var_2 = csplineseg_calctopspeedbyderiving(var_0, var_1);
  return var_2;
}

function csplineseg_calctopspeedbyderiving(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;

  for(var_8 = 0; var_8 < 3; var_8++) {
    var_2 += var_0.n3[var_8] * var_0.n3[var_8];
    var_3 += var_0.n3[var_8] * var_0.n2[var_8];
    var_4 += var_0.n3[var_8] * var_0.n[var_8];
    var_5 += var_0.n2[var_8] * var_0.n2[var_8];
    var_6 += var_0.n2[var_8] * var_0.n[var_8];
    var_7 += var_0.n[var_8] * var_0.n[var_8];
  }

  var_9 = 36 * var_2;
  var_10 = 36 * var_3;
  var_11 = 12 * var_4 + 8 * var_5;
  var_12 = 4 * var_6;
  var_13 = [];
  GscBinSkip0(0x2e, 0, 0);
}

function csplineseg_calclengthbystepping(var_0, var_1) {
  var_2 = csplineseg_getpoint(var_0, 0);
  var_3 = 0;

  for(var_4 = 1; var_4 <= var_1; var_4++) {
    var_5 = var_4 / var_1;
    var_6 = csplineseg_getpoint(var_0, var_5);
    var_3 += length(var_2["pos"] - var_6["pos"]);
    var_2 = var_6;
  }

  return var_3;
}

function csplineseg_calctopspeedbystepping(var_0, var_1, var_2) {
  var_3 = csplineseg_getpoint(var_0, 0);
  var_4 = 0;

  for(var_5 = 1; var_5 <= var_1; var_5++) {
    var_6 = var_5 / var_1;
    var_7 = csplineseg_getpoint(var_0, var_6);
    var_8 = length(var_3["pos"] - var_7["pos"]);

    if(var_8 > var_4) {
      var_4 = var_8;
    }

    var_3 = var_7;
  }

  var_4 *= var_1 / var_2;
  return var_4;
}

function cspline_findpathnodes(var_0) {
  var_1 = var_0;
  var_2 = [];

  for(var_3 = 0; isDefined(var_1.target); var_3++) {
    var_2 = var_1;
    var_4 = var_1.target;
    var_1 = getnode(var_4, "targetname");

    if(!isDefined(var_1)) {
      var_1 = getvehiclenode(var_4, "targetname");

      if(!isDefined(var_1)) {
        var_1 = getEnt(var_4, "targetname");

        if(!isDefined(var_1)) {
          var_1 = scripts\engine\utility::getStruct(var_4, "targetname");
        }
      }
    }
  }

  var_2 = var_1;
  return var_2;
}

function cspline_makepath1seg(var_0, var_1, var_2, var_3) {
  var_4 = [];
  GscBinSkip0(0x2e, 0, spawnStruct());
}

function cspline_makepathtopoint(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(isDefined(var_2)) {
    var_6 = length(var_2);
    var_5 = var_2 / var_6;
    var_6 *= 20;
  } else {
    var_6 = 20;
  }

  if(isDefined(var_4)) {
    var_7 = length(var_4);
    var_6 = var_4 / var_7;
    var_7 *= 20;
  } else {
    var_7 = 20;
  }

  if(var_7 / var_7 > 1.2 || var_7 / var_7 > 1.2 || var_6) {
    if(!isDefined(var_6[0])) {
      var_6 = (0, 0, 0);
    }

    if(!isDefined(var_6[1])) {
      var_6 = (0, 0, 0);
    }
  }

  var_8 = var_3 - var_2;
  var_9 = length(var_8);
  var_10 = var_8 / var_9;
  var_11 = [];
  GscBinSkip0(0x2e, 0, spawnStruct());
}

function cspline_makepath(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.segments = [];

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_6 = 0;
  var_7 = [];
  var_8 = distance(var_0[0].origin, var_0[1].origin);

  while(isDefined(var_0[var_5.segments.size + 2])) {
    var_9 = var_5.segments.size;
    var_10 = var_0[var_9].origin;
    var_11 = var_0[var_9 + 1].origin;
    var_12 = var_0[var_9 + 2].origin;
    var_13 = var_8;
    var_8 = distance(var_0[var_9 + 1].origin, var_0[var_9 + 2].origin);
    var_14 = var_7;
    var_7 = cspline_calctangent(var_10, var_12, var_13, var_8, 0.5);

    if(var_9 == 0) {
      if(isDefined(var_2)) {
        GscBinSkip0(0x2e, "outgoing", var_2 * var_13);
      }

      var_14 = cspline_calctangentnatural(var_10, var_11, var_7["incoming"]);
    }

    if(var_4) {
      var_5.segments[var_9] = csplineseg_calccoeffscapspeed(var_10, var_11, var_14["outgoing"], var_7["incoming"], var_13);
      var_6 += var_5.segments[var_9].endat;
    } else {
      var_5.segments[var_9] = csplineseg_calccoeffs(var_10, var_11, var_14["outgoing"], var_7["incoming"]);
      var_6 += var_13;
    }

    var_5.segments[var_9].endat = var_6;
  }

  var_9 = var_5.segments.size;
  var_10 = var_0[var_9].origin;
  var_11 = var_0[var_9 + 1].origin;
  var_13 = var_8;
  var_14 = var_7;

  if(var_9 == 0 && isDefined(var_2)) {
    GscBinSkip0(0x2e, "outgoing", var_2 * var_13);
  }

  if(isDefined(var_3)) {
    var_7 = var_3 * var_13;
  } else {
    var_7 = cspline_calctangentnatural(var_10, var_11, var_14["outgoing"]);
  }

  if(var_9 == 0 && !isDefined(var_2)) {
    var_14 = cspline_calctangentnatural(var_10, var_11, var_7["incoming"]);
  }

  if(var_4) {
    var_5.segments[var_9] = csplineseg_calccoeffscapspeed(var_10, var_11, var_14["outgoing"], var_7["incoming"], var_13);
    var_6 += var_5.segments[var_9].endat;
  } else {
    var_5.segments[var_9] = csplineseg_calccoeffs(var_10, var_11, var_14["outgoing"], var_7["incoming"]);
    var_6 += var_13;
  }

  var_5.segments[var_9].endat = var_6;

  if(var_1) {
    var_15 = 0;
    var_16 = 0;

    for(var_9 = 0; var_9 < var_5.segments.size; var_9++) {
      if(!isDefined(var_0[var_9 + 1].speed)) {
        var_0[var_9 + 1].speed = var_0[var_9].speed;
      }

      var_13 = var_5.segments[var_9].endat - var_16;
      var_17 = 2 * var_13 / (var_0[var_9].speed + var_0[var_9 + 1].speed) / 20;
      var_15 += var_17;
      var_5.segments[var_9].endtime = var_15;
      var_16 = var_5.segments[var_9].endat;
      var_5.segments[var_9].speedstart = var_0[var_9].speed / 20;
      var_5.segments[var_9].speedend = var_0[var_9 + 1].speed / 20;
    }
  } else {
    for(var_9 = 0; var_9 < var_5.segments.size; var_9++) {
      var_5.segments[var_9].endtime = var_5.segments[var_9].endat;
      var_5.segments[var_9].speedstart = 1;
      var_5.segments[var_9].speedend = 1;
    }
  }

  return var_5;
}

function cspline_movefirstpoint(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.segments = [];
  var_4 = csplineseg_getpoint(var_0.segments[0], 1);
  var_5 = var_4["pos"] - var_1;
  var_6 = length(var_5);
  var_3.segments[0] = csplineseg_calccoeffs(var_1, var_4["pos"], var_2 * var_6, var_4["vel"]);
  var_3.segments[0].endtime = var_0.segments[0].endtime * var_6 / var_0.segments[0].endat;
  var_3.segments[0].endat = var_6;
  var_7 = var_6 - var_0.segments[0].endat;
  var_8 = var_3.segments[0].endtime - var_0.segments[0].endtime;

  for(var_9 = 1; var_9 < var_0.segments.size; var_9++) {
    var_3.segments[var_9] = csplineseg_copy(var_0.segments[var_9]);
    var_3.segments[var_9].endat += var_7;
    var_3.segments[var_9].endtime += var_8;
  }

  return var_3;
}

function cspline_getpointatdistance(var_0, var_1, var_2) {
  if(var_1 <= 0) {
    var_3 = var_0.segments[0].endat;
    var_4 = csplineseg_getpoint(var_0.segments[0], 0, var_3, var_0.segments[0].speedstart);
    return var_4;
  }

  if(var_3 >= var_2.segments[var_2.segments.size - 1].endat) {
    if(var_2.segments.size > 1) {
      var_3 = var_2.segments[var_2.segments.size - 1].endat - var_2.segments[var_2.segments.size - 2].endat;
    } else {
      var_3 = var_3.segments[var_3.segments.size - 1].endat;
    }

    var_4 = csplineseg_getpoint(var_3.segments[var_3.segments.size - 1], 1, var_3, var_3.segments[var_3.segments.size - 1].speedend);
    return var_4;
  }

  for(var_5 = 0; var_3.segments[var_5].endat < var_3; var_5++) {}

  if(var_5 > 0) {
    var_6 = var_3.segments[var_5 - 1].endat;
  } else {
    var_6 = 0;
  }

  var_3 = var_3.segments[var_6].endat - var_6;
  var_7 = (var_4 - var_6) / var_3;
  var_8 = undefined;

  if(isDefined(var_5) && var_5) {
    var_8 = cspline_speedfromdistance(var_3.segments[var_6].speedstart, var_3.segments[var_6].speedend, var_7);
  }

  var_4 = csplineseg_getpoint(var_3.segments[var_6], var_7, var_3, var_8);
  return var_4;
}

function cspline_getpointattime(var_0, var_1) {
  if(var_1 <= 0) {
    var_2 = var_0.segments[0].endat;
    var_3 = csplineseg_getpoint(var_0.segments[0], 0, var_2, var_0.segments[0].speedstart);
    return var_3;
  }

  if(var_3 >= var_2.segments[var_2.segments.size - 1].endtime) {
    if(var_2.segments.size > 1) {
      var_2 = var_2.segments[var_2.segments.size - 1].endat - var_2.segments[var_2.segments.size - 2].endat;
    } else {
      var_2 = var_3.segments[var_3.segments.size - 1].endat;
    }

    var_3 = csplineseg_getpoint(var_3.segments[var_3.segments.size - 1], 1, var_2, var_3.segments[var_3.segments.size - 1].speedend);
    return var_3;
  }

  for(var_4 = 0; var_2.segments[var_4].endtime < var_3; var_4++) {}

  if(var_4 > 0) {
    var_5 = var_2.segments[var_4 - 1].endtime;
    var_2 = var_2.segments[var_4].endat - var_2.segments[var_4 - 1].endat;
  } else {
    var_5 = 0;
    var_2 = var_4.segments[0].endat;
  }

  var_6 = var_4.segments[var_2].endtime - var_5;
  var_7 = (var_5 - var_5) / var_6;
  var_8 = var_4.segments[var_2].speedstart + var_7 * (var_4.segments[var_2].speedend - var_4.segments[var_2].speedstart);
  var_9 = (var_5 - var_5) * (var_4.segments[var_2].speedstart + var_8) / 2;
  var_10 = var_9 / var_2;
  var_3 = csplineseg_getpoint(var_4.segments[var_2], var_10, var_2, var_8);
  return var_3;
}

function cspline_speedfromdistance(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = (var_1 - var_0) * (var_1 + var_0) / 2;
  return sqrt(2 * var_4 * var_3 + var_0 * var_0);
}

function cspline_adjusttime(var_0, var_1) {
  var_2 = cspline_time(var_0);
  var_3 = var_0.segments[0].endtime;
  var_4 = var_0.segments[var_0.segments.size - 2].endtime - var_3;
  var_5 = var_0.segments[var_0.segments.size - 1].endtime - var_0.segments[var_0.segments.size - 2].endtime;
  var_6 = 2 * var_3 + var_4 + 2 * var_5 - var_1;
  var_7 = (sqrt(var_6 * var_6 + 4 * var_4 * var_1) + var_6) / 2 * var_1;
  var_9 = undefined;
  var_10 = undefined;
  var_0.segments[0].speedend *= var_7;
  var_11 = var_0.segments[0].endtime * (1 / var_7 - 2 / (1 + var_7));
  var_0.segments[0].endtime /= (1 + var_7) / 2;

  for(var_12 = 1; var_12 < var_0.segments.size - 1; var_12++) {
    var_13 = undefined;
    var_0.segments[var_12].speedstart *= var_7;
    var_0.segments[var_12].speedend *= var_7;
    var_0.segments[var_12].endtime /= var_7;
    var_0.segments[var_12].endtime -= var_11;
  }

  var_12 = var_0.segments.size - 1;
  var_0.segments[var_12].speedstart *= var_7;
  var_0.segments[var_12].endtime = var_1;
}

function cspline_makenoisepath(var_0, var_1, var_2, var_3) {
  var_4 = cspline_makenoisepathnodes(var_0, var_1, var_2);

  if(isDefined(var_3)) {
    var_4[1].origin = var_3;
  }

  var_5 = spawnStruct();
  var_5.origin = var_4[0].origin;
  var_4 = var_5;
  var_5 = spawnStruct();
  var_5.origin = var_4[1].origin;
  var_4 = var_5;
  var_5 = spawnStruct();
  var_5.origin = var_4[2].origin;
  var_4 = var_5;
  var_6 = cspline_makepath(var_4);
  var_7 = spawnStruct();
  var_7.segments = [];

  for(var_8 = 0; var_8 < var_6.segments.size - 2; var_8++) {
    var_7.segments[var_8] = csplineseg_copy(var_6.segments[var_8 + 1]);
    var_7.segments[var_8].endat = var_8 + 1;
  }

  return var_7;
}

function cspline_makenoisepathnodes(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_3 = spawnStruct();
    var_5 = randomfloatrange(var_1[0], var_2[0]);
    var_6 = randomfloatrange(var_1[1], var_2[1]);
    var_7 = randomfloatrange(var_1[2], var_2[2]);
    var_3[var_4].origin = (var_5, var_6, var_7);
  }

  return var_3;
}

function cspline_test(var_0, var_1) {}

function cspline_testnodes(var_0, var_1) {
  var_2 = 20;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(isDefined(var_3)) {
      thread scripts\engine\utility::draw_arrow_time(var_3.origin, var_5.origin, (0, 1, 0), var_1);
    }

    var_3 = var_5;
  }

  foreach(var_5 in var_0) {
    thread scripts\engine\utility::draw_line_for_time(var_5.origin - (var_2, 0, 0), var_5.origin + (var_2, 0, 0), 1, 1, 0, var_1);
    thread scripts\engine\utility::draw_line_for_time(var_5.origin - (0, var_2, 0), var_5.origin + (0, var_2, 0), 1, 1, 0, var_1);
    thread scripts\engine\utility::draw_line_for_time(var_5.origin - (0, 0, var_2), var_5.origin + (0, 0, var_2), 1, 1, 0, var_1);
  }
}

function csplineseg_copy(var_0) {
  var_1 = spawnStruct();
  var_2 = 3;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_1.n3[var_3] = var_0.n3[var_3];
    var_1.n2[var_3] = var_0.n2[var_3];
    var_1.n[var_3] = var_0.n[var_3];
    var_1.c[var_3] = var_0.c[var_3];
  }

  var_1.endat = var_0.endat;
  var_1.endtime = var_0.endtime;
  return var_1;
}

function cspline_length(var_0) {
  return var_0.segments[var_0.segments.size - 1].endat;
}

function cspline_time(var_0) {
  return var_0.segments[var_0.segments.size - 1].endtime;
}

function cspline_initnoise(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_5 = var_1;
  var_4.largestep = var_2;
  var_6 = (var_0[0] - var_5, var_0[1] - var_5, var_0[2] - var_5);
  var_7 = (var_0[0] + var_5, var_0[1] + var_5, var_0[2] + var_5);

  if(!isDefined(var_3)) {
    var_3 = (var_0[0], var_0[1], var_0[2] - var_5);
  }

  var_4.largescale = cspline_makenoisepath(10, var_6, var_7, var_3);
  var_4.largescale.length = var_4.largescale.segments[var_4.largescale.segments.size - 1].endat;
  thread cspline_test(var_4.largescale, 20);
  return var_4;
}

function cspline_noise(var_0, var_1) {
  var_2 = scripts\engine\utility::mod(var_1 / var_0.largestep, var_0.largescale.length);
  var_3 = cspline_getpointatdistance(var_0.largescale, var_2);
  return var_3["pos"];
}