/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_equip_gasmask.gsc
**********************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#using_animtree("generic_human");
init() {
  if(!maps\_zombiemode_equipment::is_equipment_included("equip_gasmask_zm")) {
    return;
  }
  level._CF_PLAYER_GASMASK_OVERLAY = 9;
  maps\_zombiemode_equipment::register_equipment("equip_gasmask_zm", & "ZOMBIE_EQUIP_GASMASK_PICKUP_HINT_STRING", & "ZOMBIE_EQUIP_GASMASK_HOWTO", "gasmask", ::gasmask_activation_watcher_thread);
  PreCacheItem("lower_equip_gasmask_zm");
  level thread gasmask_on_player_connect();
}

gasmask_on_player_connect() {
  for(;;) {
    level waittill("connecting", player);
  }
}

gasmask_removed_watcher_thread() {
  self notify("only_one_gasmask_removed_thread");
  self endon("only_one_gasmask_removed_thread");
  self endon("disconnect");
  self waittill("equip_gasmask_zm_taken");
  if(isDefined(level.zombiemode_gasmask_reset_player_model)) {
    ent_num = self getEntityNumber();
    if(isDefined(self.zm_random_char)) {
      ent_num = self.zm_random_char;
    }
    self[[level.zombiemode_gasmask_reset_player_model]](ent_num);
  }
  if(isDefined(level.zombiemode_gasmask_reset_player_viewmodel)) {
    ent_num = self getEntityNumber();
    if(isDefined(self.zm_random_char)) {
      ent_num = self.zm_random_char;
    }
    self[[level.zombiemode_gasmask_reset_player_viewmodel]](ent_num);
  }
  self clearclientflag(level._CF_PLAYER_GASMASK_OVERLAY);
}

gasmask_activation_watcher_thread() {
  self endon("zombified");
  self endon("disconnect");
  self endon("equip_gasmask_zm_taken");
  self thread gasmask_removed_watcher_thread();
  self thread remove_gasmask_on_player_bleedout();
  self thread remove_gasmask_on_game_over();
  if(isDefined(level.zombiemode_gasmask_set_player_model)) {
    ent_num = self getEntityNumber();
    if(isDefined(self.zm_random_char)) {
      ent_num = self.zm_random_char;
    }
    self[[level.zombiemode_gasmask_set_player_model]](ent_num);
  }
  if(isDefined(level.zombiemode_gasmask_set_player_viewmodel)) {
    ent_num = self getEntityNumber();
    if(isDefined(self.zm_random_char)) {
      ent_num = self.zm_random_char;
    }
    self[[level.zombiemode_gasmask_set_player_viewmodel]](ent_num);
  }
  while(1) {
    self waittill_either("equip_gasmask_zm_activate", "equip_gasmask_zm_deactivate");
    if(self maps\_zombiemode_equipment::is_equipment_active("equip_gasmask_zm")) {
      self increment_is_drinking();
      self SetActionSlot(1, "");
      if(isDefined(level.zombiemode_gasmask_set_player_model)) {
        ent_num = self getEntityNumber();
        if(isDefined(self.zm_random_char)) {
          ent_num = self.zm_random_char;
        }
        self[[level.zombiemode_gasmask_change_player_headmodel]](ent_num, true);
      }
      clientnotify("gmsk2");
      self waittill("weapon_change_complete");
      self setclientflag(level._CF_PLAYER_GASMASK_OVERLAY);
    } else {
      self increment_is_drinking();
      self SetActionSlot(1, "");
      if(isDefined(level.zombiemode_gasmask_set_player_model)) {
        ent_num = self getEntityNumber();
        if(isDefined(self.zm_random_char)) {
          ent_num = self.zm_random_char;
        }
        self[[level.zombiemode_gasmask_change_player_headmodel]](ent_num, false);
      }
      self TakeWeapon("equip_gasmask_zm");
      self GiveWeapon("lower_equip_gasmask_zm");
      self SwitchToWeapon("lower_equip_gasmask_zm");
      wait(0.05);
      self clearclientflag(level._CF_PLAYER_GASMASK_OVERLAY);
      self waittill("weapon_change_complete");
      self TakeWeapon("lower_equip_gasmask_zm");
      self GiveWeapon("equip_gasmask_zm");
    }
    if(!self maps\_laststand::player_is_in_laststand()) {
      if(self is_multiple_drinking()) {
        self decrement_is_drinking();
        self setactionslot(1, "weapon", "equip_gasmask_zm");
        self notify("equipment_select_response_done");
        continue;
      } else if(isDefined(self.prev_weapon_before_equipment_change) && self hasWeapon(self.prev_weapon_before_equipment_change)) {
        if(self.prev_weapon_before_equipment_change != self GetCurrentWeapon()) {
          self SwitchToWeapon(self.prev_weapon_before_equipment_change);
          self waittill("weapon_change_complete");
        }
      } else {
        primaryWeapons = self GetWeaponsListPrimaries();
        if(isDefined(primaryWeapons) && primaryWeapons.size > 0) {
          if(primaryWeapons[0] != self GetCurrentWeapon()) {
            self SwitchToWeapon(primaryWeapons[0]);
            self waittill("weapon_change_complete");
          }
        } else {
          self SwitchToWeapon(get_player_melee_weapon());
        }
      }
    }
    self setactionslot(1, "weapon", "equip_gasmask_zm");
    if(!self maps\_laststand::player_is_in_laststand() && !is_true(self.intermission)) {
      self decrement_is_drinking();
    }
    self notify("equipment_select_response_done");
  }
}

remove_gasmask_on_player_bleedout() {
  self endon("equip_gasmask_zm_taken");
  self waittill("bled_out");
  self clearclientflag(level._CF_PLAYER_GASMASK_OVERLAY);
}

remove_gasmask_on_game_over() {
  self endon("equip_gasmask_zm_taken");
  level waittill("pre_end_game");
  self clearclientflag(level._CF_PLAYER_GASMASK_OVERLAY);
}

gasmask_active() {
  return (self maps\_zombiemode_equipment::is_equipment_active("equip_gasmask_zm"));
}

gasmask_debug_print(msg, color) {}