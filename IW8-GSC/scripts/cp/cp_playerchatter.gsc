/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_playerchatter.gsc
***********************************************/

function init_playerchatter() {
  if(isDefined(anim.player.battlechatter)) {
    return;
  }

  anim.player.battlechatter = spawnStruct();
  anim.player.battlechatter.chatqueue = [];
  anim.player.battlechatter.chatqueue["threat"] = spawnStruct();
  anim.player.battlechatter.chatqueue["threat"].expiretime = 0;
  anim.player.battlechatter.chatqueue["threat"].priority = 0;
  anim.player.battlechatter.chatqueue["response"] = spawnStruct();
  anim.player.battlechatter.chatqueue["response"].expiretime = 0;
  anim.player.battlechatter.chatqueue["response"].priority = 0;
  anim.player.battlechatter.chatqueue["reaction"] = spawnStruct();
  anim.player.battlechatter.chatqueue["reaction"].expiretime = 0;
  anim.player.battlechatter.chatqueue["reaction"].priority = 0;
  anim.player.battlechatter.chatqueue["inform"] = spawnStruct();
  anim.player.battlechatter.chatqueue["inform"].expiretime = 0;
  anim.player.battlechatter.chatqueue["inform"].priority = 0;
  anim.player.battlechatter.chatqueue["order"] = spawnStruct();
  anim.player.battlechatter.chatqueue["order"].expiretime = 0;
  anim.player.battlechatter.chatqueue["order"].priority = 0;
  anim.player.battlechatter.chatqueue["custom"] = spawnStruct();
  anim.player.battlechatter.chatqueue["custom"].expiretime = 0;
  anim.player.battlechatter.chatqueue["custom"].priority = 0;
  anim.player.battlechatter.chatqueue["stealth"] = spawnStruct();
  anim.player.battlechatter.chatqueue["stealth"].expiretime = 0;
  anim.player.battlechatter.chatqueue["stealth"].priority = 0;
  anim.player.battlechatter.nextsaytime = gettime() + 50;
  anim.player.battlechatter.nextsaytimes["threat"] = 0;
  anim.player.battlechatter.nextsaytimes["reaction"] = 0;
  anim.player.battlechatter.nextsaytimes["response"] = 0;
  anim.player.battlechatter.nextsaytimes["inform"] = 0;
  anim.player.battlechatter.nextsaytimes["order"] = 0;
  anim.player.battlechatter.nextsaytimes["custom"] = 0;
  anim.player.battlechatter.nextsaytimes["stealth"] = 0;
  anim.player.battlechatter.isspeaking = 0;
  anim.player.battlechatter.minpriority = 0;
  anim.player.battlechatter.countryid = "UN";
}

function player_battlechatter_on_thread() {
  while(!isDefined(anim.chatinitialized)) {
    wait 0.5;
  }

  if(!isDefined(anim.player.battlechatterallowed) || isDefined(anim.player.battlechatterallowed) && !anim.player.battlechatterallowed) {
    anim.player.battlechatterallowed = 1;
    anim.player.battlechatter.isspeaking = 0;
    thread player_battlechatter_cooldown_control();
    thread playerthreadthreader();
    return;
  }
}

function player_update_allowed_callouts() {
  if(!isDefined(anim.player.allowedcallouts)) {
    anim.player.allowedcallouts = [];
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("rpg");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("exposed");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("acquired");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("sighted");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("ai_contact_clock");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("ai_target_clock");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("ai_cardinal");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("player_contact_clock");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("player_target_clock");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("player_cardinal");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("ai_obvious");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("player_object_clock");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("player_location");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("ai_location");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("generic_location");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("ai_casual_clock");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("concat_location");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("concat_location");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("player_distance");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("player_target_clock_high");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("ai_distance");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("ai_target_clock_high");
    return;
  }
}

function player_battlechatter_off_thread() {
  anim notify("player_battlechatter_off");

  if(isDefined(anim.player) && isDefined(anim.player.battlechatterallowed)) {
    anim.player.battlechatterallowed = 0;
  }

  if(isDefined(anim.player) && isDefined(anim.player.battlechatter.isspeaking)) {
    anim.player.battlechatter.isspeaking = 0;
    return;
  }
}

function playerthreadthreader() {
  self endon("death");
  self endon("player_battlechatter_off");
  var0 = 0.5;
  wait var0;
  thread scripts\cp\cp_battlechatter_ai::aigrenadedangerwaiter();
  wait var0;
  thread playerdogfightwaiter();
  wait var0;
  thread playerdamagewaiter();
  wait var0;
  thread scripts\cp\cp_battlechatter_ai::aibattlechatterloop();
}

function playerdamagewaiter() {
  while(isalive(anim.player) && scripts\cp\cp_battlechatter::bcsenabled() && isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed) {
    anim.player waittill("damage", var0, var1);

    if(var1 scripts\cp\cp_battlechatter::bcissniper()) {
      var2 = anim.squads["allies"].members;
      var2 = scripts\engine\utility::array_randomize(var2);

      foreach(var4 in var2) {
        if(isalive(var4) && isai(var4) && distancesquared(anim.player.origin, var4.origin) > 10000) {
          var4 scripts\cp\cp_battlechatter_ai::addthreatevent("infantry", var1, 0.9);
          break;
        }
      }
    }

    wait 1;
  }
}

function playerdogfightwaiter() {
  while(!scripts\engine\utility::player_is_in_jackal() && isalive(anim.player) && scripts\cp\cp_battlechatter::bcsenabled()) {
    wait 1;
  }

  while(isalive(anim.player) && scripts\cp\cp_battlechatter::bcsenabled() && isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      if(isDefined(level.player.dogfighttarget)) {
        if(isDefined(level.player.dogfighttarget._blackboard) && isDefined(level.player.dogfighttarget._blackboard.isevading)) {
          if(level.player.dogfighttarget._blackboard.isevading) {
            wait randomfloatrange(0.25, 0.5);

            if(isDefined(level.player.dogfighttarget)) {
              anim.player scripts\cp\cp_battlechatter_ai::addreactionevent("movement", "generic", level.player.dogfighttarget, 0.9);
            }
          } else {
            wait randomfloatrange(0.5, 0.75);

            if(isDefined(level.player.dogfighttarget)) {
              anim.player scripts\cp\cp_battlechatter_ai::addthreatevent("acquired", level.player.dogfighttarget);
            }
          }
        }
      }
    }

    wait 1;

    while(!scripts\engine\utility::player_is_in_jackal() && isalive(anim.player) && scripts\cp\cp_battlechatter::bcsenabled()) {
      wait 1;
    }
  }
}

function playervehiclewaiter() {
  var0 = undefined;

  while(isalive(anim.player) && scripts\cp\cp_battlechatter::bcsenabled() && isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed) {
    if(!scripts\engine\utility::player_is_in_jackal()) {
      var1 = scripts\cp\utility::getvehiclearray();

      foreach(var3 in var1) {
        if(!isDefined(var3)) {
          continue;
        }

        if(isDefined(var0) && var0 == var3) {
          continue;
        }

        if(issubstr(var3.classname, "dropship")) {
          if(isDefined(var3.script_team) && var3.script_team != anim.player.team) {
            if(anim.player scripts\cp\cp_battlechatter::pointinfov(var3.origin) && distancesquared(anim.player.origin, var3.origin) < 4000000) {
              var4 = anim.squads["allies"].members;
              var4 = scripts\engine\utility::array_randomize(var4);

              foreach(var6 in var4) {
                if(isalive(var6) && isai(var6) && distancesquared(anim.player.origin, var6.origin) < 250000) {
                  var6 scripts\cp\cp_battlechatter_ai::addinformevent("incoming", "dropship", 0.9, "vehicle");
                  var0 = var3;
                }
              }

              wait randomintrange(15, 25);
            }
          }
        }
      }
    }

    wait 2;

    while(scripts\engine\utility::player_is_in_jackal()) {
      wait 5;
    }
  }
}

function player_battlechatter_cooldown_control() {
  anim.player.bcscooldown = 1;

  while(isalive(anim.player) && scripts\cp\cp_battlechatter::bcsenabled() && isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed) {
    if(anim.player.bcscooldown == 0) {
      var0 = 10;
    } else {
      var0 = anim.player.bcscooldown;
    }

    anim.player.battlechatter.isspeaking = 1;

    for(var1 = var0; var1 >= 0; var1--) {
      anim.player.bcscooldown = var1;
      wait 1;
    }

    anim.player.battlechatter.isspeaking = 0;
    level waittill("player_battlechatter_refresh");

    while(anim.player.battlechatter.isspeaking != 0) {
      wait 0.5;
    }
  }
}

function player_battlechatter_generic_event_check() {
  anim.player endon("death");
  level endon("player_battlechatter_off");
  var0 = "none";
  var1 = ["pc_ammocrate_pickup", "pc_equipcrate_pickup", "pc_weapon_scanned", "pc_armory_door", "pc_clear_last_event"];

  for(;;) {
    var2 = scripts\engine\utility::waittill_any_in_array_return(var1);

    if(var2 != var0 && var2 != "pc_clear_last_event") {
      anim.player scripts\cp\cp_battlechatter::playbattlechatter(var2);
      var0 = var2;
      thread player_battlechatter_event_clear();
    } else if(var2 == "pc_clear_last_event") {
      var0 = "none";
    }

    wait 1;
  }
}

function player_battlechatter_event_clear() {
  wait 10;
  level notify("pc_clear_last_event");
}

function player_battlechatter_check_for_crate_pickups() {
  anim.player endon("death");
  level endon("player_battlechatter_off");

  for(;;) {
    var0 = distance(anim.player.origin, self.origin);

    if(var0 < 500) {
      if(scripts\cp\utility::player_looking_at(self.origin + (0, 0, 40))) {
        if(self.targetname == "ammo_pickup") {
          level notify("pc_ammocrate_pickup");
        }

        if(self.targetname == "equipment_pickup") {
          level notify("pc_equipcrate_pickup");
        }

        if(self.targetname == "loot_hint_struct") {
          level notify("pc_armory_door");
        }

        break;
      }
    }

    wait 1;
  }
}

function isvalidplayerevent(var0) {
  if(!isDefined(self.squad.ismembersaying[var0]) || !isDefined(anim.isteamsaying[self.team][var0])) {
    return true;
  }

  if(!self.squad.ismembersaying[var0] && !anim.isteamsaying[self.team][var0]) {
    return true;
  }

  return false;
}