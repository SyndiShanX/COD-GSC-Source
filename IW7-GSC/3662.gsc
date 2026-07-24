/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3662.gsc
**************************************/

_id_96F1() {
  anim.player._id_3D4C = [];
  anim.player._id_3D4C["threat"] = spawnStruct();
  anim.player._id_3D4C["threat"]._id_698B = 0;
  anim.player._id_3D4C["threat"].priority = 0.0;
  anim.player._id_3D4C["response"] = spawnStruct();
  anim.player._id_3D4C["response"]._id_698B = 0;
  anim.player._id_3D4C["response"].priority = 0.0;
  anim.player._id_3D4C["reaction"] = spawnStruct();
  anim.player._id_3D4C["reaction"]._id_698B = 0;
  anim.player._id_3D4C["reaction"].priority = 0.0;
  anim.player._id_3D4C["inform"] = spawnStruct();
  anim.player._id_3D4C["inform"]._id_698B = 0;
  anim.player._id_3D4C["inform"].priority = 0.0;
  anim.player._id_3D4C["order"] = spawnStruct();
  anim.player._id_3D4C["order"]._id_698B = 0;
  anim.player._id_3D4C["order"].priority = 0.0;
  anim.player._id_3D4C["custom"] = spawnStruct();
  anim.player._id_3D4C["custom"]._id_698B = 0;
  anim.player._id_3D4C["custom"].priority = 0.0;
  anim.player._id_BFA8 = gettime() + 50;
  anim.player._id_BFA9["threat"] = 0;
  anim.player._id_BFA9["reaction"] = 0;
  anim.player._id_BFA9["response"] = 0;
  anim.player._id_BFA9["inform"] = 0;
  anim.player._id_BFA9["order"] = 0;
  anim.player._id_BFA9["custom"] = 0;
  anim.player._id_9F6B = 0;
  anim.player._id_29BF = 0.0;

  if(isDefined(level._id_D127) && anim.player == level._id_D127) {
    anim.player._id_46BC = "JK";
  } else {
    anim.player._id_46BC = "UN";
  }
}

_id_CF8E() {
  while(!isDefined(anim._id_3D4B)) {
    wait 0.5;
  }

  if(!isDefined(anim.player._id_28CF) || isDefined(anim.player._id_28CF) && !anim.player._id_28CF) {
    anim.player._id_28CF = 1;
    anim.player._id_9F6B = 0;
    thread _id_CF87();
    anim.player thread _id_D439();
  }
}

_id_D313() {
  if(!isDefined(anim.player._id_1C8B)) {
    anim.player._id_1C8B = [];
    anim.player scripts\anim\battlechatter::_id_17A2("rpg");
    anim.player scripts\anim\battlechatter::_id_17A2("exposed");
    anim.player scripts\anim\battlechatter::_id_17A2("acquired");
    anim.player scripts\anim\battlechatter::_id_17A2("sighted");
    anim.player scripts\anim\battlechatter::_id_17A2("ai_contact_clock");
    anim.player scripts\anim\battlechatter::_id_17A2("ai_target_clock");
    anim.player scripts\anim\battlechatter::_id_17A2("ai_cardinal");
    anim.player scripts\anim\battlechatter::_id_17A2("player_contact_clock");
    anim.player scripts\anim\battlechatter::_id_17A2("player_target_clock");
    anim.player scripts\anim\battlechatter::_id_17A2("player_cardinal");
    anim.player scripts\anim\battlechatter::_id_17A2("ai_obvious");
    anim.player scripts\anim\battlechatter::_id_17A2("player_object_clock");
    anim.player scripts\anim\battlechatter::_id_17A2("player_location");
    anim.player scripts\anim\battlechatter::_id_17A2("ai_location");
    anim.player scripts\anim\battlechatter::_id_17A2("generic_location");
    anim.player scripts\anim\battlechatter::_id_17A2("ai_casual_clock");
    anim.player scripts\anim\battlechatter::_id_17A2("concat_location");
    anim.player scripts\anim\battlechatter::_id_17A2("concat_location");
    anim.player scripts\anim\battlechatter::_id_17A2("player_distance");
    anim.player scripts\anim\battlechatter::_id_17A2("player_target_clock_high");
    anim.player scripts\anim\battlechatter::_id_17A2("ai_distance");
    anim.player scripts\anim\battlechatter::_id_17A2("ai_target_clock_high");
  }
}

_id_CF8C() {
  anim notify("player_battlechatter_off");

  if(isDefined(anim.player) && isDefined(anim.player._id_28CF)) {
    anim.player._id_28CF = 0;
  }

  if(isDefined(anim.player) && isDefined(anim.player._id_9F6B)) {
    anim.player._id_9F6B = 0;
  }
}

_id_D439() {
  self endon("death");
  self endon("player_battlechatter_off");
  var_0 = 0.5;
  wait(var_0);

  if(!scripts\engine\utility::player_is_in_jackal()) {
    thread scripts\anim\battlechatter_ai::_id_1A10();
  }

  wait(var_0);
  thread _id_D381();
  wait(var_0);
  thread _id_D37C();
  wait(var_0);
  thread scripts\anim\battlechatter_ai::_id_1A07();
}

_id_D37C() {
  while(isalive(anim.player) && scripts\anim\battlechatter::_id_29CA() && (isDefined(anim.player._id_28CF) && anim.player._id_28CF)) {
    anim.player waittill("damage", var_0, var_1);

    if(!scripts\engine\utility::player_is_in_jackal()) {
      if(var_1 scripts\anim\battlechatter::_id_29AB()) {
        var_2 = anim._id_10AF9["allies"]._id_B661;
        var_2 = scripts\engine\utility::array_randomize(var_2);

        foreach(var_4 in var_2) {
          if(isalive(var_4) && isai(var_4) && distancesquared(anim.player.origin, var_4.origin) > 10000) {
            var_4 scripts\anim\battlechatter_ai::_id_183F("infantry", var_1, 0.9);
            break;
          }
        }
      }
    }

    wait 1.0;
  }
}

_id_D381() {
  while(!scripts\engine\utility::player_is_in_jackal() && isalive(anim.player) && scripts\anim\battlechatter::_id_29CA()) {
    wait 1.0;
  }

  while(isalive(anim.player) && scripts\anim\battlechatter::_id_29CA() && (isDefined(anim.player._id_28CF) && anim.player._id_28CF)) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      if(isDefined(level.player._id_58B7)) {
        if(isDefined(level.player._id_58B7._blackboard) && isDefined(level.player._id_58B7._blackboard._id_9DE4)) {
          if(level.player._id_58B7._blackboard._id_9DE4) {
            wait(randomfloatrange(0.25, 0.5));

            if(isDefined(level.player._id_58B7)) {
              anim.player scripts\anim\battlechatter_ai::_id_181C("movement", "generic", level.player._id_58B7, 0.9);
            }
          } else {
            wait(randomfloatrange(0.5, 0.75));

            if(isDefined(level.player._id_58B7)) {
              anim.player scripts\anim\battlechatter_ai::_id_183F("acquired", level.player._id_58B7);
            }
          }
        }
      }
    }

    wait 1.0;

    while(!scripts\engine\utility::player_is_in_jackal() && isalive(anim.player) && scripts\anim\battlechatter::_id_29CA()) {
      wait 1.0;
    }
  }
}

_id_D45C() {
  var_0 = undefined;

  while(isalive(anim.player) && scripts\anim\battlechatter::_id_29CA() && (isDefined(anim.player._id_28CF) && anim.player._id_28CF)) {
    if(!scripts\engine\utility::player_is_in_jackal()) {
      var_1 = scripts\sp\utility::_id_81FF();

      foreach(var_3 in var_1) {
        if(!isDefined(var_3)) {
          continue;
        }
        if(isDefined(var_0) && var_0 == var_3) {
          continue;
        }
        if(issubstr(var_3.classname, "dropship")) {
          if(isDefined(var_3.script_team) && var_3.script_team != anim.player.team) {
            if(anim.player scripts\anim\battlechatter::_id_D643(var_3.origin) && distancesquared(anim.player.origin, var_3.origin) < 4000000) {
              var_4 = anim._id_10AF9["allies"]._id_B661;
              var_4 = scripts\engine\utility::array_randomize(var_4);

              foreach(var_6 in var_4) {
                if(isalive(var_6) && isai(var_6) && distancesquared(anim.player.origin, var_6.origin) < 250000) {
                  var_6 scripts\anim\battlechatter_ai::_id_17D2("incoming", "dropship", undefined, 0.9, "vehicle");
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

    while(scripts\engine\utility::player_is_in_jackal()) {
      wait 5.0;
    }
  }
}

_id_CF87() {
  anim.player._id_29C8 = 1;

  while(isalive(anim.player) && scripts\anim\battlechatter::_id_29CA() && (isDefined(anim.player._id_28CF) && anim.player._id_28CF)) {
    if(anim.player._id_29C8 == 0) {
      var_0 = 10;
    } else {
      var_0 = anim.player._id_29C8;
    }

    anim.player._id_9F6B = 1;

    for(var_1 = var_0; var_1 >= 0; var_1--) {
      anim.player._id_29C8 = var_1;
      wait 1.0;
    }

    anim.player._id_9F6B = 0;
    level waittill("player_battlechatter_refresh");

    while(anim.player._id_9F6B != 0) {
      wait 0.5;
    }
  }
}

_id_CF89() {
  anim.player endon("death");
  level endon("player_battlechatter_off");
  var_0 = "none";
  var_1 = ["pc_ammocrate_pickup", "pc_equipcrate_pickup", "pc_weapon_scanned", "pc_armory_door", "pc_clear_last_event"];

  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_in_array_return(var_1);

    if(var_2 != var_0 && var_2 != "pc_clear_last_event") {
      anim.player scripts\anim\battlechatter::_id_CEE8(var_2);
      var_0 = var_2;
      thread _id_CF88();
    } else if(var_2 == "pc_clear_last_event")
      var_0 = "none";

    wait 1;
  }
}

_id_CF88() {
  wait 10;
  level notify("pc_clear_last_event");
}

_id_CF86() {
  anim.player endon("death");
  level endon("player_battlechatter_off");

  for(;;) {
    var_0 = distance(anim.player.origin, self.origin);

    if(var_0 < 500) {
      if(scripts\sp\utility::_id_D1DF(self.origin + (0, 0, 40))) {
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

    wait 1.0;
  }
}

_id_9FE0(var_0) {
  if(!isDefined(self._id_10AC8._id_9E9B[var_0]) || !isDefined(anim.isteamsaying[self.team][var_0])) {
    return 1;
  }

  if(!self._id_10AC8._id_9E9B[var_0] && !anim.isteamsaying[self.team][var_0]) {
    return 1;
  }

  return 0;
}