/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_deadbody.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  level.scr_anim["dead_guy"]["death1"] = % exposed_death_nerve;
  level.scr_anim["dead_guy"]["death2"] = % exposed_death_falltoknees;
  level.scr_anim["dead_guy"]["death3"] = % exposed_death_headtwist;
  level.scr_anim["dead_guy"]["death4"] = % exposed_crouch_death_twist;
  level.scr_anim["dead_guy"]["death5"] = % exposed_crouch_death_fetal;
  level.scr_anim["dead_guy"]["death6"] = % death_sitting_pose_v1;
  level.scr_anim["dead_guy"]["death7"] = % death_sitting_pose_v2;
  level.scr_anim["dead_guy"]["death8"] = % death_pose_on_desk;
  level.scr_anim["dead_guy"]["death9"] = % death_pose_on_window;
  level.scr_animtree["dead_guy"] = #animtree;
  level.dead_body_count = 1;
  var_0 = getdvarint("ragdoll_max_simulating") - 6;

  if(var_0 > 0) {
    level.max_number_of_dead_bodies = var_0;
  }
  else {
    level.max_number_of_dead_bodies = 0;
  }

  var_1 = spawnStruct();
  var_1.bodies = [];
  common_scripts\utility::run_thread_on_targetname("trigger_body", ::trigger_body, var_1);
  common_scripts\utility::run_thread_on_targetname("dead_body", ::spawn_dead_body, var_1);
}

trigger_body(var_0) {
  self waittill("trigger");
  var_1 = getEntArray(self.target, "targetname");
  common_scripts\utility::array_thread(var_1, ::spawn_dead_body, var_0);
}

spawn_dead_body(var_0) {
  if(!getdvarint("ragdoll_enable") && isDefined(self.script_parameters) && self.script_parameters == "require_ragdoll") {
    return;
  }
  if(level.max_number_of_dead_bodies == 0) {
    return;
  }
  var_1 = undefined;

  if(isDefined(self.script_index)) {
    var_1 = self.script_index;
  }
  else {
    level.dead_body_count++;

    if(level.dead_body_count > 3) {
      level.dead_body_count = 1;
    }

    var_1 = level.dead_body_count;
  }

  var_2 = spawn("script_model", (0, 0, 0));
  var_2.origin = self.origin;
  var_2.angles = self.angles;
  var_2.animname = "dead_guy";
  var_2 maps\_utility::assign_animtree();
  var_0 que_body(var_2);
  var_2[[level.scr_deadbody[var_1]]]();

  if(!isDefined(self.script_trace)) {
    var_3 = bulletTrace(var_2.origin + (0, 0, 5), var_2.origin + (0, 0, -64), 0, undefined);
    var_2.origin = var_3["position"];
  }

  var_2 setflaggedanim("flag", var_2 maps\_utility::getanim(self.script_noteworthy), 1, 0, 1);
  var_2 waittillmatch("flag", "end");

  if(!isDefined(self.script_start)) {
    var_2 startragdoll();
  }
}

que_body(var_0) {
  self.bodies[self.bodies.size] = var_0;

  if(self.bodies.size <= level.max_number_of_dead_bodies) {
    return;
  }
  self.bodies[0] delete();
  self.bodies = common_scripts\utility::array_removeundefined(self.bodies);
}