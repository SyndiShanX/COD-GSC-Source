/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_bm21.gsc
********************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("bm21", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_bm21_mobile", "vehicle_bm21_mobile_dstry");
  precachemodel("projectile_bm21_missile");
  maps\_vehicle::build_deathfx("fx\explosions\small_vehicle_explosion", "tag_fx_tank", "explo_metal_rand", undefined, undefined, undefined, 0);
  maps\_vehicle::build_deathfx("fx\fire\firelp_med_pm", "tag_deathfx", "fire_metal_medium", undefined, undefined, 1, 0);
  maps\_vehicle::build_deathfx("fx\fire\firelp_med_pm", "tag_fx_cab", undefined, undefined, undefined, undefined, 0);
  maps\_vehicle::build_deathfx("fx\explosions\grenadeexp_default", "tag_missile18", "explo_metal_rand", undefined, undefined, undefined, 0.5);
  maps\_vehicle::build_deathfx("fx\explosions\grenadeexp_default", "tag_fx_tank", "explo_metal_rand", undefined, undefined, undefined, 0.8);
  maps\_vehicle::build_deathfx("fx\explosions\grenadeexp_default", "tag_missile14", "explo_metal_rand", undefined, undefined, undefined, 1.0);
  maps\_vehicle::build_deathfx("fx\explosions\grenadeexp_default", "tag_flash", "explo_metal_rand", undefined, undefined, undefined, 1.4);
  maps\_vehicle::build_deathfx("fx\explosions\vehicle_explosion_bm21", undefined, "car_explode", undefined, undefined, undefined, 2.6);
  maps\_vehicle::build_deathfx("fx\explosions\vehicle_explosion_bm21_tires", "tag_deathfx", undefined, undefined, undefined, undefined, 2.6);
  maps\_vehicle::build_deathfx("fx\fire\firelp_med_pm", "tag_fx_tire_right_r", undefined, undefined, undefined, undefined, 2.7);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_drive( % bm21_driving_idle_forward, % bm21_driving_idle_backward, 10);
  var_3 = var_2;
  maps\_vehicle::build_light(var_3, "headlight_bm21_left", "tag_headlight_left", "fx\misc\car_headlight_bm21", "headlights");
  maps\_vehicle::build_light(var_3, "headlight_bm21_right", "tag_headlight_right", "fx\misc\car_headlight_bm21", "headlights");
  maps\_vehicle::build_light(var_3, "parkinglight_bm21_left_f", "tag_parkinglight_left_f", "fx\misc\car_parkinglight_bm21", "headlights");
  maps\_vehicle::build_light(var_3, "parkinglight_bm21_right_f", "tag_parkinglight_right_f", "fx\misc\car_parkinglight_bm21", "headlights");
  maps\_vehicle::build_light(var_3, "taillight_bm21_right", "tag_taillight_right", "fx\misc\car_taillight_bm21", "headlights");
  maps\_vehicle::build_light(var_3, "taillight_bm21_left", "tag_taillight_left", "fx\misc\car_taillight_bm21", "headlights");
  maps\_vehicle::build_light(var_3, "breaklight_bm21_right", "tag_taillight_right", "fx\misc\car_brakelight_bm21", "brakelights");
  maps\_vehicle::build_light(var_3, "breaklight_bm21_left", "tag_taillight_left", "fx\misc\car_brakelight_bm21", "brakelights");
}

init_local() {
  self.missilemodel = "projectile_bm21_missile";
  self.missiletags = [];
  self.missiletags[0] = "tag_missile1";
  self.missiletags[1] = "tag_missile2";
  self.missiletags[2] = "tag_missile3";
  self.missiletags[3] = "tag_missile4";
  self.missiletags[4] = "tag_missile5";
  self.missiletags[5] = "tag_missile6";
  self.missiletags[6] = "tag_missile7";
  self.missiletags[7] = "tag_missile8";
  self.missiletags[8] = "tag_missile9";
  self.missiletags[9] = "tag_missile10";
  self.missiletags[10] = "tag_missile11";
  self.missiletags[11] = "tag_missile12";
  self.missiletags[12] = "tag_missile13";
  self.missiletags[13] = "tag_missile14";
  self.missiletags[14] = "tag_missile15";
  self.missiletags[15] = "tag_missile16";
  self.missiletags[16] = "tag_missile17";
  self.missiletags[17] = "tag_missile18";
  self.missiletags[18] = "tag_missile19";
  self.missiletags[19] = "tag_missile20";
  self.missiletags[20] = "tag_missile21";
  self.missiletags[21] = "tag_missile22";
  self.missiletags[22] = "tag_missile23";
  self.missiletags[23] = "tag_missile24";
  self.missiletags[24] = "tag_missile25";
  self.missiletags[25] = "tag_missile26";
  thread maps\_vehicle_missile::main();
}