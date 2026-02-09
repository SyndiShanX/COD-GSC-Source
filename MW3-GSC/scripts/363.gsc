/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\363.gsc
**************************************/

_id_2874() {
  precacheitem("turret_attackheli");
  precacheitem("missile_attackheli");
  _id_2875();
  thread init();
}

_id_2875() {
  if(getdvarint("sm_enable") && getDvar("r_zfeather") != "0") {
    level._effect["_attack_heli_spotlight"] = loadfx("misc/hunted_spotlight_model");
  } else {
    level._effect["_attack_heli_spotlight"] = loadfx("misc/spotlight_large");
  }
}

init() {
  if(isDefined(level._id_2876)) {
    return;
  }
  while(!isDefined(level.gameskill)) {
    wait 0.05;
  }
  if(!isDefined(level.cosine)) {
    level.cosine = [];
  }
  if(!isDefined(level.cosine["25"])) {
    level.cosine["25"] = cos(25);
  }
  if(!isDefined(level.cosine["35"])) {
    level.cosine["35"] = cos(35);
  }
  if(!isDefined(level._id_2878)) {
    level._id_2878 = 3500;
  }
  if(!isDefined(level._id_2879)) {
    level._id_2879 = 0;
  }
  if(!isDefined(level._id_287A)) {
    level._id_287A = cos(30);
  }
  level._id_2876 = 1;
  level._id_287B = 3;
  level._id_287C = 6;
  level._id_287D = 3;

  switch (level.gameskill) {
    case 0:
      level._id_287E = 9;
      level._id_287F = 1;
      break;
    case 1:
      level._id_287E = 7;
      level._id_287F = 2;
      break;
    case 2:
      level._id_287E = 5;
      level._id_287F = 3;
      break;
    case 3:
      level._id_287E = 3;
      level._id_287F = 5;
      break;
  }
}

_id_2880(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "kill_heli";
  }
  var_1 = maps\_vehicle::_id_2881(var_0);
  var_1 = _id_2882(var_1);
  return var_1;
}

_id_2882(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("heli_players_dead");

  if(level.gameskill == 0 || level.gameskill == 1) {
    var_2 = spawn("script_origin", var_0.origin + (0, 0, -20));
    var_2 linkto(var_0);
    var_0 thread common_scripts\utility::delete_on_death(var_2);
    var_3 = undefined;

    if(level.gameskill == 0) {
      var_3 = 2800;
    } else {
      var_3 = 2200;
    }
    if(!isDefined(var_0._id_2883)) {
      var_0.attractor = missile_createattractorent(var_2, var_3, 10000, level.player);

      if(maps\_utility::_id_12C1()) {
        var_0._id_2885 = missile_createattractorent(var_2, var_3, 10000, level._id_1337);
      }
    }
  }

  var_0 enableaimassist();
  var_0._id_2886 = spawn("script_origin", var_0.origin);
  var_0 thread common_scripts\utility::delete_on_death(var_0._id_2886);

  if(!isDefined(var_0._id_2887)) {
    var_0._id_2887 = 0;
  }
  var_0._id_2888 = 1;
  var_0._id_2889 = 0;
  var_0._id_288A = 1;
  var_0._id_288B = 0;
  var_0._id_288C = undefined;
  var_0 thread _id_28B5();
  var_0 thread _id_28B6();
  thread _id_289B(var_0, var_1);
  var_0.turrettype = undefined;
  var_0 _id_2893();
  var_0 thread _id_2892();

  switch (var_0.vehicletype) {
    case "ny_harbor_hind":
    case "hind":
      var_0.turrettype = "default";
      break;
    case "mi28":
      var_0.turrettype = "default";
      break;
    case "littlebird":
      var_0 setyawspeed(90, 30, 20);
      var_0 setmaxpitchroll(40, 40);
      var_0 sethoverparams(100, 20, 5);
      var_0 _id_2896();
      break;
    default:
      break;
  }

  var_0._id_288F = var_0._id_288E;

  if(isDefined(var_0._id_2890) && var_0._id_2890 == 1 && !isDefined(var_0._id_2891)) {
    var_0 thread _id_28DE(undefined, 1);
  }
  var_0 thread _id_28D9();
  return var_0;
}

_id_2892() {
  foreach(var_1 in level.players) {}
  var_1 maps\_utility::_id_09C9(maps\_utility::_id_09CA, "death");

  maps\_utility::_id_09CB();
  self notify("heli_players_dead");
}

_id_2893() {
  var_0 = undefined;
  var_1 = undefined;

  switch (self.vehicletype) {
    case "ny_harbor_hind":
    case "hind":
      var_1 = 600;
      var_0 = -100;
      break;
    case "mi28":
      var_1 = 600;
      var_0 = -100;
      break;
    case "littlebird":
      var_1 = 600;
      var_0 = -204;
      break;
    default:
      break;
  }

  self._id_288E = spawn("script_origin", self.origin);
  self._id_288E.angles = self.angles;
  self._id_288E.origin = self.origin;
  var_2 = spawnStruct();
  var_2.entity = self._id_288E;
  var_2.forward = var_1;
  var_2.up = var_0;
  var_2 maps\_utility::_id_18B9();
  self._id_288E linkto(self);
  self._id_288E thread _id_2899(self);
}

_id_2894() {
  if(isDefined(self.turrets)) {
    return self.turrets;
  }
  _id_2896();
  return self.turrets;
}

_id_2896() {
  self.turrettype = "miniguns";
  self._id_2897 = 0;
  self._id_2898 = 0;

  if(!isDefined(self.mgturret)) {
    return;
  }
  self.turrets = self.mgturret;
  common_scripts\utility::array_thread(self.turrets, ::_id_28D7, self);
}

_id_2899(var_0) {
  var_0 common_scripts\utility::waittill_either("death", "crash_done");

  if(isDefined(self)) {
    self delete();
  }
}

_id_289A(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "kill_heli";
  }
  var_2 = maps\_vehicle::_id_2881(var_0);
  var_2._id_2886 = spawn("script_origin", var_2.origin);
  var_2 thread common_scripts\utility::delete_on_death(var_2._id_2886);
  var_2._id_2887 = 1;
  var_2._id_2888 = 1;
  var_2._id_2889 = 0;
  var_2 thread _id_28B5();
  var_2 thread _id_28B6();
  thread _id_289B(var_2, var_1);
  return var_2;
}

_id_289B(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = maps\_vehicle::_id_2881("kill_heli");
    var_0._id_2888 = 1;
    var_0._id_2889 = 0;
    var_0 thread _id_28B5();
    var_0 thread _id_28B6();
  }

  var_2 = undefined;

  if(!isDefined(var_0.script_airspeed)) {
    var_2 = 40;
  } else {
    var_2 = var_0.script_airspeed;
  }
  if(!isDefined(level._id_289D)) {
    level._id_289D = 0;
  }
  if(!isDefined(level._id_289E)) {
    level._id_289E = 0;
  }
  if(!isDefined(level._id_289F)) {
    level._id_289F = 0;
  }
  level._id_28A0 = undefined;
  var_3 = getEntArray("attack_heli_safe_volume", "script_noteworthy");

  if(var_3.size > 0) {
    level._id_28A0 = var_3;
  }
  if(!level._id_289D) {
    thread _id_28CC(var_0);
  }
  if(!isDefined(var_0._id_28A1)) {
    switch (var_0.vehicletype) {
      case "mi28":
        target_set(var_0, (0, 0, -80));
        break;
      case "ny_harbor_hind":
      case "hind":
        target_set(var_0, (0, 0, -96));
        break;
      case "littlebird":
        target_set(var_0, (0, 0, -80));
        break;
      default:
        break;
    }

    target_setjavelinonly(var_0, 1);
  }

  var_0 thread heli_damage_monitor();
  var_0 thread _id_28CB();
  var_0 endon("death");
  var_0 endon("heli_players_dead");
  var_0 endon("returning_home");
  var_0 setvehweapon("turret_attackheli");

  if(!isDefined(var_0._id_2887)) {
    var_0._id_2887 = 0;
  }
  if(!var_0._id_2887) {
    var_0 setneargoalnotifydist(100);

    if(!isDefined(var_0._id_28A2)) {
      var_0 waittill("reached_dynamic_path_end");
    }
  } else {
    var_0 setneargoalnotifydist(500);
    var_0 waittill("near_goal");
  }

  var_0 thread _id_28A6();

  if(var_0._id_2887) {
    var_0 thread _id_28A3(var_1, var_2);
  } else {
    var_0 thread _id_28A4(var_2);
  }
}

_id_28A3(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "attack_heli_circle_node";
  }
  var_2 = getEntArray(var_0, "targetname");

  if(!isDefined(var_2) || var_2.size < 1) {
    var_2 = common_scripts\utility::getstructarray(var_0, "targetname");
  }
  var_3 = self;
  var_3 endon("stop_circling");
  var_3 endon("death");
  var_3 endon("returning_home");
  var_3 endon("heli_players_dead");

  for(;;) {
    var_3 vehicle_setspeed(var_1, var_1 / 4, var_1 / 4);
    var_3 setneargoalnotifydist(100);
    var_4 = maps\_utility::_id_2609(var_3.origin);
    var_5 = var_4.origin;
    var_3 setlookatent(var_4);
    var_6 = maps\_utility::_id_0AE9(var_5, var_2);
    var_7 = getEntArray(var_6.target, "targetname");

    if(!isDefined(var_7) || var_7.size < 1) {
      var_7 = common_scripts\utility::getstructarray(var_6.target, "targetname");
    }
    var_8 = var_7[randomint(var_7.size)];
    var_3 setvehgoalpos(var_8.origin, 1);
    var_3 waittill("near_goal");

    if(!isDefined(var_4._id_2259)) {
      wait 1;
      wait(randomfloatrange(0.8, 1.3));
    }
  }
}

_id_28A4(var_0) {
  self endon("death");
  var_1 = getEntArray("kill_heli_spot", "targetname");
  var_2 = self;
  var_3 = maps\_utility::_id_0AE9(var_2.origin, var_1);
  var_4 = var_3;
  var_2 endon("death");
  var_2 endon("returning_home");
  var_2 endon("heli_players_dead");
  var_5 = undefined;

  for(;;) {
    wait 0.05;
    var_2 vehicle_setspeed(var_0, var_0 / 2, var_0 / 10);
    var_2 setneargoalnotifydist(100);
    var_6 = maps\_utility::_id_2609(var_2.origin);
    var_7 = var_6.origin;

    if(var_3 == var_4 && var_2._id_288B) {
      var_8 = _id_28C4(var_2, var_3, var_1, var_6, var_7);
      var_3 = maps\_utility::_id_0AE9(var_7, var_8);
    }

    var_2 setvehgoalpos(var_3.origin, 1);
    var_2._id_288A = 1;
    var_6 = maps\_utility::_id_2609(var_2.origin);

    if(isDefined(self._id_288F) && isDefined(self._id_288F.classname) && self._id_288F.classname == "script_origin") {
      var_5 = var_6;
    } else if(isDefined(self._id_288F)) {
      var_5 = self._id_288F;
    } else {
      var_5 = self._id_288E;
    }
    var_2 setlookatent(var_5);
    var_2 waittill("near_goal");
    var_2._id_288A = 0;

    if(!maps\_utility::_id_12C1()) {
      if(level.gameskill == 0 || level.gameskill == 1) {
        while(_id_28A5(var_2)) {
          wait 0.5;
        }
        wait 3;
      }
    }

    var_6 = maps\_utility::_id_2609(var_2.origin);
    var_7 = var_6.origin;
    var_8 = _id_28C4(var_2, var_3, var_1, var_6, var_7);
    var_8[var_8.size] = var_3;
    var_4 = var_3;
    var_9 = maps\_utility::_id_0AE9(var_7, var_1);
    var_10 = maps\_utility::_id_0AE9(var_7, var_8);

    foreach(var_12 in var_8) {
      if(var_6 sightconetrace(var_12.origin, var_2) != 1) {
        var_8 = common_scripts\utility::array_remove(var_8, var_12);
        continue;
      }
    }

    var_14 = maps\_utility::_id_0AE9(var_7, var_8);

    if(var_8.size < 2) {
      var_3 = var_10;
    } else if(var_14 != var_9) {
      var_3 = var_14;
    } else {
      var_15 = [];
      var_15[0] = var_14;
      var_8 = maps\_utility::_id_0AEC(var_7, var_8, var_15, 2);
      var_16 = randomint(var_8.size);

      if(randomint(100) > 50) {
        var_3 = var_8[var_16];
      } else {
        var_3 = var_9;
      }
    }

    var_17 = randomfloatrange(level._id_287D - 0.5, level._id_287D + 0.5);
    common_scripts\utility::waittill_notify_or_timeout("damage_by_player", var_17);
  }
}

_id_28A5(var_0) {
  if(!level.player _id_28CE()) {
    return 0;
  }
  if(!level.player adsbuttonpressed()) {
    return 0;
  }
  var_1 = level.player getEye();

  if(sighttracepassed(var_1, var_0.origin, 0, level.player)) {
    return 1;
  }
  return 0;
}

_id_28A6() {
  self endon("stop_shooting");
  self endon("death");
  self endon("heli_players_dead");
  thread _id_28B0();
  var_0 = level._id_2878 * level._id_2878;
  level._id_28A7 = 0;

  while(isDefined(self)) {
    wait(randomfloatrange(0.8, 1.3));

    if(!_id_28AB() || !_id_28AA()) {
      var_1 = _id_28AE();

      if(isPlayer(var_1)) {
        self._id_288F = var_1;
      }
    }

    if(_id_28AA() && level.players.size > 1) {
      var_2 = maps\_utility::_id_2609(self.origin);

      if(self._id_288F != var_2) {
        var_1 = _id_28AE();

        if(isPlayer(var_1)) {
          self._id_288F = var_1;
        }
      }
    }

    if(_id_28AA()) {
      if(!_id_28A9() || level._id_28A7 == 1) {
        var_1 = _id_28AF();
        self._id_288F = var_1;
      }
    }

    if(isDefined(self._id_288C) && isPlayer(self._id_288C)) {
      self._id_288F = self._id_288C;
    } else if(!_id_28AB()) {
      var_1 = _id_28AF();
      self._id_288F = var_1;
    }

    if(!_id_28AB()) {
      continue;
    }
    if(self._id_288F _id_28C9(self)) {
      continue;
    }
    if(_id_28AB() && distancesquared(self._id_288F.origin, self.origin) > var_0) {
      continue;
    }
    if(self.turrettype == "default" && _id_28AA()) {
      _id_28C2(self._id_288F);
      wait(randomfloatrange(0.8, 1.3));
      _id_28C2(self._id_288F);
      wait(randomfloatrange(0.8, 1.3));

      while(_id_28C3(self._id_288F) && !self._id_288F _id_28C9(self)) {
        _id_28B7();
        wait(randomfloatrange(2.0, 4.0));
      }

      continue;
    }

    if(isPlayer(self._id_288F) || isai(self._id_288F)) {
      _id_28B7();
    }
    if(isPlayer(self._id_288F)) {
      thread _id_28A8(self);
    }
    common_scripts\utility::waittill_notify_or_timeout("damage_by_player", level._id_287C);
  }
}

_id_28A8(var_0) {
  level notify("player_is_heli_target");
  level endon("player_is_heli_target");
  level._id_28A7 = 1;
  var_0 common_scripts\utility::waittill_notify_or_timeout("damage_by_player", level._id_287E);
  level._id_28A7 = 0;
}

_id_28A9() {
  if(!isDefined(self._id_288F)) {
    return 0;
  }
  var_0 = self._id_288F.origin + (0, 0, 32);

  if(isPlayer(self._id_288F)) {
    var_0 = self._id_288F getEye();
  }
  var_1 = self gettagorigin("tag_flash");
  var_2 = sighttracepassed(var_1, var_0, 0, self);
  return var_2;
}

_id_28AA() {
  if(!isDefined(self._id_288F)) {
    return 0;
  }
  if(isPlayer(self._id_288F)) {
    return 1;
  } else {
    return 0;
  }
}

_id_28AB() {
  if(!isDefined(self._id_288F)) {
    return 0;
  }
  if(!isalive(self._id_288F)) {
    return 0;
  }
  if(self._id_288F == self._id_288E) {
    return 0;
  } else {
    return 1;
  }
}

_id_28AC() {
  var_0 = maps\_helicopter_globals::_id_2865(level._id_2878, level._id_287A, 1, 1, 0, 1, level._id_28AD);

  if(isDefined(var_0) && isPlayer(var_0)) {
    var_0 = self._id_288E;
  }
  if(!isDefined(var_0)) {
    var_0 = self._id_288E;
  }
  return var_0;
}

_id_28AE() {
  var_0 = getaiarray("allies");
  var_1 = maps\_helicopter_globals::_id_2865(level._id_2878, level._id_287A, 1, 0, 0, 0, var_0);

  if(!isDefined(var_1)) {
    var_1 = self._id_288E;
  }
  return var_1;
}

_id_28AF() {
  var_0 = maps\_helicopter_globals::_id_2865(level._id_2878, level._id_287A, 1, 1, 0, 1, level.players);

  if(!isDefined(var_0)) {
    var_0 = self._id_288E;
  }
  return var_0;
}

_id_28B0() {
  if(!isDefined(self._id_28B1)) {
    return;
  }
  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_shooting");
  var_0 = undefined;
  var_1 = "turret_attackheli";
  var_2 = "missile_attackheli";
  var_3 = undefined;
  var_4 = undefined;
  var_5 = [];

  switch (self.vehicletype) {
    case "mi28":
      var_0 = 1;
      var_3 = 1;
      var_4 = 0.5;
      var_5[0] = "tag_store_L_2_a";
      var_5[1] = "tag_store_R_2_a";
      var_5[2] = "tag_store_L_2_b";
      var_5[3] = "tag_store_R_2_b";
      var_5[4] = "tag_store_L_2_c";
      var_5[5] = "tag_store_R_2_c";
      var_5[6] = "tag_store_L_2_d";
      var_5[7] = "tag_store_R_2_d";
      break;
    case "littlebird":
      var_0 = 1;
      var_3 = 1;
      var_4 = 0.5;
      var_5[0] = "tag_missile_left";
      var_5[1] = "tag_missile_right";
      break;
    default:
      break;
  }

  var_6 = -1;

  for(;;) {
    wait 0.05;
    self waittill("fire_missiles", var_7);

    if(!isPlayer(var_7)) {
      continue;
    }
    var_8 = var_7;

    if(!_id_28B2(var_8)) {
      continue;
    }
    for(var_9 = 0; var_9 < var_0; var_9++) {
      var_6++;

      if(var_6 >= var_5.size) {
        var_6 = 0;
      }
      self setvehweapon(var_2);
      self._id_2889 = 1;
      var_10 = self fireweapon(var_5[var_6], var_8);
      var_10 thread _id_2873(var_4);
      var_10 thread _id_28B3();

      if(var_9 < var_0 - 1) {
        wait(var_3);
      }
    }

    self._id_2889 = 0;
    self setvehweapon(var_1);
    wait 10;
  }
}

_id_28B2(var_0) {
  if(self._id_288A) {
    return 0;
  } else {
    return 1;
  }
}

_id_28B3() {
  if(distancesquared(self.origin, level.player.origin) > 9000000) {
    return;
  }
  var_0 = self.origin;

  while(isDefined(self)) {
    var_0 = self.origin;
    wait 0.1;
  }

  earthquake(0.7, 1.5, var_0, 1600);
}

_id_2873(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  wait(var_0);

  if(isDefined(self)) {
    self missile_cleartarget();
  }
}

_id_28B4(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(var_0 != level.players[var_1]) {
      return level.players[var_1];
    }
  }

  return level.players[0];
}

_id_28B5() {
  self notify("notify_disable_thread");
  self endon("notify_disable_thread");
  self endon("death");
  self endon("heli_players_dead");

  for(;;) {
    self waittill("disable_turret");
    self._id_2888 = 0;
  }
}

_id_28B6() {
  self notify("notify_enable_thread");
  self endon("notify_enable_thread");
  self endon("death");
  self endon("heli_players_dead");

  for(;;) {
    self waittill("enable_turret");
    self._id_2888 = 1;
  }
}

_id_28B7() {
  switch (self.turrettype) {
    case "default":
      var_0 = randomintrange(5, 10);
      var_1 = weaponfiretime("turret_attackheli");
      _id_28BA(self._id_288F, var_0, var_1);
      break;
    case "miniguns":
      var_0 = _id_28B8(self._id_288F);

      if(self._id_2888 && !self._id_2889) {
        _id_28BB(self._id_288F, var_0);
      }
      break;
    default:
      break;
  }
}

_id_28B8(var_0) {
  var_1 = undefined;

  if(!isPlayer(var_0)) {
    var_1 = level._id_2876;
    return var_1;
  }

  switch (level.gameskill) {
    case 3:
    case 2:
    case 1:
    case 0:
      var_1 = randomintrange(2, 3);
      break;
  }

  return var_1;
}

_id_28B9(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  wait(var_0);

  if(!isPlayer(self._id_288F)) {
    return;
  }
  self notify("fire_missiles", self._id_288F);
}

_id_28BA(var_0, var_1, var_2) {
  thread _id_28B9(randomfloatrange(0.2, 2));

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self setturrettargetent(var_0, common_scripts\utility::randomvector(50) + (0, 0, 32));

    if(self._id_2888 && !self._id_2889) {
      self fireweapon();
    }
    wait(var_2);
  }
}

_id_28BB(var_0, var_1, var_2) {
  self endon("death");
  self endon("heli_players_dead");
  self notify("firing_miniguns");
  self endon("firing_miniguns");
  var_3 = _id_2894();
  common_scripts\utility::array_thread(var_3, ::_id_28BE, var_0, self);

  if(!self._id_2897) {
    self._id_2898 = 1;
    thread maps\_utility::play_sound_on_tag("littlebird_gatling_spinup", "tag_flash");
    wait 2.1;
    thread maps\_utility::_id_258E("littlebird_minigun_spinloop", "tag_flash");
  }

  self._id_2897 = 1;

  if(!isDefined(var_2)) {
    var_2 = 3;
  }
  var_4 = 0.5;

  if(var_4 > var_2) {
    var_4 = var_2;
  }
  if(var_4 > 0) {
    wait(randomfloatrange(var_4, var_2));
  }
  _id_28BC(var_0, var_1);
  var_3 = _id_2894();
  common_scripts\utility::array_call(var_3, ::stopfiring);
  thread _id_28C0(var_0);
  self notify("stopping_firing");
}

_id_28BC(var_0, var_1) {
  self endon("death");
  self endon("heli_players_dead");

  if(isPlayer(var_0)) {
    self endon("cant_see_player");
  }
  var_2 = _id_2894();
  common_scripts\utility::array_call(var_2, ::startfiring);
  wait(randomfloatrange(1, 2));

  if(isPlayer(var_0)) {
    thread _id_28BD(var_0);
  }
  if(isPlayer(var_0)) {
    var_3 = randomfloatrange(0.5, 3);
    thread _id_28B9(var_3);
  }

  wait(var_1);
}

_id_28BD(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stopping_firing");
  self notify("tracking_player");
  self endon("tracking_player");

  for(;;) {
    if(!_id_28C3(var_0)) {
      break;
    }

    wait 0.5;
  }

  wait(level._id_287F);
  self notify("cant_see_player");
}

_id_28BE(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("heli_players_dead");
  self notify("miniguns_have_new_target");
  self endon("miniguns_have_new_target");

  if(!isPlayer(var_0) && isai(var_0) && level._id_2879 == 0) {
    var_2 = spawn("script_origin", var_0.origin + (0, 0, 100));
    var_2 linkto(var_0);
    thread _id_28BF(var_2);
    var_0 = var_2;
  }

  for(;;) {
    wait 0.5;
    self settargetentity(var_0);
  }
}

_id_28BF(var_0) {
  common_scripts\utility::waittill_either("death", "miniguns_have_new_target");
  var_0 delete();
}

_id_28C0(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("firing_miniguns");

  if(isPlayer(var_0)) {
    wait(randomfloatrange(3, 4));
  } else {
    wait(randomfloatrange(1, 2));
  }
  thread _id_28C1();
  self._id_2898 = 0;
}

_id_28C1() {
  self notify("stop soundlittlebird_minigun_spinloop");
  self._id_2897 = 0;
  maps\_utility::play_sound_on_tag("littlebird_gatling_cooldown", "tag_flash");
}

_id_28C2(var_0) {
  var_1 = anglesToForward(level.player.angles);
  var_2 = var_1 * 400;
  var_3 = var_2 + common_scripts\utility::randomvector(50);
  var_4 = randomintrange(10, 20);
  var_5 = weaponfiretime("turret_attackheli");

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_3 = var_2 + common_scripts\utility::randomvector(50);
    self setturrettargetent(var_0, var_3);

    if(self._id_2888) {
      self fireweapon();
    }
    wait(var_5);
  }
}

_id_28C3(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  var_1 = self gettagorigin("tag_flash");

  if(sighttracepassed(var_1, var_0 getEye(), 0, undefined)) {
    return 1;
  } else {
    return 0;
  }
}

_id_28C4(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = strtok(var_1.script_linkto, " ");

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    for(var_8 = 0; var_8 < var_6.size; var_8++) {
      if(var_2[var_7].script_linkname == var_6[var_8]) {
        var_5[var_5.size] = var_2[var_7];
      }
    }
  }

  foreach(var_10 in var_5) {
    if(var_10.origin[2] < var_4[2]) {
      var_5 = common_scripts\utility::array_remove(var_5, var_10);
      continue;
    }
  }

  return var_5;
}

heli_damage_monitor() {
  self endon("death");
  self endon("heli_players_dead");
  self endon("crashing");
  self endon("leaving");
  self.damagetaken = 0;
  self._id_28C6 = undefined;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isDefined(var_1) || !isPlayer(var_1)) {
      continue;
    }
    self notify("damage_by_player");
    thread _id_28C7();
    thread _id_28C8(var_1);

    if(maps\_utility::_id_1A2C()) {
      var_1 thread updatedamagefeedback();
    }
  }
}

_id_28C7() {
  self notify("taking damage");
  self endon("taking damage");
  self endon("death");
  self endon("heli_players_dead");
  self._id_288B = 1;
  wait 1;
  self._id_288B = 0;
}

_id_28C8(var_0) {
  self notify("attacker_seen");
  self endon("attacker_seen");
  self._id_28C6 = var_0;
  self._id_288C = var_0;
  wait(level._id_287B);
  self._id_288C = undefined;
  self._id_28C6 = undefined;
}

_id_28C9(var_0) {
  if(isDefined(var_0._id_28C6)) {
    if(var_0._id_28C6 == self) {
      return 0;
    }
  }

  if(isDefined(level._id_28A0)) {
    foreach(var_2 in level._id_28A0) {
      if(self istouching(var_2)) {
        return 1;
      }
    }
  }

  return 0;
}

updatedamagefeedback() {
  if(!isPlayer(self)) {
    return;
  }
  self.hud_damagefeedback setshader("damage_feedback", 24, 48);
  self playlocalsound("player_feedback_hit_alert");
  self.hud_damagefeedback.alpha = 1;
  self.hud_damagefeedback fadeovertime(1);
  self.hud_damagefeedback.alpha = 0;
}

_id_28CA() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];
    var_1.hud_damagefeedback = newclienthudelem(var_1);
    var_1.hud_damagefeedback.horzalign = "center";
    var_1.hud_damagefeedback.vertalign = "middle";
    var_1.hud_damagefeedback.x = -12;
    var_1.hud_damagefeedback.y = -12;
    var_1.hud_damagefeedback.alpha = 0;
    var_1.hud_damagefeedback.archived = 1;
    var_1.hud_damagefeedback setshader("damage_feedback", 24, 48);
  }
}

_id_28CB() {
  self waittill("death");
  level notify("attack_heli_destroyed");
  level._id_289D = 1;
  wait 15;
  level._id_289F = 0;
}

_id_28CC(var_0) {
  var_0 endon("death");
  var_0 endon("heli_players_dead");
  wait 30;

  if(!level._id_289F) {
    return;
  }
  _id_28CD("co_cf_cmd_heli_small_fire");

  if(!level._id_289F) {
    return;
  }
  _id_28CD("co_cf_cmd_rpg_stinger");
  wait 30;

  if(!level._id_289F) {
    return;
  }
  _id_28CD("co_cf_cmd_heli_wonders");
}

_id_28CD(var_0) {
  while(level._id_289E) {
    wait 1;
  }
  level._id_289E = 1;
  level.player playSound(var_0, "sounddone");
  level.player waittill("sounddone");
  wait 0.5;
  level._id_289E = 0;
}

_id_28CE() {
  var_0 = self getcurrentweapon();

  if(!isDefined(var_0)) {
    return 0;
  }
  if(issubstr(tolower(var_0), "rpg")) {
    return 1;
  }
  if(issubstr(tolower(var_0), "stinger")) {
    return 1;
  }
  if(issubstr(tolower(var_0), "at4")) {
    return 1;
  }
  return 0;
}

_id_28CF(var_0) {
  common_scripts\utility::waittill_any("death", "crash_done", "turn_off_spotlight");
  self._id_2891 = undefined;

  if(isDefined(self)) {
    stopFXOnTag(common_scripts\utility::getfx("_attack_heli_spotlight"), self, var_0);
  }
}

_id_28D0() {
  self endon("death");
  self endon("heli_players_dead");

  if(self.vehicletype != "littlebird") {
    return;
  }
  thread _id_28D2();
  var_0 = undefined;

  for(;;) {
    wait 0.05;

    switch (self.vehicletype) {
      case "littlebird":
        var_0 = self._id_28D1;
        break;
      default:
        var_0 = self._id_288F;
        break;
    }

    if(isDefined(var_0)) {
      self setturrettargetent(var_0, (0, 0, 0));
    }
  }
}

_id_28D2() {
  self endon("death");
  self endon("heli_players_dead");
  var_0 = self._id_288E;
  var_0.targetname = "original_ent";
  self._id_28D3 = spawn("script_origin", var_0.origin);
  self._id_28D3.origin = var_0.origin;
  self._id_28D3.angles = var_0.angles;
  self._id_28D3.targetname = "left_ent";
  self._id_28D4 = spawn("script_origin", var_0.origin);
  self._id_28D4.origin = var_0.origin;
  self._id_28D4.angles = var_0.angles;
  self._id_28D4.targetname = "right_ent";
  var_1 = spawnStruct();
  var_1.entity = self._id_28D3;
  var_1.right = 250;
  var_1 maps\_utility::_id_18B9();
  self._id_28D3 linkto(self);
  var_2 = spawnStruct();
  var_2.entity = self._id_28D4;
  var_2.right = -250;
  var_2 maps\_utility::_id_18B9();
  self._id_28D4 linkto(self);
  var_3 = [];
  var_3[0] = var_0;
  var_3[1] = self._id_28D3;
  var_3[2] = self._id_28D4;
  self._id_28D1 = var_0;
  common_scripts\utility::array_thread(var_3, ::_id_28D6, self);

  for(;;) {
    wait(randomfloatrange(1, 3));

    if(_id_28AA() && !_id_28D5()) {
      self._id_28D1 = self._id_288F;
      continue;
    }

    var_4 = randomint(var_3.size);
    self._id_288E = var_3[var_4];
    self._id_28D1 = self._id_288E;
  }
}

_id_28D5() {
  self endon("death");
  self endon("heli_players_dead");

  if(!isDefined(self._id_288F)) {
    return 0;
  }
  if(!isPlayer(self._id_288F)) {
    return 0;
  }
  var_0 = self._id_288F;
  var_1 = maps\_utility::within_fov(var_0 getEye(), var_0 getplayerangles(), self.origin, level.cosine["35"]);
  return var_1;
}

_id_28D6(var_0) {
  var_0 common_scripts\utility::waittill_either("death", "crash_done");

  if(isDefined(self)) {
    self delete();
  }
}

_id_28D7(var_0) {
  var_1 = self;
  var_1 maps\_vehicle::_id_28D8("manual");

  if(isDefined(var_0._id_288E)) {
    var_1 settargetentity(var_0._id_288E);
  }
  var_1 setmode("manual");
  var_0 waittill("death");

  if(isDefined(var_0._id_2898) && var_0._id_2898 == 1) {
    thread _id_28C1();
  }
}

_id_28D9() {
  common_scripts\utility::waittill_either("death", "crash_done");

  if(isDefined(self.attractor)) {
    missile_deleteattractor(self.attractor);
  }
  if(isDefined(self._id_2885)) {
    missile_deleteattractor(self._id_2885);
  }
}

_id_28DA(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_default_heli_missiles");
  self._id_28DB = undefined;

  while(isDefined(self)) {
    wait 0.05;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    self._id_28DB = undefined;
    var_4 = undefined;

    if(isDefined(self.currentnode) && isDefined(self.currentnode.target)) {
      var_4 = maps\_utility::_id_27F1(self.currentnode.target, "targetname");
    }
    if(isDefined(var_4) && isDefined(var_4.script_linkto)) {
      self._id_28DB = maps\_utility::_id_27F1(var_4.script_linkto, "script_linkname");
    }
    if(isDefined(self._id_28DB)) {
      var_1 = self._id_28DB;
      var_2 = var_1._id_28DC;
      var_3 = var_1.script_delay;
      var_4 waittill("trigger");
    } else {
      common_scripts\utility::waittill_any("near_goal", "goal");
    }
    if(isDefined(var_1)) {
      thread _id_28E2(var_1, var_2, var_3, var_0);
    }
  }
}

_id_28DD() {
  self notify("stop_default_heli_missiles");
}

_id_28DE(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "tag_barrel";
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  playFXOnTag(common_scripts\utility::getfx("_attack_heli_spotlight"), self, var_0);
  self._id_2891 = 1;
  thread _id_28CF(var_0);

  if(var_1) {
    self endon("death");
    self endon("heli_players_dead");
    var_2 = self gettagorigin("tag_origin");

    if(!isDefined(self._id_288E)) {
      _id_2893();
    }
    self setturrettargetent(self._id_288E);
    thread _id_28D0();
  }
}

_id_28DF() {
  self notify("turn_off_spotlight");
}

_id_28E0() {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_spotlight_random_targets");

  if(!isDefined(self._id_288E)) {
    thread _id_2893();
  }
  if(!isDefined(self._id_28D3)) {
    thread _id_28D2();
  }
  while(isDefined(self)) {
    wait 0.05;
    self setturrettargetent(self._id_288E, (0, 0, 0));
  }
}

_id_28E1() {
  self notify("stop_spotlight_random_targets");
}

_id_28E2(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("heli_players_dead");

  if(isDefined(self._id_28E3)) {
    var_4 = self._id_28E3;
  } else {
    var_4 = "turret_attackheli";
  }
  var_5 = "missile_attackheli";

  if(isDefined(var_3)) {
    var_5 = var_3;
  }
  var_6 = undefined;
  var_7 = [];
  self setvehweapon(var_4);

  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  if(!isDefined(var_2)) {
    var_2 = 1;
  }
  if(!isDefined(var_0.classname)) {
    if(!isDefined(self._id_28E4)) {
      self._id_28E4 = spawn("script_origin", var_0.origin);
      thread common_scripts\utility::delete_on_death(self._id_28E4);
    }

    self._id_28E4.origin = var_0.origin;
    var_0 = self._id_28E4;
  }

  switch (self.vehicletype) {
    case "mi28":
      var_6 = 0.5;
      var_7[0] = "tag_store_L_2_a";
      var_7[1] = "tag_store_R_2_a";
      var_7[2] = "tag_store_L_2_b";
      var_7[3] = "tag_store_R_2_b";
      var_7[4] = "tag_store_L_2_c";
      var_7[5] = "tag_store_R_2_c";
      var_7[6] = "tag_store_L_2_d";
      var_7[7] = "tag_store_R_2_d";
      break;
    case "littlebird":
      var_6 = 0.5;
      var_7[0] = "tag_missile_left";
      var_7[1] = "tag_missile_right";
      break;
    default:
      break;
  }

  var_8 = -1;

  for(var_9 = 0; var_9 < var_1; var_9++) {
    var_8++;

    if(var_8 >= var_7.size) {
      var_8 = 0;
    }
    self setvehweapon(var_5);
    self._id_2889 = 1;
    var_10 = self fireweapon(var_7[var_8], var_0);
    var_10 thread _id_28B3();

    if(var_9 < var_1 - 1) {
      wait(var_2);
    }
  }

  self._id_2889 = 0;
  self setvehweapon(var_4);
}

_id_28E5() {
  self waittill("trigger", var_0);
  var_1 = common_scripts\utility::getstructarray(self.target, "targetname");
  var_1 = maps\_utility::_id_27EC(var_1);
  _id_28E7(var_0, var_1);
}

_id_28E6() {
  self waittill("trigger", var_0);
  var_1 = maps\_utility::_id_2051();
  var_1 = maps\_utility::_id_27EC(var_1);
  _id_28E7(var_0, var_1);
}

_id_28E7(var_0, var_1) {
  var_2 = [];
  var_2[0] = "tag_missile_right";
  var_2[1] = "tag_missile_left";

  if(level.script == "roadkill") {
    var_2[0] = "tag_flash_2";
    var_2[1] = "tag_flash_11";
  }

  if(var_0.vehicletype == "cobra") {
    var_2[0] = "tag_store_L_1_a";
    var_2[1] = "tag_store_R_1_a";
  }

  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_3[var_4] = spawn("script_origin", var_1[var_4].origin);
    var_0 setvehweapon("littlebird_FFAR");
    var_0 setturrettargetent(var_3[var_4]);
    var_5 = var_0 fireweapon(var_2[var_4 % var_2.size], var_3[var_4], (0, 0, 0));
    var_5 common_scripts\utility::delaycall(1, ::missile_cleartarget);
    wait(randomfloatrange(0.2, 0.3));
  }

  wait 2;

  foreach(var_7 in var_3) {}
  var_7 delete();
}