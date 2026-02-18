/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_nam_armada.csc
***********************************************/

#using script_13263926d775e7d7;
#using script_140d5347de8af85c;
#using script_280ea497b298d2e;
#using script_38867f943fb86135;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace cp_nam_armada;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  init_clientfields();
  level._effect[# "hash_12368454c367c6fc"] = # "hash_41db1a73a41027b";
  load::main();
  level thread namespace_72b0499b::init_audio();
  util::waitforclient(0);
  level thread function_578ff07e();
  players = getlocalplayers();
  allowactionslotinput(players[0] getlocalclientnumber());
  setDvar(#"hash_3fe46a1700f8faf6", 0.3);
}

function init_clientfields() {
  clientfield::register("toplayer", "pstfx_sprite_rain_loop", 1, 1, "int", &pstfx_sprite_rain_loop, 0, 0);
  clientfield::register("toplayer", "pstfx_slowed", 1, 1, "int", &pstfx_slowed, 0, 0);
  clientfield::register("toplayer", "pstfx_vignette", 1, 1, "int", &pstfx_vignette, 0, 0);
  clientfield::register("vehicle", "bamboo_heli_landing_rain_fx", 1, 1, "int", &bamboo_heli_landing_rain_fx, 0, 0);
  clientfield::register("vehicle", "adler_chopper_mortar_village", 1, 1, "int", &function_8617decb, 0, 0);
  clientfield::register("world", "toggle_dynsignage_mortartown", 1, 1, "int", &toggle_dynsignage_mortartown, 0, 0);
  clientfield::register("toplayer", "ease_to_dialog_dof", 1, 1, "int", &ease_to_dialog_dof, 0, 0);
  clientfield::register("toplayer", "lerp_fov", 1, 3, "int", &lerp_fov, 0, 1);
  clientfield::register("toplayer", "postfx_bundle_explosive_damage", 1, 1, "int", &postfx_bundle_explosive_damage, 0, 0);
  clientfield::register("toplayer", "pstfx_script_vignette", 1, 2, "int", &namespace_f180c0d7::pstfx_script_vignette, 0, 0);
  clientfield::register("toplayer", "forest_pbg_switch", 1, 1, "int", &forest_pbg_switch, 0, 0);
  clientfield::register("world", "toggle_gameplay_character_visibility", 1, 2, "int", &toggle_gameplay_character_visibility, 0, 0);
  clientfield::register("vehicle", "" + # "hash_4ddf67f7aa0f6884", 1, 1, "int", &function_241229f1, 0, 0);
  clientfield::register("vehicle", "" + # "hash_354296015ca81fd", 1, 1, "int", &function_936cacda, 0, 0);
  clientfield::register("toplayer", "" + # "pstfx_teleport", 1, getminbitcountfornum(2), "int", &pstfx_teleport, 0, 0);
  clientfield::register("vehicle", "" + # "hash_2299cc8957801441", 1, 1, "int", &function_ba96d53c, 0, 0);
  clientfield::register("world", "" + # "hash_5a188b1de711e5ca", 1, 1, "int", &function_69d7c128, 0, 0);
  clientfield::register("world", "" + # "hash_7705eee7a483781a", 1, 1, "int", &function_a7313d0d, 0, 0);
  clientfield::register("world", "" + # "hash_4ee03d623b77b0c2", 1, 1, "int", &function_855380ee, 0, 0);
  clientfield::register("world", "" + # "hash_16a1381cc22da440", 1, 1, "int", &function_c10a31d2, 0, 0);
  clientfield::register("world", "" + # "hash_147afd2c82d374fe", 1, 1, "int", &function_9bf56dad, 0, 0);
  clientfield::register("toplayer", "" + # "force_stream_weapons", 1, 2, "int", &force_stream_weapons, 0, 0);
  clientfield::register("toplayer", "" + # "hash_1d5f8429329030", 1, 2, "int", &function_35172364, 0, 0);
  clientfield::register("toplayer", "" + # "hash_4e480e273ade4c04", 1, 2, "int", &function_2dca33ef, 0, 0);
}

function toggle_gameplay_character_visibility(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  waitframe(1);

  if(bwasdemojump == 2) {
    util::function_8eb5d4b0(5000, 6);
    return;
  }

  if(bwasdemojump) {
    util::function_8eb5d4b0(400, 1.5);
    return;
  }

  util::function_21aef83c();
}

function lerp_fov(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {}

function dof_enable_autofocus() {
  self endoncallback(&function_26826144, #"death", #"disable_autofocus");
  self function_9e574055(1);
  self easing::function_136edb11(undefined, 5.6, 1, #"linear");

  while(true) {
    v_eye = self getEye();
    v_fwd = anglesToForward(self getcamangles());
    a_trace = physicstrace(v_eye, v_eye + v_fwd * 1000, (1 * -1, 1 * -1, 1 * -1), (1, 1, 1), self, 1);
    var_a84275e3 = distance(v_eye, a_trace[# "position"] + v_fwd * 1);

    if(var_a84275e3 < 100) {
      self function_9e574055(2);
    } else {
      self function_9e574055(1);
    }

    self function_d7be9a9f(var_a84275e3, 0);
    waitframe(1);
  }
}

function dof_disable_autofocus() {
  self notify(#"disable_autofocus");
}

function function_26826144(str_notify) {
  self function_9e574055(0);
  self function_3c54e2b8(1);
  self function_9ea7b4eb(1);
}

function ease_to_dialog_dof(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self function_9e574055(2);
    self easing::function_b6f1c993(undefined, 60, 1, #"linear");
    self easing::function_136edb11(undefined, 1, 1, #"linear");
    return;
  }

  self easing::function_b6f1c993(undefined, 10000, 2, #"linear");
  self easing::function_136edb11(undefined, 50, 2, #"linear");
}

function bamboo_heli_landing_rain_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_40e9c967 = self util::playFXOnTag(fieldname, level._effect[# "hash_12368454c367c6fc"], self, "tag_origin");
    return;
  }

  stopfx(fieldname, self.var_40e9c967);
}

function function_8617decb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self function_9974c822("cp_nam_armada_helicopter");
    return;
  }

  self function_5dcc74d1("cp_nam_armada_helicopter");
}

function pstfx_sprite_rain_loop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(self postfx::function_556665f2("pstfx_t9_sprite_heli_spray_r")) {
      self postfx::stoppostfxbundle("pstfx_t9_sprite_heli_spray_r");
    }

    self postfx::playpostfxbundle("pstfx_t9_sprite_heli_spray_r");
    return;
  }

  self postfx::exitpostfxbundle("pstfx_t9_sprite_heli_spray_r");
}

function function_578ff07e() {
  while(true) {
    fov = getdvarfloat(#"cg_fov", 60);
    started = 0;

    while(!started) {
      active = getdvarint(#"hash_4fd2de7c0e3c131a", 0);

      if(active) {
        started = 1;
        break;
      }

      waitframe(1);
    }

    players = getlocalplayers();
    players[0] function_49cdf043(fov, 0);
    waitframe(1);
  }
}

function pstfx_slowed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(self postfx::function_556665f2("pstfx_slowed")) {
      self postfx::stoppostfxbundle("pstfx_slowed");
    }

    self postfx::playpostfxbundle("pstfx_slowed");
    self postfx::function_c8b5f318("pstfx_slowed", "Blur", 0.02);
    return;
  }

  self postfx::exitpostfxbundle("pstfx_slowed");
}

function pstfx_vignette(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(self postfx::function_556665f2("pstfx_vignette")) {
      self postfx::stoppostfxbundle("pstfx_vignette");
    }

    self postfx::playpostfxbundle("pstfx_vignette");
    return;
  }

  self postfx::exitpostfxbundle("pstfx_vignette");
}

function postfx_bundle_explosive_damage(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(self postfx::function_556665f2("postfx_bundle_explosive_damage")) {
      self postfx::stoppostfxbundle("postfx_bundle_explosive_damage");
    }

    self postfx::playpostfxbundle("postfx_bundle_explosive_damage");
    return;
  }

  self postfx::exitpostfxbundle("postfx_bundle_explosive_damage");
}

function forest_pbg_switch(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    setexposureactivebank(fieldname, 2);
    setpbgactivebank(fieldname, 2);
    return;
  }

  setexposureactivebank(fieldname, 1);
  setpbgactivebank(fieldname, 1);
}

function function_69d7c128(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    forcestreamxmodel(#"veh_t9_mil_us_air_napalm_strike");
    function_3385d776(#"hash_11fe9ff5e4f2a6cd");
    function_3385d776(#"hash_11fe9cf5e4f2a1b4");
    function_3385d776(#"hash_7b203243ad7d0395");
    function_3385d776(#"hash_7b202f43ad7cfe7c");
    function_3385d776(#"hash_10274f95da53fc32");
    function_3385d776(#"hash_25b41b370890873c");
    function_3385d776(#"hash_53bcdb28dcd612a0");
    function_3385d776(#"hash_7122be00d75afa05");
    function_3385d776(#"hash_4c2c096e23faf610");
    function_3385d776(#"hash_63729dfa8ef2b601");
    function_3385d776(#"hash_4c28e66e23f884c0");
    function_3385d776(#"hash_6e1d6ac6b4311bd1");
    function_3385d776(#"hash_7acf0f22b1fd5f46");
    function_3385d776(#"hash_67b4b0bc7a445a09");
    return;
  }

  stopforcestreamingxmodel(#"veh_t9_mil_us_air_napalm_strike");
  function_c22a1ca2(#"hash_11fe9ff5e4f2a6cd");
  function_c22a1ca2(#"hash_11fe9cf5e4f2a1b4");
  function_c22a1ca2(#"hash_7b203243ad7d0395");
  function_c22a1ca2(#"hash_7b202f43ad7cfe7c");
  function_c22a1ca2(#"hash_10274f95da53fc32");
  function_c22a1ca2(#"hash_25b41b370890873c");
  function_c22a1ca2(#"hash_53bcdb28dcd612a0");
  function_c22a1ca2(#"hash_7122be00d75afa05");
  function_c22a1ca2(#"hash_4c2c096e23faf610");
  function_c22a1ca2(#"hash_63729dfa8ef2b601");
  function_c22a1ca2(#"hash_4c28e66e23f884c0");
  function_c22a1ca2(#"hash_6e1d6ac6b4311bd1");
  function_c22a1ca2(#"hash_7acf0f22b1fd5f46");
  function_c22a1ca2(#"hash_67b4b0bc7a445a09");
}

function function_a7313d0d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel(#"c_t9_cp_usa_hero_adler_head2_vietnam");
    forcestreamxmodel(#"c_t9_cp_usa_hero_adler_infil_vietnam_body");
    return;
  }

  stopforcestreamingxmodel(#"c_t9_cp_usa_hero_adler_head2_vietnam");
  stopforcestreamingxmodel(#"c_t9_cp_usa_hero_adler_infil_vietnam_body");
}

function function_855380ee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel(#"c_t9_cp_usa_hero_adler_head2_vietnam");
    forcestreamxmodel(#"c_t9_cp_usa_hero_adler_infil_vietnam_body");
    forcestreamxmodel(#"c_t9_usa_hero_sims_01_v2_ta_armada_fb");
    forcestreamxmodel(#"usa_navarro_headset_01_clothanim");
    forcestreamxmodel(#"c_t9_usa_chopper_helmet_navaro_01");
    return;
  }

  stopforcestreamingxmodel(#"c_t9_cp_usa_hero_adler_head2_vietnam");
  stopforcestreamingxmodel(#"c_t9_cp_usa_hero_adler_infil_vietnam_body");
  stopforcestreamingxmodel(#"c_t9_usa_hero_sims_01_v2_ta_armada_fb");
  stopforcestreamingxmodel(#"usa_navarro_headset_01_clothanim");
  stopforcestreamingxmodel(#"c_t9_usa_chopper_helmet_navaro_01");
}

function function_c10a31d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    function_3385d776(#"hash_15ef049a313d82ac");
    function_3385d776(#"hash_768b66892fcba96f");
    function_3385d776(#"hash_1165c07d9c9c7e9c");
    function_3385d776(#"hash_2aa3604c6392b2a6");
    function_3385d776(#"hash_5f0091ae3710e9f3");
    function_3385d776(#"hash_58de865168f42aee");
    function_3385d776(#"hash_77c2b6ac52930cb1");
    function_3385d776(#"hash_43d39ce5226b1f8e");
    function_3385d776(#"hash_6c5d1d5d4088c101");
    function_3385d776(#"hash_3b0cd83ac8ad5c56");
    function_3385d776(#"hash_706dd15212939f8d");
    function_3385d776(#"hash_1a4a4a928cfbbb2e");
    function_3385d776(#"hash_6d1a1169ba51609e");
    function_3385d776(#"hash_66ee45514fb3bdc9");
    function_3385d776(#"hash_38d65b6c7dc927c3");
    return;
  }

  function_c22a1ca2(#"hash_15ef049a313d82ac");
  function_c22a1ca2(#"hash_768b66892fcba96f");
  function_c22a1ca2(#"hash_1165c07d9c9c7e9c");
  function_c22a1ca2(#"hash_2aa3604c6392b2a6");
  function_c22a1ca2(#"hash_5f0091ae3710e9f3");
  function_c22a1ca2(#"hash_58de865168f42aee");
  function_c22a1ca2(#"hash_77c2b6ac52930cb1");
  function_c22a1ca2(#"hash_43d39ce5226b1f8e");
  function_c22a1ca2(#"hash_6c5d1d5d4088c101");
  function_c22a1ca2(#"hash_3b0cd83ac8ad5c56");
  function_c22a1ca2(#"hash_706dd15212939f8d");
  function_c22a1ca2(#"hash_1a4a4a928cfbbb2e");
  function_c22a1ca2(#"hash_6d1a1169ba51609e");
  function_c22a1ca2(#"hash_66ee45514fb3bdc9");
  function_c22a1ca2(#"hash_38d65b6c7dc927c3");
}

function function_9bf56dad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    function_3385d776(#"hash_73a93959db93a4cc");
    function_3385d776(#"hash_2e0287f5c8b13f57");
    function_3385d776(#"hash_6ddfd86d840222e7");
    function_3385d776(#"hash_546522712687189f");
    function_3385d776(#"hash_6e5583d35c662b17");
    return;
  }

  function_c22a1ca2(#"hash_73a93959db93a4cc");
  function_c22a1ca2(#"hash_2e0287f5c8b13f57");
  function_c22a1ca2(#"hash_6ddfd86d840222e7");
  function_c22a1ca2(#"hash_546522712687189f");
  function_c22a1ca2(#"hash_6e5583d35c662b17");
}

function function_241229f1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = getlocalplayers()[0];

  if(!isalive(player)) {
    return;
  }

  if(bwastimejump) {
    self setsoundentcontext("plr_vehicle", "driver");
    player playrumblelooponentity(fieldname, #"chopper_gunner_rumble_intro");
    self thread scene::play(#"hash_7dabd48a4919ffbd");
    player codeplaypostfxbundle("pstfx_mp_door_gunner_vignette");
    self setanim(#"hash_30cafb59b2924e48");
    wait getanimlength(#"hash_30cafb59b2924e48");

    if(isDefined(player)) {
      player stoprumble(fieldname, #"chopper_gunner_rumble_intro");
    }

    if(isDefined(self)) {
      self clearanim(#"hash_30cafb59b2924e48", 0.2);
    }

    return;
  }

  if(player function_d2cb869e("pstfx_mp_door_gunner_vignette")) {
    player codestoppostfxbundle("pstfx_mp_door_gunner_vignette");
  }
}

function function_936cacda(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_88f38d6d = util::playFXOnTag(fieldname, #"hash_701a95e763f457a5", self, "tag_body");
    return;
  }

  if(isDefined(self.var_88f38d6d)) {
    stopfx(fieldname, self.var_88f38d6d);
    self.var_88f38d6d = undefined;
  }
}

function pstfx_teleport(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(!self postfx::function_556665f2("pstfx_t9_cp_prisoner_mkultra_white_transition_short")) {
      function_be93487f(fieldname, 8, 0, 1, 0, 0);
      self postfx::playpostfxbundle("pstfx_t9_cp_prisoner_mkultra_white_transition_short");
    }

    return;
  }

  if(bwastimejump == 2) {
    if(!self postfx::function_556665f2("pstfx_t9_cp_prisoner_mkultra_transition_short")) {
      self postfx::playpostfxbundle("pstfx_t9_cp_prisoner_mkultra_transition_short");
    }

    return;
  }

  if(self postfx::function_556665f2("pstfx_t9_cp_prisoner_mkultra_white_transition_short")) {
    function_be93487f(fieldname, 1, 1, 0, 0, 0);
    self postfx::exitpostfxbundle("pstfx_t9_cp_prisoner_mkultra_white_transition_short");
  }

  if(self postfx::function_556665f2("pstfx_t9_cp_prisoner_mkultra_transition_short")) {
    self postfx::exitpostfxbundle("pstfx_t9_cp_prisoner_mkultra_transition_short");
  }
}

function function_ba96d53c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!isDefined(self.var_e7badf37)) {
      self.var_e7badf37 = util::playFXOnTag(fieldname, #"hash_6109cdb6146abcaa", self, "tag_body");
    }

    return;
  }

  if(isDefined(self.var_e7badf37)) {
    stopfx(fieldname, self.var_e7badf37);
    self.var_e7badf37 = undefined;
  }
}

function toggle_dynsignage_mortartown(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_cc46e921 = getdynentarray("dyn_signage");
  var_855e6723 = getEntArray(fieldname, "static_signage", "targetname");

  if(bwasdemojump == 1) {
    foreach(var_a077d41f in var_855e6723) {
      var_a077d41f hide();
    }

    return;
  }

  foreach(var_ccd8cd20 in var_cc46e921) {
    setdynentenabled(var_ccd8cd20, 0);
  }

  foreach(var_a077d41f in var_855e6723) {
    var_a077d41f show();
  }
}

function function_35172364(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (bwasdemojump) {
    case 1:
      level.var_a9e29100 = self function_82f1cbd2();
      break;
    case 2:
      if(isDefined(level.var_a9e29100)) {
        self function_49cdf043(level.var_a9e29100, 0);
        self function_9298adaf(1);
      }

      break;
  }
}

function function_2dca33ef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (bwasdemojump) {
    case 1:
      level.var_244d2f22 = self function_82f1cbd2();
      break;
    case 2:
      if(isDefined(level.var_244d2f22)) {
        self function_49cdf043(level.var_244d2f22, 0);
        self function_9298adaf(2);
      }

      break;
  }
}

function force_stream_weapons(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump <= 0) {
    self util::force_stream_weapons(fieldname);
    return;
  }

  var_4a5fb55d = [];

  switch (bwasdemojump) {
    case 1:
      var_4a5fb55d[var_4a5fb55d.size] = getweapon(#"hash_4ff481a4f55ed901", array("fastreload"));
      var_4a5fb55d[var_4a5fb55d.size] = getweapon(#"pistol_semiauto_t9", array("extclip"));
      var_4a5fb55d[var_4a5fb55d.size] = getweapon(#"lmg_accurate_t9", "grip2");
      var_4a5fb55d[var_4a5fb55d.size] = getweapon(#"lmg_accurate_t9", "acog");
      var_4a5fb55d[var_4a5fb55d.size] = getweapon(#"hash_4ff481a4f55ed901");
      var_4a5fb55d[var_4a5fb55d.size] = getweapon(#"hash_4ff481a4f55ed901", "stalker");
      var_4a5fb55d[var_4a5fb55d.size] = getweapon(#"hash_4ff481a4f55ed901", "extclip");
      var_4a5fb55d[var_4a5fb55d.size] = getweapon(#"tr_precisionsemi_t9", "fastreload");
      var_4a5fb55d[var_4a5fb55d.size] = getweapon(#"tr_precisionsemi_t9", "scope3x");
      break;
    case 2:
      var_4a5fb55d[var_4a5fb55d.size] = getweapon(#"lmg_slowfire_t9");
      var_4a5fb55d[var_4a5fb55d.size] = getweapon(#"pistol_semiauto_t9");
      break;
  }

  self util::force_stream_weapons(fieldname, var_4a5fb55d);
}