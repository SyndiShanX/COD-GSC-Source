/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_239a365a92ee4476.gsc
*************************************************/

#using script_239a365a92ee4476;
#using script_254c2e2a2c8207f8;
#using script_2f981f68661d5e1a;
#using script_32d93a194074fa6a;
#using script_35ee5e2cef30eea2;
#using script_3f3c7170aedfefd7;
#using script_458ce44388c14a5f;
#using script_45e6947be98e16e3;
#using script_47a7dd805c87b33f;
#using script_4bcf78b337139620;
#using script_5693b37bfb748170;
#using script_5961052449eb875f;
#using script_5dfa1fb6b030bdcb;
#using script_61565a6c1fdee6ac;
#using script_6981400abfcd765c;
#using script_89c4e8e66e8a360;
#using script_b5c3028255f05a7;
#using script_c7a00602fb8e464;
#using scripts\common\callbacks;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\matchdata;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\outline;
#namespace namespace_aa716418c1d2615b;

function init(datacallback, var_df2617dcbc6d5b8a, var_6a00940e598a7d11, playertriggercallback) {
  function_a63069a72c46f64b();
  level function_fa1f5f6731df7fea(datacallback);
  level function_f450e760a53ca63c();
  level function_2195503b0dcc12c0();
  function_527525c448469681();
  level.var_305547d6de59eba4.var_df2617dcbc6d5b8a = var_df2617dcbc6d5b8a;
  level.var_305547d6de59eba4.var_6a00940e598a7d11 = var_6a00940e598a7d11;
  scripts\common\callbacks::add("player_connect", &onplayerconnect);
  scripts\common\callbacks::add("player_disconnect", &onplayerdisconnect);

  if(isDefined(playertriggercallback)) {
    scripts\engine\utility::registersharedfunc("ftue", "player_action", playertriggercallback);
  }

  level thread function_65cb702777c34d77();
  level thread function_e72755ab509c1ff();
}

function function_b4641ae08979f8ce(var_13df2b3b7465aad6) {
  return level.var_8205621341adedc4[var_13df2b3b7465aad6];
}

function function_c80cf062684cdfe0(var_fe24673a87802a11) {
  return level.var_13036c7f57466667[var_fe24673a87802a11];
}

function function_527525c448469681() {
  level endon("game_ended");

  if(!isDefined(level.onluieventcallbacks)) {
    level waittill("lui_game_event_aggregator_initialized");
  }

  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&function_610c9eb4d045c9dd);
}

function function_610c9eb4d045c9dd(event, value) {
  assert(isPlayer(self));

  if(isDefined(event) && event == "ftue_tips_disabled" && isDefined(value)) {
    var_3bad092c1eda5eb8 = !value;

    if(self.var_fa35b4a136b27acd != var_3bad092c1eda5eb8) {
      if(var_3bad092c1eda5eb8) {
        function_b31b9bd488f22795();
        return;
      }

      function_c5767fa4c9380ff2(0);
    }
  }
}

function function_fa1f5f6731df7fea(datacallback) {
  level.var_305547d6de59eba4 = spawnStruct();
  level.var_305547d6de59eba4.var_1a60753f1ce4e8a4 = 1000;
  level.var_305547d6de59eba4.contextualtips = [];
  level.var_305547d6de59eba4.var_daba424d7f945348 = [];
  level.var_305547d6de59eba4.var_da1e4ded7db0b78 = [];
  function_effec5e680d95771();
  level function_8a4307513b99d156(datacallback);
  level.ftuedata = spawnStruct();
}

function function_758312d1e1139963() {
  allcompleted = 1;
  var_d1ea81d97408f0c2 = 0;

  foreach(key, var_ff0f9c5ebef8424e in level.var_305547d6de59eba4.contextualtips) {
    completed = function_5f50ae7bff599e0a(function_b4641ae08979f8ce(key));
    self.var_657f5a0d17435bc.completed[key] = completed;

    if(completed) {
      var_d1ea81d97408f0c2++;
      continue;
    }

    allcompleted = 0;
  }

  self.var_657f5a0d17435bc.var_876a294e1e939f4d = var_d1ea81d97408f0c2;
  return allcompleted;
}

function function_916a7d987cfa6bce() {
  var_7f58749063130ffb = self.var_bab8a83285b78528;
  assertex(isDefined(var_7f58749063130ffb), "<dev string:x1c>");

  foreach(key, var_ff0f9c5ebef8424e in level.var_305547d6de59eba4.contextualtips) {
    assertex(isDefined(var_ff0f9c5ebef8424e.var_2297e189e2eb2818), "<dev string:x3d>");

    if(!array_contains(var_ff0f9c5ebef8424e.var_2297e189e2eb2818, -1) && !array_contains(var_ff0f9c5ebef8424e.var_2297e189e2eb2818, var_7f58749063130ffb)) {
      var_e775591921435ac7 = array_find(level.var_305547d6de59eba4.var_6d061cc60360cf78, key);
      level.var_305547d6de59eba4.var_6d061cc60360cf78 = array_remove_index(level.var_305547d6de59eba4.var_6d061cc60360cf78, var_e775591921435ac7);
    }
  }
}

function function_b31b9bd488f22795() {
  function_5135b05917b91c1b();
  function_d76dfcaf4583e859();
}

function function_c5767fa4c9380ff2(disconnect) {
  level.var_25faa96ef77837a6 = array_remove(level.var_25faa96ef77837a6, self);
  level.var_75dbbfeb5401a7f2 = array_remove(level.var_75dbbfeb5401a7f2, self);

  if(!disconnect && istrue(self.var_fa35b4a136b27acd)) {
    function_6fba31415caeee6e(0);
    self notify("currentContextualTipAborted");
    self notify("contextual_tips_disable");
    self.var_fa35b4a136b27acd = 0;
  }
}

function private onplayerconnect(player) {
  function_b31b9bd488f22795();
}

function private onplayerdisconnect(player) {
  function_c5767fa4c9380ff2(1);
}

function private function_d76dfcaf4583e859() {
  if(isbot(self)) {
    return;
  }

  self.var_fa35b4a136b27acd = function_3fa91b90ba5753e7();

  if(!self.var_fa35b4a136b27acd) {
    return;
  }

  if(isDefined(level.var_305547d6de59eba4.var_df2617dcbc6d5b8a)) {
    tipsenabled = self[[level.var_305547d6de59eba4.var_df2617dcbc6d5b8a]]();
  } else {
    tipsenabled = 1;
  }

  if(tipsenabled) {
    function_c82a99fb9823b6e8();
    return;
  }

  self.var_fa35b4a136b27acd = 0;
}

function private function_c82a99fb9823b6e8() {
  function_724de61c03c5baff(level.var_305547d6de59eba4.var_6a00940e598a7d11);
  thread playerendgame();
}

function function_a73346037eb9b85f() {
  playedmatches = function_da8cf8dbdb763ae() + 1;
  namespace_b4dcb4af7024df52::function_86403e1b6ec0b2f6(playedmatches);
}

function function_724de61c03c5baff(var_6a00940e598a7d11) {
  self.var_657f5a0d17435bc = spawnStruct();
  self.var_657f5a0d17435bc.completed = [];
  self.var_657f5a0d17435bc.manualtips = [];
  self.var_657f5a0d17435bc.var_5eb1da668993b439 = [];
  self.var_657f5a0d17435bc.cooldown = 0;
  allcompleted = function_758312d1e1139963();

  if(allcompleted) {
    return;
  }

  self[[var_6a00940e598a7d11]]();
  function_8c7eb4bb28ae167f();
  function_7a1391f264af1243();
  function_916a7d987cfa6bce();
  function_8385f0514b5f730d();
  level scripts\common\ui::lui_registercallback("force_tooltip_execute", &function_1e5c3c919d3f771d);
  level thread function_afa2648d14d6b66d(self);
}

function private playerendgame() {
  self endon("disconnect");
  childthread function_ea69eecec1a8fd38();
  waittill_any_return_2("br_player_aar_data_set", "disconnect");
  onendgame();
}

function private onendgame() {
  assert(isPlayer(self));
  matchtime = gettime();
  matchtime = scripts\mp\matchdata::gettimefrommatchstart(matchtime) * 0.001;
  matchtime = int(matchtime);
  function_2f80e3ca1b2374a(matchtime);
  playedmatches = function_312e1babffbdf863();
  function_5b53803303e63eb(playedmatches, 0);
}

function function_1e5c3c919d3f771d(var_fe24673a87802a11) {
  level endon("game_ended");
  self endon("disconnect");

  if(self.var_657f5a0d17435bc.var_5e4d29a54d7eddf6 != "") {
    function_7fd621b8ba80e652();
    self notify("currentContextualTipAborted");
    waitframe();
  }

  var_8852bfb815524d4b = function_c80cf062684cdfe0(var_fe24673a87802a11);
  childthread function_58c9ac5c1aad6962(var_8852bfb815524d4b);
  self.var_657f5a0d17435bc.var_d445aab904364ee1 = 1;
  self waittill("currentContextualTipCompleted");
  self.var_657f5a0d17435bc.var_d445aab904364ee1 = 0;
}

function function_6df0c3efd3b8a03a() {
  foreach(tipkey, var_ff0f9c5ebef8424e in level.var_305547d6de59eba4.contextualtips) {
    if(istrue(var_ff0f9c5ebef8424e.var_c6228a01683251ae) && !self.var_657f5a0d17435bc.completed[tipkey]) {
      return true;
    }
  }

  return false;
}

function function_43c745bc0c2a589e() {
  foreach(tipkey, var_ff0f9c5ebef8424e in level.var_305547d6de59eba4.contextualtips) {
    if(istrue(var_ff0f9c5ebef8424e.var_bce08f4be4261bc4) && !self.var_657f5a0d17435bc.completed[tipkey]) {
      return true;
    }
  }

  return false;
}

function function_8c7eb4bb28ae167f() {
  self.var_bab8a83285b78528 = function_7fbc76f1aefc8fc5();
}

function function_afa2648d14d6b66d(player) {
  level endon("game_ended");
  player endon("disconnect");

  if(!istrue(player.hasspawned)) {
    player waittill("spawned_player");
  }

  wait 1;
  level.var_25faa96ef77837a6[level.var_25faa96ef77837a6.size] = player;
  player.var_657f5a0d17435bc.var_43c745bc0c2a589e = player function_43c745bc0c2a589e();
  player.var_657f5a0d17435bc.var_6df0c3efd3b8a03a = player function_6df0c3efd3b8a03a();

  if(player.var_657f5a0d17435bc.var_43c745bc0c2a589e || player.var_657f5a0d17435bc.var_6df0c3efd3b8a03a) {
    level.var_75dbbfeb5401a7f2[level.var_75dbbfeb5401a7f2.size] = player;
  }

  level notify("contextual_tip_player_add", player);
}

function function_20583ec6c1cfdd93() {
  waitframe();
  level.var_bbbddef448c9120 = scripts\mp\gamelogic::inprematch();
}

function function_65cb702777c34d77() {
  level endon("game_ended");
  level.var_25faa96ef77837a6 = [];
  level.var_75dbbfeb5401a7f2 = [];
  maxprocess = getdvarint(@ "hash_86e71750892089c8", 3);

  while(true) {
    function_20583ec6c1cfdd93();
    currenttime = gettime();
    processcount = 0;

    foreach(player in level.var_25faa96ef77837a6) {
      if(!isDefined(player)) {
        continue;
      }

      if(player function_c8c26fd2dd1719c6(currenttime)) {
        processcount++;
      }

      if(maxprocess > 0 && processcount >= maxprocess) {
        processcount = 0;
        function_20583ec6c1cfdd93();
      }
    }
  }
}

function function_83423a80381525e1(typemask) {
  self.nearbyenemies = undefined;
  self.var_ffddba74f404a30 = undefined;
  self.var_8f1c3552aeddaffe = undefined;
  var_7e077fa00d63d26e = self.var_657f5a0d17435bc.var_43c745bc0c2a589e;
  var_1dc18d3dd37ac5ea = self.var_657f5a0d17435bc.var_6df0c3efd3b8a03a;

  if(!var_7e077fa00d63d26e && !var_1dc18d3dd37ac5ea) {
    return false;
  }

  nearbyenemies = [];
  var_ffddba74f404a30 = [];
  var_8f1c3552aeddaffe = [];
  origin = self.origin;
  assert(-1);
  assert(-1);
  ents = function_b1eef70090b5b7b5(origin, 2755, typemask, [self]);

  foreach(checkplayer in ents) {
    if(!isDefined(checkplayer)) {
      continue;
    }

    isally = isalliedsentient(checkplayer, self);

    if(isally && var_7e077fa00d63d26e && distancesquared(checkplayer.origin, origin) <= 1000000) {
      var_ffddba74f404a30[var_ffddba74f404a30.size] = checkplayer;
      continue;
    }

    if(!isally && var_1dc18d3dd37ac5ea) {
      nearbyenemies[nearbyenemies.size] = checkplayer;
    }
  }

  if(nearbyenemies.size != 0) {
    self.nearbyenemies = nearbyenemies;
  }

  if(var_ffddba74f404a30.size != 0) {
    self.var_ffddba74f404a30 = var_ffddba74f404a30;
  }

  if(var_7e077fa00d63d26e) {
    var_8f1c3552aeddaffe = [];

    foreach(checkplayer in level.players) {
      if(isDefined(checkplayer) && checkplayer != self && isalliedsentient(checkplayer, self)) {
        var_8f1c3552aeddaffe[var_8f1c3552aeddaffe.size] = checkplayer;
      }
    }

    if(var_8f1c3552aeddaffe.size != 0) {
      self.var_8f1c3552aeddaffe = var_8f1c3552aeddaffe;
    }
  }

  return true;
}

function function_e72755ab509c1ff() {
  level endon("game_ended");
  updatetime = 1000 * getdvarint(@ "hash_1da7540b953c3277", 2);
  maxprocess = getdvarint(@ "hash_661fbc0e07f4c8bf", 3);
  typemask = function_869ccb4e3451b8c6(["etype_player"]);

  if(level.var_75dbbfeb5401a7f2.size == 0) {
    level waittill("contextual_tip_player_add");
  }

  while(true) {
    waitframe();
    searchsize = level.var_75dbbfeb5401a7f2.size;
    starttime = gettime();
    searchplayers = [];
    processcount = 0;

    foreach(player in level.var_75dbbfeb5401a7f2) {
      if(!isDefined(player)) {
        continue;
      }

      if(player function_83423a80381525e1(typemask)) {
        processcount++;
        searchplayers[searchplayers.size] = player;
      }

      if(maxprocess > 0 && processcount >= maxprocess) {
        processcount = 0;
        waitframe();
      }
    }

    level.var_75dbbfeb5401a7f2 = searchplayers;
    endtime = gettime();
    deltatime = endtime - starttime;

    if(deltatime < updatetime) {
      waittime = (updatetime - deltatime) / 1000;
      wait waittime;
    }
  }
}

function private function_64737a1614d07378() {
  self.var_f64605f38a1c7a57 = function_abfe9a8803709579();
}

function function_20363b93250e08bf(var_a97126fc869f6512) {
  var_6dfdd7d9bcd52f7 = self.var_657f5a0d17435bc.manualtips[0];

  if(isDefined(var_a97126fc869f6512)) {
    if(isDefined(var_6dfdd7d9bcd52f7)) {
      manualtip = level.var_305547d6de59eba4.contextualtips[var_6dfdd7d9bcd52f7];
      launchtip = level.var_305547d6de59eba4.contextualtips[var_a97126fc869f6512];

      if(launchtip.priority <= manualtip.priority) {
        var_a97126fc869f6512 = var_6dfdd7d9bcd52f7;
        self.var_657f5a0d17435bc.manualtips = array_remove_index(self.var_657f5a0d17435bc.manualtips, 0);
      }
    }
  } else if(isDefined(var_6dfdd7d9bcd52f7)) {
    var_a97126fc869f6512 = var_6dfdd7d9bcd52f7;
    self.var_657f5a0d17435bc.manualtips = array_remove_index(self.var_657f5a0d17435bc.manualtips, 0);
  } else {
    return false;
  }

  childthread function_f3942ee6819263f5(var_a97126fc869f6512);
  return true;
}

function function_c8c26fd2dd1719c6(processtime) {
  if(!function_e4d0f9efe9c2bca1()) {
    return false;
  }

  if(isDefined(self.var_657f5a0d17435bc.var_5e4d29a54d7eddf6)) {
    return false;
  }

  if(self.var_657f5a0d17435bc.cooldown > processtime) {
    return false;
  }

  function_64737a1614d07378();
  var_a97126fc869f6512 = undefined;

  foreach(tipkey in level.var_305547d6de59eba4.var_6d061cc60360cf78) {
    var_58c9ac5c1aad6962 = function_ceebd29c89f314d5(tipkey);

    if(var_58c9ac5c1aad6962) {
      var_a97126fc869f6512 = tipkey;
      break;
    }
  }

  function_20363b93250e08bf(var_a97126fc869f6512);
  return true;
}

function function_3fe2986e86dd4a0e(tipkey) {
  self.var_657f5a0d17435bc.completed[tipkey] = 1;
  self.var_657f5a0d17435bc.var_876a294e1e939f4d++;

  if(istrue(self.var_657f5a0d17435bc.var_7e077fa00d63d26e)) {
    self.var_657f5a0d17435bc.var_7e077fa00d63d26e = function_43c745bc0c2a589e();
  }

  if(istrue(self.var_657f5a0d17435bc.var_1dc18d3dd37ac5ea)) {
    self.var_657f5a0d17435bc.var_1dc18d3dd37ac5ea = function_6df0c3efd3b8a03a();
  }
}

function function_f3942ee6819263f5(tipkey) {
  level endon("game_ended");
  self endon("disconnect");
  self.var_657f5a0d17435bc.var_5e4d29a54d7eddf6 = tipkey;
  childthread function_58c9ac5c1aad6962(tipkey);
  childthread function_51547e875b8ddff4(tipkey);
  tipresult = waittill_any_return_2("currentContextualTipCompleted", "currentContextualTipAborted");
  function_3fe2986e86dd4a0e(tipkey);

  if(isDefined(tipresult)) {
    if(tipresult == "currentContextualTipCompleted") {
      childthread printtoscreen("<dev string:x5e>" + function_3c8848a3a11b2553(tipkey));

      function_a25d14ecf8dcb49e(function_b4641ae08979f8ce(tipkey));

      if(self.var_657f5a0d17435bc.var_876a294e1e939f4d >= level.var_305547d6de59eba4.var_1a60753f1ce4e8a4) {
        return;
      }
    } else {
      childthread printtoscreen("<dev string:x7c>" + function_3c8848a3a11b2553(tipkey));
    }
  } else {
    function_6fba31415caeee6e(0, level.ftuedata.var_f09f2ffd8a67fe03);

    childthread printtoscreen("<dev string:x98>" + function_3c8848a3a11b2553(tipkey));
  }

  self.var_657f5a0d17435bc.var_5e4d29a54d7eddf6 = undefined;
  self.var_657f5a0d17435bc.cooldown = gettime() + 12000;
}

function function_ea69eecec1a8fd38() {
  var_48f2647a5d71ae8d = 0;

  while(true) {
    var_3abc16c12e768d21 = self getclientomnvar("post_game_state");

    if(isDefined(var_3abc16c12e768d21) && var_48f2647a5d71ae8d != var_3abc16c12e768d21) {
      var_48f2647a5d71ae8d = var_3abc16c12e768d21;
      break;
    }

    waitframe();
  }

  function_7fd621b8ba80e652();
}

function private function_f8997955d2372a6b(contextualtip) {
  var_d6bc0a4323718cf2 = istrue(contextualtip.inprematch);
  isinprematch = level.var_bbbddef448c9120;

  if(var_d6bc0a4323718cf2 != isinprematch) {
    return false;
  }

  var_1e5ccbf8253a2948 = istrue(contextualtip.ingulag);
  isingulag = self.var_657f5a0d17435bc.eventscondition["GulagStarted"].isactive;

  if(var_1e5ccbf8253a2948 != isingulag) {
    return false;
  }

  return true;
}

function function_ceebd29c89f314d5(var_c0e68595c1877b35) {
  var_ff0f9c5ebef8424e = level.var_305547d6de59eba4.contextualtips[var_c0e68595c1877b35];

  if(istrue(self.var_657f5a0d17435bc.var_d445aab904364ee1)) {
    return 0;
  }

  if(self.var_657f5a0d17435bc.completed[var_c0e68595c1877b35]) {
    return 0;
  }

  if(!function_f8997955d2372a6b(var_ff0f9c5ebef8424e)) {
    return 0;
  }

  result = 1;

  if(isDefined(var_ff0f9c5ebef8424e.condfunc)) {
    result = self[[var_ff0f9c5ebef8424e.condfunc]](var_ff0f9c5ebef8424e.var_89d189dbd8049321);
  } else if(isDefined(var_ff0f9c5ebef8424e.initconditions)) {
    foreach(condition in var_ff0f9c5ebef8424e.initconditions) {
      if(isDefined(condition.params)) {
        var_cf5324f504ac4a52 = self[[level.var_6edc807b8a61c73[condition.func]]](condition.params);
      } else {
        var_cf5324f504ac4a52 = self[[level.var_6edc807b8a61c73[condition.func]]]();
      }

      result = result && var_cf5324f504ac4a52;
    }
  }

  return result;
}

function function_51547e875b8ddff4(var_c0e68595c1877b35) {
  var_ff0f9c5ebef8424e = level.var_305547d6de59eba4.contextualtips[var_c0e68595c1877b35];
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");

  if(isDefined(var_ff0f9c5ebef8424e.endconditions)) {
    var_c5209d14bf481e54 = 0;

    while(!var_c5209d14bf481e54) {
      foreach(condition in var_ff0f9c5ebef8424e.endconditions) {
        if(isDefined(condition.params)) {
          var_acea8891c2be0d5c = self[[level.var_6edc807b8a61c73[condition.func]]](condition.params);
        } else {
          var_acea8891c2be0d5c = self[[level.var_6edc807b8a61c73[condition.func]]]();
        }

        if(var_acea8891c2be0d5c) {
          if(isDefined(condition.action)) {
            self[[level.var_6edc807b8a61c73[condition.action]]]();
          }

          var_c5209d14bf481e54 = 1;
          break;
        }
      }

      waitframe();
    }
  }
}

function function_e1cef1bbd6b7e910() {
  level.ftuedata.var_5281a0a27d22f26e = 1;
}

function function_c300fc28576f45a1() {
  level.ftuedata.var_433df7cda1ff344c = 1;
}

function function_8ec9c50f12bec86a() {
  level.ftuedata.var_433df7cda1ff344c = 0;
}

function private function_fffc772291ad2500(var_c0e68595c1877b35) {
  if(!istrue(level.ftuedata.var_5281a0a27d22f26e)) {
    return;
  }

  var_ff0f9c5ebef8424e = level.var_305547d6de59eba4.contextualtips[var_c0e68595c1877b35];
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");

  while(true) {
    if(!istrue(level.ftuedata.var_433df7cda1ff344c)) {
      foreach(checkkey in level.var_305547d6de59eba4.var_6d061cc60360cf78) {
        if(checkkey == var_c0e68595c1877b35) {
          continue;
        }

        caninterrupt = function_ceebd29c89f314d5(checkkey);

        if(caninterrupt) {
          println("<dev string:xbd>" + var_c0e68595c1877b35 + "<dev string:xd9>" + checkkey);
          break;
        }
      }
    }

    wait 1;
  }
}

function function_58c9ac5c1aad6962(var_c0e68595c1877b35) {
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");

  childthread printtoscreen("<dev string:xe3>" + function_3c8848a3a11b2553(var_c0e68595c1877b35));

  var_ff0f9c5ebef8424e = level.var_305547d6de59eba4.contextualtips[var_c0e68595c1877b35];

  if(isDefined(var_ff0f9c5ebef8424e.execfunc)) {
    self[[var_ff0f9c5ebef8424e.execfunc]]();
    return;
  }

  self[[level.var_6edc807b8a61c73[level.var_305547d6de59eba4.contextualtips[var_c0e68595c1877b35].function]]]();
}

function function_3659d2731a5f2887() {
  level.var_6edc807b8a61c73[#"hash_95626095fb1efab5"] = &namespace_91fad7208d9cd856::function_5ebbaba0d200b31;
}

function function_8a4307513b99d156(datacallback) {
  function_3659d2731a5f2887();

  if(isDefined(datacallback)) {
    level.var_305547d6de59eba4.contextualtips = [[datacallback]]();
  } else {
    println("<dev string:x100>");
    level.var_305547d6de59eba4.contextualtips = [];
  }

  level.var_305547d6de59eba4.contextualtips = function_6fb77e285e34771(level.var_305547d6de59eba4.contextualtips);
  level.var_305547d6de59eba4.var_6d061cc60360cf78 = function_f5a2921bf524c600(level.var_305547d6de59eba4.contextualtips, &function_3c23eb60c9a218c6);
  level.var_305547d6de59eba4.var_6d061cc60360cf78 = function_81fad7aa52199d3e(level.var_305547d6de59eba4.var_6d061cc60360cf78);
}

function function_6fb77e285e34771(contextualtips) {
  if(!isDefined(contextualtips)) {
    return;
  }

  filteredtips = [];

  foreach(key, item in contextualtips) {
    if(getdvarint(hashcat(@ "hash_b04566e984b5cad4", item.key), 0) != 0) {
      continue;
    }

    filteredtips[key] = item;
  }

  return filteredtips;
}

function function_81fad7aa52199d3e(contextualtips) {
  filteredtips = [];

  foreach(tipkey in contextualtips) {
    contextualtip = level.var_305547d6de59eba4.contextualtips[tipkey];

    if(!isDefined(contextualtip.condfunc) && !isDefined(contextualtip.initconditions)) {
      continue;
    }

    filteredtips[filteredtips.size] = tipkey;
  }

  return filteredtips;
}

function function_28f32fc9e57814f6(tipkey) {
  if(!istrue(self.var_fa35b4a136b27acd) || !isDefined(level.var_305547d6de59eba4) || !isDefined(self.var_657f5a0d17435bc)) {
    return;
  }

  contextualtip = level.var_305547d6de59eba4.contextualtips[tipkey];
  assert(isDefined(contextualtip));

  if(self.var_657f5a0d17435bc.completed[tipkey]) {
    return 0;
  }

  if(istrue(self.var_657f5a0d17435bc.var_5eb1da668993b439[tipkey])) {
    return 0;
  }

  self.var_657f5a0d17435bc.var_5eb1da668993b439[tipkey] = 1;
  checkpriority = contextualtip.priority;
  manualtips = self.var_657f5a0d17435bc.manualtips;
  var_eebdc3556dd1fa5 = [];

  for(var_838f4526cea84195 = 0; var_838f4526cea84195 < manualtips.size; var_838f4526cea84195++) {
    var_fb49660b1b47f291 = manualtips[var_838f4526cea84195];
    var_a4409f4f4db369a = level.var_305547d6de59eba4.contextualtips[var_fb49660b1b47f291];

    if(var_a4409f4f4db369a.priority < checkpriority) {
      break;
    }

    var_eebdc3556dd1fa5[var_eebdc3556dd1fa5.size] = var_fb49660b1b47f291;
  }

  var_eebdc3556dd1fa5[var_eebdc3556dd1fa5.size] = tipkey;

  while(var_838f4526cea84195 < manualtips.size) {
    var_eebdc3556dd1fa5[var_eebdc3556dd1fa5.size] = manualtips[var_838f4526cea84195];
    var_838f4526cea84195++;
  }

  self.var_657f5a0d17435bc.manualtips = var_eebdc3556dd1fa5;
}

function function_3c23eb60c9a218c6(tipa, tipb) {
  return tipa.priority >= tipb.priority;
}

function function_f5a2921bf524c600(array, compare_func) {
  var_8e8176e676ad1fcc = [];

  foreach(key, item in array) {
    var_8e8176e676ad1fcc = array_add_safe(var_8e8176e676ad1fcc, key);
  }

  assertex(isDefined(array), "<dev string:x12a>");
  assertex(isDefined(compare_func), "<dev string:x140>");

  for(j = 1; j < var_8e8176e676ad1fcc.size; j++) {
    key = var_8e8176e676ad1fcc[j];

    for(i = j - 1; i >= 0 && ![[compare_func]](array[var_8e8176e676ad1fcc[i]], array[key]); i--) {
      var_8e8176e676ad1fcc[i + 1] = var_8e8176e676ad1fcc[i];
    }

    var_8e8176e676ad1fcc[i + 1] = key;
  }

  return var_8e8176e676ad1fcc;
}

function function_f450e760a53ca63c() {
  level.var_305547d6de59eba4.var_daba424d7f945348["GulagStarted"] = spawnStruct();
  level.var_305547d6de59eba4.var_daba424d7f945348["GulagStarted"].function = &function_d8d5458fc84e29fe;
  level.var_305547d6de59eba4.var_daba424d7f945348["GulagStarted"].var_942fd5e571e7f0f5 = 5;
  level.var_305547d6de59eba4.var_daba424d7f945348["GulagStarted"].completionmessage = "IsGulagStarted";
  level.var_305547d6de59eba4.var_daba424d7f945348["GulagStarted"].var_e9f265c1ba0aaebc = &function_e7f53a3e2391d23;
  level.var_305547d6de59eba4.var_daba424d7f945348["GulagStarted"].var_b8658683d6717273 = "gulagFinished";
  level.var_305547d6de59eba4.var_daba424d7f945348["EnemiesInMinimap"] = spawnStruct();
  level.var_305547d6de59eba4.var_daba424d7f945348["EnemiesInMinimap"].function = &function_5fcd813a97044d45;
  level.var_305547d6de59eba4.var_daba424d7f945348["EnemiesInMinimap"].var_942fd5e571e7f0f5 = 5;
  level.var_305547d6de59eba4.var_daba424d7f945348["EnemiesInMinimap"].completionmessage = "AreEnemiesInMinimap";
  level.var_305547d6de59eba4.var_daba424d7f945348["PlayerShotByEnemy"] = spawnStruct();
  level.var_305547d6de59eba4.var_daba424d7f945348["PlayerShotByEnemy"].function = &function_2f0da1e9da7ed50d;
  level.var_305547d6de59eba4.var_daba424d7f945348["PlayerShotByEnemy"].var_942fd5e571e7f0f5 = 10;
  level.var_305547d6de59eba4.var_daba424d7f945348["PlayerShotByEnemy"].completionmessage = "IsPlayerShotByEnemy";
}

function function_7a1391f264af1243() {
  self.var_657f5a0d17435bc.eventscondition = [];

  foreach(key, eventcondition in level.var_305547d6de59eba4.var_daba424d7f945348) {
    self.var_657f5a0d17435bc.eventscondition[key] = spawnStruct();
    self.var_657f5a0d17435bc.eventscondition[key].isactive = 0;
  }
}

function function_8385f0514b5f730d() {
  foreach(key, eventcondition in level.var_305547d6de59eba4.var_daba424d7f945348) {
    thread function_26d4abdfb928d4fd(eventcondition, key);
  }
}

function function_26d4abdfb928d4fd(eventcondition, key) {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    self.var_657f5a0d17435bc.eventscondition[key].isactive = 0;
    self childthread[[eventcondition.function]](eventcondition);
    self waittill(eventcondition.completionmessage);
    self.var_657f5a0d17435bc.eventscondition[key].isactive = 1;

    if(isDefined(eventcondition.var_e9f265c1ba0aaebc)) {
      self childthread[[eventcondition.var_e9f265c1ba0aaebc]]();
      self waittill(eventcondition.var_b8658683d6717273);
    }

    if(isDefined(eventcondition.var_942fd5e571e7f0f5)) {
      wait eventcondition.var_942fd5e571e7f0f5;
    }
  }
}

function function_6d7761e5ee79ee04(position, spawndelay) {
  if(!isDefined(level.var_305547d6de59eba4.var_7520d86455f99294)) {
    return;
  }

  if(isDefined(spawndelay)) {
    wait spawndelay;
  }

  level.var_305547d6de59eba4.var_7520d86455f99294.origin = position;
}

function function_effec5e680d95771() {
  level.var_305547d6de59eba4.var_da1e4ded7db0b78[0] = "brloot_plunder_cash_uncommon_1";
  level.var_305547d6de59eba4.var_da1e4ded7db0b78[1] = "brloot_plunder_cash_uncommon_2";
  level.var_305547d6de59eba4.var_da1e4ded7db0b78[2] = "brloot_plunder_cash_uncommon_3";
  level.var_305547d6de59eba4.var_da1e4ded7db0b78[3] = "brloot_plunder_cash_common_1";
  level.var_305547d6de59eba4.var_da1e4ded7db0b78[4] = "brloot_plunder_cash_rare_1";
  level.var_305547d6de59eba4.var_da1e4ded7db0b78[5] = "brloot_plunder_cash_rare_2";
  level.var_305547d6de59eba4.var_da1e4ded7db0b78[6] = "brloot_plunder_cash__epic_1";
  level.var_305547d6de59eba4.var_da1e4ded7db0b78[7] = "brloot_plunder_cash__epic_2";
}

function function_64f6dbf96d0e6f81() {
  self.var_657f5a0d17435bc.var_b80e4d5abb5c9ab5 waittill("disconnect");
  function_7fd621b8ba80e652();
  self notify("currentContextualTipAborted");
  function_66ee5612ecdfbac6();
}

function function_66ee5612ecdfbac6() {
  if(isDefined(self.var_657f5a0d17435bc.var_40834c928484edfb.waypoint)) {
    function_4d03b9ef456d0972(self.var_657f5a0d17435bc.var_40834c928484edfb.waypoint);
  }

  function_3ff2b2e0317f4686();
}

function function_7618f4372cdd1ce() {
  self.var_657f5a0d17435bc.var_9fd058151789294e.closedcash = undefined;

  while(!isDefined(self.var_657f5a0d17435bc.var_9fd058151789294e.closedcash)) {
    params = spawnStruct();
    params.mindistance = 50;
    params.maxdistance = 700;
    function_123bc3d0aa752e3(params);
    waitframe();
  }

  if(isDefined(self.var_657f5a0d17435bc.var_9fd058151789294e.closedcash)) {
    waypointposition = self.var_657f5a0d17435bc.var_9fd058151789294e.closedcash.origin + (0, 0, 1);
    self.var_657f5a0d17435bc.var_40834c928484edfb.cashwaypoint = function_e5524fb8509827bf(waypointposition, &"FTUE_MOBILE/PICK_UP", "icon_waypoint_objective_general", 15, self, 1);
    childthread function_72c1ec67d589d251(&function_3ff2b2e0317f4686);
  }
}

function function_3ff2b2e0317f4686() {
  if(self.var_657f5a0d17435bc.var_40834c928484edfb.cashwaypoint) {
    function_4d03b9ef456d0972(self.var_657f5a0d17435bc.var_40834c928484edfb.cashwaypoint);
  }
}

function function_59299228aa688748() {
  self.var_657f5a0d17435bc.var_b80e4d5abb5c9ab5 endon("disconnect");
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");
  self.var_657f5a0d17435bc.var_e7cee4fbb5b46ef2 = undefined;

  while(!isDefined(self.var_657f5a0d17435bc.var_e7cee4fbb5b46ef2)) {
    function_a568dfa416def0b(1500);
    waitframe();
  }

  if(isDefined(self.var_657f5a0d17435bc.var_e7cee4fbb5b46ef2)) {
    self.var_657f5a0d17435bc.var_40834c928484edfb.waypoint = function_e5524fb8509827bf(self.var_657f5a0d17435bc.var_e7cee4fbb5b46ef2.origin, &"FTUE_MOBILE/OPEN", "icon_waypoint_objective_general", 40, self);
    childthread function_7d8349e57f205396();
  }
}

function function_7d8349e57f205396() {
  self.var_657f5a0d17435bc.var_b80e4d5abb5c9ab5 endon("disconnect");
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");
  waypointenabled = 1;

  while(isDefined(self.var_657f5a0d17435bc.var_40834c928484edfb.waypoint)) {
    dist = distancesquared(self.origin, self.var_657f5a0d17435bc.var_e7cee4fbb5b46ef2.origin);

    if(dist <= 14400 && waypointenabled) {
      waypointenabled = 0;
      function_4d03b9ef456d0972(self.var_657f5a0d17435bc.var_40834c928484edfb.waypoint);
    }

    if(dist >= 14400 + 14400 * 0.2 && !waypointenabled) {
      waypointenabled = 1;
      self.var_657f5a0d17435bc.var_40834c928484edfb.waypoint = function_e5524fb8509827bf(self.var_657f5a0d17435bc.var_e7cee4fbb5b46ef2.origin, &"FTUE_MOBILE/OPEN", "icon_waypoint_objective_general", 40, self);
    }

    waitframe();
  }
}

function function_962a086325a6ebcc() {
  self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03.notweapons[0] = "iw9_armor_plate_deploy_mp";
  self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03.notweapons[1] = "iw9_laser_large_ir_mp";
  self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03.notweapons[2] = "iw9_spotter_scope_mp";
}

function function_d8d5458fc84e29fe(eventcondition) {
  function_db3156cab6c25766(&function_ae8bb3b961eba2a1);
  function_b3e2a55102596658(&function_8e9c156e6eaf6cef);
}

function function_e7f53a3e2391d23() {
  function_8efd0509e8d63ca9(&function_22d2c0ff8235b592);
}

function function_22d2c0ff8235b592(message) {
  self notify("gulagFinished");
}

function function_ae8bb3b961eba2a1(var_e73f82f58eb3128) {
  self notify("IsGulagStarted");
}

function function_8e9c156e6eaf6cef(var_e73f82f58eb3128) {
  self.var_657f5a0d17435bc.var_dba7867b4e133164 = 1;
}

function function_5fcd813a97044d45(eventcondition) {
  childthread function_9e3f4898db5d314e(&function_aa8fe7b21a2e4ba6);
}

function function_aa8fe7b21a2e4ba6() {
  self notify("AreEnemiesInMiniMap");
}

function function_2f0da1e9da7ed50d(eventcondition) {
  function_ff62c3aabf4c0ba8(&function_6b4f0525d8e95cde);
}

function function_6b4f0525d8e95cde(eventcondition) {
  self notify("IsPlayerShotByEnemy");
}

function function_5ebbaba0d200b31() {
  function_7fd621b8ba80e652();
  self notify("currentContextualTipAborted");
}

function function_69d2bf97401ca611(tipkey) {
  if(!isDefined(tipkey)) {
    return;
  }

  var_794fe72a0defb619 = function_1823ff50bb28148d(tipkey);

  if(!isDefined(level.var_305547d6de59eba4.contextualtips[var_794fe72a0defb619])) {
    return;
  }

  level.player function_5ebbaba0d200b31();
  level.player function_28f32fc9e57814f6(var_794fe72a0defb619);
}

# /