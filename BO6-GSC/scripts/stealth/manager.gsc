/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\manager.gsc
***************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\smartobjects\hunt_checkin;
#using scripts\smartobjects\hunt_point;
#using scripts\smartobjects\utility;
#using scripts\stealth\callbacks;
#using scripts\stealth\corpse;
#using scripts\stealth\debug;
#using scripts\stealth\enemy;
#using scripts\stealth\event;
#using scripts\stealth\threat_sight;
#using scripts\stealth\utility;
#namespace stealth_manager;

function main() {
  if(isDefined(level.stealth)) {
    return;
  }

  init();
  level thread teams_thread();

  thread debug::debug_manager();
}

function init() {
  utility::flag_set("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
  level.stealth = spawnStruct();
  level.stealth.fov = spawnStruct();
  level.stealth.save = spawnStruct();
  level.stealth.corpsesynchtype = "\xe7\x1c\xf4sGk\xe1zXq\xb6{\xe1";

  if(!isDefined(level.var_62b48f91c43f07c0)) {
    set_stealth_bundle(level.gamemodebundle.stealthbundle);
  }

  level.stealth.debug = spawnStruct();
  level.stealth.debug.screen = [];

  level.stealth.funcs = [];
  function_424f3a7393cd39a7("\xf8VZW\xd3\xad");
  corpse::corpse_init_level();
  event::event_init_level();
  level.stealth.next_sound_wait = 3000;
  level.stealth.head_shot_dist = 8;
  level.stealth.var_8b69b19f6f0325c1 = 15;
  level.stealth.group = spawnStruct();
  level.stealth.group.flags = [];
  level.stealth.group.groups = [];
  level.stealth.group.ally_groups = [];
  level.stealth.group.death_alert_timeout = [];
  level.stealth.hunting_groups = [];
  set_default_settings();
  init_stealth_volumes();
  utility::init_smartobjects();
  init_save();
  level.stealth.min_alert_level_duration = 1;
  setup_stealth_funcs();

  if(!isDefined(anim.smartobjects["\xae,p\r,\xdd\x90\xd5\xed\xa6"])) {
    hunt_point::main();
  }

  if(!isDefined(anim.smartobjects["\nCSC\xb03+\x9f\xbar\x98\x18"])) {
    hunt_checkin::main();
  }

  level.bseq = spawnStruct();
  level.bseq.instancedata = [];
}

function set_stealth_bundle(stealthbundlename, var_6cd7df59365c06e9) {
  main();

  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {
    return;
  }

  if(!isstring(stealthbundlename) || stealthbundlename == "") {
    return;
  }

  stealthbundle = getscriptbundle("\xd0\xfeq\xff+\b\xac\xcb{\xfaD[\xd5K" + stealthbundlename);

  if(isDefined(stealthbundle)) {
    thread set_stealth_bundle_internal(stealthbundle);

    if(istrue(var_6cd7df59365c06e9)) {
      ais = getaiarray();

      foreach(ai in ais) {
        ai function_96273841d702ae6b(stealthbundle.sightconfigtemplate, 1);
      }
    }

    return;
  }

  assertmsg("<dev string:x24>" + stealthbundlename + "<dev string:x38>");
}

function private set_stealth_bundle_internal(stealthbundle) {
  self notify("\xc4\xb5uY\x0fhF\x7f\x02\x1dj\x0e\\~\xbf6\x18\xc0\xbfM\xb5\xcb\xde\x02\x84V\xa8");
  self endon("\xc4\xb5uY\x0fhF\x7f\x02\x1dj\x0e\\~\xbf6\x18\xc0\xbfM\xb5\xcb\xde\x02\x84V\xa8");
  level.var_62b48f91c43f07c0 = stealthbundle;
  utility::flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
  level.var_62b48f91c43f07c0 = undefined;
  set_default_settings();
  level.stealth.sightconfigtemplate = stealthbundle.sightconfigtemplate;
  level.stealth.threatsightwidget = stealthbundle.threatsightwidget;
  level.stealth.threatsightanchor = stealthbundle.threatsightanchor;
  level.stealth.stealth_spotted_delay = stealthbundle.var_9c0442d69ed7b125;
  level.stealth.var_43e59037374c630a = stealthbundle.var_11a244a486d1c247;
  level.stealth.sightedsfx = stealthbundle.var_634f7743a5a68f38;
  level.stealth.spottedsfx = stealthbundle.spottedsfxname;
  function_51029f510f658a8c(istrue(stealthbundle.var_9de5915ab770bfd7));
  level.stealth.huntmode = stealthbundle.hunttype ?? "\xf9\xce^Z3\xe0";

  switch (level.stealth.huntmode) {
    case #"hash_c24b16fb9788caee":
      function_c0f63c5ff2844cbc(0);
      function_cc2b6ee96d1f988f(0);
      break;
    case #"hash_4f2154ac90348b6a":
      function_c0f63c5ff2844cbc(1);
      function_cc2b6ee96d1f988f(0);
      break;
    case #"hash_ad8f23b9b8103745":
      function_c0f63c5ff2844cbc(0);
      function_cc2b6ee96d1f988f(1);
      break;
  }

  level.stealth.corpsesynchtype = stealthbundle.corpsesynchtype ?? "\xe7\x1c\xf4sGk\xe1zXq\xb6{\xe1";

  foreach(player in level.players) {
    function_d23d215356703816(player, istrue(stealthbundle.sightdisguised));

    if(isDefined(level.var_7827c6737df9caca)) {
      player[[level.var_7827c6737df9caca]](istrue(stealthbundle.socialstealth));
    }

    player val::reset_all("7:V\x16\xc6\x1d\r1\xae\x9b#6Y");

    switch (level.stealth.corpsesynchtype) {
      case #"hash_1d7966a2fa479e24":
        player val::set("7:V\x16\xc6\x1d\r1\xae\x9b#6Y", "`&\xd9V\xf0rz\xd2\xe4\xc62\xd1\x816", 1);
        break;
      case #"hash_616703241319aec9":
        break;
    }
  }

  setomnvar("\xfd\x1d\x81P\xe864\x9aAS\x1e\x88", stealthbundle.var_e11ca777f1687736 ?? 0.01);
  setomnvar("0\x9e\xb9\nW\x98s\x86L\xe5", stealthbundle.var_e264804837d8e8dd ?? 0);

  if(isDefined(stealthbundle.eventlist)) {
    val::set("\x1e:\xdf\xca\xc0\x8c$I\xb7~\xf9\xe4\x7f\x8a", "\xa8+s\x99ms4\xbe\xa8\x8348", stealthbundle.eventlist);
  } else {
    val::reset("\x1e:\xdf\xca\xc0\x8c$I\xb7~\xf9\xe4\x7f\x8a", "\xa8+s\x99ms4\xbe\xa8\x8348");
  }

  corpseranges = [];
  corpseranges["~\xb9e\xde\xb9\xe1\x0e\x88\b\x02"] = stealthbundle.corpserangesight ?? 600;
  corpseranges["\x02\xaa\v\x86\xc1\xd4\x18\xa1'B\xdd"] = stealthbundle.var_c8bc7c1d03309584 ?? 300;
  corpseranges["Zk\xab[\xafHa\xe8\x9eV"] = stealthbundle.var_112f2e3d62adcf73 ?? 100;
  corpseranges["o .\xaf\xffzb\xa8\x14\x9an"] = stealthbundle.var_f475e7968016b64b ?? 100;
  corpse::set_corpse_ranges(corpseranges);
  var_e27a727fe455c38c = int((stealthbundle.var_b29a2648f04a11b6 ?? 1) * 1000);
  var_2f1fab4e9591ba24 = int((stealthbundle.var_da4c91e27616a972 ?? 2) * 1000);
  var_924a75345be17e6e = int((stealthbundle.var_137016b42a75858 ?? 5) * 1000);
  var_9761ca546387ac3 = int((stealthbundle.var_de8b118e647a8411 ?? 1) * 1000);
  var_f35c8039a04eec5f = int((stealthbundle.var_a26191342e98e2bf ?? 5) * 1000);
  var_741dc53ee4484b81 = stealthbundle.var_3595f5aa5d071f1f ?? 1200;
  combatpingradius = stealthbundle.var_377ee51cc20e8a05 ?? 720;
  var_30efe16fb9e0115b = stealthbundle.var_8b28d046b57d3aa8 ?? 640;
  var_b7d88265c3a948f5 = stealthbundle.var_69047abaeb94cb9a ?? 256;
  var_b1c70a34103e4f6f = stealthbundle.var_bd26d3aa3103054c ?? 720;
  combatgraceperiod = int((stealthbundle.aicombatgraceperiod ?? 2) * 1000);
  threatsightdecayrate = stealthbundle.var_3de8ed2c42244e8b ?? 1.5;
  var_9518e1cc39ffcd2f = stealthbundle.var_9518e1cc39ffcd2f ?? 0.33;
  var_558bc8884ca2a5ce = stealthbundle.var_ed3304181ecfa44f ?? 0;
  function_a0cd8e8970b87fc0(var_e27a727fe455c38c);
  function_156d99bf707a54f5(var_2f1fab4e9591ba24);
  function_85576aabdda88d35(var_924a75345be17e6e);
  function_7c192fa5eeb9cf82(var_9761ca546387ac3);
  function_753a0378edfaf13a(var_f35c8039a04eec5f);
  function_4e9798b778499515(var_741dc53ee4484b81);
  function_ec5de24f83f88c93(combatpingradius);
  function_c3be836f9c5b569e(var_30efe16fb9e0115b);
  function_f850e4f90c2026c4(var_b7d88265c3a948f5);
  function_eabd93023a7f252b(var_b1c70a34103e4f6f);
  level.stealth.var_602277e5a2e2d5fa = stealthbundle.aidamagerangeperipheral ?? 1500;
  level.stealth.damage_sight_range = stealthbundle.aidamagerangesight ?? 1200;
  level.stealth.damage_auto_range = stealthbundle.aidamagerangeauto ?? 480;
  function_f3d7cdfd68f8883c(combatgraceperiod);
  function_df54271c56d041f2(threatsightdecayrate);
  function_838ea0121a834854(var_9518e1cc39ffcd2f);
  function_d96718af1bf1dafd(var_558bc8884ca2a5ce);
  stealth_hidden = [];
  stealth_hidden["GX\xa9]\x82"] = 9999;
  stealth_hidden["1x\xc5\xb4\xabx"] = 9999;
  stealth_hidden["\x8b\x90\xb5\xc4W"] = 9999;
  stealth_spotted = [];
  stealth_spotted["GX\xa9]\x82"] = 9999;
  stealth_spotted["1x\xc5\xb4\xabx"] = 9999;
  stealth_spotted["\x8b\x90\xb5\xc4W"] = 9999;
  utility::set_detect_ranges(stealth_hidden, stealth_spotted);
}

function setup_stealth_funcs() {
  level utility::set_stealth_func("\x8c\xed\xaf\xe6\x1d\xac\xc2\xc6th", &utility::do_stealth);
  enemy::set_default_stealth_funcs();
  level.stealth.fngroupspottedflag = &utility::group_spotted_flag;
  level.stealth.fninitenemygame = undefined;
  level.stealth.var_46abbff822c79e7e = &callbacks::stealth_call_thread;
}

function set_default_settings() {
  stealth_hidden = [];
  stealth_hidden["GX\xa9]\x82"] = 1000;
  stealth_hidden["1x\xc5\xb4\xabx"] = 1800;
  stealth_hidden["\x8b\x90\xb5\xc4W"] = 2800;
  stealth_spotted = [];
  stealth_spotted["GX\xa9]\x82"] = 1800;
  stealth_spotted["1x\xc5\xb4\xabx"] = 2500;
  stealth_spotted["\x8b\x90\xb5\xc4W"] = 4000;
  utility::set_detect_ranges(stealth_hidden, stealth_spotted);
  minrangedarkness_hidden = [];
  minrangedarkness_hidden["GX\xa9]\x82"] = 130;
  minrangedarkness_hidden["1x\xc5\xb4\xabx"] = 215;
  minrangedarkness_hidden["\x8b\x90\xb5\xc4W"] = 300;
  minrangedarkness_spotted = [];
  minrangedarkness_spotted["GX\xa9]\x82"] = 300;
  minrangedarkness_spotted["1x\xc5\xb4\xabx"] = 375;
  minrangedarkness_spotted["\x8b\x90\xb5\xc4W"] = 450;
  utility::set_min_detect_range_darkness(minrangedarkness_hidden, minrangedarkness_spotted);
  var_5081e94c1230f49c = [];
  var_5081e94c1230f49c["GX\xa9]\x82"] = 130;
  var_5081e94c1230f49c["1x\xc5\xb4\xabx"] = 215;
  var_5081e94c1230f49c["\x8b\x90\xb5\xc4W"] = 300;
  var_96ef1b66aaa0c63f = [];
  var_96ef1b66aaa0c63f["GX\xa9]\x82"] = 300;
  var_96ef1b66aaa0c63f["1x\xc5\xb4\xabx"] = 375;
  var_96ef1b66aaa0c63f["\x8b\x90\xb5\xc4W"] = 450;
  utility::function_45380219f0ec11c0(minrangedarkness_hidden, minrangedarkness_spotted);
  level.stealth.fov.cosine["\xe0V\x90\xef~"] = 0.98;
  level.stealth.fov.cosinebusy["\xe0V\x90\xef~"] = 0.98;
  level.stealth.fov.cosinez["\xe0V\x90\xef~"] = 0;
  level.stealth.fov.ground["\xe0V\x90\xef~"] = 0;
  level.stealth.fov.cosine["\xf8VZW\xd3\xad"] = 0.7;
  level.stealth.fov.cosinebusy["\xf8VZW\xd3\xad"] = 0.86;
  level.stealth.fov.cosinez["\xf8VZW\xd3\xad"] = 0.97;
  level.stealth.fov.ground["\xf8VZW\xd3\xad"] = 1;
  level.stealth.fov.cosine["\xc2\x99.K\xdd\x9fBw>]\x8e"] = 0.7;
  level.stealth.fov.cosinebusy["\xc2\x99.K\xdd\x9fBw>]\x8e"] = 0.86;
  level.stealth.fov.cosinez["\xc2\x99.K\xdd\x9fBw>]\x8e"] = 0.97;
  level.stealth.fov.ground["\xc2\x99.K\xdd\x9fBw>]\x8e"] = 1;
  level.stealth.fov.cosine["\xb1\xf6k1\xc2\x8e\xbe\xd0\xeas:"] = 0.7;
  level.stealth.fov.cosinebusy["\xb1\xf6k1\xc2\x8e\xbe\xd0\xeas:"] = 0.86;
  level.stealth.fov.cosinez["\xb1\xf6k1\xc2\x8e\xbe\xd0\xeas:"] = 0.97;
  level.stealth.fov.ground["\xb1\xf6k1\xc2\x8e\xbe\xd0\xeas:"] = 1;
  level.stealth.fov.cosine["\x1f\x93?pK+\x9c"] = 0.01;
  level.stealth.fov.cosinebusy["\x1f\x93?pK+\x9c"] = 0.574;
  level.stealth.fov.cosinez["\x1f\x93?pK+\x9c"] = 0;
  level.stealth.fov.ground["\x1f\x93?pK+\x9c"] = 0;
  corpse::set_corpse_ranges_default();
  event_change("\xf8VZW\xd3\xad");
}

function set_event_distances(array) {
  foreach(state, state_array in array) {
    assert(state == "<dev string:x49>" || state == "<dev string:x53>", "<dev string:x5e>");

    foreach(event, value in state_array) {
      function_10789e8c198486c6(state, event, value);

      if(function_4c869cfc6e1058eb() == state) {
        function_6473d0f1c7f622d4(event, value);
        function_5d9c311ddd923192(event, value);
      }
    }
  }
}

function set_detect_ranges_internal(hidden, spotted) {
  var_f40f0018be553353 = 0.25;

  if(isDefined(hidden)) {
    function_a71949f7dace702b("\xf8VZW\xd3\xad", "GX\xa9]\x82", hidden["GX\xa9]\x82"]);
    function_a71949f7dace702b("\xf8VZW\xd3\xad", "1x\xc5\xb4\xabx", hidden["1x\xc5\xb4\xabx"]);
    function_a71949f7dace702b("\xf8VZW\xd3\xad", "\x8b\x90\xb5\xc4W", hidden["\x8b\x90\xb5\xc4W"]);

    if(!isDefined(hidden["\xf5HO8\xcaY"])) {
      hidden["\xf5HO8\xcaY"] = var_f40f0018be553353;
    }

    function_a71949f7dace702b("\xf8VZW\xd3\xad", "\xf5HO8\xcaY", hidden["\xf5HO8\xcaY"]);
  }

  if(isDefined(spotted)) {
    function_a71949f7dace702b("\x1f\x93?pK+\x9c", "GX\xa9]\x82", spotted["GX\xa9]\x82"]);
    function_a71949f7dace702b("\x1f\x93?pK+\x9c", "1x\xc5\xb4\xabx", spotted["1x\xc5\xb4\xabx"]);
    function_a71949f7dace702b("\x1f\x93?pK+\x9c", "\x8b\x90\xb5\xc4W", spotted["\x8b\x90\xb5\xc4W"]);

    if(!isDefined(spotted["\xf5HO8\xcaY"])) {
      spotted["\xf5HO8\xcaY"] = var_f40f0018be553353;
    }

    function_a71949f7dace702b("\x1f\x93?pK+\x9c", "\xf5HO8\xcaY", spotted["\xf5HO8\xcaY"]);
  }
}

function manager_thread() {
  while(true) {
    utility::flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    threat_sight::threat_sight_set_dvar(1);

    if(!playerlootenabled() && level.stealth.corpsesynchtype == "\xe7\x1c\xf4sGk\xe1zXq\xb6{\xe1") {
      foreach(player in level.players) {
        player val::set("7:V\x16\xc6\x1d\r1\xae\x9b#6Y", "`&\xd9V\xf0rz\xd2\xe4\xc62\xd1\x816", 1);
      }
    }

    utility::flag_wait("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");

    if(!playerlootenabled() && level.stealth.corpsesynchtype == "\xe7\x1c\xf4sGk\xe1zXq\xb6{\xe1") {
      foreach(player in level.players) {
        player val::reset("7:V\x16\xc6\x1d\r1\xae\x9b#6Y", "`&\xd9V\xf0rz\xd2\xe4\xc62\xd1\x816");
      }
    }

    if(!utility::flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
      continue;
    }

    event_change("\x1f\x93?pK+\x9c");
    utility::flag_waitopen("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");

    if(!utility::flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
      continue;
    }

    event_change("\xf8VZW\xd3\xad");
    waittillframeend();
  }
}

function anyone_in_combat() {
  if(!isDefined(level.stealth)) {
    return false;
  }

  if(function_f83a77097be9668e()) {
    return true;
  }

  now = gettime();

  if(now > (level.stealth.var_7e62f9c360fbcc67 ?? 0)) {
    level.stealth.var_7e62f9c360fbcc67 = now + 50;
    level.stealth.var_9c71cd68366f4a96 = undefined;
    ais = getaiunittypearray("\x9a\x1f\x83\x1bs=\x13\xf8", "\xc0\xc6J");

    foreach(guy in ais) {
      if(!isDefined(guy.stealth) && isDefined(guy.enemy) && guy.enemy == self) {
        level.stealth.var_9c71cd68366f4a96 = 1;
        break;
      }
    }
  }

  return istrue(level.stealth.var_9c71cd68366f4a96);
}

function anyone_in_hunt() {
  if(!isDefined(level.stealth)) {
    return false;
  }

  now = gettime();

  if(now > (level.stealth.var_1d63d9c6bde9e9d8 ?? 0)) {
    level.stealth.var_1d63d9c6bde9e9d8 = now + 50;
    level.stealth.var_2433e490f1676ca1 = undefined;
    ais = getaiunittypearray("?\xb1\xc0\x9a");

    foreach(guy in ais) {
      if(guy function_7e5c19559f8d41ca()) {
        level.stealth.var_2433e490f1676ca1 = 1;
        break;
      }
    }
  }

  return istrue(level.stealth.var_2433e490f1676ca1);
}

function update_stealth_spotted_thread() {
  waitframe();
  wasspotted = 0;

  while(true) {
    bspotted = anyone_in_combat();

    if(bspotted) {
      if(!wasspotted && isDefined(level.stealth.stealth_spotted_delay) && level.stealth.stealth_spotted_delay > 0) {
        wait level.stealth.stealth_spotted_delay;

        if(!anyone_in_combat()) {
          waitframe();
          continue;
        }
      }

      if(!utility::flag("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed")) {
        utility::flag_set("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");

        if(isDefined(self.stealth)) {
          mygroupflagname = utility::get_group_flagname("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
          utility::flag_set(mygroupflagname);
        }
      }
    } else if(utility::flag("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed")) {
      utility::flag_clear("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");

      if(isDefined(self.stealth)) {
        mygroupflagname = utility::get_group_flagname("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
        utility::flag_clear(mygroupflagname);
      }
    }

    wasspotted = bspotted;
    waitframe();
  }
}

function teams_thread() {
  level.stealth.enemies["?\xb1\xc0\x9a"] = [];
  level.stealth.enemies["O\x15\x1b\xad\x9ff"] = [];

  while(true) {
    utility::flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    level.stealth.enemies["?\xb1\xc0\x9a"] = level.players;
    level.stealth.enemies["O\x15\x1b\xad\x9ff"] = getaiarray("?\xb1\xc0\x9a");
    wait 0.05;
  }
}

function event_change(name) {
  function_424f3a7393cd39a7(name);
  ai_event = function_4a9aa058de7f4530();

  foreach(state_array in ai_event) {
    if(state == name) {
      foreach(key, event in state_array) {
        function_6473d0f1c7f622d4(key, event);
        function_5d9c311ddd923192(key, event);
      }
    }
  }
}

function init_save() {
  utility::flag_init("Y\xe3\x80B\x15\xca\x89\x97\xe2f<\xbbE\x80\xee\xb6\xfa\xac\x8e");
  level.stealth.save.player_nades = 0;

  if(!utility::issp()) {
    return;
  }

  utility::array_thread(level.players, &player_grenade_check);
}

function player_grenade_check() {
  while(true) {
    self waittill("\x04\x05\x86\xdb\xa3\xa0)\xc5\xf8\x89\xc0\x9fk\x94I4");
    utility::flag_set("Y\xe3\x80B\x15\xca\x89\x97\xe2f<\xbbE\x80\xee\xb6\xfa\xac\x8e");
    self waittill("\xe0\x99\xc7\xf1\a3\x81c\xa5\xe17G", grenade);
    thread player_grenade_check_dieout(grenade);
  }
}

function player_grenade_check_dieout(grenade) {
  level.stealth.save.player_nades++;
  grenade utility::waittill_notify_or_timeout("\x1e\xfd\xd1\xa2\a", 10);
  level.stealth.save.player_nades--;
  waittillframeend();

  if(!level.stealth.save.player_nades) {
    utility::flag_clear("Y\xe3\x80B\x15\xca\x89\x97\xe2f<\xbbE\x80\xee\xb6\xfa\xac\x8e");
  }
}

function init_stealth_volumes() {
  level.stealth.combat_volumes = [];
  level.stealth.hunt_volumes = [];
  level.stealth.investigate_volumes = [];
  allvolumes = getEntArray("\xa0Y\xb1\x98M\x19\x80\xdd\x15\x84{m\x96\xf3\x0f\xe0\x88-p\x80\xb3Z\x86", #classname);
  volumes = getEntArray("\xcbH\x986\xff\xb0\x97\x1c\xf1d\x86}\xff\xc3\xd6\x91\xe6\xed\x87\xce\x1e\xf6\xf8\x8a'\xfb", #classname);
  volumes = utility::array_combine(volumes, allvolumes);

  if(isDefined(volumes)) {
    foreach(vol in volumes) {
      if(isDefined(vol.script_stealthgroup) && vol.script_stealthgroup != "Bf") {
        assert(isDefined(vol.script_stealthgroup), "<dev string:xaa>" + vol.origin);
        assert(vol.script_stealthgroup != "<dev string:xda>" && vol.script_stealthgroup != "<dev string:xe0>", "<dev string:xe4>" + vol.origin);
        groups = strtok(vol.script_stealthgroup, "\xda");

        foreach(group in groups) {
          if(istrue(level.var_8fc5cf62ce40da3d) && (group == "<dev string:x12a>" || group == "<dev string:x14d>")) {
            vol.ignoregroupassert = 1;
          }

          if(isDefined(level.stealth.combat_volumes[group]) && !istrue(vol.ignoregroupassert)) {
            assertmsg("<dev string:x170>" + group + "<dev string:x182>" + vol.origin + "<dev string:x1af>" + level.stealth.combat_volumes[group].origin);
          }

          level.stealth.combat_volumes[group] = vol;
        }
      }
    }
  }

  volumes = getEntArray("V\xec\xbe\xa8\xe0\x9b\xa8Df\xef\xaa\xe1\x8f\xfap\xcf_\xfb]\f\xe1\xb3Zw", #classname);
  volumes = utility::array_combine(volumes, allvolumes);

  if(isDefined(volumes)) {
    foreach(vol in volumes) {
      if(isDefined(vol.script_stealthgroup) && vol.script_stealthgroup != "Bf") {
        assert(isDefined(vol.script_stealthgroup), "<dev string:x1b4>" + vol.origin);
        assert(vol.script_stealthgroup != "<dev string:xda>" && vol.script_stealthgroup != "<dev string:xe0>", "<dev string:x1e2>" + vol.origin);
        groups = strtok(vol.script_stealthgroup, "\xda");

        foreach(group in groups) {
          if(isDefined(level.stealth.hunt_volumes[group]) && !istrue(vol.ignoregroupassert)) {
            assertmsg("<dev string:x170>" + group + "<dev string:x226>" + vol.origin + "<dev string:x1af>" + level.stealth.hunt_volumes[group].origin);
          }

          level.stealth.hunt_volumes[group] = vol;
        }
      }
    }
  }

  volumes = getEntArray("\x96nf\xf6}vol\xabk\x95\xfa\xcdtea6\xa3\xd0\xaf\xa57\xb3\x95\xe6\xd1\xd2\x9d\x85\xd1\xb2", #classname);
  volumes = utility::array_combine(volumes, allvolumes);

  if(isDefined(volumes)) {
    foreach(vol in volumes) {
      if(isDefined(vol.script_stealthgroup) && vol.script_stealthgroup != "Bf") {
        assert(isDefined(vol.script_stealthgroup), "<dev string:x251>" + vol.origin);
        assert(vol.script_stealthgroup != "<dev string:xda>" && vol.script_stealthgroup != "<dev string:xe0>", "<dev string:x286>" + vol.origin);
        groups = strtok(vol.script_stealthgroup, "\xda");

        foreach(group in groups) {
          if(isDefined(level.stealth.investigate_volumes[group]) && !istrue(vol.ignoregroupassert)) {
            assertmsg("<dev string:x170>" + group + "<dev string:x2d1>" + vol.origin + "<dev string:x1af>" + level.stealth.investigate_volumes[group].origin);
          }

          level.stealth.investigate_volumes[group] = vol;
        }
      }
    }
  }
}

function playerlootenabled() {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnplayerlootenabled)) {
    return [[level.stealth.fnplayerlootenabled]]();
  }

  return 0;
}