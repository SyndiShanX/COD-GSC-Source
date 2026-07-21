/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player\playerchatter.gsc
***********************************************/

init_playerchatter() {
  anim.player.battlechatter = spawnStruct();
  anim.player.battlechatter.chatqueue = [];
  anim.player.battlechatter.chatqueue["threat"] = spawnStruct();
  anim.player.battlechatter.chatqueue["threat"].expiretime = 0;
  anim.player.battlechatter.chatqueue["threat"].priority = 0.0;
  anim.player.battlechatter.chatqueue["response"] = spawnStruct();
  anim.player.battlechatter.chatqueue["response"].expiretime = 0;
  anim.player.battlechatter.chatqueue["response"].priority = 0.0;
  anim.player.battlechatter.chatqueue["reaction"] = spawnStruct();
  anim.player.battlechatter.chatqueue["reaction"].expiretime = 0;
  anim.player.battlechatter.chatqueue["reaction"].priority = 0.0;
  anim.player.battlechatter.chatqueue["inform"] = spawnStruct();
  anim.player.battlechatter.chatqueue["inform"].expiretime = 0;
  anim.player.battlechatter.chatqueue["inform"].priority = 0.0;
  anim.player.battlechatter.chatqueue["order"] = spawnStruct();
  anim.player.battlechatter.chatqueue["order"].expiretime = 0;
  anim.player.battlechatter.chatqueue["order"].priority = 0.0;
  anim.player.battlechatter.chatqueue["custom"] = spawnStruct();
  anim.player.battlechatter.chatqueue["custom"].expiretime = 0;
  anim.player.battlechatter.chatqueue["custom"].priority = 0.0;
  anim.player.battlechatter.chatqueue["stealth"] = spawnStruct();
  anim.player.battlechatter.chatqueue["stealth"].expiretime = 0;
  anim.player.battlechatter.chatqueue["stealth"].priority = 0.0;
  anim.player.battlechatter.nextsaytime = gettime() + 50;
  anim.player.battlechatter.nextsaytimes["threat"] = 0;
  anim.player.battlechatter.nextsaytimes["reaction"] = 0;
  anim.player.battlechatter.nextsaytimes["response"] = 0;
  anim.player.battlechatter.nextsaytimes["inform"] = 0;
  anim.player.battlechatter.nextsaytimes["order"] = 0;
  anim.player.battlechatter.nextsaytimes["custom"] = 0;
  anim.player.battlechatter.nextsaytimes["stealth"] = 0;
  anim.player.battlechatter.isspeaking = 0;
  anim.player.battlechatter.minpriority = 0.0;
  anim.player.battlechatter.countryid = "UN";
}

player_battlechatter_on_thread() {
  while(!isDefined(anim.chatinitialized))
    wait 0.5;

  if(!isDefined(anim.player.battlechatterallowed) || isDefined(anim.player.battlechatterallowed) && !anim.player.battlechatterallowed) {
    anim.player.battlechatterallowed = 1;
    anim.player.battlechatter.isspeaking = 0;
    thread player_battlechatter_cooldown_control();
    anim.player thread playerthreadthreader();
  }
}

player_update_allowed_callouts() {
  if(!isDefined(anim.player.allowedcallouts)) {
    anim.player.allowedcallouts = [];
    anim.player scripts\anim\battlechatter.gsc::addallowedthreatcallout("rpg");
    anim.player scripts\anim\battlechatter.gsc::addallowedthreatcallout("exposed");
    anim.player scripts\anim\battlechatter.gsc::addallowedthreatcallout("acquired");
    anim.player scripts\anim\battlechatter.gsc::addallowedthreatcallout("sighted");
    anim.player scripts\anim\battlechatter.gsc::addallowedthreatcallout("target_compass");
    anim.player scripts\anim\battlechatter.gsc::addallowedthreatcallout("target_distance");
    anim.player scripts\anim\battlechatter.gsc::addallowedthreatcallout("target_elev");
    anim.player scripts\anim\battlechatter.gsc::addallowedthreatcallout("player_object_clock");
    anim.player scripts\anim\battlechatter.gsc::addallowedthreatcallout("player_location");
    anim.player scripts\anim\battlechatter.gsc::addallowedthreatcallout("ai_location");
    anim.player scripts\anim\battlechatter.gsc::addallowedthreatcallout("generic_location");
    anim.player scripts\anim\battlechatter.gsc::addallowedthreatcallout("concat_location");
  }
}

player_battlechatter_off_thread() {
  anim notify("player_battlechatter_off");

  if(isDefined(anim.player) && isDefined(anim.player.battlechatterallowed))
    anim.player.battlechatterallowed = 0;

  if(isDefined(anim.player) && isDefined(anim.player.battlechatter.isspeaking))
    anim.player.battlechatter.isspeaking = 0;
}

playerthreadthreader() {
  self endon("death");
  self endon("player_battlechatter_off");
  var_0 = 0.5;
  wait(var_0);
  thread scripts\anim\battlechatter_ai.gsc::aiinformweaponwaiter();
  wait(var_0);
  thread playerdogfightwaiter();
  wait(var_0);
  thread playerdamagewaiter();
  wait(var_0);
  thread scripts\anim\battlechatter_ai.gsc::aibattlechatterloop();
}

playerdamagewaiter() {
  while(isalive(anim.player) && scripts\anim\battlechatter.gsc::bcsenabled() && (isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed)) {
    anim.player waittill("damage", var_0, var_1);

    if(!scripts\engine\utility::player_is_in_jackal()) {
      if(var_1 scripts\anim\battlechatter.gsc::bcissniper()) {
        var_2 = anim.squads["allies"].members;
        var_2 = scripts\engine\utility::array_randomize(var_2);

        foreach(var_4 in var_2) {
          if(isalive(var_4) && isai(var_4) && distancesquared(anim.player.origin, var_4.origin) > 10000) {
            var_4 scripts\anim\battlechatter_ai.gsc::addthreatevent("infantry", var_1, 0.9);
            break;
          }
        }
      }
    }

    wait 1.0;
  }
}

playerdogfightwaiter() {
  while(!scripts\engine\utility::player_is_in_jackal() && isalive(anim.player) && scripts\anim\battlechatter.gsc::bcsenabled())
    wait 1.0;

  while(isalive(anim.player) && scripts\anim\battlechatter.gsc::bcsenabled() && (isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed)) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      if(isDefined(level.player.dogfighttarget)) {
        if(isDefined(level.player.dogfighttarget._blackboard) && isDefined(level.player.dogfighttarget._blackboard.isevading)) {
          if(level.player.dogfighttarget._blackboard.isevading) {
            wait(randomfloatrange(0.25, 0.5));

            if(isDefined(level.player.dogfighttarget))
              anim.player scripts\anim\battlechatter_ai.gsc::addreactionevent("movement", "generic", level.player.dogfighttarget, 0.9);
          } else {
            wait(randomfloatrange(0.5, 0.75));

            if(isDefined(level.player.dogfighttarget))
              anim.player scripts\anim\battlechatter_ai.gsc::addthreatevent("acquired", level.player.dogfighttarget);
          }
        }
      }
    }

    wait 1.0;

    while(!scripts\engine\utility::player_is_in_jackal() && isalive(anim.player) && scripts\anim\battlechatter.gsc::bcsenabled())
      wait 1.0;
  }
}

playervehiclewaiter() {
  var_0 = undefined;

  while(isalive(anim.player) && scripts\anim\battlechatter.gsc::bcsenabled() && (isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed)) {
    if(!scripts\engine\utility::player_is_in_jackal()) {
      var_1 = scripts\engine\sp\utility::getvehiclearray();

      foreach(var_3 in var_1) {
        if(!isDefined(var_3)) {
          continue;
        }
        if(isDefined(var_0) && var_0 == var_3) {
          continue;
        }
        if(issubstr(var_3.classname, "dropship")) {
          if(isDefined(var_3.script_team) && var_3.script_team != anim.player.team) {
            if(anim.player scripts\anim\battlechatter.gsc::pointinfov(var_3.origin) && distancesquared(anim.player.origin, var_3.origin) < 4000000) {
              var_4 = anim.squads["allies"].members;
              var_4 = scripts\engine\utility::array_randomize(var_4);

              foreach(var_6 in var_4) {
                if(isalive(var_6) && isai(var_6) && distancesquared(anim.player.origin, var_6.origin) < 250000) {
                  var_6 scripts\anim\battlechatter_ai.gsc::addinformevent("incoming", "dropship", 0.9, "vehicle");
                  var_0 = var_3;
                }
              }

              wait(randomintrange(15, 25));
            }
          }
        }
      }
    }

    wait 2;

    while(scripts\engine\utility::player_is_in_jackal())
      wait 5.0;
  }
}

player_battlechatter_cooldown_control() {
  anim.player.bcscooldown = 1;

  while(isalive(anim.player) && scripts\anim\battlechatter.gsc::bcsenabled() && (isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed)) {
    if(anim.player.bcscooldown == 0)
      var_0 = 10;
    else
      var_0 = anim.player.bcscooldown;

    anim.player.battlechatter.isspeaking = 1;

    for(var_1 = var_0; var_1 >= 0; var_1--) {
      anim.player.bcscooldown = var_1;
      wait 1.0;
    }

    anim.player.battlechatter.isspeaking = 0;
    level waittill("player_battlechatter_refresh");

    while(anim.player.battlechatter.isspeaking != 0)
      wait 0.5;
  }
}

player_battlechatter_generic_event_check() {
  anim.player endon("death");
  level endon("player_battlechatter_off");
  var_0 = "none";
  var_1 = ["pc_ammocrate_pickup", "pc_equipcrate_pickup", "pc_weapon_scanned", "pc_armory_door", "pc_clear_last_event"];

  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_in_array_return(var_1);

    if(var_2 != var_0 && var_2 != "pc_clear_last_event") {
      anim.player scripts\anim\battlechatter.gsc::playbattlechatter(var_2);
      var_0 = var_2;
      thread player_battlechatter_event_clear();
    } else if(var_2 == "pc_clear_last_event")
      var_0 = "none";

    wait 1;
  }
}

player_battlechatter_event_clear() {
  wait 10;
  level notify("pc_clear_last_event");
}

player_battlechatter_check_for_crate_pickups() {
  anim.player endon("death");
  level endon("player_battlechatter_off");

  for(;;) {
    var_0 = distance(anim.player.origin, self.origin);

    if(var_0 < 500) {
      if(scripts\engine\sp\utility::player_looking_at(self.origin + (0, 0, 40))) {
        if(self.targetname == "ammo_pickup")
          level notify("pc_ammocrate_pickup");

        if(self.targetname == "equipment_pickup")
          level notify("pc_equipcrate_pickup");

        if(self.targetname == "loot_hint_struct")
          level notify("pc_armory_door");

        break;
      }
    }

    wait 1.0;
  }
}

isvalidplayerevent(var_0) {
  if(!isDefined(self.squad.ismembersaying[var_0]) || !isDefined(anim.isteamsaying[self.team][var_0]))
    return 1;

  if(!self.squad.ismembersaying[var_0] && !anim.isteamsaying[self.team][var_0])
    return 1;

  return 0;
}