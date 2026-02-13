/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1873.gsc
*************************************************/

_id_8069() {
  if(isDefined(anim.player._id_2359)) {
    return;
  }
  anim.player._id_2359 = spawnStruct();
  anim.player._id_2359._id_3420 = [];
  anim.player._id_2359._id_3420["threat"] = spawnStruct();
  anim.player._id_2359._id_3420["threat"]._id_57AC = 0;
  anim.player._id_2359._id_3420["threat"]._id_BD27 = 0.0;
  anim.player._id_2359._id_3420["response"] = spawnStruct();
  anim.player._id_2359._id_3420["response"]._id_57AC = 0;
  anim.player._id_2359._id_3420["response"]._id_BD27 = 0.0;
  anim.player._id_2359._id_3420["reaction"] = spawnStruct();
  anim.player._id_2359._id_3420["reaction"]._id_57AC = 0;
  anim.player._id_2359._id_3420["reaction"]._id_BD27 = 0.0;
  anim.player._id_2359._id_3420["inform"] = spawnStruct();
  anim.player._id_2359._id_3420["inform"]._id_57AC = 0;
  anim.player._id_2359._id_3420["inform"]._id_BD27 = 0.0;
  anim.player._id_2359._id_3420["order"] = spawnStruct();
  anim.player._id_2359._id_3420["order"]._id_57AC = 0;
  anim.player._id_2359._id_3420["order"]._id_BD27 = 0.0;
  anim.player._id_2359._id_3420["custom"] = spawnStruct();
  anim.player._id_2359._id_3420["custom"]._id_57AC = 0;
  anim.player._id_2359._id_3420["custom"]._id_BD27 = 0.0;
  anim.player._id_2359._id_3420["stealth"] = spawnStruct();
  anim.player._id_2359._id_3420["stealth"]._id_57AC = 0;
  anim.player._id_2359._id_3420["stealth"]._id_BD27 = 0.0;
  anim.player._id_2359._id_A4D0 = gettime() + 50;
  anim.player._id_2359._id_A4D1["threat"] = 0;
  anim.player._id_2359._id_A4D1["reaction"] = 0;
  anim.player._id_2359._id_A4D1["response"] = 0;
  anim.player._id_2359._id_A4D1["inform"] = 0;
  anim.player._id_2359._id_A4D1["order"] = 0;
  anim.player._id_2359._id_A4D1["custom"] = 0;
  anim.player._id_2359._id_A4D1["stealth"] = 0;
  anim.player._id_2359._id_8A4B = 0;
  anim.player._id_2359._id_9F35 = 0.0;
  anim.player._id_2359._id_3DA9 = "UN";
}

_id_B3BD() {
  while(!isDefined(anim._id_341F)) {
    wait 0.5;
  }

  if(!isDefined(anim.player._id_237D) || isDefined(anim.player._id_237D) && !anim.player._id_237D) {
    anim.player._id_237D = 1;
    anim.player._id_2359._id_8A4B = 0;
    thread _id_B3B7();
    anim.player thread _id_B7F9();
  }
}

_id_B618() {
  if(!isDefined(anim.player._id_15AC)) {
    anim.player._id_15AC = [];
    anim.player _id_070B::_id_108B("rpg");
    anim.player _id_070B::_id_108B("exposed");
    anim.player _id_070B::_id_108B("acquired");
    anim.player _id_070B::_id_108B("sighted");
    anim.player _id_070B::_id_108B("ai_contact_clock");
    anim.player _id_070B::_id_108B("ai_target_clock");
    anim.player _id_070B::_id_108B("ai_cardinal");
    anim.player _id_070B::_id_108B("player_contact_clock");
    anim.player _id_070B::_id_108B("player_target_clock");
    anim.player _id_070B::_id_108B("player_cardinal");
    anim.player _id_070B::_id_108B("ai_obvious");
    anim.player _id_070B::_id_108B("player_object_clock");
    anim.player _id_070B::_id_108B("player_location");
    anim.player _id_070B::_id_108B("ai_location");
    anim.player _id_070B::_id_108B("generic_location");
    anim.player _id_070B::_id_108B("ai_casual_clock");
    anim.player _id_070B::_id_108B("concat_location");
    anim.player _id_070B::_id_108B("concat_location");
    anim.player _id_070B::_id_108B("player_distance");
    anim.player _id_070B::_id_108B("player_target_clock_high");
    anim.player _id_070B::_id_108B("ai_distance");
    anim.player _id_070B::_id_108B("ai_target_clock_high");
  }
}

_id_B3BB() {
  anim notify("player_battlechatter_off");

  if(isDefined(anim.player) && isDefined(anim.player._id_237D)) {
    anim.player._id_237D = 0;
  }

  if(isDefined(anim.player) && isDefined(anim.player._id_2359._id_8A4B)) {
    anim.player._id_2359._id_8A4B = 0;
  }
}

_id_B7F9() {
  self endon("death");
  self endon("player_battlechatter_off");
  var_0 = 0.5;
  wait(var_0);
  thread _id_070B::_id_1318();
  wait(var_0);
  thread _id_B698();
  wait(var_0);
  thread _id_B68A();
  wait(var_0);
  thread _id_070B::_id_130B();
}

_id_B68A() {
  while(isalive(anim.player) && _id_070A::_id_2458() && (isDefined(anim.player._id_237D) && anim.player._id_237D)) {
    anim.player waittill("damage", var_0, var_1);

    if(var_1 _id_070A::_id_2436()) {
      var_2 = anim._id_E4A8["allies"]._id_9DB5;
      var_2 = scripts\engine\utility::array_randomize(var_2);

      foreach(var_4 in var_2) {
        if(isalive(var_4) && isai(var_4) && distancesquared(anim.player.origin, var_4.origin) > 10000) {
          var_4 _id_070B::_id_1151("infantry", var_1, 0.9);
          break;
        }
      }
    }

    wait 1.0;
  }
}

_id_B698() {
  while(!scripts\engine\utility::_id_B511() && isalive(anim.player) && _id_070A::_id_2458()) {
    wait 1.0;
  }

  while(isalive(anim.player) && _id_070A::_id_2458() && (isDefined(anim.player._id_237D) && anim.player._id_237D)) {
    if(scripts\engine\utility::_id_B511()) {
      if(isDefined(level.player._id_4CC8)) {
        if(isDefined(level.player._id_4CC8._id_0B67) && isDefined(level.player._id_4CC8._id_0B67._id_883D)) {
          if(level.player._id_4CC8._id_0B67._id_883D) {
            wait(randomfloatrange(0.25, 0.5));

            if(isDefined(level.player._id_4CC8)) {
              anim.player _id_070B::_id_111E("movement", "generic", level.player._id_4CC8, 0.9);
            }
          } else {
            wait(randomfloatrange(0.5, 0.75));

            if(isDefined(level.player._id_4CC8)) {
              anim.player _id_070B::_id_1151("acquired", level.player._id_4CC8);
            }
          }
        }
      }
    }

    wait 1.0;

    while(!scripts\engine\utility::_id_B511() && isalive(anim.player) && _id_070A::_id_2458()) {
      wait 1.0;
    }
  }
}

_id_B811() {
  var_0 = undefined;

  while(isalive(anim.player) && _id_070A::_id_2458() && (isDefined(anim.player._id_237D) && anim.player._id_237D)) {
    if(!scripts\engine\utility::_id_B511()) {
      var_1 = scripts\cp\utility::_id_6E3A();

      foreach(var_3 in var_1) {
        if(!isDefined(var_3)) {
          continue;
        }
        if(isDefined(var_0) && var_0 == var_3) {
          continue;
        }
        if(issubstr(var_3.classname, "dropship")) {
          if(isDefined(var_3._id_CE7D) && var_3._id_CE7D != anim.player.team) {
            if(anim.player _id_070A::_id_B9B9(var_3.origin) && distancesquared(anim.player.origin, var_3.origin) < 4000000) {
              var_4 = anim._id_E4A8["allies"]._id_9DB5;
              var_4 = scripts\engine\utility::array_randomize(var_4);

              foreach(var_6 in var_4) {
                if(isalive(var_6) && isai(var_6) && distancesquared(anim.player.origin, var_6.origin) < 250000) {
                  var_6 _id_070B::_id_10C2("incoming", "dropship", 0.9, "vehicle");
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

    while(scripts\engine\utility::_id_B511()) {
      wait 5.0;
    }
  }
}

_id_B3B7() {
  anim.player._id_2456 = 1;

  while(isalive(anim.player) && _id_070A::_id_2458() && (isDefined(anim.player._id_237D) && anim.player._id_237D)) {
    if(anim.player._id_2456 == 0) {
      var_0 = 10;
    } else {
      var_0 = anim.player._id_2456;
    }

    anim.player._id_2359._id_8A4B = 1;

    for(var_1 = var_0; var_1 >= 0; var_1--) {
      anim.player._id_2456 = var_1;
      wait 1.0;
    }

    anim.player._id_2359._id_8A4B = 0;
    level waittill("player_battlechatter_refresh");

    while(anim.player._id_2359._id_8A4B != 0) {
      wait 0.5;
    }
  }
}

_id_B3B9() {
  anim.player endon("death");
  level endon("player_battlechatter_off");
  var_0 = "none";
  var_1 = ["pc_ammocrate_pickup", "pc_equipcrate_pickup", "pc_weapon_scanned", "pc_armory_door", "pc_clear_last_event"];

  for(;;) {
    var_2 = scripts\engine\utility::_id_10892(var_1);

    if(var_2 != var_0 && var_2 != "pc_clear_last_event") {
      anim.player _id_070A::_id_B367(var_2);
      var_0 = var_2;
      thread _id_B3B8();
    } else if(var_2 == "pc_clear_last_event")
      var_0 = "none";

    wait 1;
  }
}

_id_B3B8() {
  wait 10;
  level notify("pc_clear_last_event");
}

_id_B3B6() {
  anim.player endon("death");
  level endon("player_battlechatter_off");

  for(;;) {
    var_0 = distance(anim.player.origin, self.origin);

    if(var_0 < 500) {
      if(scripts\cp\utility::_id_B542(self.origin + (0, 0, 40))) {
        if(self._id_0481 == "ammo_pickup") {
          level notify("pc_ammocrate_pickup");
        }

        if(self._id_0481 == "equipment_pickup") {
          level notify("pc_equipcrate_pickup");
        }

        if(self._id_0481 == "loot_hint_struct") {
          level notify("pc_armory_door");
        }

        break;
      }
    }

    wait 1.0;
  }
}

_id_8AE9(var_0) {
  if(!isDefined(self._id_E478._id_892D[var_0]) || !isDefined(anim._id_8A96[self.team][var_0])) {
    return 1;
  }

  if(!self._id_E478._id_892D[var_0] && !anim._id_8A96[self.team][var_0]) {
    return 1;
  }

  return 0;
}