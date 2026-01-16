/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_deathcard.gsc
******************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include animscripts\zombie_Utility;

init() {
  flag_wait("all_players_connected");
  players = get_players();
  if(players.size > 0) {
    for(i = 0; i < players.size; i++) {
      level.deathcards[i] = SpawnStruct();
    }
    level.deathcard_laststand_func = ::deathcard_laststand;
    if(players.size > 1) {
      level.deathcard_spawn_func = ::deathcard_spawn;
    }
  }
}

deathcard_spawn() {
  dc = spawn("script_model", self.origin + (0, 0, 40));
  dc.angles = self.angles;
  dc setModel("zombie_revive");
  dc.player = self;
  dc thread deathcard_timeout();
  dc thread deathcard_wobble();
  dc thread deathcard_grab();
  self.pro_tip_death_card_round = level.round_number + 1;
}

deathcard_laststand() {
  players = get_players();
  if(players.size == 1) {
    dc = level.deathcards[0];
    dc.player = self;
    dc.weapon = [];
    dc.score = self.score;
    primaries = self GetWeaponsListPrimaries();
    dc.weapon[0] = primaries[0];
    dc.current_weapon = 0;
    if(primaries.size > 1) {
      dc.weapon[1] = primaries[1];
      currentWeapon = self GetCurrentWeapon();
      if(currentWeapon == dc.weapon[1]) {
        dc.current_weapon = 1;
      }
    }
    dc.curr_ability = self.curr_ability;
    if(maps\_zombiemode_weap_cymbal_monkey::cymbal_monkey_exists()) {
      dc.zombie_cymbal_monkey_count = self getweaponammoclip("zombie_cymbal_monkey");
    }
  } else {
    for(i = 0; i < players.size; i++) {
      if(players[i] == self) {
        dc = level.deathcards[i];
        dc.player = self;
        dc.weapon = [];
        dc.current_weapon = -1;
        dc.score = int(self.score * 0.5);
        primaries = self GetWeaponsListPrimaries();
        if(primaries[0] == "m1911_zm") {
          dc.weapon[0] = "none";
        } else {
          dc.weapon[0] = primaries[0];
          stock = self GetWeaponAmmoStock(primaries[0]);
          dc.stockCount[0] = int(stock * 0.5);
          dc.current_weapon = 0;
        }
        if(primaries.size > 1) {
          if(primaries[1] == "m1911_zm") {
            dc.weapon[1] = "none";
          } else {
            dc.weapon[1] = primaries[1];
            stock = self GetWeaponAmmoStock(primaries[1]);
            dc.stockCount[1] = int(stock * 0.5);
            currentWeapon = players[i] GetCurrentWeapon();
            if(currentWeapon == dc.weapon[1]) {
              dc.current_weapon = 1;
            } else {
              dc.current_weapon = 0;
            }
          }
        } else {
          dc.weapon[1] = "none";
        }
        dc.perk = deathcard_save_perks(self);
        dc.curr_ability = self.curr_ability;
        if(maps\_zombiemode_weap_cymbal_monkey::cymbal_monkey_exists()) {
          dc.zombie_cymbal_monkey_count = self getweaponammoclip("zombie_cymbal_monkey");
        }
      }
    }
  }
}

deathcard_save_perks(ent) {
  idx = 0;
  perk_array = undefined;
  if(ent HasPerk("specialty_armorvest")) {
    perk_array[idx] = "specialty_armorvest";
    idx++;
  } else if(ent HasPerk("specialty_armorvest_upgrade")) {
    perk_array[idx] = "specialty_armorvest_upgrade";
    idx++;
  }
  if(ent HasPerk("specialty_quickrevive")) {
    perk_array[idx] = "specialty_quickrevive";
    idx++;
  } else if(ent HasPerk("specialty_quickrevive_upgrade")) {
    perk_array[idx] = "specialty_quickrevive_upgrade";
    idx++;
  }
  if(ent HasPerk("specialty_fastreload")) {
    perk_array[idx] = "specialty_fastreload";
    idx++;
  } else if(ent HasPerk("specialty_fastreload_upgrade")) {
    perk_array[idx] = "specialty_fastreload_upgrade";
    idx++;
  }
  return (perk_array);
}

deathcard_grab() {
  self endon("deatchcard_timedout");
  wait(1);
  while(isDefined(self)) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i].is_zombie) {
        continue;
      }
      if(players[i] == self.player) {
        dist = distance(players[i].origin, self.origin);
        if(dist < 64) {
          playfx(level._effect["powerup_grabbed"], self.origin);
          playfx(level._effect["powerup_grabbed_wave"], self.origin);
          players[i] deathcard_give(i);
          wait(0.1);
          playsoundatposition("zmb_powerup_grabbed_3p", self.origin);
          self stopLoopSound();
          self delete();
          self notify("deathcard_grabbed");
          players[i] clientnotify("dc0");
        }
      }
    }
    wait_network_frame();
  }
}

deathcard_give(index) {
  dc = level.deathcards[index];
  if(dc.current_weapon >= 0) {
    weapon = undefined;
    stock = 0;
    needSwitch = false;
    if(dc.weapon[dc.current_weapon] != "none" && !self hasWeapon(dc.weapon[dc.current_weapon])) {
      weapon = dc.weapon[dc.current_weapon];
      stock = dc.stockCount[dc.current_weapon];
      needSwitch = true;
    } else {
      for(i = 0; i < 2; i++) {
        if(dc.current_weapon == i || dc.weapon[i] == "none") {
          continue;
        }
        if(!self hasWeapon(dc.weapon[i])) {
          weapon = dc.weapon[i];
          stock = dc.stockCount[i];
        }
      }
    }
    if(isDefined(weapon)) {
      primaries = self GetWeaponsListPrimaries();
      if(primaries.size >= 2) {
        takeWeapon = undefined;
        if(primaries[0] == "m1911_zm" || primaries[1] == "m1911_zm") {
          takeWeapon = "m1911_zm";
        } else {
          takeWeapon = self GetCurrentWeapon();
        }
        self TakeWeapon(takeWeapon);
      }
      self GiveWeapon(weapon, 0);
      self SetWeaponAmmoClip(weapon, WeaponClipSize(weapon));
      self SetWeaponAmmoStock(weapon, stock);
      if(needSwitch) {
        self SwitchToWeapon(weapon, 0);
      }
    }
  }
  if(isDefined(dc.perk)) {
    oldPerks = dc.perk.size;
    if(oldPerks >= 2) {
      newPerks = int(oldPerks * 0.5);
      for(i = 0; i < dc.perk.size; i++) {
        if(self HasPerk(dc.perk[i])) {
          continue;
        }
        remaining = dc.perk.size - i;
        if(remaining <= newPerks || randomInt(100) > 50) {
          maps\_zombiemode_perks::give_perk(dc.perk[i]);
          newPerks--;
        }
        if(newPerks == 0) {
          break;
        }
      }
    }
  }
  if(maps\_zombiemode_weap_cymbal_monkey::cymbal_monkey_exists()) {
    if(dc.zombie_cymbal_monkey_count) {
      self giveweapon("zombie_cymbal_monkey");
      self setweaponammoclip("zombie_cymbal_monkey", dc.zombie_cymbal_monkey_count);
    }
  }
}

deathcard_give_solo() {
  dc = level.deathcards[0];
  self maps\_zombiemode::laststand_giveback_player_perks();
  take = true;
  startWeapon = dc.weapon[dc.current_weapon];
  if(startWeapon == "m1911_zm") {
    take = false;
  }
  currentWeapon = self GetCurrentWeapon();
  if(currentWeapon != "none" && take) {
    self TakeWeapon(currentWeapon);
  }
  for(i = 0; i < 2; i++) {
    if(isDefined(dc.weapon[i])) {
      weapon = dc.weapon[i];
      if(weapon != "m1911_zm" || take) {
        self GiveWeapon(weapon, 0);
        self SetWeaponAmmoClip(weapon, WeaponClipSize(weapon));
        self GiveStartAmmo(weapon);
      }
    }
  }
  if(dc.current_weapon >= 0 && take) {
    self SwitchToWeapon(dc.weapon[dc.current_weapon], 0);
  }
  if(maps\_zombiemode_weap_cymbal_monkey::cymbal_monkey_exists()) {
    if(dc.zombie_cymbal_monkey_count) {
      self giveweapon("zombie_cymbal_monkey");
      self setweaponammoclip("zombie_cymbal_monkey", dc.zombie_cymbal_monkey_count);
    }
  }
}

deathcard_wobble() {
  self endon("deathcard_grabbed");
  self endon("deathcard_timedout");
  if(isDefined(self)) {
    playfxontag(level._effect["powerup_on"], self, "tag_origin");
    self playsound("zmb_spawn_powerup");
    self playLoopSound("evt_death_card_loop");
  }
  while(isDefined(self)) {
    self rotateyaw(360, 3, 3, 0);
    wait(3);
  }
}

deathcard_timeout() {
  self endon("deathcard_grabbed");
  level waittill("between_round_over");
  wait(1);
  level waittill("between_round_over");
  self hide();
  self notify("deathcard_timedout");
  self delete();
}