/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback.gsc
**************************************/

main() {
  maps\_utility::template_level("payback");
  maps\payback_precache::main();
  precacheshader("gasmask_overlay_delta2");
  maps\payback_streets::init_streets_assets();
  maps\_utility::default_start(maps\payback_compound::_id_6840);
  maps\_utility::add_start("s1_outer_compound", maps\payback_1_script_b::_id_67B1);
  maps\_utility::add_start("s1_main_compound", maps\payback_1_script_c::_id_6796);
  maps\_utility::add_start("s1_interrogation", maps\payback_1_script_e::s1_interrogation_jumpto);
  maps\_utility::add_start("s2_city", maps\payback_streets::start_s2_city);
  maps\_utility::add_start("s2_postambush", maps\payback_streets::start_s2_postambush);
  maps\_utility::add_start("s2_construction", maps\payback_streets_const::start_s2_construction);
  maps\_utility::add_start("s2_rappel", maps\payback_streets_const::start_s2_rappel);
  maps\_utility::add_start("s2_sandstorm", maps\payback_sandstorm::start_sandstorm);
  maps\_utility::add_start("s3_rescue", maps\payback_rescue::start_s3_rescue);
  maps\_utility::add_start("s3_escape", maps\payback_rescue::start_s3_escape);
  maps\payback_main::main();
}