/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\cache.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#namespace cache;

function init() {
  level.caches = [];
  SetDvars();
  level.var_64fb1ddb76bd394d = getdvarint(@ "hash_797157733a7b374c", 0) == 1;
  level.var_8fc6518a9ad097d7 = getdvarint(@ "hash_f13fc58fe94f1229", 0) == 1;
  level.var_5b9a9d990a538d42 = getdvarint(@ "hash_9946ed5634cbd5ad", 0) == 1;
  level.var_d6855ec15b5482f1 = getdvarint(@ "hash_8f34a6f6c29064d", 0);
  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  level callback::add("player_disconnect", &onplayerdisconnect);
}

function SetDvars() {
  setdvarifuninitialized(@ "hash_f13fc58fe94f1229", 1);
  setdvarifuninitialized(@ "hash_9946ed5634cbd5ad", 1);
  setdvarifuninitialized(@ "hash_8f34a6f6c29064d", 0);
  setdvarifuninitialized(@ "hash_caf5e1a6dd9b790d", 6);
  setdvarifuninitialized(@ "hash_cad2cba6dd7500f3", 9);
  setdvarifuninitialized(@ "hash_104aa059a81b4397", 750);
  setdvarifuninitialized(@ "hash_106dae59a841aa19", 1125);
  setdvarifuninitialized(@ "hash_cf0172531d6f94bd", 9);
  setdvarifuninitialized(@ "hash_cede7c531d496303", 12);
  setdvarifuninitialized(@ "hash_ddb7be98d91da5a7", 1125);
  setdvarifuninitialized(@ "hash_dddaac98d943c5c9", 1500);
  setdvarifuninitialized(@ "hash_602393114e4085a1", 12);
  setdvarifuninitialized(@ "hash_3b67a23c39750b03", 1500);
  setdvarifuninitialized(@ "hash_dc6b71985e82776c", 1);
  setdvarifuninitialized(@ "hash_11451d49c7dd179a", 125);
  setdvarifuninitialized(@ "hash_800f47766d0d385c", 2);
  setdvarifuninitialized(@ "hash_251b9d48cb4ea72a", 250);
  setdvarifuninitialized(@ "hash_4c296ec15d311140", 3);
  setdvarifuninitialized(@ "hash_6f1e998c4f7556f6", 375);
}

function function_9e0ae8b3ac9a190f(victim, attacker, victimnotification, meansofdeath) {
  if(victim.killcountthislife < getdvarint(@ "hash_caf5e1a6dd9b790d") && victim.streakpoints * 125 < getdvarint(@ "hash_104aa059a81b4397")) {
    return;
  }

  var_70eda0e3c11182d2 = victim function_70eda0e3c11182d2(attacker);

  if(!var_70eda0e3c11182d2) {
    return;
  }

  if(isagent(victim)) {
    return;
  }

  if(isagent(attacker) && isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  var_f7619d9f99ab13e = function_7268d2c44a8eb36c()[2];
  upangles = (0, 0, 0);
  var_650440c6a1642e7e = victim.angles;

  if(victim scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var_650440c6a1642e7e = victim getworldupreferenceangles();
    upangles = anglestoup(var_650440c6a1642e7e);

    if(upangles[2] < 0) {
      var_f7619d9f99ab13e *= -1;
    }
  }

  if(level.var_8fc6518a9ad097d7) {
    useteam = "friendly";
  } else {
    useteam = "any";
  }

  if(isDefined(level.caches[victim.guid])) {
    function_4ccc1c9389ac4346(victim.guid, 1);
  }

  visuals = [];
  cachesize = function_3eac026bd8b3a18e(victim);
  payload = undefined;

  if(isDefined(attacker.team)) {
    payload = [#"teamselect", attacker.team];
  }

  visuals[0] = spawnscriptable(cachesize, (0, 0, 0), (0, 0, 0), undefined, payload);
  visuals[0] setasgametypeobjective();
  trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);

  if(victim scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    if(upangles[2] < 0) {
      visuals[0].angles = var_650440c6a1642e7e;
    }
  }

  usetime = 0;
  level.caches[victim.guid] = scripts\mp\gameobjects::createuseobject(useteam, trigger, visuals, (0, 0, 16));
  level.caches[victim.guid].onuse = &onuse;
  level.caches[victim.guid] scripts\mp\gameobjects::setusetime(usetime);
  level.caches[victim.guid].victim = victim;
  level.caches[victim.guid].victimteam = victim.team;
  level.caches[victim.guid].offset3d = (0, 0, 24);
  level.caches[victim.guid].cachesize = cachesize;
  scripts\mp\objidpoolmanager::update_objective_setzoffset(level.caches[victim.guid].objidnum, level.caches[victim.guid].offset3d[2]);

  if(level.var_5b9a9d990a538d42) {
    attacker thread function_b4c15cacbfad2d83(level.caches[victim.guid]);
  }

  if(level.var_d6855ec15b5482f1 != 0) {
    attacker thread function_402da06a87e59da4(level.caches[victim.guid]);
  }

  attacker thread function_932003199f578b69(level.caches[victim.guid]);
  pos = victim.origin + (0, 0, var_f7619d9f99ab13e);
  level.caches[victim.guid].curorigin = pos;
  level.caches[victim.guid].trigger.origin = pos;
  level.caches[victim.guid].visuals[0].origin = pos;
  level.caches[victim.guid] scripts\mp\gameobjects::initializetagpathvariables();
  level.caches[victim.guid] scripts\mp\gameobjects::allowuse(useteam);

  if(level.var_8fc6518a9ad097d7) {
    level.caches[victim.guid].visuals[0] setscriptablepartstate(level.caches[victim.guid].cachesize, "team_only");
  }

  level.caches[victim.guid].attacker = attacker;
  level.caches[victim.guid].attackerteam = attacker.team;
  level.caches[victim.guid].ownerteam = ter_op(level.var_8fc6518a9ad097d7, attacker.team, "neutral");

  if(isDefined(level.caches[victim.guid].objidnum) && level.caches[victim.guid].objidnum != -1) {
    objid = level.caches[victim.guid].objidnum;
    state = "current";

    if(!istrue(level.var_64fb1ddb76bd394d)) {
      state = "active";
    }

    scripts\mp\objidpoolmanager::update_objective_state(objid, state);
    scripts\mp\objidpoolmanager::update_objective_position(objid, victim.origin + (0, 0, 36));
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(level.caches[victim.guid].objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(level.caches[victim.guid].objidnum, 0);
    scripts\mp\objidpoolmanager::function_98ba077848896a3(level.caches[victim.guid].objidnum, 0);
    scripts\mp\objidpoolmanager::function_f21e9b2e78de984b(level.caches[victim.guid].objidnum, 800, 1600);
  }

  if(isDefined(cachesize) && !attacker isusingremote()) {
    switch (cachesize) {
      case #"hash_a0886c37476edc4d":
        attacker thread scripts\mp\utility\points::doscoreevent(#"hash_6f7bb4cadf5d7aaa");
        victim playsoundtoplayer("jup_cache_spawn_sml", attacker);
        victim playsoundtoteam("jup_cache_spawn_sml", attacker.team, attacker);
        break;
      case #"hash_351044c342051fa5":
        attacker thread scripts\mp\utility\points::doscoreevent(#"hash_6f7bb3cadf5d78f7");
        victim playsoundtoplayer("jup_cache_spawn_med", attacker);
        victim playsoundtoteam("jup_cache_spawn_med", attacker.team, attacker);
        break;
      case #"hash_718c0a24bfc3f1e9":
        attacker thread scripts\mp\utility\points::doscoreevent(#"hash_6f7bb2cadf5d7744");
        victim playsoundtoplayer("jup_cache_spawn_lrg", attacker);
        victim playsoundtoteam("jup_cache_spawn_lrg", attacker.team, attacker);
        break;
    }
  }

  level notify(victimnotification, level.caches[victim.guid]);
}

function function_70eda0e3c11182d2(attacker) {
  if(isDefined(self.switching_teams)) {
    return false;
  }

  if(isDefined(attacker) && attacker == self) {
    return false;
  }

  if(level.teambased && isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.team) {
    return false;
  }

  if(isDefined(attacker) && !isDefined(attacker.team) && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")) {
    return false;
  }

  if(isreallyalive(self)) {
    return false;
  }

  return true;
}

function function_7268d2c44a8eb36c() {
  if(level.gametype == "conf") {
    return (0, 0, 10);
  }

  return (0, 0, 20);
}

function function_f4a26084558ba5bf() {
  self.attacker = undefined;
  self notify("reset");
  self.visuals[0] setscriptablepartstate(self.cachesize, "hidden");
  self.curorigin = (0, 0, 1000);
  self.trigger.origin = (0, 0, 1000);
  self.visuals[0].origin = (0, 0, 1000);
  scripts\mp\gameobjects::allowuse("none");

  if(self.objidnum != -1) {
    scripts\mp\objidpoolmanager::update_objective_state(self.objidnum, "done");
  }
}

function onuse(player) {
  if(isDefined(player.owner)) {
    player = player.owner;
  }

  player playsoundtoplayer("jup_cache_obj_pickup_player", player);
  player playsoundtoteam("jup_cache_obj_pickup_allies", player.team, player);
  player thread scripts\mp\utility\points::doscoreevent(#"hash_c36669313b5ec2af");

  if(self.cachesize == "cache_small") {
    player scripts\mp\killstreaks\killstreaks::givestreakpoints(#"cache", getdvarint(@ "hash_dc6b71985e82776c"), getdvarint(@ "hash_11451d49c7dd179a"));
  } else if(self.cachesize == "cache_medium") {
    player scripts\mp\killstreaks\killstreaks::givestreakpoints(#"cache", getdvarint(@ "hash_800f47766d0d385c"), getdvarint(@ "hash_251b9d48cb4ea72a"));
  } else if(self.cachesize == "cache_large") {
    player scripts\mp\killstreaks\killstreaks::givestreakpoints(#"cache", getdvarint(@ "hash_4c296ec15d311140"), getdvarint(@ "hash_6f1e998c4f7556f6"));
  }

  self.attacker notify("cache_removed");
  thread function_4ccc1c9389ac4346(self.victim.guid, undefined, player);
}

function function_b4c15cacbfad2d83(cache) {
  self endon("cache_removed");
  cache endon("death");
  level endon("game_ended");
  waittill_any_return_2("death", "disconnect");
  thread function_4ccc1c9389ac4346(cache.victim.guid, 1);
}

function function_402da06a87e59da4(cache) {
  self endon("cache_removed");
  cache endon("death");
  level endon("game_ended");
  wait level.var_d6855ec15b5482f1;
  thread function_4ccc1c9389ac4346(cache.victim.guid, 1);
}

function function_932003199f578b69(cache) {
  level endon("game_ended");
  self endon("disconnect");
  cache endon("death");

  while(true) {
    self waittill("joined_team");
    thread function_4ccc1c9389ac4346(cache.victim.guid, 1);
  }
}

function function_4ccc1c9389ac4346(guid, notifyattacker, collector) {
  if(isDefined(level.caches[guid])) {
    level.caches[guid] scripts\mp\gameobjects::allowuse("none");
    playFX(level.conf_fx["vanish"], level.caches[guid].curorigin);
    level.caches[guid] notify("reset");
    waitframe();

    if(!isDefined(level.caches[guid])) {
      return;
    }

    level.caches[guid] notify("death");

    for(i = 0; i < level.caches[guid].visuals.size; i++) {
      level.caches[guid].visuals[i] freescriptable();
    }

    if(!isDefined(level.caches[guid].skipminimapids)) {
      level.caches[guid] thread scripts\mp\gameobjects::deleteuseobject();
    }

    level.caches[guid] = undefined;
  }
}

function function_3eac026bd8b3a18e(victim) {
  victimkills = victim.killcountthislife;
  var_36fe49dbed0c39f1 = victim.streakpoints * 125;

  if(victimkills >= getdvarint(@ "hash_caf5e1a6dd9b790d") && victimkills < getdvarint(@ "hash_cad2cba6dd7500f3") || var_36fe49dbed0c39f1 >= getdvarint(@ "hash_104aa059a81b4397") && var_36fe49dbed0c39f1 < getdvarint(@ "hash_106dae59a841aa19")) {
    cachesize = "cache_small";
  }

  if(victimkills >= getdvarint(@ "hash_cf0172531d6f94bd") && victimkills < getdvarint(@ "hash_cede7c531d496303") || var_36fe49dbed0c39f1 >= getdvarint(@ "hash_ddb7be98d91da5a7") && var_36fe49dbed0c39f1 < getdvarint(@ "hash_dddaac98d943c5c9")) {
    cachesize = "cache_medium";
  }

  if(victimkills >= getdvarint(@ "hash_602393114e4085a1") || var_36fe49dbed0c39f1 >= getdvarint(@ "hash_3b67a23c39750b03")) {
    cachesize = "cache_large";
  }

  return cachesize;
}

function onplayerdisconnect(params) {
  if(isDefined(self.guid)) {
    thread function_4ccc1c9389ac4346(self.guid, 1);
  }
}