/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_ai_faller.gsc
******************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#using_animtree("generic_human");
faller_init() {
  level._zombie_fall_anims["zombie"] = [];
  level._zombie_fall_anims["zombie"]["default"] = % ai_zombie_jump_down_72;
  level._zombie_fall_anims["zombie"]["emerge"] = % ai_zombie_ceiling_emerge_01;
  level._zombie_fall_anims["zombie"]["fall"] = % ai_zombie_ceiling_dropdown_01;
  level._zombie_fall_anims["zombie"]["fall_loop"] = % ai_zombie_ceiling_fall_loop;
  level._zombie_fall_anims["zombie"]["land"][0] = % ai_zombie_ceiling_fall_land;
  level._zombie_fall_anims["zombie"]["land"][1] = % ai_zombie_ceiling_fall_land_02;
  level._zombie_fall_anims["zombie"]["attack"][0] = % ai_zombie_ceiling_attack_01;
  level._zombie_fall_anims["zombie"]["attack"][1] = % ai_zombie_ceiling_attack_02;
  level._zombie_fall_anims["zombie"]["emerge_death"] = % ai_zombie_ceiling_death;
  level.zombie_custom_think_logic = ::check_do_zombie_fall;
  level thread setup_faller_locations();
}

setup_faller_locations() {
  flag_wait("zones_initialized");
  zkeys = GetArrayKeys(level.zones);
  for(i = 0; i < level.zones.size; i++) {
    zone = level.zones[zkeys[i]];
    if(isDefined(zone.volumes[0].target)) {
      zone.fall_locations = GetStructArray(zone.volumes[0].target + "_fall", "targetname");
      for(x = 0; x < zone.fall_locations.size; x++) {
        zone.fall_locations[x].is_enabled = true;
      }
    }
  }
}

get_available_fall_locations() {
  level.zombie_fall_spawners = [];
  zone = level.zones[self.zone_name];
  if(isDefined(zone)) {
    for(x = 0; x < zone.fall_locations.size; x++) {
      if(zone.fall_locations[x].is_enabled) {
        level.zombie_fall_spawners[level.zombie_fall_spawners.size] = zone.fall_locations[x];
      }
    }
  } else {
    spots = GetStructArray("zombie_fall", "targetname");
    for(x = 0; x < spots.size; x++) {
      if(spots[x].is_enabled) {
        level.zombie_fall_spawners[level.zombie_fall_spawners.size] = spots[x];
      }
    }
  }
  return level.zombie_fall_spawners;
}

round_spawning_fall_test() {
  while(true) {
    spawn_points = [];
    for(i = 0; i < level.enemy_spawns.size; i++) {
      spawner = level.enemy_spawns[i];
      if(isDefined(spawner.script_string) && spawner.script_string == "faller") {
        spawn_points[spawn_points.size] = spawner;
      }
    }
    player = GetPlayers()[0];
    bestPoint = undefined;
    bestDist = 0.0;
    for(i = 0; i < spawn_points.size; i++) {
      checkDist = distanceSquared(spawn_points[i].origin, player.origin);
      if(!isDefined(bestPoint) || checkDist < bestDist) {
        bestPoint = spawn_points[i];
        bestDist = checkDist;
      }
    }
    if(isDefined(bestPoint)) {
      ai = spawn_zombie(bestPoint);
      ai waittill("death");
    }
    wait 5;
  }
}

check_do_zombie_fall() {
  if((GetDvarInt(#"zombie_fall_test") || (isDefined(self.script_string) && self.script_string == "faller"))) {
    self thread do_zombie_fall();
    return true;
  }
  return false;
}

zombie_faller_delete() {
  level.zombie_total++;
  self maps\_zombiemode_spawner::reset_attack_spot();
  if(isDefined(self.zombie_faller_location)) {
    self.zombie_faller_location.is_enabled = true;
    self.zombie_faller_location = undefined;
  }
  self Delete();
}

parse_script_parameters() {
  if(isDefined(self.script_parameters)) {
    parms = strtok(self.script_parameters, ";");
    if(isDefined(parms) && parms.size > 0) {
      for(i = 0; i < parms.size; i++) {
        if(parms[i] == "drop_now") {
          self.drop_now = true;
        }
        if(parms[i] == "drop_not_occupied") {
          self.drop_not_occupied = true;
        }
      }
    }
  }
}

setup_deathfunc() {
  self endon("death");
  while(!is_true(self.zombie_init_done)) {
    wait_network_frame();
  }
  self.deathFunction = ::zombie_fall_death_func;
}

do_zombie_fall() {
  self endon("death");
  self thread setup_deathfunc();
  self.no_powerups = true;
  self.in_the_ceiling = true;
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkto(self.anchor);
  if(!isDefined(self.zone_name)) {
    self.zone_name = self get_current_zone();
  }
  spots = get_available_fall_locations();
  if(spots.size < 1) {
    self unlink();
    self.anchor delete();
    self hide();
    self delayThread(0.1, ::zombie_faller_delete);
    return;
  } else if(GetDvarInt(#"zombie_fall_test")) {
    player = GetPlayers()[0];
    spot = undefined;
    bestDist = 0.0;
    for(i = 0; i < spots.size; i++) {
      checkDist = distanceSquared(spots[i].origin, player.origin);
      if(!isDefined(spot) || checkDist < bestDist) {
        spot = spots[i];
        bestDist = checkDist;
      }
    }
  } else {
    spot = random(spots);
  }
  self.zombie_faller_location = spot;
  self.zombie_faller_location.is_enabled = false;
  self.zombie_faller_location parse_script_parameters();
  if(!isDefined(spot.angles)) {
    spot.angles = (0, 0, 0);
  }
  anim_org = spot.origin;
  anim_ang = spot.angles;
  self hide();
  self.anchor moveTo(anim_org, .05);
  self.anchor waittill("movedone");
  target_org = maps\_zombiemode_spawner::get_desired_origin();
  if(isDefined(target_org)) {
    anim_ang = VectorToAngles(target_org - self.origin);
    self.anchor RotateTo((0, anim_ang[1], 0), .05);
    self.anchor waittill("rotatedone");
  }
  self unlink();
  self.anchor delete();
  self thread hide_pop();
  level thread zombie_fall_death(self, spot);
  spot thread zombie_fall_fx(self);
  self thread zombie_faller_death_wait();
  self thread zombie_faller_do_fall();
}

zombie_faller_do_fall() {
  self endon("death");
  emerge_anim = self get_fall_emerge_anim();
  self AnimScripted("fall_emerge", self.origin, self.zombie_faller_location.angles, emerge_anim);
  self animscripts\zombie_shared::DoNoteTracks("fall_emerge", ::handle_fall_notetracks, undefined, self.zombie_faller_location);
  self.zombie_faller_wait_start = GetTime();
  self.zombie_faller_should_drop = false;
  self thread zombie_fall_wait();
  self thread zombie_faller_watch_all_players();
  while(!self.zombie_faller_should_drop) {
    if(self zombie_fall_should_attack(self.zombie_faller_location)) {
      attack_anim = self get_attack_anim(self.zombie_faller_location);
      self AnimScripted("attack", self.origin, self.zombie_faller_location.angles, attack_anim);
      self animscripts\zombie_shared::DoNoteTracks("attack", ::handle_fall_notetracks, undefined, self.zombie_faller_location);
      if(!(self zombie_faller_always_drop()) && randomfloat(1) > 0.5) {
        self.zombie_faller_should_drop = true;
      }
    } else {
      if((self zombie_faller_always_drop())) {
        self.zombie_faller_should_drop = true;
        break;
      } else if(GetTime() >= self.zombie_faller_wait_start + 20000) {
        self.zombie_faller_should_drop = true;
        break;
      } else if(self zombie_faller_drop_not_occupied()) {
        self.zombie_faller_should_drop = true;
        break;
      } else {
        attack_anim = self get_attack_anim(self.zombie_faller_location);
        self AnimScripted("attack", self.origin, self.zombie_faller_location.angles, attack_anim);
        self animscripts\zombie_shared::DoNoteTracks("attack", ::handle_fall_notetracks, undefined, self.zombie_faller_location);
      }
    }
  }
  self notify("falling");
  spot = self.zombie_faller_location;
  self zombie_faller_enable_location();
  fall_anim = self get_fall_anim(spot);
  self AnimScripted("fall", self.origin, spot.angles, fall_anim);
  self animscripts\zombie_shared::DoNoteTracks("fall", ::handle_fall_notetracks, undefined, spot);
  self.deathFunction = maps\_zombiemode_spawner::zombie_death_animscript;
  self notify("fall_anim_finished");
  spot notify("stop_zombie_fall_fx");
  self StopAnimScripted();
  landAnim = random(level._zombie_fall_anims["zombie"]["land"]);
  landAnimDelta = 15;
  ground_pos = groundpos_ignore_water_new(self.origin);
  physDist = self.origin[2] - ground_pos[2] + landAnimDelta;
  if(physDist > 0) {
    fallAnim = level._zombie_fall_anims["zombie"]["fall_loop"];
    if(isDefined(fallAnim)) {
      self.fall_anim = fallAnim;
      self animcustom(::zombie_fall_loop);
      self waittill("faller_on_ground");
    }
    self.landAnim = landAnim;
    self animcustom(::zombie_land);
    wait(GetAnimLength(landAnim));
  }
  self.in_the_ceiling = false;
  self traverseMode("gravity");
  self SetAnimKnobAllRestart(animscripts\zombie_run::GetRunAnim(), %body, 1, 0.2, 1);
  self.no_powerups = false;
  self notify("zombie_custom_think_done", spot.script_noteworthy);
}

zombie_fall_loop() {
  self endon("death");
  self setFlaggedAnimKnobRestart("fall_loop", self.fall_anim, 1, 0.20, 1.0);
  while(1) {
    ground_pos = groundpos_ignore_water_new(self.origin);
    if(self.origin[2] - ground_pos[2] < 20) {
      self notify("faller_on_ground");
      break;
    }
    wait .05;
  }
}

zombie_land() {
  self setFlaggedAnimKnobRestart("land", self.landAnim, 1, 0.20, 1.0);
  wait(GetAnimLength(self.landAnim));
}

zombie_faller_always_drop() {
  if(isDefined(self.zombie_faller_location.drop_now)) {
    if(self.zombie_faller_location.drop_now == true) {
      return true;
    }
  }
  return false;
}

zombie_faller_drop_not_occupied() {
  if(is_true(self.zombie_faller_location.drop_not_occupied)) {
    if(isDefined(self.zone_name) && isDefined(level.zones[self.zone_name])) {
      return !level.zones[self.zone_name].is_occupied;
    }
  }
  return false;
}

zombie_faller_watch_all_players() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    self thread zombie_faller_watch_player(players[i]);
  }
}

zombie_faller_watch_player(player) {
  self endon("falling");
  self endon("death");
  player endon("disconnect");
  range = 200;
  rangeSqr = range * range;
  timer = 5000;
  inRange = false;
  inRangeTime = 0;
  closeRange = 60;
  closeRangeSqr = closeRange * closeRange;
  dirToPlayerEnter = (0, 0, 0);
  inCloseRange = false;
  while(1) {
    distSqr = distance2dsquared(self.origin, player.origin);
    if(distSqr < rangeSqr) {
      if(inRange) {
        if(inRangeTime + timer < GetTime()) {
          self.zombie_faller_should_drop = true;
          break;
        }
      } else {
        inRange = true;
        inRangeTime = GetTime();
      }
    } else {
      inRange = false;
    }
    if(distSqr < closeRangeSqr) {
      if(!inCloseRange) {
        dirToPlayerEnter = player.origin - self.origin;
        dirToPlayerEnter = (dirToPlayerEnter[0], dirToPlayerEnter[1], 0.0);
        dirToPlayerEnter = vectornormalize(dirToPlayerEnter);
      }
      inCloseRange = true;
    } else {
      if(inCloseRange) {
        dirToPlayerExit = player.origin - self.origin;
        dirToPlayerExit = (dirToPlayerExit[0], dirToPlayerExit[1], 0.0);
        dirToPlayerExit = vectornormalize(dirToPlayerExit);
        if(vectordot(dirToPlayerEnter, dirToPlayerExit) < 0) {
          self.zombie_faller_should_drop = true;
          break;
        }
      }
      inCloseRange = false;
    }
    wait .1;
  }
}

zombie_fall_wait() {
  self endon("falling");
  self endon("death");
  if(isDefined(self.zone_name)) {
    if(isDefined(level.zones) && isDefined(level.zones[self.zone_name])) {
      zone = level.zones[self.zone_name];
      while(1) {
        if((!zone.is_enabled || !zone.is_active)) {
          if(!(self potentially_visible(1500))) {
            if(self.health != level.zombie_health) {
              self.zombie_faller_should_drop = true;
              break;
            } else {
              self zombie_faller_delete();
              return;
            }
          }
        }
        wait(0.5);
      }
    }
  }
}

zombie_fall_should_attack(spot) {
  victims = zombie_fall_get_vicitims(spot);
  return victims.size > 0;
}

zombie_fall_get_vicitims(spot) {
  ret = [];
  players = GetPlayers();
  checkDist2 = 40.0;
  checkDist2 *= checkDist2;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(player maps\_laststand::player_is_in_laststand()) {
      continue;
    }
    stance = player GetStance();
    if(stance == "crouch" || stance == "prone") {
      continue;
    }
    zCheck = self.origin[2] - player.origin[2];
    if(zCheck < 0.0 || zCheck > 120.0) {
      continue;
    }
    dist2 = Distance2DSquared(player.origin, self.origin);
    if(dist2 < checkDist2) {
      ret[ret.size] = player;
    }
  }
  return ret;
}

get_fall_emerge_anim(spot) {
  return level._zombie_fall_anims[self.animname]["emerge"];
}

get_fall_anim(spot) {
  return level._zombie_fall_anims[self.animname]["fall"];
}

get_attack_anim(spot) {
  return random(level._zombie_fall_anims[self.animname]["attack"]);
}

zombie_faller_enable_location() {
  if(isDefined(self.zombie_faller_location)) {
    self.zombie_faller_location.is_enabled = true;
    self.zombie_faller_location = undefined;
  }
}

zombie_faller_death_wait() {
  self waittill("death");
  self endon("falling");
  self zombie_faller_enable_location();
}

zombie_fall_death_func() {
  self animmode("noclip");
  self.deathanim = level._zombie_fall_anims["zombie"]["emerge_death"];
  return self maps\_zombiemode_spawner::zombie_death_animscript();
}

zombie_fall_death(zombie, spot) {
  zombie endon("fall_anim_finished");
  while(zombie.health > 1) {
    zombie waittill("damage", amount, attacker, dir, p, type);
  }
  zombie StopAnimScripted();
  spot notify("stop_zombie_fall_fx");
}

_damage_mod_to_damage_type(type) {
  toks = strtok(type, "_");
  if(toks.size < 2) {
    return type;
  }
  returnStr = toks[1];
  for(i = 2; i < toks.size; i++) {
    returnStr += toks[i];
  }
  returnStr = tolower(returnStr);
  return returnStr;
}

zombie_fall_fx(zombie) {
  self thread zombie_fall_dust_fx(zombie);
  self thread zombie_fall_burst_fx();
  playsoundatposition("zmb_zombie_spawn", self.origin);
  zombie endon("death");
  self endon("stop_zombie_fall_fx");
  wait 1;
  if(zombie.zombie_move_speed != "sprint") {
    wait 1;
  }
}

zombie_fall_burst_fx() {
  self endon("stop_zombie_fall_fx");
  self endon("fall_anim_finished");
  playFX(level._effect["rise_burst"], self.origin + (0, 0, randomintrange(5, 10)));
  wait(.25);
  playFX(level._effect["rise_billow"], self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
}

zombie_fall_dust_fx(zombie) {
  dust_tag = "J_SpineUpper";
  self endon("stop_zombie_fall_dust_fx");
  self thread stop_zombie_fall_dust_fx(zombie);
  dust_time = 7.5;
  dust_interval = .1;
  for(t = 0; t < dust_time; t += dust_interval) {
    playFXOnTag(level._effect["rise_dust"], zombie, dust_tag);
    wait dust_interval;
  }
}

stop_zombie_fall_dust_fx(zombie) {
  zombie waittill("death");
  self notify("stop_zombie_fall_dust_fx");
}

handle_fall_notetracks(note, spot) {
  if(note == "deathout") {
    self.deathFunction = ::faller_death_ragdoll;
  } else if(note == "fire") {
    victims = zombie_fall_get_vicitims(spot);
    for(i = 0; i < victims.size; i++) {
      victims[i] DoDamage(self.meleeDamage, self.origin, self, 0, "MOD_MELEE");
      self.zombie_faller_should_drop = true;
    }
  }
}

faller_death_ragdoll() {
  self StartRagdoll();
  self launchragdoll((0, 0, -1));
  return self maps\_zombiemode_spawner::zombie_death_animscript();
}

hide_pop() {
  self endon("death");
  wait(0.5);
  if(isDefined(self)) {
    self Show();
  }
}

in_player_fov(player) {
  playerAngles = player getplayerangles();
  playerForwardVec = anglesToForward(playerAngles);
  playerUnitForwardVec = VectorNormalize(playerForwardVec);
  banzaiPos = self.origin;
  playerPos = player GetOrigin();
  playerToBanzaiVec = banzaiPos - playerPos;
  playerToBanzaiUnitVec = VectorNormalize(playerToBanzaiVec);
  forwardDotBanzai = VectorDot(playerUnitForwardVec, playerToBanzaiUnitVec);
  angleFromCenter = ACos(forwardDotBanzai);
  playerFOV = GetDvarFloat(#"cg_fov");
  banzaiVsPlayerFOVBuffer = GetDvarFloat(#"g_banzai_player_fov_buffer");
  if(banzaiVsPlayerFOVBuffer <= 0) {
    banzaiVsPlayerFOVBuffer = 0.2;
  }
  inPlayerFov = (angleFromCenter <= (playerFOV * 0.5 * (1 - banzaiVsPlayerFOVBuffer)));
  return inPlayerFov;
}

potentially_visible(how_close) {
  if(!isDefined(how_close)) {
    how_close = 1000;
  }
  potentiallyVisible = false;
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    dist = Distance(self.origin, players[i].origin);
    if(dist < how_close) {
      inPlayerFov = self in_player_fov(players[i]);
      if(inPlayerFov) {
        potentiallyVisible = true;
        break;
      }
    }
  }
  return potentiallyVisible;
}