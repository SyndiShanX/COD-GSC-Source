/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_bridge_exploder.gsc
****************************************************/

#using_animtree("script_model");

main() {
  var_0 = "bridge_exploder";
  var_1 = getent("bridge_exploder_ref", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = spawnStruct();
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  var_1 delete();
  var_3 = "vfx/moments/oil_rocks/vfx_bridge_coll_watersplash";
  maps\_anim::create_anim_scene(#animtree, var_0, %oilrocks_bridge_explosion_a_anim, "oilrocks_bridgeA", "oilrocks_bridge_explosion_A");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc02", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc03", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc04", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc05", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc06", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc07", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc09", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc10", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc11", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc12", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc13", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc14", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc22", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc23", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc24", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc25", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc26", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc27", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc28", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc29", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc30", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc31", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc32", var_3, var_3, 60);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_bridge_pc33", var_3, var_3, 60);
  maps\_anim::create_anim_scene(#animtree, var_0, %oilrocks_bridge_explosion_b_anim, "oilrocks_bridgeB", "oilrocks_bridge_explosion_B");
  level waittill("exploding_bridge_exploder");
  var_4 = [maps\_utility::spawn_anim_model("oilrocks_bridgeA", var_2.origin, var_2.angles), maps\_utility::spawn_anim_model("oilrocks_bridgeB", var_2.origin, var_2.angles)];
  var_2 maps\_anim::anim_single(var_4, var_0);
}