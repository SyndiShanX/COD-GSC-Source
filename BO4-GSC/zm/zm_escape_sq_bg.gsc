/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_escape_sq_bg.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\weapons\zm_weap_blundergat;
#include scripts\zm\weapons\zm_weap_spectral_shield;
#include scripts\zm\weapons\zm_weap_tomahawk;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_net;
#include scripts\zm_common\zm_utility;

#namespace zm_escape_sq_bg;

autoexec __init__system__() {
  system::register(#"zm_escape_sq_bg", &__init__, &__main__, undefined);
}

__init__() {
  level flag::init(#"warden_blundergat_obtained");
  level._effect[#"ee_skull_shot"] = #"electric/fx_elec_sparks_burst_sm_omni_blue_os";
}

__main__() {
  if(zm_utility::is_standard()) {
    return;
  }

  level thread wait_for_initial_conditions();
}

wait_for_initial_conditions() {
  level.sq_bg_macguffins = [];
  a_s_mcguffin = struct::get_array("struct_sq_bg_macguffin", "targetname");

  foreach(struct in a_s_mcguffin) {
    mdl_skull = util::spawn_model("p8_zm_esc_skull_afterlife_glass", struct.origin, struct.angles);
    mdl_skull.targetname = "sq_bg_macguffin";

    if(!isDefined(level.sq_bg_macguffins)) {
      level.sq_bg_macguffins = [];
    } else if(!isarray(level.sq_bg_macguffins)) {
      level.sq_bg_macguffins = array(level.sq_bg_macguffins);
    }

    if(!isinarray(level.sq_bg_macguffins, mdl_skull)) {
      level.sq_bg_macguffins[level.sq_bg_macguffins.size] = mdl_skull;
    }
  }

  array::thread_all(level.sq_bg_macguffins, &sq_bg_macguffin_think);
  array::thread_all(level.sq_bg_macguffins, &zm_weap_spectral_shield::function_16dd8932);

  if(!isDefined(level.a_tomahawk_pickup_funcs)) {
    level.a_tomahawk_pickup_funcs = [];
  } else if(!isarray(level.a_tomahawk_pickup_funcs)) {
    level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
  }

  level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &tomahawk_the_macguffin;
  level thread check_sq_bg_progress();
  level waittill(#"all_macguffins_acquired");
  var_dd7441ab = struct::get("sq_bg_reward_pickup", "targetname");
  t_reward_pickup = spawn("trigger_radius_use", var_dd7441ab.origin, 0, 96, 64);

  if(function_8b1a219a()) {
    t_reward_pickup sethintstring(#"hash_13148440ddb20104");
  } else {
    t_reward_pickup sethintstring(#"hash_3d510922bc950f08");
  }

  t_reward_pickup setcursorhint("HINT_NOICON");
  t_reward_pickup triggerignoreteam();
  t_reward_pickup setvisibletoall();
  t_reward_pickup thread give_sq_bg_reward(var_dd7441ab);
}

sq_bg_macguffin_think() {
  level endon(#"hash_6a6919e3cb8ef81");
  self endon(#"sq_bg_macguffin_received_by_player");
  self.health = 10000;
  self setCanDamage(1);
  self setforcenocull();

  while(true) {
    s_result = self waittill(#"damage");

    if(isplayer(s_result.attacker) && (s_result.weapon == getweapon(#"tomahawk_t8") || s_result.weapon == getweapon(#"tomahawk_t8_upgraded"))) {
      playFX(level._effect[#"ee_skull_shot"], self.origin);
      self thread wait_and_hide_sq_bg_macguffin();
    }
  }
}

wait_and_hide_sq_bg_macguffin() {
  self notify(#"restart_show_timer");
  self endon(#"restart_show_timer", #"caught_by_tomahawk", #"sq_bg_macguffin_received_by_player", #"death");
  wait 1.6;

  if(isDefined(self)) {
    self ghost();
  }
}

tomahawk_the_macguffin(e_grenade, n_grenade_charge_power) {
  if(!isDefined(level.sq_bg_macguffins) || level.sq_bg_macguffins.size <= 0) {
    return false;
  }

  if(!isDefined(e_grenade)) {
    return false;
  }

  foreach(mdl_skull in level.sq_bg_macguffins) {
    if(!isDefined(mdl_skull)) {
      continue;
    }

    if(!(isDefined(mdl_skull.b_collected) && mdl_skull.b_collected) && distancesquared(mdl_skull.origin, e_grenade.origin) < 100 * 100) {
      mdl_skull.b_collected = 1;
      mdl_tomahawk = zm_weap_tomahawk::tomahawk_spawn(e_grenade.origin);
      mdl_tomahawk.n_grenade_charge_power = n_grenade_charge_power;
      mdl_skull notify(#"caught_by_tomahawk");
      mdl_skull.origin = e_grenade.origin;
      mdl_skull linkto(mdl_tomahawk);
      mdl_skull clientfield::set("" + #"afterlife_entity_visibility", 2);
      self thread zm_weap_tomahawk::tomahawk_return_player(mdl_tomahawk, undefined, 800);
      self thread give_player_macguffin_upon_receipt(mdl_tomahawk, mdl_skull);
      return true;
    }
  }

  return false;
}

give_player_macguffin_upon_receipt(mdl_tomahawk, mdl_skull) {
  v_org = self.origin;

  while(isDefined(mdl_tomahawk)) {
    waitframe(1);
  }

  mdl_skull notify(#"sq_bg_macguffin_received_by_player");
  arrayremovevalue(level.sq_bg_macguffins, mdl_skull);
  mdl_skull delete();
  zm_utility::play_sound_at_pos("purchase", v_org);
  level notify(#"sq_bg_macguffin_collected", {
    #e_player: self
  });
}

check_sq_bg_progress() {
  n_macguffins_total = level.sq_bg_macguffins.size;
  n_macguffins_collected = 0;

  while(true) {
    s_result = level waittill(#"sq_bg_macguffin_collected");
    e_player = s_result.e_player;
    n_macguffins_collected++;

    if(n_macguffins_collected >= n_macguffins_total) {
      level notify(#"all_macguffins_acquired");
      break;
    }

    if(isplayer(e_player)) {
      e_player thread play_sq_bg_collected_vo();
    }
  }

  wait 1;

  if(isplayer(e_player)) {
    e_player playSound(#"zmb_easteregg_laugh");
  }
}

play_sq_bg_collected_vo() {
  self endon(#"disconnect");
  wait 1;
  self thread zm_utility::do_player_general_vox("quest", "pick_up_easter_egg");
}

give_sq_bg_reward(var_dd7441ab) {
  t_near = spawn("trigger_radius", var_dd7441ab.origin, 0, 196, 64);
  t_near thread sq_bg_spawn_rumble();
  mdl_reward = zm_utility::spawn_weapon_model(getweapon(#"ww_blundergat_t8"), undefined, var_dd7441ab.origin + (0, 0, 6), var_dd7441ab.angles);
  mdl_reward clientfield::set("" + #"bg_spawn_fx", 1);
  mdl_reward thread scene::play(#"p8_fxanim_zm_esc_blundergat_fireplace_hover_bundle", mdl_reward);

  while(isDefined(self)) {
    s_result = self waittill(#"trigger");
    e_player = s_result.activator;

    if(zm_utility::can_use(e_player, 1) && e_player.currentweapon.name != "none") {
      if(e_player hasweapon(getweapon(#"ww_blundergat_t8")) || e_player hasweapon(getweapon(#"ww_blundergat_t8_upgraded")) || e_player hasweapon(getweapon(#"ww_blundergat_acid_t8")) || e_player hasweapon(getweapon(#"ww_blundergat_acid_t8_upgraded")) || e_player hasweapon(getweapon(#"ww_blundergat_fire_t8")) || e_player hasweapon(getweapon(#"ww_blundergat_fire_t8_upgraded")) || e_player hasweapon(getweapon(#"ww_blundergat_fire_t8_unfinished"))) {
        self sethintstringforplayer(e_player, #"hash_e8fb80933bfb033");

        foreach(e_active_player in level.activeplayers) {
          if(e_active_player != e_player) {
            self setinvisibletoplayer(e_active_player, 1);
          }
        }

        wait 3;

        foreach(e_active_player in level.activeplayers) {
          self setvisibletoplayer(e_active_player);

          if(function_8b1a219a()) {
            self sethintstringforplayer(e_player, #"hash_13148440ddb20104");
            continue;
          }

          self sethintstringforplayer(e_player, #"hash_3d510922bc950f08");
        }

        continue;
      }

      mdl_reward thread function_d61275a7();
      e_player take_old_weapon_and_give_reward();
      self delete();
    }
  }

  t_near delete();
}

private function_d61275a7() {
  self clientfield::set("" + #"bg_spawn_fx", 0);
  self ghost();
  wait 5;
  self delete();
}

sq_bg_spawn_rumble() {
  self endon(#"death");

  while(true) {
    s_result = self waittill(#"trigger");

    if(isplayer(s_result.activator)) {}

    wait 0.1;
  }
}

take_old_weapon_and_give_reward() {
  var_287a8343 = zm_utility::get_player_weapon_limit(self);
  a_primaries = self getweaponslistprimaries();

  if(isDefined(a_primaries) && a_primaries.size >= var_287a8343) {
    self takeweapon(self.currentweapon);
  }

  self giveweapon(getweapon(#"ww_blundergat_t8"));
  self switchtoweapon(getweapon(#"ww_blundergat_t8"));
  level flag::set(#"warden_blundergat_obtained");
  self thread zm_audio::create_and_play_dialog(#"magicbox", #"wonder");
}