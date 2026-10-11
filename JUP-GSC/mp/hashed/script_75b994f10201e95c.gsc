/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_75b994f10201e95c.gsc
*************************************************/

#using script_4a6760982b403bad;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\flags;
#using scripts\mp\poi;
#namespace namespace_90b6dcf8105329b;

function init() {
  if(!scripts\mp\flags::gameflagexists("billboard_init_done")) {
    scripts\mp\flags::gameflaginit("billboard_init_done", 0);
  }

  level waittill("player_spawned");

  if(getdvarint(@ "scr_mp_billboards_enabled", 0) == 0) {
    return;
  }

  level.billboards = spawnStruct();
  function_a359d4a358c561f8();

  if(level.billboards.ents.size == 0) {
    return;
  }

  var_a1e312c81d78f53e = "digitalbillboardadvertisements:" + getDvar(@ "scr_mp_billboards_advertisement_set");
  var_4bfb302739681a2 = getscriptbundle(var_a1e312c81d78f53e);

  if(!isDefined(var_4bfb302739681a2)) {
    return;
  }

  var_fd9720ab856b9182 = randomint(var_4bfb302739681a2.var_a8815c64d130615b.size);
  var_95681bcccc148c4a = var_4bfb302739681a2.var_a8815c64d130615b[var_fd9720ab856b9182];
  level.billboards.regularads = var_95681bcccc148c4a.var_e0a363adf11c8946;
  level.billboards.var_97ff8df643df7bd4 = var_4bfb302739681a2.var_e4c472585af18f5d;

  if(!isDefined(var_95681bcccc148c4a) || var_95681bcccc148c4a.size == 0) {
    return;
  }

  var_9f49f87bc82efa7 = level.billboards.regularads.size;
  level.billboards.gameplayevents = var_4bfb302739681a2.gameplayevents;
  level.billboards.unifieddisplay = 0;
  level.billboards.var_10de73a7df631b43 = getdvarint(@ "hash_948d664ae50f79ac", 7);
  function_4837ccfae618581f();
  function_ae731dcf50354b8c();
  cooldown = getdvarint(@ "scr_mp_billboards_gameplay_events_cooldown", 0);

  if(cooldown <= 0) {
    cooldown = (level.billboards.var_2040b676cc5b064a + 1) * level.billboards.var_10de73a7df631b43;
  }

  level.billboards.var_aa6dc2f47a88e049 = cooldown;
  assertex(var_9f49f87bc82efa7 <= 10, "<dev string:x1c>");
  gameflaginit("billboard_advertisement_ready", 1);
  level function_96f0d4c5ff43f24e(var_fd9720ab856b9182 + 1);
  level thread function_99b22afe385da736(var_9f49f87bc82efa7);

  if(getdvarint(@ "hash_1ecb4ee1b513876d", 0) == 0 && isDefined(level.billboards.gameplayevents) && level.billboards.gameplayevents.size > 0) {
    level.billboards.gameplaytriggers = [];

    if(getdvarint(@ "hash_e8af522d932e0df6", 1) == 1) {
      level.billboards.var_2c9eff3be64be074 = getdvarint(@ "hash_83eb61fd6910d5df", 10);
      level.billboards.var_5995c3b47f8d158 = getdvarint(@ "hash_3ae7b8bc6636fb3d", 20);
      function_e3c0dc1c0153e197("highActivity", &function_8ab2a7389e0702cf);
    }

    if(getdvarint(@ "scr_mp_billboards_kill_events_enabled", 0) == 1) {
      var_959894c064d998fb = getDvar(@ "hash_2695369ab6b17928", "10 15 20");

      if(var_959894c064d998fb != "") {
        level.billboards.var_959894c064d998fb = strtok(var_959894c064d998fb, " ");
        level.billboards.var_3c2204ac892d141b = 0;
        level.billboards.var_5fa0d41d3b53913e = getdvarint(@ "hash_73eccd067acc6fc1", 20);
        scripts\common\callbacks::add("br_player_killed", &function_5f122d1221519a07);

        for(i = 0; i < level.billboards.var_959894c064d998fb.size; i++) {
          function_e3c0dc1c0153e197("killWarning" + i, &function_3dab8e19af55dd2, i + 1);
        }
      }
    }

    level thread function_4d4736a92adfde31();
  }

  scripts\mp\flags::gameflagset("billboard_init_done");
}

function function_a359d4a358c561f8() {
  level.billboards.ents = [];
  billboardtypes = function_1a8a54ed7eb5a2d8();

  if(!isDefined(billboardtypes)) {
    return;
  }

  foreach(type in billboardtypes) {
    billboards = getentitylessscriptablearray("scriptable_" + type.billboardtype, "classname");
    var_5b7c5ad771190c7c = [];
    var_27dec58d1d9b3319 = [];

    foreach(billboard in billboards) {
      poi = scripts\mp\poi::poi_findpoioriginisin(billboard.origin);

      if(!isDefined(var_5b7c5ad771190c7c[poi])) {
        var_5b7c5ad771190c7c[poi] = [];
        var_27dec58d1d9b3319[var_27dec58d1d9b3319.size] = poi;
      }

      var_5b7c5ad771190c7c[poi][var_5b7c5ad771190c7c[poi].size] = billboard;
    }

    foreach(poi in var_27dec58d1d9b3319) {
      index = randomint(type.numstates);

      foreach(billboard in var_5b7c5ad771190c7c[poi]) {
        state = index % type.numstates + 1;
        billboard.state = "rt" + state;
        billboard setscriptablepartstate("root", billboard.state);
        index++;
      }
    }

    level.billboards.ents = array_combine(level.billboards.ents, billboards);
  }
}

function function_1a8a54ed7eb5a2d8() {
  mapinfo = getmapscriptbundle();

  if(!isDefined(mapinfo)) {
    return undefined;
  }

  if(!isDefined(mapinfo.var_735def1bcfa016a5)) {
    return undefined;
  }

  var_a9bab2d4a335df29 = getscriptbundle(mapinfo.var_735def1bcfa016a5);

  if(!isDefined(var_a9bab2d4a335df29)) {
    assertmsg("<dev string:x73>" + mapinfo.var_735def1bcfa016a5 + "<dev string:x8c>");
    return undefined;
  }

  return var_a9bab2d4a335df29.billboardtypes;
}

function function_99b22afe385da736(var_9f49f87bc82efa7) {
  level endon("game_ended");
  var_2040b676cc5b064a = level.billboards.var_2040b676cc5b064a;
  var_10de73a7df631b43 = level.billboards.var_10de73a7df631b43;
  adcounter = 0;
  var_ecc00edcbc94f8f2 = 0;

  while(true) {
    gameflagwait("billboard_advertisement_ready");
    var_e4c472585af18f5d = level.billboards.var_e4c472585af18f5d;
    level notify("update_featured_ads");

    if(var_e4c472585af18f5d.size > 0) {
      level function_edd927a5f453d828(1, var_e4c472585af18f5d[var_ecc00edcbc94f8f2].id + 1);
      function_2659bf2515661476(istrue(var_e4c472585af18f5d[var_ecc00edcbc94f8f2].unifieddisplay));
      wait var_e4c472585af18f5d[var_ecc00edcbc94f8f2].duration;
      var_ecc00edcbc94f8f2 = (var_ecc00edcbc94f8f2 + 1) % var_e4c472585af18f5d.size;
    }

    for(i = 0; i < var_2040b676cc5b064a; i++) {
      gameflagwait("billboard_advertisement_ready");
      level function_edd927a5f453d828(3, adcounter + 1);
      function_2659bf2515661476(istrue(level.billboards.regularads[adcounter].unifieddisplay));
      adcounter = (adcounter + 1) % var_9f49f87bc82efa7;
      wait var_10de73a7df631b43;
    }
  }
}

function function_2659bf2515661476(var_8063670b409c27fd) {
  if(level.billboards.unifieddisplay == var_8063670b409c27fd) {
    return;
  }

  foreach(billboard in level.billboards.ents) {
    state = "rt1";

    if(!istrue(var_8063670b409c27fd)) {
      state = billboard.state;
    }

    billboard setscriptablepartstate("root", state);
  }

  level.billboards.unifieddisplay = var_8063670b409c27fd;
}

function function_4d4736a92adfde31() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  while(true) {
    foreach(gameplaytrigger in level.billboards.gameplaytriggers) {
      if(isDefined(gameplaytrigger.triggerparam)) {
        result = [[gameplaytrigger.trigger]](gameplaytrigger.triggerparam);
      } else {
        result = [[gameplaytrigger.trigger]]();
      }

      if(!isDefined(result)) {
        continue;
      }

      gameflagclear("billboard_advertisement_ready");
      gameplayeventindex = level.billboards.var_521cc61d29704380[gameplaytrigger.eventname];
      level function_edd927a5f453d828(2, gameplayeventindex + 1, result.optionalparam);
      function_2659bf2515661476(istrue(level.billboards.gameplayevents[gameplayeventindex].var_4a53054ad609a46a.unifieddisplay));
      wait result.displayduration;
      gameflagset("billboard_advertisement_ready");
      wait level.billboards.var_aa6dc2f47a88e049;
      break;
    }

    wait 2;
  }
}

function function_e1f639b9b9114bda(poiname) {
  timestampwarning = namespace_de6e6777b0937bd7::function_1b15450e092933cf(gettime());
  dlog_recordevent("dlog_event_br_billboard_poi_warning", ["poi_name", poiname, "timestamp_warning", timestampwarning]);
}

function function_5f122d1221519a07(deathdata) {
  if(!isDefined(level.billboards.var_959894c064d998fb)) {
    return;
  }

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(isDefined(deathdata.attacker) && level.billboards.var_3c2204ac892d141b < level.billboards.var_959894c064d998fb.size && deathdata.attacker.kills + 1 >= int(level.billboards.var_959894c064d998fb[level.billboards.var_3c2204ac892d141b])) {
    level.billboards.var_b94213f2edae170e = deathdata.attacker getentitynumber();
    level.billboards.var_3c2204ac892d141b++;
  }
}

function function_4837ccfae618581f() {
  var_e6cf0ed17753630b = getDvar(@ "hash_4bb0610b77a65173", "");
  var_97d55065375f529e = [];

  if(var_e6cf0ed17753630b != "") {
    var_97d55065375f529e = strtok(var_e6cf0ed17753630b, ",");
  }

  var_14d0913aec08f092 = getDvar(@ "hash_1d3125d35a55efdd", "");
  var_d718149245fd4533 = [];

  if(var_14d0913aec08f092 != "") {
    var_d718149245fd4533 = strtok(var_14d0913aec08f092, ",");
  }

  level.billboards.var_2040b676cc5b064a = getdvarint(@ "hash_fc255bcf24c83b71", level.billboards.regularads.size);
  var_e4c472585af18f5d = [];

  for(i = 0; i < var_97d55065375f529e.size; i++) {
    index = function_d8e65966da143203(var_97d55065375f529e[i], level.billboards.var_97ff8df643df7bd4);

    if(!isDefined(index)) {
      continue;
    }

    featured = spawnStruct();
    featured.id = index;
    featured.duration = level.billboards.var_10de73a7df631b43;

    if(var_d718149245fd4533.size > i) {
      featured.duration = int(var_d718149245fd4533[i]);
    }

    var_e4c472585af18f5d[var_e4c472585af18f5d.size] = featured;
  }

  level.billboards.var_e4c472585af18f5d = var_e4c472585af18f5d;
}

function function_ae731dcf50354b8c() {
  var_521cc61d29704380 = [];
  index = 0;

  foreach(gameplayevent in level.billboards.gameplayevents) {
    eventname = gameplayevent.eventname;

    if(isDefined(eventname) && eventname != "") {
      var_521cc61d29704380[gameplayevent.eventname] = index;
    }

    index++;
  }

  level.billboards.var_521cc61d29704380 = var_521cc61d29704380;
}

function function_edd927a5f453d828(var_ee2ed6d8b66240ca, index, optionalparam) {
  foreach(player in level.players) {
    if(isDefined(player)) {
      player scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_mp_billboards_advertisement_data", 0, 2, var_ee2ed6d8b66240ca);
      player scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_mp_billboards_advertisement_data", 2 + 5, 5, index);

      if(isDefined(optionalparam)) {
        player scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_mp_billboards_advertisement_data", 2 + 5 + 5, 8, optionalparam);
      }
    }
  }
}

function function_96f0d4c5ff43f24e(var_4852060d0a82bcde) {
  foreach(player in level.players) {
    if(isDefined(player)) {
      player scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_mp_billboards_advertisement_data", 2, 5, var_4852060d0a82bcde);
    }
  }
}

function function_f7dedaa26220b51c(data, duration) {
  level endon("game_ended");
  level waittill("update_featured_ads");

  if(!isDefined(duration)) {
    duration = level.billboards.var_10de73a7df631b43;
  }

  index = function_d8e65966da143203(data, level.billboards.var_97ff8df643df7bd4);

  if(!isDefined(index)) {
    return;
  }

  featured = spawnStruct();
  featured.id = index;
  featured.duration = duration;
  featured.unifieddisplay = level.billboards.var_97ff8df643df7bd4[index].unifieddisplay;
  level.billboards.var_e4c472585af18f5d[level.billboards.var_e4c472585af18f5d.size] = featured;
}

function function_d8e65966da143203(adname, availableads) {
  if(isDefined(adname)) {
    for(i = 0; i < availableads.size; i++) {
      if(adname == availableads[i].var_e9635fe005f5ad03) {
        return i;
      }
    }
  }

  return undefined;
}

function function_e3c0dc1c0153e197(eventname, func, triggerparam) {
  if(!isDefined(level.billboards.gameplaytriggers)) {
    return;
  }

  neweventindex = level.billboards.var_521cc61d29704380[eventname];

  if(!isDefined(neweventindex)) {
    assertmsg("<dev string:x9d>" + eventname + "<dev string:xb4>");
    return;
  }

  triggerstruct = spawnStruct();
  triggerstruct.eventname = eventname;
  triggerstruct.trigger = func;
  triggerstruct.triggerparam = triggerparam;
  insertat = level.billboards.gameplaytriggers.size;
  index = 0;

  foreach(gameplaytrigger in level.billboards.gameplaytriggers) {
    eventindex = level.billboards.var_521cc61d29704380[gameplaytrigger.eventname];

    if(eventindex > neweventindex) {
      insertat = index;
      break;
    }

    index++;
  }

  level.billboards.gameplaytriggers = array_insert(level.billboards.gameplaytriggers, triggerstruct, insertat);
}

function function_8ab2a7389e0702cf() {
  highestplayernum = 0;
  result = undefined;
  poiname = undefined;

  foreach(tag, poi in level.poi) {
    if(!isDefined(poi["calloutIndex"])) {
      continue;
    }

    poiplayers = poi["players"];

    if(isDefined(poiplayers) && poiplayers.size >= max(level.billboards.var_2c9eff3be64be074, highestplayernum)) {
      highestplayernum = poiplayers.size;
      optionalparam = poi["calloutIndex"];
      poiname = tag;
    }
  }

  if(highestplayernum > 0) {
    result = spawnStruct();
    result.displayduration = level.billboards.var_5995c3b47f8d158;
    result.optionalparam = optionalparam;
    function_e1f639b9b9114bda(poiname);
  }

  return result;
}

function function_3dab8e19af55dd2(triggerparam) {
  result = undefined;

  if(isDefined(level.billboards.var_b94213f2edae170e) && level.billboards.var_3c2204ac892d141b == triggerparam) {
    result = spawnStruct();
    result.displayduration = level.billboards.var_5fa0d41d3b53913e;
    result.optionalparam = level.billboards.var_b94213f2edae170e;
    level.billboards.var_b94213f2edae170e = undefined;
  }

  return result;
}