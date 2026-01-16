/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_submarine_sdv.gsc
**********************************************/

main(var_0, var_1, var_2, var_3) {
  if(var_0 == "vehicle_submarine_sdv" || var_0 == "vehicle_mini_sub_iw6")
    maps\_vehicle::build_template("submarine_sdv", var_0, var_1, var_2);
  else
    maps\_vehicle::build_template("blackshadow_730", var_0, var_1, var_2);

  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel(var_0);
  maps\_vehicle::build_life(999, 500, 1500);

  if(var_0 == "vehicle_mini_sub_iw6") {
    maps\_vehicle::build_unload_groups(::unload_groups);
    maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  }

  if(!isDefined(var_3) || !var_3) {
    if(var_0 == "vehicle_mini_sub_iw6")
      maps\_vehicle::build_rumble("subtle_tank_rumble", 0.05, 1.5, 900, 1, 1);
  }

  maps\_vehicle::build_team("allies");
  level._effect["sdv_prop_wash_1"] = loadfx("fx/water/sdv_prop_wash_2");
  level._effect["mini_sub_prop_wash"] = loadfx("vfx/moments/ship_graveyard/mini_sub_propeller_bubbles");
  level._effect["sdv_headlights"] = loadfx("fx/misc/spotlight_submarine_sdv");
}

init_local() {
  maps\_utility::ent_flag_init("moving");
  maps\_utility::ent_flag_init("lights");
  self.light_tag = common_scripts\utility::spawn_tag_origin();
  self.light_tag linkto(self, "TAG_BIG_LIGHT1", (0, 0, 0), (0, 0, 0));

  if(self.model == "vehicle_mini_sub_iw6")
    self.moving_unload = 1;

  thread cleanup_sdv();
  thread handle_move();
  thread handle_lights();
}

handle_move() {
  self endon("sdv_done");
  self endon("death");

  for(;;) {
    maps\_utility::ent_flag_wait("moving");
    thread maps\_utility::play_sound_on_tag("sdv_start", "TAG_PROPELLER");
    maps\_utility::delaythread(1, maps\_utility::play_loop_sound_on_tag, "sdv_move_loop", "TAG_PROPELLER", 1);

    if(self.model == "vehicle_mini_sub_iw6")
      thread mini_sub_prop_wash();
    else
      playFXOnTag(common_scripts\utility::getfx("sdv_prop_wash_1"), self, "TAG_PROPELLER");

    maps\_utility::ent_flag_waitopen("moving");

    if(self.model == "vehicle_mini_sub_iw6")
      thread mini_sub_prop_wash_stop();
    else
      stopFXOnTag(common_scripts\utility::getfx("sdv_prop_wash_1"), self, "TAG_PROPELLER");

    self notify("stop soundsdv_move_loop");
    thread maps\_utility::play_sound_on_tag("sdv_stop", "TAG_PROPELLER");
  }
}

mini_sub_prop_wash() {
  playFXOnTag(common_scripts\utility::getfx("mini_sub_prop_wash"), self, "j_propellerbottom");
  common_scripts\utility::waitframe();
  playFXOnTag(common_scripts\utility::getfx("mini_sub_prop_wash"), self, "j_propeller1_le");
  playFXOnTag(common_scripts\utility::getfx("mini_sub_prop_wash"), self, "j_propeller1_ri");
  common_scripts\utility::waitframe();
}

mini_sub_prop_wash_stop() {
  stopFXOnTag(common_scripts\utility::getfx("mini_sub_prop_wash"), self, "j_propellerbottom");
  common_scripts\utility::waitframe();
  stopFXOnTag(common_scripts\utility::getfx("mini_sub_prop_wash"), self, "j_propeller1_le");
  stopFXOnTag(common_scripts\utility::getfx("mini_sub_prop_wash"), self, "j_propeller1_ri");
  common_scripts\utility::waitframe();
}

cleanup_sdv() {
  common_scripts\utility::waittill_either("sdv_done", "death");
  stopFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self.light_tag, "TAG_ORIGIN");

  if(isDefined(self) && maps\_utility::ent_flag("moving")) {
    stopFXOnTag(common_scripts\utility::getfx("sdv_prop_wash_1"), self, "TAG_PROPELLER");
    self notify("stop soundsdv_move_loop");
  }

  var_0 = self.light_tag;
  wait 0.2;
  var_0 delete();
}

handle_lights() {
  self endon("sdv_done");
  self endon("death");

  for(;;) {
    maps\_utility::ent_flag_wait("lights");
    playFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self.light_tag, "TAG_ORIGIN");
    maps\_utility::ent_flag_waitopen("lights");
    stopFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self.light_tag, "TAG_ORIGIN");
  }
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].idle = % minisub_enemy_idle_r_01;
  var_0[1].idle = % minisub_enemy_idle_r_02;
  var_0[2].idle = % minisub_enemy_idle_r_03;
  var_0[3].idle = % minisub_enemy_idle_l_01;
  var_0[4].idle = % minisub_enemy_idle_l_02;
  var_0[5].idle = % minisub_enemy_idle_l_03;
  var_0[0].sittag = "tag_guy1";
  var_0[1].sittag = "tag_guy2";
  var_0[2].sittag = "tag_guy3";
  var_0[3].sittag = "tag_guy6";
  var_0[4].sittag = "tag_guy5";
  var_0[5].sittag = "tag_guy4";
  var_0[0].getout = % minisub_enemy_dismount_r_01;
  var_0[1].getout = % minisub_enemy_dismount_r_02;
  var_0[2].getout = % minisub_enemy_dismount_r_03;
  var_0[3].getout = % minisub_enemy_dismount_l_01;
  var_0[4].getout = % minisub_enemy_dismount_l_02;
  var_0[5].getout = % minisub_enemy_dismount_l_03;
  var_0[0].getoutstance = "stand";
  var_0[1].getoutstance = "stand";
  var_0[2].getoutstance = "stand";
  var_0[3].getoutstance = "stand";
  var_0[4].getoutstance = "stand";
  var_0[5].getoutstance = "stand";
  return var_0;
}

set_vehicle_anims(var_0) {
  return var_0;
}

unload_groups() {
  var_0["left"] = [];
  var_0["right"] = [];
  var_0["passengers"] = [];
  var_0["default"] = [];
  var_0["right"][var_0["right"].size] = 0;
  var_0["right"][var_0["right"].size] = 1;
  var_0["right"][var_0["right"].size] = 2;
  var_0["left"][var_0["left"].size] = 3;
  var_0["left"][var_0["left"].size] = 4;
  var_0["left"][var_0["left"].size] = 5;
  var_0["passengers"][var_0["passengers"].size] = 0;
  var_0["passengers"][var_0["passengers"].size] = 1;
  var_0["passengers"][var_0["passengers"].size] = 2;
  var_0["passengers"][var_0["passengers"].size] = 3;
  var_0["passengers"][var_0["passengers"].size] = 4;
  var_0["passengers"][var_0["passengers"].size] = 5;
  var_0["default"] = var_0["passengers"];
  return var_0;
}