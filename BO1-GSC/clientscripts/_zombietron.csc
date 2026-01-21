/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombietron.csc
*****************************************/

#include clientscripts\_music;
#include clientscripts\_utility;

main() {
  level.zombiemode = true;
  level.swimmingFeature = false;
  clientscripts\_load::main();
  clientscripts\_footsteps::SetAIFootstepPrepend("fly_step_zombie_");
  thread clientscripts\_audio::audio_init(0);
  level._zombieCBFunc = clientscripts\_zombietron::on_zombie_spawn;
  level._playerCBFunc = clientscripts\_zombietron::on_player_spawn;
  init_client_flags();
  init_client_flag_callbacks();
  OnPlayerConnect_Callback(::on_player_connect);
  level._customVehicleCBFunc = ::vehicle_spawned_callback;
  level.bomb_model = "zombie_bomb";
  level.head_model = "char_ger_ansel_head";
  level._ZOMBIE_GIB_PIECE_INDEX_ALL = 0;
  level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_ARM = 1;
  level._ZOMBIE_GIB_PIECE_INDEX_LEFT_ARM = 2;
  level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_LEG = 3;
  level._ZOMBIE_GIB_PIECE_INDEX_LEFT_LEG = 4;
  level._ZOMBIE_GIB_PIECE_INDEX_HEAD = 5;
  level._ZOMBIE_GIB_PIECE_INDEX_GUTS = 6;
  level._gib_overload_func = ::gib_handler;
  level._gibEventCBFunc = ::on_gib_event;
}

vehicle_spawned_callback(localClientNum) {
  if(self.vehicletype == "tank_t55_mini") {
    self thread collisionHandler(localClientNum);
    self thread jump_landing_thread(localClientNum);
  }
}

collisionHandler(localClientNum) {
  self endon("entityshutdown");
  while(1) {
    self waittill("veh_collision", hip, hitn, hit_intensity);
    driver_local_client = self GetLocalClientDriver();
    if(isDefined(driver_local_client)) {
      player = getlocalplayer(driver_local_client);
      if(isDefined(player)) {
        if(hit_intensity > 15) {
          player playRumbleOnEntity(driver_local_client, "damage_heavy");
        } else {
          player playRumbleOnEntity(driver_local_client, "damage_light");
        }
      }
    }
  }
}

jump_landing_thread(localClientNum) {
  self endon("entityshutdown");
  while(1) {
    self waittill("veh_landed");
    driver_local_client = self GetLocalClientDriver();
    if(isDefined(driver_local_client)) {
      player = getlocalplayer(driver_local_client);
      if(isDefined(player)) {
        player playRumbleOnEntity(driver_local_client, "damage_heavy");
      }
    }
  }
}

lightning_flash(intensity_low, intensity_high, lightningdir) {
  lightningintensity = RandomFloatRange(intensity_low, intensity_high);
  lightningexposure = 2;
  SetSavedDvar("r_lightTweakSunLight", lightningintensity);
  SetSavedDvar("r_lightTweakSunDirection", lightningdir);
  SetDvar("r_exposureValue", lightningexposure);
}

lighting_flash_cycle(intensity_low, intensity_high, min_flash_time, max_flash_time, flash_wait_time_min, flash_wait_time_max) {
  flash_time = RandomFloatRange(min_flash_time, max_flash_time);
  oldlight = GetDvarFloat("r_lightTweakSunLight");
  oldsundir = GetDvarVector("r_lightTweakSunDirection");
  oldexposure = GetDvarFloat("r_exposureValue");
  lightningdir = (RandomFloatRange(-60, -20), RandomFloatRange(0, 360), 0);
  while(flash_time > 0.0) {
    lightning_flash(intensity_low, intensity_high, lightningdir);
    playSound(0, "amb_thunder_clap", (0, 0, 0));
    flash_wait_time = RandomFloatRange(flash_wait_time_min, flash_wait_time_max);
    wait(flash_wait_time);
    SetSavedDvar("r_lightTweakSunLight", oldlight);
    SetSavedDvar("r_lightTweakSunDirection", oldsundir);
    SetDvar("r_exposureValue", oldexposure);
    flash_time = flash_time - flash_wait_time;
  }
}

lightning(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    intensity_low = 10;
    intensity_high = 30;
    min_flash_time = 0.3;
    max_flash_time = 0.7;
    flash_wait_time_min = 0.05;
    flash_wait_time_max = 0.1;
    level thread lighting_flash_cycle(intensity_low, intensity_high, min_flash_time, max_flash_time, flash_wait_time_min, flash_wait_time_max);
  }
}

show_scores(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(isPC()) {
    return;
  }
  if(set) {
    ShowScores(localClientNum);
  } else {
    HideScores(localClientNum);
  }
}

zombie_helicopter_kill(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    temp = (0, 0, 270);
    if(isDefined(level._heli_pilot_ent)) {
      temp = self.origin - level._heli_pilot_ent.origin;
    }
    temp = VectorNormalize(temp);
    launch_dir = VectorCross(temp, (0, 0, 1));
    launch_dir = VectorNormalize(launch_dir);
    launch_dir *= 100;
    self LaunchRagdoll(launch_dir);
    playSound(0, "zmb_ragdoll_launched", self.origin);
    origin = self GetTagOrigin("j_head");
    angles = self GetTagAngles("j_head");
    forcex = RandomFloatRange(-200, 200);
    forcey = RandomFloatRange(-200, 200);
    forcez = RandomFloatRange(1300, 3100);
    camera_angles = GetDvarVector("player_TopDownCamAngles");
    launchDir = anglesToForward(camera_angles);
    launchDir = launchDir * forcez * -1;
    launchDir += (forcex, forcey, 0);
    contactPoint = origin + (RandomFloatRange(-1, 1), RandomFloatRange(-1, 1), RandomFloatRange(-1, 1)) * 5;
    CreateDynEntAndLaunch(0, level.head_model, origin, angles, contactPoint, launchDir, level._effect["animscript_gibtrail_fx"]);
  }
}

heli_pilot(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    level._heli_pilot_ent = self;
  } else {
    level._heli_pilot_ent = undefined;
  }
}

init_client_flag_callbacks() {
  register_clientflag_callback("actor", level._ZT_ACTOR_CF_GIB_DEATH_P1, ::gib_death_1);
  register_clientflag_callback("actor", level._ZT_ACTOR_CF_GIB_DEATH_P2, ::gib_death_2);
  register_clientflag_callback("actor", level._ZT_ACTOR_CF_GIB_DEATH_P3, ::gib_death_3);
  register_clientflag_callback("actor", level._ZT_ACTOR_CF_GIB_DEATH_P4, ::gib_death_4);
  register_clientflag_callback("actor", level._ZT_ACTOR_CF_BLOOD, ::zombie_blood);
  register_clientflag_callback("actor", level._ZT_ACTOR_CF_LAUNCH_AND_BURN, ::zombie_launch_and_burn);
  register_clientflag_callback("actor", level._ZT_ACTOR_CF_KILLED_BY_HELI, ::zombie_helicopter_kill);
  register_clientflag_callback("scriptmover", level._ZT_SCRIPTMOVER_CF_SACRED_COW, ::sacred_cow);
  register_clientflag_callback("scriptmover", level._ZT_SCRIPTMOVER_CF_POWERUP, ::powerup);
  register_clientflag_callback("scriptmover", level._ZT_SCRIPTMOVER_CF_ELEC_TRAP, ::electrap_handler);
  register_clientflag_callback("player", level._ZT_PLAYER_CF_UPDATEPROFILE, ::update_player_profile);
  register_clientflag_callback("player", level._ZT_PLAYER_CF_HELI_PILOT, ::heli_pilot);
  register_clientflag_callback("player", level._ZT_PLAYER_CF_START_SMART_BOMB, ::smartbomb_handler);
  register_clientflag_callback("player", level._ZT_PLAYER_CF_LIGHTNING, ::lightning);
  register_clientflag_callback("player", level._ZT_PLAYER_CF_SHOW_SCORES, ::show_scores);
}

update_player_profile(localClientNum, set, newEnt) {
  PrintLn("*** Update player profile. ***");
  UpdateGamerProfile(localClientNum);
}

randomize_array(array) {
  for(i = 0; i < array.size; i++) {
    j = randomInt(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
  return array;
}

flame_death_fx() {
  self endon("entityshutdown");
  if(isDefined(self.is_on_fire) && self.is_on_fire) {
    return;
  }
  self.is_on_fire = true;
  if(isDefined(level._effect) && isDefined(level._effect["character_fire_death_torso"])) {
    playFXOnTag(0, level._effect["character_fire_death_torso"], self, "J_SpineLower");
  }
  if(isDefined(level._effect) && isDefined(level._effect["character_fire_death_sm"])) {
    wait 1;
    tagArray = [];
    tagArray[0] = "J_Elbow_LE";
    tagArray[1] = "J_Elbow_RI";
    tagArray[2] = "J_Knee_RI";
    tagArray[3] = "J_Knee_LE";
    tagArray = randomize_array(tagArray);
    playFXOnTag(0, level._effect["character_fire_death_sm"], self, tagArray[0]);
    wait 1;
    tagArray[0] = "J_Wrist_RI";
    tagArray[1] = "J_Wrist_LE";
    tagArray[2] = "J_Ankle_RI";
    tagArray[3] = "J_Ankle_LE";
    tagArray = randomize_array(tagArray);
    playFXOnTag(0, level._effect["character_fire_death_sm"], self, tagArray[0]);
    playFXOnTag(0, level._effect["character_fire_death_sm"], self, tagArray[1]);
  }
}

zombie_launch_and_burn(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(!set) {
    return;
  }
  if(!isDefined(level._nukepoint)) {
    return;
  }
  dist_squared = DistanceSquared(self.origin, level._nukepoint);
  if(dist_squared < 130 * 130) {
    self LaunchRagdoll((0, 0, 270));
  } else if(dist_squared < 360 * 360) {
    dir = VectorNormalize(self.origin - level._nukepoint);
    dir = dir * 100;
    dir = dir + (0, 0, 120);
    self LaunchRagdoll(dir);
  }
  self thread flame_death_fx();
}

smartbomb_handler(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(!set) {
    return;
  }
  if(isDefined(self.tank)) {
    level._nukepoint = self.tank.origin;
  } else {
    level._nukepoint = self.origin;
  }
  origin = self.origin + (20, 0, 800);
  bomb = spawn(0, origin, "script_model");
  bomb setModel(level.bomb_model);
  bomb.angles = (90, 0, 0);
  bomb moveTo(self.origin, 0.3, 0, 0);
  playSound(0, "zmb_nuke_incoming", self.origin);
  bomb waittill("movedone");
  playSound(0, "zmb_nuke_impact", self.origin);
  playFX(0, level._effect["bomb"], self.origin);
  bomb Delete();
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] EarthQuake(1.0, 0.8, self.origin, 1000);
  }
}

trap_tear_down_monitor(parent) {
  self endon("done");
  parent waittill("entityshutdown");
  self notify("torn_down");
  self Delete();
}

fx_tear_down_monitor() {
  self waittill("entityshutdown");
  if(isDefined(self.fx)) {
    self.fx Delete();
    self.fx = undefined;
  }
  if(isDefined(self.fx2)) {
    self.fx2 Delete();
    self.fx2 = undefined;
  }
}

electrap_loop_sound(parent) {
  self endon("torn_down");
  self playLoopSound("zmb_hazard_loop", .5);
  self waittill("deactivate");
  self notify("done");
  self stopLoopSound(0.5);
  if(isDefined(self.fx)) {
    self.fx Delete();
    self.fx = undefined;
  }
  if(isDefined(self.fx2)) {
    self.fx2 Delete();
    self.fx2 = undefined;
  }
  self Delete();
}

get_camera_launch_direction() {
  pos = GetDvarVector("player_topDownCamCenterPos") + GetDvarVector("player_topDownCamOffset");
  return VectorNormalize(pos - self.origin);
}

gib_handler(type, locations) {
  if(type == "up") {
    up = get_camera_launch_direction();
    self._gib_vel = up * RandomIntRange(1400, 3500);
  }
  return false;
}

electrap_handler(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  self endon("entityshutdown");
  if(!isDefined(self.first_tickle)) {
    self.first_tickle = 1;
    self thread fx_tear_down_monitor();
    return;
  }
  if(set) {
    if(isDefined(self.fx2)) {
      self.fx2 Delete();
      self.fx2 = SpawnFx(0, level._effect["trap_red"], self.origin, 0, (1, 0, 0), (0, 0, 1));
      if(isDefined(self.fx2)) {
        triggerFx(self.fx2);
      }
    }
    wait 1;
    self.fx = SpawnFx(0, level._effect["electric_trap"], self.origin + (0, 0, 100), 0);
    if(isDefined(self.fx)) {
      triggerFx(self.fx);
      self.soundent = spawn(0, self.origin, "script_origin");
      self.soundent thread electrap_loop_sound(self);
    }
  } else {
    if(isDefined(self.fx)) {
      self.fx Delete();
      self.soundent notify("deactivate");
    }
    if(isDefined(self.fx2)) {
      self.fx2 Delete();
    }
    self.fx2 = SpawnFx(0, level._effect["trap_green"], self.origin, 0, (1, 0, 0), (0, 0, 1));
    if(isDefined(self.fx2)) {
      triggerFx(self.fx2);
    }
  }
}

get_pickup_type_from_model(model) {
  ret = "NA";
  switch (model) {
    case "zombietron_gold_brick":
    case "zombietron_gold_bricks":
    case "zombietron_gold_coin":
    case "zombietron_silver_brick":
    case "zombietron_silver_bricks":
    case "zombietron_silver_coin":
    case "zombie_z_money_icon":
    case "zombietron_ruby":
    case "zombietron_sapphire":
    case "zombietron_diamond":
      ret = "money";
      break;
    case "c_usa_blackops_body1_fb":
      ret = "extra_life";
      break;
    case "t5_veh_tank_t55_mini_static":
      ret = "tank";
      break;
    case "t5_veh_helo_hind_mini":
      ret = "heli";
      break;
    case "p_glo_barrel_metal_blue":
      ret = "spinning_blockers";
      break;
    case "zombietron_electric_ball":
      ret = "tesla_blockers";
      break;
    case "zombie_teddybear":
      ret = "stun_blockers";
      break;
    case "anim_chicken":
      ret = "double_shot";
      break;
    case "zombie_bomb":
      ret = "bomb";
      break;
    case "zombietron_lightning_bolt":
      ret = "booster";
      break;
    case "p_rus_boots":
      ret = "speed";
      break;
    case "m2_flamethrower_zt":
    case "ray_gun_zt":
    case "weapon_usa_ray_gun":
    case "weapon_usa_flamethrower":
    case "m60_zt":
    case "minigun_zt":
    case "t5_weapon_carry_minigun_world":
    case "spas_zt":
    case "t5_weapon_spas_world":
    case "china_lake_zt":
    case "t5_weapon_ex41_world":
    case "rpg_zt":
    case "weapon_rpg7":
      ret = "weapon";
      break;
    case "zombie_auto_turret":
      ret = "mini_turret";
      break;
    case "weapon_zombie_monkey_bomb":
    case "weapon_zombie_monkey_bomb_zt":
      ret = "monkey";
      break;
  }
  return (ret);
}

pickup_tear_down_monitor(parent) {
  self endon("done");
  parent waittill("entityshutdown");
  self notify("torn_down");
  self stopLoopSound(0.5);
  self Delete();
}

pickup_loop_sound(parent, sound) {
  self endon("torn_down");
  self thread pickup_tear_down_monitor(parent);
  self playLoopSound(sound, .5);
  self waittill("picked_up");
  self notify("done");
  self stopLoopSound(0.5);
  self Delete();
}

powerup(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    play_sound = true;
    loop_sound = "";
    switch (get_pickup_type_from_model(self.model)) {
      case "extra_life":
      case "extra_life_directed":
        loop_sound = "zmb_pickup_life_shimmer";
        playFXOnTag(localClientNum, level._effect["powerup_on"], self, "tag_origin");
        break;
      case "money":
        loop_sound = "zmb_pickup_money_shimmer";
        model = self.model;
        if(model == "zombietron_ruby") {
          playFXOnTag(localClientNum, level._effect["red_gem"], self, "tag_origin");
        } else if(model == "zombietron_sapphire") {
          playFXOnTag(localClientNum, level._effect["blue_gem"], self, "tag_origin");
        } else if(model == "zombietron_diamond") {
          playFXOnTag(localClientNum, level._effect["white_gem"], self, "tag_origin");
        } else if(issubstr(self.model, "silver")) {
          playFXOnTag(localClientNum, level._effect["powerup_on_silver"], self, "tag_origin");
        } else {
          playFXOnTag(localClientNum, level._effect["powerup_on"], self, "tag_origin");
        }
        break;
      case "speed":
      case "spinning_blockers":
      case "tesla_blockers":
      case "stun_blockers":
      case "bomb":
      case "booster":
      case "mini_turret":
      case "monkey":
        loop_sound = "zmb_pickup_powerup_shimmer";
        break;
      case "double_shot":
        playSound(localClientNum, "zmb_dblshot_spawn", self.origin);
        loop_sound = "zmb_pickup_powerup_shimmer";
        break;
      case "weapon":
        loop_sound = "zmb_pickup_weapon_shimmer";
        break;
      case "tank":
      case "heli":
        loop_sound = "zmb_pickup_vehicle_shimmer";
        break;
      default:
        PrintLn("Spawned " + self.model);
        play_sound = false;
        break;
    }
    if(play_sound) {
      playSound(localClientNum, "zmb_pickup_spawn", self.origin);
    }
    if(loop_sound != "") {
      self.loopsound = spawn(0, self.origin, "script_origin");
      self.loopsound thread pickup_loop_sound(self, loop_sound);
    }
  } else {
    if(isDefined(self.loopsound)) {
      self.loopsound notify("picked_up");
    }
    playFX(0, level._effect["powerup_grabbed"], self.origin, anglesToForward(self.angles));
    switch (get_pickup_type_from_model(self.model)) {
      case "extra_life":
      case "extra_life_directed":
        playSound(localClientNum, "zmb_pickup_life", self.origin);
        break;
      case "money":
        playSound(localClientNum, "zmb_pickup_money", self.origin);
        break;
      case "tank":
      case "heli":
        playSound(localClientNum, "zmb_pickup_vehicle", self.origin);
        break;
      case "spinning_blockers":
      case "tesla_blockers":
      case "stun_blockers":
      case "double_shot":
      case "bomb":
      case "booster":
      case "speed":
        playSound(localClientNum, "zmb_pickup_powerup", self.origin);
        break;
      case "weapon":
      case "mini_turret":
      case "monkey":
        playSound(localClientNum, "zmb_pickup_weapon", self.origin);
        break;
      default:
        PrintLn("Grabbed " + self.model);
        break;
    }
  }
}

sacred_cow(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  self playLoopSound("zmb_pickup_money_shimmer");
  playFXOnTag(localClientNum, level._effect["powerup_on"], self, "J_Ankle_LE");
  playFXOnTag(localClientNum, level._effect["powerup_on"], self, "J_Ankle_RI");
  playFXOnTag(localClientNum, level._effect["powerup_on"], self, "J_Wrist_LE");
  playFXOnTag(localClientNum, level._effect["powerup_on"], self, "J_Wrist_RI");
  playFXOnTag(localClientNum, level._effect["torch_light"], self, "J_Tail2");
}

zombie_blood(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    if(is_mature()) {
      playFX(localClientNum, level._effect["big_blood"], self.origin, anglesToForward(self.angles) * -1);
    }
  }
}

gib_death(localClientNum, set, newEnt, player) {
  if(set) {
    if(is_mature()) {
      playFX(localClientNum, level._effect["gib_death"], self.origin, anglesToForward(self.angles));
    }
  }
}

gib_death_1(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  gib_death(localClientNum, set, newEnt, 1);
}

gib_death_2(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  gib_death(localClientNum, set, newEnt, 2);
}

gib_death_3(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  gib_death(localClientNum, set, newEnt, 3);
}

gib_death_4(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  gib_death(localClientNum, set, newEnt, 4);
}

init_client_flags() {
  level._ZT_ACTOR_CF_GIB_DEATH_P1 = 2;
  level._ZT_ACTOR_CF_GIB_DEATH_P2 = 3;
  level._ZT_ACTOR_CF_GIB_DEATH_P3 = 4;
  level._ZT_ACTOR_CF_GIB_DEATH_P4 = 5;
  level._ZT_ACTOR_CF_BLOOD = 6;
  level._ZT_ACTOR_CF_LAUNCH_AND_BURN = 7;
  level._ZT_ACTOR_CF_KILLED_BY_HELI = 8;
  level._ZT_SCRIPTMOVER_CF_SACRED_COW = 0;
  level._ZT_SCRIPTMOVER_CF_POWERUP = 1;
  level._ZT_SCRIPTMOVER_CF_ELEC_TRAP = 2;
  level._ZT_PLAYER_CF_UPDATEPROFILE = 10;
  level._ZT_PLAYER_CF_HELI_PILOT = 11;
  level._ZT_PLAYER_CF_LIGHTNING = 12;
  level._ZT_PLAYER_CF_SHOW_SCORES = 13;
  level._ZT_PLAYER_CF_START_SMART_BOMB = 14;
}

createZombieEyes(localClientNum) {
  if(isDefined(self._eyeArray)) {
    if(!isDefined(self._eyeArray[localClientNum])) {
      linkTag = "J_Eyeball_LE";
      self._eyeArray[localClientNum] = playFXOnTag(localClientNum, level._effect["eye_glow"], self, linkTag);
    }
  }
}

deleteZombieEyes(localClientNum) {
  if(isDefined(self._eyeArray)) {
    if(isDefined(self._eyeArray[localClientNum])) {
      DeleteFx(localClientNum, self._eyeArray[localClientNum], true);
      self._eyeArray[localClientNum] = undefined;
    }
  }
}

on_player_connect(localClientNum) {
  ForceGameModeMappings(localClientNum, "zombietron");
}

on_player_spawn(localClientNum) {
  ForceGameModeMappings(localClientNum, "zombietron");
  self mapshaderconstant(localClientNum, 0, "scriptVector0", 1.0, -1.0, 0.0, 0.0);
}

on_zombie_spawn(localClientNum) {
  if(!isDefined(self._eyeArray)) {
    self._eyeArray = [];
  }
  wait(0.05);
  if(isDefined(self) && self haseyes()) {
    self createZombieEyes(localClientNum);
  }
  if(isDefined(self))
    self mapshaderconstant(localClientNum, 0, "scriptVector0", -4.0, -1.0, 0.0, -1.0);
}

zombie_eye_callback(localClientNum, hasEyes) {
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    if(hasEyes) {
      self createZombieEyes(i);
    } else {
      self deleteZombieEyes(i);
    }
  }
}

mark_piece_gibbed(piece_index) {
  if(!isDefined(self.gibbed_pieces)) {
    self.gibbed_pieces = [];
  }
  self.gibbed_pieces[self.gibbed_pieces.size] = piece_index;
}

has_gibbed_piece(piece_index) {
  if(!isDefined(self.gibbed_pieces)) {
    return false;
  }
  for(i = 0; i < self.gibbed_pieces.size; i++) {
    if(self.gibbed_pieces[i] == piece_index) {
      return true;
    }
  }
  return false;
}

do_gib_fx(tag) {
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    playFXOnTag(i, level._effect["animscript_gib_fx"], self, tag);
  }
  playSound(0, "zmb_death_gibs", self gettagorigin(tag));
}

do_gib(model, tag) {
  start_pos = self gettagorigin(tag);
  wait(0.03);
  end_pos = self gettagorigin(tag);
  if(isDefined(self._gib_vel)) {
    forward = self._gib_vel;
    self._gib_vel = undefined;
  } else {
    forward = VectorNormalize(end_pos - start_pos);
    forward *= RandomIntRange(600, 1000);
    forward += (0, 0, RandomIntRange(400, 700));
  }
  CreateDynEntAndLaunch(0, model, end_pos, self gettagangles(tag), start_pos, forward, level._effect["animscript_gibtrail_fx"], 1);
  self do_gib_fx(tag);
}

on_gib_event(localClientNum, type, locations) {
  if(localClientNum != 0) {
    return;
  }
  if(!is_mature()) {
    return;
  }
  if(self._gib_def == -1) {
    return;
  }
  if(isDefined(level._gib_overload_func)) {
    PrintLn("type " + type);
    PrintLn("loc size " + locations.size);
    if(self[[level._gib_overload_func]](type, locations)) {
      return;
    }
  }
  for(i = 0; i < locations.size; i++) {
    if(isDefined(self.gibbed) && level._ZOMBIE_GIB_PIECE_INDEX_HEAD != locations[i]) {
      continue;
    }
    switch (locations[i]) {
      case 0:
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn1) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag1)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn1, level._gibbing_actor_models[self._gib_def].gibSpawnTag1);
        }
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn2) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag2)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn2, level._gibbing_actor_models[self._gib_def].gibSpawnTag2);
        }
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn3) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag3)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn3, level._gibbing_actor_models[self._gib_def].gibSpawnTag3);
        }
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn4) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag4)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn4, level._gibbing_actor_models[self._gib_def].gibSpawnTag4);
        }
        self thread do_gib_fx("J_SpineLower");
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_ARM);
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_LEFT_ARM);
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_LEG);
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_LEFT_LEG);
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_HEAD);
        break;
      case 1:
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn1) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag1)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn1, level._gibbing_actor_models[self._gib_def].gibSpawnTag1);
        }
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_ARM);
        break;
      case 2:
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn2) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag2)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn2, level._gibbing_actor_models[self._gib_def].gibSpawnTag2);
        }
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_LEFT_ARM);
        break;
      case 3:
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn3) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag3)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn3, level._gibbing_actor_models[self._gib_def].gibSpawnTag3);
        }
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_LEG);
        break;
      case 4:
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn4) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag4)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn4, level._gibbing_actor_models[self._gib_def].gibSpawnTag4);
        }
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_LEFT_LEG);
        break;
      case 5:
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_HEAD);
        break;
      case 6:
        self thread do_gib_fx("J_SpineLower");
        break;
    }
  }
  self.gibbed = true;
}