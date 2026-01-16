/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\uav.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\tweakables_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\airsupport;
#include scripts\killstreaks\killstreak_detect;
#include scripts\killstreaks\killstreak_hacking;
#include scripts\killstreaks\killstreakrules_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\mp\counteruav;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\teams\teams;
#include scripts\mp_common\util;
#include scripts\weapons\heatseekingmissile;

#namespace uav;

autoexec __init__system__() {
  system::register(#"uav", &__init__, undefined, #"killstreaks");
}

__init__() {
  if(level.teambased) {
    foreach(team, _ in level.teams) {
      level.activeuavs[team] = 0;
    }
  } else {
    level.activeuavs = [];
  }

  level.activeplayeruavs = [];
  level.spawneduavs = [];

  if(tweakables::gettweakablevalue("killstreak", "allowradar")) {
    killstreaks::register_killstreak("killstreak_uav", &activateuav);
  }

  level thread uavtracker();
  callback::on_connect(&onplayerconnect);
  callback::on_spawned(&onplayerspawned);
  callback::on_joined_team(&onplayerjoinedteam);
  callback::on_finalize_initialization(&function_3675de8b);
  callback::add_callback(#"hash_425352b435722271", &fx_flesh_hit_neck_fatal);
  callback::on_finalize_initialization(&function_1c601b99);
  setmatchflag("radar_allies", 0);
  setmatchflag("radar_axis", 0);
}

function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon(#"uav"), &function_bff5c062);
  }
}

function_bff5c062(uav, attackingplayer) {
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

fx_flesh_hit_neck_fatal(params) {
  enemycuavactive = 0;

  if(params.attacker hasperk(#"specialty_immunecounteruav") == 0) {
    foreach(team, _ in level.teams) {
      if(team == params.attacker.team) {
        continue;
      }

      if(counteruav::teamhasactivecounteruav(team)) {
        enemycuavactive = 1;
      }
    }
  }

  if(enemycuavactive == 0) {
    foreach(player in params.players) {
      if(isDefined(level.activeplayeruavs)) {
        activeuav = level.activeplayeruavs[player.entnum];

        if(level.forceradar == 1) {
          activeuav--;
        }

        if(activeuav > 0) {
          scoregiven = scoreevents::processscoreevent(#"uav_assist", player, undefined, undefined);

          if(isDefined(scoregiven)) {
            player challenges::earneduavassistscore(scoregiven);
            killstreakindex = level.killstreakindices[#"uav"];
            killstreaks::killstreak_assist(player, self, killstreakindex);
          }
        }
      }
    }
  }
}

function_3675de8b() {
  profilestart();
  initrotatingrig();
  profilestop();
}

initrotatingrig() {
  if(isDefined(level.var_c6129172)) {
    map_center = airsupport::getmapcenter();
    rotator_offset = (isDefined(level.var_c6129172) ? level.var_c6129172 : map_center[0], isDefined(level.var_ae8d87c7) ? level.var_ae8d87c7 : map_center[1], isDefined(level.var_eb2556e1) ? level.var_eb2556e1 : 1200);
    level.var_b59e7114 = spawn("script_model", rotator_offset);
  } else {
    map_center = airsupport::getmapcenter();
    rotator_offset = (isDefined(level.var_778a1b96) ? level.var_778a1b96 : 0, isDefined(level.var_621e7f72) ? level.var_621e7f72 : 0, 1200);
    level.var_b59e7114 = spawn("script_model", map_center + rotator_offset);
  }

  level.var_b59e7114 setModel(#"tag_origin");
  level.var_b59e7114.angles = (0, 115, 0);
  level.var_b59e7114 hide();
  level.var_b59e7114 thread rotaterig();
  level.var_b59e7114 thread swayrig();
}

rotaterig() {
  for(;;) {
    self rotateyaw(-360, 60);
    wait 60;
  }
}

swayrig() {
  centerorigin = self.origin;

  for(;;) {
    z = randomintrange(-200, -100);
    time = randomintrange(3, 6);
    self moveto(centerorigin + (0, 0, z), time, 1, 1);
    wait time;
    z = randomintrange(100, 200);
    time = randomintrange(3, 6);
    self moveto(centerorigin + (0, 0, z), time, 1, 1);
    wait time;
  }
}

hackedprefunction(hacker) {
  uav = self;
  uav resetactiveuav();
}

configureteampost(owner, ishacked) {
  uav = self;
  uav thread teams::waituntilteamchangesingleton(owner, "UAV_watch_team_change_" + uav getentitynumber(), &onteamchange, owner.entnum, "delete", "death", "leaving");

  if(ishacked == 0) {
    uav teams::hidetosameteam();
  } else {
    uav setvisibletoall();
  }

  owner addactiveuav();
}

function_f724cfe4(health) {
  waitframe(1);
  self.health = health;
}

activateuav() {
  assert(isDefined(level.players));

  if(self killstreakrules::iskillstreakallowed("uav", self.team) == 0) {
    return false;
  }

  killstreak_id = self killstreakrules::killstreakstart("uav", self.team);

  if(killstreak_id == -1) {
    return false;
  }

  rotator = level.var_b59e7114;
  attach_angle = -90;
  uav = spawn("script_model", rotator gettagorigin("tag_origin"));

  if(!isDefined(level.spawneduavs)) {
    level.spawneduavs = [];
  } else if(!isarray(level.spawneduavs)) {
    level.spawneduavs = array(level.spawneduavs);
  }

  level.spawneduavs[level.spawneduavs.size] = uav;
  uav setModel(level.killstreakbundle[#"uav"].ksmodel);
  uav.weapon = getweapon("uav");
  uav setweapon(uav.weapon);
  uav.targetname = "uav";
  uav util::make_sentient();
  uav killstreaks::configure_team("uav", killstreak_id, self, undefined, undefined, &configureteampost);
  uav killstreak_hacking::enable_hacking("uav", &hackedprefunction, undefined);
  uav clientfield::set("enemyvehicle", 1);
  killstreak_detect::killstreaktargetset(uav);
  uav setdrawinfrared(1);
  uav.killstreak_id = killstreak_id;
  uav.leaving = 0;
  uav.victimsoundmod = "vehicle";
  uav thread killstreaks::function_2b6aa9e8("uav", &destroyuav, &onlowhealth);
  uav thread function_f724cfe4(100000);
  uav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", undefined, 1);
  uav.rocketdamage = uav.maxhealth + 1;
  minflyheight = int(airsupport::getminimumflyheight());
  zoffset = minflyheight + (isDefined(level.uav_z_offset) ? level.uav_z_offset : 2500);
  angle = randomint(360);
  radiusoffset = (isDefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000) + randomint(isDefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000);
  xoffset = cos(angle) * radiusoffset;
  yoffset = sin(angle) * radiusoffset;
  anglevector = vectornormalize((xoffset, yoffset, zoffset));
  anglevector *= zoffset;
  anglevector = (anglevector[0], anglevector[1], zoffset - rotator.origin[2]);
  uav linkto(rotator, "tag_origin", anglevector, (0, angle + attach_angle, 0));
  self stats::function_e24eec31(getweapon("uav"), #"used", 1);
  uav thread killstreaks::waitfortimeout("uav", 30000, &ontimeout, "delete", "death", "crashing");
  uav thread killstreaks::waitfortimecheck(30000 / 2, &ontimecheck, "delete", "death", "crashing");
  uav thread startuavfx();
  self killstreaks::play_killstreak_start_dialog("uav", self.team, killstreak_id);
  uav killstreaks::play_pilot_dialog_on_owner("arrive", "uav", killstreak_id);
  uav thread killstreaks::player_killstreak_threat_tracking("uav");
  return true;
}

onlowhealth(attacker, weapon) {
  self.is_damaged = 1;
  params = level.killstreakbundle[#"uav"];

  if(isDefined(params.fxlowhealth)) {
    playFXOnTag(params.fxlowhealth, self, "tag_origin");
  }
}

onteamchange(entnum, event) {
  destroyuav(undefined, undefined);
}

destroyuav(attacker, weapon) {
  attacker = self[[level.figure_out_attacker]](attacker);

  if(isDefined(attacker) && (!isDefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
    attacker battlechatter::function_dd6a6012("uav", weapon);
    challenges::destroyedaircraft(attacker, weapon, 0, 0);
    luinotifyevent(#"player_callout", 2, #"hash_7f902a0b5852fe90", attacker.entnum);
    attacker challenges::addflyswatterstat(weapon, self);
  }

  if(!self.leaving) {
    self removeactiveuav();
    self killstreaks::play_destroyed_dialog_on_owner("uav", self.killstreak_id);
  }

  self notify(#"crashing");
  self playSound(#"exp_veh_large");
  params = level.killstreakbundle[#"uav"];

  if(isDefined(params.ksexplosionfx)) {
    playFXOnTag(params.ksexplosionfx, self, "tag_origin");
  }

  if(isDefined(params.var_bb6c29b4) && isDefined(weapon) && weapon == getweapon(#"shock_rifle")) {
    playFXOnTag(params.var_bb6c29b4, self, "tag_origin");
  }

  self stoploopsound();
  self setModel(#"tag_origin");

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

onplayerconnect() {
  self.entnum = self getentitynumber();

  if(!level.teambased) {
    level.activeuavs[self.entnum] = 0;
  }

  level.activeplayeruavs[self.entnum] = 0;
}

onplayerspawned() {
  self endon(#"disconnect");

  if(level.teambased == 0 || level.multiteam == 1 || level.forceradar == 1) {
    level notify(#"uav_update");
  }
}

onplayerjoinedteam(params) {
  hidealluavstosameteam();
}

ontimeout() {
  playafterburnerfx();

  if(isDefined(self.is_damaged) && self.is_damaged) {
    playFXOnTag("killstreaks/fx_uav_damage_trail", self, "tag_body");
  }

  self killstreaks::play_pilot_dialog_on_owner("timeout", "uav");
  self.leaving = 1;

  if(isDefined(level.var_14151f16)) {
    [[level.var_14151f16]](self, 0);
  }

  self removeactiveuav();
  airsupport::leave(10);
  wait 10;

  if(target_istarget(self)) {
    target_remove(self);
  }

  arrayremovevalue(level.spawneduavs, self);
  self delete();
}

ontimecheck() {
  self killstreaks::play_pilot_dialog_on_owner("timecheck", "uav", self.killstreak_id);
}

startuavfx() {
  self endon(#"death");
  wait 0.1;

  if(isDefined(self)) {
    playFXOnTag("killstreaks/fx_uav_lights", self, "tag_origin");
    self playLoopSound(#"veh_uav_engine_loop", 1);
  }
}

playafterburnerfx() {
  self endon(#"death");
  wait 0.1;

  if(isDefined(self)) {
    self stoploopsound();
    team = util::getotherteam(self.team);
    self playsoundtoteam(#"veh_kls_uav_afterburner", team);
  }
}

hasuav(team_or_entnum) {
  return level.activeuavs[team_or_entnum] > 0;
}

addactiveuav() {
  if(level.teambased) {
    assert(isDefined(self.team));
    level.activeuavs[self.team]++;
  } else {
    assert(isDefined(self.entnum));

    if(!isDefined(self.entnum)) {
      self.entnum = self getentitynumber();
    }

    level.activeuavs[self.entnum]++;
  }

  level.activeplayeruavs[self.entnum]++;
  level notify(#"uav_update");
}

removeactiveuav() {
  uav = self;
  uav resetactiveuav();
  uav killstreakrules::killstreakstop("uav", self.originalteam, self.killstreak_id);
}

resetactiveuav() {
  if(level.teambased) {
    level.activeuavs[self.team]--;
    assert(level.activeuavs[self.team] >= 0);

    if(level.activeuavs[self.team] < 0) {
      level.activeuavs[self.team] = 0;
    }
  } else if(isDefined(self.owner)) {
    assert(isDefined(self.owner.entnum));

    if(!isDefined(self.owner.entnum)) {
      self.owner.entnum = self.owner getentitynumber();
    }

    level.activeuavs[self.owner.entnum]--;
    assert(level.activeuavs[self.owner.entnum] >= 0);

    if(level.activeuavs[self.owner.entnum] < 0) {
      level.activeuavs[self.owner.entnum] = 0;
    }
  }

  if(isDefined(self.owner)) {
    level.activeplayeruavs[self.owner.entnum]--;
    assert(level.activeplayeruavs[self.owner.entnum] >= 0);
  }

  level notify(#"uav_update");
}

uavtracker() {
  level endon(#"game_ended");

  while(true) {
    level waittill(#"uav_update");

    if(level.teambased) {
      foreach(team, _ in level.teams) {
        activeuavs = level.activeuavs[team];
        activeuavsandsatellites = activeuavs + (isDefined(level.activesatellites) ? level.activesatellites[team] : 0);
        setteamspyplane(team, int(min(activeuavs, 2)));
        util::set_team_radar(team, activeuavsandsatellites > 0);
      }

      continue;
    }

    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      assert(isDefined(player.entnum));

      if(!isDefined(player.entnum)) {
        player.entnum = player getentitynumber();
      }

      activeuavs = level.activeuavs[player.entnum];
      activeuavsandsatellites = activeuavs + (isDefined(level.activesatellites) ? level.activesatellites[player.entnum] : 0);
      player setclientuivisibilityflag("radar_client", activeuavsandsatellites > 0);
      player.hasspyplane = int(min(activeuavs, 2));
    }
  }
}

hidealluavstosameteam() {
  foreach(uav in level.spawneduavs) {
    if(isDefined(uav)) {
      uav teams::hidetosameteam();
    }
  }
}