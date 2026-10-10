/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_publicevents.gsc
*******************************************************/

#using script_294dda4a4b00ffe3;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\hud_message;
#using scripts\mp\utility\script;
#namespace br_publicevents;

function init() {
  level.var_34714ce799b6017 = 0;

  if(getdvarint(@ "hash_18afe7a288a4b1e4", 0)) {
    level notify("disable_public_event");
    return;
  }

  var_37ee364b712c7afc = function_3c3429141b476356();

  if(!isDefined(var_37ee364b712c7afc)) {
    return;
  }

  level.var_34714ce799b6017 = 1;
  level.var_b06bb395c37b7ab8 = getdvarint(@ "hash_965692fa542f0728", 1) == 1;
  level.var_3f6a099030787823 = function_ee26a62ef3d1372d(@ "hash_b5088319799172eb", 0, var_37ee364b712c7afc.var_bff1bf1b8c888d19);
  level.br_pe_data = [];
  level.var_5a7ffdf228d98c9f = function_ee26a62ef3d1372d(@ "hash_90afac1657855099", 2, var_37ee364b712c7afc.var_66d81af498488598);
  level.var_6f249acebd235065 = function_ee26a62ef3d1372d(@ "hash_23b4b411c19d8090", 5, var_37ee364b712c7afc.initialdelay);
  level.var_98e0b0cb95eacda2 = function_ee26a62ef3d1372d(@ "hash_a03801ae050ddf71", 8, var_37ee364b712c7afc.var_19514771c45f18e3);
  level.var_6ed09339da2b5658 = function_8fc51a5af06412cf(function_ba70ea4e80f22895(@ "hash_d3da8cf30df8bef5", "", var_37ee364b712c7afc.var_47dc5a64efcc13d8));
  level.var_5e45ff103cde1cc6 = 0;

  if(function_b1266056816b8716()) {
    level.var_5c60c997534512df = function_8fc51a5af06412cf(function_ba70ea4e80f22895(@ "hash_955b56c18d2a6100", "", var_37ee364b712c7afc.var_9a340a5b7388b5c6));
    level.var_88870d23daafa4a3 = function_542e227485e0fd62(var_37ee364b712c7afc.var_68f213b65ed34b12, "Overtime Events List");
  }

  level.var_606854b9c9f9bc18 = function_ee26a62ef3d1372d(@ "hash_6bfe84439d5b902e", 0, var_37ee364b712c7afc.var_4d41fcdf331d7c7);
  level.var_da99e5f67262b8c4 = function_542e227485e0fd62(var_37ee364b712c7afc.var_f0570e644ddd76ff, "Match-wide Events List");
  function_6de5b883b26a0f41(var_37ee364b712c7afc);
  scripts\mp\gametypes\br_dev::registerhandlecommand(&handledevcommand_publicevents);

  if(namespace_c711384b1335919::function_4ad287e0971672a6()) {
    level thread namespace_c711384b1335919::init();
  }

  thread function_72a208ea4ccd4f2b();
}

function function_72a208ea4ccd4f2b() {
  if(publiceventsenabled()) {
    if(function_8aaa3648604bf278()) {
      level thread function_a59044c0d9b0988b();
      return;
    }

    level thread publiceventsmanager();
  }
}

function function_6de5b883b26a0f41(var_37ee364b712c7afc) {
  level notify("init_public_event");

  foreach(var_7e93722a91573842 in var_37ee364b712c7afc.var_b57c449da2d093c3) {
    if(!isDefined(var_7e93722a91573842.event)) {
      continue;
    }

    reference = function_b5db7c8669703c35(var_7e93722a91573842.event);
    publiceventinit(reference, var_7e93722a91573842);
  }

  if(function_8aaa3648604bf278()) {
    var_5648fccda43a39da = spawnStruct();
    var_5648fccda43a39da.weight = 0;
    registerpublicevent("", var_5648fccda43a39da);
  }

  waittillframeend();
  function_42d775349af86f8b();
}

function function_42d775349af86f8b() {
  foreach(eventdata in level.br_pe_data) {
    if(eventdata.weight <= 0 && !function_beb7ed17efad9bd7(eventdata)) {
      continue;
    }

    if(isDefined(eventdata.validatefunc) && ![[eventdata.validatefunc]]()) {
      eventdata.isinvalid = 1;
      continue;
    }

    if(isDefined(eventdata.postinitfunc)) {
      eventdata[[eventdata.postinitfunc]]();
      eventdata.var_32b8f60180b1c127 = 1;
    }
  }
}

function function_4634160166fb7f8b(eventname, var_7b3a7c3f67ceb677) {
  var_3c5dfe64e9e89eb8 = getDvar(hashcat(@ "hash_abb46656d4b7e51c", eventname, "_circle_event_weights"), var_7b3a7c3f67ceb677);
  circleeventweights = [];

  if(var_3c5dfe64e9e89eb8 != "") {
    var_29eeb1cee9703a92 = strtok(var_3c5dfe64e9e89eb8, " ");

    foreach(weight in var_29eeb1cee9703a92) {
      circleeventweights[circleeventweights.size] = float(weight);
    }
  }

  return circleeventweights;
}

function function_8fc51a5af06412cf(string) {
  circleeventweights = [];
  var_29eeb1cee9703a92 = strtok(string, " ");

  foreach(weight in var_29eeb1cee9703a92) {
    circleeventweights[circleeventweights.size] = float(weight);
  }

  return circleeventweights;
}

function registerpublicevent(eventtype, eventinfo) {
  assert(isDefined(level.br_pe_data));
  assert(!isDefined(level.br_pe_data[eventtype]));

  if(!isDefined(eventinfo.active)) {
    eventinfo.active = 0;
  }

  if(!isDefined(eventinfo.weight)) {
    eventinfo.weight = 1;
  }

  if(function_8aaa3648604bf278()) {
    if(!isDefined(eventinfo.maxtimes)) {
      eventinfo.maxtimes = 1;
    }
  }

  level.br_pe_data[eventtype] = eventinfo;
  return eventinfo;
}

function function_44424d94254dfaf5() {
  cancelupcomingpublicevents();

  foreach(eventtype, eventdata in level.br_pe_data) {
    function_2907d01a7d692108(eventtype);
  }
}

function cancelupcomingpublicevents() {
  level notify("cancel_public_event");
  level.var_5e45ff103cde1cc6 = 0;
}

function publiceventsenabled() {
  if(!level.var_34714ce799b6017) {
    return 0;
  }

  forceeventtype = getDvar(@ "hash_c164d00b9c54b5b8", "");

  if(forceeventtype != "") {
    return 1;
  }

  if(function_8aaa3648604bf278()) {
    return function_79a1303427bfac85();
  }

  eventcount = getpubliceventcount();

  if(!eventcount) {
    return 0;
  }

  eventchance = getpubliceventchance();

  if(eventchance <= 0) {
    return 0;
  }

  return 1;
}

function shoulddopublicevent(currentcircle, var_cbf29c8a5f4eab27) {
  eventchance = getpubliceventchance();

  if(function_8aaa3648604bf278()) {
    if(istrue(var_cbf29c8a5f4eab27)) {
      eventchance = level.var_606854b9c9f9bc18;
    } else if(isDefined(currentcircle)) {
      if(isDefined(level.var_6ed09339da2b5658[currentcircle])) {
        eventchance = level.var_6ed09339da2b5658[currentcircle];
      } else {
        if(function_b1266056816b8716()) {
          function_1cddcb2898d7667("<dev string:x1c>" + currentcircle);
        } else {
          function_1cddcb2898d7667("<dev string:x73>" + currentcircle);
        }

        return false;
      }
    }
  }

  if(eventchance <= 0) {
    return false;
  }

  return randomfloat(1) <= eventchance;
}

function function_7ddadb6d5643bee4() {
  return level.var_5e45ff103cde1cc6 > 0;
}

function getpubliceventcount() {
  return getdvarint(@ "scr_br_pe_count", 1);
}

function getpubliceventchance() {
  return getdvarfloat(@ "scr_br_pe_chance", 0);
}

function multiplepubliceventsenabled() {
  numevents = getpubliceventcount();
  return numevents != 1;
}

function publiceventsmanager() {
  level endon("cancel_public_event");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(multiplepubliceventsenabled()) {
    var_6e6a77283e1803b1 = getdvarfloat(@ "hash_a02772622b60d034", 240);
    var_6e8d89283e3e72ff = getdvarfloat(@ "hash_a04a60622b86f056", 360);

    for(numevents = getpubliceventcount(); numevents; numevents--) {
      waittime = randomfloatrange(var_6e6a77283e1803b1, var_6e8d89283e3e72ff);
      wait waittime;

      if(shoulddopublicevent()) {
        choosepubliceventtype(1);
      }
    }

    return;
  }

  if(shoulddopublicevent()) {
    choosepubliceventtype(0);
  }
}

function validateevents() {
  validtypes = [];

  foreach(eventtype, eventdata in level.br_pe_data) {
    if(eventdata.weight <= 0) {
      function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:xca>");

      continue;
    }

    if(istrue(eventdata.isinvalid)) {
      function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:xee>");

      continue;
    }

    if(isDefined(eventdata.var_b22310d8fb6c98fa) && ![[eventdata.var_b22310d8fb6c98fa]]()) {
      function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:x12e>");

      continue;
    }

    function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:x166>");

    validtypes[validtypes.size] = eventtype;
  }

  return validtypes;
}

function function_92663f9d29e51479(eventtypes, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27) {
  var_2b63c409156776a5 = spawnStruct();
  var_2b63c409156776a5.types = [];
  var_2b63c409156776a5.weights = [];

  if(!istrue(var_cbf29c8a5f4eab27) && !istrue(var_4bd41ebbce2d3bb6)) {
    foreach(eventtype in eventtypes) {
      eventdata = level.br_pe_data[eventtype];
      assert(isDefined(eventdata));
      eventweight = eventdata.weight;
      weights = ter_op(var_fb5ad7615ebab353, eventdata.var_b9b56551e1acfee2, eventdata.circleeventweights);

      if(isDefined(currentcircle) && isDefined(weights) && isDefined(weights[currentcircle])) {
        eventweight = weights[currentcircle];
      }

      var_2b63c409156776a5.types[var_2b63c409156776a5.types.size] = eventtype;
      var_2b63c409156776a5.weights[var_2b63c409156776a5.weights.size] = eventweight;
    }
  } else if(istrue(var_cbf29c8a5f4eab27)) {
    weights = level.var_da99e5f67262b8c4.weights;

    foreach(eventtype in eventtypes) {
      if(!isDefined(weights[eventtype])) {
        continue;
      }

      var_2b63c409156776a5.types[var_2b63c409156776a5.types.size] = eventtype;
      var_2b63c409156776a5.weights[var_2b63c409156776a5.weights.size] = weights[eventtype];
    }
  } else {
    weights = level.var_88870d23daafa4a3.weights;

    foreach(eventtype in eventtypes) {
      if(!isDefined(weights[eventtype])) {
        continue;
      }

      var_2b63c409156776a5.types[var_2b63c409156776a5.types.size] = eventtype;
      var_2b63c409156776a5.weights[var_2b63c409156776a5.weights.size] = weights[eventtype];
    }
  }

  return var_2b63c409156776a5;
}

function getweightedsum(eventtypes, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27) {
  var_2b63c409156776a5 = function_92663f9d29e51479(eventtypes, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27);
  weightedsum = 0;

  foreach(weight in var_2b63c409156776a5.weights) {
    weightedsum += weight;
  }

  return weightedsum;
}

function findeventforchosenweight(eventtypes, chosenweight, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27) {
  var_2b63c409156776a5 = function_92663f9d29e51479(eventtypes, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27);
  weightedsum = 0;

  foreach(i, weight in var_2b63c409156776a5.weights) {
    weightedsum += weight;

    if(chosenweight <= weightedsum) {
      return var_2b63c409156776a5.types[i];
    }
  }

  return "";
}

function choosepubliceventtype(skipwait, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27) {
  if(!isDefined(var_fb5ad7615ebab353)) {
    var_fb5ad7615ebab353 = 0;
  }

  validtypes = undefined;

  if(function_8aaa3648604bf278() && !istrue(var_cbf29c8a5f4eab27) && !istrue(var_4bd41ebbce2d3bb6)) {
    function_1cddcb2898d7667("<dev string:x178>" + currentcircle);

    validtypes = function_aaee113bdf9d92b9(currentcircle, var_fb5ad7615ebab353);
  } else if(istrue(var_cbf29c8a5f4eab27)) {
    function_1cddcb2898d7667("<dev string:x199>");

    validtypes = function_95342049a868f70b(level.var_da99e5f67262b8c4);
  } else if(istrue(var_4bd41ebbce2d3bb6)) {
    function_1cddcb2898d7667("<dev string:x1c2>");

    validtypes = function_95342049a868f70b(level.var_88870d23daafa4a3);
  } else {
    validtypes = validateevents();
  }

  if(function_8aaa3648604bf278()) {
    assert(validtypes.size != 0, "<dev string:x1e2>");
  }

  weightedsum = getweightedsum(validtypes, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27);
  randchoice = randomfloat(weightedsum);
  eventtype = findeventforchosenweight(validtypes, randchoice, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27);

  function_1cddcb2898d7667("<dev string:x233>" + function_3c8848a3a11b2553(eventtype));

  forceeventtype = getDvar(@ "hash_c164d00b9c54b5b8", "");

  if(forceeventtype != "") {
    function_1cddcb2898d7667("<dev string:x247>" + function_3c8848a3a11b2553(forceeventtype));

    eventtype = function_40fd49171fad19d3(forceeventtype);
  }

  if(isDefined(currentcircle)) {
    circleindex = ter_op(isDefined(currentcircle), currentcircle, "<dev string:x26b>");
    println("<dev string:x276>" + circleindex + "<dev string:x290>" + function_3c8848a3a11b2553(eventtype));
  }

  level runpubliceventoftype(eventtype, skipwait, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27);
}

function activateevent(eventdata) {
  level endon("game_ended");
  level endon("cancel_public_event");
  level notify("br_pe_start");

  if(isDefined(eventdata.activatefunc)) {
    eventdata[[eventdata.activatefunc]]();
  }

  level.var_5e45ff103cde1cc6 -= 1;
  level notify("br_pe_end");
}

function function_7ef2b71b1d3c3a01(currenttimeinterval) {
  if(isDefined(currenttimeinterval) && isDefined(level.var_5c60c997534512df[currenttimeinterval + 1])) {
    if(isDefined(level.var_5c60c997534512df[currenttimeinterval])) {
      timetowait = level.var_5c60c997534512df[currenttimeinterval + 1] - level.var_5c60c997534512df[currenttimeinterval];

      if(timetowait < 0) {
        function_1cddcb2898d7667("<dev string:x296>" + currenttimeinterval + "<dev string:x2ab>");

        return -1;
      }

      return timetowait;
    }
  }

  return -1;
}

function runpubliceventoftype(eventtype, skipwait, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27) {
  level endon("game_ended");
  level endon("cancel_public_event");
  assert(eventtype == "<dev string:x2d8>" || isxhashasset(eventtype), "<dev string:x2dc>");

  if(eventtype == "" && !function_8aaa3648604bf278()) {
    function_1cddcb2898d7667("<dev string:x31e>");

    return;
  }

  eventdata = level.br_pe_data[eventtype];
  assert(isDefined(eventdata));

  if(isDefined(eventdata.waitfunc) && !skipwait) {
    eventdata[[eventdata.waitfunc]]();
  }

  if(getdvarint(@ "hash_a1b1b3ba057f4935", 1) > 0) {
    while(function_7ddadb6d5643bee4()) {
      level waittill_any_2("br_pe_end", "cancel_public_event");
      waitframe();
    }
  }

  level.var_5e45ff103cde1cc6 += 1;
  var_8762815dfed51fdf = function_f28fd66285fa2c9(eventtype);
  eventdata.active = 1;
  scripts\mp\gametypes\br_analytics::branalytics_publiceventstarted(var_8762815dfed51fdf);
  scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onPublicEvent", var_8762815dfed51fdf, "start");

  if(function_8aaa3648604bf278() && !istrue(var_cbf29c8a5f4eab27)) {
    level.var_608e8df77c8e41c7 = 1;

    function_1cddcb2898d7667("<dev string:x342>" + function_3c8848a3a11b2553(eventtype));

    level thread activateevent(eventdata);

    if(!istrue(var_fb5ad7615ebab353)) {
      if(!isDefined(level.var_a926065139739a2d)) {
        level.var_a926065139739a2d = [];
      }

      if(!isDefined(level.var_a926065139739a2d[eventtype])) {
        level.var_a926065139739a2d[eventtype] = 0;
      }

      level.var_a926065139739a2d[eventtype]++;

      if(isDefined(currentcircle)) {
        level.var_deb29f8358c3a6cb[eventtype] = currentcircle;
      }
    }

    if(!istrue(var_4bd41ebbce2d3bb6)) {
      if(function_b1266056816b8716()) {
        waittime = function_7ef2b71b1d3c3a01(currentcircle);

        if(waittime >= 0) {
          wait waittime;
        } else {
          scripts\mp\flags::gameflagwait("overtime_started");
          level.var_8f19fadbf63fbc0 = 1;
        }
      } else {
        level waittill("br_circle_set");
      }

      function_2907d01a7d692108(eventtype);
      level notify("select_new_event");
    }

    return;
  }

  if(istrue(var_cbf29c8a5f4eab27)) {
    level.var_c2ed1a34fb9c867d = eventtype;
    var_f4f62e014a42208b = level.var_5e45ff103cde1cc6;

    function_1cddcb2898d7667("<dev string:x342>" + function_3c8848a3a11b2553(eventtype));

    level thread activateevent(eventdata);

    if(var_f4f62e014a42208b == level.var_5e45ff103cde1cc6) {
      assertmsg("<dev string:x358>" + function_3c8848a3a11b2553(eventtype) + "<dev string:x36c>");
    }

    function_2907d01a7d692108(eventtype);
    return;
  }

  level activateevent(eventdata);

  if(istrue(eventdata.active)) {
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onPublicEvent", var_8762815dfed51fdf, "end");
  }

  eventdata.active = 0;
  scripts\mp\gametypes\br_analytics::branalytics_publiceventended(var_8762815dfed51fdf);
}

function function_2907d01a7d692108(eventtype) {
  if(ispubliceventoftypeactive(eventtype)) {
    var_8762815dfed51fdf = function_f28fd66285fa2c9(eventtype);
    eventdata = level.br_pe_data[eventtype];

    if(isDefined(eventdata.deactivatefunc)) {
      eventdata[[eventdata.deactivatefunc]]();
    }

    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onPublicEvent", var_8762815dfed51fdf, "end");
    eventdata.active = 0;
    scripts\mp\gametypes\br_analytics::branalytics_publiceventended(var_8762815dfed51fdf);
  }
}

function ispubliceventoftypeactive(eventtype) {
  if(!level.var_34714ce799b6017 || !isDefined(level.br_pe_data)) {
    return false;
  }

  eventdata = level.br_pe_data[eventtype];

  if(!isDefined(eventdata)) {
    return false;
  }

  return istrue(eventdata.active);
}

function showsplashtoall(splashname, var_42b1e877ab187c6) {
  foreach(player in level.players) {
    player scripts\mp\hud_message::showsplash(splashname, undefined, undefined, undefined, undefined, var_42b1e877ab187c6);
  }
}

function function_6ef55ffe74b87a74(waittime) {
  level endon("game_ended");

  if(isDefined(waittime)) {
    wait waittime;
  }

  setomnvar("ui_minimap_pulse", 0);
}

function function_e37ee072d95a7c98(eventtype) {
  level notify("<dev string:x398>");
  level endon("<dev string:x398>");
  level.var_5e45ff103cde1cc6 = 0;
  var_35299ef591e15919 = function_40fd49171fad19d3(eventtype);

  if(!isDefined(level.br_pe_data[var_35299ef591e15919])) {
    var_98a1e57d4147ddcd = spawnStruct();
    [[level.var_5f038a998555089e[var_35299ef591e15919]]](var_98a1e57d4147ddcd);
    registerpublicevent(var_35299ef591e15919, var_98a1e57d4147ddcd);
  }

  if(!istrue(level.br_pe_data[var_35299ef591e15919].var_32b8f60180b1c127)) {
    level.br_pe_data[var_35299ef591e15919][[level.br_pe_data[var_35299ef591e15919].postinitfunc]]();
    level.br_pe_data[var_35299ef591e15919].var_32b8f60180b1c127 = 1;
  }

  level runpubliceventoftype(var_35299ef591e15919, 1);
}

function handledevcommand_publicevents(command, args) {
  switch (command) {
    case #"hash_94b933c8d88ea90f":
      thread function_e37ee072d95a7c98(args[0]);
      break;
  }
}

function function_8aaa3648604bf278() {
  return istrue(level.var_b06bb395c37b7ab8);
}

function function_b1266056816b8716() {
  return istrue(level.var_3f6a099030787823);
}

function function_826d1843088ff270() {
  level endon("game_ended");
  level waittill("bmo_overtime_start");
  level thread choosepubliceventtype(1, undefined, 0, 1);
}

function function_79a1303427bfac85() {
  if(scripts\mp\gametypes\br_gametypes::isfeatureenabled("customGametypeCircles")) {
    flags::function_1240434f4201ac9d("customGametypeCirclesInit");
  }

  if(level.var_606854b9c9f9bc18 > 0) {
    return 1;
  }

  var_d788440e9c4b0193 = getdvarint(@ "hash_f6d47ba2ae075d35", level.br_level.br_circleradii.size - 1);

  if(var_d788440e9c4b0193 <= 0) {
    return 0;
  }

  var_9fa6c50b17cd398e = 0;

  foreach(chance in level.var_6ed09339da2b5658) {
    if(chance > 0) {
      var_9fa6c50b17cd398e = 1;
      break;
    }
  }

  return var_9fa6c50b17cd398e;
}

function function_a59044c0d9b0988b() {
  level endon("cancel_public_event");
  level endon("game_ended");

  if(shoulddopublicevent(undefined, 1)) {
    level choosepubliceventtype(1, undefined, undefined, 0, 1);
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  level.var_a926065139739a2d = [];
  level.var_deb29f8358c3a6cb = [];
  var_93fe8081bd477cb7 = 0;
  var_d788440e9c4b0193 = 0;
  var_1bc1989068d1a2de = 0;

  if(!function_b1266056816b8716()) {
    var_d788440e9c4b0193 = getdvarint(@ "hash_f6d47ba2ae075d35", level.br_level.br_circleradii.size - 1);
    var_1bc1989068d1a2de = level.br_level.br_circleradii.size - 1;
  } else {
    var_417eaacaac86d96e = level.var_5c60c997534512df.size;
    var_d788440e9c4b0193 = getdvarint(@ "hash_f6d47ba2ae075d35", var_417eaacaac86d96e);
    var_1bc1989068d1a2de = var_417eaacaac86d96e;
  }

  while(var_93fe8081bd477cb7 < var_1bc1989068d1a2de) {
    if(var_93fe8081bd477cb7 == 0) {
      if(!function_b1266056816b8716()) {
        level waittill("br_circle_set");
      } else {
        level thread function_826d1843088ff270();
        wait level.var_5c60c997534512df[0];
      }

      wait level.var_6f249acebd235065;
    } else {
      if(istrue(level.var_608e8df77c8e41c7) || function_b1266056816b8716()) {
        level waittill("select_new_event");
      } else {
        level waittill("br_circle_set");
      }

      wait level.var_98e0b0cb95eacda2;
    }

    if(isDefined(level.var_383825619799549) && level.var_383825619799549 == 0) {
      skipwait = 0;
    } else {
      skipwait = 1;
    }

    currentcircle = var_93fe8081bd477cb7;

    if(!function_b1266056816b8716()) {
      currentcircle = level.br_circle.circleindex;
    }

    if(istrue(level.var_8f19fadbf63fbc0)) {
      level thread choosepubliceventtype(1, currentcircle, 0, 1);
    } else if(shoulddopublicevent(currentcircle)) {
      level thread choosepubliceventtype(skipwait, currentcircle, 0);
    } else {
      println("<dev string:x276>" + currentcircle + "<dev string:x3bb>");
      level notify("br_pe_no_event");
      level.var_608e8df77c8e41c7 = 0;
    }

    var_93fe8081bd477cb7++;
  }
}

function function_aaee113bdf9d92b9(currentcircle, var_fb5ad7615ebab353) {
  validtypes = [];

  foreach(eventtype, eventdata in level.br_pe_data) {
    if(eventdata.weight <= 0) {
      function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:xca>");

      continue;
    }

    if(istrue(eventdata.isinvalid)) {
      function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:xee>");

      continue;
    }

    if(isDefined(eventdata.var_b22310d8fb6c98fa) && ![[eventdata.var_b22310d8fb6c98fa]]()) {
      function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:x12e>");

      continue;
    }

    weights = ter_op(var_fb5ad7615ebab353, eventdata.var_b9b56551e1acfee2, eventdata.circleeventweights);

    if(isDefined(weights)) {
      if(isDefined(weights[currentcircle]) && weights[currentcircle] <= 0) {
        function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:xca>");

        continue;
      } else if(!isDefined(weights[currentcircle])) {
        function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:x3c5>" + currentcircle);

        continue;
      }
    }

    if(!istrue(var_fb5ad7615ebab353)) {
      if(isDefined(level.var_a926065139739a2d) && isDefined(level.var_a926065139739a2d[eventtype])) {
        if(isDefined(eventdata.maxtimes) && level.var_a926065139739a2d[eventtype] >= eventdata.maxtimes) {
          function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:x407>");

          continue;
        }
      }

      if(isDefined(level.var_deb29f8358c3a6cb) && isDefined(level.var_deb29f8358c3a6cb[eventtype])) {
        var_a8239a74fb8ad784 = currentcircle - level.var_deb29f8358c3a6cb[eventtype];

        if(var_a8239a74fb8ad784 >= level.var_5a7ffdf228d98c9f + 1) {
          level.var_deb29f8358c3a6cb[eventtype] = undefined;
        } else {
          function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:x43f>");

          continue;
        }
      }
    }

    function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:x166>");

    validtypes[validtypes.size] = eventtype;
  }

  if(validtypes.size == 0) {
    validtypes[validtypes.size] = "";
  }

  return validtypes;
}

function function_1cddcb2898d7667(message) {
  if(getdvarint(@ "hash_909fa2d0703b8e6b", 0) == 1) {
    logstring("<dev string:x4a7>" + message);
  }
}

function function_beb7ed17efad9bd7(eventdata) {
  if(isDefined(eventdata.var_b9b56551e1acfee2)) {
    foreach(weight in eventdata.var_b9b56551e1acfee2) {
      if(weight > 0) {
        return true;
      }
    }
  }

  return false;
}

function function_3c3429141b476356() {
  var_8ab7165a9397f507 = getDvar(@ "scr_br_publiceventlist", "jup_publiceventlist_none");
  var_37ee364b712c7afc = getscriptbundle("publiceventlist:" + var_8ab7165a9397f507);

  if(!isDefined(var_37ee364b712c7afc)) {
    scripts\mp\utility\script::demoforcesre("Public event list \"" + var_8ab7165a9397f507 + "\" not found. Make sure it's included in feature target");
    return undefined;
  }

  function_1cddcb2898d7667("<dev string:x4af>" + var_8ab7165a9397f507 + "<dev string:x4cf>");

  return var_37ee364b712c7afc;
}

function function_dbc8f6cb3760cd82(reference, callback) {
  if(!isDefined(level.var_5f038a998555089e)) {
    level.var_5f038a998555089e = [];
  }

  level.var_5f038a998555089e[reference] = callback;
}

function publiceventinit(reference, eventinfo) {
  if(!isDefined(reference)) {
    return;
  }

  var_35299ef591e15919 = function_40fd49171fad19d3(reference);

  if(!isDefined(level.var_5f038a998555089e) || !isDefined(level.var_5f038a998555089e[var_35299ef591e15919])) {
    scripts\mp\utility\script::demoforcesre("Public event reference \"" + reference + "\" found in scriptbundle but no init callback was registered");
    return;
  }

  [[level.var_5f038a998555089e[var_35299ef591e15919]]](eventinfo);
  eventinfo.circleeventweights = function_8fc51a5af06412cf(eventinfo.circleweights);
  eventinfo.var_b9b56551e1acfee2 = namespace_c711384b1335919::function_8be9bae8228a91f7(reference);
  function_5b7d8ca93f8705f1(eventinfo, reference);
  registerpublicevent(var_35299ef591e15919, eventinfo);
}

function function_542e227485e0fd62(bundlelist, var_41e131919f4114ca) {
  if(!isDefined(var_41e131919f4114ca)) {
    var_41e131919f4114ca = "";
  }

  var_7cccf2ef95abbdd = spawnStruct();
  var_7cccf2ef95abbdd.types = [];
  var_7cccf2ef95abbdd.weights = [];

  var_7cccf2ef95abbdd.var_41e131919f4114ca = var_41e131919f4114ca;

  foreach(var_390ae3dd8694d9dc in bundlelist) {
    if(!isDefined(var_390ae3dd8694d9dc.event)) {
      continue;
    }

    reference = function_b5db7c8669703c35(var_390ae3dd8694d9dc.event);
    var_35299ef591e15919 = function_40fd49171fad19d3(reference);
    var_7cccf2ef95abbdd.types[var_7cccf2ef95abbdd.types.size] = var_35299ef591e15919;
    var_7cccf2ef95abbdd.weights[var_35299ef591e15919] = var_390ae3dd8694d9dc.weight;
  }

  return var_7cccf2ef95abbdd;
}

function function_95342049a868f70b(var_7215713679c3b0a4) {
  validtypes = [];

  foreach(eventtype in var_7215713679c3b0a4.types) {
    if(var_7215713679c3b0a4.weights[eventtype] <= 0) {
      function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:xca>");

      continue;
    }

    if(!isDefined(level.br_pe_data[eventtype])) {
      var_4f23da738d0b2f28 = default_to(var_7215713679c3b0a4.var_41e131919f4114ca, "<dev string:x2d8>");
      scripts\mp\utility\script::demoforcesre("<dev string:x4d4>" + function_3c8848a3a11b2553(eventtype) + "<dev string:x4e1>" + var_4f23da738d0b2f28 + "<dev string:x4ee>");

      continue;
    }

    if(istrue(level.br_pe_data[eventtype].isinvalid)) {
      function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:xee>");

      continue;
    }

    if(isDefined(level.br_pe_data[eventtype].var_b22310d8fb6c98fa) && ![[level.br_pe_data[eventtype].var_b22310d8fb6c98fa]]()) {
      function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:x12e>");

      continue;
    }

    function_1cddcb2898d7667(function_3c8848a3a11b2553(eventtype) + "<dev string:x166>");

    validtypes[validtypes.size] = eventtype;
  }

  if(validtypes.size == 0) {
    validtypes[validtypes.size] = "";
  }

  return validtypes;
}

function function_5b7d8ca93f8705f1(eventinfo, eventname) {
  dvarbase = hashcat(@ "hash_abb46656d4b7e51c", eventname, "_");
  eventinfo.weight = getdvarfloat(hashcat(dvarbase, "weight"), eventinfo.weight);
  eventinfo.maxtimes = getdvarint(hashcat(dvarbase, "max_times"), eventinfo.maxtimes);
  circleweights = getDvar(hashcat(dvarbase, "circle_weights"), "");

  if(circleweights != "") {
    eventinfo.circleeventweights = function_8fc51a5af06412cf(circleweights);
  }

  if(isDefined(level.var_da99e5f67262b8c4)) {
    var_a3927c3bdc0413f = function_40fd49171fad19d3(eventname);
    var_ce86475e613bffff = level.var_da99e5f67262b8c4.weights[var_a3927c3bdc0413f];

    if(isDefined(var_ce86475e613bffff)) {
      level.var_da99e5f67262b8c4.weights[var_a3927c3bdc0413f] = getdvarfloat(hashcat(dvarbase, "matchwide_weight"), var_ce86475e613bffff);
    }
  }
}

function function_b5db7c8669703c35(var_a7708841b4fa7e4d) {
  eventbundle = getscriptbundle("publicevent:" + var_a7708841b4fa7e4d);

  if(!isDefined(eventbundle)) {
    scripts\mp\utility\script::demoforcesre("Could not find publicevent asset: " + var_a7708841b4fa7e4d);
    return undefined;
  }

  return eventbundle.ref;
}