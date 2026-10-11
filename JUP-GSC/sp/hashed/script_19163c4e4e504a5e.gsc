/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_19163c4e4e504a5e.gsc
*************************************************/

#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\engine\utility;
#namespace snd_draw;

function function_8c3a8f58cbd39dca(posx, posy, text, color, alpha, scale, duration) {
  if(isDefined(text) == 0 || text == "<dev string:x1c>") {
    return;
  }

  color = default_to(color, (1, 1, 1));
  alpha = default_to(alpha, 1);
  scale = default_to(scale, 1);
  duration = default_to(duration, 1);

  if(function_ea27c1335507c840(level.snd.callbacks["<dev string:x1d>"])) {
    [[level.snd.callbacks["<dev string:x1d>"]]](posx, posy, text, color, alpha, scale, duration);
    return;
  }

  printtoscreen2d(posx, posy, text, color, scale);
}

function function_d4355e5f7ead5aff(text, scale) {
  assert(isDefined(text));

  if(isDefined(scale) == 0) {
    scale = 1;
  }

  vidresolution = function_d8bcdde57d13f7fc();
  vidwidth = vidresolution[0];
  vidheight = vidresolution[1];
  textlength = text.size;
  textwidth = textlength * 8 * scale;
  centerx = vidwidth * 0.5 - textwidth * 0.5;
  centery = vidheight * 0.5 - 8;
  center = [centerx, centery];
  return center;
}

function function_9e5b1c32235027a1(text, scale) {
  centerpos = function_d4355e5f7ead5aff(text, scale);
  defaultposx = centerpos[0];
  defaultposy = centerpos[1];
  defaultposy = defaultposy * 0.5 + 8;
  defaultpos = [defaultposx, defaultposy];
  return defaultpos;
}

function private function_b443cb2ef9d9f62e(posx, posy, text, color, scale, fadeoutseconds, blinkseconds) {
  rowincrement = 16 * scale;
  frametime = function_e448203aedcadcf8();
  frametotal = int(fadeoutseconds / frametime);
  framecount = 0;
  blinkframes = int(blinkseconds / frametime);
  var_1a6b830aa7112a1b = 1;
  blinkcount = 0;

  if(istrue(level.snd.var_ab52ccadc04df539)) {
    var_1a6b830aa7112a1b = 2;
  }

  assertex(isstruct(level.snd), "<dev string:x29>");

  if(isarray(level.snd.var_efef27a9405ace5e) == 0) {
    level.snd.var_efef27a9405ace5e = [];
  }

  assert(isarray(level.snd.var_efef27a9405ace5e));

  if(level.snd.var_efef27a9405ace5e.size > 0) {
    foreach(row in level.snd.var_efef27a9405ace5e) {
      if(array_contains(level.snd.var_efef27a9405ace5e, posy)) {
        posy += rowincrement;
        continue;
      }

      break;
    }
  }

  level.snd.var_efef27a9405ace5e[level.snd.var_efef27a9405ace5e.size] = posy;

  while(framecount < frametotal) {
    if(framecount < blinkframes) {
      blinkstate = int(float(framecount) / float(var_1a6b830aa7112a1b));
      blinkstate %= 2;

      if(blinkstate) {
        framecount += 1;
        waitframe();
        continue;
      }
    }

    framefrac = float(framecount) / float(frametotal);
    framefrac = clamp(framefrac, 0, 1);
    alpha = namespace_53c50dd747d66443::function_e6ef280f5472a1d2(1 - framefrac, "<dev string:x42>");
    alphasq = alpha * alpha;
    colorscale = function_1f9e5d44e92014a5(color, alpha);
    function_136df9498dfe620e(text, posx, posy, scale, "<dev string:x4a>", colorscale, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
    framecount += 1;
    waitframe();
  }

  if(isarray(level.snd.var_efef27a9405ace5e)) {
    level.snd.var_efef27a9405ace5e = array_remove(level.snd.var_efef27a9405ace5e, posy);
  }
}

function function_265429989bce8de3(text, posx, posy, color, scale, fadeoutseconds, blinkseconds) {
  assert(isDefined(text));
  color = default_to(color, (1, 0.5, 0.5));
  scale = default_to(scale, 1.75);
  fadeoutseconds = default_to(fadeoutseconds, 4);
  blinkseconds = default_to(blinkseconds, 1);

  if(isDefined(posx) == 0 || isDefined(posy) == 0) {
    defaultpos = function_9e5b1c32235027a1(text, scale);

    if(isDefined(posx) == 0) {
      posx = defaultpos[0];
    }

    if(isDefined(posy) == 0) {
      posy = defaultpos[1];
    }
  }

  level thread function_b443cb2ef9d9f62e(posx, posy, text, color, scale, fadeoutseconds, blinkseconds);
  println(text);
}

function function_946a9bcdca68c4b0(var_77b899748c172731) {
  assertex(isstruct(level.snd), "<dev string:x29>");

  if(isDefined(var_77b899748c172731) && var_77b899748c172731 != 0) {
    level.snd.debughudactive = 1;
    return;
  }

  level.snd.debughudactive = undefined;
}

function snd_print3d(origin, text, color, alpha, scale, duration, centered) {
  print3d(origin, text, color, alpha, scale, duration, centered);
}

function function_978f0bcacd3604af(origin, text, color, alpha, scale, duration, right) {
  print3d(origin, text, color, alpha, scale, duration, 1);
}

function function_136df9498dfe620e(text, x, y, scale, justify, color, alpha, shadowcolor, shadowalpha, lightcolor, lightalpha, duration) {
  color = default_to(color, (1, 1, 1));
  alpha = default_to(alpha, 1);
  scale = default_to(scale, 1);
  justify = default_to(justify, "<dev string:x4c>");
  duration = default_to(duration, 1);
  offset = (0, 0, 0);
  width = 8 * scale * text.size;

  switch (justify) {
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
    function_8c3a8f58cbd39dca(position[0], position[1], text, shadowcolor, shadowalpha, scale, duration);
  }

  if(isDefined(lightcolor)) {
    if(!isDefined(lightalpha)) {
      lightalpha = alpha * 0.7333;
    }

    position = (x + -0.666 * scale, y + -0.666 * scale, 0) + offset;
    function_8c3a8f58cbd39dca(position[0], position[1], text, lightcolor, lightalpha, scale, duration);
  }

  position = (x, y, 0) + offset;
  function_8c3a8f58cbd39dca(position[0], position[1], text, color, alpha, scale, duration);
}

function print3dplus(text, origin, scale, justify, color, alpha, shadowcolor, shadowalpha, lightcolor, lightalpha, duration) {
  color = default_to(color, (1, 1, 1));
  alpha = default_to(alpha, 1);
  scale = default_to(scale, 1);
  justify = default_to(justify, "<dev string:x4c>");
  duration = int(default_to(duration, 1));
  contsize = scale < 0;
  scale = abs(scale);
  textsize = text.size;

  if(issubstr(text, "<dev string:x6b>")) {
    lines = strtok(text, "<dev string:x6b>");

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

  switch (justify) {
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

function private function_fc51b1db9f1aa696(color, depthtest, drawpatharray, offset) {
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

function private function_e58246b402adf0b1(color, depthtest, duration, offset) {
  assert(isDefined(self.origin), "<dev string:x6d>");
  assert(isvector(color), "<dev string:x8f>");
  assert(isDefined(duration), "<dev string:xaa>");
  framecount = 0;
  drawpatharray = [];
  drawpatharray[0] = self.origin;
  self endon("<dev string:xc8>");

  while(drawpatharray.size > 0) {
    temppatharray = [];

    if(framecount >= duration) {
      for(i = 1; i < drawpatharray.size; i++) {
        temppatharray[i - 1] = drawpatharray[i];
      }
    } else {
      temppatharray = drawpatharray;
    }

    if(isDefined(self) && isDefined(self.origin) && function_5b8457b9d8edb521(self) == 0) {
      temppatharray[temppatharray.size] = self.origin;
    }

    drawpatharray = temppatharray;
    function_fc51b1db9f1aa696(color, depthtest, drawpatharray, offset);
    framecount++;
    waitframe();
  }
}

function snd_drawpath(movingobject, color, depthtest, duration, offset) {
  color = default_to(color, (1, 1, 1));
  depthtest = default_to(depthtest, 0);
  duration = default_to(duration, 5);

  if(function_110d3ab280057f5b(!isDefined(movingobject), "<dev string:xda>")) {
    return;
  }

  if(istrue(level.snd.var_ab52ccadc04df539)) {
    duration = int(60 * duration);
  } else {
    duration = int(20 * duration);
  }

  assert(duration > 2, "<dev string:xff>");
  movingobject thread function_e58246b402adf0b1(color, depthtest, duration, offset);
}

function function_35b7df275c1ba312(origin, angles, extents, color, alpha, depthtest, duration) {
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
  function_35b7df275c1ba312(origin, angles, sidelength, color, alpha, depthtest, duration);
}

function debugcrosshair(origin, size, angles, color, alpha, depthtest, duration) {
  forward = (1, 0, 0);
  right = (0, 1, 0);
  up = (0, 0, 1);
  size = default_to(size, 16);
  angles = default_to(angles, (0, 0, 0));
  color = default_to(color, (1, 1, 1));
  alpha = default_to(alpha, 1);
  depthtest = default_to(depthtest, 0);
  duration = default_to(duration, 1);

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
  length = default_to(length, 12);
  headsize = default_to(headsize, 4);
  color = default_to(color, (1, 1, 1));
  alpha = default_to(alpha, 1);
  depthtest = default_to(depthtest, 0);
  duration = int(default_to(duration, 1));
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
  depthtest = default_to(depthtest, 0);
  duration = default_to(duration, 1);
  sphere(origin, radius, color, depthtest, duration);
}

function function_1589f10b96600d0f(screenheight) {
  var_c67e2413c92619a6 = 480 / screenheight;
  return var_c67e2413c92619a6;
}

function function_d6886acce6238019(coordinates, screensize) {
  screensize = default_to(screensize, function_d8bcdde57d13f7fc());
  var_c67e2413c92619a6 = function_1589f10b96600d0f(screensize[1]);
  hudwidth = coordinates[0] * var_c67e2413c92619a6;
  hudheight = coordinates[1] * var_c67e2413c92619a6;
  return [int(hudwidth), int(hudheight)];
}

function function_a540f05eecfe7e96(coordinates, screensize) {
  screensize = default_to(screensize, function_d8bcdde57d13f7fc());
  var_c67e2413c92619a6 = function_1589f10b96600d0f(screensize[1]);
  hudx = coordinates[0] * var_c67e2413c92619a6;
  hudy = coordinates[1] * var_c67e2413c92619a6;
  screenaspect = screensize[0] / screensize[1];
  var_766fc6b1f18eeeab = screenaspect * 480;
  hudxoffset = -0.5 * (var_766fc6b1f18eeeab - 640);
  hudx += hudxoffset;
  return [hudx, hudy];
}

function private function_55792e20398965bf() {
  if(isDefined(level.snd.debughudthread)) {
    return;
  }

  level.snd.debughudthread = getthread();

  while(isDefined(level.snd.debughuds)) {
    now = gettime();
    audiodebughuds = [];

    foreach(hud in level.snd.debughuds) {
      assert(function_5b8457b9d8edb521(hud) == 0);

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

function private function_bc5b7015df7542d1(duration) {
  hud = undefined;
  now = gettime();
  timeofdeath = duration * 50;

  foreach(hud in level.snd.debughuds) {
    assert(function_5b8457b9d8edb521(hud) == 0);

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

function private function_b712ac81c5cb013b(posx, posy, text, color, alpha, scale, duration) {
  hud_width = 640;
  hud_height = 480;
  hud_aspect = hud_width / hud_height;
  vidresolution = function_d8bcdde57d13f7fc();
  vidwidth = vidresolution[0];
  vidheight = vidresolution[1];
  vidaspect = vidwidth / vidheight;
  widthoffset = -0.5 * (hud_height * vidaspect - hud_width);
  hudx = posx / vidwidth * hud_width + (1 - posx / vidwidth * 0.5) * widthoffset;
  hudy = posy / vidheight * hud_height;
  assertex(isstruct(level.snd), "snd was not initialized.");

  if(isDefined(level.snd.debughuds) == 0) {
    level.snd.debughuds = [];
  }

  level thread function_55792e20398965bf();
  hud = function_bc5b7015df7542d1(duration);
  hud.x = hudx;
  hud.y = hudy;
  hud settext(text);
  hud.color = color;
  hud.alpha = alpha;
  hud.fontscale = scale * 0.5;
  hud.font = "smallfixed";
  hud.alignx = "left";
  hud.aligny = "bottom";
  hud.horizalign = "fullscreen";
  hud.vertalign = "fullscreen";
  hud.xoffset = 0;
  hud.yoffset = 0;
  hud.xpadding = 0;
  hud.ypadding = 0;
}

function private function_7c3d0b968c966668(num) {
  if(num <= 9 && num >= 0) {
    return ("<dev string:x121>" + num);
  }

  return "<dev string:x1c>" + num;
}

function private function_9aaed43357848f20(framecount, fps, var_4e6d89fb533555bb) {
  assert(isDefined(framecount));

  if(isDefined(fps) == 0) {
    fps = 20;
  }

  if(isDefined(var_4e6d89fb533555bb) == 0) {
    var_4e6d89fb533555bb = 0;
  }

  totalseconds = int(framecount / fps);
  totalminutes = int(totalseconds / 60);
  totalhours = int(totalminutes / 60);
  totaldays = int(totalhours / 24);
  frames = framecount % fps;
  var_9b51060e1a10fcbb = frames / fps * 100;
  seconds = totalseconds % 60;
  minutes = totalminutes % 60;
  hours = totalhours % 60;
  days = totaldays % 99;
  framesstring = function_7c3d0b968c966668(frames);
  var_5a6ff3568f35765e = function_7c3d0b968c966668(var_9b51060e1a10fcbb);
  secondsstring = function_7c3d0b968c966668(seconds);
  minutesstring = function_7c3d0b968c966668(minutes);
  hoursstring = function_7c3d0b968c966668(hours);
  daysstring = function_7c3d0b968c966668(days);
  timecodestring = daysstring + "<dev string:x123>" + hoursstring + "<dev string:x123>" + minutesstring + "<dev string:x123>" + secondsstring;

  if(var_4e6d89fb533555bb == 1) {
    timecodestring += "<dev string:x125>" + var_5a6ff3568f35765e;
  } else {
    timecodestring += "<dev string:x123>" + framesstring;
  }

  return timecodestring;
}

function private function_9313eda58ed29e3e(initialframecount, serverframecount, fps) {
  if(isDefined(initialframecount) == 0) {
    initialframecount = 0;
  }

  assertex(initialframecount >= 0, "<dev string:x127>");
  framestep = fps / 20;
  framecount = initialframecount;
  framecount += serverframecount * framestep;
  framecount = floor(framecount);
  framecount = int(framecount);
  return framecount;
}

function private function_2b151de570c1d056(initialframecount) {
  assert(isDefined(level.snd.timecode));

  if(isDefined(initialframecount) == 0) {
    initialframecount = 0;
  }

  assertex(initialframecount >= 0, "<dev string:x127>");
  framestep = level.snd.timecode.fps / 20;
  level.snd.timecode endon("<dev string:x157>");
  level.snd.timecode.isactive = 1;
  level.snd.timecode.framecount = 0;
  level.snd.timecode.initialframecount = initialframecount;

  while(isDefined(level.snd.timecode) && level.snd.timecode.isactive == 1) {
    posx = level.snd.timecode.posx;
    posy = level.snd.timecode.posy;
    alpha = 1;
    scale = level.snd.timecode.scale;
    framecount = function_9313eda58ed29e3e(initialframecount, level.snd.timecode.framecount, level.snd.timecode.fps);
    timecodestring = function_9aaed43357848f20(framecount, level.snd.timecode.fps);
    function_8c3a8f58cbd39dca(posx, posy, timecodestring, (1, 1, 1), alpha, scale, 1);

    if(level.snd.timecode.marksarray.size > 0) {
      posy += scale * 12;
      function_8c3a8f58cbd39dca(posx, posy, "<dev string:x169>", (1, 1, 1), alpha, scale, 1);
      posy += scale * 12;

      foreach(mark in level.snd.timecode.marksarray) {
        markstring = mark[1];
        markframecount = function_9313eda58ed29e3e(initialframecount, mark[0], level.snd.timecode.fps);
        timecode = function_9aaed43357848f20(markframecount, level.snd.timecode.fps);
        marksstring = timecode + "<dev string:x178>" + markstring + "<dev string:x6b>";
        function_8c3a8f58cbd39dca(posx, posy, marksstring, (1, 1, 1), alpha, scale, 1);
        posy += scale * 12;
      }
    }

    level.snd.timecode.framecount += 1;
    waitframe();
  }
}

function function_b6bd12cc4f34415e() {
  if(isDefined(level.snd.timecode) == 0) {
    return;
  }

  level.snd.timecode notify("<dev string:x157>");
  level.snd.timecode.isactive = 0;
  level.snd.timecode.isvisible = 0;
  markframecount = function_9313eda58ed29e3e(level.snd.timecode.initialframecount, level.snd.timecode.framecount, level.snd.timecode.fps);
  timecode = function_9aaed43357848f20(markframecount, level.snd.timecode.fps);
  markstring = timecode + "<dev string:x17c>";
  println(markstring);
  level.snd.timecode.marksarray = undefined;
  level.snd.timecode = undefined;
}

function function_d24a92cfbc477ca7(text) {
  if(isDefined(level.snd.timecode) == 0) {
    function_5177fa294d4fe5cd();
  }

  marksarrayindex = level.snd.timecode.marksarray.size;
  level.snd.timecode.marksarray[marksarrayindex] = [level.snd.timecode.framecount, text];
  markframecount = function_9313eda58ed29e3e(level.snd.timecode.initialframecount, level.snd.timecode.framecount, level.snd.timecode.fps);
  timecode = function_9aaed43357848f20(markframecount, level.snd.timecode.fps);
  markstring = timecode + "<dev string:x178>" + text;
  println(markstring);
}

function function_4680808ae4ce7935() {
  if(isDefined(level.snd.timecode) && isDefined(level.snd.timecode.marksarray)) {
    for(i = 0; i < level.snd.timecode.marksarray.size; i++) {
      level.snd.timecode.marksarray[i] = undefined;
    }
  }
}

function function_5177fa294d4fe5cd(var_ada09577e62e45ee, scale, posx, posy, var_4e6d89fb533555bb, initialframecount) {
  isvisible = 1;
  assertex(isstruct(level.snd), "<dev string:x29>");

  if(isDefined(level.snd.timecode)) {
    function_b6bd12cc4f34415e();
  }

  assert(isDefined(level.snd.timecode) == 0);
  level.snd.timecode = spawnStruct();
  level.snd.timecode.marksarray = [];

  if(isDefined(var_ada09577e62e45ee) == 0) {
    var_ada09577e62e45ee = 20;
  }

  if(isDefined(scale) == 0) {
    scale = 2;
  }

  scale /= 1;
  vidresolution = function_d8bcdde57d13f7fc();
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
  level.snd.timecode.fps = var_ada09577e62e45ee;
  level.snd.timecode.isvisible = isvisible;
  level.snd.timecode.var_4e6d89fb533555bb = var_4e6d89fb533555bb;
  level.snd.timecode thread function_2b151de570c1d056(initialframecount);
}

# /