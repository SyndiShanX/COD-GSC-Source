#include maps\mp\_utility;
#include common_scripts\utility;
#include scripts\utility;

h2_friendlyFireCheck(ent, attacker) {
  if(!isDefined(ent.owner))
    return false;

  if(isDefined(level.nukeIncoming))
    return false;

  if(level.teamBased)
    return (ent.owner.team == attacker.team);
  else
    return (ent.owner == attacker);
}

init() {
  level._effect["emp_flash"] = loadfx("fx/explosions/nuke_flash");

  level.teamEMPed["allies"] = false;
  level.teamEMPed["axis"] = false;
  level.empPlayer = undefined;

  if(level.teamBased)
    level thread EMP_TeamTracker();
  else
    level thread EMP_PlayerTracker();

  level.killstreakFuncs["emp_mp"] = ::h2_EMP_Use;

  level thread onPlayerConnect();
}

onPlayerConnect() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", player);
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");

    if((level.teamBased && level.teamEMPed[self.team]) || (!level.teamBased && isDefined(level.empPlayer) && level.empPlayer != self))
      self _setEMPJammed(true);
  }
}

h2_EMP_Use(lifeId, delay) {
  assert(isDefined(self));

  if(!isDefined(delay))
    delay = 1.0;

  myTeam = self.pers["team"];
  otherTeam = level.otherTeam[myTeam];

  if(level.teamBased)
    self thread EMP_JamTeam(otherTeam, 60.0, delay);
  else
    self thread EMP_JamPlayers(self, 60.0, delay);

  self maps\mp\_matchdata::logKillstreakEvent("emp_mp", self.origin);
  self notify("used_emp");

  return true;
}

EMP_JamTeam(teamName, duration, delay) {
  level endon("game_ended");

  assert(teamName == "allies" || teamName == "axis");

  //wait ( delay );
  thread teamPlayerCardSplash("callout_used_emp", self);

  level notify("EMP_JamTeam" + teamName);
  level endon("EMP_JamTeam" + teamName);

  foreach(player in level.players) {
    player playLocalSound("mp_lose_flag");

    if(player.team != teamName) {
      continue;
    }
    if(player _hasPerk("specialty_localjammer"))
      player ClearScrambler();
  }

  _visionsetnaked("coup_sunblind", 0.1);
  thread empEffects();

  wait(0.1);

  // resetting the vision set to the same thing won't normally have an effect.
  // however, if the client receives the previous visionset change in the same packet as this one, // this will force them to lerp from the bright one to the normal one.
  _visionsetnaked("coup_sunblind", 0);
  _visionsetnaked("", 3.0);

  level.teamEMPed[teamName] = true;
  level notify("emp_update");

  level destroyActiveVehicles(self);

  emp_timer(duration);

  level.teamEMPed[teamName] = false;

  foreach(player in level.players) {
    if(player.team != teamName) {
      continue;
    }
    if(player _hasPerk("specialty_localjammer"))
      player MakeScrambler();
  }

  level notify("emp_update");
}

emp_timer(duration) {
  level.empTimeRemaining = duration;

  while(level.empTimeRemaining) {
    wait(1.0);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    level.empTimeRemaining = max(0, level.empTimeRemaining - 1.0);
  }
}

EMP_JamPlayers(owner, duration, delay) {
  level notify("EMP_JamPlayers");
  level endon("EMP_JamPlayers");

  assert(isDefined(owner));

  //wait ( delay );

  foreach(player in level.players) {
    player playLocalSound("mp_lose_flag");

    if(player == owner) {
      continue;
    }
    if(player _hasPerk("specialty_localjammer"))
      player ClearScrambler();
  }

  _visionsetnaked("coup_sunblind", 0.1);
  thread empEffects();

  wait(0.1);

  // resetting the vision set to the same thing won't normally have an effect.
  // however, if the client receives the previous visionset change in the same packet as this one, // this will force them to lerp from the bright one to the normal one.
  _visionsetnaked("coup_sunblind", 0);
  _visionsetnaked("", 3.0);

  level notify("emp_update");

  level.empPlayer = owner;
  level.empPlayer thread empPlayerFFADisconnect();
  level destroyActiveVehicles(owner);

  level notify("emp_update");

  emp_timer(duration);

  foreach(player in level.players) {
    if(player == owner) {
      continue;
    }
    if(player _hasPerk("specialty_localjammer"))
      player MakeScrambler();
  }

  level.empPlayer = undefined;
  level notify("emp_update");
  level notify("emp_ended");
}

empPlayerFFADisconnect() {
  level endon("EMP_JamPlayers");
  level endon("emp_ended");

  self waittill("disconnect");
  level notify("emp_update");
}

empEffects() {
  foreach(player in level.players) {
    playerForward = anglesToForward(player.angles);
    playerForward = (playerForward[0], playerForward[1], 0);
    playerForward = VectorNormalize(playerForward);

    empDistance = 20000;

    empEnt = spawn("script_model", player.origin + (0, 0, 8000) + vector_multiply(playerForward, empDistance));
    empEnt setModel("tag_origin");
    empEnt.angles = empEnt.angles + (270, 0, 0);
    empEnt thread empEffect(player);
  }
}

empEffect(player) {
  player endon("disconnect");

  wait(0.5);
  PlayFXOnTagForClients(level._effect["emp_flash"], self, "tag_origin", player);
}

EMP_TeamTracker() {
  level endon("game_ended");

  for(;;) {
    level waittill_either("joined_team", "emp_update");

    foreach(player in level.players) {
      if(player.team == "spectator") {
        continue;
      }
      player _setEMPJammed(level.teamEMPed[player.team]);
    }
  }
}

EMP_PlayerTracker() {
  level endon("game_ended");

  for(;;) {
    level waittill_either("joined_team", "emp_update");

    foreach(player in level.players) {
      if(player.team == "spectator") {
        continue;
      }
      if(isDefined(level.empPlayer) && level.empPlayer != player)
        player _setEMPJammed(true);
      else
        player _setEMPJammed(false);
    }
  }
}

destroyActiveVehicles(attacker) {
  if(isDefined(attacker)) {
    foreach(heli in level.helis) {
      if(!h2_friendlyFireCheck(heli, attacker))
        radiusDamage(heli.origin, 384, 5000, 5000, attacker);
    }

    foreach(littleBird in level.littleBird) {
      if(!h2_friendlyFireCheck(littleBird, attacker))
        radiusDamage(littleBird.origin, 384, 5000, 5000, attacker);
    }

    foreach(turret in level.turrets) {
      if(!h2_friendlyFireCheck(turret, attacker))
        radiusDamage(turret.origin, 16, 5000, 5000, attacker);
    }

    foreach(rocket in level.rockets) {
      if(!h2_friendlyFireCheck(rocket, attacker))
        rocket notify("death");
    }

    if(level.teamBased) {
      foreach(uav in level.uavModels[level.otherTeam[attacker.team]])
      radiusDamage(uav.origin, 384, 5000, 5000, attacker);
    } else {
      foreach(uav in level.uavModels) {
        if(uav.owner != attacker)
          radiusDamage(uav.origin, 384, 5000, 5000, attacker);
      }
    }

    if(isDefined(level.ac130player) && level.ac130player != attacker)
      radiusDamage(level.ac130.origin + (0, 0, 10), 1000, 5000, 5000, attacker);
  } else {
    foreach(heli in level.helis)
    radiusDamage(heli.origin, 384, 5000, 5000);

    foreach(littleBird in level.littleBird)
    radiusDamage(littleBird.origin, 384, 5000, 5000);

    foreach(turret in level.turrets)
    radiusDamage(turret.origin, 16, 5000, 5000);

    foreach(rocket in level.rockets)
    rocket notify("death");

    if(level.teamBased) {
      foreach(uav in level.uavModels["allies"])
      radiusDamage(uav.origin, 384, 5000, 5000);

      foreach(uav in level.uavModels["axis"])
      radiusDamage(uav.origin, 384, 5000, 5000);
    } else {
      foreach(uav in level.uavModels)
      radiusDamage(uav.origin, 384, 5000, 5000);
    }

    if(isDefined(level.ac130player))
      radiusDamage(level.ac130.planeModel.origin + (0, 0, 10), 1000, 5000, 5000);
  }
}

_setEMPJammed(var_0) {
  if(var_0) {
    if(!self isUsingRemote())
      self setclientomnvar("ui_killstreak_remote", 1);

    self setclientomnvar("ui_hud_emp_artifact", 1);

    self notify("got_emped");
  } else {
    if(!self isUsingRemote())
      self setclientomnvar("ui_killstreak_remote", 0);

    self setclientomnvar("ui_hud_emp_artifact", 0);
  }
}