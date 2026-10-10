/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\debug.gsc
***********************************************/

#namespace debug;

function drawent(ent, radius, forwardlen, drawtimeseconds, color) {
  drawframes = int(drawtimeseconds / level.framedurationseconds);

  for(frame = 0; frame < drawframes; frame++) {
    sphere(ent.origin, radius, color);
    line(ent.origin, ent.origin + anglesToForward(ent.angles) * forwardlen, color);
    waitframe();
  }
}

function drawline(start, end, drawtimeseconds, color) {
  drawframes = int(drawtimeseconds / level.framedurationseconds);

  for(frame = 0; frame < drawframes; frame++) {
    line(start, end, color);
    waitframe();
  }
}

function drawsphere(origin, radius, drawtimeseconds, color) {
  drawframes = int(drawtimeseconds / level.framedurationseconds);

  for(frame = 0; frame < drawframes; frame++) {
    sphere(origin, radius, color);
    waitframe();
  }
}

function drawangles(origin, angles, var_3e6845817408f87e, scalar) {
  if(!isDefined(scalar)) {
    scalar = 1;
  }

  drawframes = int(var_3e6845817408f87e / level.framedurationseconds);

  for(frame = 0; frame < drawframes; frame++) {
    fwd = anglesToForward(angles);
    right = anglestoright(angles);
    up = anglestoup(angles);
    line(origin, origin + fwd * 12 * scalar, (1, 0, 0));
    line(origin, origin + right * 12 * scalar, (0, 1, 0));
    line(origin, origin + up * 12 * scalar, (0, 0, 1));
    waitframe();
  }
}

# /