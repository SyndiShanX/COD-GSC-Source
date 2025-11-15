/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\ability_util.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\util_shared;

#namespace ability_util;

gadget_is_type(slot, type) {
  if(!isDefined(self._gadgets_player) || !isDefined(self._gadgets_player[slot])) {
    return false;
  }

  return self._gadgets_player[slot].gadget_type == type;
}

gadget_slot_for_type(type) {
  invalid = 3;

  for(i = 0; i < 3; i++) {
    if(!self gadget_is_type(i, type)) {
      continue;
    }

    return i;
  }

  return invalid;
}

gadget_combat_efficiency_enabled() {
  if(isDefined(self._gadget_combat_efficiency)) {
    return self._gadget_combat_efficiency;
  }

  return 0;
}

function_43cda488() {
  if(isDefined(self.team)) {
    teammates = getplayers(self.team);

    foreach(player in teammates) {
      if(player gadget_combat_efficiency_enabled()) {
        return true;
      }
    }
  }

  return false;
}

function_f71ec759(&suppliers, var_5ce08260) {
  if(isDefined(self.team)) {
    teammates = getplayers(self.team);

    foreach(teammate in teammates) {
      if(!isDefined(teammate)) {
        continue;
      }

      if(teammate == self && var_5ce08260) {
        continue;
      }

      if(teammate gadget_combat_efficiency_enabled()) {
        suppliers[teammate getentitynumber()] = teammate;
      }
    }
  }
}

gadget_combat_efficiency_power_drain(score) {
  powerchange = -1 * score * getdvarfloat(#"scr_combat_efficiency_power_loss_scalar", 0);
  slot = gadget_slot_for_type(12);

  if(slot != 3) {
    self gadgetpowerchange(slot, powerchange);
  }
}

function_e35551d6() {
  a_weaponlist = self getweaponslist();

  foreach(weapon in a_weaponlist) {
    if(isDefined(weapon) && weapon.isgadget) {
      self takeweapon(weapon);
    }
  }
}

ability_give(weapon_name) {
  weapon = getweapon(weapon_name);
  self giveweapon(weapon);
}

is_weapon_gadget(weapon) {
  return weapon.gadget_type != 0;
}

gadget_power_reset(gadgetweapon) {
  if(isDefined(gadgetweapon)) {
    slot = self gadgetgetslot(gadgetweapon);

    if(slot >= 0 && slot < 3) {
      self gadgetpowerreset(slot);
      self gadgetcharging(slot, 1);
    }

    return;
  }

  for(slot = 0; slot < 3; slot++) {
    self gadgetpowerreset(slot);
    self gadgetcharging(slot, 1);
  }
}

gadget_power_full(gadgetweapon) {
  if(isDefined(gadgetweapon)) {
    slot = self gadgetgetslot(gadgetweapon);

    if(slot >= 0 && slot < 3) {
      self gadgetpowerset(slot, 100);
      self gadgetcharging(slot, 0);
    }

    return;
  }

  for(slot = 0; slot < 3; slot++) {
    self gadgetpowerset(slot, 100);
    self gadgetcharging(slot, 0);
  }
}

function_1a38f0b0(gadgetweapon) {
  if(isDefined(gadgetweapon)) {
    slot = self gadgetgetslot(gadgetweapon);

    if(isDefined(slot) && slot >= 0 && slot < 3) {
      self function_820a63e9(slot, 0);
    }

    return;
  }

  for(slot = 0; slot < 3; slot++) {
    self function_820a63e9(slot, 0);
  }
}

function_e8aa75b8(gadgetweapon) {
  if(isDefined(gadgetweapon)) {
    slot = self gadgetgetslot(gadgetweapon);

    if(slot >= 0 && slot < 3) {
      self gadgetpowerreset(slot);
      self function_820a63e9(slot, 1);
    }

    return;
  }

  for(slot = 0; slot < 3; slot++) {
    self gadgetpowerreset(slot);
    self function_820a63e9(slot, 1);
  }
}

function_46b37314(fill_power) {
  if(isDefined(self.playerrole) && isDefined(self.playerrole.primaryequipment)) {
    gadget_weapon = getweapon(self.playerrole.primaryequipment);

    if(isDefined(gadget_weapon)) {
      self function_1a38f0b0(gadget_weapon);

      if(isDefined(fill_power) && fill_power) {
        self gadget_power_full(gadget_weapon);
      }
    }
  }
}

function_ffd29673(fill_power) {
  if(isDefined(self.playerrole) && isDefined(self.playerrole.var_c21d61e9)) {
    gadget_weapon = getweapon(self.playerrole.var_c21d61e9);

    if(isDefined(gadget_weapon)) {
      self function_1a38f0b0(gadget_weapon);

      if(isDefined(fill_power) && fill_power) {
        self gadget_power_full(gadget_weapon);
      }
    }
  }
}

function_b6d7e7e0(fill_power) {
  if(isDefined(self.playerrole) && isDefined(self.playerrole.ultimateweapon)) {
    gadget_weapon = getweapon(self.playerrole.ultimateweapon);

    if(isDefined(gadget_weapon)) {
      self function_1a38f0b0(gadget_weapon);

      if(isDefined(fill_power) && fill_power) {
        self gadget_power_full(gadget_weapon);
      }
    }
  }
}

function_e5c7425d() {
  if(isDefined(self.playerrole) && isDefined(self.playerrole.primaryequipment)) {
    gadget_weapon = getweapon(self.playerrole.primaryequipment);

    if(isDefined(gadget_weapon)) {
      self function_e8aa75b8(gadget_weapon);
    }
  }
}

function_2bf97041() {
  if(isDefined(self.playerrole) && isDefined(self.playerrole.var_c21d61e9)) {
    gadget_weapon = getweapon(self.playerrole.var_c21d61e9);

    if(isDefined(gadget_weapon)) {
      self function_e8aa75b8(gadget_weapon);
    }
  }
}

function_791aef0d() {
  if(isDefined(self.playerrole) && isDefined(self.playerrole.ultimateweapon)) {
    gadget_weapon = getweapon(self.playerrole.ultimateweapon);

    if(isDefined(gadget_weapon)) {
      self function_e8aa75b8(gadget_weapon);
    }
  }
}

gadget_reset(gadgetweapon, changedclass, roundbased, firstround, changedspecialist) {
  slot = self gadgetgetslot(gadgetweapon);

  if(slot >= 0 && slot < 3) {
    if(isDefined(self.pers[#"held_gadgets_power"]) && isDefined(self.pers[#"held_gadgets_power"][gadgetweapon])) {
      self gadgetpowerset(slot, self.pers[#"held_gadgets_power"][gadgetweapon]);
    } else if(isDefined(self.pers[#"held_gadgets_power"]) && isDefined(self.pers[#"thiefweapon"]) && isDefined(self.pers[#"held_gadgets_power"][self.pers[#"thiefweapon"]])) {
      self gadgetpowerset(slot, self.pers[#"held_gadgets_power"][self.pers[#"thiefweapon"]]);
    } else if(isDefined(self.pers[#"held_gadgets_power"]) && isDefined(self.pers[#"rouletteweapon"]) && isDefined(self.pers[#"held_gadgets_power"][self.pers[#"rouletteweapon"]])) {
      self gadgetpowerset(slot, self.pers[#"held_gadgets_power"][self.pers[#"rouletteweapon"]]);
    }

    if(isDefined(self.pers[#"hash_7a954c017d693f69"]) && isDefined(self.pers[#"hash_7a954c017d693f69"][gadgetweapon])) {
      self function_19ed70ca(slot, self.pers[#"hash_7a954c017d693f69"][gadgetweapon]);
    }

    isfirstspawn = isDefined(self.firstspawn) ? self.firstspawn : 1;
    resetonclasschange = changedclass && gadgetweapon.gadget_power_reset_on_class_change;
    resetonfirstround = isfirstspawn && (!roundbased || firstround);
    resetonroundswitch = roundbased && !firstround && gadgetweapon.gadget_power_reset_on_round_switch;
    resetonteamchanged = !isfirstspawn && isDefined(self.switchedteamsresetgadgets) && self.switchedteamsresetgadgets && gadgetweapon.gadget_power_reset_on_team_change;
    var_1a2cf487 = changedspecialist && getdvarint(#"hash_256144ebda864b87", 0) && !(isDefined(level.ingraceperiod) && level.ingraceperiod && !(isDefined(self.hasdonecombat) && self.hasdonecombat));
    var_9468eb59 = isDefined(self.switchedteamsresetgadgets) && self.switchedteamsresetgadgets && getdvarint(#"hash_8351525729015ab", 0);
    deployed = 0;

    if(isDefined(self.pers[#"hash_68cdf8807cfaabff"]) && isDefined(self.pers[#"hash_68cdf8807cfaabff"][gadgetweapon]) && self.pers[#"hash_68cdf8807cfaabff"][gadgetweapon]) {
      if((gadgetweapon.var_7b5016a7 || !changedclass) && !isfirstspawn) {
        deployed = 1;
        self function_ac25fc1f(slot, gadgetweapon);
      }
    }

    var_2069cdca = changedclass && level.competitivesettingsenabled && roundbased && !firstround && !slot;

    if(var_2069cdca) {
      if(isDefined(self.pers[#"held_gadgets_power"]) && isDefined(self.pers[#"held_gadgets_power"][gadgetweapon])) {
        var_2069cdca = 0;
      }
    }

    if(var_1a2cf487 || var_9468eb59 || var_2069cdca) {
      self gadgetpowerset(slot, 0);
      self.pers[#"herogadgetnotified"][slot] = 0;

      if(!deployed) {
        self gadgetcharging(slot, 1);
      }

      return;
    }

    if(resetonclasschange || resetonfirstround || resetonroundswitch || resetonteamchanged) {
      self gadgetpowerreset(slot, isfirstspawn);
      self.pers[#"herogadgetnotified"][slot] = 0;

      if(!deployed) {
        self gadgetcharging(slot, 1);
      }
    }
  }
}

gadget_power_armor_on() {
  return gadget_is_active(3);
}

gadget_is_active(gadgettype) {
  slot = self gadget_slot_for_type(gadgettype);

  if(slot >= 0 && slot < 3) {
    if(self util::gadget_is_in_use(slot)) {
      return true;
    }
  }

  return false;
}

gadget_has_type(gadgettype) {
  slot = self gadget_slot_for_type(gadgettype);

  if(slot >= 0 && slot < 3) {
    return true;
  }

  return false;
}

aoe_friendlies(weapon, aoe) {
  self endon(#"disconnect", aoe.aoe_think_singleton_event);
  start_time = gettime();
  end_time = start_time + aoe.duration;

  if(!isDefined(self) || !isDefined(self.team)) {
    return;
  }

  profile_script = getdvarint(#"scr_profile_aoe", 0);

  if(profile_script) {
    profile_start_time = util::get_start_time();
    profile_elapsed_times = [];
    extra_profile_time = 1000;
    end_time += extra_profile_time;
  }

  has_reapply_check = isDefined(aoe.check_reapply_time_func);
  aoe_team = self.team;
  aoe_applied = 0;
  frac = 0;

  while(frac < 1 || aoe_applied > 0) {
    settings = getscriptbundle(weapon.customsettings);
    frac = (gettime() - start_time) / aoe.duration;

    if(frac > 1) {
      frac = 1;
    }

    radius = settings.cleanseradius;
    aoe_applied = 0;

    if(isDefined(self) && isDefined(self.origin)) {
      aoe_origin = self.origin;
    }

    friendlies_in_radius = getplayers(aoe_team, aoe_origin, radius);

    foreach(player in friendlies_in_radius) {
      if(has_reapply_check && player[[aoe.check_reapply_time_func]](aoe)) {
        continue;
      }

      if(!isalive(player)) {
        continue;
      }

      if(!isDefined(aoe.can_apply_aoe_func) || [
          [aoe.can_apply_aoe_func]
        ](player, aoe.origin)) {
        [
          [aoe.apply_aoe_func]
        ](player, weapon, aoe);
        aoe_applied++;

        if(aoe_applied >= aoe.max_applies_per_frame) {
          break;
        }
      }
    }

    if(profile_script) {
      util::record_elapsed_time(profile_start_time, profile_elapsed_times);
      waitframe(1);
      profile_start_time = util::get_start_time();
      continue;
    }

    waitframe(1);
  }

  if(profile_script) {
    util::note_elapsed_times(profile_elapsed_times, "util aoe friendlies");
  }
}

aoe_trace_entity(entity, origin, trace_z_offset) {
  entitypoint = entity.origin + (0, 0, trace_z_offset);

  if(!bullettracepassed(origin, entitypoint, 1, self, undefined, 0, 1)) {
    return false;
  }

  thread util::draw_debug_line(origin, entitypoint, 1);

  return true;
}

is_hero_weapon(gadgetweapon) {
  if((gadgetweapon.isheavyweapon || gadgetweapon.issignatureweapon) && gadgetweapon.gadget_type == 11) {
    return true;
  }

  return false;
}