/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_19163c4e4e504a5e.gsc
*****************************************************/

#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#namespace snd;

function print2d(posx, posy, text, color, alpha, scale, duration) {
  if(isDefined(text) == 0 || text == "<dev string:x24>") {
    return;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  if(!isDefined(duration)) {
    duration = 1;
  }

  if(function_9b68307805c4b4f1(level.snd.callbacks["<dev string:x28>"])) {
    [[level.snd.callbacks["<dev string:x28>"]]](posx, posy, text, color, alpha, scale, duration);
    return;
  }

  printtoscreen2d(posx, posy, text, color, scale);
}

function function_1b2e22d484285c2a(text, scale) {
  assert(isDefined(text));

  if(isDefined(scale) == 0) {
    scale = 1;
  }

  vidresolution = function_e8dca3401a4ad001();
  vidwidth = vidresolution[0];
  vidheight = vidresolution[1];
  textlength = text.size;
  textwidth = textlength * 8 * scale;
  centerx = vidwidth * 0.5 - textwidth * 0.5;
  centery = vidheight * 0.5 - 8;
  center = [centerx, centery];
  return center;
}

function function_fbd4a08035ec510c(text, scale) {
  centerpos = function_1b2e22d484285c2a(text, scale);
  defaultposx = centerpos[0];
  defaultposy = centerpos[1];
  defaultposy = defaultposy * 0.5 + 8;
  defaultpos = [defaultposx, defaultposy];
  return defaultpos;
}

function private function_e89cf15b80a210cb(posx, posy, text, color, scale, fadeoutseconds, blinkseconds) {
  rowincrement = 16 * scale;
  frametime = function_7c0b49ad82cf43cd();
  frametotal = int(fadeoutseconds / frametime);
  framecount = 0;
  blinkframes = int(blinkseconds / frametime);
  var_80acf2e03e3a4986 = 1;
  blinkcount = 0;

  if(istrue(level.snd.var_47d98b44f58f4910)) {
    var_80acf2e03e3a4986 = 2;
  }

  assert(isstruct(level.snd), "<dev string:x37>");

  if(isarray(level.snd.var_3c110c3a23f14a9b) == 0) {
    level.snd.var_3c110c3a23f14a9b = [];
  }

  assert(isarray(level.snd.var_3c110c3a23f14a9b));

  if(level.snd.var_3c110c3a23f14a9b.size > 0) {
    foreach(row in level.snd.var_3c110c3a23f14a9b) {
      if(arraycontains(level.snd.var_3c110c3a23f14a9b, posy)) {
        posy += rowincrement;
        continue;
      }

      break;
    }
  }

  level.snd.var_3c110c3a23f14a9b[level.snd.var_3c110c3a23f14a9b.size] = posy;

  while(framecount < frametotal) {
    if(framecount < blinkframes) {
      blinkstate = int(float(framecount) / float(var_80acf2e03e3a4986));
      blinkstate %= 2;

      if(blinkstate) {
        framecount += 1;
        waitframe();
        continue;
      }
    }

    framefrac = float(framecount) / float(frametotal);
    framefrac = clamp(framefrac, 0, 1);
    alpha = curve_value(1 - framefrac, "<dev string:x53>");
    alphasq = alpha * alpha;
    colorscale = function_91e4e5dcd3f773b0(color, alpha);
    function_f2aaa10b4546fafb(text, posx, posy, scale, "<dev string:x5e>", colorscale, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
    framecount += 1;
    waitframe();
  }

  if(isarray(level.snd.var_3c110c3a23f14a9b)) {
    level.snd.var_3c110c3a23f14a9b = arrayremove(level.snd.var_3c110c3a23f14a9b, posy);
  }
}

function function_9c0efd22ee470aa6(text, posx, posy, color, scale, fadeoutseconds, blinkseconds) {
  assert(isDefined(text));

  if(!isDefined(color)) {
    color = (1, 0.5, 0.5);
  }

  if(!isDefined(scale)) {
    scale = 1.75;
  }

  if(!isDefined(fadeoutseconds)) {
    fadeoutseconds = 4;
  }

  if(!isDefined(blinkseconds)) {
    blinkseconds = 1;
  }

  if(isDefined(posx) == 0 || isDefined(posy) == 0) {
    defaultpos = function_fbd4a08035ec510c(text, scale);

    if(isDefined(posx) == 0) {
      posx = defaultpos[0];
    }

    if(isDefined(posy) == 0) {
      posy = defaultpos[1];
    }
  }

  level thread function_e89cf15b80a210cb(posx, posy, text, color, scale, fadeoutseconds, blinkseconds);
  println(text);
}

function function_a7ef7da4373c5851(var_ee6f9ce0ae866370) {
  assert(isstruct(level.snd), "<dev string:x37>");

  if(isDefined(var_ee6f9ce0ae866370) && var_ee6f9ce0ae866370 != 0) {
    level.snd.debughudactive = 1;
    return;
  }

  level.snd.debughudactive = undefined;
}

function print3d(origin, text, color, alpha, scale, duration, centered) {
  print3d(origin, text, color, alpha, scale, duration, centered);
}

function print3dcentered(origin, text, color, alpha, scale, duration, right) {
  print3d(origin, text, color, alpha, scale, duration, 1);
}

function function_f2aaa10b4546fafb(text, x, y, scale, var_249406f4623258de, color, alpha, shadowcolor, shadowalpha, lightcolor, lightalpha, duration) {
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  if(!isDefined(var_249406f4623258de)) {
    var_249406f4623258de = "<dev string:x63>";
  }

  if(!isDefined(duration)) {
    duration = 1;
  }

  offset = (0, 0, 0);
  width = 8 * scale * text.size;

  switch (var_249406f4623258de) {
    case 0:
    case #"hash_311044bc01bd8beb":
    case #"hash_c9b3133a17a3b2d0":
    default:
      break;
    case 1:
    case #"hash_311041bc01bd8732":
    case #"hash_5a33ecbc44e76355":
    case #"hash_bf1a695c21e57fe4":
      offset += (width * -0.5, 0, 0);
      break;
    case 2:
    case #"hash_311052bc01bda1f5":
    case #"hash_96815ce4f2a3dbc5":
      offset += (width * -1, 0, 0);
      break;
  }

  lightcolor = undefined;

  if(isDefined(shadowcolor)) {
    shadowoffset = 1;

    if(!isDefined(shadowalpha)) {
      shadowalpha = alpha * 0.7333;
    }

    position = (x + 1.333 * scale, y + 1.333 * scale, 0) + offset;
    print2d(position[0], position[1], text, shadowcolor, shadowalpha, scale, duration);
  }

  if(isDefined(lightcolor)) {
    if(!isDefined(lightalpha)) {
      lightalpha = alpha * 0.7333;
    }

    position = (x + -0.666 * scale, y + -0.666 * scale, 0) + offset;
    print2d(position[0], position[1], text, lightcolor, lightalpha, scale, duration);
  }

  position = (x, y, 0) + offset;
  print2d(position[0], position[1], text, color, alpha, scale, duration);
}

function print3dplus(text, origin, scale, var_249406f4623258de, color, alpha, shadowcolor, shadowalpha, lightcolor, lightalpha, duration) {
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  if(!isDefined(var_249406f4623258de)) {
    var_249406f4623258de = "<dev string:x63>";
  }

  duration = int(duration ?? 1);
  contsize = scale < 0;
  scale = abs(scale);
  textsize = text.size;

  if(issubstr(text, "<dev string:x94>")) {
    lines = strtok(text, "<dev string:x94>");

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

  if(isarray(players) && isDefined(players[0])) {
    player = players[0];
    vieworigin = player getplayervieworigin();
    viewangles = player getplayerviewangles();
    viewanglesright = anglestoright(viewangles);
    viewanglesup = anglestoup(viewangles);

    if(contsize) {
      dist = distance(origin, vieworigin);
      fixeddistscalar = dist * 0.00133333;
      scale *= fixeddistscalar;
    }
  }

  width = 8 * scale * textsize;
  offset = (0, 0, 2 * scale * -1);
  offsetright = viewanglesright * offset[0];
  offsetup = viewanglesup * offset[2];
  centered = 0;

  switch (var_249406f4623258de) {
    case 0:
    case #"hash_311044bc01bd8beb":
    case #"hash_c9b3133a17a3b2d0":
    default:
      break;
    case 1:
    case #"hash_311041bc01bd8732":
    case #"hash_5a33ecbc44e76355":
    case #"hash_bf1a695c21e57fe4":
      centered = 1;
      break;
    case 2:
    case #"hash_311052bc01bda1f5":
    case #"hash_96815ce4f2a3dbc5":
      offset += (width * -1, 0, 0);
      break;
  }

  shadowcolor = undefined;
  lightcolor = undefined;

  if(isDefined(shadowcolor)) {
    if(!isDefined(shadowalpha)) {
      shadowalpha = alpha * 0.72974;
    }

    shadowoffset = viewanglesright * 1.333 * scale + viewanglesup * -1.333 * scale;
    position = origin + viewanglesright * offset[0] + viewanglesup * offset[2];
    position += shadowoffset;
    print3d(position, text, shadowcolor, shadowalpha, scale, duration, centered);
  }

  if(isDefined(lightcolor)) {
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

function private function_1c59d867f1c40747(color, depthtest, drawpatharray, offset) {
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

    if(isvector(orgend) && isvector(orgstart) && orgend != orgstart) {
      if(isvector(offset)) {
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

function private function_9905dc71e97718d4(color, depthtest, duration, offset) {
  assert(isDefined(self.origin), "<dev string:x99>");
  assert(isvector(color), "<dev string:xbf>");
  assert(isDefined(duration), "<dev string:xde>");
  framecount = 0;
  drawpatharray = [];
  drawpatharray[0] = self.origin;
  self endon("<dev string:x100>");

  while(drawpatharray.size > 0) {
    temppatharray = [];

    if(framecount >= duration) {
      for(i = 1; i < drawpatharray.size; i++) {
        temppatharray[i - 1] = drawpatharray[i];
      }
    } else {
      temppatharray = drawpatharray;
    }

    if(isDefined(self) && isDefined(self.origin) && function_cd79b44ba8163808(self) == 0) {
      temppatharray[temppatharray.size] = self.origin;
    }

    drawpatharray = temppatharray;
    function_1c59d867f1c40747(color, depthtest, drawpatharray, offset);
    framecount++;
    waitframe();
  }
}

function drawpath(movingobject, color, depthtest, duration, offset) {
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  if(!isDefined(duration)) {
    duration = 5;
  }

  if(condition_alert(!isDefined(movingobject), "<dev string:x115>")) {
    return;
  }

  if(istrue(level.snd.var_47d98b44f58f4910)) {
    duration = int(60 * duration);
  } else {
    duration = int(20 * duration);
  }

  assert(duration > 2, "<dev string:x13e>");
  movingobject thread function_9905dc71e97718d4(color, depthtest, duration, offset);
}

function function_459aa847ffd20427(origin, angles, extents, color, alpha, depthtest, duration) {
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
    side1[0] = origin + rotatevector(origin - side1[0], angles);
    side1[1] = origin + rotatevector(origin - side1[1], angles);
    side1[2] = origin + rotatevector(origin - side1[2], angles);
    side1[3] = origin + rotatevector(origin - side1[3], angles);
    side2[0] = origin + rotatevector(origin - side2[0], angles);
    side2[1] = origin + rotatevector(origin - side2[1], angles);
    side2[2] = origin + rotatevector(origin - side2[2], angles);
    side2[3] = origin + rotatevector(origin - side2[3], angles);
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
  function_459aa847ffd20427(origin, angles, sidelength, color, alpha, depthtest, duration);
}

function debugcrosshair(origin, size, angles, color, alpha, depthtest, duration) {
  forward = (1, 0, 0);
  right = (0, 1, 0);
  up = (0, 0, 1);

  if(!isDefined(size)) {
    size = 16;
  }

  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  if(!isDefined(duration)) {
    duration = 1;
  }

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
  assert(isvector(origin));
  assert(isvector(angles));

  if(!isDefined(length)) {
    length = 12;
  }

  if(!isDefined(headsize)) {
    headsize = 4;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  duration = int(duration ?? 1);
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

function linesphere(origin, radius, color, alpha, depthtest, duration) {
  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  if(!isDefined(duration)) {
    duration = 1;
  }

  sphere(origin, radius, color, depthtest, duration);
}

function function_78890743df998dae(screenheight) {
  var_5ffdf6cfc742d8a3 = 480 / screenheight;
  return var_5ffdf6cfc742d8a3;
}

function function_7ba1049293156590(coordinates, screensize = function_e8dca3401a4ad001()) {
  var_5ffdf6cfc742d8a3 = function_78890743df998dae(screensize[1]);
  hudwidth = coordinates[0] * var_5ffdf6cfc742d8a3;
  hudheight = coordinates[1] * var_5ffdf6cfc742d8a3;
  return [int(hudwidth), int(hudheight)];
}

function function_a89635a5ad4f8a73(coordinates, screensize = function_e8dca3401a4ad001()) {
  var_5ffdf6cfc742d8a3 = function_78890743df998dae(screensize[1]);
  hudx = coordinates[0] * var_5ffdf6cfc742d8a3;
  hudy = coordinates[1] * var_5ffdf6cfc742d8a3;
  screenaspect = screensize[0] / screensize[1];
  var_967e1b741b949f86 = screenaspect * 480;
  hudxoffset = -0.5 * (var_967e1b741b949f86 - 640);
  hudx += hudxoffset;
  return [hudx, hudy];
}

function private function_e6f0d8b8ff3f1b12() {
  if(isDefined(level.snd.debughudthread)) {
    return;
  }

  level.snd.debughudthread = getthread();

  while(isDefined(level.snd.debughuds)) {
    now = gettime();
    audiodebughuds = [];

    foreach(hud in level.snd.debughuds) {
      assert(function_cd79b44ba8163808(hud) == 0);

      if(hud.duration > 0) {
        audiodebughuds[audiodebughuds.size] = hud;

        if(hud.time == now) {
          continue;
        }

        hud.duration -= 1;

        if(hud.timeofdeath <= now) {
          hud.alpha = 0;
          hud settext("");
        }

        continue;
      }

      hud destroy();
    }

    level.snd.debughuds = audiodebughuds;
    waitframe();
  }
}

function private function_d1ed4546652ee94c(duration) {
  hud = undefined;
  now = gettime();
  timeofdeath = duration * 50;

  foreach(hud in level.snd.debughuds) {
    assert(function_cd79b44ba8163808(hud) == 0);

    if(now >= hud.timeofdeath) {
      hud.time = now;
      hud.timeofdeath = now + timeofdeath;
      hud.duration = duration;
      return hud;
    }
  }

  hud = newhudelem();
  hud.time = now;
  hud.timeofdeath = now + timeofdeath;
  hud.duration = duration;
  index = level.snd.debughuds.size;
  level.snd.debughuds[index] = hud;

  return hud;
}

function private function_f8c0a1a49d5b592e(posx, posy, text, color, alpha, scale, duration) {
  hud_width = 640;
  hud_height = 480;
  hud_aspect = hud_width / hud_height;
  vidresolution = function_e8dca3401a4ad001();
  vidwidth = vidresolution[0];
  vidheight = vidresolution[1];
  vidaspect = vidwidth / vidheight;
  widthoffset = -0.5 * (hud_height * vidaspect - hud_width);
  hudx = posx / vidwidth * hud_width + (1 - posx / vidwidth * 0.5) * widthoffset;
  hudy = posy / vidheight * hud_height;
  assert(isstruct(level.snd), "<dev string:x37>");

  if(isDefined(level.snd.debughuds) == 0) {
    level.snd.debughuds = [];
  }

  level thread function_e6f0d8b8ff3f1b12();
  hud = function_d1ed4546652ee94c(duration);
  hud.x = hudx;
  hud.y = hudy;
  hud settext(text);
  hud.color = color;
  hud.alpha = alpha;
  hud.fontscale = scale * 0.5;
  hud.font = "}\nK(OP\x17C\xfe\xfc";
  hud.alignx = "=\xff0b";
  hud.aligny = "\x14#\x01\x89\f\x81";
  hud.horizalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  hud.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  hud.xoffset = 0;
  hud.yoffset = 0;
  hud.xpadding = 0;
  hud.ypadding = 0;
}

function private function_1287c4553ecc1a35(num) {
  if(num <= 9 && num >= 0) {
    return ("<dev string:x164>" + num);
  }

  return "<dev string:x24>" + num;
}

function private function_dcb12639fb864d51(framecount, fps, var_5ef7cc469efaa7a) {
  assert(isDefined(framecount));

  if(isDefined(fps) == 0) {
    fps = 20;
  }

  if(isDefined(var_5ef7cc469efaa7a) == 0) {
    var_5ef7cc469efaa7a = 0;
  }

  totalseconds = int(framecount / fps);
  totalminutes = int(totalseconds / 60);
  totalhours = int(totalminutes / 60);
  totaldays = int(totalhours / 24);
  frames = framecount % fps;
  var_8b0f4a8b673194ba = frames / fps * 100;
  seconds = totalseconds % 60;
  minutes = totalminutes % 60;
  hours = totalhours % 60;
  days = totaldays % 99;
  framesstring = function_1287c4553ecc1a35(frames);
  var_6b835f2c38cd5663 = function_1287c4553ecc1a35(var_8b0f4a8b673194ba);
  secondsstring = function_1287c4553ecc1a35(seconds);
  minutesstring = function_1287c4553ecc1a35(minutes);
  hoursstring = function_1287c4553ecc1a35(hours);
  daysstring = function_1287c4553ecc1a35(days);
  timecodestring = daysstring + "<dev string:x169>" + hoursstring + "<dev string:x169>" + minutesstring + "<dev string:x169>" + secondsstring;

  if(var_5ef7cc469efaa7a == 1) {
    timecodestring += "<dev string:x16e>" + var_6b835f2c38cd5663;
  } else {
    timecodestring += "<dev string:x169>" + framesstring;
  }

  return timecodestring;
}

function private function_dd11ebe69bc07d9f(initialframecount, serverframecount, fps) {
  if(isDefined(initialframecount) == 0) {
    initialframecount = 0;
  }

  assert(initialframecount >= 0, "<dev string:x173>");
  framestep = fps / 20;
  framecount = initialframecount;
  framecount += serverframecount * framestep;
  framecount = floor(framecount);
  framecount = int(framecount);
  return framecount;
}

function private function_d1c4a1b9a9664bd3(initialframecount) {
  assert(isDefined(level.snd.timecode));

  if(isDefined(initialframecount) == 0) {
    initialframecount = 0;
  }

  assert(initialframecount >= 0, "<dev string:x173>");
  framestep = level.snd.timecode.fps / 20;
  level.snd.timecode endon("<dev string:x1a7>");
  level.snd.timecode.isactive = 1;
  level.snd.timecode.framecount = 0;
  level.snd.timecode.initialframecount = initialframecount;

  while(isDefined(level.snd.timecode) && level.snd.timecode.isactive == 1) {
    posx = level.snd.timecode.posx;
    posy = level.snd.timecode.posy;
    alpha = 1;
    scale = level.snd.timecode.scale;
    framecount = function_dd11ebe69bc07d9f(initialframecount, level.snd.timecode.framecount, level.snd.timecode.fps);
    timecodestring = function_dcb12639fb864d51(framecount, level.snd.timecode.fps);
    print2d(posx, posy, timecodestring, (1, 1, 1), alpha, scale, 1);

    if(level.snd.timecode.marksarray.size > 0) {
      posy += scale * 12;
      print2d(posx, posy, "<dev string:x1bc>", (1, 1, 1), alpha, scale, 1);
      posy += scale * 12;

      foreach(mark in level.snd.timecode.marksarray) {
        markstring = mark[1];
        markframecount = function_dd11ebe69bc07d9f(initialframecount, mark[0], level.snd.timecode.fps);
        timecode = function_dcb12639fb864d51(markframecount, level.snd.timecode.fps);
        marksstring = timecode + "<dev string:x1ce>" + markstring + "<dev string:x94>";
        print2d(posx, posy, marksstring, (1, 1, 1), alpha, scale, 1);
        posy += scale * 12;
      }
    }

    level.snd.timecode.framecount += 1;
    waitframe();
  }
}

function timecode_stop() {
  if(isDefined(level.snd.timecode) == 0) {
    return;
  }

  level.snd.timecode notify("<dev string:x1a7>");
  level.snd.timecode.isactive = 0;
  level.snd.timecode.isvisible = 0;
  markframecount = function_dd11ebe69bc07d9f(level.snd.timecode.initialframecount, level.snd.timecode.framecount, level.snd.timecode.fps);
  timecode = function_dcb12639fb864d51(markframecount, level.snd.timecode.fps);
  markstring = timecode + "<dev string:x1d5>";
  println(markstring);
  level.snd.timecode.marksarray = undefined;
  level.snd.timecode = undefined;
}

function timecode_mark(text) {
  if(isDefined(level.snd.timecode) == 0) {
    timecode();
  }

  marksarrayindex = level.snd.timecode.marksarray.size;
  level.snd.timecode.marksarray[marksarrayindex] = [level.snd.timecode.framecount, text];
  markframecount = function_dd11ebe69bc07d9f(level.snd.timecode.initialframecount, level.snd.timecode.framecount, level.snd.timecode.fps);
  timecode = function_dcb12639fb864d51(markframecount, level.snd.timecode.fps);
  markstring = timecode + "<dev string:x1ce>" + text;
  println(markstring);
}

function function_c09fe7329fe47198() {
  if(isDefined(level.snd.timecode) && isDefined(level.snd.timecode.marksarray)) {
    for(i = 0; i < level.snd.timecode.marksarray.size; i++) {
      level.snd.timecode.marksarray[i] = undefined;
    }
  }
}

function timecode(var_5d17d3c389a0d6c3, scale, posx, posy, var_5ef7cc469efaa7a, initialframecount) {
  isvisible = 1;
  assert(isstruct(level.snd), "<dev string:x37>");

  if(isDefined(level.snd.timecode)) {
    timecode_stop();
  }

  assert(isDefined(level.snd.timecode) == 0);
  level.snd.timecode = spawnStruct();
  level.snd.timecode.marksarray = [];

  if(isDefined(var_5d17d3c389a0d6c3) == 0) {
    var_5d17d3c389a0d6c3 = 20;
  }

  if(isDefined(scale) == 0) {
    scale = 2;
  }

  scale /= 1;
  vidresolution = function_e8dca3401a4ad001();
  vidwidth = vidresolution[0];
  vidheight = vidresolution[1];
  timecodewidth = 6 * 14 * scale;
  centerx = vidwidth * 0.5 - timecodewidth * 0.5;
  centery = vidheight * 0.5 - 12 * 0.5;

  if(isDefined(posx) == 0) {
    posx = centerx;
  }

  if(isDefined(posy) == 0) {
    centeroffset = 192;
    posy = centery + centeroffset;
  }

  level.snd.timecode.posx = posx;
  level.snd.timecode.posy = posy;
  level.snd.timecode.scale = scale;
  level.snd.timecode.fps = var_5d17d3c389a0d6c3;
  level.snd.timecode.isvisible = isvisible;
  level.snd.timecode.var_5ef7cc469efaa7a = var_5ef7cc469efaa7a;
  level.snd.timecode thread function_d1c4a1b9a9664bd3(initialframecount);
}

# /