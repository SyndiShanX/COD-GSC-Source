/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\clean.gsc
*************************************************/

#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\teams\_teams;
#using scripts\shared\_oob;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\popups_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace clean;

function autoexec __init__sytem__() {
  system::register("clean", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("clientuimodel", "hudItems.cleanCarryCount", 12000, 4, "int");
  clientfield::register("clientuimodel", "hudItems.cleanCarryFull", 12000, 1, "int");
  clientfield::register("scriptmover", "taco_flag", 12000, 2, "int");
  clientfield::register("allplayers", "taco_carry", 12000, 1, "int");
}

function main() {
  globallogic::init();
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 50000);
  util::registerroundlimit(0, 10);
  util::registerroundswitch(0, 9);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  level.tacos = [];
  level.teamscoreperkill = getgametypesetting("teamScorePerKill");
  level.teamscorepercleandeposit = getgametypesetting("teamScorePerCleanDeposit");
  level.var_c8a5fbc4 = 0;
  level.cleandepositonlinetime = getgametypesetting("cleanDepositOnlineTime");
  level.cleandepositrotation = getgametypesetting("cleanDepositRotation");
  level.scoreroundwinbased = 1;
  level.teambased = 1;
  level.overrideteamscore = 1;
  level.onprecachegametype = &onprecachegametype;
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.onplayerkilled = &onplayerkilled;
  level.onroundswitch = &onroundswitch;
  level.onroundendgame = &onroundendgame;
  level.var_83033207 = getweapon("clean_drop");
  if(!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
    globallogic::setvisiblescoreboardcolumns("score", "kills", "cleandeposits", "cleandenies", "deaths");
  } else {
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "cleandeposits", "cleandenies");
  }
  globallogic_audio::set_leader_gametype_dialog("startStockpile", "hcStartStockpile", "stockpileOrders", "stockpileOrders");
  gameobjects::register_allowed_gameobject(level.gametype);
}

function onprecachegametype() {}

function onstartgametype() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }
  globallogic_score::resetteamscores();
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  foreach(team in level.teams) {
    util::setobjectivetext(team, &"OBJECTIVES_CLEAN");
    util::setobjectivehinttext(team, &"OBJECTIVES_CLEAN_HINT");
    if(level.splitscreen) {
      util::setobjectivescoretext(team, &"OBJECTIVES_CLEAN");
    } else {
      util::setobjectivescoretext(team, &"OBJECTIVES_CLEAN_SCORE");
    }
    spawnlogic::add_spawn_points(team, "mp_tdm_spawn");
    spawnlogic::place_spawn_points(spawning::gettdmstartspawnname(team));
  }
  spawning::updateallspawnpoints();
  level.spawn_start = [];
  foreach(team in level.teams) {
    level.spawn_start[team] = spawnlogic::get_spawnpoint_array(spawning::gettdmstartspawnname(team));
  }
  level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  spawnpoint = spawnlogic::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
  for(i = 0; i < 60; i++) {
    level.tacos[i] = function_18b49ff3();
  }
  level function_f4229f9e();
  level thread function_5b1f87d2();
  level thread function_7ae0a91b();
  level.var_75f6aaa3 = 0;
  level.var_48919db8 = 0;
  level.var_b24377b2 = 0;
  level.var_6a17c1e8 = 0;
  level.var_dcae370c = 0;
}

function function_7ae0a91b() {
  level waittill("game_ended");
  foreach(taco in level.tacos) {
    if(taco clientfield::get("taco_flag") > 0) {
      taco clientfield::set("taco_flag", 0);
    }
  }
  foreach(var_12b94c16 in level.cleandeposithubs) {
    var_12b94c16 stoploopsound();
    if(isDefined(var_12b94c16.baseeffect)) {
      var_12b94c16.baseeffect delete();
    }
  }
  foreach(player in level.players) {
    player clientfield::set("taco_carry", 0);
  }
}

function debug_print() {
  while(true) {
    iprintln("" + level.var_75f6aaa3);
    iprintln("" + level.var_48919db8);
    iprintln("" + level.var_b24377b2);
    iprintln("" + level.var_6a17c1e8);
    iprintln("" + level.var_dcae370c);
    wait(5);
  }
}

function onspawnplayer(predictedspawn) {
  if(level.usestartspawns && !level.ingraceperiod) {
    level.usestartspawns = 0;
  }
  self.var_2deb2526 = 0;
  self.var_6963bf0f = 0;
  self.var_f2408e26 = 0;
  self.carriedtacos = 0;
  self clientfield::set_player_uimodel("hudItems.cleanCarryCount", 0);
  spawning::onspawnplayer(predictedspawn);
  self thread function_d740a523();
  self thread function_2b8b2197();
  self thread function_3063d818();
  self thread function_f1188a86();
  self.var_3d64ac00 = 0;
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  player = self;
  if(isplayer(attacker) && attacker.team != self.team) {
    if(!isDefined(killstreaks::get_killstreak_for_weapon(weapon)) || (isDefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore)) {
      attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
    }
  }
  if(isDefined(attacker) && isplayer(attacker) && attacker.team != self.team) {
    if(isDefined(player) && isDefined(player.carriedtacos)) {
      if(player.carriedtacos >= 5) {
        scoreevents::processscoreevent("clean_kill_enemy_carrying_tacos", attacker);
      }
    }
    taco = function_54bb534d();
    if(isDefined(taco)) {
      yawangle = randomint(360);
      taco function_992fbc7a(self, attacker, undefined, yawangle);
    }
    self thread function_5d5411e2(attacker, yawangle);
  }
}

function function_d740a523() {
  self endon("death");
  level endon("game_ended");
  while(true) {
    self flagsys::wait_till("camo_suit_on");
    self clientfield::set("taco_carry", 0);
    self flagsys::wait_till_clear("camo_suit_on");
  }
}

function function_2b8b2197() {
  self endon("death");
  level endon("game_ended");
  while(true) {
    self flagsys::wait_till("camo_suit_on");
    self flagsys::wait_till_clear("camo_suit_on");
    self function_65ae6452();
  }
}

function function_3063d818() {
  self endon("death");
  level endon("game_ended");
  while(true) {
    self flagsys::wait_till("clone_activated");
    self clientfield::set("taco_carry", 0);
    self flagsys::wait_till_clear("clone_activated");
  }
}

function function_f1188a86() {
  self endon("death");
  level endon("game_ended");
  while(true) {
    self flagsys::wait_till("clone_activated");
    self flagsys::wait_till_clear("clone_activated");
    self function_65ae6452();
  }
}

function function_7858ab06() {
  self endon("death");
  level endon("game_ended");
  while(true) {
    self util::waittill_any("enter_vehicle", "exit_vehicle");
    self function_65ae6452();
  }
}

function function_65ae6452() {
  if(self.carriedtacos > 0 && !self isinvehicle() && !self flagsys::get("camo_suit_on") && !self flagsys::get("clone_activated")) {
    self clientfield::set("taco_carry", 1);
  } else {
    self clientfield::set("taco_carry", 0);
  }
}

function function_54bb534d() {
  var_1ea2e34b = undefined;
  foreach(taco in level.tacos) {
    if(taco.interactteam == "none") {
      return taco;
    }
    if(isDefined(taco.var_88b94427)) {
      continue;
    }
    if(!isDefined(var_1ea2e34b) || taco.droptime < var_1ea2e34b.droptime) {
      var_1ea2e34b = taco;
    }
  }
  if(isDefined(var_1ea2e34b) && var_1ea2e34b.droptime != gettime()) {
    level.var_6a17c1e8++;
    var_1ea2e34b function_8e1efaa2();
    return var_1ea2e34b;
  }
  level.var_dcae370c++;
  return undefined;
}

function function_18b49ff3() {
  visuals = [];
  trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
  taco = gameobjects::create_use_object("any", trigger, visuals, undefined, &"");
  taco notsolid();
  taco ghost();
  taco gameobjects::set_use_time(0);
  taco.onuse = &function_9629206a;
  objective_add(taco.objectiveid, "invisible", (0, 0, 0));
  objective_icon(taco.objectiveid, "t7_hud_waypoints_stockpile_dropped");
  return taco;
}

function function_992fbc7a(victim, attacker, pos, yawangle) {
  level.var_75f6aaa3++;
  level.var_48919db8 = max(level.var_48919db8, level.var_75f6aaa3);
  if(!isDefined(yawangle)) {
    yawangle = randomint(360);
  }
  if(!isDefined(pos)) {
    pos = victim.origin + vectorscale((0, 0, 1), 40);
  }
  self.droptime = gettime();
  self.team = victim.team;
  self.victim = victim;
  self.victimteam = victim.team;
  self.attacker = attacker;
  self.attackerteam = attacker.team;
  self.trigger.origin = pos;
  self show();
  self clientfield::set("taco_flag", 1);
  self playLoopSound("mpl_fracture_core_loop");
  self dontinterpolate();
  objective_setinvisibletoall(self.objectiveid);
  objective_team(self.objectiveid, attacker.team);
  objective_state(self.objectiveid, "active");
  objective_setcolor(self.objectiveid, &"EnemyOrange");
  objective_setvisibletoplayer(self.objectiveid, attacker);
  self gameobjects::allow_use("any");
  if(isDefined(self.var_88b94427)) {
    self.var_88b94427 delete();
  }
  dropangles = (-70, yawangle, 0);
  force = anglesToForward(dropangles) * randomfloatrange(getdvarfloat("dropMin", 220), getdvarfloat("dropMax", 300));
  self.var_88b94427 = victim magicmissile(level.var_83033207, pos, force);
  self.var_88b94427 hide();
  self.var_88b94427 notsolid();
  self thread function_31778038();
  self thread function_3073cc55();
  self thread function_6769c4da();
}

function function_31778038() {
  level endon("game_ended");
  self endon("reset");
  self.var_88b94427 endon("stationary");
  while(true) {
    if(!isDefined(self)) {
      return;
    }
    if(!isDefined(self.var_88b94427)) {
      return;
    }
    if(self.var_88b94427 oob::istouchinganyoobtrigger() || self.var_88b94427 gameobjects::is_touching_any_trigger_key_value("trigger_hurt", "classname", self.trigger.origin[2], self.trigger.origin[2] + 32)) {
      self thread function_8e1efaa2();
      return;
    }
    self.trigger.origin = self.var_88b94427.origin;
    objective_position(self.objectiveid, self.trigger.origin);
    wait(0.05);
  }
}

function function_3073cc55() {
  level endon("game_ended");
  self endon("reset");
  self endon("death");
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.var_88b94427)) {
    return;
  }
  self.var_88b94427 waittill("stationary");
  self.trigger.origin = self.var_88b94427.origin;
  objective_position(self.objectiveid, self.trigger.origin);
  self playSound("mpl_fracture_core_drop");
  self clientfield::set("taco_flag", 2);
  self.var_88b94427 delete();
  self.var_88b94427 = undefined;
}

function function_6769c4da() {
  level endon("game_ended");
  self endon("reset");
  wait(60);
  level.var_b24377b2++;
  self thread function_8e1efaa2();
}

function function_8e1efaa2() {
  level.var_75f6aaa3--;
  self notify("reset");
  self clientfield::set("taco_flag", 0);
  self stoploopsound();
  self.trigger.origin = vectorscale((0, 0, 1), 1000);
  self gameobjects::allow_use("none");
  if(isDefined(self.var_88b94427)) {
    self.var_88b94427 delete();
    self.var_88b94427 = undefined;
  }
  objective_state(self.objectiveid, "invisible");
  self ghost();
}

function onroundswitch() {
  game["switchedsides"] = !game["switchedsides"];
}

function onroundendgame(roundwinner) {
  return globallogic::determineteamwinnerbygamestat("roundswon");
}

function function_f4229f9e() {
  globallogic::waitforplayers();
  function_cb0def85("clean_objective_base_trig");
  function_cb0def85("clean_objective_center_trig");
  function_cb0def85("clean_objective_scatter_trig");
  function_afb9f455();
  if(!isDefined(level.cleandepositpoints)) {
    util::error("");
    return;
  }
  level.cleandeposithubs = [];
  foreach(point in level.cleandepositpoints) {
    var_12b94c16 = function_4c41767e(point);
    level.cleandeposithubs[level.cleandeposithubs.size] = var_12b94c16;
  }
}

function function_cb0def85(targetname) {
  ents = getEntArray(targetname, "targetname");
  foreach(ent in ents) {
    ent delete();
  }
}

function function_afb9f455() {
  scriptmodels = getEntArray("script_model", "className");
  foreach(scriptmodel in scriptmodels) {
    if(scriptmodel.model === "p7_mp_flag_base") {
      scriptmodel delete();
    }
  }
}

function function_4c41767e(origin) {
  trigger = spawn("trigger_radius", origin, 0, 80, 108);
  visuals[0] = spawn("script_model", trigger.origin);
  var_12b94c16 = gameobjects::create_use_object("neutral", trigger, visuals, undefined, &"clean_deposit");
  var_12b94c16 gameobjects::set_use_time(0);
  var_12b94c16 gameobjects::allow_use("none");
  var_12b94c16 gameobjects::set_visible_team("none");
  var_12b94c16.onuse = &function_f6b1cbad;
  var_12b94c16.canuseobject = &function_52f9b039;
  var_12b94c16.effectorigin = trigger.origin + (0, 0, 0);
  var_12b94c16 spawning::create_influencer("clean_deposit_hub", var_12b94c16.origin, 0);
  var_12b94c16 spawning::enable_influencers(0);
  return var_12b94c16;
}

function function_9bc55b1b() {
  level endon("game_ended");
  self.var_6de41998 = spawn("script_model", self.effectorigin);
  self.var_6de41998 setModel("tag_origin");
  self.var_6de41998.angles = vectorscale((-1, 0, 0), 90);
  self.baseeffect = spawnfx("ui/fx_stockpile_deposit_point", self.effectorigin);
  self.baseeffect.team = "none";
  triggerfx(self.baseeffect, 0.001);
  time_left = 5;
  wait_time = level.cleandepositonlinetime - time_left;
  if(wait_time < 0) {
    wait_time = level.cleandepositonlinetime * 0.05;
  }
  wait(wait_time);
  if(!isDefined(self.baseeffect)) {
    return;
  }
  self playSound("mpl_fracture_deposit_leave");
  self.baseeffect delete();
  self.baseeffect = playFXOnTag("ui/fx_stockpile_deposit_point_end", self.var_6de41998, "tag_origin");
  self.baseeffect.team = "none";
  time_left = time_left + 0.25;
  var_3112d2e7 = 3;
  angles = (self.var_6de41998.angles[0], self.var_6de41998.angles[1] - (var_3112d2e7 * 360), self.var_6de41998.angles[2]);
  self.var_6de41998 rotateto(angles, time_left, time_left, 0, 0);
}

function function_5b1f87d2() {
  level endon("game_ended");
  while(level.inprematchperiod) {
    wait(0.05);
  }
  setbombtimer("A", 0);
  setmatchflag("bomb_timer_a", 0);
  var_1bc0e62e = -1;
  while(true) {
    if(level.var_c8a5fbc4 > 0) {
      foreach(team in level.teams) {
        setmatchflag("bomb_timer_a", 1);
        setbombtimer("A", int((gettime() + 1000) + (level.var_c8a5fbc4 * 1000)));
        if(var_1bc0e62e >= 0) {
          globallogic_audio::leader_dialog("hubOffline", team);
          globallogic_audio::play_2d_on_team("mpl_fracture_sting_powerdown", team);
        }
      }
      wait(level.var_c8a5fbc4);
    }
    var_ad07d7b1 = function_a293cd04(var_1bc0e62e);
    var_12b94c16 = level.cleandeposithubs[var_ad07d7b1];
    var_12b94c16 gameobjects::allow_use("any");
    var_12b94c16 gameobjects::set_visible_team("any");
    var_12b94c16 thread function_9bc55b1b();
    var_12b94c16 spawning::enable_influencers(1);
    var_12b94c16 playLoopSound("mpl_fracture_location_lp");
    foreach(team in level.teams) {
      setmatchflag("bomb_timer_a", 1);
      setbombtimer("A", int((gettime() + 1000) + (level.cleandepositonlinetime * 1000)));
      if(level.var_c8a5fbc4 > 0) {
        globallogic_audio::leader_dialog("hubOnline", team);
      } else if(var_1bc0e62e >= 0) {
        globallogic_audio::leader_dialog("hubMoved", team);
      }
      if(var_1bc0e62e >= 0) {
        globallogic_audio::play_2d_on_team("mpl_fracture_sting_moved", team);
      }
    }
    var_1bc0e62e = var_ad07d7b1;
    wait(level.cleandepositonlinetime);
    var_12b94c16 gameobjects::allow_use("none");
    var_12b94c16 gameobjects::set_visible_team("none");
    var_12b94c16 spawning::enable_influencers(0);
    var_12b94c16 stoploopsound();
    var_12b94c16.baseeffect delete();
    level notify("hash_9c7ac0c3");
  }
}

function function_a293cd04(var_1bc0e62e = -1) {
  switch (level.cleandepositrotation) {
    case 0: {
      return (var_1bc0e62e + 1) % level.cleandeposithubs.size;
    }
    case 1: {
      return function_d844a988(var_1bc0e62e, &function_e458e18d);
    }
  }
  return function_e458e18d(var_1bc0e62e);
}

function function_d844a988(var_1bc0e62e, var_649e0f82) {
  if(var_1bc0e62e < 0) {
    return 0;
  }
  return [[var_649e0f82]](var_1bc0e62e);
}

function function_e458e18d(var_1bc0e62e) {
  if(!isDefined(level.var_642e02f4)) {
    level.var_642e02f4 = [];
  }
  if(level.var_642e02f4.size == 0) {
    for(i = 0; i < level.cleandeposithubs.size; i++) {
      if(i != var_1bc0e62e) {
        level.var_642e02f4[level.var_642e02f4.size] = i;
      }
    }
  }
  var_558db871 = randomint(level.var_642e02f4.size);
  nextindex = level.var_642e02f4[var_558db871];
  arrayremoveindex(level.var_642e02f4, var_558db871);
  return nextindex;
}

function function_d8d5d6ee(var_1bc0e62e) {
  if(var_1bc0e62e < 0) {
    return randomint(level.cleandeposithubs.size);
  }
  nextindex = randomint(level.cleandeposithubs.size - 1);
  if(nextindex >= var_1bc0e62e) {
    nextindex++;
  }
  return nextindex;
}

function hidetimerdisplayongameend() {
  level waittill("game_ended");
  setmatchflag("bomb_timer_a", 0);
}

function function_f6b1cbad(player) {
  time = gettime();
  if((time - player.var_2deb2526) > (0.3 * 1000)) {
    player.var_6963bf0f = 0;
  }
  player.var_2deb2526 = time;
  if(isDefined(player.pers["cleandeposits"])) {
    player.pers["cleandeposits"] = player.pers["cleandeposits"] + 1;
    player.cleandeposits = player.pers["cleandeposits"];
    function_c8e1c6b3(player, self);
  }
  player addplayerstatwithgametype("CLEANDEPOSITS", 1);
  if(level.teamscorepercleandeposit > 0) {
    var_68c00958 = level.teamscorepercleandeposit;
    player globallogic_score::giveteamscoreforobjective(player.team, var_68c00958);
  }
  enemyteam = util::getotherteam(player.team);
  level thread popups::displayteammessagetoteam(&"MP_CLEAN_DEPOSIT", player, player.team);
  level thread popups::displayteammessagetoteam(&"MP_CLEAN_DEPOSIT", player, enemyteam);
  globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_friendly", player.team);
  switch (player.var_6963bf0f) {
    case 0: {
      player playlocalsound("mpl_fracture_deposit_1");
      break;
    }
    case 1: {
      player playlocalsound("mpl_fracture_deposit_2");
      break;
    }
    case 2: {
      player playlocalsound("mpl_fracture_deposit_3");
      break;
    }
    case 3: {
      player playlocalsound("mpl_fracture_deposit_4");
      break;
    }
    default: {
      player playlocalsound("mpl_fracture_deposit_5");
    }
  }
  player.var_6963bf0f++;
  scoreevents::processscoreevent("clean_enemy_deposit", player);
  player.carriedtacos--;
  player clientfield::set_player_uimodel("hudItems.cleanCarryCount", player.carriedtacos);
  player function_65ae6452();
}

function function_c8e1c6b3(player, var_b9fd331) {
  if(!isDefined(player)) {
    return;
  }
  time = gettime();
  player.var_3d64ac00++;
  if(player.var_3d64ac00 == 1) {
    player thread function_aaca5c8e(var_b9fd331);
  } else {
    if(player.var_3d64ac00 == 5) {
      scoreevents::processscoreevent("clean_multi_deposit_normal", player);
    } else if(player.var_3d64ac00 == 10) {
      scoreevents::processscoreevent("clean_multi_deposit_big", player);
      player.var_3d64ac00 = 0;
    }
  }
}

function function_aaca5c8e(var_b9fd331) {
  self endon("death");
  self endon("disconnect");
  level endon("hash_9c7ac0c3");
  self thread function_cde390a2();
  wait(0.1);
  while(true) {
    if(distance2dsquared(self.origin, var_b9fd331.origin) > (90 * 90)) {
      break;
    }
    wait(0.1);
  }
  self.var_3d64ac00 = 0;
}

function function_cde390a2() {
  self endon("death");
  self endon("disconnect");
  level waittill("hash_9c7ac0c3");
  self.var_3d64ac00 = 0;
}

function function_2f8f0719(player, victim) {
  if(!isDefined(player)) {
    return;
  }
  if(victim === player) {
    scoreevents::processscoreevent("clean_own_collect", player);
  } else {
    scoreevents::processscoreevent("clean_friendly_collect", player);
  }
  time = gettime();
  if(!isDefined(player.var_77a1267e)) {
    player.var_77a1267e = [];
  }
  var_bb446529 = time - 3250;
  function_3b21342e(player.var_77a1267e, var_bb446529);
  if(player.var_77a1267e.size >= 4) {
    scoreevents::processscoreevent("clean_multi_deny_tacos", player);
    player.var_77a1267e = undefined;
  } else {
    if(!isDefined(player.var_77a1267e)) {
      player.var_77a1267e = [];
    } else if(!isarray(player.var_77a1267e)) {
      player.var_77a1267e = array(player.var_77a1267e);
    }
    player.var_77a1267e[player.var_77a1267e.size] = time;
  }
}

function function_3b21342e(&times, time_threshold) {
  for(i = 0; i < times.size; i++) {
    if(times[i] < time_threshold) {
      times[i] = 0;
    }
  }
  arrayremovevalue(times, 0);
}

function function_52f9b039(player) {
  if(player.carriedtacos <= 0) {
    objective_clearplayerusing(self.objectiveid, player);
    return 0;
  }
  if(!player.var_2deb2526) {
    return 1;
  }
  return (player.var_2deb2526 + 250) < gettime();
}

function function_9629206a(player) {
  if(self.victimteam == player.team) {
    playsoundatposition("mpl_fracture_enemy_pickup_m", self.origin);
    if(isDefined(player.pers["cleandenies"])) {
      player.pers["cleandenies"] = player.pers["cleandenies"] + 1;
      player.cleandenies = player.pers["cleandenies"];
    }
    player addplayerstatwithgametype("CLEANDENIES", 1);
    function_2f8f0719(player, self.victim);
  } else {
    if(player.carriedtacos >= 10) {
      time = gettime();
      if((time - player.var_f2408e26) > 500) {
        player playlocalsound("mpl_fracture_enemy_pickup_nope");
        if(!isDefined(player.var_741e5451)) {
          player.var_741e5451 = 0;
        }
        player clientfield::set_player_uimodel("hudItems.cleanCarryFull", player.var_741e5451);
        player.var_741e5451 = (player.var_741e5451 ? 1 : 0);
      }
      player.var_f2408e26 = time;
      return;
    }
    player.carriedtacos++;
    player clientfield::set_player_uimodel("hudItems.cleanCarryCount", player.carriedtacos);
    player function_65ae6452();
    if(player.carriedtacos < 4) {
      playsoundatposition("mpl_fracture_enemy_pickup_s", self.origin);
    } else {
      if(player.carriedtacos < 7) {
        playsoundatposition("mpl_fracture_enemy_pickup_m", self.origin);
      } else {
        playsoundatposition("mpl_fracture_enemy_pickup_l", self.origin);
      }
    }
    scoreevents::processscoreevent("clean_enemy_collect", player);
    if(self.attackerteam == player.team && isDefined(self.attacker) && self.attacker != player) {
      scoreevents::processscoreevent("clean_assist_collect", self.attacker);
    }
  }
  self function_8e1efaa2();
}

function function_5d5411e2(attacker, yawangle) {
  dropcount = self.carriedtacos;
  self.carriedtacos = 0;
  self clientfield::set_player_uimodel("hudItems.cleanCarryCount", self.carriedtacos);
  self function_65ae6452();
  dropcount = dropcount + getdvarint("", 0);
  var_cdaa100d = 360 / (dropcount + 1);
  for(i = 0; i < dropcount; i++) {
    taco = function_54bb534d();
    if(!isDefined(taco)) {
      return;
    }
    yawangle = yawangle + var_cdaa100d;
    randomyaw = 0.8 * var_cdaa100d;
    randomyaw = randomfloatrange(randomyaw * -1, randomyaw);
    taco function_992fbc7a(self, attacker, undefined, yawangle + randomyaw);
  }
}