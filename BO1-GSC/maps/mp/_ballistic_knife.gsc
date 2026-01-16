/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_ballistic_knife.gsc
****************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  PrecacheModel("t5_weapon_ballistic_knife_blade");
  PrecacheModel("t5_weapon_ballistic_knife_blade_retrieve");
}
onSpawn(watcher, player) {
  player endon("death");
  player endon("disconnect");
  level endon("game_ended");
  self waittill("stationary", endpos, normal, angles, attacker, prey, bone);
  isFriendly = false;
  if(isDefined(endpos)) {
    retrievable_model = Spawn("script_model", endpos);
    retrievable_model SetModel("t5_weapon_ballistic_knife_blade");
    retrievable_model SetTeam(player.team);
    retrievable_model SetOwner(player);
    retrievable_model.owner = player;
    retrievable_model.angles = angles;
    retrievable_model.name = watcher.weapon;
    retrievable_model.targetname = "sticky_weapon";
    if(isDefined(prey)) {
      if(level.teamBased && isPlayer(prey) && player.team == prey.team)
        isFriendly = true;
      else if(level.teamBased && isAI(prey) && player.team == prey.aiTeam)
        isFriendly = true;
      if(!isFriendly) {
        if(IsAlive(prey)) {
          retrievable_model dropToGround(retrievable_model.origin, 80);
        } else {
          retrievable_model LinkTo(prey, bone);
        }
      } else if(isFriendly) {
        retrievable_model physicslaunch(normal, (randomint(10), randomint(10), randomint(10)));
        normal = (0, 0, 1);
      }
    }
    watcher.objectArray[watcher.objectArray.size] = retrievable_model;
    if(isFriendly)
      retrievable_model waittill("stationary");
    retrievable_model thread dropKnivesToGround();
    if(isFriendly)
      player notify("ballistic_knife_stationary", retrievable_model, normal);
    else
      player notify("ballistic_knife_stationary", retrievable_model, normal, prey);
    retrievable_model thread wait_to_show_glowing_model(prey);
  }
}
wait_to_show_glowing_model(prey) {
  level endon("game_ended");
  self endon("death");
  glowing_retrievable_model = Spawn("script_model", self.origin);
  self.glowing_model = glowing_retrievable_model;
  glowing_retrievable_model.angles = self.angles;
  glowing_retrievable_model LinkTo(self);
  if(isDefined(prey) && !IsAlive(prey)) {
    wait(2);
  }
  glowing_retrievable_model SetModel("t5_weapon_ballistic_knife_blade_retrieve");
}
watch_shutdown() {
  pickUpTrigger = self.pickUpTrigger;
  otherTeamPickUpTrigger = self.otherTeamPickUpTrigger;
  glowing_model = self.glowing_model;
  self waittill("death");
  if(isDefined(pickUpTrigger))
    pickUpTrigger delete();
  if(isDefined(otherTeamPickUpTrigger))
    otherTeamPickUpTrigger delete();
  if(isDefined(glowing_model)) {
    glowing_model delete();
  }
}
onSpawnRetrieveTrigger(watcher, player) {
  player endon("death");
  player endon("disconnect");
  level endon("game_ended");
  player waittill("ballistic_knife_stationary", retrievable_model, normal, prey);
  if(!isDefined(retrievable_model))
    return;
  vec_scale = 10;
  trigger_pos = [];
  if(isDefined(prey) && (isPlayer(prey) || isAI(prey))) {
    trigger_pos[0] = prey.origin[0];
    trigger_pos[1] = prey.origin[1];
    trigger_pos[2] = prey.origin[2] + vec_scale;
  } else {
    trigger_pos[0] = retrievable_model.origin[0] + (vec_scale * normal[0]);
    trigger_pos[1] = retrievable_model.origin[1] + (vec_scale * normal[1]);
    trigger_pos[2] = retrievable_model.origin[2] + (vec_scale * normal[2]);
  }
  pickup_trigger = Spawn("trigger_radius_use", (trigger_pos[0], trigger_pos[1], trigger_pos[2]));
  pickup_trigger SetCursorHint("HINT_NOICON", watcher.weapon);
  pickup_trigger.owner = player;
  retrievable_model.pickUpTrigger = pickup_trigger;
  hint_string = & "MP_BALLISTIC_KNIFE_PICKUP";
  if(isDefined(hint_string)) {
    pickup_trigger SetHintString(hint_string);
  } else {
    pickup_trigger SetHintString(&"MP_GENERIC_PICKUP");
  }
  if(!level.teamBased)
    pickup_trigger SetTeamForTrigger("none");
  else
    pickup_trigger SetTeamForTrigger(player.team);
  pickup_trigger EnableLinkTo();
  if(isDefined(prey))
    pickup_trigger LinkTo(prey);
  else
    pickup_trigger LinkTo(retrievable_model);
  retrievable_model thread watch_use_trigger(pickup_trigger, retrievable_model, ::pick_up, watcher.pickUpSoundPlayer, watcher.pickUpSound);
  other_team_pickup_trigger = Spawn("trigger_radius_use", (trigger_pos[0], trigger_pos[1], trigger_pos[2]));
  other_team_pickup_trigger SetCursorHint("HINT_NOICON");
  retrievable_model.otherTeamPickUpTrigger = other_team_pickup_trigger;
  if(isDefined(hint_string)) {
    other_team_pickup_trigger SetHintString(hint_string);
  } else {
    other_team_pickup_trigger SetHintString(&"MP_GENERIC_PICKUP");
  }
  if(level.teamBased) {
    other_team_pickup_trigger SetTeamForTrigger(GetOtherTeam(player.team));
  } else {
    other_team_pickup_trigger SetTeamForTrigger("none");
  }
  triggers = [];
  triggers["owner_pickup"] = pickup_trigger;
  triggers["enemy_pickup"] = other_team_pickup_trigger;
  triggers["glowing_model"] = retrievable_model.glowing_model;
  retrievable_model thread watch_trigger_visibility(triggers, "knife_ballistic_mp");
  retrievable_model thread watch_use_trigger(other_team_pickup_trigger, retrievable_model, ::pick_up, watcher.pickUpSoundPlayer, watcher.pickUpSound);
  retrievable_model thread watch_shutdown();
}
watch_trigger_visibility(triggers, weap_name) {
  self notify("watchTriggerVisibility");
  self endon("watchTriggerVisibility");
  self endon("death");
  max_ammo = WeaponMaxAmmo(weap_name) + 1;
  while (true) {
    players = level.players;
    for (i = 0; i < players.size; i++) {
      if(!IsAlive(players[i])) {
        wait(0.05);
        continue;
      }
      if(players[i] HasWeapon(weap_name)) {
        ammo_stock = players[i] GetWeaponAmmoStock(weap_name);
        ammo_clip = players[i] GetWeaponAmmoClip(weap_name);
        current_weapon = players[i] GetCurrentWeapon();
        total_ammo = ammo_stock + ammo_clip;
        hasReloaded = true;
        if(total_ammo > 0 && ammo_stock == total_ammo && current_weapon == "knife_ballistic_mp") {
          hasReloaded = false;
        }
        if(self.owner == players[i]) {
          if(total_ammo < max_ammo && hasReloaded) {
            triggers["owner_pickup"] SetVisibleToPlayer(players[i]);
            triggers["enemy_pickup"] SetInvisibleToPlayer(players[i]);
            triggers["glowing_model"] SetVisibleToPlayer(players[i]);
          } else {
            triggers["owner_pickup"] SetInvisibleToPlayer(players[i]);
            triggers["enemy_pickup"] SetInvisibleToPlayer(players[i]);
            triggers["glowing_model"] SetInvisibleToPlayer(players[i]);
          }
        } else {
          if(total_ammo < max_ammo && hasReloaded) {
            triggers["owner_pickup"] SetInvisibleToPlayer(players[i]);
            triggers["enemy_pickup"] SetVisibleToPlayer(players[i]);
            triggers["glowing_model"] SetVisibleToPlayer(players[i]);
          } else {
            triggers["owner_pickup"] SetInvisibleToPlayer(players[i]);
            triggers["enemy_pickup"] SetInvisibleToPlayer(players[i]);
            triggers["glowing_model"] SetInvisibleToPlayer(players[i]);
          }
        }
      } else {
        triggers["owner_pickup"] SetInvisibleToPlayer(players[i]);
        triggers["enemy_pickup"] SetInvisibleToPlayer(players[i]);
        triggers["glowing_model"] SetInvisibleToPlayer(players[i]);
      }
    }
    wait(0.05);
  }
}
debug_print(endpos) {
  self endon("death");
  while (true) {
    Print3d(endpos, "pickup_trigger");
    wait(0.05);
  }
}
watch_use_trigger(trigger, model, callback, playerSoundOnUse, npcSoundOnUse) {
  self endon("death");
  self endon("delete");
  level endon("game_ended");
  while (true) {
    trigger waittill("trigger", player);
    if(!IsAlive(player))
      continue;
    if(!player IsOnGround())
      continue;
    if(isDefined(trigger.triggerTeam) && (player.team != trigger.triggerTeam))
      continue;
    if(isDefined(trigger.claimedBy) && (player != trigger.claimedBy))
      continue;
    if(player UseButtonPressed() && !player.throwingGrenade && !player meleeButtonPressed()) {
      if(isDefined(playerSoundOnUse))
        player playLocalSound(playerSoundOnUse);
      if(isDefined(npcSoundOnUse))
        player playSound(npcSoundOnUse);
      self thread[[callback]](player);
      break;
    }
  }
}
pick_up(player) {
  self destroy_ent();
  current_weapon = player GetCurrentWeapon();
  if(current_weapon != "knife_ballistic_mp") {
    clip_ammo = player GetWeaponAmmoClip("knife_ballistic_mp");
    if(!clip_ammo) {
      player SetWeaponAmmoClip("knife_ballistic_mp", 1);
    } else {
      new_ammo_stock = player GetWeaponAmmoStock("knife_ballistic_mp") + 1;
      player SetWeaponAmmoStock("knife_ballistic_mp", new_ammo_stock);
    }
  } else {
    new_ammo_stock = player GetWeaponAmmoStock("knife_ballistic_mp") + 1;
    player SetWeaponAmmoStock("knife_ballistic_mp", new_ammo_stock);
  }
}
destroy_ent() {
  if(isDefined(self)) {
    pickUpTrigger = self.pickUpTrigger;
    otherTeamPickUpTrigger = self.otherTeamPickUpTrigger;
    if(isDefined(pickUpTrigger))
      pickUpTrigger delete();
    if(isDefined(otherTeamPickUpTrigger))
      otherTeamPickUpTrigger delete();
    if(isDefined(self.glowing_model)) {
      self.glowing_model delete();
    }
    self delete();
  }
}
dropKnivesToGround() {
  self endon("death");
  for (;;) {
    level waittill("drop_objects_to_ground", origin, radius);
    self dropToGround(origin, radius);
  }
}
dropToGround(origin, radius) {
  if(DistanceSquared(origin, self.origin) < radius * radius) {
    self physicslaunch((0, 0, 1), (5, 5, 5));
    self thread updateRetrieveTrigger();
  }
}
updateRetrieveTrigger() {
  self endon("death");
  self waittill("stationary");
  trigger = self.pickUpTrigger;
  trigger.origin = (self.origin[0], self.origin[1], self.origin[2] + 10);
  trigger LinkTo(self);
}