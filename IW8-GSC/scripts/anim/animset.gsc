/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\animset.gsc
***********************************************/

function init_anim_sets() {}

function registerarchetype(var0, var1, var2) {}

function archetypeexists(var0) {
  return archetypeassetloaded(var0) || isDefined(anim.archetypes[var0]);
}

function init_animset_run_move() {}

function init_animset_heat_run_move() {}

function init_animset_walk_move() {}

function init_animset_cqb_move() {}

function init_animset_pistol_stand() {}

function init_animset_rpg_stand() {}

function init_animset_shotgun_stand() {}

function init_animset_cqb_stand() {}

function init_animset_heat_stand() {}

function init_animset_heat_reload() {}

function init_animset_default_stand() {}

function init_animset_default_crouch() {}

function init_animset_rpg_crouch() {}

function init_animset_shotgun_crouch() {}

function init_animset_default_prone() {}

function init_animset_complete_custom_stand(var0) {}

function init_animset_custom_stand(var0, var1, var2, var3) {}

function init_animset_complete_custom_crouch(var0) {}

function init_animset_custom_crouch(var0, var1, var2) {}

function clear_custom_animset() {
  self.custommoveanimset = undefined;
  self.customidleanimset = undefined;
  self.combatstandanims = undefined;
  self.combatcrouchanims = undefined;
}

function set_animarray_standing_turns_pistol(var0) {}

function set_animarray_standing_turns() {}

function set_animarray_crouching_turns() {}

function set_animarray_stance_change() {}

function set_animarray_burst_and_semi_fire_stand() {}

function set_animarray_custom_burst_and_semi_fire_stand(var0) {}

function set_animarray_burst_and_semi_fire_crouch() {}

function set_animarray_custom_burst_and_semi_fire_crouch(var0) {}

function set_animarray_add_turn_aims_stand() {}

function set_animarray_add_turn_aims_crouch() {}

function set_animarray_standing() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    self.a.array = scripts\anim\utility::lookupanimarray("pistol_stand");
    return;
  }

  if(isDefined(self.combatstandanims)) {
    self.a.array = self.combatstandanims;
    return;
  }

  if(isDefined(self.heat)) {
    self.a.array = scripts\anim\utility::lookupanimarray("heat_stand");
    return;
  }

  if(scripts\anim\utility_common::usingrocketlauncher()) {
    self.a.array = scripts\anim\utility::lookupanimarray("rpg_stand");
    return;
  }

  if(isDefined(self.weapon) && scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    self.a.array = scripts\anim\utility::lookupanimarray("shotgun_stand");
    return;
  }

  if(scripts\anim\utility::iscqbwalking()) {
    self.a.array = scripts\anim\utility::lookupanimarray("cqb_stand");
    return;
  }

  self.a.array = scripts\anim\utility::lookupanimarray("default_stand");
}

function set_animarray_crouching() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  }

  if(isDefined(self.combatcrouchanims)) {
    self.a.array = self.combatcrouchanims;
    return;
  }

  if(scripts\anim\utility_common::usingrocketlauncher()) {
    self.a.array = scripts\anim\utility::lookupanimarray("rpg_crouch");
    return;
  }

  if(isDefined(self.weapon) && scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    self.a.array = scripts\anim\utility::lookupanimarray("shotgun_crouch");
    return;
  }

  self.a.array = scripts\anim\utility::lookupanimarray("default_crouch");
}

function set_animarray_prone() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  }

  self.a.array = scripts\anim\utility::lookupanimarray("default_prone");
}

function init_moving_turn_animations() {}

function init_exposed_turn_animations() {}

function init_grenade_animations() {}

function init_animset_run_n_gun() {}

function init_animset_ambush() {}

function set_ambush_sidestep_anims() {
  self.a.moveanimset["move_l"] = scripts\anim\utility::lookupanim("ambush", "move_l");
  self.a.moveanimset["move_r"] = scripts\anim\utility::lookupanim("ambush", "move_r");
  self.a.moveanimset["move_b"] = scripts\anim\utility::lookupanim("ambush", "move_b");
}

function heat_reload_anim() {
  if(self.weapon != self.primaryweapon) {
    return scripts\anim\utility::animarraypickrandom("reload");
  }

  if(isDefined(self.node)) {
    if(self nearclaimnodeandangle()) {
      var0 = undefined;

      if(self.node.type == "Cover Left") {
        var0 = scripts\anim\utility::lookupanim("heat_reload", "reload_cover_left");
      } else if(self.node.type == "Cover Right") {
        var0 = scripts\anim\utility::lookupanim("heat_reload", "reload_cover_right");
      }

      if(isDefined(var0)) {
        return var0;
      }
    }
  }

  return scripts\anim\utility::lookupanim("heat_reload", "reload_default");
}