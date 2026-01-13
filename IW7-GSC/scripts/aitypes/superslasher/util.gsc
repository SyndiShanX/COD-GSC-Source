/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\aitypes\superslasher\util.gsc
*************************************************/

isonroof() {
  return scripts\aitypes\superslasher\behaviors::superslasher_isonroof();
}

forcestagger(var_0) {
  if(!isDefined(self._blackboard.bstaggerrequested)) {
    self._blackboard.bstaggerrequested = 1;
    if(scripts\aitypes\superslasher\behaviors::superslasher_isonground()) {
      thread queueinterruptible("ground_stagger");
    } else if(isonroof()) {
      thread queueinterruptible("roof_stagger");
    }

    if(var_0) {
      drop_max_ammo();
    }
  }
}

forcetrapped(var_0) {
  if(!isDefined(self._blackboard.btraprequested)) {
    self._blackboard.btraprequested = 1;
    self._blackboard.trapduration = var_0;
    thread queueinterruptible("ground_trapped");
    self.btrophysystem = undefined;
    scripts\aitypes\superslasher\behaviors::shieldcleanup();
  }
}

queueinterruptible(var_0) {
  self notify("queue_interruptible");
  self endon("death");
  self endon("queue_interruptible");
  while(isDefined(self._blackboard.buninterruptibleanim)) {
    wait(0.05);
  }

  scripts\asm\asm::asm_setstate(var_0);
}

dosawsharks() {
  scripts\asm\superslasher\superslasher_actions::killallsharks(self);
  self notify("kill_sharks");
  scripts\asm\superslasher\superslasher_actions::dosawsharks("ground");
}

requestshockwave() {
  self.bshockwaverequested = 1;
}

requestgotoroof() {
  if(scripts\aitypes\superslasher\behaviors::superslasher_isonground() || scripts\aitypes\superslasher\behaviors::superslasher_isgoingtoground()) {
    self._blackboard.bgotoroofrequested = 1;
  }
}

requestgotoground() {
  if(scripts\aitypes\superslasher\behaviors::superslasher_isonroof() || scripts\aitypes\superslasher\behaviors::superslasher_isgoingtoroof()) {
    self._blackboard.bgotogroundrequested = 1;
  }
}

ongotoroof_init() {
  self.btrophysystem = undefined;
  scripts\aitypes\superslasher\behaviors::shieldcleanup();
}

onroof_init() {}

ongotoground_init() {}

onground_init() {}

drop_max_ammo() {
  scripts\engine\utility::flag_set("force_drop_max_ammo");
}