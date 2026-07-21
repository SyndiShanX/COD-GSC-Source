/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\animset.gsc
***********************************************/

init_anim_sets() {}

registerarchetype(var_0, var_1, var_2) {}

archetypeexists(var_0) {
  return archetypeassetloaded(var_0) || isDefined(anim.archetypes[var_0]);
}

init_animset_run_move() {}

init_animset_heat_run_move() {}

init_animset_walk_move() {}

init_animset_cqb_move() {}

init_animset_pistol_stand() {}

init_animset_rpg_stand() {}

init_animset_shotgun_stand() {}

init_animset_cqb_stand() {}

init_animset_heat_stand() {}

init_animset_heat_reload() {}

init_animset_default_stand() {}

init_animset_default_crouch() {}

init_animset_rpg_crouch() {}

init_animset_shotgun_crouch() {}

init_animset_default_prone() {}

init_animset_complete_custom_stand(var_0) {}

init_animset_custom_stand(var_0, var_1, var_2, var_3) {}

init_animset_complete_custom_crouch(var_0) {}

init_animset_custom_crouch(var_0, var_1, var_2) {}

clear_custom_animset() {
  self.custommoveanimset = undefined;
  self.customidleanimset = undefined;
  self.combatstandanims = undefined;
  self.combatcrouchanims = undefined;
}

set_animarray_standing_turns_pistol(var_0) {}

set_animarray_standing_turns() {}

set_animarray_crouching_turns() {}

set_animarray_stance_change() {}

set_animarray_burst_and_semi_fire_stand() {}

set_animarray_custom_burst_and_semi_fire_stand(var_0) {}

set_animarray_burst_and_semi_fire_crouch() {}

set_animarray_custom_burst_and_semi_fire_crouch(var_0) {}

set_animarray_add_turn_aims_stand() {}

set_animarray_add_turn_aims_crouch() {}

set_animarray_standing() {
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingsidearm())
    self.a.array = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanimarray("_encstr_A9130DDB507354D2F180EA23F78D1A");
  else if(isDefined(self.combatstandanims))
    self.a.array = self.combatstandanims;
  else if(isDefined(self.heat))
    self.a.array = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanimarray("_encstr_85180BA893BF41D1A3BB203A32");
  else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::usingrocketlauncher())
    self.a.array = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanimarray("_encstr_B6C20AD2779FA12BD368D3E3");
  else if(isDefined(self.weapon) && _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::weapon_pump_action_shotgun())
    self.a.array = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanimarray("_encstr_97310E3380DF74CFC5EA46578327AAC5");
  else if(_encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::iscqbwalking())
    self.a.array = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanimarray("_encstr_A5160A6E0F7D49B34BC06B4B");
  else
    self.a.array = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanimarray("_encstr_B27D0EE2797269554913B0E690069DAC");
}

set_animarray_crouching() {
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingsidearm())
    _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(self.primaryweapon, "_encstr_8253060E2B5FE330");

  if(isDefined(self.combatcrouchanims))
    self.a.array = self.combatcrouchanims;
  else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::usingrocketlauncher())
    self.a.array = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanimarray("_encstr_86CF0B888BE7B94740D8ADF672");
  else if(isDefined(self.weapon) && _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::weapon_pump_action_shotgun())
    self.a.array = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanimarray("_encstr_AB4E0F6E1A7B1D3BEADCF5369CBD5DC60D");
  else
    self.a.array = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanimarray("_encstr_968D0F91AC9958EA8D1DAFD827F657D80D");
}

set_animarray_prone() {
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingsidearm())
    _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(self.primaryweapon, "_encstr_8253060E2B5FE330");

  self.a.array = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanimarray("_encstr_B6DE0E8195BC80A3D9B31F1BCDA72818");
}

init_moving_turn_animations() {}

init_exposed_turn_animations() {}

init_grenade_animations() {}

init_animset_run_n_gun() {}

init_animset_ambush() {}

set_ambush_sidestep_anims() {
  self.a.moveanimset["_encstr_87C207DAF6D92BBE63"] = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanim("_encstr_81240791CBC8C34B18", "_encstr_87C207DAF6D92BBE63");
  self.a.moveanimset["_encstr_83C207AD7BB32BEB4E"] = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanim("_encstr_81240791CBC8C34B18", "_encstr_83C207AD7BB32BEB4E");
  self.a.moveanimset["_encstr_B2C207B86FA66177E2"] = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanim("_encstr_81240791CBC8C34B18", "_encstr_B2C207B86FA66177E2");
}

heat_reload_anim() {
  if(self.weapon != self.primaryweapon)
    return _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::animarraypickrandom("_encstr_AF4D07932B1BDE5846");

  if(isDefined(self.node)) {
    if(self nearclaimnodeandangle()) {
      var_0 = undefined;

      if(self.node.type == "_encstr_A7760B6710A315533959DF17AD")
        var_0 = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanim("_encstr_A1180CD02BB0A3F59C568DED2C46", "_encstr_8BD812D2E12827520D87BF97CDA52B5F90494FDB");
      else if(self.node.type == "_encstr_86A30C90489C3F32B21DA9AF0178")
        var_0 = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanim("_encstr_A1180CD02BB0A3F59C568DED2C46", "_encstr_850713F3F301C25108CEC6CDC3288A19E6035F1349");

      if(isDefined(var_0))
        return var_0;
    }
  }

  return _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::lookupanim("_encstr_A1180CD02BB0A3F59C568DED2C46", "_encstr_BA820F2051B3059BD039D185BD1028B9DB");
}