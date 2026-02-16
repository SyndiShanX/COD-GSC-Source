/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_meatshield.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_debug;
#include maps\_music;
#using_animtree("generic_human");

main(weapon, viewmodel, anims_func, do_bulletcam) {
  level._meatshield_weapon = weapon;
  level._meatshield_viewmodel = viewmodel;
  _precache(weapon, viewmodel);
  _fx();
  _anims(anims_func);
  _settings();
  _flags();
  if(!isDefined(do_bulletcam)) {
    level._meatshield_bulletcam = true;
    maps\_bulletcam::main();
  } else {
    level._meatshield_bulletcam = do_bulletcam;
  }
  OnPlayerConnect_Callback(::on_player_connect);
  OnSaveRestored_Callback(::on_save_restored);
  setup_contextual_melee();
}
on_player_connect() {}
on_save_restored() {
  player = get_players()[0];
  player SetClientDvar("sv_clientSideBullets", 1);
  player SetClientDvar("cg_forceSniperBobHack", 0);
}
_precache(weapon, viewmodel) {
  PrecacheItem(weapon);
  PrecacheModel(viewmodel);
  PrecacheModel("fx_meatshield_preloader");
  PrecacheModel("p_glo_bullet_tip");
  PrecacheShader("overlay_blood_meat_shield");
}
_fx() {
  level._effect["meatshield_fake_hit"] = LoadFX("maps/creek/fx_impact_meat_shield_fxr");
}
_settings() {
  level._MEATSHIELD_CLAMP_L = 27;
  level._MEATSHIELD_CLAMP_R = 27;
  level._MEATSHIELD_CLAMP_U = 10;
  level._MEATSHIELD_CLAMP_D = 10;
  if(!isDefined(level._meatshield_timer)) {
    level._meatshield_timer = 15;
  }
  if(!isDefined(level._meatshield_kill_player)) {
    level._meatshield_kill_player = false;
  }
}
_flags() {
  flag_init("timer_on", true);
  level.CLIENT_ENABLE_EAR_BLOOD = 0;
}
_anims(anims_func) {
  level.scr_anim["_meatshield:ai"]["grab"] = % ai_meatshield_grab;
  level.scr_anim["_meatshield:ai"]["idle"][0] = % ai_meatshield_victim_aim_idle;
  level.scr_anim["_meatshield:ai"]["idle_steady"][0] = % ai_meatshield_victim_aim_idle_steady;
  level.scr_anim["_meatshield:ai"]["trans_2_dead"][0] = % ai_meatshield_hostage_trans_2_dead;
  level.scr_anim["_meatshield:ai"]["dead_idle"][0] = % ai_meatshield_hostage_dead_idle;
  level.scr_anim["_meatshield:ai"]["dead_idle_steady"][0] = % ai_meatshield_hostage_dead_idle_steady;
  level.scr_anim["_meatshield:ai"]["drop"] = % ai_meatshield_hostage_dead_drop;
  level.scr_anim["_meatshield:player"]["grab"] = % int_meatshield_grab;
  level.scr_anim["_meatshield:player"]["idle"][0] = % int_meatshield_player_aim_idle_leftarm;
  level.scr_anim["_meatshield:player"]["idle_steady"][0] = % int_meatshield_player_aim_idle_leftarm_steady;
  level.scr_anim["_meatshield:player"]["trans_2_dead"][0] = % int_meatshield_hostage_trans_2_dead;
  level.scr_anim["_meatshield:player"]["dead_idle"][0] = % int_meatshield_hostage_dead_idle;
  level.scr_anim["_meatshield:player"]["dead_idle_steady"][0] = % int_meatshield_hostage_dead_idle_steady;
  level.scr_anim["_meatshield:player"]["drop"] = % int_meatshield_hostage_dead_drop;
  if(isDefined(anims_func)) {
    [[anims_func]]();
  }
}
setup_contextual_melee() {
  if(is_true(level.scripted_meatshield)) {
    maps\_contextual_melee::add_melee_sequence("scripted", "meatshield", "scripted", "scripted", level.scr_anim["_meatshield:player"]["grab"], level.scr_anim["_meatshield:ai"]["grab"]);
    maps\_contextual_melee::add_melee_callback("scripted", "meatshield", "scripted", "scripted", ::do_meat_shield);
  } else {
    maps\_contextual_melee::add_melee_sequence("default", "meatshield", "stand", "stand", level.scr_anim["_meatshield:player"]["grab"], level.scr_anim["_meatshield:ai"]["grab"]);
    maps\_contextual_melee::add_melee_callback("default", "meatshield", "stand", "stand", ::do_meat_shield);
  }
}
start(ai) {
  self SetClientDvar("sv_clientSideBullets", 0);
  _meatshield = spawnStruct();
  _meatshield ent_flag_init("meatshield_active", true);
  _meatshield.anim_ents = array(self.player_hands, ai);
  _meatshield.align = self get_align_pt(ai);
  _meatshield.player = self;
  _meatshield.ai = ai;
  _meatshield.blood_overlay_model = spawn("script_model", ai.origin - (0, 50, 0));
  _meatshield.blood_overlay_model setModel("fx_meatshield_preloader");
  self._meatshield = _meatshield;
  ai._meatshield = _meatshield;
  self.player_hands.animname = "_meatshield:player";
  self link_player();
  if(!isDefined(level._meatshield_no_weapon_management)) {
    self take_weapons();
  }
  self thread give_weapon();
  self FreezeControls(false);
  self AllowCrouch(false);
  self AllowProne(false);
  self SetAutoPickup(false);
  ai BloodImpact("none");
  if(!isDefined(level.meatshield_damage_override)) {
    ai.overrideActorDamage = ::meatshield_damage;
  } else {
    ai.overrideActorDamage = level.meatshield_damage_override;
  }
  ai.animname = "_meatshield:ai";
  ai gun_remove();
  ai.team = "allies";
  ai LinkTo(_meatshield.align, "tag_origin");
  ai notify("_meatshield:start");
  if(!isDefined(level.meatshield_custom_audio)) {
    ai thread meatshield_audio_init(_meatshield);
  } else {
    ai thread[[level.meatshield_custom_audio]]();
  }
  _meatshield thread notify_when_done(ai);
  _meatshield thread ads_loop();
  _meatshield.time_left = level._meatshield_timer;
  return _meatshield;
}
give_weapon() {
  self SetClientDvar("cg_forceSniperBobHack", 1);
  self SetViewModel(level._meatshield_viewmodel);
  self GiveWeapon(level._meatshield_weapon, 0);
  self SwitchToWeapon(level._meatshield_weapon);
  wait .1;
  self ShowViewModel();
  self EnableWeapons();
}
notify_when_done(ent) {
  self ent_flag_waitopen("meatshield_active");
  ent notify("_meatshield:end");
  level notify("_meatshield:end");
}
finish() {
  self ent_flag_waitopen("meatshield_active");
  self.player SetClientDvar("cg_forceSniperBobHack", 0);
  self.player TakeAllWeapons();
  self waittill("_meatshield:anims_done");
  self.player SetViewModel(level.player_viewmodel);
  if(!isDefined(level._meatshield_no_weapon_management)) {
    self.player give_weapons();
  }
  self.ai.overrideActorDamage = undefined;
  self.player.ignoreme = false;
  self.player unlink_player();
  self.player AllowCrouch(true);
  self.player AllowProne(true);
  self.player SetAutoPickup(true);
  self.player SetClientDvar("sv_clientSideBullets", 1);
  self.blood_overlay_model Delete();
  self.ai notify("_meatshield:done");
  self.player notify("_meatshield:done");
  if(isDefined(self.ai)) {
    self.ai.team = "axis";
  }
  self.player._meatshield = undefined;
}
do_meat_shield(guy) {
  _meatshield = start(guy);
  _meatshield thread do_anims();
  _meatshield thread last_guy();
  _meatshield thread meatshield_ai_targets_vox();
  _meatshield thread turn_loop(guy.left_constraint, guy.right_constraint);
  _meatshield thread ms_timer();
  _meatshield finish();
}
meatshield_damage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime) {
  MAX_DAMAGE = 7000;
  if(!isDefined(self._meatshield.damage_taken)) {
    self._meatshield.damage_taken = 0;
  }
  if(!isPlayer(eAttacker)) {
    self._meatshield.damage_taken += iDamage;
  }
  if(!is_true(self._meatshield.dead)) {
    if((self._meatshield.damage_taken > MAX_DAMAGE) || (self._meatshield.time_left < level._meatshield_timer / 1.3)) {
      self._meatshield notify("_meatshield:death");
      self._meatshield.dead = true;
      clientnotify("msd");
      if(is_mature()) {
        self SetClientFlag(level.CLIENT_ENABLE_EAR_BLOOD);
      }
    }
  }
  if(self._meatshield ent_flag("meatshield_active")) {
    fake_bullets();
  }
  return 0;
}
fake_bullets() {
  self._meatshield.player endon("meatshield_active");
  tags = [];
  tags[tags.size] = "J_Spine4";
  wait_time = .5;
  for(i = 0; i < 1; i++) {
    fx_id = level._effect["meatshield_fake_hit"];
    if(is_mature()) {
      playFXOnTag(fx_id, self, random(tags));
    }
    wait(wait_time);
  }
}
get_struct() {
  assertex(isDefined(self._meatshield), "maps/_meatshield::get_struct - Entity is not part of meatshield or called before init().");
  return self._meatshield;
}
get_align_pt(ai) {
  if(isDefined(ai.target)) {
    temp_struct = getstruct(ai.target, "targetname");
    align_point = spawn("script_model", temp_struct.origin);
    align_point.angles = temp_struct.angles;
  } else {
    align_point = spawn("script_model", ai.origin);
    align_point.angles = self.angles;
  }
  align_point setModel("tag_origin");
  return (align_point);
}
link_player(absolute) {
  self set_near_plane(1);
  if(isDefined(level._meatshield_gun_offset)) {
    setDvar("bg_gunXOffset", level._meatshield_gun_offset);
  } else {
    setDvar("bg_gunXOffset", 100);
  }
  self.player_hands LinkTo(self._meatshield.align);
  if(is_true(absolute)) {
    self StartCameraTween(.3);
    self PlayerLinkToAbsolute(self.player_hands, "tag_player");
  } else {
    self PlayerLinkToDelta(self.player_hands, "tag_player", 0, level._MEATSHIELD_CLAMP_R, level._MEATSHIELD_CLAMP_L, level._MEATSHIELD_CLAMP_U, level._MEATSHIELD_CLAMP_D, true);
  }
}
unlink_player() {
  self reset_near_plane();
  setDvar("bg_gunXOffset", 0);
  self Unlink();
}
turn_loop(left_constraint, right_constraint) {
  self endon("meatshield_active");
  original_angle = flat_angle(self.player GetPlayerAngles());
  if(isDefined(left_constraint) && isDefined(right_constraint)) {
    if(left_constraint == 0 && right_constraint == 0) {
      return;
    }
    left_constraint -= level._MEATSHIELD_CLAMP_L;
    right_constraint += level._MEATSHIELD_CLAMP_R;;
  }
  while(true) {
    new_ang = self.player GetPlayerAngles();
    ang = flat_angle(new_ang);
    if(isDefined(left_constraint) && isDefined(right_constraint)) {
      zeroed_ang = ang - original_angle;
      clamped_ang = AngleClamp180(zeroed_ang[1]);
      if(clamped_ang < left_constraint && clamped_ang > right_constraint) {
        self.align RotateTo(ang, .06);
        wait(0.05);
      } else {
        wait(0.05);
      }
    } else {
      self.align RotateTo(ang, .06);
      wait .05;
    }
  }
}
do_anims(ents) {
  self idle_loop("idle");
  for(i = 0; i < self.anim_ents.size; i++) {
    self.anim_ents[i] anim_set_blend_in_time(.5);
    self.anim_ents[i] anim_set_blend_out_time(.5);
  }
  self.align anim_single_aligned(self.anim_ents, "trans_2_dead");
  if(self ent_flag("meatshield_active")) {
    self idle_loop("dead_idle");
  }
  self.ai.overrideActorDamage = undefined;
  self.player link_player(true);
  playsoundatposition("evt_s01_ms_push_body", (0, 0, 0));
  self.align anim_single_aligned(self.anim_ents, "drop");
  self notify("_meatshield:anims_done");
}
idle_loop(which_idle) {
  self endon("_meatshield:death");
  self endon("meatshield_active");
  while(true) {
    if(self.player adsButtonPressed()) {
      self.align thread anim_loop_aligned(self.anim_ents, which_idle + "_steady");
      self.player waittill("!_ads_button_pressed");
    } else {
      self.align thread anim_loop_aligned(self.anim_ents, which_idle);
      self.player waittill("_ads_button_pressed");
    }
  }
}
ms_timer() {
  self endon("meatshield_active");
  fired_gun = false;
  NON_FIRE_IDLE_PERCENT = 0.4;
  while(true) {
    flag_wait("timer_on");
    self.time_left = level._meatshield_timer;
    for(i = level._meatshield_timer; i >= -1; i--) {
      if(self.player attackButtonPressed()) {
        fired_gun = true;
      }
      if(i < level._meatshield_timer * NON_FIRE_IDLE_PERCENT && !fired_gun && level._meatshield_kill_player == true) {
        self ms_idle_fail_player();
        break;
      }
      if(i == -1) {
        flag_clear("timer_on");
        if(level._meatshield_kill_player == true) {
          self ms_idle_fail_player();
          break;
        }
        self ent_flag_clear("meatshield_active");
      } else if(flag("timer_on")) {
        timer_wait(1);
        self.time_left--;
        level notify("timer_update", i);
      } else {
        break;
      }
    }
  }
}
timer_wait(t) {
  level endon("timer_on");
  wait t;
}
ms_idle_fail_player() {
  self.player FreezeControls(true);
  for(i = 1; i < 11; i++) {
    x = i * 0.1;
    self blood_hud(x);
    self.player PlayRumbleOnEntity("grenade_rumble");
    wait 0.1;
  }
  MissionFailed();
}
add_angle_limits(guy, left_angle, right_angle) {
  guy.left_constraint = left_angle;
  guy.right_constraint = right_angle;
}
add_target(meatshield, scripted) {
  if(!isDefined(meatshield._meatshield_targets)) {
    meatshield._meatshield_targets = [];
  }
  meatshield thread add_target_and_remove_when_dead(self);
  if(!is_true(scripted)) {
    self thread shoot_at_meatshield(meatshield);
  }
}
add_target_and_remove_when_dead(target) {
  self endon("death");
  self endon("_meatshield:end");
  self._meatshield_targets = add_to_array(self._meatshield_targets, target, false);
  target thread target_wait_for_special_fake_death(self);
  target thread target_wait_for_real_death(self);
}
target_wait_for_special_fake_death(meatshield_ai) {
  meatshield_ai endon("death");
  meatshield_ai endon("_meatshield:end");
  self endon("death");
  self waittill("special_fake_death");
  meatshield_ai._meatshield_targets = array_remove(meatshield_ai._meatshield_targets, self);
}
target_wait_for_real_death(meatshield_ai) {
  meatshield_ai endon("death");
  meatshield_ai endon("_meatshield:end");
  self endon("special_fake_death");
  self waittill("death");
  meatshield_ai._meatshield_targets = array_removedead(meatshield_ai._meatshield_targets);
}
shoot_at_meatshield(meatshield) {
  self endon("death");
  meatshield waittill("_meatshield:start");
  self.perfectAim = 1;
  self set_ignoreall(false);
  self.a.allow_sidearm = false;
  self thread shoot_at_target(meatshield, "J_MainRoot", 2, 999999);
  meatshield._meatshield ent_flag_waitopen("meatshield_active");
  self stop_shoot_at_target();
}
last_guy() {
  self ent_flag_wait("meatshield_active");
  while(self.ai._meatshield_targets.size > 1) {
    if(self ent_flag("meatshield_active")) {
      wait .05;
    } else {
      return;
    }
  }
  last_guy = self.ai._meatshield_targets[0];
  if(level._meatshield_bulletcam) {
    last_guy maps\_bulletcam::enable(true);
  }
  level notify("meat_shield_last_guy", last_guy);
  last_guy notify("meat_shield_last_guy");
  self thread finish_on_last_guy_death(last_guy);
  self ent_flag_waitopen("meatshield_active");
  if(level._meatshield_bulletcam && IsAlive(last_guy)) {
    last_guy maps\_bulletcam::enable(false);
  }
}
finish_on_last_guy_death(last_guy) {
  self endon("meatshield_active");
  if(level._meatshield_bulletcam) {
    self.player waittill("_bulletcam:end");
  } else {
    last_guy waittill("death");
  }
  self ent_flag_clear("meatshield_active");
}
blood_hud(alpha_val) {
  if(self ent_flag("meatshield_active")) {
    if(!isDefined(self.blood_hud)) {
      self.blood_hud = NewClientHudElem(self.player);
      self.blood_hud.horzAlign = "fullscreen";
      self.blood_hud.vertAlign = "fullscreen";
      self.blood_hud SetShader("overlay_blood_meat_shield", 640, 480);
      self.blood_hud.alpha = 0;
      self thread blood_hud_destroy();
    }
    self.blood_hud.alpha = alpha_val;
  }
}
blood_hud_destroy() {
  FADE_TIME = 2;
  self ent_flag_waitopen("meatshield_active");
  self.blood_hud FadeOverTime(FADE_TIME);
  self.blood_hud.alpha = 0;
  wait(FADE_TIME);
  self.blood_hud Destroy();
}
find_closest_target_to_view() {
  closest_ent = undefined;
  smallest_ang = 360;
  eye = self.player getEye();
  view_ang = AbsAngleClamp180(self.player GetPlayerAngles()[1]);
  for(i = 0; i < self.ai._meatshield_targets.size; i++) {
    if(isDefined(self.ai._meatshield_targets[i])) {
      ang_to_target = VectorToAngles(self.ai._meatshield_targets[i].origin - eye);
      ang_to_target = AbsAngleClamp180(ang_to_target[1]);
      angle_diff = abs(view_ang - ang_to_target);
      if((angle_diff < level._MEATSHIELD_CLAMP_L) && (angle_diff < smallest_ang)) {
        smallest_ang = angle_diff;
        closest_ent = self.ai._meatshield_targets[i];
      }
    }
  }
  return closest_ent;
}
ads_loop_reallow_aim_assist() {
  self waittill("meatshield_active");
  self.player resetAdsWidthAndLerp();
}
ads_loop() {
  self endon("meatshield_active");
  self thread ads_loop_reallow_aim_assist();
  self.player setAdsWidthAndLerp(400, 10);
  while(true) {
    if(self.player adsButtonPressed()) {
      self.player notify("_ads_button_pressed");
    }
    while(self.player adsButtonPressed()) {
      wait .05;
    }
    self.player notify("!_ads_button_pressed");
    wait .05;
  }
}
test() {
  self thread link_loop();
  self thread toggle_timer();
  self thread timer_hud();
}
link_loop() {
  while(true) {
    if(self buttonPressed("DPAD_DOWN")) {
      self Unlink();
    } else if(self buttonPressed("DPAD_UP")) {
      if(isDefined(self.player_hands)) {
        self link_player();
      }
    }
    wait .05;
  }
}
toggle_timer() {
  while(true) {
    while(!self buttonPressed("DPAD_RIGHT")) {
      wait .05;
    }
    flag_toggle("timer_on");
    wait .2;
  }
}
timer_hud() {
  while(true) {
    level waittill("timer_update", val);
    hud = get_timer_hud();
    if(isDefined(hud)) {
      hud SetValue(val);
    }
  }
}
get_timer_hud() {
  if(!flag("timer_on")) {
    return undefined;
  }
  if(!isDefined(level.ms_timer_hud)) {
    level.ms_timer_hud = NewDebugHudElem();
    level.ms_timer_hud.alignX = "center";
    level.ms_timer_hud.x = 0;
    level.ms_timer_hud.y = 20;
    level.ms_timer_hud.label = "Timer: ";
    level.ms_timer_hud thread destroy_timer_hud();
  }
  return (level.ms_timer_hud);
}
destroy_timer_hud() {
  flag_waitopen("timer_on");
  self Destroy();
}
set_custom_audio_func(_audio_func_pointer) {
  level.meatshield_custom_audio = _audio_func_pointer;
}
meatshield_ai_targets_vox() {
  self endon("meatshield_active");
  while(self.ai._meatshield_targets.size > 1) {
    random(self.ai._meatshield_targets) thread play_fake_battlechatter();
    wait(.5);
  }
  last_guy = self.ai._meatshield_targets[0];
  self.player waittill("_bulletcam:start");
  level notify("bulletcam_start");
}
play_fake_battlechatter() {
  self endon("death");
  if(!isDefined(level.meatshield_ai_speaking)) {
    level.meatshield_ai_speaking = false;
  }
  fake_conversation = [];
  fake_conversation[0] = "_act_fragout";
  fake_conversation[1] = "_rspns_killfirm";
  fake_conversation[2] = "_rspns_lm";
  fake_conversation[3] = "_rspns_fragout";
  prefix = "dds_vc";
  ai = RandomIntRange(0, 2);
  category = fake_conversation[RandomIntRange(0, 3)];
  suffix = "_0" + RandomIntRange(0, 4);
  alias = prefix + ai + category + suffix;
  if(level.meatshield_ai_speaking == false) {
    level.meatshield_ai_speaking = true;
    self playSound(alias, "sounddone");
    self waittill("sounddone");
    wait(RandomFloatRange(1, 3));
    level.meatshield_ai_speaking = false;
  }
}
meatshield_audio_init(_meatshield) {
  SetTimeScale(.8);
  _meatshield.ai waittill("_meatshield:done");
  clientnotify("meatd");
  SetTimeScale(1);
}