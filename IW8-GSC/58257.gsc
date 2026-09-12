/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58257.gsc
***********************************************/

function vehicle_compass_setteamfriendlyto() {
  level.vehicle_damage_cp_init = [];
  level.vehicle_damage_applytabletovehicle = getdvarint("scr_jammer_max_health", 150);
  level.vehicle_damage_beginburndown = getdvarint("scr_jammer_radius", 1750);
  level.vehicle_damage_deregisterdefaultvisuals = getdvarfloat("scr_jammer_ui_radius_multiplier", 1);
  level.vehicle_createspawnselectiontankmarker = getdvarint("scr_jammer_lifetime", 45);
  game["dialog"]["jammer_enemy_notify"] = "jammer_enemy_online";
  game["dialog"]["jammer_ally_notify"] = "jammer_friendly_online";
}

function vehicle_compass_init() {
  var_0 = 0;

  foreach(var_2 in level.vehicle_damage_cp_init) {
    foreach(var_4 in var_2) {
      var_0++;

      if(var_0 >= getdvarint("scr_jammer_max_num", 20)) {
        return false;
      }
    }
  }

  return true;
}

function vehicle_compass_instanceisregistered(var_0) {
  jumpiftrue(vehicle_compass_init()) LOC_00000033;
  self playlocalsound("br_pickup_deny");
  scripts\mp\hud_message::showerrormessage("MP_BR_INGAME_TU_WZ335/JAMMER_MAX");

  if(isDefined(self.super)) {
    jammer_refundsuper();
  }

  var_0 delete();
  return;
}

function vehicle_cp_deletenextframelate() {
  self endon("death");
  wait level.vehicle_createspawnselectiontankmarker;
  vehicle_compass_mp_shouldbevisibletoplayer();
}

function vehicle_cp_deletenextframe() {
  self endon("death");
  self.scrambleent.owner scripts\engine\utility::ref_143a7("joined_team", "joined_spectators", "disconnect", "game_ended");
  vehicle_compass_mp_shouldbevisibletoplayer();
}

function vehicle_compass_playerspawnedcallback() {}

function vehicle_cp_create() {}

function vehicle_compass_mp_init(var_0) {
  scripts\mp\damage::monitordamage(level.vehicle_damage_applytabletovehicle, "hitequip", &vehicle_compass_setplayerfriendlyto, &vehicle_compass_show, 0);
}

function vehicle_compass_show(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_4;
  var_5 = scripts\mp\damage::handlemeleedamage(var_2, var_3, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_2, var_3, var_5);
  scripts\mp\weapons::equipmenthit(self.owner, var_1, var_2, var_3);
  return var_5;
}

function vehicle_compass_setplayerfriendlyto(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
    var_2 = self.owner getentitynumber();

    if(level.vehicle_damage_cp_init[var_2].size > 1) {
      self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("ja_destroyed_m");
    } else {
      self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("ja_destroyed_s");
    }
  }

  vehicle_compass_mp_shouldbevisibletoplayer();
}

function vehicle_compass_mp_shouldbevisibletoplayer() {
  level endon("game_ended");
  self endon("death");
  self.owner notify("jammer_destroyed");

  if(isDefined(self.owner)) {
    vehicle_compass_updatevisibilityforallplayers(self.owner, self);
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);

  if(isDefined(self.scrambleent)) {
    vehicle_compass_playerjoinedteamcallback(self.scrambleent);
    self.scrambleent clearscrambler();
    self.scrambleent delete();
  }

  self setscriptablepartstate("hacked", "neutral", 0);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);
  wait 1;

  if(isDefined(self)) {
    self setscriptablepartstate("effects", "activeDestroyEnd", 0);
    earthquake(0.5, 1, self.origin, 512);
  }

  wait 1.5;
  self delete();
}

function jammer_empapplied(var_0) {
  if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0.attacker))) {
    playFXOnTag(scripts\engine\utility::getfx("emp_person_stun"), var_0.victim, "tag_origin");
    vehicle_compass_setplayerfriendlyto(var_0);
    return;
  }
}

function vehicle_createlate(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("scramble_super_finished");

  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  self.enemiesaffectedbyscambler = [];
  var_1 = 0;
  var_2 = level.vehicle_damage_beginburndown;
  var_3 = physics_createcontents(["physicscontents_player"]);

  for(;;) {
    var_4 = self.origin;
    var_5 = (var_2, var_2, 3000);
    var_6 = var_4 - var_5;
    var_7 = var_4 + var_5;
    var_8 = physics_aabbbroadphasequery(var_6, var_7, var_3, []);

    foreach(var_10 in var_8) {
      if(isPlayer(var_10)) {
        var_11 = var_10;
        var_12 = 0;
        var_13 = distance2dsquared(self.origin, var_11.origin);
        var_14 = var_2 * var_2;

        if(isDefined(var_11) && var_13 < var_14 && var_11 scripts\cp_mp\utility\player_utility::_isalive() && !var_12) {
          if(var_1 || level.teambased && var_11.team != self.team && var_11.team != "spectator" || !level.teambased && var_11 != self.owner) {
            if(var_11 scripts\cp_mp\utility\player_utility::isusingremote()) {
              continue;
            }

            if(ref_124c3(var_11, self)) {
              continue;
            }

            vehicle_compass_updatevisibilityforplayer(var_11, 1, self, var_1);
            var_11.useautorespawn = 1;
            continue;
          }

          if(ref_124c3(var_11, self)) {
            vehicle_compass_updatevisibilityforplayer(var_11, 0, self, var_1);
          }
        }
      }
    }

    foreach(var_17 in self.enemiesaffectedbyscambler) {
      if(!scripts\engine\utility::array_contains(var_8, var_17)) {
        if(ref_124c3(var_17, self)) {
          vehicle_compass_updatevisibilityforplayer(var_17, 0, self, var_1);
        }
      }
    }

    waitframe();
  }
}

function vehicle_compass_registerinstance() {
  var_2 = 0;
  var_3 = undefined;

  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(var_5 in level.supportdrones) {
      if(var_5.helperdronetype != "scrambler_drone_guard") {
        continue;
      }

      if(level.teambased) {
        if(!isDefined(var_1) && var_5.team == self.team) {
          var_3 = var_5.friendliesaffectedbyscrambler;
        } else {
          var_3 = var_5.enemiesaffectedbyscambler;
        }
      } else if(!isDefined(var_1) && var_5.owner == self) {
        var_3 = var_5.friendliesaffectedbyscrambler;
      } else {
        var_3 = var_5.enemiesaffectedbyscambler;
      }

      if(!isDefined(var_3)) {
        continue;
      }

      if(var_3.size > 0) {
        foreach(var_7 in var_3) {
          if(self == var_7 || isDefined(var_7.owner) && self == var_7.owner) {
            var_2 = 1;
            break;
          }
        }

        if(istrue(var_2)) {
          break;
        }
      }
    }

    var_1 = undefined;
    var_3 = undefined;
  }

  return < error > ;
}

function vehicle_compass_updatevisibilityforplayer(var_0, var_1, var_2) {
  var_3 = self;

  if(istrue(var_0)) {
    if(!scripts\engine\utility::array_contains(var_1.enemiesaffectedbyscambler, var_3)) {
      var_1.enemiesaffectedbyscambler[var_1.enemiesaffectedbyscambler.size] = var_3;
    }

    if(!isDefined(var_3.scrambledby)) {
      var_3.scrambledby = [var_1];
      thread vehicle_create();
    } else {
      var_3.scrambledby[var_3.scrambledby.size] = var_1;
    }

    thread vehicle_compass_shouldbevisibletoplayer(var_3, var_1);
    return;
  }

  if(isDefined(var_3)) {
    if(scripts\engine\utility::array_contains(var_1.enemiesaffectedbyscambler, var_3)) {
      var_1.enemiesaffectedbyscambler = scripts\engine\utility::array_remove(var_1.enemiesaffectedbyscambler, var_3);
    } else {
      var_1.enemiesaffectedbyscambler = scripts\engine\utility::array_removeundefined(var_1.enemiesaffectedbyscambler);
    }

    var_3.scrambledby = scripts\engine\utility::array_remove(var_3.scrambledby, var_1);

    if(var_3.scrambledby.size == 0) {
      var_3.scrambledby = undefined;
      stop_jammer_scramble(var_3, var_3.currentscramblerstrength);
      var_3.previousscramblerstrength = undefined;
      var_3.currentscramblerstrength = undefined;
      var_3.useautorespawn = 0;
      var_3 notify("scrambler_off");
      return;
    }

    return;
  }
}

function vehicle_compass_shouldbevisibletoplayer(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::ref_143a5("death", "scramble_off");

  if(ref_124c3(var_0)) {
    if(isDefined(self)) {
      if(isDefined(var_0) && isDefined(var_0.enemiesaffectedbyscambler)) {
        var_0.enemiesaffectedbyscambler = scripts\engine\utility::array_remove(var_0.enemiesaffectedbyscambler, self);
      }
    }

    vehicle_compass_updatevisibilityforplayer(0, var_0, var_1);
    return;
  }
}

function ref_124c3(var_0) {
  return isDefined(self.scrambledby) && scripts\engine\utility::array_contains(self.scrambledby, var_0);
}

function vehicle_create(var_0) {
  self endon("death");
  self endon("scramble_off");
  self endon("disconnect");
  var_1 = 0;
  var_2 = 0;
  var_3 = level.vehicle_damage_beginburndown;
  var_4 = var_3 * var_3;

  for(;;) {
    if(!isDefined(self.scrambledby)) {
      return;
    }

    foreach(var_6 in self.scrambledby) {
      var_7 = distance2dsquared(var_6.origin, self.origin);
      level.loot_setitemcount = var_7;
      var_8 = 0;
      var_2 = 0;

      if(var_7 > var_4) {
        var_8 = 0;
      } else if(var_7 >= var_4 * 0.8) {
        var_8 = 1;
      } else if(var_7 >= var_4 * 0.6) {
        var_8 = 2;
      } else if(var_7 >= var_4 * 0.4) {
        var_8 = 3;
      } else if(var_7 >= var_4 * 0.2) {
        var_8 = 4;
      } else {
        var_8 = 5;
      }

      if(var_8 > var_2) {
        var_2 = var_8;
      }
    }

    if(var_1 == 0 || var_2 != var_1) {
      self.previousscramblerstrength = var_1;
      self.currentscramblerstrength = var_2;

      if(self.previousscramblerstrength > 1) {
        var_10 = self.previousscramblerstrength;
      }

      if(self.currentscramblerstrength > 1) {
        var_10 = self.currentscramblerstrength;
      }

      stop_jammer_scramble(var_1);
      play_jammer_scramble(var_2);
      var_1 = var_2;
    }

    wait 1;
  }
}

function vehicle_compass_playerjoinedteamcallback() {
  self notify("scramble_super_finished");

  if(isDefined(self.enemiesaffectedbyscambler) && self.enemiesaffectedbyscambler.size > 0) {
    foreach(var_1 in self.enemiesaffectedbyscambler) {
      if(isDefined(var_1)) {
        var_2 = var_1;

        if(isDefined(var_2.owner)) {
          var_2 = var_2.owner;
        }

        if(ref_124c3(var_2, self)) {
          vehicle_compass_updatevisibilityforplayer(var_2, 0, self);
        }
      }
    }

    return;
  }
}

function vehicle_compass_updatevisibilityforallplayers(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  var_3 = [];

  for(var_4 = 0; var_4 < level.vehicle_damage_cp_init[var_2].size; var_4++) {
    var_5 = level.vehicle_damage_cp_init[var_2][var_4];

    if(var_5 != var_1) {
      var_3 = var_5;
    }
  }

  level.vehicle_damage_cp_init[var_2] = var_3;
}

function vehicle_compass_infect_shouldbevisibletoplayer(var_0, var_1) {
  var_2 = var_0 getentitynumber();

  if(!isDefined(level.vehicle_damage_cp_init[var_2])) {
    level.vehicle_damage_cp_init[var_2] = [];
  }

  var_3 = level.vehicle_damage_cp_init[var_2].size;

  if(var_3 + 1 > 1) {
    vehicle_compass_mp_shouldbevisibletoplayer(level.vehicle_damage_cp_init[var_2][0]);
    var_3--;
  }

  level.vehicle_damage_cp_init[var_2][var_3] = var_1;
}

function vehicle_compass_updateallvisibilityforplayer(var_0) {
  vehicle_compass_updatevisibilityforallplayers(var_0, self);
  vehicle_compass_infect_shouldbevisibletoplayer(self.owner, self);
  self.scrambleent.team = self.owner.team;
  self.scrambleent makescrambler(self.owner);
  self setscriptablepartstate("hacked", "active", 0);
}

function play_jammer_scramble(var_0) {
  if(var_0 == 0) {
    return;
  }

  if(!isDefined(self.jammerscramblelevels)) {
    self.jammerscramblelevels = [];
  }

  var_1 = self.jammerscramblelevels[var_0];

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self.jammerscramblelevels[var_0] = var_1 + 1;
  _update_jammer_scramble();
}

function stop_jammer_scramble(var_0) {
  if(var_0 == 0) {
    return;
  }

  if(isDefined(self.jammerscramblelevels[var_0])) {
    self.jammerscramblelevels[var_0] -= 1;

    if(self.jammerscramblelevels[var_0] == 0) {
      self.jammerscramblelevels[var_0] = undefined;
    }
  }

  _update_jammer_scramble();
}

function _update_jammer_scramble() {
  var_0 = 0;

  foreach(var_2 in self.jammerscramblelevels) {
    if(var_3 > var_0) {
      var_0 = var_3;
    }
  }

  self setclientomnvar("ui_jammer_strength", var_0);
}

function jammer_refundsuper() {
  self setweaponammoclip(self.super.staticdata.weapon, 1);
  self notify("super_use_finished_lb");
  self notify("super_use_finished");
  scripts\cp\vehicles\vehicle_compass_cp::ref_12097(self.super, 1);
  var_0 = scripts\mp\supers::getcurrentsuper();
  scripts\mp\supers::ref_131c7(0);
  scripts\mp\supers::ref_131c6(0);
  var_0.wasrefunded = 1;
  scripts\mp\supers::setsuperbasepoints(scripts\mp\supers::getsuperpointsneeded());
}