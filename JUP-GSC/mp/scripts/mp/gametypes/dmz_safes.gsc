/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_safes.gsc
***********************************************/

#using script_1174abedbefe9ada;
#using script_15ca41a3fbb0e379;
#using script_4948cdf739393d2d;
#using script_5307834cd39b435c;
#using script_b7a9ce0a2282b79;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\anim;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\utility\game;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace dmz_safes;

function initsafes() {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("safe", &function_7c5eefd0cbce6520);
  script_model_anims();
  level.safeprops = spawnStruct();
  level.safeprops.enablesafes = getdvarint(@ "hash_6c64e4ed1b2661b0", 1);
  level.safeprops.var_a7208b64e85e109e = getdvarint(@ "hash_4ae9be8b66f04d02", 0);
  level.safeprops.var_a4186f089a36d2f0 = getdvarint(@ "hash_20ad09d3184793f8", 2);
  level.safeprops.capturetime = getdvarint(@ "hash_40d76dd47f1ffbc5", 75);
  level.safeprops.captureradius = getdvarint(@ "hash_8fd341ad9e996d3a", 800);
  level.safeprops.revealradius = getdvarint(@ "hash_e5c47808565489f1", 24000);
  level.safeprops.revealradiussq = level.safeprops.revealradius * level.safeprops.revealradius;
  level.safeprops.revealmin = getdvarint(@ "hash_d0b1d795f6610eb5", 4);
  level.safeprops.revealmax = getdvarint(@ "hash_d0d4c195f687260b", 5);
  level.safeprops.hideicons = getdvarint(@ "hash_d8c8e09d145b3aa", 1);
  level.safeprops.enabledefenders = getdvarint(@ "hash_fe63eef908e3ebd7", 1);

  if(!level.safeprops.enablesafes) {
    return;
  }

  while(!isDefined(level.struct_class_names) || !isDefined(level.var_41670c1c65f3d3cf) || function_9a83377c98bce82a("everybody") <= 0) {
    waitframe();
  }

  scripts\mp\flags::function_1240434f4201ac9d("radiation_initialized");
  safelocations = getStructArray("dmz_safe", "script_noteworthy");
  validlocations = [];

  foreach(safelocation in safelocations) {
    fortress = namespace_9823ee6035594d67::function_c0a211a69f5f8f2f(safelocation.origin);

    if(!isDefined(fortress) && scripts\mp\poi::poi_ispoiactive(safelocation.poi) && !namespace_7789f919216d38a2::radiation_isinradiation(safelocation.origin)) {
      if(!isDefined(validlocations[safelocation.poi])) {
        validlocations[safelocation.poi] = [];
      }

      validlocations[safelocation.poi][validlocations[safelocation.poi].size] = safelocation;
    }
  }

  level.safes = [];

  foreach(arr in validlocations) {
    numtospawn = min(randomintrange(level.safeprops.var_a7208b64e85e109e, level.safeprops.var_a4186f089a36d2f0 + 1), arr.size);
    locs = array_randomize(arr);

    for(nodeidx = 0; nodeidx < numtospawn; nodeidx++) {
      function_d2441b457fa14419(locs[nodeidx]);
    }
  }

  thread function_747adf1e8fdb5ce6();
}

function function_a07f7c4c0c4ef8e3() {
  return getStructArray("<dev string:x1c>", "<dev string:x28>");
}

function function_d2441b457fa14419(node, forcedlootid) {
  if(!isDefined(node)) {
    return;
  }

  namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x3d>", "<dev string:x51>", undefined, "<dev string:x1c>", undefined, undefined, node.poi, node.origin);

  var_b66875eaf0848550 = "dmz_safe";

  if(isDefined(level.var_1789643b227cf471)) {
    var_b66875eaf0848550 = [[level.var_1789643b227cf471]](node);
  }

  safe = spawnscriptable(var_b66875eaf0848550, node.origin, node.angles);
  safe.curorigin = safe.origin;
  safe.offset3d = (0, 0, 15);
  safe scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
  objid = safe.objidnum;
  scripts\mp\objidpoolmanager::update_objective_icon(objid, "ui_map_icon_safe");
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 15);
  scripts\mp\objidpoolmanager::update_objective_position(objid, safe.origin + (0, 0, 15));
  scripts\mp\objidpoolmanager::objective_pin_global(objid, 1);
  scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9(objid, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);

  if(level.safeprops.hideicons) {
    scripts\mp\objidpoolmanager::function_9cad42ac02eff950(objid);
  } else {
    scripts\mp\objidpoolmanager::function_a28e8535e00d34f3(objid);
  }

  scripts\mp\objidpoolmanager::function_6ae37618bb04ea60(objid);
  safe.node = node;
  node.safe = safe;
  safe setscriptablepartstate("safe", "usable_not_open");

  if(isDefined(forcedlootid)) {
    safe.contents = scripts\mp\gametypes\br_lootcache::function_ec87b214cd429e96(getscriptablelootcachecontents(safe));
    safe.contents = scripts\mp\gametypes\br_lootcache::function_848e20cf1d6cab8f(safe.contents, 1, forcedlootid);
    safe.contents = array_randomize(safe.contents);
  }

  namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x60>", "<dev string:x51>", undefined, "<dev string:x70>", undefined, undefined, node.poi, node.origin);

  safe.trigger = spawn("trigger_radius", safe.node.origin, 0, int(level.safeprops.captureradius), int(level.safeprops.captureradius));
  safe.trigger trigger_off();
  safe.capturetime = level.safeprops.capturetime;
  safe.revealedteams = [];

  if(level.safeprops.enabledefenders) {
    safe function_a17b754d1372f83e(2);
  }

  safe thread function_474e2e9b4a997564(safe.trigger, level.safeprops.captureradius);
  level.safes[level.safes.size] = safe;
  safe.var_ceb543956c7203e7 = &function_9618cc73546d253d;
  return safe;
}

function function_9618cc73546d253d(container, player) {
  if(!isDefined(container) || !isDefined(player)) {
    return;
  }

  if(container getscriptableparthasstate("safe", "open_usable")) {
    container setscriptablepartstate("safe", "open_usable");
  }
}

function function_20d58c7fb1074fc6(teamname) {
  if(istrue(self.unlocked)) {
    return;
  }

  self notify("safe_unlocked");
  self.unlocked = 1;
}

function function_7c5eefd0cbce6520(instance, part, state, player, bautouse, usestring) {
  if(!isDefined(player.team)) {
    return;
  }

  if(isDefined(instance.overrideusecallback)) {
    self[[instance.overrideusecallback]](instance, part, state, player, bautouse, usestring);
    return;
  }

  if(!safe_canuse(player)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.var_355cddb773cb000d);
    return;
  }

  if(state == "usable_not_open") {
    if(function_42d3f8081a96f0b0(instance, part, state, player)) {
      instance.teams = [player.team];
      instance.trigger trigger_on();
      namespace_25b25d188ef778c4::function_1c2bd1696d29935b(player.team, "dmz_mission_safe_opening");
      function_c1fd3441ccfba6f8(player.team, "dmz_trap_drill", 0.5, "dmz_trap_drill_classic");
      scripts\mp\objidpoolmanager::update_objective_state(instance.objidnum, "current");
      scripts\mp\objidpoolmanager::objective_show_progress(instance.objidnum, 1);
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(instance.objidnum, player.team);
      instance thread function_a765843f381ad171();
      wait 1;
      scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_safe_defend_started", getteamdata(player.team, "players"), instance.node.poi);
    } else {
      instance setscriptablepartstate(part, "usable_not_open");
    }

    return;
  }

  if(state == "open_usable") {
    if(instance getscriptableparthasstate("safe", "unusable")) {
      instance setscriptablepartstate("safe", "unusable");
    }

    if(!isDefined(instance.contents)) {
      var_9256a8c4667baa69 = getdvarint(@ "hash_4c9b0494a5ffac13", 2);
      items = scripts\mp\gametypes\br_lootcache::function_a76b46f057488cc0(instance, player.team, 23, var_9256a8c4667baa69);
      instance.containertype = 4;
      instance scripts\mp\gametypes\br_lootcache::lootcachespawncontents(items, 1, player, instance.contents);
      instance function_20d58c7fb1074fc6(player.team);
      return;
    }

    instance scripts\mp\gametypes\br_lootcache::lootcachespawncontents(undefined, 1, player, instance.contents);
  }
}

function function_42d3f8081a96f0b0(safe, part, state, player) {
  safe setscriptablepartstate(part, "unusable");
  safe.successfuluse = 0;
  safe thread function_24765a7aabf0093e(player);
  safe function_7f10e8e120314f4b(player, part);
  return istrue(safe.successfuluse);
}

function function_a17b754d1372f83e(var_6e6ee0d9f73a2999) {
  self.agents = [];
  aitype = scripts\mp\ai_mp_controller::function_d5bc07eabf352abb(undefined, undefined, "short_range", undefined, 2);
  forwarddist = anglesToForward(self.angles) * 80;
  origin = getclosestpointonnavmesh(self.origin + forwarddist);
  agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, origin, self.angles, "high", "mission", "safeInitialGuards", undefined, undefined, undefined, self.node.poi, 0, undefined, 1);

  if(isDefined(agent)) {
    self.agents[0] = agent;
    thread scripts\mp\ai_behavior::function_b11c1964f528574b(agent, 0);
  }

  for(i = 0; i < var_6e6ee0d9f73a2999; i++) {
    aitype = scripts\mp\ai_mp_controller::function_d5bc07eabf352abb(undefined, undefined, "short_range");
    var_50fbac14da970ae7 = randomfloatrange(144, 360);
    forward = anglesToForward(self.angles) * var_50fbac14da970ae7;
    right = vectorcross((0, 0, 1), forward);
    facingangle = axistoangles(forward, right, (0, 0, 1));
    var_88b83b0d7a43ea72 = i / var_6e6ee0d9f73a2999 * 360 + randomfloatrange(-30, 30) % 360;
    offset = rotatepointaroundvector((0, 0, 1), forward, var_88b83b0d7a43ea72);
    origin = getclosestpointonnavmesh(self.origin + offset);
    agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, origin, facingangle, "high", "mission", "safe", undefined, undefined, undefined, self.node.poi, 0, undefined, 0);

    if(isDefined(agent)) {
      self.agents[self.agents.size] = agent;
      thread scripts\mp\ai_behavior::function_b11c1964f528574b(agent);
    }
  }
}

function function_a765843f381ad171() {
  level endon("game_ended");
  self endon("safe_unlocked");
  self.progress = 0;
  var_a81135442ee1a731 = 0;
  var_306804c6c85c36b0 = undefined;
  intervalindex = 0;
  alertradius = 512;
  helicalled = 0;
  shownplayers = [];

  while(true) {
    if(isDefined(self.trigger) && !istrue(self.trigger.trigger_off)) {
      if(!isDefined(var_306804c6c85c36b0)) {
        var_306804c6c85c36b0 = [0, self.capturetime / 4, self.capturetime / 2, self.capturetime / 100 * 75];
      }

      if(self.nearbyplayers.size > 0) {
        progressbefore = self.progress;
        self.progress = min(self.capturetime, self.progress + level.framedurationseconds);
      } else {
        progressbefore = self.progress;
        self.progress = max(0, self.progress - level.framedurationseconds * 0.5);
      }

      progress = self.progress / self.capturetime;
      shownplayers = function_75a1596e8181156(self.nearbyplayers, shownplayers, progress);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);

      if(self.progress >= self.capturetime) {
        function_67abfc6a70af2ccc();

        if(isDefined(level.var_67abfc6a70af2ccc)) {
          self[[level.var_67abfc6a70af2ccc]]();
        }
      } else if(level.safeprops.enabledefenders && self.nearbyplayers.size > 0 && isDefined(var_306804c6c85c36b0[intervalindex]) && self.progress >= var_306804c6c85c36b0[intervalindex]) {
        intervalindex++;
        alertradius += 768;

        if(alertradius > 2816) {
          alertradius = 2816;
        }

        agents = scripts\mp\ai_mp_controller::function_353fecd1549f5f42(self.origin, alertradius, undefined, 3, undefined, 64, 128);

        if(isDefined(agents)) {
          self.agents = array_combine(self.agents, agents);
          var_a81135442ee1a731 += agents.size;
        }

        if(!helicalled && intervalindex == 1 && var_a81135442ee1a731 < 4) {
          var_da117ca38efac51b = scripts\mp\ai_mp_controller::function_77acc10c4823dd8a(5, self.origin, "high", "mission", "safeReinforcements", undefined, undefined, 1, self.node.poi, "Helicopter", 32, 64);

          if(isDefined(var_da117ca38efac51b) && var_da117ca38efac51b.size > 0) {
            helicalled = 1;
            self.agents = array_combine(self.agents, var_da117ca38efac51b);
          }
        }
      } else if(self.nearbyplayers.size == 0 && intervalindex > 0) {
        intervalindex = 0;
        alertradius = 512;
      }
    }

    waitframe();
  }
}

function function_75a1596e8181156(nearbyplayers, shownplayers, progress) {
  allplayers = array_combine(nearbyplayers, shownplayers);
  var_f6fd7b0e73c3270c = shownplayers;

  foreach(player in allplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(player.team) && !array_contains(self.teams, player.team)) {
      self.teams[self.teams.size] = player.team;
    }

    if(!array_contains(shownplayers, player) && array_contains(nearbyplayers, player)) {
      if(scripts\mp\objidpoolmanager::function_ce702e5925e31fc9(self.objidnum, player, 1, 2, &"MP_DMZ_MISSIONS/OPENING_SAFE")) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objidnum, player);
        var_f6fd7b0e73c3270c = array_add(var_f6fd7b0e73c3270c, player);
      }

      continue;
    }

    if(array_contains(shownplayers, player) && !array_contains(nearbyplayers, player)) {
      scripts\mp\objidpoolmanager::function_26259bd38697b5ad(self.objidnum, player);
      var_f6fd7b0e73c3270c = array_remove(var_f6fd7b0e73c3270c, player);
    }
  }

  return var_f6fd7b0e73c3270c;
}

function function_67abfc6a70af2ccc() {
  self.trigger delete();

  foreach(team in self.teams) {
    foreach(player in getteamdata(team, "players")) {
      scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);
      scripts\mp\objidpoolmanager::function_26259bd38697b5ad(self.objidnum, player);

      if(!isDefined(player.var_35b94c88cc1cea97)) {
        player.var_35b94c88cc1cea97 = 0;
      }

      player.var_35b94c88cc1cea97++;
      player scripts\mp\utility\points::doscoreevent(#"hash_c02c8c802f07c908");
    }

    scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_safe_defend_unlocked", getteamdata(team, "players"));
    namespace_25b25d188ef778c4::function_1c2bd1696d29935b(team, "dmz_mission_safe_unlocked");
    scripts\mp\pmc_missions::function_a9f8fa06a358585b(team, "safe", 1, self.node.poi, 1);
    function_c1fd3441ccfba6f8(team, "", 1.5);
  }

  self.opened = 1;
  scripts\mp\gameobjects::releaseid();
  self setscriptablepartstate("safe", "opening");
}

function function_474e2e9b4a997564(trigger, radius) {
  level endon("game_ended");
  self endon("safe_unlocked");
  self.nearbyplayers = [];

  while(true) {
    trigger waittill("trigger", player);

    if(!isPlayer(player) || array_contains(self.nearbyplayers, player)) {
      continue;
    }

    if(!array_contains(self.teams, player.team)) {
      self.teams[self.teams.size] = player.team;
    }

    self.nearbyplayers = array_add(self.nearbyplayers, player);
    thread function_d5720ae15e13ff51(trigger, player, radius);
  }
}

function function_d5720ae15e13ff51(trigger, player, radius) {
  while(isDefined(player) && isalive(player) && isDefined(self.trigger) && distance(trigger.origin, player.origin) < radius * 1.2) {
    wait 0.2;
  }

  self.nearbyplayers = array_remove(self.nearbyplayers, player);
}

#using_animtree("script_model");

function script_model_anims() {
  level.scr_animtree["safe_drill_player"] = #animtree;
  level.scr_anim["safe_drill_player"]["safedrill_enter"] = % iw9_dmz_safedrill_enter_sdr;
  level.scr_eventanim["safe_drill_player"]["safedrill_enter"] = % "safedrill_enter";
  level.scr_viewmodelanim["safe_drill_player"]["safedrill_enter"] = "iw9_dmz_safedrill_enter_sdr";
  level.scr_anim["safe_drill_player"]["safedrill_exit"] = % iw9_dmz_safedrill_exit_sdr;
  level.scr_eventanim["safe_drill_player"]["safedrill_exit"] = % "safedrill_exit";
  level.scr_viewmodelanim["safe_drill_player"]["safedrill_exit"] = "iw9_dmz_safedrill_exit_sdr";
}

function function_680b501eb7141c84(isallowed, key) {
  if(!isDefined(key)) {
    key = "drilling";
  }

  if(!isallowed) {
    val::set(key, "allow_jump", 0);
    val::set(key, "gesture", 0);
    val::set(key, "melee", 0);
    val::set(key, "mantle", 0);
    val::set(key, "offhand_weapons", 0);
    val::set(key, "allow_movement", 0);
    val::set(key, "sprint", 0);
    val::set(key, "fire", 0);
    val::set(key, "reload", 0);
    val::set(key, "weapon_pickup", 0);
    val::set(key, "weapon_switch", 0);
    val::set(key, "offhand_weapons", 0);
    val::set(key, "execution_victim", 0);
    val::set(key, "vehicle_use", 0);
    val::set(key, "supers", 0);
    val::set(key, "third_person_toggle", 0);
    self setclientomnvar("ui_br_inventory_disabled", 1);
    self function_35501b42058d4de9();
    return;
  }

  val::reset_all(key);
  self setclientomnvar("ui_br_inventory_disabled", 0);
  self function_bb04491d50d9e43e();
}

function function_7f10e8e120314f4b(player, part) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");
  player function_680b501eb7141c84(0);
  linkedparent = self.linkedparent;
  goalpos = self.origin + rotatevector((50.586, -6.262, 0), self.angles);
  forward = (0, 0, 0) - anglesToForward(self.angles);
  up = (0, 0, 1);
  right = vectorcross(forward, up);
  goalangles = axistoangles(forward, right, up);

  if(!isDefined(linkedparent)) {
    playerviewangles = player getplayerangles();
    player.linktoent = player spawn_tag_origin(player.origin, player.playerviewangles);
    player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 0, 1);
    player setstance("stand");
    movetotime = 0.5;
    player.linktoent moveTo(goalpos, movetotime, 0.1, 0.1);
    player.linktoent rotateTo(goalangles, movetotime, 0.1, 0.1);
    player setstance("stand");
    var_cd9982adb17761a8 = gettime();
    player scripts\cp_mp\utility\inventory_utility::givegunlessweapon();
    var_698cc218e4ade75f = gettime();
    var_218f64cb035d54be = movetotime - (var_698cc218e4ade75f - var_cd9982adb17761a8) / 1000;
    waittime = max(0, var_218f64cb035d54be);
    wait waittime;
  } else {
    player setstance("stand");
    player scripts\cp_mp\utility\inventory_utility::givegunlessweapon();
  }

  player setOrigin(goalpos);
  player setplayerangles(goalangles);
  player thread scripts\mp\utility\infilexfil::infil_player_rig_updated("safe_drill_player", player.origin, player.angles);
  player.player_rig showonlytoplayer(player);

  if(isDefined(linkedparent)) {
    player.player_rig linkTo(linkedparent);
  }

  self setscriptablepartstate(part, "unusable_intro_drilling");
  scripts\mp\anim::anim_player_solo(player, player.player_rig, "safedrill_enter");

  if(isreallyalive(player)) {
    scripts\mp\anim::anim_player_solo(player, player.player_rig, "safedrill_exit");
  }

  if(isDefined(player) && isreallyalive(player)) {
    player notify("interact_finished");
  }

  waitframe();

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(player)) {
    player notify("remove_rig");

    if(isreallyalive(player)) {
      player function_680b501eb7141c84(1);
    }
  }

  self.successfuluse = 1;
}

function function_24765a7aabf0093e(player) {
  player endon("interact_finished");
  player scripts\engine\utility::waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");
  player notify("interact_interrupt");
  player stopanimscriptsceneevent();

  if(isDefined(player.linktoent)) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
  }

  player notify("remove_rig");
  player function_680b501eb7141c84(1);
}

function function_9967799221f8dd5e(team, origin) {
  wait 4;
  poi = scripts\mp\poi::function_55cf921efa4cbd09(origin, 0, 0, 1);
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_safes_revealed", getteamdata(team, "players"), poi);
  sorted = sortbydistance(level.safes, origin);
  numrevealed = 0;
  var_d4266812b99539b6 = namespace_a38a2e1fe7519183::function_e860c1be7ff11f5b(team, 21);
  var_6451409d2bfddb20 = randomintrange(level.safeprops.revealmin, level.safeprops.revealmax + 1) + var_d4266812b99539b6;

  foreach(safe in sorted) {
    if(!istrue(safe.opened) && !array_contains(safe.revealedteams, team)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(safe.objidnum, team);
      safe.revealedteams[safe.revealedteams.size] = team;
      numrevealed++;

      if(numrevealed >= var_6451409d2bfddb20) {
        break;
      }
    }
  }
}

function safe_canuse(player) {
  if(isDefined(player) && istrue(player.var_859654e0445a36d9)) {
    return false;
  }

  return true;
}

function function_747adf1e8fdb5ce6() {
  while(true) {
    if(getdvarint(@ "hash_c3c6da5323f1370f", 0)) {
      setDvar(@ "hash_c3c6da5323f1370f", 0);
      thread function_9967799221f8dd5e(level.players[0].team, level.players[0].origin);
    }

    waitframe();
  }
}

# /