/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\_prop_dev.gsc
***********************************************/

#using scripts\core_common\bots\bot;
#using scripts\core_common\dogtags;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\mp\killstreaks;
#using scripts\mp_common\gametypes\_prop_controls;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\prop;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\gametypes\spawnlogic;
#using scripts\mp_common\util;
#namespace prop_dev;

function adddevguicommand(path, var_c669188) {
  pathstr = "<dev string:x38>" + path + "<dev string:x38>";
  cmdstr = "<dev string:x38>" + var_c669188 + "<dev string:x3d>";
  debugcommand = "<dev string:x43>" + pathstr + "<dev string:x52>" + cmdstr;
  adddebugcommand(debugcommand);
}

function propdevgui() {
  var_6631295a = 0;
  var_e68b7091 = 0;
  var_28c934a0 = 0;
  var_27e85424 = 0;
  var_e535ed97 = 0;
  var_f4098dd1 = 0;
  var_94dbbfd9 = 0;
  var_b948ae6c = 0;
  minigame_on = getdvarint(#"scr_prop_minigame", 1);
  server_hud = getdvarint(#"scr_ph_useprophudserver", 1);
  var_f6fe53f9 = getdvarfloat(#"player_swimdamage", 10);
  function_5ac4dc99("<dev string:x57>", 0);
  function_5ac4dc99("<dev string:x6d>", 0);
  function_5ac4dc99("<dev string:x82>", 0);
  function_5ac4dc99("<dev string:x98>", 0);
  function_5ac4dc99("<dev string:xac>", 0);
  function_5ac4dc99("<dev string:xc0>", 0);
  function_5ac4dc99("<dev string:xd8>", 0);
  function_5ac4dc99("<dev string:xf4>", 0);
  function_5ac4dc99("<dev string:x10e>", 0);
  function_5ac4dc99("<dev string:x124>", 0);
  function_5ac4dc99("<dev string:x139>", 0);
  function_5ac4dc99("<dev string:x154>", 1);
  function_5ac4dc99("<dev string:x177>", 1);
  function_5ac4dc99("<dev string:x192>", 0);
  function_5ac4dc99("<dev string:x1aa>", 0);
  function_5ac4dc99("<dev string:x1c1>", 0);
  function_5ac4dc99("<dev string:x1db>", 0);
  function_5ac4dc99("<dev string:x1f4>", 0);
  function_5ac4dc99("<dev string:x209>", 0);
  function_5ac4dc99("<dev string:x224>", 0);
  function_5ac4dc99("<dev string:x23f>", 0);
  setDvar(#"hash_4424a07b5272599a", 0);
  setDvar(#"hash_34a3e2c00f7cd27f", 0);
  setDvar(#"hash_3fd977c7de8de72b", 0);
  setDvar(#"hash_5fea18fb5a6e0027", 0);
  setDvar(#"hash_69637702c083dc28", 0);
  setDvar(#"hash_2a03924a528ff9a8", 0);
  setDvar(#"hash_740b6f4a4aa58f21", 0);
  setDvar(#"hash_7115842bdfa67a2b", 0);

  if(getdvarint(#"hash_70c6c4a3e9254926", 0) != 0) {
    adddebugcommand("<dev string:x25d>");
  }

  adddevguicommand("<dev string:x27d>", "<dev string:x2a0>");
  adddevguicommand("<dev string:x2c3>", "<dev string:x2df>");
  adddevguicommand("<dev string:x31f>", "<dev string:x33b>" + 4 + "<dev string:x35a>");
  adddevguicommand("<dev string:x37e>", "<dev string:x33b>" + 0.25 + "<dev string:x35a>");
  adddevguicommand("<dev string:x39b>", "<dev string:x3c2>");
  adddevguicommand("<dev string:x3e2>", "<dev string:x408>");
  adddevguicommand("<dev string:x42c>", "<dev string:x450>");
  adddevguicommand("<dev string:x470>", "<dev string:x495>");
  adddevguicommand("<dev string:x4b6>", "<dev string:x4db>");
  adddevguicommand("<dev string:x4fc>", "<dev string:x51f>");
  adddevguicommand("<dev string:x53e>", "<dev string:x561>");
  adddevguicommand("<dev string:x580>", "<dev string:x59c>");
  adddevguicommand("<dev string:x5bc>", "<dev string:x5d8>");
  adddevguicommand("<dev string:x5f8>", "<dev string:x611>");
  adddevguicommand("<dev string:x62d>", "<dev string:x646>");
  adddevguicommand("<dev string:x662>", "<dev string:x678>");
  adddevguicommand("<dev string:x6c8>", "<dev string:x6e1>");
  adddevguicommand("<dev string:x701>", "<dev string:x719>");
  adddevguicommand("<dev string:x739>", "<dev string:x752>");
  adddevguicommand("<dev string:x76d>", "<dev string:x78f>");
  adddevguicommand("<dev string:x7aa>", "<dev string:x7cb>");
  adddevguicommand("<dev string:x7e5>", "<dev string:x801>");
  adddevguicommand("<dev string:x824>", "<dev string:x83f>");
  adddevguicommand("<dev string:x861>", "<dev string:x880>");
  adddevguicommand("<dev string:x8a6>", "<dev string:x8c0>");
  adddevguicommand("<dev string:x8e6>", "<dev string:x904>");
  adddevguicommand("<dev string:x924>", "<dev string:x951>");
  adddevguicommand("<dev string:x974>", "<dev string:x9a4>");
  adddevguicommand("<dev string:x9c3>", "<dev string:x9f6>");
  adddevguicommand("<dev string:xa18>", "<dev string:xa46>");
  adddevguicommand("<dev string:xa6a>", "<dev string:xa87>");
  adddevguicommand("<dev string:xaad>", "<dev string:xac9>");
  adddevguicommand("<dev string:xae9>", "<dev string:xb10>");

  while(true) {
    if(is_true(level.prematch_over)) {
      level.allow_teamchange = getdvarint(#"hash_7f436a7b31a003f3", 0);
      level.var_a7997034 = getdvarint(#"hash_4819c54cbad5ed87", 0) != 0;
    }

    if(getdvarint(#"scr_ph_useprophudserver", 0) != server_hud && isDefined(level.players)) {
      server_hud = getdvarint(#"scr_ph_useprophudserver", 0);

      if(!isDefined(level.players[0].changepropkey)) {
        iprintlnbold("<dev string:xb3b>");
      } else {
        foreach(player in level.players) {
          if(isDefined(player.team) && player util::isprop()) {
            player prop_controls::propabilitykeysvisible(server_hud, 1);
          }
        }

        level.elim_hud.alpha = server_hud;
      }
    }

    if(getdvarint(#"hash_2c678eea20875ddd", 0) != var_28c934a0 && isDefined(level.players)) {
      foreach(player in level.players) {
        if(player util::isprop()) {
          var_28c934a0 = getdvarint(#"hash_2c678eea20875ddd", 0);
          player.var_f18a4260 = !is_true(player.var_f18a4260);
          player iprintlnbold(player.var_f18a4260 ? "<dev string:xb56>" : "<dev string:xb6b>");
        }
      }
    }

    if(getdvarint(#"hash_4aab269ba89e7cb6", 0) != var_27e85424 && isDefined(level.players)) {
      foreach(player in level.players) {
        if(player util::isprop()) {
          var_27e85424 = getdvarint(#"hash_4aab269ba89e7cb6", 0);
          player.var_7ddbf78d = !is_true(player.var_7ddbf78d);
          player iprintlnbold(player.var_7ddbf78d ? "<dev string:xb7d>" : "<dev string:xb91>");
        }
      }
    }

    if(getdvarint(#"hash_53ee83feb4db4606", 0) != var_e535ed97 && isDefined(level.players)) {
      foreach(player in level.players) {
        if(player util::isprop()) {
          var_e535ed97 = getdvarint(#"hash_53ee83feb4db4606", 0);
          player.var_d0e95c44 = !is_true(player.var_d0e95c44);
          player iprintlnbold(player.var_d0e95c44 ? "<dev string:xba2>" : "<dev string:xbb7>");
        }
      }
    }

    if(getdvarint(#"hash_62162f1f94cbba77", 0) != var_f4098dd1) {
      var_f4098dd1 = getdvarint(#"hash_62162f1f94cbba77", 0);

      if(var_f4098dd1) {
        setDvar(#"doublejump_time_before_recharge", 1);
        setDvar(#"doublejump_time_before_recharge_fast", 1);
        setDvar(#"playerenergy_restrate", 10000);
      } else {
        setDvar(#"doublejump_time_before_recharge", 1600);
        setDvar(#"doublejump_time_before_recharge_fast", 1000);
        setDvar(#"playerenergy_restrate", 400);
        iprintlnbold(var_f4098dd1 ? "<dev string:xbc9>" : "<dev string:xbdc>");
      }
    }

    if(getdvarint(#"hash_618be616410fad95", 0) != var_94dbbfd9 && isDefined(level.players)) {
      foreach(player in level.players) {
        if(player prop::function_84793f03()) {
          var_94dbbfd9 = getdvarint(#"hash_618be616410fad95", 0);
          player.var_8df5658d = !is_true(player.var_8df5658d);
          player iprintlnbold(player.var_8df5658d ? "<dev string:xbec>" : "<dev string:xbff>");
        }
      }
    }

    isremoved = getdvarint(#"hash_21d7ba8da36d4023", 0);

    if(isremoved != var_6631295a) {
      var_6631295a = isremoved;
      function_ad983215(!isremoved);
    }

    var_90cd8304 = getdvarint(#"hash_34a3e2c00f7cd27f", 0);

    if(var_90cd8304 != var_e68b7091) {
      var_e68b7091 = var_90cd8304;
      result = function_fd3c3ed0(var_90cd8304);

      if(!result) {
        var_e68b7091 = !var_90cd8304;
      }

      if(var_e68b7091) {
        level.drown_damage = 0;
      } else {
        level.drown_damage = var_f6fe53f9;
      }
    }

    if(getdvarint(#"hash_3fd977c7de8de72b", 0) != 0) {
      function_cb8ecc99();
      setDvar(#"hash_3fd977c7de8de72b", 0);
    }

    if(getdvarint(#"hash_5fea18fb5a6e0027", 0) != 0) {
      function_2b23b2b6();
      setDvar(#"hash_5fea18fb5a6e0027", 0);
    }

    if(getdvarint(#"hash_69637702c083dc28", 0) != 0) {
      function_f2e19297();
      setDvar(#"hash_69637702c083dc28", 0);
    }

    if(getdvarint(#"hash_7115842bdfa67a2b", 0) != 0) {
      if(isDefined(level.players) && isDefined(level.players[0])) {
        level thread prop::function_c4aeb146(#"score_last_alive", level.players[0]);
      }

      setDvar(#"hash_7115842bdfa67a2b", 0);
    }

    if(getdvarint(#"hash_34e9a7fac83d28a6", 0) != 0) {
      showhealth();
    }

    if(getdvarint(#"hash_7b2608d6176b79f4", 0)) {
      function_38964c72();
    }

    if(getdvarint(#"hash_4424a07b5272599a", 0) != 0) {
      showmodels();
      setDvar(#"hash_4424a07b5272599a", 0);
    }

    if(getdvarint(#"hash_84008139ad85e21", 0) != 0) {
      if(isDefined(level.players) && isDefined(level.players[0])) {
        level.players[0] prop_controls::canlock();
      }
    }

    if(getdvarint(#"hash_2fa05819a4eeb99b", 0) != 0 || getdvarint(#"hash_84008139ad85e21", 0) != 0) {
      function_1f3923fa();
    }

    if(getdvarint(#"hash_2a03924a528ff9a8", 0) != 0) {
      function_5e0d41c4();
      setDvar(#"hash_2a03924a528ff9a8", 0);
    }

    if(getdvarint(#"hash_740b6f4a4aa58f21", 0) != 0) {
      function_5646cd5c();
      setDvar(#"hash_740b6f4a4aa58f21", 0);
    }

    if(getdvarint(#"hash_2441330d88677536", 0) != 0 && isDefined(level.players)) {
      level notify(#"cancelcountdown");
      setDvar(#"hash_2441330d88677536", 0);
    }

    if(getdvarint(#"hash_7da18bcec6fafe7f", 0) != 0) {
      function_34a7562e();
    }

    if(getdvarint(#"hash_745b5ef88dd291e1", 0) != 0) {
      showplayers();
    }

    if(getdvarint(#"hash_3c0e90252ca92099", 0) != 0) {
      showtargets();
    }

    if(getdvarint(#"scr_prop_minigame", 1) != minigame_on && isDefined(level.players) && level.players.size > 0) {
      minigame_on = getdvarint(#"scr_prop_minigame", 1);
      iprintlnbold(minigame_on ? "<dev string:xc0f>" : "<dev string:xc1e>");
    }

    if(getdvarint(#"hash_6132db0becb8f98", 0) != var_b948ae6c && isDefined(level.players) && level.players.size > 0) {
      var_b948ae6c = getdvarint(#"hash_6132db0becb8f98", 0);

      if(var_b948ae6c == 2) {
        iprintlnbold("<dev string:xc2e>");
      } else if(var_b948ae6c == 1) {
        iprintlnbold("<dev string:xc44>");
      } else {
        iprintlnbold("<dev string:xc5b>");
      }
    }

    waitframe(1);
  }
}

function function_ad983215(enabled) {
  setDvar(#"com_statmon", enabled);
  setDvar(#"con_minicon", enabled);
  setDvar(#"cg_drawfps", enabled);
  setDvar(#"cg_drawtime", enabled);
  setDvar(#"cg_drawviewpos", enabled);
  setDvar(#"hash_173fd7265ae0b7b1", enabled);
  setDvar(#"hash_2d3acd259cd6aca6", enabled);
}

function function_fd3c3ed0(enabled) {
  if(!isDefined(level.players) || level.players.size == 0) {
    return 0;
  }

  player = level.players[0];

  if(!isDefined(player) || !isalive(player) || isDefined(player.placementoffset) || !isDefined(player.prop)) {
    return 0;
  }

  if(enabled) {
    player function_673195f3();
  } else {
    player function_401f47cd();
  }

  return 1;
}

function function_9cd2eb63(color, label, value, text, var_e1fb743e) {
  hudelem = prop_controls::addupperrighthudelem(label, value, text, var_e1fb743e);
  hudelem.alpha = 0.5;
  hudelem.color = color;
  return hudelem;
}

function function_673195f3() {
  self prop_controls::cleanuppropcontrolshud();
  self prop_controls::function_1e25f968();

  if(self issplitscreen()) {
    self.currenthudy = -10;
  } else {
    self.currenthudy = -80;
  }

  self.var_5f51d2ee = function_1eca597a(self.prop.info.modelname);
  white = (1, 1, 1);
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0.5, 1);
  self.var_28df7051 = array(self.placementmodel, self.var_3634d14e, self.var_a2614669, self.var_5ee5df03, self.var_66df6677, self.var_ec9a93, self.var_811d1afa, self.var_d7336ed8, self.var_334e2710, self.var_faa235b5, self.var_35eb52f1, self.var_a2f59097);
  self.placementindex = 0;
  self function_8d3ffd86();
  self thread function_c3c92269();
  self thread function_4a5dac11();
  self thread function_1e509052();
}

function function_401f47cd() {
  self notify(#"hash_3ecc0277d544b441");
  prop_controls::safedestroy(self.placementmodel);
  prop_controls::safedestroy(self.var_3634d14e);
  prop_controls::safedestroy(self.var_a2614669);
  prop_controls::safedestroy(self.var_5ee5df03);
  prop_controls::safedestroy(self.var_66df6677);
  prop_controls::safedestroy(self.var_ec9a93);
  prop_controls::safedestroy(self.var_811d1afa);
  prop_controls::safedestroy(self.var_d7336ed8);
  prop_controls::safedestroy(self.var_334e2710);
  prop_controls::safedestroy(self.var_faa235b5);
  prop_controls::safedestroy(self.var_35eb52f1);
  prop_controls::safedestroy(self.var_a2f59097);
  self function_cc5afb75();
  self prop_controls::propcontrolshud();
  self prop_controls::setupkeybindings();
}

function function_1e509052() {
  self endon(#"game_ended", #"disconnect", #"hash_3ecc0277d544b441");
  self waittill(#"death");
  setDvar(#"hash_34a3e2c00f7cd27f", 0);
}

function function_c3c92269() {
  self endon(#"hash_3ecc0277d544b441");

  while(true) {
    debugaxis(self.origin, self.angles, 100, 1, 0, 1);
    box(self.origin, self getmins(), self getmaxs(), self.angles[1], (1, 0, 1), 1, 0, 1);
    waitframe(1);
  }
}

function function_4a5dac11() {
  self endon(#"hash_3ecc0277d544b441");
  self function_ea8e45a8(0);

  while(true) {
    waitresult = self waittill(#"up", #"down", #"left", #"right", #"shot");
    msg = waitresult._notify;

    if(!isDefined(msg)) {
      continue;
    }

    if(msg == "<dev string:xc73>") {
      self function_92f23bcd(-1);
      continue;
    }

    if(msg == "<dev string:xc79>") {
      self function_92f23bcd(1);
      continue;
    }

    if(msg == "<dev string:xc81>") {
      self function_cdf89a29(1);
      continue;
    }

    if(msg == "<dev string:xc8a>") {
      self function_cdf89a29(-1);
      continue;
    }

    if(msg == "<dev string:xc92>") {
      function_77511c75();
    }
  }
}

function function_92f23bcd(val) {
  self endon(#"letgo");
  function_ea8e45a8(val);
  wait 0.5;

  while(true) {
    function_ea8e45a8(val);
    wait 0.05;
  }
}

function function_ea8e45a8(val) {
  hudelem = self.var_28df7051[self.placementindex];
  hudelem.alpha = 0.5;
  hudelem.fontscale = 1;
  self.placementindex += val;

  if(self.placementindex >= self.var_28df7051.size) {
    self.placementindex = 0;
  } else if(self.placementindex < 0) {
    self.placementindex = self.var_28df7051.size - 1;
  }

  hudelem = self.var_28df7051[self.placementindex];
  hudelem.alpha = 1;
  hudelem.fontscale = 1.3;
}

function function_cdf89a29(val) {
  self endon(#"letgo");
  function_75154360(val);
  wait 0.05;

  while(true) {
    function_75154360(val);
    wait 0.05;
  }
}

function function_5ee4d3a8(inval) {
  tempindex = self.var_5f51d2ee + inval;

  if(tempindex >= level.propindex.size) {
    tempindex = 0;
  } else if(tempindex < 0) {
    tempindex = level.propindex.size - 1;
  }

  self.var_5f51d2ee = tempindex;
}

function function_1eca597a(var_8ba3b403) {
  for(index = 0; index < level.propindex.size; index++) {
    if(level.proplist[level.propindex[index][0]][level.propindex[index][1]].modelname == var_8ba3b403) {
      return index;
    }
  }
}

function function_75154360(val) {
  hudelem = self.var_28df7051[self.placementindex];

  if(hudelem == self.placementmodel) {
    function_5ee4d3a8(val);
    self.prop.info = level.proplist[level.propindex[self.var_5f51d2ee][0]][level.propindex[self.var_5f51d2ee][1]];
    prop_controls::propchangeto(self.prop.info);
    self.placementmodel settext("<dev string:xc9a>" + self.var_5f51d2ee + "<dev string:xca5>" + self.prop.info.modelname);
    self.var_3634d14e settext("<dev string:xcac>" + self.prop.info.propsizetext);
    self.var_a2614669 setvalue(self.prop.info.propsize);
    self.var_5ee5df03 setvalue(self.prop.info.propscale);
    self.var_66df6677 setvalue(self.prop.info.xyzoffset[0]);
    self.var_ec9a93 setvalue(self.prop.info.xyzoffset[1]);
    self.var_811d1afa setvalue(self.prop.info.xyzoffset[2]);
    self.var_d7336ed8 setvalue(self.prop.info.anglesoffset[0]);
    self.var_334e2710 setvalue(self.prop.info.anglesoffset[1]);
    self.var_faa235b5 setvalue(self.prop.info.anglesoffset[2]);
    self.var_35eb52f1 setvalue(self.prop.info.propheight);
    self.var_a2f59097 setvalue(self.prop.info.proprange);
    return;
  }

  if(hudelem == self.var_3634d14e || hudelem == self.var_a2614669) {
    sizes = array("<dev string:xcb6>", "<dev string:xcc0>", "<dev string:xcc9>", "<dev string:xcd3>", "<dev string:xcdc>", "<dev string:xce6>");
    index = 0;

    for(i = 0; i < sizes.size; i++) {
      if(sizes[i] == self.prop.info.propsizetext) {
        index = i;
        break;
      }
    }

    index += val;

    if(index < 0) {
      index = sizes.size - 1;
    } else if(index >= sizes.size) {
      index = 0;
    }

    self.prop.info.propsizetext = sizes[index];
    self.prop.info.propsize = prop::getpropsize(self.prop.info.propsizetext);
    self.var_3634d14e settext("<dev string:xcac>" + self.prop.info.propsizetext);
    self.var_a2614669 setvalue(self.prop.info.propsize);
    self.health = self.prop.info.propsize;
    self.maxhealth = self.health;
    return;
  }

  if(hudelem == self.var_5ee5df03) {
    var_dfa19677 = 0.1;
    var_34b4cc47 = 10;
    var_59913b42 = 0.01;
    self.prop.info.propscale += var_59913b42 * val;
    self.prop.info.propscale = math::clamp(self.prop.info.propscale, var_dfa19677, var_34b4cc47);
    self.prop setscale(self.prop.info.propscale);
    self.var_5ee5df03 setvalue(self.prop.info.propscale);
    return;
  }

  if(hudelem == self.var_66df6677) {
    self.prop unlink();
    self.prop.info.xyzoffset = (self.prop.info.xyzoffset[0] + val, self.prop.info.xyzoffset[1], self.prop.info.xyzoffset[2]);
    self.prop.xyzoffset = self.prop.info.xyzoffset;
    self.var_66df6677 setvalue(self.prop.info.xyzoffset[0]);
    function_c2ab2206();
    return;
  }

  if(hudelem == self.var_ec9a93) {
    self.prop unlink();
    self.prop.info.xyzoffset = (self.prop.info.xyzoffset[0], self.prop.info.xyzoffset[1] + val, self.prop.info.xyzoffset[2]);
    self.prop.xyzoffset = self.prop.info.xyzoffset;
    self.var_ec9a93 setvalue(self.prop.info.xyzoffset[1]);
    function_c2ab2206();
    return;
  }

  if(hudelem == self.var_811d1afa) {
    self.prop unlink();
    self.prop.info.xyzoffset = (self.prop.info.xyzoffset[0], self.prop.info.xyzoffset[1], self.prop.info.xyzoffset[2] + val);
    self.prop.xyzoffset = self.prop.info.xyzoffset;
    self.var_811d1afa setvalue(self.prop.info.xyzoffset[2]);
    function_c2ab2206();
    return;
  }

  if(hudelem == self.var_d7336ed8) {
    self.prop unlink();
    self.prop.info.anglesoffset = (self.prop.info.anglesoffset[0] + val, self.prop.info.anglesoffset[1], self.prop.info.anglesoffset[2]);
    self.prop.anglesoffset = self.prop.info.anglesoffset;
    self.var_d7336ed8 setvalue(self.prop.info.anglesoffset[0]);
    function_c2ab2206();
    return;
  }

  if(hudelem == self.var_334e2710) {
    self.prop unlink();
    self.prop.info.anglesoffset = (self.prop.info.anglesoffset[0], self.prop.info.anglesoffset[1] + val, self.prop.info.anglesoffset[2]);
    self.prop.anglesoffset = self.prop.info.anglesoffset;
    self.var_334e2710 setvalue(self.prop.info.anglesoffset[1]);
    function_c2ab2206();
    return;
  }

  if(hudelem == self.var_faa235b5) {
    self.prop unlink();
    self.prop.info.anglesoffset = (self.prop.info.anglesoffset[0], self.prop.info.anglesoffset[1], self.prop.info.anglesoffset[2] + val);
    self.prop.anglesoffset = self.prop.info.anglesoffset;
    self.var_faa235b5 setvalue(self.prop.info.anglesoffset[2]);
    function_c2ab2206();
    return;
  }

  if(hudelem == self.var_35eb52f1) {
    adjust = 10;
    self.prop.info.propheight += adjust * val;
    self.prop.info.propheight = math::clamp(self.prop.info.propheight, -30, 40);
    self.thirdpersonheightoffset = self.prop.info.propheight;
    self setclientthirdperson(1);
    self.var_35eb52f1 setvalue(self.prop.info.propheight);
    return;
  }

  if(hudelem == self.var_a2f59097) {
    adjust = 10;
    self.prop.info.proprange += adjust * val;
    self.prop.info.proprange = math::clamp(self.prop.info.proprange, 50, 360);
    self.thirdpersonrange = self.prop.info.proprange;
    self setclientthirdperson(1);
    self.var_a2f59097 setvalue(self.prop.info.proprange);
  }
}

function function_c2ab2206() {
  self.prop.origin = self.propent.origin;
  self prop::applyxyzoffset();
  self prop::applyanglesoffset();
  self.prop linkto(self.propent);
}

function function_8d3ffd86() {
  self prop_controls::notifyonplayercommand("<dev string:xc73>", "<dev string:xcf0>");
  self prop_controls::notifyonplayercommand("<dev string:xc79>", "<dev string:xd01>");
  self prop_controls::notifyonplayercommand("<dev string:xc8a>", "<dev string:xd12>");
  self prop_controls::notifyonplayercommand("<dev string:xc81>", "<dev string:xd23>");
  self prop_controls::notifyonplayercommand("<dev string:xd34>", "<dev string:xd3d>");
  self prop_controls::notifyonplayercommand("<dev string:xd34>", "<dev string:xd4e>");
  self prop_controls::notifyonplayercommand("<dev string:xd34>", "<dev string:xd5f>");
  self prop_controls::notifyonplayercommand("<dev string:xd34>", "<dev string:xd70>");
  self prop_controls::notifyonplayercommand("<dev string:xc92>", "<dev string:xd81>");
  self prop_controls::notifyonplayercommand("<dev string:xd8c>", "<dev string:xd97>");
  self prop_controls::notifyonplayercommand("<dev string:xda3>", "<dev string:xdad>");
  self prop_controls::notifyonplayercommand("<dev string:xda3>", "<dev string:xdbb>");
}

function function_cc5afb75() {
  self prop_controls::notifyonplayercommandremove("<dev string:xc73>", "<dev string:xcf0>");
  self prop_controls::notifyonplayercommandremove("<dev string:xc79>", "<dev string:xd01>");
  self prop_controls::notifyonplayercommandremove("<dev string:xc8a>", "<dev string:xd12>");
  self prop_controls::notifyonplayercommandremove("<dev string:xc81>", "<dev string:xd23>");
  self prop_controls::notifyonplayercommandremove("<dev string:xd34>", "<dev string:xd3d>");
  self prop_controls::notifyonplayercommandremove("<dev string:xd34>", "<dev string:xd4e>");
  self prop_controls::notifyonplayercommandremove("<dev string:xd34>", "<dev string:xd5f>");
  self prop_controls::notifyonplayercommandremove("<dev string:xd34>", "<dev string:xd70>");
  self prop_controls::notifyonplayercommandremove("<dev string:xc92>", "<dev string:xd81>");
  self prop_controls::notifyonplayercommandremove("<dev string:xd8c>", "<dev string:xd97>");
  self prop_controls::notifyonplayercommandremove("<dev string:xda3>", "<dev string:xdad>");
  self prop_controls::notifyonplayercommandremove("<dev string:xda3>", "<dev string:xdbb>");
}

function function_cbef3d63(vec) {
  return isDefined(vec) && (vec[0] != 0 || vec[1] != 0 || vec[2] != 0);
}

function function_a840713e(propinfo) {
  return isDefined(propinfo.propheight) && propinfo.propheight != prop::getthirdpersonheightoffsetforsize(propinfo.propsize);
}

function function_7a3672a6(propinfo) {
  return isDefined(propinfo.proprange) && propinfo.proprange != prop::getthirdpersonrangeforsize(propinfo.propsize);
}

function function_2dc5c497(file, propinfo) {
  propstr = "<dev string:xdc8>" + propinfo.modelname + "<dev string:xdcc>" + propinfo.propsizetext + "<dev string:xdcc>" + propinfo.propscale;

  if(function_cbef3d63(propinfo.xyzoffset)) {
    propstr += "<dev string:xdcc>" + propinfo.xyzoffset[0] + "<dev string:xdcc>" + propinfo.xyzoffset[1] + "<dev string:xdcc>" + propinfo.xyzoffset[2];
  } else {
    propstr += "<dev string:xdd1>";
  }

  if(function_cbef3d63(propinfo.anglesoffset)) {
    propstr += "<dev string:xdcc>" + propinfo.anglesoffset[0] + "<dev string:xdcc>" + propinfo.anglesoffset[1] + "<dev string:xdcc>" + propinfo.anglesoffset[2];
  } else {
    propstr += "<dev string:xdd1>";
  }

  if(function_a840713e(propinfo)) {
    propstr += "<dev string:xdcc>" + propinfo.propheight;
  } else {
    propstr += "<dev string:xdcc>" + prop::getthirdpersonheightoffsetforsize(propinfo.propsize);
  }

  if(function_7a3672a6(propinfo)) {
    propstr += "<dev string:xdcc>" + propinfo.proprange;
  } else {
    propstr += "<dev string:xdcc>" + prop::getthirdpersonrangeforsize(propinfo.propsize);
  }

  fprintln(file, propstr);
}

function function_8639a7b0(file, propinfo) {
  propstr = "<dev string:xddb>" + propinfo.modelname + "<dev string:xdf4>";
  fprintln(file, propstr);
}

function function_62b9b9ac(file, propsizetext) {
  foreach(sizetype in level.proplist) {
    foreach(propinfo in sizetype) {
      if(propinfo.propsizetext == propsizetext) {
        function_2dc5c497(file, propinfo);
      }
    }
  }
}

function plaza_dom_point_neutral_b_secured(file, propsizetext) {
  foreach(sizetype in level.proplist) {
    foreach(propinfo in sizetype) {
      if(propinfo.propsizetext == propsizetext) {
        function_8639a7b0(file, propinfo);
      }
    }
  }
}

function function_79d57521(file, var_7723a9cd) {
  var_7e52c89c = var_7723a9cd + "<dev string:xdfc>";
  var_44c49e4e = var_7723a9cd + "<dev string:xe04>";
  var_473e8b8d = var_7723a9cd + "<dev string:xe0c>";
  var_ca180226 = level.script + "<dev string:xe15>";
  var_19494914 = level.script + "<dev string:xe1e>";
  var_155d523d = "<dev string:xe26>";
  var_7770e500 = "<dev string:xe42>";
  var_d6ade535 = "<dev string:xe61>";
  fprintln(file, "<dev string:xe88>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:xf31>");
  fprintln(file, "<dev string:xf3c>" + var_7e52c89c + "<dev string:xf56>");
  fprintln(file, "<dev string:xf6b>" + var_44c49e4e + "<dev string:xf56>");
  fprintln(file, "<dev string:xf85>" + var_473e8b8d + "<dev string:xf9b>" + var_155d523d);
  fprintln(file, "<dev string:xfa3>" + var_7e52c89c + "<dev string:xf9b>" + var_d6ade535);
  fprintln(file, "<dev string:xfb9>" + var_44c49e4e + "<dev string:xf9b>" + var_7770e500);
  fprintln(file, "<dev string:xfcf>");
  fprintln(file, "<dev string:xff3>" + var_ca180226 + "<dev string:x1011>" + var_7723a9cd);
  fprintln(file, "<dev string:x101f>" + var_19494914 + "<dev string:x103d>" + var_44c49e4e + "<dev string:x1056>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x105b>");
  fprintln(file, "<dev string:xdc8>");
}

function function_cb8ecc99() {
  platform = "<dev string:x108e>";

  if(level.orbis) {
    platform = "<dev string:x1094>";
  } else if(level.durango) {
    platform = "<dev string:x109d>";
  }

  var_7723a9cd = level.script + "<dev string:x10a8>";
  var_7e52c89c = var_7723a9cd + "<dev string:xdfc>";
  var_b522696f = "<dev string:x10af>" + platform + "<dev string:x10b8>";
  var_d6ade535 = "<dev string:xe61>";
  file = openfile(var_7e52c89c, "<dev string:x10c8>");

  if(file == -1) {
    iprintlnbold("<dev string:x10d1>" + var_b522696f + var_7e52c89c + "<dev string:x10e7>");
    println("<dev string:x10d1>" + var_b522696f + var_7e52c89c + "<dev string:x10e7>");
    return;
  }

  function_79d57521(file, var_7723a9cd);
  fprintln(file, "<dev string:x10f7>");
  function_62b9b9ac(file, "<dev string:xcb6>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x110d>");
  function_62b9b9ac(file, "<dev string:xcc0>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x111d>");
  function_62b9b9ac(file, "<dev string:xcc9>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x112e>");
  function_62b9b9ac(file, "<dev string:xcd3>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x113e>");
  function_62b9b9ac(file, "<dev string:xcdc>");
  iprintlnbold("<dev string:x1154>" + var_b522696f + var_7e52c89c + "<dev string:x115e>" + var_d6ade535);
  println("<dev string:x1154>" + var_b522696f + var_7e52c89c + "<dev string:x115e>" + var_d6ade535);
  closefile(file);
}

function function_2b23b2b6() {
  platform = "<dev string:x108e>";

  if(level.orbis) {
    platform = "<dev string:x1094>";
  } else if(level.durango) {
    platform = "<dev string:x109d>";
  }

  var_7723a9cd = level.script + "<dev string:x10a8>";
  var_7e52c89c = var_7723a9cd + "<dev string:xe04>";
  var_b522696f = "<dev string:x10af>" + platform + "<dev string:x10b8>";
  var_d6ade535 = "<dev string:xe42>";
  file = openfile(var_7e52c89c, "<dev string:x10c8>");

  if(file == -1) {
    iprintlnbold("<dev string:x10d1>" + var_b522696f + var_7e52c89c + "<dev string:x10e7>");
    println("<dev string:x10d1>" + var_b522696f + var_7e52c89c + "<dev string:x10e7>");
    return;
  }

  fprintln(file, "<dev string:x116c>");
  plaza_dom_point_neutral_b_secured(file, "<dev string:xcb6>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x1184>");
  plaza_dom_point_neutral_b_secured(file, "<dev string:xcc0>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x1196>");
  plaza_dom_point_neutral_b_secured(file, "<dev string:xcc9>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x11a9>");
  plaza_dom_point_neutral_b_secured(file, "<dev string:xcd3>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x11bb>");
  plaza_dom_point_neutral_b_secured(file, "<dev string:xcdc>");
  iprintlnbold("<dev string:x1154>" + var_b522696f + var_7e52c89c + "<dev string:x115e>" + var_d6ade535);
  println("<dev string:x1154>" + var_b522696f + var_7e52c89c + "<dev string:x115e>" + var_d6ade535);
  closefile(file);
}

function function_f2e19297() {
  platform = "<dev string:x108e>";

  if(level.orbis) {
    platform = "<dev string:x1094>";
  } else if(level.durango) {
    platform = "<dev string:x109d>";
  }

  var_7723a9cd = level.script + "<dev string:x10a8>";
  var_7e52c89c = var_7723a9cd + "<dev string:xdfc>";
  var_44c49e4e = var_7723a9cd + "<dev string:xe04>";
  var_473e8b8d = var_7723a9cd + "<dev string:xe0c>";
  var_ca180226 = level.script + "<dev string:xe15>";
  var_19494914 = level.script + "<dev string:xe1e>";
  var_b522696f = "<dev string:x10af>" + platform + "<dev string:x10b8>";
  var_155d523d = "<dev string:xe26>";
  var_7770e500 = "<dev string:xe42>";
  var_d6ade535 = "<dev string:xe61>";
  file = openfile(var_7e52c89c, "<dev string:x10c8>");

  if(file == -1) {
    iprintlnbold("<dev string:x10d1>" + var_b522696f + var_7e52c89c + "<dev string:x10e7>");
    println("<dev string:x10d1>" + var_b522696f + var_7e52c89c + "<dev string:x10e7>");
    return;
  }

  function_79d57521(file, var_7723a9cd);
  fprintln(file, "<dev string:x10f7>");
  fprintln(file, "<dev string:x11d3>");
  fprintln(file, "<dev string:x11d3>");
  fprintln(file, "<dev string:x11d3>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x110d>");
  fprintln(file, "<dev string:x11ef>");
  fprintln(file, "<dev string:x11ef>");
  fprintln(file, "<dev string:x11ef>");
  fprintln(file, "<dev string:x11ef>");
  fprintln(file, "<dev string:x11ef>");
  fprintln(file, "<dev string:x11ef>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x111d>");
  fprintln(file, "<dev string:x1209>");
  fprintln(file, "<dev string:x1209>");
  fprintln(file, "<dev string:x1209>");
  fprintln(file, "<dev string:x1209>");
  fprintln(file, "<dev string:x1209>");
  fprintln(file, "<dev string:x1209>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x112e>");
  fprintln(file, "<dev string:x1225>");
  fprintln(file, "<dev string:x1225>");
  fprintln(file, "<dev string:x1225>");
  fprintln(file, "<dev string:x1225>");
  fprintln(file, "<dev string:x1225>");
  fprintln(file, "<dev string:x1225>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x113e>");
  fprintln(file, "<dev string:x123f>");
  fprintln(file, "<dev string:x123f>");
  fprintln(file, "<dev string:x123f>");
  closefile(file);
  file = openfile(var_44c49e4e, "<dev string:x10c8>");

  if(file == -1) {
    iprintlnbold("<dev string:x10d1>" + var_b522696f + var_44c49e4e + "<dev string:x10e7>");
    println("<dev string:x10d1>" + var_b522696f + var_44c49e4e + "<dev string:x10e7>");
    return;
  }

  fprintln(file, "<dev string:x116c>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x1184>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x1196>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x11a9>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:xdc8>");
  fprintln(file, "<dev string:x11bb>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  fprintln(file, "<dev string:x1260>");
  closefile(file);
  file = openfile(var_473e8b8d, "<dev string:x10c8>");

  if(file == -1) {
    iprintlnbold("<dev string:x10d1>" + var_b522696f + var_473e8b8d + "<dev string:x10e7>");
    println("<dev string:x10d1>" + var_b522696f + var_473e8b8d + "<dev string:x10e7>");
    return;
  }

  fprintln(file, "<dev string:x127d>" + var_7e52c89c);
  fprintln(file, "<dev string:x12a0>" + var_44c49e4e);
  closefile(file);
  iprintlnbold("<dev string:x12b7>" + var_b522696f);
  println("<dev string:x12b7>" + var_b522696f);
}

function function_77511c75() {
  player = level.players[0];

  if(!isDefined(player) || !isalive(player) || !is_true(player.hasspawned)) {
    return;
  }

  if(isDefined(level.players[1])) {
    enemybot = level.players[1];
  } else {
    enemybot = bot::add_bot(util::getotherteam(player.team));
    enemybot.ignoreall = 1;
    enemybot bot::function_bab12815(enemybot.origin);
  }

  if(!isDefined(enemybot.pers[# "participation"])) {
    enemybot.pers[# "participation"] = 0;
  }

  if(!isDefined(enemybot.hits)) {
    enemybot.hits = 0;
  }

  player.health = player.maxhealth;
  weapon = getweapon("<dev string:x12d1>");
  end = player.origin;
  dir = anglesToForward(player.angles);
  start = end + dir * 100 + (0, 0, 30);
  magicbullet(weapon, start, end, enemybot);
  dirback = -1 * dir;
  start = end + dirback * 100 + (0, 0, 30);
  magicbullet(weapon, start, end, enemybot);
  dirright = anglestoright(player.angles);
  start = end + dirright * 100 + (0, 0, 30);
  magicbullet(weapon, start, end, enemybot);
  dirleft = -1 * dirright;
  start = end + dirleft * 100 + (0, 0, 30);
  magicbullet(weapon, start, end, enemybot);
  start = end + (0, 0, 100);
  magicbullet(weapon, start, end, enemybot);
  player waittilltimeout(0.3, #"damage");
  wait 0.05;
  player.health = player.maxhealth;
}

function showhealth() {
  if(!isDefined(level.players)) {
    return;
  }

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.team) && player.team == game.defenders) {
      print3d(player.origin + (0, 0, 50), "<dev string:xdc8>" + player.health);
    }
  }
}

function function_34a7562e() {
  if(!isDefined(level.players)) {
    return;
  }

  foreach(player in level.players) {
    velocity = player getvelocity();
    var_a79358cf = (velocity[0], velocity[1], 0);
    speed = length(var_a79358cf);
    print3d(player.origin + (0, 0, 50), "<dev string:xdc8>" + speed);
  }
}

function function_38964c72() {
  if(!isDefined(level.players)) {
    return;
  }

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.prop)) {
      player prop_controls::get_ground_normal(player.prop, 1);
    }
  }
}

function function_ed0598d(propinfo, origin, angles) {
  propent = spawn("<dev string:x12e4>", origin);
  propent setcontents(0);
  propent notsolid();
  propent setplayercollision(0);
  prop = spawn("<dev string:x12e4>", propent.origin);
  prop.angles = angles;
  prop setModel(propinfo.modelname);
  prop setscale(propinfo.propscale);
  prop setCanDamage(1);
  prop.xyzoffset = propinfo.xyzoffset;
  prop.anglesoffset = propinfo.anglesoffset;
  prop.health = 1;
  prop setplayercollision(0);
  forward = anglesToForward(angles) * prop.xyzoffset[0];
  right = anglestoright(angles) * prop.xyzoffset[1];
  up = anglestoup(angles) * prop.xyzoffset[2];
  prop.origin += forward;
  prop.origin += right;
  prop.origin += up;
  prop.angles += prop.anglesoffset;
  prop linkto(propent);
  propent.prop = prop;
  propent.propinfo = propinfo;
  return propent;
}

function showmodels() {
  player = level.players[0];
  angles = player.angles;
  dir = anglesToForward(angles);
  startorigin = player.origin + (0, 0, 100);
  origin = startorigin;

  if(!isDefined(level.var_98714fa7)) {
    level.var_98714fa7 = [];

    foreach(category in level.proplist) {
      foreach(propinfo in category) {
        level.var_98714fa7[level.var_98714fa7.size] = function_ed0598d(propinfo, origin, angles);
        origin += dir * 60;
      }
    }
  } else {
    level notify(#"hash_23283189fad4c217");

    foreach(propent in level.var_98714fa7) {
      propent.origin = origin;
      origin += dir * 60;
    }
  }

  level thread function_bd50e1aa(startorigin, dir, 60, level.var_98714fa7.size);
}

function function_bd50e1aa(startorigin, fwd, modeldist, var_aba10381) {
  level endon(#"hash_23283189fad4c217");
  var_610d90b1 = fwd * modeldist;
  left = (fwd[1] * -1, fwd[0], 0);
  leftoffset = left * modeldist;
  upoffset = (0, 0, 1) * modeldist;

  while(true) {
    origin = startorigin;

    for(i = 0; i < var_aba10381; i++) {
      line(origin, origin + leftoffset, (0, 1, 0));
      line(origin, origin + upoffset, (0, 0, 1));
      origin += var_610d90b1;
    }

    line(startorigin, origin, (1, 0, 0));
    waitframe(1);
  }
}

function function_1f3923fa() {
  if(!isDefined(level.var_f8f7808e)) {
    return;
  }

  color = (0, 1, 0);

  if(!level.var_f8f7808e.success) {
    color = (1, 0, 0);
  }

  print3d(level.var_f8f7808e.playerorg + (0, 0, 50), level.var_f8f7808e.type);
  box(level.var_f8f7808e.playerorg, level.var_f8f7808e.playermins, level.var_f8f7808e.playermaxs, level.var_f8f7808e.playerangles[1], color);

  if(isDefined(level.var_f8f7808e.origin1)) {
    sphere(level.var_f8f7808e.origin1, 5, color);
    line(level.var_f8f7808e.playerorg, level.var_f8f7808e.origin1);

    if(isDefined(level.var_f8f7808e.text1)) {
      print3d(level.var_f8f7808e.origin1 + (0, 0, -10), level.var_f8f7808e.text1);
    }
  }

  if(isDefined(level.var_f8f7808e.origin2)) {
    sphere(level.var_f8f7808e.origin2, 5, color);
    line(level.var_f8f7808e.playerorg, level.var_f8f7808e.origin2);

    if(isDefined(level.var_f8f7808e.text2)) {
      print3d(level.var_f8f7808e.origin2 + (0, 0, 10), level.var_f8f7808e.text2);
    }
  }

  if(isDefined(level.var_f8f7808e.origin3)) {
    sphere(level.var_f8f7808e.origin3, 5, color);
    line(level.var_f8f7808e.playerorg, level.var_f8f7808e.origin3);

    if(isDefined(level.var_f8f7808e.text3)) {
      print3d(level.var_f8f7808e.origin3 + (0, 0, 30), level.var_f8f7808e.text3);
    }
  }
}

function function_cded003e(propinfo, origin, angles, team) {
  var_6e55957c = spawn("<dev string:x12e4>", origin);
  var_6e55957c.targetname = "<dev string:x12f4>";
  var_6e55957c setModel(propinfo.modelname);
  var_6e55957c setscale(propinfo.propscale);
  var_6e55957c.angles = angles;
  var_6e55957c setCanDamage(1);
  var_6e55957c.fakehealth = 50;
  var_6e55957c.health = 99999;
  var_6e55957c.maxhealth = 99999;
  var_6e55957c thread prop::function_aa8db165(&prop_controls::damageclonewatch);
  var_6e55957c setplayercollision(0);
  var_6e55957c makesentient();
  var_6e55957c setteam(team);
}

function function_5646cd5c() {
  player = level.players[0];
  angles = player.angles;
  dir = anglesToForward(angles);
  origin = player.origin + (0, 0, 100);

  if(isDefined(level.var_2ebdcb74)) {
    foreach(clone in level.var_2ebdcb74) {
      clone prop_controls::function_d1a1cc8d();
    }
  }

  level.var_2ebdcb74 = [];

  foreach(category in level.proplist) {
    foreach(propinfo in category) {
      level.var_2ebdcb74[level.var_2ebdcb74.size] = function_cded003e(propinfo, origin, angles, util::getotherteam(player.team));
      origin += dir * 60;
    }
  }
}

function function_5e0d41c4() {
  player = level.players[0];
  angles = player.angles;
  dir = anglesToForward(angles);
  origin = player.origin + dir * (0, 0, 100);
  propinfo = prop::getnextprop(player);

  if(!isDefined(level.var_2ebdcb74)) {
    level.var_2ebdcb74 = [];
  }

  level.var_2ebdcb74[level.var_2ebdcb74.size] = function_cded003e(propinfo, origin, angles, util::getotherteam(player.team));
}

function showplayers() {
  if(!isDefined(level.players)) {
    return;
  }

  foreach(player in level.players) {
    box(player.origin, player getmins(), player getmaxs(), player.angles[1], (1, 0, 1), 1, 0, 1);
  }
}

function showtargets() {
  if(!isDefined(level.var_1103f74e) || !isDefined(level.var_1103f74e.targets)) {
    return;
  }

  for(i = 0; i < level.var_1103f74e.targets.size; i++) {
    target = level.var_1103f74e.targets[i];

    if(isDefined(target)) {
      print3d(target.origin + (0, 0, 30), "<dev string:xdc8>" + target.fakehealth);
    }
  }
}