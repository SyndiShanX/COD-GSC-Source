/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\lotus_util.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\shared\ai\systems\fx_character;
#using scripts\shared\array_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#namespace lotus_util;

function function_571c4083(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 5: {
      self thread scene::play("p7_fxanim_cp_lotus_mobile_shops_casino_ext_parts_bundle");
      break;
    }
    case 1: {
      self thread scene::play("p7_fxanim_cp_lotus_mobile_shops_medical_ext_parts_bundle");
      break;
    }
    case 2: {
      self thread scene::play("p7_fxanim_cp_lotus_mobile_shops_merchant_ext_parts_bundle");
      break;
    }
    case 4: {
      self thread scene::play("p7_fxanim_cp_lotus_mobile_shops_restaurant_ext_parts_bundle");
      break;
    }
    case 3: {
      self thread scene::play("p7_fxanim_cp_lotus_mobile_shops_tattoo_ext_parts_bundle");
      break;
    }
  }
}

function function_83b903a6(a_ents) {
  foreach(ent in a_ents) {
    ent linkto(self);
  }
}

function function_84d3f32a() {
  scene::add_scene_func("p7_fxanim_cp_lotus_mobile_shops_casino_ext_parts_bundle", & function_83b903a6);
  scene::add_scene_func("p7_fxanim_cp_lotus_mobile_shops_medical_ext_parts_bundle", & function_83b903a6);
  scene::add_scene_func("p7_fxanim_cp_lotus_mobile_shops_merchant_ext_parts_bundle", & function_83b903a6);
  scene::add_scene_func("p7_fxanim_cp_lotus_mobile_shops_restaurant_ext_parts_bundle", & function_83b903a6);
  scene::add_scene_func("p7_fxanim_cp_lotus_mobile_shops_tattoo_ext_parts_bundle", & function_83b903a6);
}

function function_50d69c96(var_7f004376 = 12) {
  self notify("hash_9e31d48f");
  self endon("hash_9e31d48f");
  self endon("entityshutdown");
  var_4286d30 = self.origin[2];
  self function_5ffdcb9d(var_7f004376);
  while(true) {
    n_z_diff = abs(self.origin[2] - var_4286d30);
    if(n_z_diff > 320) {
      var_4286d30 = self.origin[2];
      self function_5ffdcb9d(var_7f004376);
    }
    wait(0.05);
  }
}

function function_5ffdcb9d(var_7f004376) {
  var_707bc057 = struct::get_array("siege_anim");
  var_62b3e03f = function_eb04522d(self.origin[2], var_707bc057, var_7f004376);
  var_d47b3178 = arraycopy(var_62b3e03f);
  if(isDefined(level.var_707bc057)) {
    var_41cebe05 = arrayintersect(var_62b3e03f, level.var_707bc057);
    var_3b2cf31a = arraycopy(level.var_707bc057);
    foreach(s_crowd in var_41cebe05) {
      arrayremovevalue(var_3b2cf31a, s_crowd);
    }
    foreach(s_crowd in var_3b2cf31a) {
      s_crowd thread scene::stop("cin_lot_03_01_hakim_crowd_new");
      s_crowd.scene_initialized = 0;
      s_crowd.b_play = undefined;
    }
    foreach(var_6b28a522 in var_41cebe05) {
      arrayremovevalue(var_d47b3178, var_6b28a522);
    }
  }
  foreach(s_crowd in var_d47b3178) {
    s_crowd thread scene::play("cin_lot_03_01_hakim_crowd_new");
    s_crowd.b_play = 1;
  }
  level.var_707bc057 = var_62b3e03f;
}

function function_eb04522d(n_z, a_items, n_max = a_items.size) {
  if(n_max > a_items.size) {
    n_max = a_items.size;
  }
  var_932b706d = [];
  var_b9b72b4f = [];
  for(i = 0; i < a_items.size; i++) {
    if(!isDefined(a_items[i])) {
      continue;
    }
    if(isDefined(a_items[i].b_ignore) && a_items[i].b_ignore) {
      continue;
    }
    n_length = abs(n_z - a_items[i].origin[2]);
    if(!isDefined(var_932b706d)) {
      var_932b706d = [];
    } else if(!isarray(var_932b706d)) {
      var_932b706d = array(var_932b706d);
    }
    var_932b706d[var_932b706d.size] = n_length;
    if(!isDefined(var_b9b72b4f)) {
      var_b9b72b4f = [];
    } else if(!isarray(var_b9b72b4f)) {
      var_b9b72b4f = array(var_b9b72b4f);
    }
    var_b9b72b4f[var_b9b72b4f.size] = i;
  }
  while(true) {
    b_change = 0;
    for(i = 0; i < (var_932b706d.size - 1); i++) {
      if(var_932b706d[i] <= (var_932b706d[i + 1])) {
        continue;
      }
      b_change = 1;
      n_length = var_932b706d[i];
      var_932b706d[i] = var_932b706d[i + 1];
      var_932b706d[i + 1] = n_length;
      n_index = var_b9b72b4f[i];
      var_b9b72b4f[i] = var_b9b72b4f[i + 1];
      var_b9b72b4f[i + 1] = n_index;
    }
    if(!b_change) {
      break;
    }
  }
  a_new = [];
  if(var_b9b72b4f.size > 0) {
    for(i = 0; i < n_max; i++) {
      a_new[i] = a_items[var_b9b72b4f[i]];
    }
  }
  return a_new;
}

function function_3e466373(n_local_client, n_val_new, str_name, str_key = "script_label") {
  var_707bc057 = struct::get_array(str_name, str_key);
  if(n_val_new) {
    foreach(s_crowd in var_707bc057) {
      s_crowd.b_ignore = 1;
    }
  } else {
    foreach(s_crowd in var_707bc057) {
      s_crowd.b_ignore = undefined;
    }
  }
  player = getlocalplayer(n_local_client);
  player function_5ffdcb9d();
}

function function_b33fd8cd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
    self.n_fx_id = playfxoncamera(localclientnum, level._effect["player_dust"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
  } else {
    self notify("hash_1f63111d");
    if(isDefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
  }
}

function function_38ad4ef0(localclientnum) {
  self endon("disconnect");
  self endon("entityshutdown");
}

function function_536a14db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    fxclientutils::playfxbundle(localclientnum, self, "c_nrc_robot_grunt_fx_def_1_rogue");
  } else {
    fxclientutils::stopfxbundle(localclientnum, self, "c_nrc_robot_grunt_fx_def_1_rogue");
  }
}

function falling_debris(localclientnum) {
  self notify("hash_626c7e3a");
  self endon("hash_626c7e3a");
  self endon("entityshutdown");
  wait(1);
  var_3bd3acaa = struct::get_array("debris_spawn_point", "targetname");
  a_models = array("p7_ac_unit_large", "p7_barrel_keg_beer_metal_rusty", "p7_barrel_metal_55gal_blue_lt", "p7_barrel_plastic", "p7_barstool_modern_01", "p7_bed_frame_barrack", "p7_box_case_metal_02_large", "p7_bucket_plastic_5_gal_blue", "p7_cabinet_metal_large", "p7_cai_planter_01", "p7_cai_trashcan_metal", "p7_cargo_pallet_02", "p7_copier_plastic_med", "p7_dolly", "p7_sink_ceramic_old_01", "p7_vending_machine_food", "p7_water_heater_tank");
  while(true) {
    foreach(n_index, var_520ab411 in var_3bd3acaa) {
      n_radius = var_520ab411.radius;
      n_x = var_520ab411.origin[0] + (cos(randomintrange(0, 360)) * n_radius);
      n_y = var_520ab411.origin[1] + (sin(randomintrange(0, 360)) * n_radius);
      var_4a6273cc = util::spawn_model(localclientnum, array::random(a_models), (n_x, n_y, var_520ab411.origin[2]), (randomint(360), randomint(360), randomint(360)));
      if(isDefined(var_4a6273cc)) {
        var_4a6273cc thread function_9259cfc(n_index + 1);
      }
      wait(0.05);
    }
    wait(randomfloatrange(1.5, 3));
  }
}

function function_9259cfc(n_index) {
  self endon("death");
  var_99dbd5bf = tracepoint(self.origin, self.origin + (vectorscale((0, 0, -1), 999999)));
  n_distance = distance(self.origin, var_99dbd5bf["position"]);
  n_time = n_distance / 2048;
  if(n_time <= 0) {
    self delete();
    return;
  }
  self thread function_20e0d03e();
  wait(randomfloat(1));
  self moveto(var_99dbd5bf["position"], n_time);
  self waittill("movedone");
  self delete();
}

function function_20e0d03e() {
  self endon("movedone");
  n_rotate = randomint(3);
  n_time = randomintrange(1, 4);
  while(isDefined(self)) {
    switch (n_rotate) {
      case 0: {
        self rotatepitch(360, n_time);
        break;
      }
      case 1: {
        self rotateroll(360, n_time);
        break;
      }
      default: {
        self rotateyaw(360, n_time);
        break;
      }
    }
    wait(n_time - 0.5);
  }
}

function spinning_fan() {
  self notify("stop_spinning");
  self endon("stop_spinning");
  self setscale(1.25);
  n_time = randomintrange(2, 4);
  while(true) {
    self rotatepitch(360, n_time);
    self waittill("rotatedone");
  }
}

function function_ace9894c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_indexes = findvolumedecalindexarray(self.targetname);
  if(newval) {
    foreach(n_index in a_indexes) {
      unhidevolumedecal(n_index);
    }
  } else {
    foreach(n_index in a_indexes) {
      hidevolumedecal(n_index);
    }
  }
}

function postfx_futz(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self postfx::playpostfxbundle("pstfx_dni_screen_futz_short");
  }
}

function function_16e0096d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(newval == 1) {
    wait(0.5);
    self thread postfx::playpostfxbundle("pstfx_dni_screen_futz_short");
    wait(0.25);
    self thread postfx::playpostfxbundle("pstfx_raven_loop");
    wait(0.5);
    self thread postfx::exitpostfxbundle();
  }
}

function function_d823aea7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread postfx::playpostfxbundle("pstfx_frost_loop");
  } else {
    self thread postfx::exitpostfxbundle();
  }
}

function function_344d4c76(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(newval == 1) {
    self thread postfx::playpostfxbundle("pstfx_dni_screen_futz_short");
    wait(0.3);
    self thread postfx::playpostfxbundle("pstfx_tree_loop");
    wait(1.5);
    self thread postfx::playpostfxbundle("pstfx_frost_loop");
  }
}

function function_a53d70f9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    setworldfogactivebank(localclientnum, 2);
    setlitfogbank(localclientnum, -1, 1, -1);
  } else {
    setworldfogactivebank(localclientnum, 1);
    setlitfogbank(localclientnum, -1, 0, -1);
  }
}

function player_frost_breath(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self notify("hash_aac931c8");
    self endon("hash_aac931c8");
    self endon("disconnect");
    self endon("entityshutdown");
    while(true) {
      if(self islocalplayer() && self getlocalclientnumber() === localclientnum) {
        playfxoncamera(localclientnum, level._effect["player_breath"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
      } else {
        util::delay(randomfloatrange(5, 7), undefined, & playfxontag, localclientnum, level._effect["breath_third_person"], self, "j_head");
      }
      wait(randomintrange(5, 7));
    }
  } else {
    self notify("hash_aac931c8");
  }
}

function function_b8a4442e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self notify("hash_dbbbf53a");
    self endon("hash_dbbbf53a");
    self endon("disconnect");
    self endon("entityshutdown");
    while(true) {
      playFXOnTag(localclientnum, level._effect["breath_third_person"], self, "j_head");
      wait(randomintrange(5, 7));
    }
  } else {
    self notify("hash_dbbbf53a");
  }
}