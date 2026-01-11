/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_firingrange.gsc
**************************************/

#include maps\mp\_utility;

main() {
  maps\mp\mp_firingrange_fx::main();
  precachemodel("collision_geo_10x10x512");
  maps\mp\_load::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_firingrange");
  maps\mp\mp_firingrange_amb::main();
  maps\mp\gametypes\_teamset_cubans::level_init();
  alleyTrigger = getent("alleyTrigger", "targetname");
  windowTrigger = getent("triggerwindowTarget", "targetname");
  target1 = getent("fieldTarget_BackLeft", "targetname");
  target2 = getent("fieldTarget_FrontLeft", "targetname");
  target3 = getent("fieldTarget_Middle", "targetname");
  target4 = getent("fieldTarget_BackRight", "targetname");
  target5 = getent("fieldTarget_FrontRight", "targetname");
  target6 = getent("trenchTarget_GroundWall", "targetname");
  target7 = getent("trailerTarget_Window", "targetname");
  target8 = getent("alleyTarget_Cover", "targetname");
  target9 = getent("alleyTarget_Path", "targetname");
  target10 = getent("centerTarget_Sandbags", "targetname");
  target11 = getent("towerTarget_Front", "targetname");
  target12 = getent("towerTarget_Back", "targetname");
  target13 = getent("centerTarget_Path", "targetname");
  target14 = getent("centerTarget_PathBunkerL", "targetname");
  target15 = getent("centerTarget_PathBunkerR", "targetname");
  target16 = getent("steelBuildingTarget_Slide1", "targetname");
  target17 = getent("steelBuildingTarget_PopUp", "targetname");
  target18 = getent("target_alleyWindow1", "targetname");
  target19 = getent("target_alleyWindow2", "targetname");
  target20 = getent("target_alleyWindow3", "targetname");
  targetLight1_off = getent("steelBuildingTargetLight1_off", "targetname");
  targetLight1_on = getent("steelBuildingTargetLight1_on", "targetname");
  targetLight2_off = getent("steelBuildingTargetLight2_off", "targetname");
  targetLight2_on = getent("steelBuildingTargetLight2_on", "targetname");
  level.const_fx_exploder_red_light_1 = 1001;
  level.const_fx_exploder_red_light_2 = 1002;
  speaker1 = getent("loudspeaker1", "targetname");
  speaker2 = getent("loudspeaker2", "targetname");
  targetLight1_on Hide();
  targetLight2_on Hide();
  target1 setCanDamage(true);
  target2 setCanDamage(true);
  target3 setCanDamage(true);
  target4 setCanDamage(true);
  target5 setCanDamage(true);
  target8 setCanDamage(true);
  target9 setCanDamage(true);
  target10 setCanDamage(true);
  target13 setCanDamage(true);
  target14 setCanDamage(true);
  target15 setCanDamage(true);
  target16 setCanDamage(true);
  target17 setCanDamage(true);
  target18 setCanDamage(true);
  target19 setCanDamage(true);
  target20 setCanDamage(true);
  target1 thread damageTarget(1);
  target2 thread damageTarget(1);
  target3 thread damageTarget(1);
  target4 thread damageTarget(1);
  target5 thread damageTarget(1);
  target8 thread damageTarget(2);
  target9 thread damageTarget(2);
  target10 thread damageTarget(2);
  target13 thread damageTarget(2);
  target14 thread damageTarget(3);
  target15 thread damageTarget(3);
  target16 thread damageTargetLights(targetLight1_on, targetLight1_off, speaker1, "amb_target_buzzer", level.const_fx_exploder_red_light_2);
  target17 thread damageTargetLights(targetLight2_on, targetLight2_off, speaker2, "amb_target_buzzer", level.const_fx_exploder_red_light_1);
  target18 thread damageTarget(4);
  target19 thread damageTarget(4);
  target20 thread damageTarget(5);
  target1 thread moveTarget(4, 220, 10.1);
  target2 thread moveTarget(4, 220, 5.2);
  target3 thread moveTarget(4, 220, 10.3);
  target4 thread moveTarget(3, 290, 8.4);
  target5 thread moveTarget(3, 285, 3);
  target6 thread moveTarget(1, 228, 8.1);
  target7 thread moveTarget(7, (57, 23, 0), 3);
  target8 thread moveTarget(1, 250, 5.5);
  target9 thread moveTarget(1, 146, 8.6);
  target10 thread moveTarget(1, 165, 8.7);
  target11 thread moveTarget(4, 136, 5.05);
  target12 thread moveTarget(3, 136, 7.15);
  target13 thread moveTarget(1, 228, 8.25);
  target16 thread moveTarget(4, 164, 5.35);
  target17 thread moveTarget(5, 48, 5.45);
  target18 thread moveTarget(3, 270, 8.55);
  target19 thread moveTarget(6, 70, 6.65);
  target20 thread moveTarget(1, 130, 5.75);
  target11 thread rotateTarget(2, 90, 0.5, 2);
  target12 thread rotateTarget(1, 90, 0.7, 3);
  alleyTrigger thread triggerCheck(target9);
  windowTrigger thread triggerCheck(target7);
  spawncollision("collision_geo_10x10x512", "collider", (-415, -429, -128), (0, 0, 0));
  spawncollision("collision_geo_10x10x512", "collider", (-415, -419, -128), (0, 0, 0));
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  SetDvar("scr_spawn_enemy_influencer_radius", 1600);
  SetDvar("scr_spawn_dead_friend_influencer_radius", 1300);
  SetDvar("scr_spawn_dead_friend_influencer_timeout_seconds", 13);
  SetDvar("scr_spawn_dead_friend_influencer_count", 7);
}
triggerCheck(target) {
  self endon("game_ended");
  while(1) {
    self waittill("trigger", player);
    distance = Distance(target.origin, self.origin);
    if(distance <= 90) {
      target notify("targetStopMoving");
      while(isDefined(player) && player isTouching(self) && distance <= 90) {
        if(DistanceSquared(target.origin, target.railPoints[0]) < DistanceSquared(player.origin, target.railPoints[0])) {
          target.preferredNextPos = 0;
        }
        else {
          target.preferredNextPos = 1;
        }
        wait(0.25);
      }
    }
  }
}
damageTarget(dir) {
  self endon("game_ended");
  while(1) {
    self waittill("damage", damage, attacker, direction);
    switch (dir) {
      case 1:
        self rotateroll(self.angles[1] + 90, .1);
        wait(.2);
        self rotateroll(self.angles[1] - 90, .1);
        wait(.2);
        self playSound("amb_target_flip");
        break;
      case 2: {
        rotation = 1;
        if(isDefined(attacker) && isPlayer(attacker)) {
          yaw = get2DYaw(attacker.origin, self.origin);
          if(attacker.angles[1] > yaw) {
            rotation = -1;
          }
        }
        self rotateyaw(self.angles[2] + (180 * rotation), .3);
        self playSound("amb_target_twirl");
        self waittill("rotatedone");
      }
      break;
      case 3:
        self rotatepitch(self.angles[1] + 90, .1);
        wait(.2);
        self rotatepitch(self.angles[1] - 90, .1);
        wait(.2);
        self playSound("amb_target_flip");
        break;
      case 4:
        self rotateroll(self.angles[1] - 90, .1);
        wait(.2);
        self rotateroll(self.angles[1] + 90, .1);
        wait(.2);
        self playSound("amb_target_flip");
        break;
      case 5:
        self rotatepitch(self.angles[1] - 90, .1);
        wait(.2);
        self rotatepitch(self.angles[1] + 90, .1);
        wait(.2);
        self playSound("amb_target_flip");
        break;
    }
  }
}
damageTargetLights(light_on, light_off, speaker, alias, exploderHandle) {
  self endon("game_ended");
  while(1) {
    self waittill("damage");
    speaker playSound(alias);
    exploder(exploderHandle);
    light_off Hide();
    light_on Show();
    wait(0.5);
    exploder_stop(exploderHandle);
    light_off Show();
    light_on Hide();
  }
}
moveTarget(dir, dis, speed) {
  self endon("game_ended");
  keepMoving = true;
  startPOS = self.origin;
  FarPOS = self.origin;
  sound = spawn("script_origin", self.origin);
  sound LinkTo(self);
  sound playLoopSound("amb_target_chain");
  switch (dir) {
    case 1:
      farPOS = self.origin + (0, dis, 0);
      break;
    case 2:
      farPOS = self.origin - (0, dis, 0);
      break;
    case 3:
      farPOS = self.origin + (dis, 0, 0);
      break;
    case 4:
      farPOS = self.origin - (dis, 0, 0);
      break;
    case 5:
      farPOS = self.origin + (0, 0, dis);
      break;
    case 6:
      farPOS = self.origin - (0, 0, dis);
      break;
    case 7:
      farPOS = self.origin - dis;
      break;
  }
  self.railPoints = [];
  self.railPoints[0] = startPos;
  self.railPoints[1] = FarPos;
  self.preferredNextPos = 1;
  self.playerTrigger = false;
  while(1) {
    nextPos = self.railPoints[self.preferredNextPos];
    if(self.preferredNextPos == 0) {
      self.preferredNextPos = 1;
    }
    else {
      self.preferredNextPos = 0;
    }
    self moveto(nextPos, speed);
    self waittill_either("movedone", "targetStopMoving");
    self playSound("amb_target_stop");
  }
}
rotateTarget(dir, deg, speed, pauseTime) {
  self endon("game_ended");
  while(1) {
    switch (dir) {
      case 1:
        self rotateyaw(self.angles[2] + deg, speed);
        self playSound("amb_target_rotate");
        wait(pauseTime);
        self rotateyaw(self.angles[2] - deg, speed);
        self playSound("amb_target_rotate");
        wait(pauseTime);
        break;
      case 2:
        self rotateyaw(self.angles[2] - deg, speed);
        self playSound("amb_target_rotate");
        wait(pauseTime);
        self rotateyaw(self.angles[2] + deg, speed);
        self playSound("amb_target_rotate");
        wait(pauseTime);
        break;
      case 3:
        self rotateroll(self.angles[0] + deg, speed);
        self playSound("amb_target_rotate");
        wait(pauseTime);
        self rotateroll(self.angles[0] - deg, speed);
        self playSound("amb_target_rotate");
        wait(pauseTime);
        break;
      case 4:
        self rotateroll(self.angles[0] - deg, speed);
        self playSound("amb_target_rotate");
        wait(pauseTime);
        self rotateroll(self.angles[0] + deg, speed);
        self playSound("amb_target_rotate");
        wait(pauseTime);
        break;
      case 5:
        self rotateroll(self.angles[1] + deg, speed);
        self playSound("amb_target_rotate");
        wait(pauseTime);
        self rotateroll(self.angles[1] - deg, speed);
        self playSound("amb_target_rotate");
        wait(pauseTime);
        break;
      case 6:
        self rotatepitch(self.angles[1] - deg, speed);
        wait(pauseTime);
        self rotatepitch(self.angles[1] + deg, speed);
        wait(pauseTime);
        break;
      case 7:
        self rotateto((self.angles[0] + 90, self.angles[1] - 90, self.angles[2] + 45), speed);
        wait(pauseTime);
        self rotateto((self.angles[0] - 90, self.angles[1] + 90, self.angles[2] - 45), speed);
        wait(pauseTime);
    }
  }
}