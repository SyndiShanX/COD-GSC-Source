/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_nam_armada_fx.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#namespace namespace_9a981837;

function function_c44464c8() {
  clientfield::register("toplayer", "pstfx_sprite_rain_loop", 1, 1, "int");
  clientfield::register("toplayer", "pstfx_slowed", 1, 1, "int");
  clientfield::register("toplayer", "pstfx_vignette", 1, 1, "int");
  clientfield::register("vehicle", "bamboo_heli_landing_rain_fx", 1, 1, "int");
  clientfield::register("toplayer", "postfx_bundle_explosive_damage", 1, 1, "int");
  clientfield::register("toplayer", "forest_pbg_switch", 1, 1, "int");
}

function init_fx() {
  thread function_d54bb61();
  level._effect[#"hash_75a6e0287f64b467"] = # "hash_b6ab7aa2e4af0ce";
  level._effect[#"hash_1d9204870892bf9c"] = # "hash_3d58577d8964749b";
  level._effect[#"hash_7e6d961e2c87c2c9"] = # "hash_1195c44b2991b9e";
  level._effect[#"hash_430013754d2d4603"] = # "hash_5cad1a1b9fdc43ee";
  thread exploder::kill_exploder("fx_firebase_nukeretrieve");
  thread exploder::kill_exploder("fx_firebase_nukeretrieve_downdraft");
}

function function_82a143d2() {
  playFX(level._effect[#"hash_7e6d961e2c87c2c9"], self.origin + (0, 0, -150));
}

function function_d54bb61() {
  level flag::wait_till("all_players_spawned");
  getplayers()[0] endon(#"death");
  level waittill(#"hash_7bfe2feb57babd0b");
  level.player clientfield::set_to_player("postfx_bundle_explosive_damage", 1);
  level waittill(#"hash_291826dce45def2d");
  level.player clientfield::set_to_player("postfx_bundle_explosive_damage", 0);
}

function function_121aeba5() {
  while(true) {
    wait 80;
    exploder::exploder("Flying_ocean");
    wait 91.5;
    exploder::exploder("Flying_ambience");
  }
}

function function_62dae110() {
  level.player endon(#"death");
  level.var_7466d419 endon(#"death");
  level waittill(#"hash_7a85fc4b002ec719");
  playFXOnTag(level._effect[#"hash_75a6e0287f64b467"], level.var_7466d419, "tag_attach");
  level.player clientfield::set_to_player("pstfx_sprite_rain_loop", 1);
  level waittill(#"hash_2d8371713a24b057");
  level.player clientfield::set_to_player("pstfx_sprite_rain_loop", 0);
}

function pstfx_vignette() {
  level.player endon(#"death");
}

function intro_dof() {
  level flag::wait_till("flag_vo_gearup_reach_chopper");
  level.vip endon(#"death");
  level.player endon(#"death");
  self endon(#"death");
  level flag::wait_till("flag_vo_chopper_chatter_2");
}

function function_ee673d3d() {
  self endon(#"death");
  level notify(#"hash_1849624165c8255f");
  level.var_7466d419.var_6bbdd0a5 = spawn("script_model", level.var_7466d419.origin);
  level.var_7466d419.var_6bbdd0a5 setModel(#"tag_origin");
  level.var_7466d419.var_6bbdd0a5 enablelinkto();
  level.var_7466d419.var_6bbdd0a5 linkto(level.var_7466d419, "tag_fire_extinguisher_attach", (0, 0, 35), (90, 0, 0));
  level.var_7466d419.var_585ee020 = # "hash_7401be881ac98bd9";
  level waittill(#"hash_227cc8ce5802e6b5");
  level.var_7466d419.var_6bbdd0a5 delete();
  level waittill(#"hash_1849624165c8255f");
  level.var_7466d419.var_6bbdd0a5 = spawn("script_model", level.var_7466d419.origin);
  level.var_7466d419.var_6bbdd0a5 setModel(#"tag_origin");
  level.var_7466d419.var_6bbdd0a5 enablelinkto();
  level.var_7466d419.var_6bbdd0a5 linkto(level.var_7466d419, "tag_fire_extinguisher_attach", (0, 0, 35), (90, 0, 0));
  playFXOnTag(level.var_7466d419.var_585ee020, level.var_7466d419.var_6bbdd0a5, "tag_origin");
}

function function_fcea30b4(var_c38706bb) {
  thread function_bffbd256();
}

function function_bffbd256() {
  level.player setnosunshadow();
  level flag::wait_till("flag_vo_chopper_chatter_2");
  level.player removenosunshadow();
}

function function_a9a0debb(params) {
  if(isarray(params)) {} else {
    args = strtok(params, ",");

    foreach(arg in args) {
      var_102cf4ae = strtok(arg, "=");

      switch (var_102cf4ae[0]) {
        case # "f_fstop":
          f_fstop = float(var_102cf4ae[1]);
          break;
        case # "f_fstop_time":
          f_fstop_time = float(var_102cf4ae[1]);
          break;
      }
    }
  }

  if(!isDefined(f_fstop)) {
    f_fstop = 108;
  }

  if(!isDefined(f_fstop_time)) {
    freqpitch = 1;
  }

  thread auto_dof(f_fstop, f_fstop_time);
}

function auto_dof(f_fstop, f_fstop_time) {
  if(isDefined(level.player)) {
    level.player thread fx::function_82104e32(f_fstop, f_fstop_time);
    return;
  }

  wait 1;
  level.player thread fx::function_82104e32(f_fstop, f_fstop_time);
}

function function_7e002ff8() {
  level.player flag::clear("flag_autofocus_on");
}

function function_633130e5(a_ents) {
  level.player thread fx::lighting_target_dof(a_ents[0], 0.025, 0.05);
  wait 7;
  thread function_7e002ff8();
}

function function_5c261946() {
  setDvar(#"r_dofmode", 1);
}

function forest_pbg_switch() {
  level.player endon(#"death");
  level.player clientfield::set_to_player("forest_pbg_switch", 1);
}

function function_3f0940c0() {
  level.player endon(#"death");
  level.player clientfield::set_to_player("forest_pbg_switch", 0);
}