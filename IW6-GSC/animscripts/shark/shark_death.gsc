/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\shark\shark_death.gsc
*********************************************/

#using_animtree("animals");

main() {
  self clearanim( % root, 0.2);
  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 setModel(self.model);
  var_0 useanimtree(#animtree);
  var_0 hide();
  self linkto(var_0);
  var_0 find_available_collision_model();

  if(randomintrange(0, 100) < 50) {
    var_1 = % shark_death_1;
    var_2 = % shark_death_loop_1;
    var_3 = % shark_death_settle_1;
  } else {
    var_1 = % shark_death_2;
    var_2 = % shark_death_loop_2;
    var_3 = % shark_death_settle_2;
  }

  self setanimknobrestart(var_1, 1, 0, 1);
  var_4 = getanimlength(var_1);
  playFXOnTag(level._effect["swim_ai_death_blood"], var_0, "j_spineupper");
  var_5 = ["j_tail1", "j_spineupper", "j_tail2", "j_fin_le", "j_fin_ri", "j_head", "j_jaw"];

  foreach(var_7 in var_5) {
  playFXOnTag(level._effect["water_bubbles_wide_sm_lp"], var_0, var_7);
  }

  var_9 = 1;
  var_0 moveto(var_0.origin - (0, 0, 1000), 100, 0, 100);

  while(var_9) {
    var_10 = bullettracepassed(var_0.origin, var_0.origin - (0, 0, 10), 1, self);
    var_11 = bullettracepassed(var_0.origin, var_0.origin - (0, 0, 10), 1, level.player);

    if(!var_10 && !var_11) {
      var_9 = 0;
    }

    wait 0.05;
  }

  self setanimknobrestart(var_3, 1, 0, 1);
  var_0 moveto(var_0.origin - (0, 0, 10), 5, 0, 5);

  foreach(var_7 in var_5) {
    stopFXOnTag(level._effect["water_bubbles_wide_sm_lp"], var_0, var_7);
    wait 0.05;
  }

  wait 50;
  var_0 return_collision_model();
  var_0 delete();
  self delete();
}

find_available_collision_model() {
  if(!isDefined(level.shark_collsions)) {
    return;
  }
  for(var_0 = 0; var_0 < level.shark_collsions.size; var_0++) {
    if(level.shark_collsions[var_0].is_available) {
      level.shark_collsions[var_0].is_available = 0;
      level.shark_collsions[var_0] solid();
      level.shark_collsions[var_0].origin = self.origin;
      level.shark_collsions[var_0].angles = self.angles;
      level.shark_collsions[var_0] linkto(self);
      self.shark_collision_model = level.shark_collsions[var_0];

      foreach(var_2 in level.players) {
      var_2 thread track_collision_with_player(level.shark_collsions[var_0]);
      }

      break;
    }
  }
}

track_collision_with_player(var_0) {
  var_0 endon("released");

  for(;;) {
    if(self istouching(var_0)) {
      var_0 notsolid();
      return;
    }

    wait 0.1;
  }
}

return_collision_model() {
  if(!isDefined(level.shark_collsions) || !isDefined(self.shark_collision_model)) {
    return;
  }
  self.shark_collision_model notify("released");
  self.shark_collision_model unlink();
  self.shark_collision_model notsolid();
  self.shark_collision_model.origin = self.shark_collision_model.original_origin;
  self.shark_collision_model.is_available = 1;
}