/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\visibility_mode.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace visibility_mode;

function main(funcsarray) {
  level thread function_741772fd1005a4c9(funcsarray);
}

function private function_741772fd1005a4c9(funcsarray) {
  var_36256eeb4f76a38c = getDvar(@ "hash_33a01af682caae50", 0);
  setdvarifuninitialized(@ "hash_33a01af682caae50", var_36256eeb4f76a38c);

  if(getdvarint(@ "hash_33a01af682caae50", -1) <= 0) {
    return;
  }

  level.visibilitymode = spawnStruct();
  level.visibilitymode.activeclients = [];
  level.visibilitymode.funcs = [];

  if(isfunction(funcsarray)) {
    funcsarray = [[funcsarray]]();
  }

  foreach(index, func in funcsarray) {
    level.visibilitymode.funcs[index] = func;
  }

  if(!istrue(function_9ddaf19178508d55())) {
    return;
  }

  level thread function_9d4b2121c099b285();

  level thread function_8977a3724ec5ce9e();
}

function private function_9ddaf19178508d55() {
  if(isDefined(level.visibilitymode.funcs["shouldRun"])) {
    return level[[level.visibilitymode.funcs["shouldRun"]]]();
  }

  return 0;
}

function private function_9d4b2121c099b285() {
  level endon("game_ended");

  if(isDefined(level.visibilitymode.funcs["init"])) {
    level[[level.visibilitymode.funcs["init"]]]();
  }

  level childthread[[level.visibilitymode.funcs["checkForDataUpdates"]]]();

  while(true) {
    level waittill("visibilityModeValUpdatedForPlayer", player, val);
    level.visibilitymode.activeclients = function_c1d9fd48eb09c8c9();

    if(level.visibilitymode.activeclients.size == 0) {
      continue;
    }

    for(index = 0; index < level.visibilitymode.activeclients.size; index++) {
      if(isDefined(level.visibilitymode.activeclients[index]) && !isDefined(level.visibilitymode.activeclients[index].var_ada3f21a8212c26f)) {
        level thread function_c3ae50f84a8329ac(level.visibilitymode.activeclients[index]);
      }
    }
  }
}

function private function_afe539c207a6b2fb(firstplayer, secondplayer) {
  if(issp()) {
    return (firstplayer.team == "axis");
  }

  if(!isDefined(firstplayer) || !isDefined(secondplayer)) {
    return false;
  }

  if(!isDefined(firstplayer.team) || !isDefined(secondplayer.team)) {
    return false;
  }

  if(firstplayer.team == "civilian" || secondplayer.team == "civilian") {
    return false;
  }

  if(level.teambased) {
    sameteam = firstplayer.team == secondplayer.team;
    return !sameteam;
  }

  return firstplayer != secondplayer;
}

function private function_753e2e2a70ae2d65(ent) {
  return isalive(ent) || istrue(ent.var_d4ca148f5670a1f6);
}

function private function_c3ae50f84a8329ac(client) {
  client endon("disconnect");
  client.var_ada3f21a8212c26f = 1;
  playernum = client getentitynumber();
  client childthread function_40353363f8512bb0();
  client thread function_924634e910fbfc75();

  while(client function_5f46cf1503a0541a()) {
    wait 0.5;

    if(!client function_5f46cf1503a0541a()) {
      break;
    }

    if(!isalive(client)) {
      continue;
    }

    active_targets = [[level.visibilitymode.funcs["getTargetArray"]]](client);
    active_targets = array_combine(active_targets, level.visibilitymode.forced_ents);

    for(i = 0; i < active_targets.size; i++) {
      if(active_targets[i] == client) {
        continue;
      }

      if(!function_753e2e2a70ae2d65(active_targets[i])) {
        continue;
      }

      if(active_targets[i] function_3359e7308038233e(client)) {
        continue;
      }

      if(isDefined(active_targets[i].var_79a7c8a11ed7c0e3)) {
        if(isDefined(active_targets[i].var_79a7c8a11ed7c0e3[playernum])) {
          continue;
        }
      }

      if(isDefined(active_targets[i])) {
        active_targets[i] thread function_8419f0f3143cdcfa(client);
      }
    }
  }

  client.var_ada3f21a8212c26f = undefined;
  client notify("visibiltyMode_disabled");
}

function private function_8419f0f3143cdcfa(client) {
  if(istrue(self.var_533e1f58c82c7473)) {
    return;
  }

  playernum = client getentitynumber();

  if(isDefined(self.var_79a7c8a11ed7c0e3)) {
    if(isDefined(self.var_79a7c8a11ed7c0e3[playernum])) {
      return;
    }
  }

  if(!isDefined(self.team)) {
    return;
  }

  var_517520758f9c478f = client function_266da5d877397673();

  if(function_afe539c207a6b2fb(self, client)) {
    if(var_517520758f9c478f == "alliesonly") {
      return;
    }

    self.var_23e106fcb074622f = client function_ea4e39208c784a4a();
  } else if(isPlayer(self)) {
    if(var_517520758f9c478f == "enemiesonly") {
      return;
    }

    self.var_23e106fcb074622f = client function_63a1833b6a352cd7();
  } else {
    if(var_517520758f9c478f == "enemiesonly") {
      return;
    }

    self.var_23e106fcb074622f = client function_4448756918b98e87();
  }

  enablefunc = level.visibilitymode.funcs["enableForClient"];

  if(!isDefined(self.var_79a7c8a11ed7c0e3)) {
    self.var_79a7c8a11ed7c0e3 = [];
  }

  id = self[[enablefunc]](client, self.var_23e106fcb074622f, "lowest");
  clientnum = client getentitynumber();
  self.var_79a7c8a11ed7c0e3[clientnum] = id;
  thread visibilitymode_disableoutlineoncallback(client);
  thread visibilitymode_disableoutlineondeath();
  thread visibilitymode_disableonsmokeocclude(client);
}

function private visibilitymode_disableoutlineondeath() {
  level endon("game_ended");
  self notify("visibilityMode_disableOutlineOnDeath");
  self endon("visibilityMode_disableOutlineOnDeath");
  outlineids = [];

  foreach(id in self.var_79a7c8a11ed7c0e3) {
    outlineids[outlineids.size] = id;
  }

  self waittill("death_or_disconnect");

  foreach(id in outlineids) {
    if(isDefined(id)) {
      self[[level.visibilitymode.funcs["disable"]]](id);
    }
  }

  self.var_23e106fcb074622f = undefined;
  self.var_79a7c8a11ed7c0e3 = undefined;
}

function private visibilitymode_disableoutlineoncallback(client) {
  self endon("death");
  client endon("disconnect");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  clientnum = client getentitynumber();
  self notify("visibilityMode_disableOutlineOnCallback_" + clientnum);
  self endon("visibilityMode_disableOutlineOnCallback_" + clientnum);
  oldvalue = client.visibilitymodeval;

  for(var_26d30630ea0383c3 = client.var_5615f87228f360c8; true; var_26d30630ea0383c3 = client.var_5615f87228f360c8) {
    client waittill("visibilityModeVal", val, outlineval);

    if(isDefined(val) && val == 0) {
      break;
    }

    if(val != oldvalue || outlineval != var_26d30630ea0383c3) {
      function_85e0f20ba385bf6d(client);
    }

    oldvalue = client.visibilitymodeval;
  }

  function_6b814eafddccdd4d(client);
}

function private function_6b814eafddccdd4d(client) {
  if(!isDefined(self.var_79a7c8a11ed7c0e3)) {
    return;
  }

  foreach(playernum, id in self.var_79a7c8a11ed7c0e3) {
    clientnum = client getentitynumber();

    if(clientnum == playernum) {
      if(isDefined(id)) {
        self[[level.visibilitymode.funcs["disable"]]](id);
        self.var_79a7c8a11ed7c0e3[playernum] = undefined;
      }
    }
  }
}

function private function_85e0f20ba385bf6d(client) {
  function_6b814eafddccdd4d(client);
  thread function_8419f0f3143cdcfa(client);
}

function private visibilitymode_disableonsmokeocclude(client) {
  if(!isDefined(level.visibilitymode.funcs["outlineOccluded"])) {
    return;
  }

  clientnum = client getentitynumber();
  self notify("visibilityMode_disableOnsmokeOcclude_" + clientnum);
  self endon("visibilityMode_disableOnsmokeOcclude_" + clientnum);
  self endon("death_or_disconnect");
  client endon("disconnect");
  client endon("visibiltyMode_disabled");

  while(true) {
    wait 0.5;

    if(!within_fov(client.origin, client.angles, self.origin, 0.766)) {
      continue;
    }

    if(function_3359e7308038233e(client)) {
      function_6b814eafddccdd4d(client);
      return;
    }
  }
}

function private function_3359e7308038233e(client) {
  if(!isDefined(level.visibilitymode.funcs["outlineOccluded"])) {
    return false;
  }

  self_eye = undefined;

  if(issentient(self)) {
    self_eye = self getEye();
  } else if(istrue(self.var_d4ca148f5670a1f6)) {
    if(self tagexists("TAG_EYE")) {
      self_eye = self gettagorigin("TAG_EYE");
    } else if(self tagexists("TAG_HEAD")) {
      self_eye = self gettagorigin("TAG_HEAD");
    } else {
      midpoint = function_abf76cc289cf03a3(self.model);
      self_eye = self.origin + (0, 0, midpoint[2] * 2);
    }
  }

  if([[level.visibilitymode.funcs["outlineOccluded"]]](client getEye(), self_eye)) {
    return true;
  }

  return false;
}

function function_8c2e8285c9915b12(invalue, outlinevalue) {
  println("<dev string:x1c>" + invalue);
  unpackdata = spawnStruct();
  unpackdata.currentvalue = invalue;
  unpackdata.outlinevalue = outlinevalue;
  unpackdata.controllerindex = 0;
  unpackdata.vismode = "normal";
  unpackdata.playercolor = "green";
  unpackdata.npccolor = "blue";
  unpackdata.enemycolor = "red";
  unpackdata.adsconfirm = 0;
  unpackdata = function_f3239764175224da(unpackdata);
  unpackdata = function_70cde4aff892c728(unpackdata);
  unpackdata = function_3b372246c79c0658(unpackdata);
  unpackdata = function_d7ed7d211a79ceb3(unpackdata);
  unpackdata = function_93260fadbd47622b(unpackdata);
  self.var_be1e6d7ff9628b76 = unpackdata;
  self.visibilitymodeval = invalue;
  self.var_5615f87228f360c8 = outlinevalue;
  self notify("visibilityModeVal", invalue, outlinevalue);
  level notify("visibilityModeValUpdatedForPlayer", self, invalue);
}

function private function_f3239764175224da(data) {
  if(data.currentvalue >= 3) {
    data.vismode = "alliesonly";
  } else if(data.currentvalue >= 2) {
    data.vismode = "enemiesonly";
  } else {
    data.vismode = "normal";
  }

  return data;
}

function private function_70cde4aff892c728(data) {
  if(isDefined(data.outlinevalue) && data.outlinevalue == 0) {
    data.currentvalue -= 0;
    data.playercolor = "outlinefill_depth_green";
  } else if(isDefined(data.outlinevalue) && data.outlinevalue == 1) {
    data.currentvalue -= 64;
    data.playercolor = "outline_highvis_green";
  } else if(data.currentvalue >= 192) {
    data.currentvalue -= 192;
    data.playercolor = "outline_depth_white";
  } else if(data.currentvalue >= 128) {
    data.currentvalue -= 128;
    data.playercolor = "outlinefill_depth_white";
  } else if(data.currentvalue >= 64) {
    data.currentvalue -= 64;
    data.playercolor = "outline_highvis_green";
  } else {
    data.currentvalue -= 0;
    data.playercolor = "outlinefill_depth_green";
  }

  return data;
}

function private function_3b372246c79c0658(data) {
  if(isDefined(data.outlinevalue) && data.outlinevalue == 0) {
    data.currentvalue -= 0;
    data.npccolor = "outlinefill_depth_cyan";
  } else if(isDefined(data.outlinevalue) && data.outlinevalue == 1) {
    data.currentvalue -= 16;
    data.npccolor = "outline_depth_cyan";
  } else if(data.currentvalue >= 48) {
    data.currentvalue -= 48;
    data.npccolor = "outline_depth_green";
  } else if(data.currentvalue >= 32) {
    data.currentvalue -= 32;
    data.npccolor = "outlinefill_depth_green";
  } else if(data.currentvalue >= 16) {
    data.currentvalue -= 16;
    data.npccolor = "outline_depth_cyan";
  } else {
    data.currentvalue -= 0;
    data.npccolor = "outlinefill_depth_cyan";
  }

  return data;
}

function private function_d7ed7d211a79ceb3(data) {
  if(isDefined(data.outlinevalue) && data.outlinevalue == 0) {
    data.currentvalue -= 0;
    data.enemycolor = "outlinefill_depth_red";
  } else if(isDefined(data.outlinevalue) && data.outlinevalue == 1) {
    data.currentvalue -= 4;
    data.enemycolor = "outline_depth_red";
  } else if(data.currentvalue >= 12) {
    data.currentvalue -= 12;
    data.enemycolor = "outline_depth_yellow";
  } else if(data.currentvalue >= 8) {
    data.currentvalue -= 8;
    data.enemycolor = "outlinefill_depth_yellow";
  } else if(data.currentvalue >= 4) {
    data.currentvalue -= 4;
    data.enemycolor = "outline_depth_red";
  } else {
    data.currentvalue -= 0;
    data.enemycolor = "outlinefill_depth_red";
  }

  return data;
}

function private function_93260fadbd47622b(data) {
  if(data.currentvalue > 2) {
    data.currentvalue -= 2;
    data.adsconfirm = 1;
  } else {
    data.currentvalue -= 0;
    data.adsconfirm = 0;
  }

  return data;
}

function private function_40353363f8512bb0() {
  childthread function_d26ee9ff27d79349();

  while(function_5f46cf1503a0541a()) {
    wait 0.1;

    if(!isalive(self)) {
      continue;
    }

    if(!function_787341d4cc18bba()) {
      continue;
    }

    playerads = self playerads();

    if(playerads == 1) {
      childthread function_c4e7b8218a1533cc();
    }
  }
}

function private function_c4e7b8218a1533cc() {
  tracedata = function_b8618b0d8d7ff3e3();
  entity = tracedata.entity;

  if(isDefined(entity) && isDefined(entity.team) && isDefined(entity.var_23e106fcb074622f)) {
    var_517520758f9c478f = function_266da5d877397673();

    if(function_afe539c207a6b2fb(entity, self)) {
      if(var_517520758f9c478f == "alliesonly") {
        return;
      }

      ispinged = 0;

      if(tracedata.type == "middle") {
        if(ispinged) {
          if(soundexists("ui_text_type")) {
            self playlocalsound("ui_text_type");
          }
        }

        if(soundexists("2pop")) {
          self playlocalsound("2pop");
        }
      } else if(tracedata.type == "middle_near") {
        if(ispinged) {
          if(soundexists("ui_menu_ability_hover")) {
            self playlocalsound("ui_menu_ability_hover");
          }
        }

        if(soundexists("2pop_low")) {
          self playlocalsound("2pop_low");
        }
      } else if(tracedata.type == "left") {
        if(ispinged) {
          if(soundexists("ui_menu_ability_hover")) {
            self playlocalsound("ui_menu_ability_hover");
          }
        }

        if(soundexists("2pop_low")) {
          self playlocalsound("2pop_low");
        }
      } else {
        if(ispinged) {
          if(soundexists("ui_menu_ability_hover")) {
            self playlocalsound("ui_menu_ability_hover");
          }
        }

        if(soundexists("2pop_low")) {
          self playlocalsound("2pop_low");
        }
      }

      return;
    }

    if(isPlayer(entity)) {
      if(var_517520758f9c478f == "enemiesonly") {
        return;
      }

      if(soundexists("ui_chyron_firstline")) {
        self playlocalsound("ui_chyron_firstline");
      }

      return;
    }

    if(var_517520758f9c478f == "enemiesonly") {
      return;
    }

    if(soundexists("ui_chyron_plusminus")) {
      self playlocalsound("ui_chyron_plusminus");
    }
  }
}

function private function_b8618b0d8d7ff3e3() {
  tracedist = self[[level.visibilitymode.funcs["getADSWeaponDist"]]]();
  playerangles = self getgunangles();
  traceend = self getEye() + anglesToForward(playerangles) * tracedist;
  traceoffset = (0, 0, 0);
  var_9ccff25b22cb483b = 32;
  returndata = spawnStruct();
  returndata.entity = undefined;
  returndata.type = "middle";

  for(i = 0; i < 15; i++) {
    if(i == 1) {
      traceoffset = rotatevector((0, var_9ccff25b22cb483b * -1, 0), playerangles);
      returndata.type = "left";
    } else if(i == 2) {
      traceoffset = rotatevector((0, var_9ccff25b22cb483b, 0), playerangles);
      returndata.type = "right";
    } else if(i == 3) {
      traceoffset = rotatevector((0, 0, var_9ccff25b22cb483b), playerangles);
      returndata.type = "middle_near";
    } else if(i == 4) {
      traceoffset = rotatevector((0, var_9ccff25b22cb483b * -1, var_9ccff25b22cb483b), playerangles);
      returndata.type = "left";
    } else if(i == 5) {
      traceoffset = rotatevector((0, var_9ccff25b22cb483b, var_9ccff25b22cb483b), playerangles);
      returndata.type = "right";
    } else if(i == 6) {
      traceoffset = rotatevector((0, 0, var_9ccff25b22cb483b * -1), playerangles);
      returndata.type = "middle_near";
    } else if(i == 7) {
      traceoffset = rotatevector((0, var_9ccff25b22cb483b * -1, var_9ccff25b22cb483b * -1), playerangles);
      returndata.type = "left";
    } else if(i == 8) {
      traceoffset = rotatevector((0, var_9ccff25b22cb483b, var_9ccff25b22cb483b * -1), playerangles);
      returndata.type = "right";
    } else if(i == 9) {
      traceoffset = rotatevector((0, var_9ccff25b22cb483b * -2, var_9ccff25b22cb483b), playerangles);
      returndata.type = "left";
    } else if(i == 10) {
      traceoffset = rotatevector((0, var_9ccff25b22cb483b * -2, 0), playerangles);
      returndata.type = "left";
    } else if(i == 11) {
      traceoffset = rotatevector((0, var_9ccff25b22cb483b * -2, var_9ccff25b22cb483b * -1), playerangles);
      returndata.type = "left";
    } else if(i == 12) {
      traceoffset = rotatevector((0, var_9ccff25b22cb483b * 2, var_9ccff25b22cb483b), playerangles);
      returndata.type = "right";
    } else if(i == 13) {
      traceoffset = rotatevector((0, var_9ccff25b22cb483b * 2, 0), playerangles);
      returndata.type = "right";
    } else if(i == 14) {
      traceoffset = rotatevector((0, var_9ccff25b22cb483b * 2, var_9ccff25b22cb483b * -1), playerangles);
      returndata.type = "right";
    }

    trace = scripts\engine\trace::ray_trace(self getEye(), traceend + traceoffset);

    if(isDefined(trace["entity"]) && (isPlayer(trace["entity"]) || issentient(trace["entity"]))) {
      if(returndata.type == "middle") {
        returndata.type = function_4ffad916a54ca2f(trace, playerangles, tracedist);
      }

      returndata.entity = trace["entity"];
      return returndata;
    }
  }

  return returndata;
}

function private function_4ffad916a54ca2f(trace, playerangles, tracedist) {
  hitpos = trace["position"];
  var_1dc4c86806743c5c = trace["entity"] getEye();
  targetoriginpos = trace["entity"] gettagorigin("tag_origin", 1);
  var_734d8fcbdd28f284 = self getEye() + anglesToForward(playerangles) * tracedist * 1.5;

  if(isDefined(var_1dc4c86806743c5c) && isDefined(targetoriginpos)) {
    data = scripts\engine\utility::closestdistancebetweenlines(targetoriginpos, var_1dc4c86806743c5c, self getEye(), var_734d8fcbdd28f284);

    if(isDefined(data) && data[2] < 7) {
      return "middle";
    } else if(isDefined(data)) {
      up = anglestoup(playerangles);
      var_8a15205372a55a43 = vectornormalize2(var_734d8fcbdd28f284 - self.origin);
      metotarget = vectornormalize2(targetoriginpos - self.origin);
      angbetween = math::anglebetweenvectorssigned(var_8a15205372a55a43, metotarget, up);

      if(angbetween > 0) {
        return "right";
      } else {
        return "left";
      }
    }
  }

  return "middle";
}

function private function_d26ee9ff27d79349() {
  self.var_ff7a6caa0a544d30 = 0;
  self.var_44446bd6d8fd6ed0 = 0;
  self notifyonplayercommand("vis_sprint_pressed", "+breath_sprint");
  self notifyonplayercommand("vis_sprint_pressed", "+melee_breath");

  while(function_5f46cf1503a0541a()) {
    wait 0.1;

    if(!isalive(self)) {
      continue;
    }

    if(!function_787341d4cc18bba()) {
      wait 1;
      continue;
    }

    playerads = self playerads();

    if(playerads == 1) {
      if(self.var_ff7a6caa0a544d30 == 0) {
        self.var_ff7a6caa0a544d30 = 1;
        thread function_dc7453c8550c512c();
        thread function_eec104c84dc70618("vis_sprint_pressed");
      }

      continue;
    }

    if(playerads < 1) {
      self.var_ff7a6caa0a544d30 = 0;
      self.var_44446bd6d8fd6ed0 = 0;
      self notify("visibilityMode_stopads");
    }
  }
}

function private function_eec104c84dc70618(type) {
  self endon("death_or_disconnect");
  self endon("visibilityMode_stopads");

  if(type == "vis_sprint_pressed") {
    while(true) {
      self waittill("vis_sprint_pressed");
      function_b17c1eba153a25e8();
      function_5c04dcd5e95fbb53();
      function_49afc10334084167();
    }
  }
}

function private function_b17c1eba153a25e8() {
  if(self getstance() != "prone") {
    return;
  }

  angles = (0, self.angles[1], self.angles[2]);
  self setplayerangles(angles);
}

function private function_5c04dcd5e95fbb53() {
  self endon("death_or_disconnect");
  self endon("visibilityMode_stopads");

  if(istrue(level.visibilitymode.var_419d1a784e4b187c)) {
    return;
  }

  clientallies = function_e3c04f03881b4dc7();
  active_players = [];
  var_b94177401c42c6ef = [];

  foreach(ally in clientallies) {
    if(isPlayer(ally)) {
      active_players[active_players.size] = ally;
      continue;
    }

    var_b94177401c42c6ef[var_b94177401c42c6ef.size] = ally;
  }

  active_players = sortbydistance(active_players, self.origin);

  for(i = 0; i < active_players.size; i++) {
    if(active_players[i] == self) {
      continue;
    }

    if(!isDefined(active_players[i]) || !isalive(active_players[i])) {
      continue;
    }

    if(!istrue(active_players[i].inlaststand)) {
      if(soundexists("uin_ping_confirm")) {
        active_players[i] playSound("uin_ping_confirm");
      }
    } else if(soundexists("uin_ping_wheel_announce_help")) {
      active_players[i] playSound("uin_ping_wheel_announce_help");
    }

    if(active_players.size > 1) {
      wait 0.2;
    }
  }

  if(active_players.size > 0) {
    wait 0.5;
  }
}

function private function_dc7453c8550c512c() {
  self endon("death_or_disconnect");
  self endon("visibilityMode_stopads");

  if(self.var_44446bd6d8fd6ed0 == 0) {
    self.var_44446bd6d8fd6ed0 = 1;
  } else {
    return;
  }

  maxdist = self[[level.visibilitymode.funcs["getADSWeaponDist"]]]();
  maxdistsq = squared(maxdist);
  clientenemies = function_90ce2459298d263();
  clientenemies = sortbydistance(clientenemies, self.origin);
  var_72013161599ed91b = min(5, clientenemies.size);

  for(i = 0; i < var_72013161599ed91b; i++) {
    if(!function_8eee51af38988db6(self, clientenemies[i])) {
      continue;
    }

    if(!isDefined(clientenemies[i]) || !isalive(clientenemies[i])) {
      continue;
    }

    var_c92a4399b993144a = distancesquared(clientenemies[i].origin, self.origin);

    if(var_c92a4399b993144a < maxdistsq) {
      if(soundexists("uin_ping_enemy")) {
        clientenemies[i] playSound("uin_ping_enemy");
        delay = math::remap(var_c92a4399b993144a, 0, maxdistsq, 0.15, 0.6);
        wait delay;
      }
    }
  }
}

function private function_49afc10334084167() {
  self endon("death_or_disconnect");
  self endon("visibilityMode_stopads");

  if(istrue(level.visibilitymode.var_a7628fab5ece8d7a)) {
    return;
  }

  flag_wait("objectives_registered");
  var_4267b02eda9e961 = [];

  for(i = 0; i < level.worldobjidpool.active.size; i++) {
    if(isDefined(level.worldobjidpool.active[i].identifier) && level.worldobjidpool.active[i].identifier == "nonobj_marker") {
      continue;
    }

    objstruct = spawnStruct();
    objstruct.objinfo = level.worldobjidpool.active[i];
    objstruct.origin = objective_getlocation(level.worldobjidpool.active[i].objid, 0);
    var_4267b02eda9e961[var_4267b02eda9e961.size] = objstruct;
  }

  var_4267b02eda9e961 = sortbydistance(var_4267b02eda9e961, self.origin);

  for(i = 0; i < var_4267b02eda9e961.size; i++) {
    var_8137caff89efd99 = function_bd41d880db5c1bad(var_4267b02eda9e961[i].objinfo.identifier);

    if(isDefined(var_8137caff89efd99)) {
      level thread function_95cd04544bc213e5(var_4267b02eda9e961[i].origin, self, var_8137caff89efd99);
    } else {
      level thread function_95cd04544bc213e5(var_4267b02eda9e961[i].origin, self);
    }

    if(var_4267b02eda9e961.size > 1) {
      wait 1;
    }
  }
}

function private function_95cd04544bc213e5(origin, player, customsound) {
  tag_origin = spawn("script_model", origin);
  tag_origin setModel("tag_origin");
  soundtoplay = "uin_ping_mission";

  if(isDefined(customsound)) {
    soundtoplay = customsound;
  }

  player playSound(soundtoplay);
  wait lookupsoundlength(soundtoplay) / 1000;
  tag_origin delete();
}

function private function_bd41d880db5c1bad(var_bc23a0a6125c16f4) {
  if(isDefined(level.visibilitymode.var_3a5f706a07632f07)) {
    foreach(index, sound in level.visibilitymode.var_3a5f706a07632f07) {
      if(index == var_bc23a0a6125c16f4) {
        return sound;
      }
    }
  }

  return undefined;
}

function function_7068f93aacf2ef59(var_bc23a0a6125c16f4, soundalias) {
  if(!isDefined(level.visibilitymode)) {
    return;
  }

  if(!isDefined(level.visibilitymode.var_3a5f706a07632f07)) {
    level.visibilitymode.var_3a5f706a07632f07 = [];
  }

  if(isDefined(level.visibilitymode.var_3a5f706a07632f07[var_bc23a0a6125c16f4])) {
    return;
  }

  level.visibilitymode.var_3a5f706a07632f07[var_bc23a0a6125c16f4] = soundalias;
}

function function_8eee51af38988db6(player, target) {
  if(!within_fov(player.origin, player.angles, target.origin, 0.766)) {
    return false;
  }

  playereye = player getEye();
  feetorigin = target.origin;

  if(sighttracepassed(playereye, feetorigin, 1, player, target)) {
    return true;
  }

  eyeorigin = undefined;

  if(isagent(target)) {
    eyeorigin = target getapproxeyepos();
  } else {
    eyeorigin = target getEye();
  }

  if(sighttracepassed(playereye, eyeorigin, 1, player, target)) {
    return true;
  }

  midorigin = (eyeorigin + feetorigin) * 0.5;

  if(sighttracepassed(playereye, midorigin, 1, player, target)) {
    return true;
  }

  return false;
}

function function_5f46cf1503a0541a() {
  if(isDefined(self.visibilitymodeval)) {
    return (self.visibilitymodeval > 0);
  }

  return false;
}

function function_ea4e39208c784a4a() {
  color = "outline_depth_red";

  if(isDefined(self.var_be1e6d7ff9628b76) && isDefined(self.var_be1e6d7ff9628b76.enemycolor)) {
    color = self.var_be1e6d7ff9628b76.enemycolor;
  }

  return color;
}

function function_4448756918b98e87() {
  color = "outline_depth_cyan";

  if(isDefined(self.var_be1e6d7ff9628b76) && isDefined(self.var_be1e6d7ff9628b76.npccolor)) {
    color = self.var_be1e6d7ff9628b76.npccolor;
  }

  return color;
}

function function_63a1833b6a352cd7() {
  color = "outline_highvis_green";

  if(isDefined(self.var_be1e6d7ff9628b76) && isDefined(self.var_be1e6d7ff9628b76.playercolor)) {
    color = self.var_be1e6d7ff9628b76.playercolor;
  }

  return color;
}

function function_266da5d877397673() {
  mode = "normal";

  if(isDefined(self.var_be1e6d7ff9628b76) && isDefined(self.var_be1e6d7ff9628b76.vismode)) {
    mode = self.var_be1e6d7ff9628b76.vismode;
  }

  return mode;
}

function function_787341d4cc18bba() {
  adsconfirm = 0;

  if(isDefined(self.var_be1e6d7ff9628b76) && isDefined(self.var_be1e6d7ff9628b76.adsconfirm)) {
    adsconfirm = self.var_be1e6d7ff9628b76.adsconfirm;
  }

  return adsconfirm;
}

function function_88ec96d66632c2b9() {
  active_targets = [[level.visibilitymode.funcs["getTargetArray"]]](self);
  returnguys = [];
  playernum = self getentitynumber();

  for(i = 0; i < active_targets.size; i++) {
    if(isDefined(active_targets[i].var_79a7c8a11ed7c0e3)) {
      if(isDefined(active_targets[i].var_79a7c8a11ed7c0e3[playernum])) {
        returnguys[returnguys.size] = active_targets[i];
      }
    }
  }

  return returnguys;
}

function function_90ce2459298d263() {
  all_targets = function_88ec96d66632c2b9();
  return_targets = [];

  for(i = 0; i < all_targets.size; i++) {
    if(function_afe539c207a6b2fb(all_targets[i], self)) {
      return_targets[return_targets.size] = all_targets[i];
    }
  }

  return return_targets;
}

function function_e3c04f03881b4dc7() {
  all_targets = function_88ec96d66632c2b9();
  return_targets = [];

  for(i = 0; i < all_targets.size; i++) {
    if(!function_afe539c207a6b2fb(all_targets[i], self)) {
      return_targets[return_targets.size] = all_targets[i];
    }
  }

  return return_targets;
}

function function_c1d9fd48eb09c8c9() {
  if(isDefined(level.players)) {
    activeplayers = [];

    for(i = 0; i < level.players.size; i++) {
      if(level.players[i] function_5f46cf1503a0541a()) {
        activeplayers[activeplayers.size] = level.players[i];
      }
    }

    return activeplayers;
  }

  if(isDefined(level.player)) {
    return level.player function_5f46cf1503a0541a();
  }

  return [];
}

function function_924634e910fbfc75() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("visibiltyMode_disabled");

  while(true) {
    level waittill("visibilityTeamName", teamname, soldiersarray, var_5f622d6d58521bea);

    foreach(soldier in soldiersarray) {
      if(!function_753e2e2a70ae2d65(soldier)) {
        continue;
      }

      soldier.team = teamname;

      if(istrue(var_5f622d6d58521bea)) {
        soldier.agentname = undefined;
      }

      if(!isDefined(soldier.lastteam)) {
        soldier.lastteam = "";
      }

      if(teamname != soldier.lastteam) {
        soldier function_85e0f20ba385bf6d(self);
        soldier.lastteam = teamname;

        if(isDefined(soldier.headmodel) && isent(soldier.headmodel)) {
          function_8ba05ef17e2b7d10(soldier.headmodel, teamname);
        }
      }
    }
  }
}

function function_8ba05ef17e2b7d10(entity, team) {
  if(!isDefined(level.visibilitymode.forced_ents)) {
    level.visibilitymode.forced_ents = [];
  }

  entity.var_d4ca148f5670a1f6 = 1;
  ent_number = entity getentitynumber();

  if(!is_equal(entity.team, team)) {
    entity.team = team;
    level.visibilitymode.forced_ents[ent_number] = entity;
    level notify("visibilityTeamName", team, [entity]);
  }
}

function function_b6e23e71bb7ad50f(entity) {
  if(isDefined(entity)) {
    ent_number = entity getentitynumber();

    if(isDefined(level.visibilitymode.forced_ents) && isDefined(level.visibilitymode.forced_ents[ent_number])) {
      entity.var_d4ca148f5670a1f6 = undefined;
      level.visibilitymode.forced_ents[ent_number] = undefined;
    }
  }
}

function function_d5f76e611c78509a() {
  entity = self;
  model = entity.model;
  headmodel = entity.headmodel;

  if(istrue(entity.var_d4ca148f5670a1f6)) {
    return;
  }

  if(isPlayer(entity) || isai(entity) || issentient(entity)) {
    return;
  }

  if(self tagexists("TAG_EYE") || self tagexists("j_head")) {
    if(isDefined(entity.cratetype) && entity.cratetype != "") {
      function_8ba05ef17e2b7d10(entity, entity.team);
      return;
    }

    if(issubstr(model, "enemy") || issubstr(model, "axis") || issubstr(model, "villain")) {
      function_8ba05ef17e2b7d10(entity, "axis");
      return;
    }

    function_8ba05ef17e2b7d10(entity, "allies");
  }
}

function private function_8977a3724ec5ce9e() {
  level endon("game_ended");
  dvar = @ "hash_5ecd08979278a317";

  while(true) {
    while(true) {
      var_4f9df27618277b1e = getDvar(dvar, "");

      if(var_4f9df27618277b1e != "") {
        level thread function_bf79c9a4bc54b7da(var_4f9df27618277b1e);
        setDvar(dvar, "");
      }

      wait 0.1;
    }

    wait 0.1;
  }
}

function private function_bf79c9a4bc54b7da(val) {
  val = int(val);
  level.players[0] function_8c2e8285c9915b12(val);
}