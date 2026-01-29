/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1351.gsc
**************************************/

#using_animtree("generic_human");

main() {
  level._id_0C59["dead_guy"]["death1"] = % exposed_death_nerve;
  level._id_0C59["dead_guy"]["death2"] = % exposed_death_falltoknees;
  level._id_0C59["dead_guy"]["death3"] = % exposed_death_headtwist;
  level._id_0C59["dead_guy"]["death4"] = % exposed_crouch_death_twist;
  level._id_0C59["dead_guy"]["death5"] = % exposed_crouch_death_fetal;
  level._id_0C59["dead_guy"]["death6"] = % death_sitting_pose_v1;
  level._id_0C59["dead_guy"]["death7"] = % death_sitting_pose_v2;
  level._id_0C59["dead_guy"]["death8"] = % death_pose_on_desk;
  level._id_0C59["dead_guy"]["death9"] = % death_pose_on_window;
  level._id_1245["dead_guy"] = #animtree;
  level._id_4074 = 1;
  var_0 = getdvarint("ragdoll_max_simulating") - 6;

  if(var_0 > 0) {
    level._id_4075 = var_0;
  } else {
    level._id_4075 = 0;

  }
  var_1 = spawnStruct();
  var_1._id_4076 = [];
  common_scripts\utility::run_thread_on_targetname("trigger_body", ::_id_4077, var_1);
  common_scripts\utility::run_thread_on_targetname("dead_body", ::_id_4078, var_1);
}

_id_4077(var_0) {
  self waittill("trigger");
  var_1 = getEntArray(self.target, "targetname");
  common_scripts\utility::array_thread(var_1, ::_id_4078, var_0);
}

_id_4078(var_0) {
  if(!getdvarint("ragdoll_enable") && isDefined(self._id_164F) && self._id_164F == "require_ragdoll") {
    return;
  }
  if(level._id_4075 == 0) {
    return;
  }
  var_1 = undefined;

  if(isDefined(self._id_16A5)) {
    var_1 = self._id_16A5;
  } else {
    level._id_4074++;

    if(level._id_4074 > 3) {
      level._id_4074 = 1;

    }
    var_1 = level._id_4074;
  }

  var_2 = spawn("script_model", (0, 0, 0));
  var_2.origin = self.origin;
  var_2.angles = self.angles;
  var_2._id_1032 = "dead_guy";
  var_2 maps\_utility::_id_2629();
  var_0 _id_407B(var_2);
  var_2[[level._id_4079[var_1]]]();

  if(!isDefined(self._id_407A)) {
    var_3 = bulletTrace(var_2.origin + (0, 0, 5), var_2.origin + (0, 0, -64), 0, undefined);
    var_2.origin = var_3["position"];
  }

  var_2 setflaggedanim("flag", var_2 maps\_utility::_id_1281(self.script_noteworthy), 1, 0, 1);
  var_2 waittillmatch("flag", "end");

  if(!isDefined(self._id_2139)) {
    var_2 startragdoll();
  }
}

_id_407B(var_0) {
  self._id_4076[self._id_4076.size] = var_0;

  if(self._id_4076.size <= level._id_4075) {
    return;
  }
  self._id_4076[0] delete();
  self._id_4076 = common_scripts\utility::array_removeundefined(self._id_4076);
}