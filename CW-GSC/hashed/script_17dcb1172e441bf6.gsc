/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_17dcb1172e441bf6.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_1e25ad94;

function init() {
  level.doa.var_62f60f27 = [];
  level thread function_99069e31();
}

function debugcircle(origin, radius, seconds, color) {
  if(!isDefined(seconds)) {
    seconds = 1;
  }

  if(!isDefined(color)) {
    color = (1, 0, 0);
  }

  frames = int(20 * seconds);
  circle(origin, radius, color, 0, 1, frames);
}

function debugline(p1, p2, seconds, color) {
  line(p1, p2, color, 1, 0, int(seconds * 20));
}

function function_1d1f2c26(point, timesec, size, color) {
  self endon(#"hash_20de371f231f3e8a");
  end = gettime() + timesec * 1000;
  halfwidth = int(size / 2);
  var_692eeaa1 = point + (halfwidth * -1, 0, 0);
  l2 = point + (halfwidth, 0, 0);
  var_74d6c120 = point + (0, halfwidth * -1, 0);
  var_be7dd479 = point + (0, halfwidth, 0);
  var_cfbcbc57 = point + (0, 0, halfwidth * -1);
  var_9e09d8f2 = point + (0, 0, halfwidth);

  while(end > gettime()) {
    line(var_692eeaa1, l2, color, 1, 0, 1);
    line(var_74d6c120, var_be7dd479, color, 1, 0, 1);
    line(var_cfbcbc57, var_9e09d8f2, color, 1, 0, 1);
    waitframe(1);
  }
}

function debugorigin(timesec, size, color) {
  self endon(#"hash_60eabc6ae83239fe");
  end = gettime() + timesec * 1000;
  halfwidth = int(size / 2);

  while(isDefined(self) && end > gettime()) {
    point = self.origin;
    var_692eeaa1 = point + (halfwidth * -1, 0, 0);
    l2 = point + (halfwidth, 0, 0);
    var_74d6c120 = point + (0, halfwidth * -1, 0);
    var_be7dd479 = point + (0, halfwidth, 0);
    var_cfbcbc57 = point + (0, 0, halfwidth * -1);
    var_9e09d8f2 = point + (0, 0, halfwidth);
    line(var_692eeaa1, l2, color, 1, 0, 1);
    line(var_74d6c120, var_be7dd479, color, 1, 0, 1);
    line(var_cfbcbc57, var_9e09d8f2, color, 1, 0, 1);
    waitframe(1);
  }
}

function debugmsg(txt, critical = 0) {
  if(critical == 0) {
    println("<dev string:x38>" + txt);
    return;
  }

  text = "<dev string:x48>" + gettime() + "<dev string:x68>" + txt;
  println("<dev string:x38>" + text);
  level.doa.var_62f60f27[level.doa.var_62f60f27.size] = text;
}

function function_75ebaff2(txt, timesec, entity) {
  end = gettime() + timesec * 1000;
  origin = namespace_7f5aeb59::function_23e1f90f()[0].origin;

  while(end > gettime()) {
    if(isDefined(entity)) {
      origin = entity.origin;
    }

    print3d(origin, txt);
    waitframe(1);
  }
}

function function_b57a9d84(vcenter, yaw, length, width, height, timesec = 1, color = (1, 0, 0)) {
  end = gettime() + timesec * 1000;
  mins = (length * -1 / 2, width * -1 / 2, height * -1 / 2);
  maxs = (length / 2, width / 2, height / 2);

  while(end > gettime()) {
    box(vcenter, mins, maxs, yaw, color, 1, 0, 1);
    waitframe(1);
  }
}

function function_67127ba2(entity, yaw, length, width, height, timesec = 1, color = (1, 0, 0)) {
  end = gettime() + timesec * 1000;
  mins = (length * -1 / 2, width * -1 / 2, height * -1 / 2);
  maxs = (length / 2, width / 2, height / 2);

  while(end > gettime()) {
    box(entity.origin, mins, maxs, yaw, color, 1, 0, 1);
    waitframe(1);
  }
}

function function_99069e31() {
  while(true) {
    waitframe(1);

    if(level.doa.var_62f60f27.size && isDefined(level.doa.var_39e3fa99)) {
      if(level.doa.world_state == 4) {
        origin = namespace_7f5aeb59::function_23e1f90f()[0].origin;
      } else {
        origin = [[level.doa.var_39e3fa99]] - > function_ffcf1d1();
      }

      print3d(origin, "<dev string:x72>" + level.doa.var_62f60f27.size);
    }
  }

}

function function_d88064ec(clear = 1) {
  foreach(msg in level.doa.var_62f60f27) {
    println("<dev string:x38>" + msg);
  }

  if(clear) {
    function_8225da57();
  }
}

function function_8225da57() {
  level.doa.var_62f60f27 = [];
}

function function_72f01f3f(origin, radius, time, color = (0, 1, 0)) {
  level endon(#"hash_54ce4a6a8260618e");
  self endon(#"death");
  var_264789d0 = 0.05;
  circleres = 16;
  var_d013a31 = circleres / 2;
  circleinc = 360 / circleres;
  circleres++;
  timer = gettime() + time * 1000;

  while(gettime() < timer) {
    plotpoints = [];
    rad = 0;
    wait var_264789d0;
    players = getplayers();
    angletoplayer = vectortoangles(origin - players[0].origin);

    for(i = 0; i < circleres; i++) {
      plotpoints[plotpoints.size] = origin + vectorscale(anglesToForward(angletoplayer + (rad, 90, 0)), radius) + (0, 0, 12);
      rad += circleinc;
    }

    function_f8c6064(plotpoints, color, var_264789d0);
  }
}

function function_f8c6064(plotpoints, var_2bd0b8bf, var_f491dcf7 = 1) {
  if(plotpoints.size == 0) {
    return;
  }

  lastpoint = plotpoints[0];

  for(var_f491dcf7 = int(var_f491dcf7); var_f491dcf7; var_f491dcf7--) {
    for(i = 1; i < plotpoints.size; i++) {
      line(lastpoint, plotpoints[i], var_2bd0b8bf, 1, var_f491dcf7);
      lastpoint = plotpoints[i];
    }

    waitframe(1);
  }
}

function function_e8f2d12c(pos, rad, height, var_f491dcf7 = 1, color = (0, 0, 0)) {
  self endon(#"stop_cylinder");
  self endon(#"death");
  currad = rad;
  curheight = height;

  for(var_f491dcf7 = int(var_f491dcf7); var_f491dcf7; var_f491dcf7--) {
    for(r = 0; r < 20; r++) {
      theta = r / 20 * 360;
      theta2 = (r + 1) / 20 * 360;
      line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color);
      line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color);
      line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color);
    }

    waitframe(1);
  }
}

function function_ee689179() {
  self.fading = 1;

  while(self.alpha > 0) {
    self.alpha -= 0.01;
    waitframe(1);
  }

  arrayremovevalue(level.doa.var_3843f782, self);
}

function function_8f04a649() {
  self notify("<dev string:x86>");
  self endon("<dev string:x86>");

  while(level.doa.var_3843f782.size) {
    var_4c600979 = 800;
    time = gettime();

    foreach(line in level.doa.var_3843f782) {
      if(time > line.expire && !isDefined(line.fading)) {
        line thread function_ee689179();
      }

      line.y = var_4c600979;
      var_4c600979 += int(20 * line.scale);
      debug2dtext((line.x, line.y, 0), line.text, line.color, line.alpha, (0, 0, 0), 0, line.scale, 1);
    }

    waitframe(1);
  }
}

function function_4e3cfad(text, color = (1, 1, 1), alpha = 1, scale = 1, duration = 3) {
  if(!isDefined(level.doa.var_3843f782)) {
    level.doa.var_3843f782 = [];
  }

  struct = spawnStruct();
  struct.x = 40;
  struct.text = text;
  struct.color = color;
  struct.alpha = alpha;
  struct.scale = scale;
  struct.expire = gettime() + duration * 1000;
  level.doa.var_3843f782[level.doa.var_3843f782.size] = struct;
  level thread function_8f04a649();
}

function function_70e370a(posx, posy, text, color = (1, 1, 1), alpha = 1, scale = 1, durationsec = 3) {
  if(!isDefined(text) || text == "<dev string:x9a>") {
    return;
  }

  frames = int(durationsec * 20);

  if(frames < 1) {
    frames = 1;
  }

  debug2dtext((posx, posy, 0), text, color, alpha, (0, 0, 0), 0, scale, frames);
}