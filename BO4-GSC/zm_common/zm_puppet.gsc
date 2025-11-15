/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_puppet.gsc
***********************************************/

#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;

#namespace zm_puppet;

wait_for_puppet_pickup() {
  self endon(#"death");
  self.iscurrentlypuppet = 0;

  while(true) {
    if(isDefined(self.ispuppet) && self.ispuppet && !self.iscurrentlypuppet) {
      self notify(#"stop_zombie_goto_entrance");
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

    if(isDefined(player) && player buttonpressed("<dev string:x38>")) {
      if(self.iscurrentlypuppet) {
        if(zm_utility::check_point_in_playable_area(self.goalpos) && !zm_utility::check_point_in_playable_area(self.origin)) {
          self.backedupgoal = self.goalpos;
        }

        if(!zm_utility::check_point_in_playable_area(self.goalpos) && isDefined(self.backupnode) && self.goalpos != self.backupnode.origin) {
          self notify(#"stop_zombie_goto_entrance");
        }
      }
    }

    waitframe(1);
  }
}

