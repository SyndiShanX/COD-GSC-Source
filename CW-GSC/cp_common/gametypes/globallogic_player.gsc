/******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\globallogic_player.gsc
******************************************************/

#using script_35ae72be7b4fec10;
#using script_3626f1b2cf51a99c;
#using script_725554a59d6a75b9;
#using script_db93c4bbed6e456;
#using scripts\abilities\ability_power;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\healthoverlay;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\medals_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\weapons_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\gamedifficulty;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_spawn;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\globallogic_utils;
#using scripts\cp_common\gametypes\loadout;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hazard;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weapon_utils;
#using scripts\weapons\weapons;
#namespace globallogic_player;

function private autoexec __init__system__() {
  system::register(#"globallogic_player", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_fd81f309 = ["MOD_PISTOL_BULLET", "MOD_RIFLE_BULLET", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_GRENADE"];
  level.var_1befd357 = ["MOD_PISTOL_BULLET", "MOD_RIFLE_BULLET", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_MELEE", "MOD_MELEE_WEAPON_BUTT", "MOD_HEAD_SHOT", "MOD_SUICIDE", "MOD_EXPLOSIVE"];
  level.var_ee4d094a = [];
  var_ed2bc2e0 = getscriptbundle("death_gesture_pool");

  foreach(collection in var_ed2bc2e0.collections) {
    var_4546d401 = [];

    foreach(entry in collection.stand) {
      if(!isDefined(var_4546d401[#"stand"])) {
        var_4546d401[#"stand"] = [];
      } else if(!isarray(var_4546d401[#"stand"])) {
        var_4546d401[#"stand"] = array(var_4546d401[#"stand"]);
      }

      var_4546d401[#"stand"][var_4546d401[#"stand"].size] = entry.gesture;
    }

    assert(isDefined(var_4546d401[#"stand"]));

    foreach(entry in collection.crouch) {
      if(!isDefined(var_4546d401[#"crouch"])) {
        var_4546d401[#"crouch"] = [];
      } else if(!isarray(var_4546d401[#"crouch"])) {
        var_4546d401[#"crouch"] = array(var_4546d401[#"crouch"]);
      }

      var_4546d401[#"crouch"][var_4546d401[#"crouch"].size] = entry.gesture;
    }

    assert(isDefined(var_4546d401[#"crouch"]));

    foreach(entry in collection.prone) {
      if(!isDefined(var_4546d401[#"prone"])) {
        var_4546d401[#"prone"] = [];
      } else if(!isarray(var_4546d401[#"prone"])) {
        var_4546d401[#"prone"] = array(var_4546d401[#"prone"]);
      }

      var_4546d401[#"prone"][var_4546d401[#"prone"].size] = entry.gesture;
    }

    assert(isDefined(var_4546d401[#"prone"]));

    if(is_true(collection.var_9af99f2f)) {
      assert(!isDefined(level.var_ee4d094a[#"hash_3a5790d783810d4a"]));
      level.var_ee4d094a[#"hash_3a5790d783810d4a"] = var_4546d401;
      continue;
    }

    assert(isDefined(collection.weapon));
    assert(!isDefined(level.var_ee4d094a[collection.weapon]));
    level.var_ee4d094a[collection.weapon] = var_4546d401;
  }

  clientfield::register("toplayer", "player_damage_type", 1, 1, "int");
  clientfield::register("toplayer", "player_death_shield", 1, 1, "int");
  clientfield::register("toplayer", "player_death_gesture", 1, 1, "int");

  util::init_dvar("<dev string:x38>", 1, &function_a215b825);
  util::init_dvar("<dev string:x4f>", 0, &function_a215b825);
  util::init_dvar("<dev string:x65>", "<dev string:x7f>", &function_a215b825);
  level thread function_c5972380();
}

function private function_a215b825(params) {
  if(params.name == "<dev string:x38>") {
    level.var_841888e0 = int(params.value);
    return;
  }

  if(params.name == "<dev string:x4f>") {
    level.var_16f6fb10 = int(params.value);
    return;
  }

  if(params.name == "<dev string:x65>") {
    level.var_b63e01a9 = params.value;
  }
}

function private function_16f6fb10() {
  player = self;
  self notify("<dev string:x83>");
  self endon("<dev string:x83>");
  player endon(#"disconnect");
  self notifyonplayercommand("<dev string:x97>", "<dev string:xa7>");

  while(true) {
    self waittill(#"play_gesture");
    gesture = level.var_b63e01a9;
    var_f3002d70 = function_39ab832f(1);

    if(!var_f3002d70) {
      waitframe(1);
      continue;
    }

    setslowmotion(1, 0.2, 0.3);
    player function_7abbea8e({
      #var_3ca8c1dc: gesture
    });
    player stopgestureviewmodel(gesture);
    player util::function_e05fc3fb(0);
    setslowmotion(0.2, 1, 0.3);
  }
}

function private function_c5972380() {
  while(true) {
    level waittill(#"save_restore");
    level.var_841888e0 = getdvarint(#"hash_5db59e8350ba59e7", 1);
  }
}

function function_94865447() {
  if(isDefined(level.var_d7d201ba) && !self flag::exists(level.var_d7d201ba)) {
    self flag::init(level.var_d7d201ba);
  }
}

function function_5379a6ca(mapname, var_e29f1b52, var_33ff23e1) {
  var_b34e8e96 = self stats::get_stat(#"playerstatsbymap", mapname, var_e29f1b52);

  if(isDefined(var_b34e8e96)) {
    self recordcareerstatformap(var_33ff23e1, mapname, var_b34e8e96);
  }
}

function function_20b68a46(mapname, var_e29f1b52, var_33ff23e1) {
  var_77b33741 = self stats::get_stat(#"playerstatsbymap", mapname, var_e29f1b52);

  if(isDefined(var_77b33741)) {
    self recordcareerflagformap(var_33ff23e1, mapname, var_77b33741);
  }
}

function function_3b6a335b() {
  if(!sessionmodeisonlinegame()) {
    return;
  }

  var_36b17068 = skipto::function_228558fd();

  foreach(mapname in var_36b17068) {
    self function_20b68a46(mapname, "hasBeenCompleted", "completed");
    self function_5379a6ca(mapname, "firstTimeCompletedUTC", "firstTimeCompleted");
    self function_5379a6ca(mapname, "lastCompletedUTC", "lastTimeCompleted");
    self function_5379a6ca(mapname, "numCompletions", "numberTimesCompleted");
    self function_20b68a46(mapname, "allAccoladesComplete", "allAccoladesComplete");
  }
}

function function_eee2a9d2() {
  if(!sessionmodeisonlinegame()) {
    return;
  }

  self function_3b6a335b();
  var_a25c62f6 = self stats::get_stat(#"playerstatslist", #"hash_668c1bd08c419f31", #"statvalue");
  self recordcareerstat("duration_total_paused_seconds", var_a25c62f6);
  var_cf196dd1 = self stats::get_stat("PlayerStatsList", #"hash_b38ac686f0e8f63", #"statvalue");
  self recordcareerstat("duration_total_seconds", var_cf196dd1);
  var_1ebfb2ab = self stats::get_stat(#"playerstatslist", #"kills", #"statvalue");
  self recordcareerstat("kills_Total", var_1ebfb2ab);
  var_d741995b = self stats::get_stat(#"playerstatslist", #"deaths", #"statvalue");
  self recordcareerstat("deaths_Total", var_d741995b);
  var_6fa2ecd1 = self stats::get_stat(#"hash_7dd9f1ac62a346d", #"hash_c159a616c8e909f");
  self recordcareerstat("deadOps_Total", var_6fa2ecd1);
}

function init_character_index() {
  bodytype = 0;

  if(isbot(self)) {
    bodytype = isDefined(player_role::function_c1f61ea2()) ? player_role::function_c1f61ea2() : 0;
  }

  if(player_role::is_valid(bodytype)) {
    player_role::set(bodytype);
  }
}

function callback_playerconnect() {
  function_94865447();
  thread notifyconnecting();
  self.statusicon = "$default";
  self waittill(#"begin");

  if(isDefined(level.reset_clientdvars)) {
    self[[level.reset_clientdvars]]();
  }

  if(isbot(self)) {
    level flag::wait_till("all_players_connected");
  }

  waittillframeend();
  self.statusicon = "";
  self.guid = self getguid();
  checkpointclear();
  savegame::checkpoint_save();
  self function_d4d27d5b();
  self thread function_f92e23de();
  profilelog_begintiming(4, "ship");

  if(self ishost()) {
    self thread globallogic::listenforgameend();
  }

  if(!level.splitscreen && !isDefined(self.pers[#"score"])) {
    iprintln(#"mp/connected", self);
  }

  if(!isDefined(self.pers[#"score"])) {
    self thread persistence::adjust_recent_stats();
    self stats::function_7a850245(#"valid", 0);
  }

  self.movementtracking = spawnStruct();
  self thread util::trackwallrunningdistance();
  self thread util::tracksprintdistance();
  self thread util::trackdoublejumpdistance();
  lpselfnum = self getentitynumber();
  lpxuid = self getxuid(1);
  bb::function_afcc007d(self.name, lpselfnum, lpxuid);
  init_character_index();
  self val::reset(#"player_connect", "show_hud");
  self setclientuivisibilityflag("weapon_hud_visible", 1);

  if(level.forceradar == 1) {
    self.pers[#"hasradar"] = 1;
    level.activeuavs[self getentitynumber()] = 1;
  }

  if(level.forceradar == 2) {
    self setclientuivisibilityflag("g_compassShowEnemies", level.forceradar);
  } else {
    self setclientuivisibilityflag("g_compassShowEnemies", 0);
  }

  self setclientplayersprinttime(level.playersprinttime);
  self setclientnumlives(level.numlives);
  self.lives = level.numlives;

  if(level.hardcoremode) {
    self setclientdrawtalk(3);
  }

  self.killedplayerscurrent = [];

  if(!isDefined(self.pers[#"best_kill_streak"])) {
    self.pers[#"killed_players"] = [];
    self.pers[#"killed_by"] = [];
    self.pers[#"nemesis_tracking"] = [];
    self.pers[#"artillery_kills"] = 0;
    self.pers[#"dog_kills"] = 0;
    self.pers[#"nemesis_name"] = "";
    self.pers[#"nemesis_rank"] = 0;
    self.pers[#"nemesis_rankicon"] = 0;
    self.pers[#"nemesis_xp"] = 0;
    self.pers[#"nemesis_xuid"] = "";
    self.pers[#"best_kill_streak"] = 0;
  }

  if(!isDefined(self.pers[#"music"])) {
    self.pers[#"music"] = spawnStruct();
    self.pers[#"music"].spawn = 0;
    self.pers[#"music"].inque = 0;
    self.pers[#"music"].currentstate = "SILENT";
    self.pers[#"music"].previousstate = "SILENT";
    self.pers[#"music"].nextstate = "UNDERSCORE";
    self.pers[#"music"].returnstate = "UNDERSCORE";
  }

  self.leaderdialogqueue = [];
  self.leaderdialogactive = 0;
  self.leaderdialoggroups = [];
  self.currentleaderdialoggroup = "";
  self.currentleaderdialog = "";
  self.currentleaderdialogtime = 0;

  if(!isDefined(self.pers[#"cur_kill_streak"])) {
    self.pers[#"cur_kill_streak"] = 0;
  }

  if(!isDefined(self.pers[#"cur_total_kill_streak"])) {
    self.pers[#"cur_total_kill_streak"] = 0;
    self setplayercurrentstreak(0);
  }

  if(!isDefined(self.pers[#"totalkillstreakcount"])) {
    self.pers[#"totalkillstreakcount"] = 0;
  }

  if(!isDefined(self.pers[#"killstreaksearnedthiskillstreak"])) {
    self.pers[#"killstreaksearnedthiskillstreak"] = 0;
  }

  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks && !isDefined(self.pers[#"killstreak_quantity"])) {
    self.pers[#"killstreak_quantity"] = [];
  }

  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks && !isDefined(self.pers[#"held_killstreak_ammo_count"])) {
    self.pers[#"held_killstreak_ammo_count"] = [];
  }

  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks && !isDefined(self.pers[#"held_killstreak_clip_count"])) {
    self.pers[#"held_killstreak_clip_count"] = [];
  }

  if(!isDefined(self.pers[#"changed_class"])) {
    self.pers[#"changed_class"] = 0;
  }

  self.lastkilltime = 0;
  self.cur_death_streak = 0;
  self disabledeathstreak();
  self.death_streak = 0;
  self.kill_streak = 0;
  self.gametype_kill_streak = 0;
  self.spawnqueueindex = -1;
  self.deathtime = 0;
  player::init_heal(1, 0);
  self.lastgrenadesuicidetime = -1;
  self.teamkillsthisround = 0;

  if(isDefined(world.player_lives)) {
    self.pers[#"lives"] = world.player_lives;
  } else if(!isDefined(level.livesdonotreset) || !level.livesdonotreset || !isDefined(self.pers[#"lives"])) {
    self.pers[#"lives"] = level.numlives;
  }

  self.pers[#"team"] = undefined;
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.deathcount = 0;
  self.var_c2287847 = gettime();
  self.meleekills = 0;
  self.wasaliveatmatchstart = 0;
  self.grenadesused = 0;

  if(level.splitscreen) {
    setDvar(#"splitscreen_playernum", level.players.size);
  }

  if(game.state == "postgame") {
    self.pers[#"needteam"] = 1;
    self.pers[#"team"] = "spectator";
    self.team = "spectator";
    self.sessionteam = "spectator";
    self val::set(#"player_connect", "show_hud", 0);
    self[[level.spawnintermission]]();
    self closeingamemenu();
    profilelog_endtiming(4, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame());
    return;
  }

  level endon(#"game_ended");

  if(level.oldschool) {
    self.pers[#"class"] = undefined;
    self.curclass = self.pers[#"class"];
  }

  if(isDefined(self.pers[#"team"])) {
    self.team = self.pers[#"team"];
  }

  if(isDefined(self.pers[#"class"])) {
    self.curclass = self.pers[#"class"];
  }

  if(!isDefined(self.pers[#"team"]) || isDefined(self.pers[#"needteam"])) {
    self.pers[#"needteam"] = undefined;
    self.pers[#"team"] = "spectator";
    self.team = "spectator";
    self.sessionstate = "dead";
    self globallogic_ui::updateobjectivetext();
    [[level.spawnspectator]]();
    [[level.autoassign]](0);

    if(level.rankedmatch || level.leaguematch) {
      self thread globallogic_spawn::kickifdontspawn();
    }

    if(level.teambased) {
      self.sessionteam = self.pers[#"team"];

      if(!isalive(self)) {
        self.statusicon = "hud_status_dead";
      }

      self thread spectating::set_permissions();
    }
  } else {
    self.sessionteam = self.pers[#"team"];
    self.sessionstate = "dead";
    self globallogic_ui::updateobjectivetext();
    [[level.spawnspectator]]();

    if(globallogic_utils::isvalidclass(self.pers[#"class"])) {
      self thread[[level.spawnclient]]();
    } else {
      self globallogic_ui::showmainmenuforteam();
    }

    self thread spectating::set_permissions();
  }

  if(self.sessionteam != "spectator") {
    self[[level.onspawnplayer]](1);
  }

  profilelog_endtiming(4, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame());

  if(!isDefined(level.players)) {
    level.players = [];
  } else if(!isarray(level.players)) {
    level.players = array(level.players);
  }

  if(!isinarray(level.players, self)) {
    level.players[level.players.size] = self;
  }

  level.player = self;
  globallogic::updateteamstatus();
  self function_eee2a9d2();
  var_c0fcc1e2 = self stats::get_stat(#"zmcampaigndata", #"unlocked");

  if(!isDefined(level.var_841888e0)) {
    level.var_841888e0 = 1;
  }

  if(is_true(level.var_16f6fb10)) {
    self thread function_16f6fb10();
  }

  level notify(#"connected", {
    #player: self
  });
  callback::callback(#"on_player_connect");
}

function function_d4d27d5b() {
  incaps = self stats::get_stat(#"playerstatslist", #"incaps", #"statvalue");

  if(!isDefined(incaps)) {
    incaps = 0;
  }

  revives = self stats::get_stat(#"playerstatslist", #"revives", #"statvalue");

  if(!isDefined(revives)) {
    revives = 0;
  }

  self setnoncheckpointdata("INCAPS", incaps);
  self setnoncheckpointdata("REVIVES", revives);
}

function function_f92e23de() {
  self endon(#"disconnect");
  var_11ffb46 = getrootmapname();

  if(!isDefined(var_11ffb46) || is_true(level.disablestattracking)) {
    return;
  }

  while(true) {
    level waittill(#"save_restore");
    var_eeb08e4 = self getnoncheckpointdata("INCAPS");
    var_397a145d = self stats::get_stat(#"playerstatslist", #"incaps", #"statvalue");
    var_ebf6c5c6 = self stats::get_stat(#"playerstatsbymap", var_11ffb46, #"currentstats", #"incaps");

    if(isDefined(var_eeb08e4)) {
      assert(var_eeb08e4 >= var_397a145d, "<dev string:xb8>");
      assert(var_eeb08e4 >= var_ebf6c5c6, "<dev string:xd9>");
      self stats::set_stat(#"playerstatslist", #"incaps", #"statvalue", var_eeb08e4);
      self.incaps = var_eeb08e4 - self stats::get_stat(#"playerstatsbymap", var_11ffb46, #"currentstats", #"incaps");
      self.pers[#"incaps"] = self.incaps;
    }

    var_cb9c2ac2 = self getnoncheckpointdata("REVIVES");
    var_a25504c0 = self stats::get_stat(#"playerstatslist", #"revives", #"statvalue");
    var_939d065a = self stats::get_stat(#"playerstatsbymap", var_11ffb46, #"currentstats", #"revives");

    if(isDefined(var_cb9c2ac2)) {
      assert(var_cb9c2ac2 >= var_a25504c0, "<dev string:xf7>");
      assert(var_cb9c2ac2 >= var_939d065a, "<dev string:x113>");
      self stats::set_stat(#"playerstatslist", #"revives", #"statvalue", var_cb9c2ac2);
      self.revives = var_cb9c2ac2 - self stats::get_stat(#"playerstatsbymap", var_11ffb46, #"currentstats", #"revives");
      assert(self.revives >= 0);
      self.pers[#"revives"] = self.revives;
    }

    var_28f0970b = self getnoncheckpointdata("lives");

    if(isDefined(var_28f0970b)) {
      self.lives = var_28f0970b;
      self clearnoncheckpointdata("lives");
    }
  }
}

function callback_playermigrated() {}

function callback_playerdisconnect() {
  profilestart();
  checkpointclear();
  savegame::checkpoint_save();
  arrayremovevalue(level.players, self);
  [[level.onplayerdisconnect]]();
  self clearallnoncheckpointdata();
  profilestop();
}

function callback_playermelee(eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind) {
  hit = 1;

  if(level.teambased && self.team == idamage.team) {
    if(level.friendlyfire == 0) {
      hit = 0;
    }
  }

  self finishmeleehit(idamage, weapon, vorigin, vdir, boneindex, shieldhit, hit, frombehind);
}

function function_74b6d714(attacker, effectname, var_894859a2, durationoverride, weapon) {
  var_20df3f41 = function_1115bceb(effectname);

  if(isDefined(durationoverride) && durationoverride > 0) {
    duration = durationoverride;
  } else {
    duration = undefined;
  }

  self status_effect::status_effect_apply(var_20df3f41, weapon, attacker, undefined, duration, var_894859a2);
}

function custom_gamemodes_modified_damage(victim, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc) {
  if(level.onlinegame && !sessionmodeisprivate()) {
    return einflictor;
  }

  if(isDefined(weapon) && isDefined(weapon.damagemodifier)) {
    einflictor *= weapon.damagemodifier;
  }

  if(shitloc == "MOD_PISTOL_BULLET" || shitloc == "MOD_RIFLE_BULLET") {
    einflictor = int(einflictor * level.bulletdamagescalar);
  }

  return einflictor;
}

function function_c2a2b500(victim, dir, smeansofdeath) {
  var_e3dbc335 = 0.64;

  if(is_true(victim.var_108942e2) && isDefined(dir)) {
    if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
      axis = undefined;

      if(isPlayer(victim)) {
        axis = anglestoaxis(victim getplayerangles());
      } else {
        axis = anglestoaxis(victim.angles);
      }

      if(vectordot(dir, axis.forward * -1) > var_e3dbc335) {
        return true;
      }
    }
  }

  return false;
}

function function_601cae2a(weapon, einflictor) {
  if(weapon == level.weaponnone && isDefined(einflictor)) {
    if(isDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
      weapon = getweapon(#"explodable_barrel");
    } else if(isDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
      weapon = getweapon(#"destructible_car");
    }
  }

  return weapon;
}

function figureoutfriendlyfire(victim, eattacker) {
  return level.friendlyfire;
}

function function_4b298d1f(eattacker, weapon) {
  if(level.hardcoremode) {
    return 0;
  }

  if(!isDefined(eattacker)) {
    return 0;
  }

  if(self != eattacker) {
    return 0;
  }

  return weapon.donotdamageowner;
}

function function_7681dccc() {
  if(self isinvehicle()) {
    vehicle = self getvehicleoccupied();

    if(isDefined(vehicle) && isDefined(vehicle.overrideplayerdamage)) {
      return vehicle.overrideplayerdamage;
    }
  }

  if(isDefined(self.overrideplayerdamage)) {
    return self.overrideplayerdamage;
  }

  if(isDefined(level.overrideplayerdamage)) {
    return level.overrideplayerdamage;
  }
}

function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
  profilelog_begintiming(6, "ship");

  if(game.state == "postgame") {
    return;
  }

  if(self.sessionteam == "spectator") {
    return;
  }

  if(self getinvulnerability()) {
    return;
  }

  if(isDefined(self.candocombat) && !self.candocombat) {
    return;
  }

  if(level flag::get(#"chyron_active")) {
    return;
  }

  if(scene::is_igc_active() && !scene::function_871087b6()) {
    return;
  }

  if(self.scene_takedamage === 0) {
    return;
  }

  if(is_true(self.var_977d278d)) {
    return;
  }

  if(is_true(self.b_teleport_invulnerability)) {
    return;
  }

  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(eattacker.candocombat) && !eattacker.candocombat) {
    return;
  }

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  if(smeansofdeath === "MOD_TRIGGER_HURT" && isDefined(einflictor) && isstring(einflictor.var_d92bc43b)) {
    if(einflictor.var_d92bc43b != "none" && einflictor.var_d92bc43b != "false") {
      var_e0445c07 = !isPlayer(einflictor) && is_true(einflictor.var_860eee77);
      var_e44c571d = is_true(self.var_ac0c25c9) || var_e0445c07;
      hazard::do_damage(einflictor.var_d92bc43b, idamage, einflictor, var_e44c571d);

      if(!var_e0445c07) {
        return;
      }
    }
  }

  weaponname = weapon.name;

  if((weaponname == "ai_tank_drone_gun" || weaponname == "ai_tank_drone_rocket") && !level.hardcoremode) {
    if(isDefined(eattacker) && eattacker == self) {
      if(isDefined(einflictor) && isDefined(einflictor.from_ai)) {
        return;
      }
    }

    if(isDefined(eattacker) && isDefined(eattacker.owner) && eattacker.owner == self) {
      return;
    }
  }

  if(weapon.isemp) {
    if(self hasperk(#"specialty_immuneemp")) {
      return;
    }

    self notify(#"emp_grenaded", {
      #attacker: eattacker, #position: vpoint
    });
  }

  if(isDefined(eattacker) && isPlayer(eattacker) && !weapons::ismeleemod(smeansofdeath)) {
    var_8f516911 = function_b576d3d(weapon, shitloc);
    idamage *= var_8f516911;
  }

  overrideplayerdamage = function_7681dccc();
  idamage = int(idamage);
  unmodified = idamage;

  if(isDefined(overrideplayerdamage)) {
    modifieddamage = self[[overrideplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex);

    if(isDefined(modifieddamage)) {
      if(modifieddamage <= 0) {
        return;
      }

      idamage = modifieddamage;
    }
  }

  assert(isDefined(idamage), "<dev string:x133>");
  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = eattacker;
  params.idamage = idamage;
  params.idflags = idflags;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.var_fd90b0bb = var_fd90b0bb;
  params.vpoint = vpoint;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.vdamageorigin = vdamageorigin;
  params.psoffsettime = psoffsettime;
  self.last_damaged_time = level.time;
  self callback::callback(#"on_player_damage", params);

  if(self hasperk(#"specialty_immuneparanoia")) {
    movementvector = self getvelocity();

    if(lengthsquared(movementvector) < 2500) {
      idamage *= 0.7;
    }
  }

  if(self hasperk(#"specialty_flakjacket") && weapons::isexplosivedamage(smeansofdeath) && !is_true(weapon.ignoresflakjacket)) {
    idamage *= 0.5;
  }

  if(isDefined(eattacker) && (!isPlayer(eattacker) || is_true(isbot(eattacker)))) {
    if(self flag::get("player_is_invulnerable") && !self function_883dd64(idamage)) {
      idamage = 0;
    }
  }

  idamage = custom_gamemodes_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
  idamage = int(idamage);
  self.idflags = idflags;
  self.idflagstime = gettime();
  eattacker = figureoutattacker(eattacker);
  idamage = gamedifficulty::function_2aed7a44(self, eattacker, einflictor, idamage, weapon, shitloc, smeansofdeath);
  idamage = gamedifficulty::function_23dcd1f6(self, eattacker, einflictor, idamage, weapon, shitloc, smeansofdeath);
  idamage = int(idamage);
  pixbeginevent(#"");

  if(!isDefined(vdir)) {
    idflags |= 4;
  }

  friendly = 0;

  if(self.health != self.maxhealth && !self util::function_a1d6293()) {
    self notify(#"hash_3ac4241a987b394f", {
      #mod: smeansofdeath
    });
  }

  if(isDefined(einflictor) && isDefined(einflictor.script_noteworthy)) {
    if(einflictor.script_noteworthy == "ragdoll_now") {
      smeansofdeath = "MOD_FALLING";
    }

    if(isDefined(level.overrideweaponfunc)) {
      weapon = [[level.overrideweaponfunc]](weapon, einflictor.script_noteworthy);
    }
  }

  if(weapons::isheadshot(weapon, shitloc, smeansofdeath) && isPlayer(eattacker)) {
    smeansofdeath = "MOD_HEAD_SHOT";
  }

  if(level.onplayerdamage != &globallogic::blank) {
    modifieddamage = [[level.onplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);

    if(isDefined(modifieddamage)) {
      if(modifieddamage <= 0) {
        pixendevent();
        return;
      }

      idamage = modifieddamage;
    }
  }

  if(level.onlyheadshots) {
    if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
      pixendevent();
      return;
    } else if(smeansofdeath == "MOD_HEAD_SHOT") {
      idamage = 150;
    }
  }

  if(self player_is_occupant_invulnerable(smeansofdeath)) {
    pixendevent();
    return;
  }

  same_team = isDefined(eattacker) && (self.team === eattacker.team || util::function_9b7092ef(self.team, eattacker.team));

  if(isDefined(eattacker) && isPlayer(eattacker) && !same_team) {
    self.lastattackweapon = weapon;
  }

  weapon = function_601cae2a(weapon, einflictor);
  pixendevent();

  if(isDefined(eattacker) && isai(eattacker)) {
    if(self.team == eattacker.team && smeansofdeath == "MOD_MELEE") {
      return;
    }
  }

  attackerishittingteammate = isPlayer(eattacker) && self util::isenemyplayer(eattacker) == 0;

  if(shitloc == "riotshield") {
    if(attackerishittingteammate && level.friendlyfire == 0) {
      return;
    }

    if((smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") && !attackerishittingteammate) {
      if(self.hasriotshieldequipped) {
        if(isPlayer(eattacker)) {
          eattacker.lastattackedshieldplayer = self;
          eattacker.lastattackedshieldtime = gettime();
        }

        previous_shield_damage = self.shielddamageblocked;
        self.shielddamageblocked += idamage;

        if(self.shielddamageblocked % 400 < previous_shield_damage % 400) {
          score_event = "shield_blocked_damage";

          if(self.shielddamageblocked > 2000) {
            score_event = "shield_blocked_damage_reduced";
          }

          score = rank::getscoreinfovalue(score_event);

          if(score > 0) {
            self stats::function_e24eec31(level.weaponriotshield, #"score_from_blocked_damage", score);
          }
        }
      }
    }

    if(idflags & 32) {
      shitloc = "none";

      if(!(idflags & 64)) {
        idamage *= 0;
      }
    } else if(idflags & 128) {
      if(isDefined(einflictor) && isDefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self) {
        idamage = 101;
      }

      shitloc = "none";
    } else {
      return;
    }
  }

  if(function_c2a2b500(self, vdir, smeansofdeath)) {
    self notify(#"body_shield_damage", params);
    self.var_c3d9d4c9 = 1;
    blockeddamage = 1;
    idamage = 0;
  }

  if(idamage > 0) {
    var_d020b056 = undefined;

    if(isDefined(einflictor) && isactor(einflictor)) {
      var_d020b056 = einflictor getfiremode();
    }

    self thread gamedifficulty::function_fef4c10f(gamedifficulty::function_52f56aea(var_d020b056));
  }

  if(!(idflags & 8192)) {
    if(isDefined(einflictor) && (smeansofdeath == "MOD_GAS" || weapons::isexplosivedamage(smeansofdeath))) {
      if((einflictor.classname == "grenade" || weaponname == "tabun_gas") && isDefined(self.lastspawnpoint) && self.lastspawntime + 3500 > gettime() && distancesquared(einflictor.origin, self.lastspawnpoint.origin) < 62500) {
        return;
      }

      if(self function_4b298d1f(eattacker, weapon)) {
        return;
      }

      self.explosiveinfo = [];
      self.explosiveinfo[#"damagetime"] = gettime();
      self.explosiveinfo[#"damageid"] = einflictor getentitynumber();
      self.explosiveinfo[#"originalownerkill"] = 0;
      self.explosiveinfo[#"bulletpenetrationkill"] = 0;
      self.explosiveinfo[#"chainkill"] = 0;
      self.explosiveinfo[#"damageexplosivekill"] = 0;
      self.explosiveinfo[#"chainkill"] = 0;
      self.explosiveinfo[#"cookedkill"] = 0;
      self.explosiveinfo[#"weapon"] = weapon;
      self.explosiveinfo[#"originalowner"] = einflictor.originalowner;
      isfrag = weaponname == "frag_grenade";

      if(isDefined(eattacker) && eattacker != self) {
        if(isDefined(eattacker) && isDefined(einflictor.owner) && (weapon.name == # "satchel_charge" || weapon.name == # "claymore" || weapon.name == # "bouncingbetty")) {
          self.explosiveinfo[#"originalownerkill"] = einflictor.owner == self;
          self.explosiveinfo[#"damageexplosivekill"] = isDefined(einflictor.wasdamaged);
          self.explosiveinfo[#"chainkill"] = isDefined(einflictor.waschained);
          self.explosiveinfo[#"wasjustplanted"] = isDefined(einflictor.wasjustplanted);
          self.explosiveinfo[#"bulletpenetrationkill"] = isDefined(einflictor.wasdamagedfrombulletpenetration);
          self.explosiveinfo[#"cookedkill"] = 0;
        }

        if(isDefined(einflictor) && isDefined(einflictor.stucktoplayer) && weapon.projexplosiontype == "grenade") {
          self.explosiveinfo[#"stucktoplayer"] = einflictor.stucktoplayer;
        }

        if(weapon.isstun) {
          self.laststunnedby = eattacker;
          self.laststunnedtime = self.idflagstime;
        }

        if(isDefined(eattacker.lastgrenadesuicidetime) && eattacker.lastgrenadesuicidetime >= gettime() - 50 && isfrag) {
          self.explosiveinfo[#"suicidegrenadekill"] = 1;
        } else {
          self.explosiveinfo[#"suicidegrenadekill"] = 0;
        }
      }

      if(isfrag) {
        self.explosiveinfo[#"cookedkill"] = isDefined(einflictor.iscooked);
        self.explosiveinfo[#"throwbackkill"] = isDefined(einflictor.throwback);
      }
    }

    if(smeansofdeath == "MOD_IMPACT" && isDefined(eattacker) && isPlayer(eattacker) && eattacker != self) {
      if(weapon.name == # "hatchet" && isDefined(einflictor)) {
        self.explosiveinfo[#"projectile_bounced"] = isDefined(einflictor.bounced);
      }
    }

    if(isPlayer(eattacker)) {
      eattacker.pers[#"participation"]++;
    }

    prevhealthratio = self.health / self.maxhealth;

    if(idamage >= self.health && isDefined(eattacker) && eattacker != self && !same_team && !isPlayer(eattacker)) {
      if(array::contains(level.var_fd81f309, smeansofdeath) && self gamedifficulty::function_7dbe6a66()) {
        var_1e4afbfd = (idamage - self.health) * gamedifficulty::function_eb59c79() / 100;

        if(!self function_883dd64(var_1e4afbfd)) {
          self gamedifficulty::function_2339ca92();
          self clientfield::set_to_player("player_death_shield", 1);
          self thread function_d7f8c1b3();
          self setnormalhealth(2 / self.maxhealth);
          idamage = 1;
        }
      }
    }

    if(weapon.parentweaponname === "riotshield" && self != eattacker && !same_team) {
      earthquake(0.25, 0.1, self.origin, 16, self);
    }

    if(level.teambased && issentient(eattacker) && self != eattacker && same_team) {
      pixmarker("BEGIN: PlayerDamage player");

      if(level.friendlyfire == 0) {
        if(weapon.forcedamageshellshockandrumble) {
          self damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage);
        }

        return;
      } else if(level.friendlyfire == 1) {
        if(idamage < 1) {
          idamage = 1;
        }

        if(level.friendlyfiredelay && level.friendlyfiredelaytime >= (gettime() - level.starttime - level.discardtime) / 1000) {
          eattacker.lastdamagewasfromenemy = 0;
          eattacker.friendlydamage = 1;
          eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
          eattacker.friendlydamage = undefined;
        } else {
          self.lastdamagewasfromenemy = 0;
          self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
        }
      } else if(level.friendlyfire == 2 && isalive(eattacker)) {
        idamage = int(idamage * 0.5);

        if(idamage < 1) {
          idamage = 1;
        }

        eattacker.lastdamagewasfromenemy = 0;
        eattacker.friendlydamage = 1;
        eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
        eattacker.friendlydamage = undefined;
      } else if(level.friendlyfire == 3 && isalive(eattacker)) {
        idamage = int(idamage * 0.5);

        if(idamage < 1) {
          idamage = 1;
        }

        self.lastdamagewasfromenemy = 0;
        eattacker.lastdamagewasfromenemy = 0;
        self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
        eattacker.friendlydamage = 1;
        eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
        eattacker.friendlydamage = undefined;
      }

      friendly = 1;
      pixmarker("END: PlayerDamage player");
    } else {
      if(idamage < 1 && !is_true(blockeddamage) && !self flag::get("player_is_invulnerable")) {
        idamage = 1;
      }

      giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);

      if(isDefined(eattacker)) {
        level.lastlegitimateattacker = eattacker;
      }

      if((smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH") && isDefined(einflictor) && isDefined(einflictor.iscooked)) {
        self.wascooked = gettime();
      } else {
        self.wascooked = undefined;
      }

      self.lastdamagewasfromenemy = isDefined(eattacker) && eattacker != self;

      if(self.lastdamagewasfromenemy) {
        if(isPlayer(eattacker)) {
          if(isDefined(eattacker.damagedplayers[self.clientid]) == 0) {
            eattacker.damagedplayers[self.clientid] = spawnStruct();
          }

          eattacker.damagedplayers[self.clientid].time = gettime();
          eattacker.damagedplayers[self.clientid].entity = self;
        }
      }

      if(is_true(blockeddamage)) {
        self clientfield::set_to_player("player_damage_type", 1);
        self addtodamageindicator(50, vdir);
      } else {
        self clientfield::set_to_player("player_damage_type", 0);
        self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
      }
    }

    if(isDefined(eattacker) && isPlayer(eattacker) && eattacker != self) {
      if(damagefeedback::dodamagefeedback(weapon, einflictor, idamage, smeansofdeath)) {
        if(idamage > 0) {
          if(self.health > 0) {
            perkfeedback = function_decf3cb1(self, weapon, smeansofdeath, einflictor);
          }

          eattacker thread damagefeedback::update(smeansofdeath, einflictor, perkfeedback, weapon, self, psoffsettime, shitloc);
        }
      }
    }

    self.hasdonecombat = 1;
  } else {
    idamage = unmodified;
    self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
  }

  time = gettime();
  regen_gadget = getweapon(#"gadget_health_regen");
  slot = self gadgetgetslot(regen_gadget);

  if(!isbot(self) && !self function_8bc54983() && !self scene::is_igc_active() && !self isplayinganimscripted() && !self isinvehicle() && isDefined(slot) && self gadgetisready(slot) && self.health - idamage <= 50 && (!isDefined(self.var_17a87fa6) || time >= self.var_17a87fa6 + 15000) && (!isDefined(self.var_40bbb505) || self.var_40bbb505 < 3)) {
    self.var_17a87fa6 = time;

    if(!isDefined(self.var_40bbb505)) {
      self.var_40bbb505 = 0;
    }

    self.var_40bbb505 += 1;
    self thread util::show_hint_text(#"hash_2ad0f26e2ff481b7", 0, "healing_preamble");
  }

  pixbeginevent(#"");

  if(getdvarint(#"g_debugdamage", 0)) {
    if(isDefined(eattacker.clientid)) {
      println("<dev string:x16f>" + self getentitynumber() + "<dev string:x17a>" + self.health + "<dev string:x186>" + eattacker.clientid + "<dev string:x194>" + isPlayer(einflictor) + "<dev string:x1ad>" + idamage + "<dev string:x1b9>" + shitloc);
    } else if(isDefined(eattacker)) {
      println("<dev string:x16f>" + self getentitynumber() + "<dev string:x17a>" + self.health + "<dev string:x186>" + eattacker getentitynumber() + "<dev string:x194>" + isPlayer(einflictor) + "<dev string:x1ad>" + idamage + "<dev string:x1b9>" + shitloc);
    }

    loc = anglesToForward(self getplayerangles()) * 128;
    color = (1, 1, 0);
    dur = 15;
    height = (0, 0, 16);

    if(idamage >= 100) {
      dur = 40;
      color = (1, 0, 0);
      height = (0, 0, 32);
    } else if(idamage < 20) {
      dur = 8;
      height = (0, 0, 0);
      color = (0, 0, 1);
    }

    loc += self getorigin() + height;
    print3d(loc, "<dev string:x7f>" + idamage, color, 1, 0.5, dur, 1);

    if(isDefined(eattacker.origin)) {
      print3d(eattacker.origin + (0, 0, 72), "<dev string:x7f>" + idamage, color, 1, 1, dur, 1);
      line(eattacker.origin + (0, 0, 72), loc, color, 1, 0, dur);
    }
  }

  if(self.sessionstate != "dead") {
    lpselfnum = self getentitynumber();
    lpselfname = self.name;
    lpselfteam = self.team;
    lpselfguid = self getguid();
    lpattackerteam = "";
    var_5a02d414 = 0;

    if(isPlayer(eattacker)) {
      lpattacknum = eattacker getentitynumber();
      var_c8fa9c41 = eattacker getxuid();
      lpattackguid = eattacker getguid();
      lpattackname = eattacker.name;
      lpattackerteam = eattacker.team;
    } else {
      var_74b485a4 = "world";
      lpattackerteam = "world";
      lpattacknum = -1;
      var_c8fa9c41 = 0;
      lpattackguid = "";
      lpattackname = "";
    }

    bb::logdamage(eattacker, self, weapon, idamage, smeansofdeath, shitloc, 0, var_5a02d414);
  }

  pixendevent();
  profilelog_endtiming(6, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame());
}

function function_d7f8c1b3() {
  self notify("6828fb1dcef780d1");
  self endon("6828fb1dcef780d1");
  waitframe(1);
  self clientfield::set_to_player("player_death_shield", 0);
}

function function_8b3485() {
  self notify("4552894c407ee0ee");
  self endon("4552894c407ee0ee");
  waitframe(1);
  self clientfield::set_to_player("player_death_gesture", 0);
}

function function_883dd64(idamage) {
  var_e561f9d9 = gamedifficulty::function_f4052850();

  if(idamage / 100 < var_e561f9d9) {
    return false;
  }

  return true;
}

function player_is_occupant_invulnerable(smeansofdeath) {
  if(self isremotecontrolling()) {
    return 0;
  }

  if(!isDefined(level.vehicle_drivers_are_invulnerable)) {
    level.vehicle_drivers_are_invulnerable = 0;
  }

  invulnerable = level.vehicle_drivers_are_invulnerable && self vehicle::player_is_driver();
  return invulnerable;
}

function function_decf3cb1(player, weapon, smeansofdeath, einflictor) {
  perkfeedback = undefined;
  var_88c673cf = loadout::function_88c673cf(player);
  hasflakjacket = player hasperk(#"specialty_flakjacket");
  isexplosivedamage = weapons::isexplosivedamage(smeansofdeath);
  isflashorstundamage = weapons::isflashorstundamage(weapon, smeansofdeath);

  if(isflashorstundamage && var_88c673cf) {
    perkfeedback = "tacticalMask";
  } else if(isexplosivedamage && hasflakjacket && !weapon.ignoresflakjacket && !isaikillstreakdamage(weapon, einflictor)) {
    perkfeedback = "flakjacket";
  }

  return perkfeedback;
}

function isaikillstreakdamage(weapon, einflictor) {
  if(weapon.isaikillstreakdamage) {
    if(weapon.name != "ai_tank_drone_rocket" || isDefined(einflictor.firedbyai)) {
      return true;
    }
  }

  return false;
}

function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
  pixbeginevent(#"");

  if(!level.console && idflags & 8 && isPlayer(eattacker)) {
    println("<dev string:x1c5>" + self getentitynumber() + "<dev string:x17a>" + self.health + "<dev string:x186>" + eattacker.clientid + "<dev string:x194>" + isPlayer(einflictor) + "<dev string:x1ad>" + idamage + "<dev string:x1b9>" + shitloc);
    eattacker stats::function_dad108fa(#"penetration_shots", 1);
  }

  if(!self util::function_a1d6293()) {
    if(getdvarstring(#"scr_csmode") != "") {
      self shellshock(#"damage_mp", 0.2);
    }

    self damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage);
    self ability_power::power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
  }

  if(function_6f08b381(idamage, smeansofdeath)) {
    params = {
      #einflictor: einflictor, #eattacker: eattacker, #idamage: idamage, #idflags: idflags, #smeansofdeath: smeansofdeath, #weapon: weapon, #var_fd90b0bb: var_fd90b0bb, #vpoint: vpoint, #vdir: vdir, #shitloc: shitloc, #vdamageorigin: vdamageorigin, #psoffsettime: psoffsettime, #boneindex: boneindex, #vsurfacenormal: vsurfacenormal
    };
    self thread function_7abbea8e(params);
  } else {
    self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
  }

  pixendevent();
}

function function_6f08b381(idamage, smeansofdeath) {
  player = self;

  if(self.health - idamage > 0) {
    return 0;
  }

  if(isgodmode(player)) {
    return 0;
  }

  if(isDefined(player.allowdeath) && !player.allowdeath) {
    return 0;
  }

  if(!is_true(level.var_841888e0)) {
    return 0;
  }

  if(player util::function_a1d6293()) {
    return 0;
  }

  if(!player flag::get("death_gesture_skip_mod_check")) {
    if(!isinarray(level.var_1befd357, smeansofdeath)) {
      return 0;
    }
  }

  player flag::clear("death_gesture_skip_mod_check");

  if(isDefined(player getlinkedent()) || player isinvehicle() || isDefined(player.ascender)) {
    return 0;
  }

  if(player isonladder()) {
    return 0;
  }

  if(player getstance() == "prone") {
    return 1;
  }

  return player function_39ab832f();
}

function private function_39ab832f(debugdraw) {
  player = self;
  player.var_d11f7daf = 0;
  var_d3eb1bf1 = [0, 90, -90];

  if(math::cointoss()) {
    var_d3eb1bf1 = [0, -90, 90];
  }

  for(i = 0; i < var_d3eb1bf1.size; i++) {
    if(player function_bb371c3(var_d3eb1bf1[i], debugdraw)) {
      player.var_d11f7daf = var_d3eb1bf1[i];
      return true;
    }
  }

  return false;
}

function private function_bb371c3(var_b1630ef, debugdraw) {
  player = self;
  angleoffset = (0, isDefined(var_b1630ef) ? var_b1630ef : 0, 0);
  playeraxis = anglestoaxis(player.angles + angleoffset);
  var_6ee16314 = 16;
  var_2ae934a0 = 12;
  var_c440a44e = 1;
  var_fd0c9f1c = player.origin + playeraxis.up * 32;
  var_6e0e1c32 = var_fd0c9f1c + playeraxis.forward * var_6ee16314;
  var_68e0f9e9 = (var_2ae934a0 * -1, var_2ae934a0 * -1, var_2ae934a0 * -1);
  var_4da0b949 = (var_2ae934a0, var_2ae934a0, var_2ae934a0);
  var_6c3bd059 = physicstrace(var_fd0c9f1c, var_6e0e1c32, var_68e0f9e9, var_4da0b949, player, 32);

  if(is_true(var_6c3bd059[#"startsolid"]) || var_6c3bd059[#"fraction"] < 0.9) {
    var_c440a44e = 0;
  }

  if(!var_c440a44e) {
    if(is_true(debugdraw)) {
      cylinder(var_fd0c9f1c, var_6e0e1c32, var_68e0f9e9[0], (1, 0, 0), 1, 400);
    }

    return 0;
  }

  var_f3002d70 = 1;
  var_c8e0e024 = (var_2ae934a0 * -1, var_2ae934a0 * -1, -0.1);
  var_288b287b = (var_2ae934a0, var_2ae934a0, 0.1);
  var_fe488304 = player.origin + playeraxis.forward * var_6ee16314;
  startoffset = (0, 0, 5);
  endoffset = (0, 0, -8);
  var_891e5be8 = physicstrace(var_fe488304 + startoffset, var_fe488304 + endoffset, var_c8e0e024, var_288b287b, player, 32);

  if(is_true(var_891e5be8[#"startsolid"]) || var_891e5be8[#"fraction"] > 0.9 || var_891e5be8[#"fraction"] < 0.1) {
    var_f3002d70 = 0;
  }

  if(is_true(debugdraw)) {
    var_1c1cfbe7 = (var_c8e0e024[0], var_c8e0e024[1], endoffset[2]);
    var_d42e62c7 = (var_288b287b[0], var_288b287b[1], startoffset[2]);
    var_974e8d59 = (0, 1, 0);

    if(!var_f3002d70) {
      var_974e8d59 = (1, 0, 0);
    }

    box(var_fe488304, var_1c1cfbe7, var_d42e62c7, 0, var_974e8d59, 1, 1, 400);
    var_f7a96b34 = [var_fe488304 + (var_c8e0e024[0], var_c8e0e024[1], 0), var_fe488304 + (var_288b287b[0], var_c8e0e024[1], 0), var_fe488304 + (var_c8e0e024[0], var_288b287b[1], 0), var_fe488304 + (var_288b287b[0], var_288b287b[1], 0)];

    foreach(corner in var_f7a96b34) {
      line(corner, corner + (0, 0, 99), var_974e8d59, 1, 1, 400);
    }
  }

  return var_f3002d70;
}

function private function_7abbea8e(params) {
  player = self;
  player endon(#"disconnect");
  var_5d3a3f89 = 0;

  var_5d3a3f89 = isDefined(params.var_3ca8c1dc);

  if(!var_5d3a3f89) {
    assert(player.health <= params.idamage);
  }

  assert(!player util::function_a1d6293());
  audio::on_player_killed();
  healthoverlay::end_health_regen();
  player callback::callback(#"hash_2fea1d218f4c6a1f", params);
  player util::function_e05fc3fb(1);
  player clientfield::set_to_player("player_death_gesture", 1);
  player actions::function_202ab848(0);
  player thread function_8b3485();

  if(!var_5d3a3f89) {
    player val::set(#"hash_38a6778d2daddc56", "allowdeath", 0);
    player finishplayerdamage(params.einflictor, params.eattacker, params.idamage, params.idflags, params.smeansofdeath, params.weapon, params.var_fd90b0bb, params.vpoint, params.vdir, params.shitloc, params.vdamageorigin, params.psoffsettime, params.boneindex, params.vsurfacenormal);
  }

  player val::set(#"hash_38a6778d2daddc56", "takedamage", 0);
  player val::set(#"hash_38a6778d2daddc56", "hide", 2);
  player val::set(#"hash_38a6778d2daddc56", "freezecontrols", 1);
  player val::set(#"hash_38a6778d2daddc56", "show_crosshair", 0);
  player namespace_61e6d095::function_28027c42(#"death_gesture");
  gesture = player function_39727d8d();

  if(isDefined(params.var_3ca8c1dc)) {
    if(params.var_3ca8c1dc == "<dev string:x7f>") {
      iprintlnbold("<dev string:x1d4>" + gesture + "<dev string:x1ef>");
    } else {
      gesture = params.var_3ca8c1dc;
      iprintlnbold("<dev string:x1f4>" + gesture);
    }
  }

  var_463ffce7 = player getgestureanimlength(gesture);
  player childthread function_d2b1e36d(var_463ffce7);

  if(!var_5d3a3f89) {
    var_ba99925e = max(var_463ffce7 - 0.15, 0.1);
    level thread lui::screen_fade(var_ba99925e, 1, 0, "black", 0);
  }

  player playgestureviewmodel(gesture, undefined, 1, undefined, undefined, undefined, 1, 1);
  wait var_463ffce7;
  player namespace_61e6d095::function_4279fd02(#"death_gesture");
  player val::reset_all(#"hash_38a6778d2daddc56");

  if(!var_5d3a3f89) {
    player.allowdeath = 1;
    player kill(undefined, undefined, undefined, undefined, 4 | 16384 | 8192 | 32768);
  }
}

function private function_39727d8d() {
  player = self;
  assert(isDefined(level.var_ee4d094a));
  currentweaponname = player getcurrentweapon().name;
  var_f0fdc6f6 = level.var_ee4d094a[currentweaponname];

  if(!isDefined(var_f0fdc6f6)) {
    var_f0fdc6f6 = level.var_ee4d094a[#"hash_3a5790d783810d4a"];
  }

  currentstance = player getstance();
  var_c8299c32 = var_f0fdc6f6[currentstance];
  assert(isDefined(var_c8299c32));
  return array::random(var_c8299c32);
}

function private function_d2b1e36d(var_463ffce7) {
  player = self;
  targetpitch = 0;
  yawoffset = isDefined(player.var_d11f7daf) ? player.var_d11f7daf : 0;
  pitch = abs(angleclamp180(player getplayerangles()[0]));

  if(pitch != targetpitch || yawoffset != 0) {
    max_duration = max(var_463ffce7 - 0.15, 0.1);
    prep = util::spawn_model("tag_origin", player.origin, player.angles + (0, yawoffset, 0));
    duration = max(pitch / 180, abs(yawoffset) / 180);
    duration = min(duration, max_duration);
    player playerlinktoblend(prep, "tag_origin", duration, duration * 0.5, duration * 0.5);
    wait duration + float(function_60d95f53()) / 1000;
    player unlink();
    player val::reset(#"hash_38a6778d2daddc56", "freezecontrols");
    player val::set(#"hash_38a6778d2daddc56", "freezecontrols", 1);
    prep delete();
  }
}

function function_c90195f7(attacker, weapon) {}

function function_4e570d77(attacker, weapon, smeansofdeath, wasinlaststand, var_31498810, inflictor) {
  if(isPlayer(attacker) && attacker != self && (!level.teambased || level.teambased && self.team != attacker.team)) {
    self stats::function_e24eec31(weapon, #"deaths", 1);

    if(wasinlaststand && isDefined(var_31498810)) {
      victim_weapon = var_31498810;
    } else {
      victim_weapon = self.lastdroppableweapon;
    }

    if(isDefined(victim_weapon)) {
      self stats::function_e24eec31(victim_weapon, #"deathsduringuse", 1);
    }

    if(smeansofdeath != "MOD_FALLING") {
      if(weapon.name == # "explosive_bolt" && isDefined(inflictor) && isDefined(inflictor.ownerweaponatlaunch) && inflictor.owneradsatlaunch) {
        attacker stats::function_eec52333(inflictor.ownerweaponatlaunch, #"kills", 1, attacker.class_num, 0, 1);
      } else {
        attacker stats::function_eec52333(weapon, #"kills", 1, attacker.class_num);
      }
    }

    if(smeansofdeath == "MOD_HEAD_SHOT") {
      attacker stats::function_e24eec31(weapon, #"headshots", 1);
    }

    if(smeansofdeath == "MOD_PROJECTILE") {
      attacker stats::function_e24eec31(weapon, #"direct_hit_kills", 1);
    }
  }
}

function function_387cd7fb(attacker, einflictor, weapon, smeansofdeath) {
  if(!isPlayer(attacker) || self util::isenemyplayer(attacker) == 0) {
    level notify(#"reset_obituary_count");
    level.lastobituaryplayercount = 0;
    level.lastobituaryplayer = undefined;
  } else {
    if(isDefined(level.lastobituaryplayer) && level.lastobituaryplayer == attacker) {
      level.lastobituaryplayercount++;
    } else {
      level notify(#"reset_obituary_count");
      level.lastobituaryplayer = attacker;
      level.lastobituaryplayercount = 1;
    }

    if(level.lastobituaryplayercount >= 4) {
      level notify(#"reset_obituary_count");
      level.lastobituaryplayercount = 0;
      level.lastobituaryplayer = undefined;
    }
  }

  if(level.teambased && isDefined(attacker.pers) && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {
    if(isPlayer(attacker) && level.gametype === "pvp") {
      obituary(self, self, weapon, smeansofdeath);
    }

    demo::kill_bookmark(self, self, einflictor);
    return;
  }

  if(isPlayer(attacker) && level.gametype === "pvp") {
    obituary(self, attacker, weapon, smeansofdeath);
  }

  demo::kill_bookmark(self, attacker, einflictor);
}

function function_f520d796(einflictor, attacker, smeansofdeath, weapon, shitloc) {
  awardassists = 0;

  if(weapon == "MOD_SUICIDE" && shitloc == "none" && self.throwinggrenade) {
    self.lastgrenadesuicidetime = gettime();
  }

  if(level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
    self notify(#"teamkillkicked");
    self function_a34ff774();
  }

  awardassists = 1;
  self.suicide = 1;

  if(isDefined(self.friendlydamage)) {
    self iprintln(#"mp/friendly_fire_will_not");
  }

  return awardassists;
}

function wait_and_suicide() {
  self endon(#"disconnect");
  self val::set(#"suicide", "freezecontrols", 1);
  wait 0.25;
  self suicide();
}

function function_2a11f244(einflictor, attacker, smeansofdeath, weapon, shitloc) {
  if(isalive(smeansofdeath)) {
    pixbeginevent(#"");

    if(!isDefined(attacker) || !isDefined(attacker.requireddeathcount) || smeansofdeath.deathcount == attacker.requireddeathcount) {
      smeansofdeath.pers[#"cur_total_kill_streak"]++;
      smeansofdeath setplayercurrentstreak(smeansofdeath.pers[#"cur_total_kill_streak"]);

      if(isDefined(level.killstreaks)) {
        smeansofdeath.pers[#"cur_kill_streak"]++;

        if(smeansofdeath.pers[#"cur_kill_streak"] >= 2) {
          if(smeansofdeath.pers[#"cur_kill_streak"] % 5 == 0) {
            smeansofdeath activecamo::function_896ac347(shitloc, "killstreak_5", 1);
          }

          if(smeansofdeath.pers[#"cur_kill_streak"] == 10) {
            smeansofdeath challenges::killstreakten();
          }
        }
      }
    }

    pixendevent();
  }

  if(smeansofdeath.pers[#"cur_kill_streak"] > smeansofdeath.kill_streak) {
    if(level.rankedmatch && !level.disablestattracking) {
      smeansofdeath stats::set_stat(#"higheststats", #"kill_streak", smeansofdeath.pers[#"totalkillstreakcount"]);
    }

    smeansofdeath.kill_streak = smeansofdeath.pers[#"cur_kill_streak"];
  }

  if(smeansofdeath.pers[#"cur_kill_streak"] > smeansofdeath.gametype_kill_streak) {
    smeansofdeath stats::function_baa25a23(#"kill_streak", smeansofdeath.pers[#"cur_kill_streak"]);
    smeansofdeath.gametype_kill_streak = smeansofdeath.pers[#"cur_kill_streak"];
  }

  if(weapon == "MOD_HEAD_SHOT") {} else if(weapon == "MOD_MELEE" || weapon == "MOD_MELEE_ASSASSINATE") {
    if(shitloc.isriotshield) {
      if(isDefined(smeansofdeath.class_num)) {
        var_6fa230fd = smeansofdeath getloadoutitem(smeansofdeath.class_num, "primary");
        var_1997cb6f = smeansofdeath getloadoutitem(smeansofdeath.class_num, "secondary");

        if(var_6fa230fd && level.tbl_weaponids[var_6fa230fd][#"reference"] == "riotshield" && !var_1997cb6f || var_1997cb6f && level.tbl_weaponids[var_1997cb6f][#"reference"] == "riotshield" && !var_6fa230fd) {
          smeansofdeath stats::function_e24eec31(shitloc, #"hash_63e17b42eb7cb8f5", 1);
        }
      }
    }
  }

  attackername = smeansofdeath.name;
  self thread medals::setlastkilledby(smeansofdeath, attacker);
}

function callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc, psoffsettime, deathanimduration) {
  profilelog_begintiming(7, "ship");
  self endon(#"spawned");
  self notify(#"killed_player");
  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = attacker;
  params.idamage = idamage;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.var_fd90b0bb = var_fd90b0bb;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.psoffsettime = psoffsettime;
  params.deathanimduration = deathanimduration;
  self callback::callback(#"on_player_killed", params);

  if(!self util::function_a1d6293()) {
    self callback::callback(#"hash_2fea1d218f4c6a1f", params);
  }

  self flag::clear(#"loadout_given");

  if(self.sessionteam == "spectator") {
    return;
  }

  if(game.state == "postgame") {
    return;
  }

  self needsrevive(0);

  if(isDefined(self.revivetrigger)) {
    self.revivetrigger delete();
  }

  self.revivetrigger = undefined;

  if(isDefined(self.burning) && self.burning == 1) {
    self setburn(0);
  }

  self.canbemeleed = 1;
  self.suicide = 0;
  self.teamkilled = 0;
  self.meleeattackers = undefined;

  if(isDefined(level.takelivesondeath) && level.takelivesondeath == 1) {
    if(self.pers[#"lives"]) {
      self.pers[#"lives"]--;

      if(self.pers[#"lives"] == 0) {
        level notify(#"player_eliminated");
        self notify(#"player_eliminated");
      }
    }
  }

  weapon = updateweapon(einflictor, weapon);
  pixbeginevent(#"");
  wasinlaststand = 0;
  deathtimeoffset = 0;
  var_31498810 = undefined;
  attackerstance = undefined;
  self.laststandthislife = undefined;
  self.vattackerorigin = undefined;

  if(isDefined(self.uselaststandparams)) {
    self.uselaststandparams = undefined;
    assert(isDefined(self.laststandparams));

    if(!level.teambased || isDefined(self.laststandparams) && (!isDefined(attacker) || !isPlayer(attacker) || attacker.team != self.team || attacker == self)) {
      einflictor = self.laststandparams.einflictor;
      attacker = self.laststandparams.attacker;
      attackerstance = self.laststandparams.attackerstance;
      idamage = self.laststandparams.idamage;
      smeansofdeath = self.laststandparams.smeansofdeath;
      weapon = self.laststandparams.weapon;
      var_fd90b0bb = self.laststandparams.var_fd90b0bb;
      vdir = self.laststandparams.vdir;
      shitloc = self.laststandparams.shitloc;
      self.vattackerorigin = self.laststandparams.vattackerorigin;
      deathtimeoffset = (gettime() - self.laststandparams.laststandstarttime) / 1000;
      self.bleedout_time = math::clamp(self.var_84c0402e - deathtimeoffset, 0, self.var_84c0402e);

      if(isDefined(self.var_f68bf742)) {
        wasinlaststand = 1;
        var_31498810 = self.var_f68bf742;
      }

      params.einflictor = einflictor;
      params.eattacker = attacker;
      params.idamage = idamage;
      params.smeansofdeath = smeansofdeath;
      params.weapon = weapon;
      params.var_fd90b0bb = var_fd90b0bb;
      params.vdir = vdir;
      params.shitloc = shitloc;
      self callback::callback(#"on_player_killed", params);
    }

    self.laststandparams = undefined;
  }

  bestplayer = undefined;
  bestplayermeansofdeath = undefined;
  obituarymeansofdeath = undefined;
  bestplayerweapon = undefined;
  obituaryweapon = weapon;
  assistedsuicide = 0;

  if((!isDefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || isDefined(attacker.ismagicbullet) && attacker.ismagicbullet == 1 || attacker == self) && isDefined(self.attackers)) {
    if(!isDefined(bestplayer)) {
      for(i = 0; i < self.attackers.size; i++) {
        player = self.attackers[i];

        if(!isDefined(player)) {
          continue;
        }

        if(!isDefined(self.attackerdamage[player.clientid]) || !isDefined(self.attackerdamage[player.clientid].damage)) {
          continue;
        }

        if(player == self || level.teambased && player.team == self.team) {
          continue;
        }

        if(self.attackerdamage[player.clientid].lasttimedamaged + 2500 < gettime()) {
          continue;
        }

        if(!allowedassistweapon(self.attackerdamage[player.clientid].weapon)) {
          continue;
        }

        if(self.attackerdamage[player.clientid].damage > 1 && !isDefined(bestplayer)) {
          bestplayer = player;
          bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
          bestplayerweapon = self.attackerdamage[player.clientid].weapon;
          continue;
        }

        if(isDefined(bestplayer) && self.attackerdamage[player.clientid].damage > self.attackerdamage[bestplayer.clientid].damage) {
          bestplayer = player;
          bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
          bestplayerweapon = self.attackerdamage[player.clientid].weapon;
        }
      }
    }

    if(isDefined(bestplayer)) {
      assistedsuicide = 1;
    }
  }

  if(isDefined(bestplayer)) {
    attacker = bestplayer;
    obituarymeansofdeath = bestplayermeansofdeath;
    obituaryweapon = bestplayerweapon;

    if(isDefined(bestplayerweapon)) {
      weapon = bestplayerweapon;
    }
  }

  if(isPlayer(attacker)) {
    attacker.damagedplayers[self.clientid] = undefined;
  }

  self.deathtime = gettime();
  self.pers[#"deathtime"] = self.deathtime;
  attacker = function_ff093620(attacker, weapon);
  einflictor = function_f67af024(einflictor);
  smeansofdeath = self function_eedaefc(attacker, einflictor, weapon, smeansofdeath, shitloc);

  if(!isDefined(obituarymeansofdeath)) {
    obituarymeansofdeath = smeansofdeath;
  }

  if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped == 1) {
    self.hasriotshield = 0;
    self.hasriotshieldequipped = 0;
  }

  self thread function_b709e8b8();
  self function_4e570d77(attacker, weapon, smeansofdeath, wasinlaststand, var_31498810, einflictor);
  self function_387cd7fb(attacker, einflictor, obituaryweapon, obituarymeansofdeath);
  self.sessionstate = "dead";
  self.statusicon = "hud_status_dead";
  self.pers[#"weapon"] = undefined;
  self.killedplayerscurrent = [];

  if(!isDefined(self.deathcount)) {
    self.deathcount = 0;
  }

  self.deathcount++;
  println("<dev string:x206>" + self.clientid + "<dev string:x212>" + self.deathcount);
  self function_c90195f7(attacker, weapon);
  lpselfnum = self getentitynumber();
  lpselfname = self.name;
  lpattackguid = "";
  lpattackname = "";
  lpselfteam = self.team;
  lpselfguid = self getguid();
  lpattackteam = "";
  lpattacknum = -1;
  var_c8fa9c41 = 0;
  wasteamkill = 0;
  wassuicide = 0;
  pixendevent();

  if(isPlayer(attacker)) {
    lpattackguid = attacker getguid();
    lpattackname = attacker.name;
    lpattackteam = attacker.team;

    if(attacker == self || assistedsuicide == 1) {
      dokillcam = 0;
      wassuicide = 1;
      self function_f520d796(einflictor, attacker, smeansofdeath, weapon, shitloc);
    } else {
      pixbeginevent(#"");
      lpattacknum = attacker getentitynumber();
      var_c8fa9c41 = attacker getxuid();
      dokillcam = 1;

      if(level.teambased && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {} else {
        self function_2a11f244(einflictor, attacker, smeansofdeath, weapon, shitloc);
      }

      pixendevent();
    }
  } else if(isDefined(attacker) && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")) {
    dokillcam = 0;
    lpattacknum = -1;
    var_c8fa9c41 = 0;
    lpattackguid = "";
    lpattackname = "";
    lpattackteam = "world";
    self.suicides = 0;
    self.suicide = 1;

    if(level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
      self notify(#"teamkillkicked");
      self function_a34ff774();
    }
  } else {
    dokillcam = 0;
    lpattacknum = -1;
    var_c8fa9c41 = 0;
    lpattackguid = "";
    lpattackname = "";
    lpattackteam = "world";
    wassuicide = 1;

    if(isDefined(einflictor) && isDefined(einflictor.killcament)) {
      lpattacknum = self getentitynumber();
      var_c8fa9c41 = self getxuid();
      wassuicide = 0;
    }

    if(isDefined(attacker) && isDefined(attacker.team) && isDefined(level.teams[attacker.team])) {
      if(attacker.team != self.team) {
        wassuicide = 0;
      }
    }

    if(isai(attacker)) {
      dokillcam = 1;
      lpattacknum = self getentitynumber();
      var_c8fa9c41 = 0;
    }
  }

  if(!level.ingraceperiod) {
    if(smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_EXPLOSIVE_SPLASH" && smeansofdeath != "MOD_PROJECTILE_SPLASH") {
      self weapons::drop_scavenger_for_death(attacker);
    }

    if(!wasteamkill && !wassuicide) {
      self weapons::drop_for_death(attacker, weapon, smeansofdeath);
    }
  }

  if(!wasteamkill && !wassuicide) {
    self weapons::drop_for_death(attacker, weapon, smeansofdeath);
  }

  pixbeginevent(#"");
  self.lastattacker = attacker;
  self.lastdeathpos = self.origin;

  if(isDefined(attacker) && isPlayer(attacker) && attacker != self && (!level.teambased || attacker.team != self.team)) {
    self thread challenges::playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance);
  } else {
    self notify(#"playerkilledchallengesprocessed");
  }

  if(isDefined(self.attackers)) {
    self.attackers = [];
  }

  bb::logdamage(attacker, self, weapon, idamage, smeansofdeath, shitloc, 1, !wasinlaststand);
  bb::function_cd497743("death", self);
  attackerstring = "none";

  if(isPlayer(attacker)) {
    attackerstring = attacker getxuid() + "(" + lpattackname + ")";
  }

  println("<dev string:x228>" + smeansofdeath + "<dev string:x22e>" + weapon.name + "<dev string:x233>" + attackerstring + "<dev string:x23b>" + idamage + "<dev string:x242>" + shitloc + "<dev string:x249>" + int(self.origin[0]) + "<dev string:x250>" + int(self.origin[1]) + "<dev string:x250>" + int(self.origin[2]));
  globallogic::updateteamstatus();
  self weapons::detach_carry_object_model();
  var_adfdd617 = 0;

  if(is_true(self.var_78ca5055)) {
    var_adfdd617 = 1;
  }

  if(isDefined(self.diedonvehicle)) {
    var_adfdd617 = self.diedonvehicle;
  }

  var_11e21728 = 0;

  if(isDefined(attacker) && isDefined(attacker.targetname) && attacker.targetname == "train") {
    var_11e21728 = 1;
  }

  pixendevent();
  var_2a8c097d = function_58385b58(self.team);
  pixbeginevent(#"");

  if(!var_adfdd617 && !var_11e21728 && (!is_true(level.var_6cc58e4b) || level.players.size > 1)) {
    vattackerorigin = undefined;

    if(isDefined(attacker)) {
      vattackerorigin = attacker.origin;
    }

    ragdoll_now = 0;

    if(isDefined(self.usingvehicle) && self.usingvehicle && isDefined(self.vehicleposition) && self.vehicleposition == 1) {
      ragdoll_now = 1;
    }

    var_d26b2156 = 0;

    if(!attacker isonground() && smeansofdeath == "MOD_MELEE_ASSASSINATE") {
      var_d26b2156 = 1;
    }

    body = self cloneplayer(deathanimduration, weapon, attacker, vdir);

    if(isDefined(body)) {
      self function_c29ad5cf(idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_now, body, var_d26b2156);
      self.var_f8271fa3 = body;

      if(var_2a8c097d.size == 0) {
        self battlechatter::play_death_vox(body, attacker, weapon, smeansofdeath);
      }
    }
  }

  pixendevent();
  thread globallogic_spawn::spawnqueuedclient(self.team, attacker);
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self thread[[level.onplayerkilled]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);

  for(var_63f2aecc = 0; var_63f2aecc < level.onplayerkilledextraunthreadedcbs.size; var_63f2aecc++) {
    self[[level.onplayerkilledextraunthreadedcbs[var_63f2aecc]]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
  }

  self.wantsafespawn = 0;
  perks = [];
  killstreaks = globallogic::getkillstreaks(attacker);

  if(!isDefined(self.var_52d662a9)) {
    self thread[[level.spawnplayerprediction]]();
  }

  profilelog_endtiming(7, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame());

  if(!is_true(level.var_6cc58e4b) || level.players.size > 1) {
    defaultplayerdeathwatchtime = 4;

    if(getdvarint(#"hash_62b8db0428755a32", 1)) {
      defaultplayerdeathwatchtime = getdvarfloat(#"defaultplayerdeathwatchtime", 2.5);
    }

    if(smeansofdeath == "MOD_MELEE_ASSASSINATE" || 0 > weapon.deathcamtime) {
      defaultplayerdeathwatchtime = deathanimduration * 0.001 + 0.5;
    } else if(0 < weapon.deathcamtime) {
      defaultplayerdeathwatchtime = weapon.deathcamtime;
    }

    if(isDefined(level.overrideplayerdeathwatchtimer)) {
      defaultplayerdeathwatchtime = [[level.overrideplayerdeathwatchtimer]](defaultplayerdeathwatchtime);
    }

    if(is_true(var_adfdd617)) {
      defaultplayerdeathwatchtime = 2;
      player_pos = self getplayercamerapos();
      var_cac40761 = self getplayerangles();

      if(isDefined(self.var_80730518)) {
        camera_pos = self.var_80730518 gettagorigin("tag_driver_camera");

        if(isDefined(camera_pos)) {
          player_pos = camera_pos;
        }

        var_cac40761 = self.var_80730518.angles;
      }

      self camerasetposition(player_pos, var_cac40761);
      self cameraactivate(1);
      self healthoverlay::function_8335b12();
      self thread lui::screen_fade_out(defaultplayerdeathwatchtime, "black");

      if(isDefined(self.var_80730518)) {
        if(is_true(self.var_80730518.var_4dba1441)) {
          wait 0.3;

          if(!isbot(self)) {
            self.var_80730518 setinvisibletoall();
            self.var_80730518 setvisibletoplayer(self);
          }
        }
      }
    }

    wait defaultplayerdeathwatchtime;

    if(is_true(var_adfdd617)) {
      self cameraactivate(0);
    }
  } else {
    if(isDefined(body)) {
      codesetclientfield(body, "hide_body", 1);
    }

    self stats::function_dad108fa(#"incaps", 1);
    var_787cae74 = self stats::get_stat(#"playerstatslist", #"incaps", #"statvalue");
    self setnoncheckpointdata("INCAPS", var_787cae74);

    if(self util::function_a1d6293()) {
      self namespace_5443b356::function_c6491fb8();
    } else if(!is_true(level.var_f5ebfda9)) {
      namespace_5443b356::function_906e8496(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    }

    self waittilltimeout(5, #"hash_eb0317ca3976bf9");
  }

  self notify(#"death_delay_finished");
  forcekillcam = 0;

  if(getdvarint(#"scr_forcekillcam", 0) != 0) {
    dokillcam = 1;
    forcekillcam = 1;

    if(lpattacknum < 0) {
      lpattacknum = self getentitynumber();
      var_c8fa9c41 = 0;
    }
  }

  self.respawntimerstarttime = gettime();

  if(is_true(self.var_e36aebf2)) {
    self waittilltimeout(5, #"hash_4bd20f5c626eb3f0");
    self.var_e36aebf2 = undefined;
    return;
  }

  if(game.state != "playing") {
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    return;
  }

  function_a6c8cee1();
  userespawntime = 1;

  if(isDefined(level.hostmigrationtimer)) {
    userespawntime = 0;
  }

  if(isDefined(level.var_5be43b2d)) {
    return;
  }

  if(globallogic_utils::isvalidclass(self.curclass)) {
    timepassed = undefined;

    if(isDefined(self.respawntimerstarttime) && userespawntime) {
      timepassed = (gettime() - self.respawntimerstarttime) / 1000;
    }

    self thread[[level.spawnclient]](timepassed);
    self.respawntimerstarttime = undefined;
  }
}

function function_b709e8b8() {
  if(isbot(self)) {
    level.globallarryskilled++;
  }
}

function function_a6c8cee1() {
  if(isDefined(self.var_52d662a9)) {
    starttime = gettime();
    waittime = self.var_52d662a9 * 1000;

    while(gettime() < starttime + waittime && isDefined(self.var_52d662a9)) {
      wait 0.1;
    }

    var_5172a3b5 = 1;
    self.var_52d662a9 = undefined;
  } else if(isDefined(self.killstreak_delay_killcam)) {
    while(isDefined(self.killstreak_delay_killcam)) {
      wait 0.1;
    }

    var_5172a3b5 = 1;
  }

  if(is_true(var_5172a3b5)) {
    wait 2;
  }
}

function function_a34ff774() {
  self endon(#"disconnect");
  waittillframeend();
  globallogic::gamehistoryplayerkicked();
  ban(self getentitynumber());
}

function function_5d8aa031() {
  self endon(#"disconnect");
  waittillframeend();
  playlistbanquantum = tweakables::gettweakablevalue("team", "teamkillerplaylistbanquantum");
  playlistbanpenalty = tweakables::gettweakablevalue("team", "teamkillerplaylistbanpenalty");

  if(playlistbanquantum > 0 && playlistbanpenalty > 0) {
    timeplayedtotal = self stats::get_stat(#"playerstatslist", #"time_played_total", #"statvalue");
    minutesplayed = timeplayedtotal / 60;
    freebees = 2;
    banallowance = int(floor(minutesplayed / playlistbanquantum)) + freebees;

    if(self.sessionbans > banallowance) {
      self stats::set_stat(#"playerstatslist", #"gametypeban", #"statvalue", timeplayedtotal + playlistbanpenalty * 60);
    }
  }

  globallogic::gamehistoryplayerkicked();
  ban(self getentitynumber());
}

function teamkilldelay() {
  teamkills = self.pers[#"teamkills_nostats"];

  if(level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills) {
    return 0;
  }

  exceeded = teamkills - level.minimumallowedteamkills;
  return level.teamkillspawndelay * exceeded;
}

function function_c725caa8(teamkilldelay) {
  if(teamkilldelay && level.minimumallowedteamkills >= 0) {
    if(globallogic_utils::gettimepassed() >= 5000) {
      return true;
    }

    if(self.pers[#"teamkills_nostats"] > 1) {
      return true;
    }
  }

  return false;
}

function function_da080186() {
  timeperoneteamkillreduction = 20;
  reductionpersecond = 1 / timeperoneteamkillreduction;

  while(true) {
    if(isalive(self)) {
      self.pers[#"teamkills_nostats"] -= reductionpersecond;

      if(self.pers[#"teamkills_nostats"] < level.minimumallowedteamkills) {
        self.pers[#"teamkills_nostats"] = level.minimumallowedteamkills;
        break;
      }
    }

    wait 1;
  }
}

function callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc, psoffsettime, delayoverride) {}

function damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage) {
  self thread weapons::on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
  self playrumbleonentity("damage_heavy");
}

function function_c29ad5cf(idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body, var_d26b2156) {
  if(smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone") {
    self.body = body;
    return;
  }

  if(isDefined(level.ragdoll_override) && self[[level.ragdoll_override]](idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body)) {
    return;
  }

  if(ragdoll_jib || self isonladder() || self ismantling() || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT") {
    body startragdoll();
  }

  if(!self isonground()) {
    if(getdvarint(#"scr_disable_air_death_ragdoll", 0) == 0) {
      body startragdoll();
    }
  }

  if(smeansofdeath == "MOD_MELEE_ASSASSINATE" && isDefined(var_d26b2156) && var_d26b2156) {
    body start_death_from_above_ragdoll(vdir);
  }

  if(self is_explosive_ragdoll(weapon, einflictor)) {
    body start_explosive_ragdoll(vdir, weapon);
  }

  thread delaystartragdoll(body, shitloc, vdir, weapon, einflictor, smeansofdeath);

  if(smeansofdeath == "MOD_CRUSH") {
    body globallogic_vehicle::vehiclecrush();
  }

  self.body = body;
  params = spawnStruct();
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  self.body callback::callback(#"on_player_corpse", params);
}

function is_explosive_ragdoll(weapon, inflictor) {
  if(!isDefined(weapon)) {
    return false;
  }

  if(weapon.name == # "destructible_car" || weapon.name == # "explodable_barrel") {
    return true;
  }

  if(weapon.projexplosiontype == "grenade") {
    if(isDefined(inflictor) && isDefined(inflictor.stucktoplayer)) {
      if(inflictor.stucktoplayer == self) {
        return true;
      }
    }
  }

  return false;
}

function start_explosive_ragdoll(dir, weapon) {
  if(!isDefined(self)) {
    return;
  }

  x = randomintrange(50, 100);
  y = randomintrange(50, 100);
  z = randomintrange(10, 20);

  if(isDefined(weapon) && (weapon.name == # "sticky_grenade" || weapon.name == # "explosive_bolt")) {
    if(isDefined(dir) && lengthsquared(dir) > 0) {
      x = dir[0] * x;
      y = dir[1] * y;
    }
  } else {
    if(math::cointoss()) {
      x *= -1;
    }

    if(math::cointoss()) {
      y *= -1;
    }
  }

  self startragdoll();
  self launchragdoll((x, y, z));
}

function start_death_from_above_ragdoll(dir) {
  if(!isDefined(self)) {
    return;
  }

  self startragdoll();
  self launchragdoll((0, 0, -100));
}

function notifyconnecting() {
  waittillframeend();

  if(isDefined(self)) {
    level notify(#"connecting", {
      #player: self
    });
    callback::callback(#"on_player_connecting");
  }
}

function delaystartragdoll(ent, shitloc, vdir, weapon, einflictor, smeansofdeath) {
  if(isDefined(vdir)) {
    deathanim = vdir getcorpseanim();

    if(isDefined(deathanim) && animhasnotetrack(deathanim, "ignore_ragdoll")) {
      return;
    }
  }

  if(level.oldschool) {
    if(!isDefined(einflictor)) {
      einflictor = (0, 0, 0);
    }

    explosionpos = vdir.origin + (0, 0, globallogic_utils::gethitlocheight(weapon));
    explosionpos -= einflictor * 20;
    explosionradius = 40;
    var_10fb361d = 0.75;

    if(smeansofdeath == "MOD_IMPACT" || smeansofdeath == "MOD_EXPLOSIVE" || issubstr(smeansofdeath, "MOD_GRENADE") || issubstr(smeansofdeath, "MOD_PROJECTILE") || weapon == "head" || weapon == "helmet") {
      var_10fb361d = 2.5;
    }

    vdir startragdoll(1);
    waitframe(1);

    if(!isDefined(vdir)) {
      return;
    }

    physicsexplosionsphere(explosionpos, explosionradius, explosionradius / 2, var_10fb361d);
    return;
  }

  wait 0.2;

  if(!isDefined(vdir)) {
    return;
  }

  if(vdir isragdoll()) {
    return;
  }

  deathanim = vdir getcorpseanim();

  if(isDefined(deathanim) && animhasnotetrack(deathanim, "ignore_ragdoll")) {
    return;
  }

  startfrac = 0.35;

  if(animhasnotetrack(deathanim, "start_ragdoll")) {
    times = getnotetracktimes(deathanim, "start_ragdoll");

    if(isDefined(times)) {
      startfrac = times[0];
    }
  }

  waittime = startfrac * getanimlength(deathanim);
  wait waittime;

  if(isDefined(vdir)) {
    vdir startragdoll(1);
  }
}

function function_eedaefc(attacker, einflictor, weapon, smeansofdeath, shitloc) {
  if(weapons::isheadshot(weapon, shitloc, smeansofdeath) && isPlayer(einflictor)) {
    return "MOD_HEAD_SHOT";
  }

  switch (weapon.name) {
    case # "dog_bite":
      smeansofdeath = "MOD_PISTOL_BULLET";
      break;
    case # "destructible_car":
      smeansofdeath = "MOD_EXPLOSIVE";
      break;
    case # "explodable_barrel":
      smeansofdeath = "MOD_EXPLOSIVE";
      break;
  }

  return smeansofdeath;
}

function function_ff093620(attacker, weapon) {
  if(isai(attacker) && isDefined(attacker.script_owner)) {
    if(!level.teambased || attacker.script_owner.team != self.team) {
      attacker = attacker.script_owner;
    }
  }

  if(attacker.classname == "script_vehicle" && isDefined(attacker.owner)) {
    attacker notify(#"killed", {
      #victim: self
    });
    attacker = attacker.owner;
  }

  if(isai(attacker)) {
    attacker notify(#"killed", {
      #victim: self
    });
  }

  if(isDefined(self.capturinglastflag) && self.capturinglastflag == 1) {
    attacker.lastcapkiller = 1;
  }

  if(isDefined(attacker) && isDefined(weapon) && weapon.statname == # "planemortar") {
    if(!isDefined(attacker.planemortarbda)) {
      attacker.planemortarbda = 0;
    }

    attacker.planemortarbda++;
  }

  if(isDefined(attacker) && isDefined(weapon) && (weapon.name == # "straferun_rockets" || weapon.name == # "straferun_gun")) {
    if(isDefined(attacker.straferunbda)) {
      attacker.straferunbda++;
    }
  }

  return attacker;
}

function function_f67af024(einflictor) {
  if(isDefined(einflictor) && einflictor.classname == "script_vehicle") {
    einflictor notify(#"killed", {
      #victim: self
    });

    if(isDefined(einflictor.bda)) {
      einflictor.bda++;
    }
  }

  return einflictor;
}

function updateweapon(einflictor, weapon) {
  if(weapon == level.weaponnone && isDefined(einflictor)) {
    if(isDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
      weapon = getweapon(#"explodable_barrel");
    } else if(isDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
      weapon = getweapon(#"destructible_car");
    }
  }

  return weapon;
}

function function_4d3e38fb() {
  if(self == level) {
    foreach(player in level.players) {
      player function_4d3e38fb();
    }

    return;
  }

  if(isPlayer(self)) {
    a_w_weapons = self getweaponslist();

    foreach(weapon in a_w_weapons) {
      if(is_true(weapon.isheavyweapon)) {
        self savegame::set_player_data(savegame::function_8136eb5a() + "heavy_weapon", weapon.name);
        break;
      }
    }
  }
}

function private function_c674fc77(statname) {
  var_c0b8f5fd = self stats::get_stat(#"playerstatsbymap", getrootmapname(), #"currentstats", statname);
  var_65442406 = self stats::get_stat(#"playerstatslist", statname, #"statvalue");
  return var_65442406 - var_c0b8f5fd;
}

function function_4b78690e(current_map) {
  if(!isDefined(current_map)) {
    return;
  }

  for(i = 1; i < 58; i++) {
    var_813ca5ee = self getcurrentgunrank(i);

    if(!isDefined(var_813ca5ee)) {
      var_813ca5ee = 0;
    }

    self stats::set_stat(#"currentweaponlevels", i, var_813ca5ee);
  }

  var_e461ad1 = self stats::get_stat(#"playerstatslist", #"rankxp", #"statvalue");
  self stats::set_stat(#"hash_6dcaad4976588a44", var_e461ad1);
  var_797451ed = [];
  array::add(var_797451ed, "KILLS");
  array::add(var_797451ed, "SCORE");
  array::add(var_797451ed, "ASSISTS");
  array::add(var_797451ed, "INCAPS");
  array::add(var_797451ed, "REVIVES");

  foreach(stat in var_797451ed) {
    statvalue = self stats::get_stat(#"playerstatslist", stat, #"statvalue");
    self stats::set_stat(#"playerstatsbymap", current_map, #"currentstats", stat, statvalue);
  }

  for(i = 0; i < 6; i++) {
    var_b69c01aa = self stats::get_stat(#"playerstatsbymap", current_map, #"hash_1e0160af4fd80dff", i);
    self stats::set_stat(#"playerstatsbymap", current_map, #"hash_518113a79b08988", i, var_b69c01aa);
    var_3f6b581d = self stats::get_stat(#"playerstatsbymap", current_map, #"hash_657891d65d881524", i);
    self stats::set_stat(#"playerstatsbymap", current_map, #"hash_233621878f97486b", i, var_3f6b581d);
  }

  for(i = 0; i < 20; i++) {
    var_d8bb48fd = self stats::get_stat(#"playercpdecorations", i);
    self stats::set_stat(#"hash_711b1260308620e7", i, var_d8bb48fd);
  }

  uploadstats(self);
}

function recordactiveplayersendgamematchrecordstats() {
  foreach(player in level.players) {
    recordplayermatchend(player);
    recordplayerstats(player, "present_at_end", 1);
  }
}

function callback_playershielddamageblocked(damage) {}