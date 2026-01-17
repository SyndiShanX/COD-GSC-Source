/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_faller.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#namespace zm_ai_faller;

function autoexec init() {
  initfallerbehaviorsandasm();
  animationstatenetwork::registernotetrackhandlerfunction("faller_melee", &handle_fall_notetracks);
  animationstatenetwork::registernotetrackhandlerfunction("deathout", &handle_fall_death_notetracks);
}

function private initfallerbehaviorsandasm() {
  behaviortreenetworkutility::registerbehaviortreeaction("fallerDropAction", &fallerdropaction, &fallerdropactionupdate, &fallerdropactionterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldFallerDrop", &shouldfallerdrop);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isFallerInCeiling", &isfallerinceiling);
  behaviortreenetworkutility::registerbehaviortreescriptapi("fallerCeilingDeath", &fallerceilingdeath);
  animationstatenetwork::registeranimationmocomp("mocomp_drop@faller", &mocompfallerdrop, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_ceiling_death@faller", &mocompceilingdeath, undefined, undefined);
}

function fallerdropaction(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  return 5;
}

function fallerdropactionupdate(entity, asmstatename) {
  ground_pos = zm_utility::groundpos_ignore_water_new(entity.origin);
  if((entity.origin[2] - ground_pos[2]) < 20) {
    return 4;
  }
  return 5;
}

function fallerdropactionterminate(entity, asmstatename) {
  entity.faller_drop = 0;
  return 4;
}

function shouldfallerdrop(entity) {
  if(isDefined(entity.faller_drop) && entity.faller_drop) {
    return true;
  }
  return false;
}

function isfallerinceiling(entity) {
  if(isDefined(entity.in_the_ceiling) && entity.in_the_ceiling && (!(isDefined(entity.normal_death) && entity.normal_death))) {
    return true;
  }
  return false;
}

function fallerceilingdeath(entity) {}

function private mocompfallerdrop(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("nogravity", 0);
}

function private mocompceilingdeath(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("noclip", 0);
}

function zombie_faller_delete() {
  level.zombie_total++;
  self zombie_utility::reset_attack_spot();
  if(isDefined(self.zombie_faller_location)) {
    self.zombie_faller_location.is_enabled = 1;
    self.zombie_faller_location = undefined;
  }
  self delete();
}

function faller_script_parameters() {
  if(isDefined(self.script_parameters)) {
    parms = strtok(self.script_parameters, ";");
    if(isDefined(parms) && parms.size > 0) {
      for(i = 0; i < parms.size; i++) {
        if(parms[i] == "drop_now") {
          self.drop_now = 1;
        }
        if(parms[i] == "drop_not_occupied") {
          self.drop_not_occupied = 1;
        }
        if(parms[i] == "emerge_top") {
          self.emerge_top = 1;
        }
        if(parms[i] == "emerge_bottom") {
          self.emerge_bottom = 1;
        }
      }
    }
  }
}

function setup_deathfunc(func_name) {
  self endon("death");
  while(!(isDefined(self.zombie_init_done) && self.zombie_init_done)) {
    util::wait_network_frame();
  }
  if(isDefined(func_name)) {
    self.deathfunction = func_name;
  } else {
    if(isDefined(level.custom_faller_death)) {
      self.deathfunction = level.custom_faller_death;
    } else {
      self.deathfunction = &zombie_fall_death_func;
    }
  }
}

function do_zombie_fall(spot) {
  self endon("death");
  if(!(isDefined(level.faller_init) && level.faller_init)) {
    level.faller_init = 1;
    faller_anim = self animmappingsearch(istring("anim_faller_emerge"));
    level.faller_emerge_time = getanimlength(faller_anim);
    faller_anim = self animmappingsearch(istring("anim_faller_attack_01"));
    level.faller_attack_01_time = getanimlength(faller_anim);
    faller_anim = self animmappingsearch(istring("anim_faller_attack_02"));
    level.faller_attack_02_time = getanimlength(faller_anim);
    faller_anim = self animmappingsearch(istring("anim_faller_fall"));
    level.faller_fall_time = getanimlength(faller_anim);
  }
  self.zombie_faller_location = spot;
  self.zombie_faller_location.is_enabled = 0;
  self.zombie_faller_location faller_script_parameters();
  if(isDefined(self.zombie_faller_location.emerge_bottom) && self.zombie_faller_location.emerge_bottom || (isDefined(self.zombie_faller_location.emerge_top) && self.zombie_faller_location.emerge_top)) {
    self do_zombie_emerge(spot);
    return;
  }
  self thread setup_deathfunc();
  self.no_powerups = 1;
  self.in_the_ceiling = 1;
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkto(self.anchor);
  if(!isDefined(spot.angles)) {
    spot.angles = (0, 0, 0);
  }
  anim_org = spot.origin;
  anim_ang = spot.angles;
  self ghost();
  self.anchor moveto(anim_org, 0.05);
  self.anchor waittill("movedone");
  target_org = zombie_utility::get_desired_origin();
  if(isDefined(target_org)) {
    anim_ang = vectortoangles(target_org - self.origin);
    self.anchor rotateto((0, anim_ang[1], 0), 0.05);
    self.anchor waittill("rotatedone");
  }
  self unlink();
  if(isDefined(self.anchor)) {
    self.anchor delete();
  }
  self thread zombie_utility::hide_pop();
  self thread zombie_fall_death(spot);
  self thread zombie_fall_fx(spot);
  self thread zombie_faller_death_wait();
  self thread zombie_faller_do_fall();
  self.no_powerups = 0;
  self notify("risen", spot.script_string);
}

function zombie_faller_do_fall() {
  self endon("death");
  self animscripted("fall_anim", self.origin, self.zombie_faller_location.angles, "ai_zm_dlc5_zombie_ceiling_emerge_01");
  wait(level.faller_emerge_time);
  self.zombie_faller_wait_start = gettime();
  self.zombie_faller_should_drop = 0;
  self thread zombie_fall_wait();
  self thread zombie_faller_watch_all_players();
  while(!self.zombie_faller_should_drop) {
    if(self zombie_fall_should_attack(self.zombie_faller_location)) {
      if(math::cointoss()) {
        self animscripted("fall_anim", self.origin, self.zombie_faller_location.angles, "ai_zm_dlc5_zombie_ceiling_attack_01");
        wait(level.faller_attack_01_time);
      } else {
        self animscripted("fall_anim", self.origin, self.zombie_faller_location.angles, "ai_zm_dlc5_zombie_ceiling_attack_02");
        wait(level.faller_attack_02_time);
      }
      if(!self zombie_faller_always_drop() && randomfloat(1) > 0.5) {
        self.zombie_faller_should_drop = 1;
      }
    } else {
      if(self zombie_faller_always_drop()) {
        self.zombie_faller_should_drop = 1;
        break;
      } else {
        if(gettime() >= (self.zombie_faller_wait_start + 20000)) {
          self.zombie_faller_should_drop = 1;
          break;
        } else {
          if(self zombie_faller_drop_not_occupied()) {
            self.zombie_faller_should_drop = 1;
            break;
          } else {
            if(math::cointoss()) {
              self animscripted("fall_anim", self.origin, self.zombie_faller_location.angles, "ai_zm_dlc5_zombie_ceiling_attack_01");
              wait(level.faller_attack_01_time);
            } else {
              self animscripted("fall_anim", self.origin, self.zombie_faller_location.angles, "ai_zm_dlc5_zombie_ceiling_attack_02");
              wait(level.faller_attack_02_time);
            }
          }
        }
      }
    }
  }
  self notify("falling");
  spot = self.zombie_faller_location;
  self zombie_faller_enable_location();
  self animscripted("fall_anim", self.origin, spot.angles, "ai_zm_dlc5_zombie_ceiling_dropdown_01");
  wait(level.faller_fall_time);
  self.deathfunction = &zm_spawner::zombie_death_animscript;
  self.normal_death = 1;
  self notify("fall_anim_finished");
  spot notify("stop_zombie_fall_fx");
  self stopanimscripted();
  landanimdelta = 15;
  ground_pos = zm_utility::groundpos_ignore_water_new(self.origin);
  physdist = (self.origin[2] - ground_pos[2]) + landanimdelta;
  if(physdist > 0) {
    self.faller_drop = 1;
    self waittill("zombie_land_done");
  }
  self.in_the_ceiling = 0;
  self traversemode("gravity");
  self.no_powerups = 0;
}

function zombie_fall_loop() {
  self endon("death");
  self setanimstatefromasd("zm_faller_fall_loop");
  while(true) {
    ground_pos = zm_utility::groundpos_ignore_water_new(self.origin);
    if((self.origin[2] - ground_pos[2]) < 20) {
      self notify("faller_on_ground");
      break;
    }
    wait(0.05);
  }
}

function zombie_land() {
  self setanimstatefromasd("zm_faller_land");
  zombie_shared::donotetracks("land_anim");
  self notify("zombie_land_done");
}

function zombie_faller_always_drop() {
  if(isDefined(self.zombie_faller_location.drop_now) && self.zombie_faller_location.drop_now) {
    return true;
  }
  return false;
}

function zombie_faller_drop_not_occupied() {
  if(isDefined(self.zombie_faller_location.drop_not_occupied) && self.zombie_faller_location.drop_not_occupied) {
    if(isDefined(self.zone_name) && isDefined(level.zones[self.zone_name])) {
      return !level.zones[self.zone_name].is_occupied;
    }
  }
  return 0;
}

function zombie_faller_watch_all_players() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    self thread zombie_faller_watch_player(players[i]);
  }
}

function zombie_faller_watch_player(player) {
  self endon("falling");
  self endon("death");
  player endon("disconnect");
  range = 200;
  rangesqr = range * range;
  timer = 5000;
  inrange = 0;
  inrangetime = 0;
  closerange = 60;
  closerangesqr = closerange * closerange;
  dirtoplayerenter = (0, 0, 0);
  incloserange = 0;
  while(true) {
    distsqr = distance2dsquared(self.origin, player.origin);
    if(distsqr < rangesqr) {
      if(inrange) {
        if((inrangetime + timer) < gettime()) {
          self.zombie_faller_should_drop = 1;
          break;
        }
      } else {
        inrange = 1;
        inrangetime = gettime();
      }
    } else {
      inrange = 0;
    }
    if(distsqr < closerangesqr) {
      if(!incloserange) {
        dirtoplayerenter = player.origin - self.origin;
        dirtoplayerenter = (dirtoplayerenter[0], dirtoplayerenter[1], 0);
        dirtoplayerenter = vectornormalize(dirtoplayerenter);
      }
      incloserange = 1;
    } else {
      if(incloserange) {
        dirtoplayerexit = player.origin - self.origin;
        dirtoplayerexit = (dirtoplayerexit[0], dirtoplayerexit[1], 0);
        dirtoplayerexit = vectornormalize(dirtoplayerexit);
        if(vectordot(dirtoplayerenter, dirtoplayerexit) < 0) {
          self.zombie_faller_should_drop = 1;
          break;
        }
      }
      incloserange = 0;
    }
    wait(0.1);
  }
}

function zombie_fall_wait() {
  self endon("falling");
  self endon("death");
  if(isDefined(self.zone_name)) {
    if(isDefined(level.zones) && isDefined(level.zones[self.zone_name])) {
      zone = level.zones[self.zone_name];
      while(true) {
        if(!zone.is_enabled || !zone.is_active) {
          if(!self potentially_visible(2250000)) {
            if(self.health != level.zombie_health) {
              self.zombie_faller_should_drop = 1;
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

function zombie_fall_should_attack(spot) {
  victims = zombie_fall_get_vicitims(spot);
  return victims.size > 0;
}

function zombie_fall_get_vicitims(spot) {
  ret = [];
  players = getplayers();
  checkdist2 = 40;
  checkdist2 = checkdist2 * checkdist2;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(player laststand::player_is_in_laststand()) {
      continue;
    }
    stance = player getstance();
    if(stance == "crouch" || stance == "prone") {
      continue;
    }
    zcheck = self.origin[2] - player.origin[2];
    if(zcheck < 0 || zcheck > 120) {
      continue;
    }
    dist2 = distance2dsquared(player.origin, self.origin);
    if(dist2 < checkdist2) {
      ret[ret.size] = player;
    }
  }
  return ret;
}

function get_fall_anim(spot) {
  return level._zombie_fall_anims[self.animname]["fall"];
}

function zombie_faller_enable_location() {
  if(isDefined(self.zombie_faller_location)) {
    self.zombie_faller_location.is_enabled = 1;
    self.zombie_faller_location = undefined;
  }
}

function zombie_faller_death_wait(endon_notify) {
  self endon("falling");
  if(isDefined(endon_notify)) {
    self endon(endon_notify);
  }
  self waittill("death");
  self zombie_faller_enable_location();
}

function zombie_fall_death_func(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self animmode("noclip");
  self.deathanim = "zm_faller_emerge_death";
  return self zm_spawner::zombie_death_animscript();
}

function zombie_fall_death(spot) {
  self endon("fall_anim_finished");
  while(self.health > 1) {
    self waittill("damage", amount, attacker, dir, p, type);
  }
  self stopanimscripted();
  spot notify("stop_zombie_fall_fx");
}

function _damage_mod_to_damage_type(type) {
  toks = strtok(type, "_");
  if(toks.size < 2) {
    return type;
  }
  returnstr = toks[1];
  for(i = 2; i < toks.size; i++) {
    returnstr = returnstr + toks[i];
  }
  returnstr = tolower(returnstr);
  return returnstr;
}

function zombie_fall_fx(spot) {
  spot thread zombie_fall_dust_fx(self);
  spot thread zombie_fall_burst_fx();
  playsoundatposition("zmb_zombie_spawn", spot.origin);
  self endon("death");
  spot endon("stop_zombie_fall_fx");
  wait(1);
  if(self.zombie_move_speed != "sprint") {
    wait(1);
  }
}

function zombie_fall_burst_fx() {
  self endon("stop_zombie_fall_fx");
  self endon("fall_anim_finished");
  playFX(level._effect["rise_burst"], self.origin + (0, 0, randomintrange(5, 10)));
  wait(0.25);
  playFX(level._effect["rise_billow"], self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
}

function zombie_fall_dust_fx(zombie) {
  dust_tag = "J_SpineUpper";
  self endon("stop_zombie_fall_dust_fx");
  self thread stop_zombie_fall_dust_fx(zombie);
  dust_time = 4.5;
  dust_interval = 0.3;
  t = 0;
  while(t < dust_time) {
    playFXOnTag(level._effect["rise_dust"], zombie, dust_tag);
    wait(dust_interval);
    t = t + dust_interval;
  }
}

function stop_zombie_fall_dust_fx(zombie) {
  zombie waittill("death");
  self notify("stop_zombie_fall_dust_fx");
}

function handle_fall_death_notetracks(entity) {
  self.in_the_ceiling = 0;
}

function handle_fall_notetracks(entity) {
  victims = zombie_fall_get_vicitims(entity.zombie_faller_location);
  for(i = 0; i < victims.size; i++) {
    victims[i] dodamage(entity.meleedamage, entity.origin, self, self, "none", "MOD_MELEE");
    entity.zombie_faller_should_drop = 1;
  }
}

function faller_death_ragdoll(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self startragdoll();
  self launchragdoll((0, 0, -1));
  return self zm_spawner::zombie_death_animscript();
}

function in_player_fov(player) {
  playerangles = player getplayerangles();
  playerforwardvec = anglesToForward(playerangles);
  playerunitforwardvec = vectornormalize(playerforwardvec);
  banzaipos = self.origin;
  playerpos = player getorigin();
  playertobanzaivec = banzaipos - playerpos;
  playertobanzaiunitvec = vectornormalize(playertobanzaivec);
  forwarddotbanzai = vectordot(playerunitforwardvec, playertobanzaiunitvec);
  anglefromcenter = acos(forwarddotbanzai);
  playerfov = getdvarfloat("cg_fov");
  banzaivsplayerfovbuffer = getdvarfloat("g_banzai_player_fov_buffer");
  if(banzaivsplayerfovbuffer <= 0) {
    banzaivsplayerfovbuffer = 0.2;
  }
  inplayerfov = anglefromcenter <= (playerfov * 0.5) * (1 - banzaivsplayerfovbuffer);
  return inplayerfov;
}

function potentially_visible(how_close = 1000000) {
  potentiallyvisible = 0;
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    dist = distancesquared(self.origin, players[i].origin);
    if(dist < how_close) {
      inplayerfov = self in_player_fov(players[i]);
      if(inplayerfov) {
        potentiallyvisible = 1;
        break;
      }
    }
  }
  return potentiallyvisible;
}

function do_zombie_emerge(spot) {
  self endon("death");
  self thread setup_deathfunc(&faller_death_ragdoll);
  self.no_powerups = 1;
  self.in_the_ceiling = 1;
  anim_org = spot.origin;
  anim_ang = spot.angles;
  self thread zombie_emerge_fx(spot);
  self thread zombie_faller_death_wait("risen");
  if(isDefined(level.custom_faller_entrance_logic)) {
    self thread[[level.custom_faller_entrance_logic]]();
  }
  self zombie_faller_emerge(spot);
  self.create_eyes = 1;
  wait(0.1);
  self notify("risen", spot.script_string);
  self zombie_faller_enable_location();
}

function zombie_faller_emerge(spot) {
  self endon("death");
  if(isDefined(self.zombie_faller_location.emerge_bottom) && self.zombie_faller_location.emerge_bottom) {
    self animscripted("fall_anim", self.zombie_faller_location.origin, self.zombie_faller_location.angles, "zombie_riser_elevator_from_floor");
  } else {
    self animscripted("fall_anim", self.zombie_faller_location.origin, self.zombie_faller_location.angles, "zombie_riser_elevator_from_ceiling");
  }
  self zombie_shared::donotetracks("rise_anim");
  self.deathfunction = &zm_spawner::zombie_death_animscript;
  self.in_the_ceiling = 0;
  self.no_powerups = 0;
}

function zombie_emerge_fx(spot) {
  spot thread zombie_emerge_dust_fx(self);
  playsoundatposition("zmb_zombie_spawn", spot.origin);
  self endon("death");
  spot endon("stop_zombie_fall_fx");
  wait(1);
}

function zombie_emerge_dust_fx(zombie) {
  dust_tag = "J_SpineUpper";
  self endon("stop_zombie_fall_dust_fx");
  self thread stop_zombie_fall_dust_fx(zombie);
  dust_time = 3.5;
  dust_interval = 0.5;
  t = 0;
  while(t < dust_time) {
    playFXOnTag(level._effect["rise_dust"], zombie, dust_tag);
    wait(dust_interval);
    t = t + dust_interval;
  }
}

function stop_zombie_emerge_dust_fx(zombie) {
  zombie waittill("death");
  self notify("stop_zombie_fall_dust_fx");
}