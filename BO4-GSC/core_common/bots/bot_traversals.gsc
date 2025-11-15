/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\bots\bot_traversals.gsc
***********************************************/

#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_action;
#include scripts\core_common\bots\bot_animation;

#namespace bot;

callback_botentereduseredge(startnode, endnode, mantlenode, startpos, endpos, mantlepos) {
  if(self isplayinganimscripted()) {
    self botprinterror("<dev string:x38>");

    waitframe(1);
    self botreleasemanualcontrol();
    return;
  }

  var_75e8e8e8 = startnode.type !== "Volume";

  if(var_75e8e8e8) {
    if((startnode.type === "Begin" || startnode.type === "End") && isDefined(startnode.spawnflags) && startnode.spawnflags&134217728) {
      var_75e8e8e8 = 0;
    }
  }

  if(var_75e8e8e8) {
    self botprinterror("<dev string:x6a>");

    self thread fallback_traversal(endpos);
    return;
  }

  params = spawnStruct();
  params.startnode = startnode;
  params.endnode = endnode;
  params.mantlenode = mantlenode;
  params.startpos = startpos;
  params.endpos = endpos;
  params.mantlepos = mantlepos;

  if(isDefined(startnode) && isDefined(startnode.script_parameters) && startnode.script_parameters == "botIgnoreHeightCheck") {
    params.var_bccf04e7 = 1;
  }

  self analyze(params);
  self thread volume_traversal(params);
}

cancel() {
  self notify(#"hash_a729d7d4c6847f6");
}

fallback_traversal(endpos) {
  self endon(#"death", #"hash_a729d7d4c6847f6", #"hash_37fc5d1ffce4acaf");
  self endoncallback(&release_control, #"entering_last_stand", #"new_shot");
  level endon(#"game_ended");
  self teleport(endpos, "Legacy fallback");
  self botreleasemanualcontrol();
}

function_c3452ef9(params) {
  self.traversestartnode = params.startnode;
  self.traversalstartpos = params.startpos;
  self.traverseendnode = params.endnode;
  self.traversalendpos = params.endpos;
  self.traversemantlenode = params.mantlenode;
  bot_animation::play_animation("parametric_traverse@traversal");
  self.traversestartnode = undefined;
  self.traversalstartpos = undefined;
  self.traverseendnode = undefined;
  self.traversalendpos = undefined;
  self.traversemantlenode = undefined;
  self release_control();
}

volume_traversal(params) {
  self endon(#"death", #"hash_a729d7d4c6847f6", #"hash_37fc5d1ffce4acaf");
  self endoncallback(&release_control, #"entering_last_stand", #"new_shot");
  level endon(#"game_ended");
  self.bot.traversal = params;
  self bot_action::reset();
  self thread traversal_timeout(params);

  if(params.var_b8915580) {
    self function_fc004e60(params);
  } else if(params.dist2d > 30 && params.var_5aacf42 >= 0) {
    self botprinterror("<dev string:x95>");

    self thread function_c3452ef9(params);
    return;
  } else if(abs(params.targetheight) <= 18) {
    self walk_traversal(params);
  } else if(params.targetheight > 0) {
    if(params.var_5aacf42 < 0) {
      self botprinterror("<dev string:xa7>");

      self thread function_c3452ef9(params);
      return;
    } else {
      self mantle_traversal(params);
    }
  } else if(params.targetheight < -72 && !(isDefined(params.var_bccf04e7) && params.var_bccf04e7)) {
    self botprinterror("<dev string:xbb>");

    self thread function_c3452ef9(params);
    return;
  } else if(params.targetheight < 0) {
    self fall_traversal(params.endpos);
  } else {
    self botprinterror("<dev string:xce>" + params.startnode.origin);

    self thread function_c3452ef9(params);
    return;
  }

  if(!ispointonnavmesh(self.origin, self)) {
    self botprinterror("<dev string:xe9>" + params.startnode.origin);

    self thread function_c3452ef9(params);
    return;
  } else if(distancesquared(self.origin, params.endpos) > distancesquared(self.origin, params.startpos)) {
    self botprinterror("<dev string:x10c>");

    self thread function_c3452ef9(params);
    return;
  }

  self release_control();
}

release_control(notifyhash) {
  self notify(#"hash_612231aa5def85e2");

  if(!isbot(self)) {
    return;
  }

  self.bot.traversal = undefined;
  self botreleasemanualcontrol();
}

traversal_timeout(params) {
  self endon(#"death", #"hash_a729d7d4c6847f6", #"hash_612231aa5def85e2");
  level endon(#"game_ended");
  wait 3.5;

  self botprinterror("<dev string:x137>" + params.startnode.origin);

  self notify(#"hash_37fc5d1ffce4acaf");
  self thread function_c3452ef9(params);
  self.bot.traversal = undefined;
  self botreleasemanualcontrol();
}

analyze(params) {
  params.starttrace = checknavmeshdirection(params.startpos, params.endpos - params.startpos, 512, 0);
  params.endtrace = checknavmeshdirection(params.endpos, params.startpos - params.endpos, 512, 0);
  params.targetpos = isDefined(params.mantlepos) ? params.mantlepos : params.endtrace;
  params.targetheight = params.targetpos[2] - params.starttrace[2];
  normal = params.startpos - params.endpos;
  params.normal = vectornormalize((normal[0], normal[1], 0));

  if(distance2dsquared(params.starttrace, params.targetpos) == 0) {
    params.var_5aacf42 = 0;
  } else {
    params.var_5aacf42 = vectordot(params.starttrace - params.targetpos, params.normal);
  }

  params.dist2d = distance2d(params.starttrace, params.targetpos);
  params.var_b8915580 = function_51cbae24(params);

  if(self should_record("<dev string:x152>")) {
    var_47d2875c = (params.targetpos[0], params.targetpos[1], params.starttrace[2]);
    var_b03d274a = params.dist2d < 30 ? (0, 1, 0) : (1, 0, 0);
    recordline(params.starttrace, var_47d2875c, var_b03d274a, "<dev string:x163>", self);
    recordsphere(var_47d2875c, 3, var_b03d274a, "<dev string:x163>", self);
    recordsphere(params.starttrace, 3, (0, 1, 0), "<dev string:x163>", self);
    recordsphere(params.targetpos, 3, (1, 0, 1), "<dev string:x163>", self);
  }

}

function_51cbae24(params) {
  if(params.targetheight < 18) {
    return false;
  }

  dir = vectornormalize(params.endpos - params.startpos);
  result = bulletTrace(params.startpos, params.startpos + dir * 512, 0, self);

  if(result[#"surfacetype"] == "ladder") {
    return true;
  }

  return false;
}

mantle_traversal(params) {
  if(self should_record("<dev string:x152>")) {
    record3dtext("<dev string:x16e>", self.origin, (1, 1, 1), "<dev string:x163>", undefined, 0.5);
  }

  edge_approach(params.starttrace, params.normal, 20);
  jump(params.targetpos);
  mantle(params.targetpos);
}

ledge_traversal(endpos, ledgetop, normal) {
  if(self should_record("<dev string:x152>")) {
    record3dtext("<dev string:x181>", self.origin, (1, 1, 1), "<dev string:x163>", undefined, 0.5);
  }

  trace = bulletTrace(ledgetop, ledgetop - (0, 0, 1024), 0, self);
  var_82c7381e = trace[#"position"];
  self botsetmovepoint(endpos);

  for(var_ccaaa590 = vectordot(self.origin - var_82c7381e, normal); var_ccaaa590 > 20; var_ccaaa590 = vectordot(self.origin - var_82c7381e, normal)) {
    waitframe(1);
  }

  self botsetmovemagnitude(0);
  self bottapbutton(10);
  waitframe(1);

  while(!self isonground() || self ismantling()) {
    waitframe(1);
  }
}

jump_traversal(params) {
  if(self should_record("<dev string:x152>")) {
    record3dtext("<dev string:x193>", self.origin, (1, 1, 0), "<dev string:x163>", undefined, 0.5);
  }

  self edge_approach(params.starttrace, params.normal);
  self jump(params.targetpos);
  self fall();
}

fall_traversal(endpos) {
  if(self should_record("<dev string:x152>")) {
    record3dtext("<dev string:x1a4>", self.origin, (1, 1, 1), "<dev string:x163>", undefined, 0.5);
  }

  self botsetmovemagnitude(1);
  self botsetmovepoint(endpos);
  self fall();
}

walk_traversal(params) {
  if(self should_record("<dev string:x152>")) {
    record3dtext("<dev string:x1b5>", self.origin, (1, 1, 1), "<dev string:x163>", undefined, 0.5);
  }

  self botsetmovemagnitude(1);
  self botsetmovepoint(params.endpos);
  dist = distance2dsquared(self.origin, params.endpos);
  prev_dist = dist;

  while(dist > 256 && prev_dist >= dist) {
    waitframe(1);
    prev_dist = dist;
    dist = distance2dsquared(self.origin, params.endpos);
  }
}

function_fc004e60(params) {
  self botsetmovepoint(params.endpos);

  while(!self isonground()) {
    waitframe(1);
  }
}

teleport(endpos, reason) {
  if(self should_record("<dev string:x152>")) {
    record3dtext("<dev string:x1c6>" + reason, self.origin, (1, 1, 1), "<dev string:x163>", undefined, 0.5);
  }

  self setorigin(endpos);
  self dontinterpolate();
  waitframe(1);
}

mantle(mantlepos) {
  self botsetmovemagnitude(1);

  if(self should_record("<dev string:x152>")) {
    record3dtext("<dev string:x1d3>", mantlepos, (1, 1, 1), "<dev string:x163>", undefined, 0.5);
    recordsphere(mantlepos, 3, (1, 1, 0), "<dev string:x163>", self);
  }

  while(!self isonground() || self ismantling()) {
    waitframe(1);
  }
}

edge_approach(edgepos, normal, dist = 0) {
  if(self should_record("<dev string:x152>")) {
    recordtext = "<dev string:x1dc>";

    if(dist > 0) {
      recordtext = recordtext + "<dev string:x1ec>" + dist;
    }

    record3dtext(recordtext, edgepos, (1, 1, 1), "<dev string:x163>", undefined, 0.5);
    recordsphere(edgepos, 3, (0, 1, 0), "<dev string:x163>", self);
  }

  self botsetmovepoint(edgepos);
  self botsetmovemagnitude(1);

  for(var_459ca70 = vectordot(self.origin - edgepos, normal); var_459ca70 > dist; var_459ca70 = vectordot(self.origin - edgepos, normal)) {
    waitframe(1);
  }
}

jump(var_75f5c2cb) {
  if(self should_record("<dev string:x152>")) {
    record3dtext("<dev string:x1f0>", var_75f5c2cb, (1, 1, 1), "<dev string:x163>", undefined, 0.5);
    recordsphere(var_75f5c2cb, 3, (1, 1, 1), "<dev string:x163>", self);
  }

  self bottapbutton(10);
  waitframe(1);
}

fall() {
  if(self should_record("<dev string:x152>")) {
    record3dtext("<dev string:x1f7>", self.origin, (1, 1, 1), "<dev string:x163>", undefined, 0.5);
  }

  while(self isonground()) {
    waitframe(1);
  }

  while(!self isonground()) {
    waitframe(1);
  }
}