/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\uav.gsc
***********************************************/

#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_dialog;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\util;
#using scripts\weapons\heatseekingmissile;
#namespace uav;

function private autoexec __init__system__() {
  system::register(#"uav", &preinit, undefined, &function_1c601b99, #"killstreaks");
}

function private function_6fe2ffad() {
  if(sessionmodeiswarzonegame()) {
    return "killstreak_uav_wz";
  }

  return "killstreak_uav";
}

function private preinit() {
  level.activeuavs = [];
  level.activeplayeruavs = [];
  level.spawneduavs = [];
  level.var_baadd01f = &function_1b3ab65e;
  level.var_91c243ba = &function_91c243ba;

  if(tweakables::gettweakablevalue("killstreak", "allowradar")) {
    killstreaks::register_killstreak(function_6fe2ffad(), &activateuav);
  }

  level thread uavtracker();
  callback::on_connect(&onplayerconnect);
  callback::on_spawned(&onplayerspawned);
  callback::on_joined_team(&onplayerjoinedteam);
  callback::add_callback(#"hash_7c6da2f2c9ef947a", &fx_flesh_hit_neck_fatal);
  var_742e7b3d = getweapon("uav");
  globallogic_score::register_kill_callback(var_742e7b3d, &function_9ee62e18);
  globallogic_score::function_c1e9b86b(var_742e7b3d, &function_2472a08e);
  setmatchflag("radar_allies", 0);
  setmatchflag("radar_axis", 0);
  airsupport::init_shared();
  clientfield::register("scriptmover", "uav", 1, 1, "int");
  clientfield::register("scriptmover", "uav_fx", 1, 1, "int");
}

function function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon(#"uav"), &function_bff5c062);
  }

  if(false) {
    profilestart();
    level.var_b59e7114 = killstreaks::function_f3875fb0(level.var_49dafe2a, isDefined(level.var_eb2556e1) ? level.var_eb2556e1 : 5000, 60, -1, 1);
    profilestop();
  }
}

function onplayerconnect() {
  if(!isDefined(self.entnum)) {
    self.entnum = self getentitynumber();
  }
}

function function_bff5c062(uav, attackingplayer) {
  uav hackedprefunction(attackingplayer);
  uav.owner = attackingplayer;
  uav killstreaks::configure_team_internal(attackingplayer, 1);

  if(isDefined(level.var_f1edf93f)) {
    uav notify(#"hacked");
    uav notify(#"cancel_timeout");
    var_eb79e7c3 = int([[level.var_f1edf93f]]() * 1000);
    uav thread killstreaks::waitfortimeout("uav", var_eb79e7c3, &ontimeout, "delete", "death", "crashing");
  }
}

function function_ef80ceac() {
  if(isDefined(level.activeplayeruavs[self.entnum])) {
    var_86510a2 = level.activeplayeruavs[self.entnum];

    if(level.forceradar == 1) {
      var_86510a2--;
    }

    return (var_86510a2 > 0);
  }

  return false;
}

function function_1b3ab65e() {
  foreach(uav in level.spawneduavs) {
    if(uav.team === self.team) {
      continue;
    }

    if(!getDvar(#"hash_26bd5d5bf0e32197", 0) || uav function_457c378e(self)) {
      return true;
    }
  }

  return false;
}

function function_91c243ba(enemy) {
  if(self function_ef80ceac()) {
    if(!getDvar(#"hash_26bd5d5bf0e32197", 0)) {
      return true;
    }

    foreach(uav in level.spawneduavs) {
      if(self === uav.owner && uav function_457c378e(enemy)) {
        return true;
      }
    }
  }

  return false;
}

function fx_flesh_hit_neck_fatal(params) {
  if(!isDefined(level.var_3d960463) || isDefined(level.var_3d960463) && !params.attacker[[level.var_3d960463]]()) {
    foreach(player in params.players) {
      if(player function_91c243ba(self)) {
        scoregiven = scoreevents::processscoreevent(#"uav_assist", player, undefined, undefined);

        if(isDefined(scoregiven)) {
          player challenges::earneduavassistscore(scoregiven);
          player stats::function_8fb23f94("uav", #"assists", 1);
          player stats::function_b04e7184("uav", #"best_assists");
          killstreakindex = level.killstreakindices[# "uav"];
          killstreaks::killstreak_assist(player, self, killstreakindex);

          if(isDefined(level.var_b7bc3c75.var_e2298731)) {
            player[[level.var_b7bc3c75.var_e2298731]]();
          }
        }
      }
    }
  }
}

function hackedprefunction(hacker) {
  uav = self;
  uav resetactiveuav();
}

function configureteampost(owner, ishacked) {
  uav = self;
  uav thread teams::waituntilteamchangesingleton(ishacked, "UAV_watch_team_change_" + uav getentitynumber(), &onteamchange, ishacked.entnum, "delete", "death", "leaving");
  ishacked addactiveuav();
}

function function_f724cfe4(health) {
  waitframe(1);
  self.health = health;
}

function activateuav(killstreaktype) {
  assert(isDefined(level.players));

  if(self killstreakrules::iskillstreakallowed("uav", self.team) == 0) {
    return false;
  }

  killstreak_id = self killstreakrules::killstreakstart("uav", self.team);

  if(killstreak_id == -1) {
    return false;
  }

  attach_angle = -90;
  minflyheight = killstreaks::function_43f4782d();
  uav = spawn("script_model", self.origin + (0, 0, minflyheight + 1000));

  if(!isDefined(level.spawneduavs)) {
    level.spawneduavs = [];
  } else if(!isarray(level.spawneduavs)) {
    level.spawneduavs = array(level.spawneduavs);
  }

  level.spawneduavs[level.spawneduavs.size] = uav;
  bundle = killstreaks::get_script_bundle("uav");
  uav setModel(bundle.ksmodel);
  uav setenemymodel(bundle.var_aa0b97e1);
  uav.weapon = getweapon("uav");
  uav setweapon(uav.weapon);
  uav function_619a5c20();
  uav setforcenocull();
  uav.targetname = "uav";
  uav util::make_sentient();
  uav killstreaks::configure_team(killstreaktype, killstreak_id, self, undefined, undefined, &configureteampost);
  uav killstreak_hacking::enable_hacking("uav", &hackedprefunction, undefined);
  uav clientfield::set("enemyvehicle", 1);
  killstreak_detect::killstreaktargetset(uav);
  uav setdrawinfrared(1);
  uav.killstreak_id = killstreak_id;
  uav.leaving = 0;
  uav.victimsoundmod = "vehicle";
  uav.var_48d842c3 = 1;
  uav thread killstreaks::function_2b6aa9e8("uav", &destroyuav, &onlowhealth);
  uav thread function_f724cfe4(100000);
  bundle = killstreaks::get_script_bundle("uav");
  uav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "crashing", undefined, 1);
  uav.rocketdamage = uav.maxhealth + 1;
  uav clientfield::set("uav_fx", 1);
  uav clientfield::set("scorestreakActive", 1);
  uav killstreaks::function_a781e8d2();

  if(false) {
    uav killstreaks::function_67d553c4(level.var_b59e7114, isDefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000, isDefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000, -1);
    uav clientfield::set("uav", 1);
  } else {
    if(sessionmodeiswarzonegame()) {
      var_b0490eb9 = getheliheightlockheight(self.origin);
      trace = groundtrace((self.origin[0], self.origin[1], var_b0490eb9), self.origin - (0, 0, 5000), 0, uav);
      groundheight = trace[# "position"][2];
      var_5f8c899e = groundheight + (var_b0490eb9 - groundheight) * bundle.var_ff73e08c;
      var_5f8c899e -= killstreaks::function_43f4782d();
    } else {
      var_5f8c899e = 5000;
    }

    uav.var_b59e7114 = killstreaks::function_f3875fb0(self.origin, isDefined(level.var_eb2556e1) ? level.var_eb2556e1 : var_5f8c899e, 60, -1, 1);
    uav killstreaks::function_67d553c4(uav.var_b59e7114, isDefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000, isDefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000, -1);
    uav.var_b59e7114 clientfield::set("uav", 1);
    uav.var_b59e7114 setteam(uav.team);
  }

  uav killstreakrules::function_2e6ff61a("uav", killstreak_id, {
    #origin: uav.var_b59e7114.origin, #team: uav.team
  });
  self stats::function_e24eec31(getweapon("uav"), #"used", 1);
  uav thread killstreaks::waitfortimeout("uav", 30000, &ontimeout, "delete", "death", "crashing");
  uav thread killstreaks::waitfortimecheck(30000 / 2, &ontimecheck, "delete", "death", "crashing");
  uav thread startuavfx();
  self killstreak_dialog::play_killstreak_start_dialog("uav", self.team, killstreak_id);
  uav killstreak_dialog::play_pilot_dialog_on_owner("arrive", "uav", killstreak_id);
  uav thread killstreaks::player_killstreak_threat_tracking("uav", 0.965926);
  uav thread killstreaks::function_5a7ecb6b();
  self stats::function_dad108fa(#"hash_1030d5aac01a491e", 1);
  self stats::function_dad108fa(#"hash_436fffdd733392ba", 1);
  self stats::function_dad108fa(#"hash_437000dd7333946d", 1);
  return true;
}

function onlowhealth(attacker, weapon) {
  self.is_damaged = 1;
  params = killstreaks::get_script_bundle("uav");

  if(isDefined(params.fxlowhealth)) {
    playFXOnTag(params.fxlowhealth, self, "tag_origin");
  }

  self killstreaks::function_8b4513ca();
}

function function_457c378e(ent) {
  if(!(isDefined(ent) && isDefined(self))) {
    return;
  }

  bundle = killstreaks::get_script_bundle("uav");
  var_b2231ba3 = sqr((isDefined(bundle.var_dd0e1146) ? bundle.var_dd0e1146 : 0) / 2);

  if(1 && isDefined(self.var_b59e7114)) {
    var_59848c4e = self.var_b59e7114.origin;
  } else {
    var_59848c4e = self.origin;
  }

  return distance2dsquared(ent.origin, var_59848c4e) <= var_b2231ba3;
}

function onteamchange(entnum, event) {
  destroyuav(undefined, undefined);
}

function destroyuav(attacker, weapon) {
  attacker = self[[level.figure_out_attacker]](attacker);

  if(isDefined(attacker) && (!isDefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
    attacker battlechatter::function_eebf94f6("uav");
    challenges::destroyedaircraft(attacker, weapon, 0, self);
    luinotifyevent(#"player_callout", 2, #"hash_7f902a0b5852fe90", attacker.entnum);
    attacker challenges::addflyswatterstat(weapon, self);
  }

  if(isDefined(self.var_b59e7114)) {
    self.var_b59e7114 delete();
  }

  if(!self.leaving) {
    self removeactiveuav();
    self killstreak_dialog::play_destroyed_dialog_on_owner("uav", self.killstreak_id);
  }

  self notify(#"crashing");
  self playSound(#"exp_veh_large");
  params = killstreaks::get_script_bundle("uav");

  if(isDefined(params.ksexplosionfx)) {
    playFXOnTag(params.ksexplosionfx, self, "tag_origin");
  }

  if(isDefined(params.var_bb6c29b4) && isDefined(weapon) && weapon == getweapon(#"shock_rifle")) {
    playFXOnTag(params.var_bb6c29b4, self, "tag_origin");
  }

  self killstreaks::function_7d265bd3();
  self stoploopsound();
  self setModel(#"tag_origin");
  self setenemymodel(#"tag_origin");
  self killstreaks::function_90e951f2();

  if(target_istarget(self)) {
    target_remove(self);
  }

  self unlink();
  wait 0.5;
  arrayremovevalue(level.spawneduavs, self);

  if(isDefined(self)) {
    self notify(#"delete");
    self delete();
  }
}

function onplayerspawned() {
  self endon(#"disconnect");

  if(level.teambased == 0 || level.multiteam == 1 || level.forceradar == 1) {
    uavtracker();
  }
}

function function_9ee62e18(attacker, victim, weapon, attackerweapon, meansofdeath) {
  if(attackerweapon util::isenemyplayer(meansofdeath) && (!isDefined(level.var_3d960463) || isDefined(level.var_3d960463) && !attackerweapon[[level.var_3d960463]]())) {
    if(attackerweapon function_91c243ba(meansofdeath)) {
      return true;
    }
  }

  return false;
}

function function_781f1bf2() {
  if(!isDefined(self.team)) {
    return false;
  }

  friendlyteam = self.team;

  foreach(team in level.teams) {
    if(team == friendlyteam) {
      continue;
    }

    if(isDefined(level.activeuavs[team]) && level.activeuavs[team] > 0) {
      return true;
    }
  }

  return false;
}

function function_2472a08e(params) {
  attacker = params.attacker;
  attackerweapon = params.attackerweapon;
  meansofdeath = params.meansofdeath;
  attacker contracts::increment_contract(#"hash_721e237b8a432eb");
  attacker stats::function_dad108fa(#"hash_7d6a0749d37a5428", 1);
  attacker stats::function_dad108fa(#"hash_26f3858ac994b858", 1);
  challenges::function_7f86a7b8(attacker, attackerweapon, meansofdeath);
}

function onplayerjoinedteam(params) {
  hidealluavstosameteam();
}

function ontimeout() {
  playafterburnerfx();

  if(is_true(self.is_damaged)) {
    params = getscriptbundle(function_6fe2ffad());

    if(isDefined(params.var_3d1f54ee)) {
      playFXOnTag(params.var_3d1f54ee, self, isDefined(params.var_a559066f) ? params.var_a559066f : "tag_origin");
    }
  }

  self killstreak_dialog::play_pilot_dialog_on_owner("timeout", "uav");
  self.leaving = 1;
  self clientfield::set("uav_fx", 0);

  if(isDefined(self.var_b59e7114)) {
    self.var_b59e7114 clientfield::set("uav", 0);
    self.var_b59e7114 delete();
  }

  if(isDefined(level.var_14151f16)) {
    [[level.var_14151f16]](self, 0);
  }

  self removeactiveuav();

  if(sessionmodeiswarzonegame()) {
    var_384be02f = 4000;
  }

  airsupport::leave(10, var_384be02f);
  self util::delay(10 - 3, undefined, &killstreaks::outro_scaling);
  wait 10;
  self killstreaks::function_90e951f2();
  waitframe(1);
  arrayremovevalue(level.spawneduavs, self);
  self delete();
}

function ontimecheck() {
  self killstreak_dialog::play_pilot_dialog_on_owner("timecheck", "uav", self.killstreak_id);
}

function startuavfx() {
  self endon(#"death");
  wait 0.1;

  if(isDefined(self)) {
    params = getscriptbundle(function_6fe2ffad());

    if(isDefined(params.var_7291f2f7)) {
      playFXOnTag(params.var_7291f2f7, self, isDefined(params.var_907ff222) ? params.var_907ff222 : "tag_origin");
    }
  }
}

function playafterburnerfx() {
  self endon(#"death");
  wait 0.1;

  if(isDefined(self)) {
    self stoploopsound();
    teams = util::function_668e9d6c(self.team);

    foreach(team in teams) {
      self playsoundtoteam(#"veh_kls_uav_afterburner", team);
    }
  }
}

function hasuav(team) {
  return isDefined(level.activeuavs[team]) && level.activeuavs[team] > 0;
}

function addactiveuav() {
  assert(isDefined(self.team));

  if(!isDefined(level.activeuavs[self.team])) {
    level.activeuavs[self.team] = 0;
  }

  level.activeuavs[self.team]++;

  if(!isDefined(level.activeplayeruavs[self.entnum])) {
    level.activeplayeruavs[self.entnum] = 0;
  }

  level.activeplayeruavs[self.entnum]++;
  uavtracker();
}

function removeactiveuav() {
  uav = self;
  uav resetactiveuav();
  uav killstreakrules::killstreakstop(uav.killstreaktype, self.originalteam, self.killstreak_id);
}

function resetactiveuav() {
  if(!isDefined(level.activeuavs[self.team])) {
    return;
  }

  level.activeuavs[self.team]--;
  assert(level.activeuavs[self.team] >= 0);

  if(level.activeuavs[self.team] <= 0) {
    level.activeuavs[self.team] = undefined;
  }

  if(isDefined(self.owner) && isDefined(level.activeplayeruavs[self.ownerentnum])) {
    level.activeplayeruavs[self.ownerentnum]--;
    assert(level.activeplayeruavs[self.ownerentnum] >= 0);

    if(level.activeplayeruavs[self.ownerentnum] <= 0) {
      level.activeplayeruavs[self.ownerentnum] = undefined;
    }
  }

  uavtracker();
}

function uavtracker() {
  if(level.teambased) {
    foreach(team, _ in level.teams) {
      activeuavs = isDefined(level.activeuavs[team]) ? level.activeuavs[team] : 0;
      var_376f7f8c = activeuavs + (isDefined(level.activesatellites[team]) ? level.activesatellites[team] : 0) + (isDefined(level.var_eb10c6a7[team]) ? level.var_eb10c6a7[team] : 0);
      setteamspyplane(team, int(min(activeuavs, 2)));
      util::set_team_radar(team, var_376f7f8c > 0);
    }

    return;
  }

  foreach(player in level.players) {
    activeuavs = isDefined(level.activeuavs[player.team]) ? level.activeuavs[player.team] : 0;
    var_376f7f8c = activeuavs + (isDefined(level.activesatellites[player.team]) ? level.activesatellites[player.team] : 0);

    if(isDefined(player.entnum)) {
      var_376f7f8c += isDefined(level.var_eb10c6a7[player.entnum]) ? level.var_eb10c6a7[player.entnum] : 0;
    }

    player setclientuivisibilityflag("radar_client", var_376f7f8c > 0);
    player.hasspyplane = var_376f7f8c > 0;
  }
}

function hidealluavstosameteam() {
  foreach(uav in level.spawneduavs) {
    if(isDefined(uav)) {
      uav teams::hidetosameteam();
    }
  }
}