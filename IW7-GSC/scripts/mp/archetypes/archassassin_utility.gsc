/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\archetypes\archassassin_utility.gsc
**********************************************************/

playbodyfx(var_0, var_1) {
  var_2[0][0]["org"] = self gettagorigin("j_spineupper");
  var_2[0][0]["angles"] = self gettagangles("j_spineupper");
  var_2[0][1]["org"] = self gettagorigin("j_spinelower");
  var_2[0][1]["angles"] = self gettagangles("j_spinelower");
  var_2[0][2]["org"] = self gettagorigin("j_head");
  var_2[0][2]["angles"] = self gettagangles("j_head");
  var_2[1][0]["org"] = self gettagorigin("j_knee_ri");
  var_2[1][0]["angles"] = self gettagangles("j_knee_ri");
  var_2[1][1]["org"] = self gettagorigin("j_knee_le");
  var_2[1][1]["angles"] = self gettagangles("j_knee_le");
  var_2[1][2]["org"] = self gettagorigin("j_elbow_ri");
  var_2[1][2]["angles"] = self gettagangles("j_elbow_ri");
  var_2[1][3]["org"] = self gettagorigin("j_elbow_le");
  var_2[1][3]["angles"] = self gettagangles("j_elbow_le");
  var_2[2][0]["org"] = self gettagorigin("j_ankle_le");
  var_2[2][0]["angles"] = self gettagangles("j_ankle_le");
  var_2[2][1]["org"] = self gettagorigin("j_ankle_ri");
  var_2[2][1]["angles"] = self gettagangles("j_ankle_ri");
  var_2[2][2]["org"] = self gettagorigin("j_wrist_le");
  var_2[2][2]["angles"] = self gettagangles("j_wrist_le");
  var_2[2][3]["org"] = self gettagorigin("j_wrist_ri");
  var_2[2][3]["angles"] = self gettagangles("j_wrist_ri");
  var_3 = "bullet_atomizer_impact_npc";
  var_4 = (0, 0, 0);
  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  if(isDefined(var_0)) {
    var_3 = var_0;
  }

  self playSound(var_3);
  foreach(var_6 in var_2) {
    foreach(var_8 in var_6) {
      playFX(level._effect["atomize_body"], var_8["org"] + var_4, anglesToForward(var_8["angles"]));
    }

    wait(0.01);
  }
}