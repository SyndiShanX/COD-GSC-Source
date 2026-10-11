/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_56dcb79837d451ee.gsc
*************************************************/

#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace namespace_22e6e91865862939;

function function_684874396c3776b3() {
  level.var_7eb4320d65486c37 = getStructArray("<dev string:x1c>", "<dev string:x34>");

  if(!level.var_7eb4320d65486c37.size) {
    level.var_7eb4320d65486c37 = undefined;
    return;
  }

  level.var_9182aa2a8fc581de = 0;
  level.var_7991fdfc863a12a9 = 0;
  level.var_9b90cd97e5785760 = 1;
  level.var_cf0923e214d8fb83 = 1;

  foreach(var_2cdb8d023f645452 in level.var_7eb4320d65486c37) {
    assertex(isDefined(var_2cdb8d023f645452.script_string), "<dev string:x49>");
    var_2cdb8d023f645452.s_bundle = getscriptbundle("<dev string:x95>" + var_2cdb8d023f645452.script_string);
    var_2cdb8d023f645452.var_a4a4166618e64bb3 = 0;

    foreach(s_asset in var_2cdb8d023f645452.s_bundle.assetlist) {
      if(s_asset.assettype == "<dev string:xaa>") {
        if(isDefined(s_asset.model)) {
          precachemodel(s_asset.model);
        }

        if(isarray(s_asset.var_44d1e76fc7ab685a) && s_asset.var_44d1e76fc7ab685a.size) {
          foreach(var_e1b31cbc0d6ea8f7 in s_asset.var_44d1e76fc7ab685a) {
            if(isDefined(var_e1b31cbc0d6ea8f7.modelvariant)) {
              precachemodel(var_e1b31cbc0d6ea8f7.modelvariant);
            }
          }
        }
      }
    }

    thread spawn_asset(var_2cdb8d023f645452);
  }

  a_s_temp = [];

  foreach(n_index, s_instance in level.var_7eb4320d65486c37) {
    s_instance.targetname = default_to(s_instance.targetname, "<dev string:xb4>" + n_index);
    a_s_temp[s_instance.targetname] = s_instance;
  }

  level.var_7eb4320d65486c37 = a_s_temp;
  level thread function_e0fb1885d6dc1fac();
  level thread function_c6fbee886f1cda85();
  level thread function_25f3557f59f5587c();
}

function function_e0fb1885d6dc1fac() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  wait 0.25;
  setdvarifuninitialized(@ "hash_40ad028737193fbc", 1);
  setdvarifuninitialized(@ "hash_af2088374ac3b8ad", 1);
  adddebugcommand("<dev string:xcc>");
  adddebugcommand("<dev string:x126>");
  waitframe();

  foreach(var_41dff443fe9f2590, s_instance in level.var_7eb4320d65486c37) {
    adddebugcommand("<dev string:x188>" + var_41dff443fe9f2590 + "<dev string:x1c1>" + var_41dff443fe9f2590 + "<dev string:x1ee>");
    adddebugcommand("<dev string:x1f4>" + var_41dff443fe9f2590 + "<dev string:x230>" + var_41dff443fe9f2590 + "<dev string:x1ee>");
    adddebugcommand("<dev string:x260>" + var_41dff443fe9f2590 + "<dev string:x2a2>" + var_41dff443fe9f2590 + "<dev string:x1ee>");
    waitframe();
  }

  adddebugcommand("<dev string:x2cf>");
  level thread function_d729b0a4ac51b58f();
}

function private function_d729b0a4ac51b58f() {
  level notify("<dev string:x32f>");
  level endon("<dev string:x32f>");
  level endon("<dev string:x350>");

  while(true) {
    waitframe();
    level.var_9182aa2a8fc581de = getdvarint(@ "hash_af2088374ac3b8ad", 0);
    level.var_7991fdfc863a12a9 = getdvarint(@ "hash_40ad028737193fbc", 0);
    var_bc1eb3f5c730837 = getdvarint(@ "hash_6a97927c7fa376a", 0);
    var_29dba36358bc25ca = getDvar(@ "hash_aa480c2109cbaaec");
    var_33ad70120e3843ef = getDvar(@ "hash_419027c07c5cac85");
    var_28239cf98ea3915c = getDvar(@ "hash_28c1468f736008a6");

    if(var_bc1eb3f5c730837 != 0) {
      function_78a252338b643875();
    }

    if(var_29dba36358bc25ca != "<dev string:x35e>") {
      thread function_eae657bc268c97fa(var_29dba36358bc25ca);
    }

    if(var_33ad70120e3843ef != "<dev string:x35e>") {
      function_c7bf4598dbc46d6f(var_33ad70120e3843ef);
    }

    if(var_28239cf98ea3915c != "<dev string:x35e>") {
      function_a7721dc34b7fcddc(var_28239cf98ea3915c);
    }

    setDvar(@ "hash_aa480c2109cbaaec", "<dev string:x35e>");
    setDvar(@ "hash_419027c07c5cac85", "<dev string:x35e>");
    setDvar(@ "hash_28c1468f736008a6", "<dev string:x35e>");
    setDvar(@ "hash_6a97927c7fa376a", 0);
  }
}

function function_78a252338b643875() {
  foreach(s_instance in level.var_7eb4320d65486c37) {
    if(isDefined(s_instance.var_47d007ab4f36e40d)) {
      if(isDefined(s_instance.var_47d007ab4f36e40d.var_f6a022ce17906c5b)) {
        foreach(var_edde07b0cad7554a in s_instance.var_47d007ab4f36e40d.var_f6a022ce17906c5b) {
          if(isDefined(var_edde07b0cad7554a)) {
            var_edde07b0cad7554a delete();
          }
        }
      }

      s_instance.var_47d007ab4f36e40d delete();
    }

    if(isDefined(s_instance.e_rotator)) {
      s_instance.e_rotator delete();
    }

    if(isDefined(s_instance.var_156bb435d28f9102)) {
      s_instance.var_156bb435d28f9102 delete();
    }
  }
}

function function_eae657bc268c97fa(str_instance) {
  if(str_instance == "<dev string:x35e>") {
    return;
  }

  s_instance = level.var_7eb4320d65486c37[str_instance];
  function_bf93bdd4ddf2fa08(s_instance);
  var_bcda6e15f20d9722 = 200;
  host = level.player;
  v_forward = anglesToForward(host getplayerangles());
  v_forward *= var_bcda6e15f20d9722;
  v_player_origin = host getorigin();
  v_origin = v_player_origin + v_forward;

  if(isDefined(s_instance.var_156bb435d28f9102)) {
    s_instance.var_156bb435d28f9102 delete();
  }

  s_instance.var_156bb435d28f9102 = spawn("<dev string:x362>", v_origin);
  s_instance.var_156bb435d28f9102.var_81c2718f2fde774d = 1;
  s_instance.e_rotator unlink();
  s_instance.e_rotator.origin = s_instance.var_156bb435d28f9102.origin;
  s_instance.e_rotator linkTo(s_instance.var_156bb435d28f9102);
  s_instance.var_156bb435d28f9102 linkTo(host);
  s_instance.var_156bb435d28f9102 thread function_86284089e12d25fd();
}

function function_86284089e12d25fd() {
  host = level.player;
  host endon("<dev string:x372>");
  self endon("<dev string:x372>");

  while(true) {
    var_82d6d873c22b360c = host getnormalizedmovement();
    var_437795e87e098a63 = (0, 0, 0);

    if(level.var_9182aa2a8fc581de && host adsButtonPressed() && var_82d6d873c22b360c != (0, 0, 0)) {
      self unlink();
      self.origin = (self.origin[0], self.origin[1], self.origin[2] + var_82d6d873c22b360c[0] * 3);
      self linkTo(host);
    }

    waitframe();
  }
}

function function_c7bf4598dbc46d6f(str_instance) {
  if(str_instance == "<dev string:x35e>") {
    return;
  }

  s_instance = level.var_7eb4320d65486c37[str_instance];
  function_bf93bdd4ddf2fa08(s_instance);
  host = level.player;
  v_forward = anglesToForward(host getplayerangles());
  v_forward *= 4000;
  v_eye = host getEye();
  v_origin = physicstrace(v_eye, v_eye + v_forward);

  if(isDefined(s_instance.var_156bb435d28f9102)) {
    s_instance.var_156bb435d28f9102 delete();
  }

  s_instance.var_156bb435d28f9102 = spawn("<dev string:x362>", v_origin);
  s_instance.e_rotator.origin = v_origin;
  s_instance.e_rotator linkTo(s_instance.var_156bb435d28f9102);
}

function function_a7721dc34b7fcddc(str_instance) {
  if(str_instance == "<dev string:x35e>") {
    return;
  }

  s_instance = level.var_7eb4320d65486c37[str_instance];
  function_bf93bdd4ddf2fa08(s_instance);

  if(isDefined(s_instance.var_156bb435d28f9102)) {
    s_instance.var_156bb435d28f9102 delete();
  }

  s_instance.e_rotator.origin = s_instance.origin;
}

function function_c6fbee886f1cda85() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  wait 0.5;
  host = level.player;
  host endon("<dev string:x37b>");
  level thread function_30edbc708304dc8a();

  while(true) {
    if(!level.var_9182aa2a8fc581de) {
      host val::reset_all("<dev string:x389>");
      waitframe();
      continue;
    }

    host val::set("<dev string:x389>", "<dev string:x39c>", 0);

    if(host fragButtonPressed()) {
      var_d9d303885cab9126 = 1;
      var_dfc451e555942a44 = 0;
      host val::set("<dev string:x389>", "<dev string:x3af>", 0);
    } else if(host adsButtonPressed()) {
      var_dfc451e555942a44 = 1;
      var_d9d303885cab9126 = 0;
      host val::reset("<dev string:x389>", "<dev string:x3af>");
    } else {
      var_dfc451e555942a44 = 0;
      var_d9d303885cab9126 = 0;
      host val::reset("<dev string:x389>", "<dev string:x3af>");
    }

    if((host buttonPressed("<dev string:x3bd>") || host buttonPressed("<dev string:x3c8>")) && !host sprintbuttonPressed()) {
      if(var_d9d303885cab9126) {
        host function_974a7c84f61a8d69("<dev string:x3d3>");
      } else if(var_dfc451e555942a44) {
        function_f00d91a7abf803a3();
      } else {
        function_3831054208ba1f8();
      }

      while(host buttonPressed("<dev string:x3bd>") || host buttonPressed("<dev string:x3c8>")) {
        if(var_dfc451e555942a44) {
          function_f18aa0429f98bc3();
        }

        waitframe();
      }
    }

    if((host buttonPressed("<dev string:x3db>") || host buttonPressed("<dev string:x3e8>")) && !host sprintbuttonPressed()) {
      if(var_d9d303885cab9126) {
        host function_974a7c84f61a8d69("<dev string:x3f5>");
      } else if(var_dfc451e555942a44) {} else {
        host cycle_model("<dev string:x3f5>");
      }

      while(host buttonPressed("<dev string:x3db>") || host buttonPressed("<dev string:x3e8>")) {
        waitframe();
      }
    }

    if((host buttonPressed("<dev string:x3fd>") || host buttonPressed("<dev string:x40b>")) && !host sprintbuttonPressed()) {
      if(var_d9d303885cab9126) {
        host function_974a7c84f61a8d69("<dev string:x419>");
      } else if(var_dfc451e555942a44) {
        if(flag("<dev string:x422>")) {
          flag_clear("<dev string:x422>");
        } else {
          flag_set("<dev string:x422>");
        }
      } else {
        host cycle_model("<dev string:x419>");
      }

      while(host buttonPressed("<dev string:x3fd>") || host buttonPressed("<dev string:x40b>")) {
        waitframe();
      }
    }

    if((host buttonPressed("<dev string:x443>") || host buttonPressed("<dev string:x450>")) && !host sprintbuttonPressed()) {
      if(var_d9d303885cab9126) {
        function_2d4f4f508df4fdb2();
        host function_974a7c84f61a8d69("<dev string:x45d>");
      } else if(var_dfc451e555942a44) {
        foreach(s_instance in level.var_7eb4320d65486c37) {
          if(isDefined(s_instance.var_47d007ab4f36e40d) && isDefined(s_instance.e_rotator) && !istrue(s_instance.var_47d007ab4f36e40d.var_fa329bfb7240fc7f)) {
            s_instance.var_47d007ab4f36e40d unlink();
            s_instance.var_47d007ab4f36e40d function_b987ebfe64b873d0();
            s_instance.var_47d007ab4f36e40d linkTo(s_instance.e_rotator);
          }
        }
      } else if(flag("<dev string:x466>")) {
        flag_clear("<dev string:x466>");
      } else {
        flag_set("<dev string:x466>");
      }

      while(host buttonPressed("<dev string:x443>") || host buttonPressed("<dev string:x450>")) {
        if(var_d9d303885cab9126) {
          function_e80c20454e7e1792();
        }

        waitframe();
      }
    }

    waitframe();
  }
}

function function_30edbc708304dc8a() {
  while(true) {
    if(flag("<dev string:x486>") || !level.var_9182aa2a8fc581de) {
      waitframe();
      continue;
    }

    host = level.player;

    if(isDefined(host) && level.var_7991fdfc863a12a9) {
      x = (50, 400, 0)[0] + (0, 20, 0)[0];
      y = (50, 400, 0)[1] + (0, 20, 0)[1];

      if(host fragButtonPressed()) {
        printtoscreen2d(x, y + (0, 20, 0)[1] * 0, "<dev string:x49b>", (1, 1, 1), 0.8);
        printtoscreen2d(x, y + (0, 20, 0)[1] * 1, "<dev string:x4d1>", (1, 1, 1), 0.8);
        printtoscreen2d(x, y + (0, 20, 0)[1] * 2, "<dev string:x4f5>", (1, 1, 1), 0.8);
      } else if(host adsButtonPressed()) {
        printtoscreen2d(x, y + (0, 20, 0)[1] * 0, "<dev string:x51c>", (1, 1, 1), 0.8);
        printtoscreen2d(x, y + (0, 20, 0)[1] * 1, "<dev string:x536>", (1, 1, 1), 0.8);
        printtoscreen2d(x, y + (0, 20, 0)[1] * 2, "<dev string:x55b>", (1, 1, 1), 0.8);
        printtoscreen2d(x, y + (0, 20, 0)[1] * 3, "<dev string:x587>", (1, 1, 1), 0.8);
      } else {
        printtoscreen2d(x, y + (0, 20, 0)[1] * 0, "<dev string:x5c1>", (1, 1, 1), 0.8);
        printtoscreen2d(x, y + (0, 20, 0)[1] * 1, "<dev string:x5e4>", (1, 1, 1), 0.8);
        printtoscreen2d(x, y + (0, 20, 0)[1] * 2, "<dev string:x608>", (1, 1, 1), 0.8);
        printtoscreen2d(x, y + (0, 20, 0)[1] * 3, "<dev string:x632>", (1, 1, 1), 0.8);
        printtoscreen2d(x, y + (0, 20, 0)[1] * 4, "<dev string:x64d>", (1, 1, 1), 0.8);
        printtoscreen2d(x, y + (0, 20, 0)[1] * 5, "<dev string:x673>", (1, 1, 1), 0.8);
      }

      printtoscreen2d((640, 25, 0)[0], (640, 25, 0)[1], "<dev string:x68b>", (1, 1, 1), 0.8);
      function_53785bcdff220286();
    }

    waitframe();
  }
}

function function_25f3557f59f5587c(s_instance) {
  while(!isDefined(level.player)) {
    waitframe();
  }

  while(true) {
    if(flag("<dev string:x466>") || flag("<dev string:x422>")) {
      foreach(s_instance in level.var_7eb4320d65486c37) {
        function_bf93bdd4ddf2fa08(s_instance);
        e_rotator = s_instance.e_rotator;
        var_3ad6a03af01e4791 = (e_rotator.angles[0], e_rotator.angles[1], e_rotator.angles[2]);

        if(flag("<dev string:x720>")) {
          var_3ad6a03af01e4791 = (var_3ad6a03af01e4791[0] + 3, var_3ad6a03af01e4791[1], var_3ad6a03af01e4791[2]);
        }

        if(flag("<dev string:x466>")) {
          var_3ad6a03af01e4791 = (s_instance.e_rotator.angles[0], s_instance.e_rotator.angles[1] + 3, s_instance.e_rotator.angles[2]);
        }

        if(flag("<dev string:x422>")) {
          var_3ad6a03af01e4791 = (var_3ad6a03af01e4791[0], var_3ad6a03af01e4791[1], var_3ad6a03af01e4791[2] + 3);
        }

        var_3ad6a03af01e4791 = (angleclamp(var_3ad6a03af01e4791[0]), angleclamp(var_3ad6a03af01e4791[1]), angleclamp(var_3ad6a03af01e4791[2]));
        e_rotator rotateTo(var_3ad6a03af01e4791, 0.05);
      }
    }

    waitframe();
  }
}

function function_f18aa0429f98bc3() {
  if(level.var_7991fdfc863a12a9) {
    printtoscreen2d((700, 530, 0)[0], (700, 530, 0)[1], "<dev string:x742>" + level.var_cf0923e214d8fb83, (1, 1, 1), 1);
  }
}

function function_e80c20454e7e1792() {
  if(level.var_7991fdfc863a12a9) {
    printtoscreen2d((700, 530, 0)[0], (700, 530, 0)[1], "<dev string:x75d>" + level.var_9b90cd97e5785760 + "<dev string:x777>", (1, 1, 1), 1);
  }
}

function function_53785bcdff220286() {
  host = level.player;

  if(isDefined(host) && level.var_7991fdfc863a12a9) {
    foreach(s_instance in level.var_7eb4320d65486c37) {
      var_1434dea7eb38ef0 = [];

      if(isDefined(s_instance.var_47d007ab4f36e40d)) {
        var_1434dea7eb38ef0[var_1434dea7eb38ef0.size] = "<dev string:x77c>" + default_to(s_instance.var_ba5658a989e571df.assetlabel, "<dev string:x786>");
        var_1434dea7eb38ef0[var_1434dea7eb38ef0.size] = "<dev string:x794>" + s_instance.var_ba5658a989e571df.assettype;
        var_1434dea7eb38ef0[var_1434dea7eb38ef0.size] = "<dev string:x79e>" + s_instance.var_ba5658a989e571df.model;
        var_1434dea7eb38ef0[var_1434dea7eb38ef0.size] = "<dev string:x7a8>" + default_to(s_instance.targetname, "<dev string:x7b6>");

        if(isDefined(s_instance.var_ba5658a989e571df.attachmodels)) {
          foreach(var_7ce7a36a544de708 in s_instance.var_ba5658a989e571df.attachmodels) {
            str_tag = default_to(var_7ce7a36a544de708.var_b60ba9a53f06b31b, "<dev string:x7c9>");
            var_1434dea7eb38ef0[var_1434dea7eb38ef0.size] = "<dev string:x7d7>" + var_7ce7a36a544de708.attachmodel + "<dev string:x7ec>" + str_tag + "<dev string:x7f2>";
          }
        }

        if(isDefined(s_instance.var_ba5658a989e571df.var_18819ef03e6b0884)) {
          var_1434dea7eb38ef0[var_1434dea7eb38ef0.size] = "<dev string:x7f7>" + s_instance.var_ba5658a989e571df.var_103d247cec19b232 + 1 + "<dev string:x809>" + s_instance.var_ba5658a989e571df.var_18819ef03e6b0884;
        }

        s_scene = function_f6fbd861496cf05c(s_instance);

        if(isDefined(s_scene) && isDefined(s_scene.scene) && istrue(s_instance.var_47d007ab4f36e40d.var_462b680bd2c84e9a)) {
          var_1434dea7eb38ef0[var_1434dea7eb38ef0.size] = "<dev string:x80f>" + s_scene.scene;

          if(isDefined(s_scene.sceneshot)) {
            var_1434dea7eb38ef0[var_1434dea7eb38ef0.size] = "<dev string:x81a>" + s_scene.sceneshot;
          }
        }

        if(distance2dsquared(host.origin, s_instance.var_47d007ab4f36e40d.origin) < 250000 && within_fov(host getEye(), host getplayerangles(), s_instance.var_47d007ab4f36e40d getcentroid(), 0.9)) {
          foreach(n_spacing, var_4193d6166ac5fb84 in var_1434dea7eb38ef0) {
            v_pos = s_instance.var_47d007ab4f36e40d.origin + (-15, 0, -15);
            v_pos += (0, 0, -2.5 * n_spacing);
            print3d(v_pos, var_4193d6166ac5fb84, (1, 1, 0), 1, 0.2);
          }
        }
      }
    }
  }
}

function function_b987ebfe64b873d0() {
  [n_radius] = self getboundshalfsize();
  v_ground = getgroundposition(self.origin, n_radius);
  var_48fac91d21bbd895 = self getpointinbounds(0, 0, -1);
  n_z_diff = var_48fac91d21bbd895[2] - v_ground[2];
  self.origin = (self.origin[0], self.origin[1], self.origin[2] - n_z_diff);
}

function cycle_model(str_direction) {
  str_direction = default_to(str_direction, "<dev string:x419>");

  foreach(s_instance in level.var_7eb4320d65486c37) {
    if(str_direction == "<dev string:x3f5>") {
      s_instance.var_a4a4166618e64bb3 = default_to(s_instance.var_a4a4166618e64bb3, 1);
      s_instance.var_a4a4166618e64bb3--;

      if(s_instance.var_a4a4166618e64bb3 < 0) {
        s_instance.var_a4a4166618e64bb3 = s_instance.s_bundle.assetlist.size - 1;
      }
    } else {
      s_instance.var_a4a4166618e64bb3 = default_to(s_instance.var_a4a4166618e64bb3, -1);
      s_instance.var_a4a4166618e64bb3++;

      if(s_instance.var_a4a4166618e64bb3 > s_instance.s_bundle.assetlist.size - 1) {
        s_instance.var_a4a4166618e64bb3 = 0;
      }
    }

    spawn_asset(s_instance);
  }
}

function function_2860654ba01d34d8(s_instance) {
  var_7c79a44be41c38cc = s_instance.var_a4a4166618e64bb3;
  str_asset = s_instance.s_bundle.assetlist[var_7c79a44be41c38cc].model;
  return str_asset;
}

function function_dcce9747546c6aab(s_instance) {
  var_7c79a44be41c38cc = s_instance.var_a4a4166618e64bb3;
  str_type = s_instance.s_bundle.assetlist[var_7c79a44be41c38cc].assettype;
  return str_type;
}

function function_d480550168f3e691(s_instance, var_64d79b3074426595) {
  if(istrue(var_64d79b3074426595)) {
    v_offset = (default_to(s_instance.var_642cd206326efd48.x, 0), default_to(s_instance.var_642cd206326efd48.y, 0), default_to(s_instance.var_642cd206326efd48.z, 0));
  } else {
    v_offset = (default_to(s_instance.var_ba5658a989e571df.spawnoffsetpos.x, 0), default_to(s_instance.var_ba5658a989e571df.spawnoffsetpos.y, 0), default_to(s_instance.var_ba5658a989e571df.spawnoffsetpos.z, 0));
  }

  return v_offset;
}

function function_dcd2b000b303dddb(s_instance, var_64d79b3074426595) {
  if(istrue(var_64d79b3074426595)) {
    v_offset = (default_to(s_instance.var_57746f06e388cb66.x, 0), default_to(s_instance.var_57746f06e388cb66.y, 0), default_to(s_instance.var_57746f06e388cb66.z, 0));
  } else {
    v_offset = (default_to(s_instance.var_ba5658a989e571df.var_1d06781924d70939.x, 0), default_to(s_instance.var_ba5658a989e571df.var_1d06781924d70939.y, 0), default_to(s_instance.var_ba5658a989e571df.var_1d06781924d70939.z, 0));
  }

  return v_offset;
}

function function_4654ebae913dc41b(s_instance) {
  var_7c79a44be41c38cc = s_instance.var_ba5658a989e571df.var_8fef67121ea8e662;
  var_bdeba5a36298bae1 = s_instance.var_ba5658a989e571df.var_92185f888d6fa71c[var_7c79a44be41c38cc];
  v_offset = (default_to(var_bdeba5a36298bae1.var_642cd206326efd48.x, 0), default_to(var_bdeba5a36298bae1.var_642cd206326efd48.y, 0), default_to(var_bdeba5a36298bae1.var_642cd206326efd48.z, 0));
  return v_offset;
}

function function_4f3336addbe6b715(s_instance) {
  var_7c79a44be41c38cc = s_instance.var_ba5658a989e571df.var_8fef67121ea8e662;
  var_bdeba5a36298bae1 = s_instance.var_ba5658a989e571df.var_92185f888d6fa71c[var_7c79a44be41c38cc];
  v_offset = (default_to(var_bdeba5a36298bae1.var_57746f06e388cb66.x, 0), default_to(var_bdeba5a36298bae1.var_57746f06e388cb66.y, 0), default_to(var_bdeba5a36298bae1.var_57746f06e388cb66.z, 0));
  return v_offset;
}

function function_f6fbd861496cf05c(s_instance) {
  var_7c79a44be41c38cc = s_instance.var_ba5658a989e571df.var_8fef67121ea8e662;

  if(!isarray(s_instance.var_ba5658a989e571df.var_92185f888d6fa71c) || !s_instance.var_ba5658a989e571df.var_92185f888d6fa71c.size) {
    return;
  }

  s_scene = s_instance.var_ba5658a989e571df.var_92185f888d6fa71c[var_7c79a44be41c38cc];
  return s_scene;
}

function spawn_asset(s_instance) {
  while(!isDefined(level.player)) {
    waitframe();
  }

  function_bf93bdd4ddf2fa08(s_instance);
  host = level.player;

  if(isDefined(s_instance.var_47d007ab4f36e40d) && isDefined(s_instance.var_47d007ab4f36e40d.var_f6a022ce17906c5b)) {
    foreach(model in s_instance.var_47d007ab4f36e40d.var_f6a022ce17906c5b) {
      model delete();
    }

    s_instance.var_47d007ab4f36e40d.var_f6a022ce17906c5b = undefined;
  }

  if(isDefined(s_instance.var_47d007ab4f36e40d)) {
    s_instance.var_47d007ab4f36e40d delete();
  }

  s_instance.var_ba5658a989e571df = s_instance.s_bundle.assetlist[s_instance.var_a4a4166618e64bb3];
  s_instance.var_ba5658a989e571df.var_8fef67121ea8e662 = default_to(s_instance.var_ba5658a989e571df.var_8fef67121ea8e662, 0);
  var_7ab5398b0142b69b = function_2860654ba01d34d8(s_instance);
  str_type = function_dcce9747546c6aab(s_instance);
  v_pos = s_instance.e_rotator.origin + function_d480550168f3e691(s_instance);
  v_ang = s_instance.e_rotator.angles + function_dcd2b000b303dddb(s_instance);

  switch (str_type) {
    case #"hash_769eb8a21188fc4":
      s_instance.var_47d007ab4f36e40d = spawn("<dev string:x362>", v_pos);
      s_instance.var_47d007ab4f36e40d.angles = v_ang;
      s_instance.var_47d007ab4f36e40d setModel(var_7ab5398b0142b69b);
      break;
    default:
      iprintlnbold("<dev string:x824>");
      return;
  }

  s_instance.var_47d007ab4f36e40d linkTo(s_instance.e_rotator);
  s_instance.e_rotator unlink();
  s_instance.e_rotator.angles = (s_instance.e_rotator.angles[0], s_instance.e_rotator.angles[1], 0);

  if(isDefined(s_instance.var_156bb435d28f9102)) {
    s_instance.var_156bb435d28f9102 unlink();
    s_instance.var_156bb435d28f9102.angles = (s_instance.var_156bb435d28f9102.angles[0], s_instance.var_156bb435d28f9102.angles[1], 0);

    if(istrue(s_instance.var_156bb435d28f9102.var_81c2718f2fde774d)) {
      s_instance.e_rotator linkTo(s_instance.var_156bb435d28f9102);
      s_instance.var_156bb435d28f9102 linkTo(host);
    }
  }

  if(isDefined(s_instance.var_ba5658a989e571df.attachmodels)) {
    s_instance.var_47d007ab4f36e40d.var_f6a022ce17906c5b = [];

    foreach(var_7ce7a36a544de708 in s_instance.var_ba5658a989e571df.attachmodels) {
      if(!isDefined(var_7ce7a36a544de708.attachmodel)) {
        continue;
      }

      str_tag = default_to(var_7ce7a36a544de708.var_b60ba9a53f06b31b, "<dev string:x7c9>");
      var_edde07b0cad7554a = utility::spawn_model(var_7ce7a36a544de708.attachmodel, s_instance.var_47d007ab4f36e40d.origin, s_instance.var_47d007ab4f36e40d.angles);
      var_edde07b0cad7554a linkTo(s_instance.var_47d007ab4f36e40d, str_tag, function_d480550168f3e691(var_7ce7a36a544de708, 1), function_dcd2b000b303dddb(var_7ce7a36a544de708, 1));
      s_instance.var_47d007ab4f36e40d.var_f6a022ce17906c5b = array_add(s_instance.var_47d007ab4f36e40d.var_f6a022ce17906c5b, var_edde07b0cad7554a);
    }
  }
}

function function_bf93bdd4ddf2fa08(s_instance) {
  if(!isDefined(s_instance.e_rotator)) {
    s_instance.e_rotator = spawn("<dev string:x362>", s_instance.origin);
    s_instance.e_rotator.angles = default_to(s_instance.angles, (0, 0, 0));
  }

  if(!isDefined(s_instance.var_6a63f67553c0a819) && isDefined(s_instance.script_linkname)) {
    s_instance.var_6a63f67553c0a819 = spawn("<dev string:x362>", s_instance.origin);
    s_instance.var_6a63f67553c0a819.angles = s_instance.angles;
    s_instance.var_507b3745e2487a13 = getEntArray(s_instance.script_linkname, "<dev string:x841>");

    foreach(ent in s_instance.var_507b3745e2487a13) {
      ent linkTo(s_instance.var_6a63f67553c0a819);
    }
  }
}

function function_974a7c84f61a8d69(str_option) {
  str_option = default_to(str_option, "<dev string:x419>");

  foreach(s_instance in level.var_7eb4320d65486c37) {
    var_ba5658a989e571df = s_instance.var_ba5658a989e571df;

    if(str_option == "<dev string:x3f5>") {
      var_ba5658a989e571df.var_8fef67121ea8e662--;

      if(var_ba5658a989e571df.var_8fef67121ea8e662 < 0) {
        var_ba5658a989e571df.var_8fef67121ea8e662 = var_ba5658a989e571df.var_92185f888d6fa71c.size - 1;
      }

      s_instance.var_47d007ab4f36e40d.var_462b680bd2c84e9a = undefined;
    } else if(str_option == "<dev string:x419>") {
      var_ba5658a989e571df.var_8fef67121ea8e662++;

      if(var_ba5658a989e571df.var_8fef67121ea8e662 > var_ba5658a989e571df.var_92185f888d6fa71c.size - 1) {
        var_ba5658a989e571df.var_8fef67121ea8e662 = 0;
      }

      s_instance.var_47d007ab4f36e40d.var_462b680bd2c84e9a = undefined;
    }

    s_scene = function_f6fbd861496cf05c(s_instance);

    if(isDefined(s_scene)) {
      if(isDefined(s_instance.var_47d007ab4f36e40d)) {
        if(str_option == "<dev string:x45d>") {
          var_853ad2a587bac429 = 1;
        } else {
          var_853ad2a587bac429 = 0;
        }

        s_instance function_f602ca14697efa33(s_scene, var_853ad2a587bac429);
      }

      continue;
    }

    if(isDefined(s_instance.var_47d007ab4f36e40d) && istrue(s_instance.var_47d007ab4f36e40d.var_462b680bd2c84e9a) && !istrue(s_instance.var_47d007ab4f36e40d.var_fa329bfb7240fc7f)) {
      s_instance.e_rotator scene::stop();
      s_instance.var_47d007ab4f36e40d linkTo(s_instance.e_rotator);
      s_instance.var_47d007ab4f36e40d.var_462b680bd2c84e9a = undefined;
    }
  }
}

function function_f602ca14697efa33(s_scene, var_5e10d507da2ff39) {
  if(isDefined(self.e_rotator.script_scenescriptbundle)) {
    self.e_rotator scene::stop();
  }

  self.e_rotator.script_scenescriptbundle = s_scene.scene;

  if(istrue(var_5e10d507da2ff39)) {
    if(istrue(self.var_47d007ab4f36e40d.var_462b680bd2c84e9a)) {
      self.e_rotator thread scene::play(self.var_47d007ab4f36e40d, s_scene.sceneshot, s_scene.scene);
    }

    return;
  }

  if(istrue(self.var_47d007ab4f36e40d.var_462b680bd2c84e9a)) {
    n_start_time = 0;
    b_paused = 1;
    self.var_47d007ab4f36e40d.var_462b680bd2c84e9a = undefined;
  } else {
    n_start_time = 0;
    b_paused = 0;
    self.var_47d007ab4f36e40d.var_462b680bd2c84e9a = 1;
  }

  self.e_rotator scene::stop();
  self.e_rotator thread scene::play(self.var_47d007ab4f36e40d, s_scene.sceneshot, s_scene.scene, n_start_time);
}

function function_77ed239c74e6dc6e(s_instance) {
  var_ba5658a989e571df = s_instance.var_ba5658a989e571df;
  var_8fef67121ea8e662 = var_ba5658a989e571df.var_8fef67121ea8e662;

  if(isDefined(s_instance.var_47d007ab4f36e40d.var_edde07b0cad7554a)) {
    foreach(model in s_instance.var_47d007ab4f36e40d.var_f6a022ce17906c5b) {
      model delete();
    }
  }

  if(isarray(var_ba5658a989e571df.var_92185f888d6fa71c) && isDefined(var_ba5658a989e571df.var_92185f888d6fa71c[var_8fef67121ea8e662].attachmodel)) {
    s_anim = var_ba5658a989e571df.var_92185f888d6fa71c[var_8fef67121ea8e662];
    str_attach_model = s_anim.attachmodel;
    str_tag = default_to(s_anim.var_b60ba9a53f06b31b, "<dev string:x7c9>");
    s_instance.var_47d007ab4f36e40d.var_edde07b0cad7554a = spawn("<dev string:x362>", s_instance.var_47d007ab4f36e40d.origin);
    s_instance.var_47d007ab4f36e40d.var_edde07b0cad7554a.angles = default_to(s_instance.var_47d007ab4f36e40d.angles, (0, 0, 0));
    var_50a193334d70a7ae = function_4654ebae913dc41b(s_instance);
    var_a6f03dafe74eb1d0 = function_4f3336addbe6b715(s_instance);
    s_instance.var_47d007ab4f36e40d.var_edde07b0cad7554a linkTo(s_instance.var_47d007ab4f36e40d, str_tag, var_50a193334d70a7ae, var_a6f03dafe74eb1d0);
    return;
  }

  if(isDefined(var_ba5658a989e571df.attachmodel)) {
    str_attach_model = var_ba5658a989e571df.attachmodel;
    str_tag = default_to(var_ba5658a989e571df.var_b60ba9a53f06b31b, "<dev string:x7c9>");
    s_instance.var_47d007ab4f36e40d.var_edde07b0cad7554a = spawn("<dev string:x362>", s_instance.var_47d007ab4f36e40d.origin);
    s_instance.var_47d007ab4f36e40d.var_edde07b0cad7554a.angles = default_to(s_instance.var_47d007ab4f36e40d.angles, (0, 0, 0));
    var_50a193334d70a7ae = function_4654ebae913dc41b(s_instance);
    var_a6f03dafe74eb1d0 = function_4f3336addbe6b715(s_instance);
    s_instance.var_47d007ab4f36e40d.var_edde07b0cad7554a linkTo(s_instance.var_47d007ab4f36e40d, str_tag, var_50a193334d70a7ae, var_a6f03dafe74eb1d0);
  }
}

function function_2d4f4f508df4fdb2() {
  if(level.var_9b90cd97e5785760 == 1) {
    level.var_9b90cd97e5785760 = 0.1;
    return;
  }

  if(level.var_9b90cd97e5785760 == 0.5) {
    level.var_9b90cd97e5785760 = 1;
    return;
  }

  if(level.var_9b90cd97e5785760 == 0.1) {
    level.var_9b90cd97e5785760 = 0.5;
  }
}

function function_f00d91a7abf803a3() {
  level.var_cf0923e214d8fb83 -= 0.25;

  if(level.var_cf0923e214d8fb83 < 0.25) {
    level.var_cf0923e214d8fb83 = 1;
  }

  foreach(s_instance in level.var_7eb4320d65486c37) {
    if(isDefined(s_instance.var_47d007ab4f36e40d)) {}

    if(isDefined(s_instance.var_47d007ab4f36e40d.var_edde07b0cad7554a)) {}
  }
}

function function_3831054208ba1f8() {
  foreach(s_instance in level.var_7eb4320d65486c37) {
    var_ba5658a989e571df = s_instance.var_ba5658a989e571df;

    if(isarray(var_ba5658a989e571df.var_44d1e76fc7ab685a) && var_ba5658a989e571df.var_44d1e76fc7ab685a.size > 0 && isDefined(s_instance.var_47d007ab4f36e40d)) {
      if(!isDefined(var_ba5658a989e571df.var_103d247cec19b232)) {
        var_ba5658a989e571df.var_103d247cec19b232 = 0;
        s_instance.var_ba5658a989e571df.var_18819ef03e6b0884 = var_ba5658a989e571df.var_44d1e76fc7ab685a[var_ba5658a989e571df.var_103d247cec19b232].modelvariant;
        s_instance.var_47d007ab4f36e40d setModel(s_instance.var_ba5658a989e571df.var_18819ef03e6b0884);
        continue;
      }

      var_ba5658a989e571df.var_103d247cec19b232++;

      if(var_ba5658a989e571df.var_103d247cec19b232 >= var_ba5658a989e571df.var_44d1e76fc7ab685a.size) {
        var_ba5658a989e571df.var_103d247cec19b232 = -1;
        s_instance.var_47d007ab4f36e40d setModel(var_ba5658a989e571df.model);
        s_instance.var_ba5658a989e571df.var_18819ef03e6b0884 = undefined;
        continue;
      }

      s_instance.var_ba5658a989e571df.var_18819ef03e6b0884 = var_ba5658a989e571df.var_44d1e76fc7ab685a[var_ba5658a989e571df.var_103d247cec19b232].modelvariant;

      if(isDefined(s_instance.var_ba5658a989e571df.var_18819ef03e6b0884)) {
        s_instance.var_47d007ab4f36e40d setModel(s_instance.var_ba5658a989e571df.var_18819ef03e6b0884);
      }
    }
  }
}

# /