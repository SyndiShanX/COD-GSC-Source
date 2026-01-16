/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ballistic_knife.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

init() {
  precachemodel("t5_weapon_ballistic_knife_blade");
  precachemodel("t5_weapon_ballistic_knife_blade_retrieve");
}

on_spawn(watcher, player) {
  player endon("death");
  player endon("disconnect");
  player endon("zmb_lost_knife");
  level endon("game_ended");
  self waittill("stationary", endpos, normal, angles, attacker, prey, bone);
  isfriendly = 0;

  if(isDefined(endpos)) {
    retrievable_model = spawn("script_model", endpos);
    retrievable_model setmodel("t5_weapon_ballistic_knife_blade");
    retrievable_model setowner(player);
    retrievable_model.owner = player;
    retrievable_model.angles = angles;
    retrievable_model.name = watcher.weapon;

    if(isDefined(prey)) {
      if(isplayer(prey) && player.team == prey.team)
        isfriendly = 1;
      else if(isai(prey) && player.team == prey.team)
        isfriendly = 1;

      if(!isfriendly)
        retrievable_model linkto(prey, bone);
      else if(isfriendly) {
        retrievable_model physicslaunch(normal, (randomint(10), randomint(10), randomint(10)));
        normal = (0, 0, 1);
      }
    }

    watcher.objectarray[watcher.objectarray.size] = retrievable_model;

    if(isfriendly)
      retrievable_model waittill("stationary");

    retrievable_model thread drop_knives_to_ground(player);

    if(isfriendly)
      player notify("ballistic_knife_stationary", retrievable_model, normal);
    else
      player notify("ballistic_knife_stationary", retrievable_model, normal, prey);

    retrievable_model thread wait_to_show_glowing_model(prey);
  }
}

wait_to_show_glowing_model(prey) {
  level endon("game_ended");
  self endon("death");
  glowing_retrievable_model = spawn("script_model", self.origin);
  self.glowing_model = glowing_retrievable_model;
  glowing_retrievable_model.angles = self.angles;
  glowing_retrievable_model linkto(self);

  if(isDefined(prey))
    wait 2;

  glowing_retrievable_model setmodel("t5_weapon_ballistic_knife_blade_retrieve");
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
  trigger_pos = [];

  if(isDefined(prey) && (isplayer(prey) || isai(prey))) {
    trigger_pos[0] = prey.origin[0];
    trigger_pos[1] = prey.origin[1];
    trigger_pos[2] = prey.origin[2] + 10;
  } else {
    trigger_pos[0] = retrievable_model.origin[0] + 10 * normal[0];
    trigger_pos[1] = retrievable_model.origin[1] + 10 * normal[1];
    trigger_pos[2] = retrievable_model.origin[2] + 10 * normal[2];
  }

  pickup_trigger = spawn("trigger_radius", (trigger_pos[0], trigger_pos[1], trigger_pos[2]), 0, 50, 50);
  pickup_trigger.owner = player;
  retrievable_model.retrievabletrigger = pickup_trigger;
  pickup_trigger setteamfortrigger(player.team);
  player clientclaimtrigger(pickup_trigger);
  pickup_trigger enablelinkto();

  if(isDefined(prey))
    pickup_trigger linkto(prey);
  else
    pickup_trigger linkto(retrievable_model);

  retrievable_model thread watch_use_trigger(pickup_trigger, retrievable_model, ::pick_up, watcher.weapon, watcher.pickupsoundplayer, watcher.pickupsound);
  player thread watch_shutdown(pickup_trigger, retrievable_model);
}

debug_print(endpos) {
  self endon("death");

  while(true) {
    print3d(endpos, "pickup_trigger");
    wait 0.05;
  }

}

watch_use_trigger(trigger, model, callback, weapon, playersoundonuse, npcsoundonuse) {
  self endon("death");
  self endon("delete");
  level endon("game_ended");
  max_ammo = weaponmaxammo(weapon) + 1;

  while(true) {
    trigger waittill("trigger", player);

    if(!isalive(player)) {
      continue;
    }
    if(!player isonground()) {
      continue;
    }
    if(isDefined(trigger.triggerteam) && player.team != trigger.triggerteam) {
      continue;
    }
    if(isDefined(trigger.claimedby) && player != trigger.claimedby) {
      continue;
    }
    ammo_stock = player getweaponammostock(weapon);
    ammo_clip = player getweaponammoclip(weapon);
    current_weapon = player getcurrentweapon();
    total_ammo = ammo_stock + ammo_clip;
    hasreloaded = 1;

    if(total_ammo > 0 && ammo_stock == total_ammo && current_weapon == weapon)
      hasreloaded = 0;

    if(total_ammo >= max_ammo || !hasreloaded) {
      continue;
    }
    if(isDefined(playersoundonuse))
      player playlocalsound(playersoundonuse);

    if(isDefined(npcsoundonuse))
      player playsound(npcsoundonuse);

    player thread[[callback]](weapon, model, trigger);
    break;
  }
}

pick_up(weapon, model, trigger) {
  current_weapon = self getcurrentweapon();

  if(current_weapon != weapon) {
    clip_ammo = self getweaponammoclip(weapon);

    if(!clip_ammo)
      self setweaponammoclip(weapon, 1);
    else {
      new_ammo_stock = self getweaponammostock(weapon) + 1;
      self setweaponammostock(weapon, new_ammo_stock);
    }
  } else {
    new_ammo_stock = self getweaponammostock(weapon) + 1;
    self setweaponammostock(weapon, new_ammo_stock);
  }

  model destroy_ent();
  trigger destroy_ent();
}

destroy_ent() {
  if(isDefined(self)) {
    if(isDefined(self.glowing_model))
      self.glowing_model delete();

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

    if(distancesquared(origin, self.origin) < radius * radius) {
      self physicslaunch((0, 0, 1), vectorscale((1, 1, 1), 5.0));
      self thread update_retrieve_trigger(player);
    }
  }
}

force_drop_knives_to_ground_on_death(player, prey) {
  self endon("death");
  player endon("zmb_lost_knife");
  prey waittill("death");
  self unlink();
  self physicslaunch((0, 0, 1), (0, 0, 0));
  self thread update_retrieve_trigger(player);
}

update_retrieve_trigger(player) {
  self endon("death");
  player endon("zmb_lost_knife");
  self waittill("stationary");
  trigger = self.retrievabletrigger;
  trigger.origin = (self.origin[0], self.origin[1], self.origin[2] + 10);
  trigger linkto(self);
}