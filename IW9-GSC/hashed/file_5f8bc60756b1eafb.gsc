/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5f8bc60756b1eafb.gsc
***********************************************/

init() {
  if(!isDefined(level._id_74A171505D979CBC))
    level._id_74A171505D979CBC = spawnStruct();

  level._id_74A171505D979CBC._id_1FC4FD3EF975E8C8 = ::_id_78748799DE25DA5F;
  level._id_74A171505D979CBC._id_02EC260CA66F2378 = ::_id_65BBB083561FA648;
  level._id_74A171505D979CBC._id_EFAA5D51E08521EB = ::_id_6C512ED7AF23EB04;
  level._id_74A171505D979CBC._id_03522908002CC5AF = ::_id_B3CAB4BBBD2F27BF;
  level._id_74A171505D979CBC._id_16A2AD3BCCC62BB5 = ::_id_53BC249DE0D47B05;
  level._id_74A171505D979CBC._id_2EDA72772D041081 = ::_id_6410C0421B1874AC;
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
  anims["vm_sp_takedown_knife_left_02"] = % vm_sp_takedown_knife_left_02_enemy;
  anims["vm_sp_takedown_knife_right_01"] = % vm_sp_takedown_knife_right_01_enemy;
  anims["vm_sp_takedown_knife_front_03"] = % vm_sp_takedown_knife_front_03_enemy;
  anims["vm_sp_takedown_knife_back_01"] = % vm_sp_takedown_knife_back_01_enemy;
  anims["vm_sp_takedown_knife_left_03"] = % vm_sp_takedown_knife_left_03_enemy;
  anims["vm_sp_takedown_knife_right_03"] = % vm_sp_takedown_knife_right_03_enemy;
  anims["vm_sp_takedown_knife_front_04"] = % vm_sp_takedown_knife_front_04_enemy;
  anims["vm_sp_takedown_knife_back_02"] = % vm_sp_takedown_knife_back_02_enemy;
  anims["vm_sp_takedown_pistol_left_01"] = % vm_sp_takedown_pistol_left_01_enemy;
  anims["vm_sp_takedown_pistol_right_01"] = % vm_sp_takedown_pistol_right_01_enemy;
  anims["vm_sp_takedown_pistol_front_01"] = % vm_sp_takedown_pistol_front_01_enemy;
  anims["vm_sp_takedown_pistol_back_01"] = % vm_sp_takedown_pistol_back_01_enemy;
  anims["vm_sp_takedown_pistol_left_02"] = % vm_sp_takedown_pistol_left_02_enemy;
  anims["vm_sp_takedown_pistol_right_02"] = % vm_sp_takedown_pistol_right_02_enemy;
  anims["vm_sp_takedown_pistol_front_02"] = % vm_sp_takedown_pistol_front_02_enemy;
  anims["vm_sp_takedown_pistol_back_02"] = % vm_sp_takedown_pistol_back_02_enemy;
  anims["vm_sp_takedown_knife_crouch_back_01"] = % vm_sp_takedown_knife_crouch_back_01_enemy;
  anims["vm_sp_takedown_knife_crouch_back_02"] = % vm_sp_takedown_knife_crouch_back_02_enemy;
  anims["vm_sp_takedown_knife_crouch_left_01"] = % vm_sp_takedown_knife_crouch_left_01_enemy;
  anims["vm_sp_takedown_knife_crouch_left_02"] = % vm_sp_takedown_knife_crouch_left_02_enemy;
  anims["vm_sp_takedown_knife_crouch_right_01"] = % vm_sp_takedown_knife_crouch_right_01_enemy;
  anims["vm_sp_takedown_knife_crouch_right_02"] = % vm_sp_takedown_knife_crouch_right_02_enemy;

  foreach(key, _id_4F3089070D8B1E24 in anims) {
    level.scr_anim["generic"][key] = _id_4F3089070D8B1E24;
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_death", _id_372D8C5F69B0AE2E::_id_D8F48AB0DFD5EF51, key);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_ragdoll", ::_id_91C24157247EF2FC, key);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_fx", _id_372D8C5F69B0AE2E::_id_497A27B31D43D6AF, key);
  }
}

#using_animtree("player");

_id_B0C99390CDB7EDD5() {
  level.scr_animtree["scripted_melee_player_rig"] = #animtree;

  if(!isDefined(level.scr_model) || !isDefined(level.scr_model["scripted_melee_player_rig"]))
    level.scr_model["scripted_melee_player_rig"] = "viewhands_base_fullbody_iw8";

  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_left_02"] = % vm_sp_takedown_knife_left_02_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_right_01"] = % vm_sp_takedown_knife_right_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_front_03"] = % vm_sp_takedown_knife_front_03_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_back_01"] = % vm_sp_takedown_knife_back_01_player;
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_left_02", "left", _id_372D8C5F69B0AE2E::_id_A3356321F4375B10, undefined, undefined, undefined, undefined, undefined, undefined, "TAG_ACCESSORY_LEFT");
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_right_01", "right", _id_372D8C5F69B0AE2E::_id_A3356321F4375B10, undefined, undefined, undefined, undefined, undefined, undefined, "TAG_ACCESSORY_LEFT");
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_front_03", "front", _id_372D8C5F69B0AE2E::_id_0B767805CA0E381E);
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_back_01", "back", _id_372D8C5F69B0AE2E::_id_279A32B2CDCE2B2B);
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_left_03"] = % vm_sp_takedown_knife_left_03_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_right_03"] = % vm_sp_takedown_knife_right_03_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_front_04"] = % vm_sp_takedown_knife_front_04_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_back_02"] = % vm_sp_takedown_knife_back_02_player;
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_left_03", "left", _id_372D8C5F69B0AE2E::_id_A3356321F4375B10);
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_right_03", "right", _id_372D8C5F69B0AE2E::_id_A3356321F4375B10);
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_front_04", "front", _id_372D8C5F69B0AE2E::_id_0B767805CA0E381E, undefined, undefined, undefined, undefined, undefined, undefined, "TAG_ACCESSORY_LEFT");
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_back_02", "back", _id_372D8C5F69B0AE2E::_id_279A32B2CDCE2B2B);
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_left_01"] = % vm_sp_takedown_pistol_left_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_right_01"] = % vm_sp_takedown_pistol_right_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_front_01"] = % vm_sp_takedown_pistol_front_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_back_01"] = % vm_sp_takedown_pistol_back_01_player;
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_pistol_left_01", "left", _id_372D8C5F69B0AE2E::_id_199C2718C1A3385F, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_pistol_right_01", "right", _id_372D8C5F69B0AE2E::_id_199C2718C1A3385F, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_pistol_front_01", "front", _id_372D8C5F69B0AE2E::_id_199C2718C1A3385F, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_pistol_back_01", "back", _id_372D8C5F69B0AE2E::_id_FDFBAA517A1C4018, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", _id_372D8C5F69B0AE2E::_id_EBEA6B350AF8FB8D, "vm_sp_takedown_pistol_left_01");
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", _id_372D8C5F69B0AE2E::_id_EBEA6B350AF8FB8D, "vm_sp_takedown_pistol_right_01");
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", _id_372D8C5F69B0AE2E::_id_EBEA6B350AF8FB8D, "vm_sp_takedown_pistol_front_01");
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", _id_372D8C5F69B0AE2E::_id_EBEA6B350AF8FB8D, "vm_sp_takedown_pistol_back_01");
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_left_02"] = % vm_sp_takedown_pistol_left_02_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_right_02"] = % vm_sp_takedown_pistol_right_02_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_front_02"] = % vm_sp_takedown_pistol_front_02_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_back_02"] = % vm_sp_takedown_pistol_back_02_player;
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_pistol_left_02", "left", _id_372D8C5F69B0AE2E::_id_199C2718C1A3385F, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_pistol_right_02", "right", _id_372D8C5F69B0AE2E::_id_199C2718C1A3385F, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_pistol_front_02", "front", _id_372D8C5F69B0AE2E::_id_199C2718C1A3385F, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_pistol_back_02", "back", _id_372D8C5F69B0AE2E::_id_FDFBAA517A1C4018, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", _id_372D8C5F69B0AE2E::_id_EBEA6B350AF8FB8D, "vm_sp_takedown_pistol_left_02");
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", _id_372D8C5F69B0AE2E::_id_EBEA6B350AF8FB8D, "vm_sp_takedown_pistol_right_02");
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", _id_372D8C5F69B0AE2E::_id_EBEA6B350AF8FB8D, "vm_sp_takedown_pistol_front_02");
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", _id_372D8C5F69B0AE2E::_id_EBEA6B350AF8FB8D, "vm_sp_takedown_pistol_back_02");
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_crouch_back_01"] = % vm_sp_takedown_knife_crouch_back_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_crouch_back_02"] = % vm_sp_takedown_knife_crouch_back_02_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_crouch_left_01"] = % vm_sp_takedown_knife_crouch_left_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_crouch_left_02"] = % vm_sp_takedown_knife_crouch_left_02_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_crouch_right_01"] = % vm_sp_takedown_knife_crouch_right_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_crouch_right_02"] = % vm_sp_takedown_knife_crouch_right_02_player;
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_crouch_back_01", "back", _id_372D8C5F69B0AE2E::_id_FA7CC1AD28B01833, undefined, "crouch", "crouch", undefined, undefined, undefined, "TAG_ACCESSORY_LEFT");
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_crouch_back_02", "back", _id_372D8C5F69B0AE2E::_id_FA7CC1AD28B01833, undefined, "crouch", "crouch");
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_crouch_left_01", "left", _id_372D8C5F69B0AE2E::_id_65931E2CBCA86748, undefined, "crouch", "crouch");
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_crouch_left_02", "left", _id_372D8C5F69B0AE2E::_id_65931E2CBCA86748, undefined, "crouch", "crouch");
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_crouch_right_01", "right", _id_372D8C5F69B0AE2E::_id_65931E2CBCA86748, undefined, "crouch", "crouch");
  scripts\common\utility::_id_7A5A6498179656FC("vm_sp_takedown_knife_crouch_right_02", "right", _id_372D8C5F69B0AE2E::_id_65931E2CBCA86748, undefined, "crouch", "crouch");
}

_id_65BBB083561FA648() {
  self._id_7E7071F7B9501085 = scripts\engine\sp\utility::spawn_anim_model("scripted_melee_player_rig", self.origin, self.angles);
  self._id_7E7071F7B9501085 scripts\common\anim::_id_01CB661B457551A3(1, self, 0.35);
}

_id_6C512ED7AF23EB04() {
  team3 = scripts\engine\sp\utility::get_all_closest_living(self.origin, getaiarray("team3"), 128, 0);
  enemies = scripts\engine\sp\utility::get_all_closest_living(self.origin, getaiarray("axis"), 128, 0);
  _id_765A8198C5E89918 = scripts\engine\utility::array_combine(team3, enemies);
  scripts\engine\utility::array_call(_id_765A8198C5E89918, ::_meth_F23F106F8976771D);
}

_id_B3CAB4BBBD2F27BF() {
  if(!getdvarint("dvar_301100A436CFDB2C"))
    self enableinvulnerability();

  self enablequickweaponswitch(1);
}

_id_53BC249DE0D47B05() {
  self disableinvulnerability();
  self enablequickweaponswitch(0);
}

_id_91C24157247EF2FC(guy) {
  _id_372D8C5F69B0AE2E::debug_print("start ragdoll via note");

  if(!isDefined(guy) && isDefined(guy._id_540E3C006CE71D3A._id_4187711225445340)) {
    foreach(corpse in getcorpsearray()) {
      if(istrue(corpse._id_91C24157247EF2FC)) {
        continue;
      }
      if(corpse isragdoll()) {
        continue;
      }
      _id_A4F5FB62BA3A113B = corpse.origin;

      if(getdvarint("ai_corpsesynch"))
        _id_A4F5FB62BA3A113B = corpse getcorpsephysicsorigin();

      if(isDefined(_id_A4F5FB62BA3A113B) && distancesquared(_id_A4F5FB62BA3A113B, guy._id_540E3C006CE71D3A._id_4187711225445340) < squared(60)) {
        _id_372D8C5F69B0AE2E::debug_print("do ragdoll via note");
        corpse startragdoll();
        corpse._id_91C24157247EF2FC = 1;
      }
    }
  } else if(isDefined(guy) && !istrue(guy._id_91C24157247EF2FC)) {
    guy thread _id_3433EE6B63C7E243::dropallaiweapons();
    _id_372D8C5F69B0AE2E::debug_print("do ragdoll via note");
    guy startragdoll();
    guy._id_91C24157247EF2FC = 1;
  }

  guy._id_540E3C006CE71D3A._id_4187711225445340 = undefined;
}

_id_6410C0421B1874AC() {
  rules = scripts\engine\utility::array_combine(_id_372D8C5F69B0AE2E::_id_E5433A928BC95CCA(), [::_id_29377F3B78DCB609]);
  return rules;
}

_id_29377F3B78DCB609(player, victim) {
  if(victim scripts\sp\fakeactor::is_fakeactor() || !isai(victim))
    return 0;

  return 1;
}

_id_5E2B19FD9204A302(_id_E3108E412AFB3811) {
  self playerlinkeduselinkedvelocity(_id_E3108E412AFB3811);
}