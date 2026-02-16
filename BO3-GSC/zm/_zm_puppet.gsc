/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_puppet.gsc
*************************************************/

#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#namespace zm_puppet;

function wait_for_puppet_pickup() {
  self endon("death");
  self.iscurrentlypuppet = 0;
  while(true) {
    if(isDefined(self.ispuppet) && self.ispuppet && !self.iscurrentlypuppet) {
      self notify("stop_zombie_goto_entrance");
      self.iscurrentlypuppet = 1;
    }
    if(!(isDefined(self.ispuppet) && self.ispuppet) && self.iscurrentlypuppet) {
      self.iscurrentlypuppet = 0;
    }
    if(isDefined(self.ispuppet) && self.ispuppet && zm_utility::check_point_in_playable_area(self.origin) && !isDefined(self.completed_emerging_into_playable_area)) {
      self zm_spawner::zombie_complete_emerging_into_playable_area();
      self.barricade_enter = 0;
    }
    player = getplayers()[0];
    if(isDefined(player) && player buttonPressed("")) {
      if(self.iscurrentlypuppet) {
        if(zm_utility::check_point_in_playable_area(self.goalpos) && !zm_utility::check_point_in_playable_area(self.origin)) {
          self.backedupgoal = self.goalpos;
          self thread zm_spawner::zombie_goto_entrance(self.backupnode, 0);
        }
        if(!zm_utility::check_point_in_playable_area(self.goalpos) && isDefined(self.backupnode) && self.goalpos != self.backupnode.origin) {
          self notify("stop_zombie_goto_entrance");
        }
      }
    }
    wait(0.05);
  }
}