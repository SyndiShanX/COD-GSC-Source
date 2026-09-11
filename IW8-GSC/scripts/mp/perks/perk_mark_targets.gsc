/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perk_mark_targets.gsc
**************************************************/

function marktarget_init() {}

function marktarget_run(var0, var1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\engine\utility::isbulletdamage(var1) && isPlayer(var0) && var0.team != self.team && !var0 scripts\mp\utility\perk::_hasperk("specialty_empimmune") && !isDefined(var0.ismarkedtarget)) {
    thread marktarget_execute(var0);
    return;
  }
}

function marktarget_execute(var0) {
  var0.ismarkedtarget = 1;
  var0.healthregendisabled = 1;
  wait 0.1;
  tagmarkedplayer(var0);
  wait 0.1;

  if(isDefined(var0)) {
    removemarkfromtarget(var0);
    return;
  }
}

function tagmarkedplayer(var0) {
  self endon("death_or_disconnect");
  var1 = gettime() + 3500;

  while(isalive(var0) && gettime() < var1) {
    wait 1.1;
  }
}

function removemarkfromtarget() {
  self.ismarkedtarget = undefined;
  self.healthregendisabled = undefined;
}