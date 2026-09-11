/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\entity.gsc
***********************************************/

function getaverageorigin(var0) {
  var1 = (0, 0, 0);

  if(!var0.size) {
    return undefined;
  }

  foreach(var3 in var0) {
    var1 += var3.origin;
  }

  var5 = int(var1[0] / var0.size);
  var6 = int(var1[1] / var0.size);
  var7 = int(var1[2] / var0.size);
  var1 = (var5, var6, var7);
  return var1;
}

function touchingbadtrigger() {
  var0 = getEntArray("trigger_hurt", "classname");

  foreach(var2 in var0) {
    if(self istouching(var2)) {
      return true;
    }
  }

  var4 = getEntArray("radiation", "targetname");

  foreach(var2 in var4) {
    if(self istouching(var2)) {
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

  foreach(var1 in level.outofboundstriggers) {
    if(self istouching(var1)) {
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

  foreach(var1 in level.ballallowedtriggers) {
    if(self istouching(var1)) {
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

  foreach(var1 in level.playerallowedtriggers) {
    if(self istouching(var1)) {
      self.allowedintrigger = 1;
      return true;
    }
  }

  return false;
}

function findisfacing(var0, var1, var2) {
  var3 = cos(var2);
  var4 = anglesToForward(var0.angles);
  var5 = var1.origin - var0.origin;
  var4 *= (1, 1, 0);
  var5 *= (1, 1, 0);
  var5 = vectorNormalize(var5);
  var4 = vectorNormalize(var4);
  var6 = vectordot(var5, var4);

  if(var6 >= var3) {
    return 1;
  }

  return 0;
}

function isaiteamparticipant(var0) {
  if(isagent(var0) && var0.agent_teamparticipant == 1) {
    return true;
  }

  if(isbot(var0)) {
    return true;
  }

  return false;
}

function isteamparticipant(var0) {
  if(isaiteamparticipant(var0)) {
    return true;
  }

  if(isPlayer(var0)) {
    return true;
  }

  return false;
}

function isaigameparticipant(var0) {
  if(isagent(var0) && isDefined(var0.agent_gameparticipant) && var0.agent_gameparticipant == 1) {
    return true;
  }

  if(isbot(var0)) {
    return true;
  }

  return false;
}

function isgameparticipant(var0) {
  if(isaigameparticipant(var0)) {
    return true;
  }

  if(isPlayer(var0)) {
    return true;
  }

  return false;
}

function getteamindex(var0) {
  var1 = 0;

  if(level.teambased) {
    switch (var0) {
      case "axis":
        var1 = 1;
        break;
      case "allies":
        var1 = 2;
        break;
    }
  }

  return var1;
}

function isvalidteamtarget(var0, var1, var2) {
  return isDefined(var2.team) && var2.team == var1;
}

function isvalidffatarget(var0, var1, var2) {
  return isDefined(var2.owner) && (!isDefined(var0) || var2.owner != var0);
}

function getlinknamenodes() {
  var0 = [];

  if(isDefined(self.script_linkto)) {
    var1 = strtok(self.script_linkto, " ");

    for(var2 = 0; var2 < var1.size; var2++) {
      var3 = getnode(var1[var2], "script_linkname");

      if(isDefined(var3)) {
        var0 = var3;
      }
    }
  }

  return var0;
}

function getparticipantsinradius(var0, var1, var2, var3) {
  return getentitiesinradius(var0, var1, var2, var3, scripts\engine\trace::create_character_contents());
}

function getentitiesinradius(var0, var1, var2, var3, var4) {
  if(var1 <= 0) {
    return [];
  }

  var5 = undefined;

  if(isDefined(var3)) {
    if(isarray(var3)) {
      var5 = var3;
    } else {
      var5 = [var3];
    }
  }

  var6 = physics_querypoint(var0, var1, var4, var5, "physicsquery_all");
  var7 = [];
  jumpiftrue(isDefined(var2)) LOC_0000007d;

  foreach(var9 in var6) {
    var10 = var9["entity"];

    if(isDefined(var10)) {
      var7 = var10;
    }
  }

  goto LOC_000000ce;
}

function watchentitiesinradius(var0, var1, var2, var3, var4) {
  self endon("disconnect");
  self endon("end_entities_in_radius");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    var5 = undefined;

    if(var4) {
      var5 = scripts\cp\utility\player::getplayersinradius(self.origin, var0);
    } else {
      var5 = getentitiesinradius(self.origin, var0);
    }

    if(var5.size > 0) {
      if(!var3) {
        self notify(var1, var5);
      } else {
        var6 = [];

        foreach(var8 in var5) {
          var9 = self getorigin();
          var10 = scripts\engine\utility::ter_op(var4, var8 getEye(), var8.origin);
          var11 = physics_createcontents(["physicscontents_solid", "physicscontents_structural", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot"]);
          var12 = physics_raycast(var9, var10, var11, undefined, 0, "physicsquery_closest");

          if(var12.size <= 0) {
            var6 = var8;
          }
        }

        self notify(var1, var6);
      }
    }

    wait var2;
  }
}

function cancelentitiesinradius() {
  self notify("end_entities_in_radius");
}

function placeequipmentfailed(var0, var1, var2, var3) {
  self playlocalsound("scavenger_pack_pickup");

  if(istrue(var1)) {
    var4 = undefined;

    if(isDefined(var3)) {
      var4 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var2, self, anglesToForward(var3), anglestoup(var3));
    } else {
      var4 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var2, self);
    }

    triggerfx(var4);
    thread placeequipmentfailedcleanup(var4);
  }

  switch (var0) {
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

function placeequipmentfailedcleanup(var0) {
  wait 2;
  var0 delete();
}

function isspidergrenade(var0) {
  return istrue(var0.isspidergrenade);
}

function issupertrophy(var0) {
  var1 = var0 getentitynumber();

  if(!isDefined(level.supertrophy)) {
    return false;
  }

  if(!isDefined(level.supertrophy.trophies)) {
    return false;
  }

  if(!isDefined(level.supertrophy.trophies[var1])) {
    return false;
  }

  return level.supertrophy.trophies[var1] == var0;
}

function ismicroturret(var0) {
  var1 = var0 getentitynumber();

  if(!isDefined(level.microturrets)) {
    return false;
  }

  if(!isDefined(level.microturrets[var1])) {
    return false;
  }

  return level.microturrets[var1] == var0;
}

function ischoppergunner(var0) {
  if(!isDefined(var0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return 0;
  }

  var1 = var0.streakinfo.streakname == "chopper_gunner";
  return var1;
}

function tutorial_jumpfromplane(var0) {
  if(!isDefined(var0.vehicletype)) {
    return 0;
  }

  var1 = var0.vehicletype == "apache";
  return var1;
}

function issupporthelo(var0) {
  if(!isDefined(var0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return 0;
  }

  var1 = var0.streakinfo.streakname == "chopper_support";
  return var1;
}

function isclusterstrike(var0) {
  if(!isDefined(var0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return 0;
  }

  var1 = var0.streakinfo.streakname == "toma_strike";
  return var1;
}

function isuav(var0) {
  if(!isDefined(var0.streakinfo)) {
    return false;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return false;
  }

  if(var0.streakinfo.streakname == "uav" || var0.streakinfo.streakname == "counter_uav" || var0.streakinfo.streakname == "directional_uav") {
    return true;
  }

  return false;
}

function isgunship(var0) {
  if(!isDefined(var0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return 0;
  }

  var1 = var0.streakinfo.streakname == "gunship";
  return var1;
}

function isradardrone(var0) {
  if(!isDefined(var0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return 0;
  }

  var1 = var0.streakinfo.streakname == "radar_drone_escort" || var0.streakinfo.streakname == "radar_drone_recon";
  return var1;
}

function isscramblerdrone(var0) {
  if(!isDefined(var0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return 0;
  }

  var1 = var0.streakinfo.streakname == "scrambler_drone_guard";
  return var1;
}

function isradarhelicopter(var0) {
  if(!isDefined(var0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return 0;
  }

  var1 = var0.streakinfo.streakname == "radar_drone_overwatch";
  return var1;
}

function isturret(var0) {
  return isDefined(var0.classname) && var0.classname == "misc_turret";
}

function isdronepackage(var0) {
  return isDefined(var0.cratetype);
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
    self waittill("collision", var0, var1, var2, var3, var4, var5, var6, var7);
    level notify("physSnd", self, var0, var1, var2, var3, var4, var5, var6, var7);
  }
}

function global_physics_sound_monitor() {
  level notify("physics_monitor");
  level endon("physics_monitor");

  for(;;) {
    level waittill("physSnd", var0, var1, var2, var3, var4, var5, var6, var7, var8);

    if(isDefined(var0) && isDefined(var0.phys_sound_func)) {
      level thread[[var0.phys_sound_func]](var0, var1, var2, var3, var4, var5, var6, var7, var8);
    }
  }
}

function register_physics_collision_func(var0, var1) {
  var0.phys_sound_func = var1;
}

function istouchingboundstrigger(var0) {
  return istrue(var0.alreadytouchingtrigger);
}

function istouchingboundsnullify(var0) {
  var1 = 0;

  if(isDefined(level.outofboundstriggerpatches) && level.outofboundstriggerpatches.size > 0) {
    foreach(var3 in level.outofboundstriggerpatches) {
      if(var0 istouching(var3)) {
        var1 = 1;
        break;
      }
    }
  }

  return var1;
}

function deleteonplayerdeathdisconnect(var0) {
  self endon("death");
  var0 waittill("death_or_disconnect");
  self delete();
}

function deleteatframeend() {
  self endon("death");
  waittillframeend();
  self delete();
}