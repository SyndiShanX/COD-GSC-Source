/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1202.gsc
*********************************************/

main() {
  self setModel("robot_c12_normal_torso");
  self.var_1FEC = "c12";
  self.var_1FA8 = "c12";
  self.voice = "unitednations";
  self give_explosive_touch_on_revived("c12servo");
  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  if(issentient(self)) {
    self func_849A();
    var_0 = [];
    var_0["head"] = spawnStruct();
    var_0["head"].var_B4B8 = 0;
    var_0["head"].partnerheli = [];
    var_0["head"].partnerheli["head"] = spawnStruct();
    var_0["head"].partnerheli["head"].maxhealth = 5000;
    var_0["head"].partnerheli["head"].hitloc = "head";
    var_0["head"].partnerheli["head"].var_4D6F = "J_Neck";
    self func_849B("head", 0, "head", 5000, "head", "J_Neck");
    var_0["right_arm"] = spawnStruct();
    var_0["right_arm"].var_B4B8 = 2000;
    var_0["right_arm"].partnerheli = [];
    var_0["right_arm"].partnerheli["lower"] = spawnStruct();
    var_0["right_arm"].partnerheli["lower"].maxhealth = 1000;
    var_0["right_arm"].partnerheli["lower"].hitloc = "right_arm_lower";
    var_0["right_arm"].partnerheli["lower"].var_4D6F = "J_Clavicle_X_RI";
    var_0["right_arm"].partnerheli["upper"] = spawnStruct();
    var_0["right_arm"].partnerheli["upper"].maxhealth = 1000;
    var_0["right_arm"].partnerheli["upper"].hitloc = "right_arm_upper";
    var_0["right_arm"].partnerheli["upper"].var_4D6F = "J_Clavicle_X_RI";
    self func_849B("right_arm", 2000, "lower", 1000, "right_arm_lower", "J_Clavicle_X_RI", "upper", 1000, "right_arm_upper", "J_Clavicle_X_RI");
    var_0["left_arm"] = spawnStruct();
    var_0["left_arm"].var_B4B8 = 2000;
    var_0["left_arm"].partnerheli = [];
    var_0["left_arm"].partnerheli["lower"] = spawnStruct();
    var_0["left_arm"].partnerheli["lower"].maxhealth = 1000;
    var_0["left_arm"].partnerheli["lower"].hitloc = "left_arm_lower";
    var_0["left_arm"].partnerheli["lower"].var_4D6F = "J_Clavicle_X_LE";
    var_0["left_arm"].partnerheli["upper"] = spawnStruct();
    var_0["left_arm"].partnerheli["upper"].maxhealth = 1000;
    var_0["left_arm"].partnerheli["upper"].hitloc = "left_arm_upper";
    var_0["left_arm"].partnerheli["upper"].var_4D6F = "J_Clavicle_X_LE";
    self func_849B("left_arm", 2000, "lower", 1000, "left_arm_lower", "J_Clavicle_X_LE", "upper", 1000, "left_arm_upper", "J_Clavicle_X_LE");
    var_0["right_leg"] = spawnStruct();
    var_0["right_leg"].var_B4B8 = 2000;
    var_0["right_leg"].partnerheli = [];
    var_0["right_leg"].partnerheli["upper"] = spawnStruct();
    var_0["right_leg"].partnerheli["upper"].maxhealth = 1000;
    var_0["right_leg"].partnerheli["upper"].hitloc = "right_leg_upper";
    var_0["right_leg"].partnerheli["upper"].var_4D6F = "J_HipInner_RI";
    var_0["right_leg"].partnerheli["lower"] = spawnStruct();
    var_0["right_leg"].partnerheli["lower"].maxhealth = 1000;
    var_0["right_leg"].partnerheli["lower"].hitloc = "right_leg_lower";
    var_0["right_leg"].partnerheli["lower"].var_4D6F = "J_HipInner_RI";
    self func_849B("right_leg", 2000, "upper", 1000, "right_leg_upper", "J_HipInner_RI", "lower", 1000, "right_leg_lower", "J_HipInner_RI");
    var_0["left_leg"] = spawnStruct();
    var_0["left_leg"].var_B4B8 = 2000;
    var_0["left_leg"].partnerheli = [];
    var_0["left_leg"].partnerheli["upper"] = spawnStruct();
    var_0["left_leg"].partnerheli["upper"].maxhealth = 1000;
    var_0["left_leg"].partnerheli["upper"].hitloc = "left_leg_upper";
    var_0["left_leg"].partnerheli["upper"].var_4D6F = "J_HipInner_LE";
    var_0["left_leg"].partnerheli["lower"] = spawnStruct();
    var_0["left_leg"].partnerheli["lower"].maxhealth = 1000;
    var_0["left_leg"].partnerheli["lower"].hitloc = "left_leg_lower";
    var_0["left_leg"].partnerheli["lower"].var_4D6F = "J_HipInner_LE";
    self func_849B("left_leg", 2000, "upper", 1000, "left_leg_upper", "J_HipInner_LE", "lower", 1000, "left_leg_lower", "J_HipInner_LE");
    var_0["hip_pack_right"] = spawnStruct();
    var_0["hip_pack_right"].var_B4B8 = 0;
    var_0["hip_pack_right"].partnerheli = [];
    var_0["hip_pack_right"].partnerheli["hip_pack_right"] = spawnStruct();
    var_0["hip_pack_right"].partnerheli["hip_pack_right"].maxhealth = 500;
    var_0["hip_pack_right"].partnerheli["hip_pack_right"].hitloc = "torso_upper";
    var_0["hip_pack_right"].partnerheli["hip_pack_right"].var_4D6F = "J_SpineLowerBottom_RI";
    self func_849B("hip_pack_right", 0, "hip_pack_right", 500, "torso_upper", "J_SpineLowerBottom_RI");
    var_0["hip_pack_left"] = spawnStruct();
    var_0["hip_pack_left"].var_B4B8 = 0;
    var_0["hip_pack_left"].partnerheli = [];
    var_0["hip_pack_left"].partnerheli["hip_pack_left"] = spawnStruct();
    var_0["hip_pack_left"].partnerheli["hip_pack_left"].maxhealth = 500;
    var_0["hip_pack_left"].partnerheli["hip_pack_left"].hitloc = "torso_upper";
    var_0["hip_pack_left"].partnerheli["hip_pack_left"].var_4D6F = "J_SpineLowerBottom_LE";
    self func_849B("hip_pack_left", 0, "hip_pack_left", 500, "torso_upper", "J_SpineLowerBottom_LE");
    var_0["torso"] = spawnStruct();
    var_0["torso"].var_B4B8 = 0;
    var_0["torso"].partnerheli = [];
    var_0["torso"].partnerheli["upper"] = spawnStruct();
    var_0["torso"].partnerheli["upper"].maxhealth = 9999;
    var_0["torso"].partnerheli["upper"].hitloc = "torso_upper";
    var_0["torso"].partnerheli["upper"].var_4D6F = "j_spineupper";
    var_0["torso"].partnerheli["lower"] = spawnStruct();
    var_0["torso"].partnerheli["lower"].maxhealth = 9999;
    var_0["torso"].partnerheli["lower"].hitloc = "torso_lower";
    var_0["torso"].partnerheli["lower"].var_4D6F = "j_mainroot";
    self func_849B("torso", 0, "upper", 9999, "torso_upper", "j_spineupper", "lower", 9999, "torso_lower", "j_mainroot");
    self.var_4D5D = var_0;
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("robot_c12_normal_torso");
}