/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_702128df02f507a.gsc
************************************************/

#using script_702128df02f507a;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_public;
#namespace namespace_cf51e0de98ebcb9e;

function autoexec main() {
  if(getdvarint(@ "hash_a9df41b469b5dbe2", 1) <= 0) {
    return;
  }

  init();

  level thread debug_init();
}

function init() {
  scenarios = function_7e930b64aa35ffee();

  if(isDefined(scenarios) && scenarios.size > 0) {
    level.br_destruction_scenario = spawnStruct();
    var_6a5dccee5fd220aa = function_bc90551fbdb43ef6(scenarios);
    level.br_destruction_scenario.var_6a5dccee5fd220aa = var_6a5dccee5fd220aa;
    thread function_bf0a1510baea47c5(var_6a5dccee5fd220aa);
    function_e9fe6584103182cb(var_6a5dccee5fd220aa);
  }
}

function function_7e930b64aa35ffee() {
  mapinfo = getmapscriptbundle();

  if(!isDefined(mapinfo)) {
    return undefined;
  }

  if(!isDefined(mapinfo.var_56d371dd4dd18dda) || mapinfo.var_56d371dd4dd18dda == % "") {
    return undefined;
  }

  var_6b937c81802e4bfb = getscriptbundle(mapinfo.var_56d371dd4dd18dda);

  if(!isDefined(var_6b937c81802e4bfb)) {
    assertmsg("<dev string:x1c>" + mapinfo.var_56d371dd4dd18dda + "<dev string:x38>");
    return undefined;
  }

  return var_6b937c81802e4bfb.scenarios;
}

function function_667d4e416d37d616(origin, var_7c8953aa388fb2f0, var_f795b12e5a594b2c) {
  if(!isDefined(level.br_destruction_scenario) || !isDefined(level.br_destruction_scenario.var_6a5dccee5fd220aa)) {
    return undefined;
  }

  if(!is_equal(level.br_destruction_scenario.var_6a5dccee5fd220aa.name, var_7c8953aa388fb2f0)) {
    return undefined;
  }

  if(isDefined(var_f795b12e5a594b2c) && isDefined(level.br_destruction_scenario.var_6a5dccee5fd220aa.destructionstate.state) && var_f795b12e5a594b2c != level.br_destruction_scenario.var_6a5dccee5fd220aa.destructionstate.state) {
    return 0;
  }

  var_82a1b9668c3e9620 = function_335e62799b1a356a(origin, var_7c8953aa388fb2f0, level.br_destruction_scenario.var_6a5dccee5fd220aa.defaultstate);
  return var_82a1b9668c3e9620;
}

function function_bc90551fbdb43ef6(scenarios) {
  weightoverrides = getDvar(@ "hash_d8db6ac022cc3906", "");
  var_e3ecf1db05fcac6b = strtok(weightoverrides, ",");
  validoverrides = function_3c118c933f1f96b4(var_e3ecf1db05fcac6b);

  if(validoverrides.size > 0) {
    var_7b172f966919ffd3 = [];

    foreach(index, scenario in scenarios) {
      scenario.name = tolower(scenario.name);
      scenario.weight = 0;
      var_7b172f966919ffd3[scenario.name] = index;
    }

    foreach(validoverride in validoverrides) {
      var_e2417a1fab5e2e29 = var_7b172f966919ffd3[validoverride.name];
      scenarios[var_e2417a1fab5e2e29].weight = validoverride.weight;
    }
  }

  return function_fd2c2c40201aed7e(scenarios);
}

function function_3c118c933f1f96b4(var_e3ecf1db05fcac6b) {
  validoverrides = [];

  foreach(pair in var_e3ecf1db05fcac6b) {
    pairarray = strtok(pair, " ");

    if(pairarray.size > 1 && isstring(pairarray[0])) {
      validoverride = spawnStruct();
      validoverride.name = tolower(pairarray[0]);
      validoverride.weight = int(pairarray[1]);
      validoverrides[validoverrides.size] = validoverride;
      continue;
    }

    assertmsg("<dev string:x49>" + getxhashsourcename(@ "hash_d8db6ac022cc3906") + "<dev string:x55>" + pair + "<dev string:x67>");
  }

  return validoverrides;
}

function function_fd2c2c40201aed7e(scenarios) {
  totalweight = 0;

  foreach(scenario in scenarios) {
    totalweight += scenario.weight;
  }

  choosenweight = randomfloat(totalweight);
  cumulativeweight = 0;
  var_6a5dccee5fd220aa = undefined;

  foreach(scenario in scenarios) {
    cumulativeweight += scenario.weight;

    if(cumulativeweight > choosenweight) {
      var_6a5dccee5fd220aa = scenario;
      break;
    }
  }

  return var_6a5dccee5fd220aa;
}

function function_bf0a1510baea47c5(scenario) {
  level endon("game_ended");

  if(!isDefined(scenario)) {
    return;
  }

  if(isDefined(scenario.scenename)) {
    scenario.scene = initscene(scenario.scenename);
  }

  if(isDefined(scenario.var_beb3ce9cb5705897) && scenario.var_beb3ce9cb5705897 != "") {
    game["dialog"][scenario.var_beb3ce9cb5705897] = scenario.var_beb3ce9cb5705897;
  }

  function_1109bf32b4f881b8(scenario);
  function_2d2875f903aa2a92(scenario);
  function_8aa7eefcc94fcf5d(scenario);
}

function initscene(scenename) {
  scene = spawnStruct();
  scene scene::set_scriptbundle(scenename);
  scene scene::set_anim_rate(1);
  return scene;
}

function function_1109bf32b4f881b8(scenario) {
  var_7837d7a932253c21 = !istrue(scenario.debugplay);

  if(var_7837d7a932253c21) {
    scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  }

  if(isDefined(scenario.flyinstate)) {
    setareaswaphint(scenario.name, scenario.flyinstate);
  }

  if(isDefined(scenario.var_56e04d3d0e7663ca)) {
    scripts\mp\compass::setupminimap(scenario.var_56e04d3d0e7663ca);
  }

  if(var_7837d7a932253c21) {
    scripts\mp\flags::gameflagwait("prematch_fade_done");
  } else {
    waitframe();
  }

  if(isDefined(scenario.defaultstate)) {
    scripts\common\utility::function_39698f30fd7e8a1e(scenario.name, scenario.defaultstate);
  }

  if(isDefined(scenario.flyinstate)) {
    function_1c1e3d250d7d89e(scenario.name, scenario.flyinstate);
  }

  waitframe();

  if(isDefined(scenario.scene)) {
    scenario.scene scripts\common\scene::pre_stream();
    scenario.scene scripts\common\scene::init();
    scenario.scene scene::function_b0b8f796886a9c81(1);
  }

  if(isDefined(scenario.destructionstate.state)) {
    setareaswaphint(scenario.name, scenario.destructionstate.state);
  }
}

function function_2d2875f903aa2a92(scenario) {
  if(!isDefined(scenario.scene)) {
    return;
  }

  var_7837d7a932253c21 = !istrue(scenario.debugplay);

  if(!var_7837d7a932253c21) {
    waitframe();
  } else if(isDefined(level.br_ac130)) {
    level.br_ac130 waittill("start_moving");
  } else {
    scripts\mp\flags::gameflagwait("infil_animatic_complete");
  }

  waittime = scripts\mp\gametypes\br_c130::function_130df32ea7502b9e() - scenario.var_3c98c782dfda4138;

  if(waittime > 0 && var_7837d7a932253c21) {
    wait waittime;
  }

  function_4d9e4eccd09dec28(scenario);
}

function function_4d9e4eccd09dec28(scenario) {
  scenario.scene thread scripts\common\scene::play();
  level thread function_9977d85412dfb260(scenario);
  thread function_ad4330182461d797(scenario);
}

function function_8aa7eefcc94fcf5d(scenario) {
  wait scenario.destructionstate.delay;

  if(isDefined(scenario.destructionstate.state)) {
    function_1c1e3d250d7d89e(scenario.name, scenario.destructionstate.state);
  }

  waittime = getdvarint(@ "hash_c83d487ec3dec085", 2);

  if(waittime > 0) {
    wait waittime;
  }

  if(isDefined(scenario.scene)) {
    scenario.scene scripts\common\scene::cleanup();
  }
}

function function_9977d85412dfb260(scenario) {
  if(isDefined(scenario.exploders) && scenario.exploders.size > 0) {
    foreach(exploder in scenario.exploders) {
      if(isDefined(exploder) && isDefined(exploder.name)) {
        if(isDefined(exploder.delay) && exploder.delay >= 0) {
          if(exploder.delay == 0) {
            thread scripts\engine\utility::exploder(exploder.name, level.players);
            continue;
          }

          scripts\engine\utility::delaythreadendon(exploder.delay, "game_ended", &scripts\engine\utility::exploder, exploder.name, level.players);
        }
      }
    }
  }
}

function function_ad4330182461d797(scenario) {
  if(isDefined(scenario.var_beb3ce9cb5705897) && scenario.var_beb3ce9cb5705897 != "") {
    if(isDefined(scenario.var_c335b73c96a684ee)) {
      wait scenario.var_c335b73c96a684ee;
    }

    scripts\mp\gametypes\br_public::brleaderdialog(scenario.var_beb3ce9cb5705897);
  }
}

function private function_e9fe6584103182cb(scenario) {
  eventparams = ["scenario_name", scenario.name];
  dlog_recordevent("dlog_event_br_destruction_scenario", eventparams);
}

function debug_init() {
  devgui_init();
}

function devgui_init() {
  scenarios = namespace_c9be15e212bc70fe::function_7e930b64aa35ffee();

  if(!isDefined(scenarios)) {
    return;
  }

  function_e243334881a8b809("<dev string:x6c>", &function_28157cbc9158d55f, scenarios);
  function_e243334881a8b809("<dev string:x7c>", &function_dea73eea830e5dfd, scenarios);
}

function function_e243334881a8b809(blockid, callback, scenarios) {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x8c>" + blockid + "<dev string:xab>");

  for(i = 0; i < scenarios.size; i++) {
    scenario = scenarios[i];
    scripts\common\devgui::function_b23a59dfb4ca49a1(scenario.name, blockid + "<dev string:xb0>" + i, callback);
  }

  scripts\common\devgui::function_fe953f000498048f();
}

function function_28157cbc9158d55f(params) {
  scenarios = namespace_c9be15e212bc70fe::function_7e930b64aa35ffee();
  scenario = scenarios[int(params[0])];
  scenario.debugplay = 1;

  if(isDefined(scenario.scenename)) {
    scenario.scene = initscene(scenario.scenename);
  }

  if(isDefined(scenario.scene)) {
    scenario.scene scripts\common\scene::pre_stream();
    scenario.scene scene::function_b0b8f796886a9c81(1);
  }

  function_4d9e4eccd09dec28(scenario);
}

function function_dea73eea830e5dfd(params) {
  scenarios = namespace_c9be15e212bc70fe::function_7e930b64aa35ffee();
  scenario = scenarios[int(params[0])];
  scenario.debugplay = 1;

  if(isDefined(scenario.destructionstate.state)) {
    function_1c1e3d250d7d89e(scenario.name, scenario.defaultstate);
  }

  waitframe();
  function_bf0a1510baea47c5(scenario);
}

# /