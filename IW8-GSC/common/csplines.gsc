/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\csplines.gsc
***********************************************/

cspline_calctangent(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = [];

  for(var_7 = 0; var_7 < 3; var_7++) {
    var_5[var_7] = (1 - var_4) * (var_1[var_7] - var_0[var_7]);
    var_6[var_7] = var_5[var_7];
    var_5[var_7] = var_5[var_7] * (2 * var_2 / (var_2 + var_3));
    var_6[var_7] = var_6[var_7] * (2 * var_3 / (var_2 + var_3));
  }

  var_8 = [];
  var_8["_encstr_8A4F099025A3B8715A6B17"] = (var_5[0], var_5[1], var_5[2]);
  var_8["_encstr_83DE09DEEA8E9DF62DDCEC"] = (var_6[0], var_6[1], var_6[2]);
  return var_8;
}

cspline_calctangenttcb(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = [];
  var_9 = [];

  for(var_10 = 0; var_10 < 3; var_10++) {
    var_8[var_10] = (1 - var_5) * (1 - var_6) * (1 + var_7) * 0.5 * (var_1[var_10] - var_0[var_10]);
    var_8[var_10] = var_8[var_10] + (1 - var_5) * (1 + var_6) * (1 - var_7) * 0.5 * (var_2[var_10] - var_1[var_10]);
    var_8[var_10] = var_8[var_10] * (2 * var_3 / (var_3 + var_4));
    var_9[var_10] = (1 - var_5) * (1 + var_6) * (1 + var_7) * 0.5 * (var_1[var_10] - var_0[var_10]);
    var_9[var_10] = var_9[var_10] + (1 - var_5) * (1 - var_6) * (1 - var_7) * 0.5 * (var_2[var_10] - var_1[var_10]);
    var_9[var_10] = var_9[var_10] * (2 * var_4 / (var_3 + var_4));
  }

  var_11 = [];
  var_11["_encstr_8A4F099025A3B8715A6B17"] = (var_8[0], var_8[1], var_8[2]);
  var_11["_encstr_83DE09DEEA8E9DF62DDCEC"] = (var_9[0], var_9[1], var_9[2]);
  return var_11;
}

cspline_calctangentnatural(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = [];
  var_5 = [];

  if(isDefined(var_2)) {
    for(var_6 = 0; var_6 < var_3; var_6++) {
      var_4[var_6] = (-3 * var_0[var_6] + 3 * var_1[var_6] - var_2[var_6]) / 2;
      var_5[var_6] = var_4[var_6];
    }
  } else {
    for(var_6 = 0; var_6 < var_3; var_6++) {
      var_4[var_6] = var_1[var_6] - var_0[var_6];
      var_5[var_6] = var_1[var_6] - var_0[var_6];
    }
  }

  var_7 = [];
  var_7["_encstr_8A4F099025A3B8715A6B17"] = (var_4[0], var_4[1], var_4[2]);
  var_7["_encstr_83DE09DEEA8E9DF62DDCEC"] = (var_5[0], var_5[1], var_5[2]);
  return var_7;
}

csplineseg_calccoeffs(var_0, var_1, var_2, var_3) {
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

csplineseg_calccoeffscapspeed(var_0, var_1, var_2, var_3, var_4) {
  var_5 = csplineseg_calccoeffs(var_0, var_1, var_2, var_3);
  var_6 = csplineseg_calctopspeed(var_5, var_4);

  if(var_6 > 1) {
    var_4 = var_4 * var_6;
    var_2 = var_2 / var_6;
    var_3 = var_3 / var_6;
    var_5 = csplineseg_calccoeffs(var_0, var_1, var_2, var_3);
  }

  var_5.endat = var_4;
  return var_5;
}

cspline_getnodes(var_0) {
  var_1 = [];
  var_2 = var_0.segments[0].endat;
  var_1[0] = csplineseg_getpoint(var_0.segments[0], 0, var_2, var_0.segments[0].speedstart);
  var_1[0]["_encstr_84EF055338A18F"] = 0;
  var_3 = 0;

  for(var_4 = 0; var_4 < var_0.segments.size; var_4++) {
    var_2 = var_0.segments[var_4].endat - var_3;
    var_1[var_4 + 1] = csplineseg_getpoint(var_0.segments[var_4], 1, var_2, var_0.segments[var_4].speedend);
    var_5 = csplineseg_getpoint(var_0.segments[var_4], 0, var_2, var_0.segments[var_4].speedstart);
    var_1[var_4]["_encstr_A9060879DF1BC99F9DA3"] = var_5["_encstr_8D19042C8D8D"];
    var_1[var_4 + 1]["_encstr_84EF055338A18F"] = var_0.segments[var_4].endtime;
    var_3 = var_0.segments[var_4].endat;
  }

  var_1[var_0.segments.size]["_encstr_A9060879DF1BC99F9DA3"] = var_1[var_0.segments.size]["_encstr_8D19042C8D8D"];
  return var_1;
}

csplineseg_getpoint(var_0, var_1, var_2, var_3) {
  var_4 = 3;
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];

  for(var_9 = 0; var_9 < var_4; var_9++) {
    var_5[var_9] = var_0.n3[var_9] * var_1 * var_1 * var_1 + var_0.n2[var_9] * var_1 * var_1 + var_0.n[var_9] * var_1 + var_0.c[var_9];
    var_6[var_9] = 3 * var_0.n3[var_9] * var_1 * var_1 + 2 * var_0.n2[var_9] * var_1 + var_0.n[var_9];
    var_7[var_9] = 6 * var_0.n3[var_9] * var_1 + 2 * var_0.n2[var_9];
  }

  var_8["_encstr_9B1904D08FEB"] = (var_5[0], var_5[1], var_5[2]);
  var_8["_encstr_A11904EC2B36"] = (var_6[0], var_6[1], var_6[2]);
  var_8["_encstr_8D19042C8D8D"] = (var_7[0], var_7[1], var_7[2]);

  if(isDefined(var_2)) {
    var_8["_encstr_A11904EC2B36"] = var_8["_encstr_A11904EC2B36"] / var_2;
    var_8["_encstr_8D19042C8D8D"] = var_8["_encstr_8D19042C8D8D"] / (var_2 * var_2);
  }

  if(isDefined(var_3)) {
    var_8["_encstr_A11904EC2B36"] = var_8["_encstr_A11904EC2B36"] * var_3;
    var_8["_encstr_8D19042C8D8D"] = var_8["_encstr_8D19042C8D8D"] * (var_3 * var_3);
  }

  var_8["_encstr_928A060723B255C8"] = var_3;
  return var_8;
}

csplineseg_calctopspeed(var_0, var_1) {
  var_2 = csplineseg_calctopspeedbyderiving(var_0, var_1);
  return var_2;
}

csplineseg_calctopspeedbyderiving(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;

  for(var_8 = 0; var_8 < 3; var_8++) {
    var_2 = var_2 + var_0.n3[var_8] * var_0.n3[var_8];
    var_3 = var_3 + var_0.n3[var_8] * var_0.n2[var_8];
    var_4 = var_4 + var_0.n3[var_8] * var_0.n[var_8];
    var_5 = var_5 + var_0.n2[var_8] * var_0.n2[var_8];
    var_6 = var_6 + var_0.n2[var_8] * var_0.n[var_8];
    var_7 = var_7 + var_0.n[var_8] * var_0.n[var_8];
  }

  var_9 = 36 * var_2;
  var_10 = 36 * var_3;
  var_11 = 12 * var_4 + 8 * var_5;
  var_12 = 4 * var_6;
  var_13 = [];
  var_13[0] = 0;

  if(var_9 == 0) {
    if(var_10 == 0 && var_11 == 0 && var_12 == 0)
      return sqrt(var_7) / var_1;

    var_14 = scripts\models\interactive_utility::rootsofquadratic(var_10, var_11, var_12);

    if(isDefined(var_14[0]) && var_14[0] > 0 && var_14[0] < 1) {
      var_15 = 2 * var_10 * var_14[0] + var_11;

      if(var_15 < 0)
        var_13[var_13.size] = var_14[0];
    }

    if(isDefined(var_14[1]) && var_14[1] > 0 && var_14[1] < 1) {
      var_15 = 2 * var_10 * var_14[0] + var_11;

      if(var_15 < 0)
        var_13[var_13.size] = var_14[1];
    }
  } else {
    var_16 = scripts\models\interactive_utility::rootsofquadratic(3 * var_9, 2 * var_10, var_11);
    var_17 = 0;
    var_18[0] = 0;

    for(var_17 = 0; var_17 < var_16.size; var_17++) {
      if(var_16[var_17] > 0 && var_16[var_17] < 1)
        var_18[var_18.size] = var_16[var_17];
    }

    var_18[var_18.size] = 1;

    for(var_17 = 1; var_17 < var_18.size; var_17++) {
      var_19 = var_18[var_17 - 1];
      var_20 = var_18[var_17];
      var_21 = var_9 * var_19 * var_19 * var_19 + var_10 * var_19 * var_19 + var_11 * var_19 + var_12;
      var_22 = var_9 * var_20 * var_20 * var_20 + var_10 * var_20 * var_20 + var_11 * var_20 + var_12;

      if(var_21 > 0 && var_22 < 0)
        var_13[var_13.size] = scripts\models\interactive_utility::newtonsmethod(var_19, var_20, var_9, var_10, var_11, var_12, 0.02);
    }
  }

  var_13[var_13.size] = 1;
  var_9 = 9 * var_2;
  var_10 = 12 * var_3;
  var_11 = 6 * var_4 + 4 * var_5;
  var_12 = 4 * var_6;
  var_23 = var_7;
  var_24 = 0;

  foreach(var_26 in var_13) {
    var_27 = var_9 * var_26 * var_26 * var_26 * var_26 + var_10 * var_26 * var_26 * var_26 + var_11 * var_26 * var_26 + var_12 * var_26 + var_23;

    if(var_27 > var_24)
      var_24 = var_27;
  }

  return sqrt(var_24) / var_1;
}

csplineseg_calclengthbystepping(var_0, var_1) {
  var_2 = csplineseg_getpoint(var_0, 0);
  var_3 = 0;

  for(var_4 = 1; var_4 <= var_1; var_4++) {
    var_5 = var_4 / var_1;
    var_6 = csplineseg_getpoint(var_0, var_5);
    var_3 = var_3 + length(var_2["_encstr_9B1904D08FEB"] - var_6["_encstr_9B1904D08FEB"]);
    var_2 = var_6;
  }

  return var_3;
}

csplineseg_calctopspeedbystepping(var_0, var_1, var_2) {
  var_3 = csplineseg_getpoint(var_0, 0);
  var_4 = 0;

  for(var_5 = 1; var_5 <= var_1; var_5++) {
    var_6 = var_5 / var_1;
    var_7 = csplineseg_getpoint(var_0, var_6);
    var_8 = length(var_3["_encstr_9B1904D08FEB"] - var_7["_encstr_9B1904D08FEB"]);

    if(var_8 > var_4)
      var_4 = var_8;

    var_3 = var_7;
  }

  var_4 = var_4 * (var_1 / var_2);
  return var_4;
}

cspline_findpathnodes(var_0) {
  var_1 = var_0;
  var_2 = [];

  for(var_3 = 0; isDefined(var_1.target); var_3++) {
    var_2[var_3] = var_1;
    var_4 = var_1.target;
    var_1 = getnode(var_4, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_1)) {
      var_1 = getvehiclenode(var_4, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(!isDefined(var_1)) {
        var_1 = getEnt(var_4, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(!isDefined(var_1))
          var_1 = scripts\engine\utility::getStruct(var_4, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      }
    }
  }

  var_2[var_3] = var_1;
  return var_2;
}

cspline_makepath1seg(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = spawnStruct();
  var_4[0].origin = var_0;

  if(isDefined(var_2)) {
    var_4[0].speed = length(var_2);
    var_2 = var_2 / var_4[0].speed;
    var_4[0].speed = var_4[0].speed * 20;
  } else
    var_4[0].speed = 20;

  var_4[1] = spawnStruct();
  var_4[1].origin = var_1;

  if(isDefined(var_3)) {
    var_4[1].speed = length(var_3);
    var_3 = var_3 / var_4[1].speed;
    var_4[1].speed = var_4[1].speed * 20;
  } else
    var_4[1].speed = 20;

  return cspline_makepath(var_4, 1, var_2, var_3);
}

cspline_makepathtopoint(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(!isDefined(var_4))
    var_4 = 0;

  if(isDefined(var_2)) {
    var_6 = length(var_2);
    var_5[0] = var_2 / var_6;
    var_6 = var_6 * 20;
  } else
    var_6 = 20;

  if(isDefined(var_3)) {
    var_7 = length(var_3);
    var_5[1] = var_3 / var_7;
    var_7 = var_7 * 20;
  } else
    var_7 = 20;

  if(var_6 / var_7 > 1.2 || var_7 / var_6 > 1.2 || var_4) {
    if(!isDefined(var_5[0]))
      var_5[0] = (0, 0, 0);

    if(!isDefined(var_5[1]))
      var_5[1] = (0, 0, 0);
  }

  var_8 = var_1 - var_0;
  var_9 = length(var_8);
  var_10 = var_8 / var_9;
  var_11 = [];
  var_11[0] = spawnStruct();
  var_11[0].origin = var_0;
  var_11[0].speed = var_6;
  var_12 = [];
  var_13 = max(var_6, var_7);

  if(isDefined(var_5[0]))
    var_12[0] = (var_6 + var_13) / 40;

  if(isDefined(var_5[1]))
    var_12[1] = (var_7 + var_13) / 40;

  for(var_14 = 0; var_14 < 2; var_14++) {
    if(isDefined(var_5[var_14])) {
      var_15 = (0.5 - var_14) * 2;
      var_16 = var_5[var_14];
      var_16 = var_16 * var_15;
      var_17 = vectordot(var_16, var_10);

      if(var_17 * var_15 < 0.3 || var_6 / var_7 > 1.2 || var_7 / var_6 > 1.2 || var_4) {
        if(var_17 * var_15 < 0) {
          var_18 = var_17 * var_10;
          var_16 = var_16 - var_18;
          var_16 = vectorNormalize(var_16);
          var_16 = var_16 + var_18;
        }

        var_16 = var_16 + var_10 * var_15;
        var_16 = var_16 * var_12[var_14];
        var_16 = var_16 * (sqrt(var_9) * 2);
        var_11[var_11.size] = spawnStruct();

        if(var_14 == 0)
          var_11[var_11.size - 1].origin = var_0 + var_16;
        else
          var_11[var_11.size - 1].origin = var_1 + var_16;

        var_11[var_11.size - 1].speed = var_13;
      }
    }
  }

  var_19 = var_11.size;
  var_11[var_19] = spawnStruct();
  var_11[var_19].origin = var_1;
  var_11[var_19].speed = var_7;
  return cspline_makepath(var_11, 1, var_5[0], var_5[1]);
}

cspline_makepath(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.segments = [];

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_4))
    var_4 = 1;

  var_6 = 0;
  var_7 = [];

  for(var_8 = distance(var_0[0].origin, var_0[1].origin); isDefined(var_0[var_5.segments.size + 2]); var_5.segments[var_9].endat = var_6) {
    var_9 = var_5.segments.size;
    var_10 = var_0[var_9].origin;
    var_11 = var_0[var_9 + 1].origin;
    var_12 = var_0[var_9 + 2].origin;
    var_13 = var_8;
    var_8 = distance(var_0[var_9 + 1].origin, var_0[var_9 + 2].origin);
    var_14 = var_7;
    var_7 = cspline_calctangent(var_10, var_12, var_13, var_8, 0.5);

    if(var_9 == 0) {
      if(isDefined(var_2))
        var_14["_encstr_83DE09DEEA8E9DF62DDCEC"] = var_2 * var_13;
      else
        var_14 = cspline_calctangentnatural(var_10, var_11, var_7["_encstr_8A4F099025A3B8715A6B17"]);
    }

    if(var_4) {
      var_5.segments[var_9] = csplineseg_calccoeffscapspeed(var_10, var_11, var_14["_encstr_83DE09DEEA8E9DF62DDCEC"], var_7["_encstr_8A4F099025A3B8715A6B17"], var_13);
      var_6 = var_6 + var_5.segments[var_9].endat;
      continue;
    }

    var_5.segments[var_9] = csplineseg_calccoeffs(var_10, var_11, var_14["_encstr_83DE09DEEA8E9DF62DDCEC"], var_7["_encstr_8A4F099025A3B8715A6B17"]);
    var_6 = var_6 + var_13;
  }

  var_9 = var_5.segments.size;
  var_10 = var_0[var_9].origin;
  var_11 = var_0[var_9 + 1].origin;
  var_13 = var_8;
  var_14 = var_7;

  if(var_9 == 0 && isDefined(var_2))
    var_14["_encstr_83DE09DEEA8E9DF62DDCEC"] = var_2 * var_13;

  if(isDefined(var_3))
    var_7["_encstr_8A4F099025A3B8715A6B17"] = var_3 * var_13;
  else
    var_7 = cspline_calctangentnatural(var_10, var_11, var_14["_encstr_83DE09DEEA8E9DF62DDCEC"]);

  if(var_9 == 0 && !isDefined(var_2))
    var_14 = cspline_calctangentnatural(var_10, var_11, var_7["_encstr_8A4F099025A3B8715A6B17"]);

  if(var_4) {
    var_5.segments[var_9] = csplineseg_calccoeffscapspeed(var_10, var_11, var_14["_encstr_83DE09DEEA8E9DF62DDCEC"], var_7["_encstr_8A4F099025A3B8715A6B17"], var_13);
    var_6 = var_6 + var_5.segments[var_9].endat;
  } else {
    var_5.segments[var_9] = csplineseg_calccoeffs(var_10, var_11, var_14["_encstr_83DE09DEEA8E9DF62DDCEC"], var_7["_encstr_8A4F099025A3B8715A6B17"]);
    var_6 = var_6 + var_13;
  }

  var_5.segments[var_9].endat = var_6;

  if(var_1) {
    var_15 = 0;
    var_16 = 0;

    for(var_9 = 0; var_9 < var_5.segments.size; var_9++) {
      if(!isDefined(var_0[var_9 + 1].speed))
        var_0[var_9 + 1].speed = var_0[var_9].speed;

      var_13 = var_5.segments[var_9].endat - var_16;
      var_17 = 2 * var_13 / ((var_0[var_9].speed + var_0[var_9 + 1].speed) / 20);
      var_15 = var_15 + var_17;
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

cspline_movefirstpoint(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.segments = [];
  var_4 = csplineseg_getpoint(var_0.segments[0], 1);
  var_5 = var_4["_encstr_9B1904D08FEB"] - var_1;
  var_6 = length(var_5);
  var_3.segments[0] = csplineseg_calccoeffs(var_1, var_4["_encstr_9B1904D08FEB"], var_2 * var_6, var_4["_encstr_A11904EC2B36"]);
  var_3.segments[0].endtime = var_0.segments[0].endtime * var_6 / var_0.segments[0].endat;
  var_3.segments[0].endat = var_6;
  var_7 = var_6 - var_0.segments[0].endat;
  var_8 = var_3.segments[0].endtime - var_0.segments[0].endtime;

  for(var_9 = 1; var_9 < var_0.segments.size; var_9++) {
    var_3.segments[var_9] = csplineseg_copy(var_0.segments[var_9]);
    var_3.segments[var_9].endat = var_3.segments[var_9].endat + var_7;
    var_3.segments[var_9].endtime = var_3.segments[var_9].endtime + var_8;
  }

  return var_3;
}

cspline_getpointatdistance(var_0, var_1, var_2) {
  if(var_1 <= 0) {
    var_3 = var_0.segments[0].endat;
    var_4 = csplineseg_getpoint(var_0.segments[0], 0, var_3, var_0.segments[0].speedstart);
    return var_4;
  } else if(var_1 >= var_0.segments[var_0.segments.size - 1].endat) {
    if(var_0.segments.size > 1)
      var_3 = var_0.segments[var_0.segments.size - 1].endat - var_0.segments[var_0.segments.size - 2].endat;
    else
      var_3 = var_0.segments[var_0.segments.size - 1].endat;

    var_4 = csplineseg_getpoint(var_0.segments[var_0.segments.size - 1], 1, var_3, var_0.segments[var_0.segments.size - 1].speedend);
    return var_4;
  } else {
    for(var_5 = 0; var_0.segments[var_5].endat < var_1; var_5++) {}

    if(var_5 > 0)
      var_6 = var_0.segments[var_5 - 1].endat;
    else
      var_6 = 0;

    var_3 = var_0.segments[var_5].endat - var_6;
    var_7 = (var_1 - var_6) / var_3;
    var_8 = undefined;

    if(isDefined(var_2) && var_2)
      var_8 = cspline_speedfromdistance(var_0.segments[var_5].speedstart, var_0.segments[var_5].speedend, var_7);

    var_4 = csplineseg_getpoint(var_0.segments[var_5], var_7, var_3, var_8);
    return var_4;
  }
}

cspline_getpointattime(var_0, var_1) {
  if(var_1 <= 0) {
    var_2 = var_0.segments[0].endat;
    var_3 = csplineseg_getpoint(var_0.segments[0], 0, var_2, var_0.segments[0].speedstart);
    return var_3;
  } else if(var_1 >= var_0.segments[var_0.segments.size - 1].endtime) {
    if(var_0.segments.size > 1)
      var_2 = var_0.segments[var_0.segments.size - 1].endat - var_0.segments[var_0.segments.size - 2].endat;
    else
      var_2 = var_0.segments[var_0.segments.size - 1].endat;

    var_3 = csplineseg_getpoint(var_0.segments[var_0.segments.size - 1], 1, var_2, var_0.segments[var_0.segments.size - 1].speedend);
    return var_3;
  } else {
    for(var_4 = 0; var_0.segments[var_4].endtime < var_1; var_4++) {}

    if(var_4 > 0) {
      var_5 = var_0.segments[var_4 - 1].endtime;
      var_2 = var_0.segments[var_4].endat - var_0.segments[var_4 - 1].endat;
    } else {
      var_5 = 0;
      var_2 = var_0.segments[0].endat;
    }

    var_6 = var_0.segments[var_4].endtime - var_5;
    var_7 = (var_1 - var_5) / var_6;
    var_8 = var_0.segments[var_4].speedstart + var_7 * (var_0.segments[var_4].speedend - var_0.segments[var_4].speedstart);
    var_9 = (var_1 - var_5) * (var_0.segments[var_4].speedstart + var_8) / 2;
    var_10 = var_9 / var_2;
    var_3 = csplineseg_getpoint(var_0.segments[var_4], var_10, var_2, var_8);
    return var_3;
  }
}

cspline_speedfromdistance(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = (var_1 - var_0) * (var_1 + var_0) / 2;
  return sqrt(2 * var_4 * var_3 + var_0 * var_0);
}

cspline_adjusttime(var_0, var_1) {
  var_2 = cspline_time(var_0);
  var_3 = var_0.segments[0].endtime;
  var_4 = var_0.segments[var_0.segments.size - 2].endtime - var_3;
  var_5 = var_0.segments[var_0.segments.size - 1].endtime - var_0.segments[var_0.segments.size - 2].endtime;
  var_6 = 2 * var_3 + var_4 + 2 * var_5 - var_1;
  var_7 = (sqrt(var_6 * var_6 + 4 * var_4 * var_1) + var_6) / (2 * var_1);
  var_9 = undefined;
  var_10 = undefined;
  var_0.segments[0].speedend = var_0.segments[0].speedend * var_7;
  var_11 = var_0.segments[0].endtime * (1 / var_7 - 2 / (1 + var_7));
  var_0.segments[0].endtime = var_0.segments[0].endtime / ((1 + var_7) / 2);

  for(var_12 = 1; var_12 < var_0.segments.size - 1; var_12++) {
    var_13 = undefined;
    var_0.segments[var_12].speedstart = var_0.segments[var_12].speedstart * var_7;
    var_0.segments[var_12].speedend = var_0.segments[var_12].speedend * var_7;
    var_0.segments[var_12].endtime = var_0.segments[var_12].endtime / var_7;
    var_0.segments[var_12].endtime = var_0.segments[var_12].endtime - var_11;
  }

  var_12 = var_0.segments.size - 1;
  var_0.segments[var_12].speedstart = var_0.segments[var_12].speedstart * var_7;
  var_0.segments[var_12].endtime = var_1;
}

cspline_makenoisepath(var_0, var_1, var_2, var_3) {
  var_4 = cspline_makenoisepathnodes(var_0, var_1, var_2);

  if(isDefined(var_3))
    var_4[1].origin = var_3;

  var_5 = spawnStruct();
  var_5.origin = var_4[0].origin;
  var_4[var_4.size] = var_5;
  var_5 = spawnStruct();
  var_5.origin = var_4[1].origin;
  var_4[var_4.size] = var_5;
  var_5 = spawnStruct();
  var_5.origin = var_4[2].origin;
  var_4[var_4.size] = var_5;
  var_6 = cspline_makepath(var_4);
  var_7 = spawnStruct();
  var_7.segments = [];

  for(var_8 = 0; var_8 < var_6.segments.size - 2; var_8++) {
    var_7.segments[var_8] = csplineseg_copy(var_6.segments[var_8 + 1]);
    var_7.segments[var_8].endat = var_8 + 1;
  }

  return var_7;
}

cspline_makenoisepathnodes(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_3[var_4] = spawnStruct();
    var_5 = randomfloatrange(var_1[0], var_2[0]);
    var_6 = randomfloatrange(var_1[1], var_2[1]);
    var_7 = randomfloatrange(var_1[2], var_2[2]);
    var_3[var_4].origin = (var_5, var_6, var_7);
  }

  return var_3;
}

cspline_test(var_0, var_1) {}

cspline_testnodes(var_0, var_1) {
  var_2 = 20;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(isDefined(var_3))
      thread scripts\engine\utility::draw_arrow_time(var_3.origin, var_5.origin, (0, 1, 0), var_1);

    var_3 = var_5;
  }

  foreach(var_5 in var_0) {
    thread scripts\engine\utility::draw_line_for_time(var_5.origin - (var_2, 0, 0), var_5.origin + (var_2, 0, 0), 1, 1, 0, var_1);
    thread scripts\engine\utility::draw_line_for_time(var_5.origin - (0, var_2, 0), var_5.origin + (0, var_2, 0), 1, 1, 0, var_1);
    thread scripts\engine\utility::draw_line_for_time(var_5.origin - (0, 0, var_2), var_5.origin + (0, 0, var_2), 1, 1, 0, var_1);
  }
}

csplineseg_copy(var_0) {
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

cspline_length(var_0) {
  return var_0.segments[var_0.segments.size - 1].endat;
}

cspline_time(var_0) {
  return var_0.segments[var_0.segments.size - 1].endtime;
}

cspline_initnoise(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_5 = var_1;
  var_4.largestep = var_2;
  var_6 = (var_0[0] - var_5, var_0[1] - var_5, var_0[2] - var_5);
  var_7 = (var_0[0] + var_5, var_0[1] + var_5, var_0[2] + var_5);

  if(!isDefined(var_3))
    var_3 = (var_0[0], var_0[1], var_0[2] - var_5);

  var_4.largescale = cspline_makenoisepath(10, var_6, var_7, var_3);
  var_4.largescale.length = var_4.largescale.segments[var_4.largescale.segments.size - 1].endat;
  thread cspline_test(var_4.largescale, 20);
  return var_4;
}

cspline_noise(var_0, var_1) {
  var_2 = scripts\engine\utility::mod(var_1 / var_0.largestep, var_0.largescale.length);
  var_3 = cspline_getpointatdistance(var_0.largescale, var_2);
  return var_3["_encstr_9B1904D08FEB"];
}