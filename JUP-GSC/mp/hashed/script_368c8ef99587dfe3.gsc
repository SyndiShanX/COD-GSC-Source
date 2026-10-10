/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_368c8ef99587dfe3.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\juggernaut;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\killstreaks\juggernaut_recon;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\connect_event_aggregator;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace namespace_6ea38b6e0f4f1418;

function init() {
  scripts\mp\utility\connect_event_aggregator::registeronconnectcallback(&onplayerconnect);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  level callback::add("player_death", &on_player_death);
  level.var_44815c2275fee420 = 1;
  level.blockweapondrops = 1;
  level.var_3bdb45e93efd90b7 = &function_733b734c7e056e7a;
  level.addjuggfunctionality = &addjuggfunctionality;
  level.var_acc9df39da68b525 = &function_e6f066ba732bb019;
  level.var_d467dc0100a60a11 = getdvarint(@ "hash_d709bdbee115ac07", int(300));
  level.var_d48ace0100cc32ff = getdvarint(@ "hash_d72ccbbee13c1289", int(120));
  level.var_1a57009ab34d23ff = getdvarint(hashcat(@ "scr_", scripts\cp_mp\utility\game_utility::getmapname(), "_jugg_mosh_sword_angle"), -1);
  registersharedfunc("juggMosh", "swimExitSwitchToWeapon", &swimexitswitchtoweapon);
  level thread function_3dc43012396a57c5();

  level thread function_d1d0cc2cc9b8e653();
}

function function_3dc43012396a57c5() {
  scripts\mp\flags::gameflagwait("prematch_done");
  firstspawn = 0;
  var_d738c88dd3c5e3c0 = 0;
  origin = function_f6fe02c92d1feb88();

  while(true) {
    if(firstspawn) {
      firstspawn = 0;
      wait 15;
    }

    sword = spawn_sword(origin);
    objective_playermask_showtoall(level.var_7fb45e60b8b493cd);

    if(var_d738c88dd3c5e3c0) {
      scripts\mp\objidpoolmanager::update_objective_icon(level.var_7fb45e60b8b493cd, "jup_ui_map_icon_jugg_mosh_sword_active");
    } else {
      sword hide(1);
      scripts\mp\objidpoolmanager::update_objective_icon(level.var_7fb45e60b8b493cd, "jup_ui_map_icon_jugg_mosh_sword_soon");
      sword makeunusable();
      wait 10;
      sword show();
      scripts\mp\objidpoolmanager::update_objective_icon(level.var_7fb45e60b8b493cd, "jup_ui_map_icon_jugg_mosh_sword_active");
      sword makeusable();
      sword sethintinoperable(1);
    }

    var_f04280fc2bbe674c = function_17225b7d1fe74960(sword, var_d738c88dd3c5e3c0, 10);

    if(var_f04280fc2bbe674c) {
      objective_playermask_hidefromall(level.var_7fb45e60b8b493cd);
      msg = level waittill_any_return_2("sword_player_died", "sword_player_disconnected");

      if(msg == "sword_player_died") {
        origin = level.var_a3f607fb0245c8db;
        var_d738c88dd3c5e3c0 = 1;
      } else {
        origin = function_f6fe02c92d1feb88();
        var_d738c88dd3c5e3c0 = 0;
      }
    } else {
      sword delete();
      origin = function_f6fe02c92d1feb88();
      var_d738c88dd3c5e3c0 = 0;
    }

    scripts\mp\objidpoolmanager::update_objective_position(level.var_7fb45e60b8b493cd, origin);
  }
}

function function_17225b7d1fe74960(sword, var_d738c88dd3c5e3c0, time) {
  starttime = gettime();

  while(isDefined(sword)) {
    if(var_d738c88dd3c5e3c0 && gettime() - starttime >= time * 1000) {
      return false;
    }

    foreach(player in level.players) {
      if(player useButtonPressed() && isreallyalive(player) && distance(player.origin, sword.origin) < 100) {
        sword delete();
        player takeallweapons();
        player giveweapon("jup_jp23_me_swhiskey_mp+bp_tune0+jup_jp23_me_swhiskey_rec|4+loot1");
        player switchtoweapon("jup_jp23_me_swhiskey_mp+bp_tune0+jup_jp23_me_swhiskey_rec|4+loot1");
        return true;
      }
    }

    waitframe();
  }

  return true;
}

function spawn_sword(origin) {
  spawnflags = 1;
  weaponfixed = utility::function_ec8a443fe8165fe4("jup_jp23_me_swhiskey_mp+bp_tune0+jup_jp23_me_swhiskey_rec|4+loot1", origin, [], (45, 45, 45), spawnflags);
  weaponfixed hudoutlineenable("outlinefill_depth_white");
  weaponfixed sethintinoperable(1);

  if(!isDefined(level.var_7fb45e60b8b493cd)) {
    level.var_7fb45e60b8b493cd = weaponfixed function_c8458e8bd7248c4c();
  }

  return weaponfixed;
}

function function_f6fe02c92d1feb88() {
  angle = randomint(360);

  if(isDefined(level.var_1a57009ab34d23ff) && level.var_1a57009ab34d23ff > -1) {
    angle = level.var_1a57009ab34d23ff;
  }

  origin = scripts\mp\utility\game::function_9a59855eebf296b6();
  origin += (0, 0, 40);
  origin += 64 * vectorNormalize(anglesToForward((0, angle, 0)));
  return origin;
}

function function_c8458e8bd7248c4c() {
  requestfunc = undefined;

  if(scripts\engine\utility::issharedfuncdefined("game", "requestObjectiveID")) {
    requestfunc = scripts\engine\utility::getsharedfunc("game", "requestObjectiveID");
  }

  if(isDefined(requestfunc)) {
    objid = [[requestfunc]](99);
    self.objid = objid;
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "active", self.origin, "jup_ui_map_icon_jugg_mosh_sword_soon");
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);

    foreach(player in level.players) {
      if(!isDefined(player) || isbot(player) || player == self) {
        continue;
      }

      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
    }

    scripts\mp\objidpoolmanager::update_objective_onentity(objid, self);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::function_846c2acd91309cd8(objid, 255, 194, 21, 1);
    return objid;
  }
}

function onplayerconnect() {
  player = self;

  if(!isbot(self)) {
    thread function_c5629dcdb6b0da9d();
    thread function_4c55e2917aa58a1f();
  }
}

function function_c5629dcdb6b0da9d() {
  level endon("game_ended");

  while(true) {
    joinresult = waittill_any_return_no_endon_death_2("joined_team", "joined_spectators");

    if(isDefined(self.var_5a65e474ab89ffb7) && self.var_5a65e474ab89ffb7 > 0) {
      var_cc7584781dc01176 = level.streakglobals.streakbundles["juggernaut_recon"].var_d96d3e6ceed581fd.blueprints[self.var_5a65e474ab89ffb7 - 1].genericblueprint;
      self function_9bc014e7042e8339(var_cc7584781dc01176);
    }

    if(joinresult == "joined_team") {
      if(function_115b2477be653b18()) {
        var_a9a49b677e065618 = self.team == "allies" ? 1 : 2;
        var_2badd71933ecb549 = level.streakglobals.streakbundles["juggernaut_recon"].var_d96d3e6ceed581fd.blueprints[var_a9a49b677e065618 - 1].genericblueprint;
        self function_53c61cc39f6a3b11(var_2badd71933ecb549);
        self.var_5a65e474ab89ffb7 = var_a9a49b677e065618;
        self.var_3c9615208f1c09b8 = undefined;
      }
    }
  }
}

function onplayerspawned() {
  if(getdvarint(@ "hash_672437747e65ed17", 0)) {
    return;
  }

  player = self;
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("juggernaut_recon", player);
  streakinfo.debug_state = "begin_use";
  streakinfo.mpstreaksysteminfo = spawnStruct();
  streakinfo.mpstreaksysteminfo.var_f019165513ce215a = 1;
  streakinfo.mpstreaksysteminfo.ownerxuid = player getxuid();

  if(function_115b2477be653b18()) {
    streakinfo.mpstreaksysteminfo.blueprintindex = player.team == "allies" ? 1 : 2;
  } else {
    streakinfo.mpstreaksysteminfo.blueprintindex = 0;
  }

  player function_c0a88d3391da61e4(streakinfo);
  player thread scripts\killstreaks\juggernaut_recon::function_8bac95417054dcbf(streakinfo);
  player val::set("juggernaut", "killstreaks", 1);
  player val::set("juggernaut", "cough_gesture", 1);
  player val::set("juggernaut", "weapon_pickup", 1);
}

function onplayerdisconnect(player) {
  if(player hasweapon("jup_jp23_me_swhiskey_mp+bp_tune0+jup_jp23_me_swhiskey_rec|4+loot1")) {
    level notify("sword_player_disconnected");
  }
}

function function_4c55e2917aa58a1f() {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("giveLoadout");
    thread onplayerspawned();
  }
}

function on_player_death(params) {
  if(self hasweapon("jup_jp23_me_swhiskey_mp+bp_tune0+jup_jp23_me_swhiskey_rec|4+loot1")) {
    level.var_a3f607fb0245c8db = self.origin + (0, 0, 28);
    level notify("sword_player_died");
    return;
  }

  level thread function_5354abab47f718cb(self.origin + (0, 0, 28));
}

function function_5354abab47f718cb(pos) {
  visuals = [];
  visuals[0] = spawn("script_model", pos);
  visuals[0] setModel("lm_loot_wm_armor_plate_iw9_carbon_fiber");
  visuals[0] hudoutlineenable("outlinefill_depth_white");
  visuals[0].angles = (15, 15, 15);
  trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
  useteam = "any";
  armor = scripts\mp\gameobjects::createuseobject(useteam, trigger, visuals, (0, 0, 16), "undefined", 1);
  armor.ownerteam = "neutral";
  armor.curorigin = pos;
  armor.trigger.origin = pos;
  armor.visuals[0].origin = pos;
  armor scripts\mp\gameobjects::allowuse("any");
  armor scripts\mp\gameobjects::setusetime(0);
  armor.onuse = &function_879ea531906adbcb;
}

function function_879ea531906adbcb(player) {
  if(isDefined(self.visuals[0])) {
    player playsoundtoplayer("generic_armor_pickup", player, player);
    self.visuals[0] delete();
  }

  healthadd = 200;

  if(getdvarint(@ "hash_4aa1740550dfb702", -1) > 0) {
    healthadd = getdvarint(@ "hash_4aa1740550dfb702");
  }

  player.health = int(min(player.maxhealth, healthadd + player.health));
  thread scripts\mp\gameobjects::deleteuseobject();
}

function function_733b734c7e056e7a() {
  self.infiniteammo = 0;
  health = getdvarint(@ "hash_92cd2b3237232b6d", 600);
  self.maxhealth = health;
  self.startinghealth = health;
  self.perks = [];
  self.allows["equipment_primary"] = 0;
  self.allows["equipment_secondary"] = 0;
  self.allows["flashed"] = 0;
  self.allows["stunned"] = 0;
  self.var_e60a16c2ac55422 = getdvarint(@ "hash_28407e45264d7c83", 1) == 0;
  self.var_3d390afc57b388ef = spawnStruct();
  self.var_3d390afc57b388ef.radius = getdvarint(@ "hash_1247e9b35fad8d74", 800);
  self.var_3d390afc57b388ef.interval = getdvarfloat(@ "hash_c1bf35f215586cc3", 4);
  self.var_3d390afc57b388ef.sweeptime = getdvarfloat(@ "hash_195d9991acd1e4d6", 1);
}

function function_c0a88d3391da61e4(streakinfo) {
  if(!isDefined(self.var_3c9615208f1c09b8)) {
    bundle = level.streakglobals.streakbundles["juggernaut_recon"];
    self.var_3c9615208f1c09b8 = function_d5974b5f58f14716(bundle, level.var_e084c71df9ac20f1.config, streakinfo.mpstreaksysteminfo.blueprintindex);
  }

  hasriotshield = self.classstruct.loadoutprimary == "iw9_me_riotshield" || self.classstruct.loadoutsecondary == "iw9_me_riotshield";
  self.var_3c9615208f1c09b8.movespeedscalar = hasriotshield ? getdvarfloat(@ "hash_cc0c9ad9f62df6f6", -0.1) : getdvarfloat(@ "hash_1fb8848934615a8b", 0.1);
}

function addjuggfunctionality() {
  thread function_e0001df6508ffa0b();
}

function function_e0001df6508ffa0b() {
  self endon("disconnect");
  self endon("juggernaut_end");

  while(true) {
    self waittill("reload");
    weapons = self getweaponslistall();

    foreach(weap in weapons) {
      self setweaponammostock(weap, weaponmaxammo(weap));
    }
  }
}

function function_e6f066ba732bb019() {
  time = 3;

  foreach(player in level.players) {
    if(!isreallyalive(player)) {
      continue;
    }

    if(is_equal(player.pers["team"], self.pers["team"])) {
      continue;
    }

    if(distance(player.origin, self.origin) > 300) {
      continue;
    }

    player utility::setplayerstunned();
    player thread scripts\cp_mp\utility\weapon_utility::cleanupconcussionstun(time);
    player scripts\cp_mp\utility\shellshock_utility::_shellshock("concussion_grenade_mp", "stun", time, 1);
  }
}

function swimexitswitchtoweapon(swimweapon) {
  scripts\cp_mp\utility\inventory_utility::_takeweapon(swimweapon);

  if(self hasweapon("jup_jp23_me_swhiskey_mp+bp_tune0+jup_jp23_me_swhiskey_rec|4+loot1")) {
    self switchtoweaponimmediate("jup_jp23_me_swhiskey_mp+bp_tune0+jup_jp23_me_swhiskey_rec|4+loot1");
    return;
  }

  self switchtoweaponimmediate(self.primaryweaponobj);
}

function private function_115b2477be653b18() {
  return getdvarint(@ "hash_24e4f010465c5314", 1) > 0;
}

function function_d1d0cc2cc9b8e653() {
  while(true) {
    if(!getdvarint(@ "hash_426e190367ecef56", 0)) {
      wait 5;
      continue;
    }

    while(!isDefined(level.players) || level.players.size < 2) {
      waitframe();
    }

    var_2e3b2407e9947a23 = undefined;

    foreach(player in level.players) {
      if(!isbot(player)) {
        continue;
      }

      var_2e3b2407e9947a23 = player;
      break;
    }

    if(!isalive(var_2e3b2407e9947a23) || !isalive(level.player)) {
      wait 5;
      continue;
    }

    var_2e3b2407e9947a23 setOrigin(level.player.origin + (0, 0, 1000) + 64 * vectorNormalize(anglesToForward(flat_angle(level.player.angles))));
    wait 8;
  }
}

# /