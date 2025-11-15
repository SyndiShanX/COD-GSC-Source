/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\archetypes\archassassin_utility.gsc
**********************************************************/

playbodyfx(param_00, param_01) {
  var_02[0][0]["org"] = self gettagorigin("j_spineupper");
  var_02[0][0]["angles"] = self gettagangles("j_spineupper");
  var_02[0][1]["org"] = self gettagorigin("j_spinelower");
  var_02[0][1]["angles"] = self gettagangles("j_spinelower");
  var_02[0][2]["org"] = self gettagorigin("j_head");
  var_02[0][2]["angles"] = self gettagangles("j_head");
  var_02[1][0]["org"] = self gettagorigin("j_knee_ri");
  var_02[1][0]["angles"] = self gettagangles("j_knee_ri");
  var_02[1][1]["org"] = self gettagorigin("j_knee_le");
  var_02[1][1]["angles"] = self gettagangles("j_knee_le");
  var_02[1][2]["org"] = self gettagorigin("j_elbow_ri");
  var_02[1][2]["angles"] = self gettagangles("j_elbow_ri");
  var_02[1][3]["org"] = self gettagorigin("j_elbow_le");
  var_02[1][3]["angles"] = self gettagangles("j_elbow_le");
  var_02[2][0]["org"] = self gettagorigin("j_ankle_le");
  var_02[2][0]["angles"] = self gettagangles("j_ankle_le");
  var_02[2][1]["org"] = self gettagorigin("j_ankle_ri");
  var_02[2][1]["angles"] = self gettagangles("j_ankle_ri");
  var_02[2][2]["org"] = self gettagorigin("j_wrist_le");
  var_02[2][2]["angles"] = self gettagangles("j_wrist_le");
  var_02[2][3]["org"] = self gettagorigin("j_wrist_ri");
  var_02[2][3]["angles"] = self gettagangles("j_wrist_ri");
  var_03 = "bullet_atomizer_impact_npc";
  var_04 = (0, 0, 0);
  if(isDefined(param_01)) {
    var_04 = param_01;
  }

  if(isDefined(param_00)) {
    var_03 = param_00;
  }

  self playSound(var_03);
  foreach(var_06 in var_02) {
    foreach(var_08 in var_06) {
      playFX(level._effect["atomize_body"], var_08["org"] + var_04, anglesToForward(var_08["angles"]));
    }

    wait(0.01);
  }
}