/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\pickup_health.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\abilities\gadgets\gadget_health_regen;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\system_shared;

#namespace pickup_health;

autoexec __init__system__() {
  system::register(#"pickup_health", &__init__, undefined, #"weapons");
}

private __init__() {
  callback::on_connect(&onconnect);
  callback::on_spawned(&onspawned);
  ability_player::register_gadget_activation_callbacks(23, &onhealthregen, &offhealthregen);
  level.healingdisabled = &offhealthregen;
  level.var_99a34951 = getgametypesetting(#"hash_712f4c2a96bca56e");
  level.var_33a3ef40 = getgametypesetting(#"hash_647310a2fe3554f7");
  level.var_aff59367 = getgametypesetting(#"hash_44533f4f290c5e77");
  level.pickup_respawn_time = getgametypesetting(#"hash_6a2434c947c86b9b");
}

function_e963e37d() {
  var_7a23c03b = getEntArray("pickup_health", "targetname");

  foreach(pickup in var_7a23c03b) {
    pickup.trigger = spawn("trigger_radius_use", pickup.origin + (0, 0, 15), 0, 120, 100);
    pickup.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    pickup.trigger triggerignoreteam();
    pickup.gameobject = gameobjects::create_use_object(#"neutral", pickup.trigger, [], (0, 0, 60), "pickup_health");
    pickup.gameobject gameobjects::set_objective_entity(pickup.gameobject);
    pickup.gameobject gameobjects::set_visible_team(#"any");
    pickup.gameobject gameobjects::allow_use(#"any");
    pickup.gameobject gameobjects::set_use_time(0);
    pickup.gameobject.usecount = 0;
    pickup.gameobject.parentobj = pickup;
    pickup.gameobject.onuse = &function_5bb13b48;
  }
}

function_dd4bf8ac(num) {
  if(self.pers[#"pickup_health"] < level.var_99a34951) {
    self.pers[#"pickup_health"] += num;
    self function_2bcfabea();
    return true;
  }

  return false;
}

private onconnect() {
  if(!isDefined(self.pers[#"pickup_health"])) {
    self.pers[#"pickup_health"] = 0;
  }
}

private onspawned() {
  self function_3fbb0e22();
}

function_3fbb0e22() {
  waitframe(1);
  self function_2bcfabea();
}

private onhealthregen(slot, weapon) {
  self.pers[#"pickup_health"]--;
}

private offhealthregen(slot, weapon) {
  self gadgetdeactivate(self.gadget_health_regen_slot, self.gadget_health_regen_weapon);
  thread healingdone();
}

private healingdone() {
  wait 0.5;
  self function_2bcfabea();
}

private function_5bb13b48(player) {
  if(isDefined(player) && isplayer(player)) {
    if(player function_dd4bf8ac(1)) {
      if(isDefined(self.objectiveid)) {
        objective_setinvisibletoplayer(self.objectiveid, player);
      }

      self.parentobj setinvisibletoplayer(player);
      self.trigger setinvisibletoplayer(player);
      player playsoundtoplayer(#"hash_8a4d3f134fa94d7", player);
      self.usecount++;
      player gestures::function_56e00fbf(#"gestable_grab", undefined, 0);

      if(isDefined(level.var_aff59367) && level.var_aff59367) {
        self thread function_7a80944d(player);
      }
    } else {
      player iprintlnbold(#"hash_5a11b7ef0cd7e33b");
      player playsoundtoplayer(#"uin_unavailable_charging", player);
    }
  }

  if(!(isDefined(level.var_aff59367) && level.var_aff59367) && self.usecount >= level.var_ad9d03e7) {
    self.parentobj delete();
    self gameobjects::disable_object(1);
  }
}

private function_7a80944d(player) {
  level endon(#"game_ended");
  self endon(#"death");
  player endon(#"disconnect");
  wait isDefined(level.pickup_respawn_time) ? level.pickup_respawn_time : 0;

  if(isDefined(self.objectiveid)) {
    objective_setvisibletoplayer(self.objectiveid, player);
  }

  self.parentobj setvisibletoplayer(player);
  self.trigger setvisibletoplayer(player);
}

private function_2bcfabea() {
  if(!isDefined(self) || !isDefined(self.pers[#"pickup_health"])) {
    return;
  }

  if(self.pers[#"pickup_health"] <= 0) {
    self gadget_health_regen::power_off();

    if(isDefined(self.gadget_health_regen_slot)) {
      self function_19ed70ca(self.gadget_health_regen_slot, 1);
    }

    if(self.pers[#"pickup_health"] < 0) {
      self.pers[#"pickup_health"] = 0;
    }
  } else {
    self gadget_health_regen::power_on();

    if(self.pers[#"pickup_health"] > level.var_99a34951) {
      self.pers[#"pickup_health"] = level.var_99a34951;
    }
  }

  self clientfield::set_player_uimodel("hudItems.numHealthPickups", self.pers[#"pickup_health"]);
}