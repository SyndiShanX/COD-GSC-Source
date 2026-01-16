/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ai_rappel.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\utility;
#include animscripts\debug;
#include maps\_anim;
#using_animtree("generic_human");

init_ai_rappel() {
  level.scr_anim["generic"]["rappel_in"] = % ai_rappel_in;
  level.scr_anim["generic"]["rappel"][0] = % ai_rappel_loop_in_place;
  level.scr_anim["generic"]["rappel_out"] = % ai_rappel_out;
  level.rappel_in_anim_length = getanimlength(level.scr_anim["generic"]["rappel_in"]);
  move_delta = getmovedelta(level.scr_anim["generic"]["rappel_in"]);
  move_delta = (0, 0, move_delta[2]);
  level.rappel_in_dist = length(move_delta);
  move_delta = getmovedelta(level.scr_anim["generic"]["rappel_out"]);
  move_delta = (0, 0, move_delta[2]);
  level.rappel_out_dist = length(move_delta);
  level.min_rappel_dist = level.rappel_in_dist + level.rappel_out_dist + 100;
  level.min_rappel_time = 2.0;
  level.rappel_initialized = 1;
}

start_ai_rappel(time_to_rappel, rappel_point_struct, create_rope, delete_rope) {
  self endon("death");

  if(!isDefined(level.rappel_initialized))
    init_ai_rappel();

  assert(isai(self), "start_ai_rappel should only be called on AI.");
  self.a.deathforceragdoll = 1;

  if(isDefined(rappel_point_struct)) {
    if(isstring(rappel_point_struct))
      rappel_start = getstruct(rappel_point_struct, "targetname");
    else
      rappel_start = rappel_point_struct;
  } else
    rappel_start = getstruct(self.target, "targetname");

  assert(isDefined(rappel_start), "No rappel_start struct for rappel is defined.");

  if(!isDefined(rappel_start.angles))
    rappel_start.angles = (0, 0, 0);

  rappel_face_player = 0;

  if(isDefined(rappel_start.target))
    rappel_end = getstruct(rappel_start.target, "targetname");
  else {
    rappel_end_pos = physicstrace(rappel_start.origin, rappel_start.origin - vectorscale((0, 0, 1), 10000.0));
    rappel_end = spawnstruct();
    rappel_end.origin = rappel_end_pos;
    rappel_face_player = 1;
  }

  if(!isDefined(rappel_end.angles)) {
    rappel_end.angles = (0, 0, 0);
    rappel_face_player = 1;
  }

  rappel_calulate_animation_points(rappel_start, rappel_end);

  self thread debug_rappel(rappel_start.origin, rappel_end.origin);

  self forceteleport(rappel_start.origin, rappel_start.angles);
  self thread rappel_handle_ai_death(rappel_start);

  if(is_true(create_rope))
    rappel_handle_rope_creation(rappel_start, rappel_end);

  if(is_true(delete_rope))
    self thread rappel_handle_rope_deletion(rappel_start);

  self.allowdeath = 1;

  if(!isDefined(time_to_rappel)) {
    velocity = vectorscale((0, 0, 1), 200.0);
    dist = distance(self.origin, self.out_point);
    time_to_rappel = dist / length(velocity);

    if(time_to_rappel < level.min_rappel_time)
      time_to_rappel = level.min_rappel_time;
  }

  move_ent = spawn("script_model", self.origin);
  move_ent.angles = self.angles;
  self thread rappel_move_ent_think(move_ent);

  self thread debug_in_position(rappel_end.origin);

  self disableclientlinkto();
  self linkto(move_ent);
  self thread rappel_move_ai_thread(move_ent, rappel_end, time_to_rappel, rappel_face_player);
  self thread anim_generic_loop(self, "rappel");
  self waittill("start_exit");
  self stopanimscripted();
  anim_single(self, "rappel_out", "generic");
  self unlink();
  self.a.deathforceragdoll = 0;
  move_ent delete();
  self notify("rappel_done");
}

rappel_calulate_animation_points(rappel_start, rappel_end) {
  assert(rappel_start.origin[0] == rappel_end.origin[0], "rappel start and end cant be away from each other vertically, their origin[0] value should be the same.");
  assert(distance(rappel_start.origin, rappel_end.origin) >= level.min_rappel_dist, "Minimum distance for rappel is " + level.min_rappel_dist);
  self.out_point = rappel_end.origin + (0, 0, level.rappel_out_dist);
}

rappel_move_ai_thread(move_ent, rappel_end, time_to_rappel, rappel_face_player) {
  self endon("death");

  if(rappel_face_player)
    self thread rappel_face_player(move_ent, time_to_rappel);
  else
    move_ent rotateto(rappel_end.angles, randomfloatrange(1, time_to_rappel));

  move_ent moveto(self.out_point, time_to_rappel, 1, 1);
  move_ent waittill("movedone");
  self notify("start_exit");
}

rappel_face_player(move_ent, time_to_rappel) {
  self endon("death");
  wait(time_to_rappel / 2);
  player = get_closest_player(self.origin);
  angles = vectortoangles(player.origin - self.origin);
  angles = (0, angles[1], 0);
  move_ent rotateto(angles, time_to_rappel / 2);
}

rappel_move_ent_think(move_ent) {
  self endon("rappel_done");
  self waittill("death");
  move_ent delete();
}

rappel_handle_rope_creation(rappel_start, rappel_end) {
  rappel_start.rappel_rope = createrope(rappel_start.origin, rappel_end.origin, distance(rappel_start.origin, rappel_end.origin) * 0.8);
}

rappel_handle_rope_deletion(rappel_start) {
  self waittill_any("death", "rappel_done");

  if(isDefined(rappel_start.rappel_rope)) {
    deleterope(rappel_start.rappel_rope);
    rappel_start.rappel_rope = undefined;
  }
}

rappel_struct_handle_rope_deletion() {
  self endon("rappel_done");
  self waittill("delete_rope");

  if(isDefined(self.rappel_rope)) {
    deleterope(self.rappel_rope);
    self.rappel_rope = undefined;
  }
}

rappel_handle_ai_death(rappel_start) {
  self endon("rappel_done");
  self waittill("stop_rappel");
  self startragdoll();
  self dodamage(self.health, self.origin);

  if(isDefined(rappel_start.rappel_rope)) {
    deleterope(rappel_start.rappel_rope);
    rappel_start.rappel_rope = undefined;
  }
}

debug_rappel(start, end) {
  self endon("death");
  self endon("rappel_done");

  while(true) {
    if(getdvarint(#"_id_83D71FD9")) {
      drawdebugcross(self.out_point, 1, (1, 1, 1), 0.6);
      recordline(start, end, (1, 1, 1), "Script", self);
    }

    wait 0.05;
  }

}

debug_in_position(end) {
  self endon("death");
  self endon("rappel_done");
  pos = self.origin;

  while(true) {
    if(getdvarint(#"_id_83D71FD9")) {
      drawdebugcross(pos, 1, (1, 1, 1), 0.6);
      recordline(pos, end, (0, 1, 0), "Script", self);
    }

    wait 0.05;
  }

}