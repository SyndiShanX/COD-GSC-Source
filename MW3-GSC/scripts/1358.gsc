/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1358.gsc
**************************************/

#using_animtree("script_model");

main() {
  level._id_1245["hiding_door"] = #animtree;
  level._id_1F90["hiding_door"] = "com_door_01_handleleft";
  level._id_0C59["hiding_door"]["close"] = % doorpeek_close_door;
  level._id_0C59["hiding_door"]["death_1"] = % doorpeek_deatha_door;
  level._id_0C59["hiding_door"]["death_2"] = % doorpeek_deathb_door;
  level._id_0C59["hiding_door"]["fire_1"] = % doorpeek_firea_door;
  level._id_0C59["hiding_door"]["fire_2"] = % doorpeek_fireb_door;
  level._id_0C59["hiding_door"]["fire_3"] = % doorpeek_firec_door;
  level._id_0C59["hiding_door"]["peek"] = % doorpeek_idle_door;
  level._id_0C59["hiding_door"]["grenade"] = % doorpeek_grenade_door;
  level._id_0C59["hiding_door"]["idle"][0] = % doorpeek_idle_door;
  level._id_0C59["hiding_door"]["jump"] = % doorpeek_jump_door;
  level._id_0C59["hiding_door"]["kick"] = % doorpeek_kick_door;
  level._id_0C59["hiding_door"]["open"] = % doorpeek_open_door;
  precachemodel(level._id_1F90["hiding_door"]);
  maps\_anim::_id_125D("hiding_door", "sound door death", "any", "scn_doorpeek_door_open_death");
  maps\_anim::_id_125D("hiding_door", "sound door open", "any", "scn_doorpeek_door_open");
  maps\_anim::_id_125D("hiding_door", "sound door slam", "any", "scn_doorpeek_door_slam");
  _id_40AA();
  thread _id_1E72();
}

#using_animtree("generic_human");

_id_40AA() {
  level._id_0C59["hiding_door_guy"]["close"] = % doorpeek_close;
  level._id_0C59["hiding_door_guy"]["death_1"] = % doorpeek_deatha;
  level._id_0C59["hiding_door_guy"]["death_2"] = % doorpeek_deathb;
  level._id_0C59["hiding_door_guy"]["fire_1"] = % doorpeek_firea;
  level._id_0C59["hiding_door_guy"]["fire_2"] = % doorpeek_fireb;
  level._id_0C59["hiding_door_guy"]["fire_3"] = % doorpeek_firec;
  level._id_0C59["hiding_door_guy"]["peek"] = % doorpeek_idle;
  level._id_0C59["hiding_door_guy"]["grenade"] = % doorpeek_grenade;
  level._id_0C59["hiding_door_guy"]["idle"][0] = % doorpeek_idle;
  level._id_0C59["hiding_door_guy"]["jump"] = % doorpeek_jump;
  level._id_0C59["hiding_door_guy"]["kick"] = % doorpeek_kick;
  level._id_0C59["hiding_door_guy"]["open"] = % doorpeek_open;
}

_id_1E72() {
  wait 0.05;
  maps\_anim::_id_1264("hiding_door_guy", "grenade_throw", maps\_hiding_door::_id_1295);
}