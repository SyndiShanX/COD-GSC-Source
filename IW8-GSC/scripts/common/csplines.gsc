/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\csplines.gsc
***********************************************/

function cspline_calctangent(var0, var1, var2, var3, var4) {
  var5 = [];
  var6 = [];

  for(var7 = 0; var7 < 3; var7++) {
    var5 = (1 - var4) * (var1[var7] - var0[var7]);
    var6 = var5[var7];
    var5 = var5[var7] * 2 * var2 / (var2 + var3);
    var6 = var6[var7] * 2 * var3 / (var2 + var3);
  }

  var8 = [];
  GscBinSkip0(0x2e, "incoming", (var5[0], var5[1], var5[2]));
}

function cspline_calctangenttcb(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = [];
  var9 = [];

  for(var10 = 0; var10 < 3; var10++) {
    var8 = (1 - var5) * (1 - var6) * (1 + var7) * 0.5 * (var1[var10] - var0[var10]);
    var8 = var8[var10] + (1 - var5) * (1 + var6) * (1 - var7) * 0.5 * (var2[var10] - var1[var10]);
    var8 = var8[var10] * 2 * var3 / (var3 + var4);
    var9 = (1 - var5) * (1 + var6) * (1 + var7) * 0.5 * (var1[var10] - var0[var10]);
    var9 = var9[var10] + (1 - var5) * (1 - var6) * (1 - var7) * 0.5 * (var2[var10] - var1[var10]);
    var9 = var9[var10] * 2 * var4 / (var3 + var4);
  }

  var11 = [];
  GscBinSkip0(0x2e, "incoming", (var8[0], var8[1], var8[2]));
}

function cspline_calctangentnatural(var0, var1, var2) {
  var3 = 3;
  var4 = [];
  var5 = [];

  if(isDefined(var2)) {
    for(var6 = 0; var6 < var3; var6++) {
      var4 = (-3 * var0[var6] + 3 * var1[var6] - var2[var6]) / 2;
      var5 = var4[var6];
    }
  } else {
    for(var6 = 0; var6 < var4; var6++) {
      var5 = var2[var6] - var1[var6];
      var6 = var2[var6] - var1[var6];
    }
  }

  var7 = [];
  GscBinSkip0(0x2e, "incoming", (var5[0], var5[1], var5[2]));
}

function csplineseg_calccoeffs(var0, var1, var2, var3) {
  var4 = 3;
  var5 = spawnStruct();
  var5.n3 = [];
  var5.n2 = [];
  var5.n = [];
  var5.c = [];

  for(var6 = 0; var6 < var4; var6++) {
    var5.n3[var6] = 2 * var0[var6] - 2 * var1[var6] + var2[var6] + var3[var6];
    var5.n2[var6] = -3 * var0[var6] + 3 * var1[var6] - 2 * var2[var6] - var3[var6];
    var5.n[var6] = var2[var6];
    var5.c[var6] = var0[var6];
  }

  return var5;
}

function csplineseg_calccoeffscapspeed(var0, var1, var2, var3, var4) {
  var5 = csplineseg_calccoeffs(var0, var1, var2, var3);
  var6 = csplineseg_calctopspeed(var5, var4);

  if(var6 > 1) {
    var4 *= var6;
    var2 /= var6;
    var3 /= var6;
    var5 = csplineseg_calccoeffs(var0, var1, var2, var3);
  }

  var5.endat = var4;
  return var5;
}

function cspline_getnodes(var0) {
  var1 = [];
  var2 = var0.segments[0].endat;
  var1 = csplineseg_getpoint(var0.segments[0], 0, var2, var0.segments[0].speedstart);
  var1["time"] = 0;
  var3 = 0;

  for(var4 = 0; var4 < var0.segments.size; var4++) {
    var2 = var0.segments[var4].endat - var3;
    var1 = csplineseg_getpoint(var0.segments[var4], 1, var2, var0.segments[var4].speedend);
    var5 = csplineseg_getpoint(var0.segments[var4], 0, var2, var0.segments[var4].speedstart);
    var1["acc_out"] = var5["acc"];
    var1["time"] = var0.segments[var4].endtime;
    var3 = var0.segments[var4].endat;
  }

  var1["acc_out"] = var1[var0.segments.size]["acc"];
  return var1;
}

function csplineseg_getpoint(var0, var1, var2, var3) {
  var4 = 3;
  var5 = [];
  var6 = [];
  var7 = [];
  var8 = [];

  for(var9 = 0; var9 < var4; var9++) {
    var5 = var0.n3[var9] * var1 * var1 * var1 + var0.n2[var9] * var1 * var1 + var0.n[var9] * var1 + var0.c[var9];
    var6 = 3 * var0.n3[var9] * var1 * var1 + 2 * var0.n2[var9] * var1 + var0.n[var9];
    var7 = 6 * var0.n3[var9] * var1 + 2 * var0.n2[var9];
  }

  var8 = (var5[0], var5[1], var5[2]);
  var8 = (var6[0], var6[1], var6[2]);
  var8 = (var7[0], var7[1], var7[2]);

  if(isDefined(var2)) {
    var8 = var8["vel"] / var2;
    var8 = var8["acc"] / var2 * var2;
  }

  if(isDefined(var3)) {
    var8 = var8["vel"] * var3;
    var8 = var8["acc"] * var3 * var3;
  }

  var8 = var3;
  return var8;
}

function csplineseg_calctopspeed(var0, var1) {
  var2 = csplineseg_calctopspeedbyderiving(var0, var1);
  return var2;
}

function csplineseg_calctopspeedbyderiving(var0, var1) {
  var2 = 0;
  var3 = 0;
  var4 = 0;
  var5 = 0;
  var6 = 0;
  var7 = 0;

  for(var8 = 0; var8 < 3; var8++) {
    var2 += var0.n3[var8] * var0.n3[var8];
    var3 += var0.n3[var8] * var0.n2[var8];
    var4 += var0.n3[var8] * var0.n[var8];
    var5 += var0.n2[var8] * var0.n2[var8];
    var6 += var0.n2[var8] * var0.n[var8];
    var7 += var0.n[var8] * var0.n[var8];
  }

  var9 = 36 * var2;
  var10 = 36 * var3;
  var11 = 12 * var4 + 8 * var5;
  var12 = 4 * var6;
  var13 = [];
  GscBinSkip0(0x2e, 0, 0);
}

function csplineseg_calclengthbystepping(var0, var1) {
  var2 = csplineseg_getpoint(var0, 0);
  var3 = 0;

  for(var4 = 1; var4 <= var1; var4++) {
    var5 = var4 / var1;
    var6 = csplineseg_getpoint(var0, var5);
    var3 += length(var2["pos"] - var6["pos"]);
    var2 = var6;
  }

  return var3;
}

function csplineseg_calctopspeedbystepping(var0, var1, var2) {
  var3 = csplineseg_getpoint(var0, 0);
  var4 = 0;

  for(var5 = 1; var5 <= var1; var5++) {
    var6 = var5 / var1;
    var7 = csplineseg_getpoint(var0, var6);
    var8 = length(var3["pos"] - var7["pos"]);

    if(var8 > var4) {
      var4 = var8;
    }

    var3 = var7;
  }

  var4 *= var1 / var2;
  return var4;
}

function cspline_findpathnodes(var0) {
  var1 = var0;
  var2 = [];

  for(var3 = 0; isDefined(var1.target); var3++) {
    var2 = var1;
    var4 = var1.target;
    var1 = getnode(var4, "targetname");

    if(!isDefined(var1)) {
      var1 = getvehiclenode(var4, "targetname");

      if(!isDefined(var1)) {
        var1 = getEnt(var4, "targetname");

        if(!isDefined(var1)) {
          var1 = scripts\engine\utility::getStruct(var4, "targetname");
        }
      }
    }
  }

  var2 = var1;
  return var2;
}

function cspline_makepath1seg(var0, var1, var2, var3) {
  var4 = [];
  GscBinSkip0(0x2e, 0, spawnStruct());
}

function cspline_makepathtopoint(var0, var1, var2, var3, var4) {
  var5 = [];

  if(!isDefined(var4)) {
    var4 = 0;
  }

  if(isDefined(var2)) {
    var6 = length(var2);
    var5 = var2 / var6;
    var6 *= 20;
  } else {
    var6 = 20;
  }

  if(isDefined(var4)) {
    var7 = length(var4);
    var6 = var4 / var7;
    var7 *= 20;
  } else {
    var7 = 20;
  }

  if(var7 / var7 > 1.2 || var7 / var7 > 1.2 || var6) {
    if(!isDefined(var6[0])) {
      var6 = (0, 0, 0);
    }

    if(!isDefined(var6[1])) {
      var6 = (0, 0, 0);
    }
  }

  var8 = var3 - var2;
  var9 = length(var8);
  var10 = var8 / var9;
  var11 = [];
  GscBinSkip0(0x2e, 0, spawnStruct());
}

function cspline_makepath(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var5.segments = [];

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var4)) {
    var4 = 1;
  }

  var6 = 0;
  var7 = [];
  var8 = distance(var0[0].origin, var0[1].origin);

  while(isDefined(var0[var5.segments.size + 2])) {
    var9 = var5.segments.size;
    var10 = var0[var9].origin;
    var11 = var0[var9 + 1].origin;
    var12 = var0[var9 + 2].origin;
    var13 = var8;
    var8 = distance(var0[var9 + 1].origin, var0[var9 + 2].origin);
    var14 = var7;
    var7 = cspline_calctangent(var10, var12, var13, var8, 0.5);

    if(var9 == 0) {
      if(isDefined(var2)) {
        GscBinSkip0(0x2e, "outgoing", var2 * var13);
      }

      var14 = cspline_calctangentnatural(var10, var11, var7["incoming"]);
    }

    if(var4) {
      var5.segments[var9] = csplineseg_calccoeffscapspeed(var10, var11, var14["outgoing"], var7["incoming"], var13);
      var6 += var5.segments[var9].endat;
    } else {
      var5.segments[var9] = csplineseg_calccoeffs(var10, var11, var14["outgoing"], var7["incoming"]);
      var6 += var13;
    }

    var5.segments[var9].endat = var6;
  }

  var9 = var5.segments.size;
  var10 = var0[var9].origin;
  var11 = var0[var9 + 1].origin;
  var13 = var8;
  var14 = var7;

  if(var9 == 0 && isDefined(var2)) {
    GscBinSkip0(0x2e, "outgoing", var2 * var13);
  }

  if(isDefined(var3)) {
    var7 = var3 * var13;
  } else {
    var7 = cspline_calctangentnatural(var10, var11, var14["outgoing"]);
  }

  if(var9 == 0 && !isDefined(var2)) {
    var14 = cspline_calctangentnatural(var10, var11, var7["incoming"]);
  }

  if(var4) {
    var5.segments[var9] = csplineseg_calccoeffscapspeed(var10, var11, var14["outgoing"], var7["incoming"], var13);
    var6 += var5.segments[var9].endat;
  } else {
    var5.segments[var9] = csplineseg_calccoeffs(var10, var11, var14["outgoing"], var7["incoming"]);
    var6 += var13;
  }

  var5.segments[var9].endat = var6;

  if(var1) {
    var15 = 0;
    var16 = 0;

    for(var9 = 0; var9 < var5.segments.size; var9++) {
      if(!isDefined(var0[var9 + 1].speed)) {
        var0[var9 + 1].speed = var0[var9].speed;
      }

      var13 = var5.segments[var9].endat - var16;
      var17 = 2 * var13 / (var0[var9].speed + var0[var9 + 1].speed) / 20;
      var15 += var17;
      var5.segments[var9].endtime = var15;
      var16 = var5.segments[var9].endat;
      var5.segments[var9].speedstart = var0[var9].speed / 20;
      var5.segments[var9].speedend = var0[var9 + 1].speed / 20;
    }
  } else {
    for(var9 = 0; var9 < var5.segments.size; var9++) {
      var5.segments[var9].endtime = var5.segments[var9].endat;
      var5.segments[var9].speedstart = 1;
      var5.segments[var9].speedend = 1;
    }
  }

  return var5;
}

function cspline_movefirstpoint(var0, var1, var2) {
  var3 = spawnStruct();
  var3.segments = [];
  var4 = csplineseg_getpoint(var0.segments[0], 1);
  var5 = var4["pos"] - var1;
  var6 = length(var5);
  var3.segments[0] = csplineseg_calccoeffs(var1, var4["pos"], var2 * var6, var4["vel"]);
  var3.segments[0].endtime = var0.segments[0].endtime * var6 / var0.segments[0].endat;
  var3.segments[0].endat = var6;
  var7 = var6 - var0.segments[0].endat;
  var8 = var3.segments[0].endtime - var0.segments[0].endtime;

  for(var9 = 1; var9 < var0.segments.size; var9++) {
    var3.segments[var9] = csplineseg_copy(var0.segments[var9]);
    var3.segments[var9].endat += var7;
    var3.segments[var9].endtime += var8;
  }

  return var3;
}

function cspline_getpointatdistance(var0, var1, var2) {
  if(var1 <= 0) {
    var3 = var0.segments[0].endat;
    var4 = csplineseg_getpoint(var0.segments[0], 0, var3, var0.segments[0].speedstart);
    return var4;
  }

  if(var3 >= var2.segments[var2.segments.size - 1].endat) {
    if(var2.segments.size > 1) {
      var3 = var2.segments[var2.segments.size - 1].endat - var2.segments[var2.segments.size - 2].endat;
    } else {
      var3 = var3.segments[var3.segments.size - 1].endat;
    }

    var4 = csplineseg_getpoint(var3.segments[var3.segments.size - 1], 1, var3, var3.segments[var3.segments.size - 1].speedend);
    return var4;
  }

  for(var5 = 0; var3.segments[var5].endat < var3; var5++) {}

  if(var5 > 0) {
    var6 = var3.segments[var5 - 1].endat;
  } else {
    var6 = 0;
  }

  var3 = var3.segments[var6].endat - var6;
  var7 = (var4 - var6) / var3;
  var8 = undefined;

  if(isDefined(var5) && var5) {
    var8 = cspline_speedfromdistance(var3.segments[var6].speedstart, var3.segments[var6].speedend, var7);
  }

  var4 = csplineseg_getpoint(var3.segments[var6], var7, var3, var8);
  return var4;
}

function cspline_getpointattime(var0, var1) {
  if(var1 <= 0) {
    var2 = var0.segments[0].endat;
    var3 = csplineseg_getpoint(var0.segments[0], 0, var2, var0.segments[0].speedstart);
    return var3;
  }

  if(var3 >= var2.segments[var2.segments.size - 1].endtime) {
    if(var2.segments.size > 1) {
      var2 = var2.segments[var2.segments.size - 1].endat - var2.segments[var2.segments.size - 2].endat;
    } else {
      var2 = var3.segments[var3.segments.size - 1].endat;
    }

    var3 = csplineseg_getpoint(var3.segments[var3.segments.size - 1], 1, var2, var3.segments[var3.segments.size - 1].speedend);
    return var3;
  }

  for(var4 = 0; var2.segments[var4].endtime < var3; var4++) {}

  if(var4 > 0) {
    var5 = var2.segments[var4 - 1].endtime;
    var2 = var2.segments[var4].endat - var2.segments[var4 - 1].endat;
  } else {
    var5 = 0;
    var2 = var4.segments[0].endat;
  }

  var6 = var4.segments[var2].endtime - var5;
  var7 = (var5 - var5) / var6;
  var8 = var4.segments[var2].speedstart + var7 * (var4.segments[var2].speedend - var4.segments[var2].speedstart);
  var9 = (var5 - var5) * (var4.segments[var2].speedstart + var8) / 2;
  var10 = var9 / var2;
  var3 = csplineseg_getpoint(var4.segments[var2], var10, var2, var8);
  return var3;
}

function cspline_speedfromdistance(var0, var1, var2) {
  var3 = var2;
  var4 = (var1 - var0) * (var1 + var0) / 2;
  return sqrt(2 * var4 * var3 + var0 * var0);
}

function cspline_adjusttime(var0, var1) {
  var2 = cspline_time(var0);
  var3 = var0.segments[0].endtime;
  var4 = var0.segments[var0.segments.size - 2].endtime - var3;
  var5 = var0.segments[var0.segments.size - 1].endtime - var0.segments[var0.segments.size - 2].endtime;
  var6 = 2 * var3 + var4 + 2 * var5 - var1;
  var7 = (sqrt(var6 * var6 + 4 * var4 * var1) + var6) / 2 * var1;
  var9 = undefined;
  var10 = undefined;
  var0.segments[0].speedend *= var7;
  var11 = var0.segments[0].endtime * (1 / var7 - 2 / (1 + var7));
  var0.segments[0].endtime /= (1 + var7) / 2;

  for(var12 = 1; var12 < var0.segments.size - 1; var12++) {
    var13 = undefined;
    var0.segments[var12].speedstart *= var7;
    var0.segments[var12].speedend *= var7;
    var0.segments[var12].endtime /= var7;
    var0.segments[var12].endtime -= var11;
  }

  var12 = var0.segments.size - 1;
  var0.segments[var12].speedstart *= var7;
  var0.segments[var12].endtime = var1;
}

function cspline_makenoisepath(var0, var1, var2, var3) {
  var4 = cspline_makenoisepathnodes(var0, var1, var2);

  if(isDefined(var3)) {
    var4[1].origin = var3;
  }

  var5 = spawnStruct();
  var5.origin = var4[0].origin;
  var4 = var5;
  var5 = spawnStruct();
  var5.origin = var4[1].origin;
  var4 = var5;
  var5 = spawnStruct();
  var5.origin = var4[2].origin;
  var4 = var5;
  var6 = cspline_makepath(var4);
  var7 = spawnStruct();
  var7.segments = [];

  for(var8 = 0; var8 < var6.segments.size - 2; var8++) {
    var7.segments[var8] = csplineseg_copy(var6.segments[var8 + 1]);
    var7.segments[var8].endat = var8 + 1;
  }

  return var7;
}

function cspline_makenoisepathnodes(var0, var1, var2) {
  var3 = [];

  for(var4 = 0; var4 < var0; var4++) {
    var3 = spawnStruct();
    var5 = randomfloatrange(var1[0], var2[0]);
    var6 = randomfloatrange(var1[1], var2[1]);
    var7 = randomfloatrange(var1[2], var2[2]);
    var3[var4].origin = (var5, var6, var7);
  }

  return var3;
}

function cspline_test(var0, var1) {}

function cspline_testnodes(var0, var1) {
  var2 = 20;
  var3 = undefined;

  foreach(var5 in var0) {
    if(isDefined(var3)) {
      thread scripts\engine\utility::draw_arrow_time(var3.origin, var5.origin, (0, 1, 0), var1);
    }

    var3 = var5;
  }

  foreach(var5 in var0) {
    thread scripts\engine\utility::draw_line_for_time(var5.origin - (var2, 0, 0), var5.origin + (var2, 0, 0), 1, 1, 0, var1);
    thread scripts\engine\utility::draw_line_for_time(var5.origin - (0, var2, 0), var5.origin + (0, var2, 0), 1, 1, 0, var1);
    thread scripts\engine\utility::draw_line_for_time(var5.origin - (0, 0, var2), var5.origin + (0, 0, var2), 1, 1, 0, var1);
  }
}

function csplineseg_copy(var0) {
  var1 = spawnStruct();
  var2 = 3;

  for(var3 = 0; var3 < var2; var3++) {
    var1.n3[var3] = var0.n3[var3];
    var1.n2[var3] = var0.n2[var3];
    var1.n[var3] = var0.n[var3];
    var1.c[var3] = var0.c[var3];
  }

  var1.endat = var0.endat;
  var1.endtime = var0.endtime;
  return var1;
}

function cspline_length(var0) {
  return var0.segments[var0.segments.size - 1].endat;
}

function cspline_time(var0) {
  return var0.segments[var0.segments.size - 1].endtime;
}

function cspline_initnoise(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var5 = var1;
  var4.largestep = var2;
  var6 = (var0[0] - var5, var0[1] - var5, var0[2] - var5);
  var7 = (var0[0] + var5, var0[1] + var5, var0[2] + var5);

  if(!isDefined(var3)) {
    var3 = (var0[0], var0[1], var0[2] - var5);
  }

  var4.largescale = cspline_makenoisepath(10, var6, var7, var3);
  var4.largescale.length = var4.largescale.segments[var4.largescale.segments.size - 1].endat;
  thread cspline_test(var4.largescale, 20);
  return var4;
}

function cspline_noise(var0, var1) {
  var2 = scripts\engine\utility::mod(var1 / var0.largestep, var0.largescale.length);
  var3 = cspline_getpointatdistance(var0.largescale, var2);
  return var3["pos"];
}