/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_civilians.gsc
*************************************************/

civilians_init() {
  precache_prop_models();
  precache_civilian_anims();
}

precache_prop_models() {
  precachemodel("com_cellphone_on");
}

#using_animtree("generic_human");

precache_civilian_anims() {
  level.scr_animtree["generic"] = #animtree;
  var_0 = [];
  var_0[0] = 7;
  var_0[1] = 3;
  var_1 = scripts\engine\utility::get_cumulative_weights(var_0);
  level.scr_anim["generic"]["civilian_texting_standing"][0] = % civilian_texting_standing;
  level.scr_anim["generic"]["shipcrib_stand_stationary_talk_idle_01"][0] = % shipcrib_stand_stationary_talk_idle_01;
  level.scr_anim["generic"]["hm_grnd_civ_react01_idle01"][0] = % hm_grnd_civ_react01_idle01;
  level.scr_anim["generic"]["hm_grnd_civ_react01_idle02"][0] = % hm_grnd_civ_react01_idle02;
  level.scr_anim["generic"]["hm_grnd_civ_react01_idle03"][0] = % hm_grnd_civ_react01_idle03;
  level.scr_anim["generic"]["hm_grnd_civ_react01_idle04"][0] = % hm_grnd_civ_react01_idle04;
  level.scr_anim["generic"]["hm_grnd_civ_react01_idle05"][0] = % hm_grnd_civ_react01_idle05;
  level.scr_anim["generic"]["hm_grnd_civ_react01_idle06"][0] = % hm_grnd_civ_react01_idle06;
  level.scr_anim["generic"]["hm_grnd_civ_react01_idle07"][0] = % hm_grnd_civ_react01_idle07;
  level.scr_anim["generic"]["hm_grnd_civ_react02_idle01"][0] = % hm_grnd_civ_react02_idle01;
  level.scr_anim["generic"]["hm_grnd_civ_react02_idle02"][0] = % hm_grnd_civ_react02_idle02;
  level.scr_anim["generic"]["hm_grnd_civ_react02_idle03"][0] = % hm_grnd_civ_react02_idle03;
  level.scr_anim["generic"]["hm_grnd_civ_react02_idle04"][0] = % hm_grnd_civ_react02_idle04;
  level.scr_anim["generic"]["hm_grnd_civ_react02_idle05"][0] = % hm_grnd_civ_react02_idle05;
  level.scr_anim["generic"]["hm_grnd_civ_react02_idle06"][0] = % hm_grnd_civ_react02_idle06;
  level.scr_anim["generic"]["hm_grnd_civ_react02_idle07"][0] = % hm_grnd_civ_react02_idle07;
  level.scr_anim["generic"]["shipcrib_stand_idle01_vig_01"][0] = % shipcrib_stand_idle01_vig_01;
  level.scr_anim["generic"]["shipcrib_stand_idle01_vig_02"][0] = % shipcrib_stand_idle01_vig_02;
  level.scr_anim["generic"]["shipcrib_stand_idle01_vig_03"][0] = % shipcrib_stand_idle01_vig_03;
  level.scr_anim["generic"]["shipcrib_stand_idle01_vig_04"][0] = % shipcrib_stand_idle01_vig_04;
  level.scr_anim["generic"]["shipcrib_stand_idle02_vig_01"][0] = % shipcrib_stand_idle02_vig_01;
  level.scr_anim["generic"]["shipcrib_stand_idle02_vig_02"][0] = % shipcrib_stand_idle02_vig_02;
  level.scr_anim["generic"]["shipcrib_stand_idle02_vig_03"][0] = % shipcrib_stand_idle02_vig_03;
  level.scr_anim["generic"]["shipcrib_stand_idle02_vig_04"][0] = % shipcrib_stand_idle02_vig_04;
  level.scr_anim["generic"]["civ_cctv_cover_left_crouch_hide_idle01"][0] = % civ_cctv_cover_left_crouch_hide_idle01;
  level.scr_anim["generic"]["civ_cctv_cover_right_crouch_hide_idle01"][0] = % civ_cctv_cover_right_crouch_hide_idle01;
  level.scr_anim["generic"]["civ_cctv_exposed_crouch_hide_idle01"][0] = % civ_cctv_exposed_crouch_hide_idle01;
  level.scr_anim["generic"]["civ_stl_cover_left_crouch_hide_idle01"][0] = % civ_stl_cover_left_crouch_hide_idle01;
  level.scr_anim["generic"]["civ_stl_cover_right_crouch_hide_idle01"][0] = % civ_stl_cover_right_crouch_hide_idle01;
  level.scr_anim["generic"]["civ_stl_exposed_crouch_hide_idle01"][0] = % civ_stl_exposed_crouch_hide_idle01;
  level.scr_anim["generic"]["civ_cctv_cover_left_crouch_hide_idle02"][0] = % civ_cctv_cover_left_crouch_hide_idle02;
  level.scr_anim["generic"]["civ_cctv_cover_right_crouch_hide_idle02"][0] = % civ_cctv_cover_right_crouch_hide_idle02;
  level.scr_anim["generic"]["civ_cctv_exposed_crouch_hide_idle02"][0] = % civ_cctv_exposed_crouch_hide_idle02;
  level.scr_anim["generic"]["civ_stl_cover_left_crouch_hide_idle02"][0] = % civ_stl_cover_left_crouch_hide_idle02;
  level.scr_anim["generic"]["civ_stl_cover_right_crouch_hide_idle02"][0] = % civ_stl_cover_right_crouch_hide_idle02;
  level.scr_anim["generic"]["civ_stl_exposed_crouch_hide_idle02"][0] = % civ_stl_exposed_crouch_hide_idle02;
  level.scr_anim["generic"]["civ_cctv_cover_left_crouch_hide_idle03"][0] = % civ_cctv_cover_left_crouch_hide_idle03;
  level.scr_anim["generic"]["civ_cctv_cover_right_crouch_hide_idle03"][0] = % civ_cctv_cover_right_crouch_hide_idle03;
  level.scr_anim["generic"]["civ_cctv_exposed_crouch_hide_idle03"][0] = % civ_cctv_exposed_crouch_hide_idle03;
  level.scr_anim["generic"]["civ_stl_cover_left_crouch_hide_idle03"][0] = % civ_stl_cover_left_crouch_hide_idle03;
  level.scr_anim["generic"]["civ_stl_cover_right_crouch_hide_idle03"][0] = % civ_stl_cover_right_crouch_hide_idle03;
  level.scr_anim["generic"]["civ_stl_exposed_crouch_hide_idle03"][0] = % civ_stl_exposed_crouch_hide_idle03;
}

init_civilian_props() {
  anim.civilian_props = [];
  anim.civilian_props["civilian_texting_standing"] = "com_cellphone_on";
}

populate_civilians(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 0;

  var_5 = getspawner(var_0, "targetname");
  var_6 = scripts\engine\utility::getStructArray(var_1, "targetname");
  var_7 = [];

  foreach(var_9 in var_6) {
    if(var_2)
      var_10 = var_5 scripts\engine\sp\utility::dronespawn();
    else
      var_10 = var_5 scripts\engine\sp\utility::spawn_ai();

    var_7 = scripts\engine\utility::array_add(var_7, var_10);
    var_5.count = 1;

    if(var_2) {
      var_10.origin = var_9.origin;
      var_10.angles = var_9.angles;
    } else
      var_10 forceteleport(var_9.origin, var_9.angles);

    if(isDefined(var_9.script_noteworthy))
      var_10.script_noteworthy = var_9.script_noteworthy;

    wait 0.05;

    if(var_3) {
      var_10 thread looping_idle_animation(var_9);
      continue;
    }

    var_10 thread single_animation(var_9, var_4);
  }

  return var_7;
}

looping_idle_animation(var_0) {
  self.animname = "generic";
  var_1 = var_0.animation;
  var_0 thread scripts\common\anim::anim_generic_loop(self, var_1);
  var_2 = attach_props(var_1);
  self waittill("death");

  if(isDefined(var_2))
    var_2 delete();
}

single_animation(var_0, var_1) {
  self.animname = "generic";
  var_2 = var_0.animation;
  var_3 = attach_props(var_2);

  if(var_1 == 1) {
    var_0 scripts\common\anim::anim_generic(self, var_2);

    if(isDefined(var_3))
      var_3 delete();

    self delete();
  } else {
    var_0 thread scripts\common\anim::anim_generic(self, var_2);
    self waittill("death");

    if(isDefined(var_3))
      var_3 delete();
  }
}

attach_props(var_0) {
  if(isDefined(self.has_attached_props)) {
    return;
  }
  init_civilian_props();
  var_1 = anim.civilian_props[var_0];

  if(isDefined(var_1)) {
    var_2 = self attach(var_1, "tag_inhand", 1);
    self.has_attached_props = 1;
    return var_2;
  }
}