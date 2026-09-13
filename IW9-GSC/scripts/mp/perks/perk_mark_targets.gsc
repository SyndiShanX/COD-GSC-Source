/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perk_mark_targets.gsc
**************************************************/

marktarget_init() {}

marktarget_run(victim, objweapon, smeansofdeath) {
  if(scripts\engine\utility::isbulletdamage(smeansofdeath) && isPlayer(victim) && scripts\mp\utility\player::isreallyalive(victim) && victim.team != self.team && isDefined(objweapon) && !objweapon.isalternate)
    thread marktarget_execute(victim);
}

marktarget_execute(target) {
  target notify("delayHealing_started");
  target endon("delayHealing_started");
  target.healthregendisabled = 1;
  tagmarkedplayer(target);

  if(isDefined(target))
    target removemarkfromtarget();
}

tagmarkedplayer(target) {
  self endon("death_or_disconnect");
  target endon("death_or_disconnect");
  _id_97384B887AB6A3C0 = gettime() + 3500;

  while(gettime() < _id_97384B887AB6A3C0)
    waitframe();
}

removemarkfromtarget() {
  self.healthregendisabled = undefined;
}