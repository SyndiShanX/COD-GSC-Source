/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_rus_siege.csc
***********************************************/

#using script_38867f943fb86135;
#using script_4179c51fbbe7793b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#namespace cp_rus_siege;

function event_handler[level_init] main(eventstruct) {
  preload();
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  callback::on_localplayer_spawned(&on_gameplay_started);
  load::main();
  util::waitforclient(0);
}

function preload() {
  clientfield::register("scriptmover", "radar_fx", 1, 1, "int", &radar_fx, 0, 0);
  clientfield::register("toplayer", "bullet_hit", 1, 1, "int", &function_b62587b2, 0, 1);
  clientfield::register("actor", "toggle_bone_constraint", 1, 1, "int", &toggle_bone_constraint, 0, 0);
  clientfield::register("toplayer", "stream_intro_assets", 1, 1, "int", &stream_intro_assets, 0, 0);
}

function stream_intro_assets(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel("c_t9_cp_usa_hero_adler_head1_infil_stealth");
    forcestreamxmodel("c_t9_usa_hero_adler_infil_siege_body");
    forcestreamxmodel("c_t9_cp_usa_hero_woods_body1");
    forcestreamxmodel("c_t9_cp_usa_hero_woods_head1_bandana");
    forcestreamxmodel("c_t9_cp_usa_hero_mason_infil_siege_body");
    return;
  }

  stopforcestreamingxmodel("c_t9_cp_usa_hero_adler_head1_infil_stealth");
  stopforcestreamingxmodel("c_t9_usa_hero_adler_infil_siege_body");
  stopforcestreamingxmodel("c_t9_cp_usa_hero_woods_body1");
  stopforcestreamingxmodel("c_t9_cp_usa_hero_woods_head1_bandana");
  stopforcestreamingxmodel("c_t9_cp_usa_hero_mason_infil_siege_body");
}

function function_b62587b2(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self postfx::playpostfxbundle("pstfx_ending");
    return;
  }

  if(bwastimejump == 0 && self postfx::function_556665f2("pstfx_ending")) {
    self postfx::stoppostfxbundle("pstfx_ending");
  }
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  util::function_8eb5d4b0(3500, 1.8);
}

function radar_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.radar_fx = function_239993de(fieldname, "maps/cp_rus_siege/fx9_glow_red_radar", self, "tag_origin");
    return;
  }

  killfx(fieldname, self.radar_fx);
}

function toggle_bone_constraint(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self function_d309e55a("j_bag_parent", 0);
    return;
  }

  self function_d309e55a("j_bag_parent", 1);
}