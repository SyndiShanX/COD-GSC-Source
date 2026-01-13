/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3662.gsc
*********************************************/

func_96F1() {
  level.player.var_3D4C = [];
  level.player.var_3D4C["threat"] = spawnStruct();
  level.player.var_3D4C["threat"].var_698B = 0;
  level.player.var_3D4C["threat"].priority = 0;
  level.player.var_3D4C["response"] = spawnStruct();
  level.player.var_3D4C["response"].var_698B = 0;
  level.player.var_3D4C["response"].priority = 0;
  level.player.var_3D4C["reaction"] = spawnStruct();
  level.player.var_3D4C["reaction"].var_698B = 0;
  level.player.var_3D4C["reaction"].priority = 0;
  level.player.var_3D4C["inform"] = spawnStruct();
  level.player.var_3D4C["inform"].var_698B = 0;
  level.player.var_3D4C["inform"].priority = 0;
  level.player.var_3D4C["order"] = spawnStruct();
  level.player.var_3D4C["order"].var_698B = 0;
  level.player.var_3D4C["order"].priority = 0;
  level.player.var_3D4C["custom"] = spawnStruct();
  level.player.var_3D4C["custom"].var_698B = 0;
  level.player.var_3D4C["custom"].priority = 0;
  level.player.var_BFA8 = gettime() + 50;
  level.player.var_BFA9["threat"] = 0;
  level.player.var_BFA9["reaction"] = 0;
  level.player.var_BFA9["response"] = 0;
  level.player.var_BFA9["inform"] = 0;
  level.player.var_BFA9["order"] = 0;
  level.player.var_BFA9["custom"] = 0;
  level.player.var_9F6B = 0;
  level.player.var_29BF = 0;
  if(isDefined(level.var_D127) && level.player == level.var_D127) {
    level.player.var_46BC = "JK";
    return;
  }

  level.player.var_46BC = "UN";
}

func_CF8E() {
  while(!isDefined(level.var_3D4B)) {
    wait(0.5);
  }

  if(!isDefined(level.player.var_28CF) || isDefined(level.player.var_28CF) && !level.player.var_28CF) {
    level.player.var_28CF = 1;
    level.player.var_9F6B = 0;
    thread func_CF87();
    level.player thread func_D439();
  }
}

func_D313() {
  if(!isDefined(level.player.var_1C8B)) {
    level.player.var_1C8B = [];
    level.player scripts\anim\battlechatter::func_17A2("rpg");
    level.player scripts\anim\battlechatter::func_17A2("exposed");
    level.player scripts\anim\battlechatter::func_17A2("acquired");
    level.player scripts\anim\battlechatter::func_17A2("sighted");
    level.player scripts\anim\battlechatter::func_17A2("ai_contact_clock");
    level.player scripts\anim\battlechatter::func_17A2("ai_target_clock");
    level.player scripts\anim\battlechatter::func_17A2("ai_cardinal");
    level.player scripts\anim\battlechatter::func_17A2("player_contact_clock");
    level.player scripts\anim\battlechatter::func_17A2("player_target_clock");
    level.player scripts\anim\battlechatter::func_17A2("player_cardinal");
    level.player scripts\anim\battlechatter::func_17A2("ai_obvious");
    level.player scripts\anim\battlechatter::func_17A2("player_object_clock");
    level.player scripts\anim\battlechatter::func_17A2("player_location");
    level.player scripts\anim\battlechatter::func_17A2("ai_location");
    level.player scripts\anim\battlechatter::func_17A2("generic_location");
    level.player scripts\anim\battlechatter::func_17A2("ai_casual_clock");
    level.player scripts\anim\battlechatter::func_17A2("concat_location");
    level.player scripts\anim\battlechatter::func_17A2("concat_location");
    level.player scripts\anim\battlechatter::func_17A2("player_distance");
    level.player scripts\anim\battlechatter::func_17A2("player_target_clock_high");
    level.player scripts\anim\battlechatter::func_17A2("ai_distance");
    level.player scripts\anim\battlechatter::func_17A2("ai_target_clock_high");
  }
}

func_CF8C() {
  anim notify("player_battlechatter_off");
  if(isDefined(level.player) && isDefined(level.player.var_28CF)) {
    level.player.var_28CF = 0;
  }

  if(isDefined(level.player) && isDefined(level.player.var_9F6B)) {
    level.player.var_9F6B = 0;
  }
}

func_D439() {
  self endon("death");
  self endon("player_battlechatter_off");
  var_0 = 0.5;
  wait(var_0);
  if(!scripts\engine\utility::player_is_in_jackal()) {
    thread scripts\anim\battlechatter_ai::func_1A10();
  }

  wait(var_0);
  thread func_D381();
  wait(var_0);
  thread func_D37C();
  wait(var_0);
  thread scripts\anim\battlechatter_ai::func_1A07();
}

func_D37C() {
  while(isalive(level.player) && scripts\anim\battlechatter::func_29CA() && isDefined(level.player.var_28CF) && level.player.var_28CF) {
    level.player waittill("damage", var_0, var_1);
    if(!scripts\engine\utility::player_is_in_jackal()) {
      if(var_1 scripts\anim\battlechatter::func_29AB()) {
        var_2 = level.var_10AF9["allies"].var_B661;
        var_2 = scripts\engine\utility::array_randomize(var_2);
        foreach(var_4 in var_2) {
          if(isalive(var_4) && isai(var_4) && distancesquared(level.player.origin, var_4.origin) > 10000) {
            var_4 scripts\anim\battlechatter_ai::func_183F("infantry", var_1, 0.9);
            break;
          }
        }
      }
    }

    wait(1);
  }
}

func_D381() {
  while(!scripts\engine\utility::player_is_in_jackal() && isalive(level.player) && scripts\anim\battlechatter::func_29CA()) {
    wait(1);
  }

  while(isalive(level.player) && scripts\anim\battlechatter::func_29CA() && isDefined(level.player.var_28CF) && level.player.var_28CF) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      if(isDefined(level.player.var_58B7)) {
        if(isDefined(level.player.var_58B7._blackboard) && isDefined(level.player.var_58B7._blackboard.var_9DE4)) {
          if(level.player.var_58B7._blackboard.var_9DE4) {
            wait(randomfloatrange(0.25, 0.5));
            if(isDefined(level.player.var_58B7)) {
              level.player scripts\anim\battlechatter_ai::func_181C("movement", "generic", level.player.var_58B7, 0.9);
            }
          } else {
            wait(randomfloatrange(0.5, 0.75));
            if(isDefined(level.player.var_58B7)) {
              level.player scripts\anim\battlechatter_ai::func_183F("acquired", level.player.var_58B7);
            }
          }
        }
      }
    }

    wait(1);
    while(!scripts\engine\utility::player_is_in_jackal() && isalive(level.player) && scripts\anim\battlechatter::func_29CA()) {
      wait(1);
    }
  }
}

func_D45C() {
  var_0 = undefined;
  while(isalive(level.player) && scripts\anim\battlechatter::func_29CA() && isDefined(level.player.var_28CF) && level.player.var_28CF) {
    if(!scripts\engine\utility::player_is_in_jackal()) {
      var_1 = scripts\sp\utility::maymovefrompointtopoint();
      foreach(var_3 in var_1) {
        if(!isDefined(var_3)) {
          continue;
        }

        if(isDefined(var_0) && var_0 == var_3) {
          continue;
        }

        if(issubstr(var_3.classname, "dropship")) {
          if(isDefined(var_3.script_team) && var_3.script_team != level.player.team) {
            if(level.player scripts\anim\battlechatter::func_D643(var_3.origin) && distancesquared(level.player.origin, var_3.origin) < 4000000) {
              var_4 = level.var_10AF9["allies"].var_B661;
              var_4 = scripts\engine\utility::array_randomize(var_4);
              foreach(var_6 in var_4) {
                if(isalive(var_6) && isai(var_6) && distancesquared(level.player.origin, var_6.origin) < 250000) {
                  var_6 scripts\anim\battlechatter_ai::func_17D2("incoming", "dropship", undefined, 0.9, "vehicle");
                  var_0 = var_3;
                }
              }

              wait(randomintrange(15, 25));
            }
          }
        }
      }
    }

    wait(2);
    while(scripts\engine\utility::player_is_in_jackal()) {
      wait(5);
    }
  }
}

func_CF87() {
  level.player.var_29C8 = 1;
  while(isalive(level.player) && scripts\anim\battlechatter::func_29CA() && isDefined(level.player.var_28CF) && level.player.var_28CF) {
    if(level.player.var_29C8 == 0) {
      var_0 = 10;
    } else {
      var_0 = level.player.var_29C8;
    }

    level.player.var_9F6B = 1;
    for(var_1 = var_0; var_1 >= 0; var_1--) {
      level.player.var_29C8 = var_1;
      wait(1);
    }

    level.player.var_9F6B = 0;
    level waittill("player_battlechatter_refresh");
    while(level.player.var_9F6B != 0) {
      wait(0.5);
    }
  }
}

func_CF89() {
  level.player endon("death");
  level endon("player_battlechatter_off");
  var_0 = "none";
  var_1 = ["pc_ammocrate_pickup", "pc_equipcrate_pickup", "pc_weapon_scanned", "pc_armory_door", "pc_clear_last_event"];
  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_in_array_return(var_1);
    if(var_2 != var_0 && var_2 != "pc_clear_last_event") {
      level.player scripts\anim\battlechatter::func_CEE8(var_2);
      var_0 = var_2;
      thread func_CF88();
    } else if(var_2 == "pc_clear_last_event") {
      var_0 = "none";
    }

    wait(1);
  }
}

func_CF88() {
  wait(10);
  level notify("pc_clear_last_event");
}

func_CF86() {
  level.player endon("death");
  level endon("player_battlechatter_off");
  for(;;) {
    var_0 = distance(level.player.origin, self.origin);
    if(var_0 < 500) {
      if(scripts\sp\utility::func_D1DF(self.origin + (0, 0, 40))) {
        if(self.var_336 == "ammo_pickup") {
          level notify("pc_ammocrate_pickup");
        }

        if(self.var_336 == "equipment_pickup") {
          level notify("pc_equipcrate_pickup");
        }

        if(self.var_336 == "loot_hint_struct") {
          level notify("pc_armory_door");
        }

        break;
      }
    }

    wait(1);
  }
}

func_9FE0(var_0) {
  if(!isDefined(self.var_10AC8.var_9E9B[var_0]) || !isDefined(level.isteamsaying[self.team][var_0])) {
    return 1;
  }

  if(!self.var_10AC8.var_9E9B[var_0] && !level.isteamsaying[self.team][var_0]) {
    return 1;
  }

  return 0;
}