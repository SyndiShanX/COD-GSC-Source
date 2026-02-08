/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_bouncing_betties.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

init_bouncing_betties() {
  level.betty_trigs = getEntArray("trip_betty", "targetname");

  for(i = 0; i < level.betty_trigs.size; i++) {
    level thread betty_think(level.betty_trigs[i]);
  }
}
betty_think(trigger) {
  trigger waittill("trigger");

  tripwire = GetEnt(trigger.target, "targetname");
  betty = GetEnt(tripwire.target, "targetname");
  betty_radius = 90;

  jumpHeight = RandomIntRange(68, 80);
  dropHeight = RandomIntRange(10, 20);

  jumpTime = 0.15;
  dropTime = 0.1;
  clickWaitTime = 0.05;
  radiusMultiplier = 1;
  damageMultiplier = 2;

  iprintln("Click!");

  wait(clickWaitTime);

  playFX(level._effect["betty_groundPop"], betty.origin + (0, 0, 10));

  betty thread betty_rotate();

  betty MoveTo(betty.origin + (0, 0, jumpHeight), jumpTime, 0, jumpTime * 0.5);
  betty waittill("movedone");

  betty MoveTo(betty.origin - (0, 0, dropHeight), dropTime, dropTime * 0.5);
  betty waittill("movedone");

  betty notify("stop_rotate_thread");

  playFX(level._effect["betty_explosion"], betty.origin);

  players = get_players();

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(player GetStance() == "prone") {
      continue;
    }

    if(player IsTouching(trigger)) {
      player DoDamage(player.health + 200, betty.origin);
    } else if(Distance(player.origin, betty.origin) < betty_radius + (betty_radius * radiusMultiplier)) {
      player DoDamage(player.health * damageMultiplier, betty.origin);
    }
  }

  for(i = 0; i < level.betty_trigs.size; i++) {
    otherBetty = level.betty_trigs[i];

    if(!isDefined(otherBetty) || trigger == otherBetty) {
      continue;
    }

    if(Distance2D(betty.origin, otherBetty.origin) <= betty_radius + (betty_radius * radiusMultiplier)) {
      otherBetty thread betty_pop(RandomFloatRange(0.15, 0.25));
    }
  }

  betty Delete();
  tripwire Delete();
  trigger Delete();
}
betty_rotate() {
  self endon("stop_rotate_thread");

  self thread betty_rotate_fx();

  rotateAngles = 360;
  rotateTime = 0.125;

  while(1) {
    self RotateYaw(rotateAngles, rotateTime);
    self waittill("rotatedone");
  }
}
betty_rotate_fx() {
  self endon("stop_rotate_thread");

  fxOrg = spawn("script_model", self.origin);
  fxOrg setModel("tag_origin");

  fxOrg LinkTo(self);

  wait(0.75);

  assertex(isDefined(level._effect["betty_smoketrail"]), "level._effect['betty_smoketrail'] needs to be defined");

  fx = playFXOnTag(level._effect["betty_smoketrail"], fxOrg, "tag_origin");
}
betty_pop(waitTime) {
  if(isDefined(waitTime) && waitTime > 0) {
    wait(waitTime);
  }

  self notify("trigger");
}

betty_think_no_wires(trigger) {
  trigger waittill("trigger");

  jumpHeight = RandomIntRange(68, 80);
  dropHeight = RandomIntRange(10, 20);

  jumpTime = 0.15;
  dropTime = 0.1;
  clickWaitTime = 1.0;
  radiusMultiplier = 1;
  damageMultiplier = 2;

  iprintln("Click!");

  wait(clickWaitTime);

  assertex(isDefined(level._effect["betty_groundPop"]), "level._effect['betty_groundPop'] needs to be defined");

  playFX(level._effect["betty_groundPop"], self.origin + (0, 0, 10));

  self hide();

  fake_betty = spawn("script_model", self.origin);
  fake_betty setModel("viewmodel_usa_bbetty_mine");

  fake_betty thread betty_rotate();

  fake_betty MoveTo(fake_betty.origin + (0, 0, jumpHeight), jumpTime, 0, jumpTime * 0.5);
  fake_betty waittill("movedone");

  fake_betty MoveTo(fake_betty.origin - (0, 0, dropHeight), dropTime, dropTime * 0.5);
  fake_betty waittill("movedone");

  self detonate();

  fake_betty notify("stop_rotate_thread");

  fake_betty Delete();
  trigger delete();
}