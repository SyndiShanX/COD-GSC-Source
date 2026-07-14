/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\edgehang.gsc
******************************************/

#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace edgehang;

function edgehang() {
  wait 0.5;
  level.edgehanggroups = getEntArray("\x8d\x83\xa3 \x18G\x17\xef\x9f8*\xcbt", #script_noteworthy);
  level.player.edgehang = 0;

  if(getdvarint(@ "bg_enablehangpmove")) {
    return;
  }

  foreach(edgehanggroup in level.edgehanggroups) {
    if(!isDefined(edgehanggroup.angles)) {
      edgehanggroup.angles = (0, 0, 0);
    }

    edgehanggroup scrubangles();
    edgehanggroup thread function_c26d1d9a23923f73();
  }
}

function function_c26d1d9a23923f73() {
  self.playerhanging = 0;
  createsplines();

  thread function_d128d70edd4180c4();

  while(true) {
    function_7de23230579c0c96();

    if(true) {
      thread function_e9c8013f5050ca3b();
      thread function_b46ec5dc6ed47a62();
      thread function_b18342487c7881fd();
    } else {
      thread function_2d7ebbbafb7513eb();
      thread function_d2f0b7faf8e716e4();
    }

    self.hanginteract waittill("\x91`\xb1\xe7T\x97>");
    function_27f5db3548d3d663();
  }
}

function createsplines() {
  self.splines = [];

  for(startnode = getEnt(self.target, #targetname); true; startnode = endnode) {
    if(!isDefined(startnode.target)) {
      startnode delete();
      break;
    }

    endnode = getEnt(startnode.target, #targetname);

    if(!isDefined(endnode)) {
      break;
    }

    startnode scrubangles();
    yawoffset = startnode.angles[1] - self.angles[1];

    if(yawoffset < 0) {
      yawoffset += 360;
    } else if(yawoffset > 360) {
      yawoffset -= 360;
    }

    function_94318ec231f11a5d(startnode, endnode, yawoffset);
    startnode delete();
  }
}

function scrubangles() {
  f = anglesToForward(self.angles);
  r = anglestoright(self.angles);
  u = anglestoup(self.angles);
  self.angles = axistoangles(f, r, u);
}

function function_d2f0b7faf8e716e4() {
  jumpon = 0;
  self.hanginteract endon("\x91`\xb1\xe7T\x97>");

  while(true) {
    if(function_4da49bf8f1d6e6fe(self.hanginteract)) {
      if(!level.player isonground() && level.player useButtonPressed() && !level.player ismantling()) {
        dir = level.player getnormalizedmovement();
        dir = (dir[0], dir[1] * -1, 0);

        if(length(dir) > 0.5) {
          flatf = anglesToForward((0, level.player.angles[1], 0));
          dirpressed = rotatevector(vectorNormalize(dir), level.player.angles);
          var_8edfb7f2461c5f19 = (self.hanginteract.origin[0], self.hanginteract.origin[1], 0);
          flatplayerorigin = (level.player.origin[0], level.player.origin[1], 0);
          vecto = var_8edfb7f2461c5f19 - flatplayerorigin;
          dirto = vectorNormalize(vecto);
          distto = length(self.hanginteract.origin - level.player.origin);
          dotto = vectordot(dirpressed, dirto);
          dotfacing = vectordot(flatf, dirto);

          if(distto < 100 && dotto > 0.2 && dotfacing > 0.2) {
            self.jumpon = 1;
            self.hanginteract notify("\x91`\xb1\xe7T\x97>");
          }
        }
      }
    }

    wait 0.05;
  }
}

function function_7de23230579c0c96() {
  self.hanginteract = utility::spawn_tag_origin();
  thread function_ec4257a859a2c9ef();
}

function function_a59be84d6f8948d2() {
  jumpon = 0;
  self.hanginteract endon("\x91`\xb1\xe7T\x97>");

  while(true) {
    if(function_4da49bf8f1d6e6fe(self.hanginteract)) {
      if(level.player ismantling()) {
        distto = length(self.hanginteract.origin - level.player.origin);
        dot = vectordot(anglesToForward(self.hanginteract.angles), anglesToForward(level.player.angles));

        if(distto < 64 && dot > 0.4) {
          self.jumpon = 1;
          self.hanginteract notify("\x91`\xb1\xe7T\x97>");
        }
      }
    }

    wait 0.05;
  }
}

function function_e9c8013f5050ca3b() {
  jumpon = 0;
  self.hanginteract endon("\x91`\xb1\xe7T\x97>");

  while(true) {
    if(function_4da49bf8f1d6e6fe(self.hanginteract)) {
      if(!level.player.edgehang && !level.player isonground() && !level.player ismantling() && !level.player isonladder()) {
        dir = level.player getnormalizedmovement();
        dir = (dir[0], dir[1] * -1, 0);

        if(length(dir) > 0.5) {
          flatf = anglesToForward((0, level.player.angles[1], 0));
          dirpressed = rotatevector(vectorNormalize(dir), level.player.angles);
          var_8edfb7f2461c5f19 = (self.hanginteract.origin[0], self.hanginteract.origin[1], 0);
          flatplayerorigin = (level.player.origin[0], level.player.origin[1], 0);
          vecto = var_8edfb7f2461c5f19 - flatplayerorigin;
          dirto = vectorNormalize(vecto);
          distto = length(self.hanginteract.origin - level.player.origin);
          dotto = vectordot(dirpressed, dirto);
          dotside = vectordot(dirto, anglesToForward(self.hanginteract.angles));
          dotfacing = vectordot(flatf, dirto);

          if(distto < 70 && dotto > 0.2 && dotfacing > 0.2 && dotside > -0.1) {
            self.jumpon = 1;
            self.hanginteract notify("\x91`\xb1\xe7T\x97>");
          }
        }
      }
    }

    wait 0.05;
  }
}

function function_4da49bf8f1d6e6fe(hanginteract) {
  return isDefined(level.player.var_12af9a4d1fbb1882) && hanginteract.origin == level.player.var_12af9a4d1fbb1882.origin;
}

function function_b18342487c7881fd() {
  interact = 0;
  self.hanginteract endon("\x91`\xb1\xe7T\x97>");

  while(true) {
    if(function_4da49bf8f1d6e6fe(self.hanginteract)) {
      if(!level.player.edgehang && level.player isonladder()) {
        vecto = self.hanginteract.origin - level.player.origin;
        dist = length(vecto);

        if(dist < 70) {
          flat_dir = (self.hanginteract.origin[0], self.hanginteract.origin[1], 0) - (level.player.origin[0], level.player.origin[1], 0);
          flat_dir = vectorNormalize(flat_dir);
          hangnodef = anglesToForward(self.hanginteract.angles);
          flatdotto = vectordot(flat_dir, hangnodef);

          if(flatdotto > 0.99) {
            height = level.player.origin[2] - self.hanginteract.origin[2] - -70;
            dir = level.player getnormalizedmovement();
            dir = (dir[0], dir[1] * -1, 0);

            if(abs(height) < 15) {
              if(length(dir) > 0.5) {
                dirpressed = rotatevector(vectorNormalize(dir), level.player.angles);
                r = anglestoright(self.hanginteract.angles);
                dot = vectordot(r, dirpressed);

                if(abs(dot) > 0.7) {
                  self.jumpon = 1;
                  self.hanginteract notify("\x91`\xb1\xe7T\x97>");
                }
              }

              if(dir[0] > 0) {
                self.jumpon = 1;
                self.hanginteract notify("\x91`\xb1\xe7T\x97>");
              }
            } else if(height > 0) {}
          }
        }
      }
    }

    wait 0.05;
  }
}

function function_b46ec5dc6ed47a62() {
  interact = 0;
  self.hanginteract endon("\x91`\xb1\xe7T\x97>");
  usedist = 110;
  playercontent = physics_createcontents(["\x8e\xd1\xce\xd7\xdae:@\x1bR\xd5\x85\x9b\x85\xb9\x85\xaf\xbb\xb9\x023", "\xb3 c1\xa3\xab\x05/\x96c\xec\x02~5\a\xadz\xb9\xe6\xd8B", "M\xdb^{\xbe\x7fQ;\xe3\x1f\vB\xd5~\x8aE\xdc\x95\x02\xf3\xd1\xafc\xc9\xde\xdb\n"]);

  while(true) {
    shouldinteract = 0;

    if(function_4da49bf8f1d6e6fe(self.hanginteract)) {
      if(!level.player.edgehang && distance(level.player.origin, self.hanginteract.origin) < usedist) {
        flatf = anglesToForward((0, level.player.angles[1], 0));
        var_8edfb7f2461c5f19 = (self.hanginteract.origin[0], self.hanginteract.origin[1], 0);
        flatplayerorigin = (level.player.origin[0], level.player.origin[1], 0);
        vecto = var_8edfb7f2461c5f19 - flatplayerorigin;
        dirto = vectorNormalize(vecto);
        nodef = -1 * anglesToForward(self.hanginteract.angles);
        dotto = vectordot(nodef, dirto);

        if(dotto > 0.1) {
          trace_start = level.player getEye();
          trace_end = (self.hanginteract.origin[0], self.hanginteract.origin[1], trace_start[2]);
          trace = trace::sphere_trace(trace_start, trace_end, 4, level.player, playercontent, 0);

          if(trace["\xda\x16\x81\aw}^i"] == 1) {
            shouldinteract = 1;
          }
        }
      }
    }

    if(shouldinteract) {
      if(!interact) {
        self.hanginteract cursor_hint::create_cursor_hint("\xec\xbfK|\au\xcd\xc2\x19<", (-50, 0, 0), "\x99\xdd\x88\x86\xf0\xb4\xef\xd5.\x91", 360, usedist, 100, 1, undefined, 1, undefined, "\xd3\nV\n\xa1\xbb\x8d\x91\x93Oa\xd4\x1a");
        interact = 1;
      }
    } else if(interact) {
      self.hanginteract cursor_hint::remove_cursor_hint();
      interact = 0;
    }

    wait 0.05;
  }
}

function function_2d7ebbbafb7513eb() {
  self.hanginteract cursor_hint::create_cursor_hint("\xec\xbfK|\au\xcd\xc2\x19<", (0, 0, 0), "\x99\xdd\x88\x86\xf0\xb4\xef\xd5.\x91", 110, 100, 75, 1, undefined, 1, undefined, "\xd3\nV\n\xa1\xbb\x8d\x91\x93Oa\xd4\x1a");
}

function function_27f5db3548d3d663() {
  function_46ccc002721039b1();
  function_edaf96fec47baf31();
  thread function_d3e86b3ed91377c8();
  function_51b44a520fe0eb04();
  function_f41ff9dc25c0c0e8();
  function_1285dfd81b360907();

  if(true) {
    wait 0.1;

    while(level.player ismantling()) {
      wait 0.05;
    }
  }
}

function function_d128d70edd4180c4() {
  while(true) {
    if(getdvarint(@ "hash_6d379c34d4da74f2", 0)) {
      splines = self.splines;

      foreach(spline in splines) {
        if(!self.playerhanging) {
          color = (0.7, 0.7, 0.7);
        } else if(isDefined(self.currentspline) && spline[0] == self.currentspline[0] && spline[1] == self.currentspline[1]) {
          color = (1, 0, 0);
        } else {
          color = (0, 1, 0);
        }

        line(getworldoffset(spline[0]), getworldoffset(spline[1]), color, 0.75, 0, 1);
        angles = getsplineangles(spline);
        centerpoint = (getworldoffset(spline[0]) + getworldoffset(spline[1])) * 0.5;
        line(centerpoint, centerpoint + anglesToForward(angles) * 30, color, 1, 0, 1);
      }
    }

    wait 0.05;
  }
}

function function_46ccc002721039b1() {
  self.playerhanging = 1;
  self.playerviewclamptarget = -11111;
  self.var_5cc8f7d39296e80a = 0;
  self.var_1be7f82ef01dfe79 = utility::spawn_tag_origin();
  self.var_daaccf93d227543e = utility::spawn_tag_origin();

  if(self islinked()) {
    self.var_1be7f82ef01dfe79 linkTo(self);
    self.var_daaccf93d227543e linkTo(self);
  }

  self.var_a96d9fc751a48c70 = 0;

  if(isDefined(self.jumpon) && self.jumpon) {
    var_d531c0e8f6eaf311 = level.player.origin;
  } else {
    var_d531c0e8f6eaf311 = self.hanginteract.origin;
  }

  function_c8e6b468ccaf1dec(var_d531c0e8f6eaf311, undefined);
  self.hanginteract delete();
  level.player.edgehang = 1;
}

function function_1285dfd81b360907() {
  self.playerhanging = 0;
  self.var_fa9114bdbc15b581 = undefined;
  self.currentspline = undefined;
  self.var_3fd8ab3363b361e9 = undefined;
  self.crouchoff = undefined;
  self.jumpon = undefined;
  self.var_1be7f82ef01dfe79 delete();

  if(isDefined(self.var_b7cc506cb4f463bd)) {
    self.var_b7cc506cb4f463bd delete();
  }

  level.player.edgehang = 0;
}

function function_d3e86b3ed91377c8() {
  self endon("\xd1\x14q\xa7\xfb\x01\x96\xd6\x96LC\xef\xb5\xea\x185=");
  level.player endon("\x1e\xfd\xd1\xa2\a");
  self.weaponout = 0;
  movement_offset = (0, 0, 0);
  var_aee841468af86942 = (0, 0, 0);
  var_8d9bb2ef7a4884b0 = 3;
  var_660e798bda8eaf8f = 0.5;
  shimmyoffsets = spawnStruct();
  shimmyoffsets.heartbeats = [];
  shimmyoffsets.heartbeats["O*\x8a\x86"] = spawnStruct();
  shimmyoffsets.heartbeats["O*\x8a\x86"].beat = 0.2;
  shimmyoffsets.heartbeats["O*\x8a\x86"].dir = 1;
  shimmyoffsets.heartbeats[">A\x84"] = spawnStruct();
  shimmyoffsets.heartbeats[">A\x84"].beat = 0;
  shimmyoffsets.heartbeats[">A\x84"].dir = 1;
  shimmyoffsets.var_c3124c16678285aa = 0;
  leanoffset = 0;
  stance = spawnStruct();
  stance.hangstance = 0;
  stance.var_6162ec783b09b70a = 0;
  stance.var_f2526aa92a4bf73b = 0;
  stance thread function_d71cd5b57c134113(self);
  stance thread function_46e11471b411a781(self);
  var_e3479ceb5e458c62 = 0.5;
  var_3dca88289e936574 = 0;
  var_1ee808ca5dc8f593 = 0;

  while(true) {
    leantype = getdvarint(@ "hash_18b28a0b5e19545a", 3);
    var_8d337466f1763a31 = self.var_1be7f82ef01dfe79.angles;
    input = level.player getnormalizedmovement();
    input = (input[0], input[1] * -1, 0);

    if(length(input) > length(var_aee841468af86942)) {
      lerprate = 0.1;
    } else {
      lerprate = 0.4;
    }

    var_aee841468af86942 = input;
    var_c41d2d3e7e505a43 = 1;

    if(level.player adsButtonPressed()) {
      if(leantype == 3) {
        var_de0e456cc998882 = 0;
      } else {
        var_de0e456cc998882 = 0.5;
      }
    } else {
      var_de0e456cc998882 = 2;
    }

    var_238e2e01bf84a444 = rotatevector(var_aee841468af86942, level.player getplayerangles());
    var_dfd25a9f7298b25e = vectordot(vectorNormalize(var_238e2e01bf84a444), anglesToForward(self.var_1be7f82ef01dfe79.angles));
    playerf = anglesToForward(level.player getplayerangles(1));
    var_a5e7fbb18ca2c4cf = vectordot(playerf, anglesToForward((0, self.var_1be7f82ef01dfe79.angles[1], 0)));
    var_c150e182e220799 = anglesToForward(var_8d337466f1763a31) * var_e3479ceb5e458c62;
    adslean = 0;
    var_91246e6255cb37e7 = 1;

    if(leantype == 0) {
      adslean = math::normalize_value(0, 0.2, var_a5e7fbb18ca2c4cf);
      var_91246e6255cb37e7 = function_2779f7dc8f39ab09(playerf, var_8d337466f1763a31, var_c150e182e220799);
    } else if(leantype == 1) {
      adslean = math::normalize_value(-0.3, 0.3, var_a5e7fbb18ca2c4cf);
    } else if(leantype == 2) {
      if(!isDefined(stance.var_52cc55f9678730b)) {
        stance thread function_d820fd2736da7776(self);
      } else if(stance.var_52cc55f9678730b == 1 && !level.player adsButtonPressed()) {
        stance.var_52cc55f9678730b = 0;
      }

      adslean = stance.var_52cc55f9678730b;
    } else if(leantype == 3) {
      adslean = 0;
      var_91246e6255cb37e7 = 1;
    } else {
      assertmsg("<dev string:x24>" + 3 + "<dev string:x38>");
    }

    stance function_4f7df92e666d167e(self.var_a96d9fc751a48c70, function_9a778c511ea2032c(), adslean * var_91246e6255cb37e7);

    if(leantype == 3) {
      var_490d92e2e67c43cf = 0.2;
      maxtiltacc = 0.15;
      oldlean = self.var_a96d9fc751a48c70;
      self.var_a96d9fc751a48c70 = math::lerp(self.var_a96d9fc751a48c70, input[0], 0.2);
      leandelta = oldlean - self.var_a96d9fc751a48c70;

      if(abs(leandelta) > var_490d92e2e67c43cf) {
        if(self.var_a96d9fc751a48c70 > oldlean) {
          self.var_a96d9fc751a48c70 = oldlean + var_490d92e2e67c43cf;
        } else {
          self.var_a96d9fc751a48c70 = oldlean - var_490d92e2e67c43cf;
        }
      }

      oldtilt = var_1ee808ca5dc8f593;
      var_1ee808ca5dc8f593 = math::lerp(var_1ee808ca5dc8f593, -1 * input[1], 0.13);
      tiltdelta = oldtilt - var_1ee808ca5dc8f593;

      if(abs(tiltdelta) > maxtiltacc) {
        if(var_1ee808ca5dc8f593 > oldtilt) {
          var_1ee808ca5dc8f593 = oldtilt + maxtiltacc;
        } else {
          var_1ee808ca5dc8f593 = oldtilt - maxtiltacc;
        }
      }

      if(level.player adsButtonPressed()) {
        var_3dca88289e936574 = math::lerp(var_3dca88289e936574, 1, 0.2);
      } else {
        var_3dca88289e936574 = math::lerp(var_3dca88289e936574, 0, 0.2);
      }

      amount = var_3dca88289e936574;
      leanoffset = amount * self.var_a96d9fc751a48c70;
      tiltoffset = amount * var_1ee808ca5dc8f593;
    } else {
      self.var_a96d9fc751a48c70 = math::lerp(self.var_a96d9fc751a48c70, stance.hangstance, 0.2);
      leanoffset = self.var_a96d9fc751a48c70;
      tiltoffset = 0;
    }

    leanoffset = clamp(leanoffset, -1, 1);
    horleanoffset = math::normalize_value(-1, 1, leanoffset);
    horleanoffset = math::normalized_float_smooth_in(horleanoffset);
    horleanoffset = math::factor_value(-1, 1, horleanoffset);

    if(leanoffset > 0) {
      var_f984af58f6c22ed8 = 4;

      if(leantype == 2) {
        leanvertmag = 12;
      } else {
        leanvertmag = 10;
      }
    } else {
      var_f984af58f6c22ed8 = 3;
      leanvertmag = 8;
    }

    leanoffsetup = anglestoup(var_8d337466f1763a31) * leanoffset * leanvertmag;
    leanoffsetf = anglesToForward(var_8d337466f1763a31) * horleanoffset * var_f984af58f6c22ed8;
    var_7ba3ade266ca3df2 = leanoffsetup + leanoffsetf;
    tiltdot = vectordot(anglesToForward(var_8d337466f1763a31), anglesToForward(level.player.angles));
    tiltdotfactor = math::factor_value(0.6, 1, abs(tiltdot));
    tiltdotfactor = math::normalized_float_smooth_in(tiltdotfactor);
    tiltmag = 20 * tiltdotfactor;
    tiltoffsetr = anglestoright(level.player.angles) * tiltoffset * tiltmag;
    var_ba7784f68b5cfc3b = tiltoffsetr;
    function_c8e6b468ccaf1dec(getworldoffset(self.var_3fd8ab3363b361e9) + var_238e2e01bf84a444 * var_de0e456cc998882 * var_c41d2d3e7e505a43, var_7ba3ade266ca3df2 + var_ba7784f68b5cfc3b);

    if(self.playerviewclamptarget != self.currentspline[2]) {
      self.playerviewclamptarget = self.currentspline[2];
    }

    shimmyoffsets function_fe8f1630abae00f1(function_9a778c511ea2032c(), self.var_a96d9fc751a48c70, tiltoffset);
    function_6ad33cce1ab52504(input, stance);
    wait 0.05;
  }
}

function function_2779f7dc8f39ab09(playerf, var_8d337466f1763a31, var_c150e182e220799) {
  testlength = 100;
  var_970d6810182bb43a = 0;
  fractionincrement = 0.1;
  testheights = [];

  while(var_970d6810182bb43a < 1) {
    testheights[testheights.size] = var_970d6810182bb43a;
    var_970d6810182bb43a += fractionincrement;
  }

  i = 0;
  fracpassed = undefined;
  offsetup = anglestoup(var_8d337466f1763a31) * 50;
  contents = trace::create_contents(1, 1, 1, 1, 1, 1, 1, 0, 1);

  while(true) {
    ang = level.player getplayerangles();
    testheight = testheights[i];
    testoffsetup = anglestoup(ang) * testheights[i] * 10;
    playerf = anglesToForward(ang);
    start = self.var_daaccf93d227543e.origin + offsetup + var_c150e182e220799 + testoffsetup;
    end = self.var_daaccf93d227543e.origin + playerf * testlength + offsetup + var_c150e182e220799 + testoffsetup;
    trace = trace::capsule_trace(start, end, 6, 12, ang, level.player, contents, 0);

    if(trace["\xda\x16\x81\aw}^i"] == 1) {
      fracpassed = testheights[i];
      break;
    }

    i++;

    if(i > testheights.size - 1) {
      break;
    }
  }

  if(!isDefined(fracpassed)) {
    fracpassed = 1;
  }

  return fracpassed;
}

function function_6ad33cce1ab52504(input, stance) {
  if(self.var_5cc8f7d39296e80a > 0 && length(input) > 0 && !level.player adsButtonPressed() && self.weaponout) {
    self.weaponout = 0;
    level.player val::set("\x03\x95b\xc3\xf1L#\v]", "\xe5\x06\xb0\bE\x16", 0);
    return;
  }

  if((length(input) == 0 && self.var_5cc8f7d39296e80a < 0.2 || level.player adsButtonPressed()) && !level.player isswitchingweapon() && !self.weaponout) {
    self.weaponout = 1;
    level.player val::reset_all("\x03\x95b\xc3\xf1L#\v]");
  }
}

function function_d71cd5b57c134113(edgestruct) {
  edgestruct endon("\xd1\x14q\xa7\xfb\x01\x96\xd6\x96LC\xef\xb5\xea\x185=");
  level.player notifyonplayercommand("\x8cj(\xb93Dt\x13\x9eb\x81-$\x91\xdeK\xa1", "\x1d\x93\x85]\b\x86\xbb5");

  while(true) {
    level.player waittill("\x8cj(\xb93Dt\x13\x9eb\x81-$\x91\xdeK\xa1");
    self.var_6162ec783b09b70a = 1;
  }
}

function function_46e11471b411a781(edgestruct) {
  edgestruct endon("\xd1\x14q\xa7\xfb\x01\x96\xd6\x96LC\xef\xb5\xea\x185=");
  level.player endon("\x1e\xfd\xd1\xa2\a");
  level.player notifyonplayercommand("^\xa3\xfb@\xadx\xf2*z6E\x04<\xa8\x12\xfcfY<\xf8", "\xc0\xc0Vh\xf6\xed_");
  level.player notifyonplayercommand("m5\xe7d\xab\x83D\xfb\xefr\x83\x15\x1e\xc8U3\xb3\xe6\x80", "\xe88-\x97\xb82a");
  self.crouchbuttonpressed = 0;

  while(true) {
    msg = level.player utility::waittill_any_return("m5\xe7d\xab\x83D\xfb\xefr\x83\x15\x1e\xc8U3\xb3\xe6\x80", "^\xa3\xfb@\xadx\xf2*z6E\x04<\xa8\x12\xfcfY<\xf8");

    if(msg == "m5\xe7d\xab\x83D\xfb\xefr\x83\x15\x1e\xc8U3\xb3\xe6\x80") {
      self.crouchbuttonpressed = 1;
      continue;
    }

    self.crouchbuttonpressed = 0;
  }
}

function function_d820fd2736da7776(edgestruct) {
  edgestruct endon("\xd1\x14q\xa7\xfb\x01\x96\xd6\x96LC\xef\xb5\xea\x185=");
  level.player endon("\x1e\xfd\xd1\xa2\a");
  level.player notifyonplayercommand("\xb6o\xab\xe6\xa3!\xd5G\xe8o\xb9Ar\x95\xe6s\xb2d", "\x18\xf77d\x8e\\\x1fjq\xbd(");
  self.var_52cc55f9678730b = 0;

  while(true) {
    level.player waittill("\xb6o\xab\xe6\xa3!\xd5G\xe8o\xb9Ar\x95\xe6s\xb2d");

    if(level.player adsButtonPressed()) {
      if(self.var_52cc55f9678730b == 1) {
        self.var_52cc55f9678730b = 0;
      } else {
        self.var_52cc55f9678730b = 1;
      }

      continue;
    }

    self.var_52cc55f9678730b = 0;
  }
}

function function_4f7df92e666d167e(var_cc2dd9272ea689fb, var_61d1aa882e41182d, adslean) {
  if(level.player adsButtonPressed()) {
    self.hangstance = adslean;
    return;
  }

  self.hangstance = 0;
}

function function_9a778c511ea2032c() {
  return math::normalize_value(0, 2, self.var_5cc8f7d39296e80a);
}

function function_fe8f1630abae00f1(shimmymag, leanmag, tiltmag) {
  self.var_c3124c16678285aa = math::lerp(self.var_c3124c16678285aa, shimmymag, 0.35);
  shimmyanimrate = math::factor_value(0.05, 0.19, self.var_c3124c16678285aa);

  foreach(heartbeat in self.heartbeats) {
    heartbeat.beat += heartbeat.dir * shimmyanimrate;

    if(abs(heartbeat.beat) > 1) {
      heartbeat.dir *= -1;
      frac = abs(heartbeat.beat) - 1;
      heartbeat.beat = clamp(heartbeat.beat, -1, 1);
      heartbeat.beat += heartbeat.dir * frac;
    }
  }

  camerax = 0;
  cameray = 0;
  cameraz = math::function_a8193f1c6a4715dc(abs(self.heartbeats["O*\x8a\x86"].beat)) * 3;
  var_d50ef82b67e1d039 = (camerax, cameray, cameraz) * self.var_c3124c16678285aa * 0.7;
  gunx = 0;
  guny = self.heartbeats[">A\x84"].beat * 0.5;
  gunz = math::function_a8193f1c6a4715dc(abs(self.heartbeats[">A\x84"].beat)) * 0.8;
  var_1d7ada984ba274be = (gunx, guny, gunz) * self.var_c3124c16678285aa * 0.7;

  if(level.player adsButtonPressed()) {
    ads = 1;
  } else {
    ads = 0;
  }

  var_ee844c6c2895b069 = (-1, 1, -2) * self.var_c3124c16678285aa * (1 - ads);
  var_5a137eb792a6af83 = (0, 0, 0) * self.var_c3124c16678285aa * (1 - ads);

  if(leanmag > 0) {
    var_9f87bc9b20f43ad0 = (4, 0, 0) * leanmag;
    var_a92da13e6e0aecd0 = (0, 0, 6) * leanmag;
  } else {
    var_9f87bc9b20f43ad0 = (2, 0, 0) * leanmag;
    var_a92da13e6e0aecd0 = (0, 0, 6) * leanmag;
  }

  var_b5065c761ffb965 = (0, 0, 0) * tiltmag;
  var_64ae1ef3c99cc94f = (0, 0, 14) * tiltmag;
  var_1fb7475b3944149c = (0, 0, 0) * tiltmag;
  var_9dfbdba0caddbfac = (0, 0, 6) * tiltmag;
  var_b10016de83afced = var_ee844c6c2895b069 + var_1d7ada984ba274be + var_9f87bc9b20f43ad0 + var_b5065c761ffb965;
  var_f97afce634f52217 = var_5a137eb792a6af83 + var_a92da13e6e0aecd0 + var_64ae1ef3c99cc94f;
  var_5b819d43a581c94 = var_d50ef82b67e1d039 + var_1fb7475b3944149c;
  var_f262a9b6a65d2de4 = var_9dfbdba0caddbfac;
  level.player.viewblender["\x82C\xf9\x1ca\x98\x94"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] = var_b10016de83afced;
  level.player.viewblender["\xee\xca\x85\x83\x82\xdcg"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] = var_f97afce634f52217;
  level.player.viewblender["\xa1\x81\xb9\xd7{\xa1\x88"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] = var_5b819d43a581c94;
  level.player.viewblender["U\x82\xf8\x9798;"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] = var_f262a9b6a65d2de4;
}

function function_51b44a520fe0eb04() {
  while(level.player useButtonPressed()) {
    wait 0.05;
  }

  thread function_f6292783a19d8442();

  if(true) {
    thread function_f357645f8aa6642();
  }

  if(true) {
    thread function_9890964942655541();
  }

  self waittill("\xd1\x14q\xa7\xfb\x01\x96\xd6\x96LC\xef\xb5\xea\x185=");
}

function function_f6292783a19d8442() {
  self endon("\xd1\x14q\xa7\xfb\x01\x96\xd6\x96LC\xef\xb5\xea\x185=");
  level.player waittill("\x1e\xfd\xd1\xa2\a");
  self notify("\xd1\x14q\xa7\xfb\x01\x96\xd6\x96LC\xef\xb5\xea\x185=");
}

function function_f357645f8aa6642() {
  self endon("\xd1\x14q\xa7\xfb\x01\x96\xd6\x96LC\xef\xb5\xea\x185=");

  while(true) {
    level.player waittill("\x8cj(\xb93Dt\x13\x9eb\x81-$\x91\xdeK\xa1");
    self notify("\xd1\x14q\xa7\xfb\x01\x96\xd6\x96LC\xef\xb5\xea\x185=");
  }
}

function function_9890964942655541() {
  self endon("\xd1\x14q\xa7\xfb\x01\x96\xd6\x96LC\xef\xb5\xea\x185=");

  while(true) {
    level.player waittill("m5\xe7d\xab\x83D\xfb\xefr\x83\x15\x1e\xc8U3\xb3\xe6\x80");
    self.crouchoff = 1;
    self notify("\xd1\x14q\xa7\xfb\x01\x96\xd6\x96LC\xef\xb5\xea\x185=");
    wait 0.05;
  }
}

function function_d35673dde1b9d9a(edgestruct) {
  edgestruct waittill("\xd1\x14q\xa7\xfb\x01\x96\xd6\x96LC\xef\xb5\xea\x185=");

  if(self.hint) {
    cursor_hint::remove_cursor_hint();
    self.hint = 0;
  }
}

function function_b7467d7113558270() {
  self endon("\xc24\xe9\x9d)\x8e\xcd\x14+,NN\x94\xf8z!\x19\xdb");
  self.hint = 0;

  while(true) {
    if(level.player useButtonPressed() && !self.hint) {
      cursor_hint::create_cursor_hint(undefined, (0, 0, 0), "\\.\b\x98\xe4\xf4m\x11", 90, 500, 500, 1, 0, 1);
      self.hint = 1;
    } else if(!level.player useButtonPressed() && self.hint) {
      cursor_hint::remove_cursor_hint();
      self.hint = 0;
    }

    wait 0.05;
  }
}

function function_edaf96fec47baf31() {
  level.player notify("n8\x1eq\x86\xd2\x97P");

  if(isDefined(self.jumpon) && self.jumpon) {
    blendtime = 0.15;
  } else {
    blendtime = 0.65;
  }

  earthquake(0.2, 0.4, level.player.origin, 1000);
  level.player.onehandpistol = function_91a256265c9ee133();
  level.player giveweapon(level.player.onehandpistol);
  level.player switchtoweaponimmediate(level.player.onehandpistol);

  if(level.player val::get("\xe5\x06\xb0\bE\x16")) {
    level.player val::set("\x03\x95b\xc3\xf1L#\v]", "\xe5\x06\xb0\bE\x16", 0);
    level.player.ogweapon = level.player.currentweapon;
  }

  if(level.player val::get("\x9a\xe3\xe4\xff\x81%")) {
    level.player val::set("\x03\x95b\xc3\xf1L#\v]", "\x9a\xe3\xe4\xff\x81%", 0);
  }

  if(level.player val::get("1x\xc5\xb4\xabx")) {
    level.player val::set("\x03\x95b\xc3\xf1L#\v]", "1x\xc5\xb4\xabx", 0);
    level.player val::set("\x03\x95b\xc3\xf1L#\v]", "GX\xa9]\x82", 0);
  }

  level.player val::set("\x03\x95b\xc3\xf1L#\v]", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", 0);
  level.player val::set("\x03\x95b\xc3\xf1L#\v]", "\\y\xb8\x8e\xd8K\xfd\v\v\xd8", 0);
  level.player playerlinktoblend(self.var_1be7f82ef01dfe79, "\xec\xbfK|\au\xcd\xc2\x19<", blendtime, 0.5 * blendtime, 0.5 * blendtime);
  wait blendtime;
  setviewclamps(0);
  earthquake(0.18, 0.35, level.player.origin, 1000);
}

function function_91a256265c9ee133() {
  onehandweapon = utility_sp::make_weapon("|\x13\x96\xf7\xd9\x0e\xb9X\xbaq\r");

  foreach(weapon in level.player.primaryweapons) {
    if(function_9706ece7ce6e7a43(weapon)) {
      basename = weapon.basename;
      attachments = weapon.attachments;
      onehandattachment = function_f7e5116d375d53f8(basename);
      attachments = utility::array_add(weapon.attachments, onehandattachment);
      onehandweapon = utility_sp::make_weapon(basename, attachments);
    }
  }

  return onehandweapon;
}

function function_f7e5116d375d53f8(weaponname) {
  rootnames = ["\x8aE\xf1\xfd\xf5d", "\x03I\xb177", "\x16W%.c", "\xc3\xbc.\x92g\x1dqb", "\x1dh\x18%\xaf", "k`\x89>\xae\x1bO"];

  foreach(name in rootnames) {
    if(issubstr(weaponname, name)) {
      return ("`\xd7\x82\xcd)O\xda\xd3" + name);
    }
  }

  assertmsg("<dev string:x48>" + weaponname + "<dev string:x75>");
}

function function_9706ece7ce6e7a43(weapon) {
  if(utility::string_starts_with(weapon.basename, "d\xbc\xdd,<-G")) {
    return 1;
  }

  return 0;
}

function function_d5beeec4ab6464b9() {
  level.player forceplaygestureviewmodel("\x83\x98w\f2\xd0\x18^\x04");
  wait 0.2;
  level.player forceplaygestureviewmodel("r{Y_d\xea\xfb\xact\xa6\xc6\xeb", undefined, 0.6, undefined, 1, 1);
}

function function_e4375c1e07bd9e1d() {
  level.player forceplaygestureviewmodel("\xec\x957\xf5wZ\xdcFow\xf5Lr\xac\xc2k\xfa\x99\v\x9c", undefined, 0.2, undefined, 1, 1);
  wait 0.3;
  level.player stopgestureviewmodel("\xec\x957\xf5wZ\xdcFow\xf5Lr\xac\xc2k\xfa\x99\v\x9c", 0.5);
}

function function_f41ff9dc25c0c0e8() {
  if(level.player val::get("\xe5\x06\xb0\bE\x16")) {
    level.player val::set("\x03\x95b\xc3\xf1L#\v]", "\xe5\x06\xb0\bE\x16", 0);
  }

  input = level.player getnormalizedmovement();
  input = (input[0], input[1] * -1, 0);

  if(!isalive(level.player)) {
    input = (0, 0, 0);
  }

  if(length(input) > 0.3) {
    input = vectorNormalize(input);
    input = rotatevector(input, level.player.angles);
    towardswall = anglesToForward(self.var_1be7f82ef01dfe79.angles);
    dot = vectordot(input, towardswall);

    if(dot > 0.3) {
      if(!level.player val::get("\x9a\xe3\xe4\xff\x81%")) {
        level.player val::set("\x03\x95b\xc3\xf1L#\v]", "\x9a\xe3\xe4\xff\x81%", 1);
      }
    }
  }

  level.player unlink();
  level.player val::set("\x03\x95b\xc3\xf1L#\v]", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", 1);
  level.player val::set("\x03\x95b\xc3\xf1L#\v]", "\\y\xb8\x8e\xd8K\xfd\v\v\xd8", 1);
  level.player takeweapon(level.player.onehandpistol);
  var_6ec40629c0ec134b = level.player getnormalizedmovement();
  var_6ec40629c0ec134b = (var_6ec40629c0ec134b[0], -1 * var_6ec40629c0ec134b[1], 0);
  inputmag = clamp(length(var_6ec40629c0ec134b), 0, 1);
  var_6ec40629c0ec134b = vectorNormalize(var_6ec40629c0ec134b);
  var_6ec40629c0ec134b = rotatevector(var_6ec40629c0ec134b, level.player.angles);
  upmag = math::factor_value(13, 30.5, inputmag);
  awaymag = math::factor_value(7, 0, inputmag * inputmag);
  jumpmag = math::factor_value(0, 13.5, inputmag);
  upvec = (0, 0, upmag);
  vecaway = anglesToForward(getsplineangles(self.currentspline)) * -1;
  awayvec = vecaway * awaymag;
  jumpvec = var_6ec40629c0ec134b * jumpmag;
  jumpvec += upvec;
  jumpvec += awayvec;

  if(istrue(self.crouchoff)) {
    jumpvec *= 0.2;
  }

  thread fakejump(jumpvec);
  thread function_20b9afe146d38d02();
  thread function_1e910f95c18f6f8c();
  thread function_6d6c087e4a348bbb();
  thread function_e6264710b0a2ac85();
}

function fakejump(jumpvec) {
  level.player endon("n8\x1eq\x86\xd2\x97P");
  lerp_decay = 0.8;

  while(length(jumpvec) > 0.02) {
    level.player pushplayervector(jumpvec, 1);
    jumpvec *= lerp_decay;
    level.player.viewblender["\x82C\xf9\x1ca\x98\x94"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] = level.player.viewblender["\x82C\xf9\x1ca\x98\x94"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] * lerp_decay;
    level.player.viewblender["\xee\xca\x85\x83\x82\xdcg"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] = level.player.viewblender["\xee\xca\x85\x83\x82\xdcg"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] * lerp_decay;
    level.player.viewblender["\xa1\x81\xb9\xd7{\xa1\x88"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] = level.player.viewblender["\xa1\x81\xb9\xd7{\xa1\x88"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] * lerp_decay;
    level.player.viewblender["U\x82\xf8\x9798;"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] = level.player.viewblender["U\x82\xf8\x9798;"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] * lerp_decay;
    wait 0.05;
  }

  wait 0.3;
  level.player pushplayervector((0, 0, 0), 1);
  level.player.viewblender["\x82C\xf9\x1ca\x98\x94"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] = (0, 0, 0);
  level.player.viewblender["\xee\xca\x85\x83\x82\xdcg"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] = (0, 0, 0);
  level.player.viewblender["\xa1\x81\xb9\xd7{\xa1\x88"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] = (0, 0, 0);
  level.player.viewblender["U\x82\xf8\x9798;"].channels["\xb2\x19gY!\x85\xb9\xd9S\xa1-\xb6\xb5\xe5"] = (0, 0, 0);
}

function function_1e910f95c18f6f8c() {
  level.player endon("n8\x1eq\x86\xd2\x97P");

  while(!level.player isonground()) {
    wait 0.05;
  }

  if(!level.player val::get("\xe5\x06\xb0\bE\x16")) {
    level.player val::set("\x03\x95b\xc3\xf1L#\v]", "\xe5\x06\xb0\bE\x16", 1);
  }

  if(isDefined(level.player.ogweapon)) {
    level.player giveweapon(level.player.ogweapon, 0, 0, 0, 1);
    level.player switchtoweapon(level.player.ogweapon);
    level.player.ogweapon = undefined;
  }
}

function function_20b9afe146d38d02() {
  level.player endon("n8\x1eq\x86\xd2\x97P");

  while(!level.player isonground()) {
    wait 0.05;
  }

  if(!level.player val::get("1x\xc5\xb4\xabx")) {
    wait 0.1;
    level.player val::set("\x03\x95b\xc3\xf1L#\v]", "1x\xc5\xb4\xabx", 1);
    level.player val::set("\x03\x95b\xc3\xf1L#\v]", "GX\xa9]\x82", 1);
  }
}

function function_6d6c087e4a348bbb() {
  level.player endon("n8\x1eq\x86\xd2\x97P");

  while(!level.player isonground()) {
    wait 0.05;
  }

  if(!level.player val::get("\x9a\xe3\xe4\xff\x81%")) {
    level.player val::set("\x03\x95b\xc3\xf1L#\v]", "\x9a\xe3\xe4\xff\x81%", 1);
  }
}

function function_e6264710b0a2ac85() {
  level.player endon("n8\x1eq\x86\xd2\x97P");

  while(!level.player isonground()) {
    wait 0.05;
  }

  wait 0.05;
  level.player val::reset_all("\x03\x95b\xc3\xf1L#\v]");
}

function function_c8e6b468ccaf1dec(var_916af82707ec345f, leanoffset) {
  closestspot = undefined;
  closestdist = 999999999;
  closestspline = undefined;

  if(!isDefined(self.currentspline) || !level.player adsButtonPressed()) {
    splinestocheck = self.splines;
  } else {
    splinestocheck = [self.currentspline];
  }

  foreach(spline in splinestocheck) {
    spot = pointonsegmentnearesttopoint(getworldoffset(spline[0]), getworldoffset(spline[1]), var_916af82707ec345f);
    dist = distance(spot, var_916af82707ec345f);

    if(dist < closestdist) {
      closestspot = spot;
      closestdist = dist;
      closestspline = spline;
    }
  }

  self.currentspline = closestspline;

  if(!isDefined(self.var_fa9114bdbc15b581)) {
    self.var_fa9114bdbc15b581 = self.currentspline[2];
    self.var_17931c607863ef11 = 0;
  } else {
    yawacc = 1.8;
    splineyaw = self.currentspline[2];

    if(splineyaw > self.var_fa9114bdbc15b581 && abs(splineyaw - self.var_fa9114bdbc15b581) > 180) {
      splineyaw -= 360;
    } else if(splineyaw < self.var_fa9114bdbc15b581 && abs(splineyaw - self.var_fa9114bdbc15b581) > 180) {
      splineyaw += 360;
    }

    targetyaw = math::lerp(self.var_fa9114bdbc15b581, splineyaw, 0.2);
    targetyawdelta = targetyaw - self.var_fa9114bdbc15b581;

    if(targetyawdelta > 0 && self.var_17931c607863ef11 > 0 && targetyawdelta < self.var_17931c607863ef11) {
      self.var_17931c607863ef11 = targetyawdelta;
    } else if(targetyawdelta < 0 && self.var_17931c607863ef11 < 0 && targetyawdelta > self.var_17931c607863ef11) {
      self.var_17931c607863ef11 = targetyawdelta;
    } else if(targetyawdelta > 0) {
      self.var_17931c607863ef11 += yawacc;
    } else if(targetyawdelta < 0) {
      self.var_17931c607863ef11 -= yawacc;
    } else {
      self.var_17931c607863ef11 = 0;
    }

    self.var_fa9114bdbc15b581 += self.var_17931c607863ef11;

    if(self.var_fa9114bdbc15b581 > 360) {
      self.var_fa9114bdbc15b581 -= 360;
    } else if(self.var_fa9114bdbc15b581 < 0) {
      self.var_fa9114bdbc15b581 += 360;
    }
  }

  if(self islinked()) {
    self.var_1be7f82ef01dfe79 unlink();
    self.var_daaccf93d227543e unlink();
  }

  var_de0b56e84fbca4c5 = getlocaloffset(closestspot);

  if(!isDefined(self.var_3fd8ab3363b361e9)) {
    self.var_5cc8f7d39296e80a = 0;
  } else {
    self.var_5cc8f7d39296e80a = math::lerp(self.var_5cc8f7d39296e80a, distance(self.var_3fd8ab3363b361e9, var_de0b56e84fbca4c5), 0.5);
  }

  self.var_3fd8ab3363b361e9 = var_de0b56e84fbca4c5;
  self.var_1be7f82ef01dfe79.origin = closestspot;
  self.var_daaccf93d227543e.origin = closestspot;
  self.var_1be7f82ef01dfe79.angles = function_eeeeef8fff63fd56(self.var_fa9114bdbc15b581);

  if(!isDefined(leanoffset)) {
    leanoffset = (0, 0, 0);
  }

  globaloffset = -64 * anglestoup(self.var_1be7f82ef01dfe79.angles) + -14 * anglesToForward(self.var_1be7f82ef01dfe79.angles);
  self.var_1be7f82ef01dfe79.origin += leanoffset + globaloffset;

  if(self islinked()) {
    self.var_1be7f82ef01dfe79 linkTo(self);
    self.var_daaccf93d227543e linkTo(self);
  }
}

function setviewclamps(yawoffset) {
  rightyaw = 170 - yawoffset;
  leftyaw = 170 + yawoffset;
  level.player playerlinktodelta(self.var_1be7f82ef01dfe79, "\xec\xbfK|\au\xcd\xc2\x19<", 0.8, rightyaw, leftyaw, 65, 65, 1);
}

function getsplineangles(spline) {
  ang = function_eeeeef8fff63fd56(spline[2]);
  return ang;
}

function function_eeeeef8fff63fd56(yawoffset) {
  og = yawoffset;

  if(yawoffset > 90 && yawoffset < 270) {
    flip = 1;
  } else {
    flip = 0;
  }

  if(yawoffset < 90) {
    yawoffset = yawoffset;
  } else if(yawoffset < 180) {
    yawoffset = abs(yawoffset - 180);
  } else if(yawoffset < 270) {
    yawoffset = (yawoffset - 180) * -1;
  } else {
    yawoffset = abs(yawoffset - 360);
  }

  ang = self.angles;
  f = anglesToForward(ang);
  r = anglestoright(ang);
  u = anglestoup(ang);
  yawfactor = math::normalize_value(0, 90, abs(yawoffset));

  if(yawoffset < 0) {
    maxr = -1 * f;
    maxf = r;
  } else {
    maxr = f;
    maxf = -1 * r;
  }

  if(flip) {
    f *= -1;
    r *= -1;
  }

  newf = vectorNormalize(math::factor_value(f, maxf, yawfactor));
  newr = vectorNormalize(math::factor_value(r, maxr, yawfactor));
  ang = axistoangles(newf, newr, u);
  return ang;
}

function function_94318ec231f11a5d(node1, node2, yawoffset) {
  f = anglesToForward(self.angles);
  r = anglestoright(self.angles);
  u = anglestoup(self.angles);
  splines = [node1, node2];

  if(self islinked()) {
    node1 unlink();
  }

  node1.angles = axistoangles(f, r, u);

  if(self islinked()) {
    node1 linkTo(self);
  }

  self.splines = utility::array_add(self.splines, [getlocaloffset(node1.origin), getlocaloffset(node2.origin), yawoffset]);
}

function getlocaloffset(spot) {
  org = self.origin;
  ang = self.angles;
  spot -= org;
  spot = rotatevectorinverted(spot, ang);
  return spot;
}

function getworldoffset(spot) {
  org = self.origin;
  ang = self.angles;
  spot = rotatevector(spot, ang);
  spot += org;
  return spot;
}

function function_ec4257a859a2c9ef() {
  self.hanginteract endon("\x91`\xb1\xe7T\x97>");
  wait 0.1;

  while(true) {
    time = gettime();

    if(isDefined(level.player.var_12af9a4d1fbb1882) && level.player.var_12af9a4d1fbb1882.timestamp != time) {
      level.player.var_12af9a4d1fbb1882 = undefined;
    }

    closestspot = undefined;
    closestdist = 999999999;
    closestspline = undefined;
    var_916af82707ec345f = level.player.origin;

    foreach(spline in self.splines) {
      spot = pointonsegmentnearesttopoint(getworldoffset(spline[0]), getworldoffset(spline[1]), var_916af82707ec345f);
      dist = distance(spot, var_916af82707ec345f);

      if(dist < closestdist) {
        closestspot = spot;
        closestdist = dist;
        closestspline = spline;
      }
    }

    interactspot = closestspot;
    self.hanginteract.distfromplayer = closestdist;
    self.hanginteract.timestamp = time;

    if(!isDefined(level.player.var_12af9a4d1fbb1882) || self.hanginteract.distfromplayer < level.player.var_12af9a4d1fbb1882.distfromplayer) {
      level.player.var_12af9a4d1fbb1882 = self.hanginteract;
    }

    self.hanginteract.origin = interactspot;
    self.hanginteract.angles = getsplineangles(closestspline);
    wait 0.05;
  }
}