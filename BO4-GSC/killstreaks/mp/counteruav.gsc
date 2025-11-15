/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\counteruav.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\tweakables_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\airsupport;
#include scripts\killstreaks\killstreak_detect;
#include scripts\killstreaks\killstreak_hacking;
#include scripts\killstreaks\killstreakrules_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\killstreaks_util;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\teams\teams;
#include scripts\weapons\heatseekingmissile;

#namespace counteruav;

autoexec __init__system__() {
  system::register(#"counteruav", &__init__, undefined, #"killstreaks");
}

__init__() {
  level.activecounteruavs = [];
  level.counter_uav_offsets = buildoffsetlist((0, 0, 0), 3, 450, 450);

  if(level.teambased) {
    foreach(team, _ in level.teams) {
      level.activecounteruavs[team] = 0;
    }
  } else {
    level.activecounteruavs = [];
  }

  level.activeplayercounteruavs = [];
  level.counter_uav_entities = [];

  if(tweakables::gettweakablevalue("killstreak", "allowcounteruav")) {
    killstreaks::register_killstreak("killstreak_counteruav", &activatecounteruav);
  }

  clientfield::register("toplayer", "counteruav", 1, 1, "int");
  level thread watchcounteruavs();
  callback::on_connect(&onplayerconnect);
  callback::on_spawned(&onplayerspawned);
  callback::on_joined_team(&onplayerjoinedteam);
  callback::on_finalize_initialization(&function_3675de8b);
  callback::on_connect(&onplayerconnect);
  callback::add_callback(#"hash_425352b435722271", &fx_flesh_hit_neck_fatal);

  if(getdvarint(#"scr_cuav_offset_debug", 0)) {
    level thread waitanddebugdrawoffsetlist();
  }

}

fx_flesh_hit_neck_fatal(params) {
  foreach(player in params.players) {
    if(level.activeplayercounteruavs[player.entnum] > 0) {
      scoregiven = scoreevents::processscoreevent(#"counter_uav_assist", player, undefined, undefined);

      if(isDefined(scoregiven)) {
        player challenges::earnedcuavassistscore(scoregiven);
        killstreakindex = level.killstreakindices[#"counteruav"];
        killstreaks::killstreak_assist(player, self, killstreakindex);
      }
    }
  }
}

function_3675de8b() {
  profilestart();
  initrotatingrig();
  profilestop();

  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon(#"counteruav"), &function_bff5c062);
  }
}

function_bff5c062(cuav, attackingplayer) {
  cuav hackedprefunction(attackingplayer);
  cuav.owner = attackingplayer;
  cuav setowner(attackingplayer);
  cuav killstreaks::configure_team_internal(attackingplayer, 1);

  if(isDefined(level.var_f1edf93f)) {
    cuav notify(#"hacked");
    cuav notify(#"cancel_timeout");
    var_eb79e7c3 = int([[level.var_f1edf93f]]() * 1000);
    cuav thread killstreaks::waitfortimeout("counteruav", 30000, &ontimeout, "delete", "death", "crashing");
  }
}

onplayerconnect() {
  self.entnum = self getentitynumber();

  if(!level.teambased) {
    level.activecounteruavs[self.entnum] = 0;
  }

  level.activeplayercounteruavs[self.entnum] = 0;
}

onplayerspawned() {
  if(self enemycounteruavactive()) {
    self clientfield::set_to_player("counteruav", 1);
    return;
  }

  self clientfield::set_to_player("counteruav", 0);
}

initrotatingrig() {
  if(isDefined(level.var_98c93497)) {
    map_center = airsupport::getmapcenter();
    rotator_offset = (isDefined(level.var_98c93497) ? level.var_98c93497 : map_center[0], isDefined(level.var_31be45ec) ? level.var_31be45ec : map_center[1], isDefined(level.var_8ac94558) ? level.var_8ac94558 : 1200);
    level.var_f6bf445b = spawn("script_model", rotator_offset);
  } else {
    level.var_f6bf445b = spawn("script_model", airsupport::getmapcenter() + (isDefined(level.var_f2afd3a) ? level.var_f2afd3a : 0, isDefined(level.var_e500f46c) ? level.var_e500f46c : 0, 1200));
  }

  level.var_f6bf445b setModel(#"tag_origin");
  level.var_f6bf445b.angles = (0, 115, 0);
  level.var_f6bf445b hide();
  level.var_f6bf445b thread rotaterig();
  level.var_f6bf445b thread swayrig();
}

rotaterig() {
  for(;;) {
    self rotateyaw(360, 60);
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

generaterandompoints(count) {
  points = [];

  for(i = 0; i < count; i++) {
    point = airsupport::getrandommappoint(isDefined(level.cuav_map_x_offset) ? level.cuav_map_x_offset : 0, isDefined(level.cuav_map_y_offset) ? level.cuav_map_y_offset : 0, isDefined(level.cuav_map_x_percentage) ? level.cuav_map_x_percentage : 0.5, isDefined(level.cuav_map_y_percentage) ? level.cuav_map_y_percentage : 0.5);
    minflyheight = airsupport::getminimumflyheight();
    point += (0, 0, minflyheight + (isDefined(level.counter_uav_position_z_offset) ? level.counter_uav_position_z_offset : 1000));
    points[i] = point;
  }

  return points;
}

movementmanagerthink(teamorentnum) {
  while(true) {
    level waittill(#"counter_uav_updated");
    activecount = 0;

    while(level.activecounteruavs[teamorentnum] > 0) {
      if(activecount == 0) {
        activecount = level.activecounteruavs[teamorentnum];
      }

      currentindex = level.counter_uav_position_index[teamorentnum];

      for(newindex = currentindex; newindex == currentindex; newindex = randomintrange(0, 20)) {}

      destination = level.counter_uav_positions[newindex];
      level.counter_uav_position_index[teamorentnum] = newindex;
      level notify("counter_uav_move_" + teamorentnum);
      wait 5 + randomintrange(5, 10);
    }
  }
}

getcurrentposition(teamorentnum) {
  baseposition = level.counter_uav_positions[level.counter_uav_position_index[teamorentnum]];
  offset = level.counter_uav_offsets[self.cuav_offset_index];
  return baseposition + offset;
}

assignfirstavailableoffsetindex() {
  self.cuav_offset_index = getfirstavailableoffsetindex();
  maintaincouteruaventities();
}

getfirstavailableoffsetindex() {
  available_offsets = [];

  for(i = 0; i < level.counter_uav_offsets.size; i++) {
    available_offsets[i] = 1;
  }

  foreach(cuav in level.counter_uav_entities) {
    if(isDefined(cuav)) {
      available_offsets[cuav.cuav_offset_index] = 0;
    }
  }

  for(i = 0; i < available_offsets.size; i++) {
    if(available_offsets[i]) {
      return i;
    }
  }

  util::warning("<dev string:x38>");

    return 0;
}

maintaincouteruaventities() {
  for(i = level.counter_uav_entities.size; i >= 0; i--) {
    if(!isDefined(level.counter_uav_entities[i])) {
      arrayremoveindex(level.counter_uav_entities, i);
    }
  }
}

waitanddebugdrawoffsetlist() {
  level endon(#"game_ended");
  wait 10;
  debugdrawoffsetlist();
}

debugdrawoffsetlist() {
  baseposition = level.counter_uav_positions[0];

  foreach(offset in level.counter_uav_offsets) {
    util::debug_sphere(baseposition + offset, 24, (0.95, 0.05, 0.05), 0.75, 9999999);
  }
}

  function buildoffsetlist(startoffset, depth, offset_x, offset_y) {
    offsets = [];

    for(col = 0; col < depth; col++) {
      itemcount = math::pow(2, col);
      startingindex = itemcount - 1;

      for(i = 0; i < itemcount; i++) {
        x = offset_x * col;
        y = 0;

        if(itemcount > 1) {
          y = i * offset_y;
          total_y = offset_y * startingindex;
          y -= total_y / 2;
        }

        offsets[startingindex + i] = startoffset + (x, y, 0);
      }
    }

    return offsets;
  }

function_af281272() {
  self endon(#"delete");
  waitresult = self waittill(#"death");

  if(!isDefined(self)) {
    return;
  }

  destroycounteruav(waitresult.attacker, waitresult.weapon);
}

activatecounteruav() {
  if(self killstreakrules::iskillstreakallowed("counteruav", self.team) == 0) {
    return false;
  }

  killstreak_id = self killstreakrules::killstreakstart("counteruav", self.team);

  if(killstreak_id == -1) {
    return false;
  }

  counteruav = spawncounteruav(self, killstreak_id);

  if(!isDefined(counteruav)) {
    return false;
  }

  counteruav clientfield::set("enemyvehicle", 1);
  counteruav.killstreak_id = killstreak_id;
  counteruav thread killstreaks::waittillemp(&destroycounteruavbyemp);
  counteruav thread killstreaks::waitfortimeout("counteruav", 30000, &ontimeout, "delete", "death", "crashing");
  counteruav thread killstreaks::waitfortimecheck(30000 / 2, &ontimecheck, "delete", "death", "crashing");
  counteruav thread function_af281272();
  counteruav thread killstreaks::function_2b6aa9e8("counteruav", &destroycounteruav, &onlowhealth, undefined);
  counteruav playLoopSound("veh_uav_engine_loop", 1);
  counteruav function_7c61ce31();
  self killstreaks::play_killstreak_start_dialog("counteruav", self.team, killstreak_id);
  counteruav killstreaks::play_pilot_dialog_on_owner("arrive", "counteruav", killstreak_id);
  counteruav thread killstreaks::player_killstreak_threat_tracking("counteruav");
  self stats::function_e24eec31(getweapon("counteruav"), #"used", 1);
  return true;
}

function_7c61ce31() {
  minflyheight = int(airsupport::getminimumflyheight());
  zoffset = minflyheight + (isDefined(level.var_97961f83) ? level.var_97961f83 : 2500);
  angle = randomint(360);
  radiusoffset = (isDefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000) + randomint(isDefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000);
  xoffset = cos(angle) * radiusoffset;
  yoffset = sin(angle) * radiusoffset;
  anglevector = vectornormalize((xoffset, yoffset, zoffset));
  anglevector *= zoffset;
  anglevector = (anglevector[0], anglevector[1], zoffset - level.var_f6bf445b.origin[2]);
  self linkto(level.var_f6bf445b, "tag_origin", anglevector, (0, angle + 90, 0));
}

hackedprefunction(hacker) {
  cuav = self;
  cuav resetactivecounteruav();
}

spawncounteruav(owner, killstreak_id) {
  minflyheight = airsupport::getminimumflyheight();
  bundle = struct::get_script_bundle("killstreak", "killstreak_counteruav");
  cuav = spawnvehicle(bundle.ksvehicle, airsupport::getmapcenter() + (0, 0, minflyheight + (isDefined(level.counter_uav_position_z_offset) ? level.counter_uav_position_z_offset : 1000)), (0, 0, 0), "counteruav");
  cuav assignfirstavailableoffsetindex();
  cuav killstreaks::configure_team("counteruav", killstreak_id, owner, undefined, undefined, &configureteampost);
  cuav killstreak_hacking::enable_hacking("counteruav", &hackedprefunction, undefined);
  cuav.targetname = "counteruav";
  cuav util::make_sentient();
  cuav.weapon = getweapon("counteruav");
  cuav setweapon(cuav.weapon);
  killstreak_detect::killstreaktargetset(cuav);
  cuav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", undefined, 1);
  cuav setdrawinfrared(1);

  if(!isDefined(level.counter_uav_entities)) {
    level.counter_uav_entities = [];
  } else if(!isarray(level.counter_uav_entities)) {
    level.counter_uav_entities = array(level.counter_uav_entities);
  }

  level.counter_uav_entities[level.counter_uav_entities.size] = cuav;
  return cuav;
}

configureteampost(owner, ishacked) {
  cuav = self;

  if(ishacked == 0) {
    cuav teams::hidetosameteam();
  } else {
    cuav setvisibletoall();
  }

  cuav thread teams::waituntilteamchangesingleton(owner, "CUAV_watch_team_change_" + cuav getentitynumber(), &onteamchange, self.entnum, "death", "leaving", "crashing");
  cuav addactivecounteruav();
}

listenformove() {
  self endon(#"death", #"leaving");

  while(true) {
    self thread counteruavmove();
    level waittill("counter_uav_move_" + self.team, "counter_uav_move_" + self.ownerentnum);
  }
}

counteruavmove() {
  self endon(#"death", #"leaving");
  level endon("counter_uav_move_" + self.team);
  destination = (0, 0, 0);

  if(level.teambased) {
    destination = self getcurrentposition(self.team);
  } else {
    destination = self getcurrentposition(self.ownerentnum);
  }

  lookangles = vectortoangles(destination - self.origin);
  rotationaccelerationduration = 0.5 * 0.2;
  rotationdecelerationduration = 0.5 * 0.2;
  travelaccelerationduration = 5 * 0.2;
  traveldecelerationduration = 5 * 0.2;
  self setgoal(destination, 1, 0);
}

playFX(name) {
  self endon(#"death");
  wait 0.1;

  if(isDefined(self)) {
    playFXOnTag(name, self, "tag_origin");
  }
}

onlowhealth(attacker, weapon) {
  self.is_damaged = 1;
  params = level.killstreakbundle[#"counteruav"];

  if(isDefined(params.fxlowhealth)) {
    playFXOnTag(params.fxlowhealth, self, "tag_origin");
  }
}

onteamchange(entnum, event) {
  destroycounteruav(undefined, undefined);
}

onplayerjoinedteam(params) {
  hideallcounteruavstosameteam();
}

ontimeout() {
  self.leaving = 1;

  if(isDefined(level.var_14151f16)) {
    [[level.var_14151f16]](self, 0);
  }

  self.owner globallogic_audio::play_taacom_dialog("timeout", "counteruav");
  self airsupport::leave(5);
  wait 5;
  self removeactivecounteruav();

  if(target_istarget(self)) {
    target_remove(self);
  }

  self delete();
}

ontimecheck() {
  self killstreaks::play_pilot_dialog_on_owner("timecheck", "counteruav", self.killstreak_id);
}

destroycounteruavbyemp(attacker, arg) {
  destroycounteruav(attacker, getweapon(#"emp"));
}

destroycounteruav(attacker, weapon) {
  if(self.leaving !== 1) {
    self killstreaks::play_destroyed_dialog_on_owner("counteruav", self.killstreak_id);
  }

  attacker = self[[level.figure_out_attacker]](attacker);

  if(isDefined(attacker) && (!isDefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
    attacker battlechatter::function_dd6a6012("counteruav", weapon);
    challenges::destroyedaircraft(attacker, weapon, 0, 0);
    self killstreaks::function_73566ec7(attacker, weapon, self.owner);
    luinotifyevent(#"player_callout", 2, #"hash_3544b7c59fa5c59c", attacker.entnum);
    attacker challenges::addflyswatterstat(weapon, self);
  }

  self.var_d02ddb8e = weapon;
  self playSound(#"evt_helicopter_midair_exp");
  self removeactivecounteruav();

  if(target_istarget(self)) {
    target_remove(self);
  }

  self thread deletecounteruav();
}

deletecounteruav() {
  self notify(#"crashing");
  params = level.killstreakbundle[#"counteruav"];

  if(isDefined(params.ksexplosionfx)) {
    self thread playFX(params.ksexplosionfx);
  }

  if(isDefined(params.var_bb6c29b4) && isDefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle")) {
    self thread playFX(params.var_bb6c29b4);
  }

  wait 0.1;

  if(isDefined(self)) {
    self setModel(#"tag_origin");
  }

  wait 0.2;

  if(isDefined(self)) {
    self notify(#"delete");
    self delete();
  }
}

enemycounteruavactive() {
  if(level.teambased) {
    foreach(team, _ in level.teams) {
      if(team == self.team) {
        continue;
      }

      if(teamhasactivecounteruav(team)) {
        return true;
      }
    }
  } else {
    enemies = self teams::getenemyplayers();

    foreach(player in enemies) {
      if(player hasactivecounteruav()) {
        return true;
      }
    }
  }

  return false;
}

hasactivecounteruav() {
  return level.activecounteruavs[self.entnum] > 0;
}

teamhasactivecounteruav(team) {
  return level.activecounteruavs[team] > 0;
}

hasindexactivecounteruav(team_or_entnum) {
  return level.activecounteruavs[team_or_entnum] > 0;
}

addactivecounteruav() {
  if(level.teambased) {
    level.activecounteruavs[self.team]++;

    foreach(team, _ in level.teams) {
      if(!util::function_fbce7263(team, self.team)) {
        continue;
      }

      if(killstreaks::hassatellite(team)) {
        self.owner challenges::blockedsatellite();
      }
    }
  } else {
    level.activecounteruavs[self.ownerentnum]++;
    keys = getarraykeys(level.activecounteruavs);

    for(i = 0; i < keys.size; i++) {
      if(keys[i] == self.ownerentnum) {
        continue;
      }

      if(killstreaks::hassatellite(keys[i])) {
        self.owner challenges::blockedsatellite();
        break;
      }
    }
  }

  level.activeplayercounteruavs[self.ownerentnum]++;
  level notify(#"counter_uav_updated");
}

removeactivecounteruav() {
  cuav = self;
  cuav resetactivecounteruav();
  cuav killstreakrules::killstreakstop("counteruav", self.originalteam, self.killstreak_id);
}

resetactivecounteruav() {
  if(level.teambased) {
    level.activecounteruavs[self.team]--;
    assert(level.activecounteruavs[self.team] >= 0);

    if(level.activecounteruavs[self.team] < 0) {
      level.activecounteruavs[self.team] = 0;
    }
  } else if(isDefined(self.owner)) {
    assert(isDefined(self.ownerentnum));

    if(!isDefined(self.ownerentnum)) {
      self.ownerentnum = self.owner getentitynumber();
    }

    level.activecounteruavs[self.ownerentnum]--;
    assert(level.activecounteruavs[self.ownerentnum] >= 0);

    if(level.activecounteruavs[self.ownerentnum] < 0) {
      level.activecounteruavs[self.ownerentnum] = 0;
    }
  }

  level.activeplayercounteruavs[self.ownerentnum]--;
  level notify(#"counter_uav_updated");
}

watchcounteruavs() {
  while(true) {
    level waittill(#"counter_uav_updated");

    foreach(player in level.players) {
      if(player enemycounteruavactive()) {
        player clientfield::set_to_player("counteruav", 1);
        continue;
      }

      player clientfield::set_to_player("counteruav", 0);
    }
  }
}

hideallcounteruavstosameteam() {
  foreach(counteruav in level.counter_uav_entities) {
    if(isDefined(counteruav)) {
      counteruav teams::hidetosameteam();
    }
  }
}