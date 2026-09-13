/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2c498c4c0f38f26b.gsc
***********************************************/

init() {
  if(!isDefined(level._id_74A171505D979CBC))
    level._id_74A171505D979CBC = spawnStruct();

  level._id_74A171505D979CBC._id_1FC4FD3EF975E8C8 = ::_id_78748799DE25DA5F;
  level._id_74A171505D979CBC._id_02EC260CA66F2378 = ::_id_65BBB083561FA648;
  level._id_74A171505D979CBC._id_EFAA5D51E08521EB = ::_id_6C512ED7AF23EB04;
  level._id_74A171505D979CBC._id_03522908002CC5AF = ::_id_B3CAB4BBBD2F27BF;
  level._id_74A171505D979CBC._id_16A2AD3BCCC62BB5 = ::_id_53BC249DE0D47B05;
  level._id_74A171505D979CBC._id_2EDA72772D041081 = ::_id_63CAC0421ACBE53C;
  level._id_74A171505D979CBC._id_0FBD8726770C4C39 = _id_372D8C5F69B0AE2E::_id_D8F48AB0DFD5EF51;
  level._id_74A171505D979CBC._id_8A66FB76621B9C84 = ::_id_91C24157247EF2FC;
  level._id_74A171505D979CBC._id_5415E799CAE1BAC7 = _id_372D8C5F69B0AE2E::_id_497A27B31D43D6AF;
  level._id_74A171505D979CBC.playerlinkeduselinkedvelocity = ::_id_5E2B19FD9204A302;
  _id_372D8C5F69B0AE2E::main();
}

#using_animtree("generic_human");

_id_78748799DE25DA5F() {
  _id_B0C99390CDB7EDD5();
  anims = [];
  anims["scripted_melee_kill_01_left"] = % vm_sp_context_melee_stand_1_left_enemy;
  anims["scripted_melee_kill_01_right"] = % vm_sp_context_melee_stand_1_right_enemy;
  anims["scripted_melee_kill_01_front"] = % vm_sp_context_melee_stand_1_front_enemy;
  anims["scripted_melee_kill_01_back"] = % vm_sp_context_melee_stand_1_rear_enemy;
  anims["scripted_melee_kill_02_left"] = % vm_sp_context_melee_stand_2_left_enemy;
  anims["scripted_melee_kill_02_right"] = % vm_sp_context_melee_stand_2_right_enemy;
  anims["scripted_melee_kill_02_front"] = % vm_sp_context_melee_stand_2_front_enemy;
  anims["scripted_melee_kill_02_back"] = % vm_sp_context_melee_stand_2_rear_enemy;
  anims["scripted_melee_stealth_kill_01_back"] = % vm_sp_context_melee_stand_1_rear_enemy;
  anims["scripted_melee_stealth_kill_01_left"] = % vm_sp_context_melee_stand_1_left_enemy;
  anims["scripted_melee_stealth_kill_01_right"] = % vm_sp_context_melee_stand_1_right_enemy;
  anims["scripted_melee_stealth_kill_01_front"] = % vm_sp_context_melee_stand_1_front_enemy;

  foreach(key, _id_4F3089070D8B1E24 in anims) {
    level.scr_anim["generic"][key] = _id_4F3089070D8B1E24;
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_death", _id_372D8C5F69B0AE2E::_id_D8F48AB0DFD5EF51, key);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_ragdoll", ::_id_91C24157247EF2FC, key);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_fx", _id_372D8C5F69B0AE2E::_id_497A27B31D43D6AF, key);
  }
}

#using_animtree("script_model");

_id_B0C99390CDB7EDD5() {
  level.scr_animtree["scripted_melee_player_rig"] = #animtree;

  if(!isDefined(level.scr_model) || !isDefined(level.scr_model["scripted_melee_player_rig"]))
    level.scr_model["scripted_melee_player_rig"] = "viewhands_base_iw8";

  level.scr_anim["scripted_melee_player_rig"]["scripted_melee_kill_01_left"] = % vm_sp_context_melee_stand_1_left_player;
  level.scr_anim["scripted_melee_player_rig"]["scripted_melee_kill_01_right"] = % vm_sp_context_melee_stand_1_right_player;
  level.scr_anim["scripted_melee_player_rig"]["scripted_melee_kill_01_front"] = % vm_sp_context_melee_stand_1_front_player;
  level.scr_anim["scripted_melee_player_rig"]["scripted_melee_kill_01_back"] = % vm_sp_context_melee_stand_1_rear_player;
  scripts\common\utility::_id_7A5A6498179656FC("scripted_melee_kill_01_left", "left", _id_372D8C5F69B0AE2E::_id_7E355057C5E32C56);
  scripts\common\utility::_id_7A5A6498179656FC("scripted_melee_kill_01_right", "right", _id_372D8C5F69B0AE2E::_id_7E355057C5E32C56);
  scripts\common\utility::_id_7A5A6498179656FC("scripted_melee_kill_01_front", "front", _id_372D8C5F69B0AE2E::_id_7E355057C5E32C56);
  scripts\common\utility::_id_7A5A6498179656FC("scripted_melee_kill_01_back", "back", _id_372D8C5F69B0AE2E::_id_7E355057C5E32C56);
  level.scr_anim["scripted_melee_player_rig"]["scripted_melee_kill_02_left"] = % vm_sp_context_melee_stand_2_left_player;
  level.scr_anim["scripted_melee_player_rig"]["scripted_melee_kill_02_right"] = % vm_sp_context_melee_stand_2_right_player;
  level.scr_anim["scripted_melee_player_rig"]["scripted_melee_kill_02_front"] = % vm_sp_context_melee_stand_2_front_player;
  level.scr_anim["scripted_melee_player_rig"]["scripted_melee_kill_02_back"] = % vm_sp_context_melee_stand_2_rear_player;
  scripts\common\utility::_id_7A5A6498179656FC("scripted_melee_kill_02_left", "left", _id_372D8C5F69B0AE2E::_id_7E355057C5E32C56);
  scripts\common\utility::_id_7A5A6498179656FC("scripted_melee_kill_02_right", "right", _id_372D8C5F69B0AE2E::_id_7E355057C5E32C56);
  scripts\common\utility::_id_7A5A6498179656FC("scripted_melee_kill_02_front", "front", _id_372D8C5F69B0AE2E::_id_7E355057C5E32C56);
  scripts\common\utility::_id_7A5A6498179656FC("scripted_melee_kill_02_back", "back", _id_372D8C5F69B0AE2E::_id_7E355057C5E32C56);
  level.scr_anim["scripted_melee_player_rig"]["scripted_melee_stealth_kill_01_left"] = % vm_sp_context_melee_stand_1_left_player;
  level.scr_anim["scripted_melee_player_rig"]["scripted_melee_stealth_kill_01_right"] = % vm_sp_context_melee_stand_1_right_player;
  level.scr_anim["scripted_melee_player_rig"]["scripted_melee_stealth_kill_01_front"] = % vm_sp_context_melee_stand_1_front_player;
  level.scr_anim["scripted_melee_player_rig"]["scripted_melee_stealth_kill_01_back"] = % vm_sp_context_melee_stand_1_rear_player;
  scripts\common\utility::_id_7A5A6498179656FC("scripted_melee_stealth_kill_01_left", "left", _id_372D8C5F69B0AE2E::_id_9D501E35F4127F85);
  scripts\common\utility::_id_7A5A6498179656FC("scripted_melee_stealth_kill_01_right", "right", _id_372D8C5F69B0AE2E::_id_9D501E35F4127F85);
  scripts\common\utility::_id_7A5A6498179656FC("scripted_melee_stealth_kill_01_front", "front", _id_372D8C5F69B0AE2E::_id_9D501E35F4127F85);
  scripts\common\utility::_id_7A5A6498179656FC("scripted_melee_stealth_kill_01_back", "back", _id_372D8C5F69B0AE2E::_id_9D501E35F4127F85);
}

spawn_anim_model(animname, origin, angles) {
  if(!isDefined(origin))
    origin = (0, 0, 0);

  model = spawn("script_model", origin);
  model.animname = animname;
  model useanimtree(#animtree);
  model setModel(level.scr_model[model.animname]);

  if(isDefined(angles))
    model.angles = angles;

  return model;
}

_id_65BBB083561FA648() {
  self._id_7E7071F7B9501085 = spawn_anim_model("scripted_melee_player_rig", self.origin, self.angles);
  self._id_7E7071F7B9501085 scripts\common\anim::_id_01CB661B457551A3(1, self, 0.35);
}

_id_6C512ED7AF23EB04() {
  _id_765A8198C5E89918 = getaiarray("axis");
  scripts\engine\utility::array_call(_id_765A8198C5E89918, ::_meth_F23F106F8976771D);
}

_id_B3CAB4BBBD2F27BF() {}

_id_53BC249DE0D47B05() {}

_id_91C24157247EF2FC(guy) {}

_id_63CAC0421ACBE53C() {
  return _id_372D8C5F69B0AE2E::_id_E5433A928BC95CCA();
}

_id_5E2B19FD9204A302(_id_E3108E412AFB3811) {}