/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_perks_sp.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_perks_sp;

perk_init(ref) {
  foreach(player in getplayers()) {
    perk = spawnstruct();
    perk.ref = ref;
    player.perk_refs[player.perk_refs.size] = perk;
  }
}

cac_get_dvar_int(dvar, def) {
  return int(cac_get_dvar(dvar, def));
}

cac_get_dvar(dvar, def) {
  if(getdvar(dvar) != "")
    return getdvarfloat(dvar);
  else {
    setdvar(dvar, def);
    return def;
  }
}

initperkdvars() {
  level.cac_armorpiercing_data = cac_get_dvar_int("perk_armorpiercing", "40") / 100;
  level.cac_bulletdamage_data = cac_get_dvar_int("perk_bulletDamage", "35");
  level.cac_fireproof_data = cac_get_dvar_int("perk_fireproof", "95");
  level.cac_armorvest_data = cac_get_dvar_int("perk_armorVest", "80");
  level.cac_explosivedamage_data = cac_get_dvar_int("perk_explosiveDamage", "25");
  level.cac_flakjacket_data = cac_get_dvar_int("perk_flakJacket", "35");
  level.cac_flakjacket_hardcore_data = cac_get_dvar_int("perk_flakJacket_hardcore", "9");
}

perks_init(usehud) {
  if(isDefined(level.sp_perks_initialized)) {
    return;
  }
  level.sp_perks_initialized = 1;
  level.armorpiercing_data = 0.4;
  level.bulletdamage_data = 1.35;
  level.armorvest_data = 0.8;
  level.explosivedamage_data = 25;
  level.flakjacket_data = 35;
  level.blink_warning = 5000;
  level.icon_fullbright_alpha = 0.85;
  level.icon_halfbright_alpha = 0.2;

  if(!isDefined(level.player_perk_slots))
    level.player_perk_slots = 3;

  foreach(player in getplayers()) {
    player.perk_slots = [];
    player.perk_refs = [];

    for(i = 0; i < level.player_perk_slots; i++) {
      player.perk_slots[i] = spawnstruct();
      player.perk_slots[i].ref = "";
      player.perk_slots[i].expire = -1;
    }

    player thread maps\_perks_sp::perk_hud();
    pos_x = 200 - level.player_perk_slots * 28;

    for(i = 0; i < level.player_perk_slots; i++) {
      player.perk_slots[i].pos_x = pos_x;
      player.perk_slots[i].pos_y = 186;
      player.perk_slots[i].icon_size = 28;
      player.perk_slots[i].icon = undefined;
      pos_x = pos_x + 30;
    }
  }

  perk_init("specialty_brutestrength");
  perk_init("specialty_intruder");
  perk_init("specialty_trespasser");
  perk_init("specialty_longersprint");
  perk_init("specialty_unlimitedsprint");
  perk_init("specialty_endurance");
  perk_init("specialty_flakjacket");
  perk_init("specialty_deadshot");
  perk_init("specialty_fastads");
  perk_init("specialty_rof");
  perk_init("specialty_fastreload");
  perk_init("specialty_fastweaponswitch");
  perk_init("specialty_fastmeleerecovery");
  perk_init("specialty_bulletdamage");
  perk_init("specialty_armorvest");
  perk_init("specialty_detectexplosive");
  perk_init("specialty_holdbreath");
}

find_perk(ref) {
  foreach(perk in self.perk_refs) {
    if(perk.ref == ref)
      return perk;
  }

  return undefined;
}

find_free_slot() {
  for(i = 0; i < level.player_perk_slots; i++) {
    if(self.perk_slots[i].ref == "")
      return i;
  }

  return undefined;
}

find_slot_by_ref(ref) {
  assert(isDefined(ref), "Invalid perk ref passed into find_slot_by_ref" + ref);

  for(i = 0; i < level.player_perk_slots; i++) {
    if(self.perk_slots[i].ref == ref)
      return i;
  }

  return undefined;
}

has_perk(ref) {
  return isDefined(find_slot_by_ref(ref));
}

give_perk(give_ref) {
  perk = self find_perk(give_ref);
  assert(isDefined(perk), "Undefined/unsupported perk. " + give_ref);

  if(has_perk(give_ref))
    return true;

  if(!isDefined(self find_free_slot()))
    return false;

  slot = self find_free_slot();
  assert(isDefined(slot));
  self.perk_slots[slot].ref = give_ref;
  self.perk_slots[slot].expire = -1;
  self setperk(give_ref);
  self notify("give_perk", give_ref);
  self notify("perk_update", give_ref);
  return true;
}

give_perk_for_a_time(give_ref, timeinsec) {
  if(self give_perk(give_ref)) {
    slot = find_slot_by_ref(give_ref);
    self.perk_slots[slot].expire = gettime() + timeinsec * 1000;
    self thread perk_expire_watcher();
  }
}

perk_expire_watcher() {
  self endon("death");
  self notify("perk_watcher");
  self endon("perk_watcher");
  done = 0;

  while(!done) {
    done = 1;

    for(i = 0; i < level.player_perk_slots; i++) {
      if(self.perk_slots[i].expire != -1) {
        current_time = gettime();
        done = 0;

        if(current_time > self.perk_slots[i].expire)
          take_perk_by_slot(i);
      }
    }

    wait 1;
  }
}

take_perk(take_ref) {
  assert(isDefined(self find_perk(take_ref)), "Undefined/unsupported perk." + take_ref);

  if(!has_perk(take_ref)) {
    return;
  }
  slot = self find_slot_by_ref(take_ref);
  self.perk_slots[slot].ref = "";
  self.perk_slots[slot].expire = -1;
  self unsetperk(take_ref);
  self notify("take_perk", take_ref);
  self notify("perk_update", take_ref);
  wait 0.05;
}

take_perk_by_slot(slot) {
  if(self.perk_slots[slot].ref != "")
    take_perk(self.perk_slots[slot].ref);
}

take_all_perks() {
  foreach(perk in self.perk_refs)
  self unsetperk(perk.ref);

  for(i = 0; i < level.player_perk_slots; i++)
    take_perk_by_slot(i);
}

show_perks() {
}

hide_perks() {
}

update_on_give_perk() {
  self endon("death");

  while(true) {
    self waittill("give_perk", ref);
    self flag_set("HUD_giving_perk");

    while(self flag("HUD_taking_perk"))
      wait 0.05;

    wait 1;
    self flag_clear("HUD_giving_perk");
  }
}

update_on_take_perk() {
  self endon("death");

  while(true) {
    self waittill("take_perk", ref);
    self flag_set("HUD_taking_perk");

    while(self flag("HUD_giving_perk"))
      wait 0.05;

    wait 1;
    self flag_clear("HUD_taking_perk");
  }
}

perk_hud() {
  self endon("death");
  self flag_init("HUD_giving_perk");
  self flag_init("HUD_taking_perk");
  self thread update_on_give_perk();
  self thread update_on_take_perk();

  while(true) {
    self waittill("perk_update", ref);
    slot = self find_slot_by_ref(ref);

    if(isDefined(slot)) {
    } else {
    }
  }
}