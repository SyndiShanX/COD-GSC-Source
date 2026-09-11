/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perk_mark_targets.gsc
**************************************************/

function marktarget_init() {}

function marktarget_run(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\engine\utility::isbulletdamage(var_1) && isPlayer(var_0) && var_0.team != self.team && !var_0 scripts\mp\utility\perk::_hasperk("specialty_empimmune") && !isDefined(var_0.ismarkedtarget)) {
    thread marktarget_execute(var_0);
    return;
  }
}

function marktarget_execute(var_0) {
  var_0.ismarkedtarget = 1;
  var_0.healthregendisabled = 1;
  wait 0.1;
  tagmarkedplayer(var_0);
  wait 0.1;

  if(isDefined(var_0)) {
    removemarkfromtarget(var_0);
    return;
  }
}

function tagmarkedplayer(var_0) {
  self endon("death_or_disconnect");
  var_1 = gettime() + 3500;

  while(isalive(var_0) && gettime() < var_1) {
    wait 1.1;
  }
}

function removemarkfromtarget() {
  self.ismarkedtarget = undefined;
  self.healthregendisabled = undefined;
}