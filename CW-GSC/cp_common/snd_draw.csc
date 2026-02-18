/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\snd_draw.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd_utility;
#namespace snd;

function function_669c57bc(posx, posy, text, color, alpha, scale, duration) {
  if(isDefined(text) == 0 || text == "<dev string:x38>") {
    return;
  }

  color = function_ea2f17d1(color, (1, 1, 1));
  alpha = function_ea2f17d1(alpha, 1);
  scale = function_ea2f17d1(scale, 1);
  duration = function_ea2f17d1(duration, 1);

  if(isscriptfunctionptr(level.var_44a79f1b) == 1) {
    [[level.var_44a79f1b]](posx, posy, text, color, alpha, scale, duration);
    return;
  }

  debug2dtext((posx, posy, 0), text, color, alpha, (0, 0, 0), 0, scale, duration);
}

function function_9f4eb444(text, scale) {
  assert(isDefined(text));

  if(isDefined(scale) == 0) {
    scale = 1;
  }

  var_1790a507 = function_827811b5();
  var_38c41a5e = var_1790a507[0];
  var_c13d121d = var_1790a507[1];
  textlength = text.size;
  textwidth = textlength * 11 * scale;
  centerx = var_38c41a5e * 0.5 - textwidth * 0.5;
  centery = var_c13d121d * 0.5 - 12;
  center = array(centerx, centery);
  return center;
}

function function_409c06e5(text, scale) {
  centerpos = function_9f4eb444(text, scale);
  var_fad221f1 = centerpos[0];
  var_ec8f856c = centerpos[1];
  var_ec8f856c = var_ec8f856c * 0.5 + 12;
  defaultpos = array(var_fad221f1, var_ec8f856c);
  return defaultpos;
}

function private function_ac3c5285(posx, posy, text, color, scale, fadeoutseconds, blinkseconds) {
  rowincrement = 24 * scale;
  frametime = function_6cfa7975();
  frametotal = int(fadeoutseconds / frametime);
  framecount = 0;
  blinkframes = int(blinkseconds / frametime);
  var_9a0d8dab = 1;
  blinkcount = 0;

  if(is_true(level._snd.var_8c37ff34)) {
    var_9a0d8dab = 2;
  }

  if(isarray(level.var_89c4a5f0) == 0) {
    level.var_89c4a5f0 = array();
  }

  assert(isarray(level.var_89c4a5f0));

  if(level.var_89c4a5f0.size > 0) {
    foreach(row in level.var_89c4a5f0) {
      if(isinarray(level.var_89c4a5f0, posy) == 1) {
        posy += rowincrement;
        continue;
      }

      break;
    }
  }

  level.var_89c4a5f0[level.var_89c4a5f0.size] = posy;

  while(framecount < frametotal) {
    if(framecount < blinkframes) {
      blinkstate = int(float(framecount) / float(var_9a0d8dab));
      blinkstate %= 2;

      if(blinkstate) {
        framecount += 1;
        waitframe(1);
        continue;
      }
    }

    framefrac = float(framecount) / float(frametotal);
    framefrac = math::clamp(framefrac, 0, 1);
    alpha = function_b918d683(1 - framefrac, "<dev string:x3c>");
    alphasq = alpha * alpha;
    colorscale = function_2677a7e2(color, alpha);
    function_65bb0ccd(text, posx, posy, scale, "<dev string:x47>", colorscale, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
    framecount += 1;
    waitframe(1);
  }

  if(isarray(level.var_89c4a5f0)) {
    arrayremovevalue(level.var_89c4a5f0, posy);
  }
}

function function_3ba3cecb(text, posx, posy, color, scale, fadeoutseconds, blinkseconds) {
  assert(isDefined(text) == 1);
  color = function_ea2f17d1(color, (1, 0.5, 0.5));
  scale = function_ea2f17d1(scale, 1.75);
  fadeoutseconds = function_ea2f17d1(fadeoutseconds, 4);
  blinkseconds = function_ea2f17d1(blinkseconds, 1);

  if(isDefined(posx) == 0 || isDefined(posy) == 0) {
    defaultpos = function_409c06e5(text, scale);

    if(isDefined(posx) == 0) {
      posx = defaultpos[0];
    }

    if(isDefined(posy) == 0) {
      posy = defaultpos[1];
    }
  }

  level thread function_ac3c5285(posx, posy, text, color, scale, fadeoutseconds, blinkseconds);
  println(text);
}

function snd_print3d(origin, text, color, alpha, scale, duration, centered) {
  print3d(origin, text, color, alpha, scale, duration, centered);
}

function function_4e22152d(origin, text, color, alpha, scale, duration, right) {
  print3d(text, color, alpha, scale, duration, right, 1);
}

function function_65bb0ccd(text, x, y, scale, var_6c897a55, color, alpha, shadowcolor, shadowalpha, lightcolor, lightalpha, duration) {
  color = function_ea2f17d1(color, (1, 1, 1));
  alpha = function_ea2f17d1(alpha, 1);
  scale = function_ea2f17d1(scale, 1);
  var_6c897a55 = function_ea2f17d1(var_6c897a55, "<dev string:x4c>");
  duration = function_ea2f17d1(duration, 1);
  offset = (0, 0, 0);
  width = 11 * scale * text.size;

  switch (var_6c897a55) {
    case 0:
    case # "left":
    case # "l":
    default:
      break;
    case 1:
    case # "c":
    case # "centered":
    case # "center":
      offset += (width * -0.5, 0, 0);
      break;
    case 2:
    case # "r":
    case # "right":
      offset += (width * -1, 0, 0);
      break;
  }

  if(isDefined(shadowcolor) == 1) {
    shadowoffset = 1;

    if(!isDefined(shadowalpha)) {
      shadowalpha = alpha * 0.7333;
    }

    position = (x + 1 * scale, y + 1 * scale, 0) + offset;
    function_669c57bc(position[0], position[1], text, shadowcolor, shadowalpha, scale, duration);
  }

  if(isDefined(lightcolor) == 1) {
    if(!isDefined(lightalpha)) {
      lightalpha = alpha * 0.7333;
    }

    position = (x + -0.666 * scale, y + -0.666 * scale, 0) + offset;
    function_669c57bc(position[0], position[1], text, lightcolor, lightalpha, scale, duration);
  }

  position = (x, y, 0) + offset;
  function_669c57bc(position[0], position[1], text, color, alpha, scale, duration);
}

function print3dplus(text, origin, scale, var_6c897a55, color, alpha, shadowcolor, shadowalpha, lightcolor, lightalpha, duration) {
  color = function_ea2f17d1(color, (1, 1, 1));
  alpha = function_ea2f17d1(alpha, 1);
  scale = function_ea2f17d1(scale, 1);
  var_6c897a55 = function_ea2f17d1(var_6c897a55, "<dev string:x4c>");
  duration = int(function_ea2f17d1(duration, 1));
  contsize = scale < 0;
  scale = abs(scale);
  textsize = text.size;

  if(issubstr(text, "<dev string:x54>")) {
    lines = strtok(text, "<dev string:x54>");

    if(isarray(lines) && lines.size > 1) {
      longest = 0;

      foreach(line in lines) {
        if(line.size > longest) {
          longest = line.size;
        }
      }

      textsize = longest;
    }
  }

  viewanglesright = (1, 0, 0);
  viewanglesup = (0, 0, 1);
  players = getplayerssafe();

  if(isarray(players) == 1 && isDefined(players[0])) {
    player = players[0];
    vieworigin = player getplayervieworigin();
    viewangles = player getplayerviewangles();
    viewanglesright = anglestoright(viewangles);
    viewanglesup = anglestoup(viewangles);

    if(contsize) {
      dist = distance(origin, vieworigin);
      var_7295dcac = dist * 0.00133333;
      scale *= var_7295dcac;
    }
  }

  width = 11 * scale * textsize;
  offset = (0, 0, 1 * scale * -1);
  offsetright = viewanglesright * offset[0];
  offsetup = viewanglesup * offset[2];
  centered = 0;

  switch (var_6c897a55) {
    case 0:
    case # "left":
    case # "l":
    default:
      break;
    case 1:
    case # "c":
    case # "centered":
    case # "center":
      centered = 1;
      break;
    case 2:
    case # "r":
    case # "right":
      offset += (width * -1, 0, 0);
      break;
  }

  if(isDefined(shadowcolor) == 1) {
    if(!isDefined(shadowalpha)) {
      shadowalpha = alpha * 0.72974;
    }

    shadowoffset = viewanglesright * 1 * scale + viewanglesup * -1 * scale;
    position = origin + viewanglesright * offset[0] + viewanglesup * offset[2];
    position += shadowoffset;
    print3d(position, text, shadowcolor, shadowalpha, scale, duration, centered);
  }

  if(isDefined(lightcolor) == 1) {
    if(!isDefined(lightalpha)) {
      lightalpha = alpha * 0.72974;
    }

    lightoffset = viewanglesright * -0.666 * scale + viewanglesup * 0.666 * scale;
    position = origin + viewanglesright * offset[0] + viewanglesup * offset[2];
    position += lightoffset;
    print3d(position, text, lightcolor, lightalpha, scale, duration, centered);
  }

  position = origin + viewanglesright * offset[0] + viewanglesup * offset[2];
  print3d(position, text, color, alpha, scale, duration, centered);
}

function private function_bfdce45f(color, depthtest, drawpatharray, offset) {
  if(drawpatharray.size < 2) {
    return;
  }

  linecount = drawpatharray.size - 1;
  alpha = 1;
  alphastep = 1 / linecount;
  colorscale = color;

  while(linecount > 0) {
    orgend = drawpatharray[linecount];
    orgstart = drawpatharray[linecount - 1];

    if(isvec(orgend) == 1 && isvec(orgstart) == 1 && orgend != orgstart) {
      if(isvec(offset) == 1) {
        orgend += offset;
        orgstart += offset;
      }

      line(orgend, orgstart, colorscale, alpha, depthtest, 1);
    }

    colorscale = vectorscale(color, alpha * 1.5);
    alpha -= alphastep;
    linecount--;
  }
}

function private function_6ee9efa7(color, depthtest, duration, offset) {
  assert(isDefined(self.origin) == 1, "<dev string:x59>");
  assert(isvec(color) == 1, "<dev string:x7e>");
  assert(isDefined(duration) == 1, "<dev string:x9c>");
  framecount = 0;
  drawpatharray = array();
  drawpatharray[0] = self.origin;
  self endon(#"hash_2605f8ddd93ed8f9");

  while(drawpatharray.size > 0) {
    var_c6150a06 = array();

    if(framecount >= duration) {
      for(i = 1; i < drawpatharray.size; i++) {
        var_c6150a06[i - 1] = drawpatharray[i];
      }
    } else {
      var_c6150a06 = drawpatharray;
    }

    if(isDefined(self) == 1 && isDefined(self.origin) == 1 && function_3132f113(self) == 0) {
      var_c6150a06[var_c6150a06.size] = self.origin;
    }

    drawpatharray = var_c6150a06;
    function_bfdce45f(color, depthtest, drawpatharray, offset);
    framecount++;
    waitframe(1);
  }
}

function snd_drawpath(movingobject, color, depthtest, duration, offset) {
  color = function_ea2f17d1(color, (1, 1, 1));
  depthtest = function_ea2f17d1(depthtest, 0);
  duration = function_ea2f17d1(duration, 5);

  if(function_81fac19d(!isDefined(movingobject), "<dev string:xbd>")) {
    return;
  }

  if(is_true(level._snd.var_8c37ff34)) {
    duration = int(60 * duration);
  } else {
    duration = int(20 * duration);
  }

  assert(duration > 2, "<dev string:xe5>");
  movingobject thread function_6ee9efa7(color, depthtest, duration, offset);
}

function function_a787fe30(origin, angles, extents, color, alpha, depthtest, duration) {
  half = extents * 0.5;
  halv = (half, half, half);
  mins = origin - halv;
  maxs = origin + halv;
  side1[0] = (maxs[0], maxs[1], maxs[2]);
  side1[1] = (maxs[0], maxs[1], mins[2]);
  side1[2] = (mins[0], maxs[1], mins[2]);
  side1[3] = (mins[0], maxs[1], maxs[2]);
  side2[0] = (maxs[0], mins[1], maxs[2]);
  side2[1] = (maxs[0], mins[1], mins[2]);
  side2[2] = (mins[0], mins[1], mins[2]);
  side2[3] = (mins[0], mins[1], maxs[2]);

  if(angles != (0, 0, 0)) {
    side1[0] = origin + rotatepoint(origin - side1[0], angles);
    side1[1] = origin + rotatepoint(origin - side1[1], angles);
    side1[2] = origin + rotatepoint(origin - side1[2], angles);
    side1[3] = origin + rotatepoint(origin - side1[3], angles);
    side2[0] = origin + rotatepoint(origin - side2[0], angles);
    side2[1] = origin + rotatepoint(origin - side2[1], angles);
    side2[2] = origin + rotatepoint(origin - side2[2], angles);
    side2[3] = origin + rotatepoint(origin - side2[3], angles);
  }

  for(i = 0; i < 4; i++) {
    j = i + 1;

    if(j == 4) {
      j = 0;
    }

    line(side1[i], side1[j], color, alpha, depthtest, duration);
    line(side2[i], side2[j], color, alpha, depthtest, duration);
    line(side1[i], side2[i], color, alpha, depthtest, duration);
  }
}

function cube(origin, angles, sidelength, color, alpha, depthtest, duration) {
  function_a787fe30(origin, angles, sidelength, color, alpha, depthtest, duration);
}

function debugcrosshair(origin, size, angles, color, alpha, depthtest, duration) {
  forward = (1, 0, 0);
  right = (0, 1, 0);
  up = (0, 0, 1);
  size = function_ea2f17d1(size, 16);
  angles = function_ea2f17d1(angles, (0, 0, 0));
  color = function_ea2f17d1(color, (1, 1, 1));
  alpha = function_ea2f17d1(alpha, 1);
  depthtest = function_ea2f17d1(depthtest, 0);
  duration = function_ea2f17d1(duration, 1);

  if(angles != (0, 0, 0)) {
    forward = anglesToForward(angles);
    right = anglestoright(angles) * -1;
    up = anglestoup(angles);
  }

  half = size * 0.5;
  forward *= half;
  right *= half;
  up *= half;
  mulc = 0.333;
  mulv = (mulc, mulc, mulc);
  colr = color * mulv + (1, 0, 0);
  colg = color * mulv + (0, 1, 0);
  colb = color * mulv + (0, 0, 1);
  line(origin - forward, origin + forward, colr, alpha, depthtest, duration);
  line(origin - right, origin + right, colg, alpha, depthtest, duration);
  line(origin - up, origin + up, colb, alpha, depthtest, duration);
}

function debugarrow(origin, angles, length, headsize, color, alpha, depthtest, duration) {
  assert(isvec(origin));
  assert(isvec(angles));
  length = function_ea2f17d1(length, 12);
  headsize = function_ea2f17d1(headsize, 4);
  color = function_ea2f17d1(color, (1, 1, 1));
  alpha = function_ea2f17d1(alpha, 1);
  depthtest = function_ea2f17d1(depthtest, 0);
  duration = int(function_ea2f17d1(duration, 1));
  arrow_forward = anglesToForward(angles);
  arrowhead_forward = arrow_forward;
  arrowhead_right = anglestoright(angles);
  arrowhead_up = anglestoup(angles);
  arrowhead_down = arrowhead_up;
  arrow_forward = vectorscale(arrow_forward, length);
  arrowhead_forward = vectorscale(arrowhead_forward, length - headsize);
  arrowhead_right = vectorscale(arrowhead_right, headsize);
  arrowhead_up = vectorscale(arrowhead_up, headsize);
  arrowhead_down = vectorscale(arrowhead_down, -1 * headsize);
  o = origin;
  a = o + arrow_forward;
  b = o + arrowhead_forward - arrowhead_right;
  c = o + arrowhead_forward + arrowhead_right;
  d = o + arrowhead_forward + arrowhead_up;
  e = o + arrowhead_forward + arrowhead_down;
  line(o, a, color, alpha, depthtest, duration);
  line(a, b, color, alpha, depthtest, duration);
  line(b, c, color, alpha, depthtest, duration);
  line(c, a, color, alpha, depthtest, duration);
  line(a, d, color, alpha, depthtest, duration);
  line(d, e, color, alpha, depthtest, duration);
  line(e, a, color, alpha, depthtest, duration);
}

function function_79f31114(screenheight) {
  var_bfd4f22d = 480 / screenheight;
  return var_bfd4f22d;
}

function function_df9f894b(var_841c640a, screensize) {
  screensize = function_ea2f17d1(screensize, function_827811b5());
  var_bfd4f22d = function_79f31114(screensize[1]);
  hudwidth = var_841c640a[0] * var_bfd4f22d;
  hudheight = var_841c640a[1] * var_bfd4f22d;
  return array(int(hudwidth), int(hudheight));
}

function function_da7b7c0e(var_841c640a, screensize) {
  screensize = function_ea2f17d1(screensize, function_827811b5());
  var_bfd4f22d = function_79f31114(screensize[1]);
  hudx = var_841c640a[0] * var_bfd4f22d;
  hudy = var_841c640a[1] * var_bfd4f22d;
  screenaspect = screensize[0] / screensize[1];
  var_73ea373d = screenaspect * 480;
  hudxoffset = -0.5 * (var_73ea373d - 640);
  hudx += hudxoffset;
  return array(hudx, hudy);
}