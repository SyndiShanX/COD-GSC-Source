/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\dropkick.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_3d703ef87a841fe4;
#using script_44b0b8420eabacad;
#using scripts\core_common\armor;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\mp\uav;
#using scripts\killstreaks\recon_plane;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;
#namespace dropkick;

function event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  util::registerroundscorelimit(0, 10000);
  level.takelivesondeath = 1;
  level.var_8abcfbb8 = max(getgametypesetting(#"capturetime"), 0.1);
  level.carryscore = getgametypesetting(#"carryscore");
  level.var_6ecc0fa6 = isDefined(getgametypesetting(#"idleflagresettime")) ? getgametypesetting(#"idleflagresettime") : 0;
  level.var_ce802423 = 1;
  level.dropkickcarrierarmor = isDefined(getgametypesetting(#"dropkickcarrierarmor")) ? getgametypesetting(#"dropkickcarrierarmor") : 0;
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.onspawnspectator = &onspawnspectator;
  level.onscorelimit = &onscorelimit;
  player::function_3c5cc656(&function_610d3790);
  player::function_cf3aa03d(&onplayerkilled);
  level.player_team_mask = getteammask(#"allies");
  level.enemy_team_mask = getteammask(#"axis");
  spawning::addsupportedspawnpointtype("dropkick");
  spawning::addsupportedspawnpointtype("tdm");
  spawning::function_32b97d1b(&spawning::function_90dee50d);
  spawning::function_adbbb58a(&spawning::function_c24e290c);
  clientfield::register("world", "" + # "hash_69d32ac298f2aa22", 1, 2, "int");
  level.var_2ee800c8 = "dropkickNearWinning";
  level.var_78739954 = "dropkickNearLosing";
}

function onstartgametype() {
  level thread onscoreclosemusic();
  function_2f873f5e();
  function_4e92a5e8();
}

function onscorelimit() {
  if(level.var_f2a67a5d === 1) {
    return;
  }

  level notify(#"score_limit_reached");
  level.var_f2a67a5d = 1;
  function_b256c6a7();
  winner = teams::function_ef80de99();
  thread globallogic_audio::leader_dialog("dropkickGameWon", winner);
  thread globallogic_audio::leader_dialog_for_other_teams("dropkickGameLost", winner);
  level thread end_round();
}

function end_round() {
  level childthread function_1a67afed();
  level childthread function_f7c2fc80();
  level childthread function_86ca9275();
  level childthread function_311e397d();
  level childthread function_68f13f40();
  music::setmusicstate("dropkick_round_end");
  playsoundatposition(#"hash_31f07589beb0a02e", (0, 0, 0));
  wait 11;
  globallogic_defaults::default_onscorelimit();
}

function function_610d3790(einflictor, victim, idamage, weapon) {
  if(level.var_f2a67a5d === 1) {
    return;
  }

  attacker = self;

  if(!isPlayer(attacker) || !isPlayer(idamage) || attacker.pers[#"team"] === idamage.pers[#"team"]) {
    return;
  }

  if(attacker === level.var_1d402358 || idamage === level.var_1d402358) {
    attacker challenges::function_2f462ffd(idamage, weapon, victim, level.var_bb695b91);
    attacker.pers[#"objectiveekia"]++;
    attacker.objectiveekia = attacker.pers[#"objectiveekia"];
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(level.var_f2a67a5d === 1) {
    return;
  }

  victim = self;

  if(!isPlayer(shitloc) || !isPlayer(victim) || shitloc.pers[#"team"] === victim.pers[#"team"]) {
    return;
  }

  if(shitloc === level.var_1d402358) {
    scoreevents::processscoreevent(#"hash_487edfe4eab89682", shitloc, victim, deathanimduration);

    if(weapons::ismeleemod(psoffsettime)) {
      scoreevents::processscoreevent(#"hash_18b5a81700734b76", shitloc, victim, deathanimduration);
    }

    if(!isDefined(level.var_13faac26)) {
      level.var_13faac26 = 0;
    }

    level.var_13faac26++;

    if(level.var_13faac26 == 5) {
      scoreevents::processscoreevent(#"hash_6926a7955b525980", shitloc, victim, deathanimduration);
    }

    return;
  }

  if(victim === level.var_1d402358) {
    level.var_d0bebb68 = shitloc;
    scoreevents::processscoreevent(#"hash_2fa5091c22f8e529", shitloc, victim, deathanimduration);
    return;
  }

  if(isDefined(level.var_1d402358) && isalive(level.var_1d402358) && shitloc.team === level.var_1d402358.team) {
    if(isDefined(level.var_1d402358.attackerdata) && isDefined(victim.clientid)) {
      if(isDefined(level.var_1d402358.attackerdata[victim.clientid])) {
        scoreevents::processscoreevent(#"hash_576110aaf8aa4c5", shitloc, victim, deathanimduration);
      }
    }

    if(distance2dsquared(shitloc.origin, level.var_1d402358.origin) < level.defaultoffenseradiussq) {
      scoreevents::processscoreevent(#"hash_13fa27ec1b3826b5", shitloc, victim);
    }
  }
}

function onspawnplayer(predictedspawn) {
  if(spawning::usestartspawns() && !level.ingraceperiod && !level.playerqueuedrespawn) {
    spawning::function_7a87efaa();
  }

  spawning::onspawnplayer(predictedspawn);
}

function onspawnspectator(origin, angles) {
  if(!self mayspawn()) {
    hud_message::setlowermessage(#"hash_366993465c98de65");
  }

  globallogic_defaults::default_onspawnspectator(origin, angles);
}

function private function_2f873f5e() {
  if(level.waverespawndelay) {
    foreach(team in level.teams) {
      level.wavedelay[team] = 0;
    }

    return;
  }

  level.mayspawn = &mayspawn;
}

function mayspawn() {
  if(!isDefined(self.team) || !isDefined(level.var_1d402358)) {
    return true;
  }

  return self.team != level.var_1d402358.team;
}

function forcespawnplayer() {
  if(!isDefined(self)) {
    return;
  }

  if(isalive(self) || self.pers[#"team"] === # "spectator") {
    return;
  }

  if(!globallogic_utils::isvalidclass(self.pers[#"class"])) {
    self.pers[#"class"] = "CLASS_CUSTOM1";
    self.curclass = self.pers[#"class"];
  }

  if(!self function_8b1a219a()) {
    self closeingamemenu();
  }

  self thread[[level.spawnclient]]();
}

function onscoreclosemusic() {
  teamscores = [];

  while(!level.gameended) {
    scorelimit = level.scorelimit;
    scorethreshold = scorelimit * 0.1;
    scorethresholdstart = abs(scorelimit - scorethreshold);
    scorelimitcheck = scorelimit - 10;
    topscore = 0;
    runnerupscore = 0;

    foreach(team, _ in level.teams) {
      score = [[level._getteamscore]](team);

      if(score > topscore) {
        runnerupscore = topscore;
        topscore = score;
        continue;
      }

      if(score > runnerupscore) {
        runnerupscore = score;
      }
    }

    scoredif = topscore - runnerupscore;

    if(topscore >= scorelimit * 0.9) {
      level notify(#"hash_15b8b6edc4ed3032", {
        #var_7090bf53: 0
      });
      return;
    }

    wait 1;
  }
}

function function_4e92a5e8() {
  var_35c5fae0 = struct::get_array("dropkick_football_location", "targetname");

  if(var_35c5fae0.size == 0) {
    var_35c5fae0[0] = {};
    var_35c5fae0[0].origin = getclosestpointonnavmesh(level.mapcenter, 256, 32);
    var_35c5fae0[0].angles = (0, 0, 0);
  }

  var_791ffffd = var_35c5fae0[randomint(var_35c5fae0.size)];
  trigger = spawn("trigger_radius_use", var_791ffffd.origin, 0, 110, 110);
  trigger triggerignoreteam();
  trigger setvisibletoall();
  trigger setteamfortrigger(#"none");
  trigger function_682f34cf(-800);
  trigger.trigger_offset = (0, 0, trigger.mins[2] - trigger.maxs[2]) / 2;
  var_e9f2629a = [];
  var_e9f2629a[0] = spawn("script_model", var_791ffffd.origin);
  var_e9f2629a[0] setModel(#"wpn_t9_eqp_briefcase_world");
  var_e9f2629a[0].angles = var_791ffffd.angles;
  var_4cabc96 = gameobjects::create_carry_object(#"neutral", trigger, var_e9f2629a, (0, 0, 0), #"dropkick_football");
  var_4cabc96 gameobjects::allow_carry(#"group_all");
  var_4cabc96 gameobjects::set_visible(#"group_all");
  var_4cabc96 gameobjects::set_use_time(level.var_8abcfbb8);
  var_4cabc96 gameobjects::set_objective_entity(var_4cabc96);
  var_4cabc96 gameobjects::function_a8c842d6(isDefined(getgametypesetting(#"carrier_manualdrop")) ? getgametypesetting(#"carrier_manualdrop") : 0, 1, 1);
  var_4cabc96 gameobjects::set_onpickup_event(&function_3dbc9c80);
  var_4cabc96 gameobjects::function_13798243(&function_279b8022);
  var_4cabc96 gameobjects::set_onbeginuse_event(&onbeginuse);
  var_4cabc96 gameobjects::set_onenduse_event(&onenduse);
  var_4cabc96.onreset = &onreset;
  var_4cabc96.objectiveonself = 1;
  var_4cabc96.allowweapons = 1;
  var_4cabc96.var_22389d70 = 0;

  if(true) {
    var_4cabc96.enemyobjid = gameobjects::get_next_obj_id();
    objective_add(var_4cabc96.enemyobjid, "invisible", var_791ffffd.origin, #"hash_7a7d8800746ef2a5");
  }

  level.var_bb695b91 = var_4cabc96;
}

function function_b256c6a7() {
  var_4cabc96 = level.var_bb695b91;

  if(!isDefined(var_4cabc96)) {
    return;
  }

  var_4cabc96 gameobjects::set_visible(#"group_none");
  var_4cabc96.trigger setinvisibletoall();

  if(isDefined(var_4cabc96.droptrigger)) {
    var_4cabc96.droptrigger setinvisibletoall();
  }

  if(isDefined(var_4cabc96.enemyobjid)) {
    objective_setstate(var_4cabc96.enemyobjid, "invisible");
  }
}

function function_3dbc9c80(player) {
  if(level.var_f2a67a5d === 1) {
    return;
  }

  assert(isDefined(player) && isDefined(player.team));
  ownerteam = player.team;
  var_4cabc96 = self;
  self gameobjects::set_owner_team(ownerteam);
  self.visuals[0] notsolid();

  if(player !== level.var_d0bebb68) {
    level.var_d0bebb68 = undefined;
  }

  if(isDefined(self.enemyobjid)) {
    self gameobjects::set_visible(#"group_friendly");
    objective_setstate(self.enemyobjid, "active");
    objective_setteam(self.enemyobjid, ownerteam);
    function_c939fac4(self.enemyobjid, ownerteam);
    self thread function_6e8c149a();
    self thread function_96a10724();
  } else {
    self gameobjects::set_visible(#"group_all");
  }

  if(isDefined(self.trigger)) {
    self.trigger triggerenable(0);
  }

  player.var_e8c7d324 = 1;
  player setmovespeedscale(1);
  player clientfield::set("ctf_flag_carrier", 1);
  player function_e9921723();

  if(level.dropkickcarrierarmor > 0) {
    player function_b64329fe();
  }

  remove_influencers(self, player);
  level.var_6c99ff95 = player influencers::create_entity_influencer("dropkick_football", level.player_team_mask | level.enemy_team_mask);
  level.var_1d402358 = player;
  level.var_13faac26 = 0;

  if(level.waverespawndelay) {
    level.wavedelay[ownerteam] = isDefined(level.waverespawndelay) ? level.waverespawndelay : 0;
  }

  player thread globallogic_audio::leader_dialog_on_player("dropkickPlayerPickup");
  thread globallogic_audio::function_b4319f8e("dropkickFriendlyPickup", ownerteam, player);
  thread globallogic_audio::leader_dialog_for_other_teams("dropkickEnemyPickup", ownerteam);
  self thread function_a7574777();
}

function function_279b8022(player) {
  carrier = level.var_1d402358;
  level.var_1d402358 = undefined;

  if(level.waverespawndelay) {
    level.wavedelay[carrier.team] = 0;
  } else {
    foreach(person in getplayers(carrier.team)) {
      if(person === carrier) {
        continue;
      }

      person forcespawnplayer();
    }
  }

  if(level.var_f2a67a5d === 1) {
    return;
  }

  self notify(#"hash_69b164cea4605785");
  self gameobjects::set_owner_team(#"neutral");
  self gameobjects::set_visible(#"group_all");
  self.visuals[0] solid();

  if(isDefined(self.enemyobjid)) {
    objective_setvisibletoall(self.enemyobjid);
    objective_setstate(self.enemyobjid, "invisible");
    objective_setteam(self.enemyobjid, #"none");
  }

  if(isDefined(carrier)) {
    carrier.var_e8c7d324 = 0;
    carrier setmovespeedscale(1);
    carrier clientfield::set("ctf_flag_carrier", 0);
    carrier function_f58ec571();
  }

  remove_influencers(self, carrier);
  level.var_adb77100 = self influencers::create_entity_influencer("dropkick_football", level.player_team_mask | level.enemy_team_mask);
  level.var_13faac26 = 0;

  if(carrier === level.var_d0bebb68) {
    level.var_d0bebb68 = undefined;
  }

  self thread function_aa074770();

  foreach(person in getplayers()) {
    person playlocalsound(#"hash_2e71f0773ee8286a");
  }
}

function onbeginuse(player) {
  self function_3f367c2e();
}

function onenduse(team, player, success) {
  if(!success && self gameobjects::is_object_away_from_home()) {
    self thread function_aa074770();
  }
}

function onreset(previousorigin) {
  self function_3f367c2e();
}

function function_a7574777() {
  level endon(#"score_limit_reached");
  self endon(#"hash_69b164cea4605785");
  timeheld = 0;
  var_ec4f42f2 = 0;

  for(var_a14bc571 = 0; true; var_a14bc571 = 1) {
    wait 1;
    hostmigration::waittillhostmigrationdone();
    team = self gameobjects::get_owner_team();

    if(!isDefined(team)) {
      return;
    }

    globallogic_score::giveteamscoreforobjective(team, level.carryscore);
    player = self.carrier;

    if(isDefined(player)) {
      if(isDefined(player.pers[#"objtime"])) {
        player.pers[#"objtime"]++;
        player.objtime = player.pers[#"objtime"];
      }

      player stats::function_bb7eedf0(#"objective_time", 1);
      player globallogic_score::incpersstat(#"objectivetime", 1, 0, 1);
      timeheld++;

      if(timeheld % 5 == 0) {
        scoreevents::processscoreevent(#"hash_5da3cbb3a47375eb", player);
      }

      if(timeheld >= 50 && !var_ec4f42f2) {
        scoreevents::processscoreevent(#"hash_7a2b068529e599a8", player);
        var_ec4f42f2 = 1;
      }

      if(timeheld >= 30 && player === level.var_d0bebb68 && !var_a14bc571) {
        scoreevents::processscoreevent(#"hash_149ab2bcfb997bbc", player);
      }
    }
  }
}

function function_6e8c149a() {
  self notify("38e3b8e87896c1e1");
  self endon("38e3b8e87896c1e1");
  level endon(#"score_limit_reached");
  self endon(#"hash_69b164cea4605785");

  while(true) {
    carrier = self gameobjects::get_carrier();

    if(!isDefined(self.enemyobjid) || !isDefined(carrier)) {
      return;
    }

    var_e000301a = 0;
    stance = carrier getstance();

    if(stance === "stand") {
      height = 70;
      var_e000301a = height / 1.5;
    } else if(stance === "crouch") {
      height = 50;
      var_e000301a = height / 2;
    } else if(stance === "prone") {
      height = 30;
      var_e000301a = height / 2;
    }

    objectiveposition = carrier.origin + (0, 0, var_e000301a);
    objective_setposition(self.enemyobjid, objectiveposition);
    wait 3;
  }
}

function function_96a10724() {
  level endon(#"score_limit_reached");
  self endon(#"hash_69b164cea4605785");
  var_2c26f7e5 = 0;

  while(true) {
    carrier = self gameobjects::get_carrier();
    var_8afaec49 = carrier uav::function_781f1bf2() || carrier recon_plane::function_4dc67281();

    if(var_8afaec49) {
      if(!var_2c26f7e5) {
        objective_setstate(self.enemyobjid, "invisible");
        self gameobjects::set_visible(#"group_all");
        var_2c26f7e5 = 1;
      }
    } else if(var_2c26f7e5) {
      self thread function_6e8c149a();
      objective_setstate(self.enemyobjid, "active");
      self gameobjects::set_visible(#"group_friendly");
      var_2c26f7e5 = 0;
    }

    wait 0.25;
  }
}

function function_e9921723() {
  primaryweapon = getweapon(#"hash_29ab150f9f8964f");
  self giveweapon(primaryweapon);
  self givestartammo(primaryweapon);
  self switchtoweapon(primaryweapon, 1);
  self val::set(#"hash_57686500ed84dbcc", "disable_weapon_cycling", 1);
  self val::set(#"hash_57686500ed84dbcc", "disable_offhand_weapons", 1);
  self val::set(#"hash_57686500ed84dbcc", "disable_weapon_pickup", 1);
  self loadout::function_442539("primary", primaryweapon);
  self.droppeddeathweapon = 1;
  gestures::function_a5202150(#"hash_6c5354e57d5054f6", #"hash_29ab150f9f8964f");
}

function function_b64329fe() {
  self armor::set_armor(level.dropkickcarrierarmor, level.dropkickcarrierarmor, 0, 0, 1, 1, 5, 1, 1, 1);
}

function function_f58ec571() {
  primaryweapon = getweapon(#"hash_29ab150f9f8964f");

  if(self hasweapon(primaryweapon)) {
    self takeweapon(primaryweapon);
  }

  self enableweaponcycling();
  self val::reset_all(#"hash_57686500ed84dbcc");
  self.droppeddeathweapon = undefined;
}

function remove_influencers(var_4cabc96, carrier) {
  if(isDefined(level.var_adb77100) && isDefined(var_4cabc96)) {
    var_4cabc96 influencers::remove_influencer(level.var_adb77100);
    level.var_adb77100 = undefined;
  }

  if(isDefined(level.var_6c99ff95) && isDefined(carrier)) {
    carrier influencers::remove_influencer(level.var_6c99ff95);
    level.var_6c99ff95 = undefined;
  }
}

function function_aa074770() {
  if(!isDefined(level.var_6ecc0fa6) || level.var_6ecc0fa6 == 0) {
    return;
  }

  self endon(#"hash_656fdc4ee4edf47c");
  wait level.var_6ecc0fa6;

  if(level.var_f2a67a5d === 1) {
    return;
  }

  if(!isDefined(self.carrier)) {
    self thread gameobjects::return_home();
  }
}

function function_3f367c2e() {
  if(!isDefined(level.var_6ecc0fa6) || level.var_6ecc0fa6 == 0) {
    return;
  }

  self notify(#"hash_656fdc4ee4edf47c");
}

function function_1a67afed() {
  clientfield::set("" + # "hash_69d32ac298f2aa22", 1);
  level waittill(#"pre_potm");
  clientfield::set("" + # "hash_69d32ac298f2aa22", 2);
  level waittill(#"potm_finished");
  clientfield::set("" + # "hash_69d32ac298f2aa22", 3);
}

function private function_311e397d() {
  wait 2.5;
  var_1c3c21f1 = function_ec196fb0();
  var_5ac13eb1 = struct::get_array(#"hash_4b493e0124411b31", "targetname");

  if(var_5ac13eb1.size == 0 && !isDefined(var_1c3c21f1)) {
    return;
  }

  var_a996ef6 = var_5ac13eb1[randomint(var_5ac13eb1.size)];

  if(isDefined(var_1c3c21f1)) {
    var_a996ef6 = var_1c3c21f1;
  }

  origin = var_a996ef6.origin;
  forward = anglesToForward(var_a996ef6.angles);
  up = anglestoup(var_a996ef6.angles);
  playsoundatposition(#"hash_36412d3d8dabf70e", (0, 0, 0));
  playFX(#"hash_76b02047787f0357", origin, forward, up, 1);
}

function private function_ec196fb0() {
  if(!isDefined(level.var_4c887efb) || !isDefined(level.var_4c887efb.origin)) {
    return;
  }

  if(!isDefined(level.var_4c887efb.angles)) {
    level.var_4c887efb.angles = (0, 0, 0);
  }

  return level.var_4c887efb;
}

function private function_f7c2fc80() {
  wait 2;

  foreach(player in getplayers()) {
    player function_66337ef1(#"dropkick_nuke_rumble_first");
  }

  var_3b3fc42b = 4;
  wait var_3b3fc42b;

  foreach(player in getplayers()) {
    player stoprumble(#"dropkick_nuke_rumble_first");
    player function_66337ef1(#"dropkick_nuke_rumble_second");
  }

  var_6972a090 = 3.4;
  wait var_6972a090;

  foreach(player in getplayers()) {
    player stoprumble(#"dropkick_nuke_rumble_second");
  }
}

function private function_68f13f40() {
  wait 2.1;

  foreach(player in getplayers()) {
    player gestures::play_gesture(#"hash_6c5354e57d5054f6", undefined, 1);
  }

  duration = 6.9;
  wait duration;

  foreach(player in getplayers()) {
    if(player isgestureplaying(#"hash_6c5354e57d5054f6")) {
      player stopgestureviewmodel(#"hash_6c5354e57d5054f6");
    }
  }
}

function private function_86ca9275() {
  wait 2;

  foreach(player in getplayers()) {
    player val::set(#"hash_31a56c396d195997", "show_hud", 0);
  }
}