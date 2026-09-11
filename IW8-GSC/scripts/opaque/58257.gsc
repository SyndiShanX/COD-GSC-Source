/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58257.gsc
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
  var0 = 0;

  foreach(var2 in level.vehicle_damage_cp_init) {
    foreach(var4 in var2) {
      var0++;

      if(var0 >= getdvarint("scr_jammer_max_num", 20)) {
        return false;
      }
    }
  }

  return true;
}

function vehicle_compass_instanceisregistered(var0) {
  jumpiftrue(vehicle_compass_init()) LOC_00000033;
  self playlocalsound("br_pickup_deny");
  scripts\mp\hud_message::showerrormessage("MP_BR_INGAME_TU_WZ335/JAMMER_MAX");

  if(isDefined(self.super)) {
    jammer_refundsuper();
  }

  var0 delete();
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

function vehicle_compass_mp_init(var0) {
  scripts\mp\damage::monitordamage(level.vehicle_damage_applytabletovehicle, "hitequip", &vehicle_compass_setplayerfriendlyto, &vehicle_compass_show, 0);
}

function vehicle_compass_show(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var4;
  var5 = scripts\mp\damage::handlemeleedamage(var2, var3, var5);
  var5 = scripts\mp\damage::handleapdamage(var2, var3, var5);
  scripts\mp\weapons::equipmenthit(self.owner, var1, var2, var3);
  return var5;
}

function vehicle_compass_setplayerfriendlyto(var0) {
  var1 = var0.attacker;

  if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1))) {
    var1 scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    var1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
    var2 = self.owner getentitynumber();

    if(level.vehicle_damage_cp_init[var2].size > 1) {
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

function jammer_empapplied(var0) {
  if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0.attacker))) {
    playFXOnTag(scripts\engine\utility::getfx("emp_person_stun"), var0.victim, "tag_origin");
    vehicle_compass_setplayerfriendlyto(var0);
    return;
  }
}

function vehicle_createlate(var0) {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("scramble_super_finished");

  if(!isDefined(var0)) {
    var0 = self.owner;
  }

  self.enemiesaffectedbyscambler = [];
  var1 = 0;
  var2 = level.vehicle_damage_beginburndown;
  var3 = physics_createcontents(["physicscontents_player"]);

  for(;;) {
    var4 = self.origin;
    var5 = (var2, var2, 3000);
    var6 = var4 - var5;
    var7 = var4 + var5;
    var8 = physics_aabbbroadphasequery(var6, var7, var3, []);

    foreach(var10 in var8) {
      if(isPlayer(var10)) {
        var11 = var10;
        var12 = 0;
        var13 = distance2dsquared(self.origin, var11.origin);
        var14 = var2 * var2;

        if(isDefined(var11) && var13 < var14 && var11 scripts\cp_mp\utility\player_utility::_isalive() && !var12) {
          if(var1 || level.teambased && var11.team != self.team && var11.team != "spectator" || !level.teambased && var11 != self.owner) {
            if(var11 scripts\cp_mp\utility\player_utility::isusingremote()) {
              continue;
            }

            if(ref_124c3(var11, self)) {
              continue;
            }

            vehicle_compass_updatevisibilityforplayer(var11, 1, self, var1);
            var11.useautorespawn = 1;
            continue;
          }

          if(ref_124c3(var11, self)) {
            vehicle_compass_updatevisibilityforplayer(var11, 0, self, var1);
          }
        }
      }
    }

    foreach(var17 in self.enemiesaffectedbyscambler) {
      if(!scripts\engine\utility::array_contains(var8, var17)) {
        if(ref_124c3(var17, self)) {
          vehicle_compass_updatevisibilityforplayer(var17, 0, self, var1);
        }
      }
    }

    waitframe();
  }
}

function vehicle_compass_registerinstance() {
  var2 = 0;
  var3 = undefined;

  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(var5 in level.supportdrones) {
      if(var5.helperdronetype != "scrambler_drone_guard") {
        continue;
      }

      if(level.teambased) {
        if(!isDefined(var1) && var5.team == self.team) {
          var3 = var5.friendliesaffectedbyscrambler;
        } else {
          var3 = var5.enemiesaffectedbyscambler;
        }
      } else if(!isDefined(var1) && var5.owner == self) {
        var3 = var5.friendliesaffectedbyscrambler;
      } else {
        var3 = var5.enemiesaffectedbyscambler;
      }

      if(!isDefined(var3)) {
        continue;
      }

      if(var3.size > 0) {
        foreach(var7 in var3) {
          if(self == var7 || isDefined(var7.owner) && self == var7.owner) {
            var2 = 1;
            break;
          }
        }

        if(istrue(var2)) {
          break;
        }
      }
    }

    var1 = undefined;
    var3 = undefined;
  }

  return < error > ;
}

function vehicle_compass_updatevisibilityforplayer(var0, var1, var2) {
  var3 = self;

  if(istrue(var0)) {
    if(!scripts\engine\utility::array_contains(var1.enemiesaffectedbyscambler, var3)) {
      var1.enemiesaffectedbyscambler[var1.enemiesaffectedbyscambler.size] = var3;
    }

    if(!isDefined(var3.scrambledby)) {
      var3.scrambledby = [var1];
      thread vehicle_create();
    } else {
      var3.scrambledby[var3.scrambledby.size] = var1;
    }

    thread vehicle_compass_shouldbevisibletoplayer(var3, var1);
    return;
  }

  if(isDefined(var3)) {
    if(scripts\engine\utility::array_contains(var1.enemiesaffectedbyscambler, var3)) {
      var1.enemiesaffectedbyscambler = scripts\engine\utility::array_remove(var1.enemiesaffectedbyscambler, var3);
    } else {
      var1.enemiesaffectedbyscambler = scripts\engine\utility::array_removeundefined(var1.enemiesaffectedbyscambler);
    }

    var3.scrambledby = scripts\engine\utility::array_remove(var3.scrambledby, var1);

    if(var3.scrambledby.size == 0) {
      var3.scrambledby = undefined;
      stop_jammer_scramble(var3, var3.currentscramblerstrength);
      var3.previousscramblerstrength = undefined;
      var3.currentscramblerstrength = undefined;
      var3.useautorespawn = 0;
      var3 notify("scrambler_off");
      return;
    }

    return;
  }
}

function vehicle_compass_shouldbevisibletoplayer(var0, var1) {
  level endon("game_ended");
  scripts\engine\utility::ref_143a5("death", "scramble_off");

  if(ref_124c3(var0)) {
    if(isDefined(self)) {
      if(isDefined(var0) && isDefined(var0.enemiesaffectedbyscambler)) {
        var0.enemiesaffectedbyscambler = scripts\engine\utility::array_remove(var0.enemiesaffectedbyscambler, self);
      }
    }

    vehicle_compass_updatevisibilityforplayer(0, var0, var1);
    return;
  }
}

function ref_124c3(var0) {
  return isDefined(self.scrambledby) && scripts\engine\utility::array_contains(self.scrambledby, var0);
}

function vehicle_create(var0) {
  self endon("death");
  self endon("scramble_off");
  self endon("disconnect");
  var1 = 0;
  var2 = 0;
  var3 = level.vehicle_damage_beginburndown;
  var4 = var3 * var3;

  for(;;) {
    if(!isDefined(self.scrambledby)) {
      return;
    }

    foreach(var6 in self.scrambledby) {
      var7 = distance2dsquared(var6.origin, self.origin);
      level.loot_setitemcount = var7;
      var8 = 0;
      var2 = 0;

      if(var7 > var4) {
        var8 = 0;
      } else if(var7 >= var4 * 0.8) {
        var8 = 1;
      } else if(var7 >= var4 * 0.6) {
        var8 = 2;
      } else if(var7 >= var4 * 0.4) {
        var8 = 3;
      } else if(var7 >= var4 * 0.2) {
        var8 = 4;
      } else {
        var8 = 5;
      }

      if(var8 > var2) {
        var2 = var8;
      }
    }

    if(var1 == 0 || var2 != var1) {
      self.previousscramblerstrength = var1;
      self.currentscramblerstrength = var2;

      if(self.previousscramblerstrength > 1) {
        var10 = self.previousscramblerstrength;
      }

      if(self.currentscramblerstrength > 1) {
        var10 = self.currentscramblerstrength;
      }

      stop_jammer_scramble(var1);
      play_jammer_scramble(var2);
      var1 = var2;
    }

    wait 1;
  }
}

function vehicle_compass_playerjoinedteamcallback() {
  self notify("scramble_super_finished");

  if(isDefined(self.enemiesaffectedbyscambler) && self.enemiesaffectedbyscambler.size > 0) {
    foreach(var1 in self.enemiesaffectedbyscambler) {
      if(isDefined(var1)) {
        var2 = var1;

        if(isDefined(var2.owner)) {
          var2 = var2.owner;
        }

        if(ref_124c3(var2, self)) {
          vehicle_compass_updatevisibilityforplayer(var2, 0, self);
        }
      }
    }

    return;
  }
}

function vehicle_compass_updatevisibilityforallplayers(var0, var1) {
  var2 = var0 getentitynumber();
  var3 = [];

  for(var4 = 0; var4 < level.vehicle_damage_cp_init[var2].size; var4++) {
    var5 = level.vehicle_damage_cp_init[var2][var4];

    if(var5 != var1) {
      var3 = var5;
    }
  }

  level.vehicle_damage_cp_init[var2] = var3;
}

function vehicle_compass_infect_shouldbevisibletoplayer(var0, var1) {
  var2 = var0 getentitynumber();

  if(!isDefined(level.vehicle_damage_cp_init[var2])) {
    level.vehicle_damage_cp_init[var2] = [];
  }

  var3 = level.vehicle_damage_cp_init[var2].size;

  if(var3 + 1 > 1) {
    vehicle_compass_mp_shouldbevisibletoplayer(level.vehicle_damage_cp_init[var2][0]);
    var3--;
  }

  level.vehicle_damage_cp_init[var2][var3] = var1;
}

function vehicle_compass_updateallvisibilityforplayer(var0) {
  vehicle_compass_updatevisibilityforallplayers(var0, self);
  vehicle_compass_infect_shouldbevisibletoplayer(self.owner, self);
  self.scrambleent.team = self.owner.team;
  self.scrambleent makescrambler(self.owner);
  self setscriptablepartstate("hacked", "active", 0);
}

function play_jammer_scramble(var0) {
  if(var0 == 0) {
    return;
  }

  if(!isDefined(self.—$ Š #ˆ½ Ö› Ê #!¡«5‘ = ³èB)) {
    self.—$ Š #ˆ½ Ö› Ê #!¡«5‘ = ³èB = [];
  }

  var1 = self.—$ Š #ˆ½ Ö› Ê #!¡«5‘ = ³èB[var0];

  if(!isDefined(var1)) {
    var1 = 0;
  }

  self.—$ Š #ˆ½ Ö› Ê #!¡«5‘ = ³èB[var0] = var1 + 1;
  _update_jammer_scramble();
}

function stop_jammer_scramble(var0) {
  if(var0 == 0) {
    return;
  }

  if(isDefined(self.—$ Š #ˆ½ Ö› Ê #!¡«5‘ = ³èB[var0])) {
    self.—$ Š #ˆ½ Ö› Ê #!¡«5‘ = ³èB[var0] -= 1;

    if(self.—$ Š #ˆ½ Ö› Ê #!¡«5‘ = ³èB[var0] == 0) {
      self.—$ Š #ˆ½ Ö› Ê #!¡«5‘ = ³èB[var0] = undefined;
    }
  }

  _update_jammer_scramble();
}

function _update_jammer_scramble() {
  var0 = 0;

  foreach(var2 in self.—$ Š #ˆ½ Ö› Ê #!¡«5‘ = ³èB) {
    if(var3 > var0) {
      var0 = var3;
    }
  }

  self setclientomnvar("ui_jammer_strength", var0);
}

function jammer_refundsuper() {
  self setweaponammoclip(self.super.staticdata.weapon, 1);
  self notify("super_use_finished_lb");
  self notify("super_use_finished");
  scripts\cp\vehicles\vehicle_compass_cp::ref_12097(self.super, 1);
  var0 = scripts\mp\supers::getcurrentsuper();
  scripts\mp\supers::ref_131c7(0);
  scripts\mp\supers::ref_131c6(0);
  var0.wasrefunded = 1;
  scripts\mp\supers::setsuperbasepoints(scripts\mp\supers::getsuperpointsneeded());
}