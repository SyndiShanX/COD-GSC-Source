/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_chopper_missile_defense_utility.gsc
****************************************************************/

array_removeinvalidmissiles(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isvalidmissile(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

monitorenemymissilefire() {
  var_0 = self.owner;

  for(;;) {
    var_0 waittill("LISTEN_missile_fire", var_1);

    if(!isvalidmissile(var_1)) {
      continue;
    }
    self.firedonme = array_removeinvalidmissiles(self.firedonme);
    self.firedonme = common_scripts\utility::array_add(self.firedonme, var_1);
  }
}

missile_monitormisstarget(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_5 notify("missile_monitorMissTarget");
  var_5 endon("missile_monitorMissTarget");
  var_5 endon("death");

  if(isDefined(var_4))
    var_5 endon(var_4);

  var_0 endon("death");
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, 0);
  var_5.missed_target = undefined;

  for(var_6 = 1.0; var_6 > 0.75; var_6 = vectordot(var_8, var_7)) {
    wait 0.05;

    if(!isDefined(var_0)) {
      break;
    }

    var_7 = anglesToForward(var_5.angles);
    var_8 = vectornormalize(var_0.origin - var_5.origin);
  }

  if(isDefined(var_0))
    var_5.missed_target = var_0;

  var_5 notify(var_3);
  var_5 missile_cleartarget();

  if(isDefined(var_0) && isDefined(var_0.missile_defense) && isDefined(var_0.missile_defense.firedonme) && var_0.missile_defense.firedonme.size)
    var_0.missile_defense.firedonme = common_scripts\utility::array_remove(var_0.missile_defense.firedonme, var_5);

  if(!var_1) {
    return;
  }
  if(isDefined(var_2)) {
    var_9 = squared(var_2);

    while(distancesquared(var_5.origin, var_0.origin) < var_9)
      wait 0.05;
  }

  var_5 delete();
}

do_evade(var_0) {
  if(isDefined(self.evading)) {
    return;
  }
  var_1 = "";

  if(self.classname == "script_vehicle_apache_iw6")
    var_1 = "apache";
  else if(self.classname == "script_vehicle_hind_battle_oilrocks")
    var_1 = "battlehind";

  if(var_1 == "") {
    return;
  }
  var_2 = maps\_utility::getanim_generic(var_1 + "_evade_left");
  var_3 = maps\_utility::getanim_generic(var_1 + "_evade_right");
  var_4 = [];
  var_4 = add_valid_evade(var_2, var_4);
  var_4 = add_valid_evade(var_3, var_4);

  if(var_4.size == 0) {
    return;
  }
  self.evading = 1;
  var_5 = common_scripts\utility::random(var_4);
  var_6 = getanimlength(var_5);
  var_7 = self localtoworldcoords(getmovedelta(var_5, 0, 1));
  var_8 = getangledelta3d(var_5);
  maps\_vehicle_code::suspend_drive_anims();
  self endon("kill_death_anim");
  var_9 = self.origin;
  var_10 = self.angles;
  self animscripted("evading", var_9, var_10, var_5);
  self.allowdeath = 1;
  wait(var_6 - 0.05);
  thread maps\_vehicle_code::animate_drive_idle();
  self endon("chopper_boss_move");
  self.request_move = 1;
  self notify("request_move_update");
  self.evading = undefined;
}

add_valid_evade(var_0, var_1) {
  var_2 = self localtoworldcoords(getmovedelta(var_0, 0, 1));

  foreach(var_4 in getEntArray("no_chopper_evade_area", "targetname")) {
    if(ispointinvolume(var_2, var_4))
      return var_1;
  }

  var_1[var_1.size] = var_0;
  return var_1;
}

monitorflarerelease_auto(var_0, var_1) {
  var_2 = self.owner;
  var_3 = self.flareactiveradius;
  var_4 = 0;
  var_5 = self.flarecooldown;
  var_6 = self.flarenumpairs;
  var_7 = self.flarereloadtime;

  for(;;) {
    foreach(var_9 in self.firedonme) {
      if(dsq_2d_ents_lt(var_2, var_9, var_3)) {
        var_4 = 1;
        self.owner thread do_evade(var_9);
        break;
      }
    }

    var_11 = 1;

    if(var_4) {
      if(isDefined(var_0))
        var_11 = self[[var_0]]();

      if(var_11) {
        if(isDefined(level.apache_chatter_func))
          self.owner[[level.apache_chatter_func]]("flares_out");

        for(var_12 = 0; var_12 < var_6; var_12++) {
          var_13 = common_scripts\utility::array_randomize(["right", "left"]);
          maps\_utility::delaythread(var_12 * 0.5 + 0.05, ::shootflares, var_13[0]);
          maps\_utility::delaythread(var_12 * 0.5 + 0.5, ::shootflares, var_13[1]);
        }

        wait(var_5);
      }

      var_4 = 0;

      if(var_11) {
        if(isDefined(var_1))
          self childthread[[var_1]](var_7);

        continue;
      }
    }

    wait 0.05;
  }
}

monitorflarerelease_input(var_0, var_1) {
  var_2 = self.owner;
  var_3 = self.flareactiveradius;
  var_4 = 0;
  var_5 = self.flarecooldown;
  var_6 = self.flarenumpairs;
  var_7 = self.flarereloadtime;
  var_2 notifyonplayercommand("Listen_chopper_player_missile_defense_shoot_flares", "+smoke");

  for(;;) {
    var_2 waittill("Listen_chopper_player_missile_defense_shoot_flares");

    if(self[[var_0]]()) {
      for(var_8 = 0; var_8 < var_6; var_8++) {
        var_9 = common_scripts\utility::array_randomize(["right", "left"]);
        maps\_utility::delaythread(var_8 * 0.5 + 0.05, ::shootflares, var_9[0]);
        maps\_utility::delaythread(var_8 * 0.5 + 0.5, ::shootflares, var_9[1]);
      }

      self childthread[[var_1]](var_7);
      wait(var_5);
      continue;
    }

    level.player thread maps\_utility::play_sound_on_entity("apache_player_empty_click");
  }
}

monitorenemymissilelockon(var_0) {
  var_1 = self.owner;

  for(;;) {
    var_1 waittill("LISTEN_missile_lockOn", var_2);

    if(!isDefined(var_2)) {
      continue;
    }
    if(isDefined(var_0)) {
      if(!isenemylockedontome(var_2))
        self childthread[[var_0]](var_2);
    }

    self.lockedontome = common_scripts\utility::array_removeundefined(self.lockedontome);
    self.lockedontome = common_scripts\utility::array_add(self.lockedontome, var_2);
  }
}

isenemylockedontome(var_0) {
  return maps\_utility::is_in_array(self.lockedontome, var_0);
}

isanyenemylockedontome() {
  self.lockedontome = common_scripts\utility::array_removeundefined(self.lockedontome);
  return self.lockedontome.size;
}

isanymissilefiredonme() {
  self.firedonme = array_removeinvalidmissiles(self.firedonme);
  return self.firedonme.size;
}

flare_trackvelocity() {
  self endon("LISTEN_end_flare_trackVelocity");
  self endon("death");
  self.velocity = 0;
  var_0 = self.origin;

  for(;;) {
    self.velocity = self.origin - var_0;
    var_0 = self.origin;
    wait 0.05;
  }
}

dsq_2d_ents_lt(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
    if(isDefined(var_3))
      return common_scripts\utility::ter_op(dsq_2d_ents(var_0, var_0) < squared(var_2) && abs(var_1.origin[2] - var_0.origin[2]) < var_3, 1, 0);
    else
      return common_scripts\utility::ter_op(dsq_2d_ents(var_0, var_1) < squared(var_2), 1, 0);
  }

  return common_scripts\utility::ter_op(isDefined(var_4), var_4, 0);
}

dsq_2d_ents(var_0, var_1) {
  return lengthsquared((var_0.origin[0] - var_1.origin[0], var_0.origin[1] - var_1.origin[1], 0));
}

dsq_ents_lt(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2))
    return common_scripts\utility::ter_op(distancesquared(var_0.origin, var_1.origin) < squared(var_2), 1, 0);

  return common_scripts\utility::ter_op(isDefined(var_3), var_3, 0);
}

flat_angle_yaw(var_0) {
  return (0, var_0[1], 0);
}

gt_op(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1))
    return common_scripts\utility::ter_op(var_0 > var_1, var_0, var_1);

  if(isDefined(var_0) && !isDefined(var_1))
    return var_0;

  if(!isDefined(var_0) && isDefined(var_1))
    return var_1;

  return var_2;
}

override_array_delete(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = ["death"];

  var_2 = gt_op(var_2, 0);

  foreach(var_4 in var_0) {
    if(isDefined(var_4)) {
      if(isarray(var_4)) {
        if(var_2 > 0) {
          override_array_delete(var_4, var_1, var_2);
          wait 0.05;
        } else
          thread override_array_delete(var_4, var_1, 0);

        continue;
      }

      foreach(var_6 in var_1)
      var_4 notify(var_6);

      if(var_2 > 0) {
        wait 0.05;

        if(isDefined(var_4))
          var_4 delete();
      } else
        var_4 delete();
    }
  }
}

on_param_death_delete_self(var_0) {
  self notify("on_param_death_delete_self");
  self endon("on_param_death_delete_self");
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self))
    self delete();
}

shootflares(var_0) {
  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  var_1 = self.owner;
  var_2 = var_1.angles;

  if(isDefined(self.flarerig_tagangles))
    var_2 = flat_angle_yaw(var_1 gettagangles(self.flarerig_tagangles));
  else if(isplayer(var_1))
    var_2 = (var_1 getplayerangles()[0], var_2[1], var_2[2]);

  var_3 = var_1.origin;

  if(isDefined(self.flarerig_tagorigin)) {
    var_4 = self.flarerig_tagorigin;

    if(maps\_utility::hastag(var_1.model, self.flarerig_tagorigin))
      var_3 = var_1 gettagorigin(self.flarerig_tagorigin);
    else if(maps\_utility::hastag(var_1.model, "tag_origin"))
      var_3 = var_1 gettagorigin("tag_origin");
  }

  var_5 = maps\_utility::spawn_anim_model(self.flarerig_name);
  var_6 = anglestoright(var_2);
  var_7 = common_scripts\utility::ter_op(var_0 == "right", 1, -1);
  var_8 = self.flarespawnoffsetright;
  var_5.origin = var_3 + var_7 * var_8 * var_6;
  var_9 = randomfloatrange(self.flarespawnminyawoffset, self.flarespawnmaxyawoffset);
  var_10 = randomfloatrange(self.flarespawnminpitchoffset, self.flarespawnmaxpitchoffset);
  var_2 = (var_2[0] - var_10, var_2[1] + -1 * var_7 * var_9, var_2[2] + var_7 * 90);
  var_5.angles = var_2;

  if(self.flarerig_link) {
    var_1 playrumbleonentity("smg_fire");

    if(isDefined(self.vehicle))
      var_5 linkto(self.vehicle, "tag_origin");
  }

  self.flares = common_scripts\utility::array_removeundefined(self.flares);
  var_11 = [];
  var_12 = ["flare_left_bot", "flare_right_bot"];

  foreach(var_14 in var_12) {
    var_15 = var_5 common_scripts\utility::spawn_tag_origin();
    var_15.origin = var_5 gettagorigin(var_14);
    var_15.angles = var_5 gettagangles(var_14);
    var_15 linkto(var_5, var_14);
    var_15 thread flare_trackvelocity();
    var_11[var_14] = var_15;
  }

  self.flares = common_scripts\utility::array_combine(self.flares, var_11);
  var_17 = level.scr_anim[self.flarerig_name]["flare"].size;
  var_18 = level.scr_anim[self.flarerig_name]["flare"][self.flareindex % var_17];
  self.flareindex++;
  var_19 = common_scripts\utility::ter_op(isDefined(self.flarerig_animrate), self.flarerig_animrate, 1);
  var_5.allowdeath = 0;
  var_5 setCanDamage(0);
  var_5 setflaggedanim("flare_anim", var_18, 1, 0, var_19);
  wait 0.05;

  foreach(var_14, var_15 in var_11) {
    if(isDefined(var_15))
      playFXOnTag(self.flarefx, var_11[var_14], "tag_origin");
  }

  var_5 thread maps\_utility::play_sound_on_tag(self.flaresound, "tag_fx", 1);
  var_5 waittillmatch("flare_anim", "end");

  foreach(var_14, var_15 in var_11) {
    if(isDefined(var_15))
      stopFXOnTag(self.flarefx, var_11[var_14], "tag_origin");
  }

  var_5 delete();
  var_11 = common_scripts\utility::array_removeundefined(var_11);
  common_scripts\utility::array_thread(var_11, ::flare_doburnout);

  if(isDefined(self.flares))
    self.flares = common_scripts\utility::array_removeundefined(self.flares);
}

flare_doburnout() {
  self endon("death");
  self notify("LISTEN_end_flare_trackVelocity");
  self movegravity(14 * self.velocity, 0.2);
  wait 0.2;

  if(!isDefined(self) || isDefined(self.mytarget)) {
    return;
  }
  self delete();
}

flare_monitorattractor(var_0) {
  self waittill("death");
  missile_deleteattractor(var_0);
}

flare_monitortakingoutmissile(var_0, var_1, var_2) {
  self endon("death");
  var_1 endon("death");
  var_1 notify("LISTEN_missile_attached_to_flare");
  var_3 = squared(var_0);
  var_1.mytarget = self;
  self.mytarget = var_1;
  var_1 thread on_param_death_delete_self(self);
  thread on_param_death_delete_self(var_1);
  var_1 thread missile_monitormisstarget(var_1.mytarget, 0, undefined, "LISTEN_missile_missed_flare");

  for(;;) {
    var_4 = common_scripts\utility::waittill_any_timeout(0.05, "LISTEN_missile_missed_flare");
    waittillframeend;

    if(var_4 == "LISTEN_missile_missed_flare" || isDefined(var_1.missed_target) && var_1.missed_target == var_1.mytarget || distancesquared(self.origin, var_1.origin) <= var_3) {
      if(self islinked())
        self unlink();

      var_5 = flat_angle_yaw(var_1.angles);
      var_6 = anglesToForward(var_5);
      playFX(var_2.flarefxexplode, var_1.origin, var_6);
      stopFXOnTag(var_2.flarefx, self, "tag_origin");
      earthquake(0.5, 0.6, var_1.origin, 2048);
      thread common_scripts\utility::play_sound_in_space("chopper_trophy_fire", var_1.origin);

      if(var_2.owner == level.player)
        thread common_scripts\utility::play_sound_in_space("chopper_trophy_fire_shards", var_1.origin);

      var_1 delete();
      self delete();
      return;
    }
  }
}

monitorflares() {
  for(;;) {
    self.firedonme = array_removeinvalidmissiles(self.firedonme);
    self.flares = common_scripts\utility::array_removeundefined(self.flares);

    if(self.firedonme.size && self.flares.size)
      pairflareswithclosestmissile();

    wait 0.05;
  }
}

pairflareswithclosestmissile() {
  var_0 = self.missiletargetflareradius;

  foreach(var_2 in self.firedonme) {
    if(!isvalidmissile(var_2) || isDefined(var_2.mytarget)) {
      continue;
    }
    var_3 = undefined;
    var_4 = 0;

    foreach(var_6 in self.flares) {
      if(isDefined(var_6.mytarget)) {
        continue;
      }
      if(!isDefined(var_3))
        var_3 = var_6;

      var_7 = distancesquared(var_3.origin, var_2.origin);
      var_8 = distancesquared(var_6.origin, var_2.origin);

      if(var_7 < var_0 * var_0)
        var_4 = 1;

      if(var_8 < var_7)
        var_3 = var_6;
    }

    if(isDefined(var_3) && var_4) {
      var_2.type_missile = common_scripts\utility::ter_op(isDefined(var_2.type_missile), var_2.type_missile, "guided");

      switch (var_2.type_missile) {
        case "guided":
          var_2 missile_settargetent(var_3);
          var_2 missile_setflightmodedirect();
          break;
        case "straight":
          var_10 = missile_createattractorent(var_3, 100000, var_0);
          var_3 thread flare_monitorattractor(var_10);
          break;
      }

      var_3 thread flare_monitortakingoutmissile(self.flaredestroymissileradius, var_2, self);
    }
  }
}