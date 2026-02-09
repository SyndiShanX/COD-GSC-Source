/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_bulletcam.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_debug;
#using_animtree("generic_human");

main() {
  level._effect["_bulletcam_trail"] = LoadFX("maps/creek/fx_bullet_distortion_emitter");
  if(!isDefined(level._effect["_bulletcam_impact"])) {
    level._effect["_bulletcam_impact"] = LoadFX("maps/creek/fx_impact_bullet_time");
  }
  level._effect["_bulletcam_noncam_impact"] = LoadFX("impacts/fx_flesh_hit_body_nonfatal");
  level thread init_player_flags();
}
try_bulletcam(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime) {
  if(is_true(self.in_bulletcam)) {
    return 0;
  } else if(is_true(self.bulletcam_death)) {
    magic_bullet_active = isDefined(self.magic_bullet_shield) && self.magic_bullet_shield;
    should_die = ((iDamage >= self.health) || magic_bullet_active);
    if((should_die || is_true(self.bulletcam_fakedeath)) && isPlayer(eAttacker)) {
      if(sMeansOfDeath == "MOD_RIFLE_BULLET" || sMeansOfDeath == "MOD_PISTOL_BULLET") {
        target_tag = "tag_eye";
        if(isDefined(self._bulletcam_alternatetag)) {
          target_tag = self._bulletcam_alternatetag;
        }
        vPoint = self GetTagOrigin(target_tag);
        if(!isDefined(self.deathAnim)) {
          self.deathAnim = % ai_death_upontoback;
        }
        if(magic_bullet_active) {
          self stop_magic_bullet_shield();
          iDamage = self.health + 100;
        }
        self do_bulletcam(eAttacker, vPoint);
        if(is_mature() && isDefined(self.bulletcam_impactptfx) && self.bulletcam_impactptfx) {
          fx_player = spawn("script_model", vPoint);
          fx_player setModel("tag_origin");
          fx_player.angles = VectorToAngles(vector_scale(vDir, -1));
          fx_player LinkTo(self, target_tag);
          playFXOnTag(level._effect["_bulletcam_impact"], fx_player, "tag_origin");
          fx_player thread delete_me_in_a_bit();
        } else if(is_mature()) {
          playFXOnTag(level._effect["_bulletcam_impact"], self, target_tag);
        }
      } else {
        eAttacker notify("_bulletcam:end");
      }
    } else {
      if(is_mature()) {
        playFX(level._effect["_bulletcam_noncam_impact"], vPoint, vector_scale(vDir, -1), (0, 0, 1));
      }
    }
    if(isDefined(self.bulletcam_nodeath)) {
      iDamage = self.health - 1;
    }
  } else if(is_true(self.bulletcam_fakedeath)) {}
  return iDamage;
}
#using_animtree("animated_props");
do_bulletcam(player, end_point) {
  BULLET_MODEL = "p_glo_bullet_tip";
  if(isDefined(level.BULLET_ANIM_CAM)) {
    BULLET_ANIM_CAM = level.BULLET_ANIM_CAM;
  } else {
    BULLET_ANIM_CAM = % prop_meatshield_bullet_tip_cam;
  }
  BULLET_ANIM_SPIN = % prop_meatshield_bullet_tip_spin;
  BULLET_DIST_FROM_CAMERA = 15;
  HOLD_DIST = 10;
  if(isDefined(self.bulletcam_finaldist)) {
    HOLD_DIST = self.bulletcam_finaldist;
  }
  if(getDvar(#"r_stereo3DOn") == "1") {
    BULLET_DIST_FROM_CAMERA = BULLET_DIST_FROM_CAMERA * 2;
    HOLD_DIST = HOLD_DIST * 2;
  }
  self.in_bulletcam = true;
  self notify("_bulletcam:start");
  self.bulletcam_death = undefined;
  player_ang = player GetPlayerAngles();
  pos = player get_eye();
  forward = anglesToForward(player_ang);
  start = pos + forward * BULLET_DIST_FROM_CAMERA;
  bullet = spawn("script_model", start);
  vec_to_end = end_point - start;
  ang_to_end = VectorToAngles(vec_to_end);
  bullet.angles = ang_to_end;
  bullet setModel(BULLET_MODEL);
  bullet UseAnimTree(#animtree);
  bullet SetAnim(BULLET_ANIM_SPIN, 1, 0, 3);
  fake_bullet = spawn("script_model", start);
  vec_to_player_end = VectorNormalize(vec_to_end) * (Length(vec_to_end) - HOLD_DIST);
  player_end_point = pos + vec_to_player_end;
  fake_bullet.angles = ang_to_end;
  fake_bullet setModel(BULLET_MODEL);
  fake_bullet UseAnimTree(#animtree);
  fake_bullet SetAnim(BULLET_ANIM_CAM, 1, 0, 3);
  fake_bullet Hide();
  playFXOnTag(level._effect["_bulletcam_trail"], bullet, "tag_origin");
  player thread move_player(bullet, fake_bullet, player_end_point, player_ang, self);
  self move_bullet(bullet, end_point, player);
  if(isDefined(self) && IsAlive(self)) {
    self.in_bulletcam = undefined;
    self disable_long_death();
  }
}
move_bullet(bullet, end_point, player) {
  MOVE_TIME = .4;
  MOVE_ACCEL = .3;
  MOVE_DECEL = 0;
  bullet MoveTo(end_point, MOVE_TIME, MOVE_ACCEL, MOVE_DECEL);
  bullet waittill("movedone");
  bullet Delete();
  player notify("_bulletcam:impact");
  clientNotify("blt_imp");
}
move_player(bullet, fake_bullet, end_point, player_ang, victim) {
  MOVE_TIME = .16;
  MOVE_ACCEL = 0;
  MOVE_DECEL = 0;
  BLUR_TIME = 0.8;
  HOLD_TIME = .25;
  player_org = self.origin;
  self set_near_plane(1);
  self StartCameraTween(.1);
  fake_bullet LinkTo(bullet);
  self PlayerLinkToAbsolute(fake_bullet);
  self HideViewModel();
  self DisableWeapons();
  self FreezeControls(true);
  self notify("_bulletcam:start");
  self StartFadingBlur(6, MOVE_TIME * BLUR_TIME);
  clientNotify("blt_st");
  level thread timescale_tween(.06, 1, MOVE_TIME, .1, .1);
  wait .3;
  fake_bullet Unlink();
  fake_bullet MoveTo(end_point, MOVE_TIME, MOVE_ACCEL, MOVE_DECEL);
  self thread adjust_view(fake_bullet, victim);
  if(isDefined(self.bulletcam_timeontargdeath)) {
    HOLD_TIME = self.bulletcam_timeontargetdeath;
  }
  self ent_flag_set("_bulletcam:watching_death");
  level timescale_death(HOLD_TIME);
  self reset_near_plane();
  self Unlink();
  fake_bullet Delete();
  self ent_flag_set("_bulletcam:end");
  self StartCameraTween(.5);
  self SetOrigin(player_org);
  self SetPlayerAngles(player_ang);
  wait .5;
  self ShowViewModel();
  self EnableWeapons();
  self FreezeControls(false);
}
adjust_view(bullet, victim) {
  bullet waittill("movedone");
  self Unlink();
  wait .05;
  self thread look_at(victim GetTagOrigin("tag_eye"), .2);
}
timescale_death(time) {
  wait .1;
  level thread timescale_tween(1, .06, .1);
  wait time;
  level timescale_tween(1, 1, 0);
}
enable(enable) {
  if(enable) {
    self.bulletcam_death = true;
    self BloodImpact("none");
  } else {
    self.bulletcam_death = false;
    self BloodImpact("normal");
  }
}
set_alternate_tag(tag_name) {
  self._bulletcam_alternatetag = tag_name;
}
set_death_anim(_death_anim) {
  self.deathAnim = _death_anim;
}
enable_fake_death(enable) {
  self.bulletcam_fakedeath = enable;
}
set_end_distance_from_target(_dist) {
  self.bulletcam_finaldist = _dist;
}
set_hold_distance_on_target_death(_time) {
  self.bulletcam_timeontargdeath = _time;
}
play_fx_on_impact_point_not_joint(bool) {
  self.bulletcam_impactptfx = true;
}
delete_me_in_a_bit() {
  wait(10);
  self Delete();
}
init_player_flags() {
  wait_for_first_player();
  player = get_players()[0];
  player ent_flag_init("_bulletcam:watching_death");
  player ent_flag_init("_bulletcam:end");
}