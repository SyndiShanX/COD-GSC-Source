/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_margwa.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\margwa;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_ai_margwa_elemental;
#using scripts\zm\_zm_ai_margwa_no_idgun;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_genesis_challenges;
#using scripts\zm\zm_genesis_portals;
#namespace zm_genesis_margwa;

function autoexec init() {
  function_e84ffe9c();
  spawner::add_archetype_spawn_function("margwa", & function_57c223eb);
  margwabehavior::adddirecthitweapon("turret_zm_genesis");
  margwabehavior::adddirecthitweapon("shotgun_energy");
  margwabehavior::adddirecthitweapon("shotgun_energy_upgraded");
  margwabehavior::adddirecthitweapon("pistol_energy");
  margwabehavior::adddirecthitweapon("pistol_energy_upgraded");
  if(!isDefined(level.var_fd47363)) {
    level.var_fd47363 = [];
    level.var_fd47363["head_le"] = "c_zom_dlc4_margwa_chunks_le";
    level.var_fd47363["head_mid"] = "c_zom_dlc4_margwa_chunks_mid";
    level.var_fd47363["head_ri"] = "c_zom_dlc4_margwa_chunks_ri";
    level.var_fd47363["gore_le"] = "c_zom_dlc4_margwa_gore_le";
    level.var_fd47363["gore_mid"] = "c_zom_dlc4_margwa_gore_mid";
    level.var_fd47363["gore_ri"] = "c_zom_dlc4_margwa_gore_ri";
    level.margwa_head_left_model_override = level.var_fd47363["head_le"];
    level.margwa_head_mid_model_override = level.var_fd47363["head_mid"];
    level.margwa_head_right_model_override = level.var_fd47363["head_ri"];
    level.margwa_gore_left_model_override = level.var_fd47363["gore_le"];
    level.margwa_gore_mid_model_override = level.var_fd47363["gore_mid"];
    level.margwa_gore_right_model_override = level.var_fd47363["gore_ri"];
  }
  if(!isDefined(level.var_6b7244b4)) {
    level.var_6b7244b4 = 100;
  }
}

function private function_e84ffe9c() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("genesisMargwaVortexService", & function_96a94112);
  behaviortreenetworkutility::registerbehaviortreescriptapi("genesisMargwaSpiderService", & function_9f065361);
  behaviortreenetworkutility::registerbehaviortreescriptapi("genesisMargwaReactStunTerminate", & function_a5e64246);
  behaviortreenetworkutility::registerbehaviortreescriptapi("genesisMargwaReactIDGunTerminate", & function_a478da01);
}

function private function_96a94112(entity) {
  if(isDefined(entity.var_28763934) && entity.var_28763934 < gettime()) {
    return zm_ai_margwa::function_6312be59(entity);
  }
  return 0;
}

function private function_9f065361(entity) {
  zombies = getaiteamarray(level.zombie_team);
  foreach(zombie in zombies) {
    if(zombie.archetype == "spider") {
      distsq = distancesquared(entity.origin, zombie.origin);
      if(distsq < 2304) {
        zombie kill();
      }
    }
  }
}

function private function_a5e64246(entity) {
  margwabehavior::margwareactstunterminate(entity);
  entity.var_aa0a91dd = gettime() + 10000;
}

function private function_a478da01(entity) {
  margwabehavior::margwareactidgunterminate(entity);
  entity.var_28763934 = gettime() + 10000;
}

function private function_57c223eb() {
  self.var_5ffc5a7b = & function_c27412c6;
  self.margwapainterminatecb = & function_cc95e566;
  self thread function_e1f5236a();
  self.idgun_damage_cb = & function_df77c1c3;
  self.var_fbaea41d = & function_a8ffa66c;
  self.var_c732138b = & function_f769285c;
  self.var_aa0a91dd = gettime();
  self.var_28763934 = gettime();
  self.var_15704e8d = gettime();
  self.heroweapon_kill_power = 5;
}

function private function_9ba47060() {
  self endon("death");
  wait(0.1);
  if(isDefined(self.traveler)) {
    self.traveler delete();
  }
}

function private function_f05e4819() {
  self endon("death");
  self.waiting = 1;
  self.needteleportin = 1;
  self thread margwaserverutils::margwatell();
  wait(2);
  self.travelertell clientfield::set("margwa_fx_travel_tell", 0);
  self.waiting = 0;
  self.needteleportout = 0;
}

function private function_e1f5236a() {
  self endon("death");
  wait(1);
  self margwaserverutils::margwaenablestun();
}

function private function_c27412c6(player) {
  self zm_genesis_challenges::function_ca31caac(undefined, player);
}

function private function_cc95e566() {
  if(math::cointoss()) {
    if(zm_ai_margwa_elemental::function_6bbd2a18(self)) {
      self.var_322364e8 = 1;
    } else if(zm_ai_margwa_elemental::function_b9fad980(self)) {
      self.var_3c58b79c = 1;
    }
  }
}

function private function_df77c1c3(inflictor, attacker) {
  if(isDefined(self)) {
    foreach(head in self.head) {
      if(head.health > 0) {
        damage = self.headhealthmax * 0.5;
        head.health = head.health - damage;
        if(head.health <= 0) {
          player = undefined;
          if(isDefined(self.vortex)) {
            player = self.vortex.attacker;
          }
          if(self margwaserverutils::margwakillhead(head.model, player)) {
            self kill();
          }
        }
        return;
      }
    }
  }
}

function private function_a8ffa66c(player) {
  if(isDefined(self)) {
    if(gettime() > self.var_15704e8d) {
      foreach(head in self.head) {
        if(head.health > 0) {
          head.health = 0;
          if(self margwaserverutils::margwakillhead(head.model, player)) {
            self kill();
          }
          self.var_15704e8d = gettime() + 10000;
          return;
        }
      }
    }
  }
}

function private function_f769285c() {
  if(self function_2a03f05f()) {
    self.reactstun = 1;
    return true;
  }
  return false;
}

function function_2a03f05f() {
  if(isDefined(self.canstun) && self.canstun && self.var_aa0a91dd < gettime()) {
    return true;
  }
  return false;
}