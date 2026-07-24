/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1201.gsc
**************************************/

#using_animtree("c8");

main() {
  self setModel("robot_c8_scriptable");
  self._id_1FEC = "c8";
  self._id_1FA8 = "c8";
  self.voice = "unitednations";
  self _meth_82C6("c8servo");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/c8_lochit_dmgtable");
  }

  if(issentient(self)) {
    self _meth_849A();
    var_0 = [];
    var_0["shield_upper"] = spawnStruct();
    var_0["shield_upper"]._id_B4B8 = 9999;
    var_0["shield_upper"].partnerheli = [];
    var_0["shield_upper"].partnerheli["shield"] = spawnStruct();
    var_0["shield_upper"].partnerheli["shield"].maxhealth = 1800;
    var_0["shield_upper"].partnerheli["shield"].hitloc = "armor";
    var_0["shield_upper"].partnerheli["shield"]._id_4D6F = "j_wrist_le";
    self _meth_849B("shield_upper", 9999, "shield", 1800, "armor", "j_wrist_le");
    var_0["shield_lower"] = spawnStruct();
    var_0["shield_lower"]._id_B4B8 = 9999;
    var_0["shield_lower"].partnerheli = [];
    var_0["shield_lower"].partnerheli["shield"] = spawnStruct();
    var_0["shield_lower"].partnerheli["shield"].maxhealth = 1800;
    var_0["shield_lower"].partnerheli["shield"].hitloc = "armor";
    var_0["shield_lower"].partnerheli["shield"]._id_4D6F = "j_wristbtm_le";
    self _meth_849B("shield_lower", 9999, "shield", 1800, "armor", "j_wristbtm_le");
    var_0["right_arm"] = spawnStruct();
    var_0["right_arm"]._id_B4B8 = 9999;
    var_0["right_arm"].partnerheli = [];
    var_0["right_arm"].partnerheli["upper"] = spawnStruct();
    var_0["right_arm"].partnerheli["upper"].maxhealth = 45;
    var_0["right_arm"].partnerheli["upper"].hitloc = "right_arm_upper";
    var_0["right_arm"].partnerheli["upper"]._id_4D6F = "j_shoulder_ri";
    var_0["right_arm"].partnerheli["lower"] = spawnStruct();
    var_0["right_arm"].partnerheli["lower"].maxhealth = 45;
    var_0["right_arm"].partnerheli["lower"].hitloc = "right_arm_lower";
    var_0["right_arm"].partnerheli["lower"]._id_4D6F = "j_elbow_ri";
    self _meth_849B("right_arm", 9999, "upper", 45, "right_arm_upper", "j_shoulder_ri", "lower", 45, "right_arm_lower", "j_elbow_ri");
    var_0["left_arm_upper"] = spawnStruct();
    var_0["left_arm_upper"]._id_B4B8 = 600;
    var_0["left_arm_upper"].partnerheli = [];
    var_0["left_arm_upper"].partnerheli["upper"] = spawnStruct();
    var_0["left_arm_upper"].partnerheli["upper"].maxhealth = 45;
    var_0["left_arm_upper"].partnerheli["upper"].hitloc = "left_arm_upper";
    var_0["left_arm_upper"].partnerheli["upper"]._id_4D6F = "j_shoulder_le";
    self _meth_849B("left_arm_upper", 600, "upper", 45, "left_arm_upper", "j_shoulder_le");
    var_0["left_arm_lower"] = spawnStruct();
    var_0["left_arm_lower"]._id_B4B8 = 600;
    var_0["left_arm_lower"].partnerheli = [];
    var_0["left_arm_lower"].partnerheli["lower"] = spawnStruct();
    var_0["left_arm_lower"].partnerheli["lower"].maxhealth = 45;
    var_0["left_arm_lower"].partnerheli["lower"].hitloc = "left_arm_lower";
    var_0["left_arm_lower"].partnerheli["lower"]._id_4D6F = "j_shoulderbtm_le";
    self _meth_849B("left_arm_lower", 600, "lower", 45, "left_arm_lower", "j_shoulderbtm_le");
    var_0["right_leg"] = spawnStruct();
    var_0["right_leg"]._id_B4B8 = 9999;
    var_0["right_leg"].partnerheli = [];
    var_0["right_leg"].partnerheli["upper"] = spawnStruct();
    var_0["right_leg"].partnerheli["upper"].maxhealth = 60;
    var_0["right_leg"].partnerheli["upper"].hitloc = "right_leg_upper";
    var_0["right_leg"].partnerheli["upper"]._id_4D6F = "j_hip_ri";
    var_0["right_leg"].partnerheli["lower"] = spawnStruct();
    var_0["right_leg"].partnerheli["lower"].maxhealth = 60;
    var_0["right_leg"].partnerheli["lower"].hitloc = "right_leg_lower";
    var_0["right_leg"].partnerheli["lower"]._id_4D6F = "j_knee_ri";
    self _meth_849B("right_leg", 9999, "upper", 60, "right_leg_upper", "j_hip_ri", "lower", 60, "right_leg_lower", "j_knee_ri");
    var_0["left_leg"] = spawnStruct();
    var_0["left_leg"]._id_B4B8 = 9999;
    var_0["left_leg"].partnerheli = [];
    var_0["left_leg"].partnerheli["upper"] = spawnStruct();
    var_0["left_leg"].partnerheli["upper"].maxhealth = 60;
    var_0["left_leg"].partnerheli["upper"].hitloc = "left_leg_upper";
    var_0["left_leg"].partnerheli["upper"]._id_4D6F = "j_hip_le";
    var_0["left_leg"].partnerheli["lower"] = spawnStruct();
    var_0["left_leg"].partnerheli["lower"].maxhealth = 60;
    var_0["left_leg"].partnerheli["lower"].hitloc = "left_leg_lower";
    var_0["left_leg"].partnerheli["lower"]._id_4D6F = "j_knee_le";
    self _meth_849B("left_leg", 9999, "upper", 60, "left_leg_upper", "j_hip_le", "lower", 60, "left_leg_lower", "j_knee_le");
    var_0["head"] = spawnStruct();
    var_0["head"]._id_B4B8 = 2800;
    var_0["head"].partnerheli = [];
    var_0["head"].partnerheli["head"] = spawnStruct();
    var_0["head"].partnerheli["head"].maxhealth = 0;
    var_0["head"].partnerheli["head"].hitloc = "head";
    var_0["head"].partnerheli["head"]._id_4D6F = "j_head";
    self _meth_849B("head", 2800, "head", 0, "head", "j_head");
    var_0["torso"] = spawnStruct();
    var_0["torso"]._id_B4B8 = 9999;
    var_0["torso"].partnerheli = [];
    var_0["torso"].partnerheli["upper"] = spawnStruct();
    var_0["torso"].partnerheli["upper"].maxhealth = 100;
    var_0["torso"].partnerheli["upper"].hitloc = "torso_upper";
    var_0["torso"].partnerheli["upper"]._id_4D6F = "j_spineupper";
    var_0["torso"].partnerheli["lower"] = spawnStruct();
    var_0["torso"].partnerheli["lower"].maxhealth = 100;
    var_0["torso"].partnerheli["lower"].hitloc = "torso_lower";
    var_0["torso"].partnerheli["lower"]._id_4D6F = "j_spinelower";
    self _meth_849B("torso", 9999, "upper", 100, "torso_upper", "j_spineupper", "lower", 100, "torso_lower", "j_spinelower");
    self._id_4D5D = var_0;
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("robot_c8_scriptable");
}