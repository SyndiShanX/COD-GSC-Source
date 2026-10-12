/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perk_mark_targets.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#namespace perk_mark_targets;

function marktarget_init() {}

function marktarget_run(victim, objweapon, smeansofdeath) {
  if(isbulletdamage(smeansofdeath) && isPlayer(victim) && isreallyalive(victim) && victim.team != self.team && isDefined(objweapon) && !objweapon.isalternate) {
    thread marktarget_execute(victim);
  }
}

function marktarget_execute(target) {
  target notify("delayHealing_started");
  target endon("delayHealing_started");
  target.healthregendisabled = 1;
  tagmarkedplayer(target);

  if(isDefined(target)) {
    target removemarkfromtarget();
  }
}

function tagmarkedplayer(target) {
  self endon("death_or_disconnect");
  target endon("death_or_disconnect");
  var_79e98e0273d56283 = 1;

  if(target _hasperk("specialty_frangible_resist")) {
    var_79e98e0273d56283 += getdvarfloat(@ "hash_cfc1f984f402559f", -0.5);
  }

  timemarked = gettime() + 3500 * var_79e98e0273d56283;

  while(gettime() < timemarked) {
    waitframe();
  }
}

function removemarkfromtarget() {
  self.healthregendisabled = undefined;
}