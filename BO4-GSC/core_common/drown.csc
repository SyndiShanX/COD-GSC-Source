/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\drown.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\filter_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\visionset_mgr_shared;

#namespace drown;

autoexec __init__system__() {
  system::register(#"drown", &__init__, undefined, #"visionset_mgr");
}

__init__() {
  clientfield::register("toplayer", "drown_stage", 1, 3, "int", &drown_stage_callback, 0, 0);
  callback::on_localplayer_spawned(&player_spawned);
  visionset_mgr::register_overlay_info_style_speed_blur("drown_blur", 1, 1, 0.04, 1, 1, 0, 0, 125, 125, 0);
  setup_radius_values();
}

setup_radius_values() {
  level.drown_radius[#"inner"][#"begin"][1] = 0.8;
  level.drown_radius[#"inner"][#"begin"][2] = 0.6;
  level.drown_radius[#"inner"][#"begin"][3] = 0.6;
  level.drown_radius[#"inner"][#"begin"][4] = 0.5;
  level.drown_radius[#"inner"][#"end"][1] = 0.5;
  level.drown_radius[#"inner"][#"end"][2] = 0.3;
  level.drown_radius[#"inner"][#"end"][3] = 0.3;
  level.drown_radius[#"inner"][#"end"][4] = 0.2;
  level.drown_radius[#"outer"][#"begin"][1] = 1;
  level.drown_radius[#"outer"][#"begin"][2] = 0.8;
  level.drown_radius[#"outer"][#"begin"][3] = 0.8;
  level.drown_radius[#"outer"][#"begin"][4] = 0.7;
  level.drown_radius[#"outer"][#"end"][1] = 0.8;
  level.drown_radius[#"outer"][#"end"][2] = 0.6;
  level.drown_radius[#"outer"][#"end"][3] = 0.6;
  level.drown_radius[#"outer"][#"end"][4] = 0.5;
  level.opacity[#"begin"][1] = 0.4;
  level.opacity[#"begin"][2] = 0.5;
  level.opacity[#"begin"][3] = 0.6;
  level.opacity[#"begin"][4] = 0.6;
  level.opacity[#"end"][1] = 0.5;
  level.opacity[#"end"][2] = 0.6;
  level.opacity[#"end"][3] = 0.7;
  level.opacity[#"end"][4] = 0.7;
}

player_spawned(localclientnum) {
  if(!self function_21c0fa55()) {
    return;
  }

  self player_init_drown_values();
  self thread player_watch_drown_shutdown(localclientnum);
}

player_init_drown_values() {
  if(!isDefined(self.drown_start_time)) {
    self.drown_start_time = 0;
    self.drown_outerradius = 0;
    self.drown_innerradius = 0;
    self.drown_opacity = 0;
  }
}

player_watch_drown_shutdown(localclientnum) {
  self waittill(#"death");
  self disable_drown(localclientnum);
}

function_1a9dc208() {
  playerrole = self getrolefields();
  assert(isDefined(playerrole));

  if(isDefined(playerrole)) {
    return int(playerrole.var_f0886300 * 1000);
  }

  return 2000;
}

enable_drown(localclientnum, stage) {
  filter::init_filter_drowning_damage(localclientnum);
  filter::enable_filter_drowning_damage(localclientnum, 1);
  self.drown_start_time = getservertime(localclientnum) - (stage - 1) * self function_1a9dc208();
  self.drown_outerradius = 0;
  self.drown_innerradius = 0;
  self.drown_opacity = 0;
}

disable_drown(localclientnum) {
  filter::disable_filter_drowning_damage(localclientnum, 1);
}

player_drown_fx(localclientnum, stage) {
  self endon(#"death");
  self endon(#"player_fade_out_drown_fx");
  self notify(#"player_drown_fx");
  self endon(#"player_drown_fx");
  self player_init_drown_values();
  var_f0886300 = self function_1a9dc208();
  lastoutwatertimestage = self.drown_start_time + (stage - 1) * var_f0886300;
  stageduration = var_f0886300;

  if(stage == 1) {
    stageduration = 2000;
  }

  while(true) {
    currenttime = getservertime(localclientnum);
    elapsedtime = currenttime - self.drown_start_time;
    stageratio = math::clamp((currenttime - lastoutwatertimestage) / stageduration, 0, 1);

    if(!isDefined(stage)) {
      stage = 1;
    }

    stage = math::clamp(stage, 1, 4);
    self.drown_outerradius = lerpfloat(level.drown_radius[#"outer"][#"begin"][stage], level.drown_radius[#"outer"][#"end"][stage], stageratio) * 1.41421;
    self.drown_innerradius = lerpfloat(level.drown_radius[#"inner"][#"begin"][stage], level.drown_radius[#"inner"][#"end"][stage], stageratio) * 1.41421;
    self.drown_opacity = lerpfloat(level.opacity[#"begin"][stage], level.opacity[#"end"][stage], stageratio);
    filter::set_filter_drowning_damage_inner_radius(localclientnum, 1, self.drown_innerradius);
    filter::set_filter_drowning_damage_outer_radius(localclientnum, 1, self.drown_outerradius);
    filter::set_filter_drowning_damage_opacity(localclientnum, 1, self.drown_opacity);
    waitframe(1);
  }
}

player_fade_out_drown_fx(localclientnum) {
  self endon(#"death");
  self endon(#"player_drown_fx");
  self notify(#"player_fade_out_drown_fx");
  self endon(#"player_fade_out_drown_fx");
  self player_init_drown_values();
  fadestarttime = getservertime(localclientnum);

  for(currenttime = getservertime(localclientnum); currenttime - fadestarttime < 250; currenttime = getservertime(localclientnum)) {
    ratio = (currenttime - fadestarttime) / 250;
    outerradius = lerpfloat(self.drown_outerradius, 1.41421, ratio);
    innerradius = lerpfloat(self.drown_innerradius, 1.41421, ratio);
    opacity = lerpfloat(self.drown_opacity, 0, ratio);
    filter::set_filter_drowning_damage_outer_radius(localclientnum, 1, outerradius);
    filter::set_filter_drowning_damage_inner_radius(localclientnum, 1, innerradius);
    filter::set_filter_drowning_damage_opacity(localclientnum, 1, opacity);
    waitframe(1);
  }

  self disable_drown(localclientnum);
}

drown_stage_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval > 0) {
    self enable_drown(localclientnum, newval);
    self thread player_drown_fx(localclientnum, newval);
    return;
  }

  if(!bnewent) {
    self thread player_fade_out_drown_fx(localclientnum);
    return;
  }

  self disable_drown(localclientnum);
}