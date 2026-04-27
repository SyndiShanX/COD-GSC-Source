/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_coop.gsc
********************************************************/

#include maps\_utility;
#include animscripts\utility;
#include common_scripts\utility;
#include maps\_hud_util;

main() {
  flag_init("coop_game");
  flag_init("coop_revive");
  flag_init("coop_alldowned");
  flag_init("coop_show_constant_icon");
  flag_init("coop_fail_when_all_dead");

  setDvarIfUninitialized("coop_revive", 1);
  setDvarIfUninitialized("coop_show_constant_icon", 1);

  if(is_coop())
    flag_set("coop_game");
  if(getDvar("coop_revive", 1) == "1")
    flag_set("coop_revive");

  flag_set("coop_show_constant_icon");

  precacheShader("hint_health");
  precacheShader("coop_player_location");
  precacheShader("coop_player_location_fire");

  level.coop_icon_green = (0.635, 0.929, 0.604);
  level.coop_icon_yellow = (1, 1, 0.2);
  level.coop_icon_orange = (1, .65, 0.2);
  level.coop_icon_red = (1, 0.2, 0.2);
  level.coop_icon_white = (1, 1, 1);
  level.coop_icon_downed = level.coop_icon_yellow;
  level.coop_icon_shoot = level.coop_icon_green;
  level.coop_icon_damage = level.coop_icon_orange;

  level.coop_icon_blinktime = 7;
  level.coop_icon_blinkcrement = 0.375;

  level.coop_revive_nag_hud_refreshtime = 20;

  level.revive_hud_base_offset = 75;
  level.revive_bar_base_offset = 15;
  if(!issplitscreen())
    level.revive_hud_base_offset = 120;

  foreach(player in level.players)
  player.reviving_buddy = false;

  level.coop_last_player_downed_time = 0;
  thread downed_player_manager();

  thread player_coop_check_mission_ended();
}

player_coop_proc() {
  if(!flag("coop_game"))
    return;
  level endon("coop_game");

  if(self ent_flag("coop_proc_running")) {
    return;
  }
  if(!isDefined(self.original_maxhealth))
    self.original_maxhealth = self.maxhealth;

  if(!flag("coop_revive"))
    return;
  level endon("coop_revive");

  self thread player_coop_proc_ended();

  switch (level.gameskill) {
    case 0:
    case 1:
      self.coop.bleedout_time_default = 120;
      level.coop_bleedout_stage2_multiplier = 0.5;
      level.coop_bleedout_stage3_multiplier = 0.25;
      break;
    case 2:
      self.coop.bleedout_time_default = 90;
      level.coop_bleedout_stage2_multiplier = 0.66;
      level.coop_bleedout_stage3_multiplier = 0.33;
      break;
    case 3:
      self.coop.bleedout_time_default = 60;
      level.coop_bleedout_stage2_multiplier = 0.5;
      level.coop_bleedout_stage3_multiplier = 0.25;
      break;
  }

  self ent_flag_set("coop_proc_running");
  self EnableDeathShield(true);

  assertex(self ent_flag_exist("coop_downed"), "Didnt have flag set");
  self ent_flag_clear("coop_downed");
  self ent_flag_clear("coop_pause_bleedout_timer");

  self thread player_setup_icon();

  self endon("death");

  my_id = self.unique_id;

  while(1) {
    self waittill("deathshield", damage, attacker, direction, point, type, modelName, tagName, partName, dflags, weaponName);

    if(self ent_flag("coop_downed")) {
      continue;
    }
    death_array = [];
    death_array["damage"] = damage;
    death_array["player"] = self;

    buddy = get_other_player(self);
    if(buddy ent_flag("coop_downed")) {
      self.coop_death_reason = [];
      self.coop_death_reason["attacker"] = attacker;
      self.coop_death_reason["cause"] = type;
      self.coop_death_reason["weapon_name"] = weaponName;
    }

    level.downed_players[self.unique_id] = death_array;

    self try_crush_player(attacker, type);

    level notify("player_downed");
  }
}

try_crush_player(attacker, type) {
  if(!isDefined(attacker)) {
    return;
  }

  if(!isDefined(type)) {
    return;
  }

  if(type != "MOD_CRUSH") {
    return;
  }

  if(isDefined(attacker.vehicletype)) {
    speed = attacker Vehicle_GetSpeed();
    if(abs(speed) == 0) {
      return;
    }
  }

  if(flag("special_op_terminated")) {
    return;
  }

  attacker maps\_specialops::so_crush_player(self, type);
}

downed_player_manager() {
  for(;;) {
    level.downed_players = [];

    level waittill("player_downed");

    assertex(isDefined(level.player_downed_death_buffer_time), "level.player_downed_death_buffer_time didnt get defined!");

    waittillframeend;

    if(gettime() < level.coop_last_player_downed_time + level.player_downed_death_buffer_time * 1000) {
      continue;
    }

    level.coop_last_player_downed_time = gettime();

    highest_damage = 0;
    downed_player = undefined;

    level.downed_players = array_randomize(level.downed_players);
    foreach(unique_id, array in level.downed_players) {
      if(array["damage"] >= highest_damage) {
        downed_player = array["player"];
      }
    }
    assertex(isDefined(downed_player), "Downed_player was not defined!");

    downed_player thread player_coop_downed();

    thread maps\_gameskill::resetSkill();
  }
}

create_fresh_friendly_icon(material) {
  if(isDefined(self.friendlyIcon))
    self.friendlyIcon Destroy();

  self.friendlyIcon = NewClientHudElem(self);
  self.friendlyIcon SetShader(material, 1, 1);
  self.friendlyIcon SetWayPoint(true, true, false);
  self.friendlyIcon SetWaypointIconOffscreenOnly();
  self.friendlyIcon SetTargetEnt(get_other_player(self));
  self.friendlyIcon.material = material;
  self.friendlyIcon.hidewheninmenu = true;

  if(flag("coop_show_constant_icon"))
    self.friendlyIcon.alpha = 1.0;
  else
    self.friendlyIcon.alpha = 0.0;
}

rebuild_friendly_icon(color, material, non_rotating) {
  if(isDefined(self.noFriendlyHudIcon)) {
    return;
  }
  assertex(isDefined(color), "rebuild_friendly_icon requires a valid color to be passed in.");
  assertex(isDefined(material), "rebuild_friendly_icon requires a valid material to be passed in.");

  if(!isDefined(self.friendlyIcon) || (self.friendlyIcon.material != material)) {
    create_fresh_friendly_icon(material);
  }

  self.friendlyIcon.color = color;
  if(!isDefined(non_rotating))
    self.friendlyIcon SetWaypointEdgeStyle_RotatingIcon();
}

CreateFriendlyHudIcon_Normal() {
  self rebuild_friendly_icon(level.coop_icon_green, "coop_player_location");
}

CreateFriendlyHudIcon_Downed() {
  self rebuild_friendly_icon(level.coop_icon_downed, "hint_health", true);
}

FriendlyHudIcon_BlinkWhenFire() {
  self endon("death");

  while(1) {
    self waittill("weapon_fired");
    other_player = get_other_player(self);
    other_player thread FriendlyHudIcon_FlashIcon(level.coop_icon_shoot, "coop_player_location_fire");
  }
}

FriendlyHudIcon_BlinkWhenDamaged() {
  self endon("death");

  while(1) {
    self waittill("damage");
    other_player = get_other_player(self);
    other_player thread FriendlyHudIcon_FlashIcon(level.coop_icon_damage, "coop_player_location");
  }
}

FriendlyHudIcon_FlashIcon(color, material) {
  if(isDefined(self.noFriendlyHudIcon)) {
    return;
  }
  self endon("death");
  self notify("flash_color_thread");
  self endon("flash_color_thread");

  other_player = get_other_player(self);
  if(other_player ent_flag("coop_downed")) {
    return;
  }
  self rebuild_friendly_icon(color, material);
  wait .5;

  self rebuild_friendly_icon(level.coop_icon_green, "coop_player_location");
}

player_setup_icon() {
  if(!flag("coop_game"))
    return;
  level endon("coop_game");

  self CreateFriendlyHudIcon_Normal();
  self thread FriendlyHudIcon_BlinkWhenFire();
  self thread FriendlyHudIcon_BlinkWhenDamaged();

  if(isDefined(self.noFriendlyHudIcon)) {
    return;
  }
  while(1) {
    flag_wait("coop_show_constant_icon");
    self.friendlyIcon.alpha = 1;

    flag_waitopen("coop_show_constant_icon");
    self.friendlyIcon.alpha = 0;
  }
}

player_coop_create_use_target() {
    level.revive_ent = spawn("script_model", self.origin + (0, 0, 28));

    level.revive_ent setModel("tag_origin");
    level.revive_ent linkTo(self, "tag_origin");
    level.revive_ent makeUsable();
    level.revive_ent setHintString(&"SCRIPT_COOP_REVIVE");

    player_coop_destroy_use_target() {
      foreach(player in level.players)
      player.reviving_buddy = false;

      if(isDefined(level.revive_ent))
        level.revive_ent Delete();
    }

    player_coop_downed() {
      self endon("death");

      self player_coop_set_down_attributes();

      player_coop_check_alldowned();

      if(flag("coop_alldowned"))
        self player_coop_kill();

      self player_coop_create_use_target();

      self thread player_coop_downed_dialogue();
      self thread player_coop_downed_hud();
      self thread player_coop_downed_icon();
      self thread player_coop_enlist_savior();

      self add_wait(::flag_wait, "coop_alldowned");
      self add_wait(::ent_flag_waitopen, "coop_downed");
      self add_wait(::waittill_msg, "coop_bled_out");
      do_wait_any();

      waittillframeend;
      self notify("end_func_player_coop_downed_icon");

      if(flag("coop_alldowned") || self ent_flag("coop_downed"))
        self player_coop_kill();

      self player_coop_set_original_attributes();
    }

    player_coop_downed_dialogue() {
      self endon("death");
      self endon("revived");
      level endon("special_op_terminated");

      other_player = get_other_player(self);
      time = other_player.coop.bleedout_time_default;

      initialWait = 1;

      wait initialWait;
      self notify("so_downed");
      self delaythread(0.05, ::player_coop_downed_nag_button);
    }

    get_coop_downed_hud_color(current_time, total_time, doBlinks) {
      if(!isDefined(doBlinks)) {
        doBlinks = true;
      }

      if(doBlinks && self coop_downed_hud_should_blink()) {
        ASSERT(isDefined(self.blinkState));

        if(self.blinkState == 1) {
          return level.coop_icon_white;
        }
      }

      if(current_time < (total_time * level.coop_bleedout_stage3_multiplier)) {
        return level.coop_icon_red;
      }

      if(current_time < (total_time * level.coop_bleedout_stage2_multiplier)) {
        return level.coop_icon_orange;
      }

      return level.coop_icon_downed;
    }

    coop_downed_hud_should_blink() {
      otherplayer = get_other_player(self);

      if(otherplayer player_coop_is_reviving()) {
        return false;
      }

      if(isDefined(self.lastReviveNagButtonPressTime)) {
        if((GetTime() - self.lastReviveNagButtonPressTime) < (level.coop_icon_blinktime * 1000)) {
          return true;
        }
      }

      return false;
    }

    player_downed_hud_toggle_blinkstate() {
      self notify("player_downed_hud_blinkstate");
      self endon("player_downed_hud_blinkstate");
      self endon("death");
      self endon("revived");

      self.blinkState = 1;

      while(1) {
        wait(level.coop_icon_blinkcrement);

        if(self.blinkState == 1) {
          self.blinkState = 0;
        } else {
          self.blinkState = 1;
        }
      }
    }

    player_coop_downed_nag_button() {
      self endon("death");
      self endon("revived");
      level endon("special_op_terminated");

      self NotifyOnPlayerCommand("nag", "weapnext");

      while(1) {
        if(!self can_show_nag_prompt()) {
          wait(0.05);
          continue;
        }

        if(self nag_should_draw_hud()) {
          self thread nag_prompt_show();
          self thread nag_prompt_cancel();
        }

        msg = self waittill_any_timeout(level.coop_revive_nag_hud_refreshtime, "nag", "nag_cancel");

        if(msg == "nag") {
          self.lastReviveNagButtonPressTime = GetTime();
          self thread player_downed_hud_toggle_blinkstate();
          self thread maps\_specialops_battlechatter::play_revive_nag();
        }

        wait(0.05);
      }
    }

    nag_should_draw_hud() {
      waitTime = level.coop_revive_nag_hud_refreshtime * 1000;

      if(!isDefined(self.lastReviveNagButtonPressTime)) {
        return true;
      } else if(GetTime() - self.lastReviveNagButtonPressTime < waitTime) {
        return false;
      }

      return true;
    }

    nag_prompt_show() {
      fadeTime = 0.05;
      loc = &"SPECIAL_OPS_REVIVE_NAG_HINT";

      hud = self get_nag_hud();
      hud.alpha = 0;
      hud SetText(loc);
      hud FadeOverTime(fadeTime);
      hud.alpha = 1;

      self waittill_disable_nag();

      hud FadeOverTime(fadeTime);
      hud.alpha = 0;
      hud delaycall((fadeTime + 0.05), ::Destroy);
    }

    waittill_disable_nag() {
      level endon("special_op_terminated");
      self waittill_any("nag", "nag_cancel", "death");
    }

    get_nag_hud() {
      hudelem = NewClientHudElem(self);

      hudelem.x = 0;
      hudelem.y = 50;
      hudelem.alignX = "center";
      hudelem.alignY = "middle";
      hudelem.horzAlign = "center";
      hudelem.vertAlign = "middle";
      hudelem.fontScale = 1;
      hudelem.color = (1.0, 1.0, 1.0);
      hudelem.font = "hudsmall";
      hudelem.glowColor = (0.3, 0.6, 0.3);
      hudelem.glowAlpha = 0;
      hudelem.foreground = 1;
      hudelem.hidewheninmenu = true;
      hudelem.hidewhendead = true;
      return hudelem;
    }

    nag_prompt_cancel() {
      self endon("nag");

      while(self can_show_nag_prompt()) {
        wait(0.05);
      }

      self notify("nag_cancel");
    }

    can_show_nag_prompt() {
      if(isDefined(level.hide_nag_prompt) && level.hide_nag_prompt) {
        return false;
      }

      otherplayer = get_other_player(self);
      if(otherplayer player_coop_is_reviving()) {
        return false;
      }

      if(!self maps\_specialops_battlechatter::can_say_current_nag_event_type()) {
        return false;
      }

      return true;
    }

    player_coop_downed_hud() {
      self endon("end_func_player_coop_downed_icon");
      self endon("death");
      self endon("revived");

      level endon("special_op_terminated");

      foreach(player in level.players) {
        player.revive_text = player createClientFontString("hudsmall", 1.0);
        player.revive_text setPoint("CENTER", undefined, 0, level.revive_hud_base_offset);
        player.revive_text thread maps\_specialops::so_hud_pulse_create();

        player.revive_timer = player createClientTimer("hudsmall", 1.2);
        player.revive_timer setPoint("CENTER", undefined, 0, level.revive_hud_base_offset + level.revive_bar_base_offset);
        player.revive_timer thread maps\_specialops::so_hud_pulse_create();
      }

      self thread player_coop_downed_hud_destroy();

      foreach(player in level.players) {
        if(player == self)
          player.revive_text settext(&"SCRIPT_COOP_BLEEDING_OUT");
        else
          player.revive_text settext(&"SCRIPT_COOP_BLEEDING_OUT_PARTNER");
        player.revive_timer setTimer(self.coop.bleedout_time_default - 1);
      }

      self thread player_coop_countdown_timer(self.coop.bleedout_time_default);

      time = self.coop.bleedout_time_default;

      foreach(player in level.players) {
        player.revive_text.color = self.revive_text.color;
        player.revive_timer.color = self.revive_text.color;
      }

      waittillframeend;

      while(time) {
        foreach(player in level.players) {
          previous_color = player.revive_text.color;
          new_color = get_coop_downed_hud_color(self.coop.bleedout_time, self.coop.bleedout_time_default, false);
          player.revive_text.color = new_color;
          player.revive_timer.color = new_color;

          if(distance(new_color, previous_color) > 0.001) {
            if(distance(new_color, level.coop_icon_red) <= 0.001) {
              player.revive_text.pulse_loop = true;
              player.revive_timer.pulse_loop = true;
            }

            player.revive_text thread maps\_specialops::so_hud_pulse_create();
            player.revive_timer thread maps\_specialops::so_hud_pulse_create();
          }
        }

        wait 1.0;
        time -= 1.0;
      }
    }

    player_coop_downed_hud_destroy() {
      self thread player_coop_downed_hud_destroy_mission_end();

      self waittill_any("end_func_player_coop_downed_icon", "death");
      foreach(player in level.players) {
        if(isDefined(player.revive_text))
          player.revive_text destroy();
        if(isDefined(player.revive_timer))
          player.revive_timer destroy();
      }
    }

    player_coop_downed_hud_destroy_mission_end() {
      level waittill("special_op_terminated");

      foreach(player in level.players) {
        if(isDefined(player.revive_text))
          player.revive_text destroy();
        if(isDefined(player.revive_timer))
          player.revive_timer destroy();
      }

      if(isDefined(self.friendlyIcon))
        self.friendlyIcon Destroy();
      other_player = get_other_player(self);
      if(isDefined(other_player.friendlyIcon))
        other_player.friendlyIcon Destroy();
    }

    player_coop_countdown_timer(time) {
      self endon("death");
      self endon("revived");

      level endon("special_op_terminated");

      self.coop.bleedout_time = time;

      while(self.coop.bleedout_time > 0) {
        if(self ent_flag("coop_pause_bleedout_timer")) {
          foreach(player in level.players)
          player.revive_timer.alpha = 0;
          self ent_flag_waitopen("coop_pause_bleedout_timer");

          if(self.coop.bleedout_time >= 1) {
            foreach(player in level.players)
            player.revive_timer settimer(self.coop.bleedout_time - 1);
          }
        } else {
          foreach(player in level.players)
          player.revive_timer.alpha = 1;
        }

        wait .05;
        self.coop.bleedout_time -= .05;
      }

      self.coop.bleedout_time = 0;
      maps\_specialops::so_force_deadquote("@DEADQUOTE_SO_BLED_OUT", "ui_bled_out");
      thread maps\_specialops::so_dialog_mission_failed_bleedout();
      self notify("coop_bled_out");
    }

    player_coop_downed_icon() {
      self endon("end_func_player_coop_downed_icon");
      self endon("death");
      self endon("revived");

      level endon("special_op_terminated");

      waittillframeend;

      other_player = get_other_player(self);
      other_player CreateFriendlyHudIcon_Downed();

      while(self.coop.bleedout_time > 0) {
        self ent_flag_waitopen("coop_pause_bleedout_timer");

        other_player rebuild_friendly_icon(get_coop_downed_hud_color(self.coop.bleedout_time, self.coop.bleedout_time_default), "hint_health", true);
        wait 0.05;
      }
    }

    player_coop_enlist_savior() {
      savior = get_other_player(self);
      savior thread player_coop_revive_buddy();
    }

    player_coop_freeze_players(frozen) {
      assert(isDefined(self));
      assert(isDefined(frozen));

      downed_buddy = get_other_player(self);
      assert(isDefined(downed_buddy));

      if(frozen) {
        self freezecontrols(true);
        self disableweapons();
        self disableweaponswitch();

        downed_buddy freezecontrols(true);
        downed_buddy disableweapons();
      } else {
        self freezecontrols(false);
        self enableweapons();
        self enableweaponswitch();

        downed_buddy freezecontrols(false);
        if(!is_player_down_and_out(downed_buddy))
          downed_buddy enableweapons();
      }
    }

    player_coop_revive_buddy() {
      self endon("death");
      self endon("revived");

      level endon("special_op_terminated");

      downed_buddy = get_other_player(self);
      buttonTime = 0;
      for(;;) {
        level.revive_ent waittill("trigger", player);

        if(player != self) {
          continue;
        }
        player.reviving_buddy = true;
        if(player_coop_is_reviving()) {
          self player_coop_freeze_players(true);

          level.coop_last_player_downed_time = 0;

          wait 0.1;
          if(!player_coop_is_reviving()) {
            player_coop_revive_buddy_cleanup(downed_buddy);
            continue;
          }

          level.bars = [];
          level.bars["p1"] = createClientProgressBar(level.player, level.revive_hud_base_offset + level.revive_bar_base_offset);
          level.bars["p2"] = createClientProgressBar(level.player2, level.revive_hud_base_offset + level.revive_bar_base_offset);

          foreach(player in level.players) {
            if(player == downed_buddy)
              player.revive_text settext(&"SCRIPT_COOP_REVIVING");
            else
              player.revive_text settext(&"SCRIPT_COOP_REVIVING_PARTNER");
          }

          speak_first = randomfloat(1) > 0.33;
          if(speak_first)
            self notify("so_reviving");

          buttonTime = 0;
          totalTime = 1.5;
          while(player_coop_is_reviving()) {
            downed_buddy ent_flag_set("coop_pause_bleedout_timer");
            foreach(bar in level.bars)
            bar updateBar(buttonTime / totalTime);

            wait(0.05);
            buttonTime += 0.05;
            if(buttonTime > totalTime) {
              player_coop_revive_buddy_cleanup(downed_buddy);

              downed_buddy player_coop_revive_self();
              if(!speak_first)
                self notify("so_revived");
              return;
            }
          }

          player_coop_revive_buddy_cleanup(downed_buddy);
        }
      }
    }

    player_coop_is_reviving() {
      if(!self useButtonPressed()) {
        return false;
      }

      return self.reviving_buddy;
    }

    player_coop_check_mission_ended() {
      level waittill("special_op_terminated");

      player_coop_destroy_use_target();

      revive_hud_cleanup_bars();
    }

    player_coop_revive_buddy_cleanup(downed_buddy) {
      level notify("revive_bars_killed");

      revive_hud_cleanup_bars();

      foreach(player in level.players) {
        if(player == downed_buddy)
          player.revive_text settext(&"SCRIPT_COOP_BLEEDING_OUT");
        else
          player.revive_text settext(&"SCRIPT_COOP_BLEEDING_OUT_PARTNER");
      }

      if(isDefined(downed_buddy) && isalive(downed_buddy)) {
        downed_buddy ent_flag_clear("coop_pause_bleedout_timer");
      }

      if(isDefined(self) && isalive(self)) {
        self.reviving_buddy = false;
        self player_coop_freeze_players(false);
      }
    }

    revive_hud_cleanup_bars() {
      if(isDefined(level.bars)) {
        foreach(bar in level.bars) {
          if(isDefined(bar)) {
            bar notify("destroying");
            bar destroyElem();
          }
        }
        level.bars = undefined;
      }
    }

    player_coop_revive_self() {
      self ent_flag_clear("coop_downed");
      self notify("revived");
      player_coop_destroy_use_target();
      self thread player_dying_effect_remove();

      thread maps\_gameskill::resetSkill();
    }

    player_coop_proc_ended() {
      self endon("death");

      flag_waitopen("coop_revive");
      self ent_flag_clear("coop_proc_running");
      self EnableDeathShield(false);
    }

    player_coop_set_down_attributes() {
      self endon("death");

      level.default_use_radius = getdvarint("player_useradius");
      setsaveddvar("player_useradius", 128);

      self.coop_downed = true;
      self.ignoreRandomBulletDamage = true;
      self EnableInvulnerability();
      self ent_flag_set("coop_downed");
      self.health = 2;
      self.maxhealth = self.original_maxhealth;
      self.ignoreme = true;

      self DisableUsability();
      self DisableWeaponSwitch();
      self disableoffhandweapons();
      self DisableWeapons();

      self thread player_coop_kill_by_vehicle();
      self thread player_coop_set_down_part1();
    }

    player_coop_kill_by_vehicle() {
      self endon("revived");
      self endon("death");
      level endon("special_op_terminated");

      if(flag("special_op_terminated")) {
        return;
      }

      if(!IsAlive(self)) {
        return;
      }

      while(1) {
        vehicles = Vehicle_GetArray();
        foreach(vehicle in vehicles) {
          speed = vehicle Vehicle_GetSpeed();
          if(abs(speed) == 0) {
            continue;
          }

          if(self IsTouching(vehicle)) {
            vehicle maps\_specialops::so_crush_player(self, "MOD_CRUSH");
            return;
          }
        }

        wait(0.05);
      }
    }

    player_coop_set_original_attributes() {
      setsaveddvar("player_useradius", level.default_use_radius);
      level.default_use_radius = undefined;

      self.ignoreRandomBulletDamage = false;
      self ent_flag_clear("coop_downed");
      self.down_part2_proc_ran = undefined;

      other_player = get_other_player(self);
      other_player delaythread(0.1, ::CreateFriendlyHudIcon_Normal);

      self player_coop_getup();

      self.health = self.maxhealth;
      self.ignoreme = false;
      self setstance("stand");

      self EnableUsability();
      self enableoffhandweapons();
      self EnableWeaponSwitch();

      if(!isDefined(self.placingSentry)) {
        self EnableWeapons();
      }

      self.coop_downed = undefined;
      wait 1.0;
      self DisableInvulnerability();
    }

    check_for_pistol() {
      AssertEx(isPlayer(self), "check_for_pistol() was called on a non-player.");

      weapon_list = self GetWeaponsListPrimaries();
      foreach(weapon in weapon_list) {
        if(WeaponClass(weapon) == "pistol")
          return weapon;
      }

      return undefined;
    }

    remove_pistol_if_extra() {
      AssertEx(isPlayer(self), "remove_pistol_if_extra() was called on a non-player.");

      if(isDefined(self.forced_pistol)) {
        self takeweapon(self.forced_pistol);
        self.forced_pistol = undefined;
      }

      if(player_can_restore_weapon(self.preincap_weapon)) {
        self SwitchToWeapon(self.preincap_weapon);
      } else {
        primary_weapons = self GetWeaponsListPrimaries();
        assert(primary_weapons.size > 0);
        self SwitchToWeapon(primary_weapons[0]);
      }
      self.preincap_weapon = undefined;
    }

    player_can_restore_weapon(weapon) {
      if(!isDefined(weapon))
        return false;

      if(weapon == "none")
        return false;

      if(!self HasWeapon(weapon))
        return false;

      return true;
    }

    player_coop_force_switch_to_pistol() {
      self.preincap_weapon = self GetCurrentWeapon();

      weapon_pistol = self check_for_pistol();

      if(!isDefined(weapon_pistol)) {
        weapon_pistol = "Beretta";
        if(isDefined(level.coop_incap_weapon))
          weapon_pistol = level.coop_incap_weapon;

        self.forced_pistol = weapon_pistol;
        self giveWeapon(weapon_pistol);
      }

      self SwitchToWeapon(weapon_pistol);

      if(!isDefined(self.placingSentry)) {
        self EnableWeapons();
      }
    }

    player_coop_set_down_part1() {
      self endon("revived");

      self.laststand = true;
      wait .3;

      self player_coop_force_switch_to_pistol();

      wait .25;
      self DisableInvulnerability();

      self thread player_coop_down_draw_attention();

      self waittill("damage");
      self thread player_coop_set_down_part2();
    }

    player_coop_set_down_part2() {
      self.down_part2_proc_ran = true;

      self disableweapons();
      self thread player_dying_effect();

      self.ignoreme = true;
      self.ignoreRandomBulletDamage = true;
      self EnableInvulnerability();
    }

    player_dying_effect() {
      self endon("death");
      self endon("revived");

      if(!ent_flag_exist("coop_dying_effect"))
        ent_flag_init("coop_dying_effect");
      else if(ent_flag("coop_dying_effect"))
        return;
      ent_flag_set("coop_dying_effect");

      for(;;) {
        self shellshock("default", 60);
        wait(60);
      }
    }

    player_dying_effect_remove() {
      if(ent_flag_exist("coop_dying_effect"))
        ent_flag_clear("coop_dying_effect");

      self stopShellShock();
    }

    player_coop_down_draw_attention() {
      self endon("death");
      self endon("revived");
      self endon("damage");

      notifyoncommand("draw_attention", "+attack");
      self waittill_notify_or_timeout("draw_attention", 4);
      self.ignoreme = false;
      self.ignoreRandomBulletDamage = false;
    }

    player_coop_getup() {
      self endon("death");

      self disableweapons();
      self remove_pistol_if_extra();

      self.laststand = false;
      self.achieve_downed_kills = undefined;
      wait .3;
    }

    player_coop_kill() {
      self ent_flag_set("coop_is_dead");
      self thread player_dying_effect_remove();

      if(flag("coop_fail_when_all_dead"))
        flag_wait("coop_alldowned");

      self EnableDeathShield(false);
      self DisableInvulnerability();
      self EnableHealthShield(false);
      self.laststand = false;
      self.achieve_downed_kills = undefined;
      waittillframeend;
      self kill();
    }

    player_coop_check_alldowned() {
      foreach(player in level.players) {
        downed = player ent_flag("coop_downed");
        if(!downed)
          return;
      }

      flag_set("coop_alldowned");
    }