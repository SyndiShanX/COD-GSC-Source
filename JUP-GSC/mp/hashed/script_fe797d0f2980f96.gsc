/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_fe797d0f2980f96.gsc
************************************************/

#using script_3e34d236a84cfd96;
#using script_638d701d263ee1ed;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_1cb5f1cc1f98b618;

function function_79f6b9ffeb872713() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_b23a59dfb4ca49a1("<dev string:x2e>", "<dev string:x49>", &function_50a8580a8b718b47);
  function_b23a59dfb4ca49a1("<dev string:x6b>", "<dev string:x87>", &function_50a8580a8b718b47);
  function_a9a864379a098ad6("<dev string:xaa>", "<dev string:xbd>", &function_42693079c84f5e6b, 1);
  function_b23a59dfb4ca49a1("<dev string:xd0>", "<dev string:xef>" + "<dev string:x104>", &function_1410eff963fa3b85, 1);
  function_b23a59dfb4ca49a1("<dev string:x110>", "<dev string:xef>" + "<dev string:x12e>", &function_1410eff963fa3b85, 1);
  function_b23a59dfb4ca49a1("<dev string:x13a>", "<dev string:xef>" + "<dev string:x159>", &function_1410eff963fa3b85, 1);
  function_b23a59dfb4ca49a1("<dev string:x166>", "<dev string:xef>" + "<dev string:x181>", &function_1410eff963fa3b85, 1);
  function_b23a59dfb4ca49a1("<dev string:x18b>", "<dev string:xef>" + "<dev string:x1a7>", &function_1410eff963fa3b85, 1);
  function_a9a864379a098ad6("<dev string:x1b2>", "<dev string:x1c8>", &function_5652d4212374479);
  function_b23a59dfb4ca49a1("<dev string:x1da>", "<dev string:x1f1>" + "<dev string:x104>", &function_607a7d6915ef8735, 1);
  function_b23a59dfb4ca49a1("<dev string:x1fe>", "<dev string:x1f1>" + "<dev string:x12e>", &function_607a7d6915ef8735, 1);
  function_b23a59dfb4ca49a1("<dev string:x214>", "<dev string:x1f1>" + "<dev string:x159>", &function_607a7d6915ef8735, 1);
  function_b23a59dfb4ca49a1("<dev string:x22b>", "<dev string:x1f1>" + "<dev string:x181>", &function_607a7d6915ef8735, 1);
  function_b23a59dfb4ca49a1("<dev string:x23e>", "<dev string:x1f1>" + "<dev string:x1a7>", &function_607a7d6915ef8735, 1);
  function_b23a59dfb4ca49a1("<dev string:x252>", "<dev string:x270>" + "<dev string:x104>", &function_ae3dd752642964cc, 1);
  function_b23a59dfb4ca49a1("<dev string:x284>", "<dev string:x270>" + "<dev string:x12e>", &function_ae3dd752642964cc, 1);
  function_b23a59dfb4ca49a1("<dev string:x2a1>", "<dev string:x270>" + "<dev string:x159>", &function_ae3dd752642964cc, 1);
  function_b23a59dfb4ca49a1("<dev string:x2bf>", "<dev string:x270>" + "<dev string:x181>", &function_ae3dd752642964cc, 1);
  function_b23a59dfb4ca49a1("<dev string:x2d9>", "<dev string:x270>" + "<dev string:x1a7>", &function_ae3dd752642964cc, 1);
  function_a9a864379a098ad6("<dev string:x2f4>", "<dev string:x314>", &function_ebf0cef1743090f7);
  function_a9a864379a098ad6("<dev string:x334>", "<dev string:x349>", &function_6409c5ab460c85f);
  add_devgui_command("<dev string:x35e>", "<dev string:x377>");
  add_devgui_command("<dev string:x388>", "<dev string:x3a4>");
  add_devgui_command("<dev string:x3bf>", "<dev string:x3db>");
  add_devgui_command("<dev string:x3f6>", "<dev string:x413>");
  add_devgui_command("<dev string:x42f>", "<dev string:x453>");
  add_devgui_command("<dev string:x46f>", "<dev string:x492>");
  add_devgui_command("<dev string:x4b8>", "<dev string:x4db>");
  add_devgui_command("<dev string:x501>", "<dev string:x525>");
  add_devgui_command("<dev string:x54c>", "<dev string:x577>");
  add_devgui_command("<dev string:x59e>", "<dev string:x5ca>");
  add_devgui_command("<dev string:x5f6>", "<dev string:x61c>" + 1800);
  add_devgui_command("<dev string:x641>", "<dev string:x661>");
  add_devgui_command("<dev string:x687>", "<dev string:x6aa>");
  add_devgui_command("<dev string:x6d3>", "<dev string:x6f6>");
  add_devgui_command("<dev string:x71f>", "<dev string:x742>");
  function_fe953f000498048f();
  level.var_2d70874069468dab = spawnStruct();
  level.var_2d70874069468dab.updateseconds = 1;
  level thread function_b350da246217907c();
}

function function_c5fe5d9ce72fa0bc(activityclass, activitytypename) {
  assert(isstring(activityclass));
  assert(isstring(activitytypename));
  function_6e7290c8ee4f558b("<dev string:x76b>" + activityclass + "<dev string:x78c>" + activitytypename + "<dev string:x78c>");
  function_b23a59dfb4ca49a1("<dev string:x791>", "<dev string:x7a4>" + activitytypename, &toggle_activity);
  function_b23a59dfb4ca49a1("<dev string:x7bf>", "<dev string:x7d3>" + activitytypename, &toggle_activity);
  function_b23a59dfb4ca49a1("<dev string:x7ef>", "<dev string:x809>" + activityclass + "<dev string:x82d>" + activitytypename, &function_f7739f5c2b91aac3);
  function_b23a59dfb4ca49a1("<dev string:x832>", "<dev string:x84d>" + activityclass + "<dev string:x82d>" + activitytypename, &function_f17b5e1e3d81ea1a);
  function_fe953f000498048f();
}

function private function_b350da246217907c() {
  waittillframeend();
  regions = [[level.var_2d70874069468dab.var_fa51068d985cfd59]]();
  function_6e7290c8ee4f558b("<dev string:x1c>");

  foreach(region in regions) {
    function_b23a59dfb4ca49a1("<dev string:x869>" + region + "<dev string:x87d>", "<dev string:x88c>" + "<dev string:x104>" + "<dev string:x82d>" + region, &function_8072c276f04a62c1, 1);
    function_b23a59dfb4ca49a1("<dev string:x869>" + region + "<dev string:x8a0>", "<dev string:x88c>" + "<dev string:x12e>" + "<dev string:x82d>" + region, &function_8072c276f04a62c1, 1);
    function_b23a59dfb4ca49a1("<dev string:x869>" + region + "<dev string:x8ae>", "<dev string:x88c>" + "<dev string:x159>" + "<dev string:x82d>" + region, &function_8072c276f04a62c1, 1);
    function_b23a59dfb4ca49a1("<dev string:x869>" + region + "<dev string:x8bd>", "<dev string:x88c>" + "<dev string:x181>" + "<dev string:x82d>" + region, &function_8072c276f04a62c1, 1);
    function_b23a59dfb4ca49a1("<dev string:x869>" + region + "<dev string:x8c8>", "<dev string:x88c>" + "<dev string:x1a7>" + "<dev string:x82d>" + region, &function_8072c276f04a62c1, 1);
  }

  function_fe953f000498048f();
}

function private function_6409c5ab460c85f() {
  setDvar(@ "hash_f87b20273f0955f0", 2147483646);
  setDvar(@ "hash_d431c6b00b5d6b2a", 2147483646);
  function_ba98175a5f6557f2();
}

function private function_50a8580a8b718b47(params) {
  switch (params[0]) {
    case #"hash_6caf06e2c9e6872e":
      function_d0ac7479e6ae2265(1);
      break;
    case #"hash_c1c88ef798270243":
      function_d0ac7479e6ae2265(0);
      break;
  }
}

function private toggle_activity(params) {
  activitydvar = hashcat(@ "hash_862d7d5538370d45", params[1]);
  value = int(getDvar(activitydvar, 1));

  switch (params[0]) {
    case #"hash_6caf06e2c9e6872e":
      setDvar(activitydvar, 1);
      break;
    case #"hash_c1c88ef798270243":
      setDvar(activitydvar, 0);
      break;
  }
}

function private function_b5c16cdb0a8b261e(params) {}

function private draw_activity(activityinstance, runninginstance) {
  duration = int(ceil(level.var_2d70874069468dab.updateseconds / level.framedurationseconds));
  var_1d86cbaeb48162b0 = [[level.var_2d70874069468dab.var_aa4bf0d23a33bd92]](@ "hash_176090f07a9fa6df", activityinstance.class, 1800);
  var_2f347303bf358337 = (0.3, 0.3, 1);

  for(index = 0; index < activityinstance.origins.size; index++) {
    origin = activityinstance.origins[index];
    radius = activityinstance.radii[index];
    print3d(origin + (0, 0, 50), "<dev string:x8e9>" + activityinstance.type + "<dev string:x8f2>" + activityinstance.name, (1, 1, 1), 1, 1, duration, 1);
    print3d(origin + (0, 0, 30), "<dev string:x8f8>" + activityinstance.region + "<dev string:x905>", (1, 1, 1), 1, 1, duration, 1);
    print3d(origin + (0, 0, 10), "<dev string:x90a>" + radius, (1, 1, 1), 1, 1, duration, 1);
    color = (1, 0, 0);

    if(isDefined(runninginstance)) {
      color = (0, 1, 0);
    }

    sphere(origin, 30, color, 0, duration);
    cylinder(origin, origin + (0, 0, 10), radius, color, 0, duration);
    var_34beb429638ce846 = (1, 1, 1);

    if(activityinstance.origins.size > 1) {
      var_34beb429638ce846 = var_2f347303bf358337;
    }

    cylinder(origin, origin + (0, 0, 10), radius + var_1d86cbaeb48162b0, var_34beb429638ce846, 0, duration);
  }

  for(index = 1; index < activityinstance.origins.size; index++) {
    prevorigin = activityinstance.origins[index - 1];
    origin = activityinstance.origins[index];
    line(prevorigin, origin, (0.8, 0.8, 1), 1, 0, duration);
  }
}

function private function_ae3dd752642964cc(params) {
  if(params.size > 0) {
    setDvar(hashcat(@ "hash_1f77ee2c5138ab84", "<dev string:x915>" + params[0]), 1);
  }
}

function private function_ebf0cef1743090f7() {
  var_f06b0050d062caaf = [[level.var_2d70874069468dab.var_1aeea1d49e49164b]]("<dev string:x159>", undefined, level.players[0].origin);

  if(isDefined(var_f06b0050d062caaf)) {
    [[level.var_2d70874069468dab.var_fe3181404203f4d7]](var_f06b0050d062caaf);
  }
}

function private function_f7739f5c2b91aac3(params) {
  var_f06b0050d062caaf = [[level.var_2d70874069468dab.var_1aeea1d49e49164b]](params[0], params[1], level.players[0].origin);

  if(isDefined(var_f06b0050d062caaf)) {
    [[level.var_2d70874069468dab.var_fe3181404203f4d7]](var_f06b0050d062caaf);
  }
}

function private function_825b28c7ebf6d228(type, runningonly, drawregion) {
  if(!isDefined(runningonly)) {
    runningonly = 0;
  }

  while(true) {
    foreach(region, instancetypes in level.var_5b7c4eafd38d35c.activityinstances[type]) {
      if(isDefined(drawregion) && drawregion != region) {
        continue;
      }

      foreach(instancetype, instances in instancetypes) {
        foreach(instancename, instance in instances) {
          runninginstance = undefined;

          if(isDefined(level.var_5b7c4eafd38d35c.runninginstances[type][region]) && isDefined(level.var_5b7c4eafd38d35c.runninginstances[type][region][instancetype][instancename])) {
            runninginstance = level.var_5b7c4eafd38d35c.runninginstances[type][region][instancetype][instancename];
          }

          if(runningonly && !isDefined(runninginstance)) {
            continue;
          }

          draw_activity(instance, runninginstance);
        }
      }
    }

    wait level.var_2d70874069468dab.updateseconds;
  }
}

function private function_42693079c84f5e6b() {
  while(true) {
    drawscale = getdvarfloat(@ "hash_5b0a751f4964d0a0", 1);
    duration = int(ceil(level.var_2d70874069468dab.updateseconds / level.framedurationseconds));
    screenx = 500;
    screeny = 200;
    ydelta = 40 * drawscale;
    var_a91880e9ba5df15d = 35 * drawscale;
    color = (1, 1, 1);
    scale = 3 * drawscale;
    scalesmall = 2 * drawscale;
    printtoscreen2d(screenx, screeny, "<dev string:x91b>", color, scale, duration);
    screeny += ydelta;
    regions = [];

    foreach(activityinstances in level.var_5b7c4eafd38d35c.activityinstances) {
      foreach(regionname, var_16608965b7f8614 in activityinstances) {
        if(var_16608965b7f8614.size > 0) {
          regions[regionname] = 1;
        }
      }
    }

    printtoscreen2d(screenx, screeny, "<dev string:x93a>" + regions.size, color, scale, duration);
    screeny += ydelta;
    globalcount = level.var_5b7c4eafd38d35c.activityinstances["<dev string:x181>"].size;
    activitycount = level.var_5b7c4eafd38d35c.activityinstances["<dev string:x104>"].size;
    contractcount = level.var_5b7c4eafd38d35c.activityinstances["<dev string:x12e>"].size;
    objectivecount = level.var_5b7c4eafd38d35c.activityinstances["<dev string:x159>"].size;
    startupcount = level.var_5b7c4eafd38d35c.activityinstances["<dev string:x1a7>"].size;
    types = [];
    instances = [];
    regions = [[level.var_2d70874069468dab.var_fa51068d985cfd59]]();
    var_a165f6980e3e577 = function_6a64df48ad4ce4f9();

    foreach(class in var_a165f6980e3e577) {
      types[class] = [];
      instances[class] = 0;

      foreach(region in regions) {
        var_7d0882489e1ab140 = level.var_5b7c4eafd38d35c.activityinstances[class][region];

        if(!isDefined(var_7d0882489e1ab140)) {
          continue;
        }

        foreach(activitytype, activityinstances in var_7d0882489e1ab140) {
          types[class][activitytype] = 1;
          instances[class] += activityinstances.size;
        }
      }
    }

    text = "<dev string:x94d>" + types["<dev string:x181>"].size + "<dev string:x905>";
    text += "<dev string:x95f>" + types["<dev string:x104>"].size + "<dev string:x905>";
    text += "<dev string:x96d>" + types["<dev string:x12e>"].size + "<dev string:x905>";
    text += "<dev string:x97b>" + types["<dev string:x159>"].size + "<dev string:x905>";
    text += "<dev string:x98a>" + types["<dev string:x1a7>"].size + "<dev string:x905>";
    printtoscreen2d(screenx, screeny, text, color, scale, duration);
    screeny += ydelta;
    text = "<dev string:x997>" + instances["<dev string:x181>"] + "<dev string:x905>";
    text += "<dev string:x95f>" + instances["<dev string:x104>"] + "<dev string:x905>";
    text += "<dev string:x96d>" + instances["<dev string:x12e>"] + "<dev string:x905>";
    text += "<dev string:x97b>" + instances["<dev string:x159>"] + "<dev string:x905>";
    text += "<dev string:x98a>" + instances["<dev string:x1a7>"] + "<dev string:x905>";
    printtoscreen2d(screenx, screeny, text, color, scale, duration);
    screeny += ydelta;
    difficulties = ["<dev string:x9ad>", "<dev string:x9c0>", "<dev string:x9d5>", "<dev string:x9e8>"];
    var_2bfe175508eba086 = [];

    foreach(class in var_a165f6980e3e577) {
      var_3a18cedb8717f4d1 = [];

      foreach(difficulty in difficulties) {
        var_3a18cedb8717f4d1[difficulty] = [[level.var_2d70874069468dab.var_a19c8c0604529f78]](class, difficulty);
      }

      var_2bfe175508eba086[class] = var_3a18cedb8717f4d1;
    }

    instances = [];
    maxactivities = [];

    foreach(class in var_a165f6980e3e577) {
      instances[class] = 0;
      maxactivities[class] = [[level.var_2d70874069468dab.var_c7aef763b2f3aa8]](class);

      foreach(region in regions) {
        var_7d0882489e1ab140 = level.var_5b7c4eafd38d35c.runninginstances[class][region];

        if(!isDefined(var_7d0882489e1ab140)) {
          continue;
        }

        foreach(activitytype, activityinstances in var_7d0882489e1ab140) {
          instances[class] += activityinstances.size;
        }
      }
    }

    text = "<dev string:xa01>" + instances["<dev string:x181>"] + "<dev string:xa15>" + maxactivities["<dev string:x181>"] + "<dev string:x905>";
    text += "<dev string:x95f>" + instances["<dev string:x104>"] + "<dev string:xa15>" + maxactivities["<dev string:x104>"] + "<dev string:x905>";
    printtoscreen2d(screenx, screeny, text, color, scale, duration);
    screeny += ydelta;
    text = "<dev string:xa1e>" + instances["<dev string:x12e>"] + "<dev string:xa15>" + maxactivities["<dev string:x12e>"] + "<dev string:x905>";
    text += "<dev string:x97b>" + instances["<dev string:x159>"] + "<dev string:xa15>" + maxactivities["<dev string:x159>"] + "<dev string:x905>";
    text += "<dev string:x98a>" + instances["<dev string:x1a7>"] + "<dev string:xa15>" + maxactivities["<dev string:x1a7>"] + "<dev string:x905>";
    printtoscreen2d(screenx, screeny, text, color, scale, duration);
    screeny += ydelta;
    text = "<dev string:xa2f>";
    printtoscreen2d(screenx, screeny, text, color, scale, duration);
    screeny += ydelta;

    foreach(class in var_a165f6980e3e577) {
      text = "<dev string:xa46>" + class + "<dev string:xa4e>";
      printtoscreen2d(screenx, screeny, text, color, scalesmall, duration);
      var_3a18cedb8717f4d1 = var_2bfe175508eba086[class];
      var_ccd2bc8536f2f0f9 = [];
      var_ccd2bc8536f2f0f9["<dev string:x9ad>"] = 0;
      var_ccd2bc8536f2f0f9["<dev string:x9c0>"] = 0;
      var_ccd2bc8536f2f0f9["<dev string:x9d5>"] = 0;
      var_ccd2bc8536f2f0f9["<dev string:x9e8>"] = 0;

      foreach(region in regions) {
        regiondifficulty = namespace_f721fc7d0d2d0f47::function_cf8b9cfdad89cbec(region);

        if(!isDefined(var_ccd2bc8536f2f0f9[regiondifficulty])) {
          continue;
        }

        var_7d0882489e1ab140 = level.var_5b7c4eafd38d35c.runninginstances[class][region];

        foreach(activityinstances in var_7d0882489e1ab140) {
          var_ccd2bc8536f2f0f9[regiondifficulty] += activityinstances.size;
        }
      }

      text = "<dev string:xa53>" + var_ccd2bc8536f2f0f9["<dev string:x9ad>"] + "<dev string:xa5d>" + var_3a18cedb8717f4d1["<dev string:x9ad>"] + "<dev string:xa66>";
      text += "<dev string:xa6d>" + var_ccd2bc8536f2f0f9["<dev string:x9c0>"] + "<dev string:xa5d>" + var_3a18cedb8717f4d1["<dev string:x9c0>"] + "<dev string:xa66>";
      text += "<dev string:xa78>" + var_ccd2bc8536f2f0f9["<dev string:x9d5>"] + "<dev string:xa5d>" + var_3a18cedb8717f4d1["<dev string:x9d5>"] + "<dev string:xa66>";
      text += "<dev string:xa83>" + var_ccd2bc8536f2f0f9["<dev string:x9e8>"] + "<dev string:xa5d>" + var_3a18cedb8717f4d1["<dev string:x9e8>"] + "<dev string:xa8b>";
      printtoscreen2d(screenx + 500, screeny, text, color, scalesmall, duration);
      screeny += var_a91880e9ba5df15d;
    }

    screeny += ydelta / 2;
    printtoscreen2d(screenx, screeny, "<dev string:xa91>", color, scale, duration);
    screeny += ydelta;

    foreach(region in regions) {
      runningcount = [];
      runningmax = [];

      foreach(class in var_a165f6980e3e577) {
        runningcount[class] = 0;
        var_7d0882489e1ab140 = level.var_5b7c4eafd38d35c.runninginstances[class][region];

        if(!isDefined(var_7d0882489e1ab140)) {
          continue;
        }

        foreach(activitytype, activityinstances in var_7d0882489e1ab140) {
          runningcount[class] += activityinstances.size;
        }

        runningmax[class] = [[level.var_2d70874069468dab.var_fb1eec0d33d8dc19]](class);
      }

      text = "<dev string:xa46>" + region;
      printtoscreen2d(screenx, screeny, text, color, scalesmall, duration);
      text = "<dev string:xaa2>" + runningcount["<dev string:x181>"] + "<dev string:xa5d>" + runningmax["<dev string:x181>"] + "<dev string:x905>";
      text += "<dev string:x95f>" + runningcount["<dev string:x104>"] + "<dev string:xa5d>" + runningmax["<dev string:x104>"] + "<dev string:x905>";
      text += "<dev string:x96d>" + runningcount["<dev string:x12e>"] + "<dev string:xa5d>" + runningmax["<dev string:x12e>"] + "<dev string:x905>";
      printtoscreen2d(screenx + 500, screeny, text, color, scalesmall, duration);
      text = "<dev string:x97b>" + runningcount["<dev string:x159>"] + "<dev string:xa5d>" + runningmax["<dev string:x159>"] + "<dev string:x905>";
      text += "<dev string:x98a>" + runningcount["<dev string:x1a7>"] + "<dev string:xa5d>" + runningmax["<dev string:x1a7>"] + "<dev string:x905>";
      printtoscreen2d(screenx + 1330, screeny, text, color, scalesmall, duration);
      screeny += var_a91880e9ba5df15d;
    }

    wait level.var_2d70874069468dab.updateseconds;
  }
}

function private function_607a7d6915ef8735(params) {
  function_825b28c7ebf6d228(params[0]);
}

function private function_1410eff963fa3b85(params) {
  function_825b28c7ebf6d228(params[0], 1);
}

function private function_8072c276f04a62c1(params) {
  function_825b28c7ebf6d228(params[0], undefined, params[1]);
}

function private function_44cc30417358da(name) {
  if(function_7ac3c4c1bce16dd2(name)) {
    toggle_thread(name, undefined, undefined);
  }
}

function private function_5652d4212374479() {
  function_44cc30417358da("<dev string:xaad>");
  function_44cc30417358da("<dev string:xab9>");
  function_44cc30417358da("<dev string:xacd>");
}

function private function_898ada7f773b1c5a(params) {
  level notify("<dev string:xae0>");
  level endon("<dev string:xae0>");
  activityclass = params[0];
  activitytype = params[1];
  var_980df4613b316540 = activityclass + "<dev string:x915>" + activitytype;

  if(isDefined(level.var_2d70874069468dab.var_b0705e04df8f166a) && level.var_2d70874069468dab.var_b0705e04df8f166a == var_980df4613b316540) {
    level.var_2d70874069468dab.var_b0705e04df8f166a = undefined;
    return;
  }

  level.var_2d70874069468dab.var_b0705e04df8f166a = var_980df4613b316540;

  while(true) {
    regions = [[level.var_2d70874069468dab.var_fa51068d985cfd59]]();

    foreach(region in regions) {
      if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[activityclass][region])) {
        continue;
      }

      instances = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytype];

      if(!isDefined(instances)) {
        continue;
      }

      foreach(instancename, instance in instances) {
        runninginstance = undefined;

        if(isDefined(level.var_5b7c4eafd38d35c.runninginstances[activityclass][region]) && isDefined(level.var_5b7c4eafd38d35c.runninginstances[activityclass][region][activitytype][instancename])) {
          runninginstance = level.var_5b7c4eafd38d35c.runninginstances[activityclass][region][activitytype][instancename];
        }

        draw_activity(instance, runninginstance);
      }
    }

    wait level.var_2d70874069468dab.updateseconds;
  }
}

function private function_f17b5e1e3d81ea1a(params) {
  level thread function_898ada7f773b1c5a(params);
}

# /