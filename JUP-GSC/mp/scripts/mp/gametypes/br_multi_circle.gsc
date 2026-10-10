/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_multi_circle.gsc
*******************************************************/

#using script_2d9d24f7c63ac143;
#using script_367c2e5a914658d7;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#using scripts\mp\weaponrank;
#namespace br_multi_circle;

function init() {
  if(getdvarint(@ "scr_br_multi_circle", 0) == 0) {
    return;
  }

  logstring("br_multi_circle::init");

  if(getdvarint(@ "hash_5bd161f5b9367829", 0) != 0) {
    scripts\mp\gametypes\br_gametypes::enablefeature("circleEarlyStart");
  }

  game["dialog"]["circle_split"] = "gmst_wzan_crsp";
  game["dialog"]["circle_merge"] = "gmst_wzan_crmr";
  game["dialog"]["circle_victory"] = "gmst_wzan_crsv";
  initleveldata();
  initmulticircleconfigdata();
  function_2a8bc5e4468a86dc();

  if(getdvarint(@ "hash_f4a50b0871efa9e9", 1) != 0) {
    scripts\mp\gametypes\br_circle::registercirclecallbacks(12, undefined, undefined, undefined, &function_cee78f828e373996);
  }

  level.var_80c1e8e18146024f = &function_fea1e6f98afb74f4;
}

function initleveldata() {
  level.br_circle.var_bf394857229861a5 = &function_1b21de2360beaff;
  level.var_2df69b8e552238b6 = 1;
  level.br_multi_circle = spawnStruct();
  level.br_multi_circle.circlecount = getdvarint(@ "hash_db9e0a9d41057bae", 1);
  level.br_multi_circle.splitindex = getdvarint(@ "hash_c87134a23557be72", 1);
  level.br_multi_circle.mergeindex = getdvarint(@ "hash_638da851601ca79a", 1);
  level.br_multi_circle.var_dfc65f80af9670de = getdvarfloat(@ "hash_8e7ef4c30d5b5a55", 0);
  level.br_multi_circle.var_117e933d19f2c221 = getdvarint(@ "hash_4e2f0d19a2f755ee", 1);
  level.br_multi_circle.var_7cee15a31694177c = getdvarint(@ "hash_dc93c4d0bfb9cf05", 1);
  level.br_multi_circle.var_28da030377a08f4a = getdvarint(@ "hash_8382dae948fa600f", 1);
  level.br_multi_circle.var_bc58018f3e4a64cc = getdvarfloat(@ "hash_9e74a59c2151d0a", 0.5);
  level.br_multi_circle.var_2e5bb265e73e668a = getdvarfloat(@ "hash_e87e2d1053dae898", 0.5);
  level.br_multi_circle.splittimescale = getdvarfloat(@ "hash_904276ad1475566a", 1);
  level.br_multi_circle.mergetimescale = getdvarfloat(@ "hash_389468ee25ff1dd2", 2);
  level.br_multi_circle.innertimescale = getdvarfloat(@ "hash_5d8995f6d065bc6", 0.5);
  level.br_multi_circle.var_f3ea1a173901b831 = getdvarint(@ "hash_744515d8c05e3243", 1);
  level.br_multi_circle.var_c73cd3ac9dde962f = getdvarint(@ "hash_c8f6fbc981b7f489", 0);
  level.br_multi_circle.damagedebug = getdvarint(@ "hash_317adf8ca39c83ae", 0);
  level.br_multi_circle.configs = [];
}

function initmulticircleconfigdata() {
  if(getdvarint(@ "hash_56bf37e58750811d", 0)) {
    return;
  }

  logstring("br_multi_circle::initMultiCircleConfigData");
  listref = getDvar(@ "scr_br_multi_circle_config_list", "jup_multicircleconfig_list");
  listbundle = getscriptbundle("multicircleconfiglist:" + listref);
  assertex(isDefined(listbundle), "<dev string:x1c>" + listref);

  if(isDefined(listbundle)) {
    foreach(entry in listbundle.config_list) {
      var_f5b9225aa3d3bc58 = "multicircleconfig:" + entry.config;
      config = getscriptbundle(var_f5b9225aa3d3bc58);
      assertex(isDefined(config), "<dev string:x55>" + var_f5b9225aa3d3bc58);

      if(isDefined(config)) {
        function_d0fdd965ed982f8f(config);
      }
    }
  }

  function_862a4b386242e67b();
  function_f92da29572a7dc78();
}

function function_f92da29572a7dc78() {
  if(!istrue(level.var_2df69b8e552238b6)) {
    return;
  }

  config = function_3ae1773696ab9337();
  function_8ff39b7a49d2bd92(config);
}

function function_d0fdd965ed982f8f(cfg) {
  assertex(isDefined(cfg.var_f5b9225aa3d3bc58), "<dev string:x89>");
  circleradii = undefined;

  if(isDefined(cfg.radius_list) && cfg.radius_list.size > 0) {
    assertex(isarray(cfg.radius_list) && cfg.mergeindex - cfg.splitindex + 1 == cfg.radius_list.size, "<dev string:xaf>");
    circleradii = [];

    for(i = 0; i < cfg.radius_list.size; i++) {
      circleradii[circleradii.size] = cfg.radius_list[i].radius;
    }
  }

  var_48380029fbb1007a = spawnStruct();
  var_48380029fbb1007a.name = default_to(cfg.var_f5b9225aa3d3bc58, "");
  var_48380029fbb1007a.weight = default_to(cfg.weight, 0);
  var_48380029fbb1007a.circlecount = cfg.circlecount;
  var_48380029fbb1007a.splitindex = cfg.splitindex;
  var_48380029fbb1007a.mergeindex = cfg.mergeindex;
  var_48380029fbb1007a.var_117e933d19f2c221 = default_to(cfg.var_117e933d19f2c221, 0);
  var_48380029fbb1007a.var_7cee15a31694177c = default_to(cfg.var_7cee15a31694177c, 0);
  var_48380029fbb1007a.var_28da030377a08f4a = default_to(cfg.var_28da030377a08f4a, 0);
  var_48380029fbb1007a.var_bc58018f3e4a64cc = default_to(cfg.var_d49d3b793f0995e, 0);
  var_48380029fbb1007a.var_2e5bb265e73e668a = default_to(cfg.var_80380656e112cb14, 0);
  var_48380029fbb1007a.var_672d4686b7455eb8 = default_to(cfg.var_9b248840395c2a72, 0);
  var_48380029fbb1007a.var_f4b1f848582fbe3e = default_to(cfg.var_13ab99b2a8cf8eb0, 0);
  var_48380029fbb1007a.splittimescale = default_to(cfg.splittimescale, 0);
  var_48380029fbb1007a.mergetimescale = default_to(cfg.mergetimescale, 0);
  var_48380029fbb1007a.innertimescale = default_to(cfg.innertimescale, 0);
  var_48380029fbb1007a.circleradii = circleradii;
  var_48380029fbb1007a.finalcircleoverride = default_to(cfg.finalcircleoverride, 0);
  var_48380029fbb1007a.var_fc8abdeeac961e8c = default_to(cfg.var_fc8abdeeac961e8c, 0);
  level.br_multi_circle.configs[var_48380029fbb1007a.name] = var_48380029fbb1007a;
}

function function_862a4b386242e67b() {
  foreach(config in level.br_multi_circle.configs) {
    var_de20025c62a6ebb9 = getdvarfloat(hashcat(@ "hash_11299b6aac0cc23e", config.name, "_first_circle"), -2);

    if(var_de20025c62a6ebb9 > -2) {
      var_de20025c62a6ebb9 = clamp(var_de20025c62a6ebb9, -1, 1);
      config.var_fc8abdeeac961e8c = var_de20025c62a6ebb9;
    }
  }

  var_161626a430526f7d = getDvar(@ "hash_a963ed27ec05a745", "");

  if(var_161626a430526f7d != "" && isDefined(level.br_multi_circle.configs[var_161626a430526f7d])) {
    level.br_multi_circle.var_161626a430526f7d = var_161626a430526f7d;
    return;
  }

  var_a0634e394fa7ae94 = [];

  foreach(config in level.br_multi_circle.configs) {
    overrideweight = getdvarfloat(hashcat(@ "hash_11299b6aac0cc23e", config.name, "_weight"), -1);

    if(overrideweight >= 0) {
      config.weight = overrideweight;
    }

    if(config.weight <= 0) {
      continue;
    }

    if(config.circlecount > 1 && function_e7f05a5632a76aea()) {
      continue;
    }

    var_a0634e394fa7ae94[config.name] = config;
  }

  level.br_multi_circle.configs = var_a0634e394fa7ae94;
}

function function_3ae1773696ab9337() {
  if(isDefined(level.br_multi_circle.var_161626a430526f7d)) {
    return level.br_multi_circle.configs[level.br_multi_circle.var_161626a430526f7d];
  }

  weightedsum = 0;

  foreach(config in level.br_multi_circle.configs) {
    weightedsum += config.weight;
  }

  randchoice = randomfloat(weightedsum);
  choicesum = 0;

  foreach(config in level.br_multi_circle.configs) {
    choicesum += config.weight;

    if(randchoice <= choicesum) {
      return config;
    }
  }

  return undefined;
}

function function_8ff39b7a49d2bd92(config) {
  if(!isDefined(config)) {
    return;
  }

  level.br_multi_circle.config = config;
  level.br_multi_circle.circlecount = config.circlecount;
  level.br_multi_circle.splitindex = config.splitindex;
  level.br_multi_circle.mergeindex = config.mergeindex;
  level.br_multi_circle.var_117e933d19f2c221 = config.var_117e933d19f2c221;
  level.br_multi_circle.var_7cee15a31694177c = config.var_7cee15a31694177c;
  level.br_multi_circle.var_28da030377a08f4a = config.var_28da030377a08f4a;
  level.br_multi_circle.var_bc58018f3e4a64cc = config.var_bc58018f3e4a64cc;
  level.br_multi_circle.var_2e5bb265e73e668a = config.var_2e5bb265e73e668a;
  level.br_multi_circle.var_672d4686b7455eb8 = config.var_672d4686b7455eb8;
  level.br_multi_circle.var_f4b1f848582fbe3e = config.var_f4b1f848582fbe3e;
  level.br_multi_circle.splittimescale = config.splittimescale;
  level.br_multi_circle.mergetimescale = config.mergetimescale;
  level.br_multi_circle.innertimescale = config.innertimescale;
  level.br_multi_circle.var_e60bfc21d3dced49 = undefined;
  logstring("br_multi_circle::applyMultiCircleConfig -> name=" + config.name + " count=" + config.circlecount + " split=" + config.splitindex + " merge=" + config.mergeindex);

  if(!isDefined(config.createfunc)) {
    if(getdvarint(@ "hash_dd0bab5c26cb2240", 1) == 1) {
      setDvar(@ "scr_br_circle_first_placement_scale", config.var_fc8abdeeac961e8c);
    }

    level.br_multi_circle.var_e60bfc21d3dced49 = config.finalcircleoverride;

    if(isDefined(config.splitindex) && isDefined(config.circleradii)) {
      for(i = 0; i < config.circleradii.size; i++) {
        level.br_level.br_circleradii[config.splitindex + i] = config.circleradii[i];
      }
    }
  }
}

function function_2a8bc5e4468a86dc() {
  if(level.br_multi_circle.circlecount > 1 && function_e7f05a5632a76aea()) {
    assertmsg("<dev string:xff>");
  }
}

function function_598312eb02c8eb61() {
  if(!istrue(level.var_2df69b8e552238b6)) {
    return;
  }

  function_b0f5ee01693ab2fd();
  function_d12a7c7251710cbf();
  config = level.br_multi_circle.config;

  if(isDefined(config) && isDefined(config.createfunc)) {
    function_99b71c1ba0ed78b5();
    [[config.createfunc]]();
  } else {
    function_e71987651701448a();
  }

  level notify("calc_circle_centers");
}

function function_1b21de2360beaff(circleindex) {
  minpct = 0;
  maxpct = 1;

  if(!function_49411683f5a51daa(circleindex)) {
    if(isDefined(level.br_multi_circle.var_672d4686b7455eb8)) {
      minpct = level.br_multi_circle.var_672d4686b7455eb8;
    }

    if(isDefined(level.br_multi_circle.var_f4b1f848582fbe3e)) {
      maxpct = level.br_multi_circle.var_f4b1f848582fbe3e;
    }
  }

  return [minpct, maxpct];
}

function function_16f6a495317c109d() {
  return function_676cfe2ab64ea758() / 1000;
}

function function_fea1e6f98afb74f4(var_7b6d5db8cb3c5782) {
  if(!istrue(level.var_2df69b8e552238b6)) {
    return;
  }

  function_ebfd46aa8754608();
  function_74c4ed830065b00c();
  level thread function_c6ca870b4cdff7d();

  if(istrue(var_7b6d5db8cb3c5782) && !scripts\mp\gametypes\br_gametypes::isfeatureenabled("circleEarlyStart")) {
    level waittill("infils_ready");
  }

  if(function_e7f05a5632a76aea()) {
    flag_wait("wztrain_anim_playing");
    callback::add("on_circle_set", &function_8a98a15c18897492, level.br_level.var_572a1674797a9fa8);
    callback::add("on_circle_started", &function_8a98a15c18897492, level.br_level.var_da8bd27126f360d7);
  }

  if(istrue(level.usegulag)) {
    scripts\mp\gametypes\br_gulag::setupgulagtimer();
  }

  level thread function_4c7e6f6847607c99();
  level thread function_5d02313c7d7c9d62();
  level thread function_d00dee714982522b();
  level thread function_70dab1712e13880c();
  level thread stopcirclesatgameend();
  level.br_circle.circleinittime = gettime();

  if(isDefined(level.br_level.br_circledelaytimes)) {
    for(i = 0; i < level.br_level.br_circledelaytimes.size; i++) {
      function_2d74067acccaf1a4(i);
    }
  }

  if(isDefined(level.var_20f62868a14ab570)) {
    foreach(callback in level.var_20f62868a14ab570) {
      [[callback]]();
    }
  }
}

function function_2d74067acccaf1a4(circleindex) {
  level endon("game_ended");
  level endon("br_ending_start");

  function_673b160b18fe0611();

  if(istrue(scripts\mp\gametypes\br_gametypes::runbrgametypefunc("circleTimer", circleindex))) {
    return;
  }

  level.br_circle.starttime = gettime();
  level.br_circle.circleindex = circleindex;
  var_f007ce073dc3c519 = circleindex == 0;
  var_6b890e6be7982efb = circleindex == level.br_level.br_circleclosetimes.size - 1;
  var_f2e5f195d91a8b4f = circleindex + 1 == level.br_multi_circle.splitindex;
  var_96ca8e35a7b219e3 = circleindex + 1 == level.br_multi_circle.mergeindex;
  var_4767c01df2fb3334 = function_6249dca788e0dff0();

  if(isDefined(var_4767c01df2fb3334)) {
    var_de3d7eab92efbdeb = var_4767c01df2fb3334 - 1;
    var_ce33e17e41f5adf4 = getdvarint(@ "hash_a72502fd7665f68a", 1);

    if(circleindex == var_de3d7eab92efbdeb) {
      callback::callback("on_circle_attach_to_train_pre");
    }

    if(circleindex == var_4767c01df2fb3334) {
      callback::callback("on_circle_attach_to_train");
      setomnvarforallclients("ui_publicevent_traincircle_active", 1);
    }

    var_582678f2774a4c82 = function_d6f728b66bd3966(circleindex);
    var_8cdf8ec86507d0dc = var_ce33e17e41f5adf4 && circleindex == var_de3d7eab92efbdeb;
  } else {
    var_582678f2774a4c82 = 0;
    var_8cdf8ec86507d0dc = 0;
  }

  prewaittime = level.br_level.br_circledelaytimes[circleindex];
  closetime = level.br_level.br_circleclosetimes[circleindex];
  targetradius = level.br_level.br_circleradii[circleindex + 1];

  if(!isDefined(level.var_e486acb8f70c45a2)) {
    if(function_fc0f865ddcf551ad()) {
      setomnvar("ui_br_circle_num", circleindex);
    } else {
      setomnvar("ui_br_circle_num", circleindex + 1);
    }
  }

  thread scripts\mp\gametypes\br_gulag::circletimer(circleindex);
  scripts\mp\gametypes\br_gametypes::runbrgametypefunc("circleTimerNext", circleindex);
  assertex(isDefined(level.br_level.br_circleminimapradii[circleindex]), "<dev string:x150>" + circleindex + "<dev string:x17a>");
  level thread br_lerp_minimap_zoom(circleindex);
  groundposcenter = level.br_level.br_circlecenters[circleindex + 1];
  level.br_circle.centertarget = groundposcenter;
  multicirclecount = function_d987886bb9de9137();

  if(function_e32a50f37301a6ab()) {
    function_f9b131d3d6eae27d(multicirclecount, var_6b890e6be7982efb);
  }

  function_2f4fb0777ebb4cc0();
  cleanupoutercrates();
  function_878eaeed15433716();
  centertargets = [];

  for(i = 0; i < multicirclecount; i++) {
    centertarget = level.br_multi_circle.circles[i].circlecenters[circleindex + 1];
    centertargets[i] = centertarget;
    circleents = level.br_multi_circle.circles[i].entdata;

    if(var_582678f2774a4c82) {
      circleents.safeent.origin = (circleents.dangerent.origin[0], circleents.dangerent.origin[1], targetradius);
      continue;
    }

    circleents.safeent.origin = (centertarget[0], centertarget[1], targetradius);
  }

  if(getdvarint(@ "scr_br_multi_circle_hide_with_delay", 0)) {
    scripts\mp\gametypes\br_circle_util::function_57f3fd16b628c829(circleindex);
  }

  var_dc59f76c34681ede = (var_f2e5f195d91a8b4f || var_96ca8e35a7b219e3) && multicirclecount != 1;
  level thread startuiclosetimer(prewaittime, var_f007ce073dc3c519, var_6b890e6be7982efb, circleindex, var_dc59f76c34681ede);

  for(i = 0; i < multicirclecount; i++) {
    circleents = level.br_multi_circle.circles[i].entdata;
    circleents.dangerui.origin = circleents.dangerent.origin;

    if(var_8cdf8ec86507d0dc) {
      circleents.safeui.origin = (circleents.dangerent.origin[0], circleents.dangerent.origin[1], targetradius);
      continue;
    }

    circleents.safeui.origin = circleents.safeent.origin;
  }

  wait function_16f6a495317c109d();

  for(i = 0; i < multicirclecount; i++) {
    circleents = level.br_multi_circle.circles[i].entdata;
    function_1139f778f794ff98(circleents.dangerent, circleents.safeui, circleents.dangerui, prewaittime, var_6b890e6be7982efb);
  }

  scripts\mp\gametypes\br_circle_util::playcircleopendialog(circleindex, var_f007ce073dc3c519);

  if(multicirclecount != 1 && !var_f007ce073dc3c519) {
    level thread function_9bb9abf5fd67056a(circleindex + 1, 1);
  }

  if(istrue(level.usegulag)) {
    level thread scripts\mp\gametypes\br_gulag::transitioncircle(targetradius, prewaittime);
  }

  level notify("br_circle_set");
  callback::callback("on_circle_set");

  if(var_f2e5f195d91a8b4f) {
    level notify("multi_circle_show_split");
  } else if(var_96ca8e35a7b219e3) {
    level notify("multi_circle_show_merge");
  }

  for(i = 0; i < multicirclecount; i++) {
    circleents = level.br_multi_circle.circles[i].entdata;

    if(var_582678f2774a4c82) {
      level thread function_111ebdee65ef6d36(circleents.dangerent);
      level thread function_111ebdee65ef6d36(circleents.dangerui);
      level thread function_111ebdee65ef6d36(circleents.safeent);
      level thread function_111ebdee65ef6d36(circleents.safeui);
      continue;
    }

    if(var_8cdf8ec86507d0dc) {
      level thread function_111ebdee65ef6d36(circleents.safeui);
    }
  }

  wait prewaittime;
  level notify("stop_circle_track_train");

  if(function_e32a50f37301a6ab()) {
    function_f9b131d3d6eae27d(multicirclecount, var_6b890e6be7982efb);
  }

  function_2f4fb0777ebb4cc0();

  if(multicirclecount > 1) {
    if(circleindex + 1 == level.br_multi_circle.splitindex) {
      level notify("multi_circle_split");
      scripts\mp\gametypes\br_analytics::function_14099f0f07c09e69(gettime());
    } else if(circleindex + 1 == level.br_multi_circle.mergeindex) {
      [playercounts, teamcounts] = function_59d0ab7e24248ad7();
      scripts\mp\gametypes\br_analytics::function_77c1c837c38efa21(gettime(), playercounts, teamcounts);
    }
  }

  level notify("br_circle_started");
  callback::callback("on_circle_started");
  level.circleclosing = 1;

  if(!isDefined(level.var_e486acb8f70c45a2)) {
    setomnvar("ui_hardpoint_timer", gettime() + int(closetime * 1000));
  }

  scripts\mp\gametypes\br_circle_util::playcircleclosedialog(circleindex, var_6b890e6be7982efb);

  if(multicirclecount != 1) {
    level thread function_9bb9abf5fd67056a(circleindex + 1, 0);
  }

  for(i = 0; i < multicirclecount; i++) {
    circleents = level.br_multi_circle.circles[i].entdata;
    circleents.safeui.origin = circleents.safeent.origin;
    circleents.dangerui.origin = circleents.dangerent.origin;
    function_898ca8fcdf7d6479(circleents.dangerent, circleents.safeui, circleents.dangerui, circleents.safeent, int(closetime), var_6b890e6be7982efb);

    if(var_582678f2774a4c82) {
      level thread function_111ebdee65ef6d36(circleents.dangerent, targetradius, closetime);
      level thread function_111ebdee65ef6d36(circleents.dangerui);
      level thread function_111ebdee65ef6d36(circleents.safeent);
      level thread function_111ebdee65ef6d36(circleents.safeui);
      continue;
    }

    circleents.dangerent brcirclemoveTo(centertargets[i][0], centertargets[i][1], targetradius, closetime);

    if(var_8cdf8ec86507d0dc) {
      level thread function_111ebdee65ef6d36(circleents.safeui);
    }
  }

  isplayingmusic = !istrue(level.br_circle.var_a0d948a339eee04) && !(isDefined(level.isstandardsandbox) && !level.isstandardsandbox);

  if(isplayingmusic) {
    level thread scripts\mp\music_and_dialog::function_a486df26072a530a(level.br_circle.circleindex, level.br_level.br_circleclosetimes.size, 0.4);
  }

  wait closetime;
  level notify("stop_circle_track_train");

  if(function_e32a50f37301a6ab()) {
    function_f9b131d3d6eae27d(multicirclecount, var_6b890e6be7982efb);
  }

  function_2f4fb0777ebb4cc0();

  if(multicirclecount > 1) {
    if(var_f2e5f195d91a8b4f) {
      level.br_multi_circle.issplit = 1;
      [playercounts, teamcounts] = function_59d0ab7e24248ad7();
      scripts\mp\gametypes\br_analytics::function_c3ca7338446f4fce(gettime(), playercounts, teamcounts);
    } else if(var_96ca8e35a7b219e3) {
      level.br_multi_circle.issplit = 0;
      level notify("multi_circle_merge");
      scripts\mp\gametypes\br_analytics::function_4eb4428fe15d7276(gettime());
    }
  }

  if(resetdangercircleorigin(circleindex)) {
    if(getdvarint(@ "hash_e0a1364a76dd764e", 1)) {
      for(i = 0; i < multicirclecount; i++) {
        circleents = level.br_multi_circle.circles[i].entdata;
        circleents.dangerent.origin = (centertargets[i][0], centertargets[i][1], targetradius);
      }
    }
  }

  level.circleclosing = 0;
  var_f2da81fb842e7a5e = 5;

  if(var_f2da81fb842e7a5e > 0 && circleindex < var_f2da81fb842e7a5e) {
    scripts\mp\rank::addglobalrankxpmultiplier(1.2, "cirlceMult_" + string(circleindex));
    scripts\mp\weaponrank::addweaponrankxpmultiplier(1.2, "cirlceMult_" + string(circleindex));
  }

  for(i = 0; i < multicirclecount; i++) {
    cleanupouterspawnclosets(centertargets[i], targetradius);
  }
}

function function_8a98a15c18897492(callbackparams, var_13971593b1ce5b80) {
  if(issharedfuncdefined("br_movingtrain", "changeCargoTrainSpeed")) {
    var_bf35557ed9dfccca = getsharedfunc("br_movingtrain", "changeCargoTrainSpeed");
  } else {
    assertmsg("<dev string:x1d6>");
    return;
  }

  circleindex = level.br_circle.circleindex;

  if(isDefined(var_13971593b1ce5b80[circleindex])) {
    thread[[var_bf35557ed9dfccca]](var_13971593b1ce5b80[circleindex], level.br_level.var_564911cbc1774914);
  }
}

function function_111ebdee65ef6d36(circleent, targetradius, closetime) {
  if(isDefined(targetradius) ^ isDefined(closetime)) {
    assertex(0, "<dev string:x20d>");
    return;
  }

  level endon("game_ended");
  level endon("br_ending_start");
  level endon("stop_circle_track_train");
  needslerp = isDefined(targetradius);
  starttime = gettime() / 1000;
  startradius = circleent.origin[2];
  curradius = startradius;

  while(true) {
    trainent = level.wztrain_info.animent["cargo_train"];

    if(isDefined(trainent)) {
      targetpos = trainent getorigin();

      if(needslerp && closetime > 0) {
        elapsed = gettime() / 1000 - starttime;
        curradius = lerp(startradius, targetradius, min(elapsed / closetime, 1));
      }

      circleent.origin = (targetpos[0], targetpos[1], curradius);
    }

    waitframe();
  }
}

function function_f9b131d3d6eae27d(multicirclecount, var_6b890e6be7982efb) {
  level endon("game_ended");
  level.br_circle endon("circle_unpaused");

  while(true) {
    for(i = 0; i < multicirclecount; i++) {
      circleents = level.br_multi_circle.circles[i].entdata;
      circleents.safeui.origin = circleents.safeent.origin;
      circleents.dangerui.origin = circleents.dangerent.origin;
      function_898ca8fcdf7d6479(circleents.dangerent, circleents.safeui, circleents.dangerui, circleents.safeent, int(16777), var_6b890e6be7982efb);
    }

    wait 1;
  }
}

function function_4c7e6f6847607c99(var_f1ad6948a2f3ff79) {
  level endon("game_ended");
  level endon("br_ending_start");

  while(level.br_circle.circleindex < 0) {
    waitframe();
  }

  if(scripts\mp\gametypes\br_gametypes::isfeatureenabled("circleEarlyStart")) {
    level waittill("infils_ready");
  }

  if(isDefined(var_f1ad6948a2f3ff79)) {
    wait var_f1ad6948a2f3ff79;
  }

  level notify("update_circle_hide");
}

function function_1139f778f794ff98(circleent, safeent, dangerent, duration, var_6b890e6be7982efb) {
  foreach(p in level.players) {
    if(!isbot(p)) {
      durationforplayer = _safecircledurationforplayer(p, duration);
      p setclientomnvar("ui_br_circle0_start_time", gettime());
      p setclientomnvar("ui_br_circle0_duration", durationforplayer);

      if(istrue(var_6b890e6be7982efb)) {
        p _hidesafecircleui();
      }

      durationforplayer = _dangercircledurationforplayer(p, duration);
      p setclientomnvar("ui_br_circle1_start_time", gettime());
      p setclientomnvar("ui_br_circle1_duration", durationforplayer);
    }
  }

  circleent function_f566102230d6730d(safeent, dangerent, dangerent);
  thread updatecirclehide(duration);
}

function function_898ca8fcdf7d6479(circleent, safeent, var_164900b8467e2e6f, var_e7e68ca013618514, duration, var_6b890e6be7982efb) {
  foreach(p in level.players) {
    if(!isbot(p)) {
      durationforplayer = _safecircledurationforplayer(p, duration);
      p setclientomnvar("ui_br_circle0_start_time", gettime());
      p setclientomnvar("ui_br_circle0_duration", durationforplayer);

      if(istrue(var_6b890e6be7982efb)) {
        p _hidesafecircleui();
      }

      durationforplayer = _dangercircledurationforplayer(p, duration);
      p setclientomnvar("ui_br_circle1_start_time", gettime());
      p setclientomnvar("ui_br_circle1_duration", durationforplayer);
    }
  }

  circleent function_f566102230d6730d(safeent, var_164900b8467e2e6f, var_e7e68ca013618514);
  thread updatecirclehide(duration);
}

function function_9bb9abf5fd67056a(circleindex, circleopen) {
  level endon("game_ended");
  level endon("br_ending_start");
  splashkey = undefined;
  var_25a76641870dd568 = undefined;

  if(circleindex == level.br_multi_circle.splitindex) {
    splashkey = "br_multi_circle_split";
    var_25a76641870dd568 = 10;
    scripts\mp\gametypes\br_public::brleaderdialog("circle_split");
  } else if(circleindex == level.br_multi_circle.mergeindex) {
    splashkey = "br_multi_circle_merge";
    var_25a76641870dd568 = 11;
    scripts\mp\gametypes\br_public::brleaderdialog("circle_merge");
  }

  if(!isDefined(splashkey)) {
    return;
  }

  if(circleopen) {
    splashkey += "_open";
  } else {
    splashkey += "_close";
  }

  foreach(player in level.players) {
    if(!isbot(player)) {
      if(!player scripts\mp\gametypes\br_public::isplayeringulag()) {
        player thread scripts\mp\hud_message::showsplash(splashkey);
      }

      player setclientomnvar("ui_br_circle_state", var_25a76641870dd568);
    }
  }

  if(level.br_multi_circle.var_c73cd3ac9dde962f) {
    wait 2;
    setomnvar("ui_minimap_pulse", 1);
    wait 2;
    setomnvar("ui_minimap_pulse", 0);
  }
}

function function_cee78f828e373996() {
  level.br_circle.dangercircleui.origin = getdangercircleorigin();
  level.br_circle.dangercircleent.origin = getdangercircleorigin();
  duration = getdvarint(@ "hash_d8db46472f1970a3", 300);

  foreach(player in level.players) {
    if(!isbot(player)) {
      player setclientomnvar("ui_br_circle0_start_time", 0);
      player setclientomnvar("ui_br_circle1_start_time", gettime());
      player setclientomnvar("ui_br_circle1_duration", int(duration * 1000));
      player setclientomnvar("ui_br_infil_started", 0);
    }
  }
}

function function_5d02313c7d7c9d62() {
  level endon("game_ended");
  level endon("br_ending_start");
  level endon("endCircleDamageTick");

  while(level.br_circle.circleindex < 0) {
    waitframe();
  }

  if(scripts\mp\gametypes\br_gametypes::isfeatureenabled("circleEarlyStart")) {
    level waittill("infils_ready");
  }

  level childthread function_d835881b2d4842d3();

  if(level.br_multi_circle.var_f3ea1a173901b831) {
    level childthread function_47d1a34bde08097d();

    if(istrue(getdvarint(@ "hash_72ae262a8559256", 0))) {
      level childthread function_eb2f52408ac501ac();
    }
  }
}

function function_d835881b2d4842d3() {
  var_a058dc250ace641d = function_ce6456364079cce7();

  while(true) {
    if(isDefined(level.br_circle.dangercircleent)) {
      damagetick = scripts\mp\gametypes\br_circle::function_b5597479d3e5b628();

      if(damagetick > 0) {
        foreach(player in level.players) {
          if(!isDefined(player) || !isDefined(player.origin)) {
            continue;
          }

          if(isDefined(player) && istrue(player.inairpocket)) {
            continue;
          }

          if(scripts\mp\gametypes\br_gametypes::isfeatureenabled("circleEarlyStart") && istrue(player.plotarmor)) {
            player function_6fcdea7a7060ce40();
            continue;
          }

          var_acfa1a113ba7d7c7 = 0;

          if(!ispointinmulticircledanger(player.origin) || function_d30c8f0e5abea93b(player.origin, 1)) {
            if(player cancircledamageplayer(player)) {
              var_acfa1a113ba7d7c7 = 1;
              player function_f8d9c5f59fc6c187();

              if(getdvarint(@ "scr_time_in_gas_damage_modifier_enabled", 0) == 1) {
                modifieddamagetick = player function_1e0f84e555b3de7d(var_a058dc250ace641d, damagetick);
              } else {
                modifieddamagetick = damagetick;
              }

              if(istrue(level.br_multi_circle.damagedebug)) {
                player iprintln("<dev string:x298>" + "<dev string:x2a4>" + modifieddamagetick + "<dev string:x2aa>");
              }

              gasmaskdamage = modifieddamagetick;

              if(isDefined(level.var_aa1aaed4a9b80d4b) && isDefined(level.var_152d5a9c5ac5cdad) && level.br_circle.circleindex <= level.var_aa1aaed4a9b80d4b) {
                gasmaskdamage *= level.var_152d5a9c5ac5cdad;
              }

              if(scripts\cp_mp\gasmask::function_27e68abe09612a13(player)) {
                if(scripts\mp\gametypes\br_pickups::function_f213f06eba604bbd(player)) {
                  if(istrue(player.var_a18181d8bdaa0dab)) {
                    player notify("gasmask_buffer_reset");
                  } else if(level.var_5312bc14bd5db377 > 0) {
                    player.var_a18181d8bdaa0dab = 1;
                    player thread scripts\mp\gametypes\br_pickups::function_a1d897962a19d27e();
                  }
                }

                if(istrue(player.var_a18181d8bdaa0dab)) {
                  if(!istrue(player.gasmaskequipped)) {
                    player function_81652bad17cd28bd(modifieddamagetick);
                  }

                  player scripts\cp_mp\gasmask::processdamage(gasmaskdamage);
                } else if(isDefined(player.gasmaskhealth) && player.gasmaskhealth <= 0) {
                  if(!istrue(player.var_e79884673ac9666e)) {
                    player scripts\mp\gametypes\br_pickups::function_4d16b9c52efa3b8();
                    player scripts\mp\gametypes\br_pickups::function_8e9b00a1d2b23d72();
                    player playsoundtoplayer("br_gas_mask_break_plr", player);
                  }
                } else {
                  if(!istrue(player.var_e79884673ac9666e)) {
                    player scripts\mp\gametypes\br_pickups::function_cdf7f2f6bd3207("br_multi_circle");
                  }

                  player scripts\cp_mp\gasmask::processdamage(gasmaskdamage);
                }
              } else {
                if(!istrue(player.var_e79884673ac9666e) && !function_260708c89a11f0c3(player)) {
                  player scripts\mp\gametypes\br_pickups::function_8e9b00a1d2b23d72();
                }

                player function_81652bad17cd28bd(modifieddamagetick);
              }

              if(namespace_aead94004cf4c147::isbackpackinventoryenabled()) {
                player namespace_aead94004cf4c147::function_5323bef1ad6244b9(gasmaskdamage);
              }
            } else {
              player function_6fcdea7a7060ce40();
            }
          } else {
            player function_6fcdea7a7060ce40();

            if(scripts\cp_mp\gasmask::hasgasmask(player)) {
              if(scripts\mp\gametypes\br_pickups::function_f213f06eba604bbd(player)) {
                if(istrue(player.var_a18181d8bdaa0dab)) {
                  player notify("gasmask_buffer_reset");
                } else if(level.var_5312bc14bd5db377 > 0) {
                  player.var_a18181d8bdaa0dab = 1;
                  player thread scripts\mp\gametypes\br_pickups::function_a1d897962a19d27e();
                }
              }

              if(istrue(player.var_a18181d8bdaa0dab)) {
                continue;
              } else if(!istrue(player.var_e79884673ac9666e)) {
                if(isDefined(player.gasmaskhealth) && player.gasmaskhealth <= 0) {
                  player playsoundtoplayer("br_gas_mask_break_plr", player);
                  player scripts\mp\gametypes\br_pickups::function_4d16b9c52efa3b8();
                } else {
                  player scripts\mp\gametypes\br_pickups::function_8206bc54a1ed73cb("br_multi_circle");
                }
              }
            }
          }

          if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
            player updateindangercirclestate(var_acfa1a113ba7d7c7);
          }

          if(var_acfa1a113ba7d7c7) {
            if(scripts\engine\utility::issharedfuncdefined("ftue", "player_action")) {
              player[[scripts\engine\utility::getsharedfunc("ftue", "player_action")]]("br_ftue_gas_damage");
            }
          }
        }
      }
    }

    wait 1;
  }
}

function function_47d1a34bde08097d() {
  wait 0.25;

  while(true) {
    scripts\mp\gametypes\br_circle_util::function_ebdd2e77a8ade959();
    wait 1;
  }
}

function function_eb2f52408ac501ac() {
  wait 0.5;

  while(true) {
    namespace_2ffd685c7e2d86a3::function_c4b698ed8dd5c33d();
    wait 1;
    namespace_2ffd685c7e2d86a3::function_974a505e30d0049c();
    wait 1;
  }
}

function function_d00dee714982522b() {
  if(scripts\mp\gametypes\br_circle_util::function_ea6cdf6492dfb4fa()) {
    return;
  }

  level endon("game_ended");
  level endon("br_ending_start");
  level endon("endCircleDamageTick");

  while(level.br_circle.circleindex < 0) {
    waitframe();
  }

  if(scripts\mp\gametypes\br_gametypes::isfeatureenabled("circleEarlyStart")) {
    level waittill("infils_ready");
  }

  while(true) {
    wait 1;

    if(isDefined(level.var_8a12e160a2617c92)) {
      foreach(var_7f590f6ae7f3bc83, var_d9dbca8ecf0dc293 in level.var_8a12e160a2617c92) {
        var_d9dbca8ecf0dc293 = array_removeundefined(var_d9dbca8ecf0dc293);

        foreach(hiddenobject in var_d9dbca8ecf0dc293) {
          safetime = function_f487a2a306e21bdb(hiddenobject.origin);

          if(safetime > 0) {
            delaythread(safetime, &function_e65c3ee9c7741955, hiddenobject, var_7f590f6ae7f3bc83);
          }
        }

        level.var_8a12e160a2617c92[var_7f590f6ae7f3bc83] = [];
      }
    }
  }
}

function function_e65c3ee9c7741955(obj, var_7f590f6ae7f3bc83) {
  if(!isDefined(obj)) {
    return;
  }

  var_bca649c8dd3208d8 = undefined;

  if(isDefined(level.var_725403a0618f5a10)) {
    var_bca649c8dd3208d8 = level.var_725403a0618f5a10[var_7f590f6ae7f3bc83];
  }

  if(isDefined(var_bca649c8dd3208d8)) {
    [[var_bca649c8dd3208d8]](obj);
  }
}

function function_878eaeed15433716() {
  if(!isDefined(level.br_pickups)) {
    return;
  }

  foreach(crate in level.br_pickups.crates) {
    if(isDefined(crate) && !function_27779e30fe4c0d62(crate.origin)) {
      level.br_pickups.outercrates[level.br_pickups.outercrates.size] = crate;
    }
  }
}

function function_70dab1712e13880c() {
  function_a5bc99d4d649f54b();
  function_4d4df5d8d091815();
}

function function_a5bc99d4d649f54b() {
  if(level.br_multi_circle.circlecount == 1) {
    return;
  }

  if(getdvarint(@ "hash_3250cdab1dfb0ac4", 1)) {
    return;
  }

  level endon("game_ended");
  level endon("br_ending_start");
  level endon("multi_circle_merge");
  level waittill("multi_circle_split");
  overlays = [];

  if(getdvarint(@ "hash_37133e3ee3beae30", 0)) {
    overlays = function_b378fd0a01e94537();
  }

  var_881f82e9f82546e7 = getdvarint(@ "hash_db6f837f9260ec08", 0);
  multicirclecount = function_d987886bb9de9137();

  while(true) {
    circleplayercount = [];
    var_13443b3cff3e3fe4 = [];

    for(i = 0; i < multicirclecount; i++) {
      circleplayercount[i] = 0;
      var_13443b3cff3e3fe4[i] = [];
    }

    foreach(player in level.players) {
      if(!isDefined(player) || !isalive(player) || player scripts\mp\gametypes\br_public::isplayeringulag()) {
        continue;
      }

      var_f2d6db8b91f22768 = 0;

      for(i = 0; i < multicirclecount; i++) {
        inside = 0;

        if(var_881f82e9f82546e7) {
          inside = function_783961b002f33360(player.origin, i);
        } else {
          inside = function_d277283fb9ad5d46(player.origin, i);
        }

        if(inside) {
          var_f2d6db8b91f22768 |= 1 << i;
          circleplayercount[i]++;

          if(isDefined(player.team)) {
            var_13443b3cff3e3fe4[i][player.team] = player.team;
          }
        }
      }

      player setclientomnvar("ui_br_multi_circle_player_data", var_f2d6db8b91f22768);
    }

    playercountpacked = 0;
    teamcountpacked = 0;
    circlecount = int(min(multicirclecount, 4));

    for(i = 0; i < circlecount; i++) {
      playercountpacked |= circleplayercount[i] << i * 8;
      teamcountpacked |= var_13443b3cff3e3fe4[i].size << i * 8;
    }

    setomnvar("ui_br_multi_circle_player_count", playercountpacked);
    setomnvar("ui_br_multi_circle_team_count", teamcountpacked);

    for(i = 0; i < circlecount; i++) {
      if(var_13443b3cff3e3fe4[i].size == 1) {
        function_7c70020cf67057ab(i, array_get_first_item(var_13443b3cff3e3fe4[i]));
      }

      if(isDefined(overlays[i])) {
        overlay = overlays[i];
        value = circleplayercount[i];

        if(getdvarint(@ "hash_7042bbd75f3ffc34", 1)) {
          value = var_13443b3cff3e3fe4[i].size;
        }

        overlay setvalue(value);
      }
    }

    wait 1;
  }
}

function function_4d4df5d8d091815() {
  setomnvar("ui_br_multi_circle_player_count", 0);
  setomnvar("ui_br_multi_circle_team_count", 0);
}

function function_59d0ab7e24248ad7() {
  circleplayercount = [];
  var_13443b3cff3e3fe4 = [];
  circleteamcount = [];
  multicirclecount = function_d987886bb9de9137();

  for(i = 0; i < multicirclecount; i++) {
    circleplayercount[i] = 0;
    var_13443b3cff3e3fe4[i] = [];
    circleteamcount[i] = 0;
  }

  for(i = multicirclecount; i < 4; i++) {
    circleplayercount[i] = -1;
    circleteamcount[i] = -1;
  }

  foreach(player in level.players) {
    if(!isDefined(player) || !isalive(player) || player scripts\mp\gametypes\br_public::isplayeringulag()) {
      continue;
    }

    for(i = 0; i < multicirclecount; i++) {
      if(function_d277283fb9ad5d46(player.origin, i)) {
        circleplayercount[i]++;

        if(isDefined(player.team)) {
          var_13443b3cff3e3fe4[i][player.team] = player.team;
        }
      }
    }
  }

  for(i = 0; i < multicirclecount; i++) {
    circleteamcount[i] = var_13443b3cff3e3fe4[i].size;
  }

  return [circleplayercount, circleteamcount];
}

function function_7c70020cf67057ab(index, team) {
  if(!getdvarint(@ "hash_76e1dbe6c4d5f900", 1)) {
    return;
  }

  if(!istrue(level.br_multi_circle.issplit)) {
    return;
  }

  circle = level.br_multi_circle.circles[index];

  if(!isDefined(circle) || istrue(circle.won)) {
    return;
  }

  circle.won = 1;
  function_398360bb754c9099(team);
  function_23753850f8e1a765(team);
  scripts\mp\gametypes\br_public::brleaderdialogteam("circle_victory", team);
}

function function_398360bb754c9099(team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(isalive(player) && !isbot(player) && !player scripts\mp\gametypes\br_public::isplayeringulag()) {
      player thread scripts\mp\hud_message::showsplash("br_multi_circle_winner");
    }
  }
}

function function_23753850f8e1a765(team) {
  rewardcash = getdvarint(@ "hash_28bd0ecbfe827fd1", 500);

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    player scripts\mp\gametypes\br_plunder::playerplunderpickup(rewardcash);
  }
}

function function_c6ca870b4cdff7d() {
  if(!getdvarint(@ "hash_ddf454c0808d773", 1) || level.br_multi_circle.circlecount == 1) {
    return;
  }

  level endon("game_ended");
  level endon("br_ending_start");
  level endon("multi_circle_show_merge");

  if(level.br_multi_circle.splitindex != 1) {
    level waittill("multi_circle_show_split");
  }

  function_560a6f9647ff9be6();
  level thread function_1ee81753adbe0cce();

  while(true) {
    multicirclecount = function_d987886bb9de9137();

    for(i = 0; i < multicirclecount; i++) {
      objid = level.br_multi_circle.circles[i].objid;
      pos = level.br_multi_circle.circles[i].entdata.safeent.origin;
      objpos = scripts\mp\gametypes\br_public::droptogroundmultitrace((pos[0], pos[1], 0));
      scripts\mp\objidpoolmanager::update_objective_position(objid, objpos);
    }

    level waittill("br_circle_set");
  }
}

function function_560a6f9647ff9be6() {
  objectiveids = [20, 21, 22, 23];
  objectiveicons = ["icon_waypoint_circle_a", "icon_waypoint_circle_b", "icon_waypoint_circle_c", "icon_waypoint_circle_d"];
  objectivelabels = [ &"MP_BR_INGAME/MULTI_CIRCLE_LABEL_ALPHA", &"MP_BR_INGAME/MULTI_CIRCLE_LABEL_BRAVO", &"MP_BR_INGAME/MULTI_CIRCLE_LABEL_CHARLIE", &"MP_BR_INGAME/MULTI_CIRCLE_LABEL_DELTA"];
  multicirclecount = function_d987886bb9de9137();

  for(i = 0; i < multicirclecount; i++) {
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(objid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "active", (0, 0, 0), objectiveicons[i], "icon_regular");
      scripts\mp\objidpoolmanager::function_79a1a16de6b22b2d(objid, objectiveids[i]);
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      function_a13e72e0427ecad2(objid, function_bf3237ab00fd71a1());
      objective_setlabel(objid, objectivelabels[i]);
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
      objective_sethideelevation(objid, 1);
      level.br_multi_circle.circles[i].objid = objid;
    }
  }
}

function function_1ee81753adbe0cce() {
  level waittill_any_3("game_ended", "br_ending_start", "multi_circle_show_merge");
  multicirclecount = function_d987886bb9de9137();

  for(i = 0; i < multicirclecount; i++) {
    objid = level.br_multi_circle.circles[i].objid;

    if(isDefined(objid)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(objid);
      level.br_multi_circle.circles[i].objid = undefined;
    }
  }
}

function function_e71987651701448a() {
  function_f0a1762eeb5ba01f();
  maxattempts = getdvarint(@ "hash_5741b69fc7803a21", 100);

  for(attempts = 0; attempts < maxattempts && function_bb8dc18fdc2c007a(); attempts++) {
    function_f0a1762eeb5ba01f();
  }
}

function function_b0f5ee01693ab2fd() {
  if(function_d987886bb9de9137() <= 1) {
    return;
  }

  splittimeindex = level.br_multi_circle.splitindex - 1;

  if(splittimeindex >= 0 && splittimeindex < level.br_level.br_circleclosetimes.size) {
    level.br_level.br_circleclosetimes[splittimeindex] *= level.br_multi_circle.splittimescale;
  }

  var_c048a22d8171b9f6 = level.br_multi_circle.mergeindex - 1;

  if(var_c048a22d8171b9f6 >= 0 && var_c048a22d8171b9f6 < level.br_level.br_circleclosetimes.size) {
    level.br_level.br_circleclosetimes[var_c048a22d8171b9f6] *= level.br_multi_circle.mergetimescale;
  }

  for(i = splittimeindex + 1; i < var_c048a22d8171b9f6; i++) {
    if(i < level.br_level.br_circleclosetimes.size) {
      level.br_level.br_circleclosetimes[i] *= level.br_multi_circle.innertimescale;
    }

    if(i < level.br_level.br_circledelaytimes.size) {
      level.br_level.br_circledelaytimes[i] *= level.br_multi_circle.innertimescale;
    }
  }
}

function private function_f0a1762eeb5ba01f() {
  if(!isDefined(level.br_level.br_circlecenters)) {
    return;
  }

  if(!isDefined(level.br_multi_circle)) {
    return;
  }

  level.br_multi_circle.circles = [];
  snaptonavmesh = getdvarint(@ "hash_67a8c844bad5a45b", 0);

  if(!snaptonavmesh && scripts\mp\gametypes\br_gametypes::isfeatureenabled("circleSnapToNavMesh")) {
    snaptonavmesh = 1;
  }

  multicirclecount = function_d987886bb9de9137();

  for(i = 0; i < multicirclecount; i++) {
    level.br_multi_circle.circles[i] = spawnStruct();
    level.br_multi_circle.circles[i].circlecenters = [];
  }

  splitindex = level.br_multi_circle.splitindex;
  mergeindex = level.br_multi_circle.mergeindex;
  splitcount = mergeindex - splitindex;

  if(level.br_multi_circle.circlecount == 1) {
    splitindex = level.br_level.br_circlecenters.size;
  }

  for(i = 0; i < multicirclecount; i++) {
    for(j = 0; j < splitindex; j++) {
      level.br_multi_circle.circles[i].circlecenters[j] = level.br_level.br_circlecenters[j];
    }
  }

  if(level.br_multi_circle.circlecount == 1) {
    return;
  }

  var_dfc65f80af9670de = level.br_multi_circle.var_dfc65f80af9670de;
  angleoffset = 360 / multicirclecount;
  splitoffset = getdvarfloat(@ "hash_7d2daa00c9da1e39", 0);

  if(getdvarint(@ "hash_79b501617ac641bd", 1)) {
    splitoffset += randomfloat(angleoffset) - angleoffset / 2;
  }

  splitpct = undefined;
  var_bc58018f3e4a64cc = level.br_multi_circle.var_bc58018f3e4a64cc;
  var_2e5bb265e73e668a = level.br_multi_circle.var_2e5bb265e73e668a;
  originindex = splitindex;

  if(istrue(level.br_multi_circle.var_28da030377a08f4a)) {
    originindex--;
  }

  origin = level.br_level.br_circlecenters[originindex];
  radius = level.br_level.br_circleradii[originindex];

  for(i = 0; i < multicirclecount; i++) {
    splitorigin = origin;
    theta = i * angleoffset + splitoffset;

    if(istrue(level.br_multi_circle.var_7cee15a31694177c)) {
      splitorigin = getrandompointinboundscircle(origin, radius, var_bc58018f3e4a64cc, var_2e5bb265e73e668a, 1, snaptonavmesh, 1, undefined, theta, theta);
    } else {
      thetaoffset = randomfloat(var_dfc65f80af9670de) - var_dfc65f80af9670de / 2;

      if(!isDefined(splitpct) || !istrue(level.br_multi_circle.var_117e933d19f2c221)) {
        splitpct = var_bc58018f3e4a64cc + randomfloat(var_2e5bb265e73e668a - var_bc58018f3e4a64cc);
      }

      theta += thetaoffset;
      originoffset = (radius * splitpct * cos(theta), radius * splitpct * sin(theta), 0);
      splitorigin = origin + originoffset;
    }

    level.br_multi_circle.circles[i].circlecenters[splitindex] = splitorigin;
  }

  if(splitcount > 1) {
    slicestart = splitindex;
    sliceend = splitindex + splitcount;
    circleradii = array_slice(level.br_level.br_circleradii, slicestart, sliceend);
    circleclosetimes = array_slice(level.br_level.br_circleclosetimes, slicestart, sliceend);

    for(i = 0; i < multicirclecount; i++) {
      origin = level.br_multi_circle.circles[i].circlecenters[splitindex];
      circlecenters = scripts\mp\gametypes\br_circle_util::calcsafecirclecenters(origin, circleradii, circleclosetimes, 1);

      if(isDefined(circlecenters)) {
        for(j = 1; j < circlecenters.size; j++) {
          newindex = level.br_multi_circle.circles[i].circlecenters.size;
          level.br_multi_circle.circles[i].circlecenters[newindex] = circlecenters[j];
        }
      }
    }
  }

  for(i = 0; i < multicirclecount; i++) {
    for(j = mergeindex; j < level.br_level.br_circlecenters.size; j++) {
      newindex = level.br_multi_circle.circles[i].circlecenters.size;
      level.br_multi_circle.circles[i].circlecenters[newindex] = level.br_level.br_circlecenters[j];
    }
  }

  if(getdvarint(@ "hash_4b45bb60c8b9d7a", 0) > 0) {
    movingcirclecount = level.br_level.br_movingcirclecount;
    snaptonavmesh = getdvarint(@ "hash_67a8c844bad5a45b", 0);

    if(!snaptonavmesh && scripts\mp\gametypes\br_gametypes::isfeatureenabled("circleSnapToNavMesh")) {
      snaptonavmesh = 1;
    }

    slicestart = mergeindex;
    sliceend = mergeindex + movingcirclecount + 1;
    circlecenters = array_slice(level.br_level.br_circlecenters, slicestart, sliceend);
    circleradii = array_slice(level.br_level.br_circleradii, slicestart, sliceend);
    movingcircles = scripts\mp\gametypes\br_circle_util::function_a09532919ae80718(movingcirclecount, circlecenters, circleradii, snaptonavmesh);

    if(isDefined(movingcircles)) {
      for(i = 0; i < multicirclecount; i++) {
        for(j = 0; j < movingcircles.size; j++) {
          newindex = level.br_multi_circle.circles[i].circlecenters.size;
          level.br_multi_circle.circles[i].circlecenters[newindex] = movingcircles[j];
        }
      }
    }
  }
}

function private function_bb8dc18fdc2c007a() {
  multicirclecount = function_d987886bb9de9137();

  if(multicirclecount <= 1) {
    return false;
  }

  var_2def3add71ff2d42 = getdvarfloat(@ "hash_6c976cff653fe181", 0.5);
  var_a9b2ebbbed787836 = getdvarfloat(@ "hash_2d35a2046d6899a9", 0.5);

  for(c = level.br_multi_circle.splitindex; c < level.br_multi_circle.mergeindex; c++) {
    radius = level.br_level.br_circleradii[c];

    if(radius == 0) {
      return false;
    }

    for(i = 0; i < multicirclecount - 1; i++) {
      for(j = i + 1; j < multicirclecount; j++) {
        origina = level.br_multi_circle.circles[i].circlecenters[c];
        originb = level.br_multi_circle.circles[j].circlecenters[c];
        dist = distance2d(origina, originb);
        pct = dist / 2 * radius;

        if(pct < var_2def3add71ff2d42) {
          return true;
        }
      }
    }
  }

  index = level.br_multi_circle.mergeindex - 1;

  if(index < 1) {
    return false;
  }

  for(i = 0; i < multicirclecount; i++) {
    origina = level.br_multi_circle.circles[i].circlecenters[index];
    originb = level.br_multi_circle.circles[i].circlecenters[index + 1];
    radiusa = level.br_level.br_circleradii[index];
    radiusb = level.br_level.br_circleradii[index + 1];

    if(radiusa + radiusb == 0) {
      return false;
    }

    dist = distance2d(origina, originb);
    pct = dist / (radiusa + radiusb);

    if(pct < var_a9b2ebbbed787836) {
      return true;
    }
  }

  return false;
}

function function_ebfd46aa8754608() {
  multicirclecount = function_d987886bb9de9137();

  for(i = 0; i < multicirclecount; i++) {
    var_8bebf2bfdbc76342 = level.br_multi_circle.circles[i].circlecenters[1];
    var_fb3aa9fba9719098 = level.br_level.br_circlecenters[0];
    safecircleent = spawn("script_model", (var_8bebf2bfdbc76342[0], var_8bebf2bfdbc76342[1], level.br_level.br_circleradii[1]));
    safecircleui = spawn("script_model", safecircleent.origin);
    dangercircleent = spawnbrcircle(var_fb3aa9fba9719098[0], var_fb3aa9fba9719098[1], level.br_level.br_circleradii[0]);
    dangercircleui = spawn("script_model", dangercircleent.origin);
    circleents = spawnStruct();
    circleents.safeent = safecircleent;
    circleents.safeui = safecircleui;
    circleents.dangerent = dangercircleent;
    circleents.dangerui = dangercircleui;
    level.br_multi_circle.circles[i].entdata = circleents;
    dangercircleent thread dangercircleenthidefromplayers();
    dangercircleent function_f566102230d6730d(safecircleent, dangercircleui, dangercircleui);
  }

  circleents = level.br_multi_circle.circles[0].entdata;
  level.br_circle.safecircleent = circleents.safeent;
  level.br_circle.safecircleui = circleents.safeui;
  level.br_circle.dangercircleent = circleents.dangerent;
  level.br_circle.dangercircleui = circleents.dangerui;
  level.br_circle.safecircleent.hidden = 0;
  level.br_circle.safecircleui.hidden = 0;
  level.br_circle.dangercircleent.hidden = 0;
  level.br_circle.dangercircleui.hidden = 0;
}

function function_99b71c1ba0ed78b5() {
  level.br_multi_circle.circles = [];
  multicirclecount = function_d987886bb9de9137();

  for(i = 0; i < multicirclecount; i++) {
    level.br_multi_circle.circles[i] = spawnStruct();
    level.br_multi_circle.circles[i].circlecenters = [];
  }
}

function function_74c4ed830065b00c() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleui)) {
    return;
  }

  multicirclecount = function_d987886bb9de9137();

  for(i = 0; i < multicirclecount; i++) {
    entdata = level.br_multi_circle.circles[i].entdata;

    if(isDefined(entdata) && isDefined(entdata.dangerent)) {
      entdata.dangerent show();
      entdata.dangerent hide(1);
    }
  }
}

function function_154cd3a077d16782() {
  level notify("<dev string:x2b0>");
  multicirclecount = function_d987886bb9de9137();

  for(i = 0; i < multicirclecount; i++) {
    level thread function_5d9c9221653df2f3(i);
  }
}

function function_5d9c9221653df2f3(circlenum) {
  if(!istrue(level.var_2df69b8e552238b6)) {
    return;
  }

  circle = level.br_multi_circle.circles[circlenum];

  if(!isDefined(circle)) {
    return;
  }

  level endon("<dev string:x2b0>");
  colors = [(1, 1, 1), (0.764706, 0.25098, 0.129412), (0.380392, 0.647059, 0.309804), (0.427451, 0.811765, 0.964706), (0.929412, 0.796078, 0.337255), (1, 0.0431373, 0.843137), (0.380392, 0.278431, 0.517647), (1, 0.658824, 0.647059), (0.380392, 0.780392, 0.803922), (1, 1, 1), (0.501961, 0.501961, 0.501961), (0.898039, 0.6, 0), (0, 0, 0), (0.929412, 0.796078, 0.337255)];
  firstcolorindex = 1;
  lastcolorindex = 1;
  skipcolor = [];
  skipcolor[firstcolorindex] = 1;
  skipcolor[lastcolorindex] = 1;
  skipcolor[0] = 1;
  skipcolor[9] = 1;
  skipcolor[10] = 1;
  skipcolor[12] = 1;
  skipcolor[13] = 1;
  thread function_714587ed175036c5();
  test_colors = ["<dev string:x2c6>", "<dev string:x2d0>", "<dev string:x2d8>"];

  for(spawnents = 1; true; spawnents = 0) {
    waitframe();
    colorindex = 0;

    for(circleindex = 0; circleindex < circle.circlecenters.size; circleindex++) {
      radius = level.br_level.br_circleradii[circleindex];
      center = circle.circlecenters[circleindex];

      if(circleindex == 0) {
        currentcolorindex = firstcolorindex;
      } else if(circleindex == circle.circlecenters.size - 1) {
        currentcolorindex = lastcolorindex;
      } else {
        while(istrue(skipcolor[colorindex])) {
          colorindex = (colorindex + 1) % colors.size;
        }

        currentcolorindex = colorindex;
        colorindex = (colorindex + 1) % colors.size;
      }

      color = colors[currentcolorindex];
      scripts\engine\utility::draw_circle(center, max(5, radius), color, 1, 0, 1);
      print3d(center, "<dev string:x2e2>" + circleindex + "<dev string:x2e8>" + radius, color, 1, 1, 1, 1);

      if(spawnents) {
        circleent = spawnStruct();
        circleent function_6b6b6273f8180522("<dev string:x2f0>" + test_colors[circleindex % test_colors.size], center, max(50, radius));
        circleent function_6988310081de7b45();
        circleent thread function_c3f32250a5b22066();
      }
    }
  }
}

function function_714587ed175036c5() {
  level endon("<dev string:x2b0>");
  level waittill("<dev string:x2ff>");
  thread function_154cd3a077d16782();
}

function function_cdabf323178aabc6() {
  level notify("<dev string:x316>");

  if(!istrue(level.var_2df69b8e552238b6)) {
    return;
  }

  level endon("<dev string:x316>");
  var_1a44ea2b73097af9 = "<dev string:x333>";
  var_3e610f2c94b5003a = "<dev string:x356>";
  trainicon = "<dev string:x36f>";
  var_b40ab23b53022209 = getsharedfunc("<dev string:x391>", "<dev string:x399>");
  multicirclecount = function_d987886bb9de9137();

  for(i = 0; i < multicirclecount; i++) {
    circle = level.br_multi_circle.circles[i];

    if(!isDefined(circle)) {
      return;
    }

    for(circleindex = 0; circleindex < circle.circlecenters.size; circleindex++) {
      center = circle.circlecenters[circleindex];
      markerid = [[var_b40ab23b53022209]](99);
      objective_state(markerid, "<dev string:x3af>");
      objective_icon(markerid, var_1a44ea2b73097af9);
      objective_position(markerid, center);
      level thread function_5da8967d6638d199(markerid);
    }
  }

  var_90169e022ac262d4 = [[var_b40ab23b53022209]](99);
  level thread function_5da8967d6638d199(var_90169e022ac262d4);

  if(level.br_level.var_8e40f29c8cdeb0f4) {
    var_ca131e6b449235d2 = [[var_b40ab23b53022209]](99);
    level thread function_5da8967d6638d199(var_ca131e6b449235d2);
  }

  while(true) {
    waitframe();
    curcircleindex = level.br_circle.circleindex;
    lastcircleindex = level.br_level.br_circleradii.size - 1 - level.br_level.br_movingcirclecount;

    if(curcircleindex < lastcircleindex) {
      objective_state(var_90169e022ac262d4, "<dev string:x3af>");
      objective_icon(var_90169e022ac262d4, var_3e610f2c94b5003a);
      objective_position(var_90169e022ac262d4, level.br_level.br_circlecenters[curcircleindex + 1]);
    }

    if(level.br_level.var_8e40f29c8cdeb0f4) {
      trainent = level.wztrain_info.animent["<dev string:x3b9>"];

      if(isDefined(trainent)) {
        trainpos = trainent.origin;
        objective_state(var_ca131e6b449235d2, "<dev string:x3af>");
        objective_icon(var_ca131e6b449235d2, trainicon);
        objective_position(var_ca131e6b449235d2, trainpos);
      }
    }
  }
}

function function_295e765fd8265c81() {
  level notify("<dev string:x316>");
}

function function_5da8967d6638d199(markerid) {
  level waittill("<dev string:x316>");
  var_1b8303c67ceb65ea = getsharedfunc("<dev string:x391>", "<dev string:x3c8>");
  [[var_1b8303c67ceb65ea]](markerid);
}

function function_f5b9be543604d16c() {
  level notify("<dev string:x3dd>");
  level endon("<dev string:x3dd>");
  var_576703236f9af9d2 = level.br_level.var_7c07216db79b7ecf;
  var_122e31d885c687af = level.br_level.var_c91272f3a25f1a9c;
  var_470ca2f7362b4ca8 = level.br_level.var_9ca5e77c0ae08bab;
  var_397178cf705a478f = level.br_level.var_af96b25973d3fe7e;

  if(!isDefined(var_397178cf705a478f)) {
    return;
  }

  while(true) {
    waitframe();
    var_8ce0e9aca2dc5c8a = [(1, 0, 1), (0, 1, 1)];
    offsetstep = 30;

    foreach(var_335247298b7df538, metadata in var_397178cf705a478f) {
      if(!function_d6f728b66bd3966(var_335247298b7df538)) {
        continue;
      }

      curcolor = var_8ce0e9aca2dc5c8a[var_335247298b7df538 % 2];
      var_8a63d7c71f56200e = offsetstep * (var_335247298b7df538 - function_6249dca788e0dff0() + 1);

      for(i = metadata.var_c517615f66fdfc88; i <= metadata.var_a38cece927aa04a8; i++) {
        startpos = var_576703236f9af9d2[i] + (0, 0, var_8a63d7c71f56200e);
        endpos = var_576703236f9af9d2[i + 1] + (0, 0, var_8a63d7c71f56200e);
        line(startpos, endpos, curcolor);
        var_a30e47e6f5523bd2 = 3;

        if(i == metadata.var_c517615f66fdfc88) {
          print3d(startpos, "<dev string:x3fc>" + string(var_335247298b7df538 + 1), curcolor);
          var_a30e47e6f5523bd2 = 10;
        }

        if(i == metadata.var_c517615f66fdfc88 + metadata.var_194f74574e93969c) {
          print3d(startpos, "<dev string:x406>" + string(var_335247298b7df538 + 1), curcolor);
          var_a30e47e6f5523bd2 = 10;
        }

        sphere(startpos, var_a30e47e6f5523bd2, curcolor);

        if(i == metadata.var_a38cece927aa04a8) {
          print3d(endpos, "<dev string:x410>" + string(var_335247298b7df538 + 1), curcolor);
          var_a30e47e6f5523bd2 = 10;
          sphere(endpos, var_a30e47e6f5523bd2, curcolor);
        }
      }
    }

    trainent = level.wztrain_info.animent["<dev string:x3b9>"];

    if(isDefined(trainent)) {
      trainpos = trainent.origin;
      sphere(trainent.origin, 10, (1, 1, 1));
    }
  }
}

function function_613d3dc4f3fd44d3() {
  level notify("<dev string:x3dd>");
}

function function_b378fd0a01e94537() {
  y_offset = 10;
  labels = [ &"MP/BR_MULTI_CIRCLE_LABEL_A", &"MP/BR_MULTI_CIRCLE_LABEL_B", &"MP/BR_MULTI_CIRCLE_LABEL_C", &"MP/BR_MULTI_CIRCLE_LABEL_D"];
  overlays = [];
  multicirclecount = function_d987886bb9de9137();

  for(i = 0; i < multicirclecount; i++) {
    overlay = function_7196fee664cfae44(labels[i], y_offset * i);
    overlay thread function_b0f35a515a8ee538();
    overlays[overlays.size] = overlay;
  }

  return overlays;
}

function function_7196fee664cfae44(label, yoffset) {
  hudelem = newhudelem();
  hudelem.label = label;
  hudelem.x = 720;
  hudelem.y = 50 + yoffset;
  hudelem.alignx = "right";
  hudelem.aligny = "middle";
  hudelem.sort = 1;
  hudelem.foreground = 1;
  hudelem.hidewheninmenu = 1;
  hudelem.alpha = 1;
  hudelem.fontscale = 1;
  hudelem.font = "objective";
  return hudelem;
}

function function_b0f35a515a8ee538() {
  level endon("game_ended");
  hudelem = self;
  level waittill("multi_circle_merge");

  if(isDefined(hudelem)) {
    hudelem destroy();
  }
}