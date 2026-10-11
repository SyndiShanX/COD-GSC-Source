/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\ballmode.gsc
************************************************/

#using script_1a8a97698664c7c9;
#using script_37092055e9712f79;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\teams;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#namespace ballmode;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 0, 0, 9);
    registertimelimitdvar(getgametype(), 480);
    setovertimelimitdvar(120);
    registerscorelimitdvar(getgametype(), 1);
    registerroundlimitdvar(getgametype(), 0);
    registerwinlimitdvar(getgametype(), 5);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
    function_704789086c9ad943(getgametype(), 1);
  }

  setspecialloadout();
  updategametypedvars();
  level.teambased = 1;
  level.vehiclegod = 1;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.onnormaldeath = &onnormaldeath;
  level.ontimelimit = &ontimelimit;
  level.modeonspawnplayer = &onspawnplayer;
  level.onplayerconnect = &onplayerconnect;
  level.bypassclasschoicefunc = &scripts\mp\class::alwaysgamemodeclass;
  level.nosuspensemusic = 1;
  level.requiredplayercountoveride = 1;
  level.requiredplayercount["allies"] = getdvarint(@ "hash_803b34b433ca1a24", 3);
  level.requiredplayercount["axis"] = getdvarint(@ "hash_803b34b433ca1a24", 3);

  if(getdvarint(@ "hash_cd7a289c3a33ceda", 0) != 0) {
    level.onplayerkilled = &onhotfootplayerkilled;
  }

  game["dialog"]["offense_obj"] = "iw9_gmst_anno_uktl_gsoa";
  game["dialog"]["defense_obj"] = "iw9_gmst_anno_uktl_gsoa";
  level.testtdmanywhere = getdvarint(@ "scr_tdmanywhere", 0);
  level.tdmanywhere_dropheight = getdvarfloat(@ "hash_c692d2a11dd6615", 1000);
  level.tdmanywhere_perpenoffset = getdvarfloat(@ "hash_631c58033f43c2dc", 2048);
  level.tdmanywhere_distoffset = getdvarfloat(@ "hash_f314048c87ae28aa", 4092);
  level.var_832f3e2f27bc167f = getdvarint(@ "hash_f4485e63f712eee1", 0);

  if(istrue(level.testtdmanywhere)) {
    scripts\cp_mp\parachute::initparachutedvars();
  }

  if(matchmakinggame()) {
    level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
  }

  level.reinitspawns = &reinitspawns;

  level.var_15c7e6ec178feef1 = 1;
  level.var_227023e744a288b6 = "veh9_atv_boost";
  scripts\engine\utility::registersharedfunc(level.var_227023e744a288b6, "flippedEnd", &function_ac6a3bde1c50bf84);
  namespace_b835d284f1d90ddd::main();
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh9_atv_boost");
  callback::add("player_spawned", &onplayerspawned);
  scripts\engine\utility::add_fx("ball_contact", "vfx/iw9/level/mp_futbol/vfx_futbol_soccerball_contact.vfx");
  scripts\engine\utility::add_fx("ball_contact_pulse", "vfx/iw9/level/mp_futbol/vfx_futbol_soccerball_contact_pulse.vfx");
  scripts\engine\utility::add_fx("grenade_contact", "vfx/iw9/level/mp_futbol/vfx_futbol_pickup_grenade_active.vfx");
  scripts\engine\utility::add_fx("player_rammed", "vfx/iw9/level/mp_futbol/vfx_futbol_atv_ram_explosion.vfx");
  scripts\engine\utility::add_fx("player_respawn", "vfx/iw9/level/mp_futbol/vfx_futbol_atv_ram_respawn.vfx");
  scripts\engine\utility::add_fx("grenade_launch", "vfx/iw9/level/mp_futbol/vfx_futbol_atv_grenade_launch.vfx");
  thread gamemodestates();
  thread function_eae183e660ed1bd();
  thread function_b98a63c3e6f4d6db();
  setDvar(@ "hash_8cf08f678ce293c9", 1);
}

function private function_b98a63c3e6f4d6db() {
  level endon("game_ended");
  delayseconds = getdvarint(@ "hash_72df5f8fcefc0bad", 30);
  wait delayseconds;
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  level.nojip = 1;
}

function private function_9baa17db0bddc192(entity) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid == -1) {
    return;
  }

  offsetheight = 100;
  objective_setlabel(objid, "");
  objective_setplayintro(objid, 0);
  objective_setpings(objid, 1);
  objective_setzoffset(objid, offsetheight);
  objective_icon(objid, "icon_waypoint_enemy_goal");
  objective_setbackground(objid, 1);
  objective_state(objid, "current");
  objective_position(objid, entity.origin + (0, 0, offsetheight));
  objective_setshowdistance(objid, 0);
  scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(objid, entity);
}

function private function_fb4fcf1cecf14944() {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid == -1) {
    return;
  }

  offsetheight = 100;
  objective_setlabel(objid, "");
  objective_setplayintro(objid, 0);
  objective_setpings(objid, 1);
  objective_setzoffset(objid, offsetheight);
  objective_icon(objid, "icon_waypoint_soccer_ball");
  objective_setbackground(objid, 1);
  objective_state(objid, "current");
  objective_onentity(objid, level.ball);
  objective_setshowdistance(objid, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
}

function vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;
  spawndata.vehicleoverride = ter_op(self.team == "axis", "veh9_mil_lnd_atv_physics_mp_boostball_al", "veh9_mil_lnd_atv_physics_mp_boostball_las");
  return spawndata;
}

function function_d7522ff35ba39906() {
  self notify("respawn");
  self.var_ea02a8bfcfde7c4b = 1;
  position = spawnStruct();
  position.origin = self.origin;
  position.angles = self.angles;
  spawndata = vehiclespawn_getspawndata(position);
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(level.var_227023e744a288b6, spawndata);
  vehicle.dontspawnhusk = 1;
  vehicle.godmode = 1;
  vehicle.preventrespawn = 1;
  vehicle.lastpushtime = -1;
  vehicle.rider = self;

  if(level.forceretryonvehicleoccupancyfailed) {
    thread entervehicle(vehicle);
    return;
  }

  entervehicle(vehicle);
}

function entervehicle(vehicle) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  enterdata = spawnStruct();

  if(level.forceretryonvehicleoccupancyfailed) {
    while(!istrue(enterdata.success)) {
      waitframe();
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", self, enterdata, 1);
    }
  } else {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", self, enterdata, 1);
  }

  if(getdvarint(@ "hash_f5e40a9aa678afcd", 0)) {
    vehicle.mtx = "v004";
    vehicle function_788d3c14d6b4ba6b("v004");
  } else if(!isDefined(vehicle.mtx)) {
    if(self.team == "axis") {
      vehicle.mtx = "v008";
      vehicle function_788d3c14d6b4ba6b("v008");
    } else {
      vehicle.mtx = "v009";
      vehicle function_788d3c14d6b4ba6b("v009");
    }
  }

  usepulse = getdvarint(@ "ballmode_pulse", 0);

  if(self.team == "axis") {
    self.vehicle setscriptablepartstate("tail_lights", "green", 1);
  } else {
    self.vehicle setscriptablepartstate("tail_lights", "yellow", 1);
  }

  if(usepulse) {
    thread function_263274274f7871fa();
    thread function_57751ab79abf8f20();
    thread function_72b3e6d160929c0a();
  }

  thread function_c484ebbdf856ffec();

  if(!istrue(level.disableplayeroutlines)) {
    if(istrue(level.useredandblueplayeroutlines)) {
      friendlyteam = "outline_nodepth_blue";
      enemyteam = "outline_nodepth_red";
      scripts\mp\utility\outline::outlineenableforteam(self, self.team, friendlyteam, "level_script", [self]);
      scripts\mp\utility\outline::outlineenableforteam(self.vehicle, self.team, friendlyteam, "level_script", [self]);
      scripts\mp\utility\outline::outlineenableforteam(self, enemyteam(self.team), enemyteam, "level_script");
      scripts\mp\utility\outline::outlineenableforteam(self.vehicle, enemyteam(self.team), enemyteam, "level_script");
    } else {
      teamcolor = scripts\engine\utility::ter_op(self.team == "allies", "outline_nodepth_yellow", "outline_nodepth_green");
      scripts\mp\utility\outline::outlineenableforteam(self, self.team, teamcolor, "level_script", [self]);
      scripts\mp\utility\outline::outlineenableforteam(self.vehicle, self.team, teamcolor, "level_script", [self]);
      scripts\mp\utility\outline::outlineenableforteam(self, enemyteam(self.team), teamcolor, "level_script");
      scripts\mp\utility\outline::outlineenableforteam(self.vehicle, enemyteam(self.team), teamcolor, "level_script");
    }
  }

  thread deleteondisconnect();
  thread listenforvehicleexit(self);
}

function private function_c484ebbdf856ffec() {
  while(!isDefined(level.ball)) {
    waitframe();
  }

  if(istrue(self.pers["lookingAtBall"])) {
    self function_522fb0cbb445cdc8(level.ball);
    self setclientomnvar("ballmode_cameramode", 1);
    self.pers["lookingAtBall"] = 1;
    return;
  }

  self function_522fb0cbb445cdc8();
  self setclientomnvar("ballmode_cameramode", 0);
  self.pers["lookingAtBall"] = 0;
}

function private function_ac6a3bde1c50bf84(vehicle, timedout) {
  if(isDefined(vehicle) && istrue(timedout)) {
    position = vehicle.origin + (0, 0, 100);
    angles = (0, vehicle.angles[1], 0);
    vehicle vehicle_teleport(position, angles);
  }
}

function function_690be95de2e8c072() {
  if(!isDefined(self.pers["lookingAtBall"]) || !isDefined(level.ball) || !isDefined(self.vehicle)) {
    return;
  }

  if(!self.pers["lookingAtBall"]) {
    self function_522fb0cbb445cdc8(level.ball);
    self setclientomnvar("ballmode_cameramode", 1);
    self.pers["lookingAtBall"] = 1;
    return;
  }

  self function_522fb0cbb445cdc8();
  self setclientomnvar("ballmode_cameramode", 0);
  self.pers["lookingAtBall"] = 0;
}

function function_d9702c5b7d3eaa95() {
  self endon("disconnect");
  self notifyonplayercommand("toggleLookAt", "+melee_zoom");

  while(true) {
    self waittill("toggleLookAt");
    function_690be95de2e8c072();
    wait 0.5;
  }
}

function onplayerspawned(params) {
  self.plotarmor = 1;

  if(level.var_832f3e2f27bc167f > 0) {
    level.var_832f3e2f27bc167f -= 1;
    return;
  }

  scripts\mp\battlechatter_mp::disablebattlechatter(self);
  function_d7522ff35ba39906();
  self clearsoundsubmix("iw9_mp_soccer_goal", 1);
  scripts\common\damage_effects::function_a2b4e6088394bade();
  self clearsoundsubmix("iw9_mp_killcam", 2);
  self clearclienttriggeraudiozone(2);
  thread function_cb63e733bd0d9f0b();
  thread function_7331ba007cea2319();
  thread time();
  thread function_d9702c5b7d3eaa95();
  thread function_9e64420982a86219();
  respawnfx = spawnfx(scripts\engine\utility::getfx("player_respawn"), self.origin);
  triggerfx(respawnfx);
  skin = scripts\mp\teams::lookupcurrentoperator(self.team);

  if(skin == "neymar_eastern" || skin == "messi_western" || skin == "pogba_western") {
    self.var_23511319cec8f63 = 1;
  }

  if(self.var_23511319cec8f63 && getdvarint(@ "hash_17a42017d84df7ec", 0)) {
    self playSound("equip_codball_shockstick_pickup");
    self.hasgrenade = 1;
    self setclientomnvar("ballmode_grenade", self.hasgrenade);
  }

  scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(self.pers["goals"])) {
    scripts\mp\utility\stats::setextrascore0(self.pers["goals"]);
  }
}

function time() {
  level endon("game_ended");
  self endon("disconnect");
  self.var_3c11f592093dc36d = 0;

  while(true) {
    waitframe();
    self.var_3c11f592093dc36d += level.framedurationseconds;
  }
}

function function_e1ef76f2cb1b17a1() {
  self endon("disconnect");
  self.isstunned = 1;
  self allowmovement(0);
  self.vehicle setscriptablepartstate("stunned", "stunned", 1);
  self earthquakeforplayer(0.3, 0.6, self.origin, 5000);
  self.vehicle vehicle_settopspeedforward(self.normalspeed * getdvarfloat(@ "hash_1576e2ea08aa2848", 0.8));
  scripts\mp\hud_message::showsplash("ballmode_stunned_by_player");
  wait 1;
  self.vehicle vehicle_settopspeedforward(self.normalspeed);
  self.vehicle setscriptablepartstate("stunned", "not_stunned", 1);
  self allowmovement(1);
  self.isstunned = 0;
}

function function_b81ddb79cb822f7a(var_b81ddb79cb822f7a) {
  if(var_b81ddb79cb822f7a) {
    return;
  }

  self function_d5592214acc99425();
}

function function_9e64420982a86219() {
  self endon("disconnect");
  slot = scripts\mp\equipment::getdefaultslot("equip_shockstick_ballmode");
  scripts\mp\equipment::giveequipment("equip_shockstick_ballmode", slot);
  self notifyonplayercommand("ballmode_preview_grenade", "+attack");
  self notifyonplayercommand("ballmode_throw_grenade", "-attack");

  while(true) {
    self waittill("ballmode_preview_grenade");

    if(!istrue(self.isstunned) && istrue(self.hasgrenade) && isalive(self)) {
      function_b81ddb79cb822f7a(1);
    }

    self waittill("ballmode_throw_grenade");
    function_b81ddb79cb822f7a(0);

    if(istrue(self.isstunned)) {
      waitframe();
      continue;
    }

    if(!istrue(self.hasgrenade)) {
      waitframe();
      continue;
    }

    if(!isalive(self)) {
      waitframe();
      continue;
    }

    var_60151e580078e160 = getdvarfloat(@ "hash_2e6a0a6ee3b2cd6", 40);
    var_f0cde6bba09c4ab6 = getdvarvector(@ "hash_73b69837141ae856", (0, 0, 40));
    var_8367267663479c02 = getdvarfloat(@ "hash_90221071ebbf785e", 1500);
    var_7a65053818ba8fab = getdvarvector(@ "hash_3ea5f4b035285d67", (0, 0, 150));
    self.hasgrenade = 0;
    self setclientomnvar("ballmode_grenade", self.hasgrenade);
    playerangles = anglesToForward(self getplayercameraangles());
    vehicleangles = anglesToForward(self.angles);
    grenadethrowposition = self.vehicle.origin + vehicleangles * var_60151e580078e160 + var_f0cde6bba09c4ab6;

    if(vectordot(playerangles, vehicleangles) < 0) {
      grenadethrowposition = self.vehicle.origin - vehicleangles * var_60151e580078e160 + var_f0cde6bba09c4ab6;
    }

    grenade = scripts\mp\utility\weapon::_launchgrenade("shock_stick_mp_ballmode", grenadethrowposition, playerangles * var_8367267663479c02 + var_7a65053818ba8fab, 1, undefined, undefined);
    self playSound("weap_codball_shockstick_fire");
    triggerfx(spawnfx(scripts\engine\utility::getfx("grenade_launch"), grenadethrowposition));
    grenade waittill_any_timeout_1(5, "missile_stuck");
    position = grenade.origin;
    playFX(getfx("grenade_contact"), position);

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      player earthquakeforplayer(0.3, 0.2, position, 1000);

      if(player.team == self.team) {
        continue;
      }

      if(length(player.origin - position) < 150) {
        player thread function_e1ef76f2cb1b17a1();
        scripts\mp\utility\points::doscoreevent(#"hash_89e428ee14238868");
      }
    }

    waitframe();
    grenade delete();
  }
}

function function_e69ba41ccdf770af(pickuplocation) {
  level endon("game_ended");
  pickup = spawnscriptable("ballmode_grenade_pickup", pickuplocation.origin + (0, 0, 30));
  pickup setscriptablepartstate("grenade_pickup", "ready", 1);

  while(true) {
    playerref = undefined;

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(istrue(player.hasgrenade)) {
        continue;
      }

      if(lengthsquared(player.origin - pickup.origin) < 3600) {
        playerref = player;
        break;
      }
    }

    if(!isDefined(playerref)) {
      waitframe();
      continue;
    }

    pickup setscriptablepartstate("grenade_pickup", "inactive", 1);
    playerref playSound("equip_codball_shockstick_pickup");
    playerref.hasgrenade = 1;
    playerref setclientomnvar("ballmode_grenade", playerref.hasgrenade);
    wait getdvarint(@ "hash_5da7e98d7f5dd03e", 20);
    pickup setscriptablepartstate("grenade_pickup", "ready", 1);
    playsoundatpos(pickuplocation.origin, "equip_codball_shockstick_spawn");
  }
}

function gamemodestates() {
  level endon("game_ended");
  waitframe();
  level.goalaxis = getEnt("goal_axis", "targetname");
  level.goalaxis.team = "axis";
  level.goalallies = getEnt("goal_allies", "targetname");
  level.goalallies.team = "allies";
  level.var_36b1c8c99a6b27ef = getStruct("ball_respawn", "targetname");
  namespace_fbaab9e509f00d3d::setscore(level.goalaxis.team, scripts\mp\gamescore::_getteamscore(level.goalaxis.team));
  namespace_fbaab9e509f00d3d::setscore(level.goalallies.team, scripts\mp\gamescore::_getteamscore(level.goalallies.team));
  pickuplocations = getStructArray("ballmode_pickup", "targetname");
  level thread function_e69ba41ccdf770af(pickuplocations[0]);
  level thread function_e69ba41ccdf770af(pickuplocations[1]);
  level thread function_e69ba41ccdf770af(pickuplocations[2]);
  level thread function_e69ba41ccdf770af(pickuplocations[3]);
  wait 5;
  level.ball = spawn("script_model", level.var_36b1c8c99a6b27ef.origin);
  level.ball setModel("art_stadium_ball");
  level.ball.targetname = "ball";
  level.ball physicslaunchserver((0, 0, 0), (0, 0, 0), -1000);
  level.ball thread function_26a3f9262c0e61c1();
  function_9baa17db0bddc192(level.goalaxis);
  function_9baa17db0bddc192(level.goalallies);
  function_fb4fcf1cecf14944();

  if(isDefined(game["ballmodeTimePassed"])) {
    level.starttime = gettime();
    gamemode = hashcat(@ "scr_", getgametype(), "_timelimit");
    level.watchdvars[gamemode].value = game["ballmodeTimePassed"] / 1000;
    setDvar(gamemode, game["ballmodeTimePassed"] / 1000);
  }

  scoringteam = undefined;

  while(true) {
    if(level.goalaxis istouching(level.ball)) {
      scoringteam = level.goalaxis.team;
      break;
    }

    if(level.goalallies istouching(level.ball)) {
      scoringteam = level.goalallies.team;
      break;
    }

    waitframe();
  }

  level notify("ballmode_goal_scored");
  function_75ca6e1e31fa03a8(scoringteam);

  foreach(player in level.players) {
    player.var_9835cdc5507afa4f = 0;
    player earthquakeforplayer(0.4, 2.5, level.ball.origin, 5000);
    function_d4eaf53b4475969e(player, scoringteam);

    if(player.team == scoringteam) {
      if(isDefined(level.ball.var_9b593f980e1df35b) && player == level.ball.var_9b593f980e1df35b.player) {
        level.ball.var_9b593f980e1df35b.player scripts\mp\utility\points::doscoreevent(#"ballmode_goal_score");
        player scripts\mp\utility\stats::incpersstat("goals", 1);
        player scripts\mp\utility\stats::setextrascore0(player.pers["goals"]);

        if(istrue(level.ball.var_9b593f980e1df35b.var_909dd2932bf61c47)) {
          level.ball.var_9b593f980e1df35b.player scripts\mp\utility\points::doscoreevent(#"hash_622e70d79766b33f");
        }

        player.pers["hasDoneAnyCombat"] = 1;
        continue;
      }

      if(isDefined(level.ball.recentlytouched) && isDefined(level.ball.recentlytouched[player.guid])) {
        player scripts\mp\utility\points::doscoreevent(#"hash_503431be2973fc9b");
        player.pers["hasDoneAnyCombat"] = 1;
        player.pers["assists"] = player.pers["assists"] + 1;
      }

      player scripts\mp\utility\points::doscoreevent(#"hash_7f2b80912012133f");
    }
  }

  scripts\mp\gamelogic::pausetimer();
  game["ballmodeTimePassed"] = scripts\mp\gamelogic::gettimeremaining();
  level.var_18250df1dd55da52 = 1;
  wait 3;
  scripts\mp\gamescore::giveteamscoreforobjective(scoringteam, 1, 1, undefined, 1);
  namespace_fbaab9e509f00d3d::setscore(level.goalaxis.team, scripts\mp\gamescore::_getteamscore(level.goalaxis.team));
  namespace_fbaab9e509f00d3d::setscore(level.goalallies.team, scripts\mp\gamescore::_getteamscore(level.goalallies.team));

  if(game["status"] == "overtime") {
    level thread scripts\mp\gamelogic::endgame(scoringteam, game["end_reason"]["score_limit_reached"]);
    return;
  }

  scripts\mp\gamelogic::pausetimer();
  game["ballmodeTimePassed"] = scripts\mp\gamelogic::gettimeremaining();
}

function function_75ca6e1e31fa03a8(goalteam) {
  if(goalteam == "axis") {
    exploder("goal_2");
  } else {
    exploder("goal_1");
  }

  setmusicstate("goal_scored");
  playsoundatpos(level.ball.origin, "mp_codball_goal_whistle");
  playsoundatpos(level.ball.origin, "mp_codball_goal_cheer");
  thread function_d5fe07f36853c957();
}

function function_d5fe07f36853c957() {
  function_4e8ba327eb12540c(level.players, "iw9_mp_soccer_goal", 2);
}

function function_76d65f0b5902d51d() {
  if(self.lastpulse == 0) {
    return false;
  }

  usingpulse = getdvarint(@ "ballmode_pulse", 0);
  return usingpulse && self.var_3c11f592093dc36d >= self.lastpulse && self.var_3c11f592093dc36d <= self.lastpulse + self.ramtime;
}

function pushball(vehicle, ball, normal, var_efce983b772a6f22, contactposition) {
  if(isDefined(vehicle.lastpushtime) && vehicle.rider.var_3c11f592093dc36d < vehicle.lastpushtime + 0.2) {
    return;
  }

  if(isDefined(vehicle.lastpushtime)) {}

  vehicle.lastpushtime = vehicle.rider.var_3c11f592093dc36d;
  var_76d65f0b5902d51d = function_76d65f0b5902d51d();
  var_745a7280c169244d = 1;
  var_7f6f2ff9dc45ced = 1;

  if(var_76d65f0b5902d51d) {
    var_745a7280c169244d = getdvarint(@ "hash_eb8ae893bdadfa96", 3);
    var_7f6f2ff9dc45ced = var_745a7280c169244d / 2;
  }

  vehiclevelocity = vehicle vehicle_getvelocity();
  ballvelocity = ball.velocity;
  velocitydifference = vehiclevelocity - ballvelocity;
  vehiclespeedramp = math::remap(clamp(length(velocitydifference), 0, 1000), 0, 1000, 0, 1);
  var_eb3b42597661a6ea = math::remap(vehiclespeedramp, 0, 1, 20, 60);
  var_ad3dc842bed328b9 = var_eb3b42597661a6ea * var_7f6f2ff9dc45ced;

  if(ball.velocity[2] > 40) {
    var_ad3dc842bed328b9 /= 3;
  }

  ball physics_applyimpulse(ball.origin, (0, 0, var_ad3dc842bed328b9));
  normal = vectorNormalize((normal[0], normal[1], normal[2] * 0.8));
  var_5a4ed8bed236876a = math::remap(vehiclespeedramp, 0, 1, 100, 600);
  var_9e8d543ba58e308 = normal * var_5a4ed8bed236876a;
  ball physics_applyimpulse(ball.origin, var_9e8d543ba58e308 * var_efce983b772a6f22 * var_745a7280c169244d);

  if(var_76d65f0b5902d51d) {
    playFX(getfx("ball_contact_pulse"), contactposition);
    function_508a666f8c32e510(ball, var_5a4ed8bed236876a, 0, 1);
  } else {
    playFX(getfx("ball_contact"), contactposition);
    function_508a666f8c32e510(ball, var_5a4ed8bed236876a, 0, 0);
  }

  if(var_76d65f0b5902d51d) {
    vehicle.rider earthquakeforplayer(0.3, 0.6, ball.origin, 5000);
    return;
  }

  vehicle.rider earthquakeforplayer(0.15, 0.3, ball.origin, 5000);
}

function function_508a666f8c32e510(ball, ballspeed, hitsurface, pulse) {
  soundprefix = "mp_codball_ball_impact";
  surfacetype = "_grass";
  soundintensity = "_light";
  soundalias = "mp_codball_ball_impact_grass_light";
  lightspeed = 0;
  mediumspeed = 200;
  heavyspeed = 500;

  if(hitsurface > 2 || hitsurface < 0) {
    return;
  }

  switch (hitsurface) {
    case 0:
      surfacetype = "_atv";

      if(pulse) {
        surfacetype = "_atv_pulse";
      }

      break;
    case 1:
      surfacetype = "_grass";
      break;
    case 2:
      surfacetype = "_wall";
      break;
  }

  if(ballspeed >= heavyspeed) {
    soundintensity = "_heavy";
  } else if(ballspeed >= mediumspeed) {
    soundintensity = "_medium";
  }

  soundalias = soundprefix + surfacetype + soundintensity;

  if(isDefined(soundalias) && isDefined(ball)) {
    ball playSound(soundalias);
  }
}

function function_cb63e733bd0d9f0b() {
  self endon("disconnect");

  while(true) {
    if(!isDefined(self.vehicle)) {
      waitframe();
      continue;
    }

    self.vehicle waittill("collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum);

    if(!isDefined(ent) || !isDefined(ent.owner)) {
      continue;
    }

    if(isDefined(ent.targetname) && ent.targetname == "ball") {
      pushball(self.vehicle, ent, normal, 1, position);
      continue;
    }

    isentityvehicle = isDefined(ent) && ent.classname == "script_vehicle";
    var_9da4991e43437a9e = isDefined(ent.owner) && ent.owner.team == self.team;

    if(isentityvehicle && !var_9da4991e43437a9e && istrue(self.var_9835cdc5507afa4f)) {
      collisiondirection = vectorNormalize(position - self.vehicle.origin);
      var_f00cad494ace11f1 = vectorNormalize(anglesToForward(self.vehicle.angles));
      dotproduct = vectordot(collisiondirection, var_f00cad494ace11f1);
      var_d23ed04594864bea = acos(dotproduct);

      if(var_d23ed04594864bea < 60) {
        if(!isDefined(self.var_a9bcf4e8440e11be["ballmode_rammed_player"]) || gettime() - self.var_a9bcf4e8440e11be["ballmode_rammed_player"] > 100) {
          scripts\mp\utility\points::doscoreevent(#"ballmode_rammed_player");
          self.var_a9bcf4e8440e11be["ballmode_rammed_player"] = gettime();
        }

        self.pers["hasDoneAnyCombat"] = 1;
        self.pers["lastRamTime"] = scripts\mp\teams::function_19300abfbb10928b();
        ent.owner function_b81ddb79cb822f7a(0);
        ent.owner.plotarmor = 0;
        ent.owner dodamage(ent.owner.maxhealth, ent.owner.origin, self, self.vehicle, "MOD_EXPLOSIVE", self.vehicle.objweapon, "torso_upper");
        ent.owner scripts\mp\hud_message::showsplash("ballmode_rammed_by_player");
        explosionfx = spawnfx(scripts\engine\utility::getfx("player_rammed"), ent.origin);
        playsoundatpos(ent.origin, "veh9_dmg_mil_lnd_atv_codball_explode");
        triggerfx(explosionfx);
        playrumbleonposition("grenade_rumble", ent.origin);
        earthquake(0.5, 1, ent.origin, 500);
      }
    }
  }
}

function function_26a3f9262c0e61c1() {
  level endon("game_ended");
  var_63ab34b4a76e8f86 = 0.1;
  var_7856e907f2d37675 = 1;
  var_64f13c589a594107 = 3;
  var_38f5340b182b64f0 = 0;
  var_653bf22a4d053b24 = 0;
  var_4be5096ca36000af = 200;
  var_c59ce7533110caff = 500;
  hitsurfacetype = 1;
  grasssurfacetype = 1;
  wallsurfacetype = 2;
  self physics_registerforcollisioncallback();

  while(true) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum);
    surface = physics_getsurfacetypefromflags(flag1);
    surfacetype = getsubstr(surface["name"], 9);

    if(normalspeed > var_63ab34b4a76e8f86 && surfacetype != "metal_car") {
      if(normalspeed > var_64f13c589a594107) {
        var_38f5340b182b64f0 = var_c59ce7533110caff;
      } else if(normalspeed > var_7856e907f2d37675) {
        var_38f5340b182b64f0 = var_4be5096ca36000af;
      } else {
        var_38f5340b182b64f0 = var_653bf22a4d053b24;
      }

      hitsurfacetype = grasssurfacetype;

      if(surfacetype != "grass_short") {
        hitsurfacetype = wallsurfacetype;
      }

      function_508a666f8c32e510(self, var_38f5340b182b64f0, hitsurfacetype, 0);
      waitframe();
    }
  }
}

function vectorproject(v, onto) {
  return vectordot(v, onto) / vectordot(onto, onto);
}

function function_7331ba007cea2319() {
  self endon("disconnect");

  while(true) {
    if(!isDefined(level.ball)) {
      waitframe();
      continue;
    }

    if(!isDefined(self.vehicle)) {
      waitframe();
      continue;
    }

    toball = level.ball.origin - self.vehicle.origin;
    normal = vectorNormalize(toball);
    forward = anglesToForward(self.vehicle.angles);
    left = anglestoleft(self.vehicle.angles);
    up = anglestoup(self.vehicle.angles);
    forwarddot = vectorproject(toball, forward * 90);
    leftdot = vectorproject(toball, left * 60);
    updot = vectorproject(toball, up * 85);
    var_11fa10620a425b56 = sqrt(forwarddot * forwarddot + leftdot * leftdot + updot * updot);

    if(var_11fa10620a425b56 < 1) {
      if(!isDefined(level.ball.recentlytouched)) {
        level.ball.recentlytouched = [];
      }

      if(!isDefined(level.ball.recentlytouched[self.guid])) {
        scripts\mp\utility\points::doscoreevent(#"hash_f87dedf6aa32e256");
        level.ball.recentlytouched[self.guid] = self;
      }

      if(istrue(self.var_9835cdc5507afa4f)) {
        if(!isDefined(self.var_a9bcf4e8440e11be["ballmode_rammed_ball"]) || gettime() - self.var_a9bcf4e8440e11be["ballmode_rammed_ball"] > 100) {
          scripts\mp\utility\points::doscoreevent(#"ballmode_rammed_ball");
          self.var_a9bcf4e8440e11be["ballmode_rammed_ball"] = gettime();
        }
      }

      self.pers["hasDoneAnyCombat"] = 1;
      self.pers["lastTouchTime"] = scripts\mp\teams::function_19300abfbb10928b();
      goalent = undefined;

      if(self.team == "allies") {
        goalent = level.goalaxis;
      } else {
        goalent = level.goalallies;
      }

      if(isDefined(goalent) && (!isDefined(level.ball.var_9b593f980e1df35b) || level.ball.var_9b593f980e1df35b != self)) {
        var_579b57f0f6ff2cf2 = goalent.origin - level.ball.origin;
        var_e5b0ec0e97542a26 = length(var_579b57f0f6ff2cf2);
        var_474316929ff377fe = vectordot(level.ball.velocity, var_579b57f0f6ff2cf2);

        if(var_e5b0ec0e97542a26 <= 500 && var_474316929ff377fe > 0) {
          velocitynormalized = vectorNormalize(level.ball.velocity);
          traceto = level.ball.origin + velocitynormalized * var_e5b0ec0e97542a26;
          trace = scripts\engine\trace::sphere_trace(level.ball.origin, traceto, 28, [self, self.vehicle, level.ball]);

          if(trace["fraction"] > 0.99) {
            thread function_3ea35b42c5e9419e();
          }
        }
      }

      var_9b593f980e1df35b = spawnStruct();
      var_9b593f980e1df35b.player = self;

      if(forwarddot < 0) {
        velocity = self.vehicle vehicle_getvelocity();

        if(vectordot(velocity, forward) < 0) {
          var_9b593f980e1df35b.var_909dd2932bf61c47 = 1;
        }
      }

      level.ball.var_9b593f980e1df35b = var_9b593f980e1df35b;
      thread function_53eb14eedd8c8cf8();
      pushball(self.vehicle, level.ball, normal, 1, level.ball.origin);
    }

    waitframe();
  }
}

function private function_53eb14eedd8c8cf8() {
  self notify("ballmode_watch_for_assist");
  level endon("game_ended");
  self endon("disconnect");
  self endon("ballmode_watch_for_assist");
  wait level.assisttouchtime;
  level.ball.recentlytouched[self.guid] = undefined;
}

function private function_3ea35b42c5e9419e() {
  self notify("ballmode_watch_for_save");
  level endon("game_ended");
  level endon("ballmode_goal_scored");
  self endon("disconnect");
  self endon("ballmode_watch_for_save");
  wait 1;
  scripts\mp\utility\points::doscoreevent(#"hash_24ea0be5efec97c5");
  self.pers["hasDoneAnyCombat"] = 1;
}

function function_263274274f7871fa() {
  self endon("disconnect");
  self endon("respawn");
  level endon("game_ended");
  self.lastpulse = 0;
  self.nitro = 100;
  self.ramtime = getdvarint(@ "hash_8839756ee5e73455", 1);
  self.normalspeed = getdvarint(@ "hash_b41aec456a71399a", 35);
  fastspeed = getdvarint(@ "hash_b8ee638db3d40fa6", 50);
  var_c02646f657bd26c0 = getdvarfloat(@ "hash_b7615c14184146dd", 8);

  if(self.var_23511319cec8f63 && getdvarint(@ "hash_bea2f654590e1855", 0)) {
    var_c02646f657bd26c0 = getdvarint(@ "hash_bea2f654590e1855", 0);
  }

  if(self.var_23511319cec8f63 && getdvarint(@ "hash_21590fe81942ff74", 0)) {
    self.normalspeed = getdvarint(@ "hash_21590fe81942ff74", 0);
  }

  self.vehicle setscriptablepartstate("pulse", "default", 1);
  vfxready = 0;
  self.vehicle vehicle_settopspeedforward(self.normalspeed);

  while(true) {
    if(!isDefined(self.vehicle)) {
      waitframe();
      continue;
    }

    if(!scripts\mp\flags::gameflag("prematch_done")) {
      waitframe();
      continue;
    }

    if(istrue(self.isstunned)) {
      waitframe();
      continue;
    }

    self.nitro += var_c02646f657bd26c0 * level.framedurationseconds;

    if(self.nitro > 100) {
      self.nitro = 100;
    }

    self setclientomnvar("ballmode_pulse_recharge", self.nitro / 100);

    if(self.nitro >= 100) {
      if(!vfxready) {
        self.vehicle setscriptablepartstate("pulse", "pulse_ready", 1);
        self playlocalsound("mp_codball_pulse_ready_plr");
        self playSound("mp_codball_pulse_ready_npc", self, self);
        vfxready = 1;
      }

      if(self jumpbuttonPressed()) {
        self.nitro = 0;
        self setclientomnvar("ballmode_pulse_recharge", self.nitro / 100);
        self.lastpulse = self.var_3c11f592093dc36d;
        self.var_5018479a0f0ca9c2 = self.atmaxspeed;
        vfxready = 0;
        self.vehicle vehicle_settopspeedforward(fastspeed);
        self.vehicle setscriptablepartstate("pulse", "pulsing", 1);
        self playlocalsound("mp_codball_pulse_plr");
        self playSound("mp_codball_pulse_npc", self, self);
        self earthquakeforplayer(0.15, 0.5, self.origin, 5000);
        scripts\mp\utility\points::doscoreevent(#"ballmode_pulse");
        self.pers["hasDoneAnyCombat"] = 1;

        for(x = 0; x < 5; x++) {
          self.vehicle vehphys_impulse(anglesToForward(self.vehicle.angles), 55, 0);
          wait 0.1;

          if(!isDefined(self.vehicle)) {
            break;
          }
        }

        wait 0.5;

        if(!isDefined(self.vehicle)) {
          break;
        }

        self.vehicle vehicle_settopspeedforward(self.normalspeed);
        self.vehicle setscriptablepartstate("pulse", "default", 1);
      }
    }

    waitframe();
  }
}

function function_57751ab79abf8f20() {
  self endon("disconnect");
  self endon("respawn");
  self.vehicle setscriptablepartstate("max_speed", "default", 1);
  playingmaxspeed = 0;
  self.atmaxspeed = 0;
  maxspeedtime = 0;

  while(true) {
    if(!isDefined(self.vehicle)) {
      waitframe();
      continue;
    }

    velocity = self.vehicle vehicle_getvelocity();

    if(length(velocity) > 530 && vectordot(anglesToForward(self.vehicle.angles), velocity) > 0) {
      self.atmaxspeed = 1;

      if(!playingmaxspeed) {
        playingmaxspeed = 1;

        if(getdvarint(@ "hash_3d45b5bad11c6ff1", 1)) {
          self.vehicle setscriptablepartstate("max_speed", "max_speed", 1);
        }
      }
    }

    if(length(velocity) < 100) {
      if(playingmaxspeed) {
        playingmaxspeed = 0;
        self.vehicle setscriptablepartstate("max_speed", "default", 1);
        self.atmaxspeed = 0;
      }
    }

    waitframe();
    maxspeedtime += level.framedurationseconds;

    if(maxspeedtime >= 0.25) {
      maxspeedtime -= 0.25;

      if(!self.atmaxspeed) {
        if(playingmaxspeed) {
          playingmaxspeed = 0;
          self.vehicle setscriptablepartstate("max_speed", "default", 1);
        }
      }

      self.atmaxspeed = 0;
    }
  }
}

function function_72b3e6d160929c0a() {
  self endon("disconnect");
  self endon("respawn");
  self.var_9835cdc5507afa4f = 0;
  self.vehicle setscriptablepartstate("ramming", "default", 1);

  while(true) {
    if(!isDefined(self.vehicle)) {
      waitframe();
      continue;
    }

    var_76d65f0b5902d51d = function_76d65f0b5902d51d();

    if(!var_76d65f0b5902d51d) {
      waitframe();
      continue;
    }

    if(istrue(self.var_5018479a0f0ca9c2)) {
      self.vehicle setscriptablepartstate("ramming", "ramming", 1);

      if(!istrue(level.var_18250df1dd55da52)) {
        self.var_9835cdc5507afa4f = 1;
      }
    }

    wait self.ramtime;
    self.vehicle setscriptablepartstate("ramming", "default", 1);
    self.var_9835cdc5507afa4f = 0;
    waitframe();
  }
}

function private listenforvehicleexit(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");

  if(!istrue(level.listenforvehicleexit)) {
    return;
  }

  while(isDefined(player.vehicle) && !istrue(player.vehicle.isdestroyed)) {
    waitframe();
  }

  player.plotarmor = 0;
  player dodamage(player.maxhealth, player.origin);
}

function deleteondisconnect() {
  level endon("game_ended");
  self endon("respawn");
  previousvehicle = self.vehicle;
  self waittill("death_or_disconnect");
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(previousvehicle, "driver", self);
  scripts\cp_mp\vehicles\vehicle::vehicle_death(previousvehicle);
}

function function_eae183e660ed1bd(ball) {
  while(true) {
    if(isDefined(level.ball) && isDefined(level.ball.origin)) {
      if(!isDefined(level.ball.oldorigin)) {
        level.ball.oldorigin = level.ball.origin;
      }

      level.ball.velocity = (level.ball.origin - level.ball.oldorigin) / level.framedurationseconds;
      level.ball.oldorigin = level.ball.origin;
    }

    waitframe();
  }
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_6e7da31aae47b8e0", 0);
  registerhalftimedvar(getgametype(), 0);
  setdynamicdvar(@ "hash_bb6e8f8d9be104f4", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");
  level.scorelimitoverride = 1;
  level.roundenddelay = 3;

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/WAR");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/WAR_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/WAR_HINT");
  }

  if(isDefined(level.initspawnsoverridefunc)) {
    [[level.initspawnsoverridefunc]]();
  } else {
    initspawns();
  }

  scripts\mp\gametypes\bradley_spawner::inittankspawns();

  if(getdvarint(@ "hash_cd7a289c3a33ceda", 0) != 0) {
    thread monitorhotfoot();
  }

  thread function_8469a5927d069db7();

  if(false) {
    function_bf2918399f1800b1();
  }
}

function updategametypedvars() {
  level.postgoalcooldown = dvarintvalue("postGoalCooldown", 8, 0, 10);
  level.assisttouchtime = dvarintvalue("assistTouchTime", 10, 0, 30);
  level.disableplayeroutlines = dvarintvalue("disablePlayerOutlines", 0, 0, 1);
  level.useredandblueplayeroutlines = dvarintvalue("useRedAndBluePlayerOutlines", 0, 0, 1);
  level.useredandbluegoalscoresplashes = dvarintvalue("useRedAndBlueGoalScoreSplashes", 1, 0, 1);
  level.useteamnamesongoalscoresplashes = dvarintvalue("useTeamNamesOnGoalScoreSplashes", 0, 0, 1);
  level.forceretryonvehicleoccupancyfailed = dvarintvalue("forceRetryOnVehicleOccupancyFailed", 1, 0, 1);
  level.listenforvehicleexit = dvarintvalue("listenForVehicleExit", 1, 0, 1);
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else if(getdvarint(@ "t10", 0) > 0) {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  } else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Frontline");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  spawns = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", spawns);
  scripts\mp\spawnlogic::registerspawnset("fallback", spawnssecondary);

  if(istrue(level.testtdmanywhere)) {
    x = getdvarfloat(@ "hash_b6294c84c04e377b", randomfloatrange(-4096, 4096));
    y = getdvarfloat(@ "hash_b6294b84c04e3548", randomfloatrange(-4096, 4096));
    z = getdvarfloat(@ "hash_b6294e84c04e3be1", randomfloatrange(0, 512));
    level.mapcenter = (x, y, z);
    tdmanywhere_debugshowlocs();
    return;
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function reinitspawns() {
  scripts\mp\spawnlogic::function_8390bf8c3b74466a("<dev string:x1c>");
  scripts\mp\spawnlogic::function_8390bf8c3b74466a("<dev string:x26>");
  spawns = scripts\mp\spawnlogic::getspawnpointarray("<dev string:x32>");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("<dev string:x42>");
  scripts\mp\spawnlogic::registerspawnset("<dev string:x1c>", spawns);
  scripts\mp\spawnlogic::registerspawnset("<dev string:x26>", spawnssecondary);
}

function getspawnpoint() {
  spawnteam = self.pers["team"];
  spawnpoint = undefined;

  if(spawnteam == game["attackers"]) {
    scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
  } else {
    scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
  }

  return spawnpoint;
}

function onspawnplayer(revivespawn) {
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill");

  if(!istrue(level.testtdmanywhere)) {
    return;
  }

  self setplayerangles(vectortoangles(level.mapcenter - self.origin));
}

function spawncompare(spawnpoint, spawnteam) {
  if(getdvarint(@ "hash_b5ceec3e3cb419be") != 0) {
    spawnpoints = scripts\mp\spawnlogic::getteamspawnpoints(spawnteam);
    fallbackspawnpoints = [];
    scriptspawnpoint = scripts\mp\spawnscoring::getspawnpoint_legacy(spawnpoints, fallbackspawnpoints);

    if(!isDefined(level.var_3d292942d52b104a)) {
      level.var_3d292942d52b104a = 0;
      level.var_2dc7108159dc1da3 = 0;
      level.var_a065445ba781ddf6 = 0;
    }

    level.var_3d292942d52b104a++;
    println("<dev string:x5c>" + scriptspawnpoint.index + "<dev string:x77>" + scriptspawnpoint.totalscore);

    if(scriptspawnpoint.index == spawnpoint.index) {
      level.var_2dc7108159dc1da3++;
      iprintlnbold("<dev string:x8d>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:xac>" + "<dev string:xba>" + level.var_2dc7108159dc1da3 + "<dev string:xbf>" + level.var_3d292942d52b104a);
    } else {
      level.var_a065445ba781ddf6++;
      iprintlnbold("<dev string:xc4>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:xac>" + "<dev string:xba>" + level.var_2dc7108159dc1da3 + "<dev string:xbf>" + level.var_3d292942d52b104a);
    }

    return scriptspawnpoint;
  }
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  scripts\mp\gametypes\common::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

function ontimelimit() {
  winner = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime") {
    level thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(winner == "tie") {
    foreach(player in level.players) {
      player scripts\mp\hud_message::showsplash("ballmode_overtime_banner");
    }

    game["status"] = "overtime";
    level.starttime = gettime();
    gamemode = hashcat(@ "scr_", getgametype(), "_timelimit");
    level.watchdvars[gamemode].value = getdvarint(@ "overtimelimit");
    setDvar(gamemode, getdvarint(@ "overtimelimit"));
    return;
  }

  level thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["time_limit_reached"]);
}

function function_8469a5927d069db7() {
  self endon("<dev string:xf4>");

  while(true) {
    if(getdvarint(@ "hash_46a6b424af6acbc2") != 0) {
      points = getdvarint(@ "hash_46a6b424af6acbc2");

      if(points == -1) {
        points = getdvarint(@ "scr_war_scorelimit") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x102>", points, 0);
      break;
    } else if(getdvarint(@ "hash_86e14326e43c0115") != 0) {
      points = getdvarint(@ "hash_86e14326e43c0115");

      if(points == -1) {
        points = getdvarint(@ "scr_war_scorelimit") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x10c>", points, 0);
      break;
    }

    wait 1;
  }

  setdevdvar(@ "hash_46a6b424af6acbc2", 0);
  setdevdvar(@ "hash_86e14326e43c0115", 0);
  thread function_8469a5927d069db7();
}

function function_bf2918399f1800b1() {
  wait 5;
  ents = getEntArray("<dev string:x114>", "<dev string:x122>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  ents = getEntArray("<dev string:x137>", "<dev string:x122>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:x114>", "<dev string:x122>");

  foreach(struct in structs) {
    thread scripts\mp\utility\debug::drawsphere(struct.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:x137>", "<dev string:x122>");

  foreach(struct in structs) {
    thread scripts\mp\utility\debug::drawsphere(struct.origin, 64, 1000, (0, 1, 0));
  }
}

function tdmanywhere_debugshowlocs() {
  thread scripts\mp\utility\debug::drawsphere(level.mapcenter, 128, 100, (0, 1, 0));

  if(!isDefined(level.tdmanywherefrontline)) {
    waitframe();
  }

  var_cc015915d647fbdf = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
  var_c1d9d45c8845eb82 = level.tdmanywherefrontline.anchorrt * level.tdmanywhere_perpenoffset;
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter + var_cc015915d647fbdf, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter - var_cc015915d647fbdf, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + var_cc015915d647fbdf, level.mapcenter + var_cc015915d647fbdf + var_c1d9d45c8845eb82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + var_cc015915d647fbdf, level.mapcenter + var_cc015915d647fbdf - var_c1d9d45c8845eb82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - var_cc015915d647fbdf, level.mapcenter - var_cc015915d647fbdf + var_c1d9d45c8845eb82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - var_cc015915d647fbdf, level.mapcenter - var_cc015915d647fbdf - var_c1d9d45c8845eb82, 1000, (0, 0, 1));
}

function enemyteam(friendlyteam) {
  if(friendlyteam == "allies") {
    return "axis";
  }

  return "allies";
}

function monitorhotfoot() {
  level endon("game_ended");
  level.outlinedplayers = [];
  level.hotfootabsloops = 0;
  timepassed = 0;
  scripts\mp\flags::gameflagwait("prematch_done");

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player.hotfootlastposition)) {
        player.hotfootdisttraveledsq = 0;
        player.hotfootlastposition = player.origin;
        player.abshotfootlastposition = player.origin;
      }

      player.hotfootdisttraveledsq += distancesquared(player.hotfootlastposition, player.origin);
      player.hotfootlastposition = player.origin;
    }

    timepassed += level.framedurationseconds;

    if(timepassed > 3) {
      if(level.hotfootabsloops >= 2) {
        level.hotfootabsloops = 0;

        foreach(player in level.players) {
          if(!isDefined(player.abshotfootlastposition)) {
            player.abshotfootlastposition = player.origin;
          }

          player.forceabshotfoot = distancesquared(player.abshotfootlastposition, player.origin) < 4225;
          player.abshotfootlastposition = player.origin;
        }
      }

      foreach(player in level.players) {
        entnum = player getentitynumber();
        friendlyteam = player.pers["team"];
        enemyteam = enemyteam(friendlyteam);

        if(isalive(player) && (istrue(player.forceabshotfoot) || player.hotfootdisttraveledsq < 4225 && !istrue(player.hotfootreset))) {
          if(istrue(player.forceabshotfoot)) {
            player iprintlnbold("<dev string:x14d>");
          } else {
            player iprintlnbold("<dev string:x15d>");
          }

          player.forceabshotfoot = 0;

          if(!isDefined(level.outlinedplayers[entnum])) {
            level.outlinedplayers[entnum] = player;
            player.outlineidfriend = outlineenableforteam(player, friendlyteam, "outline_nodepth_orange", "level_script");
            player.outlineidenemy = outlineenableforteam(player, enemyteam, "outline_nodepth_red", "level_script");
            player scripts\mp\utility\outline::_hudoutlineviewmodelenable("outlinefill_nodepth_orange", 0);
          }
        } else {
          if(isalive(player)) {
            player.hotfootreset = 0;
          }

          player.forceabshotfoot = 0;

          if(isDefined(level.outlinedplayers[entnum])) {
            outlinedisable(player.outlineidfriend, player);
            outlinedisable(player.outlineidenemy, player);
            player scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
            player.outlineidfriend = undefined;
            player.outlineidenemy = undefined;
            level.outlinedplayers[entnum] = undefined;
          }
        }

        player.hotfootdisttraveledsq = 0;
      }

      timepassed = 0;
    }

    level.hotfootabsloops++;
    waitframe();
  }
}

function onhotfootplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  entnum = self getentitynumber();

  if(isDefined(level.outlinedplayers[entnum])) {
    outlinedisable(self.outlineidfriend, self);
    outlinedisable(self.outlineidenemy, self);
    self.outlineidfriend = undefined;
    self.outlineidenemy = undefined;
    level.outlinedplayers[entnum] = undefined;
  }

  self.hotfootreset = 1;
}

function shouldgamelobbyremainintact() {
  axisscore = int(game["teamScores"]["axis"]);
  alliesscore = int(game["teamScores"]["allies"]);
  differential = axisscore - alliesscore;
  return differential < 10;
}

function onplayerconnect(player) {
  player scripts\mp\class::function_a16868d4dcd81a4b();
  player.pers["gamemodeLoadout"] = level.var_d4867c54e1ae2315;
  player allowspectateallteams(0);
  player.var_a9bcf4e8440e11be = [];
  player.var_23511319cec8f63 = 0;
}

function setspecialloadout() {
  level.var_d4867c54e1ae2315["loadoutPrimary"] = "iw9_me_fists";
  level.var_d4867c54e1ae2315["loadoutPrimaryAttachment"] = "none";
  level.var_d4867c54e1ae2315["loadoutPrimaryAttachment2"] = "none";
  level.var_d4867c54e1ae2315["loadoutPrimaryCamo"] = "none";
  level.var_d4867c54e1ae2315["loadoutPrimaryReticle"] = "none";
  level.var_d4867c54e1ae2315["loadoutPrimaryVariantID"] = 0;
  level.var_d4867c54e1ae2315["loadoutSecondary"] = "none";
  level.var_d4867c54e1ae2315["loadoutSecondaryAttachment"] = "none";
  level.var_d4867c54e1ae2315["loadoutSecondaryAttachment2"] = "none";
  level.var_d4867c54e1ae2315["loadoutSecondaryCamo"] = "none";
  level.var_d4867c54e1ae2315["loadoutSecondaryReticle"] = "none";
  level.var_d4867c54e1ae2315["loadoutSecondaryVariantID"] = 0;
  level.var_d4867c54e1ae2315["loadoutEquipment"] = "specialty_null";
  level.var_d4867c54e1ae2315["loadoutOffhand"] = "none";
  level.var_d4867c54e1ae2315["loadoutStreakType"] = "assault";
  level.var_d4867c54e1ae2315["loadoutKillstreak1"] = "none";
  level.var_d4867c54e1ae2315["loadoutKillstreak2"] = "none";
  level.var_d4867c54e1ae2315["loadoutKillstreak3"] = "none";
  level.var_d4867c54e1ae2315["loadoutPerks"] = [];
  level.var_d4867c54e1ae2315["loadoutGesture"] = "playerData";
}

function private function_d4eaf53b4475969e(player, scoringteam) {
  if(!isDefined(player) || !isDefined(player.team) || !isDefined(scoringteam)) {
    return;
  }

  teamname = undefined;
  teamcolor = undefined;

  if(level.useteamnamesongoalscoresplashes) {
    teamname = scoringteam;
  } else if(player.team == scoringteam) {
    teamname = "friendly";
  } else {
    teamname = "enemy";
  }

  if(!level.useredandbluegoalscoresplashes) {
    teamcolor = scripts\engine\utility::ter_op(scoringteam == "allies", "yellow", "green");
  } else if(player.team == scoringteam) {
    teamcolor = "blue";
  } else {
    teamcolor = "red";
  }

  splashname = scripts\engine\utility::string_join(["ballmode_goal_score", teamname, teamcolor], "_");
  player scripts\mp\hud_message::showsplash(splashname);
}