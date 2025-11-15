/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_frenetic.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\compass;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\mp\mp_frenetic_fx;
#include scripts\mp\mp_frenetic_sound;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\load;

#namespace mp_frenetic;

event_handler[level_init] main(eventstruct) {
  level.var_cfec596d = 828;
  level.var_39b27fbe = -3294;
  level.var_8db9ea19 = 4500;
  level.var_c6129172 = 585;
  level.var_ae8d87c7 = -3316;
  level.var_98c93497 = 585;
  level.var_31be45ec = -3316;
  level.uav_z_offset = 800;
  callback::on_game_playing(&on_game_playing);
  mp_frenetic_fx::main();
  mp_frenetic_sound::main();
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((235.75, 1731.25, 190.5), (249.75, -1743.25, 190.5), (2128, 0, 65), (-128, -704, 191), (936, 552, 193));
  level thread rotate_fans();
  level thread function_2cdcf5c3();
}

rotate_fans() {
  rotate_obj = getEntArray("rotate_model", "targetname");

  if(isDefined(rotate_obj)) {
    for(i = 0; i < rotate_obj.size; i++) {
      rotate_obj[i] thread rotate();
    }
  }
}

rotate() {
  if(!isDefined(self.speed)) {
    self.speed = 0.5;
  }

  while(true) {
    if(self.script_noteworthy == "z") {
      self rotateyaw(360, self.speed);
    } else if(self.script_noteworthy == "x") {
      self rotateroll(360, self.speed);
    } else if(self.script_noteworthy == "y") {
      self rotatepitch(360, self.speed);
    }

    wait self.speed - 0.1;
  }
}

on_game_playing() {
  array::delete_all(getEntArray("sun_block", "targetname"));
  wait getdvarfloat(#"hash_205d729c5c415715", 0.5);

  if(util::isfirstround()) {
    level scene::add_scene_func(#"p8_fxanim_mp_frenetic_flyaway_tarp_bundle", &function_dd64960c, "play");
    level thread scene::play(#"p8_fxanim_mp_frenetic_solar_panels_bundle");
    level thread scene::play(#"p8_fxanim_mp_frenetic_solar_panels_delay_01_bundle");
    level thread scene::play(#"p8_fxanim_mp_frenetic_solar_panels_delay_02_bundle");
    level thread scene::play(#"p8_fxanim_mp_frenetic_solar_panels_delay_03_bundle");
    level thread scene::play(#"p8_fxanim_mp_frenetic_vines_01_bundle");
    level thread scene::play(#"p8_fxanim_mp_frenetic_vines_02_bundle");
    level thread scene::play(#"p8_fxanim_mp_frenetic_vines_03_bundle");
    level thread scene::play(#"p8_fxanim_mp_frenetic_rock_slide_bundle");
    level thread scene::play(#"p8_fxanim_mp_frenetic_flyaway_tarp_bundle");
    return;
  }

  exploder::stop_exploder("fxexp_wind_gust_fast");
  exploder::stop_exploder("fxexp_wind_gust");
  exploder::exploder("fxexp_wind_constant");
}

function_dd64960c(a_ents) {
  if(isDefined(a_ents[#"prop 1"])) {
    var_7425591a = a_ents[#"prop 1"] gettagorigin("tarp_06_jnt") + (0, 0, -8);
    a_ents[#"prop 1"] waittill(#"physics_pulse", #"death");
    physicsexplosionsphere(var_7425591a, 1024, 1, 1);
  }
}

function_2cdcf5c3() {
  if(util::isfirstround()) {
    level thread scene::init(#"p8_fxanim_mp_frenetic_flyaway_tarp_bundle");
    level thread scene::init(#"p8_fxanim_mp_frenetic_solar_panels_bundle");
    level thread scene::init(#"p8_fxanim_mp_frenetic_solar_panels_delay_01_bundle");
    level thread scene::init(#"p8_fxanim_mp_frenetic_solar_panels_delay_02_bundle");
    level thread scene::init(#"p8_fxanim_mp_frenetic_solar_panels_delay_03_bundle");
    level thread scene::init(#"p8_fxanim_mp_frenetic_vines_01_bundle");
    level thread scene::init(#"p8_fxanim_mp_frenetic_vines_02_bundle");
    level thread scene::init(#"p8_fxanim_mp_frenetic_vines_03_bundle");
    return;
  }

  array::thread_all(struct::get_array("p8_fxanim_mp_frenetic_solar_panels_bundle", "scriptbundlename"), &scene::play, #"p8_fxanim_mp_frenetic_solar_panels_idle_bundle");
  array::thread_all(struct::get_array("p8_fxanim_mp_frenetic_solar_panels_delay_01_bundle", "scriptbundlename"), &scene::play, #"p8_fxanim_mp_frenetic_solar_panels_delay_01_idle_bundle");
  array::thread_all(struct::get_array("p8_fxanim_mp_frenetic_solar_panels_delay_02_bundle", "scriptbundlename"), &scene::play, #"p8_fxanim_mp_frenetic_solar_panels_delay_02_idle_bundle");
  array::thread_all(struct::get_array("p8_fxanim_mp_frenetic_solar_panels_delay_03_bundle", "scriptbundlename"), &scene::play, #"p8_fxanim_mp_frenetic_solar_panels_delay_03_idle_bundle");
  level thread scene::skipto_end(#"p8_fxanim_mp_frenetic_vines_01_bundle", undefined, undefined, 1);
  level thread scene::skipto_end(#"p8_fxanim_mp_frenetic_vines_02_bundle", undefined, undefined, 1);
  level thread scene::skipto_end(#"p8_fxanim_mp_frenetic_vines_03_bundle", undefined, undefined, 1);
}