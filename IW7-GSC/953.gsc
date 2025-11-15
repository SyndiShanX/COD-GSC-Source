/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 953.gsc
************************/

main() {
  self setModel("robot_c6_red_scriptable");
  self.var_1FEC = "c6";
  self.var_1FA8 = "c6";
  self.voice = "c6";
  self give_explosive_touch_on_revived("c6servo");
  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\c6_lochit_dmgtable");
  }

  if(issentient(self)) {
    self _meth_849A();
    var_00 = [];
    var_00["left_arm"] = spawnStruct();
    var_00["left_arm"].var_B4B8 = 90;
    var_00["left_arm"].partnerheli = [];
    var_00["left_arm"].partnerheli["upper"] = spawnStruct();
    var_00["left_arm"].partnerheli["upper"].maxhealth = 30;
    var_00["left_arm"].partnerheli["upper"].hitloc = "left_arm_upper";
    var_00["left_arm"].partnerheli["upper"].var_4D6F = "j_shoulder_le";
    var_00["left_arm"].partnerheli["lower"] = spawnStruct();
    var_00["left_arm"].partnerheli["lower"].maxhealth = 30;
    var_00["left_arm"].partnerheli["lower"].hitloc = "left_arm_lower";
    var_00["left_arm"].partnerheli["lower"].var_4D6F = "j_shoulder_le";
    self _meth_849B("left_arm", 90, "upper", 30, "left_arm_upper", "j_shoulder_le", "lower", 30, "left_arm_lower", "j_shoulder_le");
    var_00["right_arm"] = spawnStruct();
    var_00["right_arm"].var_B4B8 = 90;
    var_00["right_arm"].partnerheli = [];
    var_00["right_arm"].partnerheli["upper"] = spawnStruct();
    var_00["right_arm"].partnerheli["upper"].maxhealth = 30;
    var_00["right_arm"].partnerheli["upper"].hitloc = "right_arm_upper";
    var_00["right_arm"].partnerheli["upper"].var_4D6F = "j_shoulder_ri";
    var_00["right_arm"].partnerheli["lower"] = spawnStruct();
    var_00["right_arm"].partnerheli["lower"].maxhealth = 30;
    var_00["right_arm"].partnerheli["lower"].hitloc = "right_arm_lower";
    var_00["right_arm"].partnerheli["lower"].var_4D6F = "j_shoulder_ri";
    self _meth_849B("right_arm", 90, "upper", 30, "right_arm_upper", "j_shoulder_ri", "lower", 30, "right_arm_lower", "j_shoulder_ri");
    var_00["left_leg"] = spawnStruct();
    var_00["left_leg"].var_B4B8 = 90;
    var_00["left_leg"].partnerheli = [];
    var_00["left_leg"].partnerheli["upper"] = spawnStruct();
    var_00["left_leg"].partnerheli["upper"].maxhealth = 30;
    var_00["left_leg"].partnerheli["upper"].hitloc = "left_leg_upper";
    var_00["left_leg"].partnerheli["upper"].var_4D6F = "j_hip_le";
    var_00["left_leg"].partnerheli["lower"] = spawnStruct();
    var_00["left_leg"].partnerheli["lower"].maxhealth = 30;
    var_00["left_leg"].partnerheli["lower"].hitloc = "left_leg_lower";
    var_00["left_leg"].partnerheli["lower"].var_4D6F = "j_hip_le";
    self _meth_849B("left_leg", 90, "upper", 30, "left_leg_upper", "j_hip_le", "lower", 30, "left_leg_lower", "j_hip_le");
    var_00["right_leg"] = spawnStruct();
    var_00["right_leg"].var_B4B8 = 90;
    var_00["right_leg"].partnerheli = [];
    var_00["right_leg"].partnerheli["upper"] = spawnStruct();
    var_00["right_leg"].partnerheli["upper"].maxhealth = 30;
    var_00["right_leg"].partnerheli["upper"].hitloc = "right_leg_upper";
    var_00["right_leg"].partnerheli["upper"].var_4D6F = "j_hip_ri";
    var_00["right_leg"].partnerheli["lower"] = spawnStruct();
    var_00["right_leg"].partnerheli["lower"].maxhealth = 30;
    var_00["right_leg"].partnerheli["lower"].hitloc = "right_leg_lower";
    var_00["right_leg"].partnerheli["lower"].var_4D6F = "j_hip_ri";
    self _meth_849B("right_leg", 90, "upper", 30, "right_leg_upper", "j_hip_ri", "lower", 30, "right_leg_lower", "j_hip_ri");
    var_00["head"] = spawnStruct();
    var_00["head"].var_B4B8 = 300;
    var_00["head"].partnerheli = [];
    var_00["head"].partnerheli["head"] = spawnStruct();
    var_00["head"].partnerheli["head"].maxhealth = 0;
    var_00["head"].partnerheli["head"].hitloc = "head";
    var_00["head"].partnerheli["head"].var_4D6F = "j_head";
    self _meth_849B("head", 300, "head", 0, "head", "j_head");
    var_00["torso"] = spawnStruct();
    var_00["torso"].var_B4B8 = 0;
    var_00["torso"].partnerheli = [];
    var_00["torso"].partnerheli["upper"] = spawnStruct();
    var_00["torso"].partnerheli["upper"].maxhealth = 100;
    var_00["torso"].partnerheli["upper"].hitloc = "torso_upper";
    var_00["torso"].partnerheli["upper"].var_4D6F = "j_spineupper";
    var_00["torso"].partnerheli["lower"] = spawnStruct();
    var_00["torso"].partnerheli["lower"].maxhealth = 100;
    var_00["torso"].partnerheli["lower"].hitloc = "torso_lower";
    var_00["torso"].partnerheli["lower"].var_4D6F = "j_spinelower";
    self _meth_849B("torso", 0, "upper", 100, "torso_upper", "j_spineupper", "lower", 100, "torso_lower", "j_spinelower");
    self.var_4D5D = var_00;
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("robot_c6_red_scriptable");
}