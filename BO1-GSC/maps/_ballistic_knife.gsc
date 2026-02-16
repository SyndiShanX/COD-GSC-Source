/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ballistic_knife.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

init() {
  if(isDefined(level._uses_retrievable_ballisitic_knives) && level._uses_retrievable_ballisitic_knives == true) {
    PrecacheModel("t5_weapon_ballistic_knife_blade");
    PrecacheModel("t5_weapon_ballistic_knife_blade_retrieve");
  }
}
on_spawn(watcher, player) {
  player endon("death");
  player endon("disconnect");
  player endon("zmb_lost_knife");
  level endon("game_ended");
  self waittill("stationary", endpos, normal, angles, attacker, prey, bone);
  isFriendly = false;
  if(isDefined(endpos)) {
    retrievable_model = spawn("script_model", endpos);
    retrievable_model setModel("t5_weapon_ballistic_knife_blade");
    retrievable_model SetOwner(player);
    retrievable_model.owner = player;
    retrievable_model.angles = angles;
    retrievable_model.name = watcher.weapon;
    if(isDefined(prey)) {
      if(isPlayer(prey) && player.team == prey.team) {
        isFriendly = true;
      } else if(isAI(prey) && player.team == prey.team) {
        isFriendly = true;
      }
      if(!isFriendly) {
        retrievable_model LinkTo(prey, bone);
        retrievable_model thread force_drop_knives_to_ground_on_death(player, prey);
      } else if(isFriendly) {
        retrievable_model physicslaunch(normal, (randomint(10), randomint(10), randomint(10)));
        normal = (0, 0, 1);
      }
    }
    watcher.objectArray[watcher.objectArray.size] = retrievable_model;
    if(isFriendly) {
      retrievable_model waittill("stationary");
    }
    retrievable_model thread drop_knives_to_ground(player);
    if(isFriendly) {
      player notify("ballistic_knife_stationary", retrievable_model, normal);
    } else {
      player notify("ballistic_knife_stationary", retrievable_model, normal, prey);
    }
    retrievable_model thread wait_to_show_glowing_model(prey);
  }
}
wait_to_show_glowing_model(prey) {
  level endon("game_ended");
  self endon("death");
  glowing_retrievable_model = spawn("script_model", self.origin);
  self.glowing_model = glowing_retrievable_model;
  glowing_retrievable_model.angles = self.angles;
  glowing_retrievable_model LinkTo(self);
  if(isDefined(prey)) {
    wait(2);
  }
  glowing_retrievable_model setModel("t5_weapon_ballistic_knife_blade_retrieve");
}
on_spawn_retrieve_trigger(watcher, player) {
  player endon("death");
  player endon("disconnect");
  player endon("zmb_lost_knife");
  level endon("game_ended");
  player waittill("ballistic_knife_stationary", retrievable_model, normal, prey);
  if(!isDefined(retrievable_model)) {
    return;
  }
  vec_scale = 10;
  trigger_pos = [];
  if(isDefined(prey)) {
    trigger_pos[0] = prey.origin[0];
    trigger_pos[1] = prey.origin[1];
    trigger_pos[2] = prey.origin[2] + vec_scale;
  } else {
    trigger_pos[0] = retrievable_model.origin[0] + (vec_scale * normal[0]);
    trigger_pos[1] = retrievable_model.origin[1] + (vec_scale * normal[1]);
    trigger_pos[2] = retrievable_model.origin[2] + (vec_scale * normal[2]);
  }
  pickup_trigger = spawn("trigger_radius_use", (trigger_pos[0], trigger_pos[1], trigger_pos[2]));
  pickup_trigger SetCursorHint("HINT_NOICON");
  pickup_trigger.owner = player;
  retrievable_model.retrievableTrigger = pickup_trigger;
  hint_string = &"WEAPON_BALLISTIC_KNIFE_PICKUP";
  if(isDefined(hint_string)) {
    pickup_trigger SetHintString(hint_string);
  } else {
    pickup_trigger SetHintString(&"GENERIC_PICKUP");
  }
  pickup_trigger SetTeamForTrigger(player.team);
  player ClientClaimTrigger(pickup_trigger);
  pickup_trigger EnableLinkTo();
  if(isDefined(prey)) {
    pickup_trigger LinkTo(prey);
  } else {
    pickup_trigger LinkTo(retrievable_model);
  }
  retrievable_model thread watch_use_trigger(pickup_trigger, retrievable_model, ::pick_up, watcher.weapon, watcher.pickUpSoundPlayer, watcher.pickUpSound);
  player thread watch_shutdown(pickup_trigger, retrievable_model);
}
debug_print(endpos) {
  self endon("death");
  while(true) {
    Print3d(endpos, "pickup_trigger");
    wait(0.05);
  }
}
watch_use_trigger(trigger, model, callback, weapon, playerSoundOnUse, npcSoundOnUse) {
  self endon("death");
  self endon("delete");
  level endon("game_ended");
  while(true) {
    trigger waittill("trigger", player);
    if(!IsAlive(player)) {
      continue;
    }
    if(!player IsOnGround()) {
      continue;
    }
    if(isDefined(trigger.triggerTeam) && (player.team != trigger.triggerTeam)) {
      continue;
    }
    if(isDefined(trigger.claimedBy) && (player != trigger.claimedBy)) {
      continue;
    }
    if(player useButtonPressed() && !player.throwingGrenade && !player meleeButtonPressed()) {
      if(isDefined(playerSoundOnUse)) {
        player playLocalSound(playerSoundOnUse);
      }
      if(isDefined(npcSoundOnUse)) {
        player playSound(npcSoundOnUse);
      }
      player thread[[callback]](weapon, model, trigger);
      break;
    }
  }
}
pick_up(weapon, model, trigger) {
  current_weapon = self GetCurrentWeapon();
  if(current_weapon != weapon) {
    clip_ammo = self GetWeaponAmmoClip(weapon);
    if(!clip_ammo) {
      self SetWeaponAmmoClip(weapon, 1);
    } else {
      new_ammo_stock = self GetWeaponAmmoStock(weapon) + 1;
      self SetWeaponAmmoStock(weapon, new_ammo_stock);
    }
  } else {
    new_ammo_stock = self GetWeaponAmmoStock(weapon) + 1;
    self SetWeaponAmmoStock(weapon, new_ammo_stock);
  }
  model destroy_ent();
  trigger destroy_ent();
}
destroy_ent() {
  if(isDefined(self)) {
    if(isDefined(self.glowing_model)) {
      self.glowing_model delete();
    }
    self delete();
  }
}
watch_shutdown(trigger, model) {
  self waittill_any("death", "disconnect", "zmb_lost_knife");
  trigger destroy_ent();
  model destroy_ent();
}
drop_knives_to_ground(player) {
  player endon("death");
  player endon("zmb_lost_knife");
  for(;;) {
    level waittill("drop_objects_to_ground", origin, radius);
    if(DistanceSquared(origin, self.origin) < radius * radius) {
      self physicslaunch((0, 0, 1), (5, 5, 5));
      self thread update_retrieve_trigger(player);
    }
  }
}
force_drop_knives_to_ground_on_death(player, prey) {
  self endon("death");
  player endon("zmb_lost_knife");
  prey waittill("death");
  self Unlink();
  self physicslaunch((0, 0, 1), (5, 5, 5));
  self thread update_retrieve_trigger(player);
}
update_retrieve_trigger(player) {
  self endon("death");
  player endon("zmb_lost_knife");
  self waittill("stationary");
  trigger = self.retrievableTrigger;
  trigger.origin = (self.origin[0], self.origin[1], self.origin[2] + 10);
  trigger LinkTo(self);
}