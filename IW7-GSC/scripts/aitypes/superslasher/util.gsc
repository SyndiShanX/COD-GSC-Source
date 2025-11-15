/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\superslasher\util.gsc
*************************************************/

isonroof() {
  return scripts\aitypes\superslasher\behaviors::superslasher_isonroof();
}

forcestagger(param_00) {
  if(!isDefined(self.var_1198.bstaggerrequested)) {
    self.var_1198.bstaggerrequested = 1;
    if(scripts\aitypes\superslasher\behaviors::superslasher_isonground()) {
      thread queueinterruptible("ground_stagger");
    } else if(isonroof()) {
      thread queueinterruptible("roof_stagger");
    }

    if(param_00) {
      drop_max_ammo();
    }
  }
}

forcetrapped(param_00) {
  if(!isDefined(self.var_1198.btraprequested)) {
    self.var_1198.btraprequested = 1;
    self.var_1198.trapduration = param_00;
    thread queueinterruptible("ground_trapped");
    self.btrophysystem = undefined;
    scripts\aitypes\superslasher\behaviors::shieldcleanup();
  }
}

queueinterruptible(param_00) {
  self notify("queue_interruptible");
  self endon("death");
  self endon("queue_interruptible");
  while(isDefined(self.var_1198.buninterruptibleanim)) {
    wait(0.05);
  }

  scripts\asm\asm::asm_setstate(param_00);
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
    self.var_1198.bgotoroofrequested = 1;
  }
}

requestgotoground() {
  if(scripts\aitypes\superslasher\behaviors::superslasher_isonroof() || scripts\aitypes\superslasher\behaviors::superslasher_isgoingtoroof()) {
    self.var_1198.bgotogroundrequested = 1;
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