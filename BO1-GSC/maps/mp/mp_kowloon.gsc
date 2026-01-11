/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_kowloon.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#using_animtree("mp_critter");
main() {
  PrecacheModel("p_kow_airplane_747");
  PrecacheItem("zipline_mp");
  PrecacheString(&"MP_ZIPLINE");
  maps\mp\mp_kowloon_fx::main();
  precachemodel("collision_wall_128x128x10");
  precachemodel("collision_geo_128x128x128");
  precachemodel("p_jun_woodbarrel_asian_lid_wet");
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_kowloon_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_kowloon");
  }
  maps\mp\_load::main();
  maps\mp\mp_kowloon_amb::main();
  maps\mp\gametypes\_teamset_urbanspecops::level_init();
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  thread trigger_killer((920, -336, -592), 1725, 128);
  thread trigger_killer((1440, 1848, -592), 1725, 128);
  spawncollision("collision_geo_128x128x128", "collider", (-486, -1115, -181), (0, 0, 0));
  spawncollision("collision_geo_128x128x128", "collider", (-514, -1115, -128), (40, 0, 0));
  spawncollision("collision_geo_128x128x128", "collider", (-571, -998, -129), (0, 270, 0));
  spawncollision("collision_wall_128x128x10", "collider", (-514, -998, -17), (0, 270, 0));
  spawncollision("collision_wall_128x128x10", "collider", (1293, 1015, 14), (0, 0, 9.19996));
  level thread zipline_init();
  level thread handle_ambient_planes();
  animal_anims = [];
  animal_anims[animal_anims.size] = % a_monkey_freaked_01;
  animal_anims[animal_anims.size] = % a_monkey_freaked_02;
  animal_anims[animal_anims.size] = % a_monkey_freaked_03;
  animal_anims[animal_anims.size] = % a_chicken_freaked_01;
  animal_anims[animal_anims.size] = % a_chicken_freaked_02;
  animal_anims[animal_anims.size] = % a_chicken_freaked_03;
  level thread glass_exploder_init();
}
trigger_killer(position, width, height) {
  kill_trig = spawn("trigger_radius", position, 0, width, height);
  while(1) {
    kill_trig waittill("trigger", player);
    if(isplayer(player)) {
      player suicide();
    }
  }
}
zipline_init() {
  SetDvar("scr_zipline_accelerate", "1");
  SetDvar("scr_zipline_decelerate", ".3");
  SetDvar("scr_zipline_line_up", ".35");
  level waittill("prematch_over");
  zipline_trigs = getEntArray("zipline_trigger", "targetname");
  array_thread(zipline_trigs, ::zipline_trigger_func);
  array_thread(zipline_trigs, ::zipline_prox_think);
}
zipline_trigger_func() {
  self SetHintString(&"MP_ZIPLINE");
  start_point = GetStruct(self.target);
  end_point = GetStruct(start_point.target);
  zipline_speed = self.script_float;
  AssertEx(isDefined(zipline_speed), "Zip line use trigger does not have a script_float K/V pair defined");
  moving_ent = spawn("script_model", start_point.origin);
  moving_ent setModel("tag_origin");
  while(1) {
    self waittill("trigger", player);
    if(canZipline(player)) {
      player.enteringVehicle = true;
      player thread zipline_player_func(start_point, end_point.origin, moving_ent, zipline_speed);
      self trigger_off();
      waittill_any_ents(player, "death", player, "disconnect", moving_ent, "zip");
      if(isDefined(player)) {
        player.enteringVehicle = false;
      }
      moving_ent stoploopsound();
      self trigger_on();
    }
  }
}
canZipline(player) {
  if(!isDefined(player)) {
    return false;
  }
  if(!IsPlayer(player)) {
    return false;
  }
  if(!IsAlive(player)) {
    return false;
  }
  if((isDefined(player.isDefusing) && player.isDefusing)) {
    return false;
  }
  if((isDefined(player.isPlanting) && player.isPlanting)) {
    return false;
  }
  if(isDefined(player.proxBar) && !player.proxBar.hidden) {
    return false;
  }
  if(isDefined(player.revivingTeammate) && player.revivingTeammate == true) {
    return false;
  }
  if(!player IsOnGround()) {
    return false;
  }
  if(player IsInVehicle()) {
    return false;
  }
  if(player IsThrowingGrenade()) {
    return false;
  }
  if(player IsSwitchingWeapons()) {
    return false;
  }
  if(player IsMeleeing()) {
    return false;
  }
  if(isDefined(player.laststand) && player.laststand) {
    return false;
  }
  weapon = player GetCurrentWeapon();
  if(!isDefined(weapon)) {
    return false;
  }
  if(weapon == "none") {
    return false;
  }
  if(IsWeaponEquipment(weapon) && player IsFiring()) {
    return false;
  }
  if(IsWeaponSpecificUse(weapon)) {
    return false;
  }
  return true;
}
zipline_player_func(start_point, end_point_origin, moving_ent, zipline_speed) {
  self endon("death");
  self endon("disconnect");
  moving_ent.origin = self.origin + (0, 0, 80);
  moving_ent.angles = self.angles;
  current_weapon = self GetCurrentWeapon();
  zipline_accelerate = GetDvarFloat("scr_zipline_accelerate");
  zipline_decelerate = GetDvarFloat("scr_zipline_decelerate");
  zipline_line_up = GetDvarFloat("scr_zipline_line_up");
  end_zipline_offset = 16;
  self SetStance("stand");
  self GiveWeapon("zipline_mp");
  self SwitchToWeapon("zipline_mp");
  self FreezeControlsAllowLook(true);
  self DisableWeaponCycling();
  self waittill("weapon_raising");
  self PlayerLinkToDelta(moving_ent, "tag_origin", 1);
  moving_ent RotateTo(start_point.angles, zipline_line_up);
  moving_ent MoveTo(start_point.origin, zipline_line_up);
  moving_ent waittill("movedone");
  moving_ent playLoopSound("evt_zipline_slide");
  moving_ent MoveTo(end_point_origin, zipline_speed, zipline_accelerate, zipline_decelerate);
  dist = Distance2D(moving_ent.origin, end_point_origin);
  self SetDepthOfField(0, 10, 1000, 7000, 6, 1.8);
  moving_ent waittill("movedone");
  while(dist > end_zipline_offset) {
    wait(0.05);
    dist = Distance2D(moving_ent.origin, end_point_origin);
  }
  moving_ent stoploopsound(.5);
  self Unlink();
  self FreezeControlsAllowLook(false);
  self SetDepthOfField(0, 1, 8000, 10000, 6, 0);
  if(isDefined(current_weapon) && current_weapon != "none" && self HasWeapon(current_weapon)) {
    self SwitchToWeapon(current_weapon);
    self wait_endon(2, "weapon_raising");
  } else {
    primaries = self GetWeaponsListPrimaries();
    if(isDefined(primaries) && primaries.size > 0 && primaries[0] != "none") {
      self SwitchToWeapon(primaries[0]);
    }
    self wait_endon(2, "weapon_raising");
  }
  self EnableWeaponCycling();
  self TakeWeapon("zipline_mp");
  moving_ent notify("zip");
}
zipline_prox_think() {
  if(!isDefined(self.script_noteworthy)) {
    return;
  }
  s = strtok(self.script_noteworthy, " ");
  origin = (Int(s[0]), Int(s[1]), Int(s[2]));
  for(;;) {
    wait(RandomIntRange(5, 10));
    if(!isDefined(game["bots_spawned"])) {
      return;
    }
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i] is_bot() && cointoss()) {
        if(DistanceSquared(players[i].origin, origin) < 256 * 256) {
          players[i] SetScriptGoal(origin, 32);
          event = players[i] waittill_any_return("goal", "bad_path", "death", "disconnect");
          if(event == "goal") {
            players[i] PressUseButton(3);
            wait(3);
            players[i] ClearScriptGoal();
          }
          break;
        }
      }
    }
  }
}
handle_ambient_planes() {
  wait(8);
  index = 1;
  count = 0.0;
  foundPlanePoints = true;
  startPos = undefined;
  endPos = undefined;
  while(foundPlanePoints) {
    foundPlanePoints = false;
    startPosEnt = GetStruct("plane_flyby_start_" + index, "targetname");
    endPosEnt = GetStruct("plane_flyby_end_" + index, "targetname");
    if(isDefined(startPosEnt) && isDefined(endPosEnt)) {
      foundPlanePoints = true;
      count += 1.0;
      if(RandomFloat(1) <= (1.0 / count)) {
        startPos = startPosEnt.origin;
        endPos = endPosEnt.origin;
      }
    }
    index++;
  }
  if(isDefined(startPos) && isDefined(endPos)) {
    speed = 1340.0;
    delta = (endPos - startPos);
    dist = Length(delta);
    travelTime = dist / speed;
    plane = spawn("script_model", startPos);
    if(isDefined(plane)) {
      dir = VectorNormalize(delta);
      plane.angles = VectorToAngles(dir);
      plane setModel("p_kow_airplane_747");
      plane MoveTo(endPos, travelTime);
      plane thread maps\mp\mp_kowloon_amb::plane_position_updater(4500, "evt_jet_flyover");
      wait travelTime;
      plane Delete();
    }
  }
}
glass_exploder_init() {
  single_exploders = [];
  for(i = 0; i < level.createFXent.size; i++) {
    ent = level.createFXent[i];
    if(!isDefined(ent)) {
      continue;
    }
    if(ent.v["type"] != "exploder") {
      continue;
    }
    if(ent.v["exploder"] == 101) {
      single_exploders[single_exploders.size] = ent;
    }
  }
  level thread glass_exploder_think(single_exploders);
}
glass_exploder_think(exploders) {
  thresholdSq = 60 * 60;
  if(exploders.size <= 0) {
    return;
  }
  for(;;) {
    closest = 999 * 999;
    closest_exploder = undefined;
    level waittill("glass_smash", origin);
    for(i = 0; i < exploders.size; i++) {
      if(!isDefined(exploders[i])) {
        continue;
      }
      if(isDefined(exploders[i].glass_broken)) {
        continue;
      }
      distSq = DistanceSquared(exploders[i].v["origin"], origin);
      if(distSq > thresholdSq) {
        continue;
      }
      if(distSq < closest) {
        closest_exploder = exploders[i];
        closest = distSq;
      }
    }
    if(isDefined(closest_exploder)) {
      closest_exploder.glass_broken = true;
      exploder(closest_exploder.v["exploder"]);
    }
  }
}