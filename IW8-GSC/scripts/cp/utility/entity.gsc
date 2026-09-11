/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\entity.gsc
***********************************************/

function getaverageorigin(var_0) {
  var_1 = (0, 0, 0);

  if(!var_0.size) {
    return undefined;
  }

  foreach(var_3 in var_0) {
    var_1 += var_3.origin;
  }

  var_5 = int(var_1[0] / var_0.size);
  var_6 = int(var_1[1] / var_0.size);
  var_7 = int(var_1[2] / var_0.size);
  var_1 = (var_5, var_6, var_7);
  return var_1;
}

function touchingbadtrigger() {
  var_0 = getEntArray("trigger_hurt", "classname");

  foreach(var_2 in var_0) {
    if(self istouching(var_2)) {
      return true;
    }
  }

  var_4 = getEntArray("radiation", "targetname");

  foreach(var_2 in var_4) {
    if(self istouching(var_2)) {
      return true;
    }
  }

  return false;
}

function touchingoobtrigger() {
  if(istrue(self.allowedintrigger)) {
    return false;
  }

  if(!isDefined(level.outofboundstriggers)) {
    return false;
  }

  foreach(var_1 in level.outofboundstriggers) {
    if(self istouching(var_1)) {
      return true;
    }
  }

  return false;
}

function touchingballallowedtrigger() {
  if(!istrue(level.ballallowedtriggers.size)) {
    return false;
  }

  self.allowedintrigger = 0;

  foreach(var_1 in level.ballallowedtriggers) {
    if(self istouching(var_1)) {
      self.allowedintrigger = 1;
      return true;
    }
  }

  return false;
}

function touchingplayerallowedtrigger() {
  if(!istrue(level.playerallowedtriggers.size)) {
    return false;
  }

  self.allowedintrigger = 0;

  foreach(var_1 in level.playerallowedtriggers) {
    if(self istouching(var_1)) {
      self.allowedintrigger = 1;
      return true;
    }
  }

  return false;
}

function findisfacing(var_0, var_1, var_2) {
  var_3 = cos(var_2);
  var_4 = anglesToForward(var_0.angles);
  var_5 = var_1.origin - var_0.origin;
  var_4 *= (1, 1, 0);
  var_5 *= (1, 1, 0);
  var_5 = vectorNormalize(var_5);
  var_4 = vectorNormalize(var_4);
  var_6 = vectordot(var_5, var_4);

  if(var_6 >= var_3) {
    return 1;
  }

  return 0;
}

function isaiteamparticipant(var_0) {
  if(isagent(var_0) && var_0.agent_teamparticipant == 1) {
    return true;
  }

  if(isbot(var_0)) {
    return true;
  }

  return false;
}

function isteamparticipant(var_0) {
  if(isaiteamparticipant(var_0)) {
    return true;
  }

  if(isPlayer(var_0)) {
    return true;
  }

  return false;
}

function isaigameparticipant(var_0) {
  if(isagent(var_0) && isDefined(var_0.agent_gameparticipant) && var_0.agent_gameparticipant == 1) {
    return true;
  }

  if(isbot(var_0)) {
    return true;
  }

  return false;
}

function isgameparticipant(var_0) {
  if(isaigameparticipant(var_0)) {
    return true;
  }

  if(isPlayer(var_0)) {
    return true;
  }

  return false;
}

function getteamindex(var_0) {
  var_1 = 0;

  if(level.teambased) {
    switch (var_0) {
      case "axis":
        var_1 = 1;
        break;
      case "allies":
        var_1 = 2;
        break;
    }
  }

  return var_1;
}

function isvalidteamtarget(var_0, var_1, var_2) {
  return isDefined(var_2.team) && var_2.team == var_1;
}

function isvalidffatarget(var_0, var_1, var_2) {
  return isDefined(var_2.owner) && (!isDefined(var_0) || var_2.owner != var_0);
}

function getlinknamenodes() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = strtok(self.script_linkto, " ");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = getnode(var_1[var_2], "script_linkname");

      if(isDefined(var_3)) {
        var_0 = var_3;
      }
    }
  }

  return var_0;
}

function getparticipantsinradius(var_0, var_1, var_2, var_3) {
  return getentitiesinradius(var_0, var_1, var_2, var_3, scripts\engine\trace::create_character_contents());
}

function getentitiesinradius(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 <= 0) {
    return [];
  }

  var_5 = undefined;

  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      var_5 = var_3;
    } else {
      var_5 = [var_3];
    }
  }

  var_6 = physics_querypoint(var_0, var_1, var_4, var_5, "physicsquery_all");
  var_7 = [];
  jumpiftrue(isDefined(var_2)) LOC_0000007d;

  foreach(var_9 in var_6) {
    var_10 = var_9["entity"];

    if(isDefined(var_10)) {
      var_7 = var_10;
    }
  }

  goto LOC_000000ce;
}

function watchentitiesinradius(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  self endon("end_entities_in_radius");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    var_5 = undefined;

    if(var_4) {
      var_5 = scripts\cp\utility\player::getplayersinradius(self.origin, var_0);
    } else {
      var_5 = getentitiesinradius(self.origin, var_0);
    }

    if(var_5.size > 0) {
      if(!var_3) {
        self notify(var_1, var_5);
      } else {
        var_6 = [];

        foreach(var_8 in var_5) {
          var_9 = self getorigin();
          var_10 = scripts\engine\utility::ter_op(var_4, var_8 getEye(), var_8.origin);
          var_11 = physics_createcontents(["physicscontents_solid", "physicscontents_structural", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot"]);
          var_12 = physics_raycast(var_9, var_10, var_11, undefined, 0, "physicsquery_closest");

          if(var_12.size <= 0) {
            var_6 = var_8;
          }
        }

        self notify(var_1, var_6);
      }
    }

    wait var_2;
  }
}

function cancelentitiesinradius() {
  self notify("end_entities_in_radius");
}

function placeequipmentfailed(var_0, var_1, var_2, var_3) {
  self playlocalsound("scavenger_pack_pickup");

  if(istrue(var_1)) {
    var_4 = undefined;

    if(isDefined(var_3)) {
      var_4 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2, self, anglesToForward(var_3), anglestoup(var_3));
    } else {
      var_4 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2, self);
    }

    triggerfx(var_4);
    thread placeequipmentfailedcleanup(var_4);
  }

  switch (var_0) {
    case "deployable_cover_mp":
    case "cryo_mine_mp":
    case "micro_turret_mp":
    case "trip_mine_mp":
    case "trophy_mp":
      if(isPlayer(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
        self iprintlnbold("Placement Failed");
        return;
      }

      break;
  }
}

function placeequipmentfailedinit() {
  level._effect["placeEquipmentFailed"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
}

function placeequipmentfailedcleanup(var_0) {
  wait 2;
  var_0 delete();
}

function isspidergrenade(var_0) {
  return istrue(var_0.isspidergrenade);
}

function issupertrophy(var_0) {
  var_1 = var_0 getentitynumber();

  if(!isDefined(level.supertrophy)) {
    return false;
  }

  if(!isDefined(level.supertrophy.trophies)) {
    return false;
  }

  if(!isDefined(level.supertrophy.trophies[var_1])) {
    return false;
  }

  return level.supertrophy.trophies[var_1] == var_0;
}

function ismicroturret(var_0) {
  var_1 = var_0 getentitynumber();

  if(!isDefined(level.microturrets)) {
    return false;
  }

  if(!isDefined(level.microturrets[var_1])) {
    return false;
  }

  return level.microturrets[var_1] == var_0;
}

function ischoppergunner(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "chopper_gunner";
  return var_1;
}

function tutorial_jumpfromplane(var_0) {
  if(!isDefined(var_0.vehicletype)) {
    return 0;
  }

  var_1 = var_0.vehicletype == "apache";
  return var_1;
}

function issupporthelo(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "chopper_support";
  return var_1;
}

function isclusterstrike(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "toma_strike";
  return var_1;
}

function isuav(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return false;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return false;
  }

  if(var_0.streakinfo.streakname == "uav" || var_0.streakinfo.streakname == "counter_uav" || var_0.streakinfo.streakname == "directional_uav") {
    return true;
  }

  return false;
}

function isgunship(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "gunship";
  return var_1;
}

function isradardrone(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "radar_drone_escort" || var_0.streakinfo.streakname == "radar_drone_recon";
  return var_1;
}

function isscramblerdrone(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "scrambler_drone_guard";
  return var_1;
}

function isradarhelicopter(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "radar_drone_overwatch";
  return var_1;
}

function isturret(var_0) {
  return isDefined(var_0.classname) && var_0.classname == "misc_turret";
}

function isdronepackage(var_0) {
  return isDefined(var_0.cratetype);
}

function _enableequipdeployvfx() {
  if(!isDefined(self.enabledequipdeployvfx)) {
    self.enabledequipdeployvfx = 0;
  }

  if(self.enabledequipdeployvfx == 0) {
    self enableequipdeployvfx(1);
  }

  self.enabledequipdeployvfx++;
}

function _disableequipdeployvfx() {
  if(self.enabledequipdeployvfx == 1) {
    self enableequipdeployvfx(0);
  }

  self.enabledequipdeployvfx--;
}

function register_physics_collisions() {
  self endon("death");
  self endon("stop_phys_sounds");

  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    level notify("physSnd", self, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

function global_physics_sound_monitor() {
  level notify("physics_monitor");
  level endon("physics_monitor");

  for(;;) {
    level waittill("physSnd", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(var_0) && isDefined(var_0.phys_sound_func)) {
      level thread[[var_0.phys_sound_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  }
}

function register_physics_collision_func(var_0, var_1) {
  var_0.phys_sound_func = var_1;
}

function istouchingboundstrigger(var_0) {
  return istrue(var_0.alreadytouchingtrigger);
}

function istouchingboundsnullify(var_0) {
  var_1 = 0;

  if(isDefined(level.outofboundstriggerpatches) && level.outofboundstriggerpatches.size > 0) {
    foreach(var_3 in level.outofboundstriggerpatches) {
      if(var_0 istouching(var_3)) {
        var_1 = 1;
        break;
      }
    }
  }

  return var_1;
}

function deleteonplayerdeathdisconnect(var_0) {
  self endon("death");
  var_0 waittill("death_or_disconnect");
  self delete();
}

function deleteatframeend() {
  self endon("death");
  waittillframeend();
  self delete();
}