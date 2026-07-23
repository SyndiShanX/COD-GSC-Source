/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback.gsc
**************************************/

main() {
  maps\_utility::template_level("payback");
  maps\payback_precache::main();
  precacheshader("gasmask_overlay_delta2");
  maps\payback_streets::_id_669A();
  maps\_utility::_id_1F1B(maps\payback_compound::_id_6840);
  maps\_utility::_id_1E74("s1_outer_compound", maps\payback_1_script_b::_id_67B1);
  maps\_utility::_id_1E74("s1_main_compound", maps\payback_1_script_c::_id_6796);
  maps\_utility::_id_1E74("s1_interrogation", maps\payback_1_script_e::_id_663A);
  maps\_utility::_id_1E74("s2_city", maps\payback_streets::_id_669B);
  maps\_utility::_id_1E74("s2_postambush", maps\payback_streets::_id_669C);
  maps\_utility::_id_1E74("s2_construction", maps\payback_streets_const::_id_66F9);
  maps\_utility::_id_1E74("s2_rappel", maps\payback_streets_const::_id_66FB);
  maps\_utility::_id_1E74("s2_sandstorm", maps\payback_sandstorm::_id_658A);
  maps\_utility::_id_1E74("s3_rescue", maps\payback_rescue::_id_6506);
  maps\_utility::_id_1E74("s3_escape", maps\payback_rescue::_id_650A);
  maps\payback_main::main();
}