/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\sw_blended_linked_traversal.gsc
****************************************************************/

main() {
  self endon("death");
  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  self endon("death");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  var_1 = getent(var_0.script_parameters + "_1", "targetname");
  var_2 = getent(var_0.script_parameters + "_2", "targetname");
  var_3 = 0;
  var_4 = 0;

  if(isDefined(var_1.script_parameters) && var_1.script_parameters == "linkto_cargo") {
    var_2 = var_2 spawn_adjusted_train_node(var_1, var_0);
    var_4 = 1;
  } else if(isDefined(var_2.script_parameters) && var_2.script_parameters == "linkto_cargo") {
    var_1 = var_1 spawn_adjusted_train_node(var_2, var_0);
    var_3 = 1;
  }

  var_5 = var_1 common_scripts\utility::spawn_tag_origin();
  var_5 linkto(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_6 = level.scr_anim["generic"][var_0.script_animation];
  var_7 = getnotetracktimes(var_6, "blend_start")[0] * getanimlength(var_6);
  var_8 = getnotetracktimes(var_6, "blend_stop")[0] * getanimlength(var_6) - var_7;
  var_9 = self.script_forcegoal;
  self.script_forcegoal = 1;
  self linkto(var_5);
  thread traverse_allow_death(var_5);
  var_5 maps\_utility::delaythread(var_7, ::traverse_blend_link, var_1, var_2, var_8);
  self forcedeathfall(1);
  var_5 maps\_anim::anim_single_solo(self, var_0.script_animation, undefined, 0.1, "generic");
  self unlink();
  self forcedeathfall(0);
  wait 0.1;
  self.script_forcegoal = var_9;
  self notify("rt_traverse_done");
  var_5 notify("rt_traverse_done");
  var_5 maps\_utility::anim_stopanimscripted();
  var_5 delete();

  if(var_3)
    var_1 delete();

  if(var_4)
    var_2 delete();
}

traverse_allow_death(var_0) {
  self endon("rt_traverse_done");
  self.allowdeath = 1;
  self waittill("death");
  self unlink();
  var_0 notify("rt_traverse_done");
  var_0 delete();
}

traverse_blend_link(var_0, var_1, var_2) {
  self endon("rt_traverse_done");
  var_3 = 0;
  var_4 = getpartname(var_0.model, 0);

  for(var_5 = getpartname(var_1.model, 0); var_3 < var_2; var_3 = var_3 + 0.05) {
    var_6 = var_3 / var_2;
    var_7 = var_0 gettagangles(var_4);
    var_8 = var_1 gettagangles(var_5);
    var_9 = anglestoaxis(var_7);
    var_10 = anglestoaxis(var_8);
    var_11 = var_10["forward"] * var_6 + var_9["forward"] * (1 - var_6);
    var_12 = var_10["right"] * var_6 + var_9["right"] * (1 - var_6);
    var_13 = var_10["up"] * var_6 + var_9["up"] * (1 - var_6);
    var_14 = axistoangles(var_11, var_12, var_13);
    var_15 = var_0 gettagorigin(var_4);
    var_16 = var_1 gettagorigin(var_5);
    var_17 = var_16 * var_6 + var_15 * (1 - var_6);

    if(var_6 < 0.5)
      self linkto(var_0, var_4, rotatevectorinverted(var_17 - var_15, var_7), var_14 - var_7);
    else
      self linkto(var_1, var_5, rotatevectorinverted(var_17 - var_16, var_8), var_14 - var_8);

    wait 0.05;
  }

  self linkto(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
}

spawn_adjusted_train_node(var_0, var_1) {
  var_2 = vectornormalize(self.origin - var_0.origin);
  var_3 = 1;
  var_4 = undefined;

  switch (var_1.script_nodestate) {
    case "forward":
      var_4 = anglesToForward(level._train.cars[self.script_noteworthy].body.angles);
      break;
    case "right":
      var_4 = anglestoright(level._train.cars[self.script_noteworthy].body.angles);
      break;
    case "left":
      var_4 = anglestoright(level._train.cars[self.script_noteworthy].body.angles) * -1;
      break;
  }

  var_5 = var_4 * var_3;
  var_6 = vectordot(var_2, var_5);
  var_7 = common_scripts\utility::spawn_tag_origin();

  if(var_6 != 0) {
    var_5 = var_4 * var_6;
    var_8 = acos(length(var_5) / var_3);
    var_9 = var_3 * sin(var_8) * (var_6 / var_6);
    var_7.origin = var_7.origin + anglestoright(self.angles) * var_9;
  }

  var_7 linkto(level._train.cars[self.script_noteworthy].body, "j_spineupper");
  return var_7;
}