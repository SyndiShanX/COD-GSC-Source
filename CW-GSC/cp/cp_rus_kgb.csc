/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_rus_kgb.csc
***********************************************/

#using script_38867f943fb86135;
#using script_6f47ce61add0f75d;
#using script_7198e82f67d7691;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\flashlight;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace cp_rus_kgb;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  init_clientfields();
  load::main();
  util::waitforclient(0);
}

function init_clientfields() {
  clientfield::register("toplayer", "set_player_pbg_bank", 1, 2, "int", &set_player_pbg_bank, 0, 0);
  clientfield::register("actor", "set_flashlight_fx", 1, 1, "int", &set_flashlight_fx, 0, 0);
  clientfield::register("actor", "set_flashlight_gun_tag", 1, 1, "int", &set_flashlight_gun_tag, 0, 0);
  clientfield::register("scriptmover", "set_camera_fx", 1, 1, "int", &set_camera_fx, 0, 0);
  clientfield::register("scriptmover", "vault_torch_vfx", 1, 1, "int", &vault_torch_vfx, 0, 0);
  evidence_board_mission_preview::register();
  clientfield::register("toplayer", "set_fov", 1, 3, "int", &set_fov, 0, 0);
  clientfield::register("toplayer", "set_dof", 1, 3, "int", &set_dof, 0, 0);
  clientfield::register("world", "elevator_hall_dmg_models_and_vol_decals", 1, 1, "int", &function_a61974ab, 0, 1);
  clientfield::register("world", "break_c4_explosion_dynents", 1, 1, "int", &break_c4_explosion_dynents, 0, 1);
  clientfield::register("world", "exfil_cover_models", 1, 1, "int", &function_79ff9f83, 0, 1);
  clientfield::register("world", "vault_breach_dmg_models_and_vol_decals", 1, 1, "int", &function_d1d32f56, 0, 1);
  clientfield::register("scriptmover", "vault_hanging_light_vfx", 1, 1, "int", &vault_hanging_light_vfx, 0, 0);
  clientfield::register("scriptmover", "vault_hanging_light_flicker_vfx", 1, 1, "int", &vault_hanging_light_flicker_vfx, 0, 0);
  clientfield::register("world", "vault_explosion_dynents", 1, 1, "int", &vault_explosion_dynents, 0, 1);
  clientfield::register("scriptmover", "clf_fx_c4_on", 1, 1, "int", &function_12315dac, 0, 0);
  clientfield::register("scriptmover", "clf_fx_c4_blink", 1, 1, "int", &function_f8229597, 0, 0);
  clientfield::register("toplayer", "gasmask_clf", 1, 1, "int", &function_e067b5e6, 0, 0);
  clientfield::register("toplayer", "exfilmask_clf", 1, 1, "int", &function_4479bcfe, 0, 0);
  clientfield::register("toplayer", "stream_belikov_rv_assets", 1, 1, "int", &stream_belikov_rv_assets, 0, 0);
  clientfield::register("toplayer", "stream_elevator_exfil_assets", 1, 1, "int", &stream_elevator_exfil_assets, 0, 0);
  clientfield::register("toplayer", "stream_deploy_gas_assets", 1, 1, "int", &stream_deploy_gas_assets, 0, 0);
  clientfield::register("toplayer", "stream_adler_assault_assets", 1, 1, "int", &stream_adler_assault_assets, 0, 0);
  clientfield::register("scriptmover", "slide_projector_anim", 1, 1, "int", &function_cad5695c, 0, 0);
  clientfield::register("world", "toggle_occluder", 1, 1, "int", &toggle_occluder, 0, 1);
}

function function_a61974ab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_n_decals = findvolumedecalindexarray("elevator_hall_dmg_vol_decals");
  var_648616bf = findstaticmodelindexarray("elevator_hall_dmg_models");
  elevator_hall_clean_models = findstaticmodelindexarray("elevator_hall_clean_models");

  switch (bwastimejump) {
    case 0:
      foreach(model in elevator_hall_clean_models) {
        unhidestaticmodel(model);
      }

      foreach(n_decal in a_n_decals) {
        hidevolumedecal(n_decal);
      }

      foreach(model in var_648616bf) {
        hidestaticmodel(model);
      }

      break;
    case 1:
      foreach(model in elevator_hall_clean_models) {
        hidestaticmodel(model);
      }

      foreach(model in var_648616bf) {
        unhidestaticmodel(model);
      }

      foreach(n_decal in a_n_decals) {
        unhidevolumedecal(n_decal);
      }

      break;
    default:
      break;
  }
}

function break_c4_explosion_dynents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 1:
      struct = struct::get("exfil_escape_elevator_explosion_org", "targetname");
      physicsexplosionsphere(fieldname, struct.origin, 400, 0, 1, 300, 200, 1, 1);
      var_5ff9756e = struct::get_array("exfil_escape_elevator_light_post_explosion_org", "targetname");

      foreach(org in var_5ff9756e) {
        physicsexplosionsphere(fieldname, org.origin, 200, 0, 1, 100, 50, 1, 1);
      }

      break;
    default:
      break;
  }
}

function function_d1d32f56(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_689aebca = findstaticmodelindexarray("vault_breach_undamaged_models");
  a_n_decals = findvolumedecalindexarray("vault_breach_dmg_vol_decals");
  var_648616bf = findstaticmodelindexarray("vault_breach_dmg_models");

  switch (bwastimejump) {
    case 0:
      foreach(n_decal in a_n_decals) {
        hidevolumedecal(n_decal);
      }

      foreach(model in var_648616bf) {
        hidestaticmodel(model);
      }

      foreach(model in var_689aebca) {
        unhidestaticmodel(model);
      }

      break;
    case 1:
      foreach(n_decal in a_n_decals) {
        unhidevolumedecal(n_decal);
      }

      foreach(model in var_648616bf) {
        unhidestaticmodel(model);
      }

      foreach(model in var_689aebca) {
        hidestaticmodel(model);
      }

      break;
    default:
      break;
  }
}

function function_79ff9f83(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_648616bf = findstaticmodelindexarray("exfil_cover_models");
  var_1fb7432d = findstaticmodelindexarray("exfil_cover_models_og");

  switch (bwastimejump) {
    case 0:
      foreach(model in var_648616bf) {
        hidestaticmodel(model);
      }

      foreach(model in var_1fb7432d) {
        unhidestaticmodel(model);
      }

      break;
    case 1:
      foreach(model in var_648616bf) {
        unhidestaticmodel(model);
      }

      foreach(model in var_1fb7432d) {
        hidestaticmodel(model);
      }

      break;
    default:
      break;
  }
}

function set_player_pbg_bank(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self notify(#"hash_2866809d9cfd329b");

  switch (bwasdemojump) {
    case 1:
      function_be93487f(fieldname, 2, 0, 1, 0, 0);
      break;
    case 2:
      self thread function_22f4412d(fieldname);
      break;
    case 3:
      function_be93487f(fieldname, 8, 0, 0, 0, 1);
      break;
    default:
      function_be93487f(fieldname, 1, 1, 0, 0, 0);
      break;
  }
}

function private function_22f4412d(localclientnum, transitiontime = 5) {
  self notify("7fcf421cf89e7e10");
  self endon("7fcf421cf89e7e10");
  self endon(#"death", #"hash_2866809d9cfd329b");
  progress = 0;
  increment = 1 / transitiontime / 0.016;

  while(progress < 1) {
    function_be93487f(localclientnum, 5, 1, 0, progress, 0);
    progress += increment;
    waitframe(1);
  }

  function_be93487f(localclientnum, 4, 0, 0, 1, 0);
}

function set_flashlight_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (bwasdemojump) {
    case 1:
      flashlightfx = "maps/cp_kgb/fx9_kgb_lo_flashlight";
      break;
    default:
      flashlightfx = "light/fx9_light_cp_flashlight";
      break;
  }

  self flashlight::function_69258685(fieldname, flashlightfx);
}

function set_flashlight_gun_tag(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (bwasdemojump) {
    case 1:
      if(!isDefined(self.var_499c9ce)) {
        self.var_499c9ce = util::playFXOnTag(fieldname, "maps/cp_kgb/fx9_kgb_lo_flashlight", self, "tag_flashlight_fx");
      }

      break;
    default:
      if(isDefined(self.var_499c9ce)) {
        killfx(fieldname, self.var_499c9ce);
      }

      break;
  }
}

function set_fov(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  n_time = 0.5;

  switch (bwastimejump) {
    case 1:
      self function_9298adaf(1);
      break;
    case 2:
      self easing::function_f95cb457(undefined, 17, n_time, #"linear");
      break;
    case 3:
      self easing::function_f95cb457(undefined, 20, n_time, #"linear");
      break;
    case 4:
      self easing::function_f95cb457(undefined, 25, n_time, #"linear");
      break;
    case 5:
      self easing::function_f95cb457(undefined, 30, n_time, #"linear");
      break;
    case 6:
      self function_9298adaf(2);
      break;
    case 7:
      self easing::function_f95cb457(undefined, 20, 0.8, #"linear");
      break;
  }
}

function set_dof(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  n_time = 0.5;

  switch (bwastimejump) {
    case 1:
      self function_9e574055(0);
      self function_3c54e2b8(n_time);
      self function_9ea7b4eb(n_time);
      break;
    case 2:
      self function_9e574055(2);
      self function_1816c600(1.5, n_time);
      self function_d7be9a9f(50, n_time);
      break;
    case 3:
      self function_9e574055(2);
      self function_1816c600(1.5, n_time);
      self function_d7be9a9f(90, n_time);
      break;
    case 4:
      self function_9e574055(0);
      self function_3c54e2b8(2);
      self function_9ea7b4eb(2);
      break;
  }
}

function set_camera_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self.var_ace0380 = util::playFXOnTag(fieldname, "maps/cp_kgb/fx9_kgb_camera_fov", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_ace0380)) {
    killfx(fieldname, self.var_ace0380);
    self.var_7a1ac572 = undefined;
  }
}

function vault_torch_vfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self.vault_torch_vfx = util::playFXOnTag(fieldname, #"hash_5e3ecff0db09def2", self, "tag_fx");
    return;
  }

  killfx(fieldname, self.vault_torch_vfx);
}

function private function_12315dac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    fxid = util::playFXOnTag(fieldname, "maps/cp_kgb/fx9_kgb_c4_light_green", self, "tag_origin");
    self thread function_e360e5ab(fieldname, fxid, "stop_c4_on_fx");
    return;
  }

  self notify(#"stop_c4_on_fx");
}

function private function_f8229597(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    fxid = util::playFXOnTag(fieldname, "maps/cp_kgb/fx9_kgb_c4_light_red", self, "tag_origin");
    self thread function_e360e5ab(fieldname, fxid, "stop_c4_blink_fx");
    return;
  }

  self notify(#"stop_c4_blink_fx");
}

function private function_e360e5ab(localclientnum, fxid, end_notify) {
  self waittill(#"death", #"fx_death", end_notify);
  stopfx(localclientnum, fxid);
}

function private function_e067b5e6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(self postfx::function_556665f2("pstfx_gasmask_cp")) {
      self postfx::stoppostfxbundle("pstfx_gasmask_cp");
    }

    self postfx::playpostfxbundle("pstfx_gasmask_cp");
    return;
  }

  self postfx::stoppostfxbundle("pstfx_gasmask_cp");
}

function private function_4479bcfe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(self postfx::function_556665f2("pstfx_exfilmask_cp")) {
      self postfx::stoppostfxbundle("pstfx_exfilmask_cp");
    }

    self postfx::playpostfxbundle("pstfx_exfilmask_cp");
    return;
  }

  self postfx::stoppostfxbundle("pstfx_exfilmask_cp");
}

function stream_belikov_rv_assets(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel("c_t9_cp_rus_kgb_hq_officer_body1_nolod");
    forcestreamxmodel("wpn_t9_eqp_ru_radio_handheld_view");
    return;
  }

  stopforcestreamingxmodel("c_t9_cp_rus_kgb_hq_officer_body1_nolod");
  stopforcestreamingxmodel("wpn_t9_eqp_ru_radio_handheld_view");
}

function stream_elevator_exfil_assets(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel("c_t9_cp_usa_hero_adler_kgb_exfil_armor_body");
    forcestreamxmodel("c_t9_cp_usa_hero_adler_head1_kgb_officer_exfil_visor_down");
    forcestreamxmodel("c_t9_cp_rus_belikov_kgb_exfil_armor_body1");
    forcestreamxmodel("c_t9_cp_rus_kgb_hq_vip_belikov_head_exfil_visor_down");
    forcestreamxmodel("emb_cabinet_file_single_open_dmg_anim");
    return;
  }

  stopforcestreamingxmodel("c_t9_cp_usa_hero_adler_kgb_exfil_armor_body");
  stopforcestreamingxmodel("c_t9_cp_usa_hero_adler_head1_kgb_officer_exfil_visor_down");
  stopforcestreamingxmodel("c_t9_cp_rus_belikov_kgb_exfil_armor_body1");
  stopforcestreamingxmodel("c_t9_cp_rus_kgb_hq_vip_belikov_head_exfil_visor_down");
  stopforcestreamingxmodel("emb_cabinet_file_single_open_dmg_anim");
}

function stream_deploy_gas_assets(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel("c_t9_cp_usa_hero_adler_head1_kgb_gasmask");
    forcestreamxmodel("c_t9_cp_usa_hero_adler_prop_kgb_gasmask");
    forcestreamxmodel("c_t9_cp_rus_kgb_hq_vip_belikov_head_gasmask");
    forcestreamxmodel("c_t9_cp_rus_hero_belikov_prop_kgb_gasmask");
    return;
  }

  stopforcestreamingxmodel("c_t9_cp_usa_hero_adler_head1_kgb_gasmask");
  stopforcestreamingxmodel("c_t9_cp_usa_hero_adler_prop_kgb_gasmask");
  stopforcestreamingxmodel("c_t9_cp_rus_kgb_hq_vip_belikov_head_gasmask");
  stopforcestreamingxmodel("c_t9_cp_rus_hero_belikov_prop_kgb_gasmask");
}

function vault_hanging_light_vfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_a2f0a0e3 = util::playFXOnTag(fieldname, "light/fx9_light_cp_kgb_vault_hanging", self, "tag_fx");
    return;
  }

  if(isDefined(self.var_a2f0a0e3)) {
    killfx(fieldname, self.var_a2f0a0e3);
    self.var_a2f0a0e3 = undefined;
  }
}

function vault_hanging_light_flicker_vfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(isDefined(self.var_a2f0a0e3)) {
      killfx(fieldname, self.var_a2f0a0e3);
      self.var_a2f0a0e3 = undefined;
    }

    self.var_a2f0a0e3 = util::playFXOnTag(fieldname, "light/fx9_light_cp_kgb_vault_hanging_flicker", self, "tag_fx");
    return;
  }

  if(isDefined(self.var_a2f0a0e3)) {
    killfx(fieldname, self.var_a2f0a0e3);
    self.var_a2f0a0e3 = undefined;
  }
}

function function_cad5695c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self setanimrestart(#"hash_5ded2bc1daee5a9b");
    return;
  }

  self clearanim(#"hash_5ded2bc1daee5a9b", 0);
}

function toggle_occluder(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 0:
      function_e7647ecd("exfil_courtyard_occluder", 1);
      break;
    case 1:
      function_e7647ecd("exfil_courtyard_occluder", 0);
      break;
    default:
      break;
  }
}

function vault_explosion_dynents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 1:
      vault_post_explosion_orgs = struct::get_array("vault_post_explosion_orgs", "targetname");

      foreach(org in vault_post_explosion_orgs) {
        physicsexplosionsphere(fieldname, org.origin, 100, 0, 1, 20, 5, 1, 1);
      }

      break;
    default:
      break;
  }
}

function stream_adler_assault_assets(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel("c_t9_cp_usa_hero_adler_head1");
    forcestreamxmodel("c_t9_cp_usa_hero_adler_kgb_exfil_body");
    return;
  }

  stopforcestreamingxmodel("c_t9_cp_usa_hero_adler_head1");
  stopforcestreamingxmodel("c_t9_cp_usa_hero_adler_kgb_exfil_body");
}