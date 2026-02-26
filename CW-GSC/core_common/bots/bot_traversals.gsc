/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\bots\bot_traversals.gsc
***********************************************/

#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_animation;
#using scripts\core_common\callbacks_shared;
#namespace bot_traversals;

function preinit() {
  callback::add_callback(#"hash_767bb029d2dcda7c", &function_45ed4ebd);
}

function private function_45ed4ebd(eventstruct) {
  if(self isplayinganimscripted()) {
    return;
  }

  self function_c8aebd21(eventstruct);

  if(isDefined(eventstruct.var_921d19f9) && eventstruct.var_921d19f9 == 0) {
    self function_38db71f(eventstruct);
  }

  if(function_5186819c(eventstruct)) {
    self thread function_342c7f77(eventstruct);
    return;
  }

  if(function_51cbae24(eventstruct)) {
    self thread function_e48afac9(eventstruct);
    return;
  }

  if(isDefined(eventstruct.var_a8cc518d)) {
    self thread function_9bd9969f(eventstruct);
    return;
  }

  if(eventstruct.deltaz > 0 || eventstruct.var_d9db209e > 30) {
    self thread function_adeef583(eventstruct);
    return;
  }

  self thread function_b2ff3887(eventstruct);
}

function private function_b1528302(eventstruct, type) {
  self thread function_c20f7b00(eventstruct, "<dev string:x38>" + function_9e72a96(type));

  eventstruct.type = type;
  self.bot.traversal = eventstruct;
  self bottakemanualcontrol();
}

function private function_1aaef814(notifyhash) {
  self.bot.traversal = undefined;
  self.bot.traversaltype = undefined;

  if(isbot(self)) {
    self botreleasemanualcontrol();
  }
}

function private function_5186819c(eventstruct) {
  return isDefined(eventstruct.start_node) && isDefined(eventstruct.start_node.spawnflags) && eventstruct.start_node.spawnflags & 134217728;
}

function private function_51cbae24(eventstruct) {
  if(eventstruct.deltaz < 18 || isDefined(eventstruct.var_921d19f9) || isDefined(eventstruct.var_a8cc518d) || !isDefined(eventstruct.start_node) || !isDefined(eventstruct.end_node)) {
    return false;
  }

  return eventstruct.start_node.spawnflags & 4194304 || eventstruct.end_node.spawnflags & 4194304;
}

function private function_c8aebd21(eventstruct) {
  startpos = eventstruct.start_position;
  endpos = eventstruct.end_position;
  tracedist = distance2d(startpos, endpos);
  traversaldir = endpos - startpos;
  var_883d42a7 = checknavmeshdirection(startpos, traversaldir, tracedist, 0);
  eventstruct.var_883d42a7 = var_883d42a7;
  var_695ff8a6 = startpos - endpos;
  var_15dca465 = checknavmeshdirection(endpos, var_695ff8a6, tracedist, 0);
  eventstruct.var_15dca465 = var_15dca465;
  var_492af6a = physicstrace(startpos, var_883d42a7, (-15, -15, 18), (15, 15, 72), self, 32);
  eventstruct.var_75f5c2cb = var_492af6a[#"position"];
  normal = vectornormalize((var_695ff8a6[0], var_695ff8a6[1], 0));
  eventstruct.normal = normal;
  eventstruct.var_d9db209e = vectordot(normal, var_883d42a7 - var_15dca465);
  eventstruct.deltaz = eventstruct.var_15dca465[2] - eventstruct.var_883d42a7[2];
}

function private function_38db71f(eventstruct) {
  if(eventstruct.deltaz >= 18 || eventstruct.deltaz < -18) {
    return;
  }

  start = eventstruct.start_position + (0, 0, 9);
  end = eventstruct.end_position + (0, 0, 9);

  eventstruct.var_34a82e04 = start;
  eventstruct.var_5162591f = end;

  var_e74d8d10 = groundtrace(start, end, 0, self, 1, 1);

  if(var_e74d8d10[#"fraction"] >= 1) {
    return;
  }

  var_1582cba2 = var_e74d8d10[#"position"];
  dir = vectornormalize(end - start);
  var_74433575 = var_1582cba2 + dir * 5 + (0, 0, 60);

  eventstruct.var_87d52c5 = var_74433575;
  eventstruct.var_19c7b18b = var_1582cba2;

  var_924b2657 = groundtrace(var_74433575, var_1582cba2, 0, self, 1, 1);
  toppos = var_924b2657[#"position"];
  eventstruct.var_a8cc518d = (var_1582cba2[0], var_1582cba2[1], toppos[2]);
}

function private function_342c7f77(eventstruct) {
  self thread function_c20f7b00(eventstruct, "<dev string:x47>");
}

function private function_e48afac9(eventstruct) {
  self endoncallback(&function_1aaef814, #"death", #"bot_shutdown", #"bot_stuck", #"entering_last_stand", #"animscripted_start");
  self function_b1528302(eventstruct, #"ladder");
  self botsetmovepoint(eventstruct.end_position);
  self botsetmovemagnitude(1);

  while(!self isonladder()) {
    waitframe(1);
  }

  normal = eventstruct.normal;
  endedge = eventstruct.var_15dca465;

  while(self isonladder() || !self isonground() || vectordot(normal, endedge - self.origin) < 15) {
    waitframe(1);
  }

  self function_1aaef814();
}

function private function_9bd9969f(eventstruct) {
  self endoncallback(&function_1aaef814, #"death", #"bot_shutdown", #"bot_stuck", #"entering_last_stand", #"animscripted_start");
  self function_b1528302(eventstruct, #"vault");
  self botsetmovepoint(eventstruct.end_position);
  self botsetmovemagnitude(1);
  normal = eventstruct.normal;
  var_75f5c2cb = eventstruct.var_75f5c2cb;

  do {
    waitframe(1);
    var_3566f0b1 = vectordot(self.origin - var_75f5c2cb, normal);
  }
  while(var_3566f0b1 > 8);

  var_2166cb2 = eventstruct.var_a8cc518d;

  do {
    self bottapbutton(10);
    self bottapbutton(64);
    waitframe(1);
    var_2aab82d7 = vectordot(self.origin - var_2166cb2, normal);
  }
  while(!self ismantling() && !self isonground() && var_2aab82d7 >= 0);

  while(self ismantling()) {
    waitframe(1);
  }

  endpos = eventstruct.end_position;

  for(enddist = vectordot(self.origin - endpos, normal); var_2166cb2[2] - self.origin[2] < 18 && enddist > 15; enddist = vectordot(self.origin - endpos, normal)) {
    waitframe(1);
  }

  if(!self isonground() && !self isplayerswimming()) {
    self botsetmovemagnitude(0);
    velocity = self getvelocity();
    self setvelocity((0, 0, velocity[2]));
    waitframe(1);

    while(!self isonground() && !self isplayerswimming()) {
      waitframe(1);
    }
  }

  self function_1aaef814();
}

function private function_adeef583(eventstruct) {
  self endoncallback(&function_1aaef814, #"death", #"bot_shutdown", #"bot_stuck", #"entering_last_stand", #"animscripted_start");
  self function_b1528302(eventstruct, #"jump");
  endpos = eventstruct.var_15dca465;
  self botsetmovepoint(endpos);
  self botsetmovemagnitude(1);
  normal = eventstruct.normal;
  var_75f5c2cb = eventstruct.var_75f5c2cb;

  do {
    waitframe(1);
    var_3566f0b1 = vectordot(self.origin - var_75f5c2cb, normal);
  }
  while(var_3566f0b1 > 8);

  do {
    self bottapbutton(10);
    self bottapbutton(64);
    waitframe(1);
    enddist = vectordot(self.origin - endpos, normal);
  }
  while(!self ismantling() && enddist > 0);

  for(landed = self isplayerswimming() || self isonground(); self ismantling() || !landed; landed = self isplayerswimming() || self isonground()) {
    waitframe(1);
  }

  self function_1aaef814();
}

function private function_b2ff3887(eventstruct) {
  self endoncallback(&function_1aaef814, #"death", #"bot_shutdown", #"bot_stuck", #"entering_last_stand", #"animscripted_start");
  self function_b1528302(eventstruct, #"drop");
  self botsetmovepoint(eventstruct.end_position);
  self botsetmovemagnitude(1);
  normal = eventstruct.normal;
  var_75f5c2cb = eventstruct.var_75f5c2cb;
  var_883d42a7 = eventstruct.var_883d42a7;
  var_ba06b3fa = vectordot(normal, var_75f5c2cb - var_883d42a7) > 15 - 1;

  while(self isonground()) {
    if(var_ba06b3fa) {
      self bottapbutton(9);
    }

    waitframe(1);
  }

  self botsetmovemagnitude(0);
  velocity = self getvelocity();
  self setvelocity((0, 0, velocity[2]));

  while(!self isonground() && !self isplayerswimming()) {
    waitframe(1);
  }

  self function_1aaef814(eventstruct);
}

function private function_c3452ef9(eventstruct) {
  self thread function_c20f7b00(eventstruct, "<dev string:x5e>");

  self.traversestartnode = eventstruct.start_node;
  self.traversalstartpos = eventstruct.start_position;
  self.traverseendnode = eventstruct.end_node;
  self.traversalendpos = eventstruct.end_position;
  self.traversemantlenode = eventstruct.mantle_node;
  bot_animation::play_animation("parametric_traverse@traversal");
  self.traversestartnode = undefined;
  self.traversalstartpos = undefined;
  self.traverseendnode = undefined;
  self.traversalendpos = undefined;
  self.traversemantlenode = undefined;
}

function private function_c20f7b00(eventstruct, str) {
  self endon(#"death", #"bot_shutdown", #"bot_stuck", #"entering_last_stand", #"animscripted_start");
  textpos = vectorlerp(eventstruct.start_position, eventstruct.end_position, 0.5);
  yaw = vectortoangles(eventstruct.normal)[1];

  do {
    if(self bot::should_record("<dev string:x71>")) {
      record3dtext(str, textpos, (1, 1, 1), "<dev string:x88>", self, 0.5);
      recordstar(eventstruct.start_position, (0, 1, 0), "<dev string:x88>", self);
      recordbox(eventstruct.start_position, (0, -64, 0), (0, 64, 0), yaw, (0, 1, 0), "<dev string:x88>", self);
      recordstar(eventstruct.end_position, (1, 0, 0), "<dev string:x88>", self);
      recordbox(eventstruct.end_position, (0, -64, 0), (0, 64, 0), yaw, (1, 0, 0), "<dev string:x88>", self);

      if(isDefined(eventstruct.var_a8cc518d)) {
        recordstar(eventstruct.var_a8cc518d, (1, 1, 0), "<dev string:x88>", self);
        recordbox(eventstruct.var_a8cc518d, (0, -64, 0), (0, 64, 128), yaw, (1, 1, 0), "<dev string:x88>", self);
        recordline(eventstruct.start_position, eventstruct.var_a8cc518d, (0, 1, 1), "<dev string:x88>", self);
        recordline(eventstruct.end_position, eventstruct.var_a8cc518d, (0, 1, 1), "<dev string:x88>", self);
      } else {
        recordline(eventstruct.start_position, eventstruct.end_position, (0, 1, 1), "<dev string:x88>", self);
      }

      recordstar(eventstruct.var_883d42a7, (0, 1, 0), "<dev string:x88>", self);
      recordbox(eventstruct.var_883d42a7, (0, -64, 0), (0, 64, 128), yaw, (0, 1, 0), "<dev string:x88>", self);
      recordstar(eventstruct.var_15dca465, (1, 0, 0), "<dev string:x88>", self);
      recordbox(eventstruct.var_15dca465, (0, -64, 0), (0, 64, 128), yaw, (1, 0, 0), "<dev string:x88>", self);
      recordbox(eventstruct.var_75f5c2cb, (-15, -15, 18), (15, 15, 72), yaw, (1, 0, 1), "<dev string:x88>", self);

      if(isDefined(eventstruct.start_node)) {
        self function_3e781451(eventstruct.start_node, (0, 1, 0));
      }

      if(isDefined(eventstruct.end_node)) {
        self function_3e781451(eventstruct.end_node, (1, 0, 0));
      }

      if(isDefined(eventstruct.mantle_node)) {
        self function_3e781451(eventstruct.mantle_node, (1, 1, 0));
      }

      if(isDefined(eventstruct.var_34a82e04)) {
        recordline(eventstruct.var_34a82e04, eventstruct.var_5162591f, (1, 1, 0), "<dev string:x88>", self);
      }

      if(isDefined(eventstruct.var_87d52c5)) {
        recordline(eventstruct.var_87d52c5, eventstruct.var_19c7b18b, (1, 1, 0), "<dev string:x88>", self);
      }
    }

    waitframe(1);
  }
  while(isbot(self) && self botundermanualcontrol() && isDefined(self.bot) && isDefined(self.bot.traversal));
}

function private function_3e781451(node, color) {
  if(node.type == # "volume") {
    mins = (0, 0, 0) - node.aabb_extents;
    maxs = node.aabb_extents;
    recordbox(node.origin, mins, maxs, node.angles[1], color, "<dev string:x88>", self);
    return;
  }

  recordbox(node.origin, (-15, -15, 0), (15, 15, 15), node.angles[1], color, "<dev string:x88>", self);
}